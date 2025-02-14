unit api.model.resource.impl.factory;

interface

uses
  api.model.resource.interfaces,
  api.model.resource.impl.conexaofiredac,
  api.model.types;

type
  TResource = class(TInterfacedObject, iResource)
    private
      FConexao: iConexao;
    public
      constructor Create( aDb : TDataBaseType) ;
      destructor Destroy; override;
      class function New ( aDataBase : TDataBaseType)  : iResource;
      function Conexao: iConexao;
  end;

implementation

function TResource.Conexao: iConexao;
begin
  Result := FConexao;
end;

constructor TResource.Create( aDb : TDataBaseType) ;
begin
  FConexao := TmodelResourceConexaoFiredac.New(aDb);
end;

destructor TResource.Destroy;
begin

  inherited;
end;

class function TResource.New( aDataBase : TDataBaseType)  : iResource;
begin
  Result := Self.Create(aDataBase);
end;

end.
