unit Vader.Graphics.Textures;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
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
    destructor Destroy; override;
    procedure SetPixel(x, y: integer; color: TVRGBAColor);
    function GetPixel(x, y: integer): TVRGBAColor;
    property Width: integer read fWidth;
    property Height: integer read fHeight;
  end;

implementation

{ TVTexture }

constructor TVTexture.Create(Width, Height: integer);
begin
  fWidth := Width;
  fHeight := Height;
  SetLength(fPixels, Width * Height);
end;

destructor TVTexture.Destroy;
begin
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

end.
