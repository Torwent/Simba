{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
}
unit simba.vartype_ordarray;

{$i simba.inc}

interface

uses
  Classes, SysUtils,
  simba.base;

type
  TByteArrayHelper = type helper for TByteArray
    function ToString: String;
    procedure FromString(Value: String);
  end;
  TIntegerArrayHelper = type helper for TIntegerArray
    function Equals(Other: TIntegerArray): Boolean;
    function IndexOf(Value: Integer): Integer;
    function IndicesOf(Value: Integer): TIntegerArray;
    function Min: Integer;
    function Max: Integer;
    function Sum: Int64;
    function Unique: TIntegerArray;
    procedure Sort;

    function Difference(Other: TIntegerArray): TIntegerArray;
    function SymmetricDifference(Other: TIntegerArray): TIntegerArray;
    function Intersection(Other: TIntegerArray): TIntegerArray;
  end;

  TInt64ArrayHelper = type helper for TInt64Array
    function Difference(Other: TInt64Array): TInt64Array;
    function SymmetricDifference(Other: TInt64Array): TInt64Array;
    function Intersection(Other: TInt64Array): TInt64Array;
    function Min: Int64;
    function Max: Int64;
    function Sum: Int64;
    function Unique: TInt64Array;
    procedure Sort;
  end;

  TSingleArrayHelper = type helper for TSingleArray
    function Min: Single;
    function Max: Single;
    function Sum: Double;
    function Unique: TSingleArray;
    procedure Sort;
  end;

  TDoubleArrayHelper = type helper for TDoubleArray
    function Min: Double;
    function Max: Double;
    function Sum: Double;
    function Unique: TDoubleArray;
    procedure Sort;
  end;

implementation

uses
  Math,
  simba.array_algorithm;

function TByteArrayHelper.ToString: String;
begin
  SetLength(Result, Length(Self));
  if (Length(Result) > 0) then
    Move(Self[0], Result[1], Length(Self));
end;

procedure TByteArrayHelper.FromString(Value: String);
begin
  SetLength(Self, Length(Value));
  if (Length(Self) > 0) then
    Move(Value[1], Self[0], Length(Value));
end;
function TIntegerArrayHelper.Equals(Other: TIntegerArray): Boolean;
begin
  Result := specialize TArrayEquals<Integer>.Equals(Self, Other);
end;

function TIntegerArrayHelper.IndexOf(Value: Integer): Integer;
begin
  Result := specialize TArrayIndexOf<Integer>.IndexOf(Value, Self);
end;

function TIntegerArrayHelper.IndicesOf(Value: Integer): TIntegerArray;
begin
  Result := specialize TArrayIndexOf<Integer>.IndicesOf(Value, Self);
end;

function TIntegerArrayHelper.Min: Integer;
begin
  Result := specialize MinA<Integer>(Self);
end;

function TIntegerArrayHelper.Max: Integer;
begin
  Result := specialize MaxA<Integer>(Self);
end;

function TIntegerArrayHelper.Sum: Int64;
begin
  Result := specialize Sum<Integer, Int64>(Self);
end;

function TIntegerArrayHelper.Unique: TIntegerArray;
begin
  Result := specialize TArrayUnique<Integer>.Unique(Self);
end;

procedure TIntegerArrayHelper.Sort;
begin
  specialize TArraySort<Integer>.QuickSort(Self, Low(Self), High(Self));
end;

function TIntegerArrayHelper.Difference(Other: TIntegerArray): TIntegerArray;
begin
  Result := specialize TArrayRelationship<Integer>.Difference(Self, Other);
end;

function TIntegerArrayHelper.SymmetricDifference(Other: TIntegerArray): TIntegerArray;
begin
  Result := specialize TArrayRelationship<Integer>.SymmetricDifference(Self, Other);
end;

function TIntegerArrayHelper.Intersection(Other: TIntegerArray): TIntegerArray;
begin
  Result := specialize TArrayRelationship<Integer>.Intersection(Self, Other);
end;

function TInt64ArrayHelper.Difference(Other: TInt64Array): TInt64Array;
begin
  Result := specialize TArrayRelationship<Int64>.Difference(Self, Other);
end;

function TInt64ArrayHelper.SymmetricDifference(Other: TInt64Array): TInt64Array;
begin
   Result := specialize TArrayRelationship<Int64>.SymmetricDifference(Self, Other);
end;

function TInt64ArrayHelper.Intersection(Other: TInt64Array): TInt64Array;
begin
  Result := specialize TArrayRelationship<Int64>.Intersection(Self, Other);
end;

function TInt64ArrayHelper.Min: Int64;
begin
  Result := specialize MinA<Int64>(Self);
end;

function TInt64ArrayHelper.Max: Int64;
begin
  Result := specialize MaxA<Int64>(Self);
end;

function TInt64ArrayHelper.Sum: Int64;
begin
  Result := specialize Sum<Int64, Int64>(Self);
end;

function TInt64ArrayHelper.Unique: TInt64Array;
begin
  Result := specialize TArrayUnique<Int64>.Unique(Self);
end;

procedure TInt64ArrayHelper.Sort;
begin
  specialize TArraySort<Int64>.QuickSort(Self, Low(Self), High(Self));
end;

function TSingleArrayHelper.Min: Single;
begin
  Result := specialize MinA<Single>(Self);
end;

function TSingleArrayHelper.Max: Single;
begin
  Result := specialize MaxA<Single>(Self);
end;

function TSingleArrayHelper.Sum: Double;
begin
  Result := specialize Sum<Single, Double>(Self);
end;

function TSingleArrayHelper.Unique: TSingleArray;

  function Same(const L,R: Single): Boolean;
  begin
    Result := SameValue(L, R);
  end;

begin
  Result := specialize TArrayUnique<Single>.Unique(Self, @Same);
end;

procedure TSingleArrayHelper.Sort;
begin
  specialize TArraySort<Single>.QuickSort(Self, Low(Self), High(Self));
end;

function TDoubleArrayHelper.Min: Double;
begin
  Result := specialize MinA<Double>(Self);
end;

function TDoubleArrayHelper.Max: Double;
begin
  Result := specialize MaxA<Double>(Self);
end;

function TDoubleArrayHelper.Sum: Double;
begin
  Result := specialize Sum<Double, Double>(Self);
end;

function TDoubleArrayHelper.Unique: TDoubleArray;

  function Same(const L, R: Double): Boolean;
  begin
    Result := SameValue(L, R);
  end;

begin
  Result := specialize TArrayUnique<Double>.Unique(Self, @Same);
end;

procedure TDoubleArrayHelper.Sort;
begin
  specialize TArraySort<Double>.QuickSort(Self, Low(Self), High(Self));
end;

end.

