unit comercial.model.DAO.CadEnderecos;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.CadEnderecos,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOCadEnderecos = class(TinterfacedObject, iModelDAOEntity<TModelEntityCadEnderecos>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityCadEnderecos;
    procedure afterScroll(DataSet: TDataSet);
    function FoundValue(  AFieldsWhere: TDictionary<string, Variant>) : boolean;
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TModelEntityCadEnderecos>;
    function Delete: iModelDAOEntity<TModelEntityCadEnderecos>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadEnderecos>;
    function Get: iModelDAOEntity<TModelEntityCadEnderecos>;overload;
    function Insert: iModelDAOEntity<TModelEntityCadEnderecos>;
    function This: TModelEntityCadEnderecos;
    function Update: iModelDAOEntity<TModelEntityCadEnderecos>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadEnderecos>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntityCadEnderecos>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOCadEnderecos }

procedure TModelDAOCadEnderecos.afterScroll(DataSet: TDataSet);
begin
  FEntity.IDENDERECO(DataSet.FieldByName('IDENDERECO').asInteger);
  FEntity.IDEMPRESA(DataSet.FieldByName('IDEMPRESA').asInteger);
  FEntity.IDTITULAR(DataSet.FieldByName('IDTITULAR').asInteger);
  FEntity.NMENDERECO(DataSet.FieldByName('NMENDERECO').asString);
  FEntity.NUENDERECO(DataSet.FieldByName('NUENDERECO').asString);
  FEntity.STATIVO(DataSet.FieldByName('STATIVO').asString);
  FEntity.NUCEP(DataSet.FieldByName('NUCEP').asString);
  FEntity.IDUF(DataSet.FieldByName('IDUF').asinteger);
  FEntity.idcidade(DataSet.FieldByName('idcidade').asinteger);
end;

constructor TModelDAOCadEnderecos.create;
begin
  FEntity := TModelEntityCadEnderecos.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcFBTeste);
  Fquery.DataSet.AfterScroll := afterScroll;
end;

function TModelDAOCadEnderecos.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOCadEnderecos.Delete: iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('update CadEnderecos ')
    .sqlAdd(' set STEXCLUIDO = :STEXCLUIDO,')
    .sqlAdd(' DTEXCLUIDO = :DTEXCLUIDO,')
    .sqlAdd(' STATIVO = :STATIVO')
    .sqlAdd(' where IDENDERECO = :IDENDERECO')
    .addParam('IDENDERECO', FEntity.IDENDERECO)
    .addParam('STEXCLUIDO', 'S')
    .addParam('STATIVO', 'N')
    .addParam('DTEXCLUIDO', NOW)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);
  end;
end;

destructor TModelDAOCadEnderecos.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOCadEnderecos.FoundValue(  AFieldsWhere: TDictionary<string, Variant> ): boolean;
var key : string;
begin
    { verificar se existe alguma chave com valor}
  result := False;
   for key in AFieldsWhere.Keys do
     begin
        if UpperCase( AFieldsWhere.Items[Key]) <> '0' then
        begin
            result := True;
            break;
        end;
     end;

end;

function TModelDAOCadEnderecos.Get: iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadEnderecos')
    .Open;

    Fquery.DataSet.First;
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOCadEnderecos.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadEnderecos>;
 var key  : string;
   i : integer;
   found : boolean;
begin
  result := self;

//  if not FoundValue(AFieldsWhere) then
//    exit;

  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from cadEnderecos ');

    i := 0;

     for key in AFieldsWhere.Keys do
     begin

       var str : string;

        if i = 0 then
          str := ' WHERE ' +UpperCase(Key)+ ' = :'+ UpperCase(Key)
        else
          str := ' AND ' +UpperCase(Key)+ ' = :'+ UpperCase(Key);

         Fquery.sqlAdd(str);
         Fquery.addParam(UpperCase(Key),  UpperCase( AFieldsWhere.Items[Key]));

       inc(i);
     end;

    Fquery.Open;
    Fquery.DataSet.First;
  except
    on E: Exception do
      raise Exception.Create(E.message);
  end;

end;

function TModelDAOCadEnderecos.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from CadEnderecos')
    .sqlAdd('where IDENDERECO = :IDENDERECO ')
    .addParam('IDENDERECO', AValue)
    .Open;

    Fquery.DataSet.First;
  except
    on E: Exception do
      raise Exception.create(E.message);
  end;
end;

function TModelDAOCadEnderecos.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOCadEnderecos.Insert: iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into CadEnderecos')
    .sqlAdd('(IDENDERECO, IDTITULAR, IDEMPRESA, ')
    .sqlAdd('   NMENDERECO, NUENDERECO, STATIVO , ')
    .sqlAdd(' NUCEP,IDUF,idcidade )')
    .sqlAdd('values ( :IDENDERECO, :IDTITULAR, :IDEMPRESA, ')
    .sqlAdd('   :NMENDERECO, :NUENDERECO, :STATIVO ,')
    .sqlAdd(' :NUCEP, :IDUF, :idcidade )')
    .addParam('IDENDERECO', FEntity.IDENDERECO)
    .addParam('IDTITULAR', FEntity.IDTITULAR)
    .addParam('IDEMPRESA', FEntity.IDEMPRESA)
    .addParam('NMENDERECO', FEntity.NMENDERECO)
    .addParam('NUENDERECO', FEntity.NUENDERECO)
    .addParam('STATIVO', FEntity.STATIVO)
    .addParam('NUCEP', FEntity.NUCEP)
    .addParam('IDUF', FEntity.IDUF)
    .addParam('idcidade', FEntity.idcidade)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);
  end;
end;

class function TModelDAOCadEnderecos.New: iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  result := Self.create;
end;

function TModelDAOCadEnderecos.This: TModelEntityCadEnderecos;
begin
  result := FEntity;
end;

function TModelDAOCadEnderecos.Update: iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('update CadEnderecos ')
    .sqlAdd('set IDTITULAR = :IDTITULAR, ')
    .sqlAdd('IDEMPRESA = :IDEMPRESA, ')
    .sqlAdd('NMENDERECO = :NMENDERECO, ')
    .sqlAdd('NUENDERECO = :NUENDERECO, ')
    .sqlAdd('NUCEP = :NUCEP, ')
    .sqlAdd('IDUF = :IDUF, ')
    .sqlAdd('IDCIDADE = :IDCIDADE ')
    .sqlAdd('where IDENDERECO = :IDENDERECO')
    .addParam('IDENDERECO', FEntity.IDENDERECO)
    .addParam('IDTITULAR', FEntity.IDTITULAR)
    .addParam('IDEMPRESA', FEntity.IDEMPRESA)
    .addParam('NMENDERECO', FEntity.NMENDERECO)
    .addParam('NUENDERECO', FEntity.NUENDERECO)
    .addParam('NUCEP', FEntity.NUCEP)
    .addParam('IDUF', FEntity.IDUF)
    .addParam('IDCIDADE', FEntity.IDCIDADE)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar '+E.message);
  end;
end;

end.
