unit uWVCoreWebView2CookieManager;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Creates, adds or updates, gets, or or view the cookies. The changes would
  /// apply to the context of the user profile. That is, other WebViews under the
  /// same user profile could be affected.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager">See the ICoreWebView2CookieManager article.</see></para>
  /// </remarks>
  TCoreWebView2CookieManager = class
    protected
      FBaseIntf : ICoreWebView2CookieManager;

      function GetInitialized : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2CookieManager); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Create a cookie object with a specified name, value, domain, and path.
      /// One can set other optional properties after cookie creation.
      /// This only creates a cookie object and it is not added to the cookie
      /// manager until you call AddOrUpdateCookie.
      /// Leading or trailing whitespace(s), empty string, and special characters
      /// are not allowed for name.
      /// See ICoreWebView2Cookie for more details.
      /// </summary>
      function    CreateCookie(const aName, aValue, aDomain, aPath: wvstring) : ICoreWebView2Cookie;
      /// <summary>
      /// Creates a cookie whose params matches those of the specified cookie.
      /// </summary>
      function    CopyCookie(const aCookie : ICoreWebView2Cookie) : ICoreWebView2Cookie;
      /// <summary>
      /// Gets a list of cookies matching the specific URI.
      /// If uri is empty string or null, all cookies under the same profile are
      /// returned.
      /// You can modify the cookie objects by calling
      /// ICoreWebView2CookieManager::AddOrUpdateCookie, and the changes
      /// will be applied to the webview.
      /// </summary>
      function    GetCookies(const aURI : wvstring; const aHandler: ICoreWebView2GetCookiesCompletedHandler):  boolean;
      /// <summary>
      /// Adds or updates a cookie with the given cookie data; may overwrite
      /// cookies with matching name, domain, and path if they exist.
      /// This method will fail if the domain of the given cookie is not specified.
      /// </summary>
      function    AddOrUpdateCookie(const aCookie : ICoreWebView2Cookie): boolean;
      /// <summary>
      /// Deletes a cookie whose name and domain/path pair
      /// match those of the specified cookie.
      /// </summary>
      function    DeleteCookie(const aCookie : ICoreWebView2Cookie): boolean;
      /// <summary>
      /// Deletes cookies with matching name and uri.
      /// Cookie name is required.
      /// All cookies with the given name where domain
      /// and path match provided URI are deleted.
      /// </summary>
      function    DeleteCookies(const aName, aURI : wvstring): boolean;
      /// <summary>
      /// Deletes cookies with matching name and domain/path pair.
      /// Cookie name is required.
      /// If domain is specified, deletes only cookies with the exact domain.
      /// If path is specified, deletes only cookies with the exact path.
      /// </summary>
      function    DeleteCookiesWithDomainAndPath(const aName, aDomain, aPath : wvstring): boolean;
      /// <summary>
      /// Deletes all cookies under the same profile.
      /// This could affect other WebViews under the same user profile.
      /// </summary>
      function    DeleteAllCookies : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
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

