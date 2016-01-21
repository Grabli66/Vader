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
    property Pen: TVPen read fPen write fPen;
    property Brush: TVBrush read fBrush write fBrush;
    property Font: TVFont read fFont write fFont;
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
