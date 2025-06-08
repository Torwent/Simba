unit simba.import_lcl_extctrls;

{$i simba.inc}

interface

uses
  Classes, SysUtils,
  simba.base, simba.script;

procedure ImportLCLExtCtrls(Script: TSimbaScript);

implementation

uses
  controls, extctrls, graphics, customtimer, lptypes, ffi;

type
  PAlignment = ^TAlignment;
  PNotifyEvent = ^TNotifyEvent;
  PBevelWidth = ^TBevelWidth;
  PCustomPanel = ^TCustomPanel;
  PImage = ^TImage;
  PPanel = ^TPanel;
  PPanelBevel = ^TPanelBevel;
  PTimer = ^TTimer;
  PComponent = ^TComponent;
  PRect = ^TRect;
  PPicture = ^TPicture;
  PMouseEvent = ^TMouseEvent;
  PMouseMoveEvent = ^TMouseMoveEvent;

procedure _LapeTimer_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PTimer(Result)^ := TTimer.Create(PComponent(Params^[0])^);
end;

procedure _LapeTimer_Enabled_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PTimer(Params^[0])^.Enabled;
end;

procedure _LapeTimer_Enabled_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PTimer(Params^[0])^.Enabled := PBoolean(Params^[1])^;
end;

procedure _LapeTimer_Interval_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCardinal(Result)^ := PTimer(Params^[0])^.Interval;
end;

procedure _LapeTimer_Interval_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PTimer(Params^[0])^.Interval := PCardinal(Params^[1])^;
end;

procedure _LapeTimer_OnTimer_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PTimer(Params^[0])^.OnTimer;
end;

procedure _LapeTimer_OnTimer_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PTimer(Params^[0])^.OnTimer := PNotifyEvent(Params^[1])^;
end;

procedure _LapeTimer_OnStartTimer_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PTimer(Params^[0])^.OnStartTimer;
end;

procedure _LapeTimer_OnStartTimer_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PTimer(Params^[0])^.OnStartTimer := PNotifyEvent(Params^[1])^;
end;

procedure _LapeTimer_OnStopTimer_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PTimer(Params^[0])^.OnStopTimer;
end;

procedure _LapeTimer_OnStopTimer_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PTimer(Params^[0])^.OnStopTimer := PNotifyEvent(Params^[1])^;
end;

procedure _LapeImage_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Result)^ := TImage.Create(PComponent(Params^[0])^);
end;

procedure _LapeImage_DestRect(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PRect(Result)^ := PImage(Params^[0])^.DestRect();
end;

procedure _LapeImage_Center_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PImage(Params^[0])^.Center;
end;

procedure _LapeImage_Center_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.Center := PBoolean(Params^[1])^;
end;

procedure _LapeImage_Picture_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPicture(Result)^ := PImage(Params^[0])^.Picture;
end;

procedure _LapeImage_Picture_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.Picture := PPicture(Params^[1])^;
end;

procedure _LapeImage_Stretch_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PImage(Params^[0])^.Stretch;
end;

procedure _LapeImage_Stretch_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.Stretch := PBoolean(Params^[1])^;
end;

procedure _LapeImage_Transparent_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PImage(Params^[0])^.Transparent;
end;

procedure _LapeImage_Transparent_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.Transparent := PBoolean(Params^[1])^;
end;

procedure _LapeImage_Proportional_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PImage(Params^[0])^.Proportional;
end;

procedure _LapeImage_Proportional_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.Proportional := PBoolean(Params^[1])^;
end;

procedure _LapeImage_OnPictureChanged_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PImage(Params^[0])^.OnPictureChanged;
end;

procedure _LapeImage_OnPictureChanged_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.OnPictureChanged := PNotifyEvent(Params^[1])^;
end;

procedure _LapeImage_OnMouseDown_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.OnMouseDown := PMouseEvent(Params^[1])^;
end;

procedure _LapeImage_OnMouseUp_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.OnMouseUp := PMouseEvent(Params^[1])^;
end;

procedure _LapeImage_OnMouseEnter_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PImage(Params^[0])^.OnMouseEnter;
end;

procedure _LapeImage_OnMouseEnter_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.OnMouseEnter := PNotifyEvent(Params^[1])^;
end;

procedure _LapeImage_OnMouseLeave_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PImage(Params^[0])^.OnMouseLeave;
end;

procedure _LapeImage_OnMouseLeave_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.OnMouseLeave := PNotifyEvent(Params^[1])^;
end;

procedure _LapeImage_OnMouseMove_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseMoveEvent(Result)^ := PImage(Params^[0])^.OnMouseMove;
end;

procedure _LapeImage_OnMouseMove_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PImage(Params^[0])^.OnMouseMove := PMouseMoveEvent(Params^[1])^;
end;

procedure _LapeCustomPanel_Alignment_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PAlignment(Result)^ := PCustomPanel(Params^[0])^.Alignment;
end;

procedure _LapeCustomPanel_Alignment_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomPanel(Params^[0])^.Alignment := PAlignment(Params^[1])^;
end;

procedure _LapeCustomPanel_BevelInner_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPanelBevel(Result)^ := PCustomPanel(Params^[0])^.BevelInner;
end;

procedure _LapeCustomPanel_BevelInner_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomPanel(Params^[0])^.BevelInner := PPanelBevel(Params^[1])^;
end;

procedure _LapeCustomPanel_BevelOuter_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPanelBevel(Result)^ := PCustomPanel(Params^[0])^.BevelOuter;
end;

procedure _LapeCustomPanel_BevelOuter_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomPanel(Params^[0])^.BevelOuter := PPanelBevel(Params^[1])^;
end;

procedure _LapeCustomPanel_BevelWidth_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBevelWidth(Result)^ := PCustomPanel(Params^[0])^.BevelWidth;
end;

procedure _LapeCustomPanel_BevelWidth_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomPanel(Params^[0])^.BevelWidth := PBevelWidth(Params^[1])^;
end;

procedure _LapeCustomPanel_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomPanel(Result)^ := TCustomPanel.Create(PComponent(Params^[0])^);
end;

procedure _LapePanel_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPanel(Result)^ := TPanel.Create(PComponent(Params^[0])^);
end;

procedure ImportLCLExtCtrls(Script: TSimbaScript);
begin
  with Script.Compiler do
  begin
    addGlobalType('enum(None, Lowered, Raised, Space)', 'ELazPanelBevel');

    addClass('TLazTimer', 'TLazComponent', TTimer);
    addClassConstructor('TLazTimer', '(AOwner: TLazComponent)', @_LapeTimer_Create);
    addProperty('TLazTimer', 'Enabled', 'Boolean', @_LapeTimer_Enabled_Read, @_LapeTimer_Enabled_Write);
    addProperty('TLazTimer', 'Interval', 'UInt32', @_LapeTimer_Interval_Read, @_LapeTimer_Interval_Write);
    addProperty('TLazTimer', 'OnTimer', 'TLazNotifyEvent', @_LapeTimer_OnTimer_Read, @_LapeTimer_OnTimer_Write);
    addProperty('TLazTimer', 'OnStartTimer', 'TLazNotifyEvent', @_LapeTimer_OnStartTimer_Read, @_LapeTimer_OnStartTimer_Write);
    addProperty('TLazTimer', 'OnStopTimer', 'TLazNotifyEvent', @_LapeTimer_OnStopTimer_Read, @_LapeTimer_OnStopTimer_Write);

    addClass('TLazImage', 'TLazGraphicControl', TImage);
    addClassConstructor('TLazImage', '(AOwner: TLazComponent)', @_LapeImage_Create);
    addGlobalFunc('function TLazImage.DestRect: TLazRect;', @_LapeImage_DestRect);
    addProperty('TLazImage', 'Center', 'Boolean', @_LapeImage_Center_Read, @_LapeImage_Center_Write);
    addProperty('TLazImage', 'Picture', 'TLazPicture', @_LapeImage_Picture_Read, @_LapeImage_Picture_Write);
    addProperty('TLazImage', 'Stretch', 'Boolean', @_LapeImage_Stretch_Read, @_LapeImage_Stretch_Write);
    addProperty('TLazImage', 'Transparent', 'Boolean', @_LapeImage_Transparent_Read, @_LapeImage_Transparent_Write);
    addProperty('TLazImage', 'Proportional', 'Boolean', @_LapeImage_Proportional_Read, @_LapeImage_Proportional_Write);
    addProperty('TLazImage', 'OnPictureChanged', 'TLazNotifyEvent', @_LapeImage_OnPictureChanged_Read, @_LapeImage_OnPictureChanged_Write);
    addProperty('TLazImage', 'OnMouseDown', 'TLazMouseEvent', nil, @_LapeImage_OnMouseDown_Write);
    addProperty('TLazImage', 'OnMouseUp', 'TLazMouseEvent', nil, @_LapeImage_OnMouseUp_Write);
    addProperty('TLazImage', 'OnMouseEnter', 'TLazNotifyEvent', @_LapeImage_OnMouseEnter_Read, @_LapeImage_OnMouseEnter_Write);
    addProperty('TLazImage', 'OnMouseLeave', 'TLazNotifyEvent', @_LapeImage_OnMouseLeave_Read, @_LapeImage_OnMouseLeave_Write);
    addProperty('TLazImage', 'OnMouseMove', 'TLazMouseMoveEvent', @_LapeImage_OnMouseMove_Read, @_LapeImage_OnMouseMove_Write);

    addClass('TLazCustomPanel', 'TLazCustomControl', TCustomPanel);
    addProperty('TLazCustomPanel', 'Alignment', 'ELazAlignment', @_LapeCustomPanel_Alignment_Read, @_LapeCustomPanel_Alignment_Write);
    addProperty('TLazCustomPanel', 'BevelInner', 'ELazPanelBevel', @_LapeCustomPanel_BevelInner_Read, @_LapeCustomPanel_BevelInner_Write);
    addProperty('TLazCustomPanel', 'BevelOuter', 'ELazPanelBevel', @_LapeCustomPanel_BevelOuter_Read, @_LapeCustomPanel_BevelOuter_Write);
    addProperty('TLazCustomPanel', 'BevelWidth', 'Integer', @_LapeCustomPanel_BevelWidth_Read, @_LapeCustomPanel_BevelWidth_Write);
    addClassConstructor('TLazCustomPanel', '(TheOwner: TLazComponent)', @_LapeCustomPanel_Create);

    addClass('TLazPanel', 'TLazCustomPanel', TPanel);
    addClassConstructor('TLazPanel', '(TheOwner: TLazComponent)', @_LapePanel_Create);
  end;
end;

end.

