unit uWVCoreWebView2FindOptions;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX,
  {$ELSE}
  ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Class defining the find options.
  /// This class provides the necessary methods and properties to configure a find session.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2findoptions">See the ICoreWebView2FindOptions article.</see></para>
  /// </remarks>
  TCoreWebView2FindOptions = class
    protected
      FBaseIntf : ICoreWebView2FindOptions;

      function  GetInitialized: boolean;
      function  GetFindTerm: wvstring;
      function  GetIsCaseSensitive: boolean;
      function  GetShouldHighlightAllMatches: boolean;
      function  GetShouldMatchWord: boolean;
      function  GetSuppressDefaultFindDialog: boolean;

      procedure SetFindTerm(const aValue: wvstring);
      procedure SetIsCaseSensitive(aValue: boolean);
      procedure SetShouldHighlightAllMatches(aValue: boolean);
      procedure SetShouldMatchWord(aValue: boolean);
      procedure SetSuppressDefaultFindDialog(aValue: boolean);

    public
      constructor Create(const aBaseIntf : ICoreWebView2FindOptions); reintroduce;
      destructor  Destroy; override;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                : boolean                        read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                   : ICoreWebView2FindOptions       read FBaseIntf;
      /// <summary>
      /// Gets or sets the word or phrase to be searched in the current page.
      /// You can set `FindTerm` to any text you want to find on the page.
      /// This will take effect the next time you call the `Start()` method.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2findoptions#put_findterm">See the ICoreWebView2FindOptions article.</see></para>
      /// </remarks>
      property FindTerm                   : wvstring                       read GetFindTerm                   write SetFindTerm;
      /// <summary>
      /// Determines if the find session is case sensitive. Returns TRUE if the find is case sensitive, FALSE otherwise.
      /// When toggling case sensitivity, the behavior can vary by locale, which may be influenced by both the browser's UI locale and the document's language settings. The browser's UI locale
      /// typically provides a default handling approach, while the document's language settings (e.g., specified using the HTML lang attribute) can override these defaults to apply locale-specific rules. This dual consideration
      /// ensures that text is processed in a manner consistent with user expectations and the linguistic context of the content.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2findoptions#put_iscasesensitive">See the ICoreWebView2FindOptions article.</see></para>
      /// </remarks>
      property IsCaseSensitive            : boolean                        read GetIsCaseSensitive            write SetIsCaseSensitive;
      /// <summary>
      /// Gets or sets the state of whether all matches are highlighted.
      /// Returns TRUE if all matches are highlighted, FALSE otherwise.
      /// Note: Changes to this property take effect only when Start, FindNext, or FindPrevious is called.
      /// Preferences for the session cannot be updated unless another call to the Start function on the server-side is made.
      /// Therefore, changes will not take effect until one of these functions is called.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2findoptions#put_shouldhighlightallmatches">See the ICoreWebView2FindOptions article.</see></para>
      /// </remarks>
      property ShouldHighlightAllMatches  : boolean                        read GetShouldHighlightAllMatches  write SetShouldHighlightAllMatches;
      /// <summary>
      /// Similar to case sensitivity, word matching also can vary by locale, which may be influenced by both the browser's UI locale and the document's language settings. The browser's UI locale
      /// typically provides a default handling approach, while the document's language settings (e.g., specified using the HTML lang attribute) can override these defaults to apply locale-specific rules. This dual consideration
      /// ensures that text is processed in a manner consistent with user expectations and the linguistic context of the content.
      /// ShouldMatchWord determines if only whole words should be matched during the find session. Returns TRUE if only whole words should be matched, FALSE otherwise.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2findoptions#put_shouldmatchword">See the ICoreWebView2FindOptions article.</see></para>
      /// </remarks>
      property ShouldMatchWord            : boolean                        read GetShouldMatchWord            write SetShouldMatchWord;
      /// <summary>
      /// Sets this property to hide the default Find UI.
      /// You can use this to hide the default UI so that you can show your own custom UI or programmatically interact with the Find API while showing no Find UI.
      /// Returns TRUE if hiding the default Find UI and FALSE if using showing the default Find UI.
      /// Note: Changes to this property take effect only when Start, FindNext, or FindPrevious is called.
      /// Preferences for the session cannot be updated unless another call to the Start function on the server-side is made.
      /// Therefore, changes will not take effect until one of these functions is called.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2findoptions#put_suppressdefaultfinddialog">See the ICoreWebView2FindOptions article.</see></para>
      /// </remarks>
      property SuppressDefaultFindDialog  : boolean                        read GetSuppressDefaultFindDialog  write SetSuppressDefaultFindDialog;
  end;

implementation

constructor TCoreWebView2FindOptions.Create(const aBaseIntf: ICoreWebView2FindOptions);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2FindOptions.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2FindOptions.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2FindOptions.GetFindTerm: wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_FindTerm(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2FindOptions.GetIsCaseSensitive: boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsCaseSensitive(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2FindOptions.GetShouldHighlightAllMatches: boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldHighlightAllMatches(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2FindOptions.GetShouldMatchWord: boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_ShouldMatchWord(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2FindOptions.GetSuppressDefaultFindDialog: boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_SuppressDefaultFindDialog(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2FindOptions.SetFindTerm(const aValue: wvstring);
begin
  if Initialized then
    FBaseIntf.Set_FindTerm(PWideChar(aValue));
end;

procedure TCoreWebView2FindOptions.SetIsCaseSensitive(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_IsCaseSensitive(ord(aValue));
end;

procedure TCoreWebView2FindOptions.SetShouldHighlightAllMatches(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_ShouldHighlightAllMatches(ord(aValue));
end;

procedure TCoreWebView2FindOptions.SetShouldMatchWord(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_ShouldMatchWord(ord(aValue));
end;

procedure TCoreWebView2FindOptions.SetSuppressDefaultFindDialog(aValue: boolean);
begin
  if Initialized then
    FBaseIntf.Set_SuppressDefaultFindDialog(ord(aValue));
end;

end.
