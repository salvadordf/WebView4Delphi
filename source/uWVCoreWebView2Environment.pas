unit uWVCoreWebView2Environment;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows, System.Classes, System.Types, Winapi.ActiveX, System.SysUtils,
  {$ELSE}
  Windows, Classes, ActiveX, SysUtils,
  {$ENDIF}
  uWVInterfaces, uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Represents the WebView2 Environment.  WebViews created from an environment
  /// run on the browser process specified with environment parameters and
  /// objects created from an environment should be used in the same
  /// environment.  Using it in different environments are not guaranteed to be
  ///  compatible and may fail.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment">See the ICoreWebView2Environment article.</see></para>
  /// </remarks>
  TCoreWebView2Environment = class
    protected
      FBaseIntf                             : ICoreWebView2Environment;
      FBaseIntf2                            : ICoreWebView2Environment2;
      FBaseIntf3                            : ICoreWebView2Environment3;
      FBaseIntf4                            : ICoreWebView2Environment4;
      FBaseIntf5                            : ICoreWebView2Environment5;
      FBaseIntf6                            : ICoreWebView2Environment6;
      FBaseIntf7                            : ICoreWebView2Environment7;
      FBaseIntf8                            : ICoreWebView2Environment8;
      FBaseIntf9                            : ICoreWebView2Environment9;
      FBaseIntf10                           : ICoreWebView2Environment10;
      FBaseIntf11                           : ICoreWebView2Environment11;
      FBaseIntf12                           : ICoreWebView2Environment12;
      FBaseIntf13                           : ICoreWebView2Environment13;
      FBaseIntf14                           : ICoreWebView2Environment14;
      FNewBrowserVersionAvailableEventToken : EventRegistrationToken;
      FBrowserProcessExitedEventToken       : EventRegistrationToken;
      FProcessInfosChangedEventToken        : EventRegistrationToken;

      function  GetInitialized : boolean;
      function  GetBrowserVersionInfo : wvstring;
      function  GetSupportsCompositionController : boolean;
      function  GetSupportsControllerOptions : boolean;
      function  GetUserDataFolder : wvstring;
      function  GetProcessInfos : ICoreWebView2ProcessInfoCollection;
      function  GetFailureReportFolderPath : wvstring;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddNewBrowserVersionAvailableEvent(const aLoaderComponent : TComponent) : boolean;
      function  AddBrowserProcessExitedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
      function  AddBrowserProcessExitedBrowserEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddProcessInfosChangedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
      function  AddProcessInfosChangedBrowserEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Environment); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVLoader instance.
      /// </summary>
      /// <param name="aLoaderComponent">The TWVLoader instance.</param>
      function    AddAllLoaderEvents(const aLoaderComponent : TComponent) : boolean;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Asynchronously create a new WebView.
      /// </summary>
      /// <param name="aParentWindow">Handle of the control in which the WebView should be displayed.</param>
      /// <param name="aBrowserEvents">The TWVBrowserBase instance that will receive all the events.</param>
      /// <param name="aResult">Result code.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment#createcorewebview2controller">See the ICoreWebView2Environment article.</see></para>
      /// </remarks>
      function    CreateCoreWebView2Controller(aParentWindow : THandle; const aBrowserEvents : IWVBrowserEvents; var aResult: HRESULT) : boolean;
      /// <summary>
      /// Create a new web resource response object.
      /// </summary>
      /// <param name="aContent">HTTP response content as stream.</param>
      /// <param name="aStatusCode">The HTTP response status code.</param>
      /// <param name="aReasonPhrase">The HTTP response reason phrase.</param>
      /// <param name="aHeaders">Overridden HTTP response headers.</param>
      /// <param name="aResponse">The new ICoreWebView2WebResourceResponse instance.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment#createcorewebview2controller">See the ICoreWebView2Environment article.</see></para>
      /// </remarks>
      function    CreateWebResourceResponse(const aContent : IStream; aStatusCode : integer; aReasonPhrase, aHeaders : wvstring; var aResponse : ICoreWebView2WebResourceResponse) : boolean;
      /// <summary>
      /// Create a new web resource request object.
      /// URI parameter must be absolute URI.
      /// The headers string is the raw request header string delimited by CRLF
      /// (optional in last header).
      /// It's also possible to create this object with null headers string
      /// and then use the ICoreWebView2HttpRequestHeaders to construct the headers
      /// line by line.
      /// </summary>
      /// <param name="aURI">The request URI.</param>
      /// <param name="aMethod">The HTTP request method.</param>
      /// <param name="aPostData">The HTTP request message body as stream.</param>
      /// <param name="aHeaders">The mutable HTTP request headers.</param>
      /// <param name="aRequest">The new ICoreWebView2WebResourceRequest instance.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment2#createwebresourcerequest">See the ICoreWebView2Environment2 article.</see></para>
      /// </remarks>
      function    CreateWebResourceRequest(const aURI, aMethod : wvstring; const aPostData : IStream; const aHeaders : wvstring; var aRequest : ICoreWebView2WebResourceRequest): boolean;
      /// <summary>
      /// Asynchronously create a new WebView for use with visual hosting.
      /// </summary>
      /// <param name="aParentWindow">Handle of the control in which the app will connect the visual tree of the WebView.</param>
      /// <param name="aBrowserEvents">The TWVBrowserBase instance that will receive all the events.</param>
      /// <param name="aResult">Result code.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment3#createcorewebview2compositioncontroller">See the ICoreWebView2Environment3 article.</see></para>
      /// </remarks>
      function    CreateCoreWebView2CompositionController(aParentWindow : THandle; const aBrowserEvents : IWVBrowserEvents; var aResult: HRESULT) : boolean;
      /// <summary>
      /// Create an empty ICoreWebView2PointerInfo. The returned
      /// ICoreWebView2PointerInfo needs to be populated with all of the relevant
      /// info before calling SendPointerInput.
      /// </summary>
      /// <param name="aPointerInfo">The new ICoreWebView2PointerInfo instance.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment3#createcorewebview2pointerinfo">See the ICoreWebView2Environment3 article.</see></para>
      /// </remarks>
      function    CreateCoreWebView2PointerInfo(var aPointerInfo : ICoreWebView2PointerInfo) : boolean;
      /// <summary>
      /// Returns the Automation Provider for the WebView that matches the provided
      /// window. Host apps are expected to implement
      /// IRawElementProviderHwndOverride. When GetOverrideProviderForHwnd is
      /// called, the app can pass the HWND to GetAutomationProviderForWindow to
      /// find the matching WebView Automation Provider.
      /// </summary>
      /// <param name="aHandle">Handle used to find the matching WebView Automation Provider.</param>
      /// <param name="aProvider">The Automation Provider for the WebView that matches the provided window.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment4#getautomationproviderforwindow">See the ICoreWebView2Environment4 article.</see></para>
      /// </remarks>
      function    GetAutomationProviderForWindow(aHandle : THandle; var aProvider : IUnknown) : boolean;
      /// <summary>
      /// Creates the `ICoreWebView2PrintSettings` used by the `PrintToPdf` method.
      /// </summary>
      /// <param name="aPrintSettings">The new ICoreWebView2PrintSettings instance.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment6#createprintsettings">See the ICoreWebView2Environment6 article.</see></para>
      /// </remarks>
      function    CreatePrintSettings(var aPrintSettings : ICoreWebView2PrintSettings) : boolean;
      /// <summary>
      /// <para>Create a custom `ContextMenuItem` object to insert into the WebView context menu.
      /// CoreWebView2 will rewind the icon stream before decoding.</para>
      /// <para>There is a limit of 1000 active custom context menu items at a given time.
      /// Attempting to create more before deleting existing ones will fail with
      /// ERROR_NOT_ENOUGH_QUOTA.</para>
      /// <para>It is recommended to reuse ContextMenuItems across ContextMenuRequested events
      /// for performance.</para>
      /// <para>The returned ContextMenuItem object's `IsEnabled` property will default to `TRUE`
      /// and `IsChecked` property will default to `FALSE`. A `CommandId` will be assigned
      /// to the ContextMenuItem object that's unique across active custom context menu items,
      /// but command ID values of deleted ContextMenuItems can be reassigned.</para>
      /// </summary>
      /// <param name="aLabel">Context menu item label.</param>
      /// <param name="aIconStream">Context menu item icon as stream.</param>
      /// <param name="aKind">Context menu item kind.</param>
      /// <param name="aMenuItem">The new ICoreWebView2ContextMenuItem instance.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment9#createcontextmenuitem">See the ICoreWebView2Environment9 article.</see></para>
      /// </remarks>
      function    CreateContextMenuItem(const aLabel : wvstring; const aIconStream : IStream; aKind : TWVMenuItemKind; var aMenuItem : ICoreWebView2ContextMenuItem) : boolean;
      /// <summary>
      /// Create a new ICoreWebView2ControllerOptions to be passed as a parameter of
      /// CreateCoreWebView2ControllerWithOptions and CreateCoreWebView2CompositionControllerWithOptions.
      /// The 'options' is settable and in it the default value for profile name is the empty string,
      /// and the default value for IsInPrivateModeEnabled is false.
      /// Also the profile name can be reused.
      /// </summary>
      /// <param name="aOptions">The new ICoreWebView2ControllerOptions instance.</param>
      /// <param name="aResult">Result code.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment10#createcorewebview2controlleroptions">See the ICoreWebView2Environment10 article.</see></para>
      /// </remarks>
      function    CreateCoreWebView2ControllerOptions(var aOptions: ICoreWebView2ControllerOptions; var aResult: HResult): boolean;
      /// <summary>
      /// Create a new WebView with options.
      /// </summary>
      /// <param name="aParentWindow">Handle of the control in which the WebView should be displayed.</param>
      /// <param name="aOptions">The ICoreWebView2ControllerOptions instance created with CreateCoreWebView2ControllerOptions.</param>
      /// <param name="aBrowserEvents">The TWVBrowserBase instance that will receive all the events.</param>
      /// <param name="aResult">Result code.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment10#createcorewebview2controllerwithoptions">See the ICoreWebView2Environment10 article.</see></para>
      /// </remarks>
      function    CreateCoreWebView2ControllerWithOptions(aParentWindow: HWND; const aOptions: ICoreWebView2ControllerOptions; const aBrowserEvents: IWVBrowserEvents; var aResult: HResult): boolean;
      /// <summary>
      /// Create a new WebView in visual hosting mode with options.
      /// </summary>
      /// <param name="aParentWindow">Handle of the control in which the app will connect the visual tree of the WebView.</param>
      /// <param name="aOptions">The ICoreWebView2ControllerOptions instance created with CreateCoreWebView2ControllerOptions.</param>
      /// <param name="aBrowserEvents">The TWVBrowserBase instance that will receive all the events.</param>
      /// <param name="aResult">Result code.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment10#createcorewebview2compositioncontrollerwithoptions">See the ICoreWebView2Environment10 article.</see></para>
      /// </remarks>
      function    CreateCoreWebView2CompositionControllerWithOptions(aParentWindow: HWND; const aOptions: ICoreWebView2ControllerOptions; const aBrowserEvents: IWVBrowserEvents; var aResult: HResult): boolean;
      /// <summary>
      /// Create a shared memory based buffer with the specified size in bytes.
      /// The buffer can be shared with web contents in WebView by calling
      /// `PostSharedBufferToScript` on `CoreWebView2` or `CoreWebView2Frame` object.
      /// Once shared, the same content of the buffer will be accessible from both
      /// the app process and script in WebView. Modification to the content will be visible
      /// to all parties that have access to the buffer.
      /// The shared buffer is presented to the script as ArrayBuffer. All JavaScript APIs
      /// that work for ArrayBuffer including Atomics APIs can be used on it.
      /// There is currently a limitation that only size less than 2GB is supported.
      /// </summary>
      /// <param name="aSize">Buffer size in bytes.</param>
      /// <param name="aSharedBuffer">The new ICoreWebView2SharedBuffer instance.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment12#createsharedbuffer">See the ICoreWebView2Environment12 article.</see></para>
      /// </remarks>
      function    CreateSharedBuffer(aSize : Largeuint; var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;
      /// <summary>
      /// Gets a snapshot collection of `ProcessExtendedInfo`s corresponding to all
      /// currently running processes associated with this `ICoreWebView2Environment`
      /// excludes crashpad process.
      /// This provides the same list of `ProcessInfo`s as what's provided in
      /// `GetProcessInfos`, but additionally provides a list of associated `FrameInfo`s
      /// which are actively running (showing or hiding UI elements) in the renderer
      /// process. See `AssociatedFrameInfos` for more information.
      /// </summary>
      /// <param name="aBrowserEvents">The TWVBrowserBase instance that will receive all the events.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment13#getprocessextendedinfos">See the ICoreWebView2Environment13 article.</see></para>
      /// </remarks>
      function    GetProcessExtendedInfos(const aBrowserEvents : IWVBrowserEvents) : boolean;
      /// <summary>
      /// <para>Create a `ICoreWebView2FileSystemHandle` object from a path that represents a Web
      /// [FileSystemFileHandle](https://developer.mozilla.org/docs/Web/API/FileSystemFileHandle).</para>
      ///
      /// <para>The `path` is the path pointed by the file and must be a syntactically correct fully qualified
      /// path, but it is not checked here whether it currently points to a file. If an invalid path is
      /// passed, an E_INVALIDARG will be returned and the object will fail to create. Any other state
      /// validation will be done when this handle is accessed from web content
      /// and will cause the DOM exceptions described in
      /// [FileSystemFileHandle methods](https://developer.mozilla.org/docs/Web/API/FileSystemDirectoryHandle#instance_methods)
      /// if access operations fail.</para>
      ///
      /// <para>`Permission` property is used to specify whether the Handle should be created with a Read-only or
      /// Read-and-write web permission. For the `permission` value specified here, the DOM
      /// [PermissionStatus](https://developer.mozilla.org/docs/Web/API/PermissionStatus) property
      /// will be [granted](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state)
      /// and the unspecified permission will be
      /// [prompt](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state). Therefore,
      /// the web content then does not need to call
      /// [requestPermission](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/requestPermission)
      /// for the permission that was specified before attempting the permitted operation,
      /// but if it does, the promise will immediately be resolved
      /// with 'granted' PermissionStatus without firing the WebView2
      /// [PermissionRequested](/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs)
      /// event or prompting the user for permission. Otherwise, `requestPermission` will behave as the
      /// status of permission is currently `prompt`, which means the `PermissionRequested` event will fire
      /// or the user will be prompted.</para>
      /// <para>Additionally, the app must have the same OS permissions that have propagated to the
      /// [WebView2 browser process](/microsoft-edge/webview2/concepts/process-model)
      /// for the path it wishes to give the web content to read/write the file.</para>
      /// <para>Specifically, the WebView2 browser process will run in same user, package identity, and app
      /// container of the app, but other means such as security context impersonations do not get
      /// propagated, so such permissions that the app has, will not be effective in WebView2.</para>
      /// <para>Note: An exception to this is, if there is a parent directory handle that
      /// has broader permissions in the same page context than specified in here, the handle will automatically
      /// inherit the most permissive permission of the parent handle when posted to that page context.
      /// i.e. If there is already a `FileSystemDirectoryHandle` to `C:\example` that has write permission on
      /// a page, even though a WebFileSystemHandle to file `C:\example\file.txt` is created with
      /// `COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION_READ_ONLY` permission, when posted to that page, write permission
      /// will be automatically granted to the created handle.</para>
      ///
      /// <para>An app needs to be mindful that this object, when posted to the web content, provides it with unusual
      /// access to OS file system via the Web FileSystem API! The app should therefore only post objects
      /// for paths that it wants to allow access to the web content and it is not recommended that the web content
      /// "asks" for this path. The app should also check the source property of the target to ensure
      /// that it is sending to the web content of intended origin.</para>
      ///
      /// <para>Once the object is passed to web content, if the content is attempting a read,
      /// the file must be existing and available to read similar to a file chosen by
      /// [open file picker](https://developer.mozilla.org/docs/Web/API/Window/showOpenFilePicker),
      /// otherwise the read operation will
      /// [throw a DOM exception](https://developer.mozilla.org/docs/Web/API/FileSystemFileHandle/getFile#exceptions).
      /// For write operations, the file does not need to exist as `FileSystemFileHandle` will behave
      /// as a file path chosen by
      /// [save file picker](https://developer.mozilla.org/docs/Web/API/Window/showSaveFilePicker)
      /// and will create or overwrite the file, but the parent directory structure pointed
      /// by the file must exist and an existing file must be available to write and delete
      /// or the write operation will
      /// [throw a DOM exception](https://developer.mozilla.org/docs/Web/API/FileSystemFileHandle/createWritable#exceptions).</para>
      /// </summary>
      /// <param name="aPath">The path pointed by the file.</param>
      /// <param name="aPermission">Used to specify whether the Handle should be created with a Read-only or Read-and-write web permission.</param>
      /// <param name="aValue">The ICoreWebView2FileSystemHandle object created from a path that represents a Web FileSystemFileHandle.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment14#createwebfilesystemfilehandle">See the ICoreWebView2Environment14 article.</see></para>
      /// </remarks>
      function    CreateWebFileSystemFileHandle(const aPath       : wvstring;
                                                      aPermission : TWVFileSystemHandlePermission;
                                                var   aValue      : ICoreWebView2FileSystemHandle): boolean;
      /// <summary>
      /// <para>Create a `ICoreWebView2FileSystemHandle` object from a path that represents a Web
      /// [FileSystemDirectoryHandle](https://developer.mozilla.org/docs/Web/API/FileSystemDirectoryHandle).</para>
      ///
      /// <para>The `path` is the path pointed by the directory and must be a syntactically correct fully qualified
      /// path, but it is not checked here whether it currently points to a directory. Any other state
      /// validation will be done when this handle is accessed from web content
      /// and will cause DOM exceptions if access operations fail. If an invalid path is
      /// passed, an E_INVALIDARG will be returned and the object will fail to create.</para>
      ///
      /// <para>`Permission` property is used to specify whether the Handle should be created with a Read-only or
      /// Read-and-write web permission. For the `permission` value specified here, the Web
      /// [PermissionStatus](https://developer.mozilla.org/docs/Web/API/PermissionStatus)
      /// will be [granted](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state)
      /// and the unspecified permission will be
      /// [prompt](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state). Therefore,
      /// the web content then does not need to call
      /// [requestPermission](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/requestPermission)
      /// for the permission that was specified before attempting the permitted operation,
      /// but if it does, the promise will immediately be resolved
      /// with 'granted' PermissionStatus without firing the WebView2
      /// [PermissionRequested](/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs)
      /// event or prompting the user for permission. Otherwise, `requestPermission` will behave as the
      /// status of permission is currently `Prompt`, which means the `PermissionRequested` event will fire
      /// or the user will be prompted.</para>
      /// <para>Additionally, the app must have the same OS permissions that have propagated to the
      /// [WebView2 browser process](/microsoft-edge/webview2/concepts/process-model)
      /// for the path it wishes to give the web content to make any operations on the directory.
      /// Specifically, the WebView2 browser process will run in same user, package identity, and app
      /// container of the app, but other means such as security context impersonations do not get
      /// propagated, so such permissions that the app has, will not be effective in WebView2.</para>
      /// <para>Note: An exception to this is, if there is a parent directory handle that
      /// has broader permissions in the same page context than specified in here, the handle will automatically
      /// inherit the most permissive permission of the parent handle when posted to that page context.
      /// i.e. If there is already a `FileSystemDirectoryHandle` to `C:\example` that has write permission on
      /// a page, even though a WebFileSystemHandle to directory `C:\example\directory` is created with
      /// `COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION_READ_ONLY` permission, when posted to that page, write permission
      /// will be automatically granted to the created handle.</para>
      ///
      /// <para>An app needs to be mindful that this object, when posted to the web content, provides it with unusual
      /// access to OS file system via the Web FileSystem API! The app should therefore only post objects
      /// for paths that it wants to allow access to the web content and it is not recommended that the web content
      /// "asks" for this path. The app should also check the source property of the target to ensure
      /// that it is sending to the web content of intended origin.</para>
      ///
      /// <para>Once the object is passed to web content, the path must point to a directory as if it was chosen via
      /// [directory picker](https://developer.mozilla.org/docs/Web/API/Window/showDirectoryPicker)
      /// otherwise any IO operation done on the `FileSystemDirectoryHandle` will throw a DOM exception.</para>
      /// </summary>
      /// <param name="aPath">The path pointed by the directory.</param>
      /// <param name="aPermission">Used to specify whether the Handle should be created with a Read-only or Read-and-write web permission.</param>
      /// <param name="aValue">The ICoreWebView2FileSystemHandle object created from a path that represents a Web FileSystemDirectoryHandle.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment14#createwebfilesystemdirectoryhandle">See the ICoreWebView2Environment14 article.</see></para>
      /// </remarks>
      function    CreateWebFileSystemDirectoryHandle(const aPath       : wvstring;
                                                           aPermission : TWVFileSystemHandlePermission;
                                                     var   aValue      : ICoreWebView2FileSystemHandle): boolean;
      /// <summary>
      /// Create a generic object collection.
      /// </summary>
      /// <param name="aLength">Amount of items.</param>
      /// <param name="aItems">Used to specify whether the Handle should be created with a Read-only or Read-and-write web permission.</param>
      /// <param name="aObjectCollection">The ICoreWebView2ObjectCollection object created with aItems.</param>
      /// <returns>True if successfull.</return>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment14#createobjectcollection">See the ICoreWebView2Environment14 article.</see></para>
      /// </remarks>
      function   CreateObjectCollection(    aLength           : cardinal;
                                        var aItems            : IUnknown;
                                        var aObjectCollection : ICoreWebView2ObjectCollection): boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property    Initialized                   : boolean                             read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property    BaseIntf                      : ICoreWebView2Environment            read FBaseIntf;
      /// <summary>
      /// The browser version info of the current `ICoreWebView2Environment`,
      /// including channel name if it is not the WebView2 Runtime.  It matches the
      /// format of the `GetAvailableCoreWebView2BrowserVersionString` API.
      /// Channel names are `beta`, `dev`, and `canary`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment#get_browserversionstring">See the ICoreWebView2Environment article.</see></para>
      /// </remarks>
      property    BrowserVersionInfo            : wvstring                            read GetBrowserVersionInfo;
      /// <summary>
      /// Returns true if the current WebView2 runtime version supports Composition Controllers.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment3">See the ICoreWebView2Environment3 article.</see></para>
      /// </remarks>
      property    SupportsCompositionController : boolean                             read GetSupportsCompositionController;
      /// <summary>
      /// Returns true if the current WebView2 runtime version supports Controller Options.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment10">See the ICoreWebView2Environment10 article.</see></para>
      /// </remarks>
      property    SupportsControllerOptions     : boolean                             read GetSupportsControllerOptions;
      /// <summary>
      /// Returns the user data folder that all CoreWebView2's created from this
      /// environment are using.
      /// This could be either the value passed in by the developer when creating
      /// the environment object or the calculated one for default handling.  It
      /// will always be an absolute path.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment7#get_userdatafolder">See the ICoreWebView2Environment7 article.</see></para>
      /// </remarks>
      property    UserDataFolder                : wvstring                            read GetUserDataFolder;
      /// <summary>
      /// Returns the `ICoreWebView2ProcessInfoCollection`. Provide a list of all
      /// process using same user data folder except for crashpad process.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8#getprocessinfos">See the ICoreWebView2Environment8 article.</see></para>
      /// </remarks>
      property    ProcessInfos                  : ICoreWebView2ProcessInfoCollection  read GetProcessInfos;
      /// <summary>
      /// `FailureReportFolderPath` returns the path of the folder where minidump files are written.
      /// Whenever a WebView2 process crashes, a crash dump file will be created in the crash dump folder.
      /// The crash dump format is minidump files. Please see
      /// [Minidump Files documentation](/windows/win32/debug/minidump-files) for detailed information.
      /// Normally when a single child process fails, a minidump will be generated and written to disk,
      /// then the `ProcessFailed` event is raised. But for unexpected crashes, a minidump file might not be generated
      /// at all, despite whether `ProcessFailed` event is raised. If there are multiple
      /// process failures at once, multiple minidump files could be generated. Thus `FailureReportFolderPath`
      /// could contain old minidump files that are not associated with a specific `ProcessFailed` event.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment11#get_failurereportfolderpath">See the ICoreWebView2Environment11 article.</see></para>
      /// </remarks>
      property    FailureReportFolderPath       : wvstring                            read GetFailureReportFolderPath;
  end;

implementation

uses
  uWVMiscFunctions, uWVCoreWebView2Delegates, uWVBrowserBase, uWVLoader;

constructor TCoreWebView2Environment.Create(const aBaseIntf : ICoreWebView2Environment);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment2,  FBaseIntf2)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment3,  FBaseIntf3)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment4,  FBaseIntf4)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment5,  FBaseIntf5)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment6,  FBaseIntf6)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment7,  FBaseIntf7)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment8,  FBaseIntf8)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment9,  FBaseIntf9)  and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment10, FBaseIntf10) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment11, FBaseIntf11) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment12, FBaseIntf12) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment13, FBaseIntf13) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Environment14, FBaseIntf14);
end;

destructor TCoreWebView2Environment.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2Environment.InitializeFields;
begin
  FBaseIntf   := nil;
  FBaseIntf2  := nil;
  FBaseIntf3  := nil;
  FBaseIntf4  := nil;
  FBaseIntf5  := nil;
  FBaseIntf6  := nil;
  FBaseIntf7  := nil;
  FBaseIntf8  := nil;
  FBaseIntf9  := nil;
  FBaseIntf10 := nil;
  FBaseIntf11 := nil;
  FBaseIntf12 := nil;
  FBaseIntf13 := nil;
  FBaseIntf14 := nil;

  InitializeTokens;
end;

procedure TCoreWebView2Environment.InitializeTokens;
begin
  FNewBrowserVersionAvailableEventToken.value := 0;
  FBrowserProcessExitedEventToken.value       := 0;
  FProcessInfosChangedEventToken.value        := 0;
end;

function TCoreWebView2Environment.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

procedure TCoreWebView2Environment.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FNewBrowserVersionAvailableEventToken.value <> 0) then
        FBaseIntf.remove_NewBrowserVersionAvailable(FNewBrowserVersionAvailableEventToken);

      if assigned(FBaseIntf5) and (FBrowserProcessExitedEventToken.value <> 0) then
        FBaseIntf5.remove_BrowserProcessExited(FBrowserProcessExitedEventToken);

      if assigned(FBaseIntf8) and (FProcessInfosChangedEventToken.value <> 0) then
        FBaseIntf8.remove_ProcessInfosChanged(FProcessInfosChangedEventToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2Environment.AddAllLoaderEvents(const aLoaderComponent : TComponent) : boolean;
begin
  Result := AddNewBrowserVersionAvailableEvent(aLoaderComponent) and
            AddBrowserProcessExitedLoaderEvent(aLoaderComponent) and
            AddProcessInfosChangedLoaderEvent(aLoaderComponent);
end;         

function TCoreWebView2Environment.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddBrowserProcessExitedBrowserEvent(aBrowserComponent) and
            AddProcessInfosChangedBrowserEvent(aBrowserComponent);
end;

function TCoreWebView2Environment.AddNewBrowserVersionAvailableEvent(const aLoaderComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NewBrowserVersionAvailableEventHandler;
begin
  Result := False;

  if Initialized and (FNewBrowserVersionAvailableEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2NewBrowserVersionAvailableEventHandler.Create(TWVLoader(aLoaderComponent));
      Result      := succeeded(FBaseIntf.add_NewBrowserVersionAvailable(TempHandler, FNewBrowserVersionAvailableEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddBrowserProcessExitedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BrowserProcessExitedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf5) and (FBrowserProcessExitedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2BrowserProcessExitedEventHandler.Create(TWVLoader(aLoaderComponent));
      Result      := succeeded(FBaseIntf5.add_BrowserProcessExited(TempHandler, FBrowserProcessExitedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddBrowserProcessExitedBrowserEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BrowserProcessExitedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf5) and (FBrowserProcessExitedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2BrowserProcessExitedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf5.add_BrowserProcessExited(TempHandler, FBrowserProcessExitedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddProcessInfosChangedLoaderEvent(const aLoaderComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ProcessInfosChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FProcessInfosChangedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2ProcessInfosChangedEventHandler.Create(TWVLoader(aLoaderComponent));
      Result      := succeeded(FBaseIntf8.add_ProcessInfosChanged(TempHandler, FProcessInfosChangedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.AddProcessInfosChangedBrowserEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ProcessInfosChangedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf8) and (FProcessInfosChangedEventToken.value = 0) then
    try
      TempHandler := TCoreWebView2ProcessInfosChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf8.add_ProcessInfosChanged(TempHandler, FProcessInfosChangedEventToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateCoreWebView2Controller(      aParentWindow  : THandle;
                                                               const aBrowserEvents : IWVBrowserEvents;
                                                               var   aResult        : HRESULT) : boolean;
var
  TempHandler : ICoreWebView2CreateCoreWebView2ControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if Initialized then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf.CreateCoreWebView2Controller(aParentWindow, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateWebResourceResponse(const aContent      : IStream;
                                                                  aStatusCode   : integer;
                                                                  aReasonPhrase : wvstring;
                                                                  aHeaders      : wvstring;
                                                            var   aResponse     : ICoreWebView2WebResourceResponse) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.CreateWebResourceResponse(aContent,
                                                          aStatusCode,
                                                          PWideChar(aReasonPhrase),
                                                          PWideChar(aHeaders),
                                                          aResponse));
end;

function TCoreWebView2Environment.CreateWebResourceRequest(const aURI      : wvstring;
                                                           const aMethod   : wvstring;
                                                           const aPostData : IStream;
                                                           const aHeaders  : wvstring;
                                                           var   aRequest  : ICoreWebView2WebResourceRequest): boolean;
begin
  aRequest := nil;
  Result   := assigned(FBaseIntf2) and
              succeeded(FBaseIntf2.CreateWebResourceRequest(PWideChar(aURI),
                                                            PWideChar(aMethod),
                                                            aPostData,
                                                            PWideChar(aHeaders),
                                                            aRequest));
end;

function TCoreWebView2Environment.GetBrowserVersionInfo: wvstring;
var
  TempVersionInfo : PWideChar;
begin
  Result := '';

  if Initialized then
    begin
      TempVersionInfo := nil;

      if succeeded(FBaseIntf.Get_BrowserVersionString(TempVersionInfo)) then
        begin
          Result := TempVersionInfo;
          CoTaskMemFree(TempVersionInfo);
        end;
   end;
end;

function TCoreWebView2Environment.GetSupportsCompositionController : boolean;
begin
  Result := assigned(FBaseIntf3);
end;

function TCoreWebView2Environment.GetSupportsControllerOptions : boolean;
begin
  Result := assigned(FBaseIntf10);
end;

function TCoreWebView2Environment.CreateCoreWebView2CompositionController(      aParentWindow  : THandle;
                                                                          const aBrowserEvents : IWVBrowserEvents;
                                                                          var   aResult        : HRESULT) : boolean;
var
  TempHandler : ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if assigned(FBaseIntf3) then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf3.CreateCoreWebView2CompositionController(aParentWindow, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateCoreWebView2PointerInfo(var aPointerInfo: ICoreWebView2PointerInfo) : boolean;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.CreateCoreWebView2PointerInfo(aPointerInfo));
end;

function TCoreWebView2Environment.GetAutomationProviderForWindow(aHandle : THandle; var aProvider: IUnknown) : boolean;
begin
  aProvider := nil;
  Result    := assigned(FBaseIntf4) and
               succeeded(FBaseIntf4.GetAutomationProviderForWindow(aHandle, aProvider));
end;

function TCoreWebView2Environment.CreatePrintSettings(var aPrintSettings: ICoreWebView2PrintSettings): boolean;
begin
  aPrintSettings := nil;
  Result         := assigned(FBaseIntf6) and
                    succeeded(FBaseIntf6.CreatePrintSettings(aPrintSettings)) and
                    assigned(aPrintSettings);
end;

function TCoreWebView2Environment.CreateContextMenuItem(const aLabel      : wvstring;
                                                        const aIconStream : IStream;
                                                              aKind       : TWVMenuItemKind;
                                                        var   aMenuItem   : ICoreWebView2ContextMenuItem) : boolean;
begin
  aMenuItem := nil;
  Result    := assigned(FBaseIntf9) and
               succeeded(FBaseIntf9.CreateContextMenuItem(PWideChar(aLabel), aIconStream, aKind, aMenuItem)) and
               assigned(aMenuItem);
end;

function TCoreWebView2Environment.CreateCoreWebView2ControllerOptions(var aOptions : ICoreWebView2ControllerOptions;
                                                                      var aResult  : HResult): boolean;
begin
  Result   := False;
  aOptions := nil;
  aResult  := E_FAIL;

  if assigned(FBaseIntf10) then
    begin
      aResult := FBaseIntf10.CreateCoreWebView2ControllerOptions(aOptions);
      Result  := succeeded(aResult);
    end
   else
    aResult := E_NOTIMPL;
end;

function TCoreWebView2Environment.CreateCoreWebView2ControllerWithOptions(      aParentWindow  : HWND;
                                                                          const aOptions       : ICoreWebView2ControllerOptions;
                                                                          const aBrowserEvents : IWVBrowserEvents;
                                                                          var   aResult        : HResult): boolean;
var
  TempHandler : ICoreWebView2CreateCoreWebView2ControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if assigned(FBaseIntf10) then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2ControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf10.CreateCoreWebView2ControllerWithOptions(aParentWindow, aOptions, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateCoreWebView2CompositionControllerWithOptions(      aParentWindow  : HWND;
                                                                                     const aOptions       : ICoreWebView2ControllerOptions;
                                                                                     const aBrowserEvents : IWVBrowserEvents;
                                                                                     var   aResult        : HResult): boolean;
var
  TempHandler: ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler;
begin
  Result  := False;
  aResult := E_FAIL;

  if assigned(FBaseIntf10) then
    try
      TempHandler := TCoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler.Create(aBrowserEvents);
      aResult     := FBaseIntf10.CreateCoreWebView2CompositionControllerWithOptions(aParentWindow, aOptions, TempHandler);
      Result      := succeeded(aResult);
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateSharedBuffer(    aSize         : Largeuint;
                                                     var aSharedBuffer : ICoreWebView2SharedBuffer) : boolean;
var
  TempBuffer : ICoreWebView2SharedBuffer;
begin
  Result        := False;
  TempBuffer    := nil;
  aSharedBuffer := nil;

  if assigned(FBaseIntf12) and
     succeeded(FBaseIntf12.CreateSharedBuffer(aSize, TempBuffer)) and
     (TempBuffer <> nil) then
    begin
      aSharedBuffer := TempBuffer;
      Result        := True;
    end;
end;

function TCoreWebView2Environment.GetProcessExtendedInfos(const aBrowserEvents : IWVBrowserEvents) : boolean;
var
  TempHandler: ICoreWebView2GetProcessExtendedInfosCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf13) then
    try
      TempHandler := TCoreWebView2GetProcessExtendedInfosCompletedHandler.Create(aBrowserEvents);
      Result      := succeeded(FBaseIntf13.GetProcessExtendedInfos(TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Environment.CreateWebFileSystemFileHandle(const aPath       : wvstring;
                                                                      aPermission : TWVFileSystemHandlePermission;
                                                                var   aValue      : ICoreWebView2FileSystemHandle): boolean;
begin
  aValue := nil;
  Result := assigned(FBaseIntf14) and
            succeeded(FBaseIntf14.CreateWebFileSystemFileHandle(PWideChar(aPath), aPermission, aValue)) and
            assigned(aValue);
end;

function TCoreWebView2Environment.CreateWebFileSystemDirectoryHandle(const aPath       : wvstring;
                                                                           aPermission : TWVFileSystemHandlePermission;
                                                                     var   aValue      : ICoreWebView2FileSystemHandle): boolean;
begin
  aValue := nil;
  Result := assigned(FBaseIntf14) and
            succeeded(FBaseIntf14.CreateWebFileSystemDirectoryHandle(PWideChar(aPath), aPermission, aValue)) and
            assigned(aValue);
end;

function TCoreWebView2Environment.CreateObjectCollection(    aLength           : cardinal;
                                                         var aItems            : IUnknown;
                                                         var aObjectCollection : ICoreWebView2ObjectCollection): boolean;
begin
  aObjectCollection := nil;
  Result            := assigned(FBaseIntf14) and
                       succeeded(FBaseIntf14.CreateObjectCollection(aLength, aItems, aObjectCollection)) and
                       assigned(aObjectCollection);
end;

function TCoreWebView2Environment.GetUserDataFolder : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if assigned(FBaseIntf7) then
    begin
      TempString := nil;

      if succeeded(FBaseIntf7.Get_UserDataFolder(TempString)) then
        begin
          Result := TempString;
          CoTaskMemFree(TempString);
        end;
   end;
end;

function TCoreWebView2Environment.GetProcessInfos : ICoreWebView2ProcessInfoCollection;
var
  TempResult : ICoreWebView2ProcessInfoCollection;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf8) and
     succeeded(FBaseIntf8.GetProcessInfos(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2Environment.GetFailureReportFolderPath : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if assigned(FBaseIntf11) then
    begin
      TempString := nil;

      if succeeded(FBaseIntf11.Get_FailureReportFolderPath(TempString)) then
        begin
          Result := TempString;
          CoTaskMemFree(TempString);
        end;
   end;
end;

end.
