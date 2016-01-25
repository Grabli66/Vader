unit Vader.Graphics.Brushes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Vader.Graphics.Color;

type
  TVBrush = class
  end;

  { TVSolidBrush }

  TVSolidBrush = class(TVBrush)
  private
    fColor: TVColor;
  public
    constructor Create(color: TVColor);
    destructor Destroy; override;
    property Color: TVColor read fColor;
  end;

implementation

{ TVSolidBrush }

constructor TVSolidBrush.Create(color: TVColor);
begin
  fColor := color;
end;

destructor TVSolidBrush.Destroy;
begin
  inherited Destroy;
end;

end.
