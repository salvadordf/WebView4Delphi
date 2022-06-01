unit WebView4DelphiFMX_register;

{$R res\webview4delphi.dcr}

interface

procedure Register;

implementation

uses
  System.Classes, uWVFMXBrowser;

procedure Register;
begin
  RegisterComponents('WebView4Delphi', [TWVFMXBrowser]);
end;

end.
