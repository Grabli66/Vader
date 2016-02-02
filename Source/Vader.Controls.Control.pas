unit Vader.Controls.Control;

{$mode objfpc}{$H+}

interface

uses
  Vader.System,
  Vader.Graphics.Graphics;

type

{ TVControl }

 TVControl = class(TVaderObject)
 protected
   fGraphics : TVGraphics;
   fParent: TVControl;
 public
   constructor Create(parent: TVControl);
   property Graphics: TVGraphics read fGraphics;
   // Adds child to control
   procedure AddChild(child: TVControl);
   // Redraws control
   procedure Redraw; virtual;
end;

implementation

{ TVControl }

constructor TVControl.Create(parent: TVControl);
begin

end;

procedure TVControl.AddChild(child: TVControl);
begin

end;

procedure TVControl.Redraw;
begin

end;

end.

