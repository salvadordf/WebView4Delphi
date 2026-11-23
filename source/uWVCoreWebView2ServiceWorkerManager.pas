unit uWVCoreWebView2ServiceWorkerManager;

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
  /// This class manages registrations for service workers in WebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2serviceworkermanager">See the ICoreWebView2ServiceWorkerManager article.</see></para>
  /// </remarks>
  TCoreWebView2ServiceWorkerManager = class
    protected
      FBaseIntf                       : ICoreWebView2ServiceWorkerManager;
      FServiceWorkerRegisteredToken   : EventRegistrationToken;

      function GetInitialized : boolean;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;
      function  AddServiceWorkerRegisteredEvent(const aBrowserComponent : TComponent) : boolean;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2ServiceWorkerManager wrapper.
      /// </summary>
      /// <param name="aBaseIntf">The ICoreWebView2ServiceWorkerManager instance.</param>
      constructor Create(const aBaseIntf : ICoreWebView2ServiceWorkerManager); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// <para>Gets a list of the service worker registrations under the same profile.</para>
      ///
      /// <para>This method returns a list of 'CoreWebView2ServiceWorkerRegistration' objects,
      /// each representing a service worker registration.</para>
      ///
      /// <para>This method corresponds to the 'getRegistrations' method of the 'ServiceWorkerContainer'
      /// object in the DOM which returns a Promise that resolves to an array of
      /// 'ServiceWorkerRegistration' objects. See the [MDN documentation]
      /// (https://developer.mozilla.org/docs/Web/API/ServiceWorkerContainer/getRegistrations) for more information.</para>
      /// </summary>
      function    GetServiceWorkerRegistrations(const aBrowserComponent : TComponent): boolean;
      /// <summary>
      /// <para>Gets the service worker registrations associated with the specified scope.
      /// If a service worker has been registered for the given scope, it gets the
      /// list of 'CoreWebView2ServiceWorkerRegistration' objects otherwise returns
      /// empty list.</para>
      ///
      /// <para>If the service worker is registered with a 'scope' of '/app/' for an application
      /// at https://example.com/, you should specify the full qualified URI i.e.,
      /// https://example.com/app/ when calling this method. If the scope was not explicitly
      /// specified during registration, you should use the directory where the service worker
      /// script resides, for example, https://example.com/app/.</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how provided 'scriptUri' normalization is performed. For example, 'HTTPS://münchen.de/'
      /// will be normalized to 'https://www.xn--kfk.com' for comparison.</para>
      ///
      /// <para>This corresponds to the 'getRegistration' method of the 'ServiceWorkerContainer'
      /// object in the DOM which returns a Promise that resolves to a 'ServiceWorkerRegistration'
      /// object. See the [MDN documentation]
      /// (https://developer.mozilla.org/docs/Web/API/ServiceWorkerContainer/getRegistration) for more information.</para>
      ///
      /// <para>If scopeUri is empty string or null or invalid, the completed handler immediately returns
      /// 'E_INVALIDARG' and with a null pointer.</para>
      /// </summary>
      function    GetServiceWorkerRegistrationsForScope(const aBrowserComponent : TComponent; const ScopeUri : wvstring): boolean;
      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized         : boolean                                read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf            : ICoreWebView2ServiceWorkerManager      read FBaseIntf;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates, uWVConstants;

constructor TCoreWebView2ServiceWorkerManager.Create(const aBaseIntf: ICoreWebView2ServiceWorkerManager);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ServiceWorkerManager.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2ServiceWorkerManager.InitializeFields;
begin
  FBaseIntf := nil;

  InitializeTokens;
end;

procedure TCoreWebView2ServiceWorkerManager.InitializeTokens;
begin
  FServiceWorkerRegisteredToken.value := 0;
end;

procedure TCoreWebView2ServiceWorkerManager.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FServiceWorkerRegisteredToken.value <> 0) then
        FBaseIntf.remove_ServiceWorkerRegistered(FServiceWorkerRegisteredToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2ServiceWorkerManager.AddServiceWorkerRegisteredEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ServiceWorkerRegisteredEventHandler;
begin
  Result := False;

  if Initialized and (FServiceWorkerRegisteredToken.value = 0) then
    try
      TempHandler := TCoreWebView2ServiceWorkerRegisteredEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ServiceWorkerRegistered(TempHandler, FServiceWorkerRegisteredToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2ServiceWorkerManager.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddServiceWorkerRegisteredEvent(aBrowserComponent);
end;

function TCoreWebView2ServiceWorkerManager.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ServiceWorkerManager.GetServiceWorkerRegistrations(const aBrowserComponent : TComponent): boolean;
var
  TempHandler : ICoreWebView2GetServiceWorkerRegistrationsCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2GetServiceWorkerRegistrationsCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.GetServiceWorkerRegistrations(TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2ServiceWorkerManager.GetServiceWorkerRegistrationsForScope(const aBrowserComponent : TComponent; const ScopeUri : wvstring): boolean;
var
  TempHandler : ICoreWebView2GetServiceWorkerRegistrationsCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2GetServiceWorkerRegistrationsCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.GetServiceWorkerRegistrationsForScope(PWideChar(ScopeUri), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

end.
