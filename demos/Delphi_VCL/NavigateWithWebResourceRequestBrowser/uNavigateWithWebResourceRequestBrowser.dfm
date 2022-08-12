object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'NavigateWithWebResourceRequestBrowser'
  ClientHeight = 205
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 95
    Width = 682
    Height = 110
    Align = alClient
    TabOrder = 1
    Browser = WVBrowser1
  end
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 95
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 39
      Width = 41
      Height = 15
      Caption = 'Name 1'
    end
    object Label2: TLabel
      Left = 248
      Top = 39
      Width = 41
      Height = 15
      Caption = 'Name 2'
    end
    object Label3: TLabel
      Left = 8
      Top = 68
      Width = 37
      Height = 15
      Caption = 'Value 1'
    end
    object Label4: TLabel
      Left = 248
      Top = 68
      Width = 37
      Height = 15
      Caption = 'Value 2'
    end
    object Label5: TLabel
      Left = 8
      Top = 11
      Width = 21
      Height = 15
      Caption = 'URL'
    end
    object GoBtn: TButton
      Left = 432
      Top = 8
      Width = 241
      Height = 23
      Caption = 'Send POST request'
      TabOrder = 0
      OnClick = GoBtnClick
    end
    object PostParam1NameEdt: TEdit
      Left = 55
      Top = 36
      Width = 121
      Height = 23
      TabOrder = 1
      Text = 'ParamName1'
    end
    object PostParam2NameEdt: TEdit
      Left = 294
      Top = 36
      Width = 121
      Height = 23
      TabOrder = 2
      Text = 'ParamName2'
    end
    object PostParam1ValueEdt: TEdit
      Left = 55
      Top = 65
      Width = 121
      Height = 23
      TabOrder = 3
      Text = 'ParamValue1'
    end
    object PostParam2ValueEdt: TEdit
      Left = 294
      Top = 65
      Width = 121
      Height = 23
      TabOrder = 4
      Text = 'ParamValue2'
    end
    object AddressCb: TComboBox
      Left = 55
      Top = 8
      Width = 360
      Height = 23
      ItemIndex = 0
      TabOrder = 5
      Text = 'https://ptsv2.com/t/cef4delphi/post'
      Items.Strings = (
        'https://ptsv2.com/t/cef4delphi/post'
        '')
    end
    object Button1: TButton
      Left = 432
      Top = 65
      Width = 241
      Height = 23
      Caption = 'Check results in PTSV2.com'
      TabOrder = 6
      OnClick = Button1Click
    end
    object SendCustomHTTPHeaderChk: TCheckBox
      Left = 432
      Top = 39
      Width = 241
      Height = 17
      Caption = 'Send custom HTTP header'
      TabOrder = 7
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 304
    Top = 104
  end
  object WVBrowser1: TWVBrowser
    TargetCompatibleBrowserVersion = '95.0.1020.44'
    AllowSingleSignOnUsingOSPrimaryAccount = False
    OnInitializationError = WVBrowser1InitializationError
    OnAfterCreated = WVBrowser1AfterCreated
    Left = 192
    Top = 104
  end
end
