unit Vader.System;

{$I Vader.inc}

interface

type
  TByte = Byte;
  TSByte = ShortInt;
  TInt16 = SmallInt;
  TUInt16 = Word;
  TInt32 = LongInt;
  TUInt32 = Longword;
  TInt64 = Int64;
  TUint64 = QWord;
  TString = String;
  TChar = char;

type
  { TVaderObject }

  TVaderObject = class(TInterfacedObject)
    public
      // Assings values from one object to another
      procedure Assign(src: TVaderObject); virtual;
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

// Assings values from one object to another
procedure TVaderObject.Assign(src: TVaderObject);
begin
end;

end.
