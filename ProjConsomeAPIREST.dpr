program ProjConsomeAPIREST;

uses
  System.StartUpCopy,
  FMX.Forms,
  UntConsomeServico in 'UntConsomeServico.pas' {Form1},
  UntDmPrincipal in 'UntDmPrincipal.pas' {DtMdPrincipal: TDataModule},
  UntIPessoa in 'UntIPessoa.pas',
  UntPessoa in 'UntPessoa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDtMdPrincipal, DtMdPrincipal);
  Application.Run;
end.
