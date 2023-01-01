unit uBrowserFrame;

interface

uses
  {$IFDEF MSWINDOWS}Winapi.Windows,{$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts,
  uWVTypeLibrary, uWVLoader, uWVBrowserBase, uWVFMXBrowser, uWVFMXWindowParent,
  uWVTypes, uWVCoreWebView2Args;

type
  TBrowserTitleEvent = procedure(Sender: TObject; const aTitle : string) of object;

  TBrowserFrame = class(TFrame)
      AddressLay: TLayout;
      GoBtn: TSpeedButton;
      NavButtonLay: TLayout;
      BackBtn: TSpeedButton;
      ForwardBtn: TSpeedButton;
      ReloadBtn: TSpeedButton;
      StopBtn: TSpeedButton;
      URLEdt: TEdit;
      WVFMXBrowser1: TWVFMXBrowser;
      WindowParentLay: TLayout;
      FocusWorkaroundBtn: TButton;
      StatusBar1: TStatusBar;
      StatusLbl: TLabel;

      procedure BackBtnClick(Sender: TObject);
      procedure ForwardBtnClick(Sender: TObject);
      procedure ReloadBtnClick(Sender: TObject);
      procedure StopBtnClick(Sender: TObject);
      procedure GoBtnClick(Sender: TObject);

      procedure WVFMXBrowser1AfterCreated(Sender: TObject);
      procedure WVFMXBrowser1SourceChanged(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SourceChangedEventArgs);
      procedure WVFMXBrowser1GotFocus(Sender: TObject);
      procedure WVFMXBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVFMXBrowser1StatusBarTextChanged(Sender: TObject;
      const aWebView: ICoreWebView2);

    protected
      FMXWindowParent       : TWVFMXWindowParent;
      FHomepage             : string;
      FOnBrowserTitleChange : TBrowserTitleEvent;

      function  GetParentForm : TCustomForm;
      function  GetParentTab : TTabItem;
      function  GetFMXWindowParentRect : System.Types.TRect;
      procedure CreateFMXWindowParent;

  public
      constructor Create(AOwner : TComponent); override;
      procedure   NotifyMoveOrResizeStarted;
      procedure   CreateBrowser;
      procedure   ResizeBrowser;
      procedure   ShowBrowser;
      procedure   HideBrowser;

      property    ParentForm           : TCustomForm         read GetParentForm;
      property    ParentTab            : TTabItem            read GetParentTab;
      property    Homepage             : string              read FHomepage              write FHomepage;
      property    OnBrowserTitleChange : TBrowserTitleEvent  read FOnBrowserTitleChange  write FOnBrowserTitleChange;
  end;

implementation

{$R *.fmx}

uses
  FMX.Platform, {$IFDEF MSWINDOWS}FMX.Platform.Win,{$ENDIF}
  uBrowserTab;


constructor TBrowserFrame.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FHomepage              := '';
  FOnBrowserTitleChange  := nil;
end;

procedure TBrowserFrame.NotifyMoveOrResizeStarted;
begin
  WVFMXBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TBrowserFrame.CreateBrowser;
var
  {$IFDEF MSWINDOWS}
  TempHandle : HWND;
  {$ENDIF}
begin
  CreateFMXWindowParent;

  if not(WVFMXBrowser1.Initialized) then
    begin
      {$IFDEF MSWINDOWS}
      TempHandle               := FmxHandleToHWND(FMXWindowParent.Handle);
      WVFMXBrowser1.DefaultUrl := FHomepage;
      WVFMXBrowser1.CreateBrowser(TempHandle);
      {$ENDIF}
    end;
end;

procedure TBrowserFrame.ResizeBrowser;
begin
  if (FMXWindowParent <> nil) then
    begin
      FMXWindowParent.SetBounds(GetFMXWindowParentRect);
      FMXWindowParent.UpdateSize;
    end;
end;

procedure TBrowserFrame.ShowBrowser;
begin
  if (FMXWindowParent <> nil) then
    begin
      FMXWindowParent.WindowState := TWindowState.wsNormal;
      ResizeBrowser;
      FMXWindowParent.Visible := True;
    end;
end;

procedure TBrowserFrame.HideBrowser;
begin
  if (FMXWindowParent <> nil) then
    FMXWindowParent.Visible := False;
end;

function TBrowserFrame.GetFMXWindowParentRect : System.Types.TRect;
var
  TempPoint : TPointF;
begin
  TempPoint     := LocalToAbsolute(WindowParentLay.Position.Point);
  Result.Left   := round(TempPoint.x);
  Result.Top    := round(TempPoint.y);
  Result.Right  := round(TempPoint.x + WindowParentLay.Width);
  Result.Bottom := round(TempPoint.y + WindowParentLay.Height);
end;

procedure TBrowserFrame.GoBtnClick(Sender: TObject);
begin
  WVFMXBrowser1.Navigate(URLEdt.Text);
end;

procedure TBrowserFrame.ReloadBtnClick(Sender: TObject);
begin
  WVFMXBrowser1.Refresh;
end;

procedure TBrowserFrame.StopBtnClick(Sender: TObject);
begin
  WVFMXBrowser1.Stop;
end;

procedure TBrowserFrame.WVFMXBrowser1AfterCreated(Sender: TObject);
begin
  FMXWindowParent.UpdateSize;
  AddressLay.Enabled := True;
end;

procedure TBrowserFrame.WVFMXBrowser1DocumentTitleChanged(Sender: TObject);
begin
  if assigned(FOnBrowserTitleChange) then
    FOnBrowserTitleChange(self, WVFMXBrowser1.DocumentTitle);
end;

procedure TBrowserFrame.WVFMXBrowser1GotFocus(Sender: TObject);
begin
  // We use a hidden button to fix the focus issues when the browser has the real focus.
  FocusWorkaroundBtn.SetFocus;
end;

procedure TBrowserFrame.WVFMXBrowser1SourceChanged(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
  URLEdt.Text := WVFMXBrowser1.Source;
end;

procedure TBrowserFrame.WVFMXBrowser1StatusBarTextChanged(Sender: TObject;
  const aWebView: ICoreWebView2);
begin
  StatusLbl.Text := WVFMXBrowser1.StatusBarText;
end;

procedure TBrowserFrame.BackBtnClick(Sender: TObject);
begin
  WVFMXBrowser1.GoBack;
end;

procedure TBrowserFrame.ForwardBtnClick(Sender: TObject);
begin
  WVFMXBrowser1.GoForward;
end;

function TBrowserFrame.GetParentForm : TCustomForm;
var
  TempParent : TTabItem;
begin
  Result     := nil;
  TempParent := ParentTab;

  if (TempParent <> nil) and (TempParent is TBrowserTab) then
    Result := TBrowserTab(TempParent).ParentForm;
end;

function TBrowserFrame.GetParentTab : TTabItem;
var
  TempParent : TFMXObject;
begin
  Result     := nil;
  TempParent := Parent;

  while (TempParent <> nil) and not(TempParent is TTabItem) do
    TempParent := TempParent.Parent;

  if (TempParent <> nil) and (TempParent is TTabItem) then
    Result := TTabItem(TempParent);
end;

procedure TBrowserFrame.CreateFMXWindowParent;
begin
  if (FMXWindowParent = nil) then
    begin
      FMXWindowParent         := TWVFMXWindowParent.CreateNew(nil);
      FMXWindowParent.Browser := WVFMXBrowser1;
      FMXWindowParent.Reparent(ParentForm.Handle);
      ResizeBrowser;
      FMXWindowParent.Show;
    end;
end;

end.
