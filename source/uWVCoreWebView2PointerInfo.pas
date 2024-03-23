unit uWVCoreWebView2PointerInfo;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Types, Winapi.ActiveX,
  {$ELSE}
  Types, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// <para>This mostly represents a combined win32
  /// POINTER_INFO/POINTER_TOUCH_INFO/POINTER_PEN_INFO object. It takes fields
  /// from all three and excludes some win32 specific data types like HWND and
  /// HANDLE. Note, sourceDevice is taken out but we expect the PointerDeviceRect
  /// and DisplayRect to cover the existing use cases of sourceDevice.
  /// Another big difference is that any of the point or rect locations are
  /// expected to be in WebView physical coordinates. That is, coordinates
  /// relative to the WebView and no DPI scaling applied.</para>
  /// <para>The PointerId, PointerFlags, ButtonChangeKind, PenFlags, PenMask, TouchFlags,
  /// and TouchMask are all #defined flags or enums in the
  /// POINTER_INFO/POINTER_TOUCH_INFO/POINTER_PEN_INFO structure. We define those
  /// properties here as UINT32 or INT32 and expect the developer to know how to
  /// populate those values based on the Windows definitions.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo">See the ICoreWebView2PointerInfo article.</see></para>
  /// </remarks>
  TCoreWebView2PointerInfo = class
    protected
      FBaseIntf : ICoreWebView2PointerInfo;

      function  GetInitialized : boolean;
      function  GetPointerKind : cardinal;
      function  GetPointerId : cardinal;
      function  GetFrameId : cardinal;
      function  GetPointerFlags : cardinal;
      function  GetPointerDeviceRect : TRect;
      function  GetDisplayRect : TRect;
      function  GetPixelLocation : TPoint;
      function  GetHimetricLocation : TPoint;
      function  GetPixelLocationRaw : TPoint;
      function  GetHimetricLocationRaw : TPoint;
      function  GetTime : cardinal;
      function  GetHistoryCount : cardinal;
      function  GetInputData : integer;
      function  GetKeyStates : cardinal;
      function  GetPerformanceCount : uint64;
      function  GetButtonChangeKind : integer;
      function  GetPenFlags : cardinal;
      function  GetPenMask : cardinal;
      function  GetPenPressure : cardinal;
      function  GetPenRotation : cardinal;
      function  GetPenTiltX : integer;
      function  GetPenTiltY : integer;
      function  GetTouchFlags : cardinal;
      function  GetTouchMask : cardinal;
      function  GetTouchContact : TRect;
      function  GetTouchContactRaw : TRect;
      function  GetTouchOrientation : cardinal;
      function  GetTouchPressure : cardinal;

      procedure SetPointerKind(aValue : cardinal);
      procedure SetPointerId(aValue : cardinal);
      procedure SetFrameId(aValue : cardinal);
      procedure SetPointerFlags(aValue : cardinal);
      procedure SetPointerDeviceRect(aValue : TRect);
      procedure SetDisplayRect(aValue : TRect);
      procedure SetPixelLocation(aValue : TPoint);
      procedure SetHimetricLocation(aValue : TPoint);
      procedure SetPixelLocationRaw(aValue : TPoint);
      procedure SetHimetricLocationRaw(aValue : TPoint);
      procedure SetTime(aValue : cardinal);
      procedure SetHistoryCount(aValue : cardinal);
      procedure SetInputData(aValue : integer);
      procedure SetKeyStates(aValue : cardinal);
      procedure SetPerformanceCount(aValue : uint64);
      procedure SetButtonChangeKind(aValue : integer);
      procedure SetPenFlags(aValue : cardinal);
      procedure SetPenMask(aValue : cardinal);
      procedure SetPenPressure(aValue : cardinal);
      procedure SetPenRotation(aValue : cardinal);
      procedure SetPenTiltX(aValue : integer);
      procedure SetPenTiltY(aValue : integer);
      procedure SetTouchFlags(aValue : cardinal);
      procedure SetTouchMask(aValue : cardinal);
      procedure SetTouchContact(aValue : TRect);
      procedure SetTouchContactRaw(aValue : TRect);
      procedure SetTouchOrientation(aValue : cardinal);
      procedure SetTouchPressure(aValue : cardinal);

    public
      constructor Create(const aBaseIntf : ICoreWebView2PointerInfo); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized          : boolean                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf             : ICoreWebView2PointerInfo   read FBaseIntf;
      /// <summary>
      /// Get the PointerKind of the pointer event. This corresponds to the
      /// pointerKind property of the POINTER_INFO struct. The values are defined by
      /// the POINTER_INPUT_KIND enum in the Windows SDK (winuser.h). Supports
      /// PT_PEN and PT_TOUCH.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pointerkind">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PointerKind          : cardinal                   read GetPointerKind           write SetPointerKind;
      /// <summary>
      /// Get the PointerId of the pointer event. This corresponds to the pointerId
      /// property of the POINTER_INFO struct as defined in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pointerid">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PointerId            : cardinal                   read GetPointerId             write SetPointerId;
      /// <summary>
      /// Get the FrameID of the pointer event. This corresponds to the frameId
      /// property of the POINTER_INFO struct as defined in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_frameid">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property FrameId              : cardinal                   read GetFrameId               write SetFrameId;
      /// <summary>
      /// Get the PointerFlags of the pointer event. This corresponds to the
      /// pointerFlags property of the POINTER_INFO struct. The values are defined
      /// by the POINTER_FLAGS constants in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pointerflags">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PointerFlags         : cardinal                   read GetPointerFlags          write SetPointerFlags;
      /// <summary>
      /// Get the PointerDeviceRect of the sourceDevice property of the
      /// POINTER_INFO struct as defined in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pointerdevicerect">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PointerDeviceRect    : TRect                      read GetPointerDeviceRect     write SetPointerDeviceRect;
      /// <summary>
      /// Get the DisplayRect of the sourceDevice property of the POINTER_INFO
      /// struct as defined in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_displayrect">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property DisplayRect          : TRect                      read GetDisplayRect           write SetDisplayRect;
      /// <summary>
      /// Get the PixelLocation of the pointer event. This corresponds to the
      /// ptPixelLocation property of the POINTER_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pixellocation">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PixelLocation        : TPoint                     read GetPixelLocation         write SetPixelLocation;
      /// <summary>
      /// Get the HimetricLocation of the pointer event. This corresponds to the
      /// ptHimetricLocation property of the POINTER_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_himetriclocation">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property HimetricLocation     : TPoint                     read GetHimetricLocation      write SetHimetricLocation;
      /// <summary>
      /// Get the PixelLocationRaw of the pointer event. This corresponds to the
      /// ptPixelLocationRaw property of the POINTER_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pixellocationraw">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PixelLocationRaw     : TPoint                     read GetPixelLocationRaw      write SetPixelLocationRaw;
      /// <summary>
      /// Get the HimetricLocationRaw of the pointer event. This corresponds to the
      /// ptHimetricLocationRaw property of the POINTER_INFO struct as defined in
      /// the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_himetriclocationraw">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property HimetricLocationRaw  : TPoint                     read GetHimetricLocationRaw   write SetHimetricLocationRaw;
      /// <summary>
      /// Get the Time of the pointer event. This corresponds to the dwTime property
      /// of the POINTER_INFO struct as defined in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_time">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property Time                 : cardinal                   read GetTime                  write SetTime;
      /// <summary>
      /// Get the HistoryCount of the pointer event. This corresponds to the
      /// historyCount property of the POINTER_INFO struct as defined in the Windows
      /// SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_historycount">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property HistoryCount         : cardinal                   read GetHistoryCount          write SetHistoryCount;
      /// <summary>
      /// Get the InputData of the pointer event. This corresponds to the InputData
      /// property of the POINTER_INFO struct as defined in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_inputdata">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property InputData            : integer                    read GetInputData             write SetInputData;
      /// <summary>
      /// Get the KeyStates of the pointer event. This corresponds to the
      /// dwKeyStates property of the POINTER_INFO struct as defined in the Windows
      /// SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_keystates">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property KeyStates            : cardinal                   read GetKeyStates             write SetKeyStates;
      /// <summary>
      /// Get the PerformanceCount of the pointer event. This corresponds to the
      /// PerformanceCount property of the POINTER_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_performancecount">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PerformanceCount     : uint64                     read GetPerformanceCount      write SetPerformanceCount;
      /// <summary>
      /// Get the ButtonChangeKind of the pointer event. This corresponds to the
      /// ButtonChangeKind property of the POINTER_INFO struct. The values are
      /// defined by the POINTER_BUTTON_CHANGE_KIND enum in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_buttonchangekind">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property ButtonChangeKind     : integer                    read GetButtonChangeKind      write SetButtonChangeKind;
      /// <summary>
      /// Get the PenFlags of the pointer event. This corresponds to the penFlags
      /// property of the POINTER_PEN_INFO struct. The values are defined by the
      /// PEN_FLAGS constants in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Pen specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_penflags">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PenFlags             : cardinal                   read GetPenFlags              write SetPenFlags;
      /// <summary>
      /// Get the PenMask of the pointer event. This corresponds to the penMask
      /// property of the POINTER_PEN_INFO struct. The values are defined by the
      /// PEN_MASK constants in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Pen specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_penmask">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PenMask              : cardinal                   read GetPenMask               write SetPenMask;
      /// <summary>
      /// Get the PenPressure of the pointer event. This corresponds to the pressure
      /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Pen specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_penpressure">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PenPressure          : cardinal                   read GetPenPressure           write SetPenPressure;
      /// <summary>
      /// Get the PenRotation of the pointer event. This corresponds to the rotation
      /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Pen specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_penrotation">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PenRotation          : cardinal                   read GetPenRotation           write SetPenRotation;
      /// <summary>
      /// Get the PenTiltX of the pointer event. This corresponds to the tiltX
      /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Pen specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pentiltx">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PenTiltX             : integer                    read GetPenTiltX              write SetPenTiltX;
      /// <summary>
      /// Get the PenTiltY of the pointer event. This corresponds to the tiltY
      /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
      /// (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Pen specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_pentilty">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property PenTiltY             : integer                    read GetPenTiltY              write SetPenTiltY;
      /// <summary>
      /// Get the TouchFlags of the pointer event. This corresponds to the
      /// touchFlags property of the POINTER_TOUCH_INFO struct. The values are
      /// defined by the TOUCH_FLAGS constants in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Touch specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_touchflags">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property TouchFlags           : cardinal                   read GetTouchFlags            write SetTouchFlags;
      /// <summary>
      /// Get the TouchMask of the pointer event. This corresponds to the
      /// touchMask property of the POINTER_TOUCH_INFO struct. The values are
      /// defined by the TOUCH_MASK constants in the Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Touch specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_touchmask">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property TouchMask            : cardinal                   read GetTouchMask             write SetTouchMask;
      /// <summary>
      /// Get the TouchContact of the pointer event. This corresponds to the
      /// rcContact property of the POINTER_TOUCH_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Touch specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_touchcontact">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property TouchContact         : TRect                      read GetTouchContact          write SetTouchContact;
      /// <summary>
      /// Get the TouchContactRaw of the pointer event. This corresponds to the
      /// rcContactRaw property of the POINTER_TOUCH_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Touch specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_touchcontactraw">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property TouchContactRaw      : TRect                      read GetTouchContactRaw       write SetTouchContactRaw;
      /// <summary>
      /// Get the TouchOrientation of the pointer event. This corresponds to the
      /// orientation property of the POINTER_TOUCH_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Touch specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_touchorientation">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property TouchOrientation     : cardinal                   read GetTouchOrientation      write SetTouchOrientation;
      /// <summary>
      /// Get the TouchPressure of the pointer event. This corresponds to the
      /// pressure property of the POINTER_TOUCH_INFO struct as defined in the
      /// Windows SDK (winuser.h).
      /// </summary>
      /// <remarks>
      /// <para>This is a Touch specific attribute.</para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo#get_touchpressure">See the ICoreWebView2PointerInfo article.</see></para>
      /// </remarks>
      property TouchPressure        : cardinal                   read GetTouchPressure         write SetTouchPressure;
  end;

implementation

constructor TCoreWebView2PointerInfo.Create(const aBaseIntf: ICoreWebView2PointerInfo);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2PointerInfo.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2PointerInfo.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2PointerInfo.GetPointerKind : cardinal;
var
  TempResult : LongWord;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PointerKind(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPointerId : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PointerId(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetFrameId : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_FrameId(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPointerFlags : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PointerFlags(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPointerDeviceRect : TRect;
var
  TempResult : tagRECT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PointerDeviceRect(TempResult)) then
    Result := TRect(TempResult)
   else
    Result := rect(0, 0, 0, 0);
end;

function TCoreWebView2PointerInfo.GetDisplayRect : TRect;
var
  TempResult : tagRECT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_DisplayRect(TempResult)) then
    Result := TRect(TempResult)
   else
    Result := rect(0, 0, 0, 0);
end;

function TCoreWebView2PointerInfo.GetPixelLocation : TPoint;
var
  TempResult : tagPOINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PixelLocation(TempResult)) then
    Result := TPoint(TempResult)
   else
    Result := point(0, 0);
end;

function TCoreWebView2PointerInfo.GetHimetricLocation : TPoint;
var
  TempResult : tagPOINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_HimetricLocation(TempResult)) then
    Result := TPoint(TempResult)
   else
    Result := point(0, 0);
end;

function TCoreWebView2PointerInfo.GetPixelLocationRaw : TPoint;
var
  TempResult : tagPOINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PixelLocationRaw(TempResult)) then
    Result := TPoint(TempResult)
   else
    Result := point(0, 0);
end;

function TCoreWebView2PointerInfo.GetHimetricLocationRaw : TPoint;
var
  TempResult : tagPOINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_HimetricLocationRaw(TempResult)) then
    Result := TPoint(TempResult)
   else
    Result := point(0, 0);
end;

function TCoreWebView2PointerInfo.GetTime : cardinal;
var
  TempResult : Longword;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Time(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetHistoryCount : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_HistoryCount(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetInputData : integer;
var
  TempResult : SYSINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_InputData(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetKeyStates : cardinal;
var
  TempResult : Longword;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_KeyStates(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPerformanceCount : uint64;
var
  TempResult : Largeuint;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PerformanceCount(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetButtonChangeKind : integer;
var
  TempResult : SYSINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ButtonChangeKind(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPenFlags : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PenFlags(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPenMask : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PenMask(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPenPressure : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PenPressure(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPenRotation : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PenRotation(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPenTiltX : integer;
var
  TempResult : SYSINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PenTiltX(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetPenTiltY : integer;
var
  TempResult : SYSINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PenTiltY(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetTouchFlags : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_TouchFlags(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetTouchMask : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_TouchMask(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetTouchContact : TRect;
var
  TempResult : tagRECT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_TouchContact(TempResult)) then
    Result := TRect(TempResult)
   else
    Result := rect(0, 0, 0, 0);
end;

function TCoreWebView2PointerInfo.GetTouchContactRaw : TRect;
var
  TempResult : tagRECT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_TouchContactRaw(TempResult)) then
    Result := TRect(TempResult)
   else
    Result := rect(0, 0, 0, 0);
end;

function TCoreWebView2PointerInfo.GetTouchOrientation : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_TouchOrientation(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2PointerInfo.GetTouchPressure : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_TouchPressure(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

procedure TCoreWebView2PointerInfo.SetPointerKind(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_PointerKind(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPointerId(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_PointerId(aValue);
end;

procedure TCoreWebView2PointerInfo.SetFrameId(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_FrameId(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPointerFlags(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_PointerFlags(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPointerDeviceRect(aValue : TRect);
begin
  if Initialized then
    FBaseIntf.Set_PointerDeviceRect(tagRECT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetDisplayRect(aValue : TRect);
begin
  if Initialized then
    FBaseIntf.Set_DisplayRect(tagRECT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetPixelLocation(aValue : TPoint);
begin
  if Initialized then
    FBaseIntf.Set_PixelLocation(tagPOINT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetHimetricLocation(aValue : TPoint);
begin
  if Initialized then
    FBaseIntf.Set_HimetricLocation(tagPOINT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetPixelLocationRaw(aValue : TPoint);
begin
  if Initialized then
    FBaseIntf.Set_PixelLocationRaw(tagPOINT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetHimetricLocationRaw(aValue : TPoint);
begin
  if Initialized then
    FBaseIntf.Set_HimetricLocationRaw(tagPOINT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetTime(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_Time(aValue);
end;

procedure TCoreWebView2PointerInfo.SetHistoryCount(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_HistoryCount(aValue);
end;

procedure TCoreWebView2PointerInfo.SetInputData(aValue : integer);
begin
  if Initialized then
    FBaseIntf.Set_InputData(aValue);
end;

procedure TCoreWebView2PointerInfo.SetKeyStates(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_KeyStates(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPerformanceCount(aValue : uint64);
begin
  if Initialized then
    FBaseIntf.Set_PerformanceCount(aValue);
end;

procedure TCoreWebView2PointerInfo.SetButtonChangeKind(aValue : integer);
begin
  if Initialized then
    FBaseIntf.Set_ButtonChangeKind(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPenFlags(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_PenFlags(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPenMask(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_PenMask(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPenPressure(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_PenPressure(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPenRotation(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_PenRotation(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPenTiltX(aValue : integer);
begin
  if Initialized then
    FBaseIntf.Set_PenTiltX(aValue);
end;

procedure TCoreWebView2PointerInfo.SetPenTiltY(aValue : integer);
begin
  if Initialized then
    FBaseIntf.Set_PenTiltY(aValue);
end;

procedure TCoreWebView2PointerInfo.SetTouchFlags(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_TouchFlags(aValue);
end;

procedure TCoreWebView2PointerInfo.SetTouchMask(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_TouchMask(aValue);
end;

procedure TCoreWebView2PointerInfo.SetTouchContact(aValue : TRect);
begin
  if Initialized then
    FBaseIntf.Set_TouchContact(tagRECT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetTouchContactRaw(aValue : TRect);
begin
  if Initialized then
    FBaseIntf.Set_TouchContactRaw(tagRECT(aValue));
end;

procedure TCoreWebView2PointerInfo.SetTouchOrientation(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_TouchOrientation(aValue);
end;

procedure TCoreWebView2PointerInfo.SetTouchPressure(aValue : cardinal);
begin
  if Initialized then
    FBaseIntf.Set_TouchPressure(aValue);
end;

end.
