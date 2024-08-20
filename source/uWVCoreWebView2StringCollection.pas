unit uWVCoreWebView2StringCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// A collection of strings.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2stringcollection">See the ICoreWebView2StringCollection article.</see></para>
  /// </remarks>
  TCoreWebView2StringCollection = class
    protected
      FBaseIntf : ICoreWebView2StringCollection;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : wvstring;

    public
      constructor Create(const aBaseIntf : ICoreWebView2StringCollection); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2StringCollection     read FBaseIntf;
      /// <summary>
      /// The number of elements contained in the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2stringcollection#get_count">See the ICoreWebView2StringCollection article.</see></para>
      /// </remarks>
      property Count                 : cardinal                          read GetCount;
      /// <summary>
      /// Gets the element at the given index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2stringcollection#getvalueatindex">See the ICoreWebView2StringCollection article.</see></para>
      /// </remarks>
      property Items[idx : cardinal] : wvstring                          read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2StringCollection.Create(const aBaseIntf: ICoreWebView2StringCollection);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2StringCollection.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2StringCollection.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2StringCollection.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2StringCollection.GetValueAtIndex(index : cardinal) : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
