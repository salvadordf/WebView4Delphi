object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'BrowserHostAppCommunication - Initializing...'
  ClientHeight = 701
  ClientWidth = 995
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
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 0
    Width = 640
    Height = 701
    Align = alClient
    TabOrder = 1
    Browser = WVBrowser1
  end
  object MessagesPnl: TPanel
    Left = 640
    Top = 0
    Width = 355
    Height = 701
    Align = alRight
    BevelOuter = bvNone
    Enabled = False
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    object GoBtn: TButton
      Left = 10
      Top = 33
      Width = 335
      Height = 24
      Align = alTop
      Caption = '<<< Send a message to the web browser'
      TabOrder = 0
      OnClick = GoBtnClick
    end
    object Edit1: TEdit
      Left = 10
      Top = 10
      Width = 335
      Height = 23
      Align = alTop
      TabOrder = 1
      Text = 'Hello from the host application!'
    end
    object Panel1: TPanel
      Left = 10
      Top = 57
      Width = 335
      Height = 634
      Align = alClient
      BevelOuter = bvNone
      Padding.Top = 15
      TabOrder = 2
      object Label1: TLabel
        Left = 0
        Top = 15
        Width = 335
        Height = 15
        Align = alTop
        Caption = 'Messages from the web browser :'
        ExplicitWidth = 176
      end
      object MessagesMem: TMemo
        Left = 0
        Top = 30
        Width = 335
        Height = 604
        Align = alClient
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 312
    Top = 160
  end
  object WVBrowser1: TWVBrowser
    TargetCompatibleBrowserVersion = '95.0.1020.44'
    AllowSingleSignOnUsingOSPrimaryAccount = False
    OnInitializationError = WVBrowser1InitializationError
    OnAfterCreated = WVBrowser1AfterCreated
    OnWebMessageReceived = WVBrowser1WebMessageReceived
    Left = 200
    Top = 160
  end
end
