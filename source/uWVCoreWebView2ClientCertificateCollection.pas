unit uWVCoreWebView2ClientCertificateCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  TCoreWebView2ClientCertificateCollection = class
    protected
      FBaseIntf : ICoreWebView2ClientCertificateCollection;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2ClientCertificate;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ClientCertificateCollection); reintroduce;
      destructor  Destroy; override;

      property Initialized           : boolean                                      read GetInitialized;
      property BaseIntf              : ICoreWebView2ClientCertificateCollection     read FBaseIntf;
      property Count                 : cardinal                                     read GetCount;
      property Items[idx : cardinal] : ICoreWebView2ClientCertificate               read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ClientCertificateCollection.Create(const aBaseIntf: ICoreWebView2ClientCertificateCollection);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ClientCertificateCollection.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ClientCertificateCollection.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ClientCertificateCollection.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ClientCertificateCollection.GetValueAtIndex(index : cardinal) : ICoreWebView2ClientCertificate;
var
  TempResult : ICoreWebView2ClientCertificate;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

end.
