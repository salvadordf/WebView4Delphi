unit uWVCoreWebView2RegionRectCollectionView;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows,
  {$ELSE}
  Windows,
  {$ENDIF}
  uWVTypeLibrary;

type
  /// <summary>
  /// A collection of RECT.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2regionrectcollectionview">See the ICoreWebView2RegionRectCollectionView article.</see></para>
  /// </remarks>
  TCoreWebView2RegionRectCollectionView = class
    protected
      FBaseIntf : ICoreWebView2RegionRectCollectionView;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : TRect;

    public
      constructor Create(const aBaseIntf : ICoreWebView2RegionRectCollectionView); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2RegionRectCollectionView        read FBaseIntf;
      /// <summary>
      /// The number of elements contained in the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2regionrectcollectionview#get_count">See the ICoreWebView2RegionRectCollectionView article.</see></para>
      /// </remarks>
      property Count                 : cardinal                                     read GetCount;
      /// <summary>
      /// Gets the element at the given index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2regionrectcollectionview#getvalueatindex">See the ICoreWebView2RegionRectCollectionView article.</see></para>
      /// </remarks>
      property Items[idx : cardinal] : TRect                                        read GetValueAtIndex;

  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2RegionRectCollectionView.Create(const aBaseIntf: ICoreWebView2RegionRectCollectionView);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2RegionRectCollectionView.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2RegionRectCollectionView.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2RegionRectCollectionView.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2RegionRectCollectionView.GetValueAtIndex(index : cardinal) : TRect;
var
  TempResult : uWVTypeLibrary.tagRECT;
begin
  Result.Left   := 0;
  Result.Top    := 0;
  Result.Right  := 0;
  Result.Bottom := 0;

  TempResult := Result;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) then
    Result := TempResult;
end;

end.
