unit uWVCoreWebView2Deferral;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  /// <summary>
  /// This interface is used to complete deferrals on event args that support
  /// getting deferrals using the GetDeferral method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2deferral">See the ICoreWebView2Deferral article.</see></para>
  /// </remarks>
  TCoreWebView2Deferral = class
    protected
      FBaseIntf : ICoreWebView2Deferral;

      function GetInitialized : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Deferral); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// Completes the associated deferred event.  Complete should only be run
      /// once for each deferral taken.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2deferral#complete">See the ICoreWebView2Deferral article.</see></para>
      /// </remarks>
      function    Complete : boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized : boolean                read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf    : ICoreWebView2Deferral  read FBaseIntf;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2Deferral.Create(const aBaseIntf: ICoreWebView2Deferral);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2Deferral.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2Deferral.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Deferral.Complete : boolean;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Complete);
end;

end.

