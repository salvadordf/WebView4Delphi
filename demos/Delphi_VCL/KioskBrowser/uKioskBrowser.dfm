object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 740
  ClientWidth = 1011
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 0
    Width = 1011
    Height = 560
    Align = alClient
    TabStop = True
    TabOrder = 0
    Browser = WVBrowser1
  end
  object TouchKeyboard1: TTouchKeyboard
    Left = 0
    Top = 560
    Width = 1011
    Height = 180
    Align = alBottom
    GradientEnd = clSilver
    GradientStart = clGray
    Layout = 'Standard'
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 312
    Top = 160
  end
  object WVBrowser1: TWVBrowser
    DefaultURL = 'https://customhost.test/KioskBrowser.html'
    TargetCompatibleBrowserVersion = '95.0.1020.44'
    AllowSingleSignOnUsingOSPrimaryAccount = False
    OnInitializationError = WVBrowser1InitializationError
    OnAfterCreated = WVBrowser1AfterCreated
    OnNewWindowRequested = WVBrowser1NewWindowRequested
    OnWebMessageReceived = WVBrowser1WebMessageReceived
    OnAcceleratorKeyPressed = WVBrowser1AcceleratorKeyPressed
    OnContextMenuRequested = WVBrowser1ContextMenuRequested
    OnCustomItemSelected = WVBrowser1CustomItemSelected
    Left = 200
    Top = 160
  end
end
