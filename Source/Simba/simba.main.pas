{
	This file is part of the Mufasa Macro Library (MML)
	Copyright (c) 2009-2012 by Raymond van Venetië and Merlijn Wajer

    MML is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    MML is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with MML.  If not, see <http://www.gnu.org/licenses/>.

	See the file COPYING, included in this distribution,
	for details about the copyright.

    Simba: GUI for the Mufasa Macro Library
}
unit simba.main;

{$mode objfpc}{$H+}
{$i simba.inc}

interface

uses
  classes, sysutils, fileutil, AnchorDockPanel, lresources, forms, controls, graphics, dialogs,
  stdctrls, menus, comctrls, extctrls, buttons, imglist,
  simba.windowselector, simba.scripttab, simba.oswindow, castaliapaslextypes;

const
  IMAGE_COMPILE             = 0;
  IMAGE_PACKAGE             = 1;
  IMAGE_COPY                = 2;
  IMAGE_CUT                 = 3;
  IMAGE_OPEN                = 4;
  IMAGE_PASTE               = 5;
  IMAGE_SAVE                = 6;
  IMAGE_TRASH               = 7;
  IMAGE_CLOSE               = 8;
  IMAGE_CLOSE_ALL           = 9;
  IMAGE_POWER               = 10;
  IMAGE_NEW_FILE            = 11;
  IMAGE_PAUSE               = 12;
  IMAGE_REDO                = 13;
  IMAGE_PLAY                = 14;
  IMAGE_SAVE_ALL            = 15;
  IMAGE_STOP                = 16;
  IMAGE_UNDO                = 17;
  IMAGE_SEARCH              = 18;
  IMAGE_COLOR_PICKER        = 19;
  IMAGE_SELECT              = 20;
  IMAGE_GEAR                = 21;
  IMAGE_OPEN_RECENT         = 22;
  IMAGE_PACKAGE_NOTIFCATION = 23;
  IMAGE_WRITE_BUG           = 24;
  IMAGE_MINUS               = 25;
  IMAGE_PLUS                = 26;
  IMAGE_DIRECTORY           = 27;
  IMAGE_SIMBA               = 28;
  IMAGE_BOOK                = 29;
  IMAGE_FILE                = 30;
  IMAGE_TYPE                = 31;
  IMAGE_FUNCTION            = 32;
  IMAGE_PROCEDURE           = 33;
  IMAGE_GITHUB              = 34;
  IMAGE_CONSTANT            = 35;
  IMAGE_VARIABLE            = 36;

type
  TSimbaForm = class(TForm)
    DockPanel: TAnchorDockPanel;
    Images: TImageList;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem7: TMenuItem;
    TrayPopupExit: TMenuItem;
    MenuItemDebugger: TMenuItem;
    MenuItemRunWithDebugging: TMenuItem;
    MenuItemFormatScript: TMenuItem;
    MenuItemAssociateScripts: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItemEditor: TMenuItem;
    MenuItemReplace: TMenuItem;
    MenuItemConsole: TMenuItem;
    MenuItemTrayIcon: TMenuItem;
    MenuItem4: TMenuItem;
    MainMenu: TMainMenu;
    MenuItemDTMEditor: TMenuItem;
    MenuEdit: TMenuItem;
    MenuFile: TMenuItem;
    MenuHelp: TMenuItem;
    MenuItemLockLayout: TMenuItem;
    MenuItemOutput: TMenuItem;
    MenuItemResetLayout: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItemAbout: TMenuItem;
    MenuItemACA: TMenuItem;
    MenuItemBitmapConv: TMenuItem;
    MenuItemCloseTab: TMenuItem;
    MenuItemCloseTabs: TMenuItem;
    MenuItemColourHistory: TMenuItem;
    MenuItemCompile: TMenuItem;
    MenuItemCopy: TMenuItem;
    MenuItemCut: TMenuItem;
    MenuItemDebugImage: TMenuItem;
    MenuItemDivider10: TMenuItem;
    MenuItemDivider11: TMenuItem;
    MenuItemDivider14: TMenuItem;
    MenuItemDivider2: TMenuItem;
    MenuItemDivider3: TMenuItem;
    MenuItemDivider4: TMenuItem;
    MenuItemDivider5: TMenuItem;
    MenuItemDivider6: TMenuItem;
    MenuItemExportHTML: TMenuItem;
    MenuItemFileBrowser: TMenuItem;
    MenuItemFind: TMenuItem;
    MenuItemFindNext: TMenuItem;
    MenuItemFindPrev: TMenuItem;
    MenuItemFunctionList: TMenuItem;
    MenuItemGoto: TMenuItem;
    MenuItemMainExit: TMenuItem;
    MenuItemNew: TMenuItem;
    MenuItemNotes: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemOpenRecent: TMenuItem;
    MenuItemPaste: TMenuItem;
    MenuItemPause: TMenuItem;
    MenuItemRedo: TMenuItem;
    MenuItemReportBug: TMenuItem;
    MenuItemRun: TMenuItem;
    MenuItemSave: TMenuItem;
    MenuItemSaveAll: TMenuItem;
    MenuItemSaveAs: TMenuItem;
    MenuItemSaveAsDefault: TMenuItem;
    MenuItemScript: TMenuItem;
    MenuItemSelectAll: TMenuItem;
    MenuItemSettings: TMenuItem;
    MenuItemStop: TMenuItem;
    MenuItemUndo: TMenuItem;
    MenuTools: TMenuItem;
    MenuView: TMenuItem;
    TrayPopup: TPopupMenu;
    ScriptProcessorTimer: TTimer;
    ClearOutputButton: TToolButton;
    CompileButton: TToolButton;
    NewButton: TToolButton;
    OpenButton: TToolButton;
    PauseButton: TToolButton;
    ColorPickerButton: TToolButton;
    RunButton: TToolButton;
    SaveButton: TToolButton;
    SaveAllButton: TToolButton;
    SelectTargetButton: TToolButton;
    StopButton: TToolButton;
    ToolBar: TToolBar;
    ButtonSeperator1: TToolButton;
    ButtonSeperator5: TToolButton;
    ButtonSeperator3: TToolButton;
    ButtonSeperator2: TToolButton;
    ButtonSeperator4: TToolButton;
    PackageButton: TToolButton;
    TrayIcon: TTrayIcon;

    procedure DoTrayPopupExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItemDebuggerClick(Sender: TObject);
    procedure MenuItemFormatScriptClick(Sender: TObject);
    procedure MenuItemAssociateScriptsClick(Sender: TObject);
    procedure MenuNewTemplateClick(Sender: TObject);
    procedure MenuViewClick(Sender: TObject);
    procedure RecentFileItemsClick(Sender: TObject);
    procedure MenuClearOutputClick(Sender: TObject);
    procedure MenuFileClick(Sender: TObject);
    procedure MenuSaveAsDefaultClick(Sender: TObject);
    procedure MenuCloseAllTabsClick(Sender: TObject);
    procedure MenuCloseTabClick(Sender: TObject);
    procedure MenuCopyClick(Sender: TObject);
    procedure MenuCutClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuGotoClick(Sender: TObject);
    procedure MenuNewClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuFindClick(Sender: TObject);
    procedure MenuItemFindNextClick(Sender: TObject);
    procedure MenuItemFindPrevClick(Sender: TObject);
    procedure MenuPasteClick(Sender: TObject);
    procedure MenuRedoClick(Sender: TObject);
    procedure MenuSaveClick(Sender: TObject);
    procedure MenuReplaceClick(Sender: TObject);
    procedure MenuSelectAllClick(Sender: TObject);
    procedure MenuUndoClick(Sender: TObject);
    procedure DoResetLayoutClick(Sender: TObject);
    procedure MenuItemConsoleClick(Sender: TObject);
    procedure MenuItemLockLayoutClick(Sender: TObject);
    procedure MenuItemTrayIconClick(Sender: TObject);
    procedure PackageButtonClick(Sender: TObject);
    procedure SaveAllButtonClick(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
    procedure DoMenuItemDTMEditorClick(Sender: TObject);
    procedure HandleRunningScripts(Sender: TObject);
    procedure MenuItemBitmapConvClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MenuEditClick(Sender: TObject);
    procedure MenuItemCloseTabsClick(Sender: TObject);
    procedure MenuItemExportHTMLClick(Sender: TObject);
    procedure MenuItemReportBugClick(Sender: TObject);
    procedure MenuItemSettingsClick(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure ButtonPickClick(Sender: TObject);
    procedure ButtonSelectorDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoMenuItemACAClick(Sender: TObject);
    procedure DoChangeScriptState(Sender: TObject);
  protected
    FWindowSelection: TOSWindow;
    FProcessSelection: UInt32;
    FExceptionMessage: TStringList;
    FDockingReset: Boolean;

    procedure DoPrintDTM(constref DTM: String);
    procedure DoExceptionHandler(Sender: TObject; E: Exception);
    procedure DoScreenFormCreate(Sender: TObject);
    procedure DoScreenFormAdded(Sender: TObject; Form: TCustomForm);

    procedure HandleException;

    procedure SetEnabled(Value: Boolean); override;
    procedure SetTitle(Value: String);
  public
    property WindowSelection: TOSWindow read FWindowSelection;
    property ProcessSelection: UInt32 read FProcessSelection;
    property Title: String write SetTitle;

    procedure AddRecentFile(FileName: String);

    procedure SetupDocking;

    procedure CodeTools_Setup;
    procedure CodeTools_OnMessage(Sender: TObject; const Typ: TMessageEventType; const Message: String; X, Y: Integer);
    procedure CodeTools_OnLoadLibrary(Sender: TObject; FileName: String; var Contents: String);

    function CodeTools_OnFindInclude(Sender: TObject; var FileName: String): Boolean;
    function CodeTools_OnFindLibrary(Sender: TObject; var FileName: String): Boolean;

    procedure Settings_Setup;
    procedure Settings_CustomToolbarSize_Changed(Value: Int64);
    procedure Settings_CustomFontSize_Changed(Value: Int64);
    procedure Settings_LayoutLocked_Changed(Value: Boolean);
    procedure Settings_ConsoleVisible_Changed(Value: Boolean);
    procedure Settings_TrayIconVisible_Changed(Value: Boolean);

    procedure Setup(Data: PtrInt);
  end;

var
  SimbaForm: TSimbaForm;

implementation

uses
  lclintf, synexporthtml, anchordocking, simba.script_dump, simba.openssl,
  simba.mufasatypes, simba.process, simba.settings, simba.scripttemplateform,
  simba.files, simba.codeparser, simba.codeinsight,
  simba.debugimage, simba.bitmapconv, simba.colorpicker_historyform, simba.aca,
  simba.dtmeditor, simba.scriptinstance, simba.package_form, simba.aboutform,
  simba.functionlistform, simba.scripttabsform, simba.debugform, simba.filebrowserform,
  simba.notesform, simba.settingsform, simba.colorpicker, simba.ci_includecache,
  simba.highlighter, simba.scriptformatter, simba.dockinghelpers, simba.misc
  {$IFDEF WINDOWS},
  windows, shellapi
  {$ENDIF};

procedure TSimbaForm.DoExceptionHandler(Sender: TObject; E: Exception);
var
  I: Integer;
  Frames: PPointer;
begin
  if (FExceptionMessage <> nil) then
    Exit;

  FExceptionMessage := TStringList.Create();
  FExceptionMessage.Add('');
  FExceptionMessage.Add('Simba ' + IntToStr(SIMBA_VERSION) + ' encountered an unhandled exception.');
  FExceptionMessage.Add('');

  if (E <> nil) then
  begin
    FExceptionMessage.Add('Exception class: ' + E.ClassName);
    FExceptionMessage.Add('Exception message: ' + E.Message);
  end else
    FExceptionMessage.Add('Exception: nil');

  FExceptionMessage.Add(BackTraceStrFunc(ExceptAddr));

  Frames := ExceptFrames;
  for I := 0 to ExceptFrameCount - 1 do
    FExceptionMessage.Add(BackTraceStrFunc(Frames[I]));

  WriteLn(FExceptionMessage.Text);

  TThread.Synchronize(TThread.CurrentThread, @HandleException);
end;

// Used for:
//  - Set custom font size for forms created at runtime
//  - Change menu shortcuts to use command key rather than control on macOS
procedure TSimbaForm.DoScreenFormCreate(Sender: TObject);

  procedure ControlToCommandKey(Menu: TObject);
  var
    Item: TMenuItem;
    I: Int32;
    Key: UInt16;
    Shift: TShiftState;
  begin
    Item := nil;

    if (Menu is TMenu) then
      Item := TMenu(Menu).Items
    else
    if (Menu is TMenuItem) then
      Item := TMenuItem(Menu);

    if (Item <> nil) then
    begin
      ShortCutToKey(Item.ShortCut, Key, Shift);
      if (ssCtrl in Shift) then
        Item.ShortCut := ShortCut(Key, Shift - [ssCtrl] + [ssMeta]);

      for I := 0 to Item.Count - 1 do
        ControlToCommandKey(Item.Items[I]);
    end;
  end;

{$IFDEF DARWIN}
var
  I: Int32;
{$ENDIF}
begin
  with Sender as TCustomForm do
  begin
    {$IFDEF DARWIN}
    for I := 0 to ComponentCount - 1 do
      if Components[I] is TMenu then
        ControlToCommandKey(Components[I]);
    {$ENDIF}

    if Self.Visible then
      Font.Size := Self.Font.Size;
  end;
end;

// Above
procedure TSimbaForm.DoScreenFormAdded(Sender: TObject; Form: TCustomForm);
begin
  Form.AddHandlerCreate(@DoScreenFormCreate);

  // Call on ourself
  DoScreenFormCreate(Self);
end;

procedure TSimbaForm.HandleException;
var
  FileName: String;
  I: Int32;
  Aborted: Boolean;
begin
  for I := 1 to 100 do
  begin
    FileName := GetDataPath() + Format('crash-log-%d.txt', [I]);
    if not FileExists(FileName) then
      Break;
  end;

  FExceptionMessage.SaveToFile(FileName);

  if MessageDlg('Something went wrong in Simba. If you press OK, Simba will try to save your scripts before closing. (Recommended) ' +
                'See "' + ExtractRelativePath(ExtractFileDir(Application.Location), FileName) + '" for more information.', mtError, mbOKCancel, 0) = mrOK then
  begin
    SimbaScriptTabsForm.RemoveAllTabs(Aborted);
  end;

  Halt(1); // Calls finalization sections
end;

procedure TSimbaForm.CodeTools_OnMessage(Sender: TObject; const Typ: TMessageEventType; const Message: String; X, Y: Integer);
var
  Parser: TCodeParser absolute Sender;
begin
  if (Parser.Lexer.TokenPos + Parser.Lexer.TokenLen < Parser.Lexer.CaretPos) then
  begin
    SimbaDebugForm.Add('Simba''s code parser encountered an error. This could break code tools:');

    if Parser.Lexer.FileName <> '' then
      SimbaDebugForm.Add(Format('"%s" at line %d, column %d in file "%s"', [Message, Y + 1, X, Parser.Lexer.FileName]))
    else
      SimbaDebugForm.Add(Format('"%s" at line %d, column %d', [Message, Y + 1, X]));
  end;
end;

function TSimbaForm.CodeTools_OnFindInclude(Sender: TObject; var FileName: String): Boolean;
begin
  Result := FindFile(FileName, '', [ExtractFileDir(TCodeParser(Sender).Lexer.FileName), GetIncludePath(), GetSimbaPath()]);
end;

function TSimbaForm.CodeTools_OnFindLibrary(Sender: TObject; var FileName: String): Boolean;
begin
  Result := FindPlugin(FileName, [ExtractFileDir(TCodeParser(Sender).Lexer.FileName), GetPluginPath(), GetSimbaPath()]);
end;

procedure TSimbaForm.CodeTools_OnLoadLibrary(Sender: TObject; FileName: String; var Contents: String);
var
  Output, Dump: String;
begin
  Dump := SysUtils.GetTempFileName(GetDataPath(), '.dump');

  try
    SimbaProcess.RunCommandTimeout(Application.ExeName, ['--dump=' + FileName, Dump], Output, 3500);

    Contents := ReadFileToString(Dump);
    if (Contents = '') then
      raise Exception.Create('');
  except
    on E: Exception do
    begin
      SimbaDebugForm.Add('Error dumping ' + ExtractFileName(FileName));
      SimbaDebugForm.Add(Output);
    end;
  end;

  SysUtils.DeleteFile(Dump);
end;

procedure TSimbaForm.RecentFileItemsClick(Sender: TObject);
begin
  SimbaScriptTabsForm.Open(TMenuItem(Sender).Caption, True);
end;

procedure TSimbaForm.MenuItemAssociateScriptsClick(Sender: TObject);
{$IFDEF WINDOWS}

  function RunAsAdmin(const Handle: THandle; const Path, Params: String): Boolean;
  var
    info: TShellExecuteInfo;
  begin
    info := Default(TShellExecuteInfo);
    info.cbSize := SizeOf(TShellExecuteInfo);
    info.Wnd := Handle;
    info.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or SEE_MASK_NO_CONSOLE;
    info.lpVerb := 'runas';
    info.lpFile := PAnsiChar(Path);
    info.lpParameters := PAnsiChar(Params);
    info.nShow := SW_HIDE;

    Result := ShellExecuteExA(@info);
  end;

const
  Message = 'Would you like to accociate scripts with this Simba?' + LineEnding +
            'This means when opening a script, the script will be opened using this Simba executable.';
begin
  if MessageDlg('Associate?', Message, mtConfirmation, mbYesNo, 0) = mrYes then
    RunAsAdmin(Handle, Application.ExeName, '--associate');
end;
{$ELSE}
begin
end;
{$ENDIF}

procedure TSimbaForm.MenuNewTemplateClick(Sender: TObject);
begin
  SimbaScriptTemplateForm.ShowModal();
end;

procedure TSimbaForm.MenuViewClick(Sender: TObject);
begin
  MenuItemDebugger.Enabled := SimbaScriptTabsForm.CurrentTab.DebuggingForm <> nil;
end;

procedure TSimbaForm.MenuItemFormatScriptClick(Sender: TObject);
var
  Script: String;
begin
  try
    SimbaScriptTabsForm.CurrentEditor.BeginUndoBlock();

    try
      if SimbaScriptTabsForm.CurrentEditor.SelAvail then
      begin
        SimbaScriptTabsForm.CurrentEditor.SelText := FormatScript(SimbaScriptTabsForm.CurrentEditor.SelText);
      end else
      begin
        Script := SimbaScriptTabsForm.CurrentEditor.Text;

        SimbaScriptTabsForm.CurrentEditor.ClearAll();
        SimbaScriptTabsForm.CurrentEditor.InsertTextAtCaret(FormatScript(Script));
      end;
    finally
      SimbaScriptTabsForm.CurrentEditor.EndUndoBlock();
    end;
  except
    on E: Exception do
      ShowMessage('Exception while formatting script: ' + E.Message);
  end;
end;

procedure TSimbaForm.MenuItemAboutClick(Sender: TObject);
begin
  SimbaAboutForm.ShowModal();
end;

procedure TSimbaForm.DoTrayPopupExit(Sender: TObject);
begin
  Close();
end;

procedure TSimbaForm.FormCreate(Sender: TObject);
begin
  SimbaSettings := TSimbaSettings.Create();

  Application.OnException := @DoExceptionHandler;
  Screen.AddHandlerFormAdded(@DoScreenFormAdded);

  {$IFDEF WINDOWS}
  Self.MenuItemAssociateScripts.Enabled := True;
  {$ENDIF}

  Self.ToolBar.Images := TImageList.Create(ToolBar);
  Self.ToolBar.Images.Assign(Self.Images);
  Self.ToolBar.Images.Scaled := False;
end;

procedure TSimbaForm.FormDestroy(Sender: TObject);
begin
  SimbaSettings.GUI.TrayIconVisible.RemoveOnChangeHandler(@Settings_TrayIconVisible_Changed);
  SimbaSettings.GUI.ConsoleVisible.RemoveOnChangeHandler(@Settings_ConsoleVisible_Changed);
  SimbaSettings.GUI.LayoutLocked.RemoveOnChangeHandler(@Settings_LayoutLocked_Changed);
  SimbaSettings.GUI.CustomFontSize.RemoveOnChangeHandler(@Settings_CustomFontSize_Changed);
  SimbaSettings.GUI.CustomToolbarSize.RemoveOnChangeHandler(@Settings_CustomToolbarSize_Changed);
end;

procedure TSimbaForm.MenuItemDebuggerClick(Sender: TObject);
begin
  if (SimbaScriptTabsForm.CurrentTab.DebuggingForm <> nil) then
    SimbaScriptTabsForm.CurrentTab.DebuggingForm.ShowOnTop();
end;

procedure TSimbaForm.DoMenuItemACAClick(Sender: TObject);
begin
  TSimbaACAForm.Create(WindowSelection).ShowOnTop();
end;

procedure TSimbaForm.DoChangeScriptState(Sender: TObject);
begin
  try
    with SimbaScriptTabsForm.CurrentTab do
    begin
      // Already started
      if (ScriptInstance <> nil) then
      begin
        if (Sender = MenuItemRun) or (Sender = RunButton) then
          ScriptInstance.Resume()
        else
        if (Sender = MenuItemPause) or (Sender = PauseButton) then
          ScriptInstance.Pause()
        else
        if (Sender = MenuItemStop) or (Sender = StopButton) then
          ScriptInstance.Stop();
      end else
      // Start
      begin
        if (FileName <> '') then
          Save(FileName);

        ScriptInstance := TSimbaScriptInstance.Create();
        ScriptInstance.Target := Self.WindowSelection;

        if (FileName = '') then
        begin
          ScriptInstance.ScriptName := ScriptName;
          ScriptInstance.ScriptFile := CreateTempFile(Script, '.script');
        end else
          ScriptInstance.ScriptFile := FileName;

        if (Sender = MenuItemCompile) or (Sender = CompileButton) then
          ScriptInstance.Compile()
        else
        if (Sender = MenuItemRun) or (Sender = RunButton) then
          ScriptInstance.Run()
        else
        if (Sender = MenuItemRunWithDebugging) then
          ScriptInstance.Run(CreateDebuggingForm());
      end;
    end;
  except
    on E: Exception do
      MessageDlg('Exception while changing script state: ' + E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TSimbaForm.AddRecentFile(FileName: String);
var
  i: Int32;
  Item: TMenuItem;
begin
  if FileExists(FileName) then
  begin
    for i := 0 to MenuItemOpenRecent.Count - 1 do
      if SameFileName(MenuItemOpenRecent[i].Caption, FileName) then
      begin
        MenuItemOpenRecent.Delete(i);

        Break;
      end;

    while MenuItemOpenRecent.Count > 10 do
      MenuItemOpenRecent.Delete(MenuItemOpenRecent.Count - 1);

    Item := TMenuItem.Create(MenuItemOpenRecent);
    Item.OnClick := @RecentFileItemsClick;
    Item.Caption := FileName;

    MenuItemOpenRecent.Insert(0, Item);
  end;
end;

procedure TSimbaForm.MenuCloseTabClick(Sender: TObject);
var
  Aborted: Boolean;
begin
  SimbaScriptTabsForm.RemoveTab(SimbaScriptTabsForm.CurrentTab, Aborted);
end;

procedure TSimbaForm.MenuCopyClick(Sender: TObject);
begin
  if (SimbaScriptTabsForm.CurrentEditor <> nil) then
    SimbaScriptTabsForm.CurrentEditor.CopyToClipboard();
end;

procedure TSimbaForm.MenuCutClick(Sender: TObject);
begin
  if (SimbaScriptTabsForm.CurrentEditor <> nil) then
    SimbaScriptTabsForm.CurrentEditor.CutToClipboard();
end;

procedure TSimbaForm.MenuExitClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TSimbaForm.MenuGotoClick(Sender: TObject);
var
  Value: String;
begin
  if SimbaScriptTabsForm.CurrentEditor <> nil then
  begin
    Value := '';
    if InputQuery('Goto line', 'Goto line:', Value) and (StrToIntDef(Value, -1) > -1) then
      SimbaScriptTabsForm.CurrentEditor.TopLine := StrToInt(Value) - (SimbaScriptTabsForm.CurrentEditor.LinesInWindow div 2);
  end;
end;

procedure TSimbaForm.MenuClearOutputClick(Sender: TObject);
begin
  SimbaDebugForm.Clear();
end;

procedure TSimbaForm.MenuFileClick(Sender: TObject);
begin
  MenuItemSaveAll.Enabled := SimbaScriptTabsForm.TabCount > 1;
end;

procedure TSimbaForm.MenuSaveAsDefaultClick(Sender: TObject);
begin
  if MessageDlg('Save Default Script', 'Are you sure you want to overwrite the default script?', mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
  try
    SimbaScriptTabsForm.CurrentEditor.Lines.SaveToFile(SimbaSettings.Editor.DefaultScriptPath.Value);
  except
    on E: Exception do
      ShowMessage('Exception while saving default script: ' + E.Message);
  end;
end;

procedure TSimbaForm.MenuCloseAllTabsClick(Sender: TObject);
var
  Aborted: Boolean;
begin
  SimbaScriptTabsForm.RemoveAllTabs(Aborted);
end;

procedure TSimbaForm.MenuNewClick(Sender: TObject);
begin
  SimbaScriptTabsForm.AddTab();
end;

procedure TSimbaForm.DoPrintDTM(constref DTM: String);
begin
  SimbaDebugForm.Add('DTM := DTMFromString(' + #39 + DTM + #39 + ');');
end;

procedure TSimbaForm.DoMenuItemDTMEditorClick(Sender: TObject);
begin
  with TSimbaDTMEditorForm.Create(WindowSelection) do
  begin
    OnPrintDTM := @DoPrintDTM;
    ShowOnTop();
  end;
end;

procedure TSimbaForm.MenuOpenClick(Sender: TObject);
begin
  SimbaScriptTabsForm.Open();
end;

procedure TSimbaForm.MenuFindClick(Sender: TObject);
begin
  SimbaScriptTabsForm.Find();
end;

procedure TSimbaForm.MenuItemFindNextClick(Sender: TObject);
begin
  SimbaScriptTabsForm.FindNext();
end;

procedure TSimbaForm.MenuItemFindPrevClick(Sender: TObject);
begin
  SimbaScriptTabsForm.FindPrevious();
end;

procedure TSimbaForm.MenuReplaceClick(Sender: TObject);
begin
  SimbaScriptTabsForm.Replace();
end;

procedure TSimbaForm.MenuPasteClick(Sender: TObject);
begin
  if SimbaScriptTabsForm.CurrentEditor <> nil then
    SimbaScriptTabsForm.CurrentEditor.PasteFromClipboard();
end;

procedure TSimbaForm.MenuRedoClick(Sender: TObject);
begin
  if SimbaScriptTabsForm.CurrentEditor <> nil then
    SimbaScriptTabsForm.CurrentEditor.Redo();
end;

procedure TSimbaForm.MenuSaveClick(Sender: TObject);
begin
  if SimbaScriptTabsForm.CurrentTab <> nil then
  begin
    if SimbaScriptTabsForm.CurrentTab.FileName = '' then
      SimbaScriptTabsForm.CurrentTab.SaveAs()
    else
      SimbaScriptTabsForm.CurrentTab.Save(SimbaScriptTabsForm.CurrentTab.FileName);
  end;
end;

procedure TSimbaForm.MenuSelectAllClick(Sender: TObject);
begin
  if SimbaScriptTabsForm.CurrentEditor <> nil then
    SimbaScriptTabsForm.CurrentEditor.SelectAll();
end;

procedure TSimbaForm.MenuUndoClick(Sender: TObject);
begin
  if SimbaScriptTabsForm.CurrentEditor <> nil then
    SimbaScriptTabsForm.CurrentEditor.Undo();
end;

procedure TSimbaForm.DoResetLayoutClick(Sender: TObject);
begin
  if MessageDlg('Reset to default layout? This will happen when Simba is next restarted.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    FDockingReset := True
  else
    FDockingReset := False;
end;

procedure TSimbaForm.MenuItemConsoleClick(Sender: TObject);
begin
  SimbaSettings.GUI.ConsoleVisible.Value := not SimbaSettings.GUI.ConsoleVisible.Value;
end;

procedure TSimbaForm.MenuItemLockLayoutClick(Sender: TObject);
begin
  SimbaSettings.GUI.LayoutLocked.Value := not SimbaSettings.GUI.LayoutLocked.Value;
end;

procedure TSimbaForm.MenuItemTrayIconClick(Sender: TObject);
begin
  SimbaSettings.GUI.TrayIconVisible.Value := not SimbaSettings.GUI.TrayIconVisible.Value;
end;

procedure TSimbaForm.PackageButtonClick(Sender: TObject);
begin
  SimbaPackageForm.Show();
end;

procedure TSimbaForm.SaveAllButtonClick(Sender: TObject);
var
  I: Int32;
begin
  for I := SimbaScriptTabsForm.TabCount - 1 downto 0 do
    if SimbaScriptTabsForm.Tabs[I].ScriptChanged then
    begin
      if (SimbaScriptTabsForm.Tabs[I].FileName = '') then
      begin
        SimbaScriptTabsForm.Tabs[I].Show();
        SimbaScriptTabsForm.Tabs[I].SaveAs();
      end else
        SimbaScriptTabsForm.Tabs[I].Save(SimbaScriptTabsForm.Tabs[I].FileName);
    end;
end;

procedure TSimbaForm.MenuSaveAsClick(Sender: TObject);
begin
  if (SimbaScriptTabsForm.CurrentTab <> nil) then
    SimbaScriptTabsForm.CurrentTab.SaveAs();
end;

procedure TSimbaForm.HandleRunningScripts(Sender: TObject);
var
  I: Int32;
begin
  for I := 0 to SimbaScriptTabsForm.TabCount - 1 do
    with SimbaScriptTabsForm.Tabs[I] do
    begin
      if (ScriptInstance <> nil) and ScriptInstance.IsFinished then
      begin
        ScriptInstance.Free();
        ScriptInstance := nil;
      end;

      // Update buttons if current tab
      if SimbaScriptTabsForm.Tabs[I] <> SimbaScriptTabsForm.CurrentTab then
        Continue;

      if (ScriptInstance <> nil) then
      begin
        if ScriptInstance.IsStopping then
        begin
          RunButton.Enabled := False;
          PauseButton.Enabled := False;
          CompileButton.Enabled := False;

          StopButton.Enabled := True;
          StopButton.ImageIndex := IMAGE_POWER;

          SimbaScriptTabsForm.StatusPanelState.Caption := 'Stopping';
        end;

        if ScriptInstance.IsPaused then
        begin
          RunButton.Enabled := True;
          PauseButton.Enabled := False;
          CompileButton.Enabled := True;

          StopButton.Enabled := True;
          StopButton.ImageIndex := IMAGE_STOP;

          SimbaScriptTabsForm.StatusPanelState.Caption := 'Paused';
        end;

        if ScriptInstance.IsRunning then
        begin
          RunButton.Enabled := False;
          PauseButton.Enabled := True;
          CompileButton.Enabled := False;

          StopButton.Enabled := True;
          StopButton.ImageIndex := IMAGE_STOP;

          SimbaScriptTabsForm.StatusPanelState.Caption := TimeStamp(ScriptInstance.TimeRunning);
        end;
      end else
      begin
        RunButton.Enabled := True;
        PauseButton.Enabled := False;
        CompileButton.Enabled := True;

        StopButton.Enabled := False;
        StopButton.ImageIndex := IMAGE_STOP;

        SimbaScriptTabsForm.StatusPanelState.Caption := 'Stopped';
      end;
    end;
end;

procedure TSimbaForm.MenuItemBitmapConvClick(Sender: TObject);
begin
  SimbaBitmapConversionForm.Show();
end;

procedure TSimbaForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  i: Int32;
  Aborted: Boolean;
begin
  SimbaScriptTabsForm.RemoveAllTabs(Aborted);

  if Aborted then
    CloseAction := caNone
  else
  begin
    CloseAction := caFree;

    if FDockingReset then
    begin
      SimbaSettings.GUI.Layout.Value := '';
      SimbaSettings.GUI.LayoutLocked.Value := False;
    end else
    if (WindowState <> wsMinimized) then
      SimbaSettings.GUI.Layout.Value := DockMaster.SaveLayout();

    Visible := False;
  end;
end;

procedure TSimbaForm.Settings_Setup;
var
  RecentFile: String;
begin
  for RecentFile in SimbaSettings.GUI.RecentFiles.Value.Split([',']) do
    AddRecentFile(RecentFile);

  SimbaSettings.GUI.TrayIconVisible.AddOnChangeHandler(@Settings_TrayIconVisible_Changed).Changed();
  SimbaSettings.GUI.ConsoleVisible.AddOnChangeHandler(@Settings_ConsoleVisible_Changed).Changed();
  SimbaSettings.GUI.LayoutLocked.AddOnChangeHandler(@Settings_LayoutLocked_Changed).Changed();
  SimbaSettings.GUI.CustomFontSize.AddOnChangeHandler(@Settings_CustomFontSize_Changed).Changed();
  SimbaSettings.GUI.CustomToolbarSize.AddOnChangeHandler(@Settings_CustomToolbarSize_Changed).Changed();
end;

procedure TSimbaForm.Settings_TrayIconVisible_Changed(Value: Boolean);
begin
  MenuItemTrayIcon.Checked := Value;

  TrayIcon.Visible := Value;
end;

procedure TSimbaForm.Settings_CustomToolbarSize_Changed(Value: Int64);
begin
  ToolBar.ImagesWidth := Value;

  ToolBar.ButtonWidth  := Value + Scale96ToScreen(8);
  ToolBar.ButtonHeight := Value + Scale96ToScreen(8);
end;

procedure TSimbaForm.Settings_CustomFontSize_Changed(Value: Int64);
var
  i: Int32;
begin
  if (Value = 0) then
    Exit;

  for i := 0 to Screen.CustomFormCount - 1 do
    Screen.CustomForms[i].Font.Size := Value;
  Screen.HintFont.Size := Value;
end;

procedure TSimbaForm.Settings_LayoutLocked_Changed(Value: Boolean);
begin
  MenuItemLockLayout.Checked := Value;

  DockMaster.ShowHeader := not Value;
  DockMaster.AllowDragging := not Value;
end;

procedure TSimbaForm.Settings_ConsoleVisible_Changed(Value: Boolean);
var
  PID: UInt32;
begin
  MenuItemConsole.Checked := Value;

  {$IFDEF WINDOWS}
  GetWindowThreadProcessId(GetConsoleWindow(), PID);

  if (PID = GetCurrentProcessID()) then
  begin
    case Value of
      True: ShowWindow(GetConsoleWindow(), SW_SHOWNORMAL);
      False: ShowWindow(GetConsoleWindow(), SW_HIDE);
    end;
  end;
  {$ENDIF}
end;

procedure TSimbaForm.CodeTools_Setup;
var
  Parser: TCodeInsight_Include;
  I: Int32;
  Dump: TStringList;
begin
  Dump := nil;

  try
    Dump := DumpCompiler();

    for I := 0 to Dump.Count - 1 do
    begin
      Parser := TCodeInsight_Include.Create();
      Parser.OnMessage := @Self.CodeTools_OnMessage;
      Parser.Run(Dump.ValueFromIndex[I], Dump.Names[I]);

      if (Dump.Names[I] <> 'Classes') then
        TCodeInsight.AddFunctionListSection(Parser);

      TCodeInsight.AddBaseInclude(Parser);
    end;
  except
    on E: Exception do
      SimbaDebugForm.Add('Error dumping compiler: ' + E.Message);
  end;

  if (Dump <> nil) then
    Dump.Free();
end;

procedure TSimbaForm.Setup(Data: PtrInt);
var
  Directory: String;
begin
  // Create base directories
  for Directory in [GetDataPath(), GetOpenSSLBinaryPath(), GetPackagePath(), GetIncludePath(), GetFontPath(), GetScriptPath()] do
    CreateDir(Directory);

  if SimbaSettings.Environment.OpenSSLOnLaunch.Value then
    InitializeOpenSSL(True);

  // Command line
  if (Application.ParamCount > 0) then
  begin
    if (Application.ParamCount = 1) and FileExists(Application.Params[1]) then
      SimbaScriptTabsForm.Open(Application.Params[1])
    else
    if Application.HasOption('open') and FileExists(Application.Params[Application.ParamCount]) then
    begin
      SimbaScriptTabsForm.Open(Application.Params[Application.ParamCount]);

      if Application.HasOption('compile') then
        Self.CompileButton.Click();
      if Application.HasOption('run') then
        Self.RunButton.Click();
    end;
  end;

  CodeTools_Setup();
  SetupDocking();
  Settings_Setup();

  // First launch
  if SimbaSettings.Environment.FirstLaunch.Value then
  begin
    MenuItemAssociateScripts.Click();

    SimbaSettings.Environment.FirstLaunch.Value := False;
  end;

  Self.Enabled := True;
end;

procedure TSimbaForm.SetEnabled(Value: Boolean);
var
  i: Int32;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TTimer then
      TTimer(Components[i]).Enabled := Value;

  inherited SetEnabled(Value);
end;

procedure TSimbaForm.SetTitle(Value: String);
var
  Site: TAnchorDockHostSite;
  I: Int32;
begin
  Application.Title := Value;

  for I := 0 to DockMaster.ComponentCount - 1 do
  begin
    Site := TAnchorDockHostSite(DockMaster.Components[I]);
    if (Site is TAnchorDockHostSite) then
      Site.UpdateDockCaption();
  end;
end;

procedure TSimbaForm.MenuEditClick(Sender: TObject);
begin
  if SimbaScriptTabsForm.CurrentEditor <> nil then
    with SimbaScriptTabsForm.CurrentEditor do
    begin
      MenuItemCut.Enabled := SelText <> '';
      MenuItemCopy.Enabled := SelText <> '';
      MenuItemPaste.Enabled := SelText <> '';
    end;
end;

procedure TSimbaForm.MenuItemCloseTabsClick(Sender: TObject);
var
  Aborted: Boolean;
begin
  SimbaScriptTabsForm.RemoveAllTabs(Aborted);
end;

procedure TSimbaForm.MenuItemExportHTMLClick(Sender: TObject);
var
  SynExporterHTML: TSynExporterHTML;
begin
  SynExporterHTML := TSynExporterHTML.Create(nil);
  SynExporterHTML.Highlighter := TSynFreePascalSyn.Create(SynExporterHTML);
  SynExporterHTML.ExportAsText := True;

  with TSaveDialog.Create(nil) do
  try
    Filter := 'HTML Files (*.html;*.htm)|*.html;*.htm|All files(*.*)|*.*';
    Options := [ofOverwritePrompt, ofEnableSizing];
    DefaultExt := 'html';

    if Execute then
    begin
      SynExporterHTML.Title := 'Simba - ' + SimbaScriptTabsForm.CurrentTab.ScriptName;
      SynExporterHTML.ExportAll(SimbaScriptTabsForm.CurrentEditor.Lines);
      SynExporterHTML.SaveToFile(FileName);
    end;
  finally
    Free();
  end;

  SynExporterHTML.Free();
end;

procedure TSimbaForm.MenuItemReportBugClick(Sender: TObject);
begin
  OpenURL('https://github.com/MerlijnWajer/Simba/issues/new');
end;

procedure TSimbaForm.MenuItemSettingsClick(Sender: TObject);
begin
  SimbaSettingsForm.ShowModal();
end;

procedure TSimbaForm.TrayIconClick(Sender: TObject);
begin
  Self.ShowOnTop();
  if Self.CanSetFocus() then
    Self.SetFocus();
end;

procedure TSimbaForm.ButtonPickClick(Sender: TObject);
begin
  try
    with TSimbaColorPicker.Create(FWindowSelection) do
    try
      SimbaColorHistoryForm.AddColObj(TColourPickerObject.Create(Color, Point, ''), True);

      SimbaDebugForm.Add('Color picked: ' + IntToStr(Color) + ' at (' + IntToStr(Point.X) + ', ' + IntToStr(Point.Y) + ')');
    finally
      Free();
    end;

    MenuItemColourHistory.Checked := True;
    MenuItemColourHistory.OnClick(MenuItemColourHistory);
  except
    on E: Exception do
      ShowMessage('Exception while picking color: ' + E.Message + '(' + E.ClassName + ')');
  end;
end;

procedure TSimbaForm.ButtonSelectorDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  try
    with TSimbaWindowSelector.Create() do
    try
      SimbaDebugForm.Add('Window Selected: ' + IntToStr(Selected));
      SimbaDebugForm.Add(' - Dimensions: ' + IntToStr(Selected.GetBounds().Width - 1) + 'x' + IntToStr(Selected.GetBounds().Height - 1));
      SimbaDebugForm.Add(' - PID: ' + IntToStr(Selected.GetPID));

      if Selected.GetTitle() <> '' then
        SimbaDebugForm.Add(' - Title: ' + Selected.GetTitle());
      if Selected.GetClassName <> '' then
        SimbaDebugForm.Add(' - ClassName: ' + Selected.GetClassName());

      FWindowSelection := Selected;
      FProcessSelection := Selected.GetPID();
    finally
      Free();
    end;
  except
    on E: Exception do
      ShowMessage('Exception while selecting window: ' + E.Message + '(' + E.ClassName + ')');
  end;
end;

procedure TSimbaForm.SetupDocking;
begin
  BeginFormUpdate();

  try
    DockMaster.BeginUpdate();
    DockMaster.SplitterWidth := 5;
    DockMaster.HeaderClass := TSimbaAnchorDockHeader;
    DockMaster.SplitterClass := TSimbaAnchorDockSplitter;
    DockMaster.SiteClass := TSimbaAnchorDockHostSite;
    DockMaster.HideHeaderCaptionFloatingControl := False;
    DockMaster.HeaderAlignTop := $FFFFFF;
    DockMaster.PageAreaInPercent := 0;
    DockMaster.HeaderHint := 'Use the mouse to drag and dock this window';
    DockMaster.MakeDockPanel(DockPanel, admrpChild);

    DockMaster.MakeDockable(SimbaScriptTabsForm, MenuItemEditor);
    DockMaster.MakeDockable(SimbaDebugForm, MenuItemOutput);
    DockMaster.MakeDockable(SimbaFileBrowserForm, MenuItemFileBrowser);
    DockMaster.MakeDockable(SimbaFunctionListForm, MenuItemFunctionList);
    DockMaster.MakeDockable(SimbaNotesForm, MenuItemNotes);
    DockMaster.MakeDockable(SimbaDebugImageForm, MenuItemDebugImage);
    DockMaster.MakeDockable(SimbaColorHistoryForm, MenuItemColourHistory);

    if (SimbaSettings.GUI.Layout.Value = '') then
    begin
      DockMaster.GetAnchorSite(SimbaFileBrowserForm).Width := 140;
      DockMaster.GetAnchorSite(SimbaFunctionListForm).Width := 140;
      DockMaster.GetAnchorSite(SimbaDebugForm).Height := 120;

      DockMaster.ManualDockPanel(DockMaster.GetAnchorSite(SimbaScriptTabsForm), DockPanel, alClient);
      DockMaster.ManualDockPanel(DockMaster.GetAnchorSite(SimbaDebugForm), DockPanel, alBottom);
      DockMaster.ManualDockPanel(DockMaster.GetAnchorSite(SimbaFunctionListForm), DockPanel, alLeft);
      DockMaster.ManualDockPanel(DockMaster.GetAnchorSite(SimbaFileBrowserForm), DockPanel, alRight);

      DockMaster.MakeVisible(SimbaScriptTabsForm, False);
      DockMaster.MakeVisible(SimbaDebugForm, False);
      DockMaster.MakeVisible(SimbaFunctionListForm, False);
      DockMaster.MakeVisible(SimbaFileBrowserForm, False);

      Width := 1250;
      Height := 850;
    end else
      DockMaster.LoadLayout(SimbaSettings.GUI.Layout.Value);
  finally
    DockMaster.EndUpdate();

    EndFormUpdate();
  end;

  if (SimbaSettings.GUI.Layout.Value = '') then
    Position := poScreenCenter;

  EnsureVisible();
end;

{$R *.lfm}

initialization
  Randomize();

  FormatSettings.DecimalSeparator := '.';

end.
