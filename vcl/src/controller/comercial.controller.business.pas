unit comercial.controller.business;

interface

uses
  comercial.controller.interfaces,
  comercial.model.business.interfaces,
  comercial.model.business.ListTasks;

type
  TControllerBusiness = class(TInterfacedObject, iControllerBusiness)
  private
    FListTasks: iModelBusinessListTasks;
    FTask: iModelBusinessTask;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerBusiness;
    function ListTasks: iModelBusinessListTasks;
    function Task: iModelBusinessTask;
  end;

implementation

uses
  comercial.model.business.Task;

{ TControllerBusiness }

constructor TControllerBusiness.create;
begin

end;

destructor TControllerBusiness.destroy;
begin

  inherited;
end;

function TControllerBusiness.Task: iModelBusinessTask;
begin
  if not assigned(FTask) then
    FTask := TmodelBusinessTask.New;
  result := FTask;
end;

function TControllerBusiness.ListTasks: iModelBusinessListTasks;
begin
  if not assigned(FListTasks) then
    FListTasks := TmodelBusinessListTasks.New;
  result := FListTasks;
end;

class function TControllerBusiness.New: iControllerBusiness;
begin
  result := Self.create;
end;

end.
