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
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Moves focus into WebView.  WebView gets focus and focus is set to
      /// correspondent element in the page hosted in the WebView.  For
      /// Programmatic reason, focus is set to previously focused element or the
      /// default element if no previously focused element exists.  For `Next`
      /// reason, focus is set to the first element.  For `Previous` reason, focus
      /// is set to the last element.  WebView changes focus through user
      /// interaction including selecting into a WebView or Tab into it.  For
      /// tabbing, the app runs MoveFocus with Next or Previous to align with Tab
      /// and Shift+Tab respectively when it decides the WebView is the next
      /// element that may exist in a tab.  Or, the app runs `IsDialogMessage`
      /// as part of the associated message loop to allow the platform to auto
      /// handle tabbing.  The platform rotates through all windows with
      /// `WS_TABSTOP`.  When the WebView gets focus from `IsDialogMessage`, it is
      /// internally put the focus on the first or last element for tab and
      /// Shift+Tab respectively.
      /// </summary>
      function    MoveFocus(aReason : TWVMoveFocusReason) : boolean;
      /// <summary>
      /// Closes the WebView and cleans up the underlying browser instance.
      /// Cleaning up the browser instance releases the resources powering the
      /// WebView.  The browser instance is shut down if no other WebViews are
      /// using it.
      ///
      /// After running `Close`, most methods will fail and event handlers stop
      /// running.  Specifically, the WebView releases the associated references to
      /// any associated event handlers when `Close` is run.
      ///
      /// `Close` is implicitly run when the `CoreWebView2Controller` loses the
      /// final reference and is destructed.  But it is best practice to
      /// explicitly run `Close` to avoid any accidental cycle of references
      /// between the WebView and the app code.  Specifically, if you capture a
      /// reference to the WebView in an event handler you create a reference cycle
      /// between the WebView and the event handler.  Run `Close` to break the
      /// cycle by releasing all event handlers.  But to avoid the situation, it is
      /// best to both explicitly run `Close` on the WebView and to not capture a
      /// reference to the WebView to ensure the WebView is cleaned up correctly.
      /// `Close` is synchronous and won't trigger the `beforeunload` event.
      /// </summary>
      function    Close : boolean;
      /// <summary>
      /// Updates `aBounds` and `aZoomFactor` properties at the same time.  This
      /// operation is atomic from the perspective of the host.  After returning
      /// from this function, the `aBounds` and `aZoomFactor` properties are both
      /// updated if the function is successful, or neither is updated if the
      /// function fails.  If `aBounds` and `aZoomFactor` are both updated by the
      /// same scale (for example, `aBounds` and `aZoomFactor` are both doubled),
      /// then the page does not display a change in `window.innerWidth` or
      /// `window.innerHeight` and the WebView renders the content at the new size
      /// and zoom without intermediate renderings.  This function also updates
      /// just one of `aZoomFactor` or `aBounds` by passing in the new value for one
      /// and the current value for the other.
      /// </summary>
      function    SetBoundsAndZoomFactor(aBounds: TRect; const aZoomFactor: double) : boolean;
      /// <summary>
      /// This is a notification separate from `Bounds` that tells WebView that the
      ///  main WebView parent (or any ancestor) `HWND` moved.  This is needed
      /// for accessibility and certain dialogs in WebView to work correctly.
      /// </summary>
      function    NotifyParentWindowPositionChanged : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                     : boolean                  read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                        : ICoreWebView2Controller  read FBaseIntf;
      /// <summary>
      /// The zoom factor for the WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_zoomfactor">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property ZoomFactor                      : double                   read GetZoomFactor                       write SetZoomFactor;
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
      property IsVisible                       : boolean                  read GetIsVisible                        write SetIsVisible;
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
      property Bounds                          : TRect                    read GetBounds                           write SetBounds;
      /// <summary>
      /// The parent window provided by the app that this WebView is using to
      /// render content.  This API initially returns the window passed into
      /// `CreateCoreWebView2Controller`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_parentwindow">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property ParentWindow                    : THandle                  read GetParentWindow                     write SetParentWindow;
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
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller2#get_defaultbackgroundcolor">See the ICoreWebView2Controller2 article.</see></para>
      /// </remarks>
      property DefaultBackgroundColor          : TColor                   read GetDefaultBackgroundColor           write SetDefaultBackgroundColor;
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
      property RasterizationScale              : double                   read GetRasterizationScale               write SetRasterizationScale;
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
      property ShouldDetectMonitorScaleChanges : boolean                  read GetShouldDetectMonitorScaleChanges  write SetShouldDetectMonitorScaleChanges;
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
      property BoundsMode                      : TWVBoundsMode            read GetBoundsMode                       write SetBoundsMode;
      /// <summary>
      /// Gets the `CoreWebView2` associated with this `CoreWebView2Controller`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller#get_corewebview2">See the ICoreWebView2Controller article.</see></para>
      /// </remarks>
      property CoreWebView2                    : ICoreWebView2            read GetCoreWebView2;
      /// <summary>
      /// Gets the `AllowExternalDrop` property which is used to configure the
      /// capability that dragging objects from outside the bounds of webview2 and
      /// dropping into webview2 is allowed or disallowed. The default value is
      /// TRUE.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller4#get_allowexternaldrop">See the ICoreWebView2Controller4 article.</see></para>
      /// </remarks>
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
var
  TempColor : COREWEBVIEW2_COLOR;
begin
  if assigned(FBaseIntf2) then
    begin
      TempColor := DelphiColorToCoreWebViewColor(aValue);

      // The only supported alpha values are 0 (transparent) and 255 (opaque).
      if not(TempColor.A in [0, 255]) then
        TempColor.A := 255;

      FBaseIntf2.Set_DefaultBackgroundColor(TempColor);
    end;
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
