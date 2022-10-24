unit uWVCoreWebView2Certificate;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Certificate = class
    protected
      FBaseIntf : ICoreWebView2Certificate;

      function GetInitialized : boolean;
      function GetSubject : wvstring;
      function GetIssuer : wvstring;
      function GetValidFrom : TDateTime;
      function GetValidTo : TDateTime;
      function GetDerEncodedSerialNumber : wvstring;
      function GetDisplayName : wvstring;
      function GetPemEncodedIssuerCertificateChain : ICoreWebView2StringCollection;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Certificate); reintroduce;
      destructor  Destroy; override;
      function    ToPemEncoding : wvstring;

      property Initialized                         : boolean                         read GetInitialized;
      property BaseIntf                            : ICoreWebView2Certificate        read FBaseIntf                            write FBaseIntf;
      property Subject                             : wvstring                        read GetSubject;
      property Issuer                              : wvstring                        read GetIssuer;
      property ValidFrom                           : TDateTime                       read GetValidFrom;
      property ValidTo                             : TDateTime                       read GetValidTo;
      property DerEncodedSerialNumber              : wvstring                        read GetDerEncodedSerialNumber;
      property DisplayName                         : wvstring                        read GetDisplayName;
      property PemEncodedIssuerCertificateChain    : ICoreWebView2StringCollection   read GetPemEncodedIssuerCertificateChain;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.DateUtils, Winapi.ActiveX;
  {$ELSE}
  DateUtils, ActiveX;
  {$ENDIF}

constructor TCoreWebView2Certificate.Create(const aBaseIntf: ICoreWebView2Certificate);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2Certificate.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2Certificate.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Certificate.GetSubject : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Subject(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Certificate.GetIssuer : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Issuer(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Certificate.GetValidFrom : TDateTime;
var
  TempResult : double;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ValidFrom(TempResult)) then
    Result := UnixToDateTime(round(TempResult){$IFDEF DELPHI20_UP}, False{$ENDIF})
   else
    Result := 0;
end;

function TCoreWebView2Certificate.GetValidTo : TDateTime;
var
  TempResult : double;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ValidFrom(TempResult)) then
    Result := UnixToDateTime(round(TempResult){$IFDEF DELPHI20_UP}, False{$ENDIF})
   else
    Result := 0;
end;

function TCoreWebView2Certificate.GetDerEncodedSerialNumber : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DerEncodedSerialNumber(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Certificate.GetDisplayName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DisplayName(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Certificate.GetPemEncodedIssuerCertificateChain : ICoreWebView2StringCollection;
var
  TempResult : ICoreWebView2StringCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_PemEncodedIssuerCertificateChain(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2Certificate.ToPemEncoding : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.ToPemEncoding(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

end.

