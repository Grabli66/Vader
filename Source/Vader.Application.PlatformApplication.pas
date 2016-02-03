unit Vader.Application.PlatformApplication;

{$mode objfpc}{$H+}

interface

uses Vader.System,
     Vader.Controls.Window;

type

  { TVPlatformApplication }

  TVPlatformApplication = class(TVaderObject)
  protected
    fCurrentWindow: TVWindow;
  public
    procedure SetWindow(window: TVWindow);
  end;

implementation

{ TVPlatformApplication }

procedure TVPlatformApplication.SetWindow(window: TVWindow);
begin
  fCurrentWindow := window;
end;

end.
