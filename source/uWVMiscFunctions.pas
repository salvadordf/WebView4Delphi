unit uWVMiscFunctions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF FPC}
  Windows, Classes, ActiveX, SysUtils, Graphics, Math,
  {$ELSE}
  Winapi.Windows, System.Classes, System.UITypes, Winapi.ActiveX, System.SysUtils, System.Math,
  {$ENDIF}
  uWVConstants, uWVTypeLibrary, uWVTypes;

function AllocCoTaskMemStr(const aString : wvstring): PWideChar;
function LowestChromiumVersion : wvstring;
function LowestLoaderDLLVersion : wvstring;
function EnvironmentCreationErrorToString(aErrorCode : HRESULT) : wvstring;
function GetScreenDPI : integer;
function GetDeviceScaleFactor : single;

procedure OutputDebugMessage(const aMessage : string);
function  CustomExceptionHandler(const aFunctionName : string; const aException : exception) : boolean;

function CoreWebViewColorToDelphiColor(const aColor : COREWEBVIEW2_COLOR) : TColor;
function DelphiColorToCoreWebViewColor(const aColor : TColor) : COREWEBVIEW2_COLOR;

function TryIso8601BasicToDate(const Str: string; out Date: TDateTime): Boolean;

implementation

uses
  uWVLoader;

function AllocCoTaskMemStr(const aString : wvstring): PWideChar;
var
  TempLen    : integer;
  TempString : wvstring;
begin
  TempLen := Length(aString);

  if (TempLen > 0) then
    begin
      TempLen    := succ(TempLen) * SizeOf(WideChar);
      TempString := aString + #0;
      Result     := CoTaskMemAlloc(TempLen);

      Move(TempString[1], Result^, TempLen);
    end
   else
    Result := nil;
end;

function LowestChromiumVersion : wvstring;
begin
  Result := wvstring(inttostr(CHROMIUM_VERSION_MAJOR)   + '.' +
                     inttostr(CHROMIUM_VERSION_MINOR)   + '.' +
                     inttostr(CHROMIUM_VERSION_RELEASE) + '.' +
                     inttostr(CHROMIUM_VERSION_BUILD));
end;

function LowestLoaderDLLVersion : wvstring;
begin
  Result := wvstring(inttostr(WEBVIEW2LOADERLIB_VERSION_MAJOR)   + '.' +
                     inttostr(WEBVIEW2LOADERLIB_VERSION_MINOR)   + '.' +
                     inttostr(WEBVIEW2LOADERLIB_VERSION_RELEASE) + '.' +
                     inttostr(WEBVIEW2LOADERLIB_VERSION_BUILD));
end;

function EnvironmentCreationErrorToString(aErrorCode : HRESULT) : wvstring;
const
  // Undefined GetLastError error values
  ERROR_INVALID_STATE       = 5023;
  ERROR_PRODUCT_UNINSTALLED = 1614;
begin
  case aErrorCode of
    CO_E_NOTINITIALIZED : Result := 'CoInitializeEx was not called.';
    RPC_E_CHANGED_MODE  : Result := 'CoInitializeEx was previously called with COINIT_MULTITHREADED.';
    E_ACCESSDENIED      : Result := 'Unable to create user data folder, Access Denied.';
    E_FAIL              : Result := 'Edge runtime unable to start.';
    else
      if (aErrorCode = HResultFromWin32(ERROR_NOT_SUPPORTED)) then
        Result := '\Edge\Application path used in browserExecutableFolder.'
       else
        if (aErrorCode = HResultFromWin32(ERROR_INVALID_STATE)) then
          Result := 'Specified options do not match the options of the WebViews that are currently running in the shared browser process.'
         else
          if (aErrorCode = HResultFromWin32(ERROR_DISK_FULL)) then
            Result := 'There are too many previous WebView2 Runtime versions.'
           else
            if (aErrorCode = HResultFromWin32(ERROR_PRODUCT_UNINSTALLED)) then
              Result := 'Webview depends upon an installed WebView2 Runtime version and it is uninstalled.'
             else
              if (aErrorCode = HResultFromWin32(ERROR_FILE_NOT_FOUND)) then
                Result := 'Could not find Edge installation.'
               else
                if (aErrorCode = HResultFromWin32(ERROR_FILE_EXISTS)) then
                  Result := 'User data folder cannot be created because a file with the same name already exists.';
  end;
end;

function CoreWebViewColorToDelphiColor(const aColor : COREWEBVIEW2_COLOR) : TColor;
begin
  Result := (aColor.R or (aColor.G shl 8) or (aColor.B shl 16) or (aColor.A shl 24));
end;

function DelphiColorToCoreWebViewColor(const aColor : TColor) : COREWEBVIEW2_COLOR;
begin
  Result.R := byte(aColor and $000000FF);
  Result.G := byte((aColor and $0000FF00) shr 8);
  Result.B := byte((aColor and $00FF0000) shr 16);
  Result.A := byte(aColor shr 24);
end;

function GetScreenDPI : integer;
var
  TempDC : HDC;
begin
  TempDC := GetDC(0);
  Result := GetDeviceCaps(TempDC, LOGPIXELSX);
  ReleaseDC(0, TempDC);
end;

function GetDeviceScaleFactor : single;
begin
  Result := GetScreenDPI / USER_DEFAULT_SCREEN_DPI;
end;

procedure OutputDebugMessage(const aMessage : string);
begin
  {$IFDEF DEBUG}
  OutputDebugString({$IFDEF FPC}PAnsiChar{$ELSE}PWideChar{$ENDIF}(aMessage + #0));
  {$ENDIF}
end;

function CustomExceptionHandler(const aFunctionName : string; const aException : exception) : boolean;
begin
  OutputDebugMessage(aFunctionName + ' error : ' + aException.message);

  Result := (GlobalWebView2Loader <> nil) and GlobalWebView2Loader.ReRaiseExceptions;
end;

// Basic ISO8601ToDate alternative written by David Heffernan
// https://stackoverflow.com/questions/24108718/is-there-a-delphi-rtl-function-that-can-convert-the-iso-8601-basic-date-format-t
// Use ISO8601ToDate in Delphi XE6 or later versions.
function TryIso8601BasicToDate(const Str: string; out Date: TDateTime): Boolean;
var
  Year, Month, Day: Integer;
begin
  Assert(Length(Str)=8);
  Result := TryStrToInt(Copy(Str, 1, 4), Year);
  if not Result then
    exit;
  Result := TryStrToInt(Copy(Str, 5, 2), Month);
  if not Result then
    exit;
  Result := TryStrToInt(Copy(Str, 7, 2), Day);
  if not Result then
    exit;
  Result := TryEncodeDate(Year, Month, Day, Date);
end;

end.
