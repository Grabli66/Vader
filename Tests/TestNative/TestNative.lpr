program TestNative;

{$mode delphi}

uses
  SysUtils,
  Vader.Application,
  Vader.Controls.Window,
  Vader.Collections,
  Vader.Platform.Windows.Application;

type
  { TMyWindow }

  TMyWindow = class(TVWindow)
  public
  end;

var
  app: TVPlatformApplicationImpl;
  window: TMyWindow;

{ TMyWindow }

begin
  if FileExists('heap.trc') then
    DeleteFile('heap.trc');
  SetHeapTraceOutput('heap.trc');

 { app := TVApplication.Create;
  window := TMyWindow.Create;
  app.SetWindow(window);
  app.Run;}

 // ReadLn;
//  WriteLn(arr.GetItem(0));
//  arr.Free;
end.
