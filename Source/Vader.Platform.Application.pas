unit Vader.Platform.Application;

{$I Vader.inc}

interface

uses Vader.System,
     Vader.Controls.Window;

type

  { TVPlatformApplication }

  TVPlatformApplication = class(TVaderObject)
  protected
    fCurrentWindow: TVWindow;
    procedure OnWindowClose(sender: TVaderObject); virtual; abstract;
  public
    procedure SetWindow(window: TVWindow);
    procedure Run; virtual;
  end;

implementation

{ TVPlatformApplication }

procedure TVPlatformApplication.SetWindow(window: TVWindow);
begin
  fCurrentWindow := window;
  fCurrentWindow.OnClose:= OnWindowClose;
end;

procedure TVPlatformApplication.Run;
begin
  if fCurrentWindow = nil then Exit;
  fCurrentWindow.Show;
  fCurrentWindow.Free;
end;

end.
