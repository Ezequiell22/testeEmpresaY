unit comercial.model.entity.cadUF;

interface

uses
  comercial.model.DAO.interfaces,
  System.Generics.Collections;

type

  TModelEntityCadUF = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCadUF>;
    FIDUF: integer;
    FNMESTADO: String;
    FSGESTADO: String;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCadUF>);
    destructor Destroy; override;
    function IDUF(aValue: integer): TModelEntityCadUF; overload;
    function IDUF: integer; overload;
    function NMESTADO(aValue: string): TModelEntityCadUF; overload;
    function NMESTADO: string; overload;
    function SGESTADO(aValue: string): TModelEntityCadUF; overload;
    function SGESTADO: string; overload;
    function &End: iModelDAOEntity<TModelEntityCadUF>;
  end;

implementation

uses
  System.SysUtils;

{ TModelEntityCadUF }

constructor TModelEntityCadUF.Create
  (aParent: iModelDAOEntity<TModelEntityCadUF>);
begin
  FParent := aParent;
end;

destructor TModelEntityCadUF.Destroy;
begin

  inherited;
end;

function TModelEntityCadUF.&End: iModelDAOEntity<TModelEntityCadUF>;
begin
  Result := FParent;
end;

function TModelEntityCadUF.IDUF(aValue: integer): TModelEntityCadUF;
begin
  Result := Self;
  FIDUF := aValue;
end;

function TModelEntityCadUF.IDUF: integer;
begin
  if (FIDUF) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  Result := FIDUF;
end;

function TModelEntityCadUF.NMESTADO(aValue: string): TModelEntityCadUF;
begin
  Result := Self;
  FNMESTADO := aValue;
end;

function TModelEntityCadUF.NMESTADO: string;
begin
  if trim(FNMESTADO) = '' then
    raise Exception.Create('A coluna Estado não pode ser vazia');

  Result := FNMESTADO;
end;

function TModelEntityCadUF.SGESTADO(aValue: string): TModelEntityCadUF;
begin
  Result := Self;
  FSGESTADO := aValue;
end;

function TModelEntityCadUF.SGESTADO: string;
begin
  if trim(FSGESTADO) = '' then
    raise Exception.Create('Sigla não pode ser vazia');

  Result := FSGESTADO;
end;

end.
