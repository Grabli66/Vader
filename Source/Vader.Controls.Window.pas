unit Vader.Controls.Window;

{$I Vader.inc}

interface

{$IFDEF WINDOWS}
uses Vader.Platform.Windows.Controls.Window;
{$ENDIF}

{$IFDEF LINUX}
uses Vader.Platform.Linux.Controls.Window;
{$ENDIF}

type TVWindow = TVPlatformWindowImpl;

implementation

end.

