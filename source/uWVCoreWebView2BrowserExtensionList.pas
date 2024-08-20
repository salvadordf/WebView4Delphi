unit uWVCoreWebView2BrowserExtensionList;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// A collection of ICoreWebView2BrowserExtension.
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
      /// The number of elements contained in the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionlist#get_count">See the ICoreWebView2ProcessExtendedInfoCollection article.</see></para>
      /// </remarks>
      property Count                 : cardinal                                     read GetCount;
      /// <summary>
      /// Gets the element at the given index.
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
