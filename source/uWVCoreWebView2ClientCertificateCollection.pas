unit uWVCoreWebView2ClientCertificateCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// A collection of ICoreWebView2ClientCertificate.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificatecollection">See the ICoreWebView2ClientCertificateCollection article.</see></para>
  /// </remarks>
  TCoreWebView2ClientCertificateCollection = class
    protected
      FBaseIntf : ICoreWebView2ClientCertificateCollection;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2ClientCertificate;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ClientCertificateCollection); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2ClientCertificateCollection     read FBaseIntf;
      /// <summary>
      /// The number of elements contained in the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificatecollection#get_count">See the ICoreWebView2ClientCertificateCollection article.</see></para>
      /// </remarks>
      property Count                 : cardinal                                     read GetCount;
      /// <summary>
      /// Gets the element at the given index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificatecollection#getvalueatindex">See the ICoreWebView2ClientCertificateCollection article.</see></para>
      /// </remarks>
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
