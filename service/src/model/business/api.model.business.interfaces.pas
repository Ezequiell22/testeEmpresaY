unit api.model.business.interfaces;

interface

uses System.Generics.Collections,
  Data.DB,
  System.Classes,
  Vcl.CheckLst,
  Vcl.StdCtrls,
  Vcl.DBGrids,
  api.model.DAO.interfaces,
  System.JSON;

type

  iModelBusinessTask = interface
    ['{D3BF03B9-F4F6-49DF-8791-0965F3618F28}']
    function GetAllData: TjsonObject;
    function DeleteDataById( aId : string) : TjsonObject;
    function InsertData( aBody : TJSONObject) : TjsonObject;
    function UpdateData( aBody : TJSONObject; aID : string) : TjsonObject;
    function getInfos : TJsonObJect;
  end;

implementation

end.
