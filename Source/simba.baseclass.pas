{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
}
unit simba.baseclass;

{$i simba.inc}

interface

uses
  Classes, SysUtils,
  simba.base, simba.containers, simba.threading;

type
  TSimbaBaseClass = class
  protected
    FName: String;
    FFreeOnTerminate: Boolean;

    procedure NotifyUnfreed; virtual;

    function GetName: String;
    procedure SetName(Value: String);
  public
    constructor Create;
    destructor Destroy; override;

    function GetSelf: TSimbaBaseClass;

    property Name: String read GetName write SetName;
    property FreeOnTerminate: Boolean read FFreeOnTerminate write FFreeOnTerminate;
  end;
  TSimbaBaseClassType = class of TSimbaBaseClass;
  TSimbaBaseClassArray = array of TSimbaBaseClass;
  TSimbaBaseClassCreate = procedure(Obj: TSimbaBaseClass) of object;

  TSimbaBaseThread = class(TThread)
  protected
    FName: String;

    procedure NotifyUnfreed; virtual; // also used for unfinished
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;

    property Terminated;
  end;

  procedure PrintUnfreedObjects;
  procedure PrintUnfinishedThreads;
  procedure PrintUnfreedThreads;

  function GetSimbaObjectsOfClass(ClassType: TSimbaBaseClassType): TSimbaBaseClassArray;

  procedure AddHandlerOnSimbaObjectCreate(Proc: TSimbaBaseClassCreate);
  procedure RemoveHandlerOnSimbaObjectCreate(Proc: TSimbaBaseClassCreate);

implementation

type
  TTrackedObjects = specialize TSimbaThreadsafeObjectList<TSimbaBaseClass>;
  TTrackedThreads = specialize TSimbaThreadsafeObjectList<TSimbaBaseThread>;
  TCreateObjectEvents = specialize TSimbaThreadsafeList<TSimbaBaseClassCreate>;

var
  TrackedObjects: TTrackedObjects;
  TrackedThreads: TTrackedThreads;

  CreateEvents: TCreateObjectEvents;

procedure PrintUnfreedObjects;
var
  NeedHeader: Boolean = True;
begin
  TrackedObjects.Lock();
  try
    while (TrackedObjects.Count > 0) do
    begin
      if not TrackedObjects.First.FreeOnTerminate then
      begin
        if NeedHeader then
          DebugLn([EDebugLn.YELLOW], 'The following objects were not freed:');
        NeedHeader := False;

        TrackedObjects.First.NotifyUnfreed();
      end;

      TrackedObjects.First.Free();
    end;
  finally
    TrackedObjects.Unlock();
  end;
end;

procedure PrintUnfinishedThreads;
var
  NeedHeader: Boolean = True;
  I: Integer;
begin
  TrackedThreads.Lock();
  try
    for I := 0 to TrackedThreads.Count - 1 do
      if not TrackedThreads[I].Finished then
      begin
        if NeedHeader then
          DebugLn([EDebugLn.YELLOW], 'The following threads were still running:');
        NeedHeader := False;

        TrackedThreads[I].NotifyUnfreed();
      end;
  finally
    TrackedThreads.Unlock();
  end;
end;

procedure PrintUnfreedThreads;
var
  NeedHeader: Boolean = True;
begin
  TrackedThreads.Lock();
  try
    while (TrackedThreads.Count > 0) do
    begin
      if TrackedThreads.First.Finished and (not TrackedThreads.First.FreeOnTerminate) then
      begin
        if NeedHeader then
          DebugLn([EDebugLn.YELLOW], 'The following threads were not freed:');
        NeedHeader := False;

        TrackedThreads.First.NotifyUnfreed();
      end;

      if TrackedThreads.First.FreeOnTerminate then
        TrackedThreads.Delete(TrackedThreads.First)
      else
        TrackedThreads.First.Free();
    end;
  finally
    TrackedThreads.Unlock();
  end;
end;

function GetSimbaObjectsOfClass(ClassType: TSimbaBaseClassType): TSimbaBaseClassArray;
var
  I: Integer;
begin
  Result := [];

  TrackedObjects.Lock();
  try
    for I := 0 to TrackedObjects.Count - 1 do
      if (TrackedObjects[I] is ClassType) then
        Result := Result + [TrackedObjects[I]];
  finally
    TrackedObjects.UnLock();
  end;
end;

procedure AddHandlerOnSimbaObjectCreate(Proc: TSimbaBaseClassCreate);
begin
  CreateEvents.Add(Proc);
end;

procedure RemoveHandlerOnSimbaObjectCreate(Proc: TSimbaBaseClassCreate);
var
  i: Integer;
begin
  CreateEvents.Lock();
  try
    for i := CreateEvents.Count - 1 downto 0 do
      if (CreateEvents[i] = Proc) then
        CreateEvents.Delete(i);
  finally
    CreateEvents.UnLock();
  end;
end;

procedure TSimbaBaseClass.NotifyUnfreed;
begin
  DebugLn([EDebugLn.YELLOW], '  ' + ClassName + ' (' + HexStr(Self) + ')' + IfThen(Name <> '', ' "' + Name + '"', ''));
end;

function TSimbaBaseClass.GetName: String;
begin
  Result := FName;
end;

procedure TSimbaBaseClass.SetName(Value: String);
begin
  FName := Value;
end;

constructor TSimbaBaseClass.Create;
begin
  inherited Create();

  if (TrackedObjects <> nil) then
    TrackedObjects.Add(Self);

  CreateEvents.Lock();
  try
    if (CreateEvents.Count > 0) then
      CreateEvents[CreateEvents.Count - 1](Self);
  finally
    CreateEvents.UnLock();
  end;
end;

destructor TSimbaBaseClass.Destroy;
begin
  if (TrackedObjects <> nil) then
    TrackedObjects.Delete(Self);

  inherited Destroy();
end;

function TSimbaBaseClass.GetSelf: TSimbaBaseClass;
begin
  Result := Self;
end;

procedure TSimbaBaseThread.NotifyUnfreed;
begin
  DebugLn([EDebugLn.YELLOW], '  ' + ClassName + ' (' + HexStr(Self) + ')' + IfThen(FName <> '', ' "' + FName + '"', ''));
end;

constructor TSimbaBaseThread.Create;
begin
  inherited Create(True, DefaultStackSize div 2);

  if (TrackedThreads <> nil) then
    TrackedThreads.Add(Self);
end;

destructor TSimbaBaseThread.Destroy;
begin
  inherited Destroy();

  if (TrackedThreads <> nil) then
    TrackedThreads.Delete(Self);
end;

initialization
  TrackedObjects := TTrackedObjects.Create();
  TrackedThreads := TTrackedThreads.Create();

  CreateEvents := TCreateObjectEvents.Create();

finalization
  while (TrackedObjects.Count > 0) do
    TrackedObjects.First.Free();

end.
