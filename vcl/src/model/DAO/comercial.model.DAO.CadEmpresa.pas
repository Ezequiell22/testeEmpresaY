unit comercial.model.DAO.CadEmpresa;


interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.cadEmpresa,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOcadEmpresa = class(TinterfacedObject, iModelDAOEntity<TModelEntitycadEmpresa>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntitycadEmpresa;
    procedure afterScroll(DataSet: TDataSet);
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TModelEntitycadEmpresa>;
    function Delete: iModelDAOEntity<TModelEntitycadEmpresa>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntitycadEmpresa>;
    function Get: iModelDAOEntity<TModelEntitycadEmpresa>;overload;
    function Insert: iModelDAOEntity<TModelEntitycadEmpresa>;
    function This: TModelEntitycadEmpresa;
    function Update: iModelDAOEntity<TModelEntitycadEmpresa>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntitycadEmpresa>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntitycadEmpresa>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOcadEmpresa }

procedure TModelDAOcadEmpresa.afterScroll(DataSet: TDataSet);
begin
  FEntity.IDEMPRESA(DataSet.FieldByName('IDEMPRESA').asInteger);
  FEntity.NMEMPRESA(DataSet.FieldByName('NMEMPRESA').asString);
  FEntity.NUCNPJ(DataSet.FieldByName('NUCNPJ').asString);
  FEntity.STATIVO(DataSet.FieldByName('STATIVO').asString);
end;

constructor TModelDAOcadEmpresa.create;
begin
  FEntity := TModelEntitycadEmpresa.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcFBTeste);
  Fquery.DataSet.afterScroll := afterScroll
end;

function TModelDAOcadEmpresa.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntitycadEmpresa>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOcadEmpresa.Delete: iModelDAOEntity<TModelEntitycadEmpresa>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('update CADEMPRESA ')
    .sqlAdd(' set STEXCLUIDO = :STEXCLUIDO,')
    .sqlAdd(' DTEXCLUIDO = :DTEXCLUIDO,')
    .sqlAdd(' STATIVO = :STATIVO')
    .sqlAdd(' where IDEMPRESA = :IDEMPRESA')
    .addParam('IDEMPRESA', FEntity.IDEMPRESA)
    .addParam('STEXCLUIDO', 'S')
    .addParam('STATIVO', 'N')
    .addParam('DTEXCLUIDO', NOW)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);
  end;
end;

destructor TModelDAOcadEmpresa.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOcadEmpresa.Get: iModelDAOEntity<TModelEntitycadEmpresa>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CADEMPRESA')
    .Open;
    Fquery.DataSet.First;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOcadEmpresa.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntitycadEmpresa>;
begin

end;

function TModelDAOcadEmpresa.GetbyId(AValue: integer): iModelDAOEntity<TModelEntitycadEmpresa>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CADEMPRESA')
    .sqlAdd('where IDEMPRESA = :IDEMPRESA ')
    .addParam('IDEMPRESA', AValue)
    .Open;

    Fquery.DataSet.First;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOcadEmpresa.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOcadEmpresa.Insert: iModelDAOEntity<TModelEntitycadEmpresa>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into CADEMPRESA')
    .sqlAdd('(IDEMPRESA, NMEMPRESA, NUCNPJ, STATIVO )')
    .sqlAdd('values ( :IDEMPRESA, :NMEMPRESA, :NUCNPJ, :STATIVO )')
    .addParam('IDEMPRESA', FEntity.IDEMPRESA)
    .addParam('NMEMPRESA', FEntity.NMEMPRESA)
    .addParam('NUCNPJ', FEntity.NUCNPJ)
    .addParam('STATIVO', 'S')
    .execSql

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

class function TModelDAOcadEmpresa.New: iModelDAOEntity<TModelEntitycadEmpresa>;
begin
  result := Self.create;
end;

function TModelDAOcadEmpresa.This: TModelEntitycadEmpresa;
begin
  result := FEntity;
end;

function TModelDAOcadEmpresa.Update: iModelDAOEntity<TModelEntitycadEmpresa>;
begin
  result := Self;
  try

    Fquery.active(false)
    .sqlClear
    .sqlAdd('update CADEMPRESA ')
    .sqlAdd('set NUCNPJ = :NUCNPJ, ')
    .sqlAdd(' NMEMPRESA = :NMEMPRESA, ')
    .sqlAdd(' STATIVO = :STATIVO ')
    .sqlAdd(' where IDEMPRESA = :IDEMPRESA')
    .addParam('IDEMPRESA', FEntity.IDEMPRESA)
    .addParam('NUCNPJ', FEntity.NUCNPJ)
    .addParam('NMEMPRESA', FEntity.NMEMPRESA)
    .addParam('STATIVO', FEntity.STATIVO)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar '+E.message);

  end;
end;

end.
