unit uWVCoreWebView2BasicAuthenticationResponse;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Represents a Basic HTTP authentication response that contains a user name
  /// and a password as according to RFC7617 (https://tools.ietf.org/html/rfc7617)
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationresponse">See the ICoreWebView2BasicAuthenticationResponse article.</see></para>
  /// </remarks>
  TCoreWebView2BasicAuthenticationResponse = class
    protected
      FBaseIntf : ICoreWebView2BasicAuthenticationResponse;

      function GetInitialized : boolean;
      function GetUserName : wvstring;
      function GetPassword : wvstring;

      procedure SetUserName(const aValue : wvstring);
      procedure SetPassword(const aValue : wvstring);

    public
      constructor Create(const aBaseIntf : ICoreWebView2BasicAuthenticationResponse); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                         : boolean                                   read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                            : ICoreWebView2BasicAuthenticationResponse  read FBaseIntf                            write FBaseIntf;
      /// <summary>
      /// User name provided for authentication.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationresponse#get_username">See the ICoreWebView2BasicAuthenticationResponse article.</see></para>
      /// </remarks>
      property UserName                            : wvstring                                  read GetUserName                          write SetUserName;
      /// <summary>
      /// Password provided for authentication.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationresponse#get_password">See the ICoreWebView2BasicAuthenticationResponse article.</see></para>
      /// </remarks>
      property Password                            : wvstring                                  read GetPassword                          write SetPassword;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2BasicAuthenticationResponse.Create(const aBaseIntf: ICoreWebView2BasicAuthenticationResponse);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2BasicAuthenticationResponse.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2BasicAuthenticationResponse.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2BasicAuthenticationResponse.GetUserName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_UserName(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2BasicAuthenticationResponse.GetPassword : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Password(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

procedure TCoreWebView2BasicAuthenticationResponse.SetUserName(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_UserName(PWideChar(aValue));
end;

procedure TCoreWebView2BasicAuthenticationResponse.SetPassword(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_Password(PWideChar(aValue));
end;

end.

