unit uWVCoreWebView2ControllerOptions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// <para>This class is a ICoreWebView2ControllerOptions wrapper.</para>
  /// <para>ICoreWebView2ControllerOptions is used to manage profile options that created by 'CreateCoreWebView2ControllerOptions'.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions">See the ICoreWebView2ControllerOptions article.</see></para>
  /// </remarks>
  TCoreWebView2ControllerOptions = class
    protected
      FBaseIntf  : ICoreWebView2ControllerOptions;
      FBaseIntf2 : ICoreWebView2ControllerOptions2;

      function GetInitialized : boolean;
      function GetProfileName : wvstring;
      function GetIsInPrivateModeEnabled : boolean;
      function GetScriptLocale : wvstring;

      procedure SetProfileName(const aValue : wvstring);
      procedure SetIsInPrivateModeEnabled(aValue : boolean);
      procedure SetScriptLocale(const aValue : wvstring);

    public
      constructor Create(const aBaseIntf : ICoreWebView2ControllerOptions); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized             : boolean                        read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                : ICoreWebView2ControllerOptions read FBaseIntf                  write FBaseIntf;
      /// <summary>
      /// <para>`ProfileName` property is to specify a profile name, which is only allowed to contain
      /// the following ASCII characters. It has a maximum length of 64 characters excluding the null-terminator.
      /// It is ASCII case insensitive.</para>
      /// <para>* alphabet characters: a-z and A-Z</para>
      /// <para>* digit characters: 0-9</para>
      /// <para>* and '#', '@', '$', '(', ')', '+', '-', '_', '~', '.', ' ' (space).</para>
      /// <para>Note: the text must not end with a period '.' or ' ' (space). And, although upper-case letters are
      /// allowed, they're treated just as lower-case counterparts because the profile name will be mapped to
      /// the real profile directory path on disk and Windows file system handles path names in a case-insensitive way.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions#get_profilename">See the ICoreWebView2ControllerOptions article.</see></para>
      /// </remarks>
      property ProfileName             : wvstring                       read GetProfileName             write SetProfileName;
      /// <summary>
      /// `IsInPrivateModeEnabled` property is to enable/disable InPrivate mode.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions#get_isinprivatemodeenabled">See the ICoreWebView2ControllerOptions article.</see></para>
      /// </remarks>
      property IsInPrivateModeEnabled  : boolean                        read GetIsInPrivateModeEnabled  write SetIsInPrivateModeEnabled;
      /// <summary>
      /// <para>The default locale for the WebView2.  It sets the default locale for all
      /// Intl JavaScript APIs and other JavaScript APIs that depend on it, namely
      /// `Intl.DateTimeFormat()` which affects string formatting like
      /// in the time/date formats. Example: `Intl.DateTimeFormat().format(new Date())`
      /// The intended locale value is in the format of
      /// BCP 47 Language Tags. More information can be found from
      /// [IETF BCP47](https://www.ietf.org/rfc/bcp/bcp47.html).</para>
      /// <para>This property sets the locale for a CoreWebView2Environment used to create the
      /// WebView2ControllerOptions object, which is passed as a parameter in
      /// `CreateCoreWebView2ControllerWithOptions`.</para>
      /// <para>Changes to the ScriptLocale property apply to renderer processes created after
      /// the change. Any existing renderer processes will continue to use the previous
      /// ScriptLocale value. To ensure changes are applied to all renderer process,
      /// close and restart the CoreWebView2Environment and all associated WebView2 objects.</para>
      /// <para>The default value for ScriptLocale will depend on the WebView2 language
      /// and OS region. If the language portions of the WebView2 language and OS region
      /// match, then it will use the OS region. Otherwise, it will use the WebView2
      /// language.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions2#get_scriptlocale">See the ICoreWebView2ControllerOptions2 article.</see></para>
      /// </remarks>
      property ScriptLocale            : wvstring                       read GetScriptLocale            write SetScriptLocale;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVMiscFunctions;

constructor TCoreWebView2ControllerOptions.Create(const aBaseIntf : ICoreWebView2ControllerOptions);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2ControllerOptions2, FBaseIntf2);
end;

destructor TCoreWebView2ControllerOptions.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ControllerOptions.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ControllerOptions.GetProfileName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ProfileName(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ControllerOptions.GetIsInPrivateModeEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsInPrivateModeEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ControllerOptions.GetScriptLocale : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_ScriptLocale(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

procedure TCoreWebView2ControllerOptions.SetProfileName(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_ProfileName(PWideChar(aValue));
end;

procedure TCoreWebView2ControllerOptions.SetIsInPrivateModeEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsInPrivateModeEnabled(ord(aValue));
end;

procedure TCoreWebView2ControllerOptions.SetScriptLocale(const aValue : wvstring);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_ScriptLocale(PWideChar(aValue));
end;

end.
