unit comercial.model.business.interfaces;

interface

uses System.Generics.Collections,
  Data.DB,
  System.Classes,
  Vcl.CheckLst,
  Vcl.StdCtrls,
  Vcl.DBGrids,
  Vcl.Grids;

type

  iModelBusinessListTasks = interface
    ['{D3BF03B9-F4F6-49DF-8791-0965F3618F28}']
    procedure DisplayTasks(aGrid: TstringGrid);
    procedure DisplayInfos(edtQtdAll, edtAvgPriority, edtQtdDone: TEdit);
  end;

  iModelBusinessTask = interface
    ['{D3BF03B9-F4F6-49DF-8791-0965F3618F28}']
    function Id(aValue: integer): iModelBusinessTask;
    function Description(aValue: string): iModelBusinessTask;
    function Status(aValue: integer): iModelBusinessTask;
    function Priority(aValue: integer): iModelBusinessTask;
    function DeleteTask: iModelBusinessTask;
    function CreateTask: iModelBusinessTask;
    function UpdateTask: iModelBusinessTask;
  end;

implementation

end.
