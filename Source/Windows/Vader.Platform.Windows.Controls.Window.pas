unit Vader.Platform.Windows.Controls.Window;

{$mode objfpc}{$H+}

interface

uses
  Windows,
  Vader.System,
  Vader.Graphics.Textures,
  Vader.Controls.Control,
  Vader.Platform.Controls.Window;

type

  { TVPlatformWindowImpl }

  TVPlatformWindowImpl = class(TVPlatformWindow)
  private
    fWndClass: TWndClassExW;
    fWndINST: HINST;
    fWndClassName: PWideChar;
    fWndCaptionW: PWideChar;
    fWndStyle: longword;
    fWndHandle: Handle;
  public
    constructor Create;
    procedure SetCaption(Caption: WideString); override;
    procedure DrawTexture(x, y: integer; texture: IPixelSurface); override;
    procedure OnDraw; override;
    procedure ProcessMessages; override;
  end;

implementation

var gWindow: TVPlatformWindowImpl;

function WindowProcessMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT; stdcall;
begin
  case Msg of
    WM_DESTROY: begin
      if gWindow.OnClose <> nil then gWindow.OnClose(gWindow);
    end;
  end;

  Result := DefWindowProcW(hWnd, Msg, wParam, lParam);
end;

{ TVPlatformWindow }

constructor TVPlatformWindowImpl.Create;
var
  wndCpnSize, wndBrdSizeX, wndBrdSizeY: longint;
begin
  inherited Create(nil);
  gWindow:= self;

  fBox.x := 100;
  fBox.y := 100;
  fBox.Width := 800;
  fBox.Height := 600;

  fWndClassName := 'Vader';
  fWndCaptionW := 'Vader App';
  wndCpnSize := GetSystemMetrics(SM_CYCAPTION);
  wndBrdSizeX := GetSystemMetrics(SM_CXDLGFRAME);
  wndBrdSizeY := GetSystemMetrics(SM_CYDLGFRAME);

  with fWndClass do
  begin
    cbSize := SizeOf(TWndClassExW);
    style := CS_DBLCLKS or CS_HREDRAW or CS_OWNDC or CS_VREDRAW;
    lpfnWndProc := @WindowProcessMessage;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hInstance := fWndINST;
    hIcon := LoadIconW(fWndINST, 'MAINICON');
    hIconSm := 0;
    hCursor := LoadCursorW(fWndINST, PWideChar(IDC_ARROW));
    lpszMenuName := nil;
    hbrBackGround := GetStockObject(BLACK_BRUSH);
    lpszClassName := fWndClassName;
  end;

  if RegisterClassExW(fWndClass) = 0 then
  begin
    exit;
  end;

  fWndHandle := CreateWindowExW(WS_EX_APPWINDOW or WS_EX_CONTROLPARENT or
    WS_EX_WINDOWEDGE, fWndClassName, fWndCaptionW, WS_CAPTION or
    WS_CLIPCHILDREN or WS_MAXIMIZEBOX or WS_MINIMIZEBOX or WS_OVERLAPPED or
    WS_SIZEBOX or WS_SYSMENU or WS_VISIBLE, fBox.x, fBox.y, fBox.Width,
    fBox.Height, 0, 0, HInstance, nil);

  ShowWindow(fWndHandle, CmdShow);
  ShowWindow(fWndHandle, SW_SHOW);
  UpdateWindow(fWndHandle);

  BringWindowToTop(fWndHandle);
end;

procedure TVPlatformWindowImpl.SetCaption(Caption: WideString);
begin

end;

procedure TVPlatformWindowImpl.DrawTexture(x, y: integer; texture: IPixelSurface);
begin

end;

procedure TVPlatformWindowImpl.OnDraw;
begin
  inherited OnDraw;
end;

procedure TVPlatformWindowImpl.ProcessMessages;
var
  AMessage: Msg;
begin
  while GetMessage(@AMessage, 0, 0, 0) do
  begin
    TranslateMessage(AMessage);
    DispatchMessage(AMessage);
  end;
  Halt(AMessage.wParam);
end;

end.
