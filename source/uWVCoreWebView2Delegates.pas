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
  TCoreWebView2AcceleratorKeyPressedEventHandler = class(TInterfacedObject, ICoreWebView2AcceleratorKeyPressedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2AcceleratorKeyPressedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2CapturePreviewCompletedHandler = class(TInterfacedObject, ICoreWebView2CapturePreviewCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ContainsFullScreenElementChangedEventHandler = class(TInterfacedObject, ICoreWebView2ContainsFullScreenElementChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ContentLoadingEventHandler = class(TInterfacedObject, ICoreWebView2ContentLoadingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2CreateCoreWebView2ControllerCompletedHandler = class(TInterfacedObject, ICoreWebView2CreateCoreWebView2ControllerCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const createdController: ICoreWebView2Controller): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

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

  TCoreWebView2DocumentTitleChangedEventHandler = class(TInterfacedObject, ICoreWebView2DocumentTitleChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2EnvironmentCompletedHandler = class(TInterfacedObject, ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler)
    protected
      FBrowserEvents : Pointer;
      FLoaderEvents  : Pointer;

      function Invoke(errorCode: HResult; const createdEnvironment: ICoreWebView2Environment): HResult; stdcall;

    public
      constructor Create(const aBrowserEvents: IWVBrowserEvents); reintroduce; overload;
      constructor Create(const aLoaderEvents: IWVLoaderEvents); reintroduce; overload;
      destructor  Destroy; override;
  end;

  TCoreWebView2ExecuteScriptCompletedHandler = class(TInterfacedObject, ICoreWebView2ExecuteScriptCompletedHandler)
    protected
      FEvents : Pointer;
      FID     : integer;

      function Invoke(errorCode: HResult; resultObjectAsJson: PWideChar): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aExecutionID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameNavigationCompletedEventHandler = class(TInterfacedObject, ICoreWebView2NavigationCompletedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameNavigationStartingEventHandler = class(TInterfacedObject, ICoreWebView2NavigationStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2GotFocusEventHandler = class(TInterfacedObject, ICoreWebView2FocusChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2HistoryChangedEventHandler = class(TInterfacedObject, ICoreWebView2HistoryChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2LostFocusEventHandler = class(TInterfacedObject, ICoreWebView2FocusChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2MoveFocusRequestedEventHandler = class(TInterfacedObject, ICoreWebView2MoveFocusRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2MoveFocusRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2NavigationCompletedEventHandler = class(TInterfacedObject, ICoreWebView2NavigationCompletedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2NavigationStartingEventHandler = class(TInterfacedObject, ICoreWebView2NavigationStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2NewBrowserVersionAvailableEventHandler = class(TInterfacedObject, ICoreWebView2NewBrowserVersionAvailableEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVLoaderEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2NewWindowRequestedEventHandler = class(TInterfacedObject, ICoreWebView2NewWindowRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NewWindowRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2PermissionRequestedEventHandler = class(TInterfacedObject, ICoreWebView2PermissionRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2PermissionRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ProcessFailedEventHandler = class(TInterfacedObject, ICoreWebView2ProcessFailedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ScriptDialogOpeningEventHandler = class(TInterfacedObject, ICoreWebView2ScriptDialogOpeningEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScriptDialogOpeningEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2SourceChangedEventHandler = class(TInterfacedObject, ICoreWebView2SourceChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SourceChangedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2WebMessageReceivedEventHandler = class(TInterfacedObject, ICoreWebView2WebMessageReceivedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2WebResourceRequestedEventHandler = class(TInterfacedObject, ICoreWebView2WebResourceRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2WindowCloseRequestedEventHandler = class(TInterfacedObject, ICoreWebView2WindowCloseRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ZoomFactorChangedEventHandler = class(TInterfacedObject, ICoreWebView2ZoomFactorChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler = class(TInterfacedObject, ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const webView: ICoreWebView2CompositionController): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2CursorChangedEventHandler = class(TInterfacedObject, ICoreWebView2CursorChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2CompositionController; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

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

  TCoreWebView2RasterizationScaleChangedEventHandler = class(TInterfacedObject, ICoreWebView2RasterizationScaleChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2WebResourceResponseReceivedEventHandler = class(TInterfacedObject, ICoreWebView2WebResourceResponseReceivedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2DOMContentLoadedEventHandler = class(TInterfacedObject, ICoreWebView2DOMContentLoadedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2WebResourceResponseViewGetContentCompletedHandler = class(TInterfacedObject, ICoreWebView2WebResourceResponseViewGetContentCompletedHandler)
    protected
      FEvents     : Pointer;
      FResourceID : integer;

      function Invoke(errorCode: HResult; const Content: IStream): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aResourceID : integer = 0); reintroduce;
      destructor  Destroy; override;

      property ResourceID : integer read FResourceID;
  end;

  TCoreWebView2GetCookiesCompletedHandler = class(TInterfacedObject, ICoreWebView2GetCookiesCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(aResult : HResult; const aCookieList : ICoreWebView2CookieList): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2TrySuspendCompletedHandler = class(TInterfacedObject, ICoreWebView2TrySuspendCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameCreatedEventHandler = class(TInterfacedObject, ICoreWebView2FrameCreatedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2DownloadStartingEventHandler = class(TInterfacedObject, ICoreWebView2DownloadStartingEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ClientCertificateRequestedEventHandler = class(TInterfacedObject, ICoreWebView2ClientCertificateRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2PrintToPdfCompletedHandler = class(TInterfacedObject, ICoreWebView2PrintToPdfCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2BytesReceivedChangedEventHandler = class(TInterfacedObject, ICoreWebView2BytesReceivedChangedEventHandler)
    protected
      FEvents     : Pointer;
      FDownloadID : integer;

      function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2EstimatedEndTimeChangedEventHandler = class(TInterfacedObject, ICoreWebView2EstimatedEndTimeChangedEventHandler)
    protected
      FEvents     : Pointer;
      FDownloadID : integer;

      function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2StateChangedEventHandler = class(TInterfacedObject, ICoreWebView2StateChangedEventHandler)
    protected
      FEvents     : Pointer;
      FDownloadID : integer;

      function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameNameChangedEventHandler = class(TInterfacedObject, ICoreWebView2FrameNameChangedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer = 0); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameDestroyedEventHandler = class(TInterfacedObject, ICoreWebView2FrameDestroyedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer = 0); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2CallDevToolsProtocolMethodCompletedHandler = class(TInterfacedObject, ICoreWebView2CallDevToolsProtocolMethodCompletedHandler)
    protected
      FEvents : Pointer;
      FID     : integer;

      function Invoke(errorCode: HResult; returnObjectAsJson: PWideChar): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aExecutionID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler = class(TInterfacedObject, ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; id: PWideChar): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2IsMutedChangedEventHandler = class(TInterfacedObject, ICoreWebView2IsMutedChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2IsDocumentPlayingAudioChangedEventHandler = class(TInterfacedObject, ICoreWebView2IsDocumentPlayingAudioChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler = class(TInterfacedObject, ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

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

  TCoreWebView2FrameNavigationCompletedEventHandler2 = class(TInterfacedObject, ICoreWebView2FrameNavigationCompletedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameNavigationStartingEventHandler2 = class(TInterfacedObject, ICoreWebView2FrameNavigationStartingEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameContentLoadingEventHandler = class(TInterfacedObject, ICoreWebView2FrameContentLoadingEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameDOMContentLoadedEventHandler = class(TInterfacedObject, ICoreWebView2FrameDOMContentLoadedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FrameWebMessageReceivedEventHandler = class(TInterfacedObject, ICoreWebView2FrameWebMessageReceivedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2BasicAuthenticationRequestedEventHandler = class(TInterfacedObject, ICoreWebView2BasicAuthenticationRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2BasicAuthenticationRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ContextMenuRequestedEventHandler = class(TInterfacedObject, ICoreWebView2ContextMenuRequestedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContextMenuRequestedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2CustomItemSelectedEventHandler = class(TInterfacedObject, ICoreWebView2CustomItemSelectedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2ContextMenuItem; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2StatusBarTextChangedEventHandler = class(TInterfacedObject, ICoreWebView2StatusBarTextChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FramePermissionRequestedEventHandler = class(TInterfacedObject, ICoreWebView2FramePermissionRequestedEventHandler)
    protected
      FEvents  : Pointer;
      FFrameID : integer;

      function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2PermissionRequestedEventArgs2): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ClearBrowsingDataCompletedHandler = class(TInterfacedObject, ICoreWebView2ClearBrowsingDataCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler = class(TInterfacedObject, ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2ServerCertificateErrorDetectedEventHandler = class(TInterfacedObject, ICoreWebView2ServerCertificateErrorDetectedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ServerCertificateErrorDetectedEventArgs): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2FaviconChangedEventHandler = class(TInterfacedObject, ICoreWebView2FaviconChangedEventHandler)
    protected
      FEvents : Pointer;

      function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2GetFaviconCompletedHandler = class(TInterfacedObject, ICoreWebView2GetFaviconCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const faviconStream: IStream): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2PrintCompletedHandler = class(TInterfacedObject, ICoreWebView2PrintCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2PrintToPdfStreamCompletedHandler = class(TInterfacedObject, ICoreWebView2PrintToPdfStreamCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const pdfStream: IStream): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler = class(TInterfacedObject, ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult; const collectionView: ICoreWebView2PermissionSettingCollectionView): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
      destructor  Destroy; override;
  end;

  TCoreWebView2SetPermissionStateCompletedHandler = class(TInterfacedObject, ICoreWebView2SetPermissionStateCompletedHandler)
    protected
      FEvents : Pointer;

      function Invoke(errorCode: HResult): HResult; stdcall;

    public
      constructor Create(const aEvents: IWVBrowserEvents); reintroduce;
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

function TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Invoke(errorCode: HResult; const createdController: ICoreWebView2Controller): HResult;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ControllerCompletedHandler_Invoke(errorCode, createdController)
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

function TCoreWebView2EnvironmentCompletedHandler.Invoke(      errorCode          : HResult;
                                                         const createdEnvironment : ICoreWebView2Environment): HResult;
begin
  if (FBrowserEvents <> nil) then
    Result := IWVBrowserEvents(FBrowserEvents).EnvironmentCompletedHandler_Invoke(errorCode, createdEnvironment)
   else
    if (FLoaderEvents <> nil) then
      Result := IWVLoaderEvents(FLoaderEvents).EnvironmentCompletedHandler_Invoke(errorCode, createdEnvironment)
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

function TCoreWebView2ExecuteScriptCompletedHandler.Invoke(errorCode: HResult; resultObjectAsJson: PWideChar): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).ExecuteScriptCompletedHandler_Invoke(errorCode, resultObjectAsJson, FID)
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

function TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Invoke(errorCode: HResult; const webView: ICoreWebView2CompositionController): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).CreateCoreWebView2CompositionControllerCompletedHandler_Invoke(errorCode, webView)
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

function TCoreWebView2WebResourceResponseViewGetContentCompletedHandler.Invoke(errorCode: HResult; const Content: IStream): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode, Content, FResourceID)
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

function TCoreWebView2GetCookiesCompletedHandler.Invoke(aResult : HResult; const aCookieList : ICoreWebView2CookieList): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GetCookiesCompletedHandler_Invoke(aResult, aCookieList)
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

function TCoreWebView2TrySuspendCompletedHandler.Invoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).TrySuspendCompletedHandler_Invoke(errorCode, isSuccessful)
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

function TCoreWebView2PrintToPdfCompletedHandler.Invoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).PrintToPdfCompletedHandler_Invoke(errorCode, isSuccessful)
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

constructor TCoreWebView2FrameNameChangedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

constructor TCoreWebView2FrameDestroyedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

function TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Invoke(errorCode: HResult; returnObjectAsJson: PWideChar): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).CallDevToolsProtocolMethodCompletedHandler_Invoke(errorCode, returnObjectAsJson, FID)
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

function TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler.Invoke(errorCode: HResult; id: PWideChar): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).AddScriptToExecuteOnDocumentCreatedCompletedHandler_Invoke(errorCode, id)
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

constructor TCoreWebView2FrameNavigationCompletedEventHandler2.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

constructor TCoreWebView2FrameNavigationStartingEventHandler2.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

constructor TCoreWebView2FrameContentLoadingEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

constructor TCoreWebView2FrameDOMContentLoadedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

constructor TCoreWebView2FrameWebMessageReceivedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

constructor TCoreWebView2FramePermissionRequestedEventHandler.Create(const aEvents: IWVBrowserEvents; aFrameID : integer);
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

function TCoreWebView2GetFaviconCompletedHandler.Invoke(errorCode: HResult; const faviconStream: IStream): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GetFaviconCompletedHandler_Invoke(errorCode, faviconStream)
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

function TCoreWebView2PrintCompletedHandler.Invoke(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).PrintCompletedHandler_Invoke(errorCode, printStatus)
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

function TCoreWebView2PrintToPdfStreamCompletedHandler.Invoke(errorCode: HResult; const pdfStream: IStream): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).PrintToPdfStreamCompletedHandler_Invoke(errorCode, pdfStream)
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

function TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler.Invoke(errorCode: HResult; const collectionView: ICoreWebView2PermissionSettingCollectionView): HResult; stdcall;
begin
  if (FEvents <> nil) then
    Result := IWVBrowserEvents(FEvents).GetNonDefaultPermissionSettingsCompletedHandler_Invoke(errorCode, collectionView)
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

end.
