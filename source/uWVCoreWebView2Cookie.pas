unit uWVCoreWebView2Cookie;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides a set of properties that are used to manage an
  /// ICoreWebView2Cookie.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie">See the ICoreWebView2Cookie article.</see></para>
  /// </remarks>
  TCoreWebView2Cookie = class
    protected
      FBaseIntf : ICoreWebView2Cookie;

      function GetInitialized : boolean;
      function GetName : wvstring;
      function GetValue : wvstring;
      function GetDomain : wvstring;
      function GetPath : wvstring;
      function GetExpires : double;
      function GetExpiresDate : TDateTime;
      function GetIsHttpOnly : boolean;
      function GetSameSite : TWVCookieSameSiteKind;
      function GetIsSecure : boolean;
      function GetIsSession : boolean;

      procedure SetValue(const aValue : wvstring);
      procedure SetExpires(const aValue : double);
      procedure SetExpiresDate(const aValue : TDateTime);
      procedure SetIsHttpOnly(aValue : boolean);
      procedure SetSameSite(aValue : TWVCookieSameSiteKind);
      procedure SetIsSecure(aValue : boolean);

    public
      constructor Create(const aBaseIntf : ICoreWebView2Cookie); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized    : boolean                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf       : ICoreWebView2Cookie         read FBaseIntf           write FBaseIntf;
      /// <summary>
      /// Cookie name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_name">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property Name           : wvstring                    read GetName;
      /// <summary>
      /// Cookie value.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_value">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property Value          : wvstring                    read GetValue            write SetValue;
      /// <summary>
      /// The domain for which the cookie is valid.
      /// The default is the host that this cookie has been received from.
      /// Note that, for instance, ".bing.com", "bing.com", and "www.bing.com" are
      /// considered different domains.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_domain">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property Domain         : wvstring                    read GetDomain;
      /// <summary>
      /// The path for which the cookie is valid. The default is "/", which means
      /// this cookie will be sent to all pages on the Domain.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_path">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property Path           : wvstring                    read GetPath;
      /// <summary>
      /// The expiration date and time for the cookie as the number of seconds since the UNIX epoch.
      /// The default is -1.0, which means cookies are session cookies by default.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_expires">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property Expires        : double                      read GetExpires          write SetExpires;
      /// <summary>
      /// The expiration date and time for the cookie in TDateTime format.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_expires">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property ExpiresDate    : TDateTime                   read GetExpiresDate      write SetExpiresDate;
      /// <summary>
      /// Whether this cookie is http-only.
      /// True if a page script or other active content cannot access this
      /// cookie. The default is false.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_ishttponly">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property IsHttpOnly     : boolean                     read GetIsHttpOnly       write SetIsHttpOnly;
      /// <summary>
      /// SameSite status of the cookie which represents the enforcement mode of the cookie.
      /// The default is COREWEBVIEW2_COOKIE_SAME_SITE_KIND_LAX.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_samesite">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property SameSite       : TWVCookieSameSiteKind       read GetSameSite         write SetSameSite;
      /// <summary>
      /// The security level of this cookie. True if the client is only to return
      /// the cookie in subsequent requests if those requests use HTTPS.
      /// The default is false.
      /// Note that cookie that requests COREWEBVIEW2_COOKIE_SAME_SITE_KIND_NONE but
      /// is not marked Secure will be rejected.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_issecure">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property IsSecure       : boolean                     read GetIsSecure         write SetIsSecure;
      /// <summary>
      /// Whether this is a session cookie. The default is false.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie#get_issession">See the ICoreWebView2Cookie article.</see></para>
      /// </remarks>
      property IsSession      : boolean                     read GetIsSession;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.DateUtils, Winapi.ActiveX;
  {$ELSE}
  DateUtils, ActiveX;
  {$ENDIF}

constructor TCoreWebView2Cookie.Create(const aBaseIntf: ICoreWebView2Cookie);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2Cookie.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2Cookie.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Cookie.GetName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Name(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Cookie.GetValue : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Value(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Cookie.GetDomain : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Domain(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Cookie.GetPath : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Path(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Cookie.GetExpires : double;
var
  TempResult : double;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Expires(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2Cookie.GetExpiresDate : TDateTime;
var
  TempExpires : double;
begin
  Result      := 0;
  TempExpires := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Expires(TempExpires)) and
     (TempExpires <> -1) then
    Result := UnixToDateTime(round(TempExpires){$IFDEF DELPHI20_UP}, False{$ENDIF})
end;

function TCoreWebView2Cookie.GetIsHttpOnly : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsHttpOnly(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Cookie.GetSameSite : TWVCookieSameSiteKind;
var
  TempResult : COREWEBVIEW2_COOKIE_SAME_SITE_KIND;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_SameSite(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2Cookie.GetIsSecure : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsSecure(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Cookie.GetIsSession : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsSession(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2Cookie.SetValue(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_Value(PWideChar(aValue));
end;

procedure TCoreWebView2Cookie.SetExpires(const aValue : double);
begin
  if Initialized then
    FBaseIntf.Set_Expires(aValue);
end;

procedure TCoreWebView2Cookie.SetExpiresDate(const aValue : TDateTime);
begin
  if Initialized then
    FBaseIntf.Set_Expires(DateTimeToUnix(aValue{$IFDEF DELPHI20_UP}, False{$ENDIF}));
end;

procedure TCoreWebView2Cookie.SetIsHttpOnly(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsHttpOnly(ord(aValue));
end;

procedure TCoreWebView2Cookie.SetSameSite(aValue : TWVCookieSameSiteKind);
begin
  if Initialized then
    FBaseIntf.Set_SameSite(aValue);
end;

procedure TCoreWebView2Cookie.SetIsSecure(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsSecure(ord(aValue));
end;

end.

