unit api.model.DAO.task;

interface

uses
  api.model.DAO.interfaces,
  api.model.entity.task,
  Data.DB,
  api.model.resource.interfaces,
  api.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  api.model.types;

type
  TModelDAOTask = class(TinterfacedObject, iModelDAOEntity<TModelEntityTask>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityTask;
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TModelEntityTask>;
    function Delete: iModelDAOEntity<TModelEntityTask>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityTask>;
    function Get: iModelDAOEntity<TModelEntityTask>;overload;
    function Insert: iModelDAOEntity<TModelEntityTask>;
    function This: TModelEntityTask;
    function Update: iModelDAOEntity<TModelEntityTask>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityTask>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntityTask>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOTask }

constructor TModelDAOTask.create;
begin
  FEntity := TModelEntityTask.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcTeste);
end;

function TModelDAOTask.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityTask>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOTask.Delete: iModelDAOEntity<TModelEntityTask>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('delete from task ')
    .sqlAdd(' where id = :id')
    .addParam('id', FEntity.id)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

destructor TModelDAOTask.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOTask.Get: iModelDAOEntity<TModelEntityTask>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from task ')
    .Open
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOTask.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityTask>;
begin

end;

function TModelDAOTask.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityTask>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from task')
    .sqlAdd('where id = :id ')
    .addParam('id', AValue)
    .Open;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOTask.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOTask.Insert: iModelDAOEntity<TModelEntityTask>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into task')
    .sqlAdd('(id, DESCRIPTION, STATUS, PRIORITY, DATE )')
    .sqlAdd('values ')
    .sqlAdd('( :id, :DESCRIPTION, :STATUS, :PRIORITY, :DATE )')
    .addParam('ID', FEntity.ID)
    .addParam('DESCRIPTION', FEntity.DESCRIPTION)
    .addParam('STATUS', FEntity.STATUS)
    .addParam('PRIORITY', FEntity.PRIORITY)
    .addParam('DATE', NOW)
    .execSql

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

class function TModelDAOTask.New: iModelDAOEntity<TModelEntityTask>;
begin
  result := Self.create;
end;

function TModelDAOTask.This: TModelEntityTask;
begin
  result := FEntity;
end;

function TModelDAOTask.Update: iModelDAOEntity<TModelEntityTask>;
begin
  result := Self;
  try
    //ATUALIZANDO SOMENTE STATUS CONFORME DOC
    Fquery.active(false)
    .sqlClear
    .sqlAdd('update task ')
    .sqlAdd('set STATUS = :STATUS, DATE = :DATE ')
    .sqlAdd(' where ID = :ID')
    .addParam('ID', FEntity.ID)
    .addParam('STATUS', FEntity.STATUS)
    .addParam('DATE', NOW)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar '+E.message);

  end;
end;

end.
