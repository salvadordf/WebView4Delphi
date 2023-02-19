program CustomSchemeBrowser;

uses
  Vcl.Forms,
  uCustomSchemeBrowser in 'uCustomSchemeBrowser.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
