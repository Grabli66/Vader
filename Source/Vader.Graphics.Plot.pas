unit Vader.Graphics.Plot;

{$mode objfpc}{$H+}

interface

uses
  Vader.System,
  Vader.Math,
  Vader.Geometry,
  Vader.Graphics.Color,
  Vader.Graphics.Textures;

type

  TVLinePlotSettings = packed record
    x0, y0: integer;                    // Start position
    x1, y1: integer;                    // End position
    Width: integer;                     // Width of line
    Color: TVRGBAColor;
    IsAntialiased: boolean;            // Draw with antialiasing
  end;

  TVCirclePlotSettings = packed record
    x, y: integer;
    Radius: integer;
    Color: TVRGBAColor;
    IsAntialiased: boolean;            // Draw with antialiasing
  end;

  TVPolyPlotSettings = packed record
    Points: array of TVPoint;
    Color: TVRGBAColor;
    IsAntialiased: boolean;            // Draw with antialiasing
  end;

  TVSurfaceFillSettings = packed record
    Color: TVRGBAColor;
  end;

  { TVPlotter }
  { Class with plot algorithms }

  TVPlotter = class(TVaderObject)
  public
    constructor Create;
    // Draws line on surface
    procedure PlotLine(const texture: IPixelSurface; linePlotSettings: TVLinePlotSettings);
    // Draws circle on surface
    procedure PlotCircle(const texture: IPixelSurface;
      circlePlotSettings: TVCirclePlotSettings);
    // Draws poly on surface
    procedure PlotPoly(const texture: IPixelSurface;
      polyPlotSettings: TVPolyPlotSettings);
    // Fills surface
    procedure SolidFillSurface(const texture: IPixelSurface;
      surfaceFillSettings: TVSurfaceFillSettings);
  end;

implementation

procedure Swap(var x, y: integer);
var
  t: integer;
begin
  t := x;
  x := y;
  y := t;
end;

{ TVPlotter }

constructor TVPlotter.Create;
begin
  inherited Create;
end;

procedure TVPlotter.PlotLine(const texture: IPixelSurface;
  linePlotSettings: TVLinePlotSettings);
var
  dx, dy, i, sx, sy, check, e, nx, ny: integer;
  x0, y0, x1, y1: integer;
begin
  x0 := linePlotSettings.x0;
  y0 := linePlotSettings.y0;
  x1 := linePlotSettings.x1;
  y1 := linePlotSettings.y1;

  dx := abs(x0 - x1);
  dy := abs(y0 - y1);
  sx := Sign(x1 - x0);
  sy := Sign(y1 - y0);
  nx := x0;
  ny := y0;
  check := 0;
  if dy > dx then
  begin
    Swap(dx, dy);
    check := 1;
  end;
  e := 2 * dy - dx;
  for i := 0 to dx do
  begin
    texture.SetPixel(nx, ny, linePlotSettings.Color);
    if e >= 0 then
    begin
      if check = 1 then
        Inc(nx, sx)
      else
        Inc(ny, sy);
      Dec(e, 2 * dx);
    end;
    if check = 1 then
      Inc(ny, sy)
    else
      Inc(nx, sx);
    Inc(e, 2 * dy);
  end;
end;

procedure TVPlotter.PlotCircle(const texture: IPixelSurface;
  circlePlotSettings: TVCirclePlotSettings);
var
  x, y, err, xm, ym, r: integer;
begin
  xm := circlePlotSettings.x;
  ym := circlePlotSettings.y;
  r := circlePlotSettings.Radius;

  x := -r;
  y := 0;
  err := 2 - 2 * r; (* bottom left to top right *)
  repeat
    begin
      texture.SetPixel(xm - x, ym + y, circlePlotSettings.Color);
      (*   I. Quadrant +x +y *)
      texture.SetPixel(xm - y, ym - x, circlePlotSettings.Color);
      (*  II. Quadrant -x +y *)
      texture.SetPixel(xm + x, ym - y, circlePlotSettings.Color);
      (* III. Quadrant -x -y *)
      texture.SetPixel(xm + y, ym + x, circlePlotSettings.Color);
      (*  IV. Quadrant +x -y *)
      r := err;
      if r <= y then
      begin
        Inc(y, 1);
        err := err + y * 2 + 1;
      end;
      if (r > x) or (err > y) then
      begin
        Inc(x, 1);
        err := err + x * 2 + 1;
      end;
    end;
  until not (x < 0);
end;

procedure TVPlotter.PlotPoly(const texture: IPixelSurface;
  polyPlotSettings: TVPolyPlotSettings);
var
  pointCount, steps, i: integer;
  lineSettings: TVLinePlotSettings;
  point1, point2: TVPoint;
begin
  pointCount := Length(polyPlotSettings.Points);
  if pointCount < 2 then
    Exit;
  lineSettings.Color := polyPlotSettings.Color;
  lineSettings.IsAntialiased := polyPlotSettings.IsAntialiased;
  steps := Ceil(pointCount / 2);
  for i := 0 to steps do
  begin
    point1 := polyPlotSettings.Points[i];
    point2 := polyPlotSettings.Points[i + 1];
    lineSettings.x0 := point1.x;
    lineSettings.y0 := point1.y;
    lineSettings.x1 := point2.x;
    lineSettings.y1 := point2.y;
    PlotLine(texture, lineSettings);
  end;
end;

procedure TVPlotter.SolidFillSurface(const texture: IPixelSurface;
  surfaceFillSettings: TVSurfaceFillSettings);
var
  start, work: Boolean;
  y, x, sx, sy: Integer;
  pixel: TVRGBAColor;
  lineSettings: TVLinePlotSettings;
begin
  start := False;
  work := False;
  lineSettings.Color:= surfaceFillSettings.Color;
  for y := 0 to texture.GetHeight - 1 do
  begin
    for x := 0 to texture.GetWidth - 1 do
    begin
      pixel := texture.GetPixel(x, y);
      if ((pixel and $FF000000) > 0) and not work then
      begin
        start := True;
        sx := x;
        sy := y;
        texture.SetPixel(sx, sy, surfaceFillSettings.Color);
        Continue;
      end;

      if start and ((pixel and $FF000000) = 0) then
      begin
        work := True;
      end
      else if work then
      begin
        start := False;
        work := False;
        lineSettings.x0:= sx;
        lineSettings.y0:= sy;
        lineSettings.x1:= x;
        lineSettings.y1:= y;
        PlotLine(texture, lineSettings);
      end;
    end;
  end;
end;

end.
