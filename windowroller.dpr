program windowroller;

uses
  Vcl.Forms,
  FormConfig in 'source\FormConfig.pas' {FormMain},
  FormOverlay in 'source\FormOverlay.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := true;
  Application.Title := 'Window Cigar Roller';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
