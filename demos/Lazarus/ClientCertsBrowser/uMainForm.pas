unit uMainForm;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  uWVBrowser, uWVWindowParent, uWVTypeLibrary, uWVLoader, uWVCoreWebView2Args, uWVBrowserBase,
  uChildForm, uWVTypes, uWVEvents;

const
  PWV_SHOWCERTSELECTOR  = WM_APP + $A50;
  PWV_CHILDDESTROYED    = WM_APP + $A51;

type

  { TMainForm }

  TMainForm = class(TForm)
    WVWindowParent1: TWVWindowParent;
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    AddressPnl: TPanel;
    AddressCb: TComboBox;
    GoBtn: TButton;

    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1ClientCertificateRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ClientCertificateRequestedEventArgs);
    procedure WVBrowser1InitializationError(Sender: TObject;
      aErrorCode: HRESULT; const aErrorMessage: wvstring);

  protected
    FUseDefaultCerSelector : boolean;
    FCertSelectorFrm : TChildForm;

    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
    procedure ShowCertSelectorMsg(var aMessage : TMessage); message PWV_SHOWCERTSELECTOR;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

// This demo shows how to use a custom form to select a client certificate in
// the TWVBrowser.OnClientCertificateRequested event

// Use a different web page to test your certificates in case you don't have one
// from the Spanish FNMT.

procedure TMainForm.FormShow(Sender: TObject);
begin
  // Set FUseDefaultCerSelector to True if you want to use the default selector.
  FUseDefaultCerSelector := False;

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
  Caption := 'ClientCertsBrowser';
  AddressPnl.Enabled := True;
end;

procedure TMainForm.WVBrowser1ClientCertificateRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2ClientCertificateRequestedEventArgs);
var
  TempArgs : TCoreWebView2ClientCertificateRequestedEventArgs;
begin
  if FUseDefaultCerSelector then
    begin
      // Setting TempArgs.Handled and TempArgs.Cancel to False shows the default certificate selection window.
      // https://docs.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_5?view=webview2-1.0.1020.30#add_clientcertificaterequested
      TempArgs         := TCoreWebView2ClientCertificateRequestedEventArgs.Create(aArgs);
      TempArgs.Handled := False;
      TempArgs.Cancel  := False;
      FreeAndNil(TempArgs);
    end
   else
    begin
      FCertSelectorFrm := TChildForm.Create(self, aArgs);
      // Modal forms and dialogs must be shown outside WebView events
      // https://docs.microsoft.com/en-us/microsoft-edge/webview2/concepts/threading-model
      PostMessage(Handle, PWV_SHOWCERTSELECTOR, 0, 0);
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

procedure TMainForm.ShowCertSelectorMsg(var aMessage : TMessage);
begin
  FCertSelectorFrm.ShowModal;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := UTF8Decode(ExtractFileDir(Application.ExeName) + '\CustomCache');
  GlobalWebView2Loader.StartWebView2;

end.
