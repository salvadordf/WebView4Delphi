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

  /// <summary>
  /// Specifies the key event type that triggered an AcceleratorKeyPressed
  /// event.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_KEY_EVENT_KIND type.</para>
  /// </remarks>
  TWVKeyEventKind                         = type COREWEBVIEW2_KEY_EVENT_KIND;
  /// <summary>
  /// Specifies the reason for moving focus.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_MOVE_FOCUS_REASON type.</para>
  /// </remarks>
  TWVMoveFocusReason                      = type COREWEBVIEW2_MOVE_FOCUS_REASON;
  /// <summary>
  /// Indicates the error status values for web navigations.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_WEB_ERROR_STATUS type.</para>
  /// </remarks>
  TWVWebErrorStatus                       = type COREWEBVIEW2_WEB_ERROR_STATUS;
  /// <summary>
  /// Specifies the JavaScript dialog type used in the
  /// ICoreWebView2ScriptDialogOpeningEventHandler interface.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_SCRIPT_DIALOG_KIND type.</para>
  /// </remarks>
  TWVScriptDialogKind                     = type COREWEBVIEW2_SCRIPT_DIALOG_KIND;
  /// <summary>
  /// Specifies the response to a permission request.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PERMISSION_STATE type.</para>
  /// </remarks>
  TWVPermissionState                      = type COREWEBVIEW2_PERMISSION_STATE;
  /// <summary>
  /// Indicates the type of a permission request.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PERMISSION_KIND type.</para>
  /// </remarks>
  TWVPermissionKind                       = type COREWEBVIEW2_PERMISSION_KIND;
  /// <summary>
  /// Specifies the process failure type used in the
  /// `ICoreWebView2ProcessFailedEventArgs` interface. The values in this enum
  /// make reference to the process kinds in the Chromium architecture. For more
  /// information about what these processes are and what they do, see
  /// [Browser Architecture - Inside look at modern web browser](https://developers.google.com/web/updates/2018/09/inside-browser-part1).
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PROCESS_FAILED_KIND type.</para>
  /// </remarks>
  TWVProcessFailedKind                    = type COREWEBVIEW2_PROCESS_FAILED_KIND;
  /// <summary>
  /// Specifies the image format for the ICoreWebView2.CapturePreview method.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT type.</para>
  /// </remarks>
  TWVCapturePreviewImageFormat            = type COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT;
  /// <summary>
  /// Specifies the web resource request contexts.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_WEB_RESOURCE_CONTEXT type.</para>
  /// </remarks>
  TWVWebResourceContext                   = type COREWEBVIEW2_WEB_RESOURCE_CONTEXT;
  /// <summary>
  /// Kind of cookie SameSite status used in the ICoreWebView2Cookie interface.
  /// These fields match those as specified in https://developer.mozilla.org/docs/Web/HTTP/Cookies#.
  /// Learn more about SameSite cookies here: https://tools.ietf.org/html/draft-west-first-party-cookies-07
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_COOKIE_SAME_SITE_KIND type.</para>
  /// </remarks>
  TWVCookieSameSiteKind                   = type COREWEBVIEW2_COOKIE_SAME_SITE_KIND;
  /// <summary>
  /// Kind of cross origin resource access allowed for host resources during download.
  /// Note that other normal access checks like same origin DOM access check and [Content
  /// Security Policy](https://developer.mozilla.org/docs/Web/HTTP/CSP) still apply.
  /// The following table illustrates the host resource cross origin access according to
  /// access context and COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND.
  ///
  /// Cross Origin Access Context | DENY | ALLOW | DENY_CORS
  /// --- | --- | --- | ---
  /// From DOM like src of img, script or iframe element| Deny | Allow | Allow
  /// From Script like Fetch or XMLHttpRequest| Deny | Allow | Deny
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND type.</para>
  /// </remarks>
  TWVHostResourceAcccessKind              = type COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND;
  /// <summary>
  /// State of the download operation.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_DOWNLOAD_STATE type.</para>
  /// </remarks>
  TWVDownloadState                        = type COREWEBVIEW2_DOWNLOAD_STATE;
  /// <summary>
  /// Reason why a download was interrupted.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON type.</para>
  /// </remarks>
  TWVDownloadInterruptReason              = type COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON;
  /// <summary>
  /// Specifies the client certificate kind.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_CLIENT_CERTIFICATE_KIND type.</para>
  /// </remarks>
  TWVClientCertificateKind                = type COREWEBVIEW2_CLIENT_CERTIFICATE_KIND;
  /// <summary>
  /// Specifies the browser process exit type used in the
  /// ICoreWebView2BrowserProcessExitedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND type.</para>
  /// </remarks>
  TWVBrowserProcessExitKind               = type COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND;
  /// <summary>
  /// Mouse event type used by SendMouseInput to convey the type of mouse event
  /// being sent to WebView. The values of this enum align with the matching
  /// WM_* window messages.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_MOUSE_EVENT_KIND type.</para>
  /// </remarks>
  TWVMouseEventKind                       = type COREWEBVIEW2_MOUSE_EVENT_KIND;
  /// <summary>
  /// Mouse event virtual keys associated with a COREWEBVIEW2_MOUSE_EVENT_KIND for
  /// SendMouseInput. These values can be combined into a bit flag if more than
  /// one virtual key is pressed for the event. The values of this enum align
  /// with the matching MK_* mouse keys.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS type.</para>
  /// </remarks>
  TWVMouseEventVirtualKeys                = type COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS;
  /// <summary>
  /// Pointer event type used by SendPointerInput to convey the type of pointer
  /// event being sent to WebView. The values of this enum align with the
  /// matching WM_POINTER* window messages.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_POINTER_EVENT_KIND type.</para>
  /// </remarks>
  TWVPointerEventKind                     = type COREWEBVIEW2_POINTER_EVENT_KIND;
  /// <summary>
  /// Mode for how the Bounds property is interpreted in relation to the RasterizationScale property.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_BOUNDS_MODE type.</para>
  /// </remarks>
  TWVBoundsMode                           = type COREWEBVIEW2_BOUNDS_MODE;
  /// <summary>
  /// Specifies the process failure reason used in the
  /// ICoreWebView2ProcessFailedEventHandler interface.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PROCESS_FAILED_REASON type.</para>
  /// </remarks>
  TWVProcessFailedReason                  = type COREWEBVIEW2_PROCESS_FAILED_REASON;
  /// <summary>
  /// The orientation for printing, used by the Orientation property on
  /// ICoreWebView2PrintSettings.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PRINT_ORIENTATION type.</para>
  /// </remarks>
  TWVPrintOrientation                     = type COREWEBVIEW2_PRINT_ORIENTATION;
  /// <summary>
  /// A value representing RGBA color (Red, Green, Blue, Alpha) for WebView2.
  /// Each component takes a value from 0 to 255, with 0 being no intensity and 255 being the highest intensity.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_COLOR type.</para>
  /// </remarks>
  TWVColor                                = type COREWEBVIEW2_COLOR;
  /// <summary>
  /// The default download dialog can be aligned to any of the WebView corners
  /// by setting the DefaultDownloadDialogCornerAlignment property. The default
  /// position is top-right corner.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT type.</para>
  /// </remarks>
  TWVDefaultDownloadDialogCornerAlignment = type COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT;
  /// <summary>
  /// Indicates the process type used in the ICoreWebView2ProcessInfo interface.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PROCESS_KIND type.</para>
  /// </remarks>
  TWVProcessKind                          = type COREWEBVIEW2_PROCESS_KIND;
  /// <summary>
  /// Specifies the menu item kind
  /// for the ICoreWebView2ContextMenuItem.get_Kind method
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND type.</para>
  /// </remarks>
  TWVMenuItemKind                         = type COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND;
  /// <summary>
  /// Indicates the kind of context for which the context menu was created
  /// for the `ICoreWebView2ContextMenuTarget::get_Kind` method.
  /// This enum will always represent the active element that caused the context menu request.
  /// If there is a selection with multiple images, audio and text, for example, the element that
  /// the end user right clicks on within this selection will be the option represented by this enum.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND type.</para>
  /// </remarks>
  TWVMenuTargetKind                       = type COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND;
  /// <summary>
  /// PDF toolbar item. This enum must be in sync with ToolBarItem in pdf-store-data-types.ts
  /// Specifies the PDF toolbar item types used for the ICoreWebView2Settings.put_HiddenPdfToolbarItems method.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PDF_TOOLBAR_ITEMS type.</para>
  /// </remarks>
  TWVPDFToolbarItems                      = type COREWEBVIEW2_PDF_TOOLBAR_ITEMS;
  /// <summary>
  /// An enum to represent the options for WebView2 color scheme: auto, light, or dark.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PREFERRED_COLOR_SCHEME type.</para>
  /// </remarks>
  TWVPreferredColorScheme                 = type COREWEBVIEW2_PREFERRED_COLOR_SCHEME;
  /// <summary>
  /// Specifies the datatype for the
  /// ICoreWebView2Profile2.ClearBrowsingData method.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_BROWSING_DATA_KINDS type.</para>
  /// </remarks>
  TWVBrowsingDataKinds                    = type COREWEBVIEW2_BROWSING_DATA_KINDS;
  /// <summary>
  /// Specifies the action type when server certificate error is detected to be
  /// used in the ICoreWebView2ServerCertificateErrorDetectedEventArgs
  /// interface.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION type.</para>
  /// </remarks>
  TWVServerCertificateErrorAction         = type COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION;
  /// <summary>
  /// Specifies the image format to use for favicon.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_FAVICON_IMAGE_FORMAT type.</para>
  /// </remarks>
  TWVFaviconImageFormat                   = type COREWEBVIEW2_FAVICON_IMAGE_FORMAT;
  /// <summary>
  /// Specifies the collation for a print.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PRINT_COLLATION type.</para>
  /// </remarks>
  TWVPrintCollation                       = type COREWEBVIEW2_PRINT_COLLATION;
  /// <summary>
  /// Specifies the color mode for a print.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PRINT_COLOR_MODE type.</para>
  /// </remarks>
  TWVPrintColorMode                       = type COREWEBVIEW2_PRINT_COLOR_MODE;
  /// <summary>
  /// Specifies the duplex option for a print.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PRINT_DUPLEX type.</para>
  /// </remarks>
  TWVPrintDuplex                          = type COREWEBVIEW2_PRINT_DUPLEX;
  /// <summary>
  /// Specifies the media size for a print.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PRINT_MEDIA_SIZE type.</para>
  /// </remarks>
  TWVPrintMediaSize                       = type COREWEBVIEW2_PRINT_MEDIA_SIZE;
  /// <summary>
  /// Indicates the status for printing.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PRINT_STATUS type.</para>
  /// </remarks>
  TWVPrintStatus                          = type COREWEBVIEW2_PRINT_STATUS;
  /// <summary>
  /// Specifies the print dialog kind.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_PRINT_DIALOG_KIND type.</para>
  /// </remarks>
  TWVPrintDialogKind                      = type COREWEBVIEW2_PRINT_DIALOG_KIND;
  /// <summary>
  /// Specifies the desired access from script to CoreWebView2SharedBuffer.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_SHARED_BUFFER_ACCESS type.</para>
  /// </remarks>
  TWVSharedBufferAccess                   = type COREWEBVIEW2_SHARED_BUFFER_ACCESS;
  /// <summary>
  /// Tracking prevention levels.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_TRACKING_PREVENTION_LEVEL type.</para>
  /// </remarks>
  TWVTrackingPreventionLevel              = type COREWEBVIEW2_TRACKING_PREVENTION_LEVEL;
  /// <summary>
  /// Specifies memory usage target level of WebView.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL type.</para>
  /// </remarks>
  TWVMemoryUsageTargetLevel               = type COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL;
  /// <summary>
  /// Specifies the navigation kind of each navigation.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_NAVIGATION_KIND type.</para>
  /// </remarks>
  TWVNavigationKind                       = type COREWEBVIEW2_NAVIGATION_KIND;
  /// <summary>
  /// Indicates the frame type used in the `ICoreWebView2FrameInfo` interface.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_FRAME_KIND type.</para>
  /// </remarks>
  TWVFrameKind                            = type COREWEBVIEW2_FRAME_KIND;
  /// <summary>
  /// Specifies the source of `WebResourceRequested` event.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS type.</para>
  /// </remarks>
  TWVWebResourceRequestSourceKind         = type COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS;
  /// <summary>
  /// This enum contains values representing possible regions a given
  /// point lies within. The values of this enum align with the
  /// matching WM_NCHITTEST* window message return values.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_NON_CLIENT_REGION_KIND type.</para>
  /// </remarks>
  TWVNonClientRegionKind                  = type COREWEBVIEW2_NON_CLIENT_REGION_KIND;
  /// <summary>
  /// The channel search kind determines the order that release channels are
  /// searched for during environment creation. The default behavior is to search
  /// for and use the most stable channel found on the device. The order from most
  /// to least stable is: WebView2 Runtime -> Beta -> Dev -> Canary. Switch the
  /// order to prefer the least stable channel in order to perform pre-release
  /// testing. See `COREWEBVIEW2_RELEASE_CHANNELS` for descriptions of channels.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_CHANNEL_SEARCH_KIND type.</para>
  /// </remarks>
  TWVChannelSearchKind                    = type COREWEBVIEW2_CHANNEL_SEARCH_KIND;
  /// <summary>
  /// <para>The WebView2 release channels. Use `ReleaseChannels` and `ChannelSearchKind`
  /// on `ICoreWebView2EnvironmentOptions` to control which channel is searched
  /// for during environment creation.</para>
  /// <code>
  /// |Channel|Primary purpose|How often updated with new features|
  /// |:---:|---|:---:|
  /// |Stable (WebView2 Runtime)|Broad Deployment|Monthly|
  /// |Beta|Flighting with inner rings, automated testing|Monthly|
  /// |Dev|Automated testing, selfhosting to test new APIs and features|Weekly|
  /// |Canary|Automated testing, selfhosting to test new APIs and features|Daily|
  /// </code>
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_RELEASE_CHANNELS type.</para>
  /// </remarks>
  TWVReleaseChannels                      = type COREWEBVIEW2_RELEASE_CHANNELS;
  /// <summary>
  /// Set ScrollBar style on `ICoreWebView2EnvironmentOptions` during environment creation.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_SCROLLBAR_STYLE type.</para>
  /// </remarks>
  TWVScrollBarStyle                       = type COREWEBVIEW2_SCROLLBAR_STYLE;
  /// <summary>
  /// Allowed permissions of a CoreWebView2FileSystemHandle as described in
  /// [FileSystemHandle.requestPermission()](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/requestPermission)
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION type.</para>
  /// </remarks>
  TWVFileSystemHandlePermission           = type COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION;
  /// <summary>
  /// Kind of CoreWebView2FileSystemHandle as described in
  /// [FileSystemHandle.kind](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/kind)
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND type.</para>
  /// </remarks>
  TWVFileSystemHandleKind                 = type COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND;
  /// <summary>
  /// Indicates the text direction of the notification.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_TEXT_DIRECTION_KIND type.</para>
  /// </remarks>
  TWVTextDirectionKind                    = type COREWEBVIEW2_TEXT_DIRECTION_KIND;
  /// <summary>
  /// Specifies Save As kind selection options for
  /// `ICoreWebView2SaveAsUIShowingEventArgs`.
  ///
  /// For HTML documents, we support 3 Save As kinds: HTML_ONLY, SINGLE_FILE and
  /// COMPLETE. For non-HTML documents, you must use DEFAULT. MIME types of `text/html` and
  /// `application/xhtml+xml` are considered HTML documents.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_SAVE_AS_KIND type.</para>
  /// </remarks>
  TWVSaveAsKind                           = type COREWEBVIEW2_SAVE_AS_KIND;
  /// <summary>
  /// Status of a programmatic Save As call. Indicates the result
  /// of the `ShowSaveAsUI` method.
  /// </summary>
  /// <remarks>
  /// <para>Renamed COREWEBVIEW2_SAVE_AS_UI_RESULT type.</para>
  /// </remarks>
  TWVSaveAsUIResult                       = type COREWEBVIEW2_SAVE_AS_UI_RESULT;

  /// <summary>
  /// TWVLoader status values
  /// </summary>
  TWV2LoaderStatus = (wvlsCreated,
                      wvlsLoading,
                      wvlsLoaded,
                      wvlsImported,
                      wvlsInitialized,
                      wvlsError,
                      wvlsUnloaded);
  /// <summary>
  /// Event type used by TWVBrowserBase.SimulateKeyEvent
  /// </summary>
  TWV2KeyEventType = (ketKeyDown,
                      ketKeyUp,
                      ketRawKeyDown,
                      ketChar);

  /// <summary>
  /// Debug log values used by TWVLoader.DebugLog
  /// </summary>
  TWV2DebugLog = (dlDisabled,
                  dlEnabled,
                  dlEnabledStdOut,
                  dlEnabledStdErr);

  /// <summary>
  /// Debug log level used when the logging is enabled
  /// </summary>
  TWV2DebugLogLevel = (dllDefault,
                       dllInfo,
                       dllWarning,
                       dllError,
                       dllFatal);

  /// <summary>
  /// Blink editing commands used by the "Input.dispatchKeyEvent" DevTools method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://chromedevtools.github.io/devtools-protocol/1-3/Input/#method-dispatchKeyEvent">See the "Input.dispatchKeyEvent" DevTools method.</see></para>
  /// <para><see href="https://source.chromium.org/chromium/chromium/src/+/master:third_party/blink/renderer/core/editing/commands/editor_command_names.h">See the Chromium sources.</see></para>
  /// </remarks>
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

  /// <summary>
  /// Record used by GetDLLVersion to get the DLL version information
  /// </summary>
  TFileVersionInfo = record
    MajorVer : word;
    MinorVer : word;
    Release  : word;
    Build    : word;
  end;

  /// <summary>
  /// Record used by TCoreWebView2WindowFeatures.CopyToRecord to copy the windows featres
  /// </summary>
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

  /// <summary>
  /// Used by TWVBrowserBase.ClearDataForOrigin to clear the storage
  /// </summary>
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

  /// <summary>
  /// Represents the state of a setting.
  /// </summary>
  TWVState = (
    /// <summary>
    /// Use the default state for the setting.
    /// </summary>
    STATE_DEFAULT = 0,
    /// <summary>
    /// Enable or allow the setting.
    /// </summary>
    STATE_ENABLED,
    /// <summary>
    /// Disable or disallow the setting.
    /// </summary>
    STATE_DISABLED
  );

  /// <summary>
  /// Autoplay policy types used by TWVLoader.AutoplayPolicy. See the --autoplay-policy switch.
  /// </summary>
  TWVAutoplayPolicy = (appDefault,
                       appDocumentUserActivationRequired,
                       appNoUserGestureRequired,
                       appUserGestureRequired);

  /// <summary>
  /// Record with all the information to create a TCoreWebView2CustomSchemeRegistration instance to register a custom scheme.
  /// </summary>
  TWVCustomSchemeInfo = record
    /// <summary>
    /// The name of the custom scheme to register.
    /// </summary>
    SchemeName            : wvstring;
    /// <summary>
    /// Whether the sites with this scheme will be treated as a Secure Context like an HTTPS site.
    /// </summary>
    TreatAsSecure         : boolean;
    /// <summary>
    /// Comma separated list of origins that are allowed to issue requests with the custom scheme, such as XHRs and subresource requests that have an Origin header.
    /// </summary>
    AllowedDomains        : wvstring;
    /// <summary>
    /// Set this property to true if the URIs with this custom scheme will have an authority component (a host for custom schemes).
    /// </summary>
    HasAuthorityComponent : boolean;
  end;
  TWVCustomSchemeInfoArray = array of TWVCustomSchemeInfo;

  TWVCustomSchemeRegistrationArray = array of ICoreWebView2CustomSchemeRegistration;

implementation

end.
