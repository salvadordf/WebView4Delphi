unit uWVCoreWebView2FrameInfoCollectionIterator;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// Collection of FrameInfos (name and source). Used to list the affected
  /// frames' info when a frame-only render process failure occurs in the
  /// ICoreWebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollection">See the ICoreWebView2FrameInfoCollection article.</see></para>
  /// </remarks>
  TCoreWebView2FrameInfoCollectionIterator = class
    protected
      FBaseIntf : ICoreWebView2FrameInfoCollectionIterator;

      function  GetInitialized : boolean;
      function  GetHasCurrent : boolean;
      function  GetCurrent : ICoreWebView2FrameInfo;

    public
      constructor Create(const aBaseIntf : ICoreWebView2FrameInfoCollectionIterator); reintroduce;
      destructor  Destroy; override;
      function    MoveNext : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2FrameInfoCollectionIterator   read FBaseIntf;
      property HasCurrent  : boolean                                    read GetHasCurrent;
      property Current     : ICoreWebView2FrameInfo                     read GetCurrent;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2FrameInfoCollectionIterator.Create(const aBaseIntf: ICoreWebView2FrameInfoCollectionIterator);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2FrameInfoCollectionIterator.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameInfoCollectionIterator.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2FrameInfoCollectionIterator.GetHasCurrent : boolean;
var
  TempHasCurrent : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasCurrent(TempHasCurrent)) and
            (TempHasCurrent <> 0);
end;

function TCoreWebView2FrameInfoCollectionIterator.GetCurrent : ICoreWebView2FrameInfo;
var
  TempResult : ICoreWebView2FrameInfo;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetCurrent(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2FrameInfoCollectionIterator.MoveNext : boolean;
var
  TempHasNext : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.MoveNext(TempHasNext)) and
            (TempHasNext <> 0);
end;

end.
