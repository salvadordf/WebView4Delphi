unit uWVCoreWebView2ControllerOptions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, System.Types, System.UITypes, Winapi.Windows, System.SysUtils,
  {$ELSE}
  Classes, Graphics, Windows, SysUtils,
  {$ENDIF}
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
      FBaseIntf3 : ICoreWebView2ControllerOptions3;
      FBaseIntf4 : ICoreWebView2ControllerOptions4;

      function  GetInitialized : boolean;
      function  GetProfileName : wvstring;
      function  GetIsInPrivateModeEnabled : boolean;
      function  GetScriptLocale : wvstring;
      function  GetDefaultBackgroundColor : TColor;
      function  GetAllowHostInputProcessing : boolean;

      procedure SetProfileName(const aValue : wvstring);
      procedure SetIsInPrivateModeEnabled(aValue : boolean);
      procedure SetScriptLocale(const aValue : wvstring);
      procedure SetDefaultBackgroundColor(const aValue : TColor);
      procedure SetAllowHostInputProcessing(aValue : boolean);

      procedure InitializeFields;

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
      /// <summary>
      /// <para>This property allows users to initialize the `DefaultBackgroundColor` early,
      /// preventing a white flash that can occur while WebView2 is loading when
      /// the background color is set to something other than white. With early
      /// initialization, the color remains consistent from the start. After
      /// initialization, `CoreWebView2Controller.DefaultBackgroundColor` will return the value set using this API.</para>
      ///
      /// <para>The `CoreWebView2Controller.DefaultBackgroundColor` can be set via the WEBVIEW2_DEFAULT_BACKGROUND_COLOR environment variable,
      /// which will remain supported for cases where this solution is being used.
      /// It is encouraged to transition away from the environment variable and use this API solution to
      /// apply the property. It is important to highlight that when set, the enviroment variable overrides
      /// ControllerOptions::DefaultBackgroundColor and becomes the initial value of Controller::DefaultBackgroundColor.</para>
      ///
      /// <para>The `DefaultBackgroundColor` is the color that renders underneath all web
      /// content. This means WebView2 renders this color when there is no web
      /// content loaded. When no background color is defined in WebView2, it uses
      /// the `DefaultBackgroundColor` property to render the background.
      /// By default, this color is set to white.</para>
      ///
      /// <para>This API only supports opaque colors and full transparency. It will
      /// fail for colors with alpha values that don't equal 0 or 255.
      /// When WebView2 is set to be fully transparent, it does not render a background,
      /// allowing the content from windows behind it to be visible.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions3#put_defaultbackgroundcolor">See the ICoreWebView2Controller3 article.</see></para>
      /// </remarks>
      property DefaultBackgroundColor  : TColor                         read GetDefaultBackgroundColor    write SetDefaultBackgroundColor;
      /// <summary>
      /// <para>`AllowHostInputProcessing` property is to enable/disable input passing through
      /// the app before being delivered to the WebView2. This property is only applicable
      /// to controllers created with `CoreWebView2Environment.CreateCoreWebView2ControllerAsync` and not
      /// composition controllers created with `CoreWebView2Environment.CreateCoreWebView2CompositionControllerAsync`.
      /// By default the value is `FALSE`.</para>
      /// <para>Setting this property has no effect when using visual hosting.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions4#put_allowhostinputprocessing">See the ICoreWebView2Controller4 article.</see></para>
      /// </remarks>
      property AllowHostInputProcessing : boolean                       read GetAllowHostInputProcessing  write SetAllowHostInputProcessing;
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

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2ControllerOptions2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2ControllerOptions3, FBaseIntf3) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2ControllerOptions4, FBaseIntf4);
end;

destructor TCoreWebView2ControllerOptions.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2ControllerOptions.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
  FBaseIntf4 := nil;
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

function TCoreWebView2ControllerOptions.GetDefaultBackgroundColor : TColor;
var
  TempResult : COREWEBVIEW2_COLOR;
begin
  if assigned(FBaseIntf3) and
     succeeded(FBaseIntf3.Get_DefaultBackgroundColor(TempResult)) then
    Result := CoreWebViewColorToDelphiColor(TempResult)
   else
    {$IFDEF DELPHI16_UP}
    Result := TColors.SysNone;  // clNone
    {$ELSE}
    Result := clNone;
    {$ENDIF}
end;

function TCoreWebView2ControllerOptions.GetAllowHostInputProcessing : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.Get_AllowHostInputProcessing(TempResult)) and
            (TempResult <> 0);
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

procedure TCoreWebView2ControllerOptions.SetDefaultBackgroundColor(const aValue : TColor);
var
  TempColor : COREWEBVIEW2_COLOR;
begin
  if assigned(FBaseIntf3) then
    begin
      TempColor := DelphiColorToCoreWebViewColor(aValue);

      // The only supported alpha values are 0 (transparent) and 255 (opaque).
      if not(TempColor.A in [0, 255]) then
        TempColor.A := 255;

      FBaseIntf3.Set_DefaultBackgroundColor(TempColor);
    end;
end;

procedure TCoreWebView2ControllerOptions.SetAllowHostInputProcessing(aValue : boolean);
begin
  if assigned(FBaseIntf4) then
    FBaseIntf4.Set_AllowHostInputProcessing(ord(aValue));
end;

end.
