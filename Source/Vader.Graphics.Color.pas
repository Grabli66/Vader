unit Vader.Graphics.Color;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TVRGBAColor = 0..$FFFFFFFF;

  { TVColor }

  TVColor = class
  private
    fColor: TVRGBAColor;
    procedure ParseColor(color: string);
  public
    constructor Create(color: TVRGBAColor);
    constructor Create(color: string);
    constructor Create(r, g, b: byte);
    constructor Create(r, g, b, a: byte);
    function GetRed: byte;
    function GetGreen: byte;
    function GetBlue: byte;
    function GetAlpha: byte;
    function GetRGBA: TVRGBAColor;
  end;

implementation

{ TVColor }

constructor TVColor.Create(color: TVRGBAColor);
begin
  fColor := color;
end;

constructor TVColor.Create(color: string);
begin
  ParseColor(color);
end;

procedure TVColor.ParseColor(color: string);
begin

end;

constructor TVColor.Create(r, g, b: byte);
begin

end;

constructor TVColor.Create(r, g, b, a: byte);
begin

end;

function TVColor.GetRed: byte;
begin

end;

function TVColor.GetGreen: byte;
begin

end;

function TVColor.GetBlue: byte;
begin

end;

function TVColor.GetAlpha: byte;
begin

end;

function TVColor.GetRGBA: TVRGBAColor;
begin
  Result := fColor;
end;

end.
