object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'SubscribeToDevToolsProtocolEventBrowser - Initializing...'
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
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 525
    Width = 995
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 24
    ExplicitWidth = 588
  end
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 24
    Width = 995
    Height = 501
    Align = alClient
    TabOrder = 1
    Browser = WVBrowser1
  end
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 995
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object AddressCb: TComboBox
      Left = 0
      Top = 0
      Width = 946
      Height = 23
      Align = alClient
      ItemIndex = 4
      TabOrder = 0
      Text = 'https://www.w3schools.com/js/tryit.asp?filename=tryjs_alert'
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
      Left = 946
      Top = 0
      Width = 49
      Height = 24
      Align = alRight
      Caption = 'Go'
      TabOrder = 1
      OnClick = GoBtnClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 528
    Width = 995
    Height = 173
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 2
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
    OnDocumentTitleChanged = WVBrowser1DocumentTitleChanged
    OnDevToolsProtocolEventReceived = WVBrowser1DevToolsProtocolEventReceived
    OnCallDevToolsProtocolMethodCompleted = WVBrowser1CallDevToolsProtocolMethodCompleted
    Left = 200
    Top = 160
  end
end
