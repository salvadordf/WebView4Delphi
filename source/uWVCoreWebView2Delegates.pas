unit uWVCoreWebView2Delegates;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  WinApi.Windows, Winapi.ActiveX,
  {$ELSE}
  Windows, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVInterfaces, uWVTypes;

type
  /// <summary>
  /// Receives AcceleratorKeyPressed events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventhandler">See the ICoreWebView2AcceleratorKeyPressedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2AcceleratorKeyPressedEventHandler = class(TInterfacedObject, ICoreWebView2AcceleratorKeyPressedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2AcceleratorKeyPressedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the CapturePreview method.  The result is written
  /// to the stream provided in the CapturePreview method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2capturepreviewcompletedhandler">See the ICoreWebView2CapturePreviewCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2CapturePreviewCompletedHandler = class(TInterfacedObject, ICoreWebView2CapturePreviewCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives ContainsFullScreenElementChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2containsfullscreenelementchangedeventhandler">See the ICoreWebView2ContainsFullScreenElementChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ContainsFullScreenElementChangedEventHandler = class(TInterfacedObject, ICoreWebView2ContainsFullScreenElementChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `ContentLoading` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contentloadingeventhandler">See the ICoreWebView2ContentLoadingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ContentLoadingEventHandler = class(TInterfacedObject, ICoreWebView2ContentLoadingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the CoreWebView2Controller created using CreateCoreWebView2Controller.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2controllercompletedhandler">See the ICoreWebView2CreateCoreWebView2ControllerCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2CreateCoreWebView2ControllerCompletedHandler = class(TInterfacedObject, ICoreWebView2CreateCoreWebView2ControllerCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2Controller): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives DevToolsProtocolEventReceived events from the WebView.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventhandler">See the ICoreWebView2DevToolsProtocolEventReceivedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2DevToolsProtocolEventReceivedEventHandler = class(TInterfacedObject, ICoreWebView2DevToolsProtocolEventReceivedEventHandler)
    protected
      FEvents     : Pointer;
      FEventName  : wvstring;
      FEventID    : integer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DevToolsProtocolEventReceivedEventArgs): HResult; stdcall;

    public
      Token : EventRegistrationToken;

      constructor Create(const aEvents: IWVBrowserEvents; const aEventName : wvstring; aEventID : integer); reintroduce;
      destructor  Destroy; override;

      property EventName : wvstring   read FEventName;
      property EventID   : integer  read FEventID;
  end;

  /// <summary>
  /// Receives DocumentTitleChanged events.  Use the DocumentTitle property
  /// to get the modified title.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2documenttitlechangedeventhandler">See the ICoreWebView2DocumentTitleChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2DocumentTitleChangedEventHandler = class(TInterfacedObject, ICoreWebView2DocumentTitleChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the WebView2Environment created using
  /// CreateCoreWebView2Environment.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2environmentcompletedhandler">See the ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2EnvironmentCompletedHandler = class(TInterfacedObject, ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler)
    protected
      FBrowserEvents : Pointer;
      FLoaderEvents  : Pointer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2Environment): HResult; stdcall;

    public
      constructor Create(const aBrowserEvents: IWVBrowserEvents); reintroduce; overload;
      constructor Create(const aLoaderEvents: IWVLoaderEvents); reintroduce; overload;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the ExecuteScript method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2executescriptcompletedhandler">See the ICoreWebView2ExecuteScriptCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ExecuteScriptCompletedHandler = class(TInterfacedObject, ICoreWebView2ExecuteScriptCompletedHandler)
    protected
      FEvents : Pointer;
      FID     : integer;

      function Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aExecutionID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NavigationCompleted events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventhandler">See the ICoreWebView2NavigationCompletedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameNavigationCompletedEventHandler = class(TInterfacedObject, ICoreWebView2NavigationCompletedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NavigationStarting events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventhandler">See the ICoreWebView2NavigationStartingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameNavigationStartingEventHandler = class(TInterfacedObject, ICoreWebView2NavigationStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives GotFocus and LostFocus events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2focuschangedeventhandler">See the ICoreWebView2FocusChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2GotFocusEventHandler = class(TInterfacedObject, ICoreWebView2FocusChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives HistoryChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2historychangedeventhandler">See the ICoreWebView2HistoryChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2HistoryChangedEventHandler = class(TInterfacedObject, ICoreWebView2HistoryChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives GotFocus and LostFocus events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2focuschangedeventhandler">See the ICoreWebView2FocusChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2LostFocusEventHandler = class(TInterfacedObject, ICoreWebView2FocusChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives MoveFocusRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2movefocusrequestedeventhandler">See the ICoreWebView2MoveFocusRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2MoveFocusRequestedEventHandler = class(TInterfacedObject, ICoreWebView2MoveFocusRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2MoveFocusRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NavigationCompleted events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventhandler">See the ICoreWebView2NavigationCompletedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2NavigationCompletedEventHandler = class(TInterfacedObject, ICoreWebView2NavigationCompletedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NavigationStarting events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventhandler">See the ICoreWebView2NavigationStartingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2NavigationStartingEventHandler = class(TInterfacedObject, ICoreWebView2NavigationStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NewBrowserVersionAvailable events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newbrowserversionavailableeventhandler">See the ICoreWebView2NewBrowserVersionAvailableEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2NewBrowserVersionAvailableEventHandler = class(TInterfacedObject, ICoreWebView2NewBrowserVersionAvailableEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVLoaderEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NewWindowRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventhandler">See the ICoreWebView2NewWindowRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2NewWindowRequestedEventHandler = class(TInterfacedObject, ICoreWebView2NewWindowRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NewWindowRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives PermissionRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventhandler">See the ICoreWebView2PermissionRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2PermissionRequestedEventHandler = class(TInterfacedObject, ICoreWebView2PermissionRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2PermissionRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives ProcessFailed events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventhandler">See the ICoreWebView2ProcessFailedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ProcessFailedEventHandler = class(TInterfacedObject, ICoreWebView2ProcessFailedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives ScriptDialogOpening events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventhandler">See the ICoreWebView2ScriptDialogOpeningEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ScriptDialogOpeningEventHandler = class(TInterfacedObject, ICoreWebView2ScriptDialogOpeningEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScriptDialogOpeningEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives SourceChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sourcechangedeventhandler">See the ICoreWebView2SourceChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2SourceChangedEventHandler = class(TInterfacedObject, ICoreWebView2SourceChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SourceChangedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives WebMessageReceived events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventhandler">See the ICoreWebView2WebMessageReceivedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2WebMessageReceivedEventHandler = class(TInterfacedObject, ICoreWebView2WebMessageReceivedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Runs when a URL request (through network, file, and so on) is made in
  /// the webview for a Web resource matching resource context filter and URL
  /// specified in AddWebResourceRequestedFilter.  The host views and modifies
  /// the request or provide a response in a similar pattern to HTTP, in which
  /// case the request immediately completed.  This may not contain any request
  /// headers that are added by the network stack, such as an Authorization
  /// header.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventhandler">See the ICoreWebView2WebResourceRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceRequestedEventHandler = class(TInterfacedObject, ICoreWebView2WebResourceRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives WindowCloseRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowcloserequestedeventhandler">See the ICoreWebView2WindowCloseRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2WindowCloseRequestedEventHandler = class(TInterfacedObject, ICoreWebView2WindowCloseRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Implements the interface to receive ZoomFactorChanged events.  Use the
  /// ICoreWebView2Controller.ZoomFactor property to get the modified zoom
  /// factor.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2zoomfactorchangedeventhandler">See the ICoreWebView2ZoomFactorChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ZoomFactorChangedEventHandler = class(TInterfacedObject, ICoreWebView2ZoomFactorChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to receive the CoreWebView2Controller
  /// created via CreateCoreWebView2CompositionController.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2compositioncontrollercompletedhandler">See the ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler = class(TInterfacedObject, ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2CompositionController): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to receive CursorChanged events. Use
  /// the Cursor property to get the new cursor.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cursorchangedeventhandler">See the ICoreWebView2CursorChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2CursorChangedEventHandler = class(TInterfacedObject, ICoreWebView2CursorChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2CompositionController; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives BrowserProcessExited events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserprocessexitedeventhandler">See the ICoreWebView2BrowserProcessExitedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2BrowserProcessExitedEventHandler = class(TInterfacedObject, ICoreWebView2BrowserProcessExitedEventHandler)
    protected
      FBrowserEvents : Pointer;
      FLoaderEvents  : Pointer;

      function Invoke(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs): HResult; stdcall;

    public
      constructor Create(const aBrowserEvents: IWVBrowserEvents); reintroduce; overload;
      constructor Create(const aLoaderEvents: IWVLoaderEvents); reintroduce; overload;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives RasterizationScaleChanged events.  Use the RasterizationScale
  /// property to get the modified scale.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2rasterizationscalechangedeventhandler">See the ICoreWebView2RasterizationScaleChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2RasterizationScaleChangedEventHandler = class(TInterfacedObject, ICoreWebView2RasterizationScaleChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives WebResourceResponseReceived events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponsereceivedeventhandler">See the ICoreWebView2WebResourceResponseReceivedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceResponseReceivedEventHandler = class(TInterfacedObject, ICoreWebView2WebResourceResponseReceivedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives DOMContentLoaded events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2domcontentloadedeventhandler">See the ICoreWebView2DOMContentLoadedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2DOMContentLoadedEventHandler = class(TInterfacedObject, ICoreWebView2DOMContentLoadedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the ICoreWebView2WebResourceResponseView.GetContent method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseviewgetcontentcompletedhandler">See the ICoreWebView2WebResourceResponseViewGetContentCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceResponseViewGetContentCompletedHandler = class(TInterfacedObject, ICoreWebView2WebResourceResponseViewGetContentCompletedHandler)
    protected
      FEvents     : Pointer;
      FResourceID : integer;

      function Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aResourceID : integer = 0); reintroduce;
      destructor  Destroy; override;

      property ResourceID : integer read FResourceID;
  end;

  /// <summary>
  /// Receives the result of the GetCookies method.  The result is written to
  /// the cookie list provided in the GetCookies method call.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getcookiescompletedhandler">See the ICoreWebView2GetCookiesCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2GetCookiesCompletedHandler = class(TInterfacedObject, ICoreWebView2GetCookiesCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode : HResult; const result_ : ICoreWebView2CookieList): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to receive the TrySuspend result.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2trysuspendcompletedhandler">See the ICoreWebView2TrySuspendCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2TrySuspendCompletedHandler = class(TInterfacedObject, ICoreWebView2TrySuspendCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; result_: Integer): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives FrameCreated event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecreatedeventhandler">See the ICoreWebView2FrameCreatedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameCreatedEventHandler = class(TInterfacedObject, ICoreWebView2FrameCreatedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Add an event handler for the DownloadStarting event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventhandler">See the ICoreWebView2DownloadStartingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2DownloadStartingEventHandler = class(TInterfacedObject, ICoreWebView2DownloadStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// An event handler for the ClientCertificateRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventhandler">See the ICoreWebView2ClientCertificateRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ClientCertificateRequestedEventHandler = class(TInterfacedObject, ICoreWebView2ClientCertificateRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the PrintToPdf method. If the print to PDF
  /// operation succeeds, isSuccessful is true. Otherwise, if the operation
  /// failed, isSuccessful is set to false. An invalid path returns
  /// E_INVALIDARG.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printtopdfcompletedhandler">See the ICoreWebView2PrintToPdfCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2PrintToPdfCompletedHandler = class(TInterfacedObject, ICoreWebView2PrintToPdfCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; result_: Integer): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Implements the interface to receive BytesReceivedChanged event.  Use the
  /// ICoreWebView2DownloadOperation.BytesReceived property to get the received
  /// bytes count.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2bytesreceivedchangedeventhandler">See the ICoreWebView2BytesReceivedChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2BytesReceivedChangedEventHandler = class(TInterfacedObject, ICoreWebView2BytesReceivedChangedEventHandler)
    protected
      FEvents     : Pointer;
      FDownloadID : integer;

      function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Implements the interface to receive EstimatedEndTimeChanged event. Use the
  /// ICoreWebView2DownloadOperation.EstimatedEndTime property to get the new
  /// estimated end time.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2estimatedendtimechangedeventhandler">See the ICoreWebView2EstimatedEndTimeChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2EstimatedEndTimeChangedEventHandler = class(TInterfacedObject, ICoreWebView2EstimatedEndTimeChangedEventHandler)
    protected
      FEvents     : Pointer;
      FDownloadID : integer;

      function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Implements the interface to receive StateChanged event. Use the
  /// ICoreWebView2DownloadOperation.State property to get the current state,
  /// which can be in progress, interrupted, or completed. Use the
  /// ICoreWebView2DownloadOperation.InterruptReason property to get the
  /// interrupt reason if the download is interrupted.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2statechangedeventhandler">See the ICoreWebView2StateChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2StateChangedEventHandler = class(TInterfacedObject, ICoreWebView2StateChangedEventHandler)
    protected
      FEvents     : Pointer;
      FDownloadID : integer;

      function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives FrameNameChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenamechangedeventhandler">See the ICoreWebView2FrameNameChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameNameChangedEventHandler = class(TInterfacedObject, ICoreWebView2FrameNameChangedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives FrameDestroyed event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framedestroyedeventhandler">See the ICoreWebView2FrameDestroyedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameDestroyedEventHandler = class(TInterfacedObject, ICoreWebView2FrameDestroyedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives CallDevToolsProtocolMethod completion results.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2calldevtoolsprotocolmethodcompletedhandler">See the ICoreWebView2CallDevToolsProtocolMethodCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2CallDevToolsProtocolMethodCompletedHandler = class(TInterfacedObject, ICoreWebView2CallDevToolsProtocolMethodCompletedHandler)
    protected
      FEvents : Pointer;
      FID     : integer;

      function Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aExecutionID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the AddScriptToExecuteOnDocumentCreated method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2addscripttoexecuteondocumentcreatedcompletedhandler">See the ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler = class(TInterfacedObject, ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Implements the interface to receive IsMutedChanged events.  Use the
  /// IsMuted property to get the mute state.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2ismutedchangedeventhandler">See the ICoreWebView2IsMutedChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2IsMutedChangedEventHandler = class(TInterfacedObject, ICoreWebView2IsMutedChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Implements the interface to receive IsDocumentPlayingAudioChanged events.  Use the
  /// IsDocumentPlayingAudio property to get the audio playing state.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2isdocumentplayingaudiochangedeventhandler">See the ICoreWebView2IsDocumentPlayingAudioChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2IsDocumentPlayingAudioChangedEventHandler = class(TInterfacedObject, ICoreWebView2IsDocumentPlayingAudioChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Implements the interface to receive IsDefaultDownloadDialogOpenChanged
  /// events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2isdefaultdownloaddialogopenchangedeventhandler">See the ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler = class(TInterfacedObject, ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// An event handler for the ProcessInfosChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfoschangedeventhandler">See the ICoreWebView2ProcessInfosChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ProcessInfosChangedEventHandler = class(TInterfacedObject, ICoreWebView2ProcessInfosChangedEventHandler)
    protected
      FBrowserEvents : Pointer;
      FLoaderEvents  : Pointer;

      function Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aBrowserEvents: IWVBrowserEvents); reintroduce; overload;
      constructor Create(const aLoaderEvents: IWVLoaderEvents); reintroduce; overload;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NavigationCompleted events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenavigationcompletedeventhandler">See the ICoreWebView2FrameNavigationCompletedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameNavigationCompletedEventHandler2 = class(TInterfacedObject, ICoreWebView2FrameNavigationCompletedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives NavigationStarting events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenavigationstartingeventhandler">See the ICoreWebView2FrameNavigationStartingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameNavigationStartingEventHandler2 = class(TInterfacedObject, ICoreWebView2FrameNavigationStartingEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives ContentLoading events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecontentloadingeventhandler">See the ICoreWebView2FrameContentLoadingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameContentLoadingEventHandler = class(TInterfacedObject, ICoreWebView2FrameContentLoadingEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives DOMContentLoaded events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framedomcontentloadedeventhandler">See the ICoreWebView2FrameDOMContentLoadedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameDOMContentLoadedEventHandler = class(TInterfacedObject, ICoreWebView2FrameDOMContentLoadedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives WebMessageReceived events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framewebmessagereceivedeventhandler">See the ICoreWebView2FrameWebMessageReceivedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameWebMessageReceivedEventHandler = class(TInterfacedObject, ICoreWebView2FrameWebMessageReceivedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to handle the BasicAuthenticationRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventhandler">See the ICoreWebView2BasicAuthenticationRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2BasicAuthenticationRequestedEventHandler = class(TInterfacedObject, ICoreWebView2BasicAuthenticationRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2BasicAuthenticationRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives ContextMenuRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventhandler">See the ICoreWebView2ContextMenuRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ContextMenuRequestedEventHandler = class(TInterfacedObject, ICoreWebView2ContextMenuRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContextMenuRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Raised to notify the host that the end user selected a custom
  /// ContextMenuItem. CustomItemSelected event is raised on the specific
  /// ContextMenuItem that the end user selected.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customitemselectedeventhandler">See the ICoreWebView2CustomItemSelectedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2CustomItemSelectedEventHandler = class(TInterfacedObject, ICoreWebView2CustomItemSelectedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2ContextMenuItem; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives StatusBarTextChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2statusbartextchangedeventhandler">See the ICoreWebView2StatusBarTextChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2StatusBarTextChangedEventHandler = class(TInterfacedObject, ICoreWebView2StatusBarTextChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives PermissionRequested events for iframes.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framepermissionrequestedeventhandler">See the ICoreWebView2FramePermissionRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FramePermissionRequestedEventHandler = class(TInterfacedObject, ICoreWebView2FramePermissionRequestedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2PermissionRequestedEventArgs2): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

    /// <summary>
    /// The caller implements this interface to receive the ClearBrowsingData result.
    /// </summary>
    /// <remarks>
    /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clearbrowsingdatacompletedhandler">See the ICoreWebView2ClearBrowsingDataCompletedHandler article.</see></para>
    /// </remarks>
  TCoreWebView2ClearBrowsingDataCompletedHandler = class(TInterfacedObject, ICoreWebView2ClearBrowsingDataCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the ClearServerCertificateErrorActions method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clearservercertificateerroractionscompletedhandler">See the ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler = class(TInterfacedObject, ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// An event handler for the ServerCertificateErrorDetected event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventhandler">See the ICoreWebView2ServerCertificateErrorDetectedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ServerCertificateErrorDetectedEventHandler = class(TInterfacedObject, ICoreWebView2ServerCertificateErrorDetectedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ServerCertificateErrorDetectedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// This interface is a handler for when the Favicon is changed.
  /// The sender is the ICoreWebView2 object the top-level document of
  /// which has changed favicon and the eventArgs is nullptr. Use the
  /// FaviconUri property and GetFavicon method to obtain the favicon
  /// data. The second argument is always null.
  /// For more information see add_FaviconChanged.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2faviconchangedeventhandler">See the ICoreWebView2FaviconChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FaviconChangedEventHandler = class(TInterfacedObject, ICoreWebView2FaviconChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// This interface is a handler for when the Favicon is changed.
  /// The sender is the ICoreWebView2 object the top-level document of
  /// which has changed favicon and the eventArgs is nullptr. Use the
  /// FaviconUri property and GetFavicon method to obtain the favicon
  /// data. The second argument is always null.
  /// For more information see add_FaviconChanged.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2faviconchangedeventhandler">See the ICoreWebView2FaviconChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2GetFaviconCompletedHandler = class(TInterfacedObject, ICoreWebView2GetFaviconCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the Print method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printcompletedhandler">See the ICoreWebView2PrintCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2PrintCompletedHandler = class(TInterfacedObject, ICoreWebView2PrintCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; result_: COREWEBVIEW2_PRINT_STATUS): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the PrintToPdfStream method.
  /// errorCode returns S_OK if the PrintToPdfStream operation succeeded.
  /// The printable pdf data is returned in the pdfStream object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printtopdfstreamcompletedhandler">See the ICoreWebView2PrintToPdfStreamCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2PrintToPdfStreamCompletedHandler = class(TInterfacedObject, ICoreWebView2PrintToPdfStreamCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to handle the result of
  /// GetNonDefaultPermissionSettings.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getnondefaultpermissionsettingscompletedhandler">See the ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler = class(TInterfacedObject, ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2PermissionSettingCollectionView): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to handle the result of
  /// SetPermissionState.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2setpermissionstatecompletedhandler">See the ICoreWebView2SetPermissionStateCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2SetPermissionStateCompletedHandler = class(TInterfacedObject, ICoreWebView2SetPermissionStateCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Event handler for the LaunchingExternalUriScheme event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventhandler">See the ICoreWebView2LaunchingExternalUriSchemeEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2LaunchingExternalUriSchemeEventHandler = class(TInterfacedObject, ICoreWebView2LaunchingExternalUriSchemeEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2LaunchingExternalUriSchemeEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the `GetProcessExtendedInfos` method.
  /// The result is written to the collection of `ProcessExtendedInfo`s provided
  /// in the `GetProcessExtendedInfos` method call.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getprocessextendedinfoscompletedhandler">See the ICoreWebView2GetProcessExtendedInfosCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2GetProcessExtendedInfosCompletedHandler = class(TInterfacedObject, ICoreWebView2GetProcessExtendedInfosCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2ProcessExtendedInfoCollection): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to receive the result of removing
  /// the browser Extension from the Profile.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionremovecompletedhandler">See the ICoreWebView2BrowserExtensionRemoveCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2BrowserExtensionRemoveCompletedHandler = class(TInterfacedObject, ICoreWebView2BrowserExtensionRemoveCompletedHandler)
    protected
      FEvents : Pointer;
      FID     : wvstring;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; const aExtensionID: wvstring); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to receive the result of setting the
  /// browser Extension as enabled or disabled. If enabled, the browser Extension is
  /// running in WebView instances. If disabled, the browser Extension is not running in WebView instances.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionenablecompletedhandler">See the ICoreWebView2BrowserExtensionEnableCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2BrowserExtensionEnableCompletedHandler = class(TInterfacedObject, ICoreWebView2BrowserExtensionEnableCompletedHandler)
    protected
      FEvents : Pointer;
      FID     : wvstring;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; const aExtensionID: wvstring); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to receive the result
  /// of loading an browser Extension.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profileaddbrowserextensioncompletedhandler">See the ICoreWebView2ProfileAddBrowserExtensionCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ProfileAddBrowserExtensionCompletedHandler = class(TInterfacedObject, ICoreWebView2ProfileAddBrowserExtensionCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtension): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// The caller implements this interface to receive the result of
  /// getting the browser Extensions.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profilegetbrowserextensionscompletedhandler">See the ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ProfileGetBrowserExtensionsCompletedHandler = class(TInterfacedObject, ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtensionList): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the `CoreWebView2Profile.Deleted` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profiledeletedeventhandler">See the ICoreWebView2ProfileDeletedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ProfileDeletedEventHandler = class(TInterfacedObject, ICoreWebView2ProfileDeletedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Profile; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// This is the callback for ExecuteScriptWithResult
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2executescriptwithresultcompletedhandler">See the ICoreWebView2ExecuteScriptWithResultCompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ExecuteScriptWithResultCompletedHandler = class(TInterfacedObject, ICoreWebView2ExecuteScriptWithResultCompletedHandler)
    protected
      FEvents : Pointer;
      FID     : integer;

      function Invoke(errorCode: HResult; const result_: ICoreWebView2ExecuteScriptResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aExecutionID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `NonClientRegionChanged` events.
  /// event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2nonclientregionchangedeventhandler">See the ICoreWebView2NonClientRegionChangedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2NonClientRegionChangedEventHandler = class(TInterfacedObject, ICoreWebView2NonClientRegionChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2CompositionController;
                      const args: ICoreWebView2NonClientRegionChangedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `NotificationReceived` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notificationreceivedeventhandler">See the ICoreWebView2NotificationReceivedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2NotificationReceivedEventHandler = class(TInterfacedObject, ICoreWebView2NotificationReceivedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2;
                      const args: ICoreWebView2NotificationReceivedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `CloseRequested` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notificationcloserequestedeventhandler">See the ICoreWebView2NotificationCloseRequestedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2NotificationCloseRequestedEventHandler = class(TInterfacedObject, ICoreWebView2NotificationCloseRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Notification; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `SaveAsUIShowing` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2saveasuishowingeventhandler">See the ICoreWebView2SaveAsUIShowingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2SaveAsUIShowingEventHandler = class(TInterfacedObject, ICoreWebView2SaveAsUIShowingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveAsUIShowingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives the result of the `ShowSaveAsUI` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2showsaveasuicompletedhandler">See the ICoreWebView2ShowSaveAsUICompletedHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ShowSaveAsUICompletedHandler = class(TInterfacedObject, ICoreWebView2ShowSaveAsUICompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; result_: COREWEBVIEW2_SAVE_AS_UI_RESULT): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `SaveFileSecurityCheckStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2savefilesecuritycheckstartingeventhandler">See the ICoreWebView2SaveFileSecurityCheckStartingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2SaveFileSecurityCheckStartingEventHandler = class(TInterfacedObject, ICoreWebView2SaveFileSecurityCheckStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveFileSecurityCheckStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `ScreenCaptureStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2screencapturestartingeventhandler">See the ICoreWebView2ScreenCaptureStartingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2ScreenCaptureStartingEventHandler = class(TInterfacedObject, ICoreWebView2ScreenCaptureStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScreenCaptureStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `ScreenCaptureStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framescreencapturestartingeventhandler">See the ICoreWebView2FrameScreenCaptureStartingEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameScreenCaptureStartingEventHandler = class(TInterfacedObject, ICoreWebView2FrameScreenCaptureStartingEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ScreenCaptureStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

  /// <summary>
  /// Receives `FrameCreated` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framechildframecreatedeventhandler">See the ICoreWebView2FrameChildFrameCreatedEventHandler article.</see></para>
  /// </remarks>
  TCoreWebView2FrameChildFrameCreatedEventHandler = class(TInterfacedObject, ICoreWebView2FrameChildFrameCreatedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : cardinal;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2FrameCreatedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal); reintroduce;
      destructor  Destroy; override;
  end;

implementation


// TCoreWebView2AcceleratorKeyPressedEventHandler

constructor TCoreWebView2AcceleratorKeyPressedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2AcceleratorKeyPressedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2AcceleratorKeyPressedEventHandler.Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2AcceleratorKeyPressedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).AcceleratorKeyPressedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2CapturePreviewCompletedHandler

constructor TCoreWebView2CapturePreviewCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2CapturePreviewCompletedHandler.Destroy;
begin
  inherited Destroy;

  FEvents := nil;
end;

function TCoreWebView2CapturePreviewCompletedHandler.Invoke(errorCode: HResult): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).CapturePreviewCompletedHandler_Invoke(errorCode)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ContainsFullScreenElementChangedEventHandler

constructor TCoreWebView2ContainsFullScreenElementChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ContainsFullScreenElementChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ContainsFullScreenElementChangedEventHandler.Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ContainsFullScreenElementChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ContentLoadingEventHandler

constructor TCoreWebView2ContentLoadingEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ContentLoadingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ContentLoadingEventHandler.Invoke(const sender : ICoreWebView2;
                                                        const args   : ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ContentLoadingEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2CreateCoreWebView2ControllerCompletedHandler

constructor TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Invoke(errorCode: HResult; const result_: ICoreWebView2Controller): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ControllerCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2DevToolsProtocolEventReceivedEventHandler

constructor TCoreWebView2DevToolsProtocolEventReceivedEventHandler.Create(const aEvents: IWVBrowserEvents; const aEventName : wvstring; aEventID : integer);
begin
  inherited Create;

  FEvents    := Pointer(aEvents);
  FEventName := aEventName;
  FEventID   := aEventID;
end;

destructor TCoreWebView2DevToolsProtocolEventReceivedEventHandler.Destroy;
begin
  inherited Destroy;

  FEvents := nil;
end;

function TCoreWebView2DevToolsProtocolEventReceivedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DevToolsProtocolEventReceivedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).DevToolsProtocolEventReceivedEventHandler_Invoke(sender, args, FEventName, FEventID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2DocumentTitleChangedEventHandler

constructor TCoreWebView2DocumentTitleChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2DocumentTitleChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2DocumentTitleChangedEventHandler.Invoke(const sender : ICoreWebView2;
                                                              const args   : IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).DocumentTitleChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2EnvironmentCompletedHandler

constructor TCoreWebView2EnvironmentCompletedHandler.Create(const aBrowserEvents: IWVBrowserEvents);
begin
  inherited Create;

  FBrowserEvents := Pointer(aBrowserEvents);
  FLoaderEvents  := nil;
end;

constructor TCoreWebView2EnvironmentCompletedHandler.Create(const aLoaderEvents: IWVLoaderEvents);
begin
  inherited Create;

  FBrowserEvents := nil;
  FLoaderEvents  := Pointer(aLoaderEvents);
end;

destructor TCoreWebView2EnvironmentCompletedHandler.Destroy;
begin
  FBrowserEvents := nil;
  FLoaderEvents  := nil;

  inherited Destroy;
end;

function TCoreWebView2EnvironmentCompletedHandler.Invoke(      errorCode : HResult;
                                                         const result_   : ICoreWebView2Environment): HResult;
begin
  if (FBrowserEvents <> nil) then
    Result := IWVBrowserEvents(FBrowserEvents).EnvironmentCompletedHandler_Invoke(errorCode, result_)
   else
    if (FLoaderEvents <> nil) then
      Result := IWVLoaderEvents(FLoaderEvents).EnvironmentCompletedHandler_Invoke(errorCode, result_)
     else
      Result := E_FAIL;
end;


// TCoreWebView2ExecuteScriptCompletedHandler

constructor TCoreWebView2ExecuteScriptCompletedHandler.Create(const aEvents: IWVBrowserEvents; aExecutionID : integer);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
  FID     := aExecutionID;
end;

destructor TCoreWebView2ExecuteScriptCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ExecuteScriptCompletedHandler.Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ExecuteScriptCompletedHandler_Invoke(errorCode, result_, FID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameNavigationCompletedEventHandler

constructor TCoreWebView2FrameNavigationCompletedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2FrameNavigationCompletedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameNavigationCompletedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameNavigationCompletedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameNavigationStartingEventHandler

constructor TCoreWebView2FrameNavigationStartingEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2FrameNavigationStartingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameNavigationStartingEventHandler.Invoke(const sender : ICoreWebView2;
                                                                 const args   : ICoreWebView2NavigationStartingEventArgs): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameNavigationStartingEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2GotFocusEventHandler

constructor TCoreWebView2GotFocusEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2GotFocusEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2GotFocusEventHandler.Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GotFocusEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2HistoryChangedEventHandler

constructor TCoreWebView2HistoryChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2HistoryChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2HistoryChangedEventHandler.Invoke(const sender : ICoreWebView2;
                                                        const args   : IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).HistoryChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2LostFocusEventHandler

constructor TCoreWebView2LostFocusEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2LostFocusEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2LostFocusEventHandler.Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).LostFocusEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2MoveFocusRequestedEventHandler

constructor TCoreWebView2MoveFocusRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2MoveFocusRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2MoveFocusRequestedEventHandler.Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2MoveFocusRequestedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).MoveFocusRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2NavigationCompletedEventHandler

constructor TCoreWebView2NavigationCompletedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2NavigationCompletedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2NavigationCompletedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).NavigationCompletedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2NavigationStartingEventHandler

constructor TCoreWebView2NavigationStartingEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2NavigationStartingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2NavigationStartingEventHandler.Invoke(const sender : ICoreWebView2;
                                                            const args   : ICoreWebView2NavigationStartingEventArgs): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).NavigationStartingEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2NewBrowserVersionAvailableEventHandler

constructor TCoreWebView2NewBrowserVersionAvailableEventHandler.Create(const aEvents: IWVLoaderEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2NewBrowserVersionAvailableEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2NewBrowserVersionAvailableEventHandler.Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVLoaderEvents(FEvents).NewBrowserVersionAvailableEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2NewWindowRequestedEventHandler

constructor TCoreWebView2NewWindowRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2NewWindowRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2NewWindowRequestedEventHandler.Invoke(const sender : ICoreWebView2;
                                                            const args   : ICoreWebView2NewWindowRequestedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).NewWindowRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2PermissionRequestedEventHandler

constructor TCoreWebView2PermissionRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2PermissionRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2PermissionRequestedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2PermissionRequestedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).PermissionRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ProcessFailedEventHandler

constructor TCoreWebView2ProcessFailedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ProcessFailedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ProcessFailedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ProcessFailedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ScriptDialogOpeningEventHandler

constructor TCoreWebView2ScriptDialogOpeningEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ScriptDialogOpeningEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ScriptDialogOpeningEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScriptDialogOpeningEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ScriptDialogOpeningEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2SourceChangedEventHandler

constructor TCoreWebView2SourceChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2SourceChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2SourceChangedEventHandler.Invoke(const sender : ICoreWebView2;
                                                       const args   : ICoreWebView2SourceChangedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).SourceChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2WebMessageReceivedEventHandler

constructor TCoreWebView2WebMessageReceivedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2WebMessageReceivedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2WebMessageReceivedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).WebMessageReceivedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2WebResourceRequestedEventHandler

constructor TCoreWebView2WebResourceRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2WebResourceRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceRequestedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceRequestedEventArgs): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).WebResourceRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2WindowCloseRequestedEventHandler

constructor TCoreWebView2WindowCloseRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2WindowCloseRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2WindowCloseRequestedEventHandler.Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).WindowCloseRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ZoomFactorChangedEventHandler

constructor TCoreWebView2ZoomFactorChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ZoomFactorChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ZoomFactorChangedEventHandler.Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ZoomFactorChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler

constructor TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Invoke(errorCode: HResult; const result_: ICoreWebView2CompositionController): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).CreateCoreWebView2CompositionControllerCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// ICoreWebView2CursorChangedEventHandler

constructor TCoreWebView2CursorChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2CursorChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2CursorChangedEventHandler.Invoke(const sender: ICoreWebView2CompositionController; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).CursorChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2BrowserProcessExitedEventHandler

constructor TCoreWebView2BrowserProcessExitedEventHandler.Create(const aBrowserEvents: IWVBrowserEvents);
begin
  inherited Create;

  FBrowserEvents := Pointer(aBrowserEvents);
  FLoaderEvents  := nil;
end;

constructor TCoreWebView2BrowserProcessExitedEventHandler.Create(const aLoaderEvents: IWVLoaderEvents);
begin
  inherited Create;

  FBrowserEvents := nil;
  FLoaderEvents  := Pointer(aLoaderEvents);
end;

destructor TCoreWebView2BrowserProcessExitedEventHandler.Destroy;
begin
  FBrowserEvents := nil;
  FLoaderEvents  := nil;

  inherited Destroy;
end;

function TCoreWebView2BrowserProcessExitedEventHandler.Invoke(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs): HResult; stdcall;
begin
  if (FBrowserEvents <> nil) then
    Result := IWVBrowserEvents(FBrowserEvents).BrowserProcessExitedEventHandler_Invoke(sender, args)
   else
    if (FLoaderEvents <> nil) then
      Result := IWVLoaderEvents(FLoaderEvents).BrowserProcessExitedEventHandler_Invoke(sender, args)
     else
      Result := E_FAIL;
end;


// TCoreWebView2RasterizationScaleChangedEventHandler

constructor TCoreWebView2RasterizationScaleChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2RasterizationScaleChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2RasterizationScaleChangedEventHandler.Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).RasterizationScaleChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;



// TCoreWebView2WebResourceResponseReceivedEventHandler

constructor TCoreWebView2WebResourceResponseReceivedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2WebResourceResponseReceivedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceResponseReceivedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).WebResourceResponseReceivedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2DOMContentLoadedEventHandler

constructor TCoreWebView2DOMContentLoadedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2DOMContentLoadedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2DOMContentLoadedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).DOMContentLoadedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2WebResourceResponseViewGetContentCompletedHandler

constructor TCoreWebView2WebResourceResponseViewGetContentCompletedHandler.Create(const aEvents: IWVBrowserEvents; aResourceID : integer);
begin
  inherited Create;

  FEvents     := Pointer(aEvents);
  FResourceID := aResourceID;
end;

destructor TCoreWebView2WebResourceResponseViewGetContentCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceResponseViewGetContentCompletedHandler.Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode, result_, FResourceID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2GetCookiesCompletedHandler

constructor TCoreWebView2GetCookiesCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2GetCookiesCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2GetCookiesCompletedHandler.Invoke(errorCode : HResult; const result_ : ICoreWebView2CookieList): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GetCookiesCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2TrySuspendCompletedHandler

constructor TCoreWebView2TrySuspendCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2TrySuspendCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2TrySuspendCompletedHandler.Invoke(errorCode: HResult; result_: Integer): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).TrySuspendCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameCreatedEventHandler

constructor TCoreWebView2FrameCreatedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2FrameCreatedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameCreatedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameCreatedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2DownloadStartingEventHandler

constructor TCoreWebView2DownloadStartingEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2DownloadStartingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2DownloadStartingEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).DownloadStartingEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ClientCertificateRequestedEventHandler

constructor TCoreWebView2ClientCertificateRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ClientCertificateRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ClientCertificateRequestedEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ClientCertificateRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2PrintToPdfCompletedHandler

constructor TCoreWebView2PrintToPdfCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2PrintToPdfCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2PrintToPdfCompletedHandler.Invoke(errorCode: HResult; result_: Integer): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).PrintToPdfCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2BytesReceivedChangedEventHandler

constructor TCoreWebView2BytesReceivedChangedEventHandler.Create(const aEvents: IWVBrowserEvents; aDownloadID : integer);
begin
  inherited Create;

  FEvents     := Pointer(aEvents);
  FDownloadID := aDownloadID;
end;

destructor TCoreWebView2BytesReceivedChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2BytesReceivedChangedEventHandler.Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).BytesReceivedChangedEventHandler_Invoke(sender, args, FDownloadID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2EstimatedEndTimeChangedEventHandler

constructor TCoreWebView2EstimatedEndTimeChangedEventHandler.Create(const aEvents: IWVBrowserEvents; aDownloadID : integer);
begin
  inherited Create;

  FEvents     := Pointer(aEvents);
  FDownloadID := aDownloadID;
end;

destructor TCoreWebView2EstimatedEndTimeChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2EstimatedEndTimeChangedEventHandler.Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).EstimatedEndTimeChangedEventHandler_Invoke(sender, args, FDownloadID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2StateChangedEventHandler

constructor TCoreWebView2StateChangedEventHandler.Create(const aEvents: IWVBrowserEvents; aDownloadID : integer);
begin
  inherited Create;

  FEvents     := Pointer(aEvents);
  FDownloadID := aDownloadID;
end;

destructor TCoreWebView2StateChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2StateChangedEventHandler.Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).StateChangedEventHandler_Invoke(sender, args, FDownloadID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameNameChangedEventHandler

constructor TCoreWebView2FrameNameChangedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameNameChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameNameChangedEventHandler.Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameNameChangedEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameDestroyedEventHandler

constructor TCoreWebView2FrameDestroyedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameDestroyedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameDestroyedEventHandler.Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameDestroyedEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2CallDevToolsProtocolMethodCompletedHandler

constructor TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Create(const aEvents: IWVBrowserEvents; aExecutionID : integer);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
  FID     := aExecutionID;
end;

destructor TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).CallDevToolsProtocolMethodCompletedHandler_Invoke(errorCode, result_, FID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler

constructor TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler.Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).AddScriptToExecuteOnDocumentCreatedCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2IsMutedChangedEventHandler

constructor TCoreWebView2IsMutedChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2IsMutedChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2IsMutedChangedEventHandler.Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).IsMutedChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2IsDocumentPlayingAudioChangedEventHandler

constructor TCoreWebView2IsDocumentPlayingAudioChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2IsDocumentPlayingAudioChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2IsDocumentPlayingAudioChangedEventHandler.Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).IsDocumentPlayingAudioChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler

constructor TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler.Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).IsDefaultDownloadDialogOpenChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ProcessInfosChangedEventHandler

constructor TCoreWebView2ProcessInfosChangedEventHandler.Create(const aBrowserEvents: IWVBrowserEvents);
begin
  inherited Create;

  FBrowserEvents := Pointer(aBrowserEvents);
  FLoaderEvents  := nil;
end;

constructor TCoreWebView2ProcessInfosChangedEventHandler.Create(const aLoaderEvents: IWVLoaderEvents);
begin
  inherited Create;

  FBrowserEvents := nil;
  FLoaderEvents  := Pointer(aLoaderEvents);
end;

destructor TCoreWebView2ProcessInfosChangedEventHandler.Destroy;
begin
  FBrowserEvents := nil;
  FLoaderEvents  := nil;

  inherited Destroy;
end;

function TCoreWebView2ProcessInfosChangedEventHandler.Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult; stdcall;
begin
  if (FBrowserEvents <> nil) then
    Result := IWVBrowserEvents(FBrowserEvents).ProcessInfosChangedEventHandler_Invoke(sender, args)
   else
    if (FLoaderEvents <> nil) then
      Result := IWVLoaderEvents(FLoaderEvents).ProcessInfosChangedEventHandler_Invoke(sender, args)
     else
      Result := E_FAIL;
end;


// TCoreWebView2FrameNavigationCompletedEventHandler2

constructor TCoreWebView2FrameNavigationCompletedEventHandler2.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameNavigationCompletedEventHandler2.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameNavigationCompletedEventHandler2.Invoke(const sender : ICoreWebView2Frame;
                                                                   const args   : ICoreWebView2NavigationCompletedEventArgs): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameNavigationCompletedEventHandler2_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameNavigationStartingEventHandler2

constructor TCoreWebView2FrameNavigationStartingEventHandler2.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameNavigationStartingEventHandler2.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameNavigationStartingEventHandler2.Invoke(const sender : ICoreWebView2Frame;
                                                                  const args   : ICoreWebView2NavigationStartingEventArgs): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameNavigationStartingEventHandler2_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameContentLoadingEventHandler

constructor TCoreWebView2FrameContentLoadingEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameContentLoadingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameContentLoadingEventHandler.Invoke(const sender : ICoreWebView2Frame;
                                                             const args   : ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameContentLoadingEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameDOMContentLoadedEventHandler

constructor TCoreWebView2FrameDOMContentLoadedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameDOMContentLoadedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameDOMContentLoadedEventHandler.Invoke(const sender : ICoreWebView2Frame;
                                                               const args   : ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameDOMContentLoadedEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameWebMessageReceivedEventHandler

constructor TCoreWebView2FrameWebMessageReceivedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameWebMessageReceivedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameWebMessageReceivedEventHandler.Invoke(const sender : ICoreWebView2Frame;
                                                                 const args   : ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameWebMessageReceivedEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2BasicAuthenticationRequestedEventHandler

constructor TCoreWebView2BasicAuthenticationRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2BasicAuthenticationRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2BasicAuthenticationRequestedEventHandler.Invoke(const sender : ICoreWebView2;
                                                                      const args   : ICoreWebView2BasicAuthenticationRequestedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).BasicAuthenticationRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ContextMenuRequestedEventHandler

constructor TCoreWebView2ContextMenuRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ContextMenuRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ContextMenuRequestedEventHandler.Invoke(const sender : ICoreWebView2;
                                                              const args   : ICoreWebView2ContextMenuRequestedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ContextMenuRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2CustomItemSelectedEventHandler

constructor TCoreWebView2CustomItemSelectedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2CustomItemSelectedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2CustomItemSelectedEventHandler.Invoke(const sender : ICoreWebView2ContextMenuItem;
                                                            const args   : IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).CustomItemSelectedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2StatusBarTextChangedEventHandler

constructor TCoreWebView2StatusBarTextChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2StatusBarTextChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2StatusBarTextChangedEventHandler.Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).StatusBarTextChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FramePermissionRequestedEventHandler

constructor TCoreWebView2FramePermissionRequestedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FramePermissionRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FramePermissionRequestedEventHandler.Invoke(const sender : ICoreWebView2Frame;
                                                                  const args   : ICoreWebView2PermissionRequestedEventArgs2): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FramePermissionRequestedEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ClearBrowsingDataCompletedHandler

constructor TCoreWebView2ClearBrowsingDataCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ClearBrowsingDataCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ClearBrowsingDataCompletedHandler.Invoke(errorCode: HResult): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ClearBrowsingDataCompletedHandler_Invoke(errorCode)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler

constructor TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler.Invoke(errorCode: HResult): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ClearServerCertificateErrorActionsCompletedHandler_Invoke(errorCode)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ServerCertificateErrorDetectedEventHandler

constructor TCoreWebView2ServerCertificateErrorDetectedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ServerCertificateErrorDetectedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventHandler.Invoke(const sender : ICoreWebView2;
                                                                        const args   : ICoreWebView2ServerCertificateErrorDetectedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ServerCertificateErrorDetectedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FaviconChangedEventHandler

constructor TCoreWebView2FaviconChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2FaviconChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FaviconChangedEventHandler.Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FaviconChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2GetFaviconCompletedHandler

constructor TCoreWebView2GetFaviconCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2GetFaviconCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2GetFaviconCompletedHandler.Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GetFaviconCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2PrintToPdfStreamCompletedHandler

constructor TCoreWebView2PrintCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2PrintCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2PrintCompletedHandler.Invoke(errorCode: HResult; result_: COREWEBVIEW2_PRINT_STATUS): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).PrintCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2PrintToPdfStreamCompletedHandler

constructor TCoreWebView2PrintToPdfStreamCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2PrintToPdfStreamCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2PrintToPdfStreamCompletedHandler.Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).PrintToPdfStreamCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler

constructor TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler.Invoke(errorCode: HResult; const result_: ICoreWebView2PermissionSettingCollectionView): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GetNonDefaultPermissionSettingsCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2SetPermissionStateCompletedHandler

constructor TCoreWebView2SetPermissionStateCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2SetPermissionStateCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2SetPermissionStateCompletedHandler.Invoke(errorCode: HResult): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).SetPermissionStateCompletedHandler_Invoke(errorCode)
   else
    Result := E_FAIL;
end;


// TCoreWebView2LaunchingExternalUriSchemeEventHandler

constructor TCoreWebView2LaunchingExternalUriSchemeEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2LaunchingExternalUriSchemeEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2LaunchingExternalUriSchemeEventHandler.Invoke(const sender: ICoreWebView2;
                                                                    const args: ICoreWebView2LaunchingExternalUriSchemeEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).LaunchingExternalUriSchemeEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2GetProcessExtendedInfosCompletedHandler

constructor TCoreWebView2GetProcessExtendedInfosCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2GetProcessExtendedInfosCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2GetProcessExtendedInfosCompletedHandler.Invoke(errorCode: HResult; const result_: ICoreWebView2ProcessExtendedInfoCollection): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GetProcessExtendedInfosCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2BrowserExtensionRemoveCompletedHandler

constructor TCoreWebView2BrowserExtensionRemoveCompletedHandler.Create(const aEvents: IWVBrowserEvents; const aExtensionID: wvstring);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
  FID     := aExtensionID;
end;

destructor TCoreWebView2BrowserExtensionRemoveCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2BrowserExtensionRemoveCompletedHandler.Invoke(errorCode: HResult): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).BrowserExtensionRemoveCompletedHandler_Invoke(errorCode, FID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2BrowserExtensionEnableCompletedHandler

constructor TCoreWebView2BrowserExtensionEnableCompletedHandler.Create(const aEvents: IWVBrowserEvents; const aExtensionID: wvstring);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
  FID     := aExtensionID;
end;

destructor TCoreWebView2BrowserExtensionEnableCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2BrowserExtensionEnableCompletedHandler.Invoke(errorCode: HResult): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).BrowserExtensionEnableCompletedHandler_Invoke(errorCode, FID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ProfileAddBrowserExtensionCompletedHandler

constructor TCoreWebView2ProfileAddBrowserExtensionCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ProfileAddBrowserExtensionCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ProfileAddBrowserExtensionCompletedHandler.Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtension): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ProfileAddBrowserExtensionCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ProfileGetBrowserExtensionsCompletedHandler

constructor TCoreWebView2ProfileGetBrowserExtensionsCompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ProfileGetBrowserExtensionsCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ProfileGetBrowserExtensionsCompletedHandler.Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtensionList): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ProfileGetBrowserExtensionsCompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ProfileDeletedEventHandler

constructor TCoreWebView2ProfileDeletedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ProfileDeletedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ProfileDeletedEventHandler.Invoke(const sender: ICoreWebView2Profile; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ProfileDeletedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ExecuteScriptWithResultCompletedHandler

constructor TCoreWebView2ExecuteScriptWithResultCompletedHandler.Create(const aEvents: IWVBrowserEvents; aExecutionID : integer);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
  FID     := aExecutionID;
end;

destructor TCoreWebView2ExecuteScriptWithResultCompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ExecuteScriptWithResultCompletedHandler.Invoke(errorCode: HResult; const result_: ICoreWebView2ExecuteScriptResult): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ExecuteScriptWithResultCompletedHandler_Invoke(errorCode, result_, FID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2NonClientRegionChangedEventHandler

constructor TCoreWebView2NonClientRegionChangedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2NonClientRegionChangedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2NonClientRegionChangedEventHandler.Invoke(const sender : ICoreWebView2CompositionController;
                                                                const args   : ICoreWebView2NonClientRegionChangedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).NonClientRegionChangedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2NotificationReceivedEventHandler

constructor TCoreWebView2NotificationReceivedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2NotificationReceivedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2NotificationReceivedEventHandler.Invoke(const sender : ICoreWebView2;
                                                              const args   : ICoreWebView2NotificationReceivedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).NotificationReceivedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2NotificationCloseRequestedEventHandler

constructor TCoreWebView2NotificationCloseRequestedEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2NotificationCloseRequestedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2NotificationCloseRequestedEventHandler.Invoke(const sender: ICoreWebView2Notification; const args: IUnknown): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).NotificationCloseRequestedEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2SaveAsUIShowingEventHandler

constructor TCoreWebView2SaveAsUIShowingEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2SaveAsUIShowingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2SaveAsUIShowingEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveAsUIShowingEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).SaveAsUIShowingEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ShowSaveAsUICompletedHandler

constructor TCoreWebView2ShowSaveAsUICompletedHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ShowSaveAsUICompletedHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ShowSaveAsUICompletedHandler.Invoke(errorCode: HResult; result_: COREWEBVIEW2_SAVE_AS_UI_RESULT): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ShowSaveAsUICompletedHandler_Invoke(errorCode, result_)
   else
    Result := E_FAIL;
end;


// TCoreWebView2SaveFileSecurityCheckStartingEventHandler

constructor TCoreWebView2SaveFileSecurityCheckStartingEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2SaveFileSecurityCheckStartingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2SaveFileSecurityCheckStartingEventHandler.Invoke(const sender : ICoreWebView2;
                                                                       const args   : ICoreWebView2SaveFileSecurityCheckStartingEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).SaveFileSecurityCheckStartingEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2ScreenCaptureStartingEventHandler

constructor TCoreWebView2ScreenCaptureStartingEventHandler.Create(const aEvents: IWVBrowserEvents);
begin
  inherited Create;

  FEvents := Pointer(aEvents);
end;

destructor TCoreWebView2ScreenCaptureStartingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2ScreenCaptureStartingEventHandler.Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScreenCaptureStartingEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ScreenCaptureStartingEventHandler_Invoke(sender, args)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameScreenCaptureStartingEventHandler

constructor TCoreWebView2FrameScreenCaptureStartingEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameScreenCaptureStartingEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameScreenCaptureStartingEventHandler.Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ScreenCaptureStartingEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameScreenCaptureStartingEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;


// TCoreWebView2FrameChildFrameCreatedEventHandler

constructor TCoreWebView2FrameChildFrameCreatedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : cardinal);
begin
  inherited Create;

  FEvents  := Pointer(aEvents);
  FFrameID := aFrameID;
end;

destructor TCoreWebView2FrameChildFrameCreatedEventHandler.Destroy;
begin
  FEvents := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameChildFrameCreatedEventHandler.Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2FrameCreatedEventArgs): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).FrameChildFrameCreatedEventHandler_Invoke(sender, args, FFrameID)
   else
    Result := E_FAIL;
end;

end.
