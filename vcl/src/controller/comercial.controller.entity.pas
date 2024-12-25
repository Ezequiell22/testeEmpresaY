unit comercial.controller.entity;

interface

uses
  comercial.controller.interfaces,
  comercial.model.DAO.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.types.Db,
  comercial.model.entity.cadFuncionarios,
  comercial.model.entity.cadEmpresa,
  comercial.model.entity.cadUF,
  comercial.model.entity.cadEnderecos,
  comercial.model.entity.cadCidade,
  comercial.model.entity.cadTitular;

type
  TControllerEntity = class(TInterfacedObject, iControllerEntity)
  private
    FcadFuncionarios: iModelDAOEntity<TModelEntitycadFuncionarios>;
    FcadEmpresa: iModelDAOEntity<TModelEntityCadEmpresa>;
    FcadUF: iModelDAOEntity<TModelEntityCadUF>;
    FcadEnderecos: iModelDAOEntity<TModelEntityCadEnderecos>;
    FcadCidade: iModelDAOEntity<TModelEntityCadCidade>;
    FcadTitular: iModelDAOEntity<TModelEntityCadTitular>;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerEntity;
    function cadFuncionarios: iModelDAOEntity<TModelEntitycadFuncionarios>;
    function cadEmpresa: iModelDAOEntity<TModelEntityCadEmpresa>;
    function cadUF: iModelDAOEntity<TModelEntityCadUF>;
    function cadEnderecos: iModelDAOEntity<TModelEntityCadEnderecos>;
    function cadCidade: iModelDAOEntity<TModelEntityCadCidade>;
    function cadTitular: iModelDAOEntity<TModelEntityCadTitular>;
  end;

implementation

uses
  comercial.model.DAO.cadEmpresa,
  comercial.model.DAO.cadCidade,
  comercial.model.DAO.cadFuncionarios,
  comercial.model.DAO.cadEnderecos,
  comercial.model.DAO.cadTitular,
  comercial.model.DAO.cadUF;

{ TControllerEntity }

constructor TControllerEntity.create;
begin

end;

destructor TControllerEntity.destroy;
begin

  inherited;
end;

function TControllerEntity.cadCidade: iModelDAOEntity<TModelEntityCadCidade>;
begin
  if not assigned(FcadCidade) then
    FcadCidade := TmodelDaoCadCidade.New;
  result := FcadCidade;
end;

function TControllerEntity.cadEmpresa: iModelDAOEntity<TModelEntityCadEmpresa>;
begin
  if not assigned(FcadEmpresa) then
    FcadEmpresa := TmodelDaoCadEmpresa.New;
  result := FcadEmpresa;
end;

class function TControllerEntity.New: iControllerEntity;
begin
  result := self.create;
end;

function TControllerEntity.cadEnderecos
  : iModelDAOEntity<TModelEntityCadEnderecos>;
begin
  if not assigned(FcadEnderecos) then
    FcadEnderecos := TmodelDaoCadEnderecos.New;
  result := FcadEnderecos;
end;

function TControllerEntity.cadFuncionarios
  : iModelDAOEntity<TModelEntitycadFuncionarios>;
begin
  if not assigned(FcadFuncionarios) then
    FcadFuncionarios := TmodelDaoCadFuncionarios.New;
  result := FcadFuncionarios;
end;

function TControllerEntity.cadTitular: iModelDAOEntity<TModelEntityCadTitular>;
begin
  if not assigned(FcadTitular) then
    FcadTitular := TmodelDaoCadTitular.New;
  result := FcadTitular;
end;

function TControllerEntity.cadUF: iModelDAOEntity<TModelEntityCadUF>;
begin
  if not assigned(FcadUF) then
    FcadUF := TmodelDaoCadUF.New;
  result := FcadUF;
end;

end.
