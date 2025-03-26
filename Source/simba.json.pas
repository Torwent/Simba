{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
  --------------------------------------------------------------------------

  Wraps FPC's json parser.
}
unit simba.json;

{$i simba.inc}

interface

uses
  Classes, SysUtils,
  fpjson, jsonscanner,
  simba.base, simba.baseclass;

type
  {$SCOPEDENUMS ON}
  EJSONItemType = (UNKNOWN, INT, FLOAT, STR, BOOL, NULL, ARR, OBJ);
  {$SCOPEDENUMS OFF}

  TSimbaJSONItem = type Pointer;
  TSimbaJSONItemHelper = type helper for TSimbaJSONItem
  private
    procedure CheckIsObject;
    procedure CheckIsObjectOrArray;

    function GetAsBool: Boolean;
    function GetAsFloat: Double;
    function GetAsInt: Int64;
    function GetAsString: String;
    function GetAsUnicodeString: UnicodeString;
    function GetCount: Integer;
    function GetItemByIndex(Index: Integer): TSimbaJSONItem;
    function GetItemByKey(Key: String): TSimbaJSONItem;
    function GetItemType: EJSONItemType;
    function GetKey(Index: Integer): String;

    procedure SetAsBool(AValue: Boolean);
    procedure SetAsFloat(AValue: Double);
    procedure SetAsInt(AValue: Int64);
    procedure SetAsString(AValue: String);
    procedure SetAsUnicodeString(AValue: UnicodeString);
  public
    property Typ: EJSONItemType read GetItemType;

    property AsInt: Int64 read GetAsInt write SetAsInt;
    property AsString: String read GetAsString write SetAsString;
    property AsUnicodeString: UnicodeString read GetAsUnicodeString write SetAsUnicodeString;
    property AsBool: Boolean read GetAsBool write SetAsBool;
    property AsFloat: Double read GetAsFloat write SetAsFloat;

    property Count: Integer read GetCount;
    property ItemsByIndex[Index: Integer]: TSimbaJSONItem read GetItemByIndex;
    property ItemsByKey[AKey: String]: TSimbaJSONItem read GetItemByKey;
    property Key[Index: Integer]: String read GetKey;

    procedure Add(AKey: String; Value: TSimbaJSONItem);
    procedure AddInt(AKey: String; Value: Int64);
    procedure AddString(AKey: String; Value: String);
    procedure AddUnicodeString(AKey: String; Value: UnicodeString);
    procedure AddBool(AKey: String; Value: Boolean);
    procedure AddFloat(AKey: String; Value: Double);
    procedure AddArray(AKey: String; Value: TSimbaJSONItem);
    procedure AddObject(AKey: String; Value: TSimbaJSONItem);

    function Has(AKey: String): Boolean; overload;
    function Has(AKey: String; ItemType: EJSONItemType): Boolean; overload;

    function GetInt(AKey: String; out Value: Int64): Boolean;
    function GetFloat(AKey: String; out Value: Double): Boolean;
    function GetString(AKey: String; out Value: String): Boolean;
    function GetUnicodeString(AKey: String; out Value: UnicodeString): Boolean;
    function GetBool(AKey: String; out Value: Boolean): Boolean;
    function GetArray(AKey: String; out Value: TSimbaJSONItem): Boolean;
    function GetObject(AKey: String; out Value: TSimbaJSONItem): Boolean;

    function FindPath(Path: String): TSimbaJSONItem;
    function Clone: TSimbaJSONItem;
    procedure Delete(Item: TSimbaJSONItem);
    procedure Clear;

    function ToJSON: String;

    procedure Free;
  end;

  function NewJSONObject: TSimbaJSONItem;
  function NewJSONArray: TSimbaJSONItem;
  function ParseJSON(Str: String): TSimbaJSONItem;
  function LoadJSON(FileName: String): TSimbaJSONItem;
  procedure SaveJSON(Json: TSimbaJSONItem; FileName: String);

implementation

uses
  simba.jsonparser;

procedure TSimbaJSONItemHelper.CheckIsObject;
begin
  if (TJSONData(Self).JSONType <> jtObject) then
    SimbaException('Expected a JSON object. This item is a %s', [JSONTypeName(TJSONData(Self).JSONType)]);
end;

procedure TSimbaJSONItemHelper.CheckIsObjectOrArray;
begin
  if (not (TJSONData(Self).JSONType in [jtObject, jtArray])) then
    SimbaException('Expected a JSON object/array. This item is a %s', [JSONTypeName(TJSONData(Self).JSONType)]);
end;

function TSimbaJSONItemHelper.GetAsBool: Boolean;
begin
  Result := TJSONData(Self).AsBoolean;
end;

function TSimbaJSONItemHelper.GetAsFloat: Double;
begin
  Result := TJSONData(Self).AsFloat;
end;

function TSimbaJSONItemHelper.GetAsInt: Int64;
begin
  Result := TJSONData(Self).AsInt64;
end;

function TSimbaJSONItemHelper.GetAsString: String;
begin
  Result := TJSONData(Self).AsString;
end;

function TSimbaJSONItemHelper.GetCount: Integer;
begin
  Result := TJSONData(Self).Count;
end;

function TSimbaJSONItemHelper.GetItemByIndex(Index: Integer): TSimbaJSONItem;
begin
  Result := TJSONData(Self).Items[Index];
end;

function TSimbaJSONItemHelper.GetItemByKey(Key: String): TSimbaJSONItem;
begin
  CheckIsObject();

  Result := TJSONObject(Self).Find(Key);
end;

function TSimbaJSONItemHelper.GetItemType: EJSONItemType;
begin
  case TJSONData(Self).JSONType of
    jtUnknown: Result := EJSONItemType.UNKNOWN;
    jtString:  Result := EJSONItemType.STR;
    jtBoolean: Result := EJSONItemType.BOOL;
    jtNull:    Result := EJSONItemType.NULL;
    jtArray:   Result := EJSONItemType.ARR;
    jtObject:  Result := EJSONItemType.OBJ;
    jtNumber:
      if (TJSONNumber(Self).NumberType = ntFloat) then
        Result := EJSONItemType.FLOAT
      else
        Result := EJSONItemType.INT;
  end;
end;

function TSimbaJSONItemHelper.GetKey(Index: Integer): String;
begin
  CheckIsObject();

  Result := TJSONObject(Self).Names[Index];
end;

function TSimbaJSONItemHelper.GetAsUnicodeString: UnicodeString;
begin
  Result := TJSONData(Self).AsUnicodeString;
end;

function TSimbaJSONItemHelper.ToJSON: String;
begin
  Result := TJSONData(Self).FormatJSON();
end;

procedure TSimbaJSONItemHelper.SetAsBool(AValue: Boolean);
begin
  TJSONData(Self).AsBoolean := AValue;
end;

procedure TSimbaJSONItemHelper.SetAsFloat(AValue: Double);
begin
  TJSONData(Self).AsFloat := AValue;
end;

procedure TSimbaJSONItemHelper.SetAsInt(AValue: Int64);
begin
  TJSONData(Self).AsInt64 := AValue;
end;

procedure TSimbaJSONItemHelper.SetAsString(AValue: String);
begin
  TJSONData(Self).AsString := AValue;
end;

procedure TSimbaJSONItemHelper.SetAsUnicodeString(AValue: UnicodeString);
begin
  TJSONData(Self).AsUnicodeString := AValue;
end;

procedure TSimbaJSONItemHelper.Add(AKey: String; Value: TSimbaJSONItem);
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, TJSONData(Value));
    jtArray:  TJSONArray(Self).Add(TJSONData(Value));
  end;
end;

procedure TSimbaJSONItemHelper.AddInt(AKey: String; Value: Int64);
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, Value);
    jtArray:  TJSONArray(Self).Add(Value);
  end;
end;

procedure TSimbaJSONItemHelper.AddString(AKey: String; Value: String);
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, Value);
    jtArray:  TJSONArray(Self).Add(Value);
  end;
end;

procedure TSimbaJSONItemHelper.AddUnicodeString(AKey: String; Value: UnicodeString);
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, Value);
    jtArray:  TJSONArray(Self).Add(Value);
  end;
end;

procedure TSimbaJSONItemHelper.AddBool(AKey: String; Value: Boolean);
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, Value);
    jtArray:  TJSONArray(Self).Add(Value);
  end;
end;

procedure TSimbaJSONItemHelper.AddFloat(AKey: String; Value: Double);
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, Value);
    jtArray:  TJSONArray(Self).Add(Value);
  end;
end;

procedure TSimbaJSONItemHelper.AddArray(AKey: String; Value: TSimbaJSONItem);
begin
  CheckIsObjectOrArray();
  if (TJSONData(Value).JSONType <> jtArray) then
    SimbaException('Value is not a JSON array');

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, TJSONArray(Value));
    jtArray:  TJSONArray(Self).Add(TJSONArray(Value));
  end;
end;

procedure TSimbaJSONItemHelper.AddObject(AKey: String; Value: TSimbaJSONItem);
begin
  CheckIsObjectOrArray();
  if (TJSONData(Value).JSONType <> jtObject) then
    SimbaException('Value is not a JSON object');

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Add(AKey, TJSONObject(Value));
    jtArray:  TJSONArray(Self).Add(TJSONObject(Value));
  end;
end;

function TSimbaJSONItemHelper.Has(AKey: String): Boolean;
begin
  CheckIsObject();
  Result := TJSONObject(Self).Find(AKey) <> nil;
end;

function TSimbaJSONItemHelper.Has(AKey: String; ItemType: EJSONItemType): Boolean;
var
  Item: TSimbaJSONItem;
begin
  CheckIsObject();
  Item := ItemsByKey[AKey];
  Result := (Item <> nil) and (Item.Typ = ItemType);
end;

function TSimbaJSONItemHelper.GetInt(AKey: String; out Value: Int64): Boolean;
begin
  Result := Has(AKey, EJSONItemType.INT);
  if Result then
    Value := ItemsByKey[AKey].AsInt;
end;

function TSimbaJSONItemHelper.GetFloat(AKey: String; out Value: Double): Boolean;
begin
  Result := Has(AKey, EJSONItemType.FLOAT);
  if Result then
    Value := ItemsByKey[AKey].AsFloat;
end;

function TSimbaJSONItemHelper.GetString(AKey: String; out Value: String): Boolean;
begin
  Result := Has(AKey, EJSONItemType.STR);
  if Result then
    Value := ItemsByKey[AKey].AsString;
end;

function TSimbaJSONItemHelper.GetUnicodeString(AKey: String; out Value: UnicodeString): Boolean;
begin
  Result := Has(AKey, EJSONItemType.STR);
  if Result then
    Value := ItemsByKey[AKey].AsUnicodeString;
end;

function TSimbaJSONItemHelper.GetBool(AKey: String; out Value: Boolean): Boolean;
begin
  Result := Has(AKey, EJSONItemType.BOOL);
  if Result then
    Value := ItemsByKey[AKey].AsBool;
end;

function TSimbaJSONItemHelper.GetArray(AKey: String; out Value: TSimbaJSONItem): Boolean;
begin
  Result := Has(AKey, EJSONItemType.ARR);
  if Result then
    Value := TJSONArray(ItemsByKey[AKey]);
end;

function TSimbaJSONItemHelper.GetObject(AKey: String; out Value: TSimbaJSONItem): Boolean;
begin
  Result := Has(AKey, EJSONItemType.OBJ);
  if Result then
    Value := TJSONObject(ItemsByKey[AKey]);
end;

function TSimbaJSONItemHelper.FindPath(Path: String): TSimbaJSONItem;
begin
  Result := TJSONData(Self).FindPath(Path);
end;

function TSimbaJSONItemHelper.Clone: TSimbaJSONItem;
begin
  Result := TJSONData(Self).Clone;
end;

procedure TSimbaJSONItemHelper.Delete(Item: TSimbaJSONItem);
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Delete(TJSONObject(Self).IndexOf(TJSONData(Item)));
    jtArray:  TJSONArray(Self).Delete(TJSONArray(Self).IndexOf(TJSONData(Item)));
    else
      SimbaException('Cannot delete to a non json object/array');
  end;
end;

procedure TSimbaJSONItemHelper.Clear;
begin
  CheckIsObjectOrArray();

  case TJSONData(Self).JSONType of
    jtObject: TJSONObject(Self).Clear;
    jtArray:  TJSONArray(Self).Clear;
  end;
end;

procedure TSimbaJSONItemHelper.Free;
begin
  FreeAndNil(TJSONData(Self));
end;

function NewJSONObject: TSimbaJSONItem;
begin
  Result := TSimbaJSONParser.NewObject();
end;

function NewJSONArray: TSimbaJSONItem;
begin
  Result := TSimbaJSONParser.NewArray();
end;

function ParseJSON(Str: String): TSimbaJSONItem;
begin
  with TSimbaJSONParser.Create(TStringStream.Create(Str), True) do
  try
    Result := Parse();
  finally
    Free();
  end;
end;

function LoadJSON(FileName: String): TSimbaJSONItem;
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    with TSimbaJSONParser.Create(Stream, True) do
    try
      Result := Parse();
    finally
      Free();
    end;
  finally
    Stream.Free();
  end;
end;

procedure SaveJSON(Json: TSimbaJSONItem; FileName: String);
var
  Stream: TFileStream;
  Text: String;
begin
  Text := JSON.ToJSON;
  if (Length(Text) = 0) then
    Exit;

  if FileExists(FileName) then
    Stream := TFileStream.Create(FileName, fmOpenReadWrite)
  else
    Stream := TFileStream.Create(FileName, fmCreate);

  try
    Stream.Write(Text[1], Length(Text));
  finally
    Stream.Free();
  end;
end;

end.

