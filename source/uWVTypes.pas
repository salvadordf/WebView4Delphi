unit uWVTypes;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  {$IFDEF FPC}
  Classes,
  {$ELSE}
  System.Classes,
  {$ENDIF}
  uWVTypeLibrary;

type
{$IFDEF FPC}
  wvstring = type UnicodeString;
{$ELSE}
  wvstring = type string;
{$ENDIF}

  TWVKeyEventKind              = type COREWEBVIEW2_KEY_EVENT_KIND;
  TWVMoveFocusReason           = type COREWEBVIEW2_MOVE_FOCUS_REASON;
  TWVWebErrorStatus            = type COREWEBVIEW2_WEB_ERROR_STATUS;
  TWVScriptDialogKind          = type COREWEBVIEW2_SCRIPT_DIALOG_KIND;
  TWVPermissionState           = type COREWEBVIEW2_PERMISSION_STATE;
  TWVPermissionKind            = type COREWEBVIEW2_PERMISSION_KIND;
  TWVProcessFailedKind         = type COREWEBVIEW2_PROCESS_FAILED_KIND;
  TWVCapturePreviewImageFormat = type COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT;
  TWVWebResourceContext        = type COREWEBVIEW2_WEB_RESOURCE_CONTEXT;
  TWVCookieSameSiteKind        = type COREWEBVIEW2_COOKIE_SAME_SITE_KIND;
  TWVHostResourceAcccessKind   = type COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND;
  TWVDownloadState             = type COREWEBVIEW2_DOWNLOAD_STATE;
  TWVDownloadInterruptReason   = type COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON;
  TWVClientCertificateKind     = type COREWEBVIEW2_CLIENT_CERTIFICATE_KIND;
  TWVBrowserProcessExitKind    = type COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND;
  TWVMouseEventKind            = type COREWEBVIEW2_MOUSE_EVENT_KIND;
  TWVMouseEventVirtualKeys     = type COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS;
  TWVPointerEventKind          = type COREWEBVIEW2_POINTER_EVENT_KIND;
  TWVBoundsMode                = type COREWEBVIEW2_BOUNDS_MODE;
  TWVProcessFailedReason       = type COREWEBVIEW2_PROCESS_FAILED_REASON;
  TWVPrintOrientation          = type COREWEBVIEW2_PRINT_ORIENTATION;
  TWVColor                     = type COREWEBVIEW2_COLOR;

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

  TFileVersionInfo = record
    MajorVer : uint16;
    MinorVer : uint16;
    Release  : uint16;
    Build    : uint16;
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

  TWVProxySettings = record
    NoProxyServer : boolean;
    AutoDetect    : boolean;
    ByPassList    : wvstring;
    PacUrl        : wvstring;
    Server        : wvstring;
  end;

implementation

end.
