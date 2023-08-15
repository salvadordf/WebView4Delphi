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
  /// This method is for anyone want to compare version correctly to determine
  /// which version is newer, older or same.  Use it to determine whether
  /// to use webview2 or certain feature based upon version.  Sets the value of
  /// result to `-1`, `0` or `1` if `version1` is less than, equal or greater
  /// than `version2` respectively.  Returns `E_INVALIDARG` if it fails to parse
  /// any of the version strings or any input parameter is `null`.  Directly use
  /// the `versionInfo` obtained from
  /// `GetAvailableCoreWebView2BrowserVersionString` with input, channel
  /// information is ignored.
  /// </summary>
  CompareBrowserVersions                       : function(version1, version2: LPCWSTR; result: PInteger): HRESULT; stdcall;
  /// <summary>
  /// Creates an evergreen WebView2 Environment using the installed WebView2
  /// Runtime version.  This is equivalent to running
  /// `CreateCoreWebView2EnvironmentWithOptions` with `nullptr` for
  /// `browserExecutableFolder`, `userDataFolder`, `additionalBrowserArguments`.
  /// For more information, navigate to
  /// `CreateCoreWebView2EnvironmentWithOptions`.
  /// </summary>
  CreateCoreWebView2Environment                : function(const environmentCreatedHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
  /// <summary>
  /// DLL export to create a WebView2 environment with a custom version of
  /// WebView2 Runtime, user data folder, and with or without additional options.
  ///
  /// When WebView2 experimental APIs are used, make sure to provide a valid `environmentOptions`
  /// so that WebView2 runtime knows which version of the SDK that the app is using. Otherwise,
  /// WebView2 runtime assumes that the version of the SDK being used is the latest
  /// version known to it, which might not be the version of the SDK being used.
  /// This wrong SDK version assumption could result in some experimental APIs not being available.
  ///
  /// The WebView2 environment and all other WebView2 objects are single threaded
  ///  and have dependencies on Windows components that require COM to be
  /// initialized for a single-threaded apartment.  The app is expected to run
  /// `CoInitializeEx` before running `CreateCoreWebView2EnvironmentWithOptions`.
  ///
  /// ```text
  /// CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
  /// ```
  ///
  /// If `CoInitializeEx` did not run or previously ran with
  /// `COINIT_MULTITHREADED`, `CreateCoreWebView2EnvironmentWithOptions` fails
  /// with one of the following errors.
  ///
  /// ```text
  /// CO_E_NOTINITIALIZED -  if CoInitializeEx was not called
  /// RPC_E_CHANGED_MODE  -  if CoInitializeEx was previously called with
  ///                        COINIT_MULTITHREADED
  /// ```
  ///
  ///
  /// Use `browserExecutableFolder` to specify whether WebView2 controls use a
  /// fixed or installed version of the WebView2 Runtime that exists on a user
  /// machine.  To use a fixed version of the WebView2 Runtime, pass the
  /// folder path that contains the fixed version of the WebView2 Runtime to
  /// `browserExecutableFolder`. BrowserExecutableFolder supports both relative
  ///  (to the application's executable) and absolute files paths.
  /// To create WebView2 controls that use the
  /// installed version of the WebView2 Runtime that exists on user machines,
  /// pass a `null` or empty string to `browserExecutableFolder`.  In this
  /// scenario, the API tries to find a compatible version of the WebView2
  /// Runtime that is installed on the user machine (first at the machine level,
  ///  and then per user) using the selected channel preference.  The path of
  /// fixed version of the WebView2 Runtime should not contain
  /// `\Edge\Application\`. When such a path is used, the API fails
  /// with `HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)`.
  ///
  /// The default channel search order is the WebView2 Runtime, Beta, Dev, and
  /// Canary.  When an override `WEBVIEW2_RELEASE_CHANNEL_PREFERENCE` environment
  ///  variable or applicable `releaseChannelPreference` registry value is set to
  ///  `1`, the channel search order is reversed.
  ///
  /// You may specify the `userDataFolder` to change the default user data
  /// folder location for WebView2.  The path is either an absolute file path
  /// or a relative file path that is interpreted as relative to the compiled
  /// code for the current process.  For UWP apps, the default user data
  /// folder is the app data folder for the package.  For non-UWP apps, the
  /// default user data (`{Executable File Name}.WebView2`) folder is
  /// created in the same directory next to the compiled code for the app.
  /// WebView2 creation fails if the compiled code is running in a directory in
  /// which the process does not have permission to create a new directory.  The
  /// app is responsible to clean up the associated user data folder when it
  /// is done.
  ///
  /// \> [!NOTE]\n\> As a browser process may be shared among WebViews, WebView creation fails
  /// with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if the specified options
  /// does not match the options of the WebViews that are currently running in
  /// the shared browser process.
  ///
  /// `environmentCreatedHandler` is the handler result to the async operation
  /// that contains the `WebView2Environment` that was created.
  ///
  /// The `browserExecutableFolder`, `userDataFolder` and
  /// `additionalBrowserArguments` of the `environmentOptions` may be overridden
  /// by values either specified in environment variables or in the registry.
  ///
  /// When creating a `WebView2Environment` the following environment variables
  /// are verified.
  ///
  /// ```text
  /// WEBVIEW2_BROWSER_EXECUTABLE_FOLDER
  /// WEBVIEW2_USER_DATA_FOLDER
  /// WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS
  /// WEBVIEW2_RELEASE_CHANNEL_PREFERENCE
  /// ```
  ///
  /// If you find an override environment variable, use the
  /// `browserExecutableFolder` and `userDataFolder` values as replacements for
  /// the corresponding values in `CreateCoreWebView2EnvironmentWithOptions`
  /// parameters.  If `additionalBrowserArguments` is specified in environment
  /// variable or in the registry, it is appended to the corresponding values in
  /// `CreateCoreWebView2EnvironmentWithOptions` parameters.
  ///
  /// While not strictly overrides, additional environment variables may be set.
  ///
  /// ```text
  /// WEBVIEW2_WAIT_FOR_SCRIPT_DEBUGGER
  /// ```
  ///
  /// When found with a non-empty value, this indicates that the WebView is being
  ///  launched under a script debugger.  In this case, the WebView issues a
  /// `Page.waitForDebugger` CDP command that runs the script inside the WebView
  /// to pause on launch, until a debugger issues a corresponding
  /// `Runtime.runIfWaitingForDebugger` CDP command to resume the runtime.
  ///
  /// \> [!NOTE]\n\> The following environment variable does not have a registry key
  /// equivalent: `WEBVIEW2_WAIT_FOR_SCRIPT_DEBUGGER`.
  ///
  /// When found with a non-empty value, it indicates that the WebView is being
  /// launched under a script debugger that also supports host apps that use
  /// multiple WebViews.  The value is used as the identifier for a named pipe
  /// that is opened and written to when a new WebView is created by the host
  /// app.  The payload should match the payload of the `remote-debugging-port`
  /// JSON target and an external debugger may use it to attach to a specific
  /// WebView instance.  The format of the pipe created by the debugger should be
  /// `\\.\pipe\WebView2\Debugger\{app_name}\{pipe_name}`, where the following
  /// are true.
  ///
  /// *   `{app_name}` is the host app exe file name, for example,
  ///     `WebView2Example.exe`
  /// *   `{pipe_name}` is the value set for `WEBVIEW2_PIPE_FOR_SCRIPT_DEBUGGER`
  ///
  /// To enable debugging of the targets identified by the JSON, you must set the
  ///  `WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS` environment variable to send
  /// `--remote-debugging-port={port_num}`, where the following is true.
  ///
  /// *   `{port_num}` is the port on which the CDP server binds.
  ///
  /// \> [!WARNING]\n\> If you set both `WEBVIEW2_PIPE_FOR_SCRIPT_DEBUGGER` and
  /// `WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS` environment variables, the
  /// WebViews hosted in your app and associated contents may exposed to 3rd
  /// party apps such as debuggers.
  ///
  /// \> [!NOTE]\n\> The following environment variable does not have a registry key
  /// equivalent: `WEBVIEW2_PIPE_FOR_SCRIPT_DEBUGGER`.
  ///
  /// If none of those environment variables exist, then the registry is examined
  /// next.  The following registry values are verified.
  ///
  /// ```text
  /// [{Root}]\Software\Policies\Microsoft\Edge\WebView2\BrowserExecutableFolder
  /// "{AppId}"=""
  ///
  /// [{Root}]\Software\Policies\Microsoft\Edge\WebView2\ReleaseChannelPreference
  /// "{AppId}"=""
  ///
  /// [{Root}]\Software\Policies\Microsoft\Edge\WebView2\AdditionalBrowserArguments
  /// "{AppId}"=""
  ///
  /// [{Root}]\Software\Policies\Microsoft\Edge\WebView2\UserDataFolder
  /// "{AppId}"=""
  /// ```
  ///
  /// Use a group policy under **Administrative Templates** >
  /// **Microsoft Edge WebView2** to configure `browserExecutableFolder` and
  /// `releaseChannelPreference`.
  ///
  /// In the unlikely scenario where some instances of WebView are open during a
  /// browser update, the deletion of the previous WebView2 Runtime may be
  /// blocked.  To avoid running out of disk space, a new WebView creation fails
  /// with `HRESULT_FROM_WIN32(ERROR_DISK_FULL)` if it detects that too many
  /// previous WebView2 Runtime versions exist.
  ///
  /// The default maximum number of WebView2 Runtime versions allowed is `20`.
  /// To override the maximum number of the previous WebView2 Runtime versions
  /// allowed, set the value of the following environment variable.
  ///
  /// ```text
  /// COREWEBVIEW2_MAX_INSTANCES
  /// ```
  ///
  /// If the Webview depends upon an installed WebView2 Runtime version and it is
  /// uninstalled, any subsequent creation fails with
  /// `HRESULT_FROM_WIN32(ERROR_PRODUCT_UNINSTALLED)`.
  ///
  /// First verify with Root as `HKLM` and then `HKCU`.  `AppId` is first set to
  /// the Application User Model ID of the process, then if no corresponding
  /// registry key, the `AppId` is set to the compiled code name of the process,
  /// or if that is not a registry key then `*`.  If an override registry key is
  /// found, use the `browserExecutableFolder` and `userDataFolder` registry
  /// values as replacements and append `additionalBrowserArguments` registry
  /// values for the corresponding values in
  /// `CreateCoreWebView2EnvironmentWithOptions` parameters.
  ///
  /// The following summarizes the possible error values that can be returned from
  /// `CreateCoreWebView2EnvironmentWithOptions` and a description of why these
  /// errors occur.
  ///
  /// Error value                                     | Description
  /// ----------------------------------------------- | --------------------------
  /// `CO_E_NOTINITIALIZED`                           | CoInitializeEx was not called.
  /// `RPC_E_CHANGED_MODE`                            | CoInitializeEx was previously called with COINIT_MULTITHREADED.
  /// `HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)`       | *\\Edge\\Application* path used in browserExecutableFolder.
  /// `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`       | Specified options do not match the options of the WebViews that are currently running in the shared browser process.
  /// `HRESULT_FROM_WIN32(ERROR_DISK_FULL)`           | In the unlikely scenario where some instances of WebView are open during a browser update, the deletion of the previous WebView2 Runtime may be blocked. To avoid running out of disk space, a new WebView creation fails with `HRESULT_FROM_WIN32(ERROR_DISK_FULL)` if it detects that too many previous WebView2 Runtime versions exist.
  /// `HRESULT_FROM_WIN32(ERROR_PRODUCT_UNINSTALLED)` | If the Webview depends upon an installed WebView2 Runtime version and it is uninstalled.
  /// `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)`      | Could not find Edge installation.
  /// `HRESULT_FROM_WIN32(ERROR_FILE_EXISTS)`         | User data folder cannot be created because a file with the same name already exists.
  /// `E_ACCESSDENIED`                                | Unable to create user data folder, Access Denied.
  /// `E_FAIL`                                        | Edge runtime unable to start.
  /// </summary>
  CreateCoreWebView2EnvironmentWithOptions     : function(browserExecutableFolder, userDataFolder: LPCWSTR; const environmentOptions: ICoreWebView2EnvironmentOptions; const environmentCreatedHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
  /// <summary>
  /// Get the browser version info including channel name if it is not the
  /// WebView2 Runtime.  Channel names are Beta, Dev, and Canary.
  /// If an override exists for the `browserExecutableFolder` or the channel
  /// preference, the override is used.  If an override is not specified, then
  /// the parameter value passed to
  /// `GetAvailableCoreWebView2BrowserVersionString` is used.
  ///
  /// The caller must free the returned string with `CoTaskMemFree`.  See
  /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
  /// </summary>
  GetAvailableCoreWebView2BrowserVersionString : function(browserExecutableFolder: LPCWSTR; versionInfo: PLPWSTR): HRESULT; stdcall;

implementation

end.
