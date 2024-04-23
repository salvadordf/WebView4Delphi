unit uWVLibFunctions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  WinApi.Windows,
  {$ELSE}
  Windows,
  {$ENDIF}
  uWVTypeLibrary;

var
  {*
    Exported functions in WebView2Loader.dll
    https://docs.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.1020.30
  *}

  /// <summary>
  /// <para>This method is for anyone want to compare version correctly to determine
  /// which version is newer, older or same.  Use it to determine whether
  /// to use webview2 or certain feature based upon version.</para>
  /// <para>Sets the value of result to `-1`, `0` or `1` if `version1` is less than,
  /// equal or greater than `version2` respectively.  Returns `E_INVALIDARG` if it
  /// fails to parse any of the version strings or any input parameter is `null`.</para>
  /// <para>Directly use the `versionInfo` obtained from
  /// `GetAvailableCoreWebView2BrowserVersionString` with input, channel information is ignored.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#comparebrowserversions">See the Globals article.</see></para>
  /// </remarks>
  CompareBrowserVersions                       : function(version1, version2: LPCWSTR; result: PInteger): HRESULT; stdcall;
  /// <summary>
  /// <para>Creates an evergreen WebView2 Environment using the installed WebView2
  /// Runtime version.  This is equivalent to running
  /// `CreateCoreWebView2EnvironmentWithOptions` with `nullptr` for
  /// `browserExecutableFolder`, `userDataFolder`, `additionalBrowserArguments`.</para>
  /// <para>For more information, navigate to `CreateCoreWebView2EnvironmentWithOptions`.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#createcorewebview2environment">See the Globals article.</see></para>
  /// </remarks>
  CreateCoreWebView2Environment                : function(const environmentCreatedHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
  /// <summary>
  /// DLL export to create a WebView2 environment with a custom version of
  /// WebView2 Runtime, user data folder, and with or without additional options.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#createcorewebview2environmentwithoptions">See the Globals article.</see></para>
  /// </remarks>
  CreateCoreWebView2EnvironmentWithOptions     : function(browserExecutableFolder, userDataFolder: LPCWSTR; const environmentOptions: ICoreWebView2EnvironmentOptions; const environmentCreatedHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
  /// <summary>
  /// <para>Get the browser version info including channel name if it is not the
  /// WebView2 Runtime.  Channel names are Beta, Dev, and Canary.</para>
  /// <para>If an override exists for the `browserExecutableFolder` or the channel
  /// preference, the override is used.  If an override is not specified, then
  /// the parameter value passed to
  /// `GetAvailableCoreWebView2BrowserVersionString` is used.</para>
  /// <para>Returns `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)` if it fails to find an
  /// installed WebView2 runtime or non-stable Microsoft Edge installation.</para>
  /// <para>The caller must free the returned string with `CoTaskMemFree`.  See
  /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#getavailablecorewebview2browserversionstring">See the Globals article.</see></para>
  /// </remarks>
  GetAvailableCoreWebView2BrowserVersionString : function(browserExecutableFolder: LPCWSTR; versionInfo: PLPWSTR): HRESULT; stdcall;
  /// <summary>
  /// <para>This function will tell you the browser version info of the release channel
  /// used when creating an environment with the same options. Browser version
  /// info includes channel name if it is not the WebView2 Runtime. Channel names
  /// are Beta, Dev, and Canary.  The format of the return string matches the format of
  /// `BrowserVersionString` on `ICoreWebView2Environment`.</para>
  /// <para>If an override exists for `browserExecutableFolder`, `releaseChannels`,
  /// or `ChannelSearchKind`, the override is used. The presence of an override
  /// can result in a different channel used than the one expected based on the
  /// environment options object. `browserExecutableFolder` takes precedence over
  /// the other options, regardless of whether or not its channel is included in
  /// the `releaseChannels`. See `CreateCoreWebView2EnvironmentWithOptions`
  /// for more details on overrides. If an override is not specified, then the
  /// parameters passed to `GetAvailableCoreWebView2BrowserVersionStringWithOptions`
  /// are used. Returns `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)` if it fails to find
  /// an installed WebView2 Runtime or non-stable Microsoft Edge installation. Use
  /// `GetAvailableCoreWebView2BrowserVersionString` to get the version info without
  /// the environment options.</para>
  /// <para>The caller must free the returned string with `CoTaskMemFree`.  See
  /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#getavailablecorewebview2browserversionstringwithoptions">See the Globals article.</see></para>
  /// </remarks>
  GetAvailableCoreWebView2BrowserVersionStringWithOptions : function(browserExecutableFolder: LPCWSTR; const environmentOptions: ICoreWebView2EnvironmentOptions; versionInfo: PLPWSTR): HRESULT; stdcall;

implementation

end.
