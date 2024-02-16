unit uWebpageSnapshot;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Winapi.ActiveX,
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args,
  uWVBrowserBase;

type
  TWebpageSnapshotFrm = class(TForm)
    StatusBar1: TStatusBar;
    Image1: TImage;
    NavigationPnl: TPanel;
    GoBtn: TButton;
    AddressEdt: TEdit;
    WVBrowser1: TWVBrowser;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure GoBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WVBrowser1NavigationCompleted(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure WVBrowser1CapturePreviewCompleted(Sender: TObject;
      aErrorCode: HRESULT);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WVBrowser1RetrieveHTMLCompleted(Sender: TObject;
      aResult: Boolean; const aHTML: wvstring);
  private
    FStream  : TMemoryStream;
  public
    procedure EnableInterface;
  end;

var
  WebpageSnapshotFrm: TWebpageSnapshotFrm;

// This demo shows how to use an invisible browser to take a snapshot.

implementation

{$R *.dfm}

uses
  pngimage;

procedure TWebpageSnapshotFrm.EnableInterface;
begin
  NavigationPnl.Enabled := True;
end;

procedure TWebpageSnapshotFrm.GoBtnClick(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := 'Loading...';
  screen.cursor := crAppStart;

  if WVBrowser1.Initialized then
    WVBrowser1.Navigate(AddressEdt.Text)
   else
    begin
      WVBrowser1.DefaultURL := AddressEdt.Text;
      WVBrowser1.CreateInvisibleBrowser;
    end;
end;

procedure TWebpageSnapshotFrm.WVBrowser1CapturePreviewCompleted(
  Sender: TObject; aErrorCode: HRESULT);
var
  TempImage : TPngImage;
begin
  screen.cursor := crDefault;

  if succeeded(aErrorCode) then
    begin
      FStream.Position := 0;
      TempImage := TPngImage.Create;
      TempImage.LoadFromStream(FStream);
      Image1.Picture.Graphic := TempImage;
      StatusBar1.Panels[0].Text := 'Snapshot copied successfully';
      TempImage.Free;
    end
   else
    StatusBar1.Panels[0].Text := 'There was an error copying the snapshot';
end;

procedure TWebpageSnapshotFrm.WVBrowser1NavigationCompleted(
  Sender: TObject; const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
var
  TempAdapter : IStream;
begin
  try
    if assigned(FStream) then
      FStream.Clear
     else
      FStream := TMemoryStream.Create;

    TempAdapter := TStreamAdapter.Create(FStream);

    WVBrowser1.CapturePreview(COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_PNG, TempAdapter);
    WVBrowser1.RetrieveHTML;
  finally
    TempAdapter := nil;
  end;
end;

procedure TWebpageSnapshotFrm.WVBrowser1RetrieveHTMLCompleted(
  Sender: TObject; aResult: Boolean; const aHTML: wvstring);
begin
  if aResult then
    Memo1.Lines.Text := aHTML
   else
    StatusBar1.Panels[0].Text := 'There was an error getting the HTML';
end;

procedure TWebpageSnapshotFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if assigned(FStream) then
    FStream.Free;
end;

procedure TWebpageSnapshotFrm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.Initialized then
    EnableInterface;
end;

procedure GlobalWebView2Loader_OnEnvironmentCreated(Sender: TObject);
begin
  if assigned(WebpageSnapshotFrm) then
    WebpageSnapshotFrm.EnableInterface;
end;

initialization
  GlobalWebView2Loader                      := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder       := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.OnEnvironmentCreated := GlobalWebView2Loader_OnEnvironmentCreated;
  GlobalWebView2Loader.StartWebView2;

end.
