unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types,
  System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  uWVLoader, uWVBrowserBase, uWVFMXBrowser, uWVFMXWindowParent, uWVTypes,
  uDirectCompositionHost;

type
  TMainForm = class(TForm)
    AddressLay: TLayout;
    AddressEdt: TEdit;
    GoBtn: TButton;
    Timer1: TTimer;
    WVFMXBrowser1: TWVFMXBrowser;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure GoBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    procedure WVFMXBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVFMXBrowser1AfterCreated(Sender: TObject);
    procedure WVFMXBrowser1CursorChanged(Sender: TObject);

  private
    FWVDirectCompositionHost : TWVDirectCompositionHost;
    FOldWndPrc               : TFNWndProc;
    FFormStub                : Pointer;
    FIsCapturingMouse        : boolean;
    FIsTrackingMouse         : boolean;

    procedure CustomWndProc(var aMessage: TMessage);
    function  HandleMouseMessage(aMessage : cardinal; aWParam : WPARAM; aLParam : LPARAM) : boolean;
    function  TrackMouseEvents(aMouseTrackingFlags : cardinal) : boolean;

  public
    procedure CreateHandle; override;
    procedure DestroyHandle; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

// This is a demo of a WebView2 browser in "Windowsless mode" using WebView4Delphi.
// https://github.com/MicrosoftEdge/WebView2Feedback/issues/20

// The Windowless mode uses the DirectComposition API :
// https://docs.microsoft.com/en-us/windows/win32/directcomp/directcomposition-portal

// At this moment Delphi doesn't support the DirectComposition API so we have to use the
// MfPack component available at GitHub :
// https://github.com/FactoryXCode/MfPack

// It's necessary to add the MfPack source directory to the search path of this demo.

// In order to avoid adding a dependency to WebView4Delphi we create a
// TWVDirectCompositionHost instance at runtime.

// DirectComposition requires a window handle to create the visual tree and FMX ony creates
// handles for TForm controls.

// DirectComposition allows an application to bind a maximum of two visual trees to each window.
// https://docs.microsoft.com/en-us/windows/win32/directcomp/basic-concepts

// This demo only creates one visual tree for one browser using the TWVDirectCompositionHost class.

// The code in this demo is almost a direct translation of the code in the official
// WebView2APISample available at the WebView2Samples repository :
// https://github.com/MicrosoftEdge/WebView2Samples/tree/master/SampleApps/WebView2APISample

// TO-DO : Add support for touch devices.

uses
  FMX.Platform, FMX.Platform.Win,
  uWVMiscFunctions;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WVFMXBrowser1.RootVisualTarget := nil;
  FWVDirectCompositionHost.DestroyDCompVisualTree;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FIsCapturingMouse := False;
  FIsTrackingMouse  := False;

  WVFMXBrowser1.DefaultURL := AddressEdt.Text;

  FWVDirectCompositionHost         := TWVDirectCompositionHost.Create(self);
  FWVDirectCompositionHost.Parent  := self;
  FWVDirectCompositionHost.Browser := WVFMXBrowser1;
  FWVDirectCompositionHost.Align   := TAlignLayout.Client;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      WVFMXBrowser1.CreateWindowlessBrowser(FmxHandleToHWND(Handle))
     else
      Timer1.Enabled := True;
end;

procedure TMainForm.CreateHandle;
begin
  inherited CreateHandle;

  FFormStub  := MakeObjectInstance(CustomWndProc);
  FOldWndPrc := TFNWndProc(SetWindowLongPtr(FmxHandleToHWND(Handle), GWLP_WNDPROC, NativeInt(FFormStub)));
end;

procedure TMainForm.DestroyHandle;
begin
  SetWindowLongPtr(FmxHandleToHWND(Handle), GWLP_WNDPROC, NativeInt(FOldWndPrc));
  FreeObjectInstance(FFormStub);

  inherited DestroyHandle;
end;

procedure TMainForm.CustomWndProc(var aMessage: TMessage);
begin
  try
    case aMessage.Msg of
      WM_SIZE :
        if assigned(WVFMXBrowser1) then
          case aMessage.wParam of
            SIZE_MINIMIZED :
              begin
                WVFMXBrowser1.IsVisible := False;
                WVFMXBrowser1.TrySuspend;
              end;

            SIZE_RESTORED :
              begin
                WVFMXBrowser1.Resume;
                WVFMXBrowser1.IsVisible := True;
              end;
          end;

      WM_MOVE,
      WM_MOVING :
        if assigned(WVFMXBrowser1) then
          WVFMXBrowser1.NotifyParentWindowPositionChanged;

      WM_MOUSELEAVE,
      WM_MOUSEFIRST..WM_MOUSELAST :
        HandleMouseMessage(aMessage.Msg, aMessage.wParam, aMessage.lParam);
    end;

    aMessage.Result := CallWindowProc(FOldWndPrc, FmxHandleToHWND(Handle), aMessage.Msg, aMessage.wParam, aMessage.lParam);
  except
    on e : exception do
      Log.d('TMainForm.CustomWndProc error : ' + e.message);
  end;
end;

function TMainForm.HandleMouseMessage(aMessage : cardinal; aWParam : WPARAM; aLParam : LPARAM) : boolean;
var
  TempPoint : TPointF;
  TempPoint2 : TPoint;
  TempInClientRect : boolean;
  TempMouseData : cardinal;
  TempKeyState : integer;
  TempHandle : HWND;
begin
  Result := False;

  if not(assigned(FWVDirectCompositionHost)) then exit;

  TempPoint.x := int16(aLParam and $FFFF);
  TempPoint.y := int16((aLParam and $FFFF0000) shr 16);

  if (aMessage = WM_MOUSEWHEEL)  or
     (aMessage = WM_MOUSEHWHEEL) then
    TempPoint := ScreenToClient(TempPoint);

  TempInClientRect := FWVDirectCompositionHost.AbsoluteRect.Contains(TempPoint);

  if TempInClientRect or (aMessage = WM_MOUSELEAVE) or FIsCapturingMouse then
    begin
      TempMouseData := 0;
      TempKeyState  := int16(aWParam and $FFFF);

      case aMessage of
        WM_MOUSEWHEEL,
        WM_MOUSEHWHEEL,
        WM_XBUTTONDBLCLK,
        WM_XBUTTONDOWN,
        WM_XBUTTONUP :
          TempMouseData := cardinal((aWParam and $FFFF0000) shr 16);

        WM_MOUSEMOVE :
          if not(FIsTrackingMouse) then
            begin
              TrackMouseEvents(TME_LEAVE);
              FIsTrackingMouse := True;
            end;

        WM_MOUSELEAVE :
          FIsTrackingMouse := False;
      end;

      case aMessage of
        WM_LBUTTONDOWN,
        WM_MBUTTONDOWN,
        WM_RBUTTONDOWN,
        WM_XBUTTONDOWN :
          if TempInClientRect then
          begin
            TempHandle := FmxHandleToHWND(Handle);

            if (GetCapture <> TempHandle) then
              begin
                FIsCapturingMouse := True;
                SetCapture(TempHandle);
              end;
          end;

        WM_LBUTTONUP,
        WM_MBUTTONUP,
        WM_RBUTTONUP,
        WM_XBUTTONUP :
          if (GetCapture = FmxHandleToHWND(Handle)) then
            begin
              FIsCapturingMouse := False;
              ReleaseCapture;
            end;
      end;

      TempPoint2.x := round(TempPoint.x - FWVDirectCompositionHost.Position.x);
      TempPoint2.y := round(TempPoint.y - FWVDirectCompositionHost.Position.y);

      Result := WVFMXBrowser1.SendMouseInput(TWVMouseEventKind(aMessage),
                                             TWVMouseEventVirtualKeys(TempKeyState),
                                             TempMouseData,
                                             TempPoint2);
    end
   else
    if (aMessage = WM_MOUSEMOVE) and FIsTrackingMouse then
      begin
        FIsTrackingMouse := False;
        TrackMouseEvents(TME_LEAVE or TME_CANCEL);
        HandleMouseMessage(WM_MOUSELEAVE, 0, 0);
      end;
end;

function TMainForm.TrackMouseEvents(aMouseTrackingFlags : cardinal) : boolean;
var
  TempEvent : TTRACKMOUSEEVENT;
begin
  TempEvent.cbSize      := SizeOf(TTRACKMOUSEEVENT);
  TempEvent.dwFlags     := aMouseTrackingFlags;
  TempEvent.hwndTrack   := FmxHandleToHWND(Handle);
  TempEvent.dwHoverTime := 0;

  Result := TrackMouseEvent(TempEvent);
end;

procedure TMainForm.GoBtnClick(Sender: TObject);
begin
  WVFMXBrowser1.Navigate(AddressEdt.Text);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  TempHandle : HWND;
begin
  Timer1.Enabled  := False;
  TempHandle      := FmxHandleToHWND(Handle);

  if not(WVFMXBrowser1.CreateWindowlessBrowser(TempHandle)) then
    Timer1.Enabled := True;
end;

procedure TMainForm.WVFMXBrowser1AfterCreated(Sender: TObject);
begin
  if FWVDirectCompositionHost.BuildDCompTreeUsingVisual(FmxHandleToHWND(Handle)) then
    begin
      WVFMXBrowser1.RootVisualTarget := FWVDirectCompositionHost.WebViewVisual;
      FWVDirectCompositionHost.DCompDevice.Commit;
    end;

  FWVDirectCompositionHost.UpdateSize;
  FWVDirectCompositionHost.SetFocus;

  Caption            := 'FMX Windowless Browser';
  AddressLay.Enabled := True;
end;

procedure TMainForm.WVFMXBrowser1CursorChanged(Sender: TObject);
begin
  Cursor := SystemCursorIDToDelphiCursor(WVFMXBrowser1.SystemCursorId);
end;

procedure TMainForm.WVFMXBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := ExtractFileDir(ParamStr(0)) + '\CustomCache';
  GlobalWebView2Loader.StartWebView2;

end.
