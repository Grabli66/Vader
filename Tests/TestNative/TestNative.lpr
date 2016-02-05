program TestNative;

uses
  SysUtils,
  Vader.Application,
  Vader.Controls.Window;

type

  { TMyWindow }

  TMyWindow = class(TVWindow)
  public
  end;

var
  app: TVApplication;
  window: TMyWindow;

{ TMyWindow }

begin
  if FileExists('heap.trc') then
    DeleteFile('heap.trc');
  SetHeapTraceOutput('heap.trc');

  app := TVApplication.Create;
  window := TMyWindow.Create;
  app.SetWindow(window);
  app.Run;
end.
