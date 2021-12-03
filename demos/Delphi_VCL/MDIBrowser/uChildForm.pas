unit uChildForm;

interface

uses
  Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages, Vcl.Dialogs,
  uWVBrowser, uWVTypes, uWVConstants, uWVTypeLibrary, uWVLibFunctions,
  uWVLoader, uWVInterfaces, uWVWinControl, uWVWindowParent, Vcl.ExtCtrls,
  uWVBrowserBase;

type
  TMDIChild = class(TForm)
    AddressPnl: TPanel;
    AddressCb: TComboBox;
    GoBtn: TButton;
    WVWindowParent1: TWVWindowParent;
    WVBrowser1: TWVBrowser;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);

  protected
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMDIChild.FormShow(Sender: TObject);
begin
  WVBrowser1.CreateBrowser(WVWindowParent1.Handle);
end;

procedure TMDIChild.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
end;

procedure TMDIChild.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  Caption := WVBrowser1.DocumentTitle;
end;

procedure TMDIChild.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

procedure TMDIChild.WMMove(var aMessage : TWMMove);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TMDIChild.WMMoving(var aMessage : TMessage);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

end.
