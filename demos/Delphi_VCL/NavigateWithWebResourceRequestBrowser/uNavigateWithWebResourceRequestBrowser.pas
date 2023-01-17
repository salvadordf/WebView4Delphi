unit uNavigateWithWebResourceRequestBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Winapi.ActiveX,
  Winapi.ShellApi,
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args,
  uWVBrowserBase;

type
  TMainForm = class(TForm)
    WVWindowParent1: TWVWindowParent;
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    AddressPnl: TPanel;
    GoBtn: TButton;
    Label1: TLabel;
    PostParam1NameEdt: TEdit;
    PostParam2NameEdt: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    PostParam1ValueEdt: TEdit;
    PostParam2ValueEdt: TEdit;
    Label4: TLabel;
    AddressCb: TComboBox;
    Label5: TLabel;
    SendCustomHTTPHeaderChk: TCheckBox;

    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  protected
    FBody    : TStringStream;

    procedure SendSimpleRequest;
    procedure SendCustomHeaderRequest;

    // It's necessary to handle these messages to call NotifyParentWindowPositionChanged or some page elements will be misaligned.
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// This demo shows how to use the TWVBrowserBase.NavigateWithWebResourceRequest
// function to send a custom POST request.

// It sends a POST request to a page in "Henry's Post Test Server" at ptsv2.com
// that is also used by the CEF4Delphi project for a similar demo.

// Fill the names and values and then click the "Send POST request" button.
// After that you sould see a "Thank you for this dump. I hope you have a lovely day!" message.
// You can check the results by clicking in the "Check results in PTSV2.com" button.

uses
  uWVCoreWebView2WebResourceRequest, uWVCoreWebView2HttpRequestHeaders;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FBody := nil;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if assigned(FBody) then
    FreeAndNil(FBody);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
     else
      Timer1.Enabled := True;
end;

procedure TMainForm.SendSimpleRequest;
var
  TempRequest : ICoreWebView2WebResourceRequest;
  TempAdapter : IStream;
  TempParams, TempHeaders, TempMethod : string;
begin
  TempRequest := nil;
  TempAdapter := nil;

  try
    if assigned(FBody) then FreeAndNil(FBody);

    TempMethod  := 'POST';
    TempHeaders := 'Content-Type: application/x-www-form-urlencoded';
    TempParams  := PostParam1NameEdt.Text + '=' + PostParam1ValueEdt.Text + '&' + PostParam2NameEdt.Text + '=' + PostParam2ValueEdt.Text;
    FBody       := TStringStream.Create(TempParams);
    TempAdapter := TStreamAdapter.Create(FBody, soReference);

    if WVBrowser1.CoreWebView2Environment.CreateWebResourceRequest(AddressCb.Text, TempMethod, TempAdapter, TempHeaders, TempRequest) then
      WVBrowser1.NavigateWithWebResourceRequest(TempRequest);
  finally
    TempRequest := nil;
    TempAdapter := nil;
  end;
end;

procedure TMainForm.SendCustomHeaderRequest;
var
  TempRequestIntf : ICoreWebView2WebResourceRequest;
  TempRequest : TCoreWebView2WebResourceRequestRef;
  TempAdapter : IStream;
  TempParams, TempMethod : string;
  TempHeaders  : TCoreWebView2HttpRequestHeaders;
begin
  TempRequest := nil;
  TempAdapter := nil;
  TempHeaders := nil;

  try
    if assigned(FBody) then FreeAndNil(FBody);

    TempMethod  := 'POST';
    TempParams  := PostParam1NameEdt.Text + '=' + PostParam1ValueEdt.Text + '&' + PostParam2NameEdt.Text + '=' + PostParam2ValueEdt.Text;
    FBody       := TStringStream.Create(TempParams);
    TempAdapter := TStreamAdapter.Create(FBody, soReference);

    if WVBrowser1.CoreWebView2Environment.CreateWebResourceRequest(AddressCb.Text, TempMethod, TempAdapter, '', TempRequestIntf) then
      begin
        TempRequest := TCoreWebView2WebResourceRequestRef.Create(TempRequestIntf);
        TempHeaders := TCoreWebView2HttpRequestHeaders.Create(TempRequest.Headers);
        TempHeaders.SetHeader('Content-Type', 'application/x-www-form-urlencoded');
        TempHeaders.SetHeader('X-MyCustomHeader', 'MyCustomValue');
        WVBrowser1.NavigateWithWebResourceRequest(TempRequestIntf);
      end;
  finally
    if assigned(TempRequest) then FreeAndNil(TempRequest);
    if assigned(TempHeaders) then FreeAndNil(TempHeaders);
    TempAdapter := nil;
  end;
end;

procedure TMainForm.GoBtnClick(Sender: TObject);
begin
  if SendCustomHTTPHeaderChk.Checked then
    SendCustomHeaderRequest
   else
    SendSimpleRequest;
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  AddressPnl.Enabled := True;
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
  GlobalWebView2Loader.UserDataFolder := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.StartWebView2;

end.
