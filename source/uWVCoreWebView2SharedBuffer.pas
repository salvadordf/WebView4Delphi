unit uWVCoreWebView2SharedBuffer;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
    Winapi.ActiveX,
  {$ELSE}
    {$IFDEF FPC}Windows,{$ENDIF} ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// The shared buffer object that is created by CreateSharedBuffer.
  /// The object is presented to script as ArrayBuffer when posted to script with
  /// PostSharedBufferToScript.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer">See the ICoreWebView2SharedBuffer article.</see></para>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment12#createsharedbuffer">See the CreateSharedBuffer article.</see></para>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_17#postsharedbuffertoscript">See the PostSharedBufferToScript article.</see></para>
  /// </remarks>
  TCoreWebView2SharedBuffer = class
    protected
      FBaseIntf  : ICoreWebView2SharedBuffer;

      function  GetInitialized : boolean;
      function  GetSize : Largeuint;
      function  GetBuffer : PByte;
      function  GetOpenStream : IStream;
      function  GetFileMappingHandle : HANDLE;

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2SharedBuffer); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// <para>Release the backing shared memory. The application should call this API when no
      /// access to the buffer is needed any more, to ensure that the underlying resources
      /// are released timely even if the shared buffer object itself is not released due to
      /// some leaked reference.</para>
      /// <para>After the shared buffer is closed, the buffer address and file mapping handle previously
      /// obtained becomes invalid and cannot be used anymore. Accessing properties of the object
      /// will fail with `RO_E_CLOSED`. Operations like Read or Write on the IStream objects returned
      /// from `OpenStream` will fail with `RO_E_CLOSED`. `PostSharedBufferToScript` will also
      /// fail with `RO_E_CLOSED`.</para>
      /// <para>The script code should call `chrome.webview.releaseBuffer` with
      /// the shared buffer as the parameter to release underlying resources as soon
      /// as it does not need access the shared buffer any more.</para>
      /// <para>When script tries to access the buffer after calling `chrome.webview.releaseBuffer`,
      /// JavaScript `TypeError` exception will be raised complaining about accessing a
      /// detached ArrayBuffer, the same exception when trying to access a transferred ArrayBuffer.</para>
      /// <para>Closing the buffer object on native side doesn't impact access from Script and releasing
      /// the buffer from script doesn't impact access to the buffer from native side.
      /// The underlying shared memory will be released by the OS when both native and script side
      /// release the buffer.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer#close">See the ICoreWebView2SharedBuffer article.</see></para>
      /// </remarks>
      function    Close : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property    Initialized        : boolean                    read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property    BaseIntf           : ICoreWebView2SharedBuffer  read FBaseIntf;
      /// <summary>
      /// The size of the shared buffer in bytes.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer#get_size">See the ICoreWebView2SharedBuffer article.</see></para>
      /// </remarks>
      property    Size               : Largeuint                  read GetSize;
      /// <summary>
      /// The memory address of the shared buffer.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer#get_buffer">See the ICoreWebView2SharedBuffer article.</see></para>
      /// </remarks>
      property    Buffer             : PByte                      read GetBuffer;
      /// <summary>
      /// Get an IStream object that can be used to access the shared buffer.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer#openstream">See the ICoreWebView2SharedBuffer article.</see></para>
      /// </remarks>
      property    OpenStream         : IStream                    read GetOpenStream;
      /// <summary>
      /// <para>Returns a handle to the file mapping object that backs this shared buffer.
      /// The returned handle is owned by the shared buffer object. You should not
      /// call CloseHandle on it.</para>
      /// <para>Normal app should use `Buffer` or `OpenStream` to get memory address
      /// or IStream object to access the buffer.</para>
      /// <para>For advanced scenarios, you could use file mapping APIs to obtain other views
      /// or duplicate this handle to another application process and create a view from
      /// the duplicated handle in that process to access the buffer from that separate process.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer#get_filemappinghandle">See the ICoreWebView2SharedBuffer article.</see></para>
      /// </remarks>
      property    FileMappingHandle  : HANDLE                     read GetFileMappingHandle;
  end;

implementation

uses
  uWVMiscFunctions;


constructor TCoreWebView2SharedBuffer.Create(const aBaseIntf : ICoreWebView2SharedBuffer);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2SharedBuffer.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2SharedBuffer.InitializeFields;
begin
  FBaseIntf := nil;
end;

function TCoreWebView2SharedBuffer.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2SharedBuffer.GetSize : Largeuint;
var
  TempResult : Largeuint;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Size(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.GetBuffer : PByte;
var
  TempResult : PByte;
begin
  Result := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Buffer(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.GetOpenStream : IStream;
var
  TempResult : IStream;
begin
  Result := nil;

  if Initialized and
     succeeded(FBaseIntf.OpenStream(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.GetFileMappingHandle : HANDLE;
var
  TempResult : HANDLE;
begin
  Result := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_FileMappingHandle(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2SharedBuffer.Close : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Close);
end;

end.
