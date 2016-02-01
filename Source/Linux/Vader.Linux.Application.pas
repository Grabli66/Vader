unit Vader.Linux.Application;

{$mode objfpc}{$H+}

interface

uses Vader.System,
     Vader.Controls.Window;

type

{ TVPlatformApplication }

 TVPlatformApplication = class(TVaderObject)
  public
    constructor Create;
    procedure SetWindow(window: TVWindow);
    procedure Run;
end;

implementation

{ TVPlatformApplication }

constructor TVPlatformApplication.Create;
begin
  inherited Create;
end;

procedure TVPlatformApplication.SetWindow(window: TVWindow);
begin

end;

procedure TVPlatformApplication.Run;
begin

end;

end.

