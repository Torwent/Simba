{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
}
unit simba.component_button;

{$i simba.inc}

interface

uses
  Classes, SysUtils, Controls, StdCtrls, Buttons, Graphics, LMessages, ImgList,
  simba.base;

type
  {$push}
  {$scopedenums on}
  ESimbaButtonImage = (
    NONE,
    OK,
    CLOSE,
    CLEAR_FILTER,
    SELECT_DIR,
    SELECT_FILE,
    TIME,
    CALC,
    CALENDER
  );
  {$pop}

const
  IMG_TO_LAZ_GLYPH: array[ESimbaButtonImage] of String = (
    '',
    'btn_ok',
    'btn_cancel',
    'btnfiltercancel',
    'btnseldir',
    'btnselfile',
    'btntime',
    'btncalculator',
    'btncalendar'
  );

type
  TSimbaButton = class(TCustomControl)
  protected
    FImageList: TImageList;
    FImageIndex: Integer;
    FImage: ESimbaButtonImage;

    FDown: Boolean;
    FXPadding: Integer;
    FYPadding: Integer;
    FImageSpacing: Integer;

    function HasImage: Boolean;
    function ImageSize: TSize;
    function CalculateSize: TPoint;

    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure TextChanged; override;

    procedure CalculatePreferredSize(var PreferredWidth, PreferredHeight: integer; WithThemeSpace: Boolean); override;

    // Use parent font size, but use SimbaTheme.FontStyle and font styles if changed
    procedure CMParentFontChanged(var Message: TLMessage); message CM_PARENTFONTCHANGED;

    procedure SetDown(AValue: Boolean);
    procedure SetXPadding(AValue: Integer);
    procedure SetYPadding(AValue: Integer);
    procedure SetImageSpacing(AValue: Integer);

    procedure SetImage(Img: ESimbaButtonImage);
    procedure SetImageIndex(Index: Integer);
  public
    procedure Paint; override;
    procedure Click; override; // make click public

    constructor Create(AOwner: TComponent); override;

    property ImageList: TImageList read FImageList write FImageList;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Image: ESimbaButtonImage read FImage write SetImage;

    property ImageSpacing: Integer read FImageSpacing write SetImageSpacing;
    property Down: Boolean read FDown write SetDown;
    property XPadding: Integer read FXPadding write SetXPadding;
    property YPadding: Integer read FYPadding write SetYPadding;

    property OnMouseDown;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
  end;

  TSimbaToggleButton = class(TSimbaButton)
  public
    procedure Click; override;
  end;

  TSimbaCheckButton = class(TSimbaToggleButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSimbaLabeledButton = class(TCustomControl)
  protected
    FLabel: TLabel;
    FButton: TSimbaButton;

    procedure TextChanged; override;
  public
    constructor Create(AOwner: TComponent); override;

    property Button: TSimbaButton read FButton;
  end;

  TSimbaTransparentButton = class(TSimbaButton)
  public
    procedure Paint; override;
  end;

  TSimbaLabeledCheckButton = class(TCustomControl)
  protected
    FLabel: TLabel;
    FCheckButton: TSimbaCheckButton;

    procedure TextChanged; override;
  public
    constructor Create(AOwner: TComponent); override;

    property CheckButton: TSimbaCheckButton read FCheckButton;
  end;

  TSimbaCheckButtonGroup = class(TCustomControl)
  protected
    function GetSelected(Index: Integer): Boolean;
    procedure SetSelected(Index: Integer; Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;

    function Add(ACaption: String): Integer;

    property Checked[Index: Integer]: Boolean read GetSelected write SetSelected;
  end;

implementation

uses
  simba.ide_theme, simba.form_main, simba.misc,
  ATCanvasPrimitives;

procedure TSimbaTransparentButton.Paint;
begin
  if Assigned(Parent) then
    Color := Parent.Color;

  inherited Paint();
end;

procedure TSimbaLabeledCheckButton.TextChanged;
begin
  inherited TextChanged();

  if Assigned(FLabel) then
    FLabel.Caption := Text;
end;

constructor TSimbaLabeledCheckButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csOpaque];
  Color := SimbaTheme.ColorFrame;
  Font.Color := SimbaTheme.ColorFont;
  AutoSize := True;
  ParentFont := True;

  FLabel := TLabel.Create(Self);
  FLabel.Parent := Self;
  FLabel.Align := alLeft;
  FLabel.AutoSize := True;
  FLabel.Layout := tlCenter;
  FLabel.ParentFont := True;

  FCheckButton := TSimbaCheckButton.Create(Self);
  FCheckButton.Parent := Self;

  FCheckButton.Anchors := [akLeft];
  FCheckButton.AnchorSideLeft.Control := FLabel;
  FCheckButton.AnchorSideLeft.Side := asrRight;
  FCheckButton.AnchorVerticalCenterTo(FLabel);

  FCheckButton.BorderSpacing.Top := 5;
  FCheckButton.BorderSpacing.Bottom := 5;
  FCheckButton.BorderSpacing.Right := 5;
  FCheckButton.BorderSpacing.Left := 8;
end;

procedure TSimbaCheckButtonGroup.SetSelected(Index: Integer; Value: Boolean);
begin
  if (Controls[Index] is TSimbaLabeledCheckButton) then
    TSimbaLabeledCheckButton(Controls[Index]).CheckButton.Down := Value;
end;

function TSimbaCheckButtonGroup.GetSelected(Index: Integer): Boolean;
begin
  if (Controls[Index] is TSimbaLabeledCheckButton) then
    Result := TSimbaLabeledCheckButton(Controls[Index]).CheckButton.Down
  else
    Result := False;
end;

constructor TSimbaCheckButtonGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  AutoSize := True;
end;

function TSimbaCheckButtonGroup.Add(ACaption: String): Integer;
var
  CheckButton: TSimbaLabeledCheckButton;
begin
  CheckButton := TSimbaLabeledCheckButton.Create(Self);
  CheckButton.Parent := Self;
  CheckButton.Caption := ACaption;
  CheckButton.Align := alBottom;

  Result := GetControlIndex(CheckButton);
end;

procedure TSimbaButton.CMParentFontChanged(var Message: TLMessage);
var
  OldStyle: TFontStyles;
begin
  OldStyle := Font.Style;

  inherited;

  if Assigned(Parent) then
  begin
    Font.BeginUpdate();
    Font := Parent.Font;
    Font.Style := OldStyle;
    Font.Color := SimbaTheme.ColorFont;
    Font.EndUpdate();
  end;
end;

procedure TSimbaButton.SetDown(AValue: Boolean);
begin
  if FDown=AValue then Exit;
  FDown:=AValue;
  Invalidate;
end;

procedure TSimbaButton.SetXPadding(AValue: Integer);
begin
  if FXPadding=AValue then Exit;
  FXPadding := Scale96ToScreen(AValue);

  AdjustSize();
end;

procedure TSimbaButton.SetYPadding(AValue: Integer);
begin
  if FYPadding=AValue then Exit;
  FYPadding := Scale96ToScreen(AValue);

  AdjustSize();
end;

procedure TSimbaButton.SetImageSpacing(AValue: Integer);
begin
  if FImageSpacing=AValue then Exit;
  FImageSpacing := Scale96ToScreen(AValue);

  AdjustSize();
end;

function TSimbaButton.HasImage: Boolean;
begin
  Result := (FImage <> ESimbaButtonImage.NONE) or (FImageIndex > -1);
end;

function TSimbaButton.ImageSize: TSize;
begin
  if (FImage <> ESimbaButtonImage.NONE) then
    Result := LCLGlyphs.SizeForPPI[LCLGlyphs.Width, Font.PixelsPerInch]
  else if (FImageIndex > -1) then
    Result := FImageList.SizeForPPI[FImageList.Width, Font.PixelsPerInch]
  else
    Result := TSize.Create(0, 0);
end;

function TSimbaButton.CalculateSize: TPoint;
begin
  Result.X := 0;
  Result.Y := 0;

  if (Caption <> '') then
    with TBitmap.Create() do
    try
      Canvas.Font := Self.Font;

      Result.X := Canvas.TextWidth(Caption) + (BorderWidth * 2);
      Result.Y := Canvas.TextHeight('Fj') + (BorderWidth * 2);
    finally
      Free();
    end;

  if HasImage then
  begin
    Result.X += FImageSpacing;
    Result.X += ImageSize.Width;
    if ImageSize.Height > Result.Y then
      Result.Y := ImageSize.Height;
  end;

  Result.X += XPadding * 2;
  Result.Y += YPadding * 2;
end;

procedure TSimbaButton.CalculatePreferredSize(var PreferredWidth, PreferredHeight: integer; WithThemeSpace: Boolean);
begin
  inherited CalculatePreferredSize(PreferredWidth, PreferredHeight, WithThemeSpace);

  with CalculateSize() do
  begin
    PreferredWidth := X;
    PreferredHeight := Y;
  end;
end;

procedure TSimbaButton.MouseEnter;
begin
  inherited MouseEnter;

  Invalidate();
end;

procedure TSimbaButton.MouseLeave;
begin
  inherited MouseLeave;

  Invalidate();
end;

procedure TSimbaButton.TextChanged;
begin
  inherited TextChanged;

  AdjustSize();
end;

procedure TSimbaButton.Paint;
var
  Style: TTextStyle;
  R: TRect;
  ImgPoint: TPoint;
begin
  if MouseInClient or FDown then
    Canvas.Brush.Color := SimbaTheme.ColorActive
  else
    Canvas.Brush.Color := Color;

  Canvas.FillRect(ClientRect);
  CanvasPaintRoundedCorners(Canvas, ClientRect, [acckLeftTop, acckRightTop, acckLeftBottom, acckRightBottom], SimbaTheme.ColorFrame, Canvas.Brush.Color, Canvas.Brush.Color);

  R := ClientRect;
  R.Left += XPadding;
  R.Right -= XPadding;
  R.Top += YPadding;
  R.Bottom -= YPadding;

  if HasImage then
  begin
    if (Caption = '') then
    begin
      ImgPoint.X := R.Left + (R.Width div 2) - (ImageSize.Width div 2);
      ImgPoint.Y := R.Top + (R.Height div 2) - (ImageSize.Height div 2);
    end else
    begin
      ImgPoint.X := R.Left;
      ImgPoint.Y := R.CenterPoint.Y - (ImageSize.Height div 2);
    end;

    if (FImage <> ESimbaButtonImage.NONE) then
      LCLGlyphs.DrawForControl(Canvas, ImgPoint.X, ImgPoint.Y, LCLGlyphs.GetImageIndex(IMG_TO_LAZ_GLYPH[FImage]), LCLGlyphs.Width, Self, Enabled)
    else
      FImageList.DrawForControl(Canvas, ImgPoint.X, ImgPoint.Y, FImageIndex, FImageList.Width, Self, Enabled);
  end;

  Style := Canvas.TextStyle;
  Style.Layout := tlCenter;
  Style.Alignment := taCenter;

  if (Caption <> '') then
  begin
    Canvas.Font.Color := SimbaTheme.ColorFont;

    R := ClientRect;
    if HasImage then
      R.Left += ImageSize.Width + FImageSpacing;

    Canvas.TextRect(R, 0,0, Caption, Style);
  end;

  inherited Paint;
end;

procedure TSimbaButton.Click;
begin
  inherited Click;
end;

constructor TSimbaButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Color := SimbaTheme.ColorScrollBarActive;
  AutoSize := True;

  FImageList := SimbaMainForm.Images;
  FImageIndex := -1;

  ImageSpacing := 4;
  XPadding := 10;
  YPadding := 3;
end;

procedure TSimbaButton.SetImage(Img: ESimbaButtonImage);
begin
  FImage := Img;

  AdjustSize();
end;

procedure TSimbaButton.SetImageIndex(Index: Integer);
begin
  FImageIndex := Index;
  FImage := ESimbaButtonImage.NONE;

  AdjustSize();
end;

procedure TSimbaToggleButton.Click;
begin
  inherited Click();

  Down := not Down;
end;

constructor TSimbaCheckButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  SetImageIndex(IMG_TICK);
end;

procedure TSimbaLabeledButton.TextChanged;
begin
  inherited TextChanged();

  if Assigned(FLabel) then
    FLabel.Caption := Text;
end;

constructor TSimbaLabeledButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csOpaque];
  Color := SimbaTheme.ColorBackground;
  AutoSize := True;

  FButton := TSimbaButton.Create(Self);
  FButton.AutoSize := True;
  FButton.Parent := Self;
  FButton.Align := alLeft;

  FLabel := TLabel.Create(Self);
  FLabel.Parent := Self;
  FLabel.AutoSize := True;
  FLabel.Align := alClient;
  FLabel.Layout := tlCenter;
end;

end.

