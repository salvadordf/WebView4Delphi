unit uMainForm;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, Buttons, ExtCtrls,
  uWVLoader, uWVCoreWebView2Args;

const
  WV_INITIALIZED = WM_APP + $100;

  HOMEPAGE_URL        = 'https://www.bing.com';
  DEFAULT_TAB_CAPTION = 'New tab';

type
  TMainForm = class(TForm)
    ButtonPnl: TPanel;
    AddTabBtn: TSpeedButton;
    RemoveTabBtn: TSpeedButton;
    BrowserPageCtrl: TPageControl;

    procedure FormShow(Sender: TObject);
    procedure AddTabBtnClick(Sender: TObject);
    procedure RemoveTabBtnClick(Sender: TObject);

  protected
    FLastTabID       : cardinal;

    function  GetNextTabID : cardinal;
    procedure EnableButtonPnl;

    property  NextTabID       : cardinal   read GetNextTabID;

  public
    procedure WVInitializedMsg(var aMessage : TMessage); message WV_INITIALIZED;
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;

    procedure CreateNewTab(const aArgs : TCoreWebView2NewWindowRequestedEventArgs);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

// This demo shows how to create multiple browsers at runtime using tabs.

uses
  uBrowserTab;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      EnableButtonPnl;
end;

procedure TMainForm.WVInitializedMsg(var aMessage : TMessage);
begin
  EnableButtonPnl;
end;

function TMainForm.GetNextTabID : cardinal;
begin
  inc(FLastTabID);
  Result := FLastTabID;
end;

procedure TMainForm.RemoveTabBtnClick(Sender: TObject);
var
  TempTab : TBrowserTab;
begin
  TempTab := TBrowserTab(BrowserPageCtrl.Pages[BrowserPageCtrl.TabIndex]);
  TempTab.Free;
end;

procedure TMainForm.AddTabBtnClick(Sender: TObject);
var
  TempNewTab : TBrowserTab;
begin
  TempNewTab             := TBrowserTab.Create(self, NextTabID, DEFAULT_TAB_CAPTION);
  TempNewTab.PageControl := BrowserPageCtrl;

  BrowserPageCtrl.ActivePageIndex := pred(BrowserPageCtrl.PageCount);

  TempNewTab.CreateBrowser(HOMEPAGE_URL);
end;

procedure TMainForm.CreateNewTab(const aArgs : TCoreWebView2NewWindowRequestedEventArgs);
var
  TempNewTab : TBrowserTab;
begin
  TempNewTab             := TBrowserTab.Create(self, NextTabID, DEFAULT_TAB_CAPTION);
  TempNewTab.PageControl := BrowserPageCtrl;

  BrowserPageCtrl.ActivePageIndex := pred(BrowserPageCtrl.PageCount);

  TempNewTab.CreateBrowser(aArgs);
end;

procedure TMainForm.EnableButtonPnl;
begin
  if not(ButtonPnl.Enabled) then
    begin
      ButtonPnl.Enabled := True;
      Caption           := 'Tabbed Browser';
      cursor            := crDefault;
      if (BrowserPageCtrl.PageCount = 0) then AddTabBtn.Click;
    end;
end;

procedure TMainForm.WMMove(var aMessage : TWMMove);
var
  i : integer;
begin
  inherited;

  i := 0;
  while (i < BrowserPageCtrl.PageCount) do
    begin
      TBrowserTab(BrowserPageCtrl.Pages[i]).NotifyParentWindowPositionChanged;
      inc(i);
    end;
end;

procedure TMainForm.WMMoving(var aMessage : TMessage);
var
  i : integer;
begin
  inherited;

  i := 0;
  while (i < BrowserPageCtrl.PageCount) do
    begin
      TBrowserTab(BrowserPageCtrl.Pages[i]).NotifyParentWindowPositionChanged;
      inc(i);
    end;
end;

procedure GlobalWebView2Loader_OnEnvironmentCreated(Sender: TObject);
begin
  if (MainForm <> nil) and MainForm.HandleAllocated then
    PostMessage(MainForm.Handle, WV_INITIALIZED, 0, 0);
end;

initialization
  GlobalWebView2Loader                      := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder       := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.OnEnvironmentCreated := GlobalWebView2Loader_OnEnvironmentCreated;
  GlobalWebView2Loader.StartWebView2;

end.
