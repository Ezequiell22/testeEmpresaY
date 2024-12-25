unit comercial.model.entity.cadEmpresa;

interface

uses
  comercial.model.DAO.interfaces,
  System.Generics.Collections;

type

  TModelEntityCadEmpresa = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCadEmpresa>;
    FIDEMPRESA: integer;
    FNMEMPRESA: String;
    FNUCNPJ: String;
    FSTATIVO: String;
    FSTEXCLUIDO: string;
    FDTEXCLUIDO: TdateTime;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCadEmpresa>);
    destructor Destroy; override;
    function IDEMPRESA(aValue: integer): TModelEntityCadEmpresa; overload;
    function IDEMPRESA: integer; overload;
    function NMEMPRESA(aValue: string): TModelEntityCadEmpresa; overload;
    function NMEMPRESA: string; overload;
    function NUCNPJ(aValue: string): TModelEntityCadEmpresa; overload;
    function NUCNPJ: string; overload;
    function STATIVO(aValue: string): TModelEntityCadEmpresa; overload;
    function STATIVO: string; overload;
    function STEXCLUIDO(aValue: string): TModelEntityCadEmpresa; overload;
    function STEXCLUIDO: string; overload;
    function DTEXCLUIDO(aValue: TdateTime): TModelEntityCadEmpresa; overload;
    function DTEXCLUIDO: TdateTime; overload;
    function &End: iModelDAOEntity<TModelEntityCadEmpresa>;
  end;

implementation

uses
  System.SysUtils;

{ TModelEntityCadEmpresa }

constructor TModelEntityCadEmpresa.Create
  (aParent: iModelDAOEntity<TModelEntityCadEmpresa>);
begin
  FParent := aParent;
end;

destructor TModelEntityCadEmpresa.Destroy;
begin

  inherited;
end;

function TModelEntityCadEmpresa.DTEXCLUIDO(aValue: TdateTime)
  : TModelEntityCadEmpresa;
begin
  result := Self;
  FDTEXCLUIDO := aValue;
end;

function TModelEntityCadEmpresa.DTEXCLUIDO: TdateTime;
begin
  result := FDTEXCLUIDO;
end;

function TModelEntityCadEmpresa.&End: iModelDAOEntity<TModelEntityCadEmpresa>;
begin
  result := FParent;
end;

function TModelEntityCadEmpresa.IDEMPRESA(aValue: integer)
  : TModelEntityCadEmpresa;
begin
  result := Self;
  FIDEMPRESA := aValue;
end;

function TModelEntityCadEmpresa.IDEMPRESA: integer;
begin
  if (FIDEMPRESA) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  result := FIDEMPRESA;
end;

function TModelEntityCadEmpresa.NMEMPRESA(aValue: string)
  : TModelEntityCadEmpresa;
begin
  result := Self;
  FNMEMPRESA := aValue;
end;

function TModelEntityCadEmpresa.NMEMPRESA: string;
begin
  if trim(FNMEMPRESA) = '' then
    raise Exception.Create('Nome não pode ser vazio');

  result := FNMEMPRESA;
end;

function TModelEntityCadEmpresa.NUCNPJ: string;
begin
  result := FNUCNPJ;
end;

function TModelEntityCadEmpresa.STATIVO: string;
begin
  result := FSTATIVO;;
end;

function TModelEntityCadEmpresa.STATIVO(aValue: string): TModelEntityCadEmpresa;
begin
  result := Self;
  FSTATIVO := aValue;
end;

function TModelEntityCadEmpresa.STEXCLUIDO(aValue: string)
  : TModelEntityCadEmpresa;
begin
  result := Self;
  FSTEXCLUIDO := aValue;
end;

function TModelEntityCadEmpresa.STEXCLUIDO: string;
begin
  result := FSTEXCLUIDO;
end;

function TModelEntityCadEmpresa.NUCNPJ(aValue: string): TModelEntityCadEmpresa;
begin
  result := Self;
  FNUCNPJ := aValue;
end;

end.
