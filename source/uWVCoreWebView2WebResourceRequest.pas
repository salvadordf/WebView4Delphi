unit uWVCoreWebView2WebResourceRequest;

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
  /// An HTTP request used with the WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequest">See the ICoreWebView2WebResourceRequest article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceRequestRef = class
    protected
      FBaseIntf : ICoreWebView2WebResourceRequest;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetMethod : wvstring;
      function  GetContent : IStream;
      function  GetHeaders : ICoreWebView2HttpRequestHeaders;

      procedure SetURI(const aValue : wvstring);
      procedure SetMethod(const aValue : wvstring);
      procedure SetContent(const aContent : IStream);

    public
      constructor Create(const aBaseIntf : ICoreWebView2WebResourceRequest); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                          read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2WebResourceRequest  read FBaseIntf;
      /// <summary>
      /// The request URI.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequest#get_uri">See the ICoreWebView2WebResourceRequest article.</see></para>
      /// </remarks>
      property URI         : wvstring                         read GetURI           write SetURI;
      /// <summary>
      /// The HTTP request method.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequest#get_method">See the ICoreWebView2WebResourceRequest article.</see></para>
      /// </remarks>
      property Method      : wvstring                         read GetMethod        write SetMethod;
      /// <summary>
      /// The HTTP request message body as stream.  POST data should be here.  If a
      /// stream is set, which overrides the message body, the stream must have
      /// all the content data available by the time the `WebResourceRequested`
      /// event deferral of this response is completed.  Stream should be agile or
      /// be created from a background STA to prevent performance impact to the UI
      /// thread.  `Null` means no content data.  `IStream` semantics apply
      /// (return `S_OK` to `Read` runs until all data is exhausted).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequest#get_content">See the ICoreWebView2WebResourceRequest article.</see></para>
      /// </remarks>
      property Content     : IStream                          read GetContent       write SetContent;
      /// <summary>
      /// The mutable HTTP request headers.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequest#get_headers">See the ICoreWebView2WebResourceRequest article.</see></para>
      /// </remarks>
      property Headers     : ICoreWebView2HttpRequestHeaders  read GetHeaders;
  end;

  /// <summary>
  /// An HTTP request used with the WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequest">See the ICoreWebView2WebResourceRequest article.</see></para>
  /// </remarks>
  TCoreWebView2WebResourceRequestOwn = class(TInterfacedObject, ICoreWebView2WebResourceRequest)
    protected
      FURI      : wvstring;
      FMethod   : wvstring;
      FContent  : IStream;
      FHeaders  : ICoreWebView2HttpRequestHeaders;

      function Get_uri(out uri: PWideChar): HResult; stdcall;
      function Set_uri(uri: PWideChar): HResult; stdcall;
      function Get_Method(out Method: PWideChar): HResult; stdcall;
      function Set_Method(Method: PWideChar): HResult; stdcall;
      function Get_Content(out Content: IStream): HResult; stdcall;
      function Set_Content(const Content: IStream): HResult; stdcall;
      function Get_Headers(out Headers: ICoreWebView2HttpRequestHeaders): HResult; stdcall;

    public
      constructor Create(const aURI, aMethod : wvstring; const aContent : IStream; const aHeaders : ICoreWebView2HttpRequestHeaders); reintroduce;
      destructor  Destroy; override;
  end;

implementation

uses
  uWVMiscFunctions;

constructor TCoreWebView2WebResourceRequestRef.Create(const aBaseIntf: ICoreWebView2WebResourceRequest);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2WebResourceRequestRef.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceRequestRef.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebResourceRequestRef.GetURI : wvstring;
var
  TempString : PWideChar;
begin
  Result    := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebResourceRequestRef.GetMethod : wvstring;
var
  TempString : PWideChar;
begin
  Result    := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Method(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebResourceRequestRef.GetContent : IStream;
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

function TCoreWebView2WebResourceRequestRef.GetHeaders : ICoreWebView2HttpRequestHeaders;
var
  TempResult : ICoreWebView2HttpRequestHeaders;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Headers(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

procedure TCoreWebView2WebResourceRequestRef.SetURI(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_Uri(PWideChar(aValue));
end;

procedure TCoreWebView2WebResourceRequestRef.SetMethod(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_Method(PWideChar(aValue));
end;

procedure TCoreWebView2WebResourceRequestRef.SetContent(const aContent : IStream);
begin
  if Initialized then
    FBaseIntf.Set_Content(aContent);
end;



// TCoreWebView2WebResourceRequestOwn

constructor TCoreWebView2WebResourceRequestOwn.Create(const aURI, aMethod : wvstring; const aContent : IStream; const aHeaders : ICoreWebView2HttpRequestHeaders);
begin
  inherited Create;

  FURI      := aURI;
  FMethod   := aMethod;
  FContent  := aContent;
  FHeaders  := aHeaders;
end;

destructor TCoreWebView2WebResourceRequestOwn.Destroy;
begin
  FContent  := nil;
  FHeaders  := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceRequestOwn.Get_uri(out uri: PWideChar): HResult; stdcall;
begin
  Result := S_OK;
  uri    := AllocCoTaskMemStr(FURI);
end;

function TCoreWebView2WebResourceRequestOwn.Set_uri(uri: PWideChar): HResult; stdcall;
begin
  Result := S_OK;

  if (uri <> nil) then
    begin
      FURI := uri;
      CoTaskMemFree(uri);
    end
   else
    FURI := '';
end;

function TCoreWebView2WebResourceRequestOwn.Get_Method(out Method: PWideChar): HResult; stdcall;
begin
  Result := S_OK;
  Method := AllocCoTaskMemStr(FMethod);
end;

function TCoreWebView2WebResourceRequestOwn.Set_Method(Method: PWideChar): HResult; stdcall;
begin
  Result := S_OK;

  if (Method <> nil) then
    begin
      FMethod := Method;
      CoTaskMemFree(Method);
    end
   else
    FMethod := '';
end;

function TCoreWebView2WebResourceRequestOwn.Get_Content(out Content: IStream): HResult; stdcall;
begin
  Result  := S_OK;
  Content := FContent;
end;

function TCoreWebView2WebResourceRequestOwn.Set_Content(const Content: IStream): HResult; stdcall;
begin
  Result := S_OK;

  if (Content <> nil) then
    FContent := Content
   else
    FContent := nil;
end;

function TCoreWebView2WebResourceRequestOwn.Get_Headers(out Headers: ICoreWebView2HttpRequestHeaders): HResult; stdcall;
begin
  Result  := S_OK;
  Headers := FHeaders;
end;

end.
