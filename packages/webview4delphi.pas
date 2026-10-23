{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit WebView4Delphi;

{$warn 5023 off : no warning about unused units}
interface

uses
  uWVBrowser, uWVBrowserBase, uWVConstants, uWVCoreWebView2, 
  uWVCoreWebView2Args, uWVCoreWebView2BasicAuthenticationResponse, 
  uWVCoreWebView2BrowserExtension, uWVCoreWebView2BrowserExtensionList, 
  uWVCoreWebView2Certificate, uWVCoreWebView2ClientCertificate, 
  uWVCoreWebView2ClientCertificateCollection, 
  uWVCoreWebView2CompositionController, uWVCoreWebView2ContextMenuItem, 
  uWVCoreWebView2ContextMenuItemCollection, uWVCoreWebView2ContextMenuTarget, 
  uWVCoreWebView2Controller, uWVCoreWebView2ControllerOptions, 
  uWVCoreWebView2Cookie, uWVCoreWebView2CookieList, 
  uWVCoreWebView2CookieManager, uWVCoreWebView2CustomSchemeRegistration, 
  uWVCoreWebView2DedicatedWorker, uWVCoreWebView2Deferral, 
  uWVCoreWebView2Delegates, uWVCoreWebView2DownloadOperation, 
  uWVCoreWebView2Environment, uWVCoreWebView2EnvironmentOptions, 
  uWVCoreWebView2ExecuteScriptResult, uWVCoreWebView2File, 
  uWVCoreWebView2FileSystemHandle, uWVCoreWebView2Find, 
  uWVCoreWebView2FindOptions, uWVCoreWebView2Frame, uWVCoreWebView2FrameInfo, 
  uWVCoreWebView2FrameInfoCollection, 
  uWVCoreWebView2FrameInfoCollectionIterator, 
  uWVCoreWebView2HttpHeadersCollectionIterator, 
  uWVCoreWebView2HttpRequestHeaders, uWVCoreWebView2HttpResponseHeaders, 
  uWVCoreWebView2Notification, uWVCoreWebView2ObjectCollection, 
  uWVCoreWebView2ObjectCollectionView, uWVCoreWebView2PermissionSetting, 
  uWVCoreWebView2PermissionSettingCollectionView, uWVCoreWebView2PointerInfo, 
  uWVCoreWebView2PrintSettings, uWVCoreWebView2ProcessExtendedInfo, 
  uWVCoreWebView2ProcessExtendedInfoCollection, uWVCoreWebView2ProcessInfo, 
  uWVCoreWebView2ProcessInfoCollection, uWVCoreWebView2Profile, 
  uWVCoreWebView2RegionRectCollectionView, uWVCoreWebView2ScriptException, 
  uWVCoreWebView2ServiceWorker, uWVCoreWebView2ServiceWorkerManager, 
  uWVCoreWebView2ServiceWorkerRegistration, 
  uWVCoreWebView2ServiceWorkerRegistrationCollectionView, 
  uWVCoreWebView2Settings, uWVCoreWebView2SharedBuffer, 
  uWVCoreWebView2SharedWorker, uWVCoreWebView2SharedWorkerCollectionView, 
  uWVCoreWebView2SharedWorkerManager, uWVCoreWebView2StringCollection, 
  uWVCoreWebView2WebResourceRequest, uWVCoreWebView2WebResourceResponse, 
  uWVCoreWebView2WebResourceResponseView, uWVCoreWebView2WindowFeatures, 
  uWVEvents, uWVInterfaces, uWVLibFunctions, uWVLoader, uWVLoaderInternal, 
  uWVMiscFunctions, uWVTypeLibrary, uWVTypes, uWVWinControl, uWVWindowParent, 
  uWVCoreWebView2CrashReport, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uWVBrowser', @uWVBrowser.Register);
  RegisterUnit('uWVWindowParent', @uWVWindowParent.Register);
end;

initialization
  RegisterPackage('WebView4Delphi', @Register);
end.
