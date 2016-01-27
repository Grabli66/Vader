unit Vader.Graphics.Plot;

{$mode objfpc}{$H+}

interface

uses
  Vader.System,
  Vader.Graphics.Textures;

type

  TVLinePlotSettings = packed record
    x0, y0: double;                    // Start position
    x1, y1: double;                    // End position
    isAntialiased: boolean;           // Draw with antialiasing
    Width: double;                    // Width of line
  end;

  TVCubicCurvePlotSettings = packed record

  end;

  TVQuadricCurveSettings = packed record

  end;

  TVCirclePlotSettings = packed record

  end;

  TVEllipsePlotSettings = packed record

  end;

  TVRectanglePlotSettings = packed record

  end;

  { TVPlotter }
  { Class with plot algorithms }

  TVPlotter = class(TVaderObject)
  public
    constructor Create;
    procedure PlotLine(texture: IPixelSurface; linePlotSettings: TVLinePlotSettings);
    procedure PlotCubicCurve(texture: IPixelSurface; cubicCurvePlotSettings: TVCubicCurvePlotSettings);
    procedure PlotQuadricCurve(texture: IPixelSurface; quadricCurvePlotSettings: TVQuadricCurveSettings);
    procedure PlotCircle(texture: IPixelSurface; circlePlotSettings: TVCirclePlotSettings);
    procedure PlotEllipse(texture: IPixelSurface; ellipsePlotSettings: TVEllipsePlotSettings);
    procedure PlotRectangle(texture: IPixelSurface; rectanglePlotSettings: TVRectanglePlotSettings);
  end;

implementation

{ TVPlotter }

constructor TVPlotter.Create;
begin
  inherited Create;
end;

procedure TVPlotter.PlotLine(texture: IPixelSurface;
  linePlotSettings: TVLinePlotSettings);
begin

end;

procedure TVPlotter.PlotCubicCurve(texture: IPixelSurface;
  cubicCurvePlotSettings: TVCubicCurvePlotSettings);
begin

end;

procedure TVPlotter.PlotQuadricCurve(texture: IPixelSurface;
  quadricCurvePlotSettings: TVQuadricCurveSettings);
begin

end;

procedure TVPlotter.PlotCircle(texture: IPixelSurface;
  circlePlotSettings: TVCirclePlotSettings);
begin

end;

procedure TVPlotter.PlotEllipse(texture: IPixelSurface;
  ellipsePlotSettings: TVEllipsePlotSettings);
begin

end;

procedure TVPlotter.PlotRectangle(texture: IPixelSurface;
  rectanglePlotSettings: TVRectanglePlotSettings);
begin

end;

end.

