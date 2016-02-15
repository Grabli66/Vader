program TestNative;

{$mode delphi}

uses
  SysUtils, dateutils,
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
  b1, b2: TByte;
  s: TDateTime;
  st: TString;
  g: TInt32;
  ts: TTimeSpan;

{ TMyWindow }

begin
  if FileExists('heap.trc') then
    DeleteFile('heap.trc');
  SetHeapTraceOutput('heap.trc');

  b1:= 32 shl 1;
  st:= 'говнище';
  writeln(b1.ToString);
//  IncAMonth();

 { app := TVApplication.Create;
  window := TMyWindow.Create;
  app.SetWindow(window);
  app.Run;}

//  ReadLn;
//  WriteLn(arr.GetItem(0));
//  arr.Free;
end.
