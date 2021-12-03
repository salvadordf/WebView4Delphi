unit uBrowserTab;

interface

uses
  Winapi.Windows, System.Classes, Winapi.Messages, Vcl.ComCtrls, Vcl.Controls,
  Vcl.Forms, System.SysUtils, uBrowserFrame;

type
  TBrowserTab = class(TTabSheet)
    protected
      FBrowserFrame : TBrowserFrame;
      FTabID        : cardinal;

      function    GetInitialized : boolean;

      procedure   BrowserFrame_OnBrowserTitleChange(Sender: TObject; const aTitle : string);

    public
      constructor Create(AOwner: TComponent; aTabID : cardinal; const aCaption : string); reintroduce;
      procedure   NotifyParentWindowPositionChanged;
      procedure   CreateFrame(const aHomepage : string = '');
      procedure   CreateBrowser(const aHomepage : string);

      property    TabID             : cardinal   read FTabID;
      property    Initialized       : boolean    read GetInitialized;
  end;

implementation

uses
  uMainForm;

constructor TBrowserTab.Create(AOwner: TComponent; aTabID : cardinal; const aCaption : string);
begin
  inherited Create(AOwner);

  FTabID        := aTabID;
  Caption       := aCaption;
  FBrowserFrame := nil;
end;

function TBrowserTab.GetInitialized : boolean;
begin
  Result := (FBrowserFrame <> nil) and
            FBrowserFrame.Initialized;
end;

procedure TBrowserTab.NotifyParentWindowPositionChanged;
begin
  FBrowserFrame.NotifyParentWindowPositionChanged;
end;

procedure TBrowserTab.CreateFrame(const aHomepage : string);
begin
  if (FBrowserFrame = nil) then
    begin
      FBrowserFrame                      := TBrowserFrame.Create(self);
      FBrowserFrame.Name                 := 'BrowserFrame' + IntToStr(TabID);
      FBrowserFrame.Parent               := self;
      FBrowserFrame.Align                := alClient;
      FBrowserFrame.Visible              := True;
      FBrowserFrame.OnBrowserTitleChange := BrowserFrame_OnBrowserTitleChange;
      FBrowserFrame.CreateAllHandles;
    end;

  FBrowserFrame.Homepage := aHomepage;
end;

procedure TBrowserTab.CreateBrowser(const aHomepage : string);
begin
  CreateFrame(aHomepage);

  if (FBrowserFrame <> nil) then FBrowserFrame.CreateBrowser;
end;

procedure TBrowserTab.BrowserFrame_OnBrowserTitleChange(Sender: TObject; const aTitle : string);
begin
  Caption := aTitle;
end;

end.
