unit Vader.Platform.Windows.Controls.Window;

{$mode objfpc}{$H+}

interface

uses
  Windows, GL, GLU,
  Vader.System,
  Vader.Controls.Control,
  Vader.Platform.Controls.Window,
  Vader.Graphics.Textures,
  Vader.Graphics.Plot,
  Vader.Graphics.Color;

type

  { TVPlatformWindowImpl }

  TVPlatformWindowImpl = class(TVPlatformWindow)
  private
    fWndClass: TWndClassExW;
    fWndINST: HINST;
    fWndClassName: PWideChar;
    fWndCaptionW: PWideChar;
    fWndHandle: Handle;
    fDcWindow: HDC;
    fRcWindow: HGLRC;   // Render Context for the OGL Window

    fTextureName: GLuint;

    procedure CreateGLContext;
    procedure CreateWindow;
    procedure OpenGLInit;
  public
    constructor Create;
    procedure ProcessMessages(Msg: UINT);
    procedure SetCaption(Caption: WideString); override;
    procedure DrawTexture(x, y: integer; texture: IPixelSurface); override;
    procedure OnDraw; override;
    procedure Show; override;
  end;

implementation

var
  gWindow: TVPlatformWindowImpl;

function WindowProcessMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT; stdcall;
begin
  gWindow.ProcessMessages(Msg);
  Result := DefWindowProcW(hWnd, Msg, wParam, lParam);
end;

{ TVPlatformWindow }

constructor TVPlatformWindowImpl.Create;
begin
  inherited Create(nil);
  gWindow := self;

  CreateWindow;
  CreateGLContext;
  OpenGLInit;

  ShowWindow(fWndHandle, SW_SHOW);
  UpdateWindow(fWndHandle);

  BringWindowToTop(fWndHandle);
end;

procedure TVPlatformWindowImpl.ProcessMessages(Msg: UINT);
begin
  case Msg of
    WM_DESTROY:
    begin
      if gWindow.OnClose <> nil then
        gWindow.OnClose(gWindow);
    end;
    WM_PAINT:
    begin
      gWindow.OnDraw;
    end;
  end;
end;

procedure TVPlatformWindowImpl.CreateWindow;
var
  wndCpnSize, wndBrdSizeX, wndBrdSizeY: longint;
begin
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
    style := cs_hRedraw or cs_vRedraw;
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
end;

procedure TVPlatformWindowImpl.CreateGLContext;
var
  pfd: PIXELFORMATDESCRIPTOR;
  iFormat: integer;   // Pixel Format
begin
  fDcWindow := GetDC(fWndHandle);

  FillChar(pfd, sizeof(pfd), 0);   // Define Pixel Format
  pfd.nSize := sizeof(pfd);
  pfd.nVersion := 1;
  pfd.dwFlags := PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER;
  pfd.iPixelType := PFD_TYPE_RGBA;
  pfd.cColorBits := 32;
  pfd.cDepthBits := 32;
  pfd.iLayerType := PFD_MAIN_PLANE;

  iFormat := ChoosePixelFormat(fDcWindow, @pfd);   // Create Pixel Format
  SetPixelFormat(fDcWindow, iFormat, @pfd);      // Set Pixel Format
  fRcWindow := wglCreateContext(fDcWindow);

  wglMakeCurrent(fDcWindow, fRcWindow);      // Bind OpenGL to our Window
end;

procedure TVPlatformWindowImpl.OpenGLInit;
var plot: TVPlotter;
  texture: TVTexture;
  circle: TVCirclePlotSettings;
begin
  glEnable(GL_BLEND);
  glEnable(GL_TEXTURE_2D);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glViewport(0, 0, fBox.Width, fBox.Height);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluOrtho2D(0, fBox.Width, 0, fBox.Height);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

 texture:= TVTexture.Create(800, 600);
  texture.FillColor($FF3333FF);
  plot:= TVPlotter.Create;
  circle.Color:=$FF000000;
  circle.x:=100;
  circle.y:=100;
  circle.Radius:=10;
//  plot.PlotCircle(texture, circle);

  glGenTextures(1, @fTextureName);
  glBindTexture(GL_TEXTURE_2D, fTextureName);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 800, 600, 0, GL_RGBA, GL_UNSIGNED_BYTE, @texture.Pixels[1]);
  texture.Free;
  plot.Free;
end;

procedure TVPlatformWindowImpl.SetCaption(Caption: WideString);
begin

end;

procedure TVPlatformWindowImpl.DrawTexture(x, y: integer; texture: IPixelSurface);
begin

end;

procedure TVPlatformWindowImpl.OnDraw;
var
  i, j: integer;
begin
  inherited OnDraw;

  { draw here }

  glClear(GL_COLOR_BUFFER_BIT);
  glLoadIdentity();

  //glColor3f(1.0, 1.0, 1.0);
 // glBindTexture(GL_TEXTURE_2D, fTextureName);
  glBegin(GL_QUADS);
  glVertex2i(0, 0);
  glVertex2i(0, fBox.Height);
  glVertex2i(fBox.Width, fBox.Height);
  glVertex2i(fBox.Width, 0);
  glEnd();

  SwapBuffers(fDcWindow);   // put opengl stuff to screen
end;

procedure TVPlatformWindowImpl.Show;
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
