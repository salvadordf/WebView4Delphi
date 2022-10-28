unit WebView4DelphiVCL_register;

{$R res\webview4delphi.dcr}

{$I webview2.inc}

interface

procedure Register;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.Classes,
  {$ELSE}
  Classes,
  {$ENDIF}
  uWVBrowser, uWVWindowParent;

procedure Register;
begin
  RegisterComponents('WebView4Delphi', [TWVBrowser]);
  RegisterComponents('WebView4Delphi', [TWVWindowParent]);
end;

end.
