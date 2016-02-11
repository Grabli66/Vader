unit Vader.Platform.Windows.Application;

{$I ../Vader.inc}

interface

uses Windows,
     Vader.System,
     Vader.Platform.Application;

type

 { TVPlatformApplicationImpl }

 TVPlatformApplicationImpl = class(TVPlatformApplication)
  private
  public
    constructor Create;
    procedure OnWindowClose(sender: TVaderObject); override;
end;

implementation

{ TVPlatformApplicationImpl }

constructor TVPlatformApplicationImpl.Create;
begin
  inherited Create;
end;

procedure TVPlatformApplicationImpl.OnWindowClose(sender: TVaderObject);
begin
  PostQuitMessage(0);
end;

end.

