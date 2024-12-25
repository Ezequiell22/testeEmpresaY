unit comercial.model.DAO.CadTitular;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.cadTitular,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOCadTitular = class(TinterfacedObject, iModelDAOEntity<TModelEntityCadTitular>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityCadTitular;
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TModelEntityCadTitular>;
    function Delete: iModelDAOEntity<TModelEntityCadTitular>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadTitular>;
    function Get: iModelDAOEntity<TModelEntityCadTitular>;overload;
    function Insert: iModelDAOEntity<TModelEntityCadTitular>;
    function This: TModelEntityCadTitular;
    function Update: iModelDAOEntity<TModelEntityCadTitular>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadTitular>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntityCadTitular>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOCadTitular }

constructor TModelDAOCadTitular.create;
begin
  FEntity := TModelEntityCadTitular.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcFBTeste);
end;

function TModelDAOCadTitular.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadTitular>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOCadTitular.Delete: iModelDAOEntity<TModelEntityCadTitular>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('delete from cadTitular ')
    .sqlAdd(' where IDTITULAR = :IDTITULAR')
    .addParam('IDTITULAR', FEntity.IDTITULAR)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

destructor TModelDAOCadTitular.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOCadTitular.Get: iModelDAOEntity<TModelEntityCadTitular>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadTitular')
    .Open
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOCadTitular.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadTitular>;
begin

end;

function TModelDAOCadTitular.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadTitular>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadTitular')
    .sqlAdd('where IDTITULAR = :IDTITULAR ')
    .addParam('IDTITULAR', AValue)
    .Open;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOCadTitular.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOCadTitular.Insert: iModelDAOEntity<TModelEntityCadTitular>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into CadTitular')
    .sqlAdd('(IDTITULAR, IDEMPRESA, NMTITULAR, ')
    .sqlAdd('   NUCNPJCPF )')
    .sqlAdd('values ( :IDTITULAR, :IDEMPRESA, :NMTITULAR, ')
    .sqlAdd('   :NUCNPJCPF )')
    .addParam('IDTITULAR', FEntity.IDTITULAR)
    .addParam('IDEMPRESA', FEntity.IDEMPRESA)
    .addParam('NMTITULAR', FEntity.NMTITULAR)
    .addParam('NUCNPJCPF', FEntity.NUCNPJCPF)
    .execSql

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

class function TModelDAOCadTitular.New: iModelDAOEntity<TModelEntityCadTitular>;
begin
  result := Self.create;
end;

function TModelDAOCadTitular.This: TModelEntityCadTitular;
begin
  result := FEntity;
end;

function TModelDAOCadTitular.Update: iModelDAOEntity<TModelEntityCadTitular>;
begin
  result := Self;
  try

    Fquery.active(false)
    .sqlClear
    .sqlAdd('update CADTITULAR ')
    .sqlAdd('set IDEMPRESA = :IDEMPRESA, ')
    .sqlAdd('NMTITULAR = :NMTITULAR, ')
    .sqlAdd('NUCNPJCPF = :NUCNPJCPF ')
    .sqlAdd(' where IDTITULAR = :IDTITULAR')
    .addParam('IDTITULAR', FEntity.IDTITULAR)
    .addParam('IDEMPRESA', FEntity.IDEMPRESA)
    .addParam('NMTITULAR', FEntity.NMTITULAR)
    .addParam('NUCNPJCPF', FEntity.NUCNPJCPF)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar '+E.message);

  end;
end;

end.

