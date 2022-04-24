program SubscribeToDevToolsProtocolEventBrowser;

uses
  Vcl.Forms,
  uSubscribeToDevToolsProtocolEventBrowser in 'uSubscribeToDevToolsProtocolEventBrowser.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
