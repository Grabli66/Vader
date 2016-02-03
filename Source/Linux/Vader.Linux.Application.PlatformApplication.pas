unit Vader.Linux.Application.PlatformApplication;

{$mode objfpc}{$H+}

interface

uses xlib,
     Vader.System,
     Vader.Application.PlatformApplication,
     Vader.Controls.Window;

type

{ TVPlatformApplicationImpl }

 TVPlatformApplicationImpl = class(TVPlatformApplication)
  private
  public
    constructor Create;
    procedure Run;
end;

implementation

{ TVPlatformApplicationImpl }

constructor TVPlatformApplicationImpl.Create;
begin
  inherited Create;
end;

procedure TVPlatformApplicationImpl.Run;
begin
  if fCurrentWindow = nil then Exit;
  fCurrentWindow.ProcessMessages;
  fCurrentWindow.Free;
end;

end.

