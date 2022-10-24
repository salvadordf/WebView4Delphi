unit uWVCoreWebView2Cookie;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
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

      property Initialized    : boolean                     read GetInitialized;
      property BaseIntf       : ICoreWebView2Cookie         read FBaseIntf           write FBaseIntf;
      property Name           : wvstring                    read GetName;
      property Value          : wvstring                    read GetValue            write SetValue;
      property Domain         : wvstring                    read GetDomain;
      property Path           : wvstring                    read GetPath;
      property Expires        : double                      read GetExpires          write SetExpires;
      property ExpiresDate    : TDateTime                   read GetExpiresDate      write SetExpiresDate;
      property IsHttpOnly     : boolean                     read GetIsHttpOnly       write SetIsHttpOnly;
      property SameSite       : TWVCookieSameSiteKind       read GetSameSite         write SetSameSite;
      property IsSecure       : boolean                     read GetIsSecure         write SetIsSecure;
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

