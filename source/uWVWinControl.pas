unit uWVWinControl;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  WinApi.Windows, System.Classes, Vcl.Controls, Vcl.Graphics;
  {$ELSE}
  Windows, Classes, Controls, Graphics;
  {$ENDIF}

type
  /// <summary>
  /// Parent control that will be used by TWVWindowParent in VCL and LCL applications to show the web contents.
  /// </summary>
  TWVWinControl = class(TWinControl)
    protected
      function  GetChildWindowHandle : THandle;
      procedure Resize; override;

    public
      /// <summary>
      /// Creates underlying screen object.
      /// </summary>
      procedure CreateHandle; override;
      /// <summary>
      /// Invalidates all child controls created by the browser.
      /// </summary>
      procedure InvalidateChildren;
      /// <summary>
      /// Updates the size of the child controls created by the browser.
      /// </summary>
      procedure UpdateSize; virtual;
      /// <summary>
      /// Handle of the first child control created by the browser.
      /// </summary>
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
      property  OnCanResize;
      {$ENDIF}
      {$IFDEF DELPHI14_UP}
      property  Touch;
      property  OnGesture;
      {$ENDIF}
      property  DoubleBuffered;
      {$IFDEF DELPHI12_UP}
      property  ParentDoubleBuffered;
      {$ENDIF}
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

procedure TWVWinControl.Resize;
begin
  inherited Resize;

  UpdateSize;
end;

end.
