unit uWVCoreWebView2CookieList;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// A list of cookie objects. See ICoreWebView2Cookie.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookielist">See the ICoreWebView2CookieList article.</see></para>
  /// </remarks>
  TCoreWebView2CookieList = class
    protected
      FBaseIntf : ICoreWebView2CookieList;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2Cookie;

    public
      constructor Create(const aBaseIntf : ICoreWebView2CookieList); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2CookieList     read FBaseIntf;
      /// <summary>
      /// The number of cookies contained in the ICoreWebView2CookieList.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookielist#get_count">See the ICoreWebView2CookieList article.</see></para>
      /// </remarks>
      property Count                 : cardinal                    read GetCount;
      /// <summary>
      /// Gets the cookie object at the given index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookielist#getvalueatindex">See the ICoreWebView2CookieList article.</see></para>
      /// </remarks>
      property Items[idx : cardinal] : ICoreWebView2Cookie         read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2CookieList.Create(const aBaseIntf: ICoreWebView2CookieList);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2CookieList.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2CookieList.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2CookieList.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2CookieList.GetValueAtIndex(index : cardinal) : ICoreWebView2Cookie;
var
  TempResult : ICoreWebView2Cookie;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

end.
