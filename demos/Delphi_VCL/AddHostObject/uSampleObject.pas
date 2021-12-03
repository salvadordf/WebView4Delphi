unit uSampleObject;

interface

uses
  System.Win.ComObj;

const
  IID_IHostObjectSample: TGUID = '{AD203EB0-13E6-4B6D-A8D0-75E87645DBB2}';

type
  IHostObjectSample = interface(IDispatch)
    ['{AD203EB0-13E6-4B6D-A8D0-75E87645DBB2}']
    function MethodWithParametersAndReturnValue(const stringParameter: string; integerParameter: integer; out stringResult: string): HRESULT; stdcall;
    function CallCallbackAsynchronously(const callbackParameter: IDispatch): HRESULT; stdcall;
    function MethodWithReturnValue(out intResult: integer): HRESULT; stdcall;
  end;

  THostObjectSample = class(TAutoObject, IHostObjectSample)
    function MethodWithParametersAndReturnValue(const stringParameter: string; integerParameter: integer; out stringResult: string): HRESULT; stdcall;
    function CallCallbackAsynchronously(const callbackParameter: IDispatch): HRESULT; stdcall;
    function MethodWithReturnValue(out intResult: integer): HRESULT; stdcall;
  end;

implementation

function THostObjectSample.MethodWithParametersAndReturnValue(const stringParameter: string; integerParameter: integer; out stringResult: string): HRESULT; stdcall;
begin
  Result := S_OK;
  stringResult := 'qwerty';
end;

function THostObjectSample.CallCallbackAsynchronously(const callbackParameter: IDispatch): HRESULT; stdcall;
begin
  Result := S_OK;
end;

function THostObjectSample.MethodWithReturnValue(out intResult: integer): HRESULT; stdcall;
begin
  Result := S_OK;
  intResult := 42;
end;

end.
