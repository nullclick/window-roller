unit FormOverlay;


interface

  uses Winapi.Windows
     , Winapi.Messages
     , System.SysUtils
     , System.Variants
     , System.Classes
     , Vcl.Graphics
     , Vcl.Controls
     , Vcl.Forms
     , Vcl.Dialogs
     ;


  type

    TFormOverlay = class(TForm)
      private
        { Private declarations }
      public
        { Public declarations }
    end;


  var
    OverlayForm: TFormOverlay;


implementation

{$R *.dfm}

end.
