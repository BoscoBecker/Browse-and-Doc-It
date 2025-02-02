        ��  ��                  �  D   ��
 D U N I T P R O J E C T S O U R C E         0 	        //: @stopdocumentation
program %s;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.
  
  Additioanl Note: David Hoyle @ 12 Feb 2009
  
  Additionally, if you want the line number of the failures add "USE_JEDI_JCL"
  to the conditional defines for the project. NOTE: You will need to install the
  JEDI JCL on your machine for this to work.
  
  This is a highly modified project source from the default DUnit source with
  the following intensions:
   1) Count the errors and failures and returns them as an error code in a
      console application, thus automated testing can catch the errors /
      failures.
   2) Switch on and off EurekaLog (if your using it) depending on whether you
      are debugging the test or note.
   3) Pause the output is debugging the tests in the IDE except if the console
      input is redirected.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  {$IFDEF EUREKALOG}
  ExceptionLog,
  {$ENDIF}
  SysUtils,
  Forms,
  Windows,
  {$IFDEF USE_JEDI_JCL}
  JclDebug,
  {$ENDIF}
  TestFramework,
  GUITestRunner,
  TextTestRunner;

{$R *.RES}

Var
  T : TTestResult;
  iErrors : Integer;
  lpMode : Cardinal;

begin
  {$IFDEF EUREKALOG}
  SetEurekaLogState(DebugHook = 0);
  {$ENDIF}
  Application.Initialize;
  If IsConsole Then
    Begin
      {$IFDEF USE_JEDI_JCL}
      JclDebug.RemoveIgnoredException(EAbort);
      {$ENDIF}
      T := TextTestRunner.RunRegisteredTests;
      Try
        iErrors := T.FailureCount + T.ErrorCount;
      Finally
        T.Free;
      End;
      If DebugHook <> 0 Then                                           // Pause in IDE
        If GetConsoleMode(GetStdHandle(STD_INPUT_HANDLE), lpMode) Then // Check redirection
          Begin
            Writeln('Press <Enter> to finish...');
            Readln;
          End;
      If iErrors > 0 Then
        Halt(iErrors);
    End else
      GUITestRunner.RunRegisteredTests;
end.

   �   <   ��
 D U N I T U N I T S O U R C E       0 	        //: @stopdocumentation
Unit $TESTUNITNAME$;

Interface

Uses
  TestFramework,
  $UNITTOBETESTED$;

Type
$TESTCLASSES$
Implementation
$TESTIMPLEMENTATION$
Initialization
$TESTSUITES$
End.   