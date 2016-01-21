unit Vader.Graphics.Shapes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TVPoint = packed record
    x,y: integer;
  end;

  { TVShape }

  TVShape = class
  private
    fPoints: array of TVPoint;
  protected
    procedure MoveTo(x, y: integer);
    procedure LineTo(x, y: integer);
    procedure CurveTo;
    procedure BeizerTo;
    procedure Close;
  public
    constructor Create;
    destructor Destroy; override;
  end;

type
  TVLine2DShape = class(TVShape)

  end;

type
  TVRectangleShape = class(TVShape)
  end;

implementation

{ TVShape }

constructor TVShape.Create;
begin
end;

destructor TVShape.Destroy;
begin
  fPoints := nil;
  inherited Destroy;
end;

procedure TVShape.MoveTo(x, y: integer);
begin

end;

procedure TVShape.LineTo(x, y: integer);
begin

end;

procedure TVShape.CurveTo;
begin

end;

procedure TVShape.BeizerTo;
begin

end;

procedure TVShape.Close;
begin

end;

end.
