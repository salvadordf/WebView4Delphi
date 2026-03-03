program WebView4DelphiLoader;

uses
  Vcl.Forms,
  uLoaderForm in 'uLoaderForm.pas' {LoaderForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoaderForm, LoaderForm);
  Application.Run;
end.
