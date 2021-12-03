unit uSampleHostObjectClass;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, SysUtils, AddHostObject_TLB, StdVcl;

type
  TSampleHostObjectClass = class(TAutoObject, ISampleHostObjectClass)
  protected
    FLongPropValue: integer;
    FStringPropValue: WideString;
    FStringArray: array [0..2] of string;
    FDateValue: TDateTime;
    function Get_CustomBSTRProperty: WideString; safecall;
    procedure Set_CustomBSTRProperty(const Value: WideString); safecall;
    function Get_indexedProperty(Param1: Integer): WideString; safecall;
    procedure Set_indexedProperty(Param1: Integer; const Value: WideString); safecall;
    function MethodWithParametersAndReturnValue(const Param1: WideString; Param2: Integer): WideString;
          safecall;
    function Get_DateProperty: TDateTime; safecall;
    procedure Set_DateProperty(Value: TDateTime); safecall;
    procedure CreateNativeDate; safecall;
    procedure CallCallbackAsynchronously(const Param1: IDispatch); safecall;


  end;

implementation

uses ComServ;

function TSampleHostObjectClass.Get_CustomBSTRProperty: WideString;
begin
  Result := FStringPropValue;
end;

procedure TSampleHostObjectClass.Set_CustomBSTRProperty(const Value: WideString);

begin
  FStringPropValue := Value;
end;

function TSampleHostObjectClass.Get_indexedProperty(Param1: Integer): WideString;
begin
  if Param1 in [0..2] then
    Result := FStringArray[Param1]
   else
    Result := '';
end;

procedure TSampleHostObjectClass.Set_indexedProperty(Param1: Integer; const Value: WideString);
begin
  if Param1 in [0..2] then
    FStringArray[Param1] := Value;
end;

function TSampleHostObjectClass.MethodWithParametersAndReturnValue(const Param1: WideString;
          Param2: Integer): WideString;
begin
  Result := Param1 + inttostr(Param2);
end;

function TSampleHostObjectClass.Get_DateProperty: TDateTime;
begin
  Result := FDateValue;
end;

procedure TSampleHostObjectClass.Set_DateProperty(Value: TDateTime);
begin
  FDateValue := Value;
end;

procedure TSampleHostObjectClass.CreateNativeDate;
begin
  Set_DateProperty(now);
end;

procedure TSampleHostObjectClass.CallCallbackAsynchronously(const Param1: IDispatch);
const
  LOCALE_USER_DEFAULT = $0400;
var
  TempParams: pointer;
begin
  TempParams := nil;
  // TODO: Fix access violation when we use an empty TGUID
  Param1.Invoke(DISPID_UNKNOWN, TGUID.Empty, LOCALE_USER_DEFAULT, DISPATCH_METHOD, TempParams, nil, nil, nil);
end;

initialization
  TAutoObjectFactory.Create(ComServer, TSampleHostObjectClass, Class_SampleHostObjectClass,
    ciMultiInstance, tmApartment);
end.
