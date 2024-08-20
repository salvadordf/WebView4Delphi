unit uWVCoreWebView2HttpRequestHeaders;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// HTTP request headers.  Used to inspect the HTTP request on
  /// WebResourceRequested event and NavigationStarting event.
  /// </summary>
  /// <remarks>
  /// <para>It is possible to modify the HTTP request from a WebResourceRequested event, but not from a NavigationStarting event.</para>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders">See the ICoreWebView2HttpRequestHeaders article.</see></para>
  /// </remarks>
  TCoreWebView2HttpRequestHeaders = class
    protected
      FBaseIntf : ICoreWebView2HttpRequestHeaders;

      function  GetInitialized : boolean;
      function  GetIterator : ICoreWebView2HttpHeadersCollectionIterator;

    public
      constructor Create(const aBaseIntf : ICoreWebView2HttpRequestHeaders); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds or updates header that matches the name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders#setheader">See the ICoreWebView2HttpRequestHeaders article.</see></para>
      /// </remarks>
      function    SetHeader(const aName, aValue : wvstring): boolean;
      /// <summary>
      /// Gets the header value matching the name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders#getheader">See the ICoreWebView2HttpRequestHeaders article.</see></para>
      /// </remarks>
      function    GetHeader(const aName: wvstring) : wvstring;
      /// <summary>
      /// Gets the header value matching the name using an iterator.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders#getheaders">See the ICoreWebView2HttpRequestHeaders article.</see></para>
      /// </remarks>
      function    GetHeaders(const aName: wvstring; var aValue: ICoreWebView2HttpHeadersCollectionIterator): boolean;
      /// <summary>
      /// Checks whether the headers contain an entry that matches the header name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders#contains">See the ICoreWebView2HttpRequestHeaders article.</see></para>
      /// </remarks>
      function    Contains(const aValue: wvstring) : boolean;
      /// <summary>
      /// Removes header that matches the name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders#removeheader">See the ICoreWebView2HttpRequestHeaders article.</see></para>
      /// </remarks>
      function    RemoveHeader(const aName: wvstring) : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2HttpRequestHeaders            read FBaseIntf;
      /// <summary>
      /// Gets an iterator over the collection of request headers.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders#getiterator">See the ICoreWebView2HttpRequestHeaders article.</see></para>
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

constructor TCoreWebView2HttpRequestHeaders.Create(const aBaseIntf: ICoreWebView2HttpRequestHeaders);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2HttpRequestHeaders.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2HttpRequestHeaders.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2HttpRequestHeaders.SetHeader(const aName, aValue : wvstring): boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.SetHeader(PWideChar(aName), PWideChar(aValue)));
end;

function TCoreWebView2HttpRequestHeaders.GetHeader(const aName: wvstring) : wvstring;
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

function TCoreWebView2HttpRequestHeaders.GetHeaders(const aName: wvstring; var aValue: ICoreWebView2HttpHeadersCollectionIterator): boolean;
var
  TempIterator : ICoreWebView2HttpHeadersCollectionIterator;
begin
  Result       := False;
  TempIterator := nil;
  aValue       := nil;

  if Initialized and
     succeeded(FBaseIntf.GetHeaders(PWideChar(aName), TempIterator)) and
     assigned(TempIterator) then
    begin
      aValue := TempIterator;
      Result := True;
    end;
end;

function TCoreWebView2HttpRequestHeaders.Contains(const aValue: wvstring) : boolean;
var
  TempContains : integer;
begin
  TempContains := 0;
  Result       := Initialized and
                  succeeded(FBaseIntf.Contains(PWideChar(aValue), TempContains)) and
                  (TempContains <> 0);
end;

function TCoreWebView2HttpRequestHeaders.RemoveHeader(const aName: wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveHeader(PWideChar(aName)));
end;

function TCoreWebView2HttpRequestHeaders.GetIterator : ICoreWebView2HttpHeadersCollectionIterator;
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
