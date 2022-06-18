unit uWVCoreWebView2Profile;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Profile = class
    protected
      FBaseIntf  : ICoreWebView2Profile;
      FBaseIntf2 : ICoreWebView2Profile2;

      function GetInitialized : boolean;
      function GetProfileName : wvstring;
      function GetIsInPrivateModeEnabled : boolean;
      function GetProfilePath : wvstring;
      function GetDefaultDownloadFolderPath : wvstring;
      function GetPreferredColorScheme : TWVPreferredColorScheme;

      procedure SetDefaultDownloadFolderPath(const aValue : wvstring);
      procedure SetPreferredColorScheme(aValue : TWVPreferredColorScheme);

    public
      constructor Create(const aBaseIntf : ICoreWebView2Profile); reintroduce;
      destructor  Destroy; override;
      function    ClearBrowsingData(dataKinds: TWVBrowsingDataKinds; const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      function    ClearBrowsingDataInTimeRange(dataKinds: TWVBrowsingDataKinds; const startTime, endTime: TDateTime; const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      function    ClearBrowsingDataAll(const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;

      property Initialized                : boolean                     read GetInitialized;
      property BaseIntf                   : ICoreWebView2Profile        read FBaseIntf                     write FBaseIntf;
      property ProfileName                : wvstring                    read GetProfileName;
      property IsInPrivateModeEnabled     : boolean                     read GetIsInPrivateModeEnabled;
      property ProfilePath                : wvstring                    read GetProfilePath;
      property DefaultDownloadFolderPath  : wvstring                    read GetDefaultDownloadFolderPath  write SetDefaultDownloadFolderPath;
      property PreferredColorScheme       : TWVPreferredColorScheme     read GetPreferredColorScheme       write SetPreferredColorScheme;
  end;

implementation

uses
  {$IFDEF FPC}
  DateUtils, ActiveX,
  {$ELSE}
  System.DateUtils, Winapi.ActiveX,
  {$ENDIF}
  uWVMiscFunctions;

constructor TCoreWebView2Profile.Create(const aBaseIntf: ICoreWebView2Profile);
begin
  inherited Create;

  FBaseIntf  := aBaseIntf;
  FBaseIntf2 := nil;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile2, FBaseIntf2);
end;

destructor TCoreWebView2Profile.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
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

end.

