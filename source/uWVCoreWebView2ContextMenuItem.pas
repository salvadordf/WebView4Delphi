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
  /// <summary>
  /// Represents a context menu item of a context menu displayed by WebView.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem">See the ICoreWebView2ContextMenuItem article.</see></para>
  /// </remarks>
  TCoreWebView2ContextMenuItem = class
    protected
      FBaseIntf                : ICoreWebView2ContextMenuItem;
      FCustomItemSelectedToken : EventRegistrationToken;

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

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddCustomItemSelectedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ContextMenuItem); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized              : boolean                                  read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                 : ICoreWebView2ContextMenuItem             read FBaseIntf                     write FBaseIntf;
      /// <summary>
      /// Gets the unlocalized name for the `ContextMenuItem`. Use this to
      /// distinguish between context menu item types. This will be the English
      /// label of the menu item in lower camel case. For example, the "Save as"
      /// menu item will be "saveAs". Extension menu items will be "extension",
      /// custom menu items will be "custom" and spellcheck items will be
      /// "spellCheck".
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_name">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property Name                     : wvstring                                 read GetName;
      /// <summary>
      /// Gets the localized label for the `ContextMenuItem`. Will contain an
      /// ampersand for characters to be used as keyboard accelerator.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_label">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property Label_                   : wvstring                                 read GetLabel;
      /// <summary>
      /// Gets the Command ID for the `ContextMenuItem`. Use this to report the
      /// `SelectedCommandId` in `ContextMenuRequested` event.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_commandid">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property CommandId                : integer                                  read GetCommandId;
      /// <summary>
      /// Gets the localized keyboard shortcut for this ContextMenuItem. It will be
      /// the empty string if there is no keyboard shortcut. This is text intended
      /// to be displayed to the end user to show the keyboard shortcut. For example
      /// this property is Ctrl+Shift+I for the "Inspect" `ContextMenuItem`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_shortcutkeydescription">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property ShortcutKeyDescription   : wvstring                                 read GetShortcutKeyDescription;
      /// <summary>
      /// Gets the Icon for the `ContextMenuItem` in PNG, Bitmap or SVG formats in the form of an IStream.
      /// Stream will be rewound to the start of the image data.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_icon">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property Icon                     : IStream                                  read GetIcon;
      /// <summary>
      /// Gets the `ContextMenuItem` kind.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_kind">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property Kind                     : TWVMenuItemKind                          read GetKind;
      /// <summary>
      /// Gets the enabled property of the `ContextMenuItem`.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_isenabled">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property IsEnabled                : boolean                                  read GetIsEnabled                  write SetIsEnabled;
      /// <summary>
      /// Gets the checked property of the `ContextMenuItem`, used if the kind is Check box or Radio.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_ischecked">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property IsChecked                : boolean                                  read GetIsChecked                  write SetIsChecked;
      /// <summary>
      /// Gets the list of children menu items through a `ContextMenuItemCollection`
      /// if the kind is Submenu. If the kind is not submenu, will return null.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem#get_children">See the ICoreWebView2ContextMenuItem article.</see></para>
      /// </remarks>
      property Children                 : ICoreWebView2ContextMenuItemCollection   read GetChildren;
  end;

implementation

uses
  uWVBrowserBase, uWVCoreWebView2Delegates, uWVMiscFunctions;

constructor TCoreWebView2ContextMenuItem.Create(const aBaseIntf: ICoreWebView2ContextMenuItem);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ContextMenuItem.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

function TCoreWebView2ContextMenuItem.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

procedure TCoreWebView2ContextMenuItem.InitializeFields;
begin
  FBaseIntf := nil;

  InitializeTokens;
end;

procedure TCoreWebView2ContextMenuItem.InitializeTokens;
begin
  FCustomItemSelectedToken.value := 0;
end;

procedure TCoreWebView2ContextMenuItem.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FCustomItemSelectedToken.value <> 0) then
        FBaseIntf.remove_CustomItemSelected(FCustomItemSelectedToken);

      InitializeTokens;
    end;
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
  TempHandler : ICoreWebView2CustomItemSelectedEventHandler;
begin
  Result := False;

  if Initialized and (FCustomItemSelectedToken.value = 0) then
    try
      TempHandler := TCoreWebView2CustomItemSelectedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_CustomItemSelected(TempHandler, FCustomItemSelectedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2ContextMenuItem.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddCustomItemSelectedEvent(aBrowserComponent);
end;

end.

