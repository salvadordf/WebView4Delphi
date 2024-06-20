unit uWVCoreWebView2File;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Representation of a DOM
  /// [File](https://developer.mozilla.org/docs/Web/API/File) object
  /// passed via WebMessage. You can use this object to obtain the path of a
  /// File dropped on WebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2file">See the ICoreWebView2File article.</see></para>
  /// </remarks>
  TCoreWebView2File = class
    protected
      FBaseIntf : ICoreWebView2File;

      function GetInitialized : boolean;
      function GetPath : wvstring;

    public
      constructor Create(const aBaseIntf : ICoreWebView2File); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized    : boolean                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf       : ICoreWebView2File           read FBaseIntf           write FBaseIntf;
      /// <summary>
      /// Get the absolute file path.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2file#get_path">See the ICoreWebView2File article.</see></para>
      /// </remarks>
      property Path           : wvstring                    read GetPath;
  end;

implementation


uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2File.Create(const aBaseIntf: ICoreWebView2File);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2File.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2File.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2File.GetPath : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Path(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

end.
