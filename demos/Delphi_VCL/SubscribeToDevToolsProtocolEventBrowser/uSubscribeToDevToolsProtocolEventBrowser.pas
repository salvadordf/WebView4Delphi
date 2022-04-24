unit uSubscribeToDevToolsProtocolEventBrowser;

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
    AddressPnl: TPanel;
    AddressCb: TComboBox;
    GoBtn: TButton;
    Memo1: TMemo;
    Splitter1: TSplitter;

    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1DevToolsProtocolEventReceived(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2DevToolsProtocolEventReceivedEventArgs; const aEventName: wvstring; aEventID: Integer);
    procedure WVBrowser1CallDevToolsProtocolMethodCompleted(Sender: TObject; aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring; aExecutionID: Integer);

  protected
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

// This demo shows how to subscribe to a DevTools event after enabling the "Log" domain.

// Read this page to know all the details about the Log domain :
// https://chromedevtools.github.io/devtools-protocol/1-3/Log/

// These are the steps needed to get the DevTools events :

// First it enables the "Log" doamin with a TWVBrowser.CallDevToolsProtocolMethod
// call in the TWVBrowser.OnAfterCreated event. Notice that it uses a custom
// LOG_ENABLE_CMD constant and an empty JSON parameter "{}".

// After that, the TWVBrowser.OnCallDevToolsProtocolMethodCompleted event checks
// that the aExecutionID is LOG_ENABLE_CMD to subscribe to the event with a
// TWVBrowser.SubscribeToDevToolsProtocolEvent call. Notice that it uses the
// custom LOG_ENTRYADDED_EVENT constant as parameter.

// The TWVBrowser.OnDevToolsProtocolEventReceived event receives all subcribed
// DevTool events and it checks that aEventID is LOG_ENTRYADDED_EVENT before
// handling the aArgs parameter. The TMemo control shows all the received events.
// Use your favorite JSON parser to get the information you need from the aArgs
// parameter.

const
  LOG_ENABLE_CMD = 1;
  LOG_ENTRYADDED_EVENT = 2;

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
  WVBrowser1.Navigate(AddressCb.Text);
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  Caption := 'SubscribeToDevToolsProtocolEventBrowser';
  AddressPnl.Enabled := True;
  Memo1.Lines.Add('Enabling the log domain...');
  if not WVBrowser1.CallDevToolsProtocolMethod('Log.enable', '{}', LOG_ENABLE_CMD) then
    Memo1.Lines.Add('TWVBrowser.CallDevToolsProtocolMethod error');

  GoBtn.Click;
end;

procedure TMainForm.WVBrowser1CallDevToolsProtocolMethodCompleted(
  Sender: TObject; aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring;
  aExecutionID: Integer);
begin
  case aExecutionID of
    LOG_ENABLE_CMD :
      begin
        Memo1.Lines.Add('Subscribing to the Log.entryAdded event...');
        if not WVBrowser1.SubscribeToDevToolsProtocolEvent('Log.entryAdded', LOG_ENTRYADDED_EVENT) then
          Memo1.Lines.Add('TWVBrowser.SubscribeToDevToolsProtocolEvent error');
      end;
  end;
end;

procedure TMainForm.WVBrowser1DevToolsProtocolEventReceived(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2DevToolsProtocolEventReceivedEventArgs;
  const aEventName: wvstring; aEventID: Integer);
var
  TempArgs : TCoreWebView2DevToolsProtocolEventReceivedEventArgs;
begin
  case aEventID of
    LOG_ENTRYADDED_EVENT :
      begin
        TempArgs := TCoreWebView2DevToolsProtocolEventReceivedEventArgs.Create(aArgs);
        Memo1.Lines.Add('Log.entryAdded event received with this parameter : ' + TempArgs.ParameterObjectAsJson);
        TempArgs.Free;
      end;
  end;
end;

procedure TMainForm.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  Caption := 'SubscribeToDevToolsProtocolEventBrowser - ' + WVBrowser1.DocumentTitle;
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
