unit uWVCoreWebView2ControllerOptions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2ControllerOptions = class
    protected
      FBaseIntf : ICoreWebView2ControllerOptions;

      function GetInitialized : boolean;
      function GetProfileName : wvstring;
      function GetIsInPrivateModeEnabled : boolean;

      procedure SetProfileName(const aValue : wvstring);
      procedure SetIsInPrivateModeEnabled(aValue : boolean);

    public
      constructor Create(const aBaseIntf : ICoreWebView2ControllerOptions); reintroduce;
      destructor  Destroy; override;

      property Initialized             : boolean                        read GetInitialized;
      property BaseIntf                : ICoreWebView2ControllerOptions read FBaseIntf                  write FBaseIntf;
      property ProfileName             : wvstring                       read GetProfileName             write SetProfileName;
      property IsInPrivateModeEnabled  : boolean                        read GetIsInPrivateModeEnabled  write SetIsInPrivateModeEnabled;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ControllerOptions.Create(const aBaseIntf : ICoreWebView2ControllerOptions);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ControllerOptions.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ControllerOptions.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ControllerOptions.GetProfileName : wvstring;
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

function TCoreWebView2ControllerOptions.GetIsInPrivateModeEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsInPrivateModeEnabled(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2ControllerOptions.SetProfileName(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_ProfileName(PWideChar(aValue));
end;

procedure TCoreWebView2ControllerOptions.SetIsInPrivateModeEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsInPrivateModeEnabled(ord(aValue));
end;

end.
