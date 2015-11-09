unit FormConfig;


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
     , Vcl.StdCtrls
     , System.Generics.Collections
     , FormOverlay
     ;


  type

    TFormConfig = class(TForm)
      btnCreateOverlay: TButton;

      constructor Create(Owner :TComponent);
      procedure btnCreateOverlayClick(Sender: TObject);

      private
        FOverlays :TList<TFormOverlay>;
    end;


  var
    ConfigForm: TFormConfig;


implementation

{$R *.dfm}


  constructor TFormConfig.Create(Owner :TComponent);
    begin
      FOverlays := TList<TFormOverlay>.Create;
      inherited Create(Owner);
    end;


  procedure TFormConfig.btnCreateOverlayClick(Sender: TObject);
    var
      location   :TLocation;
      newOverlay :TFormOverlay;
    begin
      with location do
        begin
          X := 500;
          Y := 500;
          W := 500;
          H := 500;
        end;

      newOverlay := TFormOverlay.CreateOverlay(Self, location);
      newOverlay.Show;
    end;

end.
