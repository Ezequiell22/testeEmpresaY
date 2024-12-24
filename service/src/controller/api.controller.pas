unit api.controller;

interface

uses
  api.controller.interfaces;

type
  TController = class(TInterfacedobject, iController)
  private
    FEntity: iControllerEntity;
    FBusiness : iControllerBusiness;
  public
    constructor create;
    destructor destroy; override;
    class function New: iController;
    function entity: iControllerEntity;
    function business : iControllerBusiness;
  end;

implementation

uses
  api.controller.entity,
  api.controller.business;

{ TController }

function TController.business: iControllerBusiness;
begin
  if not Assigned(FBusiness) then
    FBusiness := TcontrollerBusiness.New;

  result := FBusiness;
end;

constructor TController.create;
begin

end;

destructor TController.destroy;
begin

  inherited;
end;

function TController.entity: iControllerEntity;
begin
  if not Assigned(FEntity) then
    FEntity := TcontrollerEntity.New;

  result := FEntity;
end;

class function TController.New: iController;
begin
  result := self.create
end;

end.
