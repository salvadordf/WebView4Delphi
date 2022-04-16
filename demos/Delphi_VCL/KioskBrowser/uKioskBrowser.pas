unit uKioskBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args,
  uWVBrowserBase, Vcl.Menus, Vcl.Touch.Keyboard;

type
  TMainForm = class(TForm)
    WVWindowParent1: TWVWindowParent;
    Timer1: TTimer;
    WVBrowser1: TWVBrowser;
    TouchKeyboard1: TTouchKeyboard;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1WebMessageReceived(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebMessageReceivedEventArgs);
    procedure WVBrowser1AcceleratorKeyPressed(Sender: TObject; const aController: ICoreWebView2Controller; const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs);
    procedure WVBrowser1NewWindowRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
    procedure WVBrowser1ContextMenuRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2ContextMenuRequestedEventArgs);
    procedure WVBrowser1CustomItemSelected(Sender: TObject; const aMenuItem: ICoreWebView2ContextMenuItem);

  protected
    FExitCommandID : integer;

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

// This is a demo with the simplest web browser you can build using WebView4Delphi and
// it doesn't show any sign of progress like other web browsers do.

// Remember that it may take a few seconds to load if Windows update, your antivirus or
// any other windows service is using your hard drive.

// Depending on your internet connection it may take longer than expected.

// Please check that your firewall or antivirus are not blocking this application
// or the domain "bing.com".

// The "initialization" section in this unit loads GlobalWebView2Loader which will create
// the global environment asynchronously.

// The browser needs the global environment but the form might be created before that so we
// use a simple timer to create the browser in case the environment is not ready when
// TForm.OnShow is triggered.

// GlobalWebView2Loader will be destroyed automatically in the "finalization" section of
// uWVLoader.pas. All browsers should be already destroyed before GlobalWebView2Loader
// is destroyed.

uses
  uWVCoreWebView2ContextMenuItemCollection, uWVCoreWebView2ContextMenuItem;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FExitCommandID := 0;
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

procedure TMainForm.WVBrowser1AcceleratorKeyPressed(Sender: TObject;
  const aController: ICoreWebView2Controller;
  const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs);
var
  TempArgs : TCoreWebView2AcceleratorKeyPressedEventArgs;
begin
  TempArgs := TCoreWebView2AcceleratorKeyPressedEventArgs.Create(aArgs);

  // If the user presses the ESC key then we close this form.
  if (TempArgs.VirtualKey = vk_Escape) then
    begin
      TempArgs.Handled := True;
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;

  TempArgs.Free;
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;

  // Set the virtual host to map local files to any URL with a customhost.test domain
  WVBrowser1.SetVirtualHostNameToFolderMapping('customhost.test', '..\assets', COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_ALLOW);
end;

procedure TMainForm.WVBrowser1ContextMenuRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2ContextMenuRequestedEventArgs);
var
  TempArgs        : TCoreWebView2ContextMenuRequestedEventArgs;
  TempCollection  : TCoreWebView2ContextMenuItemCollection;
  TempMenuItemItf : ICoreWebView2ContextMenuItem;
  TempMenuItem    : TCoreWebView2ContextMenuItem;
begin
  TempArgs       := TCoreWebView2ContextMenuRequestedEventArgs.Create(aArgs);
  TempCollection := TCoreWebView2ContextMenuItemCollection.Create(TempArgs.MenuItems);
  TempMenuItem   := nil;

  try
    TempCollection.RemoveAllMenuItems;

    if WVBrowser1.CoreWebView2Environment.CreateContextMenuItem('Exit', nil, COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_COMMAND, TempMenuItemItf) then
      try
        TempMenuItem   := TCoreWebView2ContextMenuItem.Create(TempMenuItemItf);
        FExitCommandID := TempMenuItem.CommandId;
        TempMenuItem.AddCustomItemSelectedEvent(WVBrowser1);
        TempCollection.InsertValueAtIndex(0, TempMenuItemItf);
      finally
        FreeAndNil(TempMenuItem);
      end;
  finally
    FreeAndNil(TempCollection);
    FreeAndNil(TempArgs);
  end;
end;

procedure TMainForm.WVBrowser1CustomItemSelected(Sender: TObject;
  const aMenuItem: ICoreWebView2ContextMenuItem);
var
  TempMenuItem : TCoreWebView2ContextMenuItem;
begin
  TempMenuItem := TCoreWebView2ContextMenuItem.Create(aMenuItem);

  if (TempMenuItem.CommandId = FExitCommandID) then
    PostMessage(Handle, WM_CLOSE, 0, 0);

  FreeAndNil(TempMenuItem);
end;

procedure TMainForm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

procedure TMainForm.WVBrowser1NewWindowRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
var
  TempArgs : TCoreWebView2NewWindowRequestedEventArgs;
begin
  // This demo blocks new windows
  TempArgs         := TCoreWebView2NewWindowRequestedEventArgs.Create(aArgs);
  TempArgs.Handled := True;
  TempArgs.Free;
end;

procedure TMainForm.WVBrowser1WebMessageReceived(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2WebMessageReceivedEventArgs);
var
  TempArgs : TCoreWebView2WebMessageReceivedEventArgs;
begin
  TempArgs := TCoreWebView2WebMessageReceivedEventArgs.Create(aArgs);
  // This demo only has some INPUT elements that might need a virtual keyboard in a Kiosk
  // The INPUT elements use the OnFocus and OnBlur events to send their tag name as a parameter of
  // window.chrome.webview.postMessage
  TouchKeyboard1.Visible := (CompareText(TempArgs.WebMessageAsString, 'input') = 0);
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
  GlobalWebView2Loader                 := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder  := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.KioskPrinting   := True; // This property enables silent priting
  GlobalWebView2Loader.DisableFeatures := 'msWebOOUI,msPdfOOUI';  // Disable the text selection context menu
  GlobalWebView2Loader.StartWebView2;

end.
