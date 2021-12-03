unit uWVWinControl;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

interface

uses
  {$IFDEF FPC}
  Windows, Classes, Controls, Graphics;
  {$ELSE}
  WinApi.Windows, System.Classes, Vcl.Controls, Vcl.Graphics;
  {$ENDIF}

type
  TWVWinControl = class(TWinControl)
    protected
      function  GetChildWindowHandle : THandle;
      procedure Resize; override;

    public
      function  TakeSnapshot(var aBitmap : TBitmap) : boolean;
      procedure CreateHandle; override;
      procedure InvalidateChildren;
      procedure UpdateSize; virtual;

      property  ChildWindowHandle : THandle  read GetChildWindowHandle;

    published
      property  Align;
      property  Anchors;
      property  Color;
      property  Constraints;
      property  TabStop;
      property  TabOrder;
      property  Visible;
      property  Enabled;
      property  ShowHint;
      property  Hint;
      property  DragKind;
      property  DragCursor;
      property  DragMode;
      property  OnResize;
      property  OnEnter;
      property  OnExit;
      property  OnDragDrop;
      property  OnDragOver;
      property  OnStartDrag;
      property  OnEndDrag;
      {$IFNDEF FPC}
      property  Touch;
      property  OnGesture;
      {$ENDIF}
      property  DoubleBuffered;
      property  ParentDoubleBuffered;
  end;

implementation

function TWVWinControl.GetChildWindowHandle : THandle;
begin
  if not(csDesigning in ComponentState) and HandleAllocated then
    Result := GetWindow(Handle, GW_CHILD)
   else
    Result := 0;
end;

procedure TWVWinControl.CreateHandle;
begin
  inherited CreateHandle;
end;

procedure TWVWinControl.InvalidateChildren;
begin
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

procedure TWVWinControl.UpdateSize;
var
  TempRect : TRect;
  TempHWND : THandle;
begin
  TempHWND := ChildWindowHandle;
  if (TempHWND = 0) then exit;

  TempRect := GetClientRect;

  SetWindowPos(TempHWND, 0,
               0, 0, TempRect.right, TempRect.bottom,
               SWP_NOZORDER);
end;

function TWVWinControl.TakeSnapshot(var aBitmap : TBitmap) : boolean;
var
  TempHWND   : HWND;
  TempDC     : HDC;
  TempRect   : TRect;
  TempWidth  : Integer;
  TempHeight : Integer;
begin
  Result := False;
  if (aBitmap = nil) then exit;

  TempHWND := ChildWindowHandle;
  if (TempHWND = 0) then exit;

  {$IFNDEF FPC}Winapi.{$ENDIF}Windows.GetClientRect(TempHWND, TempRect);

  TempDC     := GetDC(TempHWND);
  TempWidth  := TempRect.Right  - TempRect.Left;
  TempHeight := TempRect.Bottom - TempRect.Top;

  aBitmap        := TBitmap.Create;
  aBitmap.Height := TempHeight;
  aBitmap.Width  := TempWidth;

  Result := BitBlt(aBitmap.Canvas.Handle, 0, 0, TempWidth, TempHeight,
                   TempDC, 0, 0, SRCCOPY);

  ReleaseDC(TempHWND, TempDC);
end;

procedure TWVWinControl.Resize;
begin
  inherited Resize;

  UpdateSize;
end;

end.
