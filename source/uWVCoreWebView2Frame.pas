unit uWVCoreWebView2Frame;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  {$IFDEF FPC}
  Classes, ActiveX,
  {$ELSE}
  System.Classes, Winapi.ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Frame = class
    protected
      FBaseIntf                     : ICoreWebView2Frame;
      FNameChangedToken             : EventRegistrationToken;
      FDestroyedToken               : EventRegistrationToken;
      FFrameID                      : integer;

      function GetInitialized : boolean;
      function GetName : wvstring;
      function GetIsDestroyed : boolean;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddFrameNameChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameDestroyedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Frame; aFrameID : integer); reintroduce;
      destructor  Destroy; override;
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      function    AddHostObjectToScriptWithOrigins(const aName : wvstring; const aObject : OleVariant; aOriginsCount : cardinal; var aOrigins : wvstring) : boolean;
      function    RemoveHostObjectFromScript(const aName : wvstring) : boolean;

      property Initialized         : boolean                         read GetInitialized;
      property BaseIntf            : ICoreWebView2Frame              read FBaseIntf;
      property FrameID             : integer                         read FFrameID;
      property Name                : wvstring                        read GetName;
      property IsDestroyed         : boolean                         read GetIsDestroyed;
  end;

implementation

uses
  uWVBrowserBase, uWVCoreWebView2Delegates;

constructor TCoreWebView2Frame.Create(const aBaseIntf: ICoreWebView2Frame; aFrameID : integer);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
  FFrameID  := aFrameID;
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
  FBaseIntf := nil;
  FFrameID  := 0;

  InitializeTokens;
end;

procedure TCoreWebView2Frame.InitializeTokens;
begin
  FNameChangedToken.value := 0;
  FDestroyedToken.value   := 0;
end;

procedure TCoreWebView2Frame.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FNameChangedToken.value <> 0) then
        FBaseIntf.remove_NameChanged(FNameChangedToken);

      if (FDestroyedToken.value <> 0) then
        FBaseIntf.remove_Destroyed(FDestroyedToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2Frame.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddFrameNameChangedEvent(aBrowserComponent) and
            AddFrameDestroyedEvent(aBrowserComponent);
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

end.
