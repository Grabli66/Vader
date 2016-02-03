unit Vader.Application.Application;

{$mode objfpc}{$H+}

interface

{$IFDEF WINDOWS}
uses Vader.Windows.Application.PlatformApplication;
{$ENDIF}

{$IFDEF LINUX}
uses Vader.Linux.Application.PlatformApplication;
{$ENDIF}

type TVApplication = TVPlatformApplicationImpl;

implementation

end.

