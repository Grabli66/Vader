unit Vader.Graphics.Graphics;

{$I Vader.inc}

interface

uses
  Vader.System,
  Vader.Math,
  Vader.Geometry,
  Vader.Graphics.Textures,
  Vader.Graphics.Color,
  Vader.Graphics.Pens,
  Vader.Graphics.Brushes,
  Vader.Graphics.Font,
  Vader.Graphics.Shapes;

type

  { TVGraphics }

  TVGraphics = class(TVaderObject)
  private
    fTexture: TVTexture;
    fPen: TVPen;
    fBrush: TVBrush;
    fFont: TVFont;
    procedure ContourShape(shape: TVShape; texture: TVTexture;
      bounds: TVRect; color: TVRGBAColor);
    procedure DrawSegment(segment: TVSegment; texture: TVTexture; bounds: TVRect);
    procedure DrawLineSegment(segment: TVSegmentLine2D; texture: TVTexture;
      bounds: TVRect; color: TVRGBAColor);
    procedure DrawCircleSegment(segment: TVSegmentCircle; texture: TVTexture;
      bounds: TVRect; color: TVRGBAColor);
    // Draws aliased line with width 1 pixel
    procedure DrawLineInternal(x0, y0, x1, y1: integer; texture: TVTexture;
      color: TVRGBAColor);
    // Draws anti-aliased line with width
    procedure DrawAALineWithWidthInternal(x0, y0, x1, y1: integer;
      Width: double; texture: TVTexture; color: TVRGBAColor);
    procedure DrawCircleInternal(x, y, R: integer; texture: TVTexture;
      color: TVRGBAColor);
    procedure FillShape(shape: TVShape; texture: TVTexture; bounds: TVRect);

    procedure SetBrush(Value: TVBrush);
  public
    constructor Create(texture: TVTexture);
    destructor Destroy; override;
    property Pen: TVPen read fPen;
    property Brush: TVBrush read fBrush write SetBrush;
    property Font: TVFont read fFont;
    procedure DrawShape(shape: TVShape);
    procedure DrawString(x, y: integer; Text: WideString);
    procedure DrawImage(x, y: integer; image: TVTexture);

  end;

implementation

{ TVGraphics }

procedure Swap(var x, y: integer);
var
  t: integer;
begin
  t := x;
  x := y;
  y := t;
end;

constructor TVGraphics.Create(texture: TVTexture);
begin
  inherited Create;
  fPen := TVPen.Create($FFFF0000);
  fBrush:= TVSolidBrush.Create($FF000000);
  fTexture := texture;
end;

destructor TVGraphics.Destroy;
begin
  if Assigned(fPen) then
    fPen.Free;
  if Assigned(fBrush) then
    fBrush.Free;
  if Assigned(fFont) then
    fFont.Free;
  inherited Destroy;
end;

procedure TVGraphics.SetBrush(Value: TVBrush);
begin
  fBrush.Assign(Value);
end;

procedure TVGraphics.DrawLineInternal(x0, y0, x1, y1: integer;
  texture: TVTexture; color: TVRGBAColor);
var
  dx, dy, i, sx, sy, check, e, nx, ny: integer;
begin
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
    texture.SetPixel(nx, ny, color);
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

// Draws anti-aliased line with width
procedure TVGraphics.DrawAALineWithWidthInternal(x0, y0, x1, y1: integer;
  Width: double; texture: TVTexture; color: TVRGBAColor);
var
  dx, dy, sx, sy, err, e2, x2, y2: integer;
  ed: double;
begin
  {dx:= abs(x1-x0);
  sx:= -1;
  if x0 < x1 then sx:= 1;
  dy:= abs(y1-y0);
  sy:= -1;
  if y0 < y1 then sy:= 1;
  err:= dx-dy;      // error value e_xy
  if (dx+dy) = 0 then ed:= 1 else ed:= sqrt(dx*dx+dy*dy);

  Width:= (Width+1)/2;
  while true do begin         // pixel loop
      //setPixelColor(x0, y0, max(0,255*(abs(err-dx+dy)/ed-wd+1)));
      texture.SetPixel(x0, y0, color);
      e2:= err;
      x2:= x0;
      if (2*e2 >= -dx) then begin       // x step
         for (e2 += dy, y2 = y0; e2 < ed*wd && (y1 != y2 || dx > dy); e2 += dx)
            setPixelColor(x0, y2 += sy, max(0,255*(abs(e2)/ed-wd+1)));
         if (x0 == x1) then break;
         e2 = err; err -= dy; x0 += sx;
      end;
      if (2*e2 <= dy) then begin       // y step
         for (e2 = dx-e2; e2 < ed*wd && (x1 != x2 || dx < dy); e2 += dy)
            setPixelColor(x2 += sx, y0, max(0,255*(abs(e2)/ed-wd+1)));
         if (y0 == y1) break;
         err += dx; y0 += sy;
      end;
   end;    }
end;

procedure TVGraphics.DrawCircleInternal(x, y, R: integer; texture: TVTexture;
  color: TVRGBAColor);
var
  x2, y2, error, delta: integer;
begin
  x2 := 0;
  y2 := R;
  delta := (1 - 2 * R);
  error := 0;
  while y2 >= 0 do
  begin
    texture.SetPixel(x + x2, y + y2, color);
    texture.SetPixel(x + x2, y - y2, color);
    texture.SetPixel(x - x2, y + y2, color);
    texture.SetPixel(x - x2, y - y2, color);
    error := 2 * (delta + y2) - 1;
    if ((delta < 0) and (error <= 0)) then
    begin
      Inc(x2);
      delta := delta + (2 * x2 + 1);
      continue;
    end;
    error := 2 * (delta - x2) - 1;
    if ((delta > 0) and (error > 0)) then
    begin
      Dec(y2);
      delta := delta + (1 - 2 * y2);
      continue;
    end;
    Inc(x2);
    delta := delta + (2 * (x2 - y2));
    Dec(y2);
  end;
end;

procedure TVGraphics.DrawSegment(segment: TVSegment; texture: TVTexture; bounds: TVRect);
begin
  if segment is TVSegmentLine2D then
  begin
    DrawLineSegment(TVSegmentLine2D(segment), texture, bounds, fPen.Color.RGBA);
  end
  else if segment is TVSegmentCircle then
  begin
    DrawCircleSegment(TVSegmentCircle(segment), texture, bounds, fPen.Color.RGBA);
  end;
end;

procedure TVGraphics.DrawLineSegment(segment: TVSegmentLine2D;
  texture: TVTexture; bounds: TVRect; color: TVRGBAColor);
var
  x0, y0, x1, y1: integer;
begin
  x0 := segment.StartPoint.x - bounds.x;
  y0 := segment.StartPoint.y - bounds.y;
  x1 := segment.EndPoint.x - bounds.x;
  y1 := segment.EndPoint.y - bounds.y;
  DrawLineInternal(x0, y0, x1, y1, texture, color);
end;

procedure TVGraphics.DrawCircleSegment(segment: TVSegmentCircle;
  texture: TVTexture; bounds: TVRect; color: TVRGBAColor);
var
  x0, y0: integer;
begin
  x0 := segment.Radius + 1;
  y0 := segment.Radius + 1;
  DrawCircleInternal(x0, y0, segment.Radius, texture, color);
end;

procedure TVGraphics.ContourShape(shape: TVShape; texture: TVTexture;
  bounds: TVRect; color: TVRGBAColor);
var
  i, ln: integer;
  segment: TVSegment;
  circle: TVCircleShape;
begin
  ln := Length(shape.Segments);

  for i := 0 to ln - 1 do
  begin
    segment := shape.Segments[i];
    DrawSegment(segment, texture, bounds);
  end;
end;

procedure TVGraphics.FillShape(shape: TVShape; texture: TVTexture; bounds: TVRect);
var
  x, y, sx, sy: integer;
  start, work: boolean;
  pixel: TVRGBAColor;
  color: TVRGBAColor;
begin
  if fBrush is TVSolidBrush then
    color := (TVSolidBrush(fBrush)).Color.RGBA;

  ContourShape(shape, texture, bounds, color);

  start := False;
  work := False;
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
        texture.SetPixel(sx, sy, color);
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
        DrawLineInternal(sx, sy, x, y, texture, color);
      end;
    end;
  end;
end;

procedure TVGraphics.DrawShape(shape: TVShape);
var
  ln, i: integer;
  segment: TVSegment;
  tempTex: TVTexture;
  bounds: TVRect;
begin
  ln := Length(shape.Segments);

  bounds := shape.GetBounds;
  tempTex := TVTexture.Create(bounds);

  // Fill shape
  if Assigned(fBrush) then
  begin
    FillShape(shape, tempTex, bounds);
  end;

  for i := 0 to ln - 1 do
  begin
    segment := shape.Segments[i];
    DrawSegment(segment, tempTex, bounds);
  end;

  tempTex.Blend(bounds.x, bounds.y, fTexture);
  tempTex.Free;
end;

procedure TVGraphics.DrawString(x, y: integer; Text: WideString);
begin

end;

procedure TVGraphics.DrawImage(x, y: integer; image: TVTexture);
begin

end;

end.
