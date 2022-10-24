unit uWVCoreWebView2ContextMenuItem;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, Winapi.ActiveX,
  {$ELSE}
  Classes, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2ContextMenuItem = class
    protected
      FBaseIntf : ICoreWebView2ContextMenuItem;

      function  GetInitialized : boolean;
      function  GetName : wvstring;
      function  GetLabel : wvstring;
      function  GetCommandId : integer;
      function  GetShortcutKeyDescription : wvstring;
      function  GetIcon : IStream;
      function  GetKind : TWVMenuItemKind;
      function  GetIsEnabled : boolean;
      function  GetIsChecked : boolean;
      function  GetChildren : ICoreWebView2ContextMenuItemCollection;

      procedure SetIsEnabled(aValue : boolean);
      procedure SetIsChecked(aValue : boolean);

    public
      constructor Create(const aBaseIntf : ICoreWebView2ContextMenuItem); reintroduce;
      destructor  Destroy; override;
      function    AddCustomItemSelectedEvent(const aBrowserComponent : TComponent) : boolean;

      property Initialized              : boolean                                  read GetInitialized;
      property BaseIntf                 : ICoreWebView2ContextMenuItem             read FBaseIntf                     write FBaseIntf;
      property Name                     : wvstring                                 read GetName;
      property Label_                   : wvstring                                 read GetLabel;
      property CommandId                : integer                                  read GetCommandId;
      property ShortcutKeyDescription   : wvstring                                 read GetShortcutKeyDescription;
      property Icon                     : IStream                                  read GetIcon;
      property Kind                     : TWVMenuItemKind                          read GetKind;
      property IsEnabled                : boolean                                  read GetIsEnabled                  write SetIsEnabled;
      property IsChecked                : boolean                                  read GetIsChecked                  write SetIsChecked;
      property Children                 : ICoreWebView2ContextMenuItemCollection   read GetChildren;
  end;

implementation

uses
  uWVBrowserBase, uWVCoreWebView2Delegates, uWVMiscFunctions;

constructor TCoreWebView2ContextMenuItem.Create(const aBaseIntf: ICoreWebView2ContextMenuItem);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ContextMenuItem.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ContextMenuItem.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ContextMenuItem.GetName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_name(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuItem.GetLabel : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Label_(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuItem.GetCommandId : integer;
var
  TempResult : integer;
begin
  Result := -1;

  if Initialized and
     succeeded(FBaseIntf.Get_CommandId(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuItem.GetShortcutKeyDescription : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ShortcutKeyDescription(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuItem.GetIcon : IStream;
var
  TempResult : IStream;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Icon(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuItem.GetKind : TWVMenuItemKind;
var
  TempResult : COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuItem.GetIsEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuItem.GetIsChecked : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsChecked(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuItem.GetChildren : ICoreWebView2ContextMenuItemCollection;
var
  TempResult : ICoreWebView2ContextMenuItemCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Children(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

procedure TCoreWebView2ContextMenuItem.SetIsEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsEnabled(ord(aValue));
end;

procedure TCoreWebView2ContextMenuItem.SetIsChecked(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsChecked(ord(aValue));
end;

function TCoreWebView2ContextMenuItem.AddCustomItemSelectedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempToken : EventRegistrationToken;
begin
  Result := False;

  if Initialized then
    begin
      TempToken.value := 0;
      Result          := succeeded(FBaseIntf.add_CustomItemSelected(TWVBrowserBase(aBrowserComponent).CustomItemSelectedEventHandler, TempToken));
    end;
end;


end.

