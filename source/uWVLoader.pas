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
      FDeviceScaleFactor                      : single;
      FForcedDeviceScaleFactor                : single;
      FReRaiseExceptions                      : boolean;
      FLoaderDllPath                          : wvstring;
      FUseInternalLoader                      : boolean;

      // Fields used to create the environment
      FAdditionalBrowserArguments             : wvstring;
      FLanguage                               : wvstring;
      FTargetCompatibleBrowserVersion         : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount : boolean;
      FExclusiveUserDataFolderAccess          : boolean;
      FCustomCrashReportingEnabled            : boolean;
      FEnableTrackingPrevention               : boolean;

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

      function  GetAvailableBrowserVersion : wvstring;
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

      function  EnvironmentCompletedHandler_Invoke(errorCode: HResult; const createdEnvironment: ICoreWebView2Environment): HRESULT;
      function  NewBrowserVersionAvailableEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;
      function  BrowserProcessExitedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs): HRESULT;
      function  ProcessInfosChangedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;

      property  DefaultUserDataPath       : string              read GetDefaultUserDataPath;
      property  EnvironmentIsInitialized  : boolean             read GetEnvironmentIsInitialized;

    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;
      function    StartWebView2 : boolean;
      function    CompareVersions(const aVersion1, aVersion2 : wvstring; var aCompRslt : integer): boolean;
      procedure   UpdateDeviceScaleFactor; virtual;
      procedure   AppendErrorLog(const aText : wvstring);

      // Custom properties
      property Environment                            : ICoreWebView2Environment           read GetEnvironment;
      property Status                                 : TWV2LoaderStatus                   read FStatus;
      property AvailableBrowserVersion                : wvstring                           read GetAvailableBrowserVersion;                                                             // GetAvailableCoreWebView2BrowserVersionString
      property ErrorMessage                           : wvstring                           read GetErrorMessage;
      property ErrorCode                              : int64                              read FError;
      property SetCurrentDir                          : boolean                            read FSetCurrentDir                           write FSetCurrentDir;
      property Initialized                            : boolean                            read GetInitialized;
      property InitializationError                    : boolean                            read GetInitializationError;
      property CheckFiles                             : boolean                            read FCheckFiles                              write FCheckFiles;
      property ShowMessageDlg                         : boolean                            read FShowMessageDlg                          write FShowMessageDlg;
      property InitCOMLibrary                         : boolean                            read FInitCOMLibrary                          write FInitCOMLibrary;
      property CustomCommandLineSwitches              : wvstring                           read GetCustomCommandLineSwitches;
      property DeviceScaleFactor                      : single                             read FDeviceScaleFactor;
      property ReRaiseExceptions                      : boolean                            read FReRaiseExceptions                       write FReRaiseExceptions;
      property InstalledRuntimeVersion                : wvstring                           read GetInstalledRuntimeVersion;
      property LoaderDllPath                          : wvstring                           read FLoaderDllPath                           write FLoaderDllPath;
      property UseInternalLoader                      : boolean                            read FUseInternalLoader                       write FUseInternalLoader;

      // Properties used to create the environment
      property BrowserExecPath                        : wvstring                           read FBrowserExecPath                         write FBrowserExecPath;                        // CreateCoreWebView2EnvironmentWithOptions "browserExecutableFolder" parameter
      property UserDataFolder                         : wvstring                           read FUserDataFolder                          write FUserDataFolder;                         // CreateCoreWebView2EnvironmentWithOptions "userDataFolder" parameter
      property AdditionalBrowserArguments             : wvstring                           read FAdditionalBrowserArguments              write FAdditionalBrowserArguments;             // ICoreWebView2EnvironmentOptions.get_AdditionalBrowserArguments
      property Language                               : wvstring                           read FLanguage                                write FLanguage;                               // ICoreWebView2EnvironmentOptions.get_Language
      property TargetCompatibleBrowserVersion         : wvstring                           read FTargetCompatibleBrowserVersion          write FTargetCompatibleBrowserVersion;         // ICoreWebView2EnvironmentOptions.get_TargetCompatibleBrowserVersion
      property AllowSingleSignOnUsingOSPrimaryAccount : boolean                            read FAllowSingleSignOnUsingOSPrimaryAccount  write FAllowSingleSignOnUsingOSPrimaryAccount; // ICoreWebView2EnvironmentOptions.get_AllowSingleSignOnUsingOSPrimaryAccount
      property ExclusiveUserDataFolderAccess          : boolean                            read FExclusiveUserDataFolderAccess           write FExclusiveUserDataFolderAccess;          // ICoreWebView2EnvironmentOptions2.Get_ExclusiveUserDataFolderAccess
      property CustomCrashReportingEnabled            : boolean                            read FCustomCrashReportingEnabled             write FCustomCrashReportingEnabled;            // ICoreWebView2EnvironmentOptions3.Get_IsCustomCrashReportingEnabled
      property EnableTrackingPrevention               : boolean                            read FEnableTrackingPrevention                write FEnableTrackingPrevention;               // ICoreWebView2EnvironmentOptions5.Get_EnableTrackingPrevention

      // Properties used to set command line switches
      property EnableGPU                              : boolean                            read FEnableGPU                               write FEnableGPU;                        // --enable-gpu-plugin
      property EnableFeatures                         : wvstring                           read FEnableFeatures                          write FEnableFeatures;                   // --enable-features
      property DisableFeatures                        : wvstring                           read FDisableFeatures                         write FDisableFeatures;                  // --disable-features
      property EnableBlinkFeatures                    : wvstring                           read FEnableBlinkFeatures                     write FEnableBlinkFeatures;              // --enable-blink-features
      property DisableBlinkFeatures                   : wvstring                           read FDisableBlinkFeatures                    write FDisableBlinkFeatures;             // --disable-blink-features
      property BlinkSettings                          : wvstring                           read FBlinkSettings                           write FBlinkSettings;                    // --blink-settings
      property ForceFieldTrials                       : wvstring                           read FForceFieldTrials                        write FForceFieldTrials;                 // --force-fieldtrials
      property ForceFieldTrialParams                  : wvstring                           read FForceFieldTrialParams                   write FForceFieldTrialParams;            // --force-fieldtrial-params
      property SmartScreenProtectionEnabled           : boolean                            read FSmartScreenProtectionEnabled            write FSmartScreenProtectionEnabled;     // --disable-features=msSmartScreenProtection
      property AllowInsecureLocalhost                 : boolean                            read FAllowInsecureLocalhost                  write FAllowInsecureLocalhost;           // --allow-insecure-localhost
      property DisableWebSecurity                     : boolean                            read FDisableWebSecurity                      write FDisableWebSecurity;               // --disable-web-security
      property TouchEvents                            : TWVState                           read FTouchEvents                             write FTouchEvents;                      // --touch-events
      property HyperlinkAuditing                      : boolean                            read FHyperlinkAuditing                       write FHyperlinkAuditing;                // --no-pings
      property AutoplayPolicy                         : TWVAutoplayPolicy                  read FAutoplayPolicy                          write FAutoplayPolicy;                   // --autoplay-policy
      property MuteAudio                              : boolean                            read FMuteAudio                               write FMuteAudio;                        // --mute-audio
      property DefaultEncoding                        : wvstring                           read FDefaultEncoding                         write FDefaultEncoding;                  // --default-encoding
      property KioskPrinting                          : boolean                            read FKioskPrinting                           write FKioskPrinting;                    // --kiosk-printing
      property ProxySettings                          : TWVProxySettings                   read FProxySettings;                                                                   // --no-proxy-server  --proxy-auto-detect  --proxy-bypass-list  --proxy-pac-url  --proxy-server
      property AllowFileAccessFromFiles               : boolean                            read FAllowFileAccessFromFiles                write FAllowFileAccessFromFiles;         // --allow-file-access-from-files
      property AllowRunningInsecureContent            : boolean                            read FAllowRunningInsecureContent             write FAllowRunningInsecureContent;      // --allow-running-insecure-content
      property DisableBackgroundNetworking            : boolean                            read FDisableBackgroundNetworking             write FDisableBackgroundNetworking;      // --disable-background-networking
      property ForcedDeviceScaleFactor                : single                             read FForcedDeviceScaleFactor                 write FForcedDeviceScaleFactor;          // --force-device-scale-factor
      property RemoteDebuggingPort                    : integer                            read FRemoteDebuggingPort                     write FRemoteDebuggingPort;              // --remote-debugging-port
      property RemoteAllowOrigins                     : wvstring                           read FRemoteAllowOrigins                      write FRemoteAllowOrigins;               // --remote-allow-origins
      property DebugLog                               : TWV2DebugLog                       read FDebugLog                                write FDebugLog;                         // --enable-logging
      property DebugLogLevel                          : TWV2DebugLogLevel                  read FDebugLogLevel                           write FDebugLogLevel;                    // --log-level
      property JavaScriptFlags                        : wvstring                           read FJavaScriptFlags                         write FJavaScriptFlags;                  // --js-flags
      property DisableEdgePitchNotification           : boolean                            read FDisableEdgePitchNotification            write FDisableEdgePitchNotification;     // --disable-features=msEdgeRose
      property TreatInsecureOriginAsSecure            : wvstring                           read FTreatInsecureOriginAsSecure             write FTreatInsecureOriginAsSecure;      // --unsafely-treat-insecure-origin-as-secure


      // ICoreWebView2Environment3 properties
      property SupportsCompositionController          : boolean                            read GetSupportsCompositionController;

      // ICoreWebView2Environment8 properties
      property ProcessInfos                           : ICoreWebView2ProcessInfoCollection read GetProcessInfos;

      // ICoreWebView2Environment10 properties
      property SupportsControllerOptions              : boolean                            read GetSupportsControllerOptions;

      // ICoreWebView2Environment11 properties
      property FailureReportFolderPath                : wvstring                           read GetFailureReportFolderPath;

      // Custom events
      property OnEnvironmentCreated                   : TLoaderNotifyEvent                      read FOnEnvironmentCreated                    write FOnEnvironmentCreated;
      property OnInitializationError                  : TLoaderNotifyEvent                      read FOnInitializationError                   write FOnInitializationError;
      property OnGetCustomSchemes                     : TLoaderGetCustomSchemesEvent            read FOnGetCustomSchemes                      write FOnGetCustomSchemes;

      // ICoreWebView2Environment events
      property OnNewBrowserVersionAvailable           : TLoaderNewBrowserVersionAvailableEvent  read FOnNewBrowserVersionAvailable            write FOnNewBrowserVersionAvailable;

      // ICoreWebView2Environment5 events
      property OnBrowserProcessExited                 : TLoaderBrowserProcessExitedEvent        read FOnBrowserProcessExited                  write FOnBrowserProcessExited;

      // ICoreWebView2Environment8 events
      property OnProcessInfosChanged                  : TLoaderProcessInfosChangedEvent         read FOnProcessInfosChanged                   write FOnProcessInfosChanged;
  end;

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
  FForcedDeviceScaleFactor                := 0;
  FReRaiseExceptions                      := False;
  FLoaderDllPath                          := '';
  FUseInternalLoader                      := False;
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
  FProxySettings                          := nil;
  FErrorLog                               := nil;

  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
end;

destructor TWVLoader.Destroy;
begin
  try
    DestroyEnvironment;
    UnLoadWebView2Library;

    if FInitCOMLibrary then
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
         SearchInstalledProgram('WebView2 Runtime', 'Microsoft Corporation') then
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
    AppendErrorLog('The WebView Runtime version is older than expected! Some WebView4Delphi features won'+ #39 + 't work.');
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
      AppendErrorLog('Unsupported WebView2Loader.dll version !');

      if GetFileVersion(TempLoaderLibPath, TempVersionInfo) then
        begin
          AppendErrorLog('Expected WebView2Loader.dll version : ' + LowestLoaderDLLVersion);
          AppendErrorLog('Found WebView2Loader.dll version : ' +
                         IntToStr(TempVersionInfo.MajorVer) + '.' +
                         IntToStr(TempVersionInfo.MinorVer) + '.' +
                         IntToStr(TempVersionInfo.Release)  + '.' +
                         IntToStr(TempVersionInfo.Build));
        end;

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
      CreateCoreWebView2EnvironmentWithOptions     := Internal_CreateCoreWebView2EnvironmentWithOptions;
      CreateCoreWebView2Environment                := Internal_CreateCoreWebView2Environment;
      GetAvailableCoreWebView2BrowserVersionString := Internal_GetAvailableCoreWebView2BrowserVersionString;
      CompareBrowserVersions                       := Internal_CompareBrowserVersions;
      FStatus := wvlsImported;
      Result := True;
    end
   else
    if (FLibHandle <> 0) then
      try
        begin
          CreateCoreWebView2EnvironmentWithOptions      := GetProcAddress(FLibHandle, 'CreateCoreWebView2EnvironmentWithOptions');
          CreateCoreWebView2Environment                 := GetProcAddress(FLibHandle, 'CreateCoreWebView2Environment');
          GetAvailableCoreWebView2BrowserVersionString  := GetProcAddress(FLibHandle, 'GetAvailableCoreWebView2BrowserVersionString');
          CompareBrowserVersions                        := GetProcAddress(FLibHandle, 'CompareBrowserVersions');

          if assigned(CreateCoreWebView2EnvironmentWithOptions)     and
             assigned(CreateCoreWebView2Environment)                and
             assigned(GetAvailableCoreWebView2BrowserVersionString) and
             assigned(CompareBrowserVersions)                       then
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

  if Result then
    CheckWebViewRuntimeVersion;
end;

function TWVLoader.GetCustomCommandLineSwitches : wvstring;
var
  TempFeatures : wvstring;
  TempFormatSettings : TFormatSettings;
begin
  if not(FEnableGPU) then
    Result := '--disable-gpu --disable-gpu-compositing ';

  // The list of features you can enable is here :
  // https://chromium.googlesource.com/chromium/src/+/master/chrome/common/chrome_features.cc
  // https://source.chromium.org/chromium/chromium/src/+/main:content/public/common/content_features.cc
  // https://source.chromium.org/search?q=base::Feature
  if (length(FEnableFeatures) > 0) then
    Result := Result + '--enable-features=' + FEnableFeatures + ' ';

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
      TempFormatSettings.DecimalSeparator := '.';
      Result := Result + '--force-device-scale-factor=' +
        {$IFDEF FPC}
        UTF8Decode(FloatToStr(FForcedDeviceScaleFactor, TempFormatSettings)) + ' ';
        {$ELSE}
        FloatToStr(FForcedDeviceScaleFactor, TempFormatSettings) + ' ';
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

  // The list of JavaScript flags is here :
  // https://chromium.googlesource.com/v8/v8/+/master/src/flags/flag-definitions.h
  if (length(FJavaScriptFlags) > 0) then
    Result := Result + '--js-flags="' + FJavaScriptFlags + '" ';

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
                                                              FEnableTrackingPrevention);

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
  if FInitCOMLibrary then
    CoInitializeEx(nil, COINIT_APARTMENTTHREADED);

  Result := CheckWV2Library     and
            LoadWebView2Library and
            LoadLibProcedures   and
            CreateEnvironment;
end;

function TWVLoader.EnvironmentCompletedHandler_Invoke(      errorCode          : HResult;
                                                      const createdEnvironment : ICoreWebView2Environment) : HRESULT;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(createdEnvironment) then
    begin
      DestroyEnvironment;

      FCoreWebView2Environment := TCoreWebView2Environment.Create(createdEnvironment);
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
