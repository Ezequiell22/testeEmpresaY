unit comercial.model.DAO.CadCidade;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.CadCidade,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOCadCidade = class(TinterfacedObject, iModelDAOEntity<TModelEntityCadCidade>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityCadCidade;
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TModelEntityCadCidade>;
    function Delete: iModelDAOEntity<TModelEntityCadCidade>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadCidade>;
    function Get: iModelDAOEntity<TModelEntityCadCidade>;overload;
    function Insert: iModelDAOEntity<TModelEntityCadCidade>;
    function This: TModelEntityCadCidade;
    function Update: iModelDAOEntity<TModelEntityCadCidade>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadCidade>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntityCadCidade>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOCadCidade }

constructor TModelDAOCadCidade.create;
begin
  FEntity := TModelEntityCadCidade.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcFBTeste);
end;

function TModelDAOCadCidade.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadCidade>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOCadCidade.Delete: iModelDAOEntity<TModelEntityCadCidade>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('delete from CadCidade ')
    .sqlAdd(' where IDCIDADE = :IDCIDADE')
    .addParam('IDCIDADE', FEntity.IDCIDADE)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

destructor TModelDAOCadCidade.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOCadCidade.Get: iModelDAOEntity<TModelEntityCadCidade>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadCidade')
    .Open
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOCadCidade.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadCidade>;
begin

end;

function TModelDAOCadCidade.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadCidade>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadCidade')
    .sqlAdd('where IDCIDADE = :IDCIDADE ')
    .addParam('IDCIDADE', AValue)
    .Open;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOCadCidade.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOCadCidade.Insert: iModelDAOEntity<TModelEntityCadCidade>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into CADCIDADE')
    .sqlAdd('(IDCIDADE, NMCIDADE, IDUF, ')
    .sqlAdd('   NOIBGE )')
    .sqlAdd('values ( :IDCIDADE, :NMCIDADE, :IDUF, ')
    .sqlAdd('   :NOIBGE )')
    .addParam('IDENDERECO', FEntity.IDCIDADE)
    .addParam('NMCIDADE', FEntity.NMCIDADE)
    .addParam('IDUF', FEntity.IDUF)
    .addParam('NOIBGE', FEntity.NOIBGE)
    .execSql

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

class function TModelDAOCadCidade.New: iModelDAOEntity<TModelEntityCadCidade>;
begin
  result := Self.create;
end;

function TModelDAOCadCidade.This: TModelEntityCadCidade;
begin
  result := FEntity;
end;

function TModelDAOCadCidade.Update: iModelDAOEntity<TModelEntityCadCidade>;
begin
  result := Self;
  try

    Fquery.active(false)
    .sqlClear
    .sqlAdd('update CADCIDADE ')
    .sqlAdd('set NMCIDADE = :NMCIDADE, ')
    .sqlAdd('IDUF = :IDUF, ')
    .sqlAdd('NOIBGE = :NOIBGE ')
    .sqlAdd(' where IDCIDADE = :IDCIDADE')
    .addParam('IDCIDADE', FEntity.IDCIDADE)
    .addParam('NMCIDADE', FEntity.NMCIDADE)
    .addParam('IDUF', FEntity.IDUF)
    .addParam('NOIBGE', FEntity.NOIBGE)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar '+E.message);

  end;
end;

end.

