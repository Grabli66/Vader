unit Vader.Platform.Linux.Application;

{$I ../Vader.inc}

interface

uses xlib,
     Vader.System,
     Vader.Platform.Application,
     Vader.Controls.Window;

type

{ TVPlatformApplicationImpl }

 TVPlatformApplicationImpl = class(TVPlatformApplication)
  private
  public
    constructor Create;
end;

implementation

{ TVPlatformApplicationImpl }

constructor TVPlatformApplicationImpl.Create;
begin
  inherited Create;
end;

end.

