unit Vader.System;

{$I Vader.inc}

interface

//uses sysutils;

type
  TString = string;

type

  { TByte }

  TByte = record
    Value: Byte;
    class function Parse(s: TString): TByte; static;
    function ToString: TString;
  end;


  TSByte = shortint;
  TInt16 = smallint;
  TUInt16 = word;
  TInt32 = longint;
  TUInt32 = longword;
  TInt64 = int64;
  TUint64 = QWord;
  TChar = char;

  TDateTime = record
    Value: Double;
//    class function FromString(s: String): TDateTime;
  end;

type
  { TVaderObject }

  TVaderObject = class(TInterfacedObject)
  public
    // Assings values from one object to another
    procedure Assign(src: TVaderObject); virtual;
  end;

implementation

{ TByte }

class function TByte.Parse(s: TString): TByte;
var error: word;
begin
  Val(s, Result.Value, error);
end;

function TByte.ToString: TString;
begin
  System.Str(Value, result);
end;

{ TVaderObject }

// Assings values from one object to another
procedure TVaderObject.Assign(src: TVaderObject);
begin
end;

end.
