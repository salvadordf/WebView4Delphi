unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args,
  uWVBrowserBase, uWVCoreWebView2SharedBuffer;

type
  TMainForm = class(TForm)
    WVWindowParent1: TWVWindowParent;
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    MessagesPnl: TPanel;
    SendMsgBtn: TButton;
    Edit1: TEdit;
    Panel1: TPanel;
    MessagesMem: TMemo;
    Label1: TLabel;
    Panel2: TPanel;
    SharedBufferEdt: TEdit;
    PostSharedBufferBtn: TButton;

    procedure Timer1Timer(Sender: TObject);
    procedure SendMsgBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1WebMessageReceived(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebMessageReceivedEventArgs);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure PostSharedBufferBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  protected
    FSharedBuffer : TCoreWebView2SharedBuffer;
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

// This demos also shows how to share a buffer between the browser and Delphi.

// Use TWVBrowserBase.CreateSharedBuffer to create a shared buffer :
// https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment12?view=webview2-1.0.1661.34#createsharedbuffer

// Use TWVBrowserBase.PostSharedBufferToScript to share a buffer with the browser :
// https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_17?view=webview2-1.0.1661.34#postsharedbuffertoscript

// For all the information about shared buffers read this document :
// https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer

const
  CUSTOM_SHARED_BUFFER_SIZE = 1024;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FSharedBuffer := nil;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if assigned(FSharedBuffer) then
    FreeAndNil(FSharedBuffer);
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

procedure TMainForm.PostSharedBufferBtnClick(Sender: TObject);
var
  TempSrcBuffer : TBytes;
  TempDstBuffer : PByte;
  TempSharedBufferItf : ICoreWebView2SharedBuffer;
  TempText : string;
begin
  if not(assigned(FSharedBuffer)) and
     WVBrowser1.CreateSharedBuffer(CUSTOM_SHARED_BUFFER_SIZE, TempSharedBufferItf) then
    try
      FSharedBuffer := TCoreWebView2SharedBuffer.Create(TempSharedBufferItf);
    finally
      TempSharedBufferItf := nil;
    end;

  // Convert the text to UTF8
  TempText := trim(SharedBufferEdt.Text);
  SetLength(TempSrcBuffer, CUSTOM_SHARED_BUFFER_SIZE);
  ZeroMemory(TempSrcBuffer, CUSTOM_SHARED_BUFFER_SIZE);
  UTF8Encode(TempText, TempSrcBuffer);
  TempDstBuffer := FSharedBuffer.Buffer;
  ZeroMemory(TempDstBuffer, CUSTOM_SHARED_BUFFER_SIZE);
  // Copy the UTF8 data to the shared buffer
  move(TempSrcBuffer[1], TempDstBuffer^, CUSTOM_SHARED_BUFFER_SIZE);
  // Post the shared buffer. The document will receive a "sharedbufferreceived" message.
  WVBrowser1.PostSharedBufferToScript(FSharedBuffer.BaseIntf, COREWEBVIEW2_SHARED_BUFFER_ACCESS_READ_WRITE, '');
end;

procedure TMainForm.SendMsgBtnClick(Sender: TObject);
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
    '  let sharedBuffer;' + CRLF +
    '  window.chrome.webview.addEventListener("message", function(event) {' + CRLF +
    '    document.getElementById('+ quotedstr('messagelog') + ').value += '+ quotedstr('\nMessage received : ') + ' + event.data;' + CRLF +
    '  });' + CRLF +
    '  window.chrome.webview.addEventListener("sharedbufferreceived", e => {' + CRLF +
    '    SharedBufferReceived(e);});' + CRLF +
    '  function sendMessageToHostApp() {' + CRLF +
    '    window.chrome.webview.postMessage(document.getElementById(' + quotedstr('msgtext') + ').value);' + CRLF +
    '  }' + CRLF +
    '  function DisplaySharedBufferData(buffer) {' + CRLF +
    '    document.getElementById("shared-buffer-data").value = new TextDecoder().decode(new Uint8Array(buffer));' + CRLF +
    '  }' + CRLF +
    '  function SharedBufferReceived(e) {' + CRLF +
    '      sharedBuffer = e.getBuffer();' + CRLF +
    '      DisplaySharedBufferData(sharedBuffer);' + CRLF +
    '  }' + CRLF +
    '  function UpdateSharedBufferData(buffer) {' + CRLF +
    '    if (!buffer)' + CRLF +
    '       return;' + CRLF +
    '    const sharedArray = new Uint8Array(buffer);' + CRLF +
    '    sharedArray.fill(0);' + CRLF +
    '    let data = new TextEncoder().encode(document.getElementById("shared-buffer-data").value.trim());' + CRLF +
    '    sharedArray.set(data.subarray(0, data.length));' + CRLF +
    '    window.chrome.webview.postMessage("SharedBufferDataUpdated");' + CRLF +
    '  }' + CRLF +
    '</script></head><body>' +
    '<p><input value="Hello from the web browser!" id="msgtext"></br>' +
    '<button onclick="sendMessageToHostApp()">Send a message to the host application >>></button></p></br>' +
    '<hr>' + CRLF +
    '<p>Messages from the host application :</br><textarea id="messagelog" rows="10" cols="80"></textarea></p>' +
    '<hr>' + CRLF +
    '<p>Shared buffer contents sent from the host application :</br><textarea id="shared-buffer-data" rows="10" cols="80"></textarea></p>' +
    '<p><button onclick="UpdateSharedBufferData(sharedBuffer)">Update data in shared buffer</button></p>' +
    '</body></html>';

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
  TempMsg  : string;
  TempNewBuffer : array[0..CUSTOM_SHARED_BUFFER_SIZE - 1] of WideChar;
begin
  TempArgs := TCoreWebView2WebMessageReceivedEventArgs.Create(aArgs);
  TempMsg  := TempArgs.WebMessageAsString;
  MessagesMem.Lines.Add('Message received : ' + TempMsg);

  // The "SharedBufferDataUpdated" message is used to notify the main process that the buffer has been updated.
  if (TempMsg = 'SharedBufferDataUpdated') and assigned(FSharedBuffer) then
    begin
      FillChar(TempNewBuffer, CUSTOM_SHARED_BUFFER_SIZE, 0);
      // Convert the buffer encoded in UTF8 to a unicode string
      UTF8ToUnicode(TempNewBuffer, PAnsiChar(FSharedBuffer.Buffer), CUSTOM_SHARED_BUFFER_SIZE);
      MessagesMem.Lines.Add('New shared buffer contents : ' + TempNewBuffer);
    end;

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
