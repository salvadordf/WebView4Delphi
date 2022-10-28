program SimpleBrowser_D7;

{$I webview2.inc}

uses
  {$IFDEF DELPHI16_UP}
  Vcl.Forms,
  {$ELSE}
  Forms,
  {$ENDIF}
  uSimpleBrowser in 'uSimpleBrowser.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF DELPHI11_UP}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
