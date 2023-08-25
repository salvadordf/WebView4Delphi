unit uWVCoreWebView2ClientCertificate;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides access to the client certificate metadata.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate">See the ICoreWebView2ClientCertificate article.</see></para>
  /// </remarks>
  TCoreWebView2ClientCertificate = class
    protected
      FBaseIntf : ICoreWebView2ClientCertificate;

      function GetInitialized : boolean;
      function GetSubject : wvstring;
      function GetIssuer : wvstring;
      function GetValidFrom : TDateTime;
      function GetValidTo : TDateTime;
      function GetDerEncodedSerialNumber : wvstring;
      function GetDisplayName : wvstring;
      function GetPemEncodedIssuerCertificateChain : ICoreWebView2StringCollection;
      function GetKind : TWVClientCertificateKind;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ClientCertificate); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// PEM encoded data for the certificate.
      /// Returns Base64 encoding of DER encoded certificate.
      /// Read more about PEM at [RFC 1421 Privacy Enhanced Mail]
      /// (https://tools.ietf.org/html/rfc1421).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#topemencoding">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      function    ToPemEncoding : wvstring;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                         : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                            : ICoreWebView2ClientCertificate  read FBaseIntf                            write FBaseIntf;
      /// <summary>
      /// Subject of the certificate.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_subject">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property Subject                             : wvstring                        read GetSubject;
      /// <summary>
      /// Name of the certificate authority that issued the certificate.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_issuer">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property Issuer                              : wvstring                        read GetIssuer;
      /// <summary>
      /// The valid start date and time for the certificate as the number of seconds since
      /// the UNIX epoch.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_validfrom">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property ValidFrom                           : TDateTime                       read GetValidFrom;
      /// <summary>
      /// The valid expiration date and time for the certificate as the number of seconds since
      /// the UNIX epoch.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_validto">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property ValidTo                             : TDateTime                       read GetValidTo;
      /// <summary>
      /// Base64 encoding of DER encoded serial number of the certificate.
      /// Read more about DER at [RFC 7468 DER]
      /// (https://tools.ietf.org/html/rfc7468#appendix-B).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_derencodedserialnumber">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property DerEncodedSerialNumber              : wvstring                        read GetDerEncodedSerialNumber;
      /// <summary>
      /// Display name for a certificate.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_displayname">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property DisplayName                         : wvstring                        read GetDisplayName;
      /// <summary>
      /// Collection of PEM encoded client certificate issuer chain.
      /// In this collection first element is the current certificate followed by
      /// intermediate1, intermediate2...intermediateN-1. Root certificate is the
      /// last element in collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_pemencodedissuercertificatechain">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property PemEncodedIssuerCertificateChain    : ICoreWebView2StringCollection   read GetPemEncodedIssuerCertificateChain;
      /// <summary>
      /// Kind of a certificate (eg., smart card, pin, other).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate#get_kind">See the ICoreWebView2ClientCertificate article.</see></para>
      /// </remarks>
      property Kind                                : TWVClientCertificateKind        read GetKind;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.DateUtils, Winapi.ActiveX;
  {$ELSE}
  DateUtils, ActiveX;
  {$ENDIF}

constructor TCoreWebView2ClientCertificate.Create(const aBaseIntf: ICoreWebView2ClientCertificate);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ClientCertificate.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ClientCertificate.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ClientCertificate.GetSubject : wvstring;
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

function TCoreWebView2ClientCertificate.GetIssuer : wvstring;
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

function TCoreWebView2ClientCertificate.GetValidFrom : TDateTime;
var
  TempResult : double;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ValidFrom(TempResult)) then
    Result := UnixToDateTime(round(TempResult){$IFDEF DELPHI20_UP}, False{$ENDIF})
   else
    Result := 0;
end;

function TCoreWebView2ClientCertificate.GetValidTo : TDateTime;
var
  TempResult : double;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ValidFrom(TempResult)) then
    Result := UnixToDateTime(round(TempResult){$IFDEF DELPHI20_UP}, False{$ENDIF})
   else
    Result := 0;
end;

function TCoreWebView2ClientCertificate.GetDerEncodedSerialNumber : wvstring;
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

function TCoreWebView2ClientCertificate.GetDisplayName : wvstring;
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

function TCoreWebView2ClientCertificate.GetPemEncodedIssuerCertificateChain : ICoreWebView2StringCollection;
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

function TCoreWebView2ClientCertificate.GetKind : TWVClientCertificateKind;
var
  TempResult : COREWEBVIEW2_CLIENT_CERTIFICATE_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2ClientCertificate.ToPemEncoding : wvstring;
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

