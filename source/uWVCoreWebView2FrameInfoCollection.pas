unit uWVCoreWebView2FrameInfoCollection;

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
  TCoreWebView2FrameInfoCollection = class
    protected
      FBaseIntf : ICoreWebView2FrameInfoCollection;

      function  GetInitialized : boolean;
      function  GetIterator : ICoreWebView2FrameInfoCollectionIterator;

    public
      constructor Create(const aBaseIntf : ICoreWebView2FrameInfoCollection); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                  read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2FrameInfoCollection         read FBaseIntf;
      /// <summary>
      /// Gets an iterator over the collection of `FrameInfo`s.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollection#getiterator">See the ICoreWebView2FrameInfoCollection article.</see></para>
      /// </remarks>
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
