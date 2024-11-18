unit uWVCoreWebView2Args;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Types, Winapi.ActiveX,
  {$ELSE}
  Types, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Event args for the AcceleratorKeyPressed event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2AcceleratorKeyPressedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2AcceleratorKeyPressedEventArgs;
      FBaseIntf2 : ICoreWebView2AcceleratorKeyPressedEventArgs2;

      function GetInitialized : boolean;
      function GetKeyEventKind : TWVKeyEventKind;
      function GetVirtualKey : LongWord;
      function GetKeyEventLParam : integer;
      function GetHandled : boolean;
      function GetRepeatCount : LongWord;
      function GetScanCode : LongWord;
      function GetIsExtendedKey : boolean;
      function GetIsMenuKeyDown : boolean;
      function GetWasKeyDown : boolean;
      function GetIsKeyReleased : boolean;
      function GetIsBrowserAcceleratorKeyEnabled : boolean;

      procedure SetHandled(aValue : boolean);
      procedure SetIsBrowserAcceleratorKeyEnabled(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                    : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                       : ICoreWebView2AcceleratorKeyPressedEventArgs  read FBaseIntf;
      /// <summary>
      /// The key event type that caused the event to run.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_keyeventkind">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// </remarks>
      property KeyEventKind                   : TWVKeyEventKind                              read GetKeyEventKind;
      /// <summary>
      /// The Win32 virtual key code of the key that was pressed or released.  It
      /// is one of the Win32 virtual key constants such as `VK_RETURN` or an
      /// (uppercase) ASCII value such as `A`.  Verify whether Ctrl or Alt
      /// are pressed by running `GetKeyState(VK_CONTROL)` or
      /// `GetKeyState(VK_MENU)`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_virtualkey">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// </remarks>
      property VirtualKey                     : LongWord                                     read GetVirtualKey;
      /// <summary>
      /// The `LPARAM` value that accompanied the window message.  For more
      /// information, navigate to [WM_KEYDOWN](/windows/win32/inputdev/wm-keydown)
      /// and [WM_KEYUP](/windows/win32/inputdev/wm-keyup).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_keyeventlparam">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// </remarks>
      property KeyEventLParam                 : integer                                      read GetKeyEventLParam;
      /// <summary>
      /// Specifies the repeat count for the current message.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_physicalkeystatus">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/winrt/microsoft_web_webview2_core/corewebview2physicalkeystatus">See the CoreWebView2PhysicalKeyStatus Struct article.</see></para>
      /// </remarks>
      property RepeatCount                    : LongWord                                     read GetRepeatCount;
      /// <summary>
      /// Specifies the scan code.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_physicalkeystatus">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/winrt/microsoft_web_webview2_core/corewebview2physicalkeystatus">See the CoreWebView2PhysicalKeyStatus Struct article.</see></para>
      /// </remarks>
      property ScanCode                       : LongWord                                     read GetScanCode;
      /// <summary>
      /// Indicates that the key is an extended key.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_physicalkeystatus">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/winrt/microsoft_web_webview2_core/corewebview2physicalkeystatus">See the CoreWebView2PhysicalKeyStatus Struct article.</see></para>
      /// </remarks>
      property IsExtendedKey                  : boolean                                      read GetIsExtendedKey;
      /// <summary>
      /// Indicates that a menu key is held down (context code).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_physicalkeystatus">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/winrt/microsoft_web_webview2_core/corewebview2physicalkeystatus">See the CoreWebView2PhysicalKeyStatus Struct article.</see></para>
      /// </remarks>
      property IsMenuKeyDown                  : boolean                                      read GetIsMenuKeyDown;
      /// <summary>
      /// Indicates that the key was held down.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_physicalkeystatus">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/winrt/microsoft_web_webview2_core/corewebview2physicalkeystatus">See the CoreWebView2PhysicalKeyStatus Struct article.</see></para>
      /// </remarks>
      property WasKeyDown                     : boolean                                      read GetWasKeyDown;
      /// <summary>
      /// Indicates that the key was released.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_physicalkeystatus">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/winrt/microsoft_web_webview2_core/corewebview2physicalkeystatus">See the CoreWebView2PhysicalKeyStatus Struct article.</see></para>
      /// </remarks>
      property IsKeyReleased                  : boolean                                      read GetIsKeyReleased;
      /// <summary>
      /// During `AcceleratorKeyPressedEvent` handler invocation the WebView is
      /// blocked waiting for the decision of if the accelerator is handled by the
      /// host (or not).  If the `Handled` property is set to `TRUE` then this
      /// prevents the WebView from performing the default action for this
      /// accelerator key.  Otherwise the WebView performs the default action for
      /// the accelerator key.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs#get_handled">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
      /// </remarks>
      property Handled                        : boolean                                      read GetHandled                          write SetHandled;
      /// <summary>
      /// <para>This property allows developers to enable or disable the browser from handling a specific
      /// browser accelerator key such as Ctrl+P or F3, etc.</para>
      /// <para>Browser accelerator keys are the keys/key combinations that access features specific to
      /// a web browser, including but not limited to:</para>
      /// <code>
      ///  - Ctrl-F and F3 for Find on Page
      ///  - Ctrl-P for Print
      ///  - Ctrl-R and F5 for Reload
      ///  - Ctrl-Plus and Ctrl-Minus for zooming
      ///  - Ctrl-Shift-C and F12 for DevTools
      ///  - Special keys for browser functions, such as Back, Forward, and Search
      /// </code>
      /// <para>This property does not disable accelerator keys related to movement and text editing,
      /// such as:</para>
      /// <code>
      ///  - Home, End, Page Up, and Page Down
      ///  - Ctrl-X, Ctrl-C, Ctrl-V
      ///  - Ctrl-A for Select All
      ///  - Ctrl-Z for Undo
      /// </code>
      /// <para>The `ICoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` API is a convenient setting
      /// for developers to disable all the browser accelerator keys together, and sets the default
      /// value for the `IsBrowserAcceleratorKeyEnabled` property.</para>
      /// <para>By default, `ICoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` is `TRUE` and
      /// `IsBrowserAcceleratorKeyEnabled` is `TRUE`.</para>
      /// <para>When developers change `ICoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` setting to `FALSE`,
      /// this will change default value for `IsBrowserAcceleratorKeyEnabled` to `FALSE`.</para>
      /// <para>If developers want specific keys to be handled by the browser after changing the
      /// `ICoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` setting to `FALSE`, they need to enable
      /// these keys by setting `IsBrowserAcceleratorKeyEnabled` to `TRUE`.</para>
      /// <para>This API will give the event arg higher priority over the
      /// `ICoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` setting when we handle the keys.</para>
      /// <para>For browser accelerator keys, when an accelerator key is pressed, the propagation and
      /// processing order is:</para>
      /// <code>
      /// 1. A ICoreWebView2Controller.AcceleratorKeyPressed event is raised
      /// 2. WebView2 browser feature accelerator key handling
      /// 3. Web Content Handling: If the key combination isn't reserved for browser actions,
      /// the key event propagates to the web content, where JavaScript event listeners can
      /// capture and respond to it.
      /// </code>
      /// <para>`ICoreWebView2AcceleratorKeyPressedEventArgs` has a `Handled` property, that developers
      /// can use to mark a key as handled. When the key is marked as handled anywhere along
      /// the path, the event propagation stops, and web content will not receive the key.
      /// With `IsBrowserAcceleratorKeyEnabled` property, if developers mark
      /// `IsBrowserAcceleratorKeyEnabled` as `FALSE`, the browser will skip the WebView2
      /// browser feature accelerator key handling process, but the event propagation
      /// continues, and web content will receive the key combination.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs2#get_isbrowseracceleratorkeyenabled">See the ICoreWebView2AcceleratorKeyPressedEventArgs2 article.</see></para>
      /// </remarks>
      property IsBrowserAcceleratorKeyEnabled : boolean                                      read GetIsBrowserAcceleratorKeyEnabled   write SetIsBrowserAcceleratorKeyEnabled;
  end;

  /// <summary>
  /// Receives ContentLoading events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contentloadingeventargs">See the ICoreWebView2ContentLoadingEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2ContentLoadingEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ContentLoadingEventArgs;

      function GetInitialized : boolean;
      function GetIsErrorPage : boolean;
      function GetNavigationId : uint64;

    public
      constructor Create(const aArgs: ICoreWebView2ContentLoadingEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized  : boolean                               read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf     : ICoreWebView2ContentLoadingEventArgs  read FBaseIntf;
      /// <summary>
      /// `TRUE` if the loaded content is an error page.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contentloadingeventargs#get_iserrorpage">See the ICoreWebView2ContentLoadingEventArgs article.</see></para>
      /// </remarks>
      property IsErrorPage  : boolean                               read GetIsErrorPage;
      /// <summary>
      /// The ID of the navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contentloadingeventargs#get_navigationid">See the ICoreWebView2ContentLoadingEventArgs article.</see></para>
      /// </remarks>
      property NavigationId : uint64                                read GetNavigationId;
  end;

  /// <summary>
  /// Event args for the DevToolsProtocolEventReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventargs">See the ICoreWebView2DevToolsProtocolEventReceivedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2DevToolsProtocolEventReceivedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2DevToolsProtocolEventReceivedEventArgs;
      FBaseIntf2 : ICoreWebView2DevToolsProtocolEventReceivedEventArgs2;

      function GetInitialized : boolean;
      function GetParameterObjectAsJson : wvstring;
      function GetSessionId : wvstring;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2DevToolsProtocolEventReceivedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                                              read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2DevToolsProtocolEventReceivedEventArgs  read FBaseIntf;
      /// <summary>
      /// The parameter object of the corresponding `DevToolsProtocol` event
      /// represented as a JSON string.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventargs#get_parameterobjectasjson">See the ICoreWebView2DevToolsProtocolEventReceivedEventArgs article.</see></para>
      /// </remarks>
      property ParameterObjectAsJson : wvstring                                             read GetParameterObjectAsJson;
      /// <summary>
      /// The sessionId of the target where the event originates from.
      /// Empty string is returned as sessionId if the event comes from the default
      /// session for the top page.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventargs2#get_sessionid">See the ICoreWebView2DevToolsProtocolEventReceivedEventArgs2 article.</see></para>
      /// </remarks>
      property SessionId             : wvstring                                             read GetSessionId;
  end;

  /// <summary>
  /// Event args for the MoveFocusRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2movefocusrequestedeventargs">See the ICoreWebView2MoveFocusRequestedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2MoveFocusRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2MoveFocusRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetReason : TWVMoveFocusReason;
      function  GetHandled : boolean;

      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2MoveFocusRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                   read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2MoveFocusRequestedEventArgs  read FBaseIntf;
      /// <summary>
      /// The reason for WebView to run the `MoveFocusRequested` event.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2movefocusrequestedeventargs#get_reason">See the ICoreWebView2MoveFocusRequestedEventArgs article.</see></para>
      /// </remarks>
      property Reason      : TWVMoveFocusReason                        read GetReason;
      /// <summary>
      /// Indicates whether the event has been handled by the app.  If the app has
      /// moved the focus to another desired location, it should set the `Handled`
      /// property to `TRUE`.  When the `Handled` property is `FALSE` after the
      /// event handler returns, default action is taken.  The default action is to
      /// try to find the next tab stop child window in the app and try to move
      /// focus to that window.  If no other window exists to move focus, focus is
      /// cycled within the web content of the WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2movefocusrequestedeventargs#get_handled">See the ICoreWebView2MoveFocusRequestedEventArgs article.</see></para>
      /// </remarks>
      property Handled     : boolean                                   read GetHandled      write SetHandled;
  end;

  /// <summary>
  /// Event args for the NavigationCompleted event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventargs">See the ICoreWebView2NavigationCompletedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2NavigationCompletedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2NavigationCompletedEventArgs;
      FBaseIntf2 : ICoreWebView2NavigationCompletedEventArgs2;

      function GetInitialized : boolean;
      function GetIsSuccess : boolean;
      function GetWebErrorStatus : TWVWebErrorStatus;
      function GetNavigationID : uint64;
      function GetHttpStatusCode : integer;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2NavigationCompletedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized    : boolean                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf       : ICoreWebView2NavigationCompletedEventArgs  read FBaseIntf;
      /// <summary>
      /// <para>`TRUE` when the navigation is successful.  `FALSE` for a navigation that
      /// ended up in an error page (failures due to no network, DNS lookup
      /// failure, HTTP server responds with 4xx), but may also be `FALSE` for
      /// additional scenarios such as `window.stop()` run on navigated page.</para>
      /// <para>Note that WebView2 will report the navigation as 'unsuccessful' if the load
      /// for the navigation did not reach the expected completion for any reason. Such
      /// reasons include potentially catastrophic issues such network and certificate
      /// issues, but can also be the result of intended actions such as the app canceling a navigation or
      /// navigating away before the original navigation completed. Applications should not
      /// just rely on this flag, but also consider the reported WebErrorStatus to
      /// determine whether the failure is indeed catastrophic in their context.<para>
      /// <para>WebErrorStatuses that may indicate a non-catastrophic failure include:</para>
      /// <para> - COREWEBVIEW2_WEB_ERROR_STATUS_OPERATION_CANCELED</para>
      /// <para> - COREWEBVIEW2_WEB_ERROR_STATUS_VALID_AUTHENTICATION_CREDENTIALS_REQUIRED</para>
      /// <para> - COREWEBVIEW2_WEB_ERROR_STATUS_VALID_PROXY_AUTHENTICATION_REQUIRED</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventargs#get_issuccess">See the ICoreWebView2NavigationCompletedEventArgs article.</see></para>
      /// </remarks>
      property IsSuccess      : boolean                                    read GetIsSuccess;
      /// <summary>
      /// The error code if the navigation failed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventargs#get_weberrorstatus">See the ICoreWebView2NavigationCompletedEventArgs article.</see></para>
      /// </remarks>
      property WebErrorStatus : TWVWebErrorStatus                          read GetWebErrorStatus;
      /// <summary>
      /// The ID of the navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventargs#get_navigationid">See the ICoreWebView2NavigationCompletedEventArgs article.</see></para>
      /// </remarks>
      property NavigationID   : uint64                                     read GetNavigationID;
      /// <summary>
      /// <para>The HTTP status code of the navigation if it involved an HTTP request.
      /// For instance, this will usually be 200 if the request was successful, 404
      /// if a page was not found, etc.  See
      /// https://developer.mozilla.org/docs/Web/HTTP/Status for a list of
      /// common status codes.</para>
      /// <para>The `HttpStatusCode` property will be 0 in the following cases:</para>
      /// <para>* The navigation did not involve an HTTP request.  For instance, if it was
      ///   a navigation to a file:// URL, or if it was a same-document navigation.</para>
      /// <para>* The navigation failed before a response was received.  For instance, if
      ///   the hostname was not found, or if there was a network error.</para>
      /// <para>In those cases, you can get more information from the `IsSuccess` and
      /// `WebErrorStatus` properties.</para>
      /// <para>If the navigation receives a successful HTTP response, but the navigated
      /// page calls `window.stop()` before it finishes loading, then
      /// `HttpStatusCode` may contain a success code like 200, but `IsSuccess` will
      /// be FALSE and `WebErrorStatus` will be
      /// `COREWEBVIEW2_WEB_ERROR_STATUS_CONNECTION_ABORTED`.</para>
      /// <para>Since WebView2 handles HTTP continuations and redirects automatically, it
      /// is unlikely for `HttpStatusCode` to ever be in the 1xx or 3xx ranges.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventargs2#get_httpstatuscode">See the ICoreWebView2NavigationCompletedEventArgs2 article.</see></para>
      /// </remarks>
      property HttpStatusCode : integer                                    read GetHttpStatusCode;
  end;

  /// <summary>
  /// Event args for the NavigationStarting event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2NavigationStartingEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2NavigationStartingEventArgs;
      FBaseIntf2 : ICoreWebView2NavigationStartingEventArgs2;
      FBaseIntf3 : ICoreWebView2NavigationStartingEventArgs3;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetIsUserInitiated : boolean;
      function  GetIsRedirected : boolean;
      function  GetCancel : boolean;
      function  GetNavigationID : uint64;
      function  GetRequestHeaders : ICoreWebView2HttpRequestHeaders;
      function  GetAdditionalAllowedFrameAncestors : wvstring;
      function  GetNavigationKind : TWVNavigationKind;

      procedure SetAdditionalAllowedFrameAncestors(const aValue : wvstring);
      procedure SetCancel(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2NavigationStartingEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                       : boolean                                   read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                          : ICoreWebView2NavigationStartingEventArgs  read FBaseIntf;
      /// <summary>
      /// The uri of the requested navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs#get_uri">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
      /// </remarks>
      property URI                               : wvstring                                  read GetURI;
      /// <summary>
      /// `TRUE` when the navigation was initiated through a user gesture as
      /// opposed to programmatic navigation by page script. Navigations initiated
      /// via WebView2 APIs are considered as user initiated.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs#get_isuserinitiated">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
      /// </remarks>
      property IsUserInitiated                   : boolean                                   read GetIsUserInitiated;
      /// <summary>
      /// `TRUE` when the navigation is redirected.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs#get_isredirected">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
      /// </remarks>
      property IsRedirected                      : boolean                                   read GetIsRedirected;
      /// <summary>
      /// The host may set this flag to cancel the navigation.  If set, the
      /// navigation is not longer present and the content of the current page is
      /// intact.  For performance reasons, `GET` HTTP requests may happen, while
      /// the host is responding.  You may set cookies and use part of a request
      /// for the navigation.  Navigations to about schemes are cancellable, unless
      /// `msWebView2CancellableAboutNavigations` feature flag is disabled.
      /// Cancellation of frame navigation to `srcdoc` is not supported and
      /// wil be ignored.  A cancelled navigation will fire a `NavigationCompleted`
      /// event with a `WebErrorStatus` of
      /// `COREWEBVIEW2_WEB_ERROR_STATUS_OPERATION_CANCELED`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs#get_cancel">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
      /// </remarks>
      property Cancel                            : boolean                                   read GetCancel                              write SetCancel;
      /// <summary>
      /// The ID of the navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs#get_navigationid">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
      /// </remarks>
      property NavigationID                      : uint64                                    read GetNavigationID;
      /// <summary>
      /// <para>The HTTP request headers for the navigation.</para>
      /// <para>\>NOTE: You are not able to modify the HTTP request headers in a
      /// `NavigationStarting` event.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs#get_requestheaders">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
      /// </remarks>
      property RequestHeaders                    : ICoreWebView2HttpRequestHeaders           read GetRequestHeaders;
      /// <summary>
      /// Get additional allowed frame ancestors set by the host app.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs2#get_additionalallowedframeancestors">See the ICoreWebView2NavigationStartingEventArgs3 article.</see></para>
      /// </remarks>
      property AdditionalAllowedFrameAncestors   : wvstring                                  read GetAdditionalAllowedFrameAncestors     write SetAdditionalAllowedFrameAncestors;
      /// <summary>
      /// Get the navigation kind of this navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs3#get_navigationkind">See the ICoreWebView2NavigationStartingEventArgs3 article.</see></para>
      /// </remarks>
      property NavigationKind                    : TWVNavigationKind                         read GetNavigationKind;
  end;

  /// <summary>
  /// Event args for the NewWindowRequested event.  The event is run when
  /// content inside webview requested to a open a new window (through
  /// window.open() and so on).
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2NewWindowRequestedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2NewWindowRequestedEventArgs;
      FBaseIntf2 : ICoreWebView2NewWindowRequestedEventArgs2;
      FBaseIntf3 : ICoreWebView2NewWindowRequestedEventArgs3;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetNewWindow : ICoreWebView2;
      function  GetHandled : boolean;
      function  GetIsUserInitiated : boolean;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetWindowFeatures : ICoreWebView2WindowFeatures;
      function  GetName : wvstring;
      function  GetOriginalSourceFrameInfo : ICoreWebView2FrameInfo;

      procedure SetNewWindow(const aValue : ICoreWebView2);
      procedure SetHandled(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2NewWindowRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized             : boolean                                   read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                : ICoreWebView2NewWindowRequestedEventArgs  read FBaseIntf;
      /// <summary>
      /// The target uri of the new window requested.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs#get_uri">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
      /// </remarks>
      property URI                     : wvstring                                  read GetURI;
      /// <summary>
      /// Gets the new window.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs#get_newwindow">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
      /// </remarks>
      property NewWindow               : ICoreWebView2                             read GetNewWindow         write SetNewWindow;
      /// <summary>
      /// Gets whether the `NewWindowRequested` event is handled by host.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs#get_handled">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
      /// </remarks>
      property Handled                 : boolean                                   read GetHandled           write SetHandled;
      /// <summary>
      /// <para>`TRUE` when the new window request was initiated through a user gesture.
      /// Examples of user initiated requests are:</para>
      /// <para>- Selecting an anchor tag with target</para>
      /// <para>- Programmatic window open from a script that directly run as a result of
      /// user interaction such as via onclick handlers.</para>
      /// <para>Non-user initiated requests are programmatic window opens from a script
      /// that are not directly triggered by user interaction, such as those that
      /// run while loading a new page or via timers.</para>
      /// <para>The Microsoft Edge popup blocker is disabled for WebView so the app is
      /// able to use this flag to block non-user initiated popups.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs#get_isuserinitiated">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
      /// </remarks>
      property IsUserInitiated         : boolean                                   read GetIsUserInitiated;
      /// <summary>
      /// Obtain an `ICoreWebView2Deferral` object and put the event into a
      /// deferred state.  Use the `ICoreWebView2Deferral` object to complete the
      /// window open request at a later time.  While this event is deferred the
      /// opener window returns a `WindowProxy` to an un-navigated window, which
      /// navigates when the deferral is complete.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs#getdeferral">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
      /// </remarks>
      property Deferral                : ICoreWebView2Deferral                     read GetDeferral;
      /// <summary>
      /// Window features specified by the `window.open`.  The features should be
      /// considered for positioning and sizing of new webview windows.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs#get_windowfeatures">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
      /// </remarks>
      property WindowFeatures          : ICoreWebView2WindowFeatures               read GetWindowFeatures;
      /// <summary>
      /// <para>Gets the name of the new window. This window can be created via `window.open(url, windowName)`,
      /// where the windowName parameter corresponds to `Name` property.</para>
      /// <para>If no windowName is passed to `window.open`, then the `Name` property
      /// will be set to an empty string. Additionally, if window is opened through other means,
      /// such as `<a target="windowName">...</a>` or `<iframe name="windowName">...</iframe>`,
      /// then the `Name` property will be set accordingly. In the case of target=_blank,
      /// the `Name` property will be an empty string.</para>
      /// <para>Opening a window via ctrl+clicking a link would result in the `Name` property
      /// being set to an empty string.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs2#get_name">See the ICoreWebView2NewWindowRequestedEventArgs2 article.</see></para>
      /// </remarks>
      property Name                    : wvstring                                  read GetName;
      /// <summary>
      /// The frame info of the frame where the new window request originated. The
      /// `OriginalSourceFrameInfo` is a snapshot of frame information at the time when the
      /// new window was requested. See `ICoreWebView2FrameInfo` for details on frame
      /// properties.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs3#get_originalsourceframeinfo">See the ICoreWebView2NewWindowRequestedEventArgs3 article.</see></para>
      /// </remarks>
      property OriginalSourceFrameInfo : ICoreWebView2FrameInfo                    read GetOriginalSourceFrameInfo;
  end;

  /// <summary>
  /// Event args for the PermissionRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs">See the ICoreWebView2PermissionRequestedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2PermissionRequestedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2PermissionRequestedEventArgs;
      FBaseIntf2 : ICoreWebView2PermissionRequestedEventArgs2;
      FBaseIntf3 : ICoreWebView2PermissionRequestedEventArgs3;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetPermissionKind : TWVPermissionKind;
      function  GetIsUserInitiated : boolean;
      function  GetState : TWVPermissionState;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetHandled : boolean;
      function  GetSavesInProfile : boolean;

      procedure SetState(aValue : TWVPermissionState);
      procedure SetHandled(aValue : boolean);
      procedure SetSavesInProfile(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs); reintroduce; overload;
      constructor Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs2); reintroduce; overload;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized      : boolean                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf         : ICoreWebView2PermissionRequestedEventArgs  read FBaseIntf;
      /// <summary>
      /// The origin of the web content that requests the permission.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs#get_uri">See the ICoreWebView2PermissionRequestedEventArgs article.</see></para>
      /// </remarks>
      property URI              : wvstring                                   read GetURI;
      /// <summary>
      /// The status of a permission request, (for example is the request is granted).
      /// The default value is `COREWEBVIEW2_PERMISSION_STATE_DEFAULT`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs#get_state">See the ICoreWebView2PermissionRequestedEventArgs article.</see></para>
      /// </remarks>
      property State            : TWVPermissionState                         read GetState             write SetState;
      /// <summary>
      /// The type of the permission that is requested.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs#get_permissionkind">See the ICoreWebView2PermissionRequestedEventArgs article.</see></para>
      /// </remarks>
      property PermissionKind   : TWVPermissionKind                          read GetPermissionKind;
      /// <summary>
      /// <para>`TRUE` when the permission request was initiated through a user gesture.</para>
      /// <para>NOTE: Being initiated through a user gesture does not mean that user intended
      /// to access the associated resource.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs#get_isuserinitiated">See the ICoreWebView2PermissionRequestedEventArgs article.</see></para>
      /// </remarks>
      property IsUserInitiated  : boolean                                    read GetIsUserInitiated;
      /// <summary>
      /// Gets an `ICoreWebView2Deferral` object.  Use the deferral object to make
      /// the permission decision at a later time. The deferral only applies to the
      /// current request, and does not prevent the `OnPermissionRequested` event from
      /// getting raised for new requests. However, for some permission kinds the
      /// WebView will avoid creating a new request if there is a pending request of
      /// the same kind.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs#getdeferral">See the ICoreWebView2PermissionRequestedEventArgs article.</see></para>
      /// </remarks>
      property Deferral         : ICoreWebView2Deferral                      read GetDeferral;
      /// <summary>
      /// <para>By default, both the `OnPermissionRequested` event handlers on the
      /// `CoreWebView2Frame` and the `CoreWebView2` will be invoked, with the
      /// `CoreWebView2Frame` event handlers invoked first. The host may
      /// set this flag to `TRUE` within the `CoreWebView2Frame` event handlers
      /// to prevent the remaining `CoreWebView2` event handlers from being invoked.</para>
      /// <para>If a deferral is taken on the event args, then you must synchronously
      /// set `Handled` to TRUE prior to taking your deferral to prevent the
      /// `CoreWebView2`s event handlers from being invoked.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs2#get_handled">See the ICoreWebView2PermissionRequestedEventArgs2 article.</see></para>
      /// </remarks>
      property Handled          : boolean                                    read GetHandled           write SetHandled;
      /// <summary>
      /// The permission state set from the `PermissionRequested` event is saved in
      /// the profile by default; it persists across sessions and becomes the new
      /// default behavior for future `PermissionRequested` events. Browser
      /// heuristics can affect whether the event continues to be raised when the
      /// state is saved in the profile. Set the `SavesInProfile` property to
      /// `FALSE` to not persist the state beyond the current request, and to
      /// continue to receive `PermissionRequested`
      /// events for this origin and permission kind.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs3#get_savesinprofile">See the ICoreWebView2PermissionRequestedEventArgs3 article.</see></para>
      /// </remarks>
      property SavesInProfile   : boolean                                    read GetSavesInProfile    write SetSavesInProfile;
  end;

  /// <summary>
  /// Event args for the ProcessFailed event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs">See the ICoreWebView2ProcessFailedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2ProcessFailedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2ProcessFailedEventArgs;
      FBaseIntf2 : ICoreWebView2ProcessFailedEventArgs2;
      FBaseIntf3 : ICoreWebView2ProcessFailedEventArgs3;

      function GetInitialized : boolean;
      function GetProcessFailedKind : TWVProcessFailedKind;
      function GetReason : TWVProcessFailedReason;
      function GetExtiCode : integer;
      function GetProcessDescription : wvstring;
      function GetFrameInfosForFailedProcess : ICoreWebView2FrameInfoCollection;
      function GetFailureSourceModulePath : wvstring;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2ProcessFailedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                : boolean                              read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                   : ICoreWebView2ProcessFailedEventArgs  read FBaseIntf;
      /// <summary>
      /// The kind of process failure that has occurred. This is a combination of
      /// process kind (for example, browser, renderer, gpu) and failure (exit,
      /// unresponsiveness). Renderer processes are further divided in _main frame_
      /// renderer (`RenderProcessExited`, `RenderProcessUnresponsive`) and
      /// _subframe_ renderer (`FrameRenderProcessExited`). To learn about the
      /// conditions under which each failure kind occurs, see
      /// `COREWEBVIEW2_PROCESS_FAILED_KIND`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs#get_processfailedkind">See the ICoreWebView2ProcessFailedEventArgs article.</see></para>
      /// </remarks>
      property ProcessFailedKind          : TWVProcessFailedKind                 read GetProcessFailedKind;
      /// <summary>
      /// <para>The reason for the process failure. Some of the reasons are only
      /// applicable to specific values of
      /// `ICoreWebView2ProcessFailedEventArgs.ProcessFailedKind`, and the
      /// following `ProcessFailedKind` values always return the indicated reason
      /// value:</para>
      /// <code>
      /// ProcessFailedKind | Reason
      /// ---|---
      /// COREWEBVIEW2_PROCESS_FAILED_KIND_BROWSER_PROCESS_EXITED | COREWEBVIEW2_PROCESS_FAILED_REASON_UNEXPECTED
      /// COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_UNRESPONSIVE | COREWEBVIEW2_PROCESS_FAILED_REASON_UNRESPONSIVE
      /// </code>
      /// <para>For other `ProcessFailedKind` values, the reason may be any of the reason
      /// values. To learn about what these values mean, see
      /// `COREWEBVIEW2_PROCESS_FAILED_REASON`.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs2#get_reason">See the ICoreWebView2ProcessFailedEventArgs2 article.</see></para>
      /// </remarks>
      property Reason                     : TWVProcessFailedReason               read GetReason;
      /// <summary>
      /// The exit code of the failing process, for telemetry purposes. The exit
      /// code is always `STILL_ACTIVE` (`259`) when `ProcessFailedKind` is
      /// `COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_UNRESPONSIVE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs2#get_exitcode">See the ICoreWebView2ProcessFailedEventArgs2 article.</see></para>
      /// </remarks>
      property ExtiCode                   : integer                              read GetExtiCode;
      /// <summary>
      /// Description of the process assigned by the WebView2 Runtime. This is a
      /// technical English term appropriate for logging or development purposes,
      /// and not localized for the end user. It applies to utility processes (for
      /// example, "Audio Service", "Video Capture") and plugin processes (for
      /// example, "Flash"). The returned `processDescription` is empty if the
      /// WebView2 Runtime did not assign a description to the process.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs2#get_processdescription">See the ICoreWebView2ProcessFailedEventArgs2 article.</see></para>
      /// </remarks>
      property ProcessDescription         : wvstring                             read GetProcessDescription;
      /// <summary>
      /// <para>The collection of `FrameInfo`s for frames in the `ICoreWebView2` that were
      /// being rendered by the failed process. The content in these frames is
      /// replaced with an error page.</para>
      /// <para>This is only available when `ProcessFailedKind` is
      /// `COREWEBVIEW2_PROCESS_FAILED_KIND_FRAME_RENDER_PROCESS_EXITED`;
      /// `frames` is `null` for all other process failure kinds, including the case
      /// in which the failed process was the renderer for the main frame and
      /// subframes within it, for which the failure kind is
      /// `COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_EXITED`.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs2#get_frameinfosforfailedprocess">See the ICoreWebView2ProcessFailedEventArgs2 article.</see></para>
      /// </remarks>
      property FrameInfosForFailedProcess : ICoreWebView2FrameInfoCollection     read GetFrameInfosForFailedProcess;
      /// <summary>
      /// <para>This property is the full path of the module that caused the
      /// crash in cases of Windows Code Integrity failures.</para>
      /// <para>[Windows Code Integrity](/mem/intune/user-help/you-need-to-enable-code-integrity)
      /// is a feature that verifies the integrity and
      /// authenticity of dynamic-link libraries (DLLs)
      /// on Windows systems. It ensures that only trusted
      /// code can run on the system and prevents unauthorized or
      /// malicious modifications.</para>
      /// <para>When ProcessFailed occurred due to a failed Code Integrity check,
      /// this property returns the full path of the file that was prevented from
      /// loading on the system.</para>
      /// <para>The webview2 process which tried to load the DLL will fail with
      /// exit code STATUS_INVALID_IMAGE_HASH(-1073740760).</para>
      /// <para>A file can fail integrity check for various
      /// reasons, such as:</para>
      /// <code>
      /// - It has an invalid or missing signature that does
      /// not match the publisher or signer of the file.
      /// - It has been tampered with or corrupted by malware or other software.
      /// - It has been blocked by an administrator or a security policy.
      /// </code>
      /// <para>This property always will be the empty string if failure is not caused by
      /// STATUS_INVALID_IMAGE_HASH.</para>
      /// </summary>
      property FailureSourceModulePath    : wvstring                             read GetFailureSourceModulePath;
  end;

  /// <summary>
  /// Event args for the ScriptDialogOpening event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2ScriptDialogOpeningEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ScriptDialogOpeningEventArgs;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetKind : TWVScriptDialogKind;
      function  GetMessage : wvstring;
      function  GetDefaultText : wvstring;
      function  GetResultText : wvstring;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetResultText(const aValue : wvstring);

    public
      constructor Create(const aArgs: ICoreWebView2ScriptDialogOpeningEventArgs); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// The host may run this to respond with **OK** to `confirm`, `prompt`, and
      /// `beforeunload` dialogs.  Do not run this method to indicate cancel.
      /// From JavaScript, this means that the `confirm` and `beforeunload` function
      /// returns `TRUE` if `Accept` is run.  And for the prompt function it returns
      /// the value of `ResultText` if `Accept` is run and otherwise returns
      /// `FALSE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs#accept">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
      /// </remarks>
      function    Accept : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2ScriptDialogOpeningEventArgs  read FBaseIntf;
      /// <summary>
      /// The URI of the page that requested the dialog box.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs#get_uri">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
      /// </remarks>
      property URI         : wvstring                                   read GetURI;
      /// <summary>
      /// The kind of JavaScript dialog box.  `alert`, `confirm`, `prompt`, or
      /// `beforeunload`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs#get_kind">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
      /// </remarks>
      property Kind        : TWVScriptDialogKind                        read GetKind;
      /// <summary>
      /// The message of the dialog box.  From JavaScript this is the first
      /// parameter passed to `alert`, `confirm`, and `prompt` and is empty for
      /// `beforeunload`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs#get_message">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
      /// </remarks>
      property Message_    : wvstring                                   read GetMessage;
      /// <summary>
      /// The second parameter passed to the JavaScript prompt dialog.
      /// The result of the prompt JavaScript function uses this value as the
      /// default value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs#get_defaulttext">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
      /// </remarks>
      property DefaultText : wvstring                                   read GetDefaultText;
      /// <summary>
      /// The return value from the JavaScript prompt function if `Accept` is run.
      ///  This value is ignored for dialog kinds other than prompt.  If `Accept`
      /// is not run, this value is ignored and `FALSE` is returned from prompt.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs#get_resulttext">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
      /// </remarks>
      property ResultText  : wvstring                                   read GetResultText     write SetResultText;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object.  Use this operation to
      /// complete the event at a later time.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs#getdeferral">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
      /// </remarks>
      property Deferral    : ICoreWebView2Deferral                      read GetDeferral;
  end;

  /// <summary>
  /// Event args for the SourceChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sourcechangedeventargs">See the ICoreWebView2SourceChangedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2SourceChangedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2SourceChangedEventArgs;

      function GetInitialized : boolean;
      function GetIsNewDocument : boolean;

    public
      constructor Create(const aArgs: ICoreWebView2SourceChangedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized   : boolean                              read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf      : ICoreWebView2SourceChangedEventArgs  read FBaseIntf;
      /// <summary>
      /// `TRUE` if the page being navigated to is a new document.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sourcechangedeventargs#get_isnewdocument">See the ICoreWebView2SourceChangedEventArgs article.</see></para>
      /// </remarks>
      property IsNewDocument : boolean                              read GetIsNewDocument;
  end;

  /// <summary>
  /// Event args for the WebMessageReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventargs">See the ICoreWebView2WebMessageReceivedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2WebMessageReceivedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2WebMessageReceivedEventArgs;
      FBaseIntf2 : ICoreWebView2WebMessageReceivedEventArgs2;

      function GetInitialized : boolean;
      function GetSource : wvstring;
      function GetWebMessageAsJson : wvstring;
      function GetWebMessageAsString : wvstring;
      function GetAdditionalObjects : ICoreWebView2ObjectCollectionView;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2WebMessageReceivedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized        : boolean                                   read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf           : ICoreWebView2WebMessageReceivedEventArgs  read FBaseIntf;
      /// <summary>
      /// The URI of the document that sent this web message.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventargs#get_source">See the ICoreWebView2WebMessageReceivedEventArgs article.</see></para>
      /// </remarks>
      property Source             : wvstring                                  read GetSource;
      /// <summary>
      /// The message posted from the WebView content to the host converted to a
      /// JSON string.  Run this operation to communicate using JavaScript objects.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventargs#get_webmessageasjson">See the ICoreWebView2WebMessageReceivedEventArgs article.</see></para>
      /// </remarks>
      property WebMessageAsJson   : wvstring                                  read GetWebMessageAsJson;
      /// <summary>
      /// If the message posted from the WebView content to the host is a string
      /// type, this method returns the value of that string.  If the message
      /// posted is some other kind of JavaScript type this method fails with the
      /// following error.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventargs#trygetwebmessageasstring">See the ICoreWebView2WebMessageReceivedEventArgs article.</see></para>
      /// </remarks>
      property WebMessageAsString : wvstring                                  read GetWebMessageAsString;
      /// <summary>
      /// Additional received WebMessage objects. To pass `additionalObjects` via
      /// WebMessage to the app, use the
      /// `chrome.webview.postMessageWithAdditionalObjects` content API.
      /// Any DOM object type that can be natively representable that has been
      /// passed in to `additionalObjects` parameter will be accessible here.
      /// Currently a WebMessage object can be the `ICoreWebView2File` type.
      /// Entries in the collection can be `nullptr` if `null` or `undefined` was
      /// passed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventargs2#get_additionalobjects">See the ICoreWebView2WebMessageReceivedEventArgs2 article.</see></para>
      /// </remarks>
      property AdditionalObjects  : ICoreWebView2ObjectCollectionView         read GetAdditionalObjects;
  end;

  /// <summary>
  /// Event args for the WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs">See the ICoreWebView2WebResourceRequestedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceRequestedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2WebResourceRequestedEventArgs;
      FBaseIntf2 : ICoreWebView2WebResourceRequestedEventArgs2;

      function  GetInitialized : boolean;
      function  GetRequest : ICoreWebView2WebResourceRequest;
      function  GetResponse : ICoreWebView2WebResourceResponse;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetResourceContext : TWVWebResourceContext;
      function  GetRequestedSourceKind : TWVWebResourceRequestSourceKind;

      procedure SetResponse(const aValue : ICoreWebView2WebResourceResponse);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2WebResourceRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized         : boolean                                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf            : ICoreWebView2WebResourceRequestedEventArgs  read FBaseIntf;
      /// <summary>
      /// The Web resource request.  The request object may be missing some headers
      /// that are added by network stack at a later time.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs#get_request">See the ICoreWebView2WebResourceRequestedEventArgs article.</see></para>
      /// </remarks>
      property Request             : ICoreWebView2WebResourceRequest             read GetRequest;
      /// <summary>
      /// A placeholder for the web resource response object.  If this object is
      /// set, the web resource request is completed with the specified response.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs#get_response">See the ICoreWebView2WebResourceRequestedEventArgs article.</see></para>
      /// </remarks>
      property Response            : ICoreWebView2WebResourceResponse            read GetResponse         write SetResponse;
      /// <summary>
      /// Obtain an `ICoreWebView2Deferral` object and put the event into a
      /// deferred state.  Use the `ICoreWebView2Deferral` object to complete the
      /// request at a later time.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs#getdeferral">See the ICoreWebView2WebResourceRequestedEventArgs article.</see></para>
      /// </remarks>
      property Deferral            : ICoreWebView2Deferral                       read GetDeferral;
      /// <summary>
      /// The web resource request context.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs#get_resourcecontext">See the ICoreWebView2WebResourceRequestedEventArgs article.</see></para>
      /// </remarks>
      property ResourceContext     : TWVWebResourceContext                       read GetResourceContext;
      /// <summary>
      /// The web resource requested source.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs2#get_requestedsourcekind">See the ICoreWebView2WebResourceRequestedEventArgs2 article.</see></para>
      /// </remarks>
      property RequestedSourceKind : TWVWebResourceRequestSourceKind             read GetRequestedSourceKind;
  end;

  /// <summary>
  /// Event args for the BrowserProcessExited event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserprocessexitedeventargs">See the ICoreWebView2BrowserProcessExitedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2BrowserProcessExitedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2BrowserProcessExitedEventArgs;

      function  GetInitialized : boolean;
      function  GetBrowserProcessExitKind : TWVBrowserProcessExitKind;
      function  GetBrowserProcessId : cardinal;

    public
      constructor Create(const aArgs: ICoreWebView2BrowserProcessExitedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized            : boolean                                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf               : ICoreWebView2BrowserProcessExitedEventArgs  read FBaseIntf;
      /// <summary>
      /// The kind of browser process exit that has occurred.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserprocessexitedeventargs#get_browserprocessexitkind">See the ICoreWebView2BrowserProcessExitedEventArgs article.</see></para>
      /// </remarks>
      property BrowserProcessExitKind : TWVBrowserProcessExitKind                   read GetBrowserProcessExitKind;
      /// <summary>
      /// The process ID of the browser process that has exited.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserprocessexitedeventargs#get_browserprocessid">See the ICoreWebView2BrowserProcessExitedEventArgs article.</see></para>
      /// </remarks>
      property BrowserProcessId       : cardinal                                    read GetBrowserProcessId;
  end;

  /// <summary>
  /// Event args for the WebResourceResponseReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponsereceivedeventargs">See the ICoreWebView2WebResourceResponseReceivedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceResponseReceivedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2WebResourceResponseReceivedEventArgs;

      function  GetInitialized : boolean;
      function  GetRequest : ICoreWebView2WebResourceRequest;
      function  GetResponse : ICoreWebView2WebResourceResponseView;

    public
      constructor Create(const aArgs: ICoreWebView2WebResourceResponseReceivedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                            read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2WebResourceResponseReceivedEventArgs  read FBaseIntf;
      /// <summary>
      /// The request object for the web resource, as committed. This includes
      /// headers added by the network stack that were not be included during the
      /// associated WebResourceRequested event, such as Authentication headers.
      /// Modifications to this object have no effect on how the request is
      /// processed as it has already been sent.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponsereceivedeventargs#get_request">See the ICoreWebView2WebResourceResponseReceivedEventArgs article.</see></para>
      /// </remarks>
      property Request     : ICoreWebView2WebResourceRequest                    read GetRequest;
      /// <summary>
      /// View of the response object received for the web resource.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponsereceivedeventargs#get_response">See the ICoreWebView2WebResourceResponseReceivedEventArgs article.</see></para>
      /// </remarks>
      property Response    : ICoreWebView2WebResourceResponseView               read GetResponse;
  end;

  /// <summary>
  /// Event args for the DOMContentLoaded event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2domcontentloadedeventargs">See the ICoreWebView2DOMContentLoadedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2DOMContentLoadedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2DOMContentLoadedEventArgs;

      function  GetInitialized : boolean;
      function  GetNavigationId : uint64;

    public
      constructor Create(const aArgs: ICoreWebView2DOMContentLoadedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized  : boolean                                 read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf     : ICoreWebView2DOMContentLoadedEventArgs  read FBaseIntf;
      /// <summary>
      /// The ID of the navigation which corresponds to other navigation ID properties on other navigation events.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2domcontentloadedeventargs#get_navigationid">See the ICoreWebView2DOMContentLoadedEventArgs article.</see></para>
      /// </remarks>
      property NavigationId : uint64                                  read GetNavigationId;
  end;

  /// <summary>
  /// Event args for the FrameCreated events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecreatedeventargs">See the ICoreWebView2FrameCreatedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2FrameCreatedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2FrameCreatedEventArgs;

      function  GetInitialized : boolean;
      function  GetFrame : ICoreWebView2Frame;

    public
      constructor Create(const aArgs: ICoreWebView2FrameCreatedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized  : boolean                             read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf     : ICoreWebView2FrameCreatedEventArgs  read FBaseIntf;
      /// <summary>
      /// The frame which was created.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecreatedeventargs#get_frame">See the ICoreWebView2FrameCreatedEventArgs article.</see></para>
      /// </remarks>
      property Frame        : ICoreWebView2Frame                  read GetFrame;
  end;

  /// <summary>
  /// Event args for the DownloadStarting event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventargs">See the ICoreWebView2DownloadStartingEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2DownloadStartingEventArgs = class
    protected
      FBaseIntf : ICoreWebView2DownloadStartingEventArgs;

      function  GetInitialized : boolean;
      function  GetDownloadOperation : ICoreWebView2DownloadOperation;
      function  GetCancel : boolean;
      function  GetResultFilePath : wvstring;
      function  GetHandled : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetCancel(aValue : boolean);
      procedure SetResultFilePath(const aValue : wvstring);
      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2DownloadStartingEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized        : boolean                                 read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf           : ICoreWebView2DownloadStartingEventArgs  read FBaseIntf;
      /// <summary>
      /// Returns the `ICoreWebView2DownloadOperation` for the download that
      /// has started.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventargs#get_downloadoperation">See the ICoreWebView2DownloadStartingEventArgs article.</see></para>
      /// </remarks>
      property DownloadOperation  : ICoreWebView2DownloadOperation          read GetDownloadOperation;
      /// <summary>
      /// The host may set this flag to cancel the download. If canceled, the
      /// download save dialog is not displayed regardless of the
      /// `Handled` property.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventargs#get_cancel">See the ICoreWebView2DownloadStartingEventArgs article.</see></para>
      /// </remarks>
      property Cancel             : boolean                                 read GetCancel              write SetCancel;
      /// <summary>
      /// The path to the file. If setting the path, the host should ensure that it
      /// is an absolute path, including the file name, and that the path does not
      /// point to an existing file. If the path points to an existing file, the
      /// file will be overwritten. If the directory does not exist, it is created.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventargs#get_resultfilepath">See the ICoreWebView2DownloadStartingEventArgs article.</see></para>
      /// </remarks>
      property ResultFilePath     : wvstring                                read GetResultFilePath      write SetResultFilePath;
      /// <summary>
      /// The host may set this flag to `TRUE` to hide the default download dialog
      /// for this download. The download will progress as normal if it is not
      /// canceled, there will just be no default UI shown. By default the value is
      /// `FALSE` and the default download dialog is shown.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventargs#get_handled">See the ICoreWebView2DownloadStartingEventArgs article.</see></para>
      /// </remarks>
      property Handled            : boolean                                 read GetHandled             write SetHandled;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object.  Use this operation to
      /// complete the event at a later time.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventargs#getdeferral">See the ICoreWebView2DownloadStartingEventArgs article.</see></para>
      /// </remarks>
      property Deferral           : ICoreWebView2Deferral                   read GetDeferral;
  end;

  /// <summary>
  /// Event args for the ClientCertificateRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2ClientCertificateRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ClientCertificateRequestedEventArgs;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      function  GetInitialized : boolean;
      function  GetHost : wvstring;
      function  GetPort : integer;
      function  GetIsProxy : boolean;
      function  GetAllowedCertificateAuthorities : ICoreWebView2StringCollection;
      function  GetMutuallyTrustedCertificates : ICoreWebView2ClientCertificateCollection;
      function  GetSelectedCertificate : ICoreWebView2ClientCertificate;
      function  GetCancel : boolean;
      function  GetHandled : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetSelectedCertificate(const aValue : ICoreWebView2ClientCertificate);
      procedure SetCancel(aValue : boolean);
      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2ClientCertificateRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2ClientCertificateRequestedEventArgs  read FBaseIntf;
      /// <summary>
      /// <para>Host name of the server that requested client certificate authentication.
      /// Normalization rules applied to the hostname are:</para>
      /// <para>* Convert to lowercase characters for ascii characters.</para>
      /// <para>* Punycode is used for representing non ascii characters.</para>
      /// <para>* Strip square brackets for IPV6 address.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_host">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property Host                          : wvstring                                          read GetHost;
      /// <summary>
      /// Port of the server that requested client certificate authentication.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_port">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property Port                          : integer                                           read GetPort;
      /// <summary>
      /// Returns true if the server that issued this request is an http proxy.
      /// Returns false if the server is the origin server.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_isproxy">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property IsProxy                       : boolean                                           read GetIsProxy;
      /// <summary>
      /// Returns the `ICoreWebView2StringCollection`.
      /// The collection contains Base64 encoding of DER encoded distinguished names of
      /// certificate authorities allowed by the server.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_allowedcertificateauthorities">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property AllowedCertificateAuthorities : ICoreWebView2StringCollection                     read GetAllowedCertificateAuthorities;
      /// <summary>
      /// Returns the `ICoreWebView2ClientCertificateCollection` when client
      /// certificate authentication is requested. The collection contains mutually
      /// trusted CA certificates.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_mutuallytrustedcertificates">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property MutuallyTrustedCertificates   : ICoreWebView2ClientCertificateCollection          read GetMutuallyTrustedCertificates;
      /// <summary>
      /// Returns the selected certificate.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_selectedcertificate">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property SelectedCertificate           : ICoreWebView2ClientCertificate                    read GetSelectedCertificate             write SetSelectedCertificate;
      /// <summary>
      /// You may set this flag to cancel the certificate selection. If canceled,
      /// the request is aborted regardless of the `Handled` property. By default the
      /// value is `FALSE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_cancel">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property Cancel                        : boolean                                           read GetCancel                          write SetCancel;
      /// <summary>
      /// You may set this flag to `TRUE` to respond to the server with or
      /// without a certificate. If this flag is `TRUE` with a `SelectedCertificate`
      /// it responds to the server with the selected certificate otherwise respond to the
      /// server without a certificate. By default the value of `Handled` and `Cancel` are `FALSE`
      /// and display default client certificate selection dialog prompt to allow the user to
      /// choose a certificate. The `SelectedCertificate` is ignored unless `Handled` is set `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#get_handled">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property Handled                       : boolean                                           read GetHandled                         write SetHandled;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. Use this operation to
      /// complete the event at a later time.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs#getdeferral">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
      /// </remarks>
      property Deferral                      : ICoreWebView2Deferral                             read GetDeferral;
  end;

  /// <summary>
  /// Event args for the BasicAuthenticationRequested event. Will contain the
  /// request that led to the HTTP authorization challenge, the challenge
  /// and allows the host to provide authentication response or cancel the request.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventargs">See the ICoreWebView2BasicAuthenticationRequestedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2BasicAuthenticationRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2BasicAuthenticationRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetUri : wvstring;
      function  GetChallenge : wvstring;
      function  GetResponse : ICoreWebView2BasicAuthenticationResponse;
      function  GetCancel : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetCancel(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2BasicAuthenticationRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                             read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2BasicAuthenticationRequestedEventArgs  read FBaseIntf;
      /// <summary>
      /// The URI that led to the authentication challenge. For proxy authentication
      /// requests, this will be the URI of the proxy server.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventargs#get_uri">See the ICoreWebView2BasicAuthenticationRequestedEventArgs article.</see></para>
      /// </remarks>
      property Uri                           : wvstring                                            read GetUri;
      /// <summary>
      /// The authentication challenge string.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventargs#get_challenge">See the ICoreWebView2BasicAuthenticationRequestedEventArgs article.</see></para>
      /// </remarks>
      property Challenge                     : wvstring                                            read GetChallenge;
      /// <summary>
      /// Response to the authentication request with credentials. This object will be populated by the app
      /// if the host would like to provide authentication credentials.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventargs#get_response">See the ICoreWebView2BasicAuthenticationRequestedEventArgs article.</see></para>
      /// </remarks>
      property Response                      : ICoreWebView2BasicAuthenticationResponse            read GetResponse;
      /// <summary>
      /// Cancel the authentication request. False by default.
      /// If set to true, Response will be ignored.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventargs#get_cancel">See the ICoreWebView2BasicAuthenticationRequestedEventArgs article.</see></para>
      /// </remarks>
      property Cancel                        : boolean                                             read GetCancel           write SetCancel;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. Use this deferral to
      /// defer the decision to show the Basic Authentication dialog.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventargs#getdeferral">See the ICoreWebView2BasicAuthenticationRequestedEventArgs article.</see></para>
      /// </remarks>
      property Deferral                      : ICoreWebView2Deferral                               read GetDeferral;
  end;

  /// <summary>
  /// Event args for the ContextMenuRequested event. Will contain the selection information
  /// and a collection of all of the default context menu items that the WebView
  /// would show. Allows the app to draw its own context menu or add/remove
  /// from the default context menu.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2ContextMenuRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ContextMenuRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetMenuItems : ICoreWebView2ContextMenuItemCollection;
      function  GetContextMenuTarget : ICoreWebView2ContextMenuTarget;
      function  GetLocation : TPoint;
      function  GetSelectedCommandId : Integer;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetHandled : boolean;

      procedure SetSelectedCommandId(aValue: Integer);
      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2ContextMenuRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                             read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2ContextMenuRequestedEventArgs          read FBaseIntf;
      /// <summary>
      /// Gets the collection of `ContextMenuItem` objects.
      /// See `ICoreWebView2ContextMenuItemCollection` for more details.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs#get_menuitems">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
      /// </remarks>
      property MenuItems                     : ICoreWebView2ContextMenuItemCollection              read GetMenuItems;
      /// <summary>
      /// Gets the target information associated with the requested context menu.
      /// See `ICoreWebView2ContextMenuTarget` for more details.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs#get_contextmenutarget">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
      /// </remarks>
      property ContextMenuTarget             : ICoreWebView2ContextMenuTarget                      read GetContextMenuTarget;
      /// <summary>
      /// Gets the coordinates where the context menu request occurred in relation to the upper
      /// left corner of the WebView bounds.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs#get_location">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
      /// </remarks>
      property Location                      : TPoint                                              read GetLocation;
      /// <summary>
      /// Gets the selected CommandId.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs#get_selectedcommandid">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
      /// </remarks>
      property SelectedCommandId             : integer                                             read GetSelectedCommandId    write SetSelectedCommandId;
      /// <summary>
      /// Gets whether the `ContextMenuRequested` event is handled by host.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs#get_handled">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
      /// </remarks>
      property Handled                       : boolean                                             read GetHandled              write SetHandled;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. Use this operation to
      /// complete the event when the custom context menu is closed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs#getdeferral">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
      /// </remarks>
      property Deferral                      : ICoreWebView2Deferral                               read GetDeferral;
  end;

  /// <summary>
  /// Event args for the ServerCertificateErrorDetected event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventargs">See the ICoreWebView2ServerCertificateErrorDetectedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2ServerCertificateErrorDetectedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ServerCertificateErrorDetectedEventArgs;

      function  GetInitialized : boolean;
      function  GetErrorStatus : TWVWebErrorStatus;
      function  GetRequestUri : wvstring;
      function  GetServerCertificate : ICoreWebView2Certificate;
      function  GetAction : TWVServerCertificateErrorAction;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetAction(aValue: TWVServerCertificateErrorAction);

    public
      constructor Create(const aArgs: ICoreWebView2ServerCertificateErrorDetectedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                              read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2ServerCertificateErrorDetectedEventArgs read FBaseIntf;
      /// <summary>
      /// The TLS error code for the invalid certificate.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventargs#get_errorstatus">See the ICoreWebView2ServerCertificateErrorDetectedEventArgs article.</see></para>
      /// </remarks>
      property ErrorStatus                   : TWVWebErrorStatus                                    read GetErrorStatus;
      /// <summary>
      /// URI associated with the request for the invalid certificate.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventargs#get_requesturi">See the ICoreWebView2ServerCertificateErrorDetectedEventArgs article.</see></para>
      /// </remarks>
      property RequestUri                    : wvstring                                             read GetRequestUri;
      /// <summary>
      /// Returns the server certificate.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventargs#get_servercertificate">See the ICoreWebView2ServerCertificateErrorDetectedEventArgs article.</see></para>
      /// </remarks>
      property ServerCertificate             : ICoreWebView2Certificate                             read GetServerCertificate;
      /// <summary>
      /// The action of the server certificate error detection.
      /// The default value is `COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION_DEFAULT`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventargs#get_action">See the ICoreWebView2ServerCertificateErrorDetectedEventArgs article.</see></para>
      /// </remarks>
      property Action                        : TWVServerCertificateErrorAction                      read GetAction              write SetAction;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. Use this operation to
      /// complete the event at a later time.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventargs#getdeferral">See the ICoreWebView2ServerCertificateErrorDetectedEventArgs article.</see></para>
      /// </remarks>
      property Deferral                      : ICoreWebView2Deferral                                read GetDeferral;
  end;

  /// <summary>
  /// Event args for LaunchingExternalUriScheme event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventargs">See the ICoreWebView2LaunchingExternalUriSchemeEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2LaunchingExternalUriSchemeEventArgs = class
    protected
      FBaseIntf : ICoreWebView2LaunchingExternalUriSchemeEventArgs;

      function  GetInitialized : boolean;
      function  GetUri : wvstring;
      function  GetInitiatingOrigin : wvstring;
      function  GetIsUserInitiated : boolean;
      function  GetCancel : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetCancel(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2LaunchingExternalUriSchemeEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2LaunchingExternalUriSchemeEventArgs  read FBaseIntf;
      /// <summary>
      /// The URI with the external URI scheme to be launched.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventargs#get_uri">See the ICoreWebView2LaunchingExternalUriSchemeEventArgs article.</see></para>
      /// </remarks>
      property Uri                           : wvstring                                          read GetUri;
      /// <summary>
      /// <para>The origin initiating the external URI scheme launch.</para>
      /// <para>The origin will be an empty string if the request is initiated by calling
      /// `CoreWebView2.Navigate` on the external URI scheme. If a script initiates
      /// the navigation, the `InitiatingOrigin` will be the top-level document's
      /// `Source`, for example, if `window.location` is set to `"calculator://"`, the
      /// `InitiatingOrigin` will be set to `calculator://`. If the request is initiated
      ///  from a child frame, the `InitiatingOrigin` will be the source of that child frame.</para>
      /// <para>If the `InitiatingOrigin` is
      /// [opaque](https://html.spec.whatwg.org/multipage/origin.html#concept-origin-opaque),
      /// the `InitiatingOrigin` reported in the event args will be its precursor origin.
      /// The precursor origin is the origin that created the opaque origin. For example, if
      /// a frame on example.com opens a subframe with a different opaque origin, the subframe's
      /// precursor origin is example.com.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventargs#get_initiatingorigin">See the ICoreWebView2LaunchingExternalUriSchemeEventArgs article.</see></para>
      /// </remarks>
      property InitiatingOrigin              : wvstring                                          read GetInitiatingOrigin;
      /// <summary>
      /// <para>`TRUE` when the external URI scheme request was initiated through a user gesture.</para>
      /// <para>\>NOTE: Being initiated through a user gesture does not mean that user intended
      /// to access the associated resource.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventargs#get_isuserinitiated">See the ICoreWebView2LaunchingExternalUriSchemeEventArgs article.</see></para>
      /// </remarks>
      property IsUserInitiated               : boolean                                           read GetIsUserInitiated;
      /// <summary>
      /// <para>The event handler may set this property to `TRUE` to cancel the external URI scheme
      /// launch. If set to `TRUE`, the external URI scheme will not be launched, and the default
      /// dialog is not displayed. This property can be used to replace the normal
      /// handling of launching an external URI scheme.</para>
      /// <para>The initial value of the `Cancel` property is `FALSE`.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventargs#get_cancel">See the ICoreWebView2LaunchingExternalUriSchemeEventArgs article.</see></para>
      /// </remarks>
      property Cancel                        : boolean                                           read GetCancel             write SetCancel;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object.  Use this operation to
      /// complete the event at a later time.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventargs#getdeferral">See the ICoreWebView2LaunchingExternalUriSchemeEventArgs article.</see></para>
      /// </remarks>
      property Deferral                      : ICoreWebView2Deferral                             read GetDeferral;
  end;

  /// <summary>
  /// This is the Interface for non-client region change event args.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2nonclientregionchangedeventargs">See the ICoreWebView2NonClientRegionChangedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2NonClientRegionChangedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2NonClientRegionChangedEventArgs;

      function  GetInitialized : boolean;
      function  GetRegionKind : TWVNonClientRegionKind;

    public
      constructor Create(const aArgs: ICoreWebView2NonClientRegionChangedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2NonClientRegionChangedEventArgs      read FBaseIntf;
      /// <summary>
      /// This property represents the COREWEBVIEW2_NON_CLIENT_REGION_KIND which the
      /// region changed event corresponds to. With this property an app can query
      /// for a collection of rects which have that region kind by using
      /// QueryNonClientRegion on the composition controller.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2nonclientregionchangedeventargs#get_regionkind">See the ICoreWebView2NonClientRegionChangedEventArgs article.</see></para>
      /// </remarks>
      property RegionKind                    : TWVNonClientRegionKind                            read GetRegionKind;
  end;

  /// <summary>
  /// Event args for the `NotificationReceived` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notificationreceivedeventargs">See the ICoreWebView2NotificationReceivedEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2NotificationReceivedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2NotificationReceivedEventArgs;

      function  GetInitialized : boolean;
      function  GetSenderOrigin : wvstring;
      function  GetNotification : ICoreWebView2Notification;
      function  GetHandled : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetHandled(aValue: boolean);

    public
      constructor Create(const aArgs: ICoreWebView2NotificationReceivedEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2NotificationReceivedEventArgs        read FBaseIntf;
      /// <summary>
      /// The origin of the web content that sends the notification, such as
      /// `https://example.com/` or `https://www.example.com/`.
      /// </summary>
      property SenderOrigin                  : wvstring                                          read GetSenderOrigin;
      /// <summary>
      /// The notification that was received. You can access the
      /// properties on the Notification object to show your own notification.
      /// </summary>
      property Notification                  : ICoreWebView2Notification                         read GetNotification;
      /// <summary>
      /// <para>Sets whether the `NotificationReceived` event is handled by the host after
      /// the event handler completes or if there is a deferral then after the
      /// deferral is completed.</para>
      ///
      /// <para>If `Handled` is set to TRUE then WebView will not display the notification
      /// with the default UI, and the host will be responsible for handling the
      /// notification and for letting the web content know that the notification
      /// has been displayed, clicked, or closed. You must set `Handled` to `TRUE`
      /// before you call `ReportShown`, `ReportClicked`,
      /// `ReportClickedWithActionIndex` and `ReportClosed`, otherwise they will
      /// fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`. If after the event
      /// handler or deferral completes `Handled` is set to FALSE then WebView will
      /// display the default notification UI. Note that you cannot un-handle this
      /// event once you have set `Handled` to be `TRUE`. The initial value is
      /// FALSE.</para>
      /// </summary>
      property Handled                       : boolean                                           read GetHandled              write SetHandled;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. Use this operation to complete
      /// the event at a later time.
      /// </summary>
      property Deferral                      : ICoreWebView2Deferral                             read GetDeferral;
  end;

  /// <summary>
  /// The event args for `SaveAsUIShowing` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2saveasuishowingeventargs">See the ICoreWebView2SaveAsUIShowingEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2SaveAsUIShowingEventArgs = class
    protected
      FBaseIntf : ICoreWebView2SaveAsUIShowingEventArgs;

      function  GetInitialized : boolean;
      function  GetContentMimeType : wvstring;
      function  GetCancel : boolean;
      function  GetSuppressDefaultDialog : boolean;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetSaveAsFilePath : wvstring;
      function  GetAllowReplace : boolean;
      function  GetKind : TWVSaveAsKind;

      procedure SetCancel(aValue : boolean);
      procedure SetSuppressDefaultDialog(aValue : boolean);
      procedure SetSaveAsFilePath(const aValue : wvstring);
      procedure SetAllowReplace(aValue : boolean);
      procedure SetKind(aValue : TWVSaveAsKind);

    public
      constructor Create(const aArgs: ICoreWebView2SaveAsUIShowingEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2SaveAsUIShowingEventArgs             read FBaseIntf;
      /// <summary>
      /// Get the Mime type of content to be saved.
      /// </summary>
      property ContentMimeType               : wvstring                                          read GetContentMimeType;
      /// <summary>
      /// Sets the `Cancel` property. Set this property to `TRUE` to cancel the Save As action
      /// and prevent the download from starting. ShowSaveAsUI returns
      /// `COREWEBVIEW2_SAVE_AS_UI_RESULT_CANCELLED` in this case. The default value is `FALSE`.
      /// </summary>
      property Cancel                        : boolean                                           read GetCancel                  write SetCancel;
      /// <summary>
      /// <para>Sets the `SuppressDefaultDialog` property, which indicates whether the system
      /// default dialog is suppressed. When `SuppressDefaultDialog` is `FALSE`, the default
      /// Save As dialog is shown and the values assigned through `SaveAsFilePath`, `AllowReplace`
      /// and `Kind` are ignored when the event args invoke completed.</para>
      ///
      /// <para>Set `SuppressDefaultDialog` to `TRUE` to perform a silent Save As. When
      /// `SuppressDefaultDialog` is `TRUE`, the system dialog is skipped and the
      /// `SaveAsFilePath`, `AllowReplace` and `Kind` values are used.</para>
      ///
      /// <para>The default value is FALSE.</para>
      /// </summary>
      property SuppressDefaultDialog         : boolean                                           read GetSuppressDefaultDialog   write SetSuppressDefaultDialog;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. This will defer showing the
      /// default Save As dialog and performing the Save As operation.
      /// </summary>
      property Deferral                      : ICoreWebView2Deferral                             read GetDeferral;
      /// <summary>
      /// <para>Set the `SaveAsFilePath` property for Save As. `SaveAsFilePath` is an absolute path
      /// of the location. It includes the file name and extension. If `SaveAsFilePath` is not
      /// valid (for example, the root drive does not exist), Save As is denied and
      /// `COREWEBVIEW2_SAVE_AS_INVALID_PATH` is returned.</para>
      ///
      /// <para>If the associated download completes successfully, a target file is saved at
      /// this location. If the Kind property is `COREWEBVIEW2_SAVE_AS_KIND_COMPLETE`,
      /// there will be an additional directory with resources files.</para>
      ///
      /// <para>The default value is a system suggested path, based on users' local environment.</para>
      /// </summary>
      property SaveAsFilePath                : wvstring                                          read GetSaveAsFilePath          write SetSaveAsFilePath;
      /// <summary>
      /// <para>`AllowReplace` allows user to control what happens when a file already
      /// exists in the file path to which the Save As operation is saving.</para>
      /// <para>Setting this property to `TRUE` allows existing files to be replaced.</para>
      /// <para>Setting this property to `FALSE` will not replace existing files and will return
      /// `COREWEBVIEW2_SAVE_AS_UI_RESULT_FILE_ALREADY_EXISTS`.</para>
      ///
      /// <para>The default value is `FALSE`.</para>
      /// </summary>
      property AllowReplace                  : boolean                                           read GetAllowReplace           write SetAllowReplace;
      /// <summary>
      /// <para>Sets the `Kind` property to save documents of different kinds. See the
      /// `COREWEBVIEW2_SAVE_AS_KIND` enum for a description of the different options.</para>
      /// <para>If the kind is not allowed for the current document, ShowSaveAsUI returns
      /// `COREWEBVIEW2_SAVE_AS_UI_RESULT_KIND_NOT_SUPPORTED`.</para>
      ///
      /// <para>The default value is `COREWEBVIEW2_SAVE_AS_KIND_DEFAULT`.</para>
      /// </summary>
      property Kind                          : TWVSaveAsKind                                     read GetKind                   write SetKind;
  end;

  /// <summary>
  /// The event args for `SaveFileSecurityCheckStarting` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2savefilesecuritycheckstartingeventargs">See the ICoreWebView2SaveFileSecurityCheckStartingEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2SaveFileSecurityCheckStartingEventArgs = class
    protected
      FBaseIntf : ICoreWebView2SaveFileSecurityCheckStartingEventArgs;

      function  GetInitialized : boolean;
      function  GetCancelSave : boolean;
      function  GetDocumentOriginUri : wvstring;
      function  GetFileExtension : wvstring;
      function  GetFilePath : wvstring;
      function  GetSuppressDefaultPolicy : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetCancelSave(aValue: boolean);
      procedure SetSuppressDefaultPolicy(aValue: boolean);

    public
      constructor Create(const aArgs: ICoreWebView2SaveFileSecurityCheckStartingEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2SaveFileSecurityCheckStartingEventArgs        read FBaseIntf;
      /// <summary>
      /// Set if cancel the upcoming save/download. `TRUE` means the action
      /// will be cancelled before validations in default policy.
      /// The default value is `FALSE`.
      /// </summary>
      property CancelSave                    : boolean                                                    read GetCancelSave             write SetCancelSave;
      /// <summary>
      /// Get the document origin URI of this file save operation.
      /// </summary>
      property DocumentOriginUri             : wvstring                                                   read GetDocumentOriginUri;
      /// <summary>
      /// Get the extension of file to be saved.
      /// The file extension is the extension portion of the FilePath,
      /// preserving original case.
      /// Only final extension with period "." will be provided. For example,
      /// "*.tar.gz" is a double extension, where the ".gz" will be its
      /// final extension.
      /// File extension can be empty, if the file name has no extension
      /// at all.
      /// </summary>
      property FileExtension                 : wvstring                                                   read GetFileExtension;
      /// <summary>
      /// Get the full path of file to be saved. This includes the
      /// file name and extension.
      /// This method doesn't provide path validation, the returned
      /// string may longer than MAX_PATH.
      /// </summary>
      property FilePath                      : wvstring                                                   read GetFilePath;
      /// <summary>
      /// Set if the default policy checking and security warning will be
      /// suppressed. `TRUE` means it will be suppressed.
      /// The default value is `FALSE`.
      /// </summary>
      property SuppressDefaultPolicy         : boolean                                                    read GetSuppressDefaultPolicy  write SetSuppressDefaultPolicy;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. Use this operation to complete
      /// the SaveFileSecurityCheckStartingEvent.
      /// The default policy checking and any default UI will be blocked temporarily,
      /// saving file to local won't start, until the deferral is completed.
      /// </summary>
      property Deferral                      : ICoreWebView2Deferral                                      read GetDeferral;
  end;

  /// <summary>
  /// Event args for the `ScreenCaptureStarting` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/tcorewebview2screencapturestartingeventargs">See the TCoreWebView2ScreenCaptureStartingEventArgs article.</see></para>
  /// </remarks>
  TCoreWebView2ScreenCaptureStartingEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ScreenCaptureStartingEventArgs;

      function  GetInitialized : boolean;
      function  GetCancel : boolean;
      function  GetHandled : boolean;
      function  GetCoreWebView2FrameInfo : ICoreWebView2FrameInfo;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetCancel(aValue: boolean);
      procedure SetHandled(aValue: boolean);

    public
      constructor Create(const aArgs: ICoreWebView2ScreenCaptureStartingEventArgs); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                   : boolean                                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                      : ICoreWebView2ScreenCaptureStartingEventArgs       read FBaseIntf;
      /// <summary>
      /// <para>The host may set this flag to cancel the screen capture. If canceled,
      /// the screen capture UI is not displayed regardless of the
      /// `Handled` property.</para>
      /// <para>On the script side, it will return with a NotAllowedError as Permission denied.</para>
      /// </summary>
      property Cancel                        : boolean                                           read GetCancel                  write SetCancel;
      /// <summary>
      /// <para>By default, both the `ScreenCaptureStarting` event handlers on the
      /// `CoreWebView2Frame` and the `CoreWebView2` will be invoked, with the
      /// `CoreWebView2Frame` event handlers invoked first. The host may
      /// set this flag to `TRUE` within the `CoreWebView2Frame` event handlers
      /// to prevent the remaining `CoreWebView2` event handlers from being
      /// invoked. If the flag is set to `FALSE` within the `CoreWebView2Frame`
      /// event handlers, downstream handlers can update the `Cancel` property.</para>
      ///
      /// <para>If a deferral is taken on the event args, then you must synchronously
      /// set `Handled` to TRUE prior to taking your deferral to prevent the
      /// `CoreWebView2`s event handlers from being invoked.</para>
      /// </summary>
      property Handled                       : boolean                                           read GetHandled                 write SetHandled;
      /// <summary>
      /// The associated frame information that requests the screen capture
      /// permission. This can be used to get the frame source, name, frameId,
      /// and parent frame information.
      /// </summary>
      property OriginalSourceFrameInfo       : ICoreWebView2FrameInfo                            read GetCoreWebView2FrameInfo;
      /// <summary>
      /// Returns an `ICoreWebView2Deferral` object. Use this deferral to
      /// defer the decision to show the Screen Capture UI. getDisplayMedia()
      /// won't call its callbacks until the deferral is completed.
      /// </summary>
      property Deferral                      : ICoreWebView2Deferral                             read GetDeferral;
  end;

implementation

uses
  uWVMiscFunctions;

// TCoreWebView2AcceleratorKeyPressedEventArgs

constructor TCoreWebView2AcceleratorKeyPressedEventArgs.Create(const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2AcceleratorKeyPressedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2AcceleratorKeyPressedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2AcceleratorKeyPressedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetKeyEventKind : TWVKeyEventKind;
var
  TempType : COREWEBVIEW2_KEY_EVENT_KIND;
begin
  if Initialized and succeeded(FBaseIntf.Get_KeyEventKind(TempType)) then
    Result := TempType
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetVirtualKey : LongWord;
var
  TempKey : LongWord;
begin
  if Initialized and succeeded(FBaseIntf.Get_VirtualKey(TempKey)) then
    Result := TempKey
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetKeyEventLParam : integer;
var
  TempParam : Integer;
begin
  if Initialized and succeeded(FBaseIntf.Get_KeyEventLParam(TempParam)) then
    Result := TempParam
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetHandled : boolean;
var
  TempHandled : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempHandled)) and
            (TempHandled <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetRepeatCount : LongWord;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  if Initialized and succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) then
    Result := TempStatus.RepeatCount
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetScanCode : LongWord;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  if Initialized and succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) then
    Result := TempStatus.ScanCode
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetIsExtendedKey : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.IsExtendedKey <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetIsMenuKeyDown : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.IsMenuKeyDown <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetWasKeyDown : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.WasKeyDown <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetIsKeyReleased : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.IsKeyReleased <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetIsBrowserAcceleratorKeyEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.Get_IsBrowserAcceleratorKeyEnabled(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2AcceleratorKeyPressedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;

procedure TCoreWebView2AcceleratorKeyPressedEventArgs.SetIsBrowserAcceleratorKeyEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_IsBrowserAcceleratorKeyEnabled(ord(aValue));
end;


// TCoreWebView2ContentLoadingEventArgs

constructor TCoreWebView2ContentLoadingEventArgs.Create(const aArgs: ICoreWebView2ContentLoadingEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ContentLoadingEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ContentLoadingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ContentLoadingEventArgs.GetIsErrorPage : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsErrorPage(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContentLoadingEventArgs.GetNavigationId : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;


// TCoreWebView2DevToolsProtocolEventReceivedEventArgs

constructor TCoreWebView2DevToolsProtocolEventReceivedEventArgs.Create(const aArgs: ICoreWebView2DevToolsProtocolEventReceivedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2DevToolsProtocolEventReceivedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2DevToolsProtocolEventReceivedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2DevToolsProtocolEventReceivedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2DevToolsProtocolEventReceivedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2DevToolsProtocolEventReceivedEventArgs.GetParameterObjectAsJson : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if Initialized and
     succeeded(FBaseIntf.Get_ParameterObjectAsJson(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DevToolsProtocolEventReceivedEventArgs.GetSessionId : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_sessionId(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;



// TCoreWebView2MoveFocusRequestedEventArgs

constructor TCoreWebView2MoveFocusRequestedEventArgs.Create(const aArgs: ICoreWebView2MoveFocusRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2MoveFocusRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2MoveFocusRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2MoveFocusRequestedEventArgs.GetReason : TWVMoveFocusReason;
var
  TempReason : COREWEBVIEW2_MOVE_FOCUS_REASON;
begin
  if Initialized and succeeded(FBaseIntf.Get_reason(TempReason)) then
    Result := TempReason
   else
    Result := 0;
end;

function TCoreWebView2MoveFocusRequestedEventArgs.GetHandled : boolean;
var
  TempHandled : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempHandled)) and
            (TempHandled <> 0);
end;

procedure TCoreWebView2MoveFocusRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2NavigationCompletedEventArgs

constructor TCoreWebView2NavigationCompletedEventArgs.Create(const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NavigationCompletedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2NavigationCompletedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2NavigationCompletedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2NavigationCompletedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NavigationCompletedEventArgs.GetIsSuccess : boolean;
var
  TempSuccess : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsSuccess(TempSuccess)) and
            (TempSuccess <> 0);
end;

function TCoreWebView2NavigationCompletedEventArgs.GetWebErrorStatus : TWVWebErrorStatus;
var
  TempStatus : COREWEBVIEW2_WEB_ERROR_STATUS;
begin
  if Initialized and succeeded(FBaseIntf.Get_WebErrorStatus(TempStatus)) then
    Result := TempStatus
   else
    Result := 0;
end;

function TCoreWebView2NavigationCompletedEventArgs.GetNavigationID : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;

function TCoreWebView2NavigationCompletedEventArgs.GetHttpStatusCode : integer;
var
  TempResult : SYSINT;
begin
  Result     := 0;
  TempResult := 0;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_HttpStatusCode(TempResult)) then
    Result := TempResult;
end;


// TCoreWebView2NavigationStartingEventArgs

constructor TCoreWebView2NavigationStartingEventArgs.Create(const aArgs: ICoreWebView2NavigationStartingEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NavigationStartingEventArgs2, FBaseIntf2) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NavigationStartingEventArgs3, FBaseIntf3);
end;

destructor TCoreWebView2NavigationStartingEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2NavigationStartingEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
end;

function TCoreWebView2NavigationStartingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NavigationStartingEventArgs.GetURI : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2NavigationStartingEventArgs.GetIsUserInitiated : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsUserInitiated(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2NavigationStartingEventArgs.GetIsRedirected : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsRedirected(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2NavigationStartingEventArgs.GetRequestHeaders : ICoreWebView2HttpRequestHeaders;
var
  TempResult : ICoreWebView2HttpRequestHeaders;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_RequestHeaders(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2NavigationStartingEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2NavigationStartingEventArgs.GetNavigationID : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;

function TCoreWebView2NavigationStartingEventArgs.GetAdditionalAllowedFrameAncestors : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_AdditionalAllowedFrameAncestors(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2NavigationStartingEventArgs.GetNavigationKind : TWVNavigationKind;
var
  TempResult : COREWEBVIEW2_NAVIGATION_KIND;
begin
  TempResult := COREWEBVIEW2_NAVIGATION_KIND_RELOAD;
  Result     := TempResult;

  if assigned(FBaseIntf3) and
     succeeded(FBaseIntf3.Get_NavigationKind(TempResult)) then
    Result := TempResult;
end;

procedure TCoreWebView2NavigationStartingEventArgs.SetAdditionalAllowedFrameAncestors(const aValue : wvstring);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_AdditionalAllowedFrameAncestors(PWideChar(aValue));
end;

procedure TCoreWebView2NavigationStartingEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;


// TCoreWebView2NewWindowRequestedEventArgs

constructor TCoreWebView2NewWindowRequestedEventArgs.Create(const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NewWindowRequestedEventArgs2, FBaseIntf2) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NewWindowRequestedEventArgs3, FBaseIntf3);
end;

destructor TCoreWebView2NewWindowRequestedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2NewWindowRequestedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetURI : wvstring;
var
  TempURI : PWideChar;
begin
  Result  := '';
  TempURI := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempURI)) and
     (TempURI <> nil) then
    begin
      Result := TempURI;
      CoTaskMemFree(TempURI);
    end;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetNewWindow : ICoreWebView2;
var
  TempNewWindow : ICoreWebView2;
begin
  Result        := nil;
  TempNewWindow := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_NewWindow(TempNewWindow)) and
     (TempNewWindow <> nil) then
    Result := TempNewWindow;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetHandled : boolean;
var
  TempHandled : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempHandled)) and
            (TempHandled <> 0);
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetIsUserInitiated : boolean;
var
  TempIsUserInitiated : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsUserInitiated(TempIsUserInitiated)) and
            (TempIsUserInitiated <> 0);
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetWindowFeatures : ICoreWebView2WindowFeatures;
var
  TempWindowFeatures : ICoreWebView2WindowFeatures;
begin
  Result             := nil;
  TempWindowFeatures := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_WindowFeatures(TempWindowFeatures)) and
     (TempWindowFeatures <> nil) then
    Result := TempWindowFeatures;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetName : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if (FBaseIntf2 <> nil) and
     succeeded(FBaseIntf2.Get_name(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetOriginalSourceFrameInfo : ICoreWebView2FrameInfo;
var
  TempFrameInfo : ICoreWebView2FrameInfo;
begin
  Result        := nil;
  TempFrameInfo := nil;

  if (FBaseIntf3 <> nil) and
     succeeded(FBaseIntf3.Get_OriginalSourceFrameInfo(TempFrameInfo)) and
     (TempFrameInfo <> nil) then
    Result := TempFrameInfo;
end;

procedure TCoreWebView2NewWindowRequestedEventArgs.SetNewWindow(const aValue : ICoreWebView2);
begin
  if Initialized then
    FBaseIntf.Set_NewWindow(aValue);
end;

procedure TCoreWebView2NewWindowRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2PermissionRequestedEventArgs

constructor TCoreWebView2PermissionRequestedEventArgs.Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if assigned(aArgs) and
     LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs2, FBaseIntf2) then
    LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs3, FBaseIntf3);
end;

constructor TCoreWebView2PermissionRequestedEventArgs.Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs2);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf2 := aArgs;

  if assigned(aArgs) and
     LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs, FBaseIntf) then
    LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs3, FBaseIntf3);
end;

destructor TCoreWebView2PermissionRequestedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2PermissionRequestedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2PermissionRequestedEventArgs.GetURI : wvstring;
var
  TempURI : PWideChar;
begin
  Result  := '';
  TempURI := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempURI)) and
     (TempURI <> nil) then
    begin
      Result := TempURI;
      CoTaskMemFree(TempURI);
    end;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetState : TWVPermissionState;
var
  TempState : COREWEBVIEW2_PERMISSION_STATE;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_State(TempState)) then
    Result := TempState
   else
    Result := 0;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetPermissionKind : TWVPermissionKind;
var
  TempKind : COREWEBVIEW2_PERMISSION_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PermissionKind(TempKind)) then
    Result := TempKind
   else
    Result := 0;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetIsUserInitiated : boolean;
var
  TempIsUserInitiated : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsUserInitiated(TempIsUserInitiated)) and
            (TempIsUserInitiated <> 0);
end;

function TCoreWebView2PermissionRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetHandled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.Get_Handled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2PermissionRequestedEventArgs.GetSavesInProfile : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Get_SavesInProfile(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2PermissionRequestedEventArgs.SetState(aValue : TWVPermissionState);
begin
  if Initialized then
    FBaseIntf.Set_State(aValue);
end;

procedure TCoreWebView2PermissionRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_Handled(ord(aValue));
end;

procedure TCoreWebView2PermissionRequestedEventArgs.SetSavesInProfile(aValue : boolean);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_SavesInProfile(ord(aValue));
end;


// TCoreWebView2ProcessFailedEventArgs

constructor TCoreWebView2ProcessFailedEventArgs.Create(const aArgs: ICoreWebView2ProcessFailedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2ProcessFailedEventArgs2, FBaseIntf2) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2ProcessFailedEventArgs3, FBaseIntf3);
end;

destructor TCoreWebView2ProcessFailedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2ProcessFailedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
end;

function TCoreWebView2ProcessFailedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ProcessFailedEventArgs.GetProcessFailedKind : TWVProcessFailedKind;
var
  TempKind : COREWEBVIEW2_PROCESS_FAILED_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ProcessFailedKind(TempKind)) then
    Result := TempKind
   else
    Result := 0;
end;

function TCoreWebView2ProcessFailedEventArgs.GetReason : TWVProcessFailedReason;
var
  TempResult : COREWEBVIEW2_PROCESS_FAILED_REASON;
begin
  Result     := 0;
  TempResult := 0;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_reason(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ProcessFailedEventArgs.GetExtiCode : integer;
var
  TempResult : SYSINT;
begin
  Result     := 0;
  TempResult := 0;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_ExitCode(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ProcessFailedEventArgs.GetProcessDescription : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_ProcessDescription(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ProcessFailedEventArgs.GetFrameInfosForFailedProcess : ICoreWebView2FrameInfoCollection;
var
  TempResult : ICoreWebView2FrameInfoCollection;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_FrameInfosForFailedProcess(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ProcessFailedEventArgs.GetFailureSourceModulePath : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf3) and
     succeeded(FBaseIntf3.Get_FailureSourceModulePath(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;


// TCoreWebView2ScriptDialogOpeningEventArgs

constructor TCoreWebView2ScriptDialogOpeningEventArgs.Create(const aArgs: ICoreWebView2ScriptDialogOpeningEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ScriptDialogOpeningEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetURI : wvstring;
var
  TempURI : PWideChar;
begin
  Result  := '';
  TempURI := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempURI)) and
     (TempURI <> nil) then
    begin
      Result := TempURI;
      CoTaskMemFree(TempURI);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetKind : TWVScriptDialogKind;
var
  TempKind : COREWEBVIEW2_SCRIPT_DIALOG_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempKind)) then
    Result := TempKind
   else
    Result := 0;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetMessage : wvstring;
var
  TempString : PWideChar;
begin
  Result  := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Message(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.Accept : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Accept);
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetDefaultText : wvstring;
var
  TempString : PWideChar;
begin
  Result  := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DefaultText(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetResultText : wvstring;
var
  TempString : PWideChar;
begin
  Result  := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ResultText(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

procedure TCoreWebView2ScriptDialogOpeningEventArgs.SetResultText(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_ResultText(PWideChar(aValue));
end;


// TCoreWebView2SourceChangedEventArgs

constructor TCoreWebView2SourceChangedEventArgs.Create(const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2SourceChangedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2SourceChangedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2SourceChangedEventArgs.GetIsNewDocument : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsNewDocument(TempInt)) and
            (TempInt <> 0);
end;


// TCoreWebView2WebMessageReceivedEventArgs1

constructor TCoreWebView2WebMessageReceivedEventArgs.Create(const aArgs: ICoreWebView2WebMessageReceivedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2WebMessageReceivedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2WebMessageReceivedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2WebMessageReceivedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetSource : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Source(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetWebMessageAsJson : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_webMessageAsJson(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetWebMessageAsString : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.TryGetWebMessageAsString(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetAdditionalObjects : ICoreWebView2ObjectCollectionView;
var
  TempCollectionView : ICoreWebView2ObjectCollectionView;
begin
  Result             := nil;
  TempCollectionView := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_AdditionalObjects(TempCollectionView)) and
     (TempCollectionView <> nil) then
    Result := TempCollectionView;
end;


// TCoreWebView2WebResourceRequestedEventArgs

constructor TCoreWebView2WebResourceRequestedEventArgs.Create(const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2WebResourceRequestedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2WebResourceRequestedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2WebResourceRequestedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetRequest : ICoreWebView2WebResourceRequest;
var
  TempRequest : ICoreWebView2WebResourceRequest;
begin
  Result      := nil;
  TempRequest := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Request(TempRequest)) and
     (TempRequest <> nil) then
    Result := TempRequest;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetResponse : ICoreWebView2WebResourceResponse;
var
  TempResponse : ICoreWebView2WebResourceResponse;
begin
  Result       := nil;
  TempResponse := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Response(TempResponse)) and
     (TempResponse <> nil) then
    Result := TempResponse;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetResourceContext : TWVWebResourceContext;
var
  TempContext : COREWEBVIEW2_WEB_RESOURCE_CONTEXT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ResourceContext(TempContext)) then
    Result := TempContext
   else
    Result := COREWEBVIEW2_WEB_RESOURCE_CONTEXT_ALL;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetRequestedSourceKind : TWVWebResourceRequestSourceKind;
var
  TempResult : COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS;
begin
  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_RequestedSourceKind(TempResult)) then
    Result := TempResult
   else
    Result := COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_NONE;
end;

procedure TCoreWebView2WebResourceRequestedEventArgs.SetResponse(const aValue : ICoreWebView2WebResourceResponse);
begin
  if Initialized then
    FBaseIntf.Set_Response(aValue);
end;


// TCoreWebView2BrowserProcessExitedEventArgs

constructor TCoreWebView2BrowserProcessExitedEventArgs.Create(const aArgs: ICoreWebView2BrowserProcessExitedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2BrowserProcessExitedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2BrowserProcessExitedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2BrowserProcessExitedEventArgs.GetBrowserProcessExitKind : TWVBrowserProcessExitKind;
var
  TempResult : COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_BrowserProcessExitKind(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2BrowserProcessExitedEventArgs.GetBrowserProcessId : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_BrowserProcessId(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;


// TCoreWebView2WebResourceResponseReceivedEventArgs

constructor TCoreWebView2WebResourceResponseReceivedEventArgs.Create(const aArgs: ICoreWebView2WebResourceResponseReceivedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2WebResourceResponseReceivedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceResponseReceivedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebResourceResponseReceivedEventArgs.GetRequest : ICoreWebView2WebResourceRequest;
var
  TempRequest : ICoreWebView2WebResourceRequest;
begin
  Result      := nil;
  TempRequest := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Request(TempRequest)) and
     (TempRequest <> nil) then
    Result := TempRequest;
end;

function TCoreWebView2WebResourceResponseReceivedEventArgs.GetResponse : ICoreWebView2WebResourceResponseView;
var
  TempResponse : ICoreWebView2WebResourceResponseView;
begin
  Result       := nil;
  TempResponse := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Response(TempResponse)) and
     (TempResponse <> nil) then
    Result := TempResponse;
end;


// TCoreWebView2DOMContentLoadedEventArgs

constructor TCoreWebView2DOMContentLoadedEventArgs.Create(const aArgs: ICoreWebView2DOMContentLoadedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2DOMContentLoadedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2DOMContentLoadedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2DOMContentLoadedEventArgs.GetNavigationID : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;


// TCoreWebView2FrameCreatedEventArgs

constructor TCoreWebView2FrameCreatedEventArgs.Create(const aArgs: ICoreWebView2FrameCreatedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2FrameCreatedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameCreatedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2FrameCreatedEventArgs.GetFrame : ICoreWebView2Frame;
var
  TempResult : ICoreWebView2Frame;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Frame(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;


// TCoreWebView2DownloadStartingEventArgs

constructor TCoreWebView2DownloadStartingEventArgs.Create(const aArgs: ICoreWebView2DownloadStartingEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2DownloadStartingEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2DownloadStartingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2DownloadStartingEventArgs.GetDownloadOperation : ICoreWebView2DownloadOperation;
var
  TempResult : ICoreWebView2DownloadOperation;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DownloadOperation(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2DownloadStartingEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2DownloadStartingEventArgs.GetResultFilePath : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ResultFilePath(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DownloadStartingEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2DownloadStartingEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2DownloadStartingEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;

procedure TCoreWebView2DownloadStartingEventArgs.SetResultFilePath(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_ResultFilePath(PWideChar(aValue));
end;

procedure TCoreWebView2DownloadStartingEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2ClientCertificateRequestedEventArgs

constructor TCoreWebView2ClientCertificateRequestedEventArgs.Create(const aArgs: ICoreWebView2ClientCertificateRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ClientCertificateRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetHost : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Host(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetPort : integer;
var
  TempPort : Integer;
begin
  if Initialized and succeeded(FBaseIntf.Get_Port(TempPort)) then
    Result := TempPort
   else
    Result := 0;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetIsProxy : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsProxy(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetAllowedCertificateAuthorities : ICoreWebView2StringCollection;
var
  TempResult : ICoreWebView2StringCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_AllowedCertificateAuthorities(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetMutuallyTrustedCertificates : ICoreWebView2ClientCertificateCollection;
var
  TempResult : ICoreWebView2ClientCertificateCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_MutuallyTrustedCertificates(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetSelectedCertificate : ICoreWebView2ClientCertificate;
var
  TempResult : ICoreWebView2ClientCertificate;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_SelectedCertificate(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2ClientCertificateRequestedEventArgs.SetSelectedCertificate(const aValue : ICoreWebView2ClientCertificate);
begin
  if Initialized then
    FBaseIntf.Set_SelectedCertificate(aValue);
end;

procedure TCoreWebView2ClientCertificateRequestedEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;

procedure TCoreWebView2ClientCertificateRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2BasicAuthenticationRequestedEventArgs

constructor TCoreWebView2BasicAuthenticationRequestedEventArgs.Create(const aArgs: ICoreWebView2BasicAuthenticationRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2BasicAuthenticationRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetChallenge : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Challenge(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetResponse : ICoreWebView2BasicAuthenticationResponse;
var
  TempResult : ICoreWebView2BasicAuthenticationResponse;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Response(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2BasicAuthenticationRequestedEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;


// TCoreWebView2ContextMenuRequestedEventArgs

constructor TCoreWebView2ContextMenuRequestedEventArgs.Create(const aArgs: ICoreWebView2ContextMenuRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ContextMenuRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetMenuItems : ICoreWebView2ContextMenuItemCollection;
var
  TempResult : ICoreWebView2ContextMenuItemCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_MenuItems(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetContextMenuTarget : ICoreWebView2ContextMenuTarget;
var
  TempResult : ICoreWebView2ContextMenuTarget;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ContextMenuTarget(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetLocation : TPoint;
var
  TempResult : tagPOINT;
begin
  Result.x := low(integer);
  Result.y := low(integer);

  if Initialized and
     succeeded(FBaseIntf.Get_Location(TempResult)) then
    begin
      Result.x := TempResult.x;
      Result.y := TempResult.y;
    end;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetSelectedCommandId : Integer;
var
  TempResult : integer;
begin
  Result     := -1;
  TempResult := -1;

  if Initialized and
     succeeded(FBaseIntf.Get_SelectedCommandId(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2ContextMenuRequestedEventArgs.SetSelectedCommandId(aValue: Integer);
begin
  if Initialized then
    FBaseIntf.Set_SelectedCommandId(aValue);
end;

procedure TCoreWebView2ContextMenuRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2ServerCertificateErrorDetectedEventArgs

constructor TCoreWebView2ServerCertificateErrorDetectedEventArgs.Create(const aArgs: ICoreWebView2ServerCertificateErrorDetectedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ServerCertificateErrorDetectedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetErrorStatus : TWVWebErrorStatus;
var
  TempResult : COREWEBVIEW2_WEB_ERROR_STATUS;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_ErrorStatus(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetRequestUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_RequestUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetServerCertificate : ICoreWebView2Certificate;
var
  TempResult : ICoreWebView2Certificate;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ServerCertificate(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetAction : TWVServerCertificateErrorAction;
var
  TempResult : COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Action(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2ServerCertificateErrorDetectedEventArgs.SetAction(aValue: TWVServerCertificateErrorAction);
begin
  if Initialized then
    FBaseIntf.Set_Action(aValue);
end;


// TCoreWebView2LaunchingExternalUriSchemeEventArgs

constructor TCoreWebView2LaunchingExternalUriSchemeEventArgs.Create(const aArgs: ICoreWebView2LaunchingExternalUriSchemeEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2LaunchingExternalUriSchemeEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2LaunchingExternalUriSchemeEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2LaunchingExternalUriSchemeEventArgs.GetUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Uri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2LaunchingExternalUriSchemeEventArgs.GetInitiatingOrigin : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_InitiatingOrigin(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2LaunchingExternalUriSchemeEventArgs.GetIsUserInitiated: boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsUserInitiated(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2LaunchingExternalUriSchemeEventArgs.GetCancel: boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2LaunchingExternalUriSchemeEventArgs.GetDeferral: ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2LaunchingExternalUriSchemeEventArgs.SetCancel(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;


// TCoreWebView2NonClientRegionChangedEventArgs

constructor TCoreWebView2NonClientRegionChangedEventArgs.Create(const aArgs: ICoreWebView2NonClientRegionChangedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2NonClientRegionChangedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2NonClientRegionChangedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NonClientRegionChangedEventArgs.GetRegionKind : TWVNonClientRegionKind;
var
  TempResult : COREWEBVIEW2_NON_CLIENT_REGION_KIND;
begin
  Result := COREWEBVIEW2_NON_CLIENT_REGION_KIND_NOWHERE;

  if Initialized and
     succeeded(FBaseIntf.Get_RegionKind(TempResult)) then
    Result := TempResult;
end;


// TCoreWebView2NotificationReceivedEventArgs

constructor TCoreWebView2NotificationReceivedEventArgs.Create(const aArgs: ICoreWebView2NotificationReceivedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2NotificationReceivedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2NotificationReceivedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NotificationReceivedEventArgs.GetSenderOrigin : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_SenderOrigin(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2NotificationReceivedEventArgs.GetNotification : ICoreWebView2Notification;
var
  TempResult : ICoreWebView2Notification;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Notification(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2NotificationReceivedEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2NotificationReceivedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2NotificationReceivedEventArgs.SetHandled(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2SaveAsUIShowingEventArgs

constructor TCoreWebView2SaveAsUIShowingEventArgs.Create(const aArgs: ICoreWebView2SaveAsUIShowingEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2SaveAsUIShowingEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetContentMimeType : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ContentMimeType(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetSuppressDefaultDialog : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_SuppressDefaultDialog(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetSaveAsFilePath : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_SaveAsFilePath(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetAllowReplace : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AllowReplace(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2SaveAsUIShowingEventArgs.GetKind : TWVSaveAsKind;
var
  TempResult : COREWEBVIEW2_SAVE_AS_KIND;
begin
  Result := COREWEBVIEW2_SAVE_AS_KIND_DEFAULT;

  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempResult)) then
    Result := TempResult;
end;

procedure TCoreWebView2SaveAsUIShowingEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;

procedure TCoreWebView2SaveAsUIShowingEventArgs.SetSuppressDefaultDialog(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_SuppressDefaultDialog(ord(aValue));
end;

procedure TCoreWebView2SaveAsUIShowingEventArgs.SetSaveAsFilePath(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_SaveAsFilePath(PWideChar(aValue));
end;

procedure TCoreWebView2SaveAsUIShowingEventArgs.SetAllowReplace(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AllowReplace(ord(aValue));
end;

procedure TCoreWebView2SaveAsUIShowingEventArgs.SetKind(aValue : TWVSaveAsKind);
begin
  if Initialized then
    FBaseIntf.Set_Kind(aValue);
end;


// TCoreWebView2SaveFileSecurityCheckStartingEventArgs

constructor TCoreWebView2SaveFileSecurityCheckStartingEventArgs.Create(const aArgs: ICoreWebView2SaveFileSecurityCheckStartingEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2SaveFileSecurityCheckStartingEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventArgs.GetCancelSave : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_CancelSave(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventArgs.GetDocumentOriginUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DocumentOriginUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventArgs.GetFileExtension : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_FileExtension(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventArgs.GetFilePath : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_FilePath(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventArgs.GetSuppressDefaultPolicy : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_SuppressDefaultPolicy(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2SaveFileSecurityCheckStartingEventArgs.SetCancelSave(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_CancelSave(ord(aValue));
end;

procedure TCoreWebView2SaveFileSecurityCheckStartingEventArgs.SetSuppressDefaultPolicy(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_SuppressDefaultPolicy(ord(aValue));
end;


// TCoreWebView2ScreenCaptureStartingEventArgs

constructor TCoreWebView2ScreenCaptureStartingEventArgs.Create(const aArgs: ICoreWebView2ScreenCaptureStartingEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ScreenCaptureStartingEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ScreenCaptureStartingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ScreenCaptureStartingEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ScreenCaptureStartingEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ScreenCaptureStartingEventArgs.GetCoreWebView2FrameInfo : ICoreWebView2FrameInfo;
var
  TempResult : ICoreWebView2FrameInfo;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_OriginalSourceFrameInfo(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ScreenCaptureStartingEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2ScreenCaptureStartingEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;

procedure TCoreWebView2ScreenCaptureStartingEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;

end.
