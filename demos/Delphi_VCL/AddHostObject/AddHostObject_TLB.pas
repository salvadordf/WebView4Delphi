unit AddHostObject_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 01/12/2021 14:55:28 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\usuario\Documents\Embarcadero\Studio\Projects\WebView4Delphi\demos\Delphi_VCL\AddHostObject\AddHostObject (1)
// LIBID: {34804AF9-49F9-4911-A2FD-5A6A49C6E1AB}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AddHostObjectMajorVersion = 1;
  AddHostObjectMinorVersion = 0;

  LIBID_AddHostObject: TGUID = '{34804AF9-49F9-4911-A2FD-5A6A49C6E1AB}';

  IID_ISampleHostObjectClass: TGUID = '{E2D824D3-9F0B-4675-8A7B-5A519BEF3586}';
  CLASS_SampleHostObjectClass: TGUID = '{BF2EDEDE-1CBC-48DC-BFA9-24068365FF6B}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ISampleHostObjectClass = interface;
  ISampleHostObjectClassDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  SampleHostObjectClass = ISampleHostObjectClass;


// *********************************************************************//
// Interface: ISampleHostObjectClass
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E2D824D3-9F0B-4675-8A7B-5A519BEF3586}
// *********************************************************************//
  ISampleHostObjectClass = interface(IDispatch)
    ['{E2D824D3-9F0B-4675-8A7B-5A519BEF3586}']
    function Get_CustomBSTRProperty: WideString; safecall;
    procedure Set_CustomBSTRProperty(const Value: WideString); safecall;
    function Get_indexedProperty(Param1: Integer): WideString; safecall;
    procedure Set_indexedProperty(Param1: Integer; const Value: WideString); safecall;
    function MethodWithParametersAndReturnValue(const Param1: WideString; Param2: Integer): WideString; safecall;
    function Get_DateProperty: TDateTime; safecall;
    procedure Set_DateProperty(Value: TDateTime); safecall;
    procedure CreateNativeDate; safecall;
    procedure CallCallbackAsynchronously(const Param1: IDispatch); safecall;
    property CustomBSTRProperty: WideString read Get_CustomBSTRProperty write Set_CustomBSTRProperty;
    property indexedProperty[Param1: Integer]: WideString read Get_indexedProperty write Set_indexedProperty;
    property DateProperty: TDateTime read Get_DateProperty write Set_DateProperty;
  end;

// *********************************************************************//
// DispIntf:  ISampleHostObjectClassDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E2D824D3-9F0B-4675-8A7B-5A519BEF3586}
// *********************************************************************//
  ISampleHostObjectClassDisp = dispinterface
    ['{E2D824D3-9F0B-4675-8A7B-5A519BEF3586}']
    property CustomBSTRProperty: WideString dispid 202;
    property indexedProperty[Param1: Integer]: WideString dispid 203;
    function MethodWithParametersAndReturnValue(const Param1: WideString; Param2: Integer): WideString; dispid 201;
    property DateProperty: TDateTime dispid 204;
    procedure CreateNativeDate; dispid 205;
    procedure CallCallbackAsynchronously(const Param1: IDispatch); dispid 206;
  end;

// *********************************************************************//
// The Class CoSampleHostObjectClass provides a Create and CreateRemote method to
// create instances of the default interface ISampleHostObjectClass exposed by
// the CoClass SampleHostObjectClass. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSampleHostObjectClass = class
    class function Create: ISampleHostObjectClass;
    class function CreateRemote(const MachineName: string): ISampleHostObjectClass;
  end;

implementation

uses System.Win.ComObj;

class function CoSampleHostObjectClass.Create: ISampleHostObjectClass;
begin
  Result := CreateComObject(CLASS_SampleHostObjectClass) as ISampleHostObjectClass;
end;

class function CoSampleHostObjectClass.CreateRemote(const MachineName: string): ISampleHostObjectClass;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SampleHostObjectClass) as ISampleHostObjectClass;
end;

end.

