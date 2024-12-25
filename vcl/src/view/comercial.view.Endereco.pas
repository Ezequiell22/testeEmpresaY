unit comercial.view.Endereco;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  comercial.controller.interfaces;

type
  TpageEndereco = class(TForm)
    lbl_codigo: TLabel;
    lbl_empresa: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit_nucep: TEdit;
    lbl_cep: TLabel;
    Edit_idEndereco: TEdit;
    Label3: TLabel;
    Edit_nmendereco: TEdit;
    Label4: TLabel;
    Edit_nuendereco: TEdit;
    Label5: TLabel;
    Button_salvar: TButton;
    DataSource1: TDataSource;
    ComboBox_uf: TComboBox;
    ComboBox_cidade: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ComboBox_ufSelect(Sender: TObject);
    procedure ComboBox_cidadeSelect(Sender: TObject);
    procedure Button_salvarClick(Sender: TObject);
  private
    { Private declarations }
    Fcontroller : iController;
    procedure preencheCampos;
  public
    { Public declarations }
    procedure buscarDados;
    var
      IdEmpresa, idTitular : integer;
  end;

var
  pageEndereco: TpageEndereco;

implementation

uses
     comercial.controller;

{$R *.dfm}

procedure TpageEndereco.buscarDados;
begin
  Fcontroller
    .business
      .Endereco
        .idEmpresa(IdEmpresa)
        .idEndereco(StrToIntDef(Edit_idEndereco.Text, 0))
        .idTitular(idTitular)
        .LinkDataSource(DataSource1)
        .SearchData;

   preencheCampos;
end;

procedure TpageEndereco.Button_salvarClick(Sender: TObject);
begin
  Fcontroller
  .business
    .Endereco
    .idEmpresa(IdEmpresa)
    .idTitular(idTitular)
    .idEndereco(strTointDef(Edit_idEndereco.Text,0 ))
    .nmEndereco(Edit_nmendereco.Text)
    .nuEndereco(Edit_nuendereco.Text)
    .nuCep(Edit_nucep.Text)
    .saveData;

    ShowMessage('Dados salvos com sucesso!');
    Self.Close;
end;

procedure TpageEndereco.ComboBox_cidadeSelect(Sender: TObject);
begin
  Fcontroller
  .business
    .Endereco
      .idCidade( ComboBox_cidade.Text )
end;

procedure TpageEndereco.ComboBox_ufSelect(Sender: TObject);
begin
  Fcontroller
    .business
      .Endereco
        .idUf( ComboBox_uf.Text )
        .AbasteceComboBoxCidades(ComboBox_cidade)
end;

procedure TpageEndereco.FormShow(Sender: TObject);
begin
   Fcontroller := Tcontroller.new;
   Fcontroller
      .business
      .Endereco
      .AbasteceComboBoxUFs(ComboBox_uf);

   buscarDados;
end;

procedure TpageEndereco.preencheCampos;
begin
  if strTointDef( Edit_idEndereco.Text, 0) = 0 then
    exit;
  Edit_nmendereco.Text :=
  DataSource1.DataSet.FieldByName('nmendereco').AsString;
  Edit_nuendereco.Text :=
  DataSource1.DataSet.FieldByName('nuendereco').AsString;

  Fcontroller
  .business
    .Endereco
    .AbasteceComboBoxUFs(ComboBox_uf)
    .AbasteceComboBoxCidades(ComboBox_cidade);

  Edit_nucep.Text :=
  DataSource1.DataSet.FieldByName('nucep').AsString;
end;

end.
