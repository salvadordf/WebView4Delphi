unit uWVCoreWebView2SharedBuffer;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
    Winapi.ActiveX,
  {$ELSE}
    {$IFDEF FPC}Windows,{$ENDIF} ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2SharedBuffer = class
    protected
      FBaseIntf  : ICoreWebView2SharedBuffer;

      function  GetInitialized : boolean;
      function  GetSize : Largeuint;
      function  GetBuffer : PByte;
      function  GetOpenStream : IStream;
      function  GetFileMappingHandle : HANDLE;

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2SharedBuffer); reintroduce;
      destructor  Destroy; override;
      function    Close : boolean;

      property    Initialized        : boolean                    read GetInitialized;
      property    BaseIntf           : ICoreWebView2SharedBuffer  read FBaseIntf;
      property    Size               : Largeuint                  read GetSize;
      property    Buffer             : PByte                      read GetBuffer;
      property    OpenStream         : IStream                    read GetOpenStream;
      property    FileMappingHandle  : HANDLE                     read GetFileMappingHandle;
  end;

implementation

uses
  uWVMiscFunctions;


constructor TCoreWebView2SharedBuffer.Create(const aBaseIntf : ICoreWebView2SharedBuffer);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2SharedBuffer.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2SharedBuffer.InitializeFields;
begin
  FBaseIntf := nil;
end;

function TCoreWebView2SharedBuffer.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2SharedBuffer.GetSize : Largeuint;
var
  TempResult : Largeuint;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Size(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.GetBuffer : PByte;
var
  TempResult : PByte;
begin
  Result := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Buffer(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.GetOpenStream : IStream;
var
  TempResult : IStream;
begin
  Result := nil;

  if Initialized and
     succeeded(FBaseIntf.OpenStream(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.GetFileMappingHandle : HANDLE;
var
  TempResult : HANDLE;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_FileMappingHandle(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.Close : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Close);
end;

end.
