object MDIChild: TMDIChild
  Left = 197
  Top = 117
  Caption = 'MDI Child'
  ClientHeight = 508
  ClientWidth = 784
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    DesignSize = (
      784
      24)
    object AddressCb: TComboBox
      Left = 0
      Top = 0
      Width = 732
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
      Left = 735
      Top = 0
      Width = 49
      Height = 24
      Align = alRight
      Caption = 'Go'
      TabOrder = 1
    end
  end
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 24
    Width = 784
    Height = 484
    Align = alClient
    TabOrder = 1
    Browser = WVBrowser1
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
