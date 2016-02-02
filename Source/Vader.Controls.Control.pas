unit Vader.Controls.Control;

{$mode objfpc}{$H+}

interface

uses
  Vader.System,
  Vader.Geom,
  Vader.Controls.IWindow,
  Vader.Graphics.Graphics;

type

{ TVControl }

 TVControl = class(TVaderObject)
 protected
   fBox: TVRect;
   fGraphics : TVGraphics;
   fParent: TVControl;
   fWindow: IWindow;
//   fChilds:
 public
   constructor Create(parent: TVControl);
   property Graphics: TVGraphics read fGraphics;
   property Parent: TVControl read fParent;
   property Window: IWindow read fWindow;
   property Box: TVRect read fBox;
   procedure SetPosition(x,y: Integer); virtual;
   procedure SetSize(width, height: Integer); virtual;
   // Adds child to control
   procedure AddChild(child: TVControl);
   // Redraws control
   procedure Redraw;
end;

implementation

{ TVControl }

constructor TVControl.Create(parent: TVControl);
begin
  if parent = nil then Exit;
  if (parent is IWindow) then begin
    fWindow:= parent as IWindow;
    Exit;
  end;

  fParent:= parent;
end;

procedure TVControl.SetPosition(x, y: Integer);
begin
  fBox.x:=x;
  fBox.y:=y;
end;

procedure TVControl.SetSize(width, height: Integer);
begin
  fBox.Width:=width;
  fBox.Height:=height;
end;

procedure TVControl.AddChild(child: TVControl);
begin

end;

procedure TVControl.Redraw;
begin
  fWindow.Redraw;
end;

end.

