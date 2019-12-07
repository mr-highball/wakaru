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
unit wakaru.collection;

{$mode delphi}
{$ModeSwitch nestedprocvars}

interface

uses
  Classes,
  SysUtils;

type
  TCallbackForEachItem<T> = procedure(const AItem : T; const AIndex : Cardinal; const AData : Pointer);
  TNestedForEachItem<T> = procedure(const AItem : T; const AIndex : Cardinal; const AData : Pointer) is nested;
  TObjectForEachItem<T> = procedure(const AItem : T; const AIndex : Cardinal) of object;

  { IInterfaceCollection }
  (*
    a reference counted collection of items of type T where
    T should be an interface type
  *)
  IInterfaceCollection<T> = interface
    ['{9FCC8175-81B9-402C-9811-92FE2F7CBA35}']

    //property methods
    function GetCount: Cardinal;
    function GetItem(const AIndex : Cardinal): T;

    //properties
    property Count : Cardinal read GetCount;
    property Items[const AIndex : Cardinal] : T read GetItem; default;

    //methods
    procedure Clear();
    procedure Delete(const AIndex : Cardinal);
    function Add(const AItem : T) : Cardinal;
    function Range(const AStartIndex, AEndIndex : Cardinal) : IInterfaceCollection<T>;

    (*
      allows caller to provide a custom function that acts on each item
      of the collection then returns "this" collection after finishing

      note:
        the object method ForEach is named differently due to the compiler
        being "unsure" of which overload to call
    *)
    function ForEach(const AMethod : TCallbackForEachItem<T>; const AData : Pointer = nil) : IInterfaceCollection<T>; overload;
    function ForEach(const AMethod : TNestedForEachItem<T>; const AData : Pointer = nil) : IInterfaceCollection<T>; overload;
    function ForEachObj(const AMethod : TObjectForEachItem<T>) : IInterfaceCollection<T>;
  end;

  (*
    creates a new collection for a given interface type
  *)
  function CreateCollection<T : IInterface>() : IInterfaceCollection<T>;
implementation
uses
{$IFDEF FPC}
  wakaru.collection.fpc;
{$ELSE}
  wakaru.collection.delphi; //todo - add this unit and implement TInterfaceCollectionImpl
{$ENDIF}

function CreateCollection<T>(): IInterfaceCollection<T>;
begin
  Result := TInterfaceCollectionImpl<T>.Create;
end;


end.

