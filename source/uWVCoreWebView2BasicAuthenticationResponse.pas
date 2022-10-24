unit uWVCoreWebView2BasicAuthenticationResponse;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
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

      property Initialized                         : boolean                                   read GetInitialized;
      property BaseIntf                            : ICoreWebView2BasicAuthenticationResponse  read FBaseIntf                            write FBaseIntf;
      property UserName                            : wvstring                                  read GetUserName                          write SetUserName;
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

