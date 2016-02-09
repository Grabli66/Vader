unit Vader.Graphics.Pens;

{$I Vader.inc}

interface

uses
  Vader.System,
  Vader.Graphics.Color;

const
  DEFAULT_PEN_WIDTH = 1;

type

  { TVPen }

  TVPen = class(TVaderObject)
  private
    fColor: TVColor;
    fWidth: integer;
    fIsAntialiasing: Boolean;
    procedure SetColor(value: TVColor);
  public
    constructor Create(color: TVColor); overload;
    constructor Create(color: TVRGBAColor); overload;
    destructor Destroy; override;
    property Width: integer read fWidth write fWidth;
    property Color: TVColor read fColor write fColor;
    property IsAntialiasing: Boolean read fIsAntialiasing write fIsAntialiasing;
    procedure Assign(src: TVaderObject); override;
  end;

implementation

{ TVPen }

procedure TVPen.SetColor(value: TVColor);
begin
  fColor.Assign(value);
end;

constructor TVPen.Create(color: TVColor);
begin
  inherited Create;
  fColor := TVColor.Create(color.RGBA);
  fWidth := DEFAULT_PEN_WIDTH;
end;

constructor TVPen.Create(color: TVRGBAColor);
begin
  inherited Create;
  fColor := TVColor.Create(color);
  fWidth := DEFAULT_PEN_WIDTH;
end;

destructor TVPen.Destroy;
begin
  if Assigned(fColor) then fColor.Free;
  inherited Destroy;
end;

procedure TVPen.Assign(src: TVaderObject);
var pen: TVPen;
begin
  if src is TVPen then
  begin
    pen:= src as TVPen;
    fColor.Assign(pen);
    fWidth:= pen.Width;
    fIsAntialiasing:=pen.IsAntialiasing;
  end;
  inherited Assign(src);
end;

end.
