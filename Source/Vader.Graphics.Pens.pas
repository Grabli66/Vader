unit Vader.Graphics.Pens;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Vader.Graphics.Color;

const
  DEFAULT_PEN_WIDTH = 1;

type
  TVPen = class
  end;

  { TVBasicPen }

  TVBasicPen = class(TVPen)
    fColor: TVColor;
    fWidth: integer;
  public
    constructor Create(color: TVColor);
    property Width: integer read fWidth write fWidth;
  end;

implementation

{ TVBasicPen }

constructor TVBasicPen.Create(color: TVColor);
begin
  fColor := color;
  fWidth := DEFAULT_PEN_WIDTH;
end;

end.
