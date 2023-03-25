unit uWVTypes;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes,
  {$ELSE}
  Classes,
  {$ENDIF}
  uWVTypeLibrary;

type
  {$IFDEF DELPHI12_UP}
  wvstring = type string;
  {$ELSE}
    {$IFDEF FPC}
    wvstring = type UnicodeString;
    {$ELSE}
    wvstring = type WideString;
    {$ENDIF}
  {$ENDIF}

  TWVKeyEventKind                         = type COREWEBVIEW2_KEY_EVENT_KIND;
  TWVMoveFocusReason                      = type COREWEBVIEW2_MOVE_FOCUS_REASON;
  TWVWebErrorStatus                       = type COREWEBVIEW2_WEB_ERROR_STATUS;
  TWVScriptDialogKind                     = type COREWEBVIEW2_SCRIPT_DIALOG_KIND;
  TWVPermissionState                      = type COREWEBVIEW2_PERMISSION_STATE;
  TWVPermissionKind                       = type COREWEBVIEW2_PERMISSION_KIND;
  TWVProcessFailedKind                    = type COREWEBVIEW2_PROCESS_FAILED_KIND;
  TWVCapturePreviewImageFormat            = type COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT;
  TWVWebResourceContext                   = type COREWEBVIEW2_WEB_RESOURCE_CONTEXT;
  TWVCookieSameSiteKind                   = type COREWEBVIEW2_COOKIE_SAME_SITE_KIND;
  TWVHostResourceAcccessKind              = type COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND;
  TWVDownloadState                        = type COREWEBVIEW2_DOWNLOAD_STATE;
  TWVDownloadInterruptReason              = type COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON;
  TWVClientCertificateKind                = type COREWEBVIEW2_CLIENT_CERTIFICATE_KIND;
  TWVBrowserProcessExitKind               = type COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND;
  TWVMouseEventKind                       = type COREWEBVIEW2_MOUSE_EVENT_KIND;
  TWVMouseEventVirtualKeys                = type COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS;
  TWVPointerEventKind                     = type COREWEBVIEW2_POINTER_EVENT_KIND;
  TWVBoundsMode                           = type COREWEBVIEW2_BOUNDS_MODE;
  TWVProcessFailedReason                  = type COREWEBVIEW2_PROCESS_FAILED_REASON;
  TWVPrintOrientation                     = type COREWEBVIEW2_PRINT_ORIENTATION;
  TWVColor                                = type COREWEBVIEW2_COLOR;
  TWVDefaultDownloadDialogCornerAlignment = type COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT;
  TWVProcessKind                          = type COREWEBVIEW2_PROCESS_KIND;
  TWVMenuItemKind                         = type COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND;
  TWVMenuTargetKind                       = type COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND;
  TWVPDFToolbarItems                      = type COREWEBVIEW2_PDF_TOOLBAR_ITEMS;
  TWVPreferredColorScheme                 = type COREWEBVIEW2_PREFERRED_COLOR_SCHEME;
  TWVBrowsingDataKinds                    = type COREWEBVIEW2_BROWSING_DATA_KINDS;
  TWVServerCertificateErrorAction         = type COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION;
  TWVFaviconImageFormat                   = type COREWEBVIEW2_FAVICON_IMAGE_FORMAT;
  TWVPrintCollation                       = type COREWEBVIEW2_PRINT_COLLATION;
  TWVPrintColorMode                       = type COREWEBVIEW2_PRINT_COLOR_MODE;
  TWVPrintDuplex                          = type COREWEBVIEW2_PRINT_DUPLEX;
  TWVPrintMediaSize                       = type COREWEBVIEW2_PRINT_MEDIA_SIZE;
  TWVPrintStatus                          = type COREWEBVIEW2_PRINT_STATUS;
  TWVPrintDialogKind                      = type COREWEBVIEW2_PRINT_DIALOG_KIND;
  TWVSharedBufferAccess                   = type COREWEBVIEW2_SHARED_BUFFER_ACCESS;
  TWVTrackingPreventionLevel              = type COREWEBVIEW2_TRACKING_PREVENTION_LEVEL;

  TWV2LoaderStatus = (wvlsCreated,
                      wvlsLoading,
                      wvlsLoaded,
                      wvlsImported,
                      wvlsInitialized,
                      wvlsError,
                      wvlsUnloaded);

  TWV2KeyEventType = (ketKeyDown,
                      ketKeyUp,
                      ketRawKeyDown,
                      ketChar);

  TWV2DebugLog = (dlDisabled, dlEnabled, dlEnabledStdOut, dlEnabledStdErr);

  // Debug log level used when the logging is enabled
  TWV2DebugLogLevel = (dllDefault,
                       dllInfo,
                       dllWarning,
                       dllError,
                       dllFatal);

  // Blink editing commands used by the "Input.dispatchKeyEvent" DevTools method.
  // https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent
  // https://source.chromium.org/chromium/chromium/src/+/master:third_party/blink/renderer/core/editing/commands/editor_command_names.h
  TWV2EditingCommand = (ecAlignCenter,
                        ecAlignJustified,
                        ecAlignLeft,
                        ecAlignRight,
                        ecBackColor,
                        ecBackwardDelete,
                        ecBold,
                        ecCopy,
                        ecCreateLink,
                        ecCut,
                        ecDefaultParagraphSeparator,
                        ecDelete,
                        ecDeleteBackward,
                        ecDeleteBackwardByDecomposingPreviousCharacter,
                        ecDeleteForward,
                        ecDeleteToBeginningOfLine,
                        ecDeleteToBeginningOfParagraph,
                        ecDeleteToEndOfLine,
                        ecDeleteToEndOfParagraph,
                        ecDeleteToMark,
                        ecDeleteWordBackward,
                        ecDeleteWordForward,
                        ecFindString,
                        ecFontName,
                        ecFontSize,
                        ecFontSizeDelta,
                        ecForeColor,
                        ecFormatBlock,
                        ecForwardDelete,
                        ecHiliteColor,
                        ecIgnoreSpelling,
                        ecIndent,
                        ecInsertBacktab,
                        ecInsertHorizontalRule,
                        ecInsertHTML,
                        ecInsertImage,
                        ecInsertLineBreak,
                        ecInsertNewline,
                        ecInsertNewlineInQuotedContent,
                        ecInsertOrderedList,
                        ecInsertParagraph,
                        ecInsertTab,
                        ecInsertText,
                        ecInsertUnorderedList,
                        ecItalic,
                        ecJustifyCenter,
                        ecJustifyFull,
                        ecJustifyLeft,
                        ecJustifyNone,
                        ecJustifyRight,
                        ecMakeTextWritingDirectionLeftToRight,
                        ecMakeTextWritingDirectionNatural,
                        ecMakeTextWritingDirectionRightToLeft,
                        ecMoveBackward,
                        ecMoveBackwardAndModifySelection,
                        ecMoveDown,
                        ecMoveDownAndModifySelection,
                        ecMoveForward,
                        ecMoveForwardAndModifySelection,
                        ecMoveLeft,
                        ecMoveLeftAndModifySelection,
                        ecMovePageDown,
                        ecMovePageDownAndModifySelection,
                        ecMovePageUp,
                        ecMovePageUpAndModifySelection,
                        ecMoveParagraphBackward,
                        ecMoveParagraphBackwardAndModifySelection,
                        ecMoveParagraphForward,
                        ecMoveParagraphForwardAndModifySelection,
                        ecMoveRight,
                        ecMoveRightAndModifySelection,
                        ecMoveToBeginningOfDocument,
                        ecMoveToBeginningOfDocumentAndModifySelection,
                        ecMoveToBeginningOfLine,
                        ecMoveToBeginningOfLineAndModifySelection,
                        ecMoveToBeginningOfParagraph,
                        ecMoveToBeginningOfParagraphAndModifySelection,
                        ecMoveToBeginningOfSentence,
                        ecMoveToBeginningOfSentenceAndModifySelection,
                        ecMoveToEndOfDocument,
                        ecMoveToEndOfDocumentAndModifySelection,
                        ecMoveToEndOfLine,
                        ecMoveToEndOfLineAndModifySelection,
                        ecMoveToEndOfParagraph,
                        ecMoveToEndOfParagraphAndModifySelection,
                        ecMoveToEndOfSentence,
                        ecMoveToEndOfSentenceAndModifySelection,
                        ecMoveToLeftEndOfLine,
                        ecMoveToLeftEndOfLineAndModifySelection,
                        ecMoveToRightEndOfLine,
                        ecMoveToRightEndOfLineAndModifySelection,
                        ecMoveUp,
                        ecMoveUpAndModifySelection,
                        ecMoveWordBackward,
                        ecMoveWordBackwardAndModifySelection,
                        ecMoveWordForward,
                        ecMoveWordForwardAndModifySelection,
                        ecMoveWordLeft,
                        ecMoveWordLeftAndModifySelection,
                        ecMoveWordRight,
                        ecMoveWordRightAndModifySelection,
                        ecOutdent,
                        ecOverWrite,
                        ecPaste,
                        ecPasteAndMatchStyle,
                        ecPasteGlobalSelection,
                        ecPrint,
                        ecRedo,
                        ecRemoveFormat,
                        ecScrollLineDown,
                        ecScrollLineUp,
                        ecScrollPageBackward,
                        ecScrollPageForward,
                        ecScrollToBeginningOfDocument,
                        ecScrollToEndOfDocument,
                        ecSelectAll,
                        ecSelectLine,
                        ecSelectParagraph,
                        ecSelectSentence,
                        ecSelectToMark,
                        ecSelectWord,
                        ecSetMark,
                        ecStrikethrough,
                        ecStyleWithCSS,
                        ecSubscript,
                        ecSuperscript,
                        ecSwapWithMark,
                        ecToggleBold,
                        ecToggleItalic,
                        ecToggleUnderline,
                        ecTranspose,
                        ecUnderline,
                        ecUndo,
                        ecUnlink,
                        ecUnscript,
                        ecUnselect,
                        ecUseCSS,
                        ecYank,
                        ecYankAndSelect);

  TFileVersionInfo = record
    MajorVer : word;
    MinorVer : word;
    Release  : word;
    Build    : word;
  end;

  TWVWindowFeatures = record
    HasPosition             : boolean;
    HasSize                 : boolean;
    Left                    : cardinal;
    Top                     : cardinal;
    Width                   : cardinal;
    Height                  : cardinal;
    ShouldDisplayMenuBar    : boolean;
    ShouldDisplayStatus     : boolean;
    ShouldDisplayToolbar    : boolean;
    ShouldDisplayScrollBars : boolean;
  end;

  TWVClearDataStorageTypes = (cdstAppCache,
                              cdstCookies,
                              cdstFileSystems,
                              cdstIndexeddb,
                              cdstLocalStorage,
                              cdstShaderCache,
                              cdstWebsql,
                              cdstServiceWorkers,
                              cdstCacheStorage,
                              cdstAll);

  TWVState = (
    STATE_DEFAULT = 0,
    STATE_ENABLED,
    STATE_DISABLED
  );

  TWVAutoplayPolicy = (appDefault,
                       appDocumentUserActivationRequired,
                       appNoUserGestureRequired,
                       appUserGestureRequired);

  TWVCustomSchemeInfo = record
    SchemeName            : wvstring;  // The name of the custom scheme to register.
    TreatAsSecure         : boolean;   // Whether the sites with this scheme will be treated as a Secure Context like an HTTPS site.
    AllowedDomains        : wvstring;  // Comma separated list of origins that are allowed to issue requests with the custom scheme, such as XHRs and subresource requests that have an Origin header.
    HasAuthorityComponent : boolean;   // Set this property to true if the URIs with this custom scheme will have an authority component (a host for custom schemes).
  end;
  TWVCustomSchemeInfoArray = array of TWVCustomSchemeInfo;

  TWVCustomSchemeRegistrationArray = array of ICoreWebView2CustomSchemeRegistration;

implementation

end.
