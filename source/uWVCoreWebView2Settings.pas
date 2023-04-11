unit uWVCoreWebView2Settings;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2Settings = class
    protected
      FBaseIntf  : ICoreWebView2Settings;
      FBaseIntf2 : ICoreWebView2Settings2;
      FBaseIntf3 : ICoreWebView2Settings3;
      FBaseIntf4 : ICoreWebView2Settings4;
      FBaseIntf5 : ICoreWebView2Settings5;
      FBaseIntf6 : ICoreWebView2Settings6;
      FBaseIntf7 : ICoreWebView2Settings7;
      FBaseIntf8 : ICoreWebView2Settings8;

      function  GetInitialized : boolean;
      function  GetIsBuiltInErrorPageEnabled : boolean;
      function  GetAreDefaultContextMenusEnabled : boolean;
      function  GetAreDefaultScriptDialogsEnabled : boolean;
      function  GetAreDevToolsEnabled : boolean;
      function  GetIsScriptEnabled : boolean;
      function  GetIsStatusBarEnabled : boolean;
      function  GetIsWebMessageEnabled : boolean;
      function  GetIsZoomControlEnabled : boolean;
      function  GetAreHostObjectsAllowed : boolean;
      function  GetUserAgent : wvstring;
      function  GetAreBrowserAcceleratorKeysEnabled : boolean;
      function  GetIsPasswordAutosaveEnabled : boolean;
      function  GetIsGeneralAutofillEnabled : boolean;
      function  GetIsPinchZoomEnabled : boolean;
      function  GetIsSwipeNavigationEnabled : boolean;
      function  GetHiddenPdfToolbarItems : TWVPDFToolbarItems;
      function  GetIsReputationCheckingRequired : boolean;

      procedure SetIsBuiltInErrorPageEnabled(aValue : boolean);
      procedure SetAreDefaultContextMenusEnabled(aValue : boolean);
      procedure SetAreDefaultScriptDialogsEnabled(aValue : boolean);
      procedure SetAreDevToolsEnabled(aValue : boolean);
      procedure SetIsScriptEnabled(aValue : boolean);
      procedure SetIsStatusBarEnabled(aValue : boolean);
      procedure SetIsWebMessageEnabled(aValue : boolean);
      procedure SetIsZoomControlEnabled(aValue : boolean);
      procedure SetAreHostObjectsAllowed(aValue : boolean);
      procedure SetUserAgent(const aValue : wvstring);
      procedure SetAreBrowserAcceleratorKeysEnabled(aValue : boolean);
      procedure SetIsPasswordAutosaveEnabled(aValue : boolean);
      procedure SetIsGeneralAutofillEnabled(aValue : boolean);
      procedure SetIsPinchZoomEnabled(aValue : boolean);
      procedure SetIsSwipeNavigationEnabled(aValue : boolean);
      procedure SetHiddenPdfToolbarItems(aValue : TWVPDFToolbarItems);
      procedure SetIsReputationCheckingRequired(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Settings); reintroduce;
      destructor  Destroy; override;

      property    Initialized                      : boolean                read GetInitialized;
      property    BaseIntf                         : ICoreWebView2Settings  read FBaseIntf;
      property    IsBuiltInErrorPageEnabled        : boolean                read GetIsBuiltInErrorPageEnabled         write SetIsBuiltInErrorPageEnabled;
      property    AreDefaultContextMenusEnabled    : boolean                read GetAreDefaultContextMenusEnabled     write SetAreDefaultContextMenusEnabled;
      property    AreDefaultScriptDialogsEnabled   : boolean                read GetAreDefaultScriptDialogsEnabled    write SetAreDefaultScriptDialogsEnabled;
      property    AreDevToolsEnabled               : boolean                read GetAreDevToolsEnabled                write SetAreDevToolsEnabled;
      property    IsScriptEnabled                  : boolean                read GetIsScriptEnabled                   write SetIsScriptEnabled;
      property    IsStatusBarEnabled               : boolean                read GetIsStatusBarEnabled                write SetIsStatusBarEnabled;
      property    IsWebMessageEnabled              : boolean                read GetIsWebMessageEnabled               write SetIsWebMessageEnabled;
      property    IsZoomControlEnabled             : boolean                read GetIsZoomControlEnabled              write SetIsZoomControlEnabled;
      property    AreHostObjectsAllowed            : boolean                read GetAreHostObjectsAllowed             write SetAreHostObjectsAllowed;
      property    UserAgent                        : wvstring               read GetUserAgent                         write SetUserAgent;
      property    AreBrowserAcceleratorKeysEnabled : boolean                read GetAreBrowserAcceleratorKeysEnabled  write SetAreBrowserAcceleratorKeysEnabled;
      property    IsPasswordAutosaveEnabled        : boolean                read GetIsPasswordAutosaveEnabled         write SetIsPasswordAutosaveEnabled;
      property    IsGeneralAutofillEnabled         : boolean                read GetIsGeneralAutofillEnabled          write SetIsGeneralAutofillEnabled;
      property    IsPinchZoomEnabled               : boolean                read GetIsPinchZoomEnabled                write SetIsPinchZoomEnabled;
      property    IsSwipeNavigationEnabled         : boolean                read GetIsSwipeNavigationEnabled          write SetIsSwipeNavigationEnabled;
      property    HiddenPdfToolbarItems            : TWVPDFToolbarItems     read GetHiddenPdfToolbarItems             write SetHiddenPdfToolbarItems;
      property    IsReputationCheckingRequired     : boolean                read GetIsReputationCheckingRequired      write SetIsReputationCheckingRequired;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVMiscFunctions;


constructor TCoreWebView2Settings.Create(const aBaseIntf : ICoreWebView2Settings);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings3, FBaseIntf3) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings4, FBaseIntf4) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings5, FBaseIntf5) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings6, FBaseIntf6) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings7, FBaseIntf7) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Settings8, FBaseIntf8);
end;

destructor TCoreWebView2Settings.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2Settings.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
  FBaseIntf4 := nil;
  FBaseIntf5 := nil;
  FBaseIntf6 := nil;
  FBaseIntf7 := nil;
  FBaseIntf8 := nil;
end;

function TCoreWebView2Settings.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Settings.GetIsBuiltInErrorPageEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsBuiltInErrorPageEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreDefaultContextMenusEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreDefaultContextMenusEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreDefaultScriptDialogsEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreDefaultScriptDialogsEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreDevToolsEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreDevToolsEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsScriptEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsScriptEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsStatusBarEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsStatusBarEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsWebMessageEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsWebMessageEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsZoomControlEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsZoomControlEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetAreHostObjectsAllowed : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_AreHostObjectsAllowed(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetUserAgent : wvstring;

var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_UserAgent(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Settings.GetAreBrowserAcceleratorKeysEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Get_AreBrowserAcceleratorKeysEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsPasswordAutosaveEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.Get_IsPasswordAutosaveEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsGeneralAutofillEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf4) and
            succeeded(FBaseIntf4.Get_IsGeneralAutofillEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsPinchZoomEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf5) and
            succeeded(FBaseIntf5.Get_IsPinchZoomEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetIsSwipeNavigationEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.Get_IsSwipeNavigationEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Settings.GetHiddenPdfToolbarItems : TWVPDFToolbarItems;
var
  TempResult : COREWEBVIEW2_PDF_TOOLBAR_ITEMS;
begin
  if assigned(FBaseIntf7) and
     succeeded(FBaseIntf7.Get_HiddenPdfToolbarItems(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2Settings.GetIsReputationCheckingRequired : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf8) and
            succeeded(FBaseIntf8.Get_IsReputationCheckingRequired(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2Settings.SetIsBuiltInErrorPageEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsBuiltInErrorPageEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreDefaultContextMenusEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreDefaultContextMenusEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreDefaultScriptDialogsEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreDefaultScriptDialogsEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreDevToolsEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreDevToolsEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsScriptEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsScriptEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsStatusBarEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsStatusBarEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsWebMessageEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsWebMessageEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsZoomControlEnabled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsZoomControlEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetAreHostObjectsAllowed(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_AreHostObjectsAllowed(ord(aValue));
end;

procedure TCoreWebView2Settings.SetUserAgent(const aValue : wvstring);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_UserAgent(PWideChar(aValue));
end;

procedure TCoreWebView2Settings.SetAreBrowserAcceleratorKeysEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_AreBrowserAcceleratorKeysEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsPasswordAutosaveEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf4) then
    FBaseIntf4.Set_IsPasswordAutosaveEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsGeneralAutofillEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf4) then
    FBaseIntf4.Set_IsGeneralAutofillEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsPinchZoomEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf5) then
    FBaseIntf5.Set_IsPinchZoomEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetIsSwipeNavigationEnabled(aValue : boolean);
begin
  if assigned(FBaseIntf6) then
    FBaseIntf6.Set_IsSwipeNavigationEnabled(ord(aValue));
end;

procedure TCoreWebView2Settings.SetHiddenPdfToolbarItems(aValue : TWVPDFToolbarItems);
begin
  if assigned(FBaseIntf7) then
    FBaseIntf7.Set_HiddenPdfToolbarItems(aValue);
end;

procedure TCoreWebView2Settings.SetIsReputationCheckingRequired(aValue : boolean);
begin
  if assigned(FBaseIntf8) then
    FBaseIntf8.Set_IsReputationCheckingRequired(ord(aValue));
end;

end.
