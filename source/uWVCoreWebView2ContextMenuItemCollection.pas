unit uWVCoreWebView2ContextMenuItemCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2ContextMenuItemCollection = class
    protected
      FBaseIntf : ICoreWebView2ContextMenuItemCollection;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2ContextMenuItem;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ContextMenuItemCollection); reintroduce;
      destructor  Destroy; override;
      function    RemoveValueAtIndex(index: cardinal): boolean;
      function    InsertValueAtIndex(index: cardinal; const aValue: ICoreWebView2ContextMenuItem): boolean;
      function    AppendValue(const aValue: ICoreWebView2ContextMenuItem): boolean;
      procedure   RemoveAllMenuItems;
      procedure   RemoveMenuItem(aCommandId : integer); overload;
      procedure   RemoveMenuItem(const aLabel : wvstring); overload;

      property Initialized           : boolean                                      read GetInitialized;
      property BaseIntf              : ICoreWebView2ContextMenuItemCollection       read FBaseIntf;
      property Count                 : cardinal                                     read GetCount;
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
