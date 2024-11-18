unit uWVCoreWebView2;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, WinApi.Windows, Winapi.ActiveX, System.SysUtils, System.Types,
  {$ELSE}
  Classes, Windows, ActiveX, SysUtils, Types,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2 = class
    protected
      FBaseIntf                                : ICoreWebView2;
      FBaseIntf2                               : ICoreWebView2_2;
      FBaseIntf3                               : ICoreWebView2_3;
      FBaseIntf4                               : ICoreWebView2_4;
      FBaseIntf5                               : ICoreWebView2_5;
      FBaseIntf6                               : ICoreWebView2_6;
      FBaseIntf7                               : ICoreWebView2_7;
      FBaseIntf8                               : ICoreWebView2_8;
      FBaseIntf9                               : ICoreWebView2_9;
      FBaseIntf10                              : ICoreWebView2_10;
      FBaseIntf11                              : ICoreWebView2_11;
      FBaseIntf12                              : ICoreWebView2_12;
      FBaseIntf13                              : ICoreWebView2_13;
      FBaseIntf14                              : ICoreWebView2_14;
      FBaseIntf15                              : ICoreWebView2_15;
      FBaseIntf16                              : ICoreWebView2_16;
      FBaseIntf17                              : ICoreWebView2_17;
      FBaseIntf18                              : ICoreWebView2_18;
      FBaseIntf19                              : ICoreWebView2_19;
      FBaseIntf20                              : ICoreWebView2_20;
      FBaseIntf21                              : ICoreWebView2_21;
      FBaseIntf22                              : ICoreWebView2_22;
      FBaseIntf23                              : ICoreWebView2_23;
      FBaseIntf24                              : ICoreWebView2_24;
      FBaseIntf25                              : ICoreWebView2_25;
      FBaseIntf26                              : ICoreWebView2_26;
      FBaseIntf27                              : ICoreWebView2_27;
      FContainsFullScreenElementChangedToken   : EventRegistrationToken;
      FContentLoadingToken                     : EventRegistrationToken;
      FDocumentTitleChangedToken               : EventRegistrationToken;
      FFrameNavigationStartingToken            : EventRegistrationToken;
      FFrameNavigationCompletedToken           : EventRegistrationToken;
      FHistoryChangedToken                     : EventRegistrationToken;
      FNavigationStartingToken                 : EventRegistrationToken;
      FNavigationCompletedToken                : EventRegistrationToken;
      FNewWindowRequestedToken                 : EventRegistrationToken;
      FPermissionRequestedToken                : EventRegistrationToken;
      FProcessFailedToken                      : EventRegistrationToken;
      FScriptDialogOpeningToken                : EventRegistrationToken;
      FSourceChangedToken                      : EventRegistrationToken;
      FWebResourceRequestedToken               : EventRegistrationToken;
      FWebMessageReceivedToken                 : EventRegistrationToken;
      FWindowCloseRequestedToken               : EventRegistrationToken;
      FWebResourceResponseReceivedToken        : EventRegistrationToken;
      FDOMContentLoadedToken                   : EventRegistrationToken;
      FFrameCreatedToken                       : EventRegistrationToken;
      FDownloadStartingToken                   : EventRegistrationToken;
      FClientCertificateRequestedToken         : EventRegistrationToken;
      FIsMutedChangedToken                     : EventRegistrationToken;
      FIsDocumentPlayingAudioChangedToken      : EventRegistrationToken;
      FIsDefaultDownloadDialogOpenChangedToken : EventRegistrationToken;
      FBasicAuthenticationRequestedToken       : EventRegistrationToken;
      FContextMenuRequestedToken               : EventRegistrationToken;
      FStatusBarTextChangedToken               : EventRegistrationToken;
      FServerCertificateErrorDetectedToken     : EventRegistrationToken;
      FFaviconChangedToken                     : EventRegistrationToken;
      FLaunchingExternalUriSchemeToken         : EventRegistrationToken;
      FNotificationReceivedToken               : EventRegistrationToken;
      FSaveAsUIShowingToken                    : EventRegistrationToken;
      FSaveFileSecurityCheckStartingToken      : EventRegistrationToken;
      FScreenCaptureStartingToken              : EventRegistrationToken;
      FFrameIDCopy                             : cardinal;
      FDevToolsEventNames                      : TStringList;
      FDevToolsEventTokens                     : array of EventRegistrationToken;

      function  GetInitialized : boolean;
      function  GetBrowserProcessID : cardinal;
      function  GetCanGoBack : boolean;
      function  GetCanGoForward : boolean;
      function  GetContainsFullScreenElement : boolean;
      function  GetDocumentTitle : wvstring;
      function  GetSource : wvstring;
      function  GetCookieManager : ICoreWebView2CookieManager;
      function  GetEnvironment : ICoreWebView2Environment;
      function  GetIsSuspended : boolean;
      function  GetSettings : ICoreWebView2Settings;
      function  GetIsMuted : boolean;
      function  GetIsDocumentPlayingAudio : boolean;
      function  GetIsDefaultDownloadDialogOpen : boolean;
      function  GetDefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment;
      function  GetDefaultDownloadDialogMargin : TPoint;
      function  GetStatusBarText : wvstring;
      function  GetProfile : ICoreWebView2Profile;
      function  GetFaviconURI : wvstring;
      function  GetMemoryUsageTargetLevel : TWVMemoryUsageTargetLevel;
      function  GetFrameID : cardinal;

      procedure SetIsMuted(aValue : boolean);
      procedure SetDefaultDownloadDialogCornerAlignment(aValue : TWVDefaultDownloadDialogCornerAlignment);
      procedure SetDefaultDownloadDialogMargin(aValue : TPoint);
      procedure SetMemoryUsageTargetLevel(aValue : TWVMemoryUsageTargetLevel);

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure UnsubscribeAllDevToolsProtocolEvents;
      procedure RemoveAllEvents;

      function  AddNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddSourceChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddHistoryChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddDocumentTitleChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddNewWindowRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWebResourceRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddScriptDialogOpeningEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddProcessFailedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddContainsFullScreenElementChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWindowCloseRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddWebResourceResponseReceivedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameCreatedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddDownloadStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddClientCertificateRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddIsMutedChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddIsDocumentPlayingAudioChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddIsDefaultDownloadDialogOpenChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddBasicAuthenticationRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddContextMenuRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddStatusBarTextChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddServerCertificateErrorDetectedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFaviconChanged(const aBrowserComponent : TComponent) : boolean;
      function  AddLaunchingExternalUriScheme(const aBrowserComponent : TComponent) : boolean;
      function  AddNotificationReceived(const aBrowserComponent : TComponent) : boolean;
      function  AddSaveAsUIShowing(const aBrowserComponent : TComponent) : boolean;
      function  AddSaveFileSecurityCheckStarting(const aBrowserComponent : TComponent) : boolean;
      function  AddScreenCaptureStarting(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2); reintroduce;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Subscribe to a DevTools protocol event. The TWVBrowserBase.OnDevToolsProtocolEventReceived
      /// event will be triggered on each DevTools event.
      /// </summary>
      /// <param name="aEventName">The DevTools protocol event name.</param>
      /// <param name="aEventID">A custom event ID that will be passed as a parameter in the TWVBrowserBase event.</param>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    SubscribeToDevToolsProtocolEvent(const aEventName: wvstring; aEventID : integer; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Capture an image of what WebView is displaying.  Specify the format of
      /// the image with the aImageFormat parameter.  The resulting image binary
      /// data is written to the provided aImageStream parameter. This method fails if called
      /// before the first ContentLoading event.  For example if this is called in
      /// the NavigationStarting event for the first navigation it will fail.
      /// For subsequent navigations, the method may not fail, but will not capture
      /// an image of a given webpage until the ContentLoading event has been fired
      /// for it.  Any call to this method prior to that will result in a capture of
      /// the page being navigated away from. When this function finishes writing to the stream,
      /// the TWVBrowserBase.OnCapturePreviewCompleted event is triggered.
      /// </summary>
      /// <param name="aImageFormat">The format of the image.</param>
      /// <param name="aImageStream">The resulting image binary data is written to this stream.</param>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    CapturePreview(aImageFormat: TWVCapturePreviewImageFormat; const aImageStream: IStream; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// <para>Run JavaScript code from the JavaScript parameter in the current
      /// top-level document rendered in the WebView.
      /// The TWVBrowserBase.OnExecuteScriptCompleted event is triggered
      /// when it finishes.</para>
      /// <para>The result of evaluating the provided JavaScript is available in the
      /// aResultObjectAsJson parameter of the TWVBrowserBase.OnExecuteScriptCompleted
      /// event as a JSON encoded string.  If the result is undefined, contains a reference
      /// cycle, or otherwise is not able to be encoded into JSON, then the result
      /// is considered to be null, which is encoded in JSON as the string "null".
      /// If the script that was run throws an unhandled exception, then the result is
      /// also "null".</para>
      /// <para>If the method is run after the `NavigationStarting` event during a navigation,
      /// the script runs in the new document when loading it, around the time
      /// `ContentLoading` is run.  This operation executes the script even if
      /// `ICoreWebView2Settings.IsScriptEnabled` is set to `FALSE`.</para>
      /// </summary>
      /// <param name="JavaScript">The JavaScript code.</param>
      /// <param name="aExecutionID">A custom event ID that will be passed as a parameter in the TWVBrowserBase event.</param>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    ExecuteScript(const JavaScript : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Navigates the WebView to the previous page in the navigation history.
      /// </summary>
      function    GoBack : boolean;
      /// <summary>
      /// Navigates the WebView to the next page in the navigation history.
      /// </summary>
      function    GoForward : boolean;
      /// <summary>
      /// Cause a navigation of the top-level document to run to the specified URI.
      /// </summary>
      function    Navigate(const aURI : wvstring) : boolean;
      /// <summary>
      /// Initiates a navigation to aHTMLContent as source HTML of a new document.
      /// The `aHTMLContent` parameter may not be larger than 2 MB (2 * 1024 * 1024 bytes) in total size.
      /// The origin of the new page is `about:blank`.
      /// </summary>
      function    NavigateToString(const aHTMLContent : wvstring) : boolean;
      /// <summary>
      /// Navigates using a constructed ICoreWebView2WebResourceRequest object. This lets you
      /// provide post data or additional request headers during navigation.
      /// The headers in aRequest override headers added by WebView2 runtime except for Cookie headers.
      /// Method can only be either "GET" or "POST". Provided post data will only
      /// be sent only if the method is "POST" and the uri scheme is HTTP(S).
      /// </summary>
      function    NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;
      /// <summary>
      /// Reload the current page.  This is similar to navigating to the URI of
      /// current top level document including all navigation events firing and
      /// respecting any entries in the HTTP cache.  But, the back or forward
      /// history are not modified.
      /// </summary>
      function    Reload : boolean;
      /// <summary>
      /// Stop all navigations and pending resource fetches. Does not stop scripts.
      /// </summary>
      function    Stop : boolean;
      /// <summary>
      /// An app may call the `TrySuspend` API to have the WebView2 consume less memory.
      /// This is useful when a Win32 app becomes invisible, or when a Universal Windows
      /// Platform app is being suspended, during the suspended event handler before completing
      /// the suspended event.
      /// The CoreWebView2Controller's IsVisible property must be false when the API is called.
      /// Otherwise, the API fails with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
      /// Suspending is similar to putting a tab to sleep in the Edge browser. Suspending pauses
      /// WebView script timers and animations, minimizes CPU usage for the associated
      /// browser renderer process and allows the operating system to reuse the memory that was
      /// used by the renderer process for other processes.
      /// Note that Suspend is best effort and considered completed successfully once the request
      /// is sent to browser renderer process. If there is a running script, the script will continue
      /// to run and the renderer process will be suspended after that script is done.
      /// See [Sleeping Tabs FAQ](https://techcommunity.microsoft.com/t5/articles/sleeping-tabs-faq/m-p/1705434)
      /// for conditions that might prevent WebView from being suspended. In those situations,
      /// the completed handler will be invoked with isSuccessful as false and errorCode as S_OK.
      /// The WebView will be automatically resumed when it becomes visible. Therefore, the
      /// app normally does not have to call `Resume` explicitly.
      /// The app can call `Resume` and then `TrySuspend` periodically for an invisible WebView so that
      /// the invisible WebView can sync up with latest data and the page ready to show fresh content
      /// when it becomes visible.
      /// All WebView APIs can still be accessed when a WebView is suspended. Some APIs like Navigate
      /// will auto resume the WebView. To avoid unexpected auto resume, check `IsSuspended` property
      /// before calling APIs that might change WebView state.
      /// </summary>
      function    TrySuspend(const aHandler: ICoreWebView2TrySuspendCompletedHandler) : boolean;
      /// <summary>
      /// Resumes the WebView so that it resumes activities on the web page.
      /// This API can be called while the WebView2 controller is invisible.
      /// The app can interact with the WebView immediately after `Resume`.
      /// WebView will be automatically resumed when it becomes visible.
      /// </summary>
      function    Resume : boolean;
      /// <summary>
      /// Sets a mapping between a virtual host name and a folder path to make available to web sites
      /// via that host name.
      ///
      /// After setting the mapping, documents loaded in the WebView can use HTTP or HTTPS URLs at
      /// the specified host name specified by hostName to access files in the local folder specified
      /// by folderPath.
      ///
      /// This mapping applies to both top-level document and iframe navigations as well as subresource
      /// references from a document. This also applies to web workers including dedicated/shared worker
      /// and service worker, for loading either worker scripts or subresources
      /// (importScripts(), fetch(), XHR, etc.) issued from within a worker.
      /// For virtual host mapping to work with service worker, please keep the virtual host name
      /// mappings consistent among all WebViews sharing the same browser instance. As service worker
      /// works independently of WebViews, we merge mappings from all WebViews when resolving virtual
      /// host name, inconsistent mappings between WebViews would lead unexpected behavior.
      ///
      /// Due to a current implementation limitation, media files accessed using virtual host name can be
      /// very slow to load.
      /// As the resource loaders for the current page might have already been created and running,
      /// changes to the mapping might not be applied to the current page and a reload of the page is
      /// needed to apply the new mapping.
      ///
      /// Both absolute and relative paths are supported for folderPath. Relative paths are interpreted
      /// as relative to the folder where the exe of the app is in.
      ///
      /// Note that the folderPath length must not exceed the Windows MAX_PATH limit.
      ///
      /// accessKind specifies the level of access to resources under the virtual host from other sites.
      ///
      /// For example, after calling
      ///  <code>
      /// ```cpp
      ///    SetVirtualHostNameToFolderMapping(
      ///        L"appassets.example", L"assets",
      ///        COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_DENY);
      /// ```
      /// </code>
      /// navigating to `https://appassets.example/my-local-file.html` will
      /// show the content from my-local-file.html in the assets subfolder located on disk under
      /// the same path as the app's executable file.
      ///
      /// DOM elements that want to reference local files will have their host reference virtual host in the source.
      /// If there are multiple folders being used, define one unique virtual host per folder.
      /// For example, you can embed a local image like this
      ///  <code>
      /// ```cpp
      ///    WCHAR c_navString[] = L"<img src=\"http://appassets.example/wv2.png\"/>";
      ///    m_webView->NavigateToString(c_navString);
      /// ```
      ///  </code>
      /// The example above shows the image wv2.png by resolving the folder mapping above.
      ///
      /// You should typically choose virtual host names that are never used by real sites.
      /// If you own a domain such as example.com, another option is to use a subdomain reserved for
      /// the app (like my-app.example.com).
      ///
      /// [RFC 6761](https://tools.ietf.org/html/rfc6761) has reserved several special-use domain
      /// names that are guaranteed to not be used by real sites (for example, .example, .test, and
      /// .invalid.)
      ///
      /// Note that using `.local` as the top-level domain name will work but can cause a delay
      /// during navigations. You should avoid using `.local` if you can.
      ///
      /// Apps should use distinct domain names when mapping folder from different sources that
      /// should be isolated from each other. For instance, the app might use app-file.example for
      /// files that ship as part of the app, and book1.example might be used for files containing
      /// books from a less trusted source that were previously downloaded and saved to the disk by
      /// the app.
      ///
      /// The host name used in the APIs is canonicalized using Chromium's host name parsing logic
      /// before being used internally. For more information see [HTML5 2.6 URLs](https://dev.w3.org/html5/spec-LC/urls.html).
      ///
      /// All host names that are canonicalized to the same string are considered identical.
      /// For example, `EXAMPLE.COM` and `example.com` are treated as the same host name.
      /// An international host name and its Punycode-encoded host name are considered the same host
      /// name. There is no DNS resolution for host name and the trailing '.' is not normalized as
      /// part of canonicalization.
      ///
      /// Therefore `example.com` and `example.com.` are treated as different host names. Similarly,
      /// `virtual-host-name` and `virtual-host-name.example.com` are treated as different host names
      /// even if the machine has a DNS suffix of `example.com`.
      ///
      /// Specify the minimal cross-origin access necessary to run the app. If there is not a need to
      /// access local resources from other origins, use COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_DENY.
      /// </summary>
      function    SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
      /// <summary>
      /// Clears a host name mapping for local folder that was added by `SetVirtualHostNameToFolderMapping`.
      /// </summary>
      function    ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;
      /// <summary>
      /// Opens the Browser Task Manager view as a new window in the foreground.
      /// If the Browser Task Manager is already open, this will bring it into
      /// the foreground. WebView2 currently blocks the Shift+Esc shortcut for
      /// opening the task manager. An end user can open the browser task manager
      /// manually via the `Browser task manager` entry of the DevTools window's
      /// title bar's context menu.
      /// </summary>
      function    OpenTaskManagerWindow : boolean;
      /// <summary>
      /// Print the current page to PDF asynchronously with the provided settings.
      /// See `ICoreWebView2PrintSettings` for description of settings. Passing
      /// nullptr for `printSettings` results in default print settings used.
      ///
      /// Use `resultFilePath` to specify the path to the PDF file. The host should
      /// provide an absolute path, including file name. If the path
      /// points to an existing file, the file will be overwritten. If the path is
      /// not valid, the method fails with `E_INVALIDARG`.
      ///
      /// The async `PrintToPdf` operation completes when the data has been written
      /// to the PDF file. At this time the
      /// `ICoreWebView2PrintToPdfCompletedHandler` is invoked. If the
      /// application exits before printing is complete, the file is not saved.
      /// Only one `Printing` operation can be in progress at a time. If
      /// `PrintToPdf` is called while a `PrintToPdf` or `PrintToPdfStream` or `Print` or
      /// `ShowPrintUI` job is in progress, the completed handler is immediately invoked
      /// with `isSuccessful` set to FALSE.
      /// </summary>
      function    PrintToPdf(const aResultFilePath : wvstring; const aPrintSettings : ICoreWebView2PrintSettings; const aHandler : ICoreWebView2PrintToPdfCompletedHandler) : boolean;
      /// <summary>
      /// Opens the DevTools window for the current document in the WebView. Does
      /// nothing if run when the DevTools window is already open.
      /// </summary>
      function    OpenDevToolsWindow : boolean;
      /// <summary>
      /// <para>Post the specified webMessage to the top level document in this WebView.
      /// The main page receives the message by subscribing to the `message` event of the
      /// `window.chrome.webview` of the page document.</para>
      /// <code>
      /// ```cpp
      /// window.chrome.webview.addEventListener('message', handler)
      /// window.chrome.webview.removeEventListener('message', handler)
      /// ```
      /// </code>
      /// <para>The event args is an instance of `MessageEvent`.  The
      /// `ICoreWebView2Settings::IsWebMessageEnabled` setting must be `TRUE` or
      /// the web message will not be sent. The `data` property of the event
      /// arg is the `webMessage` string parameter parsed as a JSON string into a
      /// JavaScript object.  The `source` property of the event arg is a reference
      ///  to the `window.chrome.webview` object.  For information about sending
      /// messages from the HTML document in the WebView to the host, navigate to
      /// [add_WebMessageReceived](/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived).
      /// The message is delivered asynchronously.  If a navigation occurs before
      /// the message is posted to the page, the message is discarded.</para>
      /// </summary>
      function    PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
      /// <summary>
      /// Posts a message that is a simple string rather than a JSON string
      /// representation of a JavaScript object.  This behaves in exactly the same
      /// manner as `PostWebMessageAsJson`, but the `data` property of the event
      /// arg of the `window.chrome.webview` message is a string with the same
      /// value as `webMessageAsString`.  Use this instead of
      /// `PostWebMessageAsJson` if you want to communicate using simple strings
      /// rather than JSON objects.
      /// </summary>
      function    PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
      /// <summary>
      /// <para>Runs an asynchronous `DevToolsProtocol` method.  For more information
      /// about available methods, navigate to
      /// [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot).</para>
      /// <para>The `methodName` parameter is the full name of the method in the
      /// `{domain}.{method}` format.  The `parametersAsJson` parameter is a JSON
      /// formatted string containing the parameters for the corresponding method.</para>
      /// <para>The `Invoke` method of the `handler` is run when the method
      /// asynchronously completes.  `Invoke` is run with the return object of the
      /// method as a JSON string.  This function returns E_INVALIDARG if the `methodName` is
      /// unknown or the `parametersAsJson` has an error.  In the case of such an error, the
      /// `returnObjectAsJson` parameter of the handler will include information
      /// about the error.</para>
      /// <para>Note even though WebView2 dispatches the CDP messages in the order called,
      /// CDP method calls may be processed out of order.
      /// If you require CDP methods to run in a particular order, you should wait
      /// for the previous method's completed handler to run before calling the
      /// next method.</para>
      /// <para>If the method is to run in add_NewWindowRequested handler it should be called
      /// before the new window is set if the cdp message should affect the initial navigation. If
      /// called after setting the NewWindow property, the cdp messages
      /// may or may not apply to the initial navigation and may only apply to the subsequent navigation.
      /// For more details see `ICoreWebView2NewWindowRequestedEventArgs::put_NewWindow`.</para>
      /// </summary>
      function    CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Runs an asynchronous `DevToolsProtocol` method for a specific session of
      /// an attached target.
      /// There could be multiple `DevToolsProtocol` targets in a WebView.
      /// Besides the top level page, iframes from different origin and web workers
      /// are also separate targets. Attaching to these targets allows interaction with them.
      /// When the DevToolsProtocol is attached to a target, the connection is identified
      /// by a sessionId.
      /// To use this API, you must set the `flatten` parameter to true when calling
      /// `Target.attachToTarget` or `Target.setAutoAttach` `DevToolsProtocol` method.
      /// Using `Target.setAutoAttach` is recommended as that would allow you to attach
      /// to dedicated worker targets, which are not discoverable via other APIs like
      /// `Target.getTargets`.
      /// For more information about targets and sessions, navigate to
      /// [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot/Target).
      /// For more information about available methods, navigate to
      /// [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot)
      /// The `sessionId` parameter is the sessionId for an attached target.
      /// nullptr or empty string is treated as the session for the default target for the top page.
      /// The `methodName` parameter is the full name of the method in the
      /// `{domain}.{method}` format.  The `parametersAsJson` parameter is a JSON
      /// formatted string containing the parameters for the corresponding method.
      /// The `Invoke` method of the `handler` is run when the method
      /// asynchronously completes.  `Invoke` is run with the return object of the
      /// method as a JSON string.  This function returns E_INVALIDARG if the `methodName` is
      /// unknown or the `parametersAsJson` has an error.  In the case of such an error, the
      /// `returnObjectAsJson` parameter of the handler will include information
      /// about the error.
      /// </summary>
      function    CallDevToolsProtocolMethodForSession(const aSessionId, aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Warning: This method is deprecated and does not behave as expected for
      /// iframes. It will cause the WebResourceRequested event to fire only for the
      /// main frame and its same-origin iframes. Please use
      /// `AddWebResourceRequestedFilterWithRequestSourceKinds`
      /// instead, which will let the event to fire for all iframes on the
      /// document.
      ///
      /// Adds a URI and resource context filter for the `WebResourceRequested`
      /// event.  A web resource request with a resource context that matches this
      /// filter's resource context and a URI that matches this filter's URI
      /// wildcard string will be raised via the `WebResourceRequested` event.
      ///
      /// The `uri` parameter value is a wildcard string matched against the URI
      /// of the web resource request. This is a glob style
      /// wildcard string in which a `*` matches zero or more characters and a `?`
      /// matches exactly one character.
      /// These wildcard characters can be escaped using a backslash just before
      /// the wildcard character in order to represent the literal `*` or `?`.
      ///
      /// The matching occurs over the URI as a whole string and not limiting
      /// wildcard matches to particular parts of the URI.
      /// The wildcard filter is compared to the URI after the URI has been
      /// normalized, any URI fragment has been removed, and non-ASCII hostnames
      /// have been converted to punycode.
      ///
      /// Specifying a `nullptr` for the uri is equivalent to an empty string which
      /// matches no URIs.
      ///
      /// For more information about resource context filters, navigate to
      /// [COREWEBVIEW2_WEB_RESOURCE_CONTEXT](/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_web_resource_context).
      /// <code>
      /// | URI Filter String | Request URI | Match | Notes |
      /// | ---- | ---- | ---- | ---- |
      /// | `*` | `https://contoso.com/a/b/c` | Yes | A single * will match all URIs |
      /// | `*://contoso.com/*` | `https://contoso.com/a/b/c` | Yes | Matches everything in contoso.com across all schemes |
      /// | `*://contoso.com/*` | `https://example.com/?https://contoso.com/` | Yes | But also matches a URI with just the same text anywhere in the URI |
      /// | `example` | `https://contoso.com/example` | No | The filter does not perform partial matches |
      /// | `*example` | `https://contoso.com/example` | Yes | The filter matches across URI parts  |
      /// | `*example` | `https://contoso.com/path/?example` | Yes | The filter matches across URI parts |
      /// | `*example` | `https://contoso.com/path/?query#example` | No | The filter is matched against the URI with no fragment |
      /// | `*example` | `https://example` | No | The URI is normalized before filter matching so the actual URI used for comparison is `https://example/` |
      /// | `*example/` | `https://example` | Yes | Just like above, but this time the filter ends with a / just like the normalized URI |
      /// | `https://xn--qei.example/` | `https://&#x2764;.example/` | Yes | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      /// | `https://&#x2764;.example/` | `https://xn--qei.example/` | No | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      /// </code>
      /// </summary>
      function    AddWebResourceRequestedFilter(const URI : wvstring; ResourceContext: TWVWebResourceContext) : boolean;
      /// <summary>
      /// <para>Warning: This method and `AddWebResourceRequestedFilter` are deprecated.
      /// Please use `AddWebResourceRequestedFilterWithRequestSourceKinds` and
      /// `RemoveWebResourceRequestedFilterWithRequestSourceKinds` instead.</para>
      /// <para>Removes a matching WebResource filter that was previously added for the
      /// `WebResourceRequested` event.  If the same filter was added multiple
      /// times, then it must be removed as many times as it was added for the
      /// removal to be effective.  Returns `E_INVALIDARG` for a filter that was
      /// never added.</para>
      /// </summary>
      function    RemoveWebResourceRequestedFilter(const URI : wvstring; ResourceContext: TWVWebResourceContext) : boolean;
      /// <summary>
      /// <para>Add the provided host object to script running in the WebView with the
      /// specified name.  Host objects are exposed as host object proxies using
      /// `window.chrome.webview.hostObjects.{name}`.  Host object proxies are
      /// promises and resolves to an object representing the host object.  The
      /// promise is rejected if the app has not added an object with the name.</para>
      /// <para>When JavaScript code access a property or method of the object, a promise
      ///  is return, which resolves to the value returned from the host for the
      /// property or method, or rejected in case of error, for example, no
      /// property or method on the object or parameters are not valid.</para>
      ///
      /// <para>NOTE: While simple types, `IDispatch` and array are supported, and
      /// `IUnknown` objects that also implement `IDispatch` are treated as `IDispatch`,
      /// generic `IUnknown`, `VT_DECIMAL`, or `VT_RECORD` variant is not supported.
      /// Remote JavaScript objects like callback functions are represented as an
      /// `VT_DISPATCH` `VARIANT` with the object implementing `IDispatch`.  The
      /// JavaScript callback method may be invoked using `DISPID_VALUE` for the
      /// `DISPID`.  Such callback method invocations will return immediately and will
      /// not wait for the JavaScript function to run and so will not provide the return
      /// value of the JavaScript function.</para>
      /// <para>Nested arrays are supported up to a depth of 3.  Arrays of by
      /// reference types are not supported. `VT_EMPTY` and `VT_NULL` are mapped
      /// into JavaScript as `null`.  In JavaScript, `null` and undefined are
      /// mapped to `VT_EMPTY`.</para>
      ///
      /// <para>Additionally, all host objects are exposed as
      /// `window.chrome.webview.hostObjects.sync.{name}`.  Here the host objects
      /// are exposed as synchronous host object proxies. These are not promises
      /// and function runtimes or property access synchronously block running
      /// script waiting to communicate cross process for the host code to run.
      /// Accordingly the result may have reliability issues and it is recommended
      /// that you use the promise-based asynchronous
      /// `window.chrome.webview.hostObjects.{name}` API.</para>
      ///
      /// <para>Synchronous host object proxies and asynchronous host object proxies may
      /// both use a proxy to the same host object.  Remote changes made by one
      /// proxy propagates to any other proxy of that same host object whether
      /// the other proxies and synchronous or asynchronous.</para>
      ///
      /// <para>While JavaScript is blocked on a synchronous run to native code, that
      /// native code is unable to run back to JavaScript.  Attempts to do so fail
      ///  with `HRESULT_FROM_WIN32(ERROR_POSSIBLE_DEADLOCK)`.</para>
      ///
      /// <para>Host object proxies are JavaScript Proxy objects that intercept all
      /// property get, property set, and method invocations. Properties or methods
      ///  that are a part of the Function or Object prototype are run locally.
      /// Additionally any property or method in the
      /// `chrome.webview.hostObjects.options.forceLocalProperties`
      /// array are also run locally.  This defaults to including optional methods
      /// that have meaning in JavaScript like `toJSON` and `Symbol.toPrimitive`.
      /// Add more to the array as required.</para>
      ///
      /// <para>The `chrome.webview.hostObjects.cleanupSome` method performs a best
      /// effort garbage collection on host object proxies.</para>
      ///
      /// <para>The `chrome.webview.hostObjects.options` object provides the ability to
      /// change some functionality of host objects.</para>
      /// <code>
      /// Options property | Details
      /// ---|---
      /// `forceLocalProperties` | This is an array of host object property names that will be run locally, instead of being called on the native host object. This defaults to `then`, `toJSON`, `Symbol.toString`, and `Symbol.toPrimitive`. You can add other properties to specify that they should be run locally on the javascript host object proxy.
      /// `log` | This is a callback that will be called with debug information. For example, you can set this to `console.log.bind(console)` to have it print debug information to the console to help when troubleshooting host object usage. By default this is null.
      /// `shouldSerializeDates` | By default this is false, and javascript Date objects will be sent to host objects as a string using `JSON.stringify`. You can set this property to true to have Date objects properly serialize as a `VT_DATE` when sending to the native host object, and have `VT_DATE` properties and return values create a javascript Date object.
      /// `defaultSyncProxy` | When calling a method on a synchronous proxy, the result should also be a synchronous proxy. But in some cases, the sync/async context is lost (for example, when providing to native code a reference to a function, and then calling that function in native code). In these cases, the proxy will be asynchronous, unless this property is set.
      /// `forceAsyncMethodMatches ` | This is an array of regular expressions. When calling a method on a synchronous proxy, the method call will be performed asynchronously if the method name matches a string or regular expression in this array. Setting this value to `Async` will make any method that ends with Async be an asynchronous method call. If an async method doesn't match here and isn't forced to be asynchronous, the method will be invoked synchronously, blocking execution of the calling JavaScript and then returning the resolution of the promise, rather than returning a promise.
      /// `ignoreMemberNotFoundError` | By default, an exception is thrown when attempting to get the value of a proxy property that doesn't exist on the corresponding native class. Setting this property to `true` switches the behavior to match Chakra WinRT projection (and general JavaScript) behavior of returning `undefined` with no error.
      /// `shouldPassTypedArraysAsArrays` | By default, typed arrays are passed to the host as `IDispatch`. To instead pass typed arrays to the host as `array`, set this to `true`.
      /// </code>
      /// <para>Host object proxies additionally have the following methods which run
      /// locally.</para>
      /// <code>
      /// Method name | Details
      /// ---|---
      ///`applyHostFunction`, `getHostProperty`, `setHostProperty` | Perform a method invocation, property get, or property set on the host object. Use the methods to explicitly force a method or property to run remotely if a conflicting local method or property exists.  For instance, `proxy.toString()` runs the local `toString` method on the proxy object. But proxy.applyHostFunction('toString') runs `toString` on the host proxied object instead.
      ///`getLocalProperty`, `setLocalProperty` | Perform property get, or property set locally.  Use the methods to force getting or setting a property on the host object proxy rather than on the host object it represents. For instance, `proxy.unknownProperty` gets the property named `unknownProperty` from the host proxied object.  But proxy.getLocalProperty('unknownProperty') gets the value of the property `unknownProperty` on the proxy object.
      ///`sync` | Asynchronous host object proxies expose a sync method which returns a promise for a synchronous host object proxy for the same host object.  For example, `chrome.webview.hostObjects.sample.methodCall()` returns an asynchronous host object proxy.  Use the `sync` method to obtain a synchronous host object proxy instead: `const syncProxy = await chrome.webview.hostObjects.sample.methodCall().sync()`.
      ///`async` | Synchronous host object proxies expose an async method which blocks and returns an asynchronous host object proxy for the same host object.  For example, `chrome.webview.hostObjects.sync.sample.methodCall()` returns a synchronous host object proxy.  Running the `async` method on this blocks and then returns an asynchronous host object proxy for the same host object: `const asyncProxy = chrome.webview.hostObjects.sync.sample.methodCall().async()`.
      ///`then` | Asynchronous host object proxies have a `then` method.  Allows proxies to be awaitable.  `then` returns a promise that resolves with a representation of the host object.  If the proxy represents a JavaScript literal, a copy of that is returned locally.  If the proxy represents a function, a non-awaitable proxy is returned.  If the proxy represents a JavaScript object with a mix of literal properties and function properties, the a copy of the object is returned with some properties as host object proxies.
      /// </code>
      /// <para>All other property and method invocations (other than the above Remote
      /// object proxy methods, `forceLocalProperties` list, and properties on
      /// Function and Object prototypes) are run remotely.  Asynchronous host
      /// object proxies return a promise representing asynchronous completion of
      /// remotely invoking the method, or getting the property.  The promise
      /// resolves after the remote operations complete and the promises resolve to
      ///  the resulting value of the operation.  Synchronous host object proxies
      /// work similarly, but block running JavaScript and wait for the remote
      /// operation to complete.</para>
      ///
      /// <para>Setting a property on an asynchronous host object proxy works slightly
      /// differently.  The set returns immediately and the return value is the
      /// value that is set.  This is a requirement of the JavaScript Proxy object.
      /// If you need to asynchronously wait for the property set to complete, use
      /// the `setHostProperty` method which returns a promise as described above.
      /// Synchronous object property set property synchronously blocks until the
      /// property is set.</para>
      /// </summary>
      function    AddHostObjectToScript(const aName : wvstring; const aObject : OleVariant): boolean;
      /// <summary>
      /// Remove the host object specified by the name so that it is no longer
      /// accessible from JavaScript code in the WebView.  While new access
      /// attempts are denied, if the object is already obtained by JavaScript code
      /// in the WebView, the JavaScript code continues to have access to that
      /// object.   Run this method for a name that is already removed or never
      /// added fails.
      /// </summary>
      function    RemoveHostObjectFromScript(const aName : wvstring) : boolean;
      /// <summary>
      /// <para>Add the provided JavaScript to a list of scripts that should be run after
      /// the global object has been created, but before the HTML document has
      /// been parsed and before any other script included by the HTML document is
      /// run.  This method injects a script that runs on all top-level document
      /// and child frame page navigations.  This method runs asynchronously, and
      /// you must wait for the completion handler to finish before the injected
      /// script is ready to run.  When this method completes, the `Invoke` method
      /// of the handler is run with the `id` of the injected script.  `id` is a
      /// string.  To remove the injected script, use
      /// `RemoveScriptToExecuteOnDocumentCreated`.</para>
      /// <para>If the method is run in add_NewWindowRequested handler it should be called
      /// before the new window is set. If called after setting the NewWindow property, the initial script
      /// may or may not apply to the initial navigation and may only apply to the subsequent navigation.
      /// For more details see `ICoreWebView2NewWindowRequestedEventArgs::put_NewWindow`.</para>
      /// <para>NOTE: If an HTML document is running in a sandbox of some kind using
      /// [sandbox](https://developer.mozilla.org/docs/Web/HTML/Element/iframe#attr-sandbox)
      /// properties or the
      /// [Content-Security-Policy](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy)
      /// HTTP header affects the script that runs.  For example, if the
      /// `allow-modals` keyword is not set then requests to run the `alert`
      /// function are ignored.</para>
      /// </summary>
      function    AddScriptToExecuteOnDocumentCreated(const JavaScript : wvstring; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Remove the corresponding JavaScript added using
      /// `AddScriptToExecuteOnDocumentCreated` with the specified script ID. The
      /// script ID should be the one returned by the `AddScriptToExecuteOnDocumentCreated`.
      /// Both use `AddScriptToExecuteOnDocumentCreated` and this method in `NewWindowRequested`
      /// event handler at the same time sometimes causes trouble.  Since invalid scripts will
      /// be ignored, the script IDs you got may not be valid anymore.
      /// </summary>
      function    RemoveScriptToExecuteOnDocumentCreated(const aID : wvstring) : boolean;
      /// <summary>
      /// Open the default download dialog. If the dialog is opened before there
      /// are recent downloads, the dialog shows all past downloads for the
      /// current profile. Otherwise, the dialog shows only the recent downloads
      /// with a "See more" button for past downloads. Calling this method raises
      /// the `IsDefaultDownloadDialogOpenChanged` event if the dialog was closed.
      /// No effect if the dialog is already open.
      /// </summary>
      function    OpenDefaultDownloadDialog : boolean;
      /// <summary>
      /// Close the default download dialog. Calling this method raises the
      /// `IsDefaultDownloadDialogOpenChanged` event if the dialog was open. No
      /// effect if the dialog is already closed.
      /// </summary>
      function    CloseDefaultDownloadDialog : boolean;
      /// <summary>
      /// Clears all cached decisions to proceed with TLS certificate errors from the
      /// ServerCertificateErrorDetected event for all WebView2's sharing the same session.
      /// </summary>
      function    ClearServerCertificateErrorActions(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Async function for getting the actual image data of the favicon.
      /// The image is copied to the `imageStream` object in `ICoreWebView2GetFaviconCompletedHandler`.
      /// If there is no image then no data would be copied into the imageStream.
      /// The `format` is the file format to return the image stream.
      /// `completedHandler` is executed at the end of the operation.
      /// </summary>
      function    GetFavicon(aFormat: TWVFaviconImageFormat; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// <para>Print the current web page asynchronously to the specified printer with the provided settings.
      /// See `ICoreWebView2PrintSettings` for description of settings. Passing
      /// nullptr for `printSettings` results in default print settings used.</para>
      /// <para>The handler will return `errorCode` as `S_OK` and `printStatus` as COREWEBVIEW2_PRINT_STATUS_PRINTER_UNAVAILABLE
      /// if `printerName` doesn't match with the name of any installed printers on the user OS. The handler
      /// will return `errorCode` as `E_INVALIDARG` and `printStatus` as COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR
      /// if the caller provides invalid settings for a given printer.</para>
      /// <para>The async `Print` operation completes when it finishes printing to the printer.
      /// At this time the `ICoreWebView2PrintCompletedHandler` is invoked.
      /// Only one `Printing` operation can be in progress at a time. If `Print` is called while a `Print` or `PrintToPdf`
      /// or `PrintToPdfStream` or `ShowPrintUI` job is in progress, the completed handler is immediately invoked
      /// with `E_ABORT` and `printStatus` is COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR.
      /// This is only for printing operation on one webview.</para>
      /// <code>
      /// |       errorCode     |      printStatus                              |               Notes                                                                           |
      /// | --- | --- | --- |
      /// |        S_OK         | COREWEBVIEW2_PRINT_STATUS_SUCCEEDED           | Print operation succeeded.                                                                    |
      /// |        S_OK         | COREWEBVIEW2_PRINT_STATUS_PRINTER_UNAVAILABLE | If specified printer is not found or printer status is not available, offline or error state. |
      /// |        S_OK         | COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR         | Print operation is failed.                                                                    |
      /// |     E_INVALIDARG    | COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR         | If the caller provides invalid settings for the specified printer.                            |
      /// |       E_ABORT       | COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR         | Print operation is failed as printing job already in progress.                                |
      /// </code>
      /// </summary>
      function    Print(const aPrintSettings: ICoreWebView2PrintSettings; const aHandler: ICoreWebView2PrintCompletedHandler): boolean;
      /// <summary>
      /// <para>Opens the print dialog to print the current web page. See `COREWEBVIEW2_PRINT_DIALOG_KIND`
      /// for descriptions of print dialog kinds.</para>
      /// <para>Invoking browser or system print dialog doesn't open new print dialog if
      /// it is already open.</para>
      /// </summary>
      function    ShowPrintUI(aPrintDialogKind: TWVPrintDialogKind): boolean;
      /// <summary>
      /// <para>Provides the Pdf data of current web page asynchronously for the provided settings.
      /// Stream will be rewound to the start of the pdf data.</para>
      /// <para>See `ICoreWebView2PrintSettings` for description of settings. Passing
      /// nullptr for `printSettings` results in default print settings used.</para>
      /// <para>The async `PrintToPdfStream` operation completes when it finishes
      /// writing to the stream. At this time the `ICoreWebView2PrintToPdfStreamCompletedHandler`
      /// is invoked. Only one `Printing` operation can be in progress at a time. If
      /// `PrintToPdfStream` is called while a `PrintToPdfStream` or `PrintToPdf` or `Print`
      /// or `ShowPrintUI` job is in progress, the completed handler is immediately invoked with `E_ABORT`.
      /// This is only for printing operation on one webview.</para>
      /// </summary>
      function    PrintToPdfStream(const aPrintSettings: ICoreWebView2PrintSettings; const aHandler: ICoreWebView2PrintToPdfStreamCompletedHandler): boolean;
      /// <summary>
      /// <para>Share a shared buffer object with script of the main frame in the WebView.
      /// The script will receive a `sharedbufferreceived` event from chrome.webview.
      /// The event arg for that event will have the following methods and properties:</para>
      /// <para>  `getBuffer()`: return an ArrayBuffer object with the backing content from the shared buffer.</para>
      /// <para>  `additionalData`: an object as the result of parsing `additionalDataAsJson` as JSON string.
      ///           This property will be `undefined` if `additionalDataAsJson` is nullptr or empty string.</para>
      /// <para>  `source`: with a value set as `chrome.webview` object.</para>
      /// <para>If a string is provided as `additionalDataAsJson` but it is not a valid JSON string,
      /// the API will fail with `E_INVALIDARG`.</para>
      /// <para>If `access` is COREWEBVIEW2_SHARED_BUFFER_ACCESS_READ_ONLY, the script will only have read access to the buffer.
      /// If the script tries to modify the content in a read only buffer, it will cause an access
      /// violation in WebView renderer process and crash the renderer process.
      /// If the shared buffer is already closed, the API will fail with `RO_E_CLOSED`.</para>
      /// <para>The script code should call `chrome.webview.releaseBuffer` with
      /// the shared buffer as the parameter to release underlying resources as soon
      /// as it does not need access to the shared buffer any more.</para>
      /// <para>The application can post the same shared buffer object to multiple web pages or iframes, or
      /// post to the same web page or iframe multiple times. Each `PostSharedBufferToScript` will
      /// create a separate ArrayBuffer object with its own view of the memory and is separately
      /// released. The underlying shared memory will be released when all the views are released.</para>
      /// </summary>
      function    PostSharedBufferToScript(const aSharedBuffer: ICoreWebView2SharedBuffer; aAccess: TWVSharedBufferAccess; const aAdditionalDataAsJson: wvstring): boolean;
      /// <summary>
      /// Run JavaScript code from the JavaScript parameter in the current
      /// top-level document rendered in the WebView.
      /// The result of the execution is returned asynchronously in the CoreWebView2ExecuteScriptResult object
      /// which has methods and properties to obtain the successful result of script execution as well as any
      /// unhandled JavaScript exceptions.
      /// If this method is
      /// run after the NavigationStarting event during a navigation, the script
      /// runs in the new document when loading it, around the time
      /// ContentLoading is run. This operation executes the script even if
      /// ICoreWebView2Settings::IsScriptEnabled is set to FALSE.
      ///
      /// \snippet ScriptComponent.cpp ExecuteScriptWithResult
      /// </summary>
      function ExecuteScriptWithResult(const JavaScript: wvstring; aExecutionID : integer; const aBrowserComponent : TComponent): boolean;
      /// <summary>
      /// A web resource request with a resource context that matches this
      /// filter's resource context and a URI that matches this filter's URI
      /// wildcard string for corresponding request sources will be raised via
      /// the `WebResourceRequested` event. To receive all raised events filters
      /// have to be added before main page navigation.
      ///
      /// The `uri` parameter value is a wildcard string matched against the URI
      /// of the web resource request. This is a glob style
      /// wildcard string in which a `*` matches zero or more characters and a `?`
      /// matches exactly one character.
      /// These wildcard characters can be escaped using a backslash just before
      /// the wildcard character in order to represent the literal `*` or `?`.
      ///
      /// The matching occurs over the URI as a whole string and not limiting
      /// wildcard matches to particular parts of the URI.
      /// The wildcard filter is compared to the URI after the URI has been
      /// normalized, any URI fragment has been removed, and non-ASCII hostnames
      /// have been converted to punycode.
      ///
      /// Specifying a `nullptr` for the uri is equivalent to an empty string which
      /// matches no URIs.
      ///
      /// For more information about resource context filters, navigate to
      /// [COREWEBVIEW2_WEB_RESOURCE_CONTEXT](/microsoft-edge/webview2/reference/win32/icorewebview2#corewebview2_web_resource_context).
      ///
      /// The `requestSourceKinds` is a mask of one or more
      /// `COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS`. OR operation(s) can be
      /// applied to multiple `COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS` to
      /// create a mask representing those data types. API returns `E_INVALIDARG` if
      /// `requestSourceKinds` equals to zero. For more information about request
      /// source kinds, navigate to
      /// [COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS](/microsoft-edge/webview2/reference/win32/icorewebview2#corewebview2_web_resource_request_source_kinds).
      ///
      /// Because service workers and shared workers run separately from any one
      /// HTML document their WebResourceRequested will be raised for all
      /// CoreWebView2s that have appropriate filters added in the corresponding
      /// CoreWebView2Environment. You should only add a WebResourceRequested filter
      /// for COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SERVICE_WORKER or
      /// COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SHARED_WORKER on
      /// one CoreWebView2 to avoid handling the same WebResourceRequested
      /// event multiple times.
      ///
      /// | URI Filter String | Request URI | Match | Notes |
      /// | ---- | ---- | ---- | ---- |
      /// | `*` | `https://contoso.com/a/b/c` | Yes | A single * will match all URIs |
      /// | `*://contoso.com/*` | `https://contoso.com/a/b/c` | Yes | Matches everything in contoso.com across all schemes |
      /// | `*://contoso.com/*` | `https://example.com/?https://contoso.com/` | Yes | But also matches a URI with just the same text anywhere in the URI |
      /// | `example` | `https://contoso.com/example` | No | The filter does not perform partial matches |
      /// | `*example` | `https://contoso.com/example` | Yes | The filter matches across URI parts |
      /// | `*example` | `https://contoso.com/path/?example` | Yes | The filter matches across URI parts |
      /// | `*example` | `https://contoso.com/path/?query#example` | No | The filter is matched against the URI with no fragment |
      /// | `*example` | `https://example` | No | The URI is normalized before filter matching so the actual URI used for comparison is `https://example/` |
      /// | `*example/` | `https://example` | Yes | Just like above, but this time the filter ends with a / just like the normalized URI |
      /// | `https://xn--qei.example/` | `https://&#x2764;.example/` | Yes | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      /// | `https://&#x2764;.example/` | `https://xn--qei.example/` | No | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
      ///
      /// \snippet ScenarioSharedWorkerWRR.cpp WebResourceRequested2
      /// </summary>
      function AddWebResourceRequestedFilterWithRequestSourceKinds(const uri: wvstring;
                                                                   ResourceContext: TWVWebResourceContext;
                                                                   requestSourceKinds: TWVWebResourceRequestSourceKind): boolean;
      /// <summary>
      /// Removes a matching WebResource filter that was previously added for the
      /// `WebResourceRequested` event.  If the same filter was added multiple
      /// times, then it must be removed as many times as it was added for the
      /// removal to be effective. Returns `E_INVALIDARG` for a filter that was
      /// not added or is already removed.
      /// If the filter was added for multiple requestSourceKinds and removed just for one of them
      /// the filter remains for the non-removed requestSourceKinds.
      /// </summary>
      function RemoveWebResourceRequestedFilterWithRequestSourceKinds(const uri: wvstring;
                                                                      ResourceContext: TWVWebResourceContext;
                                                                      requestSourceKinds: TWVWebResourceRequestSourceKind): boolean;

      /// <summary>
      /// <para>Same as `PostWebMessageAsJson`, but also has support for posting DOM objects
      /// to page content. The `additionalObjects` property in the DOM MessageEvent
      /// fired on the page content is an array-like list of DOM objects that can
      /// be posted to the web content. Currently these can be the following
      /// types of objects:</para>
      /// <code>
      /// | Win32             | DOM type    |
      /// |-------------------|-------------|
      /// | ICoreWebView2FileSystemHandle | [FileSystemHandle](https://developer.mozilla.org/docs/Web/API/FileSystemHandle) |
      /// | nullptr           | null        |
      /// </code>
      /// <para>The objects are posted to the web content, following the
      /// [structured-clone](https://developer.mozilla.org/docs/Web/API/Web_Workers_API/Structured_clone_algorithm)
      /// semantics, meaning only objects that can be cloned can be posted.</para>
      /// <para>They will also behave as if they had been created by the web content they are
      /// posted to. For example, if a FileSystemFileHandle is posted to a web content
      /// it can only be re-transferred via postMessage to other web content
      /// [with the same origin](https://fs.spec.whatwg.org/#filesystemhandle).</para>
      /// <para>Warning: An app needs to be mindful when using this API to post DOM objects
      /// as this API provides the web content with unusual access to sensitive Web
      /// Platform features such as filesystem access! Similar to PostWebMessageAsJson
      /// the app should check the `Source` property of WebView2 right before posting the message
      /// to ensure the message and objects will only be sent to the target web content
      /// that it expects to receive the DOM objects. Additionally, the order
      /// of messages that are posted between `PostWebMessageAsJson` and `PostWebMessageAsJsonWithAdditionalObjects`
      /// may not be preserved.</para>
      /// </summary>
      function PostWebMessageAsJsonWithAdditionalObjects(const webMessageAsJson: wvstring;
                                                         const additionalObjects: ICoreWebView2ObjectCollectionView): boolean;
      /// <summary>
      /// <para>Programmatically trigger a Save As action for the currently loaded document.</para>
      /// <para>The `SaveAsUIShowing` event is raised.</para>
      ///
      /// <para>Opens a system modal dialog by default. If the `SuppressDefaultDialog` property
      /// is `TRUE`, the system dialog is not opened.</para>
      ///
      /// <para>This method returns `COREWEBVIEW2_SAVE_AS_UI_RESULT`. See
      /// `COREWEBVIEW2_SAVE_AS_UI_RESULT` for details.</para>
      /// </summary>
      function ShowSaveAsUI(const aBrowserComponent : TComponent) : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                          : boolean                                   read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                             : ICoreWebView2                             read FBaseIntf;
      /// <summary>
      /// The `ICoreWebView2Settings` object contains various modifiable settings
      /// for the running WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_settings">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property Settings                             : ICoreWebView2Settings                     read GetSettings;
      /// <summary>
      /// The process ID of the browser process that hosts the WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_browserprocessid">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property BrowserProcessID                     : DWORD                                     read GetBrowserProcessID;
      /// <summary>
      /// `TRUE` if the WebView is able to navigate to a previous page in the
      /// navigation history.  If `CanGoBack` changes value, the `HistoryChanged`
      /// event runs.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2##get_cangoback">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property CanGoBack                            : boolean                                   read GetCanGoBack;
      /// <summary>
      /// `TRUE` if the WebView is able to navigate to a next page in the
      /// navigation history.  If `CanGoForward` changes value, the
      /// `HistoryChanged` event runs.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_cangoforward">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property CanGoForward                         : boolean                                   read GetCanGoForward;
      /// <summary>
      /// Indicates if the WebView contains a fullscreen HTML element.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_containsfullscreenelement">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property ContainsFullScreenElement            : boolean                                   read GetContainsFullScreenElement;
      /// <summary>
      /// The title for the current top-level document.  If the document has no
      /// explicit title or is otherwise empty, a default that may or may not match
      ///  the URI of the document is used.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_documenttitle">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property DocumentTitle                        : wvstring                                  read GetDocumentTitle;
      /// <summary>
      /// The URI of the current top level document.  This value potentially
      /// changes as a part of the `SourceChanged` event that runs for some cases
      /// such as navigating to a different site or fragment navigations.  It
      /// remains the same for other types of navigations such as page refreshes
      /// or `history.pushState` with the same URL as the current page.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2#get_source">See the ICoreWebView2 article.</see></para>
      /// </remarks>
      property Source                               : wvstring                                  read GetSource;
      /// <summary>
      /// Gets the cookie manager object associated with this ICoreWebView2.
      /// See ICoreWebView2CookieManager.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2#get_cookiemanager">See the ICoreWebView2_2 article.</see></para>
      /// </remarks>
      property CookieManager                        : ICoreWebView2CookieManager                read GetCookieManager;
      /// <summary>
      /// Exposes the CoreWebView2Environment used to create this CoreWebView2.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2#get_environment">See the ICoreWebView2_2 article.</see></para>
      /// </remarks>
      property Environment                          : ICoreWebView2Environment                  read GetEnvironment;
      /// <summary>
      /// Whether WebView is suspended.
      /// `TRUE` when WebView is suspended, from the time when TrySuspend has completed
      ///  successfully until WebView is resumed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3#get_issuspended">See the ICoreWebView2_3 article.</see></para>
      /// </remarks>
      property IsSuspended                          : boolean                                   read GetIsSuspended;
      /// <summary>
      /// Indicates whether all audio output from this CoreWebView2 is muted or not.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8#get_ismuted">See the ICoreWebView2_8 article.</see></para>
      /// </remarks>
      property IsMuted                              : boolean                                   read GetIsMuted                               write SetIsMuted;
      /// <summary>
      /// Indicates whether any audio output from this CoreWebView2 is playing.
      /// This property will be true if audio is playing even if IsMuted is true.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8#get_isdocumentplayingaudio">See the ICoreWebView2_8 article.</see></para>
      /// </remarks>
      property IsDocumentPlayingAudio               : boolean                                   read GetIsDocumentPlayingAudio;
      /// <summary>
      /// `TRUE` if the default download dialog is currently open. The value of this
      /// property changes only when the default download dialog is explicitly
      /// opened or closed. Hiding the WebView implicitly hides the dialog, but does
      /// not change the value of this property.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#get_isdefaultdownloaddialogopen">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      property IsDefaultDownloadDialogOpen          : boolean                                   read GetIsDefaultDownloadDialogOpen;
      /// <summary>
      /// Get the default download dialog corner alignment.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#get_defaultdownloaddialogcorneralignment">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      property DefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment   read GetDefaultDownloadDialogCornerAlignment  write SetDefaultDownloadDialogCornerAlignment;
      /// <summary>
      /// Get the default download dialog margin.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9#get_defaultdownloaddialogmargin">See the ICoreWebView2_9 article.</see></para>
      /// </remarks>
      property DefaultDownloadDialogMargin          : TPoint                                    read GetDefaultDownloadDialogMargin           write SetDefaultDownloadDialogMargin;
      /// <summary>
      /// The status message text.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_12#get_statusbartext">See the ICoreWebView2_12 article.</see></para>
      /// </remarks>
      property StatusBarText                        : wvstring                                  read GetStatusBarText;
      /// <summary>
      /// The associated `ICoreWebView2Profile` object. If this CoreWebView2 was created with a
      /// CoreWebView2ControllerOptions, the CoreWebView2Profile will match those specified options.
      /// Otherwise if this CoreWebView2 was created without a CoreWebView2ControllerOptions, then
      /// this will be the default CoreWebView2Profile for the corresponding CoreWebView2Environment.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_13#get_profile">See the ICoreWebView2_13 article.</see></para>
      /// </remarks>
      property Profile                              : ICoreWebView2Profile                      read GetProfile;
      /// <summary>
      /// Get the current Uri of the favicon as a string.
      /// If the value is null, then the return value is `E_POINTER`, otherwise it is `S_OK`.
      /// If a page has no favicon then the value is an empty string.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15#get_faviconuri">See the ICoreWebView2_15 article.</see></para>
      /// </remarks>
      property FaviconURI                           : wvstring                                  read GetFaviconURI;
      /// <summary>
      /// `MemoryUsageTargetLevel` indicates desired memory consumption level of
      /// WebView.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_19#get_memoryusagetargetlevel">See the ICoreWebView2_19 article.</see></para>
      /// </remarks>
      property MemoryUsageTargetLevel               : TWVMemoryUsageTargetLevel                 read GetMemoryUsageTargetLevel                write SetMemoryUsageTargetLevel;
      /// <summary>
      /// The unique identifier of the main frame. It's the same kind of ID as
      /// with the `FrameId` in `ICoreWebView2Frame` and via `ICoreWebView2FrameInfo`.
      /// Note that `FrameId` may not be valid if `ICoreWebView2` has not done
      /// any navigation. It's safe to get this value during or after the first
      /// `ContentLoading` event. Otherwise, it could return the invalid frame Id 0.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_20#get_frameid">See the ICoreWebView2_20 article.</see></para>
      /// </remarks>
      property FrameId                              : cardinal                                  read GetFrameID;
  end;

implementation

uses
  uWVBrowserBase, uWVCoreWebView2Delegates, uWVMiscFunctions, uWVConstants;

constructor TCoreWebView2.Create(const aBaseIntf : ICoreWebView2);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_2,  FBaseIntf2)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_3,  FBaseIntf3)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_4,  FBaseIntf4)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_5,  FBaseIntf5)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_6,  FBaseIntf6)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_7,  FBaseIntf7)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_8,  FBaseIntf8)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_9,  FBaseIntf9)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_10, FBaseIntf10) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_11, FBaseIntf11) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_12, FBaseIntf12) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_13, FBaseIntf13) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_14, FBaseIntf14) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_15, FBaseIntf15) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_16, FBaseIntf16) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_17, FBaseIntf17) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_18, FBaseIntf18) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_19, FBaseIntf19) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_20, FBaseIntf20) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_21, FBaseIntf21) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_22, FBaseIntf22) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_23, FBaseIntf23) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_24, FBaseIntf24) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_25, FBaseIntf25) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_26, FBaseIntf26) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2_27, FBaseIntf27);
end;

destructor TCoreWebView2.Destroy;
begin
  try
    RemoveAllEvents;

    if (FDevToolsEventTokens <> nil) then
      begin
        Finalize(FDevToolsEventTokens);
        FDevToolsEventTokens := nil;
      end;

    if (FDevToolsEventNames <> nil) then
      FreeAndNil(FDevToolsEventNames);

    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2.AfterConstruction;
begin
  inherited AfterConstruction;

  FDevToolsEventNames := TStringList.Create;
end;

procedure TCoreWebView2.InitializeFields;
begin
  FBaseIntf            := nil;
  FBaseIntf2           := nil;
  FBaseIntf3           := nil;
  FBaseIntf4           := nil;
  FBaseIntf5           := nil;
  FBaseIntf6           := nil;
  FBaseIntf7           := nil;
  FBaseIntf8           := nil;
  FBaseIntf9           := nil;
  FBaseIntf10          := nil;
  FBaseIntf11          := nil;
  FBaseIntf12          := nil;
  FBaseIntf13          := nil;
  FBaseIntf14          := nil;
  FBaseIntf15          := nil;
  FBaseIntf16          := nil;
  FBaseIntf17          := nil;
  FBaseIntf18          := nil;
  FBaseIntf19          := nil;
  FBaseIntf20          := nil;
  FBaseIntf21          := nil;
  FBaseIntf22          := nil;
  FBaseIntf23          := nil;
  FBaseIntf24          := nil;
  FBaseIntf25          := nil;
  FBaseIntf26          := nil;
  FBaseIntf27          := nil;
  FDevToolsEventTokens := nil;
  FDevToolsEventNames  := nil;
  FFrameIDCopy         := WEBVIEW4DELPHI_INVALID_FRAMEID;

  InitializeTokens;
end;

procedure TCoreWebView2.InitializeTokens;
begin
  FContainsFullScreenElementChangedToken.value   := 0;
  FContentLoadingToken.value                     := 0;
  FDocumentTitleChangedToken.value               := 0;
  FFrameNavigationStartingToken.value            := 0;
  FFrameNavigationCompletedToken.value           := 0;
  FHistoryChangedToken.value                     := 0;
  FNavigationStartingToken.value                 := 0;
  FNavigationCompletedToken.value                := 0;
  FNewWindowRequestedToken.value                 := 0;
  FPermissionRequestedToken.value                := 0;
  FProcessFailedToken.value                      := 0;
  FScriptDialogOpeningToken.value                := 0;
  FSourceChangedToken.value                      := 0;
  FWebResourceRequestedToken.value               := 0;
  FWebMessageReceivedToken.value                 := 0;
  FWindowCloseRequestedToken.value               := 0;
  FWebResourceResponseReceivedToken.value        := 0;
  FDOMContentLoadedToken.value                   := 0;
  FFrameCreatedToken.value                       := 0;
  FDownloadStartingToken.value                   := 0;
  FClientCertificateRequestedToken.value         := 0;
  FIsMutedChangedToken.value                     := 0;
  FIsDocumentPlayingAudioChangedToken.value      := 0;
  FIsDefaultDownloadDialogOpenChangedToken.value := 0;
  FBasicAuthenticationRequestedToken.value       := 0;
  FContextMenuRequestedToken.value               := 0;
  FStatusBarTextChangedToken.value               := 0;
  FServerCertificateErrorDetectedToken.value     := 0;
  FFaviconChangedToken.value                     := 0;
  FLaunchingExternalUriSchemeToken.value         := 0;
  FNotificationReceivedToken.value               := 0;
  FSaveAsUIShowingToken.value                    := 0;
  FSaveFileSecurityCheckStartingToken.value      := 0;
  FScreenCaptureStartingToken.value              := 0;
end;

function TCoreWebView2.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

procedure TCoreWebView2.RemoveAllEvents;
begin
  try
    try
      if Initialized then
        begin
          if (FNavigationStartingToken.value <> 0) then
            FBaseIntf.remove_NavigationStarting(FNavigationStartingToken);

          if (FNavigationCompletedToken.value <> 0) then
            FBaseIntf.remove_NavigationCompleted(FNavigationCompletedToken);

          if (FSourceChangedToken.value <> 0) then
            FBaseIntf.remove_SourceChanged(FSourceChangedToken);

          if (FHistoryChangedToken.value <> 0) then
            FBaseIntf.remove_HistoryChanged(FHistoryChangedToken);

          if (FContentLoadingToken.value <> 0) then
            FBaseIntf.remove_ContentLoading(FContentLoadingToken);

          if (FDocumentTitleChangedToken.value <> 0) then
            FBaseIntf.remove_DocumentTitleChanged(FDocumentTitleChangedToken);

          if (FNewWindowRequestedToken.value <> 0) then
            FBaseIntf.remove_NewWindowRequested(FNewWindowRequestedToken);

          if (FFrameNavigationStartingToken.value <> 0) then
            FBaseIntf.remove_FrameNavigationStarting(FFrameNavigationStartingToken);

          if (FFrameNavigationCompletedToken.value <> 0) then
            FBaseIntf.remove_FrameNavigationCompleted(FFrameNavigationCompletedToken);

          if (FWebResourceRequestedToken.value <> 0) then
            FBaseIntf.remove_WebResourceRequested(FWebResourceRequestedToken);

          if (FScriptDialogOpeningToken.value <> 0) then
            FBaseIntf.remove_ScriptDialogOpening(FScriptDialogOpeningToken);

          if (FPermissionRequestedToken.value <> 0) then
            FBaseIntf.remove_PermissionRequested(FPermissionRequestedToken);

          if (FProcessFailedToken.value <> 0) then
            FBaseIntf.remove_ProcessFailed(FProcessFailedToken);

          if (FWebMessageReceivedToken.value <> 0) then
            FBaseIntf.remove_WebMessageReceived(FWebMessageReceivedToken);

          if (FWindowCloseRequestedToken.value <> 0) then
            FBaseIntf.remove_WindowCloseRequested(FWindowCloseRequestedToken);

          if (FContainsFullScreenElementChangedToken.value <> 0) then
            FBaseIntf.remove_ContainsFullScreenElementChanged(FContainsFullScreenElementChangedToken);

          if assigned(FBaseIntf2) then
            begin
              if (FWebResourceResponseReceivedToken.value <> 0) then
                FBaseIntf2.remove_WebResourceResponseReceived(FWebResourceResponseReceivedToken);

              if (FDOMContentLoadedToken.value <> 0) then
                FBaseIntf2.remove_DOMContentLoaded(FDOMContentLoadedToken);
            end;

          if assigned(FBaseIntf4) then
            begin
              if (FFrameCreatedToken.value <> 0) then
                FBaseIntf4.remove_FrameCreated(FFrameCreatedToken);

              if (FDownloadStartingToken.value <> 0) then
                FBaseIntf4.remove_DownloadStarting(FDownloadStartingToken);
            end;

//          Access violation when we try to remove this event
//          if assigned(FBaseIntf5) and
//             (FClientCertificateRequestedToken.value <> 0) then
//            FBaseIntf5.remove_ClientCertificateRequested(FClientCertificateRequestedToken);

          if assigned(FBaseIntf8) then
            begin
              if (FIsMutedChangedToken.value <> 0) then
                FBaseIntf8.remove_IsMutedChanged(FIsMutedChangedToken);

              if (FIsDocumentPlayingAudioChangedToken.value <> 0) then
                FBaseIntf8.remove_IsDocumentPlayingAudioChanged(FIsDocumentPlayingAudioChangedToken);
            end;

          if assigned(FBaseIntf9) and
             (FIsDefaultDownloadDialogOpenChangedToken.value <> 0) then
            FBaseIntf9.remove_IsDefaultDownloadDialogOpenChanged(FIsDefaultDownloadDialogOpenChangedToken);

          if assigned(FBaseIntf10) and
             (FBasicAuthenticationRequestedToken.Value <> 0) then
            FBaseIntf10.remove_BasicAuthenticationRequested(FBasicAuthenticationRequestedToken);

          if assigned(FBaseIntf11) and
             (FContextMenuRequestedToken.Value <> 0) then
            FBaseIntf11.remove_ContextMenuRequested(FContextMenuRequestedToken);

          if assigned(FBaseIntf12) and
             (FStatusBarTextChangedToken.Value <> 0) then
            FBaseIntf12.remove_StatusBarTextChanged(FStatusBarTextChangedToken);

//          Access violation when we try to remove this event
//          if assigned(FBaseIntf14) and
//             (FServerCertificateErrorDetectedToken.Value <> 0) then
//            FBaseIntf14.remove_ServerCertificateErrorDetected(FServerCertificateErrorDetectedToken);

          if assigned(FBaseIntf15) and
             (FFaviconChangedToken.Value <> 0) then
            FBaseIntf15.remove_FaviconChanged(FFaviconChangedToken);

          if assigned(FBaseIntf18) and
             (FLaunchingExternalUriSchemeToken.Value <> 0) then
            FBaseIntf18.remove_LaunchingExternalUriScheme(FLaunchingExternalUriSchemeToken);

          if assigned(FBaseIntf24) and
             (FNotificationReceivedToken.value <> 0) then
            FBaseIntf24.remove_NotificationReceived(FNotificationReceivedToken);

          if assigned(FBaseIntf25) and
             (FSaveAsUIShowingToken.value <> 0) then
            FBaseIntf25.remove_SaveAsUIShowing(FSaveAsUIShowingToken);

          if assigned(FBaseIntf26) and
             (FSaveFileSecurityCheckStartingToken.value <> 0) then
            FBaseIntf26.remove_SaveFileSecurityCheckStarting(FSaveFileSecurityCheckStartingToken);

          if assigned(FBaseIntf27) and
             (FScreenCaptureStartingToken.value <> 0) then
            FBaseIntf27.remove_ScreenCaptureStarting(FScreenCaptureStartingToken);

          UnsubscribeAllDevToolsProtocolEvents;
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TCoreWebView2.RemoveAllEvents', e) then raise;
    end;
  finally
    InitializeTokens;
  end;
end;

function TCoreWebView2.AddNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationStartingEventHandler;
begin
  Result := False;

  if Initialized and (FNavigationStartingToken.value = 0) then
    try
      TempHandler := TCoreWebView2NavigationStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_NavigationStarting(TempHandler, FNavigationStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationCompletedEventHandler;
begin
  Result := False;

  if Initialized and (FNavigationCompletedToken.value = 0) then
    try
      TempHandler := TCoreWebView2NavigationCompletedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_NavigationCompleted(TempHandler, FNavigationCompletedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddSourceChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2SourceChangedEventHandler;
begin
  Result := False;

  if Initialized and (FSourceChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2SourceChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_SourceChanged(TempHandler, FSourceChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddHistoryChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2HistoryChangedEventHandler;
begin
  Result := False;

  if Initialized and (FHistoryChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2HistoryChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_HistoryChanged(TempHandler, FHistoryChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ContentLoadingEventHandler;
begin
  Result := False;

  if Initialized and (FContentLoadingToken.value = 0) then
    try
      TempHandler := TCoreWebView2ContentLoadingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ContentLoading(TempHandler, FContentLoadingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddDocumentTitleChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2DocumentTitleChangedEventHandler;
begin
  Result := False;

  if Initialized and (FDocumentTitleChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2DocumentTitleChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_DocumentTitleChanged(TempHandler, FDocumentTitleChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddNewWindowRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NewWindowRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FNewWindowRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2NewWindowRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_NewWindowRequested(TempHandler, FNewWindowRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationStartingEventHandler;
begin
  Result := False;

  if Initialized and (FFrameNavigationStartingToken.value  = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_FrameNavigationStarting(TempHandler, FFrameNavigationStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NavigationCompletedEventHandler;
begin
  Result := False;

  if Initialized and (FFrameNavigationCompletedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationCompletedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_FrameNavigationCompleted(TempHandler, FFrameNavigationCompletedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWebResourceRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WebResourceRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FWebResourceRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WebResourceRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_WebResourceRequested(TempHandler, FWebResourceRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddScriptDialogOpeningEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ScriptDialogOpeningEventHandler;
begin
  Result := False;

  if Initialized and (FScriptDialogOpeningToken.value = 0) then
    try
      TempHandler := TCoreWebView2ScriptDialogOpeningEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ScriptDialogOpening(TempHandler, FScriptDialogOpeningToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2PermissionRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FPermissionRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2PermissionRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_PermissionRequested(TempHandler, FPermissionRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddProcessFailedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ProcessFailedEventHandler;
begin
  Result := False;

  if Initialized and (FProcessFailedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ProcessFailedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ProcessFailed(TempHandler, FProcessFailedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WebMessageReceivedEventHandler;
begin
  Result := False;

  if Initialized and (FWebMessageReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WebMessageReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_WebMessageReceived(TempHandler, FWebMessageReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddContainsFullScreenElementChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ContainsFullScreenElementChangedEventHandler;
begin
  Result := False;

  if Initialized and (FContainsFullScreenElementChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ContainsFullScreenElementChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ContainsFullScreenElementChanged(TempHandler, FContainsFullScreenElementChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWindowCloseRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WindowCloseRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FWindowCloseRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WindowCloseRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_WindowCloseRequested(TempHandler, FWindowCloseRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWebResourceResponseReceivedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2WebResourceResponseReceivedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FWebResourceResponseReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2WebResourceResponseReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf2.add_WebResourceResponseReceived(TempHandler, FWebResourceResponseReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2DOMContentLoadedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FDOMContentLoadedToken.value = 0) then
    try
      TempHandler := TCoreWebView2DOMContentLoadedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf2.add_DOMContentLoaded(TempHandler, FDOMContentLoadedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFrameCreatedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameCreatedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf4) and (FFrameCreatedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameCreatedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf4.add_FrameCreated(TempHandler, FFrameCreatedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddDownloadStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2DownloadStartingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf4) and (FDownloadStartingToken.value = 0) then
    try
      TempHandler := TCoreWebView2DownloadStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf4.add_DownloadStarting(TempHandler, FDownloadStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddClientCertificateRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ClientCertificateRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf5) and (FClientCertificateRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ClientCertificateRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf5.add_ClientCertificateRequested(TempHandler, FClientCertificateRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddIsMutedChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2IsMutedChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FIsMutedChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2IsMutedChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf8.add_IsMutedChanged(TempHandler, FIsMutedChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddIsDocumentPlayingAudioChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2IsDocumentPlayingAudioChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FIsDocumentPlayingAudioChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2IsDocumentPlayingAudioChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf8.add_IsDocumentPlayingAudioChanged(TempHandler, FIsDocumentPlayingAudioChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddIsDefaultDownloadDialogOpenChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf9) and (FIsDefaultDownloadDialogOpenChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf9.add_IsDefaultDownloadDialogOpenChanged(TempHandler, FIsDefaultDownloadDialogOpenChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddBasicAuthenticationRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BasicAuthenticationRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf10) and (FBasicAuthenticationRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2BasicAuthenticationRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf10.add_BasicAuthenticationRequested(TempHandler, FBasicAuthenticationRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddContextMenuRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ContextMenuRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf11) and (FContextMenuRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ContextMenuRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf11.add_ContextMenuRequested(TempHandler, FContextMenuRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddStatusBarTextChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2StatusBarTextChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf12) and (FStatusBarTextChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2StatusBarTextChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf12.add_StatusBarTextChanged(TempHandler, FStatusBarTextChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddServerCertificateErrorDetectedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ServerCertificateErrorDetectedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf14) and (FServerCertificateErrorDetectedToken.value = 0) then
    try
      TempHandler := TCoreWebView2ServerCertificateErrorDetectedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf14.add_ServerCertificateErrorDetected(TempHandler, FServerCertificateErrorDetectedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddFaviconChanged(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FaviconChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf15) and (FFaviconChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FaviconChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf15.add_FaviconChanged(TempHandler, FFaviconChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddLaunchingExternalUriScheme(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2LaunchingExternalUriSchemeEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf18) and (FLaunchingExternalUriSchemeToken.value = 0) then
    try
      TempHandler := TCoreWebView2LaunchingExternalUriSchemeEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf18.add_LaunchingExternalUriScheme(TempHandler, FLaunchingExternalUriSchemeToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddNotificationReceived(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NotificationReceivedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf24) and (FNotificationReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2NotificationReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf24.add_NotificationReceived(TempHandler, FNotificationReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddSaveAsUIShowing(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2SaveAsUIShowingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf25) and (FSaveAsUIShowingToken.value = 0) then
    try
      TempHandler := TCoreWebView2SaveAsUIShowingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf25.add_SaveAsUIShowing(TempHandler, FSaveAsUIShowingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddSaveFileSecurityCheckStarting(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2SaveFileSecurityCheckStartingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf26) and (FSaveFileSecurityCheckStartingToken.value = 0) then
    try
      TempHandler := TCoreWebView2SaveFileSecurityCheckStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf26.add_SaveFileSecurityCheckStarting(TempHandler, FSaveFileSecurityCheckStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddScreenCaptureStarting(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ScreenCaptureStartingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf27) and (FScreenCaptureStartingToken.value = 0) then
    try
      TempHandler := TCoreWebView2ScreenCaptureStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf27.add_ScreenCaptureStarting(TempHandler, FScreenCaptureStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddNavigationStartingEvent(aBrowserComponent)                 and
            AddNavigationCompletedEvent(aBrowserComponent)                and
            AddSourceChangedEvent(aBrowserComponent)                      and
            AddHistoryChangedEvent(aBrowserComponent)                     and
            AddContentLoadingEvent(aBrowserComponent)                     and
            AddDocumentTitleChangedEvent(aBrowserComponent)               and
            AddNewWindowRequestedEvent(aBrowserComponent)                 and
            AddFrameNavigationStartingEvent(aBrowserComponent)            and
            AddFrameNavigationCompletedEvent(aBrowserComponent)           and
            AddWebResourceRequestedEvent(aBrowserComponent)               and
            AddScriptDialogOpeningEvent(aBrowserComponent)                and
            AddPermissionRequestedEvent(aBrowserComponent)                and
            AddProcessFailedEvent(aBrowserComponent)                      and
            AddWebMessageReceivedEvent(aBrowserComponent)                 and
            AddContainsFullScreenElementChangedEvent(aBrowserComponent)   and
            AddWindowCloseRequestedEvent(aBrowserComponent)               and
            AddWebResourceResponseReceivedEvent(aBrowserComponent)        and
            AddDOMContentLoadedEvent(aBrowserComponent)                   and
            AddFrameCreatedEvent(aBrowserComponent)                       and
            AddDownloadStartingEvent(aBrowserComponent)                   and
            AddClientCertificateRequestedEvent(aBrowserComponent)         and
            AddIsMutedChangedEvent(aBrowserComponent)                     and
            AddIsDocumentPlayingAudioChangedEvent(aBrowserComponent)      and
            AddIsDefaultDownloadDialogOpenChangedEvent(aBrowserComponent) and
            AddBasicAuthenticationRequestedEvent(aBrowserComponent)       and
            AddContextMenuRequestedEvent(aBrowserComponent)               and
            AddStatusBarTextChangedEvent(aBrowserComponent)               and
            AddServerCertificateErrorDetectedEvent(aBrowserComponent)     and
            AddFaviconChanged(aBrowserComponent)                          and
            AddLaunchingExternalUriScheme(aBrowserComponent)              and
            AddNotificationReceived(aBrowserComponent)                    and
            AddSaveAsUIShowing(aBrowserComponent)                         and
            AddSaveFileSecurityCheckStarting(aBrowserComponent)           and
            AddScreenCaptureStarting(aBrowserComponent);
end;

function TCoreWebView2.AddWebResourceRequestedFilter(const URI             : wvstring;
                                                           ResourceContext : TWVWebResourceContext) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.AddWebResourceRequestedFilter(PWideChar(URI), ResourceContext));
end;

function TCoreWebView2.RemoveWebResourceRequestedFilter(const URI             : wvstring;
                                                              ResourceContext : TWVWebResourceContext) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveWebResourceRequestedFilter(PWideChar(URI), ResourceContext));
end;

function TCoreWebView2.CapturePreview(      aImageFormat      : TWVCapturePreviewImageFormat;
                                      const aImageStream      : IStream;
                                      const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2CapturePreviewCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2CapturePreviewCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.CapturePreview(aImageFormat, aImageStream, TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.SubscribeToDevToolsProtocolEvent(const aEventName        : wvstring;
                                                              aEventID          : integer;
                                                        const aBrowserComponent : TComponent) : boolean;
var
  TempReceiver : ICoreWebView2DevToolsProtocolEventReceiver;
  TempHandler  : ICoreWebView2DevToolsProtocolEventReceivedEventHandler;
  TempToken    : EventRegistrationToken;
  i            : integer;
begin
  Result := False;

  if Initialized and
     (FDevToolsEventNames <> nil) and
     {$IFDEF FPC}
     (FDevToolsEventNames.IndexOf(UTF8Encode(aEventName)) < 0) and
     {$ELSE}      
     (FDevToolsEventNames.IndexOf(aEventName) < 0) and
     {$ENDIF}
     succeeded(FBaseIntf.GetDevToolsProtocolEventReceiver(PWideChar(aEventName), TempReceiver)) then
    try
      TempHandler := TCoreWebView2DevToolsProtocolEventReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent), aEventName, aEventID);

      if succeeded(TempReceiver.add_DevToolsProtocolEventReceived(TempHandler, TempToken)) then
        begin
          {$IFDEF FPC}
          FDevToolsEventNames.Add(UTF8Encode(aEventName));
          {$ELSE}
          FDevToolsEventNames.Add(aEventName);
          {$ENDIF}
          i := length(FDevToolsEventTokens);
          SetLength(FDevToolsEventTokens, succ(i));
          FDevToolsEventTokens[i] := TempToken;
          Result := True;
        end;
    finally
      TempHandler := nil;
    end;
end;

procedure TCoreWebView2.UnsubscribeAllDevToolsProtocolEvents;
var
  TempReceiver  : ICoreWebView2DevToolsProtocolEventReceiver;
  i             : integer;
  TempEventName : wvstring;
begin
  if (FDevToolsEventNames = nil) or (FDevToolsEventNames.Count = 0) or not(Initialized) then
    exit;

  try
    try
      i := pred(FDevToolsEventNames.Count);

      while (i >= 0) do
        begin
          {$IFDEF FPC}
          TempEventName := UTF8Decode(FDevToolsEventNames[i]);
          {$ELSE}
          TempEventName := FDevToolsEventNames[i];
          {$ENDIF}
          if succeeded(FBaseIntf.GetDevToolsProtocolEventReceiver(PWideChar(TempEventName), TempReceiver)) then
            TempReceiver.remove_DevToolsProtocolEventReceived(FDevToolsEventTokens[i]);

          dec(i);
        end;
    except
      on e : exception do
        if CustomExceptionHandler('TCoreWebView2.UnsubscribeAllDevToolsProtocolEvents', e) then raise;
    end;
  finally
    FDevToolsEventNames.Clear;
    SetLength(FDevToolsEventTokens, 0);
  end;
end;

function TCoreWebView2.ExecuteScript(const JavaScript: wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ExecuteScriptCompletedHandler;
begin
  Result := False;

  if Initialized and (length(JavaScript) > 0) then
    try
      TempHandler := TCoreWebView2ExecuteScriptCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf.ExecuteScript(PWideChar(JavaScript), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.GoBack : boolean;
begin
  Result := CanGoBack and
            succeeded(FBaseIntf.GoBack);
end;

function TCoreWebView2.GoForward : boolean;
begin
  Result := CanGoForward and
            succeeded(FBaseIntf.GoForward);
end;

function TCoreWebView2.Navigate(const aURI : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Navigate(PWideChar(aURI)));
end;

function TCoreWebView2.NavigateToString(const aHTMLContent : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.NavigateToString(PWideChar(aHTMLContent)));
end;

function TCoreWebView2.NavigateWithWebResourceRequest(const aRequest : ICoreWebView2WebResourceRequest) : boolean;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.NavigateWithWebResourceRequest(aRequest));
end;

function TCoreWebView2.Reload : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Reload);
end;

function TCoreWebView2.Stop : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Stop);
end;

function TCoreWebView2.TrySuspend(const aHandler: ICoreWebView2TrySuspendCompletedHandler) : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.TrySuspend(aHandler));
end;

function TCoreWebView2.Resume : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Resume);
end;

function TCoreWebView2.SetVirtualHostNameToFolderMapping(const aHostName, aFolderPath : wvstring; aAccessKind : TWVHostResourceAcccessKind): boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.SetVirtualHostNameToFolderMapping(PWideChar(aHostName), PWideChar(aFolderPath), aAccessKind));
end;

function TCoreWebView2.ClearVirtualHostNameToFolderMapping(const aHostName : wvstring) : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.ClearVirtualHostNameToFolderMapping(PWideChar(aHostName)));
end;

function TCoreWebView2.OpenTaskManagerWindow : boolean;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.OpenTaskManagerWindow);
end;

function TCoreWebView2.PrintToPdf(const aResultFilePath : wvstring;
                                  const aPrintSettings  : ICoreWebView2PrintSettings;
                                  const aHandler        : ICoreWebView2PrintToPdfCompletedHandler) : boolean;
begin
  Result := False;

  if assigned(FBaseIntf7)          and
     (length(aResultFilePath) > 0) and
     assigned(aPrintSettings)      and
     assigned(aHandler)            then
    Result := succeeded(FBaseIntf7.PrintToPdf(PWideChar(aResultFilePath), aPrintSettings, aHandler));
end;

function TCoreWebView2.OpenDevToolsWindow : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.OpenDevToolsWindow);
end;

function TCoreWebView2.PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.PostWebMessageAsJson(PWideChar(aWebMessageAsJson)));
end;

function TCoreWebView2.PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.PostWebMessageAsString(PWideChar(aWebMessageAsString)));
end;

function TCoreWebView2.CallDevToolsProtocolMethod(const aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2CallDevToolsProtocolMethodCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf.CallDevToolsProtocolMethod(PWideChar(aMethodName), PWideChar(aParametersAsJson), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.CallDevToolsProtocolMethodForSession(const aSessionId, aMethodName, aParametersAsJson : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2CallDevToolsProtocolMethodCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf11) then
    try
      TempHandler := TCoreWebView2CallDevToolsProtocolMethodCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf11.CallDevToolsProtocolMethodForSession(PWideChar(aSessionId), PWideChar(aMethodName), PWideChar(aParametersAsJson), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddHostObjectToScript(const aName : wvstring; const aObject : OleVariant) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.AddHostObjectToScript(PWideChar(aName), aObject));
end;

function TCoreWebView2.RemoveHostObjectFromScript(const aName : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveHostObjectFromScript(PWideChar(aName)));
end;

function TCoreWebView2.AddScriptToExecuteOnDocumentCreated(const JavaScript : wvstring; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.AddScriptToExecuteOnDocumentCreated(PWideChar(JavaScript), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.RemoveScriptToExecuteOnDocumentCreated(const aID : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveScriptToExecuteOnDocumentCreated(PWideChar(aID)));
end;

function TCoreWebView2.OpenDefaultDownloadDialog : boolean;
begin
  Result := assigned(FBaseIntf9) and
            succeeded(FBaseIntf9.OpenDefaultDownloadDialog);
end;

function TCoreWebView2.CloseDefaultDownloadDialog : boolean;
begin
  Result := assigned(FBaseIntf9) and
            succeeded(FBaseIntf9.CloseDefaultDownloadDialog);
end;

function TCoreWebView2.ClearServerCertificateErrorActions(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf14) then
    try
      TempHandler := TCoreWebView2ClearServerCertificateErrorActionsCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf14.ClearServerCertificateErrorActions(TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.GetFavicon(aFormat: TWVFaviconImageFormat; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2GetFaviconCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf15) then
    try
      TempHandler := TCoreWebView2GetFaviconCompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf15.GetFavicon(aFormat, TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.Print(const aPrintSettings : ICoreWebView2PrintSettings;
                             const aHandler       : ICoreWebView2PrintCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf16) and
            succeeded(FBaseIntf16.Print(aPrintSettings, aHandler));
end;

function TCoreWebView2.ShowPrintUI(aPrintDialogKind: TWVPrintDialogKind): boolean;
begin
  Result := assigned(FBaseIntf16) and
            succeeded(FBaseIntf16.ShowPrintUI(aPrintDialogKind));
end;

function TCoreWebView2.PrintToPdfStream(const aPrintSettings : ICoreWebView2PrintSettings;
                                        const aHandler       : ICoreWebView2PrintToPdfStreamCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf16) and
            succeeded(FBaseIntf16.PrintToPdfStream(aPrintSettings, aHandler));
end;

function TCoreWebView2.PostSharedBufferToScript(const aSharedBuffer         : ICoreWebView2SharedBuffer;
                                                      aAccess               : TWVSharedBufferAccess;
                                                const aAdditionalDataAsJson : wvstring): boolean;
begin
  Result := assigned(FBaseIntf17) and
            succeeded(FBaseIntf17.PostSharedBufferToScript(aSharedBuffer, aAccess, PWideChar(aAdditionalDataAsJson)));
end;

function TCoreWebView2.ExecuteScriptWithResult(const JavaScript: wvstring; aExecutionID : integer; const aBrowserComponent : TComponent): boolean;
var
  TempHandler : ICoreWebView2ExecuteScriptWithResultCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf21) then
    try
      TempHandler := TCoreWebView2ExecuteScriptWithResultCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf21.ExecuteScriptWithResult(PWideChar(JavaScript), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.AddWebResourceRequestedFilterWithRequestSourceKinds(const uri                : wvstring;
                                                                                 ResourceContext    : TWVWebResourceContext;
                                                                                 requestSourceKinds : TWVWebResourceRequestSourceKind): boolean;
begin
  Result := assigned(FBaseIntf22) and
            succeeded(FBaseIntf22.AddWebResourceRequestedFilterWithRequestSourceKinds(PWideChar(uri), ResourceContext, requestSourceKinds));
end;

function TCoreWebView2.RemoveWebResourceRequestedFilterWithRequestSourceKinds(const uri                : wvstring;
                                                                                    ResourceContext    : TWVWebResourceContext;
                                                                                    requestSourceKinds : TWVWebResourceRequestSourceKind): boolean;
begin
  Result := assigned(FBaseIntf22) and
            succeeded(FBaseIntf22.RemoveWebResourceRequestedFilterWithRequestSourceKinds(PWideChar(uri), ResourceContext, requestSourceKinds));
end;

function TCoreWebView2.PostWebMessageAsJsonWithAdditionalObjects(const webMessageAsJson  : wvstring;
                                                                 const additionalObjects : ICoreWebView2ObjectCollectionView): boolean;
begin
  Result := assigned(FBaseIntf23) and
            succeeded(FBaseIntf23.PostWebMessageAsJsonWithAdditionalObjects(PWideChar(webMessageAsJson), additionalObjects));
end;

function TCoreWebView2.ShowSaveAsUI(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ShowSaveAsUICompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf25) then
    try
      TempHandler := TCoreWebView2ShowSaveAsUICompletedHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf25.ShowSaveAsUI(TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2.GetBrowserProcessID : cardinal;
var
  TempID : DWORD;
begin
  if Initialized and succeeded(FBaseIntf.Get_BrowserProcessId(TempID)) then
    Result := TempID
   else
    Result := 0;
end;

function TCoreWebView2.GetCanGoBack : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_CanGoBack(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2.GetCanGoForward : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_CanGoForward(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2.GetContainsFullScreenElement : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ContainsFullScreenElement(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2.GetDocumentTitle : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.get_DocumentTitle(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2.GetSource : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.get_Source(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2.GetCookieManager : ICoreWebView2CookieManager;
var
  TempResult : ICoreWebView2CookieManager;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_CookieManager(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetEnvironment : ICoreWebView2Environment;
var
  TempResult : ICoreWebView2Environment;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_Environment(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetIsSuspended : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Get_IsSuspended(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetSettings : ICoreWebView2Settings;
var
  TempResult : ICoreWebView2Settings;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_Settings(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetIsMuted : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf8) and
            succeeded(FBaseIntf8.Get_IsMuted(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetIsDocumentPlayingAudio : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf8) and
            succeeded(FBaseIntf8.Get_IsDocumentPlayingAudio(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetIsDefaultDownloadDialogOpen : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf9) and
            succeeded(FBaseIntf9.Get_IsDefaultDownloadDialogOpen(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2.GetDefaultDownloadDialogCornerAlignment : TWVDefaultDownloadDialogCornerAlignment;
var
  TempResult : COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT;
begin
  if assigned(FBaseIntf9) and
     succeeded(FBaseIntf9.Get_DefaultDownloadDialogCornerAlignment(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2.GetDefaultDownloadDialogMargin : TPoint;
var
  TempResult : tagPOINT;
begin
  if assigned(FBaseIntf9) and
     succeeded(FBaseIntf9.Get_DefaultDownloadDialogMargin(TempResult)) then
    Result := TPoint(TempResult)
   else
    Result := point(0, 0);
end;

function TCoreWebView2.GetStatusBarText : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf12) and
     succeeded(FBaseIntf12.Get_StatusBarText(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2.GetProfile : ICoreWebView2Profile;
var
  TempResult : ICoreWebView2Profile;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf13) and
     succeeded(FBaseIntf13.Get_Profile(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2.GetFaviconURI : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf15) and
     succeeded(FBaseIntf15.Get_FaviconUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2.GetMemoryUsageTargetLevel : TWVMemoryUsageTargetLevel;
var
  TempResult : COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL;
begin
  if assigned(FBaseIntf19) and
     succeeded(FBaseIntf19.Get_MemoryUsageTargetLevel(TempResult)) then
    Result := TempResult
   else
    Result := COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_NORMAL;
end;

function TCoreWebView2.GetFrameID : cardinal;
var
  TempResult : SYSUINT;
begin
  if assigned(FBaseIntf20) and
     succeeded(FBaseIntf20.Get_FrameId(TempResult)) then
    begin
      Result       := TempResult;
      FFrameIDCopy := TempResult;
    end
   else
    Result := FFrameIDCopy;
end;

procedure TCoreWebView2.SetIsMuted(aValue : boolean);
begin
  if assigned(FBaseIntf8) then
    FBaseIntf8.Set_IsMuted(ord(aValue));
end;

procedure TCoreWebView2.SetDefaultDownloadDialogCornerAlignment(aValue : TWVDefaultDownloadDialogCornerAlignment);
begin
  if assigned(FBaseIntf9) then
    FBaseIntf9.Set_DefaultDownloadDialogCornerAlignment(aValue);
end;

procedure TCoreWebView2.SetDefaultDownloadDialogMargin(aValue : TPoint);
begin
  if assigned(FBaseIntf9) then
    FBaseIntf9.Set_DefaultDownloadDialogMargin(tagPOINT(aValue));
end;

procedure TCoreWebView2.SetMemoryUsageTargetLevel(aValue : TWVMemoryUsageTargetLevel);
begin
  if assigned(FBaseIntf19) then
    FBaseIntf19.Set_MemoryUsageTargetLevel(aValue);
end;

end.
