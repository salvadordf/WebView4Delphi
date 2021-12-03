unit uMainForm;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, System.ImageList,
  uWVLoader;

type
  TMainForm = class(TForm)
    ToolBar2: TToolBar;
    ToolButton9: TToolButton;
    ImageList1: TImageList;
    procedure FileNew1Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// This demo shows how to create multiple browsers at runtime using MDI child forms.

uses
  uChildForm;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  TMDIChild.Create(Application);
end;

procedure GlobalWebView2Loader_OnEnvironmentCreated(Sender: TObject);
begin
  if assigned(MainForm) and not(MainForm.ToolBar2.Enabled) then
    begin
      MainForm.ToolBar2.Enabled := True;
      MainForm.FileNew1Execute(nil);
    end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized and not(MainForm.ToolBar2.Enabled) then
      begin
        MainForm.ToolBar2.Enabled := True;
        MainForm.FileNew1Execute(nil);
      end;
end;

initialization
  GlobalWebView2Loader                      := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder       := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.OnEnvironmentCreated := GlobalWebView2Loader_OnEnvironmentCreated;
  GlobalWebView2Loader.StartWebView2;

end.
