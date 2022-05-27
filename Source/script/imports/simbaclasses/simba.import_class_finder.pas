unit simba.import_class_finder;

{$i simba.inc}

interface

implementation

uses
  classes, sysutils, lptypes,
  simba.script_compiler, simba.mufasatypes, simba.finder, simba.bitmap, simba.dtm;

type
  PObject = ^TObject;

procedure _LapeMFinder_WarnOnly_Read(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  Pboolean(Result)^ := PMFinder(Params^[0])^.WarnOnly;
end;

procedure _LapeMFinder_WarnOnly_Write(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^.WarnOnly := Pboolean(Params^[1])^;
end;

procedure _LapeMFinder_DefaultOperations(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^.DefaultOperations(Pinteger(Params^[1])^, Pinteger(Params^[2])^, Pinteger(Params^[3])^, Pinteger(Params^[4])^);
end;

procedure _LapeMFinder_CountColorTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PInteger(Result)^ := PMFinder(Params^[0])^.CountColorTolerance(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^);
end;

procedure _LapeMFinder_CountColor(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PInteger(Result)^ := PMFinder(Params^[0])^.CountColor(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^);
end;

procedure _LapeMFinder_SimilarColors(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  Pboolean(Result)^ := PMFinder(Params^[0])^.SimilarColors(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^);
end;

procedure _LapeMFinder_FindColor(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColor(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^);
end;

procedure _LapeMFinder_FindColorSpiral(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColorSpiral(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^);
end;

procedure _LapeMFinder_FindColorSpiralTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColorSpiralTolerance(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^);
end;

procedure _LapeMFinder_FindColorTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColorTolerance(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^);
end;

procedure _LapeMFinder_FindColorsTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColorsTolerance(PPointArray(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^);
end;

procedure _LapeMFinder_FindColorsSpiralTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  Pboolean(Result)^ := PMFinder(Params^[0])^.FindColorsSpiralTolerance(PInteger(Params^[1])^, PInteger(Params^[2])^, PPointArray(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^, PInteger(Params^[9])^);
end;

procedure _LapeMFinder_FindColors(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColors(PPointArray(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^);
end;

procedure _LapeMFinder_FindColoredArea(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColoredArea(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^);
end;

procedure _LapeMFinder_FindColoredAreaTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindColoredAreaTolerance(PInteger(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^, PInteger(Params^[9])^);
end;

procedure _LapeMFinder_FindBitmap(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindBitmap(PMufasaBitmap(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^);
end;

procedure _LapeMFinder_FindBitmapIn(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindBitmapIn(PMufasaBitmap(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^);
end;

procedure _LapeMFinder_FindBitmapToleranceIn(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindBitmapToleranceIn(PMufasaBitmap(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^);
end;

procedure _LapeMFinder_FindBitmapSpiral(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindBitmapSpiral(PMufasaBitmap(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^);
end;

procedure _LapeMFinder_FindBitmapSpiralTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindBitmapSpiralTolerance(PMufasaBitmap(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, Pinteger(Params^[4])^, Pinteger(Params^[5])^, Pinteger(Params^[6])^, Pinteger(Params^[7])^, Pinteger(Params^[8])^);
end;

procedure _LapeMFinder_FindBitmapsSpiralTolerance(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindBitmapsSpiralTolerance(PMufasaBitmap(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PPointArray(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^, PInteger(Params^[9])^, PInteger(Params^[10])^);
end;

procedure _LapeMFinder_FindDeformedBitmapToleranceIn(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindDeformedBitmapToleranceIn(PMufasaBitmap(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PInteger(Params^[8])^, PInteger(Params^[9])^, PBoolean(Params^[10])^, PExtended(Params^[11])^);
end;

procedure _LapeMFinder_FindDTM(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindDTM(PMDTM(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^);
end;

procedure _LapeMFinder_FindDTMs(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindDTMs(PMDTM(Params^[1])^, PPointArray(Params^[2])^, Pinteger(Params^[3])^, Pinteger(Params^[4])^, Pinteger(Params^[5])^, Pinteger(Params^[6])^, PInteger(Params^[7])^);
end;

procedure _LapeMFinder_FindDTMRotated(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindDTMRotated(PMDTM(Params^[1])^, PInteger(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PInteger(Params^[7])^, PExtended(Params^[8])^, PExtended(Params^[9])^, PExtended(Params^[10])^, PExtended(Params^[11])^, Pboolean(Params^[12])^);
end;

procedure _LapeMFinder_FindDTMsRotated(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PBoolean(Result)^ := PMFinder(Params^[0])^.FindDTMsRotated(PMDTM(Params^[1])^, PPointArray(Params^[2])^, PInteger(Params^[3])^, PInteger(Params^[4])^, PInteger(Params^[5])^, PInteger(Params^[6])^, PExtended(Params^[7])^, PExtended(Params^[8])^, PExtended(Params^[9])^, P2DExtendedArray(Params^[10])^, Pboolean(Params^[11])^, PInteger(Params^[12])^);
end;

procedure _LapeMFinder_GetColors(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PIntegerArray(Result)^ := PMFinder(Params^[0])^.GetColors(PPointArray(Params^[1])^);
end;

procedure _LapeMFinder_SetToleranceSpeed(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^.SetToleranceSpeed(PInteger(Params^[1])^);
end;

procedure _LapeMFinder_GetToleranceSpeed(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PInteger(Result)^ := PMFinder(Params^[0])^.GetToleranceSpeed();
end;

procedure _LapeMFinder_SetToleranceSpeed2Modifiers(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^.SetToleranceSpeed2Modifiers(PExtended(Params^[1])^, PExtended(Params^[2])^);
end;

procedure _LapeMFinder_GetToleranceSpeed2Modifiers(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^.GetToleranceSpeed2Modifiers(PExtended(Params^[1])^, PExtended(Params^[2])^);
end;

procedure _LapeMFinder_SetToleranceSpeed3Modifier(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^.SetToleranceSpeed3Modifier(PExtended(Params^[1])^);
end;

procedure _LapeMFinder_GetToleranceSpeed3Modifier(const Params: PParamArray; const Result: Pointer); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PExtended(Result)^ := PMFinder(Params^[0])^.GetToleranceSpeed3Modifier();
end;

procedure _LapeMFinder_Init(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^ := TMFinder.Create(PObject(Params^[1])^);
end;

procedure _LapeMFinder_Free(const Params: PParamArray); {$IFDEF Lape_CDECL}cdecl;{$ENDIF}
begin
  PMFinder(Params^[0])^.Free();
end;

procedure ImportFinder(Compiler: TSimbaScript_Compiler);
begin
  with Compiler do
  begin
    addClass('TMFinder');
    addClassVar('TMFinder', 'WarnOnly', 'boolean', @_LapeMFinder_WarnOnly_Read, @_LapeMFinder_WarnOnly_Write);
    addGlobalFunc('procedure TMFinder.DefaultOperations(var xs,ys,xe,ye : integer);', @_LapeMFinder_DefaultOperations);
    addGlobalFunc('function TMFinder.CountColorTolerance(Color, xs, ys, xe, ye, Tolerance: Integer): Integer;', @_LapeMFinder_CountColorTolerance);
    addGlobalFunc('function TMFinder.CountColor(Color, xs, ys, xe, ye: Integer): Integer;', @_LapeMFinder_CountColor);
    addGlobalFunc('function TMFinder.SimilarColors(Color1,Color2,Tolerance : Integer): boolean;', @_LapeMFinder_SimilarColors);
    addGlobalFunc('function TMFinder.FindColor(out x, y: Integer; Color, xs, ys, xe, ye: Integer): Boolean;', @_LapeMFinder_FindColor);
    addGlobalFunc('function TMFinder.FindColorSpiral(var x, y: Integer; color, xs, ys, xe, ye: Integer): Boolean;', @_LapeMFinder_FindColorSpiral);
    addGlobalFunc('function TMFinder.FindColorSpiralTolerance(var x, y: Integer; color, xs, ys, xe, ye,Tol: Integer): Boolean;', @_LapeMFinder_FindColorSpiralTolerance);
    addGlobalFunc('function TMFinder.FindColorTolerance(out x, y: Integer; Color, xs, ys, xe, ye, tol: Integer): Boolean;', @_LapeMFinder_FindColorTolerance);
    addGlobalFunc('function TMFinder.FindColorsTolerance(out Points: TPointArray; Color, xs, ys, xe, ye, Tol: Integer): Boolean;', @_LapeMFinder_FindColorsTolerance);
    addGlobalFunc('function TMFinder.FindColorsSpiralTolerance(x, y: Integer; out Points: TPointArray; color, xs, ys, xe, ye: Integer; Tol: Integer): boolean;', @_LapeMFinder_FindColorsSpiralTolerance);
    addGlobalFunc('function TMFinder.FindColors(var TPA: TPointArray; Color, xs, ys, xe, ye: Integer): Boolean;', @_LapeMFinder_FindColors);
    addGlobalFunc('function TMFinder.FindColoredArea(var x, y: Integer; color, xs, ys, xe, ye: Integer; MinArea: Integer): Boolean;', @_LapeMFinder_FindColoredArea);
    addGlobalFunc('function TMFinder.FindColoredAreaTolerance(var x, y: Integer; color, xs, ys, xe, ye: Integer; MinArea, tol: Integer): Boolean;', @_LapeMFinder_FindColoredAreaTolerance);
    addGlobalFunc('function TMFinder.FindBitmap(bitmap: TMufasaBitmap; out x, y: Integer): Boolean;', @_LapeMFinder_FindBitmap);
    addGlobalFunc('function TMFinder.FindBitmapIn(bitmap: TMufasaBitmap; out x, y: Integer;  xs, ys, xe, ye: Integer): Boolean;', @_LapeMFinder_FindBitmapIn);
    addGlobalFunc('function TMFinder.FindBitmapToleranceIn(bitmap: TMufasaBitmap; out x, y: Integer; xs, ys, xe, ye: Integer; tolerance: Integer): Boolean;', @_LapeMFinder_FindBitmapToleranceIn);
    addGlobalFunc('function TMFinder.FindBitmapSpiral(bitmap: TMufasaBitmap; var x, y: Integer; xs, ys, xe, ye: Integer): Boolean;', @_LapeMFinder_FindBitmapSpiral);
    addGlobalFunc('function TMFinder.FindBitmapSpiralTolerance(bitmap: TMufasaBitmap; var x, y: Integer; xs, ys, xe, ye,tolerance : integer): Boolean;', @_LapeMFinder_FindBitmapSpiralTolerance);
    addGlobalFunc('function TMFinder.FindBitmapsSpiralTolerance(bitmap: TMufasaBitmap; x, y: Integer; out Points : TPointArray; xs, ys, xe, ye,tolerance: Integer; maxToFind: Integer = 0): Boolean;', @_LapeMFinder_FindBitmapsSpiralTolerance);
    addGlobalFunc('function TMFinder.FindDeformedBitmapToleranceIn(bitmap: TMufasaBitmap; out x, y: Integer; xs, ys, xe, ye: Integer; tolerance: Integer; Range: Integer; AllowPartialAccuracy: Boolean; out accuracy: Extended): Boolean;', @_LapeMFinder_FindDeformedBitmapToleranceIn);
    addGlobalFunc('function TMFinder.FindDTM(DTM: TMDTM; out x, y: Integer; x1, y1, x2, y2: Integer): Boolean;', @_LapeMFinder_FindDTM);
    addGlobalFunc('function TMFinder.FindDTMs(DTM: TMDTM; out Points: TPointArray; x1, y1, x2, y2 : integer; maxToFind: Integer = 0): Boolean;', @_LapeMFinder_FindDTMs);
    addGlobalFunc('function TMFinder.FindDTMRotated(DTM: TMDTM; out x, y: Integer; x1, y1, x2, y2: Integer; sAngle, eAngle, aStep: Extended; out aFound: Extended; Alternating : boolean): Boolean;', @_LapeMFinder_FindDTMRotated);
    addGlobalFunc('function TMFinder.FindDTMsRotated(DTM: TMDTM; out Points: TPointArray; x1, y1, x2, y2: Integer; sAngle, eAngle, aStep: Extended; out aFound: T2DExtendedArray;Alternating : boolean; maxToFind: Integer = 0): Boolean;', @_LapeMFinder_FindDTMsRotated);
    addGlobalFunc('function TMFinder.GetColors(const Coords: TPointArray): TIntegerArray;', @_LapeMFinder_GetColors);
    addGlobalFunc('procedure TMFinder.SetToleranceSpeed(nCTS: Integer);', @_LapeMFinder_SetToleranceSpeed);
    addGlobalFunc('function TMFinder.GetToleranceSpeed: Integer;', @_LapeMFinder_GetToleranceSpeed);
    addGlobalFunc('procedure TMFinder.SetToleranceSpeed2Modifiers(const nHue, nSat: Extended);', @_LapeMFinder_SetToleranceSpeed2Modifiers);
    addGlobalFunc('procedure TMFinder.GetToleranceSpeed2Modifiers(out hMod, sMod: Extended);', @_LapeMFinder_GetToleranceSpeed2Modifiers);
    addGlobalFunc('procedure TMFinder.SetToleranceSpeed3Modifier(modifier: Extended);', @_LapeMFinder_SetToleranceSpeed3Modifier);
    addGlobalFunc('function TMFinder.GetToleranceSpeed3Modifier: Extended;', @_LapeMFinder_GetToleranceSpeed3Modifier);
    addGlobalFunc('procedure TMFinder.Init(aClient: TObject)', @_LapeMFinder_Init);
    //addGlobalFunc('procedure TMFinder.Free;', @_LapeMFinder_Free);
  end;
end;

initialization
  TSimbaScript_Compiler.RegisterImport(@ImportFinder);

end.

