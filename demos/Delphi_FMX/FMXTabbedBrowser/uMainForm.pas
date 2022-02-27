unit uMainForm;

interface

uses
  {$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
  {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  uWVLoader, uWVBrowserBase, uWVFMXBrowser, uWVFMXWindowParent, uWVTypes,
  System.Actions, FMX.ActnList, FMX.TabControl, FMX.Controls.Presentation,
  FMX.StdCtrls;

const
  WV2_INITIALIZED      = WM_APP + $100;
  WV2_SHOWBROWSER      = WM_APP + $101;

  HOMEPAGE_URL        = 'https://www.bing.com';
  DEFAULT_TAB_CAPTION = 'New tab';

type
  TMainForm = class(TForm)
    ButtonLay: TLayout;
    AddTabBtn: TSpeedButton;
    RemoveTabBtn: TSpeedButton;
    PrevTabBtn: TSpeedButton;
    NextTabBtn: TSpeedButton;
    ShowTabsBtn: TSpeedButton;
    BrowserTabCtrl: TTabControl;
    ActionList1: TActionList;
    AddTabAction: TAction;
    RemoveTabAction: TAction;
    PrevTabAction: TAction;
    NextTabAction: TAction;
    ShowTabsAction: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddTabActionExecute(Sender: TObject);
    procedure RemoveTabActionExecute(Sender: TObject);
    procedure PrevTabActionExecute(Sender: TObject);
    procedure NextTabActionExecute(Sender: TObject);
    procedure ShowTabsActionExecute(Sender: TObject);
    procedure BrowserTabCtrlChange(Sender: TObject);

  protected
    FLastTabID  : cardinal; // Used by NextTabID to generate unique tab IDs

    {$IFDEF MSWINDOWS}
    FCustomWindowState      : TWindowState;
    FOldWndPrc              : TFNWndProc;
    FFormStub               : Pointer;

    function  GetCurrentWindowState : TWindowState;
    procedure UpdateCustomWindowState;
    procedure CreateHandle; override;
    procedure DestroyHandle; override;
    procedure CustomWndProc(var aMessage: TMessage);
    {$ENDIF}
    function  GetNextTabID : cardinal;
    procedure EnableButtonLay;
    procedure ShowSelectedBrowser;
    procedure DestroyTab(aTabID : cardinal);
    procedure CloseSelectedTab;
    procedure ResizeAllBrowsers;

    property  NextTabID : cardinal   read GetNextTabID;

  public
    function  PostCustomMessage(aMsg : cardinal; aWParam : WPARAM = 0; aLParam : LPARAM = 0) : boolean;
    procedure NotifyMoveOrResizeStarted;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  FMX.Platform, FMX.Platform.Win,
  uWVMiscFunctions, uBrowserTab;

function TMainForm.PostCustomMessage(aMsg : cardinal; aWParam : WPARAM; aLParam : LPARAM) : boolean;
{$IFDEF MSWINDOWS}
var
  TempHWND : HWND;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
  TempHWND := FmxHandleToHWND(Handle);
  Result   := (TempHWND <> 0) and WinApi.Windows.PostMessage(TempHWND, aMsg, aWParam, aLParam);
  {$ELSE}
  Result   := False;
  {$ENDIF}
end;

procedure TMainForm.PrevTabActionExecute(Sender: TObject);
begin
  if (BrowserTabCtrl.TabIndex > 0) then
    BrowserTabCtrl.TabIndex := BrowserTabCtrl.TabIndex - 1;
end;

procedure TMainForm.RemoveTabActionExecute(Sender: TObject);
begin
  CloseSelectedTab;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FLastTabID := 0;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  ResizeAllBrowsers;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if (GlobalWebView2Loader <> nil) and GlobalWebView2Loader.Initialized then
    EnableButtonLay;
end;

procedure TMainForm.NextTabActionExecute(Sender: TObject);
begin
  if (BrowserTabCtrl.TabIndex < pred(BrowserTabCtrl.TabCount)) then
    BrowserTabCtrl.TabIndex := BrowserTabCtrl.TabIndex + 1;
end;

procedure TMainForm.ResizeAllBrowsers;
var
  i : integer;
begin
  i := pred(BrowserTabCtrl.TabCount);

  while (i >= 0) do
    begin
      TBrowserTab(BrowserTabCtrl.Tabs[i]).ResizeBrowser;
      dec(i);
    end;
end;

procedure TMainForm.NotifyMoveOrResizeStarted;
var
  i : integer;
begin
  if (BrowserTabCtrl = nil) then exit;

  i := pred(BrowserTabCtrl.TabCount);

  while (i >= 0) do
    begin
      TBrowserTab(BrowserTabCtrl.Tabs[i]).NotifyMoveOrResizeStarted;
      dec(i);
    end;
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

{$IFDEF MSWINDOWS}
procedure TMainForm.AddTabActionExecute(Sender: TObject);
var
  TempNewTab : TBrowserTab;
begin
  TempNewTab        := TBrowserTab.Create(BrowserTabCtrl, NextTabID, DEFAULT_TAB_CAPTION);
  TempNewTab.Parent := BrowserTabCtrl;

  BrowserTabCtrl.TabIndex := pred(BrowserTabCtrl.TabCount);

  TempNewTab.CreateBrowser(HOMEPAGE_URL);
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
          PostCustomMessage(WV2_SHOWBROWSER);

      WV2_INITIALIZED       : EnableButtonLay;
      WV2_SHOWBROWSER       : ShowSelectedBrowser;
    end;

    aMessage.Result := CallWindowProc(FOldWndPrc, FmxHandleToHWND(Handle), aMessage.Msg, aMessage.wParam, aMessage.lParam);
  except
    on e : exception do
      if CustomExceptionHandler('TMainForm.CustomWndProc', e) then raise;
  end;
end;

procedure TMainForm.UpdateCustomWindowState;
var
  TempNewState : TWindowState;
begin
  TempNewState := GetCurrentWindowState;

  if (FCustomWindowState <> TempNewState) then
    begin
      // This is a workaround for the issue #253
      // https://github.com/salvadordf/CEF4Delphi/issues/253
      if (FCustomWindowState = TWindowState.wsMinimized) then
        PostCustomMessage(WV2_SHOWBROWSER);

      FCustomWindowState := TempNewState;
    end;
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
{$ENDIF}

procedure TMainForm.EnableButtonLay;
begin
  if not(ButtonLay.Enabled) then
    begin
      ButtonLay.Enabled := True;
      Caption           := 'FMX Tabbed Browser';
      cursor            := crDefault;
      if (BrowserTabCtrl.TabCount <= 0) then AddTabAction.Execute;
    end;
end;

function TMainForm.GetNextTabID : cardinal;
begin
  inc(FLastTabID);
  Result := FLastTabID;
end;

procedure TMainForm.ShowSelectedBrowser;
begin
  if (BrowserTabCtrl.ActiveTab <> nil) then
    TBrowserTab(BrowserTabCtrl.ActiveTab).ShowBrowser;
end;

procedure TMainForm.ShowTabsActionExecute(Sender: TObject);
begin
  if (BrowserTabCtrl.TabPosition = TTabPosition.PlatformDefault) then
    BrowserTabCtrl.TabPosition := TTabPosition.None
   else
    BrowserTabCtrl.TabPosition := TTabPosition.PlatformDefault;

  ResizeAllBrowsers;
end;

procedure TMainForm.DestroyTab(aTabID : cardinal);
var
  i : integer;
  TempTab : TBrowserTab;
  TempText : string;
begin
  i := pred(BrowserTabCtrl.TabCount);

  while (i >= 0) do
    begin
      TempTab := TBrowserTab(BrowserTabCtrl.Tabs[i]);

      if (TempTab.TabID = aTabID) then
        begin
          BrowserTabCtrl.Delete(i);
          break;
        end
       else
        dec(i);
    end;

  ShowSelectedBrowser;

  // Sometimes TTabControl doesn't draw the new selected tab correctly.
  // Changing TTabItem.Text forces the component to redraw all the tabs.
  // A nicer solution would be to use a custom ttabcontrol that publishes
  // the TTabControl.RealignTabs procedure.
  if (BrowserTabCtrl.ActiveTab <> nil) then
    begin
      TempText := BrowserTabCtrl.ActiveTab.Text;
      BrowserTabCtrl.ActiveTab.Text := TempText + '-';
      BrowserTabCtrl.ActiveTab.Text := TempText;
    end;
end;

procedure TMainForm.BrowserTabCtrlChange(Sender: TObject);
var
  i : integer;
begin
  i := pred(BrowserTabCtrl.TabCount);

  while (i >= 0) do
    begin
      if (BrowserTabCtrl.TabIndex = i) then
        TBrowserTab(BrowserTabCtrl.Tabs[i]).ShowBrowser
       else
        TBrowserTab(BrowserTabCtrl.Tabs[i]).HideBrowser;

      dec(i);
    end;
end;

procedure TMainForm.CloseSelectedTab;
begin
  if (BrowserTabCtrl.ActiveTab <> nil) then
    DestroyTab(TBrowserTab(BrowserTabCtrl.ActiveTab).TabID);
end;

procedure GlobalWebView2Loader_OnEnvironmentCreated(Sender: TObject);
begin
  if (MainForm <> nil) then MainForm.PostCustomMessage(WV2_INITIALIZED);
end;

initialization
  GlobalWebView2Loader                      := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder       := ExtractFileDir(ParamStr(0)) + '\CustomCache';
  GlobalWebView2Loader.OnEnvironmentCreated := GlobalWebView2Loader_OnEnvironmentCreated;
  GlobalWebView2Loader.StartWebView2;

end.
