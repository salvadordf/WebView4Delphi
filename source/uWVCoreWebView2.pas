unit uWVCoreWebView2;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, WinApi.Windows, Winapi.ActiveX, System.SysUtils, System.Types,
  {$ELSE}
  Classes, Windows, ActiveX, SysUtils, Types,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2 = class
    protected
      FBaseIntf                                : ICoreWebView2;
      FBaseIntf2                               : ICoreWebView2_2;
      FBaseIntf3                               : ICoreWebView2_3;
      FBaseIntf4                               : ICoreWebView2_4;
      FBaseIntf5                               : ICoreWebView2_5;
      FBaseIntf6                               : ICoreWebView2_6;
      FBaseIntf7                               : ICoreWebView2_7;
      FBaseIntf8                               : ICoreWebView2_8;
      FBaseIntf9                               : ICoreWebView2_9;
      FBaseIntf10                              : ICoreWebView2_10;
      FBaseIntf11                              : ICoreWebView2_11;
      FBaseIntf12                              : ICoreWebView2_12;
      FBaseIntf13                              : ICoreWebView2_13;
      FBaseIntf14                              : ICoreWebView2_14;
      FBaseIntf15                              : ICoreWebView2_15;
      FBaseIntf16                              : ICoreWebView2_16;
      FBaseIntf17                              : ICoreWebView2_17;
      FContainsFullScreenElementChangedToken   : EventRegistrationToken;
      FContentLoadingToken                     : EventRegistrationToken;
      FDocumentTitleChangedToken               : EventRegistrationToken;
      FFrameNavigationStartingToken            : EventRegistrationToken;
      FFrameNavigationCompletedToken           : EventRegistrationToken;
      FHistoryChangedToken                     : EventRegistrationToken;
      FNavigationStartingToken                 : EventRegistrationToken;
      FNavigationCompletedToken                : EventRegistrationToken;
      FNewWindowRequestedToken                 : EventRegistrationToken;
      FPermissionRequestedToken                : EventRegistrationToken;
      FProcessFailedToken                      : EventRegistrationToken;
      FScriptDialogOpeningToken                : EventRegistrationToken;
      FSourceChangedToken                      : EventRegistrationToken;
      FWebResourceRequestedToken               : EventRegistrationToken;
      FWebMessageReceivedToken                 : EventRegistrationToken;
      FWindowCloseRequestedToken               : EventRegistrationToken;
      FWebResourceResponseReceivedToken        : EventRegistrationToken;
      FDOMContentLoadedToken                   : EventRegistrationToken;
      FFrameCreatedToken                       : EventRegistrationToken;
      FDownloadStartingToken                   : EventRegistrationToken;
      FClientCertificateRequestedToken         : EventRegistrationToken;
      FIsMutedChangedToken                     : EventRegistrationToken;
      FIsDocumentPlayingAudioChangedToken      : EventRegistrationToken;
      FIsDefaultDownloadDialogOpenChangedToken : EventRegistrationToken;
      FBasicAuthenticationRequestedToken       : EventRegistrationToken;
      FContextMenuRequestedToken               : EventRegistrationToken;
      FStatusBarTextChangedToken               : EventRegistrationToken;
      FServerCertificateErrorDetectedToken     : EventRegistrationToken;
      FFaviconChangedToken                     : EventRegistrationToken;

      FDevToolsEventNames                      : TStringList;
      FDevToolsEventTokens                     : array of EventRegistrationToken;

      function  GetInitialized : boolean;
      function  GetBrowserProcessID : cardinal;
      function  GetCanGoBack : boolean;
      function  GetCanGoForward : boolean;
      function  GetContainsFullScreenElement : boolean;
      function  GetDocumentTitle : wvstring;
      function  GetSource : wvstring;
      function  GetCookieManager : ICoreWebView2CookieManager;
      function  GetEnvironment : ICoreWebView2Environment;
      function  GetIsSuspended : boolean;
      function  GetSettings : ICoreWebView2Settings;
      function  GetIsMuted : boolean;
      function  GetIsDocumentPlayingAudio : boolean;
      function  GetIsDefaultDownloadDialogOpen : boolean;
      function  GetDefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment;
      function  GetDefaultDownloadDialogMargin : TPoint;
      function  GetStatusBarText : wvstring;
      function  GetProfile : ICoreWebView2Profile;
      function  GetFaviconURI : wvstring;

      procedure SetIsMuted(aValue : boolean);
      procedure SetDefaultDownloadDialogCornerAlignment(aValue : TWVDefaultDownloadDialogCornerAlignment);
      procedure SetDefaultDownloadDialogMargin(aValue : TPoint);

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure UnsubscribeAllDevToolsProtocolEvents;
      procedure RemoveAllEvents;

      function  AddNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddSourceChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddHistoryChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddDocumentTitleChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddNewWindowRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWebResourceRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddScriptDialogOpeningEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddProcessFailedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddContainsFullScreenElementChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWindowCloseRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWebResourceResponseReceivedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameCreatedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddDownloadStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddClientCertificateRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddIsMutedChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddIsDocumentPlayingAudioChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddIsDefaultDownloadDialogOpenChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddBasicAuthenticationRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddContextMenuRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddStatusBarTextChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddServerCertificateErrorDetectedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFaviconChanged(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2); reintroduce;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      function    SubscribeToDevToolsProtocolEvent(const aEventName: wvstring; aEventID : integer; const aBrowserComponent : TComponent) : boolean;
      function    CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream; const aBrowserComponent : TComponent) : boolean;
      function    ExecuteScript(const JavaScript : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      function    GoBack : boolean;
      function    GoForward : boolean;
      function    Navigate(const aURI : wvstring) : boolean;
      function    NavigateToString(const aHTMLContent : wvstring) : boolean;
      function    NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;
      function    Reload : boolean;
      function    Stop : boolean;
      function    TrySuspend(const aHandler: ICoreWebView2TrySuspendCompletedHandler) : boolean;
      function    Resume : boolean;
      function    SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
      function    ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;
      function    OpenTaskManagerWindow : boolean;
      function    PrintToPdf(const aResultFilePath : wvstring; const aPrintSettings : ICoreWebView2PrintSettings; const aHandler : ICoreWebView2PrintToPdfCompletedHandler) : boolean;
      function    OpenDevToolsWindow : boolean;
      function    PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
      function    PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
      function    CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      function    CallDevToolsProtocolMethodForSession(const aSessionId, aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      function    AddWebResourceRequestedFilter(const URI : wvstring; ResourceContext: TWVWebResourceContext) : boolean;
      function    RemoveWebResourceRequestedFilter(const URI : wvstring; ResourceContext: TWVWebResourceContext) : boolean;
      function    AddHostObjectToScript(const aName : wvstring; const aObject : OleVariant): boolean;
      function    RemoveHostObjectFromScript(const aName : wvstring) : boolean;
      function    AddScriptToExecuteOnDocumentCreated(const JavaScript : wvstring; const aBrowserComponent : TComponent) : boolean;
      function    RemoveScriptToExecuteOnDocumentCreated(const aID : wvstring) : boolean;
      function    OpenDefaultDownloadDialog : boolean;
      function    CloseDefaultDownloadDialog : boolean;
      function    ClearServerCertificateErrorActions(const aBrowserComponent : TComponent) : boolean;
      function    GetFavicon(aFormat: TWVFaviconImageFormat; const aBrowserComponent : TComponent) : boolean;
      function    Print(const aPrintSettings: ICoreWebView2PrintSettings; const aHandler: ICoreWebView2PrintCompletedHandler): boolean;
      function    ShowPrintUI(aPrintDialogKind: TWVPrintDialogKind): boolean;
      function    PrintToPdfStream(const aPrintSettings: ICoreWebView2PrintSettings; const aHandler: ICoreWebView2PrintToPdfStreamCompletedHandler): boolean;
      function    PostSharedBufferToScript(const aSharedBuffer: ICoreWebView2SharedBuffer; aAccess: TWVSharedBufferAccess; const aAdditionalDataAsJson: wvstring): boolean;

      property Initialized                          : boolean                                   read GetInitialized;
      property BaseIntf                             : ICoreWebView2                             read FBaseIntf;
      property Settings                             : ICoreWebView2Settings                     read GetSettings;
      property BrowserProcessID                     : DWORD                                     read GetBrowserProcessID;
      property CanGoBack                            : boolean                                   read GetCanGoBack;
      property CanGoForward                         : boolean                                   read GetCanGoForward;
      property ContainsFullScreenElement            : boolean                                   read GetContainsFullScreenElement;
      property DocumentTitle                        : wvstring                                  read GetDocumentTitle;
      property Source                               : wvstring                                  read GetSource;
      property CookieManager                        : ICoreWebView2CookieManager                read GetCookieManager;
      property Environment                          : ICoreWebView2Environment                  read GetEnvironment;
      property IsSuspended                          : boolean                                   read GetIsSuspended;
      property IsMuted                              : boolean                                   read GetIsMuted                               write SetIsMuted;
      property IsDocumentPlayingAudio               : boolean                                   read GetIsDocumentPlayingAudio;
      property IsDefaultDownloadDialogOpen          : boolean                                   read GetIsDefaultDownloadDialogOpen;
      property DefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment   read GetDefaultDownloadDialogCornerAlignment  write SetDefaultDownloadDialogCornerAlignment;
      property DefaultDownloadDialogMargin          : TPoint                                    read GetDefaultDownloadDialogMargin           write SetDefaultDownloadDialogMargin;
      property StatusBarText                        : wvstring                                  read GetStatusBarText;
      property Profile                              : ICoreWebView2Profile                      read GetProfile;
      property FaviconURI                           : wvstring                                  read GetFaviconURI;
  end;

implementation

uses
  uWVBrowserBase, uWVCoreWebView2Delegates, uWVMiscFunctions;

constructor TCoreWebView2.Create(const aBaseIntf : ICoreWebView2);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_2,  FBaseIntf2)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_3,  FBaseIntf3)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_4,  FBaseIntf4)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_5,  FBaseIntf5)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_6,  FBaseIntf6)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_7,  FBaseIntf7)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_8,  FBaseIntf8)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_9,  FBaseIntf9)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_10, FBaseIntf10) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_11, FBaseIntf11) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_12, FBaseIntf12) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_13, FBaseIntf13) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_14, FBaseIntf14) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_15, FBaseIntf15) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_16, FBaseIntf16) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_17, FBaseIntf17);
end;

destructor TCoreWebView2.Destroy;
begin
  try
    RemoveAllEvents;

    if (FDevToolsEventTokens <> nil) then
      begin
        Finalize(FDevToolsEventTokens);
        FDevToolsEventTokens := nil;
      end;

    if (FDevToolsEventNames <> nil) then
      FreeAndNil(FDevToolsEventNames);

    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2.AfterConstruction;
begin
  inherited AfterConstruction;

  FDevToolsEventNames := TStringList.Create;
end;

procedure TCoreWebView2.InitializeFields;
begin
  FBaseIntf            := nil;
  FBaseIntf2           := nil;
  FBaseIntf3           := nil;
  FBaseIntf4           := nil;
  FBaseIntf5           := nil;
  FBaseIntf6           := nil;
  FBaseIntf7           := nil;
  FBaseIntf8           := nil;
  FBaseIntf9           := nil;
  FBaseIntf10          := nil;
  FBaseIntf11          := nil;
  FBaseIntf12          := nil;
  FBaseIntf13          := nil;
  FBaseIntf14          := nil;
  FBaseIntf15          := nil;
  FBaseIntf16          := nil;
  FBaseIntf17          := nil;
  FDevToolsEventTokens := nil;
  FDevToolsEventNames  := nil;

  InitializeTokens;
end;

procedure TCoreWebView2.InitializeTokens;
begin
  FContainsFullScreenElementChangedToken.value   := 0;
  FContentLoadingToken.value                     := 0;
  FDocumentTitleChangedToken.value               := 0;
  FFrameNavigationStartingToken.value            := 0;
  FFrameNavigationCompletedToken.value           := 0;
  FHistoryChangedToken.value                     := 0;
  FNavigationStartingToken.value                 := 0;
  FNavigationCompletedToken.value                := 0;
  FNewWindowRequestedToken.value                 := 0;
  FPermissionRequestedToken.value                := 0;
  FProcessFailedToken.value                      := 0;
  FScriptDialogOpeningToken.value                := 0;
  FSourceChangedToken.value                      := 0;
  FWebResourceRequestedToken.value               := 0;
  FWebMessageReceivedToken.value                 := 0;
  FWindowCloseRequestedToken.value               := 0;
  FWebResourceResponseReceivedToken.value        := 0;
  FDOMContentLoadedToken.value                   := 0;
  FFrameCreatedToken.value                       := 0;
  FDownloadStartingToken.value                   := 0;
  FClientCertificateRequestedToken.value         := 0;
  FIsMutedChangedToken.value                     := 0;
  FIsDocumentPlayingAudioChangedToken.value      := 0;
  FIsDefaultDownloadDialogOpenChangedToken.value := 0;
  FBasicAuthenticationRequestedToken.value       := 0;
  FContextMenuRequestedToken.value               := 0;
  FStatusBarTextChangedToken.value               := 0;
  FServerCertificateErrorDetectedToken.value     := 0;
  FFaviconChangedToken.value                     := 0;
end;

function TCoreWebView2.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

procedure TCoreWebView2.RemoveAllEvents;
begin
  try
    try
      if Initialized then
        begin
          if (FNavigationStartingToken.value <> 0) then
            FBaseIntf.remove_NavigationStarting(FNavigationStartingToken);

          if (FNavigationCompletedToken.value <> 0) then
            FBaseIntf.remove_NavigationCompleted(FNavigationCompletedToken);

          if (FSourceChangedToken.value <> 0) then
            FBaseIntf.remove_SourceChanged(FSourceChangedToken);

          if (FHistoryChangedToken.value <> 0) then
            FBaseIntf.remove_HistoryChanged(FHistoryChangedToken);

          if (FContentLoadingToken.value <> 0) then
            FBaseIntf.remove_ContentLoading(FContentLoadingToken);

          if (FDocumentTitleChangedToken.value <> 0) then
            FBaseIntf.remove_DocumentTitleChanged(FDocumentTitleChangedToken);

          if (FNewWindowRequestedToken.value <> 0) then
            FBaseIntf.remove_NewWindowRequested(FNewWindowRequestedToken);

          if (FFrameNavigationStartingToken.value <> 0) then
            FBaseIntf.remove_FrameNavigationStarting(FFrameNavigationStartingToken);

          if (FFrameNavigationCompletedToken.value <> 0) then
            FBaseIntf.remove_FrameNavigationCompleted(FFrameNavigationCompletedToken);

          if (FWebResourceRequestedToken.value <> 0) then
            FBaseIntf.remove_WebResourceRequested(FWebResourceRequestedToken);

          if (FScriptDialogOpeningToken.value <> 0) then
            FBaseIntf.remove_ScriptDialogOpening(FScriptDialogOpeningToken);

          if (FPermissionRequestedToken.value <> 0) then
            FBaseIntf.remove_PermissionRequested(FPermissionRequestedToken);

          if (FProcessFailedToken.value <> 0) then
            FBaseIntf.remove_ProcessFailed(FProcessFailedToken);

          if (FWebMessageReceivedToken.value <> 0) then
            FBaseIntf.remove_WebMessageReceived(FWebMessageReceivedToken);

          if (FWindowCloseRequestedToken.value <> 0) then
            FBaseIntf.remove_WindowCloseRequested(FWindowCloseRequestedToken);

          if (FContainsFullScreenElementChangedToken.value <> 0) then
            FBaseIntf.remove_ContainsFullScreenElementChanged(FContainsFullScreenElementChangedToken);

          if assigned(FBaseIntf2) then
            begin
              if (FWebResourceResponseReceivedToken.value <> 0) then
                FBaseIntf2.remove_WebResourceResponseReceived(FWebResourceResponseReceivedToken);

              if (FDOMContentLoadedToken.value <> 0) then
                FBaseIntf2.remove_DOMContentLoaded(FDOMContentLoadedToken);
            end;

          if assigned(FBaseIntf4) then
            begin
              if (FFrameCreatedToken.value <> 0) then
                FBaseIntf4.remove_FrameCreated(FFrameCreatedToken);

              if (FDownloadStartingToken.value <> 0) then
                FBaseIntf4.remove_DownloadStarting(FDownloadStartingToken);
            end;

//          Access violation when we try to remove this event
//          if assigned(FBaseIntf5) and
//             (FClientCertificateRequestedToken.value <> 0) then
//            FBaseIntf5.remove_ClientCertificateRequested(FClientCertificateRequestedToken);

          if assigned(FBaseIntf8) then
            begin
              if (FIsMutedChangedToken.value <> 0) then
                FBaseIntf8.remove_IsMutedChanged(FIsMutedChangedToken);

              if (FIsDocumentPlayingAudioChangedToken.value <> 0) then
                FBaseIntf8.remove_IsDocumentPlayingAudioChanged(FIsDocumentPlayingAudioChangedToken);
            end;

          if assigned(FBaseIntf9) and
             (FIsDefaultDownloadDialogOpenChangedToken.value <> 0) then
            FBaseIntf9.remove_IsDefaultDownloadDialogOpenChanged(FIsDefaultDownloadDialogOpenChangedToken);

          if assigned(FBaseIntf10) and
             (FBasicAuthenticationRequestedToken.Value <> 0) then
            FBaseIntf10.remove_BasicAuthenticationRequested(FBasicAuthenticationRequestedToken);

          if assigned(FBaseIntf11) and
             (FContextMenuRequestedToken.Value <> 0) then
            FBaseIntf11.remove_ContextMenuRequested(FContextMenuRequestedToken);

          if assigned(FBaseIntf12) and
             (FStatusBarTextChangedToken.Value <> 0) then
            FBaseIntf12.remove_StatusBarTextChanged(FStatusBarTextChangedToken);

//          Access violation when we try to remove this event
//          if assigned(FBaseIntf14) and
//             (FServerCertificateErrorDetectedToken.Value <> 0) then
//            FBaseIntf14.remove_ServerCertificateErrorDetected(FServerCertificateErrorDetectedToken);

          if assigned(FBaseIntf15) and
             (FFaviconChangedToken.Value <> 0) then
            FBaseIntf15.remove_FaviconChanged(FFaviconChangedToken);

          UnsubscribeAllDevToolsProtocolEvents;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TCoreWebView2.RemoveAllEvents', e) then raise;
    end;
  finally
    InitializeTokens;
  end;
end;

function TCoreWebView2.AddNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationStartingEventHandler;
begin
  Result := False;

  if Initialized and (FNavigationStartingToken.value = 0) then
    try
      TempHandler := TCoreWebView2NavigationStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_NavigationStarting(TempHandler, FNavigationStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationCompletedEventHandler;
begin
  Result := False;

  if Initialized and (FNavigationCompletedToken.value = 0) then
    try
      TempHandler := TCoreWebView2NavigationCompletedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_NavigationCompleted(TempHandler, FNavigationCompletedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddSourceChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2SourceChangedEventHandler;
begin
  Result := False;

  if Initialized and (FSourceChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2SourceChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_SourceChanged(TempHandler, FSourceChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddHistoryChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2HistoryChangedEventHandler;
begin
  Result := False;

  if Initialized and (FHistoryChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2HistoryChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_HistoryChanged(TempHandler, FHistoryChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ContentLoadingEventHandler;
begin
  Result := False;

  if Initialized and (FContentLoadingToken.value = 0) then
    try
      TempHandler := TCoreWebView2ContentLoadingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ContentLoading(TempHandler, FContentLoadingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddDocumentTitleChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2DocumentTitleChangedEventHandler;
begin
  Result := False;

  if Initialized and (FDocumentTitleChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2DocumentTitleChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_DocumentTitleChanged(TempHandler, FDocumentTitleChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddNewWindowRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NewWindowRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FNewWindowRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2NewWindowRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_NewWindowRequested(TempHandler, FNewWindowRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationStartingEventHandler;
begin
  Result := False;

  if Initialized and (FFrameNavigationStartingToken.value  = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_FrameNavigationStarting(TempHandler, FFrameNavigationStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationCompletedEventHandler;
begin
  Result := False;

  if Initialized and (FFrameNavigationCompletedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationCompletedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_FrameNavigationCompleted(TempHandler, FFrameNavigationCompletedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWebResourceRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WebResourceRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FWebResourceRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WebResourceRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_WebResourceRequested(TempHandler, FWebResourceRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddScriptDialogOpeningEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ScriptDialogOpeningEventHandler;
begin
  Result := False;

  if Initialized and (FScriptDialogOpeningToken.value = 0) then
    try
      TempHandler := TCoreWebView2ScriptDialogOpeningEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ScriptDialogOpening(TempHandler, FScriptDialogOpeningToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2PermissionRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FPermissionRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2PermissionRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_PermissionRequested(TempHandler, FPermissionRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddProcessFailedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ProcessFailedEventHandler;
begin
  Result := False;

  if Initialized and (FProcessFailedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ProcessFailedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ProcessFailed(TempHandler, FProcessFailedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WebMessageReceivedEventHandler;
begin
  Result := False;

  if Initialized and (FWebMessageReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WebMessageReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_WebMessageReceived(TempHandler, FWebMessageReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddContainsFullScreenElementChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ContainsFullScreenElementChangedEventHandler;
begin
  Result := False;

  if Initialized and (FContainsFullScreenElementChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ContainsFullScreenElementChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ContainsFullScreenElementChanged(TempHandler, FContainsFullScreenElementChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWindowCloseRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WindowCloseRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FWindowCloseRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WindowCloseRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_WindowCloseRequested(TempHandler, FWindowCloseRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWebResourceResponseReceivedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WebResourceResponseReceivedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FWebResourceResponseReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WebResourceResponseReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf2.add_WebResourceResponseReceived(TempHandler, FWebResourceResponseReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2DOMContentLoadedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FDOMContentLoadedToken.value = 0) then
    try
      TempHandler := TCoreWebView2DOMContentLoadedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf2.add_DOMContentLoaded(TempHandler, FDOMContentLoadedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFrameCreatedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameCreatedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf4) and (FFrameCreatedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameCreatedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf4.add_FrameCreated(TempHandler, FFrameCreatedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddDownloadStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2DownloadStartingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf4) and (FDownloadStartingToken.value = 0) then
    try
      TempHandler := TCoreWebView2DownloadStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf4.add_DownloadStarting(TempHandler, FDownloadStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddClientCertificateRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ClientCertificateRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf5) and (FClientCertificateRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ClientCertificateRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf5.add_ClientCertificateRequested(TempHandler, FClientCertificateRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddIsMutedChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2IsMutedChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FIsMutedChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2IsMutedChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf8.add_IsMutedChanged(TempHandler, FIsMutedChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddIsDocumentPlayingAudioChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2IsDocumentPlayingAudioChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FIsDocumentPlayingAudioChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2IsDocumentPlayingAudioChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf8.add_IsDocumentPlayingAudioChanged(TempHandler, FIsDocumentPlayingAudioChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddIsDefaultDownloadDialogOpenChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf9) and (FIsDefaultDownloadDialogOpenChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf9.add_IsDefaultDownloadDialogOpenChanged(TempHandler, FIsDefaultDownloadDialogOpenChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddBasicAuthenticationRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BasicAuthenticationRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf10) and (FBasicAuthenticationRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2BasicAuthenticationRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf10.add_BasicAuthenticationRequested(TempHandler, FBasicAuthenticationRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddContextMenuRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ContextMenuRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf11) and (FContextMenuRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ContextMenuRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf11.add_ContextMenuRequested(TempHandler, FContextMenuRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddStatusBarTextChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2StatusBarTextChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf12) and (FStatusBarTextChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2StatusBarTextChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf12.add_StatusBarTextChanged(TempHandler, FStatusBarTextChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddServerCertificateErrorDetectedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ServerCertificateErrorDetectedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf14) and (FServerCertificateErrorDetectedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ServerCertificateErrorDetectedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf14.add_ServerCertificateErrorDetected(TempHandler, FServerCertificateErrorDetectedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFaviconChanged(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FaviconChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf15) and (FFaviconChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FaviconChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf15.add_FaviconChanged(TempHandler, FFaviconChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddNavigationStartingEvent(aBrowserComponent)                 and
            AddNavigationCompletedEvent(aBrowserComponent)                and
            AddSourceChangedEvent(aBrowserComponent)                      and
            AddHistoryChangedEvent(aBrowserComponent)                     and
            AddContentLoadingEvent(aBrowserComponent)                     and
            AddDocumentTitleChangedEvent(aBrowserComponent)               and
            AddNewWindowRequestedEvent(aBrowserComponent)                 and
            AddFrameNavigationStartingEvent(aBrowserComponent)            and
            AddFrameNavigationCompletedEvent(aBrowserComponent)           and
            AddWebResourceRequestedEvent(aBrowserComponent)               and
            AddScriptDialogOpeningEvent(aBrowserComponent)                and
            AddPermissionRequestedEvent(aBrowserComponent)                and
            AddProcessFailedEvent(aBrowserComponent)                      and
            AddWebMessageReceivedEvent(aBrowserComponent)                 and
            AddContainsFullScreenElementChangedEvent(aBrowserComponent)   and
            AddWindowCloseRequestedEvent(aBrowserComponent)               and
            AddWebResourceResponseReceivedEvent(aBrowserComponent)        and
            AddDOMContentLoadedEvent(aBrowserComponent)                   and
            AddFrameCreatedEvent(aBrowserComponent)                       and
            AddDownloadStartingEvent(aBrowserComponent)                   and
            AddClientCertificateRequestedEvent(aBrowserComponent)         and
            AddIsMutedChangedEvent(aBrowserComponent)                     and
            AddIsDocumentPlayingAudioChangedEvent(aBrowserComponent)      and
            AddIsDefaultDownloadDialogOpenChangedEvent(aBrowserComponent) and
            AddBasicAuthenticationRequestedEvent(aBrowserComponent)       and
            AddContextMenuRequestedEvent(aBrowserComponent)               and
            AddStatusBarTextChangedEvent(aBrowserComponent)               and
            AddServerCertificateErrorDetectedEvent(aBrowserComponent)     and
            AddFaviconChanged(aBrowserComponent);
end;

function TCoreWebView2.AddWebResourceRequestedFilter(const URI             : wvstring;
                                                           ResourceContext : TWVWebResourceContext) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.AddWebResourceRequestedFilter(PWideChar(URI), ResourceContext));
end;

function TCoreWebView2.RemoveWebResourceRequestedFilter(const URI             : wvstring;
                                                              ResourceContext : TWVWebResourceContext) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveWebResourceRequestedFilter(PWideChar(URI), ResourceContext));
end;

function TCoreWebView2.CapturePreview(      aImageFormat      : TWVCapturePreviewImageFormat;
                                      const aImageStream      : IStream;
                                      const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2CapturePreviewCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2CapturePreviewCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.CapturePreview(aImageFormat, aImageStream, TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.SubscribeToDevToolsProtocolEvent(const aEventName        : wvstring;
                                                              aEventID          : integer;
                                                        const aBrowserComponent : TComponent) : boolean;
var
  TempReceiver : ICoreWebView2DevToolsProtocolEventReceiver;
  TempHandler  : ICoreWebView2DevToolsProtocolEventReceivedEventHandler;
  TempToken    : EventRegistrationToken;
  i            : integer;
begin
  Result := False;

  if Initialized and
     (FDevToolsEventNames <> nil) and
     {$IFDEF FPC}
     (FDevToolsEventNames.IndexOf(UTF8Encode(aEventName)) < 0) and
     {$ELSE}      
     (FDevToolsEventNames.IndexOf(aEventName) < 0) and
     {$ENDIF}
     succeeded(FBaseIntf.GetDevToolsProtocolEventReceiver(PWideChar(aEventName), TempReceiver)) then
    try
      TempHandler := TCoreWebView2DevToolsProtocolEventReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent), aEventName, aEventID);

      if succeeded(TempReceiver.add_DevToolsProtocolEventReceived(TempHandler, TempToken)) then
        begin
          {$IFDEF FPC}
          FDevToolsEventNames.Add(UTF8Encode(aEventName));
          {$ELSE}
          FDevToolsEventNames.Add(aEventName);
          {$ENDIF}
          i := length(FDevToolsEventTokens);
          SetLength(FDevToolsEventTokens, succ(i));
          FDevToolsEventTokens[i] := TempToken;
          Result := True;
        end;
    finally
      TempHandler := nil;
    end;
end;

procedure TCoreWebView2.UnsubscribeAllDevToolsProtocolEvents;
var
  TempReceiver  : ICoreWebView2DevToolsProtocolEventReceiver;
  i             : integer;
  TempEventName : wvstring;
begin
  if (FDevToolsEventNames = nil) or (FDevToolsEventNames.Count = 0) or not(Initialized) then
    exit;

  try
    try
      i := pred(FDevToolsEventNames.Count);

      while (i >= 0) do
        begin
          {$IFDEF FPC}
          TempEventName := UTF8Decode(FDevToolsEventNames[i]);
          {$ELSE}
          TempEventName := FDevToolsEventNames[i];
          {$ENDIF}
          if succeeded(FBaseIntf.GetDevToolsProtocolEventReceiver(PWideChar(TempEventName), TempReceiver)) then
            TempReceiver.remove_DevToolsProtocolEventReceived(FDevToolsEventTokens[i]);

          dec(i);
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TCoreWebView2.UnsubscribeAllDevToolsProtocolEvents', e) then raise;
    end;
  finally
    FDevToolsEventNames.Clear;
    SetLength(FDevToolsEventTokens, 0);
  end;
end;

function TCoreWebView2.ExecuteScript(const JavaScript: wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ExecuteScriptCompletedHandler;
begin
  Result := False;

  if Initialized and (length(JavaScript) > 0) then
    try
      TempHandler := TCoreWebView2ExecuteScriptCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf.ExecuteScript(PWideChar(JavaScript), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.GoBack : boolean;
begin
  Result := CanGoBack and
            succeeded(FBaseIntf.GoBack);
end;

function TCoreWebView2.GoForward : boolean;
begin
  Result := CanGoForward and
            succeeded(FBaseIntf.GoForward);
end;

function TCoreWebView2.Navigate(const aURI : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Navigate(PWideChar(aURI)));
end;

function TCoreWebView2.NavigateToString(const aHTMLContent : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.NavigateToString(PWideChar(aHTMLContent)));
end;

function TCoreWebView2.NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.NavigateWithWebResourceRequest(aRequest));
end;

function TCoreWebView2.Reload : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Reload);
end;

function TCoreWebView2.Stop : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Stop);
end;

function TCoreWebView2.TrySuspend(const aHandler: ICoreWebView2TrySuspendCompletedHandler) : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.TrySuspend(aHandler));
end;

function TCoreWebView2.Resume : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Resume);
end;

function TCoreWebView2.SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.SetVirtualHostNameToFolderMapping(PWideChar(aHostName), PWideChar(aFolderPath), aAccessKind));
end;

function TCoreWebView2.ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.ClearVirtualHostNameToFolderMapping(PWideChar(aHostName)));
end;

function TCoreWebView2.OpenTaskManagerWindow : boolean;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.OpenTaskManagerWindow);
end;

function TCoreWebView2.PrintToPdf(const aResultFilePath : wvstring;
                                  const aPrintSettings  : ICoreWebView2PrintSettings;
                                  const aHandler        : ICoreWebView2PrintToPdfCompletedHandler) : boolean;
begin
  Result := False;

  if assigned(FBaseIntf7)          and
     (length(aResultFilePath) > 0) and
     assigned(aPrintSettings)      and
     assigned(aHandler)            then
    Result := succeeded(FBaseIntf7.PrintToPdf(PWideChar(aResultFilePath), aPrintSettings, aHandler));
end;

function TCoreWebView2.OpenDevToolsWindow : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.OpenDevToolsWindow);
end;

function TCoreWebView2.PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.PostWebMessageAsJson(PWideChar(aWebMessageAsJson)));
end;

function TCoreWebView2.PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.PostWebMessageAsString(PWideChar(aWebMessageAsString)));
end;

function TCoreWebView2.CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2CallDevToolsProtocolMethodCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf.CallDevToolsProtocolMethod(PWideChar(aMethodName), PWideChar(aParametersAsJson), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.CallDevToolsProtocolMethodForSession(const aSessionId, aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2CallDevToolsProtocolMethodCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf11) then
    try
      TempHandler := TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf11.CallDevToolsProtocolMethodForSession(PWideChar(aSessionId), PWideChar(aMethodName), PWideChar(aParametersAsJson), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddHostObjectToScript(const aName : wvstring; const aObject : OleVariant) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.AddHostObjectToScript(PWideChar(aName), aObject));
end;

function TCoreWebView2.RemoveHostObjectFromScript(const aName : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveHostObjectFromScript(PWideChar(aName)));
end;

function TCoreWebView2.AddScriptToExecuteOnDocumentCreated(const JavaScript : wvstring; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.AddScriptToExecuteOnDocumentCreated(PWideChar(JavaScript), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.RemoveScriptToExecuteOnDocumentCreated(const aID : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveScriptToExecuteOnDocumentCreated(PWideChar(aID)));
end;

function TCoreWebView2.OpenDefaultDownloadDialog : boolean;
begin
  Result := assigned(FBaseIntf9) and
            succeeded(FBaseIntf9.OpenDefaultDownloadDialog);
end;

function TCoreWebView2.CloseDefaultDownloadDialog : boolean;
begin
  Result := assigned(FBaseIntf9) and
            succeeded(FBaseIntf9.CloseDefaultDownloadDialog);
end;

function TCoreWebView2.ClearServerCertificateErrorActions(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf14) then
    try
      TempHandler := TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf14.ClearServerCertificateErrorActions(TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.GetFavicon(aFormat: TWVFaviconImageFormat; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2GetFaviconCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf15) then
    try
      TempHandler := TCoreWebView2GetFaviconCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf15.GetFavicon(aFormat, TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.Print(const aPrintSettings : ICoreWebView2PrintSettings;
                             const aHandler       : ICoreWebView2PrintCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf16) and
            succeeded(FBaseIntf16.Print(aPrintSettings, aHandler));
end;

function TCoreWebView2.ShowPrintUI(aPrintDialogKind: TWVPrintDialogKind): boolean;
begin
  Result := assigned(FBaseIntf16) and
            succeeded(FBaseIntf16.ShowPrintUI(aPrintDialogKind));
end;

function TCoreWebView2.PrintToPdfStream(const aPrintSettings : ICoreWebView2PrintSettings;
                                        const aHandler       : ICoreWebView2PrintToPdfStreamCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf16) and
            succeeded(FBaseIntf16.PrintToPdfStream(aPrintSettings, aHandler));
end;

function TCoreWebView2.PostSharedBufferToScript(const aSharedBuffer         : ICoreWebView2SharedBuffer;
                                                      aAccess               : TWVSharedBufferAccess;
                                                const aAdditionalDataAsJson : wvstring): boolean;
begin
  Result := assigned(FBaseIntf17) and
            succeeded(FBaseIntf17.PostSharedBufferToScript(aSharedBuffer, aAccess, PWideChar(aAdditionalDataAsJson)));
end;

function TCoreWebView2.GetBrowserProcessID : cardinal;
var
  TempID : DWORD;
begin
  if Initialized and succeeded(FBaseIntf.Get_BrowserProcessId(TempID)) then
    Result := TempID
   else
    Result := 0;
end;

function TCoreWebView2.GetCanGoBack : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_CanGoBack(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2.GetCanGoForward : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_CanGoForward(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2.GetContainsFullScreenElement : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ContainsFullScreenElement(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2.GetDocumentTitle : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.get_DocumentTitle(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2.GetSource : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.get_Source(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2.GetCookieManager : ICoreWebView2CookieManager;
var
  TempResult : ICoreWebView2CookieManager;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_CookieManager(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetEnvironment : ICoreWebView2Environment;
var
  TempResult : ICoreWebView2Environment;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_Environment(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetIsSuspended : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Get_IsSuspended(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetSettings : ICoreWebView2Settings;
var
  TempResult : ICoreWebView2Settings;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_Settings(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetIsMuted : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf8) and
            succeeded(FBaseIntf8.Get_IsMuted(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetIsDocumentPlayingAudio : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf8) and
            succeeded(FBaseIntf8.Get_IsDocumentPlayingAudio(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetIsDefaultDownloadDialogOpen : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf9) and
            succeeded(FBaseIntf9.Get_IsDefaultDownloadDialogOpen(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetDefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment;
var
  TempResult : COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT;
begin
  if assigned(FBaseIntf9) and
     succeeded(FBaseIntf9.Get_DefaultDownloadDialogCornerAlignment(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2.GetDefaultDownloadDialogMargin : TPoint;
var
  TempResult : tagPOINT;
begin
  if assigned(FBaseIntf9) and
     succeeded(FBaseIntf9.Get_DefaultDownloadDialogMargin(TempResult)) then
    Result := TPoint(TempResult)
   else
    Result := point(0, 0);
end;

function TCoreWebView2.GetStatusBarText : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf12) and
     succeeded(FBaseIntf12.Get_StatusBarText(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2.GetProfile : ICoreWebView2Profile;
var
  TempResult : ICoreWebView2Profile;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf13) and
     succeeded(FBaseIntf13.Get_Profile(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetFaviconURI : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf15) and
     succeeded(FBaseIntf15.Get_FaviconUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

procedure TCoreWebView2.SetIsMuted(aValue : boolean);
begin
  if assigned(FBaseIntf8) then
    FBaseIntf8.Set_IsMuted(ord(aValue));
end;

procedure TCoreWebView2.SetDefaultDownloadDialogCornerAlignment(aValue : TWVDefaultDownloadDialogCornerAlignment);
begin
  if assigned(FBaseIntf9) then
    FBaseIntf9.Set_DefaultDownloadDialogCornerAlignment(aValue);
end;

procedure TCoreWebView2.SetDefaultDownloadDialogMargin(aValue : TPoint);
begin
  if assigned(FBaseIntf9) then
    FBaseIntf9.Set_DefaultDownloadDialogMargin(tagPOINT(aValue));
end;

end.
