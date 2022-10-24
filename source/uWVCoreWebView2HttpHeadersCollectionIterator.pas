unit uWVCoreWebView2HttpHeadersCollectionIterator;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2HttpHeadersCollectionIterator = class
    protected
      FBaseIntf : ICoreWebView2HttpHeadersCollectionIterator;

      function  GetInitialized : boolean;
      function  GetHasCurrentHeader : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2HttpHeadersCollectionIterator); reintroduce;
      destructor  Destroy; override;
      function    GetCurrentHeader(var aName, aValue: wvstring): boolean;
      function    MoveNext : boolean;

      property Initialized       : boolean                                      read GetInitialized;
      property BaseIntf          : ICoreWebView2HttpHeadersCollectionIterator   read FBaseIntf;
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
