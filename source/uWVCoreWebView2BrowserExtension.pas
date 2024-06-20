unit uWVCoreWebView2BrowserExtension;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes,
  {$ELSE}
  Classes,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides a set of properties for managing an Extension, which includes
  /// an ID, name, and whether it is enabled or not, and the ability to Remove
  /// the Extension, and enable or disable it.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextension">See the ICoreWebView2BrowserExtension article.</see></para>
  /// </remarks>
  TCoreWebView2BrowserExtension = class
    protected
      FBaseIntf : ICoreWebView2BrowserExtension;

      function GetInitialized : boolean;
      function GetID : wvstring;
      function GetName : wvstring;
      function GetIsEnabled : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2BrowserExtension); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Removes this browser extension from its WebView2 Profile. The browser extension is removed
      /// immediately including from all currently running HTML documents associated with this
      /// WebView2 Profile. The removal is persisted and future uses of this profile will not have this
      /// extension installed. After an extension is removed, calling `Remove` again will cause an exception.
      /// </summary>
      /// <remarks>
      /// <para>The TWVBrowserBase.OnBrowserExtensionRemoveCompleted event is triggered when this function finishes.</para>
      /// </remarks>
      function    Remove(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Sets whether this browser extension is enabled or disabled. This change applies immediately
      /// to the extension in all HTML documents in all WebView2s associated with this profile.
      /// After an extension is removed, calling `Enable` will not change the value of `IsEnabled`.
      /// </summary>
      /// <remarks>
      /// <para>The TWVBrowserBase.OnBrowserExtensionEnableCompleted event is triggered when this function finishes.</para>
      /// </remarks>
      function    Enable(aIsEnabled : boolean; const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized    : boolean                               read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf       : ICoreWebView2BrowserExtension         read FBaseIntf           write FBaseIntf;
      /// <summary>
      /// This is the browser extension's ID. This is the same browser extension ID returned by
      /// the browser extension API [`chrome.runtime.id`](https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions/API/runtime/id).
      /// Please see that documentation for more details on how the ID is generated.
      /// After an extension is removed, calling `Id` will return the id of the extension that is removed.
      /// </summary>
      property ID             : wvstring                              read GetID;
      /// <summary>
      /// This is the browser extension's name. This value is defined in this browser extension's
      /// manifest.json file. If manifest.json define extension's localized name, this value will
      /// be the localized version of the name.
      /// Please see [Manifest.json name](https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions/manifest.json/name)
      /// for more details.
      /// After an extension is removed, calling `Name` will return the name of the extension that is removed.
      /// </summary>
      property Name           : wvstring                              read GetName;
      /// <summary>
      /// If `isEnabled` is true then the Extension is enabled and running in WebView instances.
      /// If it is false then the Extension is disabled and not running in WebView instances.
      /// When a Extension is first installed, `IsEnable` are default to be `TRUE`.
      /// `isEnabled` is persisted per profile.
      /// After an extension is removed, calling `isEnabled` will return the value at the time it was removed.
      /// </summary>
      property IsEnabled      : boolean                               read GetIsEnabled;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVCoreWebView2Delegates, uWVBrowserBase;

constructor TCoreWebView2BrowserExtension.Create(const aBaseIntf: ICoreWebView2BrowserExtension);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2BrowserExtension.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2BrowserExtension.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2BrowserExtension.GetID : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_id(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2BrowserExtension.GetName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Name(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2BrowserExtension.GetIsEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2BrowserExtension.Remove(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BrowserExtensionRemoveCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2BrowserExtensionRemoveCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), ID);
      Result      := succeeded(FBaseIntf.Remove(TempHandler));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2BrowserExtension.Enable(aIsEnabled : boolean; const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2BrowserExtensionEnableCompletedHandler;
begin
  Result := False;

  if Initialized then
    try
      TempHandler := TCoreWebView2BrowserExtensionEnableCompletedHandler.Create(TWVBrowserBase(aBrowserComponent), ID);
      Result      := succeeded(FBaseIntf.Enable(ord(aIsEnabled), TempHandler));
    finally
      TempHandler := nil;
    end;
end;

end.
