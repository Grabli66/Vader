unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  Vader.Graphics.Graphics,
  Vader.Graphics.Shapes,
  Vader.Graphics.Textures,
  Vader.Graphics.Color;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    fTexture: TVTexture;
    fGraphics: TVGraphics;
    function ToTColor(col: TVRGBAColor): TColor;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function TForm1.ToTColor(col: TVRGBAColor): TColor;
var
  r, g, b, alpha: byte;
begin
  alpha := (col and $FF000000) shr 24;
  if alpha = 0 then
  begin
    Result := 0;
    Exit;
  end;

  r := ((col and $FF0000) shr 16) * alpha div 255 + round($FF * (1.0 - (alpha / 255)));
  g := ((col and $FF00) shr 8) * alpha div 255 + round($FF * (1.0 - (alpha / 255)));
  b := (col and $FF) * alpha div 255 + round($FF * (1.0 - (alpha / 255)));
  Result := (b shl 16) + (g shl 8) + r;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  fTexture := TVTexture.Create(200, 200);
  fGraphics := TVGraphics.Create(fTexture);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fTexture.Free;
  fGraphics.Free;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  x, y: integer;
  c: TColor;
  l: TVRectangleShape;
  b: TVRect;
begin
  l := TVRectangleShape.Create(10,10,100,20);
  fGraphics.DrawShape(l);
  l.Free;

  for x := 0 to fTexture.Width - 1 do
  begin
    for y := 0 to fTexture.Height - 1 do
    begin
      c := ToTColor(fTexture.GetPixel(x, y));
      if c > 0 then
        Canvas.Pixels[x, y] := ToTColor(fTexture.GetPixel(x, y));
    end;
  end;
end;

end.

