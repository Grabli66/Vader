unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  Vader.System,
  Vader.Window,
  Vader.Geom,
  Vader.Graphics.Textures,
  Vader.Graphics.Graphics;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    fTexture: IPixelSurface;
//    fGraphics: TVGraphics;
//    function ToTColor(col: TVRGBAColor): TColor;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{function TForm1.ToTColor(col: TVRGBAColor): TColor;
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
end;}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
//  fTexture := TVTexture.Create(200, 200);
//  fGraphics := TVGraphics.Create(fTexture);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(fTexture);
//  FreeAndNil(fGraphics);
end;

procedure TForm1.FormPaint(Sender: TObject);
{var
  x, y: integer;
  pcol: TVRGBAColor;
  l: TVRectangleShape;
  circle: TVCircleShape;
  path: TVPathShape;
  b: TVRect;
  col: TVColor;
  br: TVSolidBrush;
  plot: TVPlotter;
  lps: TVLinePlotSettings;
  cps: TVCirclePlotSettings;
  pps: TVPolyPlotSettings;
  sfs: TVSurfaceFillSettings;}
begin
{  br:= TVSolidBrush.Create($FF000000);

  path:= TVPathShape.Create;
  path.MoveTo(10,10);
  path.LineTo(20,10);
  path.LineTo(30,20);
  path.LineTo(10,30);
  path.LineTo(30,0);
  path.LineTo(10,10);
  fGraphics.DrawShape(path);

  circle := TVCircleShape.Create(20,20,10);
  FreeAndNil(br);
  br:= TVSolidBrush.Create($1100AA00);

  fGraphics.Brush := br;
  fGraphics.DrawShape(circle);
  FreeAndNil(circle);
  FreeAndNil(path);
  FreeAndNil(br);}
     {
  lps.Color:=$FF000000;
  lps.x0:=10;
  lps.y0:=10;
  lps.x1:=100;
  lps.y1:=100;

  cps.Color:= $FF000000;
  cps.x:=40;
  cps.y:=20;
  cps.Radius:=20;

  sfs.Color:=$FF000000;

//  fTexture.FillColor($);

  pps.Color:=$FF000000;
  SetLength(pps.Points, 5);
  pps.Points[0].x:= 10;
  pps.Points[0].y:= 10;
  pps.Points[1].x:= 30;
  pps.Points[1].y:= 10;
  pps.Points[2].x:= 30;
  pps.Points[2].y:= 30;
  pps.Points[3].x:= 10;
  pps.Points[3].y:= 30;
  pps.Points[4].x:= 10;
  pps.Points[4].y:= 10;

  plot:= TVPlotter.Create;
  //plot.PlotLine(fTexture, lps);
  plot.PlotCircle(fTexture, cps);
  plot.SolidFillSurface(fTexture, sfs);
  plot.PlotPoly(fTexture, pps);
  FreeAndNil(plot);

  for x := 0 to fTexture.GetWidth - 1 do
  begin
    for y := 0 to fTexture.GetHeight - 1 do
    begin
      pcol := fTexture.GetPixel(x, y);
      if pcol > 0 then begin
        Canvas.Pixels[x, y] := ToTColor(pcol);
      end;
    end;
  end; }
end;

end.

