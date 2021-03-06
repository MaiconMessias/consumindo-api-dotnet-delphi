unit UntConsomeServico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.Rtti,
  FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.StdCtrls, FMX.Edit,
  Data.Bind.Controls, FMX.Layouts, Fmx.Bind.Navigator, REST.Json, UntDmPrincipal,
  UntIPessoa, UntPessoa, Vcl.Dialogs, FMX.TabControl;

type
  TForm1 = class(TForm)
    RESTRespDtSetAdapterPessoa: TRESTResponseDataSetAdapter;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    FDMemTbPessoa: TFDMemTable;
    BindSourceDB2: TBindSourceDB;
    FDMemTbPessoaid: TIntegerField;
    FDMemTbPessoanome: TStringField;
    FDMemTbPessoacpf: TStringField;
    FDMemTbPessoaendereco: TIntegerField;
    TabControl1: TTabControl;
    TabItMemTable: TTabItem;
    Panel2: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    btnAtualiza: TButton;
    TabItCampos: TTabItem;
    edtId: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    edtCPF: TEdit;
    Label5: TLabel;
    edtEndereco: TEdit;
    Label4: TLabel;
    Panel3: TPanel;
    btnPut: TButton;
    btnPost: TButton;
    btnDeleteMethod: TButton;
    btnInserir: TButton;
    btnAlterar: TButton;
    btnDelete: TButton;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    btnVoltar: TButton;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure FormShow(Sender: TObject);
    procedure btnAtualizaClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPutClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeleteMethodClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
     function validaDados: boolean;
     procedure habilitaDesabilitaMetodos(btnHabilitado: TButton);
     procedure atualizaDados();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  vPessoa: IPessoa;

implementation

{$R *.fmx}


procedure TForm1.atualizaDados;
begin
  with DtMdPrincipal do begin
    RESTRespDtSetAdapterPessoa.Response := DtMdPrincipal.RESTResponsePessoa;
    RESTClientAPICSharp.BaseURL := Edit1.Text;
    RESTRequestPessoa.Execute;
  end;
end;

procedure TForm1.btnAlterarClick(Sender: TObject);
begin
  if (edtId.Text <> '') then begin
    TabControl1.TabIndex := 1;
    habilitaDesabilitaMetodos(btnPut);
  end;
end;

procedure TForm1.btnAtualizaClick(Sender: TObject);
begin
  atualizaDados();
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  if (edtId.Text <> '') then begin
    TabControl1.TabIndex := 1;
    habilitaDesabilitaMetodos(btnDeleteMethod);
  end;
end;


procedure TForm1.btnInserirClick(Sender: TObject);
begin
  habilitaDesabilitaMetodos(btnPost);
  TabControl1.TabIndex := 1;
  edtId.Text := '';
  edtNome.Text := '';
  edtCPF.Text := '';
  edtEndereco.Text := '';
  FDMemTbPessoa.Append;
end;

procedure TForm1.btnDeleteMethodClick(Sender: TObject);
begin
    with DtMdPrincipal do begin
      try
        vPessoa := TPessoa.Create();
        vPessoa.Id(FDMemTbPessoa.FieldByName('id').AsInteger);
        vPessoa.Nome(FDMemTbPessoa.FieldByName('nome').AsString);
        vPessoa.Cpf(FDMemTbPessoa.FieldByName('cpf').AsString);
        vPessoa.Endereco(FDMemTbPessoa.FieldByName('endereco').AsInteger);

        RESTRequestDelete.Params.ParameterByName('id').Value :=
                                             FDMemTbPessoa.FieldByName('id').AsString;
        RESTRequestDelete.Execute;
        TabControl1.TabIndex := 0;
        atualizaDados();
      except on e: Exception do
        ShowMessage('Erro original: ' + e.Message);
      end;
    end;
    TabControl1.TabIndex := 0;
end;

procedure TForm1.btnPostClick(Sender: TObject);
begin
  {if validaDados then begin
    case MessageDlg('Deseja salvar as altera??es ?', mtConfirmation, [mbOK, mbCancel], 0) of
      mrOk: begin}
        with DtMdPrincipal do begin
          try
            vPessoa := TPessoa.Create();
            vPessoa.Id(FDMemTbPessoa.FieldByName('id').AsInteger);
            vPessoa.Nome(FDMemTbPessoa.FieldByName('nome').AsString);
            vPessoa.Cpf(FDMemTbPessoa.FieldByName('cpf').AsString);
            vPessoa.Endereco(FDMemTbPessoa.FieldByName('endereco').AsInteger);

            RESTRequestPost.AddBody(TJson.ObjectToJsonString(TPessoa(vPessoa)
                                              ),ContentTypeFromString('application/json'));
            RESTRequestPost.Execute;
            RESTRequestPost.ClearBody;
          except on e: Exception do
            ShowMessage('Erro original: ' + e.Message);
          end;
        end;
        //ShowMessage('Dados salvos com sucesso!');
        TabControl1.TabIndex := 0;
        atualizaDados();
        vPessoa := nil;
      {mrCancel: begin
        ShowMessage('A??o n?o executada a pedido do usu?rio.');
      end;
  end; }
end;

procedure TForm1.btnPutClick(Sender: TObject);
var
  pPessoa: IPessoa;
begin
    with DtMdPrincipal do begin
      try
        pPessoa := TPessoa.Create();
        pPessoa.Id(FDMemTbPessoa.FieldByName('id').AsInteger);
        pPessoa.Nome(FDMemTbPessoa.FieldByName('nome').AsString);
        pPessoa.Cpf(FDMemTbPessoa.FieldByName('cpf').AsString);
        pPessoa.Endereco(FDMemTbPessoa.FieldByName('endereco').AsInteger);

        RESTRequestPut.Params.ParameterByName('id').Value :=
                                             FDMemTbPessoa.FieldByName('id').AsString;
        RESTRequestPut.AddBody(TJson.ObjectToJsonString(TPessoa(pPessoa)
                                          ),ContentTypeFromString('application/json'));
        RESTRequestPut.Execute;
        RESTRequestPut.ClearBody;
        //ShowMessage('Dados salvos com sucesso!');
        TabControl1.TabIndex := 0;
        atualizaDados();
        vPessoa := nil;
      except on e: Exception do
        ShowMessage('Erro original: ' + e.Message);
      end;
    end;
end;

procedure TForm1.btnVoltarClick(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  atualizaDados();
end;

procedure TForm1.habilitaDesabilitaMetodos(btnHabilitado: TButton );
begin
  btnPut.Enabled := false;
  btnPost.Enabled := false;
  btnDeleteMethod.Enabled := false;
  btnHabilitado.Enabled := true;
end;

function TForm1.validaDados: boolean;
begin
  //
end;

end.
