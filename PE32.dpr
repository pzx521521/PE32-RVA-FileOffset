program PE32;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ufrmdrag in 'E:\Meine_Project\1delphi\ufrmdrag.pas' {frmDrag};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PE32地址转换工具';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmDrag, frmDrag);
  Application.Run;
end.
