unit uWVBrowserBase;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF FPC}
  Windows, Classes, Types, SysUtils, Graphics, ActiveX, Messages,
  {$ELSE}
  Winapi.Windows, System.Classes, System.Types, System.UITypes, System.SysUtils, Winapi.ActiveX, Winapi.Messages,
  {$ENDIF}
  uWVTypes, uWVConstants, uWVTypeLibrary, uWVLibFunctions, uWVLoader,
  uWVInterfaces, uWVEvents, uWVCoreWebView2, uWVCoreWebView2Settings,
  uWVCoreWebView2Environment, uWVCoreWebView2Controller,
  uWVCoreWebView2PrintSettings, uWVCoreWebView2CompositionController,
  uWVCoreWebView2CookieManager;

type
  TWVBrowserBase = class(TComponent, IWVBrowserEvents)
    protected
      FCoreWebView2PrintSettings                      : TCoreWebView2PrintSettings;
      FCoreWebView2Settings                           : TCoreWebView2Settings;
      FCoreWebView2Environment                        : TCoreWebView2Environment;
      FCoreWebView2Controller                         : TCoreWebView2Controller;
      FCoreWebView2CompositionController              : TCoreWebView2CompositionController;
      FCoreWebView2                                   : TCoreWebView2;
      FWindowParentHandle                             : THandle;
      FUseDefaultEnvironment                          : boolean;
      FUseCompositionController                       : boolean;
      FDefaultURL                                     : wvstring;
      FBrowserExecPath                                : wvstring;
      FUserDataFolder                                 : wvstring;
      FAdditionalBrowserArguments                     : wvstring;
      FLanguage                                       : wvstring;
      FTargetCompatibleBrowserVersion                 : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount         : boolean;
      FIgnoreCertificateErrors                        : boolean;
      FZoomStep                                       : byte;
      FOffline                                        : boolean;

      FOldWidget0CompWndPrc                           : TFNWndProc;
      FOldWidget1CompWndPrc                           : TFNWndProc;
      FOldRenderCompWndPrc                            : TFNWndProc;
      FOldD3DWindowCompWndPrc                         : TFNWndProc;
      FWidget0CompStub                                : Pointer;
      FWidget1CompStub                                : Pointer;
      FRenderCompStub                                 : Pointer;
      FD3DWindowCompStub                              : Pointer;
      FWidget0CompHWND                                : THandle;
      FWidget1CompHWND                                : THandle;
      FRenderCompHWND                                 : THandle;
      FD3DWindowCompHWND                              : THandle;

      FOnInitializationError                          : TOnInitializationErrorEvent;
      FOnEnvironmentCompleted                         : TNotifyEvent;
      FOnControllerCompleted                          : TNotifyEvent;
      FOnAfterCreated                                 : TNotifyEvent;
      FOnExecuteScriptCompleted                       : TOnExecuteScriptCompletedEvent;
      FOnCapturePreviewCompleted                      : TOnCapturePreviewCompletedEvent;
      FOnNavigationStarting                           : TOnNavigationStartingEvent;
      FOnNavigationCompleted                          : TOnNavigationCompletedEvent;
      FOnFrameNavigationStarting                      : TOnNavigationStartingEvent;
      FOnFrameNavigationCompleted                     : TOnNavigationCompletedEvent;
      FOnSourceChanged                                : TOnSourceChangedEvent;
      FOnHistoryChanged                               : TNotifyEvent;
      FOnContentLoading                               : TOnContentLoadingEvent;
      FOnDocumentTitleChanged                         : TNotifyEvent;
      FOnNewWindowRequested                           : TOnNewWindowRequestedEvent;
      FOnWebResourceRequested                         : TOnWebResourceRequestedEvent;
      FOnScriptDialogOpening                          : TOnScriptDialogOpeningEvent;
      FOnPermissionRequested                          : TOnPermissionRequestedEvent;
      FOnProcessFailed                                : TOnProcessFailedEvent;
      FOnWebMessageReceived                           : TOnWebMessageReceivedEvent;
      FOnContainsFullScreenElementChanged             : TNotifyEvent;
      FOnWindowCloseRequested                         : TNotifyEvent;
      FOnDevToolsProtocolEventReceived                : TOnDevToolsProtocolEventReceivedEvent;
      FOnZoomFactorChanged                            : TNotifyEvent;
      FOnMoveFocusRequested                           : TOnMoveFocusRequestedEvent;
      FOnAcceleratorKeyPressed                        : TOnAcceleratorKeyPressedEvent;
      FOnGotFocus                                     : TNotifyEvent;
      FOnLostFocus                                    : TNotifyEvent;
      FOnCursorChanged                                : TNotifyEvent;
      FOnBrowserProcessExited                         : TOnBrowserProcessExitedEvent;
      FOnRasterizationScaleChanged                    : TNotifyEvent;
      FOnWebResourceResponseReceived                  : TOnWebResourceResponseReceivedEvent;
      FOnDOMContentLoaded                             : TOnDOMContentLoadedEvent;
      FOnWebResourceResponseViewGetContentCompleted   : TOnWebResourceResponseViewGetContentCompletedEvent;
      FOnGetCookiesCompleted                          : TOnGetCookiesCompletedEvent;
      FOnTrySuspendCompleted                          : TOnTrySuspendCompletedEvent;
      FOnFrameCreated                                 : TOnFrameCreatedEvent;
      FOnDownloadStarting                             : TOnDownloadStartingEvent;
      FOnClientCertificateRequested                   : TOnClientCertificateRequestedEvent;
      FOnPrintToPdfCompleted                          : TOnPrintToPdfCompletedEvent;
      FOnBytesReceivedChanged                         : TOnBytesReceivedChangedEvent;
      FOnEstimatedEndTimeChanged                      : TOnEstimatedEndTimeChangedEvent;
      FOnDownloadStateChanged                         : TOnDownloadStateChangedEvent;
      FOnFrameNameChanged                             : TOnFrameNameChangedEvent;
      FOnFrameDestroyed                               : TOnFrameDestroyedEvent;
      FOnCompositionControllerCompleted               : TNotifyEvent;
      FOnCallDevToolsProtocolMethodCompleted          : TOnCallDevToolsProtocolMethodCompletedEvent;
      FOnAddScriptToExecuteOnDocumentCreatedCompleted : TOnAddScriptToExecuteOnDocumentCreatedCompletedEvent;
      FOnWidget0CompMsg                               : TOnCompMsgEvent;
      FOnWidget1CompMsg                               : TOnCompMsgEvent;
      FOnRenderCompMsg                                : TOnCompMsgEvent;
      FOnD3DWindowCompMsg                             : TOnCompMsgEvent;

      function  GetBrowserProcessID : cardinal;
      function  GetBrowserVersionInfo : wvstring;
      function  GetCanGoBack : boolean;
      function  GetCanGoForward : boolean;
      function  GetContainsFullScreenElement : boolean;
      function  GetDocumentTitle : wvstring;
      function  GetSource : wvstring;
      function  GetCookieManager : ICoreWebView2CookieManager;
      function  GetInitialized : boolean;
      function  GetZoomFactor : double;
      function  GetZoomPct : double;
      function  GetBuiltInErrorPageEnabled : boolean;
      function  GetDefaultContextMenusEnabled : boolean;
      function  GetDefaultScriptDialogsEnabled : boolean;
      function  GetDevToolsEnabled : boolean;
      function  GetScriptEnabled : boolean;
      function  GetStatusBarEnabled : boolean;
      function  GetWebMessageEnabled : boolean;
      function  GetZoomControlEnabled : boolean;
      function  GetIsVisible : boolean;
      function  GetBounds : TRect;
      function  GetParentWindow : THandle;
      function  GetDefaultBackgroundColor : TColor;
      function  GetRasterizationScale : double;
      function  GetShouldDetectMonitorScaleChanges : boolean;
      function  GetBoundsMode : TWVBoundsMode;
      function  GetAreHostObjectsAllowed : boolean;
      function  GetUserAgent : wvstring;
      function  GetAreBrowserAcceleratorKeysEnabled : boolean;
      function  GetIsPasswordAutosaveEnabled : boolean;
      function  GetIsGeneralAutofillEnabled : boolean;
      function  GetIsPinchZoomEnabled : boolean;
      function  GetIsSwipeNavigationEnabled : boolean;
      function  GetIsSuspended: boolean;
      function  GetUserDataFolder: wvstring;

      procedure SetBuiltInErrorPageEnabled(const Value: boolean);
      procedure SetDefaultContextMenusEnabled(const Value: boolean);
      procedure SetDefaultScriptDialogsEnabled(const Value: boolean);
      procedure SetDevToolsEnabled(const Value: boolean);
      procedure SetScriptEnabled(const Value: boolean);
      procedure SetStatusBarEnabled(const Value: boolean);
      procedure SetWebMessageEnabled(const Value: boolean);
      procedure SetZoomControlEnabled(const Value: boolean);
      procedure SetZoomFactor(const Value: Double);
      procedure SetZoomPct(const aValue : double);
      procedure SetZoomStep(aValue : byte);
      procedure SetIsVisible(const aValue : boolean);
      procedure SetBounds(aValue : TRect);
      procedure SetParentWindow(aValue : THandle);
      procedure SetDefaultBackgroundColor(const aValue : TColor);
      procedure SetRasterizationScale(const aValue : double);
      procedure SetShouldDetectMonitorScaleChanges(aValue : boolean);
      procedure SetBoundsMode(aValue : TWVBoundsMode);
      procedure SetAreHostObjectsAllowed(aValue : boolean);
      procedure SetUserAgent(const aValue : wvstring);
      procedure SetAreBrowserAcceleratorKeysEnabled(aValue : boolean);
      procedure SetIsPasswordAutosaveEnabled(aValue : boolean);
      procedure SetIsGeneralAutofillEnabled(aValue : boolean);
      procedure SetIsPinchZoomEnabled(aValue : boolean);
      procedure SetIsSwipeNavigationEnabled(aValue : boolean);
      procedure SetOffline(aValue : boolean);
      procedure SetIgnoreCertificateErrors(aValue : boolean);

      function  CreateEnvironment : boolean;

      procedure DestroyEnvironment;
      procedure DestroyController;
      procedure DestroyCompositionController;
      procedure DestroyWebView;
      procedure DestroySettings;
      procedure DestroyPrintSettings;

      procedure UpdateZoomStep(aInc : boolean);
      procedure UpdateZoomPct(const aValue : double);

      procedure CreateStub(const aMethod : TWndMethod; var aStub : Pointer);
      procedure FreeAndNilStub(var aStub : pointer);
      function  InstallCompWndProc(aWnd: THandle; aStub: Pointer): TFNWndProc;
      procedure RestoreCompWndProc(var aOldWnd: THandle; aNewWnd: THandle; var aProc: TFNWndProc);
      procedure CallOldCompWndProc(aProc: TFNWndProc; aWnd: THandle; var aMessage: TMessage);
      procedure Widget0CompWndProc(var aMessage: TMessage);
      procedure Widget1CompWndProc(var aMessage: TMessage);
      procedure RenderCompWndProc(var aMessage: TMessage);
      procedure D3DWindowCompWndProc(var aMessage: TMessage);
      procedure RestoreOldCompWndProc;
      procedure ReplaceWndProcs;

      function EnvironmentCompletedHandler_Invoke(errorCode: HRESULT; const createdEnvironment: ICoreWebView2Environment): HRESULT;
      function ControllerCompletedHandler_Invoke(errorCode: HRESULT; const createdController: ICoreWebView2Controller): HRESULT;
      function ExecuteScriptCompletedHandler_Invoke(errorCode: HRESULT; resultObjectAsJson: PWideChar; aExecutionID : integer): HRESULT;
      function CapturePreviewCompletedHandler_Invoke(errorCode: HRESULT): HRESULT;
      function NavigationStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HRESULT;
      function NavigationCompletedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HRESULT;
      function FrameNavigationStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HRESULT;
      function FrameNavigationCompletedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HRESULT;
      function SourceChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SourceChangedEventArgs): HRESULT;
      function HistoryChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function ContentLoadingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContentLoadingEventArgs): HRESULT;
      function DocumentTitleChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function NewWindowRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NewWindowRequestedEventArgs): HRESULT;
      function WebResourceRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceRequestedEventArgs): HRESULT;
      function ScriptDialogOpeningEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScriptDialogOpeningEventArgs): HRESULT;
      function PermissionRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2PermissionRequestedEventArgs): HRESULT;
      function ProcessFailedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs): HRESULT;
      function WebMessageReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebMessageReceivedEventArgs): HRESULT;
      function ContainsFullScreenElementChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function WindowCloseRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function DevToolsProtocolEventReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DevToolsProtocolEventReceivedEventArgs; const aEventName : wvstring; aEventID : integer): HRESULT;
      function ZoomFactorChangedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
      function MoveFocusRequestedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2MoveFocusRequestedEventArgs): HRESULT;
      function AcceleratorKeyPressedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2AcceleratorKeyPressedEventArgs): HRESULT;
      function GotFocusEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
      function LostFocusEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
      function CreateCoreWebView2CompositionControllerCompletedHandler_Invoke(errorCode: HResult; const webView: ICoreWebView2CompositionController): HRESULT;
      function CursorChangedEventHandler_Invoke(const sender: ICoreWebView2CompositionController; const args: IUnknown): HRESULT;
      function BrowserProcessExitedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs): HRESULT;
      function RasterizationScaleChangedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
      function WebResourceResponseReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs): HRESULT;
      function DOMContentLoadedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs): HRESULT;
      function WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode: HResult; const Content: IStream): HRESULT;
      function GetCookiesCompletedHandler_Invoke(aResult : HResult; const aCookieList : ICoreWebView2CookieList): HRESULT;
      function TrySuspendCompletedHandler_Invoke(errorCode: HResult; isSuccessful: Integer): HRESULT;
      function FrameCreatedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs): HRESULT;
      function DownloadStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs): HRESULT;
      function ClientCertificateRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs): HRESULT;
      function PrintToPdfCompletedHandler_Invoke(errorCode: HResult; isSuccessful: Integer): HRESULT;
      function BytesReceivedChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
      function EstimatedEndTimeChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
      function StateChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
      function FrameNameChangedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer): HRESULT;
      function FrameDestroyedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer): HRESULT;
      function CallDevToolsProtocolMethodCompletedHandler_Invoke(errorCode: HResult; returnObjectAsJson: PWideChar; aExecutionID : integer): HRESULT;
      function AddScriptToExecuteOnDocumentCreatedCompletedHandler_Invoke(errorCode: HResult; id: PWideChar): HRESULT;

      procedure doOnInitializationError(aErrorCode: HRESULT; const aErrorMessage: wvstring); virtual;
      procedure doOnEnvironmentCompleted; virtual;
      procedure doOnControllerCompleted; virtual;
      procedure doOnAfterCreated; virtual;
      procedure doOnExecuteScriptCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring; aExecutionID : integer); virtual;
      procedure doCapturePreviewCompleted(aErrorCode: HRESULT); virtual;
      procedure doOnNavigationStarting(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs); virtual;
      procedure doOnNavigationCompleted(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs); virtual;
      procedure doOnFrameNavigationStarting(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs); virtual;
      procedure doOnFrameNavigationCompleted(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs); virtual;
      procedure doOnSourceChanged(const sender: ICoreWebView2; const args: ICoreWebView2SourceChangedEventArgs); virtual;
      procedure doOnHistoryChanged(const sender: ICoreWebView2); virtual;
      procedure doOnContentLoading(const sender: ICoreWebView2; const args: ICoreWebView2ContentLoadingEventArgs); virtual;
      procedure doOnDocumentTitleChanged(const sender: ICoreWebView2); virtual;
      procedure doOnNewWindowRequested(const sender: ICoreWebView2; const args: ICoreWebView2NewWindowRequestedEventArgs); virtual;
      procedure doOnWebResourceRequested(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceRequestedEventArgs); virtual;
      procedure doOnScriptDialogOpening(const sender: ICoreWebView2; const args: ICoreWebView2ScriptDialogOpeningEventArgs); virtual;
      procedure doOnPermissionRequested(const sender: ICoreWebView2; const args: ICoreWebView2PermissionRequestedEventArgs); virtual;
      procedure doOnProcessFailed(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs); virtual;
      procedure doOnWebMessageReceived(const sender: ICoreWebView2; const args: ICoreWebView2WebMessageReceivedEventArgs); virtual;
      procedure doOnContainsFullScreenElementChanged(const sender: ICoreWebView2); virtual;
      procedure doOnWindowCloseRequested(const sender: ICoreWebView2); virtual;
      procedure doOnDevToolsProtocolEventReceived(const sender: ICoreWebView2; const args: ICoreWebView2DevToolsProtocolEventReceivedEventArgs; const aEventName : wvstring; aEventID : integer); virtual;
      procedure doOnZoomFactorChanged(const sender: ICoreWebView2Controller); virtual;
      procedure doOnMoveFocusRequested(const sender: ICoreWebView2Controller; const args: ICoreWebView2MoveFocusRequestedEventArgs); virtual;
      procedure doOnAcceleratorKeyPressed(const sender: ICoreWebView2Controller; const args: ICoreWebView2AcceleratorKeyPressedEventArgs); virtual;
      procedure doOnGotFocus(const sender: ICoreWebView2Controller); virtual;
      procedure doOnLostFocus(const sender: ICoreWebView2Controller); virtual;
      procedure doOnCompositionControllerCompleted; virtual;
      procedure doOnCursorChangedEvent(const sender: ICoreWebView2CompositionController); virtual;
      procedure doOnBrowserProcessExitedEvent(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs); virtual;
      procedure doOnRasterizationScaleChangedEvent(const sender: ICoreWebView2Controller); virtual;
      procedure doOnWebResourceResponseReceivedEvent(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs); virtual;
      procedure doOnDOMContentLoadedEvent(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs); virtual;
      procedure doOnWebResourceResponseViewGetContentCompletedEvent(errorCode: HResult; const Content: IStream); virtual;
      procedure doOnGetCookiesCompletedEvent(aResult : HResult; const aCookieList : ICoreWebView2CookieList); virtual;
      procedure doOnTrySuspendCompletedEvent(errorCode: HResult; isSuccessful: Integer); virtual;
      procedure doOnFrameCreatedEvent(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs); virtual;
      procedure doOnDownloadStartingEvent(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs); virtual;
      procedure doOnClientCertificateRequestedEvent(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs); virtual;
      procedure doOnPrintToPdfCompletedEvent(errorCode: HResult; isSuccessful: Integer); virtual;
      procedure doOnBytesReceivedChangedEventEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer); virtual;
      procedure doOnEstimatedEndTimeChangedEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer); virtual;
      procedure doOnStateChangedEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer); virtual;
      procedure doOnFrameNameChangedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer); virtual;
      procedure doOnFrameDestroyedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer); virtual;
      procedure doOnCallDevToolsProtocolMethodCompletedEvent(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring; aExecutionID : integer); virtual;
      procedure doOnAddScriptToExecuteOnDocumentCreatedCompletedEvent(aErrorCode: HRESULT; const aID : wvstring); virtual;

    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;

      function    CreateBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean = True) : boolean; overload;
      function    CreateBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean; overload;

      function    CreateWindowlessBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean = True) : boolean; overload;
      function    CreateWindowlessBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean; overload;

      function    GoBack : boolean;
      function    GoForward : boolean;
      function    Refresh : boolean;
      function    Stop : boolean;

      function    Navigate(const aURI : wvstring) : boolean;
      function    NavigateToString(const aHTMLContent: wvstring) : boolean;
      function    NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;

      function    SubscribeToDevToolsProtocolEvent(const aEventName : wvstring; aEventID : integer = 0) : boolean;
      function    CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer = 0) : boolean;

      function    SetFocus : boolean;
      function    FocusNext : boolean;
      function    FocusPrevious : boolean;

      function    ExecuteScript(const aJavaScript : wvstring; aExecutionID : integer = 0) : boolean;
      function    CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream) : boolean;
      function    NotifyParentWindowPositionChanged : boolean;

      function    TrySuspend : boolean;
      function    Resume : boolean;

      function    SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
      function    ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;

      function    Print : boolean;
      function    PrintToPdf(const aResultFilePath : wvstring) : boolean;

      function    OpenDevToolsWindow : boolean;
      function    OpenTaskManagerWindow : boolean;

      function    PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
      function    PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;

      function    AddWebResourceRequestedFilter(const aURI: wvstring; aResourceContext: TWVWebResourceContext) : boolean;
      function    RemoveWebResourceRequestedFilter(const aURI: wvstring; aResourceContext: TWVWebResourceContext) : boolean;

      function    AddHostObjectToScript(const aName : wvstring; const aObject : OleVariant): boolean;
      function    RemoveHostObjectFromScript(const aName : wvstring) : boolean;

      function    AddScriptToExecuteOnDocumentCreated(const JavaScript : wvstring) : boolean;
      function    RemoveScriptToExecuteOnDocumentCreated(const aID : wvstring) : boolean;

      function    CreateCookie(const aName, aValue, aDomain, aPath : wvstring) : ICoreWebView2Cookie;
      function    CopyCookie(const aCookie : ICoreWebView2Cookie) : ICoreWebView2Cookie;
      function    GetCookies(const aURI : wvstring = ''):  boolean;
      function    AddOrUpdateCookie(const aCookie : ICoreWebView2Cookie): boolean;
      function    DeleteCookie(const aCookie : ICoreWebView2Cookie): boolean;
      function    DeleteCookies(const aName, aURI : wvstring): boolean;
      function    DeleteCookiesWithDomainAndPath(const aName, aDomain, aPath : wvstring): boolean;
      function    DeleteAllCookies : boolean;
      function    ClearCache : boolean;
      function    ClearDataForOrigin(const aOrigin : wvstring; aStorageTypes : TWVClearDataStorageTypes = cdstAll) : boolean;

      procedure   MoveFormTo(const x, y: Integer); virtual; abstract;
      procedure   MoveFormBy(const x, y: Integer); virtual; abstract;
      procedure   ResizeFormWidthTo(const x : Integer); virtual; abstract;
      procedure   ResizeFormHeightTo(const y : Integer); virtual; abstract;
      procedure   SetFormLeftTo(const x : Integer); virtual; abstract;
      procedure   SetFormTopTo(const y : Integer); virtual; abstract;

      procedure   IncZoomStep;
      procedure   DecZoomStep;
      procedure   ResetZoom;
      function    SetBoundsAndZoomFactor(aBounds: TRect; const aZoomFactor: double) : boolean;

      property Initialized                            : boolean                                 read GetInitialized;
      property CoreWebView2PrintSettings              : TCoreWebView2PrintSettings              read FCoreWebView2PrintSettings;
      property CoreWebView2Settings                   : TCoreWebView2Settings                   read FCoreWebView2Settings;
      property CoreWebView2Environment                : TCoreWebView2Environment                read FCoreWebView2Environment;
      property CoreWebView2Controller                 : TCoreWebView2Controller                 read FCoreWebView2Controller;
      property CoreWebView2CompositionController      : TCoreWebView2CompositionController      read FCoreWebView2CompositionController;
      property CoreWebView2                           : TCoreWebView2                           read FCoreWebView2;
      property BrowserVersionInfo                     : wvstring                                read GetBrowserVersionInfo;
      property BrowserProcessID                       : cardinal                                read GetBrowserProcessID;
      property CanGoBack                              : boolean                                 read GetCanGoBack;
      property CanGoForward                           : boolean                                 read GetCanGoForward;
      property ContainsFullScreenElement              : boolean                                 read GetContainsFullScreenElement;
      property DocumentTitle                          : wvstring                                read GetDocumentTitle;
      property Source                                 : wvstring                                read GetSource;
      property CookieManager                          : ICoreWebView2CookieManager              read GetCookieManager;
      property ZoomFactor                             : double                                  read GetZoomFactor                            write SetZoomFactor;
      property ZoomPct                                : double                                  read GetZoomPct                               write SetZoomPct;
      property ZoomStep                               : byte                                    read FZoomStep                                write SetZoomStep;
      property Offline                                : boolean                                 read FOffline                                 write SetOffline;
      property IsVisible                              : boolean                                 read GetIsVisible                             write SetIsVisible;
      property BuiltInErrorPageEnabled                : boolean                                 read GetBuiltInErrorPageEnabled               write SetBuiltInErrorPageEnabled;
      property DefaultContextMenusEnabled             : boolean                                 read GetDefaultContextMenusEnabled            write SetDefaultContextMenusEnabled;
      property DefaultScriptDialogsEnabled            : boolean                                 read GetDefaultScriptDialogsEnabled           write SetDefaultScriptDialogsEnabled;
      property DevToolsEnabled                        : boolean                                 read GetDevToolsEnabled                       write SetDevToolsEnabled;
      property ScriptEnabled                          : boolean                                 read GetScriptEnabled                         write SetScriptEnabled;
      property StatusBarEnabled                       : boolean                                 read GetStatusBarEnabled                      write SetStatusBarEnabled;
      property WebMessageEnabled                      : boolean                                 read GetWebMessageEnabled                     write SetWebMessageEnabled;
      property ZoomControlEnabled                     : boolean                                 read GetZoomControlEnabled                    write SetZoomControlEnabled;
      property AreHostObjectsAllowed                  : boolean                                 read GetAreHostObjectsAllowed                 write SetAreHostObjectsAllowed;
      property UserAgent                              : wvstring                                read GetUserAgent                             write SetUserAgent;
      property AreBrowserAcceleratorKeysEnabled       : boolean                                 read GetAreBrowserAcceleratorKeysEnabled      write SetAreBrowserAcceleratorKeysEnabled;
      property IsPasswordAutosaveEnabled              : boolean                                 read GetIsPasswordAutosaveEnabled             write SetIsPasswordAutosaveEnabled;
      property IsGeneralAutofillEnabled               : boolean                                 read GetIsGeneralAutofillEnabled              write SetIsGeneralAutofillEnabled;
      property IsPinchZoomEnabled                     : boolean                                 read GetIsPinchZoomEnabled                    write SetIsPinchZoomEnabled;
      property IsSwipeNavigationEnabled               : boolean                                 read GetIsSwipeNavigationEnabled              write SetIsSwipeNavigationEnabled;
      property Bounds                                 : TRect                                   read GetBounds                                write SetBounds;
      property ParentWindow                           : THandle                                 read GetParentWindow                          write SetParentWindow;
      property DefaultBackgroundColor                 : TColor                                  read GetDefaultBackgroundColor                write SetDefaultBackgroundColor;
      property RasterizationScale                     : double                                  read GetRasterizationScale                    write SetRasterizationScale;
      property ShouldDetectMonitorScaleChanges        : boolean                                 read GetShouldDetectMonitorScaleChanges       write SetShouldDetectMonitorScaleChanges;
      property BoundsMode                             : TWVBoundsMode                           read GetBoundsMode                            write SetBoundsMode;
      property BrowserExecPath                        : wvstring                                read FBrowserExecPath                         write FBrowserExecPath;
      property UserDataFolder                         : wvstring                                read GetUserDataFolder                        write FUserDataFolder;
      property DefaultURL                             : wvstring                                read FDefaultURL                              write FDefaultURL;
      property AdditionalBrowserArguments             : wvstring                                read FAdditionalBrowserArguments              write FAdditionalBrowserArguments;
      property Language                               : wvstring                                read FLanguage                                write FLanguage;
      property TargetCompatibleBrowserVersion         : wvstring                                read FTargetCompatibleBrowserVersion          write FTargetCompatibleBrowserVersion;
      property AllowSingleSignOnUsingOSPrimaryAccount : boolean                                 read FAllowSingleSignOnUsingOSPrimaryAccount  write FAllowSingleSignOnUsingOSPrimaryAccount;
      property IsSuspended                            : boolean                                 read GetIsSuspended;
      property IgnoreCertificateErrors                : boolean                                 read FIgnoreCertificateErrors                 write SetIgnoreCertificateErrors;

      property OnInitializationError                           : TOnInitializationErrorEvent                           read FOnInitializationError                           write FOnInitializationError;
      property OnEnvironmentCompleted                          : TNotifyEvent                                          read FOnEnvironmentCompleted                          write FOnEnvironmentCompleted;
      property OnControllerCompleted                           : TNotifyEvent                                          read FOnControllerCompleted                           write FOnControllerCompleted;
      property OnAfterCreated                                  : TNotifyEvent                                          read FOnAfterCreated                                  write FOnAfterCreated;
      property OnExecuteScriptCompleted                        : TOnExecuteScriptCompletedEvent                        read FOnExecuteScriptCompleted                        write FOnExecuteScriptCompleted;
      property OnCapturePreviewCompleted                       : TOnCapturePreviewCompletedEvent                       read FOnCapturePreviewCompleted                       write FOnCapturePreviewCompleted;
      property OnNavigationStarting                            : TOnNavigationStartingEvent                            read FOnNavigationStarting                            write FOnNavigationStarting;
      property OnNavigationCompleted                           : TOnNavigationCompletedEvent                           read FOnNavigationCompleted                           write FOnNavigationCompleted;
      property OnFrameNavigationStarting                       : TOnNavigationStartingEvent                            read FOnFrameNavigationStarting                       write FOnFrameNavigationStarting;
      property OnFrameNavigationCompleted                      : TOnNavigationCompletedEvent                           read FOnFrameNavigationCompleted                      write FOnFrameNavigationCompleted;
      property OnSourceChanged                                 : TOnSourceChangedEvent                                 read FOnSourceChanged                                 write FOnSourceChanged;
      property OnHistoryChanged                                : TNotifyEvent                                          read FOnHistoryChanged                                write FOnHistoryChanged;
      property OnContentLoading                                : TOnContentLoadingEvent                                read FOnContentLoading                                write FOnContentLoading;
      property OnDocumentTitleChanged                          : TNotifyEvent                                          read FOnDocumentTitleChanged                          write FOnDocumentTitleChanged;
      property OnNewWindowRequested                            : TOnNewWindowRequestedEvent                            read FOnNewWindowRequested                            write FOnNewWindowRequested;
      property OnWebResourceRequested                          : TOnWebResourceRequestedEvent                          read FOnWebResourceRequested                          write FOnWebResourceRequested;
      property OnScriptDialogOpening                           : TOnScriptDialogOpeningEvent                           read FOnScriptDialogOpening                           write FOnScriptDialogOpening;
      property OnPermissionRequested                           : TOnPermissionRequestedEvent                           read FOnPermissionRequested                           write FOnPermissionRequested;
      property OnProcessFailed                                 : TOnProcessFailedEvent                                 read FOnProcessFailed                                 write FOnProcessFailed;
      property OnWebMessageReceived                            : TOnWebMessageReceivedEvent                            read FOnWebMessageReceived                            write FOnWebMessageReceived;
      property OnContainsFullScreenElementChanged              : TNotifyEvent                                          read FOnContainsFullScreenElementChanged              write FOnContainsFullScreenElementChanged;
      property OnWindowCloseRequested                          : TNotifyEvent                                          read FOnWindowCloseRequested                          write FOnWindowCloseRequested;
      property OnDevToolsProtocolEventReceived                 : TOnDevToolsProtocolEventReceivedEvent                 read FOnDevToolsProtocolEventReceived                 write FOnDevToolsProtocolEventReceived;
      property OnZoomFactorChanged                             : TNotifyEvent                                          read FOnZoomFactorChanged                             write FOnZoomFactorChanged;
      property OnMoveFocusRequested                            : TOnMoveFocusRequestedEvent                            read FOnMoveFocusRequested                            write FOnMoveFocusRequested;
      property OnAcceleratorKeyPressed                         : TOnAcceleratorKeyPressedEvent                         read FOnAcceleratorKeyPressed                         write FOnAcceleratorKeyPressed;
      property OnGotFocus                                      : TNotifyEvent                                          read FOnGotFocus                                      write FOnGotFocus;
      property OnLostFocus                                     : TNotifyEvent                                          read FOnLostFocus                                     write FOnLostFocus;
      property OnCursorChanged                                 : TNotifyEvent                                          read FOnCursorChanged                                 write FOnCursorChanged;
      property OnBrowserProcessExited                          : TOnBrowserProcessExitedEvent                          read FOnBrowserProcessExited                          write FOnBrowserProcessExited;
      property OnRasterizationScaleChanged                     : TNotifyEvent                                          read FOnRasterizationScaleChanged                     write FOnRasterizationScaleChanged;
      property OnWebResourceResponseReceived                   : TOnWebResourceResponseReceivedEvent                   read FOnWebResourceResponseReceived                   write FOnWebResourceResponseReceived;
      property OnDOMContentLoaded                              : TOnDOMContentLoadedEvent                              read FOnDOMContentLoaded                              write FOnDOMContentLoaded;
      property OnWebResourceResponseViewGetContentCompleted    : TOnWebResourceResponseViewGetContentCompletedEvent    read FOnWebResourceResponseViewGetContentCompleted    write FOnWebResourceResponseViewGetContentCompleted;
      property OnGetCookiesCompleted                           : TOnGetCookiesCompletedEvent                           read FOnGetCookiesCompleted                           write FOnGetCookiesCompleted;
      property OnTrySuspendCompleted                           : TOnTrySuspendCompletedEvent                           read FOnTrySuspendCompleted                           write FOnTrySuspendCompleted;
      property OnFrameCreated                                  : TOnFrameCreatedEvent                                  read FOnFrameCreated                                  write FOnFrameCreated;
      property OnDownloadStarting                              : TOnDownloadStartingEvent                              read FOnDownloadStarting                              write FOnDownloadStarting;
      property OnClientCertificateRequested                    : TOnClientCertificateRequestedEvent                    read FOnClientCertificateRequested                    write FOnClientCertificateRequested;
      property OnPrintToPdfCompleted                           : TOnPrintToPdfCompletedEvent                           read FOnPrintToPdfCompleted                           write FOnPrintToPdfCompleted;
      property OnBytesReceivedChanged                          : TOnBytesReceivedChangedEvent                          read FOnBytesReceivedChanged                          write FOnBytesReceivedChanged;
      property OnEstimatedEndTimeChanged                       : TOnEstimatedEndTimeChangedEvent                       read FOnEstimatedEndTimeChanged                       write FOnEstimatedEndTimeChanged;
      property OnDownloadStateChanged                          : TOnDownloadStateChangedEvent                          read FOnDownloadStateChanged                          write FOnDownloadStateChanged;
      property OnFrameNameChanged                              : TOnFrameNameChangedEvent                              read FOnFrameNameChanged                              write FOnFrameNameChanged;
      property OnFrameDestroyed                                : TOnFrameDestroyedEvent                                read FOnFrameDestroyed                                write FOnFrameDestroyed;
      property OnCompositionControllerCompleted                : TNotifyEvent                                          read FOnCompositionControllerCompleted                write FOnCompositionControllerCompleted;
      property OnCallDevToolsProtocolMethodCompleted           : TOnCallDevToolsProtocolMethodCompletedEvent           read FOnCallDevToolsProtocolMethodCompleted           write FOnCallDevToolsProtocolMethodCompleted;
      property OnAddScriptToExecuteOnDocumentCreatedCompleted  : TOnAddScriptToExecuteOnDocumentCreatedCompletedEvent  read FOnAddScriptToExecuteOnDocumentCreatedCompleted  write FOnAddScriptToExecuteOnDocumentCreatedCompleted;
      property OnWidget0CompMsg                                : TOnCompMsgEvent                                       read FOnWidget0CompMsg                                write FOnWidget0CompMsg;
      property OnWidget1CompMsg                                : TOnCompMsgEvent                                       read FOnWidget1CompMsg                                write FOnWidget1CompMsg;
      property OnRenderCompMsg                                 : TOnCompMsgEvent                                       read FOnRenderCompMsg                                 write FOnRenderCompMsg;
      property OnD3DWindowCompMsg                              : TOnCompMsgEvent                                       read FOnD3DWindowCompMsg                              write FOnD3DWindowCompMsg;
  end;

implementation

uses
  uWVMiscFunctions, uWVCoreWebView2Delegates, uWVCoreWebView2EnvironmentOptions;

constructor TWVBrowserBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCoreWebView2PrintSettings                       := nil;
  FCoreWebView2Settings                            := nil;
  FCoreWebView2Environment                         := nil;
  FCoreWebView2Controller                          := nil;
  FCoreWebView2CompositionController               := nil;
  FCoreWebView2                                    := nil;
  FDefaultURL                                      := '';
  FAdditionalBrowserArguments                      := '';
  FLanguage                                        := '';
  FUseDefaultEnvironment                           := False;
  FUseCompositionController                        := False;
  FTargetCompatibleBrowserVersion                  := LowestChromiumVersion;
  FAllowSingleSignOnUsingOSPrimaryAccount          := False;
  FZoomStep                                        := ZOOM_STEP_DEF;
  FOffline                                         := False;

  FOldWidget0CompWndPrc                            := nil;
  FOldWidget1CompWndPrc                            := nil;
  FOldRenderCompWndPrc                             := nil;
  FOldD3DWindowCompWndPrc                          := nil;
  FWidget0CompStub                                 := nil;
  FWidget1CompStub                                 := nil;
  FRenderCompStub                                  := nil;
  FD3DWindowCompStub                               := nil;
  FWidget0CompHWND                                 := 0;
  FWidget1CompHWND                                 := 0;
  FRenderCompHWND                                  := 0;
  FD3DWindowCompHWND                               := 0;

  FOnInitializationError                           := nil;
  FOnEnvironmentCompleted                          := nil;
  FOnControllerCompleted                           := nil;
  FOnAfterCreated                                  := nil;
  FOnExecuteScriptCompleted                        := nil;
  FOnCapturePreviewCompleted                       := nil;
  FOnNavigationStarting                            := nil;
  FOnNavigationCompleted                           := nil;
  FOnFrameNavigationStarting                       := nil;
  FOnFrameNavigationCompleted                      := nil;
  FOnSourceChanged                                 := nil;
  FOnHistoryChanged                                := nil;
  FOnContentLoading                                := nil;
  FOnDocumentTitleChanged                          := nil;
  FOnNewWindowRequested                            := nil;
  FOnWebResourceRequested                          := nil;
  FOnScriptDialogOpening                           := nil;
  FOnPermissionRequested                           := nil;
  FOnProcessFailed                                 := nil;
  FOnWebMessageReceived                            := nil;
  FOnContainsFullScreenElementChanged              := nil;
  FOnWindowCloseRequested                          := nil;
  FOnDevToolsProtocolEventReceived                 := nil;
  FOnZoomFactorChanged                             := nil;
  FOnMoveFocusRequested                            := nil;
  FOnAcceleratorKeyPressed                         := nil;
  FOnGotFocus                                      := nil;
  FOnLostFocus                                     := nil;
  FOnCursorChanged                                 := nil;
  FOnBrowserProcessExited                          := nil;
  FOnRasterizationScaleChanged                     := nil;
  FOnWebResourceResponseReceived                   := nil;
  FOnDOMContentLoaded                              := nil;
  FOnWebResourceResponseViewGetContentCompleted    := nil;
  FOnGetCookiesCompleted                           := nil;
  FOnTrySuspendCompleted                           := nil;
  FOnFrameCreated                                  := nil;
  FOnDownloadStarting                              := nil;
  FOnClientCertificateRequested                    := nil;
  FOnPrintToPdfCompleted                           := nil;
  FOnBytesReceivedChanged                          := nil;
  FOnEstimatedEndTimeChanged                       := nil;
  FOnDownloadStateChanged                          := nil;
  FOnFrameNameChanged                              := nil;
  FOnFrameDestroyed                                := nil;
  FOnCompositionControllerCompleted                := nil;
  FOnCallDevToolsProtocolMethodCompleted           := nil;
  FOnAddScriptToExecuteOnDocumentCreatedCompleted  := nil;
  FOnWidget0CompMsg                                := nil;
  FOnWidget1CompMsg                                := nil;
  FOnRenderCompMsg                                 := nil;
  FOnD3DWindowCompMsg                              := nil;
end;

destructor TWVBrowserBase.Destroy;
begin
  try
    RestoreOldCompWndProc;
    DestroyPrintSettings;
    DestroySettings;
    DestroyEnvironment;
    DestroyWebView;
    DestroyController;
    DestroyCompositionController;
  finally
    inherited Destroy;
  end;
end;

procedure TWVBrowserBase.DestroyEnvironment;
begin
  if assigned(FCoreWebView2Environment) then
    FreeAndNil(FCoreWebView2Environment);
end;

procedure TWVBrowserBase.DestroyController;
begin
  if assigned(FCoreWebView2Controller) then
    FreeAndNil(FCoreWebView2Controller);
end;

procedure TWVBrowserBase.DestroyCompositionController;
begin
  if assigned(FCoreWebView2CompositionController) then
    FreeAndNil(FCoreWebView2CompositionController);
end;

procedure TWVBrowserBase.DestroyWebView;
begin
  if assigned(FCoreWebView2) then
    FreeAndNil(FCoreWebView2);
end;

procedure TWVBrowserBase.DestroySettings;
begin
  if assigned(FCoreWebView2Settings) then
    FreeAndNil(FCoreWebView2Settings);
end;

procedure TWVBrowserBase.DestroyPrintSettings;
begin
  if assigned(FCoreWebView2PrintSettings) then
    FreeAndNil(FCoreWebView2PrintSettings);
end;

{$IFNDEF FPC}
// Windows XP and newer (older Delphi version < XE don't have them and newer
// require a call to InitCommonControl what isn't necessary.
{type
  SUBCLASSPROC = function(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM;
    uIdSubclass: UINT_PTR; dwRefData: DWORD_PTR): LRESULT; stdcall;
  TSubClassProc = SUBCLASSPROC;

function SetWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC; uIdSubclass: UINT_PTR; dwRefData: DWORD_PTR): BOOL; stdcall;
  external comctl32 name 'SetWindowSubclass';
//function GetWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC; uIdSubclass: UINT_PTR; var pdwRefData: DWORD_PTR): BOOL; stdcall;
//  external comctl32 name 'GetWindowSubclass';
function RemoveWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC; uIdSubclass: UINT_PTR): BOOL; stdcall;
  external comctl32 name 'RemoveWindowSubclass';
function DefSubclassProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
  external comctl32 name 'DefSubclassProc';

// We stick with the original implementation because the WndProc stub is a lot
// faster than the WindowSubClass stub that uses the slow GetProp(hWnd). Which
// is extremly slow in Windows 10 1809 and newer.
}

procedure TWVBrowserBase.CreateStub(const aMethod : TWndMethod; var aStub : Pointer);
begin
  if (aStub = nil) then aStub := MakeObjectInstance(aMethod);
end;

procedure TWVBrowserBase.FreeAndNilStub(var aStub : pointer);
begin
  if (aStub <> nil) then
    begin
      FreeObjectInstance(aStub);
      aStub := nil;
    end;
end;

function TWVBrowserBase.InstallCompWndProc(aWnd: THandle; aStub: Pointer): TFNWndProc;
begin
  Result := TFNWndProc(SetWindowLongPtr(aWnd, GWLP_WNDPROC, NativeInt(aStub)));
end;

procedure TWVBrowserBase.RestoreCompWndProc(var aOldWnd: THandle; aNewWnd: THandle; var aProc: TFNWndProc);
begin
  if (aOldWnd <> 0) and (aOldWnd <> aNewWnd) and (aProc <> nil) then
    begin
      SetWindowLongPtr(aOldWnd, GWLP_WNDPROC, NativeInt(aProc));
      aProc := nil;
      aOldWnd := 0;
    end;
end;

procedure TWVBrowserBase.CallOldCompWndProc(aProc: TFNWndProc; aWnd: THandle; var aMessage: TMessage);
begin
  if (aProc <> nil) and (aWnd <> 0) then
    aMessage.Result := CallWindowProc(aProc, aWnd, aMessage.Msg, aMessage.wParam, aMessage.lParam);
end;

{$ELSE}

procedure TWVBrowserBase.CreateStub(const aMethod : TWndMethod; var aStub : Pointer);
begin
  if (aStub = nil) then
    begin
      GetMem(aStub, SizeOf(TWndMethod));
      TWndMethod(aStub^) := aMethod;
    end;
end;

procedure TWVBrowserBase.FreeAndNilStub(var aStub : pointer);
begin
  if (aStub <> nil) then
    begin
      FreeMem(aStub);
      aStub := nil;
    end;
end;

function CompSubClassProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM;
  uIdSubclass: UINT_PTR; dwRefData: DWORD_PTR): LRESULT; stdcall;
var
  m: TWndMethod;
  Msg: TMessage;
begin
  Msg.msg := uMsg;
  Msg.wParam := wparam;
  Msg.lParam := lParam;
  Msg.Result := 0;

  m := TWndMethod(Pointer(dwRefData)^);
  m(Msg);
  Result := Msg.Result;
end;

function TWVBrowserBase.InstallCompWndProc(aWnd: THandle; aStub: Pointer): TFNWndProc;
begin
  Result := nil;
  if (aWnd <> 0) and (aStub <> nil) then
    begin
      SetWindowSubclass(aWnd, @CompSubClassProc, 1, NativeInt(aStub));
      Result := TFNWndProc(1); // IdSubClass
    end;
end;

procedure TWVBrowserBase.RestoreCompWndProc(var aOldWnd: THandle; aNewWnd: THandle; var aProc: TFNWndProc);
begin
  if (aOldWnd <> 0) and (aOldWnd <> aNewWnd) and (aProc <> nil) then
    begin
      RemoveWindowSubclass(aOldWnd, @CompSubClassProc, 1);
      aProc := nil;
      aOldWnd := 0;
    end;
end;

procedure TWVBrowserBase.CallOldCompWndProc(aProc: TFNWndProc; aWnd: THandle; var aMessage: TMessage);
begin
  if (aProc <> nil) and (aWnd <> 0) then
    aMessage.Result := DefSubclassProc(aWnd, aMessage.Msg, aMessage.wParam, aMessage.lParam);
end;
{$ENDIF}

procedure TWVBrowserBase.Widget0CompWndProc(var aMessage: TMessage);
var
  TempHandled : boolean;
begin
  try
    TempHandled := False;

    try
      if assigned(FOnWidget0CompMsg) then
        FOnWidget0CompMsg(self, aMessage, TempHandled);

      if not(TempHandled) then
        CallOldCompWndProc(FOldWidget0CompWndPrc, FWidget0CompHWND, aMessage);
    finally
      if aMessage.Msg = WM_DESTROY then
        RestoreCompWndProc(FWidget0CompHWND, 0, FOldWidget0CompWndPrc);
    end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVBrowserBase.Widget0CompWndProc', e) then raise;
  end;
end;

procedure TWVBrowserBase.Widget1CompWndProc(var aMessage: TMessage);
var
  TempHandled : boolean;
begin
  try
    TempHandled := False;

    try
      if assigned(FOnWidget1CompMsg) then
        FOnWidget1CompMsg(self, aMessage, TempHandled);

      if not(TempHandled) then
        CallOldCompWndProc(FOldWidget1CompWndPrc, FWidget1CompHWND, aMessage);
    finally
      if aMessage.Msg = WM_DESTROY then
        RestoreCompWndProc(FWidget1CompHWND, 0, FOldWidget1CompWndPrc);
    end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVBrowserBase.Widget1CompWndProc', e) then raise;
  end;
end;

procedure TWVBrowserBase.RenderCompWndProc(var aMessage: TMessage);
var
  TempHandled : boolean;
begin
  try
    TempHandled := False;

    try
      if assigned(FOnRenderCompMsg) then
        FOnRenderCompMsg(self, aMessage, TempHandled);

      if not(TempHandled) then
        CallOldCompWndProc(FOldRenderCompWndPrc, FRenderCompHWND, aMessage);
    finally
      if aMessage.Msg = WM_DESTROY then
        RestoreCompWndProc(FRenderCompHWND, 0, FOldRenderCompWndPrc);
    end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVBrowserBase.RenderCompWndProc', e) then raise;
  end;
end;

procedure TWVBrowserBase.D3DWindowCompWndProc(var aMessage: TMessage);
var
  TempHandled : boolean;
begin
  try
    TempHandled := False;

    try
      if assigned(FOnD3DWindowCompMsg) then
        FOnD3DWindowCompMsg(self, aMessage, TempHandled);

      if not(TempHandled) then
        CallOldCompWndProc(FOldD3DWindowCompWndPrc, FD3DWindowCompHWND, aMessage);
    finally
      if aMessage.Msg = WM_DESTROY then
        RestoreCompWndProc(FD3DWindowCompHWND, 0, FOldD3DWindowCompWndPrc);
    end;
  except
    on e : exception do
      if CustomExceptionHandler('TWVBrowserBase.D3DWindowCompWndProc', e) then raise;
  end;
end;

procedure TWVBrowserBase.RestoreOldCompWndProc;
begin
  RestoreCompWndProc(FWidget0CompHWND, 0, FOldWidget0CompWndPrc);
  FreeAndNilStub(FWidget0CompStub);

  RestoreCompWndProc(FWidget1CompHWND, 0, FOldWidget1CompWndPrc);
  FreeAndNilStub(FWidget1CompStub);

  RestoreCompWndProc(FRenderCompHWND, 0, FOldRenderCompWndPrc);
  FreeAndNilStub(FRenderCompStub);

  RestoreCompWndProc(FD3DWindowCompHWND, 0, FOldD3DWindowCompWndPrc);
  FreeAndNilStub(FD3DWindowCompStub);
end;

function TWVBrowserBase.AddWebResourceRequestedFilter(const aURI: wvstring; aResourceContext: TWVWebResourceContext) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.AddWebResourceRequestedFilter(aURI, aResourceContext);
end;

function TWVBrowserBase.RemoveWebResourceRequestedFilter(const aURI: wvstring; aResourceContext: TWVWebResourceContext) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.RemoveWebResourceRequestedFilter(aURI, aResourceContext);
end;

function TWVBrowserBase.CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CapturePreview(aImageFormat, aImageStream, self);
end;

function TWVBrowserBase.EnvironmentCompletedHandler_Invoke(errorCode: HRESULT; const createdEnvironment: ICoreWebView2Environment): HRESULT;
var
  TempResult : boolean;
  TempError  : wvstring;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(createdEnvironment) then
    begin
      DestroyEnvironment;
      FCoreWebView2Environment := TCoreWebView2Environment.Create(createdEnvironment);

      doOnEnvironmentCompleted;

      if FUseCompositionController then
        TempResult := FCoreWebView2Environment.CreateCoreWebView2CompositionController(FWindowParentHandle, self)
       else
        TempResult := FCoreWebView2Environment.CreateCoreWebView2Controller(FWindowParentHandle, self);

      if not(TempResult) then
        doOnInitializationError(E_FAIL, 'There was an error creating the controller');
    end
   else
    begin
      TempError := 'There was a problem initializing the browser environment.' + CRLF + CRLF +
                   'Error code : 0x' +
                   {$IFDEF FPC}
                   UTF8Decode(inttohex(errorCode, 8))
                   {$ELSE}
                   inttohex(errorCode, 8)
                   {$ENDIF}
                   + CRLF + EnvironmentCreationErrorToString(errorCode);

      doOnInitializationError(errorCode, TempError);
    end;
end;

function TWVBrowserBase.ControllerCompletedHandler_Invoke(errorCode: HRESULT; const createdController: ICoreWebView2Controller): HRESULT;
var
  TempSettings      : ICoreWebView2Settings;
  TempPrintSettings : ICoreWebView2PrintSettings;
  TempCoreWebView2  : ICoreWebView2;
begin
  Result := S_OK;

  try
    if succeeded(errorCode) and assigned(createdController) then
      begin
        DestroyController;
        FCoreWebView2Controller := TCoreWebView2Controller.Create(createdController);

        doOnControllerCompleted;

        TempCoreWebView2 := FCoreWebView2Controller.CoreWebView2;

        if assigned(TempCoreWebView2) then
          begin
            DestroyWebView;
            FCoreWebView2 := TCoreWebView2.Create(TempCoreWebView2);
            TempSettings  := FCoreWebView2.Settings;

            if assigned(TempSettings) then
              begin
                DestroySettings;
                FCoreWebView2Settings := TCoreWebView2Settings.Create(TempSettings);

                if FCoreWebView2Environment.CreatePrintSettings(TempPrintSettings) then
                  begin
                    DestroyPrintSettings;
                    FCoreWebView2PrintSettings := TCoreWebView2PrintSettings.Create(TempPrintSettings);
                  end;

                if not(FUseDefaultEnvironment) then
                  FCoreWebView2Environment.AddAllBrowserEvents(self);

                FCoreWebView2.AddAllBrowserEvents(self);
                FCoreWebView2Controller.AddAllBrowserEvents(self);

                if assigned(FCoreWebView2CompositionController) then
                  FCoreWebView2CompositionController.AddAllBrowserEvents(self);

                doOnAfterCreated;

                if (Length(FDefaultURL) > 0) then
                  Navigate(FDefaultURL);
              end
             else
              doOnInitializationError(E_FAIL, 'There was an error getting the browser settings.');
          end
         else
          doOnInitializationError(E_FAIL, 'There was an error getting the browser webview.');
      end
     else
      doOnInitializationError(errorCode, 'There was an error creating the controller.');
  finally
    TempSettings     := nil;
    TempCoreWebView2 := nil;
  end;
end;

procedure TWVBrowserBase.ReplaceWndProcs;
var
  OldWidget0CompHWND, OldWidget1CompHWND, OldRenderCompHWND, OldD3DWindowCompHWND: THandle;
  NewWidget0CompHWND, NewWidget1CompHWND, NewRenderCompHWND, NewD3DWindowCompHWND: THandle;
begin
  if (FWindowParentHandle <> 0) then
    begin
      NewWidget0CompHWND := FindWindowEx(FWindowParentHandle, 0, 'Chrome_WidgetWin_0', '');

      if (FWidget0CompHWND <> NewWidget0CompHWND) then
        begin
          OldWidget0CompHWND := FWidget0CompHWND;
          FWidget0CompHWND   := NewWidget0CompHWND;
          RestoreCompWndProc(OldWidget0CompHWND, FWidget0CompHWND, FOldWidget0CompWndPrc);

          if assigned(FOnWidget0CompMsg) and (FWidget0CompHWND <> 0) and (FOldWidget0CompWndPrc = nil) then
            begin
              CreateStub({$IFDEF FPC}@{$ENDIF}Widget0CompWndProc, FWidget0CompStub);
              FOldWidget0CompWndPrc := InstallCompWndProc(FWidget0CompHWND, FWidget0CompStub);
            end;
        end;
    end;


  if (FWidget0CompHWND <> 0) then
    begin
      NewWidget1CompHWND := FindWindowEx(FWidget0CompHWND, 0, 'Chrome_WidgetWin_1', nil);

      if (FWidget1CompHWND <> NewWidget1CompHWND) then
        begin
          OldWidget1CompHWND := FWidget1CompHWND;
          FWidget1CompHWND   := NewWidget1CompHWND;
          RestoreCompWndProc(OldWidget1CompHWND, FWidget1CompHWND, FOldWidget1CompWndPrc);

          if assigned(FOnWidget1CompMsg) and (FWidget1CompHWND <> 0) and (FOldWidget1CompWndPrc = nil) then
            begin
              CreateStub({$IFDEF FPC}@{$ENDIF}Widget1CompWndProc, FWidget1CompStub);
              FOldWidget1CompWndPrc := InstallCompWndProc(FWidget1CompHWND, FWidget1CompStub);
            end;
        end;
    end;


  if (FWidget1CompHWND <> 0) then
    begin
      NewRenderCompHWND := FindWindowEx(FWidget1CompHWND, 0, 'Chrome_RenderWidgetHostHWND', 'Chrome Legacy Window');

      if (FRenderCompHWND <> NewRenderCompHWND) then
        begin
          OldRenderCompHWND := FRenderCompHWND;
          FRenderCompHWND   := NewRenderCompHWND;
          RestoreCompWndProc(OldRenderCompHWND, FRenderCompHWND, FOldRenderCompWndPrc);

          if assigned(FOnRenderCompMsg) and (FRenderCompHWND <> 0) and (FOldRenderCompWndPrc = nil) then
            begin
              CreateStub({$IFDEF FPC}@{$ENDIF}RenderCompWndProc, FRenderCompStub);
              FOldRenderCompWndPrc := InstallCompWndProc(FRenderCompHWND, FRenderCompStub);
            end;
        end;


      NewD3DWindowCompHWND := FindWindowEx(FWidget1CompHWND, 0, 'Intermediate D3D Window', nil);

      if (FD3DWindowCompHWND <> NewD3DWindowCompHWND) then
        begin
          OldD3DWindowCompHWND := FD3DWindowCompHWND;
          FD3DWindowCompHWND   := NewD3DWindowCompHWND;
          RestoreCompWndProc(OldD3DWindowCompHWND, FD3DWindowCompHWND, FOldD3DWindowCompWndPrc);

          if assigned(FOnD3DWindowCompMsg) and (FD3DWindowCompHWND <> 0) and (FOldD3DWindowCompWndPrc = nil) then
            begin
              CreateStub({$IFDEF FPC}@{$ENDIF}D3DWindowCompWndProc, FD3DWindowCompStub);
              FOldD3DWindowCompWndPrc := InstallCompWndProc(FD3DWindowCompHWND, FD3DWindowCompStub);
            end;
        end;
    end;
end;

function TWVBrowserBase.NavigationStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HRESULT;
begin
  Result := S_OK;
  ReplaceWndProcs;
  doOnNavigationStarting(sender, args);
end;

function TWVBrowserBase.NavigationCompletedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnNavigationCompleted(sender, args);
end;

function TWVBrowserBase.SourceChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SourceChangedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnSourceChanged(sender, args);
end;

function TWVBrowserBase.HistoryChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnHistoryChanged(sender);
end;

function TWVBrowserBase.ContentLoadingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContentLoadingEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnContentLoading(sender, args);
end;

function TWVBrowserBase.DocumentTitleChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnDocumentTitleChanged(sender);
end;

function TWVBrowserBase.NewWindowRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NewWindowRequestedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnNewWindowRequested(sender, args);
end;

function TWVBrowserBase.FrameNavigationStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnFrameNavigationStarting(sender, args);
end;

function TWVBrowserBase.FrameNavigationCompletedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnFrameNavigationCompleted(sender, args);
end;

function TWVBrowserBase.WebResourceRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceRequestedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnWebResourceRequested(sender, args);
end;

function TWVBrowserBase.ScriptDialogOpeningEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScriptDialogOpeningEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnScriptDialogOpening(sender, args);
end;

function TWVBrowserBase.PermissionRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2PermissionRequestedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnPermissionRequested(sender, args);
end;

function TWVBrowserBase.ProcessFailedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnProcessFailed(sender, args);
end;

function TWVBrowserBase.WebMessageReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebMessageReceivedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnWebMessageReceived(sender, args);
end;

function TWVBrowserBase.ContainsFullScreenElementChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnContainsFullScreenElementChanged(sender);
end;

function TWVBrowserBase.WindowCloseRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnWindowCloseRequested(sender);
end;

function TWVBrowserBase.ZoomFactorChangedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnZoomFactorChanged(sender);
end;

function TWVBrowserBase.MoveFocusRequestedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2MoveFocusRequestedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnMoveFocusRequested(sender, args);
end;

function TWVBrowserBase.AcceleratorKeyPressedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: ICoreWebView2AcceleratorKeyPressedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnAcceleratorKeyPressed(sender, args);
end;

function TWVBrowserBase.GotFocusEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnGotFocus(sender);
end;

function TWVBrowserBase.LostFocusEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnLostFocus(sender);
end;

function TWVBrowserBase.CreateCoreWebView2CompositionControllerCompletedHandler_Invoke(errorCode: HResult; const webView: ICoreWebView2CompositionController): HRESULT;
var
  TempControllerIntf : ICoreWebView2Controller;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(webView) then
    begin
      DestroyCompositionController;
      FCoreWebView2CompositionController := TCoreWebView2CompositionController.Create(webView);

      doOnCompositionControllerCompleted;

      if succeeded(webView.QueryInterface(IID_ICoreWebView2Controller, TempControllerIntf)) then
        Result := ControllerCompletedHandler_Invoke(errorCode, TempControllerIntf)
       else
        doOnInitializationError(E_FAIL, 'There was an error creating the controller.');
    end
   else
    doOnInitializationError(E_FAIL, 'There was an error creating the composition controller.');
end;

function TWVBrowserBase.CursorChangedEventHandler_Invoke(const sender: ICoreWebView2CompositionController; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnCursorChangedEvent(sender);
end;

function TWVBrowserBase.BrowserProcessExitedEventHandler_Invoke(const sender : ICoreWebView2Environment;
                                                                  const args   : ICoreWebView2BrowserProcessExitedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnBrowserProcessExitedEvent(sender, args);
end;

function TWVBrowserBase.RasterizationScaleChangedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnRasterizationScaleChangedEvent(sender);
end;

function TWVBrowserBase.WebResourceResponseReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnWebResourceResponseReceivedEvent(sender, args);
end;

function TWVBrowserBase.DOMContentLoadedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnDOMContentLoadedEvent(sender, args);
end;

function TWVBrowserBase.WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode: HResult; const Content: IStream): HRESULT;
begin
  Result := S_OK;
  doOnWebResourceResponseViewGetContentCompletedEvent(errorCode, Content);
end;

function TWVBrowserBase.GetCookiesCompletedHandler_Invoke(aResult : HResult; const aCookieList : ICoreWebView2CookieList): HRESULT;
begin
  Result := S_OK;
  doOnGetCookiesCompletedEvent(aResult, aCookieList);
end;

function TWVBrowserBase.TrySuspendCompletedHandler_Invoke(errorCode: HResult; isSuccessful: Integer): HRESULT;
begin
  Result := S_OK;
  doOnTrySuspendCompletedEvent(errorCode, isSuccessful);
end;

function TWVBrowserBase.FrameCreatedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnFrameCreatedEvent(sender, args);
end;

function TWVBrowserBase.DownloadStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnDownloadStartingEvent(sender, args);
end;

function TWVBrowserBase.ClientCertificateRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnClientCertificateRequestedEvent(sender, args);
end;

function TWVBrowserBase.PrintToPdfCompletedHandler_Invoke(errorCode: HResult; isSuccessful: Integer): HRESULT;
begin
  Result := S_OK;
  doOnPrintToPdfCompletedEvent(errorCode, isSuccessful);
end;

function TWVBrowserBase.BytesReceivedChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
begin
  Result := S_OK;
  doOnBytesReceivedChangedEventEvent(sender, args, aDownloadID);
end;

function TWVBrowserBase.EstimatedEndTimeChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
begin
  Result := S_OK;
  doOnEstimatedEndTimeChangedEvent(sender, args, aDownloadID);
end;

function TWVBrowserBase.StateChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
begin
  Result := S_OK;
  doOnStateChangedEvent(sender, args, aDownloadID);
end;

function TWVBrowserBase.FrameNameChangedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFrameNameChangedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameDestroyedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFrameDestroyedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.CallDevToolsProtocolMethodCompletedHandler_Invoke(errorCode: HResult; returnObjectAsJson: PWideChar; aExecutionID : integer): HRESULT;
begin
  Result := S_OK;
  doOnCallDevToolsProtocolMethodCompletedEvent(errorCode, wvstring(returnObjectAsJson), aExecutionID);
end;

function TWVBrowserBase.AddScriptToExecuteOnDocumentCreatedCompletedHandler_Invoke(errorCode: HResult; id: PWideChar): HRESULT;
begin
  Result := S_OK;
  doOnAddScriptToExecuteOnDocumentCreatedCompletedEvent(errorCode, wvstring(id));
end;

function TWVBrowserBase.ExecuteScriptCompletedHandler_Invoke(errorCode: HRESULT; resultObjectAsJson: PWideChar; aExecutionID : integer): HRESULT;
begin
  Result := S_OK;
  doOnExecuteScriptCompleted(errorCode, wvstring(resultObjectAsJson), aExecutionID);
end;

function TWVBrowserBase.DevToolsProtocolEventReceivedEventHandler_Invoke(const sender     : ICoreWebView2;
                                                                           const args       : ICoreWebView2DevToolsProtocolEventReceivedEventArgs;
                                                                           const aEventName : wvstring;
                                                                                 aEventID   : integer): HRESULT;
begin
  Result := S_OK;
  doOnDevToolsProtocolEventReceived(sender, args, aEventName, aEventID);
end;

function TWVBrowserBase.CapturePreviewCompletedHandler_Invoke(errorCode: HRESULT): HRESULT;
begin
  Result := S_OK;
  doCapturePreviewCompleted(errorCode);
end;

function TWVBrowserBase.CreateBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean) : boolean;
begin
  if aUseDefaultEnvironment and assigned(GlobalWebView2Loader) then
    Result := CreateBrowser(aHandle, GlobalWebView2Loader.Environment)
   else
    Result := CreateBrowser(aHandle, nil);
end;

function TWVBrowserBase.CreateBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean;
begin
  Result := False;

  if (aHandle                  = 0)        or
     (GlobalWebView2Loader     = nil)      or
     not(GlobalWebView2Loader.Initialized) or
     Initialized                           then
    exit;

  FWindowParentHandle := aHandle;

  if assigned(aEnvironment) then
    begin
      DestroyEnvironment;
      FUseDefaultEnvironment   := True;
      FCoreWebView2Environment := TCoreWebView2Environment.Create(aEnvironment);
      Result                   := FCoreWebView2Environment.CreateCoreWebView2Controller(FWindowParentHandle, self);
    end
   else
    Result := CreateEnvironment;
end;

function TWVBrowserBase.CreateWindowlessBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean) : boolean;
begin
  if aUseDefaultEnvironment and assigned(GlobalWebView2Loader) then
    Result := CreateWindowlessBrowser(aHandle, GlobalWebView2Loader.Environment)
   else
    Result := CreateWindowlessBrowser(aHandle, nil);
end;

function TWVBrowserBase.CreateWindowlessBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean;
begin
  Result := False;

  if (aHandle                  = 0)        or
     (GlobalWebView2Loader     = nil)      or
     not(GlobalWebView2Loader.Initialized) or
     Initialized                           then
    exit;

  FWindowParentHandle       := aHandle;
  FUseCompositionController := True;

  if assigned(aEnvironment) then
    begin
      DestroyEnvironment;
      FUseDefaultEnvironment   := True;
      FCoreWebView2Environment := TCoreWebView2Environment.Create(aEnvironment);

      if FCoreWebView2Environment.SupportsCompositionController then
        Result := FCoreWebView2Environment.CreateCoreWebView2CompositionController(FWindowParentHandle, self);
    end
   else
    Result := CreateEnvironment;
end;

function TWVBrowserBase.ExecuteScript(const aJavaScript : wvstring; aExecutionID : integer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.ExecuteScript(aJavaScript, aExecutionID, self);
end;

function TWVBrowserBase.GetBrowserProcessID: cardinal;
begin
  if Initialized then
    Result := FCoreWebView2.BrowserProcessID
   else
    Result := 0;
end;

function TWVBrowserBase.GetBrowserVersionInfo: wvstring;
begin
  if Initialized then
    Result := FCoreWebView2Environment.BrowserVersionInfo
   else
    Result := '';
end;

function TWVBrowserBase.GetUserDataFolder: wvstring;
begin
  if Initialized then
    Result := FCoreWebView2Environment.UserDataFolder
   else
    Result := FUserDataFolder;
end;

function TWVBrowserBase.GetCanGoBack: boolean;
begin
  Result := Initialized and
            FCoreWebView2.CanGoBack;
end;

function TWVBrowserBase.GetIsSuspended: boolean;
begin
  Result := Initialized and
            FCoreWebView2.IsSuspended;
end;

function TWVBrowserBase.GetCanGoForward: boolean;
begin
  Result := Initialized and
            FCoreWebView2.CanGoForward;
end;

function TWVBrowserBase.GetContainsFullScreenElement: boolean;
begin
  Result := Initialized and
            FCoreWebView2.ContainsFullScreenElement;
end;

function TWVBrowserBase.GetBuiltInErrorPageEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsBuiltInErrorPageEnabled;
end;

function TWVBrowserBase.GetDefaultContextMenusEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.AreDefaultContextMenusEnabled;
end;

function TWVBrowserBase.GetDefaultScriptDialogsEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.AreDefaultScriptDialogsEnabled;
end;

function TWVBrowserBase.GetDevToolsEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.AreDevToolsEnabled;
end;

function TWVBrowserBase.GetDocumentTitle: wvstring;
begin
  if Initialized then
    Result := FCoreWebView2.DocumentTitle
   else
    Result := '';
end;

function TWVBrowserBase.GetSource: wvstring;
begin
  if Initialized then
    Result := FCoreWebView2.Source
   else
    Result := '';
end;

function TWVBrowserBase.GetCookieManager : ICoreWebView2CookieManager;
begin
  if Initialized then
    Result := FCoreWebView2.CookieManager
   else
    Result := nil;
end;

function TWVBrowserBase.GetScriptEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsScriptEnabled;
end;

function TWVBrowserBase.GetStatusBarEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsStatusBarEnabled;
end;

function TWVBrowserBase.GetWebMessageEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsWebMessageEnabled;
end;

function TWVBrowserBase.GetInitialized: boolean;
begin
  Result := (FCoreWebView2Environment <> nil) and FCoreWebView2Environment.Initialized and
            (FCoreWebView2            <> nil) and FCoreWebView2.Initialized            and
            (FCoreWebView2Settings    <> nil) and FCoreWebView2Settings.Initialized    and
            (FCoreWebView2Controller  <> nil) and FCoreWebView2Controller.Initialized  and
            (not(FUseCompositionController) or ((FCoreWebView2CompositionController <> nil) and FCoreWebView2CompositionController.Initialized));
end;

function TWVBrowserBase.GetZoomControlEnabled: boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsZoomControlEnabled;
end;

function TWVBrowserBase.GetIsVisible : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.IsVisible;
end;

function TWVBrowserBase.GetBounds : TRect;
begin
  if Initialized then
    Result := FCoreWebView2Controller.Bounds
   else
    Result := rect(0, 0, 0, 0);
end;

function TWVBrowserBase.GetParentWindow : THandle;
begin
  if Initialized then
    Result := FCoreWebView2Controller.ParentWindow
   else
    Result := 0;
end;

function TWVBrowserBase.GetDefaultBackgroundColor : TColor;
begin
  if Initialized then
    Result := FCoreWebView2Controller.DefaultBackgroundColor
   else
    {$IFDEF FPC}
    Result := clNone;
    {$ELSE}
    Result := TColors.SysNone;  // clNone
    {$ENDIF}
end;

function TWVBrowserBase.GetRasterizationScale : double;
begin
  if Initialized then
    Result := FCoreWebView2Controller.RasterizationScale
   else
    Result := 0;
end;

function TWVBrowserBase.GetShouldDetectMonitorScaleChanges : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.ShouldDetectMonitorScaleChanges;
end;

function TWVBrowserBase.GetBoundsMode : TWVBoundsMode;
begin
  if Initialized then
    Result := FCoreWebView2Controller.BoundsMode
   else
    Result := 0;
end;

function TWVBrowserBase.GetAreHostObjectsAllowed : boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.AreHostObjectsAllowed;
end;

function TWVBrowserBase.GetUserAgent : wvstring;
begin
  if Initialized then
    Result := FCoreWebView2Settings.UserAgent
   else
    Result := '';
end;

function TWVBrowserBase.GetAreBrowserAcceleratorKeysEnabled : boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.AreBrowserAcceleratorKeysEnabled;
end;

function TWVBrowserBase.GetIsPasswordAutosaveEnabled : boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsPasswordAutosaveEnabled;
end;

function TWVBrowserBase.GetIsGeneralAutofillEnabled : boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsGeneralAutofillEnabled;
end;

function TWVBrowserBase.GetIsPinchZoomEnabled : boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsPinchZoomEnabled;
end;

function TWVBrowserBase.GetIsSwipeNavigationEnabled : boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsSwipeNavigationEnabled;
end;

function TWVBrowserBase.GetZoomFactor: Double;
begin
  if Initialized then
    Result := FCoreWebView2Controller.ZoomFactor
   else
    Result := 0;
end;

function TWVBrowserBase.GetZoomPct : double;
begin
  Result := ZoomFactor * 100;
end;

function TWVBrowserBase.GoBack : boolean;
begin
  Result := Initialized and
            FCoreWebView2.GoBack;
end;

function TWVBrowserBase.GoForward : boolean;
begin
  Result := Initialized and
            FCoreWebView2.GoForward;
end;

function TWVBrowserBase.CreateEnvironment : boolean;
var
  TempOptions : ICoreWebView2EnvironmentOptions;
  TempHandler : ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler;
begin
  try
    TempHandler := TCoreWebView2EnvironmentCompletedHandler.Create(self);

    TempOptions := TCoreWebView2EnvironmentOptions.Create(FAdditionalBrowserArguments,
                                                          FLanguage,
                                                          FTargetCompatibleBrowserVersion,
                                                          FAllowSingleSignOnUsingOSPrimaryAccount);

    Result := succeeded(CreateCoreWebView2EnvironmentWithOptions(PWideChar(FBrowserExecPath),
                                                                 PWideChar(FUserDataFolder),
                                                                 TempOptions,
                                                                 TempHandler));
  finally
    TempOptions := nil;
    TempHandler := nil;
  end;
end;

function TWVBrowserBase.Navigate(const aURI : wvstring): boolean;
begin
  Result := Initialized and
            FCoreWebView2.Navigate(aURI);
end;

function TWVBrowserBase.NavigateToString(const aHTMLContent: wvstring): boolean;
begin
  Result := Initialized and
            FCoreWebView2.NavigateToString(PWideChar(aHTMLContent));
end;

function TWVBrowserBase.NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.NavigateWithWebResourceRequest(aRequest);
end;

function TWVBrowserBase.Refresh : boolean;
begin
  Result := Initialized and
            FCoreWebView2.Reload;
end;

procedure TWVBrowserBase.SetBounds(aValue : TRect);
begin
  if Initialized then
    FCoreWebView2Controller.Bounds := aValue;
end;

procedure TWVBrowserBase.SetParentWindow(aValue : THandle);
begin
  if Initialized then
    FCoreWebView2Controller.ParentWindow := aValue;
end;

procedure TWVBrowserBase.SetDefaultBackgroundColor(const aValue : TColor);
begin
  if Initialized then
    FCoreWebView2Controller.DefaultBackgroundColor := aValue;
end;

procedure TWVBrowserBase.SetRasterizationScale(const aValue : double);
begin
  if Initialized then
    FCoreWebView2Controller.RasterizationScale := aValue;
end;

procedure TWVBrowserBase.SetShouldDetectMonitorScaleChanges(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Controller.ShouldDetectMonitorScaleChanges := aValue;
end;

procedure TWVBrowserBase.SetBoundsMode(aValue : TWVBoundsMode);
begin
  if Initialized then
    FCoreWebView2Controller.BoundsMode := aValue;
end;

procedure TWVBrowserBase.SetAreHostObjectsAllowed(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreHostObjectsAllowed := aValue;
end;

procedure TWVBrowserBase.SetUserAgent(const aValue : wvstring);
begin
  if Initialized then
    FCoreWebView2Settings.UserAgent := aValue;
end;

procedure TWVBrowserBase.SetAreBrowserAcceleratorKeysEnabled(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreBrowserAcceleratorKeysEnabled := aValue;
end;

procedure TWVBrowserBase.SetIsPasswordAutosaveEnabled(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsPasswordAutosaveEnabled := aValue;
end;

procedure TWVBrowserBase.SetIsGeneralAutofillEnabled(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsGeneralAutofillEnabled := aValue;
end;

procedure TWVBrowserBase.SetIsPinchZoomEnabled(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsPinchZoomEnabled := aValue;
end;

procedure TWVBrowserBase.SetIsSwipeNavigationEnabled(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsSwipeNavigationEnabled := aValue;
end;

procedure TWVBrowserBase.SetBuiltInErrorPageEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsBuiltInErrorPageEnabled := Value;
end;

procedure TWVBrowserBase.SetDefaultContextMenusEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreDefaultContextMenusEnabled := Value;
end;

procedure TWVBrowserBase.SetDefaultScriptDialogsEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreDefaultScriptDialogsEnabled := Value;
end;

procedure TWVBrowserBase.SetDevToolsEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreDevToolsEnabled := Value;
end;

function TWVBrowserBase.SetFocus : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.MoveFocus(COREWEBVIEW2_MOVE_FOCUS_REASON_PROGRAMMATIC);
end;

function TWVBrowserBase.FocusNext : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.MoveFocus(COREWEBVIEW2_MOVE_FOCUS_REASON_NEXT);
end;

function TWVBrowserBase.FocusPrevious : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.MoveFocus(COREWEBVIEW2_MOVE_FOCUS_REASON_PREVIOUS);
end;

function TWVBrowserBase.SetBoundsAndZoomFactor(aBounds: TRect; const aZoomFactor: double) : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.SetBoundsAndZoomFactor(aBounds, aZoomFactor);
end;

function TWVBrowserBase.NotifyParentWindowPositionChanged : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.NotifyParentWindowPositionChanged;
end;

function TWVBrowserBase.TrySuspend : boolean;
var
  TempHandler : ICoreWebView2TrySuspendCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2TrySuspendCompletedHandler.Create(self);
      Result      := FCoreWebView2.TrySuspend(TempHandler);
    finally
      TempHandler := nil;
    end;
end;

function TWVBrowserBase.Resume : boolean;
begin
  Result := Initialized and
            FCoreWebView2.Resume;
end;

function TWVBrowserBase.SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
begin
  Result := Initialized and
            FCoreWebView2.SetVirtualHostNameToFolderMapping(aHostName, aFolderPath, aAccessKind);
end;

function TWVBrowserBase.ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.ClearVirtualHostNameToFolderMapping(aHostName);
end;

function TWVBrowserBase.OpenTaskManagerWindow : boolean;
begin
  Result := Initialized and
            FCoreWebView2.OpenTaskManagerWindow;
end;

function TWVBrowserBase.Print : boolean;
begin
  Result := ExecuteScript('window.print();');
end;

function TWVBrowserBase.PrintToPdf(const aResultFilePath : wvstring) : boolean;
var
  TempHandler : ICoreWebView2PrintToPdfCompletedHandler;
begin
  Result := False;

  if Initialized and
     assigned(FCoreWebView2PrintSettings) and
     FCoreWebView2PrintSettings.Initialized then
    try
      TempHandler := TCoreWebView2PrintToPdfCompletedHandler.Create(self);
      Result      := FCoreWebView2.PrintToPdf(aResultFilePath, FCoreWebView2PrintSettings.BaseIntf, TempHandler);
    finally
      TempHandler := nil;
    end;
end;

function TWVBrowserBase.OpenDevToolsWindow : boolean;
begin
  Result := Initialized and
            FCoreWebView2.OpenDevToolsWindow;
end;

function TWVBrowserBase.PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.PostWebMessageAsJson(aWebMessageAsJson);
end;

function TWVBrowserBase.PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.PostWebMessageAsString(aWebMessageAsString);
end;

function TWVBrowserBase.CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CallDevToolsProtocolMethod(aMethodName, aParametersAsJson, aExecutionID, self);
end;

function TWVBrowserBase.AddHostObjectToScript(const aName : wvstring; const aObject : OleVariant): boolean;
begin
  Result := Initialized and
            FCoreWebView2.AddHostObjectToScript(aName, aObject);
end;

function TWVBrowserBase.RemoveHostObjectFromScript(const aName : wvstring) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.RemoveHostObjectFromScript(aName);
end;

function TWVBrowserBase.AddScriptToExecuteOnDocumentCreated(const JavaScript : wvstring) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.AddScriptToExecuteOnDocumentCreated(JavaScript, self);
end;

function TWVBrowserBase.RemoveScriptToExecuteOnDocumentCreated(const aID : wvstring) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.RemoveScriptToExecuteOnDocumentCreated(aID);
end;

function TWVBrowserBase.CreateCookie(const aName, aValue, aDomain, aPath : wvstring) : ICoreWebView2Cookie;
var
  TempManager : TCoreWebView2CookieManager;
begin
  Result := nil;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      Result      := TempManager.CreateCookie(aName, aValue, aDomain, aPath);
    finally
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.CopyCookie(const aCookie : ICoreWebView2Cookie) : ICoreWebView2Cookie;
var
  TempManager : TCoreWebView2CookieManager;
begin
  Result := nil;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      Result      := TempManager.CopyCookie(aCookie);
    finally
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.GetCookies(const aURI : wvstring):  boolean;
var
  TempHandler : ICoreWebView2GetCookiesCompletedHandler;
  TempManager : TCoreWebView2CookieManager;
begin
  Result := False;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      TempHandler := TCoreWebView2GetCookiesCompletedHandler.Create(self);
      Result      := TempManager.GetCookies(aURI, TempHandler);
    finally
      TempHandler := nil;
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.AddOrUpdateCookie(const aCookie : ICoreWebView2Cookie): boolean;
var
  TempManager : TCoreWebView2CookieManager;
begin
  Result := False;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      Result      := TempManager.AddOrUpdateCookie(aCookie);
    finally
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.DeleteCookie(const aCookie : ICoreWebView2Cookie): boolean;
var
  TempManager : TCoreWebView2CookieManager;
begin
  Result := False;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      Result      := TempManager.DeleteCookie(aCookie);
    finally
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.DeleteCookies(const aName, aURI : wvstring): boolean;
var
  TempManager : TCoreWebView2CookieManager;
begin
  Result := False;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      Result      := TempManager.DeleteCookies(aName, aURI);
    finally
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.DeleteCookiesWithDomainAndPath(const aName, aDomain, aPath : wvstring): boolean;
var
  TempManager : TCoreWebView2CookieManager;
begin
  Result := False;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      Result      := TempManager.DeleteCookiesWithDomainAndPath(aName, aDomain, aPath);
    finally
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.DeleteAllCookies : boolean;
var
  TempManager : TCoreWebView2CookieManager;
begin
  Result := False;

  if Initialized then
    try
      TempManager := TCoreWebView2CookieManager.Create(FCoreWebView2.CookieManager);
      Result      := TempManager.DeleteAllCookies;
    finally
      FreeAndNil(TempManager);
    end;
end;

function TWVBrowserBase.ClearCache : boolean;
begin
  Result := CallDevToolsProtocolMethod('Network.clearBrowserCache', '{}');
end;

function TWVBrowserBase.ClearDataForOrigin(const aOrigin : wvstring; aStorageTypes : TWVClearDataStorageTypes) : boolean;
var
  TempParams : wvstring;
begin
  TempParams := '{"origin": "' + aOrigin + '", ';

  case aStorageTypes of
    cdstAppCache        : TempParams := TempParams + '"storageTypes": "appcache"}';
    cdstCookies         : TempParams := TempParams + '"storageTypes": "cookies"}';
    cdstFileSystems     : TempParams := TempParams + '"storageTypes": "file_systems"}';
    cdstIndexeddb       : TempParams := TempParams + '"storageTypes": "indexeddb"}';
    cdstLocalStorage    : TempParams := TempParams + '"storageTypes": "local_storage"}';
    cdstShaderCache     : TempParams := TempParams + '"storageTypes": "shader_cache"}';
    cdstWebsql          : TempParams := TempParams + '"storageTypes": "websql"}';
    cdstServiceWorkers  : TempParams := TempParams + '"storageTypes": "service_workers"}';
    cdstCacheStorage    : TempParams := TempParams + '"storageTypes": "cache_storage"}';
    else                  TempParams := TempParams + '"storageTypes": "all"}';
  end;

  Result := CallDevToolsProtocolMethod('Storage.clearDataForOrigin', TempParams);
end;

procedure TWVBrowserBase.SetOffline(aValue : boolean);
var
  TempParams : wvstring;
begin
  if (FOffline <> aValue) then
    begin
      FOffline := aValue;
      TempParams := '{"offline": ' +
                    {$IFDEF FPC}
                    UTF8Decode(lowercase(BoolToStr(FOffline, True)))
                    {$ELSE}
                    lowercase(BoolToStr(FOffline, True))
                    {$ENDIF}
                    + ', "latency": 0, "downloadThroughput": 0, "uploadThroughput": 0}';

      CallDevToolsProtocolMethod('Network.emulateNetworkConditions', TempParams);
    end;
end;

procedure TWVBrowserBase.SetIgnoreCertificateErrors(aValue : boolean);
var
  TempParams : wvstring;
begin
  if (FIgnoreCertificateErrors <> aValue) then
    begin
      FIgnoreCertificateErrors := aValue;
      TempParams := '{"ignore": ' +
                    {$IFDEF FPC}
                    UTF8Decode(lowercase(BoolToStr(FIgnoreCertificateErrors, True)))
                    {$ELSE}
                    lowercase(BoolToStr(FIgnoreCertificateErrors, True))
                    {$ENDIF}
                     + '}';

      CallDevToolsProtocolMethod('Security.setIgnoreCertificateErrors', TempParams);
    end;
end;

procedure TWVBrowserBase.IncZoomStep;
begin
  UpdateZoomStep(True);
end;

procedure TWVBrowserBase.DecZoomStep;
begin
  UpdateZoomStep(False);
end;

procedure TWVBrowserBase.ResetZoom;
begin
  ZoomStep := ZOOM_STEP_DEF;
end;

procedure TWVBrowserBase.SetScriptEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsScriptEnabled := Value;
end;

procedure TWVBrowserBase.SetStatusBarEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsStatusBarEnabled := Value;
end;

procedure TWVBrowserBase.SetWebMessageEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsWebMessageEnabled := Value;
end;

procedure TWVBrowserBase.SetZoomControlEnabled(const Value: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsZoomControlEnabled := Value;
end;

procedure TWVBrowserBase.SetZoomFactor(const Value: Double);
begin
  if Initialized then
    FCoreWebView2Controller.ZoomFactor := Value;
end;

procedure TWVBrowserBase.SetZoomPct(const aValue : double);
var
  TempZoom : double;
  i : integer;
begin
  if not(Initialized) then exit;

  if (aValue >= ZoomStepValues[ZOOM_STEP_MIN]) and
     (aValue <= ZoomStepValues[ZOOM_STEP_MAX]) then
    begin
      UpdateZoomPct(aValue);
      TempZoom := ZoomPct;

      for i := ZOOM_STEP_MIN to ZOOM_STEP_MAX do
        if (TempZoom = ZoomStepValues[i]) then break;

      FZoomStep := i;
    end;
end;

procedure TWVBrowserBase.SetZoomStep(aValue : byte);
begin
  if not(Initialized) then exit;

  if (aValue in [ZOOM_STEP_MIN..ZOOM_STEP_MAX]) then
    begin
      FZoomStep := aValue;
      UpdateZoomPct(ZoomStepValues[aValue]);
    end;
end;

procedure TWVBrowserBase.SetIsVisible(const aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Controller.IsVisible := aValue;
end;

function TWVBrowserBase.Stop : boolean;
begin
  Result := Initialized and
            FCoreWebView2.Stop;
end;

function TWVBrowserBase.SubscribeToDevToolsProtocolEvent(const aEventName : wvstring; aEventID : integer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.SubscribeToDevToolsProtocolEvent(aEventName, aEventID, self);
end;

procedure TWVBrowserBase.doOnInitializationError(aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  if assigned(FOnInitializationError) then
    FOnInitializationError(self, aErrorCode, aErrorMessage);
end;

procedure TWVBrowserBase.doOnEnvironmentCompleted;
begin
  if assigned(FOnEnvironmentCompleted) then
    FOnEnvironmentCompleted(self);
end;

procedure TWVBrowserBase.doOnControllerCompleted;
begin
  if assigned(FOnControllerCompleted) then
    FOnControllerCompleted(self);
end;

procedure TWVBrowserBase.doOnAfterCreated;
begin
  if assigned(FOnAfterCreated) then
    FOnAfterCreated(self);
end;

procedure TWVBrowserBase.doOnExecuteScriptCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring; aExecutionID : integer);
begin
  if assigned(FOnExecuteScriptCompleted) then
    FOnExecuteScriptCompleted(self, aErrorCode, aResultObjectAsJson, aExecutionID);
end;

procedure TWVBrowserBase.doCapturePreviewCompleted(aErrorCode: HRESULT);
begin
  if assigned(FOnCapturePreviewCompleted) then
    FOnCapturePreviewCompleted(self, aErrorCode);
end;

procedure TWVBrowserBase.doOnNavigationStarting(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs);
begin
  if assigned(FOnNavigationStarting) then
    FOnNavigationStarting(self, sender, args);
end;

procedure TWVBrowserBase.doOnNavigationCompleted(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs);
begin
  if assigned(FOnNavigationCompleted) then
    FOnNavigationCompleted(self, sender, args);
end;

procedure TWVBrowserBase.doOnFrameNavigationStarting(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs);
begin
  if assigned(FOnFrameNavigationStarting) then
    FOnFrameNavigationStarting(self, sender, args);
end;

procedure TWVBrowserBase.doOnFrameNavigationCompleted(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs);
begin
  if assigned(FOnFrameNavigationCompleted) then
    FOnFrameNavigationCompleted(self, sender, args);
end;

procedure TWVBrowserBase.doOnSourceChanged(const sender: ICoreWebView2; const args: ICoreWebView2SourceChangedEventArgs);
begin
  if assigned(FOnSourceChanged) then
    FOnSourceChanged(self, sender, args);
end;

procedure TWVBrowserBase.doOnHistoryChanged(const sender: ICoreWebView2);
begin
  if assigned(FOnHistoryChanged) then
    FOnHistoryChanged(self);
end;

procedure TWVBrowserBase.doOnContentLoading(const sender: ICoreWebView2; const args: ICoreWebView2ContentLoadingEventArgs);
begin
  if assigned(FOnContentLoading) then
    FOnContentLoading(self, sender, args);
end;

procedure TWVBrowserBase.doOnDocumentTitleChanged(const sender: ICoreWebView2);
begin
  if assigned(FOnDocumentTitleChanged) then
    FOnDocumentTitleChanged(self);
end;

procedure TWVBrowserBase.doOnNewWindowRequested(const sender: ICoreWebView2; const args: ICoreWebView2NewWindowRequestedEventArgs);
begin
  if assigned(FOnNewWindowRequested) then
    FOnNewWindowRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnWebResourceRequested(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceRequestedEventArgs);
begin
  if assigned(FOnWebResourceRequested) then
    FOnWebResourceRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnScriptDialogOpening(const sender: ICoreWebView2; const args: ICoreWebView2ScriptDialogOpeningEventArgs);
begin
  if assigned(FOnScriptDialogOpening) then
    FOnScriptDialogOpening(self, sender, args);
end;

procedure TWVBrowserBase.doOnPermissionRequested(const sender: ICoreWebView2; const args: ICoreWebView2PermissionRequestedEventArgs);
begin
  if assigned(FOnPermissionRequested) then
    FOnPermissionRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnProcessFailed(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs);
begin
  if assigned(FOnProcessFailed) then
    FOnProcessFailed(self, sender, args);
end;

procedure TWVBrowserBase.doOnWebMessageReceived(const sender: ICoreWebView2; const args: ICoreWebView2WebMessageReceivedEventArgs);
begin
  if assigned(FOnWebMessageReceived) then
    FOnWebMessageReceived(self, sender, args);
end;

procedure TWVBrowserBase.doOnContainsFullScreenElementChanged(const sender: ICoreWebView2);
begin
  if assigned(FOnContainsFullScreenElementChanged) then
    FOnContainsFullScreenElementChanged(self);
end;

procedure TWVBrowserBase.doOnWindowCloseRequested(const sender: ICoreWebView2);
begin
  if assigned(FOnWindowCloseRequested) then
    FOnWindowCloseRequested(self);
end;

procedure TWVBrowserBase.doOnDevToolsProtocolEventReceived(const sender: ICoreWebView2; const args: ICoreWebView2DevToolsProtocolEventReceivedEventArgs; const aEventName : wvstring; aEventID : integer);
begin
  if assigned(FOnDevToolsProtocolEventReceived) then
    FOnDevToolsProtocolEventReceived(self, sender, args, aEventName, aEventID);
end;

procedure TWVBrowserBase.doOnZoomFactorChanged(const sender: ICoreWebView2Controller);
begin
  if assigned(FOnZoomFactorChanged) then
    FOnZoomFactorChanged(self);
end;

procedure TWVBrowserBase.doOnMoveFocusRequested(const sender: ICoreWebView2Controller; const args: ICoreWebView2MoveFocusRequestedEventArgs);
begin
  if assigned(FOnMoveFocusRequested) then
    FOnMoveFocusRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnAcceleratorKeyPressed(const sender: ICoreWebView2Controller; const args: ICoreWebView2AcceleratorKeyPressedEventArgs);
begin
  if assigned(FOnAcceleratorKeyPressed) then
    FOnAcceleratorKeyPressed(self, sender, args);
end;

procedure TWVBrowserBase.doOnGotFocus(const sender: ICoreWebView2Controller);
begin
  if assigned(FOnGotFocus) then
    FOnGotFocus(self);
end;

procedure TWVBrowserBase.doOnLostFocus(const sender: ICoreWebView2Controller);
begin
  if assigned(FOnLostFocus) then
    FOnLostFocus(self);
end;

procedure TWVBrowserBase.doOnCompositionControllerCompleted;
begin
  if assigned(FOnCompositionControllerCompleted) then
    FOnCompositionControllerCompleted(self);
end;

procedure TWVBrowserBase.doOnCursorChangedEvent(const sender: ICoreWebView2CompositionController);
begin
  if assigned(FOnCursorChanged) then
    FOnCursorChanged(self);
end;

procedure TWVBrowserBase.doOnBrowserProcessExitedEvent(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs);
begin
  if assigned(FOnBrowserProcessExited) then
    FOnBrowserProcessExited(self, sender, args);
end;

procedure TWVBrowserBase.doOnRasterizationScaleChangedEvent(const sender: ICoreWebView2Controller);
begin
  if assigned(FOnRasterizationScaleChanged) then
    FOnRasterizationScaleChanged(self);
end;

procedure TWVBrowserBase.doOnWebResourceResponseReceivedEvent(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs);
begin
  if assigned(FOnWebResourceResponseReceived) then
    FOnWebResourceResponseReceived(self, sender, args);
end;

procedure TWVBrowserBase.doOnDOMContentLoadedEvent(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs);
begin
  if assigned(FOnDOMContentLoaded) then
    FOnDOMContentLoaded(self, sender, args);
end;

procedure TWVBrowserBase.doOnWebResourceResponseViewGetContentCompletedEvent(errorCode: HResult; const Content: IStream);
begin
  if assigned(FOnWebResourceResponseViewGetContentCompleted) then
    FOnWebResourceResponseViewGetContentCompleted(self, errorCode, Content);
end;

procedure TWVBrowserBase.doOnGetCookiesCompletedEvent(aResult : HResult; const aCookieList : ICoreWebView2CookieList);
begin
  if assigned(FOnGetCookiesCompleted) then
    FOnGetCookiesCompleted(self, aResult, aCookieList);
end;

procedure TWVBrowserBase.doOnTrySuspendCompletedEvent(errorCode: HResult; isSuccessful: Integer);
begin
  if assigned(FOnTrySuspendCompleted) then
    FOnTrySuspendCompleted(self, errorCode, (isSuccessful <> 0));
end;

procedure TWVBrowserBase.doOnFrameCreatedEvent(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs);
begin
  if assigned(FOnFrameCreated) then
    FOnFrameCreated(self, sender, args);
end;

procedure TWVBrowserBase.doOnDownloadStartingEvent(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs);
begin
  if assigned(FOnDownloadStarting) then
    FOnDownloadStarting(self, sender, args);
end;

procedure TWVBrowserBase.doOnClientCertificateRequestedEvent(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs);
begin
  if assigned(FOnClientCertificateRequested) then
    FOnClientCertificateRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnPrintToPdfCompletedEvent(errorCode: HResult; isSuccessful: Integer);
begin
  if assigned(FOnPrintToPdfCompleted) then
    FOnPrintToPdfCompleted(self, errorCode, (isSuccessful <> 0));
end;

procedure TWVBrowserBase.doOnBytesReceivedChangedEventEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer);
begin
  if assigned(FOnBytesReceivedChanged) then
    FOnBytesReceivedChanged(self, sender, aDownloadID);
end;

procedure TWVBrowserBase.doOnEstimatedEndTimeChangedEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer);
begin
  if assigned(FOnEstimatedEndTimeChanged) then
    FOnEstimatedEndTimeChanged(self, sender, aDownloadID);
end;

procedure TWVBrowserBase.doOnStateChangedEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer);
begin
  if assigned(FOnDownloadStateChanged) then
    FOnDownloadStateChanged(self, sender, aDownloadID);
end;

procedure TWVBrowserBase.doOnFrameNameChangedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer);
begin
  if assigned(FOnFrameNameChanged) then
    FOnFrameNameChanged(self, sender, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameDestroyedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : integer);
begin
  if assigned(FOnFrameDestroyed) then
    FOnFrameDestroyed(self, sender, aFrameID);
end;

procedure TWVBrowserBase.doOnCallDevToolsProtocolMethodCompletedEvent(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring; aExecutionID : integer);
begin
  if assigned(FOnCallDevToolsProtocolMethodCompleted) then
    FOnCallDevToolsProtocolMethodCompleted(self, aErrorCode, aReturnObjectAsJson, aExecutionID);
end;

procedure TWVBrowserBase.doOnAddScriptToExecuteOnDocumentCreatedCompletedEvent(aErrorCode: HRESULT; const aID : wvstring);
begin
  if assigned(FOnAddScriptToExecuteOnDocumentCreatedCompleted) then
    FOnAddScriptToExecuteOnDocumentCreatedCompleted(self, aErrorCode, aID);
end;

procedure TWVBrowserBase.UpdateZoomStep(aInc : boolean);
var
  TempPct, TempPrev, TempNext : double;
  i : integer;
begin
  if not(Initialized) then exit;

  if (FZoomStep in [ZOOM_STEP_MIN..ZOOM_STEP_MAX]) then
    begin
      if aInc then
        begin
          if (FZoomStep < ZOOM_STEP_MAX) then
            begin
              inc(FZoomStep);
              UpdateZoomPct(ZoomStepValues[FZoomStep]);
            end;
        end
       else
        if (FZoomStep > ZOOM_STEP_MIN) then
        begin
          dec(FZoomStep);
          UpdateZoomPct(ZoomStepValues[FZoomStep]);
        end;
    end
   else
    begin
      TempPct  := ZoomPct;
      TempPrev := 0;
      i        := ZOOM_STEP_MIN;

      repeat
        if (i <= ZOOM_STEP_MAX) then
          TempNext := ZoomStepValues[i]
         else
          TempNext := ZoomStepValues[ZOOM_STEP_MAX] * 2;

        if (TempPct > TempPrev) and (TempPct < TempNext) then
          begin
            if aInc then
              begin
                if (i <= ZOOM_STEP_MAX) then
                  begin
                    FZoomStep := i;
                    UpdateZoomPct(ZoomStepValues[FZoomStep]);
                  end;
              end
             else
              if (i > ZOOM_STEP_MIN) then
                begin
                  FZoomStep := pred(i);
                  UpdateZoomPct(ZoomStepValues[FZoomStep]);
                end;

            i := ZOOM_STEP_MAX + 2;
          end
         else
          begin
            TempPrev := TempNext;
            inc(i);
          end;

      until (i > succ(ZOOM_STEP_MAX));
    end;
end;

procedure TWVBrowserBase.UpdateZoomPct(const aValue : double);
begin
  if (aValue > 0) then
    ZoomFactor := aValue / 100;
end;

end.
