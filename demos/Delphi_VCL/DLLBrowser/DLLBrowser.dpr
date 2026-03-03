library DLLBrowser;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters.

  Important note about VCL usage: when this DLL will be implicitly
  loaded and this DLL uses TWicImage / TImageCollection created in
  any unit initialization section, then Vcl.WicImageInit must be
  included into your library's USES clause. }

uses
  System.SysUtils,
  System.Classes,
  uWVLoader,
  uWebBrowserForm in 'uWebBrowserForm.pas' {WebBrowserForm};

{$R *.res}

procedure InitializeWebView4Delphi; stdcall;
begin
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := IncludeTrailingPathDelimiter(ExtractFileDir(GetModuleName(HINSTANCE))) + '\CustomCache';
  GlobalWebView2Loader.StartWebView2;
end;

procedure FinalizeWebView4Delphi; stdcall;
begin
  DestroyGlobalWebView2Loader;
end;

procedure ShowBrowser; stdcall;
begin
  WebBrowserForm := TWebBrowserForm.Create(nil);
  WebBrowserForm.Show;
end;

exports
  InitializeWebView4Delphi,
  FinalizeWebView4Delphi,
  ShowBrowser;

begin
end.
