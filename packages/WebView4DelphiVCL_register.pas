unit WebView4DelphiVCL_register;

{$R res\webview4delphi.dcr}

interface

procedure Register;

implementation

uses
  System.Classes, uWVBrowser, uWVWindowParent;

procedure Register;
begin
  RegisterComponents('WebView4Delphi', [TWVBrowser]);
  RegisterComponents('WebView4Delphi', [TWVWindowParent]);
end;

end.
