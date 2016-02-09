unit Vader.Controls.Button;

{$I Vader.inc}

interface

uses
  Vader.Controls.Control;

type

{ TVButton }

 TVButton = class(TVControl)
  public
    constructor Create;
end;

implementation

{ TVButton }

constructor TVButton.Create;
begin
  inherited Create;
end;

end.

