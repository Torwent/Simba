unit simba.import_base;

{$i simba.inc}

interface

uses
  Classes, SysUtils,
  lptypes, lpvartypes, lpparser, ffi,
  simba.base, simba.script_compiler;

procedure ImportBase(Compiler: TSimbaScript_Compiler);

implementation

uses
  Graphics, Variants,
  simba.nativeinterface, simba.env, simba.baseclass, simba.vartype_ordarray,
  simba.vartype_string, simba.vartype_stringarray, simba.vartype_pointarray,
  simba.vartype_floatmatrix;

(*
Base
====
Base methods and types.
*)

(*
GetMem
------
```
function GetMem(i: SizeInt): Pointer;
```
*)

(*
AllocMem
--------
```
function AllocMem(i: SizeInt): Pointer;
```
*)

(*
FreeMem
-------
```
procedure FreeMem(p: Pointer);
```
*)

(*
ReallocMem
----------
```
procedure ReallocMem(var p: Pointer; s: SizeInt);
```
*)

(*
FillMem
-------
```
procedure FillMem(var p; s: SizeInt; b: UInt8 = 0);
```
*)

(*
Move
----
```
procedure Move(constref Src; var Dst; s: SizeInt);
```
*)

(*
CompareMem
----------
```
function CompareMem(constref p1, p2; Length: SizeInt): EvalBool;
```
*)

(*
Assigned
--------
```
function Assigned(constref p): EvalBool;
```
*)

(*
Delete
------
```
procedure Delete(A: array; Index: Int32; Count: Int32 = Length(A));
```
*)

(*
Insert
------
```
procedure Insert(Item: Anything; A: array; Index: Int32);
```
*)

(*
Copy
----
```
procedure Copy(A: array; Index: Int32 = 0; Count: Int32 = Length(A));
```
*)

(*
SetLength
---------
```
procedure SetLength(A: array; Length: Int32);
```
*)

(*
Low
---
```
function Low(A: array): Int32;
```
*)

(*
High
----
```
function High(A: array): Int32;
```
*)

(*
Length
------
```
function Length(A: array): Int32;
```
*)

(*
WriteLn
-------
```
procedure WriteLn(Args: Anything);
```
*)

(*
Write
-----
```
procedure Write(Args: Anything);
```
*)

(*
Swap
----
```
procedure Swap(var A, B: Anything);
```
*)

(*
SizeOf
------
```
function SizeOf(A: Anything): Int32;
```
*)

(*
ToString
--------
```
function ToString(A: Anything): String;
```
*)

(*
ToStr
-----
```
function ToStr(A: Anything): String;
```
*)

(*
Inc
---
```
function Inc(var X: Ordinal; Amount: SizeInt = 1): Ordinal;
```
*)

(*
Dec
---
```
function Dec(var X: Ordinal; Amount: SizeInt = 1): Ordinal;
```
*)

(*
Ord
---
```
function Ord(X: Ordinal): Int32;
```
*)

(*
SleepUntil
----------
```
function SleepUntil(Condition: BoolExpr; Interval, Timeout: Int32): Boolean;
```
*)

(*
Default
-------
```
function Default(T: AnyType): AnyType;
```
*)

(*
Sort
----
```
procedure Sort(var A: array);
```
```
procedure Sort(var A: array; Weights: array of Ordinal; LowToHigh: Boolean);
```
```
procedure Sort(var A: array; CompareFunc: function(constref L, R: Anything): Int32);
```
*)

(*
Sorted
------
```
function Sorted(const A: array): array; overload;
```
```
function Sorted(const A: array; CompareFunc: function(constref L, R: Anything): Int32): array;
```
```
function Sorted(const A: array; Weights: array of Ordinal; LowToHigh: Boolean): array;
```
*)

(*
Unique
------
```
function Unique(const A: array): array;
```
*)

(*
Reverse
-------
```
procedure Reverse(var A: array);
```
*)

(*
Reversed
--------
```
function Reversed(const A: array): array;
```
*)

(*
IndexOf
-------
```
function IndexOf(const Item: T; const A: array): Integer;
```
*)

(*
IndicesOf
---------
```
function IndicesOf(const Item: T; const A: array): TIntegerArray;
```
*)

(*
Contains
--------
```
function Contains(const Item: T; const A: array): Boolean;
```
*)

(*
GetCallerAddress
----------------
```
function GetCallerAddress: Pointer;
```
*)

(*
GetCallerName
-------------
```
function GetCallerName: String;
```
*)

(*
GetCallerLocation
-----------------
```
function GetCallerLocation: Pointer;
```
*)

(*
GetCallerLocationStr
--------------------
```
function GetCallerLocationStr: String;
```
*)

(*
GetExceptionLocation
--------------------
```
function GetExceptionLocation: Pointer;
```
*)

(*
GetExceptionLocationStr
-----------------------
```
function GetExceptionLocationStr: String;
```
*)

(*
GetExceptionMessage
-------------------
```
function GetExceptionMessage: String;
```
*)

(*
GetScriptMethodName
-------------------
```
function GetScriptMethodName(Address: Pointer): String;
```
*)

(*
DumpCallStack
-------------
```
function DumpCallStack(Start: Integer = 0): String;
```
*)

(*
Variant.VarType
---------------
```
function Variant.VarType: EVariantVarType;
```

Returns the variants var type.

Example:

```
  if (v.VarType = EVariantVarType.Int32) then
    WriteLn('Variant contains a Int32');
```
*)
procedure _LapeVariantVarType(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PVariantType(Result)^ := PVariant(Params^[0])^.VarType;
end;

(*
Variant.IsNumeric
-----------------
```
function Variant.IsNumeric: Boolean;
```

Is integer or float?
*)
procedure _LapeVariantIsNumeric(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := VarIsNumeric(PVariant(Params^[0])^);
end;

(*
Variant.IsString
----------------
```
function Variant.IsString: Boolean;
```
*)
procedure _LapeVariantIsString(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := VarIsStr(PVariant(Params^[0])^);
end;

(*
Variant.IsInteger
-----------------
```
function Variant.IsInteger: Boolean;
```
*)
procedure _LapeVariantIsInteger(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := VarIsOrdinal(PVariant(Params^[0])^);
end;

(*
Variant.IsFloat
---------------
```
function Variant.IsFloat: Boolean;
```
*)
procedure _LapeVariantIsFloat(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := VarIsFloat(PVariant(Params^[0])^);
end;

(*
Variant.IsBoolean
-----------------
```
function Variant.IsBoolean: Boolean;
```
*)
procedure _LapeVariantIsBoolean(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := VarIsBool(PVariant(Params^[0])^);
end;

(*
Variant.IsVariant
-----------------
```
function Variant.IsVariant: Boolean;
```

The variant holds another variant!
*)
procedure _LapeVariantIsVariant(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := VarIsType(PVariant(Params^[0])^, varVariant);
end;

(*
Variant.IsAssigned
------------------
```
function Variant.IsAssigned: Boolean;
```

Example:

```
  if v.IsAssigned() then
    WriteLn('Variant HAS been assigned to')
  else
    WriteLn('The variant has NOT been assigned to');
```
*)
procedure _LapeVariantIsAssigned(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := not VarIsClear(PVariant(Params^[0])^);
end;

(*
Variant.IsNull
--------------
```
function Variant.IsNull: Boolean;
```
*)
procedure _LapeVariantIsNull(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := VarIsNull(PVariant(Params^[0])^);
end;

(*
Variant.NULL
------------
```
function Variant.NULL: Variant; static;
```

Static method that returns a null variant variable.

Example:

```
v := Variant.NULL;
WriteLn(v.IsNull());
```
*)
procedure _LapeVariantNULL(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PVariant(Result)^ := Null;
end;

procedure _LapeBaseClass_Name_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PString(Result)^ := TSimbaBaseClass(Params^[0]^).Name;
end;

procedure _LapeBaseClass_Name_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  TSimbaBaseClass(Params^[0]^).Name := PString(Params^[1])^;
end;

procedure _LapeBaseClass_FreeOnTerminate_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := TSimbaBaseClass(Params^[0]^).FreeOnTerminate;
end;

procedure _LapeBaseClass_FreeOnTerminate_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  TSimbaBaseClass(Params^[0]^).FreeOnTerminate := PBoolean(Params^[1])^;
end;

procedure _LapeByteArray_ToString(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PString(Result)^ := PByteArray(Params^[0])^.ToString();
end;

procedure _LapeByteArray_FromString(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PByteArray(Params^[0])^.FromString(PString(Params^[1])^);
end;

procedure _LapeWrite(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  Debug(PString(Params^[0])^);
end;

procedure _LapeWriteLn(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  DebugLn('');
end;

// Sort
procedure _LapeSort_IntegerArray(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PIntegerArray(Params^[0])^.Sort();
end;

procedure _LapeSort_SingleArray(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSingleArray(Params^[0])^.Sort();
end;

procedure _LapeSort_DoubleArray(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PDoubleArray(Params^[0])^.Sort();
end;

procedure _LapeSort_StringArray(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PStringArray(Params^[0])^.Sort();
end;

// Unique
procedure _LapeUnique_IntegerArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PIntegerArray(Result)^ := PIntegerArray(Params^[0])^.Unique();
end;

procedure _LapeUnique_SingleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSingleArray(Result)^ := PSingleArray(Params^[0])^.Unique();
end;

procedure _LapeUnique_DoubleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PDoubleArray(Result)^ := PDoubleArray(Params^[0])^.Unique();
end;

procedure _LapeUnique_StringArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PStringArray(Result)^ := PStringArray(Params^[0])^.Unique();
end;

procedure _LapeUnique_PointArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPointArray(Result)^ := PPointArray(Params^[0])^.Unique();
end;

// Sum
procedure _LapeArraySum_IntegerArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInt64(Result)^ := PIntegerArray(Params^[0])^.Sum();
end;

procedure _LapeArraySum_SingleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PDouble(Result)^ := PSingleArray(Params^[0])^.Sum();
end;

procedure _LapeArraySum_DoubleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PDouble(Result)^ := PDoubleArray(Params^[0])^.Sum();
end;

// Min
procedure _LapeArrayMin_IntegerArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PIntegerArray(Params^[0])^.Min();
end;

procedure _LapeArrayMin_SingleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSingle(Result)^ := PSingleArray(Params^[0])^.Min();
end;

procedure _LapeArrayMin_DoubleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PDouble(Result)^ := PDoubleArray(Params^[0])^.Min();
end;

procedure _LapeArrayMin_SingleMatrix(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSingle(Result)^ := PSingleMatrix(Params^[0])^.Min();
end;

// Max
procedure _LapeArrayMax_IntegerArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PIntegerArray(Params^[0])^.Max();
end;

procedure _LapeArrayMax_SingleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSingle(Result)^ := PSingleArray(Params^[0])^.Max();
end;

procedure _LapeArrayMax_DoubleArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PDouble(Result)^ := PDoubleArray(Params^[0])^.Max();
end;

procedure _LapeArrayMax_SingleMatrix(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSingle(Result)^ := PSingleMatrix(Params^[0])^.Max();
end;

// Mean
procedure _LapeArrayMean_PointArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPoint(Result)^ := PPointArray(Params^[0])^.Mean();
end;

procedure _LapeArrayMean_2DPointArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPoint(Result)^ := P2DPointArray(Params^[0])^.Mean();
end;

procedure _LapeArrayMean_SingleMatrix(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSingle(Result)^ := PSingleMatrix(Params^[0])^.Mean();
end;

// Median
procedure _LapeArrayMedian_PointArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPoint(Result)^ := PPointArray(Params^[0])^.Median();
end;

// IndexOf
procedure _LapeArrayIndexOf_StringArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PStringArray(Params^[0])^.IndexOf(PString(Params^[1])^);
end;

// IndicesOf
procedure _LapeArrayIndicesOf_StringArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PIntegerArray(Result)^ := PStringArray(Params^[0])^.IndicesOf(PString(Params^[1])^);
end;

// Intersection
procedure _LapeArrayIntersection_PointArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPointArray(Result)^ := PPointArray(Params^[0])^.Intersection(PPointArray(Params^[1])^);
end;

// Difference
procedure _LapeArrayDifference_PointArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPointArray(Result)^ := PPointArray(Params^[0])^.Difference(PPointArray(Params^[1])^);
end;

// SymDifference
procedure _LapeArraySymDifference_PointArray(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPointArray(Result)^ := PPointArray(Params^[0])^.SymmetricDifference(PPointArray(Params^[1])^);
end;

procedure ImportBase(Compiler: TSimbaScript_Compiler);
begin
  with Compiler do
  begin
    ImportingSection := 'Base';

    addBaseDefine('SIMBA' + Format('%d', [SIMBA_VERSION]));
    addBaseDefine('SIMBAMAJOR' + Format('%d', [SIMBA_MAJOR]));
    addBaseDefine('FPC' + Format('%d', [FPC_FULLVERSION]));
    addBaseDefine(CPU);
    addBaseDefine(OS);

    addGlobalType('UInt8', 'Byte');
    addGlobalType('Int32', 'Integer');

    addGlobalType('Int32', 'TColor');
    addGlobalType('array of TColor', 'TColorArray');

    addGlobalType('array of TStringArray', 'T2DStringArray');
    addGlobalType('array of TIntegerArray', 'T2DIntegerArray');
    addGlobalType('array of Int64', 'TInt64Array');
    addGlobalType('array of Byte', 'TByteArray');
    addGlobalType('array of Variant', 'TVariantArray');
    addGlobalType('array of Pointer', 'TPointerArray');

    addGlobalType('record X, Y: Integer; end', 'TPoint');
    addGlobalType('array of TPoint', 'TPointArray');
    addGlobalType('array of TPointArray', 'T2DPointArray');

    addGlobalType('record A, B, C: TPoint; end;', 'TTriangle');
    addGlobalType('array of TTriangle', 'TTriangleArray');

    addGlobalType('record Top, Right, Bottom, Left: TPoint; end;', 'TQuad');
    addGlobalType('array of TQuad', 'TQuadArray');

    addGlobalType('record X1, Y1, X2, Y2: Integer; end', 'TBox');
    addGlobalType('array of TBox', 'TBoxArray');

    addGlobalType('array of TSingleArray', 'TSingleMatrix');
    addGlobalType('array of TDoubleArray', 'TDoubleMatrix');
    addGlobalType('array of TByteArray', 'TByteMatrix');
    addGlobalType('array of TIntegerArray', 'TIntegerMatrix');
    addGlobalType('array of TBooleanArray', 'TBooleanMatrix');

    addGlobalType('record Width, Height: Integer; end', 'TSize');

    addGlobalType('(__LT__, __GT__, __EQ__, __LE__, __GE__, __NE__)', 'EComparator');

    addGlobalType('enum(Unknown, Unassigned, Null, Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64, Single, Double, DateTime, Currency, Boolean, Variant, AString, UString, WString)', 'EVariantVarType');

    addGlobalFunc('function Variant.VarType: EVariantVarType;', @_LapeVariantVarType);

    addGlobalFunc('function Variant.IsNumeric: Boolean;', @_LapeVariantIsNumeric);
    addGlobalFunc('function Variant.IsInteger: Boolean;', @_LapeVariantIsInteger);
    addGlobalFunc('function Variant.IsFloat: Boolean;', @_LapeVariantIsFloat);
    addGlobalFunc('function Variant.IsString: Boolean;', @_LapeVariantIsString);
    addGlobalFunc('function Variant.IsBoolean: Boolean;', @_LapeVariantIsBoolean);
    addGlobalFunc('function Variant.IsVariant: Boolean;', @_LapeVariantIsVariant);
    addGlobalFunc('function Variant.IsAssigned: Boolean;', @_LapeVariantIsAssigned);
    addGlobalFunc('function Variant.IsNull: Boolean;', @_LapeVariantIsNull);

    addGlobalFunc('function Variant.NULL: Variant; static;', @_LapeVariantNULL);

    addGlobalFunc('function TByteArray.ToString: String;', @_LapeByteArray_ToString);
    addGlobalFunc('procedure TByteArray.FromString(Str: String);', @_LapeByteArray_FromString);

    ImportingSection := '';

    addClass('TBaseClass', 'Pointer');
    addProperty('TBaseClass', 'Name', 'String', @_LapeBaseClass_Name_Read, @_LapeBaseClass_Name_Write);
    addProperty('TBaseClass', 'FreeOnTerminate', 'Boolean', @_LapeBaseClass_FreeOnTerminate_Read, @_LapeBaseClass_FreeOnTerminate_Write);

    addGlobalFunc('procedure _Write(S: String); override', @_LapeWrite);
    addGlobalFunc('procedure _WriteLn; override', @_LapeWriteLn);

    // add native versions for lape to use
    addMagic('_ArrayMin', ['TIntegerArray'], [lptNormal], 'Integer', @_LapeArrayMin_IntegerArray);
    addMagic('_ArrayMin', ['TSingleArray'], [lptNormal], 'Single', @_LapeArrayMin_SingleArray);
    addMagic('_ArrayMin', ['TDoubleArray'], [lptNormal], 'Double', @_LapeArrayMin_DoubleArray);
    addMagic('_ArrayMin', ['TSingleMatrix'], [lptNormal], 'Single', @_LapeArrayMin_SingleMatrix);

    addMagic('_ArrayMax', ['TIntegerArray'], [lptNormal], 'Integer', @_LapeArrayMax_IntegerArray);
    addMagic('_ArrayMax', ['TSingleArray'], [lptNormal], 'Single', @_LapeArrayMax_SingleArray);
    addMagic('_ArrayMax', ['TDoubleArray'], [lptNormal], 'Double', @_LapeArrayMax_DoubleArray);
    addMagic('_ArrayMax', ['TSingleMatrix'], [lptNormal], 'Single', @_LapeArrayMax_SingleMatrix);

    addMagic('_ArraySum', ['TIntegerArray'], [lptNormal], 'Int64', @_LapeArraySum_IntegerArray);
    addMagic('_ArraySum', ['TSingleArray'], [lptNormal], 'Double', @_LapeArraySum_SingleArray);
    addMagic('_ArraySum', ['TDoubleArray'], [lptNormal], 'Double', @_LapeArraySum_DoubleArray);

    addMagic('_ArraySort', ['TIntegerArray'], [lptVar], '', @_LapeSort_IntegerArray);
    addMagic('_ArraySort', ['TSingleArray'], [lptVar], '', @_LapeSort_SingleArray);
    addMagic('_ArraySort', ['TDoubleArray'], [lptVar], '', @_LapeSort_DoubleArray);
    addMagic('_ArraySort', ['TStringArray'], [lptVar], '', @_LapeSort_StringArray);

    addMagic('_ArrayUnique', ['TIntegerArray'], [lptNormal], 'TIntegerArray', @_LapeUnique_IntegerArray);
    addMagic('_ArrayUnique', ['TSingleArray'], [lptNormal], 'TSingleArray', @_LapeUnique_SingleArray);
    addMagic('_ArrayUnique', ['TDoubleArray'], [lptNormal], 'TDoubleArray', @_LapeUnique_DoubleArray);
    addMagic('_ArrayUnique', ['TStringArray'], [lptNormal], 'TStringArray', @_LapeUnique_StringArray);
    addMagic('_ArrayUnique', ['TPointArray'], [lptNormal], 'TPointArray', @_LapeUnique_PointArray);

    addMagic('_ArrayIndexOf', ['String', 'TStringArray'], [lptNormal, lptNormal], 'Integer', @_LapeArrayIndexOf_StringArray);
    addMagic('_ArrayIndicesOf', ['String', 'TStringArray'], [lptNormal, lptNormal], 'TIntegerArray', @_LapeArrayIndicesOf_StringArray);

    addMagic('_ArrayMean', ['TPointArray'], [lptNormal], 'TPoint', @_LapeArrayMean_PointArray);
    addMagic('_ArrayMean', ['T2DPointArray'], [lptNormal], 'TPoint', @_LapeArrayMean_2DPointArray);
    addMagic('_ArrayMean', ['TSingleMatrix'], [lptNormal], 'Single', @_LapeArrayMean_SingleMatrix);

    addMagic('_ArrayMedian', ['TPointArray'], [lptNormal], 'TPoint', @_LapeArrayMedian_PointArray);

    addMagic('_ArrayIntersection', ['TPointArray', 'TPointArray'], [lptNormal, lptNormal], 'TPointArray', @_LapeArrayIntersection_PointArray);
    addMagic('_ArrayDifference', ['TPointArray', 'TPointArray'], [lptNormal, lptNormal], 'TPointArray', @_LapeArrayDifference_PointArray);
    addMagic('_ArraySymDifference', ['TPointArray', 'TPointArray'], [lptNormal, lptNormal], 'TPointArray', @_LapeArraySymDifference_PointArray);
  end;
end;

end.
