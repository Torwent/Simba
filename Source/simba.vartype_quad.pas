{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
}
unit simba.vartype_quad;

{$i simba.inc}

interface

uses
  Classes, SysUtils,
  simba.base;

type
  TQuad = record
    Top: TPoint;
    Right: TPoint;
    Bottom: TPoint;
    Left: TPoint;
  end;
  TQuadArray = array of TQuad;

  TQuadHelper = type helper for TQuad
  private
    function GetCorners: TPointArray; inline;
    function GetMean: TPoint; inline;
    function GetArea: Integer; inline;
    function GetBounds: TBox; inline;
    function GetShortSideLen: Integer; inline;
    function GetLongSideLen: Integer; inline;
  public const
    EMPTY: TQuad = (Top: (X:0; Y:0); Right: (X:0; Y:0); Bottom: (X:0; Y:0); Left: (X:0; Y:0));
  public
    class function Create(ATop, ARight, ABottom, ALeft: TPoint): TQuad; static; inline; overload;
    class function CreateFromBox(Box: TBox): TQuad; static; inline; overload;
    class function CreateFromPoints(Points: TPointArray): TQuad; static; inline; overload;

    function RandomPoint: TPoint;
    function RandomPointCenter: TPoint;

    function Rotate(Radians: Double): TQuad;
    function Contains(P: TPoint): Boolean; inline;
    function Offset(P: TPoint): TQuad; inline;
    function Expand(Amount: Integer): TQuad;
    function NearestEdge(P: TPoint): TPoint;
    function Normalize: TQuad; inline;

    property Corners: TPointArray read GetCorners;
    property Mean: TPoint read GetMean;
    property Area: Integer read GetArea;
    property Bounds: TBox read GetBounds;
    property ShortSideLen: Integer read GetShortSideLen;
    property LongSideLen: Integer read GetLongSideLen;
  end;

  TQuadArrayHelper = type helper for TQuadArray
  public
    function Merge: TQuad;
    function Means: TPointArray;
    function Offset(P: TPoint): TQuadArray;
    function Expand(SizeMod: Integer): TQuadArray;
    function ContainsPoint(P: TPoint): Integer;
    function Sort(Weights: TIntegerArray; LowToHigh: Boolean = True): TQuadArray; overload;
    function Sort(Weights: TDoubleArray; LowToHigh: Boolean = True): TQuadArray; overload;
    function SortFrom(From: TPoint): TQuadArray;
    function SortByShortSide(LowToHigh: Boolean = True): TQuadArray;
    function SortByLongSide(LowToHigh: Boolean = True): TQuadArray;
    function SortByArea(LowToHigh: Boolean = True): TQuadArray;
  end;

  operator in(const P: TPoint; const Quad: TQuad): Boolean;

implementation

uses
  Math,
  simba.math, simba.vartype_pointarray, simba.random, simba.geometry,
  simba.vartype_point,
  simba.vartype_polygon,
  simba.array_algorithm;

class function TQuadHelper.Create(ATop, ARight, ABottom, ALeft: TPoint): TQuad;
begin
  Result.Top    := ATop;
  Result.Right  := ARight;
  Result.Bottom := ABottom;
  Result.Left   := ALeft;
end;

class function TQuadHelper.CreateFromBox(Box: TBox): TQuad;
begin
  Result.Top    := TPoint.Create(Box.X1, Box.Y1);
  Result.Right  := TPoint.Create(Box.X2, Box.Y1);
  Result.Bottom := TPoint.Create(Box.X2, Box.Y2);
  Result.Left   := TPoint.Create(Box.X1, Box.Y2);
end;

class function TQuadHelper.CreateFromPoints(Points: TPointArray): TQuad;
begin
  Result := Points.MinAreaRect();
end;

function TQuadHelper.RandomPoint: TPoint;
var
  a,x,y,x1,y1,x2,y2: Double;
begin
  a := ArcTan2(Left.Y-Top.Y, Left.X-Top.X);
  X := (Top.X + Right.X + Bottom.X + Left.X) / 4;
  Y := (Top.Y + Right.Y + Bottom.Y + Left.Y) / 4;
  x1 := x-Hypot(Left.y-Top.y, Left.x-Top.x) / 2;
  y1 := y-Hypot(Left.y-Bottom.y, Left.x-Bottom.x) / 2;
  x2 := x+Hypot(Left.y-Top.y, Left.x-Top.x) / 2;
  y2 := y+Hypot(Left.y-Bottom.y, Left.x-Bottom.x) / 2;

  X := (X2 + X1) / 2 + (Random()*2 - 1);
  Y := (Y2 + Y1) / 2 + (Random()*2 - 1);

  Result.X := RandomRange(Round(x1)+2, Round(x2)-2);
  Result.Y := RandomRange(Round(y1)+2, Round(y2)-2);
  Result := Result.Rotate(a, TPoint.Create(Round(X), Round(Y)));
end;

function TQuadHelper.RandomPointCenter: TPoint;
var
  a,x,y,x1,y1,x2,y2: Double;
begin
  a := ArcTan2(Left.Y-Top.Y, Left.X-Top.X);
  X := (Top.X + Right.X + Bottom.X + Left.X) / 4;
  Y := (Top.Y + Right.Y + Bottom.Y + Left.Y) / 4;
  x1 := x-Hypot(Left.y-Top.y, Left.x-Top.x) / 2;
  y1 := y-Hypot(Left.y-Bottom.y, Left.x-Bottom.x) / 2;
  x2 := x+Hypot(Left.y-Top.y, Left.x-Top.x) / 2;
  y2 := y+Hypot(Left.y-Bottom.y, Left.x-Bottom.x) / 2;

  X := (X2 + X1) / 2 + (Random()*2 - 1);
  Y := (Y2 + Y1) / 2 + (Random()*2 - 1);

  Result.X := Round(RandomMean(x1+1, x2-1));
  Result.Y := Round(RandomMean(y1+1, y2-1));
  Result := Result.Rotate(a, TPoint.Create(Round(X), Round(Y)));
end;

function TQuadHelper.GetCorners: TPointArray;
begin
  Result := [Top, Right, Bottom, Left];
end;

function TQuadHelper.GetBounds: TBox;
begin
  Result.X1 := Min(Min(Left.X, Right.X), Min(Top.X, Bottom.X));
  Result.X2 := Max(Max(Left.X, Right.X), Max(Top.X, Bottom.X));
  Result.Y1 := Min(Min(Left.Y, Right.Y), Min(Top.Y, Bottom.Y));
  Result.Y2 := Max(Max(Left.Y, Right.Y), Max(Top.Y, Bottom.Y));
end;

function TQuadHelper.GetShortSideLen: Integer;
begin
  Result := Round(Min(Hypot(Left.Y-Top.Y, Left.X-Top.X), Hypot(Left.Y-Bottom.Y, Left.X-Bottom.X)));
end;

function TQuadHelper.GetLongSideLen: Integer;
begin
  Result := Round(Max(Hypot(Left.Y-Top.Y, Left.X-Top.X), Hypot(Left.Y-Bottom.Y, Left.X-Bottom.X)));
end;

function TQuadHelper.GetMean: TPoint;
begin
  Result.X := (Self.Top.X + Self.Right.X + Self.Bottom.X + Self.Left.X) div 4;
  Result.Y := (Self.Top.Y + Self.Right.Y + Self.Bottom.Y + Self.Left.Y) div 4;
end;

function TQuadHelper.GetArea: Integer;
begin
  Result := Round(Distance(Self.Bottom, Self.Right)) * Round(Distance(Self.Bottom, Self.Left));
end;

function TQuadHelper.Rotate(Radians: Double): TQuad;
begin
  with Self.Mean do
  begin
    Result.Top    := TSimbaGeometry.RotatePoint(Self.Top,    Radians, X, Y);
    Result.Right  := TSimbaGeometry.RotatePoint(Self.Right,  Radians, X, Y);
    Result.Bottom := TSimbaGeometry.RotatePoint(Self.Bottom, Radians, X, Y);
    Result.Left   := TSimbaGeometry.RotatePoint(Self.Left,   Radians, X, Y);
  end;

  Result := Result.Normalize();
end;

function TQuadHelper.Contains(P: TPoint): Boolean;
begin
  Result := TSimbaGeometry.PointInTriangle(P, Self.Top, Self.Bottom, Self.Right) or
            TSimbaGeometry.PointInTriangle(P, Self.Top, Self.Left, Self.Bottom);
end;

function TQuadHelper.Offset(P: TPoint): TQuad;
begin
  Result := TQuad.Create(Top.Offset(P), Right.Offset(P), Bottom.Offset(P), Left.Offset(P));
end;

function TQuadHelper.Expand(Amount: Integer): TQuad;
var
  Poly: TPolygon;
begin
  Poly := TPolygon([Self.Top, Self.Right, Self.Bottom, Self.Left]);
  Poly := Poly.Expand(Amount);

  Result.Top    := Poly[0];
  Result.Right  := Poly[1];
  Result.Bottom := Poly[2];
  Result.Left   := Poly[3];
end;

function TQuadHelper.NearestEdge(P: TPoint): TPoint;
var
  Dists: array[0..3] of Double;
  Points: array[0..3] of TPoint;
  I: Integer;
  Best: Double;
begin
  Dists[0] := TSimbaGeometry.DistToLine(P, Self.Top,    Self.Left,   Points[0]);
  Dists[1] := TSimbaGeometry.DistToLine(P, Self.Left,   Self.Bottom, Points[1]);
  Dists[2] := TSimbaGeometry.DistToLine(P, Self.Bottom, Self.Right,  Points[2]);
  Dists[3] := TSimbaGeometry.DistToLine(P, Self.Right,  Self.Top,    Points[3]);

  Best   := Dists[0];
  Result := Points[0];

  for I := 1 to 3 do
    if (Dists[I] < Best) then
    begin
      Best   := Dists[I];
      Result := Points[I];
    end;
end;

function TQuadHelper.Normalize: TQuad;
var
  I, T: Integer;
  Points: TPointArray;
begin
  T := 0;
  Points := Self.Corners;
  for I := 1 to High(Points) do
    if (Points[I].Y < Points[T].Y) or ((Points[I].Y = Points[T].Y) and (Points[I].X < Points[T].X)) then
      T := I;

  Result.Top    := Points[T];
  Result.Right  := Points[(T + 1) mod 4];
  Result.Bottom := Points[(T + 2) mod 4];
  Result.Left   := Points[(T + 3) mod 4];
end;

function TQuadArrayHelper.Merge: TQuad;
var
  TPA: TPointArray;
  I,C: Integer;
begin
  C := 0;
  SetLength(TPA, Length(Self) * 4);
  for I := 0 to High(Self) do
  begin
    TPA[C]   := Self[I].Top;
    TPA[C+1] := Self[I].Right;
    TPA[C+2] := Self[I].Bottom;
    TPA[C+3] := Self[I].Left;
    Inc(C, 4);
  end;

  Result := TQuad.CreateFromPoints(TPA);
end;

function TQuadArrayHelper.Means: TPointArray;
var
  I: Integer;
begin
  SetLength(Result, Length(Self));
  for I := 0 to High(Self) do
    Result[I] := Self[I].Mean;
end;

function TQuadArrayHelper.Offset(P: TPoint): TQuadArray;
var
  I: Integer;
begin
  SetLength(Result, Length(Self));
  for I := 0 to High(Result) do
    Result[I] := Self[I].Offset(P);
end;

function TQuadArrayHelper.Expand(SizeMod: Integer): TQuadArray;
var
  I: Integer;
begin
  SetLength(Result, Length(Self));
  for I := 0 to High(Result) do
    Result[I] := Self[I].Expand(SizeMod);
end;

function TQuadArrayHelper.ContainsPoint(P: TPoint): Integer;
var
  I: Integer;
begin
  for I := 0 to High(Self) do
    if Self[I].Contains(P) then
      Exit(I);

  Result := -1;
end;

function TQuadArrayHelper.Sort(Weights: TIntegerArray; LowToHigh: Boolean): TQuadArray;
begin
  Result := Copy(Self);
  Weights := Copy(Weights);

  specialize TArraySortWeighted<TQuad, Integer>.QuickSort(Result, Weights, Low(Result), High(Result), LowToHigh);
end;

function TQuadArrayHelper.Sort(Weights: TDoubleArray; LowToHigh: Boolean): TQuadArray;
begin
  Result := Copy(Self);
  Weights := Copy(Weights);

  specialize TArraySortWeighted<TQuad, Double>.QuickSort(Result, Weights, Low(Result), High(Result), LowToHigh);
end;

function TQuadArrayHelper.SortFrom(From: TPoint): TQuadArray;
var
  Weights: TDoubleArray;
  I: Integer;
begin
  SetLength(Weights, Length(Self));
  for I := 0 to High(Weights) do
    Weights[I] := Distance(From, Self[I].Mean);

  Result := Self.Sort(Weights);
end;

function TQuadArrayHelper.SortByShortSide(LowToHigh: Boolean): TQuadArray;
var
  Weights: TIntegerArray;
  I: Integer;
begin
  SetLength(Weights, Length(Self));
  for I := 0 to High(Weights) do
    Weights[I] := Self[I].ShortSideLen;

  Result := Self.Sort(Weights, LowToHigh);
end;

function TQuadArrayHelper.SortByLongSide(LowToHigh: Boolean): TQuadArray;
var
  Weights: TIntegerArray;
  I: Integer;
begin
  SetLength(Weights, Length(Self));
  for I := 0 to High(Weights) do
    Weights[I] := Self[I].LongSideLen;

  Result := Self.Sort(Weights, LowToHigh);
end;

function TQuadArrayHelper.SortByArea(LowToHigh: Boolean): TQuadArray;
var
  Weights: TIntegerArray;
  I: Integer;
begin
  SetLength(Weights, Length(Self));
  for I := 0 to High(Weights) do
    Weights[I] := Self[I].Area;

  Result := Self.Sort(Weights, LowToHigh);
end;

operator in(const P: TPoint; const Quad: TQuad): Boolean;
begin
  Result := Quad.Contains(P);
end;

end.

