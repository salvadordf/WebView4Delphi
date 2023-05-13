unit WebView4DelphiVCL_register;

{$R res\webview4delphi.dcr}

{$I ..\source\webview2.inc}

// Disable this DEFINE if your Delphi installation can't find ToolsAPI.pas or designide.dcp
{$DEFINE ADDSPLASHSCREENLOGO}

interface

procedure Register;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, Winapi.Windows, System.SysUtils, {$IFDEF ADDSPLASHSCREENLOGO}ToolsApi,{$ENDIF}
  {$ELSE}
  Classes, Windows, SysUtils,
  {$ENDIF}
  uWVBrowser, uWVWindowParent;

{$IFDEF DELPHI16_UP}{$IFDEF ADDSPLASHSCREENLOGO}
procedure AddBitmapToSplashScreen;
const
  {$I ..\source\uWVVersion.inc}
var
  TempBitmap : HBITMAP;
  TempVersion : string;
begin
  if assigned(SplashScreenServices) then
    begin
      TempBitmap := LoadBitmap(FindResourceHInstance(HInstance), 'WebView2');
      try
        TempVersion := IntToStr(WEBVIEW2LOADERLIB_VERSION_MAJOR) + '.' +
                       IntToStr(WEBVIEW2LOADERLIB_VERSION_MINOR) + '.' +
                       IntToStr(WEBVIEW2LOADERLIB_VERSION_RELEASE) + '.' +
                       IntToStr(WEBVIEW2LOADERLIB_VERSION_BUILD);

        SplashScreenServices.AddPluginBitmap('WebView4Delphi ' + TempVersion, TempBitmap, False, 'MIT license');
      finally
        DeleteObject(TempBitmap);
      end;
    end;
end;
{$ENDIF}{$ENDIF}

procedure Register;
begin
  RegisterComponents('WebView4Delphi', [TWVBrowser]);
  RegisterComponents('WebView4Delphi', [TWVWindowParent]);

  {$IFDEF DELPHI16_UP}{$IFDEF ADDSPLASHSCREENLOGO}
  AddBitmapToSplashScreen;
  {$ENDIF}{$ENDIF}
end;

end.
