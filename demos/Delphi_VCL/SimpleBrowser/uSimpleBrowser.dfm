object MainForm: TMainForm
  Left = 303
  Top = 133
  Caption = 'SimpleBrowser - Initializing...'
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
    Top = 24
    Width = 995
    Height = 676
    Align = alClient
    TabStop = True
    TabOrder = 0
    Browser = WVBrowser1
    ExplicitWidth = 991
    ExplicitHeight = 675
  end
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 995
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 1
    ExplicitWidth = 991
    DesignSize = (
      995
      24)
    object AddressCb: TComboBox
      Left = 0
      Top = 0
      Width = 943
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
      ExplicitWidth = 939
    end
    object GoBtn: TButton
      Left = 945
      Top = 0
      Width = 50
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Go'
      TabOrder = 1
      WordWrap = True
      OnClick = GoBtnClick
      ExplicitLeft = 941
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
    OnDocumentTitleChanged = WVBrowser1DocumentTitleChanged
    Left = 200
    Top = 160
  end
end
