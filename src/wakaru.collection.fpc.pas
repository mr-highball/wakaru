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
    FList : TInternalList;
  protected
    function GetCount: Cardinal;
    function GetItem(constref AIndex : Cardinal): T;
  public
    property Count : Cardinal read GetCount;
    property Items[constref AIndex : Cardinal] : T read GetItem;

    procedure Clear();
    procedure Delete(constref AIndex : Cardinal);
    function Add(constref AItem : T) : Cardinal;
    function Range(constref AStartIndex, AEndIndex : Cardinal) : IInterfaceCollection<T>;

    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TInterfaceCollectionImpl }

function TInterfaceCollectionImpl<T>.GetCount: Cardinal;
begin
  Result := FList.Count
end;

function TInterfaceCollectionImpl<T>.GetItem(constref AIndex: Cardinal): T;
begin
  Result := FList[AIndex];
end;

procedure TInterfaceCollectionImpl<T>.Clear();
begin
  FList.Clear;
end;

procedure TInterfaceCollectionImpl<T>.Delete(constref AIndex: Cardinal);
begin
  FList.Delete(AIndex);
end;

function TInterfaceCollectionImpl<T>.Add(constref AItem: T): Cardinal;
begin
  FList.Add(AItem)
end;

function TInterfaceCollectionImpl<T>.Range(constref AStartIndex,
  AEndIndex: Cardinal): IInterfaceCollection<T>;
var
  I : Integer;
begin
  Result := TInterfaceCollectionImpl<T>.Create;

  for I := AStartIndex to AEndIndex do
    Result.Add(FList[I]);
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

