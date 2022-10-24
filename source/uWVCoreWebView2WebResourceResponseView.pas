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
      function    GetContent(const aHandler : ICoreWebView2WebResourceResponseViewGetContentCompletedHandler) : boolean;

      property Initialized  : boolean                               read GetInitialized;
      property BaseIntf     : ICoreWebView2WebResourceResponseView  read FBaseIntf;
      property StatusCode   : integer                               read GetStatusCode;
      property ReasonPhrase : wvstring                              read GetReasonPhrase;
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
