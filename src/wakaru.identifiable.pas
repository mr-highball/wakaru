unit wakaru.identifiable;

{$mode delphi}

interface

uses
  Classes,
  SysUtils,
  wakaru.types;

type

    { TIdentifiableImpl }
    (*
      base implementation of an Identifiable
    *)
    TIdentifiableImpl = class(TInterfacedObject, IIdentifiable)
    strict private
      FID,
      FTag : String;
    private
      function GetID: String;
      function GetTag: String;
      procedure SetTag(const AValue: String);
    strict protected
      (*
        initializes the ID string, can be overridden by children
      *)
      function DoInitID : String; virtual;
    public
      property ID : String read GetID;
      property Tag : String read GetTag write SetTag;

      constructor Create; virtual;
      destructor Destroy; override;
    end;

implementation

{ TIdentifiableImpl }

function TIdentifiableImpl.GetID: String;
begin
  Result := FID;
end;

function TIdentifiableImpl.GetTag: String;
begin
  Result := FTag;
end;

procedure TIdentifiableImpl.SetTag(const AValue: String);
begin
  FTag := AValue;
end;

function TIdentifiableImpl.DoInitID: String;
begin
  Result := TGuid.NewGuid.ToString();
end;

constructor TIdentifiableImpl.Create;
begin
  FID := DoInitID;
end;

destructor TIdentifiableImpl.Destroy;
begin
  inherited Destroy;
end;

end.

