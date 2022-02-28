unit uDirectCompositionHost;

interface

uses
  Winapi.Windows, System.SysUtils, System.Types, System.UITypes,
  System.Classes, System.Variants, Winapi.Messages,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts,
  uWVBrowserBase,
  WinApi.DirectX.DComp, WinApi.DirectX.DCommon; // MfPack component units

type
  TWVDirectCompositionHost = class(TLayout)
    protected
      FBrowser        : TWVBrowserBase;
      FDCompLibHandle : THandle;
      FDCompDevice    : IDCompositionDevice;
      FDCompTarget    : IDCompositionTarget;
      FRootVisual     : IDCompositionVisual;
      FWebViewVisual  : IDCompositionVisual;

      function DirectCompositionCreateDevice2(const renderingDevice: IUnknown; const iid: TGuid; out dcompositionDevice: Pointer): boolean;

    protected
      procedure Resize; override;

    public
      constructor Create(AOwner : TComponent); override;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;

      function CreateCompositionDevice : boolean;
      function CreateCompositionTarget(const aParentHandle : HWND) : boolean;
      function CreateRootVisual : boolean;
      function CreateWebViewVisual : boolean;

      function  BuildDCompTreeUsingVisual(const aParentHandle : HWND) : boolean;
      procedure DestroyDCompVisualTree;
      procedure UpdateSize;

      property Browser        : TWVBrowserBase      read FBrowser       write FBrowser;
      property DCompDevice    : IDCompositionDevice read FDCompDevice;
      property DCompTarget    : IDCompositionTarget read FDCompTarget;
      property RootVisual     : IDCompositionVisual read FRootVisual;
      property WebViewVisual  : IDCompositionVisual read FWebViewVisual;
  end;

implementation


uses
  FMX.Platform, FMX.Platform.Win,
  uWVMiscFunctions;

constructor TWVDirectCompositionHost.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FBrowser        := nil;
  FDCompLibHandle := 0;
  FDCompDevice    := nil;
  FDCompTarget    := nil;
  FRootVisual     := nil;
  FWebViewVisual  := nil;
end;

destructor TWVDirectCompositionHost.Destroy;
begin
  if (FDCompLibHandle <> 0) then
    FreeLibrary(FDCompLibHandle);

  inherited Destroy;
end;

procedure TWVDirectCompositionHost.AfterConstruction;
begin
  inherited AfterConstruction;

  CreateCompositionDevice;
end;

function TWVDirectCompositionHost.DirectCompositionCreateDevice2(const renderingDevice: IUnknown; const iid: TGuid; out dcompositionDevice: Pointer): boolean;
const
  DCompLib = 'dcomp.dll';
type
  TDCompositionCreateDevice2Func = function(const renderingDevice: IUnknown; const iid: TGuid; out dcompositionDevice: Pointer): HResult; stdcall;
var
  TempDCompositionCreateDevice2Func : TDCompositionCreateDevice2Func;
begin
  Result := False;

  try
    if (FDCompLibHandle = 0) then
      FDCompLibHandle := LoadLibrary(DCompLib);

    if (FDCompLibHandle <> 0) then
      begin
        {$IFDEF FPC}Pointer({$ENDIF}TempDCompositionCreateDevice2Func{$IFDEF FPC}){$ENDIF} := GetProcAddress(FDCompLibHandle, 'DCompositionCreateDevice2');

        Result := assigned(TempDCompositionCreateDevice2Func) and
                  succeeded(TempDCompositionCreateDevice2Func(renderingDevice, iid, dcompositionDevice)) and
                  assigned(dcompositionDevice);
      end;
  except
    on e : exception do
      if CustomExceptionHandler('DirectCompositionCreateDevice2', e) then raise;
  end;
end;

procedure TWVDirectCompositionHost.Resize;
begin
  inherited Resize;

  UpdateSize;
end;

function TWVDirectCompositionHost.CreateCompositionDevice : boolean;
const
  IID_IDCompositionDevice : TGUID = '{C37EA93A-E7AA-450D-B16F-9746CB0407F3}';
var
  TempPointer : Pointer;
begin
  Result      := False;
  TempPointer := nil;

  if DirectCompositionCreateDevice2(nil, IID_IDCompositionDevice, TempPointer) then
    begin
      FDCompDevice := IDCompositionDevice(TempPointer);
      Result       := True;
    end;
end;

function TWVDirectCompositionHost.CreateCompositionTarget(const aParentHandle : HWND) : boolean;
var
  TempResult : HRESULT;
begin
  Result := False;

  if assigned(FDCompDevice) and not(assigned(FWebViewVisual)) then
    begin
      TempResult := FDCompDevice.CreateTargetForHwnd(aParentHandle, True, FDCompTarget);
      Result     := succeeded(TempResult) and assigned(FDCompTarget);
    end;
end;

function TWVDirectCompositionHost.CreateRootVisual : boolean;
var
  TempResult : HRESULT;
begin
  Result := False;

  if assigned(FDCompDevice) and not(assigned(FRootVisual)) then
    begin
      TempResult := FDCompDevice.CreateVisual(FRootVisual);
      Result     := succeeded(TempResult) and assigned(FRootVisual);
    end;
end;

function TWVDirectCompositionHost.CreateWebViewVisual : boolean;
var
  TempResult : HRESULT;
begin
  Result := False;

  if assigned(FDCompDevice) and not(assigned(FWebViewVisual)) then
    begin
      TempResult := FDCompDevice.CreateVisual(FWebViewVisual);
      Result     := succeeded(TempResult) and assigned(FWebViewVisual);
    end;
end;

function TWVDirectCompositionHost.BuildDCompTreeUsingVisual(const aParentHandle : HWND) : boolean;
var
  TempResult : HRESULT;
begin
  Result := False;

  if assigned(FDCompDevice) and not(assigned(FWebViewVisual)) then
    begin
      if CreateCompositionTarget(aParentHandle) and CreateRootVisual then
        begin
          TempResult := FDCompTarget.SetRoot(FRootVisual);

          if succeeded(TempResult) and CreateWebViewVisual then
            begin
              TempResult := FRootVisual.AddVisual(FWebViewVisual, True, nil);
              Result     := succeeded(TempResult);
            end;
        end;
    end;
end;

procedure TWVDirectCompositionHost.DestroyDCompVisualTree;
begin
  if assigned(FWebViewVisual) then
    begin
      FWebViewVisual.RemoveAllVisuals;
      FWebViewVisual := nil;
    end;

  if assigned(FRootVisual) then
    begin
      FRootVisual.RemoveAllVisuals;
      FRootVisual := nil;
    end;

  if assigned(FDCompTarget) then
    begin
      FDCompTarget.SetRoot(nil);
      FDCompTarget := nil;
    end;

  if assigned(FDCompDevice) then
    FDCompDevice.Commit;
end;

procedure TWVDirectCompositionHost.UpdateSize;
var
  TempD2DRect : D2D_RECT_F;
begin
  if assigned(FDCompDevice) and assigned(FRootVisual) and assigned(FBrowser) then
    begin
      FBrowser.Bounds    := Rect(0, 0, round(Width), round(Height));

      TempD2DRect.Left   := 0;
      TempD2DRect.Top    := 0;
      TempD2DRect.Right  := Width;
      TempD2DRect.Bottom := Height;

      if succeeded(FRootVisual.SetOffsetX(AbsoluteRect.Left)) and
         succeeded(FRootVisual.SetOffsetY(AbsoluteRect.Top))  and
         succeeded(FRootVisual.SetClip(TempD2DRect))          then
        FDCompDevice.Commit;
    end;
end;

end.
