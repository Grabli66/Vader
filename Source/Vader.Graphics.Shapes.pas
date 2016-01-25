unit Vader.Graphics.Shapes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;

type
  TVPoint = packed record
    x, y: integer;
  end;

  TVRect = packed record
    x, y, Width, Height: integer;
  end;

  { TVSegment }

  TVSegment = class
  private
    fMinBound: TVPoint;
    fMaxBound: TVPoint;
  public
    property MinBound: TVPoint read fMinBound;
    property MaxBound: TVPoint read fMaxBound;
    function GetBounds: TVRect;
  end;

  { TVSegmentLine2D }

  TVSegmentLine2D = class(TVSegment)
  private
    fStartPos: TVPoint;
    fEndPos: TVPoint;
  public
    constructor Create(x0, y0, x1, y1: integer);
    property StartPos: TVPoint read fStartPos write fStartPos;
    property EndPos: TVPoint read fEndPos write fEndPos;
  end;

  { TVSegmentCircle }

  TVSegmentCircle = class(TVSegment)
    private
      fRadius: Integer;
    public
      constructor Create(x, y, R: integer);
      property Radius: Integer read fRadius;
  end;

  TVSegmentsArray = array of TVSegment;

  { TVShape }

  TVShape = class
  private
    fSegments: TVSegmentsArray;
    // Start position of line
    fCursorPos: TVPoint;
    // Position of shape
    fOrigin: TVPoint;
    fMinBound: TVPoint;
    fMaxBound: TVPoint;
    procedure AddSegment(segment: TVSegment);
  protected
    procedure MoveToIntern(x, y: integer);
    procedure LineToIntern(x, y: integer);
    procedure CurveToIntern;
    procedure BeizerToIntern;
    procedure CloseIntern;
  public
    constructor Create(originX, originY: integer);
    destructor Destroy; override;
    property MinBound: TVPoint read fMinBound;
    property MaxBound: TVPoint read fMaxBound;
    property Segments: TVSegmentsArray read fSegments;
    function GetBounds: TVRect;
    function GetOrigin: TVPoint;
  end;

type

  { TVLine2DShape }

  TVLine2DShape = class(TVShape)
  public
    constructor Create(x0, y0, x1, y1: integer);
  end;

  { TVPolygone2DShape }

  TVPolygone2DShape = class(TVShape)
  public
    procedure MoveTo(x, y: integer);
    procedure LineTo(x, y: integer);
  end;

  { TVRectangle }

  TVRectangleShape = class(TVShape)
  public
    constructor Create(x, y, Width, Height: integer);
  end;

  { TVCircleShape }

  TVCircleShape = class(TVShape)
    private
      fRadius: Integer;
    public
      constructor Create(x, y, R: integer);
      property Radius: Integer read fRadius;
  end;

implementation

procedure Swap(var x, y: integer);
var
  t: integer;
begin
  t := x;
  x := y;
  y := t;
end;

{ TVSegment }

function TVSegment.GetBounds: TVRect;
begin
  Result.x := fMinBound.x;
  Result.y := fMinBound.y;
  Result.Width := fMaxBound.x - fMinBound.x + 1;
  Result.Height := fMaxBound.y - fMinBound.y + 1;
end;

{ TVSegmentLine2D }

constructor TVSegmentLine2D.Create(x0, y0, x1, y1: integer);
begin
  fStartPos.x := x0;
  fStartPos.y := y0;
  fEndPos.x := x1;
  fEndPos.y := y1;

  if x0 < x1 then
  begin
    fMinBound.x := x0;
    fMaxBound.x := x1;
  end
  else
  begin
    fMinBound.x := x1;
    fMaxBound.x := x0;
  end;

  if y0 < y1 then
  begin
    fMinBound.y := y0;
    fMinBound.y := y1;
  end
  else
  begin
    fMinBound.y := y1;
    fMaxBound.y := y0;
  end;

end;

{ TVSegmentCircle }

constructor TVSegmentCircle.Create(x, y, R: integer);
begin
  fMinBound.x:=x-R;
  fMinBound.y:=y-R;
  fMaxBound.x:=x+R+2;
  fMaxBound.y:=y+R+2;
  fRadius:=R;
end;

{ TVShape }

constructor TVShape.Create(originX, originY: integer);
begin
  fOrigin.x:=originX;
  fOrigin.y:=originY;
  SetLength(fSegments, 0);
end;

destructor TVShape.Destroy;
var
  i: integer;
begin
  for i := Low(fSegments) to High(fSegments) do
  begin
    fSegments[i].Free;
  end;

  fSegments := nil;
  inherited Destroy;
end;

function TVShape.GetBounds: TVRect;
begin
  Result.x := fMinBound.x;
  Result.y := fMinBound.y;
  Result.Width := fMaxBound.x - fMinBound.x + 1;
  Result.Height := fMaxBound.y - fMinBound.y + 1;
end;

function TVShape.GetOrigin: TVPoint;
begin
  Result:=fOrigin;
end;

procedure TVShape.AddSegment(segment: TVSegment);
var
  ln: integer;
begin
  ln := Length(fSegments);
  SetLength(fSegments, ln + 1);
  fSegments[ln] := segment;
  if ln = 0 then
  begin
    fMinBound.x := segment.MinBound.x;
    fMaxBound.x := segment.MaxBound.x;
    fMinBound.y := segment.MinBound.y;
    fMaxBound.y := segment.MaxBound.y;
  end
  else
  begin

    if segment.MinBound.x < fMinBound.x then
      fMinBound.x := segment.MinBound.x;
    if segment.MaxBound.x > MaxBound.x then
      fMaxBound.x := segment.MaxBound.x;
    if segment.MinBound.y < fMinBound.y then
      fMinBound.y := segment.MinBound.y;
    if segment.MaxBound.y > MaxBound.y then
      fMaxBound.y := segment.MaxBound.y;
  end;

end;

procedure TVShape.MoveToIntern(x, y: integer);
begin
  fCursorPos.x := x;
  fCursorPos.y := y;
end;

procedure TVShape.LineToIntern(x, y: integer);
var
  seg: TVSegmentLine2D;
begin
  seg := TVSegmentLine2D.Create(fCursorPos.x, fCursorPos.y, x, y);
  AddSegment(seg);
  MoveToIntern(x, y);
end;

procedure TVShape.CurveToIntern;
begin

end;

procedure TVShape.BeizerToIntern;
begin

end;

procedure TVShape.CloseIntern;
begin

end;

{ TVLine2DShape }

constructor TVLine2DShape.Create(x0, y0, x1, y1: integer);
begin
  inherited Create(x0, y0);
  MoveToIntern(x0, y0);
  LineToIntern(x1, y1);
end;

{ TVPolyLine2DShape }

procedure TVPolygone2DShape.MoveTo(x, y: integer);
begin
  MoveToIntern(x, y);
end;

procedure TVPolygone2DShape.LineTo(x, y: integer);
begin
  LineToIntern(x, y);
end;

{ TVRectangle }

constructor TVRectangleShape.Create(x, y, Width, Height: integer);
begin
  inherited Create(x,y);
  MoveToIntern(x, y);
  LineToIntern(x + Width - 1, y);
  LineToIntern(x + Width - 1, y + Height - 1);
  LineToIntern(x, y + Height - 1);
  LineToIntern(x, y);
end;

{ TVCircleShape }

constructor TVCircleShape.Create(x, y, R: integer);
var seg: TVSegmentCircle;
begin
  inherited Create(x,y);
  seg:=TVSegmentCircle.Create(x,y,R);
  AddSegment(seg);
end;

end.
