unit comercial.model.service.Task;

interface

uses
  comercial.model.service.interfaces;

type
  TModelServiceTask = class(TInterfacedObject, iModelServiceTask)
  private
    FFactory: iModelServiceFactory;
    Fapi: IModelServiceRequester;
  public
    constructor Create;
    destructor Destroy; override;
    class function new: iModelServiceTask;
    function GetInfos: string;
    function GetTasks: string;
    function CreateTask(const ATaskData: string): string;
    function DeleteTask(const ATaskID: string): string;
    function UpdateTask(const ATaskID, ATaskData: string): string;
  end;

implementation

{ TModelServiceTask }

USES comercial.model.service.RequesterFactory;

constructor TModelServiceTask.Create;
begin
  FFactory := TModelServiceFactory.new('http://127.0.0.1:8080/', 'montreal', '12345');
  Fapi := FFactory.api;
end;

function TModelServiceTask.CreateTask(const ATaskData: string): string;
begin
  result := Fapi.Post('task', ATaskData);
end;

function TModelServiceTask.DeleteTask(const ATaskID: string): string;
begin
  result := Fapi.Delete('task', ATaskID)
end;

destructor TModelServiceTask.Destroy;
begin

  inherited;
end;

function TModelServiceTask.GetInfos: string;
begin
  result := Fapi.Get('task/infos/')
end;

function TModelServiceTask.GetTasks: string;
begin
  result := Fapi.Get('task')
end;

class function TModelServiceTask.new: iModelServiceTask;
begin
  result := Self.Create;
end;

function TModelServiceTask.UpdateTask(const ATaskID, ATaskData: string): string;
begin
  result := Fapi.Put('task', ATaskData, ATaskID)
end;

end.
