unit Vader.Opengl.Context;

{$mode objfpc}{$H+}

interface

uses Gl, glu, Vader.System, gles20;

type

{ TVOpenglContext }

 TVOpenglContext = class(TVaderObject)
  public
    procedure glLoadIdentity;
    procedure glTranslatef(x,y,z: Double);
end;

implementation

{ TVOpenglContext }

procedure TVOpenglContext.glLoadIdentity;
begin
  Gl.glLoadIdentity;
end;

procedure TVOpenglContext.glTranslatef(x, y, z: Double);
begin
  GL.glTranslatef(x,y,z);
end;

end.

