unit uWVCoreWebView2ContextMenuTarget;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Represents the information regarding the context menu target.
  /// Includes the context selected and the appropriate data used for the actions of a context menu.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget">See the ICoreWebView2ContextMenuTarget article.</see></para>
  /// </remarks>
  TCoreWebView2ContextMenuTarget = class
    protected
      FBaseIntf : ICoreWebView2ContextMenuTarget;

      function GetInitialized : boolean;
      function GetKind : TWVMenuTargetKind;
      function GetIsEditable : boolean;
      function GetIsRequestedForMainFrame : boolean;
      function GetPageUri : wvstring;
      function GetFrameUri : wvstring;
      function GetHasLinkUri : boolean;
      function GetLinkUri : wvstring;
      function GetHasLinkText : boolean;
      function GetLinkText : wvstring;
      function GetHasSourceUri : boolean;
      function GetSourceUri : wvstring;
      function GetHasSelection : boolean;
      function GetSelectionText : wvstring;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ContextMenuTarget); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized              : boolean                                read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                 : ICoreWebView2ContextMenuTarget         read FBaseIntf;
      /// <summary>
      /// Gets the kind of context that the user selected.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_kind">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property Kind                     : TWVMenuTargetKind                      read GetKind;
      /// <summary>
      /// Returns TRUE if the context menu is requested on an editable component.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_iseditable">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property IsEditable               : boolean                                read GetIsEditable;
      /// <summary>
      /// Returns TRUE if the context menu was requested on the main frame and
      /// FALSE if invoked on another frame.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_isrequestedformainframe">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property IsRequestedForMainFrame  : boolean                                read GetIsRequestedForMainFrame;
      /// <summary>
      /// Gets the uri of the page.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_pageuri">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property PageUri                  : wvstring                               read GetPageUri;
      /// <summary>
      /// Gets the uri of the frame. Will match the PageUri if `IsRequestedForMainFrame` is TRUE.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_frameuri">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property FrameUri                 : wvstring                               read GetFrameUri;
      /// <summary>
      /// Returns TRUE if the context menu is requested on HTML containing an anchor tag.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_haslinkuri">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property HasLinkUri               : boolean                                read GetHasLinkUri;
      /// <summary>
      /// Gets the uri of the link (if `HasLinkUri` is TRUE, null otherwise).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_linkuri">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property LinkUri                  : wvstring                               read GetLinkUri;
      /// <summary>
      /// Returns TRUE if the context menu is requested on text element that contains an anchor tag.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_haslinktext">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property HasLinkText              : boolean                                read GetHasLinkText;
      /// <summary>
      /// Gets the text of the link (if `HasLinkText` is TRUE, null otherwise).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_linktext">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property LinkText                 : wvstring                               read GetLinkText;
      /// <summary>
      /// Returns TRUE if the context menu is requested on HTML containing a source uri.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_hassourceuri">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property HasSourceUri             : boolean                                read GetHasSourceUri;
      /// <summary>
      /// Gets the active source uri of element (if `HasSourceUri` is TRUE, null otherwise).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_sourceuri">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property SourceUri                : wvstring                               read GetSourceUri;
      /// <summary>
      /// Returns TRUE if the context menu is requested on a selection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_hasselection">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property HasSelection             : boolean                                read GetHasSelection;
      /// <summary>
      /// Gets the selected text (if `HasSelection` is TRUE, null otherwise).
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget#get_selectiontext">See the ICoreWebView2ContextMenuTarget article.</see></para>
      /// </remarks>
      property SelectionText            : wvstring                               read GetSelectionText;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ContextMenuTarget.Create(const aBaseIntf: ICoreWebView2ContextMenuTarget);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ContextMenuTarget.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ContextMenuTarget.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ContextMenuTarget.GetKind : TWVMenuTargetKind;
var
  TempResult : COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2ContextMenuTarget.GetIsEditable : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsEditable(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuTarget.GetIsRequestedForMainFrame : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsRequestedForMainFrame(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuTarget.GetPageUri : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_PageUri(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuTarget.GetFrameUri : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_FrameUri(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuTarget.GetHasLinkUri : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasLinkUri(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuTarget.GetLinkUri : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_LinkUri(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuTarget.GetHasLinkText : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasLinkText(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuTarget.GetLinkText : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_LinkText(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuTarget.GetHasSourceUri : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasSourceUri(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuTarget.GetSourceUri : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_SourceUri(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2ContextMenuTarget.GetHasSelection : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasSelection(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContextMenuTarget.GetSelectionText : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_SelectionText(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

end.

