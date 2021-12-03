unit WebView4Delphi_register;

{$R res\webview4delphi.dcr}

interface

procedure Register;

implementation

uses
  System.Classes, uWVBrowser, uWVWindowParent, uWVFMXBrowser;

procedure Register;
begin
  RegisterComponents('WebView4Delphi', [TWVBrowser]);
  RegisterComponents('WebView4Delphi', [TWVWindowParent]);
  RegisterComponents('WebView4Delphi', [TWVFMXBrowser]);
end;

end.
