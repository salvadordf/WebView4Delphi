unit uWVCoreWebView2Frame;

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
  /// ICoreWebView2Frame provides direct access to the iframes information.
  /// You can get an ICoreWebView2Frame by handling the ICoreWebView2_4.add_FrameCreated event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame">See the ICoreWebView2Frame article.</see></para>
  /// </remarks>
  TCoreWebView2Frame = class
    protected
      FBaseIntf                                : ICoreWebView2Frame;
      FBaseIntf2                               : ICoreWebView2Frame2;
      FBaseIntf3                               : ICoreWebView2Frame3;
      FBaseIntf4                               : ICoreWebView2Frame4;
      FBaseIntf5                               : ICoreWebView2Frame5;
      FBaseIntf6                               : ICoreWebView2Frame6;
      FBaseIntf7                               : ICoreWebView2Frame7;
      FNameChangedToken                        : EventRegistrationToken;
      FDestroyedToken                          : EventRegistrationToken;
      FFrameNavigationStartingToken            : EventRegistrationToken;
      FFrameNavigationCompletedToken           : EventRegistrationToken;
      FFrameContentLoadingToken                : EventRegistrationToken;
      FFrameDOMContentLoadedToken              : EventRegistrationToken;
      FFrameWebMessageReceivedToken            : EventRegistrationToken;
      FPermissionRequestedToken                : EventRegistrationToken;
      FFrameScreenCaptureStartingToken         : EventRegistrationToken;
      FFrameChildFrameCreatedToken             : EventRegistrationToken;
      FFrameIDCopy                             : cardinal;

      function GetInitialized : boolean;
      function GetName : wvstring;
      function GetIsDestroyed : boolean;
      function GetFrameID : cardinal;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddFrameNameChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameDestroyedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameScreenCaptureStartingEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddFrameCreatedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2Frame wrapper.
      /// </summary>
      /// <param name="aBaseIntf">The ICoreWebView2Frame instance.</param>
      constructor Create(const aBaseIntf : ICoreWebView2Frame); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// <para>Add the provided host object to script running in the iframe with the
      /// specified name for the list of the specified origins. The host object
      /// will be accessible for this iframe only if the iframe's origin during
      /// access matches one of the origins which are passed. The provided origins
      /// will be normalized before comparing to the origin of the document.</para>
      /// <para>So the scheme name is made lower case, the host will be punycode decoded
      /// as appropriate, default port values will be removed, and so on.</para>
      /// <para>This means the origin's host may be punycode encoded or not and will match
      /// regardless. If list contains malformed origin the call will fail.</para>
      /// <para>The method can be called multiple times in a row without calling
      /// RemoveHostObjectFromScript for the same object name. It will replace
      /// the previous object with the new object and new list of origins.</para>
      /// <para>List of origins will be treated as following:</para>
      /// <para>1. empty list - call will succeed and object will be added for the iframe
      /// but it will not be exposed to any origin;</para>
      /// <para>2. list with origins - during access to host object from iframe the
      /// origin will be checked that it belongs to this list;</para>
      /// <para>3. list with "*" element - host object will be available for iframe for
      /// all origins. We suggest not to use this feature without understanding
      /// security implications of giving access to host object from from iframes
      /// with unknown origins.</para>
      /// <para>4. list with "file://" element - host object will be available for iframes
      /// loaded via file protocol.</para>
      /// <para>Calling this method fails if it is called after the iframe is destroyed.
      /// For more information about host objects navigate to
      /// ICoreWebView2.AddHostObjectToScript.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame#addhostobjecttoscriptwithorigins">See the ICoreWebView2Frame article.</see></para>
      /// </remarks>
      function    AddHostObjectToScriptWithOrigins(const aName : wvstring; const aObject : OleVariant; aOriginsCount : cardinal; var aOrigins : wvstring) : boolean;
      /// <summary>
      /// Remove the host object specified by the name so that it is no longer
      /// accessible from JavaScript code in the iframe. While new access
      /// attempts are denied, if the object is already obtained by JavaScript code
      /// in the iframe, the JavaScript code continues to have access to that
      /// object. Calling this method for a name that is already removed or was
      /// never added fails. If the iframe is destroyed this method will return fail
      /// also.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame#removehostobjectfromscript">See the ICoreWebView2Frame article.</see></para>
      /// </remarks>
      function    RemoveHostObjectFromScript(const aName : wvstring) : boolean;
      /// <summary>
      /// <para>Run JavaScript code from the javascript parameter in the current frame.
      /// The result of evaluating the provided JavaScript is passed to the completion handler.
      /// The result value is a JSON encoded string. If the result is undefined,
      /// contains a reference cycle, or otherwise is not able to be encoded into
      /// JSON, then the result is considered to be null, which is encoded
      /// in JSON as the string "null".</para>
      /// <para>NOTE: A function that has no explicit return value returns undefined. If the
      /// script that was run throws an unhandled exception, then the result is
      /// also "null". This method is applied asynchronously. If the method is
      /// run before `ContentLoading`, the script will not be executed
      /// and the string "null" will be returned.</para>
      /// <para>This operation executes the script even if `ICoreWebView2Settings::IsScriptEnabled` is
      /// set to `FALSE`.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#executescript">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      function    ExecuteScript(const JavaScript : wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// <para>Posts the specified webMessage to the frame.
      /// The frame receives the message by subscribing to the `message` event of
      /// the `window.chrome.webview` of the frame document.</para>
      /// <para>
      /// <code>
      /// ```cpp
      /// window.chrome.webview.addEventListener('message', handler)
      /// window.chrome.webview.removeEventListener('message', handler)
      /// ```</code>
      /// </para>
      /// <para>The event args is an instances of `MessageEvent`. The
      /// `ICoreWebView2Settings::IsWebMessageEnabled` setting must be `TRUE` or
      /// the message will not be sent. The `data` property of the event
      /// args is the `webMessage` string parameter parsed as a JSON string into a
      /// JavaScript object. The `source` property of the event args is a reference
      /// to the `window.chrome.webview` object.  For information about sending
      /// messages from the HTML document in the WebView to the host, navigate to
      /// [add_WebMessageReceived](/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived).
      /// The message is delivered asynchronously. If a navigation occurs before the
      /// message is posted to the page, the message is discarded.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#postwebmessageasjson">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      function    PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
      /// <summary>
      /// Posts a message that is a simple string rather than a JSON string
      /// representation of a JavaScript object. This behaves in exactly the same
      /// manner as `PostWebMessageAsJson`, but the `data` property of the event
      /// args of the `window.chrome.webview` message is a string with the same
      /// value as `webMessageAsString`. Use this instead of
      /// `PostWebMessageAsJson` if you want to communicate using simple strings
      /// rather than JSON objects.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2#postwebmessageasstring">See the ICoreWebView2Frame2 article.</see></para>
      /// </remarks>
      function    PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
      /// <summary>
      /// <para>Share a shared buffer object with script of the iframe in the WebView.
      /// The script will receive a `sharedbufferreceived` event from chrome.webview.
      /// The event arg for that event will have the following methods and properties:</para>
      /// <para>  `getBuffer()`: return an ArrayBuffer object with the backing content from the shared buffer.</para>
      /// <para>  `additionalData`: an object as the result of parsing `additionalDataAsJson` as JSON string.
      ///           This property will be `undefined` if `additionalDataAsJson` is nullptr or empty string.</para>
      /// <para>  `source`: with a value set as `chrome.webview` object.</para>
      /// <para>If a string is provided as `additionalDataAsJson` but it is not a valid JSON string,
      /// the API will fail with `E_INVALIDARG`.</para>
      /// <para>If `access` is COREWEBVIEW2_SHARED_BUFFER_ACCESS_READ_ONLY, the script will only have read access to the buffer.</para>
      /// <para>If the script tries to modify the content in a read only buffer, it will cause an access
      /// violation in WebView renderer process and crash the renderer process.</para>
      /// <para>If the shared buffer is already closed, the API will fail with `RO_E_CLOSED`.</para>
      /// <para>The script code should call `chrome.webview.releaseBuffer` with
      /// the shared buffer as the parameter to release underlying resources as soon
      /// as it does not need access to the shared buffer any more.</para>
      /// <para>The application can post the same shared buffer object to multiple web pages or iframes, or
      /// post to the same web page or iframe multiple times. Each `PostSharedBufferToScript` will
      /// create a separate ArrayBuffer object with its own view of the memory and is separately
      /// released. The underlying shared memory will be released when all the views are released.</para>
      /// <para>For example, if we want to send data to script for one time read only consumption.</para>
      /// <para>Sharing a buffer to script has security risk. You should only share buffer with trusted site.
      /// If a buffer is shared to a untrusted site, possible sensitive information could be leaked.
      /// If a buffer is shared as modifiable by the script and the script modifies it in an unexpected way,
      /// it could result in corrupted data that might even crash the application.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame4#postsharedbuffertoscript">See the ICoreWebView2Frame4 article.</see></para>
      /// </remarks>
      function    PostSharedBufferToScript(const aSharedBuffer: ICoreWebView2SharedBuffer; aAccess: TWVSharedBufferAccess; const aAdditionalDataAsJson: wvstring): boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized         : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf            : ICoreWebView2Frame              read FBaseIntf;
      /// <summary>
      /// The unique identifier of the current frame. It's the same kind of ID as
      /// with the `FrameId` in `ICoreWebView2` and via `CoreWebView2FrameInfo`.
      /// </summary>
      property FrameID             : cardinal                        read GetFrameID;
      /// <summary>
      /// The value of iframe's window.name property. The default value equals to
      /// iframe html tag declaring it. You can access this property even if the
      /// iframe is destroyed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame#get_name">See the ICoreWebView2Frame article.</see></para>
      /// </remarks>
      property Name                : wvstring                        read GetName;
      /// <summary>
      /// Check whether a frame is destroyed. Returns true during
      /// the Destroyed event.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame#isdestroyed">See the ICoreWebView2Frame article.</see></para>
      /// </remarks>
      property IsDestroyed         : boolean                         read GetIsDestroyed;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates, uWVConstants;

constructor TCoreWebView2Frame.Create(const aBaseIntf: ICoreWebView2Frame);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame3, FBaseIntf3) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame4, FBaseIntf4) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame5, FBaseIntf5) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame6, FBaseIntf6) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame7, FBaseIntf7);
end;

destructor TCoreWebView2Frame.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2Frame.InitializeFields;
begin
  FBaseIntf    := nil;
  FBaseIntf2   := nil;
  FBaseIntf3   := nil;
  FBaseIntf4   := nil;
  FBaseIntf5   := nil;
  FBaseIntf6   := nil;
  FBaseIntf7   := nil;
  FFrameIDCopy := WEBVIEW4DELPHI_INVALID_FRAMEID;

  InitializeTokens;
end;

procedure TCoreWebView2Frame.InitializeTokens;
begin
  FNameChangedToken.value                  := 0;
  FDestroyedToken.value                    := 0;
  FFrameNavigationStartingToken.value      := 0;
  FFrameNavigationCompletedToken.value     := 0;
  FFrameContentLoadingToken.value          := 0;
  FFrameDOMContentLoadedToken.value        := 0;
  FFrameWebMessageReceivedToken.value      := 0;
  FPermissionRequestedToken.value          := 0;
  FFrameScreenCaptureStartingToken.value   := 0;
  FFrameChildFrameCreatedToken.value       := 0;
end;

procedure TCoreWebView2Frame.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FNameChangedToken.value <> 0) then
        FBaseIntf.remove_NameChanged(FNameChangedToken);

      if (FDestroyedToken.value <> 0) then
        FBaseIntf.remove_Destroyed(FDestroyedToken);

      if assigned(FBaseIntf2) then
        begin
          if (FFrameNavigationStartingToken.value <> 0) then
            FBaseIntf2.remove_NavigationStarting(FFrameNavigationStartingToken);

          if (FFrameNavigationCompletedToken.value <> 0) then
            FBaseIntf2.remove_NavigationCompleted(FFrameNavigationCompletedToken);

          if (FFrameContentLoadingToken.value <> 0) then
            FBaseIntf2.remove_ContentLoading(FFrameContentLoadingToken);

          if (FFrameDOMContentLoadedToken.value <> 0) then
            FBaseIntf2.remove_DOMContentLoaded(FFrameDOMContentLoadedToken);

          if (FFrameWebMessageReceivedToken.value <> 0) then
            FBaseIntf2.remove_WebMessageReceived(FFrameWebMessageReceivedToken);
        end;

      if assigned(FBaseIntf3) and
         (FPermissionRequestedToken.value <> 0) then
        FBaseIntf3.remove_PermissionRequested(FPermissionRequestedToken);

      if assigned(FBaseIntf6) and
         (FFrameScreenCaptureStartingToken.value <> 0) then
        FBaseIntf6.remove_ScreenCaptureStarting(FFrameScreenCaptureStartingToken);

      // FBaseIntf7.remove_FrameCreated raises an exception when the frame is already destroyed.
      if assigned(FBaseIntf7) and
         not(IsDestroyed) and
         (FFrameChildFrameCreatedToken.value <> 0) then
        FBaseIntf7.remove_FrameCreated(FFrameChildFrameCreatedToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2Frame.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddFrameNameChangedEvent(aBrowserComponent)           and
            AddFrameDestroyedEvent(aBrowserComponent)             and
            AddFrameNavigationStartingEvent(aBrowserComponent)    and
            AddFrameNavigationCompletedEvent(aBrowserComponent)   and
            AddFrameContentLoadingEvent(aBrowserComponent)        and
            AddFrameDOMContentLoadedEvent(aBrowserComponent)      and
            AddFrameWebMessageReceivedEvent(aBrowserComponent)    and
            AddPermissionRequestedEvent(aBrowserComponent)        and
            AddFrameScreenCaptureStartingEvent(aBrowserComponent) and
            AddFrameCreatedEvent(aBrowserComponent);
end;

function TCoreWebView2Frame.AddFrameNameChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameNameChangedEventHandler;
begin
  Result := False;

  if Initialized and (FNameChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameNameChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf.add_NameChanged(TempHandler, FNameChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameDestroyedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameDestroyedEventHandler;
begin
  Result := False;

  if Initialized and (FDestroyedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameDestroyedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf.add_Destroyed(TempHandler, FDestroyedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameNavigationStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameNavigationStartingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameNavigationStartingToken.value  = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationStartingEventHandler2.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf2.add_NavigationStarting(TempHandler, FFrameNavigationStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameNavigationCompletedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameNavigationCompletedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameNavigationCompletedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameNavigationCompletedEventHandler2.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf2.add_NavigationCompleted(TempHandler, FFrameNavigationCompletedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameContentLoadingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameContentLoadingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameContentLoadingToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameContentLoadingEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf2.add_ContentLoading(TempHandler, FFrameContentLoadingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameDOMContentLoadedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameDOMContentLoadedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameDOMContentLoadedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameDOMContentLoadedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf2.add_DOMContentLoaded(TempHandler, FFrameDOMContentLoadedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameWebMessageReceivedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameWebMessageReceivedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (FFrameWebMessageReceivedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameWebMessageReceivedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf2.add_WebMessageReceived(TempHandler, FFrameWebMessageReceivedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddPermissionRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FramePermissionRequestedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf3) and (FPermissionRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FramePermissionRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf3.add_PermissionRequested(TempHandler, FPermissionRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameScreenCaptureStartingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameScreenCaptureStartingEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf6) and (FFrameScreenCaptureStartingToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameScreenCaptureStartingEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf6.add_ScreenCaptureStarting(TempHandler, FFrameScreenCaptureStartingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.AddFrameCreatedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FrameChildFrameCreatedEventHandler;
begin
  Result := False;

  if assigned(FBaseIntf7) and (FFrameChildFrameCreatedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FrameChildFrameCreatedEventHandler.Create(TWVBrowserBase(aBrowserComponent), FrameID);
      Result      := succeeded(FBaseIntf7.add_FrameCreated(TempHandler, FFrameChildFrameCreatedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Frame.GetName : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Name(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2Frame.GetIsDestroyed : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.IsDestroyed(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Frame.GetFrameID : cardinal;
var
  TempResult : SYSUINT;
begin
  if assigned(FBaseIntf5) and
     succeeded(FBaseIntf5.Get_FrameId(TempResult)) then
    begin
      Result       := TempResult;
      FFrameIDCopy := TempResult;
    end
   else
    Result := FFrameIDCopy;
end;

function TCoreWebView2Frame.AddHostObjectToScriptWithOrigins(const aName : wvstring; const aObject : OleVariant; aOriginsCount : cardinal; var aOrigins : wvstring) : boolean;
var
  TempOrigins : PWideChar;
begin
  Result      := False;
  aOrigins    := '';
  TempOrigins := nil;

  if Initialized  and
     succeeded(FBaseIntf.AddHostObjectToScriptWithOrigins(PWideChar(aName), aObject, aOriginsCount, TempOrigins)) then
    begin
      Result := True;

      if assigned(TempOrigins) then
        aOrigins := TempOrigins;
    end;
end;

function TCoreWebView2Frame.RemoveHostObjectFromScript(const aName : wvstring) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveHostObjectFromScript(PWideChar(aName)));
end;

function TCoreWebView2Frame.ExecuteScript(const JavaScript: wvstring; aExecutionID : integer; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2ExecuteScriptCompletedHandler;
begin
  Result := False;

  if assigned(FBaseIntf2) and (length(JavaScript) > 0) then
    try
      TempHandler := TCoreWebView2ExecuteScriptCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), aExecutionID);
      Result      := succeeded(FBaseIntf2.ExecuteScript(PWideChar(JavaScript), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Frame.PostWebMessageAsJson(const aWebMessageAsJson : wvstring) : boolean;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.PostWebMessageAsJson(PWideChar(aWebMessageAsJson)));
end;

function TCoreWebView2Frame.PostWebMessageAsString(const aWebMessageAsString : wvstring) : boolean;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.PostWebMessageAsString(PWideChar(aWebMessageAsString)));
end;

function TCoreWebView2Frame.PostSharedBufferToScript(const aSharedBuffer         : ICoreWebView2SharedBuffer;
                                                           aAccess               : TWVSharedBufferAccess;
                                                     const aAdditionalDataAsJson : wvstring): boolean;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.PostSharedBufferToScript(aSharedBuffer, aAccess, PWideChar(aAdditionalDataAsJson)));
end;

end.
