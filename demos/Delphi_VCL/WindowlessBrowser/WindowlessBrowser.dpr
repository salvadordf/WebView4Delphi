program WindowlessBrowser;

uses
  Vcl.Forms,
  uWindowlessBrowser in 'uWindowlessBrowser.pas' {MainForm},
  uDirectCompositionHost in 'uDirectCompositionHost.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
