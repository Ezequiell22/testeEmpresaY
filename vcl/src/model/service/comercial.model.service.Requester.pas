unit comercial.model.service.Requester;

interface

uses
  System.SysUtils,
  System.Classes,
  RESTRequest4D,
  System.NetEncoding,
  comercial.model.service.interfaces;

type
  TModelServiceRequester = class(TInterfacedObject, iModelServiceRequester)
  private
    FBaseURL: string;
    FUsername: string;
    FPassword: string;
    function BuildURLWithParams(const AEndpoint: string;
      const AParams: TStrings): string;

  var
  public
    constructor Create(const ABaseURL, AUsername, APassword: string);
    class function New(const ABaseURL, AUsername, APassword: string)
      : iModelServiceRequester;
    function Get(const AEndpoint: string): string;
    function Post(const AEndpoint, ABody: string): string;
    function Put(const AEndpoint, ABody: string; aId: string): string;
    function Delete(const AEndpoint: string; aId: string): string;
  end;

implementation

{ TModelServiceRequester }

function TModelServiceRequester.BuildURLWithParams(const AEndpoint: string;
  const AParams: TStrings): string;
var
  ParamString: string;
begin
  if Assigned(AParams) and (AParams.Count > 0) then
  begin
    ParamString := AParams.DelimitedText;
    Result := FBaseURL + AEndpoint + '?' + ParamString;
  end
  else
    Result := FBaseURL + AEndpoint;
end;

constructor TModelServiceRequester.Create(const ABaseURL, AUsername,
  APassword: string);
begin
  FBaseURL := ABaseURL;
  FUsername := AUsername;
  FPassword := APassword;
end;

function TModelServiceRequester.Get(const AEndpoint: string): string;
var
  response: IResponse;
begin

  response := TRequest.New.BaseURL(FBaseURL + AEndpoint)
    .Accept('application/json').BasicAuthentication(FUsername, FPassword).Get;

  Result := response.content;

  if response.statusCode <> 200 then
    raise Exception.Create('Error ' + response.content);

end;

class function TModelServiceRequester.New(const ABaseURL, AUsername,
  APassword: string): iModelServiceRequester;
begin
  Result := Self.Create(ABaseURL, AUsername, APassword)
end;

function TModelServiceRequester.Post(const AEndpoint, ABody: string): string;
var
  response: IResponse;
begin

  response := TRequest.New.BaseURL(FBaseURL + AEndpoint)
    .Accept('application/json').BasicAuthentication(FUsername, FPassword)
    .AddBody(ABody, 'application/json').Post;

  Result := response.content;

  if response.statusCode <> 201 then
    raise Exception.Create('Error ' + response.content);
end;

function TModelServiceRequester.Put(const AEndpoint, ABody: string;
  aId: string): string;
var
  response: IResponse;
begin

  response := TRequest.New.BaseURL(FBaseURL + AEndpoint + '/' + aId)
    .Accept('application/json').BasicAuthentication(FUsername, FPassword)
    .AddBody(ABody, 'application/json').Put;

  Result := response.content;

  if response.statusCode <> 200 then
    raise Exception.Create('Error ' + response.content);
end;

function TModelServiceRequester.Delete(const AEndpoint: string;
  aId: string): string;
var
  response: IResponse;
begin

  response := TRequest.New.BaseURL(FBaseURL + AEndpoint + '/' + aId)
    .Accept('application/json').BasicAuthentication(FUsername,
    FPassword).Delete;

  Result := response.content;

  if response.statusCode <> 200 then
    raise Exception.Create('Error ' + response.content);
end;

end.
