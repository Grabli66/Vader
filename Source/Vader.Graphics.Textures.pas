unit Vader.Graphics.Textures;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Vader.Graphics.Shapes,
  Vader.Graphics.Color;

type

  { TVTexture }
  TVTexture = class
  private
    fWidth: integer;
    fHeight: integer;
    fPixels: array of TVRGBAColor;
  public
    constructor Create(Width, Height: integer);
    constructor Create(rect: TVRect); overload;
    destructor Destroy; override;
    property Width: integer read fWidth;
    property Height: integer read fHeight;
    procedure SetPixel(x, y: integer; color: TVRGBAColor);
    function GetPixel(x, y: integer): TVRGBAColor;
    procedure CopyTo(x, y: integer; dest: TVTexture);
  end;

implementation

{ TVTexture }

constructor TVTexture.Create(Width, Height: integer);
begin
  fWidth := Width;
  fHeight := Height;
  SetLength(fPixels, Width * Height);
end;

constructor TVTexture.Create(rect: TVRect); overload;
begin
  Create(rect.Width, rect.Height);
end;

destructor TVTexture.Destroy;
begin
  fPixels:=nil;
  inherited Destroy;
end;

procedure TVTexture.SetPixel(x, y: integer; color: TVRGBAColor);
begin
  if (x > fWidth) or (x < 0) then
    Exit;
  if (y > fHeight) or (y < 0) then
    Exit;
  fPixels[y * fWidth + x] := color;
end;

function TVTexture.GetPixel(x, y: integer): TVRGBAColor;
begin
  Result := fPixels[y * fWidth + x];
end;

procedure TVTexture.CopyTo(x, y: integer; dest: TVTexture);
var
  x1, y1: Integer;
begin
  for x1 := 0 to fWidth-1 do
  begin
    for y1 := 0 to fHeight-1 do
    begin
       dest.SetPixel(x1 + x, y1 + y, GetPixel(x1,y1));
    end;
  end;
end;

end.
