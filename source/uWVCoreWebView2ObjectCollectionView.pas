unit uWVCoreWebView2ObjectCollectionView;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  TCoreWebView2ObjectCollectionView = class
    protected
      FBaseIntf : ICoreWebView2ObjectCollectionView;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : IUnknown;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ObjectCollectionView); reintroduce;
      destructor  Destroy; override;

      property Initialized           : boolean                                      read GetInitialized;
      property BaseIntf              : ICoreWebView2ObjectCollectionView            read FBaseIntf;
      property Count                 : cardinal                                     read GetCount;
      property Items[idx : cardinal] : IUnknown                                     read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ObjectCollectionView.Create(const aBaseIntf: ICoreWebView2ObjectCollectionView);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ObjectCollectionView.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ObjectCollectionView.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ObjectCollectionView.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ObjectCollectionView.GetValueAtIndex(index : cardinal) : IUnknown;
var
  TempResult : IUnknown;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

end.
