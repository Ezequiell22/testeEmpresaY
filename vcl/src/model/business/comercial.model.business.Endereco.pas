unit comercial.model.business.Endereco;

interface

uses
  comercial.model.business.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.DAO.interfaces,
  comercial.model.entity.cadEnderecos,
  Data.DB, Vcl.StdCtrls, System.Classes;

type
  TModelBusinessEndereco = class(TInterfacedObject, iModelBusinessEndereco)
  private
    FQueryAux : iQuery;
    FcadEnderecos : iModelDAOEntity<TModelEntityCadEnderecos>;
    FidEmpresa : integer;
    FidTitular : integer;
    FidEndereco : integer;
    FidUF : integer;
    FidCidade : integer;
    FnmEndereco : string;
    FnuEndereco : string;
    FnuCep : string;
  function IndexOfParcial(const SubStr: string; Strings: TStrings): integer;
  function newId: integer;
  function isNew: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iModelBusinessEndereco;
    function SearchData : iModelBusinessEndereco;
    function idEmpresa(aValue : integer) : iModelBusinessEndereco;
    function idTitular(aValue : integer) : iModelBusinessEndereco;
    function idEndereco(aValue : integer) : iModelBusinessEndereco;
    function idUf(aValue : string) : iModelBusinessEndereco;
    function idCidade(aValue : string) : iModelBusinessEndereco;
    function nmEndereco(aValue : string) : iModelBusinessEndereco;
    function nuEndereco(aValue : string) : iModelBusinessEndereco;
    function nuCep(aValue : string) : iModelBusinessEndereco;
    function LinkDataSource(aDataSource : TDataSource)
      : iModelBusinessEndereco;
    function AbasteceComboBoxUFs(aComboBox: TComboBox): iModelBusinessEndereco;
    function AbasteceComboBoxCidades(aComboBox: TComboBox)
      : iModelBusinessEndereco;
    function saveData : iModelBusinessEndereco;
  end;

implementation

uses
  comercial.model.types.Db,
  comercial.model.resource.impl.queryFiredac,
  comercial.model.DAO.CadEnderecos,
  Generics.Collections,
  System.SysUtils;

{ TModelBusinessEndereco }

function TModelBusinessEndereco.isNew: boolean;
begin
    FQueryAux
      .active(false)
      .sqlClear
      .sqlAdd('select * from cadEnderecos')
      .sqlAdd('where idEndereco = :idEndereco')
      .addParam('idEndereco', FidEndereco)
      .open;

    result := FQueryAux.DataSet.IsEmpty;
end;

function TModelBusinessEndereco.newId: integer;
begin
  FQueryAux
    .active(false)
    .sqlClear
      .sqlAdd('select (max(nullif(idEndereco, 0 )) + 1) idE ')
      .sqlAdd('from cadEnderecos')
      .open;

  result := FQueryAux.DataSet.FieldByName('idE').AsInteger;
end;

function TModelBusinessEndereco.IndexOfParcial(const SubStr: string; Strings: TStrings): integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to Strings.Count - 1 do
  begin
    if Pos(UpperCase(SubStr), UpperCase(Strings[I])) > 0 then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TModelBusinessEndereco.AbasteceComboBoxCidades(aComboBox: TComboBox)
:iModelBusinessEndereco;
begin
  result := Self;
  aComboBox.Items.Clear;

  if FidUF <= 0 then
   raise Exception.Create('Informe o idUf');

  FQueryAux
    .sqlClear
    .sqlAdd('select idCidade, nmCidade  ')
    .sqlAdd('from cadCidade')
    .sqlAdd('where idUF = :idUF ')
    .addParam('idUF', FidUF)
    .open;

  var dataSet := FQueryAux
    .DataSet;

  while not dataset.Eof do
  begin
    aComboBox.Items.Add(
    dataset.FieldByName('idCidade').AsString + ' - '+
    dataset.FieldByName('nmCidade').AsString);
    dataset.Next;
  end;

  aComboBox.ItemIndex := IndexOfParcial(FidCidade.ToString + ' - ',
    aComboBox.Items);
end;

function TModelBusinessEndereco.AbasteceComboBoxUFs(aComboBox: TComboBox):
iModelBusinessEndereco;
begin
  result := Self;
  aComboBox.Items.Clear;

  FQueryAux
    .sqlClear
    .sqlAdd('select idUf, nmEstado  ')
    .sqlAdd('from cadUf')
    .open;

  var dataSet := FQueryAux
    .DataSet;

  while not dataset.Eof do
  begin
    aComboBox.Items.Add(
    dataset.FieldByName('idUf').AsString + ' - '+
    dataset.FieldByName('nmEstado').AsString);
    dataset.Next;
  end;

  aComboBox.ItemIndex := IndexOfParcial(FidUF.ToString + ' - ',
    aComboBox.Items);
end;

constructor TModelBusinessEndereco.Create;
begin
  FQueryAux := TModelResourceQueryFiredac.New(tcFbTeste);
  FcadEnderecos := TModelDaoCadEnderecos.new;
end;

destructor TModelBusinessEndereco.Destroy;
begin

  inherited;
end;

function TModelBusinessEndereco.idCidade(
  aValue: string): iModelBusinessEndereco;
begin
  result := Self;
  FidCidade := 0;
  if (aValue.Contains('-')) then
  begin
     FidCidade := strToint(Trim(copy(aValue, 1, pos('-',aValue) - 1)));
  end;
end;

function TModelBusinessEndereco.idEmpresa(
  aValue: integer): iModelBusinessEndereco;
begin
  result := Self;
  FidEmpresa := aValue;
end;

function TModelBusinessEndereco.idEndereco(
  aValue: integer): iModelBusinessEndereco;
begin
  result := Self;
  FidEndereco := aValue;
end;

function TModelBusinessEndereco.idTitular(
  aValue: integer): iModelBusinessEndereco;
begin
  result := Self;
  FidTitular := aValue;
end;

function TModelBusinessEndereco.idUf(aValue: string): iModelBusinessEndereco;
begin
  result := Self;
  FidUF := 0;
  if (aValue.Contains('-')) then
  begin
     FidUF :=strToint(Trim(copy(aValue, 1, pos('-', aValue) - 1)));
  end;
end;

function TModelBusinessEndereco.LinkDataSource(
  aDataSource: TDataSource): iModelBusinessEndereco;
begin
  result := Self;
  aDataSource.DataSet := FcadEnderecos.GetDataSet;
end;

class function TModelBusinessEndereco.New : iModelBusinessEndereco;
begin
  result := Self.create;
end;

function TModelBusinessEndereco.nmEndereco(
  aValue: string): iModelBusinessEndereco;
begin
  result := Self;
  FnmEndereco := aValue;
end;

function TModelBusinessEndereco.nuCep(aValue: string): iModelBusinessEndereco;
begin
  result := Self;
  FnuCep := aValue;
end;

function TModelBusinessEndereco.nuEndereco(
  aValue: string): iModelBusinessEndereco;
begin
  result := Self;
  FnuEndereco := aValue;
end;

function TModelBusinessEndereco.saveData: iModelBusinessEndereco;
begin
  result := Self;

  if isNew then
  begin
    FcadEnderecos
      .This
        .IDENDERECO(newId)
        .IDTITULAR(FidTitular)
        .IDEMPRESA(FidEmpresa)
        .NMENDERECO(FnmEndereco)
        .NUENDERECO(FnuEndereco)
        .NUCEP(FnuCep)
        .IDCIDADE(FidCidade)
        .IDUF(FidUF)
        .STATIVO('N')
        .&End
      .Insert;
  end
  else
  begin
    FcadEnderecos
      .This
        .IDENDERECO(FidEndereco)
        .IDTITULAR(FidTitular)
        .IDEMPRESA(FidEmpresa)
        .NMENDERECO(FnmEndereco)
        .NUENDERECO(FnuEndereco)
        .NUCEP(FnuCep)
        .IDCIDADE(FidCidade)
        .IDUF(FidUF)
        .&End
      .update;
  end;

end;

function TModelBusinessEndereco.SearchData : iModelBusinessEndereco;
var
  params: Tdictionary<string, variant>;
begin
  result := Self;
  params := Tdictionary<string, variant>.Create;
  try
    params.Add('idEndereco', FidEndereco);
    params.Add('idTitular', FidTitular);
    params.Add('idEmpresa', FidEmpresa);

    FcadEnderecos
      .Get(params);

    FidUF := FcadEnderecos.GetDataSet.FieldByName('idUF').AsInteger;
    FidCidade := FcadEnderecos.GetDataSet.FieldByName('idCidade').AsInteger;
  finally
    params.Free;
  end;
end;

end.
