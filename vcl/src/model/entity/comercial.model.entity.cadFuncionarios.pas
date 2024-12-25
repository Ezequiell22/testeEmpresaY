unit comercial.model.entity.cadFuncionarios;

interface

uses
  comercial.model.DAO.interfaces,
  System.Generics.Collections;

type

  TModelEntityCadFuncionarios = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCadFuncionarios>;
    FIDFUNCIONARIO: integer;
    FNMFUNCIONARIO: String;
    FDTNASCIMENTO: TdateTime;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCadFuncionarios>);
    destructor Destroy; override;
    function IDFUNCIONARIO(aValue: integer): TModelEntityCadFuncionarios; overload;
    function IDFUNCIONARIO: integer; overload;
    function NMFUNCIONARIO(aValue: string): TModelEntityCadFuncionarios; overload;
    function NMFUNCIONARIO: string; overload;
    function DTNASCIMENTO(aValue: TdateTime): TModelEntityCadFuncionarios; overload;
    function DTNASCIMENTO: TdateTime; overload;
    function &End: iModelDAOEntity<TModelEntityCadFuncionarios>;
  end;

implementation

uses
  System.SysUtils;

{ TModelEntityCadFuncionarios }

constructor TModelEntityCadFuncionarios.Create(aParent: iModelDAOEntity<TModelEntityCadFuncionarios>);
begin
  FParent := aParent;
end;

destructor TModelEntityCadFuncionarios.Destroy;
begin

  inherited;
end;

function TModelEntityCadFuncionarios.DTNASCIMENTO: TdateTime;
begin
  Result := FDTNASCIMENTO;
end;

function TModelEntityCadFuncionarios.DTNASCIMENTO(aValue: TdateTime): TModelEntityCadFuncionarios;
begin
  Result := Self;
  FDTNASCIMENTO := aValue;
end;

function TModelEntityCadFuncionarios.&End: iModelDAOEntity<TModelEntityCadFuncionarios>;
begin
  Result := FParent;
end;

function TModelEntityCadFuncionarios.IDFUNCIONARIO(aValue: integer): TModelEntityCadFuncionarios;
begin
  Result := Self;
  FIDFUNCIONARIO := aValue;
end;

function TModelEntityCadFuncionarios.IDFUNCIONARIO: integer;
begin
  if (FIDFUNCIONARIO) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  Result := FIDFUNCIONARIO;
end;

function TModelEntityCadFuncionarios.NMFUNCIONARIO(aValue: string): TModelEntityCadFuncionarios;
begin
  Result := Self;
  FNMFUNCIONARIO := aValue;
end;

function TModelEntityCadFuncionarios.NMFUNCIONARIO: string;
begin
  if trim(FNMFUNCIONARIO) = '' then
    raise Exception.Create('Nome não pode ser vazio');

  Result := FNMFUNCIONARIO;
end;

end.
