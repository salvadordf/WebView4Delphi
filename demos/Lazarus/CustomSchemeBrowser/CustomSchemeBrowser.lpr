program CustomSchemeBrowser;

{$MODE Delphi}

uses
  Forms, Interfaces,
  uCustomSchemeBrowser in 'uCustomSchemeBrowser.pas' {MainForm};

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
