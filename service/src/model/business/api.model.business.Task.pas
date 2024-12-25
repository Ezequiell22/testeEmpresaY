unit api.model.business.Task;

interface

uses
  api.model.business.interfaces,
  Data.DB,
  api.model.resource.interfaces,
  api.model.resource.impl.queryFiredac,
  api.model.types,
  api.model.DAO.interfaces,
  api.model.entity.Task,
  System.JSON,
  Variants;

type
  TModelBusinessTask = class(TInterfacedObject, iModelBusinessTask)
  private
    FQueryAux: iQuery;
    FID: integer;
    FStatus: tpStatus;
    FDESCRIPTION: String;
    FPRIORITY: TpPriority;
    FStatusCode: integer;
    FDataResult: TJsonObject;
    Ftask: iModelDAOEntity<TModelEntityTask>;
    function isNew: boolean;
    function newId: integer;
    procedure ValidadeBodyInsert(aBody: TJsonObject);
    procedure ValidadeBodyUpdate(aBody: TJsonObject);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessTask;
    function GetAllData: TJsonObject;
    function DeleteDataById(aId: string): TJsonObject;
    function InsertData(aBody: TJsonObject): TJsonObject;
    function UpdateData(aBody: TJsonObject; aId: string): TJsonObject;
    function getInfos: TJsonObject;
  end;

implementation

uses
  api.model.DAO.Task,
  System.SysUtils,
  System.TypInfo;

{ TModelBusinessTask }

function TModelBusinessTask.DeleteDataById(aId: string): TJsonObject;
begin

  FID := aId.ToInteger;
  FDataResult := TJsonObject.Create;

  try
    Ftask.This.id(FID).&End.Delete;
  except
    on e: exception do
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
  Ftask := TmodelDaoTask.New;
end;

destructor TModelBusinessTask.Destroy;
begin

  inherited;
end;

function TModelBusinessTask.isNew: boolean;
begin
  FQueryAux.active(false).sqlClear.sqlAdd('select * from task')
    .sqlAdd('where id = :id').addParam('id', FID).open;

  result := FQueryAux.DataSet.IsEmpty;
end;

class function TModelBusinessTask.New: iModelBusinessTask;
begin
  result := Self.Create;
end;

function TModelBusinessTask.newId: integer;
begin
  FQueryAux.active(false).sqlClear.sqlAdd
    ('SELECT ISNULL(MAX(id), 0) + 1 AS NewID ').sqlAdd('from TASK').open;

  result := FQueryAux.DataSet.FieldByName('NewID').AsInteger;
end;

function TModelBusinessTask.UpdateData(aBody: TJsonObject; aId: string)
  : TJsonObject;
begin
  FDataResult := TJsonObject.Create;
  FID := aId.ToInteger;

  if isNew then
    raise exception.Create('Invalid id');

  ValidadeBodyUpdate(aBody);

  Ftask.This.id(FID).DESCRIPTION(FDESCRIPTION).STATUS(ord(FStatus))
    .PRIORITY(ord(FPRIORITY)).&End.Update;

  FDataResult.AddPair('data', 'Data updated');
  FDataResult.AddPair('statusCode', 200);

  result := FDataResult;

end;

procedure TModelBusinessTask.ValidadeBodyInsert(aBody: TJsonObject);
begin
  try
    if not Assigned(aBody) then
      raise exception.Create('Não existem dados para inserir');

    FDESCRIPTION := aBody.GetValue<string>('description');
    FPRIORITY := TpPriority(aBody.GetValue<integer>('priority'));

  except
    on e: exception do
    begin
      FStatusCode := 400;
      raise exception.Create('Error ' + e.Message);
    end;

  end;
end;

procedure TModelBusinessTask.ValidadeBodyUpdate(aBody: TJsonObject);
begin

  if not Assigned(aBody) then
    raise exception.Create('Não existem dados para atualizar');

  if not aBody.TryGetValue<string>('description', FDESCRIPTION) then
    FDESCRIPTION := '';

  try
    FPRIORITY := TpPriority(aBody.GetValue<integer>('priority'));
  except
    FPRIORITY := TpPriority(0);
  end;

  FStatus := tpStatus(aBody.GetValue<integer>('status'));

end;

function TModelBusinessTask.InsertData(aBody: TJsonObject): TJsonObject;
begin
  FDataResult := TJsonObject.Create;

  FStatusCode := 201;
  ValidadeBodyInsert(aBody);

  Ftask.This.id(newId).DESCRIPTION(FDESCRIPTION).PRIORITY(ord(FPRIORITY))
    .STATUS(ord(tpStatus.Nova)).&End.Insert;

  FDataResult.AddPair('data', 'Data inserted');
  FDataResult.AddPair('statusCode', 201);

  result := FDataResult
end;

function TModelBusinessTask.GetAllData: TJsonObject;
var
  JsonArray: TJSONArray;
  JsonObject: TJsonObject;
  StrStatus, strPriority: string;
  iStatus, iPriority: integer;
begin
  JsonArray := TJSONArray.Create;
  FDataResult := TJsonObject.Create;
  try

    Ftask.GET;
    var
    DataSetTemp := Ftask.GetDataSet;

    DataSetTemp.First;
    while not DataSetTemp.Eof do
    begin
      iStatus := DataSetTemp.FieldByName('status').AsInteger;
      iPriority := DataSetTemp.FieldByName('priority').AsInteger;
      StrStatus := GetEnumName(TypeInfo(tpStatus), iStatus);
      strPriority := GetEnumName(TypeInfo(TpPriority), iPriority);

      JsonObject := TJsonObject.Create;
      try
        JsonObject.AddPair('id', DataSetTemp.FieldByName('id').AsString);
        JsonObject.AddPair('description', DataSetTemp.FieldByName('description')
          .AsString);
        JsonObject.AddPair('status', StrStatus);
        JsonObject.AddPair('priority', strPriority);
        JsonObject.AddPair('date', formatDateTime('YYYY-MM-DD hh:mm:ss',
          DataSetTemp.FieldByName('DATE').AsDateTime));

        JsonArray.AddElement(JsonObject);
      except
        JsonObject.Free;
        raise;
      end;

      DataSetTemp.Next;
    end;

    FDataResult.AddPair('data', JsonArray);
    FDataResult.AddPair('statusCode', 200);

    result := FDataResult;
  except
    JsonArray.Free;
    raise;
  end;
end;

function TModelBusinessTask.getInfos: TJsonObject;
var
  JsonObject: TJsonObject;
  allQtd: integer;
  avgPriority: currency;
  qtdDone: integer;
begin
  FDataResult := TJsonObject.Create;

  {
    view no readme
  }

  FQueryAux.active(false).sqlClear.sqlAdd('SELECT * from task_infos').open;

  var
  fdataSetTemp := FQueryAux.DataSet;
  allQtd := fdataSetTemp.FieldByName('allQtd').AsInteger;
  avgPriority := fdataSetTemp.FieldByName('avgPriority').AsCurrency;
  qtdDone := fdataSetTemp.FieldByName('qtdDone').AsInteger;

  JsonObject := TJsonObject.Create;
  JsonObject.AddPair('qtdAll', allQtd);
  JsonObject.AddPair('avgPriority', avgPriority);
  JsonObject.AddPair('qtdDone', qtdDone);

  FDataResult.AddPair('data', JsonObject);
  FDataResult.AddPair('statusCode', 200);
  result := FDataResult;

end;

end.
