unit Vader.Controls.IWindow;

{$mode objfpc}{$H+}

interface

uses Vader.Geom,
     Vader.Graphics.Textures;

type IWindow = interface
  ['{E72DAD77-3C61-428E-A9BF-C6A52B511D6E}']
  procedure SetCaption(caption: WideString);
  procedure DrawTexture(x,y: integer; texture: IPixelSurface);
  procedure Redraw;
end;

implementation

end.

