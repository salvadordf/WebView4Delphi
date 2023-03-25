unit uWVCoreWebView2Frame;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, Winapi.ActiveX,
  {$ELSE}
  Classes, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Frame = class
    protected
      FBaseIntf                                : ICoreWebView2Frame;
      FBaseIntf2                               : ICoreWebView2Frame2;
      FBaseIntf3                               : ICoreWebView2Frame3;
      FBaseIntf4                               : ICoreWebView2Frame4;
      FNameChangedToken                        : EventRegistrationToken;
      FDestroyedToken                          : EventRegistrationToken;
      FFrameNavigationStartingToken            : EventRegistrationToken;
      FFrameNavigationCompletedToken           : EventRegistrationToken;
      FFrameContentLoadingToken                : EventRegistrationToken;
      FFrameDOMContentLoadedToken              : EventRegistrationToken;
      FFrameWebMessageReceivedToken            : EventRegistrationToken;
      FPermissionRequestedToken                : EventRegistrationToken;
      FFrameID                                 : integer;

      function GetInitialized : boolean;
      function GetName : wvstring;
      function GetIsDestroyed : boolean;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddFrameNameChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameDestroyedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Frame; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      function    AddHostObjectToScriptWithOrigins(const aName : wvstring; const aObject : OleVariant; aOriginsCount : cardinal; var aOrigins : wvstring) : boolean;
      function    RemoveHostObjectFromScript(const aName : wvstring) : boolean;
      function    ExecuteScript(const JavaScript : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      function    PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
      function    PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
      function    PostSharedBufferToScript(const aSharedBuffer: ICoreWebView2SharedBuffer; aAccess: TWVSharedBufferAccess; const aAdditionalDataAsJson: wvstring): boolean;

      property Initialized         : boolean                         read GetInitialized;
      property BaseIntf            : ICoreWebView2Frame              read FBaseIntf;
      property FrameID             : integer                         read FFrameID;
      property Name                : wvstring                        read GetName;
      property IsDestroyed         : boolean                         read GetIsDestroyed;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates;

constructor TCoreWebView2Frame.Create(const aBaseIntf: ICoreWebView2Frame; aFrameID : integer);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
  FFrameID  := aFrameID;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame3, FBaseIntf3) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame4, FBaseIntf4);
end;

destructor TCoreWebView2Frame.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2Frame.InitializeFields;
begin
  FBaseIntf   := nil;
  FBaseIntf2  := nil;
  FBaseIntf3  := nil;
  FFrameID    := 0;

  InitializeTokens;
end;

procedure TCoreWebView2Frame.InitializeTokens;
begin
  FNameChangedToken.value              := 0;
  FDestroyedToken.value                := 0;
  FFrameNavigationStartingToken.value  := 0;
  FFrameNavigationCompletedToken.value := 0;
  FFrameContentLoadingToken.value      := 0;
  FFrameDOMContentLoadedToken.value    := 0;
  FFrameWebMessageReceivedToken.value  := 0;
  FPermissionRequestedToken.value      := 0;
end;

procedure TCoreWebView2Frame.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FNameChangedToken.value <> 0) then
        FBaseIntf.remove_NameChanged(FNameChangedToken);

      if (FDestroyedToken.value <> 0) then
        FBaseIntf.remove_Destroyed(FDestroyedToken);

      if assigned(FBaseIntf2) then
        begin
          if (FFrameNavigationStartingToken.value <> 0) then
            FBaseIntf2.remove_NavigationStarting(FFrameNavigationStartingToken);

          if (FFrameNavigationCompletedToken.value <> 0) then
            FBaseIntf2.remove_NavigationCompleted(FFrameNavigationCompletedToken);

          if (FFrameContentLoadingToken.value <> 0) then
            FBaseIntf2.remove_ContentLoading(FFrameContentLoadingToken);

          if (FFrameDOMContentLoadedToken.value <> 0) then
            FBaseIntf2.remove_DOMContentLoaded(FFrameDOMContentLoadedToken);

          if (FFrameWebMessageReceivedToken.value <> 0) then
            FBaseIntf2.remove_WebMessageReceived(FFrameWebMessageReceivedToken);
        end;

      if assigned(FBaseIntf3) and
         (FPermissionRequestedToken.value <> 0) then
        FBaseIntf3.remove_PermissionRequested(FPermissionRequestedToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2Frame.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddFrameNameChangedEvent(aBrowserComponent)         and
            AddFrameDestroyedEvent(aBrowserComponent)           and
            AddFrameNavigationStartingEvent(aBrowserComponent)  and
            AddFrameNavigationCompletedEvent(aBrowserComponent) and
            AddFrameContentLoadingEvent(aBrowserComponent)      and
            AddFrameDOMContentLoadedEvent(aBrowserComponent)    and
            AddFrameWebMessageReceivedEvent(aBrowserComponent)  and
            AddPermissionRequestedEvent(aBrowserComponent);
end;

function TCoreWebView2Frame.AddFrameNameChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameNameChangedEventHandler;
begin
  Result := False;

  if Initialized and (FNameChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameNameChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf.add_NameChanged(TempHandler, FNameChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameDestroyedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameDestroyedEventHandler;
begin
  Result := False;

  if Initialized and (FDestroyedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameDestroyedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf.add_Destroyed(TempHandler, FDestroyedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameNavigationStartingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameNavigationStartingToken.value  = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationStartingEventHandler2.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf2.add_NavigationStarting(TempHandler, FFrameNavigationStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameNavigationCompletedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameNavigationCompletedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationCompletedEventHandler2.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf2.add_NavigationCompleted(TempHandler, FFrameNavigationCompletedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameContentLoadingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameContentLoadingToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameContentLoadingEventHandler.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf2.add_ContentLoading(TempHandler, FFrameContentLoadingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameDOMContentLoadedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameDOMContentLoadedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameDOMContentLoadedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf2.add_DOMContentLoaded(TempHandler, FFrameDOMContentLoadedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameWebMessageReceivedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameWebMessageReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameWebMessageReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf2.add_WebMessageReceived(TempHandler, FFrameWebMessageReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FramePermissionRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf3) and (FPermissionRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FramePermissionRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FFrameID);
      Result      := succeeded(FBaseIntf3.add_PermissionRequested(TempHandler, FPermissionRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Frame.GetName : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Name(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2Frame.GetIsDestroyed : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.IsDestroyed(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Frame.AddHostObjectToScriptWithOrigins(const aName : wvstring; const aObject : OleVariant; aOriginsCount : cardinal; var aOrigins : wvstring) : boolean;
var
  TempOrigins : PWideChar;
begin
  Result      := False;
  aOrigins    := '';
  TempOrigins := nil;

  if Initialized  and
     succeeded(FBaseIntf.AddHostObjectToScriptWithOrigins(PWideChar(aName), aObject, aOriginsCount, TempOrigins)) then
    begin
      Result := True;

      if assigned(TempOrigins) then
        aOrigins := TempOrigins;
    end;
end;

function TCoreWebView2Frame.RemoveHostObjectFromScript(const aName : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveHostObjectFromScript(PWideChar(aName)));
end;

function TCoreWebView2Frame.ExecuteScript(const JavaScript: wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ExecuteScriptCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (length(JavaScript) > 0) then
    try
      TempHandler := TCoreWebView2ExecuteScriptCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf2.ExecuteScript(PWideChar(JavaScript), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.PostWebMessageAsJson(PWideChar(aWebMessageAsJson)));
end;

function TCoreWebView2Frame.PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.PostWebMessageAsString(PWideChar(aWebMessageAsString)));
end;

function TCoreWebView2Frame.PostSharedBufferToScript(const aSharedBuffer         : ICoreWebView2SharedBuffer;
                                                           aAccess               : TWVSharedBufferAccess;
                                                     const aAdditionalDataAsJson : wvstring): boolean;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.PostSharedBufferToScript(aSharedBuffer, aAccess, PWideChar(aAdditionalDataAsJson)));
end;

end.
