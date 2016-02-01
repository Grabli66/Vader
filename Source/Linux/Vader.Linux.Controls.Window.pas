unit Vader.Linux.Controls.Window;

{$mode objfpc}{$H+}

interface

uses
  Vader.System,
  Vader.Controls.Control,
  Vader.Controls.IWindow,
  Vader.Opengl.Context;

type

  { TVPlatformWindow }

  TVPlatformWindow = class(TVControl, IWindow)
  private
    fGlContext: TVOpenglContext;
  public
    constructor Create;
    procedure SetCaption(Caption: WideString);
    procedure SetPosition(x, y: integer);
    procedure SetSize(Width, Height: integer);
    function Gl : TVOpenglContext;
  end;

implementation

{ TVPlatformWindow }

constructor TVPlatformWindow.Create;
begin
  inherited Create;
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

function TVPlatformWindow.Gl: TVOpenglContext;
begin
  Result:= fGlContext;
end;

end.
