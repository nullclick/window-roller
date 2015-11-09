program windowroller;

uses
  Vcl.Forms,
  Unit1 in 'source\Unit1.pas' {Form1},
  CigarForm in 'source\CigarForm.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := true;
  Application.Title := 'Window Cigar Roller';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
