unit Vader.Collections;

{$I Vader.inc}

interface

uses
  Vader.System;

type
  TArray<T> = array of T;

type
  ICollection<T> = interface(IEnumerable<T>)
    ['{DF82B6C9-6310-4BB9-B3AE-61A788F1A6DA}']
    function Size: integer;
    function IsEmpty: boolean;
    procedure Add(obj: T);
    procedure Clear;
  end;

type
  IList<T> = interface(ICollection<T>)
    ['{1A551ADE-706A-444B-8B83-46942090864A}']
    function GetItem(index: integer): T;
    procedure SetItem(Index: integer; const Value: T);
  end;

type

  { TArrayEnumerator }

  TArrayEnumerator<T> = class(TVaderObject, IEnumerator<T>)
  private
    fItems: TArray<T>;
    fPosition: integer;
    fCount: integer;
  public
    constructor Create(Items: TArray<T>; Count: integer = -1);
    { IEnumerator<T> }
    function GetCurrent: T;
    function MoveNext: boolean;
    procedure Reset;
  end;

type

  { TArrayList }

  TArrayList<T> = class(TVaderObject, IList<T>)
  private
    fPos: integer;
    fSize: integer;
    fInitCapacity: integer;
    fItems: TArray<T>;
    procedure Init(capacity: integer = 0);
  public
    constructor Create(capacity: integer = 0);
    // ICollection
    function Size: integer;
    function IsEmpty: boolean;
    procedure Add(obj: T);
    procedure Clear;
    // IList
    function GetItem(Index: integer): T;
    procedure SetItem(Index: integer; const Value: T);
    property Item[Index: integer]: T read GetItem write SetItem; default;
    // IEnumerator
    function GetEnumerator: IEnumerator<T>;
  end;

implementation

{ TArrayList }

constructor TArrayList<T>.Create(capacity: integer = 0);
begin
  fInitCapacity := capacity;
  Init(capacity);
end;

procedure TArrayList<T>.Init(capacity: integer = 0);
begin
  fSize := 0;
  fItems := nil;
  fPos := 0;
  if capacity > 0 then
  begin
    SetLength(fItems, capacity);
  end;
end;

function TArrayList<T>.GetItem(Index: integer): T;
begin
  Result := fItems[Index];
end;

procedure TArrayList<T>.SetItem(Index: integer; const Value: T);
begin
  fItems[Index] := Value;
end;

function TArrayList<T>.Size: integer;
begin
  Result := fSize;
end;

function TArrayList<T>.IsEmpty: boolean;
begin
  Result := fSize = 0;
end;

procedure TArrayList<T>.Add(obj: T);
var
  len: integer;
begin
  len := Length(fItems);
  if fSize < len then
  begin
    fItems[fSize] := obj;
  end
  else
  begin
    SetLength(fItems, fSize + 1);
    fItems[fSize] := obj;
  end;

  Inc(fSize, 1);
end;

procedure TArrayList<T>.Clear;
var i: Integer;
begin
  for i:= 0 to fSize -1 do begin
    fItems[i].Free;
  end;

  fSize := 0;
  Init(fInitCapacity);
end;

function TArrayList<T>.GetEnumerator: IEnumerator<T>;
begin
  Result := TArrayEnumerator<T>.Create(fItems);
end;

{ TArrayEnumerator }

constructor TArrayEnumerator<T>.Create(Items: TArray<T>; Count: integer);
begin
  inherited Create;
  fItems := Items;
  fPosition := -1;
  if Count < 0 then
    fCount := Length(Items)
  else
    fCount := Count;
end;

function TArrayEnumerator<T>.GetCurrent: T;
begin
  Result := fItems[fPosition];
end;

function TArrayEnumerator<T>.MoveNext: boolean;
begin
  Inc(fPosition);
  Result := fPosition < fCount;
end;

procedure TArrayEnumerator<T>.Reset;
begin
  fPosition := -1;
end;

end.
