object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Cookie Manager - Initializing...'
  ClientHeight = 701
  ClientWidth = 1122
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
    Top = 24
    Width = 880
    Height = 677
    Align = alClient
    TabOrder = 1
    Browser = WVBrowser1
  end
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 1122
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    DesignSize = (
      1122
      24)
    object AddressCb: TComboBox
      Left = 0
      Top = 0
      Width = 1070
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ItemIndex = 0
      TabOrder = 0
      Text = 'https://www.bing.com'
      Items.Strings = (
        'https://www.bing.com'
        'https://www.google.com'
        
          'https://www.whatismybrowser.com/detect/what-http-headers-is-my-b' +
          'rowser-sending'
        'https://www.w3schools.com/js/tryit.asp?filename=tryjs_win_close'
        'https://www.w3schools.com/js/tryit.asp?filename=tryjs_alert'
        'https://www.w3schools.com/js/tryit.asp?filename=tryjs_loc_assign'
        
          'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_styl' +
          'e_backgroundcolor'
        
          'https://www.w3schools.com/Tags/tryit.asp?filename=tryhtml_iframe' +
          '_name'
        'https://www.w3schools.com/html/html5_video.asp'
        'http://html5test.com/'
        
          'https://webrtc.github.io/samples/src/content/devices/input-outpu' +
          't/'
        'https://test.webrtc.org/'
        'https://www.browserleaks.com/webrtc'
        'https://shaka-player-demo.appspot.com/demo/'
        'http://webglsamples.org/'
        'https://get.webgl.org/'
        'https://www.briskbard.com'
        'https://www.youtube.com'
        'https://html5demos.com/drag/'
        'https://frames-per-second.appspot.com/')
    end
    object GoBtn: TButton
      Left = 1073
      Top = 0
      Width = 49
      Height = 24
      Align = alRight
      Caption = 'Go'
      TabOrder = 1
      OnClick = GoBtnClick
    end
  end
  object Panel1: TPanel
    Left = 880
    Top = 24
    Width = 242
    Height = 677
    Align = alRight
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 2
    object Button1: TButton
      Left = 10
      Top = 10
      Width = 222
      Height = 25
      Align = alTop
      Caption = 'Get cookies'
      TabOrder = 0
      OnClick = Button1Click
    end
    object CookiesLb: TListBox
      Left = 10
      Top = 35
      Width = 222
      Height = 398
      Align = alTop
      ItemHeight = 15
      TabOrder = 1
    end
    object DeleteCookiesBtn: TButton
      Left = 10
      Top = 459
      Width = 222
      Height = 25
      Caption = 'Delete all cookies'
      TabOrder = 2
      OnClick = DeleteCookiesBtnClick
    end
    object AddCustomCookieBtn: TButton
      Left = 10
      Top = 506
      Width = 222
      Height = 25
      Caption = 'Add custom cookie'
      TabOrder = 3
      OnClick = AddCustomCookieBtnClick
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
    DefaultURL = 'https://www.bing.com'
    TargetCompatibleBrowserVersion = '95.0.1020.44'
    AllowSingleSignOnUsingOSPrimaryAccount = False
    OnInitializationError = WVBrowser1InitializationError
    OnAfterCreated = WVBrowser1AfterCreated
    OnGetCookiesCompleted = WVBrowser1GetCookiesCompleted
    Left = 200
    Top = 160
  end
end
