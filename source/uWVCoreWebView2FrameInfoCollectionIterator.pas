unit uWVCoreWebView2FrameInfoCollectionIterator;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// Iterator for a collection of FrameInfos. For more info, see
  /// ICoreWebView2ProcessFailedEventArgs2 and
  /// ICoreWebView2FrameInfoCollection.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollectioniterator">See the ICoreWebView2FrameInfoCollectionIterator article.</see></para>
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
      /// <summary>
      /// Move the iterator to the next `FrameInfo` in the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollectioniterator#movenext">See the ICoreWebView2FrameInfoCollectionIterator article.</see></para>
      /// </remarks>
      function    MoveNext : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2FrameInfoCollectionIterator   read FBaseIntf;
      /// <summary>
      /// `TRUE` when the iterator has not run out of `FrameInfo`s.  If the
      /// collection over which the iterator is iterating is empty or if the
      /// iterator has gone past the end of the collection, then this is `FALSE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollectioniterator#get_hascurrent">See the ICoreWebView2FrameInfoCollectionIterator article.</see></para>
      /// </remarks>
      property HasCurrent  : boolean                                    read GetHasCurrent;
      /// <summary>
      /// Get the current `ICoreWebView2FrameInfo` of the iterator.
      /// Returns `HRESULT_FROM_WIN32(ERROR_INVALID_INDEX)` if HasCurrent is
      /// `FALSE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollectioniterator#getcurrent">See the ICoreWebView2FrameInfoCollectionIterator article.</see></para>
      /// </remarks>
      property Current     : ICoreWebView2FrameInfo                     read GetCurrent;
  end;

  {
    function MoveNext(out hasNext: Integer): HResult; stdcall;
  }

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
