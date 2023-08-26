unit uWVCoreWebView2HttpHeadersCollectionIterator;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Iterator for a collection of HTTP headers.  For more information, navigate
  /// to ICoreWebView2HttpRequestHeaders and ICoreWebView2HttpResponseHeaders.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpheaderscollectioniterator">See the ICoreWebView2HttpHeadersCollectionIterator article.</see></para>
  /// </remarks>
  TCoreWebView2HttpHeadersCollectionIterator = class
    protected
      FBaseIntf : ICoreWebView2HttpHeadersCollectionIterator;

      function  GetInitialized : boolean;
      function  GetHasCurrentHeader : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2HttpHeadersCollectionIterator); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Get the name and value of the current HTTP header of the iterator.  If
      /// the previous `MoveNext` operation set the `hasNext` parameter to `FALSE`,
      /// this method fails.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpheaderscollectioniterator#getcurrentheader">See the ICoreWebView2HttpHeadersCollectionIterator article.</see></para>
      /// </remarks>
      function    GetCurrentHeader(var aName, aValue: wvstring): boolean;
      /// <summary>
      /// <para>Move the iterator to the next HTTP header in the collection.</para>
      /// <para>\> [!NOTE]\n \> If no more HTTP headers exist, the `hasNext` parameter is set to
      /// `FALSE`.  After this occurs the `GetCurrentHeader` method fails.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpheaderscollectioniterator#movenext">See the ICoreWebView2HttpHeadersCollectionIterator article.</see></para>
      /// </remarks>
      function    MoveNext : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized       : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf          : ICoreWebView2HttpHeadersCollectionIterator   read FBaseIntf;
      /// <summary>
      /// `TRUE` when the iterator has not run out of headers.  If the collection
      /// over which the iterator is iterating is empty or if the iterator has gone
      ///  past the end of the collection then this is `FALSE`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpheaderscollectioniterator#get_hascurrentheader">See the ICoreWebView2HttpHeadersCollectionIterator article.</see></para>
      /// </remarks>
      property HasCurrentHeader  : boolean                                      read GetHasCurrentHeader;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2HttpHeadersCollectionIterator.Create(const aBaseIntf: ICoreWebView2HttpHeadersCollectionIterator);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2HttpHeadersCollectionIterator.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2HttpHeadersCollectionIterator.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2HttpHeadersCollectionIterator.GetHasCurrentHeader : boolean;
var
  TempHasCurrent : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasCurrentHeader(TempHasCurrent)) and
            (TempHasCurrent <> 0);
end;

function TCoreWebView2HttpHeadersCollectionIterator.GetCurrentHeader(var aName, aValue : wvstring): boolean;
var
  TempName, TempValue : PWideChar;
begin
  Result    := False;
  aName     := '';
  aValue    := '';
  TempName  := nil;
  TempValue := nil;

  if Initialized and succeeded(FBaseIntf.GetCurrentHeader(TempName, TempValue)) then
    begin
      Result := True;
      aName  := TempName;
      aValue := TempValue;
      CoTaskMemFree(TempName);
      CoTaskMemFree(TempValue);
    end;
end;

function TCoreWebView2HttpHeadersCollectionIterator.MoveNext : boolean;
var
  TempHasNext : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.MoveNext(TempHasNext)) and
            (TempHasNext <> 0);
end;

end.
