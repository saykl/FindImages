program Project6;

uses
  Vcl.Forms,
  Image in 'Image.pas' {ImageFromFolder};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TImageFromFolder, ImageFromFolder);
  Application.Run;
end.
