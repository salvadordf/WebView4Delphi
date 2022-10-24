unit uWVCoreWebView2CookieManager;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2CookieManager = class
    protected
      FBaseIntf : ICoreWebView2CookieManager;

      function GetInitialized : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2CookieManager); reintroduce;
      destructor  Destroy; override;
      function    CreateCookie(const aName, aValue, aDomain, aPath: wvstring) : ICoreWebView2Cookie;
      function    CopyCookie(const aCookie : ICoreWebView2Cookie) : ICoreWebView2Cookie;
      function    GetCookies(const aURI : wvstring; const aHandler: ICoreWebView2GetCookiesCompletedHandler):  boolean;
      function    AddOrUpdateCookie(const aCookie : ICoreWebView2Cookie): boolean;
      function    DeleteCookie(const aCookie : ICoreWebView2Cookie): boolean;
      function    DeleteCookies(const aName, aURI : wvstring): boolean;
      function    DeleteCookiesWithDomainAndPath(const aName, aDomain, aPath : wvstring): boolean;
      function    DeleteAllCookies : boolean;

      property Initialized : boolean                     read GetInitialized;
      property BaseIntf    : ICoreWebView2CookieManager  read FBaseIntf;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2CookieManager.Create(const aBaseIntf: ICoreWebView2CookieManager);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2CookieManager.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2CookieManager.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2CookieManager.CreateCookie(const aName, aValue, aDomain, aPath: wvstring) : ICoreWebView2Cookie;
var
  TempResult : ICoreWebView2Cookie;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.CreateCookie(PWideChar(aName), PWideChar(aValue), PWideChar(aDomain), PWideChar(aPath), TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2CookieManager.CopyCookie(const aCookie : ICoreWebView2Cookie) : ICoreWebView2Cookie;
var
  TempResult : ICoreWebView2Cookie;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.CopyCookie(aCookie, TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2CookieManager.GetCookies(const aURI : wvstring; const aHandler: ICoreWebView2GetCookiesCompletedHandler) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.GetCookies(PWideChar(aURI), aHandler));
end;

function TCoreWebView2CookieManager.AddOrUpdateCookie(const aCookie : ICoreWebView2Cookie): boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.AddOrUpdateCookie(aCookie));
end;

function TCoreWebView2CookieManager.DeleteCookie(const aCookie : ICoreWebView2Cookie): boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.DeleteCookie(aCookie));
end;

function TCoreWebView2CookieManager.DeleteCookies(const aName, aURI : wvstring): boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.DeleteCookies(PWideChar(aName), PWideChar(aURI)));
end;

function TCoreWebView2CookieManager.DeleteCookiesWithDomainAndPath(const aName, aDomain, aPath : wvstring): boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.DeleteCookiesWithDomainAndPath(PWideChar(aName), PWideChar(aDomain), PWideChar(aPath)));
end;

function TCoreWebView2CookieManager.DeleteAllCookies : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.DeleteAllCookies);
end;

end.

