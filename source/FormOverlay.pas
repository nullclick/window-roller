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

    TPent = array[0..4] of TPoint;

    TLocation = record
      X :Integer;
      Y :Integer;
      W :Integer;
      H :Integer;
    end;

    TFormOverlay = class(TForm)
        constructor CreateOverlay(Owner :TComponent; Location :TLocation);
        procedure FormCreate(Sender :TObject);
        procedure FormClose(Sender :Tobject; var Action :TCloseAction);

      private
        HRgn      :THandle;
        FLocation :TLocation;
        FPent     :TPent;
        function MakeStarRegion(Size :Integer) :hRgn;
    end;


implementation

{$R *.dfm}

  constructor TFormOverlay.CreateOverlay(Owner :TComponent; Location :TLocation);
    begin
      FLocation := Location;
      inherited Create(Owner);
    end;


  procedure TFormOverlay.FormCreate(Sender :TObject);
    var
      TW : integer;
      ColorIdx, GreetIdx : integer;
    begin
      Self.SetBounds(FLocation.X, FLocation.Y, 250, 250);
      {set window shape to a pentagon}
      HRgn := MakeStarRegion(70);
      SetWindowRgn(Self.Handle, HRgn, true);

      ShowHint := true;
      Self.Color := $00E8E8E8;

      Application.ProcessMessages;
    end;


  procedure TFormOverlay.FormClose(Sender :TObject; var Action :TCloseAction);
    begin
    end;


  function TFormOverlay.MakeStarRegion(Size :Integer) :hRgn;
    {X, Y == screen position of top point, Size == point-to-point distance}
    {Size == Cos18/Cos54 * radius of circumscribing circle}
    var
      XOffset, YOffset, DX1, DY1, DX2, DY2, i : integer;
      BM : TBitmap;
    const
    //  Cos18 = 0.951;
      Cos54 = 0.588;
      Sin54 = 0.809;
      Tan72 = 3.078;
    begin
      XOffset := trunc(Size * Sin54 + 10);  // half width of star
      YOffset := 10;
      {calculate the increments of points from top}
      DX1 := trunc(Size * Sin54);
      DY1 := trunc(Size * Cos54);
      DX2 := Size div 2;
      DY2 := trunc(Size * Tan72 / 2);
      {now specify the points of the pentagon (anti-clock order)}
      FPent[0] := point(XOffset, YOffset);              // Top, Mid
      FPent[1] := point(XOffset - DX1, YOffset + DY1);  // Mid, Left
      FPent[2] := point(XOffset - DX2, YOffset + DY2);  // Bottom, Left
      FPent[3] := point(XOffset + DX2, YOffset + DY2);  // Bottom, Right
      FPent[4] := point(XOffset + DX1, YOffset + DY1);  // Mid, Right
      {draw pentacle as path}
      BM := TBitmap.Create;
      BeginPath(BM.Canvas.Handle);
      {...set the fill mode to fill in the central polygon}
      SetPolyFillMode(BM.Canvas.Handle, WINDING);
      with BM.Canvas do begin
        MoveTo(FPent[0].X, FPent[0].Y);
        for i := 1 to 5 do
         with FPent[(i * 2) mod 5] do // go round alternate points joining them
            LineTo(X, Y);
        {end; for i := 0 to 5}
      end; {with Canvas}
      EndPath(BM.Canvas.Handle);
      {... turn the path into a region}
      Result := PathToRegion(BM.Canvas.Handle);
      BM.Free;
    end;

end.
