unit uWVCoreWebView2CrashReport;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Types, Winapi.ActiveX,
  {$ELSE}
  Types, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// <para>Provides crash signature data captured at the moment of process
  /// failure.</para>
  /// <para>CrashReport is nil when the failure did not produce a crash report
  /// (normal exit, external kill, launch failure, hang). CrashReport may be
  /// nil for certain crash-type failures where no crash report was produced;
  /// host apps should always check for null before accessing properties.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2crashreport">See the ICoreWebView2CrashReport article.</see></para>
  /// </remarks>
  TCoreWebView2CrashReport = class
    protected
      FBaseIntf : ICoreWebView2CrashReport;

      function  GetInitialized : boolean;
      function  GetBucketId : wvstring;
      function  GetCrashReportId : wvstring;
      function  GetExceptionCode : LongWord;
      function  GetFaultOffset : uint64;
      function  GetFaultingModuleName : wvstring;
      function  GetFaultingModuleVersion : wvstring;
      function  GetReportTime : uint64;

    public
      constructor Create(const aBaseIntf : ICoreWebView2CrashReport); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// <para>Returns true when the interface implemented by this class is
      /// fully initialized.</para>
      /// </summary>
      property Initialized           : boolean                    read GetInitialized;
      /// <summary>
      /// <para>Returns the interface implemented by this class.</para>
      /// </summary>
      property BaseIntf              : ICoreWebView2CrashReport   read FBaseIntf;
      /// <summary>
      /// <para>Crash bucket identifier assigned by Microsoft's crash telemetry
      /// service. Returned as a 32-character hex string. Empty when no bucket
      /// was assigned: crash data was not uploaded to Microsoft's telemetry
      /// service (custom crash reporting enabled), or no response was received
      /// from the telemetry service (network throttled or unavailable).</para>
      /// </summary>
      property BucketId              : wvstring                   read GetBucketId;
      /// <summary>
      /// <para>The unique identifier (UUID) for this crash report. Use this to locate the
      /// corresponding dump file in `FailureReportFolderPath`.</para>
      /// </summary>
      property CrashReportId         : wvstring                   read GetCrashReportId;
      /// <summary>
      /// <para>The Windows exception code for the failure, e.g. `0xC0000005` for
      /// `STATUS_ACCESS_VIOLATION`. `0` if not available.</para>
      /// </summary>
      property ExceptionCode         : LongWord                   read GetExceptionCode;
      /// <summary>
      /// <para>Relative virtual address (RVA) of the faulting instruction within
      /// `FaultingModuleName`. `0` if not available.</para>
      /// </summary>
      property FaultOffset           : uint64                     read GetFaultOffset;
      /// <summary>
      /// <para>Basename of the module containing the faulting instruction,
      /// e.g. `renderer.dll`.</para>
      /// </summary>
      property FaultingModuleName    : wvstring                   read GetFaultingModuleName;
      /// <summary>
      /// <para>Version of the faulting module, e.g. `128.0.2739.42`.</para>
      /// </summary>
      property FaultingModuleVersion : wvstring                   read GetFaultingModuleVersion;
      /// <summary>
      /// <para>Time the crash report was recorded, as a Windows FILETIME value
      /// (100-nanosecond intervals since Jan 1 1601 UTC). `0` if unavailable.</para>
      /// </summary>
      property ReportTime            : uint64                     read GetReportTime;
  end;

implementation

constructor TCoreWebView2CrashReport.Create(const aBaseIntf: ICoreWebView2CrashReport);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2CrashReport.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2CrashReport.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2CrashReport.GetBucketId: wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_BucketId(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2CrashReport.GetCrashReportId: wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_CrashReportId(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2CrashReport.GetExceptionCode: LongWord;
var
  TempResult : SYSUINT;
begin
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_ExceptionCode(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2CrashReport.GetFaultOffset: uint64;
var
  TempResult : Largeuint;
begin
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_FaultOffset(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2CrashReport.GetFaultingModuleName: wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_FaultingModuleName(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2CrashReport.GetFaultingModuleVersion: wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_FaultingModuleVersion(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2CrashReport.GetReportTime: uint64;
var
  TempResult : Largeuint;
begin
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_ReportTime(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

end.
