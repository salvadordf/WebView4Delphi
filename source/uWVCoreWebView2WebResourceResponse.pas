unit uWVCoreWebView2WebResourceResponse;

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
  /// An HTTP response used with the WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponse">See the ICoreWebView2WebResourceResponse article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceResponse = class
    protected
      FBaseIntf : ICoreWebView2WebResourceResponse;

      function  GetInitialized : boolean;
      function  GetContent : IStream;
      function  GetHeaders : ICoreWebView2HttpResponseHeaders;
      function  GetStatusCode : integer;
      function  GetReasonPhrase : wvstring;

      procedure SetContent(const aContent: IStream);
      procedure SetStatusCode(aStatusCode: integer);
      procedure SetReasonPhrase(const aValue : wvstring);

    public
      constructor Create(const aBaseIntf : ICoreWebView2WebResourceResponse); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized  : boolean                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf     : ICoreWebView2WebResourceResponse  read FBaseIntf;
      /// <summary>
      /// The HTTP response status code.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponse#get_statuscode">See the ICoreWebView2WebResourceResponse article.</see></para>
      /// </remarks>
      property StatusCode   : integer                           read GetStatusCode    write SetStatusCode;
      /// <summary>
      /// The HTTP response reason phrase.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponse#get_reasonphrase">See the ICoreWebView2WebResourceResponse article.</see></para>
      /// </remarks>
      property ReasonPhrase : wvstring                          read GetReasonPhrase  write SetReasonPhrase;
      /// <summary>
      /// <para>HTTP response content as stream.  Stream must have all the content data
      /// available by the time the `WebResourceRequested` event deferral of this
      /// response is completed.  Stream should be agile or be created from a
      /// background thread to prevent performance impact to the UI thread.  `Null`
      ///  means no content data.  `IStream` semantics apply (return `S_OK` to
      /// `Read` runs until all data is exhausted).</para>
      /// <para>When providing the response data, you should consider relevant HTTP
      /// request headers just like an HTTP server would do. For example, if the
      /// request was for a video resource in a HTML video element, the request may
      /// contain the [Range](https://developer.mozilla.org/docs/Web/HTTP/Headers/Range)
      /// header to request only a part of the video that is streaming. In this
      /// case, your response stream should be only the portion of the video
      /// specified by the range HTTP request headers and you should set the
      /// appropriate
      /// [Content-Range](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Range)
      /// header in the response.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponse#get_content">See the ICoreWebView2WebResourceResponse article.</see></para>
      /// </remarks>
      property Content      : IStream                           read GetContent       write SetContent;
      /// <summary>
      /// Overridden HTTP response headers.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponse#get_headers">See the ICoreWebView2WebResourceResponse article.</see></para>
      /// </remarks>
      property Headers      : ICoreWebView2HttpResponseHeaders  read GetHeaders;
  end;

implementation

constructor TCoreWebView2WebResourceResponse.Create(const aBaseIntf: ICoreWebView2WebResourceResponse);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2WebResourceResponse.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceResponse.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebResourceResponse.GetContent : IStream;
var
  TempResult : IStream;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Content(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2WebResourceResponse.GetHeaders : ICoreWebView2HttpResponseHeaders;
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

function TCoreWebView2WebResourceResponse.GetStatusCode : integer;
var
  TempResult : SYSINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_StatusCode(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2WebResourceResponse.GetReasonPhrase : wvstring;
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

procedure TCoreWebView2WebResourceResponse.SetContent(const aContent: IStream);
begin
  if Initialized then
    FBaseIntf.Set_Content(aContent);
end;

procedure TCoreWebView2WebResourceResponse.SetStatusCode(aStatusCode: integer);
begin
  if Initialized then
    FBaseIntf.Set_StatusCode(aStatusCode);
end;

procedure TCoreWebView2WebResourceResponse.SetReasonPhrase(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_ReasonPhrase(PWideChar(aValue));
end;

end.

