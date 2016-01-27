unit Vader.Graphics.Pens;

{$mode objfpc}{$H+}

interface

uses
  Vader.System,
  Vader.Graphics.Color;

const
  DEFAULT_PEN_WIDTH = 1;

type
  TVPen = class(TVaderObject)
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
    constructor Create(color: TVRGBAColor); overload;
    destructor Destroy; override;
    property Width: integer read fWidth write fWidth;
    property Color: TVColor read fColor write fColor;
  end;

implementation

{ TVBasicPen }

constructor TVBasicPen.Create(color: TVColor);
begin
  inherited Create;
  fColor := TVColor.Create(color.RGBA);
  fWidth := DEFAULT_PEN_WIDTH;
end;

constructor TVBasicPen.Create(color: TVRGBAColor);
begin
  inherited Create;
  fColor := TVColor.Create(color);
  fWidth := DEFAULT_PEN_WIDTH;
end;

destructor TVBasicPen.Destroy;
begin
  if Assigned(fColor) then fColor.Free;
  inherited Destroy;
end;

end.
