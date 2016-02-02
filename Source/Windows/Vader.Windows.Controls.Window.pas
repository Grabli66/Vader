unit Vader.Windows.Controls.Window;

{$mode objfpc}{$H+}

interface

uses
  Windows,
  Vader.System,
  Vader.Controls.Control,
  Vader.Controls.IWindow;

type

  { TVPlatformWindow }

  TVPlatformWindow = class(TVControl, IWindow)
  private
    fWndClass: TWndClassExW;
    fWndINST: HINST;
    fWndClassName: PWideChar;
    fWndCaptionW: PWideChar;
    fWndStyle: longword;
    fWndHandle: Handle;
  public
    constructor Create;
    procedure SetCaption(Caption: WideString);
    procedure SetPosition(x, y: integer);
    procedure SetSize(Width, Height: integer);
  end;

implementation

function WindowProcessMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT; stdcall;
begin

end;

{ TVPlatformWindow }

constructor TVPlatformWindow.Create;
var
  wndCpnSize, wndBrdSizeX, wndBrdSizeY: longint;
begin
  inherited Create(nil);
  fWndClassName:= 'Vader';
  fWndCaptionW:= 'Vader App';
  wndCpnSize := GetSystemMetrics(SM_CYCAPTION);
  wndBrdSizeX := GetSystemMetrics(SM_CXDLGFRAME);
  wndBrdSizeY := GetSystemMetrics(SM_CYDLGFRAME);

  with fWndClass do
  begin
    cbSize := SizeOf(TWndClassExW);
    style := CS_DBLCLKS or CS_OWNDC;
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

  fWndStyle := WS_CAPTION or WS_MINIMIZEBOX or WS_SYSMENU or WS_VISIBLE;
  fWndHandle := CreateWindowExW( WS_EX_TOOLWINDOW, fWndClassName, fWndCaptionW, WS_POPUP, 0, 0, 0, 0, 0, 0, 0, nil );

  BringWindowToTop( fWndHandle );
end;

procedure TVPlatformWindow.SetCaption(Caption: WideString);
begin

end;

procedure TVPlatformWindow.SetPosition(x, y: integer);
begin

end;

procedure TVPlatformWindow.SetSize(Width, Height: integer);
begin

end;

end.
