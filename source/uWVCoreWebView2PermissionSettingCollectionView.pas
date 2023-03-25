unit uWVCoreWebView2PermissionSettingCollectionView;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2PermissionSettingCollectionView = class
    protected
      FBaseIntf  : ICoreWebView2PermissionSettingCollectionView;

      function  GetInitialized : boolean;
      function  GetValueAtIndex(idx : cardinal) : ICoreWebView2PermissionSetting;
      function  GetCount : cardinal;

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2PermissionSettingCollectionView); reintroduce;
      destructor  Destroy; override;

      property    Initialized                      : boolean                                       read GetInitialized;
      property    BaseIntf                         : ICoreWebView2PermissionSettingCollectionView  read FBaseIntf;
      property    ValueAtIndex[idx : cardinal]     : ICoreWebView2PermissionSetting                read GetValueAtIndex;
      property    Count                            : cardinal                                      read GetCount;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVMiscFunctions;


constructor TCoreWebView2PermissionSettingCollectionView.Create(const aBaseIntf : ICoreWebView2PermissionSettingCollectionView);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2PermissionSettingCollectionView.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2PermissionSettingCollectionView.InitializeFields;
begin
  FBaseIntf  := nil;
end;

function TCoreWebView2PermissionSettingCollectionView.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2PermissionSettingCollectionView.GetValueAtIndex(idx : cardinal) : ICoreWebView2PermissionSetting;
var
  TempResult : ICoreWebView2PermissionSetting;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf) and
     succeeded(FBaseIntf.GetValueAtIndex(idx, TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2PermissionSettingCollectionView.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result := 0;

  if assigned(FBaseIntf) and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

end.
