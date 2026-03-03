unit uLoaderForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TLoaderForm = class(TForm)
    InitializeBtn: TButton;
    ShowBtn: TButton;
    CloseBtn: TButton;
    FinalizeBtn: TButton;
    procedure InitializeBtnClick(Sender: TObject);
    procedure ShowBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FinalizeBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FInitialized : boolean;

  public
    { Public declarations }
  end;

  procedure InitializeWebView4Delphi; stdcall; external 'DLLBrowser.dll';
  procedure FinalizeWebView4Delphi; stdcall; external 'DLLBrowser.dll';
  procedure ShowBrowser; stdcall; external 'DLLBrowser.dll';

var
  LoaderForm: TLoaderForm;

implementation

{$R *.dfm}

procedure TLoaderForm.InitializeBtnClick(Sender: TObject);
begin
  InitializeWebView4Delphi;

  FInitialized          := True;
  InitializeBtn.Enabled := False;
  ShowBtn.Enabled       := True;
end;

procedure TLoaderForm.ShowBtnClick(Sender: TObject);
begin
  ShowBrowser;

  ShowBtn.Enabled     := False;
  FinalizeBtn.Enabled := True;
end;

procedure TLoaderForm.FinalizeBtnClick(Sender: TObject);
begin
  FinalizeWebView4Delphi;

  FInitialized        := False;
  FinalizeBtn.Enabled := False;
  CloseBtn.Enabled    := True;
end;

procedure TLoaderForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not(FInitialized);
end;

procedure TLoaderForm.CloseBtnClick(Sender: TObject);
begin
  close;
end;

end.
