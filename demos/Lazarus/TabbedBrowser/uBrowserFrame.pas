unit uBrowserFrame;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  uWVBrowserBase, uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypeLibrary, uWVTypes, uWVEvents;

type
  TBrowserTitleEvent = procedure(Sender: TObject; const aTitle : string) of object;

  { TBrowserFrame }

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
    procedure WVBrowser1InitializationError(Sender: TObject;
      aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1NavigationStarting(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationStartingEventArgs);
    procedure WVBrowser1NavigationCompleted(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1SourceChanged(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SourceChangedEventArgs);

    procedure BackBtnClick(Sender: TObject);
    procedure ForwardBtnClick(Sender: TObject);
    procedure ReloadBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

  protected
    FHomepage             : string;
    FOnBrowserTitleChange : TBrowserTitleEvent;

    function  GetInitialized : boolean;

    procedure UpdateNavButtons(aIsNavigating : boolean);

  public
    constructor Create(AOwner : TComponent); override;
    procedure   NotifyParentWindowPositionChanged;
    procedure   CreateBrowser;
    procedure   CreateAllHandles;

    property  Initialized          : boolean             read GetInitialized;
    property  Homepage             : string              read FHomepage              write FHomepage;
    property  OnBrowserTitleChange : TBrowserTitleEvent  read FOnBrowserTitleChange  write FOnBrowserTitleChange;
  end;

implementation

{$R *.lfm}

// This demo shows how to create multiple browsers at runtime using tabs.

constructor TBrowserFrame.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FHomepage              := '';
  FOnBrowserTitleChange  := nil;
end;

procedure TBrowserFrame.NotifyParentWindowPositionChanged;
begin
  WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TBrowserFrame.CreateBrowser;
begin
  WVBrowser1.DefaultURL := UTF8Decode(FHomepage);
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

procedure TBrowserFrame.WVBrowser1SourceChanged(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
  URLCbx.Text := UTF8Encode(WVBrowser1.Source);
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
  WVBrowser1.Navigate(UTF8Decode(URLCbx.Text));
end;

procedure TBrowserFrame.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  NavControlPnl.Enabled := True;
end;

procedure TBrowserFrame.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  if assigned(FOnBrowserTitleChange) then
    FOnBrowserTitleChange(self, UTF8Encode(WVBrowser1.DocumentTitle));
end;

procedure TBrowserFrame.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(UTF8Encode(aErrorMessage));
end;

end.
