unit uWVCoreWebView2ContextMenuTarget;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
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

      property Initialized              : boolean                                read GetInitialized;
      property BaseIntf                 : ICoreWebView2ContextMenuTarget         read FBaseIntf;
      property Kind                     : TWVMenuTargetKind                      read GetKind;
      property IsEditable               : boolean                                read GetIsEditable;
      property IsRequestedForMainFrame  : boolean                                read GetIsRequestedForMainFrame;
      property PageUri                  : wvstring                               read GetPageUri;
      property FrameUri                 : wvstring                               read GetFrameUri;
      property HasLinkUri               : boolean                                read GetHasLinkUri;
      property LinkUri                  : wvstring                               read GetLinkUri;
      property HasLinkText              : boolean                                read GetHasLinkText;
      property LinkText                 : wvstring                               read GetLinkText;
      property HasSourceUri             : boolean                                read GetHasSourceUri;
      property SourceUri                : wvstring                               read GetSourceUri;
      property HasSelection             : boolean                                read GetHasSelection;
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

