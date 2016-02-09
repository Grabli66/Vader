unit Vader.Math;

{$I Vader.inc}

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
  Result := Trunc(x);
  if Frac(x) < 0 then
    Result := Result - 1;
end;

function Ceil(x: double): integer;
begin
  Result := Trunc(x);
  if Frac(x) > 0 then
    Result := Result + 1;
end;

end.

