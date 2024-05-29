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
  /// <summary>
  /// Options used to create WebView2 Environment.  A default implementation is
  /// provided in WebView2EnvironmentOptions.h.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
  /// </remarks>
  TCoreWebView2EnvironmentOptions = class(TInterfacedObject,
                                          ICoreWebView2EnvironmentOptions,
                                          ICoreWebView2EnvironmentOptions2,
                                          ICoreWebView2EnvironmentOptions3,
                                          ICoreWebView2EnvironmentOptions4,
                                          ICoreWebView2EnvironmentOptions5,
                                          ICoreWebView2EnvironmentOptions6,
                                          ICoreWebView2EnvironmentOptions7,
                                          ICoreWebView2EnvironmentOptions8)
    protected
      FAdditionalBrowserArguments             : wvstring;
      FLanguage                               : wvstring;
      FTargetCompatibleBrowserVersion         : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount : boolean;
      FExclusiveUserDataFolderAccess          : boolean;
      FCustomCrashReportingEnabled            : boolean;
      FSchemeRegistrations                    : TWVCustomSchemeRegistrationArray;
      FEnableTrackingPrevention               : boolean;
      FAreBrowserExtensionsEnabled            : boolean;
      FChannelSearchKind                      : TWVChannelSearchKind;
      FReleaseChannels                        : TWVReleaseChannels;
      FScrollBarStyle                         : TWVScrollBarStyle;

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

      // ICoreWebView2EnvironmentOptions6
      function Get_AreBrowserExtensionsEnabled(out value: Integer): HResult; stdcall;
      function Set_AreBrowserExtensionsEnabled(value: Integer): HResult; stdcall;

      // ICoreWebView2EnvironmentOptions7
      function Get_ChannelSearchKind(out value: COREWEBVIEW2_CHANNEL_SEARCH_KIND): HResult; stdcall;
      function Set_ChannelSearchKind(value: COREWEBVIEW2_CHANNEL_SEARCH_KIND): HResult; stdcall;
      function Get_ReleaseChannels(out value: COREWEBVIEW2_RELEASE_CHANNELS): HResult; stdcall;
      function Set_ReleaseChannels(value: COREWEBVIEW2_RELEASE_CHANNELS): HResult; stdcall;

      // ICoreWebView2EnvironmentOptions8
      function Get_ScrollBarStyle(out value: COREWEBVIEW2_SCROLLBAR_STYLE): HResult; stdcall;
      function Set_ScrollBarStyle(value: COREWEBVIEW2_SCROLLBAR_STYLE): HResult; stdcall;

      procedure DestroySchemeRegistrations;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2EnvironmentOptions wrapper.
      /// </summary>
      /// <param name="aAdditionalBrowserArguments">Additional command line switches.</param>
      /// <param name="aLanguage">The default display language for WebView.  It applies to browser UI such as context menu and dialogs.  It also applies to the `accept-languages` HTTP header that WebView sends to websites.</param>
      /// <param name="aTargetCompatibleBrowserVersion">Specifies the version of the WebView2 Runtime binaries required to be compatible with your app.</param>
      /// <param name="aAllowSingleSignOnUsingOSPrimaryAccount">Used to enable single sign on with Azure Active Directory (AAD) and personal Microsoft Account (MSA) resources inside WebView.</param>
      /// <param name="aExclusiveUserDataFolderAccess">Whether other processes can create WebView2 from WebView2Environment created with the same user data folder and therefore sharing the same WebView browser process instance.</param>
      /// <param name="aCustomCrashReportingEnabled">Send crash data to Microsoft endpoint or respect OS consent.</param>
      /// <param name="aSchemeRegistrations">Array of custom scheme registrations.</param>
      /// <param name="aEnableTrackingPrevention">Enable tracking prevention.</param>
      /// <param name="aAreBrowserExtensionsEnabled">If it's set to True, new extensions can be added to user profile and used.</param>
      /// <param name="aChannelSearchKind">WebView2 Runtime channel search order.</param>
      /// <param name="aReleaseChannels">Indicates which channels environment creation should search for.</param>
      /// <param name="aScrollBarStyle">The ScrollBar style being set on the WebView2 Environment.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions2">See the ICoreWebView2EnvironmentOptions2 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions3">See the ICoreWebView2EnvironmentOptions3 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions4">See the ICoreWebView2EnvironmentOptions4 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions5">See the ICoreWebView2EnvironmentOptions5 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions6">See the ICoreWebView2EnvironmentOptions6 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7">See the ICoreWebView2EnvironmentOptions7 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions8">See the ICoreWebView2EnvironmentOptions8 article.</see></para>
      /// </remarks>
      constructor Create(const aAdditionalBrowserArguments, aLanguage, aTargetCompatibleBrowserVersion : wvstring; aAllowSingleSignOnUsingOSPrimaryAccount, aExclusiveUserDataFolderAccess, aCustomCrashReportingEnabled : boolean; const aSchemeRegistrations: TWVCustomSchemeRegistrationArray; aEnableTrackingPrevention, aAreBrowserExtensionsEnabled: boolean; aChannelSearchKind : TWVChannelSearchKind; aReleaseChannels : TWVReleaseChannels; aScrollBarStyle: TWVScrollBarStyle);
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
                                                         aEnableTrackingPrevention               : boolean;
                                                         aAreBrowserExtensionsEnabled            : boolean;
                                                         aChannelSearchKind                      : TWVChannelSearchKind;
                                                         aReleaseChannels                        : TWVReleaseChannels;
                                                         aScrollBarStyle                         : TWVScrollBarStyle);
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
  FAreBrowserExtensionsEnabled            := aAreBrowserExtensionsEnabled;
  FChannelSearchKind                      := aChannelSearchKind;
  FReleaseChannels                        := aReleaseChannels;
  FScrollBarStyle                         := aScrollBarStyle;

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
    try
      i := pred(length(FSchemeRegistrations));

      while (i >= 0) do
        begin
          FSchemeRegistrations[i] := nil;
          dec(i);
        end;
    finally
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

function TCoreWebView2EnvironmentOptions.Get_AreBrowserExtensionsEnabled(out value: Integer): HResult; stdcall;
begin
  Result := S_OK;
  value  := ord(FAreBrowserExtensionsEnabled);
end;

function TCoreWebView2EnvironmentOptions.Set_AreBrowserExtensionsEnabled(value: Integer): HResult; stdcall;
begin
  Result                       := S_OK;
  FAreBrowserExtensionsEnabled := (value <> 0);
end;

function TCoreWebView2EnvironmentOptions.Get_ChannelSearchKind(out value: COREWEBVIEW2_CHANNEL_SEARCH_KIND): HResult; stdcall;
begin
  Result := S_OK;
  value  := FChannelSearchKind;
end;

function TCoreWebView2EnvironmentOptions.Set_ChannelSearchKind(value: COREWEBVIEW2_CHANNEL_SEARCH_KIND): HResult; stdcall;
begin
  Result             := S_OK;
  FChannelSearchKind := value;
end;

function TCoreWebView2EnvironmentOptions.Get_ReleaseChannels(out value: COREWEBVIEW2_RELEASE_CHANNELS): HResult; stdcall;
begin
  Result := S_OK;
  value  := FReleaseChannels;
end;

function TCoreWebView2EnvironmentOptions.Set_ReleaseChannels(value: COREWEBVIEW2_RELEASE_CHANNELS): HResult; stdcall;
begin
  Result           := S_OK;
  FReleaseChannels := value;
end;

function TCoreWebView2EnvironmentOptions.Get_ScrollBarStyle(out value: COREWEBVIEW2_SCROLLBAR_STYLE): HResult; stdcall;
begin
  Result := S_OK;
  value  := FScrollBarStyle;
end;

function TCoreWebView2EnvironmentOptions.Set_ScrollBarStyle(value: COREWEBVIEW2_SCROLLBAR_STYLE): HResult; stdcall;
begin
  Result          := S_OK;
  FScrollBarStyle := value;
end;

end.
