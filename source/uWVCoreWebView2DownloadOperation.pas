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
      constructor Create(const aBaseIntf : ICoreWebView2DownloadOperation; aDownloadID : integer); reintroduce;
      destructor  Destroy; override;
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      function    Cancel : boolean;
      function    Pause : boolean;
      function    Resume : boolean;

      property Initialized         : boolean                         read GetInitialized;
      property BaseIntf            : ICoreWebView2DownloadOperation  read FBaseIntf;
      property DownloadID          : integer                         read FDownloadID;
      property URI                 : wvstring                        read GetURI;
      property ContentDisposition  : wvstring                        read GetContentDisposition;
      property MimeType            : wvstring                        read GetMimeType;
      property TotalBytesToReceive : int64                           read GetTotalBytesToReceive;
      property BytesReceived       : int64                           read GetBytesReceived;
      property EstimatedEndTime    : TDateTime                       read GetEstimatedEndTime;
      property ResultFilePath      : wvstring                        read GetResultFilePath;
      property State               : TWVDownloadState                read GetState;
      property InterruptReason     : TWVDownloadInterruptReason      read GetInterruptReason;
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
