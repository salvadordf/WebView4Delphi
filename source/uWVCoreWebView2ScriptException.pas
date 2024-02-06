unit uWVCoreWebView2ScriptException;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// This interface represents a JavaScript exception.
  /// If the CoreWebView2.ExecuteScriptWithResult result has Succeeded as false,
  /// you can use the result's Exception property to get the script exception.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2scriptexception">See the ICoreWebView2ScriptException article.</see></para>
  /// </remarks>
  TCoreWebView2ScriptException = class
    protected
      FBaseIntf : ICoreWebView2ScriptException;

      function GetInitialized : boolean;
      function GetLineNumber : cardinal;
      function GetColumnNumber : cardinal;
      function GetName : wvstring;
      function GetMessage : wvstring;

    public
      constructor Create(const aBaseIntf : ICoreWebView2ScriptException); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// This will return all details of the exception as a JSON string.
      /// In the case that script has thrown a non-Error object such as `throw "abc";`
      /// or any other non-Error object, you can get object specific properties.
      /// </summary>
      function ToJson                : wvstring;
      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized           : boolean                           read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf              : ICoreWebView2ScriptException      read FBaseIntf;
      /// <summary>
      /// The line number of the source where the exception occurred.
      /// In the JSON it is `exceptionDetail.lineNumber`.
      /// Note that this position starts at 0.
      /// </summary>
      property LineNumber            : cardinal                          read GetLineNumber;
      /// <summary>
      /// The column number of the source where the exception occurred.
      /// In the JSON it is `exceptionDetail.columnNumber`.
      /// Note that this position starts at 0.
      /// </summary>
      property ColumnNumber          : cardinal                          read GetColumnNumber;
      /// <summary>
      /// The Name is the exception's class name.
      /// In the JSON it is `exceptionDetail.exception.className`.
      /// This is the empty string if the exception doesn't have a class name.
      /// This can happen if the script throws a non-Error object such as `throw "abc";`
      /// </summary>
      property Name                  : wvstring                          read GetName;
      /// <summary>
      /// The Message is the exception's message and potentially stack.
      /// In the JSON it is exceptionDetail.exception.description.
      /// This is the empty string if the exception doesn't have a description.
      /// This can happen if the script throws a non-Error object such as throw "abc";.
      /// </summary>
      property Message_              : wvstring                          read GetMessage;

  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  Winapi.ActiveX;
  {$ELSE}
  ActiveX;
  {$ENDIF}

constructor TCoreWebView2ScriptException.Create(const aBaseIntf: ICoreWebView2ScriptException);
begin
  inherited Create;

  FBaseIntf := aBaseIntf;
end;

destructor TCoreWebView2ScriptException.Destroy;
begin
  FBaseIntf := nil;

  inherited Destroy;
end;

function TCoreWebView2ScriptException.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2ScriptException.GetLineNumber : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_LineNumber(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2ScriptException.GetColumnNumber : cardinal;
var
  TempResult : SYSUINT;
begin
  if Initialized and succeeded(FBaseIntf.Get_ColumnNumber(TempResult)) then
    Result := TempResult
   else
    Result := 0;
end;

function TCoreWebView2ScriptException.GetName : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_name(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptException.GetMessage : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_Message(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

function TCoreWebView2ScriptException.ToJson : wvstring;
var
  TempString : PWideChar;
begin
  Result     := '';
  TempString := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ToJson(TempString)) then
    begin
      Result := TempString;
      CoTaskMemFree(TempString);
    end;
end;

end.
