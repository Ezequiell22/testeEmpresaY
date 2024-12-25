unit comercial.model.resource.impl.conexaofiredac;

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
  FireDAC.Phys.FB,
  FireDAC.DApt,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  comercial.model.resource.interfaces,
  Data.DB,
  comercial.model.types.DB,
  FireDAC.Phys.IB;

type
  TmodelResourceConexaoFiredac = class(TInterfacedObject, iConexao)
  private
    FConn: TFDConnection;
    FdataBaseName: TDataBaseType;
    FDPhysIBDriverLink: TFDPhysIBDriverLink;
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
    if FdataBaseName = tcSQlServerErechimProducao then
    begin
      //
    end
    else if FdataBaseName = tcFBTeste then
    begin

      FConn.Params.DriverID := 'FB';
      FConn.Params.Database := 'C:\testeEmpresa\DADOS.FDB';
      FConn.Params.UserName := 'SYSDBA';
      FConn.Params.Password := 'masterkey';
      FDPhysIBDriverLink.VendorLib := 'fbClient.dll';
    end
    else if FdataBaseName = tcSqlServerSped then
    begin
      //
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
  FDPhysIBDriverLink := TFDPhysIBDriverLink.Create(nil);
end;

destructor TmodelResourceConexaoFiredac.Destroy;
begin
  FConn.Free;
  FDPhysIBDriverLink.Free;
  inherited;
end;

class function TmodelResourceConexaoFiredac.New(aDataBase: TDataBaseType)
  : iConexao;
begin
  Result := Self.Create(aDataBase);
end;

end.
