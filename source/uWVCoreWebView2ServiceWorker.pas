unit uWVCoreWebView2ServiceWorker;

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
  /// This class represents a service worker in WebView2 and provides methods and properties
  /// for interacting with it, such as getting the script uri, posting messages to it etc.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2serviceworker">See the ICoreWebView2ServiceWorker article.</see></para>
  /// </remarks>
  TCoreWebView2ServiceWorker = class
    protected
      FBaseIntf                                : ICoreWebView2ServiceWorker;
      FWorkerID                                : cardinal;
      FDestroyingToken                         : EventRegistrationToken;
      FWebMessageReceivedToken                 : EventRegistrationToken;

      function GetInitialized : boolean;
      function GetScriptUri : wvstring;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddServiceWorkerDestroyingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2ServiceWorker wrapper.
      /// </summary>
      /// <param name="aBaseIntf">The ICoreWebView2ServiceWorker instance.</param>
      constructor Create(const aBaseIntf : ICoreWebView2ServiceWorker); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// <para>Posts the specified webMessageAsJson to this worker.</para>
      /// <para>The worker receives the message by subscribing to the 'message' event of the
      /// 'self.chrome.webview' of the worker.</para>
      /// <code>
      /// self.chrome.webview.addEventListener('message', handler)
      /// self.chrome.webview.removeEventListener('message', handler)
      /// </code>
      /// <para>The event args is an instance of 'MessageEvent'. Both the
      /// 'ICoreWebView2Profile.AreWebViewScriptApisEnabledForServiceWorkers' and
      /// 'ICoreWebView2Settings.IsWebMessageEnabled' settings must be 'TRUE' or
      /// the web message will not be sent. The 'data' property of the event arg
      /// is the 'webMessageAsJson' string parameter parsed as a JSON string into a
      /// JS object. The 'source' property of the event arg is the path
      /// to the worker script. The message is delivered asynchronously.</para>
      /// <para>If the worker is terminated or destroyed before the message is posted,
      /// the message is discarded.</para>
      /// <para>Worker Javascript may subscribe and unsubscribe to the event
      /// using the following code:</para>
      /// <code>
      /// self.chrome.webview.addEventListener('message', handler)
      /// self.chrome.webview.removeEventListener('message', handler)
      /// </code>
      /// <para>See also the equivalent methods: 'ICoreWebView2::PostWebMessageAsJson',
      /// 'ICoreWebView2Frame::PostWebMessageAsJson',
      /// 'ICoreWebView2DedicatedWorker::PostWebMessageAsJson'.</para>
      /// </summary>
      function    PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
      /// <summary>
      /// <para>Posts a message that is a simple string rather than a JSON string
      /// representation of a JavaScript object. This behaves exactly the same
      /// manner as 'PostWebMessageAsJson', but the 'data' property of the event
      /// arg of the 'self.chrome.webview' message is a string with the same
      /// value as 'webMessageAsString'.  Use this instead of
      /// 'PostWebMessageAsJson' if you want to communicate using simple strings
      /// rather than JSON objects. Please see 'PostWebMessageAsJson' for
      /// additional information.</para>
      /// <para>See also the equivalent methods: 'ICoreWebView2::PostWebMessageAsString'
      /// 'ICoreWebView2Frame::PostWebMessageAsString',
      /// 'ICoreWebView2DedicatedWorker::PostWebMessageAsString'.</para>
      /// </summary>
      function    PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized         : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf            : ICoreWebView2ServiceWorker      read FBaseIntf;
      /// <summary>
      /// Custom unique identifier of the current dedicated worker.
      /// </summary>
      property WorkerID            : cardinal                        read FWorkerID;
      /// <summary>
      /// <para>A string representing the Uri of the script that the worker is executing.</para>
      ///
      /// <para>The 'scriptUri' is a fully qualified URI, including the scheme, host, and path.
      /// In contrast, the 'scriptURL' property of the 'Worker' object in the DOM returns the relative
      /// URL of the script being executed by the worker. For more details on DOM API, see the
      /// [DOM API documentation](https://developer.mozilla.org/docs/Web/API/Worker/scriptURL).</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how normalization is performed.
      /// The same process applies to the 'scriptURL' when a worker is registered from DOM API.
      /// The 'scriptUri' property reflects this normalization, ensuring that the URL is standardized. For example,
      /// 'HTTPS://EXAMPLE.COM/worker.js' is canonicalized to 'https://example.com/worker.js';
      /// 'https://bücher.de/worker.js' is canonicalized to 'https://xn--bcher-kva.de/worker.js'.</para>
      /// </summary>
      property ScriptUri           : wvstring                        read GetScriptUri;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates, uWVConstants, uWVLoader;

constructor TCoreWebView2ServiceWorker.Create(const aBaseIntf: ICoreWebView2ServiceWorker);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if assigned(GlobalWebView2Loader) then
    FWorkerID := GlobalWebView2Loader.NextWorkerID;
end;

destructor TCoreWebView2ServiceWorker.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2ServiceWorker.InitializeFields;
begin
  FBaseIntf := nil;
  FWorkerID := 0;

  InitializeTokens;
end;

procedure TCoreWebView2ServiceWorker.InitializeTokens;
begin
  FDestroyingToken.value                               := 0;
  FWebMessageReceivedToken.value                       := 0;
end;

procedure TCoreWebView2ServiceWorker.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FDestroyingToken.value <> 0) then
        FBaseIntf.remove_Destroying(FDestroyingToken);

      if (FWebMessageReceivedToken.value <> 0) then
        FBaseIntf.remove_WebMessageReceived(FWebMessageReceivedToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2ServiceWorker.AddServiceWorkerDestroyingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ServiceWorkerDestroyingEventHandler;
begin
  Result := False;

  if Initialized and (FDestroyingToken.value = 0) then
    try
      TempHandler := TCoreWebView2ServiceWorkerDestroyingEventHandler.Create(TWVBrowserBase(aBrowserComponent), WorkerID);
      Result      := succeeded(FBaseIntf.add_Destroying(TempHandler, FDestroyingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2ServiceWorker.AddWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ServiceWorkerWebMessageReceivedEventHandler;
begin
  Result := False;

  if Initialized and (FWebMessageReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ServiceWorkerWebMessageReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent), WorkerID);
      Result      := succeeded(FBaseIntf.add_WebMessageReceived(TempHandler, FWebMessageReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2ServiceWorker.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddServiceWorkerDestroyingEvent(aBrowserComponent) and
            AddWebMessageReceivedEvent(aBrowserComponent);
end;

function TCoreWebView2ServiceWorker.PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.PostWebMessageAsJson(PWideChar(aWebMessageAsJson)));
end;

function TCoreWebView2ServiceWorker.PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.PostWebMessageAsString(PWideChar(aWebMessageAsString)));
end;

function TCoreWebView2ServiceWorker.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ServiceWorker.GetScriptUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ScriptUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
