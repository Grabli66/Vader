unit Vader.Controls.IWindow;

{$mode objfpc}{$H+}

interface

uses Vader.Geom;

type IWindow = interface
  ['{E72DAD77-3C61-428E-A9BF-C6A52B511D6E}']
  procedure SetCaption(caption: WideString);
  procedure SetPosition(x,y: Integer);
  procedure SetSize(width, height: Integer);
end;

implementation

end.

