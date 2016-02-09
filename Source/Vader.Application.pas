unit Vader.Application;

{$I Vader.inc}

interface

{$IFDEF WINDOWS}
uses Vader.Platform.Windows.Application;
{$ENDIF}

{$IFDEF LINUX}
uses Vader.Platform.Linux.Application;
{$ENDIF}

type TVApplication = TVPlatformApplicationImpl;

implementation

end.

