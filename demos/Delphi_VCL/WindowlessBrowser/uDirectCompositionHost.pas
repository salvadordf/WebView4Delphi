unit uDirectCompositionHost;

interface

uses
  WinApi.Windows, System.Classes, System.SysUtils,
  uWVWindowParent,
  WinApi.DirectX.DComp, WinApi.DirectX.DCommon; // MfPack component units

type
  TWVDirectCompositionHost = class(TWVWindowParent)
    protected
      FDCompLibHandle : THandle;
      FDCompDevice    : IDCompositionDevice;
      FDCompTarget    : IDCompositionTarget;
      FRootVisual     : IDCompositionVisual;
      FWebViewVisual  : IDCompositionVisual;

      function DirectCompositionCreateDevice2(const renderingDevice: IUnknown; const iid: TGuid; out dcompositionDevice: Pointer): boolean;

    public
      constructor Create(AOwner : TComponent); override;
      destructor  Destroy; override;
      procedure   AfterConstruction; override;

      function CreateCompositionDevice : boolean;
      function CreateCompositionTarget : boolean;
      function CreateRootVisual : boolean;
      function CreateWebViewVisual : boolean;

      function  BuildDCompTreeUsingVisual : boolean;
      procedure DestroyDCompVisualTree;
      procedure UpdateSize; override;

      property DCompDevice    : IDCompositionDevice read FDCompDevice;
      property DCompTarget    : IDCompositionTarget read FDCompTarget;
      property RootVisual     : IDCompositionVisual read FRootVisual;
      property WebViewVisual  : IDCompositionVisual read FWebViewVisual;
  end;

implementation

uses
  uWVMiscFunctions;

constructor TWVDirectCompositionHost.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

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

function TWVDirectCompositionHost.CreateCompositionDevice : boolean;
const
  IID_IDCompositionDevice: TGUID = '{C37EA93A-E7AA-450D-B16F-9746CB0407F3}';
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

function TWVDirectCompositionHost.CreateCompositionTarget : boolean;
var
  TempResult  : HRESULT;
begin
  Result := False;

  if assigned(FDCompDevice) and not(assigned(FWebViewVisual)) then
    begin
      TempResult := FDCompDevice.CreateTargetForHwnd(Handle, True, FDCompTarget);
      Result     := succeeded(TempResult) and assigned(FDCompTarget);
    end;
end;

function TWVDirectCompositionHost.CreateRootVisual : boolean;
var
  TempResult  : HRESULT;
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
  TempResult  : HRESULT;
begin
  Result := False;

  if assigned(FDCompDevice) and not(assigned(FWebViewVisual)) then
    begin
      TempResult := FDCompDevice.CreateVisual(FWebViewVisual);
      Result     := succeeded(TempResult) and assigned(FWebViewVisual);
    end;
end;

function TWVDirectCompositionHost.BuildDCompTreeUsingVisual : boolean;
var
  TempResult : HRESULT;
begin
  Result := False;

  if assigned(FDCompDevice) and not(assigned(FWebViewVisual)) then
    begin
      if CreateCompositionTarget and CreateRootVisual then
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
  TempRect    : TRect;
  TempD2DRect : D2D_RECT_F;
  TempResult  : HRESULT;
begin
  inherited UpdateSize;

  if assigned(FDCompDevice) and assigned(FRootVisual) then
    begin
      TempRect := ClientRect;

      TempD2DRect.Left   := 0;
      TempD2DRect.Top    := 0;
      TempD2DRect.Right  := Width;
      TempD2DRect.Bottom := Height;

      TempResult := FRootVisual.SetOffsetX(TempRect.Left);

      if succeeded(TempResult) then
        begin
          TempResult := FRootVisual.SetOffsetY(TempRect.Top);

          if succeeded(TempResult) then
            begin
              TempResult := FRootVisual.SetClip(TempD2DRect);

              if succeeded(TempResult) then
                FDCompDevice.Commit;
            end;
        end;
    end;
end;

end.
