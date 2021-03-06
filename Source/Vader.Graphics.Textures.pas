unit Vader.Graphics.Textures;

{$I Vader.inc}

interface

uses
  Vader.System,
  Vader.Geometry,
  Vader.Graphics.Color;

type
  TVPixelArray = array of TVRGBAColor;

  // Interface for surfaces with direct access for pixels
  IPixelSurface = interface
    ['{F325E03F-F96C-4B48-950B-A3542AD692DE}']
    procedure FillColor(color: TVRGBAColor);
    procedure SetPixel(x, y: integer; color: TVRGBAColor);
    function GetPixel(x, y: integer): TVRGBAColor;
    function GetPixels : TVPixelArray;
    function GetWidth: Integer;
    function GetHeight: Integer;
  end;

  { TVTexture }
  TVTexture = class(TVaderObject, IPixelSurface)
  private
    fWidth: integer;
    fHeight: integer;
    fPixels: TVPixelArray;
    function AlphaBlend(src, dst: TVRGBAColor): TVRGBAColor;
  public
    constructor Create(Width, Height: integer); overload;
    constructor Create(rect: TVRect); overload;
    destructor Destroy; override;
    property Pixels: TVPixelArray read fPixels;
    function GetPixels: TVPixelArray;
    procedure FillColor(color: TVRGBAColor);
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetPixel(x, y: integer; color: TVRGBAColor);
    function GetPixel(x, y: integer): TVRGBAColor;
    procedure Blend(x, y: integer; dest: TVTexture);
  end;

implementation

{ TVTexture }

function TVTexture.AlphaBlend(src, dst: TVRGBAColor): TVRGBAColor;
var
  r, g, b, alpha: byte;
  srcR, srcG, srcB: byte;
  dstR, dstG, dstB: byte;
begin
  alpha := (src and $FF000000) shr 24;
  if alpha = 0 then
  begin
    Result := 0;
    Exit;
  end;

  srcR := (src and $FF0000) shr 16;
  srcG := (src and $FF00) shr 8;
  srcB := src and $FF;

  dstR := (dst and $FF0000) shr 16;
  dstG := (dst and $FF00) shr 8;
  dstB := dst and $FF;

  r := srcR * alpha div 255 + round(dstR * (1.0 - (alpha / 255)));
  g := srcG * alpha div 255 + round(dstG * (1.0 - (alpha / 255)));
  b := srcB * alpha div 255 + round(dstB * (1.0 - (alpha / 255)));

  Result := src and $FF000000 + (r shl 16) + (g shl 8) + b;
end;

constructor TVTexture.Create(Width, Height: integer);
begin
  inherited Create;
  fWidth := Width;
  fHeight := Height;
  SetLength(fPixels, Width * Height);
end;

constructor TVTexture.Create(rect: TVRect); overload;
begin
  inherited Create;
  Create(rect.Width, rect.Height);
end;

destructor TVTexture.Destroy;
begin
  fPixels := nil;
  inherited Destroy;
end;

function TVTexture.GetPixels: TVPixelArray;
begin
  Result:= fPixels;
end;

procedure TVTexture.FillColor(color: TVRGBAColor);
var
  x, y: Integer;
begin
 for x := 0 to fWidth - 1 do
  begin
    for y := 0 to fHeight - 1 do
    begin
      fPixels[y * fWidth + x] := color;
    end;
  end;
end;

function TVTexture.GetWidth: Integer;
begin
  Result:= fWidth;
end;

function TVTexture.GetHeight: Integer;
begin
  Result:= fHeight;
end;

procedure TVTexture.SetPixel(x, y: integer; color: TVRGBAColor);
begin
  if (x > fWidth - 1) or (x < 0) then
    Exit;
  if (y > fHeight - 1) or (y < 0) then
    Exit;
  fPixels[y * fWidth + x] := color;
end;

function TVTexture.GetPixel(x, y: integer): TVRGBAColor;
begin
  Result := fPixels[y * fWidth + x];
end;

procedure TVTexture.Blend(x, y: integer; dest: TVTexture);
var
  x1, y1: integer;
  pixel, srcPixel, dstPixel: TVRGBAColor;
begin
  for x1 := 0 to fWidth - 1 do
  begin
    for y1 := 0 to fHeight - 1 do
    begin
      srcPixel := GetPixel(x1, y1);
      dstPixel := dest.GetPixel(x1 + x, y1 + y);
      pixel := AlphaBlend(srcPixel, dstPixel);
      if (pixel and $FF000000) > 0 then
        dest.SetPixel(x1 + x, y1 + y, pixel);
    end;
  end;
end;

end.
