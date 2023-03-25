unit uWVCoreWebView2Environment;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows, System.Classes, System.Types, Winapi.ActiveX, System.SysUtils,
  {$ELSE}
  Windows, Classes, ActiveX, SysUtils,
  {$ENDIF}
  uWVInterfaces, uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Environment = class
    protected
      FBaseIntf                             : ICoreWebView2Environment;
      FBaseIntf2                            : ICoreWebView2Environment2;
      FBaseIntf3                            : ICoreWebView2Environment3;
      FBaseIntf4                            : ICoreWebView2Environment4;
      FBaseIntf5                            : ICoreWebView2Environment5;
      FBaseIntf6                            : ICoreWebView2Environment6;
      FBaseIntf7                            : ICoreWebView2Environment7;
      FBaseIntf8                            : ICoreWebView2Environment8;
      FBaseIntf9                            : ICoreWebView2Environment9;
      FBaseIntf10                           : ICoreWebView2Environment10;
      FBaseIntf11                           : ICoreWebView2Environment11;
      FBaseIntf12                           : ICoreWebView2Environment12;
      FNewBrowserVersionAvailableEventToken : EventRegistrationToken;
      FBrowserProcessExitedEventToken       : EventRegistrationToken;
      FProcessInfosChangedEventToken        : EventRegistrationToken;

      function  GetInitialized : boolean;
      function  GetBrowserVersionInfo : wvstring;
      function  GetSupportsCompositionController : boolean;
      function  GetSupportsControllerOptions : boolean;
      function  GetUserDataFolder : wvstring;
      function  GetProcessInfos : ICoreWebView2ProcessInfoCollection;
      function  GetFailureReportFolderPath : wvstring;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddNewBrowserVersionAvailableEvent(const aLoaderComponent : TComponent) : boolean;
      function  AddBrowserProcessExitedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
      function  AddBrowserProcessExitedBrowserEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddProcessInfosChangedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
      function  AddProcessInfosChangedBrowserEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Environment); reintroduce;
      destructor  Destroy; override;
      function    AddAllLoaderEvents(const aLoaderComponent : TComponent) : boolean;
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      function    CreateCoreWebView2Controller(aParentWindow : THandle; const aBrowserEvents : IWVBrowserEvents; var aResult: HRESULT) : boolean;
      function    CreateWebResourceResponse(const aContent : IStream; aStatusCode : integer; aReasonPhrase, aHeaders : wvstring; var aResponse : ICoreWebView2WebResourceResponse) : boolean;
      function    CreateWebResourceRequest(const aURI, aMethod : wvstring; const aPostData : IStream; const aHeaders : wvstring; var aRequest : ICoreWebView2WebResourceRequest): boolean;
      function    CreateCoreWebView2CompositionController(aParentWindow : THandle; const aBrowserEvents : IWVBrowserEvents; var aResult: HRESULT) : boolean;
      function    CreateCoreWebView2PointerInfo(var aPointerInfo : ICoreWebView2PointerInfo) : boolean;
      function    GetAutomationProviderForWindow(aHandle : THandle; var aProvider : IUnknown) : boolean;
      function    CreatePrintSettings(var aPrintSettings : ICoreWebView2PrintSettings) : boolean;
      function    CreateContextMenuItem(const aLabel : wvstring; const aIconStream : IStream; aKind : TWVMenuItemKind; var aMenuItem : ICoreWebView2ContextMenuItem) : boolean;
      function    CreateCoreWebView2ControllerOptions(var aOptions: ICoreWebView2ControllerOptions): boolean;
      function    CreateCoreWebView2ControllerWithOptions(aParentWindow: HWND; const aOptions: ICoreWebView2ControllerOptions; const aBrowserEvents: IWVBrowserEvents; var aResult: HResult): boolean;
      function    CreateCoreWebView2CompositionControllerWithOptions(aParentWindow: HWND; const aOptions: ICoreWebView2ControllerOptions; const aBrowserEvents: IWVBrowserEvents; var aResult: HResult): boolean;
      function    CreateSharedBuffer(aSize : Largeuint; var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;

      property    Initialized                   : boolean                             read GetInitialized;
      property    BaseIntf                      : ICoreWebView2Environment            read FBaseIntf;
      property    BrowserVersionInfo            : wvstring                            read GetBrowserVersionInfo;
      property    SupportsCompositionController : boolean                             read GetSupportsCompositionController;
      property    SupportsControllerOptions     : boolean                             read GetSupportsControllerOptions;
      property    UserDataFolder                : wvstring                            read GetUserDataFolder;
      property    ProcessInfos                  : ICoreWebView2ProcessInfoCollection  read GetProcessInfos;
      property    FailureReportFolderPath       : wvstring                            read GetFailureReportFolderPath;
  end;

implementation

uses
  uWVMiscFunctions, uWVCoreWebView2Delegates, uWVBrowserBase, uWVLoader;

constructor TCoreWebView2Environment.Create(const aBaseIntf : ICoreWebView2Environment);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment2,  FBaseIntf2)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment3,  FBaseIntf3)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment4,  FBaseIntf4)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment5,  FBaseIntf5)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment6,  FBaseIntf6)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment7,  FBaseIntf7)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment8,  FBaseIntf8)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment9,  FBaseIntf9)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment10, FBaseIntf10) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment11, FBaseIntf11) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment12, FBaseIntf12);
end;

destructor TCoreWebView2Environment.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2Environment.InitializeFields;
begin
  FBaseIntf   := nil;
  FBaseIntf2  := nil;
  FBaseIntf3  := nil;
  FBaseIntf4  := nil;
  FBaseIntf5  := nil;
  FBaseIntf6  := nil;
  FBaseIntf7  := nil;
  FBaseIntf8  := nil;
  FBaseIntf9  := nil;
  FBaseIntf10 := nil;
  FBaseIntf11 := nil;
  FBaseIntf12 := nil;

  InitializeTokens;
end;

procedure TCoreWebView2Environment.InitializeTokens;
begin
  FNewBrowserVersionAvailableEventToken.value := 0;
  FBrowserProcessExitedEventToken.value       := 0;
  FProcessInfosChangedEventToken.value        := 0;
end;

function TCoreWebView2Environment.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

procedure TCoreWebView2Environment.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FNewBrowserVersionAvailableEventToken.value <> 0) then
        FBaseIntf.remove_NewBrowserVersionAvailable(FNewBrowserVersionAvailableEventToken);

      if assigned(FBaseIntf5) and (FBrowserProcessExitedEventToken.value <> 0) then
        FBaseIntf5.remove_BrowserProcessExited(FBrowserProcessExitedEventToken);

      if assigned(FBaseIntf8) and (FProcessInfosChangedEventToken.value <> 0) then
        FBaseIntf8.remove_ProcessInfosChanged(FProcessInfosChangedEventToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2Environment.AddAllLoaderEvents(const aLoaderComponent : TComponent) : boolean;
begin
  Result := AddNewBrowserVersionAvailableEvent(aLoaderComponent) and
            AddBrowserProcessExitedLoaderEvent(aLoaderComponent) and
            AddProcessInfosChangedLoaderEvent(aLoaderComponent);
end;         

function TCoreWebView2Environment.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddBrowserProcessExitedBrowserEvent(aBrowserComponent) and
            AddProcessInfosChangedBrowserEvent(aBrowserComponent);
end;

function TCoreWebView2Environment.AddNewBrowserVersionAvailableEvent(const aLoaderComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NewBrowserVersionAvailableEventHandler;
begin
  Result := False;

  if Initialized and (FNewBrowserVersionAvailableEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2NewBrowserVersionAvailableEventHandler.Create(TWVLoader(aLoaderComponent));
      Result      := succeeded(FBaseIntf.add_NewBrowserVersionAvailable(TempHandler, FNewBrowserVersionAvailableEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddBrowserProcessExitedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BrowserProcessExitedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf5) and (FBrowserProcessExitedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2BrowserProcessExitedEventHandler.Create(TWVLoader(aLoaderComponent));
      Result      := succeeded(FBaseIntf5.add_BrowserProcessExited(TempHandler, FBrowserProcessExitedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddBrowserProcessExitedBrowserEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BrowserProcessExitedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf5) and (FBrowserProcessExitedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2BrowserProcessExitedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf5.add_BrowserProcessExited(TempHandler, FBrowserProcessExitedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddProcessInfosChangedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ProcessInfosChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FProcessInfosChangedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2ProcessInfosChangedEventHandler.Create(TWVLoader(aLoaderComponent));
      Result      := succeeded(FBaseIntf8.add_ProcessInfosChanged(TempHandler, FProcessInfosChangedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddProcessInfosChangedBrowserEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ProcessInfosChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FProcessInfosChangedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2ProcessInfosChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf8.add_ProcessInfosChanged(TempHandler, FProcessInfosChangedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateCoreWebView2Controller(      aParentWindow  : THandle;
                                                               const aBrowserEvents : IWVBrowserEvents;
                                                               var   aResult        : HRESULT) : boolean;
var
  TempHandler : ICoreWebView2CreateCoreWebView2ControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if Initialized then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf.CreateCoreWebView2Controller(aParentWindow, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateWebResourceResponse(const aContent      : IStream;
                                                                  aStatusCode   : integer;
                                                                  aReasonPhrase : wvstring;
                                                                  aHeaders      : wvstring;
                                                            var   aResponse     : ICoreWebView2WebResourceResponse) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.CreateWebResourceResponse(aContent,
                                                          aStatusCode,
                                                          PWideChar(aReasonPhrase),
                                                          PWideChar(aHeaders),
                                                          aResponse));
end;

function TCoreWebView2Environment.CreateWebResourceRequest(const aURI      : wvstring;
                                                           const aMethod   : wvstring;
                                                           const aPostData : IStream;
                                                           const aHeaders  : wvstring;
                                                           var   aRequest  : ICoreWebView2WebResourceRequest): boolean;
begin
  aRequest := nil;
  Result   := assigned(FBaseIntf2) and
              succeeded(FBaseIntf2.CreateWebResourceRequest(PWideChar(aURI),
                                                            PWideChar(aMethod),
                                                            aPostData,
                                                            PWideChar(aHeaders),
                                                            aRequest));
end;

function TCoreWebView2Environment.GetBrowserVersionInfo: wvstring;
var
  TempVersionInfo : PWideChar;
begin
  Result := '';

  if Initialized then
    begin
      TempVersionInfo := nil;

      if succeeded(FBaseIntf.Get_BrowserVersionString(TempVersionInfo)) then
        begin
          Result := TempVersionInfo;
          CoTaskMemFree(TempVersionInfo);
        end;
   end;
end;

function TCoreWebView2Environment.GetSupportsCompositionController : boolean;
begin
  Result := assigned(FBaseIntf3);
end;

function TCoreWebView2Environment.GetSupportsControllerOptions : boolean;
begin
  Result := assigned(FBaseIntf10);
end;

function TCoreWebView2Environment.CreateCoreWebView2CompositionController(      aParentWindow  : THandle;
                                                                          const aBrowserEvents : IWVBrowserEvents;
                                                                          var   aResult        : HRESULT) : boolean;
var
  TempHandler : ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if assigned(FBaseIntf3) then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf3.CreateCoreWebView2CompositionController(aParentWindow, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateCoreWebView2PointerInfo(var aPointerInfo: ICoreWebView2PointerInfo) : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.CreateCoreWebView2PointerInfo(aPointerInfo));
end;

function TCoreWebView2Environment.GetAutomationProviderForWindow(aHandle : THandle; var aProvider: IUnknown) : boolean;
begin
  aProvider := nil;
  Result    := assigned(FBaseIntf4) and
               succeeded(FBaseIntf4.GetAutomationProviderForWindow(aHandle, aProvider));
end;

function TCoreWebView2Environment.CreatePrintSettings(var aPrintSettings: ICoreWebView2PrintSettings): boolean;
begin
  aPrintSettings := nil;
  Result         := assigned(FBaseIntf6) and
                    succeeded(FBaseIntf6.CreatePrintSettings(aPrintSettings)) and
                    assigned(aPrintSettings);
end;

function TCoreWebView2Environment.CreateContextMenuItem(const aLabel      : wvstring;
                                                        const aIconStream : IStream;
                                                              aKind       : TWVMenuItemKind;
                                                        var   aMenuItem   : ICoreWebView2ContextMenuItem) : boolean;
begin
  aMenuItem := nil;
  Result    := assigned(FBaseIntf9) and
               succeeded(FBaseIntf9.CreateContextMenuItem(PWideChar(aLabel), aIconStream, aKind, aMenuItem)) and
               assigned(aMenuItem);
end;

function TCoreWebView2Environment.CreateCoreWebView2ControllerOptions(var aOptions: ICoreWebView2ControllerOptions): boolean;
begin
  aOptions := nil;
  Result   := assigned(FBaseIntf10) and
              succeeded(FBaseIntf10.CreateCoreWebView2ControllerOptions(aOptions)) and
              assigned(aOptions);
end;

function TCoreWebView2Environment.CreateCoreWebView2ControllerWithOptions(      aParentWindow  : HWND;
                                                                          const aOptions       : ICoreWebView2ControllerOptions;
                                                                          const aBrowserEvents : IWVBrowserEvents;
                                                                          var   aResult        : HResult): boolean;
var
  TempHandler : ICoreWebView2CreateCoreWebView2ControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if assigned(FBaseIntf10) then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf10.CreateCoreWebView2ControllerWithOptions(aParentWindow, aOptions, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateCoreWebView2CompositionControllerWithOptions(      aParentWindow  : HWND;
                                                                                     const aOptions       : ICoreWebView2ControllerOptions;
                                                                                     const aBrowserEvents : IWVBrowserEvents;
                                                                                     var   aResult        : HResult): boolean;
var
  TempHandler: ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if assigned(FBaseIntf10) then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf10.CreateCoreWebView2CompositionControllerWithOptions(aParentWindow, aOptions, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateSharedBuffer(    aSize         : Largeuint;
                                                     var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;
var
  TempBuffer : ICoreWebView2SharedBuffer;
begin
  Result        := False;
  TempBuffer    := nil;
  aSharedBuffer := nil;

  if assigned(FBaseIntf12) and
     succeeded(FBaseIntf12.CreateSharedBuffer(aSize, TempBuffer)) and
     (TempBuffer <> nil) then
    begin
      aSharedBuffer := TempBuffer;
      Result        := True;
    end;
end;

function TCoreWebView2Environment.GetUserDataFolder : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if assigned(FBaseIntf7) then
    begin
      TempString := nil;

      if succeeded(FBaseIntf7.Get_UserDataFolder(TempString)) then
        begin
          Result := TempString;
          CoTaskMemFree(TempString);
        end;
   end;
end;

function TCoreWebView2Environment.GetProcessInfos : ICoreWebView2ProcessInfoCollection;
var
  TempResult : ICoreWebView2ProcessInfoCollection;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf8) and
     succeeded(FBaseIntf8.GetProcessInfos(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2Environment.GetFailureReportFolderPath : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if assigned(FBaseIntf11) then
    begin
      TempString := nil;

      if succeeded(FBaseIntf11.Get_FailureReportFolderPath(TempString)) then
        begin
          Result := TempString;
          CoTaskMemFree(TempString);
        end;
   end;
end;

end.
