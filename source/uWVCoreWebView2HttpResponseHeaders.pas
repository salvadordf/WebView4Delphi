unit uWVCoreWebView2HttpResponseHeaders;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2HttpResponseHeaders = class
    protected
      FBaseIntf : ICoreWebView2HttpResponseHeaders;

      function  GetInitialized : boolean;
      function  GetIterator : ICoreWebView2HttpHeadersCollectionIterator;

    public
      constructor Create(const aBaseIntf : ICoreWebView2HttpResponseHeaders); reintroduce;
      destructor  Destroy; override;
      function    GetHeader(const aName: wvstring) : wvstring;
      function    GetHeaders(const aName: wvstring; var aIterator: ICoreWebView2HttpHeadersCollectionIterator): boolean;
      function    Contains(const aName: wvstring) : boolean;
      function    AppendHeader(const aName, aValue : wvstring) : boolean;

      property Initialized : boolean                                    read GetInitialized;
      property BaseIntf    : ICoreWebView2HttpResponseHeaders           read FBaseIntf;
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
