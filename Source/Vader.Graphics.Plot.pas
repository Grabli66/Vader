unit Vader.Graphics.Plot;

{$mode objfpc}{$H+}

interface

uses
  Vader.System,
  Vader.Math,
  Vader.Graphics.Color,
  Vader.Graphics.Textures;

type

  TVLinePlotSettings = packed record
    x0, y0: integer;                    // Start position
    x1, y1: integer;                    // End position
    IsAntialiased: boolean;            // Draw with antialiasing
    Width: integer;                     // Width of line
    Color: TVRGBAColor;
  end;

  TVCubicCurvePlotSettings = packed record

  end;

  TVQuadricCurveSettings = packed record

  end;

  TVCirclePlotSettings = packed record
    x, y: integer;
    Radius: integer;
    Color: TVRGBAColor;
  end;

  TVEllipsePlotSettings = packed record

  end;

  TVRectanglePlotSettings = packed record

  end;

  { TVPlotter }
  { Class with plot algorithms }

  TVPlotter = class(TVaderObject)
  public
    constructor Create;
    // Draws line on surface
    procedure PlotLine(texture: IPixelSurface; linePlotSettings: TVLinePlotSettings);
    // Draws circle on surface
    procedure PlotCircle(texture: IPixelSurface;
      circlePlotSettings: TVCirclePlotSettings);
    // Draws rectangle on surface
    procedure PlotRectangle(texture: IPixelSurface;
      rectanglePlotSettings: TVRectanglePlotSettings);
    // Fills surface
//    procedure FillRectangle(texture: IPixelSurface; );

    procedure PlotCubicCurve(texture: IPixelSurface;
      cubicCurvePlotSettings: TVCubicCurvePlotSettings);
    procedure PlotQuadricCurve(texture: IPixelSurface;
      quadricCurvePlotSettings: TVQuadricCurveSettings);
    procedure PlotEllipse(texture: IPixelSurface;
      ellipsePlotSettings: TVEllipsePlotSettings);
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

procedure TVPlotter.PlotLine(texture: IPixelSurface;
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

procedure TVPlotter.PlotCubicCurve(texture: IPixelSurface;
  cubicCurvePlotSettings: TVCubicCurvePlotSettings);
begin

end;

procedure TVPlotter.PlotQuadricCurve(texture: IPixelSurface;
  quadricCurvePlotSettings: TVQuadricCurveSettings);
begin

end;

procedure TVPlotter.PlotCircle(texture: IPixelSurface;
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
      texture.SetPixel(xm - x, ym + y, circlePlotSettings.Color);  (*   I. Quadrant +x +y *)
      texture.SetPixel(xm - y, ym - x, circlePlotSettings.Color);  (*  II. Quadrant -x +y *)
      texture.SetPixel(xm + x, ym - y, circlePlotSettings.Color);  (* III. Quadrant -x -y *)
      texture.SetPixel(xm + y, ym + x, circlePlotSettings.Color);  (*  IV. Quadrant +x -y *)
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

procedure TVPlotter.PlotEllipse(texture: IPixelSurface;
  ellipsePlotSettings: TVEllipsePlotSettings);
begin

end;

procedure TVPlotter.PlotRectangle(texture: IPixelSurface;
  rectanglePlotSettings: TVRectanglePlotSettings);
begin

end;

end.
