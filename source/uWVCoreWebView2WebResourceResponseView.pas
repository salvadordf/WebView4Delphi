unit uWVCoreWebView2WebResourceResponseView;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// View of the HTTP representation for a web resource response. The properties
  /// of this object are not mutable. This response view is used with the
  /// TWVBrowserBase.OnWebResourceResponseReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseview">See the ICoreWebView2WebResourceResponseView article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceResponseView = class
    protected
      FBaseIntf : ICoreWebView2WebResourceResponseView;

      function  GetInitialized : boolean;
      function  GetHeaders : ICoreWebView2HttpResponseHeaders;
      function  GetStatusCode : integer;
      function  GetReasonPhrase : wvstring;

    public
      constructor Create(const aBaseIntf : ICoreWebView2WebResourceResponseView); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// <para>Get the response content asynchronously. The handler will receive the
      /// response content stream.</para>
      /// <para>This method returns null if content size is more than 123MB or for navigations that become downloads
      /// or if response is downloadable content type (e.g., application/octet-stream).
      /// See `add_DownloadStarting` event to handle the response.</para>
      /// <para>If this method is being called again before a first call has completed,
      /// the handler will be invoked at the same time the handlers from prior calls
      /// are invoked.</para>
      /// <para>If this method is being called after a first call has completed, the
      /// handler will be invoked immediately.</para>
      /// <para>TCoreWebView2WebResourceResponseView.GetContent will trigger the
      /// TWVBrowserBase.OnWebResourceResponseViewGetContentCompleted event with the resource contents.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseview#getcontent">See the ICoreWebView2WebResourceResponseView article.</see></para>
      /// </remarks>
      function    GetContent(const aHandler : ICoreWebView2WebResourceResponseViewGetContentCompletedHandler) : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized  : boolean                               read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf     : ICoreWebView2WebResourceResponseView  read FBaseIntf;
      /// <summary>
      /// The HTTP response status code.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseview#get_statuscode">See the ICoreWebView2WebResourceResponseView article.</see></para>
      /// </remarks>
      property StatusCode   : integer                               read GetStatusCode;
      /// <summary>
      /// The HTTP response reason phrase.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseview#get_reasonphrase">See the ICoreWebView2WebResourceResponseView article.</see></para>
      /// </remarks>
      property ReasonPhrase : wvstring                              read GetReasonPhrase;
      /// <summary>
      /// The HTTP response headers as received.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseview#get_headers">See the ICoreWebView2WebResourceResponseView article.</see></para>
      /// </remarks>
      property Headers      : ICoreWebView2HttpResponseHeaders      read GetHeaders;
  end;

implementation

constructor TCoreWebView2WebResourceResponseView.Create(const aBaseIntf: ICoreWebView2WebResourceResponseView);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2WebResourceResponseView.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceResponseView.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebResourceResponseView.GetContent(const aHandler : ICoreWebView2WebResourceResponseViewGetContentCompletedHandler) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.GetContent(aHandler));
end;

function TCoreWebView2WebResourceResponseView.GetHeaders : ICoreWebView2HttpResponseHeaders;
var
  TempResult : ICoreWebView2HttpResponseHeaders;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Headers(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2WebResourceResponseView.GetStatusCode : integer;
var
  TempResult : SYSINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_StatusCode(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2WebResourceResponseView.GetReasonPhrase : wvstring;
var
  TempString : PWideChar;
begin
  Result    := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ReasonPhrase(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
