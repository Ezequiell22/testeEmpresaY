unit comercial.model.service.RequesterFactory;

interface

uses
  comercial.model.service.Requester,
  comercial.model.service.interfaces,
  System.SysUtils;

type
  TModelServiceFactory = class(TInterfacedObject, iModelServiceFactory )
  private
    FRequester: iModelServiceRequester;
  public
    constructor Create(const ABaseURL, AUsername, APassword: string);
    destructor destroy; override;
    class function new(const ABaseURL, AUsername, APassword: string)
      : iModelServiceFactory;
    function api : iModelServiceRequester;
  end;

implementation

{ TModelServiceFactory }

function TModelServiceFactory.api: iModelServiceRequester;
begin
  result := FRequester;
end;

constructor TModelServiceFactory.Create(const ABaseURL, AUsername,
  APassword: string);
begin
  FRequester := TModelServiceRequester.Create(ABaseURL, AUsername, APassword);
end;

destructor TModelServiceFactory.destroy;
begin

  inherited;
end;

class function TModelServiceFactory.new(const ABaseURL, AUsername,
  APassword: string): iModelServiceFactory;
begin
  Result := self.Create(ABaseURL, AUsername, APassword)
end;

end.
