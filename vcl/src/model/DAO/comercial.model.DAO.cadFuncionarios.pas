unit comercial.model.DAO.cadFuncionarios;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.cadFuncionarios,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOcadFuncionarios = class(TinterfacedObject, iModelDAOEntity<TModelEntitycadFuncionarios>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntitycadFuncionarios;
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TModelEntitycadFuncionarios>;
    function Delete: iModelDAOEntity<TModelEntitycadFuncionarios>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntitycadFuncionarios>;
    function Get: iModelDAOEntity<TModelEntitycadFuncionarios>;overload;
    function Insert: iModelDAOEntity<TModelEntitycadFuncionarios>;
    function This: TModelEntitycadFuncionarios;
    function Update: iModelDAOEntity<TModelEntitycadFuncionarios>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntitycadFuncionarios>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntitycadFuncionarios>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOcadFuncionarios }

constructor TModelDAOcadFuncionarios.create;
begin
  FEntity := TModelEntitycadFuncionarios.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcFBTeste);
end;

function TModelDAOcadFuncionarios.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOcadFuncionarios.Delete: iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('delete from CADFUNCIONARIOS ')
    .sqlAdd(' where IDFUNCIONARIO = :IDFUNCIONARIO')
    .addParam('IDFUNCIONARIO', FEntity.IDFUNCIONARIO)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

destructor TModelDAOcadFuncionarios.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOcadFuncionarios.Get: iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CADFUNCIONARIOS')
    .Open
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOcadFuncionarios.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntitycadFuncionarios>;
begin

end;

function TModelDAOcadFuncionarios.GetbyId(AValue: integer): iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CADFUNCIONARIOS')
    .sqlAdd('where IDFUNCIONARIO = :IDFUNCIONARIO ')
    .addParam('IDFUNCIONARIO', AValue)
    .Open;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOcadFuncionarios.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOcadFuncionarios.Insert: iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into CADFUNCIONARIOS')
    .sqlAdd('(IDFUNCIONARIO, NMFUNCIONARIO )')
      .sqlAdd('values ( :IDFUNCIONARIO, :NMFUNCIONARIO )')
      .addParam('IDFUNCIONARIO', FEntity.IDFUNCIONARIO)
      .addParam('NMFUNCIONARIO', FEntity.NMFUNCIONARIO)
      .execSql

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

class function TModelDAOcadFuncionarios.New: iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  result := Self.create;
end;

function TModelDAOcadFuncionarios.This: TModelEntitycadFuncionarios;
begin
  result := FEntity;
end;

function TModelDAOcadFuncionarios.Update: iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  result := Self;
  try

    Fquery.active(false)
    .sqlClear
    .sqlAdd('update CADFUNCIONARIOS ')
    .sqlAdd('set DTNASCIMENTO = :DTNASCIMENTO ')
    .sqlAdd(' where IDFUNCIONARIO = :IDFUNCIONARIO')
    .addParam('IDFUNCIONARIO', FEntity.IDFUNCIONARIO)
    .addParam('DTNASCIMENTO', FEntity.DTNASCIMENTO)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar '+E.message);

  end;
end;

end.
