unit uWindowlessBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, WinApi.ActiveX, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.AppEvnts,
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args, uWVBrowserBase,
  uDirectCompositionHost;

type
  TMainForm = class(TForm, IDropTarget)
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    AddressPnl: TPanel;
    AddressCb: TComboBox;
    GoBtn: TButton;
    ApplicationEvents1: TApplicationEvents;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

    procedure Timer1Timer(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1CursorChanged(Sender: TObject);

  protected
    FWVDirectCompositionHost : TWVDirectCompositionHost;
    FIsCapturingMouse        : boolean;
    FIsTrackingMouse         : boolean;
    FDragAndDropInitialized  : boolean;

    function HandleMouseMessage(aMessage : cardinal; aWParam : WPARAM; aLParam : LPARAM) : boolean;
    function TrackMouseEvents(aMouseTrackingFlags : cardinal) : boolean;
    function OffsetPointToWebView(aPoint : TPoint) : TPoint;

  public
    // IDropTarget
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function IDropTarget.DragOver = IDropTarget_DragOver;
    function IDropTarget_DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;

    procedure InitializeDragAndDrop;
    procedure ShutdownDragAndDrop;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uWVMiscFunctions;

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

// The code in this demo is almost a direct translation of the code in the official
// WebView2APISample available at the WebView2Samples repository :
// https://github.com/MicrosoftEdge/WebView2Samples/tree/master/SampleApps/WebView2APISample

// TO-DO : Add support for touch devices.

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  case Msg.message of
    WM_SIZE :
      case Msg.wParam of
        SIZE_MINIMIZED :
          begin
            WVBrowser1.IsVisible := False;
            WVBrowser1.TrySuspend;
          end;

        SIZE_RESTORED :
          begin
            WVBrowser1.Resume;
            WVBrowser1.IsVisible := True;
          end;
      end;

    WM_MOVE,
    WM_MOVING :
      if (WVBrowser1 <> nil) then
        WVBrowser1.NotifyParentWindowPositionChanged;

    WM_MOUSELEAVE,
    WM_MOUSEFIRST..WM_MOUSELAST :
      HandleMouseMessage(Msg.message, Msg.wParam, Msg.lParam);
  end;
end;

function TMainForm.HandleMouseMessage(aMessage : cardinal; aWParam : WPARAM; aLParam : LPARAM) : boolean;
var
  TempPoint : TPoint;
  TempInClientRect : boolean;
  TempMouseData : cardinal;
  TempKeyState : integer;
begin
  Result := False;

  if not(assigned(FWVDirectCompositionHost)) then exit;

  TempPoint.x := int16(aLParam and $FFFF);
  TempPoint.y := int16((aLParam and $FFFF0000) shr 16);

  if (aMessage = WM_MOUSEWHEEL)  or
     (aMessage = WM_MOUSEHWHEEL) then
    TempPoint := FWVDirectCompositionHost.ScreenToclient(TempPoint);

  TempInClientRect := PtInRect(FWVDirectCompositionHost.ClientRect, TempPoint);

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
          if TempInClientRect and (GetCapture <> FWVDirectCompositionHost.Handle) then
            begin
              FIsCapturingMouse := True;
              SetCapture(FWVDirectCompositionHost.Handle);
            end;

        WM_LBUTTONUP,
        WM_MBUTTONUP,
        WM_RBUTTONUP,
        WM_XBUTTONUP :
          if (GetCapture = FWVDirectCompositionHost.Handle) then
            begin
              FIsCapturingMouse := False;
              ReleaseCapture;
            end;
      end;

      Result := WVBrowser1.SendMouseInput(TWVMouseEventKind(aMessage),
                                          TWVMouseEventVirtualKeys(TempKeyState),
                                          TempMouseData,
                                          TempPoint);
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
  TempEvent.hwndTrack   := FWVDirectCompositionHost.Handle;
  TempEvent.dwHoverTime := 0;

  Result := TrackMouseEvent(TempEvent);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WVBrowser1.RootVisualTarget := nil;
  FWVDirectCompositionHost.DestroyDCompVisualTree;
  ShutdownDragAndDrop;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FIsCapturingMouse       := False;
  FIsTrackingMouse        := False;
  FDragAndDropInitialized := False;

  WVBrowser1.DefaultURL := AddressCb.Text;

  FWVDirectCompositionHost         := TWVDirectCompositionHost.Create(self);
  FWVDirectCompositionHost.Parent  := self;
  FWVDirectCompositionHost.Align   := alClient;
  FWVDirectCompositionHost.Browser := WVBrowser1;
  FWVDirectCompositionHost.CreateHandle;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      WVBrowser1.CreateWindowlessBrowser(FWVDirectCompositionHost.Handle)
     else
      Timer1.Enabled := True;
end;

procedure TMainForm.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.Navigate(AddressCb.Text);
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
begin
  if FWVDirectCompositionHost.BuildDCompTreeUsingVisual then
    begin
      WVBrowser1.RootVisualTarget := FWVDirectCompositionHost.WebViewVisual;
      FWVDirectCompositionHost.DCompDevice.Commit;
    end;

  FWVDirectCompositionHost.UpdateSize;
  FWVDirectCompositionHost.SetFocus;

  WVBrowser1.AllowExternalDrop := True;

  InitializeDragAndDrop;

  Caption := 'WindowlessBrowser';
  AddressPnl.Enabled := True;
end;

procedure TMainForm.WVBrowser1CursorChanged(Sender: TObject);
begin
  FWVDirectCompositionHost.Cursor := SystemCursorIDToDelphiCursor(WVBrowser1.SystemCursorId);
end;

procedure TMainForm.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  Caption := 'WindowlessBrowser - ' + WVBrowser1.DocumentTitle;
end;

procedure TMainForm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  if GlobalWebView2Loader.Initialized then
    WVBrowser1.CreateWindowlessBrowser(FWVDirectCompositionHost.Handle)
   else
    Timer1.Enabled := True;
end;

procedure TMainForm.InitializeDragAndDrop;
begin
  if not(FDragAndDropInitialized) then
    FDragAndDropInitialized := succeeded(RegisterDragDrop(Handle, self));
end;

procedure TMainForm.ShutdownDragAndDrop;
begin
  if FDragAndDropInitialized then
    RevokeDragDrop(Handle);
end;

// IDropTarget
function TMainForm.DragEnter(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
begin
  Result := WVBrowser1.DragEnter(DataObj, grfKeyState, OffsetPointToWebView(pt), LongWord(dwEffect));
end;

function TMainForm.IDropTarget_DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
begin
  Result := WVBrowser1.DragOver(grfKeyState, OffsetPointToWebView(pt), LongWord(dwEffect));
end;

function TMainForm.DragLeave: HRESULT; stdcall;
begin
  Result := WVBrowser1.DragLeave;
end;

function TMainForm.Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
begin
  Result := WVBrowser1.Drop(dataObj, grfKeyState, OffsetPointToWebView(pt), LongWord(dwEffect));
end;

function TMainForm.OffsetPointToWebView(aPoint : TPoint) : TPoint;
begin
  Result   := ScreenToClient(aPoint);
  Result.X := Result.X - FWVDirectCompositionHost.Left;
  Result.Y := Result.Y - FWVDirectCompositionHost.Top;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.StartWebView2;

end.
