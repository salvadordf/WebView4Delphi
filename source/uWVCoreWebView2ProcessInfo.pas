unit uWVCoreWebView2ProcessInfo;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides a set of properties for a process in the ICoreWebView2Environment.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfo">See the ICoreWebView2ProcessInfo article.</see></para>
  /// </remarks>
  TCoreWebView2ProcessInfo = class
    protected
      FBaseIntf : ICoreWebView2ProcessInfo;

      function GetInitialized : boolean;
      function GetKind : TWVProcessKind;
      function GetProcessId : integer;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ProcessInfo); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                         : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                            : ICoreWebView2ProcessInfo        read FBaseIntf                            write FBaseIntf;
      /// <summary>
      /// The kind of the process.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfo#get_kind">See the ICoreWebView2ProcessInfo article.</see></para>
      /// </remarks>
      property Kind                                : TWVProcessKind                  read GetKind;
      /// <summary>
      /// The process id of the process.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfo#get_processid">See the ICoreWebView2ProcessInfo article.</see></para>
      /// </remarks>
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

