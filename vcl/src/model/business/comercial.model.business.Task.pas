unit comercial.model.business.Task;

interface

uses
  comercial.model.business.interfaces,
  comercial.model.service.interfaces;

type
  TModelBusinessTask = class(TInterfacedObject, iModelBusinessTask)
  private
    Fid: integer;
    FDescription: String;
    FPriority: integer;
    Fstatus: integer;
    FModelServiceTask: iModelServiceTask;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessTask;
    function Id(aValue: integer): iModelBusinessTask;
    function Description(aValue: string): iModelBusinessTask;
    function Status(aValue: integer): iModelBusinessTask;
    function Priority(aValue: integer): iModelBusinessTask;
    function DeleteTask: iModelBusinessTask;
    function CreateTask: iModelBusinessTask;
    function UpdateTask: iModelBusinessTask;
  end;

implementation

uses
  Generics.Collections,
  System.SysUtils,
  comercial.model.service.Task,
  System.JSON;

{ TModelBusinessTask }

constructor TModelBusinessTask.Create;
begin
  FModelServiceTask := TModelServiceTask.New;
end;

function TModelBusinessTask.CreateTask: iModelBusinessTask;
var
  content: TJsonObject;
  strData: string;
begin
  result := Self;

  content := TJsonObject.Create;
  try
    try
      content.AddPair('description', FDescription);
      content.AddPair('priority', FPriority);
      strData := content.ToString;

      FModelServiceTask.CreateTask(strData);
    except
      on E: Exception do
        raise Exception.Create('Error ao criar tarefa' + E.Message);
    end;
  finally
    content.Free;
  end;

end;

function TModelBusinessTask.DeleteTask: iModelBusinessTask;
begin
  result := Self;

  if Fid <= 0 then
    raise Exception.Create('Informe o ID');

  try
    FModelServiceTask.DeleteTask(Fid.ToString);
  except
    on E: Exception do
      raise Exception.Create('Error ao criar tarefa' + E.Message);
  end;

end;

function TModelBusinessTask.Description(aValue: string): iModelBusinessTask;
begin
  result := Self;
  FDescription := aValue;
end;

destructor TModelBusinessTask.Destroy;
begin

  inherited;
end;

function TModelBusinessTask.Id(aValue: integer): iModelBusinessTask;
begin
  result := Self;
  Fid := aValue;
end;

class function TModelBusinessTask.New: iModelBusinessTask;
begin
  result := Self.Create;
end;

function TModelBusinessTask.Priority(aValue: integer): iModelBusinessTask;
begin
  result := Self;
  FPriority := aValue;
end;

function TModelBusinessTask.Status(aValue: integer): iModelBusinessTask;
begin
  result := Self;
  Fstatus := aValue;
end;

function TModelBusinessTask.UpdateTask: iModelBusinessTask;
var
  content: TJsonObject;
  strData: string;
begin
  result := Self;

  if Fid <= 0 then
    raise Exception.Create('Informe o ID');

  content := TJsonObject.Create;
  try
    try
      content.AddPair('status', Fstatus);
      strData := content.ToString;
      FModelServiceTask.UpdateTask(Fid.ToString, strData);

    except
      on E: Exception do
        raise Exception.Create('Error ao atualizar tarefa' + E.Message);
    end;
  finally
    content.Free;
  end;

end;

end.
