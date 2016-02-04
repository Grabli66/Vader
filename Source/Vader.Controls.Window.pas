unit Vader.Controls.Window;

{$mode objfpc}{$H+}

interface

{$IFDEF WINDOWS}
uses Vader.Platform.Windows.Controls.Window;
{$ENDIF}

{$IFDEF LINUX}
uses Vader.Linux.Controls.Window;
{$ENDIF}

type TVWindow = TVPlatformWindowImpl;

implementation

end.

