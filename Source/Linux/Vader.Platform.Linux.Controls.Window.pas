unit Vader.Platform.Linux.Controls.Window;

{$I Vader.inc}

interface

uses
  GL, GLU, GLX, GLext, X, XLib, XUtil,
  Vader.System,
  Vader.Controls.Control,
  Vader.Platform.Controls.Window,
  Vader.Graphics.Plot,
  Vader.Graphics.Textures;

type

  { TVPlatformWindowImpl }

  TVPlatformWindowImpl = class(TVPlatformWindow)
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
    fTextureName: GLuint;
    // Connects to X Server
    procedure ChooseVisual;
    procedure ConnectXServer;
    procedure CreateGLContext;
    procedure CreateWindow;
    procedure DestroyGLContext;
    procedure DestroyWindow;
    procedure OpenGLInit;
    procedure Start;
    procedure SwapBuffers;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetCaption(Caption: WideString);
    procedure DrawTexture(x, y: integer; texture: IPixelSurface);
    procedure Show; override;
    procedure OnDraw; override;
  end;

implementation

{ TVPlatformWindow }

constructor TVPlatformWindowImpl.Create;
begin
  inherited Create(nil);
  fBox.x := 100;
  fBox.y := 100;
  fBox.Width := 800;
  fBox.Height := 600;
  fCaption := 'Vader';
  Start;
end;

destructor TVPlatformWindowImpl.Destroy;
begin
  DestroyGLContext;
  DestroyWindow;

  XFreeColormap(fScrDisplay, fScrColorMap);
  inherited Destroy;
end;

// Connects to X Server
procedure TVPlatformWindowImpl.ConnectXServer;
begin
  fScrDisplay := XOpenDisplay(nil);
  if not Assigned(fScrDisplay) then
  begin
    exit;
  end;
  fScrDefault := DefaultScreen(fScrDisplay);
end;

// Choose display settings
procedure TVPlatformWindowImpl.ChooseVisual;
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
procedure TVPlatformWindowImpl.CreateGLContext;
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
procedure TVPlatformWindowImpl.CreateWindow;
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
procedure TVPlatformWindowImpl.DestroyGLContext;
begin
  if not glXMakeCurrent(fScrDisplay, None, nil) then
    Exit;

  glXDestroyContext(fScrDisplay, fOglContext);
  glXWaitGL;
end;

{ Free window }
procedure TVPlatformWindowImpl.DestroyWindow;
begin
  XDestroyWindow(fScrDisplay, fWndHandle);
  glXWaitX;
end;

procedure TVPlatformWindowImpl.SwapBuffers;
begin
  glXSwapBuffers(fScrDisplay, fWndHandle);
end;

procedure TVPlatformWindowImpl.OpenGLInit;
var plot: TVPlotter;
  texture: TVTexture;
  circle: TVCirclePlotSettings;
begin
  glClearColor(1.0,1.0,1.0,1.0);

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
//  texture.FillColor($FF000000);
  plot:= TVPlotter.Create;
  circle.Color:=$FF1155AA;
  circle.x:=100;
  circle.y:=100;
  circle.Radius:=50;
  plot.PlotCircle(texture, circle);

  glGenTextures(1, @fTextureName);
  glBindTexture(GL_TEXTURE_2D, fTextureName);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 800, 600, 0, GL_RGBA, GL_UNSIGNED_BYTE, @texture.Pixels[1]);
  texture.Free;
  plot.Free;
end;

procedure TVPlatformWindowImpl.Start;
var
  wnd_Title: TXTextProperty;
begin
  // Создает окно и OpenGL контекст
  ConnectXServer;
  ChooseVisual;
  CreateWindow;
  CreateGLContext;
  OpenGLInit;

  // Устанавливает название окна
  XStringListToTextProperty(@fCaption, 1, @wnd_Title);
  XSetWMName(fScrDisplay, fWndHandle, @wnd_Title);
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

  { draw here }
  glClear(GL_COLOR_BUFFER_BIT);
  glLoadIdentity();

 // glColor3f(0.0, 1.0, 1.0);
  glBindTexture(GL_TEXTURE_2D, fTextureName);
  glBegin(GL_QUADS);
  glTexCoord2d(0, 0);
  glVertex2i(0, 0);
  glTexCoord2d(0, 1);
  glVertex2i(0, fBox.Height);
  glTexCoord2d(1, 1);
  glVertex2i(fBox.Width, fBox.Height);
  glTexCoord2d(1, 0);
  glVertex2i(fBox.Width, 0);
  glEnd();

  glXWaitGL;
  SwapBuffers;   // put opengl stuff to screen
end;

procedure TVPlatformWindowImpl.Show;
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
