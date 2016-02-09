unit Vader.Controls.Control;

{$I Vader.inc}

interface

uses
  Vader.System,
  Vader.Geometry,
//  Vader.Controls.Window,
  Vader.Graphics.Graphics,
  Vader.Collections;

type

  TNotifyEvent = procedure(Sender: TVaderObject) of object;

  { TVControl }

  TVControl = class(TVaderObject)
  protected
    fBox: TVRect;
    fGraphics: TVGraphics;
    fParent: TVControl;
//    fWindow: TVWindow;
    fChilds: IList<TVControl>;
  public
    constructor Create(parent: TVControl);
    property Graphics: TVGraphics read fGraphics;
    property Parent: TVControl read fParent;
//    property Window: TVWindow read fWindow;
    property Box: TVRect read fBox;
    procedure SetPosition(x, y: integer); virtual;
    procedure SetSize(Width, Height: integer); virtual;
    // Adds child to control
    procedure AddChild(child: TVControl);
    procedure OnDraw; virtual;
  end;

implementation

{ TVControl }

constructor TVControl.Create(parent: TVControl);
begin
  {if parent = nil then
    Exit;
  if (parent is IWindow) then
  begin
    fWindow := parent as IWindow;
    Exit;
  end;

  fParent := parent;}
  fChilds:= TArrayList<TVControl>.Create;
end;

procedure TVControl.SetPosition(x, y: integer);
begin
  fBox.x := x;
  fBox.y := y;
end;

procedure TVControl.SetSize(Width, Height: integer);
begin
  fBox.Width := Width;
  fBox.Height := Height;
end;

procedure TVControl.AddChild(child: TVControl);
begin
  fChilds.Add(child);
end;

procedure TVControl.OnDraw;
begin
end;

end.

