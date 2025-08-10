program KioskBrowser;

{$MODE Delphi}

uses
  Forms, Interfaces,
  uKioskBrowser in 'uKioskBrowser.pas' {MainForm},
  uVirtualTouchKeyboard in 'uVirtualTouchKeyboard.pas';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
