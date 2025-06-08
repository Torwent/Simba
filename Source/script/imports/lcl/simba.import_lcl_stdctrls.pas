unit simba.import_lcl_stdctrls;

{$i simba.inc}

interface

uses
  Classes, SysUtils,
  simba.base, simba.script;

procedure ImportLCLStdCtrls(Script: TSimbaScript);

implementation

uses
  controls, extctrls, stdctrls, comctrls, forms, graphics, buttons, lptypes, ffi;

type
  PObject = ^TObject;
  PComponent = ^TComponent;
  PAlignment = ^TAlignment;
  PTextLayout = ^TTextLayout;
  PButton = ^TButton;
  PButtonLayout = ^TButtonLayout;
  PCheckBox = ^TCheckBox;
  PCheckBoxState = ^TCheckBoxState;
  PComboBox = ^TComboBox;
  PComboBoxStyle = ^TComboBoxStyle;
  PCustomCheckBox = ^TCustomCheckBox;
  PCustomComboBox = ^TCustomComboBox;
  PCustomEdit = ^TCustomEdit;
  PCustomListBox = ^TCustomListBox;
  PDrawItemEvent = ^TDrawItemEvent;
  PMeasureItemEvent = ^TMeasureItemEvent;
  PSelectionChangeEvent = ^TSelectionChangeEvent;
  PEdit = ^TEdit;
  PGroupBox = ^TGroupBox;
  PLabel = ^TLabel;
  PListBox = ^TCustomListBox;
  PListBoxStyle = ^TListBoxStyle;
  PMemo = ^TMemo;
  PMemoScrollbar = ^TMemoScrollbar;
  PRadioButton = ^TRadioButton;
  PScrollStyle = ^TScrollStyle;
  PSpeedButton = ^TSpeedButton;
  PBitmap = ^TBitmap;
  PNotifyEvent = ^TNotifyEvent;
  PStrings = ^TStrings;
  PPoint = ^TPoint;
  PRect = ^TRect;
  PCanvas = ^TCanvas;
  PMouseMoveEvent = ^TMouseMoveEvent;
  PMouseEvent = ^TMouseEvent;

procedure _LapeCustomComboBox_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Result)^ := TCustomComboBox.Create(PComponent(Params^[0])^);
end;

procedure _LapeCustomComboBox_AddItem(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.AddItem(PString(Params^[1])^, PObject(Params^[2])^);
end;

procedure _LapeCustomComboBox_AddHistoryItem(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.AddHistoryItem(PString(Params^[1])^, Pinteger(Params^[2])^, PBoolean(Params^[3])^, PBoolean(Params^[4])^);
end;

procedure _LapeCustomComboBox_AddHistoryItemEx(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.AddHistoryItem(PString(Params^[1])^, PObject(Params^[2])^, Pinteger(Params^[3])^, PBoolean(Params^[4])^, PBoolean(Params^[5])^);
end;

procedure _LapeCustomComboBox_Clear(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.Clear();
end;

procedure _LapeCustomComboBox_ClearSelection(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.ClearSelection();
end;

procedure _LapeCustomComboBox_DroppedDown_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomComboBox(Params^[0])^.DroppedDown;
end;

procedure _LapeCustomComboBox_DroppedDown_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.DroppedDown := PBoolean(Params^[1])^;
end;

procedure _LapeCustomComboBox_SelectAll(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.SelectAll();
end;

procedure _LapeCustomComboBox_AutoComplete_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomComboBox(Params^[0])^.AutoComplete;
end;

procedure _LapeCustomComboBox_AutoComplete_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.AutoComplete := PBoolean(Params^[1])^;
end;

procedure _LapeCustomComboBox_AutoDropDown_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomComboBox(Params^[0])^.AutoDropDown;
end;

procedure _LapeCustomComboBox_AutoDropDown_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.AutoDropDown := PBoolean(Params^[1])^;
end;

procedure _LapeCustomComboBox_AutoSelect_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomComboBox(Params^[0])^.AutoSelect;
end;

procedure _LapeCustomComboBox_AutoSelect_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.AutoSelect := PBoolean(Params^[1])^;
end;

procedure _LapeCustomComboBox_AutoSelected_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomComboBox(Params^[0])^.AutoSelected;
end;

procedure _LapeCustomComboBox_AutoSelected_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.AutoSelected := PBoolean(Params^[1])^;
end;

procedure _LapeCustomComboBox_ArrowKeysTraverseList_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomComboBox(Params^[0])^.ArrowKeysTraverseList;
end;

procedure _LapeCustomComboBox_ArrowKeysTraverseList_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.ArrowKeysTraverseList := PBoolean(Params^[1])^;
end;

procedure _LapeCustomComboBox_Canvas_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCanvas(Result)^ := PCustomComboBox(Params^[0])^.Canvas;
end;

procedure _LapeCustomComboBox_DropDownCount_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomComboBox(Params^[0])^.DropDownCount;
end;

procedure _LapeCustomComboBox_DropDownCount_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.DropDownCount := PInteger(Params^[1])^;
end;

procedure _LapeCustomComboBox_Items_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PStrings(Result)^ := PCustomComboBox(Params^[0])^.Items;
end;

procedure _LapeCustomComboBox_Items_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.Items := PStrings(Params^[1])^;
end;

procedure _LapeCustomComboBox_ItemIndex_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomComboBox(Params^[0])^.ItemIndex;
end;

procedure _LapeCustomComboBox_ItemIndex_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.ItemIndex := Pinteger(Params^[1])^;
end;

procedure _LapeCustomComboBox_ReadOnly_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomComboBox(Params^[0])^.ReadOnly;
end;

procedure _LapeCustomComboBox_ReadOnly_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.ReadOnly := PBoolean(Params^[1])^;
end;

procedure _LapeCustomComboBox_SelLength_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomComboBox(Params^[0])^.SelLength;
end;

procedure _LapeCustomComboBox_SelLength_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.SelLength := Pinteger(Params^[1])^;
end;

procedure _LapeCustomComboBox_SelStart_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomComboBox(Params^[0])^.SelStart;
end;

procedure _LapeCustomComboBox_SelStart_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.SelStart := Pinteger(Params^[1])^;
end;

procedure _LapeCustomComboBox_SelText_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PString(Result)^ := PCustomComboBox(Params^[0])^.SelText;
end;

procedure _LapeCustomComboBox_SelText_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.SelText := PString(Params^[1])^;
end;

procedure _LapeCustomComboBox_Style_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PComboBoxStyle(Result)^ := PCustomComboBox(Params^[0])^.Style;
end;

procedure _LapeCustomComboBox_Style_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.Style := PComboBoxStyle(Params^[1])^;
end;

procedure _LapeCustomComboBox_Text_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PString(Result)^ := PCustomComboBox(Params^[0])^.Text;
end;

procedure _LapeCustomComboBox_Text_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomComboBox(Params^[0])^.Text := PString(Params^[1])^;
end;

procedure _LapeComboBox_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PComboBox(Result)^ := TComboBox.Create(PComponent(Params^[0])^);
end;

procedure _LapeCustomComboBox_OnChange_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PComboBox(Params^[0])^.OnChange;
end;

procedure _LapeCustomComboBox_OnChange_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PComboBox(Params^[0])^.OnChange := PNotifyEvent(Params^[1])^;
end;

procedure _LapeCustomListBox_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Result)^ := TCustomListBox.Create(PComponent(Params^[0])^);
end;

procedure _LapeCustomListBox_AddItem(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.AddItem(PString(Params^[1])^, PObject(Params^[2])^);
end;

procedure _LapeCustomListBox_Click(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.Click();
end;

procedure _LapeCustomListBox_Clear(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.Clear();
end;

procedure _LapeCustomListBox_ClearSelection(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.ClearSelection();
end;

procedure _LapeCustomListBox_GetIndexAtXY(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomListBox(Params^[0])^.GetIndexAtXY(Pinteger(Params^[1])^, Pinteger(Params^[2])^);
end;

procedure _LapeCustomListBox_GetIndexAtY(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomListBox(Params^[0])^.GetIndexAtY(Pinteger(Params^[1])^);
end;

procedure _LapeCustomListBox_GetSelectedText(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PString(Result)^ := PCustomListBox(Params^[0])^.GetSelectedText();
end;

procedure _LapeCustomListBox_ItemAtPos(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomListBox(Params^[0])^.ItemAtPos(PPoint(Params^[1])^, PBoolean(Params^[2])^);
end;

procedure _LapeCustomListBox_ItemRect(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PRect(Result)^ := PCustomListBox(Params^[0])^.ItemRect(PInteger(Params^[1])^);
end;

procedure _LapeCustomListBox_ItemVisible(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomListBox(Params^[0])^.ItemVisible(PInteger(Params^[1])^);
end;

procedure _LapeCustomListBox_ItemFullyVisible(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomListBox(Params^[0])^.ItemFullyVisible(PInteger(Params^[1])^);
end;

procedure _LapeCustomListBox_LockSelectionChange(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.LockSelectionChange();
end;

procedure _LapeCustomListBox_MakeCurrentVisible(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.MakeCurrentVisible();
end;

procedure _LapeCustomListBox_MeasureItem(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.MeasureItem(PInteger(Params^[1])^, PInteger(Params^[2])^);
end;

procedure _LapeCustomListBox_SelectAll(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.SelectAll();
end;

procedure _LapeCustomListBox_UnlockSelectionChange(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.UnlockSelectionChange();
end;

procedure _LapeCustomListBox_DrawFocusRect_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := lboDrawFocusRect in PCustomListBox(Params^[0])^.Options;
end;

procedure _LapeCustomListBox_DrawFocusRect_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.Options := PCustomListBox(Params^[0])^.Options + [lboDrawFocusRect];
end;

procedure _LapeCustomListBox_Canvas_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCanvas(Result)^ := PCustomListBox(Params^[0])^.Canvas;
end;

procedure _LapeCustomListBox_ClickOnSelChange_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomListBox(Params^[0])^.ClickOnSelChange;
end;

procedure _LapeCustomListBox_ClickOnSelChange_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.ClickOnSelChange := PBoolean(Params^[1])^;
end;

procedure _LapeCustomListBox_Columns_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomListBox(Params^[0])^.Columns;
end;

procedure _LapeCustomListBox_Columns_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.Columns := PInteger(Params^[1])^;
end;

procedure _LapeCustomListBox_Count_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomListBox(Params^[0])^.Count;
end;

procedure _LapeCustomListBox_ExtendedSelect_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomListBox(Params^[0])^.ExtendedSelect;
end;

procedure _LapeCustomListBox_ExtendedSelect_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.ExtendedSelect := PBoolean(Params^[1])^;
end;

procedure _LapeCustomListBox_ItemHeight_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomListBox(Params^[0])^.ItemHeight;
end;

procedure _LapeCustomListBox_ItemHeight_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.ItemHeight := PInteger(Params^[1])^;
end;

procedure _LapeCustomListBox_ItemIndex_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomListBox(Params^[0])^.ItemIndex;
end;

procedure _LapeCustomListBox_ItemIndex_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.ItemIndex := Pinteger(Params^[1])^;
end;

procedure _LapeCustomListBox_Items_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PStrings(Result)^ := PCustomListBox(Params^[0])^.Items;
end;

procedure _LapeCustomListBox_Items_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.Items := PStrings(Params^[1])^;
end;

procedure _LapeCustomListBox_MultiSelect_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomListBox(Params^[0])^.MultiSelect;
end;

procedure _LapeCustomListBox_MultiSelect_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.MultiSelect := PBoolean(Params^[1])^;
end;

procedure _LapeCustomListBox_ScrollWidth_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomListBox(Params^[0])^.ScrollWidth;
end;

procedure _LapeCustomListBox_ScrollWidth_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.ScrollWidth := PInteger(Params^[1])^;
end;

procedure _LapeCustomListBox_SelCount_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomListBox(Params^[0])^.SelCount;
end;

procedure _LapeCustomListBox_Sorted_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomListBox(Params^[0])^.Sorted;
end;

procedure _LapeCustomListBox_Sorted_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.Sorted := PBoolean(Params^[1])^;
end;

procedure _LapeCustomListBox_TopIndex_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomListBox(Params^[0])^.TopIndex;
end;

procedure _LapeCustomListBox_TopIndex_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.TopIndex := PInteger(Params^[1])^;
end;

procedure _LapeCustomListBox_OnDblClick_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PCustomListBox(Params^[0])^.OnDblClick;
end;

procedure _LapeCustomListBox_OnDblClick_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.OnDblClick := PNotifyEvent(Params^[1])^;
end;

procedure _LapeCustomListBox_Style_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PListBoxStyle(Result)^ := PCustomListBox(Params^[0])^.Style;
end;

procedure _LapeCustomListBox_Style_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.Style := PListBoxStyle(Params^[1])^;
end;

procedure _LapeCustomListBox_OnSelectionChange_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSelectionChangeEvent(Result)^ := PCustomListBox(Params^[0])^.OnSelectionChange;
end;

procedure _LapeCustomListBox_OnSelectionChange_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.OnSelectionChange := PSelectionChangeEvent(Params^[1])^;
end;

procedure _LapeCustomListBox_OnMeasureItem_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMeasureItemEvent(Result)^ := PCustomListBox(Params^[0])^.OnMeasureItem;
end;

procedure _LapeCustomListBox_OnMeasureItem_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.OnMeasureItem := PMeasureItemEvent(Params^[1])^;
end;

procedure _LapeCustomListBox_OnDrawItem_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PDrawItemEvent(Result)^ := PCustomListBox(Params^[0])^.OnDrawItem;
end;

procedure _LapeCustomListBox_OnDrawItem_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomListBox(Params^[0])^.OnDrawItem := PDrawItemEvent(Params^[1])^;
end;

procedure _LapeListBox_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PListBox(Result)^ := TListBox.Create(PComponent(Params^[0])^);
end;

procedure _LapeCustomEdit_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Result)^ := TCustomEdit.Create(PComponent(Params^[0])^);
end;

procedure _LapeCustomEdit_Clear(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.Clear();
end;

procedure _LapeCustomEdit_SelectAll(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.SelectAll();
end;

procedure _LapeCustomEdit_ClearSelection(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.ClearSelection();
end;

procedure _LapeCustomEdit_CopyToClipboard(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.CopyToClipboard();
end;

procedure _LapeCustomEdit_CutToClipboard(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.CutToClipboard();
end;

procedure _LapeCustomEdit_PasteFromClipboard(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.PasteFromClipboard();
end;

procedure _LapeCustomEdit_Undo(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.Undo();
end;

procedure _LapeCustomEdit_CanUndo_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomEdit(Params^[0])^.CanUndo;
end;

procedure _LapeCustomEdit_CaretPos_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PPoint(Result)^ := PCustomEdit(Params^[0])^.CaretPos;
end;

procedure _LapeCustomEdit_CaretPos_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.CaretPos := PPoint(Params^[1])^;
end;

procedure _LapeCustomEdit_HideSelection_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomEdit(Params^[0])^.HideSelection;
end;

procedure _LapeCustomEdit_HideSelection_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.HideSelection := PBoolean(Params^[1])^;
end;

procedure _LapeCustomEdit_MaxLength_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PInteger(Result)^ := PCustomEdit(Params^[0])^.MaxLength;
end;

procedure _LapeCustomEdit_MaxLength_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.MaxLength := PInteger(Params^[1])^;
end;

procedure _LapeCustomEdit_Modified_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomEdit(Params^[0])^.Modified;
end;

procedure _LapeCustomEdit_Modified_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.Modified := PBoolean(Params^[1])^;
end;

procedure _LapeCustomEdit_OnChange_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PCustomEdit(Params^[0])^.OnChange;
end;

procedure _LapeCustomEdit_OnChange_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.OnChange := PNotifyEvent(Params^[1])^;
end;

procedure _LapeCustomEdit_PasswordChar_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PChar(Result)^ := PCustomEdit(Params^[0])^.PasswordChar;
end;

procedure _LapeCustomEdit_PasswordChar_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.PasswordChar := PChar(Params^[1])^;
end;

procedure _LapeCustomEdit_ReadOnly_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomEdit(Params^[0])^.ReadOnly;
end;

procedure _LapeCustomEdit_ReadOnly_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.ReadOnly := PBoolean(Params^[1])^;
end;

procedure _LapeCustomEdit_SelLength_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomEdit(Params^[0])^.SelLength;
end;

procedure _LapeCustomEdit_SelLength_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.SelLength := Pinteger(Params^[1])^;
end;

procedure _LapeCustomEdit_SelStart_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PCustomEdit(Params^[0])^.SelStart;
end;

procedure _LapeCustomEdit_SelStart_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.SelStart := Pinteger(Params^[1])^;
end;

procedure _LapeCustomEdit_SelText_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PString(Result)^ := PCustomEdit(Params^[0])^.SelText;
end;

procedure _LapeCustomEdit_SelText_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.SelText := PString(Params^[1])^;
end;

procedure _LapeCustomEdit_Text_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PString(Result)^ := PCustomEdit(Params^[0])^.Text;
end;

procedure _LapeCustomEdit_Text_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomEdit(Params^[0])^.Text := PString(Params^[1])^;
end;

procedure _LapeEdit_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PEdit(Result)^ := TEdit.Create(PComponent(Params^[0])^);
end;

procedure _LapeEdit_OnEditingDone_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PEdit(Params^[0])^.OnEditingDone;
end;

procedure _LapeEdit_OnEditingDone_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PEdit(Params^[0])^.OnEditingDone := PNotifyEvent(Params^[1])^;
end;

procedure _LapeGroupBox_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PGroupBox(Result)^ := TGroupBox.Create(PComponent(Params^[0])^);
end;

procedure _LapeMemo_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Result)^ := TMemo.Create(PComponent(Params^[0])^);
end;

procedure _LapeMemo_Append(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.Append(PString(Params^[1])^);
end;

procedure _LapeMemo_Lines_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PStrings(Result)^ := PMemo(Params^[0])^.Lines;
end;

procedure _LapeMemo_Lines_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.Lines := PStrings(Params^[1])^;
end;

procedure _LapeMemo_HorzScrollBar_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMemoScrollBar(Result)^ := PMemo(Params^[0])^.HorzScrollBar;
end;

procedure _LapeMemo_HorzScrollBar_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.HorzScrollBar := PMemoScrollBar(Params^[1])^;
end;

procedure _LapeMemo_VertScrollBar_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMemoScrollBar(Result)^ := PMemo(Params^[0])^.VertScrollBar;
end;

procedure _LapeMemo_VertScrollBar_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.VertScrollBar := PMemoScrollBar(Params^[1])^;
end;

procedure _LapeMemo_ScrollBars_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PScrollStyle(Result)^ := PMemo(Params^[0])^.ScrollBars;
end;

procedure _LapeMemo_ScrollBars_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.ScrollBars := PScrollStyle(Params^[1])^;
end;

procedure _LapeMemo_WantReturns_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PMemo(Params^[0])^.WantReturns;
end;

procedure _LapeMemo_WantReturns_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.WantReturns := PBoolean(Params^[1])^;
end;

procedure _LapeMemo_WantTabs_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PMemo(Params^[0])^.WantTabs;
end;

procedure _LapeMemo_WantTabs_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.WantTabs := PBoolean(Params^[1])^;
end;

procedure _LapeMemo_WordWrap_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PMemo(Params^[0])^.WordWrap;
end;

procedure _LapeMemo_WordWrap_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PMemo(Params^[0])^.WordWrap := PBoolean(Params^[1])^;
end;

procedure _LapeButton_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PButton(Result)^ := TButton.Create(PComponent(Params^[0])^);
end;

procedure _LapeButton_Click(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PButton(Params^[0])^.Click();
end;

procedure _LapeButton_OnMouseMove_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseMoveEvent(Result)^ := PButton(Params^[0])^.OnMouseMove;
end;

procedure _LapeButton_OnMouseMove_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PButton(Params^[0])^.OnMouseMove := PMouseMoveEvent(Params^[1])^;
end;

procedure _LapeButton_OnMouseDown_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PButton(Params^[0])^.OnMouseDown := PMouseEvent(Params^[1])^;
end;

procedure _LapeButton_OnMouseDown_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseEvent(Result)^ := PButton(Params^[0])^.OnMouseDown;
end;

procedure _LapeButton_OnMouseUp_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PButton(Params^[0])^.OnMouseUp := PMouseEvent(Params^[1])^;
end;

procedure _LapeButton_OnMouseUp_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseEvent(Result)^ := PButton(Params^[0])^.OnMouseUp;
end;

procedure _LapeButton_OnMouseLeave_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PButton(Params^[0])^.OnMouseLeave;
end;

procedure _LapeButton_OnMouseLeave_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PButton(Params^[0])^.OnMouseLeave := PNotifyEvent(Params^[1])^;
end;

procedure _LapeButton_OnMouseEnter_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PButton(Params^[0])^.OnMouseEnter;
end;

procedure _LapeButton_OnMouseEnter_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PButton(Params^[0])^.OnMouseEnter := PNotifyEvent(Params^[1])^;
end;

procedure _LapeCustomCheckBox_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomCheckBox(Result)^ := TCustomCheckBox.Create(PComponent(Params^[0])^);
end;

procedure _LapeCustomCheckBox_AllowGrayed_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PCustomCheckBox(Params^[0])^.AllowGrayed;
end;

procedure _LapeCustomCheckBox_AllowGrayed_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomCheckBox(Params^[0])^.AllowGrayed := PBoolean(Params^[1])^;
end;

procedure _LapeCustomCheckBox_State_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCheckBoxState(Result)^ := PCustomCheckBox(Params^[0])^.State;
end;

procedure _LapeCustomCheckBox_State_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomCheckBox(Params^[0])^.State := PCheckBoxState(Params^[1])^;
end;

procedure _LapeCustomCheckBox_OnChange_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PCustomCheckBox(Params^[0])^.OnChange;
end;

procedure _LapeCustomCheckBox_OnChange_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PCustomCheckBox(Params^[0])^.OnChange := PNotifyEvent(Params^[1])^;
end;

procedure _LapeCheckBox_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PCheckBox(Result)^ := TCheckBox.Create(PComponent(Params^[0])^);
end;

procedure _LapeLabel_AdjustFontForOptimalFill(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PLabel(Params^[0])^.AdjustFontForOptimalFill();
end;

procedure _LapeLabel_Alignment_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PAlignment(Result)^ := PLabel(Params^[0])^.Alignment;
end;

procedure _LapeLabel_Alignment_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.Alignment := PAlignment(Params^[1])^;
end;

procedure _LapeLabel_Layout_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PTextLayout(Result)^ := PLabel(Params^[0])^.Layout;
end;

procedure _LapeLabel_Layout_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.Layout := PTextLayout(Params^[1])^;
end;

procedure _LapeLabel_Transparent_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PLabel(Params^[0])^.Transparent;
end;

procedure _LapeLabel_Transparent_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.Transparent := PBoolean(Params^[1])^;
end;

procedure _LapeLabel_WordWrap_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PLabel(Params^[0])^.WordWrap;
end;

procedure _LapeLabel_WordWrap_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.WordWrap := PBoolean(Params^[1])^;
end;

procedure _LapeLabel_OptimalFill_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PLabel(Params^[0])^.OptimalFill;
end;

procedure _LapeLabel_OptimalFill_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.OptimalFill := PBoolean(Params^[1])^;
end;

procedure _LapeLabel_OnMouseEnter_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PLabel(Params^[0])^.OnMouseEnter;
end;

procedure _LapeLabel_OnMouseEnter_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.OnMouseEnter := PNotifyEvent(Params^[1])^;
end;

procedure _LapeLabel_OnMouseLeave_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PLabel(Params^[0])^.OnMouseLeave;
end;

procedure _LapeLabel_OnMouseLeave_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.OnMouseLeave := PNotifyEvent(Params^[1])^;
end;

procedure _LapeLabel_OnMouseMove_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseMoveEvent(Result)^ := PLabel(Params^[0])^.OnMouseMove;
end;

procedure _LapeLabel_OnMouseMove_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.OnMouseMove := PMouseMoveEvent(Params^[1])^;
end;

procedure _LapeLabel_OnMouseDown_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseEvent(Result)^ := PLabel(Params^[0])^.OnMouseDown;
end;

procedure _LapeLabel_OnMouseDown_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.OnMouseDown := PMouseEvent(Params^[1])^;
end;

procedure _LapeLabel_OnMouseUp_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseEvent(Result)^ := PLabel(Params^[0])^.OnMouseUp;
end;

procedure _LapeLabel_OnMouseUp_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Params^[0])^.OnMouseUp := PMouseEvent(Params^[1])^;
end;

procedure _LapeLabel_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PLabel(Result)^ := TLabel.Create(PComponent(Params^[0])^);
end;

procedure _LapeSpeedButton_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Result)^ := TSpeedButton.Create(PComponent(Params^[0])^);
end;

procedure _LapeSpeedButton_OnMouseEnter_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PSpeedButton(Params^[0])^.OnMouseEnter;
end;

procedure _LapeSpeedButton_OnMouseEnter_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.OnMouseEnter := PNotifyEvent(Params^[1])^;
end;

procedure _LapeSpeedButton_OnMouseLeave_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PSpeedButton(Params^[0])^.OnMouseLeave;
end;

procedure _LapeSpeedButton_OnMouseLeave_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.OnMouseLeave := PNotifyEvent(Params^[1])^;
end;

procedure _LapeSpeedButton_OnMouseMove_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseMoveEvent(Result)^ := PSpeedButton(Params^[0])^.OnMouseMove;
end;

procedure _LapeSpeedButton_OnMouseMove_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.OnMouseMove := PMouseMoveEvent(Params^[1])^;
end;

procedure _LapeSpeedButton_OnMouseDown_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseEvent(Result)^ := PSpeedButton(Params^[0])^.OnMouseDown;
end;

procedure _LapeSpeedButton_OnMouseDown_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.OnMouseDown := PMouseEvent(Params^[1])^;
end;

procedure _LapeSpeedButton_OnMouseUp_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PMouseEvent(Result)^ := PSpeedButton(Params^[0])^.OnMouseUp;
end;

procedure _LapeSpeedButton_OnMouseUp_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.OnMouseUp := PMouseEvent(Params^[1])^;
end;

procedure _LapeSpeedButton_OnPaint_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PNotifyEvent(Result)^ := PSpeedButton(Params^[0])^.OnPaint;
end;

procedure _LapeSpeedButton_OnPaint_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.OnPaint := PNotifyEvent(Params^[1])^;
end;

procedure _LapeSpeedButton_Glyph_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBitmap(Result)^ := PSpeedButton(Params^[0])^.Glyph;
end;

procedure _LapeSpeedButton_Down_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PSpeedButton(Params^[0])^.Down;
end;

procedure _LapeSpeedButton_Down_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.Down := PBoolean(Params^[1])^;
end;

procedure _LapeSpeedButton_Flat_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PSpeedButton(Params^[0])^.Flat;
end;

procedure _LapeSpeedButton_Flat_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.Flat := PBoolean(Params^[1])^;
end;

procedure _LapeSpeedButton_Layout_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PButtonLayout(Result)^ := PSpeedButton(Params^[0])^.Layout;
end;

procedure _LapeSpeedButton_Layout_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.Layout := PButtonLayout(Params^[1])^;
end;

procedure _LapeSpeedButton_Margin_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PSpeedButton(Params^[0])^.Margin;
end;

procedure _LapeSpeedButton_Margin_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.Margin := Pinteger(Params^[1])^;
end;

procedure _LapeSpeedButton_ShowCaption_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PSpeedButton(Params^[0])^.ShowCaption;
end;

procedure _LapeSpeedButton_ShowCaption_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.ShowCaption := PBoolean(Params^[1])^;
end;

procedure _LapeSpeedButton_Spacing_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  Pinteger(Result)^ := PSpeedButton(Params^[0])^.Spacing;
end;

procedure _LapeSpeedButton_Spacing_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.Spacing := Pinteger(Params^[1])^;
end;

procedure _LapeSpeedButton_Transparent_Read(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PBoolean(Result)^ := PSpeedButton(Params^[0])^.Transparent;
end;

procedure _LapeSpeedButton_Transparent_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.Transparent := PBoolean(Params^[1])^;
end;

procedure _LapeSpeedButton_Glyph_Write(const Params: PParamArray); LAPE_WRAPPER_CALLING_CONV
begin
  PSpeedButton(Params^[0])^.Glyph := PBitmap(Params^[1])^;
end;

procedure _LapeRadioButton_Create(const Params: PParamArray; const Result: Pointer); LAPE_WRAPPER_CALLING_CONV
begin
  PRadioButton(Result)^ := TRadioButton.Create(PComponent(Params^[0])^);
end;

procedure ImportLCLStdCtrls(Script: TSimbaScript);
begin
  with Script.Compiler do
  begin
    addGlobalType('enum(ssNone, ssHorizontal, ssVertical, ssBoth, ssAutoHorizontal, ssAutoVertical, ssAutoBoth)', 'ELazScrollStyle');
    addGlobalType('set of enum(odSelected, odGrayed, odDisabled, odChecked, odFocused, odDefault, odHotLight, odInactive, odNoAccel, odNoFocusRect, odReserved1, odReserved2, odComboBoxEdit, odBackgroundPainted)', 'ELazOwnerDrawStates');
    addGlobalType('enum(csDropDown, csSimple, csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable, csOwnerDrawEditableFixed, csOwnerDrawEditableVariable)', 'ELazComboBoxStyle');
    addGlobalType('enum(lbStandard, lbOwnerDrawFixed, lbOwnerDrawVariable, lbVirtual)', 'ELazListBoxStyle');
    addGlobalType('enum(taLeftJustify, taRightJustify, taCenter)', 'ELazAlignment');
    addGlobalType('enum(cbUnchecked, cbChecked, cbGrayed)', 'ELazCheckBoxState');
    addGlobalType('enum(blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom)', 'ELazButtonLayout');

    addGlobalType('procedure(Control: TLazWinControl; Index: Integer; ARect: TLazRect; State: ELazOwnerDrawStates) of object', 'TLazDrawItemEvent', FFI_DEFAULT_ABI);
    addGlobalType('procedure(Control: TLazWinControl; Index: Integer; var AHeight: Integer) of object', 'TLazMeasureItemEvent', FFI_DEFAULT_ABI);
    addGlobalType('procedure(Sender: TObject; User: Boolean) of object', 'TLazSelectionChangeEvent', FFI_DEFAULT_ABI);

    addClass('TLazCustomComboBox', 'TLazWinControl', TCustomComboBox);
    addClassConstructor('TLazCustomComboBox', '(TheOwner: TLazComponent)', @_LapeCustomComboBox_Create);
    addGlobalFunc('procedure TLazCustomComboBox.AddItem(const Item: String; AnObject: TObject);', @_LapeCustomComboBox_AddItem);
    addGlobalFunc('procedure TLazCustomComboBox.AddHistoryItem(const Item: string; MaxHistoryCount: Integer;SetAsText, CaseSensitive: Boolean);', @_LapeCustomComboBox_AddHistoryItem);
    addGlobalFunc('procedure TLazCustomComboBox.AddHistoryItem(const Item: string; AnObject: TObject;MaxHistoryCount: Integer; SetAsText, CaseSensitive: Boolean); overload', @_LapeCustomComboBox_AddHistoryItemEx);
    addGlobalFunc('procedure TLazCustomComboBox.Clear;', @_LapeCustomComboBox_Clear);
    addGlobalFunc('procedure TLazCustomComboBox.ClearSelection;', @_LapeCustomComboBox_ClearSelection);
    addGlobalFunc('procedure TLazCustomComboBox.SelectAll;', @_LapeCustomComboBox_SelectAll);
    addProperty('TLazCustomComboBox', 'DroppedDown', 'Boolean', @_LapeCustomComboBox_DroppedDown_Read, @_LapeCustomComboBox_DroppedDown_Write);
    addProperty('TLazCustomComboBox', 'AutoComplete', 'Boolean', @_LapeCustomComboBox_AutoComplete_Read, @_LapeCustomComboBox_AutoComplete_Write);
    addProperty('TLazCustomComboBox', 'AutoDropDown', 'Boolean', @_LapeCustomComboBox_AutoDropDown_Read, @_LapeCustomComboBox_AutoDropDown_Write);
    addProperty('TLazCustomComboBox', 'AutoSelect', 'Boolean', @_LapeCustomComboBox_AutoSelect_Read, @_LapeCustomComboBox_AutoSelect_Write);
    addProperty('TLazCustomComboBox', 'AutoSelected', 'Boolean', @_LapeCustomComboBox_AutoSelected_Read, @_LapeCustomComboBox_AutoSelected_Write);
    addProperty('TLazCustomComboBox', 'ArrowKeysTraverseList', 'Boolean', @_LapeCustomComboBox_ArrowKeysTraverseList_Read, @_LapeCustomComboBox_ArrowKeysTraverseList_Write);
    addProperty('TLazCustomComboBox', 'Canvas', 'TLazCanvas', @_LapeCustomComboBox_Canvas_Read);
    addProperty('TLazCustomComboBox', 'DropDownCount', 'Integer', @_LapeCustomComboBox_DropDownCount_Read, @_LapeCustomComboBox_DropDownCount_Write);
    addProperty('TLazCustomComboBox', 'Items', 'TLazStrings', @_LapeCustomComboBox_Items_Read, @_LapeCustomComboBox_Items_Write);
    addProperty('TLazCustomComboBox', 'ItemIndex', 'Integer', @_LapeCustomComboBox_ItemIndex_Read, @_LapeCustomComboBox_ItemIndex_Write);
    addProperty('TLazCustomComboBox', 'ReadOnly', 'Boolean', @_LapeCustomComboBox_ReadOnly_Read, @_LapeCustomComboBox_ReadOnly_Write);
    addProperty('TLazCustomComboBox', 'SelLength', 'Integer', @_LapeCustomComboBox_SelLength_Read, @_LapeCustomComboBox_SelLength_Write);
    addProperty('TLazCustomComboBox', 'SelStart', 'Integer', @_LapeCustomComboBox_SelStart_Read, @_LapeCustomComboBox_SelStart_Write);
    addProperty('TLazCustomComboBox', 'SelText', 'String', @_LapeCustomComboBox_SelText_Read, @_LapeCustomComboBox_SelText_Write);
    addProperty('TLazCustomComboBox', 'Style', 'ELazComboBoxStyle', @_LapeCustomComboBox_Style_Read, @_LapeCustomComboBox_Style_Write);
    addProperty('TLazCustomComboBox', 'Text', 'string', @_LapeCustomComboBox_Text_Read, @_LapeCustomComboBox_Text_Write);

    addClass('TLazComboBox', 'TLazCustomComboBox', TComboBox);
    addClassConstructor('TLazComboBox', '(TheOwner: TLazComponent)', @_LapeComboBox_Create);
    addProperty('TLazComboBox', 'OnChange', 'TLazNotifyEvent', @_LapeCustomComboBox_OnChange_Read, @_LapeCustomComboBox_OnChange_Write);

    addClass('TLazCustomListBox', 'TLazWinControl', TCustomListBox);
    addClassConstructor('TLazCustomListBox', '(TheOwner: TLazComponent)', @_LapeCustomListBox_Create);
    addGlobalFunc('procedure TLazCustomListBox.AddItem(const Item: String; AnObject: TObject);', @_LapeCustomListBox_AddItem);
    addGlobalFunc('procedure TLazCustomListBox.Click;', @_LapeCustomListBox_Click);
    addGlobalFunc('procedure TLazCustomListBox.Clear;', @_LapeCustomListBox_Clear);
    addGlobalFunc('procedure TLazCustomListBox.ClearSelection;', @_LapeCustomListBox_ClearSelection);
    addGlobalFunc('function TLazCustomListBox.GetIndexAtXY(X, Y: Integer): Integer;', @_LapeCustomListBox_GetIndexAtXY);
    addGlobalFunc('function TLazCustomListBox.GetIndexAtY(Y: Integer): Integer;', @_LapeCustomListBox_GetIndexAtY);
    addGlobalFunc('function TLazCustomListBox.GetSelectedText: string;', @_LapeCustomListBox_GetSelectedText);
    addGlobalFunc('function TLazCustomListBox.ItemAtPos(const Pos: TPoint; Existing: Boolean): Integer;', @_LapeCustomListBox_ItemAtPos);
    addGlobalFunc('function TLazCustomListBox.ItemRect(Index: Integer): TLazRect;', @_LapeCustomListBox_ItemRect);
    addGlobalFunc('function TLazCustomListBox.ItemVisible(Index: Integer): Boolean;', @_LapeCustomListBox_ItemVisible);
    addGlobalFunc('function TLazCustomListBox.ItemFullyVisible(Index: Integer): Boolean;', @_LapeCustomListBox_ItemFullyVisible);
    addGlobalFunc('procedure TLazCustomListBox.LockSelectionChange;', @_LapeCustomListBox_LockSelectionChange);
    addGlobalFunc('procedure TLazCustomListBox.MakeCurrentVisible;', @_LapeCustomListBox_MakeCurrentVisible);
    addGlobalFunc('procedure TLazCustomListBox.MeasureItem(Index: Integer; var TheHeight: Integer);', @_LapeCustomListBox_MeasureItem);
    addGlobalFunc('procedure TLazCustomListBox.SelectAll;', @_LapeCustomListBox_SelectAll);
    addGlobalFunc('procedure TLazCustomListBox.UnlockSelectionChange;', @_LapeCustomListBox_UnlockSelectionChange);
    addProperty('TLazCustomListBox', 'DrawFocusRect', 'Boolean', @_LapeCustomListBox_DrawFocusRect_Read, @_LapeCustomListBox_DrawFocusRect_Write);
    addProperty('TLazCustomListBox', 'Canvas', 'TLazCanvas', @_LapeCustomListBox_Canvas_Read);
    addProperty('TLazCustomListBox', 'ClickOnSelChange', 'Boolean', @_LapeCustomListBox_ClickOnSelChange_Read, @_LapeCustomListBox_ClickOnSelChange_Write);
    addProperty('TLazCustomListBox', 'Columns', 'Integer', @_LapeCustomListBox_Columns_Read, @_LapeCustomListBox_Columns_Write);
    addProperty('TLazCustomListBox', 'Count', 'Integer', @_LapeCustomListBox_Count_Read);
    addProperty('TLazCustomListBox', 'ExtendedSelect', 'Boolean', @_LapeCustomListBox_ExtendedSelect_Read, @_LapeCustomListBox_ExtendedSelect_Write);
    addProperty('TLazCustomListBox', 'ItemHeight', 'Integer', @_LapeCustomListBox_ItemHeight_Read, @_LapeCustomListBox_ItemHeight_Write);
    addProperty('TLazCustomListBox', 'ItemIndex', 'Integer', @_LapeCustomListBox_ItemIndex_Read, @_LapeCustomListBox_ItemIndex_Write);
    addProperty('TLazCustomListBox', 'Items', 'TLazStrings', @_LapeCustomListBox_Items_Read, @_LapeCustomListBox_Items_Write);
    addProperty('TLazCustomListBox', 'MultiSelect', 'Boolean', @_LapeCustomListBox_MultiSelect_Read, @_LapeCustomListBox_MultiSelect_Write);
    addProperty('TLazCustomListBox', 'ScrollWidth', 'Integer', @_LapeCustomListBox_ScrollWidth_Read, @_LapeCustomListBox_ScrollWidth_Write);
    addProperty('TLazCustomListBox', 'SelCount', 'Integer', @_LapeCustomListBox_SelCount_Read);
    addProperty('TLazCustomListBox', 'Sorted', 'Boolean', @_LapeCustomListBox_Sorted_Read, @_LapeCustomListBox_Sorted_Write);
    addProperty('TLazCustomListBox', 'TopIndex', 'Integer', @_LapeCustomListBox_TopIndex_Read, @_LapeCustomListBox_TopIndex_Write);
    addProperty('TLazCustomListBox', 'Style', 'ELazListBoxStyle', @_LapeCustomListBox_Style_Read, @_LapeCustomListBox_Style_Write);
    addProperty('TLazCustomListBox', 'OnDblClick', 'TLazNotifyEvent', @_LapeCustomListBox_OnDblClick_Read, @_LapeCustomListBox_OnDblClick_Write);
    addProperty('TLazCustomListBox', 'OnDrawItem', 'TLazDrawItemEvent', @_LapeCustomListBox_OnDrawItem_Read, @_LapeCustomListBox_OnDrawItem_Write);
    addProperty('TLazCustomListBox', 'OnMeasureItemEvent', 'TLazMeasureItemEvent', @_LapeCustomListBox_OnMeasureItem_Read, @_LapeCustomListBox_OnMeasureItem_Write);
    addProperty('TLazCustomListBox', 'OnSelectionChange', 'TLazSelectionChangeEvent', @_LapeCustomListBox_OnSelectionChange_Read, @_LapeCustomListBox_OnSelectionChange_Write);

    addClass('TLazListBox', 'TLazCustomListBox', TListBox);
    addClassConstructor('TLazListBox', '(AOwner: TLazComponent)', @_LapeListBox_Create);

    addClass('TLazCustomEdit', 'TLazWinControl', TCustomEdit);
    addClassConstructor('TLazCustomEdit', '(AOwner: TLazComponent)', @_LapeCustomEdit_Create);
    addGlobalFunc('procedure TLazCustomEdit.Clear;', @_LapeCustomEdit_Clear);
    addGlobalFunc('procedure TLazCustomEdit.SelectAll;', @_LapeCustomEdit_SelectAll);
    addGlobalFunc('procedure TLazCustomEdit.ClearSelection;', @_LapeCustomEdit_ClearSelection);
    addGlobalFunc('procedure TLazCustomEdit.CopyToClipboard;', @_LapeCustomEdit_CopyToClipboard);
    addGlobalFunc('procedure TLazCustomEdit.CutToClipboard;', @_LapeCustomEdit_CutToClipboard);
    addGlobalFunc('procedure TLazCustomEdit.PasteFromClipboard;', @_LapeCustomEdit_PasteFromClipboard);
    addGlobalFunc('procedure TLazCustomEdit.Undo;', @_LapeCustomEdit_Undo);
    addProperty('TLazCustomEdit', 'CanUndo', 'Boolean', @_LapeCustomEdit_CanUndo_Read);
    addProperty('TLazCustomEdit', 'CaretPos', 'TPoint', @_LapeCustomEdit_CaretPos_Read, @_LapeCustomEdit_CaretPos_Write);
    addProperty('TLazCustomEdit', 'HideSelection', 'Boolean', @_LapeCustomEdit_HideSelection_Read, @_LapeCustomEdit_HideSelection_Write);
    addProperty('TLazCustomEdit', 'MaxLength', 'Integer', @_LapeCustomEdit_MaxLength_Read, @_LapeCustomEdit_MaxLength_Write);
    addProperty('TLazCustomEdit', 'Modified', 'Boolean', @_LapeCustomEdit_Modified_Read, @_LapeCustomEdit_Modified_Write);
    addProperty('TLazCustomEdit', 'OnChange', 'TLazNotifyEvent', @_LapeCustomEdit_OnChange_Read, @_LapeCustomEdit_OnChange_Write);
    addProperty('TLazCustomEdit', 'PasswordChar', 'Char', @_LapeCustomEdit_PasswordChar_Read, @_LapeCustomEdit_PasswordChar_Write);
    addProperty('TLazCustomEdit', 'ReadOnly', 'Boolean', @_LapeCustomEdit_ReadOnly_Read, @_LapeCustomEdit_ReadOnly_Write);
    addProperty('TLazCustomEdit', 'SelLength', 'Integer', @_LapeCustomEdit_SelLength_Read, @_LapeCustomEdit_SelLength_Write);
    addProperty('TLazCustomEdit', 'SelStart', 'Integer', @_LapeCustomEdit_SelStart_Read, @_LapeCustomEdit_SelStart_Write);
    addProperty('TLazCustomEdit', 'SelText', 'String', @_LapeCustomEdit_SelText_Read, @_LapeCustomEdit_SelText_Write);
    addProperty('TLazCustomEdit', 'Text', 'string', @_LapeCustomEdit_Text_Read, @_LapeCustomEdit_Text_Write);

    addClass('TLazEdit', 'TLazCustomEdit', TEdit);
    addProperty('TLazEdit', 'OnEditingDone', 'TLazNotifyEvent', @_LapeEdit_OnEditingDone_Read, @_LapeEdit_OnEditingDone_Write);
    addClassConstructor('TLazEdit', '(AOwner: TLazComponent)', @_LapeEdit_Create);

    addClass('TLazGroupBox', 'TLazWinControl', TGroupBox);
    addClassConstructor('TLazGroupBox', '(AOwner: TLazComponent)', @_LapeGroupBox_Create);

    addClass('TLazMemo', 'TLazCustomEdit', TMemo);
    addClassConstructor('TLazMemo', '(AOwner: TLazComponent)', @_LapeMemo_Create);
    addGlobalFunc('procedure TLazMemo.Append(const Value: String);', @_LapeMemo_Append);
    addProperty('TLazMemo', 'Lines', 'TLazStrings', @_LapeMemo_Lines_Read, @_LapeMemo_Lines_Write);
    addProperty('TLazMemo', 'HorzScrollBar', 'TLazControlScrollBar', @_LapeMemo_HorzScrollBar_Read, @_LapeMemo_HorzScrollBar_Write);
    addProperty('TLazMemo', 'VertScrollBar', 'TLazControlScrollBar', @_LapeMemo_VertScrollBar_Read, @_LapeMemo_VertScrollBar_Write);
    addProperty('TLazMemo', 'ScrollBars', 'ELazScrollStyle', @_LapeMemo_ScrollBars_Read, @_LapeMemo_ScrollBars_Write);
    addProperty('TLazMemo', 'WantReturns', 'Boolean', @_LapeMemo_WantReturns_Read, @_LapeMemo_WantReturns_Write);
    addProperty('TLazMemo', 'WantTabs', 'Boolean', @_LapeMemo_WantTabs_Read, @_LapeMemo_WantTabs_Write);
    addProperty('TLazMemo', 'WordWrap', 'Boolean', @_LapeMemo_WordWrap_Read, @_LapeMemo_WordWrap_Write);

    addClass('TLazButton', 'TLazWinControl', TButton);
    addClassConstructor('TLazButton', '(TheOwner: TLazComponent)', @_LapeButton_Create);
    addGlobalFunc('procedure TLazButton.Click;', @_LapeButton_Click);
    addProperty('TLazButton', 'OnMouseDown', 'TLazMouseEvent', @_LapeButton_OnMouseDown_Read, @_LapeButton_OnMouseDown_Write);
    addProperty('TLazButton', 'OnMouseEnter', 'TLazNotifyEvent', @_LapeButton_OnMouseEnter_Read, @_LapeButton_OnMouseEnter_Write);
    addProperty('TLazButton', 'OnMouseLeave', 'TLazNotifyEvent', @_LapeButton_OnMouseLeave_Read, @_LapeButton_OnMouseLeave_Write);
    addProperty('TLazButton', 'OnMouseMove', 'TLazMouseMoveEvent', @_LapeButton_OnMouseMove_Read, @_LapeButton_OnMouseMove_Write);
    addProperty('TLazButton', 'OnMouseUp', 'TLazMouseEvent', @_LapeButton_OnMouseUp_Read, @_LapeButton_OnMouseUp_Write);

    addClass('TLazCustomCheckBox', 'TLazWinControl', TCustomCheckBox);
    addClassConstructor('TLazCustomCheckBox', '(TheOwner: TLazComponent)', @_LapeCustomCheckBox_Create);
    addProperty('TLazCustomCheckBox', 'AllowGrayed', 'Boolean', @_LapeCustomCheckBox_AllowGrayed_Read, @_LapeCustomCheckBox_AllowGrayed_Write);
    addProperty('TLazCustomCheckBox', 'State', 'ELazCheckBoxState', @_LapeCustomCheckBox_State_Read, @_LapeCustomCheckBox_State_Write);
    addProperty('TLazCustomCheckBox', 'OnChange', 'TLazNotifyEvent', @_LapeCustomCheckBox_OnChange_Read, @_LapeCustomCheckBox_OnChange_Write);

    addClass('TLazCheckBox', 'TLazCustomCheckBox', TCheckBox);
    addClassConstructor('TLazCheckBox', '(TheOwner: TLazComponent)', @_LapeCheckBox_Create);

    addClass('TLazRadioButton', 'TLazCustomCheckBox', TRadioButton);
    addClassConstructor('TLazRadioButton', '(AOwner: TLazComponent)', @_LapeRadioButton_Create);

    addClass('TLazLabel', 'TLazGraphicControl', TLabel);
    addClassConstructor('TLazLabel', '(TheOwner: TLazComponent)', @_LapeLabel_Create);
    addGlobalFunc('function TLazLabel.AdjustFontForOptimalFill: Boolean;', @_LapeLabel_AdjustFontForOptimalFill);
    addProperty('TLazLabel', 'Alignment', 'ELazAlignment', @_LapeLabel_Alignment_Read, @_LapeLabel_Alignment_Write);
    addProperty('TLazLabel', 'Layout', 'ELazTextLayout', @_LapeLabel_Layout_Read, @_LapeLabel_Layout_Write);
    addProperty('TLazLabel', 'Transparent', 'Boolean', @_LapeLabel_Transparent_Read, @_LapeLabel_Transparent_Write);
    addProperty('TLazLabel', 'WordWrap', 'Boolean', @_LapeLabel_WordWrap_Read, @_LapeLabel_WordWrap_Write);
    addProperty('TLazLabel', 'OptimalFill', 'Boolean', @_LapeLabel_OptimalFill_Read, @_LapeLabel_OptimalFill_Write);
    addProperty('TLazLabel', 'OnMouseEnter', 'TLazNotifyEvent', @_LapeLabel_OnMouseEnter_Read, @_LapeLabel_OnMouseEnter_Write);
    addProperty('TLazLabel', 'OnMouseLeave', 'TLazNotifyEvent', @_LapeLabel_OnMouseLeave_Read, @_LapeLabel_OnMouseLeave_Write);
    addProperty('TLazLabel', 'OnMouseMove', 'TLazMouseMoveEvent', @_LapeLabel_OnMouseMove_Read, @_LapeLabel_OnMouseMove_Write);
    addProperty('TLazLabel', 'OnMouseDown', 'TLazMouseEvent', @_LapeLabel_OnMouseDown_Read, @_LapeLabel_OnMouseDown_Write);
    addProperty('TLazLabel', 'OnMouseUp', 'TLazMouseEvent', @_LapeLabel_OnMouseUp_Read, @_LapeLabel_OnMouseUp_Write);

    addClass('TLazSpeedButton', 'TLazGraphicControl', TSpeedButton);
    addClassConstructor('TLazSpeedButton', '(AOwner: TLazComponent)', @_LapeSpeedButton_Create);
    addProperty('TLazSpeedButton', 'OnMouseEnter', 'TLazNotifyEvent', @_LapeSpeedButton_OnMouseEnter_Read, @_LapeSpeedButton_OnMouseEnter_Write);
    addProperty('TLazSpeedButton', 'OnMouseLeave', 'TLazNotifyEvent', @_LapeSpeedButton_OnMouseLeave_Read, @_LapeSpeedButton_OnMouseLeave_Write);
    addProperty('TLazSpeedButton', 'OnMouseMove', 'TLazMouseMoveEvent', @_LapeSpeedButton_OnMouseMove_Read, @_LapeSpeedButton_OnMouseMove_Write);
    addProperty('TLazSpeedButton', 'OnMouseDown', 'TLazMouseEvent', @_LapeSpeedButton_OnMouseDown_Read, @_LapeSpeedButton_OnMouseDown_Write);
    addProperty('TLazSpeedButton', 'OnMouseUp', 'TLazMouseEvent', @_LapeSpeedButton_OnMouseUp_Read, @_LapeSpeedButton_OnMouseUp_Write);
    addProperty('TLazSpeedButton', 'OnPaint', 'TLazNotifyEvent', @_LapeSpeedButton_OnPaint_Read, @_LapeSpeedButton_OnPaint_Write);
    addProperty('TLazSpeedButton', 'Glyph', 'TLazBitmap', @_LapeSpeedButton_Glyph_Read, @_LapeSpeedButton_Glyph_Write);
    addProperty('TLazSpeedButton', 'Down', 'Boolean', @_LapeSpeedButton_Down_Read, @_LapeSpeedButton_Down_Write);
    addProperty('TLazSpeedButton', 'Flat', 'Boolean', @_LapeSpeedButton_Flat_Read, @_LapeSpeedButton_Flat_Write);
    addProperty('TLazSpeedButton', 'Layout', 'ELazButtonLayout', @_LapeSpeedButton_Layout_Read, @_LapeSpeedButton_Layout_Write);
    addProperty('TLazSpeedButton', 'Margin', 'Integer', @_LapeSpeedButton_Margin_Read, @_LapeSpeedButton_Margin_Write);
    addProperty('TLazSpeedButton', 'ShowCaption', 'Boolean', @_LapeSpeedButton_ShowCaption_Read, @_LapeSpeedButton_ShowCaption_Write);
    addProperty('TLazSpeedButton', 'Spacing', 'Integer', @_LapeSpeedButton_Spacing_Read, @_LapeSpeedButton_Spacing_Write);
    addProperty('TLazSpeedButton', 'Transparent', 'Boolean', @_LapeSpeedButton_Transparent_Read, @_LapeSpeedButton_Transparent_Write);
  end;
end;

end.

