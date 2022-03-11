object TBasicUserAuthForm: TTBasicUserAuthForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'User authentication'
  ClientHeight = 195
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  DesignSize = (
    537
    195)
  TextHeight = 15
  object InfoLbl: TLabel
    Left = 40
    Top = 16
    Width = 308
    Height = 15
    Caption = 'Type your username and password for the following page :'
  end
  object UsernameLbl: TLabel
    Left = 40
    Top = 72
    Width = 53
    Height = 15
    Caption = 'Username'
  end
  object PasswordLbl: TLabel
    Left = 40
    Top = 120
    Width = 50
    Height = 15
    Caption = 'Password'
  end
  object URILbl: TLabel
    Left = 40
    Top = 37
    Width = 3
    Height = 15
  end
  object ButtonPnl: TPanel
    Left = 0
    Top = 160
    Width = 537
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 40
    Padding.Top = 5
    Padding.Right = 40
    Padding.Bottom = 5
    TabOrder = 2
    ExplicitWidth = 432
    object OkBtn: TButton
      Left = 40
      Top = 5
      Width = 120
      Height = 25
      Align = alLeft
      Caption = 'Ok'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      OnClick = OkBtnClick
      ExplicitHeight = 31
    end
    object CancelBtn: TButton
      Left = 377
      Top = 5
      Width = 120
      Height = 25
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = CancelBtnClick
      ExplicitLeft = 317
      ExplicitHeight = 31
    end
  end
  object UsernameEdt: TEdit
    Left = 120
    Top = 69
    Width = 377
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = UsernameEdtChange
  end
  object PasswordEdt: TEdit
    Left = 120
    Top = 117
    Width = 377
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 1
    OnChange = UsernameEdtChange
  end
end
