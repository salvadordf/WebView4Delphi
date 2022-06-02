unit uWVLoaderInternal;
// Based on https://github.com/YWtheGod/DRT/blob/main/SOURCE/DRT.WIN.WebView2Loader.pas

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}
{$I webview2.inc}

interface

uses
{$IFDEF FPC}
  Windows,
{$ELSE}
  WinApi.Windows, WinApi.ShlObj, WinApi.ActiveX,
{$ENDIF}
  uWVTypeLibrary, uWVTypes;

function Internal_CreateCoreWebView2EnvironmentWithOptions
  (browserExecutableFolder, userDataFolder: LPCWSTR;
  const environmentOptions: ICoreWebView2EnvironmentOptions;
  const environment_created_handler
  : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler)
  : HRESULT; stdcall;
function Internal_CreateCoreWebView2Environment
  (const environment_created_handler
  : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler)
  : HRESULT; stdcall;
function Internal_GetAvailableCoreWebView2BrowserVersionString
  (browserExecutableFolder: LPCWSTR; pVersionInfo: PLPWSTR): HRESULT; stdcall;
function Internal_CompareBrowserVersions(version1, version2: LPCWSTR;
  pRet: PInteger): HRESULT; stdcall;

implementation

uses
{$IFDEF FPC}
  ActiveX, Registry,
{$ELSE}
  IOUtils, System.Win.Registry,
{$ENDIF}
  SysUtils;

{$IFDEF FPC}
function GetCurrentProcessExplicitAppUserModelID(var AppID: LPWSTR): HRESULT;
  StdCall; external 'shell32' name 'GetCurrentProcessExplicitAppUserModelID';
{$ENDIF}

type
  TWebView2ReleaseChannelPreference = (kStable = 0, kCanary = 1);

  TWebView2EnvironmentParams = record
    embeddedEdgeSubFolder, userDataDir: wvstring;
    environmentOptions: ICoreWebView2EnvironmentOptions;
    releaseChannelPreference: TWebView2ReleaseChannelPreference;
  end;

  // int DoesPolicyExistInRoot(HKEY hKey) {
  // HKEY phkResult = nullptr;
  // LSTATUS result =
  // RegOpenKeyExW(hKey, L"Software\\Policies\\Microsoft\\Edge\\WebView2\\", 0,
  // 0x20019u, &phkResult);
  // RegCloseKey(phkResult);
  // return result == ERROR_SUCCESS;
  // }
function DoesPolicyExistInRoot(h: HKEY): boolean;
var
  r: TRegistry;
begin
  r := TRegistry.Create(KEY_READ);
  try
    r.RootKey := h;
    Result := r.OpenKey('Software\Policies\Microsoft\Edge\\WebView2\', False);
  finally
    r.Free;
  end;
end;

// bool ReadEnvironmentVariable(LPCWSTR lpName, WString* outValue) {
// DWORD len = GetEnvironmentVariableW(lpName, nullptr, 0);
// if (!len || !outValue->Reserve(len)) return false;
// return outValue->Resize(
// GetEnvironmentVariableW(lpName, outValue->String(), len));
// }
function ReadEnvironmentVariable(LpName: wvstring;
  var outValue: wvstring): boolean;
begin
  outValue := GetEnvironmentVariable(LpName);
  Result := outValue <> '';
end;

// int GetAppUserModelIdForCurrentProcess(WString* idOut) {
// auto* lpGetCurrentApplicationUserModelId =
// reinterpret_cast<GetCurrentApplicationUserModelIdProc>(
// GetProcAddress(GetModuleHandleW(L"Kernel32.dll"),
// "GetCurrentApplicationUserModelId"));
//
// // Win8+: Use GetCurrentApplicationUserModelId.
// if (lpGetCurrentApplicationUserModelId) {
// idOut->Reserve(0x100);
// auto idLength = static_cast<UINT32>(idOut->Capacity());
// if (!lpGetCurrentApplicationUserModelId(&idLength, idOut->String())) {
// if (!idOut->Resize(idLength - 1)) {
// return E_UNEXPECTED;
// }
// return S_OK;
// }
// }
//
// // Win7: Use GetCurrentProcessExplicitAppUserModelID.
// PWSTR appId = nullptr;
// HRESULT hr = GetCurrentProcessExplicitAppUserModelID(&appId);
// if (FAILED(hr)) {
// CoTaskMemFree(appId);
// appId = nullptr;
// return hr;
// }
// if (!idOut->Assign(appId)) {
// CoTaskMemFree(appId);
// appId = nullptr;
// return HRESULT_FROM_WIN32(GetLastError());
// }
// CoTaskMemFree(appId);
// appId = nullptr;
// return S_OK;
// }
type
  GetCurrentApplicationUserModelIdProc = function
    (var applicationUserModelIdLength: Cardinal;
    applicationUserModelId: PWideChar): HRESULT; stdcall;

function GetAppUserModelIdForCurrentProcess(var idOut: wvstring): integer;
var
  G: GetCurrentApplicationUserModelIdProc;
  l: Cardinal;
  AppID: PWideChar;
  hr: HRESULT;
begin
  G := GetProcAddress(GetModuleHandleW('Kernel32.dll'),
    'GetCurrentApplicationUserModelId');
  if assigned(G) then
    begin
      SetLength(idOut, $100);
      l := $100;
      hr := G(l, PWideChar(idOut));
      if hr = ERROR_SUCCESS then
        SetLength(idOut, l);
      exit(hr);
    end;
  AppID := nil;
  hr := GetCurrentProcessExplicitAppUserModelID(AppID);
  if hr < 0 then
    begin
      CoTaskMemFree(AppID);
      AppID := nil;
      exit(hr)
    end;
  idOut := AppID;
  CoTaskMemFree(AppID);
  AppID := nil;
  exit(S_OK)
end;

// HRESULT HRESULT_FROM_WIN32(unsigned long x) { return (HRESULT)(x) <= 0 ?
// (HRESULT)(x) : (HRESULT) (((x) & 0x0000FFFF) | (FACILITY_WIN32 << 16) | 0x80000000);}//HRESULT GetModulePath(HMODULE hModule, WString* outPath) {
function HRESULT_FROM_WIN32(const x: Cardinal): HRESULT; inline;
begin
  if HRESULT(x) < 0 then
    exit(x);
  exit((x and $FFFF) or (7 shl 16) or $80000000)
end;

// outPath->Reserve(MAX_PATH);
// DWORD result = GetModuleFileNameW(hModule, outPath->String(),
// static_cast<DWORD>(outPath->Capacity()));
// if (result == outPath->Capacity() &&
// GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
// outPath->Reserve(0x1000u);
// result = GetModuleFileNameW(hModule, outPath->String(),
// static_cast<DWORD>(outPath->Capacity()));
// }
// if (!result || result >= outPath->Capacity()) {
// return HRESULT_FROM_WIN32(GetLastError());
// }
// outPath->Resize(result);
// return S_OK;
// }
function GetModulePath(h: HModule; var outPath: wvstring): HRESULT;
var
  r: Cardinal;
begin
  SetLength(outPath, 260);
  r := GetModuleFileNameW(h, PWideChar(outPath), 260);
  if GetLastError() = ERROR_INSUFFICIENT_BUFFER then
    begin
      SetLength(outPath, $1000);
      r := GetModuleFileNameW(h, PWideChar(outPath), $1000);
    end;
  if (r = 0) or (r > $1000) then
    exit(HRESULT_FROM_WIN32(GetLastError));
  SetLength(outPath, r);
  exit(S_OK);
end;

var
  gShouldCheckPolicyOverride: boolean = true;
  gShouldCheckRegistryOverride: boolean = true;
  // bool ReadOverrideFromRegistry(PCWSTR key, HKEY root, const WCHAR* lpValue,
  // PCWSTR* outBuf, WString* outStr, DWORD* outInt,
  // bool redist) {
  // DWORD pcbData;
  // HKEY phkResult = nullptr;
  // if (!key || !*key) return false;
  // WString pvData;
  // if (redist)
  // pvData.Append(kRedistOverrideKey);
  // else
  // pvData.Append(kEmbeddedOverrideKey);
  // pvData.Append(key);
  // LSTATUS lStatus =
  // RegOpenKeyExW(root, pvData.String(), 0, KEY_QUERY_VALUE, &phkResult);
  // if (lStatus != ERROR_SUCCESS) {
  // return false;
  // }
  // gShouldCheckRegistryOverride = true;
  //
  // if (outInt) {
  // char szData[4];
  // szData[0] = 0;
  // pcbData = 4;
  // if (RegGetValueW(phkResult, nullptr, lpValue, RRF_RT_REG_DWORD, nullptr,
  // szData, &pcbData) == 0) {
  // *outInt = szData[0] == 1;
  // } else {
  // if (!RegGetString(lpValue, phkResult, outBuf, outStr)) {
  // RegCloseKey(phkResult);
  // return false;
  // }
  // *outInt = wcstol(*outBuf, nullptr, 10) == 1;
  // }
  // RegCloseKey(phkResult);
  // return true;
  // }
  //
  // if (!RegGetString(lpValue, phkResult, outBuf, outStr)) {
  // RegCloseKey(phkResult);
  // return false;
  // }
  //
  // RegCloseKey(phkResult);
  // return true;
  // }

function ReadOverrideFromRegistry(key: wvstring; root: HKEY; lpValue: wvstring;
  var ret: boolean; redist: boolean): boolean; overload;
var
  pvData: wvstring;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := root;
    if key = '' then
      exit(False);
    if redist then
      pvData := 'Software\Policies\Microsoft\Edge\WebView2\'
    else
      pvData := 'Software\Policies\Microsoft\EmbeddedBrowserWebView\LoaderOverride\';
    if not Reg.OpenKey(pvData + key, False) then
      exit(False);
    gShouldCheckRegistryOverride := true;
    case Reg.GetDataType(lpValue) of
      TRegDataType.rdInteger:
        ret := Reg.ReadInteger(lpValue) = 1;
      TRegDataType.rdString:
        ret := Reg.ReadString(lpValue) = '1';
    else
      exit(False);
    end;
    Result := true;
  finally
    Reg.Free;
  end;
end;

function ReadOverrideFromRegistry(key: wvstring; root: HKEY; lpValue: wvstring;
  var outStr: wvstring; redist: boolean): boolean; overload;
var
  pvData: wvstring;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := root;
    if key = '' then
      exit(False);
    if redist then
      pvData := 'Software\Policies\Microsoft\Edge\WebView2\'
    else
      pvData := 'Software\Policies\Microsoft\EmbeddedBrowserWebView\LoaderOverride\';
    if not Reg.OpenKey(pvData + key, False) then
      exit(False);
    gShouldCheckRegistryOverride := true;
    try
      outStr := Reg.ReadString(lpValue);
    except
      on E: Exception do
        exit(False)
    end;
    Result := true;
  finally
    Reg.Free;
  end;
end;

// bool UpdateParamsWithRegOverrides(PCWSTR key, HKEY root, PCWSTR* outBuf,
// WString* outStr, DWORD* outInt, bool redist) {
// WString exeName, aumId, modulePath;
// GetAppUserModelIdForCurrentProcess(&aumId);
// if (FAILED(GetModulePath(nullptr, &modulePath))) {
// exeName.Clear();
// } else {
// const wchar_t* lastSlash = wcsrchr(modulePath.String(), L'\\');
// if (!lastSlash) lastSlash = modulePath.String();
// exeName.Assign(lastSlash + 1);
// }
//
// if (gShouldCheckPolicyOverride && redist) {
// if (ReadOverrideFromRegistry(key, root, aumId.String(), outBuf, outStr,
// outInt, redist))
// return true;
// if (ReadOverrideFromRegistry(key, root, exeName.String(), outBuf, outStr,
// outInt, redist))
// return true;
// if (ReadOverrideFromRegistry(key, root, L"*", outBuf, outStr, outInt,
// redist))
// return true;
// return false;
// }
//
// if (ReadOverrideFromRegistry(aumId.String(), root, key, outBuf, outStr,
// outInt, redist))
// return true;
// if (ReadOverrideFromRegistry(exeName.String(), root, key, outBuf, outStr,
// outInt, redist))
// return true;
// if (ReadOverrideFromRegistry(L"*", root, key, outBuf, outStr, outInt, redist))
// return true;
// return false;
// }
function UpdateParamsWithRegOverrides(key: wvstring; root: HKEY;
  var ret: boolean; redist: boolean): boolean; overload;
var
  exeName, aumID, modulePath: wvstring;
begin
  GetAppUserModelIdForCurrentProcess(aumID);
  if GetModulePath(0, modulePath) < 0 then
    exeName := ''
  else
    begin
      exeName := ExtractFileName(modulePath);
    end;
  if gShouldCheckPolicyOverride and redist then
    begin
      if ReadOverrideFromRegistry(key, root, aumID, ret, redist) then
        exit(true);
      if ReadOverrideFromRegistry(key, root, exeName, ret, redist) then
        exit(true);
      if ReadOverrideFromRegistry(key, root, '*', ret, redist) then
        exit(true);
      exit(False)
    end;
  if ReadOverrideFromRegistry(aumID, root, key, ret, redist) then
    exit(true);
  if ReadOverrideFromRegistry(exeName, root, key, ret, redist) then
    exit(true);
  if ReadOverrideFromRegistry('*', root, key, ret, redist) then
    exit(true);
  exit(False)
end;

function UpdateParamsWithRegOverrides(key: wvstring; root: HKEY;
  var outStr: wvstring; redist: boolean): boolean; overload;
var
  exeName, aumID, modulePath: wvstring;
begin
  GetAppUserModelIdForCurrentProcess(aumID);
  if GetModulePath(0, modulePath) < 0 then
    exeName := ''
  else
    begin
      exeName := ExtractFileName(modulePath);
    end;
  if gShouldCheckPolicyOverride and redist then
    begin
      if ReadOverrideFromRegistry(key, root, aumID, outStr, redist) then
        exit(true);
      if ReadOverrideFromRegistry(key, root, exeName, outStr, redist) then
        exit(true);
      if ReadOverrideFromRegistry(key, root, '*', outStr, redist) then
        exit(true);
      exit(False)
    end;
  if ReadOverrideFromRegistry(aumID, root, key, outStr, redist) then
    exit(true);
  if ReadOverrideFromRegistry(exeName, root, key, outStr, redist) then
    exit(true);
  if ReadOverrideFromRegistry('*', root, key, outStr, redist) then
    exit(true);
  exit(False)
end;

// bool UpdateParamsWithOverrides(const wchar_t* env, const wchar_t* key,
// PCWSTR* outBuf, WString* outStr, DWORD* outInt,
// bool checkOverride) {
// if (checkOverride) {
// gShouldCheckPolicyOverride = true;
// gShouldCheckRegistryOverride = true;
// }
//
// if (ReadEnvironmentVariable(env, outStr)) {
// *outBuf = outStr->String();
// DWORD intVal = wcstol(outStr->String(), nullptr, 10) == 1;
// if (outInt) {
// *outInt = intVal;
// }
// return intVal;
// }
//
// if (!gShouldCheckRegistryOverride && !gShouldCheckPolicyOverride &&
// !checkOverride) {
// return false;
// }
//
// gShouldCheckRegistryOverride = false;
// gShouldCheckPolicyOverride = DoesPolicyExistInRoot(HKEY_CURRENT_USER) ||
// DoesPolicyExistInRoot(HKEY_LOCAL_MACHINE);
//
// return UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outBuf, outStr,
// outInt, true) ||
// UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER, outBuf, outStr,
// outInt, true) ||
// UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outBuf, outStr,
// outInt, false) ||
// UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER, outBuf, outStr,
// outInt, false);
// }
function UpdateParamsWithOverrides(const env, key: wvstring; var ret: boolean;
  checkOverride: boolean): boolean; overload;
var
  outStr: wvstring;
begin
  if checkOverride then
    begin
      gShouldCheckPolicyOverride := true;
      gShouldCheckRegistryOverride := true;
    end;
  if ReadEnvironmentVariable(env, outStr) then
    begin
      ret := strtointdef(outStr, 0) = 1;
      exit(ret);
    end;
  if not gShouldCheckRegistryOverride and not gShouldCheckPolicyOverride and not checkOverride then
    exit(False);
  gShouldCheckRegistryOverride := False;
  gShouldCheckPolicyOverride := DoesPolicyExistInRoot(HKEY_CURRENT_USER) or
    DoesPolicyExistInRoot(HKEY_LOCAL_MACHINE);
  Result := UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, true)
    or UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER, outStr, true) or
    UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, False) or
    UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER, outStr, False);
end;

function UpdateParamsWithOverrides(const env, key: wvstring;
  var outStr: wvstring; checkOverride: boolean): boolean; overload;
begin
  if checkOverride then
    begin
      gShouldCheckPolicyOverride := true;
      gShouldCheckRegistryOverride := true;
    end;
  if ReadEnvironmentVariable(env, outStr) then
    begin
      exit(strtointdef(outStr, 0) = 1);
    end;
  if not gShouldCheckRegistryOverride and not gShouldCheckPolicyOverride and not checkOverride
  then
    exit(False);
  gShouldCheckRegistryOverride := False;
  gShouldCheckPolicyOverride := DoesPolicyExistInRoot(HKEY_CURRENT_USER) or
    DoesPolicyExistInRoot(HKEY_LOCAL_MACHINE);
  Result := UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, true)
    or UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER, outStr, true) or
    UpdateParamsWithRegOverrides(key, HKEY_LOCAL_MACHINE, outStr, False) or
    UpdateParamsWithRegOverrides(key, HKEY_CURRENT_USER, outStr, False);
end;

// void UpdateWebViewEnvironmentParamsWithOverrideValues(
// WebView2EnvironmentParams* params, WString* outStrings) {
// UpdateParamsWithOverrides(
// L"WEBVIEW2_BROWSER_EXECUTABLE_FOLDER", L"browserExecutableFolder",
// &params->embeddedEdgeSubFolder, &outStrings[0], nullptr, true);
// UpdateParamsWithOverrides(L"WEBVIEW2_USER_DATA_FOLDER", L"userDataFolder",
// &params->userDataDir, &outStrings[1], nullptr,
// false);
// const wchar_t* tmpStr = nullptr;
// WString tmpWStr;
// UpdateParamsWithOverrides(
// L"WEBVIEW2_RELEASE_CHANNEL_PREFERENCE", L"releaseChannelPreference",
// &tmpStr, &tmpWStr,
// reinterpret_cast<DWORD*>(&params->releaseChannelPreference), false);
// }
procedure UpdateWebViewEnvironmentParamsWithOverrideValues
  (var params: TWebView2EnvironmentParams);
begin
  UpdateParamsWithOverrides('WEBVIEW2_BROWSER_EXECUTABLE_FOLDER',
    'browserExecutableFolder', params.embeddedEdgeSubFolder, true);
  UpdateParamsWithOverrides('WEBVIEW2_USER_DATA_FOLDER', 'userDataFolder',
    params.userDataDir, true);
  UpdateParamsWithOverrides('WEBVIEW2_RELEASE_CHANNEL_PREFERENCE',
    'releaseChannelPreference', boolean(params.releaseChannelPreference), true);
end;

// void GetInstallKeyPathForChannel(DWORD channel, WString* outRegistryKey) {
// const auto* guid = kChannelUuid[channel];
// outRegistryKey->Reserve(wcslen(guid) + wcslen(kInstallKeyPath));
// outRegistryKey->Assign(L"Software\\Microsoft\\EdgeUpdate\\ClientState\\",
// wcslen(kInstallKeyPath));
// outRegistryKey->Append(guid, wcslen(guid));
// }
const
  kChannelUuid: array [0 .. 4] of wvstring =
    ('{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}',
    '{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}',
    '{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}',
    '{65C35B14-6C1D-4122-AC46-7148CC9D6497}',
    '{BE59E8FD-089A-411B-A3B0-051D9E417818}');

procedure GetInstallKeyPathForChannel(channel: Cardinal;
  var outRegistryKey: wvstring);
begin
  outRegistryKey := 'Software\Microsoft\EdgeUpdate\ClientState\' +
    kChannelUuid[channel];
end;

procedure GetInstallKeyPathForChannel2(channel: Cardinal;
  var outRegistryKey: wvstring);
begin
  outRegistryKey := 'Software\WOW6432Node\Microsoft\EdgeUpdate\ClientState\' +
    kChannelUuid[channel];
end;

// bool ParseVersionNumbers(PCWSTR versionString, UINT32* outVersion) {
// const wchar_t* start = versionString;
// wchar_t* end = nullptr;
// for (int i = 0; i < 4; i++) {
// outVersion[i] = wcstol(start, &end, 10);
// if (!end || start == end) {
// return false;
// }
// if (*end == L'.') {
// start = end + 1;
// }
// }
// return true;
// }
type
  TVersionRec = array [0 .. 3] of Cardinal;

function ParseVersionNumbers(s: wvstring; var o: TVersionRec): boolean;
var
  i: integer;
  E: integer;
  t: wvstring;
begin
  for i := 0 to 3 do
    begin
      if s = '' then
        exit(False);
      val(s, o[i], E);
      if E = 0 then
        begin
          t := s;
          s := '';
        end
      else
        begin
          t := copy(s, 1, E - 1);
          s := copy(s, E + 1);
        end;
      val(t, o[i], E);
    end;
  Result := true;
end;

// bool FindClientDllInFolder(WString* folder) {
// folder->Append(L"\\");
// folder->Append(kEmbeddedWebViewPath);
// return GetFileAttributesW(folder->String()) != INVALID_FILE_ATTRIBUTES;
// }
function FindClientDllInFolder(var folder: wvstring): boolean;
begin
{$IFDEF WIN64}
  folder := IncludeTrailingPathDelimiter(folder) +
    'EBWebView\x64\EmbeddedBrowserWebView.dll';
{$ELSE}
  folder := IncludeTrailingPathDelimiter(folder) +
    'EBWebView\x86\EmbeddedBrowserWebView.dll';
{$ENDIF}
  Result := Fileexists(folder);
end;

// bool CheckVersionAndFindClientDllInFolder(const UINT32* version,
// WString* path) {
// for (int component = 0; component < 4; component++) {
// if (version[component] < kMinimumCompatibleVersion[component]) {
// return false;
// }
// if (version[component] > kMinimumCompatibleVersion[component]) {
// break;
// }
// }
// return FindClientDllInFolder(path);
// }
const
  kMinimumCompatibleVersion: array [0 .. 3] of Cardinal = (86, 0, 616, 0);

function CheckVersionAndFindClientDllInFolder(const version: TVersionRec;
  var path: wvstring): boolean;
var
  i: integer;
begin
  for i := 0 to 3 do
    begin
      if version[i] < kMinimumCompatibleVersion[i] then
        exit(False);
      if version[i] > kMinimumCompatibleVersion[i] then
        break;
    end;
  Result := FindClientDllInFolder(path);
end;

// int FindInstalledClientDllForChannel(PCWSTR lpSubKey, bool system,
// WString* versionStr, WString* clientPath) {
// HKEY phkResult;
// DWORD cbPath = MAX_PATH;
// UINT32 version[4];
// wchar_t path[MAX_PATH];
//
// if (RegOpenKeyExW(system ? HKEY_LOCAL_MACHINE : HKEY_CURRENT_USER, lpSubKey,
// 0, KEY_READ | KEY_WOW64_32KEY, &phkResult)) {
// return false;
// }
// LSTATUS result = RegQueryValueExW(phkResult, L"EBWebView", nullptr, nullptr,
// reinterpret_cast<LPBYTE>(path), &cbPath);
// RegCloseKey(phkResult);
// if (result) {
// return false;
// }
// clientPath->Assign(path);
// const wchar_t* versionPart = wcsrchr(clientPath->String(), '\\');
// if (!versionPart) {
// return false;
// }
// if (!ParseVersionNumbers(versionPart + 1, version)) {
// return false;
// }
// if (versionStr) {
// versionStr->Assign(versionPart + 1);
// }
// return CheckVersionAndFindClientDllInFolder(version, clientPath);
// }
function FindInstalledClientDllForChannel(lpSubKey: wvstring; sys: boolean;
  var versionStr, clientPath: wvstring): boolean;
var
  r: TRegistry;
  version: TVersionRec;
begin
  r := TRegistry.Create(KEY_READ);
  try
    if sys then
      r.RootKey := HKEY_LOCAL_MACHINE
    else
      r.RootKey := HKEY_CURRENT_USER;
    if not r.OpenKey(lpSubKey, False) then
      exit(False);
    try
      clientPath := r.ReadString('EBWebView');
      versionStr := ExtractFileName(clientPath);
      if not ParseVersionNumbers(versionStr, version) then
        exit(False);
    except
      on E: Exception do
        exit(False);
    end;
  finally
    r.Free;
  end;
  Result := CheckVersionAndFindClientDllInFolder(version, clientPath);
end;

// int FindInstalledClientDll(WString* clientPath,
// WebView2ReleaseChannelPreference preference,
// WString* versionStr, WString* channelStr) {
// DWORD channel = 0;
// WString lpSubKey;
// UINT32 version[4];
// WString pkgBuf;
//
// static auto getCurrentPackageInfo =
// reinterpret_cast<GetCurrentPackageInfoProc>(GetProcAddress(
// GetModuleHandleW(L"kernelbase.dll"), "GetCurrentPackageInfo"));
//
// for (int i = 0; i < kNumChannels; i++) {
// channel =
// preference == WebView2ReleaseChannelPreference::kCanary ? 4 - i : i;
// GetInstallKeyPathForChannel(channel, &lpSubKey);
// if (FindInstalledClientDllForChannel(lpSubKey.String(), false, versionStr,
// clientPath)) {
// break;
// }
// if (FindInstalledClientDllForChannel(lpSubKey.String(), true, versionStr,
// clientPath)) {
// break;
// }
// if (!getCurrentPackageInfo) {
// continue;
// }
// unsigned int cPackages;
// unsigned int len = 0;
// if (getCurrentPackageInfo(1, &len, nullptr, &cPackages) !=
// ERROR_INSUFFICIENT_BUFFER) {
// continue;
// }
// if (!len || !pkgBuf.ReserveBuffer(len)) {
// continue;
// }
// if (getCurrentPackageInfo(1, &len, static_cast<BYTE*>(pkgBuf.Data()),
// &cPackages)) {
// continue;
// }
// if (!cPackages) {
// continue;
// }
// auto* packages = static_cast<PACKAGE_INFO*>(pkgBuf.Data());
// PACKAGE_INFO* package = nullptr;
// for (UINT32 j = 0; j < cPackages; j++) {
// if (_wcsicmp(packages[j].packageFamilyName,
// kChannelPackageFamilyName[channel]) == 0) {
// package = &packages[j];
// break;
// }
// }
// if (package == nullptr) {
// continue;
// }
// version[0] = package->packageId.version.Major;
// version[1] = package->packageId.version.Minor;
// version[2] = package->packageId.version.Build;
// version[3] = package->packageId.version.Revision;
// clientPath->Assign(package->path);
// if (CheckVersionAndFindClientDllInFolder(version, clientPath)) {
// if (versionStr) {
// wchar_t buffer[12] = {0};
// versionStr->Reserve(15);
// if (_ultow_s(version[0], buffer, _countof(buffer) - 1, 10)) {
// continue;
// }
// versionStr->Assign(buffer);
// if (_ultow_s(version[1], buffer, _countof(buffer) - 1, 10)) {
// continue;
// }
// versionStr->Append(L".");
// versionStr->Append(buffer);
// if (_ultow_s(version[2], buffer, _countof(buffer) - 1, 10)) {
// continue;
// }
// versionStr->Append(L".");
// versionStr->Append(buffer);
// if (_ultow_s(version[3], buffer, _countof(buffer) - 1, 10)) {
// continue;
// }
// versionStr->Append(L".");
// versionStr->Append(buffer);
// }
// break;
// }
// }
// if (channelStr) {
// channelStr->Assign(kChannelName[channel]);
// }
// return 0;
// }
type
  TGetCurrentPackageInfoProc = function(flags: Cardinal;
    var bufferlength: Cardinal; buffer: pointer; var count: Cardinal): HRESULT;

  TPACKAGE_VERSION = record
    case integer of
      0:
        (version: UInt64);
      1:
        (Revision, Build, Minor, Major: Word)
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

var
  getCurrentPackageInfo: TGetCurrentPackageInfoProc;

const
  kChannelPackageFamilyName: array [0 .. 4] of wvstring =
    ('Microsoft.WebView2Runtime.Stable_8wekyb3d8bbwe',
    'Microsoft.WebView2Runtime.Beta_8wekyb3d8bbwe',
    'Microsoft.WebView2Runtime.Dev_8wekyb3d8bbwe',
    'Microsoft.WebView2Runtime.Canary_8wekyb3d8bbwe',
    'Microsoft.WebView2Runtime.Internal_8wekyb3d8bbwe');
  kChannelName: array [0 .. 4] of wvstring = ('', 'beta', 'dev', 'canary',
    'internal');

function FindInstalledClientDll(var clientPath: wvstring;
  preference: TWebView2ReleaseChannelPreference;
  var versionStr, channelStr: wvstring): integer;
var
  channel: Cardinal;
  lpSubKey: wvstring;
  version: TVersionRec;
  pkBuf: wvstring;
  i, j: integer;
  len, cPackages: Cardinal;
  packages, package: PPACKAGE_INFO;
begin
  getCurrentPackageInfo := TGetCurrentPackageInfoProc
    (GetProcAddress(GetModuleHandleW('kernelbase.dll'),
    'GetCurrentPackageInfo'));
  for i := 0 to 4 do
    begin
      if preference = kCanary then
        channel := 4 - i
      else
        channel := i;
      GetInstallKeyPathForChannel(channel, lpSubKey);
      if FindInstalledClientDllForChannel(lpSubKey, False, versionStr,
        clientPath) then
        break;
      if FindInstalledClientDllForChannel(lpSubKey, true, versionStr, clientPath)
      then
        break;
      GetInstallKeyPathForChannel2(channel, lpSubKey);
      if FindInstalledClientDllForChannel(lpSubKey, False, versionStr,
        clientPath) then
        break;
      if FindInstalledClientDllForChannel(lpSubKey, true, versionStr, clientPath)
      then
        break;
      if not assigned(getCurrentPackageInfo) then
        continue;
      len := 0;
      if getCurrentPackageInfo(1, len, nil, cPackages) <> ERROR_INSUFFICIENT_BUFFER
      then
        continue;
      if len = 0 then
        continue;
      SetLength(pkBuf, len);
      if getCurrentPackageInfo(1, len, pointer(pkBuf), cPackages) <> 0 then
        continue;
      if cPackages = 0 then
        continue;
      packages := PPACKAGE_INFO(pkBuf);
      package := nil;
      for j := 0 to cPackages - 1 do
        begin
          if UpperCase(packages.packageFamilyName)
            = UpperCase(kChannelPackageFamilyName[j]) then
            begin
              package := packages;
              break;
            end;
          inc(packages);
        end;
      if package = nil then
        continue;
      version[0] := package.packageId.version.Major;
      version[1] := package.packageId.version.Minor;
      version[2] := package.packageId.version.Build;
      version[3] := package.packageId.version.Revision;
      clientPath := package.path;
      if CheckVersionAndFindClientDllInFolder(version, clientPath) then
        begin
          versionStr := format('%d.%d.%d.%d', [version[0], version[1],
            version[2], version[3]]);
          break;
        end;
    end;
  channelStr := kChannelName[channel];
  Result := 0;
end;

// HRESULT FindEmbeddedClientDll(const wchar_t* embeddedEdgeSubFolder,
// WString* outClientPath) {
// outClientPath->Reserve(MAX_PATH);
// outClientPath->Assign(embeddedEdgeSubFolder);
// const wchar_t* path = outClientPath->String();
// if (outClientPath->Length() >= 3 &&
// static_cast<wchar_t>((path[0] & 0xFFDF) - L'A') < 0x1A &&
// path[1] == L':' && path[2] == L'\\') {
// if (!FindClientDllInFolder(outClientPath)) {
// return HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
// }
// return S_OK;
// }
// if (outClientPath->Length() < 3 || path[1] == ':' || path[0] != L'\\' ||
// path[1] != L'\\') {
// WString modulePath;
// HRESULT hr = GetModulePath(nullptr, &modulePath);
// if (hr < 0) {
// return hr;
// }
// outClientPath->Assign(modulePath.String(), modulePath.Length());
// const wchar_t* basenameSlash = wcsrchr(modulePath.String(), L'\\');
// if (!basenameSlash) return E_FAIL;
// outClientPath->Assign(modulePath.String(),
// basenameSlash - modulePath.String() + 1);
// outClientPath->Append(embeddedEdgeSubFolder);
// if (!FindClientDllInFolder(outClientPath)) {
// return HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
// }
// return S_OK;
// }
// if (!FindClientDllInFolder(outClientPath)) {
// return HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
// }
// return S_OK;
// }
function FindEmbeddedClientDll(var embeddedEdgeSubFolder: wvstring;
  var outClientPath: wvstring): HRESULT;
var
  m: wvstring;
begin
  if (Length(embeddedEdgeSubFolder) >= 3) and
    ((DWORD(embeddedEdgeSubFolder[1]) and $FFDF) - Ord('A') < $1A) and
    (embeddedEdgeSubFolder[2] = ':') and (embeddedEdgeSubFolder[2] = '\') then
    begin
      if FindClientDllInFolder(embeddedEdgeSubFolder) then
        exit(S_OK)
      else
        exit(HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND));
    end;
  if (Length(embeddedEdgeSubFolder) < 3) or (embeddedEdgeSubFolder[2] = ':') or
    (embeddedEdgeSubFolder[1] <> '\') or (embeddedEdgeSubFolder[2] <> '\') then
    begin
      Result := GetModulePath(0, m);
      if Result < 0 then
        exit;
      embeddedEdgeSubFolder := IncludeTrailingPathDelimiter(m) +
        embeddedEdgeSubFolder;
      if FindClientDllInFolder(embeddedEdgeSubFolder) then
        exit(S_OK)
      else
        exit(HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND));
    end;
  exit(S_OK);
end;

type
  TWebView2RunTimeType = (kInstalled = 0, kRedistributable = 1);
  TCreateWebViewEnvironmentWithOptionsInternal = function(a: boolean;
    b: TWebView2RunTimeType; c: PWideChar; d: System.IUnKnown;
    E: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler)
    : HRESULT; stdcall;
  TDllCanUnloadNow = function: HRESULT; stdcall;

  // HRESULT CreateWebViewEnvironmentWithClientDll(
  // PCWSTR lpLibFileName, bool unknown, WebView2RunTimeType runtimeType,
  // PCWSTR unknown2, System.IUnKnown* unknown3,
  // ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler*
  // envCompletedHandler) {
  // HMODULE clientDll = LoadLibraryW(lpLibFileName);
  // if (!clientDll) {
  // return HRESULT_FROM_WIN32(GetLastError());
  // }
function CreateWebViewEnvironmentWithClientDll(lplibfilename: wvstring;
  unknown: boolean; runtimeType: TWebView2RunTimeType; unknown2: PWideChar;
  unknown3: System.IUnKnown;
  envCompletedHandler
  : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT;
var
  clientDLL: HModule;
  createProc: TCreateWebViewEnvironmentWithOptionsInternal;
  canUnLoadProc: TDllCanUnloadNow;
begin
  clientDLL := LoadLibraryW(PWideChar(lplibfilename));
  if clientDLL = 0 then
    exit(HRESULT_FROM_WIN32(GetLastError));
  createProc := GetProcAddress(clientDLL,
    'CreateWebViewEnvironmentWithOptionsInternal');
  canUnLoadProc := GetProcAddress(clientDLL, 'DllCanUnloadNow');
  if not assigned(createProc) then
    exit(HRESULT_FROM_WIN32(GetLastError));
  Result := createProc(unknown, runtimeType, unknown2, unknown3,
    envCompletedHandler);
  if assigned(canUnLoadProc) and (canUnLoadProc() = 0) then
    FreeLibrary(clientDLL);
end;

// HRESULT TryCreateWebViewEnvironment(
// WebView2EnvironmentParams params,
// ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler*
// environmentCreatedHandler) {
// WebView2RunTimeType runtimeType;
// HRESULT hr;
// WString dllPath;
//
// if (params.embeddedEdgeSubFolder && *params.embeddedEdgeSubFolder) {
// runtimeType = WebView2RunTimeType::kRedistributable;
// hr = FindEmbeddedClientDll(params.embeddedEdgeSubFolder, &dllPath);
// } else {
// runtimeType = WebView2RunTimeType::kInstalled;
// hr = FindInstalledClientDll(&dllPath, params.releaseChannelPreference,
// nullptr, nullptr);
// }
// if (FAILED(hr)) {
// return hr;
// }
// return CreateWebViewEnvironmentWithClientDll(
// dllPath.String(), true, runtimeType, params.userDataDir,
// params.environmentOptions, environmentCreatedHandler);
// }
type
  TEnvironmentCreatedRetryHandler = class(TInterfacedObject,
    ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler)
  private
    mEnvironmentParams: TWebView2EnvironmentParams;
    mOriginalHandler
      : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
    mRetries: integer;
  public
    constructor Create(environmentParams: TWebView2EnvironmentParams;
      originalHandler
      : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
      retries: integer);
    function Invoke(ret: HRESULT;
      const created_environment: ICoreWebView2Environment): HRESULT; stdcall;
  end;

function TryCreateWebViewEnvironment(params: TWebView2EnvironmentParams;
  environmentCreatedHandler
  : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler): HRESULT;
var
  runtimeType: TWebView2RunTimeType;
  hr: HRESULT;
  dllPath, v, c: wvstring;
begin
  if params.embeddedEdgeSubFolder <> '' then
    begin
      runtimeType := TWebView2RunTimeType.kRedistributable;
      hr := FindEmbeddedClientDll(params.embeddedEdgeSubFolder, dllPath);
    end
  else
    begin
      runtimeType := TWebView2RunTimeType.kInstalled;
      hr := FindInstalledClientDll(dllPath,
        params.releaseChannelPreference, v, c);
    end;
  if hr < 0 then
    exit(hr);
  Result := CreateWebViewEnvironmentWithClientDll(dllPath, true, runtimeType,
    PWideChar(params.userDataDir), params.environmentOptions as System.IUnKnown,
    environmentCreatedHandler);
end;

function Internal_CreateCoreWebView2EnvironmentWithOptions;
var
  params: TWebView2EnvironmentParams;
begin
  params.embeddedEdgeSubFolder := browserExecutableFolder;
  params.userDataDir := userDataFolder;
  params.environmentOptions := environmentOptions;
  params.releaseChannelPreference := kStable;
  if not assigned(environment_created_handler) then
    exit(E_POINTER);
  UpdateWebViewEnvironmentParamsWithOverrideValues(params);
  Result := TryCreateWebViewEnvironment(params,
    TEnvironmentCreatedRetryHandler.Create(params,
    environment_created_handler, 1));
end;

function Internal_CreateCoreWebView2Environment;
begin
  exit(Internal_CreateCoreWebView2EnvironmentWithOptions(nil, nil, nil,
    environment_created_handler));
end;

// HRESULT FindEmbeddedBrowserVersion(LPCWSTR filename, WString* outBuf) {
// unsigned int puLen = 0;
// LPWSTR lpBuffer = nullptr;
// DWORD dwHandle = 0;
// DWORD cbVerInfo = GetFileVersionInfoSizeW(filename, &dwHandle);
// WString verInfoBuffer;
//
// if (!cbVerInfo) {
// return HRESULT_FROM_WIN32(GetLastError());
// }
//
// if (!verInfoBuffer.ReserveBuffer(cbVerInfo)) {
// return E_UNEXPECTED;
// }
//
// if (!GetFileVersionInfoW(filename, dwHandle, cbVerInfo,
// verInfoBuffer.Data()) ||
// !VerQueryValueW(verInfoBuffer.Data(),
// L"\\StringFileInfo\\040904B0\\ProductVersion",
// reinterpret_cast<LPVOID*>(&lpBuffer), &puLen) ||
// !lpBuffer) {
// return HRESULT_FROM_WIN32(GetLastError());
// }
//
// outBuf->Assign(lpBuffer);
// return S_OK;
// }
function FindEmbeddedBrowserVersion(filename: wvstring;
  var outBuf: wvstring): HRESULT;
var
  InfoSize, Wnd: DWORD;
  VerBuf: pointer;
  lpBuffer: pointer;
  VerSize: DWORD;
begin
  lpBuffer := nil;
  // UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(filename), Wnd);
  if InfoSize = 0 then
    exit(HRESULT_FROM_WIN32(GetLastError))
  else
    begin
      GetMem(VerBuf, InfoSize);
      try
        if not GetFileVersionInfo(PChar(filename), Wnd, InfoSize, VerBuf) or
          not VerQueryValue(VerBuf, '\StringFileInfo\040904B0\ProductVersion',
          lpBuffer, VerSize) then
          exit(HRESULT_FROM_WIN32(GetLastError));
        outBuf := PWideChar(lpBuffer);
        Result := S_OK;
      finally
        FreeMem(VerBuf);
      end;
    end;
end;

// STDAPI GetAvailableCoreWebView2BrowserVersionString(
// PCWSTR browserExecutableFolder, LPWSTR* versionInfo) {
// HRESULT hr;
// WebView2EnvironmentParams params{
// .embeddedEdgeSubFolder = browserExecutableFolder,
// .userDataDir = nullptr,
// .environmentOptions = nullptr,
// .releaseChannelPreference = WebView2ReleaseChannelPreference::kStable,
// };
// if (!versionInfo) {
// return E_POINTER;
// }
// WString outStrings[3];
//
// UpdateWebViewEnvironmentParamsWithOverrideValues(&params, outStrings);
//
// WString channelStr;
// WString versionStr;
// WString clientPath;
// if (params.embeddedEdgeSubFolder && *params.embeddedEdgeSubFolder) {
// hr = FindEmbeddedClientDll(params.embeddedEdgeSubFolder, &clientPath);
// if (FAILED(hr)) {
// *versionInfo = nullptr;
// return hr;
// }
// hr = FindEmbeddedBrowserVersion(clientPath.String(), &versionStr);
// } else {
// hr = FindInstalledClientDll(&clientPath, params.releaseChannelPreference,
// &versionStr, &channelStr);
// }
// if (FAILED(hr)) {
// *versionInfo = nullptr;
// return hr;
// }
// if (!channelStr.Empty()) {
// versionStr.Append(L" ");
// versionStr.Append(channelStr.String(), channelStr.Length());
// }
// hr = S_OK;
// *versionInfo = MakeCoMemString(versionStr.String(), versionStr.Length());
// return hr;
// }
function Internal_GetAvailableCoreWebView2BrowserVersionString;
var
  hr: HRESULT;
  params: TWebView2EnvironmentParams;
  chnstr, verstr, clnstr: wvstring;
begin
  params.embeddedEdgeSubFolder := browserExecutableFolder;
  params.userDataDir := '';
  params.environmentOptions := nil;
  params.releaseChannelPreference := kStable;
  UpdateWebViewEnvironmentParamsWithOverrideValues(params);
  if params.embeddedEdgeSubFolder <> '' then
    begin
      hr := FindEmbeddedClientDll(params.embeddedEdgeSubFolder, clnstr);
      if hr < 0 then
        begin
          pVersionInfo^ := nil;
          exit(hr);
        end;
      hr := FindEmbeddedBrowserVersion(clnstr, verstr);
    end
  else
    begin
      hr := FindInstalledClientDll(clnstr, params.releaseChannelPreference,
        verstr, chnstr);
    end;
  if hr < 0 then
    begin
      pVersionInfo^ := nil;
      exit(hr);
    end;
  if chnstr <> '' then
    verstr := verstr + ' ' + chnstr;
  pVersionInfo := CoTaskMemAlloc(Length(verstr) * sizeof(Char) + 2);
  move(verstr[1], pVersionInfo^^, Length(verstr) * sizeof(Char));
  PChar(PChar(version) + Length(verstr))^ := #0;
  Result := hr;
end;

// STDAPI CompareBrowserVersions(PCWSTR version1, PCWSTR version2, int* result) {
// if (!result) {
// return E_POINTER;
// }
// if (!version1 || !version2) {
// return E_INVALIDARG;
// }
// UINT32 v1[4], v2[4];
// if (!ParseVersionNumbers(version1, v2) ||
// !ParseVersionNumbers(version2, v1)) {
// return E_INVALIDARG;
// }
// for (int i = 0; i < 4; ++i) {
// if (v2[i] > v1[i]) {
// *result = 1;
// return S_OK;
// }
// if (v2[i] < v1[i]) {
// *result = -1;
// return S_OK;
// }
// }
// *result = 0;
// return S_OK;
// }
function Internal_CompareBrowserVersions;
var
  v1, v2: TVersionRec;
  i: integer;
begin
  if (version1 = nil) or (version2 = nil) then
    exit(E_INVALIDARG);
  if not ParseVersionNumbers(version1, v2) or
    not ParseVersionNumbers(version2, v1) then
    exit(E_INVALIDARG);
  Result := S_OK;
  for i := 0 to 3 do
    if v2[i] > v1[i] then
      begin
        pRet^ := 1;
        exit;
      end
    else if v2[i] < v1[i] then
      begin
        pRet^ := -1;
        exit;
      end;
  pRet^ := 0;
end;

{ TEnvironmentCreatedRetryHandler }

constructor TEnvironmentCreatedRetryHandler.Create(environmentParams
  : TWebView2EnvironmentParams;
  originalHandler: ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
  retries: integer);
begin
  inherited Create;
  mEnvironmentParams := environmentParams;
  mOriginalHandler := originalHandler;
  mRetries := retries;
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
      if ret < 0 then
        mOriginalHandler.Invoke(ret, nil);
    end;
  Result := S_OK;
end;

end.
