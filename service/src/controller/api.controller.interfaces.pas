unit api.controller.interfaces;

interface

uses
  api.model.DAO.interfaces,
  api.model.resource.interfaces,
  api.model.business.interfaces,
  api.model.entity.task;

type
  iControllerEntity = interface;
  iControllerBusiness = interface;

  iController = interface
    ['{7C276AC1-0385-4CFE-8395-319A67F573E2}']
    function entity: iControllerEntity;
    function business: iControllerBusiness;
  end;

  iControllerEntity = interface
    ['{9EDCA6E3-A329-454A-8755-67C9919C0B29}']
    function task : iModelDAOEntity<TModelEntityTask>;
  end;

  iControllerBusiness = interface
    ['{D64C6AAD-C4A3-46BC-BBE4-3CF753379DA5}']
    function task: iModelBusinessTask;
  end;

implementation

end.
