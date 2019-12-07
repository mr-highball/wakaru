{ wakaru

  Copyright (c) 2019 mr-highball

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
}
unit wakaru.collection.fpc;

{$mode delphi}

interface

uses
  Classes,
  SysUtils,
  wakaru.collection,
  fgl;

type

  { TInterfaceCollectionImpl }
  (*
    fpc implementation for a generic interface collection
  *)
  TInterfaceCollectionImpl<T> = class(TInterfacedObject, IInterfaceCollection<T>)
  strict protected
    type
    TInternalList = TFPGInterfacedObjectList<T>;
  private
    FList: TInternalList;
  protected
    function GetCount: cardinal;
    function GetItem(const AIndex: cardinal): T;
  public
    property Count: cardinal read GetCount;
    property Items[const AIndex: cardinal]: T read GetItem;

    procedure Clear();
    procedure Delete(const AIndex: cardinal);
    function Add(const AItem: T): cardinal;
    function Range(const AStartIndex, AEndIndex: cardinal): IInterfaceCollection<T>;
    function ForEach(const AMethod: TCallbackForEachItem<T>; const AData : Pointer): IInterfaceCollection<T>; overload;
    function ForEach(const AMethod : TNestedForEachItem<T>; const AData : Pointer) : IInterfaceCollection<T>; overload;
    function ForEachObj(const AMethod : TObjectForEachItem<T>) : IInterfaceCollection<T>;

    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TInterfaceCollectionImpl }

function TInterfaceCollectionImpl<T>.GetCount: cardinal;
begin
  Result := FList.Count;
end;

function TInterfaceCollectionImpl<T>.GetItem(const AIndex: cardinal): T;
begin
  Result := FList[AIndex];
end;

procedure TInterfaceCollectionImpl<T>.Clear();
begin
  FList.Clear;
end;

procedure TInterfaceCollectionImpl<T>.Delete(const AIndex: cardinal);
begin
  FList.Delete(AIndex);
end;

function TInterfaceCollectionImpl<T>.Add(const AItem: T): cardinal;
begin
  FList.Add(AItem);
end;

function TInterfaceCollectionImpl<T>.Range(const AStartIndex, AEndIndex: cardinal):IInterfaceCollection<T>;
var
  I: integer;
begin
  Result := TInterfaceCollectionImpl<T>.Create;

  for I := AStartIndex to AEndIndex do
    if I > FList.Count then
      Break
    else
      Result.Add(FList[I]);
end;

function TInterfaceCollectionImpl<T>.ForEach(const AMethod: TCallbackForEachItem<T>;
  const AData : Pointer):IInterfaceCollection<T>;
var
  I: Integer;
begin
  Result := Self;

  if not Assigned(AMethod) then
    Exit;

  //iterate list and pass item to method
  for I := 0 to Pred(FList.Count) do
    AMethod(FList[I], I, AData);
end;

function TInterfaceCollectionImpl<T>.ForEach(const
  AMethod: TNestedForEachItem<T>; const AData : Pointer): IInterfaceCollection<T>;
var
  I: Integer;
begin
  Result := Self;

  if not Assigned(AMethod) then
    Exit;

  //iterate list and pass item to method
  for I := 0 to Pred(FList.Count) do
    AMethod(FList[I], I, AData);
end;

function TInterfaceCollectionImpl<T>.ForEachObj(const
  AMethod: TObjectForEachItem<T>): IInterfaceCollection<T>;
var
  I: Integer;
begin
  Result := Self;

  if not Assigned(AMethod) then
    Exit;

  //iterate list and pass item to method
  for I := 0 to Pred(FList.Count) do
    AMethod(FList[I], I);
end;

constructor TInterfaceCollectionImpl<T>.Create;
begin
  FList := TInternalList.Create;
end;

destructor TInterfaceCollectionImpl<T>.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

end.
