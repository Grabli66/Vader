unit Vader.Application;

{$mode objfpc}{$H+}

interface

{$IFDEF WINDOWS}
uses Vader.Windows.Application;
{$ENDIF}

{$IFDEF LINUX}
uses Vader.Linux.Application;
{$ENDIF}

type TVApplication = TVPlatformApplication;

implementation

end.

