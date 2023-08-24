unit uWVCoreWebView2DownloadOperation;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, Winapi.ActiveX, System.DateUtils,
  {$ELSE}
  Classes, ActiveX, DateUtils,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Represents a download operation. Gives access to the download's metadata
  /// and supports a user canceling, pausing, or resuming the download.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation">See the ICoreWebView2DownloadOperation article.</see></para>
  /// </remarks>
  TCoreWebView2DownloadOperation = class
    protected
      FBaseIntf                     : ICoreWebView2DownloadOperation;
      FBytesReceivedChangedToken    : EventRegistrationToken;
      FEstimatedEndTimeChangedToken : EventRegistrationToken;
      FStateChangedToken            : EventRegistrationToken;
      FDownloadID                   : integer;

      function GetInitialized : boolean;
      function GetURI : wvstring;
      function GetContentDisposition : wvstring;
      function GetMimeType : wvstring;
      function GetTotalBytesToReceive : int64;
      function GetBytesReceived : int64;
      function GetEstimatedEndTime : TDateTime;
      function GetResultFilePath : wvstring;
      function GetState : TWVDownloadState;
      function GetInterruptReason : TWVDownloadInterruptReason;
      function GetCanResume : boolean;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function AddBytesReceivedChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function AddEstimatedEndTimeChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function AddStateChangedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2DownloadOperation wrapper.
      /// </summary>
      /// <param name="aBaseIntf">The ICoreWebView2DownloadOperation instance.</param>
      /// <param name="aDownloadID">Custom ID used to identify this download operation.</param>
      constructor Create(const aBaseIntf : ICoreWebView2DownloadOperation; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Cancels the download. If canceled, the default download dialog shows
      /// that the download was canceled. Host should set the `Cancel` property from
      /// `ICoreWebView2SDownloadStartingEventArgs` if the download should be
      /// canceled without displaying the default download dialog.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#cancel">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      function    Cancel : boolean;
      /// <summary>
      /// Pauses the download. If paused, the default download dialog shows that the
      /// download is paused. No effect if download is already paused. Pausing a
      /// download changes the state to `COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED`
      /// with `InterruptReason` set to `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_USER_PAUSED`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#pause">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      function    Pause : boolean;
      /// <summary>
      /// Resumes a paused download. May also resume a download that was interrupted
      /// for another reason, if `CanResume` returns true. Resuming a download changes
      /// the state from `COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED` to
      /// `COREWEBVIEW2_DOWNLOAD_STATE_IN_PROGRESS`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#resume">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      function    Resume : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized         : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf            : ICoreWebView2DownloadOperation  read FBaseIntf;
      /// <summary>
      /// Custom ID used to identify this download operation.
      /// </summary>
      property DownloadID          : integer                         read FDownloadID;
      /// <summary>
      /// The URI of the download.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_uri">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property URI                 : wvstring                        read GetURI;
      /// <summary>
      /// The Content-Disposition header value from the download's HTTP response.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_contentdisposition">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property ContentDisposition  : wvstring                        read GetContentDisposition;
      /// <summary>
      /// MIME type of the downloaded content.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_mimetype">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property MimeType            : wvstring                        read GetMimeType;
      /// <summary>
      /// The expected size of the download in total number of bytes based on the
      /// HTTP Content-Length header. Returns -1 if the size is unknown.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_totalbytestoreceive">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property TotalBytesToReceive : int64                           read GetTotalBytesToReceive;
      /// <summary>
      /// The number of bytes that have been written to the download file.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_bytesreceived">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property BytesReceived       : int64                           read GetBytesReceived;
      /// <summary>
      /// The estimated end time in [ISO 8601 Date and Time Format](https://www.iso.org/iso-8601-date-and-time-format.html).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_estimatedendtime">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property EstimatedEndTime    : TDateTime                       read GetEstimatedEndTime;
      /// <summary>
      /// The absolute path to the download file, including file name. Host can change
      /// this from `ICoreWebView2DownloadStartingEventArgs`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_resultfilepath">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property ResultFilePath      : wvstring                        read GetResultFilePath;
      /// <summary>
      /// The state of the download. A download can be in progress, interrupted, or
      /// completed. See `COREWEBVIEW2_DOWNLOAD_STATE` for descriptions of states.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_state">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property State               : TWVDownloadState                read GetState;
      /// <summary>
      /// The reason why connection with file host was broken.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_interruptreason">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property InterruptReason     : TWVDownloadInterruptReason      read GetInterruptReason;
      /// <summary>
      /// Returns true if an interrupted download can be resumed. Downloads with
      /// the following interrupt reasons may automatically resume without you
      /// calling any methods:
      /// `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_NO_RANGE`,
      /// `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_HASH_MISMATCH`,
      /// `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_TOO_SHORT`.
      /// In these cases download progress may be restarted with `BytesReceived`
      /// reset to 0.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation#get_canresume">See the ICoreWebView2DownloadOperation article.</see></para>
      /// </remarks>
      property CanResume           : boolean                         read GetCanResume;
  end;

implementation

uses
  uWVBrowserBase, uWVCoreWebView2Delegates, uWVMiscFunctions;

constructor TCoreWebView2DownloadOperation.Create(const aBaseIntf: ICoreWebView2DownloadOperation; aDownloadID : integer);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf   := aBaseIntf;
  FDownloadID := aDownloadID;
end;

destructor TCoreWebView2DownloadOperation.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2DownloadOperation.InitializeFields;
begin
  FBaseIntf   := nil;
  FDownloadID := 0;

  InitializeTokens;
end;

procedure TCoreWebView2DownloadOperation.InitializeTokens;
begin
  FBytesReceivedChangedToken.value    := 0;
  FEstimatedEndTimeChangedToken.value := 0;
  FStateChangedToken.value            := 0;
end;

procedure TCoreWebView2DownloadOperation.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FBytesReceivedChangedToken.value <> 0) then
        FBaseIntf.remove_BytesReceivedChanged(FBytesReceivedChangedToken);

      if (FEstimatedEndTimeChangedToken.value <> 0) then
        FBaseIntf.remove_EstimatedEndTimeChanged(FEstimatedEndTimeChangedToken);

      if (FStateChangedToken.value <> 0) then
        FBaseIntf.remove_StateChanged(FStateChangedToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2DownloadOperation.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddBytesReceivedChangedEvent(aBrowserComponent)    and
            AddEstimatedEndTimeChangedEvent(aBrowserComponent) and
            AddStateChangedEvent(aBrowserComponent);
end;

function TCoreWebView2DownloadOperation.AddBytesReceivedChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BytesReceivedChangedEventHandler;
begin
  Result := False;

  if Initialized and (FBytesReceivedChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2BytesReceivedChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FDownloadID);
      Result      := succeeded(FBaseIntf.add_BytesReceivedChanged(TempHandler, FBytesReceivedChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2DownloadOperation.AddEstimatedEndTimeChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2EstimatedEndTimeChangedEventHandler;
begin
  Result := False;

  if Initialized and (FEstimatedEndTimeChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2EstimatedEndTimeChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FDownloadID);
      Result      := succeeded(FBaseIntf.add_EstimatedEndTimeChanged(TempHandler, FEstimatedEndTimeChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2DownloadOperation.AddStateChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2StateChangedEventHandler;
begin
  Result := False;

  if Initialized and (FStateChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2StateChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FDownloadID);
      Result      := succeeded(FBaseIntf.add_StateChanged(TempHandler, FStateChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2DownloadOperation.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2DownloadOperation.GetURI : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.get_Uri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DownloadOperation.GetContentDisposition : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ContentDisposition(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DownloadOperation.GetMimeType : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_MimeType(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DownloadOperation.GetTotalBytesToReceive : int64;
var
  TempResult : int64;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_TotalBytesToReceive(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2DownloadOperation.GetBytesReceived : int64;
var
  TempResult : int64;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_BytesReceived(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2DownloadOperation.GetEstimatedEndTime : TDateTime;
var
  TempString : PWideChar;
begin
  Result     := 0;
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_EstimatedEndTime(TempString)) then
    begin
      {$IFDEF DELPHI20_UP}
      Result := ISO8601ToDate(TempString, False);
      {$ELSE}
        {$IFDEF FPC}
        Result := ISO8601ToDate(TempString, False);
        {$ELSE}
        TryIso8601BasicToDate(TempString, Result);
        {$ENDIF}
      {$ENDIF}
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DownloadOperation.GetResultFilePath : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ResultFilePath(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DownloadOperation.GetState : TWVDownloadState;
var
  TempResult : COREWEBVIEW2_DOWNLOAD_STATE;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_State(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2DownloadOperation.GetInterruptReason : TWVDownloadInterruptReason;
var
  TempResult : COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_InterruptReason(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2DownloadOperation.GetCanResume : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_CanResume(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2DownloadOperation.Cancel : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Cancel);
end;

function TCoreWebView2DownloadOperation.Pause : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Pause);
end;

function TCoreWebView2DownloadOperation.Resume : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Resume);
end;

end.
