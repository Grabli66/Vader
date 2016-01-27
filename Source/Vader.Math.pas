unit Vader.Math;

{$mode objfpc}{$H+}

interface

// Sign functions
type
  TValueSign = -1..1;

const
  NegativeValue = Low(TValueSign);
  ZeroValue = 0;
  PositiveValue = High(TValueSign);

function Sign(const AValue: Double): TValueSign;inline;

implementation

function Sign(const AValue: Double): TValueSign;inline;
begin
  If Avalue<0.0 then
    Result:=NegativeValue
  else If Avalue>0.0 then
    Result:=PositiveValue
  else
    Result:=ZeroValue;
end;

end.

