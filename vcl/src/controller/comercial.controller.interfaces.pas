unit comercial.controller.interfaces;

interface

uses
  comercial.model.business.interfaces;

type

  iControllerBusiness = interface;

  iController = interface
    ['{7C276AC1-0385-4CFE-8395-319A67F573E2}']
    function business: iControllerBusiness;
  end;

  iControllerBusiness = interface
    ['{D64C6AAD-C4A3-46BC-BBE4-3CF753379DA5}']
    function ListTasks: iModelBusinessListTasks;
    function Task : iModelBusinessTask;
  end;

implementation

end.
