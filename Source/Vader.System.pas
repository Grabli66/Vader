unit Vader.System;

{$mode objfpc}{$H+}

interface

type

  { TVaderObject }

  TVaderObject = class
    public
      procedure Assign(src: TVaderObject); virtual;
      function ToString: WideString; virtual;
  end;

procedure FreeAndNil(var Obj);

implementation

procedure FreeAndNil(var Obj);
var
  P: TObject;
begin
  P := TObject(Obj);
  TObject(Obj) := nil;  // clear the reference before destroying the object
  P.Free;
end;

{ TVaderObject }

procedure TVaderObject.Assign(src: TVaderObject);
begin

end;

function TVaderObject.ToString: WideString;
begin
  Result:='TVaderObject';
end;

end.
