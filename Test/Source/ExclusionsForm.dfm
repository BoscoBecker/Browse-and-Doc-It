object frmExclusions: TfrmExclusions
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Exclusions'
  ClientHeight = 330
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    488
    330)
  PixelsPerInch = 96
  TextHeight = 13
  object memExclusions: TMemo
    Left = 8
    Top = 8
    Width = 472
    Height = 283
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    ExplicitWidth = 384
    ExplicitHeight = 197
  end
  object btnOK: TBitBtn
    Left = 324
    Top = 297
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 1
    Kind = bkOK
    ExplicitLeft = 178
    ExplicitTop = 221
  end
  object btnCancel: TBitBtn
    Left = 405
    Top = 297
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 2
    Kind = bkCancel
    ExplicitLeft = 259
    ExplicitTop = 221
  end
end