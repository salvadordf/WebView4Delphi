unit uBasicUserAuthForm;        

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, Windows, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  uWVTypeLibrary, uWVCoreWebView2Args, uWVCoreWebView2Deferral;

type
  TTBasicUserAuthForm = class(TForm)
    ButtonPnl: TPanel;
    OkBtn: TButton;
    CancelBtn: TButton;
    InfoLbl: TLabel;
    UsernameLbl: TLabel;
    PasswordLbl: TLabel;
    UsernameEdt: TEdit;
    PasswordEdt: TEdit;
    URILbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure UsernameEdtChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FArgs        : TCoreWebView2BasicAuthenticationRequestedEventArgs;
    FDeferral    : TCoreWebView2Deferral;
    FOkPressed   : boolean;
  public
    constructor Create(AOwner: TComponent; const aArgs : ICoreWebView2BasicAuthenticationRequestedEventArgs); reintroduce;
  end;

implementation

{$R *.lfm}

uses
  uWVCoreWebView2BasicAuthenticationResponse;

procedure TTBasicUserAuthForm.CancelBtnClick(Sender: TObject);
begin
  close;
end;

constructor TTBasicUserAuthForm.Create(AOwner: TComponent; const aArgs : ICoreWebView2BasicAuthenticationRequestedEventArgs);
begin
  inherited Create(AOwner);

  FArgs      := TCoreWebView2BasicAuthenticationRequestedEventArgs.Create(aArgs);
  FDeferral  := TCoreWebView2Deferral.Create(FArgs.Deferral);
  FOkPressed := False;
end;

procedure TTBasicUserAuthForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not(FOkPressed) then
    FArgs.Cancel := True;

  Action := TCloseAction.caFree;
end;

procedure TTBasicUserAuthForm.FormDestroy(Sender: TObject);
begin
  if assigned(FDeferral) then
    FreeAndNil(FDeferral);

  if assigned(FArgs) then
    FreeAndNil(FArgs);
end;

procedure TTBasicUserAuthForm.FormShow(Sender: TObject);
begin
  URILbl.Caption := Utf8Encode(FArgs.URI);
end;

procedure TTBasicUserAuthForm.OkBtnClick(Sender: TObject);
var
  TempResponse : TCoreWebView2BasicAuthenticationResponse;
begin
  FOkPressed := True;

  TempResponse          := TCoreWebView2BasicAuthenticationResponse.Create(FArgs.Response);
  TempResponse.Username := Utf8Decode(UsernameEdt.Text);
  TempResponse.Password := Utf8Decode(PasswordEdt.Text);
  TempResponse.Free;

  close;
end;

procedure TTBasicUserAuthForm.UsernameEdtChange(Sender: TObject);
begin
  OkBtn.Enabled := (length(UsernameEdt.Text) > 0) and (length(PasswordEdt.Text) > 0);
end;

end.
