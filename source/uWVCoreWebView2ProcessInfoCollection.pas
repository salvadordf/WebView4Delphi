unit uWVCoreWebView2ProcessInfoCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  TCoreWebView2ProcessInfoCollection = class
    protected
      FBaseIntf : ICoreWebView2ProcessInfoCollection;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2ProcessInfo;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ProcessInfoCollection); reintroduce;
      destructor  Destroy; override;

      property Initialized           : boolean                                      read GetInitialized;
      property BaseIntf              : ICoreWebView2ProcessInfoCollection           read FBaseIntf;
      property Count                 : cardinal                                     read GetCount;
      property Items[idx : cardinal] : ICoreWebView2ProcessInfo                     read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ProcessInfoCollection.Create(const aBaseIntf: ICoreWebView2ProcessInfoCollection);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ProcessInfoCollection.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ProcessInfoCollection.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ProcessInfoCollection.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ProcessInfoCollection.GetValueAtIndex(index : cardinal) : ICoreWebView2ProcessInfo;
var
  TempResult : ICoreWebView2ProcessInfo;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

end.
