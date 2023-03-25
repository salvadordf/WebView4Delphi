unit uWVCoreWebView2PermissionSetting;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2PermissionSetting = class
    protected
      FBaseIntf  : ICoreWebView2PermissionSetting;

      function  GetInitialized : boolean;
      function  GetPermissionKind : TWVPermissionKind;
      function  GetPermissionOrigin : wvstring;
      function  GetPermissionState : TWVPermissionState;

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2PermissionSetting); reintroduce;
      destructor  Destroy; override;

      property    Initialized      : boolean                         read GetInitialized;
      property    BaseIntf         : ICoreWebView2PermissionSetting  read FBaseIntf;
      property    PermissionKind   : TWVPermissionKind               read GetPermissionKind;
      property    PermissionOrigin : wvstring                        read GetPermissionOrigin;
      property    PermissionState  : TWVPermissionState              read GetPermissionState;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVMiscFunctions;


constructor TCoreWebView2PermissionSetting.Create(const aBaseIntf : ICoreWebView2PermissionSetting);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2PermissionSetting.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2PermissionSetting.InitializeFields;
begin
  FBaseIntf  := nil;
end;

function TCoreWebView2PermissionSetting.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2PermissionSetting.GetPermissionKind : TWVPermissionKind;
var
  TempResult : COREWEBVIEW2_PERMISSION_KIND;
begin
  Result := COREWEBVIEW2_PERMISSION_KIND_UNKNOWN_PERMISSION;

  if Initialized and
     succeeded(FBaseIntf.Get_PermissionKind(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2PermissionSetting.GetPermissionOrigin : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_PermissionOrigin(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2PermissionSetting.GetPermissionState : TWVPermissionState;
var
  TempResult : COREWEBVIEW2_PERMISSION_STATE;
begin
  Result := COREWEBVIEW2_PERMISSION_STATE_DEFAULT;

  if Initialized and
     succeeded(FBaseIntf.Get_PermissionState(TempResult)) then
    Result := TempResult;
end;

end.
