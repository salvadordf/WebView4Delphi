unit uWVCoreWebView2CompositionController;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, System.Types, Winapi.Windows, Winapi.ActiveX,
  {$ELSE}
  Classes, Windows, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// This interface is an extension of the ICoreWebView2Controller interface to
  /// support visual hosting. An object implementing the
  /// ICoreWebView2CompositionController interface will also implement
  /// ICoreWebView2Controller. Callers are expected to use
  /// ICoreWebView2Controller for resizing, visibility, focus, and so on, and
  /// then use ICoreWebView2CompositionController to connect to a composition
  /// tree and provide input meant for the WebView.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller">See the ICoreWebView2CompositionController article.</see></para>
  /// </remarks>
  TCoreWebView2CompositionController = class
    protected
      FBaseIntf           : ICoreWebView2CompositionController;
      FBaseIntf2          : ICoreWebView2CompositionController2;
      FBaseIntf3          : ICoreWebView2CompositionController3;
      FBaseIntf4          : ICoreWebView2CompositionController4;

      FCursorChangedToken     : EventRegistrationToken;
      FNonClientRegionChanged : EventRegistrationToken;

      function  GetInitialized : boolean;
      function  GetRootVisualTarget : IUnknown;
      function  GetCursor : HCURSOR;
      function  GetSystemCursorID : cardinal;
      function  GetAutomationProvider : IUnknown;

      procedure SetRootVisualTarget(const aValue : IUnknown);

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddCursorChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddNonClientRegionChangedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2CompositionController); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_HORIZONTAL_WHEEL or
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_WHEEL, then mouseData specifies the amount of
      /// wheel movement. A positive value indicates that the wheel was rotated
      /// forward, away from the user; a negative value indicates that the wheel was
      /// rotated backward, toward the user. One wheel click is defined as
      /// WHEEL_DELTA, which is 120.
      /// If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOUBLE_CLICK
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOWN, or
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_UP, then mouseData specifies which X
      /// buttons were pressed or released. This value should be 1 if the first X
      /// button is pressed/released and 2 if the second X button is
      /// pressed/released.
      /// If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE, then virtualKeys,
      /// mouseData, and point should all be zero.
      /// If eventKind is any other value, then mouseData should be zero.
      /// Point is expected to be in the client coordinate space of the WebView.
      /// To track mouse events that start in the WebView and can potentially move
      /// outside of the WebView and host application, calling SetCapture and
      /// ReleaseCapture is recommended.
      /// To dismiss hover popups, it is also recommended to send
      /// COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE messages.
      /// </summary>
      function    SendMouseInput(aEventKind : TWVMouseEventKind; aVirtualKeys : TWVMouseEventVirtualKeys; aMouseData : cardinal; aPoint : TPoint) : boolean;
      /// <summary>
      /// SendPointerInput accepts touch or pen pointer input of types defined in
      /// COREWEBVIEW2_POINTER_EVENT_KIND. Any pointer input from the system must be
      /// converted into an ICoreWebView2PointerInfo first.
      /// </summary>
      function    SendPointerInput(aEventKind : TWVPointerEventKind; const aPointerInfo : ICoreWebView2PointerInfo) : boolean;
      /// <summary>
      /// This function corresponds to [IDropTarget::DragEnter](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragenter).
      ///
      /// This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.
      ///
      /// The hosting application must register as an IDropTarget and implement
      /// and forward DragEnter calls to this function.
      ///
      /// point parameter must be modified to include the WebView's offset and be in
      /// the WebView's client coordinates (Similar to how SendMouseInput works).
      /// </summary>
      function    DragEnter(const dataObject: IDataObject; keyState: LongWord; point: tagPOINT; out effect: LongWord) : HResult;
      /// <summary>
      /// This function corresponds to [IDropTarget::DragLeave](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragleave).
      ///
      /// This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.
      ///
      /// The hosting application must register as an IDropTarget and implement
      /// and forward DragLeave calls to this function.
      /// </summary>
      function    DragLeave : HResult;
      /// <summary>
      /// This function corresponds to [IDropTarget::DragOver](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragover).
      ///
      /// This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.
      ///
      /// The hosting application must register as an IDropTarget and implement
      /// and forward DragOver calls to this function.
      ///
      /// point parameter must be modified to include the WebView's offset and be in
      /// the WebView's client coordinates (Similar to how SendMouseInput works).
      /// </summary>
      function    DragOver(keyState: LongWord; point: tagPOINT; out effect: LongWord) : HResult;
      /// <summary>
      /// This function corresponds to [IDropTarget::Drop](/windows/win32/api/oleidl/nf-oleidl-idroptarget-drop).
      ///
      /// This function has a dependency on AllowExternalDrop property of
      /// CoreWebView2Controller and return E_FAIL to callers to indicate this
      /// operation is not allowed if AllowExternalDrop property is set to false.
      ///
      /// The hosting application must register as an IDropTarget and implement
      /// and forward Drop calls to this function.
      ///
      /// point parameter must be modified to include the WebView's offset and be in
      /// the WebView's client coordinates (Similar to how SendMouseInput works).
      /// </summary>
      function    Drop(const dataObject: IDataObject; keyState: LongWord; point: tagPOINT; out effect: LongWord) : HResult;
      /// <summary>
      /// If you are hosting a WebView2 using CoreWebView2CompositionController, you can call
      /// this method in your Win32 WndProc to determine if the mouse is moving over or
      /// clicking on WebView2 web content that should be considered part of a non-client region.

      /// The point parameter is expected to be in the client coordinate space of WebView2.
      /// The method sets the out parameter value as follows:
      ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_CAPTION when point corresponds to
      ///         a region (HTML element) within the WebView2 with
      ///         `-webkit-app-region: drag` CSS style set.
      ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_CLIENT when point corresponds to
      ///         a region (HTML element) within the WebView2 without
      ///         `-webkit-app-region: drag` CSS style set.
      ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_NOWHERE when point is not within the WebView2.
      ///
      /// NOTE: in order for WebView2 to properly handle the title bar system menu,
      /// the app needs to send WM_NCRBUTTONDOWN and WM_NCRBUTTONUP to SendMouseInput.
      /// See sample code below.
      /// \snippet ViewComponent.cpp DraggableRegions2
      ///
      /// \snippet ViewComponent.cpp DraggableRegions1
      /// </summary>
      function    GetNonClientRegionAtPoint(point: TPoint) : TWVNonClientRegionKind;
      /// <summary>
      /// This method is used to get the collection of rects that correspond
      /// to a particular COREWEBVIEW2_NON_CLIENT_REGION_KIND. This is to be used in
      /// the callback of add_NonClientRegionChanged whose event args object contains
      /// a region property of type COREWEBVIEW2_NON_CLIENT_REGION_KIND.
      ///
      /// \snippet ScenarioNonClientRegionSupport.cpp AddChangeListener
      /// </summary>
      function    QueryNonClientRegion(Kind: TWVNonClientRegionKind): ICoreWebView2RegionRectCollectionView;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized        : boolean                              read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf           : ICoreWebView2CompositionController   read FBaseIntf;
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
      property RootVisualTarget   : IUnknown                             read GetRootVisualTarget     write SetRootVisualTarget;
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
      property Cursor             : HCURSOR                              read GetCursor;
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
      property SystemCursorID     : cardinal                             read GetSystemCursorID;
      /// <summary>
      /// Returns the Automation Provider for the WebView. This object implements
      /// IRawElementProviderSimple.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller2#get_automationprovider">See the ICoreWebView2CompositionController2 article.</see></para>
      /// </remarks>
      property AutomationProvider : IUnknown                             read GetAutomationProvider;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates;

constructor TCoreWebView2CompositionController.Create(const aBaseIntf: ICoreWebView2CompositionController);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2CompositionController2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2CompositionController3, FBaseIntf3) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2CompositionController4, FBaseIntf4);
end;

destructor TCoreWebView2CompositionController.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2CompositionController.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
  FBaseIntf4 := nil;

  InitializeTokens;
end;

procedure TCoreWebView2CompositionController.InitializeTokens;
begin
  FCursorChangedToken.value     := 0;
  FNonClientRegionChanged.value := 0;
end;

function TCoreWebView2CompositionController.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2CompositionController.GetRootVisualTarget : IUnknown;
var
  TempResult : IUnknown;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_RootVisualTarget(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2CompositionController.GetCursor : HCURSOR;
var
  TempResult : HCURSOR;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Cursor(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2CompositionController.GetSystemCursorID : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_SystemCursorId(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2CompositionController.GetAutomationProvider : IUnknown;
var
  TempResult : IUnknown;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_AutomationProvider(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

procedure TCoreWebView2CompositionController.SetRootVisualTarget(const aValue : IUnknown);
begin
  if Initialized then
    FBaseIntf.Set_RootVisualTarget(aValue);
end;

procedure TCoreWebView2CompositionController.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FCursorChangedToken.value <> 0) then
        FBaseIntf.remove_CursorChanged(FCursorChangedToken);

      if (FNonClientRegionChanged.value <> 0) then
        FBaseIntf4.remove_NonClientRegionChanged(FNonClientRegionChanged);

      InitializeTokens;
    end;
end;

function TCoreWebView2CompositionController.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddCursorChangedEvent(aBrowserComponent) and
            AddNonClientRegionChangedEvent(aBrowserComponent);
end;

function TCoreWebView2CompositionController.AddCursorChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2CursorChangedEventHandler;
begin
  Result := False;

  if Initialized and (FCursorChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2CursorChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_CursorChanged(TempHandler, FCursorChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2CompositionController.AddNonClientRegionChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NonClientRegionChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf4) and (FNonClientRegionChanged.value = 0) then
    try
      TempHandler := TCoreWebView2NonClientRegionChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf4.add_NonClientRegionChanged(TempHandler, FNonClientRegionChanged));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2CompositionController.SendMouseInput(aEventKind   : TWVMouseEventKind;
                                                           aVirtualKeys : TWVMouseEventVirtualKeys;
                                                           aMouseData   : cardinal;
                                                           aPoint       : TPoint) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.SendMouseInput(aEventKind, aVirtualKeys, aMouseData, tagPOINT(aPoint)));
end;

function TCoreWebView2CompositionController.SendPointerInput(      aEventKind   : TWVPointerEventKind;
                                                             const aPointerInfo : ICoreWebView2PointerInfo) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.SendPointerInput(aEventKind, aPointerInfo));
end;

function TCoreWebView2CompositionController.DragEnter(const dataObject : IDataObject;
                                                            keyState   : LongWord;
                                                            point      : tagPOINT;
                                                      out   effect     : LongWord) : HResult;
begin
  Result := S_OK;
  effect := DROPEFFECT_NONE;

  if assigned(FBaseIntf3) then
    Result := FBaseIntf3.DragEnter(dataObject, keyState, point, effect);
end;

function TCoreWebView2CompositionController.DragLeave : HResult;
begin
  Result := S_OK;

  if assigned(FBaseIntf3) then
    Result := FBaseIntf3.DragLeave;
end;

function TCoreWebView2CompositionController.DragOver(    keyState : LongWord;
                                                         point    : tagPOINT;
                                                     out effect   : LongWord) : HResult;
begin
  Result := S_OK;
  effect := DROPEFFECT_NONE;

  if assigned(FBaseIntf3) then
    Result := FBaseIntf3.DragOver(keyState, point, effect);
end;

function TCoreWebView2CompositionController.Drop(const dataObject : IDataObject;
                                                       keyState   : LongWord;
                                                       point      : tagPOINT;
                                                 out   effect     : LongWord) : HResult;
begin
  Result := S_OK;
  effect := DROPEFFECT_NONE;

  if assigned(FBaseIntf3) then
    Result := FBaseIntf3.Drop(dataObject, keyState, point, effect);
end;

function TCoreWebView2CompositionController.GetNonClientRegionAtPoint(point: TPoint) : TWVNonClientRegionKind;
var
  TempResult : COREWEBVIEW2_NON_CLIENT_REGION_KIND;
begin
  Result := COREWEBVIEW2_NON_CLIENT_REGION_KIND_NOWHERE;

  if assigned(FBaseIntf4) and
     succeeded(FBaseIntf4.GetNonClientRegionAtPoint(point, TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2CompositionController.QueryNonClientRegion(Kind: TWVNonClientRegionKind): ICoreWebView2RegionRectCollectionView;
var
  TempResult : ICoreWebView2RegionRectCollectionView;
begin
  TempResult := nil;

  if assigned(FBaseIntf4) and
     succeeded(FBaseIntf4.QueryNonClientRegion(Kind, TempResult)) and
     (TempResult <> nil) then
    Result := TempResult
   else
    Result := nil;
end;

end.
