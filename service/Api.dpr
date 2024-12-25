program Api;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  System.SysUtils,
  System.JSON,
  Winapi.Windows,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  api.model.business.Task in 'src\model\business\api.model.business.Task.pas',
  api.model.business.interfaces in 'src\model\business\api.model.business.interfaces.pas',
  api.model.DAO.task in 'src\model\DAO\api.model.DAO.task.pas',
  api.model.DAO.interfaces in 'src\model\DAO\api.model.DAO.interfaces.pas',
  api.model.entity.task in 'src\model\entity\api.model.entity.task.pas',
  api.model.resource.interfaces in 'src\model\resource\api.model.resource.interfaces.pas',
  api.model.resource.impl.conexaofiredac in 'src\model\resource\impl\api.model.resource.impl.conexaofiredac.pas',
  api.model.resource.impl.factory in 'src\model\resource\impl\api.model.resource.impl.factory.pas',
  api.model.resource.impl.queryFiredac in 'src\model\resource\impl\api.model.resource.impl.queryFiredac.pas',
  api.model.types in 'src\model\types\api.model.types.pas',
  api.controller.business in 'src\controller\api.controller.business.pas',
  api.controller.entity in 'src\controller\api.controller.entity.pas',
  api.controller.interfaces in 'src\controller\api.controller.interfaces.pas',
  api.controller in 'src\controller\api.controller.pas';

var
  FController: iController;

procedure ConfigureRoutes;
begin
  THorse.Use(Jhonson);
  THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      // autenticação basica
      Result := AUsername.Equals('montreal') and APassword.Equals('12345');
    end));

  // Consultar e retornar a lista de todas as tarefas.
  THorse.Get('/task',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      resp: TJsonObject;
      StatusCode: Integer;
    begin
      FController := TController.New;
      resp := FController.business.Task.getAlldata;
      StatusCode := resp.GetValue('statusCode').value.ToInteger;
      Res.Status(StatusCode).Send<TJsonObject>(resp);
    end);

  // Adicionar uma nova tarefa
  THorse.Post('/task',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      Body: TJsonObject;
      resp: TJsonObject;
      StatusCode: Integer;
    begin
      FController := TController.New;
      Body := TJsonObject.ParseJSONValue(Req.Body) as TJsonObject;
      resp := FController.business.Task.InsertData(Body);

      StatusCode := resp.GetValue('statusCode').value.ToInteger;
      Res.Status(StatusCode).Send<TJsonObject>(resp);
    end);

  // Atualizar o status de uma tarefa.
  THorse.Put('/task/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      Body: TJsonObject;
      resp: TJsonObject;
      StatusCode: Integer;
    begin
      FController := TController.New;
      Body := TJsonObject.ParseJSONValue(Req.Body) as TJsonObject;
      resp := FController.business.Task.UpdateData(Body, Req.Params['id']);

      StatusCode := resp.GetValue('statusCode').value.ToInteger;
      Res.Status(StatusCode).Send<TJsonObject>(resp);
    end);

  // Remover uma tarefa
  THorse.Delete('/task/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      resp: TJsonObject;
      StatusCode: Integer;
    begin
      FController := TController.New;
      resp := FController.business.Task.DeleteDataById
        (Req.Params['id']);
      StatusCode := resp.GetValue('statusCode').value.ToInteger;
      Res.Status(StatusCode).Send<TJsonObject>(resp);
    end);

  { • O número total de tarefas.
    • A média de prioridade das tarefas pendentes.
    • A quantidade de tarefas concluídas nos últimos 7 dias. }
  THorse.Get('/task/infos',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      resp: TJsonObject;
      StatusCode: Integer;
    begin
      FController := TController.New;

      resp := FController.business.Task.getInfos;
      StatusCode := resp.GetValue('statusCode').value.ToInteger;
      Res.Status(StatusCode).Send<TJsonObject>(resp);
    end);
end;

begin
  try
    ConfigureRoutes;
    Writeln('Server is running on http://localhost:8080');

    THorse.Listen(8080);
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
