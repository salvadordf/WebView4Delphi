unit uWVCoreWebView2Deferral;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary;

type
  TCoreWebView2Deferral = class
    protected
      FBaseIntf : ICoreWebView2Deferral;

      function GetInitialized : boolean;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Deferral); reintroduce;
      destructor  Destroy; override;
      function    Complete : boolean;

      property Initialized : boolean                read GetInitialized;
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

