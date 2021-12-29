object BrowserFrame: TBrowserFrame
  Left = 0
  Top = 0
  Width = 1030
  Height = 758
  TabOrder = 0
  PixelsPerInch = 96
  object NavControlPnl: TPanel
    Left = 0
    Top = 0
    Width = 1030
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object NavButtonPnl: TPanel
      Left = 0
      Top = 0
      Width = 123
      Height = 35
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      object BackBtn: TButton
        Left = 5
        Top = 5
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
        Left = 35
        Top = 5
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
      end
      object ReloadBtn: TButton
        Left = 64
        Top = 5
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
      end
      object StopBtn: TButton
        Left = 93
        Top = 5
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
      Left = 123
      Top = 0
      Width = 872
      Height = 35
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        872
        35)
      object URLCbx: TComboBox
        Left = 2
        Top = 7
        Width = 868
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'https://www.bing.com'
        Items.Strings = (
          'https://www.bing.com'
          'https://www.google.com'
          
            'https://www.whatismybrowser.com/detect/what-http-headers-is-my-b' +
            'rowser-sending'
          'https://www.w3schools.com/js/tryit.asp?filename=tryjs_win_close'
          
            'https://www.w3schools.com/tags/tryit.asp?filename=tryhtml_a_targ' +
            'et'
          'https://www.w3schools.com/jsref/met_win_open.asp'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'open'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'open2'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'open3'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'open4'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'open5'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'open6'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'name'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_' +
            'opener'
          'https://www.w3schools.com/js/tryit.asp?filename=tryjs_alert'
          'https://www.w3schools.com/js/tryit.asp?filename=tryjs_loc_assign'
          
            'https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_styl' +
            'e_backgroundcolor'
          'https://www.w3schools.com/html/html5_video.asp'
          'http://www.adobe.com/software/flash/about/'
          'http://isflashinstalled.com/'
          'https://helpx.adobe.com/flash-player.html'
          'https://www.ultrasounds.com/'
          'https://www.whatismybrowser.com/detect/is-flash-installed'
          'http://html5test.com/'
          
            'https://webrtc.github.io/samples/src/content/devices/input-outpu' +
            't/'
          'https://test.webrtc.org/'
          'https://www.w3schools.com/'
          'http://webglsamples.org/'
          'https://get.webgl.org/'
          'https://www.briskbard.com'
          'https://www.youtube.com'
          'https://html5demos.com/drag/'
          
            'https://developers.google.com/maps/documentation/javascript/exam' +
            'ples/streetview-embed?hl=fr'
          
            'https://www.w3schools.com/Tags/tryit.asp?filename=tryhtml_iframe' +
            '_name'
          
            'http://www-db.deis.unibo.it/courses/TW/DOCS/w3schools/html/tryit' +
            '.asp-filename=tryhtml5_html_manifest.html'
          'https://www.browserleaks.com/webrtc'
          'https://frames-per-second.appspot.com/')
      end
    end
    object ConfigPnl: TPanel
      Left = 995
      Top = 0
      Width = 35
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object GoBtn: TButton
        Left = 5
        Top = 5
        Width = 25
        Height = 25
        Caption = #9658
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = GoBtnClick
      end
    end
  end
  object WVWindowParent1: TWVWindowParent
    Left = 0
    Top = 35
    Width = 1030
    Height = 723
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
    OnNavigationStarting = WVBrowser1NavigationStarting
    OnNavigationCompleted = WVBrowser1NavigationCompleted
    OnSourceChanged = WVBrowser1SourceChanged
    OnDocumentTitleChanged = WVBrowser1DocumentTitleChanged
    OnNewWindowRequested = WVBrowser1NewWindowRequested
    Left = 88
    Top = 152
  end
end
