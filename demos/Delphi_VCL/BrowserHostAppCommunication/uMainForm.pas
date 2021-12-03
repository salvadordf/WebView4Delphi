unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args,
  uWVBrowserBase;

type
  TMainForm = class(TForm)
    WVWindowParent1: TWVWindowParent;
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    MessagesPnl: TPanel;
    GoBtn: TButton;
    Edit1: TEdit;
    Panel1: TPanel;
    MessagesMem: TMemo;
    Label1: TLabel;

    procedure Timer1Timer(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1WebMessageReceived(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebMessageReceivedEventArgs);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);

  protected
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// This demo shows how to send and receive messages between the web browser and the web page.

// JavaScript can send messages with "window.chrome.webview.postMessage"
// The web browser will receive them in the TWVBrowser.OnWebMessageReceived event.

// The web browser can send messages with the TWVBrowser.PostWebMessageAsString function
// JavaScript will receive them in the "message" event listener declared with
// window.chrome.webview.addEventListener

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

procedure TMainForm.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.PostWebMessageAsString(Edit1.Text);
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
var
  TempContent : string;
begin
  WVWindowParent1.UpdateSize;
  Caption := 'Browser Host App Communication example';
  MessagesPnl.Enabled := True;

  TempContent :=
    '<!DOCTYPE html><html><head><script>' +
    '  window.chrome.webview.addEventListener("message", function(event) {' +
    '    document.getElementById('+ quotedstr('messagelog') + ').value += '+ quotedstr('\nMessage received : ') + ' + event.data;' +
    '  });' +
    '  function sendMessageToHostApp() {' +
    '    window.chrome.webview.postMessage(document.getElementById(' + quotedstr('msgtext') + ').value);' +
    '  }' +
    '</script></head><body>' +
    '<p><input value="Hello from the web browser!" id="msgtext"></br><button onclick="sendMessageToHostApp()">Send a message to the host application >>></button></p></br></br></br>' +
    '<p>Messages from the host application :</br><textarea id="messagelog" rows="10" cols="80"></textarea></p></body></html>';

  WVBrowser1.NavigateToString(TempContent);
end;

procedure TMainForm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

procedure TMainForm.WVBrowser1WebMessageReceived(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2WebMessageReceivedEventArgs);
var
  TempArgs : TCoreWebView2WebMessageReceivedEventArgs;
begin
  TempArgs := TCoreWebView2WebMessageReceivedEventArgs.Create(aArgs);
  MessagesMem.Lines.Add('Message received : ' + TempArgs.WebMessageAsString);
  TempArgs.Free;
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
