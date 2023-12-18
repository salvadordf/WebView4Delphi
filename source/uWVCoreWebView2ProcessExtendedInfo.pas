unit uWVCoreWebView2ProcessExtendedInfo;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides process with associated extended information in the `ICoreWebView2Environment`.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processextendedinfo">See the ICoreWebView2ProcessExtendedInfo article.</see></para>
  /// </remarks>
  TCoreWebView2ProcessExtendedInfo = class
    protected
      FBaseIntf : ICoreWebView2ProcessExtendedInfo;

      function GetInitialized : boolean;
      function GetProcessInfo : ICoreWebView2ProcessInfo;
      function GetAssociatedFrameInfos : ICoreWebView2FrameInfoCollection;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ProcessExtendedInfo); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                         : boolean                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                            : ICoreWebView2ProcessExtendedInfo  read FBaseIntf                            write FBaseIntf;
      /// <summary>
      /// The process info of the current process.
      /// </summary>
      property ProcessInfo                         : ICoreWebView2ProcessInfo          read GetProcessInfo;
      /// <summary>
      /// The collection of associated `FrameInfo`s which are actively running
      /// (showing or hiding UI elements) in this renderer process. `AssociatedFrameInfos`
      /// will only be populated when this `ICoreWebView2ProcessExtendedInfo`
      /// corresponds to a renderer process. Non-renderer processes will always
      /// have an empty `AssociatedFrameInfos`. The `AssociatedFrameInfos` may
      /// also be empty for renderer processes that have no active frames.
      /// </summary>
      property AssociatedFrameInfos                : ICoreWebView2FrameInfoCollection  read GetAssociatedFrameInfos;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ProcessExtendedInfo.Create(const aBaseIntf: ICoreWebView2ProcessExtendedInfo);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ProcessExtendedInfo.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ProcessExtendedInfo.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ProcessExtendedInfo.GetProcessInfo: ICoreWebView2ProcessInfo;
var
  TempResult : ICoreWebView2ProcessInfo;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_processInfo(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ProcessExtendedInfo.GetAssociatedFrameInfos : ICoreWebView2FrameInfoCollection;
var
  TempResult : ICoreWebView2FrameInfoCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_AssociatedFrameInfos(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

end.
