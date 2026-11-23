unit uWVCoreWebView2ServiceWorkerRegistration;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, Winapi.ActiveX,
  {$ELSE}
  Classes, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// This class represents a service worker registration in WebView2 and provides methods
  /// and properties for interacting with it, such as getting the scope uri, active service worker,
  /// listening for service worker activation, unregistering events etc.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2serviceworkerregistration">See the ICoreWebView2ServiceWorkerRegistration article.</see></para>
  /// </remarks>
  TCoreWebView2ServiceWorkerRegistration = class
    protected
      FBaseIntf                    : ICoreWebView2ServiceWorkerRegistration;
      FServiceWorkerActivatedToken : EventRegistrationToken;
      FUnregisteringToken          : EventRegistrationToken;

      function GetInitialized : boolean;
      function GetActiveServiceWorker : ICoreWebView2ServiceWorker;
      function GetOrigin : wvstring;
      function GetScopeUri : wvstring;
      function GetTopLevelOrigin : wvstring;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function AddServiceWorkerActivatedEvent(const aBrowserComponent : TComponent) : boolean;
      function AddUnregisteringEvent(const aBrowserComponent : TComponent) : boolean;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2ServiceWorkerRegistration wrapper.
      /// </summary>
      /// <param name="aBaseIntf">The ICoreWebView2ServiceWorkerRegistration instance.</param>
      constructor Create(const aBaseIntf : ICoreWebView2ServiceWorkerRegistration); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized         : boolean                                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf            : ICoreWebView2ServiceWorkerRegistration      read FBaseIntf;
      /// <summary>
      /// <para>The active service worker that was created. If there is no active service worker,
      /// it returns a null pointer.</para>
      /// <para>The active service worker is the service worker that controls the pages within
      /// the scope of the registration. See the [Service Worker]
      /// (https://developer.mozilla.org/docs/Web/API/ServiceWorker) for more information.</para>
      ///
      /// <para>This corresponds to the 'active' property of the 'ServiceWorkerRegistration' object in the DOM.
      /// For more information, see the [MDN documentation]
      /// (https://developer.mozilla.org/docs/Web/API/ServiceWorkerRegistration/active).</para>
      /// </summary>
      property ActiveServiceWorker : ICoreWebView2ServiceWorker                  read GetActiveServiceWorker;
      /// <summary>
      /// <para>A string representing the URI of the origin where the worker is executing.</para>
      ///
      /// <para>If a worker created with 'ScriptUri' set to https://example.com/worker.js, the origin
      /// will be https://example.com/.</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how normalization is performed.</para>
      /// </summary>
      property Origin              : wvstring                                    read GetOrigin;
      /// <summary>
      /// <para>The 'scopeUri' is a fully qualified URI, including the scheme, host and path,
      /// that specifies the range of URLs a service worker can control.</para>
      ///
      /// <para>When registering a service worker, if no scope is specified, it defaults to the
      /// directory where the service worker script resides. For example, if the script is
      /// located at https://example.com/app/sw.js, the default 'scopeUri' would be
      /// https://example.com/app/. However, if a scope is provided, it is defined relative
      /// to the application's base URI. For instance, if an application at
      /// https://example.com/ registers a service worker with a scope of /app/, the resulting
      /// 'scopeUri' is https://example.com/app/.</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how normalization is performed.</para>
      /// <para>The same process applies to the 'Scope' when a service worker is registered from DOM API.</para>
      /// <para>The 'scopeUri' property reflects this normalization, ensuring that the URI is standardized. For example,
      /// 'HTTPS://EXAMPLE.COM/app/' is canonicalized to 'https://example.com/app/';
      /// 'https://bücher.de/' is canonicalized to 'https://xn--bcher-kva.de/'.</para>
      ///
      /// <para>The 'scope' property of the 'ServiceWorkerRegistration' object in the DOM returns
      /// the relative URL based on the application's base URI, while this property always
      /// returns a fully qualified URI.  For more information on DOM API, see the
      /// [MDN documentation](https://developer.mozilla.org/docs/Web/API/ServiceWorkerRegistration/scope).</para>
      /// </summary>
      property ScopeUri            : wvstring                                    read GetScopeUri;
      /// <summary>
      /// <para>A string representing the URI of the top-level document that the worker is associated with.</para>
      ///
      /// <para>If a worker is created with 'ScriptUri' set to https://example.com/worker.js, the top-level origin
      /// is https://example.com/. If the same worker is created from a iframe at https://example.com/ which is hosted on
      /// https://example2.com/, the top-level origin is https://example2.com/.</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how normalization is performed.</para>
      ///
      /// <para>When CustomDataPartitionId is set, the 'TopLevelOrigin' will be a generated
      /// site like guid.invalid. For example, if the top-level document is https://example.com/worker.js,
      /// the top-level origin will be 'https://guid.invalid/'.</para>
      ///
      /// <para>For more details see 'ICoreWebView2Experimental20::CustomDataPartitionId'.</para>
      /// </summary>
      property TopLevelOrigin      : wvstring                                    read GetTopLevelOrigin;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates, uWVConstants;

constructor TCoreWebView2ServiceWorkerRegistration.Create(const aBaseIntf: ICoreWebView2ServiceWorkerRegistration);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ServiceWorkerRegistration.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2ServiceWorkerRegistration.InitializeFields;
begin
  FBaseIntf := nil;

  InitializeTokens;
end;

procedure TCoreWebView2ServiceWorkerRegistration.InitializeTokens;
begin
  FServiceWorkerActivatedToken.value := 0;
  FUnregisteringToken.value          := 0;
end;

procedure TCoreWebView2ServiceWorkerRegistration.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FServiceWorkerActivatedToken.value <> 0) then
        FBaseIntf.remove_ServiceWorkerActivated(FServiceWorkerActivatedToken);

      if (FUnregisteringToken.value <> 0) then
        FBaseIntf.remove_Unregistering(FUnregisteringToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2ServiceWorkerRegistration.AddServiceWorkerActivatedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ServiceWorkerActivatedEventHandler;
begin
  Result := False;

  if Initialized and (FServiceWorkerActivatedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ServiceWorkerActivatedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ServiceWorkerActivated(TempHandler, FServiceWorkerActivatedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2ServiceWorkerRegistration.AddUnregisteringEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ServiceWorkerRegistrationUnregisteringEventHandler;
begin
  Result := False;

  if Initialized and (FUnregisteringToken.value = 0) then
    try
      TempHandler := TCoreWebView2ServiceWorkerRegistrationUnregisteringEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_Unregistering(TempHandler, FUnregisteringToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2ServiceWorkerRegistration.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddServiceWorkerActivatedEvent(aBrowserComponent) and
            AddUnregisteringEvent(aBrowserComponent);
end;

function TCoreWebView2ServiceWorkerRegistration.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ServiceWorkerRegistration.GetActiveServiceWorker: ICoreWebView2ServiceWorker;
var
  TempResult : ICoreWebView2ServiceWorker;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ActiveServiceWorker(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ServiceWorkerRegistration.GetOrigin : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_origin(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ServiceWorkerRegistration.GetScopeUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ScopeUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ServiceWorkerRegistration.GetTopLevelOrigin : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_TopLevelOrigin(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
