unit uWVCoreWebView2ProcessExtendedInfoCollection;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// A collection of ICoreWebView2ProcessExtendedInfo.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processextendedinfocollection">See the ICoreWebView2ProcessExtendedInfoCollection article.</see></para>
  /// </remarks>
  TCoreWebView2ProcessExtendedInfoCollection = class
    protected
      FBaseIntf : ICoreWebView2ProcessExtendedInfoCollection;

      function GetInitialized : boolean;
      function GetCount : cardinal;
      function GetValueAtIndex(index : cardinal) : ICoreWebView2ProcessExtendedInfo;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ProcessExtendedInfoCollection); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                                      read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2ProcessExtendedInfoCollection   read FBaseIntf;
      /// <summary>
      /// The number of elements contained in the collection.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processextendedinfocollection#get_count">See the ICoreWebView2ProcessExtendedInfoCollection article.</see></para>
      /// </remarks>
      property Count                 : cardinal                                     read GetCount;
      /// <summary>
      /// Gets the element at the given index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processextendedinfocollection#getvalueatindex">See the ICoreWebView2ProcessExtendedInfoCollection article.</see></para>
      /// </remarks>
      property Items[idx : cardinal] : ICoreWebView2ProcessExtendedInfo             read GetValueAtIndex;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ProcessExtendedInfoCollection.Create(const aBaseIntf: ICoreWebView2ProcessExtendedInfoCollection);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ProcessExtendedInfoCollection.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ProcessExtendedInfoCollection.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ProcessExtendedInfoCollection.GetCount : cardinal;
var
  TempResult : SYSUINT;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_Count(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2ProcessExtendedInfoCollection.GetValueAtIndex(index : cardinal) : ICoreWebView2ProcessExtendedInfo;
var
  TempResult : ICoreWebView2ProcessExtendedInfo;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.GetValueAtIndex(index, TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

end.
