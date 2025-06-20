{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
}
unit simba.ide_tab;

{$i simba.inc}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, Dialogs, Process, SynEdit, SynEditTypes,
  simba.base, simba.ide_editor, simba.form_output, simba.component_tabcontrol, simba.vartype_windowhandle;

type
  TSimbaScriptTab = class;

  // main class which will run the script of a given tab.
  // Manages output etc.
  TSimbaScriptTabRunner = class(TComponent)
  protected
    FTab: TSimbaScriptTab;

    FErrorSet: Boolean;
    FError: record
      Message, FileName: String;
      Line, Col: Integer;
    end;

    FProcess: TProcess;

    FStartTime: UInt64;

    FOutputThread: TThread;

    FState: ESimbaScriptState;

    FScriptFile: String;
    FScript: String;
    FScriptTitle: String;

    procedure Start(Args: TStringArray);

    procedure ShowError;
    procedure ShowOutputBox;

    procedure DoOutputThread;
    procedure DoOutputThreadTerminated(Sender: TObject);

    function GetTimeRunning: UInt64;

    procedure SetState(Value: ESimbaScriptState);
  public
    property Script: String read FScript;
    property ScriptTitle: String read FScriptTitle;

    property Tab: TSimbaScriptTab read FTab;

    property Process: TProcess read FProcess;
    property State: ESimbaScriptState read FState write SetState;
    property TimeRunning: UInt64 read GetTimeRunning;

    // Start
    procedure Run(Args: TStringArray);
    procedure Compile(Args: TStringArray);

    // Change the running state
    procedure Resume;
    procedure Pause;
    procedure Stop;
    procedure Kill;

    procedure SetError(Message, FileName: String; Line, Col: Integer);

    constructor Create(ATab: TSimbaScriptTab); reintroduce;
    destructor Destroy; override;
  end;

  TSimbaScriptTab = class(TSimbaTab)
  protected
    FUID: Integer;
    FEditor: TSimbaEditor;
    FSavedText: String;
    FScriptFileName: String;
    FScriptTitle: String;

    FScriptRunner: TSimbaScriptTabRunner;

    FOutputBox: TSimbaOutputBox;

    procedure LoadDefaultScript;
    procedure FindDeclarationAtCaretASync(Data: PtrInt);

    // Keep output tab in sync
    procedure TextChanged; override;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function DoEditorGetFileName(Sender: TObject): String;
    procedure DoEditorModified(Sender: TObject);
    procedure DoEditorLinkClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoEditorStatusChanges(Sender: TObject; Changes: TSynStatusChanges);

    function GetScript: String;
    function GetScriptChanged: Boolean;
  public
    property UID: Integer read FUID;
    property OutputBox: TSimbaOutputBox read FOutputBox;

    property ScriptTitle: String read FScriptTitle;
    property ScriptFileName: String read FScriptFileName;

    property ScriptChanged: Boolean read GetScriptChanged;
    property Script: String read GetScript;
    property Editor: TSimbaEditor read FEditor;

    function SaveAsDialog: String;

    function Save(FileName: String): Boolean;
    function Load(FileName: String): Boolean;

    procedure Undo;
    procedure Redo;

    procedure GotoLine(Line: Integer);

    procedure FindDeclarationAtCaret;

    function IsActiveTab: Boolean;
    function CanClose: Boolean;

    function ScriptStateStr: String;
    function ScriptState: ESimbaScriptState;

    procedure Run(Target: TWindowHandle);
    procedure Compile;
    procedure Pause;
    procedure Stop;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  Forms,
  simba.fs, simba.settings, simba.ide_events,
  simba.form_main, simba.form_tabs, simba.env, simba.ide_showdeclaration, simba.threading,
  simba.ide_scriptcommunication, simba.datetime, simba.ide_editor_popupmenu, simba.vartype_string;

procedure TSimbaScriptTabRunner.DoOutputThread;
var
  ReadBuffer, RemainingBuffer: String;

  procedure EmptyProcessOutput;
  var
    Count: Integer;
  begin
    while (FProcess.Output.NumBytesAvailable > 0) do
    begin
      Count := FProcess.Output.Read(ReadBuffer[1], Length(ReadBuffer));
      if (Count > 0) then
        RemainingBuffer := FTab.OutputBox.Add(RemainingBuffer + Copy(ReadBuffer, 1, Count));
    end;
  end;

begin
  try
    SetLength(ReadBuffer, 8192);
    SetLength(RemainingBuffer, 0);

    while FProcess.Running do
    begin
      EmptyProcessOutput();

      Sleep(500);
    end;

    //DebugLn('Script process[%d] terminated. Exit code: %d', [FProcess.ProcessID, FProcess.ExitCode]);

    EmptyProcessOutput();
  except
    on E: Exception do
      DebugLn('Script process[%d] output thread crashed: %s', [FProcess.ProcessID, E.Message]);
  end;
end;

procedure TSimbaScriptTabRunner.DoOutputThreadTerminated(Sender: TObject);
begin
  CheckMainThread('TSimbaScriptTabRunner.DoOutputThreadTerminated');
  if FProcess.Running then
    FProcess.Terminate(0);

  if FErrorSet then
  begin
    ShowError();
    ShowOutputBox();
  end;

  Self.Free();
end;

function TSimbaScriptTabRunner.GetTimeRunning: UInt64;
begin
  if (FStartTime = 0) then
    Result := 0
  else
    Result := GetTickCount64() - FStartTime;
end;

procedure TSimbaScriptTabRunner.SetState(Value: ESimbaScriptState);
begin
  FState := Value;

  SimbaIDEEvents.Notify(SimbaIDEEvent.TAB_SCRIPTSTATE_CHANGE, FTab);
end;

procedure TSimbaScriptTabRunner.Start(Args: TStringArray);
begin
  FScriptFile := FTab.ScriptFileName;
  FScriptTitle := FTab.ScriptTitle;
  FScript := FTab.Script;

  FStartTime := GetTickCount64();

  FProcess.Parameters.Add('--simbacommunication=%s', [TSimbaScriptInstanceCommunication.Create(Self).ClientID]);
  if SimbaSettings.Compiler.ShowHints.Value then
    FProcess.Parameters.Add('--hints');

  FProcess.Parameters.AddStrings(Args);
  if (FScriptFile <> '') then
    FProcess.Parameters.Add(FScriptFile);
  FProcess.Execute();

  FOutputThread := RunInThread(@DoOutputThread);
  FOutputThread.OnTerminate := @DoOutputThreadTerminated;

  State := ESimbaScriptState.STATE_RUNNING;
end;

procedure TSimbaScriptTabRunner.ShowError;
begin
  // FError is in the script tab that ran the script
  if (FTab.ScriptFileName = FError.FileName) or ((FTab.ScriptFileName = '') and (FTab.ScriptTitle = FError.FileName)) then
  begin
    FTab.Show();
    FTab.Editor.FocusLine(FError.Line, FError.Col, $0000A5);
  end else
  // else, open the file and display.
  if SimbaTabsForm.Open(FError.FileName) then
    SimbaTabsForm.CurrentEditor.FocusLine(FError.Line, FError.Col, $0000A5);

  FTab.Editor.FocusLine(FError.Line, FError.Col, $0000A5);
end;

procedure TSimbaScriptTabRunner.ShowOutputBox;
begin
  FTab.OutputBox.MakeVisible();
end;

procedure TSimbaScriptTabRunner.Run(Args: TStringArray);
begin
  Start(Args + ['--run']);
end;

procedure TSimbaScriptTabRunner.Compile(Args: TStringArray);
begin
  Start(Args + ['--compile']);
end;

procedure TSimbaScriptTabRunner.Resume;
begin
  FState := ESimbaScriptState.STATE_RUNNING;
  FProcess.Input.Write(FState, SizeOf(Int32));
end;

procedure TSimbaScriptTabRunner.Pause;
begin
  FState := ESimbaScriptState.STATE_PAUSED;
  FProcess.Input.Write(FState, SizeOf(Int32));
end;

procedure TSimbaScriptTabRunner.Stop;
begin
  if (FState = ESimbaScriptState.STATE_STOP) then
    FProcess.Terminate(1001)
  else
  begin
    FState := ESimbaScriptState.STATE_STOP;
    FProcess.Input.Write(FState, SizeOf(Int32));
  end;
end;

constructor TSimbaScriptTabRunner.Create(ATab: TSimbaScriptTab);
begin
  inherited Create(ATab);

  FTab := ATab;
  FState := ESimbaScriptState.STATE_RUNNING;

  FProcess := TProcess.Create(Self);
  FProcess.PipeBufferSize := 16 * 1024;
  FProcess.CurrentDirectory := Application.Location;
  FProcess.Options := FProcess.Options + [poUsePipes, poStderrToOutPut, poDetached];
  FProcess.Executable := Application.ExeName;
end;

procedure TSimbaScriptTabRunner.Kill;
begin
  FProcess.Terminate(0);
end;

procedure TSimbaScriptTabRunner.SetError(Message, FileName: String; Line, Col: Integer);
begin
  FErrorSet := True;

  FError.Message := Message;
  FError.FileName := FileName;
  FError.Line := Line;
  FError.Col := Col;
end;

destructor TSimbaScriptTabRunner.Destroy;
begin
  State := ESimbaScriptState.STATE_NONE;

  inherited Destroy();
end;

var
  __UID: Integer = 0;

function TSimbaScriptTab.GetScript: String;
begin
  Result := FEditor.Text;
end;

function TSimbaScriptTab.GetScriptChanged: Boolean;
begin
  Result := FEditor.Text <> FSavedText;
end;

procedure TSimbaScriptTab.LoadDefaultScript;
begin
  case SimbaSettings.Editor.DefaultScriptType.Value of
    0: FEditor.Text := TSimbaFile.FileRead(SimbaSettings.Editor.DefaultScriptFile.Value);
    1: FEditor.Text := SimbaSettings.Editor.DefaultScript.Value;
  end;

  FEditor.MarkTextAsSaved();
end;

procedure TSimbaScriptTab.TextChanged;
begin
  inherited TextChanged();

  if Assigned(FOutputBox) then
    FOutputBox.TabTitle := Caption;
end;

procedure TSimbaScriptTab.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FScriptRunner) then
    FScriptRunner := nil;

  inherited Notification(AComponent, Operation);
end;

function TSimbaScriptTab.DoEditorGetFileName(Sender: TObject): String;
begin
  Result := FScriptFileName;
end;

procedure TSimbaScriptTab.FindDeclarationAtCaretASync(Data: PtrInt);
begin
  FindAndShowDeclaration(Script, ScriptFileName, Editor.GetCaretPos(True), Editor.GetExpressionEx(FEditor.CaretX, FEditor.CaretY));
end;

procedure TSimbaScriptTab.FindDeclarationAtCaret;
begin
  Application.QueueAsyncCall(@FindDeclarationAtCaretASync, 0); // queue the event to let synedit finishing painting
end;

procedure TSimbaScriptTab.DoEditorModified(Sender: TObject);
begin
  if ScriptChanged then
    Caption := '*' + FScriptTitle
  else
    Caption := FScriptTitle;

  SimbaIDEEvents.Notify(SimbaIDEEvent.TAB_MODIFIED, Self);
end;

procedure TSimbaScriptTab.DoEditorLinkClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FindDeclarationAtCaret();
end;

procedure TSimbaScriptTab.DoEditorStatusChanges(Sender: TObject; Changes: TSynStatusChanges);
begin
  SimbaIDEEvents.Notify(SimbaIDEEvent.TAB_CARETMOVED, Self);
end;

function TSimbaScriptTab.SaveAsDialog: String;
begin
  Result := '';

  with TSaveDialog.Create(Self) do
  try
    Filter := 'Simba Files|*.simba;*.pas;*.inc;|Any Files|*.*';
    Options := Options + [ofOverwritePrompt];
    InitialDir := ExtractFileDir(FScriptFileName);
    if (InitialDir = '') then
      InitialDir := SimbaEnv.ScriptsPath;

    if Execute() then
    begin
      if (ExtractFileExt(FileName) = '') then
        FileName := ChangeFileExt(FileName, '.simba');

      Result := FileName;
    end;
  finally
    Free();
  end;
end;

function TSimbaScriptTab.Save(FileName: String): Boolean;
begin
  Result := False;

  if (FileName = '') then
  begin
    FileName := SaveAsDialog();
    if (FileName = '') then
      Exit;
  end;

  try
    FEditor.Lines.SaveToFile(FileName);

    Result := True;
  except
    on E: Exception do
    begin
      MessageDlg('Unable to save script: ' + E.Message, mtError, [mbOK], 0);

      Exit;
    end;
  end;

  FSavedText := FEditor.Text;

  FScriptFileName := FileName;
  FScriptTitle := TSimbaPath.PathExtractName(FScriptFileName);
  if FScriptTitle.EndsWith('.simba') then
    FScriptTitle := FScriptTitle.Before('.simba');

  Caption := FScriptTitle;
end;

function TSimbaScriptTab.Load(FileName: String): Boolean;
begin
  Result := False;
  if (FileName = '') then
    Exit;

  try
    FEditor.Lines.LoadFromFile(FileName);

    Result := True;
  except
    on E: Exception do
    begin
      MessageDlg('Unable to load script: ' + E.Message, mtError, [mbOK], 0);
      Exit;
    end;
  end;

  FSavedText := FEditor.Text;

  FScriptFileName := FileName;
  FScriptTitle := TSimbaPath.PathExtractName(FScriptFileName);
  if FScriptTitle.EndsWith('.simba') then
    FScriptTitle := FScriptTitle.Before('.simba');

  Caption := FScriptTitle;
  if Result then
    SimbaIDEEvents.Notify(SimbaIDEEvent.TAB_LOADED, Self);
end;

procedure TSimbaScriptTab.Undo;
begin
  FEditor.Undo();
end;

procedure TSimbaScriptTab.Redo;
begin
  FEditor.Redo();
end;

procedure TSimbaScriptTab.GotoLine(Line: Integer);
begin
  Editor.CaretX := 1;
  Editor.CaretY := Line;
  Editor.TopLine := (Line + 1) - (Editor.LinesInWindow div 2);
end;

function TSimbaScriptTab.IsActiveTab: Boolean;
begin
  Result := TabControl.ActiveTab = Self;
end;

function TSimbaScriptTab.CanClose: Boolean;
begin
  Result := True;

  if (FScriptRunner <> nil) then
  begin
    Show();

    // Don't close if user doesn't want to focefully stop the script
    if (MessageDlg('Script is still running. Forcefully stop this script?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
    begin
      Result := False;
      Exit;
    end;

    if (FScriptRunner <> nil) then
      FScriptRunner.Kill();
  end;

  if ScriptChanged then
  begin
    Show();

    // Ask to save the script yes/no = can close. Else cannot close.
    case MessageDlg('Script has been modified. Save this script?', mtConfirmation, [mbYes, mbNo, mbAbort], 0) of
      mrYes:
        Result := Save(FScriptFileName);
      mrNo:
        Result := True;
      else
        Result := False;
    end;
  end;
end;

function TSimbaScriptTab.ScriptStateStr: String;
begin
  Result := 'Stopped';

  if (FScriptRunner <> nil) then
    case FScriptRunner.State of
      ESimbaScriptState.STATE_RUNNING: Result := FormatMilliseconds(FScriptRunner.TimeRunning, 'hh:mm:ss');
      ESimbaScriptState.STATE_PAUSED:  Result := 'Paused';
    end;
end;

function TSimbaScriptTab.ScriptState: ESimbaScriptState;
begin
  Result := ESimbaScriptState.STATE_NONE;
  if (FScriptRunner <> nil) then
    Result := FScriptRunner.State;
end;

procedure TSimbaScriptTab.Run(Target: TWindowHandle);
begin
  //DebugLn('TSimbaScriptTab.Run :: ' + ScriptTitle + ' ' + ScriptFileName);

  if (FScriptRunner <> nil) then
    FScriptRunner.Resume()
  else
  begin
    if (FScriptFileName <> '') then
      Save(FScriptFileName);

    FScriptRunner := TSimbaScriptTabRunner.Create(Self);
    if (Target > 0) then
      FScriptRunner.Run(['--target=' + IntToStr(Target)])
    else
      FScriptRunner.Run([]);
  end;
end;

procedure TSimbaScriptTab.Compile;
begin
  //DebugLn('TSimbaScriptTab.Compile :: ' + ScriptTitle + ' ' + ScriptFileName);

  if (FScriptRunner = nil) then
  begin
    if (FScriptFileName <> '') then
      Save(FScriptFileName);

    FScriptRunner := TSimbaScriptTabRunner.Create(Self);
    FScriptRunner.Compile([]);
  end;
end;

procedure TSimbaScriptTab.Pause;
begin
  //DebugLn('TSimbaScriptTab.Pause :: ' + ScriptTitle + ' ' + ScriptFileName);

  if (FScriptRunner <> nil) then
    FScriptRunner.Pause();
end;

procedure TSimbaScriptTab.Stop;
begin
  //DebugLn('TSimbaScriptTab.Stop :: ' + ScriptTitle + ' ' + ScriptFileName);

  if (FScriptRunner <> nil) then
    FScriptRunner.Stop();
end;

constructor TSimbaScriptTab.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Inc(__UID);

  FUID := __UID;
  FScriptTitle := 'Untitled';
  FScriptFileName := '';

  FEditor := TSimbaEditor.Create(Self, [seoColors, seoKeybindings]);
  FEditor.Parent := Self;
  FEditor.Align := alClient;
  FEditor.RegisterStatusChangedHandler(@DoEditorStatusChanges, [scCaretX, scCaretY, scModified]);
  FEditor.OnClickLink := @DoEditorLinkClick;
  FEditor.OnModified := @DoEditorModified;
  FEditor.OnGetFileName := @DoEditorGetFileName;
  FEditor.PopupMenu := TSimbaTabPopupMenu.Create(Self);

  FOutputBox := SimbaOutputForm.AddScriptOutput('Untitled');
  FOutputBox.TabImageIndex := IMG_STOP;

  LoadDefaultScript();

  FSavedText := FEditor.Text;
end;

destructor TSimbaScriptTab.Destroy;
begin
  Application.RemoveAsyncCalls(Self);
  SimbaIDEEvents.Notify(SimbaIDEEvent.TAB_CLOSED, Self);
  if Assigned(SimbaOutputForm) then
    SimbaOutputForm.RemoveTab(FOutputBox);

  inherited Destroy();
end;

end.
