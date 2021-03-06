unit UntPessoa;

interface

uses UntIPessoa;

type
  TPessoa = class(TInterfacedObject, IPessoa)
    FId: integer;
    FNome: string;
    FCpf: string;
    FEndereco: integer;
    // setters
    procedure Id(value: integer);
    procedure Nome(value: string);
    procedure Cpf(value: string);
    procedure Endereco(value: integer);
    // getters
    function getId(): integer;
    function getNome(): string;
    function getCpf(): string;
    function getEndereco(): integer;
  end;

implementation

{ TPessoa }



procedure TPessoa.Id(value: integer);
begin
  FId := value;
end;

procedure TPessoa.Cpf(value: string);
begin
  FCpf := value;
end;

procedure TPessoa.Endereco(value: integer);
begin
  FEndereco := value;
end;

procedure TPessoa.Nome(value: string);
begin
  FNome := value;
end;

function TPessoa.getCpf(): string;
begin
  result := FCpf;
end;

function TPessoa.getEndereco(): integer;
begin
  result := FEndereco;
end;

function TPessoa.getId(): integer;
begin
  result := FId;
end;

function TPessoa.getNome(): string;
begin
  result := FNome;
end;


end.
