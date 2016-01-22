unit Vader.Graphics.Graphics;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Math,
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
    procedure DrawSegment(segment: TVSegment; texture: TVTexture);
    procedure DrawLineSegment(segment: TVSegmentLine2D; texture: TVTexture);
    procedure FillShape(shape: TVShape; texture: TVTexture);
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
  inherited Destroy;
end;

procedure TVGraphics.DrawLineSegment(segment: TVSegmentLine2D; texture: TVTexture);
var
  dx, dy, i, sx, sy, check, e, nx, ny: integer;
begin
  dx := abs(segment.StartPos.x - segment.EndPos.x);
  dy := abs(segment.StartPos.y - segment.EndPos.y);
  sx := Sign(segment.EndPos.x - segment.StartPos.x);
  sy := Sign(segment.EndPos.y - segment.StartPos.y);
  nx := segment.StartPos.x;
  ny := segment.StartPos.y;
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

procedure TVGraphics.DrawSegment(segment: TVSegment; texture: TVTexture);
begin
  if segment is TVSegmentLine2D then begin
    DrawLineSegment(TVSegmentLine2D(segment), texture);
  end;
end;

procedure TVGraphics.FillShape(shape: TVShape; texture: TVTexture);
begin

end;

procedure TVGraphics.DrawShape(shape: TVShape);
var
  ln, i: integer;
  segment: TVSegment;
  tempTex: TVTexture;
begin
  ln := Length(shape.Segments);

  tempTex:= TVTexture.Create(shape.GetBounds);

  // Fill shape
  if Assigned(fBrush) then
  begin
    FillShape(shape, tempTex);
  end;

  for i := 0 to ln - 1 do
  begin
    segment := shape.Segments[i];
    DrawSegment(segment, tempTex);
  end;

  tempTex.CopyTo(0,0,fTexture);
  tempTex.Free;
end;

procedure TVGraphics.DrawString(x, y: integer; Text: WideString);
begin

end;

procedure TVGraphics.DrawImage(x, y: integer; image: TVTexture);
begin

end;

end.
