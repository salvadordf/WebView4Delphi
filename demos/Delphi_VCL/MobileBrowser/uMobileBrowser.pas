unit uMobileBrowser;

{$I ..\..\..\source\webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Samples.Spin, System.JSON,
  {$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  Mask, Spin, JSON,
  {$ENDIF}
  uWVBrowser, uWVWinControl, uWVWindowParent, uWVTypes, uWVConstants, uWVTypeLibrary,
  uWVLibFunctions, uWVLoader, uWVInterfaces, uWVCoreWebView2Args,
  uWVBrowserBase;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    AddressPnl: TPanel;
    GoBtn: TButton;
    Splitter1: TSplitter;
    LogMem: TMemo;
    Panel3: TPanel;
    CanEmulateBtn: TButton;
    ClearDeviceMetricsOverrideBtn: TButton;
    Panel4: TPanel;
    GroupBox1: TGroupBox;
    UserAgentCb: TComboBox;
    OverrideUserAgentBtn: TButton;
    EmulateTouchChk: TCheckBox;
    Panel5: TPanel;
    GroupBox2: TGroupBox;
    Panel6: TPanel;
    Label1: TLabel;
    HeightEdt: TSpinEdit;
    Panel7: TPanel;
    Label2: TLabel;
    WidthEdt: TSpinEdit;
    OverrideDeviceMetricsBtn: TButton;
    Panel8: TPanel;
    Label3: TLabel;
    ScaleEdt: TMaskEdit;
    Panel9: TPanel;
    Label4: TLabel;
    OrientationCb: TComboBox;
    Panel10: TPanel;
    Label5: TLabel;
    AngleEdt: TSpinEdit;
    AddressCb: TComboBox;
    WVWindowParent1: TWVWindowParent;
    WVBrowser1: TWVBrowser;

    procedure GoBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CanEmulateBtnClick(Sender: TObject);
    procedure OverrideUserAgentBtnClick(Sender: TObject);
    procedure EmulateTouchChkClick(Sender: TObject);
    procedure ClearDeviceMetricsOverrideBtnClick(Sender: TObject);
    procedure OverrideDeviceMetricsBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1CallDevToolsProtocolMethodCompleted(Sender: TObject; aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring; aExecutionID: Integer);

  protected
    // You have to handle this two messages to call NotifyMoveOrResizeStarted or some page elements will be misaligned.
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;

    procedure HandleSetUserAgentResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
    procedure HandleSetTouchEmulationEnabledResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
    procedure HandleCanEmulateResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
    procedure HandleClearDeviceMetricsOverrideResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
    procedure HandleSetDeviceMetricsOverrideResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

const
  DEVTOOLS_SETUSERAGENTOVERRIDE_ID       = 1;
  DEVTOOLS_SETTOUCHEMULATIONENABLED_ID   = 2;
  DEVTOOLS_CANEMULATE_ID                 = 3;
  DEVTOOLS_CLEARDEVICEMETRICSOVERRIDE_ID = 4;
  DEVTOOLS_SETDEVICEMETRICSOVERRIDE_ID   = 5;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
     else
      Timer1.Enabled := True;
end;

procedure TMainForm.CanEmulateBtnClick(Sender: TObject);
begin
  WVBrowser1.CallDevToolsProtocolMethod('Emulation.canEmulate', '{}', DEVTOOLS_CANEMULATE_ID);
end;

procedure TMainForm.ClearDeviceMetricsOverrideBtnClick(Sender: TObject);
begin
  WVBrowser1.CallDevToolsProtocolMethod('Emulation.clearDeviceMetricsOverride', '{}', DEVTOOLS_CLEARDEVICEMETRICSOVERRIDE_ID);
end;

procedure TMainForm.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.Navigate(AddressCb.Text);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  if GlobalWebView2Loader.Initialized then
    WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
   else
    Timer1.Enabled := True;
end;

procedure TMainForm.WMMove(var aMessage : TWMMove);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TMainForm.WMMoving(var aMessage : TMessage);
begin
  inherited;

  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TMainForm.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  WVWindowParent1.SetFocus;
  Caption := 'Mobile Browser';
  AddressPnl.Enabled := True;
end;

procedure TMainForm.WVBrowser1CallDevToolsProtocolMethodCompleted(
  Sender: TObject; aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring;
  aExecutionID: Integer);
begin
  case aExecutionID of
    DEVTOOLS_SETUSERAGENTOVERRIDE_ID       : HandleSetUserAgentResult(aErrorCode, aReturnObjectAsJson);
    DEVTOOLS_SETTOUCHEMULATIONENABLED_ID   : HandleSetTouchEmulationEnabledResult(aErrorCode, aReturnObjectAsJson);
    DEVTOOLS_CANEMULATE_ID                 : HandleCanEmulateResult(aErrorCode, aReturnObjectAsJson);
    DEVTOOLS_CLEARDEVICEMETRICSOVERRIDE_ID : HandleClearDeviceMetricsOverrideResult(aErrorCode, aReturnObjectAsJson);
    DEVTOOLS_SETDEVICEMETRICSOVERRIDE_ID   : HandleSetDeviceMetricsOverrideResult(aErrorCode, aReturnObjectAsJson);
  end;
end;

procedure TMainForm.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;

procedure TMainForm.HandleSetUserAgentResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
begin
  if succeeded(aErrorCode) then
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Successful SetUserAgentOverride');
      end)
   else
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Unsuccessful SetUserAgentOverride');
      end);
end;

procedure TMainForm.HandleSetTouchEmulationEnabledResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
begin
  if succeeded(aErrorCode) then
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Successful SetTouchEmulationEnabled');
      end)
   else
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Unsuccessful SetTouchEmulationEnabled');
      end);
end;

procedure TMainForm.HandleCanEmulateResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
var
  TempObject : TJSonObject;
  TempValue  : TJSonValue;
begin
  if succeeded(aErrorCode) and (aReturnObjectAsJson <> '') then
    begin
      TempObject  := TJSonObject.Create;
      TempValue   := TempObject.ParseJSONValue(aReturnObjectAsJson);

      if (TempValue as TJSONObject).Get('result').JSONValue.AsType<boolean> then
        TThread.ForceQueue(nil,
          procedure
          begin
            LogMem.Lines.Add('Successful CanEmulate. Emulation is supported.');
          end)
       else
        TThread.ForceQueue(nil,
          procedure
          begin
            LogMem.Lines.Add('Successful CanEmulate. Emulation is not supported.');
          end);

      TempObject.Free;
    end
   else
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Unsuccessful CanEmulate');
      end);
end;

procedure TMainForm.HandleClearDeviceMetricsOverrideResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
begin
  if succeeded(aErrorCode) then
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Successful ClearDeviceMetricsOverride');
      end)
   else
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Unsuccessful ClearDeviceMetricsOverride');
      end);
end;

procedure TMainForm.HandleSetDeviceMetricsOverrideResult(aErrorCode: HRESULT; const aReturnObjectAsJson: wvstring);
begin
  if succeeded(aErrorCode) then
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Successful SetDeviceMetricsOverride');
      end)
   else
    TThread.ForceQueue(nil,
      procedure
      begin
        LogMem.Lines.Add('Unsuccessful SetDeviceMetricsOverride');
      end);
end;

procedure TMainForm.EmulateTouchChkClick(Sender: TObject);
var
  TempObject : TJSonObject;
begin
  TempObject  := TJSonObject.Create;
  TempObject.AddPair('enabled', EmulateTouchChk.Checked);

  if EmulateTouchChk.Checked then
    TempObject.AddPair('maxTouchPoints', 2);

  WVBrowser1.CallDevToolsProtocolMethod('Emulation.setTouchEmulationEnabled', TempObject.ToString, DEVTOOLS_SETTOUCHEMULATIONENABLED_ID);
  TempObject.Free;
end;

procedure TMainForm.OverrideDeviceMetricsBtnClick(Sender: TObject);
var
  TempObject, TempValue : TJSonObject;
  TempFormatSettings : TFormatSettings;
  TempOrientation : string;
begin
  TempObject  := TJSonObject.Create;
  TempObject.AddPair('width',  WidthEdt.Value);
  TempObject.AddPair('height', HeightEdt.Value);

  TempFormatSettings := TFormatSettings.Create;
  TempFormatSettings.DecimalSeparator := '.';
  TempObject.AddPair('deviceScaleFactor', StrToFloat(ScaleEdt.Text, TempFormatSettings));

  TempObject.AddPair('mobile', True);

  case OrientationCb.ItemIndex of
    0 :  TempOrientation := 'portraitPrimary';
    1 :  TempOrientation := 'portraitSecondary';
    2 :  TempOrientation := 'landscapePrimary';
    else TempOrientation := 'landscapeSecondary';
  end;

  TempValue := TJSonObject.Create;
  TempValue.AddPair('type', TempOrientation);
  TempValue.AddPair('angle', AngleEdt.Value);

  TempObject.AddPair('screenOrientation', TempValue);

  WVBrowser1.CallDevToolsProtocolMethod('Emulation.setDeviceMetricsOverride', TempObject.ToString, DEVTOOLS_SETDEVICEMETRICSOVERRIDE_ID);
  TempObject.Free;
end;

procedure TMainForm.OverrideUserAgentBtnClick(Sender: TObject);
var
  TempObject, TempValue : TJSonObject;
  TempMetadataDict, TempBrandDict, TempFullVersionDict: TJSonObject;
  TempBrandsArray, TempFullVersionListArray : TJSONArray;
begin
  TempObject := TJSonObject.Create;

  TempBrandDict := TJSonObject.Create;
  TempBrandDict.AddPair('brand', 'Chromium');
  TempBrandDict.AddPair('version', '91');
  TempBrandsArray := TJSONArray.Create;
  TempBrandsArray.AddElement(TempBrandDict);

  TempFullVersionDict := TJSonObject.Create;
  TempFullVersionDict.AddPair('brand', 'Chromium');
  TempFullVersionDict.AddPair('version', '91.0.4472.114');
  TempFullVersionListArray := TJSONArray.Create;
  TempFullVersionListArray.AddElement(TempFullVersionDict);

  TempMetadataDict := TJSonObject.Create;
  TempMetadataDict.AddPair('brands', TempBrandsArray);
  TempMetadataDict.AddPair('fullVersionList', TempFullVersionListArray);
  TempMetadataDict.AddPair('fullVersion', '91.0.4472.114'); // Deprecated
  TempMetadataDict.AddPair('platform', 'Android'); //or Windows
  TempMetadataDict.AddPair('platformVersion', '12');
  TempMetadataDict.AddPair('architecture', 'arm');
  TempMetadataDict.AddPair('model', 'SM-F916N');
  TempMetadataDict.AddPair('mobile', true);
  TempMetadataDict.AddPair('bitness', '32');

  TempObject.AddPair('userAgent', UserAgentCb.Text);
  // Setting the userAgentMetadata value is optional and can be omited.
  // All the values in TempMetadataDict are just an example and they should be customized for each use case.
  TempObject.AddPair('userAgentMetadata', TempMetadataDict);

  WVBrowser1.CallDevToolsProtocolMethod('Emulation.setUserAgentOverride', TempObject.ToString, DEVTOOLS_SETUSERAGENTOVERRIDE_ID);
  TempObject.Free;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.StartWebView2;

end.
