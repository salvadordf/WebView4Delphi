unit uBrowserFrame;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  uWVBrowserBase, uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypeLibrary, uWVTypes,
  uChildForm, uWVCoreWebView2Args, uWVCoreWebView2Deferral;

type
  TBrowserTitleEvent = procedure(Sender: TObject; const aTitle : string) of object;

  TBrowserFrame = class(TFrame)
    NavControlPnl: TPanel;
    NavButtonPnl: TPanel;
    BackBtn: TButton;
    ForwardBtn: TButton;
    ReloadBtn: TButton;
    StopBtn: TButton;
    URLEditPnl: TPanel;
    URLCbx: TComboBox;
    ConfigPnl: TPanel;
    GoBtn: TButton;
    WVWindowParent1: TWVWindowParent;
    WVBrowser1: TWVBrowser;

    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1NavigationStarting(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationStartingEventArgs);
    procedure WVBrowser1NavigationCompleted(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1SourceChanged(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SourceChangedEventArgs);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1NewWindowRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NewWindowRequestedEventArgs);

    procedure BackBtnClick(Sender: TObject);
    procedure ForwardBtnClick(Sender: TObject);
    procedure ReloadBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

  protected
    FHomepage             : wvstring;
    FOnBrowserTitleChange : TBrowserTitleEvent;
    FArgs                 : TCoreWebView2NewWindowRequestedEventArgs;
    FDeferral             : TCoreWebView2Deferral;

    function  GetInitialized : boolean;

    procedure SetArgs(const aValue : TCoreWebView2NewWindowRequestedEventArgs);

    procedure UpdateNavButtons(aIsNavigating : boolean);

  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure   NotifyParentWindowPositionChanged;
    procedure   CreateBrowser;
    procedure   CreateAllHandles;

    property  Initialized          : boolean                                   read GetInitialized;
    property  Homepage             : wvstring                                  read FHomepage              write FHomepage;
    property  OnBrowserTitleChange : TBrowserTitleEvent                        read FOnBrowserTitleChange  write FOnBrowserTitleChange;
    property  Args                 : TCoreWebView2NewWindowRequestedEventArgs  read FArgs                  write SetArgs;
  end;

implementation

{$R *.lfm}

uses
  uWVCoreWebView2WindowFeatures, uMainForm;

constructor TBrowserFrame.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FHomepage              := '';
  FOnBrowserTitleChange  := nil;
end;

destructor TBrowserFrame.Destroy;
begin
  if assigned(FDeferral) then
    FreeAndNil(FDeferral);

  if assigned(FArgs) then
    FreeAndNil(FArgs);

  inherited Destroy;
end;

procedure TBrowserFrame.NotifyParentWindowPositionChanged;
begin
  WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TBrowserFrame.CreateBrowser;
begin
  WVBrowser1.DefaultURL := FHomepage;
  WVBrowser1.CreateBrowser(WVWindowParent1.Handle);
end;

procedure TBrowserFrame.CreateAllHandles;
begin
  CreateHandle;

  WVWindowParent1.CreateHandle;
end;

function TBrowserFrame.GetInitialized : boolean;
begin
  Result := WVBrowser1.Initialized;
end;

procedure TBrowserFrame.SetArgs(const aValue : TCoreWebView2NewWindowRequestedEventArgs);
begin
  FArgs     := aValue;
  FDeferral := TCoreWebView2Deferral.Create(FArgs.Deferral);
end;

procedure TBrowserFrame.WVBrowser1NavigationCompleted(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  UpdateNavButtons(False);
end;

procedure TBrowserFrame.WVBrowser1NavigationStarting(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationStartingEventArgs);
begin
  UpdateNavButtons(True);
end;

procedure TBrowserFrame.WVBrowser1NewWindowRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
var
  TempChildForm : TChildForm;
  TempArgs : TCoreWebView2NewWindowRequestedEventArgs;
  TempWindowFeatures : TCoreWebView2WindowFeatures;
begin
  if assigned(aArgs) then
    begin
      TempArgs           := TCoreWebView2NewWindowRequestedEventArgs.Create(aArgs);
      TempWindowFeatures := TCoreWebView2WindowFeatures.Create(TempArgs.WindowFeatures);

      if TempWindowFeatures.HasSize or TempWindowFeatures.HasPosition then
        begin
          TempChildForm := TChildForm.Create(self, TempArgs);
          TempChildForm.Show;
        end
       else
        TMainForm(Application.MainForm).CreateNewTab(TempArgs);

      FreeAndNil(TempWindowFeatures);
    end;
end;

procedure TBrowserFrame.WVBrowser1SourceChanged(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
  URLCbx.Text := WVBrowser1.Source;
end;

procedure TBrowserFrame.ReloadBtnClick(Sender: TObject);
begin
  WVBrowser1.Refresh;
end;

procedure TBrowserFrame.StopBtnClick(Sender: TObject);
begin
  WVBrowser1.Stop;
end;

procedure TBrowserFrame.UpdateNavButtons(aIsNavigating : boolean);
begin
  BackBtn.Enabled    := WVBrowser1.CanGoBack;
  ForwardBtn.Enabled := WVBrowser1.CanGoForward;
  ReloadBtn.Enabled  := not(aIsNavigating);
  StopBtn.Enabled    := aIsNavigating;
end;

procedure TBrowserFrame.BackBtnClick(Sender: TObject);
begin
  WVBrowser1.GoBack;
end;

procedure TBrowserFrame.ForwardBtnClick(Sender: TObject);
begin
  WVBrowser1.GoForward;
end;

procedure TBrowserFrame.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.Navigate(URLCbx.Text);
end;

procedure TBrowserFrame.WVBrowser1AfterCreated(Sender: TObject);
begin
  if assigned(FArgs) and assigned(FDeferral) then
    try
      FArgs.NewWindow := WVBrowser1.CoreWebView2.BaseIntf;
      FArgs.Handled   := True;

      FDeferral.Complete;
    finally
      FreeAndNil(FDeferral);
      FreeAndNil(FArgs);
    end;

  WVWindowParent1.UpdateSize;
  NavControlPnl.Enabled := True;
end;

procedure TBrowserFrame.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  if assigned(FOnBrowserTitleChange) then
    FOnBrowserTitleChange(self, WVBrowser1.DocumentTitle);
end;

procedure TBrowserFrame.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

end.
