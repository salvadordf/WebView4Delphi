unit uWVCoreWebView2FileSystemHandle;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Representation of a DOM
  /// [FileSystemHandle](https://developer.mozilla.org/docs/Web/API/FileSystemHandle)
  /// object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2filesystemhandle">See the ICoreWebView2FileSystemHandle article.</see></para>
  /// </remarks>
  TCoreWebView2FileSystemHandle = class
    protected
      FBaseIntf : ICoreWebView2FileSystemHandle;

      function GetInitialized : boolean;
      function GetKind : TWVFileSystemHandleKind;
      function GetPath : wvstring;
      function GetPermission : TWVFileSystemHandlePermission;

    public
      constructor Create(const aBaseIntf : ICoreWebView2FileSystemHandle); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2FileSystemHandle                read FBaseIntf;
      /// <summary>
      /// The kind of the FileSystemHandle. It can either be a file or a directory.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2filesystemhandle#get_kind">See the ICoreWebView2FileSystemHandle article.</see></para>
      /// </remarks>
      property Kind                  : TWVFileSystemHandleKind                      read GetKind;
      /// <summary>
      /// The path to the FileSystemHandle.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2filesystemhandle#get_path">See the ICoreWebView2FileSystemHandle article.</see></para>
      /// </remarks>
      property Path                  : wvstring                                     read GetPath;
      /// <summary>
      /// The permissions granted to the FileSystemHandle.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2filesystemhandle#get_permission">See the ICoreWebView2FileSystemHandle article.</see></para>
      /// </remarks>
      property Permission            : TWVFileSystemHandlePermission                read GetPermission;

  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2FileSystemHandle.Create(const aBaseIntf: ICoreWebView2FileSystemHandle);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2FileSystemHandle.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2FileSystemHandle.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2FileSystemHandle.GetKind : TWVFileSystemHandleKind;
var
  TempResult : COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Kind(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2FileSystemHandle.GetPath : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Path(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2FileSystemHandle.GetPermission : TWVFileSystemHandlePermission;
var
  TempResult : COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Permission(TempResult)) then
    Result := TempResult;
end;

end.
