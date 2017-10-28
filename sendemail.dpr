program sendemail;

uses
  Vcl.Forms,
  Email.View in 'Email.View.pas' {frmEmail},
  Main.View in 'Main.View.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmEmail, frmEmail);
  Application.Run;
end.
