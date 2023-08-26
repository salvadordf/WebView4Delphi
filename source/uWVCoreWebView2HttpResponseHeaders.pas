unit uWVCoreWebView2HttpResponseHeaders;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// HTTP response headers.  Used to construct a WebResourceResponse for the
  /// WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpresponseheaders">See the ICoreWebView2HttpResponseHeaders article.</see></para>
  /// </remarks>
  TCoreWebView2HttpResponseHeaders = class
    protected
      FBaseIntf : ICoreWebView2HttpResponseHeaders;

      function  GetInitialized : boolean;
      function  GetIterator : ICoreWebView2HttpHeadersCollectionIterator;

    public
      constructor Create(const aBaseIntf : ICoreWebView2HttpResponseHeaders); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Gets the first header value in the collection matching the name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpresponseheaders#getheader">See the ICoreWebView2HttpResponseHeaders article.</see></para>
      /// </remarks>
      function    GetHeader(const aName: wvstring) : wvstring;
      /// <summary>
      /// Gets the header values matching the name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpresponseheaders#getheaders">See the ICoreWebView2HttpResponseHeaders article.</see></para>
      /// </remarks>
      function    GetHeaders(const aName: wvstring; var aIterator: ICoreWebView2HttpHeadersCollectionIterator): boolean;
      /// <summary>
      /// Verifies that the headers contain entries that match the header name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpresponseheaders#contains">See the ICoreWebView2HttpResponseHeaders article.</see></para>
      /// </remarks>
      function    Contains(const aName: wvstring) : boolean;
      /// <summary>
      /// Appends header line with name and value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpresponseheaders#appendheader">See the ICoreWebView2HttpResponseHeaders article.</see></para>
      /// </remarks>
      function    AppendHeader(const aName, aValue : wvstring) : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2HttpResponseHeaders           read FBaseIntf;
      /// <summary>
      /// Gets an iterator over the collection of entire response headers.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpresponseheaders#getiterator">See the ICoreWebView2HttpResponseHeaders article.</see></para>
      /// </remarks>
      property Iterator    : ICoreWebView2HttpHeadersCollectionIterator read GetIterator;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2HttpResponseHeaders.Create(const aBaseIntf: ICoreWebView2HttpResponseHeaders);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2HttpResponseHeaders.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2HttpResponseHeaders.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2HttpResponseHeaders.GetHeader(const aName: wvstring) : wvstring;
var
  TempValue : PWideChar;
begin
  Result    := '';
  TempValue := nil;

  if Initialized and
     succeeded(FBaseIntf.GetHeader(PWideChar(aName), TempValue)) and
     (TempValue <> nil) then
    begin
      Result := TempValue;
      CoTaskMemFree(TempValue);
    end;
end;

function TCoreWebView2HttpResponseHeaders.GetHeaders(const aName: wvstring; var aIterator: ICoreWebView2HttpHeadersCollectionIterator): boolean;
var
  TempIterator : ICoreWebView2HttpHeadersCollectionIterator;
begin
  Result       := False;
  TempIterator := nil;
  aIterator    := nil;

  if Initialized and
     succeeded(FBaseIntf.GetHeaders(PWideChar(aName), TempIterator)) and
     assigned(TempIterator) then
    begin
      aIterator := TempIterator;
      Result    := True;
    end;
end;

function TCoreWebView2HttpResponseHeaders.Contains(const aName: wvstring) : boolean;
var
  TempContains : integer;
begin
  TempContains := 0;
  Result       := Initialized and
                  succeeded(FBaseIntf.Contains(PWideChar(aName), TempContains)) and
                  (TempContains <> 0);
end;

function TCoreWebView2HttpResponseHeaders.AppendHeader(const aName, aValue : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.AppendHeader(PWideChar(aName), PWideChar(aValue)));
end;

function TCoreWebView2HttpResponseHeaders.GetIterator : ICoreWebView2HttpHeadersCollectionIterator;
var
  TempIterator : ICoreWebView2HttpHeadersCollectionIterator;
begin
  Result       := nil;
  TempIterator := nil;

  if Initialized and
     succeeded(FBaseIntf.GetIterator(TempIterator)) and
     assigned(TempIterator) then
    Result := TempIterator;
end;

end.
