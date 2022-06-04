{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit WebView4Delphi;

{$warn 5023 off : no warning about unused units}
interface

uses
  uWVBrowser, uWVBrowserBase, uWVConstants, uWVCoreWebView2, 
  uWVCoreWebView2Args, uWVCoreWebView2ClientCertificate, 
  uWVCoreWebView2ClientCertificateCollection, 
  uWVCoreWebView2CompositionController, uWVCoreWebView2Controller, 
  uWVCoreWebView2Cookie, uWVCoreWebView2CookieList, 
  uWVCoreWebView2CookieManager, uWVCoreWebView2Deferral, 
  uWVCoreWebView2Delegates, uWVCoreWebView2DownloadOperation, 
  uWVCoreWebView2Environment, uWVCoreWebView2EnvironmentOptions, 
  uWVCoreWebView2Frame, uWVCoreWebView2FrameInfo, 
  uWVCoreWebView2FrameInfoCollection, 
  uWVCoreWebView2FrameInfoCollectionIterator, 
  uWVCoreWebView2HttpHeadersCollectionIterator, 
  uWVCoreWebView2HttpRequestHeaders, uWVCoreWebView2HttpResponseHeaders, 
  uWVCoreWebView2PointerInfo, uWVCoreWebView2PrintSettings, 
  uWVCoreWebView2Settings, uWVCoreWebView2StringCollection, 
  uWVCoreWebView2WebResourceRequest, uWVCoreWebView2WebResourceResponse, 
  uWVCoreWebView2WebResourceResponseView, uWVCoreWebView2WindowFeatures, 
  uWVEvents, uWVInterfaces, uWVLibFunctions, uWVLoader, uWVMiscFunctions, 
  uWVTypeLibrary, uWVTypes, uWVWinControl, uWVWindowParent, 
  uWVCoreWebView2ProcessInfo, uWVCoreWebView2ProcessInfoCollection, 
  uWVCoreWebView2BasicAuthenticationResponse, uWVCoreWebView2ContextMenuItem, 
  uWVCoreWebView2ContextMenuItemCollection, uWVCoreWebView2ContextMenuTarget, 
  uWVLoaderInternal, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uWVBrowser', @uWVBrowser.Register);
  RegisterUnit('uWVWindowParent', @uWVWindowParent.Register);
end;

initialization
  RegisterPackage('WebView4Delphi', @Register);
end.
