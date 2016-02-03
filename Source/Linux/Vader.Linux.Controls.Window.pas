unit Vader.Linux.Controls.Window;

{$mode objfpc}{$H+}

interface

uses
  GL, GLU, GLX, GLext, X, XLib, XUtil,
  Vader.System,
  Vader.Controls.Control,
  Vader.Controls.IWindow,
  Vader.Graphics.Textures;

type

  { TVPlatformWindow }

  TVPlatformWindow = class(TVControl, IWindow)
  private
    fCaption: PChar;
    { Pointer to display }
    fScrDisplay: PDisplay;
    { Pointer to screen }
    fScrDefault: DWORD;
    { OpenGL settings }
    fGlAttr: array[0..10] of DWORD;
    { glXChooseVisual }
    fVisualInfo: PXVisualInfo;
    fScrColorMap: TColormap;
    { Window settings }
    fWndAttr: TXSetWindowAttributes;
    { Window handle }
    fWndHandle: TWindow;
    { Opengl context }
    fOglContext: GLXContext;
    // Connects to X Server
    procedure ChooseVisual;
    procedure ConnectXServer;
    procedure CreateGLContext;
    procedure CreateWindow;
    procedure DestroyGLContext;
    procedure DestroyWindow;
    procedure Start;
    procedure SwapBuffers;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetCaption(Caption: WideString);
    procedure DrawTexture(x, y: integer; texture: IPixelSurface);
    procedure ProcessMessages;
  end;

implementation

{ TVPlatformWindow }

constructor TVPlatformWindow.Create;
begin
  inherited Create(nil);
  fBox.x := 100;
  fBox.y := 100;
  fBox.Width := 800;
  fBox.Height := 600;
  fCaption := 'Vader';
  Start;
end;

destructor TVPlatformWindow.Destroy;
begin
  DestroyGLContext;
  DestroyWindow;

  XFreeColormap(fScrDisplay, fScrColorMap);
  inherited Destroy;
end;

// Connects to X Server
procedure TVPlatformWindow.ConnectXServer;
begin
  fScrDisplay := XOpenDisplay(nil);
  if not Assigned(fScrDisplay) then
  begin
    exit;
  end;
  fScrDefault := DefaultScreen(fScrDisplay);
end;

// Choose display settings
procedure TVPlatformWindow.ChooseVisual;
begin
  fGlAttr[0] := GLX_RGBA;
  fGlAttr[1] := GLX_DOUBLEBUFFER;
  fGlAttr[2] := GLX_DEPTH_SIZE;
  fGlAttr[3] := 24;
  fGlAttr[4] := GLX_STENCIL_SIZE;
  fGlAttr[5] := 8;
  fGlAttr[6] := None;

  fVisualInfo := glXChooseVisual(fScrDisplay, fScrDefault, @fGlAttr);
  if not Assigned(fVisualInfo) then
  begin
    exit;
  end;
end;

{ Creates opengl context }
procedure TVPlatformWindow.CreateGLContext;
var
  attribs: array[0..4] of integer;
  nitems: integer;
  config: PGLXFBConfig;
begin
  config := glXChooseFBConfig(fScrDisplay, fScrDefault, nil, nitems);

  attribs[0] := GLX_CONTEXT_MAJOR_VERSION_ARB;
  attribs[1] := 3;
  attribs[2] := GLX_CONTEXT_MINOR_VERSION_ARB;
  attribs[3] := 0;
  attribs[4] := 0;

  fOglContext := glXCreateContextAttribsARB(fScrDisplay, config^, nil, True, attribs);

  if not Assigned(fOglContext) then
  begin
    fOglContext := glXCreateContext(fScrDisplay, fVisualInfo, nil, False);
    if not Assigned(fOglContext) then
    begin
      exit;
    end;
  end;

  if not glXMakeCurrent(fScrDisplay, fWndHandle, fOglContext) then
  begin
    exit;
  end;
end;

// Creates window
procedure TVPlatformWindow.CreateWindow;
var
  wndValueMask: integer;
  rootWnd: TWindow;
begin
  // get root window
  rootWnd := RootWindow(fScrDisplay, fVisualInfo^.screen);
  fScrColorMap := XCreateColormap(fScrDisplay, rootWnd, fVisualInfo^.visual,
    AllocNone);

  fWndAttr.colormap := fScrColorMap;
  fWndAttr.event_mask := ExposureMask or StructureNotifyMask;
  wndValueMask := CWColormap or CWEventMask or CWX or CWY;

  fWndHandle := XCreateWindow(fScrDisplay, rootWnd, fBox.x, fBox.y,
    fBox.Width, fBox.Height, 0, // Border width
    fVisualInfo^.depth, InputOutput, fVisualInfo^.visual, wndValueMask, @fWndAttr);

  if fWndHandle = 0 then
  begin
    exit;
  end;

  XMapWindow(fScrDisplay, fWndHandle);
  glXWaitX;
end;

{ Free opengl context }
procedure TVPlatformWindow.DestroyGLContext;
begin
  if not glXMakeCurrent(fScrDisplay, None, nil) then
    Exit;

  glXDestroyContext(fScrDisplay, fOglContext);
  glXWaitGL;
end;

{ Free window }
procedure TVPlatformWindow.DestroyWindow;
begin
  XDestroyWindow(fScrDisplay, fWndHandle);
  glXWaitX;
end;

procedure TVPlatformWindow.SwapBuffers;
begin
  glXSwapBuffers(fScrDisplay, fWndHandle);
end;

procedure TVPlatformWindow.Start;
var
  wnd_Title: TXTextProperty;
begin
  // Создает окно и OpenGL контекст
  ConnectXServer;
  ChooseVisual;
  CreateWindow;
  CreateGLContext;

  // Устанавливает название окна
  XStringListToTextProperty(@fCaption, 1, @wnd_Title);
  XSetWMName(fScrDisplay, fWndHandle, @wnd_Title);
end;

procedure TVPlatformWindow.SetCaption(Caption: WideString);
begin

end;

procedure TVPlatformWindow.DrawTexture(x, y: integer; texture: IPixelSurface);
begin
end;

procedure TVPlatformWindow.ProcessMessages;
var
  running: boolean;
  wmDeleteMessage: TAtom;
var
  event: TXEvent;
begin
  // Подписывается на событие удаления окна
  wmDeleteMessage := XInternAtom(fScrDisplay, 'WM_DELETE_WINDOW', False);
  XSetWMProtocols(fScrDisplay, fWndHandle, @wmDeleteMessage, 1);
  running:= true;
  while running do
  begin
    while XPending(fScrDisplay) <> 0 do
    begin
      XNextEvent(fScrDisplay, @event);
      if (event._type = ClientMessage) then
      begin
        if (event.xclient.Data.l[0] = wmDeleteMessage) then
          running := False;
        break;
      end;
      OnDraw;
    end;
  end;
end;

end.
