unit comercial.model.business.ListTasks;

interface

uses
  comercial.model.business.interfaces,
  comercial.model.service.interfaces,
  System.JSON,
  Vcl.Grids,
  Vcl.StdCtrls;

type
  TModelBusinessListTasks = class(TInterfacedObject, iModelBusinessListTasks)
  private
    FModelServiceTask: iModelServiceTask;
    Ftasks: TJsonArray;
    function tasks: TJsonArray;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessListTasks;
    procedure DisplayTasks(aGrid: TstringGrid);
    procedure DisplayInfos(
    edtQtdAll, edtAvgPriority, edtQtdDone : TEdit);
  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  comercial.model.service.Task;

{ TModelBusinessListTasks }

constructor TModelBusinessListTasks.Create;
begin
  FModelServiceTask := TModelServiceTask.New;
end;

destructor TModelBusinessListTasks.Destroy;
begin
  inherited;
end;

procedure TModelBusinessListTasks.DisplayInfos(edtQtdAll, edtAvgPriority,
  edtQtdDone: TEdit);
  var respStr : string;
  RespJson: TJsonObject;
  DataValue : TJsonValue;
begin

  respStr := FModelServiceTask
    .GetInfos;
  try
    RespJson := TJsonObject.ParseJSONValue(RespStr) as TJsonObject;
    if Assigned(RespJson) then
    begin
      DataValue := RespJson.GetValue('data');

      edtQtdAll.Text := DataValue.GetValue<string>('qtdAll');
      edtAvgPriority.Text := DataValue.GetValue<string>('avgPriority');
      edtQtdDone.Text := DataValue.GetValue<string>('qtdDone');
    end
    else
      raise Exception.Create('A resposta não é um objeto JSON válido.');
  finally
    RespJson.Free;
  end;

end;

procedure TModelBusinessListTasks.DisplayTasks(aGrid: TstringGrid);
var
  I, J: Integer;
  JsonObj: TJsonObject;
  Pair: TJSONPair;
begin
  Ftasks := tasks;

  try
    if Ftasks.Count > 0 then
    begin
      JsonObj := Ftasks.Items[0] as TJsonObject;
      aGrid.ColCount := JsonObj.Count;
      aGrid.RowCount := Ftasks.Count + 1;

      J := 0;
      for Pair in JsonObj do
      begin
        aGrid.Cells[J, 0] := Pair.JsonString.Value;
        Inc(J);
      end;
    end;

    for I := 0 to Ftasks.Count - 1 do
    begin
      JsonObj := Ftasks.Items[I] as TJsonObject;
      J := 0;
      for Pair in JsonObj do
      begin
        aGrid.Cells[J, I + 1] := Pair.JsonValue.Value;
        aGrid.ColWidths[J] := Length(Pair.JsonValue.Value) + 100;
        Inc(J);
      end;
    end;

  finally
    Ftasks.Free;
  end;
end;

class function TModelBusinessListTasks.New: iModelBusinessListTasks;
begin
  result := self.Create;
end;

function TModelBusinessListTasks.tasks: TJsonArray;
var
  RespStr: string;
  RespJson: TJsonObject;
  DataValue: TJsonValue;
begin
  result := nil;
  RespStr := FModelServiceTask.GetTasks;

  try
    RespJson := TJsonObject.ParseJSONValue(RespStr) as TJsonObject;
    if Assigned(RespJson) then
    begin
      DataValue := RespJson.GetValue('data');
      if Assigned(DataValue) and (DataValue is TJsonArray) then
        result := TJsonArray(DataValue.Clone)
      else
        raise Exception.Create
          ('O atributo "data" não foi encontrado ou não é um array.');
    end
    else
      raise Exception.Create('A resposta não é um objeto JSON válido.');
  finally
    RespJson.Free;
  end;
end;

end.
