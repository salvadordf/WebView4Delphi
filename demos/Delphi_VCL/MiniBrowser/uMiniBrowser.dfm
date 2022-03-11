object MiniBrowserFrm: TMiniBrowserFrm
  Left = 0
  Top = 0
  Caption = 'MiniBrowser - Initializing...'
  ClientHeight = 717
  ClientWidth = 1119
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
  PixelsPerInch = 96
  TextHeight = 15
  object NavControlPnl: TPanel
    Left = 0
    Top = 0
    Width = 1119
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object NavButtonPnl: TPanel
      Left = 0
      Top = 0
      Width = 133
      Height = 41
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object BackBtn: TButton
        Left = 8
        Top = 8
        Width = 25
        Height = 25
        Caption = '3'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = BackBtnClick
      end
      object ForwardBtn: TButton
        Left = 39
        Top = 8
        Width = 25
        Height = 25
        Caption = '4'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = ForwardBtnClick
      end
      object ReloadBtn: TButton
        Left = 70
        Top = 8
        Width = 25
        Height = 25
        Caption = 'q'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ReloadBtnClick
      end
      object StopBtn: TButton
        Left = 101
        Top = 8
        Width = 25
        Height = 25
        Caption = '='
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = StopBtnClick
      end
    end
    object URLEditPnl: TPanel
      Left = 133
      Top = 0
      Width = 913
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      Padding.Top = 9
      Padding.Bottom = 8
      TabOrder = 1
      object URLCbx: TComboBox
        Left = 0
        Top = 9
        Width = 913
        Height = 23
        Align = alClient
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
          'https://frames-per-second.appspot.com/'
          'https://badssl.com/'
          'https://www.httpwatch.com/httpgallery/authentication/'
          'edge://flags/'
          'edge://gpu/'
          'edge://about/')
      end
    end
    object ConfigPnl: TPanel
      Left = 1046
      Top = 0
      Width = 73
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object ConfigBtn: TButton
        Left = 40
        Top = 8
        Width = 25
        Height = 25
        Caption = #8801
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = ConfigBtnClick
      end
      object GoBtn: TButton
        Left = 8
        Top = 8
        Width = 25
        Height = 25
        Caption = #9658
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = GoBtnClick
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 698
    Width = 1119
    Height = 19
    Panels = <
      item
        Width = 400
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 400
      end>
  end
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 41
    Width = 1119
    Height = 657
    Align = alClient
    TabStop = True
    TabOrder = 2
    Browser = WVBrowser1
  end
  object WVBrowser1: TWVBrowser
    DefaultURL = 'about:blank'
    TargetCompatibleBrowserVersion = '95.0.1020.44'
    AllowSingleSignOnUsingOSPrimaryAccount = False
    OnInitializationError = WVBrowser1InitializationError
    OnAfterCreated = WVBrowser1AfterCreated
    OnCapturePreviewCompleted = WVBrowser1CapturePreviewCompleted
    OnNavigationStarting = WVBrowser1NavigationStarting
    OnNavigationCompleted = WVBrowser1NavigationCompleted
    OnSourceChanged = WVBrowser1SourceChanged
    OnDocumentTitleChanged = WVBrowser1DocumentTitleChanged
    OnWebResourceRequested = WVBrowser1WebResourceRequested
    OnWebResourceResponseReceived = WVBrowser1WebResourceResponseReceived
    OnDownloadStarting = WVBrowser1DownloadStarting
    OnPrintToPdfCompleted = WVBrowser1PrintToPdfCompleted
    OnBytesReceivedChanged = WVBrowser1BytesReceivedChanged
    OnDownloadStateChanged = WVBrowser1DownloadStateChanged
    OnRetrieveHTMLCompleted = WVBrowser1RetrieveHTMLCompleted
    OnRetrieveTextCompleted = WVBrowser1RetrieveTextCompleted
    OnRetrieveMHTMLCompleted = WVBrowser1RetrieveMHTMLCompleted
    OnBasicAuthenticationRequested = WVBrowser1BasicAuthenticationRequested
    Left = 48
    Top = 64
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 48
    Top = 128
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 48
    Top = 200
    object LoadFromFileMi: TMenuItem
      Caption = 'Load from file...'
      OnClick = LoadFromFileMiClick
    end
    object SaveToFileMi: TMenuItem
      Caption = 'Save to file...'
      OnClick = SaveToFileMiClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Print1: TMenuItem
      Caption = 'Print...'
      OnClick = Print1Click
    end
    object Print2: TMenuItem
      Caption = 'Print to PDF...'
      OnClick = Print2Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Opentaskmanager1: TMenuItem
      Caption = 'Open task manager...'
      OnClick = Opentaskmanager1Click
    end
    object DevTools1: TMenuItem
      Caption = 'DevTools...'
      OnClick = DevTools1Click
    end
    object Zoom1: TMenuItem
      Caption = 'Zoom'
      object Inczoom1: TMenuItem
        Caption = 'Inc zoom'
        OnClick = Inczoom1Click
      end
      object Deczoom1: TMenuItem
        Caption = 'Dec zoom'
        OnClick = Deczoom1Click
      end
      object REsetzoom1: TMenuItem
        Caption = 'Reset zoom'
        OnClick = Resetzoom1Click
      end
    end
    object akesnapshot1: TMenuItem
      Caption = 'Take snapshot...'
      OnClick = Takesnapshot1Click
    end
    object Blockimages1: TMenuItem
      Caption = 'Block images'
      OnClick = Blockimages1Click
    end
    object ShowHTTPheaders1: TMenuItem
      Caption = 'Show HTTP headers...'
      OnClick = ShowHTTPheaders1Click
    end
    object Clearcache1: TMenuItem
      Caption = 'Clear cache'
      OnClick = Clearcache1Click
    end
    object Offline1: TMenuItem
      Caption = 'Offline'
      OnClick = Offline1Click
    end
    object Ignorecertificateerrors1: TMenuItem
      Caption = 'Ignore certificate errors'
      OnClick = Ignorecertificateerrors1Click
    end
    object Availablebrowserversion1: TMenuItem
      Caption = 'Available browser version...'
      OnClick = Availablebrowserversion1Click
    end
    object Changeuseragentstring1: TMenuItem
      Caption = 'Change user agent string...'
      OnClick = Changeuseragentstring1Click
    end
    object Muted1: TMenuItem
      Caption = 'Muted'
      OnClick = Muted1Click
    end
    object Browserprocesses1: TMenuItem
      Caption = 'Browser processes...'
      OnClick = Browserprocesses1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 272
  end
  object SaveDialog1: TSaveDialog
    Left = 48
    Top = 344
  end
end
