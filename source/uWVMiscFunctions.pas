unit uWVMiscFunctions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF FPC}
  Windows, Classes, ActiveX, SysUtils, Graphics, Math, Controls, StrUtils,
  {$ELSE}
  Winapi.Windows, System.Classes, System.UITypes, Winapi.ActiveX, System.SysUtils, System.Math, System.StrUtils,
  {$ENDIF}
  uWVConstants, uWVTypeLibrary, uWVTypes;

const
  SHLWAPIDLL  = 'shlwapi.dll';

function AllocCoTaskMemStr(const aString : wvstring): PWideChar;
function LowestChromiumVersion : wvstring;
function LowestLoaderDLLVersion : wvstring;
function EnvironmentCreationErrorToString(aErrorCode : HRESULT) : wvstring;
function ControllerCreationErrorToString(aErrorCode : HRESULT) : wvstring;
function CompositionControllerCreationErrorToString(aErrorCode : HRESULT) : wvstring;
function GetScreenDPI : integer;
function GetDeviceScaleFactor : single;
function EditingCommandToString(aEditingCommand : TWV2EditingCommand): wvstring;
function DeleteDirContents(const aDirectory : string; const aExcludeFiles : TStringList = nil) : boolean;
function SystemCursorIDToDelphiCursor(aSystemCursorID : cardinal) : TCursor;

procedure OutputDebugMessage(const aMessage : string);
function  CustomExceptionHandler(const aFunctionName : string; const aException : exception) : boolean;
procedure LogMouseEvent(aEventKind : TWVMouseEventKind; aVirtualKeys : TWVMouseEventVirtualKeys; aMouseData : cardinal; aPoint : TPoint);

function CoreWebViewColorToDelphiColor(const aColor : COREWEBVIEW2_COLOR) : TColor;
function DelphiColorToCoreWebViewColor(const aColor : TColor) : COREWEBVIEW2_COLOR;

function TryIso8601BasicToDate(const Str: string; out Date: TDateTime): Boolean;
function JSONUnescape(const Source: wvstring): wvstring;
function JSONEscape(const Source: wvstring): wvstring;

function CustomPathIsRelative(const aPath : wvstring) : boolean;
function CustomPathCanonicalize(const aOriginalPath : wvstring; var aCanonicalPath : wvstring) : boolean;
function CustomAbsolutePath(const aPath : wvstring) : wvstring;
function CustomPathIsURL(const aPath : wvstring) : boolean;
function CustomPathIsUNC(const aPath : wvstring) : boolean;
function GetModulePath : wvstring;
function EscapeCommandLineParameter(const aParameter : wvstring) : wvstring;

function PathIsRelativeAnsi(pszPath: LPCSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathIsRelativeA';
function PathIsRelativeUnicode(pszPath: LPCWSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathIsRelativeW';
function PathCanonicalizeAnsi(pszBuf: LPSTR; pszPath: LPCSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathCanonicalizeA';
function PathCanonicalizeUnicode(pszBuf: LPWSTR; pszPath: LPCWSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathCanonicalizeW';
function PathIsUNCAnsi(pszPath: LPCSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathIsUNCA';
function PathIsUNCUnicode(pszPath: LPCWSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathIsUNCW';
function PathIsURLAnsi(pszPath: LPCSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathIsURLA';
function PathIsURLUnicode(pszPath: LPCWSTR): BOOL; stdcall; external SHLWAPIDLL name 'PathIsURLW';

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
                  Result := 'User data folder cannot be created because a file with the same name already exists.'
                 else
                  Result := 'Unexpected error result.';
  end;
end;

function ControllerCreationErrorToString(aErrorCode : HRESULT) : wvstring;
const
  // Undefined GetLastError error values
  ERROR_INVALID_STATE       = 5023;
begin
  case aErrorCode of
    E_ABORT : Result := 'The parent window was destroyed before the controller creation was finished.';
    else
      if (aErrorCode = HResultFromWin32(ERROR_INVALID_STATE)) then
        Result := 'Another browser is using the same user data folder.'
       else
        Result := 'Unexpected error result.';
  end;
end;

function CompositionControllerCreationErrorToString(aErrorCode : HRESULT) : wvstring;
const
  // Undefined GetLastError error values
  ERROR_INVALID_STATE       = 5023;
begin
  case aErrorCode of
    E_ABORT : Result := 'The parent window was destroyed before the composition controller creation was finished.';
    else
      if (aErrorCode = HResultFromWin32(ERROR_INVALID_STATE)) then
        Result := 'Another browser is using the same user data folder.'
       else
        Result := 'Unexpected error result.';
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

procedure LogMouseEvent(aEventKind : TWVMouseEventKind; aVirtualKeys : TWVMouseEventVirtualKeys; aMouseData : cardinal; aPoint : TPoint);
begin
  OutputDebugMessage('aEventKind: $' + IntToHex(integer(aEventKind), 4) + ', ' +
                     'aVirtualKeys: $' + IntToHex(Integer(aVirtualKeys), 2) + ', ' +
                     'aMouseData: ' + IntToStr(integer(aMouseData)) + ', ' +
                     'aPoint: (' + IntToStr(aPoint.x) + ',' + IntToStr(aPoint.y) + ')');
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

// This function is a modified version of the JSONUnescape function created by Olvin Roght in stackoverflow :
// https://stackoverflow.com/questions/9713491/delphi-decode-json-utf8-escaped-text
function JSONUnescape(const Source: wvstring): wvstring;
const
  ESCAPE_CHAR = '\';
  QUOTE_CHAR = '"';
var
  EscapeCharPos, TempPos: Integer;
  Temp: string;
  IsQuotedString: Boolean;
begin
  result := '';
  IsQuotedString := (Source[1] = QUOTE_CHAR) and
    (Source[Length(Source)] = QUOTE_CHAR);
  EscapeCharPos := Pos(ESCAPE_CHAR, Source);
  TempPos := 1;
  while EscapeCharPos > 0 do
  begin
    result := result + Copy(Source, TempPos, EscapeCharPos - TempPos);
    TempPos := EscapeCharPos;
    if EscapeCharPos < Length(Source) - Integer(IsQuotedString) then
      case Source[EscapeCharPos + 1] of
        't':
          Temp := #9;
        'n':
          Temp := #10;
        'r':
          Temp := #13;
        '\':
          Temp := '\';
        '"':
          Temp := '"';
        'u':
          begin
            if EscapeCharPos + 4 < Length(Source) - Integer(IsQuotedString) then
              Temp := Chr(StrToInt('$' + Copy(Source, EscapeCharPos + 2, 4)));
            Inc(TempPos, 4);
          end;
      end;
    Inc(TempPos, 2);
    result := result + Temp;
    EscapeCharPos := PosEx(ESCAPE_CHAR, Source, TempPos);
  end;
  result := result + Copy(Source, TempPos, Length(Source) - TempPos + 1);
end;

function JSONEscape(const Source: wvstring): wvstring;
const
  CHAR_DBLQUOTE       = #34;
  CHAR_BACKWARDSSLASH = #92;
  CHAR_FORWARDSSLASH  = #47;
  CHAR_BACKSPACE      = #8;
  CHAR_FORMFEED       = #12;
  CHAR_LINEFEED       = #10;
  CHAR_CARRIAGERETURN = #13;
  CHAR_HORIZONTALTAB  = #9;
var
  i, TempLen : integer;
begin
  Result  := '';
  TempLen := length(Source);
  i       := 1;

  while (i <= TempLen) do
    begin
      case Source[i] of
        CHAR_DBLQUOTE,
        CHAR_BACKWARDSSLASH,
        CHAR_FORWARDSSLASH  : Result := Result + '\' + Source[i];
        CHAR_BACKSPACE      : Result := Result + '\b';
        CHAR_FORMFEED       : Result := Result + '\f';
        CHAR_LINEFEED       : Result := Result + '\n';
        CHAR_CARRIAGERETURN : Result := Result + '\r';
        CHAR_HORIZONTALTAB  : Result := Result + '\t';

        else
          if (ord(Source[i]) < 32) or (ord(Source[i]) > 126) then
            Result := Result + '\u' + IntToHex(ord(Source[i]), 4)
           else
            Result := Result + Source[i];
      end;

      inc(i);
    end;
end;

function EditingCommandToString(aEditingCommand : TWV2EditingCommand): wvstring;
begin
  case aEditingCommand of
    ecAlignCenter                                  : Result := 'AlignCenter';
    ecAlignJustified                               : Result := 'AlignJustified';
    ecAlignLeft                                    : Result := 'AlignLeft';
    ecAlignRight                                   : Result := 'AlignRight';
    ecBackColor                                    : Result := 'BackColor';
    ecBackwardDelete                               : Result := 'BackwardDelete';
    ecBold                                         : Result := 'Bold';
    ecCopy                                         : Result := 'Copy';
    ecCreateLink                                   : Result := 'CreateLink';
    ecCut                                          : Result := 'Cut';
    ecDefaultParagraphSeparator                    : Result := 'DefaultParagraphSeparator';
    ecDelete                                       : Result := 'Delete';
    ecDeleteBackward                               : Result := 'DeleteBackward';
    ecDeleteBackwardByDecomposingPreviousCharacter : Result := 'DeleteBackwardByDecomposingPreviousCharacter';
    ecDeleteForward                                : Result := 'DeleteForward';
    ecDeleteToBeginningOfLine                      : Result := 'DeleteToBeginningOfLine';
    ecDeleteToBeginningOfParagraph                 : Result := 'DeleteToBeginningOfParagraph';
    ecDeleteToEndOfLine                            : Result := 'DeleteToEndOfLine';
    ecDeleteToEndOfParagraph                       : Result := 'DeleteToEndOfParagraph';
    ecDeleteToMark                                 : Result := 'DeleteToMark';
    ecDeleteWordBackward                           : Result := 'DeleteWordBackward';
    ecDeleteWordForward                            : Result := 'DeleteWordForward';
    ecFindString                                   : Result := 'FindString';
    ecFontName                                     : Result := 'FontName';
    ecFontSize                                     : Result := 'FontSize';
    ecFontSizeDelta                                : Result := 'FontSizeDelta';
    ecForeColor                                    : Result := 'ForeColor';
    ecFormatBlock                                  : Result := 'FormatBlock';
    ecForwardDelete                                : Result := 'ForwardDelete';
    ecHiliteColor                                  : Result := 'HiliteColor';
    ecIgnoreSpelling                               : Result := 'IgnoreSpelling';
    ecIndent                                       : Result := 'Indent';
    ecInsertBacktab                                : Result := 'InsertBacktab';
    ecInsertHorizontalRule                         : Result := 'InsertHorizontalRule';
    ecInsertHTML                                   : Result := 'InsertHTML';
    ecInsertImage                                  : Result := 'InsertImage';
    ecInsertLineBreak                              : Result := 'InsertLineBreak';
    ecInsertNewline                                : Result := 'InsertNewline';
    ecInsertNewlineInQuotedContent                 : Result := 'InsertNewlineInQuotedContent';
    ecInsertOrderedList                            : Result := 'InsertOrderedList';
    ecInsertParagraph                              : Result := 'InsertParagraph';
    ecInsertTab                                    : Result := 'InsertTab';
    ecInsertText                                   : Result := 'InsertText';
    ecInsertUnorderedList                          : Result := 'InsertUnorderedList';
    ecItalic                                       : Result := 'Italic';
    ecJustifyCenter                                : Result := 'JustifyCenter';
    ecJustifyFull                                  : Result := 'JustifyFull';
    ecJustifyLeft                                  : Result := 'JustifyLeft';
    ecJustifyNone                                  : Result := 'JustifyNone';
    ecJustifyRight                                 : Result := 'JustifyRight';
    ecMakeTextWritingDirectionLeftToRight          : Result := 'MakeTextWritingDirectionLeftToRight';
    ecMakeTextWritingDirectionNatural              : Result := 'MakeTextWritingDirectionNatural';
    ecMakeTextWritingDirectionRightToLeft          : Result := 'MakeTextWritingDirectionRightToLeft';
    ecMoveBackward                                 : Result := 'MoveBackward';
    ecMoveBackwardAndModifySelection               : Result := 'MoveBackwardAndModifySelection';
    ecMoveDown                                     : Result := 'MoveDown';
    ecMoveDownAndModifySelection                   : Result := 'MoveDownAndModifySelection';
    ecMoveForward                                  : Result := 'MoveForward';
    ecMoveForwardAndModifySelection                : Result := 'MoveForwardAndModifySelection';
    ecMoveLeft                                     : Result := 'MoveLeft';
    ecMoveLeftAndModifySelection                   : Result := 'MoveLeftAndModifySelection';
    ecMovePageDown                                 : Result := 'MovePageDown';
    ecMovePageDownAndModifySelection               : Result := 'MovePageDownAndModifySelection';
    ecMovePageUp                                   : Result := 'MovePageUp';
    ecMovePageUpAndModifySelection                 : Result := 'MovePageUpAndModifySelection';
    ecMoveParagraphBackward                        : Result := 'MoveParagraphBackward';
    ecMoveParagraphBackwardAndModifySelection      : Result := 'MoveParagraphBackwardAndModifySelection';
    ecMoveParagraphForward                         : Result := 'MoveParagraphForward';
    ecMoveParagraphForwardAndModifySelection       : Result := 'MoveParagraphForwardAndModifySelection';
    ecMoveRight                                    : Result := 'MoveRight';
    ecMoveRightAndModifySelection                  : Result := 'MoveRightAndModifySelection';
    ecMoveToBeginningOfDocument                    : Result := 'MoveToBeginningOfDocument';
    ecMoveToBeginningOfDocumentAndModifySelection  : Result := 'MoveToBeginningOfDocumentAndModifySelection';
    ecMoveToBeginningOfLine                        : Result := 'MoveToBeginningOfLine';
    ecMoveToBeginningOfLineAndModifySelection      : Result := 'MoveToBeginningOfLineAndModifySelection';
    ecMoveToBeginningOfParagraph                   : Result := 'MoveToBeginningOfParagraph';
    ecMoveToBeginningOfParagraphAndModifySelection : Result := 'MoveToBeginningOfParagraphAndModifySelection';
    ecMoveToBeginningOfSentence                    : Result := 'MoveToBeginningOfSentence';
    ecMoveToBeginningOfSentenceAndModifySelection  : Result := 'MoveToBeginningOfSentenceAndModifySelection';
    ecMoveToEndOfDocument                          : Result := 'MoveToEndOfDocument';
    ecMoveToEndOfDocumentAndModifySelection        : Result := 'MoveToEndOfDocumentAndModifySelection';
    ecMoveToEndOfLine                              : Result := 'MoveToEndOfLine';
    ecMoveToEndOfLineAndModifySelection            : Result := 'MoveToEndOfLineAndModifySelection';
    ecMoveToEndOfParagraph                         : Result := 'MoveToEndOfParagraph';
    ecMoveToEndOfParagraphAndModifySelection       : Result := 'MoveToEndOfParagraphAndModifySelection';
    ecMoveToEndOfSentence                          : Result := 'MoveToEndOfSentence';
    ecMoveToEndOfSentenceAndModifySelection        : Result := 'MoveToEndOfSentenceAndModifySelection';
    ecMoveToLeftEndOfLine                          : Result := 'MoveToLeftEndOfLine';
    ecMoveToLeftEndOfLineAndModifySelection        : Result := 'MoveToLeftEndOfLineAndModifySelection';
    ecMoveToRightEndOfLine                         : Result := 'MoveToRightEndOfLine';
    ecMoveToRightEndOfLineAndModifySelection       : Result := 'MoveToRightEndOfLineAndModifySelection';
    ecMoveUp                                       : Result := 'MoveUp';
    ecMoveUpAndModifySelection                     : Result := 'MoveUpAndModifySelection';
    ecMoveWordBackward                             : Result := 'MoveWordBackward';
    ecMoveWordBackwardAndModifySelection           : Result := 'MoveWordBackwardAndModifySelection';
    ecMoveWordForward                              : Result := 'MoveWordForward';
    ecMoveWordForwardAndModifySelection            : Result := 'MoveWordForwardAndModifySelection';
    ecMoveWordLeft                                 : Result := 'MoveWordLeft';
    ecMoveWordLeftAndModifySelection               : Result := 'MoveWordLeftAndModifySelection';
    ecMoveWordRight                                : Result := 'MoveWordRight';
    ecMoveWordRightAndModifySelection              : Result := 'MoveWordRightAndModifySelection';
    ecOutdent                                      : Result := 'Outdent';
    ecOverWrite                                    : Result := 'OverWrite';
    ecPaste                                        : Result := 'Paste';
    ecPasteAndMatchStyle                           : Result := 'PasteAndMatchStyle';
    ecPasteGlobalSelection                         : Result := 'PasteGlobalSelection';
    ecPrint                                        : Result := 'Print';
    ecRedo                                         : Result := 'Redo';
    ecRemoveFormat                                 : Result := 'RemoveFormat';
    ecScrollLineDown                               : Result := 'ScrollLineDown';
    ecScrollLineUp                                 : Result := 'ScrollLineUp';
    ecScrollPageBackward                           : Result := 'ScrollPageBackward';
    ecScrollPageForward                            : Result := 'ScrollPageForward';
    ecScrollToBeginningOfDocument                  : Result := 'ScrollToBeginningOfDocument';
    ecScrollToEndOfDocument                        : Result := 'ScrollToEndOfDocument';
    ecSelectAll                                    : Result := 'SelectAll';
    ecSelectLine                                   : Result := 'SelectLine';
    ecSelectParagraph                              : Result := 'SelectParagraph';
    ecSelectSentence                               : Result := 'SelectSentence';
    ecSelectToMark                                 : Result := 'SelectToMark';
    ecSelectWord                                   : Result := 'SelectWord';
    ecSetMark                                      : Result := 'SetMark';
    ecStrikethrough                                : Result := 'Strikethrough';
    ecStyleWithCSS                                 : Result := 'StyleWithCSS';
    ecSubscript                                    : Result := 'Subscript';
    ecSuperscript                                  : Result := 'Superscript';
    ecSwapWithMark                                 : Result := 'SwapWithMark';
    ecToggleBold                                   : Result := 'ToggleBold';
    ecToggleItalic                                 : Result := 'ToggleItalic';
    ecToggleUnderline                              : Result := 'ToggleUnderline';
    ecTranspose                                    : Result := 'Transpose';
    ecUnderline                                    : Result := 'Underline';
    ecUndo                                         : Result := 'Undo';
    ecUnlink                                       : Result := 'Unlink';
    ecUnscript                                     : Result := 'Unscript';
    ecUnselect                                     : Result := 'Unselect';
    ecUseCSS                                       : Result := 'UseCSS';
    ecYank                                         : Result := 'Yank';
    ecYankAndSelect                                : Result := 'YankAndSelect';
    else                                             Result := '';
  end;
end;

function DeleteDirContents(const aDirectory : string; const aExcludeFiles : TStringList) : boolean;
var
  TempRec  : TSearchRec;
  TempPath : string;
  TempIdx  : integer;
begin
  Result := True;

  try
    if (length(aDirectory) > 0) and
       DirectoryExists(aDirectory) and
       (FindFirst(aDirectory + '\*', faAnyFile, TempRec) = 0) then
      try
        repeat
          TempPath := aDirectory + PathDelim + TempRec.Name;

          if ((TempRec.Attr and faDirectory) <> 0) then
            begin
              if (TempRec.Name <> '.') and (TempRec.Name <> '..') then
                begin
                  if DeleteDirContents(TempPath, aExcludeFiles) then
                    Result := RemoveDir(TempPath) and Result
                   else
                    Result := False;
                end;
            end
           else
            if (aExcludeFiles <> nil) then
              begin
                TempIdx := aExcludeFiles.IndexOf(TempRec.Name);
                Result  := ((TempIdx >= 0) or
                            ((TempIdx < 0) and DeleteFile(TempPath))) and
                           Result;
              end
             else
              Result := DeleteFile(TempPath) and Result;

        until (FindNext(TempRec) <> 0) or not(Result);
      finally
        FindClose(TempRec);
      end;
  except
    on e : exception do
      if CustomExceptionHandler('DeleteDirContents', e) then raise;
  end;
end;

function SystemCursorIDToDelphiCursor(aSystemCursorID : cardinal) : TCursor;
begin
  // https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-loadcursorw
  case aSystemCursorId of
    32650 : Result := crAppStart;
    32512 : Result := crArrow;
    32515 : Result := crCross;
    32649 : Result := crHandPoint;
    32651 : Result := crHelp;
    32513 : Result := crIBeam;
    32648 : Result := crNoDrop;
    32640,
    32646 : Result := crSizeAll;
    32643 : Result := crSizeNESW;
    32645 : Result := crSizeNS;
    32642 : Result := crSizeNWSE;
    32644 : Result := crSizeWE;
    32516 : Result := crUpArrow;
    32514 : Result := crHourGlass;
    else    Result := crDefault;
  end;
end;

function CustomPathIsRelative(const aPath : wvstring) : boolean;
begin
  Result := PathIsRelativeUnicode(PWideChar(aPath));
end;

function CustomPathIsURL(const aPath : wvstring) : boolean;
begin
  Result := PathIsURLUnicode(PWideChar(aPath + #0));
end;

function CustomPathIsUNC(const aPath : wvstring) : boolean;
begin
  Result := PathIsUNCUnicode(PWideChar(aPath + #0));
end;

function CustomPathCanonicalize(const aOriginalPath : wvstring; var aCanonicalPath : wvstring) : boolean;
var
  TempBuffer: array [0..pred(MAX_PATH)] of WideChar;
begin
  Result         := False;
  aCanonicalPath := '';

  if (length(aOriginalPath) > MAX_PATH) or
     (Copy(aOriginalPath, 1, 4) = '\\?\') or
     CustomPathIsUNC(aOriginalPath) then
    exit;

  FillChar(TempBuffer, MAX_PATH * SizeOf(WideChar), 0);

  if PathCanonicalizeUnicode(@TempBuffer[0], PWideChar(aOriginalPath + #0)) then
    begin
      aCanonicalPath := TempBuffer;
      Result         := True;
    end;
end;

function CustomAbsolutePath(const aPath : wvstring) : wvstring;
var
  TempNewPath, TempOldPath : wvstring;
begin
  if (length(aPath) > 0) then
    begin
      if CustomPathIsRelative(aPath) then
        TempOldPath := GetModulePath + aPath
       else
        TempOldPath := aPath;

      if not(CustomPathCanonicalize(TempOldPath, TempNewPath)) then
        TempNewPath := TempOldPath;

      Result := TempNewPath;
    end
   else
    Result := '';
end;

function GetModulePath : wvstring;
begin
  {$IFDEF FPC}
  Result := UTF8Decode(IncludeTrailingPathDelimiter(ExtractFileDir(GetModuleName(HINSTANCE))));
  {$ELSE}
  Result := IncludeTrailingPathDelimiter(ExtractFileDir(GetModuleName(HINSTANCE)));
  {$ENDIF}
end;

function EscapeCommandLineParameter(const aParameter : wvstring) : wvstring;
const
  RESERVEDCHARS = ['`', '~', '!', '#', '$', '&', '*', '(', ')', #9, '{', '[', '|', '\', ';', #39, '"', #10, '<', '>', '?', ' '];
var
  i : integer;
begin
  i := 1;

  while (i <= length(aParameter)) do
    begin
      if CharInSet(aParameter[i], RESERVEDCHARS) then
        Result := Result + '\' + aParameter[i]
       else
        Result := Result + aParameter[i];

      inc(i);
    end;
end;

end.
