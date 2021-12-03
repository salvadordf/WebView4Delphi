program SimpleBrowser;

{$MODE Delphi}

uses
  Forms, Interfaces,
  uSimpleBrowser in 'uSimpleBrowser.pas' {MainForm};

{.$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
