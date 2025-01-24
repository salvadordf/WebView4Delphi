unit uWVWindowParent;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  WinApi.Windows, System.Classes, Vcl.Controls, WinApi.Messages,
  {$ELSE}
  Windows, Classes, Controls, {$IFDEF FPC}LMessages, LResources,{$ELSE} Messages,{$ENDIF}
  {$ENDIF}
  uWVWinControl, uWVBrowserBase;

type
  {$IFNDEF FPC}{$IFDEF DELPHI16_UP}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}{$ENDIF}
  /// <summary>
  /// Parent control used by VCL and LCL applications to show the web contents.
  /// </summary>
  TWVWindowParent = class(TWVWinControl)
    protected
      FBrowser : TWVBrowserBase;

      function  GetBrowser : TWVBrowserBase;

      procedure SetBrowser(const aValue : TWVBrowserBase);

      procedure WndProc(var aMessage: TMessage); override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      procedure Resize; override;

    public
      constructor Create(AOwner : TComponent); override;
      procedure   UpdateSize; override;
      /// <summary>
      /// Moves focus into WebView.
      /// </summary>
      procedure   SetFocus; override;

    published
      /// <summary>
      /// Browser associated to this control to show web contents.
      /// </summary>
      property Browser     : TWVBrowserBase   read GetBrowser     write SetBrowser;
  end;

{$IFDEF FPC}
procedure Register;
{$ENDIF}

implementation

constructor TWVWindowParent.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FBrowser := nil;
end;

procedure TWVWindowParent.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent = FBrowser) then
    FBrowser := nil;
end;

procedure TWVWindowParent.Resize;
begin
  inherited Resize;

  UpdateSize;
end;

function TWVWindowParent.GetBrowser: TWVBrowserBase;
begin
  Result := FBrowser;
end;

procedure TWVWindowParent.SetBrowser(const aValue : TWVBrowserBase);
begin
  FBrowser := aValue;

  if (aValue <> nil) then
    aValue.FreeNotification(Self);
end;

procedure TWVWindowParent.UpdateSize;
begin
  if (FBrowser <> nil) then
    FBrowser.Bounds := ClientRect
   else
    inherited UpdateSize;
end;

procedure TWVWindowParent.SetFocus;
begin
  inherited SetFocus;

  if (FBrowser <> nil) then
    FBrowser.SetFocus;
end;

procedure TWVWindowParent.WndProc(var aMessage: TMessage);
var
  tmpVisible: boolean;
begin
  case aMessage.Msg of
    WM_SETFOCUS:
      begin
        if (FBrowser <> nil) then
          FBrowser.SetFocus;

        inherited WndProc(aMessage);
      end;

    WM_ERASEBKGND:
      if (ChildWindowHandle = 0) then
        inherited WndProc(aMessage);

    CM_RECREATEWND:  // #75: this VCL quirk kills CEF/WebView2 instantly
      begin
        if (FBrowser <> nil) then
          begin
            tmpVisible := FBrowser.IsVisible;
            if tmpVisible then
              FBrowser.IsVisible := False; // avoid flicker, 0 is GetDesktopHWND
            FBrowser.ParentWindow := 0;
          end
        else
          tmpVisible := False;  // avoid compiler warning
        try
          inherited WndProc(aMessage);
        finally
          if (FBrowser <> nil) then
            begin
              FBrowser.ParentWindow := Self.Handle;
              FBrowser.IsVisible := tmpVisible;
            end;
        end;
      end;

    else inherited WndProc(aMessage);
  end;
end;

{$IFDEF FPC}
procedure Register;
begin
  {$I res/twvwindowparent.lrs}
  RegisterComponents('WebView4Delphi', [TWVWindowParent]);
end;
{$ENDIF}

end.
