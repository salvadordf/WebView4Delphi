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
  uWVTypeLibrary;

type
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

      property Initialized          : boolean                    read GetInitialized;
      property BaseIntf             : ICoreWebView2PointerInfo   read FBaseIntf;
      property PointerKind          : cardinal                   read GetPointerKind           write SetPointerKind;
      property PointerId            : cardinal                   read GetPointerId             write SetPointerId;
      property FrameId              : cardinal                   read GetFrameId               write SetFrameId;
      property PointerFlags         : cardinal                   read GetPointerFlags          write SetPointerFlags;
      property PointerDeviceRect    : TRect                      read GetPointerDeviceRect     write SetPointerDeviceRect;
      property DisplayRect          : TRect                      read GetDisplayRect           write SetDisplayRect;
      property PixelLocation        : TPoint                     read GetPixelLocation         write SetPixelLocation;
      property HimetricLocation     : TPoint                     read GetHimetricLocation      write SetHimetricLocation;
      property PixelLocationRaw     : TPoint                     read GetPixelLocationRaw      write SetPixelLocationRaw;
      property HimetricLocationRaw  : TPoint                     read GetHimetricLocationRaw   write SetHimetricLocationRaw;
      property Time                 : cardinal                   read GetTime                  write SetTime;
      property HistoryCount         : cardinal                   read GetHistoryCount          write SetHistoryCount;
      property InputData            : integer                    read GetInputData             write SetInputData;
      property KeyStates            : cardinal                   read GetKeyStates             write SetKeyStates;
      property PerformanceCount     : uint64                     read GetPerformanceCount      write SetPerformanceCount;
      property ButtonChangeKind     : integer                    read GetButtonChangeKind      write SetButtonChangeKind;
      property PenFlags             : cardinal                   read GetPenFlags              write SetPenFlags;
      property PenMask              : cardinal                   read GetPenMask               write SetPenMask;
      property PenPressure          : cardinal                   read GetPenPressure           write SetPenPressure;
      property PenRotation          : cardinal                   read GetPenRotation           write SetPenRotation;
      property PenTiltX             : integer                    read GetPenTiltX              write SetPenTiltX;
      property PenTiltY             : integer                    read GetPenTiltY              write SetPenTiltY;
      property TouchFlags           : cardinal                   read GetTouchFlags            write SetTouchFlags;
      property TouchMask            : cardinal                   read GetTouchMask             write SetTouchMask;
      property TouchContact         : TRect                      read GetTouchContact          write SetTouchContact;
      property TouchContactRaw      : TRect                      read GetTouchContactRaw       write SetTouchContactRaw;
      property TouchOrientation     : cardinal                   read GetTouchOrientation      write SetTouchOrientation;
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
