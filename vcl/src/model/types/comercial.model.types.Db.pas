unit comercial.model.types.Db;

interface

type
  TDataBaseType = (
    tcSQlServerErechimProducao,
    tcSqlServerErechimWms,
    tcSqlServerSped,
    tcFBTeste,
    tcUnknown);

function typeToStrDb(aValue: TDataBaseType): string;
function getStrTypes: TArray<string>;
function strToTypeDb(aValue: string): TDataBaseType;
function strToTypeDbIndex(aValue: string): Integer;
function typeToIndex(aValue: TDataBaseType): Integer;
function indexToStrDb(aIndex: Integer): string;
function indexToTypeDb(aIndex: Integer): TDataBaseType;

implementation

function indexToTypeDb(aIndex: Integer): TDataBaseType;
begin
  result := TDataBaseType(aIndex);
end;

function indexToStrDb(aIndex: Integer): string;
begin
  case TDataBaseType(aIndex) of
    tcSQlServerErechimProducao:
      result := 'ErechimProducao';
    tcSqlServerErechimWms:
      result := 'ErechimWms';
    tcSqlServerSped:
      result := 'Sped';
    tcFBTeste:
      result := 'Banco';
    tcUnknown:
      result := 'Unknown';
  else
    result := 'Invalid Index';
  end;
end;

function typeToIndex(aValue: TDataBaseType): Integer;
begin
  result := Ord(aValue);
end;

function strToTypeDbIndex(aValue: string): Integer;
var
  dbType: TDataBaseType;
begin
  dbType := strToTypeDb(aValue);
  result := typeToIndex(dbType);
end;

function typeToStrDb(aValue: TDataBaseType): string;
begin

  case aValue of
    tcSQlServerErechimProducao:
      result := 'ErechimProducao';
    tcSqlServerErechimWms:
      result := 'ErechimWms';
    tcSqlServerSped:
      result := 'Sped';
    tcFBTeste:
      result := 'dados';
  else
    result := '';
  end;

end;

function strToTypeDb(aValue: string): TDataBaseType;
begin
  if aValue = 'tcSqlServerErechimProducao' then
    result := tcSQlServerErechimProducao
  else if aValue = 'tcSqlServerErechimWms' then
    result := tcSqlServerErechimWms
  else if aValue = 'tcSqlServerSped' then
    result := tcSqlServerSped
  else
    result := tcUnknown;
end;

function getStrTypes: TArray<string>;
var
  tp: TDataBaseType;
  i: Integer;
begin
  SetLength(result, Ord(High(TDataBaseType)) + 1);
  i := 0;
  for tp := Low(TDataBaseType) to High(TDataBaseType) do
  begin

    result[i] := typeToStrDb(tp);
    Inc(i);
  end;
end;

end.
