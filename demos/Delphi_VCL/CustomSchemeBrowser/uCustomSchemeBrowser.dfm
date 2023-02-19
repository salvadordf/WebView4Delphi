object MainForm: TMainForm
  Left = 303
  Top = 133
  Caption = 'CustomSchemeBrowser - Initializing...'
  ClientHeight = 700
  ClientWidth = 995
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 23
    Width = 995
    Height = 677
    Align = alClient
    TabOrder = 1
    Browser = WVBrowser1
    ExplicitTop = 29
    ExplicitHeight = 676
  end
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 995
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object AddressCb: TComboBox
      Left = 0
      Top = 0
      Width = 870
      Height = 23
      Align = alClient
      ItemIndex = 0
      TabOrder = 0
      Text = 'myscheme://domain/CustomScheme.html'
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
      ExplicitLeft = -6
      ExplicitTop = -2
      ExplicitWidth = 945
    end
    object GoBtn: TButton
      Left = 945
      Top = 0
      Width = 50
      Height = 23
      Align = alRight
      Caption = 'Go'
      TabOrder = 1
      WordWrap = True
      OnClick = GoBtnClick
      ExplicitLeft = 941
      ExplicitHeight = 24
    end
    object DevToolsBtn: TButton
      Left = 870
      Top = 0
      Width = 75
      Height = 23
      Align = alRight
      Caption = 'DevTools'
      TabOrder = 2
      OnClick = DevToolsBtnClick
      ExplicitLeft = 904
      ExplicitHeight = 25
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
    DefaultURL = 'myscheme://domain/CustomScheme.html'
    TargetCompatibleBrowserVersion = '95.0.1020.44'
    AllowSingleSignOnUsingOSPrimaryAccount = False
    OnInitializationError = WVBrowser1InitializationError
    OnAfterCreated = WVBrowser1AfterCreated
    OnDocumentTitleChanged = WVBrowser1DocumentTitleChanged
    OnWebResourceRequested = WVBrowser1WebResourceRequested
    Left = 200
    Top = 160
  end
end
