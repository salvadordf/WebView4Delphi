program FMXTabbedBrowser;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uBrowserTab in 'uBrowserTab.pas',
  uBrowserFrame in 'uBrowserFrame.pas' {BrowserFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
