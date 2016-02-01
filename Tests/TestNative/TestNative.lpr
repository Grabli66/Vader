program TestNative;

uses sysutils,
  Vader.Application,
  Vader.Controls.Window;

var app: TVApplication;
    window: TVWindow;

begin
  if FileExists('heap.trc') then
    DeleteFile('heap.trc');
  SetHeapTraceOutput('heap.trc');

  app:= TVApplication.Create;
  window:= TVWindow.Create;
  app.SetWindow(window);
  app.Run;
end.

