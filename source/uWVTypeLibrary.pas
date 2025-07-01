unit uWVTypeLibrary;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON} // If you use Delphi 6 you'll need to download and install the second D6 patch in order for this to compile.
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
  IID_ICoreWebView2Controller: TGUID = '{4D00C0D1-9434-4EB6-8078-8697A560334F}';
  IID_ICoreWebView2ZoomFactorChangedEventHandler: TGUID = '{B52D71D6-C4DF-4543-A90C-64A3E60F38CB}';
  IID_ICoreWebView2MoveFocusRequestedEventHandler: TGUID = '{69035451-6DC7-4CB8-9BCE-B2BD70AD289F}';
  IID_ICoreWebView2MoveFocusRequestedEventArgs: TGUID = '{2D6AA13B-3839-4A15-92FC-D88B3C0D9C9D}';
  IID_ICoreWebView2FocusChangedEventHandler: TGUID = '{05EA24BD-6452-4926-9014-4B82B498135D}';
  IID_ICoreWebView2AcceleratorKeyPressedEventHandler: TGUID = '{B29C7E28-FA79-41A8-8E44-65811C76DCB2}';
  IID_ICoreWebView2AcceleratorKeyPressedEventArgs: TGUID = '{9F760F8A-FB79-42BE-9990-7B56900FA9C7}';
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
  IID_ICoreWebView2_19: TGUID = '{6921F954-79B0-437F-A997-C85811897C68}';
  IID_ICoreWebView2_20: TGUID = '{B4BC1926-7305-11EE-B962-0242AC120002}';
  IID_ICoreWebView2_21: TGUID = '{C4980DEA-587B-43B9-8143-3EF3BF552D95}';
  IID_ICoreWebView2ExecuteScriptWithResultCompletedHandler: TGUID = '{1BB5317B-8238-4C67-A7FF-BAF6558F289D}';
  IID_ICoreWebView2ExecuteScriptResult: TGUID = '{0CE15963-3698-4DF7-9399-71ED6CDD8C9F}';
  IID_ICoreWebView2ScriptException: TGUID = '{054DAE00-84A3-49FF-BC17-4012A90BC9FD}';
  IID_ICoreWebView2_22: TGUID = '{DB75DFC7-A857-4632-A398-6969DDE26C0A}';
  IID_ICoreWebView2_23: TGUID = '{508F0DB5-90C4-5872-90A7-267A91377502}';
  IID_ICoreWebView2ObjectCollectionView: TGUID = '{0F36FD87-4F69-4415-98DA-888F89FB9A33}';
  IID_ICoreWebView2_24: TGUID = '{39A7AD55-4287-5CC1-88A1-C6F458593824}';
  IID_ICoreWebView2NotificationReceivedEventHandler: TGUID = '{89C5D598-8788-423B-BE97-E6E01C0F9EE3}';
  IID_ICoreWebView2NotificationReceivedEventArgs: TGUID = '{1512DD5B-5514-4F85-886E-21C3A4C9CFE6}';
  IID_ICoreWebView2Notification: TGUID = '{B7434D98-6BC8-419D-9DA5-FB5A96D4DACD}';
  IID_ICoreWebView2NotificationCloseRequestedEventHandler: TGUID = '{47C32D23-1E94-4733-85F1-D9BF4ACD0974}';
  IID_ICoreWebView2_25: TGUID = '{B5A86092-DF50-5B4F-A17B-6C8F8B40B771}';
  IID_ICoreWebView2SaveAsUIShowingEventHandler: TGUID = '{6BAA177E-3A2E-5CCF-9A13-FAD676CD0522}';
  IID_ICoreWebView2SaveAsUIShowingEventArgs: TGUID = '{55902952-0E0D-5AAA-A7D0-E833CDB34F62}';
  IID_ICoreWebView2ShowSaveAsUICompletedHandler: TGUID = '{E24B07E3-8169-5C34-994A-7F6478946A3C}';
  IID_ICoreWebView2_26: TGUID = '{806268B8-F897-5685-88E5-C45FCA0B1A48}';
  IID_ICoreWebView2SaveFileSecurityCheckStartingEventHandler: TGUID = '{7899576C-19E3-57C8-B7D1-55808292DE57}';
  IID_ICoreWebView2SaveFileSecurityCheckStartingEventArgs: TGUID = '{CF4FF1D1-5A67-5660-8D63-EF699881EA65}';
  IID_ICoreWebView2_27: TGUID = '{00FBE33B-8C07-517C-AA23-0DDD4B5F6FA0}';
  IID_ICoreWebView2ScreenCaptureStartingEventHandler: TGUID = '{E24FF05A-1DB5-59D9-89F3-3C864268DB4A}';
  IID_ICoreWebView2ScreenCaptureStartingEventArgs: TGUID = '{892C03FD-AEE3-5EBA-A1FA-6FD2F6484B2B}';
  IID_ICoreWebView2FrameInfo: TGUID = '{DA86B8A1-BDF3-4F11-9955-528CEFA59727}';
  IID_ICoreWebView2AcceleratorKeyPressedEventArgs2: TGUID = '{03B2C8C8-7799-4E34-BD66-ED26AA85F2BF}';
  IID_ICoreWebView2BrowserExtension: TGUID = '{7EF7FFA0-FAC5-462C-B189-3D9EDBE575DA}';
  IID_ICoreWebView2BrowserExtensionRemoveCompletedHandler: TGUID = '{8E41909A-9B18-4BB1-8CDF-930F467A50BE}';
  IID_ICoreWebView2BrowserExtensionEnableCompletedHandler: TGUID = '{30C186CE-7FAD-421F-A3BC-A8EAF071DDB8}';
  IID_ICoreWebView2BrowserProcessExitedEventArgs: TGUID = '{1F00663F-AF8C-4782-9CDD-DD01C52E34CB}';
  IID_ICoreWebView2CompositionController: TGUID = '{3DF9B733-B9AE-4A15-86B4-EB9EE9826469}';
  IID_ICoreWebView2PointerInfo: TGUID = '{E6995887-D10D-4F5D-9359-4CE46E4F96B9}';
  IID_ICoreWebView2CursorChangedEventHandler: TGUID = '{9DA43CCC-26E1-4DAD-B56C-D8961C94C571}';
  IID_ICoreWebView2CompositionController2: TGUID = '{0B6A3D24-49CB-4806-BA20-B5E0734A7B26}';
  IID_ICoreWebView2CompositionController3: TGUID = '{9570570E-4D76-4361-9EE1-F04D0DBDFB1E}';
  IID_ICoreWebView2CompositionController4: TGUID = '{7C367B9B-3D2B-450F-9E58-D61A20F486AA}';
  IID_ICoreWebView2RegionRectCollectionView: TGUID = '{333353B8-48BF-4449-8FCC-22697FAF5753}';
  IID_ICoreWebView2NonClientRegionChangedEventHandler: TGUID = '{4A794E66-AA6C-46BD-93A3-382196837680}';
  IID_ICoreWebView2NonClientRegionChangedEventArgs: TGUID = '{AB71D500-0820-4A52-809C-48DB04FF93BF}';
  IID_ICoreWebView2Controller2: TGUID = '{C979903E-D4CA-4228-92EB-47EE3FA96EAB}';
  IID_ICoreWebView2Controller3: TGUID = '{F9614724-5D2B-41DC-AEF7-73D62B51543B}';
  IID_ICoreWebView2RasterizationScaleChangedEventHandler: TGUID = '{9C98C8B1-AC53-427E-A345-3049B5524BBE}';
  IID_ICoreWebView2Controller4: TGUID = '{97D418D5-A426-4E49-A151-E1A10F327D9E}';
  IID_ICoreWebView2ControllerOptions: TGUID = '{12AAE616-8CCB-44EC-BCB3-EB1831881635}';
  IID_ICoreWebView2ControllerOptions2: TGUID = '{06C991D8-9E7E-11ED-A8FC-0242AC120002}';
  IID_ICoreWebView2ControllerOptions3: TGUID = '{B32B191A-8998-57CA-B7CB-E04617E4CE4A}';
  IID_ICoreWebView2ControllerOptions4: TGUID = '{21EB052F-AD39-555E-824A-C87B091D4D36}';
  IID_ICoreWebView2CustomSchemeRegistration: TGUID = '{D60AC92C-37A6-4B26-A39E-95CFE59047BB}';
  IID_ICoreWebView2DevToolsProtocolEventReceivedEventArgs2: TGUID = '{2DC4959D-1494-4393-95BA-BEA4CB9EBD1B}';
  IID_ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler: TGUID = '{4E8A3389-C9D8-4BD2-B6B5-124FEE6CC14D}';
  IID_ICoreWebView2Environment2: TGUID = '{41F3632B-5EF4-404F-AD82-2D606C5A9A21}';
  IID_ICoreWebView2Environment3: TGUID = '{80A22AE3-BE7C-4CE2-AFE1-5A50056CDEEB}';
  IID_ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler: TGUID = '{02FAB84B-1428-4FB7-AD45-1B2E64736184}';
  IID_ICoreWebView2Environment4: TGUID = '{20944379-6DCF-41D6-A0A0-ABC0FC50DE0D}';
  IID_ICoreWebView2Environment5: TGUID = '{319E423D-E0D7-4B8D-9254-AE9475DE9B17}';
  IID_ICoreWebView2BrowserProcessExitedEventHandler: TGUID = '{FA504257-A216-4911-A860-FE8825712861}';
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
  IID_ICoreWebView2Environment13: TGUID = '{AF641F58-72B2-11EE-B962-0242AC120002}';
  IID_ICoreWebView2GetProcessExtendedInfosCompletedHandler: TGUID = '{F45E55AA-3BC2-11EE-BE56-0242AC120002}';
  IID_ICoreWebView2ProcessExtendedInfoCollection: TGUID = '{32EFA696-407A-11EE-BE56-0242AC120002}';
  IID_ICoreWebView2ProcessExtendedInfo: TGUID = '{AF4C4C2E-45DB-11EE-BE56-0242AC120002}';
  IID_ICoreWebView2FrameInfoCollection: TGUID = '{8F834154-D38E-4D90-AFFB-6800A7272839}';
  IID_ICoreWebView2FrameInfoCollectionIterator: TGUID = '{1BF89E2D-1B2B-4629-B28F-05099B41BB03}';
  IID_ICoreWebView2Environment14: TGUID = '{A5E9FAD9-C875-59DA-9BD7-473AA5CA1CEF}';
  IID_ICoreWebView2FileSystemHandle: TGUID = '{C65100AC-0DE2-5551-A362-23D9BD1D0E1F}';
  IID_ICoreWebView2ObjectCollection: TGUID = '{5CFEC11C-25BD-4E8D-9E1A-7ACDAEEEC047}';
  IID_ICoreWebView2EnvironmentOptions: TGUID = '{2FDE08A8-1E9A-4766-8C05-95A9CEB9D1C5}';
  IID_ICoreWebView2EnvironmentOptions2: TGUID = '{FF85C98A-1BA7-4A6B-90C8-2B752C89E9E2}';
  IID_ICoreWebView2EnvironmentOptions3: TGUID = '{4A5C436E-A9E3-4A2E-89C3-910D3513F5CC}';
  IID_ICoreWebView2EnvironmentOptions4: TGUID = '{AC52D13F-0D38-475A-9DCA-876580D6793E}';
  IID_ICoreWebView2EnvironmentOptions5: TGUID = '{0AE35D64-C47F-4464-814E-259C345D1501}';
  IID_ICoreWebView2EnvironmentOptions6: TGUID = '{57D29CC3-C84F-42A0-B0E2-EFFBD5E179DE}';
  IID_ICoreWebView2EnvironmentOptions7: TGUID = '{C48D539F-E39F-441C-AE68-1F66E570BDC5}';
  IID_ICoreWebView2EnvironmentOptions8: TGUID = '{7C7ECF51-E918-5CAF-853C-E9A2BCC27775}';
  IID_ICoreWebView2File: TGUID = '{F2C19559-6BC1-4583-A757-90021BE9AFEC}';
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
  IID_ICoreWebView2Frame5: TGUID = '{99D199C4-7305-11EE-B962-0242AC120002}';
  IID_ICoreWebView2Frame6: TGUID = '{0DE611FD-31E9-5DDC-9D71-95EDA26EFF32}';
  IID_ICoreWebView2FrameScreenCaptureStartingEventHandler: TGUID = '{A6C1D8AD-BB80-59C5-895B-FBA1698B9309}';
  IID_ICoreWebView2Frame7: TGUID = '{3598CFA2-D85D-5A9F-9228-4DDE1F59EC64}';
  IID_ICoreWebView2FrameChildFrameCreatedEventHandler: TGUID = '{569E40E7-46B7-563D-83AE-1073155664D7}';
  IID_ICoreWebView2FrameInfo2: TGUID = '{56F85CFA-72C4-11EE-B962-0242AC120002}';
  IID_ICoreWebView2NavigationCompletedEventArgs2: TGUID = '{FDF8B738-EE1E-4DB2-A329-8D7D7B74D792}';
  IID_ICoreWebView2NavigationStartingEventArgs2: TGUID = '{9086BE93-91AA-472D-A7E0-579F2BA006AD}';
  IID_ICoreWebView2NavigationStartingEventArgs3: TGUID = '{DDFFE494-4942-4BD2-AB73-35B8FF40E19F}';
  IID_ICoreWebView2NewWindowRequestedEventArgs2: TGUID = '{BBC7BAED-74C6-4C92-B63A-7F5AEAE03DE3}';
  IID_ICoreWebView2NewWindowRequestedEventArgs3: TGUID = '{842BED3C-6AD6-4DD9-B938-28C96667AD66}';
  IID_ICoreWebView2PermissionRequestedEventArgs3: TGUID = '{E61670BC-3DCE-4177-86D2-C629AE3CB6AC}';
  IID_ICoreWebView2PermissionSetting: TGUID = '{792B6ECA-5576-421C-9119-74EBB3A4FFB3}';
  IID_ICoreWebView2PrintSettings2: TGUID = '{CA7F0E1F-3484-41D1-8C1A-65CD44A63F8D}';
  IID_ICoreWebView2ProcessFailedEventArgs2: TGUID = '{4DAB9422-46FA-4C3E-A5D2-41D2071D3680}';
  IID_ICoreWebView2ProcessFailedEventArgs3: TGUID = '{AB667428-094D-5FD1-B480-8B4C0FDBDF2F}';
  IID_ICoreWebView2Profile2: TGUID = '{FA740D4B-5EAE-4344-A8AD-74BE31925397}';
  IID_ICoreWebView2ClearBrowsingDataCompletedHandler: TGUID = '{E9710A06-1D1D-49B2-8234-226F35846AE5}';
  IID_ICoreWebView2Profile3: TGUID = '{B188E659-5685-4E05-BDBA-FC640E0F1992}';
  IID_ICoreWebView2Profile4: TGUID = '{8F4AE680-192E-4EC8-833A-21CFADAEF628}';
  IID_ICoreWebView2SetPermissionStateCompletedHandler: TGUID = '{FC77FB30-9C9E-4076-B8C7-7644A703CA1B}';
  IID_ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler: TGUID = '{38274481-A15C-4563-94CF-990EDC9AEB95}';
  IID_ICoreWebView2PermissionSettingCollectionView: TGUID = '{F5596F62-3DE5-47B1-91E8-A4104B596B96}';
  IID_ICoreWebView2Profile5: TGUID = '{2EE5B76E-6E80-4DF2-BCD3-D4EC3340A01B}';
  IID_ICoreWebView2Profile6: TGUID = '{BD82FA6A-1D65-4C33-B2B4-0393020CC61B}';
  IID_ICoreWebView2Profile7: TGUID = '{7B4C7906-A1AA-4CB4-B723-DB09F813D541}';
  IID_ICoreWebView2ProfileAddBrowserExtensionCompletedHandler: TGUID = '{DF1AAB27-82B9-4AB6-AAE8-017A49398C14}';
  IID_ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler: TGUID = '{FCE16A1C-F107-4601-8B75-FC4940AE25D0}';
  IID_ICoreWebView2BrowserExtensionList: TGUID = '{2EF3D2DC-BD5F-4F4D-90AF-FD67798F0C2F}';
  IID_ICoreWebView2Profile8: TGUID = '{FBF70C2F-EB1F-4383-85A0-163E92044011}';
  IID_ICoreWebView2ProfileDeletedEventHandler: TGUID = '{DF35055D-772E-4DBE-B743-5FBF74A2B258}';
  IID_ICoreWebView2Settings2: TGUID = '{EE9A0F68-F46C-4E32-AC23-EF8CAC224D2A}';
  IID_ICoreWebView2Settings3: TGUID = '{FDB5AB74-AF33-4854-84F0-0A631DEB5EBA}';
  IID_ICoreWebView2Settings4: TGUID = '{CB56846C-4168-4D53-B04F-03B6D6796FF2}';
  IID_ICoreWebView2Settings5: TGUID = '{183E7052-1D03-43A0-AB99-98E043B66B39}';
  IID_ICoreWebView2Settings6: TGUID = '{11CB3ACD-9BC8-43B8-83BF-F40753714F87}';
  IID_ICoreWebView2Settings7: TGUID = '{488DC902-35EF-42D2-BC7D-94B65C4BC49C}';
  IID_ICoreWebView2Settings8: TGUID = '{9E6B0E8F-86AD-4E81-8147-A9B5EDB68650}';
  IID_ICoreWebView2Settings9: TGUID = '{0528A73B-E92D-49F4-927A-E547DDDAA37D}';
  IID_ICoreWebView2WebMessageReceivedEventArgs2: TGUID = '{06FC7AB7-C90C-4297-9389-33CA01CF6D5E}';
  IID_ICoreWebView2WebResourceRequestedEventArgs2: TGUID = '{9C562C24-B219-4D7F-92F6-B187FBBADD56}';

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
  /// 1) when the app cancels a navigation via NavigationStarting event.
  /// 2) For original navigation if the app navigates the WebView2 in a rapid succession
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
  /// Permission is requested when developers use the [File System Access API](https://developer.mozilla.org/docs/Web/API/File_System_Access_API)
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
  /// [Autoplay guide for media and Web Audio APIs](https://developer.mozilla.org/docs/Web/Media/Autoplay_guide) for details.
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
  /// when developers use the [Web MIDI API](https://developer.mozilla.org/docs/Web/API/Web_MIDI_API)
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
  /// `ICoreWebView2ProcessFailedEventArgs` interface. The values in this enum
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
  /// Indicates that the main frame's render process ended unexpectedly. Any
  /// subframes in the WebView will be gone too.  A new render process is
  /// created automatically and navigated to an error page. You can use the
  /// `Reload` method to try to recover from this failure. Alternatively, you
  /// can `Close` and recreate the WebView.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_EXITED = $00000001;
  /// <summary>
  /// <para>Indicates that the main frame's render process is unresponsive. Renderer
  /// process unresponsiveness can happen for the following reasons:</para>
  /// <para>There is a **long-running script** being executed. For example, the
  /// web content in your WebView might be performing a synchronous XHR, or have
  /// entered an infinite loop. Or, the **system is busy**.</para>
  /// <para>The `ProcessFailed` event will continue to be raised every few seconds
  /// until the renderer process has become responsive again. The application
  /// can consider taking action if the event keeps being raised. For example,
  /// the application might show UI for the user to decide to keep waiting or
  /// reload the page, or navigate away.</para>
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_UNRESPONSIVE = $00000002;
  /// <summary>
  /// Indicates that a frame-only render process ended unexpectedly. The process
  /// exit does not affect the top-level document, only a subset of the
  /// subframes within it. The content in these frames is replaced with an error
  /// page in the frame. Your application can communicate with the main frame to
  /// recover content in the impacted frames, using
  /// `ICoreWebView2ProcessFailedEventArgs2.FrameInfosForFailedProcess` to get
  /// information about the impacted frames.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_FRAME_RENDER_PROCESS_EXITED = $00000003;
  /// <summary>
  /// Indicates that a utility process ended unexpectedly. The failed process
  /// is recreated automatically. Your application does **not** need to handle
  /// recovery for this event, but can use `ICoreWebView2ProcessFailedEventArgs`
  /// and `ICoreWebView2ProcessFailedEventArgs2` to collect information about
  /// the failure, including `ProcessDescription`.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_UTILITY_PROCESS_EXITED = $00000004;
  /// <summary>
  /// Indicates that a sandbox helper process ended unexpectedly. This failure
  /// is not fatal. Your application does **not** need to handle recovery for
  /// this event, but can use `ICoreWebView2ProcessFailedEventArgs` and
  /// `ICoreWebView2ProcessFailedEventArgs2` to collect information about
  /// the failure.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_SANDBOX_HELPER_PROCESS_EXITED = $00000005;
  /// <summary>
  /// Indicates that the GPU process ended unexpectedly. The failed process
  /// is recreated automatically. Your application does **not** need to handle
  /// recovery for this event, but can use `ICoreWebView2ProcessFailedEventArgs`
  /// and `ICoreWebView2ProcessFailedEventArgs2` to collect information about
  /// the failure.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_GPU_PROCESS_EXITED = $00000006;
  /// <summary>
  /// Indicates that a PPAPI plugin process ended unexpectedly. This failure
  /// is not fatal. Your application does **not** need to handle recovery for
  /// this event, but can use `ICoreWebView2ProcessFailedEventArgs` and
  /// `ICoreWebView2ProcessFailedEventArgs2` to collect information about
  /// the failure, including `ProcessDescription`.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_PPAPI_PLUGIN_PROCESS_EXITED = $00000007;
  /// <summary>
  /// Indicates that a PPAPI plugin broker process ended unexpectedly. This failure
  /// is not fatal. Your application does **not** need to handle recovery for
  /// this event, but can use `ICoreWebView2ProcessFailedEventArgs` and
  /// `ICoreWebView2ProcessFailedEventArgs2` to collect information about
  /// the failure.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_KIND_PPAPI_BROKER_PROCESS_EXITED = $00000008;
  /// <summary>
  /// Indicates that a process of unspecified kind ended unexpectedly. Your
  /// application can use `ICoreWebView2ProcessFailedEventArgs` and
  /// `ICoreWebView2ProcessFailedEventArgs2` to collect information about
  /// the failure.
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
  ///
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
  /// ICoreWebView2PrintSettings.
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
  /// Indicates the text direction of the notification.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_text_direction_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_TEXT_DIRECTION_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates that the notification text direction adopts the browser's language setting behavior.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_TEXT_DIRECTION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_TEXT_DIRECTION_KIND_DEFAULT = $00000000;
  /// <summary>
  /// Indicates that the notification text is left-to-right.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_TEXT_DIRECTION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_TEXT_DIRECTION_KIND_LEFT_TO_RIGHT = $00000001;
  /// <summary>
  /// Indicates that the notification text is right-to-left.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_TEXT_DIRECTION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_TEXT_DIRECTION_KIND_RIGHT_TO_LEFT = $00000002;

type
  /// <summary>
  /// Specifies Save As kind selection options for
  /// `ICoreWebView2SaveAsUIShowingEventArgs`.
  ///
  /// For HTML documents, we support 3 Save As kinds: HTML_ONLY, SINGLE_FILE and
  /// COMPLETE. For non-HTML documents, you must use DEFAULT. MIME types of `text/html` and
  /// `application/xhtml+xml` are considered HTML documents.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_save_as_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_KIND = TOleEnum;
const
  /// <summary>
  /// Default kind to save non-HTML content. If this kind is selected for an HTML
  /// page, the behavior is the same as the `HTML_ONLY` kind.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_KIND_DEFAULT = $00000000;
  /// <summary>
  /// Save the page as HTML. Only the top-level document is saved, excluding
  /// subresources.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_KIND_HTML_ONLY = $00000001;
  /// <summary>
  /// Save the page as [MHTML](https://en.wikipedia.org/wiki/MHTML).
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_KIND_SINGLE_FILE = $00000002;
  /// <summary>
  /// Save the page as HTML and download the page-related source files
  /// (for example: CSS, JavaScript, images, etc.) in a directory with
  /// the same filename prefix.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_KIND_COMPLETE = $00000003;

type
  /// <summary>
  /// Status of a programmatic Save As call. Indicates the result
  /// of the `ShowSaveAsUI` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_save_as_ui_result">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_UI_RESULT = TOleEnum;
const
  /// <summary>
  /// The ShowSaveAsUI method call completed successfully. By default, the system
  /// Save As dialog opens. If `SuppressDefaultDialog` is set to TRUE, the system
  /// dialog is skipped.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_UI_RESULT values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_UI_RESULT_SUCCESS = $00000000;
  /// <summary>
  /// Could not perform Save As because the destination file path is an invalid path.
  ///
  /// The path is invalid when it is empty, a relative path, or a directory,
  /// or when the parent path does not exist.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_UI_RESULT values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_UI_RESULT_INVALID_PATH = $00000001;
  /// <summary>
  /// Could not perform Save As because the destination file path already exists and
  /// replacing files was not allowed by the `AllowReplace` property.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_UI_RESULT values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_UI_RESULT_FILE_ALREADY_EXISTS = $00000002;
  /// <summary>
  /// Could not perform Save As because the `Kind` property selection is not
  /// supported due to content MIME type or system limits.
  ///
  /// See the `COREWEBVIEW2_SAVE_AS_KIND` enum for MIME type limits.
  ///
  /// System limits include when the `HTML_ONLY` kind is selected for an error page
  /// at child mode, or when the `COMPLETE` kind is selected and the WebView is
  /// running in an App Container.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_UI_RESULT values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_UI_RESULT_KIND_NOT_SUPPORTED = $00000003;
  /// <summary>
  /// Did not perform Save As because the end user cancelled or the
  /// `Cancel` property on `ICoreWebView2SaveAsUIShowingEventArgs` was set to TRUE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SAVE_AS_UI_RESULT values.</para>
  /// </remarks>
  COREWEBVIEW2_SAVE_AS_UI_RESULT_CANCELLED = $00000004;

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
  COREWEBVIEW2_MOUSE_EVENT_KIND_HORIZONTAL_WHEEL = 526;
  /// <summary>
  /// Left button double click mouse event, WM_LBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEFT_BUTTON_DOUBLE_CLICK = 515;
  /// <summary>
  /// Left button down mouse event, WM_LBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEFT_BUTTON_DOWN = 513;
  /// <summary>
  /// Left button up mouse event, WM_LBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEFT_BUTTON_UP = 514;
  /// <summary>
  /// Mouse leave event, WM_MOUSELEAVE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE = 675;
  /// <summary>
  /// Middle button double click mouse event, WM_MBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MIDDLE_BUTTON_DOUBLE_CLICK = 521;
  /// <summary>
  /// Middle button down mouse event, WM_MBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MIDDLE_BUTTON_DOWN = 519;
  /// <summary>
  /// Middle button up mouse event, WM_MBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MIDDLE_BUTTON_UP = 520;
  /// <summary>
  /// Mouse move event, WM_MOUSEMOVE.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_MOVE = 512;
  /// <summary>
  /// Right button double click mouse event, WM_RBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_RIGHT_BUTTON_DOUBLE_CLICK = 518;
  /// <summary>
  /// Right button down mouse event, WM_RBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_RIGHT_BUTTON_DOWN = 516;
  /// <summary>
  /// Right button up mouse event, WM_RBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_RIGHT_BUTTON_UP = 517;
  /// <summary>
  /// Mouse wheel scroll event, WM_MOUSEWHEEL.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_WHEEL = 522;
  /// <summary>
  /// First or second X button double click mouse event, WM_XBUTTONDBLCLK.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOUBLE_CLICK = 525;
  /// <summary>
  /// First or second X button down mouse event, WM_XBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOWN = 523;
  /// <summary>
  /// First or second X button up mouse event, WM_XBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_UP = 524;
  /// <summary>
  /// Mouse Right Button Down event over a nonclient area, WM_NCRBUTTONDOWN.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_NON_CLIENT_RIGHT_BUTTON_DOWN = 164;
  /// <summary>
  /// Mouse Right Button up event over a nonclient area, WM_NCRBUTTONUP.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_MOUSE_EVENT_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_MOUSE_EVENT_KIND_NON_CLIENT_RIGHT_BUTTON_UP = 165;

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
  /// Allowed permissions of a CoreWebView2FileSystemHandle as described in
  /// [FileSystemHandle.requestPermission()](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/requestPermission)
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_file_system_handle_permission">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION = TOleEnum;
const
  /// <summary>
  /// Read-only permission for FileSystemHandle.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION values.</para>
  /// </remarks>
  COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION_READ_ONLY = $00000000;
  /// <summary>
  /// Read and write permissions for FileSystemHandle.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION values.</para>
  /// </remarks>
  COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION_READ_WRITE = $00000001;

type
  /// <summary>
  /// Kind of CoreWebView2FileSystemHandle as described in
  /// [FileSystemHandle.kind](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/kind)
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_file_system_handle_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND = TOleEnum;
const
  /// <summary>
  /// FileSystemHandle is for a file
  /// (i.e. [FileSystemFileHandle](https://developer.mozilla.org/docs/Web/API/FileSystemFileHandle))
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND_FILE = $00000000;
  /// <summary>
  /// FileSystemHandle is for a directory
  /// (i.e. [FileSystemDirectoryHandle](https://developer.mozilla.org/docs/Web/API/FileSystemDirectoryHandle))
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND_DIRECTORY = $00000001;

type
  /// <summary>
  /// The channel search kind determines the order that release channels are
  /// searched for during environment creation. The default behavior is to search
  /// for and use the most stable channel found on the device. The order from most
  /// to least stable is: WebView2 Runtime -> Beta -> Dev -> Canary. Switch the
  /// order to prefer the least stable channel in order to perform pre-release
  /// testing. See `COREWEBVIEW2_RELEASE_CHANNELS` for descriptions of channels.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_channel_search_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_CHANNEL_SEARCH_KIND = TOleEnum;
const
  /// <summary>
  /// Search for a release channel from most to least stable:
  /// WebView2 Runtime -> Beta -> Dev -> Canary. This is the default behavior.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CHANNEL_SEARCH_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CHANNEL_SEARCH_KIND_MOST_STABLE = $00000000;
  /// <summary>
  /// Search for a release channel from least to most stable:
  /// Canary -> Dev -> Beta -> WebView2 Runtime.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_CHANNEL_SEARCH_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE = $00000001;

type
  /// <summary>
  /// <para>The WebView2 release channels. Use `ReleaseChannels` and `ChannelSearchKind`
  /// on `ICoreWebView2EnvironmentOptions` to control which channel is searched
  /// for during environment creation.</para>
  /// <code>
  /// |Channel|Primary purpose|How often updated with new features|
  /// |:---:|---|:---:|
  /// |Stable (WebView2 Runtime)|Broad Deployment|Monthly|
  /// |Beta|Flighting with inner rings, automated testing|Monthly|
  /// |Dev|Automated testing, selfhosting to test new APIs and features|Weekly|
  /// |Canary|Automated testing, selfhosting to test new APIs and features|Daily|
  /// </code>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_release_channels">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_RELEASE_CHANNELS = TOleEnum;
const
  /// <summary>
  /// No release channel. Passing only this value to `ReleaseChannels` results
  /// in HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND).
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_RELEASE_CHANNELS values.</para>
  /// </remarks>
  COREWEBVIEW2_RELEASE_CHANNELS_NONE = $00000000;
  /// <summary>
  /// The stable WebView2 Runtime that is released every 4 weeks.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_RELEASE_CHANNELS values.</para>
  /// </remarks>
  COREWEBVIEW2_RELEASE_CHANNELS_STABLE = $00000001;
  /// <summary>
  /// The Beta release channel that is released every 4 weeks, a week before the
  /// stable release.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_RELEASE_CHANNELS values.</para>
  /// </remarks>
  COREWEBVIEW2_RELEASE_CHANNELS_BETA = $00000002;
  /// <summary>
  /// The Dev release channel that is released weekly.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_RELEASE_CHANNELS values.</para>
  /// </remarks>
  COREWEBVIEW2_RELEASE_CHANNELS_DEV = $00000004;
  /// <summary>
  /// The Canary release channel that is released daily.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_RELEASE_CHANNELS values.</para>
  /// </remarks>
  COREWEBVIEW2_RELEASE_CHANNELS_CANARY = $00000008;

type
  /// <summary>
  /// Set ScrollBar style on `ICoreWebView2EnvironmentOptions` during environment creation.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_scrollbar_style">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_SCROLLBAR_STYLE = TOleEnum;
const
  /// <summary>
  /// Browser default ScrollBar style.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SCROLLBAR_STYLE values.</para>
  /// </remarks>
  COREWEBVIEW2_SCROLLBAR_STYLE_DEFAULT = $00000000;
  /// <summary>
  /// <para>Window style fluent overlay scroll bar.</para>
  /// <para>Please see [Fluent UI](https://developer.microsoft.com/fluentui#/)
  /// for more details on fluent UI.</para>
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_SCROLLBAR_STYLE values.</para>
  /// </remarks>
  COREWEBVIEW2_SCROLLBAR_STYLE_FLUENT_OVERLAY = $00000001;

type
  /// <summary>
  /// Indicates the frame type used in the `ICoreWebView2FrameInfo` interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_frame_kind">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_FRAME_KIND = TOleEnum;
const
  /// <summary>
  /// Indicates that the frame is an unknown type frame. We may extend this enum
  /// type to identify more frame kinds in the future.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FRAME_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_FRAME_KIND_UNKNOWN = $00000000;
  /// <summary>
  /// Indicates that the frame is a primary main frame(webview).
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FRAME_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_FRAME_KIND_MAIN_FRAME = $00000001;
  /// <summary>
  /// Indicates that the frame is an iframe.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FRAME_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_FRAME_KIND_IFRAME = $00000002;
  /// <summary>
  /// Indicates that the frame is an embed element.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FRAME_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_FRAME_KIND_EMBED = $00000003;
  /// <summary>
  /// Indicates that the frame is an object element.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_FRAME_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_FRAME_KIND_OBJECT = $00000004;


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
  /// The process crashed. Most crashes will generate dumps in the location
  /// indicated by `ICoreWebView2Environment11.get_FailureReportFolderPath`.
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
  /// The process terminated due to running out of memory.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_PROCESS_FAILED_REASON values.</para>
  /// </remarks>
  COREWEBVIEW2_PROCESS_FAILED_REASON_OUT_OF_MEMORY = $00000005;
  /// <summary>
  /// Deprecated. This value is unused.
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
  COREWEBVIEW2_BROWSING_DATA_KINDS_FILE_SYSTEMS = $0001;
  /// <summary>
  /// Specifies data stored by the IndexedDB DOM feature.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_INDEXED_DB = $0002;
  /// <summary>
  /// Specifies data stored by the localStorage DOM API.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_LOCAL_STORAGE = $0004;
  /// <summary>
  /// Specifies data stored by the Web SQL database DOM API.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_WEB_SQL = $0008;
  /// <summary>
  /// Specifies data stored by the CacheStorage DOM API.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_CACHE_STORAGE = $0010;
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
  COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_DOM_STORAGE = $0020;
  /// <summary>
  /// Specifies HTTP cookies data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_COOKIES = $0040;
  /// <summary>
  /// Specifies all site data, now and future. This browsing data kind
  /// is inclusive of COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_DOM_STORAGE and
  /// COREWEBVIEW2_BROWSING_DATA_KINDS_COOKIES. New site data types
  /// may be added to this data kind in the future.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_SITE = $0080;
  /// <summary>
  /// Specifies disk cache.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_DISK_CACHE = $0100;
  /// <summary>
  /// Specifies download history data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_DOWNLOAD_HISTORY = $0200;
  /// <summary>
  /// Specifies general autofill form data.
  /// This excludes password information and includes information like:
  /// names, street and email addresses, phone numbers, and arbitrary input.
  /// This also includes payment data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_GENERAL_AUTOFILL = $0400;
  /// <summary>
  /// Specifies password autosave data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_PASSWORD_AUTOSAVE = $0800;
  /// <summary>
  /// Specifies browsing history data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_BROWSING_HISTORY = $1000;
  /// <summary>
  /// Specifies settings data.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_SETTINGS = $2000;
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
  COREWEBVIEW2_BROWSING_DATA_KINDS_ALL_PROFILE = $4000;
  /// <summary>
  /// Specifies service workers registered for an origin, and clear will result in
  /// termination and deregistration of them.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_BROWSING_DATA_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_BROWSING_DATA_KINDS_SERVICE_WORKERS = $8000;

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

  /// <summary>
  /// This enum contains values representing possible regions a given
  /// point lies within. The values of this enum align with the
  /// matching WM_NCHITTEST* window message return values.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_non_client_region_kind">See the Globals article.</see></para>
  /// </remarks>
type
  COREWEBVIEW2_NON_CLIENT_REGION_KIND = TOleEnum;
const
  /// <summary>
  /// A hit test region out of bounds of the WebView2.
  /// This has the same value as the Win32 HTNOWHERE
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NON_CLIENT_REGION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NON_CLIENT_REGION_KIND_NOWHERE = $00000000;
  /// <summary>
  /// A hit test region in the WebView2 which does not have the CSS style
  /// `-webkit-app-region: drag` set. This is normal web content that should not be
  /// considered part of the app window's title bar. This has the same value
  /// as the Win32 HTCLIENT constant.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NON_CLIENT_REGION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NON_CLIENT_REGION_KIND_CLIENT = $00000001;
  /// <summary>
  /// A hit test region in the WebView2 which has the CSS style
  /// `-webkit-app-region: drag` set. Web content should use this CSS
  /// style to identify regions that should be treated like the app
  /// window's title bar. This has the same value as the Win32 HTCAPTION
  /// constant.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NON_CLIENT_REGION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NON_CLIENT_REGION_KIND_CAPTION = $00000002;
  /// <summary>
  /// A hit test region in the Webview2 which corresponds to the minimize
  /// window control button.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NON_CLIENT_REGION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NON_CLIENT_REGION_KIND_MINIMIZE = $00000008;
  /// <summary>
  /// A hit test region in the Webview2 which corresponds to the maximize
  /// window control button.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NON_CLIENT_REGION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NON_CLIENT_REGION_KIND_MAXIMIZE = $00000009;
  /// <summary>
  /// A hit test region in the Webview2 which corresponds to the close
  /// window control button.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_NON_CLIENT_REGION_KIND values.</para>
  /// </remarks>
  COREWEBVIEW2_NON_CLIENT_REGION_KIND_CLOSE = $00000014;

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
  /// <summary>
  /// Specifies the source of `WebResourceRequested` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_web_resource_request_source_kinds">See the Globals article.</see></para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS = TOleEnum;
const
  /// <summary>
  /// Indicates that no web resource is requested.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_NONE = $00000000;
  /// <summary>
  /// Indicates that web resource is requested from main page including dedicated workers and iframes.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_DOCUMENT = $00000001;
  /// <summary>
  /// Indicates that web resource is requested from shared worker.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SHARED_WORKER = $00000002;
  /// <summary>
  /// Indicates that web resource is requested from service worker.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SERVICE_WORKER = $00000004;
  /// <summary>
  /// Indicates that web resource is requested from any supported source.
  /// </summary>
  /// <remarks>
  /// <para>This is one of the COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS values.</para>
  /// </remarks>
  COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_ALL = $FFFFFFFF;


type
{*
 *********************************************************************
 Forward declaration of types defined in TypeLibrary
 *********************************************************************
*}
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
  ICoreWebView2Controller = interface;
  ICoreWebView2ZoomFactorChangedEventHandler = interface;
  ICoreWebView2MoveFocusRequestedEventHandler = interface;
  ICoreWebView2MoveFocusRequestedEventArgs = interface;
  ICoreWebView2FocusChangedEventHandler = interface;
  ICoreWebView2AcceleratorKeyPressedEventHandler = interface;
  ICoreWebView2AcceleratorKeyPressedEventArgs = interface;
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
  ICoreWebView2_19 = interface;
  ICoreWebView2_20 = interface;
  ICoreWebView2_21 = interface;
  ICoreWebView2ExecuteScriptWithResultCompletedHandler = interface;
  ICoreWebView2ExecuteScriptResult = interface;
  ICoreWebView2ScriptException = interface;
  ICoreWebView2_22 = interface;
  ICoreWebView2_23 = interface;
  ICoreWebView2ObjectCollectionView = interface;
  ICoreWebView2_24 = interface;
  ICoreWebView2NotificationReceivedEventHandler = interface;
  ICoreWebView2NotificationReceivedEventArgs = interface;
  ICoreWebView2Notification = interface;
  ICoreWebView2NotificationCloseRequestedEventHandler = interface;
  ICoreWebView2_25 = interface;
  ICoreWebView2SaveAsUIShowingEventHandler = interface;
  ICoreWebView2SaveAsUIShowingEventArgs = interface;
  ICoreWebView2ShowSaveAsUICompletedHandler = interface;
  ICoreWebView2_26 = interface;
  ICoreWebView2SaveFileSecurityCheckStartingEventHandler = interface;
  ICoreWebView2SaveFileSecurityCheckStartingEventArgs = interface;
  ICoreWebView2_27 = interface;
  ICoreWebView2ScreenCaptureStartingEventHandler = interface;
  ICoreWebView2ScreenCaptureStartingEventArgs = interface;
  ICoreWebView2FrameInfo = interface;
  ICoreWebView2AcceleratorKeyPressedEventArgs2 = interface;
  ICoreWebView2BrowserExtension = interface;
  ICoreWebView2BrowserExtensionRemoveCompletedHandler = interface;
  ICoreWebView2BrowserExtensionEnableCompletedHandler = interface;
  ICoreWebView2BrowserProcessExitedEventArgs = interface;
  ICoreWebView2CompositionController = interface;
  ICoreWebView2PointerInfo = interface;
  ICoreWebView2CursorChangedEventHandler = interface;
  ICoreWebView2CompositionController2 = interface;
  ICoreWebView2CompositionController3 = interface;
  ICoreWebView2CompositionController4 = interface;
  ICoreWebView2RegionRectCollectionView = interface;
  ICoreWebView2NonClientRegionChangedEventHandler = interface;
  ICoreWebView2NonClientRegionChangedEventArgs = interface;
  ICoreWebView2Controller2 = interface;
  ICoreWebView2Controller3 = interface;
  ICoreWebView2RasterizationScaleChangedEventHandler = interface;
  ICoreWebView2Controller4 = interface;
  ICoreWebView2ControllerOptions = interface;
  ICoreWebView2ControllerOptions2 = interface;
  ICoreWebView2ControllerOptions3 = interface;
  ICoreWebView2ControllerOptions4 = interface;
  ICoreWebView2CustomSchemeRegistration = interface;
  ICoreWebView2DevToolsProtocolEventReceivedEventArgs2 = interface;
  ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler = interface;
  ICoreWebView2Environment2 = interface;
  ICoreWebView2Environment3 = interface;
  ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler = interface;
  ICoreWebView2Environment4 = interface;
  ICoreWebView2Environment5 = interface;
  ICoreWebView2BrowserProcessExitedEventHandler = interface;
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
  ICoreWebView2Environment13 = interface;
  ICoreWebView2GetProcessExtendedInfosCompletedHandler = interface;
  ICoreWebView2ProcessExtendedInfoCollection = interface;
  ICoreWebView2ProcessExtendedInfo = interface;
  ICoreWebView2FrameInfoCollection = interface;
  ICoreWebView2FrameInfoCollectionIterator = interface;
  ICoreWebView2Environment14 = interface;
  ICoreWebView2FileSystemHandle = interface;
  ICoreWebView2ObjectCollection = interface;
  ICoreWebView2EnvironmentOptions = interface;
  ICoreWebView2EnvironmentOptions2 = interface;
  ICoreWebView2EnvironmentOptions3 = interface;
  ICoreWebView2EnvironmentOptions4 = interface;
  ICoreWebView2EnvironmentOptions5 = interface;
  ICoreWebView2EnvironmentOptions6 = interface;
  ICoreWebView2EnvironmentOptions7 = interface;
  ICoreWebView2EnvironmentOptions8 = interface;
  ICoreWebView2File = interface;
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
  ICoreWebView2Frame5 = interface;
  ICoreWebView2Frame6 = interface;
  ICoreWebView2FrameScreenCaptureStartingEventHandler = interface;
  ICoreWebView2Frame7 = interface;
  ICoreWebView2FrameChildFrameCreatedEventHandler = interface;
  ICoreWebView2FrameInfo2 = interface;
  ICoreWebView2NavigationCompletedEventArgs2 = interface;
  ICoreWebView2NavigationStartingEventArgs2 = interface;
  ICoreWebView2NavigationStartingEventArgs3 = interface;
  ICoreWebView2NewWindowRequestedEventArgs2 = interface;
  ICoreWebView2NewWindowRequestedEventArgs3 = interface;
  ICoreWebView2PermissionRequestedEventArgs3 = interface;
  ICoreWebView2PermissionSetting = interface;
  ICoreWebView2PrintSettings2 = interface;
  ICoreWebView2ProcessFailedEventArgs2 = interface;
  ICoreWebView2ProcessFailedEventArgs3 = interface;
  ICoreWebView2Profile2 = interface;
  ICoreWebView2ClearBrowsingDataCompletedHandler = interface;
  ICoreWebView2Profile3 = interface;
  ICoreWebView2Profile4 = interface;
  ICoreWebView2SetPermissionStateCompletedHandler = interface;
  ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler = interface;
  ICoreWebView2PermissionSettingCollectionView = interface;
  ICoreWebView2Profile5 = interface;
  ICoreWebView2Profile6 = interface;
  ICoreWebView2Profile7 = interface;
  ICoreWebView2ProfileAddBrowserExtensionCompletedHandler = interface;
  ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler = interface;
  ICoreWebView2BrowserExtensionList = interface;
  ICoreWebView2Profile8 = interface;
  ICoreWebView2ProfileDeletedEventHandler = interface;
  ICoreWebView2Settings2 = interface;
  ICoreWebView2Settings3 = interface;
  ICoreWebView2Settings4 = interface;
  ICoreWebView2Settings5 = interface;
  ICoreWebView2Settings6 = interface;
  ICoreWebView2Settings7 = interface;
  ICoreWebView2Settings8 = interface;
  ICoreWebView2Settings9 = interface;
  ICoreWebView2WebMessageReceivedEventArgs2 = interface;
  ICoreWebView2WebResourceRequestedEventArgs2 = interface;

{*
 *********************************************************************
 Declaration of structures, unions and aliases.
 *********************************************************************
*}

  {* Missing NativeUInt declaration ************** WEBVIEW4DELPHI ************** *}
  {$IFNDEF FPC}{$IFNDEF DELPHI15_UP}NativeUInt  = Cardinal;{$ENDIF}{$ENDIF}

  {* Missing HANDLE declaration ************** WEBVIEW4DELPHI ************** *}
  {$IFNDEF FPC}HANDLE = type NativeUInt;{$ENDIF}

  {$IFNDEF FPC}{$IFNDEF DELPHI7_UP}
  uint64     = type int64;
  PPAnsiChar = array of PChar;
  NativeInt  = integer;
  {$ENDIF}{$ENDIF}

  Uint64Array = array of Uint64;

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

  {* tagRect is identical to TRect. ************** WEBVIEW4DELPHI ************** *}
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
    /// <summary>
    /// The key event type that caused the event to run.
    /// </summary>
    function Get_KeyEventKind(out KeyEventKind: COREWEBVIEW2_KEY_EVENT_KIND): HResult; stdcall;
    /// <summary>
    /// The Win32 virtual key code of the key that was pressed or released.  It
    /// is one of the Win32 virtual key constants such as `VK_RETURN` or an
    /// (uppercase) ASCII value such as `A`.  Verify whether Ctrl or Alt
    /// are pressed by running `GetKeyState(VK_CONTROL)` or
    /// `GetKeyState(VK_MENU)`.
    /// </summary>
    function Get_VirtualKey(out VirtualKey: SYSUINT): HResult; stdcall;
    /// <summary>
    /// The `LPARAM` value that accompanied the window message.  For more
    /// information, navigate to [WM_KEYDOWN](/windows/win32/inputdev/wm-keydown)
    /// and [WM_KEYUP](/windows/win32/inputdev/wm-keyup).
    /// </summary>
    function Get_KeyEventLParam(out lParam: SYSINT): HResult; stdcall;
    /// <summary>
    /// A structure representing the information passed in the `LPARAM` of the
    /// window message.
    /// </summary>
    function Get_PhysicalKeyStatus(out PhysicalKeyStatus: COREWEBVIEW2_PHYSICAL_KEY_STATUS): HResult; stdcall;
    /// <summary>
    /// During `AcceleratorKeyPressedEvent` handler invocation the WebView is
    /// blocked waiting for the decision of if the accelerator is handled by the
    /// host (or not).  If the `Handled` property is set to `TRUE` then this
    /// prevents the WebView from performing the default action for this
    /// accelerator key.  Otherwise the WebView performs the default action for
    /// the accelerator key.
    /// </summary>
    function Get_Handled(out Handled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Handled` property.
    /// </summary>
    function Set_Handled(Handled: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This is a continuation of the ICoreWebView2AcceleratorKeyPressedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventargs2">See the ICoreWebView2AcceleratorKeyPressedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2AcceleratorKeyPressedEventArgs2 = interface(ICoreWebView2AcceleratorKeyPressedEventArgs)
    ['{03B2C8C8-7799-4E34-BD66-ED26AA85F2BF}']
    /// <summary>
    /// This property allows developers to enable or disable the browser from handling a specific
    /// browser accelerator key such as Ctrl+P or F3, etc.
    ///
    /// Browser accelerator keys are the keys/key combinations that access features specific to
    /// a web browser, including but not limited to:
    ///  - Ctrl-F and F3 for Find on Page
    ///  - Ctrl-P for Print
    ///  - Ctrl-R and F5 for Reload
    ///  - Ctrl-Plus and Ctrl-Minus for zooming
    ///  - Ctrl-Shift-C and F12 for DevTools
    ///  - Special keys for browser functions, such as Back, Forward, and Search
    ///
    /// This property does not disable accelerator keys related to movement and text editing,
    /// such as:
    ///  - Home, End, Page Up, and Page Down
    ///  - Ctrl-X, Ctrl-C, Ctrl-V
    ///  - Ctrl-A for Select All
    ///  - Ctrl-Z for Undo
    ///
    /// The `CoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` API is a convenient setting
    /// for developers to disable all the browser accelerator keys together, and sets the default
    /// value for the `IsBrowserAcceleratorKeyEnabled` property.
    /// By default, `CoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` is `TRUE` and
    /// `IsBrowserAcceleratorKeyEnabled` is `TRUE`.
    /// When developers change `CoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` setting to `FALSE`,
    /// this will change default value for `IsBrowserAcceleratorKeyEnabled` to `FALSE`.
    /// If developers want specific keys to be handled by the browser after changing the
    /// `CoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` setting to `FALSE`, they need to enable
    /// these keys by setting `IsBrowserAcceleratorKeyEnabled` to `TRUE`.
    /// This API will give the event arg higher priority over the
    /// `CoreWebView2Settings.AreBrowserAcceleratorKeysEnabled` setting when we handle the keys.
    ///
    /// For browser accelerator keys, when an accelerator key is pressed, the propagation and
    /// processing order is:
    /// 1. A CoreWebView2Controller.AcceleratorKeyPressed event is raised
    /// 2. WebView2 browser feature accelerator key handling
    /// 3. Web Content Handling: If the key combination isn't reserved for browser actions,
    /// the key event propagates to the web content, where JavaScript event listeners can
    /// capture and respond to it.
    ///
    /// `ICoreWebView2AcceleratorKeyPressedEventArgs` has a `Handled` property, that developers
    /// can use to mark a key as handled. When the key is marked as handled anywhere along
    /// the path, the event propagation stops, and web content will not receive the key.
    /// With `IsBrowserAcceleratorKeyEnabled` property, if developers mark
    /// `IsBrowserAcceleratorKeyEnabled` as `FALSE`, the browser will skip the WebView2
    /// browser feature accelerator key handling process, but the event propagation
    /// continues, and web content will receive the key combination.
    ///
    /// \snippet ScenarioAcceleratorKeyPressed.cpp IsBrowserAcceleratorKeyEnabled
    /// Gets the `IsBrowserAcceleratorKeyEnabled` property.
    /// </summary>
    function Get_IsBrowserAcceleratorKeyEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsBrowserAcceleratorKeyEnabled` property.
    /// </summary>
    function Set_IsBrowserAcceleratorKeyEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives AcceleratorKeyPressed events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2acceleratorkeypressedeventhandler">See the ICoreWebView2AcceleratorKeyPressedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2AcceleratorKeyPressedEventHandler = interface(IUnknown)
    ['{B29C7E28-FA79-41A8-8E44-65811C76DCB2}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Controller;
                    const args: ICoreWebView2AcceleratorKeyPressedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// The owner of the `CoreWebView2` object that provides support for resizing,
  /// showing and hiding, focusing, and other functionality related to
  /// windowing and composition.  The `CoreWebView2Controller` owns the
  /// `CoreWebView2`, and if all references to the `CoreWebView2Controller` go
  /// away, the WebView is closed.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller">See the ICoreWebView2Controller article.</see></para>
  /// </remarks>
  ICoreWebView2Controller = interface(IUnknown)
    ['{4D00C0D1-9434-4EB6-8078-8697A560334F}']
    /// <summary>
    /// The `IsVisible` property determines whether to show or hide the WebView2.
    ///   If `IsVisible` is set to `FALSE`, the WebView2 is transparent and is
    /// not rendered.   However, this does not affect the window containing the
    /// WebView2 (the `HWND` parameter that was passed to
    /// `CreateCoreWebView2Controller`).  If you want that window to disappear
    /// too, run `ShowWindow` on it directly in addition to modifying the
    /// `IsVisible` property.  WebView2 as a child window does not get window
    /// messages when the top window is minimized or restored.  For performance
    /// reasons, developers should set the `IsVisible` property of the WebView to
    /// `FALSE` when the app window is minimized and back to `TRUE` when the app
    /// window is restored. The app window does this by handling
    /// `SIZE_MINIMIZED and SIZE_RESTORED` command upon receiving `WM_SIZE`
    /// message.
    ///
    /// There are CPU and memory benefits when the page is hidden. For instance,
    /// Chromium has code that throttles activities on the page like animations
    /// and some tasks are run less frequently. Similarly, WebView2 will
    /// purge some caches to reduce memory usage.
    ///
    /// \snippet ViewComponent.cpp ToggleIsVisible
    /// </summary>
    function Get_IsVisible(out IsVisible: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsVisible` property.
    ///
    /// \snippet ViewComponent.cpp ToggleIsVisibleOnMinimize
    /// </summary>
    function Set_IsVisible(IsVisible: Integer): HResult; stdcall;
    /// <summary>
    /// The WebView bounds. Bounds are relative to the parent `HWND`.  The app
    /// has two ways to position a WebView.
    ///
    /// *   Create a child `HWND` that is the WebView parent `HWND`.  Position
    ///     the window where the WebView should be.  Use `(0, 0)` for the
    ///     top-left corner (the offset) of the `Bounds` of the WebView.
    /// *   Use the top-most window of the app as the WebView parent HWND.  For
    ///     example, to position WebView correctly in the app, set the top-left
    ///     corner of the Bound of the WebView.
    ///
    /// The values of `Bounds` are limited by the coordinate space of the host.
    /// </summary>
    function Get_Bounds(out Bounds: tagRECT): HResult; stdcall;
    /// <summary>
    /// Sets the `Bounds` property.
    ///
    /// \snippet ViewComponent.cpp ResizeWebView
    /// </summary>
    function Set_Bounds(Bounds: tagRECT): HResult; stdcall;
    /// <summary>
    /// The zoom factor for the WebView.
    ///
    /// \> [!NOTE]\n\> Changing zoom factor may cause `window.innerWidth`,
    /// `window.innerHeight`, both, and page layout to change.  A zoom factor
    /// that is applied by the host by running `ZoomFactor` becomes the new
    /// default zoom for the WebView.  The zoom factor applies across navigations
    /// and is the zoom factor WebView is returned to when the user chooses
    /// Ctrl+0.  When the zoom factor is changed by the user (resulting in
    /// the app receiving `ZoomFactorChanged`), that zoom applies only for the
    /// current page.  Any user applied zoom is only for the current page and is
    /// reset on a navigation.  Specifying a `zoomFactor` less than or equal to
    /// `0` is not allowed.  WebView also has an internal supported zoom factor
    /// range.  When a specified zoom factor is out of that range, it is
    /// normalized to be within the range, and a `ZoomFactorChanged` event is
    /// triggered for the real applied zoom factor.  When the range normalization
    /// happens, the `ZoomFactor` property reports the zoom factor specified
    /// during the previous modification of the `ZoomFactor` property until the
    /// `ZoomFactorChanged` event is received after WebView applies the
    /// normalized zoom factor.
    /// </summary>
    function Get_ZoomFactor(out ZoomFactor: Double): HResult; stdcall;
    /// <summary>
    /// Sets the `ZoomFactor` property.
    /// </summary>
    function Set_ZoomFactor(ZoomFactor: Double): HResult; stdcall;
    /// <summary>
    /// Adds an event handler for the `ZoomFactorChanged` event.
    /// `ZoomFactorChanged` runs when the `ZoomFactor` property of the WebView
    /// changes.  The event may run because the `ZoomFactor` property was
    /// modified, or due to the user manually modifying the zoom.  When it is
    /// modified using the `ZoomFactor` property, the internal zoom factor is
    /// updated immediately and no `ZoomFactorChanged` event is triggered.
    /// WebView associates the last used zoom factor for each site.  It is
    /// possible for the zoom factor to change when navigating to a different
    /// page.  When the zoom factor changes due to a navigation change, the
    /// `ZoomFactorChanged` event runs right after the `ContentLoading` event.
    ///
    /// \snippet ViewComponent.cpp ZoomFactorChanged
    /// </summary>
    function add_ZoomFactorChanged(const eventHandler: ICoreWebView2ZoomFactorChangedEventHandler; 
                                   out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_ZoomFactorChanged`.
    /// </summary>
    function remove_ZoomFactorChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Updates `Bounds` and `ZoomFactor` properties at the same time.  This
    /// operation is atomic from the perspective of the host.  After returning
    /// from this function, the `Bounds` and `ZoomFactor` properties are both
    /// updated if the function is successful, or neither is updated if the
    /// function fails.  If `Bounds` and `ZoomFactor` are both updated by the
    /// same scale (for example, `Bounds` and `ZoomFactor` are both doubled),
    /// then the page does not display a change in `window.innerWidth` or
    /// `window.innerHeight` and the WebView renders the content at the new size
    /// and zoom without intermediate renderings.  This function also updates
    /// just one of `ZoomFactor` or `Bounds` by passing in the new value for one
    /// and the current value for the other.
    ///
    /// \snippet ViewComponent.cpp SetBoundsAndZoomFactor
    /// </summary>
    function SetBoundsAndZoomFactor(Bounds: tagRECT; ZoomFactor: Double): HResult; stdcall;
    /// <summary>
    /// Moves focus into WebView.  WebView gets focus and focus is set to
    /// correspondent element in the page hosted in the WebView.  For
    /// Programmatic reason, focus is set to previously focused element or the
    /// default element if no previously focused element exists.  For `Next`
    /// reason, focus is set to the first element.  For `Previous` reason, focus
    /// is set to the last element.  WebView changes focus through user
    /// interaction including selecting into a WebView or Tab into it.  For
    /// tabbing, the app runs MoveFocus with Next or Previous to align with Tab
    /// and Shift+Tab respectively when it decides the WebView is the next
    /// element that may exist in a tab.  Or, the app runs `IsDialogMessage`
    /// as part of the associated message loop to allow the platform to auto
    /// handle tabbing.  The platform rotates through all windows with
    /// `WS_TABSTOP`.  When the WebView gets focus from `IsDialogMessage`, it is
    /// internally put the focus on the first or last element for tab and
    /// Shift+Tab respectively.
    ///
    /// \snippet App.cpp MoveFocus0
    ///
    /// \snippet ControlComponent.cpp MoveFocus1
    ///
    /// \snippet ControlComponent.cpp MoveFocus2
    /// </summary>
    function MoveFocus(reason: COREWEBVIEW2_MOVE_FOCUS_REASON): HResult; stdcall;
    /// <summary>
    /// Adds an event handler for the `MoveFocusRequested` event.
    /// `MoveFocusRequested` runs when user tries to tab out of the WebView.  The
    /// focus of the WebView has not changed when this event is run.
    ///
    /// \snippet ControlComponent.cpp MoveFocusRequested
    /// </summary>
    function add_MoveFocusRequested(const eventHandler: ICoreWebView2MoveFocusRequestedEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_MoveFocusRequested`.
    /// </summary>
    function remove_MoveFocusRequested(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Adds an event handler for the `GotFocus` event.  `GotFocus` runs when
    /// WebView has focus.
    /// </summary>
    function add_GotFocus(const eventHandler: ICoreWebView2FocusChangedEventHandler; 
                          out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_GotFocus`.
    /// </summary>
    function remove_GotFocus(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Adds an event handler for the `LostFocus` event.  `LostFocus` runs when
    /// WebView loses focus.  In the case where `MoveFocusRequested` event is
    /// run, the focus is still on WebView when `MoveFocusRequested` event runs.
    /// `LostFocus` only runs afterwards when code of the app or default action
    /// of `MoveFocusRequested` event set focus away from WebView.
    /// </summary>
    function add_LostFocus(const eventHandler: ICoreWebView2FocusChangedEventHandler;
                           out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_LostFocus`.
    /// </summary>
    function remove_LostFocus(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Adds an event handler for the `AcceleratorKeyPressed` event.
    /// `AcceleratorKeyPressed` runs when an accelerator key or key combo is
    /// pressed or released while the WebView is focused.  A key is considered an
    ///  accelerator if either of the following conditions are true.
    ///
    /// *   Ctrl or Alt is currently being held.
    /// *   The pressed key does not map to a character.
    ///
    /// A few specific keys are never considered accelerators, such as Shift.
    /// The `Escape` key is always considered an accelerator.
    ///
    /// Auto-repeated key events caused by holding the key down also triggers
    /// this event.  Filter out the auto-repeated key events by verifying the
    /// `KeyEventLParam` or `PhysicalKeyStatus` event args.
    ///
    /// In windowed mode, the event handler is run synchronously.  Until you
    /// run `Handled()` on the event args or the event handler returns, the
    /// browser process is blocked and outgoing cross-process COM requests fail
    /// with `RPC_E_CANTCALLOUT_ININPUTSYNCCALL`.  All `CoreWebView2` API methods
    /// work, however.
    ///
    /// In windowless mode, the event handler is run asynchronously.  Further
    /// input do not reach the browser until the event handler returns or
    /// `Handled()` is run, but the browser process is not blocked, and outgoing
    /// COM requests work normally.
    ///
    /// It is recommended to run `Handled(TRUE)` as early as are able to know
    /// that you want to handle the accelerator key.
    ///
    /// \snippet ControlComponent.cpp AcceleratorKeyPressed
    /// </summary>
    function add_AcceleratorKeyPressed(const eventHandler: ICoreWebView2AcceleratorKeyPressedEventHandler; 
                                       out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with
    /// `add_AcceleratorKeyPressed`.
    /// </summary>
    function remove_AcceleratorKeyPressed(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// The parent window provided by the app that this WebView is using to
    /// render content.  This API initially returns the window passed into
    /// `CreateCoreWebView2Controller`.
    /// </summary>
    {* ParentWindow: wireHWND --> ParentWindow: HWND    ************** WEBVIEW4DELPHI ************** *}
    function Get_ParentWindow(out ParentWindow: HWND): HResult; stdcall;
    /// <summary>
    /// Sets the parent window for the WebView.  This causes the WebView to
    /// re-parent the main WebView window to the newly provided window.
    /// </summary>
    {* ParentWindow: wireHWND --> ParentWindow: HWND    ************** WEBVIEW4DELPHI ************** *}
    function Set_ParentWindow(ParentWindow: HWND): HResult; stdcall;
    /// <summary>
    /// This is a notification separate from `Bounds` that tells WebView that the
    ///  main WebView parent (or any ancestor) `HWND` moved.  This is needed
    /// for accessibility and certain dialogs in WebView to work correctly.
    ///
    /// \snippet ViewComponent.cpp NotifyParentWindowPositionChanged
    /// </summary>
    function NotifyParentWindowPositionChanged: HResult; stdcall;
    /// <summary>
    /// Closes the WebView and cleans up the underlying browser instance.
    /// Cleaning up the browser instance releases the resources powering the
    /// WebView.  The browser instance is shut down if no other WebViews are
    /// using it.
    ///
    /// After running `Close`, most methods will fail and event handlers stop
    /// running.  Specifically, the WebView releases the associated references to
    /// any associated event handlers when `Close` is run.
    ///
    /// `Close` is implicitly run when the `CoreWebView2Controller` loses the
    /// final reference and is destructed.  But it is best practice to
    /// explicitly run `Close` to avoid any accidental cycle of references
    /// between the WebView and the app code.  Specifically, if you capture a
    /// reference to the WebView in an event handler you create a reference cycle
    /// between the WebView and the event handler.  Run `Close` to break the
    /// cycle by releasing all event handlers.  But to avoid the situation, it is
    /// best to both explicitly run `Close` on the WebView and to not capture a
    /// reference to the WebView to ensure the WebView is cleaned up correctly.
    /// `Close` is synchronous and won't trigger the `beforeunload` event.
    ///
    /// \snippet AppWindow.cpp Close
    /// </summary>
    function Close: HResult; stdcall;
    /// <summary>
    /// Gets the `CoreWebView2` associated with this `CoreWebView2Controller`.
    /// </summary>
    function Get_CoreWebView2(out CoreWebView2: ICoreWebView2): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `ZoomFactorChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2zoomfactorchangedeventhandler">See the ICoreWebView2ZoomFactorChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ZoomFactorChangedEventHandler = interface(IUnknown)
    ['{B52D71D6-C4DF-4543-A90C-64A3E60F38CB}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The reason for WebView to run the `MoveFocusRequested` event.
    /// </summary>
    function Get_reason(out reason: COREWEBVIEW2_MOVE_FOCUS_REASON): HResult; stdcall;
    /// <summary>
    /// Indicates whether the event has been handled by the app.  If the app has
    /// moved the focus to another desired location, it should set the `Handled`
    /// property to `TRUE`.  When the `Handled` property is `FALSE` after the
    /// event handler returns, default action is taken.  The default action is to
    /// try to find the next tab stop child window in the app and try to move
    /// focus to that window.  If no other window exists to move focus, focus is
    /// cycled within the web content of the WebView.
    /// </summary>
    function Get_Handled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Handled` property.
    /// </summary>
    function Set_Handled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `GotFocus` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2focuschangedeventhandler">See the ICoreWebView2FocusChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FocusChangedEventHandler = interface(IUnknown)
    ['{05EA24BD-6452-4926-9014-4B82B498135D}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The `ICoreWebView2Settings` object contains various modifiable settings
    /// for the running WebView.
    /// </summary>
    function Get_Settings(out Settings: ICoreWebView2Settings): HResult; stdcall;
    /// <summary>
    /// The URI of the current top level document.  This value potentially
    /// changes as a part of the `SourceChanged` event that runs for some cases
    /// such as navigating to a different site or fragment navigations.  It
    /// remains the same for other types of navigations such as page refreshes
    /// or `history.pushState` with the same URL as the current page.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    ///
    /// \snippet ControlComponent.cpp SourceChanged
    /// </summary>
    function Get_Source(out uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// Cause a navigation of the top-level document to run to the specified URI.
    /// For more information, navigate to [Navigation
    /// events](/microsoft-edge/webview2/concepts/navigation-events).
    ///
    /// \> [!NOTE]\n\> This operation starts a navigation and the corresponding
    /// `NavigationStarting` event triggers sometime after `Navigate` runs.
    ///
    /// \snippet ControlComponent.cpp Navigate
    /// </summary>
    function Navigate(uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// Initiates a navigation to htmlContent as source HTML of a new document.
    /// The `htmlContent` parameter may not be larger than 2 MB (2 * 1024 * 1024 bytes) in total size.
    /// The origin of the new page is `about:blank`.
    ///
    /// ```cpp
    ///    SetVirtualHostNameToFolderMapping(
    ///        L"appassets.example", L"assets",
    ///        COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_DENY);
    ///
    ///    WCHAR c_navString[] = LR"
    ///    <head><link rel='stylesheet' href ='http://appassets.example/wv2.css'/></head>
    ///    <body>
    ///      <img src='http://appassets.example/wv2.png' />
    ///      <p><a href='http://appassets.example/winrt_test.txt'>Click me</a></p>
    ///    </body>";
    ///    m_webView->NavigateToString(c_navString);
    /// ```
    /// \snippet SettingsComponent.cpp NavigateToString
    /// </summary>
    function NavigateToString(htmlContent: PWideChar): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `NavigationStarting` event.
    /// `NavigationStarting` runs when the WebView main frame is requesting
    /// permission to navigate to a different URI.  Redirects trigger this
    /// operation as well, and the navigation id is the same as the original
    /// one.
    ///
    /// Navigations will be blocked until all `NavigationStarting` event handlers
    /// return.
    ///
    /// \snippet SettingsComponent.cpp NavigationStarting
    /// </summary>
    function add_NavigationStarting(const eventHandler: ICoreWebView2NavigationStartingEventHandler;
                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_NavigationStarting`.
    /// </summary>
    function remove_NavigationStarting(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `ContentLoading` event.  `ContentLoading`
    /// triggers before any content is loaded, including scripts added with
    /// `AddScriptToExecuteOnDocumentCreated`.  `ContentLoading` does not trigger
    /// if a same page navigation occurs (such as through `fragment`
    /// navigations or `history.pushState` navigations).  This operation
    /// follows the `NavigationStarting` and `SourceChanged` events and precedes
    /// the `HistoryChanged` and `NavigationCompleted` events.
    /// </summary>
    function add_ContentLoading(const eventHandler: ICoreWebView2ContentLoadingEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_ContentLoading`.
    /// </summary>
    function remove_ContentLoading(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `SourceChanged` event.  `SourceChanged`
    /// triggers when the `Source` property changes.  `SourceChanged` runs when
    /// navigating to a different site or fragment navigations.  It does not
    /// trigger for other types of navigations such as page refreshes or
    /// `history.pushState` with the same URL as the current page.
    /// `SourceChanged` runs before `ContentLoading` for navigation to a new
    /// document.
    ///
    /// \snippet ControlComponent.cpp SourceChanged
    /// </summary>
    function add_SourceChanged(const eventHandler: ICoreWebView2SourceChangedEventHandler; 
                               out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_SourceChanged`.
    /// </summary>
    function remove_SourceChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `HistoryChanged` event.  `HistoryChanged` is
    /// raised for changes to joint session history, which consists of top-level
    /// and manual frame navigations.  Use `HistoryChanged` to verify that the
    /// `CanGoBack` or `CanGoForward` value has changed.  `HistoryChanged` also
    /// runs for using `GoBack` or `GoForward`.  `HistoryChanged` runs after
    /// `SourceChanged` and `ContentLoading`.  `CanGoBack` is false for
    /// navigations initiated through ICoreWebView2Frame APIs if there has not yet
    /// been a user gesture.
    ///
    /// \snippet ControlComponent.cpp HistoryChanged
    /// </summary>
    function add_HistoryChanged(const eventHandler: ICoreWebView2HistoryChangedEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_HistoryChanged`.
    /// </summary>
    function remove_HistoryChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `NavigationCompleted` event.
    /// `NavigationCompleted` runs when the WebView has completely loaded
    /// (concurrently when `body.onload` runs) or loading stopped with error.
    ///
    /// \snippet ControlComponent.cpp NavigationCompleted
    /// </summary>
    function add_NavigationCompleted(const eventHandler: ICoreWebView2NavigationCompletedEventHandler;
                                     out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_NavigationCompleted`.
    /// </summary>
    function remove_NavigationCompleted(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `FrameNavigationStarting` event.
    /// `FrameNavigationStarting` triggers when a child frame in the WebView
    /// requests permission to navigate to a different URI.  Redirects trigger
    /// this operation as well, and the navigation id is the same as the original
    /// one.
    ///
    /// Navigations will be blocked until all `FrameNavigationStarting` event
    /// handlers return.
    ///
    /// \snippet SettingsComponent.cpp FrameNavigationStarting
    /// </summary>
    function add_FrameNavigationStarting(const eventHandler: ICoreWebView2NavigationStartingEventHandler; 
                                         out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with
    /// `add_FrameNavigationStarting`.
    /// </summary>
    function remove_FrameNavigationStarting(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `FrameNavigationCompleted` event.
    /// `FrameNavigationCompleted` triggers when a child frame has completely
    /// loaded (concurrently when `body.onload` has triggered) or loading stopped with error.
    ///
    /// \snippet ControlComponent.cpp FrameNavigationCompleted
    /// </summary>
    function add_FrameNavigationCompleted(const eventHandler: ICoreWebView2NavigationCompletedEventHandler; 
                                          out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with
    /// `add_FrameNavigationCompleted`.
    /// </summary>
    function remove_FrameNavigationCompleted(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `ScriptDialogOpening` event.
    /// `ScriptDialogOpening` runs when a JavaScript dialog (`alert`, `confirm`,
    /// `prompt`, or `beforeunload`) displays for the webview.  This event only
    /// triggers if the `ICoreWebView2Settings::AreDefaultScriptDialogsEnabled`
    /// property is set to `FALSE`.  The `ScriptDialogOpening` event suppresses
    /// dialogs or replaces default dialogs with custom dialogs.
    ///
    /// If a deferral is not taken on the event args, the subsequent scripts are
    /// blocked until the event handler returns.  If a deferral is taken, the
    /// scripts are blocked until the deferral is completed.
    ///
    /// \snippet SettingsComponent.cpp ScriptDialogOpening
    /// </summary>
    function add_ScriptDialogOpening(const eventHandler: ICoreWebView2ScriptDialogOpeningEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_ScriptDialogOpening`.
    /// </summary>
    function remove_ScriptDialogOpening(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `PermissionRequested` event.
    /// `PermissionRequested` runs when content in a WebView requests permission
    /// to access some privileged resources.
    ///
    /// If a deferral is not taken on the event args, the subsequent scripts are
    /// blocked until the event handler returns.  If a deferral is taken, the
    /// scripts are blocked until the deferral is completed.
    ///
    /// \snippet SettingsComponent.cpp PermissionRequested0
    /// \snippet SettingsComponent.cpp PermissionRequested1
    /// </summary>
    function add_PermissionRequested(const eventHandler: ICoreWebView2PermissionRequestedEventHandler; 
                                     out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_PermissionRequested`.
    /// </summary>
    function remove_PermissionRequested(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `ProcessFailed` event.
    /// `ProcessFailed` runs when any of the processes in the
    /// [WebView2 Process Group](https://learn.microsoft.com/microsoft-edge/webview2/concepts/process-model?tabs=csharp#processes-in-the-webview2-runtime)
    /// encounters one of the following conditions:
    ///
    /// Condition | Details
    /// ---|---
    /// Unexpected exit | The process indicated by the event args has exited unexpectedly (usually due to a crash). The failure might or might not be recoverable and some failures are auto-recoverable.
    /// Unresponsiveness | The process indicated by the event args has become unresponsive to user input. This is only reported for renderer processes, and will run every few seconds until the process becomes responsive again.
    ///
    /// \> [!NOTE]\n\> When the failing process is the browser process, a
    /// `ICoreWebView2Environment5::BrowserProcessExited` event will run too.
    ///
    /// Your application can use `ICoreWebView2ProcessFailedEventArgs` and
    /// `ICoreWebView2ProcessFailedEventArgs2` to identify which condition and
    /// process the event is for, and to collect diagnostics and handle recovery
    /// if necessary. For more details about which cases need to be handled by
    /// your application, see `COREWEBVIEW2_PROCESS_FAILED_KIND`.
    ///
    /// \snippet ProcessComponent.cpp ProcessFailed
    /// </summary>
    function add_ProcessFailed(const eventHandler: ICoreWebView2ProcessFailedEventHandler;
                               out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_ProcessFailed`.
    /// </summary>
    function remove_ProcessFailed(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add the provided JavaScript to a list of scripts that should be run after
    /// the global object has been created, but before the HTML document has
    /// been parsed and before any other script included by the HTML document is
    /// run.  This method injects a script that runs on all top-level document
    /// and child frame page navigations.  This method runs asynchronously, and
    /// you must wait for the completion handler to finish before the injected
    /// script is ready to run.  When this method completes, the `Invoke` method
    /// of the handler is run with the `id` of the injected script.  `id` is a
    /// string.  To remove the injected script, use
    /// `RemoveScriptToExecuteOnDocumentCreated`.
    ///
    /// If the method is run in add_NewWindowRequested handler it should be called
    /// before the new window is set. If called after setting the NewWindow property, the initial script
    /// may or may not apply to the initial navigation and may only apply to the subsequent navigation.
    /// For more details see `ICoreWebView2NewWindowRequestedEventArgs::put_NewWindow`.
    ///
    /// \> [!NOTE]\n\> If an HTML document is running in a sandbox of some kind using
    /// [sandbox](https://developer.mozilla.org/docs/Web/HTML/Element/iframe#attr-sandbox)
    /// properties or the
    /// [Content-Security-Policy](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy)
    /// HTTP header affects the script that runs.  For example, if the
    /// `allow-modals` keyword is not set then requests to run the `alert`
    /// function are ignored.
    ///
    /// \snippet ScriptComponent.cpp AddScriptToExecuteOnDocumentCreated
    /// </summary>
    function AddScriptToExecuteOnDocumentCreated(javaScript: PWideChar; 
                                                 const handler: ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Remove the corresponding JavaScript added using
    /// `AddScriptToExecuteOnDocumentCreated` with the specified script ID. The
    /// script ID should be the one returned by the `AddScriptToExecuteOnDocumentCreated`.
    /// Both use `AddScriptToExecuteOnDocumentCreated` and this method in `NewWindowRequested`
    /// event handler at the same time sometimes causes trouble.  Since invalid scripts will
    /// be ignored, the script IDs you got may not be valid anymore.
    /// </summary>
    function RemoveScriptToExecuteOnDocumentCreated(id: PWideChar): HResult; stdcall;
    /// <summary>
    /// Run JavaScript code from the javascript parameter in the current
    /// top-level document rendered in the WebView.  The result of evaluating
    /// the provided JavaScript is used in this parameter.  The result value is
    /// a JSON encoded string.  If the result is undefined, contains a reference
    /// cycle, or otherwise is not able to be encoded into JSON, then the result
    /// is considered to be null, which is encoded in JSON as the string "null".
    ///
    /// \> [!NOTE]\n\> A function that has no explicit return value returns undefined. If the
    /// script that was run throws an unhandled exception, then the result is
    /// also "null".  This method is applied asynchronously. If the method is
    /// run after the `NavigationStarting` event during a navigation, the script
    /// runs in the new document when loading it, around the time
    /// `ContentLoading` is run.  This operation executes the script even if
    /// `ICoreWebView2Settings::IsScriptEnabled` is set to `FALSE`.
    ///
    /// \snippet ScriptComponent.cpp ExecuteScript
    /// </summary>
    function ExecuteScript(javaScript: PWideChar; 
                           const handler: ICoreWebView2ExecuteScriptCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Capture an image of what WebView is displaying.  Specify the format of
    /// the image with the `imageFormat` parameter.  The resulting image binary
    /// data is written to the provided `imageStream` parameter.  When
    /// `CapturePreview` finishes writing to the stream, the `Invoke` method on
    /// the provided `handler` parameter is run.  This method fails if called
    /// before the first ContentLoading event.  For example if this is called in
    /// the NavigationStarting event for the first navigation it will fail.
    /// For subsequent navigations, the method may not fail, but will not capture
    /// an image of a given webpage until the ContentLoading event has been fired
    /// for it.  Any call to this method prior to that will result in a capture of
    /// the page being navigated away from.
    ///
    /// \snippet FileComponent.cpp CapturePreview
    /// </summary>
    function CapturePreview(imageFormat: COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT; 
                            const imageStream: IStream; 
                            const handler: ICoreWebView2CapturePreviewCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Reload the current page.  This is similar to navigating to the URI of
    /// current top level document including all navigation events firing and
    /// respecting any entries in the HTTP cache.  But, the back or forward
    /// history are not modified.
    /// </summary>
    function Reload: HResult; stdcall;
    /// <summary>
    /// Post the specified webMessage to the top level document in this WebView.
    /// The main page receives the message by subscribing to the `message` event of the
    /// `window.chrome.webview` of the page document.
    ///
    /// ```cpp
    /// window.chrome.webview.addEventListener('message', handler)
    /// window.chrome.webview.removeEventListener('message', handler)
    /// ```
    ///
    /// The event args is an instance of `MessageEvent`.  The
    /// `ICoreWebView2Settings::IsWebMessageEnabled` setting must be `TRUE` or
    /// the web message will not be sent. The `data` property of the event
    /// arg is the `webMessage` string parameter parsed as a JSON string into a
    /// JavaScript object.  The `source` property of the event arg is a reference
    ///  to the `window.chrome.webview` object.  For information about sending
    /// messages from the HTML document in the WebView to the host, navigate to
    /// [add_WebMessageReceived](/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived).
    /// The message is delivered asynchronously.  If a navigation occurs before
    /// the message is posted to the page, the message is discarded.
    ///
    /// \snippet ScenarioWebMessage.cpp WebMessageReceived
    /// </summary>
    function PostWebMessageAsJson(webMessageAsJson: PWideChar): HResult; stdcall;
    /// <summary>
    /// Posts a message that is a simple string rather than a JSON string
    /// representation of a JavaScript object.  This behaves in exactly the same
    /// manner as `PostWebMessageAsJson`, but the `data` property of the event
    /// arg of the `window.chrome.webview` message is a string with the same
    /// value as `webMessageAsString`.  Use this instead of
    /// `PostWebMessageAsJson` if you want to communicate using simple strings
    /// rather than JSON objects.
    /// </summary>
    function PostWebMessageAsString(webMessageAsString: PWideChar): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `WebMessageReceived` event.
    /// `WebMessageReceived` runs when the
    /// `ICoreWebView2Settings::IsWebMessageEnabled` setting is set and the
    /// top-level document of the WebView runs
    /// `window.chrome.webview.postMessage`.  The `postMessage` function is
    /// `void postMessage(object)` where object is any object supported by JSON
    /// conversion.
    ///
    /// \snippet assets\ScenarioWebMessage.html chromeWebView
    ///
    /// When the page calls `postMessage`, the object parameter is converted to a
    /// JSON string and is posted asynchronously to the host process. This will
    /// result in the handler's `Invoke` method being called with the JSON string
    /// as a parameter.
    ///
    /// \snippet ScenarioWebMessage.cpp WebMessageReceived
    ///
    /// If the same page calls `postMessage` multiple times, the corresponding
    /// `WebMessageReceived` events are guaranteed to be fired in the same order.
    /// However, if multiple frames call `postMessage`, there is no guaranteed
    /// order.  In addition, `WebMessageReceived` events caused by calls to
    /// `postMessage` are not guaranteed to be sequenced with events caused by DOM
    /// APIs.  For example, if the page runs
    ///
    /// ```javascript
    /// chrome.webview.postMessage("message");
    /// window.open();
    /// ```
    ///
    /// then the `NewWindowRequested` event might be fired before the
    /// `WebMessageReceived` event.  If you need the `WebMessageReceived` event
    /// to happen before anything else, then in the `WebMessageReceived` handler
    /// you can post a message back to the page and have the page wait until it
    /// receives that message before continuing.
    /// </summary>
    function add_WebMessageReceived(const handler: ICoreWebView2WebMessageReceivedEventHandler;
                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_WebMessageReceived`.
    /// </summary>
    function remove_WebMessageReceived(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Runs an asynchronous `DevToolsProtocol` method.  For more information
    /// about available methods, navigate to
    /// [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot)
    /// .  The `methodName` parameter is the full name of the method in the
    /// `{domain}.{method}` format.  The `parametersAsJson` parameter is a JSON
    /// formatted string containing the parameters for the corresponding method.
    /// The `Invoke` method of the `handler` is run when the method
    /// asynchronously completes.  `Invoke` is run with the return object of the
    /// method as a JSON string.  This function returns E_INVALIDARG if the `methodName` is
    /// unknown or the `parametersAsJson` has an error.  In the case of such an error, the
    /// `returnObjectAsJson` parameter of the handler will include information
    /// about the error.
    /// Note even though WebView2 dispatches the CDP messages in the order called,
    /// CDP method calls may be processed out of order.
    /// If you require CDP methods to run in a particular order, you should wait
    /// for the previous method's completed handler to run before calling the
    /// next method.
    /// If the method is to run in add_NewWindowRequested handler it should be called
    /// before the new window is set if the cdp message should affect the initial navigation. If
    /// called after setting the NewWindow property, the cdp messages
    /// may or may not apply to the initial navigation and may only apply to the subsequent navigation.
    /// For more details see `ICoreWebView2NewWindowRequestedEventArgs::put_NewWindow`.
    ///
    /// \snippet ScriptComponent.cpp CallDevToolsProtocolMethod
    /// </summary>
    function CallDevToolsProtocolMethod(methodName: PWideChar; parametersAsJson: PWideChar; 
                                        const handler: ICoreWebView2CallDevToolsProtocolMethodCompletedHandler): HResult; stdcall;
    /// <summary>
    /// The process ID of the browser process that hosts the WebView.
    /// </summary>
    function Get_BrowserProcessId(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// `TRUE` if the WebView is able to navigate to a previous page in the
    /// navigation history.  If `CanGoBack` changes value, the `HistoryChanged`
    /// event runs.
    /// </summary>
    function Get_CanGoBack(out CanGoBack: Integer): HResult; stdcall;
    /// <summary>
    /// `TRUE` if the WebView is able to navigate to a next page in the
    /// navigation history.  If `CanGoForward` changes value, the
    /// `HistoryChanged` event runs.
    /// </summary>
    function Get_CanGoForward(out CanGoForward: Integer): HResult; stdcall;
    /// <summary>
    /// Navigates the WebView to the previous page in the navigation history.
    /// </summary>
    function GoBack: HResult; stdcall;
    /// <summary>
    /// Navigates the WebView to the next page in the navigation history.
    /// </summary>
    function GoForward: HResult; stdcall;
    /// <summary>
    /// Get a DevTools Protocol event receiver that allows you to subscribe to a
    /// DevTools Protocol event.  The `eventName` parameter is the full name of
    /// the event in the format `{domain}.{event}`.  For more information about
    /// DevTools Protocol events description and event args, navigate to
    /// [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot).
    ///
    /// \snippet ScriptComponent.cpp DevToolsProtocolEventReceived
    /// </summary>
    function GetDevToolsProtocolEventReceiver(eventName: PWideChar; 
                                              out receiver: ICoreWebView2DevToolsProtocolEventReceiver): HResult; stdcall;
    /// <summary>
    /// Stop all navigations and pending resource fetches.  Does not stop scripts.
    /// </summary>
    function Stop: HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `NewWindowRequested` event.
    /// `NewWindowRequested` runs when content inside the WebView requests to
    /// open a new window, such as through `window.open`.  The app can pass a
    /// target WebView that is considered the opened window or mark the event as
    /// `Handled`, in which case WebView2 does not open a window.
    /// If either `Handled` or `NewWindow` properties are not set, the target
    /// content will be opened on a popup window.
    ///
    /// If a deferral is not taken on the event args, scripts that resulted in the
    /// new window that are requested are blocked until the event handler returns.
    /// If a deferral is taken, then scripts are blocked until the deferral is
    /// completed or new window is set.
    ///
    /// For more details and considerations on the target WebView to be supplied
    /// at the opened window, see `ICoreWebView2NewWindowRequestedEventArgs::put_NewWindow`.
    ///
    /// \snippet AppWindow.cpp NewWindowRequested
    /// </summary>
    function add_NewWindowRequested(const eventHandler: ICoreWebView2NewWindowRequestedEventHandler;
                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_NewWindowRequested`.
    /// </summary>
    function remove_NewWindowRequested(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `DocumentTitleChanged` event.
    /// `DocumentTitleChanged` runs when the `DocumentTitle` property of the
    /// WebView changes and may run before or after the `NavigationCompleted`
    /// event.
    ///
    /// \snippet FileComponent.cpp DocumentTitleChanged
    /// </summary>
    function add_DocumentTitleChanged(const eventHandler: ICoreWebView2DocumentTitleChangedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_DocumentTitleChanged`.
    /// </summary>
    function remove_DocumentTitleChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// The title for the current top-level document.  If the document has no
    /// explicit title or is otherwise empty, a default that may or may not match
    ///  the URI of the document is used.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_DocumentTitle(out title: PWideChar): HResult; stdcall;
    /// <summary>
    /// Add the provided host object to script running in the WebView with the
    /// specified name.  Host objects are exposed as host object proxies using
    /// `window.chrome.webview.hostObjects.{name}`.  Host object proxies are
    /// promises and resolves to an object representing the host object.  The
    /// promise is rejected if the app has not added an object with the name.
    /// When JavaScript code access a property or method of the object, a promise
    ///  is return, which resolves to the value returned from the host for the
    /// property or method, or rejected in case of error, for example, no
    /// property or method on the object or parameters are not valid.
    ///
    /// \> [!NOTE]\n\> While simple types, `IDispatch` and array are supported, and
    /// `IUnknown` objects that also implement `IDispatch` are treated as `IDispatch`,
    /// generic `IUnknown`, `VT_DECIMAL`, or `VT_RECORD` variant is not supported.
    /// Remote JavaScript objects like callback functions are represented as an
    /// `VT_DISPATCH` `VARIANT` with the object implementing `IDispatch`.  The
    /// JavaScript callback method may be invoked using `DISPID_VALUE` for the
    /// `DISPID`.  Such callback method invocations will return immediately and will
    /// not wait for the JavaScript function to run and so will not provide the return
    /// value of the JavaScript function.
    /// Nested arrays are supported up to a depth of 3.  Arrays of by
    /// reference types are not supported. `VT_EMPTY` and `VT_NULL` are mapped
    /// into JavaScript as `null`.  In JavaScript, `null` and undefined are
    /// mapped to `VT_EMPTY`.
    ///
    /// Additionally, all host objects are exposed as
    /// `window.chrome.webview.hostObjects.sync.{name}`.  Here the host objects
    /// are exposed as synchronous host object proxies. These are not promises
    /// and function runtimes or property access synchronously block running
    /// script waiting to communicate cross process for the host code to run.
    /// Accordingly the result may have reliability issues and it is recommended
    /// that you use the promise-based asynchronous
    /// `window.chrome.webview.hostObjects.{name}` API.
    ///
    /// Synchronous host object proxies and asynchronous host object proxies may
    /// both use a proxy to the same host object.  Remote changes made by one
    /// proxy propagates to any other proxy of that same host object whether
    /// the other proxies and synchronous or asynchronous.
    ///
    /// While JavaScript is blocked on a synchronous run to native code, that
    /// native code is unable to run back to JavaScript.  Attempts to do so fail
    ///  with `HRESULT_FROM_WIN32(ERROR_POSSIBLE_DEADLOCK)`.
    ///
    /// Host object proxies are JavaScript Proxy objects that intercept all
    /// property get, property set, and method invocations. Properties or methods
    ///  that are a part of the Function or Object prototype are run locally.
    /// Additionally any property or method in the
    /// `chrome.webview.hostObjects.options.forceLocalProperties`
    /// array are also run locally.  This defaults to including optional methods
    /// that have meaning in JavaScript like `toJSON` and `Symbol.toPrimitive`.
    /// Add more to the array as required.
    ///
    /// The `chrome.webview.hostObjects.cleanupSome` method performs a best
    /// effort garbage collection on host object proxies.
    ///
    /// The `chrome.webview.hostObjects.options` object provides the ability to
    /// change some functionality of host objects.
    ///
    /// Options property | Details
    /// ---|---
    /// `forceLocalProperties` | This is an array of host object property names that will be run locally, instead of being called on the native host object. This defaults to `then`, `toJSON`, `Symbol.toString`, and `Symbol.toPrimitive`. You can add other properties to specify that they should be run locally on the javascript host object proxy.
    /// `log` | This is a callback that will be called with debug information. For example, you can set this to `console.log.bind(console)` to have it print debug information to the console to help when troubleshooting host object usage. By default this is null.
    /// `shouldSerializeDates` | By default this is false, and javascript Date objects will be sent to host objects as a string using `JSON.stringify`. You can set this property to true to have Date objects properly serialize as a `VT_DATE` when sending to the native host object, and have `VT_DATE` properties and return values create a javascript Date object.
    /// `defaultSyncProxy` | When calling a method on a synchronous proxy, the result should also be a synchronous proxy. But in some cases, the sync/async context is lost (for example, when providing to native code a reference to a function, and then calling that function in native code). In these cases, the proxy will be asynchronous, unless this property is set.
    /// `forceAsyncMethodMatches ` | This is an array of regular expressions. When calling a method on a synchronous proxy, the method call will be performed asynchronously if the method name matches a string or regular expression in this array. Setting this value to `Async` will make any method that ends with Async be an asynchronous method call. If an async method doesn't match here and isn't forced to be asynchronous, the method will be invoked synchronously, blocking execution of the calling JavaScript and then returning the resolution of the promise, rather than returning a promise.
    /// `ignoreMemberNotFoundError` | By default, an exception is thrown when attempting to get the value of a proxy property that doesn't exist on the corresponding native class. Setting this property to `true` switches the behavior to match Chakra WinRT projection (and general JavaScript) behavior of returning `undefined` with no error.
    /// `shouldPassTypedArraysAsArrays` | By default, typed arrays are passed to the host as `IDispatch`. To instead pass typed arrays to the host as `array`, set this to `true`.
    ///
    /// Host object proxies additionally have the following methods which run
    /// locally.
    ///
    /// Method name | Details
    /// ---|---
    ///`applyHostFunction`, `getHostProperty`, `setHostProperty` | Perform a method invocation, property get, or property set on the host object. Use the methods to explicitly force a method or property to run remotely if a conflicting local method or property exists.  For instance, `proxy.toString()` runs the local `toString` method on the proxy object. But proxy.applyHostFunction('toString') runs `toString` on the host proxied object instead.
    ///`getLocalProperty`, `setLocalProperty` | Perform property get, or property set locally.  Use the methods to force getting or setting a property on the host object proxy rather than on the host object it represents. For instance, `proxy.unknownProperty` gets the property named `unknownProperty` from the host proxied object.  But proxy.getLocalProperty('unknownProperty') gets the value of the property `unknownProperty` on the proxy object.
    ///`sync` | Asynchronous host object proxies expose a sync method which returns a promise for a synchronous host object proxy for the same host object.  For example, `chrome.webview.hostObjects.sample.methodCall()` returns an asynchronous host object proxy.  Use the `sync` method to obtain a synchronous host object proxy instead: `const syncProxy = await chrome.webview.hostObjects.sample.methodCall().sync()`.
    ///`async` | Synchronous host object proxies expose an async method which blocks and returns an asynchronous host object proxy for the same host object.  For example, `chrome.webview.hostObjects.sync.sample.methodCall()` returns a synchronous host object proxy.  Running the `async` method on this blocks and then returns an asynchronous host object proxy for the same host object: `const asyncProxy = chrome.webview.hostObjects.sync.sample.methodCall().async()`.
    ///`then` | Asynchronous host object proxies have a `then` method.  Allows proxies to be awaitable.  `then` returns a promise that resolves with a representation of the host object.  If the proxy represents a JavaScript literal, a copy of that is returned locally.  If the proxy represents a function, a non-awaitable proxy is returned.  If the proxy represents a JavaScript object with a mix of literal properties and function properties, the a copy of the object is returned with some properties as host object proxies.
    ///
    /// All other property and method invocations (other than the above Remote
    /// object proxy methods, `forceLocalProperties` list, and properties on
    /// Function and Object prototypes) are run remotely.  Asynchronous host
    /// object proxies return a promise representing asynchronous completion of
    /// remotely invoking the method, or getting the property.  The promise
    /// resolves after the remote operations complete and the promises resolve to
    ///  the resulting value of the operation.  Synchronous host object proxies
    /// work similarly, but block running JavaScript and wait for the remote
    /// operation to complete.
    ///
    /// Setting a property on an asynchronous host object proxy works slightly
    /// differently.  The set returns immediately and the return value is the
    /// value that is set.  This is a requirement of the JavaScript Proxy object.
    /// If you need to asynchronously wait for the property set to complete, use
    /// the `setHostProperty` method which returns a promise as described above.
    /// Synchronous object property set property synchronously blocks until the
    /// property is set.
    ///
    /// For example, suppose you have a COM object with the following interface.
    ///
    /// \snippet HostObjectSample.idl AddHostObjectInterface
    ///
    /// Add an instance of this interface into your JavaScript with
    /// `AddHostObjectToScript`.  In this case, name it `sample`.
    ///
    /// \snippet ScenarioAddHostObject.cpp AddHostObjectToScript
    ///
    /// In the HTML document, use the COM object using
    /// `chrome.webview.hostObjects.sample`.
    /// Note that `CoreWebView2.AddHostObjectToScript` only applies to the
    /// top-level document and not to frames. To add host objects to frames use
    /// `CoreWebView2Frame.AddHostObjectToScript`.
    ///
    /// \snippet assets\ScenarioAddHostObject.html HostObjectUsage
    ///
    /// Exposing host objects to script has security risk.  For more information
    /// about best practices, navigate to
    /// [Best practices for developing secure WebView2 applications](/microsoft-edge/webview2/concepts/security).
    /// </summary>
    function AddHostObjectToScript(name: PWideChar; const object_: OleVariant): HResult; stdcall;
    /// <summary>
    /// Remove the host object specified by the name so that it is no longer
    /// accessible from JavaScript code in the WebView.  While new access
    /// attempts are denied, if the object is already obtained by JavaScript code
    /// in the WebView, the JavaScript code continues to have access to that
    /// object.   Run this method for a name that is already removed or never
    /// added fails.
    /// </summary>
    function RemoveHostObjectFromScript(name: PWideChar): HResult; stdcall;
    /// <summary>
    /// Opens the DevTools window for the current document in the WebView. Does
    /// nothing if run when the DevTools window is already open.
    /// </summary>
    function OpenDevToolsWindow: HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `ContainsFullScreenElementChanged` event.
    /// `ContainsFullScreenElementChanged` triggers when the
    /// `ContainsFullScreenElement` property changes.  An HTML element inside the
    /// WebView may enter fullscreen to the size of the WebView or leave
    /// fullscreen.  This event is useful when, for example, a video element
    /// requests to go fullscreen.  The listener of
    /// `ContainsFullScreenElementChanged` may resize the WebView in response.
    ///
    /// \snippet AppWindow.cpp ContainsFullScreenElementChanged
    /// </summary>
    function add_ContainsFullScreenElementChanged(const eventHandler: ICoreWebView2ContainsFullScreenElementChangedEventHandler; 
                                                  out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with
    /// `add_ContainsFullScreenElementChanged`.
    /// </summary>
    function remove_ContainsFullScreenElementChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Indicates if the WebView contains a fullscreen HTML element.
    /// </summary>
    function Get_ContainsFullScreenElement(out ContainsFullScreenElement: Integer): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `WebResourceRequested` event.
    /// `WebResourceRequested` runs when the WebView is performing a URL request
    /// to a matching URL and resource context and source kind filter that was
    /// added with `AddWebResourceRequestedFilterWithRequestSourceKinds`.
    /// At least one filter must be added for the event to run.
    ///
    /// The web resource requested may be blocked until the event handler returns
    /// if a deferral is not taken on the event args.  If a deferral is taken,
    /// then the web resource requested is blocked until the deferral is
    /// completed.
    ///
    /// If this event is subscribed in the add_NewWindowRequested handler it should be called
    /// after the new window is set. For more details see `ICoreWebView2NewWindowRequestedEventArgs::put_NewWindow`.
    ///
    /// This event is by default raised for file, http, and https URI schemes.
    /// This is also raised for registered custom URI schemes. For more details
    /// see `ICoreWebView2CustomSchemeRegistration`.
    ///
    /// \snippet SettingsComponent.cpp WebResourceRequested0
    /// \snippet SettingsComponent.cpp WebResourceRequested1
    /// </summary>
    function add_WebResourceRequested(const eventHandler: ICoreWebView2WebResourceRequestedEventHandler;
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_WebResourceRequested`.
    /// </summary>
    function remove_WebResourceRequested(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Warning: This method is deprecated and does not behave as expected for
    /// iframes. It will cause the WebResourceRequested event to fire only for the
    /// main frame and its same-origin iframes. Please use
    /// `AddWebResourceRequestedFilterWithRequestSourceKinds`
    /// instead, which will let the event to fire for all iframes on the
    /// document.
    ///
    /// Adds a URI and resource context filter for the `WebResourceRequested`
    /// event.  A web resource request with a resource context that matches this
    /// filter's resource context and a URI that matches this filter's URI
    /// wildcard string will be raised via the `WebResourceRequested` event.
    ///
    /// The `uri` parameter value is a wildcard string matched against the URI
    /// of the web resource request. This is a glob style
    /// wildcard string in which a `*` matches zero or more characters and a `?`
    /// matches exactly one character.
    /// These wildcard characters can be escaped using a backslash just before
    /// the wildcard character in order to represent the literal `*` or `?`.
    ///
    /// The matching occurs over the URI as a whole string and not limiting
    /// wildcard matches to particular parts of the URI.
    /// The wildcard filter is compared to the URI after the URI has been
    /// normalized, any URI fragment has been removed, and non-ASCII hostnames
    /// have been converted to punycode.
    ///
    /// Specifying a `nullptr` for the uri is equivalent to an empty string which
    /// matches no URIs.
    ///
    /// For more information about resource context filters, navigate to
    /// [COREWEBVIEW2_WEB_RESOURCE_CONTEXT](/microsoft-edge/webview2/reference/win32/webview2-idl#corewebview2_web_resource_context).
    ///
    /// | URI Filter String | Request URI | Match | Notes |
    /// | ---- | ---- | ---- | ---- |
    /// | `*` | `https://contoso.com/a/b/c` | Yes | A single * will match all URIs |
    /// | `*://contoso.com/*` | `https://contoso.com/a/b/c` | Yes | Matches everything in contoso.com across all schemes |
    /// | `*://contoso.com/*` | `https://example.com/?https://contoso.com/` | Yes | But also matches a URI with just the same text anywhere in the URI |
    /// | `example` | `https://contoso.com/example` | No | The filter does not perform partial matches |
    /// | `*example` | `https://contoso.com/example` | Yes | The filter matches across URI parts  |
    /// | `*example` | `https://contoso.com/path/?example` | Yes | The filter matches across URI parts |
    /// | `*example` | `https://contoso.com/path/?query#example` | No | The filter is matched against the URI with no fragment |
    /// | `*example` | `https://example` | No | The URI is normalized before filter matching so the actual URI used for comparison is `https://example/` |
    /// | `*example/` | `https://example` | Yes | Just like above, but this time the filter ends with a / just like the normalized URI |
    /// | `https://xn--qei.example/` | `https://&#x2764;.example/` | Yes | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
    /// | `https://&#x2764;.example/` | `https://xn--qei.example/` | No | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
    /// </summary>
    function AddWebResourceRequestedFilter(uri: PWideChar;
                                           ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT): HResult; stdcall;
    /// <summary>
    /// Warning: This method and `AddWebResourceRequestedFilter` are deprecated.
    /// Please use `AddWebResourceRequestedFilterWithRequestSourceKinds` and
    /// `RemoveWebResourceRequestedFilterWithRequestSourceKinds` instead.
    ///
    /// Removes a matching WebResource filter that was previously added for the
    /// `WebResourceRequested` event.  If the same filter was added multiple
    /// times, then it must be removed as many times as it was added for the
    /// removal to be effective.  Returns `E_INVALIDARG` for a filter that was
    /// never added.
    /// </summary>
    function RemoveWebResourceRequestedFilter(uri: PWideChar;
                                              ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `WindowCloseRequested` event.
    /// `WindowCloseRequested` triggers when content inside the WebView
    /// requested to close the window, such as after `window.close` is run.  The
    /// app should close the WebView and related app window if that makes sense
    /// to the app. After the first window.close() call, this event may not fire
    /// for any immediate back to back window.close() calls.
    ///
    /// \snippet AppWindow.cpp WindowCloseRequested
    /// </summary>
    function add_WindowCloseRequested(const eventHandler: ICoreWebView2WindowCloseRequestedEventHandler;
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_WindowCloseRequested`.
    /// </summary>
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
    /// <summary>
    /// Controls if running JavaScript is enabled in all future navigations in
    /// the WebView.  This only affects scripts in the document.  Scripts
    /// injected with `ExecuteScript` runs even if script is disabled.
    /// The default value is `TRUE`.
    ///
    /// \snippet SettingsComponent.cpp IsScriptEnabled
    /// </summary>
    function Get_IsScriptEnabled(out IsScriptEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsScriptEnabled` property.
    /// </summary>
    function Set_IsScriptEnabled(IsScriptEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// The `IsWebMessageEnabled` property is used when loading a new HTML
    /// document.  If set to `TRUE`, communication from the host to the top-level
    ///  HTML document of the WebView is allowed using `PostWebMessageAsJson`,
    /// `PostWebMessageAsString`, and message event of `window.chrome.webview`.
    /// For more information, navigate to PostWebMessageAsJson.  Communication
    /// from the top-level HTML document of the WebView to the host is allowed
    /// using the postMessage function of `window.chrome.webview` and
    /// `add_WebMessageReceived` method.  For more information, navigate to
    /// [add_WebMessageReceived](/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived).
    /// If set to false, then communication is disallowed.  `PostWebMessageAsJson`
    /// and `PostWebMessageAsString` fails with `E_ACCESSDENIED` and
    /// `window.chrome.webview.postMessage` fails by throwing an instance of an
    /// `Error` object. The default value is `TRUE`.
    ///
    /// \snippet ScenarioWebMessage.cpp IsWebMessageEnabled
    /// </summary>
    function Get_IsWebMessageEnabled(out IsWebMessageEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsWebMessageEnabled` property.
    /// </summary>
    function Set_IsWebMessageEnabled(IsWebMessageEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// `AreDefaultScriptDialogsEnabled` is used when loading a new HTML
    /// document.  If set to `FALSE`, WebView2 does not render the default JavaScript
    /// dialog box (Specifically those displayed by the JavaScript alert,
    /// confirm, prompt functions and `beforeunload` event).  Instead, if an
    /// event handler is set using `add_ScriptDialogOpening`, WebView sends an
    /// event that contains all of the information for the dialog and allow the
    /// host app to show a custom UI.
    /// The default value is `TRUE`.
    /// </summary>
    function Get_AreDefaultScriptDialogsEnabled(out AreDefaultScriptDialogsEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AreDefaultScriptDialogsEnabled` property.
    /// </summary>
    function Set_AreDefaultScriptDialogsEnabled(AreDefaultScriptDialogsEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// `IsStatusBarEnabled` controls whether the status bar is displayed.  The
    /// status bar is usually displayed in the lower left of the WebView and
    /// shows things such as the URI of a link when the user hovers over it and
    /// other information.
    /// The default value is `TRUE`.
    /// The status bar UI can be altered by web content and should not be considered secure.
    /// </summary>
    function Get_IsStatusBarEnabled(out IsStatusBarEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsStatusBarEnabled` property.
    /// </summary>
    function Set_IsStatusBarEnabled(IsStatusBarEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// `AreDevToolsEnabled` controls whether the user is able to use the context
    /// menu or keyboard shortcuts to open the DevTools window.
    /// The default value is `TRUE`.
    /// </summary>
    function Get_AreDevToolsEnabled(out AreDevToolsEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AreDevToolsEnabled` property.
    /// </summary>
    function Set_AreDevToolsEnabled(AreDevToolsEnabled: Integer): HResult; stdcall;
    /// <summary>
    /// The `AreDefaultContextMenusEnabled` property is used to prevent default
    /// context menus from being shown to user in WebView.
    /// The default value is `TRUE`.
    ///
    /// \snippet SettingsComponent.cpp DisableContextMenu
    /// </summary>
    function Get_AreDefaultContextMenusEnabled(out enabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AreDefaultContextMenusEnabled` property.
    /// </summary>
    function Set_AreDefaultContextMenusEnabled(enabled: Integer): HResult; stdcall;
    /// <summary>
    /// The `AreHostObjectsAllowed` property is used to control whether host
    /// objects are accessible from the page in WebView.
    /// The default value is `TRUE`.
    ///
    /// \snippet SettingsComponent.cpp HostObjectsAccess
    /// </summary>
    function Get_AreHostObjectsAllowed(out allowed: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AreHostObjectsAllowed` property.
    /// </summary>
    function Set_AreHostObjectsAllowed(allowed: Integer): HResult; stdcall;
    /// <summary>
    /// The `IsZoomControlEnabled` property is used to prevent the user from
    /// impacting the zoom of the WebView.  When disabled, the user is not able
    /// to zoom using Ctrl++, Ctrl+-, or Ctrl+mouse wheel, but the zoom
    /// is set using `ZoomFactor` API.  The default value is `TRUE`.
    ///
    /// \snippet SettingsComponent.cpp DisableZoomControl
    /// </summary>
    function Get_IsZoomControlEnabled(out enabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsZoomControlEnabled` property.
    /// </summary>
    function Set_IsZoomControlEnabled(enabled: Integer): HResult; stdcall;
    /// <summary>
    /// The `IsBuiltInErrorPageEnabled` property is used to disable built in
    /// error page for navigation failure and render process failure.  When
    /// disabled, a blank page is displayed when the related error happens.
    /// The default value is `TRUE`.
    ///
    /// \snippet SettingsComponent.cpp BuiltInErrorPageEnabled
    /// </summary>
    function Get_IsBuiltInErrorPageEnabled(out enabled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsBuiltInErrorPageEnabled` property.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The uri of the requested navigation.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// `TRUE` when the navigation was initiated through a user gesture as
    /// opposed to programmatic navigation by page script. Navigations initiated
    /// via WebView2 APIs are considered as user initiated.
    /// </summary>
    function Get_IsUserInitiated(out IsUserInitiated: Integer): HResult; stdcall;
    /// <summary>
    /// `TRUE` when the navigation is redirected.
    /// </summary>
    function Get_IsRedirected(out IsRedirected: Integer): HResult; stdcall;
    /// <summary>
    /// The HTTP request headers for the navigation.
    ///
    /// \> [!NOTE]\n\> You are not able to modify the HTTP request headers in a
    /// `NavigationStarting` event.
    /// </summary>
    function Get_RequestHeaders(out RequestHeaders: ICoreWebView2HttpRequestHeaders): HResult; stdcall;
    /// <summary>
    /// The host may set this flag to cancel the navigation.  If set, the
    /// navigation is not longer present and the content of the current page is
    /// intact.  For performance reasons, `GET` HTTP requests may happen, while
    /// the host is responding.  You may set cookies and use part of a request
    /// for the navigation.  Navigations to about schemes are cancellable, unless
    /// `msWebView2CancellableAboutNavigations` feature flag is disabled.
    /// Cancellation of frame navigation to `srcdoc` is not supported and
    /// wil be ignored.  A cancelled navigation will fire a `NavigationCompleted`
    /// event with a `WebErrorStatus` of
    /// `COREWEBVIEW2_WEB_ERROR_STATUS_OPERATION_CANCELED`.
    /// </summary>
    function Get_Cancel(out Cancel: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Cancel` property.
    /// </summary>
    function Set_Cancel(Cancel: Integer): HResult; stdcall;
    /// <summary>
    /// The ID of the navigation.
    /// </summary>
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
    /// <summary>
    /// Gets the header value matching the name.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function GetHeader(name: PWideChar; out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the header value matching the name using an iterator.
    /// </summary>
    function GetHeaders(name: PWideChar; out value: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
    /// <summary>
    /// Checks whether the headers contain an entry that matches the header name.
    /// </summary>
    function Contains(name: PWideChar; out value: Integer): HResult; stdcall;
    /// <summary>
    /// Adds or updates header that matches the name.
    /// </summary>
    function SetHeader(name: PWideChar; value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Removes header that matches the name.
    /// </summary>
    function RemoveHeader(name: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets an iterator over the collection of request headers.
    /// </summary>
    function GetIterator(out value: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
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
    /// <summary>
    /// Get the name and value of the current HTTP header of the iterator.  If
    /// the previous `MoveNext` operation set the `hasNext` parameter to `FALSE`,
    /// this method fails.
    ///
    /// The caller must free the returned strings with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function GetCurrentHeader(out name: PWideChar; out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// `TRUE` when the iterator has not run out of headers.  If the collection
    /// over which the iterator is iterating is empty or if the iterator has gone
    ///  past the end of the collection then this is `FALSE`.
    /// </summary>
    function Get_HasCurrentHeader(out hasCurrent: Integer): HResult; stdcall;
    /// <summary>
    /// Move the iterator to the next HTTP header in the collection.
    ///
    /// \> [!NOTE]\n \> If no more HTTP headers exist, the `hasNext` parameter is set to
    /// `FALSE`.  After this occurs the `GetCurrentHeader` method fails.
    /// </summary>
    function MoveNext(out hasNext: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `ContentLoading` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2contentloadingeventhandler">See the ICoreWebView2ContentLoadingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ContentLoadingEventHandler = interface(IUnknown)
    ['{364471E7-F2BE-4910-BDBA-D72077D51C4B}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// `TRUE` if the loaded content is an error page.
    /// </summary>
    function Get_IsErrorPage(out value: Integer): HResult; stdcall;
    /// <summary>
    /// The ID of the navigation.
    /// </summary>
    function Get_NavigationId(out value: Largeuint): HResult; stdcall;
  end;

  /// <summary>
  /// Receives SourceChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sourcechangedeventhandler">See the ICoreWebView2SourceChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2SourceChangedEventHandler = interface(IUnknown)
    ['{3C067F9F-5388-4772-8B48-79F7EF1AB37C}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// `TRUE` if the page being navigated to is a new document.
    /// </summary>
    function Get_IsNewDocument(out value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives HistoryChanged events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2historychangedeventhandler">See the ICoreWebView2HistoryChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2HistoryChangedEventHandler = interface(IUnknown)
    ['{C79A420C-EFD9-4058-9295-3E8B4BCAB645}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// `TRUE` when the navigation is successful.  `FALSE` for a navigation that
    /// ended up in an error page (failures due to no network, DNS lookup
    /// failure, HTTP server responds with 4xx), but may also be `FALSE` for
    /// additional scenarios such as `window.stop()` run on navigated page.
    /// Note that WebView2 will report the navigation as 'unsuccessful' if the load
    /// for the navigation did not reach the expected completion for any reason. Such
    /// reasons include potentially catastrophic issues such network and certificate
    /// issues, but can also be the result of intended actions such as the app canceling a navigation or
    /// navigating away before the original navigation completed. Applications should not
    /// just rely on this flag, but also consider the reported WebErrorStatus to
    /// determine whether the failure is indeed catastrophic in their context.
    /// WebErrorStatuses that may indicate a non-catastrophic failure include:
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_OPERATION_CANCELED
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_VALID_AUTHENTICATION_CREDENTIALS_REQUIRED
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_VALID_PROXY_AUTHENTICATION_REQUIRED
    /// </summary>
    function Get_IsSuccess(out IsSuccess: Integer): HResult; stdcall;
    /// <summary>
    /// The error code if the navigation failed.
    /// </summary>
    function Get_WebErrorStatus(out WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS): HResult; stdcall;
    /// <summary>
    /// The ID of the navigation.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The URI of the page that requested the dialog box.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// The kind of JavaScript dialog box.  `alert`, `confirm`, `prompt`, or
    /// `beforeunload`.
    /// </summary>
    function Get_Kind(out Kind: COREWEBVIEW2_SCRIPT_DIALOG_KIND): HResult; stdcall;
    /// <summary>
    /// The message of the dialog box.  From JavaScript this is the first
    /// parameter passed to `alert`, `confirm`, and `prompt` and is empty for
    /// `beforeunload`.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Message(out Message: PWideChar): HResult; stdcall;
    /// <summary>
    /// The host may run this to respond with **OK** to `confirm`, `prompt`, and
    /// `beforeunload` dialogs.  Do not run this method to indicate cancel.
    /// From JavaScript, this means that the `confirm` and `beforeunload` function
    /// returns `TRUE` if `Accept` is run.  And for the prompt function it returns
    /// the value of `ResultText` if `Accept` is run and otherwise returns
    /// `FALSE`.
    /// </summary>
    function Accept: HResult; stdcall;
    /// <summary>
    /// The second parameter passed to the JavaScript prompt dialog.
    /// The result of the prompt JavaScript function uses this value as the
    /// default value.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_DefaultText(out DefaultText: PWideChar): HResult; stdcall;
    /// <summary>
    /// The return value from the JavaScript prompt function if `Accept` is run.
    ///  This value is ignored for dialog kinds other than prompt.  If `Accept`
    /// is not run, this value is ignored and `FALSE` is returned from prompt.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ResultText(out ResultText: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `ResultText` property.
    /// </summary>
    function Set_ResultText(ResultText: PWideChar): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object.  Use this operation to
    /// complete the event at a later time.
    /// </summary>
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
    /// <summary>
    /// Completes the associated deferred event.  Complete should only be run
    /// once for each deferral taken.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The origin of the web content that requests the permission.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// The type of the permission that is requested.
    /// </summary>
    function Get_PermissionKind(out PermissionKind: COREWEBVIEW2_PERMISSION_KIND): HResult; stdcall;
    /// <summary>
    /// `TRUE` when the permission request was initiated through a user gesture.
    ///
    /// \> [!NOTE]\n\> Being initiated through a user gesture does not mean that user intended
    /// to access the associated resource.
    /// </summary>
    function Get_IsUserInitiated(out IsUserInitiated: Integer): HResult; stdcall;
    /// <summary>
    /// The status of a permission request, (for example is the request is granted).
    /// The default value is `COREWEBVIEW2_PERMISSION_STATE_DEFAULT`.
    /// </summary>
    function Get_State(out State: COREWEBVIEW2_PERMISSION_STATE): HResult; stdcall;
    /// <summary>
    /// Sets the `State` property.
    /// </summary>
    function Set_State(State: COREWEBVIEW2_PERMISSION_STATE): HResult; stdcall;
    /// <summary>
    /// Gets an `ICoreWebView2Deferral` object.  Use the deferral object to make
    /// the permission decision at a later time. The deferral only applies to the
    /// current request, and does not prevent the `PermissionRequested` event from
    /// getting raised for new requests. However, for some permission kinds the
    /// WebView will avoid creating a new request if there is a pending request of
    /// the same kind.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The kind of process failure that has occurred. This is a combination of
    /// process kind (for example, browser, renderer, gpu) and failure (exit,
    /// unresponsiveness). Renderer processes are further divided in _main frame_
    /// renderer (`RenderProcessExited`, `RenderProcessUnresponsive`) and
    /// _subframe_ renderer (`FrameRenderProcessExited`). To learn about the
    /// conditions under which each failure kind occurs, see
    /// `COREWEBVIEW2_PROCESS_FAILED_KIND`.
    /// </summary>
    function Get_ProcessFailedKind(out value: COREWEBVIEW2_PROCESS_FAILED_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the AddScriptToExecuteOnDocumentCreated method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2addscripttoexecuteondocumentcreatedcompletedhandler">See the ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler = interface(IUnknown)
    ['{B99369F3-9B11-47B5-BC6F-8E7895FCEA17}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the ExecuteScript method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2executescriptcompletedhandler">See the ICoreWebView2ExecuteScriptCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ExecuteScriptCompletedHandler = interface(IUnknown)
    ['{49511172-CC67-4BCA-9923-137112F4C4CC}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;
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
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The URI of the document that sent this web message.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Source(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The message posted from the WebView content to the host converted to a
    /// JSON string.  Run this operation to communicate using JavaScript objects.
    ///
    /// For example, the following `postMessage` runs result in the following
    /// `WebMessageAsJson` values.
    ///
    /// ```json
    /// postMessage({'a': 'b'})      L"{\"a\": \"b\"}"
    /// postMessage(1.2)             L"1.2"
    /// postMessage('example')       L"\"example\""
    /// ```
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_webMessageAsJson(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// If the message posted from the WebView content to the host is a string
    /// type, this method returns the value of that string.  If the message
    /// posted is some other kind of JavaScript type this method fails with the
    /// following error.
    ///
    /// ```text
    /// E_INVALIDARG
    /// ```
    ///
    /// Run this operation to communicate using simple strings.
    ///
    /// For example, the following `postMessage` runs result in the following
    /// `WebMessageAsString` values.
    ///
    /// ```json
    /// postMessage({'a': 'b'})      E_INVALIDARG
    /// postMessage(1.2)             E_INVALIDARG
    /// postMessage('example')       L"example"
    /// ```
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function TryGetWebMessageAsString(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `CallDevToolsProtocolMethod` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2calldevtoolsprotocolmethodcompletedhandler">See the ICoreWebView2CallDevToolsProtocolMethodCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CallDevToolsProtocolMethodCompletedHandler = interface(IUnknown)
    ['{5C4889F0-5EF6-4C5A-952C-D8F1B92D0574}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; result_: PWideChar): HResult; stdcall;
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
    /// <summary>
    /// Adds an event handler for the `DevToolsProtocolEventReceived` event.
    /// Subscribe to a `DevToolsProtocol` event.  The `Invoke` method of the
    /// `handler` runs whenever the corresponding `DevToolsProtocol` event runs.
    /// `Invoke` runs with an event args object containing the parameter object
    /// of the DevTools Protocol event as a JSON string.
    ///
    /// \snippet ScriptComponent.cpp DevToolsProtocolEventReceived
    /// </summary>
    function add_DevToolsProtocolEventReceived(const eventHandler: ICoreWebView2DevToolsProtocolEventReceivedEventHandler;
                                               out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_DevToolsProtocolEventReceived`.
    /// </summary>
    function remove_DevToolsProtocolEventReceived(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `DevToolsProtocolEventReceived` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceivedeventhandler">See the ICoreWebView2DevToolsProtocolEventReceivedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2DevToolsProtocolEventReceivedEventHandler = interface(IUnknown)
    ['{E2FDA4BE-5456-406C-A261-3D452138362C}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The parameter object of the corresponding `DevToolsProtocol` event
    /// represented as a JSON string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ParameterObjectAsJson(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NewWindowRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventhandler">See the ICoreWebView2NewWindowRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NewWindowRequestedEventHandler = interface(IUnknown)
    ['{D4C185FE-C81C-4989-97AF-2D3FA7AB5651}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The target uri of the new window requested.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets a CoreWebView2 as a result of the NewWindowRequested event. Provides
    /// a WebView as the target for a `window.open()` from inside the
    /// requesting WebView. If this is set, the top-level window of this WebView
    /// is returned as the opened
    /// [WindowProxy](https://developer.mozilla.org/docs/glossary/windowproxy)
    /// to the opener script. If this is not set, then `Handled` is checked to
    /// determine behavior for NewWindowRequested event.
    /// CoreWebView2 provided in the `NewWindow` property must be on the same
    /// Environment as the opener WebView and should not have been navigated
    /// previously. Don't use methods that cause navigation or interact with the
    /// DOM on this CoreWebView2 until the target content has loaded. Setting event
    /// handlers, changing Settings properties, or other methods are fine to call.
    /// Changes to settings should be made before `put_NewWindow` is called to
    /// ensure that those settings take effect for the newly setup WebView. Once the
    /// NewWindow is set the underlying web contents of this CoreWebView2 will be
    /// replaced and navigated as appropriate for the new window. After setting
    /// new window it cannot be changed and error will be return otherwise.
    ///
    /// The methods which should affect the new web contents like
    /// AddScriptToExecuteOnDocumentCreated has to be called and completed before setting NewWindow.
    /// Other methods which should affect the new web contents like add_WebResourceRequested have to be called after setting NewWindow.
    /// It is best not to use RemoveScriptToExecuteOnDocumentCreated before setting NewWindow, otherwise it may not work for later added scripts.
    ///
    /// The new WebView must have the same profile as the opener WebView.
    /// </summary>
    function Set_NewWindow(const NewWindow: ICoreWebView2): HResult; stdcall;
    /// <summary>
    /// Gets the new window.
    /// </summary>
    function Get_NewWindow(out NewWindow: ICoreWebView2): HResult; stdcall;
    /// <summary>
    /// Sets whether the `NewWindowRequested` event is handled by host.  If this
    /// is `FALSE` and no `NewWindow` is set, the WebView opens a popup window
    /// and it returns as opened `WindowProxy`.  If set to `TRUE` and no
    /// `NewWindow` is set for `window.open`, the opened `WindowProxy` is for an
    /// testing window object and no window loads.
    /// The default value is `FALSE`.
    /// </summary>
    function Set_Handled(Handled: Integer): HResult; stdcall;
    /// <summary>
    /// Gets whether the `NewWindowRequested` event is handled by host.
    /// </summary>
    function Get_Handled(out Handled: Integer): HResult; stdcall;
    /// <summary>
    /// `TRUE` when the new window request was initiated through a user gesture.
    /// Examples of user initiated requests are:
    ///
    /// - Selecting an anchor tag with target
    /// - Programmatic window open from a script that directly run as a result of
    /// user interaction such as via onclick handlers.
    ///
    /// Non-user initiated requests are programmatic window opens from a script
    /// that are not directly triggered by user interaction, such as those that
    /// run while loading a new page or via timers.
    /// The Microsoft Edge popup blocker is disabled for WebView so the app is
    /// able to use this flag to block non-user initiated popups.
    /// </summary>
    function Get_IsUserInitiated(out IsUserInitiated: Integer): HResult; stdcall;
    /// <summary>
    /// Obtain an `ICoreWebView2Deferral` object and put the event into a
    /// deferred state.  Use the `ICoreWebView2Deferral` object to complete the
    /// window open request at a later time.  While this event is deferred the
    /// opener window returns a `WindowProxy` to an un-navigated window, which
    /// navigates when the deferral is complete.
    /// </summary>
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
    /// <summary>
    /// Window features specified by the `window.open`.  The features should be
    /// considered for positioning and sizing of new webview windows.
    /// </summary>
    function Get_WindowFeatures(out value: ICoreWebView2WindowFeatures): HResult; stdcall;
  end;

  /// <summary>
  /// <para>The window features for a WebView popup window.  The fields match the
  /// windowFeatures passed to window.open as specified in
  /// [Window features](https://developer.mozilla.org/docs/Web/API/Window/open#Window_features)
  /// on MDN.</para>
  /// <para>There is no requirement for you to respect the values.  If your app does
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
  /// to an integer.</para>
  /// <para>In runtime versions 98 or later, the values of ShouldDisplayMenuBar,
  /// ShouldDisplayStatus, ShouldDisplayToolbar, and ShouldDisplayScrollBars
  /// will not directly depend on the equivalent fields in the windowFeatures
  /// string.  Instead, they will all be false if the window is expected to be a
  /// popup, and true if it is not.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures">See the ICoreWebView2WindowFeatures article.</see></para>
  /// </remarks>
  ICoreWebView2WindowFeatures = interface(IUnknown)
    ['{5EAF559F-B46E-4397-8860-E422F287FF1E}']
    /// <summary>
    /// Specifies left and top values.
    /// </summary>
    function Get_HasPosition(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Specifies height and width values.
    /// </summary>
    function Get_HasSize(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Specifies the left position of the window.   If `HasPosition` is set to
    /// `FALSE`, this field is ignored.
    /// </summary>
    function Get_left(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Specifies the top position of the window.   If `HasPosition` is set to
    /// `FALSE`, this field is ignored.
    /// </summary>
    function Get_top(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Specifies the height of the window.  Minimum value is `100`.  If
    /// `HasSize` is set to `FALSE`, this field is ignored.
    /// </summary>
    function Get_Height(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Specifies the width of the window.  Minimum value is `100`.  If `HasSize`
    /// is set to `FALSE`, this field is ignored.
    /// </summary>
    function Get_Width(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Indicates that the menu bar is displayed.
    /// </summary>
    function Get_ShouldDisplayMenuBar(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Indicates that the status bar is displayed.
    /// </summary>
    function Get_ShouldDisplayStatus(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Indicates that the browser toolbar is displayed.
    /// </summary>
    function Get_ShouldDisplayToolbar(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Indicates that the scroll bars are displayed.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `WebResourceRequested` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventhandler">See the ICoreWebView2WebResourceRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceRequestedEventHandler = interface(IUnknown)
    ['{AB00B74C-15F1-4646-80E8-E76341D25D71}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The Web resource request.  The request object may be missing some headers
    /// that are added by network stack at a later time.
    /// </summary>
    function Get_Request(out Request: ICoreWebView2WebResourceRequest): HResult; stdcall;
    /// <summary>
    /// A placeholder for the web resource response object.  If this object is
    /// set, the web resource request is completed with the specified response.
    /// </summary>
    function Get_Response(out Response: ICoreWebView2WebResourceResponse): HResult; stdcall;
    /// <summary>
    /// Sets the `Response` property.  Create an empty web resource response
    /// object with `CreateWebResourceResponse` and then modify it to construct
    /// the response.
    /// </summary>
    function Set_Response(const Response: ICoreWebView2WebResourceResponse): HResult; stdcall;
    /// <summary>
    /// Obtain an `ICoreWebView2Deferral` object and put the event into a
    /// deferred state.  Use the `ICoreWebView2Deferral` object to complete the
    /// request at a later time.
    /// </summary>
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
    /// <summary>
    /// The web resource request context.
    /// </summary>
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
    /// <summary>
    /// The request URI.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `Uri` property.
    /// </summary>
    function Set_uri(uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// The HTTP request method.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Method(out Method: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `Method` property.
    /// </summary>
    function Set_Method(Method: PWideChar): HResult; stdcall;
    /// <summary>
    /// The HTTP request message body as stream.  POST data should be here.  If a
    /// stream is set, which overrides the message body, the stream must have
    /// all the content data available by the time the `WebResourceRequested`
    /// event deferral of this response is completed.  Stream should be agile or
    /// be created from a background STA to prevent performance impact to the UI
    /// thread.  `Null` means no content data.  `IStream` semantics apply
    /// (return `S_OK` to `Read` runs until all data is exhausted).
    /// </summary>
    function Get_Content(out Content: IStream): HResult; stdcall;
    /// <summary>
    /// Sets the `Content` property.
    /// </summary>
    function Set_Content(const Content: IStream): HResult; stdcall;
    /// <summary>
    /// The mutable HTTP request headers
    /// </summary>
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
    /// <summary>
    /// HTTP response content as stream.  Stream must have all the content data
    /// available by the time the `WebResourceRequested` event deferral of this
    /// response is completed.  Stream should be agile or be created from a
    /// background thread to prevent performance impact to the UI thread.  `Null`
    ///  means no content data.  `IStream` semantics apply (return `S_OK` to
    /// `Read` runs until all data is exhausted).
    /// When providing the response data, you should consider relevant HTTP
    /// request headers just like an HTTP server would do. For example, if the
    /// request was for a video resource in a HTML video element, the request may
    /// contain the [Range](https://developer.mozilla.org/docs/Web/HTTP/Headers/Range)
    /// header to request only a part of the video that is streaming. In this
    /// case, your response stream should be only the portion of the video
    /// specified by the range HTTP request headers and you should set the
    /// appropriate
    /// [Content-Range](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Range)
    /// header in the response.
    /// </summary>
    function Get_Content(out Content: IStream): HResult; stdcall;
    /// <summary>
    /// Sets the `Content` property.
    /// </summary>
    function Set_Content(const Content: IStream): HResult; stdcall;
    /// <summary>
    /// Overridden HTTP response headers.
    /// </summary>
    function Get_Headers(out Headers: ICoreWebView2HttpResponseHeaders): HResult; stdcall;
    /// <summary>
    /// The HTTP response status code.
    /// </summary>
    function Get_StatusCode(out StatusCode: SYSINT): HResult; stdcall;
    /// <summary>
    /// Sets the `StatusCode` property.
    /// </summary>
    function Set_StatusCode(StatusCode: SYSINT): HResult; stdcall;
    /// <summary>
    /// The HTTP response reason phrase.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ReasonPhrase(out ReasonPhrase: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `ReasonPhrase` property.
    /// </summary>
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
    /// <summary>
    /// Appends header line with name and value.
    /// </summary>
    function AppendHeader(name: PWideChar; value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Verifies that the headers contain entries that match the header name.
    /// </summary>
    function Contains(name: PWideChar; out value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the first header value in the collection matching the name.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function GetHeader(name: PWideChar; out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the header values matching the name.
    /// </summary>
    function GetHeaders(name: PWideChar; out value: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
    /// <summary>
    /// Gets an iterator over the collection of entire response headers.
    /// </summary>
    function GetIterator(out value: ICoreWebView2HttpHeadersCollectionIterator): HResult; stdcall;
  end;

  /// <summary>
  /// Receives WindowCloseRequested events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowcloserequestedeventhandler">See the ICoreWebView2WindowCloseRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WindowCloseRequestedEventHandler = interface(IUnknown)
    ['{5C19E9E0-092F-486B-AFFA-CA8231913039}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Add an event handler for the WebResourceResponseReceived event.
    /// WebResourceResponseReceived is raised when the WebView receives the
    /// response for a request for a web resource (any URI resolution performed by
    /// the WebView; such as HTTP/HTTPS, file and data requests from redirects,
    /// navigations, declarations in HTML, implicit favicon lookups, and fetch API
    /// usage in the document). The host app can use this event to view the actual
    /// request and response for a web resource. There is no guarantee about the
    /// order in which the WebView processes the response and the host app's
    /// handler runs. The app's handler will not block the WebView from processing
    /// the response.
    /// \snippet ScenarioAuthentication.cpp WebResourceResponseReceived
    /// </summary>
    function add_WebResourceResponseReceived(const eventHandler: ICoreWebView2WebResourceResponseReceivedEventHandler; 
                                             out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with
    /// add_WebResourceResponseReceived.
    /// </summary>
    function remove_WebResourceResponseReceived(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Navigates using a constructed WebResourceRequest object. This lets you
    /// provide post data or additional request headers during navigation.
    /// The headers in the WebResourceRequest override headers
    /// added by WebView2 runtime except for Cookie headers.
    /// Method can only be either "GET" or "POST". Provided post data will only
    /// be sent only if the method is "POST" and the uri scheme is HTTP(S).
    /// \snippet ScenarioNavigateWithWebResourceRequest.cpp NavigateWithWebResourceRequest
    /// </summary>
    function NavigateWithWebResourceRequest(const Request: ICoreWebView2WebResourceRequest): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the DOMContentLoaded event.
    /// DOMContentLoaded is raised when the initial html document has been parsed.
    /// This aligns with the document's DOMContentLoaded event in html.
    ///
    /// \snippet ScenarioDOMContentLoaded.cpp DOMContentLoaded
    /// </summary>
    function add_DOMContentLoaded(const eventHandler: ICoreWebView2DOMContentLoadedEventHandler;
                                  out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with add_DOMContentLoaded.
    /// </summary>
    function remove_DOMContentLoaded(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Gets the cookie manager object associated with this ICoreWebView2.
    /// See ICoreWebView2CookieManager.
    ///
    /// \snippet ScenarioCookieManagement.cpp CookieManager
    /// </summary>
    function Get_CookieManager(out CookieManager: ICoreWebView2CookieManager): HResult; stdcall;
    /// <summary>
    /// Exposes the CoreWebView2Environment used to create this CoreWebView2.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The request object for the web resource, as committed. This includes
    /// headers added by the network stack that were not be included during the
    /// associated WebResourceRequested event, such as Authentication headers.
    /// Modifications to this object have no effect on how the request is
    /// processed as it has already been sent.
    /// </summary>
    function Get_Request(out value: ICoreWebView2WebResourceRequest): HResult; stdcall;
    /// <summary>
    /// View of the response object received for the web resource.
    /// </summary>
    function Get_Response(out value: ICoreWebView2WebResourceResponseView): HResult; stdcall;
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
    /// <summary>
    /// The HTTP response headers as received.
    /// </summary>
    function Get_Headers(out Headers: ICoreWebView2HttpResponseHeaders): HResult; stdcall;
    /// <summary>
    /// The HTTP response status code.
    /// </summary>
    function Get_StatusCode(out StatusCode: SYSINT): HResult; stdcall;
    /// <summary>
    /// The HTTP response reason phrase.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ReasonPhrase(out ReasonPhrase: PWideChar): HResult; stdcall;
    /// <summary>
    /// Get the response content asynchronously. The handler will receive the
    /// response content stream.
    ///
    /// This method returns null if content size is more than 123MB or for navigations that become downloads
    /// or if response is downloadable content type (e.g., application/octet-stream).
    /// See `add_DownloadStarting` event to handle the response.
    ///
    /// If this method is being called again before a first call has completed,
    /// the handler will be invoked at the same time the handlers from prior calls
    /// are invoked.
    /// If this method is being called after a first call has completed, the
    /// handler will be invoked immediately.
    /// \snippet ScenarioWebViewEventMonitor.cpp GetContent
    /// </summary>
    function GetContent(const handler: ICoreWebView2WebResourceResponseViewGetContentCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `GetContent` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponseviewgetcontentcompletedhandler">See the ICoreWebView2WebResourceResponseViewGetContentCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceResponseViewGetContentCompletedHandler = interface(IUnknown)
    ['{875738E1-9FA2-40E3-8B74-2E8972DD6FE7}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;
  end;

  /// <summary>
  /// Receives DOMContentLoaded events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2domcontentloadedeventhandler">See the ICoreWebView2DOMContentLoadedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2DOMContentLoadedEventHandler = interface(IUnknown)
    ['{4BAC7E9C-199E-49ED-87ED-249303ACF019}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The ID of the navigation which corresponds to other navigation ID properties on other navigation events.
    /// </summary>
    function Get_NavigationId(out value: Largeuint): HResult; stdcall;
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
    /// <summary>
    /// Create a cookie object with a specified name, value, domain, and path.
    /// One can set other optional properties after cookie creation.
    /// This only creates a cookie object and it is not added to the cookie
    /// manager until you call AddOrUpdateCookie.
    /// Leading or trailing whitespace(s), empty string, and special characters
    /// are not allowed for name.
    /// See ICoreWebView2Cookie for more details.
    /// </summary>
    function CreateCookie(name: PWideChar; value: PWideChar; Domain: PWideChar; Path: PWideChar; 
                          out cookie: ICoreWebView2Cookie): HResult; stdcall;
    /// <summary>
    /// Creates a cookie whose params matches those of the specified cookie.
    /// </summary>
    function CopyCookie(const cookieParam: ICoreWebView2Cookie; out cookie: ICoreWebView2Cookie): HResult; stdcall;
    /// <summary>
    /// Gets a list of cookies matching the specific URI.
    /// If uri is empty string or null, all cookies under the same profile are
    /// returned.
    /// You can modify the cookie objects by calling
    /// ICoreWebView2CookieManager::AddOrUpdateCookie, and the changes
    /// will be applied to the webview.
    /// \snippet ScenarioCookieManagement.cpp GetCookies
    /// </summary>
    function GetCookies(uri: PWideChar; const handler: ICoreWebView2GetCookiesCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Adds or updates a cookie with the given cookie data; may overwrite
    /// cookies with matching name, domain, and path if they exist.
    /// This method will fail if the domain of the given cookie is not specified.
    /// \snippet ScenarioCookieManagement.cpp AddOrUpdateCookie
    /// </summary>
    function AddOrUpdateCookie(const cookie: ICoreWebView2Cookie): HResult; stdcall;
    /// <summary>
    /// Deletes a cookie whose name and domain/path pair
    /// match those of the specified cookie.
    /// </summary>
    function DeleteCookie(const cookie: ICoreWebView2Cookie): HResult; stdcall;
    /// <summary>
    /// Deletes cookies with matching name and uri.
    /// Cookie name is required.
    /// All cookies with the given name where domain
    /// and path match provided URI are deleted.
    /// </summary>
    function DeleteCookies(name: PWideChar; uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// Deletes cookies with matching name and domain/path pair.
    /// Cookie name is required.
    /// If domain is specified, deletes only cookies with the exact domain.
    /// If path is specified, deletes only cookies with the exact path.
    /// </summary>
    function DeleteCookiesWithDomainAndPath(name: PWideChar; Domain: PWideChar; Path: PWideChar): HResult; stdcall;
    /// <summary>
    /// Deletes all cookies under the same profile.
    /// This could affect other WebViews under the same user profile.
    /// </summary>
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
    /// <summary>
    /// Cookie name.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_name(out name: PWideChar): HResult; stdcall;
    /// <summary>
    /// Cookie value.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_value(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Set the cookie value property.
    /// </summary>
    function Set_value(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The domain for which the cookie is valid.
    /// The default is the host that this cookie has been received from.
    /// Note that, for instance, ".bing.com", "bing.com", and "www.bing.com" are
    /// considered different domains.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Domain(out Domain: PWideChar): HResult; stdcall;
    /// <summary>
    /// The path for which the cookie is valid. The default is "/", which means
    /// this cookie will be sent to all pages on the Domain.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Path(out Path: PWideChar): HResult; stdcall;
    /// <summary>
    /// The expiration date and time for the cookie as the number of seconds since the UNIX epoch.
    /// The default is -1.0, which means cookies are session cookies by default.
    /// </summary>
    function Get_Expires(out Expires: Double): HResult; stdcall;
    /// <summary>
    /// Set the Expires property. Cookies are session cookies and will not be
    /// persistent if Expires is set to -1.0. NaN, infinity, and any negative
    /// value set other than -1.0 is disallowed.
    /// </summary>
    function Set_Expires(Expires: Double): HResult; stdcall;
    /// <summary>
    /// Whether this cookie is http-only.
    /// True if a page script or other active content cannot access this
    /// cookie. The default is false.
    /// </summary>
    function Get_IsHttpOnly(out IsHttpOnly: Integer): HResult; stdcall;
    /// <summary>
    /// Set the IsHttpOnly property.
    /// </summary>
    function Set_IsHttpOnly(IsHttpOnly: Integer): HResult; stdcall;
    /// <summary>
    /// SameSite status of the cookie which represents the enforcement mode of the cookie.
    /// The default is COREWEBVIEW2_COOKIE_SAME_SITE_KIND_LAX.
    /// </summary>
    function Get_SameSite(out SameSite: COREWEBVIEW2_COOKIE_SAME_SITE_KIND): HResult; stdcall;
    /// <summary>
    /// Set the SameSite property.
    /// </summary>
    function Set_SameSite(SameSite: COREWEBVIEW2_COOKIE_SAME_SITE_KIND): HResult; stdcall;
    /// <summary>
    /// The security level of this cookie. True if the client is only to return
    /// the cookie in subsequent requests if those requests use HTTPS.
    /// The default is false.
    /// Note that cookie that requests COREWEBVIEW2_COOKIE_SAME_SITE_KIND_NONE but
    /// is not marked Secure will be rejected.
    /// </summary>
    function Get_IsSecure(out IsSecure: Integer): HResult; stdcall;
    /// <summary>
    /// Set the IsSecure property.
    /// </summary>
    function Set_IsSecure(IsSecure: Integer): HResult; stdcall;
    /// <summary>
    /// Whether this is a session cookie. The default is false.
    /// </summary>
    function Get_IsSession(out IsSession: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the GetCookies method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getcookiescompletedhandler">See the ICoreWebView2GetCookiesCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2GetCookiesCompletedHandler = interface(IUnknown)
    ['{5A4F5069-5C15-47C3-8646-F4DE1C116670}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2CookieList): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of ICoreWebView2Cookie.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cookielist">See the ICoreWebView2CookieList article.</see></para>
  /// </remarks>
  ICoreWebView2CookieList = interface(IUnknown)
    ['{F7F6F714-5D2A-43C6-9503-346ECE02D186}']
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2Cookie): HResult; stdcall;
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
    /// <summary>
    /// Asynchronously create a new WebView.
    ///
    /// `parentWindow` is the `HWND` in which the WebView should be displayed and
    /// from which receive input.  The WebView adds a child window to the
    /// provided window before this function returns.  Z-order and other things
    /// impacted by sibling window order are affected accordingly.  If you want to
    /// move the WebView to a different parent after it has been created, you must
    /// call put_ParentWindow to update tooltip positions, accessibility trees,
    /// and such.
    ///
    /// HWND_MESSAGE is a valid parameter for `parentWindow` for an invisible
    /// WebView for Windows 8 and above. In this case the window will never
    /// become visible. You are not able to reparent the window after you have
    /// created the WebView.  This is not supported in Windows 7 or below.
    /// Passing this parameter in Windows 7 or below will return
    /// ERROR_INVALID_WINDOW_HANDLE in the controller callback.
    ///
    /// It is recommended that the app set Application User Model ID for the
    /// process or the app window.  If none is set, during WebView creation a
    /// generated Application User Model ID is set to root window of
    /// `parentWindow`.
    ///
    /// \snippet AppWindow.cpp CreateCoreWebView2Controller
    ///
    /// It is recommended that the app handles restart manager messages, to
    /// gracefully restart it in the case when the app is using the WebView2
    /// Runtime from a certain installation and that installation is being
    /// uninstalled.  For example, if a user installs a version of the WebView2
    /// Runtime and opts to use another version of the WebView2 Runtime for
    /// testing the app, and then uninstalls the 1st version of the WebView2
    /// Runtime without closing the app, the app restarts to allow
    /// un-installation to succeed.
    ///
    /// \snippet AppWindow.cpp RestartManager
    ///
    /// The app should retry `CreateCoreWebView2Controller` upon failure, unless the
    /// error code is `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
    /// When the app retries `CreateCoreWebView2Controller` upon failure, it is
    /// recommended that the app restarts from creating a new WebView2
    /// Environment.  If a WebView2 Runtime update happens, the version
    /// associated with a WebView2 Environment may have been removed and causing
    /// the object to no longer work.  Creating a new WebView2 Environment works
    /// since it uses the latest version.
    ///
    /// WebView creation fails with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if a
    /// running instance using the same user data folder exists, and the Environment
    /// objects have different `EnvironmentOptions`.  For example, if a WebView was
    /// created with one language, an attempt to create a WebView with a different
    /// language using the same user data folder will fail.
    ///
    /// The creation will fail with `E_ABORT` if `parentWindow` is destroyed
    /// before the creation is finished.  If this is caused by a call to
    /// `DestroyWindow`, the creation completed handler will be invoked before
    /// `DestroyWindow` returns, so you can use this to cancel creation and clean
    /// up resources synchronously when quitting a thread.
    ///
    /// In rare cases the creation can fail with `E_UNEXPECTED` if runtime does not have
    /// permissions to the user data folder.
    /// </summary>
    function CreateCoreWebView2Controller(ParentWindow: HWND;
                                          const handler: ICoreWebView2CreateCoreWebView2ControllerCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Create a new web resource response object.  The `headers` parameter is
    /// the raw response header string delimited by newline.  It is also possible
    /// to create this object with null headers string and then use the
    /// `ICoreWebView2HttpResponseHeaders` to construct the headers line by line.
    /// For more information about other parameters, navigate to
    /// [ICoreWebView2WebResourceResponse](/microsoft-edge/webview2/reference/win32/icorewebview2webresourceresponse).
    ///
    /// \snippet SettingsComponent.cpp WebResourceRequested0
    /// \snippet SettingsComponent.cpp WebResourceRequested1
    /// </summary>
    function CreateWebResourceResponse(const Content: IStream; StatusCode: SYSINT; 
                                       ReasonPhrase: PWideChar; Headers: PWideChar; 
                                       out Response: ICoreWebView2WebResourceResponse): HResult; stdcall;
    /// <summary>
    /// The browser version info of the current `ICoreWebView2Environment`,
    /// including channel name if it is not the WebView2 Runtime.  It matches the
    /// format of the `GetAvailableCoreWebView2BrowserVersionString` API.
    /// Channel names are `beta`, `dev`, and `canary`.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    ///
    /// \snippet AppWindow.cpp GetBrowserVersionString
    /// </summary>
    function Get_BrowserVersionString(out versionInfo: PWideChar): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `NewBrowserVersionAvailable` event.
    /// `NewBrowserVersionAvailable` runs when a newer version of the WebView2
    /// Runtime is installed and available using WebView2.  To use the newer
    /// version of the browser you must create a new environment and WebView.
    /// The event only runs for new version from the same WebView2 Runtime from
    /// which the code is running. When not running with installed WebView2
    /// Runtime, no event is run.
    ///
    /// Because a user data folder is only able to be used by one browser
    /// process at a time, if you want to use the same user data folder in the
    /// WebView using the new version of the browser, you must close the
    /// environment and instance of WebView that are using the older version of
    /// the browser first.  Or simply prompt the user to restart the app.
    ///
    /// \snippet AppWindow.cpp NewBrowserVersionAvailable
    /// </summary>
    function add_NewBrowserVersionAvailable(const eventHandler: ICoreWebView2NewBrowserVersionAvailableEventHandler; 
                                            out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_NewBrowserVersionAvailable`.
    /// </summary>
    function remove_NewBrowserVersionAvailable(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `CreateCoreWebView2Controller` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2controllercompletedhandler">See the ICoreWebView2CreateCoreWebView2ControllerCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CreateCoreWebView2ControllerCompletedHandler = interface(IUnknown)
    ['{6C4819F3-C9B7-4260-8127-C9F5BDE7F68C}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2Controller): HResult; stdcall;
  end;

  /// <summary>
  /// Receives NewBrowserVersionAvailable events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newbrowserversionavailableeventhandler">See the ICoreWebView2NewBrowserVersionAvailableEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NewBrowserVersionAvailableEventHandler = interface(IUnknown)
    ['{F9A2976E-D34E-44FC-ADEE-81B6B57CA914}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// An app may call the `TrySuspend` API to have the WebView2 consume less memory.
    /// This is useful when a Win32 app becomes invisible, or when a Universal Windows
    /// Platform app is being suspended, during the suspended event handler before completing
    /// the suspended event.
    /// The CoreWebView2Controller's IsVisible property must be false when the API is called.
    /// Otherwise, the API fails with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
    /// Suspending is similar to putting a tab to sleep in the Edge browser. Suspending pauses
    /// WebView script timers and animations, minimizes CPU usage for the associated
    /// browser renderer process and allows the operating system to reuse the memory that was
    /// used by the renderer process for other processes.
    /// Note that Suspend is best effort and considered completed successfully once the request
    /// is sent to browser renderer process. If there is a running script, the script will continue
    /// to run and the renderer process will be suspended after that script is done.
    /// See [Sleeping Tabs FAQ](https://techcommunity.microsoft.com/t5/articles/sleeping-tabs-faq/m-p/1705434)
    /// for conditions that might prevent WebView from being suspended. In those situations,
    /// the completed handler will be invoked with isSuccessful as false and errorCode as S_OK.
    /// The WebView will be automatically resumed when it becomes visible. Therefore, the
    /// app normally does not have to call `Resume` explicitly.
    /// The app can call `Resume` and then `TrySuspend` periodically for an invisible WebView so that
    /// the invisible WebView can sync up with latest data and the page ready to show fresh content
    /// when it becomes visible.
    /// All WebView APIs can still be accessed when a WebView is suspended. Some APIs like Navigate
    /// will auto resume the WebView. To avoid unexpected auto resume, check `IsSuspended` property
    /// before calling APIs that might change WebView state.
    ///
    /// \snippet ViewComponent.cpp ToggleIsVisibleOnMinimize
    ///
    /// \snippet ViewComponent.cpp Suspend
    /// </summary>
    function TrySuspend(const handler: ICoreWebView2TrySuspendCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Resumes the WebView so that it resumes activities on the web page.
    /// This API can be called while the WebView2 controller is invisible.
    /// The app can interact with the WebView immediately after `Resume`.
    /// WebView will be automatically resumed when it becomes visible.
    ///
    /// \snippet ViewComponent.cpp ToggleIsVisibleOnMinimize
    ///
    /// \snippet ViewComponent.cpp Resume
    /// </summary>
    function Resume: HResult; stdcall;
    /// <summary>
    /// Whether WebView is suspended.
    /// `TRUE` when WebView is suspended, from the time when TrySuspend has completed
    ///  successfully until WebView is resumed.
    /// </summary>
    function Get_IsSuspended(out IsSuspended: Integer): HResult; stdcall;
    /// <summary>
    /// Sets a mapping between a virtual host name and a folder path to make available to web sites
    /// via that host name.
    ///
    /// After setting the mapping, documents loaded in the WebView can use HTTP or HTTPS URLs at
    /// the specified host name specified by hostName to access files in the local folder specified
    /// by folderPath.
    ///
    /// This mapping applies to both top-level document and iframe navigations as well as subresource
    /// references from a document. This also applies to web workers including dedicated/shared worker
    /// and service worker, for loading either worker scripts or subresources
    /// (importScripts(), fetch(), XHR, etc.) issued from within a worker.
    /// For virtual host mapping to work with service worker, please keep the virtual host name
    /// mappings consistent among all WebViews sharing the same browser instance. As service worker
    /// works independently of WebViews, we merge mappings from all WebViews when resolving virtual
    /// host name, inconsistent mappings between WebViews would lead unexpected behavior.
    ///
    /// Due to a current implementation limitation, media files accessed using virtual host name can be
    /// very slow to load.
    /// As the resource loaders for the current page might have already been created and running,
    /// changes to the mapping might not be applied to the current page and a reload of the page is
    /// needed to apply the new mapping.
    ///
    /// Both absolute and relative paths are supported for folderPath. Relative paths are interpreted
    /// as relative to the folder where the exe of the app is in.
    ///
    /// Note that the folderPath length must not exceed the Windows MAX_PATH limit.
    ///
    /// accessKind specifies the level of access to resources under the virtual host from other sites.
    ///
    /// For example, after calling
    /// ```cpp
    ///    SetVirtualHostNameToFolderMapping(
    ///        L"appassets.example", L"assets",
    ///        COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_DENY);
    /// ```
    /// navigating to `https://appassets.example/my-local-file.html` will
    /// show the content from my-local-file.html in the assets subfolder located on disk under
    /// the same path as the app's executable file.
    ///
    /// DOM elements that want to reference local files will have their host reference virtual host in the source.
    /// If there are multiple folders being used, define one unique virtual host per folder.
    /// For example, you can embed a local image like this
    /// ```cpp
    ///    WCHAR c_navString[] = L"<img src=\"http://appassets.example/wv2.png\"/>";
    ///    m_webView->NavigateToString(c_navString);
    /// ```
    /// The example above shows the image wv2.png by resolving the folder mapping above.
    ///
    /// You should typically choose virtual host names that are never used by real sites.
    /// If you own a domain such as example.com, another option is to use a subdomain reserved for
    /// the app (like my-app.example.com).
    ///
    /// [RFC 6761](https://tools.ietf.org/html/rfc6761) has reserved several special-use domain
    /// names that are guaranteed to not be used by real sites (for example, .example, .test, and
    /// .invalid.)
    ///
    /// Note that using `.local` as the top-level domain name will work but can cause a delay
    /// during navigations. You should avoid using `.local` if you can.
    ///
    /// Apps should use distinct domain names when mapping folder from different sources that
    /// should be isolated from each other. For instance, the app might use app-file.example for
    /// files that ship as part of the app, and book1.example might be used for files containing
    /// books from a less trusted source that were previously downloaded and saved to the disk by
    /// the app.
    ///
    /// The host name used in the APIs is canonicalized using Chromium's host name parsing logic
    /// before being used internally. For more information see [HTML5 2.6 URLs](https://dev.w3.org/html5/spec-LC/urls.html).
    ///
    /// All host names that are canonicalized to the same string are considered identical.
    /// For example, `EXAMPLE.COM` and `example.com` are treated as the same host name.
    /// An international host name and its Punycode-encoded host name are considered the same host
    /// name. There is no DNS resolution for host name and the trailing '.' is not normalized as
    /// part of canonicalization.
    ///
    /// Therefore `example.com` and `example.com.` are treated as different host names. Similarly,
    /// `virtual-host-name` and `virtual-host-name.example.com` are treated as different host names
    /// even if the machine has a DNS suffix of `example.com`.
    ///
    /// Specify the minimal cross-origin access necessary to run the app. If there is not a need to
    /// access local resources from other origins, use COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_DENY.
    ///
    /// \snippet AppWindow.cpp AddVirtualHostNameToFolderMapping
    ///
    /// \snippet AppWindow.cpp LocalUrlUsage
    /// </summary>
    function SetVirtualHostNameToFolderMapping(hostName: PWideChar; folderPath: PWideChar; 
                                               accessKind: COREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND): HResult; stdcall;
    /// <summary>
    /// Clears a host name mapping for local folder that was added by `SetVirtualHostNameToFolderMapping`.
    /// </summary>
    function ClearVirtualHostNameToFolderMapping(hostName: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `TrySuspend` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2trysuspendcompletedhandler">See the ICoreWebView2TrySuspendCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2TrySuspendCompletedHandler = interface(IUnknown)
    ['{00F206A7-9D17-4605-91F6-4E8E4DE192E3}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; result_: Integer): HResult; stdcall;
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
    /// <summary>
    /// Raised when a new iframe is created.
    /// Handle this event to get access to ICoreWebView2Frame objects.
    /// Use ICoreWebView2Frame.add_Destroyed to listen for when this iframe goes
    /// away.
    /// </summary>
    function add_FrameCreated(const eventHandler: ICoreWebView2FrameCreatedEventHandler; 
                              out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with add_FrameCreated.
    /// </summary>
    function remove_FrameCreated(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `DownloadStarting` event. This event is
    /// raised when a download has begun, blocking the default download dialog,
    /// but not blocking the progress of the download.
    ///
    /// The host can choose to cancel a download, change the result file path,
    /// and hide the default download dialog.
    /// If the host chooses to cancel the download, the download is not saved, no
    /// dialog is shown, and the state is changed to
    /// COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED with interrupt reason
    /// COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_USER_CANCELED. Otherwise, the
    /// download is saved to the default path after the event completes,
    /// and default download dialog is shown if the host did not choose to hide it.
    /// The host can change the visibility of the download dialog using the
    /// `Handled` property. If the event is not handled, downloads complete
    /// normally with the default dialog shown.
    ///
    /// \snippet ScenarioCustomDownloadExperience.cpp DownloadStarting
    /// </summary>
    function add_DownloadStarting(const eventHandler: ICoreWebView2DownloadStartingEventHandler;
                                  out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_DownloadStarting`.
    /// </summary>
    function remove_DownloadStarting(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `FrameCreated` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecreatedeventhandler">See the ICoreWebView2FrameCreatedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameCreatedEventHandler = interface(IUnknown)
    ['{38059770-9BAA-11EB-A8B3-0242AC130003}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The frame which was created.
    /// </summary>
    function Get_Frame(out value: ICoreWebView2Frame): HResult; stdcall;
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
    /// <summary>
    /// The value of iframe's window.name property. The default value equals to
    /// iframe html tag declaring it. You can access this property even if the
    /// iframe is destroyed.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_name(out name: PWideChar): HResult; stdcall;
    /// <summary>
    /// Raised when the iframe changes its window.name property.
    /// </summary>
    function add_NameChanged(const eventHandler: ICoreWebView2FrameNameChangedEventHandler; 
                             out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with add_NameChanged.
    /// </summary>
    function remove_NameChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add the provided host object to script running in the iframe with the
    /// specified name for the list of the specified origins. The host object
    /// will be accessible for this iframe only if the iframe's origin during
    /// access matches one of the origins which are passed. The provided origins
    /// will be normalized before comparing to the origin of the document.
    /// So the scheme name is made lower case, the host will be punycode decoded
    /// as appropriate, default port values will be removed, and so on.
    /// This means the origin's host may be punycode encoded or not and will match
    /// regardless. If list contains malformed origin the call will fail.
    /// The method can be called multiple times in a row without calling
    /// RemoveHostObjectFromScript for the same object name. It will replace
    /// the previous object with the new object and new list of origins.
    /// List of origins will be treated as following:
    /// 1. empty list - call will succeed and object will be added for the iframe
    /// but it will not be exposed to any origin;
    /// 2. list with origins - during access to host object from iframe the
    /// origin will be checked that it belongs to this list;
    /// 3. list with "*" element - host object will be available for iframe for
    /// all origins. We suggest not to use this feature without understanding
    /// security implications of giving access to host object from from iframes
    /// with unknown origins.
    /// 4. list with "file://" element - host object will be available for iframes
    /// loaded via file protocol.
    /// Calling this method fails if it is called after the iframe is destroyed.
    /// \snippet ScenarioAddHostObject.cpp AddHostObjectToScriptWithOrigins
    /// For more information about host objects navigate to
    /// ICoreWebView2::AddHostObjectToScript.
    /// </summary>
    function AddHostObjectToScriptWithOrigins(name: PWideChar; const object_: OleVariant;
                                              originsCount: SYSUINT; var origins: PWideChar): HResult; stdcall;
    /// <summary>
    /// Remove the host object specified by the name so that it is no longer
    /// accessible from JavaScript code in the iframe. While new access
    /// attempts are denied, if the object is already obtained by JavaScript code
    /// in the iframe, the JavaScript code continues to have access to that
    /// object. Calling this method for a name that is already removed or was
    /// never added fails. If the iframe is destroyed this method will return fail
    /// also.
    /// </summary>
    function RemoveHostObjectFromScript(name: PWideChar): HResult; stdcall;
    /// <summary>
    /// The Destroyed event is raised when the iframe corresponding
    /// to this CoreWebView2Frame object is removed or the document
    /// containing that iframe is destroyed.
    /// </summary>
    function add_Destroyed(const eventHandler: ICoreWebView2FrameDestroyedEventHandler; 
                           out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with add_Destroyed.
    /// </summary>
    function remove_Destroyed(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Check whether a frame is destroyed. Returns true during
    /// the Destroyed event.
    /// </summary>
    function IsDestroyed(out destroyed: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `NameChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenamechangedeventhandler">See the ICoreWebView2FrameNameChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameNameChangedEventHandler = interface(IUnknown)
    ['{435C7DC8-9BAA-11EB-A8B3-0242AC130003}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `Destroyed` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framedestroyedeventhandler">See the ICoreWebView2FrameDestroyedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameDestroyedEventHandler = interface(IUnknown)
    ['{59DD7B4C-9BAA-11EB-A8B3-0242AC130003}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `DownloadStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2downloadstartingeventhandler">See the ICoreWebView2DownloadStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2DownloadStartingEventHandler = interface(IUnknown)
    ['{EFEDC989-C396-41CA-83F7-07F845A55724}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Returns the `ICoreWebView2DownloadOperation` for the download that
    /// has started.
    /// </summary>
    function Get_DownloadOperation(out DownloadOperation: ICoreWebView2DownloadOperation): HResult; stdcall;
    /// <summary>
    /// The host may set this flag to cancel the download. If canceled, the
    /// download save dialog is not displayed regardless of the
    /// `Handled` property.
    /// </summary>
    function Get_Cancel(out Cancel: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Cancel` property.
    /// </summary>
    function Set_Cancel(Cancel: Integer): HResult; stdcall;
    /// <summary>
    /// The path to the file. If setting the path, the host should ensure that it
    /// is an absolute path, including the file name, and that the path does not
    /// point to an existing file. If the path points to an existing file, the
    /// file will be overwritten. If the directory does not exist, it is created.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ResultFilePath(out ResultFilePath: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `ResultFilePath` property.
    /// </summary>
    function Set_ResultFilePath(ResultFilePath: PWideChar): HResult; stdcall;
    /// <summary>
    /// The host may set this flag to `TRUE` to hide the default download dialog
    /// for this download. The download will progress as normal if it is not
    /// canceled, there will just be no default UI shown. By default the value is
    /// `FALSE` and the default download dialog is shown.
    /// </summary>
    function Get_Handled(out Handled: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Handled` property.
    /// </summary>
    function Set_Handled(Handled: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object.  Use this operation to
    /// complete the event at a later time.
    /// </summary>
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
    /// <summary>
    /// Add an event handler for the `BytesReceivedChanged` event.
    ///
    /// \snippet ScenarioCustomDownloadExperience.cpp BytesReceivedChanged
    /// </summary>
    function add_BytesReceivedChanged(const eventHandler: ICoreWebView2BytesReceivedChangedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_BytesReceivedChanged`.
    /// </summary>
    function remove_BytesReceivedChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `EstimatedEndTimeChanged` event.
    /// </summary>
    function add_EstimatedEndTimeChanged(const eventHandler: ICoreWebView2EstimatedEndTimeChangedEventHandler; 
                                         out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_EstimatedEndTimeChanged`.
    /// </summary>
    function remove_EstimatedEndTimeChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `StateChanged` event.
    ///
    /// \snippet ScenarioCustomDownloadExperience.cpp StateChanged
    /// </summary>
    function add_StateChanged(const eventHandler: ICoreWebView2StateChangedEventHandler; 
                              out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_StateChanged`.
    /// </summary>
    function remove_StateChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// The URI of the download.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_uri(out uri: PWideChar): HResult; stdcall;
    /// <summary>
    /// The Content-Disposition header value from the download's HTTP response.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ContentDisposition(out ContentDisposition: PWideChar): HResult; stdcall;
    /// <summary>
    /// MIME type of the downloaded content.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_MimeType(out MimeType: PWideChar): HResult; stdcall;
    /// <summary>
    /// The expected size of the download in total number of bytes based on the
    /// HTTP Content-Length header. Returns -1 if the size is unknown.
    /// </summary>
    function Get_TotalBytesToReceive(out TotalBytesToReceive: Int64): HResult; stdcall;
    /// <summary>
    /// The number of bytes that have been written to the download file.
    /// </summary>
    function Get_BytesReceived(out BytesReceived: Int64): HResult; stdcall;
    /// <summary>
    /// The estimated end time in [ISO 8601 Date and Time Format](https://www.iso.org/iso-8601-date-and-time-format.html).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_EstimatedEndTime(out EstimatedEndTime: PWideChar): HResult; stdcall;
    /// <summary>
    /// The absolute path to the download file, including file name. Host can change
    /// this from `ICoreWebView2DownloadStartingEventArgs`.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ResultFilePath(out ResultFilePath: PWideChar): HResult; stdcall;
    /// <summary>
    /// The state of the download. A download can be in progress, interrupted, or
    /// completed. See `COREWEBVIEW2_DOWNLOAD_STATE` for descriptions of states.
    /// </summary>
    function Get_State(out downloadState: COREWEBVIEW2_DOWNLOAD_STATE): HResult; stdcall;
    /// <summary>
    /// The reason why connection with file host was broken.
    /// </summary>
    function Get_InterruptReason(out InterruptReason: COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON): HResult; stdcall;
    /// <summary>
    /// Cancels the download. If canceled, the default download dialog shows
    /// that the download was canceled. Host should set the `Cancel` property from
    /// `ICoreWebView2SDownloadStartingEventArgs` if the download should be
    /// canceled without displaying the default download dialog.
    /// </summary>
    function Cancel: HResult; stdcall;
    /// <summary>
    /// Pauses the download. If paused, the default download dialog shows that the
    /// download is paused. No effect if download is already paused. Pausing a
    /// download changes the state to `COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED`
    /// with `InterruptReason` set to `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_USER_PAUSED`.
    /// </summary>
    function Pause: HResult; stdcall;
    /// <summary>
    /// Resumes a paused download. May also resume a download that was interrupted
    /// for another reason, if `CanResume` returns true. Resuming a download changes
    /// the state from `COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED` to
    /// `COREWEBVIEW2_DOWNLOAD_STATE_IN_PROGRESS`.
    /// </summary>
    function Resume: HResult; stdcall;
    /// <summary>
    /// Returns true if an interrupted download can be resumed. Downloads with
    /// the following interrupt reasons may automatically resume without you
    /// calling any methods:
    /// `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_SERVER_NO_RANGE`,
    /// `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_HASH_MISMATCH`,
    /// `COREWEBVIEW2_DOWNLOAD_INTERRUPT_REASON_FILE_TOO_SHORT`.
    /// In these cases download progress may be restarted with `BytesReceived`
    /// reset to 0.
    /// </summary>
    function Get_CanResume(out CanResume: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `BytesReceivedChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2bytesreceivedchangedeventhandler">See the ICoreWebView2BytesReceivedChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2BytesReceivedChangedEventHandler = interface(IUnknown)
    ['{828E8AB6-D94C-4264-9CEF-5217170D6251}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `EstimatedEndTimeChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2estimatedendtimechangedeventhandler">See the ICoreWebView2EstimatedEndTimeChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2EstimatedEndTimeChangedEventHandler = interface(IUnknown)
    ['{28F0D425-93FE-4E63-9F8D-2AEEC6D3BA1E}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2DownloadOperation; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `StateChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2statechangedeventhandler">See the ICoreWebView2StateChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2StateChangedEventHandler = interface(IUnknown)
    ['{81336594-7EDE-4BA9-BF71-ACF0A95B58DD}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Adds an event handler for the ClientCertificateRequested event.
    /// The ClientCertificateRequested event is raised when the WebView2
    /// is making a request to an HTTP server that needs a client certificate
    /// for HTTP authentication.
    /// Read more about HTTP client certificates at
    /// [RFC 8446 The Transport Layer Security (TLS) Protocol Version 1.3](https://tools.ietf.org/html/rfc8446).
    ///
    /// With this event you have several options for responding to client certificate requests:
    ///
    /// Scenario                                                   | Handled | Cancel | SelectedCertificate
    /// ---------------------------------------------------------- | ------- | ------ | -------------------
    /// Respond to server with a certificate                       | True    | False  | MutuallyTrustedCertificate value
    /// Respond to server without certificate                      | True    | False  | null
    /// Display default client certificate selection dialog prompt | False   | False  | n/a
    /// Cancel the request                                         | n/a     | True   | n/a
    ///
    /// If you don't handle the event, WebView2 will
    /// show the default client certificate selection dialog prompt to user.
    ///
    /// \snippet SettingsComponent.cpp ClientCertificateRequested1
    /// \snippet ScenarioClientCertificateRequested.cpp ClientCertificateRequested2
    /// </summary>
    function add_ClientCertificateRequested(const eventHandler: ICoreWebView2ClientCertificateRequestedEventHandler; 
                                            out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with add_ClientCertificateRequested.
    /// </summary>
    function remove_ClientCertificateRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `ClientCertificateRequested` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificaterequestedeventhandler">See the ICoreWebView2ClientCertificateRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ClientCertificateRequestedEventHandler = interface(IUnknown)
    ['{D7175BA2-BCC3-11EB-8529-0242AC130003}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Host name of the server that requested client certificate authentication.
    /// Normalization rules applied to the hostname are:
    /// * Convert to lowercase characters for ascii characters.
    /// * Punycode is used for representing non ascii characters.
    /// * Strip square brackets for IPV6 address.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Host(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Port of the server that requested client certificate authentication.
    /// </summary>
    function Get_Port(out value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Returns true if the server that issued this request is an http proxy.
    /// Returns false if the server is the origin server.
    /// </summary>
    function Get_IsProxy(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns the `ICoreWebView2StringCollection`.
    /// The collection contains Base64 encoding of DER encoded distinguished names of
    /// certificate authorities allowed by the server.
    /// </summary>
    function Get_AllowedCertificateAuthorities(out value: ICoreWebView2StringCollection): HResult; stdcall;
    /// <summary>
    /// Returns the `ICoreWebView2ClientCertificateCollection` when client
    /// certificate authentication is requested. The collection contains mutually
    /// trusted CA certificates.
    /// </summary>
    function Get_MutuallyTrustedCertificates(out value: ICoreWebView2ClientCertificateCollection): HResult; stdcall;
    /// <summary>
    /// Returns the selected certificate.
    /// </summary>
    function Get_SelectedCertificate(out value: ICoreWebView2ClientCertificate): HResult; stdcall;
    /// <summary>
    /// Sets the certificate to respond to the server.
    /// </summary>
    function Set_SelectedCertificate(const value: ICoreWebView2ClientCertificate): HResult; stdcall;
    /// <summary>
    /// You may set this flag to cancel the certificate selection. If canceled,
    /// the request is aborted regardless of the `Handled` property. By default the
    /// value is `FALSE`.
    /// </summary>
    function Get_Cancel(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Cancel` property.
    /// </summary>
    function Set_Cancel(value: Integer): HResult; stdcall;
    /// <summary>
    /// You may set this flag to `TRUE` to respond to the server with or
    /// without a certificate. If this flag is `TRUE` with a `SelectedCertificate`
    /// it responds to the server with the selected certificate otherwise respond to the
    /// server without a certificate. By default the value of `Handled` and `Cancel` are `FALSE`
    /// and display default client certificate selection dialog prompt to allow the user to
    /// choose a certificate. The `SelectedCertificate` is ignored unless `Handled` is set `TRUE`.
    /// </summary>
    function Get_Handled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Handled` property.
    /// </summary>
    function Set_Handled(value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. Use this operation to
    /// complete the event at a later time.
    /// </summary>
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
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of ICoreWebView2ClientCertificate.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificatecollection">See the ICoreWebView2ClientCertificateCollection article.</see></para>
  /// </remarks>
  ICoreWebView2ClientCertificateCollection = interface(IUnknown)
    ['{EF5674D2-BCC3-11EB-8529-0242AC130003}']
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2ClientCertificate): HResult; stdcall;
  end;

  /// <summary>
  /// Provides access to the client certificate metadata.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clientcertificate">See the ICoreWebView2ClientCertificate article.</see></para>
  /// </remarks>
  ICoreWebView2ClientCertificate = interface(IUnknown)
    ['{E7188076-BCC3-11EB-8529-0242AC130003}']
    /// <summary>
    /// Subject of the certificate.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Subject(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Name of the certificate authority that issued the certificate.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Issuer(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The valid start date and time for the certificate as the number of seconds since
    /// the UNIX epoch.
    /// </summary>
    function Get_ValidFrom(out value: Double): HResult; stdcall;
    /// <summary>
    /// The valid expiration date and time for the certificate as the number of seconds since
    /// the UNIX epoch.
    /// </summary>
    function Get_ValidTo(out value: Double): HResult; stdcall;
    /// <summary>
    /// Base64 encoding of DER encoded serial number of the certificate.
    /// Read more about DER at [RFC 7468 DER]
    /// (https://tools.ietf.org/html/rfc7468#appendix-B).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_DerEncodedSerialNumber(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Display name for a certificate.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_DisplayName(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// PEM encoded data for the certificate.
    /// Returns Base64 encoding of DER encoded certificate.
    /// Read more about PEM at [RFC 1421 Privacy Enhanced Mail]
    /// (https://tools.ietf.org/html/rfc1421).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function ToPemEncoding(out pemEncodedData: PWideChar): HResult; stdcall;
    /// <summary>
    /// Collection of PEM encoded client certificate issuer chain.
    /// In this collection first element is the current certificate followed by
    /// intermediate1, intermediate2...intermediateN-1. Root certificate is the
    /// last element in collection.
    /// </summary>
    function Get_PemEncodedIssuerCertificateChain(out value: ICoreWebView2StringCollection): HResult; stdcall;
    /// <summary>
    /// Kind of a certificate (eg., smart card, pin, other).
    /// </summary>
    function Get_Kind(out value: COREWEBVIEW2_CLIENT_CERTIFICATE_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of `ICoreWebView2_5` that manages opening
  /// the browser task manager window.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_6">See the ICoreWebView2_6 article.</see></para>
  /// </remarks>
  ICoreWebView2_6 = interface(ICoreWebView2_5)
    ['{499AADAC-D92C-4589-8A75-111BFC167795}']
    /// <summary>
    /// Opens the Browser Task Manager view as a new window in the foreground.
    /// If the Browser Task Manager is already open, this will bring it into
    /// the foreground. WebView2 currently blocks the Shift+Esc shortcut for
    /// opening the task manager. An end user can open the browser task manager
    /// manually via the `Browser task manager` entry of the DevTools window's
    /// title bar's context menu.
    /// </summary>
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
    /// <summary>
    /// Print the current page to PDF asynchronously with the provided settings.
    /// See `ICoreWebView2PrintSettings` for description of settings. Passing
    /// nullptr for `printSettings` results in default print settings used.
    ///
    /// Use `resultFilePath` to specify the path to the PDF file. The host should
    /// provide an absolute path, including file name. If the path
    /// points to an existing file, the file will be overwritten. If the path is
    /// not valid, the method fails with `E_INVALIDARG`.
    ///
    /// The async `PrintToPdf` operation completes when the data has been written
    /// to the PDF file. At this time the
    /// `ICoreWebView2PrintToPdfCompletedHandler` is invoked. If the
    /// application exits before printing is complete, the file is not saved.
    /// Only one `Printing` operation can be in progress at a time. If
    /// `PrintToPdf` is called while a `PrintToPdf` or `PrintToPdfStream` or `Print` or
    /// `ShowPrintUI` job is in progress, the completed handler is immediately invoked
    /// with `isSuccessful` set to FALSE.
    ///
    /// \snippet FileComponent.cpp PrintToPdf
    /// </summary>
    function PrintToPdf(ResultFilePath: PWideChar; const printSettings: ICoreWebView2PrintSettings; 
                        const handler: ICoreWebView2PrintToPdfCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Settings used by the PrintToPdf method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printsettings">See the ICoreWebView2PrintSettings article.</see></para>
  /// </remarks>
  ICoreWebView2PrintSettings = interface(IUnknown)
    ['{377F3721-C74E-48CA-8DB1-DF68E51D60E2}']
    /// <summary>
    /// The orientation can be portrait or landscape. The default orientation is
    /// portrait. See `COREWEBVIEW2_PRINT_ORIENTATION`.
    /// </summary>
    function Get_Orientation(out Orientation: COREWEBVIEW2_PRINT_ORIENTATION): HResult; stdcall;
    /// <summary>
    /// Sets the `Orientation` property.
    /// </summary>
    function Set_Orientation(Orientation: COREWEBVIEW2_PRINT_ORIENTATION): HResult; stdcall;
    /// <summary>
    /// The scale factor is a value between 0.1 and 2.0. The default is 1.0.
    /// </summary>
    function Get_ScaleFactor(out ScaleFactor: Double): HResult; stdcall;
    /// <summary>
    /// Sets the `ScaleFactor` property. Returns `E_INVALIDARG` if an invalid
    /// value is provided, and the current value is not changed.
    /// </summary>
    function Set_ScaleFactor(ScaleFactor: Double): HResult; stdcall;
    /// <summary>
    /// The page width in inches. The default width is 8.5 inches.
    /// </summary>
    function Get_PageWidth(out PageWidth: Double): HResult; stdcall;
    /// <summary>
    /// Sets the `PageWidth` property. Returns `E_INVALIDARG` if the page width is
    /// less than or equal to zero, and the current value is not changed.
    /// </summary>
    function Set_PageWidth(PageWidth: Double): HResult; stdcall;
    /// <summary>
    /// The page height in inches. The default height is 11 inches.
    /// </summary>
    function Get_PageHeight(out PageHeight: Double): HResult; stdcall;
    /// <summary>
    /// Sets the `PageHeight` property. Returns `E_INVALIDARG` if the page height
    /// is less than or equal to zero, and the current value is not changed.
    /// </summary>
    function Set_PageHeight(PageHeight: Double): HResult; stdcall;
    /// <summary>
    /// The top margin in inches. The default is 1 cm, or ~0.4 inches.
    /// </summary>
    function Get_MarginTop(out MarginTop: Double): HResult; stdcall;
    /// <summary>
    /// Sets the `MarginTop` property. A margin cannot be less than zero.
    /// Returns `E_INVALIDARG` if an invalid value is provided, and the current
    /// value is not changed.
    /// </summary>
    function Set_MarginTop(MarginTop: Double): HResult; stdcall;
    /// <summary>
    /// The bottom margin in inches. The default is 1 cm, or ~0.4 inches.
    /// </summary>
    function Get_MarginBottom(out MarginBottom: Double): HResult; stdcall;
    /// <summary>
    /// Sets the `MarginBottom` property. A margin cannot be less than zero.
    /// Returns `E_INVALIDARG` if an invalid value is provided, and the current
    /// value is not changed.
    /// </summary>
    function Set_MarginBottom(MarginBottom: Double): HResult; stdcall;
    /// <summary>
    /// The left margin in inches. The default is 1 cm, or ~0.4 inches.
    /// </summary>
    function Get_MarginLeft(out MarginLeft: Double): HResult; stdcall;
    /// <summary>
    /// Sets the `MarginLeft` property. A margin cannot be less than zero.
    /// Returns `E_INVALIDARG` if an invalid value is provided, and the current
    /// value is not changed.
    /// </summary>
    function Set_MarginLeft(MarginLeft: Double): HResult; stdcall;
    /// <summary>
    /// The right margin in inches. The default is 1 cm, or ~0.4 inches.
    /// </summary>
    function Get_MarginRight(out MarginRight: Double): HResult; stdcall;
    /// <summary>
    /// Set the `MarginRight` property.A margin cannot be less than zero.
    /// Returns `E_INVALIDARG` if an invalid value is provided, and the current
    /// value is not changed.
    /// </summary>
    function Set_MarginRight(MarginRight: Double): HResult; stdcall;
    /// <summary>
    /// `TRUE` if background colors and images should be printed. The default value
    /// is `FALSE`.
    /// </summary>
    function Get_ShouldPrintBackgrounds(out ShouldPrintBackgrounds: Integer): HResult; stdcall;
    /// <summary>
    /// Set the `ShouldPrintBackgrounds` property.
    /// </summary>
    function Set_ShouldPrintBackgrounds(ShouldPrintBackgrounds: Integer): HResult; stdcall;
    /// <summary>
    /// `TRUE` if only the current end user's selection of HTML in the document
    /// should be printed. The default value is `FALSE`.
    /// </summary>
    function Get_ShouldPrintSelectionOnly(out ShouldPrintSelectionOnly: Integer): HResult; stdcall;
    /// <summary>
    /// Set the `ShouldPrintSelectionOnly` property.
    /// </summary>
    function Set_ShouldPrintSelectionOnly(ShouldPrintSelectionOnly: Integer): HResult; stdcall;
    /// <summary>
    /// `TRUE` if header and footer should be printed. The default value is `FALSE`.
    /// The header consists of the date and time of printing, and the title of the
    /// page. The footer consists of the URI and page number. The height of the
    /// header and footer is 0.5 cm, or ~0.2 inches.
    /// </summary>
    function Get_ShouldPrintHeaderAndFooter(out ShouldPrintHeaderAndFooter: Integer): HResult; stdcall;
    /// <summary>
    /// Set the `ShouldPrintHeaderAndFooter` property.
    /// </summary>
    function Set_ShouldPrintHeaderAndFooter(ShouldPrintHeaderAndFooter: Integer): HResult; stdcall;
    /// <summary>
    /// The title in the header if `ShouldPrintHeaderAndFooter` is `TRUE`. The
    /// default value is the title of the current document.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_HeaderTitle(out HeaderTitle: PWideChar): HResult; stdcall;
    /// <summary>
    /// Set the `HeaderTitle` property. If an empty string or null value is
    /// provided, no title is shown in the header.
    /// </summary>
    function Set_HeaderTitle(HeaderTitle: PWideChar): HResult; stdcall;
    /// <summary>
    /// The URI in the footer if `ShouldPrintHeaderAndFooter` is `TRUE`. The
    /// default value is the current URI.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_FooterUri(out FooterUri: PWideChar): HResult; stdcall;
    /// <summary>
    /// Set the `FooterUri` property. If an empty string or null value is
    /// provided, no URI is shown in the footer.
    /// </summary>
    function Set_FooterUri(FooterUri: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `PrintToPdf` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2printtopdfcompletedhandler">See the ICoreWebView2PrintToPdfCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2PrintToPdfCompletedHandler = interface(IUnknown)
    ['{CCF1EF04-FD8E-4D5F-B2DE-0983E41B8C36}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; result_: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_7 that supports media features.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_8">See the ICoreWebView2_8 article.</see></para>
  /// </remarks>
  ICoreWebView2_8 = interface(ICoreWebView2_7)
    ['{E9632730-6E1E-43AB-B7B8-7B2C9E62E094}']
    /// <summary>
    /// Adds an event handler for the `IsMutedChanged` event.
    /// `IsMutedChanged` is raised when the IsMuted property changes value.
    ///
    /// \snippet AudioComponent.cpp IsMutedChanged
    /// </summary>
    function add_IsMutedChanged(const eventHandler: ICoreWebView2IsMutedChangedEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_IsMutedChanged`.
    /// </summary>
    function remove_IsMutedChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Indicates whether all audio output from this CoreWebView2 is muted or not.
    ///
    /// \snippet AudioComponent.cpp ToggleIsMuted
    /// </summary>
    function Get_IsMuted(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsMuted` property.
    ///
    /// \snippet AudioComponent.cpp ToggleIsMuted
    /// </summary>
    function Set_IsMuted(value: Integer): HResult; stdcall;
    /// <summary>
    /// Adds an event handler for the `IsDocumentPlayingAudioChanged` event.
    /// `IsDocumentPlayingAudioChanged` is raised when the IsDocumentPlayingAudio property changes value.
    ///
    /// \snippet AudioComponent.cpp IsDocumentPlayingAudioChanged
    /// </summary>
    function add_IsDocumentPlayingAudioChanged(const eventHandler: ICoreWebView2IsDocumentPlayingAudioChangedEventHandler; 
                                               out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_IsDocumentPlayingAudioChanged`.
    /// </summary>
    function remove_IsDocumentPlayingAudioChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Indicates whether any audio output from this CoreWebView2 is playing.
    /// This property will be true if audio is playing even if IsMuted is true.
    ///
    /// \snippet AudioComponent.cpp IsDocumentPlayingAudio
    /// </summary>
    function Get_IsDocumentPlayingAudio(out value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `IsMutedChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2ismutedchangedeventhandler">See the ICoreWebView2IsMutedChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2IsMutedChangedEventHandler = interface(IUnknown)
    ['{57D90347-CD0E-4952-A4A2-7483A2756F08}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `IsDocumentPlayingAudioChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2isdocumentplayingaudiochangedeventhandler">See the ICoreWebView2IsDocumentPlayingAudioChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2IsDocumentPlayingAudioChangedEventHandler = interface(IUnknown)
    ['{5DEF109A-2F4B-49FA-B7F6-11C39E513328}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Raised when the `IsDefaultDownloadDialogOpen` property changes. This event
    /// comes after the `DownloadStarting` event. Setting the `Handled` property
    /// on the `DownloadStartingEventArgs` disables the default download dialog
    /// and ensures that this event is never raised.
    /// </summary>
    function add_IsDefaultDownloadDialogOpenChanged(const handler: ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler; 
                                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with
    /// `add_IsDefaultDownloadDialogOpenChanged`.
    /// </summary>
    function remove_IsDefaultDownloadDialogOpenChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// `TRUE` if the default download dialog is currently open. The value of this
    /// property changes only when the default download dialog is explicitly
    /// opened or closed. Hiding the WebView implicitly hides the dialog, but does
    /// not change the value of this property.
    /// </summary>
    function Get_IsDefaultDownloadDialogOpen(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Open the default download dialog. If the dialog is opened before there
    /// are recent downloads, the dialog shows all past downloads for the
    /// current profile. Otherwise, the dialog shows only the recent downloads
    /// with a "See more" button for past downloads. Calling this method raises
    /// the `IsDefaultDownloadDialogOpenChanged` event if the dialog was closed.
    /// No effect if the dialog is already open.
    ///
    /// \snippet ViewComponent.cpp ToggleDefaultDownloadDialog
    /// </summary>
    function OpenDefaultDownloadDialog: HResult; stdcall;
    /// <summary>
    /// Close the default download dialog. Calling this method raises the
    /// `IsDefaultDownloadDialogOpenChanged` event if the dialog was open. No
    /// effect if the dialog is already closed.
    /// </summary>
    function CloseDefaultDownloadDialog: HResult; stdcall;
    /// <summary>
    /// Get the default download dialog corner alignment.
    /// </summary>
    function Get_DefaultDownloadDialogCornerAlignment(out value: COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT): HResult; stdcall;
    /// <summary>
    /// Set the default download dialog corner alignment. The dialog can be
    /// aligned to any of the WebView corners (see
    /// COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT). When the WebView
    /// or dialog changes size, the dialog keeps its position relative to the
    /// corner. The dialog may become partially or completely outside of the
    /// WebView bounds if the WebView is small enough. Set the margin relative to
    /// the corner with the `DefaultDownloadDialogMargin` property. The corner
    /// alignment and margin should be set during initialization to ensure that
    /// they are correctly applied when the layout is first computed, otherwise
    /// they will not take effect until the next time the WebView position or size
    /// is updated.
    ///
    /// \snippet ViewComponent.cpp SetDefaultDownloadDialogPosition
    /// </summary>
    function Set_DefaultDownloadDialogCornerAlignment(value: COREWEBVIEW2_DEFAULT_DOWNLOAD_DIALOG_CORNER_ALIGNMENT): HResult; stdcall;
    /// <summary>
    /// Get the default download dialog margin.
    /// </summary>
    function Get_DefaultDownloadDialogMargin(out value: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Set the default download dialog margin relative to the WebView corner
    /// specified by `DefaultDownloadDialogCornerAlignment`. The margin is a
    /// point that describes the vertical and horizontal distances between the
    /// chosen WebView corner and the default download dialog corner nearest to
    /// it. Positive values move the dialog towards the center of the WebView from
    /// the chosen WebView corner, and negative values move the dialog away from
    /// it. Use (0, 0) to align the dialog to the WebView corner with no margin.
    /// The corner alignment and margin should be set during initialization to
    /// ensure that they are correctly applied when the layout is first computed,
    /// otherwise they will not take effect until the next time the WebView
    /// position or size is updated.
    /// </summary>
    function Set_DefaultDownloadDialogMargin(value: tagPOINT): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `IsDefaultDownloadDialogOpenChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2isdefaultdownloaddialogopenchangedeventhandler">See the ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2IsDefaultDownloadDialogOpenChangedEventHandler = interface(IUnknown)
    ['{3117DA26-AE13-438D-BD46-EDBEB2C4CE81}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Adds an event handler for the BasicAuthenticationRequested event.
    /// BasicAuthenticationRequested event is raised when WebView encounters a
    /// Basic HTTP Authentication request as described in
    /// https://developer.mozilla.org/docs/Web/HTTP/Authentication, a Digest
    /// HTTP Authentication request as described in
    /// https://developer.mozilla.org/docs/Web/HTTP/Headers/Authorization#digest,
    /// an NTLM authentication or a Proxy Authentication request.
    ///
    /// The host can provide a response with credentials for the authentication or
    /// cancel the request. If the host sets the Cancel property to false but does not
    /// provide either UserName or Password properties on the Response property, then
    /// WebView2 will show the default authentication challenge dialog prompt to
    /// the user.
    ///
    /// \snippet ScenarioAuthentication.cpp BasicAuthenticationRequested
    /// </summary>
    function add_BasicAuthenticationRequested(const eventHandler: ICoreWebView2BasicAuthenticationRequestedEventHandler; 
                                              out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with add_BasicAuthenticationRequested.
    /// </summary>
    function remove_BasicAuthenticationRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `BasicAuthenticationRequested` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2basicauthenticationrequestedeventhandler">See the ICoreWebView2BasicAuthenticationRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2BasicAuthenticationRequestedEventHandler = interface(IUnknown)
    ['{58B4D6C2-18D4-497E-B39B-9A96533FA278}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The URI that led to the authentication challenge. For proxy authentication
    /// requests, this will be the URI of the proxy server.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_uri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The authentication challenge string
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Challenge(out Challenge: PWideChar): HResult; stdcall;
    /// <summary>
    /// Response to the authentication request with credentials. This object will be populated by the app
    /// if the host would like to provide authentication credentials.
    /// </summary>
    function Get_Response(out Response: ICoreWebView2BasicAuthenticationResponse): HResult; stdcall;
    /// <summary>
    /// Cancel the authentication request. False by default.
    /// If set to true, Response will be ignored.
    /// </summary>
    function Get_Cancel(out Cancel: Integer): HResult; stdcall;
    /// <summary>
    /// Set the Cancel property.
    /// </summary>
    function Set_Cancel(Cancel: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. Use this deferral to
    /// defer the decision to show the Basic Authentication dialog.
    /// </summary>
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
    /// <summary>
    /// User name provided for authentication.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_UserName(out UserName: PWideChar): HResult; stdcall;
    /// <summary>
    /// Set user name property
    /// </summary>
    function Set_UserName(UserName: PWideChar): HResult; stdcall;
    /// <summary>
    /// Password provided for authentication.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Password(out Password: PWideChar): HResult; stdcall;
    /// <summary>
    /// Set password property
    /// </summary>
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
    /// <summary>
    /// Runs an asynchronous `DevToolsProtocol` method for a specific session of
    /// an attached target.
    /// There could be multiple `DevToolsProtocol` targets in a WebView.
    /// Besides the top level page, iframes from different origin and web workers
    /// are also separate targets. Attaching to these targets allows interaction with them.
    /// When the DevToolsProtocol is attached to a target, the connection is identified
    /// by a sessionId.
    /// To use this API, you must set the `flatten` parameter to true when calling
    /// `Target.attachToTarget` or `Target.setAutoAttach` `DevToolsProtocol` method.
    /// Using `Target.setAutoAttach` is recommended as that would allow you to attach
    /// to dedicated worker targets, which are not discoverable via other APIs like
    /// `Target.getTargets`.
    /// For more information about targets and sessions, navigate to
    /// [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot/Target).
    /// For more information about available methods, navigate to
    /// [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot)
    /// The `sessionId` parameter is the sessionId for an attached target.
    /// nullptr or empty string is treated as the session for the default target for the top page.
    /// The `methodName` parameter is the full name of the method in the
    /// `{domain}.{method}` format.  The `parametersAsJson` parameter is a JSON
    /// formatted string containing the parameters for the corresponding method.
    /// The `Invoke` method of the `handler` is run when the method
    /// asynchronously completes.  `Invoke` is run with the return object of the
    /// method as a JSON string.  This function returns E_INVALIDARG if the `methodName` is
    /// unknown or the `parametersAsJson` has an error.  In the case of such an error, the
    /// `returnObjectAsJson` parameter of the handler will include information
    /// about the error.
    ///
    /// \snippet ScriptComponent.cpp DevToolsProtocolMethodMultiSession
    ///
    /// \snippet ScriptComponent.cpp CallDevToolsProtocolMethodForSession
    /// </summary>
    function CallDevToolsProtocolMethodForSession(sessionId: PWideChar; methodName: PWideChar;
                                                  parametersAsJson: PWideChar;
                                                  const handler: ICoreWebView2CallDevToolsProtocolMethodCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `ContextMenuRequested` event.
    /// `ContextMenuRequested` event is raised when a context menu is requested by the user
    /// and the content inside WebView hasn't disabled context menus.
    /// The host has the option to create their own context menu with the information provided in
    /// the event or can add items to or remove items from WebView context menu.
    /// If the host doesn't handle the event, WebView will display the default context menu.
    ///
    /// \snippet SettingsComponent.cpp EnableCustomMenu
    /// </summary>
    function add_ContextMenuRequested(const eventHandler: ICoreWebView2ContextMenuRequestedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_ContextMenuRequested`.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Gets the collection of `ContextMenuItem` objects.
    /// See `ICoreWebView2ContextMenuItemCollection` for more details.
    /// </summary>
    function Get_MenuItems(out value: ICoreWebView2ContextMenuItemCollection): HResult; stdcall;
    /// <summary>
    /// Gets the target information associated with the requested context menu.
    /// See `ICoreWebView2ContextMenuTarget` for more details.
    /// </summary>
    function Get_ContextMenuTarget(out value: ICoreWebView2ContextMenuTarget): HResult; stdcall;
    /// <summary>
    /// Gets the coordinates where the context menu request occurred in relation to the upper
    /// left corner of the WebView bounds.
    /// </summary>
    function Get_Location(out value: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Sets the selected context menu item's command ID. When this is set,
    /// WebView will execute the selected command. This
    /// value should always be obtained via the selected `ContextMenuItem`'s `CommandId` property.
    /// The default value is -1 which means that no selection occurred. The app can
    /// also report the selected command ID for a custom context menu item, which
    /// will cause the `CustomItemSelected` event to be fired for the custom item, however
    /// while command IDs for each custom context menu item is unique
    /// during a ContextMenuRequested event, CoreWebView2 may reassign command ID
    /// values of deleted custom ContextMenuItems to new objects and the command
    /// ID assigned to the same custom item can be different between each app runtime.
    /// </summary>
    function Set_SelectedCommandId(value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Gets the selected CommandId.
    /// </summary>
    function Get_SelectedCommandId(out value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Sets whether the `ContextMenuRequested` event is handled by host after
    /// the event handler completes or if there is a deferral then after the deferral is completed.
    /// If `Handled` is set to TRUE then WebView will not display a context menu and will instead
    /// use the `SelectedCommandId` property to indicate which, if any, context menu item command to invoke.
    /// If after the event handler or deferral completes `Handled` is set to FALSE then WebView
    /// will display a context menu based on the contents of the `MenuItems` property.
    /// The default value is FALSE.
    /// </summary>
    function Set_Handled(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets whether the `ContextMenuRequested` event is handled by host.
    /// </summary>
    function Get_Handled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. Use this operation to
    /// complete the event when the custom context menu is closed.
    /// </summary>
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
    /// <summary>
    /// Gets the number of `ContextMenuItem` objects contained in the `ContextMenuItemCollection`.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the `ContextMenuItem` at the specified index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2ContextMenuItem): HResult; stdcall;
    /// <summary>
    /// Removes the `ContextMenuItem` at the specified index.
    /// </summary>
    function RemoveValueAtIndex(index: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Inserts the `ContextMenuItem` at the specified index.
    /// </summary>
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
    /// <summary>
    /// Gets the unlocalized name for the `ContextMenuItem`. Use this to
    /// distinguish between context menu item types. This will be the English
    /// label of the menu item in lower camel case. For example, the "Save as"
    /// menu item will be "saveAs". Extension menu items will be "extension",
    /// custom menu items will be "custom" and spellcheck items will be
    /// "spellCheck".
    /// Some example context menu item names are:
    /// - "saveAs"
    /// - "copyImage"
    /// - "openLinkInNewWindow"
    /// - "cut"
    /// - "copy"
    /// - "paste"
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_name(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the localized label for the `ContextMenuItem`. Will contain an
    /// ampersand for characters to be used as keyboard accelerator.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Label_(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the Command ID for the `ContextMenuItem`. Use this to report the
    /// `SelectedCommandId` in `ContextMenuRequested` event.
    /// </summary>
    function Get_CommandId(out value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Gets the localized keyboard shortcut for this ContextMenuItem. It will be
    /// the empty string if there is no keyboard shortcut. This is text intended
    /// to be displayed to the end user to show the keyboard shortcut. For example
    /// this property is Ctrl+Shift+I for the "Inspect" `ContextMenuItem`.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ShortcutKeyDescription(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the Icon for the `ContextMenuItem` in PNG, Bitmap or SVG formats in the form of an IStream.
    /// Stream will be rewound to the start of the image data.
    /// </summary>
    function Get_Icon(out value: IStream): HResult; stdcall;
    /// <summary>
    /// Gets the `ContextMenuItem` kind.
    /// </summary>
    function Get_Kind(out value: COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND): HResult; stdcall;
    /// <summary>
    /// Sets the enabled property of the `ContextMenuItem`. Must only be used in the case of a
    /// custom context menu item. The default value for this is `TRUE`.
    /// </summary>
    function Set_IsEnabled(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the enabled property of the `ContextMenuItem`.
    /// </summary>
    function Get_IsEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the checked property of the `ContextMenuItem`. Must only be used for custom context
    /// menu items that are of kind Check box or Radio.
    /// </summary>
    function Set_IsChecked(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the checked property of the `ContextMenuItem`, used if the kind is Check box or Radio.
    /// </summary>
    function Get_IsChecked(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the list of children menu items through a `ContextMenuItemCollection`
    /// if the kind is Submenu. If the kind is not submenu, will return null.
    /// </summary>
    function Get_Children(out value: ICoreWebView2ContextMenuItemCollection): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `CustomItemSelected` event.
    /// `CustomItemSelected` event is raised when the user selects this `ContextMenuItem`.
    /// Will only be raised for end developer created context menu items
    /// </summary>
    function add_CustomItemSelected(const eventHandler: ICoreWebView2CustomItemSelectedEventHandler; 
                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_CustomItemSelected`.
    /// </summary>
    function remove_CustomItemSelected(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `CustomItemSelected` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2customitemselectedeventhandler">See the ICoreWebView2CustomItemSelectedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CustomItemSelectedEventHandler = interface(IUnknown)
    ['{49E1D0BC-FE9E-4481-B7C2-32324AA21998}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Gets the kind of context that the user selected.
    /// </summary>
    function Get_Kind(out value: COREWEBVIEW2_CONTEXT_MENU_TARGET_KIND): HResult; stdcall;
    /// <summary>
    /// Returns TRUE if the context menu is requested on an editable component.
    /// </summary>
    function Get_IsEditable(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns TRUE if the context menu was requested on the main frame and
    /// FALSE if invoked on another frame.
    /// </summary>
    function Get_IsRequestedForMainFrame(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the uri of the page.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_PageUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the uri of the frame. Will match the PageUri if `IsRequestedForMainFrame` is TRUE.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_FrameUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Returns TRUE if the context menu is requested on HTML containing an anchor tag.
    /// </summary>
    function Get_HasLinkUri(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the uri of the link (if `HasLinkUri` is TRUE, null otherwise).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_LinkUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Returns TRUE if the context menu is requested on text element that contains an anchor tag.
    /// </summary>
    function Get_HasLinkText(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the text of the link (if `HasLinkText` is TRUE, null otherwise).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_LinkText(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Returns TRUE if the context menu is requested on HTML containing a source uri.
    /// </summary>
    function Get_HasSourceUri(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the active source uri of element (if `HasSourceUri` is TRUE, null otherwise).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_SourceUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Returns TRUE if the context menu is requested on a selection.
    /// </summary>
    function Get_HasSelection(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the selected text (if `HasSelection` is TRUE, null otherwise).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
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
    /// <summary>
    /// Add an event handler for the `StatusBarTextChanged` event.
    /// `StatusBarTextChanged` fires when the WebView is showing a status message,
    /// a URL, or an empty string (an indication to hide the status bar).
    /// \snippet SettingsComponent.cpp StatusBarTextChanged
    /// </summary>
    function add_StatusBarTextChanged(const eventHandler: ICoreWebView2StatusBarTextChangedEventHandler; 
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_StatusBarTextChanged`.
    /// </summary>
    function remove_StatusBarTextChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// The status message text.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The associated `ICoreWebView2Profile` object. If this CoreWebView2 was created with a
    /// CoreWebView2ControllerOptions, the CoreWebView2Profile will match those specified options.
    /// Otherwise if this CoreWebView2 was created without a CoreWebView2ControllerOptions, then
    /// this will be the default CoreWebView2Profile for the corresponding CoreWebView2Environment.
    ///
    /// \snippet AppWindow.cpp CoreWebView2Profile
    /// </summary>
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
    /// <summary>
    /// Name of the profile.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ProfileName(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// InPrivate mode is enabled or not.
    /// </summary>
    function Get_IsInPrivateModeEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Full path of the profile directory.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ProfilePath(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the `DefaultDownloadFolderPath` property. The default value is the
    /// system default download folder path for the user.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_DefaultDownloadFolderPath(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `DefaultDownloadFolderPath` property. The default download folder
    /// path is persisted in the user data folder across sessions. The value
    /// should be an absolute path to a folder that the user and application can
    /// write to. Returns `E_INVALIDARG` if the value is invalid, and the default
    /// download folder path is not changed. Otherwise the path is changed
    /// immediately. If the directory does not yet exist, it is created at the
    /// time of the next download. If the host application does not have
    /// permission to create the directory, then the user is prompted to provide a
    /// new path through the Save As dialog. The user can override the default
    /// download folder path for a given download by choosing a different path in
    /// the Save As dialog.
    /// </summary>
    function Set_DefaultDownloadFolderPath(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The PreferredColorScheme property sets the overall color scheme of the
    /// WebView2s associated with this profile. This sets the color scheme for
    /// WebView2 UI like dialogs, prompts, and context menus by setting the
    /// media feature `prefers-color-scheme` for websites to respond to.
    ///
    /// The default value for this is COREWEBVIEW2_PREFERRED_COLOR_AUTO,
    /// which will follow whatever theme the OS is currently set to.
    ///
    /// \snippet ViewComponent.cpp SetPreferredColorScheme
    /// Returns the value of the `PreferredColorScheme` property.
    /// </summary>
    function Get_PreferredColorScheme(out value: COREWEBVIEW2_PREFERRED_COLOR_SCHEME): HResult; stdcall;
    /// <summary>
    /// Sets the `PreferredColorScheme` property.
    /// </summary>
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
    /// <summary>
    /// Adds an event handler for the ServerCertificateErrorDetected event.
    /// The ServerCertificateErrorDetected event is raised when the WebView2
    /// cannot verify server's digital certificate while loading a web page.
    ///
    /// This event will raise for all web resources and follows the `WebResourceRequested` event.
    ///
    /// If you don't handle the event, WebView2 will show the default TLS interstitial error page to the user
    /// for navigations, and for non-navigations the web request is cancelled.
    ///
    /// Note that WebView2 before raising `ServerCertificateErrorDetected` raises a `NavigationCompleted` event
    /// with `IsSuccess` as FALSE and any of the below WebErrorStatuses that indicate a certificate failure.
    ///
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_COMMON_NAME_IS_INCORRECT
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_EXPIRED
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_CLIENT_CERTIFICATE_CONTAINS_ERRORS
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_REVOKED
    /// - COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_IS_INVALID
    ///
    /// For more details see `ICoreWebView2NavigationCompletedEventArgs::get_IsSuccess` and handle
    /// ServerCertificateErrorDetected event or show the default TLS interstitial error page to the user
    /// according to the app needs.
    ///
    /// WebView2 caches the response when action is `COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION_ALWAYS_ALLOW`
    /// for the RequestUri's host and the server certificate in the session and the `ServerCertificateErrorDetected`
    /// event won't be raised again.
    ///
    /// To raise the event again you must clear the cache using `ClearServerCertificateErrorActions`.
    ///
    /// \snippet SettingsComponent.cpp ServerCertificateErrorDetected1
    /// </summary>
    function add_ServerCertificateErrorDetected(const eventHandler: ICoreWebView2ServerCertificateErrorDetectedEventHandler; 
                                                out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with add_ServerCertificateErrorDetected.
    /// </summary>
    function remove_ServerCertificateErrorDetected(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Clears all cached decisions to proceed with TLS certificate errors from the
    /// ServerCertificateErrorDetected event for all WebView2's sharing the same session.
    /// </summary>
    function ClearServerCertificateErrorActions(const handler: ICoreWebView2ClearServerCertificateErrorActionsCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `ServerCertificateErrorDetected` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2servercertificateerrordetectedeventhandler">See the ICoreWebView2ServerCertificateErrorDetectedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ServerCertificateErrorDetectedEventHandler = interface(IUnknown)
    ['{969B3A26-D85E-4795-8199-FEF57344DA22}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The TLS error code for the invalid certificate.
    /// </summary>
    function Get_ErrorStatus(out value: COREWEBVIEW2_WEB_ERROR_STATUS): HResult; stdcall;
    /// <summary>
    /// URI associated with the request for the invalid certificate.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_RequestUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Returns the server certificate.
    /// </summary>
    function Get_ServerCertificate(out value: ICoreWebView2Certificate): HResult; stdcall;
    /// <summary>
    /// The action of the server certificate error detection.
    /// The default value is `COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION_DEFAULT`.
    /// </summary>
    function Get_Action(out value: COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION): HResult; stdcall;
    /// <summary>
    /// Sets the `Action` property.
    /// </summary>
    function Set_Action(value: COREWEBVIEW2_SERVER_CERTIFICATE_ERROR_ACTION): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. Use this operation to
    /// complete the event at a later time.
    /// </summary>
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
    /// <summary>
    /// Subject of the certificate.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Subject(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Name of the certificate authority that issued the certificate.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Issuer(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The valid start date and time for the certificate as the number of seconds since
    /// the UNIX epoch.
    /// </summary>
    function Get_ValidFrom(out value: Double): HResult; stdcall;
    /// <summary>
    /// The valid expiration date and time for the certificate as the number of seconds since
    /// the UNIX epoch.
    /// </summary>
    function Get_ValidTo(out value: Double): HResult; stdcall;
    /// <summary>
    /// Base64 encoding of DER encoded serial number of the certificate.
    /// Read more about DER at [RFC 7468 DER]
    /// (https://tools.ietf.org/html/rfc7468#appendix-B).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_DerEncodedSerialNumber(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Display name for a certificate.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings)
    /// </summary>
    function Get_DisplayName(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// PEM encoded data for the certificate.
    /// Returns Base64 encoding of DER encoded certificate.
    /// Read more about PEM at [RFC 1421 Privacy Enhanced Mail]
    /// (https://tools.ietf.org/html/rfc1421).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings)
    /// </summary>
    function ToPemEncoding(out pemEncodedData: PWideChar): HResult; stdcall;
    /// <summary>
    /// Collection of PEM encoded certificate issuer chain.
    /// In this collection first element is the current certificate followed by
    /// intermediate1, intermediate2...intermediateN-1. Root certificate is the
    /// last element in collection.
    /// </summary>
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
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
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
    /// <summary>
    /// Add an event handler for the `FaviconChanged` event.
    /// The `FaviconChanged` event is raised when the
    /// [favicon](https://developer.mozilla.org/docs/Glossary/Favicon)
    /// had a different URL then the previous URL.
    /// The FaviconChanged event will be raised for first navigating to a new
    /// document, whether or not a document declares a Favicon in HTML if the
    /// favicon is different from the previous fav icon. The event will
    /// be raised again if a favicon is declared in its HTML or has script
    /// to set its favicon. The favicon information can then be retrieved with
    /// `GetFavicon` and `FaviconUri`.
    /// </summary>
    function add_FaviconChanged(const eventHandler: ICoreWebView2FaviconChangedEventHandler; 
                                out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove the event handler for `FaviconChanged` event.
    /// </summary>
    function remove_FaviconChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Get the current Uri of the favicon as a string.
    /// If the value is null, then the return value is `E_POINTER`, otherwise it is `S_OK`.
    /// If a page has no favicon then the value is an empty string.
    /// </summary>
    function Get_FaviconUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Async function for getting the actual image data of the favicon.
    /// The image is copied to the `imageStream` object in `ICoreWebView2GetFaviconCompletedHandler`.
    /// If there is no image then no data would be copied into the imageStream.
    /// The `format` is the file format to return the image stream.
    /// `completedHandler` is executed at the end of the operation.
    ///
    /// \snippet SettingsComponent.cpp FaviconChanged
    /// </summary>
    function GetFavicon(format: COREWEBVIEW2_FAVICON_IMAGE_FORMAT; 
                        const completedHandler: ICoreWebView2GetFaviconCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `FaviconChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2faviconchangedeventhandler">See the ICoreWebView2FaviconChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FaviconChangedEventHandler = interface(IUnknown)
    ['{2913DA94-833D-4DE0-8DCA-900FC524A1A4}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `GetFavicon` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getfaviconcompletedhandler">See the ICoreWebView2GetFaviconCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2GetFaviconCompletedHandler = interface(IUnknown)
    ['{A2508329-7DA8-49D7-8C05-FA125E4AEE8D}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2 interface to support printing.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16">See the ICoreWebView2_16 article.</see></para>
  /// </remarks>
  ICoreWebView2_16 = interface(ICoreWebView2_15)
    ['{0EB34DC9-9F91-41E1-8639-95CD5943906B}']
    /// <summary>
    /// Print the current web page asynchronously to the specified printer with the provided settings.
    /// See `ICoreWebView2PrintSettings` for description of settings. Passing
    /// nullptr for `printSettings` results in default print settings used.
    ///
    /// The handler will return `errorCode` as `S_OK` and `printStatus` as COREWEBVIEW2_PRINT_STATUS_PRINTER_UNAVAILABLE
    /// if `printerName` doesn't match with the name of any installed printers on the user OS. The handler
    /// will return `errorCode` as `E_INVALIDARG` and `printStatus` as COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR
    /// if the caller provides invalid settings for a given printer.
    ///
    /// The async `Print` operation completes when it finishes printing to the printer.
    /// At this time the `ICoreWebView2PrintCompletedHandler` is invoked.
    /// Only one `Printing` operation can be in progress at a time. If `Print` is called while a `Print` or `PrintToPdf`
    /// or `PrintToPdfStream` or `ShowPrintUI` job is in progress, the completed handler is immediately invoked
    /// with `E_ABORT` and `printStatus` is COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR.
    /// This is only for printing operation on one webview.
    ///
    /// |       errorCode     |      printStatus                              |               Notes                                                                           |
    /// | --- | --- | --- |
    /// |        S_OK         | COREWEBVIEW2_PRINT_STATUS_SUCCEEDED           | Print operation succeeded.                                                                    |
    /// |        S_OK         | COREWEBVIEW2_PRINT_STATUS_PRINTER_UNAVAILABLE | If specified printer is not found or printer status is not available, offline or error state. |
    /// |        S_OK         | COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR         | Print operation is failed.                                                                    |
    /// |     E_INVALIDARG    | COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR         | If the caller provides invalid settings for the specified printer.                            |
    /// |       E_ABORT       | COREWEBVIEW2_PRINT_STATUS_OTHER_ERROR         | Print operation is failed as printing job already in progress.                                |
    ///
    /// \snippet AppWindow.cpp PrintToPrinter
    /// </summary>
    function Print(const printSettings: ICoreWebView2PrintSettings; 
                   const handler: ICoreWebView2PrintCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Opens the print dialog to print the current web page. See `COREWEBVIEW2_PRINT_DIALOG_KIND`
    /// for descriptions of print dialog kinds.
    ///
    /// Invoking browser or system print dialog doesn't open new print dialog if
    /// it is already open.
    ///
    /// \snippet AppWindow.cpp ShowPrintUI
    /// </summary>
    function ShowPrintUI(printDialogKind: COREWEBVIEW2_PRINT_DIALOG_KIND): HResult; stdcall;
    /// <summary>
    /// Provides the Pdf data of current web page asynchronously for the provided settings.
    /// Stream will be rewound to the start of the pdf data.
    ///
    /// See `ICoreWebView2PrintSettings` for description of settings. Passing
    /// nullptr for `printSettings` results in default print settings used.
    ///
    /// The async `PrintToPdfStream` operation completes when it finishes
    /// writing to the stream. At this time the `ICoreWebView2PrintToPdfStreamCompletedHandler`
    /// is invoked. Only one `Printing` operation can be in progress at a time. If
    /// `PrintToPdfStream` is called while a `PrintToPdfStream` or `PrintToPdf` or `Print`
    /// or `ShowPrintUI` job is in progress, the completed handler is immediately invoked with `E_ABORT`.
    /// This is only for printing operation on one webview.
    ///
    /// \snippet AppWindow.cpp PrintToPdfStream
    /// </summary>
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
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; result_: COREWEBVIEW2_PRINT_STATUS): HResult; stdcall;
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
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: IStream): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of ICoreWebView2_16 that supports shared buffer based on file mapping.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_17">See the ICoreWebView2_17 article.</see></para>
  /// </remarks>
  ICoreWebView2_17 = interface(ICoreWebView2_16)
    ['{702E75D4-FD44-434D-9D70-1A68A6B1192A}']
    /// <summary>
    /// Share a shared buffer object with script of the main frame in the WebView.
    /// The script will receive a `sharedbufferreceived` event from chrome.webview.
    /// The event arg for that event will have the following methods and properties:
    ///   `getBuffer()`: return an ArrayBuffer object with the backing content from the shared buffer.
    ///   `additionalData`: an object as the result of parsing `additionalDataAsJson` as JSON string.
    ///           This property will be `undefined` if `additionalDataAsJson` is nullptr or empty string.
    ///   `source`: with a value set as `chrome.webview` object.
    /// If a string is provided as `additionalDataAsJson` but it is not a valid JSON string,
    /// the API will fail with `E_INVALIDARG`.
    /// If `access` is COREWEBVIEW2_SHARED_BUFFER_ACCESS_READ_ONLY, the script will only have read access to the buffer.
    /// If the script tries to modify the content in a read only buffer, it will cause an access
    /// violation in WebView renderer process and crash the renderer process.
    /// If the shared buffer is already closed, the API will fail with `RO_E_CLOSED`.
    ///
    /// The script code should call `chrome.webview.releaseBuffer` with
    /// the shared buffer as the parameter to release underlying resources as soon
    /// as it does not need access to the shared buffer any more.
    ///
    /// The application can post the same shared buffer object to multiple web pages or iframes, or
    /// post to the same web page or iframe multiple times. Each `PostSharedBufferToScript` will
    /// create a separate ArrayBuffer object with its own view of the memory and is separately
    /// released. The underlying shared memory will be released when all the views are released.
    ///
    /// For example, if we want to send data to script for one time read only consumption.
    ///
    /// \snippet ScenarioSharedBuffer.cpp OneTimeShareBuffer
    ///
    /// In the HTML document,
    ///
    /// \snippet assets\ScenarioSharedBuffer.html ShareBufferScriptCode_1
    ///
    /// \snippet assets\ScenarioSharedBuffer.html ShareBufferScriptCode_2
    ///
    /// Sharing a buffer to script has security risk. You should only share buffer with trusted site.
    /// If a buffer is shared to a untrusted site, possible sensitive information could be leaked.
    /// If a buffer is shared as modifiable by the script and the script modifies it in an unexpected way,
    /// it could result in corrupted data that might even crash the application.
    /// </summary>
    function PostSharedBufferToScript(const sharedBuffer: ICoreWebView2SharedBuffer;
                                      access: COREWEBVIEW2_SHARED_BUFFER_ACCESS; 
                                      additionalDataAsJson: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// The shared buffer object that is created by [CreateSharedBuffer](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment12#createsharedbuffer).
  /// The object is presented to script as ArrayBuffer when posted to script with
  /// [PostSharedBufferToScript](/microsoft-edge/webview2/reference/win32/icorewebview2_17#postsharedbuffertoscript).
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2sharedbuffer">See the ICoreWebView2SharedBuffer article.</see></para>
  /// </remarks>
  ICoreWebView2SharedBuffer = interface(IUnknown)
    ['{B747A495-0C6F-449E-97B8-2F81E9D6AB43}']
    /// <summary>
    /// The size of the shared buffer in bytes.
    /// </summary>
    function Get_Size(out value: Largeuint): HResult; stdcall;
    /// <summary>
    /// The memory address of the shared buffer.
    /// </summary>
	  {* out value: PByte1 --> out value: PByte    ************** WEBVIEW4DELPHI ************** *}
    function Get_Buffer(out value: PByte): HResult; stdcall;
    /// <summary>
    /// Get an IStream object that can be used to access the shared buffer.
    /// </summary>
    function OpenStream(out value: IStream): HResult; stdcall;
    /// <summary>
    /// Returns a handle to the file mapping object that backs this shared buffer.
    /// The returned handle is owned by the shared buffer object. You should not
    /// call CloseHandle on it.
    /// Normal app should use `Buffer` or `OpenStream` to get memory address
    /// or IStream object to access the buffer.
    /// For advanced scenarios, you could use file mapping APIs to obtain other views
    /// or duplicate this handle to another application process and create a view from
    /// the duplicated handle in that process to access the buffer from that separate process.
    /// </summary>
	  {* out value: Pointer --> out value: HANDLE    ************** WEBVIEW4DELPHI ************** *}
    function Get_FileMappingHandle(out value: HANDLE): HResult; stdcall;
    /// <summary>
    /// Release the backing shared memory. The application should call this API when no
    /// access to the buffer is needed any more, to ensure that the underlying resources
    /// are released timely even if the shared buffer object itself is not released due to
    /// some leaked reference.
    /// After the shared buffer is closed, the buffer address and file mapping handle previously
    /// obtained becomes invalid and cannot be used anymore. Accessing properties of the object
    /// will fail with `RO_E_CLOSED`. Operations like Read or Write on the IStream objects returned
    /// from `OpenStream` will fail with `RO_E_CLOSED`. `PostSharedBufferToScript` will also
    /// fail with `RO_E_CLOSED`.
    ///
    /// The script code should call `chrome.webview.releaseBuffer` with
    /// the shared buffer as the parameter to release underlying resources as soon
    /// as it does not need access the shared buffer any more.
    /// When script tries to access the buffer after calling `chrome.webview.releaseBuffer`,
    /// JavaScript `TypeError` exception will be raised complaining about accessing a
    /// detached ArrayBuffer, the same exception when trying to access a transferred ArrayBuffer.
    ///
    /// Closing the buffer object on native side doesn't impact access from Script and releasing
    /// the buffer from script doesn't impact access to the buffer from native side.
    /// The underlying shared memory will be released by the OS when both native and script side
    /// release the buffer.
    /// </summary>
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
    /// <summary>
    /// Adds an event handler for the `LaunchingExternalUriScheme` event.
    /// The `LaunchingExternalUriScheme` event is raised when a navigation request is made to
    /// a URI scheme that is registered with the OS.
    /// The `LaunchingExternalUriScheme` event handler may suppress the default dialog
    /// or replace the default dialog with a custom dialog.
    ///
    /// If a deferral is not taken on the event args, the external URI scheme launch is
    /// blocked until the event handler returns.  If a deferral is taken, the
    /// external URI scheme launch is blocked until the deferral is completed.
    /// The host also has the option to cancel the URI scheme launch.
    ///
    /// The `NavigationStarting` and `NavigationCompleted` events will be raised,
    /// regardless of whether the `Cancel` property is set to `TRUE` or
    /// `FALSE`. The `NavigationCompleted` event will be raised with the `IsSuccess` property
    /// set to `FALSE` and the `WebErrorStatus` property set to `ConnectionAborted` regardless of
    /// whether the host sets the `Cancel` property on the
    /// `ICoreWebView2LaunchingExternalUriSchemeEventArgs`. The `SourceChanged`, `ContentLoading`,
    /// and `HistoryChanged` events will not be raised for this navigation to the external URI
    /// scheme regardless of the `Cancel` property.
    /// The `LaunchingExternalUriScheme` event will be raised after the
    /// `NavigationStarting` event and before the `NavigationCompleted` event.
    /// The default `CoreWebView2Settings` will also be updated upon navigation to an external
    /// URI scheme. If a setting on the `CoreWebView2Settings` interface has been changed,
    /// navigating to an external URI scheme will trigger the `CoreWebView2Settings` to update.
    ///
    /// The WebView2 may not display the default dialog based on user settings, browser settings,
    /// and whether the origin is determined as a
    /// [trustworthy origin](https://w3c.github.io/webappsec-secure-contexts#
    /// potentially-trustworthy-origin); however, the event will still be raised.
    ///
    /// If the request is initiated by a cross-origin frame without a user gesture,
    /// the request will be blocked and the `LaunchingExternalUriScheme` event will not
    /// be raised.
    ///
    /// \snippet SettingsComponent.cpp ToggleLaunchingExternalUriScheme
    /// </summary>
    function add_LaunchingExternalUriScheme(const eventHandler: ICoreWebView2LaunchingExternalUriSchemeEventHandler; 
                                            out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with
    /// `add_LaunchingExternalUriScheme`.
    /// </summary>
    function remove_LaunchingExternalUriScheme(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `LaunchingExternalUriScheme` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2launchingexternalurischemeeventhandler">See the ICoreWebView2LaunchingExternalUriSchemeEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2LaunchingExternalUriSchemeEventHandler = interface(IUnknown)
    ['{74F712E0-8165-43A9-A13F-0CCE597E75DF}']
    /// <summary>
    /// Receives the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The URI with the external URI scheme to be launched.
    /// </summary>
    function Get_uri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// <para>The origin initiating the external URI scheme launch.
    /// The origin will be an empty string if the request is initiated by calling
    /// `CoreWebView2.Navigate` on the external URI scheme. If a script initiates
    /// the navigation, the `InitiatingOrigin` will be the top-level document's
    /// `Source`, for example, if `window.location` is set to `"calculator://"`, the
    /// `InitiatingOrigin` will be set to `calculator://`. If the request is initiated
    ///  from a child frame, the `InitiatingOrigin` will be the source of that child frame.</para>
    /// <para>If the `InitiatingOrigin` is
    /// [opaque](https://html.spec.whatwg.org/multipage/origin.html#concept-origin-opaque),
    /// the `InitiatingOrigin` reported in the event args will be its precursor origin.
    /// The precursor origin is the origin that created the opaque origin. For example, if
    /// a frame on example.com opens a subframe with a different opaque origin, the subframe's
    /// precursor origin is example.com.</para>
    /// </summary>
    function Get_InitiatingOrigin(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// `TRUE` when the external URI scheme request was initiated through a user gesture.
    ///
    /// \> [!NOTE]\n\> Being initiated through a user gesture does not mean that user intended
    /// to access the associated resource.
    /// </summary>
    function Get_IsUserInitiated(out value: Integer): HResult; stdcall;
    /// <summary>
    /// The event handler may set this property to `TRUE` to cancel the external URI scheme
    /// launch. If set to `TRUE`, the external URI scheme will not be launched, and the default
    /// dialog is not displayed. This property can be used to replace the normal
    /// handling of launching an external URI scheme.
    /// The initial value of the `Cancel` property is `FALSE`.
    /// </summary>
    function Get_Cancel(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Cancel` property.
    /// </summary>
    function Set_Cancel(value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object.  Use this operation to
    /// complete the event at a later time.
    /// </summary>
    function GetDeferral(out value: ICoreWebView2Deferral): HResult; stdcall;
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
    /// <summary>
    /// `MemoryUsageTargetLevel` indicates desired memory consumption level of
    /// WebView.
    /// </summary>
    function Get_MemoryUsageTargetLevel(out value: COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL): HResult; stdcall;
    /// <summary>
    /// An app may set `MemoryUsageTargetLevel` to indicate desired memory
    /// consumption level of WebView. Scripts will not be impacted and continue
    /// to run. This is useful for inactive apps that still want to run scripts
    /// and/or keep network connections alive and therefore could not call
    /// `TrySuspend` and `Resume` to reduce memory consumption. These apps can
    /// set memory usage target level to `COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_LOW`
    /// when the app becomes inactive, and set back to
    /// `COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_NORMAL` when the app becomes
    /// active. It is not necessary to set CoreWebView2Controller's IsVisible
    /// property to false when setting the property.
    /// It is a best effort operation to change memory usage level, and the
    /// API will return before the operation completes.
    /// Setting the level to `COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_LOW`
    /// could potentially cause memory for some WebView browser processes to be
    /// swapped out to disk in some circumstances.
    /// It is a best effort to reduce memory usage as much as possible. If a script
    /// runs after its related memory has been swapped out, the memory will be swapped
    /// back in to ensure the script can still run, but performance might be impacted.
    /// Therefore, the app should set the level back to
    /// `COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL_NORMAL` when the app becomes
    /// active again. Setting memory usage target level back to normal will not happen
    /// automatically.
    /// An app should choose to use either the combination of `TrySuspend` and `Resume`
    /// or the combination of setting MemoryUsageTargetLevel to low and normal. It is
    /// not advisable to mix them.
    /// Trying to set `MemoryUsageTargetLevel` while suspended will be ignored.
    /// The `TrySuspend` and `Resume` methods will change the `MemoryUsageTargetLevel`.
    /// `TrySuspend` will automatically set `MemoryUsageTargetLevel` to low while
    /// `Resume` on suspended WebView will automatically set `MemoryUsageTargetLevel`
    /// to normal. Calling `Resume` when the WebView is not suspended would not change
    /// `MemoryUsageTargetLevel`.
    ///
    /// \snippet ViewComponent.cpp MemoryUsageTargetLevel
    /// </summary>
    function Set_MemoryUsageTargetLevel(value: COREWEBVIEW2_MEMORY_USAGE_TARGET_LEVEL): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of `ICoreWebView2_19` that provides the `FrameId` property.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_20">See the ICoreWebView2_20 article.</see></para>
  /// </remarks>
  ICoreWebView2_20 = interface(ICoreWebView2_19)
    ['{B4BC1926-7305-11EE-B962-0242AC120002}']
    /// <summary>
    /// The unique identifier of the main frame. It's the same kind of ID as
    /// with the `FrameId` in `CoreWebView2Frame` and via `CoreWebView2FrameInfo`.
    /// Note that `FrameId` may not be valid if `CoreWebView2` has not done
    /// any navigation. It's safe to get this value during or after the first
    /// `ContentLoading` event. Otherwise, it could return the invalid frame Id 0.
    /// </summary>
    function Get_FrameId(out value: SYSUINT): HResult; stdcall;
  end;

  /// <summary>
  /// This is the interface for getting string and exception with ExecuteScriptWithResult.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_21">See the ICoreWebView2_21 article.</see></para>
  /// </remarks>
  ICoreWebView2_21 = interface(ICoreWebView2_20)
    ['{C4980DEA-587B-43B9-8143-3EF3BF552D95}']
    /// <summary>
    /// Run JavaScript code from the JavaScript parameter in the current
    /// top-level document rendered in the WebView.
    /// The result of the execution is returned asynchronously in the CoreWebView2ExecuteScriptResult object
    /// which has methods and properties to obtain the successful result of script execution as well as any
    /// unhandled JavaScript exceptions.
    /// If this method is
    /// run after the NavigationStarting event during a navigation, the script
    /// runs in the new document when loading it, around the time
    /// ContentLoading is run. This operation executes the script even if
    /// ICoreWebView2Settings::IsScriptEnabled is set to FALSE.
    ///
    /// \snippet ScriptComponent.cpp ExecuteScriptWithResult
    /// </summary>
    function ExecuteScriptWithResult(javaScript: PWideChar;
                                     const handler: ICoreWebView2ExecuteScriptWithResultCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `ExecuteScriptWithResult` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2executescriptwithresultcompletedhandler">See the ICoreWebView2ExecuteScriptWithResultCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ExecuteScriptWithResultCompletedHandler = interface(IUnknown)
    ['{1BB5317B-8238-4C67-A7FF-BAF6558F289D}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result: ICoreWebView2ExecuteScriptResult): HResult; stdcall;
  end;

  /// <summary>
  /// This is the result for ExecuteScriptWithResult.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2executescriptresult">See the ICoreWebView2ExecuteScriptResult article.</see></para>
  /// </remarks>
  ICoreWebView2ExecuteScriptResult = interface(IUnknown)
    ['{0CE15963-3698-4DF7-9399-71ED6CDD8C9F}']
    /// <summary>
    /// This property is true if ExecuteScriptWithResult successfully executed script with
    /// no unhandled exceptions and the result is available in the ResultAsJson property
    /// or via the TryGetResultAsString method.
    /// If it is false then the script execution had an unhandled exception which you
    /// can get via the Exception property.
    /// </summary>
    function Get_Succeeded(out value: Integer): HResult; stdcall;
    /// <summary>
    /// A function that has no explicit return value returns undefined. If the
    /// script that was run throws an unhandled exception, then the result is
    /// also "null". This method is applied asynchronously. If the method is
    /// run before `ContentLoading`, the script will not be executed
    /// and the string "null" will be returned.
    /// The return value description is as follows
    /// 1. S_OK: Execution succeeds.
    /// 2. E_POINTER: When the `jsonResult` is nullptr.
    /// </summary>
    function Get_ResultAsJson(out jsonResult: PWideChar): HResult; stdcall;
    /// <summary>
    /// If Succeeded is true and the result of script execution is a string, this method provides the value of the string result,
    /// and we will get the `FALSE` var value when the js result is not string type.
    /// The return value description is as follows
    /// 1. S_OK: Execution succeeds.
    /// 2. E_POINTER: When the `stringResult` or `value` is nullptr.
    /// NOTE: If the `value` returns `FALSE`, the `stringResult` will be set to a empty string.
    /// </summary>
    function TryGetResultAsString(out stringResult: PWideChar; out value: Integer): HResult; stdcall;
    /// <summary>
    /// If Succeeded is false, you can use this property to get the unhandled exception thrown by script execution
    /// Note that due to the compatibility of the WinRT/.NET interface,
    /// S_OK will be returned even if the acquisition fails.
    /// We can determine whether the acquisition is successful by judging whether the `exception` is nullptr.
    /// </summary>
    function Get_Exception(out Exception: ICoreWebView2ScriptException): HResult; stdcall;
  end;

  /// <summary>
  /// This interface represents a JavaScript exception.
  /// If the CoreWebView2.ExecuteScriptWithResult result has Succeeded as false,
  /// you can use the result's Exception property to get the script exception.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptexception">See the ICoreWebView2ScriptException article.</see></para>
  /// </remarks>
  ICoreWebView2ScriptException = interface(IUnknown)
    ['{054DAE00-84A3-49FF-BC17-4012A90BC9FD}']
    /// <summary>
    /// The line number of the source where the exception occurred.
    /// In the JSON it is `exceptionDetail.lineNumber`.
    /// Note that this position starts at 0.
    /// </summary>
    function Get_LineNumber(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// The column number of the source where the exception occurred.
    /// In the JSON it is `exceptionDetail.columnNumber`.
    /// Note that this position starts at 0.
    /// </summary>
    function Get_ColumnNumber(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// The Name is the exception's class name.
    /// In the JSON it is `exceptionDetail.exception.className`.
    /// This is the empty string if the exception doesn't have a class name.
    /// This can happen if the script throws a non-Error object such as `throw "abc";`
    /// </summary>
    function Get_name(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The Message is the exception's message and potentially stack.
    /// In the JSON it is exceptionDetail.exception.description.
    /// This is the empty string if the exception doesn't have a description.
    /// This can happen if the script throws a non-Error object such as throw "abc";.
    /// </summary>
    function Get_Message(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// This will return all details of the exception as a JSON string.
    /// In the case that script has thrown a non-Error object such as `throw "abc";`
    /// or any other non-Error object, you can get object specific properties.
    /// </summary>
    function Get_ToJson(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of `ICoreWebView2` that allows to
  /// set filters in order to receive WebResourceRequested events for
  /// service workers, shared workers and different origin iframes.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_22">See the ICoreWebView2_22 article.</see></para>
  /// </remarks>
  ICoreWebView2_22 = interface(ICoreWebView2_21)
    ['{DB75DFC7-A857-4632-A398-6969DDE26C0A}']
    /// <summary>
    /// A web resource request with a resource context that matches this
    /// filter's resource context and a URI that matches this filter's URI
    /// wildcard string for corresponding request sources will be raised via
    /// the `WebResourceRequested` event. To receive all raised events filters
    /// have to be added before main page navigation.
    ///
    /// The `uri` parameter value is a wildcard string matched against the URI
    /// of the web resource request. This is a glob style
    /// wildcard string in which a `*` matches zero or more characters and a `?`
    /// matches exactly one character.
    /// These wildcard characters can be escaped using a backslash just before
    /// the wildcard character in order to represent the literal `*` or `?`.
    ///
    /// The matching occurs over the URI as a whole string and not limiting
    /// wildcard matches to particular parts of the URI.
    /// The wildcard filter is compared to the URI after the URI has been
    /// normalized, any URI fragment has been removed, and non-ASCII hostnames
    /// have been converted to punycode.
    ///
    /// Specifying a `nullptr` for the uri is equivalent to an empty string which
    /// matches no URIs.
    ///
    /// For more information about resource context filters, navigate to
    /// [COREWEBVIEW2_WEB_RESOURCE_CONTEXT](/microsoft-edge/webview2/reference/win32/icorewebview2#corewebview2_web_resource_context).
    ///
    /// The `requestSourceKinds` is a mask of one or more
    /// `COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS`. OR operation(s) can be
    /// applied to multiple `COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS` to
    /// create a mask representing those data types. API returns `E_INVALIDARG` if
    /// `requestSourceKinds` equals to zero. For more information about request
    /// source kinds, navigate to
    /// [COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS](/microsoft-edge/webview2/reference/win32/icorewebview2#corewebview2_web_resource_request_source_kinds).
    ///
    /// Because service workers and shared workers run separately from any one
    /// HTML document their WebResourceRequested will be raised for all
    /// CoreWebView2s that have appropriate filters added in the corresponding
    /// CoreWebView2Environment. You should only add a WebResourceRequested filter
    /// for COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SERVICE_WORKER or
    /// COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_SHARED_WORKER on
    /// one CoreWebView2 to avoid handling the same WebResourceRequested
    /// event multiple times.
    ///
    /// | URI Filter String | Request URI | Match | Notes |
    /// | ---- | ---- | ---- | ---- |
    /// | `*` | `https://contoso.com/a/b/c` | Yes | A single * will match all URIs |
    /// | `*://contoso.com/*` | `https://contoso.com/a/b/c` | Yes | Matches everything in contoso.com across all schemes |
    /// | `*://contoso.com/*` | `https://example.com/?https://contoso.com/` | Yes | But also matches a URI with just the same text anywhere in the URI |
    /// | `example` | `https://contoso.com/example` | No | The filter does not perform partial matches |
    /// | `*example` | `https://contoso.com/example` | Yes | The filter matches across URI parts |
    /// | `*example` | `https://contoso.com/path/?example` | Yes | The filter matches across URI parts |
    /// | `*example` | `https://contoso.com/path/?query#example` | No | The filter is matched against the URI with no fragment |
    /// | `*example` | `https://example` | No | The URI is normalized before filter matching so the actual URI used for comparison is `https://example/` |
    /// | `*example/` | `https://example` | Yes | Just like above, but this time the filter ends with a / just like the normalized URI |
    /// | `https://xn--qei.example/` | `https://&#x2764;.example/` | Yes | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
    /// | `https://&#x2764;.example/` | `https://xn--qei.example/` | No | Non-ASCII hostnames are normalized to punycode before wildcard comparison |
    ///
    /// \snippet ScenarioSharedWorkerWRR.cpp WebResourceRequested2
    /// </summary>
    function AddWebResourceRequestedFilterWithRequestSourceKinds(uri: PWideChar;
                                                                 ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT;
                                                                 requestSourceKinds: COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS): HResult; stdcall;
    /// <summary>
    /// Removes a matching WebResource filter that was previously added for the
    /// `WebResourceRequested` event.  If the same filter was added multiple
    /// times, then it must be removed as many times as it was added for the
    /// removal to be effective. Returns `E_INVALIDARG` for a filter that was
    /// not added or is already removed.
    /// If the filter was added for multiple requestSourceKinds and removed just for one of them
    /// the filter remains for the non-removed requestSourceKinds.
    /// </summary>
    function RemoveWebResourceRequestedFilterWithRequestSourceKinds(uri: PWideChar;
                                                                    ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT;
                                                                    requestSourceKinds: COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView_23 interface for
  /// PostWebMessageAsJsonWithAdditionalObjects.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_23">See the ICoreWebView2_23 article.</see></para>
  /// </remarks>
  ICoreWebView2_23 = interface(ICoreWebView2_22)
    ['{508F0DB5-90C4-5872-90A7-267A91377502}']
    /// <summary>
    /// Same as `PostWebMessageAsJson`, but also has support for posting DOM objects
    /// to page content. The `additionalObjects` property in the DOM MessageEvent
    /// fired on the page content is an array-like list of DOM objects that can
    /// be posted to the web content. Currently these can be the following
    /// types of objects:
    ///
    /// | Win32             | DOM type    |
    /// |-------------------|-------------|
    /// | ICoreWebView2FileSystemHandle | [FileSystemHandle](https://developer.mozilla.org/docs/Web/API/FileSystemHandle) |
    /// | nullptr           | null        |
    ///
    /// The objects are posted to the web content, following the
    /// [structured-clone](https://developer.mozilla.org/docs/Web/API/Web_Workers_API/Structured_clone_algorithm)
    /// semantics, meaning only objects that can be cloned can be posted.
    /// They will also behave as if they had been created by the web content they are
    /// posted to. For example, if a FileSystemFileHandle is posted to a web content
    /// it can only be re-transferred via postMessage to other web content
    /// [with the same origin](https://fs.spec.whatwg.org/#filesystemhandle).
    /// Warning: An app needs to be mindful when using this API to post DOM objects
    /// as this API provides the web content with unusual access to sensitive Web
    /// Platform features such as filesystem access! Similar to PostWebMessageAsJson
    /// the app should check the `Source` property of WebView2 right before posting the message
    /// to ensure the message and objects will only be sent to the target web content
    /// that it expects to receive the DOM objects. Additionally, the order
    /// of messages that are posted between `PostWebMessageAsJson` and `PostWebMessageAsJsonWithAdditionalObjects`
    /// may not be preserved.
    /// \snippet ScenarioFileSystemHandleShare.cpp PostWebMessageWithAdditionalObjects
    /// </summary>
    function PostWebMessageAsJsonWithAdditionalObjects(webMessageAsJson: PWideChar;
                                                       const additionalObjects: ICoreWebView2ObjectCollectionView): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView2_24 interface that manages WebView2 Web
  /// Notification functionality.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_24">See the ICoreWebView2_24 article.</see></para>
  /// </remarks>
  ICoreWebView2_24 = interface(ICoreWebView2_23)
    ['{39A7AD55-4287-5CC1-88A1-C6F458593824}']
    /// <summary>
    /// Adds an event handler for the `NotificationReceived` event for
    /// non-persistent notifications.
    ///
    /// If a deferral is not taken on the event args, the subsequent scripts after
    /// the DOM notification creation call (i.e. `Notification()`) are blocked
    /// until the event handler returns. If a deferral is taken, the scripts are
    /// blocked until the deferral is completed.
    /// </summary>
    function add_NotificationReceived(const eventHandler: ICoreWebView2NotificationReceivedEventHandler;
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_NotificationReceived`.
    /// </summary>
    function remove_NotificationReceived(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `NotificationReceived` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notificationreceivedeventhandler">See the ICoreWebView2NotificationReceivedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NotificationReceivedEventHandler = interface(IUnknown)
    ['{89C5D598-8788-423B-BE97-E6E01C0F9EE3}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2;
                    const args: ICoreWebView2NotificationReceivedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the `NotificationReceived` event.
  /// \snippet ScenarioNotificationReceived.cpp NotificationReceived
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notificationreceivedeventargs">See the ICoreWebView2NotificationReceivedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2NotificationReceivedEventArgs = interface(IUnknown)
    ['{1512DD5B-5514-4F85-886E-21C3A4C9CFE6}']
    /// <summary>
    /// The origin of the web content that sends the notification, such as
    /// `https://example.com/` or `https://www.example.com/`.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_SenderOrigin(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The notification that was received. You can access the
    /// properties on the Notification object to show your own notification.
    /// </summary>
    function Get_Notification(out value: ICoreWebView2Notification): HResult; stdcall;
    /// <summary>
    /// Sets whether the `NotificationReceived` event is handled by the host after
    /// the event handler completes or if there is a deferral then after the
    /// deferral is completed.
    ///
    /// If `Handled` is set to TRUE then WebView will not display the notification
    /// with the default UI, and the host will be responsible for handling the
    /// notification and for letting the web content know that the notification
    /// has been displayed, clicked, or closed. You must set `Handled` to `TRUE`
    /// before you call `ReportShown`, `ReportClicked`,
    /// `ReportClickedWithActionIndex` and `ReportClosed`, otherwise they will
    /// fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`. If after the event
    /// handler or deferral completes `Handled` is set to FALSE then WebView will
    /// display the default notification UI. Note that you cannot un-handle this
    /// event once you have set `Handled` to be `TRUE`. The initial value is
    /// FALSE.
    /// </summary>
    function Set_Handled(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets whether the `NotificationReceived` event is handled by host.
    /// </summary>
    function Get_Handled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. Use this operation to complete
    /// the event at a later time.
    /// </summary>
    function GetDeferral(out deferral: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView2Notification that represents a [HTML Notification
  /// object](https://developer.mozilla.org/docs/Web/API/Notification).
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification">See the ICoreWebView2Notification article.</see></para>
  /// </remarks>
  ICoreWebView2Notification = interface(IUnknown)
    ['{B7434D98-6BC8-419D-9DA5-FB5A96D4DACD}']
    /// <summary>
    /// Add an event handler for the `CloseRequested` event. This event is raised
    /// when the notification is closed by the web code, such as through
    /// `notification.close()`. You don't need to call `ReportClosed` since this is
    /// coming from the web code.
    /// </summary>
    function add_CloseRequested(const eventHandler: ICoreWebView2NotificationCloseRequestedEventHandler;
                                out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_CloseRequested`.
    /// </summary>
    function remove_CloseRequested(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// The host may run this to report the notification has been displayed and it
    /// will cause the
    /// [show](https://developer.mozilla.org/docs/Web/API/Notification/show_event)
    /// event to be raised for non-persistent notifications. You must not run this
    /// unless you are handling the `NotificationReceived` event. Returns
    /// `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `Handled` is `FALSE` when
    /// this is called.
    /// </summary>
    function ReportShown: HResult; stdcall;
    /// <summary>
    /// The host may run this to report the notification has been clicked, and it
    /// will cause the
    /// [click](https://developer.mozilla.org/docs/Web/API/Notification/click_event)
    /// event to be raised for non-persistent notifications and the
    /// [notificationclick](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/notificationclick_event)
    /// event for persistent notifications. Use `ReportClickedWithActionIndex` to
    /// specify an action to activate a persistent notification. You must not run
    /// this unless you are handling the `NotificationReceived` event. Returns
    /// `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `Handled` is `FALSE` or
    /// `ReportShown` has not been run when this is called.
    /// </summary>
    function ReportClicked: HResult; stdcall;
    /// <summary>
    /// The host may run this to report the notification was dismissed, and it
    /// will cause the
    /// [close](https://developer.mozilla.org/docs/Web/API/Notification/close_event)
    /// event to be raised for non-persistent notifications and the
    /// [notificationclose](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/notificationclose_event)
    /// event for persistent notifications. You must not run this unless you are
    /// handling the `NotificationReceived` event. Returns
    /// `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `Handled` is `FALSE` or
    /// `ReportShown` has not been run when this is called.
    /// </summary>
    function ReportClosed: HResult; stdcall;
    /// <summary>
    /// A string representing the body text of the notification.
    /// The default value is an empty string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Body(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The text direction in which to display the notification.
    /// This corresponds to
    /// [Notification.dir](https://developer.mozilla.org/docs/Web/API/Notification/dir)
    /// DOM API.
    /// The default value is `COREWEBVIEW2_TEXT_DIRECTION_KIND_DEFAULT`.
    /// </summary>
    function Get_Direction(out value: COREWEBVIEW2_TEXT_DIRECTION_KIND): HResult; stdcall;
    /// <summary>
    /// The notification's language, as intended to be specified using a string
    /// representing a language tag (such as `en-US`) according to
    /// [BCP47](https://datatracker.ietf.org/doc/html/rfc5646). Note that no
    /// validation is performed on this property and it can be any string the
    /// notification sender specifies.
    /// This corresponds to
    /// [Notification.lang](https://developer.mozilla.org/docs/Web/API/Notification/lang)
    /// DOM API.
    /// The default value is an empty string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Language(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// A string representing an identifying tag for the notification.
    /// This corresponds to
    /// [Notification.tag](https://developer.mozilla.org/docs/Web/API/Notification/tag)
    /// DOM API.
    /// The default value is an empty string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Tag(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// A string containing the URI of an icon to be displayed in the
    /// notification.
    /// The default value is an empty string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_IconUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The title of the notification.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_title(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// A string containing the URI of the image used to represent the
    /// notification when there isn't enough space to display the notification
    /// itself.
    /// The default value is an empty string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_BadgeUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// A string containing the URI of an image to be displayed in the
    /// notification.
    /// The default value is an empty string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_BodyImageUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Indicates whether the user should be notified after a new notification
    /// replaces an old one.
    /// This corresponds to
    /// [Notification.renotify](https://developer.mozilla.org/docs/Web/API/Notification/renotify)
    /// DOM API.
    /// The default value is `FALSE`.
    /// </summary>
    function Get_ShouldRenotify(out value: Integer): HResult; stdcall;
    /// <summary>
    /// A boolean value indicating that a notification should remain active until
    /// the user clicks or dismisses it, rather than closing automatically.
    /// This corresponds to
    /// [Notification.requireInteraction](https://developer.mozilla.org/docs/Web/API/Notification/requireInteraction)
    /// DOM API. Note that you may not be able to necessarily implement this due to native API limitations.
    /// The default value is `FALSE`.
    /// </summary>
    function Get_RequiresInteraction(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Indicates whether the notification should be silent -- i.e., no sounds or
    /// vibrations should be issued, regardless of the device settings.
    /// This corresponds to
    /// [Notification.silent](https://developer.mozilla.org/docs/Web/API/Notification/silent)
    /// DOM API.
    /// The default value is `FALSE`.
    /// </summary>
    function Get_IsSilent(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Indicates the time at which a notification is created or applicable (past,
    /// present, or future) as the number of milliseconds since the UNIX epoch.
    /// </summary>
    function Get_Timestamp(out value: Double): HResult; stdcall;
    /// <summary>
    /// Gets the vibration pattern for devices with vibration hardware to emit.
    /// The vibration pattern can be represented by an array of 64-bit unsigned integers
    /// describing a pattern of vibrations and pauses. See [Vibration
    /// API](https://developer.mozilla.org/docs/Web/API/Vibration_API) for more
    /// information.
    /// This corresponds to
    /// [Notification.vibrate](https://developer.mozilla.org/docs/Web/API/Notification/vibrate)
    /// DOM API.
    /// An empty array is returned if no vibration patterns are
    /// specified.
    /// </summary>
    {* vibrationPattern: PLargeuint1 --> vibrationPattern: Uint64Array    ************** WEBVIEW4DELPHI ************** *}
    function GetVibrationPattern(out Count: SYSUINT; out vibrationPattern: Uint64Array): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `CloseRequested` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notificationcloserequestedeventhandler">See the ICoreWebView2NotificationCloseRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NotificationCloseRequestedEventHandler = interface(IUnknown)
    ['{47C32D23-1E94-4733-85F1-D9BF4ACD0974}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Notification; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView2_25 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25">See the ICoreWebView2_25 article.</see></para>
  /// </remarks>
  ICoreWebView2_25 = interface(ICoreWebView2_24)
    ['{B5A86092-DF50-5B4F-A17B-6C8F8B40B771}']
    /// <summary>
    /// Adds an event handler for the `SaveAsUIShowing` event.
    /// This event is raised when save as is triggered, programmatically or manually.
    ///
    /// \snippet ScenarioSaveAs.cpp ToggleSilent
    /// </summary>
    function add_SaveAsUIShowing(const eventHandler: ICoreWebView2SaveAsUIShowingEventHandler;
                                 out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_SaveAsUIShowing`.
    /// </summary>
    function remove_SaveAsUIShowing(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Programmatically trigger a Save As action for the currently loaded document.
    /// The `SaveAsUIShowing` event is raised.
    ///
    /// Opens a system modal dialog by default. If the `SuppressDefaultDialog` property
    /// is `TRUE`, the system dialog is not opened.
    ///
    /// This method returns `COREWEBVIEW2_SAVE_AS_UI_RESULT`. See
    /// `COREWEBVIEW2_SAVE_AS_UI_RESULT` for details.
    ///
    /// \snippet ScenarioSaveAs.cpp ProgrammaticSaveAs
    /// </summary>
    function ShowSaveAsUI(const handler: ICoreWebView2ShowSaveAsUICompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `SaveAsUIShowing` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2saveasuishowingeventhandler">See the ICoreWebView2SaveAsUIShowingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2SaveAsUIShowingEventHandler = interface(IUnknown)
    ['{6BAA177E-3A2E-5CCF-9A13-FAD676CD0522}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2; const args: ICoreWebView2SaveAsUIShowingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// The event args for `SaveAsUIShowing` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2saveasuishowingeventargs">See the ICoreWebView2SaveAsUIShowingEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2SaveAsUIShowingEventArgs = interface(IUnknown)
    ['{55902952-0E0D-5AAA-A7D0-E833CDB34F62}']
    /// <summary>
    /// Get the Mime type of content to be saved.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ContentMimeType(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `Cancel` property. Set this property to `TRUE` to cancel the Save As action
    /// and prevent the download from starting. ShowSaveAsUI returns
    /// `COREWEBVIEW2_SAVE_AS_UI_RESULT_CANCELLED` in this case. The default value is `FALSE`.
    /// </summary>
    function Set_Cancel(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the `Cancel` property.
    /// </summary>
    function Get_Cancel(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `SuppressDefaultDialog` property, which indicates whether the system
    /// default dialog is suppressed. When `SuppressDefaultDialog` is `FALSE`, the default
    /// Save As dialog is shown and the values assigned through `SaveAsFilePath`, `AllowReplace`
    /// and `Kind` are ignored when the event args invoke completed.
    ///
    /// Set `SuppressDefaultDialog` to `TRUE` to perform a silent Save As. When
    /// `SuppressDefaultDialog` is `TRUE`, the system dialog is skipped and the
    /// `SaveAsFilePath`, `AllowReplace` and `Kind` values are used.
    ///
    /// The default value is FALSE.
    /// </summary>
    function Set_SuppressDefaultDialog(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the `SuppressDefaultDialog` property.
    /// </summary>
    function Get_SuppressDefaultDialog(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. This will defer showing the
    /// default Save As dialog and performing the Save As operation.
    /// </summary>
    function GetDeferral(out value: ICoreWebView2Deferral): HResult; stdcall;
    /// <summary>
    /// Set the `SaveAsFilePath` property for Save As. `SaveAsFilePath` is an absolute path
    /// of the location. It includes the file name and extension. If `SaveAsFilePath` is not
    /// valid (for example, the root drive does not exist), Save As is denied and
    /// `COREWEBVIEW2_SAVE_AS_INVALID_PATH` is returned.
    ///
    /// If the associated download completes successfully, a target file is saved at
    /// this location. If the Kind property is `COREWEBVIEW2_SAVE_AS_KIND_COMPLETE`,
    /// there will be an additional directory with resources files.
    ///
    /// The default value is a system suggested path, based on users' local environment.
    /// </summary>
    function Set_SaveAsFilePath(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the `SaveAsFilePath` property.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_SaveAsFilePath(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// `AllowReplace` allows user to control what happens when a file already
    /// exists in the file path to which the Save As operation is saving.
    /// Setting this property to `TRUE` allows existing files to be replaced.
    /// Setting this property to `FALSE` will not replace existing files and will return
    /// `COREWEBVIEW2_SAVE_AS_UI_RESULT_FILE_ALREADY_EXISTS`.
    ///
    /// The default value is `FALSE`.
    /// </summary>
    function Set_AllowReplace(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the `AllowReplace` property.
    /// </summary>
    function Get_AllowReplace(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Kind` property to save documents of different kinds. See the
    /// `COREWEBVIEW2_SAVE_AS_KIND` enum for a description of the different options.
    /// If the kind is not allowed for the current document, ShowSaveAsUI returns
    /// `COREWEBVIEW2_SAVE_AS_UI_RESULT_KIND_NOT_SUPPORTED`.
    ///
    /// The default value is `COREWEBVIEW2_SAVE_AS_KIND_DEFAULT`.
    /// </summary>
    function Set_Kind(value: COREWEBVIEW2_SAVE_AS_KIND): HResult; stdcall;
    /// <summary>
    /// Gets the `Kind` property.
    /// </summary>
    function Get_Kind(out value: COREWEBVIEW2_SAVE_AS_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `ShowSaveAsUI` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2showsaveasuicompletedhandler">See the ICoreWebView2ShowSaveAsUICompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ShowSaveAsUICompletedHandler = interface(IUnknown)
    ['{E24B07E3-8169-5C34-994A-7F6478946A3C}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; result_: COREWEBVIEW2_SAVE_AS_UI_RESULT): HResult; stdcall;
  end;

  /// <summary>
  /// This is the ICoreWebView2_26 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_26">See the ICoreWebView2_26 article.</see></para>
  /// </remarks>
  ICoreWebView2_26 = interface(ICoreWebView2_25)
    ['{806268B8-F897-5685-88E5-C45FCA0B1A48}']
    /// <summary>
    /// Adds an event handler for the `SaveFileSecurityCheckStarting` event.
    /// This event will be raised during system FileTypePolicy
    /// checking the dangerous file extension list.
    ///
    /// Developers can specify their own logic for determining whether
    /// to allow a particular type of file to be saved from the document origin URI.
    /// Developers can also determine the save decision based on other criteria.
    ///
    /// Here are two properties in `ICoreWebView2SaveFileSecurityCheckStartingEventArgs`
    /// to manage the decision: `CancelSave` and `SuppressDefaultPolicy`.
    /// Table of Properties' value and result:
    ///
    /// | CancelSave | SuppressDefaultPolicy | Result
    /// | ---------- | ------ | ---------------------
    /// | False      | False  | Perform the default policy check. It may show the
    /// |            |        | security warning UI if the file extension is
    /// |            |        | dangerous.
    /// | ---------- | ------ | ---------------------
    /// | False      | True   | Skip the default policy check and the possible
    /// |            |        | security warning. Start saving or downloading.
    /// | ---------- | ------ | ---------------------
    /// | True       | Any    | Skip the default policy check and the possible
    /// |            |        | security warning. Abort save or download.
    ///
    /// \snippet ScenarioFileTypePolicy.cpp SuppressPolicyForExtension
    /// </summary>
    function add_SaveFileSecurityCheckStarting(const eventHandler: ICoreWebView2SaveFileSecurityCheckStartingEventHandler;
                                               out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_SaveFileSecurityCheckStarting`.
    /// </summary>
    function remove_SaveFileSecurityCheckStarting(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `SaveFileSecurityCheckStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2savefilesecuritycheckstartingeventhandler">See the ICoreWebView2SaveFileSecurityCheckStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2SaveFileSecurityCheckStartingEventHandler = interface(IUnknown)
    ['{7899576C-19E3-57C8-B7D1-55808292DE57}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2;
                    const args: ICoreWebView2SaveFileSecurityCheckStartingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// The event args for `SaveFileSecurityCheckStarting` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2savefilesecuritycheckstartingeventargs">See the ICoreWebView2SaveFileSecurityCheckStartingEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2SaveFileSecurityCheckStartingEventArgs = interface(IUnknown)
    ['{CF4FF1D1-5A67-5660-8D63-EF699881EA65}']
    /// <summary>
    /// Gets the `CancelSave` property.
    /// </summary>
    function Get_CancelSave(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set if cancel the upcoming save/download. `TRUE` means the action
    /// will be cancelled before validations in default policy.
    ///
    /// The default value is `FALSE`.
    /// </summary>
    function Set_CancelSave(value: Integer): HResult; stdcall;
    /// <summary>
    /// Get the document origin URI of this file save operation.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_DocumentOriginUri(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Get the extension of file to be saved.
    ///
    /// The file extension is the extension portion of the FilePath,
    /// preserving original case.
    ///
    /// Only final extension with period "." will be provided. For example,
    /// "*.tar.gz" is a double extension, where the ".gz" will be its
    /// final extension.
    ///
    /// File extension can be empty, if the file name has no extension
    /// at all.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_FileExtension(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Get the full path of file to be saved. This includes the
    /// file name and extension.
    ///
    /// This method doesn't provide path validation, the returned
    /// string may longer than MAX_PATH.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_FilePath(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Gets the `SuppressDefaultPolicy` property.
    /// </summary>
    function Get_SuppressDefaultPolicy(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set if the default policy checking and security warning will be
    /// suppressed. `TRUE` means it will be suppressed.
    ///
    /// The default value is `FALSE`.
    /// </summary>
    function Set_SuppressDefaultPolicy(value: Integer): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. Use this operation to complete
    /// the SaveFileSecurityCheckStartingEvent.
    ///
    /// The default policy checking and any default UI will be blocked temporarily,
    /// saving file to local won't start, until the deferral is completed.
    /// </summary>
    function GetDeferral(out value: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// This interface is an extension of `ICoreWebView2` that supports the ScreenCaptureStarting event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_27">See the ICoreWebView2_27 article.</see></para>
  /// </remarks>
  ICoreWebView2_27 = interface(ICoreWebView2_26)
    ['{00FBE33B-8C07-517C-AA23-0DDD4B5F6FA0}']
    /// <summary>
    /// Adds an event handler for the `ScreenCaptureStarting` event.
    /// Add an event handler for the `ScreenCaptureStarting` event.
    /// `ScreenCaptureStarting` event is raised when the [Screen Capture API](https://www.w3.org/TR/screen-capture/)
    /// is requested by the user using getDisplayMedia().
    /// \snippet ScenarioScreenCapture.cpp ScreenCaptureStarting0
    /// </summary>
    function add_ScreenCaptureStarting(const eventHandler: ICoreWebView2ScreenCaptureStartingEventHandler;
                                       out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_ScreenCaptureStarting`.
    /// </summary>
    function remove_ScreenCaptureStarting(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `ScreenCaptureStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2screencapturestartingeventhandler">See the ICoreWebView2ScreenCaptureStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ScreenCaptureStartingEventHandler = interface(IUnknown)
    ['{E24FF05A-1DB5-59D9-89F3-3C864268DB4A}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2;
                    const args: ICoreWebView2ScreenCaptureStartingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the `ScreenCaptureStarting` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2screencapturestartingeventargs">See the ICoreWebView2ScreenCaptureStartingEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2ScreenCaptureStartingEventArgs = interface(IUnknown)
    ['{892C03FD-AEE3-5EBA-A1FA-6FD2F6484B2B}']
    /// <summary>
    /// Gets the `Cancel` property.
    /// </summary>
    function Get_Cancel(out value: Integer): HResult; stdcall;
    /// <summary>
    /// The host may set this flag to cancel the screen capture. If canceled,
    /// the screen capture UI is not displayed regardless of the
    /// `Handled` property.
    /// On the script side, it will return with a NotAllowedError as Permission denied.
    /// </summary>
    function Set_Cancel(value: Integer): HResult; stdcall;
    /// <summary>
    /// Gets the `Handled` property.
    /// </summary>
    function Get_Handled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// By default, both the `ScreenCaptureStarting` event handlers on the
    /// `CoreWebView2Frame` and the `CoreWebView2` will be invoked, with the
    /// `CoreWebView2Frame` event handlers invoked first. The host may
    /// set this flag to `TRUE` within the `CoreWebView2Frame` event handlers
    /// to prevent the remaining `CoreWebView2` event handlers from being
    /// invoked. If the flag is set to `FALSE` within the `CoreWebView2Frame`
    /// event handlers, downstream handlers can update the `Cancel` property.
    ///
    /// If a deferral is taken on the event args, then you must synchronously
    /// set `Handled` to TRUE prior to taking your deferral to prevent the
    /// `CoreWebView2`s event handlers from being invoked.
    /// </summary>
    function Set_Handled(value: Integer): HResult; stdcall;
    /// <summary>
    /// The associated frame information that requests the screen capture
    /// permission. This can be used to get the frame source, name, frameId,
    /// and parent frame information.
    /// </summary>
    function Get_OriginalSourceFrameInfo(out value: ICoreWebView2FrameInfo): HResult; stdcall;
    /// <summary>
    /// Returns an `ICoreWebView2Deferral` object. Use this deferral to
    /// defer the decision to show the Screen Capture UI. getDisplayMedia()
    /// won't call its callbacks until the deferral is completed.
    /// </summary>
    function GetDeferral(out value: ICoreWebView2Deferral): HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties for a frame in the ICoreWebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo">See the ICoreWebView2FrameInfo article.</see></para>
  /// </remarks>
  ICoreWebView2FrameInfo = interface(IUnknown)
    ['{DA86B8A1-BDF3-4F11-9955-528CEFA59727}']
    /// <summary>
    /// The value of iframe's window.name property. The default value equals to
    /// iframe html tag declaring it, as in `<iframe name="frame-name">...</iframe>`.
    /// The returned string is empty when the frame has no name attribute and
    /// no assigned value for window.name.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_name(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// <para>The URI of the document in the frame.</para>
    /// <para>The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).</para>
    /// </summary>
    function Get_Source(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the BrowserProcessExited event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserprocessexitedeventargs">See the ICoreWebView2BrowserProcessExitedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2BrowserProcessExitedEventArgs = interface(IUnknown)
    ['{1F00663F-AF8C-4782-9CDD-DD01C52E34CB}']
    /// <summary>
    /// The kind of browser process exit that has occurred.
    /// </summary>
    function Get_BrowserProcessExitKind(out value: COREWEBVIEW2_BROWSER_PROCESS_EXIT_KIND): HResult; stdcall;
    /// <summary>
    /// The process ID of the browser process that has exited.
    /// </summary>
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
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// The RootVisualTarget is a visual in the hosting app's visual tree. This
    /// visual is where the WebView will connect its visual tree. The app uses
    /// this visual to position the WebView within the app. The app still needs
    /// to use the Bounds property to size the WebView. The RootVisualTarget
    /// property can be an IDCompositionVisual or a
    /// Windows::UI::Composition::ContainerVisual. WebView will connect its visual
    /// tree to the provided visual before returning from the property setter. The
    /// app needs to commit on its device setting the RootVisualTarget property.
    /// The RootVisualTarget property supports being set to nullptr to disconnect
    /// the WebView from the app's visual tree.
    /// \snippet ViewComponent.cpp SetRootVisualTarget
    /// \snippet ViewComponent.cpp BuildDCompTree
    /// </summary>
    function Get_RootVisualTarget(out target: IUnknown): HResult; stdcall;
    /// <summary>
    /// Set the RootVisualTarget property.
    /// </summary>
    function Set_RootVisualTarget(const target: IUnknown): HResult; stdcall;
    /// <summary>
    /// If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_HORIZONTAL_WHEEL or
    /// COREWEBVIEW2_MOUSE_EVENT_KIND_WHEEL, then mouseData specifies the amount of
    /// wheel movement. A positive value indicates that the wheel was rotated
    /// forward, away from the user; a negative value indicates that the wheel was
    /// rotated backward, toward the user. One wheel click is defined as
    /// WHEEL_DELTA, which is 120.
    /// If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOUBLE_CLICK
    /// COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_DOWN, or
    /// COREWEBVIEW2_MOUSE_EVENT_KIND_X_BUTTON_UP, then mouseData specifies which X
    /// buttons were pressed or released. This value should be 1 if the first X
    /// button is pressed/released and 2 if the second X button is
    /// pressed/released.
    /// If eventKind is COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE, then virtualKeys,
    /// mouseData, and point should all be zero.
    /// If eventKind is any other value, then mouseData should be zero.
    /// Point is expected to be in the client coordinate space of the WebView.
    /// To track mouse events that start in the WebView and can potentially move
    /// outside of the WebView and host application, calling SetCapture and
    /// ReleaseCapture is recommended.
    /// To dismiss hover popups, it is also recommended to send
    /// COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE messages.
    /// \snippet ViewComponent.cpp SendMouseInput
    /// </summary>
    function SendMouseInput(eventKind: COREWEBVIEW2_MOUSE_EVENT_KIND; 
                            virtualKeys: COREWEBVIEW2_MOUSE_EVENT_VIRTUAL_KEYS; mouseData: SYSUINT; 
                            point: tagPOINT): HResult; stdcall;
    /// <summary>
    /// SendPointerInput accepts touch or pen pointer input of types defined in
    /// COREWEBVIEW2_POINTER_EVENT_KIND. Any pointer input from the system must be
    /// converted into an ICoreWebView2PointerInfo first.
    /// </summary>
    function SendPointerInput(eventKind: COREWEBVIEW2_POINTER_EVENT_KIND; 
                              const pointerInfo: ICoreWebView2PointerInfo): HResult; stdcall;
    /// <summary>
    /// The current cursor that WebView thinks it should be. The cursor should be
    /// set in WM_SETCURSOR through \::SetCursor or set on the corresponding
    /// parent/ancestor HWND of the WebView through \::SetClassLongPtr. The HCURSOR
    /// can be freed so CopyCursor/DestroyCursor is recommended to keep your own
    /// copy if you are doing more than immediately setting the cursor.
    /// </summary>
    {* function Get_Cursor(out Cursor: wireHICON): HResult; stdcall;  wireHICON -> HCURSOR  ************** WEBVIEW4DELPHI ************** *}
    function Get_Cursor(out Cursor: HCURSOR): HResult; stdcall;
    /// <summary>
    /// The current system cursor ID reported by the underlying rendering engine
    /// for WebView. For example, most of the time, when the cursor is over text,
    /// this will return the int value for IDC_IBEAM. The systemCursorId is only
    /// valid if the rendering engine reports a default Windows cursor resource
    /// value. Navigate to
    /// [LoadCursorW](/windows/win32/api/winuser/nf-winuser-loadcursorw) for more
    /// details. Otherwise, if custom CSS cursors are being used, this will return
    /// 0. To actually use systemCursorId in LoadCursor or LoadImage,
    /// MAKEINTRESOURCE must be called on it first.
    ///
    /// \snippet ViewComponent.cpp SystemCursorId
    /// </summary>
    function Get_SystemCursorId(out SystemCursorId: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the CursorChanged event.
    /// The event is raised when WebView thinks the cursor should be changed. For
    /// example, when the mouse cursor is currently the default cursor but is then
    /// moved over text, it may try to change to the IBeam cursor.
    ///
    /// It is expected for the developer to send
    /// COREWEBVIEW2_MOUSE_EVENT_KIND_LEAVE messages (in addition to
    /// COREWEBVIEW2_MOUSE_EVENT_KIND_MOVE messages) through the SendMouseInput
    /// API. This is to ensure that the mouse is actually within the WebView that
    /// sends out CursorChanged events.
    ///
    /// \snippet ViewComponent.cpp CursorChanged
    /// </summary>
    function add_CursorChanged(const eventHandler: ICoreWebView2CursorChangedEventHandler;
                               out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with add_CursorChanged.
    /// </summary>
    function remove_CursorChanged(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// <para>This mostly represents a combined win32
  /// POINTER_INFO/POINTER_TOUCH_INFO/POINTER_PEN_INFO object. It takes fields
  /// from all three and excludes some win32 specific data types like HWND and
  /// HANDLE. Note, sourceDevice is taken out but we expect the PointerDeviceRect
  /// and DisplayRect to cover the existing use cases of sourceDevice.
  /// Another big difference is that any of the point or rect locations are
  /// expected to be in WebView physical coordinates. That is, coordinates
  /// relative to the WebView and no DPI scaling applied.</para>
  /// <para>The PointerId, PointerFlags, ButtonChangeKind, PenFlags, PenMask, TouchFlags,
  /// and TouchMask are all #defined flags or enums in the
  /// POINTER_INFO/POINTER_TOUCH_INFO/POINTER_PEN_INFO structure. We define those
  /// properties here as UINT32 or INT32 and expect the developer to know how to
  /// populate those values based on the Windows definitions.</para>
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2pointerinfo">See the ICoreWebView2PointerInfo article.</see></para>
  /// </remarks>
  ICoreWebView2PointerInfo = interface(IUnknown)
    ['{E6995887-D10D-4F5D-9359-4CE46E4F96B9}']
    /// <summary>
    /// Get the PointerKind of the pointer event. This corresponds to the
    /// pointerKind property of the POINTER_INFO struct. The values are defined by
    /// the POINTER_INPUT_KIND enum in the Windows SDK (winuser.h). Supports
    /// PT_PEN and PT_TOUCH.
    /// </summary>
    function Get_PointerKind(out PointerKind: LongWord): HResult; stdcall;
    /// <summary>
    /// Set the PointerKind of the pointer event. This corresponds to the
    /// pointerKind property of the POINTER_INFO struct. The values are defined by
    /// the POINTER_INPUT_KIND enum in the Windows SDK (winuser.h). Supports
    /// PT_PEN and PT_TOUCH.
    /// </summary>
    function Set_PointerKind(PointerKind: LongWord): HResult; stdcall;
    /// <summary>
    /// Get the PointerId of the pointer event. This corresponds to the pointerId
    /// property of the POINTER_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Get_PointerId(out PointerId: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the PointerId of the pointer event. This corresponds to the pointerId
    /// property of the POINTER_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Set_PointerId(PointerId: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the FrameID of the pointer event. This corresponds to the frameId
    /// property of the POINTER_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Get_FrameId(out FrameId: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the FrameID of the pointer event. This corresponds to the frameId
    /// property of the POINTER_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Set_FrameId(FrameId: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the PointerFlags of the pointer event. This corresponds to the
    /// pointerFlags property of the POINTER_INFO struct. The values are defined
    /// by the POINTER_FLAGS constants in the Windows SDK (winuser.h).
    /// </summary>
    function Get_PointerFlags(out PointerFlags: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the PointerFlags of the pointer event. This corresponds to the
    /// pointerFlags property of the POINTER_INFO struct. The values are defined
    /// by the POINTER_FLAGS constants in the Windows SDK (winuser.h).
    /// </summary>
    function Set_PointerFlags(PointerFlags: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the PointerDeviceRect of the sourceDevice property of the
    /// POINTER_INFO struct as defined in the Windows SDK (winuser.h).
    /// </summary>
    function Get_PointerDeviceRect(out PointerDeviceRect: tagRECT): HResult; stdcall;
    /// <summary>
    /// Set the PointerDeviceRect of the sourceDevice property of the
    /// POINTER_INFO struct as defined in the Windows SDK (winuser.h).
    /// </summary>
    function Set_PointerDeviceRect(PointerDeviceRect: tagRECT): HResult; stdcall;
    /// <summary>
    /// Get the DisplayRect of the sourceDevice property of the POINTER_INFO
    /// struct as defined in the Windows SDK (winuser.h).
    /// </summary>
    function Get_DisplayRect(out DisplayRect: tagRECT): HResult; stdcall;
    /// <summary>
    /// Set the DisplayRect of the sourceDevice property of the POINTER_INFO
    /// struct as defined in the Windows SDK (winuser.h).
    /// </summary>
    function Set_DisplayRect(DisplayRect: tagRECT): HResult; stdcall;
    /// <summary>
    /// Get the PixelLocation of the pointer event. This corresponds to the
    /// ptPixelLocation property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Get_PixelLocation(out PixelLocation: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Set the PixelLocation of the pointer event. This corresponds to the
    /// ptPixelLocation property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Set_PixelLocation(PixelLocation: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Get the HimetricLocation of the pointer event. This corresponds to the
    /// ptHimetricLocation property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Get_HimetricLocation(out HimetricLocation: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Set the HimetricLocation of the pointer event. This corresponds to the
    /// ptHimetricLocation property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Set_HimetricLocation(HimetricLocation: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Get the PixelLocationRaw of the pointer event. This corresponds to the
    /// ptPixelLocationRaw property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Get_PixelLocationRaw(out PixelLocationRaw: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Set the PixelLocationRaw of the pointer event. This corresponds to the
    /// ptPixelLocationRaw property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Set_PixelLocationRaw(PixelLocationRaw: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Get the HimetricLocationRaw of the pointer event. This corresponds to the
    /// ptHimetricLocationRaw property of the POINTER_INFO struct as defined in
    /// the Windows SDK (winuser.h).
    /// </summary>
    function Get_HimetricLocationRaw(out HimetricLocationRaw: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Set the HimetricLocationRaw of the pointer event. This corresponds to the
    /// ptHimetricLocationRaw property of the POINTER_INFO struct as defined in
    /// the Windows SDK (winuser.h).
    /// </summary>
    function Set_HimetricLocationRaw(HimetricLocationRaw: tagPOINT): HResult; stdcall;
    /// <summary>
    /// Get the Time of the pointer event. This corresponds to the dwTime property
    /// of the POINTER_INFO struct as defined in the Windows SDK (winuser.h).
    /// </summary>
    function Get_Time(out Time: LongWord): HResult; stdcall;
    /// <summary>
    /// Set the Time of the pointer event. This corresponds to the dwTime property
    /// of the POINTER_INFO struct as defined in the Windows SDK (winuser.h).
    /// </summary>
    function Set_Time(Time: LongWord): HResult; stdcall;
    /// <summary>
    /// Get the HistoryCount of the pointer event. This corresponds to the
    /// historyCount property of the POINTER_INFO struct as defined in the Windows
    /// SDK (winuser.h).
    /// </summary>
    function Get_HistoryCount(out HistoryCount: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the HistoryCount of the pointer event. This corresponds to the
    /// historyCount property of the POINTER_INFO struct as defined in the Windows
    /// SDK (winuser.h).
    /// </summary>
    function Set_HistoryCount(HistoryCount: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the InputData of the pointer event. This corresponds to the InputData
    /// property of the POINTER_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Get_InputData(out InputData: SYSINT): HResult; stdcall;
    /// <summary>
    /// Set the InputData of the pointer event. This corresponds to the InputData
    /// property of the POINTER_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Set_InputData(InputData: SYSINT): HResult; stdcall;
    /// <summary>
    /// Get the KeyStates of the pointer event. This corresponds to the
    /// dwKeyStates property of the POINTER_INFO struct as defined in the Windows
    /// SDK (winuser.h).
    /// </summary>
    function Get_KeyStates(out KeyStates: LongWord): HResult; stdcall;
    /// <summary>
    /// Set the KeyStates of the pointer event. This corresponds to the
    /// dwKeyStates property of the POINTER_INFO struct as defined in the Windows
    /// SDK (winuser.h).
    /// </summary>
    function Set_KeyStates(KeyStates: LongWord): HResult; stdcall;
    /// <summary>
    /// Get the PerformanceCount of the pointer event. This corresponds to the
    /// PerformanceCount property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Get_PerformanceCount(out PerformanceCount: Largeuint): HResult; stdcall;
    /// <summary>
    /// Set the PerformanceCount of the pointer event. This corresponds to the
    /// PerformanceCount property of the POINTER_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    function Set_PerformanceCount(PerformanceCount: Largeuint): HResult; stdcall;
    /// <summary>
    /// Get the ButtonChangeKind of the pointer event. This corresponds to the
    /// ButtonChangeKind property of the POINTER_INFO struct. The values are
    /// defined by the POINTER_BUTTON_CHANGE_KIND enum in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Get_ButtonChangeKind(out ButtonChangeKind: SYSINT): HResult; stdcall;
    /// <summary>
    /// Set the ButtonChangeKind of the pointer event. This corresponds to the
    /// ButtonChangeKind property of the POINTER_INFO struct. The values are
    /// defined by the POINTER_BUTTON_CHANGE_KIND enum in the Windows SDK
    /// (winuser.h).
    /// </summary>
    function Set_ButtonChangeKind(ButtonChangeKind: SYSINT): HResult; stdcall;
    /// <summary>
    /// Get the PenFlags of the pointer event. This corresponds to the penFlags
    /// property of the POINTER_PEN_INFO struct. The values are defined by the
    /// PEN_FLAGS constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Get_PenFlags(out PenFlags: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the PenFlags of the pointer event. This corresponds to the penFlags
    /// property of the POINTER_PEN_INFO struct. The values are defined by the
    /// PEN_FLAGS constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Set_PenFlags(PenFlags: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the PenMask of the pointer event. This corresponds to the penMask
    /// property of the POINTER_PEN_INFO struct. The values are defined by the
    /// PEN_MASK constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Get_PenMask(out PenMask: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the PenMask of the pointer event. This corresponds to the penMask
    /// property of the POINTER_PEN_INFO struct. The values are defined by the
    /// PEN_MASK constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Set_PenMask(PenMask: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the PenPressure of the pointer event. This corresponds to the pressure
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Get_PenPressure(out PenPressure: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the PenPressure of the pointer event. This corresponds to the pressure
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Set_PenPressure(PenPressure: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the PenRotation of the pointer event. This corresponds to the rotation
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Get_PenRotation(out PenRotation: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the PenRotation of the pointer event. This corresponds to the rotation
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Set_PenRotation(PenRotation: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the PenTiltX of the pointer event. This corresponds to the tiltX
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Get_PenTiltX(out PenTiltX: SYSINT): HResult; stdcall;
    /// <summary>
    /// Set the PenTiltX of the pointer event. This corresponds to the tiltX
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Set_PenTiltX(PenTiltX: SYSINT): HResult; stdcall;
    /// <summary>
    /// Get the PenTiltY of the pointer event. This corresponds to the tiltY
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Get_PenTiltY(out PenTiltY: SYSINT): HResult; stdcall;
    /// <summary>
    /// Set the PenTiltY of the pointer event. This corresponds to the tiltY
    /// property of the POINTER_PEN_INFO struct as defined in the Windows SDK
    /// (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Pen specific attribute.</para>
    /// </remarks>
    function Set_PenTiltY(PenTiltY: SYSINT): HResult; stdcall;
    /// <summary>
    /// Get the TouchFlags of the pointer event. This corresponds to the
    /// touchFlags property of the POINTER_TOUCH_INFO struct. The values are
    /// defined by the TOUCH_FLAGS constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Get_TouchFlags(out TouchFlags: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the TouchFlags of the pointer event. This corresponds to the
    /// touchFlags property of the POINTER_TOUCH_INFO struct. The values are
    /// defined by the TOUCH_FLAGS constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Set_TouchFlags(TouchFlags: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the TouchMask of the pointer event. This corresponds to the
    /// touchMask property of the POINTER_TOUCH_INFO struct. The values are
    /// defined by the TOUCH_MASK constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Get_TouchMask(out TouchMask: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the TouchMask of the pointer event. This corresponds to the
    /// touchMask property of the POINTER_TOUCH_INFO struct. The values are
    /// defined by the TOUCH_MASK constants in the Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Set_TouchMask(TouchMask: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the TouchContact of the pointer event. This corresponds to the
    /// rcContact property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Get_TouchContact(out TouchContact: tagRECT): HResult; stdcall;
    /// <summary>
    /// Set the TouchContact of the pointer event. This corresponds to the
    /// rcContact property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Set_TouchContact(TouchContact: tagRECT): HResult; stdcall;
    /// <summary>
    /// Get the TouchContactRaw of the pointer event. This corresponds to the
    /// rcContactRaw property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Get_TouchContactRaw(out TouchContactRaw: tagRECT): HResult; stdcall;
    /// <summary>
    /// Set the TouchContactRaw of the pointer event. This corresponds to the
    /// rcContactRaw property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Set_TouchContactRaw(TouchContactRaw: tagRECT): HResult; stdcall;
    /// <summary>
    /// Get the TouchOrientation of the pointer event. This corresponds to the
    /// orientation property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Get_TouchOrientation(out TouchOrientation: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the TouchOrientation of the pointer event. This corresponds to the
    /// orientation property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Set_TouchOrientation(TouchOrientation: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Get the TouchPressure of the pointer event. This corresponds to the
    /// pressure property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Get_TouchPressure(out TouchPressure: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Set the TouchPressure of the pointer event. This corresponds to the
    /// pressure property of the POINTER_TOUCH_INFO struct as defined in the
    /// Windows SDK (winuser.h).
    /// </summary>
    /// <remarks>
    /// <para>This is a Touch specific attribute.</para>
    /// </remarks>
    function Set_TouchPressure(TouchPressure: SYSUINT): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `CursorChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2cursorchangedeventhandler">See the ICoreWebView2CursorChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CursorChangedEventHandler = interface(IUnknown)
    ['{9DA43CCC-26E1-4DAD-B56C-D8961C94C571}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Returns the Automation Provider for the WebView. This object implements
    /// IRawElementProviderSimple.
    /// </summary>
    function Get_AutomationProvider(out value: IUnknown): HResult; stdcall;
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
    /// <summary>
    /// This function corresponds to [IDropTarget::DragEnter](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragenter).
    ///
    /// This function has a dependency on AllowExternalDrop property of
    /// CoreWebView2Controller and return E_FAIL to callers to indicate this
    /// operation is not allowed if AllowExternalDrop property is set to false.
    ///
    /// The hosting application must register as an IDropTarget and implement
    /// and forward DragEnter calls to this function.
    ///
    /// point parameter must be modified to include the WebView's offset and be in
    /// the WebView's client coordinates (Similar to how SendMouseInput works).
    ///
    /// \snippet DropTarget.cpp DragEnter
    /// </summary>
    function DragEnter(const dataObject: IDataObject; keyState: LongWord; point: tagPOINT;
                       out effect: LongWord): HResult; stdcall;
    /// <summary>
    /// This function corresponds to [IDropTarget::DragLeave](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragleave).
    ///
    /// This function has a dependency on AllowExternalDrop property of
    /// CoreWebView2Controller and return E_FAIL to callers to indicate this
    /// operation is not allowed if AllowExternalDrop property is set to false.
    ///
    /// The hosting application must register as an IDropTarget and implement
    /// and forward DragLeave calls to this function.
    ///
    /// \snippet DropTarget.cpp DragLeave
    /// </summary>
    function DragLeave: HResult; stdcall;
    /// <summary>
    /// This function corresponds to [IDropTarget::DragOver](/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragover).
    ///
    /// This function has a dependency on AllowExternalDrop property of
    /// CoreWebView2Controller and return E_FAIL to callers to indicate this
    /// operation is not allowed if AllowExternalDrop property is set to false.
    ///
    /// The hosting application must register as an IDropTarget and implement
    /// and forward DragOver calls to this function.
    ///
    /// point parameter must be modified to include the WebView's offset and be in
    /// the WebView's client coordinates (Similar to how SendMouseInput works).
    ///
    /// \snippet DropTarget.cpp DragOver
    /// </summary>
    function DragOver(keyState: LongWord; point: tagPOINT; out effect: LongWord): HResult; stdcall;
    /// <summary>
    /// This function corresponds to [IDropTarget::Drop](/windows/win32/api/oleidl/nf-oleidl-idroptarget-drop).
    ///
    /// This function has a dependency on AllowExternalDrop property of
    /// CoreWebView2Controller and return E_FAIL to callers to indicate this
    /// operation is not allowed if AllowExternalDrop property is set to false.
    ///
    /// The hosting application must register as an IDropTarget and implement
    /// and forward Drop calls to this function.
    ///
    /// point parameter must be modified to include the WebView's offset and be in
    /// the WebView's client coordinates (Similar to how SendMouseInput works).
    ///
    /// \snippet DropTarget.cpp Drop
    /// </summary>
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
    /// <summary>
    /// The `DefaultBackgroundColor` property is the color WebView renders
    /// underneath all web content. This means WebView renders this color when
    /// there is no web content loaded such as before the initial navigation or
    /// between navigations. This also means web pages with undefined css
    /// background properties or background properties containing transparent
    /// pixels will render their contents over this color. Web pages with defined
    /// and opaque background properties that span the page will obscure the
    /// `DefaultBackgroundColor` and display normally. The default value for this
    /// property is white to resemble the native browser experience.
    ///
    /// The Color is specified by the COREWEBVIEW2_COLOR that represents an RGBA
    /// value. The `A` represents an Alpha value, meaning
    /// `DefaultBackgroundColor` can be transparent. In the case of a transparent
    /// `DefaultBackgroundColor` WebView will render hosting app content as the
    /// background. This Alpha value is not supported on Windows 7. Any `A` value
    /// other than 255 will result in E_INVALIDARG on Windows 7.
    /// It is supported on all other WebView compatible platforms.
    ///
    /// Semi-transparent colors are not currently supported by this API and
    /// setting `DefaultBackgroundColor` to a semi-transparent color will fail
    /// with E_INVALIDARG. The only supported alpha values are 0 and 255, all
    /// other values will result in E_INVALIDARG.
    /// `DefaultBackgroundColor` can only be an opaque color or transparent.
    ///
    /// This value may also be set by using the
    /// `WEBVIEW2_DEFAULT_BACKGROUND_COLOR` environment variable. There is a
    /// known issue with background color where setting the color by API can
    /// still leave the app with a white flicker before the
    /// `DefaultBackgroundColor` takes effect. Setting the color via environment
    /// variable solves this issue. The value must be a hex value that can
    /// optionally prepend a 0x. The value must account for the alpha value
    /// which is represented by the first 2 digits. So any hex value fewer than 8
    /// digits will assume a prepended 00 to the hex value and result in a
    /// transparent color.
    /// `get_DefaultBackgroundColor` will return the result of this environment
    /// variable if used. This environment variable can only set the
    /// `DefaultBackgroundColor` once. Subsequent updates to background color
    /// must be done through API call.
    ///
    /// \snippet ViewComponent.cpp DefaultBackgroundColor
    /// </summary>
    function Get_DefaultBackgroundColor(out value: COREWEBVIEW2_COLOR): HResult; stdcall;
    /// <summary>
    /// Sets the `DefaultBackgroundColor` property.
    /// </summary>
    function Set_DefaultBackgroundColor(value: COREWEBVIEW2_COLOR): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Controller2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller3">See the ICoreWebView2Controller3 article.</see></para>
  /// </remarks>
  ICoreWebView2Controller3 = interface(ICoreWebView2Controller2)
    ['{F9614724-5D2B-41DC-AEF7-73D62B51543B}']
    /// <summary>
    /// The rasterization scale for the WebView. The rasterization scale is the
    /// combination of the monitor DPI scale and text scaling set by the user.
    /// This value should be updated when the DPI scale of the app's top level
    /// window changes (i.e. monitor DPI scale changes or window changes monitor)
    /// or when the text scale factor of the system changes.
    ///
    /// \snippet AppWindow.cpp DPIChanged
    ///
    /// \snippet AppWindow.cpp TextScaleChanged1
    ///
    /// \snippet AppWindow.cpp TextScaleChanged2
    ///
    /// Rasterization scale applies to the WebView content, as well as
    /// popups, context menus, scroll bars, and so on. Normal app scaling
    /// scenarios should use the ZoomFactor property or SetBoundsAndZoomFactor
    /// API which only scale the rendered HTML content and not popups, context
    /// menus, scroll bars, and so on.
    ///
    /// \snippet ViewComponent.cpp RasterizationScale
    /// </summary>
    function Get_RasterizationScale(out scale: Double): HResult; stdcall;
    /// <summary>
    /// Set the rasterization scale property.
    /// </summary>
    function Set_RasterizationScale(scale: Double): HResult; stdcall;
    /// <summary>
    /// ShouldDetectMonitorScaleChanges property determines whether the WebView
    /// attempts to track monitor DPI scale changes. When true, the WebView will
    /// track monitor DPI scale changes, update the RasterizationScale property,
    /// and raises RasterizationScaleChanged event. When false, the WebView will
    /// not track monitor DPI scale changes, and the app must update the
    /// RasterizationScale property itself. RasterizationScaleChanged event will
    /// never raise when ShouldDetectMonitorScaleChanges is false. Apps that want
    /// to set their own rasterization scale should set this property to false to
    /// avoid the WebView2 updating the RasterizationScale property to match the
    /// monitor DPI scale.
    /// </summary>
    function Get_ShouldDetectMonitorScaleChanges(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the ShouldDetectMonitorScaleChanges property.
    /// </summary>
    function Set_ShouldDetectMonitorScaleChanges(value: Integer): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the RasterizationScaleChanged event.
    /// The event is raised when the WebView detects that the monitor DPI scale
    /// has changed, ShouldDetectMonitorScaleChanges is true, and the WebView has
    /// changed the RasterizationScale property.
    ///
    /// \snippet ViewComponent.cpp RasterizationScaleChanged
    /// </summary>
    function add_RasterizationScaleChanged(const eventHandler: ICoreWebView2RasterizationScaleChangedEventHandler;
                                           out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with
    /// add_RasterizationScaleChanged.
    /// </summary>
    function remove_RasterizationScaleChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// BoundsMode affects how setting the Bounds and RasterizationScale
    /// properties work. Bounds mode can either be in COREWEBVIEW2_BOUNDS_MODE_USE_RAW_PIXELS
    /// mode or COREWEBVIEW2_BOUNDS_MODE_USE_RASTERIZATION_SCALE mode.
    ///
    /// When the mode is in COREWEBVIEW2_BOUNDS_MODE_USE_RAW_PIXELS, setting the bounds
    /// property will set the size of the WebView in raw screen pixels. Changing
    /// the rasterization scale in this mode won't change the raw pixel size of
    /// the WebView and will only change the rasterization scale.
    ///
    /// When the mode is in COREWEBVIEW2_BOUNDS_MODE_USE_RASTERIZATION_SCALE, setting the
    /// bounds property will change the logical size of the WebView which can be
    /// described by the following equation:
    /// ```text
    /// Logical size * rasterization scale = Raw Pixel size
    /// ```
    /// In this case, changing the rasterization scale will keep the logical size
    /// the same and change the raw pixel size.
    ///
    /// \snippet ViewComponent.cpp BoundsMode
    /// </summary>
    function Get_BoundsMode(out BoundsMode: COREWEBVIEW2_BOUNDS_MODE): HResult; stdcall;
    /// <summary>
    /// Set the BoundsMode property.
    /// </summary>
    function Set_BoundsMode(BoundsMode: COREWEBVIEW2_BOUNDS_MODE): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `RasterizationScaleChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2rasterizationscalechangedeventhandler">See the ICoreWebView2RasterizationScaleChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2RasterizationScaleChangedEventHandler = interface(IUnknown)
    ['{9C98C8B1-AC53-427E-A345-3049B5524BBE}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Gets the `AllowExternalDrop` property which is used to configure the
    /// capability that dragging objects from outside the bounds of webview2 and
    /// dropping into webview2 is allowed or disallowed. The default value is
    /// TRUE.
    ///
    /// \snippet SettingsComponent.cpp ToggleAllowExternalDrop
    /// </summary>
    function Get_AllowExternalDrop(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AllowExternalDrop` property which is used to configure the
    /// capability that dragging objects from outside the bounds of webview2 and
    /// dropping into webview2 is allowed or disallowed.
    ///
    /// \snippet SettingsComponent.cpp ToggleAllowExternalDrop
    /// </summary>
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
    /// <summary>
    /// `ProfileName` property is to specify a profile name, which is only allowed to contain
    /// the following ASCII characters. It has a maximum length of 64 characters excluding the null-terminator.
    /// It is ASCII case insensitive.
    ///
    /// * alphabet characters: a-z and A-Z
    /// * digit characters: 0-9
    /// * and '#', '@', '$', '(', ')', '+', '-', '_', '~', '.', ' ' (space).
    ///
    /// Note: the text must not end with a period '.' or ' ' (space). And, although upper-case letters are
    /// allowed, they're treated just as lower-case counterparts because the profile name will be mapped to
    /// the real profile directory path on disk and Windows file system handles path names in a case-insensitive way.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ProfileName(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `ProfileName` property.
    /// </summary>
    function Set_ProfileName(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// `IsInPrivateModeEnabled` property is to enable/disable InPrivate mode.
    /// </summary>
    function Get_IsInPrivateModeEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsInPrivateModeEnabled` property.
    /// </summary>
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
    /// <summary>
    /// The default locale for the WebView2.  It sets the default locale for all
    /// Intl JavaScript APIs and other JavaScript APIs that depend on it, namely
    /// `Intl.DateTimeFormat()` which affects string formatting like
    /// in the time/date formats. Example: `Intl.DateTimeFormat().format(new Date())`
    /// The intended locale value is in the format of
    /// BCP 47 Language Tags. More information can be found from
    /// [IETF BCP47](https://www.ietf.org/rfc/bcp/bcp47.html).
    ///
    /// This property sets the locale for a CoreWebView2Environment used to create the
    /// WebView2ControllerOptions object, which is passed as a parameter in
    /// `CreateCoreWebView2ControllerWithOptions`.
    ///
    /// Changes to the ScriptLocale property apply to renderer processes created after
    /// the change. Any existing renderer processes will continue to use the previous
    /// ScriptLocale value. To ensure changes are applied to all renderer process,
    /// close and restart the CoreWebView2Environment and all associated WebView2 objects.
    ///
    /// The default value for ScriptLocale will depend on the WebView2 language
    /// and OS region. If the language portions of the WebView2 language and OS region
    /// match, then it will use the OS region. Otherwise, it will use the WebView2
    /// language.
    ///
    /// | OS Region | WebView2 Language | Default WebView2 ScriptLocale |
    /// |-----------|-------------------|-------------------------------|
    /// | en-GB     | en-US             | en-GB                         |
    /// | es-MX     | en-US             | en-US                         |
    /// | en-US     | en-GB             | en-US                         |
    ///
    /// You can set the ScriptLocale to the empty string to get the default ScriptLocale value.
    ///
    /// Use OS specific APIs to determine the OS region to use with this property
    /// if you want to match the OS. For example:
    ///
    /// Win32 C++:
    /// ```cpp
    ///   wchar_t osLocale[LOCALE_NAME_MAX_LENGTH] = {0};
    ///   GetUserDefaultLocaleName(osLocale, LOCALE_NAME_MAX_LENGTH);
    /// ```
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// \snippet AppWindow.cpp ScriptLocaleSetting
    /// </summary>
    function Get_ScriptLocale(out locale: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `ScriptLocale` property.
    /// </summary>
    function Set_ScriptLocale(locale: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Controller option used to expose the DefaultBackgroundColor property early in the loading process.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions3">See the ICoreWebView2ControllerOptions3 article.</see></para>
  /// </remarks>
  ICoreWebView2ControllerOptions3 = interface(ICoreWebView2ControllerOptions2)
    ['{B32B191A-8998-57CA-B7CB-E04617E4CE4A}']
    /// <summary>
    /// Gets the `DefaultBackgroundColor` property.
    /// </summary>
    function Get_DefaultBackgroundColor(out value: COREWEBVIEW2_COLOR): HResult; stdcall;
    /// <summary>
    /// <para>This property allows users to initialize the `DefaultBackgroundColor` early,
    /// preventing a white flash that can occur while WebView2 is loading when
    /// the background color is set to something other than white. With early
    /// initialization, the color remains consistent from the start. After
    /// initialization, `CoreWebView2Controller.DefaultBackgroundColor` will return the value set using this API.</para>
    ///
    /// <para>The `CoreWebView2Controller.DefaultBackgroundColor` can be set via the WEBVIEW2_DEFAULT_BACKGROUND_COLOR environment variable,
    /// which will remain supported for cases where this solution is being used.
    /// It is encouraged to transition away from the environment variable and use this API solution to
    /// apply the property. It is important to highlight that when set, the enviroment variable overrides
    /// ControllerOptions::DefaultBackgroundColor and becomes the initial value of Controller::DefaultBackgroundColor.</para>
    ///
    /// <para>The `DefaultBackgroundColor` is the color that renders underneath all web
    /// content. This means WebView2 renders this color when there is no web
    /// content loaded. When no background color is defined in WebView2, it uses
    /// the `DefaultBackgroundColor` property to render the background.
    /// By default, this color is set to white.</para>
    ///
    /// <para>This API only supports opaque colors and full transparency. It will
    /// fail for colors with alpha values that don't equal 0 or 255.
    /// When WebView2 is set to be fully transparent, it does not render a background,
    /// allowing the content from windows behind it to be visible.</para>
    /// </summary>
    function Set_DefaultBackgroundColor(value: COREWEBVIEW2_COLOR): HResult; stdcall;
  end;

  /// <summary>
  /// Controller option used to allow user input pass through the browser and make
  /// them received in the host app process.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controlleroptions4">See the ICoreWebView2ControllerOptions4 article.</see></para>
  /// </remarks>
  ICoreWebView2ControllerOptions4 = interface(ICoreWebView2ControllerOptions3)
    ['{21EB052F-AD39-555E-824A-C87B091D4D36}']
    /// <summary>
    /// Gets the `AllowHostInputProcessing` property.
    /// </summary>
    function Get_AllowHostInputProcessing(out value: Integer): HResult; stdcall;
    /// <summary>
    /// `AllowHostInputProcessing` property is to enable/disable input passing through
    /// the app before being delivered to the WebView2. This property is only applicable
    /// to controllers created with `CoreWebView2Environment.CreateCoreWebView2ControllerAsync` and not
    /// composition controllers created with `CoreWebView2Environment.CreateCoreWebView2CompositionControllerAsync`.
    /// By default the value is `FALSE`.
    /// Setting this property has no effect when using visual hosting.
    /// \snippet AppWindow.cpp AllowHostInputProcessing
    /// </summary>
    function Set_AllowHostInputProcessing(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `ClearBrowsingData` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2clearbrowsingdatacompletedhandler">See the ICoreWebView2ClearBrowsingDataCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ClearBrowsingDataCompletedHandler = interface(IUnknown)
    ['{E9710A06-1D1D-49B2-8234-226F35846AE5}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `CreateCoreWebView2CompositionController` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2compositioncontrollercompletedhandler">See the ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler = interface(IUnknown)
    ['{02FAB84B-1428-4FB7-AD45-1B2E64736184}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2CompositionController): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `CreateCoreWebView2Environment` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2createcorewebview2environmentcompletedhandler">See the ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler = interface(IUnknown)
    ['{4E8A3389-C9D8-4BD2-B6B5-124FEE6CC14D}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2Environment): HResult; stdcall;
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
    /// <summary>
    /// The name of the custom scheme to register.
    /// </summary>
    function Get_SchemeName(out SchemeName: PWideChar): HResult; stdcall;
    /// <summary>
    /// Whether the sites with this scheme will be treated as a
    /// [Secure Context](https://developer.mozilla.org/docs/Web/Security/Secure_Contexts)
    /// like an HTTPS site. This flag is only effective when HasAuthorityComponent
    /// is also set to `true`.
    /// `false` by default.
    /// </summary>
    function Get_TreatAsSecure(out TreatAsSecure: Integer): HResult; stdcall;
    /// <summary>
    /// Set if the scheme will be treated as a Secure Context.
    /// </summary>
    function Set_TreatAsSecure(TreatAsSecure: Integer): HResult; stdcall;
    /// <summary>
    /// List of origins that are allowed to issue requests with the custom
    /// scheme, such as XHRs and subresource requests that have an Origin header.
    /// The origin of any request (requests that have the
    /// [Origin header](https://developer.mozilla.org/docs/Web/HTTP/Headers/Origin))
    /// to the custom scheme URI needs to be in this list. No-origin requests
    /// are requests that do not have an Origin header, such as link
    /// navigations, embedded images and are always allowed.
    /// Note: POST requests always contain an Origin header, therefore
    /// AllowedOrigins must be set for even for same origin POST requests.
    /// Note that cross-origin restrictions still apply.
    /// From any opaque origin (Origin header is null), no cross-origin requests
    /// are allowed.
    /// If the list is empty, no cross-origin request to this scheme is
    /// allowed.
    /// Origins are specified as a string in the format of
    /// scheme://host:port.
    /// The origins are string pattern matched with `*` (matches 0 or more
    /// characters) and `?` (matches 0 or 1 character) wildcards just like
    /// the URI matching in the
    /// [AddWebResourceRequestedFilter API](/dotnet/api/microsoft.web.webview2.core.corewebview2.addwebresourcerequestedfilter).
    /// For example, "http://*.example.com:80".
    /// Here's a set of examples of what is allowed and not:
    ///
    /// | Request URI | Originating URL | AllowedOrigins | Allowed |
    /// | -- | -- | -- | -- |
    /// | `custom-scheme:request` | `https://www.example.com` | {"https://www.example.com"} | Yes |
    /// | `custom-scheme:request` | `https://www.example.com` | {"https://*.example.com"} | Yes |
    /// | `custom-scheme:request` | `https://www.example.com` | {"https://www.example2.com"} | No |
    /// | `custom-scheme-with-authority://host/path` | `custom-scheme-with-authority://host2` | {""} | No |
    /// | `custom-scheme-with-authority://host/path` | `custom-scheme-with-authority2://host` | {"custom-scheme-with-authority2://*"} | Yes |
    /// | `custom-scheme-without-authority:path` | custom-scheme-without-authority:path2 | {"custom-scheme-without-authority:*"} | No |
    /// | `custom-scheme-without-authority:path` | custom-scheme-without-authority:path2 | {"*"} | Yes |
    ///
    /// The returned strings and the array itself must be deallocated with
    /// CoTaskMemFree.
    /// </summary>
    {* out allowedOrigins: PPWideChar1 --> out allowedOrigins: PPWideChar    ************** WEBVIEW4DELPHI ************** *}
    function GetAllowedOrigins(out allowedOriginsCount: SYSUINT; out allowedOrigins: PPWideChar): HResult; stdcall;
    /// <summary>
    /// Set the array of origins that are allowed to use the scheme.
    /// </summary>
    {* var allowedOrigins: PWideChar --> allowedOrigins: PPWideChar    ************** WEBVIEW4DELPHI ************** *}
    function SetAllowedOrigins(allowedOriginsCount: SYSUINT; allowedOrigins: PPWideChar): HResult; stdcall;
    /// <summary>
    /// Set this property to `true` if the URIs with this custom
    /// scheme will have an authority component (a host for custom schemes).
    /// Specifically, if you have a URI of the following form you should set the
    /// `HasAuthorityComponent` value as listed.
    ///
    /// | URI | Recommended HasAuthorityComponent value |
    /// | -- | -- |
    /// | `custom-scheme-with-authority://host/path` | `true` |
    /// | `custom-scheme-without-authority:path` | `false` |
    ///
    /// When this property is set to `true`, the URIs with this scheme will be
    /// interpreted as having a
    /// [scheme and host](https://html.spec.whatwg.org/multipage/origin.html#concept-origin-tuple)
    /// origin similar to an http URI. Note that the port and user
    /// information are never included in the computation of origins for
    /// custom schemes.
    /// If this property is set to `false`, URIs with this scheme will have an
    /// [opaque origin](https://html.spec.whatwg.org/multipage/origin.html#concept-origin-opaque)
    /// similar to a data URI.
    /// This property is `false` by default.
    ///
    /// Note: For custom schemes registered as having authority component,
    /// navigations to URIs without authority of such custom schemes will fail.
    /// However, if the content inside WebView2 references
    /// a subresource with a URI that does not have
    /// an authority component, but of a custom scheme that is registered as
    /// having authority component, the URI will be interpreted as a relative path
    /// as specified in [RFC3986](https://www.rfc-editor.org/rfc/rfc3986).
    /// For example, `custom-scheme-with-authority:path` will be interpreted
    /// as `custom-scheme-with-authority://host/path`.
    /// However, this behavior cannot be guaranteed to remain in future
    /// releases so it is recommended not to rely on this behavior.
    /// </summary>
    function Get_HasAuthorityComponent(out HasAuthorityComponent: Integer): HResult; stdcall;
    /// <summary>
    /// Get has authority component.
    /// </summary>
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
    /// <summary>
    /// The sessionId of the target where the event originates from.
    /// Empty string is returned as sessionId if the event comes from the default
    /// session for the top page.
    ///
    /// \snippet ScriptComponent.cpp DevToolsProtocolEventReceivedSessionId
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_sessionId(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment2">See the ICoreWebView2Environment2 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment2 = interface(ICoreWebView2Environment)
    ['{41F3632B-5EF4-404F-AD82-2D606C5A9A21}']
    /// <summary>
    /// Create a new web resource request object.
    /// URI parameter must be absolute URI.
    /// The headers string is the raw request header string delimited by CRLF
    /// (optional in last header).
    /// It's also possible to create this object with null headers string
    /// and then use the ICoreWebView2HttpRequestHeaders to construct the headers
    /// line by line.
    /// For information on other parameters see ICoreWebView2WebResourceRequest.
    ///
    /// \snippet ScenarioNavigateWithWebResourceRequest.cpp NavigateWithWebResourceRequest
    /// </summary>
    function CreateWebResourceRequest(uri: PWideChar; Method: PWideChar; const postData: IStream; 
                                      Headers: PWideChar; 
                                      out value: ICoreWebView2WebResourceRequest): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment3">See the ICoreWebView2Environment3 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment3 = interface(ICoreWebView2Environment2)
    ['{80A22AE3-BE7C-4CE2-AFE1-5A50056CDEEB}']
    /// <summary>
    /// Asynchronously create a new WebView for use with visual hosting.
    ///
    /// parentWindow is the HWND in which the app will connect the visual tree of
    /// the WebView. This will be the HWND that the app will receive pointer/
    /// mouse input meant for the WebView (and will need to use SendMouseInput/
    /// SendPointerInput to forward). If the app moves the WebView visual tree to
    /// underneath a different window, then it needs to call put_ParentWindow to
    /// update the new parent HWND of the visual tree.
    ///
    /// HWND_MESSAGE is not a valid parameter for `parentWindow` for visual hosting.
    /// The underlying implementation of supporting HWND_MESSAGE would break
    /// accessibility for visual hosting. This is supported in windowed
    /// WebViews - see CreateCoreWebView2Controller.
    ///
    /// Use put_RootVisualTarget on the created CoreWebView2CompositionController to
    /// provide a visual to host the browser's visual tree.
    ///
    /// It is recommended that the application set Application User Model ID for
    /// the process or the application window. If none is set, during WebView
    /// creation a generated Application User Model ID is set to root window of
    /// parentWindow.
    /// \snippet AppWindow.cpp CreateCoreWebView2Controller
    ///
    /// It is recommended that the application handles restart manager messages
    /// so that it can be restarted gracefully in the case when the app is using
    /// Edge for WebView from a certain installation and that installation is
    /// being uninstalled. For example, if a user installs Edge from Dev channel
    /// and opts to use Edge from that channel for testing the app, and then
    /// uninstalls Edge from that channel without closing the app, the app will
    /// be restarted to allow uninstallation of the dev channel to succeed.
    /// \snippet AppWindow.cpp RestartManager
    ///
    /// The app should retry `CreateCoreWebView2CompositionController` upon failure,
    /// unless the error code is `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
    /// When the app retries `CreateCoreWebView2CompositionController`
    /// upon failure, it is recommended that the app restarts from creating a new
    /// WebView2 Environment.  If a WebView2 Runtime update happens, the version
    /// associated with a WebView2 Environment may have been removed and causing
    /// the object to no longer work.  Creating a new WebView2 Environment works
    /// since it uses the latest version.
    ///
    /// WebView creation fails with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if a
    /// running instance using the same user data folder exists, and the Environment
    /// objects have different `EnvironmentOptions`.  For example, if a WebView was
    /// created with one language, an attempt to create a WebView with a different
    /// language using the same user data folder will fail.
    ///
    /// The creation will fail with `E_ABORT` if `parentWindow` is destroyed
    /// before the creation is finished.  If this is caused by a call to
    /// `DestroyWindow`, the creation completed handler will be invoked before
    /// `DestroyWindow` returns, so you can use this to cancel creation and clean
    /// up resources synchronously when quitting a thread.
    ///
    /// In rare cases the creation can fail with `E_UNEXPECTED` if runtime does not have
    /// permissions to the user data folder.
    ///
    /// CreateCoreWebView2CompositionController is supported in the following versions of Windows:
    ///
    /// - Windows 11
    /// - Windows 10
    /// - Windows Server 2019
    /// - Windows Server 2016
    /// </summary>
    function CreateCoreWebView2CompositionController(ParentWindow: HWND;
                                                     const handler: ICoreWebView2CreateCoreWebView2CompositionControllerCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Create an empty ICoreWebView2PointerInfo. The returned
    /// ICoreWebView2PointerInfo needs to be populated with all of the relevant
    /// info before calling SendPointerInput.
    /// </summary>
    function CreateCoreWebView2PointerInfo(out value: ICoreWebView2PointerInfo): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment3 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment4">See the ICoreWebView2Environment4 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment4 = interface(ICoreWebView2Environment3)
    ['{20944379-6DCF-41D6-A0A0-ABC0FC50DE0D}']
    /// <summary>
    /// Returns the Automation Provider for the WebView that matches the provided
    /// window. Host apps are expected to implement
    /// IRawElementProviderHwndOverride. When GetOverrideProviderForHwnd is
    /// called, the app can pass the HWND to GetAutomationProviderForWindow to
    /// find the matching WebView Automation Provider.
    /// </summary>
    function GetAutomationProviderForWindow(HWND_: HWND; out value: IUnknown): HResult; stdcall;
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
    /// <summary>
    /// Adds an event handler for the `BrowserProcessExited` event.
    /// The `BrowserProcessExited` event is raised when the collection of WebView2
    /// Runtime processes for the browser process of this environment terminate
    /// due to browser process failure or normal shutdown (for example, when all
    /// associated WebViews are closed), after all resources have been released
    /// (including the user data folder). To learn about what these processes are,
    /// go to [Process model](/microsoft-edge/webview2/concepts/process-model).
    ///
    /// A handler added with this method is called until removed with
    /// `remove_BrowserProcessExited`, even if a new browser process is bound to
    /// this environment after earlier `BrowserProcessExited` events are raised.
    ///
    /// Multiple app processes can share a browser process by creating their webviews
    /// from a `ICoreWebView2Environment` with the same user data folder. When the entire
    /// collection of WebView2Runtime processes for the browser process exit, all
    /// associated `ICoreWebView2Environment` objects receive the `BrowserProcessExited`
    /// event. Multiple processes sharing the same browser process need to coordinate
    /// their use of the shared user data folder to avoid race conditions and
    /// unnecessary waits. For example, one process should not clear the user data
    /// folder at the same time that another process recovers from a crash by recreating
    /// its WebView controls; one process should not block waiting for the event if
    /// other app processes are using the same browser process (the browser process will
    /// not exit until those other processes have closed their webviews too).
    ///
    /// Note this is an event from the `ICoreWebView2Environment3` interface, not
    /// the `ICoreWebView2` one. The difference between `BrowserProcessExited` and
    /// `ICoreWebView2`'s `ProcessFailed` is that `BrowserProcessExited` is
    /// raised for any **browser process** exit (expected or unexpected, after all
    /// associated processes have exited too), while `ProcessFailed` is raised for
    /// **unexpected** process exits of any kind (browser, render, GPU, and all
    /// other types), or for main frame **render process** unresponsiveness. To
    /// learn more about the WebView2 Process Model, go to
    /// [Process model](/microsoft-edge/webview2/concepts/process-model).
    ///
    /// In the case the browser process crashes, both `BrowserProcessExited` and
    /// `ProcessFailed` events are raised, but the order is not guaranteed. These
    /// events are intended for different scenarios. It is up to the app to
    /// coordinate the handlers so they do not try to perform reliability recovery
    /// while also trying to move to a new WebView2 Runtime version or remove the
    /// user data folder.
    ///
    /// \snippet AppWindow.cpp Close
    /// </summary>
    function add_BrowserProcessExited(const eventHandler: ICoreWebView2BrowserProcessExitedEventHandler;
                                      out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_BrowserProcessExited`.
    /// </summary>
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
    /// <summary>
    /// Creates the `ICoreWebView2PrintSettings` used by the `PrintToPdf`
    /// method.
    /// </summary>
    function CreatePrintSettings(out value: ICoreWebView2PrintSettings): HResult; stdcall;
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
    /// <summary>
    /// Returns the user data folder that all CoreWebView2's created from this
    /// environment are using.
    /// This could be either the value passed in by the developer when creating
    /// the environment object or the calculated one for default handling.  It
    /// will always be an absolute path.
    ///
    /// \snippet AppWindow.cpp GetUserDataFolder
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
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
    /// <summary>
    /// Adds an event handler for the `ProcessInfosChanged` event.
    ///
    /// \snippet ProcessComponent.cpp ProcessInfosChanged
    /// \snippet ProcessComponent.cpp ProcessInfosChanged1
    /// </summary>
    function add_ProcessInfosChanged(const eventHandler: ICoreWebView2ProcessInfosChangedEventHandler;
                                     out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_ProcessInfosChanged`.
    /// </summary>
    function remove_ProcessInfosChanged(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Returns the `ICoreWebView2ProcessInfoCollection`
    /// Provide a list of all process using same user data folder except for crashpad process.
    /// </summary>
    function GetProcessInfos(out value: ICoreWebView2ProcessInfoCollection): HResult; stdcall;
  end;

  /// <summary>
  /// eceives `ProcessInfosChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfoschangedeventhandler">See the ICoreWebView2ProcessInfosChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessInfosChangedEventHandler = interface(IUnknown)
    ['{F4AF0C39-44B9-40E9-8B11-0484CFB9E0A1}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Environment; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of ICoreWebView2ProcessInfo.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfocollection">See the ICoreWebView2ProcessInfoCollection article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessInfoCollection = interface(IUnknown)
    ['{402B99CD-A0CC-4FA5-B7A5-51D86A1D2339}']
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2ProcessInfo): HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties for a process in the ICoreWebView2Environment.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processinfo">See the ICoreWebView2ProcessInfo article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessInfo = interface(IUnknown)
    ['{84FA7612-3F3D-4FBF-889D-FAD000492D72}']
    /// <summary>
    /// The process id of the process.
    /// </summary>
    function Get_ProcessId(out value: SYSINT): HResult; stdcall;
    /// <summary>
    /// The kind of the process.
    /// </summary>
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
    /// <summary>
    /// Create a custom `ContextMenuItem` object to insert into the WebView context menu.
    /// CoreWebView2 will rewind the icon stream before decoding.
    /// There is a limit of 1000 active custom context menu items at a given time.
    /// Attempting to create more before deleting existing ones will fail with
    /// ERROR_NOT_ENOUGH_QUOTA.
    /// It is recommended to reuse ContextMenuItems across ContextMenuRequested events
    /// for performance.
    /// The returned ContextMenuItem object's `IsEnabled` property will default to `TRUE`
    /// and `IsChecked` property will default to `FALSE`. A `CommandId` will be assigned
    /// to the ContextMenuItem object that's unique across active custom context menu items,
    /// but command ID values of deleted ContextMenuItems can be reassigned.
    /// </summary>
    function CreateContextMenuItem(Label_: PWideChar; const iconStream: IStream; 
                                   Kind: COREWEBVIEW2_CONTEXT_MENU_ITEM_KIND; 
                                   out value: ICoreWebView2ContextMenuItem): HResult; stdcall;
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
    /// <summary>
    /// Create a new ICoreWebView2ControllerOptions to be passed as a parameter of
    /// CreateCoreWebView2ControllerWithOptions and CreateCoreWebView2CompositionControllerWithOptions.
    /// The 'options' is settable and in it the default value for profile name is the empty string,
    /// and the default value for IsInPrivateModeEnabled is false.
    /// Also the profile name can be reused.
    /// </summary>
    function CreateCoreWebView2ControllerOptions(out value: ICoreWebView2ControllerOptions): HResult; stdcall;
    /// <summary>
    /// Create a new WebView with options.
    /// </summary>
    function CreateCoreWebView2ControllerWithOptions(ParentWindow: HWND;
                                                     const options: ICoreWebView2ControllerOptions;
                                                     const handler: ICoreWebView2CreateCoreWebView2ControllerCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Create a new WebView in visual hosting mode with options.
    /// </summary>
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
    /// <summary>
    /// `FailureReportFolderPath` returns the path of the folder where minidump files are written.
    /// Whenever a WebView2 process crashes, a crash dump file will be created in the crash dump folder.
    /// The crash dump format is minidump files. Please see
    /// [Minidump Files documentation](/windows/win32/debug/minidump-files) for detailed information.
    /// Normally when a single child process fails, a minidump will be generated and written to disk,
    /// then the `ProcessFailed` event is raised. But for unexpected crashes, a minidump file might not be generated
    /// at all, despite whether `ProcessFailed` event is raised. If there are multiple
    /// process failures at once, multiple minidump files could be generated. Thus `FailureReportFolderPath`
    /// could contain old minidump files that are not associated with a specific `ProcessFailed` event.
    /// \snippet AppWindow.cpp GetFailureReportFolder
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
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
    /// <summary>
    /// Create a shared memory based buffer with the specified size in bytes.
    /// The buffer can be shared with web contents in WebView by calling
    /// `PostSharedBufferToScript` on `CoreWebView2` or `CoreWebView2Frame` object.
    /// Once shared, the same content of the buffer will be accessible from both
    /// the app process and script in WebView. Modification to the content will be visible
    /// to all parties that have access to the buffer.
    /// The shared buffer is presented to the script as ArrayBuffer. All JavaScript APIs
    /// that work for ArrayBuffer including Atomics APIs can be used on it.
    /// There is currently a limitation that only size less than 2GB is supported.
    /// </summary>
    function CreateSharedBuffer(Size: Largeuint; out value: ICoreWebView2SharedBuffer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Environment interface for getting process
  /// with associated information.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment13">See the ICoreWebView2Environment13 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment13 = interface(ICoreWebView2Environment12)
    ['{AF641F58-72B2-11EE-B962-0242AC120002}']
    /// <summary>
    /// Gets a snapshot collection of `ProcessExtendedInfo`s corresponding to all
    /// currently running processes associated with this `CoreWebView2Environment`
    /// excludes crashpad process.
    /// This provides the same list of `ProcessInfo`s as what's provided in
    /// `GetProcessInfos`, but additionally provides a list of associated `FrameInfo`s
    /// which are actively running (showing or hiding UI elements) in the renderer
    /// process. See `AssociatedFrameInfos` for more information.
    ///
    /// \snippet ProcessComponent.cpp GetProcessExtendedInfos
    /// </summary>
    function GetProcessExtendedInfos(const handler: ICoreWebView2GetProcessExtendedInfosCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `GetProcessExtendedInfos` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getprocessextendedinfoscompletedhandler">See the ICoreWebView2GetProcessExtendedInfosCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2GetProcessExtendedInfosCompletedHandler = interface(IUnknown)
    ['{F45E55AA-3BC2-11EE-BE56-0242AC120002}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2ProcessExtendedInfoCollection): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of ICoreWebView2ProcessExtendedInfo.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processextendedinfocollection">See the ICoreWebView2ProcessExtendedInfoCollection article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessExtendedInfoCollection = interface(IUnknown)
    ['{32EFA696-407A-11EE-BE56-0242AC120002}']
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2ProcessExtendedInfo): HResult; stdcall;
  end;

  /// <summary>
  /// Provides process with associated extended information in the `ICoreWebView2Environment`.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processextendedinfo">See the ICoreWebView2ProcessExtendedInfo article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessExtendedInfo = interface(IUnknown)
    ['{AF4C4C2E-45DB-11EE-BE56-0242AC120002}']
    /// <summary>
    /// The process info of the current process.
    /// </summary>
    function Get_processInfo(out processInfo: ICoreWebView2ProcessInfo): HResult; stdcall;
    /// <summary>
    /// The collection of associated `FrameInfo`s which are actively running
    /// (showing or hiding UI elements) in this renderer process. `AssociatedFrameInfos`
    /// will only be populated when this `CoreWebView2ProcessExtendedInfo`
    /// corresponds to a renderer process. Non-renderer processes will always
    /// have an empty `AssociatedFrameInfos`. The `AssociatedFrameInfos` may
    /// also be empty for renderer processes that have no active frames.
    ///
    /// \snippet ProcessComponent.cpp AssociatedFrameInfos
    /// </summary>
    function Get_AssociatedFrameInfos(out frames: ICoreWebView2FrameInfoCollection): HResult; stdcall;
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
    /// <summary>
    /// Gets an iterator over the collection of `FrameInfo`s.
    /// </summary>
    function GetIterator(out value: ICoreWebView2FrameInfoCollectionIterator): HResult; stdcall;
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
    /// <summary>
    /// `TRUE` when the iterator has not run out of `FrameInfo`s.  If the
    /// collection over which the iterator is iterating is empty or if the
    /// iterator has gone past the end of the collection, then this is `FALSE`.
    /// </summary>
    function Get_hasCurrent(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Get the current `ICoreWebView2FrameInfo` of the iterator.
    /// Returns `HRESULT_FROM_WIN32(ERROR_INVALID_INDEX)` if HasCurrent is
    /// `FALSE`.
    /// </summary>
    function GetCurrent(out value: ICoreWebView2FrameInfo): HResult; stdcall;
    /// <summary>
    /// Move the iterator to the next `FrameInfo` in the collection.
    /// </summary>
    function MoveNext(out value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This is ICoreWebView2Environment14 that exposes new methods to
  /// create Filesystem access related DOM objects.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment14">See the ICoreWebView2Environment14 article.</see></para>
  /// </remarks>
  ICoreWebView2Environment14 = interface(ICoreWebView2Environment13)
    ['{A5E9FAD9-C875-59DA-9BD7-473AA5CA1CEF}']
    /// <summary>
    /// Create a `ICoreWebView2FileSystemHandle` object from a path that represents a Web
    /// [FileSystemFileHandle](https://developer.mozilla.org/docs/Web/API/FileSystemFileHandle).
    ///
    /// The `path` is the path pointed by the file and must be a syntactically correct fully qualified
    /// path, but it is not checked here whether it currently points to a file. If an invalid path is
    /// passed, an E_INVALIDARG will be returned and the object will fail to create. Any other state
    /// validation will be done when this handle is accessed from web content
    /// and will cause the DOM exceptions described in
    /// [FileSystemFileHandle methods](https://developer.mozilla.org/docs/Web/API/FileSystemDirectoryHandle#instance_methods)
    /// if access operations fail.
    ///
    /// `Permission` property is used to specify whether the Handle should be created with a Read-only or
    /// Read-and-write web permission. For the `permission` value specified here, the DOM
    /// [PermissionStatus](https://developer.mozilla.org/docs/Web/API/PermissionStatus) property
    /// will be [granted](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state)
    /// and the unspecified permission will be
    /// [prompt](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state). Therefore,
    /// the web content then does not need to call
    /// [requestPermission](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/requestPermission)
    /// for the permission that was specified before attempting the permitted operation,
    /// but if it does, the promise will immediately be resolved
    /// with 'granted' PermissionStatus without firing the WebView2
    /// [PermissionRequested](/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs)
    /// event or prompting the user for permission. Otherwise, `requestPermission` will behave as the
    /// status of permission is currently `prompt`, which means the `PermissionRequested` event will fire
    /// or the user will be prompted.
    /// Additionally, the app must have the same OS permissions that have propagated to the
    /// [WebView2 browser process](/microsoft-edge/webview2/concepts/process-model)
    /// for the path it wishes to give the web content to read/write the file.
    /// Specifically, the WebView2 browser process will run in same user, package identity, and app
    /// container of the app, but other means such as security context impersonations do not get
    /// propagated, so such permissions that the app has, will not be effective in WebView2.
    /// Note: An exception to this is, if there is a parent directory handle that
    /// has broader permissions in the same page context than specified in here, the handle will automatically
    /// inherit the most permissive permission of the parent handle when posted to that page context.
    /// i.e. If there is already a `FileSystemDirectoryHandle` to `C:\example` that has write permission on
    /// a page, even though a WebFileSystemHandle to file `C:\example\file.txt` is created with
    /// `COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION_READ_ONLY` permission, when posted to that page, write permission
    /// will be automatically granted to the created handle.
    ///
    /// An app needs to be mindful that this object, when posted to the web content, provides it with unusual
    /// access to OS file system via the Web FileSystem API! The app should therefore only post objects
    /// for paths that it wants to allow access to the web content and it is not recommended that the web content
    /// "asks" for this path. The app should also check the source property of the target to ensure
    /// that it is sending to the web content of intended origin.
    ///
    /// Once the object is passed to web content, if the content is attempting a read,
    /// the file must be existing and available to read similar to a file chosen by
    /// [open file picker](https://developer.mozilla.org/docs/Web/API/Window/showOpenFilePicker),
    /// otherwise the read operation will
    /// [throw a DOM exception](https://developer.mozilla.org/docs/Web/API/FileSystemFileHandle/getFile#exceptions).
    /// For write operations, the file does not need to exist as `FileSystemFileHandle` will behave
    /// as a file path chosen by
    /// [save file picker](https://developer.mozilla.org/docs/Web/API/Window/showSaveFilePicker)
    /// and will create or overwrite the file, but the parent directory structure pointed
    /// by the file must exist and an existing file must be available to write and delete
    /// or the write operation will
    /// [throw a DOM exception](https://developer.mozilla.org/docs/Web/API/FileSystemFileHandle/createWritable#exceptions).
    /// </summary>
    function CreateWebFileSystemFileHandle(Path: PWideChar;
                                           Permission: COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION;
                                           out value: ICoreWebView2FileSystemHandle): HResult; stdcall;
    /// <summary>
    /// Create a `ICoreWebView2FileSystemHandle` object from a path that represents a Web
    /// [FileSystemDirectoryHandle](https://developer.mozilla.org/docs/Web/API/FileSystemDirectoryHandle).
    ///
    /// The `path` is the path pointed by the directory and must be a syntactically correct fully qualified
    /// path, but it is not checked here whether it currently points to a directory. Any other state
    /// validation will be done when this handle is accessed from web content
    /// and will cause DOM exceptions if access operations fail. If an invalid path is
    /// passed, an E_INVALIDARG will be returned and the object will fail to create.
    ///
    /// `Permission` property is used to specify whether the Handle should be created with a Read-only or
    /// Read-and-write web permission. For the `permission` value specified here, the Web
    /// [PermissionStatus](https://developer.mozilla.org/docs/Web/API/PermissionStatus)
    /// will be [granted](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state)
    /// and the unspecified permission will be
    /// [prompt](https://developer.mozilla.org/docs/Web/API/PermissionStatus/state). Therefore,
    /// the web content then does not need to call
    /// [requestPermission](https://developer.mozilla.org/docs/Web/API/FileSystemHandle/requestPermission)
    /// for the permission that was specified before attempting the permitted operation,
    /// but if it does, the promise will immediately be resolved
    /// with 'granted' PermissionStatus without firing the WebView2
    /// [PermissionRequested](/microsoft-edge/webview2/reference/win32/icorewebview2permissionrequestedeventargs)
    /// event or prompting the user for permission. Otherwise, `requestPermission` will behave as the
    /// status of permission is currently `Prompt`, which means the `PermissionRequested` event will fire
    /// or the user will be prompted.
    /// Additionally, the app must have the same OS permissions that have propagated to the
    /// [WebView2 browser process](/microsoft-edge/webview2/concepts/process-model)
    /// for the path it wishes to give the web content to make any operations on the directory.
    /// Specifically, the WebView2 browser process will run in same user, package identity, and app
    /// container of the app, but other means such as security context impersonations do not get
    /// propagated, so such permissions that the app has, will not be effective in WebView2.
    /// Note: An exception to this is, if there is a parent directory handle that
    /// has broader permissions in the same page context than specified in here, the handle will automatically
    /// inherit the most permissive permission of the parent handle when posted to that page context.
    /// i.e. If there is already a `FileSystemDirectoryHandle` to `C:\example` that has write permission on
    /// a page, even though a WebFileSystemHandle to directory `C:\example\directory` is created with
    /// `COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION_READ_ONLY` permission, when posted to that page, write permission
    /// will be automatically granted to the created handle.
    ///
    /// An app needs to be mindful that this object, when posted to the web content, provides it with unusual
    /// access to OS file system via the Web FileSystem API! The app should therefore only post objects
    /// for paths that it wants to allow access to the web content and it is not recommended that the web content
    /// "asks" for this path. The app should also check the source property of the target to ensure
    /// that it is sending to the web content of intended origin.
    ///
    /// Once the object is passed to web content, the path must point to a directory as if it was chosen via
    /// [directory picker](https://developer.mozilla.org/docs/Web/API/Window/showDirectoryPicker)
    /// otherwise any IO operation done on the `FileSystemDirectoryHandle` will throw a DOM exception.
    /// </summary>
    function CreateWebFileSystemDirectoryHandle(Path: PWideChar;
                                                Permission: COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION;
                                                out value: ICoreWebView2FileSystemHandle): HResult; stdcall;
    /// <summary>
    /// Create a generic object collection.
    /// </summary>
    function CreateObjectCollection(length: SYSUINT; var items: IUnknown;
                                    out objectCollection: ICoreWebView2ObjectCollection): HResult; stdcall;
  end;

  /// <summary>
  /// Representation of a DOM
  /// [FileSystemHandle](https://developer.mozilla.org/docs/Web/API/FileSystemHandle)
  /// object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2filesystemhandle">See the ICoreWebView2FileSystemHandle article.</see></para>
  /// </remarks>
  ICoreWebView2FileSystemHandle = interface(IUnknown)
    ['{C65100AC-0DE2-5551-A362-23D9BD1D0E1F}']
    /// <summary>
    /// The kind of the FileSystemHandle. It can either be a file or a directory.
    /// </summary>
    function Get_Kind(out value: COREWEBVIEW2_FILE_SYSTEM_HANDLE_KIND): HResult; stdcall;
    /// <summary>
    /// The path to the FileSystemHandle.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Path(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The permissions granted to the FileSystemHandle.
    /// </summary>
    function Get_Permission(out value: COREWEBVIEW2_FILE_SYSTEM_HANDLE_PERMISSION): HResult; stdcall;
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
    /// <summary>
    /// Changes the behavior of the WebView.  The arguments are passed to the
    /// browser process as part of the command.  For more information about
    /// using command-line switches with Chromium browser processes, navigate to
    /// [Run Chromium with Flags](https://www.chromium.org/developers/how-tos/run-chromium-with-flags).
    /// The value appended to a switch is appended to the browser process, for
    /// example, in `--edge-webview-switches=xxx` the value is `xxx`.  If you
    /// specify a switch that is important to WebView functionality, it is
    /// ignored, for example, `--user-data-dir`.  Specific features are disabled
    /// internally and blocked from being enabled.  If a switch is specified
    /// multiple times, only the last instance is used.
    ///
    /// \> [!NOTE]\n\> A merge of the different values of the same switch is not attempted,
    /// except for disabled and enabled features. The features specified by
    /// `--enable-features` and `--disable-features` are merged with simple
    /// logic.\n\> *   The features is the union of the specified features
    /// and built-in features.  If a feature is disabled, it is removed from the
    /// enabled features list.
    ///
    /// If you specify command-line switches and use the
    /// `additionalBrowserArguments` parameter, the `--edge-webview-switches`
    /// value takes precedence and is processed last.  If a switch fails to
    /// parse, the switch is ignored.  The default state for the operation is
    /// to run the browser process with no extra flags.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_AdditionalBrowserArguments(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `AdditionalBrowserArguments` property.
    ///
    /// Please note that calling this API twice will replace the previous value
    /// rather than appending to it. If there are multiple switches, there
    /// should be a space in between them. The one exception is if multiple
    /// features are being enabled/disabled for a single switch, in which
    /// case the features should be comma-seperated.
    /// Ex. "--disable-features=feature1,feature2 --some-other-switch --do-something"
    /// </summary>
    function Set_AdditionalBrowserArguments(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The default display language for WebView.  It applies to browser UI such as
    /// context menu and dialogs.  It also applies to the `accept-languages` HTTP
    ///  header that WebView sends to websites. The intended locale value is in the
    /// format of BCP 47 Language Tags. More information can be found from
    /// [IETF BCP47](https://www.ietf.org/rfc/bcp/bcp47.html).
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Language(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `Language` property.
    /// </summary>
    function Set_Language(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Specifies the version of the WebView2 Runtime binaries required to be
    /// compatible with your app.  This defaults to the WebView2 Runtime version
    /// that corresponds with the version of the SDK the app is using.  The
    /// format of this value is the same as the format of the
    /// `BrowserVersionString` property and other `BrowserVersion` values.  Only
    /// the version part of the `BrowserVersion` value is respected.  The channel
    ///  suffix, if it exists, is ignored.  The version of the WebView2 Runtime
    /// binaries actually used may be different from the specified
    /// `TargetCompatibleBrowserVersion`.  The binaries are only guaranteed to be
    /// compatible.  Verify the actual version on the `BrowserVersionString`
    /// property on the `ICoreWebView2Environment`.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_TargetCompatibleBrowserVersion(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Sets the `TargetCompatibleBrowserVersion` property.
    /// </summary>
    function Set_TargetCompatibleBrowserVersion(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The `AllowSingleSignOnUsingOSPrimaryAccount` property is used to enable
    /// single sign on with Azure Active Directory (AAD) and personal Microsoft
    /// Account (MSA) resources inside WebView. All AAD accounts, connected to
    /// Windows and shared for all apps, are supported. For MSA, SSO is only enabled
    /// for the account associated for Windows account login, if any.
    /// Default is disabled. Universal Windows Platform apps must also declare
    /// `enterpriseCloudSSO`
    /// [Restricted capabilities](/windows/uwp/packaging/app-capability-declarations\#restricted-capabilities)
    /// for the single sign on (SSO) to work.
    /// </summary>
    function Get_AllowSingleSignOnUsingOSPrimaryAccount(out allow: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AllowSingleSignOnUsingOSPrimaryAccount` property.
    /// </summary>
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
    /// <summary>
    /// Whether other processes can create WebView2 from WebView2Environment created with the
    /// same user data folder and therefore sharing the same WebView browser process instance.
    /// Default is FALSE.
    /// </summary>
    function Get_ExclusiveUserDataFolderAccess(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `ExclusiveUserDataFolderAccess` property.
    /// The `ExclusiveUserDataFolderAccess` property specifies that the WebView environment
    /// obtains exclusive access to the user data folder.
    /// If the user data folder is already being used by another WebView environment with a
    /// different value for `ExclusiveUserDataFolderAccess` property, the creation of a WebView2Controller
    /// using the environment object will fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
    /// When set as TRUE, no other WebView can be created from other processes using WebView2Environment
    /// objects with the same UserDataFolder. This prevents other processes from creating WebViews
    /// which share the same browser process instance, since sharing is performed among
    /// WebViews that have the same UserDataFolder. When another process tries to create a
    /// WebView2Controller from an WebView2Environment object created with the same user data folder,
    /// it will fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
    /// </summary>
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
    /// <summary>
    /// When `IsCustomCrashReportingEnabled` is set to `TRUE`, Windows won't send crash data to Microsoft endpoint.
    /// `IsCustomCrashReportingEnabled` is default to be `FALSE`, in this case, WebView will respect OS consent.
    /// </summary>
    function Get_IsCustomCrashReportingEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `IsCustomCrashReportingEnabled` property.
    /// </summary>
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
    /// <summary>
    /// Array of custom scheme registrations. The returned
    /// ICoreWebView2CustomSchemeRegistration pointers must be released, and the
    /// array itself must be deallocated with CoTaskMemFree.
    /// </summary>
    {* out schemeRegistrations: PPUserType3 --> out schemeRegistrations: PPCoreWebView2CustomSchemeRegistration    ************** WEBVIEW4DELPHI ************** *}
    function GetCustomSchemeRegistrations(out Count: SYSUINT; out schemeRegistrations: PPCoreWebView2CustomSchemeRegistration): HResult; stdcall;
    /// <summary>
    /// Set the array of custom scheme registrations to be used.
    /// \snippet AppWindow.cpp CoreWebView2CustomSchemeRegistration
    /// </summary>
    {* var schemeRegistrations: ICoreWebView2CustomSchemeRegistration --> schemeRegistrations: PPCoreWebView2CustomSchemeRegistration    ************** WEBVIEW4DELPHI ************** *}
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
    /// <summary>
    /// The `EnableTrackingPrevention` property is used to enable/disable tracking prevention
    /// feature in WebView2. This property enable/disable tracking prevention for all the
    /// WebView2's created in the same environment. By default this feature is enabled to block
    /// potentially harmful trackers and trackers from sites that aren't visited before and set to
    /// `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED` or whatever value was last changed/persisted
    /// on the profile.
    ///
    /// You can set this property to false to disable the tracking prevention feature if the app only
    /// renders content in the WebView2 that is known to be safe. Disabling this feature when creating
    /// environment also improves runtime performance by skipping related code.
    ///
    /// You shouldn't disable this property if WebView2 is being used as a "full browser" with arbitrary
    /// navigation and should protect end user privacy.
    ///
    /// There is `ICoreWebView2Profile3::PreferredTrackingPreventionLevel` property to control levels of
    /// tracking prevention of the WebView2's associated with a same profile. However, you can also disable
    /// tracking prevention later using `ICoreWebView2Profile3::PreferredTrackingPreventionLevel` property and
    /// `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_NONE` value but that doesn't improves runtime performance.
    ///
    /// See `ICoreWebView2Profile3::PreferredTrackingPreventionLevel` for more details.
    ///
    /// Tracking prevention protects users from online tracking by restricting the ability of trackers to
    /// access browser-based storage as well as the network. See [Tracking prevention](/microsoft-edge/web-platform/tracking-prevention).
    /// </summary>
    function Get_EnableTrackingPrevention(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `EnableTrackingPrevention` property.
    /// </summary>
    function Set_EnableTrackingPrevention(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Additional options used to create WebView2 Environment to manage browser extensions.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions6">See the ICoreWebView2EnvironmentOptions6 article.</see></para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions6 = interface(IUnknown)
    ['{57D29CC3-C84F-42A0-B0E2-EFFBD5E179DE}']
    /// <summary>
    /// When `AreBrowserExtensionsEnabled` is set to `TRUE`, new extensions can be added to user
    /// profile and used. `AreBrowserExtensionsEnabled` is default to be `FALSE`, in this case,
    /// new extensions can't be installed, and already installed extension won't be
    /// available to use in user profile.
    /// If connecting to an already running environment with a different value for `AreBrowserExtensionsEnabled`
    /// property, it will fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
    /// See `ICoreWebView2BrowserExtension` for Extensions API details.
    /// </summary>
    function Get_AreBrowserExtensionsEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AreBrowserExtensionsEnabled` property.
    /// </summary>
    function Set_AreBrowserExtensionsEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Additional options used to create the WebView2 Environment that support
  /// specifying the `ReleaseChannels` and `ChannelSearchKind`.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7">See the ICoreWebView2EnvironmentOptions7 article.</see></para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions7 = interface(IUnknown)
    ['{C48D539F-E39F-441C-AE68-1F66E570BDC5}']
    /// <summary>
    /// Gets the `ChannelSearchKind` property.
    /// </summary>
    function Get_ChannelSearchKind(out value: COREWEBVIEW2_CHANNEL_SEARCH_KIND): HResult; stdcall;
    /// <summary>
    /// <para>The `ChannelSearchKind` property is `COREWEBVIEW2_CHANNEL_SEARCH_KIND_MOST_STABLE`
    /// by default; environment creation searches for a release channel on the machine
    /// from most to least stable using the first channel found. The default search order is:
    /// WebView2 Runtime -&gt; Beta -&gt; Dev -&gt; Canary. Set `ChannelSearchKind` to
    /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE` to reverse the search order
    /// so that environment creation searches for a channel from least to most stable. If
    /// `ReleaseChannels` has been provided, the loader will only search
    /// for channels in the set. See `COREWEBVIEW2_RELEASE_CHANNELS` for more details
    /// on channels.</para>
    /// <para>This property can be overridden by the corresponding
    /// registry key `ChannelSearchKind` or the environment variable
    /// `WEBVIEW2_CHANNEL_SEARCH_KIND`. Set the value to `1` to set the search kind to
    /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE`. See
    /// `CreateCoreWebView2EnvironmentWithOptions` for more details on overrides.</para>
    /// </summary>
    function Set_ChannelSearchKind(value: COREWEBVIEW2_CHANNEL_SEARCH_KIND): HResult; stdcall;
    /// <summary>
    /// Gets the `ReleaseChannels` property.
    /// </summary>
    function Get_ReleaseChannels(out value: COREWEBVIEW2_RELEASE_CHANNELS): HResult; stdcall;
    /// <summary>
    /// <para>Sets the `ReleaseChannels`, which is a mask of one or more
    /// `COREWEBVIEW2_RELEASE_CHANNELS` indicating which channels environment
    /// creation should search for. OR operation(s) can be applied to multiple
    /// `COREWEBVIEW2_RELEASE_CHANNELS` to create a mask. The default value is a
    /// a mask of all the channels. By default, environment creation searches for
    /// channels from most to least stable, using the first channel found on the
    /// device. When `ReleaseChannels` is provided, environment creation will only
    /// search for the channels specified in the set. Set `ChannelSearchKind` to
    /// `COREWEBVIEW2_CHANNEL_SEARCH_KIND_LEAST_STABLE` to reverse the search order
    /// so environment creation searches for least stable build first. See
    /// `COREWEBVIEW2_RELEASE_CHANNELS` for descriptions of each channel.</para>
    /// <para>`CreateCoreWebView2EnvironmentWithOptions` fails with
    /// `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)` if environment creation is unable
    /// to find any channel from the `ReleaseChannels` installed on the device.
    /// Use `GetAvailableCoreWebView2BrowserVersionStringWithOptions` on
    /// `ICoreWebView2Environment` to verify which channel is used when this option
    /// is set.</para>
    /// Examples:
    /// <code>
    /// |   ReleaseChannels   |   Channel Search Kind: Most Stable (default)   |   Channel Search Kind: Least Stable   |
    /// | --- | --- | --- |
    /// |COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE| WebView2 Runtime -&gt; Beta | Beta -&gt; WebView2 Runtime|
    /// |COREWEBVIEW2_RELEASE_CHANNELS_CANARY \| COREWEBVIEW2_RELEASE_CHANNELS_DEV \| COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE| WebView2 Runtime -&gt; Beta -&gt; Dev -&gt; Canary | Canary -&gt; Dev -&gt; Beta -&gt; WebView2 Runtime |
    /// |COREWEBVIEW2_RELEASE_CHANNELS_CANARY| Canary | Canary |
    /// |COREWEBVIEW2_RELEASE_CHANNELS_BETA \| COREWEBVIEW2_RELEASE_CHANNELS_CANARY \| COREWEBVIEW2_RELEASE_CHANNELS_STABLE | WebView2 Runtime -&gt; Beta -&gt; Canary | Canary -&gt; Beta -&gt; WebView2 Runtime |
    /// </code>
    /// <para>If both `BrowserExecutableFolder` and `ReleaseChannels` are provided, the
    /// `BrowserExecutableFolder` takes precedence, regardless of whether or not the
    /// channel of `BrowserExecutableFolder` is included in the `ReleaseChannels`.</para>
    /// <para>`ReleaseChannels` can be overridden by the corresponding registry override
    /// `ReleaseChannels` or the environment variable `WEBVIEW2_RELEASE_CHANNELS`.</para>
    /// <para>Set the value to a comma-separated string of integers, which map to the
    /// following release channel values: Stable (0), Beta (1), Dev (2), and
    /// Canary (3). For example, the values "0,2" and "2,0" indicate that environment
    /// creation should only search for Dev channel and the WebView2 Runtime, using the
    /// order indicated by `ChannelSearchKind`. Environment creation attempts to
    /// interpret each integer and treats any invalid entry as Stable channel. See
    /// `CreateCoreWebView2EnvironmentWithOptions` for more details on overrides.</para>
    /// </summary>
    function Set_ReleaseChannels(value: COREWEBVIEW2_RELEASE_CHANNELS): HResult; stdcall;
  end;

  /// <summary>
  /// Additional options used to create WebView2 Environment.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions8">See the ICoreWebView2EnvironmentOptions8 article.</see></para>
  /// </remarks>
  ICoreWebView2EnvironmentOptions8 = interface(IUnknown)
    ['{7C7ECF51-E918-5CAF-853C-E9A2BCC27775}']
    /// <summary>
    /// Gets the `ScrollBarStyle` property.
    /// </summary>
    function Get_ScrollBarStyle(out value: COREWEBVIEW2_SCROLLBAR_STYLE): HResult; stdcall;
    /// <summary>
    /// The ScrollBar style being set on the WebView2 Environment.
    /// The default value is `COREWEBVIEW2_SCROLLBAR_STYLE_DEFAULT`
    /// which specifies the default browser ScrollBar style.
    /// The `color-scheme` CSS property needs to be set on the corresponding page
    /// to allow ScrollBar to follow light or dark theme. Please see
    /// [color-scheme](https://developer.mozilla.org/docs/Web/CSS/color-scheme#declaring_color_scheme_preferences)
    /// for how `color-scheme` can be set.
    /// CSS styles that modify the ScrollBar applied on top of native ScrollBar styling
    /// that is selected with `ScrollBarStyle`.
    /// </summary>
    function Set_ScrollBarStyle(value: COREWEBVIEW2_SCROLLBAR_STYLE): HResult; stdcall;
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
    /// <summary>
    /// Add an event handler for the `NavigationStarting` event.
    /// A frame navigation will raise a `NavigationStarting` event and
    /// a `CoreWebView2.FrameNavigationStarting` event. All of the
    /// `FrameNavigationStarting` event handlers for the current frame will be
    /// run before the `NavigationStarting` event handlers. All of the event handlers
    /// share a common `NavigationStartingEventArgs` object. Whichever event handler is
    /// last to change the `NavigationStartingEventArgs.Cancel` property will
    /// decide if the frame navigation will be cancelled. Redirects raise this
    /// event as well, and the navigation id is the same as the original one.
    ///
    /// Navigations will be blocked until all `NavigationStarting` and
    /// `CoreWebView2.FrameNavigationStarting` event handlers return.
    /// </summary>
    function add_NavigationStarting(const eventHandler: ICoreWebView2FrameNavigationStartingEventHandler;
                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_NavigationStarting`.
    /// </summary>
    function remove_NavigationStarting(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `ContentLoading` event.  `ContentLoading`
    /// triggers before any content is loaded, including scripts added with
    /// `AddScriptToExecuteOnDocumentCreated`.  `ContentLoading` does not trigger
    /// if a same page navigation occurs (such as through `fragment`
    /// navigations or `history.pushState` navigations).  This operation
    /// follows the `NavigationStarting` and precedes `NavigationCompleted` events.
    /// </summary>
    function add_ContentLoading(const eventHandler: ICoreWebView2FrameContentLoadingEventHandler;
                                out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_ContentLoading`.
    /// </summary>
    function remove_ContentLoading(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `NavigationCompleted` event.
    /// `NavigationCompleted` runs when the CoreWebView2Frame has completely
    /// loaded (concurrently when `body.onload` runs) or loading stopped with error.
    /// </summary>
    function add_NavigationCompleted(const eventHandler: ICoreWebView2FrameNavigationCompletedEventHandler;
                                     out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_NavigationCompleted`.
    /// </summary>
    function remove_NavigationCompleted(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the DOMContentLoaded event.
    /// DOMContentLoaded is raised when the iframe html document has been parsed.
    /// This aligns with the document's DOMContentLoaded event in html.
    /// </summary>
    function add_DOMContentLoaded(const eventHandler: ICoreWebView2FrameDOMContentLoadedEventHandler;
                                  out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with add_DOMContentLoaded.
    /// </summary>
    function remove_DOMContentLoaded(token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Run JavaScript code from the javascript parameter in the current frame.
    /// The result of evaluating the provided JavaScript is passed to the completion handler.
    /// The result value is a JSON encoded string. If the result is undefined,
    /// contains a reference cycle, or otherwise is not able to be encoded into
    /// JSON, then the result is considered to be null, which is encoded
    /// in JSON as the string "null".
    ///
    /// \> [!NOTE]\n\> A function that has no explicit return value returns undefined. If the
    /// script that was run throws an unhandled exception, then the result is
    /// also "null". This method is applied asynchronously. If the method is
    /// run before `ContentLoading`, the script will not be executed
    /// and the string "null" will be returned.
    /// This operation executes the script even if `ICoreWebView2Settings::IsScriptEnabled` is
    /// set to `FALSE`.
    ///
    /// \snippet ScenarioDOMContentLoaded.cpp ExecuteScriptFrame
    /// </summary>
    function ExecuteScript(javaScript: PWideChar;
                           const handler: ICoreWebView2ExecuteScriptCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Posts the specified webMessage to the frame.
    /// The frame receives the message by subscribing to the `message` event of
    /// the `window.chrome.webview` of the frame document.
    ///
    /// ```cpp
    /// window.chrome.webview.addEventListener('message', handler)
    /// window.chrome.webview.removeEventListener('message', handler)
    /// ```
    ///
    /// The event args is an instances of `MessageEvent`. The
    /// `ICoreWebView2Settings::IsWebMessageEnabled` setting must be `TRUE` or
    /// the message will not be sent. The `data` property of the event
    /// args is the `webMessage` string parameter parsed as a JSON string into a
    /// JavaScript object. The `source` property of the event args is a reference
    /// to the `window.chrome.webview` object.  For information about sending
    /// messages from the HTML document in the WebView to the host, navigate to
    /// [add_WebMessageReceived](/microsoft-edge/webview2/reference/win32/icorewebview2#add_webmessagereceived).
    /// The message is delivered asynchronously. If a navigation occurs before the
    /// message is posted to the page, the message is discarded.
    /// </summary>
    function PostWebMessageAsJson(webMessageAsJson: PWideChar): HResult; stdcall;
    /// <summary>
    /// Posts a message that is a simple string rather than a JSON string
    /// representation of a JavaScript object. This behaves in exactly the same
    /// manner as `PostWebMessageAsJson`, but the `data` property of the event
    /// args of the `window.chrome.webview` message is a string with the same
    /// value as `webMessageAsString`. Use this instead of
    /// `PostWebMessageAsJson` if you want to communicate using simple strings
    /// rather than JSON objects.
    /// </summary>
    function PostWebMessageAsString(webMessageAsString: PWideChar): HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `WebMessageReceived` event.
    /// `WebMessageReceived` runs when the
    /// `ICoreWebView2Settings::IsWebMessageEnabled` setting is set and the
    /// frame document runs `window.chrome.webview.postMessage`.
    /// The `postMessage` function is `void postMessage(object)`
    /// where object is any object supported by JSON conversion.
    ///
    /// \snippet assets\ScenarioWebMessage.html chromeWebView
    ///
    /// When the frame calls `postMessage`, the object parameter is converted to a
    /// JSON string and is posted asynchronously to the host process. This will
    /// result in the handlers `Invoke` method being called with the JSON string
    /// as its parameter.
    ///
    /// \snippet ScenarioWebMessage.cpp WebMessageReceivedIFrame
    /// </summary>
    function add_WebMessageReceived(const handler: ICoreWebView2FrameWebMessageReceivedEventHandler;
                                    out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Remove an event handler previously added with `add_WebMessageReceived`.
    /// </summary>
    function remove_WebMessageReceived(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `NavigationStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenavigationstartingeventhandler">See the ICoreWebView2FrameNavigationStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameNavigationStartingEventHandler = interface(IUnknown)
    ['{E79908BF-2D5D-4968-83DB-263FEA2C1DA3}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2NavigationStartingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `ContentLoading` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framecontentloadingeventhandler">See the ICoreWebView2FrameContentLoadingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameContentLoadingEventHandler = interface(IUnknown)
    ['{0D6156F2-D332-49A7-9E03-7D8F2FEEEE54}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2ContentLoadingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `NavigationCompleted` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framenavigationcompletedeventhandler">See the ICoreWebView2FrameNavigationCompletedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameNavigationCompletedEventHandler = interface(IUnknown)
    ['{609302AD-0E36-4F9A-A210-6A45272842A9}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2NavigationCompletedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `DOMContentLoaded` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framedomcontentloadedeventhandler">See the ICoreWebView2FrameDOMContentLoadedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameDOMContentLoadedEventHandler = interface(IUnknown)
    ['{38D9520D-340F-4D1E-A775-43FCE9753683}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame; 
                    const args: ICoreWebView2DOMContentLoadedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `WebMessageReceived` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framewebmessagereceivedeventhandler">See the ICoreWebView2FrameWebMessageReceivedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameWebMessageReceivedEventHandler = interface(IUnknown)
    ['{E371E005-6D1D-4517-934B-A8F1629C62A5}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// Adds an event handler for the `PermissionRequested` event.
    /// `PermissionRequested` is raised when content in an iframe any of its
    /// descendant iframes requests permission to privileged resources.
    ///
    /// This relates to the `PermissionRequested` event on the `CoreWebView2`.
    /// Both these events will be raised in the case of an iframe requesting
    /// permission. The `CoreWebView2Frame`'s event handlers will be invoked
    /// before the event handlers on the `CoreWebView2`. If the `Handled` property
    /// of the `PermissionRequestedEventArgs` is set to TRUE within the
    /// `CoreWebView2Frame` event handler, then the event will not be
    /// raised on the `CoreWebView2`, and it's event handlers will not be invoked.
    ///
    /// In the case of nested iframes, if the `PermissionRequested` event is handled
    /// in the current nested iframe (i.e., the Handled property of the
    /// `PermissionRequestedEventArgs` is set to TRUE), the event will not be raised
    /// on the parent `CoreWebView2Frame`. However, if the `PermissionRequested` event is
    /// not handled in that nested iframe, the event will be raised from its nearest
    /// tracked parent `CoreWebView2Frame`. It will iterate through the parent frame
    /// chain up to the main frame until a parent frame handles the request.
    ///
    /// If a deferral is not taken on the event args, the subsequent scripts are
    /// blocked until the event handler returns.  If a deferral is taken, the
    /// scripts are blocked until the deferral is completed.
    ///
    /// \snippet ScenarioIFrameDevicePermission.cpp PermissionRequested0
    /// \snippet ScenarioIFrameDevicePermission.cpp PermissionRequested1
    /// </summary>
    function add_PermissionRequested(const eventHandler: ICoreWebView2FramePermissionRequestedEventHandler;
                                     out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_PermissionRequested`
    /// </summary>
    function remove_PermissionRequested(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `PermissionRequested` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framepermissionrequestedeventhandler">See the ICoreWebView2FramePermissionRequestedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FramePermissionRequestedEventHandler = interface(IUnknown)
    ['{845D0EDD-8BD8-429B-9915-4821789F23E9}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
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
    /// <summary>
    /// By default, both the `PermissionRequested` event handlers on the
    /// `CoreWebView2Frame` and the `CoreWebView2` will be invoked, with the
    /// `CoreWebView2Frame` event handlers invoked first. The host may
    /// set this flag to `TRUE` within the `CoreWebView2Frame` event handlers
    /// to prevent the remaining `CoreWebView2` event handlers from being invoked.
    ///
    /// If a deferral is taken on the event args, then you must synchronously
    /// set `Handled` to TRUE prior to taking your deferral to prevent the
    /// `CoreWebView2`s event handlers from being invoked.
    /// </summary>
    function Get_Handled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `Handled` property.
    /// </summary>
    function Set_Handled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// This is an extension of the ICoreWebView2Frame interface that supports shared buffer based on file mapping.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame4">See the ICoreWebView2Frame4 article.</see></para>
  /// </remarks>
  ICoreWebView2Frame4 = interface(ICoreWebView2Frame3)
    ['{188782DC-92AA-4732-AB3C-FCC59F6F68B9}']
    /// <summary>
    /// Share a shared buffer object with script of the iframe in the WebView.
    /// The script will receive a `sharedbufferreceived` event from chrome.webview.
    /// The event arg for that event will have the following methods and properties:
    ///   `getBuffer()`: return an ArrayBuffer object with the backing content from the shared buffer.
    ///   `additionalData`: an object as the result of parsing `additionalDataAsJson` as JSON string.
    ///           This property will be `undefined` if `additionalDataAsJson` is nullptr or empty string.
    ///   `source`: with a value set as `chrome.webview` object.
    /// If a string is provided as `additionalDataAsJson` but it is not a valid JSON string,
    /// the API will fail with `E_INVALIDARG`.
    /// If `access` is COREWEBVIEW2_SHARED_BUFFER_ACCESS_READ_ONLY, the script will only have read access to the buffer.
    /// If the script tries to modify the content in a read only buffer, it will cause an access
    /// violation in WebView renderer process and crash the renderer process.
    /// If the shared buffer is already closed, the API will fail with `RO_E_CLOSED`.
    ///
    /// The script code should call `chrome.webview.releaseBuffer` with
    /// the shared buffer as the parameter to release underlying resources as soon
    /// as it does not need access to the shared buffer any more.
    ///
    /// The application can post the same shared buffer object to multiple web pages or iframes, or
    /// post to the same web page or iframe multiple times. Each `PostSharedBufferToScript` will
    /// create a separate ArrayBuffer object with its own view of the memory and is separately
    /// released. The underlying shared memory will be released when all the views are released.
    ///
    /// For example, if we want to send data to script for one time read only consumption.
    ///
    /// \snippet ScenarioSharedBuffer.cpp OneTimeShareBuffer
    ///
    /// In the HTML document,
    ///
    /// \snippet assets\ScenarioSharedBuffer.html ShareBufferScriptCode_1
    ///
    /// \snippet assets\ScenarioSharedBuffer.html ShareBufferScriptCode_2
    ///
    /// Sharing a buffer to script has security risk. You should only share buffer with trusted site.
    /// If a buffer is shared to a untrusted site, possible sensitive information could be leaked.
    /// If a buffer is shared as modifiable by the script and the script modifies it in an unexpected way,
    /// it could result in corrupted data that might even crash the application.
    /// </summary>
    function PostSharedBufferToScript(const sharedBuffer: ICoreWebView2SharedBuffer; 
                                      access: COREWEBVIEW2_SHARED_BUFFER_ACCESS;
                                      additionalDataAsJson: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// This is an extension of the ICoreWebView2Frame interface that provides the `FrameId` property.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame5">See the ICoreWebView2Frame5 article.</see></para>
  /// </remarks>
  ICoreWebView2Frame5 = interface(ICoreWebView2Frame4)
    ['{99D199C4-7305-11EE-B962-0242AC120002}']
    /// <summary>
    /// The unique identifier of the current frame. It's the same kind of ID as
    /// with the `FrameId` in `CoreWebView2` and via `CoreWebView2FrameInfo`.
    /// </summary>
    function Get_FrameId(out value: SYSUINT): HResult; stdcall;
  end;

  /// <summary>
  /// This is an extension of the ICoreWebView2Frame interface that supports ScreenCaptureStarting.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame6">See the ICoreWebView2Frame6 article.</see></para>
  /// </remarks>
  ICoreWebView2Frame6 = interface(ICoreWebView2Frame5)
    ['{0DE611FD-31E9-5DDC-9D71-95EDA26EFF32}']
    /// <summary>
    /// Adds an event handler for the `ScreenCaptureStarting` event.
    /// Add an event handler for the `ScreenCaptureStarting` event.
    /// `ScreenCaptureStarting` is raised when content in an iframe or any of its
    /// descendant iframes requests permission to use the Screen Capture
    /// API from getDisplayMedia().
    ///
    /// This relates to the `ScreenCaptureStarting` event on the
    /// `CoreWebView2`.
    /// Both these events will be raised in the case of an iframe requesting
    /// screen capture. The `CoreWebView2Frame`'s event handlers will be invoked
    /// before the event handlers on the `CoreWebView2`. If the `Handled`
    /// property of the `ScreenCaptureStartingEventArgs` is set to TRUE
    /// within the`CoreWebView2Frame` event handler, then the event will not
    /// be raised on the `CoreWebView2`, and its event handlers will not be
    /// invoked.
    ///
    /// \snippet ScenarioScreenCapture.cpp ScreenCaptureStarting1
    /// </summary>
    function add_ScreenCaptureStarting(const eventHandler: ICoreWebView2FrameScreenCaptureStartingEventHandler;
                                       out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_ScreenCaptureStarting`.
    /// </summary>
    function remove_ScreenCaptureStarting(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `ScreenCaptureStarting` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framescreencapturestartingeventhandler">See the ICoreWebView2FrameScreenCaptureStartingEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameScreenCaptureStartingEventHandler = interface(IUnknown)
    ['{A6C1D8AD-BB80-59C5-895B-FBA1698B9309}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame;
                    const args: ICoreWebView2ScreenCaptureStartingEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// This is the `ICoreWebView2Frame` interface to support tracking
  /// of nested iframes.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frame7">See the ICoreWebView2Frame7 article.</see></para>
  /// </remarks>
  ICoreWebView2Frame7 = interface(ICoreWebView2Frame6)
    ['{3598CFA2-D85D-5A9F-9228-4DDE1F59EC64}']
    /// <summary>
    /// Adds an event handler for the `FrameCreated` event.
    /// Raised when a new direct descendant iframe is created.
    /// Handle this event to get access to ICoreWebView2Frame objects.
    /// Use `ICoreWebView2Frame.add_Destroyed` to listen for when this
    /// iframe goes away.
    ///
    /// \snippet ScenarioWebViewEventMonitor.cpp FrameCreated
    /// </summary>
    function add_FrameCreated(const eventHandler: ICoreWebView2FrameChildFrameCreatedEventHandler;
                              out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_FrameCreated`.
    /// </summary>
    function remove_FrameCreated(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `FrameCreated` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2framechildframecreatedeventhandler">See the ICoreWebView2FrameChildFrameCreatedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2FrameChildFrameCreatedEventHandler = interface(IUnknown)
    ['{569E40E7-46B7-563D-83AE-1073155664D7}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Frame; const args: ICoreWebView2FrameCreatedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2FrameInfo interface that provides
  /// `ParentFrameInfo`, `FrameId` and `FrameKind` properties.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2frameinfo2">See the ICoreWebView2FrameInfo2 article.</see></para>
  /// </remarks>
  ICoreWebView2FrameInfo2 = interface(ICoreWebView2FrameInfo)
    ['{56F85CFA-72C4-11EE-B962-0242AC120002}']
    /// <summary>
    /// This parent frame's `FrameInfo`. `ParentFrameInfo` will only be
    /// populated when obtained via calling
    ///`CoreWebView2ProcessExtendedInfo.AssociatedFrameInfos`.
    /// `CoreWebView2FrameInfo` objects obtained via `CoreWebView2.ProcessFailed` will
    /// always have a `null` `ParentFrameInfo`. This property is also `null` for the
    /// main frame in the WebView2 which has no parent frame.
    /// Note that this `ParentFrameInfo` could be out of date as it's a snapshot.
    /// </summary>
    function Get_ParentFrameInfo(out frameInfo: ICoreWebView2FrameInfo): HResult; stdcall;
    /// <summary>
    /// The unique identifier of the frame associated with the current `FrameInfo`.
    /// It's the same kind of ID as with the `FrameId` in `CoreWebView2` and via
    /// `CoreWebView2Frame`. `FrameId` will only be populated (non-zero) when obtained
    /// calling `CoreWebView2ProcessExtendedInfo.AssociatedFrameInfos`.
    /// `CoreWebView2FrameInfo` objects obtained via `CoreWebView2.ProcessFailed` will
    /// always have an invalid frame Id 0.
    /// Note that this `FrameId` could be out of date as it's a snapshot.
    /// If there's WebView2 created or destroyed or `FrameCreated/FrameDestroyed` events
    /// after the asynchronous call `CoreWebView2Environment.GetProcessExtendedInfos`
    /// starts, you may want to call asynchronous method again to get the updated `FrameInfo`s.
    /// </summary>
    function Get_FrameId(out id: SYSUINT): HResult; stdcall;
    /// <summary>
    /// The frame kind of the frame. `FrameKind` will only be populated when
    /// obtained calling `CoreWebView2ProcessExtendedInfo.AssociatedFrameInfos`.
    /// `CoreWebView2FrameInfo` objects obtained via `CoreWebView2.ProcessFailed`
    /// will always have the default value `COREWEBVIEW2_FRAME_KIND_UNKNOWN`.
    /// Note that this `FrameKind` could be out of date as it's a snapshot.
    /// </summary>
    function Get_FrameKind(out Kind: COREWEBVIEW2_FRAME_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `GetNonDefaultPermissionSettings` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2getnondefaultpermissionsettingscompletedhandler">See the ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler = interface(IUnknown)
    ['{38274481-A15C-4563-94CF-990EDC9AEB95}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2PermissionSettingCollectionView): HResult; stdcall;
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
    /// <summary>
    /// Gets the `ICoreWebView2PermissionSetting` at the specified index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out permissionSetting: ICoreWebView2PermissionSetting): HResult; stdcall;
    /// <summary>
    /// The number of `ICoreWebView2PermissionSetting`s in the collection.
    /// </summary>
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
    /// <summary>
    /// The kind of the permission setting. See `COREWEBVIEW2_PERMISSION_KIND` for
    /// more details.
    /// </summary>
    function Get_PermissionKind(out value: COREWEBVIEW2_PERMISSION_KIND): HResult; stdcall;
    /// <summary>
    /// The origin of the permission setting.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_PermissionOrigin(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The state of the permission setting.
    /// </summary>
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
    /// <summary>
    /// The HTTP status code of the navigation if it involved an HTTP request.
    /// For instance, this will usually be 200 if the request was successful, 404
    /// if a page was not found, etc.  See
    /// https://developer.mozilla.org/docs/Web/HTTP/Status for a list of
    /// common status codes.
    ///
    /// The `HttpStatusCode` property will be 0 in the following cases:
    /// * The navigation did not involve an HTTP request.  For instance, if it was
    ///   a navigation to a file:// URL, or if it was a same-document navigation.
    /// * The navigation failed before a response was received.  For instance, if
    ///   the hostname was not found, or if there was a network error.
    ///
    /// In those cases, you can get more information from the `IsSuccess` and
    /// `WebErrorStatus` properties.
    ///
    /// If the navigation receives a successful HTTP response, but the navigated
    /// page calls `window.stop()` before it finishes loading, then
    /// `HttpStatusCode` may contain a success code like 200, but `IsSuccess` will
    /// be FALSE and `WebErrorStatus` will be
    /// `COREWEBVIEW2_WEB_ERROR_STATUS_CONNECTION_ABORTED`.
    ///
    /// Since WebView2 handles HTTP continuations and redirects automatically, it
    /// is unlikely for `HttpStatusCode` to ever be in the 1xx or 3xx ranges.
    /// </summary>
    function Get_HttpStatusCode(out value: SYSINT): HResult; stdcall;
  end;

  /// <summary>
  /// The AdditionalAllowedFrameAncestors API that enable developers to provide additional allowed frame ancestors.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2navigationstartingeventargs2">See the ICoreWebView2NavigationStartingEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2NavigationStartingEventArgs2 = interface(ICoreWebView2NavigationStartingEventArgs)
    ['{9086BE93-91AA-472D-A7E0-579F2BA006AD}']
    /// <summary>
    /// Get additional allowed frame ancestors set by the host app.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_AdditionalAllowedFrameAncestors(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// The app may set this property to allow a frame to be embedded by additional ancestors besides what is allowed by
    /// http header [X-Frame-Options](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Frame-Options)
    /// and [Content-Security-Policy frame-ancestors directive](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy/frame-ancestors).
    /// If set, a frame ancestor is allowed if it is allowed by the additional allowed frame
    /// ancestors or original http header from the site.
    /// Whether an ancestor is allowed by the additional allowed frame ancestors is done the same way as if the site provided
    /// it as the source list of the Content-Security-Policy frame-ancestors directive.
    /// For example, if `https://example.com` and `https://www.example.com` are the origins of the top
    /// page and intermediate iframes that embed a nested site-embedding iframe, and you fully trust
    /// those origins, you should set this property to `https://example.com https://www.example.com`.
    /// This property gives the app the ability to use iframe to embed sites that otherwise
    /// could not be embedded in an iframe in trusted app pages.
    /// This could potentially subject the embedded sites to [Clickjacking](https://en.wikipedia.org/wiki/Clickjacking)
    /// attack from the code running in the embedding web page. Therefore, you should only
    /// set this property with origins of fully trusted embedding page and any intermediate iframes.
    /// Whenever possible, you should use the list of specific origins of the top and intermediate
    /// frames instead of wildcard characters for this property.
    /// This API is to provide limited support for app scenarios that used to be supported by
    /// `<webview>` element in other solutions like JavaScript UWP apps and Electron.
    /// You should limit the usage of this property to trusted pages, and specific navigation
    /// target url, by checking the `Source` of the WebView2, and `Uri` of the event args.
    ///
    /// This property is ignored for top level document navigation.
    ///
    /// \snippet ScriptComponent.cpp AdditionalAllowedFrameAncestors_1
    ///
    /// \snippet ScriptComponent.cpp AdditionalAllowedFrameAncestors_2
    /// </summary>
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
    /// <summary>
    /// Get the navigation kind of this navigation.
    /// </summary>
    function Get_NavigationKind(out value: COREWEBVIEW2_NAVIGATION_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// This is a continuation of the ICoreWebView2NewWindowRequestedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs2">See the ICoreWebView2NewWindowRequestedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2NewWindowRequestedEventArgs2 = interface(ICoreWebView2NewWindowRequestedEventArgs)
    ['{BBC7BAED-74C6-4C92-B63A-7F5AEAE03DE3}']
    /// <summary>
    /// Gets the name of the new window. This window can be created via `window.open(url, windowName)`,
    /// where the windowName parameter corresponds to `Name` property.
    /// If no windowName is passed to `window.open`, then the `Name` property
    /// will be set to an empty string. Additionally, if window is opened through other means,
    /// such as `<a target="windowName">...</a>` or `<iframe name="windowName">...</iframe>`,
    /// then the `Name` property will be set accordingly. In the case of target=_blank,
    /// the `Name` property will be an empty string.
    /// Opening a window via ctrl+clicking a link would result in the `Name` property
    /// being set to an empty string.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_name(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// This is a continuation of the ICoreWebView2NewWindowRequestedEventArgs interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2newwindowrequestedeventargs3">See the ICoreWebView2NewWindowRequestedEventArgs3 article.</see></para>
  /// </remarks>
  ICoreWebView2NewWindowRequestedEventArgs3 = interface(ICoreWebView2NewWindowRequestedEventArgs2)
    ['{842BED3C-6AD6-4DD9-B938-28C96667AD66}']
    /// <summary>
    /// The frame info of the frame where the new window request originated. The
    /// `OriginalSourceFrameInfo` is a snapshot of frame information at the time when the
    /// new window was requested. See `ICoreWebView2FrameInfo` for details on frame
    /// properties.
    /// </summary>
    function Get_OriginalSourceFrameInfo(out value: ICoreWebView2FrameInfo): HResult; stdcall;
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
    /// <summary>
    /// The permission state set from the `PermissionRequested` event is saved in
    /// the profile by default; it persists across sessions and becomes the new
    /// default behavior for future `PermissionRequested` events. Browser
    /// heuristics can affect whether the event continues to be raised when the
    /// state is saved in the profile. Set the `SavesInProfile` property to
    /// `FALSE` to not persist the state beyond the current request, and to
    /// continue to receive `PermissionRequested`
    /// events for this origin and permission kind.
    /// </summary>
    function Get_SavesInProfile(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `SavesInProfile` property.
    /// </summary>
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
    /// <summary>
    /// Page range to print. Defaults to empty string, which means print all pages.
    /// If the Page range is empty string or null, then it applies the default.
    ///
    /// The PageRanges property is a list of page ranges specifying one or more pages that
    /// should be printed separated by commas. Any whitespace between page ranges is ignored.
    /// A valid page range is either a single integer identifying the page to print, or a range
    /// in the form `[start page]-[last page]` where `start page` and `last page` are integers
    /// identifying the first and last inclusive pages respectively to print.
    /// Every page identifier is an integer greater than 0 unless wildcards are used (see below examples).
    /// The first page is 1.
    ///
    /// In a page range of the form `[start page]-[last page]` the start page number must be
    /// larger than 0 and less than or equal to the document's total page count.
    /// If the `start page` is not present, then 1 is used as the `start page`.
    /// The `last page` must be larger than the `start page`.
    /// If the `last page` is not present, then the document total page count is used as the `last page`.
    ///
    /// Repeating a page does not print it multiple times. To print multiple times, use the `Copies` property.
    ///
    /// The pages are always printed in ascending order, even if specified in non-ascending order.
    ///
    /// If page range is not valid or if a page is greater than document total page count,
    /// `ICoreWebView2PrintCompletedHandler` or `ICoreWebView2PrintToPdfStreamCompletedHandler`
    /// handler will return `E_INVALIDARG`.
    ///
    /// The following examples assume a document with 20 total pages.
    ///
    /// |       Example         |       Result      |               Notes                                              |
    /// | --- | --- | --- |
    /// | "2"                   |  Page 2           |                                                                  |
    /// | "1-4, 9, 3-6, 10, 11" |  Pages 1-6, 9-11  |                                                                  |
    /// | "1-4, -6"             |  Pages 1-6        | The "-6" is interpreted as "1-6".                                |
    /// | "2-"                  |  Pages 2-20       | The "2-" is interpreted as "pages 2 to the end of the document". |
    /// | "4-2, 11, -6"         |  Invalid          | "4-2" is an invalid range.                                       |
    /// | "-"                   |  Pages 1-20       | The "-" is interpreted as "page 1 to the end of the document".   |
    /// | "1-4dsf, 11"          |  Invalid          |                                                                  |
    /// | "2-2"                 |  Page 2           |                                                                  |
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings)
    /// </summary>
    function Get_PageRanges(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Set the `PageRanges` property.
    /// </summary>
    function Set_PageRanges(value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Prints multiple pages of a document on a single piece of paper. Choose from 1, 2, 4, 6, 9 or 16.
    /// The default value is 1.
    /// </summary>
    function Get_PagesPerSide(out value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Set the `PagesPerSide` property. Returns `E_INVALIDARG` if an invalid value is
    /// provided, and the current value is not changed.
    ///
    /// Below examples shows print output for PagesPerSide and Duplex.
    ///
    /// |  PagesPerSide   |    Total pages   | Two-sided printing |              Result                                               |
    /// | --- | --- | --- | --- |
    /// |      1          |      1           |        -           | 1 page on the front side.                                         |
    /// |      2          |      1           |        Yes         | 1 page on the front side.                                         |
    /// |      2          |      4           |        -           | 2 pages on the first paper and 2 pages on the next paper.         |
    /// |      2          |      4           |        Yes         | 2 pages on the front side and 2 pages on back side.               |
    /// |      4          |      4           |        Yes         | 4 pages on the front side.                                        |
    /// |      4          |      8           |        Yes         | 4 pages on the front side and 4 pages on the back side.           |
    /// </summary>
    function Set_PagesPerSide(value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Number of copies to print. Minimum value is `1` and the maximum copies count is `999`.
    /// The default value is 1.
    ///
    /// This value is ignored in PrintToPdfStream method.
    /// </summary>
    function Get_Copies(out value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Set the `Copies` property. Returns `E_INVALIDARG` if an invalid value is provided
    /// and the current value is not changed.
    /// </summary>
    function Set_Copies(value: SYSINT): HResult; stdcall;
    /// <summary>
    /// Printer collation. See `COREWEBVIEW2_PRINT_COLLATION` for descriptions of
    /// collation. The default value is `COREWEBVIEW2_PRINT_COLLATION_DEFAULT`.
    ///
    /// Printing uses default value of printer's collation if an invalid value is provided
    /// for the specific printer.
    ///
    /// This value is ignored in PrintToPdfStream method.
    /// </summary>
    function Get_Collation(out value: COREWEBVIEW2_PRINT_COLLATION): HResult; stdcall;
    /// <summary>
    /// Set the `Collation` property.
    /// </summary>
    function Set_Collation(value: COREWEBVIEW2_PRINT_COLLATION): HResult; stdcall;
    /// <summary>
    /// Printer color mode. See `COREWEBVIEW2_PRINT_COLOR_MODE` for descriptions
    /// of color modes. The default value is `COREWEBVIEW2_PRINT_COLOR_MODE_DEFAULT`.
    ///
    /// Printing uses default value of printer supported color if an invalid value is provided
    /// for the specific printer.
    /// </summary>
    function Get_ColorMode(out value: COREWEBVIEW2_PRINT_COLOR_MODE): HResult; stdcall;
    /// <summary>
    /// Set the `ColorMode` property.
    /// </summary>
    function Set_ColorMode(value: COREWEBVIEW2_PRINT_COLOR_MODE): HResult; stdcall;
    /// <summary>
    /// Printer duplex settings. See `COREWEBVIEW2_PRINT_DUPLEX` for descriptions of duplex.
    /// The default value is `COREWEBVIEW2_PRINT_DUPLEX_DEFAULT`.
    ///
    /// Printing uses default value of printer's duplex if an invalid value is provided
    /// for the specific printer.
    ///
    /// This value is ignored in PrintToPdfStream method.
    /// </summary>
    function Get_Duplex(out value: COREWEBVIEW2_PRINT_DUPLEX): HResult; stdcall;
    /// <summary>
    /// Set the `Duplex` property.
    /// </summary>
    function Set_Duplex(value: COREWEBVIEW2_PRINT_DUPLEX): HResult; stdcall;
    /// <summary>
    /// Printer media size. See `COREWEBVIEW2_PRINT_MEDIA_SIZE` for descriptions of media size.
    /// The default value is `COREWEBVIEW2_PRINT_MEDIA_SIZE_DEFAULT`.
    ///
    /// If media size is `COREWEBVIEW2_PRINT_MEDIA_SIZE_CUSTOM`, you should set the `PageWidth`
    /// and `PageHeight`.
    ///
    /// Printing uses default value of printer supported media size if an invalid value is provided
    /// for the specific printer.
    ///
    /// This value is ignored in PrintToPdfStream method.
    /// </summary>
    function Get_MediaSize(out value: COREWEBVIEW2_PRINT_MEDIA_SIZE): HResult; stdcall;
    /// <summary>
    /// Set the `MediaSize` property.
    /// </summary>
    function Set_MediaSize(value: COREWEBVIEW2_PRINT_MEDIA_SIZE): HResult; stdcall;
    /// <summary>
    /// The name of the printer to use. Defaults to empty string.
    /// If the printer name is empty string or null, then it prints to the default
    /// printer on the user OS.
    ///
    /// This value is ignored in PrintToPdfStream method.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`. See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings)
    /// </summary>
    function Get_PrinterName(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Set the `PrinterName` property. If provided printer name doesn't match
    /// with the name of any installed printers on the user OS,
    /// `ICoreWebView2PrintCompletedHandler` handler will return `errorCode` as
    /// `S_OK` and `printStatus` as COREWEBVIEW2_PRINT_STATUS_PRINTER_UNAVAILABLE.
    ///
    /// Use [Enum Printers](/windows/win32/printdocs/enumprinters)
    /// to enumerate available printers.
    /// </summary>
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
    /// <summary>
    /// The reason for the process failure. Some of the reasons are only
    /// applicable to specific values of
    /// `ICoreWebView2ProcessFailedEventArgs::ProcessFailedKind`, and the
    /// following `ProcessFailedKind` values always return the indicated reason
    /// value:
    ///
    /// ProcessFailedKind | Reason
    /// ---|---
    /// COREWEBVIEW2_PROCESS_FAILED_KIND_BROWSER_PROCESS_EXITED | COREWEBVIEW2_PROCESS_FAILED_REASON_UNEXPECTED
    /// COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_UNRESPONSIVE | COREWEBVIEW2_PROCESS_FAILED_REASON_UNRESPONSIVE
    ///
    /// For other `ProcessFailedKind` values, the reason may be any of the reason
    /// values. To learn about what these values mean, see
    /// `COREWEBVIEW2_PROCESS_FAILED_REASON`.
    /// </summary>
    function Get_reason(out reason: COREWEBVIEW2_PROCESS_FAILED_REASON): HResult; stdcall;
    /// <summary>
    /// The exit code of the failing process, for telemetry purposes. The exit
    /// code is always `STILL_ACTIVE` (`259`) when `ProcessFailedKind` is
    /// `COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_UNRESPONSIVE`.
    /// </summary>
    function Get_ExitCode(out ExitCode: SYSINT): HResult; stdcall;
    /// <summary>
    /// Description of the process assigned by the WebView2 Runtime. This is a
    /// technical English term appropriate for logging or development purposes,
    /// and not localized for the end user. It applies to utility processes (for
    /// example, "Audio Service", "Video Capture") and plugin processes (for
    /// example, "Flash"). The returned `processDescription` is empty if the
    /// WebView2 Runtime did not assign a description to the process.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_ProcessDescription(out ProcessDescription: PWideChar): HResult; stdcall;
    /// <summary>
    /// The collection of `FrameInfo`s for frames in the `ICoreWebView2` that were
    /// being rendered by the failed process. The content in these frames is
    /// replaced with an error page.
    /// This is only available when `ProcessFailedKind` is
    /// `COREWEBVIEW2_PROCESS_FAILED_KIND_FRAME_RENDER_PROCESS_EXITED`;
    /// `frames` is `null` for all other process failure kinds, including the case
    /// in which the failed process was the renderer for the main frame and
    /// subframes within it, for which the failure kind is
    /// `COREWEBVIEW2_PROCESS_FAILED_KIND_RENDER_PROCESS_EXITED`.
    /// </summary>
    function Get_FrameInfosForFailedProcess(out frames: ICoreWebView2FrameInfoCollection): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2ProcessFailedEventArgs2 interface
  /// for getting blocked file for code integrity process failures.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2processfailedeventargs3">See the icorewebview2processfailedeventargs3 article.</see></para>
  /// </remarks>
  ICoreWebView2ProcessFailedEventArgs3 = interface(ICoreWebView2ProcessFailedEventArgs2)
    ['{AB667428-094D-5FD1-B480-8B4C0FDBDF2F}']
    /// <summary>
    /// This property is the full path of the module that caused the
    /// crash in cases of Windows Code Integrity failures.
    /// [Windows Code Integrity](/mem/intune/user-help/you-need-to-enable-code-integrity)
    /// is a feature that verifies the integrity and
    /// authenticity of dynamic-link libraries (DLLs)
    /// on Windows systems. It ensures that only trusted
    /// code can run on the system and prevents unauthorized or
    /// malicious modifications.
    /// When ProcessFailed occurred due to a failed Code Integrity check,
    /// this property returns the full path of the file that was prevented from
    /// loading on the system.
    /// The webview2 process which tried to load the DLL will fail with
    /// exit code STATUS_INVALID_IMAGE_HASH(-1073740760).
    /// A file can fail integrity check for various
    /// reasons, such as:
    /// - It has an invalid or missing signature that does
    /// not match the publisher or signer of the file.
    /// - It has been tampered with or corrupted by malware or other software.
    /// - It has been blocked by an administrator or a security policy.
    /// This property always will be the empty string if failure is not caused by
    /// STATUS_INVALID_IMAGE_HASH.
    ///
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_FailureSourceModulePath(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// Profile2 interface.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2">See the ICoreWebView2Profile2 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile2 = interface(ICoreWebView2Profile)
    ['{FA740D4B-5EAE-4344-A8AD-74BE31925397}']
    /// <summary>
    /// Clear browsing data based on a data type. This method takes two parameters,
    /// the first being a mask of one or more `COREWEBVIEW2_BROWSING_DATA_KINDS`. OR
    /// operation(s) can be applied to multiple `COREWEBVIEW2_BROWSING_DATA_KINDS` to
    /// create a mask representing those data types. The browsing data kinds that are
    /// supported are listed below. These data kinds follow a hierarchical structure in
    /// which nested bullet points are included in their parent bullet point's data kind.
    /// Ex: All DOM storage is encompassed in all site data which is encompassed in
    /// all profile data.
    ///
    /// * All Profile
    ///   * All Site Data
    ///     * All DOM Storage: File Systems, Indexed DB, Local Storage, Web SQL, Cache
    ///         Storage
    ///     * Cookies
    ///   * Disk Cache
    ///   * Download History
    ///   * General Autofill
    ///   * Password Autosave
    ///   * Browsing History
    ///   * Settings
    ///
    /// The completed handler will be invoked when the browsing data has been cleared and
    /// will indicate if the specified data was properly cleared. In the case in which
    /// the operation is interrupted and the corresponding data is not fully cleared
    /// the handler will return `E_ABORT` and otherwise will return `S_OK`.
    /// Because this is an asynchronous operation, code that is dependent on the cleared
    /// data must be placed in the callback of this operation.
    /// If the WebView object is closed before the clear browsing data operation
    /// has completed, the handler will be released, but not invoked. In this case
    /// the clear browsing data operation may or may not be completed.
    /// ClearBrowsingData clears the `dataKinds` regardless of timestamp.
    /// </summary>
    function ClearBrowsingData(dataKinds: COREWEBVIEW2_BROWSING_DATA_KINDS;
                               const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): HResult; stdcall;
    /// <summary>
    /// ClearBrowsingDataInTimeRange behaves like ClearBrowsingData except that it
    /// takes in two additional parameters for the start and end time for which it
    /// should clear the data between.  The `startTime` and `endTime`
    /// parameters correspond to the number of seconds since the UNIX epoch.
    /// `startTime` is inclusive while `endTime` is exclusive, therefore the data will
    /// be cleared between [startTime, endTime).
    /// </summary>
    function ClearBrowsingDataInTimeRange(dataKinds: COREWEBVIEW2_BROWSING_DATA_KINDS;
                                          startTime: Double; endTime: Double;
                                          const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): HResult; stdcall;
    /// <summary>
    /// ClearBrowsingDataAll behaves like ClearBrowsingData except that it
    /// clears the entirety of the data associated with the profile it is called on.
    /// It clears the data regardless of timestamp.
    ///
    /// \snippet AppWindow.cpp ClearBrowsingData
    /// </summary>
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
    /// <summary>
    /// The `PreferredTrackingPreventionLevel` property allows you to control levels of tracking prevention for WebView2
    /// which are associated with a profile. This level would apply to the context of the profile. That is, all WebView2s
    /// sharing the same profile will be affected and also the value is persisted in the user data folder.
    ///
    /// See `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL` for descriptions of levels.
    ///
    /// If tracking prevention feature is enabled when creating the WebView2 environment, you can also disable tracking
    /// prevention later using this property and `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_NONE` value but that doesn't
    /// improves runtime performance.
    ///
    /// There is `ICoreWebView2EnvironmentOptions5::EnableTrackingPrevention` property to enable/disable tracking prevention feature
    /// for all the WebView2's created in the same environment. If enabled, `PreferredTrackingPreventionLevel` is set to
    /// `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED` by default for all the WebView2's and profiles created in the same
    /// environment or is set to the level whatever value was last changed/persisted to the profile. If disabled
    /// `PreferredTrackingPreventionLevel` is not respected by WebView2. If `PreferredTrackingPreventionLevel` is set when the
    /// feature is disabled, the property value get changed and persisted but it will takes effect only if
    /// `ICoreWebView2EnvironmentOptions5::EnableTrackingPrevention` is true.
    ///
    /// See `ICoreWebView2EnvironmentOptions5::EnableTrackingPrevention` for more details.
    /// \snippet SettingsComponent.cpp SetTrackingPreventionLevel
    /// </summary>
    function Get_PreferredTrackingPreventionLevel(out value: COREWEBVIEW2_TRACKING_PREVENTION_LEVEL): HResult; stdcall;
    /// <summary>
    /// Set the `PreferredTrackingPreventionLevel` property.
    ///
    /// If `ICoreWebView2EnvironmentOptions5::EnableTrackingPrevention` is false, this property will be changed and persisted
    /// to the profile but the WebView2 ignores the level silently.
    /// </summary>
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
    /// <summary>
    /// Sets permission state for the given permission kind and origin
    /// asynchronously. The change persists across sessions until it is changed by
    /// another call to `SetPermissionState`, or by setting the `State` property
    /// in `PermissionRequestedEventArgs`. Setting the state to
    /// `COREWEBVIEW2_PERMISSION_STATE_DEFAULT` will erase any state saved in the
    /// profile and restore the default behavior.
    /// The origin should have a valid scheme and host (e.g. "https://www.example.com"),
    /// otherwise the method fails with `E_INVALIDARG`. Additional URI parts like
    /// path and fragment are ignored. For example, "https://wwww.example.com/app1/index.html/"
    /// is treated the same as "https://wwww.example.com". See the
    /// [MDN origin definition](https://developer.mozilla.org/docs/Glossary/Origin)
    /// for more details.
    ///
    /// \snippet ScenarioPermissionManagement.cpp SetPermissionState
    /// </summary>
    function SetPermissionState(PermissionKind: COREWEBVIEW2_PERMISSION_KIND; origin: PWideChar;
                                State: COREWEBVIEW2_PERMISSION_STATE;
                                const handler: ICoreWebView2SetPermissionStateCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Invokes the handler with a collection of all nondefault permission settings.
    /// Use this method to get the permission state set in the current and previous
    /// sessions.
    ///
    /// \snippet ScenarioPermissionManagement.cpp GetNonDefaultPermissionSettings
    /// </summary>
    function GetNonDefaultPermissionSettings(const handler: ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `SetPermissionState` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2setpermissionstatecompletedhandler">See the ICoreWebView2SetPermissionStateCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2SetPermissionStateCompletedHandler = interface(IUnknown)
    ['{FC77FB30-9C9E-4076-B8C7-7644A703CA1B}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
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
    /// <summary>
    /// Get the cookie manager for the profile. All CoreWebView2s associated with this
    /// profile share the same cookie values. Changes to cookies in this cookie manager apply to all
    /// CoreWebView2s associated with this profile.
    /// See ICoreWebView2CookieManager.
    ///
    /// \snippet ScenarioCookieManagement.cpp CookieManagerProfile
    /// </summary>
    function Get_CookieManager(out value: ICoreWebView2CookieManager): HResult; stdcall;
  end;

  /// <summary>
  /// Interfaces in profile for managing password-autosave and general-autofill.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile6">See the ICoreWebView2Profile6 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile6 = interface(ICoreWebView2Profile5)
    ['{BD82FA6A-1D65-4C33-B2B4-0393020CC61B}']
    /// <summary>
    /// IsPasswordAutosaveEnabled controls whether autosave for password
    /// information is enabled. The IsPasswordAutosaveEnabled property behaves
    /// independently of the IsGeneralAutofillEnabled property. When IsPasswordAutosaveEnabled is
    /// false, no new password data is saved and no Save/Update Password prompts are displayed.
    /// However, if there was password data already saved before disabling this setting,
    /// then that password information is auto-populated, suggestions are shown and clicking on
    /// one will populate the fields.
    /// When IsPasswordAutosaveEnabled is true, password information is auto-populated,
    /// suggestions are shown and clicking on one will populate the fields, new data
    /// is saved, and a Save/Update Password prompt is displayed.
    /// It will take effect immediately after setting.
    /// The default value is `FALSE`.
    /// This property has the same value as
    /// `CoreWebView2Settings.IsPasswordAutosaveEnabled`, and changing one will
    /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
    /// will share the same value for this property, so for the `CoreWebView2`s
    /// with the same profile, their
    /// `CoreWebView2Settings.IsPasswordAutosaveEnabled` and
    /// `CoreWebView2Profile.IsPasswordAutosaveEnabled` will always have the same
    /// value.
    ///
    /// \snippet SettingsComponent.cpp ToggleProfilePasswordAutosaveEnabled
    /// </summary>
    function Get_IsPasswordAutosaveEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the IsPasswordAutosaveEnabled property.
    /// </summary>
    function Set_IsPasswordAutosaveEnabled(value: Integer): HResult; stdcall;
    /// <summary>
    /// IsGeneralAutofillEnabled controls whether autofill for information
    /// like names, street and email addresses, phone numbers, and arbitrary input
    /// is enabled. This excludes password and credit card information. When
    /// IsGeneralAutofillEnabled is false, no suggestions appear, and no new information
    /// is saved. When IsGeneralAutofillEnabled is true, information is saved, suggestions
    /// appear and clicking on one will populate the form fields.
    /// It will take effect immediately after setting.
    /// The default value is `TRUE`.
    /// This property has the same value as
    /// `CoreWebView2Settings.IsGeneralAutofillEnabled`, and changing one will
    /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
    /// will share the same value for this property, so for the `CoreWebView2`s
    /// with the same profile, their
    /// `CoreWebView2Settings.IsGeneralAutofillEnabled` and
    /// `CoreWebView2Profile.IsGeneralAutofillEnabled` will always have the same
    /// value.
    ///
    /// \snippet SettingsComponent.cpp ToggleProfileGeneralAutofillEnabled
    /// </summary>
    function Get_IsGeneralAutofillEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the IsGeneralAutofillEnabled property.
    /// </summary>
    function Set_IsGeneralAutofillEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Interfaces in profile for managing browser extensions.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile7">See the ICoreWebView2Profile7 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile7 = interface(ICoreWebView2Profile6)
    ['{7B4C7906-A1AA-4CB4-B723-DB09F813D541}']
    /// <summary>
    /// Adds the [browser extension](https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions)
    /// using the extension path for unpacked extensions from the local device. Extension is
    /// running right after installation.
    /// The extension folder path is the topmost folder of an unpacked browser extension and
    /// contains the browser extension manifest file.
    /// If the `extensionFolderPath` is an invalid path or doesn't contain the extension manifest.json
    /// file, this function will return `ERROR_FILE_NOT_FOUND` to callers.
    /// Installed extension will default `IsEnabled` to true.
    /// When `AreBrowserExtensionsEnabled` is `FALSE`, `AddBrowserExtension` will fail and return
    /// HRESULT `ERROR_NOT_SUPPORTED`.
    /// During installation, the content of the extension is not copied to the user data folder.
    /// Once the extension is installed, changing the content of the extension will cause the
    /// extension to be removed from the installed profile.
    /// When an extension is added the extension is persisted in the corresponding profile. The
    /// extension will still be installed the next time you use this profile.
    /// When an extension is installed from a folder path, adding the same extension from the same
    /// folder path means reinstalling this extension. When two extensions with the same Id are
    /// installed, only the later installed extension will be kept.
    ///
    /// Extensions that are designed to include any UI interactions (e.g. icon, badge, pop up, etc.)
    /// can be loaded and used but will have missing UI entry points due to the lack of browser
    /// UI elements to host these entry points in WebView2.
    ///
    /// The following summarizes the possible error values that can be returned from
    /// `AddBrowserExtension` and a description of why these errors occur.
    ///
    /// Error value                                     | Description
    /// ----------------------------------------------- | --------------------------
    /// `HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)`       | Extensions are disabled.
    /// `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)`      | Cannot find `manifest.json` file or it is not a valid extension manifest.
    /// `E_ACCESSDENIED`                                | Cannot load extension with file or directory name starting with \"_\", reserved for use by the system.
    /// `E_FAIL`                                        | Extension failed to install with other unknown reasons.
    /// </summary>
    function AddBrowserExtension(extensionFolderPath: PWideChar;
                                 const handler: ICoreWebView2ProfileAddBrowserExtensionCompletedHandler): HResult; stdcall;
    /// <summary>
    /// Gets a snapshot of the set of extensions installed at the time `GetBrowserExtensions` is
    /// called. If an extension is installed or uninstalled after `GetBrowserExtensions` completes,
    /// the list returned by `GetBrowserExtensions` remains the same.
    /// When `AreBrowserExtensionsEnabled` is `FALSE`, `GetBrowserExtensions` won't return any
    /// extensions on current user profile.
    /// </summary>
    function GetBrowserExtensions(const handler: ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `AddBrowserExtension` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profileaddbrowserextensioncompletedhandler">See the ICoreWebView2ProfileAddBrowserExtensionCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ProfileAddBrowserExtensionCompletedHandler = interface(IUnknown)
    ['{DF1AAB27-82B9-4AB6-AAE8-017A49398C14}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtension): HResult; stdcall;
  end;

  /// <summary>
  /// Provides a set of properties for managing an Extension, which includes
  /// an ID, name, and whether it is enabled or not, and the ability to Remove
  /// the Extension, and enable or disable it.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextension">See the ICoreWebView2BrowserExtension article.</see></para>
  /// </remarks>
  ICoreWebView2BrowserExtension = interface(IUnknown)
    ['{7EF7FFA0-FAC5-462C-B189-3D9EDBE575DA}']
    /// <summary>
    /// This is the browser extension's ID. This is the same browser extension ID returned by
    /// the browser extension API [`chrome.runtime.id`](https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions/API/runtime/id).
    /// Please see that documentation for more details on how the ID is generated.
    /// After an extension is removed, calling `Id` will return the id of the extension that is removed.
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_id(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// This is the browser extension's name. This value is defined in this browser extension's
    /// manifest.json file. If manifest.json define extension's localized name, this value will
    /// be the localized version of the name.
    /// Please see [Manifest.json name](https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions/manifest.json/name)
    /// for more details.
    /// After an extension is removed, calling `Name` will return the name of the extension that is removed.
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_name(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// Removes this browser extension from its WebView2 Profile. The browser extension is removed
    /// immediately including from all currently running HTML documents associated with this
    /// WebView2 Profile. The removal is persisted and future uses of this profile will not have this
    /// extension installed. After an extension is removed, calling `Remove` again will cause an exception.
    /// </summary>
    function Remove(const handler: ICoreWebView2BrowserExtensionRemoveCompletedHandler): HResult; stdcall;
    /// <summary>
    /// If `isEnabled` is true then the Extension is enabled and running in WebView instances.
    /// If it is false then the Extension is disabled and not running in WebView instances.
    /// When a Extension is first installed, `IsEnable` are default to be `TRUE`.
    /// `isEnabled` is persisted per profile.
    /// After an extension is removed, calling `isEnabled` will return the value at the time it was removed.
    /// </summary>
    function Get_IsEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets whether this browser extension is enabled or disabled. This change applies immediately
    /// to the extension in all HTML documents in all WebView2s associated with this profile.
    /// After an extension is removed, calling `Enable` will not change the value of `IsEnabled`.
    /// </summary>
    function Enable(IsEnabled: Integer;
                    const handler: ICoreWebView2BrowserExtensionEnableCompletedHandler): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `Remove` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionremovecompletedhandler">See the ICoreWebView2BrowserExtensionRemoveCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2BrowserExtensionRemoveCompletedHandler = interface(IUnknown)
    ['{8E41909A-9B18-4BB1-8CDF-930F467A50BE}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `Enable` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionenablecompletedhandler">See the ICoreWebView2BrowserExtensionEnableCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2BrowserExtensionEnableCompletedHandler = interface(IUnknown)
    ['{30C186CE-7FAD-421F-A3BC-A8EAF071DDB8}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult): HResult; stdcall;
  end;

  /// <summary>
  /// Receives the result of the `GetBrowserExtensions` method.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profilegetbrowserextensionscompletedhandler">See the ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler = interface(IUnknown)
    ['{FCE16A1C-F107-4601-8B75-FC4940AE25D0}']
    /// <summary>
    /// Provides the result of the corresponding asynchronous method.
    /// </summary>
    function Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtensionList): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of ICoreWebView2BrowserExtension.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2browserextensionlist">See the ICoreWebView2BrowserExtensionList article.</see></para>
  /// </remarks>
  ICoreWebView2BrowserExtensionList = interface(IUnknown)
    ['{2EF3D2DC-BD5F-4F4D-90AF-FD67798F0C2F}']
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2BrowserExtension): HResult; stdcall;
  end;

  /// <summary>
  /// This is the profile interface that manages profile deletion.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile8">See the ICoreWebView2Profile8 article.</see></para>
  /// </remarks>
  ICoreWebView2Profile8 = interface(ICoreWebView2Profile7)
    ['{FBF70C2F-EB1F-4383-85A0-163E92044011}']
    /// <summary>
    /// After the API is called, the profile will be marked for deletion. The
    /// local profile's directory will be deleted at browser process exit. If it
    /// fails to delete, because something else is holding the files open,
    /// WebView2 will try to delete the profile at all future browser process
    /// starts until successful.
    /// The corresponding CoreWebView2s will be closed and the
    /// CoreWebView2Profile.Deleted event will be raised. See
    /// `CoreWebView2Profile.Deleted` for more information.
    /// If you try to create a new profile with the same name as an existing
    /// profile that has been marked as deleted but hasn't yet been deleted,
    /// profile creation will fail with HRESULT_FROM_WIN32(ERROR_DELETE_PENDING).
    ///
    /// \snippet SettingsComponent.cpp DeleteProfile
    /// </summary>
    function Delete: HResult; stdcall;
    /// <summary>
    /// Add an event handler for the `Deleted` event. The `Deleted` event is
    /// raised when the profile is marked for deletion. When this event is
    /// raised, the CoreWebView2Profile and its corresponding CoreWebView2s have
    /// been closed, and cannot be used anymore.
    ///
    /// \snippet AppWindow.cpp ProfileDeleted
    /// </summary>
    function add_Deleted(const eventHandler: ICoreWebView2ProfileDeletedEventHandler;
                         out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// Removes an event handler previously added with `add_Deleted`.
    /// </summary>
    function remove_Deleted(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `Deleted` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profiledeletedeventhandler">See the ICoreWebView2ProfileDeletedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2ProfileDeletedEventHandler = interface(IUnknown)
    ['{DF35055D-772E-4DBE-B743-5FBF74A2B258}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2Profile; const args: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface that manages the user agent.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings2">See the ICoreWebView2Settings2 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings2 = interface(ICoreWebView2Settings)
    ['{EE9A0F68-F46C-4E32-AC23-EF8CAC224D2A}']
    /// <summary>
    /// Returns the User Agent. The default value is the default User Agent of the
    /// Microsoft Edge browser.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_UserAgent(out value: PWideChar): HResult; stdcall;
    /// <summary>
    /// This setting determines the UserAgent of WebView. This property may be overridden if
    /// the User-Agent header is set in a request. If the parameter is empty
    /// the User Agent will not be updated and the current User Agent will remain.
    /// Setting this property may clear User Agent Client Hints headers
    /// Sec-CH-UA-* and script values from navigator.userAgentData. Current
    /// implementation behavior is subject to change.
    /// The User Agent set will also be effective on service workers
    /// and shared workers associated with the WebView. If there are
    /// multiple WebViews associated with the same service worker or
    /// shared worker, the last User Agent set will be used.
    ///
    /// \snippet SettingsComponent.cpp UserAgent
    /// </summary>
    function Set_UserAgent(value: PWideChar): HResult; stdcall;
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
    /// <summary>
    /// When this setting is set to FALSE, it disables all accelerator keys that
    /// access features specific to a web browser, including but not limited to:
    ///  - Ctrl-F and F3 for Find on Page
    ///  - Ctrl-P for Print
    ///  - Ctrl-R and F5 for Reload
    ///  - Ctrl-Plus and Ctrl-Minus for zooming
    ///  - Ctrl-Shift-C and F12 for DevTools
    ///  - Special keys for browser functions, such as Back, Forward, and Search
    ///
    /// It does not disable accelerator keys related to movement and text editing,
    /// such as:
    ///  - Home, End, Page Up, and Page Down
    ///  - Ctrl-X, Ctrl-C, Ctrl-V
    ///  - Ctrl-A for Select All
    ///  - Ctrl-Z for Undo
    ///
    /// Those accelerator keys will always be enabled unless they are handled in
    /// the `AcceleratorKeyPressed` event.
    ///
    /// This setting has no effect on the `AcceleratorKeyPressed` event.  The event
    /// will be fired for all accelerator keys, whether they are enabled or not.
    ///
    /// The default value for `AreBrowserAcceleratorKeysEnabled` is TRUE.
    ///
    /// \snippet SettingsComponent.cpp AreBrowserAcceleratorKeysEnabled
    /// </summary>
    function Get_AreBrowserAcceleratorKeysEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets the `AreBrowserAcceleratorKeysEnabled` property.
    /// </summary>
    function Set_AreBrowserAcceleratorKeysEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage autofill.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings4">See the ICoreWebView2Settings4 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings4 = interface(ICoreWebView2Settings3)
    ['{CB56846C-4168-4D53-B04F-03B6D6796FF2}']
    /// <summary>
    /// IsPasswordAutosaveEnabled controls whether autosave for password
    /// information is enabled. The IsPasswordAutosaveEnabled property behaves
    /// independently of the IsGeneralAutofillEnabled property. When IsPasswordAutosaveEnabled is
    /// false, no new password data is saved and no Save/Update Password prompts are displayed.
    /// However, if there was password data already saved before disabling this setting,
    /// then that password information is auto-populated, suggestions are shown and clicking on
    /// one will populate the fields.
    /// When IsPasswordAutosaveEnabled is true, password information is auto-populated,
    /// suggestions are shown and clicking on one will populate the fields, new data
    /// is saved, and a Save/Update Password prompt is displayed.
    /// It will take effect immediately after setting.
    /// The default value is `FALSE`.
    /// This property has the same value as
    /// `CoreWebView2Profile.IsPasswordAutosaveEnabled`, and changing one will
    /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
    /// will share the same value for this property, so for the `CoreWebView2`s
    /// with the same profile, their
    /// `CoreWebView2Settings.IsPasswordAutosaveEnabled` and
    /// `CoreWebView2Profile.IsPasswordAutosaveEnabled` will always have the same
    /// value.
    ///
    /// \snippet SettingsComponent.cpp PasswordAutosaveEnabled
    /// </summary>
    function Get_IsPasswordAutosaveEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the IsPasswordAutosaveEnabled property.
    /// </summary>
    function Set_IsPasswordAutosaveEnabled(value: Integer): HResult; stdcall;
    /// <summary>
    /// IsGeneralAutofillEnabled controls whether autofill for information
    /// like names, street and email addresses, phone numbers, and arbitrary input
    /// is enabled. This excludes password and credit card information. When
    /// IsGeneralAutofillEnabled is false, no suggestions appear, and no new information
    /// is saved. When IsGeneralAutofillEnabled is true, information is saved, suggestions
    /// appear and clicking on one will populate the form fields.
    /// It will take effect immediately after setting.
    /// The default value is `TRUE`.
    /// This property has the same value as
    /// `CoreWebView2Profile.IsGeneralAutofillEnabled`, and changing one will
    /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
    /// will share the same value for this property, so for the `CoreWebView2`s
    /// with the same profile, their
    /// `CoreWebView2Settings.IsGeneralAutofillEnabled` and
    /// `CoreWebView2Profile.IsGeneralAutofillEnabled` will always have the same
    /// value.
    ///
    /// \snippet SettingsComponent.cpp GeneralAutofillEnabled
    /// </summary>
    function Get_IsGeneralAutofillEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the IsGeneralAutofillEnabled property.
    /// </summary>
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
    /// <summary>
    /// Pinch-zoom, referred to as "Page Scale" zoom, is performed as a post-rendering step,
    /// it changes the page scale factor property and scales the surface the web page is
    /// rendered onto when user performs a pinch zooming action. It does not change the layout
    /// but rather changes the viewport and clips the web content, the content outside of the
    /// viewport isn't visible onscreen and users can't reach this content using mouse.
    ///
    /// The `IsPinchZoomEnabled` property enables or disables the ability of
    /// the end user to use a pinching motion on touch input enabled devices
    /// to scale the web content in the WebView2. It defaults to `TRUE`.
    /// When set to `FALSE`, the end user cannot pinch zoom after the next navigation.
    /// Disabling/Enabling `IsPinchZoomEnabled` only affects the end user's ability to use
    /// pinch motions and does not change the page scale factor.
    /// This API only affects the Page Scale zoom and has no effect on the
    /// existing browser zoom properties (`IsZoomControlEnabled` and `ZoomFactor`)
    /// or other end user mechanisms for zooming.
    ///
    /// \snippet SettingsComponent.cpp TogglePinchZoomEnabled
    /// </summary>
    function Get_IsPinchZoomEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the `IsPinchZoomEnabled` property
    /// </summary>
    function Set_IsPinchZoomEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage swipe navigation.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings6">See the ICoreWebView2Settings6 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings6 = interface(ICoreWebView2Settings5)
    ['{11CB3ACD-9BC8-43B8-83BF-F40753714F87}']
    /// <summary>
    /// The `IsSwipeNavigationEnabled` property enables or disables the ability of the
    /// end user to use swiping gesture on touch input enabled devices to
    /// navigate in WebView2. It defaults to `TRUE`.
    ///
    /// When this property is `TRUE`, then all configured navigation gestures are enabled:
    /// 1. Swiping left and right to navigate forward and backward is always configured.
    /// 2. Swiping down to refresh is off by default and not exposed via our API currently,
    /// it requires the "--pull-to-refresh" option to be included in the additional browser
    /// arguments to be configured. (See put_AdditionalBrowserArguments.)
    ///
    /// When set to `FALSE`, the end user cannot swipe to navigate or pull to refresh.
    /// This API only affects the overscrolling navigation functionality and has no
    /// effect on the scrolling interaction used to explore the web content shown
    /// in WebView2.
    ///
    /// Disabling/Enabling IsSwipeNavigationEnabled takes effect after the
    /// next navigation.
    ///
    /// \snippet SettingsComponent.cpp ToggleSwipeNavigationEnabled
    /// </summary>
    function Get_IsSwipeNavigationEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the `IsSwipeNavigationEnabled` property
    /// </summary>
    function Set_IsSwipeNavigationEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to hide Pdf toolbar items.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings7">See the ICoreWebView2Settings7 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings7 = interface(ICoreWebView2Settings6)
    ['{488DC902-35EF-42D2-BC7D-94B65C4BC49C}']
    /// <summary>
    /// `HiddenPdfToolbarItems` is used to customize the PDF toolbar items. By default, it is COREWEBVIEW2_PDF_TOOLBAR_ITEMS_NONE and so it displays all of the items.
    /// Changes to this property apply to all CoreWebView2s in the same environment and using the same profile.
    /// Changes to this setting apply only after the next navigation.
    /// \snippet SettingsComponent.cpp ToggleHidePdfToolbarItems
    /// </summary>
    function Get_HiddenPdfToolbarItems(out value: COREWEBVIEW2_PDF_TOOLBAR_ITEMS): HResult; stdcall;
    /// <summary>
    /// Set the `HiddenPdfToolbarItems` property.
    /// </summary>
    function Set_HiddenPdfToolbarItems(value: COREWEBVIEW2_PDF_TOOLBAR_ITEMS): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage smartscreen.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings8">See the ICoreWebView2Settings8 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings8 = interface(ICoreWebView2Settings7)
    ['{9E6B0E8F-86AD-4E81-8147-A9B5EDB68650}']
    /// <summary>
    /// SmartScreen helps webviews identify reported phishing and malware websites
    /// and also helps users make informed decisions about downloads.
    /// `IsReputationCheckingRequired` is used to control whether SmartScreen
    /// enabled or not. SmartScreen is enabled or disabled for all CoreWebView2s
    /// using the same user data folder. If
    /// CoreWebView2Setting.IsReputationCheckingRequired is true for any
    /// CoreWebView2 using the same user data folder, then SmartScreen is enabled.
    /// If CoreWebView2Setting.IsReputationCheckingRequired is false for all
    /// CoreWebView2 using the same user data folder, then SmartScreen is
    /// disabled. When it is changed, the change will be applied to all WebViews
    /// using the same user data folder on the next navigation or download. The
    /// default value for `IsReputationCheckingRequired` is true. If the newly
    /// created CoreWebview2 does not set SmartScreen to false, when
    /// navigating(Such as Navigate(), LoadDataUrl(), ExecuteScript(), etc.), the
    /// default value will be applied to all CoreWebview2 using the same user data
    /// folder.
    /// SmartScreen of WebView2 apps can be controlled by Windows system setting
    /// "SmartScreen for Microsoft Edge", specially, for WebView2 in Windows
    /// Store apps, SmartScreen is controlled by another Windows system setting
    /// "SmartScreen for Microsoft Store apps". When the Windows setting is enabled, the
    /// SmartScreen operates under the control of the `IsReputationCheckingRequired`.
    /// When the Windows setting is disabled, the SmartScreen will be disabled
    /// regardless of the `IsReputationCheckingRequired` value set in WebView2 apps.
    /// In other words, under this circumstance the value of
    /// `IsReputationCheckingRequired` will be saved but overridden by system setting.
    /// Upon re-enabling the Windows setting, the CoreWebview2 will reference the
    /// `IsReputationCheckingRequired` to determine the SmartScreen status.
    /// \snippet SettingsComponent.cpp ToggleSmartScreen
    /// </summary>
    function Get_IsReputationCheckingRequired(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Sets whether this webview2 instance needs SmartScreen protection for its content.
    /// Set the `IsReputationCheckingRequired` property.
    /// </summary>
    function Set_IsReputationCheckingRequired(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// A continuation of the ICoreWebView2Settings interface to manage non-client
  /// regions.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2settings9">See the ICoreWebView2Settings9 article.</see></para>
  /// </remarks>
  ICoreWebView2Settings9 = interface(ICoreWebView2Settings8)
    ['{0528A73B-E92D-49F4-927A-E547DDDAA37D}']
    /// <summary>
    /// The `IsNonClientRegionSupportEnabled` property enables web pages to use the
    /// `app-region` CSS style. Disabling/Enabling the `IsNonClientRegionSupportEnabled`
    /// takes effect after the next navigation. Defaults to `FALSE`.
    ///
    /// When this property is `TRUE`, then all the non-client region features
    /// will be enabled:
    /// Draggable Regions will be enabled, they are regions on a webpage that
    /// are marked with the CSS attribute `app-region: drag/no-drag`. When set to
    /// `drag`, these regions will be treated like the window's title bar, supporting
    /// dragging of the entire WebView and its host app window; the system menu shows
    /// upon right click, and a double click will trigger maximizing/restoration of the
    /// window size.
    ///
    /// When set to `FALSE`, all non-client region support will be disabled.
    /// The `app-region` CSS style will be ignored on web pages.
    /// \snippet SettingsComponent.cpp ToggleNonClientRegionSupportEnabled
    /// </summary>
    function Get_IsNonClientRegionSupportEnabled(out value: Integer): HResult; stdcall;
    /// <summary>
    /// Set the IsNonClientRegionSupportEnabled property
    /// </summary>
    function Set_IsNonClientRegionSupportEnabled(value: Integer): HResult; stdcall;
  end;

  /// <summary>
  /// Event args for the `WebResourceRequested` event.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2webresourcerequestedeventargs2">See the ICoreWebView2WebResourceRequestedEventArgs2 article.</see></para>
  /// </remarks>
  ICoreWebView2WebResourceRequestedEventArgs2 = interface(ICoreWebView2WebResourceRequestedEventArgs)
    ['{9C562C24-B219-4D7F-92F6-B187FBBADD56}']
    /// <summary>
    /// The web resource requested source.
    /// </summary>
    function Get_RequestedSourceKind(out value: COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS): HResult; stdcall;
  end;

  /// <summary>
  /// Receives `NonClientRegionChanged` events.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2nonclientregionchangedeventhandler">See the ICoreWebView2NonClientRegionChangedEventHandler article.</see></para>
  /// </remarks>
  ICoreWebView2NonClientRegionChangedEventHandler = interface(IUnknown)
    ['{4A794E66-AA6C-46BD-93A3-382196837680}']
    /// <summary>
    /// Provides the event args for the corresponding event.
    /// </summary>
    function Invoke(const sender: ICoreWebView2CompositionController;
                    const args: ICoreWebView2NonClientRegionChangedEventArgs): HResult; stdcall;
  end;

  /// <summary>
  /// This is the Interface for non-client region change event args.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2nonclientregionchangedeventargs">See the ICoreWebView2NonClientRegionChangedEventArgs article.</see></para>
  /// </remarks>
  ICoreWebView2NonClientRegionChangedEventArgs = interface(IUnknown)
    ['{AB71D500-0820-4A52-809C-48DB04FF93BF}']
    /// <summary>
    /// This property represents the COREWEBVIEW2_NON_CLIENT_REGION_KIND which the
    /// region changed event corresponds to. With this property an app can query
    /// for a collection of rects which have that region kind by using
    /// QueryNonClientRegion on the composition controller.
    /// </summary>
    function Get_RegionKind(out value: COREWEBVIEW2_NON_CLIENT_REGION_KIND): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of RECT.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2regionrectcollectionview">See the ICoreWebView2RegionRectCollectionView article.</see></para>
  /// </remarks>
  ICoreWebView2RegionRectCollectionView = interface(IUnknown)
    ['{333353B8-48BF-4449-8FCC-22697FAF5753}']
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: tagRECT): HResult; stdcall;
  end;

  /// <summary>
  /// This Interface includes an API which enables non-client hit-testing support for WebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2compositioncontroller4">See the ICoreWebView2CompositionController4 article.</see></para>
  /// </remarks>
  ICoreWebView2CompositionController4 = interface(ICoreWebView2CompositionController3)
    ['{7C367B9B-3D2B-450F-9E58-D61A20F486AA}']
    /// <summary>
    /// If you are hosting a WebView2 using CoreWebView2CompositionController, you can call
    /// this method in your Win32 WndProc to determine if the mouse is moving over or
    /// clicking on WebView2 web content that should be considered part of a non-client region.

    /// The point parameter is expected to be in the client coordinate space of WebView2.
    /// The method sets the out parameter value as follows:
    ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_CAPTION when point corresponds to
    ///         a region (HTML element) within the WebView2 with
    ///         `-webkit-app-region: drag` CSS style set.
    ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_CLIENT when point corresponds to
    ///         a region (HTML element) within the WebView2 without
    ///         `-webkit-app-region: drag` CSS style set.
    ///     - COREWEBVIEW2_NON_CLIENT_REGION_KIND_NOWHERE when point is not within the WebView2.
    ///
    /// NOTE: in order for WebView2 to properly handle the title bar system menu,
    /// the app needs to send WM_NCRBUTTONDOWN and WM_NCRBUTTONUP to SendMouseInput.
    /// See sample code below.
    /// \snippet ViewComponent.cpp DraggableRegions2
    ///
    /// \snippet ViewComponent.cpp DraggableRegions1
    /// </summary>
    function GetNonClientRegionAtPoint(point: tagPOINT;
                                       out value: COREWEBVIEW2_NON_CLIENT_REGION_KIND): HResult; stdcall;
    /// <summary>
    /// This method is used to get the collection of rects that correspond
    /// to a particular COREWEBVIEW2_NON_CLIENT_REGION_KIND. This is to be used in
    /// the callback of add_NonClientRegionChanged whose event args object contains
    /// a region property of type COREWEBVIEW2_NON_CLIENT_REGION_KIND.
    ///
    /// \snippet ScenarioNonClientRegionSupport.cpp AddChangeListener
    /// </summary>
    function QueryNonClientRegion(Kind: COREWEBVIEW2_NON_CLIENT_REGION_KIND;
                                  out rects: ICoreWebView2RegionRectCollectionView): HResult; stdcall;
    /// <summary>
    /// This method is used to add a listener for NonClientRegionChanged.
    /// The event is fired when regions which are marked as non-client in the
    /// app html have changed. So either when new regions have been marked,
    /// or unmarked, or the region(s) have been changed to a different kind.
    ///
    /// \snippet ScenarioNonClientRegionSupport.cpp AddChangeListener
    /// </summary>
    function add_NonClientRegionChanged(const eventHandler: ICoreWebView2NonClientRegionChangedEventHandler;
                                        out token: EventRegistrationToken): HResult; stdcall;
    /// <summary>
    /// This method is used to remove an event handler previously added with
    /// add_NonClientRegionChanged
    /// </summary>
    function remove_NonClientRegionChanged(token: EventRegistrationToken): HResult; stdcall;
  end;

  /// <summary>
  /// Representation of a DOM
  /// [File](https://developer.mozilla.org/docs/Web/API/File) object
  /// passed via WebMessage. You can use this object to obtain the path of a
  /// File dropped on WebView2.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2file">See the ICoreWebView2File article.</see></para>
  /// </remarks>
  ICoreWebView2File = interface(IUnknown)
    ['{F2C19559-6BC1-4583-A757-90021BE9AFEC}']
    /// <summary>
    /// Get the absolute file path.
    ///
    /// The caller must free the returned string with `CoTaskMemFree`.  See
    /// [API Conventions](/microsoft-edge/webview2/concepts/win32-api-conventions#strings).
    /// </summary>
    function Get_Path(out value: PWideChar): HResult; stdcall;
  end;

  /// <summary>
  /// A collection of objects.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2objectcollectionview">See the ICoreWebView2ObjectCollectionView article.</see></para>
  /// </remarks>
  ICoreWebView2ObjectCollectionView = interface(IUnknown)
    ['{0F36FD87-4F69-4415-98DA-888F89FB9A33}']
    /// <summary>
    /// The number of elements contained in the collection.
    /// </summary>
    function Get_Count(out value: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Gets the element at the given index.
    /// </summary>
    function GetValueAtIndex(index: SYSUINT; out value: IUnknown): HResult; stdcall;
  end;

  /// <summary>
  /// Represents a collection of generic objects. Used to get, remove and add
  /// objects at the specified index.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2objectcollection">See the ICoreWebView2ObjectCollection article.</see></para>
  /// </remarks>
  ICoreWebView2ObjectCollection = interface(ICoreWebView2ObjectCollectionView)
    ['{5CFEC11C-25BD-4E8D-9E1A-7ACDAEEEC047}']
    /// <summary>
    /// Removes the object at the specified index.
    /// </summary>
    function RemoveValueAtIndex(index: SYSUINT): HResult; stdcall;
    /// <summary>
    /// Inserts the object at the specified index.
    /// </summary>
    function InsertValueAtIndex(index: SYSUINT; const value: IUnknown): HResult; stdcall;
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
    /// <summary>
    /// Additional received WebMessage objects. To pass `additionalObjects` via
    /// WebMessage to the app, use the
    /// `chrome.webview.postMessageWithAdditionalObjects` content API.
    /// Any DOM object type that can be natively representable that has been
    /// passed in to `additionalObjects` parameter will be accessible here.
    /// Currently a WebMessage object can be the `ICoreWebView2File` type.
    /// Entries in the collection can be `nullptr` if `null` or `undefined` was
    /// passed.
    /// </summary>
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
