unit uWVCoreWebView2EnvironmentOptions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  {$IFDEF FPC}
  Windows, ActiveX,
  {$ELSE}
  WinApi.Windows, Winapi.ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2EnvironmentOptions = class(TInterfacedObject, ICoreWebView2EnvironmentOptions, ICoreWebView2EnvironmentOptions2)
    protected
      FAdditionalBrowserArguments             : wvstring;
      FLanguage                               : wvstring;
      FTargetCompatibleBrowserVersion         : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount : boolean;
      FExclusiveUserDataFolderAccess          : boolean;

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

    public
      constructor Create(const aAdditionalBrowserArguments, aLanguage, aTargetCompatibleBrowserVersion : wvstring; aAllowSingleSignOnUsingOSPrimaryAccount, aExclusiveUserDataFolderAccess : boolean);
  end;

implementation

uses
  uWVMiscFunctions;

constructor TCoreWebView2EnvironmentOptions.Create(const aAdditionalBrowserArguments             : wvstring;
                                                   const aLanguage                               : wvstring;
                                                   const aTargetCompatibleBrowserVersion         : wvstring;
                                                         aAllowSingleSignOnUsingOSPrimaryAccount : boolean;
                                                         aExclusiveUserDataFolderAccess          : boolean);
begin
  inherited Create;

  FAdditionalBrowserArguments             := aAdditionalBrowserArguments;
  FLanguage                               := aLanguage;
  FTargetCompatibleBrowserVersion         := aTargetCompatibleBrowserVersion;
  FAllowSingleSignOnUsingOSPrimaryAccount := aAllowSingleSignOnUsingOSPrimaryAccount;
  FExclusiveUserDataFolderAccess          := aExclusiveUserDataFolderAccess;
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

end.
