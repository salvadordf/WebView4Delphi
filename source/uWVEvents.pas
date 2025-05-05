unit uWVEvents;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX, Winapi.Messages,
  {$ELSE}
  ActiveX, Messages,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  // Loader events
  TLoaderNotifyEvent                                       = {$IFDEF DELPHI12_UP}reference to{$ENDIF} procedure(Sender: TObject) {$IFNDEF DELPHI12_UP}{$IFNDEF FPC} of object{$ENDIF}{$ENDIF};
  TLoaderBrowserProcessExitedEvent                         = {$IFDEF DELPHI12_UP}reference to{$ENDIF} procedure(Sender: TObject; const aEnvironment: ICoreWebView2Environment; const aArgs: ICoreWebView2BrowserProcessExitedEventArgs) {$IFNDEF DELPHI12_UP}{$IFNDEF FPC} of object{$ENDIF}{$ENDIF};
  TLoaderNewBrowserVersionAvailableEvent                   = {$IFDEF DELPHI12_UP}reference to{$ENDIF} procedure(Sender: TObject; const aEnvironment: ICoreWebView2Environment) {$IFNDEF DELPHI12_UP}{$IFNDEF FPC} of object{$ENDIF}{$ENDIF};
  TLoaderProcessInfosChangedEvent                          = {$IFDEF DELPHI12_UP}reference to{$ENDIF} procedure(Sender: TObject; const aEnvironment: ICoreWebView2Environment) {$IFNDEF DELPHI12_UP}{$IFNDEF FPC} of object{$ENDIF}{$ENDIF};
  TLoaderGetCustomSchemesEvent                             = {$IFDEF DELPHI12_UP}reference to{$ENDIF} procedure(Sender: TObject; var aCustomSchemes: TWVCustomSchemeInfoArray) {$IFNDEF DELPHI12_UP}{$IFNDEF FPC} of object{$ENDIF}{$ENDIF};

  // Browser events
  TOnExecuteScriptCompletedEvent                           = procedure(Sender: TObject; aErrorCode: HRESULT; const aResultObjectAsJson: wvstring; aExecutionID: integer) of object;
  TOnCapturePreviewCompletedEvent                          = procedure(Sender: TObject; aErrorCode: HRESULT) of object;
  TOnWebResourceResponseViewGetContentCompletedEvent       = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: IStream; aResourceID : integer) of object;
  TOnGetCookiesCompletedEvent                              = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: ICoreWebView2CookieList) of object;
  TOnTrySuspendCompletedEvent                              = procedure(Sender: TObject; aErrorCode: HRESULT; aResult: boolean) of object;
  TOnPrintToPdfCompletedEvent                              = procedure(Sender: TObject; aErrorCode: HRESULT; aResult: boolean) of object;
  TOnCallDevToolsProtocolMethodCompletedEvent              = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: wvstring; aExecutionID: integer) of object;
  TOnAddScriptToExecuteOnDocumentCreatedCompletedEvent     = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: wvstring) of object;
  TOnMoveFocusRequestedEvent                               = procedure(Sender: TObject; const aController: ICoreWebView2Controller; const aArgs: ICoreWebView2MoveFocusRequestedEventArgs) of object;
  TOnAcceleratorKeyPressedEvent                            = procedure(Sender: TObject; const aController: ICoreWebView2Controller; const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs) of object;
  TOnBrowserProcessExitedEvent                             = procedure(Sender: TObject; const aEnvironment: ICoreWebView2Environment; const aArgs: ICoreWebView2BrowserProcessExitedEventArgs) of object;
  TOnNavigationStartingEvent                               = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationStartingEventArgs) of object;
  TOnNavigationCompletedEvent                              = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationCompletedEventArgs) of object;
  TOnSourceChangedEvent                                    = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SourceChangedEventArgs) of object;
  TOnContentLoadingEvent                                   = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ContentLoadingEventArgs) of object;
  TOnNewWindowRequestedEvent                               = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NewWindowRequestedEventArgs) of object;
  TOnWebResourceRequestedEvent                             = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebResourceRequestedEventArgs) of object;
  TOnScriptDialogOpeningEvent                              = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ScriptDialogOpeningEventArgs) of object;
  TOnPermissionRequestedEvent                              = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2PermissionRequestedEventArgs) of object;
  TOnProcessFailedEvent                                    = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ProcessFailedEventArgs) of object;
  TOnWebMessageReceivedEvent                               = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebMessageReceivedEventArgs) of object;
  TOnDevToolsProtocolEventReceivedEvent                    = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2DevToolsProtocolEventReceivedEventArgs; const aEventName : wvstring; aEventID : integer) of object;
  TOnWebResourceResponseReceivedEvent                      = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebResourceResponseReceivedEventArgs) of object;
  TOnDOMContentLoadedEvent                                 = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2DOMContentLoadedEventArgs) of object;
  TOnFrameCreatedEvent                                     = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2FrameCreatedEventArgs) of object;
  TOnDownloadStartingEvent                                 = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2DownloadStartingEventArgs) of object;
  TOnClientCertificateRequestedEvent                       = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ClientCertificateRequestedEventArgs) of object;
  TOnBytesReceivedChangedEvent                             = procedure(Sender: TObject; const aDownloadOperation: ICoreWebView2DownloadOperation; aDownloadID: integer) of object;
  TOnEstimatedEndTimeChangedEvent                          = procedure(Sender: TObject; const aDownloadOperation: ICoreWebView2DownloadOperation; aDownloadID: integer) of object;
  TOnDownloadStateChangedEvent                             = procedure(Sender: TObject; const aDownloadOperation: ICoreWebView2DownloadOperation; aDownloadID: integer) of object;
  TOnFrameNameChangedEvent                                 = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; aFrameID: cardinal) of object;
  TOnFrameDestroyedEvent                                   = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; aFrameID: cardinal) of object;
  TOnInitializationErrorEvent                              = procedure(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring) of object;
  TOnPrintCompletedEvent                                   = procedure(Sender: TObject; aErrorCode: HRESULT; aResult: TWVPrintStatus) of object;
  TOnRefreshIgnoreCacheCompletedEvent                      = procedure(Sender: TObject; aErrorCode: HRESULT; const aResultObjectAsJson: wvstring) of object;
  TOnRetrieveHTMLCompletedEvent                            = procedure(Sender: TObject; aResult: boolean; const aHTML: wvstring) of object;
  TOnRetrieveTextCompletedEvent                            = procedure(Sender: TObject; aResult: boolean; const aText: wvstring) of object;
  TOnRetrieveMHTMLCompletedEvent                           = procedure(Sender: TObject; aResult: boolean; const aMHTML: wvstring) of object;
  TOnClearCacheCompletedEvent                              = procedure(Sender: TObject; aResult: boolean) of object;
  TOnClearDataForOriginCompletedEvent                      = procedure(Sender: TObject; aResult: boolean) of object;
  TOnOfflineCompletedEvent                                 = procedure(Sender: TObject; aResult: boolean) of object;
  TOnIgnoreCertificateErrorsCompletedEvent                 = procedure(Sender: TObject; aResult: boolean) of object;
  TOnSimulateKeyEventCompletedEvent                        = procedure(Sender: TObject; aResult: boolean) of object;
  TOnIsMutedChangedEvent                                   = procedure(Sender: TObject; const aWebView: ICoreWebView2) of object;
  TOnIsDocumentPlayingAudioChangedEvent                    = procedure(Sender: TObject; const aWebView: ICoreWebView2) of object;
  TOnIsDefaultDownloadDialogOpenChangedEvent               = procedure(Sender: TObject; const aWebView: ICoreWebView2) of object;
  TOnProcessInfosChangedEvent                              = procedure(Sender: TObject; const aEnvironment: ICoreWebView2Environment) of object;
  TOnFrameNavigationStartingEvent                          = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2NavigationStartingEventArgs; aFrameID: cardinal) of object;
  TOnFrameNavigationCompletedEvent                         = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2NavigationCompletedEventArgs; aFrameID: cardinal) of object;
  TOnFrameContentLoadingEvent                              = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2ContentLoadingEventArgs; aFrameID: cardinal) of object;
  TOnFrameDOMContentLoadedEvent                            = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2DOMContentLoadedEventArgs; aFrameID: cardinal) of object;
  TOnFrameWebMessageReceivedEvent                          = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2WebMessageReceivedEventArgs; aFrameID: cardinal) of object;
  TOnBasicAuthenticationRequestedEvent                     = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2BasicAuthenticationRequestedEventArgs) of object;
  TOnContextMenuRequestedEvent                             = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ContextMenuRequestedEventArgs) of object;
  TOnCustomItemSelectedEvent                               = procedure(Sender: TObject; const aMenuItem: ICoreWebView2ContextMenuItem) of object;
  TOnStatusBarTextChangedEvent                             = procedure(Sender: TObject; const aWebView: ICoreWebView2) of object;
  TOnFramePermissionRequestedEvent                         = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2PermissionRequestedEventArgs2; aFrameID: cardinal) of object;
  TOnClearBrowsingDataCompletedEvent                       = procedure(Sender: TObject; aErrorCode: HRESULT) of object;
  TOnServerCertificateErrorActionsCompletedEvent           = procedure(Sender: TObject; aErrorCode: HRESULT) of object;
  TOnServerCertificateErrorDetectedEvent                   = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ServerCertificateErrorDetectedEventArgs) of object;
  TOnFaviconChangedEvent                                   = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: IUnknown) of object;
  TOnGetFaviconCompletedEvent                              = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: IStream) of object;
  TOnPrintToPdfStreamCompletedEvent                        = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: IStream) of object;
  TOnGetCustomSchemesEvent                                 = procedure(Sender: TObject; var aCustomSchemes: TWVCustomSchemeInfoArray) of object;
  TOnGetNonDefaultPermissionSettingsCompletedEvent         = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: ICoreWebView2PermissionSettingCollectionView) of object;
  TOnSetPermissionStateCompletedEvent                      = procedure(Sender: TObject; aErrorCode: HRESULT) of object;
  TOnLaunchingExternalUriSchemeEvent                       = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2LaunchingExternalUriSchemeEventArgs) of object;
  TOnGetProcessExtendedInfosCompletedEvent                 = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: ICoreWebView2ProcessExtendedInfoCollection) of object;
  TOnBrowserExtensionRemoveCompletedEvent                  = procedure(Sender: TObject; aErrorCode: HRESULT; const aExtensionID: wvstring) of object;
  TOnBrowserExtensionEnableCompletedEvent                  = procedure(Sender: TObject; aErrorCode: HRESULT; const aExtensionID: wvstring) of object;
  TOnProfileAddBrowserExtensionCompletedEvent              = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: ICoreWebView2BrowserExtension) of object;
  TOnProfileGetBrowserExtensionsCompletedEvent             = procedure(Sender: TObject; aErrorCode: HRESULT; const aResult: ICoreWebView2BrowserExtensionList) of object;
  TOnProfileDeletedEvent                                   = procedure(Sender: TObject; const aProfile: ICoreWebView2Profile) of object;
  TOnExecuteScriptWithResultCompletedEvent                 = procedure(Sender: TObject; errorCode: HResult; const aResult: ICoreWebView2ExecuteScriptResult; aExecutionID : integer) of object;
  TOnNonClientRegionChangedEvent                           = procedure(Sender: TObject; const aController : ICoreWebView2CompositionController; const aArgs : ICoreWebView2NonClientRegionChangedEventArgs) of object;
  TOnNotificationReceivedEvent                             = procedure(Sender: TObject; const aWebView : ICoreWebView2; const aArgs : ICoreWebView2NotificationReceivedEventArgs) of object;
  TOnNotificationCloseRequestedEvent                       = procedure(Sender: TObject; const aNotification: ICoreWebView2Notification; const aArgs: IUnknown) of object;
  TOnSaveAsUIShowingEvent                                  = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SaveAsUIShowingEventArgs) of object;
  TOnShowSaveAsUICompletedEvent                            = procedure(Sender: TObject; aErrorCode: HResult; aResult: TWVSaveAsUIResult) of object;
  TOnSaveFileSecurityCheckStartingEvent                    = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SaveFileSecurityCheckStartingEventArgs) of object;
  TOnScreenCaptureStartingEvent                            = procedure(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ScreenCaptureStartingEventArgs) of object;
  TOnFrameScreenCaptureStartingEvent                       = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2ScreenCaptureStartingEventArgs; aFrameID: cardinal) of object;
  TOnFrameChildFrameCreatedEvent                           = procedure(Sender: TObject; const aFrame: ICoreWebView2Frame; const aArgs: ICoreWebView2FrameCreatedEventArgs; aFrameID: cardinal) of object;

  // Custom events
  TOnCompMsgEvent                                          = procedure(Sender: TObject; var aMessage: TMessage; var aHandled: Boolean) of object;

implementation

end.
