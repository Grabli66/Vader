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
    procedure ContourShape(shape: TVShape; texture: TVTexture; bounds: TVRect);
    procedure DrawSegment(segment: TVSegment; texture: TVTexture; bounds: TVRect);
    procedure DrawLineSegment(segment: TVSegmentLine2D; texture: TVTexture; bounds: TVRect);
    procedure DrawLineInternal(x0,y0,x1,y1: Integer; texture: TVTexture);
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
  if Assigned(fBrush) then fBrush.Free;
  if Assigned(fPen) then fPen.Free;
  if Assigned(fFont) then fFont.Free;
  inherited Destroy;
end;

procedure TVGraphics.DrawLineInternal(x0,y0,x1,y1: Integer; texture: TVTexture);
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
    texture.SetPixel(nx, ny, fPen.Color.GetRGBA);
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

procedure TVGraphics.DrawSegment(segment: TVSegment; texture: TVTexture; bounds: TVRect);
begin
  if segment is TVSegmentLine2D then begin
    DrawLineSegment(TVSegmentLine2D(segment), texture, bounds);
  end;
end;

procedure TVGraphics.DrawLineSegment(segment: TVSegmentLine2D;
  texture: TVTexture; bounds: TVRect);
var x0,y0,x1,y1: Integer;
begin
  x0:= segment.StartPos.x - bounds.x;
  y0:= segment.StartPos.y - bounds.y;
  x1:= segment.EndPos.x - bounds.x;
  y1:= segment.EndPos.y - bounds.y ;
  DrawLineInternal(x0,y0,x1,y1,texture);
end;

procedure TVGraphics.ContourShape(shape: TVShape; texture: TVTexture; bounds: TVRect);
var i, ln: integer;
    segment: TVSegment;
begin
  ln := Length(shape.Segments);
  for i := 0 to ln - 1 do
  begin
    segment := shape.Segments[i];
    DrawSegment(segment, texture, bounds);
  end;
end;

procedure TVGraphics.FillShape(shape: TVShape; texture: TVTexture; bounds: TVRect);
var x, y, sx, sy: integer;
  start, work: boolean;
  pixel: TVRGBAColor;
begin
  ContourShape(shape, texture, bounds);

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
        DrawLineInternal(sx, sy, x, y, texture);
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

  bounds:= shape.GetBounds;
  tempTex:= TVTexture.Create(bounds);

  // Fill shape
  if Assigned(fBrush) then
  begin
    FillShape(shape, tempTex, bounds);
  end;

 { for i := 0 to ln - 1 do
  begin
    segment := shape.Segments[i];
    DrawSegment(segment, tempTex, bounds);
  end;}

  tempTex.CopyTo(bounds.x,bounds.y,fTexture);
  tempTex.Free;
end;

procedure TVGraphics.DrawString(x, y: integer; Text: WideString);
begin

end;

procedure TVGraphics.DrawImage(x, y: integer; image: TVTexture);
begin

end;

end.
