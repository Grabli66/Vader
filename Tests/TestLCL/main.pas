unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  Vader.Graphics.Brushes,
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

  r := (col and $FF0000) shr 16;
  g := (col and $FF00) shr 8;
  b := (col and $FF);
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
  pcol: TVRGBAColor;
  l: TVRectangleShape;
  circle: TVCircleShape;
  path: TVPathShape;
  b: TVRect;
  col: TVColor;
  br: TVSolidBrush;
begin
  fGraphics.Brush := TVSolidBrush.Create(TVColor.Create($FF000000));
  path:= TVPathShape.Create;
  path.MoveTo(10,10);
  path.LineTo(20,10);
  path.LineTo(30,20);
  path.LineTo(10,30);
  path.LineTo(30,0);
  path.LineTo(10,10);
  fGraphics.DrawShape(path);

  circle := TVCircleShape.Create(20,20,10);
  fGraphics.Brush := TVSolidBrush.Create(TVColor.Create($1100AA00));
  fGraphics.DrawShape(circle);
  circle.Free;
  path.Free;

  for x := 0 to fTexture.Width - 1 do
  begin
    for y := 0 to fTexture.Height - 1 do
    begin
      pcol := fTexture.GetPixel(x, y);
      if pcol > 0 then begin
        Canvas.Pixels[x, y] := ToTColor(pcol);
      end;
    end;
  end;
end;

end.

