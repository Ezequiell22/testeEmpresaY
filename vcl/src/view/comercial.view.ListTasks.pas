unit comercial.view.ListTasks;

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
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  comercial.controller.interfaces;

type
  TpageListTasks = class(TForm)
    Button_buscar: TButton;
    Button_novo: TButton;
    Button_deletar: TButton;
    Button_editar: TButton;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit_allQtd: TEdit;
    Edit_avgPriority: TEdit;
    Edit3_qtdDone: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Button_buscarClick(Sender: TObject);
    procedure Button_novoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button_editarClick(Sender: TObject);
    procedure Button_deletarClick(Sender: TObject);
  private
    Fcontroller: iController;
    procedure Editar;
  public
    { Public declarations }
  end;

var
  pageListTasks: TpageListTasks;

implementation

uses
  comercial.controller,
  comercial.view.Task,
  comercial.view.utils.types,
  System.TypInfo;

{$R *.dfm}

procedure TpageListTasks.Button_buscarClick(Sender: TObject);
begin
  Fcontroller.business.ListTasks.DisplayTasks(StringGrid1);
  FController.business
    .ListTasks
      .DisplayInfos(Edit_allQtd, Edit_avgPriority, Edit3_qtdDone);
end;

procedure TpageListTasks.Button_deletarClick(Sender: TObject);
var
  CellValue: string;
begin
  CellValue := StringGrid1.Cells[0, StringGrid1.Row];
  if CellValue = EmptyStr then
    exit;

  Fcontroller.business.Task.Id(CellValue.ToInteger).DeleteTask;

  Button_buscarClick(Sender);

  showMessage('Tarefa removida');
end;

procedure TpageListTasks.Button_editarClick(Sender: TObject);
begin
  Editar
end;

procedure TpageListTasks.Button_novoClick(Sender: TObject);
begin
  pageTask := TpageTask.Create(self);
  try
    pageTask.Caption := 'Nova Tarefa';
    pageTask.Edit_id.ReadOnly := false;
    pageTask.ShowModal;
  finally
    pageTask.Free;
  end;

  Button_buscarClick(Sender);
end;

procedure TpageListTasks.DBGrid1DblClick(Sender: TObject);
begin
  Editar
end;

procedure TpageListTasks.Editar;
var
  Id, description, priority, status: string;
begin
  Id := StringGrid1.Cells[0, StringGrid1.Row];
  description := StringGrid1.Cells[1, StringGrid1.Row];
  priority := StringGrid1.Cells[3, StringGrid1.Row];
  status := StringGrid1.Cells[2, StringGrid1.Row];

  if Id = EmptyStr then
    exit;

  pageTask := TpageTask.Create(self);
  try
    pageTask.Caption := 'Editar Tarefa';
    pageTask.Edit_id.ReadOnly := true;
    pageTask.Edit_id.Text := Id;
    pageTask.Edit_description.Text := description;
    pageTask.ComboBox1_priority.ItemIndex :=
    GetEnumValue(TypeInfo(TpPriority),
      priority);
    pageTask.ComboBox_status.ItemIndex :=
      GetEnumValue(TypeInfo(TpStatus), status);
    pageTask.ShowModal;
  finally
    pageTask.Free;
  end;

  Button_buscarClick(self);
end;

procedure TpageListTasks.FormShow(Sender: TObject);
begin

  Fcontroller := TController.new;
  Button_buscarClick(Sender);
end;

end.
