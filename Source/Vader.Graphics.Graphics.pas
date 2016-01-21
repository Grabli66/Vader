unit Vader.Graphics.Graphics;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
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
    fPen: TVPen;
    fBrush: TVBrush;
    fFont: TVFont;
  public
    constructor Create(texture: TVTexture);
    destructor Destroy; override;
    procedure SetBrush(brush: TVBrush);
    procedure SetPen(pen: TVPen);
    procedure SetFont(font: TVFont);
    procedure DrawShape(shape: TVShape);
    procedure DrawString(x, y: integer; Text: WideString);
    procedure DrawImage(x, y: integer; image: TVTexture);
  end;

implementation

{ TVGraphics }

constructor TVGraphics.Create(texture: TVTexture);
begin
  fTexture := texture;
end;

destructor TVGraphics.Destroy;
begin
  inherited Destroy;
end;

procedure TVGraphics.SetBrush(brush: TVBrush);
begin
  fBrush := brush;
end;

procedure TVGraphics.SetPen(pen: TVPen);
begin
  fPen := pen;
end;

procedure TVGraphics.SetFont(font: TVFont);
begin
  fFont := font;
end;

procedure TVGraphics.DrawShape(shape: TVShape);
begin

end;

procedure TVGraphics.DrawString(x, y: integer; Text: WideString);
begin

end;

procedure TVGraphics.DrawImage(x, y: integer; image: TVTexture);
begin

end;

end.
