unit uWVLibFunctions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  {$IFDEF FPC}
  Windows,
  {$ELSE}
  WinApi.Windows,
  {$ENDIF}
  uWVTypeLibrary;

var
  // Exported functions in WebView2Loader.dll
  // https://docs.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.1020.30
  CompareBrowserVersions                       : function(version1, version2: LPCWSTR; result: PInteger): HRESULT; stdcall;
  CreateCoreWebView2Environment                : function(const environmentCreatedHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
  CreateCoreWebView2EnvironmentWithOptions     : function(browserExecutableFolder, userDataFolder: LPCWSTR; const environmentOptions: ICoreWebView2EnvironmentOptions; const environmentCreatedHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
  GetAvailableCoreWebView2BrowserVersionString : function(browserExecutableFolder: LPCWSTR; versionInfo: PLPWSTR): HRESULT; stdcall;

implementation

end.
