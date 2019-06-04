program UntrackMe;

uses
  Vcl.Forms,
  MainFM in 'MainFM.pas' {fmUntrackMe};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmUntrackMe, fmUntrackMe);
  Application.Run;
end.
