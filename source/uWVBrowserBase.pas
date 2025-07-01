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
  uWVCoreWebView2CookieManager, uWVCoreWebView2Delegates,
  uWVCoreWebView2Profile;

type
  /// <summary>
  /// Parent class of TWVBrowser and TWVFMXBrowser that puts together all browser procedures, functions, properties and events in one place.
  /// It has all you need to create, modify and destroy a web browser.
  /// </summary>
  TWVBrowserBase = class(TComponent, IWVBrowserEvents)
    protected
      FCoreWebView2PrintSettings                       : TCoreWebView2PrintSettings;
      FCoreWebView2Settings                            : TCoreWebView2Settings;
      FCoreWebView2Environment                         : TCoreWebView2Environment;
      FCoreWebView2Controller                          : TCoreWebView2Controller;
      FCoreWebView2CompositionController               : TCoreWebView2CompositionController;
      FCoreWebView2                                    : TCoreWebView2;
      FCoreWebView2Profile                             : TCoreWebView2Profile;
      FWindowParentHandle                              : THandle;
      FUseDefaultEnvironment                           : boolean;
      FUseCompositionController                        : boolean;
      FDefaultURL                                      : wvstring;
      FBrowserExecPath                                 : wvstring;
      FUserDataFolder                                  : wvstring;
      FIgnoreCertificateErrors                         : boolean;
      FZoomStep                                        : byte;
      FOffline                                         : boolean;
      FIsNavigating                                    : boolean;
      FProfileName                                     : wvstring;
      FIsInPrivateModeEnabled                          : boolean;
      FClearBrowsingDataCompletedHandler               : ICoreWebView2ClearBrowsingDataCompletedHandler;
      FSetPermissionStateCompletedHandler              : ICoreWebView2SetPermissionStateCompletedHandler;
      FGetNonDefaultPermissionSettingsCompletedHandler : ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler;
      FProfileAddBrowserExtensionCompletedHandler      : ICoreWebView2ProfileAddBrowserExtensionCompletedHandler;
      FProfileGetBrowserExtensionsCompletedHandler     : ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler;
      FPreferredTrackingPreventionLevel                : TWVTrackingPreventionLevel;
      FScriptLocale                                    : wvstring;
      FDefaultBackgroundColor                          : TColor;
      FAllowHostInputProcessing                        : boolean;

      // Fields used to create the environment
      FAdditionalBrowserArguments                      : wvstring;
      FLanguage                                        : wvstring;
      FTargetCompatibleBrowserVersion                  : wvstring;
      FAllowSingleSignOnUsingOSPrimaryAccount          : boolean;
      FExclusiveUserDataFolderAccess                   : boolean;
      FCustomCrashReportingEnabled                     : boolean;
      FEnableTrackingPrevention                        : boolean;
      FAreBrowserExtensionsEnabled                     : boolean;
      FChannelSearchKind                               : TWVChannelSearchKind;
      FReleaseChannels                                 : TWVReleaseChannels;
      FScrollBarStyle                                  : TWVScrollBarStyle;

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
      FOnLaunchingExternalUriScheme                   : TOnLaunchingExternalUriSchemeEvent;
      FOnGetProcessExtendedInfosCompleted             : TOnGetProcessExtendedInfosCompletedEvent;
      FOnBrowserExtensionRemoveCompleted              : TOnBrowserExtensionRemoveCompletedEvent;
      FOnBrowserExtensionEnableCompleted              : TOnBrowserExtensionEnableCompletedEvent;
      FOnProfileAddBrowserExtensionCompleted          : TOnProfileAddBrowserExtensionCompletedEvent;
      FOnProfileGetBrowserExtensionsCompleted         : TOnProfileGetBrowserExtensionsCompletedEvent;
      FOnProfileDeleted                               : TOnProfileDeletedEvent;
      FOnExecuteScriptWithResultCompleted             : TOnExecuteScriptWithResultCompletedEvent;
      FOnNonClientRegionChanged                       : TOnNonClientRegionChangedEvent;
      FOnNotificationReceived                         : TOnNotificationReceivedEvent;
      FOnNotificationCloseRequested                   : TOnNotificationCloseRequestedEvent;
      FOnSaveAsUIShowing                              : TOnSaveAsUIShowingEvent;
      FOnShowSaveAsUICompleted                        : TOnShowSaveAsUICompletedEvent;
      FOnSaveFileSecurityCheckStarting                : TOnSaveFileSecurityCheckStartingEvent;
      FOnScreenCaptureStarting                        : TOnScreenCaptureStartingEvent;
      FOnFrameScreenCaptureStarting                   : TOnFrameScreenCaptureStartingEvent;
      FOnFrameChildFrameCreated                       : TOnFrameChildFrameCreatedEvent;

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
      function  GetIsNonClientRegionSupportEnabled : boolean;
      function  GetFaviconURI : wvstring;
      function  GetScreenScale : single; virtual;
      function  GetProfileName : wvstring;
      function  GetIsInPrivateModeEnabled : boolean;
      function  GetProfilePath : wvstring;
      function  GetDefaultDownloadFolderPath : wvstring;
      function  GetPreferredColorScheme : TWVPreferredColorScheme;
      function  GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
      function  GetProfileCookieManager : ICoreWebView2CookieManager;
      function  GetProfileIsPasswordAutosaveEnabled : boolean;
      function  GetProfileIsGeneralAutofillEnabled : boolean;
      function  GetMemoryUsageTargetLevel : TWVMemoryUsageTargetLevel;
      function  GetFrameID : cardinal;

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
      procedure SetIsNonClientRegionSupportEnabled(aValue : boolean);
      procedure SetProfileName(const aValue : wvstring);
      procedure SetDefaultDownloadFolderPath(const aValue : wvstring);
      procedure SetPreferredColorScheme(const aValue : TWVPreferredColorScheme);
      procedure SetPreferredTrackingPreventionLevel(const aValue : TWVTrackingPreventionLevel);
      procedure SetProfileIsPasswordAutosaveEnabled(aValue : boolean);
      procedure SetProfileIsGeneralAutofillEnabled(aValue : boolean);
      procedure SetMemoryUsageTargetLevel(aValue : TWVMemoryUsageTargetLevel);

      function  CreateEnvironment : boolean;
      function  CreateCompositionController: boolean;
      function  CreateController : boolean;

      procedure DestroyEnvironment;
      procedure DestroyController;
      procedure DestroyCompositionController;
      procedure DestroyWebView;
      procedure DestroyProfile;
      procedure DestroySettings;
      procedure DestroyPrintSettings;

      procedure CalculateZoomStep;
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

      function EnvironmentCompletedHandler_Invoke(errorCode: HRESULT; const result_: ICoreWebView2Environment): HRESULT;
      function ControllerCompletedHandler_Invoke(errorCode: HRESULT; const result_: ICoreWebView2Controller): HRESULT;
      function ExecuteScriptCompletedHandler_Invoke(errorCode: HRESULT; result_: PWideChar; aExecutionID : integer): HRESULT;
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
      function CreateCoreWebView2CompositionControllerCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2CompositionController): HRESULT;
      function CursorChangedEventHandler_Invoke(const sender: ICoreWebView2CompositionController; const args: IUnknown): HRESULT;
      function BrowserProcessExitedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: ICoreWebView2BrowserProcessExitedEventArgs): HRESULT;
      function RasterizationScaleChangedEventHandler_Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HRESULT;
      function WebResourceResponseReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2WebResourceResponseReceivedEventArgs): HRESULT;
      function DOMContentLoadedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs): HRESULT;
      function WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode: HResult; const result_: IStream; aResourceID : integer): HRESULT;
      function GetCookiesCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2CookieList): HRESULT;
      function TrySuspendCompletedHandler_Invoke(errorCode: HResult; result_: Integer): HRESULT;
      function FrameCreatedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs): HRESULT;
      function DownloadStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs): HRESULT;
      function ClientCertificateRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs): HRESULT;
      function PrintToPdfCompletedHandler_Invoke(errorCode: HResult; result_: Integer): HRESULT;
      function BytesReceivedChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
      function EstimatedEndTimeChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
      function StateChangedEventHandler_Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer): HRESULT;
      function FrameNameChangedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal): HRESULT;
      function FrameDestroyedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal): HRESULT;
      function CallDevToolsProtocolMethodCompletedHandler_Invoke(errorCode: HResult; result_: PWideChar; aExecutionID : integer): HRESULT;
      function AddScriptToExecuteOnDocumentCreatedCompletedHandler_Invoke(errorCode: HResult; result_: PWideChar): HRESULT;
      function IsMutedChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function IsDocumentPlayingAudioChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function IsDefaultDownloadDialogOpenChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function ProcessInfosChangedEventHandler_Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HRESULT;
      function FrameNavigationStartingEventHandler2_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationStartingEventArgs; aFrameID: cardinal): HRESULT;
      function FrameNavigationCompletedEventHandler2_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationCompletedEventArgs; aFrameID: cardinal): HRESULT;
      function FrameContentLoadingEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ContentLoadingEventArgs; aFrameID: cardinal): HRESULT;
      function FrameDOMContentLoadedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2DOMContentLoadedEventArgs; aFrameID: cardinal): HRESULT;
      function FrameWebMessageReceivedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2WebMessageReceivedEventArgs; aFrameID: cardinal): HRESULT;
      function BasicAuthenticationRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2BasicAuthenticationRequestedEventArgs): HRESULT;
      function ContextMenuRequestedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContextMenuRequestedEventArgs): HRESULT;
      function CustomItemSelectedEventHandler_Invoke(const sender: ICoreWebView2ContextMenuItem; const args: IUnknown): HRESULT;
      function StatusBarTextChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function FramePermissionRequestedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2PermissionRequestedEventArgs2; aFrameID: cardinal): HRESULT;
      function ClearBrowsingDataCompletedHandler_Invoke(errorCode: HResult): HRESULT;
      function ClearServerCertificateErrorActionsCompletedHandler_Invoke(errorCode: HResult): HRESULT;
      function ServerCertificateErrorDetectedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ServerCertificateErrorDetectedEventArgs): HRESULT;
      function FaviconChangedEventHandler_Invoke(const sender: ICoreWebView2; const args: IUnknown): HRESULT;
      function GetFaviconCompletedHandler_Invoke(errorCode: HResult; const result_: IStream): HRESULT;
      function PrintCompletedHandler_Invoke(errorCode: HResult; result_: COREWEBVIEW2_PRINT_STATUS): HRESULT;
      function PrintToPdfStreamCompletedHandler_Invoke(errorCode: HResult; const result_: IStream): HRESULT;
      function GetNonDefaultPermissionSettingsCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2PermissionSettingCollectionView): HRESULT;
      function SetPermissionStateCompletedHandler_Invoke(errorCode: HResult): HRESULT;
      function LaunchingExternalUriSchemeEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2LaunchingExternalUriSchemeEventArgs): HRESULT;
      function GetProcessExtendedInfosCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2ProcessExtendedInfoCollection): HRESULT;
      function BrowserExtensionRemoveCompletedHandler_Invoke(errorCode: HResult; const aExtensionID: wvstring): HRESULT;
      function BrowserExtensionEnableCompletedHandler_Invoke(errorCode: HResult; const aExtensionID: wvstring): HRESULT;
      function ProfileAddBrowserExtensionCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtension): HRESULT;
      function ProfileGetBrowserExtensionsCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtensionList): HRESULT;
      function ProfileDeletedEventHandler_Invoke(const sender: ICoreWebView2Profile; const args: IUnknown): HRESULT;
      function ExecuteScriptWithResultCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2ExecuteScriptResult; aExecutionID : integer): HRESULT;
      function NonClientRegionChangedEventHandler_Invoke(const sender: ICoreWebView2CompositionController; const args: ICoreWebView2NonClientRegionChangedEventArgs): HRESULT;
      function NotificationReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NotificationReceivedEventArgs): HRESULT;
      function NotificationCloseRequestedEventHandler_Invoke(const sender: ICoreWebView2Notification; const args: IUnknown): HRESULT;
      function SaveAsUIShowingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveAsUIShowingEventArgs): HRESULT;
      function ShowSaveAsUICompletedHandler_Invoke(errorCode: HResult; result_: COREWEBVIEW2_SAVE_AS_UI_RESULT): HRESULT;
      function SaveFileSecurityCheckStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveFileSecurityCheckStartingEventArgs): HRESULT;
      function ScreenCaptureStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScreenCaptureStartingEventArgs): HRESULT;
      function FrameScreenCaptureStartingEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ScreenCaptureStartingEventArgs; aFrameID: cardinal): HRESULT;
      function FrameChildFrameCreatedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2FrameCreatedEventArgs; aFrameID: cardinal): HRESULT;

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
      procedure doOnWebResourceResponseViewGetContentCompletedEvent(errorCode: HResult; const result_: IStream; aResourceID : integer); virtual;
      procedure doOnGetCookiesCompletedEvent(errorCode: HResult; const result_: ICoreWebView2CookieList); virtual;
      procedure doOnTrySuspendCompletedEvent(errorCode: HResult; result_: Integer); virtual;
      procedure doOnFrameCreatedEvent(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs); virtual;
      procedure doOnDownloadStartingEvent(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs); virtual;
      procedure doOnClientCertificateRequestedEvent(const sender: ICoreWebView2; const args: ICoreWebView2ClientCertificateRequestedEventArgs); virtual;
      procedure doOnPrintToPdfCompletedEvent(errorCode: HResult; result_: Integer); virtual;
      procedure doOnBytesReceivedChangedEventEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer); virtual;
      procedure doOnEstimatedEndTimeChangedEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer); virtual;
      procedure doOnStateChangedEvent(const sender: ICoreWebView2DownloadOperation; const args: IUnknown; aDownloadID : integer); virtual;
      procedure doOnFrameNameChangedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal); virtual;
      procedure doOnFrameDestroyedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal); virtual;
      procedure doOnCallDevToolsProtocolMethodCompletedEvent(aErrorCode: HRESULT; const aResult: wvstring; aExecutionID : integer); virtual;
      procedure doOnAddScriptToExecuteOnDocumentCreatedCompletedEvent(aErrorCode: HRESULT; const aResult : wvstring); virtual;
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
      procedure doOnFrameNavigationStarting2(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationStartingEventArgs; aFrameID : cardinal); virtual;
      procedure doOnFrameNavigationCompleted2(const sender: ICoreWebView2Frame; const args: ICoreWebView2NavigationCompletedEventArgs; aFrameID : cardinal); virtual;
      procedure doOnFrameContentLoadingEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2ContentLoadingEventArgs; aFrameID: cardinal); virtual;
      procedure doOnFrameDOMContentLoadedEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2DOMContentLoadedEventArgs; aFrameID: cardinal); virtual;
      procedure doOnFrameWebMessageReceivedEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2WebMessageReceivedEventArgs; aFrameID: cardinal); virtual;
      procedure doOnBasicAuthenticationRequestedEvent(const sender: ICoreWebView2; const args: ICoreWebView2BasicAuthenticationRequestedEventArgs); virtual;
      procedure doOnContextMenuRequestedEvent(const sender: ICoreWebView2; const args: ICoreWebView2ContextMenuRequestedEventArgs); virtual;
      procedure doOnCustomItemSelectedEvent(const sender: ICoreWebView2ContextMenuItem; const args: IUnknown); virtual;
      procedure doOnStatusBarTextChangedEvent(const sender: ICoreWebView2; const args: IUnknown); virtual;
      procedure doOnFramePermissionRequestedEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2PermissionRequestedEventArgs2; aFrameID: cardinal); virtual;
      procedure doOnClearBrowsingDataCompletedEvent(aErrorCode: HRESULT); virtual;
      procedure doOnServerCertificateErrorActionsCompletedEvent(aErrorCode: HRESULT); virtual;
      procedure doOnServerCertificateErrorDetectedEvent(const sender: ICoreWebView2; const args: ICoreWebView2ServerCertificateErrorDetectedEventArgs); virtual;
      procedure doOnFaviconChangedEvent(const sender: ICoreWebView2; const args: IUnknown); virtual;
      procedure doOnGetFaviconCompletedEvent(errorCode: HResult; const result_: IStream); virtual;
      procedure doOnPrintCompletedEvent(errorCode: HResult; result_: COREWEBVIEW2_PRINT_STATUS); virtual;
      procedure doOnPrintToPdfStreamCompletedEvent(errorCode: HResult; const result_: IStream); virtual;
      procedure doOnGetCustomSchemes(var aSchemeRegistrations : TWVCustomSchemeRegistrationArray); virtual;
      procedure doOnGetNonDefaultPermissionSettingsCompleted(errorCode: HResult; const result_: ICoreWebView2PermissionSettingCollectionView); virtual;
      procedure doOnSetPermissionStateCompleted(errorCode: HResult); virtual;
      procedure doOnLaunchingExternalUriSchemeEvent(const sender: ICoreWebView2; const args: ICoreWebView2LaunchingExternalUriSchemeEventArgs); virtual;
      procedure doOnGetProcessExtendedInfosCompletedEvent(errorCode: HResult; const result_: ICoreWebView2ProcessExtendedInfoCollection); virtual;
      procedure doOnBrowserExtensionRemoveCompletedEvent(errorCode: HResult; const aExtensionID: wvstring); virtual;
      procedure doOnBrowserExtensionEnableCompletedEvent(errorCode: HResult; const aExtensionID: wvstring); virtual;
      procedure doOnProfileAddBrowserExtensionCompletedEvent(errorCode: HResult; const result_: ICoreWebView2BrowserExtension); virtual;
      procedure doOnProfileGetBrowserExtensionsCompletedEvent(errorCode: HResult; const result_: ICoreWebView2BrowserExtensionList); virtual;
      procedure doOnProfileDeletedEvent(const sender: ICoreWebView2Profile; const args: IUnknown); virtual;
      procedure doOnExecuteScriptWithResultCompletedEvent(errorCode: HResult; const result_: ICoreWebView2ExecuteScriptResult; aExecutionID : integer); virtual;
      procedure doOnNonClientRegionChangedEvent(const sender: ICoreWebView2CompositionController; const args: ICoreWebView2NonClientRegionChangedEventArgs); virtual;
      procedure doOnNotificationReceivedEvent(const sender: ICoreWebView2; const args: ICoreWebView2NotificationReceivedEventArgs); virtual;
      procedure doOnNotificationCloseRequestedEvent(const sender: ICoreWebView2Notification; const args: IUnknown); virtual;
      procedure doOnSaveAsUIShowingEvent(const sender: ICoreWebView2; const args: ICoreWebView2SaveAsUIShowingEventArgs); virtual;
      procedure doOnShowSaveAsUICompletedEvent(errorCode: HResult; result_: COREWEBVIEW2_SAVE_AS_UI_RESULT); virtual;
      procedure doOnSaveFileSecurityCheckStartingEvent(const sender: ICoreWebView2; const args: ICoreWebView2SaveFileSecurityCheckStartingEventArgs); virtual;
      procedure doOnScreenCaptureStartingEvent(const sender: ICoreWebView2; const args: ICoreWebView2ScreenCaptureStartingEventArgs); virtual;
      procedure doOnFrameScreenCaptureStartingEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2ScreenCaptureStartingEventArgs; aFrameID: cardinal); virtual;
      procedure doOnFrameChildFrameCreatedEvent(const sender: ICoreWebView2Frame; const args: ICoreWebView2FrameCreatedEventArgs; aFrameID: cardinal); virtual;

    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;
      /// <summary>
      /// Used to create the browser using the global environment by default.
      /// The browser will be fully initialized when the TWVBrowserBase.OnAfterCreated
      /// event is triggered.
      /// </summary>
      /// <param name="aHandle">The TWVWindowParent handle.</param>
      /// <param name="aUseDefaultEnvironment">Use the global environment or create a new one for this browser.</param>
      function    CreateBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean = True) : boolean; overload;
      /// <summary>
      /// Used to create the browser using a custom environment. The browser will be
      /// fully initialized when the TWVBrowserBase.OnAfterCreated event is triggered.
      /// </summary>
      /// <param name="aHandle">The TWVWindowParent handle.</param>
      /// <param name="aEnvironment">Custom environment to be used by this browser.</param>
      function    CreateBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean; overload;
      /// <summary>
      /// Used to create a windowless browser using the global environment by default.
      /// The browser will be fully initialized when the TWVBrowserBase.OnAfterCreated
      /// event is triggered.
      /// </summary>
      /// <param name="aHandle">The TWVDirectCompositionHost handle.</param>
      /// <param name="aUseDefaultEnvironment">Use the global environment or create a new one for this browser.</param>
      function    CreateWindowlessBrowser(aHandle : THandle; aUseDefaultEnvironment : boolean = True) : boolean; overload;
      /// <summary>
      /// Used to create a windowless browser using a custom environment. The browser will be
      /// fully initialized when the TWVBrowserBase.OnAfterCreated event is triggered.
      /// </summary>
      /// <param name="aHandle">The TWVDirectCompositionHost handle.</param>
      /// <param name="aEnvironment">Custom environment to be used by this browser.</param>
      function    CreateWindowlessBrowser(aHandle : THandle; const aEnvironment : ICoreWebView2Environment) : boolean; overload;
      /// <summary>
      /// Used to create an invisible browser using the global environment by default.
      /// You are not able to reparent the window after you have created the browser.
      /// The browser will be fully initialized when the TWVBrowserBase.OnAfterCreated
      /// event is triggered.
      /// </summary>
      /// <param name="aUseDefaultEnvironment">Use the global environment or create a new one for this browser.</param>
      function    CreateInvisibleBrowser(aUseDefaultEnvironment : boolean = True) : boolean; overload;
      /// <summary>
      /// Used to create an invisible browser using a custom environment.
      /// You are not able to reparent the window after you have created the browser.
      /// The browser will be fully initialized when the TWVBrowserBase.OnAfterCreated
      /// event is triggered.
      /// </summary>
      /// <param name="aEnvironment">Custom environment to be used by this browser.</param>
      function    CreateInvisibleBrowser(const aEnvironment : ICoreWebView2Environment) : boolean; overload;
      /// <summary>
      /// Navigates the WebView to the previous page in the navigation history.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#goback">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    GoBack : boolean;
      /// <summary>
      /// Navigates the WebView to the next page in the navigation history.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#goforward">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    GoForward : boolean;
      /// <summary>
      /// Reload the current page.  This is similar to navigating to the URI of
      /// current top level document including all navigation events firing and
      /// respecting any entries in the HTTP cache.  But, the back or forward
      /// history are not modified.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#reload">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    Refresh : boolean;
      /// <summary>
      /// <para>Reload the current page. Browser cache is ignored as if the user pressed Shift+refresh.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnRefreshIgnoreCacheCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Page/#method-reload">See the Page Domain article.</see></para>
      /// </remarks>
      function    RefreshIgnoreCache : boolean;
      /// <summary>
      /// Stop all navigations and pending resource fetches. Does not stop scripts.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#stop">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    Stop : boolean;
      /// <summary>
      /// Cause a navigation of the top-level document to run to the specified URI.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#navigate">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    Navigate(const aURI : wvstring) : boolean;
      /// <summary>
      /// Initiates a navigation to aHTMLContent as source HTML of a new document.
      /// The origin of the new page is `about:blank`.
      /// </summary>
      /// <param name="aHTMLContent">Source HTML. It may not be larger than 2 MB (2 * 1024 * 1024 bytes) in total size.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#navigatetostring">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    NavigateToString(const aHTMLContent: wvstring) : boolean;
      /// <summary>
      /// Navigates using a constructed ICoreWebView2WebResourceRequest object. This lets you
      /// provide post data or additional request headers during navigation.
      /// The headers in aRequest override headers added by WebView2 runtime except for Cookie headers.
      /// Method can only be either "GET" or "POST". Provided post data will only
      /// be sent only if the method is "POST" and the uri scheme is HTTP(S).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2#navigatewithwebresourcerequest">See the ICoreWebView2_2 article.</see></para>
      /// </remarks>
      function    NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;
      /// <summary>
      /// Subscribe to a DevTools protocol event. The TWVBrowserBase.OnDevToolsProtocolEventReceived
      /// event will be triggered on each DevTools event.
      /// </summary>
      /// <param name="aEventName">The DevTools protocol event name.</param>
      /// <param name="aEventID">A custom event ID that will be passed as a parameter in the TWVBrowserBase event.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceiver#add_devtoolsprotocoleventreceived">See the ICoreWebView2DevToolsProtocolEventReceiver article.</see></para>
      /// </remarks>
      function    SubscribeToDevToolsProtocolEvent(const aEventName : wvstring; aEventID : integer = 0) : boolean;
      /// <summary>
      /// <para>Runs an asynchronous `DevToolsProtocol` method.</para>
      /// <para>The TWVBrowserBase.OnCallDevToolsProtocolMethodCompleted event is triggered
      /// when it finishes executing. This function returns E_INVALIDARG if the `aMethodName` is
      /// unknown or the `aParametersAsJson` has an error.  In the case of such an error, the
      /// `aReturnObjectAsJson` parameter of the event will include information
      /// about the error.</para>
      /// <para>Note even though WebView2 dispatches the CDP messages in the order called,
      /// CDP method calls may be processed out of order.
      /// If you require CDP methods to run in a particular order, you should wait
      /// for the previous method is finished before calling the next method.</para>
      /// <para>If the method is to run in add_NewWindowRequested handler it should be called
      /// before the new window is set if the cdp message should affect the initial navigation. If
      /// called after setting the NewWindow property, the cdp messages
      /// may or may not apply to the initial navigation and may only apply to the subsequent navigation.
      /// For more details see `ICoreWebView2NewWindowRequestedEventArgs::put_NewWindow`.</para>
      /// </summary>
      /// <param name="aMethodName">The DevTools protocol full method name.</param>
      /// <param name="aParametersAsJson">JSON formatted string containing the parameters for the corresponding method.</param>
      /// <param name="aExecutionID">A custom event ID that will be passed as a parameter in the TWVBrowserBase event.</param>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot">See the Chrome DevTools Protocol web page.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#calldevtoolsprotocolmethod">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer = 0) : boolean;
      /// <summary>
      /// <para>Runs an asynchronous `DevToolsProtocol` method for a specific session of
      /// an attached target.</para>
      /// <para>There could be multiple `DevToolsProtocol` targets in a WebView.
      /// Besides the top level page, iframes from different origin and web workers
      /// are also separate targets. Attaching to these targets allows interaction with them.
      /// When the DevToolsProtocol is attached to a target, the connection is identified
      /// by a sessionId.</para>
      /// <para>To use this API, you must set the `flatten` parameter to true when calling
      /// `Target.attachToTarget` or `Target.setAutoAttach` `DevToolsProtocol` method.
      /// Using `Target.setAutoAttach` is recommended as that would allow you to attach
      /// to dedicated worker targets, which are not discoverable via other APIs like
      /// `Target.getTargets`.</para>
      /// <para>The TWVBrowserBase.OnCallDevToolsProtocolMethodCompleted event is triggered
      /// when it finishes executing. This function returns E_INVALIDARG if the `aMethodName` is
      /// unknown or the `aParametersAsJson` has an error.  In the case of such an error, the
      /// `aReturnObjectAsJson` parameter of the event will include information
      /// about the error.</para>
      /// <para>Note even though WebView2 dispatches the CDP messages in the order called,
      /// CDP method calls may be processed out of order.
      /// If you require CDP methods to run in a particular order, you should wait
      /// for the previous method is finished before calling the next method.</para>
      /// </summary>
      /// <param name="aSessionId">The sessionId for an attached target. An empty string is treated as the session for the default target for the top page.</param>
      /// <param name="aMethodName">The DevTools protocol full method name.</param>
      /// <param name="aParametersAsJson">JSON formatted string containing the parameters for the corresponding method.</param>
      /// <param name="aExecutionID">A custom event ID that will be passed as a parameter in the TWVBrowserBase event.</param>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot">See the Chrome DevTools Protocol web page.</see></para>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Target">Information about targets and sessions.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_11#calldevtoolsprotocolmethodforsession">See the ICoreWebView2_11 article.</see></para>
      /// </remarks>
      function    CallDevToolsProtocolMethodForSession(const aSessionId, aMethodName, aParametersAsJson : wvstring; aExecutionID : integer = 0) : boolean;
      /// <summary>
      /// Moves focus into WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#movefocus">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      function    SetFocus : boolean;
      /// <summary>
      /// Moves the focus to the next element.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#movefocus">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      function    FocusNext : boolean;
      /// <summary>
      /// Moves the focus to the previous element.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#movefocus">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      function    FocusPrevious : boolean;
      /// <summary>
      /// <para>Run JavaScript code from the JavaScript parameter in the current
      /// top-level document rendered in the WebView.</para>
      /// <para>The TWVBrowserBase.OnExecuteScriptWithResultCompleted event is triggered
      /// when it finishes executing.</para>
      /// <para>The result of the execution is returned asynchronously in the ICoreWebView2ExecuteScriptResult object
      /// which has methods and properties to obtain the successful result of script execution as well as any
      /// unhandled JavaScript exceptions.</para>
      /// <para>If this method is run after the NavigationStarting event during a navigation, the script
      /// runs in the new document when loading it, around the time
      /// ContentLoading is run. This operation executes the script even if
      /// ICoreWebView2Settings.IsScriptEnabled is set to FALSE.</para>
      /// </summary>
      /// <param name="aJavaScript">The JavaScript code.</param>
      /// <param name="aExecutionID">A custom event ID that will be passed as a parameter in the TWVBrowserBase event.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_21#executescriptwithresult">See the icorewebview2_21 article.</see></para>
      /// </remarks>
      function ExecuteScriptWithResult(const aJavaScript: wvstring; aExecutionID : integer = 0): boolean;
      /// <summary>
      /// <para>Run JavaScript code from the aJavaScript parameter in the current
      /// top-level document rendered in the WebView.</para>
      /// <para>The TWVBrowserBase.OnExecuteScriptCompleted event is triggered
      /// when it finishes executing.</para>
      /// <para>The result of evaluating the provided JavaScript is available in the
      /// aResultObjectAsJson parameter of the TWVBrowserBase.OnExecuteScriptCompleted
      /// event as a JSON encoded string.  If the result is undefined, contains a reference
      /// cycle, or otherwise is not able to be encoded into JSON, then the result
      /// is considered to be null, which is encoded in JSON as the string "null".
      /// If the script that was run throws an unhandled exception, then the result is
      /// also "null".</para>
      /// <para>If the method is run after the `NavigationStarting` event during a navigation,
      /// the script runs in the new document when loading it, around the time
      /// `ContentLoading` is run.  This operation executes the script even if
      /// `ICoreWebView2Settings.IsScriptEnabled` is set to `FALSE`.</para>
      /// </summary>
      /// <param name="aJavaScript">The JavaScript code.</param>
      /// <param name="aExecutionID">A custom event ID that will be passed as a parameter in the TWVBrowserBase event.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#executescript">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    ExecuteScript(const aJavaScript : wvstring; aExecutionID : integer = 0) : boolean;
      /// <summary>
      /// <para>Capture an image of what WebView is displaying.  Specify the format of
      /// the image with the aImageFormat parameter.  The resulting image binary
      /// data is written to the provided aImageStream parameter. This method fails if called
      /// before the first ContentLoading event.  For example if this is called in
      /// the NavigationStarting event for the first navigation it will fail.</para>
      /// <para>For subsequent navigations, the method may not fail, but will not capture
      /// an image of a given webpage until the ContentLoading event has been fired
      /// for it.  Any call to this method prior to that will result in a capture of
      /// the page being navigated away from. When this function finishes writing to the stream,
      /// the TWVBrowserBase.OnCapturePreviewCompleted event is triggered.</para>
      /// </summary>
      /// <param name="aImageFormat">The format of the image.</param>
      /// <param name="aImageStream">The resulting image binary data is written to this stream.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#capturepreview">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream) : boolean;
      /// <summary>
      /// This is a notification that tells WebView that the main WebView parent
      /// (or any ancestor) `HWND` moved.  This is needed for accessibility and
      /// certain dialogs in WebView to work correctly.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#notifyparentwindowpositionchanged">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      function    NotifyParentWindowPositionChanged : boolean;
      /// <summary>
      /// <para>Sets permission state for the given permission kind and origin
      /// asynchronously. The change persists across sessions until it is changed by
      /// another call to `SetPermissionState`, or by setting the `State` property
      /// in `PermissionRequestedEventArgs`.</para>
      /// <para>Setting the state to `COREWEBVIEW2_PERMISSION_STATE_DEFAULT` will
      /// erase any state saved in the profile and restore the default behavior.</para>
      /// <para>The origin should have a valid scheme and host (e.g. "https://www.example.com"),
      /// otherwise the method fails with `E_INVALIDARG`. Additional URI parts like
      /// path and fragment are ignored. For example, "https://wwww.example.com/app1/index.html/"
      /// is treated the same as "https://wwww.example.com".</para>
      /// <para>This function triggers the TWVBrowserBase.OnSetPermissionStateCompleted event.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://developer.mozilla.org/en-US/docs/Glossary/Origin">See the MDN origin definition.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile4#setpermissionstate">See the ICoreWebView2Profile4 article.</see></para>
      /// </remarks>
      function    SetPermissionState(aPermissionKind: TWVPermissionKind; const aOrigin: wvstring; aState: TWVPermissionState) : boolean;
      /// <summary>
      /// <para>Invokes the handler with a collection of all nondefault permission settings.
      /// Use this method to get the permission state set in the current and previous
      /// sessions.</para>
      /// <para>This function triggers the TWVBrowserBase.OnGetNonDefaultPermissionSettingsCompleted event.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile4#getnondefaultpermissionsettings">See the ICoreWebView2Profile4 article.</see></para>
      /// </remarks>
      function    GetNonDefaultPermissionSettings: boolean;
      /// <summary>
      /// <para>Adds the [browser extension](https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions)
      /// using the extension path for unpacked extensions from the local device. Extension is
      /// running right after installation.</para>
      /// <para>The extension folder path is the topmost folder of an unpacked browser extension and
      /// contains the browser extension manifest file.</para>
      /// <para>If the `extensionFolderPath` is an invalid path or doesn't contain the extension manifest.json
      /// file, this function will return `ERROR_FILE_NOT_FOUND` to callers.</para>
      /// <para>Installed extension will default `IsEnabled` to true.</para>
      /// <para>When `AreBrowserExtensionsEnabled` is `FALSE`, `AddBrowserExtension` will fail and return
      /// HRESULT `ERROR_NOT_SUPPORTED`.</para>
      /// <para>During installation, the content of the extension is not copied to the user data folder.
      /// Once the extension is installed, changing the content of the extension will cause the
      /// extension to be removed from the installed profile.</para>
      /// <para>When an extension is added the extension is persisted in the corresponding profile. The
      /// extension will still be installed the next time you use this profile.</para>
      /// <para>When an extension is installed from a folder path, adding the same extension from the same
      /// folder path means reinstalling this extension. When two extensions with the same Id are
      /// installed, only the later installed extension will be kept.</para>
      /// <para>Extensions that are designed to include any UI interactions (e.g. icon, badge, pop up, etc.)
      /// can be loaded and used but will have missing UI entry points due to the lack of browser
      /// UI elements to host these entry points in WebView2.</para>
      /// <para>The following summarizes the possible error values that can be returned from
      /// `AddBrowserExtension` and a description of why these errors occur.</para>
      /// <code>
      /// Error value                                     | Description
      /// ----------------------------------------------- | --------------------------
      /// `HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)`       | Extensions are disabled.
      /// `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)`      | Cannot find `manifest.json` file or it is not a valid extension manifest.
      /// `E_ACCESSDENIED`                                | Cannot load extension with file or directory name starting with \"_\", reserved for use by the system.
      /// `E_FAIL`                                        | Extension failed to install with other unknown reasons.
      /// </code>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile7#addbrowserextension">See the ICoreWebView2Profile7 article.</see></para>
      /// <para>The TWVBrowserBase.OnProfileAddBrowserExtensionCompleted event is triggered when TWVBrowserBase.AddBrowserExtension finishes executing.</para>
      /// </remarks>
      function    AddBrowserExtension(const extensionFolderPath: wvstring): boolean;
      /// <summary>
      /// <para>Gets a snapshot of the set of extensions installed at the time `GetBrowserExtensions` is
      /// called. If an extension is installed or uninstalled after `GetBrowserExtensions` completes,
      /// the list returned by `GetBrowserExtensions` remains the same.</para>
      /// <para>When `AreBrowserExtensionsEnabled` is `FALSE`, `GetBrowserExtensions` won't return any
      /// extensions on current user profile.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile7#getbrowserextensions">See the ICoreWebView2Profile7 article.</see></para>
      /// <para>The TWVBrowserBase.OnProfileGetBrowserExtensionsCompleted event is triggered when TWVBrowserBase.GetBrowserExtensions finishes executing.</para>
      /// </remarks>
      function    GetBrowserExtensions: boolean;
      /// <summary>
      /// <para>After the API is called, the profile will be marked for deletion. The
      /// local profile's directory will be deleted at browser process exit. If it
      /// fails to delete, because something else is holding the files open,
      /// WebView2 will try to delete the profile at all future browser process
      /// starts until successful.</para>
      /// <para>The corresponding CoreWebView2s will be closed and the
      /// CoreWebView2Profile.Deleted event will be raised. See
      /// `CoreWebView2Profile.Deleted` for more information.</para>
      /// <para>If you try to create a new profile with the same name as an existing
      /// profile that has been marked as deleted but hasn't yet been deleted,
      /// profile creation will fail with HRESULT_FROM_WIN32(ERROR_DELETE_PENDING).</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile8#delete">See the ICoreWebView2Profile8 article.</see></para>
      /// </remarks>
      function    DeleteProfile: boolean;
      /// <summary>
      /// <para>An app may call the `TrySuspend` API to have the WebView2 consume less memory.
      /// This is useful when a Win32 app becomes invisible, or when a Universal Windows
      /// Platform app is being suspended, during the suspended event handler before completing
      /// the suspended event.</para>
      /// <para>The IsVisible property must be false when the API is called.
      /// Otherwise, the API fails with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
      /// Suspending is similar to putting a tab to sleep in the Edge browser. Suspending pauses
      /// WebView script timers and animations, minimizes CPU usage for the associated
      /// browser renderer process and allows the operating system to reuse the memory that was
      /// used by the renderer process for other processes.</para>
      /// <para>Note that Suspend is best effort and considered completed successfully once the request
      /// is sent to browser renderer process. If there is a running script, the script will continue
      /// to run and the renderer process will be suspended after that script is done.
      /// for conditions that might prevent WebView from being suspended. In those situations,
      /// the completed handler will be invoked with isSuccessful as false and errorCode as S_OK.
      /// The WebView will be automatically resumed when it becomes visible. Therefore, the
      /// app normally does not have to call `Resume` explicitly.</para>
      /// <para>The app can call `Resume` and then `TrySuspend` periodically for an invisible WebView so that
      /// the invisible WebView can sync up with latest data and the page ready to show fresh content
      /// when it becomes visible.</para>
      /// <para>All WebView APIs can still be accessed when a WebView is suspended. Some APIs like Navigate
      /// will auto resume the WebView. To avoid unexpected auto resume, check `IsSuspended` property
      /// before calling APIs that might change WebView state.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnTrySuspendCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://techcommunity.microsoft.com/t5/articles/sleeping-tabs-faq/m-p/1705434">See the sleeping Tabs FAQ.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3#trysuspend">See the ICoreWebView2_3 article.</see></para>
      /// </remarks>
      function    TrySuspend : boolean;
      /// <summary>
      /// Resumes the WebView so that it resumes activities on the web page.
      /// This API can be called while the WebView2 controller is invisible.
      /// The app can interact with the WebView immediately after `Resume`.
      /// WebView will be automatically resumed when it becomes visible.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3#resume">See the ICoreWebView2_3 article.</see></para>
      /// </remarks>
      function    Resume : boolean;
      /// <summary>
      /// <para>Sets a mapping between a virtual host name and a folder path to make available to web sites
      /// via that host name.</para>
      /// <para>After setting the mapping, documents loaded in the WebView can use HTTP or HTTPS URLs at
      /// the specified host name specified by hostName to access files in the local folder specified
      /// by folderPath.</para>
      /// </summary>
      /// <param name="aHostName">Host name to access files in the local folder specified by aFolderPath.</param>
      /// <param name="aFolderPath">The path to the local files. Both absolute and relative paths are supported. Relative paths are interpreted as relative to the folder where the exe of the app is in. Note that the aFolderPath length must not exceed the Windows MAX_PATH limit.</param>
      /// <param name="aAccessKind">aAccessKind specifies the level of access to resources under the virtual host from other sites.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3#setvirtualhostnametofoldermapping">See the ICoreWebView2_3 article.</see></para>
      /// </remarks>
      function    SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
      /// <summary>
      /// Clears a host name mapping for local folder that was added by `SetVirtualHostNameToFolderMapping`.
      /// </summary>
      /// <param name="aHostName">Host name used previously with SetVirtualHostNameToFolderMapping to access files in the local folder.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3#clearvirtualhostnametofoldermapping">See the ICoreWebView2_3 article.</see></para>
      /// </remarks>
      function    ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;
      /// <summary>
      /// Retrieve the HTML contents. The TWVBrowserBase.OnRetrieveHTMLCompleted event is triggered asynchronously with the HTML contents.
      /// </summary>
      function    RetrieveHTML : boolean;
      /// <summary>
      /// Retrieve the text contents. The TWVBrowserBase.OnRetrieveTextCompleted event is triggered asynchronously with the text contents.
      /// </summary>
      /// <param name="aVisibleTextOnly">Exclude text that is hidden with CSS or rendered as invisible due to its parent's visibility settings.</param>
      function    RetrieveText(aVisibleTextOnly: boolean = False) : boolean;
      /// <summary>
      /// Retrieve the web page contents in MHTML format. The TWVBrowserBase.OnRetrieveMHTMLCompleted event is triggered asynchronously with the MHTML contents.
      /// </summary>
      function    RetrieveMHTML : boolean;
      /// <summary>
      /// <para>Print the current web page asynchronously to the specified printer with the TWVBrowserBase.CoreWebView2PrintSettings settings.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnPrintCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16#print">See the ICoreWebView2_16 article.</see></para>
      /// </remarks>
      function    Print : boolean;
      /// <summary>
      /// Opens the print dialog to print the current web page using the system print dialog or the browser print preview dialog.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16#showprintui">See the ICoreWebView2_16 article.</see></para>
      /// </remarks>
      function    ShowPrintUI(aUseSystemPrintDialog : boolean = False): boolean;
      /// <summary>
      /// Print the current page to PDF asynchronously with the TWVBrowserBase.CoreWebView2PrintSettings settings.
      /// This function is asynchronous and it triggers the TWVBrowserBase.OnPrintToPdfCompleted event when it finishes executing.
      /// </summary>
      /// <param name="aResultFilePath">The path to the PDF file.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_7#printtopdf">See the ICoreWebView2_7 article.</see></para>
      /// </remarks>
      function    PrintToPdf(const aResultFilePath : wvstring) : boolean;
      /// <summary>
      /// Provides the Pdf data of current web page asynchronously for the TWVBrowserBase.CoreWebView2PrintSettings settings.
      /// Stream will be rewound to the start of the pdf data.
      /// This function is asynchronous and it triggers the TWVBrowserBase.OnPrintToPdfStreamCompleted event.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16#printtopdfstream">See the ICoreWebView2_16 article.</see></para>
      /// </remarks>
      function    PrintToPdfStream : boolean;
      /// <summary>
      /// Opens the DevTools window for the current document in the WebView. Does
      /// nothing if run when the DevTools window is already open.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#opendevtoolswindow">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    OpenDevToolsWindow : boolean;
      /// <summary>
      /// Opens the Browser Task Manager view as a new window in the foreground.
      /// If the Browser Task Manager is already open, this will bring it into
      /// the foreground. WebView2 currently blocks the Shift+Esc shortcut for
      /// opening the task manager. An end user can open the browser task manager
      /// manually via the `Browser task manager` entry of the DevTools window's
      /// title bar's context menu.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_6#opentaskmanagerwindow">See the ICoreWebView2_6 article.</see></para>
      /// </remarks>
      function    OpenTaskManagerWindow : boolean;
      /// <summary>
      /// <para>Post the specified webMessage to the top level document in this WebView.
      /// The main page receives the message by subscribing to the `message` event of the
      /// `window.chrome.webview` of the page document.</para>
      /// <code>
      /// ```cpp
      /// window.chrome.webview.addEventListener('message', handler)
      /// window.chrome.webview.removeEventListener('message', handler)
      /// ```
      /// </code>
      /// <para>The event args is an instance of `MessageEvent`.  The
      /// `ICoreWebView2Settings.IsWebMessageEnabled` setting must be `TRUE` or
      /// the web message will not be sent. The `data` property of the event
      /// arg is the `webMessage` string parameter parsed as a JSON string into a
      /// JavaScript object.  The `source` property of the event arg is a reference
      ///  to the `window.chrome.webview` object.  For information about sending
      /// messages from the HTML document in the WebView to the host, navigate to
      /// [add_WebMessageReceived](/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived).
      /// The message is delivered asynchronously.  If a navigation occurs before
      /// the message is posted to the page, the message is discarded.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#postwebmessageasjson">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
      /// <summary>
      /// Posts a message that is a simple string rather than a JSON string
      /// representation of a JavaScript object.  This behaves in exactly the same
      /// manner as `PostWebMessageAsJson`, but the `data` property of the event
      /// arg of the `window.chrome.webview` message is a string with the same
      /// value as `aWebMessageAsString`.  Use this instead of
      /// `PostWebMessageAsJson` if you want to communicate using simple strings
      /// rather than JSON objects.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#postwebmessageasstring">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
      /// <summary>
      /// <para>Warning: This method is deprecated and does not behave as expected for
      /// iframes. It will cause the WebResourceRequested event to fire only for the
      /// main frame and its same-origin iframes. Please use
      /// `AddWebResourceRequestedFilterWithRequestSourceKinds`
      /// instead, which will let the event to fire for all iframes on the
      /// document.</para>
      /// <para>Adds a URI and resource context filter for the `WebResourceRequested`
      /// event.  A web resource request with a resource context that matches this
      /// filter's resource context and a URI that matches this filter's URI
      /// wildcard string will be raised via the `WebResourceRequested` event.</para>
      /// <para>The `aURI` parameter value is a wildcard string matched against the URI
      /// of the web resource request. This is a glob style
      /// wildcard string in which a `*` matches zero or more characters and a `?`
      /// matches exactly one character.</para>
      /// <para>These wildcard characters can be escaped using a backslash just before
      /// the wildcard character in order to represent the literal `*` or `?`.</para>
      /// <para>The matching occurs over the URI as a whole string and not limiting
      /// wildcard matches to particular parts of the URI.</para>
      /// <para>The wildcard filter is compared to the URI after the URI has been
      /// normalized, any URI fragment has been removed, and non-ASCII hostnames
      /// have been converted to punycode.</para>
      /// <para>Specifying an empty string for aURI matches no URIs.</para>
      /// <para>For more information about resource context filters, navigate to
      /// [COREWEBVIEW2_WEB_RESOURCE_CONTEXT](/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_web_resource_context).</para>
      /// <code>
      /// | URI Filter String | Request URI | Match | Notes |
      /// | ---- | ---- | ---- | ---- |
      /// | `*` | `https://contoso.com/a/b/c` | Yes | A single * will match all URIs |
      /// | `*://contoso.com/*` | `https://contoso.com/a/b/c` | Yes | Matches everything in contoso.com across all schemes |
      /// | `*://contoso.com/*` | `https://example.com/?https://contoso.com/` | Yes | But also matches a URI with just the same text anywhere in the URI |
      /// | `example` | `https://contoso.com/example` | No | The filter does not perform partial matches |
      /// | `*example` | `https://contoso.com/example` | Yes | The filter matches across URI parts  |
      /// | `*example` | `https://contoso.com/path/?example` | Yes | The filter matches across URI parts |
      /// | `*example` | `https://contoso.com/path/?query#example` | No | The filter is matched against the URI with no fragment |
      /// | `*example` | `https://example` | No | The URI is normalized before filter matching so the actual URI used for comparison is `https://example/` |
      /// | `*example/` | `https://example` | Yes | Just like above, but this time the filter ends with a / just like the normalized URI |
      /// | `https://xn--qei.example/` | `https://&#x2764;.example/` | Yes | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      /// | `https://&#x2764;.example/` | `https://xn--qei.example/` | No | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      /// </code>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#addwebresourcerequestedfilter">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    AddWebResourceRequestedFilter(const aURI: wvstring; aResourceContext: TWVWebResourceContext) : boolean;
      /// <para>Warning: This method and `AddWebResourceRequestedFilter` are deprecated.
      /// Please use `AddWebResourceRequestedFilterWithRequestSourceKinds` and
      /// `RemoveWebResourceRequestedFilterWithRequestSourceKinds` instead.</para>
      /// <para>Removes a matching WebResource filter that was previously added for the
      /// `WebResourceRequested` event.  If the same filter was added multiple
      /// times, then it must be removed as many times as it was added for the
      /// removal to be effective.  Returns `E_INVALIDARG` for a filter that was
      /// never added.</para>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#removewebresourcerequestedfilter">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    RemoveWebResourceRequestedFilter(const aURI: wvstring; aResourceContext: TWVWebResourceContext) : boolean;
      /// <summary>
      /// <para>A web resource request with a resource context that matches this
      /// filter's resource context and a URI that matches this filter's URI
      /// wildcard string for corresponding request sources will be raised via
      /// the `WebResourceRequested` event. To receive all raised events filters
      /// have to be added before main page navigation.</para>
      /// <para>The `uri` parameter value is a wildcard string matched against the URI
      /// of the web resource request. This is a glob style
      /// wildcard string in which a `*` matches zero or more characters and a `?`
      /// matches exactly one character.</para>
      /// <para>These wildcard characters can be escaped using a backslash just before
      /// the wildcard character in order to represent the literal `*` or `?`.</para>
      /// <para>The matching occurs over the URI as a whole string and not limiting
      /// wildcard matches to particular parts of the URI.</para>
      /// <para>The wildcard filter is compared to the URI after the URI has been
      /// normalized, any URI fragment has been removed, and non-ASCII hostnames
      /// have been converted to punycode.</para>
      /// <para>Specifying a `nullptr` for the uri is equivalent to an empty string which
      /// matches no URIs.</para>
      /// <para>For more information about resource context filters, navigate to
      /// [COREWEBVIEW2_WEB_RESOURCE_CONTEXT](/microsoft-edge/webview2/reference/win32/icorewebview2#corewebview2_web_resource_context).</para>
      /// <para>The `requestSourceKinds` is a mask of one or more
      /// `COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS`. OR operation(s) can be
      /// applied to multiple `COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS` to
      /// create a mask representing those data types. API returns `E_INVALIDARG` if
      /// `requestSourceKinds` equals to zero. For more information about request
      /// source kinds, navigate to
      /// [COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS](/microsoft-edge/webview2/reference/win32/icorewebview2#corewebview2_web_resource_request_source_kinds).</para>
      /// <para>Because service workers and shared workers run separately from any one
      /// HTML document their WebResourceRequested will be raised for all
      /// CoreWebView2s that have appropriate filters added in the corresponding
      /// CoreWebView2Environment. You should only add a WebResourceRequested filter
      /// for COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SERVICE_WORKER or
      /// COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SHARED_WORKER on
      /// one CoreWebView2 to avoid handling the same WebResourceRequested
      /// event multiple times.</para>
      /// <code>
      /// | URI Filter String | Request URI | Match | Notes |
      /// | ---- | ---- | ---- | ---- |
      /// | `*` | `https://contoso.com/a/b/c` | Yes | A single * will match all URIs |
      /// | `*://contoso.com/*` | `https://contoso.com/a/b/c` | Yes | Matches everything in contoso.com across all schemes |
      /// | `*://contoso.com/*` | `https://example.com/?https://contoso.com/` | Yes | But also matches a URI with just the same text anywhere in the URI |
      /// | `example` | `https://contoso.com/example` | No | The filter does not perform partial matches |
      /// | `*example` | `https://contoso.com/example` | Yes | The filter matches across URI parts |
      /// | `*example` | `https://contoso.com/path/?example` | Yes | The filter matches across URI parts |
      /// | `*example` | `https://contoso.com/path/?query#example` | No | The filter is matched against the URI with no fragment |
      /// | `*example` | `https://example` | No | The URI is normalized before filter matching so the actual URI used for comparison is `https://example/` |
      /// | `*example/` | `https://example` | Yes | Just like above, but this time the filter ends with a / just like the normalized URI |
      /// | `https://xn--qei.example/` | `https://&#x2764;.example/` | Yes | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      /// | `https://&#x2764;.example/` | `https://xn--qei.example/` | No | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      /// </code>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_22#addwebresourcerequestedfilterwithrequestsourcekinds">See the ICoreWebView2_22 article.</see></para>
      /// </remarks>
      function AddWebResourceRequestedFilterWithRequestSourceKinds(const uri: wvstring;
                                                                   ResourceContext: TWVWebResourceContext;
                                                                   requestSourceKinds: TWVWebResourceRequestSourceKind): boolean;
      /// <summary>
      /// <para>Removes a matching WebResource filter that was previously added for the
      /// `WebResourceRequested` event.  If the same filter was added multiple
      /// times, then it must be removed as many times as it was added for the
      /// removal to be effective. Returns `E_INVALIDARG` for a filter that was
      /// not added or is already removed.</para>
      /// <para>If the filter was added for multiple requestSourceKinds and removed just for one of them
      /// the filter remains for the non-removed requestSourceKinds.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_22#removewebresourcerequestedfilterwithrequestsourcekinds">See the ICoreWebView2_22 article.</see></para>
      /// </remarks>
      function RemoveWebResourceRequestedFilterWithRequestSourceKinds(const uri: wvstring;
                                                                      ResourceContext: TWVWebResourceContext;
                                                                      requestSourceKinds: TWVWebResourceRequestSourceKind): boolean;
      /// <summary>
      /// <para>Same as `PostWebMessageAsJson`, but also has support for posting DOM objects
      /// to page content. The `additionalObjects` property in the DOM MessageEvent
      /// fired on the page content is an array-like list of DOM objects that can
      /// be posted to the web content. Currently these can be the following
      /// types of objects:</para>
      /// <code>
      /// | Win32             | DOM type    |
      /// |-------------------|-------------|
      /// | ICoreWebView2FileSystemHandle | [FileSystemHandle](https://developer.mozilla.org/docs/Web/API/FileSystemHandle) |
      /// | nullptr           | null        |
      /// </code>
      /// <para>The objects are posted to the web content, following the
      /// [structured-clone](https://developer.mozilla.org/docs/Web/API/Web_Workers_API/Structured_clone_algorithm)
      /// semantics, meaning only objects that can be cloned can be posted.</para>
      /// <para>They will also behave as if they had been created by the web content they are
      /// posted to. For example, if a FileSystemFileHandle is posted to a web content
      /// it can only be re-transferred via postMessage to other web content
      /// [with the same origin](https://fs.spec.whatwg.org/#filesystemhandle).</para>
      /// <para>Warning: An app needs to be mindful when using this API to post DOM objects
      /// as this API provides the web content with unusual access to sensitive Web
      /// Platform features such as filesystem access! Similar to PostWebMessageAsJson
      /// the app should check the `Source` property of WebView2 right before posting the message
      /// to ensure the message and objects will only be sent to the target web content
      /// that it expects to receive the DOM objects. Additionally, the order
      /// of messages that are posted between `PostWebMessageAsJson` and `PostWebMessageAsJsonWithAdditionalObjects`
      /// may not be preserved.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_23#postwebmessageasjsonwithadditionalobjects">See the ICoreWebView2_23 article.</see></para>
      /// </remarks>
      function PostWebMessageAsJsonWithAdditionalObjects(const webMessageAsJson: wvstring;
                                                         const additionalObjects: ICoreWebView2ObjectCollectionView): boolean;
      /// <summary>
      /// <para>Add the provided host object to script running in the WebView with the
      /// specified name.  Host objects are exposed as host object proxies using
      /// `window.chrome.webview.hostObjects.{name}`.  Host object proxies are
      /// promises and resolves to an object representing the host object.  The
      /// promise is rejected if the app has not added an object with the name.</para>
      /// <para>When JavaScript code access a property or method of the object, a promise
      ///  is return, which resolves to the value returned from the host for the
      /// property or method, or rejected in case of error, for example, no
      /// property or method on the object or parameters are not valid.</para>
      ///
      /// <para>NOTE: While simple types, `IDispatch` and array are supported, and
      /// `IUnknown` objects that also implement `IDispatch` are treated as `IDispatch`,
      /// generic `IUnknown`, `VT_DECIMAL`, or `VT_RECORD` variant is not supported.
      /// Remote JavaScript objects like callback functions are represented as an
      /// `VT_DISPATCH` `VARIANT` with the object implementing `IDispatch`.  The
      /// JavaScript callback method may be invoked using `DISPID_VALUE` for the
      /// `DISPID`.  Such callback method invocations will return immediately and will
      /// not wait for the JavaScript function to run and so will not provide the return
      /// value of the JavaScript function.</para>
      /// <para>Nested arrays are supported up to a depth of 3.  Arrays of by
      /// reference types are not supported. `VT_EMPTY` and `VT_NULL` are mapped
      /// into JavaScript as `null`.  In JavaScript, `null` and undefined are
      /// mapped to `VT_EMPTY`.</para>
      ///
      /// <para>Additionally, all host objects are exposed as
      /// `window.chrome.webview.hostObjects.sync.{name}`.  Here the host objects
      /// are exposed as synchronous host object proxies. These are not promises
      /// and function runtimes or property access synchronously block running
      /// script waiting to communicate cross process for the host code to run.
      /// Accordingly the result may have reliability issues and it is recommended
      /// that you use the promise-based asynchronous
      /// `window.chrome.webview.hostObjects.{name}` API.</para>
      ///
      /// <para>Synchronous host object proxies and asynchronous host object proxies may
      /// both use a proxy to the same host object.  Remote changes made by one
      /// proxy propagates to any other proxy of that same host object whether
      /// the other proxies and synchronous or asynchronous.</para>
      ///
      /// <para>While JavaScript is blocked on a synchronous run to native code, that
      /// native code is unable to run back to JavaScript.  Attempts to do so fail
      ///  with `HRESULT_FROM_WIN32(ERROR_POSSIBLE_DEADLOCK)`.</para>
      ///
      /// <para>Host object proxies are JavaScript Proxy objects that intercept all
      /// property get, property set, and method invocations. Properties or methods
      ///  that are a part of the Function or Object prototype are run locally.
      /// Additionally any property or method in the
      /// `chrome.webview.hostObjects.options.forceLocalProperties`
      /// array are also run locally.  This defaults to including optional methods
      /// that have meaning in JavaScript like `toJSON` and `Symbol.toPrimitive`.
      /// Add more to the array as required.</para>
      ///
      /// <para>The `chrome.webview.hostObjects.cleanupSome` method performs a best
      /// effort garbage collection on host object proxies.</para>
      ///
      /// <para>The `chrome.webview.hostObjects.options` object provides the ability to
      /// change some functionality of host objects.</para>
      /// <code>
      /// Options property | Details
      /// ---|---
      /// `forceLocalProperties` | This is an array of host object property names that will be run locally, instead of being called on the native host object. This defaults to `then`, `toJSON`, `Symbol.toString`, and `Symbol.toPrimitive`. You can add other properties to specify that they should be run locally on the javascript host object proxy.
      /// `log` | This is a callback that will be called with debug information. For example, you can set this to `console.log.bind(console)` to have it print debug information to the console to help when troubleshooting host object usage. By default this is null.
      /// `shouldSerializeDates` | By default this is false, and javascript Date objects will be sent to host objects as a string using `JSON.stringify`. You can set this property to true to have Date objects properly serialize as a `VT_DATE` when sending to the native host object, and have `VT_DATE` properties and return values create a javascript Date object.
      /// `defaultSyncProxy` | When calling a method on a synchronous proxy, the result should also be a synchronous proxy. But in some cases, the sync/async context is lost (for example, when providing to native code a reference to a function, and then calling that function in native code). In these cases, the proxy will be asynchronous, unless this property is set.
      /// `forceAsyncMethodMatches ` | This is an array of regular expressions. When calling a method on a synchronous proxy, the method call will be performed asynchronously if the method name matches a string or regular expression in this array. Setting this value to `Async` will make any method that ends with Async be an asynchronous method call. If an async method doesn't match here and isn't forced to be asynchronous, the method will be invoked synchronously, blocking execution of the calling JavaScript and then returning the resolution of the promise, rather than returning a promise.
      /// `ignoreMemberNotFoundError` | By default, an exception is thrown when attempting to get the value of a proxy property that doesn't exist on the corresponding native class. Setting this property to `true` switches the behavior to match Chakra WinRT projection (and general JavaScript) behavior of returning `undefined` with no error.
      /// `shouldPassTypedArraysAsArrays` | By default, typed arrays are passed to the host as `IDispatch`. To instead pass typed arrays to the host as `array`, set this to `true`.
      /// </code>
      /// <para>Host object proxies additionally have the following methods which run
      /// locally.</para>
      /// <code>
      /// Method name | Details
      /// ---|---
      ///`applyHostFunction`, `getHostProperty`, `setHostProperty` | Perform a method invocation, property get, or property set on the host object. Use the methods to explicitly force a method or property to run remotely if a conflicting local method or property exists.  For instance, `proxy.toString()` runs the local `toString` method on the proxy object. But proxy.applyHostFunction('toString') runs `toString` on the host proxied object instead.
      ///`getLocalProperty`, `setLocalProperty` | Perform property get, or property set locally.  Use the methods to force getting or setting a property on the host object proxy rather than on the host object it represents. For instance, `proxy.unknownProperty` gets the property named `unknownProperty` from the host proxied object.  But proxy.getLocalProperty('unknownProperty') gets the value of the property `unknownProperty` on the proxy object.
      ///`sync` | Asynchronous host object proxies expose a sync method which returns a promise for a synchronous host object proxy for the same host object.  For example, `chrome.webview.hostObjects.sample.methodCall()` returns an asynchronous host object proxy.  Use the `sync` method to obtain a synchronous host object proxy instead: `const syncProxy = await chrome.webview.hostObjects.sample.methodCall().sync()`.
      ///`async` | Synchronous host object proxies expose an async method which blocks and returns an asynchronous host object proxy for the same host object.  For example, `chrome.webview.hostObjects.sync.sample.methodCall()` returns a synchronous host object proxy.  Running the `async` method on this blocks and then returns an asynchronous host object proxy for the same host object: `const asyncProxy = chrome.webview.hostObjects.sync.sample.methodCall().async()`.
      ///`then` | Asynchronous host object proxies have a `then` method.  Allows proxies to be awaitable.  `then` returns a promise that resolves with a representation of the host object.  If the proxy represents a JavaScript literal, a copy of that is returned locally.  If the proxy represents a function, a non-awaitable proxy is returned.  If the proxy represents a JavaScript object with a mix of literal properties and function properties, the a copy of the object is returned with some properties as host object proxies.
      /// </code>
      /// <para>All other property and method invocations (other than the above Remote
      /// object proxy methods, `forceLocalProperties` list, and properties on
      /// Function and Object prototypes) are run remotely.  Asynchronous host
      /// object proxies return a promise representing asynchronous completion of
      /// remotely invoking the method, or getting the property.  The promise
      /// resolves after the remote operations complete and the promises resolve to
      ///  the resulting value of the operation.  Synchronous host object proxies
      /// work similarly, but block running JavaScript and wait for the remote
      /// operation to complete.</para>
      ///
      /// <para>Setting a property on an asynchronous host object proxy works slightly
      /// differently.  The set returns immediately and the return value is the
      /// value that is set.  This is a requirement of the JavaScript Proxy object.
      /// If you need to asynchronously wait for the property set to complete, use
      /// the `setHostProperty` method which returns a promise as described above.
      /// Synchronous object property set property synchronously blocks until the
      /// property is set.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#addhostobjecttoscript">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    AddHostObjectToScript(const aName : wvstring; const aObject : OleVariant): boolean;
      /// <summary>
      /// Remove the host object specified by the name so that it is no longer
      /// accessible from JavaScript code in the WebView.  While new access
      /// attempts are denied, if the object is already obtained by JavaScript code
      /// in the WebView, the JavaScript code continues to have access to that
      /// object.   Run this method for a name that is already removed or never
      /// added fails.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#removehostobjectfromscript">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    RemoveHostObjectFromScript(const aName : wvstring) : boolean;
      /// <summary>
      /// <para>Add the provided JavaScript to a list of scripts that should be run after
      /// the global object has been created, but before the HTML document has
      /// been parsed and before any other script included by the HTML document is
      /// run.  This method injects a script that runs on all top-level document
      /// and child frame page navigations.  This method runs asynchronously, and
      /// you must wait for the completion handler to finish before the injected
      /// script is ready to run.  When this method completes, the `Invoke` method
      /// of the handler is run with the `id` of the injected script.  `id` is a
      /// string.  To remove the injected script, use
      /// `RemoveScriptToExecuteOnDocumentCreated`.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnAddScriptToExecuteOnDocumentCreatedCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#addscripttoexecuteondocumentcreated">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    AddScriptToExecuteOnDocumentCreated(const JavaScript : wvstring) : boolean;
      /// <summary>
      /// Remove the corresponding JavaScript added using
      /// `AddScriptToExecuteOnDocumentCreated` with the specified script ID. The
      /// script ID should be the one returned by the `AddScriptToExecuteOnDocumentCreated`.
      /// Both use `AddScriptToExecuteOnDocumentCreated` and this method in `NewWindowRequested`
      /// event handler at the same time sometimes causes trouble.  Since invalid scripts will
      /// be ignored, the script IDs you got may not be valid anymore.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#removescripttoexecuteondocumentcreated">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      function    RemoveScriptToExecuteOnDocumentCreated(const aID : wvstring) : boolean;
      /// <summary>
      /// Create a cookie object with a specified name, value, domain, and path.
      /// One can set other optional properties after cookie creation.
      /// This only creates a cookie object and it is not added to the cookie
      /// manager until you call AddOrUpdateCookie.
      /// Leading or trailing whitespace(s), empty string, and special characters
      /// are not allowed for name.
      /// See ICoreWebView2Cookie for more details.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#createcookie">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    CreateCookie(const aName, aValue, aDomain, aPath : wvstring) : ICoreWebView2Cookie;
      /// <summary>
      /// Creates a cookie whose params matches those of the specified cookie.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#copycookie">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    CopyCookie(const aCookie : ICoreWebView2Cookie) : ICoreWebView2Cookie;
      /// <summary>
      /// <para>Gets a list of cookies matching the specific URI.
      /// If uri is empty string or null, all cookies under the same profile are
      /// returned.</para>
      /// <para>You can modify the cookie objects by calling
      /// ICoreWebView2CookieManager.AddOrUpdateCookie, and the changes
      /// will be applied to the webview.</para>
      /// <para>The TWVBrowserBase.OnGetCookiesCompleted event is triggered asynchronously with the cookies.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#getcookies">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    GetCookies(const aURI : wvstring = ''):  boolean;
      /// <summary>
      /// Adds or updates a cookie with the given cookie data; may overwrite
      /// cookies with matching name, domain, and path if they exist.
      /// This method will fail if the domain of the given cookie is not specified.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#addorupdatecookie">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    AddOrUpdateCookie(const aCookie : ICoreWebView2Cookie): boolean;
      /// <summary>
      /// Deletes a cookie whose name and domain/path pair
      /// match those of the specified cookie.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#deletecookie">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    DeleteCookie(const aCookie : ICoreWebView2Cookie): boolean;
      /// <summary>
      /// Deletes cookies with matching name and uri.
      /// Cookie name is required.
      /// All cookies with the given name where domain
      /// and path match provided URI are deleted.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#deletecookies">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    DeleteCookies(const aName, aURI : wvstring): boolean;
      /// <summary>
      /// Deletes cookies with matching name and domain/path pair.
      /// Cookie name is required.
      /// If domain is specified, deletes only cookies with the exact domain.
      /// If path is specified, deletes only cookies with the exact path.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#deletecookieswithdomainandpath">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    DeleteCookiesWithDomainAndPath(const aName, aDomain, aPath : wvstring): boolean;
      /// <summary>
      /// Deletes all cookies under the same profile.
      /// This could affect other WebViews under the same user profile.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#deleteallcookies">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      function    DeleteAllCookies : boolean;
      /// <summary>
      /// Move the parent form to the x and y coordinates.
      /// </summary>
      procedure   MoveFormTo(const x, y: Integer); virtual; abstract;
      /// <summary>
      /// Move the parent form adding x and y to the coordinates.
      /// </summary>
      procedure   MoveFormBy(const x, y: Integer); virtual; abstract;
      /// <summary>
      /// Add x to the parent form width.
      /// </summary>
      procedure   ResizeFormWidthTo(const x : Integer); virtual; abstract;
      /// <summary>
      /// Add y to the parent form height.
      /// </summary>
      procedure   ResizeFormHeightTo(const y : Integer); virtual; abstract;
      /// <summary>
      /// Set the parent form left property to x.
      /// </summary>
      procedure   SetFormLeftTo(const x : Integer); virtual; abstract;
      /// <summary>
      /// Set the parent form top property to y.
      /// </summary>
      procedure   SetFormTopTo(const y : Integer); virtual; abstract;
      /// <summary>
      /// Increments the browser zoom.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_zoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      procedure   IncZoomStep;
      /// <summary>
      /// Decrements the browser zoom.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_zoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      procedure   DecZoomStep;
      /// <summary>
      /// Sets the browser zoom to 100%.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_zoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      procedure   ResetZoom;
      /// <summary>
      /// Updates `Bounds` and `ZoomFactor` properties at the same time.  This
      /// operation is atomic from the perspective of the host.  After returning
      /// from this function, the `Bounds` and `ZoomFactor` properties are both
      /// updated if the function is successful, or neither is updated if the
      /// function fails.  If `Bounds` and `ZoomFactor` are both updated by the
      /// same scale (for example, `Bounds` and `ZoomFactor` are both doubled),
      /// then the page does not display a change in `window.innerWidth` or
      /// `window.innerHeight` and the WebView renders the content at the new size
      /// and zoom without intermediate renderings.  This function also updates
      /// just one of `ZoomFactor` or `Bounds` by passing in the new value for one
      /// and the current value for the other.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#setboundsandzoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      function    SetBoundsAndZoomFactor(aBounds: TRect; const aZoomFactor: double) : boolean;
      /// <summary>
      /// Enables or disables all audio output from this browser.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8#get_ismuted">See the ICoreWebView2_8 article.</see></para>
      /// </remarks>
      procedure   ToggleMuteState;
      /// <summary>
      /// Open the default download dialog. If the dialog is opened before there
      /// are recent downloads, the dialog shows all past downloads for the
      /// current profile. Otherwise, the dialog shows only the recent downloads
      /// with a "See more" button for past downloads. Calling this method raises
      /// the `IsDefaultDownloadDialogOpenChanged` event if the dialog was closed.
      /// No effect if the dialog is already open.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#opendefaultdownloaddialog">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      function    OpenDefaultDownloadDialog : boolean;
      /// <summary>
      /// Close the default download dialog. Calling this method raises the
      /// IsDefaultDownloadDialogOpenChanged event if the dialog was open.
      /// No effect if the dialog is already closed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#opendefaultdownloaddialog">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      function    CloseDefaultDownloadDialog : boolean;
      /// <summary>
      /// Simulate editing commands using the "Input.dispatchKeyEvent" DevTools method.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent">See the "Input.dispatchKeyEvent" DevTools method.</see></para>
      /// <para><see href="https://source.chromium.org/chromium/chromium/src/+/master:third_party/blink/renderer/core/editing/commands/editor_command_names.h">See the Chromium sources.</see></para>
      /// </remarks>
      function    SimulateEditingCommand(aEditingCommand : TWV2EditingCommand): boolean;
      /// <summary>
      /// Dispatches a key event to the page using the "Input.dispatchKeyEvent"
      /// DevTools method. The browser has to be focused before simulating any
      /// key event. This function is asynchronous and it triggers the
      /// TWVBrowserBase.OnSimulateKeyEventCompleted event when it finishes executing.
      /// </summary>
      /// <param name="type_">Type of the key event.</param>
      /// <param name="modifiers">Bit field representing pressed modifier keys. Alt=1, Ctrl=2, Meta/Command=4, Shift=8.</param>
      /// <param name="windowsVirtualKeyCode">Windows virtual key code.</param>
      /// <param name="nativeVirtualKeyCode">Native virtual key code.</param>
      /// <param name="timestamp">Time at which the event occurred.</param>
      /// <param name="location">Whether the event was from the left or right side of the keyboard. 1=Left, 2=Right.</param>
      /// <param name="autoRepeat">Whether the event was generated from auto repeat.</param>
      /// <param name="isKeypad">Whether the event was generated from the keypad.</param>
      /// <param name="isSystemKey">Whether the event was a system key event.</param>
      /// <param name="text">Text as generated by processing a virtual key code with a keyboard layout. Not needed for for keyUp and rawKeyDown events.</param>
      /// <param name="unmodifiedtext">Text that would have been generated by the keyboard if no modifiers were pressed (except for shift). Useful for shortcut (accelerator) key handling.</param>
      /// <param name="keyIdentifier">Unique key identifier (e.g., 'U+0041').</param>
      /// <param name="code">Unique DOM defined string value for each physical key (e.g., 'KeyA').</param>
      /// <param name="key">Unique DOM defined string value describing the meaning of the key in the context of active modifiers, keyboard layout, etc (e.g., 'AltGr').</param>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent">See the "Input.dispatchKeyEvent" DevTools method.</see></para>
      /// </remarks>
      function    SimulateKeyEvent(type_: TWV2KeyEventType; modifiers, windowsVirtualKeyCode, nativeVirtualKeyCode: integer; timestamp: integer = 0; location: integer = 0; autoRepeat: boolean = False; isKeypad: boolean = False; isSystemKey: boolean = False; const text: wvstring = ''; const unmodifiedtext: wvstring = ''; const keyIdentifier: wvstring = ''; const code: wvstring = ''; const key: wvstring = ''): boolean; virtual;
      /// <summary>
      /// Simulate that the F3 key was pressed and released.
      /// The browser has to be focused before simulating any key event.
      /// This key information was logged using a Spanish keyboard. It might not work with different keyboard layouts.
      /// This function is asynchronous and it triggers the TWVBrowserBase.OnSimulateKeyEventCompleted event several times.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent">See the "Input.dispatchKeyEvent" DevTools method.</see></para>
      /// </remarks>
      function    KeyboardShortcutSearch : boolean; virtual;
      /// <summary>
      /// Simulate that SHIFT + F5 keys were pressed and released.
      /// The browser has to be focused before simulating any key event.
      /// This key information was logged using a Spanish keyboard. It might not work with different keyboard layouts.
      /// This function is asynchronous and it triggers the TWVBrowserBase.OnSimulateKeyEventCompleted event several times.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent">See the "Input.dispatchKeyEvent" DevTools method.</see></para>
      /// </remarks>
      function    KeyboardShortcutRefreshIgnoreCache : boolean; virtual;
      /// <summary>
      /// <para>This function is only available in "Windowless mode" and provides mouse input meant for the WebView.</para>
      /// <para>If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_HORIZONTAL_WHEEL or
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_WHEEL, then mouseData specifies the amount of
      /// wheel movement. A positive value indicates that the wheel was rotated
      /// forward, away from the user; a negative value indicates that the wheel was
      /// rotated backward, toward the user. One wheel click is defined as
      /// WHEEL_DELTA, which is 120.</para>
      /// <para>If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOUBLE_CLICK
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOWN, or
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_UP, then mouseData specifies which X
      /// buttons were pressed or released. This value should be 1 if the first X
      /// button is pressed/released and 2 if the second X button is
      /// pressed/released.</para>
      /// <para>If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE, then virtualKeys,
      /// mouseData, and point should all be zero.</para>
      /// <para>If eventKind is any other value, then mouseData should be zero.
      /// Point is expected to be in the client coordinate space of the WebView.
      /// To track mouse events that start in the WebView and can potentially move
      /// outside of the WebView and host application, calling SetCapture and
      /// ReleaseCapture is recommended.</para>
      /// <para>To dismiss hover popups, it is also recommended to send
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE messages.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller#sendmouseinput">See the ICoreWebView2CompositionController article.</see></para>
      /// </remarks>
      function    SendMouseInput(aEventKind : TWVMouseEventKind; aVirtualKeys : TWVMouseEventVirtualKeys; aMouseData : cardinal; aPoint : TPoint) : boolean;
      /// <summary>
      /// <para>This function is only available in "Windowless mode" and provides pointer input meant for the WebView.</para>
      /// <para>SendPointerInput accepts touch or pen pointer input of types defined in
      /// COREWEBVIEW2_POINTER_EVENT_KIND. Any pointer input from the system must be
      /// converted into an ICoreWebView2PointerInfo first.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller#sendpointerinput">See the ICoreWebView2CompositionController article.</see></para>
      /// </remarks>
      function    SendPointerInput(aEventKind : TWVPointerEventKind; const aPointerInfo : ICoreWebView2PointerInfo) : boolean;
      /// <summary>
      /// <para>This function is only available in "Windowless mode" and corresponds to
      /// [IDropTarget::DragEnter](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragenter).</para>
      /// <para>This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.</para>
      /// <para>The hosting application must register as an IDropTarget and implement
      /// and forward DragEnter calls to this function.</para>
      /// <para>point parameter must be modified to include the WebView's offset and be in
      /// the WebView's client coordinates (Similar to how SendMouseInput works).</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller3#dragenter">See the ICoreWebView2CompositionController3 article.</see></para>
      /// </remarks>
      function    DragEnter(const dataObject: IDataObject; keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
      /// <summary>
      /// <para>This function is only available in "Windowless mode" and corresponds to
      /// [IDropTarget::DragLeave](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragleave).</para>
      /// <para>This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.</para>
      /// <para>The hosting application must register as an IDropTarget and implement
      /// and forward DragLeave calls to this function.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller3#dragleave">See the ICoreWebView2CompositionController3 article.</see></para>
      /// </remarks>
      function    DragLeave : HResult;
      /// <summary>
      /// <para>This function is only available in "Windowless mode" and corresponds to
      /// [IDropTarget::DragOver](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragover).</para>
      /// <para>This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.</para>
      /// <para>The hosting application must register as an IDropTarget and implement
      /// and forward DragOver calls to this function.</para>
      /// <para>point parameter must be modified to include the WebView's offset and be in
      /// the WebView's client coordinates (Similar to how SendMouseInput works).</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller3#dragover">See the ICoreWebView2CompositionController3 article.</see></para>
      /// </remarks>
      function    DragOver(keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
      /// <summary>
      /// <para>This function is only available in "Windowless mode" and corresponds to
      /// [IDropTarget::Drop](/windows/win32/api/oleidl/nf-oleidl-idroptarget-drop).</para>
      /// <para>This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.</para>
      /// <para>The hosting application must register as an IDropTarget and implement
      /// and forward Drop calls to this function.</para>
      /// <para>point parameter must be modified to include the WebView's offset and be in
      /// the WebView's client coordinates (Similar to how SendMouseInput works).</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller3#drop">See the ICoreWebView2CompositionController3 article.</see></para>
      /// </remarks>
      function    Drop(const dataObject: IDataObject; keyState: LongWord; point: TPoint; out effect: LongWord) : HResult;
      /// <summary>
      /// <para>If you are hosting a WebView2 using CoreWebView2CompositionController, you can call
      /// this method in your Win32 WndProc to determine if the mouse is moving over or
      /// clicking on WebView2 web content that should be considered part of a non-client region.</para>
      /// <para>The point parameter is expected to be in the client coordinate space of WebView2.
      /// The method sets the out parameter value as follows:</para>
      /// <code>
      ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_CAPTION when point corresponds to
      ///         a region (HTML element) within the WebView2 with
      ///         `-webkit-app-region: drag` CSS style set.
      ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_CLIENT when point corresponds to
      ///         a region (HTML element) within the WebView2 without
      ///         `-webkit-app-region: drag` CSS style set.
      ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_NOWHERE when point is not within the WebView2.
      /// </code>
      /// <para>NOTE: in order for WebView2 to properly handle the title bar system menu,
      /// the app needs to send WM_NCRBUTTONDOWN and WM_NCRBUTTONUP to SendMouseInput.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller4#getnonclientregionatpoint">See the ICoreWebView2CompositionController4 article.</see></para>
      /// </remarks>
      function    GetNonClientRegionAtPoint(point: TPoint) : TWVNonClientRegionKind;
      /// <summary>
      /// This method is used to get the collection of rects that correspond
      /// to a particular TWVNonClientRegionKind. This is to be used in
      /// the callback of add_NonClientRegionChanged whose event args object contains
      /// a region property of type TWVNonClientRegionKind.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller4#querynonclientregion">See the ICoreWebView2CompositionController4 article.</see></para>
      /// </remarks>
      function    QueryNonClientRegion(Kind: TWVNonClientRegionKind): ICoreWebView2RegionRectCollectionView;
      /// <summary>
      /// Clears the browser cache. This function is asynchronous and it triggers the TWVBrowserBase.OnClearCacheCompleted event when it finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Network/#method-clearBrowserCache">See the Chrome DevTools Protocol page about the Network.clearBrowserCache method.</see></para>
      /// </remarks>
      function    ClearCache : boolean;
      /// <summary>
      /// Clears the storage for origin. This function is asynchronous and it triggers the TWVBrowserBase.OnClearDataForOriginCompleted event when it finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Storage/#method-clearDataForOrigin">See the Chrome DevTools Protocol page about the Storage.clearDataForOrigin method.</see></para>
      /// </remarks>
      function    ClearDataForOrigin(const aOrigin : wvstring; aStorageTypes : TWVClearDataStorageTypes = cdstAll) : boolean;
      /// <summary>
      /// <para>Clear browsing data based on a data type. This method takes two parameters,
      /// the first being a mask of one or more `COREWEBVIEW2_BROWSING_DATA_KINDS`. OR
      /// operation(s) can be applied to multiple `COREWEBVIEW2_BROWSING_DATA_KINDS` to
      /// create a mask representing those data types.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnClearBrowsingDataCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2#clearbrowsingdata">See the ICoreWebView2Profile2 article.</see></para>
      /// </remarks>
      function    ClearBrowsingData(dataKinds: TWVBrowsingDataKinds): boolean;
      /// <summary>
      /// <para>ClearBrowsingDataInTimeRange behaves like ClearBrowsingData except that it
      /// takes in two additional parameters for the start and end time for which it
      /// should clear the data between.  The `startTime` and `endTime`
      /// parameters correspond to the number of seconds since the UNIX epoch.</para>
      /// <para>`startTime` is inclusive while `endTime` is exclusive, therefore the data will
      /// be cleared between startTime and endTime.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnClearBrowsingDataCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2#clearbrowsingdataintimerange">See the ICoreWebView2Profile2 article.</see></para>
      /// </remarks>
      function    ClearBrowsingDataInTimeRange(dataKinds: TWVBrowsingDataKinds; const startTime, endTime: TDateTime): boolean;
      /// <summary>
      /// <para>ClearBrowsingDataAll behaves like ClearBrowsingData except that it
      /// clears the entirety of the data associated with the profile it is called on.
      /// It clears the data regardless of timestamp.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnClearBrowsingDataCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2#clearbrowsingdataall">See the ICoreWebView2Profile2 article.</see></para>
      /// </remarks>
      function    ClearBrowsingDataAll: boolean;
      /// <summary>
      /// <para>Clears all cached decisions to proceed with TLS certificate errors from the
      /// OnServerCertificateErrorDetected event for all WebView2's sharing the same session.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnServerCertificateErrorActionsCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14#clearservercertificateerroractions">See the ICoreWebView2_14 article.</see></para>
      /// </remarks>
      function    ClearServerCertificateErrorActions : boolean;
      /// <summary>
      /// <para>Async function for getting the actual image data of the favicon.</para>
      /// <para>This function is asynchronous and it triggers the TWVBrowserBase.OnGetFaviconCompleted event when it finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15#getfavicon">See the ICoreWebView2_15 article.</see></para>
      /// </remarks>
      function    GetFavicon(aFormat: TWVFaviconImageFormat = COREWEBVIEW2_FAVICON_IMAGE_FORMAT_PNG) : boolean;
      /// <summary>
      /// Create a shared memory based buffer with the specified size in bytes.
      /// The buffer can be shared with web contents in WebView by calling
      /// `PostSharedBufferToScript` on `CoreWebView2` or `CoreWebView2Frame` object.
      /// Once shared, the same content of the buffer will be accessible from both
      /// the app process and script in WebView. Modification to the content will be visible
      /// to all parties that have access to the buffer.
      /// The shared buffer is presented to the script as ArrayBuffer. All JavaScript APIs
      /// that work for ArrayBuffer including Atomics APIs can be used on it.
      /// There is currently a limitation that only size less than 2GB is supported.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment12#createsharedbuffer">See the ICoreWebView2Environment12 article.</see></para>
      /// </remarks>
      function    CreateSharedBuffer(aSize : Largeuint; var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;
      /// <summary>
      /// <para>Share a shared buffer object with script of the main frame in the WebView.</para>
      /// <para>The script will receive a `sharedbufferreceived` event from chrome.webview.</para>
      /// <para>Read the linked article for all the details.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_17#postsharedbuffertoscript">See the ICoreWebView2_17 article.</see></para>
      /// </remarks>
      function    PostSharedBufferToScript(const aSharedBuffer: ICoreWebView2SharedBuffer; aAccess: TWVSharedBufferAccess; const aAdditionalDataAsJson: wvstring): boolean;
      /// <summary>
      /// <para>Gets a snapshot collection of `ProcessExtendedInfo`s corresponding to all
      /// currently running processes associated with this `ICoreWebView2Environment`
      /// excludes crashpad process.</para>
      /// <para>This provides the same list of `ProcessInfo`s as what's provided in
      /// `GetProcessInfos`, but additionally provides a list of associated `FrameInfo`s
      /// which are actively running (showing or hiding UI elements) in the renderer
      /// process. See `AssociatedFrameInfos` for more information.</para>
      /// </summary>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment13#getprocessextendedinfos">See the ICoreWebView2Environment13 article.</see></para>
      /// <para>This function triggers the TWVBrowserBase.OnGetProcessExtendedInfosCompleted event.</para>
      /// </remarks>
      function    GetProcessExtendedInfos : boolean;
      /// <summary>
      /// <para>Programmatically trigger a Save As action for the currently loaded document.</para>
      /// <para>Opens a system modal dialog by default. If the `SuppressDefaultDialog` property
      /// is `TRUE`, the system dialog is not opened.</para>
      /// <para>This method returns `COREWEBVIEW2_SAVE_AS_UI_RESULT`. See
      /// `COREWEBVIEW2_SAVE_AS_UI_RESULT` for details.</para>
      /// </summary>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25#showsaveasui">See the ICoreWebView2_25 article.</see></para>
      /// <para>This function triggers the TWVBrowserBase.OnSaveAsUIShowing and TWVBrowserBase.OnShowSaveAsUICompleted events.</para>
      /// </remarks>
      function    ShowSaveAsUI : boolean;

      // Custom properties
      property Initialized                                     : boolean                                               read GetInitialized;
      /// <summary>
      /// Settings used for printing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printsettings">See the ICoreWebView2PrintSettings article.</see></para>
      /// </remarks>
      property CoreWebView2PrintSettings                       : TCoreWebView2PrintSettings                            read FCoreWebView2PrintSettings;
      /// <summary>
      /// CoreWebView2Settings contains various modifiable settings for the running WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property CoreWebView2Settings                            : TCoreWebView2Settings                                 read FCoreWebView2Settings;
      /// <summary>
      /// Represents the WebView2 Environment.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment">See the ICoreWebView2Environment article.</see></para>
      /// </remarks>
      property CoreWebView2Environment                         : TCoreWebView2Environment                              read FCoreWebView2Environment;
      /// <summary>
      /// The owner of the `CoreWebView2` object that provides support for resizing,
      /// showing and hiding, focusing, and other functionality related to
      /// windowing and composition.  The `CoreWebView2Controller` owns the
      /// `CoreWebView2`, and if all references to the `CoreWebView2Controller` go
      /// away, the WebView is closed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property CoreWebView2Controller                          : TCoreWebView2Controller                               read FCoreWebView2Controller;
      /// <summary>
      /// <para>ICoreWebView2CompositionController wrapper used by this browser.</para>
      /// <para>This interface is an extension of the ICoreWebView2Controller interface to
      /// support visual hosting. An object implementing the
      /// ICoreWebView2CompositionController interface will also implement
      /// ICoreWebView2Controller. Callers are expected to use
      /// ICoreWebView2Controller for resizing, visibility, focus, and so on, and
      /// then use ICoreWebView2CompositionController to connect to a composition
      /// tree and provide input meant for the WebView.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller">See the ICoreWebView2CompositionController article.</see></para>
      /// </remarks>
      property CoreWebView2CompositionController               : TCoreWebView2CompositionController                    read FCoreWebView2CompositionController;
      /// <summary>
      /// ICoreWebView2 wrapper used by this browser.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property CoreWebView2                                    : TCoreWebView2                                         read FCoreWebView2;
      /// <summary>
      /// The associated `ICoreWebView2Profile` object. If this CoreWebView2 was created with a
      /// CoreWebView2ControllerOptions, the CoreWebView2Profile will match those specified options.
      /// Otherwise if this CoreWebView2 was created without a CoreWebView2ControllerOptions, then
      /// this will be the default CoreWebView2Profile for the corresponding CoreWebView2Environment.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_13#get_profile">See the ICoreWebView2_13 article.</see></para>
      /// </remarks>
      property Profile                                         : TCoreWebView2Profile                                  read FCoreWebView2Profile;
      /// <summary>
      /// First URL loaded by the browser after its creation.
      /// </summary>
      property DefaultURL                                      : wvstring                                              read FDefaultURL                                      write FDefaultURL;
      /// <summary>
      /// Returns true after OnNavigationStarting and before OnNavigationCompleted.
      /// </summary>
      property IsNavigating                                    : boolean                                               read FIsNavigating;
      /// <summary>
      /// Returns the current zoom value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_zoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property ZoomPct                                         : double                                                read GetZoomPct                                       write SetZoomPct;
      /// <summary>
      /// Returns the current zoom value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_zoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property ZoomStep                                        : byte                                                  read FZoomStep                                        write SetZoomStep;
      /// <summary>
      /// Handle of one to the child controls created automatically by the browser to show the web contents.
      /// </summary>
      property Widget0CompHWND                                 : THandle                                               read FWidget0CompHWND;
      /// <summary>
      /// Handle of one to the child controls created automatically by the browser to show the web contents.
      /// </summary>
      property Widget1CompHWND                                 : THandle                                               read FWidget1CompHWND;
      /// <summary>
      /// Handle of one to the child controls created automatically by the browser to show the web contents.
      /// </summary>
      property RenderCompHWND                                  : THandle                                               read FRenderCompHWND;
      /// <summary>
      /// Handle of one to the child controls created automatically by the browser to show the web contents.
      /// </summary>
      property D3DWindowCompHWND                               : THandle                                               read FD3DWindowCompHWND;
      /// <summary>
      /// Returns the GlobalWebView2Loader.DeviceScaleFactor value.
      /// </summary>
      property ScreenScale                                     : single                                                read GetScreenScale;
      /// <summary>
      /// <para>Uses the Network.emulateNetworkConditions DevTool method to set the browser in offline mode.</para>
      /// <para>The TWVBrowserBase.OnOfflineCompleted event is triggered asynchronously after setting this property.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Network/#method-emulateNetworkConditions">See the Network Domain article.</see></para>
      /// </remarks>
      property Offline                                         : boolean                                               read FOffline                                         write SetOffline;
      /// <summary>
      /// <para>Uses the Security.setIgnoreCertificateErrors DevTool method to enable/disable whether all certificate errors should be ignored.</para>
      /// <para>The TWVBrowserBase.OnIgnoreCertificateErrorsCompleted event is triggered asynchronously after setting this property.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Security/#method-setIgnoreCertificateErrors">See the Security Domain article.</see></para>
      /// </remarks>
      property IgnoreCertificateErrors                         : boolean                                               read FIgnoreCertificateErrors                         write SetIgnoreCertificateErrors;

      // Properties used in the ICoreWebView2Environment creation
      property BrowserExecPath                                 : wvstring                                              read FBrowserExecPath                                 write FBrowserExecPath;
      /// <summary>
      /// Returns the user data folder that all CoreWebView2's created from this
      /// environment are using.
      /// This could be either the value passed in by the developer when creating
      /// the environment object or the calculated one for default handling.  It
      /// will always be an absolute path.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment7#get_userdatafolder">See the ICoreWebView2Environment7 article.</see></para>
      /// </remarks>
      property UserDataFolder                                  : wvstring                                              read GetUserDataFolder                                write FUserDataFolder;
      /// <summary>
      /// Additional command line switches.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_AdditionalBrowserArguments.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property AdditionalBrowserArguments                      : wvstring                                              read FAdditionalBrowserArguments                      write FAdditionalBrowserArguments;
      /// <summary>
      /// The default display language for WebView.  It applies to browser UI such as
      /// context menu and dialogs.  It also applies to the `accept-languages` HTTP
      /// header that WebView sends to websites.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_Language.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property Language                                        : wvstring                                              read FLanguage                                        write FLanguage;
      /// <summary>
      /// Specifies the version of the WebView2 Runtime binaries required to be
      /// compatible with your app.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_TargetCompatibleBrowserVersion.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property TargetCompatibleBrowserVersion                  : wvstring                                              read FTargetCompatibleBrowserVersion                  write FTargetCompatibleBrowserVersion;
      /// <summary>
      /// Used to enable single sign on with Azure Active Directory (AAD) and personal Microsoft
      /// Account (MSA) resources inside WebView.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions.get_AllowSingleSignOnUsingOSPrimaryAccount.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
      /// </remarks>
      property AllowSingleSignOnUsingOSPrimaryAccount          : boolean                                               read FAllowSingleSignOnUsingOSPrimaryAccount          write FAllowSingleSignOnUsingOSPrimaryAccount;
      /// <summary>
      /// Whether other processes can create WebView2 from WebView2Environment created with the
      /// same user data folder and therefore sharing the same WebView browser process instance.
      /// Default is FALSE.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions2.Get_ExclusiveUserDataFolderAccess.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions2">See the ICoreWebView2EnvironmentOptions2 article.</see></para>
      /// </remarks>
      property ExclusiveUserDataFolderAccess                   : boolean                                               read FExclusiveUserDataFolderAccess                   write FExclusiveUserDataFolderAccess;
      /// <summary>
      /// When `CustomCrashReportingEnabled` is set to `TRUE`, Windows won't send crash data to Microsoft endpoint.
      /// `CustomCrashReportingEnabled` is default to be `FALSE`, in this case, WebView will respect OS consent.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions3.Get_IsCustomCrashReportingEnabled.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions3">See the ICoreWebView2EnvironmentOptions3 article.</see></para>
      /// </remarks>
      property CustomCrashReportingEnabled                     : boolean                                               read FCustomCrashReportingEnabled                     write FCustomCrashReportingEnabled;
      /// <summary>
      /// The `EnableTrackingPrevention` property is used to enable/disable tracking prevention
      /// feature in WebView2. This property enable/disable tracking prevention for all the
      /// WebView2's created in the same environment.
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions5.Get_EnableTrackingPrevention.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions5">See the ICoreWebView2EnvironmentOptions5 article.</see></para>
      /// </remarks>
      property EnableTrackingPrevention                        : boolean                                               read FEnableTrackingPrevention                        write FEnableTrackingPrevention;
      /// <summary>
      /// <para>When `AreBrowserExtensionsEnabled` is set to `TRUE`, new extensions can be added to user
      /// profile and used. `AreBrowserExtensionsEnabled` is default to be `FALSE`, in this case,
      /// new extensions can't be installed, and already installed extension won't be
      /// available to use in user profile.</para>
      /// <para>If connecting to an already running environment with a different value for `AreBrowserExtensionsEnabled`
      /// property, it will fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions6.Get_AreBrowserExtensionsEnabled.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions6">See the ICoreWebView2EnvironmentOptions6 article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextension">See the ICoreWebView2BrowserExtension article for Extensions API details.</see></para>
      /// </remarks>
      property AreBrowserExtensionsEnabled                     : boolean                                               read FAreBrowserExtensionsEnabled                     write FAreBrowserExtensionsEnabled;
      /// <summary>
      /// <para>The `ChannelSearchKind` property is `COREWEBVIEW2_CHANNEL_SEARCH_KIND_MOST_STABLE`
      /// by default; environment creation searches for a release channel on the machine
      /// from most to least stable using the first channel found. The default search order is:
      /// WebView2 Runtime -&gt; Beta -&gt; Dev -&gt; Canary. Set `ChannelSearchKind` to
      /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE` to reverse the search order
      /// so that environment creation searches for a channel from least to most stable. If
      /// `ReleaseChannels` has been provided, the loader will only search
      /// for channels in the set. See `COREWEBVIEW2_RELEASE_CHANNELS` for more details
      /// on channels.</para>
      /// <para>This property can be overridden by the corresponding
      /// registry key `ChannelSearchKind` or the environment variable
      /// `WEBVIEW2_CHANNEL_SEARCH_KIND`. Set the value to `1` to set the search kind to
      /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE`. See
      /// `CreateCoreWebView2EnvironmentWithOptions` for more details on overrides.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions7.Get_ChannelSearchKind.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7">See the ICoreWebView2EnvironmentOptions7 article.</see></para>
      /// </remarks>
      property ChannelSearchKind                               : TWVChannelSearchKind                                  read FChannelSearchKind                               write FChannelSearchKind;
      /// <summary>
      /// <para>Sets the `ReleaseChannels`, which is a mask of one or more
      /// `COREWEBVIEW2_RELEASE_CHANNELS` indicating which channels environment
      /// creation should search for. OR operation(s) can be applied to multiple
      /// `COREWEBVIEW2_RELEASE_CHANNELS` to create a mask. The default value is a
      /// a mask of all the channels. By default, environment creation searches for
      /// channels from most to least stable, using the first channel found on the
      /// device. When `ReleaseChannels` is provided, environment creation will only
      /// search for the channels specified in the set. Set `ChannelSearchKind` to
      /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE` to reverse the search order
      /// so environment creation searches for least stable build first. See
      /// `COREWEBVIEW2_RELEASE_CHANNELS` for descriptions of each channel.</para>
      /// <para>`CreateCoreWebView2EnvironmentWithOptions` fails with
      /// `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)` if environment creation is unable
      /// to find any channel from the `ReleaseChannels` installed on the device.
      /// Use `GetAvailableCoreWebView2BrowserVersionStringWithOptions` on
      /// `ICoreWebView2Environment` to verify which channel is used when this option
      /// is set.</para>
      /// Examples:
      /// <code>
      /// |   ReleaseChannels   |   Channel Search Kind: Most Stable (default)   |   Channel Search Kind: Least Stable   |
      /// | --- | --- | --- |
      /// |COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE| WebView2 Runtime -&gt; Beta | Beta -&gt; WebView2 Runtime|
      /// |COREWEBVIEW2_RELEASE_CHANNELS_CANARY \| COREWEBVIEW2_RELEASE_CHANNELS_DEV \| COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE| WebView2 Runtime -&gt; Beta -&gt; Dev -&gt; Canary | Canary -&gt; Dev -&gt; Beta -&gt; WebView2 Runtime |
      /// |COREWEBVIEW2_RELEASE_CHANNELS_CANARY| Canary | Canary |
      /// |COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_CANARY \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE | WebView2 Runtime -&gt; Beta -&gt; Canary | Canary -&gt; Beta -&gt; WebView2 Runtime |
      /// </code>
      /// <para>If both `BrowserExecutableFolder` and `ReleaseChannels` are provided, the
      /// `BrowserExecutableFolder` takes precedence, regardless of whether or not the
      /// channel of `BrowserExecutableFolder` is included in the `ReleaseChannels`.</para>
      /// <para>`ReleaseChannels` can be overridden by the corresponding registry override
      /// `ReleaseChannels` or the environment variable `WEBVIEW2_RELEASE_CHANNELS`.</para>
      /// <para>Set the value to a comma-separated string of integers, which map to the
      /// following release channel values: Stable (0), Beta (1), Dev (2), and
      /// Canary (3). For example, the values "0,2" and "2,0" indicate that environment
      /// creation should only search for Dev channel and the WebView2 Runtime, using the
      /// order indicated by `ChannelSearchKind`. Environment creation attempts to
      /// interpret each integer and treats any invalid entry as Stable channel. See
      /// `CreateCoreWebView2EnvironmentWithOptions` for more details on overrides.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions7.Get_ReleaseChannels.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7">See the ICoreWebView2EnvironmentOptions7 article.</see></para>
      /// </remarks>
      property ReleaseChannels                                 : TWVReleaseChannels                                    read FReleaseChannels                                 write FReleaseChannels;
      /// <summary>
      /// <para>The ScrollBar style being set on the WebView2 Environment.</para>
      /// <para>The default value is `COREWEBVIEW2_SCROLLBAR_STYLE_DEFAULT`
      /// which specifies the default browser ScrollBar style.</para>
      /// <para>The `color-scheme` CSS property needs to be set on the corresponding page
      /// to allow ScrollBar to follow light or dark theme. Please see
      /// [color-scheme](https://developer.mozilla.org/docs/Web/CSS/color-scheme#declaring_color_scheme_preferences)
      /// for how `color-scheme` can be set.</para>
      /// <para>CSS styles that modify the ScrollBar applied on top of native ScrollBar styling
      /// that is selected with `ScrollBarStyle`.</para>
      /// </summary>
      /// <remarks>
      /// <para>Property used to create the environment. Used as ICoreWebView2EnvironmentOptions8.Get_ScrollBarStyle.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions8">See the ICoreWebView2EnvironmentOptions8 article.</see></para>
      /// </remarks>
      property ScrollBarStyle                                  : TWVScrollBarStyle                                     read FScrollBarStyle                                  write FScrollBarStyle;
      /// <summary>
      /// The browser version info of the current `ICoreWebView2Environment`,
      /// including channel name if it is not the WebView2 Runtime.  It matches the
      /// format of the `GetAvailableCoreWebView2BrowserVersionString` API.
      /// Channel names are `beta`, `dev`, and `canary`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment#get_browserversionstring">See the ICoreWebView2Environment article.</see></para>
      /// </remarks>
      property BrowserVersionInfo                              : wvstring                                              read GetBrowserVersionInfo;
      /// <summary>
      /// The process ID of the browser process that hosts the WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_browserprocessid">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property BrowserProcessID                                : cardinal                                              read GetBrowserProcessID;
      /// <summary>
      /// `TRUE` if the WebView is able to navigate to a previous page in the
      /// navigation history.  If `CanGoBack` changes value, the `HistoryChanged`
      /// event runs.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2##get_cangoback">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property CanGoBack                                       : boolean                                               read GetCanGoBack;
      /// <summary>
      /// `TRUE` if the WebView is able to navigate to a next page in the
      /// navigation history.  If `CanGoForward` changes value, the
      /// `HistoryChanged` event runs.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_cangoforward">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property CanGoForward                                    : boolean                                               read GetCanGoForward;
      /// <summary>
      /// Indicates if the WebView contains a fullscreen HTML element.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_containsfullscreenelement">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property ContainsFullScreenElement                       : boolean                                               read GetContainsFullScreenElement;
      /// <summary>
      /// The title for the current top-level document.  If the document has no
      /// explicit title or is otherwise empty, a default that may or may not match
      ///  the URI of the document is used.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_documenttitle">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property DocumentTitle                                   : wvstring                                              read GetDocumentTitle;
      /// <summary>
      /// The URI of the current top level document.  This value potentially
      /// changes as a part of the `SourceChanged` event that runs for some cases
      /// such as navigating to a different site or fragment navigations.  It
      /// remains the same for other types of navigations such as page refreshes
      /// or `history.pushState` with the same URL as the current page.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_source">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property Source                                          : wvstring                                              read GetSource;
      /// <summary>
      /// Gets the cookie manager object associated with this ICoreWebView2.
      /// See ICoreWebView2CookieManager.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2#get_cookiemanager">See the ICoreWebView2_2 article.</see></para>
      /// </remarks>
      property CookieManager                                   : ICoreWebView2CookieManager                            read GetCookieManager;
      /// <summary>
      /// Whether WebView is suspended.
      /// `TRUE` when WebView is suspended, from the time when TrySuspend has completed
      ///  successfully until WebView is resumed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3#get_issuspended">See the ICoreWebView2_3 article.</see></para>
      /// </remarks>
      property IsSuspended                                     : boolean                                               read GetIsSuspended;
      /// <summary>
      /// Indicates whether any audio output from this CoreWebView2 is playing.
      /// This property will be true if audio is playing even if IsMuted is true.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8#get_isdocumentplayingaudio">See the ICoreWebView2_8 article.</see></para>
      /// </remarks>
      property IsDocumentPlayingAudio                          : boolean                                               read GetIsDocumentPlayingAudio;
      /// <summary>
      /// Indicates whether all audio output from this CoreWebView2 is muted or not.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8#get_ismuted">See the ICoreWebView2_8 article.</see></para>
      /// </remarks>
      property IsMuted                                         : boolean                                               read GetIsMuted                                       write SetIsMuted;
      /// <summary>
      /// Get the default download dialog corner alignment.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#get_defaultdownloaddialogcorneralignment">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      property DefaultDownloadDialogCornerAlignment            : TWVDefaultDownloadDialogCornerAlignment               read GetDefaultDownloadDialogCornerAlignment          write SetDefaultDownloadDialogCornerAlignment;
      /// <summary>
      /// Get the default download dialog margin.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#get_defaultdownloaddialogmargin">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      property DefaultDownloadDialogMargin                     : TPoint                                                read GetDefaultDownloadDialogMargin                   write SetDefaultDownloadDialogMargin;
      /// <summary>
      /// `TRUE` if the default download dialog is currently open. The value of this
      /// property changes only when the default download dialog is explicitly
      /// opened or closed. Hiding the WebView implicitly hides the dialog, but does
      /// not change the value of this property.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#get_isdefaultdownloaddialogopen">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      property IsDefaultDownloadDialogOpen                     : boolean                                               read GetIsDefaultDownloadDialogOpen;
      /// <summary>
      /// The status message text.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_12#get_statusbartext">See the ICoreWebView2_12 article.</see></para>
      /// </remarks>
      property StatusBarText                                   : wvstring                                              read GetStatusBarText;
      /// <summary>
      /// Get the current Uri of the favicon as a string.
      /// If the value is null, then the return value is `E_POINTER`, otherwise it is `S_OK`.
      /// If a page has no favicon then the value is an empty string.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15#get_faviconuri">See the ICoreWebView2_15 article.</see></para>
      /// </remarks>
      property FaviconURI                                      : wvstring                                              read GetFaviconURI;
      /// <summary>
      /// `MemoryUsageTargetLevel` indicates desired memory consumption level of
      /// WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_19#get_memoryusagetargetlevel">See the ICoreWebView2_19 article.</see></para>
      /// </remarks>
      property MemoryUsageTargetLevel                          : TWVMemoryUsageTargetLevel                             read GetMemoryUsageTargetLevel                        write SetMemoryUsageTargetLevel;
      /// <summary>
      /// <para>The WebView bounds. Bounds are relative to the parent `HWND`.  The app
      /// has two ways to position a WebView.</para>
      /// <para>*   Create a child `HWND` that is the WebView parent `HWND`.  Position
      ///     the window where the WebView should be.  Use `(0, 0)` for the
      ///     top-left corner (the offset) of the `Bounds` of the WebView.</para>
      /// <para>*   Use the top-most window of the app as the WebView parent HWND.  For
      ///     example, to position WebView correctly in the app, set the top-left
      ///     corner of the Bound of the WebView.</para>
      /// <para>The values of `Bounds` are limited by the coordinate space of the host.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_bounds">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property Bounds                                          : TRect                                                 read GetBounds                                        write SetBounds;
      /// <summary>
      /// <para>The `IsVisible` property determines whether to show or hide the WebView2.</para>
      /// <para>If `IsVisible` is set to `FALSE`, the WebView2 is transparent and is
      /// not rendered.   However, this does not affect the window containing the
      /// WebView2 (the `HWND` parameter that was passed to
      /// `CreateCoreWebView2Controller`).  If you want that window to disappear
      /// too, run `ShowWindow` on it directly in addition to modifying the
      /// `IsVisible` property.  WebView2 as a child window does not get window
      /// messages when the top window is minimized or restored.  For performance
      /// reasons, developers should set the `IsVisible` property of the WebView to
      /// `FALSE` when the app window is minimized and back to `TRUE` when the app
      /// window is restored. The app window does this by handling
      /// `SIZE_MINIMIZED and SIZE_RESTORED` command upon receiving `WM_SIZE`
      /// message.</para>
      /// <para>There are CPU and memory benefits when the page is hidden. For instance,
      /// Chromium has code that throttles activities on the page like animations
      /// and some tasks are run less frequently. Similarly, WebView2 will
      /// purge some caches to reduce memory usage.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_isvisible">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property IsVisible                                       : boolean                                               read GetIsVisible                                     write SetIsVisible;
      /// <summary>
      /// The parent window provided by the app that this WebView is using to
      /// render content.  This API initially returns the window passed into
      /// `CreateCoreWebView2Controller`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_parentwindow">See the ICoreWebView2Controller article.</see></para>
      /// <para><see href="https://github.com/salvadordf/WebView4Delphi/issues/13">See the WebView4Delphi issue #13 to know how to reparent a browser.</see></para>
      /// </remarks>
      property ParentWindow                                    : THandle                                               read GetParentWindow                                  write SetParentWindow;
      /// <summary>
      /// The zoom factor for the WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_zoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property ZoomFactor                                      : double                                                read GetZoomFactor                                    write SetZoomFactor;
      /// <summary>
      /// <para>The `DefaultBackgroundColor` property is the color WebView renders
      /// underneath all web content. This means WebView renders this color when
      /// there is no web content loaded such as before the initial navigation or
      /// between navigations. This also means web pages with undefined css
      /// background properties or background properties containing transparent
      /// pixels will render their contents over this color. Web pages with defined
      /// and opaque background properties that span the page will obscure the
      /// `DefaultBackgroundColor` and display normally. The default value for this
      /// property is white to resemble the native browser experience.</para>
      /// <para>The Color is specified by the COREWEBVIEW2_COLOR that represents an RGBA
      /// value. The `A` represents an Alpha value, meaning
      /// `DefaultBackgroundColor` can be transparent. In the case of a transparent
      /// `DefaultBackgroundColor` WebView will render hosting app content as the
      /// background. This Alpha value is not supported on Windows 7. Any `A` value
      /// other than 255 will result in E_INVALIDARG on Windows 7.
      /// It is supported on all other WebView compatible platforms.</para>
      /// <para>Semi-transparent colors are not currently supported by this API and
      /// setting `DefaultBackgroundColor` to a semi-transparent color will fail
      /// with E_INVALIDARG. The only supported alpha values are 0 and 255, all
      /// other values will result in E_INVALIDARG.
      /// `DefaultBackgroundColor` can only be an opaque color or transparent.</para>
      /// <para>This value may also be set by using the
      /// `WEBVIEW2_DEFAULT_BACKGROUND_COLOR` environment variable. There is a
      /// known issue with background color where setting the color by API can
      /// still leave the app with a white flicker before the
      /// `DefaultBackgroundColor` takes effect. Setting the color via environment
      /// variable solves this issue. The value must be a hex value that can
      /// optionally prepend a 0x. The value must account for the alpha value
      /// which is represented by the first 2 digits. So any hex value fewer than 8
      /// digits will assume a prepended 00 to the hex value and result in a
      /// transparent color.</para>
      /// <para>`get_DefaultBackgroundColor` will return the result of this environment
      /// variable if used. This environment variable can only set the
      /// `DefaultBackgroundColor` once. Subsequent updates to background color
      /// must be done through API call.</para>
      /// </summary>
      /// <remarks>
      /// <para>The only supported alpha values are 0 (transparent) and 255 (opaque). Remember to set the alpha channel manually when using predefined TColor values.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller2#get_defaultbackgroundcolor">See the ICoreWebView2Controller2 article.</see></para>
      /// </remarks>
      property DefaultBackgroundColor                          : TColor                                                read GetDefaultBackgroundColor                        write SetDefaultBackgroundColor;
      /// <summary>
      /// <para>BoundsMode affects how setting the Bounds and RasterizationScale
      /// properties work. Bounds mode can either be in COREWEBVIEW2_BOUNDS_MODE_USE_RAW_PIXELS
      /// mode or COREWEBVIEW2_BOUNDS_MODE_USE_RASTERIZATION_SCALE mode.</para>
      /// <para>When the mode is in COREWEBVIEW2_BOUNDS_MODE_USE_RAW_PIXELS, setting the bounds
      /// property will set the size of the WebView in raw screen pixels. Changing
      /// the rasterization scale in this mode won't change the raw pixel size of
      /// the WebView and will only change the rasterization scale.</para>
      /// <para>When the mode is in COREWEBVIEW2_BOUNDS_MODE_USE_RASTERIZATION_SCALE, setting the
      /// bounds property will change the logical size of the WebView which can be
      /// described by the following equation: Logical size * rasterization scale = Raw Pixel size</para>
      /// <para>In this case, changing the rasterization scale will keep the logical size
      /// the same and change the raw pixel size.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller3#get_boundsmode">See the ICoreWebView2Controller3 article.</see></para>
      /// </remarks>
      property BoundsMode                                      : TWVBoundsMode                                         read GetBoundsMode                                    write SetBoundsMode;
      /// <summary>
      /// <para>The rasterization scale for the WebView. The rasterization scale is the
      /// combination of the monitor DPI scale and text scaling set by the user.
      /// This value should be updated when the DPI scale of the app's top level
      /// window changes (i.e. monitor DPI scale changes or window changes monitor)
      /// or when the text scale factor of the system changes.</para>
      /// <para>Rasterization scale applies to the WebView content, as well as
      /// popups, context menus, scroll bars, and so on. Normal app scaling
      /// scenarios should use the ZoomFactor property or SetBoundsAndZoomFactor
      /// API which only scale the rendered HTML content and not popups, context
      /// menus, scroll bars, and so on.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller3#get_rasterizationscale">See the ICoreWebView2Controller3 article.</see></para>
      /// </remarks>
      property RasterizationScale                              : double                                                read GetRasterizationScale                            write SetRasterizationScale;
      /// <summary>
      /// ShouldDetectMonitorScaleChanges property determines whether the WebView
      /// attempts to track monitor DPI scale changes. When true, the WebView will
      /// track monitor DPI scale changes, update the RasterizationScale property,
      /// and raises RasterizationScaleChanged event. When false, the WebView will
      /// not track monitor DPI scale changes, and the app must update the
      /// RasterizationScale property itself. RasterizationScaleChanged event will
      /// never raise when ShouldDetectMonitorScaleChanges is false. Apps that want
      /// to set their own rasterization scale should set this property to false to
      /// avoid the WebView2 updating the RasterizationScale property to match the
      /// monitor DPI scale.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller3#get_shoulddetectmonitorscalechanges">See the ICoreWebView2Controller3 article.</see></para>
      /// </remarks>
      property ShouldDetectMonitorScaleChanges                 : boolean                                               read GetShouldDetectMonitorScaleChanges               write SetShouldDetectMonitorScaleChanges;
      /// <summary>
      /// Gets the `AllowExternalDrop` property which is used to configure the
      /// capability that dragging objects from outside the bounds of webview2 and
      /// dropping into webview2 is allowed or disallowed. The default value is
      /// TRUE.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller4#get_allowexternaldrop">See the ICoreWebView2Controller4 article.</see></para>
      /// </remarks>
      property AllowExternalDrop                               : boolean                                               read GetAllowExternalDrop                             write SetAllowExternalDrop;
      /// <summary>
      /// The `DefaultContextMenusEnabled` property is used to prevent default
      /// context menus from being shown to user in WebView.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_aredefaultcontextmenusenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property DefaultContextMenusEnabled                      : boolean                                               read GetDefaultContextMenusEnabled                    write SetDefaultContextMenusEnabled;
      /// <summary>
      /// `DefaultScriptDialogsEnabled` is used when loading a new HTML
      /// document.  If set to `FALSE`, WebView2 does not render the default JavaScript
      /// dialog box (Specifically those displayed by the JavaScript alert,
      /// confirm, prompt functions and `beforeunload` event).  Instead, if an
      /// event handler is set using `add_ScriptDialogOpening`, WebView sends an
      /// event that contains all of the information for the dialog and allow the
      /// host app to show a custom UI. The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_aredefaultscriptdialogsenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property DefaultScriptDialogsEnabled                     : boolean                                               read GetDefaultScriptDialogsEnabled                   write SetDefaultScriptDialogsEnabled;
      /// <summary>
      /// `DevToolsEnabled` controls whether the user is able to use the context
      /// menu or keyboard shortcuts to open the DevTools window.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_aredevtoolsenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property DevToolsEnabled                                 : boolean                                               read GetDevToolsEnabled                               write SetDevToolsEnabled;
      /// <summary>
      /// The `AreHostObjectsAllowed` property is used to control whether host
      /// objects are accessible from the page in WebView.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_arehostobjectsallowed">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property AreHostObjectsAllowed                           : boolean                                               read GetAreHostObjectsAllowed                         write SetAreHostObjectsAllowed;
      /// <summary>
      /// The `BuiltInErrorPageEnabled` property is used to disable built in
      /// error page for navigation failure and render process failure.  When
      /// disabled, a blank page is displayed when the related error happens.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_isbuiltinerrorpageenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property BuiltInErrorPageEnabled                         : boolean                                               read GetBuiltInErrorPageEnabled                       write SetBuiltInErrorPageEnabled;
      /// <summary>
      /// Controls if running JavaScript is enabled in all future navigations in
      /// the WebView.  This only affects scripts in the document.  Scripts
      /// injected with `ExecuteScript` runs even if script is disabled.
      /// The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_isscriptenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property ScriptEnabled                                   : boolean                                               read GetScriptEnabled                                 write SetScriptEnabled;
      /// <summary>
      /// `StatusBarEnabled` controls whether the status bar is displayed.  The
      /// status bar is usually displayed in the lower left of the WebView and
      /// shows things such as the URI of a link when the user hovers over it and
      /// other information. The default value is `TRUE`. The status bar UI can be
      /// altered by web content and should not be considered secure.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_isstatusbarenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property StatusBarEnabled                                : boolean                                               read GetStatusBarEnabled                              write SetStatusBarEnabled;
      /// <summary>
      /// <para>The `WebMessageEnabled` property is used when loading a new HTML
      /// document.  If set to `TRUE`, communication from the host to the top-level
      ///  HTML document of the WebView is allowed using `PostWebMessageAsJson`,
      /// `PostWebMessageAsString`, and message event of `window.chrome.webview`.
      /// For more information, navigate to PostWebMessageAsJson.  Communication
      /// from the top-level HTML document of the WebView to the host is allowed
      /// using the postMessage function of `window.chrome.webview` and
      /// `add_WebMessageReceived` method.</para>
      /// <para>If set to false, then communication is disallowed.  `PostWebMessageAsJson`
      /// and `PostWebMessageAsString` fails with `E_ACCESSDENIED` and
      /// `window.chrome.webview.postMessage` fails by throwing an instance of an
      /// `Error` object. The default value is `TRUE`.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived">See the add_WebMessageReceived method article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_iswebmessageenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property WebMessageEnabled                               : boolean                                               read GetWebMessageEnabled                             write SetWebMessageEnabled;
      /// <summary>
      /// The `ZoomControlEnabled` property is used to prevent the user from
      /// impacting the zoom of the WebView.  When disabled, the user is not able
      /// to zoom using Ctrl++, Ctrl+-, or Ctrl+mouse wheel, but the zoom
      /// is set using `ZoomFactor` API.  The default value is `TRUE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings#get_iszoomcontrolenabled">See the ICoreWebView2Settings article.</see></para>
      /// </remarks>
      property ZoomControlEnabled                              : boolean                                               read GetZoomControlEnabled                            write SetZoomControlEnabled;
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
      property UserAgent                                       : wvstring                                              read GetUserAgent                                     write SetUserAgent;
      /// <summary>
      /// When this setting is set to FALSE, it disables all accelerator keys that
      /// access features specific to a web browser.
      /// The default value for `AreBrowserAcceleratorKeysEnabled` is TRUE.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings3#get_arebrowseracceleratorkeysenabled">See the ICoreWebView2Settings3 article.</see></para>
      /// </remarks>
      property AreBrowserAcceleratorKeysEnabled                : boolean                                               read GetAreBrowserAcceleratorKeysEnabled              write SetAreBrowserAcceleratorKeysEnabled;
      /// <summary>
      /// <para>IsGeneralAutofillEnabled controls whether autofill for information
      /// like names, street and email addresses, phone numbers, and arbitrary input
      /// is enabled. This excludes password and credit card information. When
      /// IsGeneralAutofillEnabled is false, no suggestions appear, and no new information
      /// is saved. When IsGeneralAutofillEnabled is true, information is saved, suggestions
      /// appear and clicking on one will populate the form fields. It will take effect
      /// immediately after setting. The default value is `TRUE`.</para>
      /// <para>This property has the same value as
      /// `CoreWebView2Profile.IsGeneralAutofillEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsGeneralAutofillEnabled` and
      /// `CoreWebView2Profile.IsGeneralAutofillEnabled` will always have the same
      /// value.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings4#get_isgeneralautofillenabled">See the ICoreWebView2Settings4 article.</see></para>
      /// </remarks>
      property IsGeneralAutofillEnabled                        : boolean                                               read GetIsGeneralAutofillEnabled                      write SetIsGeneralAutofillEnabled;
      /// <summary>
      /// <para>IsPasswordAutosaveEnabled controls whether autosave for password
      /// information is enabled. The IsPasswordAutosaveEnabled property behaves
      /// independently of the IsGeneralAutofillEnabled property. When IsPasswordAutosaveEnabled is
      /// false, no new password data is saved and no Save/Update Password prompts are displayed.
      /// However, if there was password data already saved before disabling this setting,
      /// then that password information is auto-populated, suggestions are shown and clicking on
      /// one will populate the fields.</para>
      /// <para>When IsPasswordAutosaveEnabled is true, password information is auto-populated,
      /// suggestions are shown and clicking on one will populate the fields, new data
      /// is saved, and a Save/Update Password prompt is displayed.
      /// It will take effect immediately after setting. The default value is `FALSE`.</para>
      /// <para>This property has the same value as
      /// `CoreWebView2Profile.IsPasswordAutosaveEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsPasswordAutosaveEnabled` and
      /// `CoreWebView2Profile.IsPasswordAutosaveEnabled` will always have the same
      /// value.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings4#get_ispasswordautosaveenabled">See the ICoreWebView2Settings4 article.</see></para>
      /// </remarks>
      property IsPasswordAutosaveEnabled                       : boolean                                               read GetIsPasswordAutosaveEnabled                     write SetIsPasswordAutosaveEnabled;
      /// <summary>
      /// <para>Pinch-zoom, referred to as "Page Scale" zoom, is performed as a post-rendering step,
      /// it changes the page scale factor property and scales the surface the web page is
      /// rendered onto when user performs a pinch zooming action. It does not change the layout
      /// but rather changes the viewport and clips the web content, the content outside of the
      /// viewport isn't visible onscreen and users can't reach this content using mouse.</para>
      /// <para>The `IsPinchZoomEnabled` property enables or disables the ability of
      /// the end user to use a pinching motion on touch input enabled devices
      /// to scale the web content in the WebView2. It defaults to `TRUE`.
      /// When set to `FALSE`, the end user cannot pinch zoom after the next navigation.
      /// Disabling/Enabling `IsPinchZoomEnabled` only affects the end user's ability to use
      /// pinch motions and does not change the page scale factor.
      /// This API only affects the Page Scale zoom and has no effect on the
      /// existing browser zoom properties (`IsZoomControlEnabled` and `ZoomFactor`)
      /// or other end user mechanisms for zooming.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings5#get_ispinchzoomenabled">See the ICoreWebView2Settings5 article.</see></para>
      /// </remarks>
      property IsPinchZoomEnabled                              : boolean                                               read GetIsPinchZoomEnabled                            write SetIsPinchZoomEnabled;
      /// <summary>
      /// <para>The `IsSwipeNavigationEnabled` property enables or disables the ability of the
      /// end user to use swiping gesture on touch input enabled devices to
      /// navigate in WebView2. It defaults to `TRUE`.</para>
      /// <para>When this property is `TRUE`, then all configured navigation gestures are enabled:
      /// 1. Swiping left and right to navigate forward and backward is always configured.
      /// 2. Swiping down to refresh is off by default and not exposed via our API currently,
      /// it requires the "--pull-to-refresh" option to be included in the additional browser
      /// arguments to be configured. (See put_AdditionalBrowserArguments.)</para>
      /// <para>When set to `FALSE`, the end user cannot swipe to navigate or pull to refresh.
      /// This API only affects the overscrolling navigation functionality and has no
      /// effect on the scrolling interaction used to explore the web content shown
      /// in WebView2.</para>
      /// <para>Disabling/Enabling IsSwipeNavigationEnabled takes effect after the
      /// next navigation.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings6#get_isswipenavigationenabled">See the ICoreWebView2Settings6 article.</see></para>
      /// </remarks>
      property IsSwipeNavigationEnabled                        : boolean                                               read GetIsSwipeNavigationEnabled                      write SetIsSwipeNavigationEnabled;
      /// <summary>
      /// `HiddenPdfToolbarItems` is used to customize the PDF toolbar items. By default, it is COREWEBVIEW2_PDF_TOOLBAR_ITEMS_NONE and so it displays all of the items.
      /// Changes to this property apply to all CoreWebView2s in the same environment and using the same profile.
      /// Changes to this setting apply only after the next navigation.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings7#get_hiddenpdftoolbaritems">See the ICoreWebView2Settings7 article.</see></para>
      /// </remarks>
      property HiddenPdfToolbarItems                           : TWVPDFToolbarItems                                    read GetHiddenPdfToolbarItems                         write SetHiddenPdfToolbarItems;
      /// <summary>
      /// <para>SmartScreen helps webviews identify reported phishing and malware websites
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
      /// folder.</para>
      /// <para>SmartScreen of WebView2 apps can be controlled by Windows system setting
      /// "SmartScreen for Microsoft Edge", specially, for WebView2 in Windows
      /// Store apps, SmartScreen is controlled by another Windows system setting
      /// "SmartScreen for Microsoft Store apps". When the Windows setting is enabled, the
      /// SmartScreen operates under the control of the `IsReputationCheckingRequired`.
      /// When the Windows setting is disabled, the SmartScreen will be disabled
      /// regardless of the `IsReputationCheckingRequired` value set in WebView2 apps.
      /// In other words, under this circumstance the value of
      /// `IsReputationCheckingRequired` will be saved but overridden by system setting.
      /// Upon re-enabling the Windows setting, the CoreWebview2 will reference the
      /// `IsReputationCheckingRequired` to determine the SmartScreen status.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings8#get_isreputationcheckingrequired">See the ICoreWebView2Settings8 article.</see></para>
      /// </remarks>
      property IsReputationCheckingRequired                    : boolean                                               read GetIsReputationCheckingRequired                  write SetIsReputationCheckingRequired;
      /// <summary>
      /// <para>The `IsNonClientRegionSupportEnabled` property enables web pages to use the
      /// `app-region` CSS style. Disabling/Enabling the `IsNonClientRegionSupportEnabled`
      /// takes effect after the next navigation. Defaults to `FALSE`.</para>
      /// <para>When this property is `TRUE`, then all the non-client region features
      /// will be enabled:</para>
      /// <para>Draggable Regions will be enabled, they are regions on a webpage that
      /// are marked with the CSS attribute `app-region: drag/no-drag`. When set to
      /// `drag`, these regions will be treated like the window's title bar, supporting
      /// dragging of the entire WebView and its host app window; the system menu shows
      /// upon right click, and a double click will trigger maximizing/restoration of the
      /// window size.</para>
      /// <para>When set to `FALSE`, all non-client region support will be disabled.
      /// The `app-region` CSS style will be ignored on web pages.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings9#get_isnonclientregionsupportenabled">See the ICoreWebView2Settings9 article.</see></para>
      /// </remarks>
      property IsNonClientRegionSupportEnabled                 : boolean                                               read GetIsNonClientRegionSupportEnabled               write SetIsNonClientRegionSupportEnabled;
      /// <summary>
      /// The current cursor that WebView thinks it should be. The cursor should be
      /// set in WM_SETCURSOR through \::SetCursor or set on the corresponding
      /// parent/ancestor HWND of the WebView through \::SetClassLongPtr. The HCURSOR
      /// can be freed so CopyCursor/DestroyCursor is recommended to keep your own
      /// copy if you are doing more than immediately setting the cursor.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller#get_cursor">See the ICoreWebView2CompositionController article.</see></para>
      /// </remarks>
      property Cursor                                          : HCURSOR                                               read GetCursor;
      /// <summary>
      /// The RootVisualTarget is a visual in the hosting app's visual tree. This
      /// visual is where the WebView will connect its visual tree. The app uses
      /// this visual to position the WebView within the app. The app still needs
      /// to use the Bounds property to size the WebView. The RootVisualTarget
      /// property can be an IDCompositionVisual or a
      /// Windows::UI::Composition::ContainerVisual. WebView will connect its visual
      /// tree to the provided visual before returning from the property setter. The
      /// app needs to commit on its device setting the RootVisualTarget property.
      /// The RootVisualTarget property supports being set to nullptr to disconnect
      /// the WebView from the app's visual tree.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller#get_rootvisualtarget">See the ICoreWebView2CompositionController article.</see></para>
      /// </remarks>
      property RootVisualTarget                                : IUnknown                                              read GetRootVisualTarget                              write SetRootVisualTarget;
      /// <summary>
      /// The current system cursor ID reported by the underlying rendering engine
      /// for WebView. For example, most of the time, when the cursor is over text,
      /// this will return the int value for IDC_IBEAM. The systemCursorId is only
      /// valid if the rendering engine reports a default Windows cursor resource
      /// value. Navigate to
      /// [LoadCursorW](/windows/win32/api/winuser/nf-winuser-loadcursorw) for more
      /// details. Otherwise, if custom CSS cursors are being used, this will return
      /// 0. To actually use systemCursorId in LoadCursor or LoadImage,
      /// MAKEINTRESOURCE must be called on it first.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller#get_systemcursorid">See the ICoreWebView2CompositionController article.</see></para>
      /// </remarks>
      property SystemCursorID                                  : cardinal                                              read GetSystemCursorID;
      /// <summary>
      /// Returns the Automation Provider for the WebView. This object implements
      /// IRawElementProviderSimple.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller2#get_automationprovider">See the ICoreWebView2CompositionController2 article.</see></para>
      /// </remarks>
      property AutomationProvider                              : IUnknown                                              read GetAutomationProvider;
      /// <summary>
      /// Returns the `ICoreWebView2ProcessInfoCollection`. Provide a list of all
      /// process using same user data folder except for crashpad process.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8#getprocessinfos">See the ICoreWebView2Environment8 article.</see></para>
      /// </remarks>
      property ProcessInfos                                    : ICoreWebView2ProcessInfoCollection                    read GetProcessInfos;
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
      property ProfileName                                     : wvstring                                              read GetProfileName                                   write SetProfileName;
      /// <summary>
      /// `IsInPrivateModeEnabled` property is to enable/disable InPrivate mode.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions#get_isinprivatemodeenabled">See the ICoreWebView2ControllerOptions article.</see></para>
      /// </remarks>
      property IsInPrivateModeEnabled                          : boolean                                               read GetIsInPrivateModeEnabled                        write FIsInPrivateModeEnabled;
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
      property ScriptLocale                                    : wvstring                                              read FScriptLocale                                    write FScriptLocale;
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
      property AllowHostInputProcessing                        : boolean                                               read FAllowHostInputProcessing                        write FAllowHostInputProcessing;
      /// <summary>
      /// Full path of the profile directory.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_profilepath">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property ProfilePath                                     : wvstring                                              read GetProfilePath;
      /// <summary>
      /// Gets the `DefaultDownloadFolderPath` property. The default value is the
      /// system default download folder path for the user.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_defaultdownloadfolderpath">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property DefaultDownloadFolderPath                       : wvstring                                              read GetDefaultDownloadFolderPath                     write SetDefaultDownloadFolderPath;
      /// <summary>
      /// <para>The PreferredColorScheme property sets the overall color scheme of the
      /// WebView2s associated with this profile. This sets the color scheme for
      /// WebView2 UI like dialogs, prompts, and context menus by setting the
      /// media feature `prefers-color-scheme` for websites to respond to.</para>
      /// <para>The default value for this is COREWEBVIEW2_PREFERRED_COLOR_AUTO,
      /// which will follow whatever theme the OS is currently set to.</para>
      /// <para>Returns the value of the `PreferredColorScheme` property.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_preferredcolorscheme">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property PreferredColorScheme                            : TWVPreferredColorScheme                               read GetPreferredColorScheme                          write SetPreferredColorScheme;
      /// <summary>
      /// <para>The `PreferredTrackingPreventionLevel` property allows you to control levels of tracking prevention for WebView2
      /// which are associated with a profile. This level would apply to the context of the profile. That is, all WebView2s
      /// sharing the same profile will be affected and also the value is persisted in the user data folder.</para>
      /// <para>See `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL` for descriptions of levels.</para>
      /// <para>If tracking prevention feature is enabled when creating the WebView2 environment, you can also disable tracking
      /// prevention later using this property and `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_NONE` value but that doesn't
      /// improves runtime performance.</para>
      /// <para>There is `ICoreWebView2EnvironmentOptions5.EnableTrackingPrevention` property to enable/disable tracking prevention feature
      /// for all the WebView2's created in the same environment. If enabled, `PreferredTrackingPreventionLevel` is set to
      /// `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED` by default for all the WebView2's and profiles created in the same
      /// environment or is set to the level whatever value was last changed/persisted to the profile. If disabled
      /// `PreferredTrackingPreventionLevel` is not respected by WebView2. If `PreferredTrackingPreventionLevel` is set when the
      /// feature is disabled, the property value get changed and persisted but it will takes effect only if
      /// `ICoreWebView2EnvironmentOptions5.EnableTrackingPrevention` is true.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile3#get_preferredtrackingpreventionlevel">See the ICoreWebView2Profile3 article.</see></para>
      /// </remarks>
      property PreferredTrackingPreventionLevel                : TWVTrackingPreventionLevel                            read GetPreferredTrackingPreventionLevel              write SetPreferredTrackingPreventionLevel;
      /// <summary>
      /// Get the cookie manager for the profile. All CoreWebView2s associated with this
      /// profile share the same cookie values. Changes to cookies in this cookie manager apply to all
      /// CoreWebView2s associated with this profile. See ICoreWebView2CookieManager.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile5#get_cookiemanager">See the ICoreWebView2Profile5 article.</see></para>
      /// </remarks>
      property ProfileCookieManager                            : ICoreWebView2CookieManager                            read GetProfileCookieManager;
      /// <summary>
      /// <para>IsPasswordAutosaveEnabled controls whether autosave for password
      /// information is enabled. The IsPasswordAutosaveEnabled property behaves
      /// independently of the IsGeneralAutofillEnabled property. When IsPasswordAutosaveEnabled is
      /// false, no new password data is saved and no Save/Update Password prompts are displayed.
      /// However, if there was password data already saved before disabling this setting,
      /// then that password information is auto-populated, suggestions are shown and clicking on
      /// one will populate the fields.</para>
      /// <para>When IsPasswordAutosaveEnabled is true, password information is auto-populated,
      /// suggestions are shown and clicking on one will populate the fields, new data
      /// is saved, and a Save/Update Password prompt is displayed.</para>
      /// <para>It will take effect immediately after setting. The default value is `FALSE`.</para>
      /// <para>This property has the same value as
      /// `CoreWebView2Settings.IsPasswordAutosaveEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsPasswordAutosaveEnabled` and
      /// `CoreWebView2Profile.IsPasswordAutosaveEnabled` will always have the same
      /// value.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile6#get_ispasswordautosaveenabled">See the ICoreWebView2Profile6 article.</see></para>
      /// </remarks>
      property ProfileIsPasswordAutosaveEnabled                : boolean                                               read GetProfileIsPasswordAutosaveEnabled              write SetProfileIsPasswordAutosaveEnabled;
      /// <summary>
      /// <para>IsGeneralAutofillEnabled controls whether autofill for information
      /// like names, street and email addresses, phone numbers, and arbitrary input
      /// is enabled. This excludes password and credit card information. When
      /// IsGeneralAutofillEnabled is false, no suggestions appear, and no new information
      /// is saved. When IsGeneralAutofillEnabled is true, information is saved, suggestions
      /// appear and clicking on one will populate the form fields.</para>
      /// <para>It will take effect immediately after setting. The default value is `TRUE`.</para>
      /// <para>This property has the same value as
      /// `CoreWebView2Settings.IsGeneralAutofillEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsGeneralAutofillEnabled` and
      /// `CoreWebView2Profile.IsGeneralAutofillEnabled` will always have the same
      /// value.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile6#get_isgeneralautofillenabled">See the ICoreWebView2Profile6 article.</see></para>
      /// </remarks>
      property ProfileIsGeneralAutofillEnabled                 : boolean                                               read GetProfileIsGeneralAutofillEnabled               write SetProfileIsGeneralAutofillEnabled;
      /// <summary>
      /// The unique identifier of the main frame. It's the same kind of ID as
      /// with the `FrameId` in `ICoreWebView2Frame` and via `ICoreWebView2FrameInfo`.
      /// Note that `FrameId` may not be valid if `ICoreWebView2` has not done
      /// any navigation. It's safe to get this value during or after the first
      /// `ContentLoading` event. Otherwise, it could return the invalid frame Id 0.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_20#get_frameid">See the ICoreWebView2_20 article.</see></para>
      /// </remarks>
      property FrameId                                        : cardinal                                               read GetFrameID;

      /// <summary>
      /// The OnBrowserProcessExited event is triggered when the collection of WebView2
      /// Runtime processes for the browser process of this environment terminate
      /// due to browser process failure or normal shutdown (for example, when all
      /// associated WebViews are closed), after all resources have been released
      /// (including the user data folder).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment5#add_browserprocessexited">See the ICoreWebView2Environment5 article.</see></para>
      /// </remarks>
      property OnBrowserProcessExited                          : TOnBrowserProcessExitedEvent                          read FOnBrowserProcessExited                          write FOnBrowserProcessExited;
      /// <summary>
      /// OnProcessInfosChanged is triggered when the ProcessInfos property has changed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8#add_processinfoschanged">See the ICoreWebView2Environment8 article.</see></para>
      /// </remarks>
      property OnProcessInfosChanged                           : TOnProcessInfosChangedEvent                           read FOnProcessInfosChanged                           write FOnProcessInfosChanged;
      /// <summary>
      /// `OnContainsFullScreenElementChanged` triggers when the
      /// `ContainsFullScreenElement` property changes.  An HTML element inside the
      /// WebView may enter fullscreen to the size of the WebView or leave
      /// fullscreen.  This event is useful when, for example, a video element
      /// requests to go fullscreen.  The listener of
      /// `ContainsFullScreenElementChanged` may resize the WebView in response.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_containsfullscreenelementchanged">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnContainsFullScreenElementChanged              : TNotifyEvent                                          read FOnContainsFullScreenElementChanged              write FOnContainsFullScreenElementChanged;
      /// <summary>
      /// `OnContentLoading` triggers before any content is loaded, including scripts added with
      /// `AddScriptToExecuteOnDocumentCreated`.  `ContentLoading` does not trigger
      /// if a same page navigation occurs (such as through `fragment`
      /// navigations or `history.pushState` navigations).  This operation
      /// follows the `NavigationStarting` and `SourceChanged` events and precedes
      /// the `HistoryChanged` and `NavigationCompleted` events.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_contentloading">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnContentLoading                                : TOnContentLoadingEvent                                read FOnContentLoading                                write FOnContentLoading;
      /// <summary>
      /// `OnDocumentTitleChanged` runs when the `DocumentTitle` property of the
      /// WebView changes and may run before or after the `NavigationCompleted`
      /// event.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_documenttitlechanged">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnDocumentTitleChanged                          : TNotifyEvent                                          read FOnDocumentTitleChanged                          write FOnDocumentTitleChanged;
      /// <summary>
      /// `OnFrameNavigationCompleted` triggers when a child frame has completely
      /// loaded (concurrently when `body.onload` has triggered) or loading stopped with error.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_framenavigationcompleted">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnFrameNavigationCompleted                      : TOnNavigationCompletedEvent                           read FOnFrameNavigationCompleted                      write FOnFrameNavigationCompleted;
      /// <summary>
      /// `OnFrameNavigationStarting` triggers when a child frame in the WebView
      /// requests permission to navigate to a different URI.  Redirects trigger
      /// this operation as well, and the navigation id is the same as the original
      /// one. Navigations will be blocked until all `FrameNavigationStarting` event
      /// handlers return.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_framenavigationstarting">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnFrameNavigationStarting                       : TOnNavigationStartingEvent                            read FOnFrameNavigationStarting                       write FOnFrameNavigationStarting;
      /// <summary>
      /// `OnHistoryChanged` is raised for changes to joint session history, which consists of top-level
      /// and manual frame navigations.  Use `HistoryChanged` to verify that the
      /// `CanGoBack` or `CanGoForward` value has changed.  `HistoryChanged` also
      /// runs for using `GoBack` or `GoForward`.  `HistoryChanged` runs after
      /// `SourceChanged` and `ContentLoading`.  `CanGoBack` is false for
      /// navigations initiated through ICoreWebView2Frame APIs if there has not yet
      /// been a user gesture.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_historychanged">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnHistoryChanged                                : TNotifyEvent                                          read FOnHistoryChanged                                write FOnHistoryChanged;
      /// <summary>
      /// `OnNavigationCompleted` runs when the WebView has completely loaded
      /// (concurrently when `body.onload` runs) or loading stopped with error.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_navigationcompleted">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnNavigationCompleted                           : TOnNavigationCompletedEvent                           read FOnNavigationCompleted                           write FOnNavigationCompleted;
      /// <summary>
      /// `OnNavigationStarting` runs when the WebView main frame is requesting
      /// permission to navigate to a different URI.  Redirects trigger this
      /// operation as well, and the navigation id is the same as the original
      /// one. Navigations will be blocked until all `NavigationStarting` event handlers
      /// return.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_navigationstarting">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnNavigationStarting                            : TOnNavigationStartingEvent                            read FOnNavigationStarting                            write FOnNavigationStarting;
      /// <summary>
      /// <para>`OnNewWindowRequested` runs when content inside the WebView requests to
      /// open a new window, such as through `window.open`.  The app can pass a
      /// target WebView that is considered the opened window or mark the event as
      /// `Handled`, in which case WebView2 does not open a window.
      /// If either `Handled` or `NewWindow` properties are not set, the target
      /// content will be opened on a popup window.</para>
      /// <para>If a deferral is not taken on the event args, scripts that resulted in the
      /// new window that are requested are blocked until the event handler returns.
      /// If a deferral is taken, then scripts are blocked until the deferral is
      /// completed or new window is set.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_newwindowrequested">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnNewWindowRequested                            : TOnNewWindowRequestedEvent                            read FOnNewWindowRequested                            write FOnNewWindowRequested;
      /// <summary>
      /// `OnPermissionRequested` runs when content in a WebView requests permission
      /// to access some privileged resources. If a deferral is not taken on the event
      /// args, the subsequent scripts are blocked until the event handler returns.
      /// If a deferral is taken, the scripts are blocked until the deferral is completed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_permissionrequested">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnPermissionRequested                           : TOnPermissionRequestedEvent                           read FOnPermissionRequested                           write FOnPermissionRequested;
      /// <summary>
      /// <para>`OnProcessFailed` runs when any of the processes in the
      /// [WebView2 Process Group](https://learn.microsoft.com/microsoft-edge/webview2/concepts/process-model?tabs=csharp#processes-in-the-webview2-runtime)
      /// encounters one of the following conditions:</para>
      /// <code>
      /// Condition | Details
      /// ---|---
      /// Unexpected exit | The process indicated by the event args has exited unexpectedly (usually due to a crash). The failure might or might not be recoverable and some failures are auto-recoverable.
      /// Unresponsiveness | The process indicated by the event args has become unresponsive to user input. This is only reported for renderer processes, and will run every few seconds until the process becomes responsive again.
      /// </code>
      /// <para>NOTE: When the failing process is the browser process, a
      /// `ICoreWebView2Environment5.BrowserProcessExited` event will run too.</para>
      /// <para>Your application can use `ICoreWebView2ProcessFailedEventArgs` and
      /// `ICoreWebView2ProcessFailedEventArgs2` to identify which condition and
      /// process the event is for, and to collect diagnostics and handle recovery
      /// if necessary. For more details about which cases need to be handled by
      /// your application, see `COREWEBVIEW2_PROCESS_FAILED_KIND`.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_processfailed">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnProcessFailed                                 : TOnProcessFailedEvent                                 read FOnProcessFailed                                 write FOnProcessFailed;
      /// <summary>
      /// <para>`OnScriptDialogOpening` runs when a JavaScript dialog (`alert`, `confirm`,
      /// `prompt`, or `beforeunload`) displays for the webview.  This event only
      /// triggers if the `ICoreWebView2Settings.AreDefaultScriptDialogsEnabled`
      /// property is set to `FALSE`.  The `ScriptDialogOpening` event suppresses
      /// dialogs or replaces default dialogs with custom dialogs.</para>
      /// <para>If a deferral is not taken on the event args, the subsequent scripts are
      /// blocked until the event handler returns.  If a deferral is taken, the
      /// scripts are blocked until the deferral is completed.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_scriptdialogopening">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnScriptDialogOpening                           : TOnScriptDialogOpeningEvent                           read FOnScriptDialogOpening                           write FOnScriptDialogOpening;
      /// <summary>
      /// `OnSourceChanged` triggers when the `Source` property changes.  `SourceChanged` runs when
      /// navigating to a different site or fragment navigations.  It does not
      /// trigger for other types of navigations such as page refreshes or
      /// `history.pushState` with the same URL as the current page.
      /// `SourceChanged` runs before `ContentLoading` for navigation to a new
      /// document.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_sourcechanged">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnSourceChanged                                 : TOnSourceChangedEvent                                 read FOnSourceChanged                                 write FOnSourceChanged;
      /// <summary>
      /// `OnWebMessageReceived` runs when the `ICoreWebView2Settings.IsWebMessageEnabled`
      /// setting is set and the top-level document of the WebView runs
      /// `window.chrome.webview.postMessage`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnWebMessageReceived                            : TOnWebMessageReceivedEvent                            read FOnWebMessageReceived                            write FOnWebMessageReceived;
      /// <summary>
      /// <para>`OnWebResourceRequested` runs when the WebView is performing a URL request
      /// to a matching URL and resource context and source kind filter that was
      /// added with `AddWebResourceRequestedFilterWithRequestSourceKinds`.
      /// At least one filter must be added for the event to run.</para>
      /// <para>The web resource requested may be blocked until the event handler returns
      /// if a deferral is not taken on the event args.  If a deferral is taken,
      /// then the web resource requested is blocked until the deferral is
      /// completed.</para>
      /// <para>If this event is subscribed in the add_NewWindowRequested handler it should be called
      /// after the new window is set. For more details see `ICoreWebView2NewWindowRequestedEventArgs.put_NewWindow`.</para>
      /// <para>This event is by default raised for file, http, and https URI schemes.
      /// This is also raised for registered custom URI schemes. For more details
      /// see `ICoreWebView2CustomSchemeRegistration`.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_webresourcerequested">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnWebResourceRequested                          : TOnWebResourceRequestedEvent                          read FOnWebResourceRequested                          write FOnWebResourceRequested;
      /// <summary>
      /// `OnWindowCloseRequested` triggers when content inside the WebView
      /// requested to close the window, such as after `window.close` is run.  The
      /// app should close the WebView and related app window if that makes sense
      /// to the app. After the first window.close() call, this event may not fire
      /// for any immediate back to back window.close() calls.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#add_windowcloserequested">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnWindowCloseRequested                          : TNotifyEvent                                          read FOnWindowCloseRequested                          write FOnWindowCloseRequested;
      /// <summary>
      /// OnDOMContentLoaded is raised when the initial html document has been parsed.
      /// This aligns with the document's DOMContentLoaded event in html.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2#add_domcontentloaded">See the ICoreWebView2_2 article.</see></para>
      /// </remarks>
      property OnDOMContentLoaded                              : TOnDOMContentLoadedEvent                              read FOnDOMContentLoaded                              write FOnDOMContentLoaded;
      /// <summary>
      /// OnWebResourceResponseReceived is raised when the WebView receives the
      /// response for a request for a web resource (any URI resolution performed by
      /// the WebView; such as HTTP/HTTPS, file and data requests from redirects,
      /// navigations, declarations in HTML, implicit favicon lookups, and fetch API
      /// usage in the document). The host app can use this event to view the actual
      /// request and response for a web resource. There is no guarantee about the
      /// order in which the WebView processes the response and the host app's
      /// handler runs. The app's handler will not block the WebView from processing
      /// the response.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2#add_webresourceresponsereceived">See the ICoreWebView2_2 article.</see></para>
      /// </remarks>
      property OnWebResourceResponseReceived                   : TOnWebResourceResponseReceivedEvent                   read FOnWebResourceResponseReceived                   write FOnWebResourceResponseReceived;
      /// <summary>
      /// <para>This event is raised when a download has begun, blocking the default download dialog,
      /// but not blocking the progress of the download.</para>
      /// <para>The host can choose to cancel a download, change the result file path,
      /// and hide the default download dialog.</para>
      /// <para>If the host chooses to cancel the download, the download is not saved, no
      /// dialog is shown, and the state is changed to
      /// COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED with interrupt reason
      /// COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_USER_CANCELED. Otherwise, the
      /// download is saved to the default path after the event completes,
      /// and default download dialog is shown if the host did not choose to hide it.
      /// The host can change the visibility of the download dialog using the
      /// `Handled` property. If the event is not handled, downloads complete
      /// normally with the default dialog shown.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_4#add_downloadstarting">See the ICoreWebView2_4 article.</see></para>
      /// </remarks>
      property OnDownloadStarting                              : TOnDownloadStartingEvent                              read FOnDownloadStarting                              write FOnDownloadStarting;
      /// <summary>
      /// Raised when a new iframe is created.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_4#add_framecreated">See the ICoreWebView2_4 article.</see></para>
      /// </remarks>
      property OnFrameCreated                                  : TOnFrameCreatedEvent                                  read FOnFrameCreated                                  write FOnFrameCreated;
      /// <summary>
      /// The OnClientCertificateRequested event is raised when the WebView2
      /// is making a request to an HTTP server that needs a client certificate
      /// for HTTP authentication.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_5#add_clientcertificaterequested">See the ICoreWebView2_5 article.</see></para>
      /// </remarks>
      property OnClientCertificateRequested                    : TOnClientCertificateRequestedEvent                    read FOnClientCertificateRequested                    write FOnClientCertificateRequested;
      /// <summary>
      /// `OnIsDocumentPlayingAudioChanged` is raised when the IsDocumentPlayingAudio property changes value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8#add_isdocumentplayingaudiochanged">See the ICoreWebView2_8 article.</see></para>
      /// </remarks>
      property OnIsDocumentPlayingAudioChanged                 : TOnIsDocumentPlayingAudioChangedEvent                 read FOnIsDocumentPlayingAudioChanged                 write FOnIsDocumentPlayingAudioChanged;
      /// <summary>
      /// `OnIsMutedChanged` is raised when the IsMuted property changes value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8#add_ismutedchanged">See the ICoreWebView2_8 article.</see></para>
      /// </remarks>
      property OnIsMutedChanged                                : TOnIsMutedChangedEvent                                read FOnIsMutedChanged                                write FOnIsMutedChanged;
      /// <summary>
      /// Raised when the `IsDefaultDownloadDialogOpen` property changes. This event
      /// comes after the `DownloadStarting` event. Setting the `Handled` property
      /// on the `DownloadStartingEventArgs` disables the default download dialog
      /// and ensures that this event is never raised.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#add_isdefaultdownloaddialogopenchanged">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      property OnIsDefaultDownloadDialogOpenChanged            : TOnIsDefaultDownloadDialogOpenChangedEvent            read FOnIsDefaultDownloadDialogOpenChanged            write FOnIsDefaultDownloadDialogOpenChanged;
      /// <summary>
      /// <para>Add an event handler for the BasicAuthenticationRequested event.
      /// BasicAuthenticationRequested event is raised when WebView encounters a
      /// Basic HTTP Authentication request as described in
      /// https://developer.mozilla.org/docs/Web/HTTP/Authentication, a Digest
      /// HTTP Authentication request as described in
      /// https://developer.mozilla.org/docs/Web/HTTP/Headers/Authorization#digest,
      /// an NTLM authentication or a Proxy Authentication request.</para>
      /// <para>The host can provide a response with credentials for the authentication or
      /// cancel the request. If the host sets the Cancel property to false but does not
      /// provide either UserName or Password properties on the Response property, then
      /// WebView2 will show the default authentication challenge dialog prompt to
      /// the user.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_10#add_basicauthenticationrequested">See the ICoreWebView2_10 article.</see></para>
      /// </remarks>
      property OnBasicAuthenticationRequested                  : TOnBasicAuthenticationRequestedEvent                  read FOnBasicAuthenticationRequested                  write FOnBasicAuthenticationRequested;
      /// <summary>
      /// `OnContextMenuRequested` event is raised when a context menu is requested by the user
      /// and the content inside WebView hasn't disabled context menus.
      /// The host has the option to create their own context menu with the information provided in
      /// the event or can add items to or remove items from WebView context menu.
      /// If the host doesn't handle the event, WebView will display the default context menu.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_11#add_contextmenurequested">See the ICoreWebView2_11 article.</see></para>
      /// </remarks>
      property OnContextMenuRequested                          : TOnContextMenuRequestedEvent                          read FOnContextMenuRequested                          write FOnContextMenuRequested;
      /// <summary>
      /// `OnStatusBarTextChanged` fires when the WebView is showing a status message,
      /// a URL, or an empty string (an indication to hide the status bar).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_12#add_statusbartextchanged">See the ICoreWebView2_12 article.</see></para>
      /// </remarks>
      property OnStatusBarTextChanged                          : TOnStatusBarTextChangedEvent                          read FOnStatusBarTextChanged                          write FOnStatusBarTextChanged;
      /// <summary>
      /// Event triggered when TWVBrowserBase.ClearServerCertificateErrorActions finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14#clearservercertificateerroractions">See the ICoreWebView2_14 article.</see></para>
      /// </remarks>
      property OnServerCertificateErrorActionsCompleted        : TOnServerCertificateErrorActionsCompletedEvent        read FOnServerCertificateErrorActionsCompleted        write FOnServerCertificateErrorActionsCompleted;
      /// <summary>
      /// <para>The OnServerCertificateErrorDetected event is raised when the WebView2
      /// cannot verify server's digital certificate while loading a web page.</para>
      /// <para>This event will raise for all web resources and follows the `WebResourceRequested` event.</para>
      /// <para>If you don't handle the event, WebView2 will show the default TLS interstitial error page to the user
      /// for navigations, and for non-navigations the web request is cancelled.</para>
      /// <para>Note that WebView2 before raising `OnServerCertificateErrorDetected` raises a `OnNavigationCompleted` event
      /// with `IsSuccess` as FALSE and any of the below WebErrorStatuses that indicate a certificate failure.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14#add_servercertificateerrordetected">See the ICoreWebView2_14 article.</see></para>
      /// </remarks>
      property OnServerCertificateErrorDetected                : TOnServerCertificateErrorDetectedEvent                read FOnServerCertificateErrorDetected                write FOnServerCertificateErrorDetected;
      /// <summary>
      /// The `OnFaviconChanged` event is raised when the
      /// [favicon](https://developer.mozilla.org/docs/Glossary/Favicon)
      /// had a different URL then the previous URL.
      /// The OnFaviconChanged event will be raised for first navigating to a new
      /// document, whether or not a document declares a Favicon in HTML if the
      /// favicon is different from the previous fav icon. The event will
      /// be raised again if a favicon is declared in its HTML or has script
      /// to set its favicon. The favicon information can then be retrieved with
      /// `GetFavicon` and `FaviconUri`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15#add_faviconchanged">See the ICoreWebView2_15 article.</see></para>
      /// </remarks>
      property OnFaviconChanged                                : TOnFaviconChangedEvent                                read FOnFaviconChanged                                write FOnFaviconChanged;
      /// <summary>
      /// The TWVBrowserBase.OnGetFaviconCompleted event is triggered when the TWVBrowserBase.GetFavicon call finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15#getfavicon">See the ICoreWebView2_15 article.</see></para>
      /// </remarks>
      property OnGetFaviconCompleted                           : TOnGetFaviconCompletedEvent                           read FOnGetFaviconCompleted                           write FOnGetFaviconCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnPrintCompleted event is triggered when the TWVBrowserBase.Print call finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16#print">See the ICoreWebView2_16 article.</see></para>
      /// </remarks>
      property OnPrintCompleted                                : TOnPrintCompletedEvent                                read FOnPrintCompleted                                write FOnPrintCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnPrintCompleted event is triggered when the TWVBrowserBase.PrintToPdfStream call finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16#printtopdfstream">See the ICoreWebView2_16 article.</see></para>
      /// </remarks>
      property OnPrintToPdfStreamCompleted                     : TOnPrintToPdfStreamCompletedEvent                     read FOnPrintToPdfStreamCompleted                     write FOnPrintToPdfStreamCompleted;
      /// <summary>
      /// <para>`OnAcceleratorKeyPressed` runs when an accelerator key or key combo is
      /// pressed or released while the WebView is focused.  A key is considered an
      ///  accelerator if either of the following conditions are true.</para>
      /// <para>*   Ctrl or Alt is currently being held.</para>
      /// <para>*   The pressed key does not map to a character.</para>
      /// <para>A few specific keys are never considered accelerators, such as Shift.
      /// The `Escape` key is always considered an accelerator.</para>
      /// <para>Auto-repeated key events caused by holding the key down also triggers
      /// this event.  Filter out the auto-repeated key events by verifying the
      /// `KeyEventLParam` or `PhysicalKeyStatus` event args.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#add_acceleratorkeypressed">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property OnAcceleratorKeyPressed                         : TOnAcceleratorKeyPressedEvent                         read FOnAcceleratorKeyPressed                         write FOnAcceleratorKeyPressed;
      /// <summary>
      /// `OnGotFocus` runs when WebView has focus.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#add_gotfocus">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property OnGotFocus                                      : TNotifyEvent                                          read FOnGotFocus                                      write FOnGotFocus;
      /// <summary>
      /// `OnLostFocus` runs when WebView loses focus.  In the case where `OnMoveFocusRequested` event is
      /// run, the focus is still on WebView when `OnMoveFocusRequested` event runs.
      /// `LostFocus` only runs afterwards when code of the app or default action
      /// of `OnMoveFocusRequested` event set focus away from WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#add_lostfocus">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property OnLostFocus                                     : TNotifyEvent                                          read FOnLostFocus                                     write FOnLostFocus;
      /// <summary>
      /// `OnMoveFocusRequested` runs when user tries to tab out of the WebView.  The
      /// focus of the WebView has not changed when this event is run.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#add_movefocusrequested">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property OnMoveFocusRequested                            : TOnMoveFocusRequestedEvent                            read FOnMoveFocusRequested                            write FOnMoveFocusRequested;
      /// <summary>
      /// `OnZoomFactorChanged` runs when the `ZoomFactor` property of the WebView
      /// changes.  The event may run because the `ZoomFactor` property was
      /// modified, or due to the user manually modifying the zoom.  When it is
      /// modified using the `ZoomFactor` property, the internal zoom factor is
      /// updated immediately and no `OnZoomFactorChanged` event is triggered.
      /// WebView associates the last used zoom factor for each site.  It is
      /// possible for the zoom factor to change when navigating to a different
      /// page.  When the zoom factor changes due to a navigation change, the
      /// `OnZoomFactorChanged` event runs right after the `ContentLoading` event.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#add_zoomfactorchanged">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property OnZoomFactorChanged                             : TNotifyEvent                                          read FOnZoomFactorChanged                             write FOnZoomFactorChanged;
      /// <summary>
      /// The event is raised when the WebView detects that the monitor DPI scale
      /// has changed, ShouldDetectMonitorScaleChanges is true, and the WebView has
      /// changed the RasterizationScale property.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller3#add_rasterizationscalechanged">See the ICoreWebView2Controller3 article.</see></para>
      /// </remarks>
      property OnRasterizationScaleChanged                     : TNotifyEvent                                          read FOnRasterizationScaleChanged                     write FOnRasterizationScaleChanged;
      /// <summary>
      /// <para>The event is raised when WebView thinks the cursor should be changed. For
      /// example, when the mouse cursor is currently the default cursor but is then
      /// moved over text, it may try to change to the IBeam cursor.</para>
      /// <para>It is expected for the developer to send
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE messages (in addition to
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_MOVE messages) through the SendMouseInput
      /// API. This is to ensure that the mouse is actually within the WebView that
      /// sends out CursorChanged events.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller#add_cursorchanged">See the ICoreWebView2CompositionController article.</see></para>
      /// </remarks>
      property OnCursorChanged                                 : TNotifyEvent                                          read FOnCursorChanged                                 write FOnCursorChanged;
      /// <summary>
      /// The event is raised when the number of received bytes for a download operation changes.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#add_bytesreceivedchanged">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property OnBytesReceivedChanged                          : TOnBytesReceivedChangedEvent                          read FOnBytesReceivedChanged                          write FOnBytesReceivedChanged;
      /// <summary>
      /// The event is raised when the estimated end time for a download operation changes.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#add_estimatedendtimechanged">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property OnEstimatedEndTimeChanged                       : TOnEstimatedEndTimeChangedEvent                       read FOnEstimatedEndTimeChanged                       write FOnEstimatedEndTimeChanged;
      /// <summary>
      /// The event is raised when the download operation state changes.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#add_statechanged">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property OnDownloadStateChanged                          : TOnDownloadStateChangedEvent                          read FOnDownloadStateChanged                          write FOnDownloadStateChanged;
      /// <summary>
      /// The OnFrameDestroyed event is raised when the iframe corresponding
      /// to this CoreWebView2Frame object is removed or the document
      /// containing that iframe is destroyed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame#add_destroyed">See the ICoreWebView2Frame article.</see></para>
      /// </remarks>
      property OnFrameDestroyed                                : TOnFrameDestroyedEvent                                read FOnFrameDestroyed                                write FOnFrameDestroyed;
      /// <summary>
      /// Raised when the iframe changes its window.name property.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame#add_namechanged">See the ICoreWebView2Frame article.</see></para>
      /// </remarks>
      property OnFrameNameChanged                              : TOnFrameNameChangedEvent                              read FOnFrameNameChanged                              write FOnFrameNameChanged;
      /// <summary>
      /// <para>A frame navigation will raise a `OnFrameNavigationStarting2` event and
      /// a `OnFrameNavigationStarting` event. All of the
      /// `FrameNavigationStarting` event handlers for the current frame will be
      /// run before the `OnFrameNavigationStarting2` event handlers. All of the event handlers
      /// share a common `NavigationStartingEventArgs` object. Whichever event handler is
      /// last to change the `NavigationStartingEventArgs.Cancel` property will
      /// decide if the frame navigation will be cancelled. Redirects raise this
      /// event as well, and the navigation id is the same as the original one.</para>
      /// <para>Navigations will be blocked until all `OnFrameNavigationStarting2` and
      /// `OnFrameNavigationStarting` event handlers return.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#add_navigationstarting">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      property OnFrameNavigationStarting2                      : TOnFrameNavigationStartingEvent                       read FOnFrameNavigationStarting2                      write FOnFrameNavigationStarting2;
      /// <summary>
      /// `OnFrameNavigationCompleted2` runs when the CoreWebView2Frame has completely
      /// loaded (concurrently when `body.onload` runs) or loading stopped with error.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#add_navigationcompleted">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      property OnFrameNavigationCompleted2                     : TOnFrameNavigationCompletedEvent                      read FOnFrameNavigationCompleted2                     write FOnFrameNavigationCompleted2;
      /// <summary>
      /// `OnFrameContentLoading` triggers before any content is loaded, including scripts added with
      /// `AddScriptToExecuteOnDocumentCreated`.  `OnFrameContentLoading` does not trigger
      /// if a same page navigation occurs (such as through `fragment`
      /// navigations or `history.pushState` navigations).  This operation
      /// follows the `OnFrameNavigationStarting2` and precedes `OnFrameNavigationCompleted2` events.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#add_contentloading">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      property OnFrameContentLoading                           : TOnFrameContentLoadingEvent                           read FOnFrameContentLoading                           write FOnFrameContentLoading;
      /// <summary>
      /// OnFrameDOMContentLoaded is raised when the iframe html document has been parsed.
      /// This aligns with the document's DOMContentLoaded event in html.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#add_domcontentloaded">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      property OnFrameDOMContentLoaded                         : TOnFrameDOMContentLoadedEvent                         read FOnFrameDOMContentLoaded                         write FOnFrameDOMContentLoaded;
      /// <summary>
      /// `OnFrameWebMessageReceived` runs when the
      /// `ICoreWebView2Settings.IsWebMessageEnabled` setting is set and the
      /// frame document runs `window.chrome.webview.postMessage`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#add_webmessagereceived">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      property OnFrameWebMessageReceived                       : TOnFrameWebMessageReceivedEvent                       read FOnFrameWebMessageReceived                       write FOnFrameWebMessageReceived;
      /// <summary>
      /// <para>`OnFramePermissionRequested` is raised when content in an iframe any of its
      /// descendant iframes requests permission to privileged resources.</para>
      /// <para>This relates to the `OnPermissionRequested` event on the `CoreWebView2`.
      /// Both these events will be raised in the case of an iframe requesting
      /// permission. The `CoreWebView2Frame`'s event handlers will be invoked
      /// before the event handlers on the `CoreWebView2`. If the `Handled` property
      /// of the `PermissionRequestedEventArgs` is set to TRUE within the
      /// `CoreWebView2Frame` event handler, then the event will not be
      /// raised on the `CoreWebView2`, and it's event handlers will not be invoked.</para>
      /// <para>In the case of nested iframes, if the `PermissionRequested` event is handled
      /// in the current nested iframe (i.e., the Handled property of the
      /// `PermissionRequestedEventArgs` is set to TRUE), the event will not be raised
      /// on the parent `CoreWebView2Frame`. However, if the `PermissionRequested` event is
      /// not handled in that nested iframe, the event will be raised from its nearest
      /// tracked parent `CoreWebView2Frame`. It will iterate through the parent frame
      /// chain up to the main frame until a parent frame handles the request.</para>
      /// <para>If a deferral is not taken on the event args, the subsequent scripts are
      /// blocked until the event handler returns.  If a deferral is taken, the
      /// scripts are blocked until the deferral is completed.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame3#add_permissionrequested">See the ICoreWebView2Frame3 article.</see></para>
      /// </remarks>
      property OnFramePermissionRequested                      : TOnFramePermissionRequestedEvent                      read FOnFramePermissionRequested                      write FOnFramePermissionRequested;
      /// <summary>
      /// OnDevToolsProtocolEventReceived is triggered when a DevTools protocol
      /// event runs. It's necessary to subscribe to that event with a
      /// SubscribeToDevToolsProtocolEvent call.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceiver#add_devtoolsprotocoleventreceived">See the ICoreWebView2DevToolsProtocolEventReceiver article.</see></para>
      /// </remarks>
      property OnDevToolsProtocolEventReceived                 : TOnDevToolsProtocolEventReceivedEvent                 read FOnDevToolsProtocolEventReceived                 write FOnDevToolsProtocolEventReceived;
      /// <summary>
      /// `OnCustomItemSelected` event is raised when the user selects a custom `ContextMenuItem`.
      /// Will only be raised for end developer created context menu items.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#add_customitemselected">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property OnCustomItemSelected                            : TOnCustomItemSelectedEvent                            read FOnCustomItemSelected                            write FOnCustomItemSelected;
      /// <summary>
      /// This event is triggered when the TWVBrowserBase.ClearBrowsingData call finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2#clearbrowsingdata">See the ICoreWebView2Profile2 article.</see></para>
      /// </remarks>
      property OnClearBrowsingDataCompleted                    : TOnClearBrowsingDataCompletedEvent                    read FOnClearBrowsingDataCompleted                    write FOnClearBrowsingDataCompleted;

      /// <summary>
      /// Called if any of the browser initialization steps fail.
      /// </summary>
      property OnInitializationError                           : TOnInitializationErrorEvent                           read FOnInitializationError                           write FOnInitializationError;
      /// <summary>
      /// Called when the environment was created successfully.
      /// </summary>
      property OnEnvironmentCompleted                          : TNotifyEvent                                          read FOnEnvironmentCompleted                          write FOnEnvironmentCompleted;
      /// <summary>
      /// Called when the controller was created successfully.
      /// </summary>
      property OnControllerCompleted                           : TNotifyEvent                                          read FOnControllerCompleted                           write FOnControllerCompleted;
      /// <summary>
      /// Called after a new browser is created and it's ready to navigate to the default URL.
      /// </summary>
      property OnAfterCreated                                  : TNotifyEvent                                          read FOnAfterCreated                                  write FOnAfterCreated;
      /// <summary>
      /// Triggered when a TWVBrowserBase.ExecuteScript call finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#executescript">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnExecuteScriptCompleted                        : TOnExecuteScriptCompletedEvent                        read FOnExecuteScriptCompleted                        write FOnExecuteScriptCompleted;
      /// <summary>
      /// Triggered when a TWVBrowserBase.CapturePreview call finishes writting the image to the stream.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#capturepreview">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnCapturePreviewCompleted                       : TOnCapturePreviewCompletedEvent                       read FOnCapturePreviewCompleted                       write FOnCapturePreviewCompleted;
      /// <summary>
      /// Triggered when a TWVBrowserBase.GetCookies call finishes executing. This event includes the requested cookies.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager#getcookies">See the ICoreWebView2CookieManager article.</see></para>
      /// </remarks>
      property OnGetCookiesCompleted                           : TOnGetCookiesCompletedEvent                           read FOnGetCookiesCompleted                           write FOnGetCookiesCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnTrySuspendCompleted event is triggered when a TWVBrowserBase.TrySuspend call finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3#trysuspend">See the ICoreWebView2_3 article.</see></para>
      /// </remarks>
      property OnTrySuspendCompleted                           : TOnTrySuspendCompletedEvent                           read FOnTrySuspendCompleted                           write FOnTrySuspendCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnPrintToPdfCompleted event is triggered when the TWVBrowserBase.PrintToPdf call finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_7#printtopdf">See the ICoreWebView2_7 article.</see></para>
      /// </remarks>
      property OnPrintToPdfCompleted                           : TOnPrintToPdfCompletedEvent                           read FOnPrintToPdfCompleted                           write FOnPrintToPdfCompleted;
      /// <summary>
      /// Called when the composition controller was created successfully.
      /// </summary>
      property OnCompositionControllerCompleted                : TNotifyEvent                                          read FOnCompositionControllerCompleted                write FOnCompositionControllerCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnCallDevToolsProtocolMethodCompleted event is triggered
      /// when TWVBrowserBase.CallDevToolsProtocolMethod finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#calldevtoolsprotocolmethod">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnCallDevToolsProtocolMethodCompleted           : TOnCallDevToolsProtocolMethodCompletedEvent           read FOnCallDevToolsProtocolMethodCompleted           write FOnCallDevToolsProtocolMethodCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnAddScriptToExecuteOnDocumentCreatedCompleted event is triggered
      /// when TWVBrowserBase.AddScriptToExecuteOnDocumentCreated finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#addscripttoexecuteondocumentcreated">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property OnAddScriptToExecuteOnDocumentCreatedCompleted  : TOnAddScriptToExecuteOnDocumentCreatedCompletedEvent  read FOnAddScriptToExecuteOnDocumentCreatedCompleted  write FOnAddScriptToExecuteOnDocumentCreatedCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnWebResourceResponseViewGetContentCompleted event is triggered
      /// when TCoreWebView2WebResourceResponseView.GetContent finishes executing. This event includes the resource contents.
      /// </summary>
      /// <remarks>
      /// <para>See the MiniBrowser demo for an example.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseview#getcontent">See the ICoreWebView2WebResourceResponseView article.</see></para>
      /// </remarks>
      property OnWebResourceResponseViewGetContentCompleted    : TOnWebResourceResponseViewGetContentCompletedEvent    read FOnWebResourceResponseViewGetContentCompleted    write FOnWebResourceResponseViewGetContentCompleted;
      /// <summary>
      /// Event triggered when the window called 'Chrome_WidgetWin_0' receives a message.
      /// </summary>
      property OnWidget0CompMsg                                : TOnCompMsgEvent                                       read FOnWidget0CompMsg                                write FOnWidget0CompMsg;
      /// <summary>
      /// Event triggered when the window called 'Chrome_WidgetWin_1' receives a message.
      /// </summary>
      property OnWidget1CompMsg                                : TOnCompMsgEvent                                       read FOnWidget1CompMsg                                write FOnWidget1CompMsg;
      /// <summary>
      /// Event triggered when the window called 'Chrome_RenderWidgetHostHWND' receives a message.
      /// </summary>
      property OnRenderCompMsg                                 : TOnCompMsgEvent                                       read FOnRenderCompMsg                                 write FOnRenderCompMsg;
      /// <summary>
      /// Event triggered when the window called 'Intermediate D3D Window' receives a message.
      /// </summary>
      property OnD3DWindowCompMsg                              : TOnCompMsgEvent                                       read FOnD3DWindowCompMsg                              write FOnD3DWindowCompMsg;
      /// <summary>
      /// The TWVBrowserBase.OnRetrieveHTMLCompleted event is triggered when TWVBrowserBase.RetrieveHTML finishes executing. It includes the HTML contents.
      /// </summary>
      property OnRetrieveHTMLCompleted                         : TOnRetrieveHTMLCompletedEvent                         read FOnRetrieveHTMLCompleted                         write FOnRetrieveHTMLCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnRetrieveTextCompleted event is triggered when TWVBrowserBase.RetrieveText finishes executing. It includes the text contents.
      /// </summary>
      property OnRetrieveTextCompleted                         : TOnRetrieveTextCompletedEvent                         read FOnRetrieveTextCompleted                         write FOnRetrieveTextCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnRetrieveMHTMLCompleted event is triggered when TWVBrowserBase.RetrieveMHTML finishes executing. It includes the MHTML contents.
      /// </summary>
      property OnRetrieveMHTMLCompleted                        : TOnRetrieveMHTMLCompletedEvent                        read FOnRetrieveMHTMLCompleted                        write FOnRetrieveMHTMLCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnClearCacheCompleted event is triggered when TWVBrowserBase.ClearCache finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Network/#method-clearBrowserCache">See the Chrome DevTools Protocol page about the Network.clearBrowserCache method.</see></para>
      /// </remarks>
      property OnClearCacheCompleted                           : TOnClearCacheCompletedEvent                           read FOnClearCacheCompleted                           write FOnClearCacheCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnClearDataForOriginCompleted event is triggered when TWVBrowserBase.ClearDataForOrigin finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Storage/#method-clearDataForOrigin">See the Chrome DevTools Protocol page about the Storage.clearDataForOrigin method.</see></para>
      /// </remarks>
      property OnClearDataForOriginCompleted                   : TOnClearDataForOriginCompletedEvent                   read FOnClearDataForOriginCompleted                   write FOnClearDataForOriginCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnOfflineCompleted event is triggered after setting the TWVBrowserBase.Offline property.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Network/#method-emulateNetworkConditions">See the Network Domain article.</see></para>
      /// </remarks>
      property OnOfflineCompleted                              : TOnOfflineCompletedEvent                              read FOnOfflineCompleted                              write FOnOfflineCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnIgnoreCertificateErrorsCompleted event is triggered after setting the TWVBrowserBase.IgnoreCertificateErrors property.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Security/#method-setIgnoreCertificateErrors">See the Security Domain article.</see></para>
      /// </remarks>
      property OnIgnoreCertificateErrorsCompleted              : TOnIgnoreCertificateErrorsCompletedEvent              read FOnIgnoreCertificateErrorsCompleted              write FOnIgnoreCertificateErrorsCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnRefreshIgnoreCacheCompleted event is triggered when TWVBrowserBase.RefreshIgnoreCache finishes executing.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/tot/Page/#method-reload">See the Page Domain article.</see></para>
      /// </remarks>
      property OnRefreshIgnoreCacheCompleted                   : TOnRefreshIgnoreCacheCompletedEvent                   read FOnRefreshIgnoreCacheCompleted                   write FOnRefreshIgnoreCacheCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnSimulateKeyEventCompleted event is triggered when TWVBrowserBase.SimulateKeyEvent or TWVBrowserBase.SimulateEditingCommand finish executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent">See the "Input.dispatchKeyEvent" DevTools method.</see></para>
      /// </remarks>
      property OnSimulateKeyEventCompleted                     : TOnSimulateKeyEventCompletedEvent                     read FOnSimulateKeyEventCompleted                     write FOnSimulateKeyEventCompleted;
      /// <summary>
      /// <para>OnGetCustomSchemes is triggered automatically before creaing the environment to register custom schemes.</para>
      /// <para>Fill the aCustomSchemes event parameter with all the information to create one or more
      /// ICoreWebView2CustomSchemeRegistration instances that will be used during the creation of the Environment.</para>
      /// </summary>
      /// <remarks>
      /// <para><see cref="uWVTypes|TWVCustomSchemeInfo">See TWVCustomSchemeInfo.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customschemeregistration">See the ICoreWebView2CustomSchemeRegistration article.</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions4">See the ICoreWebView2EnvironmentOptions4 article.</see></para>
      /// </remarks>
      property OnGetCustomSchemes                              : TOnGetCustomSchemesEvent                              read FOnGetCustomSchemes                              write FOnGetCustomSchemes;
      /// <summary>
      /// The TWVBrowserBase.OnGetNonDefaultPermissionSettingsCompleted event is triggered when TWVBrowserBase.GetNonDefaultPermissionSettings finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile4#getnondefaultpermissionsettings">See the ICoreWebView2Profile4 article.</see></para>
      /// </remarks>
      property OnGetNonDefaultPermissionSettingsCompleted      : TOnGetNonDefaultPermissionSettingsCompletedEvent      read FOnGetNonDefaultPermissionSettingsCompleted      write FOnGetNonDefaultPermissionSettingsCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnSetPermissionStateCompleted event is triggered when TWVBrowserBase.SetPermissionState finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile4#setpermissionstate">See the ICoreWebView2Profile4 article.</see></para>
      /// </remarks>
      property OnSetPermissionStateCompleted                   : TOnSetPermissionStateCompletedEvent                   read FOnSetPermissionStateCompleted                   write FOnSetPermissionStateCompleted;
      /// <summary>
      /// <para>The `OnLaunchingExternalUriScheme` event is raised when a navigation request is made to
      /// a URI scheme that is registered with the OS.</para>
      ///
      /// <para>The `OnLaunchingExternalUriScheme` event handler may suppress the default dialog
      /// or replace the default dialog with a custom dialog.</para>
      ///
      /// <para>If a deferral is not taken on the event args, the external URI scheme launch is
      /// blocked until the event handler returns.  If a deferral is taken, the
      /// external URI scheme launch is blocked until the deferral is completed.
      /// The host also has the option to cancel the URI scheme launch.</para>
      ///
      /// <para>The `OnNavigationStarting` and `OnNavigationCompleted` events will be raised,
      /// regardless of whether the `Cancel` property is set to `TRUE` or
      /// `FALSE`. The `OnNavigationCompleted` event will be raised with the `IsSuccess` property
      /// set to `FALSE` and the `WebErrorStatus` property set to `ConnectionAborted` regardless of
      /// whether the host sets the `Cancel` property on the
      /// `ICoreWebView2LaunchingExternalUriSchemeEventArgs`. The `OnSourceChanged`, `OnContentLoading`,
      /// and `OnHistoryChanged` events will not be raised for this navigation to the external URI
      /// scheme regardless of the `Cancel` property.</para>
      ///
      /// <para>The `OnLaunchingExternalUriScheme` event will be raised after the
      /// `OnNavigationStarting` event and before the `OnNavigationCompleted` event.</para>
      ///
      /// <para>The default `CoreWebView2Settings` will also be updated upon navigation to an external
      /// URI scheme. If a setting on the `CoreWebView2Settings` interface has been changed,
      /// navigating to an external URI scheme will trigger the `CoreWebView2Settings` to update.</para>
      ///
      /// <para>The WebView2 may not display the default dialog based on user settings, browser settings,
      /// and whether the origin is determined as a
      /// [trustworthy origin](https://w3c.github.io/webappsec-secure-contexts#
      /// potentially-trustworthy-origin); however, the event will still be raised.</para>
      ///
      /// <para>If the request is initiated by a cross-origin frame without a user gesture,
      /// the request will be blocked and the `OnLaunchingExternalUriScheme` event will not
      /// be raised.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_18#add_launchingexternalurischeme">See the ICoreWebView2_18 article.</see></para>
      /// </remarks>
      property OnLaunchingExternalUriScheme                    : TOnLaunchingExternalUriSchemeEvent                    read FOnLaunchingExternalUriScheme                    write FOnLaunchingExternalUriScheme;
      /// <summary>
      /// The TWVBrowserBase.OnGetProcessExtendedInfosCompleted event is triggered when TWVBrowserBase.GetProcessExtendedInfos finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment13#getprocessextendedinfos">See the ICoreWebView2Environment13 article.</see></para>
      /// </remarks>
      property OnGetProcessExtendedInfosCompleted              : TOnGetProcessExtendedInfosCompletedEvent              read FOnGetProcessExtendedInfosCompleted              write FOnGetProcessExtendedInfosCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnBrowserExtensionRemoveCompleted event is triggered when TCoreWebView2BrowserExtension.Remove finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextension#remove">See the ICoreWebView2BrowserExtension article.</see></para>
      /// </remarks>
      property OnBrowserExtensionRemoveCompleted               : TOnBrowserExtensionRemoveCompletedEvent               read FOnBrowserExtensionRemoveCompleted               write FOnBrowserExtensionRemoveCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnBrowserExtensionEnableCompleted event is triggered when TCoreWebView2BrowserExtension.Enable finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextension#enable">See the ICoreWebView2BrowserExtension article.</see></para>
      /// </remarks>
      property OnBrowserExtensionEnableCompleted               : TOnBrowserExtensionEnableCompletedEvent               read FOnBrowserExtensionEnableCompleted               write FOnBrowserExtensionEnableCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnProfileAddBrowserExtensionCompleted event is triggered when TWVBrowserBase.AddBrowserExtension finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile7#addbrowserextension">See the ICoreWebView2Profile7 article.</see></para>
      /// </remarks>
      property OnProfileAddBrowserExtensionCompleted           : TOnProfileAddBrowserExtensionCompletedEvent           read FOnProfileAddBrowserExtensionCompleted           write FOnProfileAddBrowserExtensionCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnProfileGetBrowserExtensionsCompleted event is triggered when TWVBrowserBase.GetBrowserExtensions finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile7#getbrowserextensions">See the ICoreWebView2Profile7 article.</see></para>
      /// </remarks>
      property OnProfileGetBrowserExtensionsCompleted          : TOnProfileGetBrowserExtensionsCompletedEvent          read FOnProfileGetBrowserExtensionsCompleted          write FOnProfileGetBrowserExtensionsCompleted;
      /// <summary>
      /// The TWVBrowserBase.OnProfileDeleted event is triggered when TWVBrowserBase.Delete finishes executing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile8#delete">See the ICoreWebView2Profile8 article.</see></para>
      /// </remarks>
      property OnProfileDeleted                                : TOnProfileDeletedEvent                                read FOnProfileDeleted                                write FOnProfileDeleted;
      /// <summary>
      /// Provides the result of ExecuteScriptWithResult.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_21#executescriptwithresult">See the ICoreWebView2_21 article.</see></para>
      /// </remarks>
      property OnExecuteScriptWithResultCompleted              : TOnExecuteScriptWithResultCompletedEvent              read FOnExecuteScriptWithResultCompleted              write FOnExecuteScriptWithResultCompleted;
      /// <summary>
      /// This event is fired when regions which are marked as non-client in the
      /// app html have changed. So either when new regions have been marked,
      /// or unmarked, or the region(s) have been changed to a different kind.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller4#add_nonclientregionchanged">See the ICoreWebView2CompositionController4 article.</see></para>
      /// </remarks>
      property OnNonClientRegionChanged                        : TOnNonClientRegionChangedEvent                        read FOnNonClientRegionChanged                        write FOnNonClientRegionChanged;
      /// <summary>
      /// <para>Event for non-persistent notifications.</para>
      ///
      /// <para>If a deferral is not taken on the event args, the subsequent scripts after
      /// the DOM notification creation call (i.e. `Notification()`) are blocked
      /// until the event handler returns. If a deferral is taken, the scripts are
      /// blocked until the deferral is completed.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_24#add_notificationreceived">See the ICoreWebView2_24 article.</see></para>
      /// </remarks>
      property OnNotificationReceived                          : TOnNotificationReceivedEvent                          read FOnNotificationReceived                          write FOnNotificationReceived;
      /// <summary>
      /// This event is raised when the notification is closed by the web code, such as through
      /// `notification.close()`. You don't need to call `ReportClosed` since this is
      /// coming from the web code.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification#add_closerequested">See the ICoreWebView2Notification article.</see></para>
      /// </remarks>
      property OnNotificationCloseRequested                    : TOnNotificationCloseRequestedEvent                    read FOnNotificationCloseRequested                    write FOnNotificationCloseRequested;
      /// <summary>
      /// This event is raised when save as is triggered, programmatically or manually.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25#add_saveasuishowing">See the ICoreWebView2_25 article.</see></para>
      /// </remarks>
      property OnSaveAsUIShowing                               : TOnSaveAsUIShowingEvent                               read FOnSaveAsUIShowing                               write FOnSaveAsUIShowing;
      /// <summary>
      /// This event receives the result of the `ShowSaveAsUI` method.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25#showsaveasui">See the ICoreWebView2_25 article.</see></para>
      /// </remarks>
      property OnShowSaveAsUICompleted                        : TOnShowSaveAsUICompletedEvent                          read FOnShowSaveAsUICompleted                         write FOnShowSaveAsUICompleted;
      /// <summary>
      /// <para>This event will be raised during system FileTypePolicy
      /// checking the dangerous file extension list.</para>
      /// <para>Developers can specify their own logic for determining whether
      /// to allow a particular type of file to be saved from the document origin URI.
      /// Developers can also determine the save decision based on other criteria.</para>
      /// <para>Here are two properties in `ICoreWebView2SaveFileSecurityCheckStartingEventArgs`
      /// to manage the decision: `CancelSave` and `SuppressDefaultPolicy`.</para>
      /// <para>Table of Properties' value and result:</para>
      /// <code>
      /// | CancelSave | SuppressDefaultPolicy | Result
      /// | ---------- | ------ | ---------------------
      /// | False      | False  | Perform the default policy check. It may show the
      /// |            |        | security warning UI if the file extension is
      /// |            |        | dangerous.
      /// | ---------- | ------ | ---------------------
      /// | False      | True   | Skip the default policy check and the possible
      /// |            |        | security warning. Start saving or downloading.
      /// | ---------- | ------ | ---------------------
      /// | True       | Any    | Skip the default policy check and the possible
      /// |            |        | security warning. Abort save or download.
      /// </code>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_26#add_savefilesecuritycheckstarting">See the ICoreWebView2_26 article.</see></para>
      /// <para><see href="https://github.com/MicrosoftEdge/WebView2Feedback/blob/main/specs/FileTypePolicy.md">See the FileTypePolicy API article.</see></para>
      /// </remarks>
      property OnSaveFileSecurityCheckStarting                : TOnSaveFileSecurityCheckStartingEvent                  read FOnSaveFileSecurityCheckStarting                 write FOnSaveFileSecurityCheckStarting;
      /// <summary>
      /// `OnScreenCaptureStarting` event is raised when the [Screen Capture API](https://www.w3.org/TR/screen-capture/)
      /// is requested by the user using getDisplayMedia().
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_27#add_screencapturestarting">See the ICoreWebView2_27 article.</see></para>
      /// </remarks>
      property OnScreenCaptureStarting                        : TOnScreenCaptureStartingEvent                          read FOnScreenCaptureStarting                         write FOnScreenCaptureStarting;
      /// <summary>
      /// <para>`OnFrameScreenCaptureStarting` is raised when content in an iframe or any of its
      /// descendant iframes requests permission to use the Screen Capture
      /// API from getDisplayMedia().</para>
      ///
      /// <para>This relates to the `ScreenCaptureStarting` event on the
      /// `CoreWebView2`.</para>
      /// <para>Both these events will be raised in the case of an iframe requesting
      /// screen capture. The `CoreWebView2Frame`'s event handlers will be invoked
      /// before the event handlers on the `CoreWebView2`. If the `Handled`
      /// property of the `ScreenCaptureStartingEventArgs` is set to TRUE
      /// within the`CoreWebView2Frame` event handler, then the event will not
      /// be raised on the `CoreWebView2`, and its event handlers will not be
      /// invoked.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame6#add_screencapturestarting">See the ICoreWebView2Frame6 article.</see></para>
      /// </remarks>
      property OnFrameScreenCaptureStarting                   : TOnFrameScreenCaptureStartingEvent                     read FOnFrameScreenCaptureStarting                    write FOnFrameScreenCaptureStarting;
      /// <summary>
      /// Raised when a new direct descendant iframe is created.
      /// Handle this event to get access to ICoreWebView2Frame objects.
      /// Use `OnFrameDestroyed` to listen for when this iframe goes away.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame7">See the ICoreWebView2Frame7 article.</see></para>
      /// </remarks>
      property OnFrameChildFrameCreated                       : TOnFrameChildFrameCreatedEvent                         read FOnFrameChildFrameCreated                        write FOnFrameChildFrameCreated;
  end;

implementation

uses
  uWVMiscFunctions, uWVCoreWebView2EnvironmentOptions, uWVCoreWebView2ControllerOptions,
  uWVCoreWebView2CustomSchemeRegistration;

constructor TWVBrowserBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCoreWebView2PrintSettings                       := nil;
  FCoreWebView2Settings                            := nil;
  FCoreWebView2Environment                         := nil;
  FCoreWebView2Controller                          := nil;
  FCoreWebView2CompositionController               := nil;
  FCoreWebView2                                    := nil;
  FCoreWebView2Profile                             := nil;
  FDefaultURL                                      := '';
  FUseDefaultEnvironment                           := False;
  FUseCompositionController                        := False;
  FZoomStep                                        := ZOOM_STEP_DEF;
  FOffline                                         := False;
  FIsNavigating                                    := False;
  FProfileName                                     := '';
  FIsInPrivateModeEnabled                          := False;
  FScriptLocale                                    := '';
  FDefaultBackgroundColor                          := TColor($FFFFFFFF); // opaque white
  FAllowHostInputProcessing                        := False;
  FClearBrowsingDataCompletedHandler               := nil;
  FSetPermissionStateCompletedHandler              := nil;
  FGetNonDefaultPermissionSettingsCompletedHandler := nil;
  FProfileAddBrowserExtensionCompletedHandler      := nil;
  FProfileGetBrowserExtensionsCompletedHandler     := nil;

  // Fields used to create the environment
  FAdditionalBrowserArguments                      := '';
  FLanguage                                        := '';
  FTargetCompatibleBrowserVersion                  := LowestChromiumVersion;
  FAllowSingleSignOnUsingOSPrimaryAccount          := False;
  FExclusiveUserDataFolderAccess                   := False;
  FCustomCrashReportingEnabled                     := False;
  FEnableTrackingPrevention                        := True;
  FAreBrowserExtensionsEnabled                     := False;
  FChannelSearchKind                               := COREWEBVIEW2_CHANNEL_SEARCH_KIND_MOST_STABLE;
  FReleaseChannels                                 := COREWEBVIEW2_RELEASE_CHANNELS_STABLE or
                                                      COREWEBVIEW2_RELEASE_CHANNELS_BETA or
                                                      COREWEBVIEW2_RELEASE_CHANNELS_DEV or
                                                      COREWEBVIEW2_RELEASE_CHANNELS_CANARY;
  FScrollBarStyle                                  := COREWEBVIEW2_SCROLLBAR_STYLE_DEFAULT;

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
  FOnGetNonDefaultPermissionSettingsCompleted      := nil;
  FOnSetPermissionStateCompleted                   := nil;
  FOnLaunchingExternalUriScheme                    := nil;
  FOnGetProcessExtendedInfosCompleted              := nil;
  FOnBrowserExtensionRemoveCompleted               := nil;
  FOnBrowserExtensionEnableCompleted               := nil;
  FOnProfileAddBrowserExtensionCompleted           := nil;
  FOnProfileGetBrowserExtensionsCompleted          := nil;
  FOnProfileDeleted                                := nil;
  FOnExecuteScriptWithResultCompleted              := nil;
  FOnNonClientRegionChanged                        := nil;
  FOnNotificationReceived                          := nil;
  FOnNotificationCloseRequested                    := nil;
  FOnSaveAsUIShowing                               := nil;
  FOnShowSaveAsUICompleted                         := nil;
  FOnSaveFileSecurityCheckStarting                 := nil;
  FOnScreenCaptureStarting                         := nil;
  FOnFrameScreenCaptureStarting                    := nil;
  FOnFrameChildFrameCreated                        := nil;
end;

destructor TWVBrowserBase.Destroy;
begin
  try
    RestoreOldCompWndProc;
    DestroyProfile;
    DestroyPrintSettings;
    DestroySettings;
    DestroyEnvironment;
    DestroyWebView;
    DestroyController;
    DestroyCompositionController;

    FClearBrowsingDataCompletedHandler               := nil;
    FSetPermissionStateCompletedHandler              := nil;
    FGetNonDefaultPermissionSettingsCompletedHandler := nil;
    FProfileAddBrowserExtensionCompletedHandler      := nil;
    FProfileGetBrowserExtensionsCompletedHandler     := nil;
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

procedure TWVBrowserBase.DestroyProfile;
begin
  if assigned(FCoreWebView2Profile) then
    FreeAndNil(FCoreWebView2Profile);
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

procedure TWVBrowserBase.AfterConstruction;
begin
  inherited AfterConstruction;

  FClearBrowsingDataCompletedHandler               := TCoreWebView2ClearBrowsingDataCompletedHandler.Create(self);
  FSetPermissionStateCompletedHandler              := TCoreWebView2SetPermissionStateCompletedHandler.Create(self);
  FGetNonDefaultPermissionSettingsCompletedHandler := TCoreWebView2GetNonDefaultPermissionSettingsCompletedHandler.Create(self);
  FProfileAddBrowserExtensionCompletedHandler      := TCoreWebView2ProfileAddBrowserExtensionCompletedHandler.Create(self);
  FProfileGetBrowserExtensionsCompletedHandler     := TCoreWebView2ProfileGetBrowserExtensionsCompletedHandler.Create(self);
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

function TWVBrowserBase.AddWebResourceRequestedFilterWithRequestSourceKinds(const uri                : wvstring;
                                                                                  ResourceContext    : TWVWebResourceContext;
                                                                                  requestSourceKinds : TWVWebResourceRequestSourceKind): boolean;
begin
  Result := Initialized and
            FCoreWebView2.AddWebResourceRequestedFilterWithRequestSourceKinds(uri, ResourceContext, requestSourceKinds);
end;

function TWVBrowserBase.RemoveWebResourceRequestedFilterWithRequestSourceKinds(const uri                : wvstring;
                                                                                     ResourceContext    : TWVWebResourceContext;
                                                                                     requestSourceKinds : TWVWebResourceRequestSourceKind): boolean;
begin
  Result := Initialized and
            FCoreWebView2.RemoveWebResourceRequestedFilterWithRequestSourceKinds(uri, ResourceContext, requestSourceKinds);
end;

function TWVBrowserBase.PostWebMessageAsJsonWithAdditionalObjects(const webMessageAsJson: wvstring;
                                                                  const additionalObjects: ICoreWebView2ObjectCollectionView): boolean;
begin
  Result := Initialized and
            FCoreWebView2.PostWebMessageAsJsonWithAdditionalObjects(webMessageAsJson, additionalObjects);
end;

function TWVBrowserBase.CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CapturePreview(aImageFormat, aImageStream, self);
end;

function TWVBrowserBase.EnvironmentCompletedHandler_Invoke(errorCode: HRESULT; const result_: ICoreWebView2Environment): HRESULT;
var
  TempError : wvstring;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(result_) then
    begin
      DestroyEnvironment;
      FCoreWebView2Environment := TCoreWebView2Environment.Create(result_);

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

function TWVBrowserBase.ControllerCompletedHandler_Invoke(errorCode: HRESULT; const result_: ICoreWebView2Controller): HRESULT;
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
    if succeeded(errorCode) and assigned(result_) then
      begin
        DestroyController;
        FCoreWebView2Controller := TCoreWebView2Controller.Create(result_);

        doOnControllerCompleted;

        TempCoreWebView2 := FCoreWebView2Controller.CoreWebView2;

        if assigned(TempCoreWebView2) then
          begin
            DestroyWebView;
            FCoreWebView2 := TCoreWebView2.Create(TempCoreWebView2);
            TempSettings  := FCoreWebView2.Settings;

            if assigned(TempSettings) then
              begin
                DestroyProfile;
                FCoreWebView2Profile := TCoreWebView2Profile.Create(FCoreWebView2.Profile);
                FCoreWebView2Profile.AddAllBrowserEvents(self);

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
  CalculateZoomStep;
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

function TWVBrowserBase.CreateCoreWebView2CompositionControllerCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2CompositionController): HRESULT;
var
  TempControllerIntf : ICoreWebView2Controller;
  TempError          : wvstring;
  TempHResult        : HRESULT;
begin
  Result := S_OK;

  if succeeded(errorCode) and assigned(result_) then
    begin
      DestroyCompositionController;
      FCoreWebView2CompositionController := TCoreWebView2CompositionController.Create(result_);

      doOnCompositionControllerCompleted;

      TempHResult := result_.QueryInterface(IID_ICoreWebView2Controller, TempControllerIntf);

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

function TWVBrowserBase.WebResourceResponseViewGetContentCompletedHandler_Invoke(errorCode: HResult; const result_: IStream; aResourceID : integer): HRESULT;
begin
  Result := S_OK;
  doOnWebResourceResponseViewGetContentCompletedEvent(errorCode, result_, aResourceID);
end;

function TWVBrowserBase.GetCookiesCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2CookieList): HRESULT;
begin
  Result := S_OK;
  doOnGetCookiesCompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.TrySuspendCompletedHandler_Invoke(errorCode: HResult; result_: Integer): HRESULT;
begin
  Result := S_OK;
  doOnTrySuspendCompletedEvent(errorCode, result_);
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

function TWVBrowserBase.PrintToPdfCompletedHandler_Invoke(errorCode: HResult; result_: Integer): HRESULT;
begin
  Result := S_OK;
  doOnPrintToPdfCompletedEvent(errorCode, result_);
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

function TWVBrowserBase.FrameNameChangedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameNameChangedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameDestroyedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameDestroyedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.CallDevToolsProtocolMethodCompletedHandler_Invoke(errorCode: HResult; result_: PWideChar; aExecutionID : integer): HRESULT;
begin
  Result := S_OK;

  case aExecutionID of
    WEBVIEW4DELPHI_DEVTOOLS_RETRIEVEMHTML_ID :
      doOnRetrieveMHTMLCompleted(errorCode, wvstring(result_));

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

    WEBVIEW4DELPHI_DEVTOOLS_REFRESH_ID :
      doOnRefreshIgnoreCacheCompleted(errorCode, wvstring(result_));

    else
      doOnCallDevToolsProtocolMethodCompletedEvent(errorCode, wvstring(result_), aExecutionID);
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
                                                            aFrameID : cardinal);
begin
  if assigned(FOnFrameNavigationStarting2) then
    FOnFrameNavigationStarting2(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameNavigationCompleted2(const sender   : ICoreWebView2Frame;
                                                       const args     : ICoreWebView2NavigationCompletedEventArgs;
                                                             aFrameID : cardinal);
begin
  if assigned(FOnFrameNavigationCompleted2) then
    FOnFrameNavigationCompleted2(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameContentLoadingEvent(const sender   : ICoreWebView2Frame;
                                                      const args     : ICoreWebView2ContentLoadingEventArgs;
                                                            aFrameID : cardinal);
begin
  if assigned(FOnFrameContentLoading) then
    FOnFrameContentLoading(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameDOMContentLoadedEvent(const sender   : ICoreWebView2Frame;
                                                        const args     : ICoreWebView2DOMContentLoadedEventArgs;
                                                              aFrameID : cardinal);
begin
  if assigned(FOnFrameDOMContentLoaded) then
    FOnFrameDOMContentLoaded(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameWebMessageReceivedEvent(const sender   : ICoreWebView2Frame;
                                                          const args     : ICoreWebView2WebMessageReceivedEventArgs;
                                                                aFrameID : cardinal);
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
                                                                 aFrameID : cardinal);
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

procedure TWVBrowserBase.doOnGetFaviconCompletedEvent(      errorCode : HResult;
                                                      const result_   : IStream);
begin
  if assigned(FOnGetFaviconCompleted) then
    FOnGetFaviconCompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnPrintCompletedEvent(errorCode : HResult;
                                                 result_   : COREWEBVIEW2_PRINT_STATUS);
begin
  if assigned(FOnPrintCompleted) then
    FOnPrintCompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnPrintToPdfStreamCompletedEvent(      errorCode : HResult;
                                                            const result_   : IStream);
begin
  if assigned(FOnPrintToPdfStreamCompleted) then
    FOnPrintToPdfStreamCompleted(self, errorCode, result_);
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

procedure TWVBrowserBase.doOnGetNonDefaultPermissionSettingsCompleted(      errorCode : HResult;
                                                                      const result_   : ICoreWebView2PermissionSettingCollectionView);
begin
  if assigned(FOnGetNonDefaultPermissionSettingsCompleted) then
    FOnGetNonDefaultPermissionSettingsCompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnSetPermissionStateCompleted(errorCode: HResult);
begin
  if assigned(FOnSetPermissionStateCompleted) then
    FOnSetPermissionStateCompleted(self, errorCode);
end;

procedure TWVBrowserBase.doOnLaunchingExternalUriSchemeEvent(const sender : ICoreWebView2;
                                                             const args   : ICoreWebView2LaunchingExternalUriSchemeEventArgs);
begin
  if assigned(FOnLaunchingExternalUriScheme) then
    FOnLaunchingExternalUriScheme(self, sender, args);
end;

procedure TWVBrowserBase.doOnGetProcessExtendedInfosCompletedEvent(      errorCode : HResult;
                                                                   const result_   : ICoreWebView2ProcessExtendedInfoCollection);
begin
  if assigned(FOnGetProcessExtendedInfosCompleted) then
    FOnGetProcessExtendedInfosCompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnBrowserExtensionRemoveCompletedEvent(      errorCode    : HResult;
                                                                  const aExtensionID : wvstring);
begin
  if assigned(FOnBrowserExtensionRemoveCompleted) then
    FOnBrowserExtensionRemoveCompleted(self, errorCode, aExtensionID);
end;

procedure TWVBrowserBase.doOnBrowserExtensionEnableCompletedEvent(      errorCode    : HResult;
                                                                  const aExtensionID : wvstring);
begin
  if assigned(FOnBrowserExtensionEnableCompleted) then
    FOnBrowserExtensionEnableCompleted(self, errorCode, aExtensionID);
end;

procedure TWVBrowserBase.doOnProfileAddBrowserExtensionCompletedEvent(      errorCode : HResult;
                                                                      const result_   : ICoreWebView2BrowserExtension);
begin
  if assigned(FOnProfileAddBrowserExtensionCompleted) then
    FOnProfileAddBrowserExtensionCompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnProfileGetBrowserExtensionsCompletedEvent(      errorCode : HResult;
                                                                       const result_   : ICoreWebView2BrowserExtensionList);
begin
  if assigned(FOnProfileGetBrowserExtensionsCompleted) then
    FOnProfileGetBrowserExtensionsCompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnProfileDeletedEvent(const sender : ICoreWebView2Profile;
                                                 const args   : IUnknown);
begin
  if assigned(FOnProfileDeleted) then
    FOnProfileDeleted(self, sender);
end;

procedure TWVBrowserBase.doOnExecuteScriptWithResultCompletedEvent(      errorCode    : HResult;
                                                                   const result_      : ICoreWebView2ExecuteScriptResult;
                                                                         aExecutionID : integer);
begin
  if assigned(FOnExecuteScriptWithResultCompleted) then
    FOnExecuteScriptWithResultCompleted(self, errorCode, result_, aExecutionID);
end;

procedure TWVBrowserBase.doOnNonClientRegionChangedEvent(const sender : ICoreWebView2CompositionController;
                                                         const args   : ICoreWebView2NonClientRegionChangedEventArgs);
begin
  if assigned(FOnNonClientRegionChanged) then
    FOnNonClientRegionChanged(self, sender, args);
end;

procedure TWVBrowserBase.doOnNotificationReceivedEvent(const sender : ICoreWebView2;
                                                       const args   : ICoreWebView2NotificationReceivedEventArgs);
begin
  if assigned(FOnNotificationReceived) then
    FOnNotificationReceived(self, sender, args);
end;

procedure TWVBrowserBase.doOnNotificationCloseRequestedEvent(const sender : ICoreWebView2Notification;
                                                             const args   : IUnknown);
begin
  if assigned(FOnNotificationCloseRequested) then
    FOnNotificationCloseRequested(self, sender, args);
end;

procedure TWVBrowserBase.doOnSaveAsUIShowingEvent(const sender : ICoreWebView2;
                                                  const args   : ICoreWebView2SaveAsUIShowingEventArgs);
begin
  if assigned(FOnSaveAsUIShowing) then
    FOnSaveAsUIShowing(self, sender, args);
end;

procedure TWVBrowserBase.doOnShowSaveAsUICompletedEvent(errorCode : HResult;
                                                        result_   : COREWEBVIEW2_SAVE_AS_UI_RESULT);
begin
  if assigned(FOnShowSaveAsUICompleted) then
    FOnShowSaveAsUICompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnSaveFileSecurityCheckStartingEvent(const sender : ICoreWebView2;
                                                                const args   : ICoreWebView2SaveFileSecurityCheckStartingEventArgs);
begin
  if assigned(FOnSaveFileSecurityCheckStarting) then
    FOnSaveFileSecurityCheckStarting(self, sender, args);
end;

procedure TWVBrowserBase.doOnScreenCaptureStartingEvent(const sender : ICoreWebView2;
                                                        const args   : ICoreWebView2ScreenCaptureStartingEventArgs);
begin
  if assigned(FOnScreenCaptureStarting) then
    FOnScreenCaptureStarting(self, sender, args);
end;

procedure TWVBrowserBase.doOnFrameScreenCaptureStartingEvent(const sender   : ICoreWebView2Frame;
                                                             const args     : ICoreWebView2ScreenCaptureStartingEventArgs;
                                                                   aFrameID : cardinal);
begin
  if assigned(FOnFrameScreenCaptureStarting) then
    FOnFrameScreenCaptureStarting(self, sender, args, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameChildFrameCreatedEvent(const sender   : ICoreWebView2Frame;
                                                         const args     : ICoreWebView2FrameCreatedEventArgs;
                                                               aFrameID : cardinal);
begin
  if assigned(FOnFrameChildFrameCreated) then
    FOnFrameChildFrameCreated(self, sender, args, aFrameID);
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

function TWVBrowserBase.AddScriptToExecuteOnDocumentCreatedCompletedHandler_Invoke(errorCode: HResult; result_: PWideChar): HRESULT;
begin
  Result := S_OK;
  doOnAddScriptToExecuteOnDocumentCreatedCompletedEvent(errorCode, wvstring(result_));
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
                                                                          aFrameID : cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameNavigationStarting2(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameNavigationCompletedEventHandler2_Invoke(const sender   : ICoreWebView2Frame;
                                                                     const args     : ICoreWebView2NavigationCompletedEventArgs;
                                                                           aFrameID : cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameNavigationCompleted2(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameContentLoadingEventHandler_Invoke(const sender   : ICoreWebView2Frame;
                                                               const args     : ICoreWebView2ContentLoadingEventArgs;
                                                                     aFrameID : cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameContentLoadingEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameDOMContentLoadedEventHandler_Invoke(const sender   : ICoreWebView2Frame;
                                                                 const args     : ICoreWebView2DOMContentLoadedEventArgs;
                                                                       aFrameID : cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameDOMContentLoadedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameWebMessageReceivedEventHandler_Invoke(const sender   : ICoreWebView2Frame;
                                                                   const args     : ICoreWebView2WebMessageReceivedEventArgs;
                                                                         aFrameID : cardinal): HRESULT;
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
                                                                          aFrameID : cardinal): HRESULT;
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

function TWVBrowserBase.GetFaviconCompletedHandler_Invoke(errorCode: HResult; const result_: IStream): HRESULT;
begin
  Result := S_OK;
  doOnGetFaviconCompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.PrintCompletedHandler_Invoke(errorCode: HResult; result_: COREWEBVIEW2_PRINT_STATUS): HRESULT;
begin
  Result := S_OK;
  doOnPrintCompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.PrintToPdfStreamCompletedHandler_Invoke(errorCode: HResult; const result_: IStream): HRESULT;
begin
  Result := S_OK;
  doOnPrintToPdfStreamCompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.GetNonDefaultPermissionSettingsCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2PermissionSettingCollectionView): HRESULT;
begin
  Result := S_OK;
  doOnGetNonDefaultPermissionSettingsCompleted(errorCode, result_);
end;

function TWVBrowserBase.SetPermissionStateCompletedHandler_Invoke(errorCode: HResult): HRESULT;
begin
  Result := S_OK;
  doOnSetPermissionStateCompleted(errorCode);
end;

function TWVBrowserBase.LaunchingExternalUriSchemeEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2LaunchingExternalUriSchemeEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnLaunchingExternalUriSchemeEvent(sender, args);
end;

function TWVBrowserBase.GetProcessExtendedInfosCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2ProcessExtendedInfoCollection): HRESULT;
begin
  Result := S_OK;
  doOnGetProcessExtendedInfosCompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.BrowserExtensionRemoveCompletedHandler_Invoke(errorCode: HResult; const aExtensionID: wvstring): HRESULT;
begin
  Result := S_OK;
  doOnBrowserExtensionRemoveCompletedEvent(errorCode, aExtensionID);
end;

function TWVBrowserBase.BrowserExtensionEnableCompletedHandler_Invoke(errorCode: HResult; const aExtensionID: wvstring): HRESULT;
begin
  Result := S_OK;
  doOnBrowserExtensionEnableCompletedEvent(errorCode, aExtensionID);
end;

function TWVBrowserBase.ProfileAddBrowserExtensionCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtension): HRESULT;
begin
  Result := S_OK;
  doOnProfileAddBrowserExtensionCompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.ProfileGetBrowserExtensionsCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtensionList): HRESULT;
begin
  Result := S_OK;
  doOnProfileGetBrowserExtensionsCompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.ProfileDeletedEventHandler_Invoke(const sender: ICoreWebView2Profile; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnProfileDeletedEvent(sender, args);
end;

function TWVBrowserBase.ExecuteScriptWithResultCompletedHandler_Invoke(errorCode: HResult; const result_: ICoreWebView2ExecuteScriptResult; aExecutionID : integer): HRESULT;
begin
  Result := S_OK;
  doOnExecuteScriptWithResultCompletedEvent(errorCode, result_, aExecutionID);
end;

function TWVBrowserBase.NonClientRegionChangedEventHandler_Invoke(const sender: ICoreWebView2CompositionController; const args: ICoreWebView2NonClientRegionChangedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnNonClientRegionChangedEvent(sender, args);
end;

function TWVBrowserBase.NotificationReceivedEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2NotificationReceivedEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnNotificationReceivedEvent(sender, args);
end;

function TWVBrowserBase.NotificationCloseRequestedEventHandler_Invoke(const sender: ICoreWebView2Notification; const args: IUnknown): HRESULT;
begin
  Result := S_OK;
  doOnNotificationCloseRequestedEvent(sender, args);
end;

function TWVBrowserBase.SaveAsUIShowingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveAsUIShowingEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnSaveAsUIShowingEvent(sender, args);
end;

function TWVBrowserBase.ShowSaveAsUICompletedHandler_Invoke(errorCode: HResult; result_: COREWEBVIEW2_SAVE_AS_UI_RESULT): HRESULT;
begin
  Result := S_OK;
  doOnShowSaveAsUICompletedEvent(errorCode, result_);
end;

function TWVBrowserBase.SaveFileSecurityCheckStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveFileSecurityCheckStartingEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnSaveFileSecurityCheckStartingEvent(sender, args);
end;

function TWVBrowserBase.ScreenCaptureStartingEventHandler_Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ScreenCaptureStartingEventArgs): HRESULT;
begin
  Result := S_OK;
  doOnScreenCaptureStartingEvent(sender, args);
end;

function TWVBrowserBase.FrameScreenCaptureStartingEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2ScreenCaptureStartingEventArgs; aFrameID: cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameScreenCaptureStartingEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.FrameChildFrameCreatedEventHandler_Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2FrameCreatedEventArgs; aFrameID: cardinal): HRESULT;
begin
  Result := S_OK;
  doOnFrameChildFrameCreatedEvent(sender, args, aFrameID);
end;

function TWVBrowserBase.ExecuteScriptCompletedHandler_Invoke(errorCode: HRESULT; result_: PWideChar; aExecutionID : integer): HRESULT;
begin
  Result := S_OK;

  case aExecutionID of
    WEBVIEW4DELPHI_JS_RETRIEVEHTMLJOB_ID :
      doOnRetrieveHTMLCompleted(errorCode, wvstring(result_));

    WEBVIEW4DELPHI_JS_RETRIEVETEXTJOB_ID :
      doOnRetrieveTextCompleted(errorCode, wvstring(result_));

    else
      doOnExecuteScriptCompleted(errorCode, wvstring(result_), aExecutionID);
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
      Result                   := CreateController;
    end
   else
    Result := CreateEnvironment;
end;

function TWVBrowserBase.CreateInvisibleBrowser(aUseDefaultEnvironment : boolean) : boolean;
begin
  Result := CreateBrowser(HWND_MESSAGE, aUseDefaultEnvironment);
end;

function TWVBrowserBase.CreateInvisibleBrowser(const aEnvironment : ICoreWebView2Environment) : boolean;
begin
  Result := CreateBrowser(HWND_MESSAGE, aEnvironment);
end;

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
    if FCoreWebView2Environment.CreateCoreWebView2ControllerOptions(TempOptionsIntf, TempHResult) then
      try
        TempOptions                          := TCoreWebView2ControllerOptions.Create(TempOptionsIntf);
        TempOptions.ProfileName              := FProfileName;
        TempOptions.IsInPrivateModeEnabled   := FIsInPrivateModeEnabled;
        TempOptions.ScriptLocale             := FScriptLocale;
        TempOptions.DefaultBackgroundColor   := FDefaultBackgroundColor;
        TempOptions.AllowHostInputProcessing := FAllowHostInputProcessing;

        Result := FCoreWebView2Environment.CreateCoreWebView2CompositionControllerWithOptions(FWindowParentHandle,
                                                                                              TempOptions.BaseIntf,
                                                                                              self,
                                                                                              TempHResult);
      finally
        FreeAndNil(TempOptions);
        TempOptionsIntf := nil;
      end
     else
      if (TempHResult = E_NOTIMPL) then
        begin
          FProfileName            := '';
          FIsInPrivateModeEnabled := False;

          Result := FCoreWebView2Environment.CreateCoreWebView2CompositionController(FWindowParentHandle,
                                                                                     self,
                                                                                     TempHResult);
        end
       else
        begin
          TempError := 'There was an error creating the controller options. (1)' + CRLF +
                       'Error code : 0x' +
                       {$IFDEF FPC}
                       UTF8Decode(inttohex(TempHResult, 8))
                       {$ELSE}
                       inttohex(TempHResult, 8)
                       {$ENDIF}
                       + CRLF + ControllerOptionsCreationErrorToString(TempHResult);

          doOnInitializationError(TempHResult, TempError);
          exit;
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
  Result := False;

  if FCoreWebView2Environment.CreateCoreWebView2ControllerOptions(TempOptionsIntf, TempHResult) then
    try
      TempOptions                          := TCoreWebView2ControllerOptions.Create(TempOptionsIntf);
      TempOptions.ProfileName              := FProfileName;
      TempOptions.IsInPrivateModeEnabled   := FIsInPrivateModeEnabled;
      TempOptions.ScriptLocale             := FScriptLocale;
      TempOptions.DefaultBackgroundColor   := FDefaultBackgroundColor;
      TempOptions.AllowHostInputProcessing := FAllowHostInputProcessing;

      Result := FCoreWebView2Environment.CreateCoreWebView2ControllerWithOptions(FWindowParentHandle,
                                                                                 TempOptions.BaseIntf,
                                                                                 self,
                                                                                 TempHResult);
    finally
      FreeAndNil(TempOptions);
      TempOptionsIntf := nil;
    end
   else
    if (TempHResult = E_NOTIMPL) then
      begin
        FProfileName            := '';
        FIsInPrivateModeEnabled := False;

        Result := FCoreWebView2Environment.CreateCoreWebView2Controller(FWindowParentHandle,
                                                                        self,
                                                                        TempHResult);
      end
     else
      begin
        TempError := 'There was an error creating the controller options. (2)' + CRLF +
                     'Error code : 0x' +
                     {$IFDEF FPC}
                     UTF8Decode(inttohex(TempHResult, 8))
                     {$ELSE}
                     inttohex(TempHResult, 8)
                     {$ENDIF}
                     + CRLF + ControllerOptionsCreationErrorToString(TempHResult);

        doOnInitializationError(TempHResult, TempError);
        exit;
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

function TWVBrowserBase.ExecuteScriptWithResult(const aJavaScript: wvstring; aExecutionID : integer): boolean;
begin
  Result := Initialized and
            FCoreWebView2.ExecuteScriptWithResult(aJavaScript, aExecutionID, self);
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
    Result := FDefaultBackgroundColor;
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

function TWVBrowserBase.GetIsNonClientRegionSupportEnabled : boolean;
begin
  Result := Initialized and
            FCoreWebView2Settings.IsNonClientRegionSupportEnabled;
end;

function TWVBrowserBase.GetFaviconURI : wvstring;
begin
  if Initialized then
    Result := FCoreWebView2.FaviconURI
   else
    Result := '';
end;

function TWVBrowserBase.GetMemoryUsageTargetLevel : TWVMemoryUsageTargetLevel;
begin
  if Initialized then
    Result := FCoreWebView2.MemoryUsageTargetLevel
   else
    Result := COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_NORMAL;
end;

function TWVBrowserBase.GetFrameID : cardinal;
begin
  if Initialized then
    Result := FCoreWebView2.FrameId
   else
    Result := WEBVIEW4DELPHI_INVALID_FRAMEID;
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
                                                          FEnableTrackingPrevention,
                                                          FAreBrowserExtensionsEnabled,
                                                          FChannelSearchKind,
                                                          FReleaseChannels,
                                                          FScrollBarStyle);

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

function TWVBrowserBase.RefreshIgnoreCache : boolean;
begin
  Result := CallDevToolsProtocolMethod('Page.reload', '{"ignoreCache": true}', WEBVIEW4DELPHI_DEVTOOLS_REFRESH_ID);
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
  FDefaultBackgroundColor := aValue;

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

procedure TWVBrowserBase.SetIsNonClientRegionSupportEnabled(aValue : boolean);
begin
  if Initialized then
    FCoreWebView2Settings.IsNonClientRegionSupportEnabled := aValue;
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

function TWVBrowserBase.GetProcessExtendedInfos : boolean;
begin
  Result := Initialized and
            FCoreWebView2Environment.GetProcessExtendedInfos(self);
end;

function TWVBrowserBase.ShowSaveAsUI : boolean;
begin
  Result := Initialized and
            FCoreWebView2.ShowSaveAsUI(self);
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

function TWVBrowserBase.RetrieveHTML : boolean;
begin
  // JS code created by Alessandro Mancini
  Result := ExecuteScript('encodeURIComponent(document.documentElement.outerHTML);', WEBVIEW4DELPHI_JS_RETRIEVEHTMLJOB_ID);
end;

function TWVBrowserBase.RetrieveText(aVisibleTextOnly: boolean) : boolean;
begin
  if aVisibleTextOnly then
    Result := ExecuteScript('encodeURIComponent(document.body.innerText);', WEBVIEW4DELPHI_JS_RETRIEVETEXTJOB_ID)
   else
    Result := ExecuteScript('encodeURIComponent(document.body.textContent);', WEBVIEW4DELPHI_JS_RETRIEVETEXTJOB_ID);
end;

function TWVBrowserBase.RetrieveMHTML : boolean;
begin
  Result := CallDevToolsProtocolMethod('Page.captureSnapshot', '{"format": "mhtml"}', WEBVIEW4DELPHI_DEVTOOLS_RETRIEVEMHTML_ID);
end;

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

function TWVBrowserBase.CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2.CallDevToolsProtocolMethod(aMethodName, aParametersAsJson, aExecutionID, self);
end;

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

function TWVBrowserBase.ClearCache : boolean;
begin
  Result := CallDevToolsProtocolMethod('Network.clearBrowserCache', '{}', WEBVIEW4DELPHI_DEVTOOLS_CLEARBROWSERCACHE_ID);
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

procedure TWVBrowserBase.doOnWebResourceResponseViewGetContentCompletedEvent(errorCode: HResult; const result_: IStream; aResourceID : integer);
begin
  if assigned(FOnWebResourceResponseViewGetContentCompleted) then
    FOnWebResourceResponseViewGetContentCompleted(self, errorCode, result_, aResourceID);
end;

procedure TWVBrowserBase.doOnGetCookiesCompletedEvent(errorCode: HResult; const result_ : ICoreWebView2CookieList);
begin
  if assigned(FOnGetCookiesCompleted) then
    FOnGetCookiesCompleted(self, errorCode, result_);
end;

procedure TWVBrowserBase.doOnTrySuspendCompletedEvent(errorCode: HResult; result_: Integer);
begin
  if assigned(FOnTrySuspendCompleted) then
    FOnTrySuspendCompleted(self, errorCode, (result_ <> 0));
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

procedure TWVBrowserBase.doOnPrintToPdfCompletedEvent(errorCode: HResult; result_: Integer);
begin
  if assigned(FOnPrintToPdfCompleted) then
    FOnPrintToPdfCompleted(self, errorCode, (result_ <> 0));
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

procedure TWVBrowserBase.doOnFrameNameChangedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal);
begin
  if assigned(FOnFrameNameChanged) then
    FOnFrameNameChanged(self, sender, aFrameID);
end;

procedure TWVBrowserBase.doOnFrameDestroyedEvent(const sender: ICoreWebView2Frame; const args: IUnknown; aFrameID : cardinal);
begin
  if assigned(FOnFrameDestroyed) then
    FOnFrameDestroyed(self, sender, aFrameID);
end;

procedure TWVBrowserBase.doOnCallDevToolsProtocolMethodCompletedEvent(aErrorCode: HRESULT; const aResult: wvstring; aExecutionID : integer);
begin
  if assigned(FOnCallDevToolsProtocolMethodCompleted) then
    FOnCallDevToolsProtocolMethodCompleted(self, aErrorCode, aResult, aExecutionID);
end;

procedure TWVBrowserBase.doOnAddScriptToExecuteOnDocumentCreatedCompletedEvent(aErrorCode: HRESULT; const aResult : wvstring);
begin
  if assigned(FOnAddScriptToExecuteOnDocumentCreatedCompleted) then
    FOnAddScriptToExecuteOnDocumentCreatedCompleted(self, aErrorCode, aResult);
end;

procedure TWVBrowserBase.CalculateZoomStep;
var
  TempPct, TempDelta, TempBest : double;
  i, TempStep : integer;
begin
  TempPct  := ZoomPct;
  TempStep := ZOOM_STEP_DEF;
  TempBest := 10000;
  i        := ZOOM_STEP_MIN;

  while (i <= ZOOM_STEP_MAX) do
    begin
      TempDelta := abs(ZoomStepValues[i] - TempPCt);

      if (TempBest > TempDelta) then
        begin
          TempBest := TempDelta;
          TempStep := i;
        end
       else
        if (TempBest < TempDelta) then
          break;

      inc(i);
    end;

  FZoomStep := TempStep;
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

function TWVBrowserBase.SimulateEditingCommand(aEditingCommand : TWV2EditingCommand): boolean;
var
  TempParams : wvstring;
begin
  TempParams := '{"type": "char", "commands": ["' + EditingCommandToString(aEditingCommand) + '"]}';
  Result     := CallDevToolsProtocolMethod('Input.dispatchKeyEvent', TempParams, WEBVIEW4DELPHI_DEVTOOLS_SIMULATEKEYEVENT_ID);
end;

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

function TWVBrowserBase.KeyboardShortcutSearch : boolean;
begin
  Result := SimulateKeyEvent(ketRawKeyDown, $100, VK_F3, integer($003D0001)) and
            SimulateKeyEvent(ketKeyUp,      $100, VK_F3, integer($C03D0001));
end;

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

  if FUseCompositionController and Initialized then
    begin
      TempPoint.x := point.X;
      TempPoint.y := point.Y;
      Result      := FCoreWebView2CompositionController.Drop(dataObject, keyState, TempPoint, effect);
    end;
end;

function TWVBrowserBase.GetNonClientRegionAtPoint(point: TPoint) : TWVNonClientRegionKind;
begin
  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.GetNonClientRegionAtPoint(point)
   else
    Result := COREWEBVIEW2_NON_CLIENT_REGION_KIND_NOWHERE;
end;

function TWVBrowserBase.QueryNonClientRegion(Kind: TWVNonClientRegionKind): ICoreWebView2RegionRectCollectionView;
begin
  if FUseCompositionController and Initialized then
    Result := FCoreWebView2CompositionController.QueryNonClientRegion(Kind)
   else
    Result := nil;
end;

function TWVBrowserBase.ClearBrowsingData(dataKinds: TWVBrowsingDataKinds): boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.ClearBrowsingData(dataKinds, FClearBrowsingDataCompletedHandler);
end;

function TWVBrowserBase.ClearBrowsingDataInTimeRange(dataKinds: TWVBrowsingDataKinds; const startTime, endTime: TDateTime): boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.ClearBrowsingDataInTimeRange(dataKinds, startTime, endTime, FClearBrowsingDataCompletedHandler);
end;

function TWVBrowserBase.ClearBrowsingDataAll: boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.ClearBrowsingDataAll(FClearBrowsingDataCompletedHandler);
end;

function TWVBrowserBase.SetPermissionState(aPermissionKind: TWVPermissionKind; const aOrigin: wvstring; aState: TWVPermissionState) : boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.SetPermissionState(aPermissionKind, aOrigin, aState, FSetPermissionStateCompletedHandler);
end;

function TWVBrowserBase.GetNonDefaultPermissionSettings: boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.GetNonDefaultPermissionSettings(FGetNonDefaultPermissionSettingsCompletedHandler);
end;

function TWVBrowserBase.AddBrowserExtension(const extensionFolderPath: wvstring): boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.AddBrowserExtension(extensionFolderPath, FProfileAddBrowserExtensionCompletedHandler);
end;

function TWVBrowserBase.GetBrowserExtensions: boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.GetBrowserExtensions(FProfileGetBrowserExtensionsCompletedHandler);
end;

function TWVBrowserBase.DeleteProfile: boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.Delete;
end;

function TWVBrowserBase.GetProfileName : wvstring;
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    Result := FCoreWebView2Profile.ProfileName
   else
    Result := '';
end;

function TWVBrowserBase.GetIsInPrivateModeEnabled : boolean;
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    Result := FCoreWebView2Profile.IsInPrivateModeEnabled
   else
    Result := FIsInPrivateModeEnabled;
end;

function TWVBrowserBase.GetProfilePath : wvstring;
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    Result := FCoreWebView2Profile.ProfilePath
   else
    Result := '';
end;

function TWVBrowserBase.GetDefaultDownloadFolderPath : wvstring;
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    Result := FCoreWebView2Profile.DefaultDownloadFolderPath
   else
    Result := '';
end;

procedure TWVBrowserBase.SetDefaultDownloadFolderPath(const aValue : wvstring);
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    FCoreWebView2Profile.DefaultDownloadFolderPath := aValue;
end;

function TWVBrowserBase.GetPreferredColorScheme : TWVPreferredColorScheme;
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    Result := FCoreWebView2Profile.PreferredColorScheme
   else
    Result := COREWEBVIEW2_PREFERRED_COLOR_SCHEME_AUTO;
end;

procedure TWVBrowserBase.SetPreferredColorScheme(const aValue : TWVPreferredColorScheme);
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    FCoreWebView2Profile.PreferredColorScheme := aValue;
end;

function TWVBrowserBase.GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    Result := FCoreWebView2Profile.PreferredTrackingPreventionLevel
   else
    Result := COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED;
end;

function TWVBrowserBase.GetProfileCookieManager : ICoreWebView2CookieManager;
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    Result := FCoreWebView2Profile.CookieManager
   else
    Result := nil;
end;

function TWVBrowserBase.GetProfileIsPasswordAutosaveEnabled : boolean;
begin
  Result :=  Initialized and
             assigned(FCoreWebView2Profile) and
             FCoreWebView2Profile.IsPasswordAutosaveEnabled;
end;

function TWVBrowserBase.GetProfileIsGeneralAutofillEnabled : boolean;
begin
  Result := Initialized and
            assigned(FCoreWebView2Profile) and
            FCoreWebView2Profile.IsGeneralAutofillEnabled;
end;

procedure TWVBrowserBase.SetPreferredTrackingPreventionLevel(const aValue : TWVTrackingPreventionLevel);
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    FCoreWebView2Profile.PreferredTrackingPreventionLevel := aValue;
end;

procedure TWVBrowserBase.SetProfileIsPasswordAutosaveEnabled(aValue : boolean);
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    FCoreWebView2Profile.IsPasswordAutosaveEnabled := aValue;
end;

procedure TWVBrowserBase.SetProfileIsGeneralAutofillEnabled(aValue : boolean);
begin
  if Initialized and assigned(FCoreWebView2Profile) then
    FCoreWebView2Profile.IsGeneralAutofillEnabled := aValue;
end;

procedure TWVBrowserBase.SetMemoryUsageTargetLevel(aValue : TWVMemoryUsageTargetLevel);
begin
  if Initialized then
    FCoreWebView2.MemoryUsageTargetLevel := aValue;
end;

function TWVBrowserBase.CreateSharedBuffer(aSize : Largeuint; var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;
begin
  Result := Initialized and
            FCoreWebView2Environment.CreateSharedBuffer(aSize, aSharedBuffer);
end;

end.
