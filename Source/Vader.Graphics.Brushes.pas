unit Vader.Graphics.Brushes;

{$I Vader.inc}

interface

uses
  Vader.System,
  Vader.Graphics.Color;

type
  TVBrush = class(TVaderObject)
  public
  end;

  { TVSolidBrush }

  TVSolidBrush = class(TVBrush)
  private
    fColor: TVColor;
  public
    constructor Create; overload;
    constructor Create(color: TVColor); overload;
    constructor Create(color: TVRGBAColor); overload;
    destructor Destroy; override;
    property Color: TVColor read fColor;
    procedure Assign(src: TVaderObject); override;
  end;

implementation

{ TVSolidBrush }

constructor TVSolidBrush.Create;
begin
  inherited Create;
  fColor := TVColor.Create(COLOR_BLACK);
end;

constructor TVSolidBrush.Create(color: TVColor);
begin
  Create;
  fColor.RGBA := color.RGBA;
end;

constructor TVSolidBrush.Create(color: TVRGBAColor);
begin
  Create;
  fColor.RGBA := color;
end;

destructor TVSolidBrush.Destroy;
begin
  if Assigned(fColor) then
    fColor.Free;
  inherited Destroy;
end;

procedure TVSolidBrush.Assign(src: TVaderObject);
begin
  if src is TVSolidBrush then
  begin
    fColor.Assign((src as TVSolidBrush).Color);
  end;
  inherited Assign(src);
end;

end.
