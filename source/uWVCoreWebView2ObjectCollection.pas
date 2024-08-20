unit uWVCoreWebView2ObjectCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVCoreWebView2ObjectCollectionView;

type
  /// <summary>
  /// Represents a collection of generic objects. Used to get, remove and add
  /// objects at the specified index.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2objectcollection">See the ICoreWebView2ObjectCollection article.</see></para>
  /// </remarks>
  TCoreWebView2ObjectCollection = class(TCoreWebView2ObjectCollectionView)
    public
      /// <summary>
      /// Removes the object at the specified index.
      /// </summary>
      function RemoveValueAtIndex(index: cardinal): boolean;
      /// <summary>
      /// Inserts the object at the specified index.
      /// </summary>
      function InsertValueAtIndex(index: cardinal; const value: IUnknown): boolean;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

function TCoreWebView2ObjectCollection.RemoveValueAtIndex(index: cardinal): boolean;
begin
  Result := Initialized and
            succeeded((FBaseIntf as ICoreWebView2ObjectCollection).RemoveValueAtIndex(index));
end;

function TCoreWebView2ObjectCollection.InsertValueAtIndex(index: cardinal; const value: IUnknown): boolean;
begin
  Result := Initialized and
            succeeded((FBaseIntf as ICoreWebView2ObjectCollection).InsertValueAtIndex(index, value));
end;

end.
