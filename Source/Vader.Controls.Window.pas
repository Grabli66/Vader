unit Vader.Controls.Window;

{$mode objfpc}{$H+}

interface

{$IFDEF WINDOWS}
uses Vader.Windows.Controls.Window;
{$ENDIF}

{$IFDEF LINUX}
uses Vader.Linux.Controls.Window;
{$ENDIF}

type TVWindow = TVPlatformWindow;

implementation

end.

