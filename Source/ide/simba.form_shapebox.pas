{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
}
unit simba.form_shapebox;

{$i simba.inc}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  simba.base, simba.component_shapebox, simba.env, simba.image, simba.ide_maintoolbar;

type
  TSimbaShapeBoxForm = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItemLoadTargetImage: TMenuItem;
    MenuItemLoadImage: TMenuItem;
    OpenDialog: TOpenDialog;

    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItemLoadTargetImageClick(Sender: TObject);
    procedure MenuItemLoadImageClick(Sender: TObject);
  public
    ShapeBox: TSimbaShapeBox;
  end;

var
  SimbaShapeBoxForm: TSimbaShapeBoxForm;

implementation

procedure TSimbaShapeBoxForm.FormCreate(Sender: TObject);
begin
  ShapeBox := TSimbaShapeBox.Create(Self);
  ShapeBox.Parent := Self;
  ShapeBox.Align := alClient;

  Width  := Scale96ToScreen(800);
  Height := Scale96ToScreen(600);
end;

procedure TSimbaShapeBoxForm.FormHide(Sender: TObject);
begin
  ShapeBox.PrintShapes();
  ShapeBox.SaveToFile(SimbaEnv.DataPath + 'shapes');
end;

procedure TSimbaShapeBoxForm.FormShow(Sender: TObject);
begin
  if (ShapeBox.Background.Width = 0) and (ShapeBox.Background.Height = 0) then
    ShapeBox.SetImage(TSimbaImage.Create(1500, 1500));

  ShapeBox.LoadFromFile(SimbaEnv.DataPath + 'shapes');
end;

procedure TSimbaShapeBoxForm.MenuItem3Click(Sender: TObject);
begin
  if OpenDialog.Execute() then
    ShapeBox.LoadFromFile(OpenDialog.FileName);
end;

procedure TSimbaShapeBoxForm.MenuItem4Click(Sender: TObject);
begin
  if OpenDialog.Execute() then
    ShapeBox.SaveToFile(OpenDialog.FileName);
end;

procedure TSimbaShapeBoxForm.MenuItemLoadTargetImageClick(Sender: TObject);
begin
  if (SimbaMainToolBar.WindowSelection > 0) then
    ShapeBox.SetImage(TSimbaImage.CreateFromWindow(SimbaMainToolBar.WindowSelection));
end;

procedure TSimbaShapeBoxForm.MenuItemLoadImageClick(Sender: TObject);
begin
  if OpenDialog.Execute() then
    ShapeBox.SetImage(TSimbaImage.Create(OpenDialog.FileName));
end;

{$R *.lfm}

end.

