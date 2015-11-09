program windowroller;


  uses Vcl.Forms
     , FormConfig  in 'source\FormConfig.pas'  {ConfigForm}
     , FormOverlay in 'source\FormOverlay.pas' {OverlayForm}
     ;

{$R *.res}


begin
  Application.Initialize;
  Application.ShowMainForm := true;
  Application.Title := 'Window Cigar Roller';
  Application.CreateForm(TFormConfig, ConfigForm);
  Application.Run;
end.
