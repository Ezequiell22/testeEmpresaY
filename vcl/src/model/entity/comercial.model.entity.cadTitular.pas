unit comercial.model.entity.cadTitular;

interface

uses
  comercial.model.DAO.interfaces,
  System.Generics.Collections;

type

  TModelEntityCadTitular = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCadTitular>;
    FIDTITULAR: integer;
    FIDEMPRESA: integer;
    FNMTITULAR: String;
    FNUCNPJCPF: String;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCadTitular>);
    destructor Destroy; override;
    function IDTITULAR(aValue: integer): TModelEntityCadTitular; overload;
    function IDTITULAR: integer; overload;
    function IDEMPRESA(aValue: integer): TModelEntityCadTitular; overload;
    function IDEMPRESA: integer; overload;
    function NMTITULAR(aValue: string): TModelEntityCadTitular; overload;
    function NMTITULAR: string; overload;
    function NUCNPJCPF(aValue: string): TModelEntityCadTitular; overload;
    function NUCNPJCPF: string; overload;
    function &End: iModelDAOEntity<TModelEntityCadTitular>;
  end;

implementation

uses
  System.SysUtils;

{ TModelEntityCadTitular }

constructor TModelEntityCadTitular.Create
  (aParent: iModelDAOEntity<TModelEntityCadTitular>);
begin
  FParent := aParent;
end;

destructor TModelEntityCadTitular.Destroy;
begin

  inherited;
end;

function TModelEntityCadTitular.&End: iModelDAOEntity<TModelEntityCadTitular>;
begin
  Result := FParent;
end;

function TModelEntityCadTitular.IDTITULAR(aValue: integer)
  : TModelEntityCadTitular;
begin
  Result := Self;
  FIDTITULAR := aValue;
end;

function TModelEntityCadTitular.IDTITULAR: integer;
begin
  if (FIDTITULAR) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  Result := FIDTITULAR;
end;

function TModelEntityCadTitular.IDEMPRESA(aValue: integer)
  : TModelEntityCadTitular;
begin
  Result := Self;
  FIDEMPRESA := aValue;
end;

function TModelEntityCadTitular.IDEMPRESA: integer;
begin
  if (FIDTITULAR) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  Result := FIDEMPRESA;
end;

function TModelEntityCadTitular.NMTITULAR(aValue: string)
  : TModelEntityCadTitular;
begin
  Result := Self;
  FNMTITULAR := aValue;
end;

function TModelEntityCadTitular.NMTITULAR: string;
begin
  if trim(FNMTITULAR) = '' then
    raise Exception.Create('Nome não pode ser vazio');

  Result := FNMTITULAR;
end;

function TModelEntityCadTitular.NUCNPJCPF(aValue: string)
  : TModelEntityCadTitular;
begin
  Result := Self;
  FNUCNPJCPF := aValue;
end;

function TModelEntityCadTitular.NUCNPJCPF: string;
begin
  if trim(FNUCNPJCPF) = '' then
    raise Exception.Create('Documento não pode ser vazio');

  Result := FNUCNPJCPF;
end;

end.
