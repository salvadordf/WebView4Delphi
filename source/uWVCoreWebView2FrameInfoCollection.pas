unit uWVCoreWebView2FrameInfoCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  TCoreWebView2FrameInfoCollection = class
    protected
      FBaseIntf : ICoreWebView2FrameInfoCollection;

      function  GetInitialized : boolean;
      function  GetIterator : ICoreWebView2FrameInfoCollectionIterator;

    public
      constructor Create(const aBaseIntf : ICoreWebView2FrameInfoCollection); reintroduce;
      destructor  Destroy; override;

      property Initialized : boolean                                  read GetInitialized;
      property BaseIntf    : ICoreWebView2FrameInfoCollection         read FBaseIntf;
      property Iterator    : ICoreWebView2FrameInfoCollectionIterator read GetIterator;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2FrameInfoCollection.Create(const aBaseIntf: ICoreWebView2FrameInfoCollection);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2FrameInfoCollection.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameInfoCollection.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2FrameInfoCollection.GetIterator : ICoreWebView2FrameInfoCollectionIterator;
var
  TempIterator : ICoreWebView2FrameInfoCollectionIterator;
begin
  Result       := nil;
  TempIterator := nil;

  if Initialized and
     succeeded(FBaseIntf.GetIterator(TempIterator)) and
     assigned(TempIterator) then
    Result := TempIterator;
end;

end.
