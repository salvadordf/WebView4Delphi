unit uWVCoreWebView2FrameInfo;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides a set of properties for a frame in the ICoreWebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo">See the ICoreWebView2FrameInfo article.</see></para>
  /// </remarks>
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
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
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
