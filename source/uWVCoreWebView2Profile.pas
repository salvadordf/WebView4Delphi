unit uWVCoreWebView2Profile;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Profile = class
    protected
      FBaseIntf : ICoreWebView2Profile;

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
  ActiveX;
  {$ELSE}
  Winapi.ActiveX;
  {$ENDIF}

constructor TCoreWebView2Profile.Create(const aBaseIntf: ICoreWebView2Profile);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
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

end.

