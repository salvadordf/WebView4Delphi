unit uWVTypeLibrary;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Winapi.ActiveX;
  {$ELSE}
  Windows, Classes, Variants, Graphics, ActiveX;
  {$ENDIF}

const
  /// <summary>
  /// TypeLibrary major version
  /// </summary>
  WebView2MajorVersion = 1;
  /// <summary>
  /// TypeLibrary minor version
  /// </summary>
  WebView2MinorVersion = 0;

  LIBID_WebView2: TGUID = '{26D34152-879F-4065-BEA2-3DAA2CFADFB8}';

  IID_ICoreWebView2AcceleratorKeyPressedEventArgs: TGUID = '{9F760F8A-FB79-42BE-9990-7B56900FA9C7}';
  IID_ICoreWebView2AcceleratorKeyPressedEventHandler: TGUID = '{B29C7E28-FA79-41A8-8E44-65811C76DCB2}';
  IID_ICoreWebView2Controller: TGUID = '{4D00C0D1-9434-4EB6-8078-8697A560334F}';
  IID_ICoreWebView2ZoomFactorChangedEventHandler: TGUID = '{B52D71D6-C4DF-4543-A90C-64A3E60F38CB}';
  IID_ICoreWebView2MoveFocusRequestedEventHandler: TGUID = '{69035451-6DC7-4CB8-9BCE-B2BD70AD289F}';
  IID_ICoreWebView2MoveFocusRequestedEventArgs: TGUID = '{2D6AA13B-3839-4A15-92FC-D88B3C0D9C9D}';
  IID_ICoreWebView2FocusChangedEventHandler: TGUID = '{05EA24BD-6452-4926-9014-4B82B498135D}';
  IID_ICoreWebView2: TGUID = '{76ECEACB-0462-4D94-AC83-423A6793775E}';
  IID_ICoreWebView2Settings: TGUID = '{E562E4F0-D7FA-43AC-8D71-C05150499F00}';
  IID_ICoreWebView2NavigationStartingEventHandler: TGUID = '{9ADBE429-F36D-432B-9DDC-F8881FBD76E3}';
  IID_ICoreWebView2NavigationStartingEventArgs: TGUID = '{5B495469-E119-438A-9B18-7604F25F2E49}';
  IID_ICoreWebView2HttpRequestHeaders: TGUID = '{E86CAC0E-5523-465C-B536-8FB9FC8C8C60}';
  IID_ICoreWebView2HttpHeadersCollectionIterator: TGUID = '{0702FC30-F43B-47BB-AB52-A42CB552AD9F}';
  IID_ICoreWebView2ContentLoadingEventHandler: TGUID = '{364471E7-F2BE-4910-BDBA-D72077D51C4B}';
  IID_ICoreWebView2ContentLoadingEventArgs: TGUID = '{0C8A1275-9B6B-4901-87AD-70DF25BAFA6E}';
  IID_ICoreWebView2SourceChangedEventHandler: TGUID = '{3C067F9F-5388-4772-8B48-79F7EF1AB37C}';
  IID_ICoreWebView2SourceChangedEventArgs: TGUID = '{31E0E545-1DBA-4266-8914-F63848A1F7D7}';
  IID_ICoreWebView2HistoryChangedEventHandler: TGUID = '{C79A420C-EFD9-4058-9295-3E8B4BCAB645}';
  IID_ICoreWebView2NavigationCompletedEventHandler: TGUID = '{D33A35BF-1C49-4F98-93AB-006E0533FE1C}';
  IID_ICoreWebView2NavigationCompletedEventArgs: TGUID = '{30D68B7D-20D9-4752-A9CA-EC8448FBB5C1}';
  IID_ICoreWebView2ScriptDialogOpeningEventHandler: TGUID = '{EF381BF9-AFA8-4E37-91C4-8AC48524BDFB}';
  IID_ICoreWebView2ScriptDialogOpeningEventArgs: TGUID = '{7390BB70-ABE0-4843-9529-F143B31B03D6}';
  IID_ICoreWebView2Deferral: TGUID = '{C10E7F7B-B585-46F0-A623-8BEFBF3E4EE0}';
  IID_ICoreWebView2PermissionRequestedEventHandler: TGUID = '{15E1C6A3-C72A-4DF3-91D7-D097FBEC6BFD}';
  IID_ICoreWebView2PermissionRequestedEventArgs: TGUID = '{973AE2EF-FF18-4894-8FB2-3C758F046810}';
  IID_ICoreWebView2ProcessFailedEventHandler: TGUID = '{79E0AEA4-990B-42D9-AA1D-0FCC2E5BC7F1}';
  IID_ICoreWebView2ProcessFailedEventArgs: TGUID = '{8155A9A4-1474-4A86-8CAE-151B0FA6B8CA}';
  IID_ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler: TGUID = '{B99369F3-9B11-47B5-BC6F-8E7895FCEA17}';
  IID_ICoreWebView2ExecuteScriptCompletedHandler: TGUID = '{49511172-CC67-4BCA-9923-137112F4C4CC}';
  IID_ICoreWebView2CapturePreviewCompletedHandler: TGUID = '{697E05E9-3D8F-45FA-96F4-8FFE1EDEDAF5}';
  IID_ICoreWebView2WebMessageReceivedEventHandler: TGUID = '{57213F19-00E6-49FA-8E07-898EA01ECBD2}';
  IID_ICoreWebView2WebMessageReceivedEventArgs: TGUID = '{0F99A40C-E962-4207-9E92-E3D542EFF849}';
  IID_ICoreWebView2CallDevToolsProtocolMethodCompletedHandler: TGUID = '{5C4889F0-5EF6-4C5A-952C-D8F1B92D0574}';
  IID_ICoreWebView2DevToolsProtocolEventReceiver: TGUID = '{B32CA51A-8371-45E9-9317-AF021D080367}';
  IID_ICoreWebView2DevToolsProtocolEventReceivedEventHandler: TGUID = '{E2FDA4BE-5456-406C-A261-3D452138362C}';
  IID_ICoreWebView2DevToolsProtocolEventReceivedEventArgs: TGUID = '{653C2959-BB3A-4377-8632-B58ADA4E66C4}';
  IID_ICoreWebView2NewWindowRequestedEventHandler: TGUID = '{D4C185FE-C81C-4989-97AF-2D3FA7AB5651}';
  IID_ICoreWebView2NewWindowRequestedEventArgs: TGUID = '{34ACB11C-FC37-4418-9132-F9C21D1EAFB9}';
  IID_ICoreWebView2WindowFeatures: TGUID = '{5EAF559F-B46E-4397-8860-E422F287FF1E}';
  IID_ICoreWebView2DocumentTitleChangedEventHandler: TGUID = '{F5F2B923-953E-4042-9F95-F3A118E1AFD4}';
  IID_ICoreWebView2ContainsFullScreenElementChangedEventHandler: TGUID = '{E45D98B1-AFEF-45BE-8BAF-6C7728867F73}';
  IID_ICoreWebView2WebResourceRequestedEventHandler: TGUID = '{AB00B74C-15F1-4646-80E8-E76341D25D71}';
  IID_ICoreWebView2WebResourceRequestedEventArgs: TGUID = '{453E667F-12C7-49D4-BE6D-DDBE7956F57A}';
  IID_ICoreWebView2WebResourceRequest: TGUID = '{97055CD4-512C-4264-8B5F-E3F446CEA6A5}';
  IID_ICoreWebView2WebResourceResponse: TGUID = '{AAFCC94F-FA27-48FD-97DF-830EF75AAEC9}';
  IID_ICoreWebView2HttpResponseHeaders: TGUID = '{03C5FF5A-9B45-4A88-881C-89A9F328619C}';
  IID_ICoreWebView2WindowCloseRequestedEventHandler: TGUID = '{5C19E9E0-092F-486B-AFFA-CA8231913039}';
  IID_ICoreWebView2_2: TGUID = '{9E8F0CF8-E670-4B5E-B2BC-73E061E3184C}';
  IID_ICoreWebView2WebResourceResponseReceivedEventHandler: TGUID = '{7DE9898A-24F5-40C3-A2DE-D4F458E69828}';
  IID_ICoreWebView2WebResourceResponseReceivedEventArgs: TGUID = '{D1DB483D-6796-4B8B-80FC-13712BB716F4}';
  IID_ICoreWebView2WebResourceResponseView: TGUID = '{79701053-7759-4162-8F7D-F1B3F084928D}';
  IID_ICoreWebView2WebResourceResponseViewGetContentCompletedHandler: TGUID = '{875738E1-9FA2-40E3-8B74-2E8972DD6FE7}';
  IID_ICoreWebView2DOMContentLoadedEventHandler: TGUID = '{4BAC7E9C-199E-49ED-87ED-249303ACF019}';
  IID_ICoreWebView2DOMContentLoadedEventArgs: TGUID = '{16B1E21A-C503-44F2-84C9-70ABA5031283}';
  IID_ICoreWebView2CookieManager: TGUID = '{177CD9E7-B6F5-451A-94A0-5D7A3A4C4141}';
  IID_ICoreWebView2Cookie: TGUID = '{AD26D6BE-1486-43E6-BF87-A2034006CA21}';
  IID_ICoreWebView2GetCookiesCompletedHandler: TGUID = '{5A4F5069-5C15-47C3-8646-F4DE1C116670}';
  IID_ICoreWebView2CookieList: TGUID = '{F7F6F714-5D2A-43C6-9503-346ECE02D186}';
  IID_ICoreWebView2Environment: TGUID = '{B96D755E-0319-4E92-A296-23436F46A1FC}';
  IID_ICoreWebView2CreateCoreWebView2ControllerCompletedHandler: TGUID = '{6C4819F3-C9B7-4260-8127-C9F5BDE7F68C}';
  IID_ICoreWebView2NewBrowserVersionAvailableEventHandler: TGUID = '{F9A2976E-D34E-44FC-ADEE-81B6B57CA914}';
  IID_ICoreWebView2_3: TGUID = '{A0D6DF20-3B92-416D-AA0C-437A9C727857}';
  IID_ICoreWebView2TrySuspendCompletedHandler: TGUID = '{00F206A7-9D17-4605-91F6-4E8E4DE192E3}';
  IID_ICoreWebView2_4: TGUID = '{20D02D59-6DF2-42DC-BD06-F98A694B1302}';
  IID_ICoreWebView2FrameCreatedEventHandler: TGUID = '{38059770-9BAA-11EB-A8B3-0242AC130003}';
  IID_ICoreWebView2FrameCreatedEventArgs: TGUID = '{4D6E7B5E-9BAA-11EB-A8B3-0242AC130003}';
  IID_ICoreWebView2Frame: TGUID = '{F1131A5E-9BA9-11EB-A8B3-0242AC130003}';
  IID_ICoreWebView2FrameNameChangedEventHandler: TGUID = '{435C7DC8-9BAA-11EB-A8B3-0242AC130003}';
  IID_ICoreWebView2FrameDestroyedEventHandler: TGUID = '{59DD7B4C-9BAA-11EB-A8B3-0242AC130003}';
  IID_ICoreWebView2DownloadStartingEventHandler: TGUID = '{EFEDC989-C396-41CA-83F7-07F845A55724}';
  IID_ICoreWebView2DownloadStartingEventArgs: TGUID = '{E99BBE21-43E9-4544-A732-282764EAFA60}';
  IID_ICoreWebView2DownloadOperation: TGUID = '{3D6B6CF2-AFE1-44C7-A995-C65117714336}';
  IID_ICoreWebView2BytesReceivedChangedEventHandler: TGUID = '{828E8AB6-D94C-4264-9CEF-5217170D6251}';
  IID_ICoreWebView2EstimatedEndTimeChangedEventHandler: TGUID = '{28F0D425-93FE-4E63-9F8D-2AEEC6D3BA1E}';
  IID_ICoreWebView2StateChangedEventHandler: TGUID = '{81336594-7EDE-4BA9-BF71-ACF0A95B58DD}';
  IID_ICoreWebView2_5: TGUID = '{BEDB11B8-D63C-11EB-B8BC-0242AC130003}';
  IID_ICoreWebView2ClientCertificateRequestedEventHandler: TGUID = '{D7175BA2-BCC3-11EB-8529-0242AC130003}';
  IID_ICoreWebView2ClientCertificateRequestedEventArgs: TGUID = '{BC59DB28-BCC3-11EB-8529-0242AC130003}';
  IID_ICoreWebView2StringCollection: TGUID = '{F41F3F8A-BCC3-11EB-8529-0242AC130003}';
  IID_ICoreWebView2ClientCertificateCollection: TGUID = '{EF5674D2-BCC3-11EB-8529-0242AC130003}';
  IID_ICoreWebView2ClientCertificate: TGUID = '{E7188076-BCC3-11EB-8529-0242AC130003}';
  IID_ICoreWebView2_6: TGUID = '{499AADAC-D92C-4589-8A75-111BFC167795}';
  IID_ICoreWebView2_7: TGUID = '{79C24D83-09A3-45AE-9418-487F32A58740}';
  IID_ICoreWebView2PrintSettings: TGUID = '{377F3721-C74E-48CA-8DB1-DF68E51D60E2}';
  IID_ICoreWebView2PrintToPdfCompletedHandler: TGUID = '{CCF1EF04-FD8E-4D5F-B2DE-0983E41B8C36}';
  IID_ICoreWebView2_8: TGUID = '{E9632730-6E1E-43AB-B7B8-7B2C9E62E094}';
  IID_ICoreWebView2IsMutedChangedEventHandler: TGUID = '{57D90347-CD0E-4952-A4A2-7483A2756F08}';
  IID_ICoreWebView2IsDocumentPlayingAudioChangedEventHandler: TGUID = '{5DEF109A-2F4B-49FA-B7F6-11C39E513328}';
  IID_ICoreWebView2_9: TGUID = '{4D7B2EAB-9FDC-468D-B998-A9260B5ED651}';
  IID_ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler: TGUID = '{3117DA26-AE13-438D-BD46-EDBEB2C4CE81}';
  IID_ICoreWebView2_10: TGUID = '{B1690564-6F5A-4983-8E48-31D1143FECDB}';
  IID_ICoreWebView2BasicAuthenticationRequestedEventHandler: TGUID = '{58B4D6C2-18D4-497E-B39B-9A96533FA278}';
  IID_ICoreWebView2BasicAuthenticationRequestedEventArgs: TGUID = '{EF05516F-D897-4F9E-B672-D8E2307A3FB0}';
  IID_ICoreWebView2BasicAuthenticationResponse: TGUID = '{07023F7D-2D77-4D67-9040-6E7D428C6A40}';
  IID_ICoreWebView2_11: TGUID = '{0BE78E56-C193-4051-B943-23B460C08BDB}';
  IID_ICoreWebView2ContextMenuRequestedEventHandler: TGUID = '{04D3FE1D-AB87-42FB-A898-DA241D35B63C}';
  IID_ICoreWebView2ContextMenuRequestedEventArgs: TGUID = '{A1D309EE-C03F-11EB-8529-0242AC130003}';
  IID_ICoreWebView2ContextMenuItemCollection: TGUID = '{F562A2F5-C415-45CF-B909-D4B7C1E276D3}';
  IID_ICoreWebView2ContextMenuItem: TGUID = '{7AED49E3-A93F-497A-811C-749C6B6B6C65}';
  IID_ICoreWebView2CustomItemSelectedEventHandler: TGUID = '{49E1D0BC-FE9E-4481-B7C2-32324AA21998}';
  IID_ICoreWebView2ContextMenuTarget: TGUID = '{B8611D99-EED6-4F3F-902C-A198502AD472}';
  IID_ICoreWebView2_12: TGUID = '{35D69927-BCFA-4566-9349-6B3E0D154CAC}';
  IID_ICoreWebView2StatusBarTextChangedEventHandler: TGUID = '{A5E3B0D0-10DF-4156-BFAD-3B43867ACAC6}';
  IID_ICoreWebView2_13: TGUID = '{F75F09A8-667E-4983-88D6-C8773F315E84}';
  IID_ICoreWebView2Profile: TGUID = '{79110AD3-CD5D-4373-8BC3-C60658F17A5F}';
  IID_ICoreWebView2_14: TGUID = '{6DAA4F10-4A90-4753-8898-77C5DF534165}';
  IID_ICoreWebView2ServerCertificateErrorDetectedEventHandler: TGUID = '{969B3A26-D85E-4795-8199-FEF57344DA22}';
  IID_ICoreWebView2ServerCertificateErrorDetectedEventArgs: TGUID = '{012193ED-7C13-48FF-969D-A84C1F432A14}';
  IID_ICoreWebView2Certificate: TGUID = '{C5FB2FCE-1CAC-4AEE-9C79-5ED0362EAAE0}';
  IID_ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler: TGUID = '{3B40AAC6-ACFE-4FFD-8211-F607B96E2D5B}';
  IID_ICoreWebView2_15: TGUID = '{517B2D1D-7DAE-4A66-A4F4-10352FFB9518}';
  IID_ICoreWebView2FaviconChangedEventHandler: TGUID = '{2913DA94-833D-4DE0-8DCA-900FC524A1A4}';
  IID_ICoreWebView2GetFaviconCompletedHandler: TGUID = '{A2508329-7DA8-49D7-8C05-FA125E4AEE8D}';
  IID_ICoreWebView2_16: TGUID = '{0EB34DC9-9F91-41E1-8639-95CD5943906B}';
  IID_ICoreWebView2PrintCompletedHandler: TGUID = '{8FD80075-ED08-42DB-8570-F5D14977461E}';
  IID_ICoreWebView2PrintToPdfStreamCompletedHandler: TGUID = '{4C9F8229-8F93-444F-A711-2C0DFD6359D5}';
  IID_ICoreWebView2_17: TGUID = '{702E75D4-FD44-434D-9D70-1A68A6B1192A}';
  IID_ICoreWebView2SharedBuffer: TGUID = '{B747A495-0C6F-449E-97B8-2F81E9D6AB43}';
  IID_ICoreWebView2_18: TGUID = '{7A626017-28BE-49B2-B865-3BA2B3522D90}';
  IID_ICoreWebView2LaunchingExternalUriSchemeEventHandler: TGUID = '{74F712E0-8165-43A9-A13F-0CCE597E75DF}';
  IID_ICoreWebView2LaunchingExternalUriSchemeEventArgs: TGUID = '{07D1A6C3-7175-4BA1-9306-E593CA07E46C}';
  IID_ICoreWebView2BrowserProcessExitedEventArgs: TGUID = '{1F00663F-AF8C-4782-9CDD-DD01C52E34CB}';
  IID_ICoreWebView2BrowserProcessExitedEventHandler: TGUID = '{FA504257-A216-4911-A860-FE8825712861}';
  IID_ICoreWebView2CompositionController: TGUID = '{3DF9B733-B9AE-4A15-86B4-EB9EE9826469}';
  IID_ICoreWebView2PointerInfo: TGUID = '{E6995887-D10D-4F5D-9359-4CE46E4F96B9}';
  IID_ICoreWebView2CursorChangedEventHandler: TGUID = '{9DA43CCC-26E1-4DAD-B56C-D8961C94C571}';
  IID_ICoreWebView2CompositionController2: TGUID = '{0B6A3D24-49CB-4806-BA20-B5E0734A7B26}';
  IID_ICoreWebView2CompositionController3: TGUID = '{9570570E-4D76-4361-9EE1-F04D0DBDFB1E}';
  IID_ICoreWebView2Controller2: TGUID = '{C979903E-D4CA-4228-92EB-47EE3FA96EAB}';
  IID_ICoreWebView2Controller3: TGUID = '{F9614724-5D2B-41DC-AEF7-73D62B51543B}';
  IID_ICoreWebView2RasterizationScaleChangedEventHandler: TGUID = '{9C98C8B1-AC53-427E-A345-3049B5524BBE}';
  IID_ICoreWebView2Controller4: TGUID = '{97D418D5-A426-4E49-A151-E1A10F327D9E}';
  IID_ICoreWebView2ControllerOptions: TGUID = '{12AAE616-8CCB-44EC-BCB3-EB1831881635}';
  IID_ICoreWebView2ControllerOptions2: TGUID = '{06C991D8-9E7E-11ED-A8FC-0242AC120002}';
  IID_ICoreWebView2ClearBrowsingDataCompletedHandler: TGUID = '{E9710A06-1D1D-49B2-8234-226F35846AE5}';
  IID_ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler: TGUID = '{02FAB84B-1428-4FB7-AD45-1B2E64736184}';
  IID_ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler: TGUID = '{4E8A3389-C9D8-4BD2-B6B5-124FEE6CC14D}';
  IID_ICoreWebView2CustomSchemeRegistration: TGUID = '{D60AC92C-37A6-4B26-A39E-95CFE59047BB}';
  IID_ICoreWebView2DevToolsProtocolEventReceivedEventArgs2: TGUID = '{2DC4959D-1494-4393-95BA-BEA4CB9EBD1B}';
  IID_ICoreWebView2Environment2: TGUID = '{41F3632B-5EF4-404F-AD82-2D606C5A9A21}';
  IID_ICoreWebView2Environment3: TGUID = '{80A22AE3-BE7C-4CE2-AFE1-5A50056CDEEB}';
  IID_ICoreWebView2Environment4: TGUID = '{20944379-6DCF-41D6-A0A0-ABC0FC50DE0D}';
  IID_ICoreWebView2Environment5: TGUID = '{319E423D-E0D7-4B8D-9254-AE9475DE9B17}';
  IID_ICoreWebView2Environment6: TGUID = '{E59EE362-ACBD-4857-9A8E-D3644D9459A9}';
  IID_ICoreWebView2Environment7: TGUID = '{43C22296-3BBD-43A4-9C00-5C0DF6DD29A2}';
  IID_ICoreWebView2Environment8: TGUID = '{D6EB91DD-C3D2-45E5-BD29-6DC2BC4DE9CF}';
  IID_ICoreWebView2ProcessInfosChangedEventHandler: TGUID = '{F4AF0C39-44B9-40E9-8B11-0484CFB9E0A1}';
  IID_ICoreWebView2ProcessInfoCollection: TGUID = '{402B99CD-A0CC-4FA5-B7A5-51D86A1D2339}';
  IID_ICoreWebView2ProcessInfo: TGUID = '{84FA7612-3F3D-4FBF-889D-FAD000492D72}';
  IID_ICoreWebView2Environment9: TGUID = '{F06F41BF-4B5A-49D8-B9F6-FA16CD29F274}';
  IID_ICoreWebView2Environment10: TGUID = '{EE0EB9DF-6F12-46CE-B53F-3F47B9C928E0}';
  IID_ICoreWebView2Environment11: TGUID = '{F0913DC6-A0EC-42EF-9805-91DFF3A2966A}';
  IID_ICoreWebView2Environment12: TGUID = '{F503DB9B-739F-48DD-B151-FDFCF253F54E}';
  IID_ICoreWebView2EnvironmentOptions: TGUID = '{2FDE08A8-1E9A-4766-8C05-95A9CEB9D1C5}';
  IID_ICoreWebView2EnvironmentOptions2: TGUID = '{FF85C98A-1BA7-4A6B-90C8-2B752C89E9E2}';
  IID_ICoreWebView2EnvironmentOptions3: TGUID = '{4A5C436E-A9E3-4A2E-89C3-910D3513F5CC}';
  IID_ICoreWebView2EnvironmentOptions4: TGUID = '{AC52D13F-0D38-475A-9DCA-876580D6793E}';
  IID_ICoreWebView2EnvironmentOptions5: TGUID = '{0AE35D64-C47F-4464-814E-259C345D1501}';
  IID_ICoreWebView2Frame2: TGUID = '{7A6A5834-D185-4DBF-B63F-4A9BC43107D4}';
  IID_ICoreWebView2FrameNavigationStartingEventHandler: TGUID = '{E79908BF-2D5D-4968-83DB-263FEA2C1DA3}';
  IID_ICoreWebView2FrameContentLoadingEventHandler: TGUID = '{0D6156F2-D332-49A7-9E03-7D8F2FEEEE54}';
  IID_ICoreWebView2FrameNavigationCompletedEventHandler: TGUID = '{609302AD-0E36-4F9A-A210-6A45272842A9}';
  IID_ICoreWebView2FrameDOMContentLoadedEventHandler: TGUID = '{38D9520D-340F-4D1E-A775-43FCE9753683}';
  IID_ICoreWebView2FrameWebMessageReceivedEventHandler: TGUID = '{E371E005-6D1D-4517-934B-A8F1629C62A5}';
  IID_ICoreWebView2Frame3: TGUID = '{B50D82CC-CC28-481D-9614-CB048895E6A0}';
  IID_ICoreWebView2FramePermissionRequestedEventHandler: TGUID = '{845D0EDD-8BD8-429B-9915-4821789F23E9}';
  IID_ICoreWebView2PermissionRequestedEventArgs2: TGUID = '{74D7127F-9DE6-4200-8734-42D6FB4FF741}';
  IID_ICoreWebView2Frame4: TGUID = '{188782DC-92AA-4732-AB3C-FCC59F6F68B9}';
  IID_ICoreWebView2FrameInfo: TGUID = '{DA86B8A1-BDF3-4F11-9955-528CEFA59727}';
  IID_ICoreWebView2FrameInfoCollection: TGUID = '{8F834154-D38E-4D90-AFFB-6800A7272839}';
  IID_ICoreWebView2FrameInfoCollectionIterator: TGUID = '{1BF89E2D-1B2B-4629-B28F-05099B41BB03}';
  IID_ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler: TGUID = '{38274481-A15C-4563-94CF-990EDC9AEB95}';
  IID_ICoreWebView2PermissionSettingCollectionView: TGUID = '{F5596F62-3DE5-47B1-91E8-A4104B596B96}';
  IID_ICoreWebView2PermissionSetting: TGUID = '{792B6ECA-5576-421C-9119-74EBB3A4FFB3}';
  IID_ICoreWebView2NavigationCompletedEventArgs2: TGUID = '{FDF8B738-EE1E-4DB2-A329-8D7D7B74D792}';
  IID_ICoreWebView2NavigationStartingEventArgs2: TGUID = '{9086BE93-91AA-472D-A7E0-579F2BA006AD}';
  IID_ICoreWebView2NavigationStartingEventArgs3: TGUID = '{DDFFE494-4942-4BD2-AB73-35B8FF40E19F}';
  IID_ICoreWebView2NewWindowRequestedEventArgs2: TGUID = '{BBC7BAED-74C6-4C92-B63A-7F5AEAE03DE3}';
  IID_ICoreWebView2PermissionRequestedEventArgs3: TGUID = '{E61670BC-3DCE-4177-86D2-C629AE3CB6AC}';
  IID_ICoreWebView2PrintSettings2: TGUID = '{CA7F0E1F-3484-41D1-8C1A-65CD44A63F8D}';
  IID_ICoreWebView2ProcessFailedEventArgs2: TGUID = '{4DAB9422-46FA-4C3E-A5D2-41D2071D3680}';
  IID_ICoreWebView2Profile2: TGUID = '{FA740D4B-5EAE-4344-A8AD-74BE31925397}';
  IID_ICoreWebView2Profile3: TGUID = '{B188E659-5685-4E05-BDBA-FC640E0F1992}';
  IID_ICoreWebView2Profile4: TGUID = '{8F4AE680-192E-4EC8-833A-21CFADAEF628}';
  IID_ICoreWebView2SetPermissionStateCompletedHandler: TGUID = '{FC77FB30-9C9E-4076-B8C7-7644A703CA1B}';
  IID_ICoreWebView2Profile5: TGUID = '{2EE5B76E-6E80-4DF2-BCD3-D4EC3340A01B}';
  IID_ICoreWebView2Profile6: TGUID = '{BD82FA6A-1D65-4C33-B2B4-0393020CC61B}';
  IID_ICoreWebView2Settings2: TGUID = '{EE9A0F68-F46C-4E32-AC23-EF8CAC224D2A}';
  IID_ICoreWebView2Settings3: TGUID = '{FDB5AB74-AF33-4854-84F0-0A631DEB5EBA}';
  IID_ICoreWebView2Settings4: TGUID = '{CB56846C-4168-4D53-B04F-03B6D6796FF2}';
  IID_ICoreWebView2Settings5: TGUID = '{183E7052-1D03-43A0-AB99-98E043B66B39}';
  IID_ICoreWebView2Settings6: TGUID = '{11CB3ACD-9BC8-43B8-83BF-F40753714F87}';
  IID_ICoreWebView2Settings7: TGUID = '{488DC902-35EF-42D2-BC7D-94B65C4BC49C}';
  IID_ICoreWebView2Settings8: TGUID = '{9E6B0E8F-86AD-4E81-8147-A9B5EDB68650}';
  IID_ICoreWebView2_19: TGUID = '{6921F954-79B0-437F-A997-C85811897C68}';
  IID_ICoreWebView2File: TGUID = '{F2C19559-6BC1-4583-A757-90021BE9AFEC}';
  IID_ICoreWebView2ObjectCollectionView: TGUID = '{0F36FD87-4F69-4415-98DA-888F89FB9A33}';
  IID_ICoreWebView2WebMessageReceivedEventArgs2: TGUID = '{06FC7AB7-C90C-4297-9389-33CA01CF6D5E}';

{*
 *********************************************************************
 Declaration of Enumerations defined in Type Library
 *********************************************************************
*}

type
  /// <summary>
  /// Specifies the key event type that triggered an AcceleratorKeyPressed
  /// event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_key_event_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_KEY_EVENT_KIND = TOleEnum;
const
  /// <summary>
  /// Specifies that the key event type corresponds to window message
  /// WM_KEYDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_KEY_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_KEY_EVENT_KIND_KEY_DOWN = $00000000;
  /// <summary>
  /// Specifies that the key event type corresponds to window message
  /// WM_KEYUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_KEY_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_KEY_EVENT_KIND_KEY_UP = $00000001;
  /// <summary>
  /// Specifies that the key event type corresponds to window message
  /// WM_SYSKEYDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_KEY_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_KEY_EVENT_KIND_SYSTEM_KEY_DOWN = $00000002;
  /// <summary>
  /// Specifies that the key event type corresponds to window message
  /// WM_SYSKEYUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_KEY_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_KEY_EVENT_KIND_SYSTEM_KEY_UP = $00000003;

type
  /// <summary>
  /// Specifies the reason for moving focus.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_move_focus_reason">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_MOVE_FOCUS_REASON = TOleEnum;
const
  /// <summary>
  /// Specifies that the code is setting focus into WebView.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOVE_FOCUS_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_MOVE_FOCUS_REASON_PROGRAMMATIC = $00000000;
  /// <summary>
  /// Specifies that the focus is moving due to Tab traversal forward.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOVE_FOCUS_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_MOVE_FOCUS_REASON_NEXT = $00000001;
  /// <summary>
  /// Specifies that the focus is moving due to Tab traversal backward.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOVE_FOCUS_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_MOVE_FOCUS_REASON_PREVIOUS = $00000002;

type
  /// <summary>
  /// Indicates the error status values for web navigations.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_web_error_status">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS = TOleEnum;
const
  /// <summary>
  /// Indicates that an unknown error occurred.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_UNKNOWN = $00000000;
  /// <summary>
  /// Indicates that the SSL certificate common name does not match the web
  /// address.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_COMMON_NAME_IS_INCORRECT = $00000001;
  /// <summary>
  /// Indicates that the SSL certificate has expired.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_EXPIRED = $00000002;
  /// <summary>
  /// Indicates that the SSL client certificate contains errors.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CLIENT_CERTIFICATE_CONTAINS_ERRORS = $00000003;
  /// <summary>
  /// Indicates that the SSL certificate has been revoked.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_REVOKED = $00000004;
  /// <summary>
  /// Indicates that the SSL certificate is not valid.  The certificate may not
  /// match the public key pins for the host name, the certificate is signed
  /// by an untrusted authority or using a weak sign algorithm, the certificate
  /// claimed DNS names violate name constraints, the certificate contains a
  /// weak key, the validity period of the certificate is too long, lack of
  /// revocation information or revocation mechanism, non-unique host name,
  /// lack of certificate transparency information, or the certificate is
  /// chained to a
  /// [legacy Symantec root](https://security.googleblog.com/2018/03/distrust-of-symantec-pki-immediate.html).
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_IS_INVALID = $00000005;
  /// <summary>
  /// Indicates that the host is unreachable.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_SERVER_UNREACHABLE = $00000006;
  /// <summary>
  /// Indicates that the connection has timed out.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_TIMEOUT = $00000007;
  /// <summary>
  /// Indicates that the server returned an invalid or unrecognized response.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_ERROR_HTTP_INVALID_SERVER_RESPONSE = $00000008;
  /// <summary>
  /// Indicates that the connection was stopped.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CONNECTION_ABORTED = $00000009;
  /// <summary>
  /// Indicates that the connection was reset.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CONNECTION_RESET = $0000000A;
  /// <summary>
  /// Indicates that the Internet connection has been lost.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_DISCONNECTED = $0000000B;
  /// <summary>
  /// Indicates that a connection to the destination was not established.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_CANNOT_CONNECT = $0000000C;
  /// <summary>
  /// Indicates that the provided host name was not able to be resolved.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_HOST_NAME_NOT_RESOLVED = $0000000D;
  /// <summary>
  /// Indicates that the operation was canceled. This status code is also used
  /// in the following cases:
  /// - When the app cancels a navigation via NavigationStarting event.
  /// - For original navigation if the app navigates the WebView2 in a rapid succession
  /// away after the load for original navigation commenced, but before it completed.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_OPERATION_CANCELED = $0000000E;
  /// <summary>
  /// Indicates that the request redirect failed.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_REDIRECT_FAILED = $0000000F;
  /// <summary>
  /// Indicates that an unexpected error occurred.
  /// </summary>
  COREWEBVIEW2_WEB_ERROR_STATUS_UNEXPECTED_ERROR = $00000010;
  /// <summary>
  /// Indicates that user is prompted with a login, waiting on user action.
  /// Initial navigation to a login site will always return this even if app provides
  /// credential using BasicAuthenticationRequested.
  /// HTTP response status code in this case is 401.
  /// See status code reference here: https://developer.mozilla.org/docs/Web/HTTP/Status.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_VALID_AUTHENTICATION_CREDENTIALS_REQUIRED = $00000011;
  /// <summary>
  /// Indicates that user lacks proper authentication credentials for a proxy server.
  /// HTTP response status code in this case is 407.
  /// See status code reference here: https://developer.mozilla.org/docs/Web/HTTP/Status.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_ERROR_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_ERROR_STATUS_VALID_PROXY_AUTHENTICATION_REQUIRED = $00000012;

type
  /// <summary>
  /// Specifies the JavaScript dialog type used in the
  /// ICoreWebView2ScriptDialogOpeningEventHandler interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_script_dialog_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_SCRIPT_DIALOG_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates that the dialog uses the window.alert JavaScript function.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SCRIPT_DIALOG_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SCRIPT_DIALOG_KIND_ALERT = $00000000;
  /// <summary>
  /// Indicates that the dialog uses the window.confirm JavaScript function.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SCRIPT_DIALOG_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SCRIPT_DIALOG_KIND_CONFIRM = $00000001;
  /// <summary>
  /// Indicates that the dialog uses the window.prompt JavaScript function.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SCRIPT_DIALOG_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SCRIPT_DIALOG_KIND_PROMPT = $00000002;
  /// <summary>
  /// Indicates that the dialog uses the beforeunload JavaScript event.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SCRIPT_DIALOG_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SCRIPT_DIALOG_KIND_BEFOREUNLOAD = $00000003;

type
  /// <summary>
  /// Indicates the type of a permission request.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_permission_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates an unknown permission.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_UNKNOWN_PERMISSION = $00000000;
  /// <summary>
  /// Indicates permission to capture audio.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_MICROPHONE = $00000001;
  /// <summary>
  /// Indicates permission to capture video.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_CAMERA = $00000002;
  /// <summary>
  /// Indicates permission to access geolocation.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_GEOLOCATION = $00000003;
  /// <summary>
  /// Indicates permission to send web notifications. Apps that would like to
  /// show notifications should handle PermissionRequested events
  /// and no browser permission prompt will be shown for notification requests.
  /// Note that push notifications are currently unavailable in WebView2.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_NOTIFICATIONS = $00000004;
  /// <summary>
  /// Indicates permission to access generic sensor.  Generic Sensor covering
  /// ambient-light-sensor, accelerometer, gyroscope, and magnetometer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_OTHER_SENSORS = $00000005;
  /// <summary>
  /// Indicates permission to read the system clipboard without a user gesture.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_CLIPBOARD_READ = $00000006;
  /// <summary>
  /// Indicates permission to automatically download multiple files. Permission
  /// is requested when multiple downloads are triggered in quick succession.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_MULTIPLE_AUTOMATIC_DOWNLOADS = $00000007;
  /// <summary>
  /// Indicates permission to read and write to files or folders on the device.
  /// Permission is requested when developers use the [File System Access API](https://developer.mozilla.org/en-US/docs/Web/API/File_System_Access_API)
  /// to show the file or folder picker to the end user, and then request
  /// "readwrite" permission for the user's selection.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_FILE_READ_WRITE = $00000008;
  /// <summary>
  /// Indicates permission to play audio and video automatically on sites. This
  /// permission affects the autoplay attribute and play method of the audio and
  /// video HTML elements, and the start method of the Web Audio API. See the
  /// [Autoplay guide for media and Web Audio APIs](https://developer.mozilla.org/en-US/docs/Web/Media/Autoplay_guide) for details.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_AUTOPLAY = $00000009;
  /// <summary>
  /// Indicates permission to use fonts on the device. Permission is requested
  /// when developers use the [Local Font Access API](https://wicg.github.io/local-font-access/)
  /// to query the system fonts available for styling web content.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_LOCAL_FONTS = $0000000A;
  /// <summary>
  /// Indicates permission to send and receive system exclusive messages to/from MIDI
  /// (Musical Instrument Digital Interface) devices. Permission is requested
  /// when developers use the [Web MIDI API](https://developer.mozilla.org/en-US/docs/Web/API/Web_MIDI_API)
  /// to request access to system exclusive MIDI messages.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_MIDI_SYSTEM_EXCLUSIVE_MESSAGES = $0000000B;
  /// <summary>
  /// Indicates permission to open and place windows on the screen. Permission is
  /// requested when developers use the [Multi-Screen Window Placement API](https://www.w3.org/TR/window-placement/)
  /// to get screen details.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_KIND_WINDOW_MANAGEMENT = $0000000C;

type
  /// <summary>
  /// Specifies the response to a permission request.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_permission_state">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_STATE = TOleEnum;
const
  /// <summary>
  /// Specifies that the default browser behavior is used, which normally
  /// prompt users for decision.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_STATE values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_STATE_DEFAULT = $00000000;
  /// <summary>
  /// Specifies that the permission request is granted.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_STATE values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_STATE_ALLOW = $00000001;
  /// <summary>
  /// Specifies that the permission request is denied.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PERMISSION_STATE values.</para>
  /// </remarks>
  COREWEBVIEW2_PERMISSION_STATE_DENY = $00000002;

type
  /// <summary>
  /// Specifies the process failure type used in the
  /// ICoreWebView2ProcessFailedEventHandler interface. The values in this enum
  /// make reference to the process kinds in the Chromium architecture. For more
  /// information about what these processes are and what they do, see
  /// [Browser Architecture - Inside look at modern web browser](https://developers.google.com/web/updates/2018/09/inside-browser-part1).
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_process_failed_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates that the browser process ended unexpectedly.  The WebView
  /// automatically moves to the Closed state.  The app has to recreate a new
  /// WebView to recover from this failure.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_BROWSER_PROCESS_EXITED = $00000000;
  /// <summary>
  /// Indicates that the main frame's render process ended unexpectedly.  A new
  /// render process is created automatically and navigated to an error page.
  /// You can use the Reload method to try to reload the page that failed.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_EXITED = $00000001;
  /// <summary>
  /// Indicates that the main frame's render process is unresponsive.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// <para>Note that this does not seem to work right now.
  /// Does not fire for simple long running script case, the only related test
  /// SitePerProcessBrowserTest::NoCommitTimeoutForInvisibleWebContents is
  /// disabled.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_UNRESPONSIVE = $00000002;
  /// <summary>
  /// Indicates that a frame-only render process ended unexpectedly. The process
  /// exit does not affect the top-level document, only a subset of the
  /// subframes within it. The content in these frames is replaced with an error
  /// page in the frame.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_FRAME_RENDER_PROCESS_EXITED = $00000003;
  /// <summary>
  /// Indicates that a utility process ended unexpectedly.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_UTILITY_PROCESS_EXITED = $00000004;
  /// <summary>
  /// Indicates that a sandbox helper process ended unexpectedly.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_SANDBOX_HELPER_PROCESS_EXITED = $00000005;
  /// <summary>
  /// Indicates that the GPU process ended unexpectedly.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_GPU_PROCESS_EXITED = $00000006;
  /// <summary>
  /// Indicates that a PPAPI plugin process ended unexpectedly.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_PPAPI_PLUGIN_PROCESS_EXITED = $00000007;
  /// <summary>
  /// Indicates that a PPAPI plugin broker process ended unexpectedly.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_PPAPI_BROKER_PROCESS_EXITED = $00000008;
  /// <summary>
  /// Indicates that a process of unspecified kind ended unexpectedly.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_UNKNOWN_PROCESS_EXITED = $00000009;

type
  /// <summary>
  /// Specifies the image format for the ICoreWebView2.CapturePreview method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_capture_preview_image_format">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT = TOleEnum;
const
  /// <summary>
  /// Indicates that the PNG image format is used.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT values.</para>
  /// </remarks>
  COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_PNG = $00000000;
  /// <summary>
  /// Indicates the JPEG image format is used.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT values.</para>
  /// </remarks>
  COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_JPEG = $00000001;

type
  /// <summary>
  /// Specifies the web resource request contexts.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_web_resource_context">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT = TOleEnum;
const
  /// <summary>
  /// Specifies all resources.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_ALL = $00000000;
  /// <summary>
  /// Specifies a document resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_DOCUMENT = $00000001;
  /// <summary>
  /// Specifies a CSS resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_STYLESHEET = $00000002;
  /// <summary>
  /// Specifies an image resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_IMAGE = $00000003;
  /// <summary>
  /// Specifies another media resource such as a video.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_MEDIA = $00000004;
  /// <summary>
  /// Specifies a font resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_FONT = $00000005;
  /// <summary>
  /// Specifies a script resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_SCRIPT = $00000006;
  /// <summary>
  /// Specifies an XML HTTP request, Fetch and EventSource API communication.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_XML_HTTP_REQUEST = $00000007;
  /// <summary>
  /// Specifies a Fetch API communication.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// <para>Note that this isn't working. Fetch API requests are fired as a part
  /// of COREWEBVIEW2_WEB_RESOURCE_CONTEXT_XML_HTTP_REQUEST.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_FETCH = $00000008;
  /// <summary>
  /// Specifies a TextTrack resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_TEXT_TRACK = $00000009;
  /// <summary>
  /// Specifies an EventSource API communication.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_EVENT_SOURCE = $0000000A;
  /// <summary>
  /// Specifies a WebSocket API communication.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// <para>Note that this isn't working. EventSource API requests are fired as a part
  /// of COREWEBVIEW2_WEB_RESOURCE_CONTEXT_XML_HTTP_REQUEST.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_WEBSOCKET = $0000000B;
  /// <summary>
  /// Specifies a Web App Manifest.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_MANIFEST = $0000000C;
  /// <summary>
  /// Specifies a Signed HTTP Exchange.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_SIGNED_EXCHANGE = $0000000D;
  /// <summary>
  /// Specifies a Ping request.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_PING = $0000000E;
  /// <summary>
  /// Specifies a CSP Violation Report.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_CSP_VIOLATION_REPORT = $0000000F;
  /// <summary>
  /// Specifies an other resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_CONTEXT values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_CONTEXT_OTHER = $00000010;

type
  /// <summary>
  /// Kind of cookie SameSite status used in the ICoreWebView2Cookie interface.
  /// These fields match those as specified in https://developer.mozilla.org/docs/Web/HTTP/Cookies#.
  /// Learn more about SameSite cookies here: https://tools.ietf.org/html/draft-west-first-party-cookies-07
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_cookie_same_site_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_COOKIE_SAME_SITE_KIND = TOleEnum;
const
  /// <summary>
  /// None SameSite type. No restrictions on cross-site requests.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_COOKIE_SAME_SITE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_COOKIE_SAME_SITE_KIND_NONE = $00000000;
  /// <summary>
  /// Lax SameSite type. The cookie will be sent with "same-site" requests, and with "cross-site" top level navigation.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_COOKIE_SAME_SITE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_COOKIE_SAME_SITE_KIND_LAX = $00000001;
  /// <summary>
  /// Strict SameSite type. The cookie will only be sent along with "same-site" requests.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_COOKIE_SAME_SITE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_COOKIE_SAME_SITE_KIND_STRICT = $00000002;

type
  /// <summary>
  /// Kind of cross origin resource access allowed for host resources during download.
  /// Note that other normal access checks like same origin DOM access check and [Content
  /// Security Policy](https://developer.mozilla.org/docs/Web/HTTP/CSP) still apply.
  /// The following table illustrates the host resource cross origin access according to
  /// access context and COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND.
  ///
  /// Cross Origin Access Context | DENY | ALLOW | DENY_CORS
  /// --- | --- | --- | ---
  /// From DOM like src of img, script or iframe element| Deny | Allow | Allow
  /// From Script like Fetch or XMLHttpRequest| Deny | Allow | Deny
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_host_resource_access_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND = TOleEnum;
const
  /// <summary>
  /// All cross origin resource access is denied, including normal sub resource access
  /// as src of a script or image element.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_DENY = $00000000;
  /// <summary>
  /// All cross origin resource access is allowed, including accesses that are
  /// subject to Cross-Origin Resource Sharing(CORS) check. The behavior is similar to
  /// a web site sends back http header Access-Control-Allow-Origin: *.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_ALLOW = $00000001;
  /// <summary>
  /// Cross origin resource access is allowed for normal sub resource access like
  /// as src of a script or image element, while any access that subjects to CORS check
  /// will be denied.
  /// See [Cross-Origin Resource Sharing](https://developer.mozilla.org/docs/Web/HTTP/CORS)
  /// for more information.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_DENY_CORS = $00000002;

type
  /// <summary>
  /// State of the download operation.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_download_state">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_STATE = TOleEnum;
const
  /// <summary>
  /// The download is in progress.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_STATE values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_STATE_IN_PROGRESS = $00000000;
  /// <summary>
  /// The connection with the file host was broken. The InterruptReason property
  /// can be accessed from ICoreWebView2DownloadOperation. See
  /// COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON for descriptions of kinds of
  /// interrupt reasons. Host can check whether an interrupted download can be
  /// resumed with the CanResume property on the ICoreWebView2DownloadOperation.
  /// Once resumed, a download is in the COREWEBVIEW2_DOWNLOAD_STATE_IN_PROGRESS state.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_STATE values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED = $00000001;
  /// <summary>
  /// The download completed successfully.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_STATE values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_STATE_COMPLETED = $00000002;

type
  /// <summary>
  /// Reason why a download was interrupted.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_download_interrupt_reason">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON = TOleEnum;
const
  /// <summary>
  /// No reason.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_NONE = $00000000;
  /// <summary>
  /// Generic file error.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_FAILED = $00000001;
  /// <summary>
  /// Access denied due to security restrictions.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_ACCESS_DENIED = $00000002;
  /// <summary>
  /// Disk full. User should free some space or choose a different location to
  /// store the file.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_NO_SPACE = $00000003;
  /// <summary>
  /// Result file path with file name is too long.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_NAME_TOO_LONG = $00000004;
  /// <summary>
  /// File is too large for file system.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_TOO_LARGE = $00000005;
  /// <summary>
  /// Microsoft Defender Smartscreen detected a virus in the file.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_MALICIOUS = $00000006;
  /// <summary>
  /// File was in use, too many files opened, or out of memory.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_TRANSIENT_ERROR = $00000007;
  /// <summary>
  /// File blocked by local policy.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_BLOCKED_BY_POLICY = $00000008;
  /// <summary>
  /// Security check failed unexpectedly. Microsoft Defender SmartScreen could
  /// not scan this file.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_SECURITY_CHECK_FAILED = $00000009;
  /// <summary>
  /// Seeking past the end of a file in opening a file, as part of resuming an
  /// interrupted download. The file did not exist or was not as large as
  /// expected. Partially downloaded file was truncated or deleted, and download
  /// will be restarted automatically.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_TOO_SHORT = $0000000A;
  /// <summary>
  /// Partial file did not match the expected hash and was deleted. Download
  /// will be restarted automatically.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_HASH_MISMATCH = $0000000B;
  /// <summary>
  /// Generic network error. User can retry the download manually.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_NETWORK_FAILED = $0000000C;
  /// <summary>
  /// Network operation timed out.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_NETWORK_TIMEOUT = $0000000D;
  /// <summary>
  /// Network connection lost. User can retry the download manually.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_NETWORK_DISCONNECTED = $0000000E;
  /// <summary>
  /// Server has gone down. User can retry the download manually.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_NETWORK_SERVER_DOWN = $0000000F;
  /// <summary>
  /// Network request invalid because original or redirected URI is invalid, has
  /// an unsupported scheme, or is disallowed by network policy.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_NETWORK_INVALID_REQUEST = $00000010;
  /// <summary>
  /// Generic server error. User can retry the download manually.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_FAILED = $00000011;
  /// <summary>
  /// Server does not support range requests.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_NO_RANGE = $00000012;
  /// <summary>
  /// Server does not have the requested data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_BAD_CONTENT = $00000013;
  /// <summary>
  /// Server did not authorize access to resource.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_UNAUTHORIZED = $00000014;
  /// <summary>
  /// Server certificate problem.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_CERTIFICATE_PROBLEM = $00000015;
  /// <summary>
  /// Server access forbidden.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_FORBIDDEN = $00000016;
  /// <summary>
  /// Unexpected server response. Responding server may not be intended server.
  /// User can retry the download manually.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_UNEXPECTED_RESPONSE = $00000017;
  /// <summary>
  /// Server sent fewer bytes than the Content-Length header. Content-length
  /// header may be invalid or connection may have closed. Download is treated
  /// as complete unless there are
  /// [strong validators](https://tools.ietf.org/html/rfc7232#section-2) present
  /// to interrupt the download.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_CONTENT_LENGTH_MISMATCH = $00000018;
  /// <summary>
  /// Unexpected cross-origin redirect.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_CROSS_ORIGIN_REDIRECT = $00000019;
  /// <summary>
  /// User canceled the download.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_USER_CANCELED = $0000001A;
  /// <summary>
  /// User shut down the WebView. Resuming downloads that were interrupted
  /// during shutdown is not yet supported.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_USER_SHUTDOWN = $0000001B;
  /// <summary>
  /// User paused the download.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_USER_PAUSED = $0000001C;
  /// <summary>
  /// WebView crashed.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_DOWNLOAD_PROCESS_CRASHED = $0000001D;

type
  /// <summary>
  /// Specifies the client certificate kind.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_client_certificate_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_CLIENT_CERTIFICATE_KIND = TOleEnum;
const
  /// <summary>
  /// Specifies smart card certificate.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CLIENT_CERTIFICATE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CLIENT_CERTIFICATE_KIND_SMART_CARD = $00000000;
  /// <summary>
  /// Specifies PIN certificate.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CLIENT_CERTIFICATE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CLIENT_CERTIFICATE_KIND_PIN = $00000001;
  /// <summary>
  /// Specifies other certificate.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CLIENT_CERTIFICATE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CLIENT_CERTIFICATE_KIND_OTHER = $00000002;

type
  /// <summary>
  /// The orientation for printing, used by the Orientation property on
  /// ICoreWebView2PrintSettings. Currently only printing to PDF is supported.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_print_orientation">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PRINT_ORIENTATION = TOleEnum;
const
  /// <summary>
  /// Print the page(s) in portrait orientation.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_ORIENTATION values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_ORIENTATION_PORTRAIT = $00000000;
  /// <summary>
  /// Print the page(s) in landscape orientation.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_ORIENTATION values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_ORIENTATION_LANDSCAPE = $00000001;

type
  /// <summary>
  /// The default download dialog can be aligned to any of the WebView corners
  /// by setting the DefaultDownloadDialogCornerAlignment property. The default
  /// position is top-right corner.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_default_download_dialog_corner_alignment">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT = TOleEnum;
const
  /// <summary>
  /// Top-left corner of the WebView.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT values.</para>
  /// </remarks>
  COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT_TOP_LEFT = $00000000;
  /// <summary>
  /// Top-right corner of the WebView.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT values.</para>
  /// </remarks>
  COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT_TOP_RIGHT = $00000001;
  /// <summary>
  /// Bottom-left corner of the WebView.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT values.</para>
  /// </remarks>
  COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT_BOTTOM_LEFT = $00000002;
  /// <summary>
  /// Bottom-right corner of the WebView.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT values.</para>
  /// </remarks>
  COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT_BOTTOM_RIGHT = $00000003;

type
  /// <summary>
  /// Specifies the menu item kind
  /// for the ICoreWebView2ContextMenuItem.get_Kind method
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_context_menu_item_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND = TOleEnum;
const
  /// <summary>
  /// Specifies a command menu item kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_COMMAND = $00000000;
  /// <summary>
  /// Specifies a check box menu item kind. ContextMenuItem objects of this kind
  /// will need the IsChecked property to determine current state of the check box.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_CHECK_BOX = $00000001;
  /// <summary>
  /// Specifies a radio button menu item kind. ContextMenuItem objects of this kind
  /// will need the IsChecked property to determine current state of the radio button.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_RADIO = $00000002;
  /// <summary>
  /// Specifies a separator menu item kind. ContextMenuItem objects of this kind
  /// are used to signal a visual separator with no functionality.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_SEPARATOR = $00000003;
  /// <summary>
  /// Specifies a submenu menu item kind. ContextMenuItem objects of this kind will contain
  /// a ContextMenuItemCollection of its children ContextMenuItem objects.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND_SUBMENU = $00000004;

type
  /// <summary>
  /// Indicates the kind of context for which the context menu was created
  /// for the ICoreWebView2ContextMenuTarget::get_Kind method.
  /// This enum will always represent the active element that caused the context menu request.
  /// If there is a selection with multiple images, audio and text, for example, the element that
  /// the end user right clicks on within this selection will be the option represented by this enum.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_context_menu_target_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates that the context menu was created for the page without any additional content.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND_PAGE = $00000000;
  /// <summary>
  /// Indicates that the context menu was created for an image element.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND_IMAGE = $00000001;
  /// <summary>
  /// Indicates that the context menu was created for selected text.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND_SELECTED_TEXT = $00000002;
  /// <summary>
  /// Indicates that the context menu was created for an audio element.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND_AUDIO = $00000003;
  /// <summary>
  /// Indicates that the context menu was created for a video element.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND_VIDEO = $00000004;

type
  /// <summary>
  /// An enum to represent the options for WebView2 color scheme: auto, light, or dark.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_preferred_color_scheme">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PREFERRED_COLOR_SCHEME = TOleEnum;
const
  /// <summary>
  /// Auto color scheme.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PREFERRED_COLOR_SCHEME values.</para>
  /// </remarks>
  COREWEBVIEW2_PREFERRED_COLOR_SCHEME_AUTO = $00000000;
  /// <summary>
  /// Light color scheme.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PREFERRED_COLOR_SCHEME values.</para>
  /// </remarks>
  COREWEBVIEW2_PREFERRED_COLOR_SCHEME_LIGHT = $00000001;
  /// <summary>
  /// Dark color scheme.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PREFERRED_COLOR_SCHEME values.</para>
  /// </remarks>
  COREWEBVIEW2_PREFERRED_COLOR_SCHEME_DARK = $00000002;

type
  /// <summary>
  /// Specifies the action type when server certificate error is detected to be
  /// used in the ICoreWebView2ServerCertificateErrorDetectedEventArgs
  /// interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_server_certificate_error_action">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION = TOleEnum;
const
  /// <summary>
  /// Indicates to ignore the warning and continue the request with the TLS
  /// certificate. This decision is cached for the RequestUri's host and the
  /// server certificate in the session.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION values.</para>
  /// </remarks>
  COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION_ALWAYS_ALLOW = $00000000;
  /// <summary>
  /// Indicates to reject the certificate and cancel the request.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION values.</para>
  /// </remarks>
  COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION_CANCEL = $00000001;
  /// <summary>
  /// Indicates to display the default TLS interstitial error page to user for
  /// page navigations.
  /// For others TLS certificate is rejected and the request is cancelled.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION values.</para>
  /// </remarks>
  COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION_DEFAULT = $00000002;

type
  /// <summary>
  /// Specifies the image format to use for favicon.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_favicon_image_format">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_FAVICON_IMAGE_FORMAT = TOleEnum;
const
  /// <summary>
  /// Indicates that the PNG image format is used.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FAVICON_IMAGE_FORMAT values.</para>
  /// </remarks>
  COREWEBVIEW2_FAVICON_IMAGE_FORMAT_PNG = $00000000;
  /// <summary>
  /// Indicates the JPEG image format is used.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FAVICON_IMAGE_FORMAT values.</para>
  /// </remarks>
  COREWEBVIEW2_FAVICON_IMAGE_FORMAT_JPEG = $00000001;

type
  /// <summary>
  /// Indicates the status for printing.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_print_status">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PRINT_STATUS = TOleEnum;
const
  /// <summary>
  /// Indicates that the print operation is succeeded.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_STATUS_SUCCEEDED = $00000000;
  /// <summary>
  /// Indicates that the printer is not available.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_STATUS_PRINTER_UNAVAILABLE = $00000001;
  /// <summary>
  /// Indicates that the print operation is failed.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_STATUS values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR = $00000002;

type
  /// <summary>
  /// Specifies the print dialog kind.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_print_dialog_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DIALOG_KIND = TOleEnum;
const
  /// <summary>
  /// Opens the browser print preview dialog.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_DIALOG_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DIALOG_KIND_BROWSER = $00000000;
  /// <summary>
  /// Opens the system print dialog.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_DIALOG_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DIALOG_KIND_SYSTEM = $00000001;

type
  /// <summary>
  /// Specifies the desired access from script to CoreWebView2SharedBuffer.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_shared_buffer_access">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_SHARED_BUFFER_ACCESS = TOleEnum;
const
  /// <summary>
  /// Script from web page only has read access to the shared buffer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SHARED_BUFFER_ACCESS values.</para>
  /// </remarks>
  COREWEBVIEW2_SHARED_BUFFER_ACCESS_READ_ONLY = $00000000;
  /// <summary>
  /// Script from web page has read and write access to the shared buffer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SHARED_BUFFER_ACCESS values.</para>
  /// </remarks>
  COREWEBVIEW2_SHARED_BUFFER_ACCESS_READ_WRITE = $00000001;

type
  /// <summary>
  /// Specifies the browser process exit type used in the
  /// ICoreWebView2BrowserProcessExitedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_browser_process_exit_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates that the browser process ended normally.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND_NORMAL = $00000000;
  /// <summary>
  /// Indicates that the browser process ended unexpectedly.
  /// A ProcessFailed event will also be sent to listening WebViews from the
  /// ICoreWebView2Environment associated to the failed process.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND_FAILED = $00000001;

type
  /// <summary>
  /// Mouse event type used by SendMouseInput to convey the type of mouse event
  /// being sent to WebView. The values of this enum align with the matching
  /// WM_* window messages.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_mouse_event_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND = TOleEnum;
const
  /// <summary>
  /// Mouse horizontal wheel scroll event, WM_MOUSEHWHEEL.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_HORIZONTAL_WHEEL = $0000020E;
  /// <summary>
  /// Left button double click mouse event, WM_LBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEFT_BUTTON_DOUBLE_CLICK = $00000203;
  /// <summary>
  /// Left button down mouse event, WM_LBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEFT_BUTTON_DOWN = $00000201;
  /// <summary>
  /// Left button up mouse event, WM_LBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEFT_BUTTON_UP = $00000202;
  /// <summary>
  /// Mouse leave event, WM_MOUSELEAVE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE = $000002A3;
  /// <summary>
  /// Middle button double click mouse event, WM_MBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MIDDLE_BUTTON_DOUBLE_CLICK = $00000209;
  /// <summary>
  /// Middle button down mouse event, WM_MBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MIDDLE_BUTTON_DOWN = $00000207;
  /// <summary>
  /// Middle button up mouse event, WM_MBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MIDDLE_BUTTON_UP = $00000208;
  /// <summary>
  /// Mouse move event, WM_MOUSEMOVE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MOVE = $00000200;
  /// <summary>
  /// Right button double click mouse event, WM_RBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_RIGHT_BUTTON_DOUBLE_CLICK = $00000206;
  /// <summary>
  /// Right button down mouse event, WM_RBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_RIGHT_BUTTON_DOWN = $00000204;
  /// <summary>
  /// Right button up mouse event, WM_RBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_RIGHT_BUTTON_UP = $00000205;
  /// <summary>
  /// Mouse wheel scroll event, WM_MOUSEWHEEL.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_WHEEL = $0000020A;
  /// <summary>
  /// First or second X button double click mouse event, WM_XBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOUBLE_CLICK = $0000020D;
  /// <summary>
  /// First or second X button down mouse event, WM_XBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOWN = $0000020B;
  /// <summary>
  /// First or second X button up mouse event, WM_XBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_UP = $0000020C;

type
  /// <summary>
  /// Mouse event virtual keys associated with a COREWEBVIEW2_MOUSE_EVENT_KIND for
  /// SendMouseInput. These values can be combined into a bit flag if more than
  /// one virtual key is pressed for the event. The values of this enum align
  /// with the matching MK_* mouse keys.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_mouse_event_virtual_keys">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS = TOleEnum;
const
  /// <summary>
  /// No additional keys pressed.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_NONE = $00000000;
  /// <summary>
  /// Left mouse button is down, MK_LBUTTON.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_LEFT_BUTTON = $00000001;
  /// <summary>
  /// Right mouse button is down, MK_RBUTTON.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_RIGHT_BUTTON = $00000002;
  /// <summary>
  /// SHIFT key is down, MK_SHIFT.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_SHIFT = $00000004;
  /// <summary>
  /// CTRL key is down, MK_CONTROL.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_CONTROL = $00000008;
  /// <summary>
  /// Middle mouse button is down, MK_MBUTTON.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_MIDDLE_BUTTON = $00000010;
  /// <summary>
  /// First X button is down, MK_XBUTTON1
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_X_BUTTON1 = $00000020;
  /// <summary>
  /// Second X button is down, MK_XBUTTON2
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS_X_BUTTON2 = $00000040;

type
  /// <summary>
  /// Pointer event type used by SendPointerInput to convey the type of pointer
  /// event being sent to WebView. The values of this enum align with the
  /// matching WM_POINTER* window messages.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_pointer_event_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_POINTER_EVENT_KIND = TOleEnum;
const
  /// <summary>
  /// Corresponds to WM_POINTERACTIVATE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_POINTER_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_POINTER_EVENT_KIND_ACTIVATE = $0000024B;
  /// <summary>
  /// Corresponds to WM_POINTERDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_POINTER_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_POINTER_EVENT_KIND_DOWN = $00000246;
  /// <summary>
  /// Corresponds to WM_POINTERENTER.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_POINTER_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_POINTER_EVENT_KIND_ENTER = $00000249;
  /// <summary>
  /// Corresponds to WM_POINTERLEAVE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_POINTER_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_POINTER_EVENT_KIND_LEAVE = $0000024A;
  /// <summary>
  /// Corresponds to WM_POINTERUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_POINTER_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_POINTER_EVENT_KIND_UP = $00000247;
  /// <summary>
  /// Corresponds to WM_POINTERUPDATE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_POINTER_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_POINTER_EVENT_KIND_UPDATE = $00000245;

type
  /// <summary>
  /// Mode for how the Bounds property is interpreted in relation to the RasterizationScale property.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_bounds_mode">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_BOUNDS_MODE = TOleEnum;
const
  /// <summary>
  /// Bounds property represents raw pixels. Physical size of Webview is not impacted by RasterizationScale.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BOUNDS_MODE values.</para>
  /// </remarks>
  COREWEBVIEW2_BOUNDS_MODE_USE_RAW_PIXELS = $00000000;
  /// <summary>
  /// Bounds property represents logical pixels and the RasterizationScale property is used to get the physical size of the WebView.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BOUNDS_MODE values.</para>
  /// </remarks>
  COREWEBVIEW2_BOUNDS_MODE_USE_RASTERIZATION_SCALE = $00000001;

type
  /// <summary>
  /// Indicates the process type used in the ICoreWebView2ProcessInfo interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_process_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates the browser process kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND_BROWSER = $00000000;
  /// <summary>
  /// Indicates the render process kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND_RENDERER = $00000001;
  /// <summary>
  /// Indicates the utility process kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND_UTILITY = $00000002;
  /// <summary>
  /// Indicates the sandbox helper process kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND_SANDBOX_HELPER = $00000003;
  /// <summary>
  /// Indicates the GPU process kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND_GPU = $00000004;
  /// <summary>
  /// Indicates the PPAPI plugin process kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND_PPAPI_PLUGIN = $00000005;
  /// <summary>
  /// Indicates the PPAPI plugin broker process kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_KIND_PPAPI_BROKER = $00000006;

type
  /// <summary>
  /// Specifies the navigation kind of each navigation.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_navigation_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_NAVIGATION_KIND = TOleEnum;
const
  /// <summary>
  /// A navigation caused by CoreWebView2.Reload(), location.reload(), the end user
  /// using F5 or other UX, or other reload mechanisms to reload the current document
  /// without modifying the navigation history.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NAVIGATION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NAVIGATION_KIND_RELOAD = $00000000;
  /// <summary>
  /// A navigation back or forward to a different entry in the session navigation history,
  /// like via CoreWebView2.Back(), location.back(), the end user pressing Alt+Left
  /// or other UX, or other mechanisms to navigate back or forward in the current
  /// session navigation history.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NAVIGATION_KIND values.</para>
  /// <para>This kind doesn't distinguish back or forward, because we can't
  /// distinguish it from origin source blink.mojom.NavigationType.</para>
  /// </remarks>
  COREWEBVIEW2_NAVIGATION_KIND_BACK_OR_FORWARD = $00000001;
  /// <summary>
  /// A navigation to another document, which can be caused by CoreWebView2.Navigate(),
  /// window.location.href = ..., or other WebView2 or DOM APIs that navigate to a new URI.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NAVIGATION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NAVIGATION_KIND_NEW_DOCUMENT = $00000002;

type
  /// <summary>
  /// Specifies the collation for a print.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_print_collation">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLLATION = TOleEnum;
const
  /// <summary>
  /// The default collation for a printer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_COLLATION values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLLATION_DEFAULT = $00000000;
  /// <summary>
  /// Indicate that the collation has been selected for the printed output.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_COLLATION values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLLATION_COLLATED = $00000001;
  /// <summary>
  /// Indicate that the collation has not been selected for the printed output.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_COLLATION values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLLATION_UNCOLLATED = $00000002;

type
  /// <summary>
  /// Specifies the color mode for a print.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_print_color_mode">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLOR_MODE = TOleEnum;
const
  /// <summary>
  /// The default color mode for a printer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_COLOR_MODE values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLOR_MODE_DEFAULT = $00000000;
  /// <summary>
  /// Indicate that the printed output will be in color.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_COLOR_MODE values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLOR_MODE_COLOR = $00000001;
  /// <summary>
  /// Indicate that the printed output will be in shades of gray.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_COLOR_MODE values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_COLOR_MODE_GRAYSCALE = $00000002;

type
  /// <summary>
  /// Specifies the duplex option for a print.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_print_duplex">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DUPLEX = TOleEnum;
const
  /// <summary>
  /// The default duplex for a printer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_DUPLEX values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DUPLEX_DEFAULT = $00000000;
  /// <summary>
  /// Print on only one side of the sheet.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_DUPLEX values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DUPLEX_ONE_SIDED = $00000001;
  /// <summary>
  /// Print on both sides of the sheet, flipped along the long edge.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_DUPLEX values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DUPLEX_TWO_SIDED_LONG_EDGE = $00000002;
  /// <summary>
  /// Print on both sides of the sheet, flipped along the short edge.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_DUPLEX values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_DUPLEX_TWO_SIDED_SHORT_EDGE = $00000003;

type
  /// <summary>
  /// Specifies the media size for a print.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_print_media_size">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PRINT_MEDIA_SIZE = TOleEnum;
const
  /// <summary>
  /// The default media size for a printer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_MEDIA_SIZE values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_MEDIA_SIZE_DEFAULT = $00000000;
  /// <summary>
  /// Indicate custom media size that is specific to the printer.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PRINT_MEDIA_SIZE values.</para>
  /// </remarks>
  COREWEBVIEW2_PRINT_MEDIA_SIZE_CUSTOM = $00000001;

type
  /// <summary>
  /// Specifies the process failure reason used in the
  /// ICoreWebView2ProcessFailedEventHandler interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_process_failed_reason">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON = TOleEnum;
const
  /// <summary>
  /// An unexpected process failure occurred.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_UNEXPECTED = $00000000;
  /// <summary>
  /// The process became unresponsive.
  /// This only applies to the main frame's render process.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_UNRESPONSIVE = $00000001;
  /// <summary>
  /// The process was terminated. For example, from Task Manager.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_TERMINATED = $00000002;
  /// <summary>
  /// The process crashed.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_CRASHED = $00000003;
  /// <summary>
  /// The process failed to launch.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_LAUNCH_FAILED = $00000004;
  /// <summary>
  /// The process died due to running out of memory.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_OUT_OF_MEMORY = $00000005;
  /// <summary>
  /// The process exited because its corresponding profile was deleted.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_PROFILE_DELETED = $00000006;

type
  /// <summary>
  /// Specifies the datatype for the
  /// ICoreWebView2Profile2.ClearBrowsingData method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_browsing_data_kinds">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS = TOleEnum;
const
  /// <summary>
  /// Specifies file systems data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_FILE_SYSTEMS = 1 shl 0;
  /// <summary>
  /// Specifies data stored by the IndexedDB DOM feature.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_INDEXED_DB = 1 shl 1;
  /// <summary>
  /// Specifies data stored by the localStorage DOM API.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_LOCAL_STORAGE = 1 shl 2;
  /// <summary>
  /// Specifies data stored by the Web SQL database DOM API.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_WEB_SQL = 1 shl 3;
  /// <summary>
  /// Specifies data stored by the CacheStorage DOM API.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_CACHE_STORAGE = 1 shl 4;
  /// <summary>
  /// Specifies DOM storage data, now and future. This browsing data kind is
  /// inclusive of COREWEBVIEW2_BROWSING_DATA_KINDS_FILE_SYSTEMS,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_INDEXED_DB,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_LOCAL_STORAGE,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_WEB_SQL,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_SERVICE_WORKERS,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_CACHE_STORAGE,
  /// and some other data kinds not listed yet to keep consistent with
  /// [DOM-accessible storage](https://www.w3.org/TR/clear-site-data/#storage).
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_DOM_STORAGE = 1 shl 5;
  /// <summary>
  /// Specifies HTTP cookies data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_COOKIES = 1 shl 6;
  /// <summary>
  /// Specifies all site data, now and future. This browsing data kind
  /// is inclusive of COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_DOM_STORAGE and
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_COOKIES. New site data types
  /// may be added to this data kind in the future.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_SITE = 1 shl 7;
  /// <summary>
  /// Specifies disk cache.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_DISK_CACHE = 1 shl 8;
  /// <summary>
  /// Specifies download history data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_DOWNLOAD_HISTORY = 1 shl 9;
  /// <summary>
  /// Specifies general autofill form data.
  /// This excludes password information and includes information like:
  /// names, street and email addresses, phone numbers, and arbitrary input.
  /// This also includes payment data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_GENERAL_AUTOFILL = 1 shl 10;
  /// <summary>
  /// Specifies password autosave data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_PASSWORD_AUTOSAVE = 1 shl 11;
  /// <summary>
  /// Specifies browsing history data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_BROWSING_HISTORY = 1 shl 12;
  /// <summary>
  /// Specifies settings data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_SETTINGS = 1 shl 13;
  /// <summary>
  /// Specifies profile data that should be wiped to make it look like a new profile.
  /// This does not delete account-scoped data like passwords but will remove access
  /// to account-scoped data by signing the user out.
  /// Specifies all profile data, now and future. New profile data types may be added
  /// to this data kind in the future.
  /// This browsing data kind is inclusive of COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_SITE,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_DISK_CACHE,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_DOWNLOAD_HISTORY,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_GENERAL_AUTOFILL,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_PASSWORD_AUTOSAVE,
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_BROWSING_HISTORY, and
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_SETTINGS.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_PROFILE = 1 shl 14;
  /// <summary>
  /// Specifies service workers registered for an origin, and clear will result in
  /// termination and deregistration of them.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_SERVICE_WORKERS = 1 shl 15;

type
  /// <summary>
  /// Tracking prevention levels.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_tracking_prevention_level">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_TRACKING_PREVENTION_LEVEL = TOleEnum;
const
  /// <summary>
  /// Tracking prevention is turned off.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_TRACKING_PREVENTION_LEVEL values.</para>
  /// </remarks>
  COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_NONE = $00000000;
  /// <summary>
  /// The least restrictive level of tracking prevention. Set to this level to
  /// protect against malicious trackers but allows most other trackers and
  /// personalize content and ads.
  ///
  /// See [Current tracking prevention
  /// behavior](/microsoft-edge/web-platform/tracking-prevention#current-tracking-prevention-behavior)
  /// for fine-grained information on what is being blocked with this level and
  /// can change with different Edge versions.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_TRACKING_PREVENTION_LEVEL values.</para>
  /// </remarks>
  COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BASIC = $00000001;
  /// <summary>
  /// The default level of tracking prevention. Set to this level to
  /// protect against social media tracking on top of malicious trackers.
  /// Content and ads will likely be less personalized.
  ///
  /// See [Current tracking prevention
  /// behavior](/microsoft-edge/web-platform/tracking-prevention#current-tracking-prevention-behavior)
  /// for fine-grained information on what is being blocked with this level and
  /// can change with different Edge versions.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_TRACKING_PREVENTION_LEVEL values.</para>
  /// </remarks>
  COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED = $00000002;
  /// <summary>
  /// The most restrictive level of tracking prevention. Set to this level to
  /// protect
  /// against malicious trackers and most trackers across sites. Content and ads
  /// will likely have minimal personalization.
  ///
  /// This level blocks the most trackers but could cause some websites to not
  /// behave as expected.
  ///
  /// See [Current tracking prevention
  /// behavior](/microsoft-edge/web-platform/tracking-prevention#current-tracking-prevention-behavior)
  /// for fine-grained information on what is being blocked with this level and
  /// can change with different Edge versions.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_TRACKING_PREVENTION_LEVEL values.</para>
  /// </remarks>
  COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_STRICT = $00000003;

type
  /// <summary>
  /// PDF toolbar item. This enum must be in sync with ToolBarItem in pdf-store-data-types.ts
  /// Specifies the PDF toolbar item types used for the ICoreWebView2Settings.put_HiddenPdfToolbarItems method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_pdf_toolbar_items">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS = TOleEnum;
const
  /// <summary>
  /// No item
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_NONE = $00000000;
  /// <summary>
  /// The save button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_SAVE = $00000001;
  /// <summary>
  /// The print button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_PRINT = $00000002;
  /// <summary>
  /// The save as button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_SAVE_AS = $00000004;
  /// <summary>
  /// The zoom in button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_ZOOM_IN = $00000008;
  /// <summary>
  /// The zoom out button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_ZOOM_OUT = $00000010;
  /// <summary>
  /// The rotate button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_ROTATE = $00000020;
  /// <summary>
  /// The fit page button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_FIT_PAGE = $00000040;
  /// <summary>
  /// The page layout button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_PAGE_LAYOUT = $00000080;
  /// <summary>
  /// The bookmarks button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_BOOKMARKS = $00000100;
  /// <summary>
  /// The page select button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_PAGE_SELECTOR = $00000200;
  /// <summary>
  /// The search button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_SEARCH = $00000400;
  /// <summary>
  /// The full screen button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_FULL_SCREEN = $00000800;
  /// <summary>
  /// The more settings button
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PDF_TOOLBAR_ITEMS values.</para>
  /// </remarks>
  COREWEBVIEW2_PDF_TOOLBAR_ITEMS_MORE_SETTINGS = $00001000;

type
  /// <summary>
  /// Specifies memory usage target level of WebView.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_memory_usage_target_level">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL = TOleEnum;
const
  /// <summary>
  /// Specifies normal memory usage target level.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL values.</para>
  /// </remarks>
  COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_NORMAL = $00000000;
  /// <summary>
  /// Specifies low memory usage target level.
  /// Used for inactivate WebView for reduced memory consumption.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL values.</para>
  /// </remarks>
  COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_LOW = $00000001;

type
{*
 *********************************************************************
 Forward declaration of types defined in TypeLibrary
 *********************************************************************
*}
  ICoreWebView2AcceleratorKeyPressedEventArgs = interface;
  ICoreWebView2AcceleratorKeyPressedEventHandler = interface;
  ICoreWebView2Controller = interface;
  ICoreWebView2ZoomFactorChangedEventHandler = interface;
  ICoreWebView2MoveFocusRequestedEventHandler = interface;
  ICoreWebView2MoveFocusRequestedEventArgs = interface;
  ICoreWebView2FocusChangedEventHandler = interface;
  ICoreWebView2 = interface;
  ICoreWebView2Settings = interface;
  ICoreWebView2NavigationStartingEventHandler = interface;
  ICoreWebView2NavigationStartingEventArgs = interface;
  ICoreWebView2HttpRequestHeaders = interface;
  ICoreWebView2HttpHeadersCollectionIterator = interface;
  ICoreWebView2ContentLoadingEventHandler = interface;
  ICoreWebView2ContentLoadingEventArgs = interface;
  ICoreWebView2SourceChangedEventHandler = interface;
  ICoreWebView2SourceChangedEventArgs = interface;
  ICoreWebView2HistoryChangedEventHandler = interface;
  ICoreWebView2NavigationCompletedEventHandler = interface;
  ICoreWebView2NavigationCompletedEventArgs = interface;
  ICoreWebView2ScriptDialogOpeningEventHandler = interface;
  ICoreWebView2ScriptDialogOpeningEventArgs = interface;
  ICoreWebView2Deferral = interface;
  ICoreWebView2PermissionRequestedEventHandler = interface;
  ICoreWebView2PermissionRequestedEventArgs = interface;
  ICoreWebView2ProcessFailedEventHandler = interface;
  ICoreWebView2ProcessFailedEventArgs = interface;
  ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler = interface;
  ICoreWebView2ExecuteScriptCompletedHandler = interface;
  ICoreWebView2CapturePreviewCompletedHandler = interface;
  ICoreWebView2WebMessageReceivedEventHandler = interface;
  ICoreWebView2WebMessageReceivedEventArgs = interface;
  ICoreWebView2CallDevToolsProtocolMethodCompletedHandler = interface;
  ICoreWebView2DevToolsProtocolEventReceiver = interface;
  ICoreWebView2DevToolsProtocolEventReceivedEventHandler = interface;
  ICoreWebView2DevToolsProtocolEventReceivedEventArgs = interface;
  ICoreWebView2NewWindowRequestedEventHandler = interface;
  ICoreWebView2NewWindowRequestedEventArgs = interface;
  ICoreWebView2WindowFeatures = interface;
  ICoreWebView2DocumentTitleChangedEventHandler = interface;
  ICoreWebView2ContainsFullScreenElementChangedEventHandler = interface;
  ICoreWebView2WebResourceRequestedEventHandler = interface;
  ICoreWebView2WebResourceRequestedEventArgs = interface;
  ICoreWebView2WebResourceRequest = interface;
  ICoreWebView2WebResourceResponse = interface;
  ICoreWebView2HttpResponseHeaders = interface;
  ICoreWebView2WindowCloseRequestedEventHandler = interface;
  ICoreWebView2_2 = interface;
  ICoreWebView2WebResourceResponseReceivedEventHandler = interface;
  ICoreWebView2WebResourceResponseReceivedEventArgs = interface;
  ICoreWebView2WebResourceResponseView = interface;
  ICoreWebView2WebResourceResponseViewGetContentCompletedHandler = interface;
  ICoreWebView2DOMContentLoadedEventHandler = interface;
  ICoreWebView2DOMContentLoadedEventArgs = interface;
  ICoreWebView2CookieManager = interface;
  ICoreWebView2Cookie = interface;
  ICoreWebView2GetCookiesCompletedHandler = interface;
  ICoreWebView2CookieList = interface;
  ICoreWebView2Environment = interface;
  ICoreWebView2CreateCoreWebView2ControllerCompletedHandler = interface;
  ICoreWebView2NewBrowserVersionAvailableEventHandler = interface;
  ICoreWebView2_3 = interface;
  ICoreWebView2TrySuspendCompletedHandler = interface;
  ICoreWebView2_4 = interface;
  ICoreWebView2FrameCreatedEventHandler = interface;
  ICoreWebView2FrameCreatedEventArgs = interface;
  ICoreWebView2Frame = interface;
  ICoreWebView2FrameNameChangedEventHandler = interface;
  ICoreWebView2FrameDestroyedEventHandler = interface;
  ICoreWebView2DownloadStartingEventHandler = interface;
  ICoreWebView2DownloadStartingEventArgs = interface;
  ICoreWebView2DownloadOperation = interface;
  ICoreWebView2BytesReceivedChangedEventHandler = interface;
  ICoreWebView2EstimatedEndTimeChangedEventHandler = interface;
  ICoreWebView2StateChangedEventHandler = interface;
  ICoreWebView2_5 = interface;
  ICoreWebView2ClientCertificateRequestedEventHandler = interface;
  ICoreWebView2ClientCertificateRequestedEventArgs = interface;
  ICoreWebView2StringCollection = interface;
  ICoreWebView2ClientCertificateCollection = interface;
  ICoreWebView2ClientCertificate = interface;
  ICoreWebView2_6 = interface;
  ICoreWebView2_7 = interface;
  ICoreWebView2PrintSettings = interface;
  ICoreWebView2PrintToPdfCompletedHandler = interface;
  ICoreWebView2_8 = interface;
  ICoreWebView2IsMutedChangedEventHandler = interface;
  ICoreWebView2IsDocumentPlayingAudioChangedEventHandler = interface;
  ICoreWebView2_9 = interface;
  ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler = interface;
  ICoreWebView2_10 = interface;
  ICoreWebView2BasicAuthenticationRequestedEventHandler = interface;
  ICoreWebView2BasicAuthenticationRequestedEventArgs = interface;
  ICoreWebView2BasicAuthenticationResponse = interface;
  ICoreWebView2_11 = interface;
  ICoreWebView2ContextMenuRequestedEventHandler = interface;
  ICoreWebView2ContextMenuRequestedEventArgs = interface;
  ICoreWebView2ContextMenuItemCollection = interface;
  ICoreWebView2ContextMenuItem = interface;
  ICoreWebView2CustomItemSelectedEventHandler = interface;
  ICoreWebView2ContextMenuTarget = interface;
  ICoreWebView2_12 = interface;
  ICoreWebView2StatusBarTextChangedEventHandler = interface;
  ICoreWebView2_13 = interface;
  ICoreWebView2Profile = interface;
  ICoreWebView2_14 = interface;
  ICoreWebView2ServerCertificateErrorDetectedEventHandler = interface;
  ICoreWebView2ServerCertificateErrorDetectedEventArgs = interface;
  ICoreWebView2Certificate = interface;
  ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler = interface;
  ICoreWebView2_15 = interface;
  ICoreWebView2FaviconChangedEventHandler = interface;
  ICoreWebView2GetFaviconCompletedHandler = interface;
  ICoreWebView2_16 = interface;
  ICoreWebView2PrintCompletedHandler = interface;
  ICoreWebView2PrintToPdfStreamCompletedHandler = interface;
  ICoreWebView2_17 = interface;
  ICoreWebView2SharedBuffer = interface;
  ICoreWebView2_18 = interface;
  ICoreWebView2LaunchingExternalUriSchemeEventHandler = interface;
  ICoreWebView2LaunchingExternalUriSchemeEventArgs = interface;
  ICoreWebView2BrowserProcessExitedEventArgs = interface;
  ICoreWebView2BrowserProcessExitedEventHandler = interface;
  ICoreWebView2CompositionController = interface;
  ICoreWebView2PointerInfo = interface;
  ICoreWebView2CursorChangedEventHandler = interface;
  ICoreWebView2CompositionController2 = interface;
  ICoreWebView2CompositionController3 = interface;
  ICoreWebView2Controller2 = interface;
  ICoreWebView2Controller3 = interface;
  ICoreWebView2RasterizationScaleChangedEventHandler = interface;
  ICoreWebView2Controller4 = interface;
  ICoreWebView2ControllerOptions = interface;
  ICoreWebView2ControllerOptions2 = interface;
  ICoreWebView2ClearBrowsingDataCompletedHandler = interface;
  ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler = interface;
  ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler = interface;
  ICoreWebView2CustomSchemeRegistration = interface;
  ICoreWebView2DevToolsProtocolEventReceivedEventArgs2 = interface;
  ICoreWebView2Environment2 = interface;
  ICoreWebView2Environment3 = interface;
  ICoreWebView2Environment4 = interface;
  ICoreWebView2Environment5 = interface;
  ICoreWebView2Environment6 = interface;
  ICoreWebView2Environment7 = interface;
  ICoreWebView2Environment8 = interface;
  ICoreWebView2ProcessInfosChangedEventHandler = interface;
  ICoreWebView2ProcessInfoCollection = interface;
  ICoreWebView2ProcessInfo = interface;
  ICoreWebView2Environment9 = interface;
  ICoreWebView2Environment10 = interface;
  ICoreWebView2Environment11 = interface;
  ICoreWebView2Environment12 = interface;
  ICoreWebView2EnvironmentOptions = interface;
  ICoreWebView2EnvironmentOptions2 = interface;
  ICoreWebView2EnvironmentOptions3 = interface;
  ICoreWebView2EnvironmentOptions4 = interface;
  ICoreWebView2EnvironmentOptions5 = interface;
  ICoreWebView2Frame2 = interface;
  ICoreWebView2FrameNavigationStartingEventHandler = interface;
  ICoreWebView2FrameContentLoadingEventHandler = interface;
  ICoreWebView2FrameNavigationCompletedEventHandler = interface;
  ICoreWebView2FrameDOMContentLoadedEventHandler = interface;
  ICoreWebView2FrameWebMessageReceivedEventHandler = interface;
  ICoreWebView2Frame3 = interface;
  ICoreWebView2FramePermissionRequestedEventHandler = interface;
  ICoreWebView2PermissionRequestedEventArgs2 = interface;
  ICoreWebView2Frame4 = interface;
  ICoreWebView2FrameInfo = interface;
  ICoreWebView2FrameInfoCollection = interface;
  ICoreWebView2FrameInfoCollectionIterator = interface;
  ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler = interface;
  ICoreWebView2PermissionSettingCollectionView = interface;
  ICoreWebView2PermissionSetting = interface;
  ICoreWebView2NavigationCompletedEventArgs2 = interface;
  ICoreWebView2NavigationStartingEventArgs2 = interface;
  ICoreWebView2NavigationStartingEventArgs3 = interface;
  ICoreWebView2NewWindowRequestedEventArgs2 = interface;
  ICoreWebView2PermissionRequestedEventArgs3 = interface;
  ICoreWebView2PrintSettings2 = interface;
  ICoreWebView2ProcessFailedEventArgs2 = interface;
  ICoreWebView2Profile2 = interface;
  ICoreWebView2Profile3 = interface;
  ICoreWebView2Profile4 = interface;
  ICoreWebView2SetPermissionStateCompletedHandler = interface;
  ICoreWebView2Profile5 = interface;
  ICoreWebView2Profile6 = interface;
  ICoreWebView2Settings2 = interface;
  ICoreWebView2Settings3 = interface;
  ICoreWebView2Settings4 = interface;
  ICoreWebView2Settings5 = interface;
  ICoreWebView2Settings6 = interface;
  ICoreWebView2Settings7 = interface;
  ICoreWebView2Settings8 = interface;
  ICoreWebView2_19 = interface;
  ICoreWebView2File = interface;
  ICoreWebView2ObjectCollectionView = interface;
  ICoreWebView2WebMessageReceivedEventArgs2 = interface;

{*
 *********************************************************************
 Declaration of structures, unions and aliases.
 *********************************************************************
*}

  // Missing NativeUInt declaration ************** WEBVIEW4DELPHI **************
  {$IFNDEF FPC}{$IFNDEF DELPHI15_UP}NativeUInt  = Cardinal;{$ENDIF}{$ENDIF}

  // Missing HANDLE declaration ************** WEBVIEW4DELPHI **************
  {$IFNDEF FPC}HANDLE = type NativeUInt;{$ENDIF}

  PPCoreWebView2CustomSchemeRegistration = ^ICoreWebView2CustomSchemeRegistration;

  /// <summary>
  /// Contains the information packed into the LPARAM sent to a Win32 key
  /// event.  For more information about WM_KEYDOWN, navigate to
  /// [WM_KEYDOWN message](/windows/win32/inputdev/wm-keydown).
  /// </summary>
  COREWEBVIEW2_PHYSICAL_KEY_STATUS = record
    /// <summary>
    /// Specifies the repeat count for the current message.
    /// </summary>
    RepeatCount: SYSUINT;
    /// <summary>
    /// Specifies the scan code.
    /// </summary>
    ScanCode: SYSUINT;
    /// <summary>
    /// Indicates that the key is an extended key.
    /// </summary>
    IsExtendedKey: Integer;
    /// <summary>
    /// Indicates that a menu key is held down (context code).
    /// </summary>
    IsMenuKeyDown: Integer;
    /// <summary>
    /// Indicates that the key was held down.
    /// </summary>
    WasKeyDown: Integer;
    /// <summary>
    /// Indicates that the key was released.
    /// </summary>
    IsKeyReleased: Integer;
  end;

  // tagRect is identical to TRect. ************** WEBVIEW4DELPHI **************
  tagRECT = TRect;

  /// <summary>
  /// Represents a reference to a delegate that receives change notifications.
  /// </summary>
  /// <remarks>
  /// <para>Windows.Foundation.EventRegistrationToken. Also defined in Winapi.CommonTypes</para>
  /// </remarks>
  EventRegistrationToken = record
    value: Int64;
  end;

  /// <summary>
  /// A value representing RGBA color (Red, Green, Blue, Alpha) for WebView2.
  /// Each component takes a value from 0 to 255, with 0 being no intensity and 255 being the highest intensity.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_color">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_COLOR = packed record
    /// <summary>
    /// Specifies the intensity of the Alpha ie. opacity value. 0 is transparent, 255 is opaque.
    /// </summary>
    A: Byte;
    /// <summary>
    /// Specifies the intensity of the Red color.
    /// </summary>
    R: Byte;
    /// <summary>
    /// Specifies the intensity of the Green color.
    /// </summary>
    G: Byte;
    /// <summary>
    /// Specifies the intensity of the Blue color.
    /// </summary>
    B: Byte;
  end;


  /// <summary>
  /// Event args for the AcceleratorKeyPressed event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs">See the ICoreWebView2AcceleratorKeyPressedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2AcceleratorKeyPressedEventArgs = interface(IUnknown)
    ['{9F760F8A-FB79-42BE-9990-7B56900FA9C7}']
    function Get_KeyEventKind(out KeyEventKind: COREWEBVIEW2_KEY_EVENT_KIND): HResult; stdcall;
    function Get_VirtualKey(out VirtualKey: SYSUINT): HResult; stdcall;
    function Get_KeyEventLParam(out lParam: SYSINT): HResult; stdcall;
    function Get_PhysicalKeyStatus(out PhysicalKeyStatus: COREWEBVIEW2_PHYSICAL_KEY_STATUS): HResult; stdcall;
    function Get_Handled(out Handled: Integer): HResult; stdcall;
    function Set_Handled(Handled: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives AcceleratorKeyPressed events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventhandler">See the ICoreWebView2AcceleratorKeyPressedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2AcceleratorKeyPressedEventHandler = interface(IUnknown)
    ['{B29C7E28-FA79-41A8-8E44-65811C76DCB2}']
    function Invoke(const sender: ICoreWebView2Controller; 
                    const args: ICoreWebView2AcceleratorKeyPressedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Provides the event args for the corresponding event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller">See the ICoreWebView2Controller article.</see></para>
  /// </remarks>
  ICoreWebView2Controller = interface(IUnknown)
    ['{4D00C0D1-9434-4EB6-8078-8697A560334F}']
    function Get_IsVisible(out IsVisible: Integer): HResult; stdcall;
    function Set_IsVisible(IsVisible: Integer): HResult; stdcall;
    function Get_Bounds(out Bounds: tagRECT): HResult; stdcall;
    function Set_Bounds(Bounds: tagRECT): HResult; stdcall;
    function Get_ZoomFactor(out ZoomFactor: Double): HResult; stdcall;
    function Set_ZoomFactor(ZoomFactor: Double): HResult; stdcall;
    function add_ZoomFactorChanged(const eventHandler: ICoreWebView2ZoomFactorChangedEventHandler; 
                                   out token: EventRegistrationToken): HResult; stdcall;
    function remove_ZoomFactorChanged(token: EventRegistrationToken): HResult; stdcall;
    function SetBoundsAndZoomFactor(Bounds: tagRECT; ZoomFactor: Double): HResult; stdcall;
    function MoveFocus(reason: COREWEBVIEW2_MOVE_FOCUS_REASON): HResult; stdcall;
    function add_MoveFocusRequested(const eventHandler: ICoreWebView2MoveFocusRequestedEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_MoveFocusRequested(token: EventRegistrationToken): HResult; stdcall;
    function add_GotFocus(const eventHandler: ICoreWebView2FocusChangedEventHandler; 
                          out token: EventRegistrationToken): HResult; stdcall;
    function remove_GotFocus(token: EventRegistrationToken): HResult; stdcall;
    function add_LostFocus(const eventHandler: ICoreWebView2FocusChangedEventHandler; 
                           out token: EventRegistrationToken): HResult; stdcall;
    function remove_LostFocus(token: EventRegistrationToken): HResult; stdcall;
    function add_AcceleratorKeyPressed(const eventHandler: ICoreWebView2AcceleratorKeyPressedEventHandler; 
                                       out token: EventRegistrationToken): HResult; stdcall;
    function remove_AcceleratorKeyPressed(token: EventRegistrationToken): HResult; stdcall;
    // ParentWindow: wireHWND --> ParentWindow: HWND    ************** WEBVIEW4DELPHI **************
    function Get_ParentWindow(out ParentWindow: HWND): HResult; stdcall;
    // ParentWindow: wireHWND --> ParentWindow: HWND    ************** WEBVIEW4DELPHI **************
    function Set_ParentWindow(ParentWindow: HWND): HResult; stdcall;
    function NotifyParentWindowPositionChanged: HResult; stdcall;
    function Close: HResult; stdcall;
    function Get_CoreWebView2(out CoreWebView2: ICoreWebView2): HResult; stdcall;
  end;

  /// <summary>
  /// Implements the interface to receive ZoomFactorChanged events.  Use the
  /// ICoreWebView2Controller.ZoomFactor property to get the modified zoom
  /// factor.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2zoomfactorchangedeventhandler">See the ICoreWebView2ZoomFactorChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ZoomFactorChangedEventHandler = interface(IUnknown)
    ['{B52D71D6-C4DF-4543-A90C-64A3E60F38CB}']
    function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives MoveFocusRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2movefocusrequestedeventhandler">See the ICoreWebView2MoveFocusRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2MoveFocusRequestedEventHandler = interface(IUnknown)
    ['{69035451-6DC7-4CB8-9BCE-B2BD70AD289F}']
    function Invoke(const sender: ICoreWebView2Controller; 
                    const args: ICoreWebView2MoveFocusRequestedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the MoveFocusRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2movefocusrequestedeventargs">See the ICoreWebView2MoveFocusRequestedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2MoveFocusRequestedEventArgs = interface(IUnknown)
    ['{2D6AA13B-3839-4A15-92FC-D88B3C0D9C9D}']
    function Get_reason(out reason: COREWEBVIEW2_MOVE_FOCUS_REASON): HResult; stdcall;
    function Get_Handled(out value: Integer): HResult; stdcall;
    function Set_Handled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives GotFocus and LostFocus events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2focuschangedeventhandler">See the ICoreWebView2FocusChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FocusChangedEventHandler = interface(IUnknown)
    ['{05EA24BD-6452-4926-9014-4B82B498135D}']
    function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// WebView2 enables you to host web content using the latest Microsoft Edge
  /// browser and web technology.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2">See the ICoreWebView2 article.</see></para>
  /// </remarks>
  ICoreWebView2 = interface(IUnknown)
    ['{76ECEACB-0462-4D94-AC83-423A6793775E}']
    function Get_Settings(out Settings: ICoreWebView2Settings): HResult; stdcall;
    function Get_Source(out uri: PWideChar): HResult; stdcall;
    function Navigate(uri: PWideChar): HResult; stdcall;
    function NavigateToString(htmlContent: PWideChar): HResult; stdcall;
    function add_NavigationStarting(const eventHandler: ICoreWebView2NavigationStartingEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_NavigationStarting(token: EventRegistrationToken): HResult; stdcall;
    function add_ContentLoading(const eventHandler: ICoreWebView2ContentLoadingEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    function remove_ContentLoading(token: EventRegistrationToken): HResult; stdcall;
    function add_SourceChanged(const eventHandler: ICoreWebView2SourceChangedEventHandler; 
                               out token: EventRegistrationToken): HResult; stdcall;
    function remove_SourceChanged(token: EventRegistrationToken): HResult; stdcall;
    function add_HistoryChanged(const eventHandler: ICoreWebView2HistoryChangedEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    function remove_HistoryChanged(token: EventRegistrationToken): HResult; stdcall;
    function add_NavigationCompleted(const eventHandler: ICoreWebView2NavigationCompletedEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    function remove_NavigationCompleted(token: EventRegistrationToken): HResult; stdcall;
    function add_FrameNavigationStarting(const eventHandler: ICoreWebView2NavigationStartingEventHandler; 
                                         out token: EventRegistrationToken): HResult; stdcall;
    function remove_FrameNavigationStarting(token: EventRegistrationToken): HResult; stdcall;
    function add_FrameNavigationCompleted(const eventHandler: ICoreWebView2NavigationCompletedEventHandler; 
                                          out token: EventRegistrationToken): HResult; stdcall;
    function remove_FrameNavigationCompleted(token: EventRegistrationToken): HResult; stdcall;
    function add_ScriptDialogOpening(const eventHandler: ICoreWebView2ScriptDialogOpeningEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    function remove_ScriptDialogOpening(token: EventRegistrationToken): HResult; stdcall;
    function add_PermissionRequested(const eventHandler: ICoreWebView2PermissionRequestedEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    function remove_PermissionRequested(token: EventRegistrationToken): HResult; stdcall;
    function add_ProcessFailed(const eventHandler: ICoreWebView2ProcessFailedEventHandler; 
                               out token: EventRegistrationToken): HResult; stdcall;
    function remove_ProcessFailed(token: EventRegistrationToken): HResult; stdcall;
    function AddScriptToExecuteOnDocumentCreated(javaScript: PWideChar; 
                                                 const handler: ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler): HResult; stdcall;
    function RemoveScriptToExecuteOnDocumentCreated(id: PWideChar): HResult; stdcall;
    function ExecuteScript(javaScript: PWideChar; 
                           const handler: ICoreWebView2ExecuteScriptCompletedHandler): HResult; stdcall;
    function CapturePreview(imageFormat: COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT; 
                            const imageStream: IStream; 
                            const handler: ICoreWebView2CapturePreviewCompletedHandler): HResult; stdcall;
    function Reload: HResult; stdcall;
    function PostWebMessageAsJson(webMessageAsJson: PWideChar): HResult; stdcall;
    function PostWebMessageAsString(webMessageAsString: PWideChar): HResult; stdcall;
    function add_WebMessageReceived(const handler: ICoreWebView2WebMessageReceivedEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_WebMessageReceived(token: EventRegistrationToken): HResult; stdcall;
    function CallDevToolsProtocolMethod(methodName: PWideChar; parametersAsJson: PWideChar; 
                                        const handler: ICoreWebView2CallDevToolsProtocolMethodCompletedHandler): HResult; stdcall;
    function Get_BrowserProcessId(out value: SYSUINT): HResult; stdcall;
    function Get_CanGoBack(out CanGoBack: Integer): HResult; stdcall;
    function Get_CanGoForward(out CanGoForward: Integer): HResult; stdcall;
    function GoBack: HResult; stdcall;
    function GoForward: HResult; stdcall;
    function GetDevToolsProtocolEventReceiver(eventName: PWideChar; 
                                              out receiver: ICoreWebView2DevToolsProtocolEventReceiver): HResult; stdcall;
    function Stop: HResult; stdcall;
    function add_NewWindowRequested(const eventHandler: ICoreWebView2NewWindowRequestedEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_NewWindowRequested(token: EventRegistrationToken): HResult; stdcall;
    function add_DocumentTitleChanged(const eventHandler: ICoreWebView2DocumentTitleChangedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    function remove_DocumentTitleChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_DocumentTitle(out title: PWideChar): HResult; stdcall;
    function AddHostObjectToScript(name: PWideChar; const object_: OleVariant): HResult; stdcall;
    function RemoveHostObjectFromScript(name: PWideChar): HResult; stdcall;
    function OpenDevToolsWindow: HResult; stdcall;
    function add_ContainsFullScreenElementChanged(const eventHandler: ICoreWebView2ContainsFullScreenElementChangedEventHandler; 
                                                  out token: EventRegistrationToken): HResult; stdcall;
    function remove_ContainsFullScreenElementChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_ContainsFullScreenElement(out ContainsFullScreenElement: Integer): HResult; stdcall;
    function add_WebResourceRequested(const eventHandler: ICoreWebView2WebResourceRequestedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    function remove_WebResourceRequested(token: EventRegistrationToken): HResult; stdcall;
    function AddWebResourceRequestedFilter(uri: PWideChar; 
                                           ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT): HResult; stdcall;
    function RemoveWebResourceRequestedFilter(uri: PWideChar; 
                                              ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT): HResult; stdcall;
    function add_WindowCloseRequested(const eventHandler: ICoreWebView2WindowCloseRequestedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    function remove_WindowCloseRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Defines properties that enable, disable, or modify WebView features.
  /// Changes to IsGeneralAutofillEnabled and IsPasswordAutosaveEnabled
  /// apply immediately, while other setting changes made after NavigationStarting
  /// event do not apply until the next top-level navigation.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings">See the ICoreWebView2Settings article.</see></para>
  /// </remarks>
  ICoreWebView2Settings = interface(IUnknown)
    ['{E562E4F0-D7FA-43AC-8D71-C05150499F00}']
    function Get_IsScriptEnabled(out IsScriptEnabled: Integer): HResult; stdcall;
    function Set_IsScriptEnabled(IsScriptEnabled: Integer): HResult; stdcall;
    function Get_IsWebMessageEnabled(out IsWebMessageEnabled: Integer): HResult; stdcall;
    function Set_IsWebMessageEnabled(IsWebMessageEnabled: Integer): HResult; stdcall;
    function Get_AreDefaultScriptDialogsEnabled(out AreDefaultScriptDialogsEnabled: Integer): HResult; stdcall;
    function Set_AreDefaultScriptDialogsEnabled(AreDefaultScriptDialogsEnabled: Integer): HResult; stdcall;
    function Get_IsStatusBarEnabled(out IsStatusBarEnabled: Integer): HResult; stdcall;
    function Set_IsStatusBarEnabled(IsStatusBarEnabled: Integer): HResult; stdcall;
    function Get_AreDevToolsEnabled(out AreDevToolsEnabled: Integer): HResult; stdcall;
    function Set_AreDevToolsEnabled(AreDevToolsEnabled: Integer): HResult; stdcall;
    function Get_AreDefaultContextMenusEnabled(out enabled: Integer): HResult; stdcall;
    function Set_AreDefaultContextMenusEnabled(enabled: Integer): HResult; stdcall;
    function Get_AreHostObjectsAllowed(out allowed: Integer): HResult; stdcall;
    function Set_AreHostObjectsAllowed(allowed: Integer): HResult; stdcall;
    function Get_IsZoomControlEnabled(out enabled: Integer): HResult; stdcall;
    function Set_IsZoomControlEnabled(enabled: Integer): HResult; stdcall;
    function Get_IsBuiltInErrorPageEnabled(out enabled: Integer): HResult; stdcall;
    function Set_IsBuiltInErrorPageEnabled(enabled: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NavigationStarting events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventhandler">See the ICoreWebView2NavigationStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationStartingEventHandler = interface(IUnknown)
    ['{9ADBE429-F36D-432B-9DDC-F8881FBD76E3}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the NavigationStarting event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs">See the ICoreWebView2NavigationStartingEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationStartingEventArgs = interface(IUnknown)
    ['{5B495469-E119-438A-9B18-7604F25F2E49}']
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    function Get_IsUserInitiated(out IsUserInitiated: Integer): HResult; stdcall;
    function Get_IsRedirected(out IsRedirected: Integer): HResult; stdcall;
    function Get_RequestHeaders(out RequestHeaders: ICoreWebView2HttpRequestHeaders): HResult; stdcall;
    function Get_Cancel(out Cancel: Integer): HResult; stdcall;
    function Set_Cancel(Cancel: Integer): HResult; stdcall;
    function Get_NavigationId(out NavigationId: Largeuint): HResult; stdcall;
  end;

  /// <summary>
  /// HTTP request headers.  Used to inspect the HTTP request on
  /// WebResourceRequested event and NavigationStarting event.
  /// </summary>
  /// <remarks>
  /// <para>It is possible to modify the HTTP request from a WebResourceRequested event, but not from a NavigationStarting event.</para>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httprequestheaders">See the ICoreWebView2HttpRequestHeaders article.</see></para>
  /// </remarks>
  ICoreWebView2HttpRequestHeaders = interface(IUnknown)
    ['{E86CAC0E-5523-465C-B536-8FB9FC8C8C60}']
    function GetHeader(name: PWideChar; out value: PWideChar): HResult; stdcall;
    function GetHeaders(name: PWideChar; out iterator: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
    function Contains(name: PWideChar; out Contains: Integer): HResult; stdcall;
    function SetHeader(name: PWideChar; value: PWideChar): HResult; stdcall;
    function RemoveHeader(name: PWideChar): HResult; stdcall;
    function GetIterator(out iterator: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
  end;

  /// <summary>
  /// Iterator for a collection of HTTP headers.  For more information, navigate
  /// to ICoreWebView2HttpRequestHeaders and ICoreWebView2HttpResponseHeaders.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpheaderscollectioniterator">See the ICoreWebView2HttpHeadersCollectionIterator article.</see></para>
  /// </remarks>
  ICoreWebView2HttpHeadersCollectionIterator = interface(IUnknown)
    ['{0702FC30-F43B-47BB-AB52-A42CB552AD9F}']
    function GetCurrentHeader(out name: PWideChar; out value: PWideChar): HResult; stdcall;
    function Get_HasCurrentHeader(out hasCurrent: Integer): HResult; stdcall;
    function MoveNext(out hasNext: Integer): HResult; stdcall;
  end;

  /// <summary>
  ///
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contentloadingeventhandler">See the ICoreWebView2ContentLoadingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ContentLoadingEventHandler = interface(IUnknown)
    ['{364471E7-F2BE-4910-BDBA-D72077D51C4B}']
    function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives ContentLoading events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contentloadingeventargs">See the ICoreWebView2ContentLoadingEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2ContentLoadingEventArgs = interface(IUnknown)
    ['{0C8A1275-9B6B-4901-87AD-70DF25BAFA6E}']
    function Get_IsErrorPage(out IsErrorPage: Integer): HResult; stdcall;
    function Get_NavigationId(out NavigationId: Largeuint): HResult; stdcall;
  end;

  /// <summary>
  /// Receives SourceChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sourcechangedeventhandler">See the ICoreWebView2SourceChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2SourceChangedEventHandler = interface(IUnknown)
    ['{3C067F9F-5388-4772-8B48-79F7EF1AB37C}']
    function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SourceChangedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the SourceChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sourcechangedeventargs">See the ICoreWebView2SourceChangedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2SourceChangedEventArgs = interface(IUnknown)
    ['{31E0E545-1DBA-4266-8914-F63848A1F7D7}']
    function Get_IsNewDocument(out IsNewDocument: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives HistoryChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2historychangedeventhandler">See the ICoreWebView2HistoryChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2HistoryChangedEventHandler = interface(IUnknown)
    ['{C79A420C-EFD9-4058-9295-3E8B4BCAB645}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NavigationCompleted events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventhandler">See the ICoreWebView2NavigationCompletedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationCompletedEventHandler = interface(IUnknown)
    ['{D33A35BF-1C49-4F98-93AB-006E0533FE1C}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the NavigationCompleted event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventargs">See the ICoreWebView2NavigationCompletedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationCompletedEventArgs = interface(IUnknown)
    ['{30D68B7D-20D9-4752-A9CA-EC8448FBB5C1}']
    function Get_IsSuccess(out IsSuccess: Integer): HResult; stdcall;
    function Get_WebErrorStatus(out WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS): HResult; stdcall;
    function Get_NavigationId(out NavigationId: Largeuint): HResult; stdcall;
  end;

  /// <summary>
  /// Receives ScriptDialogOpening events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventhandler">See the ICoreWebView2ScriptDialogOpeningEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ScriptDialogOpeningEventHandler = interface(IUnknown)
    ['{EF381BF9-AFA8-4E37-91C4-8AC48524BDFB}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2ScriptDialogOpeningEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the ScriptDialogOpening event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptdialogopeningeventargs">See the ICoreWebView2ScriptDialogOpeningEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2ScriptDialogOpeningEventArgs = interface(IUnknown)
    ['{7390BB70-ABE0-4843-9529-F143B31B03D6}']
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    function Get_Kind(out Kind: COREWEBVIEW2_SCRIPT_DIALOG_KIND): HResult; stdcall;
    function Get_Message(out Message: PWideChar): HResult; stdcall;
    function Accept: HResult; stdcall;
    function Get_DefaultText(out DefaultText: PWideChar): HResult; stdcall;
    function Get_ResultText(out ResultText: PWideChar): HResult; stdcall;
    function Set_ResultText(ResultText: PWideChar): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is used to complete deferrals on event args that support
  /// getting deferrals using the GetDeferral method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2deferral">See the ICoreWebView2Deferral article.</see></para>
  /// </remarks>
  ICoreWebView2Deferral = interface(IUnknown)
    ['{C10E7F7B-B585-46F0-A623-8BEFBF3E4EE0}']
    function Complete: HResult; stdcall;
  end;

  /// <summary>
  /// Receives PermissionRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventhandler">See the ICoreWebView2PermissionRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2PermissionRequestedEventHandler = interface(IUnknown)
    ['{15E1C6A3-C72A-4DF3-91D7-D097FBEC6BFD}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2PermissionRequestedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the PermissionRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs">See the ICoreWebView2PermissionRequestedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2PermissionRequestedEventArgs = interface(IUnknown)
    ['{973AE2EF-FF18-4894-8FB2-3C758F046810}']
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    function Get_PermissionKind(out PermissionKind: COREWEBVIEW2_PERMISSION_KIND): HResult; stdcall;
    function Get_IsUserInitiated(out IsUserInitiated: Integer): HResult; stdcall;
    function Get_State(out State: COREWEBVIEW2_PERMISSION_STATE): HResult; stdcall;
    function Set_State(State: COREWEBVIEW2_PERMISSION_STATE): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// Receives ProcessFailed events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventhandler">See the ICoreWebView2ProcessFailedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessFailedEventHandler = interface(IUnknown)
    ['{79E0AEA4-990B-42D9-AA1D-0FCC2E5BC7F1}']
    function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2ProcessFailedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the ProcessFailed event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs">See the ICoreWebView2ProcessFailedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessFailedEventArgs = interface(IUnknown)
    ['{8155A9A4-1474-4A86-8CAE-151B0FA6B8CA}']
    function Get_ProcessFailedKind(out ProcessFailedKind: COREWEBVIEW2_PROCESS_FAILED_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the AddScriptToExecuteOnDocumentCreated method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2addscripttoexecuteondocumentcreatedcompletedhandler">See the ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler = interface(IUnknown)
    ['{B99369F3-9B11-47B5-BC6F-8E7895FCEA17}']
    function Invoke(errorCode: HResult; id: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the ExecuteScript method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2executescriptcompletedhandler">See the ICoreWebView2ExecuteScriptCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ExecuteScriptCompletedHandler = interface(IUnknown)
    ['{49511172-CC67-4BCA-9923-137112F4C4CC}']
    function Invoke(errorCode: HResult; resultObjectAsJson: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the CapturePreview method.  The result is written
  /// to the stream provided in the CapturePreview method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2capturepreviewcompletedhandler">See the ICoreWebView2CapturePreviewCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CapturePreviewCompletedHandler = interface(IUnknown)
    ['{697E05E9-3D8F-45FA-96F4-8FFE1EDEDAF5}']
    function Invoke(errorCode: HResult): HResult; stdcall;
  end;

  /// <summary>
  /// Receives WebMessageReceived events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventhandler">See the ICoreWebView2WebMessageReceivedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WebMessageReceivedEventHandler = interface(IUnknown)
    ['{57213F19-00E6-49FA-8E07-898EA01ECBD2}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the WebMessageReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventargs">See the ICoreWebView2WebMessageReceivedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2WebMessageReceivedEventArgs = interface(IUnknown)
    ['{0F99A40C-E962-4207-9E92-E3D542EFF849}']
    function Get_Source(out Source: PWideChar): HResult; stdcall;
    function Get_webMessageAsJson(out webMessageAsJson: PWideChar): HResult; stdcall;
    function TryGetWebMessageAsString(out webMessageAsString: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives CallDevToolsProtocolMethod completion results.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2calldevtoolsprotocolmethodcompletedhandler">See the ICoreWebView2CallDevToolsProtocolMethodCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CallDevToolsProtocolMethodCompletedHandler = interface(IUnknown)
    ['{5C4889F0-5EF6-4C5A-952C-D8F1B92D0574}']
    function Invoke(errorCode: HResult; returnObjectAsJson: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A Receiver is created for a particular DevTools Protocol event and allows
  /// you to subscribe and unsubscribe from that event.  Obtained from the
  /// WebView object using GetDevToolsProtocolEventReceiver.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceiver">See the ICoreWebView2DevToolsProtocolEventReceiver article.</see></para>
  /// </remarks>
  ICoreWebView2DevToolsProtocolEventReceiver = interface(IUnknown)
    ['{B32CA51A-8371-45E9-9317-AF021D080367}']
    function add_DevToolsProtocolEventReceived(const handler: ICoreWebView2DevToolsProtocolEventReceivedEventHandler; 
                                               out token: EventRegistrationToken): HResult; stdcall;
    function remove_DevToolsProtocolEventReceived(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives DevToolsProtocolEventReceived events from the WebView.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventhandler">See the ICoreWebView2DevToolsProtocolEventReceivedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2DevToolsProtocolEventReceivedEventHandler = interface(IUnknown)
    ['{E2FDA4BE-5456-406C-A261-3D452138362C}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2DevToolsProtocolEventReceivedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the DevToolsProtocolEventReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventargs">See the ICoreWebView2DevToolsProtocolEventReceivedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2DevToolsProtocolEventReceivedEventArgs = interface(IUnknown)
    ['{653C2959-BB3A-4377-8632-B58ADA4E66C4}']
    function Get_ParameterObjectAsJson(out ParameterObjectAsJson: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NewWindowRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventhandler">See the ICoreWebView2NewWindowRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NewWindowRequestedEventHandler = interface(IUnknown)
    ['{D4C185FE-C81C-4989-97AF-2D3FA7AB5651}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2NewWindowRequestedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the NewWindowRequested event.  The event is run when
  /// content inside webview requested to a open a new window (through
  /// window.open() and so on).
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs">See the ICoreWebView2NewWindowRequestedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2NewWindowRequestedEventArgs = interface(IUnknown)
    ['{34ACB11C-FC37-4418-9132-F9C21D1EAFB9}']
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    function Set_NewWindow(const NewWindow: ICoreWebView2): HResult; stdcall;
    function Get_NewWindow(out NewWindow: ICoreWebView2): HResult; stdcall;
    function Set_Handled(Handled: Integer): HResult; stdcall;
    function Get_Handled(out Handled: Integer): HResult; stdcall;
    function Get_IsUserInitiated(out IsUserInitiated: Integer): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
    function Get_WindowFeatures(out value: ICoreWebView2WindowFeatures): HResult; stdcall;
  end;

  /// <summary>
  /// The window features for a WebView popup window.  The fields match the
  /// windowFeatures passed to window.open as specified in
  /// [Window features](https://developer.mozilla.org/docs/Web/API/Window/open#Window_features)
  /// on MDN.
  ///
  /// There is no requirement for you to respect the values.  If your app does
  /// not have corresponding UI features (for example, no toolbar) or if all
  /// instance of WebView are opened in tabs and do not have distinct size or
  /// positions, then your app does not respect the values.  You may want to
  /// respect values, but perhaps only some apply to the UI of you app.
  /// Accordingly, you may respect all, some, or none of the properties as
  /// appropriate for your app.  For all numeric properties, if the value that is
  /// passed to window.open is outside the range of an unsigned 32bit int, the
  /// resulting value is the absolute value of the maximum for unsigned 32bit
  /// integer.  If you are not able to parse the value an integer, it is
  /// considered 0.  If the value is a floating point value, it is rounded down
  /// to an integer.
  ///
  /// In runtime versions 98 or later, the values of ShouldDisplayMenuBar,
  /// ShouldDisplayStatus, ShouldDisplayToolbar, and ShouldDisplayScrollBars
  /// will not directly depend on the equivalent fields in the windowFeatures
  /// string.  Instead, they will all be false if the window is expected to be a
  /// popup, and true if it is not.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures">See the ICoreWebView2WindowFeatures article.</see></para>
  /// </remarks>
  ICoreWebView2WindowFeatures = interface(IUnknown)
    ['{5EAF559F-B46E-4397-8860-E422F287FF1E}']
    function Get_HasPosition(out value: Integer): HResult; stdcall;
    function Get_HasSize(out value: Integer): HResult; stdcall;
    function Get_left(out value: SYSUINT): HResult; stdcall;
    function Get_top(out value: SYSUINT): HResult; stdcall;
    function Get_Height(out value: SYSUINT): HResult; stdcall;
    function Get_Width(out value: SYSUINT): HResult; stdcall;
    function Get_ShouldDisplayMenuBar(out value: Integer): HResult; stdcall;
    function Get_ShouldDisplayStatus(out value: Integer): HResult; stdcall;
    function Get_ShouldDisplayToolbar(out value: Integer): HResult; stdcall;
    function Get_ShouldDisplayScrollBars(out value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives DocumentTitleChanged events.  Use the DocumentTitle property
  /// to get the modified title.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2documenttitlechangedeventhandler">See the ICoreWebView2DocumentTitleChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2DocumentTitleChangedEventHandler = interface(IUnknown)
    ['{F5F2B923-953E-4042-9F95-F3A118E1AFD4}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives ContainsFullScreenElementChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2containsfullscreenelementchangedeventhandler">See the ICoreWebView2ContainsFullScreenElementChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ContainsFullScreenElementChangedEventHandler = interface(IUnknown)
    ['{E45D98B1-AFEF-45BE-8BAF-6C7728867F73}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Runs when a URL request (through network, file, and so on) is made in
  /// the webview for a Web resource matching resource context filter and URL
  /// specified in AddWebResourceRequestedFilter.  The host views and modifies
  /// the request or provide a response in a similar pattern to HTTP, in which
  /// case the request immediately completed.  This may not contain any request
  /// headers that are added by the network stack, such as an Authorization
  /// header.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventhandler">See the ICoreWebView2WebResourceRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceRequestedEventHandler = interface(IUnknown)
    ['{AB00B74C-15F1-4646-80E8-E76341D25D71}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2WebResourceRequestedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs">See the ICoreWebView2WebResourceRequestedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceRequestedEventArgs = interface(IUnknown)
    ['{453E667F-12C7-49D4-BE6D-DDBE7956F57A}']
    function Get_Request(out Request: ICoreWebView2WebResourceRequest): HResult; stdcall;
    function Get_Response(out Response: ICoreWebView2WebResourceResponse): HResult; stdcall;
    function Set_Response(const Response: ICoreWebView2WebResourceResponse): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
    function Get_ResourceContext(out context: COREWEBVIEW2_WEB_RESOURCE_CONTEXT): HResult; stdcall;
  end;

  /// <summary>
  /// An HTTP request used with the WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequest">See the ICoreWebView2WebResourceRequest article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceRequest = interface(IUnknown)
    ['{97055CD4-512C-4264-8B5F-E3F446CEA6A5}']
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    function Set_uri(uri: PWideChar): HResult; stdcall;
    function Get_Method(out Method: PWideChar): HResult; stdcall;
    function Set_Method(Method: PWideChar): HResult; stdcall;
    function Get_Content(out Content: IStream): HResult; stdcall;
    function Set_Content(const Content: IStream): HResult; stdcall;
    function Get_Headers(out Headers: ICoreWebView2HttpRequestHeaders): HResult; stdcall;
  end;

  /// <summary>
  /// An HTTP response used with the WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponse">See the ICoreWebView2WebResourceResponse article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceResponse = interface(IUnknown)
    ['{AAFCC94F-FA27-48FD-97DF-830EF75AAEC9}']
    function Get_Content(out Content: IStream): HResult; stdcall;
    function Set_Content(const Content: IStream): HResult; stdcall;
    function Get_Headers(out Headers: ICoreWebView2HttpResponseHeaders): HResult; stdcall;
    function Get_StatusCode(out StatusCode: SYSINT): HResult; stdcall;
    function Set_StatusCode(StatusCode: SYSINT): HResult; stdcall;
    function Get_ReasonPhrase(out ReasonPhrase: PWideChar): HResult; stdcall;
    function Set_ReasonPhrase(ReasonPhrase: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// HTTP response headers.  Used to construct a WebResourceResponse for the
  /// WebResourceRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2httpresponseheaders">See the ICoreWebView2HttpResponseHeaders article.</see></para>
  /// </remarks>
  ICoreWebView2HttpResponseHeaders = interface(IUnknown)
    ['{03C5FF5A-9B45-4A88-881C-89A9F328619C}']
    function AppendHeader(name: PWideChar; value: PWideChar): HResult; stdcall;
    function Contains(name: PWideChar; out Contains: Integer): HResult; stdcall;
    function GetHeader(name: PWideChar; out value: PWideChar): HResult; stdcall;
    function GetHeaders(name: PWideChar; out iterator: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
    function GetIterator(out iterator: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
  end;

  /// <summary>
  /// Receives WindowCloseRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowcloserequestedeventhandler">See the ICoreWebView2WindowCloseRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WindowCloseRequestedEventHandler = interface(IUnknown)
    ['{5C19E9E0-092F-486B-AFFA-CA8231913039}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2">See the ICoreWebView2_2 article.</see></para>
  /// </remarks>
  ICoreWebView2_2 = interface(ICoreWebView2)
    ['{9E8F0CF8-E670-4B5E-B2BC-73E061E3184C}']
    function add_WebResourceResponseReceived(const eventHandler: ICoreWebView2WebResourceResponseReceivedEventHandler; 
                                             out token: EventRegistrationToken): HResult; stdcall;
    function remove_WebResourceResponseReceived(token: EventRegistrationToken): HResult; stdcall;
    function NavigateWithWebResourceRequest(const Request: ICoreWebView2WebResourceRequest): HResult; stdcall;
    function add_DOMContentLoaded(const eventHandler: ICoreWebView2DOMContentLoadedEventHandler; 
                                  out token: EventRegistrationToken): HResult; stdcall;
    function remove_DOMContentLoaded(token: EventRegistrationToken): HResult; stdcall;
    function Get_CookieManager(out CookieManager: ICoreWebView2CookieManager): HResult; stdcall;
    function Get_Environment(out Environment: ICoreWebView2Environment): HResult; stdcall;
  end;

  /// <summary>
  /// Receives WebResourceResponseReceived events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponsereceivedeventhandler">See the ICoreWebView2WebResourceResponseReceivedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceResponseReceivedEventHandler = interface(IUnknown)
    ['{7DE9898A-24F5-40C3-A2DE-D4F458E69828}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2WebResourceResponseReceivedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the WebResourceResponseReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponsereceivedeventargs">See the ICoreWebView2WebResourceResponseReceivedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceResponseReceivedEventArgs = interface(IUnknown)
    ['{D1DB483D-6796-4B8B-80FC-13712BB716F4}']
    function Get_Request(out Request: ICoreWebView2WebResourceRequest): HResult; stdcall;
    function Get_Response(out Response: ICoreWebView2WebResourceResponseView): HResult; stdcall;
  end;

  /// <summary>
  /// View of the HTTP representation for a web resource response. The properties
  /// of this object are not mutable. This response view is used with the
  /// WebResourceResponseReceived event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseview">See the ICoreWebView2WebResourceResponseView article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceResponseView = interface(IUnknown)
    ['{79701053-7759-4162-8F7D-F1B3F084928D}']
    function Get_Headers(out Headers: ICoreWebView2HttpResponseHeaders): HResult; stdcall;
    function Get_StatusCode(out StatusCode: SYSINT): HResult; stdcall;
    function Get_ReasonPhrase(out ReasonPhrase: PWideChar): HResult; stdcall;
    function GetContent(const handler: ICoreWebView2WebResourceResponseViewGetContentCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the ICoreWebView2WebResourceResponseView.GetContent method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseviewgetcontentcompletedhandler">See the ICoreWebView2WebResourceResponseViewGetContentCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceResponseViewGetContentCompletedHandler = interface(IUnknown)
    ['{875738E1-9FA2-40E3-8B74-2E8972DD6FE7}']
    function Invoke(errorCode: HResult; const Content: IStream): HResult; stdcall;
  end;

  /// <summary>
  /// Receives DOMContentLoaded events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2domcontentloadedeventhandler">See the ICoreWebView2DOMContentLoadedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2DOMContentLoadedEventHandler = interface(IUnknown)
    ['{4BAC7E9C-199E-49ED-87ED-249303ACF019}']
    function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the DOMContentLoaded event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2domcontentloadedeventargs">See the ICoreWebView2DOMContentLoadedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2DOMContentLoadedEventArgs = interface(IUnknown)
    ['{16B1E21A-C503-44F2-84C9-70ABA5031283}']
    function Get_NavigationId(out NavigationId: Largeuint): HResult; stdcall;
  end;

  /// <summary>
  /// Creates, adds or updates, gets, or or view the cookies. The changes would
  /// apply to the context of the user profile. That is, other WebViews under the
  /// same user profile could be affected.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookiemanager">See the ICoreWebView2CookieManager article.</see></para>
  /// </remarks>
  ICoreWebView2CookieManager = interface(IUnknown)
    ['{177CD9E7-B6F5-451A-94A0-5D7A3A4C4141}']
    function CreateCookie(name: PWideChar; value: PWideChar; Domain: PWideChar; Path: PWideChar; 
                          out cookie: ICoreWebView2Cookie): HResult; stdcall;
    function CopyCookie(const cookieParam: ICoreWebView2Cookie; out cookie: ICoreWebView2Cookie): HResult; stdcall;
    function GetCookies(uri: PWideChar; const handler: ICoreWebView2GetCookiesCompletedHandler): HResult; stdcall;
    function AddOrUpdateCookie(const cookie: ICoreWebView2Cookie): HResult; stdcall;
    function DeleteCookie(const cookie: ICoreWebView2Cookie): HResult; stdcall;
    function DeleteCookies(name: PWideChar; uri: PWideChar): HResult; stdcall;
    function DeleteCookiesWithDomainAndPath(name: PWideChar; Domain: PWideChar; Path: PWideChar): HResult; stdcall;
    function DeleteAllCookies: HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties that are used to manage an
  /// ICoreWebView2Cookie.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookie">See the ICoreWebView2Cookie article.</see></para>
  /// </remarks>
  ICoreWebView2Cookie = interface(IUnknown)
    ['{AD26D6BE-1486-43E6-BF87-A2034006CA21}']
    function Get_name(out name: PWideChar): HResult; stdcall;
    function Get_value(out value: PWideChar): HResult; stdcall;
    function Set_value(value: PWideChar): HResult; stdcall;
    function Get_Domain(out Domain: PWideChar): HResult; stdcall;
    function Get_Path(out Path: PWideChar): HResult; stdcall;
    function Get_Expires(out Expires: Double): HResult; stdcall;
    function Set_Expires(Expires: Double): HResult; stdcall;
    function Get_IsHttpOnly(out IsHttpOnly: Integer): HResult; stdcall;
    function Set_IsHttpOnly(IsHttpOnly: Integer): HResult; stdcall;
    function Get_SameSite(out SameSite: COREWEBVIEW2_COOKIE_SAME_SITE_KIND): HResult; stdcall;
    function Set_SameSite(SameSite: COREWEBVIEW2_COOKIE_SAME_SITE_KIND): HResult; stdcall;
    function Get_IsSecure(out IsSecure: Integer): HResult; stdcall;
    function Set_IsSecure(IsSecure: Integer): HResult; stdcall;
    function Get_IsSession(out IsSession: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the GetCookies method.  The result is written to
  /// the cookie list provided in the GetCookies method call.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getcookiescompletedhandler">See the ICoreWebView2GetCookiesCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2GetCookiesCompletedHandler = interface(IUnknown)
    ['{5A4F5069-5C15-47C3-8646-F4DE1C116670}']
    function Invoke(result: HResult; const cookieList: ICoreWebView2CookieList): HResult; stdcall;
  end;

  /// <summary>
  /// A list of cookie objects. See ICoreWebView2Cookie.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookielist">See the ICoreWebView2CookieList article.</see></para>
  /// </remarks>
  ICoreWebView2CookieList = interface(IUnknown)
    ['{F7F6F714-5D2A-43C6-9503-346ECE02D186}']
    function Get_Count(out Count: SYSUINT): HResult; stdcall;
    function GetValueAtIndex(index: SYSUINT; out cookie: ICoreWebView2Cookie): HResult; stdcall;
  end;

  /// <summary>
  /// Represents the WebView2 Environment.  WebViews created from an environment
  /// run on the browser process specified with environment parameters and
  /// objects created from an environment should be used in the same
  /// environment.  Using it in different environments are not guaranteed to be
  ///  compatible and may fail.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment">See the ICoreWebView2Environment article.</see></para>
  /// </remarks>
  ICoreWebView2Environment = interface(IUnknown)
    ['{B96D755E-0319-4E92-A296-23436F46A1FC}']
    // var ParentWindow: _RemotableHandle --> ParentWindow: HWND    ************** WEBVIEW4DELPHI **************
    function CreateCoreWebView2Controller(ParentWindow: HWND;
                                          const handler: ICoreWebView2CreateCoreWebView2ControllerCompletedHandler): HResult; stdcall;
    function CreateWebResourceResponse(const Content: IStream; StatusCode: SYSINT; 
                                       ReasonPhrase: PWideChar; Headers: PWideChar; 
                                       out Response: ICoreWebView2WebResourceResponse): HResult; stdcall;
    function Get_BrowserVersionString(out versionInfo: PWideChar): HResult; stdcall;
    function add_NewBrowserVersionAvailable(const eventHandler: ICoreWebView2NewBrowserVersionAvailableEventHandler; 
                                            out token: EventRegistrationToken): HResult; stdcall;
    function remove_NewBrowserVersionAvailable(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the CoreWebView2Controller created using CreateCoreWebView2Controller.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2controllercompletedhandler">See the ICoreWebView2CreateCoreWebView2ControllerCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CreateCoreWebView2ControllerCompletedHandler = interface(IUnknown)
    ['{6C4819F3-C9B7-4260-8127-C9F5BDE7F68C}']
    function Invoke(errorCode: HResult; const createdController: ICoreWebView2Controller): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NewBrowserVersionAvailable events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newbrowserversionavailableeventhandler">See the ICoreWebView2NewBrowserVersionAvailableEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NewBrowserVersionAvailableEventHandler = interface(IUnknown)
    ['{F9A2976E-D34E-44FC-ADEE-81B6B57CA914}']
    function Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2_2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3">See the ICoreWebView2_3 article.</see></para>
  /// </remarks>
  ICoreWebView2_3 = interface(ICoreWebView2_2)
    ['{A0D6DF20-3B92-416D-AA0C-437A9C727857}']
    function TrySuspend(const handler: ICoreWebView2TrySuspendCompletedHandler): HResult; stdcall;
    function Resume: HResult; stdcall;
    function Get_IsSuspended(out IsSuspended: Integer): HResult; stdcall;
    function SetVirtualHostNameToFolderMapping(hostName: PWideChar; folderPath: PWideChar; 
                                               accessKind: COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND): HResult; stdcall;
    function ClearVirtualHostNameToFolderMapping(hostName: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// The caller implements this interface to receive the TrySuspend result.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2trysuspendcompletedhandler">See the ICoreWebView2TrySuspendCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2TrySuspendCompletedHandler = interface(IUnknown)
    ['{00F206A7-9D17-4605-91F6-4E8E4DE192E3}']
    function Invoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2_3 interface to support FrameCreated and
  /// DownloadStarting events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_4">See the ICoreWebView2_4 article.</see></para>
  /// </remarks>
  ICoreWebView2_4 = interface(ICoreWebView2_3)
    ['{20D02D59-6DF2-42DC-BD06-F98A694B1302}']
    function add_FrameCreated(const eventHandler: ICoreWebView2FrameCreatedEventHandler; 
                              out token: EventRegistrationToken): HResult; stdcall;
    function remove_FrameCreated(token: EventRegistrationToken): HResult; stdcall;
    function add_DownloadStarting(const eventHandler: ICoreWebView2DownloadStartingEventHandler; 
                                  out token: EventRegistrationToken): HResult; stdcall;
    function remove_DownloadStarting(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives FrameCreated event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecreatedeventhandler">See the ICoreWebView2FrameCreatedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameCreatedEventHandler = interface(IUnknown)
    ['{38059770-9BAA-11EB-A8B3-0242AC130003}']
    function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2FrameCreatedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the FrameCreated events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecreatedeventargs">See the ICoreWebView2FrameCreatedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2FrameCreatedEventArgs = interface(IUnknown)
    ['{4D6E7B5E-9BAA-11EB-A8B3-0242AC130003}']
    function Get_Frame(out Frame: ICoreWebView2Frame): HResult; stdcall;
  end;

  /// <summary>
  /// ICoreWebView2Frame provides direct access to the iframes information.
  /// You can get an ICoreWebView2Frame by handling the ICoreWebView2_4.add_FrameCreated event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame">See the ICoreWebView2Frame article.</see></para>
  /// </remarks>
  ICoreWebView2Frame = interface(IUnknown)
    ['{F1131A5E-9BA9-11EB-A8B3-0242AC130003}']
    function Get_name(out name: PWideChar): HResult; stdcall;
    function add_NameChanged(const eventHandler: ICoreWebView2FrameNameChangedEventHandler; 
                             out token: EventRegistrationToken): HResult; stdcall;
    function remove_NameChanged(token: EventRegistrationToken): HResult; stdcall;
    function AddHostObjectToScriptWithOrigins(name: PWideChar; const object_: OleVariant; 
                                              originsCount: SYSUINT; var origins: PWideChar): HResult; stdcall;
    function RemoveHostObjectFromScript(name: PWideChar): HResult; stdcall;
    function add_Destroyed(const eventHandler: ICoreWebView2FrameDestroyedEventHandler; 
                           out token: EventRegistrationToken): HResult; stdcall;
    function remove_Destroyed(token: EventRegistrationToken): HResult; stdcall;
    function IsDestroyed(out destroyed: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives FrameNameChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenamechangedeventhandler">See the ICoreWebView2FrameNameChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameNameChangedEventHandler = interface(IUnknown)
    ['{435C7DC8-9BAA-11EB-A8B3-0242AC130003}']
    function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives FrameDestroyed event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framedestroyedeventhandler">See the ICoreWebView2FrameDestroyedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameDestroyedEventHandler = interface(IUnknown)
    ['{59DD7B4C-9BAA-11EB-A8B3-0242AC130003}']
    function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Add an event handler for the DownloadStarting event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventhandler">See the ICoreWebView2DownloadStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2DownloadStartingEventHandler = interface(IUnknown)
    ['{EFEDC989-C396-41CA-83F7-07F845A55724}']
    function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2DownloadStartingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the DownloadStarting event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventargs">See the ICoreWebView2DownloadStartingEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2DownloadStartingEventArgs = interface(IUnknown)
    ['{E99BBE21-43E9-4544-A732-282764EAFA60}']
    function Get_DownloadOperation(out DownloadOperation: ICoreWebView2DownloadOperation): HResult; stdcall;
    function Get_Cancel(out Cancel: Integer): HResult; stdcall;
    function Set_Cancel(Cancel: Integer): HResult; stdcall;
    function Get_ResultFilePath(out ResultFilePath: PWideChar): HResult; stdcall;
    function Set_ResultFilePath(ResultFilePath: PWideChar): HResult; stdcall;
    function Get_Handled(out Handled: Integer): HResult; stdcall;
    function Set_Handled(Handled: Integer): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// Represents a download operation. Gives access to the download's metadata
  /// and supports a user canceling, pausing, or resuming the download.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadoperation">See the ICoreWebView2DownloadOperation article.</see></para>
  /// </remarks>
  ICoreWebView2DownloadOperation = interface(IUnknown)
    ['{3D6B6CF2-AFE1-44C7-A995-C65117714336}']
    function add_BytesReceivedChanged(const eventHandler: ICoreWebView2BytesReceivedChangedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    function remove_BytesReceivedChanged(token: EventRegistrationToken): HResult; stdcall;
    function add_EstimatedEndTimeChanged(const eventHandler: ICoreWebView2EstimatedEndTimeChangedEventHandler; 
                                         out token: EventRegistrationToken): HResult; stdcall;
    function remove_EstimatedEndTimeChanged(token: EventRegistrationToken): HResult; stdcall;
    function add_StateChanged(const eventHandler: ICoreWebView2StateChangedEventHandler; 
                              out token: EventRegistrationToken): HResult; stdcall;
    function remove_StateChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    function Get_ContentDisposition(out ContentDisposition: PWideChar): HResult; stdcall;
    function Get_MimeType(out MimeType: PWideChar): HResult; stdcall;
    function Get_TotalBytesToReceive(out TotalBytesToReceive: Int64): HResult; stdcall;
    function Get_BytesReceived(out BytesReceived: Int64): HResult; stdcall;
    function Get_EstimatedEndTime(out EstimatedEndTime: PWideChar): HResult; stdcall;
    function Get_ResultFilePath(out ResultFilePath: PWideChar): HResult; stdcall;
    function Get_State(out downloadState: COREWEBVIEW2_DOWNLOAD_STATE): HResult; stdcall;
    function Get_InterruptReason(out InterruptReason: COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON): HResult; stdcall;
    function Cancel: HResult; stdcall;
    function Pause: HResult; stdcall;
    function Resume: HResult; stdcall;
    function Get_CanResume(out CanResume: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Implements the interface to receive BytesReceivedChanged event.  Use the
  /// ICoreWebView2DownloadOperation.BytesReceived property to get the received
  /// bytes count.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2bytesreceivedchangedeventhandler">See the ICoreWebView2BytesReceivedChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2BytesReceivedChangedEventHandler = interface(IUnknown)
    ['{828E8AB6-D94C-4264-9CEF-5217170D6251}']
    function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Implements the interface to receive EstimatedEndTimeChanged event. Use the
  /// ICoreWebView2DownloadOperation.EstimatedEndTime property to get the new
  /// estimated end time.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2estimatedendtimechangedeventhandler">See the ICoreWebView2EstimatedEndTimeChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2EstimatedEndTimeChangedEventHandler = interface(IUnknown)
    ['{28F0D425-93FE-4E63-9F8D-2AEEC6D3BA1E}']
    function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Implements the interface to receive StateChanged event. Use the
  /// ICoreWebView2DownloadOperation.State property to get the current state,
  /// which can be in progress, interrupted, or completed. Use the
  /// ICoreWebView2DownloadOperation.InterruptReason property to get the
  /// interrupt reason if the download is interrupted.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2statechangedeventhandler">See the ICoreWebView2StateChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2StateChangedEventHandler = interface(IUnknown)
    ['{81336594-7EDE-4BA9-BF71-ACF0A95B58DD}']
    function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2_4 interface to support ClientCertificateRequested
  /// event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_5">See the ICoreWebView2_5 article.</see></para>
  /// </remarks>
  ICoreWebView2_5 = interface(ICoreWebView2_4)
    ['{BEDB11B8-D63C-11EB-B8BC-0242AC130003}']
    function add_ClientCertificateRequested(const eventHandler: ICoreWebView2ClientCertificateRequestedEventHandler; 
                                            out token: EventRegistrationToken): HResult; stdcall;
    function remove_ClientCertificateRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// An event handler for the ClientCertificateRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventhandler">See the ICoreWebView2ClientCertificateRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ClientCertificateRequestedEventHandler = interface(IUnknown)
    ['{D7175BA2-BCC3-11EB-8529-0242AC130003}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2ClientCertificateRequestedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the ClientCertificateRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventargs">See the ICoreWebView2ClientCertificateRequestedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2ClientCertificateRequestedEventArgs = interface(IUnknown)
    ['{BC59DB28-BCC3-11EB-8529-0242AC130003}']
    function Get_Host(out value: PWideChar): HResult; stdcall;
    function Get_Port(out value: SYSINT): HResult; stdcall;
    function Get_IsProxy(out value: Integer): HResult; stdcall;
    function Get_AllowedCertificateAuthorities(out value: ICoreWebView2StringCollection): HResult; stdcall;
    function Get_MutuallyTrustedCertificates(out value: ICoreWebView2ClientCertificateCollection): HResult; stdcall;
    function Get_SelectedCertificate(out value: ICoreWebView2ClientCertificate): HResult; stdcall;
    function Set_SelectedCertificate(const value: ICoreWebView2ClientCertificate): HResult; stdcall;
    function Get_Cancel(out value: Integer): HResult; stdcall;
    function Set_Cancel(value: Integer): HResult; stdcall;
    function Get_Handled(out value: Integer): HResult; stdcall;
    function Set_Handled(value: Integer): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of strings.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2stringcollection">See the ICoreWebView2StringCollection article.</see></para>
  /// </remarks>
  ICoreWebView2StringCollection = interface(IUnknown)
    ['{F41F3F8A-BCC3-11EB-8529-0242AC130003}']
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    function GetValueAtIndex(index: SYSUINT; out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of client certificate object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificatecollection">See the ICoreWebView2ClientCertificateCollection article.</see></para>
  /// </remarks>
  ICoreWebView2ClientCertificateCollection = interface(IUnknown)
    ['{EF5674D2-BCC3-11EB-8529-0242AC130003}']
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    function GetValueAtIndex(index: SYSUINT; out certificate: ICoreWebView2ClientCertificate): HResult; stdcall;
  end;

  /// <summary>
  /// Provides access to the client certificate metadata.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate">See the ICoreWebView2ClientCertificate article.</see></para>
  /// </remarks>
  ICoreWebView2ClientCertificate = interface(IUnknown)
    ['{E7188076-BCC3-11EB-8529-0242AC130003}']
    function Get_Subject(out value: PWideChar): HResult; stdcall;
    function Get_Issuer(out value: PWideChar): HResult; stdcall;
    function Get_ValidFrom(out value: Double): HResult; stdcall;
    function Get_ValidTo(out value: Double): HResult; stdcall;
    function Get_DerEncodedSerialNumber(out value: PWideChar): HResult; stdcall;
    function Get_DisplayName(out value: PWideChar): HResult; stdcall;
    function ToPemEncoding(out pemEncodedData: PWideChar): HResult; stdcall;
    function Get_PemEncodedIssuerCertificateChain(out value: ICoreWebView2StringCollection): HResult; stdcall;
    function Get_Kind(out value: COREWEBVIEW2_CLIENT_CERTIFICATE_KIND): HResult; stdcall;
  end;

  /// <summary>
  ///
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_6">See the ICoreWebView2_6 article.</see></para>
  /// </remarks>
  ICoreWebView2_6 = interface(ICoreWebView2_5)
    ['{499AADAC-D92C-4589-8A75-111BFC167795}']
    function OpenTaskManagerWindow: HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_5 that manages opening
  /// the browser task manager window.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_7">See the ICoreWebView2_7 article.</see></para>
  /// </remarks>
  ICoreWebView2_7 = interface(ICoreWebView2_6)
    ['{79C24D83-09A3-45AE-9418-487F32A58740}']
    function PrintToPdf(ResultFilePath: PWideChar; const printSettings: ICoreWebView2PrintSettings; 
                        const handler: ICoreWebView2PrintToPdfCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Settings used by the PrintToPdf method. Other programmatic printing is not
  /// currently supported.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printsettings">See the ICoreWebView2PrintSettings article.</see></para>
  /// </remarks>
  ICoreWebView2PrintSettings = interface(IUnknown)
    ['{377F3721-C74E-48CA-8DB1-DF68E51D60E2}']
    function Get_Orientation(out Orientation: COREWEBVIEW2_PRINT_ORIENTATION): HResult; stdcall;
    function Set_Orientation(Orientation: COREWEBVIEW2_PRINT_ORIENTATION): HResult; stdcall;
    function Get_ScaleFactor(out ScaleFactor: Double): HResult; stdcall;
    function Set_ScaleFactor(ScaleFactor: Double): HResult; stdcall;
    function Get_PageWidth(out PageWidth: Double): HResult; stdcall;
    function Set_PageWidth(PageWidth: Double): HResult; stdcall;
    function Get_PageHeight(out PageHeight: Double): HResult; stdcall;
    function Set_PageHeight(PageHeight: Double): HResult; stdcall;
    function Get_MarginTop(out MarginTop: Double): HResult; stdcall;
    function Set_MarginTop(MarginTop: Double): HResult; stdcall;
    function Get_MarginBottom(out MarginBottom: Double): HResult; stdcall;
    function Set_MarginBottom(MarginBottom: Double): HResult; stdcall;
    function Get_MarginLeft(out MarginLeft: Double): HResult; stdcall;
    function Set_MarginLeft(MarginLeft: Double): HResult; stdcall;
    function Get_MarginRight(out MarginRight: Double): HResult; stdcall;
    function Set_MarginRight(MarginRight: Double): HResult; stdcall;
    function Get_ShouldPrintBackgrounds(out ShouldPrintBackgrounds: Integer): HResult; stdcall;
    function Set_ShouldPrintBackgrounds(ShouldPrintBackgrounds: Integer): HResult; stdcall;
    function Get_ShouldPrintSelectionOnly(out ShouldPrintSelectionOnly: Integer): HResult; stdcall;
    function Set_ShouldPrintSelectionOnly(ShouldPrintSelectionOnly: Integer): HResult; stdcall;
    function Get_ShouldPrintHeaderAndFooter(out ShouldPrintHeaderAndFooter: Integer): HResult; stdcall;
    function Set_ShouldPrintHeaderAndFooter(ShouldPrintHeaderAndFooter: Integer): HResult; stdcall;
    function Get_HeaderTitle(out HeaderTitle: PWideChar): HResult; stdcall;
    function Set_HeaderTitle(HeaderTitle: PWideChar): HResult; stdcall;
    function Get_FooterUri(out FooterUri: PWideChar): HResult; stdcall;
    function Set_FooterUri(FooterUri: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the PrintToPdf method. If the print to PDF
  /// operation succeeds, isSuccessful is true. Otherwise, if the operation
  /// failed, isSuccessful is set to false. An invalid path returns
  /// E_INVALIDARG.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printtopdfcompletedhandler">See the ICoreWebView2PrintToPdfCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2PrintToPdfCompletedHandler = interface(IUnknown)
    ['{CCF1EF04-FD8E-4D5F-B2DE-0983E41B8C36}']
    function Invoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_7 that supports media features.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8">See the ICoreWebView2_8 article.</see></para>
  /// </remarks>
  ICoreWebView2_8 = interface(ICoreWebView2_7)
    ['{E9632730-6E1E-43AB-B7B8-7B2C9E62E094}']
    function add_IsMutedChanged(const eventHandler: ICoreWebView2IsMutedChangedEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    function remove_IsMutedChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_IsMuted(out value: Integer): HResult; stdcall;
    function Set_IsMuted(value: Integer): HResult; stdcall;
    function add_IsDocumentPlayingAudioChanged(const eventHandler: ICoreWebView2IsDocumentPlayingAudioChangedEventHandler; 
                                               out token: EventRegistrationToken): HResult; stdcall;
    function remove_IsDocumentPlayingAudioChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_IsDocumentPlayingAudio(out value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Implements the interface to receive IsMutedChanged events.  Use the
  /// IsMuted property to get the mute state.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2ismutedchangedeventhandler">See the ICoreWebView2IsMutedChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2IsMutedChangedEventHandler = interface(IUnknown)
    ['{57D90347-CD0E-4952-A4A2-7483A2756F08}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Implements the interface to receive IsDocumentPlayingAudioChanged events.  Use the
  /// IsDocumentPlayingAudio property to get the audio playing state.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2isdocumentplayingaudiochangedeventhandler">See the ICoreWebView2IsDocumentPlayingAudioChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2IsDocumentPlayingAudioChangedEventHandler = interface(IUnknown)
    ['{5DEF109A-2F4B-49FA-B7F6-11C39E513328}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_8 that default download
  /// dialog positioning and anchoring.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_9">See the ICoreWebView2_9 article.</see></para>
  /// </remarks>
  ICoreWebView2_9 = interface(ICoreWebView2_8)
    ['{4D7B2EAB-9FDC-468D-B998-A9260B5ED651}']
    function add_IsDefaultDownloadDialogOpenChanged(const handler: ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler; 
                                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_IsDefaultDownloadDialogOpenChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_IsDefaultDownloadDialogOpen(out value: Integer): HResult; stdcall;
    function OpenDefaultDownloadDialog: HResult; stdcall;
    function CloseDefaultDownloadDialog: HResult; stdcall;
    function Get_DefaultDownloadDialogCornerAlignment(out value: COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT): HResult; stdcall;
    function Set_DefaultDownloadDialogCornerAlignment(value: COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT): HResult; stdcall;
    function Get_DefaultDownloadDialogMargin(out value: tagPOINT): HResult; stdcall;
    function Set_DefaultDownloadDialogMargin(value: tagPOINT): HResult; stdcall;
  end;

  /// <summary>
  /// Implements the interface to receive IsDefaultDownloadDialogOpenChanged
  /// events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2isdefaultdownloaddialogopenchangedeventhandler">See the ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler = interface(IUnknown)
    ['{3117DA26-AE13-438D-BD46-EDBEB2C4CE81}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_9 that supports
  /// BasicAuthenticationRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_10">See the ICoreWebView2_10 article.</see></para>
  /// </remarks>
  ICoreWebView2_10 = interface(ICoreWebView2_9)
    ['{B1690564-6F5A-4983-8E48-31D1143FECDB}']
    function add_BasicAuthenticationRequested(const eventHandler: ICoreWebView2BasicAuthenticationRequestedEventHandler; 
                                              out token: EventRegistrationToken): HResult; stdcall;
    function remove_BasicAuthenticationRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// The caller implements this interface to handle the BasicAuthenticationRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventhandler">See the ICoreWebView2BasicAuthenticationRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2BasicAuthenticationRequestedEventHandler = interface(IUnknown)
    ['{58B4D6C2-18D4-497E-B39B-9A96533FA278}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2BasicAuthenticationRequestedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the BasicAuthenticationRequested event. Will contain the
  /// request that led to the HTTP authorization challenge, the challenge
  /// and allows the host to provide authentication response or cancel the request.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventargs">See the ICoreWebView2BasicAuthenticationRequestedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2BasicAuthenticationRequestedEventArgs = interface(IUnknown)
    ['{EF05516F-D897-4F9E-B672-D8E2307A3FB0}']
    function Get_uri(out value: PWideChar): HResult; stdcall;
    function Get_Challenge(out Challenge: PWideChar): HResult; stdcall;
    function Get_Response(out Response: ICoreWebView2BasicAuthenticationResponse): HResult; stdcall;
    function Get_Cancel(out Cancel: Integer): HResult; stdcall;
    function Set_Cancel(Cancel: Integer): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// Represents a Basic HTTP authentication response that contains a user name
  /// and a password as according to RFC7617 (https://tools.ietf.org/html/rfc7617)
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationresponse">See the ICoreWebView2BasicAuthenticationResponse article.</see></para>
  /// </remarks>
  ICoreWebView2BasicAuthenticationResponse = interface(IUnknown)
    ['{07023F7D-2D77-4D67-9040-6E7D428C6A40}']
    function Get_UserName(out UserName: PWideChar): HResult; stdcall;
    function Set_UserName(UserName: PWideChar): HResult; stdcall;
    function Get_Password(out Password: PWideChar): HResult; stdcall;
    function Set_Password(Password: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_10 that supports sessionId
  /// for CDP method calls and ContextMenuRequested event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_11">See the ICoreWebView2_11 article.</see></para>
  /// </remarks>
  ICoreWebView2_11 = interface(ICoreWebView2_10)
    ['{0BE78E56-C193-4051-B943-23B460C08BDB}']
    function CallDevToolsProtocolMethodForSession(sessionId: PWideChar; methodName: PWideChar; 
                                                  parametersAsJson: PWideChar; 
                                                  const handler: ICoreWebView2CallDevToolsProtocolMethodCompletedHandler): HResult; stdcall;
    function add_ContextMenuRequested(const eventHandler: ICoreWebView2ContextMenuRequestedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    function remove_ContextMenuRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives ContextMenuRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventhandler">See the ICoreWebView2ContextMenuRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ContextMenuRequestedEventHandler = interface(IUnknown)
    ['{04D3FE1D-AB87-42FB-A898-DA241D35B63C}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2ContextMenuRequestedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the ContextMenuRequested event. Will contain the selection information
  /// and a collection of all of the default context menu items that the WebView
  /// would show. Allows the app to draw its own context menu or add/remove
  /// from the default context menu.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenurequestedeventargs">See the ICoreWebView2ContextMenuRequestedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2ContextMenuRequestedEventArgs = interface(IUnknown)
    ['{A1D309EE-C03F-11EB-8529-0242AC130003}']
    function Get_MenuItems(out value: ICoreWebView2ContextMenuItemCollection): HResult; stdcall;
    function Get_ContextMenuTarget(out value: ICoreWebView2ContextMenuTarget): HResult; stdcall;
    function Get_Location(out value: tagPOINT): HResult; stdcall;
    function Set_SelectedCommandId(value: SYSINT): HResult; stdcall;
    function Get_SelectedCommandId(out value: SYSINT): HResult; stdcall;
    function Set_Handled(value: Integer): HResult; stdcall;
    function Get_Handled(out value: Integer): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// Represents a collection of ContextMenuItem objects. Used to get, remove and add
  /// ContextMenuItem objects at the specified index.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitemcollection">See the ICoreWebView2ContextMenuItemCollection article.</see></para>
  /// </remarks>
  ICoreWebView2ContextMenuItemCollection = interface(IUnknown)
    ['{F562A2F5-C415-45CF-B909-D4B7C1E276D3}']
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2ContextMenuItem): HResult; stdcall;
    function RemoveValueAtIndex(index: SYSUINT): HResult; stdcall;
    function InsertValueAtIndex(index: SYSUINT; const value: ICoreWebView2ContextMenuItem): HResult; stdcall;
  end;

  /// <summary>
  /// Represents a context menu item of a context menu displayed by WebView.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenuitem">See the ICoreWebView2ContextMenuItem article.</see></para>
  /// </remarks>
  ICoreWebView2ContextMenuItem = interface(IUnknown)
    ['{7AED49E3-A93F-497A-811C-749C6B6B6C65}']
    function Get_name(out value: PWideChar): HResult; stdcall;
    function Get_Label_(out value: PWideChar): HResult; stdcall;
    function Get_CommandId(out value: SYSINT): HResult; stdcall;
    function Get_ShortcutKeyDescription(out value: PWideChar): HResult; stdcall;
    function Get_Icon(out value: IStream): HResult; stdcall;
    function Get_Kind(out value: COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND): HResult; stdcall;
    function Set_IsEnabled(value: Integer): HResult; stdcall;
    function Get_IsEnabled(out value: Integer): HResult; stdcall;
    function Set_IsChecked(value: Integer): HResult; stdcall;
    function Get_IsChecked(out value: Integer): HResult; stdcall;
    function Get_Children(out value: ICoreWebView2ContextMenuItemCollection): HResult; stdcall;
    function add_CustomItemSelected(const eventHandler: ICoreWebView2CustomItemSelectedEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_CustomItemSelected(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Raised to notify the host that the end user selected a custom
  /// ContextMenuItem. CustomItemSelected event is raised on the specific
  /// ContextMenuItem that the end user selected.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customitemselectedeventhandler">See the ICoreWebView2CustomItemSelectedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CustomItemSelectedEventHandler = interface(IUnknown)
    ['{49E1D0BC-FE9E-4481-B7C2-32324AA21998}']
    function Invoke(const sender: ICoreWebView2ContextMenuItem; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Represents the information regarding the context menu target.
  /// Includes the context selected and the appropriate data used for the actions of a context menu.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contextmenutarget">See the ICoreWebView2ContextMenuTarget article.</see></para>
  /// </remarks>
  ICoreWebView2ContextMenuTarget = interface(IUnknown)
    ['{B8611D99-EED6-4F3F-902C-A198502AD472}']
    function Get_Kind(out value: COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND): HResult; stdcall;
    function Get_IsEditable(out value: Integer): HResult; stdcall;
    function Get_IsRequestedForMainFrame(out value: Integer): HResult; stdcall;
    function Get_PageUri(out value: PWideChar): HResult; stdcall;
    function Get_FrameUri(out value: PWideChar): HResult; stdcall;
    function Get_HasLinkUri(out value: Integer): HResult; stdcall;
    function Get_LinkUri(out value: PWideChar): HResult; stdcall;
    function Get_HasLinkText(out value: Integer): HResult; stdcall;
    function Get_LinkText(out value: PWideChar): HResult; stdcall;
    function Get_HasSourceUri(out value: Integer): HResult; stdcall;
    function Get_SourceUri(out value: PWideChar): HResult; stdcall;
    function Get_HasSelection(out value: Integer): HResult; stdcall;
    function Get_SelectionText(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_11 that supports
  /// StatusBarTextChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_12">See the ICoreWebView2_12 article.</see></para>
  /// </remarks>
  ICoreWebView2_12 = interface(ICoreWebView2_11)
    ['{35D69927-BCFA-4566-9349-6B3E0D154CAC}']
    function add_StatusBarTextChanged(const eventHandler: ICoreWebView2StatusBarTextChangedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    function remove_StatusBarTextChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_StatusBarText(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives StatusBarTextChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2statusbartextchangedeventhandler">See the ICoreWebView2StatusBarTextChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2StatusBarTextChangedEventHandler = interface(IUnknown)
    ['{A5E3B0D0-10DF-4156-BFAD-3B43867ACAC6}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_12 that supports Profile
  /// API.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_13">See the ICoreWebView2_13 article.</see></para>
  /// </remarks>
  ICoreWebView2_13 = interface(ICoreWebView2_12)
    ['{F75F09A8-667E-4983-88D6-C8773F315E84}']
    function Get_Profile(out value: ICoreWebView2Profile): HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties to configure a Profile object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile">See the ICoreWebView2Profile article.</see></para>
  /// </remarks>
  ICoreWebView2Profile = interface(IUnknown)
    ['{79110AD3-CD5D-4373-8BC3-C60658F17A5F}']
    function Get_ProfileName(out value: PWideChar): HResult; stdcall;
    function Get_IsInPrivateModeEnabled(out value: Integer): HResult; stdcall;
    function Get_ProfilePath(out value: PWideChar): HResult; stdcall;
    function Get_DefaultDownloadFolderPath(out value: PWideChar): HResult; stdcall;
    function Set_DefaultDownloadFolderPath(value: PWideChar): HResult; stdcall;
    function Get_PreferredColorScheme(out value: COREWEBVIEW2_PREFERRED_COLOR_SCHEME): HResult; stdcall;
    function Set_PreferredColorScheme(value: COREWEBVIEW2_PREFERRED_COLOR_SCHEME): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_13 that adds
  /// ServerCertificate support.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14">See the ICoreWebView2_14 article.</see></para>
  /// </remarks>
  ICoreWebView2_14 = interface(ICoreWebView2_13)
    ['{6DAA4F10-4A90-4753-8898-77C5DF534165}']
    function add_ServerCertificateErrorDetected(const eventHandler: ICoreWebView2ServerCertificateErrorDetectedEventHandler; 
                                                out token: EventRegistrationToken): HResult; stdcall;
    function remove_ServerCertificateErrorDetected(token: EventRegistrationToken): HResult; stdcall;
    function ClearServerCertificateErrorActions(const handler: ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// An event handler for the ServerCertificateErrorDetected event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventhandler">See the ICoreWebView2ServerCertificateErrorDetectedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ServerCertificateErrorDetectedEventHandler = interface(IUnknown)
    ['{969B3A26-D85E-4795-8199-FEF57344DA22}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2ServerCertificateErrorDetectedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the ServerCertificateErrorDetected event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventargs">See the ICoreWebView2ServerCertificateErrorDetectedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2ServerCertificateErrorDetectedEventArgs = interface(IUnknown)
    ['{012193ED-7C13-48FF-969D-A84C1F432A14}']
    function Get_ErrorStatus(out value: COREWEBVIEW2_WEB_ERROR_STATUS): HResult; stdcall;
    function Get_RequestUri(out value: PWideChar): HResult; stdcall;
    function Get_ServerCertificate(out value: ICoreWebView2Certificate): HResult; stdcall;
    function Get_Action(out value: COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION): HResult; stdcall;
    function Set_Action(value: COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION): HResult; stdcall;
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// Provides access to the certificate metadata.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2certificate">See the ICoreWebView2Certificate article.</see></para>
  /// </remarks>
  ICoreWebView2Certificate = interface(IUnknown)
    ['{C5FB2FCE-1CAC-4AEE-9C79-5ED0362EAAE0}']
    function Get_Subject(out value: PWideChar): HResult; stdcall;
    function Get_Issuer(out value: PWideChar): HResult; stdcall;
    function Get_ValidFrom(out value: Double): HResult; stdcall;
    function Get_ValidTo(out value: Double): HResult; stdcall;
    function Get_DerEncodedSerialNumber(out value: PWideChar): HResult; stdcall;
    function Get_DisplayName(out value: PWideChar): HResult; stdcall;
    function ToPemEncoding(out pemEncodedData: PWideChar): HResult; stdcall;
    function Get_PemEncodedIssuerCertificateChain(out value: ICoreWebView2StringCollection): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the ClearServerCertificateErrorActions method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clearservercertificateerroractionscompletedhandler">See the ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler = interface(IUnknown)
    ['{3B40AAC6-ACFE-4FFD-8211-F607B96E2D5B}']
    function Invoke(errorCode: HResult): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_14 that supports status Favicons.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15">See the ICoreWebView2_15 article.</see></para>
  /// </remarks>
  ICoreWebView2_15 = interface(ICoreWebView2_14)
    ['{517B2D1D-7DAE-4A66-A4F4-10352FFB9518}']
    function add_FaviconChanged(const eventHandler: ICoreWebView2FaviconChangedEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    function remove_FaviconChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_FaviconUri(out value: PWideChar): HResult; stdcall;
    function GetFavicon(format: COREWEBVIEW2_FAVICON_IMAGE_FORMAT; 
                        const completedHandler: ICoreWebView2GetFaviconCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is a handler for when the Favicon is changed.
  /// The sender is the ICoreWebView2 object the top-level document of
  /// which has changed favicon and the eventArgs is nullptr. Use the
  /// FaviconUri property and GetFavicon method to obtain the favicon
  /// data. The second argument is always null.
  /// For more information see add_FaviconChanged.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2faviconchangedeventhandler">See the ICoreWebView2FaviconChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FaviconChangedEventHandler = interface(IUnknown)
    ['{2913DA94-833D-4DE0-8DCA-900FC524A1A4}']
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is a handler for the completion of the population of
  /// imageStream.
  /// errorCode returns S_OK if the API succeeded.
  /// The image is returned in the faviconStream object. If there is no image
  /// then no data would be copied into the imageStream.
  /// For more details, see the GetFavicon API.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getfaviconcompletedhandler">See the ICoreWebView2GetFaviconCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2GetFaviconCompletedHandler = interface(IUnknown)
    ['{A2508329-7DA8-49D7-8C05-FA125E4AEE8D}']
    function Invoke(errorCode: HResult; const faviconStream: IStream): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2 interface to support printing.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16">See the ICoreWebView2_16 article.</see></para>
  /// </remarks>
  ICoreWebView2_16 = interface(ICoreWebView2_15)
    ['{0EB34DC9-9F91-41E1-8639-95CD5943906B}']
    function Print(const printSettings: ICoreWebView2PrintSettings; 
                   const handler: ICoreWebView2PrintCompletedHandler): HResult; stdcall;
    function ShowPrintUI(printDialogKind: COREWEBVIEW2_PRINT_DIALOG_KIND): HResult; stdcall;
    function PrintToPdfStream(const printSettings: ICoreWebView2PrintSettings; 
                              const handler: ICoreWebView2PrintToPdfStreamCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the Print method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printcompletedhandler">See the ICoreWebView2PrintCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2PrintCompletedHandler = interface(IUnknown)
    ['{8FD80075-ED08-42DB-8570-F5D14977461E}']
    function Invoke(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the PrintToPdfStream method.
  /// errorCode returns S_OK if the PrintToPdfStream operation succeeded.
  /// The printable pdf data is returned in the pdfStream object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printtopdfstreamcompletedhandler">See the ICoreWebView2PrintToPdfStreamCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2PrintToPdfStreamCompletedHandler = interface(IUnknown)
    ['{4C9F8229-8F93-444F-A711-2C0DFD6359D5}']
    function Invoke(errorCode: HResult; const pdfStream: IStream): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_16 that supports shared buffer based on file mapping.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_17">See the ICoreWebView2_17 article.</see></para>
  /// </remarks>
  ICoreWebView2_17 = interface(ICoreWebView2_16)
    ['{702E75D4-FD44-434D-9D70-1A68A6B1192A}']
    function PostSharedBufferToScript(const sharedBuffer: ICoreWebView2SharedBuffer;
                                      access: COREWEBVIEW2_SHARED_BUFFER_ACCESS; 
                                      additionalDataAsJson: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// The shared buffer object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer">See the ICoreWebView2SharedBuffer article.</see></para>
  /// </remarks>
  ICoreWebView2SharedBuffer = interface(IUnknown)
    ['{B747A495-0C6F-449E-97B8-2F81E9D6AB43}']
    function Get_Size(out value: Largeuint): HResult; stdcall;
	// out value: PByte1 --> out value: PByte    ************** WEBVIEW4DELPHI **************
    function Get_Buffer(out value: PByte): HResult; stdcall;
    function OpenStream(out value: IStream): HResult; stdcall;
	// out value: Pointer --> out value: HANDLE    ************** WEBVIEW4DELPHI **************
    function Get_FileMappingHandle(out value: HANDLE): HResult; stdcall;
    function Close: HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_17 that manages
  /// navigation requests to URI schemes registered with the OS.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_18">See the ICoreWebView2_18 article.</see></para>
  /// </remarks>
  ICoreWebView2_18 = interface(ICoreWebView2_17)
    ['{7A626017-28BE-49B2-B865-3BA2B3522D90}']
    function add_LaunchingExternalUriScheme(const eventHandler: ICoreWebView2LaunchingExternalUriSchemeEventHandler; 
                                            out token: EventRegistrationToken): HResult; stdcall;
    function remove_LaunchingExternalUriScheme(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Event handler for the LaunchingExternalUriScheme event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventhandler">See the ICoreWebView2LaunchingExternalUriSchemeEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2LaunchingExternalUriSchemeEventHandler = interface(IUnknown)
    ['{74F712E0-8165-43A9-A13F-0CCE597E75DF}']
    function Invoke(const sender: ICoreWebView2; 
                    const args: ICoreWebView2LaunchingExternalUriSchemeEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for LaunchingExternalUriScheme event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventargs">See the ICoreWebView2LaunchingExternalUriSchemeEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2LaunchingExternalUriSchemeEventArgs = interface(IUnknown)
    ['{07D1A6C3-7175-4BA1-9306-E593CA07E46C}']
    function Get_uri(out value: PWideChar): HResult; stdcall;
    function Get_InitiatingOrigin(out value: PWideChar): HResult; stdcall;
    function Get_IsUserInitiated(out value: Integer): HResult; stdcall;
    function Get_Cancel(out value: Integer): HResult; stdcall;
    function Set_Cancel(value: Integer): HResult; stdcall;
    function GetDeferral(out value: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the BrowserProcessExited event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserprocessexitedeventargs">See the ICoreWebView2BrowserProcessExitedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2BrowserProcessExitedEventArgs = interface(IUnknown)
    ['{1F00663F-AF8C-4782-9CDD-DD01C52E34CB}']
    function Get_BrowserProcessExitKind(out BrowserProcessExitKind: COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND): HResult; stdcall;
    function Get_BrowserProcessId(out value: SYSUINT): HResult; stdcall;
  end;

  /// <summary>
  /// Receives BrowserProcessExited events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserprocessexitedeventhandler">See the ICoreWebView2BrowserProcessExitedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2BrowserProcessExitedEventHandler = interface(IUnknown)
    ['{FA504257-A216-4911-A860-FE8825712861}']
    function Invoke(const sender: ICoreWebView2Environment; 
                    const args: ICoreWebView2BrowserProcessExitedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of the ICoreWebView2Controller interface to
  /// support visual hosting. An object implementing the
  /// ICoreWebView2CompositionController interface will also implement
  /// ICoreWebView2Controller. Callers are expected to use
  /// ICoreWebView2Controller for resizing, visibility, focus, and so on, and
  /// then use ICoreWebView2CompositionController to connect to a composition
  /// tree and provide input meant for the WebView.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller">See the ICoreWebView2CompositionController article.</see></para>
  /// </remarks>
  ICoreWebView2CompositionController = interface(IUnknown)
    ['{3DF9B733-B9AE-4A15-86B4-EB9EE9826469}']
    function Get_RootVisualTarget(out target: IUnknown): HResult; stdcall;
    function Set_RootVisualTarget(const target: IUnknown): HResult; stdcall;
    function SendMouseInput(eventKind: COREWEBVIEW2_MOUSE_EVENT_KIND; 
                            virtualKeys: COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS; mouseData: SYSUINT; 
                            point: tagPOINT): HResult; stdcall;
    function SendPointerInput(eventKind: COREWEBVIEW2_POINTER_EVENT_KIND; 
                              const pointerInfo: ICoreWebView2PointerInfo): HResult; stdcall;
    // function Get_Cursor(out Cursor: wireHICON): HResult; stdcall;  wireHICON -> HCURSOR  ************** WEBVIEW4DELPHI **************
    function Get_Cursor(out Cursor: HCURSOR): HResult; stdcall;
    function Get_SystemCursorId(out SystemCursorId: SYSUINT): HResult; stdcall;
    function add_CursorChanged(const eventHandler: ICoreWebView2CursorChangedEventHandler;
                               out token: EventRegistrationToken): HResult; stdcall;
    function remove_CursorChanged(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// This mostly represents a combined win32
  /// POINTER_INFO/POINTER_TOUCH_INFO/POINTER_PEN_INFO object. It takes fields
  /// from all three and excludes some win32 specific data types like HWND and
  /// HANDLE. Note, sourceDevice is taken out but we expect the PointerDeviceRect
  /// and DisplayRect to cover the existing use cases of sourceDevice.
  /// Another big difference is that any of the point or rect locations are
  /// expected to be in WebView physical coordinates. That is, coordinates
  /// relative to the WebView and no DPI scaling applied.
  //
  // The PointerId, PointerFlags, ButtonChangeKind, PenFlags, PenMask, TouchFlags,
  // and TouchMask are all #defined flags or enums in the
  // POINTER_INFO/POINTER_TOUCH_INFO/POINTER_PEN_INFO structure. We define those
  // properties here as UINT32 or INT32 and expect the developer to know how to
  // populate those values based on the Windows definitions.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo">See the ICoreWebView2PointerInfo article.</see></para>
  /// </remarks>
  ICoreWebView2PointerInfo = interface(IUnknown)
    ['{E6995887-D10D-4F5D-9359-4CE46E4F96B9}']
    function Get_PointerKind(out PointerKind: LongWord): HResult; stdcall;
    function Set_PointerKind(PointerKind: LongWord): HResult; stdcall;
    function Get_PointerId(out PointerId: SYSUINT): HResult; stdcall;
    function Set_PointerId(PointerId: SYSUINT): HResult; stdcall;
    function Get_FrameId(out FrameId: SYSUINT): HResult; stdcall;
    function Set_FrameId(FrameId: SYSUINT): HResult; stdcall;
    function Get_PointerFlags(out PointerFlags: SYSUINT): HResult; stdcall;
    function Set_PointerFlags(PointerFlags: SYSUINT): HResult; stdcall;
    function Get_PointerDeviceRect(out PointerDeviceRect: tagRECT): HResult; stdcall;
    function Set_PointerDeviceRect(PointerDeviceRect: tagRECT): HResult; stdcall;
    function Get_DisplayRect(out DisplayRect: tagRECT): HResult; stdcall;
    function Set_DisplayRect(DisplayRect: tagRECT): HResult; stdcall;
    function Get_PixelLocation(out PixelLocation: tagPOINT): HResult; stdcall;
    function Set_PixelLocation(PixelLocation: tagPOINT): HResult; stdcall;
    function Get_HimetricLocation(out HimetricLocation: tagPOINT): HResult; stdcall;
    function Set_HimetricLocation(HimetricLocation: tagPOINT): HResult; stdcall;
    function Get_PixelLocationRaw(out PixelLocationRaw: tagPOINT): HResult; stdcall;
    function Set_PixelLocationRaw(PixelLocationRaw: tagPOINT): HResult; stdcall;
    function Get_HimetricLocationRaw(out HimetricLocationRaw: tagPOINT): HResult; stdcall;
    function Set_HimetricLocationRaw(HimetricLocationRaw: tagPOINT): HResult; stdcall;
    function Get_Time(out Time: LongWord): HResult; stdcall;
    function Set_Time(Time: LongWord): HResult; stdcall;
    function Get_HistoryCount(out HistoryCount: SYSUINT): HResult; stdcall;
    function Set_HistoryCount(HistoryCount: SYSUINT): HResult; stdcall;
    function Get_InputData(out InputData: SYSINT): HResult; stdcall;
    function Set_InputData(InputData: SYSINT): HResult; stdcall;
    function Get_KeyStates(out KeyStates: LongWord): HResult; stdcall;
    function Set_KeyStates(KeyStates: LongWord): HResult; stdcall;
    function Get_PerformanceCount(out PerformanceCount: Largeuint): HResult; stdcall;
    function Set_PerformanceCount(PerformanceCount: Largeuint): HResult; stdcall;
    function Get_ButtonChangeKind(out ButtonChangeKind: SYSINT): HResult; stdcall;
    function Set_ButtonChangeKind(ButtonChangeKind: SYSINT): HResult; stdcall;
    function Get_PenFlags(out PenFlags: SYSUINT): HResult; stdcall;
    function Set_PenFlags(PenFlags: SYSUINT): HResult; stdcall;
    function Get_PenMask(out PenMask: SYSUINT): HResult; stdcall;
    function Set_PenMask(PenMask: SYSUINT): HResult; stdcall;
    function Get_PenPressure(out PenPressure: SYSUINT): HResult; stdcall;
    function Set_PenPressure(PenPressure: SYSUINT): HResult; stdcall;
    function Get_PenRotation(out PenRotation: SYSUINT): HResult; stdcall;
    function Set_PenRotation(PenRotation: SYSUINT): HResult; stdcall;
    function Get_PenTiltX(out PenTiltX: SYSINT): HResult; stdcall;
    function Set_PenTiltX(PenTiltX: SYSINT): HResult; stdcall;
    function Get_PenTiltY(out PenTiltY: SYSINT): HResult; stdcall;
    function Set_PenTiltY(PenTiltY: SYSINT): HResult; stdcall;
    function Get_TouchFlags(out TouchFlags: SYSUINT): HResult; stdcall;
    function Set_TouchFlags(TouchFlags: SYSUINT): HResult; stdcall;
    function Get_TouchMask(out TouchMask: SYSUINT): HResult; stdcall;
    function Set_TouchMask(TouchMask: SYSUINT): HResult; stdcall;
    function Get_TouchContact(out TouchContact: tagRECT): HResult; stdcall;
    function Set_TouchContact(TouchContact: tagRECT): HResult; stdcall;
    function Get_TouchContactRaw(out TouchContactRaw: tagRECT): HResult; stdcall;
    function Set_TouchContactRaw(TouchContactRaw: tagRECT): HResult; stdcall;
    function Get_TouchOrientation(out TouchOrientation: SYSUINT): HResult; stdcall;
    function Set_TouchOrientation(TouchOrientation: SYSUINT): HResult; stdcall;
    function Get_TouchPressure(out TouchPressure: SYSUINT): HResult; stdcall;
    function Set_TouchPressure(TouchPressure: SYSUINT): HResult; stdcall;
  end;

  /// <summary>
  /// The caller implements this interface to receive CursorChanged events. Use
  /// the Cursor property to get the new cursor.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cursorchangedeventhandler">See the ICoreWebView2CursorChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CursorChangedEventHandler = interface(IUnknown)
    ['{9DA43CCC-26E1-4DAD-B56C-D8961C94C571}']
    function Invoke(const sender: ICoreWebView2CompositionController; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2CompositionController interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller2">See the ICoreWebView2CompositionController2 article.</see></para>
  /// </remarks>
  ICoreWebView2CompositionController2 = interface(ICoreWebView2CompositionController)
    ['{0B6A3D24-49CB-4806-BA20-B5E0734A7B26}']
    function Get_AutomationProvider(out provider: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is the continuation of the
  /// ICoreWebView2CompositionController2 interface to manage drag and drop.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller3">See the ICoreWebView2CompositionController3 article.</see></para>
  /// </remarks>
  ICoreWebView2CompositionController3 = interface(ICoreWebView2CompositionController2)
    ['{9570570E-4D76-4361-9EE1-F04D0DBDFB1E}']
    function DragEnter(const dataObject: IDataObject; keyState: LongWord; point: tagPOINT; 
                       out effect: LongWord): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function DragOver(keyState: LongWord; point: tagPOINT; out effect: LongWord): HResult; stdcall;
    function Drop(const dataObject: IDataObject; keyState: LongWord; point: tagPOINT; 
                  out effect: LongWord): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Controller interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller2">See the ICoreWebView2Controller2 article.</see></para>
  /// </remarks>
  ICoreWebView2Controller2 = interface(ICoreWebView2Controller)
    ['{C979903E-D4CA-4228-92EB-47EE3FA96EAB}']
    function Get_DefaultBackgroundColor(out backgroundColor: COREWEBVIEW2_COLOR): HResult; stdcall;
    function Set_DefaultBackgroundColor(backgroundColor: COREWEBVIEW2_COLOR): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Controller2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller3">See the ICoreWebView2Controller3 article.</see></para>
  /// </remarks>
  ICoreWebView2Controller3 = interface(ICoreWebView2Controller2)
    ['{F9614724-5D2B-41DC-AEF7-73D62B51543B}']
    function Get_RasterizationScale(out scale: Double): HResult; stdcall;
    function Set_RasterizationScale(scale: Double): HResult; stdcall;
    function Get_ShouldDetectMonitorScaleChanges(out value: Integer): HResult; stdcall;
    function Set_ShouldDetectMonitorScaleChanges(value: Integer): HResult; stdcall;
    function add_RasterizationScaleChanged(const eventHandler: ICoreWebView2RasterizationScaleChangedEventHandler;
                                           out token: EventRegistrationToken): HResult; stdcall;
    function remove_RasterizationScaleChanged(token: EventRegistrationToken): HResult; stdcall;
    function Get_BoundsMode(out BoundsMode: COREWEBVIEW2_BOUNDS_MODE): HResult; stdcall;
    function Set_BoundsMode(BoundsMode: COREWEBVIEW2_BOUNDS_MODE): HResult; stdcall;
  end;

  /// <summary>
  /// Receives RasterizationScaleChanged events.  Use the RasterizationScale
  /// property to get the modified scale.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2rasterizationscalechangedeventhandler">See the ICoreWebView2RasterizationScaleChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2RasterizationScaleChangedEventHandler = interface(IUnknown)
    ['{9C98C8B1-AC53-427E-A345-3049B5524BBE}']
    function Invoke(const sender: ICoreWebView2Controller; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView2Controller4 interface.
  /// The ICoreWebView2Controller4 provides interface to enable/disable external drop.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller4">See the ICoreWebView2Controller4 article.</see></para>
  /// </remarks>
  ICoreWebView2Controller4 = interface(ICoreWebView2Controller3)
    ['{97D418D5-A426-4E49-A151-E1A10F327D9E}']
    function Get_AllowExternalDrop(out value: Integer): HResult; stdcall;
    function Set_AllowExternalDrop(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is used to manage profile options that created by 'CreateCoreWebView2ControllerOptions'.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions">See the ICoreWebView2ControllerOptions article.</see></para>
  /// </remarks>
  ICoreWebView2ControllerOptions = interface(IUnknown)
    ['{12AAE616-8CCB-44EC-BCB3-EB1831881635}']
    function Get_ProfileName(out value: PWideChar): HResult; stdcall;
    function Set_ProfileName(value: PWideChar): HResult; stdcall;
    function Get_IsInPrivateModeEnabled(out value: Integer): HResult; stdcall;
    function Set_IsInPrivateModeEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This is the interface in ControllerOptions for ScriptLocale.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions2">See the ICoreWebView2ControllerOptions2 article.</see></para>
  /// </remarks>
  ICoreWebView2ControllerOptions2 = interface(ICoreWebView2ControllerOptions)
    ['{06C991D8-9E7E-11ED-A8FC-0242AC120002}']
    function Get_ScriptLocale(out locale: PWideChar): HResult; stdcall;
    function Set_ScriptLocale(locale: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// The caller implements this interface to receive the ClearBrowsingData result.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clearbrowsingdatacompletedhandler">See the ICoreWebView2ClearBrowsingDataCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ClearBrowsingDataCompletedHandler = interface(IUnknown)
    ['{E9710A06-1D1D-49B2-8234-226F35846AE5}']
    function Invoke(errorCode: HResult): HResult; stdcall;
  end;

  /// <summary>
  /// The caller implements this interface to receive the CoreWebView2Controller
  /// created via CreateCoreWebView2CompositionController.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2compositioncontrollercompletedhandler">See the ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler = interface(IUnknown)
    ['{02FAB84B-1428-4FB7-AD45-1B2E64736184}']
    function Invoke(errorCode: HResult; const webView: ICoreWebView2CompositionController): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the WebView2Environment created using
  /// CreateCoreWebView2Environment.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2environmentcompletedhandler">See the ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler = interface(IUnknown)
    ['{4E8A3389-C9D8-4BD2-B6B5-124FEE6CC14D}']
    function Invoke(errorCode: HResult; const createdEnvironment: ICoreWebView2Environment): HResult; stdcall;
  end;

  /// <summary>
  /// Represents the registration of a custom scheme with the
  /// CoreWebView2Environment.
  /// This allows the WebView2 app to be able to handle WebResourceRequested
  /// event for requests with the specified scheme and be able to navigate the
  /// WebView2 to the custom scheme. Once the environment is created, the
  /// registrations are valid and immutable throughout the lifetime of the
  /// associated WebView2s' browser process and any WebView2 environments
  /// sharing the browser process must be created with identical custom scheme
  /// registrations, otherwise the environment creation will fail.
  /// Any further attempts to register the same scheme will fail during environment creation.
  /// The URIs of registered custom schemes will be treated similar to http
  /// URIs for their origins.
  /// They will have tuple origins for URIs with host and opaque origins for
  /// URIs without host as specified in
  /// [7.5 Origin - HTML Living Standard](https://html.spec.whatwg.org/multipage/origin.html)
  ///
  /// Example:
  /// custom-scheme-with-host://hostname/path/to/resource has origin of
  /// custom-scheme-with-host://hostname.
  /// custom-scheme-without-host:path/to/resource has origin of
  /// custom-scheme-without-host:path/to/resource.
  /// For WebResourceRequested event, the cases of request URIs and filter URIs
  /// with custom schemes will be normalized according to generic URI syntax
  /// rules. Any non-ASCII characters will be preserved.
  /// The registered custom schemes also participate in
  /// [CORS](https://developer.mozilla.org/docs/Web/HTTP/CORS) and
  /// adheres to [CSP](https://developer.mozilla.org/docs/Web/HTTP/CSP).
  /// The app needs to set the appropriate access headers in its
  /// WebResourceRequested event handler to allow CORS requests.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customschemeregistration">See the ICoreWebView2CustomSchemeRegistration article.</see></para>
  /// </remarks>
  ICoreWebView2CustomSchemeRegistration = interface(IUnknown)
    ['{D60AC92C-37A6-4B26-A39E-95CFE59047BB}']
    function Get_SchemeName(out SchemeName: PWideChar): HResult; stdcall;
    function Get_TreatAsSecure(out TreatAsSecure: Integer): HResult; stdcall;
    function Set_TreatAsSecure(TreatAsSecure: Integer): HResult; stdcall;
	// out allowedOrigins: PPWideChar1 --> out allowedOrigins: PPWideChar    ************** WEBVIEW4DELPHI **************
    function GetAllowedOrigins(out allowedOriginsCount: SYSUINT; out allowedOrigins: PPWideChar): HResult; stdcall; 
	// var allowedOrigins: PWideChar --> allowedOrigins: PPWideChar    ************** WEBVIEW4DELPHI **************
    function SetAllowedOrigins(allowedOriginsCount: SYSUINT; allowedOrigins: PPWideChar): HResult; stdcall; 
    function Get_HasAuthorityComponent(out HasAuthorityComponent: Integer): HResult; stdcall;
    function Set_HasAuthorityComponent(HasAuthorityComponent: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This is a continuation of the ICoreWebView2DevToolsProtocolEventReceivedEventArgs
  /// interface that provides the session ID of the target where the event originates from.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventargs2">See the ICoreWebView2DevToolsProtocolEventReceivedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2DevToolsProtocolEventReceivedEventArgs2 = interface(ICoreWebView2DevToolsProtocolEventReceivedEventArgs)
    ['{2DC4959D-1494-4393-95BA-BEA4CB9EBD1B}']
    function Get_sessionId(out sessionId: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment2">See the ICoreWebView2Environment2 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment2 = interface(ICoreWebView2Environment)
    ['{41F3632B-5EF4-404F-AD82-2D606C5A9A21}']
    function CreateWebResourceRequest(uri: PWideChar; Method: PWideChar; const postData: IStream; 
                                      Headers: PWideChar; 
                                      out Request: ICoreWebView2WebResourceRequest): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment3">See the ICoreWebView2Environment3 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment3 = interface(ICoreWebView2Environment2)
    ['{80A22AE3-BE7C-4CE2-AFE1-5A50056CDEEB}']
    // var ParentWindow: _RemotableHandle --> ParentWindow: HWND    ************** WEBVIEW4DELPHI **************
    function CreateCoreWebView2CompositionController(ParentWindow: HWND;
                                                     const handler: ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler): HResult; stdcall;
    function CreateCoreWebView2PointerInfo(out pointerInfo: ICoreWebView2PointerInfo): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment3 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment4">See the ICoreWebView2Environment4 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment4 = interface(ICoreWebView2Environment3)
    ['{20944379-6DCF-41D6-A0A0-ABC0FC50DE0D}']
    // function GetAutomationProviderForWindow(var hwnd: _RemotableHandle; out provider: IUnknown): HResult; stdcall;  var hwnd: _RemotableHandle -> aHWND: HWND    ************** WEBVIEW4DELPHI **************
    function GetAutomationProviderForWindow(aHWND: HWND; out provider: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment4 interface that supports
  /// the BrowserProcessExited event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment5">See the ICoreWebView2Environment5 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment5 = interface(ICoreWebView2Environment4)
    ['{319E423D-E0D7-4B8D-9254-AE9475DE9B17}']
    function add_BrowserProcessExited(const eventHandler: ICoreWebView2BrowserProcessExitedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    function remove_BrowserProcessExited(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of the ICoreWebView2Environment that supports
  /// creating print settings for printing to PDF.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment6">See the ICoreWebView2Environment6 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment6 = interface(ICoreWebView2Environment5)
    ['{E59EE362-ACBD-4857-9A8E-D3644D9459A9}']
    function CreatePrintSettings(out printSettings: ICoreWebView2PrintSettings): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of the ICoreWebView2Environment. An object
  /// implementing the ICoreWebView2Environment7 interface will also
  /// implement ICoreWebView2Environment.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment7">See the ICoreWebView2Environment7 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment7 = interface(ICoreWebView2Environment6)
    ['{43C22296-3BBD-43A4-9C00-5C0DF6DD29A2}']
    function Get_UserDataFolder(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment7 interface that supports
  /// the ProcessInfosChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8">See the ICoreWebView2Environment8 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment8 = interface(ICoreWebView2Environment7)
    ['{D6EB91DD-C3D2-45E5-BD29-6DC2BC4DE9CF}']
    function add_ProcessInfosChanged(const eventHandler: ICoreWebView2ProcessInfosChangedEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    function remove_ProcessInfosChanged(token: EventRegistrationToken): HResult; stdcall;
    function GetProcessInfos(out value: ICoreWebView2ProcessInfoCollection): HResult; stdcall;
  end;

  /// <summary>
  /// An event handler for the ProcessInfosChanged event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfoschangedeventhandler">See the ICoreWebView2ProcessInfosChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessInfosChangedEventHandler = interface(IUnknown)
    ['{F4AF0C39-44B9-40E9-8B11-0484CFB9E0A1}']
    function Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A list containing process id and corresponding process type.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfocollection">See the ICoreWebView2ProcessInfoCollection article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessInfoCollection = interface(IUnknown)
    ['{402B99CD-A0CC-4FA5-B7A5-51D86A1D2339}']
    function Get_Count(out Count: SYSUINT): HResult; stdcall;
    function GetValueAtIndex(index: SYSUINT; out processInfo: ICoreWebView2ProcessInfo): HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties for a process in the ICoreWebView2Environment.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfo">See the ICoreWebView2ProcessInfo article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessInfo = interface(IUnknown)
    ['{84FA7612-3F3D-4FBF-889D-FAD000492D72}']
    function Get_ProcessId(out value: SYSINT): HResult; stdcall;
    function Get_Kind(out Kind: COREWEBVIEW2_PROCESS_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment interface for
  /// creating CoreWebView2 ContextMenuItem objects.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment9">See the ICoreWebView2Environment9 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment9 = interface(ICoreWebView2Environment8)
    ['{F06F41BF-4B5A-49D8-B9F6-FA16CD29F274}']
    function CreateContextMenuItem(Label_: PWideChar; const iconStream: IStream; 
                                   Kind: COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND; 
                                   out item: ICoreWebView2ContextMenuItem): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is used to create ICoreWebView2ControllerOptions object, which
  /// can be passed as a parameter in CreateCoreWebView2ControllerWithOptions and
  /// CreateCoreWebView2CompositionControllerWithOptions function for multiple profiles support.
  /// The profile will be created on disk or opened when calling CreateCoreWebView2ControllerWithOptions or
  /// CreateCoreWebView2CompositionControllerWithOptions no matter InPrivate mode is enabled or not, and
  /// it will be released in memory when the corresponding controller is closed but still remain on disk.
  /// If you create a WebView2Controller with {ProfileName="name", InPrivate=false} and then later create another
  /// one with {ProfileName="name", InPrivate=true}, these two controllers using the same profile would be allowed to
  /// run at the same time.
  /// As WebView2 is built on top of Edge browser, it follows Edge's behavior pattern. To create an InPrivate WebView,
  /// we gets an off-the-record profile (an InPrivate profile) from a regular profile, then create the WebView with the
  /// off-the-record profile.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment10">See the ICoreWebView2Environment10 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment10 = interface(ICoreWebView2Environment9)
    ['{EE0EB9DF-6F12-46CE-B53F-3F47B9C928E0}']
    function CreateCoreWebView2ControllerOptions(out options: ICoreWebView2ControllerOptions): HResult; stdcall;
    // var ParentWindow: _RemotableHandle --> ParentWindow: HWND    ************** WEBVIEW4DELPHI **************
    function CreateCoreWebView2ControllerWithOptions(ParentWindow: HWND;
                                                     const options: ICoreWebView2ControllerOptions;
                                                     const handler: ICoreWebView2CreateCoreWebView2ControllerCompletedHandler): HResult; stdcall;
    // var ParentWindow: _RemotableHandle --> ParentWindow: HWND    ************** WEBVIEW4DELPHI **************
    function CreateCoreWebView2CompositionControllerWithOptions(ParentWindow: HWND;
                                                                const options: ICoreWebView2ControllerOptions; 
                                                                const handler: ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment interface for
  /// getting the crash dump folder path.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment11">See the ICoreWebView2Environment11 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment11 = interface(ICoreWebView2Environment10)
    ['{F0913DC6-A0EC-42EF-9805-91DFF3A2966A}']
    function Get_FailureReportFolderPath(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment interface for creating shared buffer object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment12">See the ICoreWebView2Environment12 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment12 = interface(ICoreWebView2Environment11)
    ['{F503DB9B-739F-48DD-B151-FDFCF253F54E}']
    function CreateSharedBuffer(Size: Largeuint; out shared_buffer: ICoreWebView2SharedBuffer): HResult; stdcall;
  end;

  /// <summary>
  /// Options used to create WebView2 Environment.  A default implementation is
  /// provided in WebView2EnvironmentOptions.h.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions">See the ICoreWebView2EnvironmentOptions article.</see></para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions = interface(IUnknown)
    ['{2FDE08A8-1E9A-4766-8C05-95A9CEB9D1C5}']
    function Get_AdditionalBrowserArguments(out value: PWideChar): HResult; stdcall;
    function Set_AdditionalBrowserArguments(value: PWideChar): HResult; stdcall;
    function Get_Language(out value: PWideChar): HResult; stdcall;
    function Set_Language(value: PWideChar): HResult; stdcall;
    function Get_TargetCompatibleBrowserVersion(out value: PWideChar): HResult; stdcall;
    function Set_TargetCompatibleBrowserVersion(value: PWideChar): HResult; stdcall;
    function Get_AllowSingleSignOnUsingOSPrimaryAccount(out allow: Integer): HResult; stdcall;
    function Set_AllowSingleSignOnUsingOSPrimaryAccount(allow: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Additional options used to create WebView2 Environment.  A default implementation is
  /// provided in WebView2EnvironmentOptions.h.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions2">See the ICoreWebView2EnvironmentOptions2 article.</see></para>
  /// <para>ICoreWebView2EnvironmentOptions* interfaces derive from IUnknown to make moving
  /// the API from experimental to public smoothier. These interfaces are mostly internal to
  /// WebView's own code. Normal apps just use the objects we provided and never interact
  /// with the interfaces. Advanced apps might implement their own options object. In that
  /// case, it is also easier for them to implement the interface if it is derived from IUnknown.</para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions2 = interface(IUnknown)
    ['{FF85C98A-1BA7-4A6B-90C8-2B752C89E9E2}']
    function Get_ExclusiveUserDataFolderAccess(out value: Integer): HResult; stdcall;
    function Set_ExclusiveUserDataFolderAccess(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Additional options used to create WebView2 Environment to manage crash
  /// reporting.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions3">See the ICoreWebView2EnvironmentOptions3 article.</see></para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions3 = interface(IUnknown)
    ['{4A5C436E-A9E3-4A2E-89C3-910D3513F5CC}']
    function Get_IsCustomCrashReportingEnabled(out value: Integer): HResult; stdcall;
    function Set_IsCustomCrashReportingEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Additional options used to create WebView2 Environment that manages custom scheme registration.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions4">See the ICoreWebView2EnvironmentOptions4 article.</see></para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions4 = interface(IUnknown)
    ['{AC52D13F-0D38-475A-9DCA-876580D6793E}']
    // out schemeRegistrations: PPUserType3 --> out schemeRegistrations: PPCoreWebView2CustomSchemeRegistration    ************** WEBVIEW4DELPHI **************
    function GetCustomSchemeRegistrations(out Count: SYSUINT; out schemeRegistrations: PPCoreWebView2CustomSchemeRegistration): HResult; stdcall;
    // var schemeRegistrations: ICoreWebView2CustomSchemeRegistration --> schemeRegistrations: PPCoreWebView2CustomSchemeRegistration    ************** WEBVIEW4DELPHI **************
    function SetCustomSchemeRegistrations(Count: SYSUINT; schemeRegistrations: PPCoreWebView2CustomSchemeRegistration): HResult; stdcall;
  end;

  /// <summary>
  /// Additional options used to create WebView2 Environment to manage tracking
  /// prevention.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions5">See the ICoreWebView2EnvironmentOptions5 article.</see></para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions5 = interface(IUnknown)
    ['{0AE35D64-C47F-4464-814E-259C345D1501}']
    function Get_EnableTrackingPrevention(out value: Integer): HResult; stdcall;
    function Set_EnableTrackingPrevention(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Frame interface with navigation events,
  /// executing script and posting web messages.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame2">See the ICoreWebView2Frame2 article.</see></para>
  /// </remarks>
  ICoreWebView2Frame2 = interface(ICoreWebView2Frame)
    ['{7A6A5834-D185-4DBF-B63F-4A9BC43107D4}']
    function add_NavigationStarting(const eventHandler: ICoreWebView2FrameNavigationStartingEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_NavigationStarting(token: EventRegistrationToken): HResult; stdcall;
    function add_ContentLoading(const eventHandler: ICoreWebView2FrameContentLoadingEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    function remove_ContentLoading(token: EventRegistrationToken): HResult; stdcall;
    function add_NavigationCompleted(const eventHandler: ICoreWebView2FrameNavigationCompletedEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    function remove_NavigationCompleted(token: EventRegistrationToken): HResult; stdcall;
    function add_DOMContentLoaded(const eventHandler: ICoreWebView2FrameDOMContentLoadedEventHandler; 
                                  out token: EventRegistrationToken): HResult; stdcall;
    function remove_DOMContentLoaded(token: EventRegistrationToken): HResult; stdcall;
    function ExecuteScript(javaScript: PWideChar; 
                           const handler: ICoreWebView2ExecuteScriptCompletedHandler): HResult; stdcall;
    function PostWebMessageAsJson(webMessageAsJson: PWideChar): HResult; stdcall;
    function PostWebMessageAsString(webMessageAsString: PWideChar): HResult; stdcall;
    function add_WebMessageReceived(const handler: ICoreWebView2FrameWebMessageReceivedEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    function remove_WebMessageReceived(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NavigationStarting events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenavigationstartingeventhandler">See the ICoreWebView2FrameNavigationStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameNavigationStartingEventHandler = interface(IUnknown)
    ['{E79908BF-2D5D-4968-83DB-263FEA2C1DA3}']
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives ContentLoading events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecontentloadingeventhandler">See the ICoreWebView2FrameContentLoadingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameContentLoadingEventHandler = interface(IUnknown)
    ['{0D6156F2-D332-49A7-9E03-7D8F2FEEEE54}']
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NavigationCompleted events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenavigationcompletedeventhandler">See the ICoreWebView2FrameNavigationCompletedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameNavigationCompletedEventHandler = interface(IUnknown)
    ['{609302AD-0E36-4F9A-A210-6A45272842A9}']
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives DOMContentLoaded events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framedomcontentloadedeventhandler">See the ICoreWebView2FrameDOMContentLoadedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameDOMContentLoadedEventHandler = interface(IUnknown)
    ['{38D9520D-340F-4D1E-A775-43FCE9753683}']
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives WebMessageReceived events for iframe.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framewebmessagereceivedeventhandler">See the ICoreWebView2FrameWebMessageReceivedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameWebMessageReceivedEventHandler = interface(IUnknown)
    ['{E371E005-6D1D-4517-934B-A8F1629C62A5}']
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2WebMessageReceivedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// This is an extension of the ICoreWebView2Frame interface that supports PermissionRequested
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame3">See the ICoreWebView2Frame3 article.</see></para>
  /// </remarks>
  ICoreWebView2Frame3 = interface(ICoreWebView2Frame2)
    ['{B50D82CC-CC28-481D-9614-CB048895E6A0}']
    function add_PermissionRequested(const handler: ICoreWebView2FramePermissionRequestedEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    function remove_PermissionRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives PermissionRequested events for iframes.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framepermissionrequestedeventhandler">See the ICoreWebView2FramePermissionRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FramePermissionRequestedEventHandler = interface(IUnknown)
    ['{845D0EDD-8BD8-429B-9915-4821789F23E9}']
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2PermissionRequestedEventArgs2): HResult; stdcall;
  end;

  /// <summary>
  /// This is a continuation of the ICoreWebView2PermissionRequestedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs2">See the ICoreWebView2PermissionRequestedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2PermissionRequestedEventArgs2 = interface(ICoreWebView2PermissionRequestedEventArgs)
    ['{74D7127F-9DE6-4200-8734-42D6FB4FF741}']
    function Get_Handled(out Handled: Integer): HResult; stdcall;
    function Set_Handled(Handled: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This is an extension of the ICoreWebView2Frame interface that supports shared buffer based on file mapping.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame4">See the ICoreWebView2Frame4 article.</see></para>
  /// </remarks>
  ICoreWebView2Frame4 = interface(ICoreWebView2Frame3)
    ['{188782DC-92AA-4732-AB3C-FCC59F6F68B9}']
    function PostSharedBufferToScript(const sharedBuffer: ICoreWebView2SharedBuffer; 
                                      access: COREWEBVIEW2_SHARED_BUFFER_ACCESS;
                                      additionalDataAsJson: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties for a frame in the ICoreWebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo">See the ICoreWebView2FrameInfo article.</see></para>
  /// </remarks>
  ICoreWebView2FrameInfo = interface(IUnknown)
    ['{DA86B8A1-BDF3-4F11-9955-528CEFA59727}']
    function Get_name(out name: PWideChar): HResult; stdcall;
    function Get_Source(out Source: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Collection of FrameInfos (name and source). Used to list the affected
  /// frames' info when a frame-only render process failure occurs in the
  /// ICoreWebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollection">See the ICoreWebView2FrameInfoCollection article.</see></para>
  /// </remarks>
  ICoreWebView2FrameInfoCollection = interface(IUnknown)
    ['{8F834154-D38E-4D90-AFFB-6800A7272839}']
    function GetIterator(out iterator: ICoreWebView2FrameInfoCollectionIterator): HResult; stdcall;
  end;

  /// <summary>
  /// Iterator for a collection of FrameInfos. For more info, see
  /// ICoreWebView2ProcessFailedEventArgs2 and
  /// ICoreWebView2FrameInfoCollection.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfocollectioniterator">See the ICoreWebView2FrameInfoCollectionIterator article.</see></para>
  /// </remarks>
  ICoreWebView2FrameInfoCollectionIterator = interface(IUnknown)
    ['{1BF89E2D-1B2B-4629-B28F-05099B41BB03}']
    function Get_hasCurrent(out hasCurrent: Integer): HResult; stdcall;
    function GetCurrent(out frameInfo: ICoreWebView2FrameInfo): HResult; stdcall;
    function MoveNext(out hasNext: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// The caller implements this interface to handle the result of
  /// GetNonDefaultPermissionSettings.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getnondefaultpermissionsettingscompletedhandler">See the ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler = interface(IUnknown)
    ['{38274481-A15C-4563-94CF-990EDC9AEB95}']
    function Invoke(errorCode: HResult; 
                    const collectionView: ICoreWebView2PermissionSettingCollectionView): HResult; stdcall;
  end;

  /// <summary>
  /// Read-only collection of PermissionSettings (origin, kind, and state). Used to list
  /// the nondefault permission settings on the profile that are persisted across
  /// sessions.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsettingcollectionview">See the ICoreWebView2PermissionSettingCollectionView article.</see></para>
  /// </remarks>
  ICoreWebView2PermissionSettingCollectionView = interface(IUnknown)
    ['{F5596F62-3DE5-47B1-91E8-A4104B596B96}']
    function GetValueAtIndex(index: SYSUINT; out permissionSetting: ICoreWebView2PermissionSetting): HResult; stdcall;
    function Get_Count(out value: SYSUINT): HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties for a permission setting.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionsetting">See the ICoreWebView2PermissionSetting article.</see></para>
  /// </remarks>
  ICoreWebView2PermissionSetting = interface(IUnknown)
    ['{792B6ECA-5576-421C-9119-74EBB3A4FFB3}']
    function Get_PermissionKind(out value: COREWEBVIEW2_PERMISSION_KIND): HResult; stdcall;
    function Get_PermissionOrigin(out value: PWideChar): HResult; stdcall;
    function Get_PermissionState(out value: COREWEBVIEW2_PERMISSION_STATE): HResult; stdcall;
  end;

  /// <summary>
  /// This is an interface for the StatusCode property of
  /// ICoreWebView2NavigationCompletedEventArgs
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationcompletedeventargs2">See the ICoreWebView2NavigationCompletedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationCompletedEventArgs2 = interface(ICoreWebView2NavigationCompletedEventArgs)
    ['{FDF8B738-EE1E-4DB2-A329-8D7D7B74D792}']
    function Get_HttpStatusCode(out http_status_code: SYSINT): HResult; stdcall;
  end;

  /// <summary>
  /// The AdditionalAllowedFrameAncestors API that enable developers to provide additional allowed frame ancestors.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs2">See the ICoreWebView2NavigationStartingEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationStartingEventArgs2 = interface(ICoreWebView2NavigationStartingEventArgs)
    ['{9086BE93-91AA-472D-A7E0-579F2BA006AD}']
    function Get_AdditionalAllowedFrameAncestors(out value: PWideChar): HResult; stdcall;
    function Set_AdditionalAllowedFrameAncestors(value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// The NavigationKind API that enables developers to get more information about
  /// navigation type.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs3">See the ICoreWebView2NavigationStartingEventArgs3 article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationStartingEventArgs3 = interface(ICoreWebView2NavigationStartingEventArgs2)
    ['{DDFFE494-4942-4BD2-AB73-35B8FF40E19F}']
    function Get_NavigationKind(out navigation_kind: COREWEBVIEW2_NAVIGATION_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// This is a continuation of the ICoreWebView2NewWindowRequestedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs2">See the ICoreWebView2NewWindowRequestedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2NewWindowRequestedEventArgs2 = interface(ICoreWebView2NewWindowRequestedEventArgs)
    ['{BBC7BAED-74C6-4C92-B63A-7F5AEAE03DE3}']
    function Get_name(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// This is a continuation of the ICoreWebView2PermissionRequestedEventArgs
  /// interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs3">See the ICoreWebView2PermissionRequestedEventArgs3 article.</see></para>
  /// </remarks>
  ICoreWebView2PermissionRequestedEventArgs3 = interface(ICoreWebView2PermissionRequestedEventArgs2)
    ['{E61670BC-3DCE-4177-86D2-C629AE3CB6AC}']
    function Get_SavesInProfile(out value: Integer): HResult; stdcall;
    function Set_SavesInProfile(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Settings used by the Print method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printsettings2">See the ICoreWebView2PrintSettings2 article.</see></para>
  /// </remarks>
  ICoreWebView2PrintSettings2 = interface(ICoreWebView2PrintSettings)
    ['{CA7F0E1F-3484-41D1-8C1A-65CD44A63F8D}']
    function Get_PageRanges(out value: PWideChar): HResult; stdcall;
    function Set_PageRanges(value: PWideChar): HResult; stdcall;
    function Get_PagesPerSide(out value: SYSINT): HResult; stdcall;
    function Set_PagesPerSide(value: SYSINT): HResult; stdcall;
    function Get_Copies(out value: SYSINT): HResult; stdcall;
    function Set_Copies(value: SYSINT): HResult; stdcall;
    function Get_Collation(out value: COREWEBVIEW2_PRINT_COLLATION): HResult; stdcall;
    function Set_Collation(value: COREWEBVIEW2_PRINT_COLLATION): HResult; stdcall;
    function Get_ColorMode(out value: COREWEBVIEW2_PRINT_COLOR_MODE): HResult; stdcall;
    function Set_ColorMode(value: COREWEBVIEW2_PRINT_COLOR_MODE): HResult; stdcall;
    function Get_Duplex(out value: COREWEBVIEW2_PRINT_DUPLEX): HResult; stdcall;
    function Set_Duplex(value: COREWEBVIEW2_PRINT_DUPLEX): HResult; stdcall;
    function Get_MediaSize(out value: COREWEBVIEW2_PRINT_MEDIA_SIZE): HResult; stdcall;
    function Set_MediaSize(value: COREWEBVIEW2_PRINT_MEDIA_SIZE): HResult; stdcall;
    function Get_PrinterName(out value: PWideChar): HResult; stdcall;
    function Set_PrinterName(value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2ProcessFailedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs2">See the ICoreWebView2ProcessFailedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessFailedEventArgs2 = interface(ICoreWebView2ProcessFailedEventArgs)
    ['{4DAB9422-46FA-4C3E-A5D2-41D2071D3680}']
    function Get_reason(out reason: COREWEBVIEW2_PROCESS_FAILED_REASON): HResult; stdcall;
    function Get_ExitCode(out ExitCode: SYSINT): HResult; stdcall;
    function Get_ProcessDescription(out ProcessDescription: PWideChar): HResult; stdcall;
    function Get_FrameInfosForFailedProcess(out frames: ICoreWebView2FrameInfoCollection): HResult; stdcall;
  end;

  /// <summary>
  /// Profile2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2">See the ICoreWebView2Profile2 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile2 = interface(ICoreWebView2Profile)
    ['{FA740D4B-5EAE-4344-A8AD-74BE31925397}']
    function ClearBrowsingData(dataKinds: COREWEBVIEW2_BROWSING_DATA_KINDS; 
                               const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): HResult; stdcall;
    function ClearBrowsingDataInTimeRange(dataKinds: COREWEBVIEW2_BROWSING_DATA_KINDS; 
                                          startTime: Double; endTime: Double; 
                                          const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): HResult; stdcall;
    function ClearBrowsingDataAll(const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// This is an extension of the ICoreWebView2Profile interface to control levels of tracking prevention.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile3">See the ICoreWebView2Profile3 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile3 = interface(ICoreWebView2Profile2)
    ['{B188E659-5685-4E05-BDBA-FC640E0F1992}']
    function Get_PreferredTrackingPreventionLevel(out value: COREWEBVIEW2_TRACKING_PREVENTION_LEVEL): HResult; stdcall;
    function Set_PreferredTrackingPreventionLevel(value: COREWEBVIEW2_TRACKING_PREVENTION_LEVEL): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView2Profile interface for the permission management APIs.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile4">See the ICoreWebView2Profile4 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile4 = interface(ICoreWebView2Profile3)
    ['{8F4AE680-192E-4EC8-833A-21CFADAEF628}']
    function SetPermissionState(PermissionKind: COREWEBVIEW2_PERMISSION_KIND; origin: PWideChar; 
                                State: COREWEBVIEW2_PERMISSION_STATE; 
                                const completedHandler: ICoreWebView2SetPermissionStateCompletedHandler): HResult; stdcall;
    function GetNonDefaultPermissionSettings(const completedHandler: ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// The caller implements this interface to handle the result of
  /// SetPermissionState.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2setpermissionstatecompletedhandler">See the ICoreWebView2SetPermissionStateCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2SetPermissionStateCompletedHandler = interface(IUnknown)
    ['{FC77FB30-9C9E-4076-B8C7-7644A703CA1B}']
    function Invoke(errorCode: HResult): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView2Profile interface for cookie manager.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile5">See the ICoreWebView2Profile5 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile5 = interface(ICoreWebView2Profile4)
    ['{2EE5B76E-6E80-4DF2-BCD3-D4EC3340A01B}']
    function Get_CookieManager(out CookieManager: ICoreWebView2CookieManager): HResult; stdcall;
  end;

  /// <summary>
  /// Interfaces in profile for managing password-autosave and general-autofill.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile6">See the ICoreWebView2Profile6 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile6 = interface(ICoreWebView2Profile5)
    ['{BD82FA6A-1D65-4C33-B2B4-0393020CC61B}']
    function Get_IsPasswordAutosaveEnabled(out value: Integer): HResult; stdcall;
    function Set_IsPasswordAutosaveEnabled(value: Integer): HResult; stdcall;
    function Get_IsGeneralAutofillEnabled(out value: Integer): HResult; stdcall;
    function Set_IsGeneralAutofillEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface that manages the user agent.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings2">See the ICoreWebView2Settings2 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings2 = interface(ICoreWebView2Settings)
    ['{EE9A0F68-F46C-4E32-AC23-EF8CAC224D2A}']
    function Get_UserAgent(out UserAgent: PWideChar): HResult; stdcall;
    function Set_UserAgent(UserAgent: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface that manages whether
  /// browser accelerator keys are enabled.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings3">See the ICoreWebView2Settings3 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings3 = interface(ICoreWebView2Settings2)
    ['{FDB5AB74-AF33-4854-84F0-0A631DEB5EBA}']
    function Get_AreBrowserAcceleratorKeysEnabled(out AreBrowserAcceleratorKeysEnabled: Integer): HResult; stdcall;
    function Set_AreBrowserAcceleratorKeysEnabled(AreBrowserAcceleratorKeysEnabled: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage autofill.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings4">See the ICoreWebView2Settings4 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings4 = interface(ICoreWebView2Settings3)
    ['{CB56846C-4168-4D53-B04F-03B6D6796FF2}']
    function Get_IsPasswordAutosaveEnabled(out value: Integer): HResult; stdcall;
    function Set_IsPasswordAutosaveEnabled(value: Integer): HResult; stdcall;
    function Get_IsGeneralAutofillEnabled(out value: Integer): HResult; stdcall;
    function Set_IsGeneralAutofillEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage pinch zoom.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings5">See the ICoreWebView2Settings5 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings5 = interface(ICoreWebView2Settings4)
    ['{183E7052-1D03-43A0-AB99-98E043B66B39}']
    function Get_IsPinchZoomEnabled(out enabled: Integer): HResult; stdcall;
    function Set_IsPinchZoomEnabled(enabled: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage swipe navigation.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings6">See the ICoreWebView2Settings6 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings6 = interface(ICoreWebView2Settings5)
    ['{11CB3ACD-9BC8-43B8-83BF-F40753714F87}']
    function Get_IsSwipeNavigationEnabled(out enabled: Integer): HResult; stdcall;
    function Set_IsSwipeNavigationEnabled(enabled: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to hide Pdf toolbar items.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings7">See the ICoreWebView2Settings7 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings7 = interface(ICoreWebView2Settings6)
    ['{488DC902-35EF-42D2-BC7D-94B65C4BC49C}']
    function Get_HiddenPdfToolbarItems(out hidden_pdf_toolbar_items: COREWEBVIEW2_PDF_TOOLBAR_ITEMS): HResult; stdcall;
    function Set_HiddenPdfToolbarItems(hidden_pdf_toolbar_items: COREWEBVIEW2_PDF_TOOLBAR_ITEMS): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage smartscreen.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings8">See the ICoreWebView2Settings8 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings8 = interface(ICoreWebView2Settings7)
    ['{9E6B0E8F-86AD-4E81-8147-A9B5EDB68650}']
    function Get_IsReputationCheckingRequired(out value: Integer): HResult; stdcall;
    function Set_IsReputationCheckingRequired(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_18 that manages memory usage
  /// target level.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_19">See the ICoreWebView2_19 article.</see></para>
  /// </remarks>
  ICoreWebView2_19 = interface(ICoreWebView2_18)
    ['{6921F954-79B0-437F-A997-C85811897C68}']
    function Get_MemoryUsageTargetLevel(out level: COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL): HResult; stdcall;
    function Set_MemoryUsageTargetLevel(level: COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL): HResult; stdcall;
  end;

  /// <summary>
  /// Representation of a DOM
  /// [File](https://developer.mozilla.org/en-US/docs/Web/API/File) object
  /// passed via WebMessage. You can use this object to obtain the path of a
  /// File dropped on WebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2file">See the ICoreWebView2File article.</see></para>
  /// </remarks>
  ICoreWebView2File = interface(IUnknown)
    ['{F2C19559-6BC1-4583-A757-90021BE9AFEC}']
    function Get_Path(out Path: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Read-only collection of generic objects.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2objectcollectionview">See the ICoreWebView2ObjectCollectionView article.</see></para>
  /// </remarks>
  ICoreWebView2ObjectCollectionView = interface(IUnknown)
    ['{0F36FD87-4F69-4415-98DA-888F89FB9A33}']
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    function GetValueAtIndex(index: SYSUINT; out value: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Extension of WebMessageReceivedEventArgs to provide access to additional
  /// WebMessage objects.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webmessagereceivedeventargs2">See the ICoreWebView2WebMessageReceivedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2WebMessageReceivedEventArgs2 = interface(ICoreWebView2WebMessageReceivedEventArgs)
    ['{06FC7AB7-C90C-4297-9389-33CA01CF6D5E}']
    function Get_AdditionalObjects(out value: ICoreWebView2ObjectCollectionView): HResult; stdcall;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}  
  System.Win.ComObj;    
  {$ELSE}
  ComObj;
  {$ENDIF}

end.
