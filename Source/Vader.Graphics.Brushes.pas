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
  end;

implementation

{ TVSolidBrush }

constructor TVSolidBrush.Create(color: TVColor);
begin
  fColor := color;
end;

end.
