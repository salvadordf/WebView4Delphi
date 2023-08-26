unit uWVCoreWebView2PermissionSetting;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides a set of properties for a permission setting.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsetting">See the ICoreWebView2PermissionSetting article.</see></para>
  /// </remarks>
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

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property    Initialized      : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property    BaseIntf         : ICoreWebView2PermissionSetting  read FBaseIntf;
      /// <summary>
      /// The kind of the permission setting. See `COREWEBVIEW2_PERMISSION_KIND` for
      /// more details.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsetting#get_permissionkind">See the ICoreWebView2PermissionSetting article.</see></para>
      /// </remarks>
      property    PermissionKind   : TWVPermissionKind               read GetPermissionKind;
      /// <summary>
      /// The origin of the permission setting.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsetting#get_permissionorigin">See the ICoreWebView2PermissionSetting article.</see></para>
      /// </remarks>
      property    PermissionOrigin : wvstring                        read GetPermissionOrigin;
      /// <summary>
      /// The state of the permission setting.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsetting#get_permissionstate">See the ICoreWebView2PermissionSetting article.</see></para>
      /// </remarks>
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
