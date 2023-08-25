unit uWVCoreWebView2CustomSchemeRegistration;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.SysUtils, Winapi.ActiveX,
  {$ELSE}
  SysUtils, ActiveX,
  {$ENDIF}
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// <para>Represents the registration of a custom scheme with the
  /// CoreWebView2Environment.</para>
  /// <para>This allows the WebView2 app to be able to handle WebResourceRequested
  /// event for requests with the specified scheme and be able to navigate the
  /// WebView2 to the custom scheme.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customschemeregistration">See the ICoreWebView2CustomSchemeRegistration article.</see></para>
  /// </remarks>
  TCoreWebView2CustomSchemeRegistration = class(TInterfacedObject, ICoreWebView2CustomSchemeRegistration)
    protected
      FCustomSchemeInfo : TWVCustomSchemeInfo;

      // ICoreWebView2CustomSchemeRegistration
      function Get_SchemeName(out SchemeName: PWideChar): HResult; stdcall;
      function Get_TreatAsSecure(out TreatAsSecure: Integer): HResult; stdcall;
      function Set_TreatAsSecure(TreatAsSecure: Integer): HResult; stdcall;
      function GetAllowedOrigins(out allowedOriginsCount: SYSUINT; out allowedOrigins: PPWideChar): HResult; stdcall;
      function SetAllowedOrigins(allowedOriginsCount: SYSUINT; allowedOrigins: PPWideChar): HResult; stdcall;
      function Get_HasAuthorityComponent(out HasAuthorityComponent: Integer): HResult; stdcall;
      function Set_HasAuthorityComponent(HasAuthorityComponent: Integer): HResult; stdcall;

    public
      /// <summary>
      /// Constructor of the ICoreWebView2CustomSchemeRegistration wrapper.
      /// </summary>
      /// <param name="aCustomSchemeInfo">Record with all the information to register a custom scheme.</param>
      /// <remarks>
      /// <para><see cref="uWVTypes|TWVCustomSchemeInfo">See the TWVCustomSchemeInfo comments</see></para>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customschemeregistration">See the ICoreWebView2CustomSchemeRegistration article.</see></para>
      /// </remarks>
      constructor Create(const aCustomSchemeInfo : TWVCustomSchemeInfo); reintroduce; overload;
      /// <summary>
      /// Constructor of the ICoreWebView2CustomSchemeRegistration wrapper.
      /// </summary>
      /// <param name="aSchemeName">The name of the custom scheme to register.</param>
      /// <param name="aAllowedDomains">Comma separated list of origins that are allowed to issue requests with the custom scheme, such as XHRs and subresource requests that have an Origin header.</param>
      /// <param name="aTreatAsSecure">Whether the sites with this scheme will be treated as a Secure Context like an HTTPS site.</param>
      /// <param name="aHasAuthorityComponent">Set this property to true if the URIs with this custom scheme will have an authority component (a host for custom schemes)</param>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customschemeregistration">See the ICoreWebView2CustomSchemeRegistration article.</see></para>
      /// </remarks>
      constructor Create(const aSchemeName, aAllowedDomains : wvstring; aTreatAsSecure, aHasAuthorityComponent : boolean); reintroduce; overload;
  end;

implementation

uses
  uWVMiscFunctions;

constructor TCoreWebView2CustomSchemeRegistration.Create(const aCustomSchemeInfo : TWVCustomSchemeInfo);
begin
  inherited Create;

  FCustomSchemeInfo := aCustomSchemeInfo;
end;

constructor TCoreWebView2CustomSchemeRegistration.Create(const aSchemeName, aAllowedDomains : wvstring; aTreatAsSecure, aHasAuthorityComponent : boolean);
begin
  inherited Create;

  FCustomSchemeInfo.SchemeName            := aSchemeName;
  FCustomSchemeInfo.TreatAsSecure         := aTreatAsSecure;
  FCustomSchemeInfo.AllowedDomains        := aAllowedDomains;
  FCustomSchemeInfo.HasAuthorityComponent := aHasAuthorityComponent;
end;

function TCoreWebView2CustomSchemeRegistration.Get_SchemeName(out SchemeName: PWideChar): HResult; stdcall;
begin
  Result     := S_OK;
  SchemeName := AllocCoTaskMemStr(FCustomSchemeInfo.SchemeName);
end;

function TCoreWebView2CustomSchemeRegistration.Get_TreatAsSecure(out TreatAsSecure: Integer): HResult; stdcall;
begin
  Result        := S_OK;
  TreatAsSecure := ord(FCustomSchemeInfo.TreatAsSecure);
end;

function TCoreWebView2CustomSchemeRegistration.Set_TreatAsSecure(TreatAsSecure: Integer): HResult; stdcall;
begin
  Result                          := S_OK;
  FCustomSchemeInfo.TreatAsSecure := (TreatAsSecure <> 0);
end;

function TCoreWebView2CustomSchemeRegistration.GetAllowedOrigins(out allowedOriginsCount: SYSUINT; out allowedOrigins: PPWideChar): HResult; stdcall;
var
  i, j, TempSize : integer;
  TempOrigin : wvstring;
  TempArray : array of PWideChar;
begin
  Result              := S_OK;
  allowedOriginsCount := 0;
  allowedOrigins      := nil;

  if (FCustomSchemeInfo.AllowedDomains <> '') then
    begin
      j := 1;

      for i := 1 to Length(FCustomSchemeInfo.AllowedDomains) do
        if (FCustomSchemeInfo.AllowedDomains[i] = ',') or (i = Length(FCustomSchemeInfo.AllowedDomains)) then
          begin
            if (i > j) then
              begin
                if (i = Length(FCustomSchemeInfo.AllowedDomains)) then
                  TempOrigin := trim(copy(FCustomSchemeInfo.AllowedDomains, j, i - j + 1))
                 else
                  TempOrigin := trim(copy(FCustomSchemeInfo.AllowedDomains, j, i - j));

                if (length(TempOrigin) > 0) then
                  begin
                    SetLength(TempArray, succ(length(TempArray)));
                    TempArray[pred(length(TempArray))] := AllocCoTaskMemStr(TempOrigin);
                  end;
              end;

            j := succ(i);
          end;

      allowedOriginsCount := length(TempArray);

      if (allowedOriginsCount > 0) then
        begin
          TempSize       := allowedOriginsCount * SizeOf(PWideChar);
          allowedOrigins := CoTaskMemAlloc(TempSize);
          Move(TempArray[0], allowedOrigins^, TempSize);
        end;
    end;
end;

function TCoreWebView2CustomSchemeRegistration.SetAllowedOrigins(allowedOriginsCount: SYSUINT; allowedOrigins: PPWideChar): HResult; stdcall;
var
  TempArray : PPWideChar;
  TempOriginPtr : PWideChar;
  TempOrigin : wvstring;
  i : SYSUINT;
begin
  Result    := S_OK;
  i         := 0;
  TempArray := allowedOrigins;

  FCustomSchemeInfo.AllowedDomains := '';

  while (i < allowedOriginsCount) do
    begin
      TempOriginPtr := TempArray^;

      if (TempOriginPtr <> nil) then
        begin
          TempOrigin := TempOriginPtr;

          if (FCustomSchemeInfo.AllowedDomains = '') then
            FCustomSchemeInfo.AllowedDomains := TempOrigin
           else
            FCustomSchemeInfo.AllowedDomains := ',' + TempOrigin;

          CoTaskMemFree(TempOriginPtr);
        end;

      inc(TempArray);
      inc(i);
    end;

  CoTaskMemFree(allowedOrigins);
end;

function TCoreWebView2CustomSchemeRegistration.Get_HasAuthorityComponent(out HasAuthorityComponent: Integer): HResult; stdcall;
begin
  Result                := S_OK;
  HasAuthorityComponent := ord(FCustomSchemeInfo.HasAuthorityComponent);
end;

function TCoreWebView2CustomSchemeRegistration.Set_HasAuthorityComponent(HasAuthorityComponent: Integer): HResult; stdcall;
begin
  Result                                  := S_OK;
  FCustomSchemeInfo.HasAuthorityComponent := (HasAuthorityComponent <> 0);
end;


end.
