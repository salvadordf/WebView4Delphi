unit uChildForm;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  uWVTypeLibrary, uWVCoreWebView2Args, uWVCoreWebView2Deferral,
  uWVCoreWebView2ClientCertificateCollection, uWVCoreWebView2ClientCertificate;

type
  TChildForm = class(TForm)
    ButtonPnl: TPanel;
    SelectBtn: TButton;
    CancelBtn: TButton;
    CertificatesPnl: TPanel;
    CertificatesLb: TListBox;
    procedure FormShow(Sender: TObject);
    procedure CertificatesLbClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SelectBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FArgs        : TCoreWebView2ClientCertificateRequestedEventArgs;
    FDeferral    : TCoreWebView2Deferral;
    FCollection  : TCoreWebView2ClientCertificateCollection;
    FCertificate : TCoreWebView2ClientCertificate;
  public
    constructor Create(AOwner: TComponent; const aArgs : ICoreWebView2ClientCertificateRequestedEventArgs); reintroduce;
  end;

var
  ChildForm: TChildForm;

implementation

{$R *.lfm}

procedure TChildForm.CertificatesLbClick(Sender: TObject);
begin
  if (CertificatesLb.ItemIndex >= 0) then
    begin
      SelectBtn.Enabled := True;
      if assigned(FCollection) and assigned(FCertificate) then
        FCertificate.BaseIntf := FCollection.items[CertificatesLb.ItemIndex];
    end
   else
    begin
      SelectBtn.Enabled := False;
      if assigned(FCertificate) then
        FCertificate.BaseIntf := nil;
    end;
end;

constructor TChildForm.Create(AOwner: TComponent; const aArgs : ICoreWebView2ClientCertificateRequestedEventArgs);
begin
  inherited Create(AOwner);

  FArgs        := TCoreWebView2ClientCertificateRequestedEventArgs.Create(aArgs);
  FDeferral    := TCoreWebView2Deferral.Create(FArgs.Deferral);
  FCollection  := TCoreWebView2ClientCertificateCollection.Create(FArgs.MutuallyTrustedCertificates);
  FCertificate := TCoreWebView2ClientCertificate.Create(nil);
end;

procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TChildForm.FormDestroy(Sender: TObject);
begin
  if assigned(FCertificate) then
    FreeAndNil(FCertificate);

  if assigned(FCollection) then
    FreeAndNil(FCollection);

  if assigned(FDeferral) then
    FreeAndNil(FDeferral);

  if assigned(FArgs) then
    FreeAndNil(FArgs);
end;

procedure TChildForm.FormShow(Sender: TObject);
var
  i : cardinal;
  TempInfo : string;
begin
  if assigned(FCollection) and assigned(FCertificate) then
    begin
      i := 0;
      while (i < FCollection.Count) do
        begin
          FCertificate.BaseIntf := FCollection.items[i];
          TempInfo := UTF8Encode(FCertificate.Subject) + ' - ' +
                      UTF8Encode(FCertificate.DisplayName) + ' - ' +
                      'Valid until : ' + DateToStr(FCertificate.ValidTo);
          CertificatesLb.Items.Add(TempInfo);
          inc(i);
        end;
    end;
end;

procedure TChildForm.CancelBtnClick(Sender: TObject);
begin
  if assigned(FArgs) and assigned(FDeferral) then
    begin
      FArgs.Cancel := True;
      FDeferral.Complete;
    end;

  close;
end;

procedure TChildForm.SelectBtnClick(Sender: TObject);
begin
  if assigned(FArgs) and assigned(FDeferral) then
    begin
      if assigned(FCertificate) and FCertificate.Initialized then
        begin
          FArgs.SelectedCertificate := FCertificate.BaseIntf;
          FArgs.Handled             := True;
          FArgs.Cancel              := False;
        end
       else
        FArgs.Cancel := True;

      FDeferral.Complete;
    end;

  close;
end;

end.
