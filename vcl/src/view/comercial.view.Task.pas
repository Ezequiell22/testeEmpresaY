unit comercial.view.Task;

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
  Vcl.StdCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  comercial.controller.interfaces, comercial.view.utils.types;

type
  TpageTask = class(TForm)
    Edit_id: TEdit;
    Label1: TLabel;
    Edit_description: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1_priority: TComboBox;
    ComboBox_status: TComboBox;
    Button_salvar: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button_selecionaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Fcontroller: iController;
    procedure SalvarDados;
    procedure FixComboBoxPriority;
    procedure FixComboBoxStatus;
  public
    { Public declarations }
    procedure BuscaDados;
  end;

var
  pageTask: TpageTask;

implementation

uses
  comercial.controller,
  System.TypInfo;

{$R *.dfm}

procedure TpageTask.BuscaDados;
begin
  //
  // Fcontroller
  // .business
  // .Empresa
  // .idEmpresa(strTointDef(Edit_idEmpresa.Text,0))
  // .LinkDataSourceEnderecos(DataSource_enderecos)
  // .LinkDataSourceEmpresa(DataSource_empresa)
  // .SearchData;
  //
  // Edit_nome.Text := DataSource_empresa
  // .DataSet.FieldByName('nmempresa').AsString;
  //
  // Edit_cnpj.Text := DataSource_empresa
  // .DataSet.FieldByName('nucnpj').AsString;
end;

procedure TpageTask.Button_selecionaClick(Sender: TObject);
begin
  SalvarDados;

end;

procedure TpageTask.FixComboBoxPriority;
var
  I: Integer;
  EnumName: string;
begin
  ComboBox1_priority.Items.Clear;

  for I := Ord(Low(tpPriority)) to Ord(High(tpPriority)) do
  begin
    EnumName := GetEnumName(TypeInfo(tpPriority), I);
    ComboBox1_priority.Items.Add(EnumName);
  end;

  if ComboBox1_priority.Items.Count > 0 then
    ComboBox1_priority.ItemIndex := 0;
end;

procedure TpageTask.FixComboBoxStatus;
var
  I: Integer;
  EnumName: string;
begin
  ComboBox_status.Items.Clear;

  for I := Ord(Low(tpStatus)) to Ord(High(tpStatus)) do
  begin
    EnumName := GetEnumName(TypeInfo(tpStatus), I);
    ComboBox_status.Items.Add(EnumName);
  end;

  if ComboBox_status.Items.Count > 0 then
    ComboBox_status.ItemIndex := 0;

end;

procedure TpageTask.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SalvarDados
end;

procedure TpageTask.FormCreate(Sender: TObject);
begin
   FixComboBoxStatus;
   FixComboBoxPriority;
end;

procedure TpageTask.FormShow(Sender: TObject);
begin

  Fcontroller := TController.new;

end;

procedure TpageTask.SalvarDados;
begin

end;

end.
