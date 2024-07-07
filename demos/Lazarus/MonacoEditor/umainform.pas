unit uMainForm;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Messages,
  uWVWindowParent, uWVBrowser, uWVTypes, uWVLoader, uWVTypeLibrary;

type

  { TMainForm }

  TMainForm = class(TForm)
    AddressCb: TComboBox;
    AddressPnl: TPanel;
    GoBtn: TButton;
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    WVWindowParent1: TWVWindowParent;
    procedure FormShow(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject;
      aErrorCode: HRESULT; const aErrorMessage: wvstring);
  protected
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

// This demo loads a local HTML file loaded using a virtual host in a WebView2 browser.

// This file is located in the WebView4Delphi\assets\monaco directory.

// This demo maps the monaco.editor domain to the ..\assets\monaco directory by calling
// TWVBrowser.SetVirtualHostNameToFolderMapping inside the TWVBrowser.OnAfterCreated event.

// Read this for all the details about this feature :
// https://docs.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3?view=webview2-1.0.1020.30#setvirtualhostnametofoldermapping


{ TMainForm }

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

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  if GlobalWebView2Loader.Initialized then
    WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
   else
    Timer1.Enabled := True;
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  Caption := 'Monaco Editor';
  AddressPnl.Enabled := True;          
  WVBrowser1.SetVirtualHostNameToFolderMapping('monaco.editor', '..\assets\monaco', COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_ALLOW);
end;

procedure TMainForm.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  Caption := 'Monaco Editor - ' + UTF8Encode(WVBrowser1.DocumentTitle);
end;

procedure TMainForm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(UTF8Encode(aErrorMessage));
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

