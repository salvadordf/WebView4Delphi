unit uCustomSchemeBrowser;

{$MODE Delphi}

interface

{$I webview2.inc}

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, ComCtrls, StdCtrls, ActiveX,
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
    DevToolsBtn: TButton;

    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1WebResourceRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
    procedure DevToolsBtnClick(Sender: TObject);

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

{$R *.lfm}

// This demo registers a custom scheme called "myscheme" and it loads a web page using that scheme.

// In order to register the custom scheme we use the GlobalWebView2Loader.OnGetCustomSchemes event
// where we can allocate an open array with all the custom schemes needed for the browser. In this case
// we only register one scheme.

// This demo calls WVBrowser1.AddWebResourceRequestedFilter because that will trigger
// WVBrowser1.OnWebResourceRequested events where we can open the resource files on the hard drive and
// create the responses with the file contents.

// Read these documents for more information :
// https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions4?view=webview2-1.0.1619-prerelease
// https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customschemeregistration?view=webview2-1.0.1619-prerelease

uses
  uWVCoreWebView2WebResourceRequest;

const
  MY_CUSTOM_SCHEME = 'myscheme';

procedure TMainForm.DevToolsBtnClick(Sender: TObject);
begin
  WVBrowser1.OpenDevToolsWindow;
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
  Caption := 'CustomSchemeBrowser';
  AddressPnl.Enabled := True;

  // Filter all requests to the custom scheme
  WVBrowser1.AddWebResourceRequestedFilter(MY_CUSTOM_SCHEME + '*', COREWEBVIEW2_WEB_RESOURCE_CONTEXT_ALL);
end;

procedure TMainForm.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  Caption := 'CustomSchemeBrowser - ' + WVBrowser1.DocumentTitle;
end;

procedure TMainForm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

procedure TMainForm.WVBrowser1WebResourceRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
const
  URI_START = MY_CUSTOM_SCHEME + '://domain/';
var
  TempArgs     : TCoreWebView2WebResourceRequestedEventArgs;
  TempResponse : ICoreWebView2WebResourceResponse;
  TempRequest  : TCoreWebView2WebResourceRequestRef;
  TempFileName : wvstring;
  TempURI      : wvstring;
  TempStart    : wvstring;
  TempExt      : wvstring;
  TempAdapter  : IStream;
  TempStream   : TFileStream;
begin
  try
    TempArgs    := TCoreWebView2WebResourceRequestedEventArgs.Create(aArgs);
    TempRequest := TCoreWebView2WebResourceRequestRef.Create(TempArgs.Request);
    TempURI     := TempRequest.URI;
    TempStart   := copy(TempURI, 1, length(URI_START));

    if (CompareText(TempStart, URI_START) = 0) then
      begin
        TempFileName := '..\assets\' + copy(TempURI, succ(length(URI_START)), length(TempURI));

        if FileExists(TempFileName) then
          begin
            TempExt     := ExtractFileExt(TempFileName);
            TempStream  := TFileStream.Create(TempFileName, fmOpenRead);
            TempAdapter := TStreamAdapter.Create(TempStream, soOwned);

            if (CompareText(TempExt, '.htm') = 0) or (CompareText(TempExt, '.html') = 0) then
              WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(TempAdapter, 200, 'OK', 'Content-Type: text/html', TempResponse)
             else
              if (CompareText(TempExt, '.css') = 0) then
                WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(TempAdapter, 200, 'OK', 'Content-Type: text/css', TempResponse)
               else
                if (CompareText(TempExt, '.js') = 0) then
                  WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(TempAdapter, 200, 'OK', 'Content-Type: application/javascript', TempResponse)
                 else
                  if (CompareText(TempExt, '.jpg') = 0) then
                    WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(TempAdapter, 200, 'OK', 'Content-Type: image/jpeg', TempResponse)
                   else
                    if (CompareText(TempExt, '.png') = 0) then
                      WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(TempAdapter, 200, 'OK', 'Content-Type: image/png', TempResponse)
                     else
                      WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(nil, 404, 'Not Found', '', TempResponse);
          end
         else
          WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(nil, 404, 'Not Found', '', TempResponse);
      end
     else
      WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(nil, 404, 'Not Found', '', TempResponse);

    TempArgs.Response := TempResponse;
  finally
    FreeAndNil(TempRequest);
    FreeAndNil(TempArgs);
    TempResponse := nil;
    TempAdapter  := nil;
  end;
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

procedure GlobalWebView2Loader_OnGetCustomSchemes(Sender: TObject; var aCustomSchemes: TWVCustomSchemeInfoArray);
begin
  // We can register multiple schemes but this demo only register 1
  SetLength(aCustomSchemes, 1);

  aCustomSchemes[0].SchemeName            := MY_CUSTOM_SCHEME; // The name of the custom scheme to register.
  aCustomSchemes[0].TreatAsSecure         := True; // Whether the sites with this scheme will be treated as a Secure Context like an HTTPS site.
  aCustomSchemes[0].AllowedDomains        := 'https://*.example.com,https://*.briskbard.com'; // Comma separated list of origins that are allowed to issue requests with the custom scheme, such as XHRs and subresource requests that have an Origin header.
  aCustomSchemes[0].HasAuthorityComponent := True; // Set this property to true if the URIs with this custom scheme will have an authority component (a host for custom schemes).
end;

initialization
  GlobalWebView2Loader                    := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder     := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.OnGetCustomSchemes := GlobalWebView2Loader_OnGetCustomSchemes;
  GlobalWebView2Loader.StartWebView2;

end.
