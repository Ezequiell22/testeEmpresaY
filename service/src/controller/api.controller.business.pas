unit api.controller.business;

interface

uses
  api.controller.interfaces,
  api.model.business.interfaces,
  api.model.resource.interfaces,
  api.model.DAO.interfaces,
  api.model.business.task;

type
  TControllerBusiness = class(TInterfacedObject, iControllerBusiness)
  private
    FTask: iModelBusinessTask;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerBusiness;
    function Task: iModelBusinessTask;
  end;

implementation


{ TControllerBusiness }

constructor TControllerBusiness.create;
begin

end;

destructor TControllerBusiness.destroy;
begin

  inherited;
end;

function TControllerBusiness.task: iModelBusinessTask;
begin
  if not assigned(FTask) then
    FTask := TmodelBusinessTask.New;
  result := FTask;
end;

class function TControllerBusiness.New: iControllerBusiness;
begin
  result := Self.create;
end;

end.
