unit uWVBrowserBase;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
    Winapi.Windows, System.Classes, System.Types, System.UITypes, System.SysUtils,
    Winapi.ActiveX, Winapi.Messages, {$IFDEF DELPHI20_UP}System.JSON,{$ENDIF}
    {$IFDEF DELPHI21_UP}System.NetEncoding,{$ELSE}Web.HTTPApp,{$ENDIF}
  {$ELSE}
    Windows, Classes, Types, SysUtils, Graphics, ActiveX, Messages,
    {$IFDEF FPC}httpprotocol, CommCtrl, fpjson, jsonparser,{$ENDIF}
  {$ENDIF}
  uWVTypes, uWVConstants, uWVTypeLibrary, uWVLibFunctions, uWVLoader,
  uWVInterfaces, uWVEvents, uWVCoreWebView2, uWVCoreWebView2Settings,
  uWVCoreWebView2Environment, uWVCoreWebView2Controller,
  uWVCoreWebView2PrintSettings, uWVCoreWebView2CompositionController,
  uWVCoreWebView2CookieManager, uWVCoreWebView2Delegates;

type
  TWVBrowserBase = class(TComponent, IWVBrowserEvents)
    protected
      FCoreWebView2PrintSettings                       : TCoreWebView2PrintSettings;
      FCoreWebView2Settings                            : TCoreWebView2Settings;
      FCoreWebView2Environment                         : TCoreWebView2Environment;
      FCoreWebView2Controller                          : TCoreWebView2Controller;
      FCoreWebView2CompositionController               : TCoreWebView2CompositionController;
      FCoreWebView2                                    : TCoreWebView2;
      FWindowParentHandle                              : THandle;
      FUseDefaultEnvironment                           : boolean;
      FUseCompositionController                        : boolean;
      FDefaultURL                                      : wvstring;
      FBrowserExecPath                                 : wvstring;
      FUserDataFolder                                  : wvstring;
      FAdditionalBrowserArguments                      : wvstring;
      FLanguage                                        : wvstring;
      FTargetCompatibleBrowserVersion                  : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount          : boolean;
      FExclusiveUserDataFolderAccess                   : boolean;
      FCustomCrashReportingEnabled                     : boolean;
      FIgnoreCertificateErrors                         : boolean;
      FZoomStep                                        : byte;
      FOffline                                         : boolean;
      FIsNavigating                                    : boolean;
      FProfileName                                     : wvstring;
      FIsInPrivateModeEnabled                          : boolean;
      FMenuItemHandler                                 : ICoreWebView2CustomItemSelectedEventHandler;
      FClearBrowsingDataCompletedHandler               : ICoreWebView2ClearBrowsingDataCompletedHandler;
      FSetPermissionStateCompletedHandler              : ICoreWebView2SetPermissionStateCompletedHandler;
      FGetNonDefaultPermissionSettingsCompletedHandler : ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler;
      FEnableTrackingPrevention                        : boolean;
      FPreferredTrackingPreventionLevel                : TWVTrackingPreventionLevel;
      FScriptLocale                                    : wvstring;

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
      FOnPrintCompleted                               : TOnPrintCompletedEvent;
      FOnRetrieveHTMLCompleted                        : TOnRetrieveHTMLCompletedEvent;
      FOnRetrieveTextCompleted                        : TOnRetrieveTextCompletedEvent;
      FOnRetrieveMHTMLCompleted                       : TOnRetrieveMHTMLCompletedEvent;
      FOnClearCacheCompleted                          : TOnClearCacheCompletedEvent;
      FOnClearDataForOriginCompleted                  : TOnClearDataForOriginCompletedEvent;
      FOnOfflineCompleted                             : TOnOfflineCompletedEvent;
      FOnIgnoreCertificateErrorsCompleted             : TOnIgnoreCertificateErrorsCompletedEvent;
      FOnRefreshIgnoreCacheCompleted                  : TOnRefreshIgnoreCacheCompletedEvent;
      FOnSimulateKeyEventCompleted                    : TOnSimulateKeyEventCompletedEvent;
      FOnIsMutedChanged                               : TOnIsMutedChangedEvent;
      FOnIsDocumentPlayingAudioChanged                : TOnIsDocumentPlayingAudioChangedEvent;
      FOnIsDefaultDownloadDialogOpenChanged           : TOnIsDefaultDownloadDialogOpenChangedEvent;
      FOnProcessInfosChanged                          : TOnProcessInfosChangedEvent;
      FOnFrameNavigationStarting2                     : TOnFrameNavigationStartingEvent;
      FOnFrameNavigationCompleted2                    : TOnFrameNavigationCompletedEvent;
      FOnFrameContentLoading                          : TOnFrameContentLoadingEvent;
      FOnFrameDOMContentLoaded                        : TOnFrameDOMContentLoadedEvent;
      FOnFrameWebMessageReceived                      : TOnFrameWebMessageReceivedEvent;
      FOnBasicAuthenticationRequested                 : TOnBasicAuthenticationRequestedEvent;
      FOnContextMenuRequested                         : TOnContextMenuRequestedEvent;
      FOnCustomItemSelected                           : TOnCustomItemSelectedEvent;
      FOnStatusBarTextChanged                         : TOnStatusBarTextChangedEvent;
      FOnFramePermissionRequested                     : TOnFramePermissionRequestedEvent;
      FOnClearBrowsingDataCompleted                   : TOnClearBrowsingDataCompletedEvent;
      FOnServerCertificateErrorActionsCompleted       : TOnServerCertificateErrorActionsCompletedEvent;
      FOnServerCertificateErrorDetected               : TOnServerCertificateErrorDetectedEvent;
      FOnFaviconChanged                               : TOnFaviconChangedEvent;
      FOnGetFaviconCompleted                          : TOnGetFaviconCompletedEvent;
      FOnPrintToPdfStreamCompleted                    : TOnPrintToPdfStreamCompletedEvent;
      FOnGetCustomSchemes                             : TOnGetCustomSchemesEvent;
      FOnGetNonDefaultPermissionSettingsCompleted     : TOnGetNonDefaultPermissionSettingsCompletedEvent;
      FOnSetPermissionStateCompleted                  : TOnSetPermissionStateCompletedEvent;

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
      function  GetRootVisualTarget : IUnknown;
      function  GetCursor : HCURSOR;
      function  GetSystemCursorID : cardinal;
      function  GetAutomationProvider : IUnknown;
      function  GetProcessInfos : ICoreWebView2ProcessInfoCollection;
      function  GetIsMuted : boolean;
      function  GetIsDocumentPlayingAudio : boolean;
      function  GetIsDefaultDownloadDialogOpen : boolean;
      function  GetDefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment;
      function  GetDefaultDownloadDialogMargin : TPoint;
      function  GetStatusBarText : wvstring;
      function  GetAllowExternalDrop : boolean;
      function  GetHiddenPdfToolbarItems : TWVPDFToolbarItems;
      function  GetIsReputationCheckingRequired : boolean;
      function  GetCustomItemSelectedEventHandler : ICoreWebView2CustomItemSelectedEventHandler;
      function  GetFaviconURI : wvstring;
      function  GetScreenScale : single; virtual;
      function  GetProfileName : wvstring;
      function  GetIsInPrivateModeEnabled : boolean;
      function  GetProfilePath : wvstring;
      function  GetDefaultDownloadFolderPath : wvstring;
      function  GetPreferredColorScheme : TWVPreferredColorScheme;
      function  GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
      function  GetProfileCookieManager : ICoreWebView2CookieManager;

      procedure SetBuiltInErrorPageEnabled(aValue: boolean);
      procedure SetDefaultContextMenusEnabled(aValue: boolean);
      procedure SetDefaultScriptDialogsEnabled(aValue: boolean);
      procedure SetDevToolsEnabled(aValue: boolean);
      procedure SetScriptEnabled(aValue: boolean);
      procedure SetStatusBarEnabled(aValue: boolean);
      procedure SetWebMessageEnabled(aValue: boolean);
      procedure SetZoomControlEnabled(aValue: boolean);
      procedure SetZoomFactor(const aValue: Double);
      procedure SetZoomPct(const aValue : double);
      procedure SetZoomStep(aValue : byte);
      procedure SetIsVisible(aValue : boolean);
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
      procedure SetRootVisualTarget(const aValue : IUnknown);
      procedure SetIsMuted(aValue : boolean);
      procedure SetDefaultDownloadDialogCornerAlignment(aValue : TWVDefaultDownloadDialogCornerAlignment);
      procedure SetDefaultDownloadDialogMargin(aValue : TPoint);
      procedure SetAllowExternalDrop(aValue : boolean);
      procedure SetHiddenPdfToolbarItems(aValue : TWVPDFToolbarItems);
      procedure SetIsReputationCheckingRequired(aValue : boolean);
      procedure SetProfileName(const aValue : wvstring);
      procedure SetDefaultDownloadFolderPath(const aValue : wvstring);
      procedure SetPreferredColorScheme(const aValue : TWVPreferredColorScheme);
      procedure SetPreferredTrackingPreventionLevel(const aValue : TWVTrackingPreventionLevel);

      function  CreateEnvironment : boolean;
      function  CreateCompositionController: boolean;
      function  CreateController : boolean;

      procedure DestroyEnvironment;
      procedure DestroyController;
      procedure DestroyCompositionController;
      procedure DestroyWebView;
      procedure DestroySettings;
      procedure DestroyPrintSettings;
      procedure DestroyMenuItemHandler;

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

      function  ExtractJSONData(const aJSON: wvstring; var aData: wvstring) : boolean; virtual;
      function  ExtractEncodedJSON(const aJSON: wvstring): wvstring;

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
      function WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode: HResult; const Content: IStream; aResourceID : integer): HRESULT;
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
      function IsMutedChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function IsDocumentPlayingAudioChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function IsDefaultDownloadDialogOpenChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function ProcessInfosChangedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;
      function FrameNavigationStartingEventHandler2_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationStartingEventArgs; aFrameID: integer): HRESULT;
      function FrameNavigationCompletedEventHandler2_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationCompletedEventArgs; aFrameID: integer): HRESULT;
      function FrameContentLoadingEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ContentLoadingEventArgs; aFrameID: integer): HRESULT;
      function FrameDOMContentLoadedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2DOMContentLoadedEventArgs; aFrameID: integer): HRESULT;
      function FrameWebMessageReceivedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2WebMessageReceivedEventArgs; aFrameID: integer): HRESULT;
      function BasicAuthenticationRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2BasicAuthenticationRequestedEventArgs): HRESULT;
      function ContextMenuRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContextMenuRequestedEventArgs): HRESULT;
      function CustomItemSelectedEventHandler_Invoke(const sender: ICoreWebView2ContextMenuItem; const args: IUnknown): HRESULT;
      function StatusBarTextChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function FramePermissionRequestedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2PermissionRequestedEventArgs2; aFrameID: integer): HRESULT;
      function ClearBrowsingDataCompletedHandler_Invoke(errorCode: HResult): HRESULT;
      function ClearServerCertificateErrorActionsCompletedHandler_Invoke(errorCode: HResult): HRESULT;
      function ServerCertificateErrorDetectedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ServerCertificateErrorDetectedEventArgs): HRESULT;
      function FaviconChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function GetFaviconCompletedHandler_Invoke(errorCode: HResult; const faviconStream: IStream): HRESULT;
      function PrintCompletedHandler_Invoke(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS): HRESULT;
      function PrintToPdfStreamCompletedHandler_Invoke(errorCode: HResult; const pdfStream: IStream): HRESULT;
      function GetNonDefaultPermissionSettingsCompletedHandler_Invoke(errorCode: HResult; const collectionView: ICoreWebView2PermissionSettingCollectionView): HRESULT;
      function SetPermissionStateCompletedHandler_Invoke(errorCode: HResult): HRESULT;

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
      procedure doOnWebResourceResponseViewGetContentCompletedEvent(errorCode: HResult; const Content: IStream; aResourceID : integer); virtual;
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
      procedure doOnRetrieveHTMLCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring); virtual;
      procedure doOnRetrieveTextCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring); virtual;
      procedure doOnRetrieveMHTMLCompleted(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring); virtual;
      procedure doOnClearCacheCompleted(aErrorCode: HRESULT); virtual;
      procedure doOnClearDataForOriginCompleted(aErrorCode: HRESULT); virtual;
      procedure doOnOfflineCompleted(aErrorCode: HRESULT); virtual;
      procedure doOnIgnoreCertificateErrorsCompleted(aErrorCode: HRESULT); virtual;
      procedure doOnRefreshIgnoreCacheCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring); virtual;
      procedure doOnSimulateKeyEventCompleted(aErrorCode: HRESULT); virtual;
      procedure doOnIsMutedChanged(const sender: ICoreWebView2); virtual;
      procedure doOnIsDocumentPlayingAudioChanged(const sender: ICoreWebView2); virtual;
      procedure doOnIsDefaultDownloadDialogOpenChanged(const sender: ICoreWebView2); virtual;
      procedure doOnProcessInfosChangedEvent(const sender: ICoreWebView2Environment); virtual;
      procedure doOnFrameNavigationStarting2(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationStartingEventArgs; aFrameID : integer); virtual;
      procedure doOnFrameNavigationCompleted2(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationCompletedEventArgs; aFrameID : integer); virtual;
      procedure doOnFrameContentLoadingEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2ContentLoadingEventArgs; aFrameID: integer); virtual;
      procedure doOnFrameDOMContentLoadedEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2DOMContentLoadedEventArgs; aFrameID: integer); virtual;
      procedure doOnFrameWebMessageReceivedEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2WebMessageReceivedEventArgs; aFrameID: integer); virtual;
      procedure doOnBasicAuthenticationRequestedEvent(const sender: ICoreWebView2; const args: ICoreWebView2BasicAuthenticationRequestedEventArgs); virtual;
      procedure doOnContextMenuRequestedEvent(const sender: ICoreWebView2; const args: ICoreWebView2ContextMenuRequestedEventArgs); virtual;
      procedure doOnCustomItemSelectedEvent(const sender: ICoreWebView2ContextMenuItem; const args: IUnknown); virtual;
      procedure doOnStatusBarTextChangedEvent(const sender: ICoreWebView2; const args: IUnknown); virtual;
      procedure doOnFramePermissionRequestedEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2PermissionRequestedEventArgs2; aFrameID: integer); virtual;
      procedure doOnClearBrowsingDataCompletedEvent(aErrorCode: HRESULT); virtual;
      procedure doOnServerCertificateErrorActionsCompletedEvent(aErrorCode: HRESULT); virtual;
      procedure doOnServerCertificateErrorDetectedEvent(const sender: ICoreWebView2; const args: ICoreWebView2ServerCertificateErrorDetectedEventArgs); virtual;
      procedure doOnFaviconChangedEvent(const sender: ICoreWebView2; const args: IUnknown); virtual;
      procedure doOnGetFaviconCompletedEvent(errorCode: HResult; const faviconStream: IStream); virtual;
      procedure doOnPrintCompletedEvent(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS); virtual;
      procedure doOnPrintToPdfStreamCompletedEvent(errorCode: HResult; const pdfStream: IStream); virtual;
      procedure doOnGetCustomSchemes(var aSchemeRegistrations : TWVCustomSchemeRegistrationArray); virtual;
      procedure doOnGetNonDefaultPermissionSettingsCompleted(errorCode: HResult; const collectionView: ICoreWebView2PermissionSettingCollectionView); virtual;
      procedure doOnSetPermissionStateCompleted(errorCode: HResult); virtual;

    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;

      function    CreateBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean = True) : boolean; overload;
      function    CreateBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean; overload;

      function    CreateWindowlessBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean = True) : boolean; overload;
      function    CreateWindowlessBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean; overload;

      function    GoBack : boolean;
      function    GoForward : boolean;
      function    Refresh : boolean;
      function    RefreshIgnoreCache : boolean;
      function    Stop : boolean;

      function    Navigate(const aURI : wvstring) : boolean;
      function    NavigateToString(const aHTMLContent: wvstring) : boolean;
      function    NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;

      function    SubscribeToDevToolsProtocolEvent(const aEventName : wvstring; aEventID : integer = 0) : boolean;
      function    CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer = 0) : boolean;
      function    CallDevToolsProtocolMethodForSession(const aSessionId, aMethodName, aParametersAsJson : wvstring; aExecutionID : integer = 0) : boolean;

      function    SetFocus : boolean;
      function    FocusNext : boolean;
      function    FocusPrevious : boolean;

      function    ExecuteScript(const aJavaScript : wvstring; aExecutionID : integer = 0) : boolean;
      function    CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream) : boolean;
      function    NotifyParentWindowPositionChanged : boolean;

      function    SetPermissionState(aPermissionKind: TWVPermissionKind; const aOrigin: wvstring; aState: TWVPermissionState) : boolean;
      function    GetNonDefaultPermissionSettings: boolean;

      function    TrySuspend : boolean;
      function    Resume : boolean;

      function    SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
      function    ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;

      function    RetrieveHTML : boolean;
      function    RetrieveText : boolean;
      function    RetrieveMHTML : boolean;

      function    Print : boolean;
      function    ShowPrintUI(aUseSystemPrintDialog : boolean = False): boolean;
      function    PrintToPdf(const aResultFilePath : wvstring) : boolean;
      function    PrintToPdfStream : boolean;

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

      procedure   ToggleMuteState;

      function    OpenDefaultDownloadDialog : boolean;
      function    CloseDefaultDownloadDialog : boolean;

      function    SimulateEditingCommand(aEditingCommand : TWV2EditingCommand): boolean;
      function    SimulateKeyEvent(type_: TWV2KeyEventType; modifiers, windowsVirtualKeyCode, nativeVirtualKeyCode: integer; timestamp: integer = 0; location: integer = 0; autoRepeat: boolean = False; isKeypad: boolean = False; isSystemKey: boolean = False; const text: wvstring = ''; const unmodifiedtext: wvstring = ''; const keyIdentifier: wvstring = ''; const code: wvstring = ''; const key: wvstring = ''): boolean; virtual;
      function    KeyboardShortcutSearch : boolean; virtual;
      function    KeyboardShortcutRefreshIgnoreCache : boolean; virtual;

      function    SendMouseInput(aEventKind : TWVMouseEventKind; aVirtualKeys : TWVMouseEventVirtualKeys; aMouseData : cardinal; aPoint : TPoint) : boolean;
      function    SendPointerInput(aEventKind : TWVPointerEventKind; const aPointerInfo : ICoreWebView2PointerInfo) : boolean;
      function    DragEnter(const dataObject: IDataObject; keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
      function    DragLeave : HResult;
      function    DragOver(keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
      function    Drop(const dataObject: IDataObject; keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;

      function    ClearBrowsingData(dataKinds: TWVBrowsingDataKinds): boolean;
      function    ClearBrowsingDataInTimeRange(dataKinds: TWVBrowsingDataKinds; const startTime, endTime: TDateTime): boolean;
      function    ClearBrowsingDataAll: boolean;

      function    ClearServerCertificateErrorActions : boolean;
      function    GetFavicon(aFormat: TWVFaviconImageFormat = COREWEBVIEW2_FAVICON_IMAGE_FORMAT_PNG) : boolean;

      function    CreateSharedBuffer(aSize : Largeuint; var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;
      function    PostSharedBufferToScript(const aSharedBuffer: ICoreWebView2SharedBuffer; aAccess: TWVSharedBufferAccess; const aAdditionalDataAsJson: wvstring): boolean;

      // Custom properties
      property Initialized                                     : boolean                                               read GetInitialized;
      property CoreWebView2PrintSettings                       : TCoreWebView2PrintSettings                            read FCoreWebView2PrintSettings;
      property CoreWebView2Settings                            : TCoreWebView2Settings                                 read FCoreWebView2Settings;
      property CoreWebView2Environment                         : TCoreWebView2Environment                              read FCoreWebView2Environment;
      property CoreWebView2Controller                          : TCoreWebView2Controller                               read FCoreWebView2Controller;
      property CoreWebView2CompositionController               : TCoreWebView2CompositionController                    read FCoreWebView2CompositionController;
      property CoreWebView2                                    : TCoreWebView2                                         read FCoreWebView2;
      property DefaultURL                                      : wvstring                                              read FDefaultURL                                      write FDefaultURL;
      property IsNavigating                                    : boolean                                               read FIsNavigating;
      property ZoomPct                                         : double                                                read GetZoomPct                                       write SetZoomPct;                                 // ICoreWebView2Controller.get_ZoomFactor
      property ZoomStep                                        : byte                                                  read FZoomStep                                        write SetZoomStep;                                // ICoreWebView2Controller.get_ZoomFactor
      property Widget0CompHWND                                 : THandle                                               read FWidget0CompHWND;
      property Widget1CompHWND                                 : THandle                                               read FWidget1CompHWND;
      property RenderCompHWND                                  : THandle                                               read FRenderCompHWND;
      property D3DWindowCompHWND                               : THandle                                               read FD3DWindowCompHWND;
      property CustomItemSelectedEventHandler                  : ICoreWebView2CustomItemSelectedEventHandler           read GetCustomItemSelectedEventHandler;
      property ScreenScale                                     : single                                                read GetScreenScale;

      // Custom properties created using DevTool methods
      property Offline                                         : boolean                                               read FOffline                                         write SetOffline;
      property IgnoreCertificateErrors                         : boolean                                               read FIgnoreCertificateErrors                         write SetIgnoreCertificateErrors;

      // Properties used in the ICoreWebView2Environment creation
      property BrowserExecPath                                 : wvstring                                              read FBrowserExecPath                                 write FBrowserExecPath;                           // CreateCoreWebView2EnvironmentWithOptions "browserExecutableFolder" parameter
      property UserDataFolder                                  : wvstring                                              read GetUserDataFolder                                write FUserDataFolder;                            // CreateCoreWebView2EnvironmentWithOptions "userDataFolder" parameter
      property AdditionalBrowserArguments                      : wvstring                                              read FAdditionalBrowserArguments                      write FAdditionalBrowserArguments;                // ICoreWebView2EnvironmentOptions.get_AdditionalBrowserArguments
      property Language                                        : wvstring                                              read FLanguage                                        write FLanguage;                                  // ICoreWebView2EnvironmentOptions.get_Language
      property TargetCompatibleBrowserVersion                  : wvstring                                              read FTargetCompatibleBrowserVersion                  write FTargetCompatibleBrowserVersion;            // ICoreWebView2EnvironmentOptions.get_TargetCompatibleBrowserVersion
      property AllowSingleSignOnUsingOSPrimaryAccount          : boolean                                               read FAllowSingleSignOnUsingOSPrimaryAccount          write FAllowSingleSignOnUsingOSPrimaryAccount;    // ICoreWebView2EnvironmentOptions.get_AllowSingleSignOnUsingOSPrimaryAccount
      property ExclusiveUserDataFolderAccess                   : boolean                                               read FExclusiveUserDataFolderAccess                   write FExclusiveUserDataFolderAccess;             // ICoreWebView2EnvironmentOptions2.Get_ExclusiveUserDataFolderAccess
      property CustomCrashReportingEnabled                     : boolean                                               read FCustomCrashReportingEnabled                     write FCustomCrashReportingEnabled;               // ICoreWebView2EnvironmentOptions3.Get_IsCustomCrashReportingEnabled
      property EnableTrackingPrevention                        : boolean                                               read FEnableTrackingPrevention                        write FEnableTrackingPrevention;                  // ICoreWebView2EnvironmentOptions5.Get_EnableTrackingPrevention

      // ICoreWebView2Environment properties
      property BrowserVersionInfo                              : wvstring                                              read GetBrowserVersionInfo;                                                                             // ICoreWebView2Environment.get_BrowserVersionString

      // ICoreWebView2 properties
      property BrowserProcessID                                : cardinal                                              read GetBrowserProcessID;                                                                               // ICoreWebView2.get_BrowserProcessId
      property CanGoBack                                       : boolean                                               read GetCanGoBack;                                                                                      // ICoreWebView2.get_CanGoBack
      property CanGoForward                                    : boolean                                               read GetCanGoForward;                                                                                   // ICoreWebView2.get_CanGoForward
      property ContainsFullScreenElement                       : boolean                                               read GetContainsFullScreenElement;                                                                      // ICoreWebView2.get_ContainsFullScreenElement
      property DocumentTitle                                   : wvstring                                              read GetDocumentTitle;                                                                                  // ICoreWebView2.get_DocumentTitle
      property Source                                          : wvstring                                              read GetSource;                                                                                         // ICoreWebView2.get_Source

      // ICoreWebView2_2 properties
      property CookieManager                                   : ICoreWebView2CookieManager                            read GetCookieManager;                                                                                  // ICoreWebView2_2.get_CookieManager

      // ICoreWebView2_3 properties
      property IsSuspended                                     : boolean                                               read GetIsSuspended;                                                                                    // ICoreWebView2_3.get_IsSuspended

      // ICoreWebView2_8 properties
      property IsDocumentPlayingAudio                          : boolean                                               read GetIsDocumentPlayingAudio;                                                                         // ICoreWebView2_8.get_IsDocumentPlayingAudio
      property IsMuted                                         : boolean                                               read GetIsMuted                                       write SetIsMuted;                                 // ICoreWebView2_8.get_IsMuted

      // ICoreWebView2_9 properties
      property DefaultDownloadDialogCornerAlignment            : TWVDefaultDownloadDialogCornerAlignment               read GetDefaultDownloadDialogCornerAlignment          write SetDefaultDownloadDialogCornerAlignment;    // ICoreWebView2_9.get_DefaultDownloadDialogCornerAlignment
      property DefaultDownloadDialogMargin                     : TPoint                                                read GetDefaultDownloadDialogMargin                   write SetDefaultDownloadDialogMargin;             // ICoreWebView2_9.get_DefaultDownloadDialogMargin
      property IsDefaultDownloadDialogOpen                     : boolean                                               read GetIsDefaultDownloadDialogOpen;                                                                    // ICoreWebView2_9.get_IsDefaultDownloadDialogOpen

      // ICoreWebView2_12
      property StatusBarText                                   : wvstring                                              read GetStatusBarText;

      // ICoreWebView2_15
      property FaviconURI                                      : wvstring                                              read GetFaviconURI;

      // ICoreWebView2Controller properties
      property Bounds                                          : TRect                                                 read GetBounds                                        write SetBounds;                                  // ICoreWebView2Controller.get_Bounds
      property IsVisible                                       : boolean                                               read GetIsVisible                                     write SetIsVisible;                               // ICoreWebView2Controller.get_IsVisible
      property ParentWindow                                    : THandle                                               read GetParentWindow                                  write SetParentWindow;                            // ICoreWebView2Controller.get_ParentWindow
      property ZoomFactor                                      : double                                                read GetZoomFactor                                    write SetZoomFactor;                              // ICoreWebView2Controller.get_ZoomFactor

      // ICoreWebView2Controller2 properties
      property DefaultBackgroundColor                          : TColor                                                read GetDefaultBackgroundColor                        write SetDefaultBackgroundColor;                  // ICoreWebView2Controller2.get_DefaultBackgroundColor

      // ICoreWebView2Controller3 properties
      property BoundsMode                                      : TWVBoundsMode                                         read GetBoundsMode                                    write SetBoundsMode;                              // ICoreWebView2Controller3.get_BoundsMode
      property RasterizationScale                              : double                                                read GetRasterizationScale                            write SetRasterizationScale;                      // ICoreWebView2Controller3.get_RasterizationScale
      property ShouldDetectMonitorScaleChanges                 : boolean                                               read GetShouldDetectMonitorScaleChanges               write SetShouldDetectMonitorScaleChanges;         // ICoreWebView2Controller3.get_ShouldDetectMonitorScaleChanges

      // ICoreWebView2Controller4 properties
      property AllowExternalDrop                               : boolean                                               read GetAllowExternalDrop                             write SetAllowExternalDrop;

      // ICoreWebView2Settings properties
      property DefaultContextMenusEnabled                      : boolean                                               read GetDefaultContextMenusEnabled                    write SetDefaultContextMenusEnabled;              // ICoreWebView2Settings.get_AreDefaultContextMenusEnabled
      property DefaultScriptDialogsEnabled                     : boolean                                               read GetDefaultScriptDialogsEnabled                   write SetDefaultScriptDialogsEnabled;             // ICoreWebView2Settings.get_AreDefaultScriptDialogsEnabled
      property DevToolsEnabled                                 : boolean                                               read GetDevToolsEnabled                               write SetDevToolsEnabled;                         // ICoreWebView2Settings.get_AreDevToolsEnabled
      property AreHostObjectsAllowed                           : boolean                                               read GetAreHostObjectsAllowed                         write SetAreHostObjectsAllowed;                   // ICoreWebView2Settings.get_AreHostObjectsAllowed
      property BuiltInErrorPageEnabled                         : boolean                                               read GetBuiltInErrorPageEnabled                       write SetBuiltInErrorPageEnabled;                 // ICoreWebView2Settings.get_IsBuiltInErrorPageEnabled
      property ScriptEnabled                                   : boolean                                               read GetScriptEnabled                                 write SetScriptEnabled;                           // ICoreWebView2Settings.get_IsScriptEnabled
      property StatusBarEnabled                                : boolean                                               read GetStatusBarEnabled                              write SetStatusBarEnabled;                        // ICoreWebView2Settings.get_IsStatusBarEnabled
      property WebMessageEnabled                               : boolean                                               read GetWebMessageEnabled                             write SetWebMessageEnabled;                       // ICoreWebView2Settings.get_IsWebMessageEnabled
      property ZoomControlEnabled                              : boolean                                               read GetZoomControlEnabled                            write SetZoomControlEnabled;                      // ICoreWebView2Settings.get_IsZoomControlEnabled

      // ICoreWebView2Settings2 properties
      property UserAgent                                       : wvstring                                              read GetUserAgent                                     write SetUserAgent;                               // ICoreWebView2Settings2.get_UserAgent

      // ICoreWebView2Settings3 properties
      property AreBrowserAcceleratorKeysEnabled                : boolean                                               read GetAreBrowserAcceleratorKeysEnabled              write SetAreBrowserAcceleratorKeysEnabled;        // ICoreWebView2Settings3.get_AreBrowserAcceleratorKeysEnabled

      // ICoreWebView2Settings4 properties
      property IsGeneralAutofillEnabled                        : boolean                                               read GetIsGeneralAutofillEnabled                      write SetIsGeneralAutofillEnabled;                // ICoreWebView2Settings4.get_IsGeneralAutofillEnabled
      property IsPasswordAutosaveEnabled                       : boolean                                               read GetIsPasswordAutosaveEnabled                     write SetIsPasswordAutosaveEnabled;               // ICoreWebView2Settings4.get_IsPasswordAutosaveEnabled

      // ICoreWebView2Settings5 properties
      property IsPinchZoomEnabled                              : boolean                                               read GetIsPinchZoomEnabled                            write SetIsPinchZoomEnabled;                      // ICoreWebView2Settings5.get_IsPinchZoomEnabled

      // ICoreWebView2Settings6 properties
      property IsSwipeNavigationEnabled                        : boolean                                               read GetIsSwipeNavigationEnabled                      write SetIsSwipeNavigationEnabled;                // ICoreWebView2Settings6.get_IsSwipeNavigationEnabled

      // ICoreWebView2Settings7 properties
      property HiddenPdfToolbarItems                           : TWVPDFToolbarItems                                    read GetHiddenPdfToolbarItems                         write SetHiddenPdfToolbarItems;                   // ICoreWebView2Settings7.Get_HiddenPdfToolbarItems

      // ICoreWebView2Settings8 properties
      property IsReputationCheckingRequired                    : boolean                                               read GetIsReputationCheckingRequired                  write SetIsReputationCheckingRequired;            // ICoreWebView2Settings8.Get_IsReputationCheckingRequired

      // ICoreWebView2CompositionController properties
      property Cursor                                          : HCURSOR                                               read GetCursor;                                                                                         // ICoreWebView2CompositionController.get_Cursor
      property RootVisualTarget                                : IUnknown                                              read GetRootVisualTarget                              write SetRootVisualTarget;                        // ICoreWebView2CompositionController.get_RootVisualTarget
      property SystemCursorID                                  : cardinal                                              read GetSystemCursorID;                                                                                 // ICoreWebView2CompositionController.get_SystemCursorId

      // ICoreWebView2CompositionController2 properties
      property AutomationProvider                              : IUnknown                                              read GetAutomationProvider;                                                                             // ICoreWebView2CompositionController2.get_UIAProvider

      // ICoreWebView2Environment8 properties
      property ProcessInfos                                    : ICoreWebView2ProcessInfoCollection                    read GetProcessInfos;                                                                                   // ICoreWebView2Environment8.GetProcessInfos

      // ICoreWebView2ControllerOptions and ICoreWebView2Profile properties
      property ProfileName                                     : wvstring                                              read GetProfileName                                   write SetProfileName;                             // ICoreWebView2ControllerOptions.Get_ProfileName and ICoreWebView2Profile.Get_ProfileName
      property IsInPrivateModeEnabled                          : boolean                                               read GetIsInPrivateModeEnabled                        write FIsInPrivateModeEnabled;                    // ICoreWebView2ControllerOptions.Get_IsInPrivateModeEnabled and ICoreWebView2Profile.Get_IsInPrivateModeEnabled
      property ScriptLocale                                    : wvstring                                              read FScriptLocale                                    write FScriptLocale;                              // ICoreWebView2ControllerOptions2.Get_ScriptLocale

      // ICoreWebView2Profile properties
      property ProfilePath                                     : wvstring                                              read GetProfilePath;                                                                                    // ICoreWebView2Profile.Get_ProfilePath
      property DefaultDownloadFolderPath                       : wvstring                                              read GetDefaultDownloadFolderPath                     write SetDefaultDownloadFolderPath;               // ICoreWebView2Profile.Get_DefaultDownloadFolderPath
      property PreferredColorScheme                            : TWVPreferredColorScheme                               read GetPreferredColorScheme                          write SetPreferredColorScheme;                    // ICoreWebView2Profile.Get_PreferredColorScheme

      // ICoreWebView2Profile3 properties
      property PreferredTrackingPreventionLevel                : TWVTrackingPreventionLevel                            read GetPreferredTrackingPreventionLevel              write SetPreferredTrackingPreventionLevel;        // ICoreWebView2Profile3.Get_PreferredTrackingPreventionLevel

      // ICoreWebView2Profile5 properties
      property ProfileCookieManager                            : ICoreWebView2CookieManager                            read GetProfileCookieManager;                                                                           // ICoreWebView2Profile5.get_CookieManager

      // ICoreWebView2Environment5 events
      property OnBrowserProcessExited                          : TOnBrowserProcessExitedEvent                          read FOnBrowserProcessExited                          write FOnBrowserProcessExited;

      // ICoreWebView2Environment8 events
      property OnProcessInfosChanged                           : TOnProcessInfosChangedEvent                           read FOnProcessInfosChanged                           write FOnProcessInfosChanged;

      // ICoreWebView2 events
      property OnContainsFullScreenElementChanged              : TNotifyEvent                                          read FOnContainsFullScreenElementChanged              write FOnContainsFullScreenElementChanged;
      property OnContentLoading                                : TOnContentLoadingEvent                                read FOnContentLoading                                write FOnContentLoading;
      property OnDocumentTitleChanged                          : TNotifyEvent                                          read FOnDocumentTitleChanged                          write FOnDocumentTitleChanged;
      property OnFrameNavigationCompleted                      : TOnNavigationCompletedEvent                           read FOnFrameNavigationCompleted                      write FOnFrameNavigationCompleted;
      property OnFrameNavigationStarting                       : TOnNavigationStartingEvent                            read FOnFrameNavigationStarting                       write FOnFrameNavigationStarting;
      property OnHistoryChanged                                : TNotifyEvent                                          read FOnHistoryChanged                                write FOnHistoryChanged;
      property OnNavigationCompleted                           : TOnNavigationCompletedEvent                           read FOnNavigationCompleted                           write FOnNavigationCompleted;
      property OnNavigationStarting                            : TOnNavigationStartingEvent                            read FOnNavigationStarting                            write FOnNavigationStarting;
      property OnNewWindowRequested                            : TOnNewWindowRequestedEvent                            read FOnNewWindowRequested                            write FOnNewWindowRequested;
      property OnPermissionRequested                           : TOnPermissionRequestedEvent                           read FOnPermissionRequested                           write FOnPermissionRequested;
      property OnProcessFailed                                 : TOnProcessFailedEvent                                 read FOnProcessFailed                                 write FOnProcessFailed;
      property OnScriptDialogOpening                           : TOnScriptDialogOpeningEvent                           read FOnScriptDialogOpening                           write FOnScriptDialogOpening;
      property OnSourceChanged                                 : TOnSourceChangedEvent                                 read FOnSourceChanged                                 write FOnSourceChanged;
      property OnWebMessageReceived                            : TOnWebMessageReceivedEvent                            read FOnWebMessageReceived                            write FOnWebMessageReceived;
      property OnWebResourceRequested                          : TOnWebResourceRequestedEvent                          read FOnWebResourceRequested                          write FOnWebResourceRequested;
      property OnWindowCloseRequested                          : TNotifyEvent                                          read FOnWindowCloseRequested                          write FOnWindowCloseRequested;

      // ICoreWebView2_2 events
      property OnDOMContentLoaded                              : TOnDOMContentLoadedEvent                              read FOnDOMContentLoaded                              write FOnDOMContentLoaded;
      property OnWebResourceResponseReceived                   : TOnWebResourceResponseReceivedEvent                   read FOnWebResourceResponseReceived                   write FOnWebResourceResponseReceived;

      // ICoreWebView2_4 events
      property OnDownloadStarting                              : TOnDownloadStartingEvent                              read FOnDownloadStarting                              write FOnDownloadStarting;
      property OnFrameCreated                                  : TOnFrameCreatedEvent                                  read FOnFrameCreated                                  write FOnFrameCreated;

      // ICoreWebView2_5 events
      property OnClientCertificateRequested                    : TOnClientCertificateRequestedEvent                    read FOnClientCertificateRequested                    write FOnClientCertificateRequested;

      // ICoreWebView2_8 events
      property OnIsDocumentPlayingAudioChanged                 : TOnIsDocumentPlayingAudioChangedEvent                 read FOnIsDocumentPlayingAudioChanged                 write FOnIsDocumentPlayingAudioChanged;
      property OnIsMutedChanged                                : TOnIsMutedChangedEvent                                read FOnIsMutedChanged                                write FOnIsMutedChanged;

      // ICoreWebView2_9 events
      property OnIsDefaultDownloadDialogOpenChanged            : TOnIsDefaultDownloadDialogOpenChangedEvent            read FOnIsDefaultDownloadDialogOpenChanged            write FOnIsDefaultDownloadDialogOpenChanged;

      // ICoreWebView2_10 events
      property OnBasicAuthenticationRequested                  : TOnBasicAuthenticationRequestedEvent                  read FOnBasicAuthenticationRequested                  write FOnBasicAuthenticationRequested;

      // ICoreWebView2_11 events
      property OnContextMenuRequested                          : TOnContextMenuRequestedEvent                          read FOnContextMenuRequested                          write FOnContextMenuRequested;

      // ICoreWebView2_12 events
      property OnStatusBarTextChanged                          : TOnStatusBarTextChangedEvent                          read FOnStatusBarTextChanged                          write FOnStatusBarTextChanged;

      // ICoreWebView2_14 events
      property OnServerCertificateErrorActionsCompleted        : TOnServerCertificateErrorActionsCompletedEvent        read FOnServerCertificateErrorActionsCompleted        write FOnServerCertificateErrorActionsCompleted;
      property OnServerCertificateErrorDetected                : TOnServerCertificateErrorDetectedEvent                read FOnServerCertificateErrorDetected                write FOnServerCertificateErrorDetected;

      // ICoreWebView2_15 events
      property OnFaviconChanged                                : TOnFaviconChangedEvent                                read FOnFaviconChanged                                write FOnFaviconChanged;
      property OnGetFaviconCompleted                           : TOnGetFaviconCompletedEvent                           read FOnGetFaviconCompleted                           write FOnGetFaviconCompleted;

      // ICoreWebView2_16 events
      property OnPrintCompleted                                : TOnPrintCompletedEvent                                read FOnPrintCompleted                                write FOnPrintCompleted;
      property OnPrintToPdfStreamCompleted                     : TOnPrintToPdfStreamCompletedEvent                     read FOnPrintToPdfStreamCompleted                     write FOnPrintToPdfStreamCompleted;

      // ICoreWebView2Controller events
      property OnAcceleratorKeyPressed                         : TOnAcceleratorKeyPressedEvent                         read FOnAcceleratorKeyPressed                         write FOnAcceleratorKeyPressed;
      property OnGotFocus                                      : TNotifyEvent                                          read FOnGotFocus                                      write FOnGotFocus;
      property OnLostFocus                                     : TNotifyEvent                                          read FOnLostFocus                                     write FOnLostFocus;
      property OnMoveFocusRequested                            : TOnMoveFocusRequestedEvent                            read FOnMoveFocusRequested                            write FOnMoveFocusRequested;
      property OnZoomFactorChanged                             : TNotifyEvent                                          read FOnZoomFactorChanged                             write FOnZoomFactorChanged;

      // ICoreWebView2Controller3 events
      property OnRasterizationScaleChanged                     : TNotifyEvent                                          read FOnRasterizationScaleChanged                     write FOnRasterizationScaleChanged;

      // ICoreWebView2CompositionController events
      property OnCursorChanged                                 : TNotifyEvent                                          read FOnCursorChanged                                 write FOnCursorChanged;

      // ICoreWebView2DownloadOperation events
      property OnBytesReceivedChanged                          : TOnBytesReceivedChangedEvent                          read FOnBytesReceivedChanged                          write FOnBytesReceivedChanged;
      property OnEstimatedEndTimeChanged                       : TOnEstimatedEndTimeChangedEvent                       read FOnEstimatedEndTimeChanged                       write FOnEstimatedEndTimeChanged;
      property OnDownloadStateChanged                          : TOnDownloadStateChangedEvent                          read FOnDownloadStateChanged                          write FOnDownloadStateChanged;

      // ICoreWebView2Frame events
      property OnFrameDestroyed                                : TOnFrameDestroyedEvent                                read FOnFrameDestroyed                                write FOnFrameDestroyed;
      property OnFrameNameChanged                              : TOnFrameNameChangedEvent                              read FOnFrameNameChanged                              write FOnFrameNameChanged;

      // ICoreWebView2Frame2 events
      property OnFrameNavigationStarting2                      : TOnFrameNavigationStartingEvent                       read FOnFrameNavigationStarting2                      write FOnFrameNavigationStarting2;
      property OnFrameNavigationCompleted2                     : TOnFrameNavigationCompletedEvent                      read FOnFrameNavigationCompleted2                     write FOnFrameNavigationCompleted2;
      property OnFrameContentLoading                           : TOnFrameContentLoadingEvent                           read FOnFrameContentLoading                           write FOnFrameContentLoading;
      property OnFrameDOMContentLoaded                         : TOnFrameDOMContentLoadedEvent                         read FOnFrameDOMContentLoaded                         write FOnFrameDOMContentLoaded;
      property OnFrameWebMessageReceived                       : TOnFrameWebMessageReceivedEvent                       read FOnFrameWebMessageReceived                       write FOnFrameWebMessageReceived;

      // ICoreWebView2Frame3 events
      property OnFramePermissionRequested                      : TOnFramePermissionRequestedEvent                      read FOnFramePermissionRequested                      write FOnFramePermissionRequested;

      // ICoreWebView2DevToolsProtocolEventReceiver events
      property OnDevToolsProtocolEventReceived                 : TOnDevToolsProtocolEventReceivedEvent                 read FOnDevToolsProtocolEventReceived                 write FOnDevToolsProtocolEventReceived;

      // ICoreWebView2ContextMenuItem events
      property OnCustomItemSelected                            : TOnCustomItemSelectedEvent                            read FOnCustomItemSelected                            write FOnCustomItemSelected;

      // ICoreWebView2Profile2 events
      property OnClearBrowsingDataCompleted                    : TOnClearBrowsingDataCompletedEvent                    read FOnClearBrowsingDataCompleted                    write FOnClearBrowsingDataCompleted;

      // Custom events
      property OnInitializationError                           : TOnInitializationErrorEvent                           read FOnInitializationError                           write FOnInitializationError;
      property OnEnvironmentCompleted                          : TNotifyEvent                                          read FOnEnvironmentCompleted                          write FOnEnvironmentCompleted;
      property OnControllerCompleted                           : TNotifyEvent                                          read FOnControllerCompleted                           write FOnControllerCompleted;
      property OnAfterCreated                                  : TNotifyEvent                                          read FOnAfterCreated                                  write FOnAfterCreated;
      property OnExecuteScriptCompleted                        : TOnExecuteScriptCompletedEvent                        read FOnExecuteScriptCompleted                        write FOnExecuteScriptCompleted;
      property OnCapturePreviewCompleted                       : TOnCapturePreviewCompletedEvent                       read FOnCapturePreviewCompleted                       write FOnCapturePreviewCompleted;
      property OnGetCookiesCompleted                           : TOnGetCookiesCompletedEvent                           read FOnGetCookiesCompleted                           write FOnGetCookiesCompleted;
      property OnTrySuspendCompleted                           : TOnTrySuspendCompletedEvent                           read FOnTrySuspendCompleted                           write FOnTrySuspendCompleted;
      property OnPrintToPdfCompleted                           : TOnPrintToPdfCompletedEvent                           read FOnPrintToPdfCompleted                           write FOnPrintToPdfCompleted;
      property OnCompositionControllerCompleted                : TNotifyEvent                                          read FOnCompositionControllerCompleted                write FOnCompositionControllerCompleted;
      property OnCallDevToolsProtocolMethodCompleted           : TOnCallDevToolsProtocolMethodCompletedEvent           read FOnCallDevToolsProtocolMethodCompleted           write FOnCallDevToolsProtocolMethodCompleted;
      property OnAddScriptToExecuteOnDocumentCreatedCompleted  : TOnAddScriptToExecuteOnDocumentCreatedCompletedEvent  read FOnAddScriptToExecuteOnDocumentCreatedCompleted  write FOnAddScriptToExecuteOnDocumentCreatedCompleted;
      property OnWebResourceResponseViewGetContentCompleted    : TOnWebResourceResponseViewGetContentCompletedEvent    read FOnWebResourceResponseViewGetContentCompleted    write FOnWebResourceResponseViewGetContentCompleted;
      property OnWidget0CompMsg                                : TOnCompMsgEvent                                       read FOnWidget0CompMsg                                write FOnWidget0CompMsg;
      property OnWidget1CompMsg                                : TOnCompMsgEvent                                       read FOnWidget1CompMsg                                write FOnWidget1CompMsg;
      property OnRenderCompMsg                                 : TOnCompMsgEvent                                       read FOnRenderCompMsg                                 write FOnRenderCompMsg;
      property OnD3DWindowCompMsg                              : TOnCompMsgEvent                                       read FOnD3DWindowCompMsg                              write FOnD3DWindowCompMsg;
      property OnRetrieveHTMLCompleted                         : TOnRetrieveHTMLCompletedEvent                         read FOnRetrieveHTMLCompleted                         write FOnRetrieveHTMLCompleted;
      property OnRetrieveTextCompleted                         : TOnRetrieveTextCompletedEvent                         read FOnRetrieveTextCompleted                         write FOnRetrieveTextCompleted;
      property OnRetrieveMHTMLCompleted                        : TOnRetrieveMHTMLCompletedEvent                        read FOnRetrieveMHTMLCompleted                        write FOnRetrieveMHTMLCompleted;
      property OnClearCacheCompleted                           : TOnClearCacheCompletedEvent                           read FOnClearCacheCompleted                           write FOnClearCacheCompleted;
      property OnClearDataForOriginCompleted                   : TOnClearDataForOriginCompletedEvent                   read FOnClearDataForOriginCompleted                   write FOnClearDataForOriginCompleted;
      property OnOfflineCompleted                              : TOnOfflineCompletedEvent                              read FOnOfflineCompleted                              write FOnOfflineCompleted;
      property OnIgnoreCertificateErrorsCompleted              : TOnIgnoreCertificateErrorsCompletedEvent              read FOnIgnoreCertificateErrorsCompleted              write FOnIgnoreCertificateErrorsCompleted;
      property OnRefreshIgnoreCacheCompleted                   : TOnRefreshIgnoreCacheCompletedEvent                   read FOnRefreshIgnoreCacheCompleted                   write FOnRefreshIgnoreCacheCompleted;
      property OnSimulateKeyEventCompleted                     : TOnSimulateKeyEventCompletedEvent                     read FOnSimulateKeyEventCompleted                     write FOnSimulateKeyEventCompleted;
      property OnGetCustomSchemes                              : TOnGetCustomSchemesEvent                              read FOnGetCustomSchemes                              write FOnGetCustomSchemes;
      property OnGetNonDefaultPermissionSettingsCompleted      : TOnGetNonDefaultPermissionSettingsCompletedEvent      read FOnGetNonDefaultPermissionSettingsCompleted      write FOnGetNonDefaultPermissionSettingsCompleted;
      property OnSetPermissionStateCompleted                   : TOnSetPermissionStateCompletedEvent                   read FOnSetPermissionStateCompleted                   write FOnSetPermissionStateCompleted;
  end;

implementation

uses
  uWVMiscFunctions, uWVCoreWebView2EnvironmentOptions, uWVCoreWebView2ControllerOptions,
  uWVCoreWebView2Profile, uWVCoreWebView2CustomSchemeRegistration;

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
  FExclusiveUserDataFolderAccess                   := False;
  FCustomCrashReportingEnabled                     := False;
  FEnableTrackingPrevention                        := True;
  FZoomStep                                        := ZOOM_STEP_DEF;
  FOffline                                         := False;
  FIsNavigating                                    := False;
  FProfileName                                     := '';
  FIsInPrivateModeEnabled                          := False;
  FScriptLocale                                    := '';
  FMenuItemHandler                                 := nil;
  FClearBrowsingDataCompletedHandler               := nil;
  FSetPermissionStateCompletedHandler              := nil;
  FGetNonDefaultPermissionSettingsCompletedHandler := nil;

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
  FOnProcessInfosChanged                           := nil;
  FOnFrameNavigationStarting2                      := nil;
  FOnFrameNavigationCompleted2                     := nil;
  FOnFrameContentLoading                           := nil;
  FOnFrameDOMContentLoaded                         := nil;
  FOnFrameWebMessageReceived                       := nil;
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
  FOnPrintCompleted                                := nil;
  FOnRetrieveHTMLCompleted                         := nil;
  FOnRetrieveTextCompleted                         := nil;
  FOnRetrieveMHTMLCompleted                        := nil;
  FOnClearCacheCompleted                           := nil;
  FOnClearDataForOriginCompleted                   := nil;
  FOnOfflineCompleted                              := nil;
  FOnIgnoreCertificateErrorsCompleted              := nil;
  FOnRefreshIgnoreCacheCompleted                   := nil;
  FOnSimulateKeyEventCompleted                     := nil;
  FOnIsMutedChanged                                := nil;
  FOnIsDocumentPlayingAudioChanged                 := nil;
  FOnIsDefaultDownloadDialogOpenChanged            := nil;
  FOnBasicAuthenticationRequested                  := nil;
  FOnContextMenuRequested                          := nil;
  FOnCustomItemSelected                            := nil;
  FOnStatusBarTextChanged                          := nil;
  FOnFramePermissionRequested                      := nil;
  FOnClearBrowsingDataCompleted                    := nil;
  FOnServerCertificateErrorActionsCompleted        := nil;
  FOnServerCertificateErrorDetected                := nil;
  FOnFaviconChanged                                := nil;
  FOnGetFaviconCompleted                           := nil;
  FOnPrintToPdfStreamCompleted                     := nil;
  FOnGetCustomSchemes                              := nil;
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
    DestroyMenuItemHandler;
    FClearBrowsingDataCompletedHandler               := nil;
    FSetPermissionStateCompletedHandler              := nil;
    FGetNonDefaultPermissionSettingsCompletedHandler := nil;
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

procedure TWVBrowserBase.DestroyMenuItemHandler;
begin
  try
    try
      // WebView2 doesn't release any ICoreWebView2CustomItemSelectedEventHandler instances
      while assigned(FMenuItemHandler) and
            (TCoreWebView2CustomItemSelectedEventHandler(FMenuItemHandler).RefCount > 1) do
        FMenuItemHandler._Release;
    except
      on e : exception do
        if CustomExceptionHandler('TWVBrowserBase.DestroyMenuItemHandler', e) then raise;
    end;
  finally
    FMenuItemHandler := nil;
  end;
end;

procedure TWVBrowserBase.AfterConstruction;
begin
  inherited AfterConstruction;

  FClearBrowsingDataCompletedHandler               := TCoreWebView2ClearBrowsingDataCompletedHandler.Create(self);
  FSetPermissionStateCompletedHandler              := TCoreWebView2SetPermissionStateCompletedHandler.Create(self);
  FGetNonDefaultPermissionSettingsCompletedHandler := TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler.Create(self);
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnCapturePreviewCompleted event when it finishes
function TWVBrowserBase.CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CapturePreview(aImageFormat, aImageStream, self);
end;

function TWVBrowserBase.EnvironmentCompletedHandler_Invoke(errorCode: HRESULT; const createdEnvironment: ICoreWebView2Environment): HRESULT;
var
  TempError : wvstring;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(createdEnvironment) then
    begin
      DestroyEnvironment;
      FCoreWebView2Environment := TCoreWebView2Environment.Create(createdEnvironment);

      doOnEnvironmentCompleted;

      if FUseCompositionController then
        CreateCompositionController
       else
        CreateController;
    end
   else
    begin
      TempError := 'There was an error creating the browser environment. (3)' + CRLF +
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
  TempError         : wvstring;
begin
  Result            := S_OK;
  TempSettings      := nil;
  TempCoreWebView2  := nil;
  TempPrintSettings := nil;

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
      begin
        TempError := 'There was an error creating the controller. (2)' + CRLF +
                     'Error code : 0x' +
                     {$IFDEF FPC}
                     UTF8Decode(inttohex(errorCode, 8))
                     {$ELSE}
                     inttohex(errorCode, 8)
                     {$ENDIF}
                     + CRLF + ControllerCreationErrorToString(errorCode);

        doOnInitializationError(errorCode, TempError);
      end;
  finally
    TempSettings      := nil;
    TempCoreWebView2  := nil;
    TempPrintSettings := nil;
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
              CreateStub(Widget0CompWndProc, FWidget0CompStub);
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
              CreateStub(Widget1CompWndProc, FWidget1CompStub);
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
              CreateStub(RenderCompWndProc, FRenderCompStub);
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
              CreateStub(D3DWindowCompWndProc, FD3DWindowCompStub);
              FOldD3DWindowCompWndPrc := InstallCompWndProc(FD3DWindowCompHWND, FD3DWindowCompStub);
            end;
        end;
    end;
end;

function TWVBrowserBase.NavigationStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationStartingEventArgs): HRESULT;
begin
  Result        := S_OK;
  FIsNavigating := True;

  ReplaceWndProcs;

  doOnNavigationStarting(sender, args);
end;

function TWVBrowserBase.NavigationCompletedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NavigationCompletedEventArgs): HRESULT;
begin
  Result        := S_OK;
  FIsNavigating := False;

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

function TWVBrowserBase.FrameNavigationStartingEventHandler_Invoke(const sender   : ICoreWebView2;
                                                                   const args     : ICoreWebView2NavigationStartingEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnFrameNavigationStarting(sender, args);
end;

function TWVBrowserBase.FrameNavigationCompletedEventHandler_Invoke(const sender   : ICoreWebView2;
                                                                    const args     : ICoreWebView2NavigationCompletedEventArgs): HRESULT;
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
  TempError          : wvstring;
  TempHResult        : HRESULT;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(webView) then
    begin
      DestroyCompositionController;
      FCoreWebView2CompositionController := TCoreWebView2CompositionController.Create(webView);

      doOnCompositionControllerCompleted;

      TempHResult := webView.QueryInterface(IID_ICoreWebView2Controller, TempControllerIntf);

      if succeeded(TempHResult) then
        Result := ControllerCompletedHandler_Invoke(errorCode, TempControllerIntf)
       else
        doOnInitializationError(TempHResult, 'There was an error creating the controller. (3)');
    end
   else
    begin
      TempError := 'There was an error creating the composition controller. (2)' + CRLF +
                   'Error code : 0x' +
                   {$IFDEF FPC}
                   UTF8Decode(inttohex(errorCode, 8))
                   {$ELSE}
                   inttohex(errorCode, 8)
                   {$ENDIF}
                    + CRLF + CompositionControllerCreationErrorToString(errorCode);

      doOnInitializationError(errorCode, TempError);
    end;
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

function TWVBrowserBase.WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode: HResult; const Content: IStream; aResourceID : integer): HRESULT;
begin
  Result := S_OK;
  doOnWebResourceResponseViewGetContentCompletedEvent(errorCode, Content, aResourceID);
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

  case aExecutionID of
    WEBVIEW4DELPHI_DEVTOOLS_RETRIEVEMHTML_ID :
      doOnRetrieveMHTMLCompleted(errorCode, wvstring(returnObjectAsJson));

    WEBVIEW4DELPHI_DEVTOOLS_CLEARBROWSERCACHE_ID :
      doOnClearCacheCompleted(errorCode);

    WEBVIEW4DELPHI_DEVTOOLS_CLEARDATAFORORIGIN_ID :
      doOnClearDataForOriginCompleted(errorCode);

    WEBVIEW4DELPHI_DEVTOOLS_EMULATENETWORKCONDITIONS_ID :
      doOnOfflineCompleted(errorCode);

    WEBVIEW4DELPHI_DEVTOOLS_SETIGNORECERTIFICATEERRORS_ID :
      doOnIgnoreCertificateErrorsCompleted(errorCode);

    WEBVIEW4DELPHI_DEVTOOLS_SIMULATEKEYEVENT_ID :
      doOnSimulateKeyEventCompleted(errorCode);

    else
      doOnCallDevToolsProtocolMethodCompletedEvent(errorCode, wvstring(returnObjectAsJson), aExecutionID);
  end;
end;

procedure TWVBrowserBase.doOnClearCacheCompleted(aErrorCode: HRESULT);
begin
  if assigned(FOnClearCacheCompleted) then
    FOnClearCacheCompleted(self, succeeded(aErrorCode));
end;

procedure TWVBrowserBase.doOnClearDataForOriginCompleted(aErrorCode: HRESULT);
begin
  if assigned(FOnClearDataForOriginCompleted) then
    FOnClearDataForOriginCompleted(self, succeeded(aErrorCode));
end;

procedure TWVBrowserBase.doOnOfflineCompleted(aErrorCode: HRESULT);
begin
  if assigned(FOnOfflineCompleted) then
    FOnOfflineCompleted(self, succeeded(aErrorCode));
end;

procedure TWVBrowserBase.doOnIgnoreCertificateErrorsCompleted(aErrorCode: HRESULT);
begin
  if assigned(FOnIgnoreCertificateErrorsCompleted) then
    FOnIgnoreCertificateErrorsCompleted(self, succeeded(aErrorCode));
end;

procedure TWVBrowserBase.doOnSimulateKeyEventCompleted(aErrorCode: HRESULT);
begin
  if assigned(FOnSimulateKeyEventCompleted) then
    FOnSimulateKeyEventCompleted(self, succeeded(aErrorCode));
end;

procedure TWVBrowserBase.doOnIsMutedChanged(const sender: ICoreWebView2);
begin
  if assigned(FOnIsMutedChanged) then
    FOnIsMutedChanged(self, sender);
end;

procedure TWVBrowserBase.doOnIsDocumentPlayingAudioChanged(const sender: ICoreWebView2);
begin
  if assigned(FOnIsDocumentPlayingAudioChanged) then
    FOnIsDocumentPlayingAudioChanged(self, sender);
end;

procedure TWVBrowserBase.doOnIsDefaultDownloadDialogOpenChanged(const sender: ICoreWebView2);
begin
  if assigned(FOnIsDefaultDownloadDialogOpenChanged) then
    FOnIsDefaultDownloadDialogOpenChanged(self, sender);
end;

procedure TWVBrowserBase.doOnProcessInfosChangedEvent(const sender: ICoreWebView2Environment);
begin
  if assigned(FOnProcessInfosChanged) then
    FOnProcessInfosChanged(self, sender);
end;

procedure TWVBrowserBase.doOnFrameNavigationStarting2(const sender   : ICoreWebView2Frame;
                                                      const args     : ICoreWebView2NavigationStartingEventArgs;
                                                            aFrameID : integer);
begin
  if assigned(FOnFrameNavigationStarting2) then
    FOnFrameNavigationStarting2(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameNavigationCompleted2(const sender   : ICoreWebView2Frame;
                                                       const args     : ICoreWebView2NavigationCompletedEventArgs;
                                                             aFrameID : integer);
begin
  if assigned(FOnFrameNavigationCompleted2) then
    FOnFrameNavigationCompleted2(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameContentLoadingEvent(const sender   : ICoreWebView2Frame;
                                                      const args     : ICoreWebView2ContentLoadingEventArgs;
                                                            aFrameID : integer);
begin
  if assigned(FOnFrameContentLoading) then
    FOnFrameContentLoading(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameDOMContentLoadedEvent(const sender   : ICoreWebView2Frame;
                                                        const args     : ICoreWebView2DOMContentLoadedEventArgs;
                                                              aFrameID : integer);
begin
  if assigned(FOnFrameDOMContentLoaded) then
    FOnFrameDOMContentLoaded(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameWebMessageReceivedEvent(const sender   : ICoreWebView2Frame;
                                                          const args     : ICoreWebView2WebMessageReceivedEventArgs;
                                                                aFrameID : integer);
begin
  if assigned(FOnFrameWebMessageReceived) then
    FOnFrameWebMessageReceived(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnBasicAuthenticationRequestedEvent(const sender : ICoreWebView2;
                                                               const args   : ICoreWebView2BasicAuthenticationRequestedEventArgs);
begin
  if assigned(FOnBasicAuthenticationRequested) then
    FOnBasicAuthenticationRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnContextMenuRequestedEvent(const sender : ICoreWebView2;
                                                       const args   : ICoreWebView2ContextMenuRequestedEventArgs);
begin
  if assigned(FOnContextMenuRequested) then
    FOnContextMenuRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnCustomItemSelectedEvent(const sender : ICoreWebView2ContextMenuItem;
                                                     const args   : IUnknown);
begin
  if assigned(FOnCustomItemSelected) then
    FOnCustomItemSelected(self, sender);
end;

procedure TWVBrowserBase.doOnStatusBarTextChangedEvent(const sender : ICoreWebView2;
                                                       const args   : IUnknown);
begin
  if assigned(FOnStatusBarTextChanged) then
    FOnStatusBarTextChanged(self, sender);
end;

procedure TWVBrowserBase.doOnFramePermissionRequestedEvent(const sender   : ICoreWebView2Frame;
                                                           const args     : ICoreWebView2PermissionRequestedEventArgs2;
                                                                 aFrameID : integer);
begin
  if assigned(FOnFramePermissionRequested) then
    FOnFramePermissionRequested(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnClearBrowsingDataCompletedEvent(aErrorCode: HRESULT);
begin
  if assigned(FOnClearBrowsingDataCompleted) then
    FOnClearBrowsingDataCompleted(self, aErrorCode);
end;

procedure TWVBrowserBase.doOnServerCertificateErrorActionsCompletedEvent(aErrorCode: HRESULT);
begin
  if assigned(FOnServerCertificateErrorActionsCompleted) then
    FOnServerCertificateErrorActionsCompleted(self, aErrorCode);
end;

procedure TWVBrowserBase.doOnServerCertificateErrorDetectedEvent(const sender : ICoreWebView2;
                                                                 const args   : ICoreWebView2ServerCertificateErrorDetectedEventArgs);
begin
  if assigned(FOnServerCertificateErrorDetected) then
    FOnServerCertificateErrorDetected(self, sender, args);
end;

procedure TWVBrowserBase.doOnFaviconChangedEvent(const sender : ICoreWebView2;
                                                 const args   : IUnknown);
begin
  if assigned(FOnFaviconChanged) then
    FOnFaviconChanged(self, sender, args);
end;

procedure TWVBrowserBase.doOnGetFaviconCompletedEvent(      errorCode     : HResult;
                                                      const faviconStream : IStream);
begin
  if assigned(FOnGetFaviconCompleted) then
    FOnGetFaviconCompleted(self, errorCode, faviconStream);
end;

procedure TWVBrowserBase.doOnPrintCompletedEvent(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS);
begin
  if assigned(FOnPrintCompleted) then
    FOnPrintCompleted(self, errorCode, printStatus);
end;

procedure TWVBrowserBase.doOnPrintToPdfStreamCompletedEvent(errorCode: HResult; const pdfStream: IStream);
begin
  if assigned(FOnPrintToPdfStreamCompleted) then
    FOnPrintToPdfStreamCompleted(self, errorCode, pdfStream);
end;

procedure TWVBrowserBase.doOnGetCustomSchemes(var aSchemeRegistrations : TWVCustomSchemeRegistrationArray);
var
  TempArray : TWVCustomSchemeInfoArray;
  i, TempLen : integer;
begin
  if not(assigned(FOnGetCustomSchemes)) then exit;

  TempArray := nil;
  FOnGetCustomSchemes(self, TempArray);
  TempLen := length(TempArray);

  if (TempLen = 0) then exit;

  SetLength(aSchemeRegistrations,  TempLen);
  ZeroMemory(aSchemeRegistrations, TempLen * SizeOf(ICoreWebView2CustomSchemeRegistration));

  i := 0;
  while (i < TempLen) do
    begin
      aSchemeRegistrations[i] := TCoreWebView2CustomSchemeRegistration.Create(TempArray[i]);
      inc(i);
    end;
end;

procedure TWVBrowserBase.doOnGetNonDefaultPermissionSettingsCompleted(errorCode: HResult; const collectionView: ICoreWebView2PermissionSettingCollectionView);
begin
  if assigned(FOnGetNonDefaultPermissionSettingsCompleted) then
    FOnGetNonDefaultPermissionSettingsCompleted(self, errorCode, collectionView);
end;

procedure TWVBrowserBase.doOnSetPermissionStateCompleted(errorCode: HResult);
begin
  if assigned(FOnSetPermissionStateCompleted) then
    FOnSetPermissionStateCompleted(self, errorCode);
end;

procedure TWVBrowserBase.doOnRetrieveMHTMLCompleted(      aErrorCode          : HRESULT;
                                                    const aReturnObjectAsJson : wvstring);
var
  TempMHTML  : wvstring;
  TempResult : boolean;
begin
  if assigned(FOnRetrieveMHTMLCompleted) then
    begin
      TempMHTML  := '';
      TempResult := succeeded(aErrorCode) and
                    ExtractJSONData(aReturnObjectAsJson, TempMHTML);

      FOnRetrieveMHTMLCompleted(self, TempResult, TempMHTML);
    end;
end;

function TWVBrowserBase.ExtractJSONData(const aJSON: wvstring; var aData: wvstring) : boolean;
{$IFDEF FPC}
var
  TempJSON, TempData : TJSONData;
begin
  Result   := False;
  TempJSON := nil;

  if (length(aJSON) > 0) then
    try
      TempJSON := GetJSON(UTF8Encode(aJSON), False);
      TempData := TempJSON.FindPath('data');

      if assigned(TempData) then
        begin
          aData  := UTF8Decode(TempData.AsString);
          Result := True;
        end;
    finally
      if assigned(TempJSON) then
        FreeAndNil(TempJSON);
    end;
end;
{$ELSE}
{$IFDEF DELPHI20_UP}
var
  TempJSONObj : TJSONObject;
  TempJSONVal : TJSONValue;
begin
  Result      := False;
  TempJSONObj := nil;

  try
    if (length(aJSON) > 0) then
      begin
        TempJSONObj := TJSONObject.Create;

        if (TempJSONObj.Parse(BytesOf(aJSON), 0) >= 0) then
          begin
            TempJSONVal := TempJSONObj.GetValue('data');

            if assigned(TempJSONVal) then
              begin
                aData  := TempJSONVal.Value;
                Result := True;
              end;
          end;
      end;
  finally
    if assigned(TempJSONObj) then
      FreeAndNil(TempJSONObj);
  end;
end;
{$ELSE}
var
  TempJSON, TempKey, TempValue : wvstring;
  TempLen, i : integer;
begin
  Result   := False;
  TempJSON := trim(aJSON);
  TempLen  := length(TempJSON);

  if (TempLen > 0) and (TempJSON[1] = '{') and (TempJSON[TempLen] = '}') then
    begin
      TempJSON  := trim(copy(TempJSON, 2, TempLen - 2));
      i         := pos(':', TempJSON);
      TempKey   := trim(copy(TempJSON, 1, i - 1));
      TempValue := trim(copy(TempJSON, i + 1, TempLen));
      TempLen   := length(TempKey);

      if (TempLen > 0) and (TempKey[1] = '"') and (TempKey[TempLen] = '"') then
        begin
          TempKey := copy(TempKey, 2, TempLen - 2);

          if (CompareText(TempKey, 'data') = 0) then
            begin
              TempLen := length(TempValue);

              if (TempLen > 0) and (TempValue[1] = '"') and (TempValue[TempLen] = '"') then
                begin
                  aData  := JSONUnescape(copy(TempValue, 2, TempLen - 2));
                  Result := True;
                end;
            end;
        end;
    end;
end;
{$ENDIF}
{$ENDIF}

function TWVBrowserBase.ExtractEncodedJSON(const aJSON: wvstring): wvstring;
begin
  Result := '';

  {$IFDEF DELPHI21_UP}
  Result := TNetEncoding.URL.Decode(aJSON);
  {$ELSE}
    {$IFDEF FPC}
    Result := UTF8Decode(HTTPDecode(UTF8Encode(aJSON)));
    {$ELSE}
      {$IFDEF DELPHI12_UP}
      Result := UTF8ToWideString(CustomURLDecode(aJSON));
      {$ELSE}
      Result := UTF8Decode(CustomURLDecode(aJSON));
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}

  if (length(Result) > 0) and (Result[1] = '"') and (Result[length(Result)] = '"') then
    Result := copy(Result, 2, length(Result) - 2);
end;

function TWVBrowserBase.AddScriptToExecuteOnDocumentCreatedCompletedHandler_Invoke(errorCode: HResult; id: PWideChar): HRESULT;
begin
  Result := S_OK;
  doOnAddScriptToExecuteOnDocumentCreatedCompletedEvent(errorCode, wvstring(id));
end;

function TWVBrowserBase.IsMutedChangedEventHandler_Invoke(const sender : ICoreWebView2;
                                                          const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnIsMutedChanged(sender);
end;

function TWVBrowserBase.IsDocumentPlayingAudioChangedEventHandler_Invoke(const sender : ICoreWebView2;
                                                                         const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnIsDocumentPlayingAudioChanged(sender);
end;

function TWVBrowserBase.IsDefaultDownloadDialogOpenChangedEventHandler_Invoke(const sender : ICoreWebView2;
                                                                              const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnIsDefaultDownloadDialogOpenChanged(sender);
end;

function TWVBrowserBase.ProcessInfosChangedEventHandler_Invoke(const sender : ICoreWebView2Environment;
                                                               const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnProcessInfosChangedEvent(sender);
end;

function TWVBrowserBase.FrameNavigationStartingEventHandler2_Invoke(const sender   : ICoreWebView2Frame;
                                                                    const args     : ICoreWebView2NavigationStartingEventArgs;
                                                                          aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFrameNavigationStarting2(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameNavigationCompletedEventHandler2_Invoke(const sender   : ICoreWebView2Frame;
                                                                     const args     : ICoreWebView2NavigationCompletedEventArgs;
                                                                           aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFrameNavigationCompleted2(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameContentLoadingEventHandler_Invoke(const sender   : ICoreWebView2Frame;
                                                               const args     : ICoreWebView2ContentLoadingEventArgs;
                                                                     aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFrameContentLoadingEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameDOMContentLoadedEventHandler_Invoke(const sender   : ICoreWebView2Frame;
                                                                 const args     : ICoreWebView2DOMContentLoadedEventArgs;
                                                                       aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFrameDOMContentLoadedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameWebMessageReceivedEventHandler_Invoke(const sender   : ICoreWebView2Frame;
                                                                   const args     : ICoreWebView2WebMessageReceivedEventArgs;
                                                                         aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFrameWebMessageReceivedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.BasicAuthenticationRequestedEventHandler_Invoke(const sender : ICoreWebView2;
                                                                        const args   : ICoreWebView2BasicAuthenticationRequestedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnBasicAuthenticationRequestedEvent(sender, args);
end;

function TWVBrowserBase.ContextMenuRequestedEventHandler_Invoke(const sender : ICoreWebView2;
                                                                const args   : ICoreWebView2ContextMenuRequestedEventArgs): HRESULT;
begin
  Result := S_OK;
  DestroyMenuItemHandler;
  doOnContextMenuRequestedEvent(sender, args);
end;

function TWVBrowserBase.CustomItemSelectedEventHandler_Invoke(const sender : ICoreWebView2ContextMenuItem;
                                                              const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnCustomItemSelectedEvent(sender, args);
end;

function TWVBrowserBase.StatusBarTextChangedEventHandler_Invoke(const sender : ICoreWebView2;
                                                                const args   : IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnStatusBarTextChangedEvent(sender, args);
end;

function TWVBrowserBase.FramePermissionRequestedEventHandler_Invoke(const sender   : ICoreWebView2Frame;
                                                                    const args     : ICoreWebView2PermissionRequestedEventArgs2;
                                                                          aFrameID : integer): HRESULT;
begin
  Result := S_OK;
  doOnFramePermissionRequestedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.ClearBrowsingDataCompletedHandler_Invoke(errorCode: HResult): HRESULT;
begin
  Result := S_OK;
  doOnClearBrowsingDataCompletedEvent(errorCode);
end;

function TWVBrowserBase.ClearServerCertificateErrorActionsCompletedHandler_Invoke(errorCode: HResult): HRESULT;
begin
  Result := S_OK;
  doOnServerCertificateErrorActionsCompletedEvent(errorCode);
end;

function TWVBrowserBase.ServerCertificateErrorDetectedEventHandler_Invoke(const sender : ICoreWebView2;
                                                                          const args   : ICoreWebView2ServerCertificateErrorDetectedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnServerCertificateErrorDetectedEvent(sender, args);
end;

function TWVBrowserBase.FaviconChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnFaviconChangedEvent(sender, args);
end;

function TWVBrowserBase.GetFaviconCompletedHandler_Invoke(errorCode: HResult; const faviconStream: IStream): HRESULT;
begin
  Result := S_OK;
  doOnGetFaviconCompletedEvent(errorCode, faviconStream);
end;

function TWVBrowserBase.PrintCompletedHandler_Invoke(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS): HRESULT;
begin
  Result := S_OK;
  doOnPrintCompletedEvent(errorCode, printStatus);
end;

function TWVBrowserBase.PrintToPdfStreamCompletedHandler_Invoke(errorCode: HResult; const pdfStream: IStream): HRESULT;
begin
  Result := S_OK;
  doOnPrintToPdfStreamCompletedEvent(errorCode, pdfStream);
end;

function TWVBrowserBase.GetNonDefaultPermissionSettingsCompletedHandler_Invoke(errorCode: HResult; const collectionView: ICoreWebView2PermissionSettingCollectionView): HRESULT;
begin
  Result := S_OK;
  doOnGetNonDefaultPermissionSettingsCompleted(errorCode, collectionView);
end;

function TWVBrowserBase.SetPermissionStateCompletedHandler_Invoke(errorCode: HResult): HRESULT;
begin
  Result := S_OK;
  doOnSetPermissionStateCompleted(errorCode);
end;

function TWVBrowserBase.ExecuteScriptCompletedHandler_Invoke(errorCode: HRESULT; resultObjectAsJson: PWideChar; aExecutionID : integer): HRESULT;
begin
  Result := S_OK;

  case aExecutionID of
    WEBVIEW4DELPHI_JS_RETRIEVEHTMLJOB_ID :
      doOnRetrieveHTMLCompleted(errorCode, wvstring(resultObjectAsJson));

    WEBVIEW4DELPHI_JS_RETRIEVETEXTJOB_ID :
      doOnRetrieveTextCompleted(errorCode, wvstring(resultObjectAsJson));

    WEBVIEW4DELPHI_JS_REFRESH_ID :
      doOnRefreshIgnoreCacheCompleted(errorCode, wvstring(resultObjectAsJson));

    else
      doOnExecuteScriptCompleted(errorCode, wvstring(resultObjectAsJson), aExecutionID);
  end;
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnAfterCreated event when the browser is fully initialized
function TWVBrowserBase.CreateBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean) : boolean;
begin
  if aUseDefaultEnvironment and assigned(GlobalWebView2Loader) then
    Result := CreateBrowser(aHandle, GlobalWebView2Loader.Environment)
   else
    Result := CreateBrowser(aHandle, nil);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnAfterCreated event when the browser is fully initialized
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
      Result                   := CreateController;
    end
   else
    Result := CreateEnvironment;
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnAfterCreated event when the browser is fully initialized
function TWVBrowserBase.CreateWindowlessBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean) : boolean;
begin
  if aUseDefaultEnvironment and assigned(GlobalWebView2Loader) then
    Result := CreateWindowlessBrowser(aHandle, GlobalWebView2Loader.Environment)
   else
    Result := CreateWindowlessBrowser(aHandle, nil);
end;

function TWVBrowserBase.CreateCompositionController: boolean;
var
  TempError       : wvstring;
  TempHResult     : HRESULT;
  TempOptions     : TCoreWebView2ControllerOptions;
  TempOptionsIntf : ICoreWebView2ControllerOptions;
  TempOldWinVer   : boolean;
begin
  Result        := False;
  TempOldWinVer := False;
  TempHResult   := S_OK;

  if (Win32MajorVersion < 10) then
    TempOldWinVer := True
   else
    if FCoreWebView2Environment.CreateCoreWebView2ControllerOptions(TempOptionsIntf) then
      try
        TempOptions                        := TCoreWebView2ControllerOptions.Create(TempOptionsIntf);
        TempOptions.ProfileName            := FProfileName;
        TempOptions.IsInPrivateModeEnabled := FIsInPrivateModeEnabled;
        TempOptions.ScriptLocale           := FScriptLocale;

        Result := FCoreWebView2Environment.CreateCoreWebView2CompositionControllerWithOptions(FWindowParentHandle,
                                                                                              TempOptions.BaseIntf,
                                                                                              self,
                                                                                              TempHResult);
      finally
        FreeAndNil(TempOptions);
        TempOptionsIntf := nil;
      end
     else
      begin
        FProfileName            := '';
        FIsInPrivateModeEnabled := False;

        Result := FCoreWebView2Environment.CreateCoreWebView2CompositionController(FWindowParentHandle,
                                                                                   self,
                                                                                   TempHResult);
      end;

  if not(Result) then
    begin
      TempError := 'There was an error creating the composition controller. (3)' + CRLF;

      if TempOldWinVer then
        TempError := TempError + 'The composition controller requires at least Windows 10 or Windows Server 2016.'
       else
        TempError := TempError + 'Error code : 0x' +
                     {$IFDEF FPC}
                     UTF8Decode(inttohex(TempHResult, 8))
                     {$ELSE}
                     inttohex(TempHResult, 8)
                     {$ENDIF}
                      + CRLF + CompositionControllerCreationErrorToString(TempHResult);

      doOnInitializationError(TempHResult, TempError);
    end;
end;

function TWVBrowserBase.CreateController : boolean;
var
  TempError       : wvstring;
  TempHResult     : HRESULT;
  TempOptions     : TCoreWebView2ControllerOptions;
  TempOptionsIntf : ICoreWebView2ControllerOptions;
begin
  if FCoreWebView2Environment.CreateCoreWebView2ControllerOptions(TempOptionsIntf) then
    try
      TempOptions                        := TCoreWebView2ControllerOptions.Create(TempOptionsIntf);
      TempOptions.ProfileName            := FProfileName;
      TempOptions.IsInPrivateModeEnabled := FIsInPrivateModeEnabled;
      TempOptions.ScriptLocale           := FScriptLocale;

      Result := FCoreWebView2Environment.CreateCoreWebView2ControllerWithOptions(FWindowParentHandle,
                                                                                 TempOptions.BaseIntf,
                                                                                 self,
                                                                                 TempHResult);
    finally
      FreeAndNil(TempOptions);
      TempOptionsIntf := nil;
    end
   else
    begin
      FProfileName            := '';
      FIsInPrivateModeEnabled := False;

      Result := FCoreWebView2Environment.CreateCoreWebView2Controller(FWindowParentHandle,
                                                                      self,
                                                                      TempHResult);
    end;

  if not(Result) then
    begin
      TempError := 'There was an error creating the controller. (4)' + CRLF +
                   'Error code : 0x' +
                   {$IFDEF FPC}
                   UTF8Decode(inttohex(TempHResult, 8))
                   {$ELSE}
                   inttohex(TempHResult, 8)
                   {$ENDIF}
                   + CRLF + ControllerCreationErrorToString(TempHResult);

      doOnInitializationError(TempHResult, TempError);
    end;
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnAfterCreated event when the browser is fully initialized
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
        Result := CreateCompositionController
       else
        doOnInitializationError(E_FAIL, 'The environment doesn' + #39 + 't support a composition controller.');
    end
   else
    Result := CreateEnvironment;
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnExecuteScriptCompleted event when it finishes
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

function TWVBrowserBase.GetRootVisualTarget : IUnknown;
begin
  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.RootVisualTarget
   else
    Result := nil;
end;

function TWVBrowserBase.GetCursor : HCURSOR;
begin
  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.Cursor
   else
    Result := 0;
end;

function TWVBrowserBase.GetSystemCursorID : cardinal;
begin
  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.SystemCursorID
   else
    Result := 0;
end;

function TWVBrowserBase.GetAutomationProvider : IUnknown;
begin
  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.AutomationProvider
   else
    Result := nil;
end;

function TWVBrowserBase.GetProcessInfos : ICoreWebView2ProcessInfoCollection;
begin
  if Initialized then
    Result := FCoreWebView2Environment.ProcessInfos
   else
    Result := nil;
end;

function TWVBrowserBase.GetIsMuted : boolean;
begin
  Result := Initialized and
            FCoreWebView2.IsMuted;
end;

function TWVBrowserBase.GetIsDocumentPlayingAudio : boolean;
begin
  Result := Initialized and
            FCoreWebView2.IsDocumentPlayingAudio;
end;

function TWVBrowserBase.GetIsDefaultDownloadDialogOpen : boolean;
begin
  Result := Initialized and
            FCoreWebView2.IsDefaultDownloadDialogOpen;
end;

function TWVBrowserBase.GetStatusBarText : wvstring;
begin
  if Initialized then
    Result := FCoreWebView2.StatusBarText
   else
    Result := '';
end;

function TWVBrowserBase.GetDefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment;
begin
  if Initialized then
    Result := FCoreWebView2.DefaultDownloadDialogCornerAlignment
   else
    Result := 0;
end;

function TWVBrowserBase.GetDefaultDownloadDialogMargin : TPoint;
begin
  if Initialized then
    Result := FCoreWebView2.DefaultDownloadDialogMargin
   else
    Result := point(0, 0);
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
    {$IFDEF DELPHI16_UP}
    Result := TColors.SysNone;  // clNone
    {$ELSE}
    Result := clNone;
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

function TWVBrowserBase.GetAllowExternalDrop : boolean;
begin
  Result := Initialized and
            FCoreWebView2Controller.AllowExternalDrop;
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

function TWVBrowserBase.GetHiddenPdfToolbarItems : TWVPDFToolbarItems;
begin
  if Initialized then
    Result := FCoreWebView2Settings.HiddenPdfToolbarItems
   else
    Result := 0;
end;

function TWVBrowserBase.GetIsReputationCheckingRequired : boolean;
begin
  if Initialized then
    Result := FCoreWebView2Settings.IsReputationCheckingRequired
   else
    Result := True;
end;

function TWVBrowserBase.GetCustomItemSelectedEventHandler : ICoreWebView2CustomItemSelectedEventHandler;
begin
  if not(assigned(FMenuItemHandler)) then
    FMenuItemHandler := TCoreWebView2CustomItemSelectedEventHandler.Create(self);

  Result := FMenuItemHandler;
end;

function TWVBrowserBase.GetFaviconURI : wvstring;
begin
  if Initialized then
    Result := FCoreWebView2.FaviconURI
   else
    Result := '';
end;

function TWVBrowserBase.GetScreenScale : single;
begin
  if (GlobalWebView2Loader <> nil) then
    Result := GlobalWebView2Loader.DeviceScaleFactor
   else
    Result := 1;
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
  TempError   : wvstring;
  TempHResult : HRESULT;
  TempSchemeRegistrations : TWVCustomSchemeRegistrationArray;
  i : integer;
begin
  Result                  := False;
  TempSchemeRegistrations := nil;

  try
    doOnGetCustomSchemes(TempSchemeRegistrations);

    TempHandler := TCoreWebView2EnvironmentCompletedHandler.Create(self);

    TempOptions := TCoreWebView2EnvironmentOptions.Create(FAdditionalBrowserArguments,
                                                          FLanguage,
                                                          FTargetCompatibleBrowserVersion,
                                                          FAllowSingleSignOnUsingOSPrimaryAccount,
                                                          FExclusiveUserDataFolderAccess,
                                                          FCustomCrashReportingEnabled,
                                                          TempSchemeRegistrations,
                                                          FEnableTrackingPrevention);

    TempHResult := CreateCoreWebView2EnvironmentWithOptions(PWideChar(FBrowserExecPath),
                                                            PWideChar(FUserDataFolder),
                                                            TempOptions,
                                                            TempHandler);

    if succeeded(TempHResult) then
      Result := True
     else
      begin
        TempError := 'There was an error creating the browser environment. (2)' + CRLF +
                     'Error code : 0x' +
                     {$IFDEF FPC}
                     UTF8Decode(inttohex(TempHResult, 8))
                     {$ELSE}
                     inttohex(TempHResult, 8)
                     {$ENDIF}
                     + CRLF + EnvironmentCreationErrorToString(TempHResult);

        doOnInitializationError(TempHResult, TempError);
      end;
  finally
    TempOptions := nil;
    TempHandler := nil;

    if assigned(TempSchemeRegistrations) then
      begin
        i := pred(length(TempSchemeRegistrations));
        while (i >= 0) do
          begin
            TempSchemeRegistrations[i] := nil;
            dec(i);
          end;
      end;
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnRefreshIgnoreCacheCompleted event when it finishes
function TWVBrowserBase.RefreshIgnoreCache : boolean;
begin
  Result := ExecuteScript('location.reload(true);', WEBVIEW4DELPHI_JS_REFRESH_ID);
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

procedure TWVBrowserBase.SetAllowExternalDrop(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Controller.AllowExternalDrop := aValue;
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

procedure TWVBrowserBase.SetHiddenPdfToolbarItems(aValue : TWVPDFToolbarItems);
begin
  if Initialized then
    FCoreWebView2Settings.HiddenPdfToolbarItems := aValue;
end;

procedure TWVBrowserBase.SetIsReputationCheckingRequired(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsReputationCheckingRequired := aValue;
end;

procedure TWVBrowserBase.SetProfileName(const aValue : wvstring);
const
  PROFILENAME_VALID_CHARS      = ['a'..'z', 'A'..'Z', '0'..'9', '#', '@', '$', '(', ')', '+', '-', '_', '~', '.', ' '];
  PROFILENAME_INVALID_ENDCHARS = ['.', ' '];
  PROFILENAME_MAX_LENGTH       = 64;
var
  i : integer;
  TempValue : wvstring;
begin
  TempValue := '';
  i         := 1;

  while (i <= length(aValue)) do
    begin
      {$IFDEF DELPHI12_UP}
      if CharInSet(aValue[i], PROFILENAME_VALID_CHARS) then
      {$ELSE}
      if (Char(aValue[i]) in PROFILENAME_VALID_CHARS) then
      {$ENDIF}
        TempValue := TempValue + aValue[i];

      inc(i);
    end;

  TempValue := copy(TempValue, 1, PROFILENAME_MAX_LENGTH);

  while (length(TempValue) > 0) and
        {$IFDEF DELPHI12_UP}
        CharInSet(TempValue[length(TempValue)], PROFILENAME_INVALID_ENDCHARS) do
        {$ELSE}
        (Char(TempValue[length(TempValue)]) in PROFILENAME_INVALID_ENDCHARS) do
        {$ENDIF}
    TempValue := copy(TempValue, 1, pred(length(TempValue)));

  FProfileName := TempValue;
end;

procedure TWVBrowserBase.SetBuiltInErrorPageEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsBuiltInErrorPageEnabled := aValue;
end;

procedure TWVBrowserBase.SetDefaultContextMenusEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreDefaultContextMenusEnabled := aValue;
end;

procedure TWVBrowserBase.SetDefaultScriptDialogsEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreDefaultScriptDialogsEnabled := aValue;
end;

procedure TWVBrowserBase.SetDevToolsEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.AreDevToolsEnabled := aValue;
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

procedure TWVBrowserBase.ToggleMuteState;
begin
  if Initialized then
    FCoreWebView2.IsMuted := not(FCoreWebView2.IsMuted);
end;

function TWVBrowserBase.OpenDefaultDownloadDialog : boolean;
begin
  Result := Initialized and
            FCoreWebView2.OpenDefaultDownloadDialog;
end;

function TWVBrowserBase.CloseDefaultDownloadDialog : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CloseDefaultDownloadDialog;
end;

function TWVBrowserBase.ClearServerCertificateErrorActions : boolean;
begin
  Result := Initialized and
            FCoreWebView2.ClearServerCertificateErrorActions(self);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnGetFaviconCompleted event when it finishes
function TWVBrowserBase.GetFavicon(aFormat: TWVFaviconImageFormat) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.GetFavicon(aFormat, self);
end;

function TWVBrowserBase.PostSharedBufferToScript(const aSharedBuffer         : ICoreWebView2SharedBuffer;
                                                       aAccess               : TWVSharedBufferAccess;
                                                 const aAdditionalDataAsJson : wvstring): boolean;
begin
  Result := Initialized and
            FCoreWebView2.PostSharedBufferToScript(aSharedBuffer, aAccess, aAdditionalDataAsJson);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnTrySuspendCompleted event when it finishes
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnRetrieveHTMLCompleted event with the HTML contents
function TWVBrowserBase.RetrieveHTML : boolean;
begin
  // JS code created by Alessandro Mancini
  Result := ExecuteScript('encodeURI(document.documentElement.outerHTML);', WEBVIEW4DELPHI_JS_RETRIEVEHTMLJOB_ID);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnRetrieveTextCompleted event with the text contents
function TWVBrowserBase.RetrieveText : boolean;
begin
  Result := ExecuteScript('encodeURI(document.body.textContent);', WEBVIEW4DELPHI_JS_RETRIEVETEXTJOB_ID);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnRetrieveMHTMLCompleted event with the MHTML contents
function TWVBrowserBase.RetrieveMHTML : boolean;
begin
  Result := CallDevToolsProtocolMethod('Page.captureSnapshot', '{"format": "mhtml"}', WEBVIEW4DELPHI_DEVTOOLS_RETRIEVEMHTML_ID);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnPrintCompleted event when it finishes
function TWVBrowserBase.Print : boolean;
var
  TempHandler : ICoreWebView2PrintCompletedHandler;
begin
  Result := False;

  if Initialized and
     assigned(FCoreWebView2PrintSettings) and
     FCoreWebView2PrintSettings.Initialized then
    try
      TempHandler := TCoreWebView2PrintCompletedHandler.Create(self);
      Result      := FCoreWebView2.Print(FCoreWebView2PrintSettings.BaseIntf, TempHandler);
    finally
      TempHandler := nil;
    end;
end;

function TWVBrowserBase.ShowPrintUI(aUseSystemPrintDialog : boolean): boolean;
begin
  if Initialized then
    begin
      if aUseSystemPrintDialog then
        Result := FCoreWebView2.ShowPrintUI(COREWEBVIEW2_PRINT_DIALOG_KIND_SYSTEM)
       else
        Result := FCoreWebView2.ShowPrintUI(COREWEBVIEW2_PRINT_DIALOG_KIND_BROWSER);
    end
   else
    Result := False;
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnPrintToPdfCompleted event when it finishes
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnPrintToPdfStream event
function TWVBrowserBase.PrintToPdfStream : boolean;
var
  TempHandler : ICoreWebView2PrintToPdfStreamCompletedHandler;
begin
  Result := False;

  if Initialized and
     assigned(FCoreWebView2PrintSettings) and
     FCoreWebView2PrintSettings.Initialized then
    try
      TempHandler := TCoreWebView2PrintToPdfStreamCompletedHandler.Create(self);
      Result      := FCoreWebView2.PrintToPdfStream(FCoreWebView2PrintSettings.BaseIntf, TempHandler);
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnCallDevToolsProtocolMethodCompleted event when it finishes
function TWVBrowserBase.CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CallDevToolsProtocolMethod(aMethodName, aParametersAsJson, aExecutionID, self);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnCallDevToolsProtocolMethodCompleted event when it finishes
function TWVBrowserBase.CallDevToolsProtocolMethodForSession(const aSessionId, aMethodName, aParametersAsJson : wvstring; aExecutionID : integer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CallDevToolsProtocolMethodForSession(aSessionId, aMethodName, aParametersAsJson, aExecutionID, self);
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnAddScriptToExecuteOnDocumentCreatedCompleted event when it finishes
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnGetCookiesCompleted event when it finishes
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

// This function is asynchronous and it triggers the TWVBrowserBase.OnClearCacheCompleted event when it finishes
function TWVBrowserBase.ClearCache : boolean;
begin
  Result := CallDevToolsProtocolMethod('Network.clearBrowserCache', '{}', WEBVIEW4DELPHI_DEVTOOLS_CLEARBROWSERCACHE_ID);
end;

// This function is asynchronous and it triggers the TWVBrowserBase.OnClearDataForOriginCompleted event when it finishes
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

  Result := CallDevToolsProtocolMethod('Storage.clearDataForOrigin', TempParams, WEBVIEW4DELPHI_DEVTOOLS_CLEARDATAFORORIGIN_ID);
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

      CallDevToolsProtocolMethod('Network.emulateNetworkConditions', TempParams, WEBVIEW4DELPHI_DEVTOOLS_EMULATENETWORKCONDITIONS_ID);
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

      CallDevToolsProtocolMethod('Security.setIgnoreCertificateErrors', TempParams, WEBVIEW4DELPHI_DEVTOOLS_SETIGNORECERTIFICATEERRORS_ID);
    end;
end;

procedure TWVBrowserBase.SetRootVisualTarget(const aValue : IUnknown);
begin
  if FUseCompositionController and Initialized then
    FCoreWebView2CompositionController.RootVisualTarget := aValue;
end;

procedure TWVBrowserBase.SetIsMuted(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2.IsMuted := aValue;
end;

procedure TWVBrowserBase.SetDefaultDownloadDialogCornerAlignment(aValue : TWVDefaultDownloadDialogCornerAlignment);
begin
  if Initialized then
    FCoreWebView2.DefaultDownloadDialogCornerAlignment := aValue;
end;

procedure TWVBrowserBase.SetDefaultDownloadDialogMargin(aValue : TPoint);
begin
  if Initialized then
    FCoreWebView2.DefaultDownloadDialogMargin := aValue;
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

procedure TWVBrowserBase.SetScriptEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsScriptEnabled := aValue;
end;

procedure TWVBrowserBase.SetStatusBarEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsStatusBarEnabled := aValue;
end;

procedure TWVBrowserBase.SetWebMessageEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsWebMessageEnabled := aValue;
end;

procedure TWVBrowserBase.SetZoomControlEnabled(aValue: boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsZoomControlEnabled := aValue;
end;

procedure TWVBrowserBase.SetZoomFactor(const aValue: Double);
begin
  if Initialized then
    FCoreWebView2Controller.ZoomFactor := aValue;
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

procedure TWVBrowserBase.SetIsVisible(aValue : boolean);
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

procedure TWVBrowserBase.doOnRefreshIgnoreCacheCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring);
begin
  if assigned(FOnRefreshIgnoreCacheCompleted) then
    FOnRefreshIgnoreCacheCompleted(self, aErrorCode, aResultObjectAsJson);
end;

procedure TWVBrowserBase.doOnRetrieveHTMLCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring);
var
  TempResult : wvstring;
begin
  if succeeded(aErrorCode) and assigned(FOnRetrieveHTMLCompleted) then
    begin
      TempResult := ExtractEncodedJSON(aResultObjectAsJson);
      FOnRetrieveHTMLCompleted(self, length(TempResult) > 0, TempResult);
    end;
end;

procedure TWVBrowserBase.doOnRetrieveTextCompleted(aErrorCode: HRESULT; const aResultObjectAsJson: wvstring);
var
  TempResult : wvstring;
begin
  if succeeded(aErrorCode) and assigned(FOnRetrieveTextCompleted) then
    begin
      TempResult := ExtractEncodedJSON(aResultObjectAsJson);
      FOnRetrieveTextCompleted(self, length(TempResult) > 0, TempResult);
    end;
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

procedure TWVBrowserBase.doOnWebResourceResponseViewGetContentCompletedEvent(errorCode: HResult; const Content: IStream; aResourceID : integer);
begin
  if assigned(FOnWebResourceResponseViewGetContentCompleted) then
    FOnWebResourceResponseViewGetContentCompleted(self, errorCode, Content, aResourceID);
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

// Blink editing commands used by the "Input.dispatchKeyEvent" DevTools method.
// https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent
// https://source.chromium.org/chromium/chromium/src/+/master:third_party/blink/renderer/core/editing/commands/editor_command_names.h
// This function is asynchronous and it triggers the TWVBrowserBase.OnSimulateKeyEventCompleted event when it finishes
function TWVBrowserBase.SimulateEditingCommand(aEditingCommand : TWV2EditingCommand): boolean;
var
  TempParams : wvstring;
begin
  TempParams := '{"type": "char", "commands": ["' + EditingCommandToString(aEditingCommand) + '"]}';
  Result     := CallDevToolsProtocolMethod('Input.dispatchKeyEvent', TempParams, WEBVIEW4DELPHI_DEVTOOLS_SIMULATEKEYEVENT_ID);
end;

// Dispatches a key event to the page using the "Input.dispatchKeyEvent" DevTools method
// https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent
// The browser has to be focused before simulating any key event.
// This function is asynchronous and it triggers the TWVBrowserBase.OnSimulateKeyEventCompleted event when it finishes
function TWVBrowserBase.SimulateKeyEvent(      type_                 : TWV2KeyEventType;
                                               modifiers             : integer;
                                               windowsVirtualKeyCode : integer;
                                               nativeVirtualKeyCode  : integer;
                                               timestamp             : integer;
                                               location              : integer;
                                               autoRepeat            : boolean;
                                               isKeypad              : boolean;
                                               isSystemKey           : boolean;
                                         const text                  : wvstring;
                                         const unmodifiedtext        : wvstring;
                                         const keyIdentifier         : wvstring;
                                         const code                  : wvstring;
                                         const key                   : wvstring): boolean;
var
  TempParams : wvstring;
begin
  TempParams := '{"type": ';

  case type_ of
    ketKeyDown    : TempParams := TempParams + '"keyDown"';
    ketKeyUp      : TempParams := TempParams + '"keyUp"';
    ketRawKeyDown : TempParams := TempParams + '"rawKeyDown"';
    ketChar       : TempParams := TempParams + '"char"';
  end;

  if (modifiers <> 0) then
    TempParams := TempParams + ', "modifiers": ' + inttostr(modifiers);

  if (timestamp <> 0) then
    TempParams := TempParams + ', "timestamp": ' + inttostr(timestamp);

  if (length(text) > 0) then
    TempParams := TempParams + ', "text": "' + JSONEscape(text) + '"';

  if (length(unmodifiedtext) > 0) then
    TempParams := TempParams + ', "unmodifiedtext": "' + JSONEscape(unmodifiedtext) + '"';

  if (length(keyIdentifier) > 0) then
    TempParams := TempParams + ', "keyIdentifier": "' + JSONEscape(keyIdentifier) + '"';

  if (length(code) > 0) then
    TempParams := TempParams + ', "code": "' + JSONEscape(code) + '"';

  if (length(key) > 0) then
    TempParams := TempParams + ', "key": "' + JSONEscape(key) + '"';

  if (windowsVirtualKeyCode <> 0) then
    TempParams := TempParams + ', "windowsVirtualKeyCode": ' + inttostr(windowsVirtualKeyCode);

  if (nativeVirtualKeyCode <> 0) then
    TempParams := TempParams + ', "nativeVirtualKeyCode": ' + inttostr(nativeVirtualKeyCode);

  if autoRepeat then
    TempParams := TempParams + ', "autoRepeat": true';

  if isKeypad then
    TempParams := TempParams + ', "isKeypad": true';

  if isSystemKey then
    TempParams := TempParams + ', "isSystemKey": true';

  if (location <> 0) then
    TempParams := TempParams + ', "location": ' + inttostr(location);

  TempParams := TempParams + '}';

  Result := CallDevToolsProtocolMethod('Input.dispatchKeyEvent', TempParams, WEBVIEW4DELPHI_DEVTOOLS_SIMULATEKEYEVENT_ID);
end;

// Simulate that the F3 key was pressed and released.
// The browser has to be focused before simulating any key event.
// This key information was logged using a Spanish keyboard. It might not work with different keyboard layouts.
// This function is asynchronous and it triggers the TWVBrowserBase.OnSimulateKeyEventCompleted event several times
function TWVBrowserBase.KeyboardShortcutSearch : boolean;
begin
  Result := SimulateKeyEvent(ketRawKeyDown, $100, VK_F3, integer($003D0001)) and
            SimulateKeyEvent(ketKeyUp,      $100, VK_F3, integer($C03D0001));
end;

// Simulate that SHIFT + F5 keys were pressed and released
// The browser has to be focused before simulating any key event.       
// This key information was logged using a Spanish keyboard. It might not work with different keyboard layouts.
// This function is asynchronous and it triggers the TWVBrowserBase.OnSimulateKeyEventCompleted event several times
function TWVBrowserBase.KeyboardShortcutRefreshIgnoreCache : boolean;
begin
  Result := SimulateKeyEvent(ketRawKeyDown, $502, VK_Shift, integer($002A0001)) and
            SimulateKeyEvent(ketRawKeyDown, $102, VK_F5,    integer($003F0001)) and
            SimulateKeyEvent(ketKeyUp,      $102, VK_F5,    integer($C03F0001)) and
            SimulateKeyEvent(ketKeyUp,      $100, VK_Shift, integer($C02A0001));
end;

function TWVBrowserBase.SendMouseInput(aEventKind : TWVMouseEventKind; aVirtualKeys : TWVMouseEventVirtualKeys; aMouseData : cardinal; aPoint : TPoint) : boolean;
begin
  Result := FUseCompositionController and
            Initialized and
            FCoreWebView2CompositionController.SendMouseInput(aEventKind, aVirtualKeys, aMouseData, aPoint);
end;

function TWVBrowserBase.SendPointerInput(aEventKind : TWVPointerEventKind; const aPointerInfo : ICoreWebView2PointerInfo) : boolean;
begin
  Result := FUseCompositionController and
            Initialized and
            FCoreWebView2CompositionController.SendPointerInput(aEventKind, aPointerInfo);
end;

function TWVBrowserBase.DragEnter(const dataObject: IDataObject; keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
var
  TempPoint : tagPoint;
begin
  Result := S_OK;
  effect := DROPEFFECT_NONE;

  TempPoint.x := point.X;
  TempPoint.y := point.Y;

  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.DragEnter(dataObject, keyState, TempPoint, effect);
end;

function TWVBrowserBase.DragLeave : HResult;
begin
  Result := S_OK;

  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.DragLeave;
end;

function TWVBrowserBase.DragOver(keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
var
  TempPoint : tagPoint;
begin
  Result := S_OK;
  effect := DROPEFFECT_NONE;

  TempPoint.x := point.X;
  TempPoint.y := point.Y;

  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.DragOver(keyState, TempPoint, effect);
end;

function TWVBrowserBase.Drop(const dataObject: IDataObject; keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
var
  TempPoint : tagPoint;
begin
  Result := S_OK;
  effect := DROPEFFECT_NONE;

  TempPoint.x := point.X;
  TempPoint.y := point.Y;

  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.Drop(dataObject, keyState, TempPoint, effect);
end;

function TWVBrowserBase.ClearBrowsingData(dataKinds: TWVBrowsingDataKinds): boolean;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := False;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.ClearBrowsingData(dataKinds, FClearBrowsingDataCompletedHandler);
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.ClearBrowsingDataInTimeRange(dataKinds: TWVBrowsingDataKinds; const startTime, endTime: TDateTime): boolean;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := False;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.ClearBrowsingDataInTimeRange(dataKinds, startTime, endTime, FClearBrowsingDataCompletedHandler);
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.ClearBrowsingDataAll: boolean;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := False;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.ClearBrowsingDataAll(FClearBrowsingDataCompletedHandler);
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.SetPermissionState(aPermissionKind: TWVPermissionKind; const aOrigin: wvstring; aState: TWVPermissionState) : boolean;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := False;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.SetPermissionState(aPermissionKind, aOrigin, aState, FSetPermissionStateCompletedHandler);
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetNonDefaultPermissionSettings: boolean;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := False;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.GetNonDefaultPermissionSettings(FGetNonDefaultPermissionSettingsCompletedHandler);
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetProfileName : wvstring;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := FProfileName;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.ProfileName;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetIsInPrivateModeEnabled : boolean;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := FIsInPrivateModeEnabled;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.IsInPrivateModeEnabled;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetProfilePath : wvstring;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := '';
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.ProfilePath;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetDefaultDownloadFolderPath : wvstring;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := '';
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.DefaultDownloadFolderPath;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

procedure TWVBrowserBase.SetDefaultDownloadFolderPath(const aValue : wvstring);
var
  TempProfile : TCoreWebView2Profile;
begin
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      TempProfile.DefaultDownloadFolderPath := aValue;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetPreferredColorScheme : TWVPreferredColorScheme;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := COREWEBVIEW2_PREFERRED_COLOR_SCHEME_AUTO;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.PreferredColorScheme;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

procedure TWVBrowserBase.SetPreferredColorScheme(const aValue : TWVPreferredColorScheme);
var
  TempProfile : TCoreWebView2Profile;
begin
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      TempProfile.PreferredColorScheme := aValue;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.PreferredTrackingPreventionLevel;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.GetProfileCookieManager : ICoreWebView2CookieManager;
var
  TempProfile : TCoreWebView2Profile;
begin
  Result      := nil;
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      Result      := TempProfile.CookieManager;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

procedure TWVBrowserBase.SetPreferredTrackingPreventionLevel(const aValue : TWVTrackingPreventionLevel);
var
  TempProfile : TCoreWebView2Profile;
begin
  TempProfile := nil;

  if Initialized then
    try
      TempProfile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
      TempProfile.PreferredTrackingPreventionLevel := aValue;
    finally
      if assigned(TempProfile) then
        FreeAndNil(TempProfile);
    end;
end;

function TWVBrowserBase.CreateSharedBuffer(aSize : Largeuint; var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2Environment.CreateSharedBuffer(aSize, aSharedBuffer);
end;

end.
