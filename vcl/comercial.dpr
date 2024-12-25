program comercial;

uses
  Vcl.Forms,
  comercial.view.index in 'src\view\comercial.view.index.pas' {frmIndex},
  comercial.controller.business in 'src\controller\comercial.controller.business.pas',
  comercial.controller.interfaces in 'src\controller\comercial.controller.interfaces.pas',
  comercial.controller in 'src\controller\comercial.controller.pas',
  comercial.model.behaviors.LogException in 'src\model\behaviors\comercial.model.behaviors.LogException.pas',
  comercial.model.business.interfaces in 'src\model\business\comercial.model.business.interfaces.pas',
  comercial.model.business.ListTasks in 'src\model\business\comercial.model.business.ListTasks.pas',
  comercial.view.ListTasks in 'src\view\comercial.view.ListTasks.pas' {pageListTasks},
  comercial.model.business.Task in 'src\model\business\comercial.model.business.Task.pas',
  comercial.view.Task in 'src\view\comercial.view.Task.pas' {pageTask},
  comercial.model.service.Requester in 'src\model\service\comercial.model.service.Requester.pas',
  comercial.model.service.RequesterFactory in 'src\model\service\comercial.model.service.RequesterFactory.pas',
  comercial.model.service.Task in 'src\model\service\comercial.model.service.Task.pas',
  comercial.model.service.interfaces in 'src\model\service\comercial.model.service.interfaces.pas',
  comercial.view.utils.types in 'src\view\utils\comercial.view.utils.types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmIndex, frmIndex);
  Application.CreateForm(TpageTask, pageTask);
  Application.Run;
end.
