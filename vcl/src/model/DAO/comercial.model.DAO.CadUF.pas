unit comercial.model.DAO.CadUF;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.CadUF,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOCadUF = class(TinterfacedObject, iModelDAOEntity<TModelEntityCadUF>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityCadUF;
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TModelEntityCadUF>;
    function Delete: iModelDAOEntity<TModelEntityCadUF>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadUF>;
    function Get: iModelDAOEntity<TModelEntityCadUF>;overload;
    function Insert: iModelDAOEntity<TModelEntityCadUF>;
    function This: TModelEntityCadUF;
    function Update: iModelDAOEntity<TModelEntityCadUF>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadUF>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntityCadUF>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOCadUF }

constructor TModelDAOCadUF.create;
begin
  FEntity := TModelEntityCadUF.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcFBTeste);
end;

function TModelDAOCadUF.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadUF>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOCadUF.Delete: iModelDAOEntity<TModelEntityCadUF>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('delete from CadUF ')
    .sqlAdd(' where IDUF = :IDUF')
    .addParam('IDUF', FEntity.IDUF)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

destructor TModelDAOCadUF.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOCadUF.Get: iModelDAOEntity<TModelEntityCadUF>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadUF')
    .Open
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOCadUF.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadUF>;
begin

end;

function TModelDAOCadUF.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadUF>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadUF')
    .sqlAdd('where IDUF = :IDUF ')
    .addParam('IDUF', AValue)
    .Open;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOCadUF.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOCadUF.Insert: iModelDAOEntity<TModelEntityCadUF>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into CADUF')
    .sqlAdd('(IDUF, NMESTADO, SGESTADO )')
      .sqlAdd('values ( :IDUF, :NMESTADO, :SGESTADO )')
      .addParam('IDUF', FEntity.IDUF)
      .addParam('NMESTADO', FEntity.NMESTADO)
      .addParam('SGESTADO', FEntity.SGESTADO)
      .execSql

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

class function TModelDAOCadUF.New: iModelDAOEntity<TModelEntityCadUF>;
begin
  result := Self.create;
end;

function TModelDAOCadUF.This: TModelEntityCadUF;
begin
  result := FEntity;
end;

function TModelDAOCadUF.Update: iModelDAOEntity<TModelEntityCadUF>;
begin
  result := Self;
  try

    Fquery.active(false)
    .sqlClear
    .sqlAdd('update CADUF ')
    .sqlAdd('set NMESTADO = :NMESTADO, ')
    .sqlAdd('SGESTADO = :SGESTADO ')
    .sqlAdd(' where IDUF = :IDUF')
    .addParam('IDUF', FEntity.IDUF)
    .addParam('NMESTADO', FEntity.NMESTADO)
    .addParam('SGESTADO', FEntity.SGESTADO)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar '+E.message);

  end;
end;

end.
