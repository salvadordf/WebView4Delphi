program AddHostObject;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  AddHostObject_TLB in 'AddHostObject_TLB.pas',
  uSampleHostObjectClass in 'uSampleHostObjectClass.pas' {SampleHostObjectClass: CoClass};

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
