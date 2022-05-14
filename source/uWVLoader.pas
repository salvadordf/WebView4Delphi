unit uWVLoader;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF FPC}
  Windows, Classes, SysUtils, ActiveX, Registry, ShlObj, Math, Dialogs,
  {$ELSE}
  WinApi.Windows, System.Classes, System.SysUtils, WinApi.ActiveX, System.Win.Registry, Winapi.ShlObj, System.Math,
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
      FLibHandle                              : THandle;
      FErrorMsg                               : string;
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

      // Fields used to create the environment
      FAdditionalBrowserArguments             : wvstring;
      FLanguage                               : wvstring;
      FTargetCompatibleBrowserVersion         : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount : boolean;
      FExclusiveUserDataFolderAccess          : boolean;

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
      FDebugLog                               : TWV2DebugLog;
      FDebugLogLevel                          : TWV2DebugLogLevel;
      FJavaScriptFlags                        : wvstring;

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

      function  CreateEnvironment : boolean;
      procedure DestroyEnvironment;

      function  GetDLLVersion(const aDLLFile : wvstring; var aVersionInfo : TFileVersionInfo) : boolean;
      function  GetExtendedFileVersion(const aFileName : wvstring) : uint64;
      function  LoadLibProcedures : boolean;
      function  LoadWebView2Library : boolean;
      procedure UnLoadWebView2Library;
      function  CheckWV2Library : boolean;
      function  CheckBrowserExecPath : boolean;
      function  CheckWV2DLL : boolean;
      function  CheckDLLVersion(const aDLLFile : wvstring; aMajor, aMinor, aRelease, aBuild : uint16) : boolean;
      function  GetDLLHeaderMachine(const aDLLFile : string; var aMachine : integer) : boolean;
      function  Is32BitProcess : boolean;
      function  CheckInstalledRuntimeRegEntry(aLocalMachine : boolean; const aPath : string; var aVersion : wvstring) : boolean;
      procedure ShowErrorMessageDlg(const aError : string);
      function  SearchInstalledProgram(const aDisplayName, aPublisher : string) : boolean;
      function  SearchInstalledProgramInPath(const aRegPath, aDisplayName, aPublisher : string; aLocalMachine : boolean) : boolean;

      procedure doOnInitializationError; virtual;
      procedure doOnEnvironmentCreated; virtual;
      procedure doOnNewBrowserVersionAvailable(const aEnvironment: ICoreWebView2Environment); virtual;
      procedure doOnBrowserProcessExitedEvent(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs); virtual;
      procedure doProcessInfosChangedEvent(const sender: ICoreWebView2Environment); virtual;

      function  EnvironmentCompletedHandler_Invoke(errorCode: HResult; const createdEnvironment: ICoreWebView2Environment): HRESULT;
      function  NewBrowserVersionAvailableEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;
      function  BrowserProcessExitedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs): HRESULT;
      function  ProcessInfosChangedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;

      property  DefaultUserDataPath       : string              read GetDefaultUserDataPath;
      property  EnvironmentIsInitialized  : boolean             read GetEnvironmentIsInitialized;

    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      function    StartWebView2 : boolean;
      function    CompareVersions(const aVersion1, aVersion2 : wvstring; var aCompRslt : integer): boolean;
      procedure   UpdateDeviceScaleFactor; virtual;

      // Custom properties
      property Environment                            : ICoreWebView2Environment           read GetEnvironment;
      property Status                                 : TWV2LoaderStatus                   read FStatus;
      property AvailableBrowserVersion                : wvstring                           read GetAvailableBrowserVersion;                                                             // GetAvailableCoreWebView2BrowserVersionString
      property ErrorMessage                           : string                             read FErrorMsg;
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

      // Properties used to create the environment
      property BrowserExecPath                        : wvstring                           read FBrowserExecPath                         write FBrowserExecPath;                        // CreateCoreWebView2EnvironmentWithOptions "browserExecutableFolder" parameter
      property UserDataFolder                         : wvstring                           read FUserDataFolder                          write FUserDataFolder;                         // CreateCoreWebView2EnvironmentWithOptions "userDataFolder" parameter
      property AdditionalBrowserArguments             : wvstring                           read FAdditionalBrowserArguments              write FAdditionalBrowserArguments;             // ICoreWebView2EnvironmentOptions.get_AdditionalBrowserArguments
      property Language                               : wvstring                           read FLanguage                                write FLanguage;                               // ICoreWebView2EnvironmentOptions.get_Language
      property TargetCompatibleBrowserVersion         : wvstring                           read FTargetCompatibleBrowserVersion          write FTargetCompatibleBrowserVersion;         // ICoreWebView2EnvironmentOptions.get_TargetCompatibleBrowserVersion
      property AllowSingleSignOnUsingOSPrimaryAccount : boolean                            read FAllowSingleSignOnUsingOSPrimaryAccount  write FAllowSingleSignOnUsingOSPrimaryAccount; // ICoreWebView2EnvironmentOptions.get_AllowSingleSignOnUsingOSPrimaryAccount
      property ExclusiveUserDataFolderAccess          : boolean                            read FExclusiveUserDataFolderAccess           write FExclusiveUserDataFolderAccess;          // ICoreWebView2EnvironmentOptions2.Get_ExclusiveUserDataFolderAccess

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
      property DebugLog                               : TWV2DebugLog                       read FDebugLog                                write FDebugLog;                         // --enable-logging
      property DebugLogLevel                          : TWV2DebugLogLevel                  read FDebugLogLevel                           write FDebugLogLevel;                    // --log-level
      property JavaScriptFlags                        : wvstring                           read FJavaScriptFlags                         write FJavaScriptFlags;                  // --js-flags

      // ICoreWebView2Environment3 properties
      property SupportsCompositionController          : boolean                            read GetSupportsCompositionController;

      // ICoreWebView2Environment8 properties
      property ProcessInfos                           : ICoreWebView2ProcessInfoCollection read GetProcessInfos;

      // ICoreWebView2Environment10 properties
      property SupportsControllerOptions              : boolean                            read GetSupportsControllerOptions;

      // Custom events
      property OnEnvironmentCreated                   : TLoaderNotifyEvent                      read FOnEnvironmentCreated                    write FOnEnvironmentCreated;
      property OnInitializationError                  : TLoaderNotifyEvent                      read FOnInitializationError                   write FOnInitializationError;

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
  uWVCoreWebView2EnvironmentOptions;

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
  FStatus                                 := wvlsCreated;
  FLibHandle                              := 0;
  FErrorMsg                               := '';
  FError                                  := 0;
  FBrowserExecPath                        := '';
  FUserDataFolder                         := '';
  FSetCurrentDir                          := True;
  FCheckFiles                             := True;
  FShowMessageDlg                         := True;
  FInitCOMLibrary                         := {$IFDEF FPC}True{$ELSE}False{$ENDIF};
  FForcedDeviceScaleFactor                := 0;
  FReRaiseExceptions                      := False;
  FRemoteDebuggingPort                    := 0;

  UpdateDeviceScaleFactor;

  // Fields used to create the environment
  FAdditionalBrowserArguments             := '';
  FLanguage                               := '';
  FTargetCompatibleBrowserVersion         := LowestChromiumVersion;
  FAllowSingleSignOnUsingOSPrimaryAccount := False;
  FExclusiveUserDataFolderAccess          := False;

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
  FDebugLog                               := TWV2DebugLog.dlDisabled;
  FDebugLogLevel                          := TWV2DebugLogLevel.dllDefault;
  FJavaScriptFlags                        := '';

  FProxySettings := TWVProxySettings.Create;

  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
end;

destructor TWVLoader.Destroy;
begin
  try
    DestroyEnvironment;
    UnLoadWebView2Library;

    if FInitCOMLibrary then
      CoUnInitialize;

    FreeAndNil(FProxySettings);
  finally
    inherited Destroy;
  end;
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

function TWVLoader.GetDLLVersion(const aDLLFile : wvstring; var aVersionInfo : TFileVersionInfo) : boolean;
var
  TempVersion : uint64;
begin
  Result := False;

  try
    if FileExists(aDLLFile) then
      begin
        TempVersion := GetExtendedFileVersion(aDLLFile);

        if (TempVersion <> 0) then
          begin
            aVersionInfo.MajorVer := uint16(TempVersion shr 48);
            aVersionInfo.MinorVer := uint16((TempVersion shr 32) and $FFFF);
            aVersionInfo.Release  := uint16((TempVersion shr 16) and $FFFF);
            aVersionInfo.Build    := uint16(TempVersion and $FFFF);

            Result := True;
          end;
      end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVLoader.GetDLLVersion', e) then raise;
  end;
end;

function TWVLoader.LoadWebView2Library : boolean;
var
  TempOldDir : string;
begin
  Result := False;

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

        FStatus    := wvlsLoading;
        FLibHandle := LoadLibraryExW(PWideChar(WEBVIEW2LOADERLIB), 0, LOAD_WITH_ALTERED_SEARCH_PATH);

        if (FLibHandle = 0) then
          begin
            FStatus   := wvlsError;
            FError    := GetLastError;
            FErrorMsg := 'Error loading ' + WEBVIEW2LOADERLIB + CRLF + CRLF +
                         'Error code : 0x' + inttohex(cardinal(FError), 8) + CRLF +
                         SysErrorMessage(cardinal(FError));

            ShowErrorMessageDlg(FErrorMsg);
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

function TWVLoader.CheckDLLVersion(const aDLLFile : wvstring; aMajor, aMinor, aRelease, aBuild : uint16) : boolean;
var
  TempVersionInfo : TFileVersionInfo;
begin
  Result := False;

  if GetDLLVersion(aDLLFile, TempVersionInfo) then
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
          FStatus   := wvlsError;
          FErrorMsg := 'WebView2 Runtime is not installed correctly.' + CRLF + CRLF +
                       'Download and run the Evergreen Standalone Installer from ' + CRLF +
                       'https://developer.microsoft.com/en-us/microsoft-edge/webview2/#download-section';

          ShowErrorMessageDlg(FErrorMsg);
        end;
    end
   else
    if DirectoryExists(FBrowserExecPath) then
      Result := True
     else
      begin
        FStatus   := wvlsError;
        FErrorMsg := 'The Browser Executable Folder doesn' + #39 + 't exist.';

        ShowErrorMessageDlg(FErrorMsg);
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

procedure TWVLoader.ShowErrorMessageDlg(const aError : string);
begin
  if FShowMessageDlg then
    {$IFDEF FPC}
    ShowMessage(aError);
    {$ELSE}
    MessageBox(0, PChar(aError + #0), PChar('Error' + #0), MB_ICONERROR or MB_OK or MB_TOPMOST);
    {$ENDIF}
end;

function TWVLoader.CheckWV2DLL : boolean;
var
  TempMachine : integer;
  TempVersionInfo : TFileVersionInfo;
begin
  Result := False;

  if CheckDLLVersion(WEBVIEW2LOADERLIB,
                     WEBVIEW2LOADERLIB_VERSION_MAJOR,
                     WEBVIEW2LOADERLIB_VERSION_MINOR,
                     WEBVIEW2LOADERLIB_VERSION_RELEASE,
                     WEBVIEW2LOADERLIB_VERSION_BUILD) then
    begin
      if GetDLLHeaderMachine(WEBVIEW2LOADERLIB, TempMachine) then
        case TempMachine of
          WV2_IMAGE_FILE_MACHINE_I386 :
            if Is32BitProcess then
              Result := True
             else
              begin
                FStatus   := wvlsError;
                FErrorMsg := 'Wrong WebView2Loader.dll !' + CRLF + CRLF +
                             'Use the 32 bit loader DLL with 32 bits applications only.';

                ShowErrorMessageDlg(FErrorMsg);
              end;

          WV2_IMAGE_FILE_MACHINE_AMD64 :
            if not(Is32BitProcess) then
              Result := True
             else

              begin
                FStatus   := wvlsError;
                FErrorMsg := 'Wrong WebView2Loader.dll !' + CRLF + CRLF +
                             'Use the 64 bit loader DLL with 64 bits applications only.';

                ShowErrorMessageDlg(FErrorMsg);
              end;

          else
            begin
              FStatus   := wvlsError;
              FErrorMsg := 'Unknown WebView2Loader.dll !';

              ShowErrorMessageDlg(FErrorMsg);
            end;
        end
       else
        Result := True;
    end
   else
    begin
      FStatus   := wvlsError;
      FErrorMsg := 'Unsupported WebView2Loader.dll version !';

      if GetDLLVersion(WEBVIEW2LOADERLIB, TempVersionInfo) then
        begin
          FErrorMsg := FErrorMsg + CRLF + CRLF +
                       'Expected WebView2Loader.dll version : ';

          {$IFDEF FPC}
          FErrorMsg := FErrorMsg + UTF8Encode(LowestChromiumVersion);
          {$ELSE}
          FErrorMsg := FErrorMsg + LowestChromiumVersion;
          {$ENDIF}

          FErrorMsg := FErrorMsg + CRLF +
                       'Found WebView2Loader.dll version : ' +
                       IntToStr(TempVersionInfo.MajorVer) + '.' +
                       IntToStr(TempVersionInfo.MinorVer) + '.' +
                       IntToStr(TempVersionInfo.Release)  + '.' +
                       IntToStr(TempVersionInfo.Build);
        end;

      ShowErrorMessageDlg(FErrorMsg);
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
            CheckWV2DLL;

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

  try
    if (FLibHandle <> 0) then
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
            FStatus   := wvlsError;
            FErrorMsg := 'There was a problem loading the library procedures';

            ShowErrorMessageDlg(FErrorMsg);
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

  if not(FSmartScreenProtectionEnabled) then
    begin
      if (length(TempFeatures) > 0) then
        TempFeatures := TempFeatures + ',msSmartScreenProtection'
       else
        TempFeatures := 'msSmartScreenProtection';
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

  case FDebugLog of
    TWV2DebugLog.dlEnabled       : Result := Result + '--enable-logging ';
    TWV2DebugLog.dlEnabledStdOut : Result := Result + '--enable-logging=stdout ';
    TWV2DebugLog.dlEnabledStdErr : Result := Result + '--enable-logging=stderr ';
  end;

  case FDebugLogLevel of
    TWV2DebugLogLevel.dllInfo    : Result := Result + '--log-level=0 ';
    TWV2DebugLogLevel.dllWarning : Result := Result + '--log-level=1 ';
    TWV2DebugLogLevel.dllError   : Result := Result + '--log-level=2 ';
    TWV2DebugLogLevel.dllFatal   : Result := Result + '--log-level=3 ';
  end;

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
              {$IFDEF FPC}
              aVersion := UTF8Decode(TempReg.ReadString(RUNTIME_REG_VERSION));
              {$ELSE}
              aVersion := TempReg.ReadString(RUNTIME_REG_VERSION);
              {$ENDIF}
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
  RUNTIME_REG_PATH_32BIT = 'SOFTWARE\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
  RUNTIME_REG_PATH_64BIT = 'SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
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

function TWVLoader.CreateEnvironment : boolean;
var
  TempOptions : ICoreWebView2EnvironmentOptions;
  TempHandler : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
  TempHResult : HRESULT;
begin
  Result := False;

  try
    if (FStatus = wvlsImported) and not(EnvironmentIsInitialized) then
      begin
        TempHandler := TCoreWebView2EnvironmentCompletedHandler.Create(self);

        TempOptions := TCoreWebView2EnvironmentOptions.Create(CustomCommandLineSwitches,
                                                              FLanguage,
                                                              FTargetCompatibleBrowserVersion,
                                                              FAllowSingleSignOnUsingOSPrimaryAccount,
                                                              FExclusiveUserDataFolderAccess);

        TempHResult := CreateCoreWebView2EnvironmentWithOptions(PWideChar(FBrowserExecPath),
                                                                PWideChar(FUserDataFolder),
                                                                TempOptions,
                                                                TempHandler);

        if succeeded(TempHResult) then
          Result := True
         else
          begin
            FStatus   := wvlsError;
            FError    := TempHResult;
            FErrorMsg := 'There was an error creating the browser environment. (1)' + CRLF +
                         'Error code : 0x' +
                         {$IFDEF FPC}
                         UTF8Decode(inttohex(TempHResult, 8))
                         {$ELSE}
                         inttohex(TempHResult, 8)
                         {$ENDIF}
                         + CRLF + EnvironmentCreationErrorToString(TempHResult);

            ShowErrorMessageDlg(FErrorMsg);
          end;
      end;
  finally
    TempOptions := nil;
    TempHandler := nil;
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
var
  TempPath : array [0..MAX_PATH] of char;
begin
  System.FillChar(TempPath, SizeOf(TempPath), 0);

  if ShGetSpecialFolderPath(0, TempPath, CSIDL_LOCAL_APPDATA, False) then
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
  Result    := Initialized and
               succeeded(CompareBrowserVersions(PWideChar(aVersion1), PWideChar(aVersion2), @aCompRslt));
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
      FErrorMsg := 'There was a problem initializing the browser environment.' + CRLF + CRLF +
                   'Error code : 0x' + IntToHex(errorCode, 8) + CRLF +
                   {$IFDEF FPC}
                   UTF8Encode(EnvironmentCreationErrorToString(errorCode));
                   {$ELSE}
                   EnvironmentCreationErrorToString(errorCode);
                   {$ENDIF}

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
