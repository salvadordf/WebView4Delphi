unit uWVCoreWebView2Profile;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Profile = class
    protected
      FBaseIntf  : ICoreWebView2Profile;
      FBaseIntf2 : ICoreWebView2Profile2;
      FBaseIntf3 : ICoreWebView2Profile3;
      FBaseIntf4 : ICoreWebView2Profile4;
      FBaseIntf5 : ICoreWebView2Profile5;
      FBaseIntf6 : ICoreWebView2Profile6;

      function GetInitialized : boolean;
      function GetProfileName : wvstring;
      function GetIsInPrivateModeEnabled : boolean;
      function GetProfilePath : wvstring;
      function GetDefaultDownloadFolderPath : wvstring;
      function GetPreferredColorScheme : TWVPreferredColorScheme;
      function GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
      function GetCookieManager : ICoreWebView2CookieManager;
      function GetIsPasswordAutosaveEnabled : boolean;
      function GetIsGeneralAutofillEnabled : boolean;

      procedure SetDefaultDownloadFolderPath(const aValue : wvstring);
      procedure SetPreferredColorScheme(aValue : TWVPreferredColorScheme);
      procedure SetPreferredTrackingPreventionLevel(aValue : TWVTrackingPreventionLevel);
      procedure SetIsPasswordAutosaveEnabled(aValue : boolean);
      procedure SetIsGeneralAutofillEnabled(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Profile); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Clear browsing data based on a data type. This method takes two parameters,
      /// the first being a mask of one or more `COREWEBVIEW2_BROWSING_DATA_KINDS`. OR
      /// operation(s) can be applied to multiple `COREWEBVIEW2_BROWSING_DATA_KINDS` to
      /// create a mask representing those data types. The browsing data kinds that are
      /// supported are listed below. These data kinds follow a hierarchical structure in
      /// which nested bullet points are included in their parent bullet point's data kind.
      /// Ex: All DOM storage is encompassed in all site data which is encompassed in
      /// all profile data.
      /// * All Profile
      ///   * All Site Data
      ///     * All DOM Storage: File Systems, Indexed DB, Local Storage, Web SQL, Cache
      ///         Storage
      ///     * Cookies
      ///   * Disk Cache
      ///   * Download History
      ///   * General Autofill
      ///   * Password Autosave
      ///   * Browsing History
      ///   * Settings
      /// The completed handler will be invoked when the browsing data has been cleared and
      /// will indicate if the specified data was properly cleared. In the case in which
      /// the operation is interrupted and the corresponding data is not fully cleared
      /// the handler will return `E_ABORT` and otherwise will return `S_OK`.
      /// Because this is an asynchronous operation, code that is dependent on the cleared
      /// data must be placed in the callback of this operation.
      /// If the WebView object is closed before the clear browsing data operation
      /// has completed, the handler will be released, but not invoked. In this case
      /// the clear browsing data operation may or may not be completed.
      /// ClearBrowsingData clears the `dataKinds` regardless of timestamp.
      /// </summary>
      function    ClearBrowsingData(dataKinds: TWVBrowsingDataKinds; const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      /// <summary>
      /// ClearBrowsingDataInTimeRange behaves like ClearBrowsingData except that it
      /// takes in two additional parameters for the start and end time for which it
      /// should clear the data between.  The `startTime` and `endTime`
      /// parameters correspond to the number of seconds since the UNIX epoch.
      /// `startTime` is inclusive while `endTime` is exclusive, therefore the data will
      /// be cleared between [startTime, endTime).
      /// </summary>
      function    ClearBrowsingDataInTimeRange(dataKinds: TWVBrowsingDataKinds; const startTime, endTime: TDateTime; const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      /// <summary>
      /// ClearBrowsingDataAll behaves like ClearBrowsingData except that it
      /// clears the entirety of the data associated with the profile it is called on.
      /// It clears the data regardless of timestamp.
      ///
      /// \snippet AppWindow.cpp ClearBrowsingData
      /// </summary>
      function    ClearBrowsingDataAll(const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      /// <summary>
      /// Sets permission state for the given permission kind and origin
      /// asynchronously. The change persists across sessions until it is changed by
      /// another call to `SetPermissionState`, or by setting the `State` property
      /// in `PermissionRequestedEventArgs`. Setting the state to
      /// `COREWEBVIEW2_PERMISSION_STATE_DEFAULT` will erase any state saved in the
      /// profile and restore the default behavior.
      /// The origin should have a valid scheme and host (e.g. "https://www.example.com"),
      /// otherwise the method fails with `E_INVALIDARG`. Additional URI parts like
      /// path and fragment are ignored. For example, "https://wwww.example.com/app1/index.html/"
      /// is treated the same as "https://wwww.example.com". See the
      /// [MDN origin definition](https://developer.mozilla.org/en-US/docs/Glossary/Origin)
      /// for more details.
      ///
      /// \snippet ScenarioPermissionManagement.cpp SetPermissionState
      /// </summary>
      function    SetPermissionState(PermissionKind: TWVPermissionKind; const origin: wvstring; State: TWVPermissionState; const completedHandler: ICoreWebView2SetPermissionStateCompletedHandler): boolean;
      /// <summary>
      /// Invokes the handler with a collection of all nondefault permission settings.
      /// Use this method to get the permission state set in the current and previous
      /// sessions.
      ///
      /// \snippet ScenarioPermissionManagement.cpp GetNonDefaultPermissionSettings
      /// </summary>
      function    GetNonDefaultPermissionSettings(const completedHandler: ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler): boolean;

      property Initialized                       : boolean                     read GetInitialized;
      property BaseIntf                          : ICoreWebView2Profile        read FBaseIntf                            write FBaseIntf;
      property ProfileName                       : wvstring                    read GetProfileName;
      property IsInPrivateModeEnabled            : boolean                     read GetIsInPrivateModeEnabled;
      property ProfilePath                       : wvstring                    read GetProfilePath;
      property DefaultDownloadFolderPath         : wvstring                    read GetDefaultDownloadFolderPath         write SetDefaultDownloadFolderPath;
      property PreferredColorScheme              : TWVPreferredColorScheme     read GetPreferredColorScheme              write SetPreferredColorScheme;
      property PreferredTrackingPreventionLevel  : TWVTrackingPreventionLevel  read GetPreferredTrackingPreventionLevel  write SetPreferredTrackingPreventionLevel;
      property CookieManager                     : ICoreWebView2CookieManager  read GetCookieManager;
      property IsPasswordAutosaveEnabled         : boolean                     read GetIsPasswordAutosaveEnabled         write SetIsPasswordAutosaveEnabled;
      property IsGeneralAutofillEnabled          : boolean                     read GetIsGeneralAutofillEnabled          write SetIsGeneralAutofillEnabled;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.DateUtils, Winapi.ActiveX,
  {$ELSE}
  DateUtils, ActiveX,
  {$ENDIF}
  uWVMiscFunctions;

constructor TCoreWebView2Profile.Create(const aBaseIntf: ICoreWebView2Profile);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf  := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile3, FBaseIntf3) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile4, FBaseIntf4) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile5, FBaseIntf5) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile6, FBaseIntf6);
end;

destructor TCoreWebView2Profile.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2Profile.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
  FBaseIntf4 := nil;
  FBaseIntf5 := nil;
  FBaseIntf6 := nil;
end;

function TCoreWebView2Profile.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Profile.GetProfileName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ProfileName(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Profile.GetIsInPrivateModeEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsInPrivateModeEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Profile.GetProfilePath : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ProfilePath(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Profile.GetDefaultDownloadFolderPath : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DefaultDownloadFolderPath(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Profile.GetPreferredColorScheme : TWVPreferredColorScheme;
var
  TempResult : COREWEBVIEW2_PREFERRED_COLOR_SCHEME;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_PreferredColorScheme(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2Profile.GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
var
  TempResult : COREWEBVIEW2_TRACKING_PREVENTION_LEVEL;
begin
  Result := COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED;

  if assigned(FBaseIntf3) and
     succeeded(FBaseIntf3.Get_PreferredTrackingPreventionLevel(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2Profile.GetCookieManager : ICoreWebView2CookieManager;
var
  TempResult : ICoreWebView2CookieManager;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf5) and
     succeeded(FBaseIntf5.Get_CookieManager(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2Profile.GetIsPasswordAutosaveEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.Get_IsPasswordAutosaveEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Profile.GetIsGeneralAutofillEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.Get_IsGeneralAutofillEnabled(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2Profile.SetDefaultDownloadFolderPath(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_DefaultDownloadFolderPath(PWideChar(aValue));
end;

procedure TCoreWebView2Profile.SetPreferredColorScheme(aValue : TWVPreferredColorScheme);
begin
  if Initialized then
    FBaseIntf.Set_PreferredColorScheme(aValue);
end;

procedure TCoreWebView2Profile.SetPreferredTrackingPreventionLevel(aValue : TWVTrackingPreventionLevel);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_PreferredTrackingPreventionLevel(aValue);
end;

procedure TCoreWebView2Profile.SetIsPasswordAutosaveEnabled(aValue: boolean);
begin
  if assigned(FBaseIntf6) then
    FBaseIntf6.Set_IsPasswordAutosaveEnabled(ord(aValue));
end;

procedure TCoreWebView2Profile.SetIsGeneralAutofillEnabled(aValue: boolean);
begin
  if assigned(FBaseIntf6) then
    FBaseIntf6.Set_IsGeneralAutofillEnabled(ord(aValue));
end;

function TCoreWebView2Profile.ClearBrowsingData(      dataKinds : TWVBrowsingDataKinds;
                                                const handler   : ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf2) and
            assigned(handler)    and
            succeeded(FBaseIntf2.ClearBrowsingData(dataKinds, handler));
end;

function TCoreWebView2Profile.ClearBrowsingDataInTimeRange(      dataKinds : TWVBrowsingDataKinds;
                                                           const startTime : TDateTime;
                                                           const endTime   : TDateTime;
                                                           const handler   : ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
var
  TempStart, TempEnd : int64;
begin
  Result := False;

  if assigned(FBaseIntf2) and
     assigned(handler)    then
    begin
      TempStart := DateTimeToUnix(startTime{$IFDEF DELPHI20_UP}, False{$ENDIF});
      TempEnd   := DateTimeToUnix(endTime{$IFDEF DELPHI20_UP}, False{$ENDIF});
      Result    := succeeded(FBaseIntf2.ClearBrowsingDataInTimeRange(dataKinds, TempStart, TempEnd, handler));
    end;
end;

function TCoreWebView2Profile.ClearBrowsingDataAll(const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf2) and
            assigned(handler)    and
            succeeded(FBaseIntf2.ClearBrowsingDataAll(handler));
end;

function TCoreWebView2Profile.SetPermissionState(      PermissionKind   : TWVPermissionKind;
                                                 const origin           : wvstring;
                                                       State            : TWVPermissionState;
                                                 const completedHandler : ICoreWebView2SetPermissionStateCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf4)       and
            assigned(completedHandler) and
            succeeded(FBaseIntf4.SetPermissionState(PermissionKind, PWideChar(origin), State, completedHandler));
end;

function TCoreWebView2Profile.GetNonDefaultPermissionSettings(const completedHandler: ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf4)       and
            assigned(completedHandler) and
            succeeded(FBaseIntf4.GetNonDefaultPermissionSettings(completedHandler));
end;

end.

