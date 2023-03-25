unit uWVCoreWebView2EnvironmentOptions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  WinApi.Windows, Winapi.ActiveX,
  {$ELSE}
  Windows, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2EnvironmentOptions = class(TInterfacedObject,
                                          ICoreWebView2EnvironmentOptions,
                                          ICoreWebView2EnvironmentOptions2,
                                          ICoreWebView2EnvironmentOptions3,
                                          ICoreWebView2EnvironmentOptions4,
                                          ICoreWebView2EnvironmentOptions5)
    protected
      FAdditionalBrowserArguments             : wvstring;
      FLanguage                               : wvstring;
      FTargetCompatibleBrowserVersion         : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount : boolean;
      FExclusiveUserDataFolderAccess          : boolean;
      FCustomCrashReportingEnabled            : boolean;
      FSchemeRegistrations                    : TWVCustomSchemeRegistrationArray;
      FEnableTrackingPrevention               : boolean;

      // ICoreWebView2EnvironmentOptions
      function Get_AdditionalBrowserArguments(out value: PWideChar): HResult; stdcall;
      function Set_AdditionalBrowserArguments(value: PWideChar): HResult; stdcall;
      function Get_Language(out value: PWideChar): HResult; stdcall;
      function Set_Language(value: PWideChar): HResult; stdcall;
      function Get_TargetCompatibleBrowserVersion(out value: PWideChar): HResult; stdcall;
      function Set_TargetCompatibleBrowserVersion(value: PWideChar): HResult; stdcall;
      function Get_AllowSingleSignOnUsingOSPrimaryAccount(out allow: Integer): HResult; stdcall;
      function Set_AllowSingleSignOnUsingOSPrimaryAccount(allow: Integer): HResult; stdcall;

      // ICoreWebView2EnvironmentOptions2
      function Get_ExclusiveUserDataFolderAccess(out value: Integer): HResult; stdcall;
      function Set_ExclusiveUserDataFolderAccess(value: Integer): HResult; stdcall;

      // ICoreWebView2EnvironmentOptions3
      function Get_IsCustomCrashReportingEnabled(out value: Integer): HResult; stdcall;
      function Set_IsCustomCrashReportingEnabled(value: Integer): HResult; stdcall;

      // ICoreWebView2EnvironmentOptions4
      function GetCustomSchemeRegistrations(out Count: SYSUINT; out schemeRegistrations: PPCoreWebView2CustomSchemeRegistration): HResult; stdcall;
      function SetCustomSchemeRegistrations(Count: SYSUINT; schemeRegistrations: PPCoreWebView2CustomSchemeRegistration): HResult; stdcall;

      // ICoreWebView2EnvironmentOptions5
      function Get_EnableTrackingPrevention(out value: Integer): HResult; stdcall;
      function Set_EnableTrackingPrevention(value: Integer): HResult; stdcall;

      procedure DestroySchemeRegistrations;

    public
      constructor Create(const aAdditionalBrowserArguments, aLanguage, aTargetCompatibleBrowserVersion : wvstring; aAllowSingleSignOnUsingOSPrimaryAccount, aExclusiveUserDataFolderAccess, aCustomCrashReportingEnabled : boolean; const aSchemeRegistrations: TWVCustomSchemeRegistrationArray; aEnableTrackingPrevention: boolean);
      destructor  Destroy; override;
  end;

implementation

uses
  uWVMiscFunctions;

constructor TCoreWebView2EnvironmentOptions.Create(const aAdditionalBrowserArguments             : wvstring;
                                                   const aLanguage                               : wvstring;
                                                   const aTargetCompatibleBrowserVersion         : wvstring;
                                                         aAllowSingleSignOnUsingOSPrimaryAccount : boolean;
                                                         aExclusiveUserDataFolderAccess          : boolean;
                                                         aCustomCrashReportingEnabled            : boolean;
                                                   const aSchemeRegistrations                    : TWVCustomSchemeRegistrationArray;
                                                         aEnableTrackingPrevention               : boolean);
var
  i : integer;
begin
  inherited Create;

  FAdditionalBrowserArguments             := aAdditionalBrowserArguments;
  FLanguage                               := aLanguage;
  FTargetCompatibleBrowserVersion         := aTargetCompatibleBrowserVersion;
  FAllowSingleSignOnUsingOSPrimaryAccount := aAllowSingleSignOnUsingOSPrimaryAccount;
  FExclusiveUserDataFolderAccess          := aExclusiveUserDataFolderAccess;
  FCustomCrashReportingEnabled            := aCustomCrashReportingEnabled;
  FSchemeRegistrations                    := nil;
  FEnableTrackingPrevention               := aEnableTrackingPrevention;

  if assigned(aSchemeRegistrations) then
    begin
      i := length(aSchemeRegistrations);
      SetLength(FSchemeRegistrations,  i);
      ZeroMemory(FSchemeRegistrations, i * SizeOf(ICoreWebView2CustomSchemeRegistration));

      dec(i);
      while (i >= 0) do
        begin
          FSchemeRegistrations[i] := aSchemeRegistrations[i];
          dec(i);
        end;
    end;
end;

destructor TCoreWebView2EnvironmentOptions.Destroy;
begin
  DestroySchemeRegistrations;

  inherited Destroy;
end;

procedure TCoreWebView2EnvironmentOptions.DestroySchemeRegistrations;
var
  i : integer;
begin
  if assigned(FSchemeRegistrations) then
    begin
      i := pred(length(FSchemeRegistrations));

      while (i >= 0) do
        begin
          FSchemeRegistrations[i] := nil;
          dec(i);
        end;

      SetLength(FSchemeRegistrations, 0);
    end;
end;

function TCoreWebView2EnvironmentOptions.Get_AdditionalBrowserArguments(out value: PWideChar): HResult; stdcall;
begin
  Result := S_OK;
  value  := AllocCoTaskMemStr(FAdditionalBrowserArguments);
end;

function TCoreWebView2EnvironmentOptions.Set_AdditionalBrowserArguments(value: PWideChar): HResult; stdcall;
begin
  Result := S_OK;

  if (value <> nil) then
    begin
      FAdditionalBrowserArguments := value;
      CoTaskMemFree(value);
    end
   else
    FAdditionalBrowserArguments := '';
end;

function TCoreWebView2EnvironmentOptions.Get_Language(out value: PWideChar): HResult; stdcall;
begin
  Result := S_OK;
  value  := AllocCoTaskMemStr(FLanguage);
end;

function TCoreWebView2EnvironmentOptions.Set_Language(value: PWideChar): HResult; stdcall;
begin
  Result := S_OK;

  if (value <> nil) then
    begin
      FLanguage := value;
      CoTaskMemFree(value);
    end
   else
    FLanguage := '';
end;

function TCoreWebView2EnvironmentOptions.Get_TargetCompatibleBrowserVersion(out value: PWideChar): HResult; stdcall;
begin
  Result := S_OK;
  value  := AllocCoTaskMemStr(FTargetCompatibleBrowserVersion);
end;

function TCoreWebView2EnvironmentOptions.Set_TargetCompatibleBrowserVersion(value: PWideChar): HResult; stdcall;
begin
  Result := S_OK;

  if (value <> nil) then
    begin
      FTargetCompatibleBrowserVersion := value;
      CoTaskMemFree(value);
    end
   else
    FTargetCompatibleBrowserVersion := '';
end;

function TCoreWebView2EnvironmentOptions.Get_AllowSingleSignOnUsingOSPrimaryAccount(out allow: Integer): HResult; stdcall;
begin
  Result := S_OK;
  allow  := ord(FAllowSingleSignOnUsingOSPrimaryAccount);
end;

function TCoreWebView2EnvironmentOptions.Set_AllowSingleSignOnUsingOSPrimaryAccount(allow: Integer): HResult; stdcall;
begin
  Result := S_OK;
  FAllowSingleSignOnUsingOSPrimaryAccount := (allow <> 0);
end;

function TCoreWebView2EnvironmentOptions.Get_ExclusiveUserDataFolderAccess(out value: Integer): HResult; stdcall;
begin
  Result := S_OK;
  value  := ord(FExclusiveUserDataFolderAccess);
end;

function TCoreWebView2EnvironmentOptions.Set_ExclusiveUserDataFolderAccess(value: Integer): HResult; stdcall;
begin
  Result := S_OK;
  FExclusiveUserDataFolderAccess := (value <> 0);
end;

function TCoreWebView2EnvironmentOptions.Get_IsCustomCrashReportingEnabled(out value: Integer): HResult; stdcall;
begin
  Result := S_OK;
  value  := ord(FCustomCrashReportingEnabled);
end;

function TCoreWebView2EnvironmentOptions.Set_IsCustomCrashReportingEnabled(value: Integer): HResult; stdcall;
begin
  Result                       := S_OK;
  FCustomCrashReportingEnabled := (value <> 0);
end;

function TCoreWebView2EnvironmentOptions.GetCustomSchemeRegistrations(out Count               : SYSUINT;
                                                                      out schemeRegistrations : PPCoreWebView2CustomSchemeRegistration): HResult; stdcall;
var
  TempArray : PPCoreWebView2CustomSchemeRegistration;
  i         : SYSUINT;
  TempLen   : integer;
begin
  Result              := S_OK;
  Count               := length(FSchemeRegistrations);
  schemeRegistrations := nil;

  if (Count = 0) then exit;

  TempLen             := Count * SizeOf(ICoreWebView2CustomSchemeRegistration);
  schemeRegistrations := CoTaskMemAlloc(TempLen);
  TempArray           := schemeRegistrations;
  ZeroMemory(TempArray, TempLen);

  i := 0;
  while (i < count) do
    begin
      TempArray^ := FSchemeRegistrations[i];
      inc(TempArray);
      inc(i);
    end;
end;

function TCoreWebView2EnvironmentOptions.SetCustomSchemeRegistrations(Count               : SYSUINT;
                                                                      schemeRegistrations : PPCoreWebView2CustomSchemeRegistration): HResult; stdcall;
var
  TempArray : PPCoreWebView2CustomSchemeRegistration;
  i         : SYSUINT;
begin
  Result := S_OK;
  DestroySchemeRegistrations;

  if (Count = 0) then exit;

  SetLength(FSchemeRegistrations,  Count);
  ZeroMemory(FSchemeRegistrations, Count * SizeOf(ICoreWebView2CustomSchemeRegistration));

  TempArray := schemeRegistrations;
  i         := 0;

  while (i < Count) do
    begin
      FSchemeRegistrations[i] := TempArray^;
      inc(TempArray);
      inc(i);
    end;

  CoTaskMemFree(schemeRegistrations);
end;

function TCoreWebView2EnvironmentOptions.Get_EnableTrackingPrevention(out value: Integer): HResult; stdcall;
begin
  Result := S_OK;
  value  := ord(FEnableTrackingPrevention);
end;

function TCoreWebView2EnvironmentOptions.Set_EnableTrackingPrevention(value: Integer): HResult; stdcall;
begin
  Result                    := S_OK;
  FEnableTrackingPrevention := (value <> 0);
end;

end.
