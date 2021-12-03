program ClientCertsBrowser;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uChildForm in 'uChildForm.pas' {ChildForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TChildForm, ChildForm);
  Application.Run;
end.
