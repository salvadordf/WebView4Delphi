program MobileBrowser;

{$I ..\..\..\source\webview2.inc}

uses
  Vcl.Forms,
  uMobileBrowser in 'uMobileBrowser.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
