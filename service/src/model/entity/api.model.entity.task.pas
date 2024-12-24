unit api.model.entity.task;

interface

uses
  api.model.DAO.interfaces,
  System.Generics.Collections;

type

  TModelEntityTask = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityTask>;
    FID: integer;
    FDESCRIPTION: String;
    FSTATUS: String;// created - pendent - done
    FPRIORITY: integer; // 0 a 10
    FDATECREATED: TDatetime;

  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityTask>);
    destructor Destroy; override;
    function ID(aValue: integer): TModelEntityTask; overload;
    function ID: integer; overload;
    function DESCRIPTION(aValue: string): TModelEntityTask; overload;
    function DESCRIPTION: string; overload;
    function STATUS(aValue: string): TModelEntityTask; overload;
    function STATUS: string; overload;
    function PRIORITY(aValue: integer): TModelEntityTask; overload;
    function PRIORITY: integer; overload;
    function DATECREATED(aValue: TDatetime): TModelEntityTask; overload;
    function DATECREATED: TDatetime; overload;
    function &End: iModelDAOEntity<TModelEntityTask>;
  end;

implementation

uses
  System.SysUtils;

{ TModelEntityTask }

constructor TModelEntityTask.Create(aParent: iModelDAOEntity<TModelEntityTask>);
begin
  FParent := aParent;
end;

function TModelEntityTask.DATECREATED(aValue: TDatetime): TModelEntityTask;
begin
  result := Self;
  FDATECREATED := aValue;
end;

function TModelEntityTask.DATECREATED: TDatetime;
begin
  result := FDATECREATED;
end;

function TModelEntityTask.DESCRIPTION: string;
begin
  result := FDESCRIPTION;
end;

function TModelEntityTask.DESCRIPTION(aValue: string): TModelEntityTask;
begin
  result := Self;
  FDESCRIPTION := aValue;
end;

destructor TModelEntityTask.Destroy;
begin

  inherited;
end;

function TModelEntityTask.&End: iModelDAOEntity<TModelEntityTask>;
begin
  result := FParent;
end;

function TModelEntityTask.ID: integer;
begin
  result := FID;
end;

function TModelEntityTask.ID(aValue: integer): TModelEntityTask;
begin
  result := Self;
  FID := aValue;
end;

function TModelEntityTask.PRIORITY: integer;
begin
  result := FPRIORITY;
end;

function TModelEntityTask.PRIORITY(aValue: integer): TModelEntityTask;
begin
  result := Self;
  FPRIORITY := aValue;
end;

function TModelEntityTask.STATUS(aValue: string): TModelEntityTask;
begin
  result := Self;
  FSTATUS := aValue;
end;

function TModelEntityTask.STATUS: string;
begin
  result := FSTATUS;
end;

end.
