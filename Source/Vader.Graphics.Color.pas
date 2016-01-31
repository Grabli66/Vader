unit Vader.Graphics.Color;

{$mode objfpc}{$H+}

interface

uses Vader.System;

const COLOR_BLACK = $FF000000;

type
  TVRGBAColor = 0..$FFFFFFFF;

  { TVColor }

  TVColor = class(TVaderObject)
  private
    fColor: TVRGBAColor;
    procedure ParseColor(color: string);
  public
    constructor Create(color: TVRGBAColor);
    constructor Create(color: string);
    constructor Create(r, g, b: byte);
    constructor Create(r, g, b, a: byte);
    property RGBA: TVRGBAColor read fColor write fColor;
    function GetRed: byte;
    function GetGreen: byte;
    function GetBlue: byte;
    function GetAlpha: byte;
    procedure Assign(src: TVaderObject); override;
  end;

implementation

{ TVColor }

constructor TVColor.Create(color: TVRGBAColor);
begin
  inherited Create;
  fColor := color;
end;

constructor TVColor.Create(color: string);
begin
  inherited Create;
  ParseColor(color);
end;

procedure TVColor.ParseColor(color: string);
begin

end;

constructor TVColor.Create(r, g, b: byte);
begin
  inherited Create;
end;

constructor TVColor.Create(r, g, b, a: byte);
begin
  inherited Create;
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

procedure TVColor.Assign(src: TVaderObject);
var color: TVColor;
begin
  if src is TVColor then
  begin
    color:= src as TVColor;
    fColor:= color.RGBA;
  end;
  inherited Assign(src);
end;

end.
