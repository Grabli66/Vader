unit Vader.Graphics.Graphics;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Math,
  Vader.Graphics.Color,
  Vader.Graphics.Textures,
  Vader.Graphics.Shapes,
  Vader.Graphics.Brushes,
  Vader.Graphics.Pens,
  Vader.Graphics.Font;

type

  { TVGraphics }

  TVGraphics = class
  private
    fTexture: TVTexture;
    fPen: TVBasicPen;
    fBrush: TVBrush;
    fFont: TVFont;
    procedure ContourShape(shape: TVShape; texture: TVTexture;
      bounds: TVRect; color: TVRGBAColor);
    procedure DrawSegment(segment: TVSegment; texture: TVTexture; bounds: TVRect);
    procedure DrawLineSegment(segment: TVSegmentLine2D; texture: TVTexture;
      bounds: TVRect; color: TVRGBAColor);
    procedure DrawCircleSegment(segment: TVSegmentCircle; texture: TVTexture;
      bounds: TVRect; color: TVRGBAColor);
    procedure DrawLineInternal(x0, y0, x1, y1: integer; texture: TVTexture;
      color: TVRGBAColor);
    procedure DrawCircleInternal(x, y, R: integer; texture: TVTexture;
      color: TVRGBAColor);
    procedure FillShape(shape: TVShape; texture: TVTexture; bounds: TVRect);
  public
    constructor Create(texture: TVTexture);
    destructor Destroy; override;
    property Pen: TVBasicPen read fPen write fPen;
    property Brush: TVBrush read fBrush write fBrush;
    property Font: TVFont read fFont write fFont;
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
  fPen := TVBasicPen.Create($FFFF0000);
  fTexture := texture;
end;

destructor TVGraphics.Destroy;
begin
  if Assigned(fBrush) then
    fBrush.Free;
  if Assigned(fPen) then
    fPen.Free;
  if Assigned(fFont) then
    fFont.Free;
  inherited Destroy;
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
    DrawLineSegment(TVSegmentLine2D(segment), texture, bounds, fPen.Color.GetRGBA);
  end else if segment is TVSegmentCircle then begin
    DrawCircleSegment(TVSegmentCircle(segment), texture, bounds, fPen.Color.GetRGBA);
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
var x0, y0: integer;
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
    color := (TVSolidBrush(fBrush)).Color.GetRGBA;

  ContourShape(shape, texture, bounds, color);

  start := False;
  work := False;
  for y := 0 to texture.Height - 1 do
  begin
    for x := 0 to texture.Width - 1 do
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
