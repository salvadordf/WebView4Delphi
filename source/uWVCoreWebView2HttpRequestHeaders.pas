unit uWVCoreWebView2HttpRequestHeaders;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2HttpRequestHeaders = class
    protected
      FBaseIntf : ICoreWebView2HttpRequestHeaders;

      function  GetInitialized : boolean;
      function  GetIterator : ICoreWebView2HttpHeadersCollectionIterator;

    public
      constructor Create(const aBaseIntf : ICoreWebView2HttpRequestHeaders); reintroduce;
      destructor  Destroy; override;
      function    SetHeader(const aName, aValue : wvstring): boolean;
      function    GetHeader(const aName: wvstring) : wvstring;
      function    GetHeaders(const aName: wvstring; var aIterator: ICoreWebView2HttpHeadersCollectionIterator): boolean;
      function    Contains(const aName: wvstring) : boolean;
      function    RemoveHeader(const aName: wvstring) : boolean;

      property Initialized : boolean                                    read GetInitialized;
      property BaseIntf    : ICoreWebView2HttpRequestHeaders            read FBaseIntf;
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

function TCoreWebView2HttpRequestHeaders.GetHeaders(const aName: wvstring; var aIterator: ICoreWebView2HttpHeadersCollectionIterator): boolean;
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

function TCoreWebView2HttpRequestHeaders.Contains(const aName: wvstring) : boolean;
var
  TempContains : integer;
begin
  TempContains := 0;
  Result       := Initialized and
                  succeeded(FBaseIntf.Contains(PWideChar(aName), TempContains)) and
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
