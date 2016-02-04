unit Vader.Platform.Controls.Window;

{$mode objfpc}

interface

uses
  Vader.System,
  Vader.Controls.Control,
  Vader.Graphics.Textures;

type TVPlatformWindow = class(TVControl)
  protected
    fOnClose: TNotifyEvent;
  public
    property OnClose: TNotifyEvent read fOnClose write fOnClose;
    procedure SetCaption(caption: WideString); virtual; abstract;
    procedure DrawTexture(x,y: integer; texture: IPixelSurface); virtual; abstract;
    procedure ProcessMessages; virtual; abstract;
end;

implementation

end.

