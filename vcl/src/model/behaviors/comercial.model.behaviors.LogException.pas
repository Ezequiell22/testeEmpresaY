unit comercial.model.behaviors.LogException;

interface

uses
  System.SysUtils,
  vcl.Forms,
  vcl.Dialogs,
  System.UITypes;

type
  TModelBehaviorsLogException = class
  private
    FLogFile: String;
    FDirImagesLog: string;
    function buildMsg(form, caption, classError, error: string): string;
  public
    constructor Create;
    procedure TrataException(Sender: TObject; E: Exception);
    procedure GravarLog(Value: String);
    function CapturarTela(Aform: String): string;
    procedure ConfDirImages;
  end;

var
  ModelBehaviorsLogException: TModelBehaviorsLogException;

implementation

uses
  System.Classes,
  Winapi.Windows,
  vcl.Graphics,
  vcl.ExtCtrls;

{ TModelBehaviorsLogException }

function TModelBehaviorsLogException.buildMsg(form, caption, classError,
  error: string): string;
begin

  result := 'Form: ' + form + slinebreak
    + ' | Caption: ' + caption + slinebreak
    + ' | Classe Erro:' + classError + slinebreak
    + ' | Erro:' + error;

end;

function TModelBehaviorsLogException.CapturarTela(Aform: String): String;
var
  dc: hdc;
  cv: TCanvas;
  bitmap: TBitmap;
  image1: Timage;

begin
  bitmap := TBitmap.Create;
  image1 := Timage.Create(nil);
  try
    try
      bitmap.Width := Screen.Width;
      bitmap.Height := Screen.Height;
      dc := GetDc(0);
      cv := TCanvas.Create;
      cv.Handle := dc;
      bitmap.Canvas.CopyRect(Rect(0, 0, Screen.Width, Screen.Height), cv,
        Rect(0, 0, Screen.Width, Screen.Height));
      cv.Free;
      ReleaseDC(0, dc);

      result := FDirImagesLog + Aform + formatDateTime('DDmmYYYYHHnnss',
        now) + '.bmp';

      image1.Picture.Assign(bitmap);
      image1.Picture.SaveToFile(result);
    except
      result := '';
    end;
  finally
    image1.Free;
    bitmap.Free;
  end;
end;

procedure TModelBehaviorsLogException.ConfDirImages;
begin
  FDirImagesLog := getCurrentDir() + '\CapturasDeTelaErro\comercial\';
  if not DirectoryExists(FDirImagesLog) then
    ForceDirectories(FDirImagesLog)

end;

constructor TModelBehaviorsLogException.Create;
begin
  ReportMemoryLeaksOnShutdown := true;
  FLogFile := ChangeFileExt(ParamStr(0), '.log');
  ConfDirImages;
  Application.OnException := TrataException;
end;

procedure TModelBehaviorsLogException.GravarLog(Value: String);
var
  txtLog: TextFile;
begin
  AssignFile(txtLog, FLogFile);
  if FileExists(FLogFile) then
    Append(txtLog)
  else
    Rewrite(txtLog);
  Writeln(txtLog, formatDateTime('dd/mm/YY hh:nn:ss - ', now) + Value);
  CloseFile(txtLog);
end;

procedure TModelBehaviorsLogException.TrataException(Sender: TObject;
  E: Exception);
var
  form, caption, classError, error: string;
begin

  GravarLog('===========================================');
  if TComponent(Sender) is TForm then
  begin
    form := TForm(Sender).name;
    caption := TForm(Sender).caption;
    classError := E.ClassName;
    error := E.Message;
  end
  else
  begin
    form := TForm(TComponent(Sender).Owner).name;
    caption := TForm(TComponent(Sender).Owner).caption;
    classError := E.ClassName;
    error := E.Message;
  end;

  var
  msg := buildMsg(form, caption, classError, error);

  if UpperCase(E.Message).Contains('ERRO') then
    GravarLog(msg);

  if upperCase(e.Message).Contains('ERRO') then
  begin
    MessageDlg(E.Message, TMsgDlgType.mtError, [mbok], 0);
  end
  else
    MessageDlg(E.Message, TMsgDlgType.mtWarning, [mbok], 0);

end;

initialization

ModelBehaviorsLogException := TModelBehaviorsLogException.Create;

finalization

ModelBehaviorsLogException.Free;

end.
