object frmProgress: TfrmProgress
  Left = 414
  Top = 426
  BorderStyle = bsNone
  Caption = 'Progress'
  ClientHeight = 120
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFrame: TPanel
    Left = 0
    Top = 0
    Width = 498
    Height = 120
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    ExplicitHeight = 148
    object pnlButton: TPanel
      Left = 2
      Top = 78
      Width = 494
      Height = 40
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 119
      object btnCancel: TBitBtn
        Left = 204
        Top = 1
        Width = 93
        Height = 31
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Kind = bkCancel
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnCancelClick
      end
    end
    object pnlPanel1: TPanel
      Left = 2
      Top = 46
      Width = 494
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      BevelOuter = bvNone
      BorderWidth = 5
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 116
      ExplicitWidth = 498
      object prbProgressBar1: TProgressBar
        Left = 5
        Top = 5
        Width = 484
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        TabOrder = 0
      end
    end
    object pnlInfo: TPanel
      Left = 2
      Top = 2
      Width = 494
      Height = 44
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      TabOrder = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitHeight = 40
    end
  end
end
