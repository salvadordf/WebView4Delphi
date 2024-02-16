program WebpageSnapshot;

uses
  Vcl.Forms,
  uWebpageSnapshot in 'uWebpageSnapshot.pas' {WebpageSnapshotFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWebpageSnapshotFrm, WebpageSnapshotFrm);
  Application.Run;
end.
