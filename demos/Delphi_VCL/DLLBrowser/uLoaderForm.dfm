object LoaderForm: TLoaderForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WebView4Delphi Loader'
  ClientHeight = 234
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 15
  object InitializeBtn: TButton
    Left = 8
    Top = 8
    Width = 270
    Height = 50
    Caption = '(1) Initialize WebView4Delphi'
    TabOrder = 0
    OnClick = InitializeBtnClick
  end
  object ShowBtn: TButton
    Left = 8
    Top = 64
    Width = 270
    Height = 50
    Caption = '(2) Show web browser form'
    Enabled = False
    TabOrder = 1
    OnClick = ShowBtnClick
  end
  object CloseBtn: TButton
    Left = 8
    Top = 176
    Width = 270
    Height = 50
    Caption = '(4) Close this form'
    Enabled = False
    TabOrder = 2
    OnClick = CloseBtnClick
  end
  object FinalizeBtn: TButton
    Left = 8
    Top = 120
    Width = 271
    Height = 50
    Caption = '(3) Finalize WebView4Delphi'
    Enabled = False
    TabOrder = 3
    OnClick = FinalizeBtnClick
  end
end
