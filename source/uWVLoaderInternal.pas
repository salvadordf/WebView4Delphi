unit uWVLoaderInternal;
// Based on
//   https://github.com/YWtheGod/DRT/blob/main/SOURCE/DRT.WIN.WebView2Loader.pas
//   https://github.com/jchv/OpenWebView2Loader

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  WinApi.Windows, WinApi.ShlObj, WinApi.ActiveX,
  {$ELSE}
  Windows,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

function Internal_CreateCoreWebView2EnvironmentWithOptions(browserExecutableFolder, userDataFolder: LPCWSTR; const environmentOptions: ICoreWebView2EnvironmentOptions; const environment_created_handler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
function Internal_CreateCoreWebView2Environment(const environment_created_handler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
function Internal_GetAvailableCoreWebView2BrowserVersionString(browserExecutableFolder: LPCWSTR; pVersionInfo: PLPWSTR): HRESULT; stdcall;
function Internal_GetAvailableCoreWebView2BrowserVersionStringWithOptions(browserExecutableFolder: LPCWSTR; const environmentOptions: ICoreWebView2EnvironmentOptions; pVersionInfo: PLPWSTR): HRESULT; stdcall;
function Internal_CompareBrowserVersions(version1, version2: LPCWSTR; pRet: PInteger): HRESULT; stdcall;

implementation

uses
  {$IFDEF DELPHI16_UP}
  IOUtils, System.Win.Registry,
  {$ELSE}
  ActiveX, Registry,
  {$ENDIF}
  SysUtils,
  uWVMiscFunctions;

type
  TWebView2ReleaseChannelPreference = (kStable = 0, kCanary = 1);

  TWebView2EnvironmentParams = record
    embeddedEdgeSubFolder    : wvstring;
    userDataDir              : wvstring;
    environmentOptions       : ICoreWebView2EnvironmentOptions;
    releaseChannelPreference : TWebView2ReleaseChannelPreference;
  end;

function DoesPolicyExistInRoot(aRootKey : HKEY): boolean;
const
  REDIST_OVERRIDE_KEY = 'Software\Policies\Microsoft\Edge\WebView2\';
var
  TempReg : TRegistry;
begin
  Result  := False;
  TempReg := nil;

  try
    try
      TempReg         := TRegistry.Create(KEY_READ);
      TempReg.RootKey := aRootKey;
      Result          := TempReg.KeyExists(REDIST_OVERRIDE_KEY) and
                         TempReg.OpenKey(REDIST_OVERRIDE_KEY, False);
    except
      on e : exception do
        if CustomExceptionHandler('DoesPolicyExistInRoot', e) then raise;
    end;
  finally
    if assigned(TempReg) then FreeAndNil(TempReg);
  end;
end;

function ReadEnvironmentVariable(const aName  : wvstring;
                                 var   aValue : wvstring): boolean;
var
  TempValue : wvstring;
begin
  TempValue := GetEnvironmentVariable(aName);

  if (TempValue <> '') then
    begin
      aValue := TempValue;
      Result := True;
    end
   else
    Result := False;
end;

function GetAppUserModelIdForCurrentProcess(var idOut: wvstring): HRESULT;
type
  GetCurrentApplicationUserModelIdProc        = function(var applicationUserModelIdLength: Cardinal; applicationUserModelId: PWideChar): HRESULT; stdcall;
  GetCurrentProcessExplicitAppUserModelIDProc = function(var AppID: LPWSTR): HRESULT; stdcall;
var
  LGetCurrentApplicationUserModelId        : GetCurrentApplicationUserModelIdProc;
  LGetCurrentProcessExplicitAppUserModelID : GetCurrentProcessExplicitAppUserModelIDProc;
  TempLen   : Cardinal;
  TempAppID : PWideChar;
begin
  Result := E_NOTIMPL;
  idOut  := '';

  // GetCurrentApplicationUserModelId is only available in Windows 8 or newer
  if (Win32MajorVersion > 6) or
     ((Win32MajorVersion = 6) and (Win32MinorVersion >= 2)) then
    begin
      LGetCurrentApplicationUserModelId := GetProcAddress(GetModuleHandleW('Kernel32.dll'), 'GetCurrentApplicationUserModelId');
      TempLen := 0;

      if assigned(LGetCurrentApplicationUserModelId) and
         (LGetCurrentApplicationUserModelId(TempLen, nil) = ERROR_INSUFFICIENT_BUFFER) then
        begin
          SetLength(idOut, TempLen);
          if (LGetCurrentApplicationUserModelId(TempLen, PWideChar(idOut)) = ERROR_SUCCESS) then
            begin
              idOut  := trim(idOut);
              Result := S_OK;
              exit;
            end;
        end;
    end;

  // GetCurrentProcessExplicitAppUserModelID is only available in Windows 7 or newer
  if (Win32MajorVersion > 6) or
     ((Win32MajorVersion = 6) and (Win32MinorVersion >= 1)) then
    begin
      LGetCurrentProcessExplicitAppUserModelID := GetProcAddress(GetModuleHandleW('shell32.dll'), 'GetCurrentProcessExplicitAppUserModelID');
      TempLen := 0;

      if assigned(LGetCurrentProcessExplicitAppUserModelID) then
        begin
          TempAppID := nil;
          Result    := LGetCurrentProcessExplicitAppUserModelID(TempAppID);

          if succeeded(Result) then
            idOut := TempAppID;

          if assigned(TempAppID) then
            CoTaskMemFree(TempAppID);
        end;
    end;
end;

function GetModulePath(h: HModule; var outPath: wvstring): HRESULT;
const
  CUSTOM_MAX_PATH = $1000;
var
  TempLen : Cardinal;
begin
  SetLength(outPath, MAX_PATH);
  TempLen := GetModuleFileNameW(h, PWideChar(outPath), MAX_PATH);

  if (GetLastError() = ERROR_INSUFFICIENT_BUFFER) then
    begin
      SetLength(outPath, CUSTOM_MAX_PATH);
      TempLen := GetModuleFileNameW(h, PWideChar(outPath), CUSTOM_MAX_PATH);
    end;

  if (TempLen = 0) or (TempLen > CUSTOM_MAX_PATH) then
    Result := HResultFromWin32(GetLastError())
   else
    begin
      Result  := S_OK;
      outPath := copy(outPath, 1, TempLen);
    end;
end;

var
  gShouldCheckPolicyOverride   : boolean = True;
  gShouldCheckRegistryOverride : boolean = True;

function ReadOverrideFromRegistry(const aKey     : wvstring;
                                        aRootKey : HKEY;
                                  const aValue   : wvstring;
                                  var   aResult  : boolean;
                                        aRedist  : boolean): boolean; overload;
var
  TempKey : wvstring;
  TempReg : TRegistry;
begin
  Result  := False;
  TempReg := nil;

  try
    try
      if (aKey <> '') then
        begin
          TempReg         := TRegistry.Create(KEY_READ);
          TempReg.RootKey := aRootKey;

          if aRedist then
            TempKey := 'Software\Policies\Microsoft\Edge\WebView2\' + aKey
           else
            TempKey := 'Software\Policies\Microsoft\EmbeddedBrowserWebView\LoaderOverride\' + aKey;

          if TempReg.KeyExists(TempKey) and
             TempReg.OpenKey(TempKey, False) then
            begin
              gShouldCheckRegistryOverride := True;

              case TempReg.GetDataType(aValue) of
                rdInteger :
                  begin
                    aResult := TempReg.ReadInteger(aValue) = 1;
                    Result  := True;
                  end;

                rdString :
                  begin
                    aResult := TempReg.ReadString(aValue) = '1';
                    Result  := True;
                  end;
              end;
            end;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('ReadOverrideFromRegistry', e) then raise;
    end;
  finally
    if assigned(TempReg) then FreeAndNil(TempReg);
  end;
end;

function ReadOverrideFromRegistry(const aKey     : wvstring;
                                        aRootKey : HKEY;
                                  const aValue   : wvstring;
                                  var   aResult  : wvstring;
                                        aRedist  : boolean): boolean; overload;
var
  TempKey : wvstring;
  TempReg : TRegistry;
begin
  Result  := False;
  TempReg := nil;

  try
    try
      if (aKey <> '') then
        begin
          TempReg         := TRegistry.Create(KEY_READ);
          TempReg.RootKey := aRootKey;

          if aRedist then
            TempKey := 'Software\Policies\Microsoft\Edge\WebView2\' + aKey
           else
            TempKey := 'Software\Policies\Microsoft\EmbeddedBrowserWebView\LoaderOverride\' + aKey;

          if TempReg.KeyExists(TempKey) and
             TempReg.OpenKey(TempKey, False) then
            begin
              gShouldCheckRegistryOverride := True;

              if (TempReg.GetDataType(aValue) = rdString) then
                begin
                  aResult := TempReg.ReadString(aValue);
                  Result  := (aResult <> '');
                end;
            end;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('ReadOverrideFromRegistry', e) then raise;
    end;
  finally
    if assigned(TempReg) then FreeAndNil(TempReg);
  end;
end;

function UpdateParamsWithRegOverrides(const aKey     : wvstring;
                                            aRootKey : HKEY;
                                      var   aResult  : boolean;
                                            aRedist  : boolean): boolean; overload;
var
  TempExe, TempID, TempPath: wvstring;
begin
  Result := False;
  GetAppUserModelIdForCurrentProcess(TempID);

  if succeeded(GetModulePath(0, TempPath)) then
    TempExe := ExtractFileName(TempPath)
   else
    TempExe := '';

  if gShouldCheckPolicyOverride and aRedist then
    begin
      if ReadOverrideFromRegistry(aKey, aRootKey, TempID, aResult, aRedist) or
         ReadOverrideFromRegistry(aKey, aRootKey, TempExe, aResult, aRedist) or
         ReadOverrideFromRegistry(aKey, aRootKey, '*', aResult, aRedist) then
        Result := True;
    end
   else
    if ReadOverrideFromRegistry(TempID, aRootKey, aKey, aResult, aRedist) or
       ReadOverrideFromRegistry(TempExe, aRootKey, aKey, aResult, aRedist) or
       ReadOverrideFromRegistry('*', aRootKey, aKey, aResult, aRedist) then
      Result := True;
end;

function UpdateParamsWithRegOverrides(const aKey     : wvstring;
                                            aRootKey : HKEY;
                                      var   aResult  : wvstring;
                                            aRedist  : boolean): boolean; overload;
var
  TempExe, TempID, TempPath: wvstring;
begin
  Result := False;
  GetAppUserModelIdForCurrentProcess(TempID);

  if succeeded(GetModulePath(0, TempPath)) then
    TempExe := ExtractFileName(TempPath)
   else
    TempExe := '';

  if gShouldCheckPolicyOverride and aRedist then
    begin
      if ReadOverrideFromRegistry(aKey, aRootKey, TempID, aResult, aRedist) or
         ReadOverrideFromRegistry(aKey, aRootKey, TempExe, aResult, aRedist) or
         ReadOverrideFromRegistry(aKey, aRootKey, '*', aResult, aRedist) then
        Result := True;
    end
   else
    if ReadOverrideFromRegistry(TempID, aRootKey, aKey, aResult, aRedist) or
       ReadOverrideFromRegistry(TempExe, aRootKey, aKey, aResult, aRedist) or
       ReadOverrideFromRegistry('*', aRootKey, aKey, aResult, aRedist) then
      Result := True;
end;

function UpdateParamsWithOverrides(const env           : wvstring;
                                   const key           : wvstring;
                                   var   ret           : boolean;
                                         checkOverride : boolean): boolean; overload;
var
  outStr: wvstring;
begin
  if checkOverride then
    begin
      gShouldCheckPolicyOverride   := True;
      gShouldCheckRegistryOverride := True;
    end;

  if ReadEnvironmentVariable(env, outStr) then
    Result := True
   else
    if not(gShouldCheckRegistryOverride) and
       not(gShouldCheckPolicyOverride)   and
       not(checkOverride)                then
      Result := False
     else
      begin
        gShouldCheckRegistryOverride := False;
        gShouldCheckPolicyOverride   := DoesPolicyExistInRoot(HKEY_CURRENT_USER) or
                                        DoesPolicyExistInRoot(HKEY_LOCAL_MACHINE);

        Result := UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, True)  or
                  UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER,  outStr, True)  or
                  UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, False) or
                  UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER,  outStr, False);
     end;
end;

function UpdateParamsWithOverrides(const env           : wvstring;
                                   const key           : wvstring;
                                   var   outStr        : wvstring;
                                         checkOverride : boolean): boolean; overload;
begin
  if checkOverride then
    begin
      gShouldCheckPolicyOverride   := True;
      gShouldCheckRegistryOverride := True;
    end;

  if ReadEnvironmentVariable(env, outStr) then
    Result := True
   else
    if not(gShouldCheckRegistryOverride) and
       not(gShouldCheckPolicyOverride)   and
       not(checkOverride)                then
      Result := False
     else
      begin
        gShouldCheckRegistryOverride := False;
        gShouldCheckPolicyOverride   := DoesPolicyExistInRoot(HKEY_CURRENT_USER) or
                                        DoesPolicyExistInRoot(HKEY_LOCAL_MACHINE);

        Result := UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, True)  or
                  UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER,  outStr, True)  or
                  UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, False) or
                  UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER,  outStr, False);
      end;
end;

procedure UpdateWebViewEnvironmentParamsWithOverrideValues(var aParams : TWebView2EnvironmentParams);
begin
  UpdateParamsWithOverrides('WEBVIEW2_BROWSER_EXECUTABLE_FOLDER',
                            'browserExecutableFolder',
                            aParams.embeddedEdgeSubFolder,
                            True);

  UpdateParamsWithOverrides('WEBVIEW2_USER_DATA_FOLDER',
                            'userDataFolder',
                            aParams.userDataDir,
                            True);

  UpdateParamsWithOverrides('WEBVIEW2_RELEASE_CHANNEL_PREFERENCE',
                            'releaseChannelPreference',
                            boolean(aParams.releaseChannelPreference),
                            True);
end;

const
  kChannelUuid: array [0 .. 4] of wvstring = ('{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}',
                                              '{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}',
                                              '{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}',
                                              '{65C35B14-6C1D-4122-AC46-7148CC9D6497}',
                                              '{BE59E8FD-089A-411B-A3B0-051D9E417818}');

procedure GetInstallKeyPathForChannel(channel: Cardinal; var outRegistryKey: wvstring);
begin
  outRegistryKey := 'Software\Microsoft\EdgeUpdate\ClientState\' + kChannelUuid[channel];
end;

procedure GetInstallKeyPathForChannel2(channel: Cardinal; var outRegistryKey: wvstring);
begin
  outRegistryKey := 'Software\WOW6432Node\Microsoft\EdgeUpdate\ClientState\' + kChannelUuid[channel];
end;

type
  TVersionRec = array [0 .. 3] of Cardinal;

function ParseVersionNumbers(s: wvstring; var o: TVersionRec): boolean;
var
  i: integer;
  E: integer;
  t: wvstring;
begin
  Result := False;

  for i := 0 to 3 do
    begin
      if (s = '') then exit;

      val(s, o[i], E);

      if (E = 0) then
        begin
          t := s;
          s := '';
        end
       else
        begin
          t := copy(s, 1, E - 1);
          s := copy(s, E + 1, length(s));
        end;

      val(t, o[i], E);
    end;

  Result := True;
end;

function FindClientDllInFolder(var folder: wvstring): boolean;
const
{$IFDEF WIN64}
  EMBEDDED_WEBVIEW_PATH = 'EBWebView\x64\EmbeddedBrowserWebView.dll';
{$ELSE}
  {$IFDEF CPUARM64}
  EMBEDDED_WEBVIEW_PATH = 'EBWebView\arm64\EmbeddedBrowserWebView.dll';
  {$ELSE}
  EMBEDDED_WEBVIEW_PATH = 'EBWebView\x86\EmbeddedBrowserWebView.dll';
  {$ENDIF}
{$ENDIF}
begin
  folder := IncludeTrailingPathDelimiter(folder) + EMBEDDED_WEBVIEW_PATH;
  Result := FileExists(folder);
end;

function CheckVersionAndFindClientDllInFolder(const version: TVersionRec; var path: wvstring): boolean;
const
  kMinimumCompatibleVersion: array [0 .. 3] of Cardinal = (86, 0, 616, 0);
var
  i: integer;
begin
  Result := False;

  for i := 0 to 3 do
    if (version[i] < kMinimumCompatibleVersion[i]) then
      exit
     else
      if (version[i] > kMinimumCompatibleVersion[i]) then
        break;

  Result := FindClientDllInFolder(path);
end;

function FindInstalledClientDllForChannel(const aSubKey     : wvstring;
                                                aSystem     : boolean;
                                          var   aVersion    : wvstring;
                                          var   aClientPath : wvstring): boolean;
var
  TempReg : TRegistry;
  TempVer : TVersionRec;
begin
  Result  := False;
  TempReg := nil;

  try
    try
      TempReg := TRegistry.Create(KEY_READ);

      if aSystem then
        TempReg.RootKey := HKEY_LOCAL_MACHINE
       else
        TempReg.RootKey := HKEY_CURRENT_USER;

      if TempReg.KeyExists(aSubKey) and
         TempReg.OpenKey(aSubKey, False) then
        begin
          aClientPath := TempReg.ReadString('EBWebView');

          if (aClientPath <> '') then
            begin
              aVersion := ExtractFileName(aClientPath);

              if ParseVersionNumbers(aVersion, TempVer) then
                Result := CheckVersionAndFindClientDllInFolder(TempVer, aClientPath);
            end;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('FindInstalledClientDllForChannel', e) then raise;
    end;
  finally
    if assigned(TempReg) then FreeAndNil(TempReg);
  end;
end;

type
  TGetCurrentPackageInfoProc = function(flags: Cardinal; var bufferlength: Cardinal; buffer: pointer; var count: Cardinal): HRESULT;

  TPACKAGE_VERSION = record
    case integer of
      0: (version: UInt64);
      1: (Revision, Build, Minor, Major: Word)
    end;

  TPACKAGE_ID = record
    reserved, processorArchitecture: Cardinal;
    version: TPACKAGE_VERSION;
    name, publisher, resourceId, publisherId: PWideChar;
  end;

  TPACKAGE_INFO = record
    reserved, flags: Cardinal;
    path, packageFullName, packageFamilyName: PWideChar;
    packageId: TPACKAGE_ID;
  end;
  PPACKAGE_INFO = ^TPACKAGE_INFO;

const
  kChannelPackageFamilyName: array [0 .. 4] of wvstring =
    ('Microsoft.WebView2Runtime.Stable_8wekyb3d8bbwe',
     'Microsoft.WebView2Runtime.Beta_8wekyb3d8bbwe',
     'Microsoft.WebView2Runtime.Dev_8wekyb3d8bbwe',
     'Microsoft.WebView2Runtime.Canary_8wekyb3d8bbwe',
     'Microsoft.WebView2Runtime.Internal_8wekyb3d8bbwe');

  kChannelName: array [0 .. 4] of wvstring = ('', 'beta', 'dev', 'canary', 'internal');

function FindInstalledClientDll(var clientPath : wvstring;
                                    preference : TWebView2ReleaseChannelPreference;
                                var versionStr : wvstring;
                                var channelStr : wvstring): integer;
const
  APPMODEL_ERROR_NO_PACKAGE = $00003D54;                                
var
  channel: Cardinal;
  lpSubKey: wvstring;
  version: TVersionRec;
  pkBuf: array of byte;
  i, j: integer;
  len, cPackages: Cardinal;
  packages, package: PPACKAGE_INFO;
  GetCurrentPackageInfo: TGetCurrentPackageInfoProc;
  TempResult : integer;
begin
  // GetCurrentPackageInfo is only available in Windows 8 or newer
  if (Win32MajorVersion > 6) or
     ((Win32MajorVersion = 6) and (Win32MinorVersion >= 2)) then
    GetCurrentPackageInfo := TGetCurrentPackageInfoProc(GetProcAddress(GetModuleHandleW('kernelbase.dll'), 'GetCurrentPackageInfo'))
   else
    GetCurrentPackageInfo := nil;

  for i := 0 to 4 do
    begin
      if (preference = kCanary) then
        channel := 4 - i
       else
        channel := i;

      GetInstallKeyPathForChannel(channel, lpSubKey);

      if FindInstalledClientDllForChannel(lpSubKey, False, versionStr, clientPath) then
        break;

      if FindInstalledClientDllForChannel(lpSubKey, True, versionStr, clientPath) then
        break;

      GetInstallKeyPathForChannel2(channel, lpSubKey);

      if FindInstalledClientDllForChannel(lpSubKey, False, versionStr, clientPath) then
        break;

      if FindInstalledClientDllForChannel(lpSubKey, True, versionStr, clientPath) then
        break;

      if not assigned(GetCurrentPackageInfo) then
        continue;

      len := 0;
      TempResult := GetCurrentPackageInfo(1, len, nil, cPackages);
      if (TempResult = APPMODEL_ERROR_NO_PACKAGE) then
        begin
          Result := E_FAIL;
          exit;
        end;
      
      if (TempResult <> ERROR_INSUFFICIENT_BUFFER) or (len = 0) then
        continue;

      SetLength(pkBuf, len);
      if (GetCurrentPackageInfo(1, len, @pkBuf[0], cPackages) <> 0) or (cPackages = 0) then
        continue;

      packages := PPACKAGE_INFO(pkBuf);
      package  := nil;

      for j := 0 to cPackages - 1 do
        begin
          if (UpperCase(packages.packageFamilyName) = UpperCase(kChannelPackageFamilyName[j])) then
            begin
              package := packages;
              break;
            end;

          inc(packages);
        end;

      if (package = nil) then
        continue;

      version[0] := package.packageId.version.Major;
      version[1] := package.packageId.version.Minor;
      version[2] := package.packageId.version.Build;
      version[3] := package.packageId.version.Revision;
      clientPath := package.path;

      if CheckVersionAndFindClientDllInFolder(version, clientPath) then
        begin
          versionStr := format('%d.%d.%d.%d', [version[0], version[1], version[2], version[3]]);
          break;
        end;
    end;

  channelStr := kChannelName[channel];
  Result     := S_OK;
end;

function FindEmbeddedClientDll(const embeddedEdgeSubFolder : wvstring;
                               var   outClientPath         : wvstring): HRESULT;
var
  TempPath : wvstring;
begin
  Result        := S_OK;
  outClientPath := embeddedEdgeSubFolder;

  if (Length(outClientPath) >= 3) and
    ((DWORD(outClientPath[1]) and $FFDF) - Ord('A') < $1A) and
    (outClientPath[2] = ':') and
    (outClientPath[3] = '\') then
    begin
      if not(FindClientDllInFolder(outClientPath)) then
        Result := HResultFromWin32(ERROR_FILE_NOT_FOUND);
    end
   else
    if (Length(outClientPath) < 3) or
       (outClientPath[2] = ':') or
       (outClientPath[1] <> '\') or
       (outClientPath[2] <> '\') then
      begin
        Result := GetModulePath(0, TempPath);
        if (Result < 0) then exit;

        outClientPath := IncludeTrailingPathDelimiter(TempPath) + embeddedEdgeSubFolder;

        if not(FindClientDllInFolder(outClientPath)) then
          Result := HResultFromWin32(ERROR_FILE_NOT_FOUND);
      end
     else
      if not(FindClientDllInFolder(outClientPath)) then
        Result := HResultFromWin32(ERROR_FILE_NOT_FOUND);
end;

type
  TWebView2RunTimeType = (kInstalled = 0, kRedistributable = 1);

  TCreateWebViewEnvironmentWithOptionsInternal = function(a: boolean; b: TWebView2RunTimeType; c: PWideChar; d: System.IUnKnown; E: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
  TDllCanUnloadNow = function: HRESULT; stdcall;

function CreateWebViewEnvironmentWithClientDll(      lplibfilename       : wvstring;
                                                     unknown             : boolean;
                                                     runtimeType         : TWebView2RunTimeType;
                                                     unknown2            : PWideChar;
                                               const unknown3            : System.IUnKnown;
                                                     envCompletedHandler : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT;
var
  clientDLL     : HModule;
  createProc    : TCreateWebViewEnvironmentWithOptionsInternal;
  canUnLoadProc : TDllCanUnloadNow;
begin
  clientDLL := LoadLibraryW(PWideChar(lplibfilename));

  if (clientDLL = 0) then
    begin
      Result := HResultFromWin32(GetLastError);
      exit;
    end;

  createProc    := GetProcAddress(clientDLL, 'CreateWebViewEnvironmentWithOptionsInternal');  // Undocumented function
  canUnLoadProc := GetProcAddress(clientDLL, 'DllCanUnloadNow');

  if not(assigned(createProc)) then
    begin
      Result := HResultFromWin32(GetLastError);
      exit;
    end;

  Result := createProc(unknown, runtimeType, unknown2, unknown3, envCompletedHandler);

  if assigned(canUnLoadProc) and (canUnLoadProc() = 0) then
    FreeLibrary(clientDLL);
end;

type
  TEnvironmentCreatedRetryHandler = class(TInterfacedObject, ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler)
    private
      mEnvironmentParams : TWebView2EnvironmentParams;
      mOriginalHandler   : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
      mRetries           : integer;
    public
      constructor Create(environmentParams: TWebView2EnvironmentParams; const originalHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler; retries: integer);
      function    Invoke(ret: HRESULT; const created_environment: ICoreWebView2Environment): HRESULT; stdcall;
  end;

function TryCreateWebViewEnvironment(      aParams                    : TWebView2EnvironmentParams;
                                     const aEnvironmentCreatedHandler : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT;
var
  runtimeType: TWebView2RunTimeType;
  dllPath, v, c: wvstring;
begin
  if (aParams.embeddedEdgeSubFolder <> '') then
    begin
      runtimeType := kRedistributable;
      Result      := FindEmbeddedClientDll(aParams.embeddedEdgeSubFolder, dllPath);
    end
   else
    begin
      runtimeType := kInstalled;
      Result      := FindInstalledClientDll(dllPath, aParams.releaseChannelPreference, v, c);
    end;

  if succeeded(Result) then
    Result := CreateWebViewEnvironmentWithClientDll(dllPath,
                                                    True,
                                                    runtimeType,
                                                    PWideChar(aParams.userDataDir),
                                                    aParams.environmentOptions as System.IUnKnown,
                                                    aEnvironmentCreatedHandler);
end;

function Internal_CreateCoreWebView2EnvironmentWithOptions(      browserExecutableFolder     : LPCWSTR;
                                                                 userDataFolder              : LPCWSTR;
                                                           const environmentOptions          : ICoreWebView2EnvironmentOptions;
                                                           const environment_created_handler : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
var
  TempParams  : TWebView2EnvironmentParams;
  TempHandler : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
begin
  if assigned(environment_created_handler) then
    begin
      TempParams.embeddedEdgeSubFolder    := browserExecutableFolder;
      TempParams.userDataDir              := userDataFolder;
      TempParams.environmentOptions       := environmentOptions;
      TempParams.releaseChannelPreference := kStable;

      UpdateWebViewEnvironmentParamsWithOverrideValues(TempParams);

      try
        TempHandler := TEnvironmentCreatedRetryHandler.Create(TempParams, environment_created_handler, 1);
        Result      := TryCreateWebViewEnvironment(TempParams, TempHandler);
      finally
        TempHandler := nil;
      end;
    end
   else
    Result := E_POINTER;
end;

function Internal_CreateCoreWebView2Environment(const environment_created_handler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT; stdcall;
begin
  Result := Internal_CreateCoreWebView2EnvironmentWithOptions(nil, nil, nil, environment_created_handler);
end;

function FindEmbeddedBrowserVersion(const aFilename: wvstring; var aVersion: wvstring): HRESULT;
var
  TempBlockSize  : cardinal;
  TempHandle     : cardinal;
  TempBlock      : pointer;
  TempBuffer     : pointer;
  TempBufferSize : cardinal;
  TempSubBlock   : wvstring;
begin
  TempBuffer    := nil;
  TempHandle    := 0;
  TempBlockSize := GetFileVersionInfoSizeW(PWideChar(aFilename), TempHandle);

  if TempBlockSize = 0 then
    Result := HResultFromWin32(GetLastError)
   else
    begin
      GetMem(TempBlock, TempBlockSize);

      try
        TempSubBlock := '\StringFileInfo\040904B0\ProductVersion';

        if not(GetFileVersionInfoW(PWideChar(aFilename), TempHandle, TempBlockSize, TempBlock)) or
           not(VerQueryValueW(TempBlock, PWideChar(TempSubBlock), TempBuffer, TempBufferSize)) or
           not(assigned(TempBuffer)) then
          Result := HResultFromWin32(GetLastError)
         else
          begin
            aVersion := PWideChar(TempBuffer);
            Result   := S_OK;
          end;
      finally
        FreeMem(TempBlock);
      end;
    end;
end;

function Internal_GetAvailableCoreWebView2BrowserVersionString(browserExecutableFolder: LPCWSTR; pVersionInfo: PLPWSTR): HRESULT; stdcall;
var
  TempParams : TWebView2EnvironmentParams;
  hr: HRESULT;
  TempChannelStr, TempVersionStr, TempClientPath: wvstring;
  TempSize : integer;
begin
  if (pVersionInfo = nil) then
    begin
      Result := E_POINTER;
      exit;
    end;

  TempParams.embeddedEdgeSubFolder    := browserExecutableFolder;
  TempParams.userDataDir              := '';
  TempParams.environmentOptions       := nil;
  TempParams.releaseChannelPreference := kStable;

  UpdateWebViewEnvironmentParamsWithOverrideValues(TempParams);

  if (TempParams.embeddedEdgeSubFolder <> '') then
    begin
      hr := FindEmbeddedClientDll(TempParams.embeddedEdgeSubFolder, TempClientPath);

      if (hr < 0) then
        begin
          pVersionInfo^ := nil;
          Result        := hr;
          exit;
        end;

      hr := FindEmbeddedBrowserVersion(TempClientPath, TempVersionStr);
    end
   else
    hr := FindInstalledClientDll(TempClientPath, TempParams.releaseChannelPreference, TempVersionStr, TempChannelStr);

  if (hr < 0) then
    begin
      pVersionInfo^ := nil;
      Result        := hr;
      exit;
    end;

  if (TempVersionStr <> '') then
    begin
      if (TempChannelStr <> '') then
        TempVersionStr := TempVersionStr + ' ' + TempChannelStr;

      TempVersionStr := TempVersionStr + #0;
      TempSize       := Length(TempVersionStr) * SizeOf(WideChar);

      pVersionInfo^ := CoTaskMemAlloc(TempSize);
      move(TempVersionStr[1], pVersionInfo^^, TempSize);
      Result := S_OK;
    end
   else
    Result := E_FAIL;
end;

function Internal_GetAvailableCoreWebView2BrowserVersionStringWithOptions(browserExecutableFolder: LPCWSTR; const environmentOptions: ICoreWebView2EnvironmentOptions; pVersionInfo: PLPWSTR): HRESULT; stdcall;
begin
  // TO-DO: Implement GetAvailableCoreWebView2BrowserVersionStringWithOptions
  Result := E_NOTIMPL;
end;

function Internal_CompareBrowserVersions(version1, version2: LPCWSTR; pRet: PInteger): HRESULT; stdcall;
var
  TempVersion1, TempVersion2: TVersionRec;
  i: integer;
begin
  if (pRet = nil) then
    Result := E_POINTER
   else
    if (version1 = nil) or
       (version2 = nil) or
       not(ParseVersionNumbers(version1, TempVersion1)) or
       not(ParseVersionNumbers(version2, TempVersion2)) then
      Result := E_INVALIDARG
     else
      begin
        Result := S_OK;

        for i := 0 to 3 do
          if (TempVersion2[i] < TempVersion1[i]) then
            begin
              pRet^ := 1;
              exit;
            end
           else
            if (TempVersion2[i] > TempVersion1[i]) then
              begin
                pRet^ := -1;
                exit;
              end;

        pRet^ := 0;
      end;
end;

{ TEnvironmentCreatedRetryHandler }

constructor TEnvironmentCreatedRetryHandler.Create(      environmentParams : TWebView2EnvironmentParams;
                                                   const originalHandler   : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
                                                         retries           : integer);
begin
  inherited Create;

  mEnvironmentParams := environmentParams;
  mOriginalHandler   := originalHandler;
  mRetries           := retries;
end;

function TEnvironmentCreatedRetryHandler.Invoke;
begin
  if (ret >= 0) or (mRetries <= 0) then
    begin
      if assigned(created_environment) and assigned(mOriginalHandler) then
        mOriginalHandler.Invoke(S_OK, created_environment);
    end
   else
    begin
      dec(mRetries);
      ret := TryCreateWebViewEnvironment(mEnvironmentParams, self);

      if (ret < 0) then
        mOriginalHandler.Invoke(ret, nil);
    end;

  Result := S_OK;
end;

end.
