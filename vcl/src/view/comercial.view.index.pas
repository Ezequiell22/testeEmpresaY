unit comercial.view.index;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  comercial.controller.interfaces;

type
  TfrmIndex = class(Tform)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    asks1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure asks1Click(Sender: TObject);
  private
    Fcontroller: iController;
    CloseForm: Word;
    MutexHandle: THandle;
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
  public
  end;

var
  frmIndex: TfrmIndex;

implementation

{$R *.dfm}

uses
  System.UITypes,
  comercial.controller,
  comercial.view.ListTasks;

procedure TfrmIndex.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin

  if (Msg.message = WM_KEYDOWN) or (Msg.message = WM_COMMAND) or
    (Msg.message = WM_MOUSEMOVE) then
  begin
    CloseForm := 0;
    Handled := FALSE;
  end;

  if (Msg.message = WM_KEYDOWN) and (GetKeyState(VK_CONTROL) < 0) and
    (Msg.wParam = VK_DELETE) then
  begin
    Handled := True;
  end;

end;

procedure TfrmIndex.asks1Click(Sender: TObject);
begin
  pageListTasks := TpageListTasks.Create(self);
  try
    pageListTasks.ShowModal;
  finally
    pageListTasks.Free;
  end;
end;

procedure TfrmIndex.FormCreate(Sender: TObject);
var
  numberVersion, dateVersion: string;
begin
  try
    MutexHandle := CreateMutex(nil, True, 'AppDelphi1');
    if (MutexHandle = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then
      raise Exception.Create('O aplicativo já está em execução.');

    SystemParametersInfo(SPI_SETBEEP, 0, nil, SPIF_SENDWININICHANGE);

    numberVersion := '1';
    dateVersion := '26/12/2024';

    self.Caption := 'Versão liberada ' + numberVersion +
      '  | Data ' + dateVersion;
  except
    on e: Exception do
      showMessage(e.message)
  end;
end;

procedure TfrmIndex.FormDestroy(Sender: TObject);
begin
  inherited;
  if MutexHandle <> 0 then
    CloseHandle(MutexHandle);
end;

procedure TfrmIndex.FormShow(Sender: TObject);
begin
  inherited;
  CloseForm := 0;
  application.OnMessage := AppMessage;

end;

end.
