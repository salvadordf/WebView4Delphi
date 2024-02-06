unit uWVCoreWebView2ExecuteScriptResult;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// This is the result for ExecuteScriptWithResult.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2executescriptresult">See the ICoreWebView2ExecuteScriptResult article.</see></para>
  /// </remarks>
  TCoreWebView2ExecuteScriptResult = class
    protected
      FBaseIntf : ICoreWebView2ExecuteScriptResult;

      function GetInitialized : boolean;
      function GetSucceeded : boolean;
      function GetResultAsJson : wvstring;
      function GetException : ICoreWebView2ScriptException;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ExecuteScriptResult); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// If Succeeded is true and the result of script execution is a string, this method provides the value of the string result,
      /// and we will get the `FALSE` var value when the js result is not string type.
      /// The return value description is as follows
      /// 1. S_OK: Execution succeeds.
      /// 2. E_POINTER: When the `stringResult` or `value` is nullptr.
      /// NOTE: If the `value` returns `FALSE`, the `stringResult` will be set to a empty string.
      /// </summary>
      function TryGetResultAsString(var stringResult: wvstring; var value: boolean): boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2ExecuteScriptResult  read FBaseIntf;
      /// <summary>
      /// This property is true if ExecuteScriptWithResult successfully executed script with
      /// no unhandled exceptions and the result is available in the ResultAsJson property
      /// or via the TryGetResultAsString method.
      /// If it is false then the script execution had an unhandled exception which you
      /// can get via the Exception property.
      /// </summary>
      property Succeeded_            : boolean                           read GetSucceeded;
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
      property ResultAsJson          : wvstring                          read GetResultAsJson;
      /// <summary>
      /// If Succeeded is false, you can use this property to get the unhandled exception thrown by script execution
      /// Note that due to the compatibility of the WinRT/.NET interface,
      /// S_OK will be returned even if the acquisition fails.
      /// We can determine whether the acquisition is successful by judging whether the `exception` is nullptr.
      /// </summary>
      property Exception             : ICoreWebView2ScriptException      read GetException;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ExecuteScriptResult.Create(const aBaseIntf: ICoreWebView2ExecuteScriptResult);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ExecuteScriptResult.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ExecuteScriptResult.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ExecuteScriptResult.GetSucceeded : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_Succeeded(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2ExecuteScriptResult.GetResultAsJson : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ResultAsJson(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ExecuteScriptResult.GetException : ICoreWebView2ScriptException;
var
  TempResult : ICoreWebView2ScriptException;
begin
  Result     := nil;
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Exception(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2ExecuteScriptResult.TryGetResultAsString(var stringResult: wvstring; var value: boolean): boolean;
var
  TempString : PWideChar;
  TempValue  : integer;
begin
  Result       := False;
  TempString   := nil;
  stringResult := '';
  value        := False;

  if Initialized and
     succeeded(FBaseIntf.TryGetResultAsString(TempString, TempValue)) then
    begin
      Result       := True;
      value        := (TempValue <> 0);
      stringResult := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
