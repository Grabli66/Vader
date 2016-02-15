unit Vader.System;

{$I Vader.inc}

interface

//uses sysutils;

type
  TString = type WideString;
  TChar = type WideChar;
  TByte = type Byte;
  TSByte = type Shortint;
  TInt16 = type Smallint;
  TUInt16 = type Word;
  TInt32 = type Longint;
  TUInt32 = type Longword;
  TInt64 = type Int64;
  TUint64 = type QWord;
  TDouble = type Double;
  TBoolean = type Boolean;
  TDateTime = type Double;
  TTimeSpan = type Double;

  { TStringHelper }

  TStringHelper = record helper for TString
    function Size: TInt32;
  end;

  { TByteHelper }

  TByteHelper = record helper for TByte
    class function Parse(value: TString): TByte; static;
    function ToString: TString;
  end;

  { TDateTimeHelper }

  TDateTimeKind = (Local, Unspecified, Utc);

  TDateTimeHelper = record helper for TDateTime
    class function Now: TDateTime; static; inline;
    class function UtcNow: TDateTime; static; inline;
    class function Today: TDateTime; static; inline;
    procedure AddDays(value: TInt32);
    function Date: TDateTime;
    function Year: TInt32;
    function Month: TInt32;
    function Day: TInt32;
    function Hour: TInt32;
    function Minute: TInt32;
    function Second: TInt32;
    function Millisecond: TInt32;
    function Ticks: TInt64;
    function DayOfWeek: TInt32;
    function DayOfYear: TInt32;
    function Kind: TDateTimeKind;
    function ToString: TString;
  end;

  { TTimeSpanHelper }

  TTimeSpanHelper = record helper for TTimeSpan
    class function Create(hours, minutes, seconds: TInt32): TTimeSpan; static; overload;
    class function Create(days, hours, minutes, seconds: TInt32): TTimeSpan; static; overload;
    class function Create(days, hours, minutes, seconds, milliseconds: TInt32): TTimeSpan; static; overload;
    class function Create(ticks: TInt64): TTimeSpan; static; overload;
    class function TicksPerDay: TInt64; static; inline;
    class function TicksPerHour: TInt64; static; inline;
    class function TicksPerMinute: TInt64; static; inline;
    class function TicksPerSecond: TInt64; static; inline;
    class function TicksPerMillisecond: TInt64; static; inline;
    function Days: TInt32;
    function Hours: TInt32;
    function Minutes: TInt32;
    function Seconds: TInt32;
    function Milliseconds: TInt32;
    function Ticks: TInt64;
    function TotalDays: TInt32;
    function TotalHours: TInt32;
    function TotalMinutes: TInt32;
    function TotalSeconds: TInt32;
    function TotalMilliseconds: TInt32;
    function TotalTicks: TInt64;
  end;

type
  { TVaderObject }

  TVaderObject = class(TInterfacedObject)
  public
    // Assings values from one object to another
    procedure Assign(src: TVaderObject); virtual;
  end;

implementation

{ TDateTimeHelper }

class function TDateTimeHelper.Now: TDateTime;
begin

end;

class function TDateTimeHelper.UtcNow: TDateTime;
begin

end;

class function TDateTimeHelper.Today: TDateTime;
begin

end;

procedure TDateTimeHelper.AddDays(value: TInt32);
begin
  self:= self + value;
end;

function TDateTimeHelper.Date: TDateTime;
begin

end;

function TDateTimeHelper.Year: TInt32;
begin

end;

function TDateTimeHelper.Month: TInt32;
begin

end;

function TDateTimeHelper.Day: TInt32;
begin

end;

function TDateTimeHelper.Hour: TInt32;
begin

end;

function TDateTimeHelper.Minute: TInt32;
begin

end;

function TDateTimeHelper.Second: TInt32;
begin

end;

function TDateTimeHelper.Millisecond: TInt32;
begin

end;

function TDateTimeHelper.Ticks: TInt64;
begin

end;

function TDateTimeHelper.DayOfWeek: TInt32;
begin

end;

function TDateTimeHelper.DayOfYear: TInt32;
begin

end;

function TDateTimeHelper.Kind: TDateTimeKind;
begin

end;

function TDateTimeHelper.ToString: TString;
begin
  Result:= '';
end;

{ TTimeSpanHelper }

class function TTimeSpanHelper.Create(hours, minutes, seconds: TInt32
  ): TTimeSpan;
begin

end;

class function TTimeSpanHelper.Create(days, hours, minutes, seconds: TInt32): TTimeSpan;
begin
  Result:= days;
end;

class function TTimeSpanHelper.Create(days, hours, minutes, seconds,
  milliseconds: TInt32): TTimeSpan;
begin

end;

class function TTimeSpanHelper.Create(ticks: TInt64): TTimeSpan;
begin

end;

class function TTimeSpanHelper.TicksPerDay: TInt64;
begin
  Result:= 864000000000;
end;

class function TTimeSpanHelper.TicksPerHour: TInt64;
begin
 Result:= 36000000000;
end;

class function TTimeSpanHelper.TicksPerMinute: TInt64;
begin
 Result:= 600000000;
end;

class function TTimeSpanHelper.TicksPerSecond: TInt64;
begin
 Result:= 10000000;
end;

class function TTimeSpanHelper.TicksPerMillisecond: TInt64;
begin
  Result:= 10000;
end;

function TTimeSpanHelper.Days: TInt32;
begin

end;

function TTimeSpanHelper.Hours: TInt32;
begin

end;

function TTimeSpanHelper.Minutes: TInt32;
begin

end;

function TTimeSpanHelper.Seconds: TInt32;
begin

end;

function TTimeSpanHelper.Milliseconds: TInt32;
begin

end;

function TTimeSpanHelper.Ticks: TInt64;
begin

end;

function TTimeSpanHelper.TotalDays: TInt32;
begin

end;

function TTimeSpanHelper.TotalHours: TInt32;
begin

end;

function TTimeSpanHelper.TotalMinutes: TInt32;
begin

end;

function TTimeSpanHelper.TotalSeconds: TInt32;
begin

end;

function TTimeSpanHelper.TotalMilliseconds: TInt32;
begin

end;

function TTimeSpanHelper.TotalTicks: TInt64;
begin

end;

{ TStringHelper }

function TStringHelper.Size: TInt32;
begin
  Result:= Length(self);
end;

{ TByteHelper }

class function TByteHelper.Parse(value: TString): TByte;
var
  error: word;
begin
  Val(value, Result, error);
end;

function TByteHelper.ToString: TString;
begin
  System.Str(self, Result);
end;

{ TVaderObject }

procedure TVaderObject.Assign(src: TVaderObject);
begin
end;

end.
