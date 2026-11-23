unit uWVCoreWebView2SharedWorker;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, Winapi.ActiveX,
  {$ELSE}
  Classes, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  TCoreWebView2SharedWorker = class
    protected
      FBaseIntf                                : ICoreWebView2SharedWorker;
      FWorkerID                                : cardinal;
      FDestroyingToken                         : EventRegistrationToken;

      function GetInitialized : boolean;
      function GetScriptUri : wvstring;
      function GetOrigin : wvstring;
      function GetTopLevelOrigin : wvstring;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddSharedWorkerDestroyingEvent(const aBrowserComponent : TComponent) : boolean;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2SharedWorker wrapper.
      /// </summary>
      /// <param name="aBaseIntf">The ICoreWebView2SharedWorker instance.</param>
      constructor Create(const aBaseIntf : ICoreWebView2SharedWorker); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized         : boolean                         read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf            : ICoreWebView2SharedWorker       read FBaseIntf;
      /// <summary>
      /// Custom unique identifier of the current dedicated worker.
      /// </summary>
      property WorkerID            : cardinal                        read FWorkerID;
      /// <summary>
      /// <para>A string representing the Uri of the script that the worker is executing.</para>
      ///
      /// <para>The 'scriptUri' is a fully qualified URI, including the scheme, host, and path.
      /// In contrast, the 'scriptURL' property of the 'Worker' object in the DOM returns the relative
      /// URL of the script being executed by the worker. For more details on DOM API, see the
      /// [DOM API documentation](https://developer.mozilla.org/docs/Web/API/Worker/scriptURL).</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how normalization is performed.</para>
      /// <para>The same process applies to the 'scriptURL' when a worker is created from DOM API.</para>
      /// <para>The 'scriptUri' property reflects this normalization, ensuring that the URL is standardized. For example,
      /// 'HTTPS://EXAMPLE.COM/worker.js' is canonicalized to 'https://example.com/worker.js';
      /// 'https://bücher.de/worker.js' is canonicalized to 'https://xn--bcher-kva.de/worker.js'.</para>
      /// </summary>
      property ScriptUri           : wvstring                        read GetScriptUri;
      /// <summary>
      /// <para>A string representing the URI of the origin where the worker is executing.</para>
      ///
      /// <para>If a worker created with 'ScriptUri' set to https://example.com/worker.js, the origin
      /// will be https://example.com/.</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how normalization is performed.</para>
      /// </summary>
      property Origin              : wvstring                        read GetOrigin;
      /// <summary>
      /// <para>A string representing the URI of the top-level document that the worker is associated with.</para>
      ///
      /// <para>If a worker is created with 'ScriptUri' set to https://example.com/worker.js, the top-level origin
      /// is https://example.com/. If the same worker is created from a iframe at https://example.com/ which is hosted on
      /// https://example2.com/, the top-level origin is https://example2.com/.</para>
      ///
      /// <para>Refer to the Host Name Canonicalization for
      /// details on how normalization is performed.</para>
      ///
      /// <para>When CustomDataPartitionId is set, the 'TopLevelOrigin' will be a generated
      /// site like guid.invalid. For example, if the top-level document is https://example.com/worker.js,
      /// the top-level origin will be https://guid.invalid/.</para>
      ///
      /// <para>For more details see 'ICoreWebView2Experimental20::CustomDataPartitionId'.</para>
      /// </summary>
      property TopLevelOrigin      : wvstring                        read GetTopLevelOrigin;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates, uWVConstants, uWVLoader;

constructor TCoreWebView2SharedWorker.Create(const aBaseIntf: ICoreWebView2SharedWorker);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;

  if assigned(GlobalWebView2Loader) then
    FWorkerID := GlobalWebView2Loader.NextWorkerID;
end;

destructor TCoreWebView2SharedWorker.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2SharedWorker.InitializeFields;
begin
  FBaseIntf := nil;
  FWorkerID := 0;

  InitializeTokens;
end;

procedure TCoreWebView2SharedWorker.InitializeTokens;
begin
  FDestroyingToken.value := 0;
end;

procedure TCoreWebView2SharedWorker.RemoveAllEvents;
begin
  if Initialized then
    begin
      if (FDestroyingToken.value <> 0) then
        FBaseIntf.remove_Destroying(FDestroyingToken);

      InitializeTokens;
    end;
end;

function TCoreWebView2SharedWorker.AddSharedWorkerDestroyingEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2SharedWorkerDestroyingEventHandler;
begin
  Result := False;

  if Initialized and (FDestroyingToken.value = 0) then
    try
      TempHandler := TCoreWebView2SharedWorkerDestroyingEventHandler.Create(TWVBrowserBase(aBrowserComponent), WorkerID);
      Result      := succeeded(FBaseIntf.add_Destroying(TempHandler, FDestroyingToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2SharedWorker.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddSharedWorkerDestroyingEvent(aBrowserComponent);
end;

function TCoreWebView2SharedWorker.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2SharedWorker.GetScriptUri : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ScriptUri(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2SharedWorker.GetOrigin : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_origin(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2SharedWorker.GetTopLevelOrigin : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_TopLevelOrigin(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
