unit uWVCoreWebView2Notification;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes,
  {$ELSE}
  Classes,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// This is the ICoreWebView2Notification that represents a [HTML Notification
  /// object](https://developer.mozilla.org/docs/Web/API/Notification).
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification">See the ICoreWebView2Notification article.</see></para>
  /// </remarks>
  TCoreWebView2Notification = class
    protected
      FBaseIntf            : ICoreWebView2Notification;
      FCloseRequestedToken : EventRegistrationToken;

      function GetInitialized : boolean;
      function GetBody : wvstring;
      function GetDirection : TWVTextDirectionKind;
      function GetLanguage : wvstring;
      function GetTag : wvstring;
      function GetIconUri : wvstring;
      function GetTitle : wvstring;
      function GetBadgeUri : wvstring;
      function GetBodyImageUri : wvstring;
      function GetShouldRenotify : boolean;
      function GetRequiresInteraction : boolean;
      function GetIsSilent : boolean;
      function GetTimestamp : TDateTime;
      function GetVibrationPattern : Uint64Array;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function AddCloseRequestedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Notification); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// The host may run this to report the notification has been displayed and it
      /// will cause the
      /// [show](https://developer.mozilla.org/docs/Web/API/Notification/show_event)
      /// event to be raised for non-persistent notifications. You must not run this
      /// unless you are handling the `NotificationReceived` event. Returns
      /// `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `Handled` is `FALSE` when
      /// this is called.
      /// </summary>
      function ReportShown: boolean;
      /// <summary>
      /// The host may run this to report the notification has been clicked, and it
      /// will cause the
      /// [click](https://developer.mozilla.org/docs/Web/API/Notification/click_event)
      /// event to be raised for non-persistent notifications and the
      /// [notificationclick](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/notificationclick_event)
      /// event for persistent notifications. Use `ReportClickedWithActionIndex` to
      /// specify an action to activate a persistent notification. You must not run
      /// this unless you are handling the `NotificationReceived` event. Returns
      /// `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `Handled` is `FALSE` or
      /// `ReportShown` has not been run when this is called.
      /// </summary>
      function ReportClicked: boolean;
      /// <summary>
      /// The host may run this to report the notification was dismissed, and it
      /// will cause the
      /// [close](https://developer.mozilla.org/docs/Web/API/Notification/close_event)
      /// event to be raised for non-persistent notifications and the
      /// [notificationclose](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/notificationclose_event)
      /// event for persistent notifications. You must not run this unless you are
      /// handling the `NotificationReceived` event. Returns
      /// `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `Handled` is `FALSE` or
      /// `ReportShown` has not been run when this is called.
      /// </summary>
      function ReportClosed: boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                         : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                            : ICoreWebView2Notification       read FBaseIntf                            write FBaseIntf;
      /// <summary>
      /// A string representing the body text of the notification.
      /// The default value is an empty string.
      /// </summary>
      property Body                                : wvstring                        read GetBody;
      /// <summary>
      /// The text direction in which to display the notification.
      /// This corresponds to
      /// [Notification.dir](https://developer.mozilla.org/docs/Web/API/Notification/dir)
      /// DOM API.
      /// The default value is `COREWEBVIEW2_TEXT_DIRECTION_KIND_DEFAULT`.
      /// </summary>
      property Direction                           : TWVTextDirectionKind            read GetDirection;
      /// <summary>
      /// The notification's language, as intended to be specified using a string
      /// representing a language tag (such as `en-US`) according to
      /// [BCP47](https://datatracker.ietf.org/doc/html/rfc5646). Note that no
      /// validation is performed on this property and it can be any string the
      /// notification sender specifies.
      /// This corresponds to
      /// [Notification.lang](https://developer.mozilla.org/docs/Web/API/Notification/lang)
      /// DOM API.
      /// The default value is an empty string.
      /// </summary>
      property Language                            : wvstring                        read GetLanguage;
      /// <summary>
      /// A string representing an identifying tag for the notification.
      /// This corresponds to
      /// [Notification.tag](https://developer.mozilla.org/docs/Web/API/Notification/tag)
      /// DOM API.
      /// The default value is an empty string.
      /// </summary>
      property Tag                                 : wvstring                        read GetTag;
      /// <summary>
      /// A string containing the URI of an icon to be displayed in the
      /// notification.
      /// The default value is an empty string.
      /// </summary>
      property IconUri                             : wvstring                        read GetIconUri;
      /// <summary>
      /// The title of the notification.
      /// </summary>
      property Title                               : wvstring                        read GetTitle;
      /// <summary>
      /// A string containing the URI of the image used to represent the
      /// notification when there isn't enough space to display the notification
      /// itself.
      /// The default value is an empty string.
      /// </summary>
      property BadgeUri                            : wvstring                        read GetBadgeUri;
      /// <summary>
      /// A string containing the URI of an image to be displayed in the
      /// notification.
      /// The default value is an empty string.
      /// </summary>
      property BodyImageUri                        : wvstring                        read GetBodyImageUri;
      /// <summary>
      /// Indicates whether the user should be notified after a new notification
      /// replaces an old one.
      /// This corresponds to
      /// [Notification.renotify](https://developer.mozilla.org/docs/Web/API/Notification/renotify)
      /// DOM API.
      /// The default value is `FALSE`.
      /// </summary>
      property ShouldRenotify                      : boolean                         read GetShouldRenotify;
      /// <summary>
      /// A boolean value indicating that a notification should remain active until
      /// the user clicks or dismisses it, rather than closing automatically.
      /// This corresponds to
      /// [Notification.requireInteraction](https://developer.mozilla.org/docs/Web/API/Notification/requireInteraction)
      /// DOM API. Note that you may not be able to necessarily implement this due to native API limitations.
      /// The default value is `FALSE`.
      /// </summary>
      property RequiresInteraction                 : boolean                         read GetRequiresInteraction;
      /// <summary>
      /// Indicates whether the notification should be silent -- i.e., no sounds or
      /// vibrations should be issued, regardless of the device settings.
      /// This corresponds to
      /// [Notification.silent](https://developer.mozilla.org/docs/Web/API/Notification/silent)
      /// DOM API.
      /// The default value is `FALSE`.
      /// </summary>
      property IsSilent                            : boolean                         read GetIsSilent;
      /// <summary>
      /// Indicates the time at which a notification is created or applicable (past,
      /// present, or future) as the number of milliseconds since the UNIX epoch.
      /// </summary>
      property Timestamp                           : TDateTime                       read GetTimestamp;
      /// <summary>
      /// Gets the vibration pattern for devices with vibration hardware to emit.
      /// The vibration pattern can be represented by an array of 64-bit unsigned integers
      /// describing a pattern of vibrations and pauses. See [Vibration
      /// API](https://developer.mozilla.org/docs/Web/API/Vibration_API) for more
      /// information.
      /// This corresponds to
      /// [Notification.vibrate](https://developer.mozilla.org/docs/Web/API/Notification/vibrate)
      /// DOM API.
      /// An empty array is returned if no vibration patterns are
      /// specified.
      /// </summary>
      property VibrationPattern                    : Uint64Array                     read GetVibrationPattern;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.DateUtils, Winapi.ActiveX,
  {$ELSE}
  DateUtils, ActiveX,
  {$ENDIF}
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates, uWVConstants;

constructor TCoreWebView2Notification.Create(const aBaseIntf: ICoreWebView2Notification);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

function TCoreWebView2Notification.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddCloseRequestedEvent(aBrowserComponent);
end;

destructor TCoreWebView2Notification.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2Notification.InitializeFields;
begin
  FBaseIntf := nil;

  InitializeTokens;
end;

procedure TCoreWebView2Notification.InitializeTokens;
begin
  FCloseRequestedToken.value := 0;
end;

procedure TCoreWebView2Notification.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FCloseRequestedToken.value <> 0) then
        FBaseIntf.remove_CloseRequested(FCloseRequestedToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2Notification.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Notification.ReportShown: boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.ReportShown());
end;

function TCoreWebView2Notification.ReportClicked: boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.ReportClicked());
end;

function TCoreWebView2Notification.ReportClosed: boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.ReportClosed());
end;

function TCoreWebView2Notification.GetBody : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Body(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Notification.GetDirection : TWVTextDirectionKind;
var
  TempResult : COREWEBVIEW2_TEXT_DIRECTION_KIND;
begin
  Result := COREWEBVIEW2_TEXT_DIRECTION_KIND_DEFAULT;

  if Initialized and
     succeeded(FBaseIntf.Get_Direction(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2Notification.GetLanguage : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Language(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Notification.GetTag : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Tag(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Notification.GetIconUri : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_IconUri(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Notification.GetTitle : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_title(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Notification.GetBadgeUri : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_BadgeUri(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Notification.GetBodyImageUri : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_BodyImageUri(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Notification.GetShouldRenotify : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldRenotify(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2Notification.GetRequiresInteraction : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_RequiresInteraction(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2Notification.GetIsSilent : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsSilent(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2Notification.GetTimestamp : TDateTime;
var
  TempResult : double;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Timestamp(TempResult)) then
    Result := UnixToDateTime(round(TempResult){$IFDEF DELPHI20_UP}, False{$ENDIF})
   else
    Result := 0;
end;

function TCoreWebView2Notification.GetVibrationPattern : Uint64Array;
var
  TempCount, i : SYSUINT;
  TempPattern  : Uint64Array;
begin
  Result      := nil;
  TempCount   := 0;
  TempPattern := nil;

  if Initialized and
     succeeded(FBaseIntf.GetVibrationPattern(TempCount, TempPattern)) and
     (TempCount > 1) and
     (TempPattern <> nil) then
    begin
      SetLength(Result, TempCount);
      i := 0;
      while (i < TempCount) do
        begin
          Result[i] := TempPattern[i];
          inc(i);
        end;
    end;
end;

function TCoreWebView2Notification.AddCloseRequestedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2NotificationCloseRequestedEventHandler;
begin
  Result := False;

  if Initialized and (FCloseRequestedToken.value = 0) then
    try
      TempHandler := TCoreWebView2NotificationCloseRequestedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_CloseRequested(TempHandler, FCloseRequestedToken));
    finally
      TempHandler := nil;
    end;
end;

end.
