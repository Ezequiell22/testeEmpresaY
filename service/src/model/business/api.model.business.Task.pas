unit api.model.business.Task;

interface

uses
  api.model.business.interfaces,
  Data.DB,
  api.model.resource.interfaces,
  api.model.resource.impl.queryFiredac,
  api.model.types.Db,
  api.model.DAO.interfaces,
  api.model.entity.task,
  System.JSON,
  Variants;

type
  TModelBusinessTask = class(TInterfacedObject, iModelBusinessTask)
  private
    FQueryAux: iQuery;
    FID: integer;
    FStatus : string;
    FDESCRIPTION: String;
    FPRIORITY: integer; // 0 a 10
    FStatusCode : integer;
    FDataResult : TJsonObject;
    Ftask : iModelDAOEntity<TModelEntityTask>;
    function isNew : boolean;
    function newId : integer;
    procedure ValidadeBodyInsert(aBody : TJSONObject);
    procedure ValidadeBodyUpdate(aBody : TJSONObject);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessTask;
    function GetAllData: TjsonObject;
    function DeleteDataById( aId : string) : TjsonObject;
    function InsertData( aBody : TJSONObject) : TjsonObject;
    function UpdateData( aBody : TJSONObject; aID : string) : TjsonObject;
    function getInfos : TJsonObJect;
  end;

implementation

uses
  api.model.DAO.task,
  Generics.Collections,
  System.SysUtils;

{ TModelBusinessTask }


function TModelBusinessTask.DeleteDataById(aId : string ): TJSONObject;
begin

  FiD := aId.ToInteger;
  FDataResult := TJSONObject.Create;

  try
    Ftask
    .This
      .id(FiD)
      .&End
    .Delete;
  except
  on e:exception do
  begin
    FDataResult.AddPair('data', e.Message);
    FDataResult.AddPair('statusCode', 500);
    exit;
  end;
  end;

  FDataResult.AddPair('data', 'Data deleted');
  FDataResult.AddPair('statusCode', 200);
  result := FDataResult
end;


constructor TModelBusinessTask.Create;
begin
  FQueryAux := TModelResourceQueryFiredac.New(tcTeste);
  FTask := TmodelDaoTask.New;
end;

destructor TModelBusinessTask.Destroy;
begin

  inherited;
end;

//function TModelBusinessTask.fixResultData(aStatusCode: integer;
//  aData: variant): TJsonObject;
//begin
//  FDataResult.AddPair('StatusCode' , aStatusCode);
//  case vartype(aData) of
//    varObject:
//    begin
//
//      FDataResult.AddPair('data' , TJsonObject(aData));
//    end;
//    varString :
//      FDataResult.AddPair('data' , '');
//
//
//  end;
//
//end;

function TModelBusinessTask.isNew: boolean;
begin
    FQueryAux
      .active(false)
      .sqlClear
      .sqlAdd('select * from task')
      .sqlAdd('where id = :id')
      .addParam('id', FID)
      .open;

    result := FQueryAux.DataSet.IsEmpty;
end;

class function TModelBusinessTask.New: iModelBusinessTask;
begin
  result := Self.Create;
end;

function TModelBusinessTask.newId: integer;
begin
  FQueryAux
    .active(false)
    .sqlClear
      .sqlAdd('SELECT ISNULL(MAX(id), 0) + 1 AS NewID ')
      .sqlAdd('from TASK')
      .open;

  result := FQueryAux.DataSet.FieldByName('NewID').AsInteger;
end;

function TModelBusinessTask.UpdateData(aBody: TJSONObject;
  aID: string): TjsonObject;
begin
  FDataResult := TJsonObject.Create;
  fid := aId.ToInteger;

  if isNew then
    raise Exception.Create('Invalid id');

  ValidadeBodyUpdate(aBody);

  Ftask
  .This
    .id(fid)
    .DESCRIPTION(FDESCRIPTION)
    .STATUS(FStatus)
    .PRIORITY(FPRIORITY)
    .&end
    .Update;

    FDataResult.AddPair('data', 'Data updated');
    FDataResult.AddPair('statusCode', 200);

  result := FDataResult;

end;

procedure TModelBusinessTask.ValidadeBodyInsert(aBody : TJSONObject);
begin
  try
    if not Assigned(aBody) then
      raise Exception.Create('Não existem dados para inserir');

    fDescription := aBody.GetValue<string>('description');
    fpriority := aBody.GetValue<Integer>('priority');

  except
    on E:Exception do
    begin
      FStatusCode := 400;

    end;

  end;
end;

procedure TModelBusinessTask.ValidadeBodyUpdate(aBody: TJSONObject);
begin

  if not Assigned(aBody) then
    raise Exception.Create('Não existem dados para atualizar');

  if not aBody.TryGetValue<string>('description', FDESCRIPTION) then
    FDESCRIPTION := '';

  if not aBody.TryGetValue<Integer>('priority', Fpriority) then
    Fpriority := 0;

  FStatus := abody.GetValue<string>('status');

end;

function TModelBusinessTask.InsertData(aBody : TJSONObject)
: TJsonObject;
begin
  FDataResult := TJsonObject.Create;

  FStatusCode := 201;
  ValidadeBodyInsert(abody);

  Ftask
  .This
    .id(newId)
    .DESCRIPTION(FDESCRIPTION)
    .PRIORITY(FPRIORITY)
    .STATUS('created')
    .&end
    .Insert;

    FDataResult.AddPair('data', 'Data inserted');
    FDataResult.AddPair('statusCode', 201);

  result := FDataResult
end;

function TModelBusinessTask.GetAllData: TJsonObject;
var
  JsonArray: TJSONArray;
  JsonObject: TJSONObject;
begin
  JsonArray := TJSONArray.Create;
  FDataResult := TJsonObject.Create;
  try

    Ftask.GET;
    var DataSetTemp := Ftask.GetDataSet;

    DataSetTemp.First;
    while not DataSetTemp.Eof do
    begin
      JsonObject := TJSONObject.Create;
      try
        JsonObject.AddPair('id', DataSetTemp.FieldByName('id').AsString);
        JsonObject.AddPair('description', DataSetTemp.FieldByName('description').AsString);
        JsonObject.AddPair('status', DataSetTemp.FieldByName('status').AsString);
        JsonObject.AddPair('priority', DataSetTemp.FieldByName('priority').AsString);
        JsonObject.AddPair('dateCreated',
        formatDateTime('DD/MM/YYYY'  ,DataSetTemp.FieldByName('dateCreated').AsDateTime));

        JsonArray.AddElement(JsonObject);
      except
        JsonObject.Free;
        raise;
      end;

      DataSetTemp.Next;
    end;

    FDataResult.AddPair('data', JsonArray);
    FDataResult.AddPair('statusCode', 200);

    Result := FDataResult;
  except
    JsonArray.Free;
    raise;
  end;
end;


function TModelBusinessTask.getInfos: TJsonObJect;
var JsonObject: TJSONObject;
begin
  FDataResult := TJsonObject.Create;

  FQueryAux
  .active(false)
  .sqlClear
  .sqlAdd('SELECT ')
  .sqlAdd(' qtdTotal.qtdTotal,')
  .sqlAdd('media.media,')
  .sqlAdd('qtdConcluida.qtdConcluida ')
  .sqlAdd('FROM ')
  .sqlAdd('    (SELECT COUNT(id) AS qtdTotal  ')
  .sqlAdd('FROM task) AS qtdTotal   ')
  .sqlAdd('CROSS JOIN  ')
  .sqlAdd('    (SELECT AVG(priority) AS media ')
  .sqlAdd('	FROM task WHERE UPPER(status) ')
  .sqlAdd(' <> ''PENDENT'') AS media  ')
  .sqlAdd('CROSS JOIN      ')
  .sqlAdd('   (SELECT COUNT(id) AS qtdConcluida  ')
  .sqlAdd('   FROM task ')
  .sqlAdd('   WHERE UPPER(status) = ''DONE'' ')
  .sqlAdd(' AND datecreated <= GETDATE() - 1) ')
  .sqlAdd('AS qtdConcluida;')
  .open;

  var fdataSetTemp := FQueryAux.DataSet;
    JsonObject := TJSONObject.Create;
    JsonObject.AddPair('Total de tarefas',
    fdataSetTemp.FieldByName('qtdTotal').asinteger);
    JsonObject.AddPair('Média de prioridade das tarefas pendentes',
    fdataSetTemp.FieldByName('media').AsCurrency);
    JsonObject.AddPair('Quantidade de tarefas concluídas nos últimos 7 dias',
     fdataSetTemp.FieldByName('qtdConcluida').asinteger);


  FDataResult.AddPair('data', JsonObject);
  FDataResult.AddPair('statusCode', 200);
  result := FDataResult;

end;

end.
