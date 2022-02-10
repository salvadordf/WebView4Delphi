unit uMainForm;

interface

uses
  Winapi.Windows, System.SysUtils, System.Types, System.UITypes,
  System.Classes, System.Variants, Winapi.Messages,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  uWVLoader, uWVBrowserBase, uWVFMXBrowser, uWVFMXWindowParent, uWVTypes,
  FMX.Layouts;

const
  WEBVIEW2_SHOWBROWSER = WM_APP + $101;

type
  TMainForm = class(TForm)
    AddressPnl: TPanel;
    AddressEdt: TEdit;
    GoBtn: TButton;
    WVFMXBrowser1: TWVFMXBrowser;
    Timer1: TTimer;
    BrowserLay: TLayout;

    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure Timer1Timer(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

    procedure WVFMXBrowser1AfterCreated(Sender: TObject);
    procedure WVFMXBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVFMXBrowser1GotFocus(Sender: TObject);

  private
    FMXWindowParent         : TWVFMXWindowParent;
    FCustomWindowState      : TWindowState;
    FOldWndPrc              : TFNWndProc;
    FFormStub               : Pointer;

    procedure LoadURL;
    procedure ResizeChild;
    procedure CreateFMXWindowParent;
    function  GetFMXWindowParentRect : System.Types.TRect;
    function  PostCustomMessage(aMsg : cardinal; aWParam : WPARAM = 0; aLParam : LPARAM = 0) : boolean;

    function  GetCurrentWindowState : TWindowState;
    procedure UpdateCustomWindowState;
    procedure CustomWndProc(var aMessage: TMessage);

  public
    procedure CreateHandle; override;
    procedure DestroyHandle; override;
    procedure NotifyMoveOrResizeStarted;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

// This is a simple browser in normal mode in a Firemonkey application.

// This demo uses a TWVFMXBrowser and a TWVFMXWindowParent. It replaces the original WndProc with a
// custom CustomWndProc procedure to handle Windows messages.

uses
  FMX.Platform, FMX.Platform.Win;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FMXWindowParent    := nil;
  FCustomWindowState := WindowState;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  ResizeChild;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  TempHandle : HWND;
begin
  // TFMXWindowParent has to be created at runtime
  CreateFMXWindowParent;

  // You *MUST* call CreateBrowser to create and initialize the browser.
  // This will trigger the AfterCreated event when the browser is fully
  // initialized and ready to receive commands.

  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      begin
        TempHandle               := FmxHandleToHWND(FMXWindowParent.Handle);
        WVFMXBrowser1.DefaultUrl := AddressEdt.Text;

        if not(WVFMXBrowser1.CreateBrowser(TempHandle)) then
          Timer1.Enabled := True;
      end;
end;

function TMainForm.PostCustomMessage(aMsg : cardinal; aWParam : WPARAM; aLParam : LPARAM) : boolean;
var
  TempHWND : HWND;
begin
  TempHWND := FmxHandleToHWND(Handle);
  Result   := (TempHWND <> 0) and WinApi.Windows.PostMessage(TempHWND, aMsg, aWParam, aLParam);
end;

procedure TMainForm.GoBtnClick(Sender: TObject);
begin
  LoadURL;
end;

procedure TMainForm.ResizeChild;
begin
  if (FMXWindowParent <> nil) then
    FMXWindowParent.SetBounds(GetFMXWindowParentRect);
end;

procedure TMainForm.CreateFMXWindowParent;
begin
  if (FMXWindowParent = nil) then
    begin
      FMXWindowParent         := TWVFMXWindowParent.CreateNew(nil);
      FMXWindowParent.Browser := WVFMXBrowser1;
      FMXWindowParent.Reparent(Handle);
      ResizeChild;
      FMXWindowParent.Show;
    end;
end;

function TMainForm.GetFMXWindowParentRect : System.Types.TRect;
var
  TempScale : single;
begin
  TempScale     := GlobalWebView2Loader.DeviceScaleFactor;
  Result.Left   := round(BrowserLay.Position.x);
  Result.Top    := round(BrowserLay.Position.y);
  Result.Right  := Result.Left + round(BrowserLay.Width  * TempScale);
  Result.Bottom := Result.Top  + round(BrowserLay.Height * TempScale);
end;

procedure TMainForm.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  PositionChanged: Boolean;
begin
  PositionChanged := (ALeft <> Left) or (ATop <> Top);

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if PositionChanged then
    NotifyMoveOrResizeStarted;
end;

procedure TMainForm.NotifyMoveOrResizeStarted;
begin
  if (WVFMXBrowser1 <> nil) then WVFMXBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  TempHandle : HWND;
begin
  Timer1.Enabled  := False;
  TempHandle      := FmxHandleToHWND(FMXWindowParent.Handle);

  if not(WVFMXBrowser1.CreateBrowser(TempHandle)) then
    Timer1.Enabled := True;
end;

procedure TMainForm.LoadURL;
begin
  WVFMXBrowser1.Navigate(AddressEdt.Text);
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
const
  SWP_STATECHANGED = $8000;  // Undocumented
var
  TempWindowPos : PWindowPos;
begin
  try
    case aMessage.Msg of
      WM_MOVE,
      WM_MOVING : NotifyMoveOrResizeStarted;

      WM_SIZE :
        if (aMessage.wParam = SIZE_RESTORED) then
          UpdateCustomWindowState;

      WM_WINDOWPOSCHANGING :
        begin
          TempWindowPos := TWMWindowPosChanging(aMessage).WindowPos;
          if ((TempWindowPos.Flags and SWP_STATECHANGED) <> 0) then
            UpdateCustomWindowState;
        end;

      WM_SHOWWINDOW :
        if (aMessage.wParam <> 0) and (aMessage.lParam = SW_PARENTOPENING) then
          PostCustomMessage(WEBVIEW2_SHOWBROWSER);

      WEBVIEW2_SHOWBROWSER :
        if (FMXWindowParent <> nil) then
          begin
            FMXWindowParent.WindowState := TWindowState.wsNormal;
            FMXWindowParent.Show;
            FMXWindowParent.SetBounds(GetFMXWindowParentRect);
          end;
    end;

    aMessage.Result := CallWindowProc(FOldWndPrc, FmxHandleToHWND(Handle), aMessage.Msg, aMessage.wParam, aMessage.lParam);
  except
    on e : exception do
      Log.d('TMainForm.CustomWndProc error : ' + e.message);
  end;
end;

procedure TMainForm.UpdateCustomWindowState;
var
  TempNewState : TWindowState;
begin
  TempNewState := GetCurrentWindowState;

  if (FCustomWindowState <> TempNewState) then
    begin
      if (FCustomWindowState = TWindowState.wsMinimized) then
        PostCustomMessage(WEBVIEW2_SHOWBROWSER);

      FCustomWindowState := TempNewState;
    end;
end;

procedure TMainForm.WVFMXBrowser1AfterCreated(Sender: TObject);
begin
  FMXWindowParent.UpdateSize;
  Caption            := 'Simple FMX Browser';
  AddressPnl.Enabled := True;
end;

procedure TMainForm.WVFMXBrowser1GotFocus(Sender: TObject);
var
  TempObject : TFMXObject;
begin
  if (Focused <> nil) then
    begin
      TempObject := Focused.GetObject;

      if (TempObject <> nil) and (TempObject is TControl) then
        TControl(TempObject).ResetFocus;
    end;
end;

procedure TMainForm.WVFMXBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

function TMainForm.GetCurrentWindowState : TWindowState;
var
  TempPlacement : TWindowPlacement;
  TempHWND      : HWND;
begin
  // TForm.WindowState is not updated correctly in FMX forms.
  // We have to call the GetWindowPlacement function in order to read the window state correctly.

  Result   := TWindowState.wsNormal;
  TempHWND := FmxHandleToHWND(Handle);

  ZeroMemory(@TempPlacement, SizeOf(TWindowPlacement));
  TempPlacement.Length := SizeOf(TWindowPlacement);

  if GetWindowPlacement(TempHWND, @TempPlacement) then
    case TempPlacement.showCmd of
      SW_SHOWMAXIMIZED : Result := TWindowState.wsMaximized;
      SW_SHOWMINIMIZED : Result := TWindowState.wsMinimized;
    end;

  if IsIconic(TempHWND) then Result := TWindowState.wsMinimized;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := ExtractFileDir(ParamStr(0)) + '\CustomCache';
  GlobalWebView2Loader.StartWebView2;

end.
