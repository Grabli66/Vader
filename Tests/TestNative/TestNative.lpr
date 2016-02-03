program TestNative;

uses
  SysUtils,
  Vader.Application.Application,
  Vader.Controls.Window;

type

  { TMyWindow }

  TMyWindow = class(TVWindow)
  public
    procedure OnDraw; override;
  end;

var
  app: TVApplication;
  window: TMyWindow;

{ TMyWindow }

procedure TMyWindow.OnDraw;
begin
end;

begin
  if FileExists('heap.trc') then
    DeleteFile('heap.trc');
  SetHeapTraceOutput('heap.trc');

  app := TVApplication.Create;
  window := TMyWindow.Create;
  app.SetWindow(window);
  app.Run;
end.
