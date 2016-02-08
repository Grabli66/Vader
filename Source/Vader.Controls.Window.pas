unit Vader.Controls.Window;

{$mode objfpc}{$H+}

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

