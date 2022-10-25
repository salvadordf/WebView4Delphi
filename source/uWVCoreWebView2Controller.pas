unit uWVCoreWebView2Controller;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, System.Types, System.UITypes, Winapi.Windows, System.SysUtils,
  {$ELSE}
  Classes, Graphics, Windows, SysUtils,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Controller = class
    protected
      FBaseIntf                       : ICoreWebView2Controller;
      FBaseIntf2                      : ICoreWebView2Controller2;
      FBaseIntf3                      : ICoreWebView2Controller3;
      FBaseIntf4                      : ICoreWebView2Controller4;
      FAcceleratorKeyPressedToken     : EventRegistrationToken;
      FGotFocusToken                  : EventRegistrationToken;
      FLostFocusToken                 : EventRegistrationToken;
      FMoveFocusRequestedToken        : EventRegistrationToken;
      FZoomFactorChangedToken         : EventRegistrationToken;
      FRasterizationScaleChangedToken : EventRegistrationToken;

      function  GetInitialized : boolean;
      function  GetZoomFactor : double;
      function  GetIsVisible : boolean;
      function  GetBounds : TRect;
      function  GetParentWindow : THandle;
      function  GetDefaultBackgroundColor : TColor;
      function  GetRasterizationScale : double;
      function  GetShouldDetectMonitorScaleChanges : boolean;
      function  GetBoundsMode : TWVBoundsMode;
      function  GetCoreWebView2 : ICoreWebView2;
      function  GetAllowExternalDrop : boolean;

      procedure SetZoomFactor(const aValue : double);
      procedure SetIsVisible(const aValue : boolean);
      procedure SetBounds(aValue : TRect);
      procedure SetParentWindow(aValue : THandle);
      procedure SetDefaultBackgroundColor(const aValue : TColor);
      procedure SetRasterizationScale(const aValue : double);
      procedure SetShouldDetectMonitorScaleChanges(aValue : boolean);
      procedure SetBoundsMode(aValue : TWVBoundsMode);
      procedure SetAllowExternalDrop(aValue : boolean);

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddAcceleratorKeyPressedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddGotFocusEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddLostFocusEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddMoveFocusRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddZoomFactorChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddRasterizationScaleChangedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Controller); reintroduce;
      destructor  Destroy; override;
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      function    MoveFocus(aReason : TWVMoveFocusReason) : boolean;
      function    Close : boolean;
      function    SetBoundsAndZoomFactor(aBounds: TRect; const aZoomFactor: double) : boolean;
      function    NotifyParentWindowPositionChanged : boolean;

      property Initialized                     : boolean                  read GetInitialized;
      property BaseIntf                        : ICoreWebView2Controller  read FBaseIntf;
      property ZoomFactor                      : double                   read GetZoomFactor                       write SetZoomFactor;
      property IsVisible                       : boolean                  read GetIsVisible                        write SetIsVisible;
      property Bounds                          : TRect                    read GetBounds                           write SetBounds;
      property ParentWindow                    : THandle                  read GetParentWindow                     write SetParentWindow;
      property DefaultBackgroundColor          : TColor                   read GetDefaultBackgroundColor           write SetDefaultBackgroundColor;
      property RasterizationScale              : double                   read GetRasterizationScale               write SetRasterizationScale;
      property ShouldDetectMonitorScaleChanges : boolean                  read GetShouldDetectMonitorScaleChanges  write SetShouldDetectMonitorScaleChanges;
      property BoundsMode                      : TWVBoundsMode            read GetBoundsMode                       write SetBoundsMode;
      property CoreWebView2                    : ICoreWebView2            read GetCoreWebView2;
      property AllowExternalDrop               : boolean                  read GetAllowExternalDrop                write SetAllowExternalDrop;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates;

constructor TCoreWebView2Controller.Create(const aBaseIntf : ICoreWebView2Controller);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Controller2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Controller3, FBaseIntf3) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Controller4, FBaseIntf4);
end;

destructor TCoreWebView2Controller.Destroy;
begin
  try
    RemoveAllEvents;
    Close;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2Controller.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
  FBaseIntf4 := nil;

  InitializeTokens;
end;

procedure TCoreWebView2Controller.InitializeTokens;
begin
  FAcceleratorKeyPressedToken.value     := 0;
  FGotFocusToken.value                  := 0;
  FLostFocusToken.value                 := 0;
  FMoveFocusRequestedToken.value        := 0;
  FZoomFactorChangedToken.value         := 0;
  FRasterizationScaleChangedToken.value := 0;
end;

function TCoreWebView2Controller.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

procedure TCoreWebView2Controller.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FAcceleratorKeyPressedToken.value <> 0) then
        FBaseIntf.remove_AcceleratorKeyPressed(FAcceleratorKeyPressedToken);

      if (FGotFocusToken.value <> 0) then
        FBaseIntf.remove_GotFocus(FGotFocusToken);

      if (FLostFocusToken.value <> 0) then
        FBaseIntf.remove_LostFocus(FLostFocusToken);

      if (FMoveFocusRequestedToken.value <> 0) then
        FBaseIntf.remove_MoveFocusRequested(FMoveFocusRequestedToken);

      if (FZoomFactorChangedToken.value <> 0) then
        FBaseIntf.remove_ZoomFactorChanged(FZoomFactorChangedToken);

      if assigned(FBaseIntf3) and (FRasterizationScaleChangedToken.value <> 0) then
        FBaseIntf3.remove_RasterizationScaleChanged(FRasterizationScaleChangedToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2Controller.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddAcceleratorKeyPressedEvent(aBrowserComponent) and
            AddGotFocusEvent(aBrowserComponent)              and
            AddLostFocusEvent(aBrowserComponent)             and
            AddMoveFocusRequestedEvent(aBrowserComponent)    and
            AddZoomFactorChangedEvent(aBrowserComponent)     and
            AddRasterizationScaleChangedEvent(aBrowserComponent);
end;

function TCoreWebView2Controller.AddAcceleratorKeyPressedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2AcceleratorKeyPressedEventHandler;
begin
  Result := False;

  if Initialized and (FAcceleratorKeyPressedToken.value = 0) then
    try
      TempHandler := TCoreWebView2AcceleratorKeyPressedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_AcceleratorKeyPressed(TempHandler, FAcceleratorKeyPressedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Controller.AddGotFocusEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FocusChangedEventHandler;
begin
  Result := False;

  if Initialized and (FGotFocusToken.value = 0) then
    try
      TempHandler := TCoreWebView2GotFocusEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_GotFocus(TempHandler, FGotFocusToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Controller.AddLostFocusEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FocusChangedEventHandler;
begin
  Result := False;

  if Initialized and (FLostFocusToken.value = 0) then
    try
      TempHandler := TCoreWebView2LostFocusEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_LostFocus(TempHandler, FLostFocusToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Controller.AddMoveFocusRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2MoveFocusRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FMoveFocusRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2MoveFocusRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_MoveFocusRequested(TempHandler, FMoveFocusRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Controller.AddZoomFactorChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ZoomFactorChangedEventHandler;
begin
  Result := False;

  if Initialized and (FZoomFactorChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ZoomFactorChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ZoomFactorChanged(TempHandler, FZoomFactorChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Controller.AddRasterizationScaleChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2RasterizationScaleChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf3) and (FRasterizationScaleChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2RasterizationScaleChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf3.add_RasterizationScaleChanged(TempHandler, FRasterizationScaleChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Controller.MoveFocus(aReason : TWVMoveFocusReason) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.MoveFocus(aReason));
end;

function TCoreWebView2Controller.Close : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Close);
end;

function TCoreWebView2Controller.GetCoreWebView2 : ICoreWebView2;
var
  TempResult : ICoreWebView2;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_CoreWebView2(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2Controller.GetAllowExternalDrop : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.Get_AllowExternalDrop(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Controller.SetBoundsAndZoomFactor(aBounds: TRect; const aZoomFactor: double) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.SetBoundsAndZoomFactor(tagRECT(aBounds), aZoomFactor));
end;

function TCoreWebView2Controller.NotifyParentWindowPositionChanged : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.NotifyParentWindowPositionChanged);
end;

function TCoreWebView2Controller.GetZoomFactor : double;
var
  TempResult : double;
begin
  if Initialized and succeeded(FBaseIntf.Get_ZoomFactor(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

procedure TCoreWebView2Controller.SetZoomFactor(const aValue : double);
begin
  if Initialized then
    FBaseIntf.Set_ZoomFactor(aValue);
end;

procedure TCoreWebView2Controller.SetBounds(aValue : TRect);
begin
  if Initialized then
    FBaseIntf.Set_Bounds(tagRECT(aValue));
end;

procedure TCoreWebView2Controller.SetParentWindow(aValue : THandle);
begin
  if Initialized then
    FBaseIntf.Set_ParentWindow(aValue);
end;

procedure TCoreWebView2Controller.SetDefaultBackgroundColor(const aValue : TColor);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_DefaultBackgroundColor(DelphiColorToCoreWebViewColor(aValue));
end;

procedure TCoreWebView2Controller.SetRasterizationScale(const aValue : double);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_RasterizationScale(aValue);
end;

procedure TCoreWebView2Controller.SetShouldDetectMonitorScaleChanges(aValue : boolean);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_ShouldDetectMonitorScaleChanges(ord(aValue));
end;

procedure TCoreWebView2Controller.SetBoundsMode(aValue : TWVBoundsMode);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_BoundsMode(aValue);
end;

procedure TCoreWebView2Controller.SetAllowExternalDrop(aValue : boolean);
begin
  if assigned(FBaseIntf4) then
    FBaseIntf4.Set_AllowExternalDrop(ord(aValue));
end;

function TCoreWebView2Controller.GetIsVisible : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsVisible(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Controller.GetBounds : TRect;
var
  TempRect : tagRECT;
begin
  TempRect.left   := 0;
  TempRect.top    := 0;
  TempRect.right  := 0;
  TempRect.bottom := 0;

  if Initialized and succeeded(FBaseIntf.Get_Bounds(TempRect)) then
    Result := TRect(TempRect);
end;

function TCoreWebView2Controller.GetParentWindow : THandle;
var
  TempHandle : HWND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ParentWindow(TempHandle)) then
    Result := TempHandle
   else
    Result := 0;
end;

function TCoreWebView2Controller.GetDefaultBackgroundColor : TColor;
var
  TempResult : COREWEBVIEW2_COLOR;
begin
  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_DefaultBackgroundColor(TempResult)) then
    Result := CoreWebViewColorToDelphiColor(TempResult)
   else
    {$IFDEF DELPHI16_UP}
    Result := TColors.SysNone;  // clNone
    {$ELSE}
    Result := clNone;
    {$ENDIF}
end;

function TCoreWebView2Controller.GetRasterizationScale : double;
var
  TempResult : double;
begin
  TempResult := 0;

  if assigned(FBaseIntf3) and
     succeeded(FBaseIntf3.Get_RasterizationScale(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2Controller.GetShouldDetectMonitorScaleChanges : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Get_ShouldDetectMonitorScaleChanges(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Controller.GetBoundsMode : TWVBoundsMode;
var
  TempResult : COREWEBVIEW2_BOUNDS_MODE;
begin
  TempResult := 0;

  if assigned(FBaseIntf3) and
     succeeded(FBaseIntf3.Get_BoundsMode(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

procedure TCoreWebView2Controller.SetIsVisible(const aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsVisible(ord(aValue));
end;

end.
