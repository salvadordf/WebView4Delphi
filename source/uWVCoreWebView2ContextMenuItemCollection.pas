unit uWVCoreWebView2ContextMenuItemCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Represents a collection of ContextMenuItem objects. Used to get, remove and add
  /// ContextMenuItem objects at the specified index.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
  /// </remarks>
  TCoreWebView2ContextMenuItemCollection = class
    protected
      FBaseIntf : ICoreWebView2ContextMenuItemCollection;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2ContextMenuItem;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ContextMenuItemCollection); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Removes the `ContextMenuItem` at the specified index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#removevalueatindex">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      function    RemoveValueAtIndex(index: cardinal): boolean;
      /// <summary>
      /// Inserts the `ContextMenuItem` at the specified index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#insertvalueatindex">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      function    InsertValueAtIndex(index: cardinal; const aValue: ICoreWebView2ContextMenuItem): boolean;
      /// <summary>
      /// Appends the aValue item at the end of the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#insertvalueatindex">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      function    AppendValue(const aValue: ICoreWebView2ContextMenuItem): boolean;
      /// <summary>
      /// Removes all items from the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#removevalueatindex">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      procedure   RemoveAllMenuItems;
      /// <summary>
      /// Removes the item with the commandId value specified in the paramaters.
      /// </summary>
      /// <param name="aCommandId">The commandId value of the item that has to be removed.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#removevalueatindex">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      procedure   RemoveMenuItem(aCommandId : integer); overload;
      /// <summary>
      /// Removes the item with the label value specified in the paramaters.
      /// </summary>
      /// <param name="aLabel">The label value of the item that has to be removed.</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#removevalueatindex">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      procedure   RemoveMenuItem(const aLabel : wvstring); overload;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2ContextMenuItemCollection       read FBaseIntf;
      /// <summary>
      /// Gets the number of `ContextMenuItem` objects contained in the `ContextMenuItemCollection`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#get_count">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      property Count                 : cardinal                                     read GetCount;
      /// <summary>
      /// Gets the `ContextMenuItem` at the specified index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection#getvalueatindex">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
      /// </remarks>
      property Items[idx : cardinal] : ICoreWebView2ContextMenuItem                 read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.SysUtils, Winapi.ActiveX,
  {$ELSE}
  SysUtils, ActiveX,
  {$ENDIF}
  uWVCoreWebView2ContextMenuItem;

constructor TCoreWebView2ContextMenuItemCollection.Create(const aBaseIntf: ICoreWebView2ContextMenuItemCollection);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ContextMenuItemCollection.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ContextMenuItemCollection.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ContextMenuItemCollection.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuItemCollection.GetValueAtIndex(index : cardinal) : ICoreWebView2ContextMenuItem;
var
  TempResult : ICoreWebView2ContextMenuItem;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuItemCollection.RemoveValueAtIndex(index: cardinal): boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.RemoveValueAtIndex(index));
end;

function TCoreWebView2ContextMenuItemCollection.InsertValueAtIndex(index: cardinal; const aValue: ICoreWebView2ContextMenuItem): boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.InsertValueAtIndex(index, aValue));
end;

function TCoreWebView2ContextMenuItemCollection.AppendValue(const aValue: ICoreWebView2ContextMenuItem): boolean;
begin
  Result := Initialized and
            InsertValueAtIndex(Count, aValue);
end;

procedure TCoreWebView2ContextMenuItemCollection.RemoveAllMenuItems;
var
  i : cardinal;
begin
  if (Count > 0) then
    for i := pred(Count) downto 0 do
      RemoveValueAtIndex(i);
end;

procedure TCoreWebView2ContextMenuItemCollection.RemoveMenuItem(aCommandId : integer);
var
  TempItem : TCoreWebView2ContextMenuItem;
  i        : cardinal;
begin
  TempItem := nil;

  try
    if (Count > 0) then
      for i := pred(Count) downto 0 do
        begin
          if assigned(TempItem) then
            TempItem.BaseIntf := Items[i]
           else
            TempItem := TCoreWebView2ContextMenuItem.Create(Items[i]);

          if (TempItem.Kind      = COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_COMMAND) and
             (TempItem.CommandId = aCommandId) then
            begin
              RemoveValueAtIndex(i);
              break;
            end;
        end;
  finally
    if assigned(TempItem) then
      FreeAndNil(TempItem);
  end;
end;

procedure TCoreWebView2ContextMenuItemCollection.RemoveMenuItem(const aLabel : wvstring);
var
  TempItem : TCoreWebView2ContextMenuItem;
  i        : cardinal;
begin
  TempItem := nil;

  try
    if (Count > 0) then
      for i := pred(Count) downto 0 do
        begin
          if assigned(TempItem) then
            TempItem.BaseIntf := Items[i]
           else
            TempItem := TCoreWebView2ContextMenuItem.Create(Items[i]);

          if (TempItem.Kind   = COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_COMMAND) and
             (TempItem.Label_ = aLabel) then
            begin
              RemoveValueAtIndex(i);
              break;
            end;
        end;
  finally
    if assigned(TempItem) then
      FreeAndNil(TempItem);
  end;
end;

end.
