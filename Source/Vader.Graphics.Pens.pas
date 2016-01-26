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
    private
      fIsAntialiasing: Boolean;
    public
      property IsAntialiasing: Boolean read fIsAntialiasing write fIsAntialiasing;
  end;

  { TVBasicPen }

  TVBasicPen = class(TVPen)
  private
    fColor: TVColor;
    fWidth: integer;
  public
    constructor Create(color: TVColor);
    constructor Create(color: TVRGBAColor);
    destructor Destroy; override;
    property Width: integer read fWidth write fWidth;
    property Color: TVColor read fColor write fColor;
  end;

implementation

{ TVBasicPen }

constructor TVBasicPen.Create(color: TVColor);
begin
  fColor := TVColor.Create(color.GetRGBA);
  fWidth := DEFAULT_PEN_WIDTH;
end;

constructor TVBasicPen.Create(color: TVRGBAColor);
begin
  fColor := TVColor.Create(color);
  fWidth := DEFAULT_PEN_WIDTH;
end;

destructor TVBasicPen.Destroy;
begin
  fColor.Free;
  inherited Destroy;
end;

end.
