unit uWVCoreWebView2Find;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, System.Types, System.UITypes, System.SysUtils, Winapi.ActiveX,
  {$ELSE}
  Classes, Graphics, SysUtils, ActiveX,
  {$ENDIF}
  uWVTypeLibrary;

type
  /// <summary>
  /// Class providing methods and properties for finding and navigating through text in the web view.
  /// This class allows for finding text, navigation between matches, and customization of the find UI.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2find">See the ICoreWebView2Find article.</see></para>
  /// </remarks>
  TCoreWebView2Find = class
    protected
      FBaseIntf                       : ICoreWebView2Find;
      FActiveMatchIndexChangedToken   : EventRegistrationToken;
      FMatchCountChangedToken         : EventRegistrationToken;

      function  GetInitialized : boolean;
      function  GetActiveMatchIndex : integer;
      function  GetMatchCount : integer;

      procedure InitializeFields;
      procedure InitializeTokens;
      procedure RemoveAllEvents;

      function  AddActiveMatchIndexChangedEvent(const aBrowserComponent : TComponent) : boolean;
      function  AddMatchCountChangedEvent(const aBrowserComponent : TComponent) : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Find); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Adds all the events of this class to an existing TWVBrowserBase instance.
      /// </summary>
      /// <param name="aBrowserComponent">The TWVBrowserBase instance.</param>
      function    AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
      /// <summary>
      /// Initiates a find using the specified find options asynchronously.
      /// Displays the Find bar and starts the find session. If a find session was already ongoing, it will be stopped and replaced with this new instance.
      /// If called with an empty string, the Find bar is displayed but no finding occurs. Changing the FindOptions object after initiation won't affect the ongoing find session.
      /// To change the ongoing find session, Start must be called again with a new or modified FindOptions object.
      /// Start supports HTML and TXT document queries. In general, this API is designed for text-based find sessions.
      /// If you start a find session programmatically on another file format that doesn't have text fields, the find session will try to execute but will fail to find any matches. (It will silently fail)
      /// Note: The asynchronous action completes when the UI has been displayed with the find term in the UI bar, and the matches have populated on the counter on the find bar.
      /// There may be a slight latency between the UI display and the matches populating in the counter.
      /// The MatchCountChanged and ActiveMatchIndexChanged events are only raised after Start has completed; otherwise, they will have their default values (-1 for active match index and 0 for match count).
      /// To start a new find session (beginning the search from the first match), call `Stop` before invoking `Start`.
      /// If `Start` is called consecutively with the same options and without calling `Stop`, the find session
      /// will continue from the current position in the existing session.
      /// Calling `Start` without altering its parameters will behave either as `FindNext` or `FindPrevious`, depending on the most recent search action performed.
      /// Start will default to forward if neither have been called.
      /// However, calling Start again during an ongoing find session does not resume from the point
      /// of the current active match. For example, given the text "1 1 A 1 1" and initiating a find session for "A",
      /// then starting another find session for "1", it will start searching from the beginning of the document,
      /// regardless of the previous active match. This behavior indicates that changing the find query initiates a
      /// completely new find session, rather than continuing from the previous match index.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2find#start">See the ICoreWebView2Find article.</see></para>
      /// </remarks>
      function    Start(const options: ICoreWebView2FindOptions;
                        const handler: ICoreWebView2FindStartCompletedHandler) : boolean;
      /// <summary>
      /// Navigates to the next match in the document.
      /// If there are no matches to find, FindNext will wrap around to the first match's index.
      /// If called when there is no find session active, FindNext will silently fail.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2find#findnext">See the ICoreWebView2Find article.</see></para>
      /// </remarks>
      function    FindNext : boolean;
      /// <summary>
      /// Navigates to the previous match in the document.
      /// If there are no matches to find, FindPrevious will wrap around to the last match's index.
      /// If called when there is no find session active, FindPrevious will silently fail.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2find#findprevious">See the ICoreWebView2Find article.</see></para>
      /// </remarks>
      function    FindPrevious : boolean;
      /// <summary>
      /// Stops the current 'Find' session and hides the Find bar.
      /// If called with no Find session active, it will silently do nothing.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2find#stopt">See the ICoreWebView2Find article.</see></para>
      /// </remarks>
      function    Stop : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                     : boolean                  read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                        : ICoreWebView2Find        read FBaseIntf;
      /// <summary>
      /// Retrieves the index of the currently active match in the find session. Returns the index of the currently active match, or -1 if there is no active match.
      /// The index starts at 1 for the first match.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2find#get_activematchindex">See the ICoreWebView2Find article.</see></para>
      /// </remarks>
      property ActiveMatchIndex                : integer                  read GetActiveMatchIndex;
      /// <summary>
      /// Gets the total count of matches found in the current document based on the last find sessions criteria. Returns the total count of matches.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2find#get_matchcount">See the ICoreWebView2Find article.</see></para>
      /// </remarks>
      property MatchCount                      : integer                  read GetMatchCount;
  end;

implementation

uses
  uWVMiscFunctions, uWVBrowserBase, uWVCoreWebView2Delegates;

constructor TCoreWebView2Find.Create(const aBaseIntf: ICoreWebView2Find);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2Find.Destroy;
begin
  try
    RemoveAllEvents;
    InitializeFields;
  finally
    inherited Destroy;
  end;
end;

procedure TCoreWebView2Find.InitializeFields;
begin
  FBaseIntf := nil;

  InitializeTokens;
end;

procedure TCoreWebView2Find.InitializeTokens;
begin
  FActiveMatchIndexChangedToken.value := 0;
  FMatchCountChangedToken.value       := 0;
end;

procedure TCoreWebView2Find.RemoveAllEvents;
begin
  if Initialized then
    try
      try
        if (FActiveMatchIndexChangedToken.value <> 0) then
          FBaseIntf.remove_ActiveMatchIndexChanged(FActiveMatchIndexChangedToken);

        if (FMatchCountChangedToken.value <> 0) then
          FBaseIntf.remove_MatchCountChanged(FMatchCountChangedToken);
      except
        on e : exception do
          if CustomExceptionHandler('TCoreWebView2Find.RemoveAllEvents', e) then raise;
      end;
    finally
      InitializeTokens;
    end;
end;

function TCoreWebView2Find.AddActiveMatchIndexChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FindActiveMatchIndexChangedEventHandler;
begin
  Result := False;

  if Initialized and (FActiveMatchIndexChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FindActiveMatchIndexChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_ActiveMatchIndexChanged(TempHandler, FActiveMatchIndexChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Find.AddMatchCountChangedEvent(const aBrowserComponent : TComponent) : boolean;
var
  TempHandler : ICoreWebView2FindMatchCountChangedEventHandler;
begin
  Result := False;

  if Initialized and (FMatchCountChangedToken.value = 0) then
    try
      TempHandler := TCoreWebView2FindMatchCountChangedEventHandler.Create(TWVBrowserBase(aBrowserComponent));
      Result      := succeeded(FBaseIntf.add_MatchCountChanged(TempHandler, FMatchCountChangedToken));
    finally
      TempHandler := nil;
    end;
end;

function TCoreWebView2Find.AddAllBrowserEvents(const aBrowserComponent : TComponent) : boolean;
begin
  Result := AddActiveMatchIndexChangedEvent(aBrowserComponent) and
            AddMatchCountChangedEvent(aBrowserComponent);
end;

function TCoreWebView2Find.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Find.GetActiveMatchIndex : integer;
var
  TempResult : SYSINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_ActiveMatchIndex(TempResult)) then
    Result := TempResult
   else
    Result := -1;
end;

function TCoreWebView2Find.GetMatchCount : integer;
var
  TempResult : SYSINT;
begin
  if Initialized and
     succeeded(FBaseIntf.Get_MatchCount(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2Find.Start(const options: ICoreWebView2FindOptions;
                                 const handler: ICoreWebView2FindStartCompletedHandler) : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Start(options, handler));
end;

function TCoreWebView2Find.FindNext : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.FindNext);
end;

function TCoreWebView2Find.FindPrevious : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.FindPrevious);
end;

function TCoreWebView2Find.Stop : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Stop);
end;

end.
