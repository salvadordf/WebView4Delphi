unit uWVCoreWebView2WindowFeatures;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// <para>The window features for a WebView popup window.  The fields match the
  /// windowFeatures passed to window.open as specified in
  /// [Window features](https://developer.mozilla.org/docs/Web/API/Window/open#Window_features)
  /// on MDN.</para>
  /// <para>There is no requirement for you to respect the values.  If your app does
  /// not have corresponding UI features (for example, no toolbar) or if all
  /// instance of WebView are opened in tabs and do not have distinct size or
  /// positions, then your app does not respect the values.  You may want to
  /// respect values, but perhaps only some apply to the UI of you app.
  /// Accordingly, you may respect all, some, or none of the properties as
  /// appropriate for your app.  For all numeric properties, if the value that is
  /// passed to window.open is outside the range of an unsigned 32bit int, the
  /// resulting value is the absolute value of the maximum for unsigned 32bit
  /// integer.  If you are not able to parse the value an integer, it is
  /// considered 0.  If the value is a floating point value, it is rounded down
  /// to an integer.</para>
  /// <para>In runtime versions 98 or later, the values of ShouldDisplayMenuBar,
  /// ShouldDisplayStatus, ShouldDisplayToolbar, and ShouldDisplayScrollBars
  /// will not directly depend on the equivalent fields in the windowFeatures
  /// string.  Instead, they will all be false if the window is expected to be a
  /// popup, and true if it is not.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures">See the ICoreWebView2WindowFeatures article.</see></para>
  /// </remarks>
  TCoreWebView2WindowFeatures = class
    protected
      FBaseIntf : ICoreWebView2WindowFeatures;

      function GetInitialized : boolean;
      function GetHasPosition : boolean;
      function GetHasSize : boolean;
      function GetLeft : cardinal;
      function GetTop : cardinal;
      function GetWidth : cardinal;
      function GetHeight : cardinal;
      function GetShouldDisplayMenuBar : boolean;
      function GetShouldDisplayStatus : boolean;
      function GetShouldDisplayToolbar : boolean;
      function GetShouldDisplayScrollBars : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2WindowFeatures); reintroduce;
      destructor  Destroy; override;
      procedure   CopyToRecord(var aWindowFeatures : TWVWindowFeatures);

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized             : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                : ICoreWebView2WindowFeatures     read FBaseIntf;
      /// <summary>
      /// Specifies left and top values.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_hasposition">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property HasPosition             : boolean                         read GetHasPosition;
      /// <summary>
      /// Specifies height and width values.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_hassize">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property HasSize                 : boolean                         read GetHasSize;
      /// <summary>
      /// Specifies the left position of the window.   If `HasPosition` is set to
      /// `FALSE`, this field is ignored.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_left">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property Left                    : cardinal                        read GetLeft;
      /// <summary>
      /// Specifies the top position of the window.   If `HasPosition` is set to
      /// `FALSE`, this field is ignored.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_top">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property Top                     : cardinal                        read GetTop;
      /// <summary>
      /// Specifies the width of the window.  Minimum value is `100`.  If `HasSize`
      /// is set to `FALSE`, this field is ignored.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_width">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property Width                   : cardinal                        read GetWidth;
      /// <summary>
      /// Specifies the height of the window.  Minimum value is `100`.  If
      /// `HasSize` is set to `FALSE`, this field is ignored.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_height">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property Height                  : cardinal                        read GetHeight;
      /// <summary>
      /// Indicates that the menu bar is displayed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_shoulddisplaymenubar">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property ShouldDisplayMenuBar    : boolean                         read GetShouldDisplayMenuBar;
      /// <summary>
      /// Indicates that the status bar is displayed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_shoulddisplaystatus">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property ShouldDisplayStatus     : boolean                         read GetShouldDisplayStatus;
      /// <summary>
      /// Indicates that the browser toolbar is displayed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_shoulddisplaytoolbar">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property ShouldDisplayToolbar    : boolean                         read GetShouldDisplayToolbar;
      /// <summary>
      /// Indicates that the scroll bars are displayed.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures#get_shoulddisplayscrollbars">See the ICoreWebView2WindowFeatures article.</see></para>
      /// </remarks>
      property ShouldDisplayScrollBars : boolean                         read GetShouldDisplayScrollBars;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2WindowFeatures.Create(const aBaseIntf: ICoreWebView2WindowFeatures);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2WindowFeatures.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

procedure TCoreWebView2WindowFeatures.CopyToRecord(var aWindowFeatures : TWVWindowFeatures);
begin
  aWindowFeatures.HasPosition             := HasPosition;
  aWindowFeatures.HasSize                 := HasSize;
  aWindowFeatures.Left                    := Left;
  aWindowFeatures.Top                     := Top;
  aWindowFeatures.Width                   := Width;
  aWindowFeatures.Height                  := Height;
  aWindowFeatures.ShouldDisplayMenuBar    := ShouldDisplayMenuBar;
  aWindowFeatures.ShouldDisplayStatus     := ShouldDisplayStatus;
  aWindowFeatures.ShouldDisplayToolbar    := ShouldDisplayToolbar;
  aWindowFeatures.ShouldDisplayScrollBars := ShouldDisplayScrollBars;
end;

function TCoreWebView2WindowFeatures.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WindowFeatures.GetHasPosition : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasPosition(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetHasSize : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_HasSize(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetLeft : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Left(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetTop : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Top(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetWidth : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Width(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetHeight : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_Height(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayMenuBar : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayMenuBar(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayStatus : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayStatus(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayToolbar : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayToolbar(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2WindowFeatures.GetShouldDisplayScrollBars : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldDisplayScrollBars(TempResult)) and
            (TempResult <> 0);
end;


end.

