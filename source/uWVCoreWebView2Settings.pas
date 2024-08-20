unit uWVCoreWebView2Settings;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Defines properties that enable, disable, or modify WebView features.
  /// Changes to IsGeneralAutofillEnabled and IsPasswordAutosaveEnabled
  /// apply immediately, while other setting changes made after NavigationStarting
  /// event do not apply until the next top-level navigation.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings">See the ICoreWebView2Settings article.</see></para>
  /// </remarks>
  TCoreWebView2Settings = class
    protected
      FBaseIntf  : ICoreWebView2Settings;
      FBaseIntf2 : ICoreWebView2Settings2;
      FBaseIntf3 : ICoreWebView2Settings3;
      FBaseIntf4 : ICoreWebView2Settings4;
      FBaseIntf5 : ICoreWebView2Settings5;
      FBaseIntf6 : ICoreWebView2Settings6;
      FBaseIntf7 : ICoreWebView2Settings7;
      FBaseIntf8 : ICoreWebView2Settings8;
      FBaseIntf9 : ICoreWebView2Settings9;

      function  GetInitialized : boolean;
      function  GetIsBuiltInErrorPageEnabled : boolean;
      function  GetAreDefaultContextMenusEnabled : boolean;
      function  GetAreDefaultScriptDialogsEnabled : boolean;
      function  GetAreDevToolsEnabled : boolean;
      function  GetIsScriptEnabled : boolean;
      function  GetIsStatusBarEnabled : boolean;
      function  GetIsWebMessageEnabled : boolean;
      function  GetIsZoomControlEnabled : boolean;
      function  GetAreHostObjectsAllowed : boolean;
      function  GetUserAgent : wvstring;
      function  GetAreBrowserAcceleratorKeysEnabled : boolean;
      function  GetIsPasswordAutosaveEnabled : boolean;
      function  GetIsGeneralAutofillEnabled : boolean;
      function  GetIsPinchZoomEnabled : boolean;
      function  GetIsSwipeNavigationEnabled : boolean;
      function  GetHiddenPdfToolbarItems : TWVPDFToolbarItems;
      function  GetIsReputationCheckingRequired : boolean;
      function  GetIsNonClientRegionSupportEnabled : boolean;

      procedure SetIsBuiltInErrorPageEnabled(aValue : boolean);
      procedure SetAreDefaultContextMenusEnabled(aValue : boolean);
      procedure SetAreDefaultScriptDialogsEnabled(aValue : boolean);
      procedure SetAreDevToolsEnabled(aValue : boolean);
      procedure SetIsScriptEnabled(aValue : boolean);
      procedure SetIsStatusBarEnabled(aValue : boolean);
      procedure SetIsWebMessageEnabled(aValue : boolean);
      procedure SetIsZoomControlEnabled(aValue : boolean);
      procedure SetAreHostObjectsAllowed(aValue : boolean);
      procedure SetUserAgent(const aValue : wvstring);
      procedure SetAreBrowserAcceleratorKeysEnabled(aValue : boolean);
      procedure SetIsPasswordAutosaveEnabled(aValue : boolean);
      procedure SetIsGeneralAutofillEnabled(aValue : boolean);
      procedure SetIsPinchZoomEnabled(aValue : boolean);
      procedure SetIsSwipeNavigationEnabled(aValue : boolean);
      procedure SetHiddenPdfToolbarItems(aValue : TWVPDFToolbarItems);
      procedure SetIsReputationCheckingRequired(aValue : boolean);
      procedure SetIsNonClientRegionSupportEnabled(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Settings); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property    Initialized                      : boolean                read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property    BaseIntf                         : ICoreWebView2Settings  read FBaseIntf;
      /// <summary>
      /// The `IsBuiltInErrorPageEnabled` property is used to disable built in
      /// error page for navigation failure and render process failure.  When
      /// disabled, a blank page is displayed when the related error happens.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_isbuiltinerrorpageenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    IsBuiltInErrorPageEnabled        : boolean                read GetIsBuiltInErrorPageEnabled         write SetIsBuiltInErrorPageEnabled;
      /// <summary>
      /// The `AreDefaultContextMenusEnabled` property is used to prevent default
      /// context menus from being shown to user in WebView.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_aredefaultcontextmenusenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    AreDefaultContextMenusEnabled    : boolean                read GetAreDefaultContextMenusEnabled     write SetAreDefaultContextMenusEnabled;
      /// <summary>
      /// `AreDefaultScriptDialogsEnabled` is used when loading a new HTML
      /// document.  If set to `FALSE`, WebView2 does not render the default JavaScript
      /// dialog box (Specifically those displayed by the JavaScript alert,
      /// confirm, prompt functions and `beforeunload` event).  Instead, if an
      /// event handler is set using `add_ScriptDialogOpening`, WebView sends an
      /// event that contains all of the information for the dialog and allow the
      /// host app to show a custom UI.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_aredefaultscriptdialogsenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    AreDefaultScriptDialogsEnabled   : boolean                read GetAreDefaultScriptDialogsEnabled    write SetAreDefaultScriptDialogsEnabled;
      /// <summary>
      /// `AreDevToolsEnabled` controls whether the user is able to use the context
      /// menu or keyboard shortcuts to open the DevTools window.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_aredevtoolsenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    AreDevToolsEnabled               : boolean                read GetAreDevToolsEnabled                write SetAreDevToolsEnabled;
      /// <summary>
      /// Controls if running JavaScript is enabled in all future navigations in
      /// the WebView.  This only affects scripts in the document.  Scripts
      /// injected with `ExecuteScript` runs even if script is disabled.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_isscriptenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    IsScriptEnabled                  : boolean                read GetIsScriptEnabled                   write SetIsScriptEnabled;
      /// <summary>
      /// `IsStatusBarEnabled` controls whether the status bar is displayed.  The
      /// status bar is usually displayed in the lower left of the WebView and
      /// shows things such as the URI of a link when the user hovers over it and
      /// other information. The default value is `TRUE`. The status bar UI can be
      /// altered by web content and should not be considered secure.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_isstatusbarenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    IsStatusBarEnabled               : boolean                read GetIsStatusBarEnabled                write SetIsStatusBarEnabled;
      /// <summary>
      /// The `IsWebMessageEnabled` property is used when loading a new HTML
      /// document.  If set to `TRUE`, communication from the host to the top-level
      ///  HTML document of the WebView is allowed using `PostWebMessageAsJson`,
      /// `PostWebMessageAsString`, and message event of `window.chrome.webview`.
      /// For more information, navigate to PostWebMessageAsJson.  Communication
      /// from the top-level HTML document of the WebView to the host is allowed
      /// using the postMessage function of `window.chrome.webview` and
      /// `add_WebMessageReceived` method.  For more information, navigate to
      /// [add_WebMessageReceived](/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived).
      /// If set to false, then communication is disallowed.  `PostWebMessageAsJson`
      /// and `PostWebMessageAsString` fails with `E_ACCESSDENIED` and
      /// `window.chrome.webview.postMessage` fails by throwing an instance of an
      /// `Error` object. The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_iswebmessageenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    IsWebMessageEnabled              : boolean                read GetIsWebMessageEnabled               write SetIsWebMessageEnabled;
      /// <summary>
      /// The `IsZoomControlEnabled` property is used to prevent the user from
      /// impacting the zoom of the WebView.  When disabled, the user is not able
      /// to zoom using Ctrl++, Ctrl+-, or Ctrl+mouse wheel, but the zoom
      /// is set using `ZoomFactor` API.  The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_iszoomcontrolenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    IsZoomControlEnabled             : boolean                read GetIsZoomControlEnabled              write SetIsZoomControlEnabled;
      /// <summary>
      /// The `AreHostObjectsAllowed` property is used to control whether host
      /// objects are accessible from the page in WebView.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_arehostobjectsallowed">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property    AreHostObjectsAllowed            : boolean                read GetAreHostObjectsAllowed             write SetAreHostObjectsAllowed;
      /// <summary>
      /// <para>Returns the User Agent. The default value is the default User Agent of the
      /// Microsoft Edge browser.</para>
      /// <para>This property may be overridden if
      /// the User-Agent header is set in a request. If the parameter is empty
      /// the User Agent will not be updated and the current User Agent will remain.
      /// Setting this property may clear User Agent Client Hints headers
      /// Sec-CH-UA-* and script values from navigator.userAgentData. Current
      /// implementation behavior is subject to change.</para>
      /// <para>The User Agent set will also be effective on service workers
      /// and shared workers associated with the WebView. If there are
      /// multiple WebViews associated with the same service worker or
      /// shared worker, the last User Agent set will be used.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings2#get_useragent">See the ICoreWebView2Settings2 article.</see></para>
      /// </remarks>
      property    UserAgent                        : wvstring               read GetUserAgent                         write SetUserAgent;
      /// <summary>
      /// When this setting is set to FALSE, it disables all accelerator keys that
      /// access features specific to a web browser, including but not limited to:
      ///  - Ctrl-F and F3 for Find on Page
      ///  - Ctrl-P for Print
      ///  - Ctrl-R and F5 for Reload
      ///  - Ctrl-Plus and Ctrl-Minus for zooming
      ///  - Ctrl-Shift-C and F12 for DevTools
      ///  - Special keys for browser functions, such as Back, Forward, and Search
      ///
      /// It does not disable accelerator keys related to movement and text editing,
      /// such as:
      ///  - Home, End, Page Up, and Page Down
      ///  - Ctrl-X, Ctrl-C, Ctrl-V
      ///  - Ctrl-A for Select All
      ///  - Ctrl-Z for Undo
      ///
      /// Those accelerator keys will always be enabled unless they are handled in
      /// the `AcceleratorKeyPressed` event.
      ///
      /// This setting has no effect on the `AcceleratorKeyPressed` event.  The event
      /// will be fired for all accelerator keys, whether they are enabled or not.
      ///
      /// The default value for `AreBrowserAcceleratorKeysEnabled` is TRUE.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings3#get_arebrowseracceleratorkeysenabled">See the ICoreWebView2Settings3 article.</see></para>
      /// </remarks>
      property    AreBrowserAcceleratorKeysEnabled : boolean                read GetAreBrowserAcceleratorKeysEnabled  write SetAreBrowserAcceleratorKeysEnabled;
      /// <summary>
      /// IsPasswordAutosaveEnabled controls whether autosave for password
      /// information is enabled. The IsPasswordAutosaveEnabled property behaves
      /// independently of the IsGeneralAutofillEnabled property. When IsPasswordAutosaveEnabled is
      /// false, no new password data is saved and no Save/Update Password prompts are displayed.
      /// However, if there was password data already saved before disabling this setting,
      /// then that password information is auto-populated, suggestions are shown and clicking on
      /// one will populate the fields.
      /// When IsPasswordAutosaveEnabled is true, password information is auto-populated,
      /// suggestions are shown and clicking on one will populate the fields, new data
      /// is saved, and a Save/Update Password prompt is displayed.
      /// It will take effect immediately after setting.
      /// The default value is `FALSE`.
      /// This property has the same value as
      /// `CoreWebView2Profile.IsPasswordAutosaveEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsPasswordAutosaveEnabled` and
      /// `CoreWebView2Profile.IsPasswordAutosaveEnabled` will always have the same
      /// value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings4#get_ispasswordautosaveenabled">See the ICoreWebView2Settings4 article.</see></para>
      /// </remarks>
      property    IsPasswordAutosaveEnabled        : boolean                read GetIsPasswordAutosaveEnabled         write SetIsPasswordAutosaveEnabled;
      /// <summary>
      /// IsGeneralAutofillEnabled controls whether autofill for information
      /// like names, street and email addresses, phone numbers, and arbitrary input
      /// is enabled. This excludes password and credit card information. When
      /// IsGeneralAutofillEnabled is false, no suggestions appear, and no new information
      /// is saved. When IsGeneralAutofillEnabled is true, information is saved, suggestions
      /// appear and clicking on one will populate the form fields.
      /// It will take effect immediately after setting.
      /// The default value is `TRUE`.
      /// This property has the same value as
      /// `CoreWebView2Profile.IsGeneralAutofillEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsGeneralAutofillEnabled` and
      /// `CoreWebView2Profile.IsGeneralAutofillEnabled` will always have the same
      /// value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings4#get_isgeneralautofillenabled">See the ICoreWebView2Settings4 article.</see></para>
      /// </remarks>
      property    IsGeneralAutofillEnabled         : boolean                read GetIsGeneralAutofillEnabled          write SetIsGeneralAutofillEnabled;
      /// <summary>
      /// Pinch-zoom, referred to as "Page Scale" zoom, is performed as a post-rendering step,
      /// it changes the page scale factor property and scales the surface the web page is
      /// rendered onto when user performs a pinch zooming action. It does not change the layout
      /// but rather changes the viewport and clips the web content, the content outside of the
      /// viewport isn't visible onscreen and users can't reach this content using mouse.
      ///
      /// The `IsPinchZoomEnabled` property enables or disables the ability of
      /// the end user to use a pinching motion on touch input enabled devices
      /// to scale the web content in the WebView2. It defaults to `TRUE`.
      /// When set to `FALSE`, the end user cannot pinch zoom after the next navigation.
      /// Disabling/Enabling `IsPinchZoomEnabled` only affects the end user's ability to use
      /// pinch motions and does not change the page scale factor.
      /// This API only affects the Page Scale zoom and has no effect on the
      /// existing browser zoom properties (`IsZoomControlEnabled` and `ZoomFactor`)
      /// or other end user mechanisms for zooming.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings5#get_ispinchzoomenabled">See the ICoreWebView2Settings5 article.</see></para>
      /// </remarks>
      property    IsPinchZoomEnabled               : boolean                read GetIsPinchZoomEnabled                write SetIsPinchZoomEnabled;
      /// <summary>
      /// The `IsSwipeNavigationEnabled` property enables or disables the ability of the
      /// end user to use swiping gesture on touch input enabled devices to
      /// navigate in WebView2. It defaults to `TRUE`.
      ///
      /// When this property is `TRUE`, then all configured navigation gestures are enabled:
      /// 1. Swiping left and right to navigate forward and backward is always configured.
      /// 2. Swiping down to refresh is off by default and not exposed via our API currently,
      /// it requires the "--pull-to-refresh" option to be included in the additional browser
      /// arguments to be configured. (See put_AdditionalBrowserArguments.)
      ///
      /// When set to `FALSE`, the end user cannot swipe to navigate or pull to refresh.
      /// This API only affects the overscrolling navigation functionality and has no
      /// effect on the scrolling interaction used to explore the web content shown
      /// in WebView2.
      ///
      /// Disabling/Enabling IsSwipeNavigationEnabled takes effect after the
      /// next navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings6#get_isswipenavigationenabled">See the ICoreWebView2Settings6 article.</see></para>
      /// </remarks>
      property    IsSwipeNavigationEnabled         : boolean                read GetIsSwipeNavigationEnabled          write SetIsSwipeNavigationEnabled;
      /// <summary>
      /// `HiddenPdfToolbarItems` is used to customize the PDF toolbar items. By default, it is COREWEBVIEW2_PDF_TOOLBAR_ITEMS_NONE and so it displays all of the items.
      /// Changes to this property apply to all CoreWebView2s in the same environment and using the same profile.
      /// Changes to this setting apply only after the next navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings7#get_hiddenpdftoolbaritems">See the ICoreWebView2Settings7 article.</see></para>
      /// </remarks>
      property    HiddenPdfToolbarItems            : TWVPDFToolbarItems     read GetHiddenPdfToolbarItems             write SetHiddenPdfToolbarItems;
      /// <summary>
      /// SmartScreen helps webviews identify reported phishing and malware websites
      /// and also helps users make informed decisions about downloads.
      /// `IsReputationCheckingRequired` is used to control whether SmartScreen
      /// enabled or not. SmartScreen is enabled or disabled for all CoreWebView2s
      /// using the same user data folder. If
      /// CoreWebView2Setting.IsReputationCheckingRequired is true for any
      /// CoreWebView2 using the same user data folder, then SmartScreen is enabled.
      /// If CoreWebView2Setting.IsReputationCheckingRequired is false for all
      /// CoreWebView2 using the same user data folder, then SmartScreen is
      /// disabled. When it is changed, the change will be applied to all WebViews
      /// using the same user data folder on the next navigation or download. The
      /// default value for `IsReputationCheckingRequired` is true. If the newly
      /// created CoreWebview2 does not set SmartScreen to false, when
      /// navigating(Such as Navigate(), LoadDataUrl(), ExecuteScript(), etc.), the
      /// default value will be applied to all CoreWebview2 using the same user data
      /// folder.
      /// SmartScreen of WebView2 apps can be controlled by Windows system setting
      /// "SmartScreen for Microsoft Edge", specially, for WebView2 in Windows
      /// Store apps, SmartScreen is controlled by another Windows system setting
      /// "SmartScreen for Microsoft Store apps". When the Windows setting is enabled, the
      /// SmartScreen operates under the control of the `IsReputationCheckingRequired`.
      /// When the Windows setting is disabled, the SmartScreen will be disabled
      /// regardless of the `IsReputationCheckingRequired` value set in WebView2 apps.
      /// In other words, under this circumstance the value of
      /// `IsReputationCheckingRequired` will be saved but overridden by system setting.
      /// Upon re-enabling the Windows setting, the CoreWebview2 will reference the
      /// `IsReputationCheckingRequired` to determine the SmartScreen status.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings8#get_isreputationcheckingrequired">See the ICoreWebView2Settings8 article.</see></para>
      /// </remarks>
      property    IsReputationCheckingRequired     : boolean                read GetIsReputationCheckingRequired      write SetIsReputationCheckingRequired;
      /// <summary>
      /// The `IsNonClientRegionSupportEnabled` property enables web pages to use the
      /// `app-region` CSS style. Disabling/Enabling the `IsNonClientRegionSupportEnabled`
      /// takes effect after the next navigation. Defaults to `FALSE`.
      ///
      /// When this property is `TRUE`, then all the non-client region features
      /// will be enabled:
      /// Draggable Regions will be enabled, they are regions on a webpage that
      /// are marked with the CSS attribute `app-region: drag/no-drag`. When set to
      /// `drag`, these regions will be treated like the window's title bar, supporting
      /// dragging of the entire WebView and its host app window; the system menu shows
      /// upon right click, and a double click will trigger maximizing/restoration of the
      /// window size.
      ///
      /// When set to `FALSE`, all non-client region support will be disabled.
      /// The `app-region` CSS style will be ignored on web pages.
      /// \snippet SettingsComponent.cpp ToggleNonClientRegionSupportEnabled
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings9#get_isnonclientregionsupportenabled">See the ICoreWebView2Settings9 article.</see></para>
      /// </remarks>
      property    IsNonClientRegionSupportEnabled  : boolean                read GetIsNonClientRegionSupportEnabled   write SetIsNonClientRegionSupportEnabled;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVMiscFunctions;


constructor TCoreWebView2Settings.Create(const aBaseIntf : ICoreWebView2Settings);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings3, FBaseIntf3) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings4, FBaseIntf4) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings5, FBaseIntf5) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings6, FBaseIntf6) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings7, FBaseIntf7) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings8, FBaseIntf8) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings9, FBaseIntf9);
end;

destructor TCoreWebView2Settings.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2Settings.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
  FBaseIntf4 := nil;
  FBaseIntf5 := nil;
  FBaseIntf6 := nil;
  FBaseIntf7 := nil;
  FBaseIntf8 := nil;
  FBaseIntf9 := nil;
end;

function TCoreWebView2Settings.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Settings.GetIsBuiltInErrorPageEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsBuiltInErrorPageEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreDefaultContextMenusEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreDefaultContextMenusEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreDefaultScriptDialogsEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreDefaultScriptDialogsEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreDevToolsEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreDevToolsEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsScriptEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsScriptEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsStatusBarEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsStatusBarEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsWebMessageEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsWebMessageEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsZoomControlEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsZoomControlEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreHostObjectsAllowed : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreHostObjectsAllowed(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetUserAgent : wvstring;

var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_UserAgent(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Settings.GetAreBrowserAcceleratorKeysEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Get_AreBrowserAcceleratorKeysEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsPasswordAutosaveEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.Get_IsPasswordAutosaveEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsGeneralAutofillEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.Get_IsGeneralAutofillEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsPinchZoomEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf5) and
            succeeded(FBaseIntf5.Get_IsPinchZoomEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsSwipeNavigationEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.Get_IsSwipeNavigationEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetHiddenPdfToolbarItems : TWVPDFToolbarItems;
var
  TempResult : COREWEBVIEW2_PDF_TOOLBAR_ITEMS;
begin
  if assigned(FBaseIntf7) and
     succeeded(FBaseIntf7.Get_HiddenPdfToolbarItems(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2Settings.GetIsReputationCheckingRequired : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf8) and
            succeeded(FBaseIntf8.Get_IsReputationCheckingRequired(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsNonClientRegionSupportEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf9) and
            succeeded(FBaseIntf9.Get_IsNonClientRegionSupportEnabled(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2Settings.SetIsBuiltInErrorPageEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsBuiltInErrorPageEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreDefaultContextMenusEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreDefaultContextMenusEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreDefaultScriptDialogsEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreDefaultScriptDialogsEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreDevToolsEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreDevToolsEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsScriptEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsScriptEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsStatusBarEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsStatusBarEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsWebMessageEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsWebMessageEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsZoomControlEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsZoomControlEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreHostObjectsAllowed(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreHostObjectsAllowed(ord(aValue));
end;

procedure TCoreWebView2Settings.SetUserAgent(const aValue : wvstring);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_UserAgent(PWideChar(aValue));
end;

procedure TCoreWebView2Settings.SetAreBrowserAcceleratorKeysEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_AreBrowserAcceleratorKeysEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsPasswordAutosaveEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf4) then
    FBaseIntf4.Set_IsPasswordAutosaveEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsGeneralAutofillEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf4) then
    FBaseIntf4.Set_IsGeneralAutofillEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsPinchZoomEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf5) then
    FBaseIntf5.Set_IsPinchZoomEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsSwipeNavigationEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf6) then
    FBaseIntf6.Set_IsSwipeNavigationEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetHiddenPdfToolbarItems(aValue : TWVPDFToolbarItems);
begin
  if assigned(FBaseIntf7) then
    FBaseIntf7.Set_HiddenPdfToolbarItems(aValue);
end;

procedure TCoreWebView2Settings.SetIsReputationCheckingRequired(aValue : boolean);
begin
  if assigned(FBaseIntf8) then
    FBaseIntf8.Set_IsReputationCheckingRequired(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsNonClientRegionSupportEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf9) then
    FBaseIntf9.Set_IsNonClientRegionSupportEnabled(ord(aValue));
end;


end.
