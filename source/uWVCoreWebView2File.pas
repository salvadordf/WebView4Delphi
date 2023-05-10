unit uWVCoreWebView2File;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2File = class
    protected
      FBaseIntf : ICoreWebView2File;

      function GetInitialized : boolean;
      function GetPath : wvstring;

    public
      constructor Create(const aBaseIntf : ICoreWebView2File); reintroduce;
      destructor  Destroy; override;

      property Initialized    : boolean                     read GetInitialized;
      property BaseIntf       : ICoreWebView2File           read FBaseIntf           write FBaseIntf;
      property Path           : wvstring                    read GetPath;
  end;

implementation


uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2File.Create(const aBaseIntf: ICoreWebView2File);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2File.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2File.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2File.GetPath : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Path(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

end.
