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

      property Initialized  : boolean                           read GetInitialized;
      property BaseIntf     : ICoreWebView2WebResourceResponse  read FBaseIntf;
      property StatusCode   : integer                           read GetStatusCode    write SetStatusCode;
      property ReasonPhrase : wvstring                          read GetReasonPhrase  write SetReasonPhrase;
      property Content      : IStream                           read GetContent       write SetContent;
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

