program WebpageSnapshot;

{$MODE Delphi}

uses
  Forms, Interfaces,
  uWebpageSnapshot in 'uWebpageSnapshot.pas' {WebpageSnapshotFrm};

begin
  Application.Initialize;
  Application.CreateForm(TWebpageSnapshotFrm, WebpageSnapshotFrm);
  Application.Run;
end.
