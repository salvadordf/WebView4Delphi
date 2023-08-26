unit uWVCoreWebView2PermissionSettingCollectionView;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Read-only collection of PermissionSettings (origin, kind, and state). Used to list
  /// the nondefault permission settings on the profile that are persisted across
  /// sessions.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsettingcollectionview">See the ICoreWebView2PermissionSettingCollectionView article.</see></para>
  /// </remarks>
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

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property    Initialized                      : boolean                                       read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property    BaseIntf                         : ICoreWebView2PermissionSettingCollectionView  read FBaseIntf;
      /// <summary>
      /// Gets the `ICoreWebView2PermissionSetting` at the specified index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsettingcollectionview#getvalueatindex">See the ICoreWebView2PermissionSettingCollectionView article.</see></para>
      /// </remarks>
      property    ValueAtIndex[idx : cardinal]     : ICoreWebView2PermissionSetting                read GetValueAtIndex;
      /// <summary>
      /// The number of `ICoreWebView2PermissionSetting`s in the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsettingcollectionview#get_count">See the ICoreWebView2PermissionSettingCollectionView article.</see></para>
      /// </remarks>
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
