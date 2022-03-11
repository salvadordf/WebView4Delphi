unit uMiniBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  WinApi.TlHelp32, Winapi.PsAPI,
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args, uWVCoreWebView2DownloadOperation,
  uWVBrowserBase, uBasicUserAuthForm;

const
  PWV_SHOWUSERAUTH  = WM_APP + $A50;

type
  TMiniBrowserFrm = class(TForm)
    NavControlPnl: TPanel;
    NavButtonPnl: TPanel;
    BackBtn: TButton;
    ForwardBtn: TButton;
    ReloadBtn: TButton;
    StopBtn: TButton;
    URLEditPnl: TPanel;
    URLCbx: TComboBox;
    ConfigPnl: TPanel;
    ConfigBtn: TButton;
    GoBtn: TButton;
    StatusBar1: TStatusBar;
    WVWindowParent1: TWVWindowParent;
    WVBrowser1: TWVBrowser;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Print1: TMenuItem;
    Print2: TMenuItem;
    N1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N2: TMenuItem;
    LoadFromFileMi: TMenuItem;
    Opentaskmanager1: TMenuItem;
    DevTools1: TMenuItem;
    Zoom1: TMenuItem;
    Inczoom1: TMenuItem;
    Deczoom1: TMenuItem;
    REsetzoom1: TMenuItem;
    akesnapshot1: TMenuItem;
    Blockimages1: TMenuItem;
    ShowHTTPheaders1: TMenuItem;
    Clearcache1: TMenuItem;
    Offline1: TMenuItem;
    Ignorecertificateerrors1: TMenuItem;
    Availablebrowserversion1: TMenuItem;
    SaveToFileMi: TMenuItem;
    Changeuseragentstring1: TMenuItem;
    Muted1: TMenuItem;
    Browserprocesses1: TMenuItem;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure Timer1Timer(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);

    procedure ConfigBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure Print2Click(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure ForwardBtnClick(Sender: TObject);
    procedure ReloadBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure LoadFromFileMiClick(Sender: TObject);
    procedure Opentaskmanager1Click(Sender: TObject);
    procedure DevTools1Click(Sender: TObject);
    procedure Inczoom1Click(Sender: TObject);
    procedure Deczoom1Click(Sender: TObject);
    procedure Resetzoom1Click(Sender: TObject);
    procedure Takesnapshot1Click(Sender: TObject);
    procedure Blockimages1Click(Sender: TObject);
    procedure ShowHTTPheaders1Click(Sender: TObject);
    procedure Clearcache1Click(Sender: TObject);
    procedure Offline1Click(Sender: TObject);
    procedure Ignorecertificateerrors1Click(Sender: TObject);
    procedure Availablebrowserversion1Click(Sender: TObject);
    procedure SaveToFileMiClick(Sender: TObject);
    procedure Changeuseragentstring1Click(Sender: TObject);
    procedure Muted1Click(Sender: TObject);
    procedure Browserprocesses1Click(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1PrintToPdfCompleted(Sender: TObject; aErrorCode: HRESULT; aIsSuccessful: Boolean);
    procedure WVBrowser1SourceChanged(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SourceChangedEventArgs);
    procedure WVBrowser1NavigationStarting(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationStartingEventArgs);
    procedure WVBrowser1NavigationCompleted(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure WVBrowser1DownloadStarting(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2DownloadStartingEventArgs);
    procedure WVBrowser1DownloadStateChanged(Sender: TObject; const aDownloadOperation: ICoreWebView2DownloadOperation; aDownloadID : integer);
    procedure WVBrowser1BytesReceivedChanged(Sender: TObject; const aDownloadOperation: ICoreWebView2DownloadOperation; aDownloadID : integer);
    procedure WVBrowser1CapturePreviewCompleted(Sender: TObject; aErrorCode: HRESULT);
    procedure WVBrowser1WebResourceRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
    procedure WVBrowser1WebResourceResponseReceived(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2WebResourceResponseReceivedEventArgs);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1RetrieveHTMLCompleted(Sender: TObject; aResult: Boolean; const aHTML: wvstring);
    procedure WVBrowser1RetrieveTextCompleted(Sender: TObject; aResult: Boolean; const aText: wvstring);
    procedure WVBrowser1RetrieveMHTMLCompleted(Sender: TObject; aResult: Boolean; const aMHTML: wvstring);
    procedure WVBrowser1BasicAuthenticationRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2BasicAuthenticationRequestedEventArgs);

  protected
    FDownloadOperation : TCoreWebView2DownloadOperation;
    FDownloadIDGen     : integer;
    FFileStream        : TFileStream;
    FBlockImages       : boolean;
    FGetHeaders        : boolean;
    FHeaders           : TStringList;
    FUserAuthFrm       : TTBasicUserAuthForm;

    procedure UpdateNavButtons(aIsNavigating : boolean);
    procedure UpdateDownloadInfo(aDownloadID : integer);
    function  GetNextDownloadID : integer;

    procedure LoadFromFileAsString(const aFileName : string);
    procedure LoadFromFileAsFileURI(const aFileName : string);
    procedure SaveAsTextFile(const aFileName : string; const aFileContents : wvstring);

    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
    procedure ShowUserAuthMsg(var aMessage : TMessage); message PWV_SHOWUSERAUTH;
  public
    { Public declarations }
  end;

var
  MiniBrowserFrm: TMiniBrowserFrm;

implementation

{$R *.dfm}

uses
  Winapi.ActiveX, uTextViewerForm,
  uWVCoreWebView2WebResourceResponseView, uWVCoreWebView2HttpResponseHeaders,
  uWVCoreWebView2HttpHeadersCollectionIterator,
  uWVCoreWebView2ProcessInfoCollection, uWVCoreWebView2ProcessInfo;

procedure TMiniBrowserFrm.Takesnapshot1Click(Sender: TObject);
var
  TempAdapter : IStream;
begin
  SaveDialog1.Filter     := 'PNG files (*.png)|*.png';
  SaveDialog1.DefaultExt := 'png';

  if SaveDialog1.Execute and (length(SaveDialog1.FileName) > 0) then
    try
      if (FFileStream <> nil) then FreeAndNil(FFileStream);

      FFileStream := TFileStream.Create(SaveDialog1.FileName, fmCreate);
      TempAdapter := TStreamAdapter.Create(FFileStream, soReference);

      WVBrowser1.CapturePreview(COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_PNG, TempAdapter);
    finally
      TempAdapter := nil;
    end;
end;

procedure TMiniBrowserFrm.Availablebrowserversion1Click(Sender: TObject);
begin
  showmessage('Available browser version : ' + GlobalWebView2Loader.AvailableBrowserVersion);
end;

procedure TMiniBrowserFrm.BackBtnClick(Sender: TObject);
begin
  WVBrowser1.GoBack;
end;

procedure TMiniBrowserFrm.Blockimages1Click(Sender: TObject);
begin
  FBlockImages := not(FBlockImages);
end;

procedure TMiniBrowserFrm.Browserprocesses1Click(Sender: TObject);
var
  TempCollection : TCoreWebView2ProcessInfoCollection;
  TempInfo : TCoreWebView2ProcessInfo;
  i : cardinal;
  TempSL : TStringList;
  TempItemInfo : string;
  TempHandle : THandle;
  TempMemCtrs  : TProcessMemoryCounters;
begin
  TempCollection := nil;
  TempInfo       := nil;
  TempSL         := nil;

  try
    TempSL         := TStringList.Create;
    TempCollection := TCoreWebView2ProcessInfoCollection.Create(WVBrowser1.ProcessInfos);

    i := 0;
    while (i < TempCollection.Count) do
      begin
        if assigned(TempInfo) then
          TempInfo.BaseIntf := TempCollection.items[i]
         else
          Tempinfo := TCoreWebView2ProcessInfo.Create(TempCollection.items[i]);

        TempItemInfo := 'Process type : ';

        case TempInfo.Kind of
          COREWEBVIEW2_PROCESS_KIND_BROWSER        : TempItemInfo := TempItemInfo + 'Browser';
          COREWEBVIEW2_PROCESS_KIND_RENDERER       : TempItemInfo := TempItemInfo + 'Renderer';
          COREWEBVIEW2_PROCESS_KIND_UTILITY        : TempItemInfo := TempItemInfo + 'Utility';
          COREWEBVIEW2_PROCESS_KIND_SANDBOX_HELPER : TempItemInfo := TempItemInfo + 'Sandbox helper';
          COREWEBVIEW2_PROCESS_KIND_GPU            : TempItemInfo := TempItemInfo + 'GPU';
          COREWEBVIEW2_PROCESS_KIND_PPAPI_PLUGIN   : TempItemInfo := TempItemInfo + 'PPAPI plugin';
          COREWEBVIEW2_PROCESS_KIND_PPAPI_BROKER   : TempItemInfo := TempItemInfo + 'PPAPI broker';
          else                                       TempItemInfo := TempItemInfo + 'Unknown';
        end;

        TempItemInfo := TempItemInfo + ', Process ID : ' + IntToStr(TempInfo.ProcessId);
        TempHandle   := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, TempInfo.ProcessId);

        if (TempHandle <> 0) then
          try
            ZeroMemory(@TempMemCtrs, SizeOf(TProcessMemoryCounters));
            TempMemCtrs.cb := SizeOf(TProcessMemoryCounters);

            if GetProcessMemoryInfo(TempHandle, @TempMemCtrs, TempMemCtrs.cb) then
              TempItemInfo := TempItemInfo + ', Memory : ' + IntToStr(TempMemCtrs.WorkingSetSize);
          finally
            CloseHandle(TempHandle);
          end;

        TempSL.Add(TempItemInfo);
        inc(i);
      end;

    TextViewerFrm.Caption := 'Process info';
    TextViewerFrm.Memo1.Lines.Clear;
    TextViewerFrm.Memo1.Lines.AddStrings(TempSL);
    TextViewerFrm.Show;
  finally
    if assigned(TempCollection) then
      FreeAndNil(TempCollection);

    if assigned(TempInfo) then
      FreeAndNil(TempInfo);

    if assigned(TempSL) then
      FreeAndNil(TempSL);
  end;
end;

procedure TMiniBrowserFrm.Changeuseragentstring1Click(Sender: TObject);
var
  TempUA : string;
begin
  TempUA := inputbox('Change the user agent string', 'New user agent :', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:95.0) Gecko/20100101 Firefox/95.0');

  if (length(TempUA) > 0) then
    WVBrowser1.UserAgent := TempUA;
end;

procedure TMiniBrowserFrm.Clearcache1Click(Sender: TObject);
begin
  WVBrowser1.ClearCache;
end;

procedure TMiniBrowserFrm.ConfigBtnClick(Sender: TObject);
var
  TempPoint : TPoint;
begin
  TempPoint.x := ConfigBtn.left;
  TempPoint.y := ConfigBtn.top + ConfigBtn.Height;
  TempPoint   := ConfigPnl.ClientToScreen(TempPoint);

  PopupMenu1.Popup(TempPoint.x, TempPoint.y);
end;

procedure TMiniBrowserFrm.Deczoom1Click(Sender: TObject);
begin
  WVBrowser1.DecZoomStep;
end;

procedure TMiniBrowserFrm.DevTools1Click(Sender: TObject);
begin
  WVBrowser1.OpenDevToolsWindow;
end;

procedure TMiniBrowserFrm.FormCreate(Sender: TObject);
begin
  FGetHeaders             := True;
  FHeaders                := TStringList.Create;
  FFileStream             := nil;
  FUserAuthFrm            := nil;
  FBlockImages            := False;
  FDownloadIDGen          := 0;
  FDownloadOperation      := nil;
  WVBrowser1.DefaultURL := URLCbx.Text;
end;

procedure TMiniBrowserFrm.FormDestroy(Sender: TObject);
begin
  if (FHeaders <> nil) then
    FreeAndNil(FHeaders);

  if (FFileStream <> nil) then
    FreeAndNil(FFileStream);

  if assigned(FDownloadOperation) then
    FreeAndNil(FDownloadOperation);
end;

procedure TMiniBrowserFrm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
     else
      Timer1.Enabled := True;
end;

procedure TMiniBrowserFrm.ForwardBtnClick(Sender: TObject);
begin
  WVBrowser1.GoForward;
end;

procedure TMiniBrowserFrm.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.Navigate(URLCbx.Text);
end;

procedure TMiniBrowserFrm.Ignorecertificateerrors1Click(Sender: TObject);
begin
  WVBrowser1.IgnoreCertificateErrors := not(WVBrowser1.IgnoreCertificateErrors);
end;

procedure TMiniBrowserFrm.Inczoom1Click(Sender: TObject);
begin
  WVBrowser1.IncZoomStep;
end;

procedure TMiniBrowserFrm.LoadFromFileMiClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'HTML files (*.html)|*.html|' +
                        'Text files (*.txt)|*.txt|' +
                        'PDF files (*.pdf)|*.pdf|' +
                        'MHTML files (*.mhtml)|*.mhtml';

  if OpenDialog1.Execute then
    case OpenDialog1.FilterIndex of
      1       : LoadFromFileAsString(OpenDialog1.FileName);
      2, 3, 4 : LoadFromFileAsFileURI(OpenDialog1.FileName);
    end;
end;

procedure TMiniBrowserFrm.Muted1Click(Sender: TObject);
begin
  WVBrowser1.ToggleMuteState;
end;

procedure TMiniBrowserFrm.LoadFromFileAsString(const aFileName : string);
var
  TempLines : TStringList;
begin
  TempLines := nil;

  try
    try
      if (length(aFileName) > 0) and FileExists(aFileName) then
        begin
          TempLines := TStringList.Create;
          TempLines.LoadFromFile(OpenDialog1.FileName);
          WVBrowser1.NavigateToString(TempLines.Text);
        end;
    except
      {$IFDEF DEBUG}
      on e : exception do
        OutputDebugString(PWideChar('TMiniBrowserFrm.LoadFromFileAsString error: ' + e.message + chr(0)));
      {$ENDIF}
    end;
  finally
    if assigned(TempLines) then
      FreeAndNil(TempLines);
  end;
end;

procedure TMiniBrowserFrm.LoadFromFileAsFileURI(const aFileName : string);
var
  TempFileURI: string;
begin
  if (length(aFileName) > 0) and FileExists(aFileName) then
    begin
      // TODO: The Filename should be escaped
      TempFileURI := 'file:///' + aFileName;

      WVBrowser1.Navigate(TempFileURI);
    end;
end;

procedure TMiniBrowserFrm.Offline1Click(Sender: TObject);
begin
  WVBrowser1.Offline := not(WVBrowser1.Offline);
end;

procedure TMiniBrowserFrm.Opentaskmanager1Click(Sender: TObject);
begin
  WVBrowser1.OpenTaskManagerWindow;
end;

procedure TMiniBrowserFrm.PopupMenu1Popup(Sender: TObject);
begin
  Blockimages1.Checked             := FBlockImages;
  Offline1.Checked                 := WVBrowser1.Offline;
  Ignorecertificateerrors1.Checked := WVBrowser1.IgnoreCertificateErrors;
  Muted1.Checked                   := WVBrowser1.IsMuted;
end;

procedure TMiniBrowserFrm.Print1Click(Sender: TObject);
begin
  WVBrowser1.Print;
end;

procedure TMiniBrowserFrm.Print2Click(Sender: TObject);
begin
  SaveDialog1.Filter     := 'PDF files (*.pdf)|*.pdf';
  SaveDialog1.DefaultExt := 'pdf';

  if SaveDialog1.Execute and (length(SaveDialog1.FileName) > 0) then
    WVBrowser1.PrintToPDF(SaveDialog1.FileName);
end;

procedure TMiniBrowserFrm.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  Caption := 'MiniBrowser';
  NavControlPnl.Enabled := True;

  // We need to a filter to enable the TWVBrowser.OnWebResourceRequested event
  WVBrowser1.AddWebResourceRequestedFilter('*', COREWEBVIEW2_WEB_RESOURCE_CONTEXT_IMAGE);
  WVBrowser1.AddWebResourceRequestedFilter('*', COREWEBVIEW2_WEB_RESOURCE_CONTEXT_MEDIA);
end;

procedure TMiniBrowserFrm.WVBrowser1BasicAuthenticationRequested(
  Sender: TObject; const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2BasicAuthenticationRequestedEventArgs);
begin
  FUserAuthFrm := TTBasicUserAuthForm.Create(self, aArgs);
  // Modal forms and dialogs must be shown outside WebView events
  // https://docs.microsoft.com/en-us/microsoft-edge/webview2/concepts/threading-model
  PostMessage(Handle, PWV_SHOWUSERAUTH, 0, 0);
end;

procedure TMiniBrowserFrm.WVBrowser1BytesReceivedChanged(Sender: TObject;
  const aDownloadOperation: ICoreWebView2DownloadOperation; aDownloadID : integer);
begin
  UpdateDownloadInfo(aDownloadID);
end;

procedure TMiniBrowserFrm.WVBrowser1CapturePreviewCompleted(
  Sender: TObject; aErrorCode: HRESULT);
begin
  if not(succeeded(aErrorCode)) then
    showmessage('There was an error taking the snapshot');

  if (FFileStream <> nil) then
    FreeAndNil(FFileStream);
end;

procedure TMiniBrowserFrm.UpdateDownloadInfo(aDownloadID : integer);
var
  TempStatus : string;
  TempPct : double;
begin
  if assigned(FDownloadOperation) and (FDownloadOperation.DownloadID = aDownloadID) then
    begin
      TempStatus := 'Downloading...';

      if (FDownloadOperation.TotalBytesToReceive <> 0) then
        begin
          TempPct    := (FDownloadOperation.BytesReceived / FDownloadOperation.TotalBytesToReceive) * 100;
          TempStatus := TempStatus + ' ' + inttostr(round(TempPct)) + '%';
        end
       else
        TempStatus := TempStatus + ' ' + inttostr(FDownloadOperation.BytesReceived) + ' bytes';

      TempStatus := TempStatus + ' - Estimated end time : ' + TimeToStr(FDownloadOperation.EstimatedEndTime);

      StatusBar1.Panels[0].Text := TempStatus;
    end;
end;

function TMiniBrowserFrm.GetNextDownloadID : integer;
begin
  inc(FDownloadIDGen);
  Result := FDownloadIDGen;
end;

procedure TMiniBrowserFrm.WVBrowser1DocumentTitleChanged(
  Sender: TObject);
begin
  Caption := 'MiniBrowser - ' + WVBrowser1.DocumentTitle;
end;

procedure TMiniBrowserFrm.WVBrowser1DownloadStarting(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2DownloadStartingEventArgs);
var
  TempArgs : TCoreWebView2DownloadStartingEventArgs;
begin
  // This demo only allows 1 file download at the same time.
  // Create a list of TCoreWebView2DownloadOperation if you need to handle more file downloads and check the DownloadID field.

  TempArgs := TCoreWebView2DownloadStartingEventArgs.Create(aArgs);

  if assigned(TempArgs.DownloadOperation) and not(assigned(FDownloadOperation)) then
    begin
      FDownloadOperation := TCoreWebView2DownloadOperation.Create(TempArgs.DownloadOperation, GetNextDownloadID);
      FDownloadOperation.AddAllBrowserEvents(WVBrowser1);
      // We hide the download window
      TempArgs.Handled := True;
    end;

  FreeAndNil(TempArgs);
end;

procedure TMiniBrowserFrm.WVBrowser1DownloadStateChanged(Sender: TObject; const aDownloadOperation: ICoreWebView2DownloadOperation; aDownloadID : integer);
begin
  if assigned(FDownloadOperation) and (FDownloadOperation.DownloadID = aDownloadID) then
    begin
      case FDownloadOperation.State of
        COREWEBVIEW2_DOWNLOAD_STATE_IN_PROGRESS :
          UpdateDownloadInfo(aDownloadID);

        COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED :
          begin
            StatusBar1.Panels[0].Text := 'Download was interrupted';
            FreeAndNil(FDownloadOperation);
          end;

        COREWEBVIEW2_DOWNLOAD_STATE_COMPLETED :
          begin
            StatusBar1.Panels[0].Text := 'Download complete!';
            FreeAndNil(FDownloadOperation);
          end;
      end;
    end;
end;

procedure TMiniBrowserFrm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

procedure TMiniBrowserFrm.WVBrowser1NavigationCompleted(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  UpdateNavButtons(False);
  StatusBar1.Panels[0].Text := 'Navigation completed.';
end;

procedure TMiniBrowserFrm.WVBrowser1NavigationStarting(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationStartingEventArgs);
begin
  FGetHeaders := True;
  UpdateNavButtons(True);
  StatusBar1.Panels[0].Text := 'Navigating...';
end;

procedure TMiniBrowserFrm.UpdateNavButtons(aIsNavigating : boolean);
begin
  BackBtn.Enabled    := WVBrowser1.CanGoBack;
  ForwardBtn.Enabled := WVBrowser1.CanGoForward;
  ReloadBtn.Enabled  := not(aIsNavigating);
  StopBtn.Enabled    := aIsNavigating;
end;

procedure TMiniBrowserFrm.WVBrowser1PrintToPdfCompleted(Sender: TObject;
  aErrorCode: HRESULT; aIsSuccessful: Boolean);
begin
  if aIsSuccessful then
    showmessage('The PDF file was generated successfully')
   else
    showmessage('There was a problem generating the PDF file.');
end;

procedure TMiniBrowserFrm.SaveAsTextFile(const aFileName : string; const aFileContents : wvstring);
var
  TempSL : TStringList;
begin
  TempSL := nil;

  if (length(aFileName) > 0) then
    try
      try
        TempSL      := TStringList.Create;
        TempSL.Text := aFileContents;
        TempSL.SaveToFile(aFileName);
      except
        {$IFDEF DEBUG}
        on e: exception do
          OutputDebugString(PWideChar('TMiniBrowserFrm.SaveAsTextFile error: ' + e.message + chr(0)));
        {$ENDIF}
      end;
    finally
      if assigned(TempSL) then
        FreeAndNil(TempSL);
    end;
end;

procedure TMiniBrowserFrm.WVBrowser1RetrieveHTMLCompleted(Sender: TObject;
  aResult: Boolean; const aHTML: wvstring);
begin
  if aResult then
    SaveAsTextFile(SaveDialog1.FileName, aHTML);
end;

procedure TMiniBrowserFrm.WVBrowser1RetrieveMHTMLCompleted(Sender: TObject;
  aResult: Boolean; const aMHTML: wvstring);
begin
  if aResult then
    SaveAsTextFile(SaveDialog1.FileName, aMHTML);
end;

procedure TMiniBrowserFrm.WVBrowser1RetrieveTextCompleted(Sender: TObject;
  aResult: Boolean; const aText: wvstring);
begin
  if aResult then
    SaveAsTextFile(SaveDialog1.FileName, aText);
end;

procedure TMiniBrowserFrm.WVBrowser1SourceChanged(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
  URLCbx.Text := WVBrowser1.Source;
end;

procedure TMiniBrowserFrm.WVBrowser1WebResourceRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
var
  TempArgs     : TCoreWebView2WebResourceRequestedEventArgs;
  TempResponse : ICoreWebView2WebResourceResponse;
begin
  if FBlockImages and
     WVBrowser1.CoreWebView2Environment.CreateWebResourceResponse(nil, 403, 'Blocked', 'Content-Type: image/jpeg', TempResponse) then
    try
      TempArgs          := TCoreWebView2WebResourceRequestedEventArgs.Create(aArgs);
      TempArgs.Response := TempResponse;
    finally
      FreeAndNil(TempArgs);
      TempResponse := nil;
    end;
end;

procedure TMiniBrowserFrm.WVBrowser1WebResourceResponseReceived(
  Sender: TObject; const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2WebResourceResponseReceivedEventArgs);
var
  TempArgs     : TCoreWebView2WebResourceResponseReceivedEventArgs;
  TempResponse : TCoreWebView2WebResourceResponseView;
  TempHeaders  : TCoreWebView2HttpResponseHeaders;
  TempIterator : TCoreWebView2HttpHeadersCollectionIterator;
  TempName     : wvstring;
  TempValue    : wvstring;
begin
  if FGetHeaders then
    try
      FHeaders.Clear;
      FGetHeaders  := False;
      TempArgs     := TCoreWebView2WebResourceResponseReceivedEventArgs.Create(aArgs);
      TempResponse := TCoreWebView2WebResourceResponseView.Create(TempArgs.Response);
      TempHeaders  := TCoreWebView2HttpResponseHeaders.Create(TempResponse.Headers);
      TempIterator := TCoreWebView2HttpHeadersCollectionIterator.Create(TempHeaders.Iterator);

      while TempIterator.HasCurrentHeader do
        begin
          if TempIterator.GetCurrentHeader(TempName, TempValue) then
            FHeaders.Add(TempName + ': ' + TempValue);

          TempIterator.MoveNext;
        end;
    finally
      FreeAndNil(TempIterator);
      FreeAndNil(TempHeaders);
      FreeAndNil(TempResponse);
      FreeAndNil(TempArgs);
    end;
end;

procedure TMiniBrowserFrm.ReloadBtnClick(Sender: TObject);
begin
  WVBrowser1.Refresh;
end;

procedure TMiniBrowserFrm.Resetzoom1Click(Sender: TObject);
begin
  WVBrowser1.ResetZoom;
end;

procedure TMiniBrowserFrm.SaveToFileMiClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'HTML files (*.html)|*.html|' +
                        'Text files (*.txt)|*.txt|' +
                        'MHTML files (*.mhtml)|*.MHTML';

  if SaveDialog1.Execute then
    case SaveDialog1.FilterIndex of
      1 : WVBrowser1.RetrieveHTML;
      2 : WVBrowser1.RetrieveText;
      3 : WVBrowser1.RetrieveMHTML;
    end;
end;

procedure TMiniBrowserFrm.ShowHTTPheaders1Click(Sender: TObject);
begin
  TextViewerFrm.Caption := 'Headers';
  TextViewerFrm.Memo1.Lines.Text := FHeaders.Text;
  TextViewerFrm.Show;
end;

procedure TMiniBrowserFrm.StopBtnClick(Sender: TObject);
begin
  WVBrowser1.Stop;
end;

procedure TMiniBrowserFrm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  if GlobalWebView2Loader.Initialized then
    WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
   else
    Timer1.Enabled := True;
end;

procedure TMiniBrowserFrm.WMMove(var aMessage : TWMMove);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TMiniBrowserFrm.WMMoving(var aMessage : TMessage);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TMiniBrowserFrm.ShowUserAuthMsg(var aMessage : TMessage);
begin
  FUserAuthFrm.ShowModal;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := ExtractFileDir(Application.ExeName) + '\CustomCache';
  // Uncomment these lines to enable the debug log in 'CustomCache\EBWebView\chrome_debug.log'
  //GlobalWebView2Loader.DebugLog       := TWV2DebugLog.dlEnabled;
  //GlobalWebView2Loader.DebugLogLevel  := TWV2DebugLogLevel.dllInfo;
  GlobalWebView2Loader.StartWebView2;

end.
