unit UntDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TDtMdPrincipal = class(TDataModule)
    RESTClientAPICSharp: TRESTClient;
    RESTResponsePessoa: TRESTResponse;
    RESTRequestPessoa: TRESTRequest;
    RESTRequestPut: TRESTRequest;
    RESTRequestPost: TRESTRequest;
    RESTRequestDelete: TRESTRequest;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtMdPrincipal: TDtMdPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
