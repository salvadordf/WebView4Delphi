unit uWVCoreWebView2ProcessInfo;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2ProcessInfo = class
    protected
      FBaseIntf : ICoreWebView2ProcessInfo;

      function GetInitialized : boolean;
      function GetKind : TWVProcessKind;
      function GetProcessId : integer;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ProcessInfo); reintroduce;
      destructor  Destroy; override;

      property Initialized                         : boolean                         read GetInitialized;
      property BaseIntf                            : ICoreWebView2ProcessInfo        read FBaseIntf                            write FBaseIntf;
      property Kind                                : TWVProcessKind                  read GetKind;
      property ProcessId                           : integer                         read GetProcessId;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ProcessInfo.Create(const aBaseIntf: ICoreWebView2ProcessInfo);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ProcessInfo.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ProcessInfo.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ProcessInfo.GetKind : TWVProcessKind;
var
  TempResult : COREWEBVIEW2_PROCESS_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2ProcessInfo.GetProcessId : integer;
var
  TempResult : integer;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.get_ProcessId(TempResult)) then
    Result := TempResult;
end;

end.

