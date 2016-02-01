unit Vader.Math;

{$mode objfpc}{$H+}

interface

type
  TValueSign = -1..1;

const
  NegativeValue = Low(TValueSign);
  ZeroValue = 0;
  PositiveValue = High(TValueSign);

function Sign(const AValue: double): TValueSign; inline;
function Floor(x: double): integer;
function Ceil(x: double): integer;

implementation

function Sign(const AValue: double): TValueSign; inline;
begin
  if Avalue < 0.0 then
    Result := NegativeValue
  else if Avalue > 0.0 then
    Result := PositiveValue
  else
    Result := ZeroValue;
end;

function Floor(x: double): integer;
begin
  Floor := Trunc(x);
  if Frac(x) < 0 then
    Floor := Floor - 1;
end;

function Ceil(x: double): integer;
begin
  Ceil := Trunc(x);
  if Frac(x) > 0 then
    Ceil := Ceil + 1;
end;

end.

