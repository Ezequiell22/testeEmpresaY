unit api.model.resource.impl.conexaofiredac;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MSSQL,
  FireDAC.DApt,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  api.model.resource.interfaces,
  Data.DB,
  api.model.types.DB;

type
  TmodelResourceConexaoFiredac = class(TInterfacedObject, iConexao)
  private
    FConn: TFDConnection;
    FdataBaseName: TDataBaseType;
  public
    constructor Create(aDataBase: TDataBaseType);
    destructor Destroy; override;
    class function New(aDataBase: TDataBaseType): iConexao;
    function Connect: TCustomConnection;
  end;

implementation

uses
  Vcl.Dialogs, Vcl.Forms;

function TmodelResourceConexaoFiredac.Connect: TCustomConnection;
begin
  try
    FConn.Params.Clear;

    if FdataBaseName = tcTeste then
    begin

      FConn.Params.DriverID := 'MSSQL';
      FConn.Params.Database := 'teste';
      FConn.Params.Add('OSAuthent=Yes');
      FConn.Params.Add('Encrypt=no');
      FConn.Params.Add('Server=DESKTOP-180BIC5');

    end;

    FConn.Connected := True;
    Result := FConn;
  except
    on e: exception do
      raise exception.Create('Não foi possivel realizar a conexão ' +
        e.message);
  end;
end;

constructor TmodelResourceConexaoFiredac.Create(aDataBase: TDataBaseType);
begin
  FConn := TFDConnection.Create(nil);
  FdataBaseName := aDataBase;
end;

destructor TmodelResourceConexaoFiredac.Destroy;
begin
  FConn.Free;
  inherited;
end;

class function TmodelResourceConexaoFiredac.New(aDataBase: TDataBaseType)
  : iConexao;
begin
  Result := Self.Create(aDataBase);
end;

end.
