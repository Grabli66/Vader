unit Vader.Geometry;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TVPoint = packed record
    x, y: integer;
  end;

  TVRect = packed record
    x, y, Width, Height: integer;
  end;

implementation

end.

