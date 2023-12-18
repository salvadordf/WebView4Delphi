unit uWVCoreWebView2BrowserExtensionList;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// Provides a set of properties for managing browser Extension Lists from user profile. This
  /// includes the number of browser Extensions in the list, and the ability to get an browser
  /// Extension from the list at a particular index.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionlist">See the ICoreWebView2BrowserExtensionList article.</see></para>
  /// </remarks>
  TCoreWebView2BrowserExtensionList = class
    protected
      FBaseIntf : ICoreWebView2BrowserExtensionList;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2BrowserExtension;

    public
      constructor Create(const aBaseIntf : ICoreWebView2BrowserExtensionList); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2BrowserExtensionList   read FBaseIntf;
      /// <summary>
      /// The number of browser Extensions in the list.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionlist#get_count">See the ICoreWebView2ProcessExtendedInfoCollection article.</see></para>
      /// </remarks>
      property Count                 : cardinal                                     read GetCount;
      /// <summary>
      /// Gets the browser Extension located in the browser Extension List at the given index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionlist#getvalueatindex">See the ICoreWebView2ProcessExtendedInfoCollection article.</see></para>
      /// </remarks>
      property Items[idx : cardinal] : ICoreWebView2BrowserExtension             read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2BrowserExtensionList.Create(const aBaseIntf: ICoreWebView2BrowserExtensionList);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2BrowserExtensionList.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2BrowserExtensionList.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2BrowserExtensionList.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2BrowserExtensionList.GetValueAtIndex(index : cardinal) : ICoreWebView2BrowserExtension;
var
  TempResult : ICoreWebView2BrowserExtension;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

end.
