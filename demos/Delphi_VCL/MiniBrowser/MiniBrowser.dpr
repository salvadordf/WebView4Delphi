program MiniBrowser;

uses
  Vcl.Forms,
  uMiniBrowser in 'uMiniBrowser.pas' {MiniBrowserFrm},
  uTextViewerForm in 'uTextViewerForm.pas' {TextViewerFrm},
  uBasicUserAuthForm in 'uBasicUserAuthForm.pas' {TBasicUserAuthForm};

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMiniBrowserFrm, MiniBrowserFrm);
  Application.CreateForm(TTextViewerFrm, TextViewerFrm);
  Application.Run;
end.
