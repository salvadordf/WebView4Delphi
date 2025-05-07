unit uWVLoader;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  WinApi.Windows, System.Classes, System.SysUtils, WinApi.ActiveX, System.Win.Registry, Winapi.ShlObj, System.Math,
  {$ELSE}
  Windows, Classes, SysUtils, ActiveX, Registry, ShlObj, Math, Dialogs,
  {$ENDIF}
  uWVLibFunctions, uWVInterfaces, uWVTypeLibrary, uWVTypes, uWVEvents, uWVCoreWebView2Environment;

type
  TWVProxySettings = class;
  /// <summary>
  /// Class used to simplify the WebView2 initialization and destruction.
  /// </summary>
  TWVLoader = class(TComponent, IWVLoaderEvents)
    protected
      FCoreWebView2Environment                : TCoreWebView2Environment;
      FOnEnvironmentCreated                   : TLoaderNotifyEvent;
      FOnNewBrowserVersionAvailable           : TLoaderNewBrowserVersionAvailableEvent;
      FOnInitializationError                  : TLoaderNotifyEvent;
      FOnBrowserProcessExited                 : TLoaderBrowserProcessExitedEvent;
      FOnProcessInfosChanged                  : TLoaderProcessInfosChangedEvent;
      FOnGetCustomSchemes                     : TLoaderGetCustomSchemesEvent;
      FLibHandle                              : THandle;
      FErrorLog                               : TStringList;
      FError                                  : int64;
      FBrowserExecPath                        : wvstring;
      FUserDataFolder                         : wvstring;
      FStatus                                 : TWV2LoaderStatus;
      FSetCurrentDir                          : boolean;
      FCheckFiles                             : boolean;
      FShowMessageDlg                         : boolean;
      FInitCOMLibrary                         : boolean;
      FLocalCOMInitMade                       : boolean;
      FDeviceScaleFactor                      : single;
      FForcedDeviceScaleFactor                : single;
      FReRaiseExceptions                      : boolean;
      FLoaderDllPath                          : wvstring;
      FUseInternalLoader                      : boolean;
      FAllowOldRuntime                        : boolean;

      // Fields used to create the environment
      FAdditionalBrowserArguments             : wvstring;
      FLanguage                               : wvstring;
      FTargetCompatibleBrowserVersion         : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount : boolean;
      FExclusiveUserDataFolderAccess          : boolean;
      FCustomCrashReportingEnabled            : boolean;
      FEnableTrackingPrevention               : boolean;
      FAreBrowserExtensionsEnabled            : boolean;
      FChannelSearchKind                      : TWVChannelSearchKind;
      FReleaseChannels                        : TWVReleaseChannels;
      FScrollBarStyle                         : TWVScrollBarStyle;

      // Fields used to set command line switches
      FEnableGPU                              : boolean;
      FEnableFeatures                         : wvstring;
      FDisableFeatures                        : wvstring;
      FEnableBlinkFeatures                    : wvstring;
      FDisableBlinkFeatures                   : wvstring;
      FBlinkSettings                          : wvstring;
      FForceFieldTrials                       : wvstring;
      FForceFieldTrialParams                  : wvstring;
      FSmartScreenProtectionEnabled           : boolean;
      FAllowInsecureLocalhost                 : boolean;
      FDisableWebSecurity                     : boolean;
      FTouchEvents                            : TWVState;
      FHyperlinkAuditing                      : boolean;
      FAutoplayPolicy                         : TWVAutoplayPolicy;
      FMuteAudio                              : boolean;
      FDefaultEncoding                        : wvstring;
      FKioskPrinting                          : boolean;
      FProxySettings                          : TWVProxySettings;
      FAllowFileAccessFromFiles               : boolean;
      FAllowRunningInsecureContent            : boolean;
      FDisableBackgroundNetworking            : boolean;
      FRemoteDebuggingPort                    : integer;
      FRemoteAllowOrigins                     : wvstring;
      FDebugLog                               : TWV2DebugLog;
      FDebugLogLevel                          : TWV2DebugLogLevel;
      FJavaScriptFlags                        : wvstring;
      FDisableEdgePitchNotification           : boolean;
      FTreatInsecureOriginAsSecure            : wvstring;
      FOpenOfficeDocumentsInWebViewer         : boolean;
      FMicrosoftSignIn                        : boolean;
      FPostQuantumKyber                       : TWVState;
      FUserAgent                              : wvstring;

      FAutoAcceptCamAndMicCapture             : boolean;

      function  GetInternalAvailableBrowserVersion : wvstring;
      function  GetAvailableBrowserVersion : wvstring;
      function  GetAvailableBrowserVersionWithOptions : wvstring;
      function  GetInitialized : boolean;
      function  GetInitializationError : boolean;
      function  GetEnvironmentIsInitialized : boolean;
      function  GetDefaultUserDataPath : string;
      function  GetEnvironment : ICoreWebView2Environment;
      function  GetProcessInfos : ICoreWebView2ProcessInfoCollection;
      function  GetSupportsCompositionController : boolean;
      function  GetSupportsControllerOptions : boolean;
      function  GetCustomCommandLineSwitches : wvstring;
      function  GetInstalledRuntimeVersion : wvstring;
      function  GetErrorMessage : wvstring;
      function  GetFailureReportFolderPath : wvstring;

      function  CreateEnvironment : boolean;
      procedure DestroyEnvironment;

      function  GetFileVersion(const aFile : wvstring; var aVersionInfo : TFileVersionInfo) : boolean;
      function  GetExtendedFileVersion(const aFileName : wvstring) : uint64;
      function  LoadLibProcedures : boolean;
      function  LoadWebView2Library : boolean;
      procedure UnLoadWebView2Library;
      function  CheckWV2Library : boolean;
      function  CheckBrowserExecPath : boolean;
      function  CheckWebViewRuntimeVersion : boolean;
      function  CheckWV2DLL : boolean;
      function  CheckFileVersion(const aFile : wvstring; aMajor, aMinor, aRelease, aBuild : word) : boolean;
      function  GetDLLHeaderMachine(const aDLLFile : string; var aMachine : integer) : boolean;
      function  Is32BitProcess : boolean;
      function  CheckInstalledRuntimeRegEntry(aLocalMachine : boolean; const aPath : string; var aVersion : wvstring) : boolean;
      procedure ShowErrorMessageDlg(const aError : wvstring);
      function  SearchInstalledProgram(const aDisplayName, aPublisher : string) : boolean;
      function  SearchInstalledProgramInPath(const aRegPath, aDisplayName, aPublisher : string; aLocalMachine : boolean) : boolean;

      procedure doOnInitializationError; virtual;
      procedure doOnEnvironmentCreated; virtual;
      procedure doOnNewBrowserVersionAvailable(const aEnvironment: ICoreWebView2Environment); virtual;
      procedure doOnBrowserProcessExitedEvent(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs); virtual;
      procedure doProcessInfosChangedEvent(const sender: ICoreWebView2Environment); virtual;
      procedure doOnGetCustomSchemes(var aSchemeRegistrations : TWVCustomSchemeRegistrationArray); virtual;

      function  EnvironmentCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2Environment): HRESULT;
      function  NewBrowserVersionAvailableEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;
      function  BrowserProcessExitedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs): HRESULT;
      function  ProcessInfosChangedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;
      /// <summary>
      /// Default value of the user data path.
      /// </summary>
      property  DefaultUserDataPath       : string              read GetDefaultUserDataPath;
      /// <summary>
      /// Returns true if the environment is initialized.
      /// </summary>
      property  EnvironmentIsInitialized  : boolean             read GetEnvironmentIsInitialized;

    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;
      /// <summary>
      /// This function is used to initialize WebView2.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#createcorewebview2environmentwithoptions">See the Globals article.</see></para>
      /// </remarks>
      function    StartWebView2 : boolean;
      /// <summary>
      /// This method is for anyone want to compare version correctly to determine
      /// which version is newer, older or same.Use it to determine whether
      /// to use webview2 or certain feature based upon version. Sets the value of
      /// aCompRslt to -1, 0 or 1 if aVersion1 is less than, equal or greater
      /// than aVersion2 respectively. Returns false if it fails to parse
      /// any of the version strings.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#comparebrowserversions">See the Globals article.</see></para>
      /// </remarks>
      function    CompareVersions(const aVersion1, aVersion2 : wvstring; var aCompRslt : integer): boolean;
      /// <summary>
      /// Update the DeviceScaleFactor property value with the current scale or the ForcedDeviceScaleFactor value.
      /// </summary>
      procedure   UpdateDeviceScaleFactor; virtual;
      /// <summary>
      /// Append aText to the ErrorMessage property.
      /// </summary>
      procedure   AppendErrorLog(const aText : wvstring);

      /// <summary>
      /// Represents the global WebView2 Environment.
      /// </summary>
      property Environment                            : ICoreWebView2Environment           read GetEnvironment;
      /// <summary>
      /// Returns the TWVLoader initialization status.
      /// </summary>
      property Status                                 : TWV2LoaderStatus                   read FStatus;
      /// <summary>
      /// Get the browser version info including channel name if it is not the
      /// WebView2 Runtime. Channel names are Beta, Dev, and Canary.
      /// </summary>
      property AvailableBrowserVersion                : wvstring                           read GetAvailableBrowserVersion;
      /// <summary>
      /// Get the browser version info of the release channel used when creating
      /// an environment with the same options. Channel names are Beta, Dev, and
      /// Canary.
      /// </summary>
      property AvailableBrowserVersionWithOptions     : wvstring                           read GetAvailableBrowserVersionWithOptions;
      /// <summary>
      /// Returns all the text appended to the error log with AppendErrorLog.
      /// </summary>
      property ErrorMessage                           : wvstring                           read GetErrorMessage;
      /// <summary>
      /// Returns the last initialization error code.
      /// </summary>
      property ErrorCode                              : int64                              read FError;
      /// <summary>
      ///	Used to set the current directory when the WebView2 library is loaded. This is required if the application is launched from a different application.
      /// </summary>
      property SetCurrentDir                          : boolean                            read FSetCurrentDir                           write FSetCurrentDir;
      /// <summary>
      /// Returns true if the Status is wvlsInitialized.
      /// </summary>
      property Initialized                            : boolean                            read GetInitialized;
      /// <summary>
      /// Returns true if the Status is wvlsError.
      /// </summary>
      property InitializationError                    : boolean                            read GetInitializationError;
      /// <summary>
      /// Checks if the WebView2 library is present and the DLL version.
      /// </summary>
      property CheckFiles                             : boolean                            read FCheckFiles                              write FCheckFiles;
      /// <summary>
      /// Set to true when you need to use a showmessage dialog to show the error messages.
      /// </summary>
      property ShowMessageDlg                         : boolean                            read FShowMessageDlg                          write FShowMessageDlg;
      /// <summary>
      /// Set to true to call CoInitializeEx and CoUnInitialize in TWVLoader.Create and TWVLoader.Destroy.
      /// </summary>
      property InitCOMLibrary                         : boolean                            read FInitCOMLibrary                          write FInitCOMLibrary;
      /// <summary>
      /// Custom command line switches used by TCoreWebView2EnvironmentOptions.Create to initialize WebView2.
      /// </summary>
      property CustomCommandLineSwitches              : wvstring                           read GetCustomCommandLineSwitches;
      /// <summary>
      /// Returns the device scale factor.
      /// </summary>
      property DeviceScaleFactor                      : single                             read FDeviceScaleFactor;
      /// <summary>
      /// Set to true to raise all exceptions.
      /// </summary>
      property ReRaiseExceptions                      : boolean                            read FReRaiseExceptions                       write FReRaiseExceptions;
      /// <summary>
      /// Returns the installed WebView2 runtime version.
      /// </summary>
      property InstalledRuntimeVersion                : wvstring                           read GetInstalledRuntimeVersion;
      /// <summary>
      /// Full path to WebView2Loader.dll. Leave empty to load WebView2Loader.dll from the current directory.
      /// </summary>
      property LoaderDllPath                          : wvstring                           read FLoaderDllPath                           write FLoaderDllPath;
      /// <summary>
      /// Use a WebView2Loader.dll replacement based on the OpenWebView2Loader project.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://github.com/jchv/OpenWebView2Loader">See the OpenWebView2Loader project repository at GitHub.</see></para>
      /// </remarks>
      property UseInternalLoader                      : boolean                            read FUseInternalLoader                       write FUseInternalLoader;
      /// <summary>
      /// Allow using old WebView2 Runtime versions.
      /// </summary>
      property AllowOldRuntime                        : boolean                            read FAllowOldRuntime                         write FAllowOldRuntime;
      /// <summary>
      /// <para>Use BrowserExecPath to specify whether WebView2 controls use a fixed or
      /// installed version of the WebView2 Runtime that exists on a user machine.
      /// To use a fixed version of the WebView2 Runtime, pass the folder path that
      /// contains the fixed version of the WebView2 Runtime to BrowserExecPath.</para>
      /// <para>BrowserExecPath supports both relative (to the application's executable)
      /// and absolute files paths. To create WebView2 controls that use the installed
      /// version of the WebView2 Runtime that exists on user machines,
      /// pass an empty string to BrowserExecPath.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as the browserExecutableFolder parameter of CreateCoreWebView2EnvironmentWithOptions.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#createcorewebview2environmentwithoptions">See the Globals article.</see></para>
      /// </remarks>
      property BrowserExecPath                        : wvstring                           read FBrowserExecPath                         write FBrowserExecPath;
      /// <summary>
      /// You may specify the userDataFolder to change the default user data folder
      /// location for WebView2. The path is either an absolute file path or a relative
      /// file path that is interpreted as relative to the compiled code for the
      /// current process.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as the userDataFolder parameter of CreateCoreWebView2EnvironmentWithOptions.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#createcorewebview2environmentwithoptions">See the Globals article.</see></para>
      /// </remarks>
      property UserDataFolder                         : wvstring                           read FUserDataFolder                          write FUserDataFolder;
      /// <summary>
      /// Additional command line switches.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_AdditionalBrowserArguments.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property AdditionalBrowserArguments             : wvstring                           read FAdditionalBrowserArguments              write FAdditionalBrowserArguments;
      /// <summary>
      /// The default display language for WebView.  It applies to browser UI such as
      /// context menu and dialogs.  It also applies to the `accept-languages` HTTP
      /// header that WebView sends to websites.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_Language.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property Language                               : wvstring                           read FLanguage                                write FLanguage;
      /// <summary>
      /// Specifies the version of the WebView2 Runtime binaries required to be
      /// compatible with your app.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_TargetCompatibleBrowserVersion.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property TargetCompatibleBrowserVersion         : wvstring                           read FTargetCompatibleBrowserVersion          write FTargetCompatibleBrowserVersion;
      /// <summary>
      /// Used to enable single sign on with Azure Active Directory (AAD) and personal Microsoft
      /// Account (MSA) resources inside WebView.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_AllowSingleSignOnUsingOSPrimaryAccount.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property AllowSingleSignOnUsingOSPrimaryAccount : boolean                            read FAllowSingleSignOnUsingOSPrimaryAccount  write FAllowSingleSignOnUsingOSPrimaryAccount;
      /// <summary>
      /// Whether other processes can create WebView2 from WebView2Environment created with the
      /// same user data folder and therefore sharing the same WebView browser process instance.
      /// Default is FALSE.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions2.Get_ExclusiveUserDataFolderAccess.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions2">See the ICoreWebView2EnvironmentOptions2 article.</see></para>
      /// </remarks>
      property ExclusiveUserDataFolderAccess          : boolean                            read FExclusiveUserDataFolderAccess           write FExclusiveUserDataFolderAccess;
      /// <summary>
      /// When `CustomCrashReportingEnabled` is set to `TRUE`, Windows won't send crash data to Microsoft endpoint.
      /// `CustomCrashReportingEnabled` is default to be `FALSE`, in this case, WebView will respect OS consent.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions3.Get_IsCustomCrashReportingEnabled.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions3">See the ICoreWebView2EnvironmentOptions3 article.</see></para>
      /// </remarks>
      property CustomCrashReportingEnabled            : boolean                            read FCustomCrashReportingEnabled             write FCustomCrashReportingEnabled;
      /// <summary>
      /// The `EnableTrackingPrevention` property is used to enable/disable tracking prevention
      /// feature in WebView2. This property enable/disable tracking prevention for all the
      /// WebView2's created in the same environment.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions5.Get_EnableTrackingPrevention.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions5">See the ICoreWebView2EnvironmentOptions5 article.</see></para>
      /// </remarks>
      property EnableTrackingPrevention               : boolean                            read FEnableTrackingPrevention                write FEnableTrackingPrevention;
      /// <summary>
      /// <para>When `AreBrowserExtensionsEnabled` is set to `TRUE`, new extensions can be added to user
      /// profile and used. `AreBrowserExtensionsEnabled` is default to be `FALSE`, in this case,
      /// new extensions can't be installed, and already installed extension won't be
      /// available to use in user profile.</para>
      /// <para>If connecting to an already running environment with a different value for `AreBrowserExtensionsEnabled`
      /// property, it will fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions6.Get_AreBrowserExtensionsEnabled.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions6">See the ICoreWebView2EnvironmentOptions6 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextension">See the ICoreWebView2BrowserExtension article for Extensions API details.</see></para>
      /// </remarks>
      property AreBrowserExtensionsEnabled            : boolean                            read FAreBrowserExtensionsEnabled             write FAreBrowserExtensionsEnabled;
      /// <summary>
      /// <para>The `ChannelSearchKind` property is `COREWEBVIEW2_CHANNEL_SEARCH_KIND_MOST_STABLE`
      /// by default; environment creation searches for a release channel on the machine
      /// from most to least stable using the first channel found. The default search order is:
      /// WebView2 Runtime -&gt; Beta -&gt; Dev -&gt; Canary. Set `ChannelSearchKind` to
      /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE` to reverse the search order
      /// so that environment creation searches for a channel from least to most stable. If
      /// `ReleaseChannels` has been provided, the loader will only search
      /// for channels in the set. See `COREWEBVIEW2_RELEASE_CHANNELS` for more details
      /// on channels.</para>
      /// <para>This property can be overridden by the corresponding
      /// registry key `ChannelSearchKind` or the environment variable
      /// `WEBVIEW2_CHANNEL_SEARCH_KIND`. Set the value to `1` to set the search kind to
      /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE`. See
      /// `CreateCoreWebView2EnvironmentWithOptions` for more details on overrides.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions7.Get_ChannelSearchKind.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7">See the ICoreWebView2EnvironmentOptions7 article.</see></para>
      /// </remarks>
      property ChannelSearchKind                      : TWVChannelSearchKind               read FChannelSearchKind                       write FChannelSearchKind;
      /// <summary>
      /// <para>Sets the `ReleaseChannels`, which is a mask of one or more
      /// `COREWEBVIEW2_RELEASE_CHANNELS` indicating which channels environment
      /// creation should search for. OR operation(s) can be applied to multiple
      /// `COREWEBVIEW2_RELEASE_CHANNELS` to create a mask. The default value is a
      /// a mask of all the channels. By default, environment creation searches for
      /// channels from most to least stable, using the first channel found on the
      /// device. When `ReleaseChannels` is provided, environment creation will only
      /// search for the channels specified in the set. Set `ChannelSearchKind` to
      /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE` to reverse the search order
      /// so environment creation searches for least stable build first. See
      /// `COREWEBVIEW2_RELEASE_CHANNELS` for descriptions of each channel.</para>
      /// <para>`CreateCoreWebView2EnvironmentWithOptions` fails with
      /// `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)` if environment creation is unable
      /// to find any channel from the `ReleaseChannels` installed on the device.
      /// Use `GetAvailableCoreWebView2BrowserVersionStringWithOptions` on
      /// `ICoreWebView2Environment` to verify which channel is used when this option
      /// is set.</para>
      /// Examples:
      /// <code>
      /// |   ReleaseChannels   |   Channel Search Kind: Most Stable (default)   |   Channel Search Kind: Least Stable   |
      /// | --- | --- | --- |
      /// |COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE| WebView2 Runtime -&gt; Beta | Beta -&gt; WebView2 Runtime|
      /// |COREWEBVIEW2_RELEASE_CHANNELS_CANARY \| COREWEBVIEW2_RELEASE_CHANNELS_DEV \| COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE| WebView2 Runtime -&gt; Beta -&gt; Dev -&gt; Canary | Canary -&gt; Dev -&gt; Beta -&gt; WebView2 Runtime |
      /// |COREWEBVIEW2_RELEASE_CHANNELS_CANARY| Canary | Canary |
      /// |COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_CANARY \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE | WebView2 Runtime -&gt; Beta -&gt; Canary | Canary -&gt; Beta -&gt; WebView2 Runtime |
      /// </code>
      /// <para>If both `BrowserExecutableFolder` and `ReleaseChannels` are provided, the
      /// `BrowserExecutableFolder` takes precedence, regardless of whether or not the
      /// channel of `BrowserExecutableFolder` is included in the `ReleaseChannels`.</para>
      /// <para>`ReleaseChannels` can be overridden by the corresponding registry override
      /// `ReleaseChannels` or the environment variable `WEBVIEW2_RELEASE_CHANNELS`.</para>
      /// <para>Set the value to a comma-separated string of integers, which map to the
      /// following release channel values: Stable (0), Beta (1), Dev (2), and
      /// Canary (3). For example, the values "0,2" and "2,0" indicate that environment
      /// creation should only search for Dev channel and the WebView2 Runtime, using the
      /// order indicated by `ChannelSearchKind`. Environment creation attempts to
      /// interpret each integer and treats any invalid entry as Stable channel. See
      /// `CreateCoreWebView2EnvironmentWithOptions` for more details on overrides.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions7.Get_ReleaseChannels.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7">See the ICoreWebView2EnvironmentOptions7 article.</see></para>
      /// </remarks>
      property ReleaseChannels                        : TWVReleaseChannels                 read FReleaseChannels                         write FReleaseChannels;
      /// <summary>
      /// <para>The ScrollBar style being set on the WebView2 Environment.</para>
      /// <para>The default value is `COREWEBVIEW2_SCROLLBAR_STYLE_DEFAULT`
      /// which specifies the default browser ScrollBar style.</para>
      /// <para>The `color-scheme` CSS property needs to be set on the corresponding page
      /// to allow ScrollBar to follow light or dark theme. Please see
      /// [color-scheme](https://developer.mozilla.org/docs/Web/CSS/color-scheme#declaring_color_scheme_preferences)
      /// for how `color-scheme` can be set.</para>
      /// <para>CSS styles that modify the ScrollBar applied on top of native ScrollBar styling
      /// that is selected with `ScrollBarStyle`.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions8.Get_ScrollBarStyle.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions8">See the ICoreWebView2EnvironmentOptions8 article.</see></para>
      /// </remarks>
      property ScrollBarStyle                         : TWVScrollBarStyle                  read FScrollBarStyle                          write FScrollBarStyle;
      /// <summary>
      /// Enable GPU hardware acceleration.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --disable-gpu</see></para>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --disable-gpu-compositing</see></para>
      /// </remarks>
      property EnableGPU                              : boolean                            read FEnableGPU                               write FEnableGPU;
      /// <summary>
      /// List of feature names to enable.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --enable-features</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/webview-features-flags">See the WebView2 browser flags article.</see></para>
      /// <para>The list of features you can enable is here:</para>
      /// <para>https://chromium.googlesource.com/chromium/src/+/master/chrome/common/chrome_features.cc</para>
      /// <para>https://source.chromium.org/chromium/chromium/src/+/main:content/public/common/content_features.cc</para>
      /// <para>https://source.chromium.org/search?q=base::Feature</para>
      /// </remarks>
      property EnableFeatures                         : wvstring                           read FEnableFeatures                          write FEnableFeatures;
      /// <summary>
      /// List of feature names to disable.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --disable-features</see></para>
      /// <para>The list of features you can disable is here:</para>
      /// <para>https://chromium.googlesource.com/chromium/src/+/master/chrome/common/chrome_features.cc</para>
      /// <para>https://source.chromium.org/chromium/chromium/src/+/main:content/public/common/content_features.cc</para>
      /// <para>https://source.chromium.org/search?q=base::Feature</para>
      /// </remarks>
      property DisableFeatures                        : wvstring                           read FDisableFeatures                         write FDisableFeatures;
      /// <summary>
      /// Enable one or more Blink runtime-enabled features.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --enable-blink-features</see></para>
      /// <para>The list of Blink features you can enable is here:</para>
      /// <para>https://cs.chromium.org/chromium/src/third_party/blink/renderer/platform/runtime_enabled_features.json5</para>
      /// </remarks>
      property EnableBlinkFeatures                    : wvstring                           read FEnableBlinkFeatures                     write FEnableBlinkFeatures;
      /// <summary>
      /// Disable one or more Blink runtime-enabled features.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --disable-blink-features</see></para>
      /// <para>The list of Blink features you can disable is here:</para>
      /// <para>https://cs.chromium.org/chromium/src/third_party/blink/renderer/platform/runtime_enabled_features.json5</para>
      /// </remarks>
      property DisableBlinkFeatures                   : wvstring                           read FDisableBlinkFeatures                    write FDisableBlinkFeatures;
      /// <summary>
      /// Set blink settings. Format is <name>[=<value],<name>[=<value>],...
      /// The names are declared in Settings.json5. For boolean type, use "true", "false",
      /// or omit '=<value>' part to set to true. For enum type, use the int value of the
      /// enum value. Applied after other command line flags and prefs.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --blink-settings</see></para>
      /// <para>The list of Blink settings you can disable is here:</para>
      /// <para>https://source.chromium.org/chromium/chromium/src/+/master:third_party/blink/renderer/core/frame/settings.json5</para>
      /// </remarks>
      property BlinkSettings                          : wvstring                           read FBlinkSettings                           write FBlinkSettings;
      /// <summary>
      /// <para>This option can be used to force field trials when testing changes locally.</para>
      /// <para>The argument is a list of name and value pairs, separated by slashes.</para>
      /// <para>If a trial name is prefixed with an asterisk, that trial will start activated.</para>
      /// <para>For example, the following argument defines two trials, with the second one
      /// activated: "GoogleNow/Enable/*MaterialDesignNTP/Default/" This option can also
      /// be used by the browser process to send the list of trials to a non-browser
      /// process, using the same format. See FieldTrialList::CreateTrialsFromString()
      /// in field_trial.h for details.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --force-fieldtrials</see></para>
      /// <para>https://source.chromium.org/chromium/chromium/src/+/master:base/base_switches.cc</para>
      /// </remarks>
      property ForceFieldTrials                       : wvstring                           read FForceFieldTrials                        write FForceFieldTrials;
      /// <summary>
      /// <para>This option can be used to force parameters of field trials when testing
      /// changes locally. The argument is a param list of (key, value) pairs prefixed
      /// by an associated (trial, group) pair. You specify the param list for multiple
      /// (trial, group) pairs with a comma separator.</para>
      /// <para>Example: "Trial1.Group1:k1/v1/k2/v2,Trial2.Group2:k3/v3/k4/v4"</para>
      /// <para>Trial names, groups names, parameter names, and value should all be URL
      /// escaped for all non-alphanumeric characters.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --force-fieldtrial-params</see></para>
      /// <para>https://source.chromium.org/chromium/chromium/src/+/master:components/variations/variations_switches.cc</para>
      /// </remarks>
      property ForceFieldTrialParams                  : wvstring                           read FForceFieldTrialParams                   write FForceFieldTrialParams;
      /// <summary>
      /// Workaround given my Microsoft to disable the SmartScreen protection.
      /// </summary>
      property SmartScreenProtectionEnabled           : boolean                            read FSmartScreenProtectionEnabled            write FSmartScreenProtectionEnabled;
      /// <summary>
      /// Enables TLS/SSL errors on localhost to be ignored (no interstitial, no blocking of requests).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --allow-insecure-localhost</see></para>
      /// </remarks>
      property AllowInsecureLocalhost                 : boolean                            read FAllowInsecureLocalhost                  write FAllowInsecureLocalhost;
      /// <summary>
      /// Don't enforce the same-origin policy.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --disable-web-security</see></para>
      /// </remarks>
      property DisableWebSecurity                     : boolean                            read FDisableWebSecurity                      write FDisableWebSecurity;
      /// <summary>
      /// Enable support for touch event feature detection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --touch-events</see></para>
      /// </remarks>
      property TouchEvents                            : TWVState                           read FTouchEvents                             write FTouchEvents;
      /// <summary>
      /// Don't send hyperlink auditing pings.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --no-pings</see></para>
      /// </remarks>
      property HyperlinkAuditing                      : boolean                            read FHyperlinkAuditing                       write FHyperlinkAuditing;
      /// <summary>
      /// Autoplay policy.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --autoplay-policy</see></para>
      /// </remarks>
      property AutoplayPolicy                         : TWVAutoplayPolicy                  read FAutoplayPolicy                          write FAutoplayPolicy;
      /// <summary>
      /// Mutes audio sent to the audio device so it is not audible during automated testing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --mute-audio</see></para>
      /// </remarks>
      property MuteAudio                              : boolean                            read FMuteAudio                               write FMuteAudio;
      /// <summary>
      /// Default encoding.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://bitbucket.org/chromiumembedded/cef/src/master/libcef/common/cef_switches.cc">Uses the following command line switch: --default-encoding</see></para>
      /// </remarks>
      property DefaultEncoding                        : wvstring                           read FDefaultEncoding                         write FDefaultEncoding;
      /// <summary>
      /// Enable automatically pressing the print button in print preview.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --kiosk-printing</see></para>
      /// </remarks>
      property KioskPrinting                          : boolean                            read FKioskPrinting                           write FKioskPrinting;
      /// <summary>
      /// Configure the browser to use a proxy server.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --no-proxy-server</see></para>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-auto-detect</see></para>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-bypass-list</see></para>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-pac-url</see></para>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-server</see></para>
      /// <para><see href="https://www.chromium.org/developers/design-documents/network-settings/">See the Network Settings article.</see></para>
      /// <para><see href="https://github.com/chromium/chromium/blob/main/net/docs/proxy.md"/">See the Proxy Support article.</see></para>
      /// <para><see href="https://developer.chrome.com/docs/extensions/reference/api/proxy">See the chrome.proxy API article.</see></para>
      /// </remarks>
      property ProxySettings                          : TWVProxySettings                   read FProxySettings;
      /// <summary>
      /// By default, file:// URIs cannot read other file:// URIs. This is an override for developers who need the old behavior for testing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --allow-file-access-from-files</see></para>
      /// </remarks>
      property AllowFileAccessFromFiles               : boolean                            read FAllowFileAccessFromFiles                write FAllowFileAccessFromFiles;
      /// <summary>
      /// By default, an https page cannot run JavaScript, CSS or plugins from http URLs. This provides an override to get the old insecure behavior.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --allow-running-insecure-content</see></para>
      /// </remarks>
      property AllowRunningInsecureContent            : boolean                            read FAllowRunningInsecureContent             write FAllowRunningInsecureContent;
      /// <summary>
      /// Disable several subsystems which run network requests in the background.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --disable-background-networking</see></para>
      /// </remarks>
      property DisableBackgroundNetworking            : boolean                            read FDisableBackgroundNetworking             write FDisableBackgroundNetworking;
      /// <summary>
      /// Overrides the device scale factor for the browser UI and the contents.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --force-device-scale-factor</see></para>
      /// </remarks>
      property ForcedDeviceScaleFactor                : single                             read FForcedDeviceScaleFactor                 write FForcedDeviceScaleFactor;
      /// <summary>
      /// Set to a value between 1024 and 65535 to enable remote debugging on the
      /// specified port. Also configurable using the "remote-debugging-port"
      /// command-line switch. Remote debugging can be accessed by loading the
      /// chrome://inspect page in Google Chrome. Port numbers 9222 and 9229 are
      /// discoverable by default. Other port numbers may need to be configured via
      /// "Discover network targets" on the Devices tab.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --remote-debugging-port</see></para>
      /// </remarks>
      property RemoteDebuggingPort                    : integer                            read FRemoteDebuggingPort                     write FRemoteDebuggingPort;
      /// <summary>
      /// Enables web socket connections from the specified origins only. '*' allows any origin.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --remote-allow-origins</see></para>
      /// </remarks>
      property RemoteAllowOrigins                     : wvstring                           read FRemoteAllowOrigins                      write FRemoteAllowOrigins;
      /// <summary>
      /// Force logging to be enabled. Logging is disabled by default in release builds.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --enable-logging</see></para>
      /// </remarks>
      property DebugLog                               : TWV2DebugLog                       read FDebugLog                                write FDebugLog;
      /// <summary>
      /// Sets the minimum log level.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --log-level</see></para>
      /// </remarks>
      property DebugLogLevel                          : TWV2DebugLogLevel                  read FDebugLogLevel                           write FDebugLogLevel;
      /// <summary>
      /// Specifies the flags passed to JS engine.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --js-flags</see></para>
      /// </remarks>
      property JavaScriptFlags                        : wvstring                           read FJavaScriptFlags                         write FJavaScriptFlags;
      /// <summary>
      /// Workaround given my Microsoft to disable the "Download Edge" notifications.
      /// </summary>
      property DisableEdgePitchNotification           : boolean                            read FDisableEdgePitchNotification            write FDisableEdgePitchNotification;
      /// <summary>
      /// Treat given (insecure) origins as secure origins.
      /// Multiple origins can be supplied as a comma-separated list.
      /// For the definition of secure contexts, see https://w3c.github.io/webappsec-secure-contexts/
      /// and https://www.w3.org/TR/powerful-features/#is-origin-trustworthy
      /// Example: --unsafely-treat-insecure-origin-as-secure=http://a.test,http://b.test
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --unsafely-treat-insecure-origin-as-secure</see></para>
      /// </remarks>
      property TreatInsecureOriginAsSecure            : wvstring                           read FTreatInsecureOriginAsSecure             write FTreatInsecureOriginAsSecure;
      /// <summary>
      /// <para>Enable the MS Office file viewer in the browser.</para>
      /// <para>This is a workaround given by Microsoft to open MS Office documents in the web browser instead of downloading the files.</para>
      /// </summary>
      property OpenOfficeDocumentsInWebViewer         : boolean                            read FOpenOfficeDocumentsInWebViewer          write FOpenOfficeDocumentsInWebViewer;
      /// <summary>
      /// If enabled, allows implicit sign-in to Microsoft webpages using any account, by using the information from the primary OS account.
      /// </summary>
      /// <remarks>
      /// <para>This property uses the msSingleSignOnOSForPrimaryAccountIsShared flag.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/webview-features-flags">See the WebView2 browser flags article.</see></para>
      /// </remarks>
      property MicrosoftSignIn                        : boolean                            read FMicrosoftSignIn                         write FMicrosoftSignIn;
      /// <summary>
      /// This option enables a combination of X25519 and Kyber in TLS 1.3.
      /// </summary>
      property TLS13HybridizedKyberSupport            : TWVState                           read FPostQuantumKyber                        write FPostQuantumKyber;
      /// <summary>
      /// A string used to override the default user agent with a custom one.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --user-agent</see></para>
      /// </remarks>
      property UserAgent                              : wvstring                           read FUserAgent                               write FUserAgent;
      /// <summary>
      /// Bypasses the dialog prompting the user for permission to capture cameras and microphones.
      /// Useful in automatic tests of video-conferencing Web applications. This is nearly
      /// identical to kUseFakeUIForMediaStream, with the exception being that this flag does NOT
      /// affect screen-capture.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --auto-accept-camera-and-microphone-capture</see></para>
      /// </remarks>
      property AutoAcceptCamAndMicCapture             : boolean                            read FAutoAcceptCamAndMicCapture              write FAutoAcceptCamAndMicCapture;
      /// <summary>
      /// Returns true if the current WebView2 runtime version supports Composition Controllers.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment3">See the ICoreWebView2Environment3 article.</see></para>
      /// </remarks>
      property SupportsCompositionController          : boolean                            read GetSupportsCompositionController;
      /// <summary>
      /// Returns the `ICoreWebView2ProcessInfoCollection`
      /// Provide a list of all process using same user data folder except for crashpad process.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8">See the ICoreWebView2Environment8 article.</see></para>
      /// </remarks>
      property ProcessInfos                           : ICoreWebView2ProcessInfoCollection read GetProcessInfos;
      /// <summary>
      /// Returns true if the current WebView2 runtime version supports Controller Options.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment10">See the ICoreWebView2Environment10 article.</see></para>
      /// </remarks>
      property SupportsControllerOptions              : boolean                            read GetSupportsControllerOptions;
      /// <summary>
      /// <para>`FailureReportFolderPath` returns the path of the folder where minidump files are written.
      /// Whenever a WebView2 process crashes, a crash dump file will be created in the crash dump folder.
      /// The crash dump format is minidump files.</para>
      /// <para>Please see [Minidump Files documentation](/windows/win32/debug/minidump-files) for detailed information.</para>
      /// <para>Normally when a single child process fails, a minidump will be generated and written to disk,
      /// then the `ProcessFailed` event is raised. But for unexpected crashes, a minidump file might not be generated
      /// at all, despite whether `ProcessFailed` event is raised. If there are multiple
      /// process failures at once, multiple minidump files could be generated. Thus `FailureReportFolderPath`
      /// could contain old minidump files that are not associated with a specific `ProcessFailed` event.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment11#get_failurereportfolderpath">See the ICoreWebView2Environment11 article.</see></para>
      /// </remarks>
      property FailureReportFolderPath                : wvstring                           read GetFailureReportFolderPath;
      /// <summary>
      /// OnEnvironmentCreated is triggered when the Environment is successfully created and Status is wvlsInitialized.
      /// </summary>
      property OnEnvironmentCreated                   : TLoaderNotifyEvent                      read FOnEnvironmentCreated                    write FOnEnvironmentCreated;
      /// <summary>
      /// OnInitializationError is triggered when there was a problem creating the Environment ans Status is wvlsError. ErrorCode and ErrorMessage have more details about this error.
      /// </summary>
      property OnInitializationError                  : TLoaderNotifyEvent                      read FOnInitializationError                   write FOnInitializationError;
      /// <summary>
      /// <para>OnGetCustomSchemes is triggered automatically before creaing the environment to register custom schemes.</para>
      /// <para>Fill the aCustomSchemes event parameter with all the information to create one or more
      /// ICoreWebView2CustomSchemeRegistration instances that will be used during the creation of the Environment.</para>
      /// </summary>
      /// <remarks>
      /// <para><see cref="uWVTypes|TWVCustomSchemeInfo">See TWVCustomSchemeInfo.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customschemeregistration">See the ICoreWebView2CustomSchemeRegistration article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions4">See the ICoreWebView2EnvironmentOptions4 article.</see></para>
      /// </remarks>
      property OnGetCustomSchemes                     : TLoaderGetCustomSchemesEvent            read FOnGetCustomSchemes                      write FOnGetCustomSchemes;
      /// <summary>
      /// OnNewBrowserVersionAvailable runs when a newer version of the WebView2
      /// Runtime is installed and available using WebView2.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment#add_newbrowserversionavailable">See the ICoreWebView2Environment article.</see></para>
      /// </remarks>
      property OnNewBrowserVersionAvailable           : TLoaderNewBrowserVersionAvailableEvent  read FOnNewBrowserVersionAvailable            write FOnNewBrowserVersionAvailable;
      /// <summary>
      /// The OnBrowserProcessExited event is triggered when the collection of WebView2
      /// Runtime processes for the browser process of this environment terminate
      /// due to browser process failure or normal shutdown (for example, when all
      /// associated WebViews are closed), after all resources have been released
      /// (including the user data folder).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment5#add_browserprocessexited">See the ICoreWebView2Environment5 article.</see></para>
      /// </remarks>
      property OnBrowserProcessExited                 : TLoaderBrowserProcessExitedEvent        read FOnBrowserProcessExited                  write FOnBrowserProcessExited;
      /// <summary>
      /// OnProcessInfosChanged is triggered when the ProcessInfos property has changed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8#add_processinfoschanged">See the ICoreWebView2Environment8 article.</see></para>
      /// </remarks>
      property OnProcessInfosChanged                  : TLoaderProcessInfosChangedEvent         read FOnProcessInfosChanged                   write FOnProcessInfosChanged;
  end;

  /// <summary>
  /// Class used by the TWVLoader.ProxySettigns property to configure
  /// a custom proxy server using the following command line switches:
  /// --no-proxy-server, --proxy-auto-detect, --proxy-bypass-list,
  /// --proxy-pac-url and --proxy-server.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --no-proxy-server</see></para>
  /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-auto-detect</see></para>
  /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-bypass-list</see></para>
  /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-pac-url</see></para>
  /// <para><see href="https://peter.sh/experiments/chromium-command-line-switches/">Uses the following command line switch: --proxy-server</see></para>
  /// <para><see href="https://www.chromium.org/developers/design-documents/network-settings/">See the Network Settings article.</see></para>
  /// <para><see href="https://github.com/chromium/chromium/blob/main/net/docs/proxy.md"/">See the Proxy Support article.</see></para>
  /// <para><see href="https://developer.chrome.com/docs/extensions/reference/api/proxy">See the chrome.proxy API article.</see></para>
  /// </remarks>
  TWVProxySettings = class
    protected
      FNoProxyServer : boolean;
      FAutoDetect    : boolean;
      FByPassList    : wvstring;
      FPacUrl        : wvstring;
      FServer        : wvstring;

    public
      constructor Create;

      property NoProxyServer : boolean    read FNoProxyServer  write FNoProxyServer;
      property AutoDetect    : boolean    read FAutoDetect     write FAutoDetect;
      property ByPassList    : wvstring   read FByPassList     write FByPassList;
      property PacUrl        : wvstring   read FPacUrl         write FPacUrl;
      property Server        : wvstring   read FServer         write FServer;
  end;

var
  /// <summary>
  /// Global instance of TWVLoader used to simplify the WebView2 initialization and destruction.
  /// </summary>
  /// <remarks>
  /// <para><see cref="uWVLoader|TWVLoader">See TWVLoader.</see></para>
  /// </remarks>
  GlobalWebView2Loader : TWVLoader = nil;

procedure DestroyGlobalWebView2Loader;

implementation

uses
  uWVConstants, uWVMiscFunctions, uWVCoreWebView2Delegates,
  uWVCoreWebView2EnvironmentOptions, uWVLoaderInternal, uWVCoreWebView2CustomSchemeRegistration;

const
  WEBVIEW2LOADERLIB = 'WebView2Loader.dll';

procedure DestroyGlobalWebView2Loader;
begin
  if assigned(GlobalWebView2Loader) then
    FreeAndNil(GlobalWebView2Loader);
end;

constructor TWVLoader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCoreWebView2Environment                := nil;
  FOnEnvironmentCreated                   := nil;
  FOnNewBrowserVersionAvailable           := nil;
  FOnProcessInfosChanged                  := nil;
  FOnInitializationError                  := nil;
  FOnBrowserProcessExited                 := nil;
  FOnGetCustomSchemes                     := nil;
  FStatus                                 := wvlsCreated;
  FLibHandle                              := 0;
  FError                                  := 0;
  FBrowserExecPath                        := '';
  FUserDataFolder                         := '';
  FSetCurrentDir                          := True;
  FCheckFiles                             := True;
  FShowMessageDlg                         := True;
  FInitCOMLibrary                         := {$IFDEF DELPHI16_UP}False{$ELSE}True{$ENDIF};
  FLocalCOMInitMade                       := False;
  FForcedDeviceScaleFactor                := 0;
  FReRaiseExceptions                      := False;
  FLoaderDllPath                          := '';
  FUseInternalLoader                      := False;
  FAllowOldRuntime                        := True;
  FRemoteDebuggingPort                    := 0;
  FRemoteAllowOrigins                     := '';

  UpdateDeviceScaleFactor;

  // Fields used to create the environment
  FAdditionalBrowserArguments             := '';
  FLanguage                               := '';
  FTargetCompatibleBrowserVersion         := LowestChromiumVersion;
  FAllowSingleSignOnUsingOSPrimaryAccount := False;
  FExclusiveUserDataFolderAccess          := False;
  FCustomCrashReportingEnabled            := False;
  FEnableTrackingPrevention               := True;
  FAreBrowserExtensionsEnabled            := False;
  FChannelSearchKind                      := COREWEBVIEW2_CHANNEL_SEARCH_KIND_MOST_STABLE;
  FReleaseChannels                        := COREWEBVIEW2_RELEASE_CHANNELS_STABLE or
                                             COREWEBVIEW2_RELEASE_CHANNELS_BETA or
                                             COREWEBVIEW2_RELEASE_CHANNELS_DEV or
                                             COREWEBVIEW2_RELEASE_CHANNELS_CANARY;
  FScrollBarStyle                         := COREWEBVIEW2_SCROLLBAR_STYLE_DEFAULT;

  // Fields used to set command line switches
  FEnableGPU                              := True;
  FEnableFeatures                         := '';
  FDisableFeatures                        := '';
  FEnableBlinkFeatures                    := '';
  FDisableBlinkFeatures                   := '';
  FBlinkSettings                          := '';
  FForceFieldTrials                       := '';
  FForceFieldTrialParams                  := '';
  FSmartScreenProtectionEnabled           := True;
  FAllowInsecureLocalhost                 := False;
  FDisableWebSecurity                     := False;
  FTouchEvents                            := STATE_DEFAULT;
  FHyperlinkAuditing                      := True;
  FAutoplayPolicy                         := appDefault;
  FMuteAudio                              := False;
  FDefaultEncoding                        := '';
  FKioskPrinting                          := False;
  FAllowFileAccessFromFiles               := False;
  FAllowRunningInsecureContent            := False;
  FDisableBackgroundNetworking            := False;
  FDebugLog                               := dlDisabled;
  FDebugLogLevel                          := dllDefault;
  FJavaScriptFlags                        := '';
  FDisableEdgePitchNotification           := True;
  FTreatInsecureOriginAsSecure            := '';
  FOpenOfficeDocumentsInWebViewer         := False;
  FAutoAcceptCamAndMicCapture             := False;
  FMicrosoftSignIn                        := False;
  FPostQuantumKyber                       := STATE_DEFAULT;
  FUserAgent                              := '';
  FProxySettings                          := nil;
  FErrorLog                               := nil;

  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
end;

destructor TWVLoader.Destroy;
begin
  try
    DestroyEnvironment;
    UnLoadWebView2Library;

    if FLocalCOMInitMade then
      CoUnInitialize;

    if assigned(FProxySettings) then
      FreeAndNil(FProxySettings);

    if assigned(FErrorLog) then
      FreeAndNil(FErrorLog);
  finally
    inherited Destroy;
  end;
end;

procedure TWVLoader.AfterConstruction;
begin
  inherited AfterConstruction;

  FProxySettings := TWVProxySettings.Create;
  FErrorLog      := TStringList.Create;
end;

procedure TWVLoader.DestroyEnvironment;
begin
  if (FCoreWebView2Environment <> nil) then
    FreeAndNil(FCoreWebView2Environment);
end;

procedure TWVLoader.doOnInitializationError;
begin
  if assigned(FOnInitializationError) then
    FOnInitializationError(self);
end;

procedure TWVLoader.doOnEnvironmentCreated;
begin
  if assigned(FOnEnvironmentCreated) then
    FOnEnvironmentCreated(self);
end;

procedure TWVLoader.doOnNewBrowserVersionAvailable(const aEnvironment: ICoreWebView2Environment);
begin
  if assigned(FOnNewBrowserVersionAvailable) then
    FOnNewBrowserVersionAvailable(self, aEnvironment);
end;

procedure TWVLoader.doOnBrowserProcessExitedEvent(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs);
begin
  if assigned(FOnBrowserProcessExited) then
    FOnBrowserProcessExited(self, sender, args);
end;

procedure TWVLoader.doProcessInfosChangedEvent(const sender: ICoreWebView2Environment);
begin
  if assigned(FOnProcessInfosChanged) then
    FOnProcessInfosChanged(self, sender);
end;

procedure TWVLoader.doOnGetCustomSchemes(var aSchemeRegistrations : TWVCustomSchemeRegistrationArray);
var
  TempArray : TWVCustomSchemeInfoArray;
  i, TempLen : integer;
begin
  if not(assigned(FOnGetCustomSchemes)) then exit;

  TempArray := nil;
  FOnGetCustomSchemes(self, TempArray);
  TempLen := length(TempArray);

  if (TempLen = 0) then exit;

  SetLength(aSchemeRegistrations,  TempLen);
  ZeroMemory(aSchemeRegistrations, TempLen * SizeOf(ICoreWebView2CustomSchemeRegistration));

  i := 0;
  while (i < TempLen) do
    begin
      aSchemeRegistrations[i] := TCoreWebView2CustomSchemeRegistration.Create(TempArray[i]);
      inc(i);
    end;
end;

function TWVLoader.GetExtendedFileVersion(const aFileName : wvstring) : uint64;
var
  TempSize   : DWORD;
  TempBuffer : pointer;
  TempLen    : UINT;
  TempHandle : cardinal;
  TempInfo   : PVSFixedFileInfo;
begin
  Result     := 0;
  TempBuffer := nil;
  TempHandle := 0;
  TempLen    := 0;

  try
    try
      TempSize := GetFileVersionInfoSizeW(PWideChar(aFileName), TempHandle);

      if (TempSize > 0) then
        begin
          GetMem(TempBuffer, TempSize);

          if GetFileVersionInfoW(PWideChar(aFileName), TempHandle, TempSize, TempBuffer) and
             VerQueryValue(TempBuffer, '\', Pointer(TempInfo), TempLen) then
            begin
              Result := TempInfo^.dwFileVersionMS;
              Result := Result shl 32;
              Result := Result or TempInfo^.dwFileVersionLS;
            end;
        end
       else
        OutputDebugMessage('TWVLoader.GetExtendedFileVersion error: ' + SysErrorMessage(GetLastError()));
    except
      on e : exception do
        if CustomExceptionHandler('TWVLoader.GetExtendedFileVersion', e) then raise;
    end;
  finally
    if (TempBuffer <> nil) then FreeMem(TempBuffer);
  end;
end;

function TWVLoader.GetFileVersion(const aFile : wvstring; var aVersionInfo : TFileVersionInfo) : boolean;
var
  TempVersion : uint64;
begin
  Result := False;

  try
    if FileExists(aFile) then
      begin
        TempVersion := GetExtendedFileVersion(aFile);

        if (TempVersion <> 0) then
          begin
            aVersionInfo.MajorVer := word(TempVersion shr 48);
            aVersionInfo.MinorVer := word((TempVersion shr 32) and $FFFF);
            aVersionInfo.Release  := word((TempVersion shr 16) and $FFFF);
            aVersionInfo.Build    := word(TempVersion and $FFFF);

            Result := True;
          end;
      end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVLoader.GetFileVersion', e) then raise;
  end;
end;

function TWVLoader.LoadWebView2Library : boolean;
var
  TempOldDir : string;
  TempLoaderLibPath : wvstring;
begin
  Result := False;

  if FUseInternalLoader then
    begin
      Result := True;
      exit;
    end;

  try
    if (FLibHandle <> 0) then
      Result := True
     else
      try
        if FSetCurrentDir then
          begin
            TempOldDir := GetCurrentDir;
            chdir(GetModulePath);
          end;

        FStatus := wvlsLoading;

        if (FLoaderDllPath <> '') then
          TempLoaderLibPath := FLoaderDllPath
         else
          TempLoaderLibPath := WEBVIEW2LOADERLIB;

        FLibHandle := LoadLibraryW(PWideChar(TempLoaderLibPath));

        if (FLibHandle = 0) then
          begin
            FStatus   := wvlsError;
            FError    := GetLastError;

            AppendErrorLog('Error loading ' + TempLoaderLibPath);
            AppendErrorLog('Error code : 0x' + {$IFDEF FPC}UTF8Decode({$ENDIF}inttohex(cardinal(FError), 8){$IFDEF FPC}){$ENDIF});
            AppendErrorLog({$IFDEF FPC}UTF8Decode({$ENDIF}SysErrorMessage(cardinal(FError)){$IFDEF FPC}){$ENDIF});

            ShowErrorMessageDlg(ErrorMessage);
          end
         else
          begin
            FStatus := wvlsLoaded;
            Result  := True;
          end;
      finally
        if FSetCurrentDir then
          chdir(TempOldDir);
      end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVLoader.LoadWebView2Library', e) then raise;
  end;
end;

procedure TWVLoader.UnLoadWebView2Library;
begin
  if FUseInternalLoader then
    exit;

  try
    if (FLibHandle <> 0) then
      begin
        FreeLibrary(FLibHandle);
        FLibHandle := 0;
        FStatus    := wvlsUnloaded;
      end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVLoader.UnLoadWebView2Library', e) then raise;
  end;
end;

function TWVLoader.CheckFileVersion(const aFile : wvstring; aMajor, aMinor, aRelease, aBuild : word) : boolean;
var
  TempVersionInfo : TFileVersionInfo;
begin
  Result := False;

  if GetFileVersion(aFile, TempVersionInfo) then
    begin
      if (TempVersionInfo.MajorVer > aMajor) then
        Result := True
       else
        if (TempVersionInfo.MajorVer = aMajor) then
          begin
            if (TempVersionInfo.MinorVer > aMinor) then
              Result := True
             else
              if (TempVersionInfo.MinorVer = aMinor) then
                begin
                  if (TempVersionInfo.Release > aRelease) then
                    Result := True
                   else
                    if (TempVersionInfo.Release = aRelease) then
                      Result := (TempVersionInfo.Build >= aBuild);
                end;
          end;
    end;
end;

// This function is based on the answer given by 'Alex' in StackOverflow
// https://stackoverflow.com/questions/2748474/how-to-determine-if-dll-file-was-compiled-as-x64-or-x86-bit-using-either-delphi
function TWVLoader.GetDLLHeaderMachine(const aDLLFile : string; var aMachine : integer) : boolean;
var
  TempHeader         : TImageDosHeader;
  TempImageNtHeaders : TImageNtHeaders;
  TempStream         : TFileStream;
begin
  Result     := False;
  aMachine   := IMAGE_FILE_MACHINE_UNKNOWN;
  TempStream := nil;

  try
    try
      if FileExists(aDLLFile) then
        begin
          TempStream := TFileStream.Create(aDLLFile, fmOpenRead or fmShareDenyWrite);
          TempStream.seek(0, soFromBeginning);
          TempStream.ReadBuffer(TempHeader, SizeOf(TempHeader));

          if (TempHeader.e_magic = IMAGE_DOS_SIGNATURE) and
             (TempHeader._lfanew <> 0) then
            begin
              TempStream.Position := TempHeader._lfanew;
              TempStream.ReadBuffer(TempImageNtHeaders, SizeOf(TempImageNtHeaders));

              if (TempImageNtHeaders.Signature = IMAGE_NT_SIGNATURE) then
                begin
                  aMachine := TempImageNtHeaders.FileHeader.Machine;
                  Result   := True;
                end;
            end;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TWVLoader.GetDLLHeaderMachine', e) then raise;
    end;
  finally
    if (TempStream <> nil) then FreeAndNil(TempStream);
  end;
end;

function TWVLoader.CheckBrowserExecPath : boolean;
begin
  Result := False;

  if (length(FBrowserExecPath) = 0) then
    begin
      if (length(InstalledRuntimeVersion) > 0) or
         SearchInstalledProgram('WebView2 Runtime', 'Microsoft Corporation') or
         (length(GetInternalAvailableBrowserVersion) > 0) then
        Result := True
       else
        begin
          FStatus := wvlsError;
          AppendErrorLog('WebView2 Runtime is not installed correctly.');
          AppendErrorLog('Download and run the Evergreen Standalone Installer from ');
          AppendErrorLog('https://developer.microsoft.com/en-us/microsoft-edge/webview2/#download-section');

          ShowErrorMessageDlg(ErrorMessage);
        end;
    end
   else
    try
      if FileExists(IncludeTrailingPathDelimiter(FBrowserExecPath) + 'msedgewebview2.exe') then
        Result := True
       else
        begin
          FStatus := wvlsError;
          AppendErrorLog('The Browser Executable Folder doesn' + #39 + 't exist.');

          ShowErrorMessageDlg(ErrorMessage);
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TWVLoader.CheckBrowserExecPath', e) then raise;
    end;
end;

function TWVLoader.CheckWebViewRuntimeVersion : boolean;
var
  TempCompRslt : integer;
begin
  Result := False;

  if (length(FBrowserExecPath) = 0) then
    Result := CompareVersions(InstalledRuntimeVersion, LowestChromiumVersion, TempCompRslt) and
              (TempCompRslt >= 0)
   else
    if CheckFileVersion(IncludeTrailingPathDelimiter(FBrowserExecPath) + 'msedgewebview2.exe',
                        CHROMIUM_VERSION_MAJOR,
                        CHROMIUM_VERSION_MINOR,
                        CHROMIUM_VERSION_RELEASE,
                        CHROMIUM_VERSION_BUILD) then
      Result := True;

  if not(Result) then
    begin
      AppendErrorLog('The WebView Runtime version is older than expected! Some WebView4Delphi features won' + #39 + 't work.');

      if FAllowOldRuntime then
        Result  := True
       else
        FStatus := wvlsError;
    end;
end;

function TWVLoader.Is32BitProcess : boolean;
begin
{$IFDEF TARGET_32BITS}
  Result := True;
{$ELSE}
  Result := False;
{$ENDIF}
end;

procedure TWVLoader.ShowErrorMessageDlg(const aError : wvstring);
begin
  if FShowMessageDlg then
    MessageBoxW(0, PWideChar(aError + #0), PWideChar(WideString('Error') + #0), MB_ICONERROR or MB_OK or MB_TOPMOST);
end;

function TWVLoader.CheckWV2DLL : boolean;
var
  TempMachine : integer;
  TempVersionInfo : TFileVersionInfo;
  TempLoaderLibPath : wvstring;
begin
  Result := False;

  if FUseInternalLoader then
    begin
      Result := True;
      exit;
    end;

  if FLoaderDllPath <> '' then
    TempLoaderLibPath := FLoaderDllPath
   else
    TempLoaderLibPath := WEBVIEW2LOADERLIB;

  if CheckFileVersion(TempLoaderLibPath,
                      WEBVIEW2LOADERLIB_VERSION_MAJOR,
                      WEBVIEW2LOADERLIB_VERSION_MINOR,
                      WEBVIEW2LOADERLIB_VERSION_RELEASE,
                      WEBVIEW2LOADERLIB_VERSION_BUILD) then
    begin
      if GetDLLHeaderMachine(TempLoaderLibPath, TempMachine) then
        case TempMachine of
          WV2_IMAGE_FILE_MACHINE_I386 :
            if Is32BitProcess then
              Result := True
             else
              begin
                FStatus := wvlsError;
                AppendErrorLog('Wrong WebView2Loader.dll !');
                AppendErrorLog('Use the 32 bit loader DLL with 32 bits applications only.');

                ShowErrorMessageDlg(ErrorMessage);
              end;

          WV2_IMAGE_FILE_MACHINE_AMD64 :
            if not(Is32BitProcess) then
              Result := True
             else

              begin
                FStatus := wvlsError;
                AppendErrorLog('Wrong WebView2Loader.dll !');
                AppendErrorLog('Use the 64 bit loader DLL with 64 bits applications only.');

                ShowErrorMessageDlg(ErrorMessage);
              end;

          else
            begin
              FStatus := wvlsError;
              AppendErrorLog('Unknown WebView2Loader.dll !');

              ShowErrorMessageDlg(ErrorMessage);
            end;
        end
       else
        Result := True;
    end
   else
    begin
      FStatus := wvlsError;

      if GetFileVersion(TempLoaderLibPath, TempVersionInfo) then
        begin
          AppendErrorLog('Unsupported WebView2Loader.dll version !');
          AppendErrorLog('Expected WebView2Loader.dll version : ' + LowestLoaderDLLVersion);
          AppendErrorLog('Found WebView2Loader.dll version : ' +
                         IntToStr(TempVersionInfo.MajorVer) + '.' +
                         IntToStr(TempVersionInfo.MinorVer) + '.' +
                         IntToStr(TempVersionInfo.Release)  + '.' +
                         IntToStr(TempVersionInfo.Build));
        end
       else
        AppendErrorLog('WebView2Loader.dll file not found !');

      ShowErrorMessageDlg(ErrorMessage);
    end;
end;

function TWVLoader.CheckWV2Library : boolean;
var
  TempOldDir : string;
begin
  if not(FCheckFiles) then
    begin
      Result := True;
      exit;
    end;

  if FSetCurrentDir then
    begin
      TempOldDir := GetCurrentDir;
      chdir(GetModulePath);
    end;

  Result := CheckBrowserExecPath and
            (FUseInternalLoader or CheckWV2DLL);

  if FSetCurrentDir then chdir(TempOldDir);
end;

function TWVLoader.SearchInstalledProgram(const aDisplayName, aPublisher : string) : boolean;
const
  UNINST_PATH_32BIT = 'SOFTWARE\Microsoft\Windows\CurrentVersion\UnInstall';
  UNINST_PATH_64BIT = 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall';
begin
  Result := SearchInstalledProgramInPath(UNINST_PATH_32BIT, aDisplayName, aPublisher, True)  or
            SearchInstalledProgramInPath(UNINST_PATH_32BIT, aDisplayName, aPublisher, False) or
            SearchInstalledProgramInPath(UNINST_PATH_64BIT, aDisplayName, aPublisher, True)  or
            SearchInstalledProgramInPath(UNINST_PATH_64BIT, aDisplayName, aPublisher, False);
end;

function TWVLoader.SearchInstalledProgramInPath(const aRegPath, aDisplayName, aPublisher : string; aLocalMachine : boolean) : boolean;
const
  DISPLAYNAME_KEY  = 'DisplayName';
  PUBLISHER_KEY    = 'Publisher';
var
  TempReg : TRegistry;
  TempKeys : TStringList;
  i, j : integer;
  TempDisplayName, TempPublisher, TempKey : string;
begin
  Result   := False;
  TempReg  := nil;
  TempKeys := nil;

  try
    try
      TempReg := TRegistry.Create;

      if aLocalMachine then
        TempReg.RootKey := HKEY_LOCAL_MACHINE
       else
        TempReg.RootKey := HKEY_CURRENT_USER;

      if TempReg.OpenKeyReadOnly(aRegPath) then
        begin
          TempKeys := TStringList.Create;
          TempReg.GetKeyNames(TStrings(TempKeys));
          TempReg.CloseKey;

          i := 0;
          j := TempKeys.Count;

          while (i < j) and not(Result) do
            begin
              TempKey := TempKeys[i];

              if TempReg.OpenKeyReadOnly(aRegPath + '\' + TempKey) then
                begin
                  if TempReg.ValueExists(DISPLAYNAME_KEY) then
                    TempDisplayName := lowercase(TempReg.ReadString(DISPLAYNAME_KEY))
                   else
                    TempDisplayName := '';

                  if TempReg.ValueExists(PUBLISHER_KEY) then
                    TempPublisher := lowercase(TempReg.ReadString(PUBLISHER_KEY))
                   else
                    TempPublisher := '';

                  Result := (Pos(lowercase(aDisplayName), TempDisplayName) > 0) and
                            (Pos(lowercase(aPublisher),   TempPublisher)   > 0);

                  TempReg.CloseKey;
                end;

              inc(i);
            end;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TWVLoader.SearchInstalledProgram', e) then raise;
    end;
  finally
    if (TempReg  <> nil) then FreeAndNil(TempReg);
    if (TempKeys <> nil) then FreeAndNil(TempKeys);
  end;
end;

function TWVLoader.LoadLibProcedures : boolean;
begin
  Result := False;

  if FUseInternalLoader then
    begin
      CreateCoreWebView2EnvironmentWithOptions                := Internal_CreateCoreWebView2EnvironmentWithOptions;
      CreateCoreWebView2Environment                           := Internal_CreateCoreWebView2Environment;
      GetAvailableCoreWebView2BrowserVersionString            := Internal_GetAvailableCoreWebView2BrowserVersionString;
      GetAvailableCoreWebView2BrowserVersionStringWithOptions := Internal_GetAvailableCoreWebView2BrowserVersionStringWithOptions;
      CompareBrowserVersions                                  := Internal_CompareBrowserVersions;
      FStatus := wvlsImported;
      Result  := True;
    end
   else
    if (FLibHandle <> 0) then
      try
        begin
          CreateCoreWebView2EnvironmentWithOptions                := GetProcAddress(FLibHandle, 'CreateCoreWebView2EnvironmentWithOptions');
          CreateCoreWebView2Environment                           := GetProcAddress(FLibHandle, 'CreateCoreWebView2Environment');
          GetAvailableCoreWebView2BrowserVersionString            := GetProcAddress(FLibHandle, 'GetAvailableCoreWebView2BrowserVersionString');
          GetAvailableCoreWebView2BrowserVersionStringWithOptions := GetProcAddress(FLibHandle, 'GetAvailableCoreWebView2BrowserVersionStringWithOptions');
          CompareBrowserVersions                                  := GetProcAddress(FLibHandle, 'CompareBrowserVersions');

          if assigned(CreateCoreWebView2EnvironmentWithOptions)                and
             assigned(CreateCoreWebView2Environment)                           and
             assigned(GetAvailableCoreWebView2BrowserVersionString)            and
             assigned(GetAvailableCoreWebView2BrowserVersionStringWithOptions) and
             assigned(CompareBrowserVersions)                                  then
            begin
              Result  := True;
              FStatus := wvlsImported;
            end
           else
            begin
              FStatus := wvlsError;
              AppendErrorLog('There was a problem loading the library procedures');

              ShowErrorMessageDlg(ErrorMessage);
            end;
        end;
      except
        on e : exception do
          if CustomExceptionHandler('TWVLoader.LoadLibProcedures', e) then raise;
      end;
end;

function TWVLoader.GetCustomCommandLineSwitches : wvstring;
var
  TempFeatures : wvstring;
  {$IFDEF VER140}
  TempDecimalSeparator : char;  // Only for Delphi 6
  {$ELSE}
  TempFormatSettings : TFormatSettings;
  {$ENDIF}
begin
  if not(FEnableGPU) then
    Result := '--disable-gpu --disable-gpu-compositing ';

  // The list of features you can enable is here :
  // https://chromium.googlesource.com/chromium/src/+/master/chrome/common/chrome_features.cc
  // https://source.chromium.org/chromium/chromium/src/+/main:content/public/common/content_features.cc
  // https://source.chromium.org/search?q=base::Feature
  TempFeatures := FEnableFeatures;

  // This is a workaround given by Microsoft to open MS Office documents in the web browser instead of downloading the files.
  if FOpenOfficeDocumentsInWebViewer then
    begin
      if (length(TempFeatures) > 0) then
        TempFeatures := TempFeatures + ',msOpenOfficeDocumentsInWebViewer'
       else
        TempFeatures := 'msOpenOfficeDocumentsInWebViewer';
    end;

  if FMicrosoftSignIn then
    begin
      if (length(TempFeatures) > 0) then
        TempFeatures := TempFeatures + ',msSingleSignOnOSForPrimaryAccountIsShared'
       else
        TempFeatures := 'msSingleSignOnOSForPrimaryAccountIsShared';
    end;

  if (FPostQuantumKyber = STATE_ENABLED) then
    begin
      if (length(TempFeatures) > 0) then
        TempFeatures := TempFeatures + ',PostQuantumKyber'
       else
        TempFeatures := 'PostQuantumKyber';
    end;

  if (length(TempFeatures) > 0) then
    Result := Result + '--enable-features=' + TempFeatures + ' ';

  // The list of features you can disable is here :
  // https://chromium.googlesource.com/chromium/src/+/master/chrome/common/chrome_features.cc
  // https://source.chromium.org/chromium/chromium/src/+/main:content/public/common/content_features.cc
  // https://source.chromium.org/search?q=base::Feature
  TempFeatures := FDisableFeatures;

  // This is the workaround given my Microsoft to disable the SmartScreen protection.
  if not(FSmartScreenProtectionEnabled) then
    begin
      if (length(TempFeatures) > 0) then
        TempFeatures := TempFeatures + ',msSmartScreenProtection'
       else
        TempFeatures := 'msSmartScreenProtection';
    end;

  // This is the workaround given my Microsoft to disable the "Download Edge" notifications.
  if FDisableEdgePitchNotification then
    begin
      if (length(TempFeatures) > 0) then
        TempFeatures := TempFeatures + ',msEdgeRose'
       else
        TempFeatures := 'msEdgeRose';
    end;

  if (FPostQuantumKyber = STATE_DISABLED) then
    begin
      if (length(TempFeatures) > 0) then
        TempFeatures := TempFeatures + ',PostQuantumKyber'
       else
        TempFeatures := 'PostQuantumKyber';
    end;

  if (length(TempFeatures) > 0) then
    Result := Result + '--disable-features=' + TempFeatures + ' ';

  // The list of Blink features you can enable is here :
  // https://cs.chromium.org/chromium/src/third_party/blink/renderer/platform/runtime_enabled_features.json5
  if (length(FEnableBlinkFeatures) > 0) then
    Result := Result + '--enable-blink-features=' + FEnableBlinkFeatures + ' ';

  // The list of Blink features you can disable is here :
  // https://cs.chromium.org/chromium/src/third_party/blink/renderer/platform/runtime_enabled_features.json5
  if (length(FDisableBlinkFeatures) > 0) then
    Result := Result + '--disable-blink-features=' + FDisableBlinkFeatures + ' ';

  // The list of Blink settings you can modify is here :
  // https://source.chromium.org/chromium/chromium/src/+/master:third_party/blink/renderer/core/frame/settings.json5
  if (length(FBlinkSettings) > 0) then
    Result := Result + '--blink-settings=' + FBlinkSettings + ' ';

  // https://source.chromium.org/chromium/chromium/src/+/master:base/base_switches.cc
  if (length(FForceFieldTrials) > 0) then
    Result := Result + '--force-fieldtrials=' + FForceFieldTrials + ' ';

  // https://source.chromium.org/chromium/chromium/src/+/master:components/variations/variations_switches.cc
  if (length(FForceFieldTrialParams) > 0) then
    Result := Result + '--force-fieldtrial-params=' + FForceFieldTrialParams + ' ';

  if FAllowInsecureLocalhost then
    Result := Result + '--allow-insecure-localhost ';

  if FDisableWebSecurity then
    Result := Result + '--disable-web-security ';

  case FTouchEvents of
    STATE_ENABLED  : Result := Result + '--touch-events=enabled ';
    STATE_DISABLED : Result := Result + '--touch-events=disabled ';
  end;

  if not(FHyperlinkAuditing) then
    Result := Result + '--no-pings ';

  case FAutoplayPolicy of
    appDocumentUserActivationRequired    :
      Result := Result + '--autoplay-policy=document-user-activation-required ';

    appNoUserGestureRequired             :
      Result := Result + '--autoplay-policy=no-user-gesture-required ';

    appUserGestureRequired               :
      Result := Result + '--autoplay-policy=user-gesture-required ';
  end;

  if FMuteAudio then
    Result := Result + '--mute-audio ';

  if (length(FDefaultEncoding) > 0) then
    Result := Result + '--default-encoding=' + FDefaultEncoding + ' ';

  if FKioskPrinting then
    Result := Result + '--kiosk-printing ';

  if FProxySettings.NoProxyServer then
    Result := Result + '--no-proxy-server '
   else
    begin
      if FProxySettings.AutoDetect then
        Result := Result + '--proxy-auto-detect ';

      if (length(FProxySettings.ByPassList) > 0) then
        Result := Result + '--proxy-bypass-list=' + FProxySettings.ByPassList + ' ';

      if (length(FProxySettings.PacUrl) > 0) then
        Result := Result + '--proxy-pac-url=' + FProxySettings.PacUrl + ' ';

      if (length(FProxySettings.Server) > 0) then
        Result := Result + '--proxy-server=' + FProxySettings.Server + ' ';
    end;

  if FAllowFileAccessFromFiles then
    Result := Result + '--allow-file-access-from-files ';

  if FAllowRunningInsecureContent then
    Result := Result + '--allow-running-insecure-content ';

  if FDisableBackgroundNetworking then
    Result := Result + '--disable-background-networking ';

  if (FForcedDeviceScaleFactor <> 0) then
    begin
      {$IFDEF VER140}         // Only for Delphi 6
        TempDecimalSeparator := DecimalSeparator;
        DecimalSeparator     := '.';
        Result := Result + '--force-device-scale-factor=' + FloatToStr(FForcedDeviceScaleFactor) + ' ';
        DecimalSeparator     := TempDecimalSeparator;
      {$ELSE}
        TempFormatSettings.DecimalSeparator := '.';
        Result := Result + '--force-device-scale-factor=' +
          {$IFDEF FPC}UTF8Decode({$ENDIF}FloatToStr(FForcedDeviceScaleFactor, TempFormatSettings){$IFDEF FPC}){$ENDIF} + ' ';
      {$ENDIF}
    end;

  if (FRemoteDebuggingPort > 0) then
    Result := Result + '--remote-debugging-port=' + inttostr(FRemoteDebuggingPort) + ' ';

  if (length(FRemoteAllowOrigins) > 0) then
    Result := Result + '--remote-allow-origins=' + FRemoteAllowOrigins + ' ';

  case FDebugLog of
    dlEnabled       : Result := Result + '--enable-logging ';
    dlEnabledStdOut : Result := Result + '--enable-logging=stdout ';
    dlEnabledStdErr : Result := Result + '--enable-logging=stderr ';
  end;

  case FDebugLogLevel of
    dllInfo    : Result := Result + '--log-level=0 ';
    dllWarning : Result := Result + '--log-level=1 ';
    dllError   : Result := Result + '--log-level=2 ';
    dllFatal   : Result := Result + '--log-level=3 ';
  end;

  if (length(FTreatInsecureOriginAsSecure) > 0) then
    Result := Result + '--unsafely-treat-insecure-origin-as-secure=' + FTreatInsecureOriginAsSecure + ' ';

  if FAutoAcceptCamAndMicCapture then
    Result := Result + '--auto-accept-camera-and-microphone-capture ';

  // The list of JavaScript flags is here :
  // https://chromium.googlesource.com/v8/v8/+/master/src/flags/flag-definitions.h
  if (length(FJavaScriptFlags) > 0) then
    Result := Result + '--js-flags="' + FJavaScriptFlags + '" ';

  if (length(FUserAgent) > 0) then
    Result := Result + '--user-agent="' + FUserAgent + '" ';

  if (length(FAdditionalBrowserArguments) > 0) then
    Result := Result + FAdditionalBrowserArguments
   else
    Result := trim(Result);
end;

function TWVLoader.CheckInstalledRuntimeRegEntry(aLocalMachine : boolean; const aPath : string; var aVersion : wvstring) : boolean;
const
  RUNTIME_REG_VERSION = 'pv';
var
  TempReg : TRegistry;
begin
  Result   := false;
  TempReg  := nil;
  aVersion := '';

  try
    try
      TempReg := TRegistry.Create;

      if aLocalMachine then
        TempReg.RootKey := HKEY_LOCAL_MACHINE
       else
        TempReg.RootKey := HKEY_CURRENT_USER;

      if TempReg.KeyExists(aPath)       and
         TempReg.OpenKeyReadOnly(aPath) then
        begin
          if TempReg.ValueExists(RUNTIME_REG_VERSION) then
            begin
              aVersion := {$IFDEF FPC}UTF8Decode({$ENDIF}TempReg.ReadString(RUNTIME_REG_VERSION){$IFDEF FPC}){$ENDIF};
              Result   := length(aVersion) > 0;
            end;

          TempReg.CloseKey;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TWVLoader.CheckInstalledRuntimeRegEntry', e) then raise;
    end;
  finally
    if (TempReg <> nil) then FreeAndNil(TempReg);
  end;
end;

function TWVLoader.GetInstalledRuntimeVersion : wvstring;
const
  RUNTIME_REG_PATH_32BIT  = 'SOFTWARE\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
  RUNTIME_REG_PATH_64BIT  = 'SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
var
  TempResult : wvstring;
begin
  Result := '';

  if CheckInstalledRuntimeRegEntry(False, RUNTIME_REG_PATH_32BIT, TempResult) or
     CheckInstalledRuntimeRegEntry(False, RUNTIME_REG_PATH_64BIT, TempResult) or
     CheckInstalledRuntimeRegEntry(True,  RUNTIME_REG_PATH_32BIT, TempResult) or
     CheckInstalledRuntimeRegEntry(True,  RUNTIME_REG_PATH_64BIT, TempResult) then
    Result := TempResult;
end;

function TWVLoader.GetErrorMessage : wvstring;
begin
  if assigned(FErrorLog) then
    Result := FErrorLog.Text
   else
    Result := '';
end;

function TWVLoader.GetFailureReportFolderPath : wvstring;
begin
  if EnvironmentIsInitialized then
    Result := FCoreWebView2Environment.FailureReportFolderPath
   else
    Result := '';
end;

function TWVLoader.CreateEnvironment : boolean;
var
  TempOptions : ICoreWebView2EnvironmentOptions;
  TempHandler : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
  TempHResult : HRESULT;
  TempSchemeRegistrations : TWVCustomSchemeRegistrationArray;
  i : integer;
begin
  Result                  := False;
  TempSchemeRegistrations := nil;

  try
    if (FStatus = wvlsImported) and not(EnvironmentIsInitialized) then
      begin
        doOnGetCustomSchemes(TempSchemeRegistrations);

        TempHandler := TCoreWebView2EnvironmentCompletedHandler.Create(self);

        TempOptions := TCoreWebView2EnvironmentOptions.Create(CustomCommandLineSwitches,
                                                              FLanguage,
                                                              FTargetCompatibleBrowserVersion,
                                                              FAllowSingleSignOnUsingOSPrimaryAccount,
                                                              FExclusiveUserDataFolderAccess,
                                                              FCustomCrashReportingEnabled,
                                                              TempSchemeRegistrations,
                                                              FEnableTrackingPrevention,
                                                              FAreBrowserExtensionsEnabled,
                                                              FChannelSearchKind,
                                                              FReleaseChannels,
                                                              FScrollBarStyle);

        TempHResult := CreateCoreWebView2EnvironmentWithOptions(PWideChar(FBrowserExecPath),
                                                                PWideChar(FUserDataFolder),
                                                                TempOptions,
                                                                TempHandler);

        if succeeded(TempHResult) then
          Result := True
         else
          begin
            FStatus := wvlsError;
            FError  := TempHResult;
            AppendErrorLog('There was an error creating the browser environment. (1)');
            AppendErrorLog('Error code : 0x' + {$IFDEF FPC}UTF8Decode({$ENDIF}inttohex(TempHResult, 8){$IFDEF FPC}){$ENDIF});
            AppendErrorLog(EnvironmentCreationErrorToString(TempHResult));

            ShowErrorMessageDlg(ErrorMessage);
          end;
      end;
  finally
    TempOptions := nil;
    TempHandler := nil;

    if assigned(TempSchemeRegistrations) then
      begin
        i := pred(length(TempSchemeRegistrations));
        while (i >= 0) do
          begin
            TempSchemeRegistrations[i] := nil;
            dec(i);
          end;
      end;
  end;
end;

function TWVLoader.GetInitialized : boolean;
begin
  Result := (FStatus = wvlsInitialized);
end;

function TWVLoader.GetInitializationError : boolean;
begin
  Result := (FStatus = wvlsError);
end;

function TWVLoader.GetEnvironmentIsInitialized : boolean;
begin
  Result := assigned(FCoreWebView2Environment) and
            FCoreWebView2Environment.Initialized;
end;

function TWVLoader.GetDefaultUserDataPath : string;
const
  CSIDL_LOCAL_APPDATA = $001c;
var
  TempPath : array [0..MAX_PATH] of char;
begin
  System.FillChar(TempPath, SizeOf(TempPath), 0);

  if SHGetSpecialFolderPath(0, TempPath, CSIDL_LOCAL_APPDATA, False) then
    Result := IncludeTrailingPathDelimiter(TempPath) + 'WebView2\UserData'
   else
    Result := '';
end;

function TWVLoader.GetEnvironment : ICoreWebView2Environment;
begin
  if EnvironmentIsInitialized then
    Result := FCoreWebView2Environment.BaseIntf
   else
    Result := nil;
end;

function TWVLoader.GetProcessInfos : ICoreWebView2ProcessInfoCollection;
begin
  if EnvironmentIsInitialized then
    Result := FCoreWebView2Environment.ProcessInfos
   else
    Result := nil;
end;

function TWVLoader.GetSupportsCompositionController : boolean;
begin
  Result := EnvironmentIsInitialized and
            FCoreWebView2Environment.SupportsCompositionController;
end;

function TWVLoader.GetSupportsControllerOptions : boolean;
begin
  Result := EnvironmentIsInitialized and
            FCoreWebView2Environment.SupportsControllerOptions;
end;

function TWVLoader.GetAvailableBrowserVersion : wvstring;
var
  TempVersion : PWideChar;
begin
  Result      := '';
  TempVersion := nil;

  if Initialized and
     succeeded(GetAvailableCoreWebView2BrowserVersionString(PWideChar(FBrowserExecPath), @TempVersion)) and
     assigned(TempVersion) then
    begin
      Result := TempVersion;
      CoTaskMemFree(TempVersion);
    end;
end;

function TWVLoader.GetInternalAvailableBrowserVersion : wvstring;
var
  TempVersion : PWideChar;
begin
  Result      := '';
  TempVersion := nil;

  if succeeded(Internal_GetAvailableCoreWebView2BrowserVersionString(PWideChar(FBrowserExecPath), @TempVersion)) and
     assigned(TempVersion) then
    begin
      Result := TempVersion;
      CoTaskMemFree(TempVersion);
    end;
end;

function TWVLoader.GetAvailableBrowserVersionWithOptions : wvstring;
var
  TempVersion : PWideChar;
  TempOptions : ICoreWebView2EnvironmentOptions;
  TempSchemeRegistrations : TWVCustomSchemeRegistrationArray;
  i : integer;
begin
  Result      := '';
  TempVersion := nil;
  TempOptions := nil;
  TempSchemeRegistrations := nil;

  if Initialized then
    try
      TempOptions := TCoreWebView2EnvironmentOptions.Create(CustomCommandLineSwitches,
                                                            FLanguage,
                                                            FTargetCompatibleBrowserVersion,
                                                            FAllowSingleSignOnUsingOSPrimaryAccount,
                                                            FExclusiveUserDataFolderAccess,
                                                            FCustomCrashReportingEnabled,
                                                            TempSchemeRegistrations,
                                                            FEnableTrackingPrevention,
                                                            FAreBrowserExtensionsEnabled,
                                                            FChannelSearchKind,
                                                            FReleaseChannels,
                                                            FScrollBarStyle);

      if succeeded(GetAvailableCoreWebView2BrowserVersionStringWithOptions(PWideChar(FBrowserExecPath), TempOptions, @TempVersion)) and
         assigned(TempVersion) then
        begin
          Result := TempVersion;
          CoTaskMemFree(TempVersion);
        end;
    finally
      TempOptions := nil;

      if assigned(TempSchemeRegistrations) then
        begin
          i := pred(length(TempSchemeRegistrations));
          while (i >= 0) do
            begin
              TempSchemeRegistrations[i] := nil;
              dec(i);
            end;
        end;
    end;
end;

function TWVLoader.CompareVersions(const aVersion1, aVersion2 : wvstring; var aCompRslt : integer) : boolean;
begin
  aCompRslt := 0;
  Result    := (FStatus in [wvlsImported, wvlsInitialized]) and
               succeeded(CompareBrowserVersions(PWideChar(aVersion1), PWideChar(aVersion2), @aCompRslt));
end;

procedure TWVLoader.AppendErrorLog(const aText : wvstring);
begin
  OutputDebugMessage(aText);
  if assigned(FErrorLog) then
    FErrorLog.Add(aText);
end;

procedure TWVLoader.UpdateDeviceScaleFactor;
begin
  if (FForcedDeviceScaleFactor <> 0) then
    FDeviceScaleFactor := FForcedDeviceScaleFactor
   else
    FDeviceScaleFactor := GetDeviceScaleFactor;
end;

function TWVLoader.StartWebView2 : boolean;
begin
  Result := False;

  if FInitCOMLibrary and not(FLocalCOMInitMade) then
    begin
      case CoInitializeEx(nil, COINIT_APARTMENTTHREADED) of
        S_OK, S_FALSE      :
          begin
            // To uninitialize the COM library gracefully on a thread, each
            // successful call to CoInitialize or CoInitializeEx, including any
            // call that returns S_FALSE, must be balanced by a corresponding
            // call to CoUninitialize.
            FLocalCOMInitMade := True;
            Result            := True;
          end;

        RPC_E_CHANGED_MODE : AppendErrorLog('A previous call to CoInitializeEx specified an incompatible concurrency model for this thread.');
        E_INVALIDARG       : AppendErrorLog('CoInitializeEx failed. One or more arguments are not valid.');
        E_OUTOFMEMORY      : AppendErrorLog('CoInitializeEx failed to allocate necessary memory.');
        E_UNEXPECTED       : AppendErrorLog('Unexpected CoInitializeEx failure.');
        else                 AppendErrorLog('Unknown CoInitializeEx failure.');
      end;

      if not(Result) then
        begin
          ShowErrorMessageDlg(ErrorMessage);
          exit;
        end;
    end;

  Result := CheckWV2Library            and
            LoadWebView2Library        and
            LoadLibProcedures          and
            CheckWebViewRuntimeVersion and
            CreateEnvironment;
end;

function TWVLoader.EnvironmentCompletedHandler_Invoke(      errorCode : HResult;
                                                      const result_   : ICoreWebView2Environment) : HRESULT;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(result_) then
    begin
      DestroyEnvironment;

      FCoreWebView2Environment := TCoreWebView2Environment.Create(result_);
      FCoreWebView2Environment.AddAllLoaderEvents(self);

      FStatus := wvlsInitialized;

      doOnEnvironmentCreated;
    end
   else
    begin
      FStatus   := wvlsError;
      FError    := errorCode;
      AppendErrorLog('There was a problem initializing the browser environment.');
      AppendErrorLog('Error code : 0x' + {$IFDEF FPC}UTF8Decode({$ENDIF}inttohex(errorCode, 8){$IFDEF FPC}){$ENDIF});
      AppendErrorLog(EnvironmentCreationErrorToString(errorCode));

      doOnInitializationError;
    end;
end;

function TWVLoader.NewBrowserVersionAvailableEventHandler_Invoke(const sender : ICoreWebView2Environment;
                                                                 const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnNewBrowserVersionAvailable(sender);
end;

function TWVLoader.BrowserProcessExitedEventHandler_Invoke(const sender : ICoreWebView2Environment;
                                                           const args   : ICoreWebView2BrowserProcessExitedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnBrowserProcessExitedEvent(sender, args);
end;

function TWVLoader.ProcessInfosChangedEventHandler_Invoke(const sender : ICoreWebView2Environment;
                                                          const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doProcessInfosChangedEvent(sender);
end;

// TWVProxySettings

constructor TWVProxySettings.Create;
begin
  inherited Create;

  FNoProxyServer := False;
  FAutoDetect    := False;
  FByPassList    := '';
  FPacUrl        := '';
  FServer        := '';
end;

initialization

finalization
  DestroyGlobalWebView2Loader

end.
