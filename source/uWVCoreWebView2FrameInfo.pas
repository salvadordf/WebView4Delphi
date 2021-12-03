unit uWVCoreWebView2FrameInfo;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2FrameInfo = class
    protected
      FBaseIntf : ICoreWebView2FrameInfo;

      function GetInitialized : boolean;
      function GetName : wvstring;
      function GetSource : wvstring;

    public
      constructor Create(const aBaseIntf : ICoreWebView2FrameInfo); reintroduce;
      destructor  Destroy; override;

      property Initialized : boolean                 read GetInitialized;
      property BaseIntf    : ICoreWebView2FrameInfo  read FBaseIntf       write FBaseIntf;
      property Name        : wvstring                read GetName;
      property Source      : wvstring                read GetSource;
  end;

implementation

uses
  {$IFDEF FPC}
  ActiveX;
  {$ELSE}
  Winapi.ActiveX;
  {$ENDIF}

constructor TCoreWebView2FrameInfo.Create(const aBaseIntf: ICoreWebView2FrameInfo);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2FrameInfo.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameInfo.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2FrameInfo.GetName : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Name(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2FrameInfo.GetSource : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Source(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
