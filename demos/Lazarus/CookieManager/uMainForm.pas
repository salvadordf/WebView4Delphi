unit uMainForm;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  uWVBrowser, uWVWindowParent, uWVTypeLibrary, uWVLoader, uWVBrowserBase, uWVTypes, uWVEvents;

type

  { TMainForm }

  TMainForm = class(TForm)
    WVWindowParent1: TWVWindowParent;
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    AddressPnl: TPanel;
    AddressCb: TComboBox;
    GoBtn: TButton;
    Panel1: TPanel;
    Button1: TButton;
    CookiesLb: TListBox;
    DeleteCookiesBtn: TButton;
    AddCustomCookieBtn: TButton;

    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);  
    procedure Button1Click(Sender: TObject);                    
    procedure DeleteCookiesBtnClick(Sender: TObject);
    procedure AddCustomCookieBtnClick(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1GetCookiesCompleted(Sender: TObject; aResult: HRESULT; const aCookieList: ICoreWebView2CookieList);
    procedure WVBrowser1InitializationError(Sender: TObject;
      aErrorCode: HRESULT; const aErrorMessage: wvstring);

  protected
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

// This demo shows how to read, add or delete browser cookies.

uses
  uWVCoreWebView2CookieList, uWVCoreWebView2Cookie;

procedure TMainForm.AddCustomCookieBtnClick(Sender: TObject);
var
  TempCookie : ICoreWebView2Cookie;
begin
  TempCookie := WVBrowser1.CreateCookie('mycustomcookie', '1234', 'example.com', '/');

  if assigned(TempCookie) then
    try
      WVBrowser1.AddOrUpdateCookie(TempCookie);
    finally
      TempCookie := nil;
    end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin                  
  // This is an asynchronous call that will trigger the TWVBrowser.OnGetCookiesCompleted event with the cookies
  WVBrowser1.GetCookies;
end;

procedure TMainForm.DeleteCookiesBtnClick(Sender: TObject);
begin
  WVBrowser1.DeleteAllCookies;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(UTF8Encode(GlobalWebView2Loader.ErrorMessage))
   else
    if GlobalWebView2Loader.Initialized then
      WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
     else
      Timer1.Enabled := True;
end;

procedure TMainForm.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.Navigate(UTF8Decode(AddressCb.Text));
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  Caption := 'Cookie Manager';
  AddressPnl.Enabled := True;
end;

procedure TMainForm.WVBrowser1GetCookiesCompleted(Sender: TObject;
  aResult: HRESULT; const aCookieList: ICoreWebView2CookieList);
var
  TempCookieList : TCoreWebView2CookieList;
  TempCookie : TCoreWebView2Cookie;
  i : cardinal;
  TempInfo : string;
begin
  TempCookieList := nil;
  TempCookie     := nil;

  CookiesLb.Clear;

  if assigned(aCookieList) then
    try
       TempCookieList := TCoreWebView2CookieList.Create(aCookieList);
       TempCookie     := TCoreWebView2Cookie.Create(nil);

       i := 0;
       while (i < TempCookieList.Count) do
         begin
           TempCookie.BaseIntf := TempCookieList.Items[i];
           TempInfo := UTF8Encode(TempCookie.Name) + ' - ' +
                       UTF8Encode(TempCookie.Domain);
           CookiesLb.Items.Add(TempInfo);
           inc(i);
         end;
    finally
      if assigned(TempCookieList) then
        FreeAndNil(TempCookieList);

      if assigned(TempCookie) then
        FreeAndNil(TempCookie);
    end;
end;

procedure TMainForm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(UTF8Encode(aErrorMessage));
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  if GlobalWebView2Loader.Initialized then
    WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
   else
    Timer1.Enabled := True;
end;

procedure TMainForm.WMMove(var aMessage : TWMMove);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TMainForm.WMMoving(var aMessage : TMessage);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := UTF8Decode(ExtractFileDir(Application.ExeName) + '\CustomCache');
  GlobalWebView2Loader.StartWebView2;

end.
