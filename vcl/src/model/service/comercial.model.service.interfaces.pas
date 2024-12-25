unit comercial.model.service.interfaces;

interface

type
  iModelServiceRequester = interface
    ['{E87F1940-D1F2-46F5-9A0C-B62726285B1F}']
    function Get(const AEndpoint: string): string;
    function Post(const AEndpoint, ABody: string): string;
    function Put(const AEndpoint, ABody: string; aId: string): string;
    function Delete(const AEndpoint: string; aId: string): string;
  end;

  iModelServiceFactory = interface
    ['{F59322A2-9EC9-49DB-B5B5-7A0B18F91239}']
    function api: iModelServiceRequester;
  end;

  iModelServiceTask = interface
    ['{845780C1-D06F-4123-B37C-859E4B3C96C4}']
    function GetInfos: string;
    function GetTasks: string;
    function CreateTask(const ATaskData: string): string;
    function DeleteTask(const ATaskID: string): string;
    function UpdateTask(const ATaskID, ATaskData: string): string;
  end;

implementation

end.
