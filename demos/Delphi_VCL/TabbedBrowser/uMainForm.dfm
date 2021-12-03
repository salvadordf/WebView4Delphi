object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Tabbed Browser'
  ClientHeight = 744
  ClientWidth = 1056
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object ButtonPnl: TPanel
    Left = 0
    Top = 0
    Width = 32
    Height = 744
    Align = alLeft
    BevelOuter = bvNone
    Enabled = False
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 0
    object AddTabBtn: TSpeedButton
      Left = 3
      Top = 3
      Width = 26
      Height = 26
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      OnClick = AddTabBtnClick
    end
    object RemoveTabBtn: TSpeedButton
      Left = 3
      Top = 32
      Width = 26
      Height = 26
      Caption = #8722
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      OnClick = RemoveTabBtnClick
    end
  end
  object BrowserPageCtrl: TPageControl
    Left = 32
    Top = 0
    Width = 1024
    Height = 744
    Align = alClient
    TabOrder = 1
    TabWidth = 150
  end
end
