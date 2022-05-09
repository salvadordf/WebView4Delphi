program KioskBrowser;

uses
  Vcl.Forms,
  uKioskBrowser in 'uKioskBrowser.pas' {MainForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
