program NavigateWithWebResourceRequestBrowser;

{$MODE Delphi}

uses
  Forms, Interfaces,
  uNavigateWithWebResourceRequestBrowser in 'uNavigateWithWebResourceRequestBrowser.pas' {MainForm};

{.$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
