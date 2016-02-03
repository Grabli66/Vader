unit Vader.Windows.Application;

{$mode objfpc}{$H+}

interface

uses Windows,
     Vader.System,
     Vader.Controls.Window;

type

{ TVPlatformApplication }

 TVPlatformApplication = class(TVaderObject)
  private
    fCurrentWindow: TVWindow;
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
  fCurrentWindow:= window;
end;

procedure TVPlatformApplication.Run;
var AMessage: Msg;
begin
  if fCurrentWindow = nil then Exit;
  while GetMessage(@AMessage, 0, 0, 0) do begin
    TranslateMessage(AMessage);
    DispatchMessage(AMessage);
  end;
  Halt(AMessage.wParam);
end;

end.

