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
      FBaseIntf  : ICoreWebView2FrameInfo;
      FBaseIntf2 : ICoreWebView2FrameInfo2;

      function GetInitialized : boolean;

      // ICoreWebView2FrameInfo
      function GetName : wvstring;
      function GetSource : wvstring;

      // ICoreWebView2FrameInfo2
      function GetParentFrameInfo : ICoreWebView2FrameInfo;
      function GetFrameId : cardinal;
      function GetFrameKind : TWVFrameKind;
      function GetFrameKindStr : wvstring;

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2FrameInfo); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized       : boolean                 read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf          : ICoreWebView2FrameInfo  read FBaseIntf       write FBaseIntf;
      /// <summary>
      /// The value of iframe's window.name property. The default value equals to
      /// iframe html tag declaring it, as in `<iframe name="frame-name">...</iframe>`.
      /// The returned string is empty when the frame has no name attribute and
      /// no assigned value for window.name.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo#get_name">See the ICoreWebView2FrameInfo article.</see></para>
      /// </remarks>
      property Name              : wvstring                read GetName;
      /// <summary>
      /// The URI of the document in the frame.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo#get_source">See the ICoreWebView2FrameInfo article.</see></para>
      /// </remarks>
      property Source            : wvstring                read GetSource;
      /// <summary>
      /// This parent frame's `FrameInfo`. `ParentFrameInfo` will only be
      /// populated when obtained via calling
      /// `ICoreWebView2ProcessExtendedInfo.AssociatedFrameInfos`.
      /// `ICoreWebView2FrameInfo` objects obtained via `ICoreWebView2.ProcessFailed` will
      /// always have a `null` `ParentFrameInfo`. This property is also `null` for the
      /// main frame in the WebView2 which has no parent frame.
      /// Note that this `ParentFrameInfo` could be out of date as it's a snapshot.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo2#get_parentframeinfo">See the ICoreWebView2FrameInfo2 article.</see></para>
      /// </remarks>
      property ParentFrameInfo   : ICoreWebView2FrameInfo  read GetParentFrameInfo;
      /// <summary>
      /// The unique identifier of the frame associated with the current `FrameInfo`.
      /// It's the same kind of ID as with the `FrameId` in `ICoreWebView2` and via
      /// `ICoreWebView2Frame`. `FrameId` will only be populated (non-zero) when obtained
      /// calling `CoreWebView2ProcessExtendedInfo.AssociatedFrameInfos`.
      /// `ICoreWebView2FrameInfo` objects obtained via `ICoreWebView2.ProcessFailed` will
      /// always have an invalid frame Id 0.
      /// Note that this `FrameId` could be out of date as it's a snapshot.
      /// If there's WebView2 created or destroyed or `FrameCreated/FrameDestroyed` events
      /// after the asynchronous call `CoreWebView2Environment.GetProcessExtendedInfos`
      /// starts, you may want to call asynchronous method again to get the updated `FrameInfo`s.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo2#get_frameid">See the ICoreWebView2FrameInfo2 article.</see></para>
      /// </remarks>
      property FrameId           : cardinal                read GetFrameId;
      /// <summary>
      /// The frame kind of the frame. `FrameKind` will only be populated when
      /// obtained calling `ICoreWebView2ProcessExtendedInfo.AssociatedFrameInfos`.
      /// `ICoreWebView2FrameInfo` objects obtained via `ICoreWebView2.ProcessFailed`
      /// will always have the default value `COREWEBVIEW2_FRAME_KIND_UNKNOWN`.
      /// Note that this `FrameKind` could be out of date as it's a snapshot.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo2#get_framekind">See the ICoreWebView2FrameInfo2 article.</see></para>
      /// </remarks>
      property FrameKind         : TWVFrameKind            read GetFrameKind;
      /// <summary>
      /// The frame kind of the frame in string format.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo2#get_framekind">See the ICoreWebView2FrameInfo2 article.</see></para>
      /// </remarks>
      property FrameKindStr      : wvstring                read GetFrameKindStr;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVMiscFunctions, uWVConstants;

constructor TCoreWebView2FrameInfo.Create(const aBaseIntf: ICoreWebView2FrameInfo);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Frame2, FBaseIntf2);
end;

destructor TCoreWebView2FrameInfo.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2FrameInfo.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
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

function TCoreWebView2FrameInfo.GetParentFrameInfo : ICoreWebView2FrameInfo;
var
  TempResult : ICoreWebView2FrameInfo;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_ParentFrameInfo(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2FrameInfo.GetFrameId : cardinal;
var
  TempResult : SYSUINT;
begin
  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_FrameId(TempResult)) then
    Result := TempResult
   else
    Result := WEBVIEW4DELPHI_INVALID_FRAMEID;
end;

function TCoreWebView2FrameInfo.GetFrameKind : TWVFrameKind;
var
  TempResult : COREWEBVIEW2_FRAME_KIND;
begin
  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_FrameKind(TempResult)) then
    Result := TempResult
   else
    Result := COREWEBVIEW2_FRAME_KIND_UNKNOWN;
end;

function TCoreWebView2FrameInfo.GetFrameKindStr : wvstring;
begin
  case FrameKind of
    COREWEBVIEW2_FRAME_KIND_UNKNOWN    : Result := 'unknown';
    COREWEBVIEW2_FRAME_KIND_MAIN_FRAME : Result := 'main';
    COREWEBVIEW2_FRAME_KIND_IFRAME     : Result := 'iframe';
    COREWEBVIEW2_FRAME_KIND_EMBED      : Result := 'embed';
    COREWEBVIEW2_FRAME_KIND_OBJECT     : Result := 'object';
    else                                 Result := 'unknown';
  end;
end;

end.
