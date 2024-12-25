unit comercial.model.entity.cadCidade;

interface

uses
  comercial.model.DAO.interfaces,
  System.Generics.Collections;

type

  TModelEntityCadCidade = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCadCidade>;
    FIDCIDADE: integer;
    FIDUF: integer;
    FNMCIDADE: String;
    FNOIBGE: String;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCadCidade>);
    destructor Destroy; override;
    function IDCIDADE(aValue: integer): TModelEntityCadCidade; overload;
    function IDCIDADE: integer; overload;
    function IDUF(aValue: integer): TModelEntityCadCidade; overload;
    function IDUF: integer; overload;
    function NMCIDADE(aValue: string): TModelEntityCadCidade; overload;
    function NMCIDADE: string; overload;
    function NOIBGE(aValue: string): TModelEntityCadCidade; overload;
    function NOIBGE: string; overload;
    function &End: iModelDAOEntity<TModelEntityCadCidade>;
  end;

implementation

uses
  System.SysUtils;

{ TModelEntityCadCidade }

constructor TModelEntityCadCidade.Create
  (aParent: iModelDAOEntity<TModelEntityCadCidade>);
begin
  FParent := aParent;
end;

destructor TModelEntityCadCidade.Destroy;
begin

  inherited;
end;

function TModelEntityCadCidade.&End: iModelDAOEntity<TModelEntityCadCidade>;
begin
  Result := FParent;
end;

function TModelEntityCadCidade.IDCIDADE(aValue: integer): TModelEntityCadCidade;
begin
  Result := Self;
  FIDCIDADE := aValue;
end;

function TModelEntityCadCidade.IDCIDADE: integer;
begin
  if (FIDCIDADE) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  Result := FIDCIDADE;
end;

function TModelEntityCadCidade.IDUF(aValue: integer): TModelEntityCadCidade;
begin
  Result := Self;
  FIDUF := aValue;
end;

function TModelEntityCadCidade.IDUF: integer;
begin
  if (FIDUF) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  Result := FIDUF;
end;

function TModelEntityCadCidade.NMCIDADE(aValue: string): TModelEntityCadCidade;
begin
  Result := Self;
  FNMCIDADE := aValue;
end;

function TModelEntityCadCidade.NMCIDADE: string;
begin
  if trim(FNMCIDADE) = '' then
    raise Exception.Create('Nome não pode ser vazio');

  Result := FNMCIDADE;
end;

function TModelEntityCadCidade.NOIBGE(aValue: string): TModelEntityCadCidade;
begin
  Result := Self;
  FNOIBGE := aValue;
end;

function TModelEntityCadCidade.NOIBGE: string;
begin
  if trim(FNOIBGE) = '' then
    raise Exception.Create('IBGE não pode ser vazio');

  Result := FNOIBGE;
end;

end.
