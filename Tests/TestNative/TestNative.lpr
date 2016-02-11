program TestNative;

{$mode delphi}

uses
  SysUtils,
  Vader.System,
  Vader.Application,
  Vader.Controls.Window,
  Vader.Collections;

type
  { TMyWindow }

  TMyWindow = class(TVWindow)
  public
  end;

var
  window: TMyWindow;
  b: TByte;
  s: TDateTime;

{ TMyWindow }

begin
  if FileExists('heap.trc') then
    DeleteFile('heap.trc');
  SetHeapTraceOutput('heap.trc');

  b:= TByte.Parse('24');
  WriteLn(b.ToString);

 { app := TVApplication.Create;
  window := TMyWindow.Create;
  app.SetWindow(window);
  app.Run;}

//  ReadLn;
//  WriteLn(arr.GetItem(0));
//  arr.Free;
end.
