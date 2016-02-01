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
 public
   constructor Create;
end;

implementation

{ TVControl }

constructor TVControl.Create;
begin

end;

end.

