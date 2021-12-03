program MDIBrowser;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uChildForm in 'uChildForm.pas' {MDIChild};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
