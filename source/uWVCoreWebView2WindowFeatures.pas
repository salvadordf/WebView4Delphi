unit uWVCoreWebView2WindowFeatures;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2WindowFeatures = class
    protected
      FBaseIntf : ICoreWebView2WindowFeatures;

      function GetInitialized : boolean;
      function GetHasPosition : boolean;
      function GetHasSize : boolean;
      function GetLeft : cardinal;
      function GetTop : cardinal;
      function GetWidth : cardinal;
      function GetHeight : cardinal;
      function GetShouldDisplayMenuBar : boolean;
      function GetShouldDisplayStatus : boolean;
      function GetShouldDisplayToolbar : boolean;
      function GetShouldDisplayScrollBars : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2WindowFeatures); reintroduce;
      destructor  Destroy; override;
      procedure   CopyToRecord(var aWindowFeatures : TWVWindowFeatures);

      property Initialized             : boolean                         read GetInitialized;
      property BaseIntf                : ICoreWebView2WindowFeatures     read FBaseIntf;
      property HasPosition             : boolean                         read GetHasPosition;
      property HasSize                 : boolean                         read GetHasSize;
      property Left                    : cardinal                        read GetLeft;
      property Top                     : cardinal                        read GetTop;
      property Width                   : cardinal                        read GetWidth;
      property Height                  : cardinal                        read GetHeight;
      property ShouldDisplayMenuBar    : boolean                         read GetShouldDisplayMenuBar;
      property ShouldDisplayStatus     : boolean                         read GetShouldDisplayStatus;
      property ShouldDisplayToolbar    : boolean                         read GetShouldDisplayToolbar;
      property ShouldDisplayScrollBars : boolean                         read GetShouldDisplayScrollBars;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2WindowFeatures.Create(const aBaseIntf: ICoreWebView2WindowFeatures);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2WindowFeatures.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

procedure TCoreWebView2WindowFeatures.CopyToRecord(var aWindowFeatures : TWVWindowFeatures);
begin
  aWindowFeatures.HasPosition             := HasPosition;
  aWindowFeatures.HasSize                 := HasSize;
  aWindowFeatures.Left                    := Left;
  aWindowFeatures.Top                     := Top;
  aWindowFeatures.Width                   := Width;
  aWindowFeatures.Height                  := Height;
  aWindowFeatures.ShouldDisplayMenuBar    := ShouldDisplayMenuBar;
  aWindowFeatures.ShouldDisplayStatus     := ShouldDisplayStatus;
  aWindowFeatures.ShouldDisplayToolbar    := ShouldDisplayToolbar;
  aWindowFeatures.ShouldDisplayScrollBars := ShouldDisplayScrollBars;
end;

function TCoreWebView2WindowFeatures.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WindowFeatures.GetHasPosition : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasPosition(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetHasSize : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasSize(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetLeft : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Left(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetTop : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Top(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetWidth : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Width(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetHeight : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Height(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayMenuBar : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayMenuBar(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayStatus : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayStatus(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayToolbar : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayToolbar(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayScrollBars : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayScrollBars(TempResult)) and
            (TempResult <> 0);
end;


end.

