unit uWVCoreWebView2Args;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Types, Winapi.ActiveX,
  {$ELSE}
  Types, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2AcceleratorKeyPressedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2AcceleratorKeyPressedEventArgs;

      function GetInitialized : boolean;
      function GetKeyEventKind : TWVKeyEventKind;
      function GetVirtualKey : LongWord;
      function GetKeyEventLParam : integer;
      function GetHandled : boolean;
      function GetRepeatCount : LongWord;
      function GetScanCode : LongWord;
      function GetIsExtendedKey : boolean;
      function GetIsMenuKeyDown : boolean;
      function GetWasKeyDown : boolean;
      function GetIsKeyReleased : boolean;

      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized    : boolean                                      read GetInitialized;
      property BaseIntf       : ICoreWebView2AcceleratorKeyPressedEventArgs  read FBaseIntf;
      property KeyEventKind   : TWVKeyEventKind                              read GetKeyEventKind;
      property VirtualKey     : LongWord                                     read GetVirtualKey;
      property KeyEventLParam : integer                                      read GetKeyEventLParam;
      property RepeatCount    : LongWord                                     read GetRepeatCount;
      property ScanCode       : LongWord                                     read GetScanCode;
      property IsExtendedKey  : boolean                                      read GetIsExtendedKey;
      property IsMenuKeyDown  : boolean                                      read GetIsMenuKeyDown;
      property WasKeyDown     : boolean                                      read GetWasKeyDown;
      property IsKeyReleased  : boolean                                      read GetIsKeyReleased;
      property Handled        : boolean                                      read GetHandled          write SetHandled;
  end;

  TCoreWebView2ContentLoadingEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ContentLoadingEventArgs;

      function GetInitialized : boolean;
      function GetIsErrorPage : boolean;
      function GetNavigationId : uint64;

    public
      constructor Create(const aArgs: ICoreWebView2ContentLoadingEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized  : boolean                               read GetInitialized;
      property BaseIntf     : ICoreWebView2ContentLoadingEventArgs  read FBaseIntf;
      property IsErrorPage  : boolean                               read GetIsErrorPage;
      property NavigationId : uint64                                read GetNavigationId;
  end;

  TCoreWebView2DevToolsProtocolEventReceivedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2DevToolsProtocolEventReceivedEventArgs;
      FBaseIntf2 : ICoreWebView2DevToolsProtocolEventReceivedEventArgs2;

      function GetInitialized : boolean;
      function GetParameterObjectAsJson : wvstring;
      function GetSessionId : wvstring;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2DevToolsProtocolEventReceivedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized           : boolean                                              read GetInitialized;
      property BaseIntf              : ICoreWebView2DevToolsProtocolEventReceivedEventArgs  read FBaseIntf;
      property ParameterObjectAsJson : wvstring                                             read GetParameterObjectAsJson;
      property SessionId             : wvstring                                             read GetSessionId;
  end;

  TCoreWebView2MoveFocusRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2MoveFocusRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetReason : TWVMoveFocusReason;
      function  GetHandled : boolean;

      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2MoveFocusRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized : boolean                                   read GetInitialized;
      property BaseIntf    : ICoreWebView2MoveFocusRequestedEventArgs  read FBaseIntf;
      property Reason      : TWVMoveFocusReason                        read GetReason;
      property Handled     : boolean                                   read GetHandled      write SetHandled;
  end;

  TCoreWebView2NavigationCompletedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2NavigationCompletedEventArgs;
      FBaseIntf2 : ICoreWebView2NavigationCompletedEventArgs2;

      function GetInitialized : boolean;
      function GetIsSuccess : boolean;
      function GetWebErrorStatus : TWVWebErrorStatus;
      function GetNavigationID : uint64;
      function GetHttpStatusCode : integer;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2NavigationCompletedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized    : boolean                                    read GetInitialized;
      property BaseIntf       : ICoreWebView2NavigationCompletedEventArgs  read FBaseIntf;
      property IsSuccess      : boolean                                    read GetIsSuccess;
      property WebErrorStatus : TWVWebErrorStatus                          read GetWebErrorStatus;
      property NavigationID   : uint64                                     read GetNavigationID;
      property HttpStatusCode : integer                                    read GetHttpStatusCode;
  end;

  TCoreWebView2NavigationStartingEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2NavigationStartingEventArgs;
      FBaseIntf2 : ICoreWebView2NavigationStartingEventArgs2;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetIsUserInitiated : boolean;
      function  GetIsRedirected : boolean;
      function  GetCancel : boolean;
      function  GetNavigationID : uint64;
      function  GetRequestHeaders : ICoreWebView2HttpRequestHeaders;
      function  GetAdditionalAllowedFrameAncestors : wvstring;

      procedure SetAdditionalAllowedFrameAncestors(const aValue : wvstring);
      procedure SetCancel(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2NavigationStartingEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized                       : boolean                                   read GetInitialized;
      property BaseIntf                          : ICoreWebView2NavigationStartingEventArgs  read FBaseIntf;
      property URI                               : wvstring                                  read GetURI;
      property IsUserInitiated                   : boolean                                   read GetIsUserInitiated;
      property IsRedirected                      : boolean                                   read GetIsRedirected;
      property Cancel                            : boolean                                   read GetCancel                              write SetCancel;
      property NavigationID                      : uint64                                    read GetNavigationID;
      property RequestHeaders                    : ICoreWebView2HttpRequestHeaders           read GetRequestHeaders;
      property AdditionalAllowedFrameAncestors   : wvstring                                  read GetAdditionalAllowedFrameAncestors     write SetAdditionalAllowedFrameAncestors;
  end;

  TCoreWebView2NewWindowRequestedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2NewWindowRequestedEventArgs;
      FBaseIntf2 : ICoreWebView2NewWindowRequestedEventArgs2;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetNewWindow : ICoreWebView2;
      function  GetHandled : boolean;
      function  GetIsUserInitiated : boolean;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetWindowFeatures : ICoreWebView2WindowFeatures;
      function  GetName : wvstring;

      procedure SetNewWindow(const aValue : ICoreWebView2);
      procedure SetHandled(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2NewWindowRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized      : boolean                                   read GetInitialized;
      property BaseIntf         : ICoreWebView2NewWindowRequestedEventArgs  read FBaseIntf;
      property URI              : wvstring                                  read GetURI;
      property NewWindow        : ICoreWebView2                             read GetNewWindow         write SetNewWindow;
      property Handled          : boolean                                   read GetHandled           write SetHandled;
      property IsUserInitiated  : boolean                                   read GetIsUserInitiated;
      property Deferral         : ICoreWebView2Deferral                     read GetDeferral;
      property WindowFeatures   : ICoreWebView2WindowFeatures               read GetWindowFeatures;
      property Name             : wvstring                                  read GetName;
  end;

  TCoreWebView2PermissionRequestedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2PermissionRequestedEventArgs;
      FBaseIntf2 : ICoreWebView2PermissionRequestedEventArgs2;
      FBaseIntf3 : ICoreWebView2PermissionRequestedEventArgs3;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetPermissionKind : TWVPermissionKind;
      function  GetIsUserInitiated : boolean;
      function  GetState : TWVPermissionState;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetHandled : boolean;
      function  GetSavesInProfile : boolean;

      procedure SetState(aValue : TWVPermissionState);
      procedure SetHandled(aValue : boolean);
      procedure SetSavesInProfile(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs); reintroduce; overload;
      constructor Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs2); reintroduce; overload;
      destructor  Destroy; override;

      property Initialized      : boolean                                    read GetInitialized;
      property BaseIntf         : ICoreWebView2PermissionRequestedEventArgs  read FBaseIntf;
      property URI              : wvstring                                   read GetURI;
      property State            : TWVPermissionState                         read GetState             write SetState;
      property PermissionKind   : TWVPermissionKind                          read GetPermissionKind;
      property IsUserInitiated  : boolean                                    read GetIsUserInitiated;
      property Deferral         : ICoreWebView2Deferral                      read GetDeferral;
      property Handled          : boolean                                    read GetHandled           write SetHandled;
      property SavesInProfile   : boolean                                    read GetSavesInProfile    write SetSavesInProfile;
  end;

  TCoreWebView2ProcessFailedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2ProcessFailedEventArgs;
      FBaseIntf2 : ICoreWebView2ProcessFailedEventArgs2;

      function GetInitialized : boolean;
      function GetProcessFailedKind : TWVProcessFailedKind;
      function GetReason : TWVProcessFailedReason;
      function GetExtiCode : integer;
      function GetProcessDescription : wvstring;
      function GetFrameInfosForFailedProcess : ICoreWebView2FrameInfoCollection;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2ProcessFailedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized                : boolean                              read GetInitialized;
      property BaseIntf                   : ICoreWebView2ProcessFailedEventArgs  read FBaseIntf;
      property ProcessFailedKind          : TWVProcessFailedKind                 read GetProcessFailedKind;
      property Reason                     : TWVProcessFailedReason               read GetReason;
      property ExtiCode                   : integer                              read GetExtiCode;
      property ProcessDescription         : wvstring                             read GetProcessDescription;
      property FrameInfosForFailedProcess : ICoreWebView2FrameInfoCollection     read GetFrameInfosForFailedProcess;
  end;

  TCoreWebView2ScriptDialogOpeningEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ScriptDialogOpeningEventArgs;

      function  GetInitialized : boolean;
      function  GetURI : wvstring;
      function  GetKind : TWVScriptDialogKind;
      function  GetMessage : wvstring;
      function  GetDefaultText : wvstring;
      function  GetResultText : wvstring;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetResultText(const aValue : wvstring);

    public
      constructor Create(const aArgs: ICoreWebView2ScriptDialogOpeningEventArgs); reintroduce;
      destructor  Destroy; override;
      function    Accept : boolean;

      property Initialized : boolean                                    read GetInitialized;
      property BaseIntf    : ICoreWebView2ScriptDialogOpeningEventArgs  read FBaseIntf;
      property URI         : wvstring                                   read GetURI;
      property Kind        : TWVScriptDialogKind                        read GetKind;
      property Message_    : wvstring                                   read GetMessage;
      property DefaultText : wvstring                                   read GetDefaultText;
      property ResultText  : wvstring                                   read GetResultText     write SetResultText;
      property Deferral    : ICoreWebView2Deferral                      read GetDeferral;
  end;

  TCoreWebView2SourceChangedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2SourceChangedEventArgs;

      function GetInitialized : boolean;
      function GetIsNewDocument : boolean;

    public
      constructor Create(const aArgs: ICoreWebView2SourceChangedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized   : boolean                              read GetInitialized;
      property BaseIntf      : ICoreWebView2SourceChangedEventArgs  read FBaseIntf;
      property IsNewDocument : boolean                              read GetIsNewDocument;
  end;

  TCoreWebView2WebMessageReceivedEventArgs = class
    protected
      FBaseIntf  : ICoreWebView2WebMessageReceivedEventArgs;
      FBaseIntf2 : ICoreWebView2WebMessageReceivedEventArgs2;

      function GetInitialized : boolean;
      function GetSource : wvstring;
      function GetWebMessageAsJson : wvstring;
      function GetWebMessageAsString : wvstring;
      function GetAdditionalObjects : ICoreWebView2ObjectCollectionView;

      procedure InitializeFields;

    public
      constructor Create(const aArgs: ICoreWebView2WebMessageReceivedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized        : boolean                                   read GetInitialized;
      property BaseIntf           : ICoreWebView2WebMessageReceivedEventArgs  read FBaseIntf;
      property Source             : wvstring                                  read GetSource;
      property WebMessageAsJson   : wvstring                                  read GetWebMessageAsJson;
      property WebMessageAsString : wvstring                                  read GetWebMessageAsString;
      property AdditionalObjects  : ICoreWebView2ObjectCollectionView         read GetAdditionalObjects;
  end;

  TCoreWebView2WebResourceRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2WebResourceRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetRequest : ICoreWebView2WebResourceRequest;
      function  GetResponse : ICoreWebView2WebResourceResponse;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetResourceContext : TWVWebResourceContext;

      procedure SetResponse(const aValue : ICoreWebView2WebResourceResponse);

    public
      constructor Create(const aArgs: ICoreWebView2WebResourceRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized     : boolean                                     read GetInitialized;
      property BaseIntf        : ICoreWebView2WebResourceRequestedEventArgs  read FBaseIntf;
      property Request         : ICoreWebView2WebResourceRequest             read GetRequest;
      property Response        : ICoreWebView2WebResourceResponse            read GetResponse         write SetResponse;
      property Deferral        : ICoreWebView2Deferral                       read GetDeferral;
      property ResourceContext : TWVWebResourceContext                       read GetResourceContext;
  end;

  TCoreWebView2BrowserProcessExitedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2BrowserProcessExitedEventArgs;

      function  GetInitialized : boolean;
      function  GetBrowserProcessExitKind : TWVBrowserProcessExitKind;
      function  GetBrowserProcessId : cardinal;

    public
      constructor Create(const aArgs: ICoreWebView2BrowserProcessExitedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized            : boolean                                     read GetInitialized;
      property BaseIntf               : ICoreWebView2BrowserProcessExitedEventArgs  read FBaseIntf;
      property BrowserProcessExitKind : TWVBrowserProcessExitKind                   read GetBrowserProcessExitKind;
      property BrowserProcessId       : cardinal                                    read GetBrowserProcessId;
  end;

  TCoreWebView2WebResourceResponseReceivedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2WebResourceResponseReceivedEventArgs;

      function  GetInitialized : boolean;
      function  GetRequest : ICoreWebView2WebResourceRequest;
      function  GetResponse : ICoreWebView2WebResourceResponseView;

    public
      constructor Create(const aArgs: ICoreWebView2WebResourceResponseReceivedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized : boolean                                            read GetInitialized;
      property BaseIntf    : ICoreWebView2WebResourceResponseReceivedEventArgs  read FBaseIntf;
      property Request     : ICoreWebView2WebResourceRequest                    read GetRequest;
      property Response    : ICoreWebView2WebResourceResponseView               read GetResponse;
  end;

  TCoreWebView2DOMContentLoadedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2DOMContentLoadedEventArgs;

      function  GetInitialized : boolean;
      function  GetNavigationId : uint64;

    public
      constructor Create(const aArgs: ICoreWebView2DOMContentLoadedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized  : boolean                                 read GetInitialized;
      property BaseIntf     : ICoreWebView2DOMContentLoadedEventArgs  read FBaseIntf;
      property NavigationId : uint64                                  read GetNavigationId;
  end;

  TCoreWebView2FrameCreatedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2FrameCreatedEventArgs;

      function  GetInitialized : boolean;
      function  GetFrame : ICoreWebView2Frame;

    public
      constructor Create(const aArgs: ICoreWebView2FrameCreatedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized  : boolean                             read GetInitialized;
      property BaseIntf     : ICoreWebView2FrameCreatedEventArgs  read FBaseIntf;
      property Frame        : ICoreWebView2Frame                  read GetFrame;
  end;

  TCoreWebView2DownloadStartingEventArgs = class
    protected
      FBaseIntf : ICoreWebView2DownloadStartingEventArgs;

      function  GetInitialized : boolean;
      function  GetDownloadOperation : ICoreWebView2DownloadOperation;
      function  GetCancel : boolean;
      function  GetResultFilePath : wvstring;
      function  GetHandled : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetCancel(aValue : boolean);
      procedure SetResultFilePath(const aValue : wvstring);
      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2DownloadStartingEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized        : boolean                                 read GetInitialized;
      property BaseIntf           : ICoreWebView2DownloadStartingEventArgs  read FBaseIntf;
      property DownloadOperation  : ICoreWebView2DownloadOperation          read GetDownloadOperation;
      property Cancel             : boolean                                 read GetCancel              write SetCancel;
      property ResultFilePath     : wvstring                                read GetResultFilePath      write SetResultFilePath;
      property Handled            : boolean                                 read GetHandled             write SetHandled;
      property Deferral           : ICoreWebView2Deferral                   read GetDeferral;
  end;

  TCoreWebView2ClientCertificateRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ClientCertificateRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetHost : wvstring;
      function  GetIsProxy : boolean;
      function  GetAllowedCertificateAuthorities : ICoreWebView2StringCollection;
      function  GetMutuallyTrustedCertificates : ICoreWebView2ClientCertificateCollection;
      function  GetSelectedCertificate : ICoreWebView2ClientCertificate;
      function  GetCancel : boolean;
      function  GetHandled : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetSelectedCertificate(const aValue : ICoreWebView2ClientCertificate);
      procedure SetCancel(aValue : boolean);
      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2ClientCertificateRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized                   : boolean                                           read GetInitialized;
      property BaseIntf                      : ICoreWebView2ClientCertificateRequestedEventArgs  read FBaseIntf;
      property Host                          : wvstring                                          read GetHost;
      property IsProxy                       : boolean                                           read GetIsProxy;
      property AllowedCertificateAuthorities : ICoreWebView2StringCollection                     read GetAllowedCertificateAuthorities;
      property MutuallyTrustedCertificates   : ICoreWebView2ClientCertificateCollection          read GetMutuallyTrustedCertificates;
      property SelectedCertificate           : ICoreWebView2ClientCertificate                    read GetSelectedCertificate             write SetSelectedCertificate;
      property Cancel                        : boolean                                           read GetCancel                          write SetCancel;
      property Handled                       : boolean                                           read GetHandled                         write SetHandled;
      property Deferral                      : ICoreWebView2Deferral                             read GetDeferral;
  end;

  TCoreWebView2BasicAuthenticationRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2BasicAuthenticationRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetUri : wvstring;
      function  GetChallenge : wvstring;
      function  GetResponse : ICoreWebView2BasicAuthenticationResponse;
      function  GetCancel : boolean;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetCancel(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2BasicAuthenticationRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized                   : boolean                                             read GetInitialized;
      property BaseIntf                      : ICoreWebView2BasicAuthenticationRequestedEventArgs  read FBaseIntf;
      property Uri                           : wvstring                                            read GetUri;
      property Challenge                     : wvstring                                            read GetChallenge;
      property Response                      : ICoreWebView2BasicAuthenticationResponse            read GetResponse;
      property Cancel                        : boolean                                             read GetCancel           write SetCancel;
      property Deferral                      : ICoreWebView2Deferral                               read GetDeferral;
  end;

  TCoreWebView2ContextMenuRequestedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ContextMenuRequestedEventArgs;

      function  GetInitialized : boolean;
      function  GetMenuItems : ICoreWebView2ContextMenuItemCollection;
      function  GetContextMenuTarget : ICoreWebView2ContextMenuTarget;
      function  GetLocation : TPoint;
      function  GetSelectedCommandId : Integer;
      function  GetDeferral : ICoreWebView2Deferral;
      function  GetHandled : boolean;

      procedure SetSelectedCommandId(aValue: Integer);
      procedure SetHandled(aValue : boolean);

    public
      constructor Create(const aArgs: ICoreWebView2ContextMenuRequestedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized                   : boolean                                             read GetInitialized;
      property BaseIntf                      : ICoreWebView2ContextMenuRequestedEventArgs          read FBaseIntf;
      property MenuItems                     : ICoreWebView2ContextMenuItemCollection              read GetMenuItems;
      property ContextMenuTarget             : ICoreWebView2ContextMenuTarget                      read GetContextMenuTarget;
      property Location                      : TPoint                                              read GetLocation;
      property SelectedCommandId             : integer                                             read GetSelectedCommandId    write SetSelectedCommandId;
      property Handled                       : boolean                                             read GetHandled              write SetHandled;
      property Deferral                      : ICoreWebView2Deferral                               read GetDeferral;
  end;

  TCoreWebView2ServerCertificateErrorDetectedEventArgs = class
    protected
      FBaseIntf : ICoreWebView2ServerCertificateErrorDetectedEventArgs;

      function  GetInitialized : boolean;
      function  GetErrorStatus : TWVWebErrorStatus;
      function  GetRequestUri : wvstring;
      function  GetServerCertificate : ICoreWebView2Certificate;
      function  GetAction : TWVServerCertificateErrorAction;
      function  GetDeferral : ICoreWebView2Deferral;

      procedure SetAction(aValue: TWVServerCertificateErrorAction);

    public
      constructor Create(const aArgs: ICoreWebView2ServerCertificateErrorDetectedEventArgs); reintroduce;
      destructor  Destroy; override;

      property Initialized                   : boolean                                              read GetInitialized;
      property BaseIntf                      : ICoreWebView2ServerCertificateErrorDetectedEventArgs read FBaseIntf;
      property ErrorStatus                   : TWVWebErrorStatus                                    read GetErrorStatus;
      property RequestUri                    : wvstring                                             read GetRequestUri;
      property ServerCertificate             : ICoreWebView2Certificate                             read GetServerCertificate;
      property Action                        : TWVServerCertificateErrorAction                      read GetAction              write SetAction;
      property Deferral                      : ICoreWebView2Deferral                                read GetDeferral;
  end;


implementation

uses
  uWVMiscFunctions;

// TCoreWebView2AcceleratorKeyPressedEventArgs

constructor TCoreWebView2AcceleratorKeyPressedEventArgs.Create(const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2AcceleratorKeyPressedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetKeyEventKind : TWVKeyEventKind;
var
  TempType : COREWEBVIEW2_KEY_EVENT_KIND;
begin
  if Initialized and succeeded(FBaseIntf.Get_KeyEventKind(TempType)) then
    Result := TempType
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetVirtualKey : LongWord;
var
  TempKey : LongWord;
begin
  if Initialized and succeeded(FBaseIntf.Get_VirtualKey(TempKey)) then
    Result := TempKey
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetKeyEventLParam : integer;
var
  TempParam : Integer;
begin
  if Initialized and succeeded(FBaseIntf.Get_KeyEventLParam(TempParam)) then
    Result := TempParam
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetHandled : boolean;
var
  TempHandled : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempHandled)) and
            (TempHandled <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetRepeatCount : LongWord;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  if Initialized and succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) then
    Result := TempStatus.RepeatCount
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetScanCode : LongWord;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  if Initialized and succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) then
    Result := TempStatus.ScanCode
   else
    Result := 0;
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetIsExtendedKey : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.IsExtendedKey <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetIsMenuKeyDown : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.IsMenuKeyDown <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetWasKeyDown : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.WasKeyDown <> 0);
end;

function TCoreWebView2AcceleratorKeyPressedEventArgs.GetIsKeyReleased : boolean;
var
  TempStatus : COREWEBVIEW2_PHYSICAL_KEY_STATUS;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_PhysicalKeyStatus(TempStatus)) and
            (TempStatus.IsKeyReleased <> 0);
end;

procedure TCoreWebView2AcceleratorKeyPressedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2ContentLoadingEventArgs

constructor TCoreWebView2ContentLoadingEventArgs.Create(const aArgs: ICoreWebView2ContentLoadingEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ContentLoadingEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ContentLoadingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ContentLoadingEventArgs.GetIsErrorPage : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsErrorPage(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ContentLoadingEventArgs.GetNavigationId : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;


// TCoreWebView2DevToolsProtocolEventReceivedEventArgs

constructor TCoreWebView2DevToolsProtocolEventReceivedEventArgs.Create(const aArgs: ICoreWebView2DevToolsProtocolEventReceivedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2DevToolsProtocolEventReceivedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2DevToolsProtocolEventReceivedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2DevToolsProtocolEventReceivedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2DevToolsProtocolEventReceivedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2DevToolsProtocolEventReceivedEventArgs.GetParameterObjectAsJson : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if Initialized and
     succeeded(FBaseIntf.Get_ParameterObjectAsJson(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DevToolsProtocolEventReceivedEventArgs.GetSessionId : wvstring;
var
  TempString : PWideChar;
begin
  Result := '';

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_sessionId(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;



// TCoreWebView2MoveFocusRequestedEventArgs

constructor TCoreWebView2MoveFocusRequestedEventArgs.Create(const aArgs: ICoreWebView2MoveFocusRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2MoveFocusRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2MoveFocusRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2MoveFocusRequestedEventArgs.GetReason : TWVMoveFocusReason;
var
  TempReason : COREWEBVIEW2_MOVE_FOCUS_REASON;
begin
  if Initialized and succeeded(FBaseIntf.Get_reason(TempReason)) then
    Result := TempReason
   else
    Result := 0;
end;

function TCoreWebView2MoveFocusRequestedEventArgs.GetHandled : boolean;
var
  TempHandled : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempHandled)) and
            (TempHandled <> 0);
end;

procedure TCoreWebView2MoveFocusRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2NavigationCompletedEventArgs

constructor TCoreWebView2NavigationCompletedEventArgs.Create(const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NavigationCompletedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2NavigationCompletedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2NavigationCompletedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2NavigationCompletedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NavigationCompletedEventArgs.GetIsSuccess : boolean;
var
  TempSuccess : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsSuccess(TempSuccess)) and
            (TempSuccess <> 0);
end;

function TCoreWebView2NavigationCompletedEventArgs.GetWebErrorStatus : TWVWebErrorStatus;
var
  TempStatus : COREWEBVIEW2_WEB_ERROR_STATUS;
begin
  if Initialized and succeeded(FBaseIntf.Get_WebErrorStatus(TempStatus)) then
    Result := TempStatus
   else
    Result := 0;
end;

function TCoreWebView2NavigationCompletedEventArgs.GetNavigationID : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;

function TCoreWebView2NavigationCompletedEventArgs.GetHttpStatusCode : integer;
var
  TempResult : SYSINT;
begin
  Result     := 0;
  TempResult := 0;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_HttpStatusCode(TempResult)) then
    Result := TempResult;
end;


// TCoreWebView2NavigationStartingEventArgs

constructor TCoreWebView2NavigationStartingEventArgs.Create(const aArgs: ICoreWebView2NavigationStartingEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NavigationStartingEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2NavigationStartingEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2NavigationStartingEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2NavigationStartingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NavigationStartingEventArgs.GetURI : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2NavigationStartingEventArgs.GetIsUserInitiated : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsUserInitiated(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2NavigationStartingEventArgs.GetIsRedirected : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsRedirected(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2NavigationStartingEventArgs.GetRequestHeaders : ICoreWebView2HttpRequestHeaders;
var
  TempResult : ICoreWebView2HttpRequestHeaders;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_RequestHeaders(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2NavigationStartingEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2NavigationStartingEventArgs.GetNavigationID : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;

function TCoreWebView2NavigationStartingEventArgs.GetAdditionalAllowedFrameAncestors : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_AdditionalAllowedFrameAncestors(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

procedure TCoreWebView2NavigationStartingEventArgs.SetAdditionalAllowedFrameAncestors(const aValue : wvstring);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_AdditionalAllowedFrameAncestors(PWideChar(aValue));
end;

procedure TCoreWebView2NavigationStartingEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;


// TCoreWebView2NewWindowRequestedEventArgs

constructor TCoreWebView2NewWindowRequestedEventArgs.Create(const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2NewWindowRequestedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2NewWindowRequestedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2NewWindowRequestedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetURI : wvstring;
var
  TempURI : PWideChar;
begin
  Result  := '';
  TempURI := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempURI)) and
     (TempURI <> nil) then
    begin
      Result := TempURI;
      CoTaskMemFree(TempURI);
    end;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetNewWindow : ICoreWebView2;
var
  TempNewWindow : ICoreWebView2;
begin
  Result        := nil;
  TempNewWindow := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_NewWindow(TempNewWindow)) and
     (TempNewWindow <> nil) then
    Result := TempNewWindow;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetHandled : boolean;
var
  TempHandled : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempHandled)) and
            (TempHandled <> 0);
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetIsUserInitiated : boolean;
var
  TempIsUserInitiated : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsUserInitiated(TempIsUserInitiated)) and
            (TempIsUserInitiated <> 0);
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetWindowFeatures : ICoreWebView2WindowFeatures;
var
  TempWindowFeatures : ICoreWebView2WindowFeatures;
begin
  Result             := nil;
  TempWindowFeatures := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_WindowFeatures(TempWindowFeatures)) and
     (TempWindowFeatures <> nil) then
    Result := TempWindowFeatures;
end;

function TCoreWebView2NewWindowRequestedEventArgs.GetName : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if (FBaseIntf2 <> nil) and
     succeeded(FBaseIntf2.Get_name(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

procedure TCoreWebView2NewWindowRequestedEventArgs.SetNewWindow(const aValue : ICoreWebView2);
begin
  if Initialized then
    FBaseIntf.Set_NewWindow(aValue);
end;

procedure TCoreWebView2NewWindowRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2PermissionRequestedEventArgs

constructor TCoreWebView2PermissionRequestedEventArgs.Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if assigned(aArgs) and
     LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs2, FBaseIntf2) then
    LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs3, FBaseIntf3);
end;

constructor TCoreWebView2PermissionRequestedEventArgs.Create(const aArgs: ICoreWebView2PermissionRequestedEventArgs2);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf2 := aArgs;

  if assigned(aArgs) and
     LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs, FBaseIntf) then
    LoggedQueryInterface(aArgs, IID_ICoreWebView2PermissionRequestedEventArgs3, FBaseIntf3);
end;

destructor TCoreWebView2PermissionRequestedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2PermissionRequestedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2PermissionRequestedEventArgs.GetURI : wvstring;
var
  TempURI : PWideChar;
begin
  Result  := '';
  TempURI := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempURI)) and
     (TempURI <> nil) then
    begin
      Result := TempURI;
      CoTaskMemFree(TempURI);
    end;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetState : TWVPermissionState;
var
  TempState : COREWEBVIEW2_PERMISSION_STATE;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_State(TempState)) then
    Result := TempState
   else
    Result := 0;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetPermissionKind : TWVPermissionKind;
var
  TempKind : COREWEBVIEW2_PERMISSION_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_PermissionKind(TempKind)) then
    Result := TempKind
   else
    Result := 0;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetIsUserInitiated : boolean;
var
  TempIsUserInitiated : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsUserInitiated(TempIsUserInitiated)) and
            (TempIsUserInitiated <> 0);
end;

function TCoreWebView2PermissionRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

function TCoreWebView2PermissionRequestedEventArgs.GetHandled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf2) and
            succeeded(FBaseIntf2.Get_Handled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2PermissionRequestedEventArgs.GetSavesInProfile : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf3) and
            succeeded(FBaseIntf3.Get_SavesInProfile(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2PermissionRequestedEventArgs.SetState(aValue : TWVPermissionState);
begin
  if Initialized then
    FBaseIntf.Set_State(aValue);
end;

procedure TCoreWebView2PermissionRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if assigned(FBaseIntf2) then
    FBaseIntf2.Set_Handled(ord(aValue));
end;

procedure TCoreWebView2PermissionRequestedEventArgs.SetSavesInProfile(aValue : boolean);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_SavesInProfile(ord(aValue));
end;


// TCoreWebView2ProcessFailedEventArgs

constructor TCoreWebView2ProcessFailedEventArgs.Create(const aArgs: ICoreWebView2ProcessFailedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2ProcessFailedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2ProcessFailedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2ProcessFailedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2ProcessFailedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ProcessFailedEventArgs.GetProcessFailedKind : TWVProcessFailedKind;
var
  TempKind : COREWEBVIEW2_PROCESS_FAILED_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ProcessFailedKind(TempKind)) then
    Result := TempKind
   else
    Result := 0;
end;

function TCoreWebView2ProcessFailedEventArgs.GetReason : TWVProcessFailedReason;
var
  TempResult : COREWEBVIEW2_PROCESS_FAILED_REASON;
begin
  Result     := 0;
  TempResult := 0;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_reason(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ProcessFailedEventArgs.GetExtiCode : integer;
var
  TempResult : SYSINT;
begin
  Result     := 0;
  TempResult := 0;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_ExitCode(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ProcessFailedEventArgs.GetProcessDescription : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_ProcessDescription(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ProcessFailedEventArgs.GetFrameInfosForFailedProcess : ICoreWebView2FrameInfoCollection;
var
  TempResult : ICoreWebView2FrameInfoCollection;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_FrameInfosForFailedProcess(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;


// TCoreWebView2ScriptDialogOpeningEventArgs

constructor TCoreWebView2ScriptDialogOpeningEventArgs.Create(const aArgs: ICoreWebView2ScriptDialogOpeningEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ScriptDialogOpeningEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetURI : wvstring;
var
  TempURI : PWideChar;
begin
  Result  := '';
  TempURI := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempURI)) and
     (TempURI <> nil) then
    begin
      Result := TempURI;
      CoTaskMemFree(TempURI);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetKind : TWVScriptDialogKind;
var
  TempKind : COREWEBVIEW2_SCRIPT_DIALOG_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempKind)) then
    Result := TempKind
   else
    Result := 0;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetMessage : wvstring;
var
  TempString : PWideChar;
begin
  Result  := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Message(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.Accept : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Accept);
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetDefaultText : wvstring;
var
  TempString : PWideChar;
begin
  Result  := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DefaultText(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetResultText : wvstring;
var
  TempString : PWideChar;
begin
  Result  := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ResultText(TempString)) and
     (TempString <> nil) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptDialogOpeningEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

procedure TCoreWebView2ScriptDialogOpeningEventArgs.SetResultText(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_ResultText(PWideChar(aValue));
end;


// TCoreWebView2SourceChangedEventArgs

constructor TCoreWebView2SourceChangedEventArgs.Create(const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2SourceChangedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2SourceChangedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2SourceChangedEventArgs.GetIsNewDocument : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsNewDocument(TempInt)) and
            (TempInt <> 0);
end;


// TCoreWebView2WebMessageReceivedEventArgs1

constructor TCoreWebView2WebMessageReceivedEventArgs.Create(const aArgs: ICoreWebView2WebMessageReceivedEventArgs);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aArgs;

  if Initialized then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2WebMessageReceivedEventArgs2, FBaseIntf2);
end;

destructor TCoreWebView2WebMessageReceivedEventArgs.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2WebMessageReceivedEventArgs.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetSource : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Source(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetWebMessageAsJson : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_webMessageAsJson(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetWebMessageAsString : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.TryGetWebMessageAsString(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2WebMessageReceivedEventArgs.GetAdditionalObjects : ICoreWebView2ObjectCollectionView;
var
  TempCollectionView : ICoreWebView2ObjectCollectionView;
begin
  Result             := nil;
  TempCollectionView := nil;

  if assigned(FBaseIntf2) and
     succeeded(FBaseIntf2.Get_AdditionalObjects(TempCollectionView)) and
     (TempCollectionView <> nil) then
    Result := TempCollectionView;
end;


// TCoreWebView2WebResourceRequestedEventArgs

constructor TCoreWebView2WebResourceRequestedEventArgs.Create(const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2WebResourceRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetRequest : ICoreWebView2WebResourceRequest;
var
  TempRequest : ICoreWebView2WebResourceRequest;
begin
  Result      := nil;
  TempRequest := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Request(TempRequest)) and
     (TempRequest <> nil) then
    Result := TempRequest;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetResponse : ICoreWebView2WebResourceResponse;
var
  TempResponse : ICoreWebView2WebResourceResponse;
begin
  Result       := nil;
  TempResponse := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Response(TempResponse)) and
     (TempResponse <> nil) then
    Result := TempResponse;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempDeferral : ICoreWebView2Deferral;
begin
  Result       := nil;
  TempDeferral := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempDeferral)) and
     (TempDeferral <> nil) then
    Result := TempDeferral;
end;

function TCoreWebView2WebResourceRequestedEventArgs.GetResourceContext : TWVWebResourceContext;
var
  TempContext : COREWEBVIEW2_WEB_RESOURCE_CONTEXT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ResourceContext(TempContext)) then
    Result := TempContext
   else
    Result := 0;
end;

procedure TCoreWebView2WebResourceRequestedEventArgs.SetResponse(const aValue : ICoreWebView2WebResourceResponse);
begin
  if Initialized then
    FBaseIntf.Set_Response(aValue);
end;


// TCoreWebView2BrowserProcessExitedEventArgs

constructor TCoreWebView2BrowserProcessExitedEventArgs.Create(const aArgs: ICoreWebView2BrowserProcessExitedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2BrowserProcessExitedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2BrowserProcessExitedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2BrowserProcessExitedEventArgs.GetBrowserProcessExitKind : TWVBrowserProcessExitKind;
var
  TempResult : COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_BrowserProcessExitKind(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2BrowserProcessExitedEventArgs.GetBrowserProcessId : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_BrowserProcessId(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;


// TCoreWebView2WebResourceResponseReceivedEventArgs

constructor TCoreWebView2WebResourceResponseReceivedEventArgs.Create(const aArgs: ICoreWebView2WebResourceResponseReceivedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2WebResourceResponseReceivedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2WebResourceResponseReceivedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2WebResourceResponseReceivedEventArgs.GetRequest : ICoreWebView2WebResourceRequest;
var
  TempRequest : ICoreWebView2WebResourceRequest;
begin
  Result      := nil;
  TempRequest := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Request(TempRequest)) and
     (TempRequest <> nil) then
    Result := TempRequest;
end;

function TCoreWebView2WebResourceResponseReceivedEventArgs.GetResponse : ICoreWebView2WebResourceResponseView;
var
  TempResponse : ICoreWebView2WebResourceResponseView;
begin
  Result       := nil;
  TempResponse := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Response(TempResponse)) and
     (TempResponse <> nil) then
    Result := TempResponse;
end;


// TCoreWebView2DOMContentLoadedEventArgs

constructor TCoreWebView2DOMContentLoadedEventArgs.Create(const aArgs: ICoreWebView2DOMContentLoadedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2DOMContentLoadedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2DOMContentLoadedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2DOMContentLoadedEventArgs.GetNavigationID : uint64;
var
  TempID : Largeuint;
begin
  if Initialized and succeeded(FBaseIntf.Get_NavigationId(TempID)) then
    Result := uint64(TempID)
   else
    Result := 0;
end;


// TCoreWebView2FrameCreatedEventArgs

constructor TCoreWebView2FrameCreatedEventArgs.Create(const aArgs: ICoreWebView2FrameCreatedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2FrameCreatedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2FrameCreatedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2FrameCreatedEventArgs.GetFrame : ICoreWebView2Frame;
var
  TempResult : ICoreWebView2Frame;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Frame(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;


// TCoreWebView2DownloadStartingEventArgs

constructor TCoreWebView2DownloadStartingEventArgs.Create(const aArgs: ICoreWebView2DownloadStartingEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2DownloadStartingEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2DownloadStartingEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2DownloadStartingEventArgs.GetDownloadOperation : ICoreWebView2DownloadOperation;
var
  TempResult : ICoreWebView2DownloadOperation;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DownloadOperation(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2DownloadStartingEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2DownloadStartingEventArgs.GetResultFilePath : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ResultFilePath(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2DownloadStartingEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2DownloadStartingEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2DownloadStartingEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;

procedure TCoreWebView2DownloadStartingEventArgs.SetResultFilePath(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_ResultFilePath(PWideChar(aValue));
end;

procedure TCoreWebView2DownloadStartingEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2ClientCertificateRequestedEventArgs

constructor TCoreWebView2ClientCertificateRequestedEventArgs.Create(const aArgs: ICoreWebView2ClientCertificateRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ClientCertificateRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetHost : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Host(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetIsProxy : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsProxy(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetAllowedCertificateAuthorities : ICoreWebView2StringCollection;
var
  TempResult : ICoreWebView2StringCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_AllowedCertificateAuthorities(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetMutuallyTrustedCertificates : ICoreWebView2ClientCertificateCollection;
var
  TempResult : ICoreWebView2ClientCertificateCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_MutuallyTrustedCertificates(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetSelectedCertificate : ICoreWebView2ClientCertificate;
var
  TempResult : ICoreWebView2ClientCertificate;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_SelectedCertificate(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ClientCertificateRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2ClientCertificateRequestedEventArgs.SetSelectedCertificate(const aValue : ICoreWebView2ClientCertificate);
begin
  if Initialized then
    FBaseIntf.Set_SelectedCertificate(aValue);
end;

procedure TCoreWebView2ClientCertificateRequestedEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;

procedure TCoreWebView2ClientCertificateRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2BasicAuthenticationRequestedEventArgs

constructor TCoreWebView2BasicAuthenticationRequestedEventArgs.Create(const aArgs: ICoreWebView2BasicAuthenticationRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2BasicAuthenticationRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_uri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetChallenge : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Challenge(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetResponse : ICoreWebView2BasicAuthenticationResponse;
var
  TempResult : ICoreWebView2BasicAuthenticationResponse;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Response(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetCancel : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Cancel(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2BasicAuthenticationRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2BasicAuthenticationRequestedEventArgs.SetCancel(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Cancel(ord(aValue));
end;


// TCoreWebView2ContextMenuRequestedEventArgs

constructor TCoreWebView2ContextMenuRequestedEventArgs.Create(const aArgs: ICoreWebView2ContextMenuRequestedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ContextMenuRequestedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetMenuItems : ICoreWebView2ContextMenuItemCollection;
var
  TempResult : ICoreWebView2ContextMenuItemCollection;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_MenuItems(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetContextMenuTarget : ICoreWebView2ContextMenuTarget;
var
  TempResult : ICoreWebView2ContextMenuTarget;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ContextMenuTarget(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetLocation : TPoint;
var
  TempResult : tagPOINT;
begin
  Result.x := low(integer);
  Result.y := low(integer);

  if Initialized and
     succeeded(FBaseIntf.Get_Location(TempResult)) then
    begin
      Result.x := TempResult.x;
      Result.y := TempResult.y;
    end;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetSelectedCommandId : Integer;
var
  TempResult : integer;
begin
  Result     := -1;
  TempResult := -1;

  if Initialized and
     succeeded(FBaseIntf.Get_SelectedCommandId(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetHandled : boolean;
var
  TempInt : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Handled(TempInt)) and
            (TempInt <> 0);
end;

function TCoreWebView2ContextMenuRequestedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2ContextMenuRequestedEventArgs.SetSelectedCommandId(aValue: Integer);
begin
  if Initialized then
    FBaseIntf.Set_SelectedCommandId(aValue);
end;

procedure TCoreWebView2ContextMenuRequestedEventArgs.SetHandled(aValue : boolean);
begin
  if Initialized then
    FBaseIntf.Set_Handled(ord(aValue));
end;


// TCoreWebView2ServerCertificateErrorDetectedEventArgs

constructor TCoreWebView2ServerCertificateErrorDetectedEventArgs.Create(const aArgs: ICoreWebView2ServerCertificateErrorDetectedEventArgs);
begin
  inherited Create;

  FBaseIntf := aArgs;
end;

destructor TCoreWebView2ServerCertificateErrorDetectedEventArgs.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetErrorStatus : TWVWebErrorStatus;
var
  TempResult : COREWEBVIEW2_WEB_ERROR_STATUS;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_ErrorStatus(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetRequestUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_RequestUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetServerCertificate : ICoreWebView2Certificate;
var
  TempResult : ICoreWebView2Certificate;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ServerCertificate(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetAction : TWVServerCertificateErrorAction;
var
  TempResult : COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Action(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ServerCertificateErrorDetectedEventArgs.GetDeferral : ICoreWebView2Deferral;
var
  TempResult : ICoreWebView2Deferral;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetDeferral(TempResult)) and
     (TempResult <> nil) then
    Result := TempResult;
end;

procedure TCoreWebView2ServerCertificateErrorDetectedEventArgs.SetAction(aValue: TWVServerCertificateErrorAction);
begin
  if Initialized then
    FBaseIntf.Set_Action(aValue);
end;

end.
