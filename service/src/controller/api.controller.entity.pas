unit api.controller.entity;

interface

uses
  api.controller.interfaces,
  api.model.DAO.interfaces,
  api.model.resource.interfaces,
  api.model.types.Db,
  api.model.entity.task;

type
  TControllerEntity = class(TInterfacedObject, iControllerEntity)
  private
    Ftask: iModelDAOEntity<TModelEntityTask>;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerEntity;
    function task: iModelDAOEntity<TModelEntityTask>;
  end;

implementation

uses
  api.model.DAO.task;

{ TControllerEntity }

constructor TControllerEntity.create;
begin

end;

destructor TControllerEntity.destroy;
begin

  inherited;
end;

function TControllerEntity.task: iModelDAOEntity<TModelEntityTask>;
begin
  if not assigned(Ftask) then
    Ftask := TmodelDaoTask.New;
  result := Ftask;
end;

class function TControllerEntity.New: iControllerEntity;
begin
  result := self.create;
end;

end.
