(**
  
  This module contains DUnit test for the Browse and Doc It code.

  @Author  David Hoyle
  @Version 59.520
  @Date    09 May 2021

  @nocheck HardCodedString HardCodedInteger HardCodedNumber

  @license

    Browse and Doc It is a RAD Studio plug-in for browsing, checking and
    documenting your code.
    
    Copyright (C) 2019  David Hoyle (https://github.com/DGH2112/Browse-and-Doc-It/)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
  
**)
unit Test.BADI.Pascal.Module;

interface

Uses
  TestFramework,
  BADI.Pascal.Module,
  Test.BADI.Base.Module,
  BADI.Types;

type
  TArrayOfMetricLimits = Array[Low(TBADIModuleMetric)..High(TBADIModuleMetric)] Of Double;

  TestTPascalModule = Class(TExtendedTestCase)
  Strict Private
    FSource: String;
    FPascalModule : TPascalModule;
  Strict Protected
    Procedure SetMetricLimit(Const eMetric : TBADIModuleMetric;
  Const dblMetricLimit : Double);
  Public
    Procedure SetUp; Override;
    Procedure TearDown; Override;
  Published
    Procedure TestAsString;
    Procedure TestCreateParser;
    Procedure TestReservedWords;
    Procedure TestDirectives;
    Procedure TestProcessCompilerDirective;
    Procedure TestReferenceSymbol;
    Procedure TestGoal;
    Procedure TestOPProgram;
    Procedure TestOPUnit;
    Procedure TestOPPackage;
    Procedure TestOPLibrary;
    Procedure TestProgramBlock;
    procedure TestUsesClause;
    Procedure TestPortabilityDirective;
    Procedure TestInterfaceSection;
    Procedure TestInterfaceDecl;
    Procedure TestExportedHeading;
    Procedure TestImplementationSection;
    Procedure TestBlock;
    Procedure TestExportsStmt;
    procedure TestExportsItem;
    Procedure TestDeclSection;
    Procedure TestLabelDeclSection;
    Procedure TestConstSection;
    Procedure TestConstantDecl;
    Procedure TestResStringSection;
    Procedure TestResourceStringDecl;
    Procedure TestTypeSection;
    Procedure TestTypeDecl;
    Procedure TestTypedConstant;
    Procedure TestArrayConstant;
    Procedure TestRecordConstant;
    Procedure TestRecordFieldConstant;
    Procedure TestOPType;
    Procedure TestRestrictedType;
    Procedure TestClassRefType;
    Procedure TestSimpleType;
    Procedure TestRealType;
    Procedure TestOrdinalType;
    Procedure TestOrdIdent;
    Procedure TestVariantType;
    Procedure TestSubRangeType;
    Procedure TestEnumerateType;
    Procedure TestEnumerateElement;
    Procedure TestStringType;
    Procedure TestStrucType;
    Procedure TestArrayType;
    Procedure TestRecType;
    Procedure TestFieldList;
    procedure TestFieldDecl;
    Procedure TestVariantSection;
    procedure TestRecVariant;
    Procedure TestSetType;
    Procedure TestFileType;
    Procedure TestPointerType;
    Procedure TestProcedureType;
    Procedure TestVarSection;
    Procedure TestClassVarSection;
    Procedure TestThreadVarSection;
    Procedure TestVarDecl;
    Procedure TestThreadVarDecl;
    Procedure TestExpression;
    Procedure TestSimpleExpression;
    Procedure TestTerm;
    Procedure TestFactor;
    Procedure TestRelOp;
    Procedure TestAddOp;
    Procedure TestMulOp;
    Procedure TestDesignator;
    Procedure TestSetConstructor;
    Procedure TestSetElement;
    Procedure TestExprList;
    Procedure TestStatement;
    Procedure TestStmtList;
    Procedure TestSimpleStatement;
    Procedure TestStructStmt;
    Procedure TestCompoundStmt;
    Procedure TestConditionalStmt;
    Procedure TestIfStmt;
    Procedure TestCaseStmt;
    Procedure TestCaseSelector;
    Procedure TestCaseLabel;
    Procedure TestLoopStmt;
    Procedure TestRepeatStmt;
    Procedure TestWhileStmt;
    Procedure TestForStmt;
    Procedure TestWithStmt;
    Procedure TestTryExceptAndFinallyStmt;
    Procedure TestExceptionBlock;
    Procedure TestRaiseStmt;
    Procedure TestAssemblerStatement;
    Procedure TestProcedureDeclSection;
    Procedure TestProcedureDecl;
    Procedure TestFunctionDecl;
    Procedure TestConstructorDecl;
    Procedure TestDestructorDecl;
    Procedure TestFunctionHeading;
    Procedure TestProcedureHeading;
    Procedure TestFormalParameter;
    Procedure TestFormalParam;
    Procedure TestParameter;
    Procedure TestDirective;
    Procedure TestObjectType;
    Procedure TestObjHeritage;
    Procedure TestMethodList;
    Procedure TestMethodHeading;
    Procedure TestConstructorHeading;
    Procedure TestDestructorHeading;
    Procedure TestObjFieldList;
    Procedure TestInitSection;
    Procedure TestClassType;
    Procedure TestClassHeritage;
    procedure TestClassVisibility;
    Procedure TestClassFieldList;
    Procedure TestClassMethodList;
    Procedure TestClassPropertyList;
    Procedure TestPropertyList;
    Procedure TestPropertyInterface;
    Procedure TestPropertyParameterList;
    Procedure TestPropertySpecifiers;
    Procedure TestInterfaceType;
    Procedure TestInterfaceHeritage;
    Procedure TestRequiresClause;
    procedure TestContainsClause;
    Procedure TestAdvancedRecords;
    Procedure TestRTTIAttributesSingleClass;
    Procedure TestRTTIAttributesSingleMethod;
    Procedure TestRTTIAttributesSingleRecord;
    Procedure TestRTTIAttributesComplexType;
    Procedure TestRTTIAttributesMultiFields;
    Procedure TestRTTIAttributesMultiFunction;
    Procedure TestRTTIAttributesSingleTypeConst;
    Procedure TestRTTIAttributesSingleProperty;
    Procedure TestRTTIAttributesRecord;
    Procedure TestRTTIAttributesClass;
    Procedure TestRTTIAttributesInterface;
    Procedure TestRTTIAttributesMultiPerFuncton;
    Procedure TestRTTIAttributesMultiPerLine;
    Procedure TestRTTIAttributesMultiOnTypeWithComment;
    Procedure TestRTTIAttributesGalore;
    Procedure TestGenericsTStack;
    Procedure TestGenericTMultipleTypes;
    Procedure TestGenericProcVariable;
    Procedure TestGenericSimplyConstraint;
    Procedure TestGenericMultiConstraint;
    Procedure TestGenericTypeConstructor;
    Procedure TestGenericClassConstraintTObjectList;
    Procedure TestGenericClassConstraint;
    Procedure TestGenericClassConstraintWithConstructor;
    Procedure TestGenericClassRecordConstraint;
    Procedure TestGenericInterfaceConstraint;
    Procedure TestGenericPassingRecordsAsParameters;
    Procedure TestGenericInterfaces;
    Procedure TestGenericMethod;
    Procedure TestGenericCollections;
    Procedure TestGenericEntities;
    Procedure TestGenericTEnum;
    Procedure TestGenericTEnumDemo;
    Procedure TestGenericMultiDefType;
    Procedure TestGenericFunctionTArrayResult;
    Procedure TestOperatorImplicit;
    Procedure TestOperatorExplicit;
    Procedure TestOperatorNegative;
    Procedure TestOperatorPositive;
    Procedure TestOperatorInc;
    Procedure TestOperatorDec;
    Procedure TestOperatorLogicalNot;
    Procedure TestOperatorBitwiseNot;
    Procedure TestOperatorTrunc;
    Procedure TestOperatorRound;
    Procedure TestOperatorEqual;
    Procedure TestOperatorNotEqual;
    Procedure TestOperatorGreaterThan;
    Procedure TestOperatorGreaterThanOrEqual;
    Procedure TestOperatorLessThan;
    Procedure TestOperatorLessThanOrEqual;
    Procedure TestOperatorAdd;
    Procedure TestOperatorSubtract;
    Procedure TestOperatorMultiply;
    Procedure TestOperatorDivide;
    Procedure TestOperatorIntDivide;
    Procedure TestOperatorModulus;
    Procedure TestOperatorLeftShift;
    Procedure TestOperatorRightShift;
    Procedure TestOperatorLogicalAnd;
    Procedure TestOperatorLogicalOr;
    Procedure TestOperatorLogicalXor;
    Procedure TestOperatorBitwiseAnd;
    Procedure TestOperatorBitwiseOr;
    Procedure TestOperatorBitwiseXor;
    Procedure TestRecordEmpty;
    Procedure TestRecordVisibilityOnly;
    Procedure TestRecordOneMemberPerVisibility;
    Procedure TestRecordHelper;
    Procedure TestRecordHelperWithHeritage;
    Procedure TestObjectEmpty;
    Procedure TestObjectOneOfEachMember;
    Procedure TestClassEmpty;
    Procedure TestClassVisibilityOnly;
    Procedure TestClassOneMemberPerVisibility;
    Procedure TestClassProperty;
    Procedure TestAnonymousProcRef;
    Procedure TestAnonymousFuncRef;
    Procedure TestAnonymousProcAssignment;
    Procedure TestAnonymousInLineDef;
    Procedure TestAnonymousMethodAsVariable;
    Procedure TestAnonymousMethodsStdProcDecl;
    Procedure TestAnonymousMethodsImplStdProcDecl;
    Procedure TestAnonymousMethodsStdFuncDecl;
    Procedure TestAnonymousMethodsImplStdFuncDecl;
    Procedure TestAnonymousMethodsUsing;
    Procedure TestLongMethodImplementations;
    Procedure TestLongMethodParameterLists;
    Procedure TestLongMethodVariableLists;
    Procedure TestHardCodedIntegers;
    Procedure TestHardCodedNumbers;
    Procedure TestHardCodedStrings;
    Procedure TestUnsortedMethods;
    Procedure TestUseOfWITHStmt;
    Procedure TestUseOfGOTOStmt;
    Procedure TestNestedIFDepth;
    Procedure TestMethodCyclometricComplexity;
    Procedure TestMethodToxicity;
    Procedure TestEmptyExceptBlocks;
    Procedure TestEmptyFinallyBlocks;
    Procedure TestExceptionEating;
    Procedure TestEmptyThenBlocks;
    Procedure TestEmptyElseBlocks;
    Procedure TestEmptyCaseBlocks;
    Procedure TestEmptyForBlocks;
    Procedure TestEmptyWhileBlocks;
    Procedure TestEmptyRepeatBlocks;
    Procedure TestEmptyBeginEndBlocks;
    Procedure TestEmptyInitializationBlock;
    Procedure TestEmptyFinalizationBlock;
    Procedure TestEmptyMethods;
    Procedure TestMissingCONSTInParameters;
    Procedure TestInLineVarsDecl;
    Procedure TestInLineVarsScope;
    Procedure TestInLineVarsTypeInf;
    Procedure TestInLineConstDecl;
    Procedure TestInLineForDecl;
    Procedure TestCodeFailure01;
    Procedure TestCodeFailure02;
    Procedure TestCodeFailure03;
    Procedure TestCodeFailure04;
    Procedure TestCodeFailure05;
    Procedure TestCodeFailure06;
    Procedure TestCodeFailure07;
    Procedure TestCodeFailure08;
    procedure TestCodeFailure09;
    Procedure TestCodeFailure10;
    Procedure TestCodeFailure11;
    Procedure TestCodeFailure12;
    Procedure TestCodeFailure13;
    Procedure TestCodeFailure14;
    Procedure TestCodeFailure15;
    Procedure TestCodeFailure16;
    Procedure TestCodeFailure17;
    Procedure TestCodeFailure18;
    Procedure TestCodeFailure19;
    Procedure TestCodeFailure21;
    Procedure TestCodeFailure22;
    Procedure TestCodeFailure23;
    Procedure TestCodeFailure24;
    Procedure TestCodeFailure25;
    Procedure TestCodeFailure26;
    Procedure TestCodeFailure27;
    Procedure TestCodeFailure28;
    Procedure TestCodeFailure29;
    Procedure TestCodeFailure30;
    Procedure TestCodeFailure31;
    Procedure TestCodeFailure32;
    Procedure TestCodeFailure33;
    Procedure TestCodeFailure34;
    Procedure TestCodeFailure35;
    Procedure TestCodeFailure36;
    Procedure TestCodeFailure37;
    Procedure TestCodeFailure38;
    Procedure TestCodeFailure39;
    Procedure TestCodeFailure40;
    Procedure TestCodeFailure41;
    Procedure TestCodeFailure42;
    Procedure TestCodeFailure43;
    Procedure TestCodeFailure44;
    Procedure TestCodeFailure45;
    Procedure TestCodeFailure46;
    Procedure TestCodeFailure47;
    Procedure TestCodeFailure48;
    Procedure TestCodeFailure49;
  Public
  End;

Implementation

Uses
  SysUtils,
  BADI.TokenInfo,
  BADI.ResourceStrings,
  BADI.Options;

Const
  strNone = '%s';
  strUnit =
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    '%s'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    '%s'#13#10 +
    ''#13#10 +
    'End.'#13#10;
  strProgram =
    'Program MyProgram;'#13#10 +
    ''#13#10 +
    '%s'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '%s'#13#10 +
    'End.'#13#10;

//
// Test methods for the class TPascalModule.
//
Procedure TestTPascalModule.SetMetricLimit(Const eMetric : TBADIModuleMetric;
  Const dblMetricLimit : Double);

Var
  R: TBADIMetricRecord;

Begin
  R := TBADIOptions.BADIOptions.ModuleMetric[eMetric];
  R.FLimit := dblMetricLimit;
  TBADIOptions.BADIOptions.ModuleMetric[eMetric] := R;
End;

Procedure TestTPascalModule.Setup;

Begin
  FSource :=
    '(**'#13#10 +
    '  Hello description.'#13#10 +
    '  @Date ' + FormatDateTime('dd mmm yyyy', Now) + #13#10 +
    '  @Author David Hoyle'#13#10 +
    '  @Version 1.0'#13#10 +
    '**)'#13#10 +
    'Program Hello;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  (** Hello variable **)'#13#10 +
    '  Hello : Integer;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  // Do nothing.'#13#10 +
    'End.'#13#10;
  FPascalModule := TPascalModule.CreateParser(FSource, 'Hello.dpr', True,
    [moParse, moCheckForDocumentConflicts]);
  SetMetricLimit(mmLongMethods,             50);
  SetMetricLimit(mmLongParameterLists,       7);
  SetMetricLimit(mmLongMethodVariableLists,  7);
  SetMetricLimit(mmNestedIFDepth,            5);
  SetMetricLimit(mmCyclometricComplexity,   10);
  SetMetricLimit(mmToxicity,                 1);
End;

Procedure TestTPascalModule.TearDown;

Begin
  FPascalModule.Free;
End;

Procedure TestTPascalModule.TestAddOp;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := 1 + 2;'#13#10 +
    '  j := Hello - i;'#13#10 +
    '  k := $FF OR $12;'#13#10 +
    '  l := $FF XOR 123;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

procedure TestTPascalModule.TestAdvancedRecords;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyRec1 = Record'#13#10 +
    '  private '#13#10 +
    '    Field1 : String'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    '  TMyRec2 = Record'#13#10 +
    '  strict private '#13#10 +
    '    Field1 : String'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    '  TMyRec3 = Record'#13#10 +
    '  strict  private'#13#10 +
    '    Field1 : String'#13#10 +
    '    Field2 : String'#13#10 +
    '  strict private '#13#10 +
    '    function hello : string;'#13#10 +
    '  public '#13#10 +
    '    procedure goodbye;'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    '  TMyRec4 = Record'#13#10 +
    '  strict private '#13#10 +
    '    Field1 : String'#13#10 +
    '    Field2 : String'#13#10 +
    '  strict private '#13#10 +
    '    function hello : string;'#13#10 +
    '  public '#13#10 +
    '    procedure goodbye;'#13#10 +
    '  public '#13#10 +
    '    class operator Implicit(A : Integer) : Integer;'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Function TMyRec3.Hello : String; Begin End;'#13#10 +
    'Procedure TMyRec3.Goodbye; Begin End;'#13#10 +
    'Function TMyRec4.Hello : String; Begin End;'#13#10 +
    'Procedure TMyRec4.Goodbye; Begin End;'#13#10 +
    'Class Operator TMyRec4.Implicit(A : Integer) : Integer; Begin End;',
    [ttErrors, ttWarnings],
    [ 'Types\TMyRec1|TMyRec1 = Record|scPrivate',
      'Types\TMyRec1\Fields\Field1|Field1 : String|scPrivate',
      'Types\TMyRec2|TMyRec2 = Record|scPrivate',
      'Types\TMyRec2\Fields\Field1|Field1 : String|scPrivate',
      'Types\TMyRec3|TMyRec3 = Record|scPrivate',
      'Types\TMyRec3\Fields\Field1|Field1 : String|scPrivate',
      'Types\TMyRec3\Fields\Field2|Field2 : String|scPrivate',
      'Types\TMyRec3\Methods\Hello|Function hello : string|scPrivate',
      'Types\TMyRec3\Methods\goodbye|Procedure goodbye|scPublic',
      'Types\TMyRec4|TMyRec4 = Record|scPrivate',
      'Types\TMyRec4\Fields\Field1|Field1 : String|scPrivate',
      'Types\TMyRec4\Fields\Field2|Field2 : String|scPrivate',
      'Types\TMyRec4\Methods\Hello|Function hello : string|scPrivate',
      'Types\TMyRec4\Methods\Goodbye|Procedure goodbye|scPublic',
      'Types\TMyRec4\Methods\Implicit|Class Operator Implicit(A : Integer) : Integer|scPublic',
      'Implemented Methods\TMyRec3\Hello|Function hello : string|scPrivate',
      'Implemented Methods\TMyRec3\Goodbye|Procedure goodbye|scPublic',
      'Implemented Methods\TMyRec4\Hello|Function hello : string|scPrivate',
      'Implemented Methods\TMyRec4\Goodbye|Procedure goodbye|scPublic',
      'Implemented Methods\TMyRec4\Implicit|Class Operator Implicit(A : Integer) : Integer|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousFuncRef;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TIntegerFunction = reference to function(const x, y: integer): integer;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TIntegerFunction|TIntegerFunction = Reference To Function(Const x, y : Integer) : Integer|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousProcRef;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TOutputProc = reference to procedure(const aString: string);',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TOutputProc|TOutputProc = Reference To Procedure(Const aString : String)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousProcAssignment;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  OutputProc := procedure(const aString: string)'#13#10 +
    '    begin'#13#10 +
    '      WriteLn(aString);'#13#10 +
    '    end; '#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousInLineDef;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TIntegerCalculator = Class'#13#10 +
    '    Procedure RegisterOperators;'#13#10 +
    '  End;',
    'procedure TIntegerCalculator.RegisterOperators;'#13#10 +
    'begin'#13#10 +
    '  RegisterMathOperator(''Add'', function(x, y: integer): integer'#13#10 +
    '    begin'#13#10 +
    '      Result := x + y;'#13#10 +
    '    end);'#13#10 +
    '  RegisterMathOperator(''Subtract'', function(x, y: integer): integer'#13#10 +
    '    begin'#13#10 +
    '      Result := x - y;'#13#10 +
    '    end);'#13#10 +
    '  RegisterMathOperator(''Multiply'', function(x, y: integer): integer'#13#10 +
    '    begin'#13#10 +
    '      Result := x * y;'#13#10 +
    '    end);'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\TIntegerCalculator|TIntegerCalculator = Class|scPublic',
      'Types\TIntegerCalculator\Methods\RegisterOperators|Procedure RegisterOperators|scPublished',
      'Implemented Methods\TIntegerCalculator\RegisterOperators|Procedure RegisterOperators|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousMethodAsVariable;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    'SubtractCalc: TIntegerFunction;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  SubtractCalc := function(x, y: integer): integer'#13#10 +
    '    begin'#13#10 +
    '      Result := x - y;'#13#10 +
    '    end;'#13#10 +
    'RegisterMathCalculation(''Subtract'', SubtractCalc);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Variables\SubtractCalc|SubtractCalc : TIntegerFunction|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousMethodsStdProcDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TProc = reference to procedure;'#13#10 +
    '  TProc<T> = reference to procedure (Arg1: T);'#13#10 +
    '  TProc<T1, T2> = reference to procedure (Arg1: T1; Arg2: T2);'#13#10 +
    '  TProc<T1, T2, T3> = reference to procedure (Arg1: T1; Arg2: T2; Arg3: T3);'#13#10 +
    '  TProc<T1, T2, T3, T4> = reference to procedure (Arg1: T1; Arg2: T2; Arg3: T3; Arg4 : T4);',
    '',
    [ttErrors, ttWarnings],
    [
       'Types\TProc|TProc = Reference to Procedure|scPublic',
       'Types\TProc<T>|TProc<T> = Reference to Procedure(Arg1 : T)|scPublic',
       'Types\TProc<T1, T2>|TProc<T1, T2> = Reference to Procedure(Arg1 : T1; Arg2 : T2)|scPublic',
       'Types\TProc<T1, T2, T3>|TProc<T1, T2, T3> = Reference to Procedure(Arg1 : T1; Arg2 : T2; Arg3 : T3)|scPublic',
       'Types\TProc<T1, T2, T3, T4>|TProc<T1, T2, T3, T4> = Reference to Procedure(Arg1 : T1; Arg2 : T2; Arg3 : T3; Arg4 : T4)|scPublic'
    ]
  )
End;

Procedure TestTPascalModule.TestAnonymousMethodsImplStdProcDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    '  StringDoubleProc: TProc<string, double>;'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    '  StringDoubleProc := procedure(aString: string; aDouble: Double)'#13#10 +
    '    begin'#13#10 +
    '      ShowMessage(aString + '' '' + FloatToStr(aDouble));'#13#10 +
    '    end;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Variables\StringDoubleProc|StringDoubleProc : TProc<String, Double>|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousMethodsStdFuncDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TFunc<TResult> = reference to function: TResult;'#13#10 +
    '  TFunc<T,TResult> = reference to function (Arg1: T): TResult;'#13#10 +
    '  TFunc<T1, T2,TResult> = reference to function (Arg1: T1; Arg2: T2): TResult;'#13#10 +
    '  TFunc<T1, T2, T3,TResult> = reference to function (Arg1: T1; Arg2: T2; Arg3: T3): TResult;'#13#10 +
    '  TFunc<T1, T2, T3, T4,TResult> = reference to function (Arg1: T1; Arg2: T2; Arg3: T3; Arg4: T4): TResult;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TFunc<TResult>|TFunc<TResult> = Reference To Function : TResult|scPublic',
      'Types\TFunc<T, TResult>|TFunc<T, TResult> = Reference To Function(Arg1 : T) : TResult|scPublic',
      'Types\TFunc<T1, T2, TResult>|TFunc<T1, T2, TResult> = Reference To Function(Arg1 : T1; Arg2 : T2) : TResult|scPublic',
      'Types\TFunc<T1, T2, T3, TResult>|TFunc<T1, T2, T3, TResult> = Reference To Function(Arg1 : T1; Arg2 : T2; Arg3 : T3) : TResult|scPublic',
      'Types\TFunc<T1, T2, T3, T4, TResult>|TFunc<T1, T2, T3, T4, TResult> = Reference To Function(Arg1 : T1; Arg2 : T2; Arg3 : T3; Arg4 : T4) : TResult|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousMethodsImplStdFuncDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'function AddIntegers(a, b: integer): integer;'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    '  AddFunc: TFunc<integer, integer, integer>;'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    '  AddFunc := function(x, y: integer): integer'#13#10 +
    '    begin'#13#10 +
    '      Result := x + y;'#13#10 +
    '    end;'#13#10 +
    '  Result := AddFunc(a, b);'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\AddIntegers|Function AddIntegers(a, b : Integer) : Integer|scPrivate',
      'Implemented Methods\AddIntegers\Variables\AddFunc|AddFunc : TFunc<integer, integer, integer>|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestAnonymousMethodsUsing;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  Obj = class'#13#10 +
    '    class procedure Using<T: class>(O: T; Proc: TProc<T>); static;'#13#10 +
    '  end;',
    'class procedure Obj.Using<T>(O: T; Proc: TProc<T>);'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    '  try'#13#10 +
    '    Proc(O);'#13#10 +
    '  finally'#13#10 +
    '    O.Free;'#13#10 +
    '  end;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\Obj|Obj = Class|scPublic',
      'Types\Obj\Methods\Using<T>|Class Procedure Using<T>(O : T; Proc : TProc<T>); Static|scPublished',
      'Implemented Methods\Obj\Using<T>|Class Procedure Using<T>(O : T; Proc : TProc<T>)|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestArrayConstant;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Const'#13#10 +
    '  j : Array[1..2] Of String = (''one'', ''two'');'#13#10 +
    '  i : Array[1..2] Of Integer = (1, 2);',
    [ttErrors, ttWarnings],
    [ 'Constants\j|j : Array[1..2] Of String = (''one'', ''two'')|scPrivate',
      'Constants\i|i : Array[1..2] Of Integer = (1, 2)|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestArrayType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Array Of Integer;'#13#10 +
    '  t02 = Array[1..2] Of String Platform;'#13#10 +
    '  t03 = Array[1 + 2..3*9] Of Byte;'#13#10 +
    '  t04 = Array[1, 2, 3] of Integer;'#13#10 +
    '  t05 = Array[1..2, 0..2] Of String;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Array Of Integer|scPrivate',
      'Types\t02|t02 = Array[1..2] Of String|scPrivate',
      'Types\t03|t03 = Array[1 + 2..3 * 9] Of Byte|scPrivate',
      'Types\t04|t04 = Array[1, 2, 3] of Integer|scPrivate',
      'Types\t05|t05 = Array[1..2, 0..2] Of String|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestAssemblerStatement;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  asm'#13#10 +
    '    MOV DX,BX'#13#10 +
    '  end;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Hello2;'#13#10 +
    ''#13#10 +
    '  asm'#13#10 +
    '    MOV DX,BX'#13#10 +
    '  end;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello2|Procedure Hello2|scPrivate'
    ]
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  asm'#13#10 +
    '      MOV   EDX, Colors '#13#10 +
    '      MOV   ECX, Count '#13#10 +
    '      DEC   ECX '#13#10 +
    '      JS    @@END '#13#10 +
    '      LEA   EAX, SysInfo '#13#10 +
    '      CMP   [EAX].TSystemInfo.wProcessorLevel, 3 '#13#10 +
    '      JE    @@386 '#13#10 +
    '@@1:  MOV   EAX, [EDX+ECX*4] '#13#10 +
    '      BSWAP EAX '#13#10 +
    '      SHR   EAX,8 '#13#10 +
    '      MOV   [EDX+ECX*4],EAX '#13#10 +
    '      DEC   ECX '#13#10 +
    '      JNS   @@1 '#13#10 +
    '      JMP   @@END '#13#10 +
    '@@386: '#13#10 +
    '      PUSH  EBX '#13#10 +
    '@@2:  XOR   EBX,EBX '#13#10 +
    '      MOV   EAX, [EDX+ECX*4] '#13#10 +
    '      MOV   BH, AL '#13#10 +
    '      MOV   BL, AH '#13#10 +
    '      SHR   EAX,16 '#13#10 +
    '      SHL   EBX,8 '#13#10 +
    '      MOV   BL, AL '#13#10 +
    '      MOV   [EDX+ECX*4],EBX '#13#10 +
    '      DEC   ECX '#13#10 +
    '      JNS   @@2 '#13#10 +
    '      POP   EBX '#13#10 +
    '  @@END: '#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestAsString;

Begin
  CheckEquals('Program Hello', FPascalModule.AsString(True, False));
End;

Procedure TestTPascalModule.TestBlock;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'ResourceString'#13#10 +
    '  strHello = ''Hello'';'#13#10 +
    ''#13#10 +
    'Exports'#13#10 +
    '  DGHProc1;',
    '  WriteLn(strHello);',
    [ttErrors, ttWarnings],
    [
      'Resource Strings\strHello|strHello = ''Hello''|scPrivate',
      'Exports\DGHProc1|DGHProc1|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCaseLabel;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  case i of'#13#10 +
    '    1..2 * 3 / 4: Hello;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCaseSelector;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  case i of'#13#10 +
    '    1, 2, 3, 4: Hello;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCaseStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  case i of'#13#10 +
    '    1: Hello;'#13#10 +
    '  end;'#13#10 +
    '  case i of '#13#10 +
    '    2: Goodbye;'#13#10 +
    '  else'#13#10 +
    '    exit;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestClassEmpty;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class;'#13#10 +
    '  TMyOtherClass = Class'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyOtherClass|TMyOtherClass = Class|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestClassFieldList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  MyClass = Class'#13#10 +
    '  private'#13#10 +
    '    MyPrivateField : Integer;'#13#10 +
    '  protected'#13#10 +
    '    MyProtectedField1, MyProtectedField2 : Integer;'#13#10 +
    '  public'#13#10 +
    '    MyPublicField : String;'#13#10 +
    '  published'#13#10 +
    '    MyPublishedField : Boolean;'#13#10 +
    '  strict private'#13#10 +
    '    MyStrictPrivateField : TMyClass;'#13#10 +
    '  strict protected'#13#10 +
    '    MyStrictProtectedField : TMyClass;'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\MyClass|MyClass = Class|scPrivate',
      'Types\MyClass\Fields\MyPrivateField|MyPrivateField : Integer|scPrivate',
      'Types\MyClass\Fields\MyProtectedField1|MyProtectedField1 : Integer|scProtected',
      'Types\MyClass\Fields\MyProtectedField2|MyProtectedField2 : Integer|scProtected',
      'Types\MyClass\Fields\MyPublicField|MyPublicField : String|scPublic',
      'Types\MyClass\Fields\MyPublishedField|MyPublishedField : Boolean|scPublished',
      'Types\MyClass\Fields\MyStrictPrivateField|MyStrictPrivateField : TMyClass|scPrivate',
      'Types\MyClass\Fields\MyStrictProtectedField|MyStrictProtectedField : TMyClass|scProtected'
    ]
  );
End;

Procedure TestTPascalModule.TestClassHeritage;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyClass1 = Class(TObject)'#13#10 +
    '  End;'#13#10 +
    '  MyClass2 = Class(TObject, IMyInterface, IMyOtherInterface)'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\MyClass1|MyClass1 = Class(TObject)|scPublic',
      'Types\MyClass2|MyClass2 = Class(TObject, IMyInterface, IMyOtherInterface)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestClassMethodList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  private'#13#10 +
    '    Procedure MyPrivateMethod;'#13#10 +
    '  protected'#13#10 +
    '    Function MyProtectedMethod : Boolean;'#13#10 +
    '  public'#13#10 +
    '    Constructor MyPublicMethod;'#13#10 +
    '    Constructor MyPublicMethod2;'#13#10 +
    '  published'#13#10 +
    '    Destructor MyPublishedMethod;'#13#10 +
    '  strict private'#13#10 +
    '    Procedure MyStrictPrivateMethod;'#13#10 +
    '  strict protected'#13#10 +
    '    Class Function MyStrictProtectedMethod : String;'#13#10 +
    '  End;',
    'Procedure TMyClass.MyPrivateMethod; Begin End;'#13#10 +
    'Function TMyClass.MyProtectedMethod : Boolean; Begin End;'#13#10 +
    'Constructor TMyClass.MyPublicMethod; Begin End;'#13#10 +
    'Constructor TMyClass.MyPublicMethod2; Begin End;'#13#10 +
    'Destructor TMyClass.MyPublishedMethod; Begin End;'#13#10 +
    'Procedure TMyClass.MyStrictPrivateMethod; Begin End;'#13#10 +
    'Class Function TMyClass.MyStrictProtectedMethod : String; Begin End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Methods\MyPrivateMethod|Procedure MyPrivateMethod|scPrivate',
      'Types\TMyClass\Methods\MyProtectedMethod|Function MyProtectedMethod : Boolean|scProtected',
      'Types\TMyClass\Methods\MyPublicMethod|Constructor MyPublicMethod|scPublic',
      'Types\TMyClass\Methods\MyPublicMethod2|Constructor MyPublicMethod2|scPublic',
      'Types\TMyClass\Methods\MyPublishedMethod|Destructor MyPublishedMethod|scPublished',
      'Types\TMyClass\Methods\MyStrictPrivateMethod|Procedure MyStrictPrivateMethod|scPrivate',
      'Types\TMyClass\Methods\MyStrictProtectedMethod|Class Function MyStrictProtectedMethod : String|scProtected',
      'Implemented Methods\TMyClass\MyPrivateMethod|Procedure MyPrivateMethod|scPrivate',
      'Implemented Methods\TMyClass\MyProtectedMethod|Function MyProtectedMethod : Boolean|scProtected',
      'Implemented Methods\TMyClass\MyPublicMethod|Constructor MyPublicMethod|scPublic',
      'Implemented Methods\TMyClass\MyPublicMethod2|Constructor MyPublicMethod2|scPublic',
      'Implemented Methods\TMyClass\MyPublishedMethod|Destructor MyPublishedMethod|scPublished',
      'Implemented Methods\TMyClass\MyStrictPrivateMethod|Procedure MyStrictPrivateMethod|scPrivate',
      'Implemented Methods\TMyClass\MyStrictProtectedMethod|Class Function MyStrictProtectedMethod : String|scProtected'
    ]
  );
End;

Procedure TestTPascalModule.TestClassOneMemberPerVisibility;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  Private'#13#10 +
    '  Strict Private'#13#10 +
    '  Protected'#13#10 +
    '  Strict Protected'#13#10 +
    '  Public'#13#10 +
    '  Published'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    ['Types\TMyClass|TMyClass = Class|scPublic']
  );
End;

Procedure TestTPascalModule.TestClassProperty;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  Strict Private'#13#10 +
    '    Class Var FClassVariable : Integer;'#13#10 +
    '  Public'#13#10 +
    '    Class Property Variable : Integer Read FClassVariable Write FClassVariable;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings, ttHints],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Class Variables\FClassVariable|FClassVariable : Integer|scPrivate',
      'Types\TMyClass\Properties\Variable|Class Property Variable : Integer Read FClassVariable Write FClassVariable|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestClassPropertyList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  private'#13#10 +
    '    Property MyPrivateProperty;'#13#10 +
    '  protected'#13#10 +
    '    Property MyProtectedProperty : Boolean;'#13#10 +
    '  public'#13#10 +
    '    Property MyPublicProperty;'#13#10 +
    '  published'#13#10 +
    '    Property MyPublishedProperty;'#13#10 +
    '  strict private'#13#10 +
    '    Property MyStrictPrivateProperty;'#13#10 +
    '  strict protected'#13#10 +
    '    Property MyStrictProtectedProperty;'#13#10 +
    '    Property MyStrictProtectedProperty2;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Properties\MyPrivateProperty|Property MyPrivateProperty|scPrivate',
      'Types\TMyClass\Properties\MyProtectedProperty|Property MyProtectedProperty : Boolean|scProtected',
      'Types\TMyClass\Properties\MyPublicProperty|Property MyPublicProperty|scPublic',
      'Types\TMyClass\Properties\MyPublishedProperty|Property MyPublishedProperty|scPublished',
      'Types\TMyClass\Properties\MyStrictPrivateProperty|Property MyStrictPrivateProperty|scPrivate',
      'Types\TMyClass\Properties\MyStrictProtectedProperty|Property MyStrictProtectedProperty|scProtected',
      'Types\TMyClass\Properties\MyStrictProtectedProperty2|Property MyStrictProtectedProperty2|scProtected'
    ]
  );
End;

Procedure TestTPascalModule.TestClassRefType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  a = Class of TClass;',
    '',
    [ttErrors, ttWarnings],
    ['Types\a|a = Class Of TClass|scPublic']
  );
End;

Procedure TestTPascalModule.TestClassType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass1 = Class'#13#10 +
    '  End;'#13#10 +
    '  TMyClass2 = Class Abstract'#13#10 +
    '  End;'#13#10 +
    '  TMyClass3 = Class Sealed'#13#10 +
    '  End;'#13#10 +
    '  TMyClass4 = Class Helper For TMyClass'#13#10 +
    '  End;'#13#10 +
    '  TMyClass5 = Class Helper (TMyClassHelper) For TMyClass'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass1|TMyClass1 = Class|scPublic',
      'Types\TMyClass2|TMyClass2 = Class Abstract|scPublic',
      'Types\TMyClass3|TMyClass3 = Class Sealed|scPublic',
      'Types\TMyClass4|TMyClass4 = Class Helper For TMyClass|scPublic',
      'Types\TMyClass5|TMyClass5 = Class Helper(TMyClassHelper) For TMyClass|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestClassVarSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  c1 = Class'#13#10 +
    '  var'#13#10 +
    '    v1, v2 : Integer;'#13#10 +
    '  End;',
    'Type'#13#10 +
    '  c2 = Class'#13#10 +
    '  Field : TField;'#13#10 +
    '  var'#13#10 +
    '    v3, v4 : Integer;'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\c1|c1 = Class|scPublic',
      'Types\c1\Variables\v1|v1 : Integer|scPublished',
      'Types\c1\Variables\v2|v2 : Integer|scPublished',
      'Types\c2|c2 = Class|scPrivate',
      'Types\c2\Fields\Field|Field : TField|scPublished',
      'Types\c2\Variables\v3|v3 : Integer|scPublished',
      'Types\c2\Variables\v4|v4 : Integer|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestClassVisibility;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyClass = Class'#13#10 +
    '  private'#13#10 +
    '  protected'#13#10 +
    '  public'#13#10 +
    '  published'#13#10 +
    '  strict private'#13#10 +
    '  strict protected'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    ['Types\MyClass|MyClass = Class|scPublic']
  );
End;

Procedure TestTPascalModule.TestClassVisibilityOnly;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  Strict Private'#13#10 +
    '  Private'#13#10 +
    '  Strict Protected'#13#10 +
    '  Protected'#13#10 +
    '  Public'#13#10 +
    '  Published'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    ['Types\TMyClass|TMyClass = Class|scPublic']
  );
End;

Procedure TestTPascalModule.TestCodeFailure01;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  With TMyClass.Create(Nil) Do '#13#10 +
    '    DoSomething;'#13#10 +
    '  With TMyClass.Create(Nil), MyObject Do '#13#10 +
    '    DoSomething(MyObjectField);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure02;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    '(**'#13#10 +
    '  This is a description.'#13#10 +
    '  @date %s'#13#10 +
    '  @author DGH'#13#10 +
    '  @version 0.9'#13#10 +
    '**)'#13#10 +
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    '(**'#13#10 +
    '  This is a description.'#13#10 +
    '  @precon  None.'#13#10 +
    '  @postcon None.'#13#10 +
    '  @param   Ident as an Array Of String'#13#10 +
    '**)'#13#10 +
    'Procedure Hello1(Ident : Array of String);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    '(**'#13#10 +
    '  This is a description.'#13#10 +
    '  @precon  None.'#13#10 +
    '  @postcon None.'#13#10 +
    '  @param   Ident as an Array Of Const'#13#10 +
    '**)'#13#10 +
    'Procedure Hello2(Ident : Array of Const);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello1|Procedure Hello1(Ident : Array Of String)|scPrivate',
      'Implemented Methods\Hello2|Procedure Hello2(Ident : Array Of Const)|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure03;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    '(**'#13#10 +
    '  This is a description.'#13#10 +
    '  @date %s'#13#10 +
    '  @author DGH'#13#10 +
    '  @version 0.9'#13#10 +
    '**)'#13#10 +
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    '  {$R *.res}'#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestCodeFailure04;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Library MyLibrary;'#13#10 +
    ''#13#10 +
    'Uses'#13#10 +
    '  Windows;'#13#10 +
    ''#13#10 +
    'Exports'#13#10 +
    '  MyFunc;'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Uses\Windows|Windows|scPublic',
      'Exports\MyFunc|MyFunc|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure05;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  try'#13#10 +
    '    AMethod;'#13#10 +
    '    fail(''Expected exception not raised'');'#13#10 +
    '  except'#13#10 +
    '    on E: Exception do'#13#10 +
    '    begin'#13#10 +
    '      if E.ClassType <> AExceptionClass then'#13#10 +
    '        raise;'#13#10 +
    '    end'#13#10 +
    '  end;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure06;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Const'#13#10 +
    '  ProtectedFields: string ='#13#10 +
    '    (''Call_Number,DatIns,DatFup,DatFin,EmpIns,EmpFup,EmpFin,Status,DIS_FileOrg,'''#13#10 +
    '    +''DIS_MailFrom,DIS_MailTo,Emp_Email,Dep_Email,Act_CallID,DIS_CallID'''#13#10 +
    '    +''EmpChg,DatChg,Act_Memo,Cost_CallID,Cost_Value,Call_Cost'');',
    [ttErrors, ttWarnings],
    ['Constants\ProtectedFields|ProtectedFields : string = (''Call_Number,DatIns,DatFup,DatFin,EmpIns,EmpFup,EmpFin,Status,DIS_FileOrg,''' +
    ' + ''DIS_MailFrom,DIS_MailTo,Emp_Email,Dep_Email,Act_CallID,DIS_CallID''' +
    ' + ''EmpChg,DatChg,Act_Memo,Cost_CallID,Cost_Value,Call_Cost'')|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure07;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'var'#13#10 +
    '  TagSymbols: array[TTag] of string ='#13#10 +
    '    ('''', ''LINK'', ''IMAGE'', ''TABLE'', ''IMAGEMAP'', ''OBJECT'', ''EMBED'');',
    [ttErrors, ttWarnings],
    ['Variables\TagSymbols|TagSymbols : array[TTag] of string = ('''', ''LINK'', ''IMAGE'', ''TABLE'', ''IMAGEMAP'', ''OBJECT'', ''EMBED'')|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure08;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Const'#13#10 +
    '  a = 123;'#13#10 +
    '  b = 234.567;'#13#10 +
    '  c = $123;'#13#10 +
    '  d = $FFEE00;'#13#10 +
    '  e = 12.345e-12;'#13#10 +
    '  f = 23.456e+34;',
    [ttErrors, ttWarnings],
    [
      'Constants\a|a = 123|scPrivate',
      'Constants\b|b = 234.567|scPrivate',
      'Constants\c|c = $123|scPrivate',
      'Constants\d|d = $FFEE00|scPrivate',
      'Constants\e|e = 12.345e-12|scPrivate',
      'Constants\f|f = 23.456e+34|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure11;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'var'#13#10 +
    '  StandardOLEFormat: TFormatEtc = ('#13#10 +
    '    // Format must later be set.'#13#10 +
    '    cfFormat: 0;'#13#10 +
    '    // No specific target device to render on.'#13#10 +
    '    ptd: nil;'#13#10 +
    '    // Normal content to render.'#13#10 +
    '    dwAspect: DVASPECT_CONTENT;'#13#10 +
    '    // No specific page of multipage data (we don''t use multipage data by default).'#13#10 +
    '    lindex: -1;'#13#10 +
    '    // Acceptable storage formats are IStream and global memory. The first is preferred.'#13#10 +
    '    tymed: TYMED_ISTREAM or TYMED_HGLOBAL;'#13#10 +
    '  );',
    [ttErrors, ttWarnings],
    ['Variables\StandardOLEFormat|StandardOLEFormat : TFormatEtc = (cfFormat : 0; ptd : nil; dwAspect : DVASPECT_CONTENT; lindex : - 1; tymed : TYMED_ISTREAM or TYMED_HGLOBAL;)|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure12;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Case i Of'#13#10 +
    '    ^L: DoSomething;'#13#10 +
    '  Else'#13#10 +
    '    DoSomethingElse;'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure13;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Const'#13#10 +
    '  MyProc01 : Procedure = Nil;'#13#10 +
    '  MyFunc01 : Function : Integer = Nil;'#13#10 +
    ''#13#10 +
    '  MyProc02 : Procedure StdCall = Nil;'#13#10 +
    '  MyFunc02 : Function : Integer StdCall = Nil;',
    '',
    [ttErrors, ttWarnings],
    [
      'Constants\MyProc01|MyProc01 : Procedure = Nil|scPublic',
      'Constants\MyFunc01|MyFunc01 : Function : Integer = Nil|scPublic',
      'Constants\MyProc02|MyProc02 : Procedure; StdCall = Nil|scPublic',
      'Constants\MyFunc02|MyFunc02 : Function : Integer; StdCall = Nil|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure09;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    {$IFNDEF DELPHI7_UP}'#13#10 +
    '    property Size: LongInt read GetSize;'#13#10 +
    '    {$ENDIF}'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    ['Types\TMyClass|TMyClass = Class|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure10;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Const'#13#10 +
    '    IID_IDropTargetHelper: TGUID = (D1: $4657278B; D2: $411B; D3: $11D2; D4: ($83, $9A, $00, $C0, $4F, $D9, $18, $D0));'#13#10 +
    '    IID_IDragSourceHelper: TGUID = (D1: $DE5BF786; D2: $477A; D3: $11D2; D4: ($83, $9D, $00, $C0, $4F, $D9, $18, $D0));'#13#10 +
    '    IID_IDropTarget: TGUID = (D1: $00000122; D2: $0000; D3: $0000; D4: ($C0, $00, $00, $00, $00, $00, $00, $46));'#13#10 +
    '    CLSID_DragDropHelper: TGUID = (D1: $4657278A; D2: $411B; D3: $11D2; D4: ($83, $9A, $00, $C0, $4F, $D9, $18, $D0));',
    [ttErrors, ttWarnings],
    [
      'Constants\IID_IDropTargetHelper|IID_IDropTargetHelper : TGUID = (D1 : $4657278B; D2 : $411B; D3 : $11D2; D4 : ($83, $9A, $00, $C0, $4F, $D9, $18, $D0))|scPrivate',
      'Constants\IID_IDragSourceHelper|IID_IDragSourceHelper : TGUID = (D1 : $DE5BF786; D2 : $477A; D3 : $11D2; D4 : ($83, $9D, $00, $C0, $4F, $D9, $18, $D0))|scPrivate',
      'Constants\IID_IDropTarget|IID_IDropTarget : TGUID = (D1 : $00000122; D2 : $0000; D3 : $0000; D4 : ($C0, $00, $00, $00, $00, $00, $00, $46))|scPrivate',
      'Constants\CLSID_DragDropHelper|CLSID_DragDropHelper : TGUID = (D1 : $4657278A; D2 : $411B; D3 : $11D2; D4 : ($83, $9A, $00, $C0, $4F, $D9, $18, $D0))|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure14;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyClass = Class(TObject, IMyInterface)'#13#10 +
    '  Protected'#13#10 +
    '    function IMyInterface.DoSomething = DoSomething; '#13#10 +
    '    function DoSomething : Integer; StdCall;'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Function TMyClass.DoSomething : Integer;'#13#10 +
    'Begin End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class(TObject, iMyInterface)|scPrivate',
      //: @debug 'Types\TMyClass\Methods\DoSomething|Function IMyInterface.DoSomething = DoSomething|scProtected',
      //: @debug 'Types\TMyClass\Methods\DoSomething|Function DoSomething : Integer; StdCall|scProtected',
      'Implemented Methods\TMyClass\DoSomething|Function DoSomething : Integer|scProtected'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure15;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  Private'#13#10 +
    '    property PropertyPageImpl: TPropertyPageImpl read FPropertyPageImpl'#13#10 +
    '      implements IPropertyPage, IPropertyPage2;'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPrivate',
      'Types\TMyClass\Properties\PropertyPageImpl|Property PropertyPageImpl : ' +
        'TPropertyPageImpl Read FPropertyPageImpl Implements IPropertyPage, IPropertyPage2|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure16;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TBasicAction = Class'#13#10 +
    '    procedure UnRegisterChanges(Value: TBasicActionLink);'#13#10 +
    '  End;',
    'procedure TBasicAction.UnRegisterChanges(Value: TBasicActionLink);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Value.{!}FAction := nil;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TBasicAction|TBasicAction = Class|scPublic',
      'Types\TBasicAction\Methods\UnRegisterChanges|Procedure UnRegisterChanges(Value : TBasicActionLink)|scPublished',
      'Implemented Methods\TBasicAction\UnRegisterChanges|Procedure UnRegisterChanges(Value : TBasicActionLink)|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure17;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  if (goEditing in Options) and (Char(Msg.CharCode) in [^H, #32..#255]) then'#13#10 +
    '    ShowEditorChar(Char(Msg.CharCode))'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure18;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  try'#13#10 +
    '    Result := StrToDate(DateStr);'#13#10 +
    '  except'#13#10 +
    '    on EConvertError do'#13#10 +
    '    else raise;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure19;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    procedure Add(Item: TMenuItem); overload;'#13#10 +
    '    procedure Add(const AItems: array of TMenuItem); overload;'#13#10 +
    ''#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure TMyClass.Add(Item : TMenuItem);'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure TMyClass.Add(const AItems : array of TMenuItem);'#13#10 +
    'Begin End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPrivate'
      //: @debug 'Types\TMyClass\Methods\Add|Procedure Add(Item : TMenuItem); Overload|scPublic'
      //: @debug 'Types\TMyClass\Methods\Add|Procedure Add(Const AItems : Array Of TMenuItem); Overload|scPublic'
      //: @debug 'Implemented Methods\TMyClass\Add.P0.TMenuItem|Procedure Add(Item : TMenuItem); Overload|scPublic',
      //: @debug 'Implemented Methods\TMyClass\Add.P0.Const.Array Of TMenu|Procedure Add(const AItems : Array Of TMenuItem); Overload|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure21;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure Hello; deprecated;',
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    function PSExecuteStatement(const ASQL: string; AParams: TParams;'#13#10 +
    '      ResultSet: Pointer = nil): Integer; overload; virtual; deprecated;'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure Hello; deprecated;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Function TMyClass.PSExecuteStatement(const ASQL: string; AParams: TParams;'#13#10 +
    '  ResultSet: Pointer = nil): Integer;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Exported Headings\Hello|Procedure Hello|scPublic',
      'Types\TMyClass|TMyClass = Class|scPrivate',
      'Types\TMyClass\Methods\PSExecuteStatement|Function PSExecuteStatement(const ASQL : string; AParams : TParams; ResultSet : Pointer = nil) : Integer; overload; virtual|scPublished',
      'Implemented Methods\Hello|Procedure Hello|scPublic',
      'Implemented Methods\TMyClass\PSExecuteStatement|Function PSExecuteStatement(const ASQL : string; AParams : TParams; ResultSet : Pointer = nil) : Integer|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure22;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Test;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Str(dblValue:3:4, strValue);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Test|Procedure Test|scPrivate']
  );
End;

Procedure TestTPascalModule.TestCodeFailure23;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '  Private'#13#10 +
    '    Type TMyEnum = (myFirst, meLast); // NOT ADDED TO RECORD'#13#10 +
    '    Var i : Integer;                  // NOT ADDED TO RECORD'#13#10 +
    '    Const j = 10;                     // NOT ADDED TO RECORD'#13#10 +
    '    Class Var q : String;'#13#10 +
    '  Strict Private'#13#10 +
    '    FInt : Integer;'#13#10 +
    '  Public'#13#10 +
    '    Procedure AddItem;'#13#10 +
    '    Constructor Create(i : Integer);'#13#10 +
    '    //: @note this is not allowed here Destructor Destroy;'#13#10 +
    '    Class Operator Add(a, b : TMyRecord) : TMyRecord;'#13#10 +
    '    Property Hello : Integer Read FInt;'#13#10 +
    '  End;',
    'Procedure TMyRecord.AddItem; Begin End;'#13#10 +
    'Constructor TMyRecord.Create(i : Integer); Begin End;'#13#10 +
    'Class Operator TMyRecord.Add(a, b : TMyRecord) : TMyRecord; Begin End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Types\TMyEnum|TMyEnum = (myFirst, meLast)|scPrivate',
      'Types\TMyRecord\Variables\i|i : Integer|scPrivate',
      'Types\TMyRecord\Constants\j|j = 10|scPrivate',
      'Types\TMyRecord\Class Variables\q|q : String|scPrivate',
      'Types\TMyRecord\Fields\FInt|FInt : Integer|scPrivate',
      'Types\TMyRecord\Methods\AddItem|Procedure AddItem|scPublic',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Add|Class Operator Add(a, b : TMyRecord) : TMyRecord|scPublic',
      'Types\TMyRecord\Properties\Hello|Property Hello : Integer Read FInt|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure24;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TFirst = Class'#13#10 +
    '  Public Type'#13#10 +
    '    TSecond = Class'#13#10 +
    '    Public Type'#13#10 +
    '      TThird = Class'#13#10 +
    '      Public Type'#13#10 +
    '        TFourth = Class'#13#10 +
    '          Procedure Hello;'#13#10 +
    '        End;'#13#10 +
    '      End;'#13#10 +
    '    End;'#13#10 +
    '  End;',
    'Procedure TFirst.TSecond.TThird.TFourth.Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TFirst|TFirst = Class|scPublic',
      'Types\TFirst\Types\TSecond|TSecond = Class|scPublic',
      'Types\TFirst\Types\TSecond\Types\TThird|TThird = Class|scPublic',
      'Types\TFirst\Types\TSecond\Types\TThird\Types\TFourth|TFourth = Class|scPublic',
      'Types\TFirst\Types\TSecond\Types\TThird\Types\TFourth\Methods\Hello|Procedure Hello|scPublished',
      'Implemented Methods\TFirst\TSecond\TThird\TFourth\Hello|Procedure Hello|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure25;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '    TInt64Ex = Record '#13#10 +
    '    Case Integer Of'#13#10 +
    '      1: (Value : Int64);'#13#10 +
    '      2: ('#13#10 +
    '        iFirst  : Word;'#13#10 +
    '        iSecond : Word;'#13#10 +
    '        iThird  : Word;'#13#10 +
    '        iFourth : Word;'#13#10 +
    '      );'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TInt64Ex|TInt64Ex = Record|scPublic',
      'Types\TInt64Ex\Fields\Value|Value : Int64|scPublic',
      'Types\TInt64Ex\Fields\iFirst|iFirst : Word|scPublic',
      'Types\TInt64Ex\Fields\iSecond|iSecond : Word|scPublic',
      'Types\TInt64Ex\Fields\iThird|iThird : Word|scPublic',
      'Types\TInt64Ex\Fields\iFourth|iFourth : Word|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure26;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TEnumerableFilter<F; T: TFmxObject> = class(TEnumerable<T>)'#13#10 +
    '  private'#13#10 +
    '    FBaseEnum: TEnumerable<F>;'#13#10 +
    '    FSelfDestruct: Boolean;'#13#10 +
    '    FPredicate: TPredicate<T>;'#13#10 +
    '  protected'#13#10 +
    '    function DoGetEnumerator: TEnumerator<T>; override;'#13#10 +
    '  public'#13#10 +
    '    constructor Create(const FullEnum: TEnumerable<F>; SelfDestruct: Boolean = False; const Pred: TPredicate<T> = nil);'#13#10 +
    '    class function Filter(const Src: TEnumerable<F>; const Predicate: TPredicate<T> = nil): TEnumerableFilter<F,T>;'#13#10 +
    '  type'#13#10 +
    '    TFilterEnumerator = class(TEnumerator<T>)'#13#10 +
    '    private'#13#10 +
    '      FCleanup: TEnumerableFilter<F,T>;'#13#10 +
    '      FRawEnumerator: TEnumerator<F>;'#13#10 +
    '      FCurrent: T;'#13#10 +
    '      FPredicate: TPredicate<T>;'#13#10 +
    '      function GetCurrent: T;'#13#10 +
    '    protected'#13#10 +
    '      function DoGetCurrent: T; override;'#13#10 +
    '      function DoMoveNext: Boolean; override;'#13#10 +
    '    public'#13#10 +
    '      constructor Create(const Enumerable: TEnumerable<F>; const Cleanup: TEnumerableFilter<F,T>;'#13#10 +
    '        const Pred: TPredicate<T>);'#13#10 +
    '      destructor Destroy; override;'#13#10 +
    '      property Current: T read GetCurrent;'#13#10 +
    '      function MoveNext: Boolean;'#13#10 +
    '    end;'#13#10 +
    '  end;',
    'constructor TEnumerableFilter<F, T>.Create(const FullEnum: TEnumerable<F>; SelfDestruct: Boolean;'#13#10 +
    '  const Pred: TPredicate<T>);'#13#10 +
    'begin'#13#10 +
    '  FBaseEnum := FullEnum;'#13#10 +
    '  FSelfDestruct := SelfDestruct;'#13#10 +
    '  FPredicate := Pred;'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function TEnumerableFilter<F,T>.DoGetEnumerator: TEnumerator<T>;'#13#10 +
    'begin'#13#10 +
    '  if FSelfDestruct then'#13#10 +
    '    Result := TFilterEnumerator.Create(FBaseEnum, Self, FPredicate)'#13#10 +
    '  else'#13#10 +
    '    Result := TFilterEnumerator.Create(FBaseEnum, nil, FPredicate);'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'class function TEnumerableFilter<F, T>.Filter(const Src: TEnumerable<F>; const Predicate: TPredicate<T> = nil):'#13#10 +
    '  TEnumerableFilter<F, T>;'#13#10 +
    'begin'#13#10 +
    '  Result := TEnumerableFilter<F,T>.Create(Src, True, Predicate);'#13#10 +
    'end;'#13#10 +
    'constructor TEnumerableFilter<F, T>.TFilterEnumerator.Create(const Enumerable: TEnumerable<F>;'#13#10 +
    '  const Cleanup: TEnumerableFilter<F, T>; const Pred: TPredicate<T>);'#13#10 +
    'begin'#13#10 +
    '  FRawEnumerator := Enumerable.GetEnumerator;'#13#10 +
    '  FCleanup := Cleanup;'#13#10 +
    '  FPredicate := Pred;'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'destructor TEnumerableFilter<F,T>.TFilterEnumerator.Destroy;'#13#10 +
    'begin'#13#10 +
    '  FRawEnumerator.Free;'#13#10 +
    '  inherited;'#13#10 +
    '  if FCleanup <> nil then'#13#10 +
    '    FCleanup.Free;'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function TEnumerableFilter<F,T>.TFilterEnumerator.DoGetCurrent: T;'#13#10 +
    'begin'#13#10 +
    '  Result := GetCurrent;'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function TEnumerableFilter<F,T>.TFilterEnumerator.DoMoveNext: Boolean;'#13#10 +
    'begin'#13#10 +
    '  Result := MoveNext;'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function TEnumerableFilter<F,T>.TFilterEnumerator.GetCurrent: T;'#13#10 +
    'begin'#13#10 +
    '  Result := FCurrent;'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function TEnumerableFilter<F,T>.TFilterEnumerator.MoveNext: Boolean;'#13#10 +
    'begin'#13#10 +
    '  Result := False;'#13#10 +
    '  while (not Result) and (FRawEnumerator.MoveNext) do'#13#10 +
    '    if (FRawEnumerator.Current is T) and (not Assigned(FPredicate)) or (Assigned(FPredicate) and'#13#10 +
    '      FPredicate(FRawEnumerator.Current as T)) then'#13#10 +
    '    begin'#13#10 +
    '      FCurrent := FRawEnumerator.Current as T;'#13#10 +
    '      Result := FCurrent <> nil;'#13#10 +
    '    end;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\TEnumerableFilter<F, T>|TEnumerableFilter<F, T> = Class(TEnumerable<T>)|scPublic',
      'Types\TEnumerableFilter<F, T>\Fields\FBaseEnum|FBaseEnum : TEnumerable<F>|scPrivate',
      'Types\TEnumerableFilter<F, T>\Fields\FSelfDestruct|FSelfDestruct : Boolean|scPrivate',
      'Types\TEnumerableFilter<F, T>\Fields\FPredicate|FPredicate : TPredicate<T>|scPrivate',
      'Types\TEnumerableFilter<F, T>\Methods\DoGetEnumerator|Function DoGetEnumerator : TEnumerator<T>; Override|scProtected',
      'Types\TEnumerableFilter<F, T>\Methods\Create|Constructor Create(const FullEnum : TEnumerable<F>; SelfDestruct : Boolean = False; const Pred : TPredicate<T> = nil)|scPublic',
      'Types\TEnumerableFilter<F, T>\Methods\Filter|Class Function Filter(const Src : TEnumerable<F>; const Predicate : TPredicate<T> = nil) : TEnumerableFilter<F, T>|scPublic',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator|TFilterEnumerator = Class(TEnumerator<T>)|scPublic',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Fields\FCleanup|FCleanup : TEnumerableFilter<F, T>|scPrivate',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Fields\FRawEnumerator|FRawEnumerator : TEnumerator<F>|scPrivate',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Fields\FCurrent|FCurrent : T|scPrivate',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Fields\FPredicate|FPredicate : TPredicate<T>|scPrivate',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Methods\GetCurrent|Function GetCurrent : T|scPrivate',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Methods\Create|Constructor Create(const Enumerable : TEnumerable<F>; const Cleanup : TEnumerableFilter<F, T>; const Pred : TPredicate<T>)|scPublic',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Methods\Destroy|Destructor Destroy; override|scPublic',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Properties\Current|Property Current : T Read GetCurrent|scPublic',
      'Types\TEnumerableFilter<F, T>\Types\TFilterEnumerator\Methods\MoveNext|Function MoveNext : Boolean|scPublic',
      'Implemented Methods\TEnumerableFilter<F, T>\DoGetEnumerator|Function DoGetEnumerator : TEnumerator<T>|scProtected',
      'Implemented Methods\TEnumerableFilter<F, T>\Create|Constructor Create(const FullEnum : TEnumerable<F>; SelfDestruct : Boolean; const Pred : TPredicate<T>)|scPublic',
      'Implemented Methods\TEnumerableFilter<F, T>\Filter|Class Function Filter(const Src : TEnumerable<F>; const Predicate : TPredicate<T> = nil) : TEnumerableFilter<F, T>|scPublic',
      'Implemented Methods\TEnumerableFilter<F, T>\TFilterEnumerator\GetCurrent|Function GetCurrent : T|scPrivate',
      'Implemented Methods\TEnumerableFilter<F, T>\TFilterEnumerator\Create|Constructor Create(const Enumerable : TEnumerable<F>; const Cleanup : TEnumerableFilter<F, T>; const Pred : TPredicate<T>)|scPublic',
      'Implemented Methods\TEnumerableFilter<F, T>\TFilterEnumerator\Destroy|Destructor Destroy|scPublic',
      'Implemented Methods\TEnumerableFilter<F, T>\TFilterEnumerator\MoveNext|Function MoveNext : Boolean|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure27;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  if Columns[Index].FChanged then'#13#10 +
    '    try'#13#10 +
    '      SendMessage<Integer>(MM_COLUMN_CHANGED, Index);'#13#10 +
    '    finally'#13#10 +
    '      Columns[Index].FChanged := False;'#13#10 +
    '    end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure28;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := ;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ],
    1
  );
End;

Procedure TestTPascalModule.TestCodeFailure29;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Goodbye();'#13#10 +
    '  Goodbye2(qwery, );'#13#10 +
    '  Goodbye2(, qwery);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ],
    2
  );
End;

procedure TestTPascalModule.TestCodeFailure30;
begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'function GetVDMPointer32W; external wow16lib;'#13#10 +
    'function GetVDMPointer64W; external wow16lib index 516;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\GetVDMPointer32W|Function GetVDMPointer32W; External wow16lib|scPrivate'
    ]
  );
end;

Procedure TestTPascalModule.TestCodeFailure31;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyPublicClass = Class'#13#10 +
    '  Strict Private'#13#10 +
    '    Type'#13#10 +
    '      TMyPrivateClass = Class'#13#10 +
    '      Public'#13#10 +
    '        Type'#13#10 +
    '          TMyPublicClass = Class'#13#10 +
    '          Public'#13#10 +
    '            Procedure MyPublicMethod;'#13#10 +
    '          End;'#13#10 +
    '        Procedure MyPublicMethod;'#13#10 +
    '      End;'#13#10 +
    '    Procedure MyStrictPrivateMethod;'#13#10 +
    '  Private'#13#10 +
    '    Procedure MyPrivateMethod;'#13#10 +
    '  Strict Protected'#13#10 +
    '    Procedure MyStrictProtectedMethod;'#13#10 +
    '  Protected'#13#10 +
    '    Procedure MyProtectedMethod;'#13#10 +
    '  Public'#13#10 +
    '    Type'#13#10 +
    '      TMyPublicClass = Class'#13#10 +
    '      Public'#13#10 +
    '        Type'#13#10 +
    '          TMyPublicClass = Class'#13#10 +
    '          Public'#13#10 +
    '            Procedure MyPublicMethod;'#13#10 +
    '          End;'#13#10 +
    '        Procedure MyPublicMethod;'#13#10 +
    '      End;'#13#10 +
    '    Procedure MyPublicMethod;'#13#10 +
    '  Published'#13#10 +
    '    Procedure MyPublishedMethod;'#13#10 +
    '  End;',
    'Procedure TMyPublicClass.MyStrictPrivateMethod; Begin End;'#13#10 +
    'Procedure TMyPublicClass.MyPrivateMethod; Begin End;'#13#10 +
    'Procedure TMyPublicClass.MyStrictProtectedMethod; Begin End;'#13#10 +
    'Procedure TMyPublicClass.MyProtectedMethod; Begin End;'#13#10 +
    'Procedure TMyPublicClass.MyPublicMethod; Begin End;'#13#10 +
    'Procedure TMyPublicClass.MyPublishedMethod; Begin End;'#13#10 +
    ''#13#10 +
    'Procedure TMyPublicClass.TMyPrivateClass.MyPublicMethod; Begin End;'#13#10 + //???????
    'Procedure TMyPublicClass.TMyPrivateClass.TMyPublicClass.MyPublicMethod; Begin End;'#13#10 +
    'Procedure TMyPublicClass.TMyPublicClass.MyPublicMethod; Begin End;'#13#10 +
    'Procedure TMyPublicClass.TMyPublicClass.TMyPublicClass.MyPublicMethod; Begin End;',
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestCodeFailure32;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  Private'#13#10 +
    '    Function GetText(i : Integer) : String;'#13#10 +
    '  Public'#13#10 +
    '    Property Text[i : Integer] : String Read GetText; Default;'#13#10 +
    '  End;',
    'Function TMyClass.GetText(i : Integer) : String; Begin Result := ''''; End;',
    [ttErrors, ttWarnings],
    []
  );
End;


Procedure TestTPascalModule.TestCodeFailure33;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Uses'#13#10 +
    '  SysUtils,'#13#10 +
    '  {$IFDEF EUREKALOG}'#13#10 +
    '  EuekaLog7,'#13#10 +
    '  {$ENDIF}'#13#10 +
    '  Windows;',
    '',
    [ttErrors, ttWarnings],
    ['Uses\Interface\SysUtils|SysUtils|scPublic','Uses\Interface\Windows|Windows|scPublic']
  );
End;

Procedure TestTPascalModule.TestCodeFailure34;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  Public'#13#10 +
    '    Procedure Test; {$IFNDEF D2005} Deprecated; {$ENDIF}'#13#10 +
    ''#13#10 +
    ''#13#10 +
    '  End;',
    '',
    [ttErrors],
    ['Types\TMyClass\Methods\Test|Procedure Test|scPublic']
  );
End;

Procedure TestTPascalModule.TestCodeFailure35;

Begin
  TBADIOptions.BADIOptions.Options := TBADIOptions.BADIOptions.Options + [doshowhints];
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  Strict Private'#13#10 +
    '    FClassVariable : Integer;'#13#10 +
    '  Public'#13#10 +
    '    Property Variable : Integer Read FClassVariable Write FClassVariable;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings, ttHints],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Fields\FClassVariable|FClassVariable : Integer|scPrivate',
      'Types\TMyClass\Properties\Variable|Property Variable : Integer Read FClassVariable Write FClassVariable|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestCodeFailure36;

Var
  BO : TDocOptions;

Begin
  BO := TBADIOptions.BADIOptions.Options;
  TBADIOptions.BADIOptions.Options := [doCustomDrawing..doAddPreAndPostToComment];
  Try
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TPascalModule = Class'#13#10 +
    '  Strict Protected'#13#10 +
    '    Procedure EnumerateElement(EnumerateType : TEnumerateType);'#13#10 +
    '  Public'#13#10 +
    '  End;'#13#10,
    'Procedure TPascalModule.EnumerateElement(EnumerateType : TEnumerateType);'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  ExprType : TPascalExprTypes;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  If IsIdentifier(Token) Then'#13#10 +
    '    Begin'#13#10 +
    '      AddToExpression(EnumerateType);'#13#10 +
    '      If Token.Token = ''='' Then'#13#10 +
    '        Begin'#13#10 +
    '          AddToExpression(EnumerateType);'#13#10 +
    '          ExprType := [petUnknown, petConstExpr];'#13#10 +
    '          ConstExpr(EnumerateType, ExprType);'#13#10 +
    '        End;'#13#10 +
    '    End Else'#13#10 +
    '      ErrorAndSeekToken(strIdentExpected, Token.Token, strSeekableOnErrorTokens, stActual);'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttHints],
    []
  );
  Finally
    TBADIOptions.BADIOptions.Options := BO;
  End;
End;

Procedure TestTPascalModule.TestCodeFailure37;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure T��est();'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  �� : Integer;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  �� := 0;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestCodeFailure38;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure TParallelForTest();'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  TParallel.For(sgStatus.FixedRows, sgStatus.RowCount - 1,'#13#10 +
    '    Procedure(r : Integer)'#13#10 +
    '    Begin'#13#10 +
    '      Case GPSync(r, FotoZeitZone, GPSZZeitToleranz) Of'#13#10 +
    '        resTPFound:    TInterlock.Increment(x);'#13#10 +
    '        resTPNotFound: TInterlock.Increment(y);'#13#10 +
    '      End;'#13#10 +
    '    End'#13#10 +
    '  );'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    []
  );
End;

procedure TestTPascalModule.TestCodeFailure39;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  begin'#13#10 +
    '    Hello;'#13#10 +
    '    i := $8000000000000000;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors],
    []
  );
End;

procedure TestTPascalModule.TestCodeFailure40;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TfrmMyEditorMainForm = Class'#13#10 +
    '    Function FindEditor(Const strFileName: String): TDGHSynEdit;'#13#10 +
    '  End;',
    'Function TfrmMyEditorMainForm.FindEditor(Const strFileName: String): TDGHSynEdit;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  i: Integer;'#13#10 +
    '  ;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, ''FindEditor'', tmoTiming);{$ENDIF}'#13#10 +
    '  Editor := Nil;'#13#10 +
    '  TabbedDocIterator('#13#10 +
    '    Procedure(Const E : TDGHSynEdit; Const iIndex : Integer)'#13#10 +
    '    Begin'#13#10 +
    '      If AnsiCompareFileName(strFileName, E.FileName) = 0 Then'#13#10 +
    '        Editor := E;'#13#10 +
    '    End'#13#10 +
    '  );'#13#10 +
    '  Result := Editor;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [],
    1
  );
End;

Procedure TestTPascalModule.TestCodeFailure41;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TBADIOptions = Class(TInterfacedObject, IBADIOptions) '#13#10 +
    '  Strict Private '#13#10 +
    '    Type '#13#10 +
    '      TBADIExclusion = (deDocumentation, deMetrics, deChecks); '#13#10 +
    '      TBADIExclusions = Set Of TBADIExclusion; '#13#10 +
    '      TBADIExclusionRec = Record '#13#10 +
    '        FExclusionPattern : String; '#13#10 +
    '        FExclusions       : TBADIExclusions; '#13#10 +
    '      End; '#13#10 +
    '  Strict Private '#13#10 +
    '    FExcludeDocFiles        : TList<TBADIExclusionRec>; '#13#10 +
    '  Strict Protected '#13#10 +
    '  Public '#13#10 +
    '    Constructor Create;'#13#10 +
    '  End; ',
    'Constructor TBADIOptions.Create;'#13#10 +
    'Begin'#13#10 +
    '  FExcludeDocFiles := TList.Create;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttHints],
    []
  );
End;

Procedure TestTPascalModule.TestCodeFailure42;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Function TXTVirtualTreeHelper.GetSortedColumns('#13#10 +
    '  Const boolAllColumns : Boolean) : TArray<TXTColumnPosition>;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  System.Generics.Collections.TArray.Sort<TXTColumnPosition>(Result,'#13#10 +
    '    TXTColumnPositionComparer.Create);'#13#10 +
    'End;',
    [ttErrors],
    []
  );
End;

procedure TestTPascalModule.TestCodeFailure43;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  var i : Integer := 1;'#13#10 +
    '  var j := 1',
    [ttErrors],
    []
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  const s = ''Hello'';',
    [ttErrors],
    []
  );
End;

Procedure TestTPascalModule.TestCodeFailure44;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure Hello();',
    'Procedure Hello();'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  const s = ''Hello'';'#13#10 +
    '  WriteLn(s);'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttHints, ttChecks],
    []
  );
End;

Procedure TestTPascalModule.TestCodeFailure45;

Begin
  
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure GetAdaptersInfo; stdcall; external ''GetAdaptersInfo'';',
    [ttErrors..ttHints, ttChecks],
    []
  );
End;

procedure TestTPascalModule.TestCodeFailure46;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '{$IFDEF PROFILECODE}'#13#10 +
    'Type'#13#10 +
    '  TProfiler = Class'#13#10 +
    '  Strict Private'#13#10 +
    '    FStackTop      : Integer;'#13#10 +
    '    FRootProfile   : TProfile;'#13#10 +
    '    FCurrentProfile: TProfile;'#13#10 +
    '    {$IFNDEF CONSOLE}'#13#10 +
    '    FProgressForm  : TForm;'#13#10 +
    '    FLabel         : TLabel;'#13#10 +
    '    {$ENDIF}'#13#10 +
    '  Strict Protected'#13#10 +
    '    Procedure DumpProfileInformation;'#13#10 +
    '    {$IFNDEF CONSOLE}'#13#10 +
    '    Procedure Msg(strMsg: String; boolForce : Boolean = False);'#13#10 +
    '    {$ENDIF}'#13#10 +
    '  Public'#13#10 +
    '    Constructor Create;'#13#10 +
    '    Destructor Destroy; Override;'#13#10 +
    '    Procedure Start(strMethodName: String);'#13#10 +
    '    Procedure Stop;'#13#10 +
    '  End;'#13#10 +
    '{$ENDIF}',
    '',
    [ttErrors],
    []
  );
End;

procedure TestTPascalModule.TestCodeFailure47;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Const strTokenTypeInfo : TBADITokenFontInfoTokenSet = ('#13#10 +
    '  (FForeColour : clRed;        FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [fsBold];               FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [fsBold];               FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clMaroon;     FStyles : [fsBold];               FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clBlack;      FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clInfoText;   FStyles : [];                     FBackColour: clInfoBk),'#13#10 +
    '  (FForeColour : clWindowText; FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clNavy;       FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clPurple;     FStyles : [fsBold, fsUnderline];  FBackColour: clNone),'#13#10 +
    '  (FForeColour : clMaroon;     FStyles : [];                     FBackColour: clNone),'#13#10 +
    '  (FForeColour : clAqua;       FStyles : [];                     FBackColour: clNone)'#13#10 +
    ');',
    [ttErrors],
    []
  );
End;

procedure TestTPascalModule.TestCodeFailure48;
Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TSimpleIndexComparer<T> = Class(TInterfacedObject, IComparer<TXTSimpleIndexRecord<T>>)'#13#10 +
    '  Strict Private'#13#10 +
    '  Strict Protected'#13#10 +
    '  Public'#13#10 +
    '    Function Compare(Const recLeft, recRight : TXTSimpleIndexRecord<T>) : Integer;'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Function TSimpleIndexComparer<T>.Compare(Const recLeft, recRight : TXTSimpleIndexRecord<T>) : Integer;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    []
  );
End;

procedure TestTPascalModule.TestCodeFailure49;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Test;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  NodeData1 := Sender.GetNodeData(Node1);'#13#10 +
    '  NodeData2 := Sender.GetNodeData(Node2);'#13#10 +
    '  If NodeData1.FShiftLevel = NodeData2.FShiftLevel Then'#13#10 +
    '    Begin'#13#10 +
    '      Result := NodeData1.FDateIndex - NodeData2.FDateIndex;'#13#10 +
    '      If Result = 0 Then'#13#10 +
    '        Result := NodeData1.FShiftIndex - NodeData2.FShiftIndex;'#13#10 +
    '    End'#13#10 +
    '  Else If NodeData1.FShiftLevel < NodeData2.FShiftLevel Then'#13#10 +
    '    Result := -1'#13#10 +
    '  Else'#13#10 +
    '    Result := 1;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestCompoundStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  begin'#13#10 +
    '    Hello;'#13#10 +
    '    i := 1 + 2 * j;'#13#10 +
    '    Print(j);'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestConditionalStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  if Hello Then'#13#10 +
    '    exit;'#13#10 +
    '  case i of'#13#10 +
    '    1: Exit;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestConstantDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Const'#13#10 +
    '  c = 0 platform;'#13#10 +
    '  e : String = ''Hello'' library;',
    'procedure implode(i : Integer);'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  c : Integer = 0;'#13#10 +
    '  e = ''Hello'';'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Constants\c|c = 0|scPublic',
      'Constants\e|e : String = ''Hello''|scPublic',
      'Implemented Methods\implode|Procedure implode(i : Integer)|scPrivate',
      'Implemented Methods\implode\Constants\c|c : Integer = 0|scLocal',
      'Implemented Methods\implode\Constants\e|e = ''Hello''|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestConstructorDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    Constructor Create; Virtual;'#13#10 +
    'End;',
    'Constructor TMyClass.Create; Virtual; Platform'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Methods\Create|Constructor Create; Virtual|scPublished',
      'Implemented Methods\TMyClass\Create|Constructor Create; Virtual|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestConstructorHeading;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    '  MySecondObject = Object(TObject)'#13#10 +
    '    Constructor Create(str : String);'#13#10 +
    '  End;',
    'Constructor MySecondObject.Create(str : String);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\MyObject|MyObject = Object(TObject)|scPublic',
      'Types\MySecondObject|MySecondObject = Object(TObject)|scPublic',
      'Types\MySecondObject\Methods\Create|Constructor Create(str : String)|scPublic',
      'Implemented Methods\MySecondObject\Create|Constructor Create(str : String)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestConstSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Const'#13#10 +
    '  c = 0;'#13#10 +
    '  e = ''Hello'';',
    'procedure implode(i : Integer);'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  c = 0;'#13#10 +
    '  e = ''Hello'';'#13#10 +
    '  ex = 1 * 2 + 3 / 4;'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Constants\c|c = 0|scPublic',
      'Constants\e|e = ''Hello''|scPublic',
      'Implemented Methods\implode|Procedure implode(i : Integer)|scPrivate',
      'Implemented Methods\implode\Constants\c|c = 0|scLocal',
      'Implemented Methods\implode\Constants\e|e = ''Hello''|scLocal',
      'Implemented Methods\implode\Constants\ex|ex = 1 * 2 + 3 / 4|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestContainsClause;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Package MyPackage;'#13#10 +
    ''#13#10 +
    'Requires'#13#10 +
    '  VCL50;'#13#10 +
    ''#13#10 +
    'Contains'#13#10 +
    '  DGHLibrary In ''DGHLibrary.pas'','#13#10 +
    '  Library In ''Library.pas'';'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Requires\VCL50|VCL50|scNone',
      'Contains\DGHLibrary|DGHLibrary In ''DGHLibrary.pas''|scNone',
      'Contains\Library|Library In ''Library.pas''|scNone'
    ]
  );
End;

Procedure TestTPascalModule.TestCreateParser;

Begin
  CheckEquals(0, FPascalModule.HeadingCount(strErrors), FPascalModule.FirstError);
  CheckEquals(0, FPascalModule.HeadingCount(strDocumentationConflicts),
    FPascalModule.DocConflict(1));
End;

Procedure TestTPascalModule.TestDeclSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Const'#13#10 +
    '  c = 0;'#13#10 +
    ''#13#10 +
    'ResourceString'#13#10 +
    '  rs = ''Hello'';'#13#10 +
    ''#13#10 +
    'Type'#13#10 +
    '  t = Integer;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  v : String;'#13#10 +
    ''#13#10 +
    'Threadvar'#13#10 +
    '  tv : Integer;'#13#10 +
    ''#13#10 +
    '  Procedure MyProc;'#13#10 +
    '  '#13#10 +
    '  Label'#13#10 +
    '    DGH;'#13#10 +
    '  '#13#10 +
    '  Const'#13#10 +
    '    c = 0;'#13#10 +
    '  '#13#10 +
    '  ResourceString'#13#10 +
    '    rs = ''Hello'';'#13#10 +
    '  '#13#10 +
    '  Type'#13#10 +
    '    t = Integer;'#13#10 +
    '  '#13#10 +
    '  Var'#13#10 +
    '    v : String;'#13#10 +
    '  '#13#10 +
    '  Begin'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Constants\c|c = 0|scPrivate',
      'Resource Strings\rs|rs = ''Hello''|scPrivate',
      'Types\t|t = Integer|scPrivate',
      'Variables\v|v : String|scPrivate',
      'Thread Variables\tv|tv : Integer|scPrivate',
      'Implemented Methods\MyProc|Procedure MyProc|scPrivate',
      'Implemented Methods\MyProc\Labels\DGH|DGH|scLocal',
      'Implemented Methods\MyProc\Constants\c|c = 0|scLocal',
      'Implemented Methods\MyProc\Resource Strings\rs|rs = ''Hello''|scLocal',
      'Implemented Methods\MyProc\Types\t|t = Integer|scLocal',
      'Implemented Methods\MyProc\Variables\v|v : String|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestDesignator;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  QualId;'#13#10 +
    '  QualId.Ident;'#13#10 +
    '  Ident[1 + 2, Hello];'#13#10 +
    '  QualId.ident[1 + 2, Hello];'#13#10 +
    '  Ident^;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestDestructorDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    Destructor Destroy; Override;'#13#10 +
    '  End;',
    'Destructor TMyClass.Destroy; Override; Platform'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Methods\Destroy|Destructor Destroy; Override|scPublished',
      'Implemented Methods\TMyClass\Destroy|Destructor Destroy; Override|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestDestructorHeading;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
   'Type'#13#10 +
   '  MyObject = Object(TObject)'#13#10 +
   '  End;'#13#10 +
   '  MySecondObject = Object(TObject)'#13#10 +
   '    Destructor Destroy(str : String);'#13#10 +
   '  End;',
   'Destructor MySecondObject.Destroy(str : String);'#13#10 +
   ''#13#10 +
   'Begin'#13#10 +
   'End;',
   [ttErrors, ttWarnings],
   [
     'Types\MyObject|MyObject = Object(TObject)|scPublic',
     'Types\MySecondObject|MySecondObject = Object(TObject)|scPublic',
     'Types\MySecondObject\Methods\Destroy|Destructor Destroy(str : String)|scPublic',
     'Implemented Methods\MySecondObject\Destroy|Destructor Destroy(str : String)|scPublic'
   ]
  );
End;

Procedure TestTPascalModule.TestDirective;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Ident01; abstract;'#13#10 +
    ''#13#10 +
    'Procedure Ident02; assembler;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident03; cdecl;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident04a; dispid 1;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident04; dynamic;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident05; export;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident06; external ''Hello'';'#13#10 +
    ''#13#10 +
    'Procedure Ident07; far;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident08; final;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident09; forward;'#13#10 +
    ''#13#10 +
    'Procedure Ident10; inline;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident11; local;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident12; message WM_QUIT;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident13; near;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident14; overload;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident15; override;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident16; pascal;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident17; register;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident18; reintroduce;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident19; safecall;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident20; stdcall;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident21; varargs;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident22; virtual;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident23; virtual; overload;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident24; virtual overload;'#13#10 +
    'Begin End;'#13#10 +
    ''#13#10 +
    'Procedure Ident25; virtual overload; platform'#13#10 +
    'Begin End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Ident01|Procedure Ident01; abstract|scPrivate',
      'Implemented Methods\Ident02|Procedure Ident02; assembler|scPrivate',
      'Implemented Methods\Ident03|Procedure Ident03; cdecl|scPrivate',
      'Implemented Methods\Ident04a|Procedure Ident04a; dispid 1|scPrivate',
      'Implemented Methods\Ident04|Procedure Ident04; dynamic|scPrivate',
      'Implemented Methods\Ident05|Procedure Ident05; export|scPrivate',
      'Implemented Methods\Ident06|Procedure Ident06; External ''Hello''|scPrivate',
      'Implemented Methods\Ident07|Procedure Ident07; far|scPrivate',
      'Implemented Methods\Ident08|Procedure Ident08; final|scPrivate',
      'Implemented Methods\Ident09|Procedure Ident09; forward|scPrivate',
      'Implemented Methods\Ident10|Procedure Ident10; inline|scPrivate',
      'Implemented Methods\Ident11|Procedure Ident11; local|scPrivate',
      'Implemented Methods\Ident12|Procedure Ident12; message WM_QUIT|scPrivate',
      'Implemented Methods\Ident13|Procedure Ident13; near|scPrivate',
      'Implemented Methods\Ident14|Procedure Ident14; overload|scPrivate',
      'Implemented Methods\Ident15|Procedure Ident15; override|scPrivate',
      'Implemented Methods\Ident16|Procedure Ident16; pascal|scPrivate',
      'Implemented Methods\Ident17|Procedure Ident17; register|scPrivate',
      'Implemented Methods\Ident18|Procedure Ident18; reintroduce|scPrivate',
      'Implemented Methods\Ident19|Procedure Ident19; safecall|scPrivate',
      'Implemented Methods\Ident20|Procedure Ident20; stdcall|scPrivate',
      'Implemented Methods\Ident21|Procedure Ident21; varargs|scPrivate',
      'Implemented Methods\Ident22|Procedure Ident22; virtual|scPrivate',
      'Implemented Methods\Ident23|Procedure Ident23; virtual; overload|scPrivate',
      'Implemented Methods\Ident24|Procedure Ident24; virtual; overload|scPrivate',
      'Implemented Methods\Ident25|Procedure Ident25; virtual; overload|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestDirectives;

Var
  Words : TKeyWords;
  i : Integer;

begin
  Words := FPascalModule.Directives;
  CheckEquals(0, Low(Words));
  CheckEquals(44, High(Words));
  For i := Low(Words) To Pred(High(Words)) Do
    Check(Words[i] < Words[i + 1], Words[i] + '!<' + Words[i + 1]);
end;

Procedure TestTPascalModule.TestEnumerateElement;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = (emOne, emTwo, emThree);'#13#10 +
    '  t02 = (emOne = 2, emTwo = 3 * 5, emThree = i * 100);',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = (emOne, emTwo, emThree)|scPrivate',
      'Types\t02|t02 = (emOne = 2, emTwo = 3 * 5, emThree = i * 100)|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestEnumerateType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = (emOne, emTwo, emThree);'#13#10 +
    '  t02 = (emOne = 2, emTwo = 3 * 5, emThree = i * 100);',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = (emOne, emTwo, emThree)|scPrivate',
      'Types\t02|t02 = (emOne = 2, emTwo = 3 * 5, emThree = i * 100)|scPrivate'
    ]
  );
End;

procedure TestTPascalModule.TestExceptionBlock;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  sl := tstringlist.create;'#13#10 +
    '  try'#13#10 +
    '    sl.clear;'#13#10 +
    '  finally'#13#10 +
    '    sl.free;'#13#10 +
    '  end;'#13#10 +
    '  '#13#10 +
    '  try'#13#10 +
    '    sl.clear;'#13#10 +
    '  except'#13#10 +
    '    on e : exception do'#13#10 +
    '      exit;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestExportedHeading;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'procedure implode(i : Integer); stdcall;'#13#10 +
    'function explode(i : Integer) : boolean; pascal;',
    'procedure implode(i : Integer);'#13#10 +
    'begin'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function explode(i : Integer) : boolean;'#13#10 +
    'begin'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Exported Headings\implode|Procedure implode(i : Integer); StdCall|scPublic',
      'Exported Headings\explode|Function explode(i : Integer) : boolean; pascal|scPublic',
      'Implemented Methods\implode|Procedure implode(i : Integer)|scPublic',
      'Implemented Methods\explode|Function explode(i : Integer) : boolean|scPublic'
    ]
  );
End;

procedure TestTPascalModule.TestExportsItem;

Const
  strSource =
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Exports'#13#10 +
    '  DGHProc1 Name ''DGHProcA'', DGHProc2 Index 1,'#13#10 +
    '  DGHProc3 Name ''Hello'' Index 2, DGHProc4 Index 3 Name ''Hello'';'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    'End.'#13#10;

Var
  P: TPascalModule;

begin
  P := TPascalModule.CreateParser(strSource, '', False, [moParse]);
  Try
    CheckEquals(0, P.HeadingCount(strHints), P.FirstHint);
    CheckEquals(0, P.HeadingCount(strWarnings), P.FirstWarning);
    CheckEquals(0, P.HeadingCount(strErrors), P.FirstError);
  Finally
    P.Free;
  End;
end;

procedure TestTPascalModule.TestExportsStmt;

Const
  strSource =
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Exports'#13#10 +
    '  DGHProc1, DGHProc2;'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    'End.'#13#10;

Var
  P: TPascalModule;

begin
  P := TPascalModule.CreateParser(strSource, '', False, [moParse]);
  Try
    CheckEquals(0, P.HeadingCount(strHints), P.FirstHint);
    CheckEquals(0, P.HeadingCount(strWarnings), P.FirstWarning);
    CheckEquals(0, P.HeadingCount(strErrors), P.FirstError);
  Finally
    P.Free;
  End;
end;

procedure TestTPascalModule.TestExpression;

Const
  strSource =
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := Hello <> Goodbye;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'End.'#13#10;

Var
  P: TPascalModule;

begin
  P := TPascalModule.CreateParser(strSource, '', False, [moParse]);
  Try
    CheckEquals(0, P.HeadingCount(strHints), P.FirstHint);
    CheckEquals(0, P.HeadingCount(strWarnings), P.FirstWarning);
    CheckEquals(0, P.HeadingCount(strErrors), P.FirstError);
  Finally
    P.Free;
  End;
end;

procedure TestTPascalModule.TestExprList;

Const
  strSource =
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := [1..2, 2, 3];'#13#10 +
    '  i := MyFunc[Hello, 2, 3];'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'End.'#13#10;

Var
  P: TPascalModule;

begin
  P := TPascalModule.CreateParser(strSource, '', False, [moParse]);
  Try
    CheckEquals(0, P.HeadingCount(strHints), P.FirstHint);
    CheckEquals(0, P.HeadingCount(strWarnings), P.FirstWarning);
    CheckEquals(0, P.HeadingCount(strErrors), P.FirstError);
  Finally
    P.Free;
  End;
end;

Procedure TestTPascalModule.TestFactor;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Designator;'#13#10 +
    '  Designator(1 + 2, Help);'#13#10 +
    '  o := @Designator;'#13#10 +
    '  i := 1.0;'#13#10 +
    '  str := ''Hello'';'#13#10 +
    '  i := (1 + 2 / 3  *4);'#13#10 +
    '  bool := Not bool;'#13#10 +
    '  Inherited Create;'#13#10 +
    '  i := [1, 2, 3..6];'#13#10 +
    '  TypeId(1 * 2 / 3 * 4);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestFieldDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Record'#13#10 +
    '    FField1 : Integer platform;'#13#10 +
    '    FField2 : String;'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Record|scPrivate',
      'Types\t01\Fields\FField1|FField1 : Integer|scPublic',
      'Types\t01\Fields\FField2|FField2 : String|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestFieldList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Record'#13#10 +
    '    FField1 : Integer;'#13#10 +
    '    FField2 : String;'#13#10 +
    '  End;'#13#10 +
    '  THInfo = Record'#13#10 +
    '    dblBearing : Double;'#13#10 +
    '    Case THInfoType Of'#13#10 +
    '      itSetout  : (dblEasting, dblNorthing  : Double);'#13#10 +
    '      itMeasure, itCompare : (dblChainage : Double;'#13#10 +
    '        Case THInfoType Of'#13#10 +
    '          itMeasure: (dblOffset : Double);'#13#10 +
    '          itCompare: (dblDistance : Double);'#13#10 +
    '    );'#13#10 +
    '   End;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Record|scPrivate',
      'Types\t01\Fields\FField1|FField1 : Integer|scPublic',
      'Types\t01\Fields\FField2|FField2 : String|scPublic',
      'Types\THInfo|THInfo = Record|scPrivate',
      'Types\THInfo\Fields\dblEasting|dblEasting : Double|scPublic',
      'Types\THInfo\Fields\dblNorthing|dblNorthing : Double|scPublic',
      'Types\THInfo\Fields\dblChainage|dblChainage : Double|scPublic',
      'Types\THInfo\Fields\dblOffset|dblOffset : Double|scPublic',
      'Types\THInfo\Fields\dblDistance|dblDistance : Double|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestFileType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = File Of Integer;'#13#10 +
    '  t02 = File Of TSomething platform;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = File Of Integer|scPrivate',
      'Types\t02|t02 = File Of TSomething|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestFormalParam;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Ident(i : Integer; var j : String; const k : Boolean; out l : String);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Ident|Procedure Ident(i : Integer; var j : String; const k : Boolean; out l : String)|scPrivate']
  );
End;

Procedure TestTPascalModule.TestFormalParameter;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Ident(i : Integer; j : String; k : Boolean);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Ident|Procedure Ident(i : Integer; j : String; k : Boolean)|scPrivate']
  );
End;

Procedure TestTPascalModule.TestForStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  for i := 0 To 10 Do'#13#10 +
    '    Inc(j);'#13#10 +
    '  for i := 10 DownTo 0 Do'#13#10 +
    '    Inc(j);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  for i in names Do'#13#10 +
    '    Inc(i);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestFunctionDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Function Hello : Integer; StdCall; Library'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Function Hello : Integer; StdCall|scPrivate']
  );
End;

Procedure TestTPascalModule.TestFunctionHeading;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Function Ident : Boolean;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Function Ident2 : String;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Function Ident3(i : Integer) : String;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Ident|Function Ident : Boolean|scPrivate',
      'Implemented Methods\Ident2|Function Ident2 : String|scPrivate',
      'Implemented Methods\Ident3|Function Ident3(i : Integer) : String|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericClassConstraintTObjectList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TObjectList<T: class> = class(TList<T>)'#13#10 +
    '  private'#13#10 +
    '    FOwnsObjects: Boolean;'#13#10 +
    '  protected'#13#10 +
    '    procedure Notify(const Value: T; Action: TCollectionNotification); override;'#13#10 +
    '  public'#13#10 +
    '    constructor Create(AOwnsObjects: Boolean = True); overload;'#13#10 +
    '    constructor Create(const AComparer: IComparer<T>; AOwnsObjects: Boolean = True); overload;'#13#10 +
    '    constructor Create(Collection: TEnumerable<T>; AOwnsObjects: Boolean = True); overload;'#13#10 +
    '    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;'#13#10 +
    '  end;',
    '',
    [ttErrors],
    [
      'Types\TObjectList<T>|TObjectList<T> = Class(TList<T>)|scPublic',
      'Types\TObjectList<T>\Fields\FOwnsObjects|FOwnsObjects : Boolean|scPrivate',
      'Types\TObjectList<T>\Methods\Notify|Procedure Notify(const Value : T; Action : TCollectionNotification); override|scProtected',
      //: @debug 'Types\TObjectList<T>\Methods\Create|Constructor Create(AOwnsObjects : Boolean = True); Overload|scPublic',
      //: @debug 'Types\TObjectList<T>\Methods\Create|Create(Const AComparer : IComparer<T>; AOwnsObjects : Boolean = True); Overload|scPublic',
      //: @debug 'Types\TObjectList<T>\Methods\Create|Constructor Create(Collection : TEnumerable<T>; AOwnsObjects : Boolean = True); Overload|scPublic',
      'Types\TObjectList<T>\Properties\OwnsObjects|Property OwnsObjects : Boolean read FOwnsObjects write FOwnsObjects|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericClassConstraintWithConstructor;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  // Notice the addition of the constructor constraint'#13#10 +
    '  TSomeClass<T: class, constructor> = class'#13#10 +
    '    function GetType: T;'#13#10 +
    '  end;',
    '{ TSomeClass<T> }'#13#10 +
    ''#13#10 +
    'function TSomeClass<T>.GetType: T;'#13#10 +
    'begin'#13#10 +
    '  Result := T.Create;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\TSomeClass<T>|TSomeClass<T> = Class|scPublic',
      'Types\TSomeClass<T>\Methods\GetType|Function GetType : T|scPublished',
      'Implemented Methods\TSomeClass<T>\GetType|Function GetType : T|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericClassRecordConstraint;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TSomeClass<T: record> = class'#13#10 +
    '  private'#13#10 +
    '    FType: T;'#13#10 +
    '  public'#13#10 +
    '    constructor Create(aType: T);'#13#10 +
    '    function GetType: T;'#13#10 +
    '  end;',
    'constructor TSomeClass<T>.Create(aType: T);'#13#10 +
    'begin'#13#10 +
    '  inherited Create;'#13#10 +
    '  FType := aType;'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function TSomeClass<T>.GetType: T;'#13#10 +
    'begin'#13#10 +
    '  Result := FType;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\TSomeClass<T>|TSomeClass<T> = Class|scPublic',
      'Types\TSomeClass<T>\Fields\FType|FType : T|scPrivate',
      'Types\TSomeClass<T>\Methods\Create|Constructor Create(aType : T)|scPublic',
      'Types\TSomeClass<T>\Methods\GetType|Function GetType : T|scPublic',
      'Implemented Methods\TSomeClass<T>\Create|Constructor Create(aType : T)|scPublic',
      'Implemented Methods\TSomeClass<T>\GetType|Function GetType : T|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericCollections;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TList<T> = Class;'#13#10 +
    '  TThreadedList<T> = Class;'#13#10 +
    '  TQueue<T> = Class;'#13#10 +
    '  TStack<T> = Class;'#13#10 +
    '  TDictionary<TKey, TValue> = Class;'#13#10 +
    '  TObjectList<T> = Class;'#13#10 +
    '  TObjectStack<T> = Class;'#13#10 +
    '  TObjectDictionary<TKey, TValue> = Class;'#13#10 +
    '  TThreadedQueue<T> = Class;',
    '',
    [ttErrors],
    [
      'Types\TList<T>|TList<T> = Class|scPublic',
      'Types\TThreadedList<T>|TThreadedList<T> = Class|scPublic',
      'Types\TQueue<T>|TQueue<T> = Class|scPublic',
      'Types\TStack<T>|TStack<T> = Class|scPublic',
      'Types\TDictionary<TKey, TValue>|TDictionary<TKey, TValue> = Class|scPublic',
      'Types\TObjectList<T>|TObjectList<T> = Class|scPublic',
      'Types\TObjectStack<T>|TObjectStack<T> = Class|scPublic',
      'Types\TObjectDictionary<TKey, TValue>|TObjectDictionary<TKey, TValue> = Class|scPublic',
      'Types\TThreadedQueue<T>|TThreadedQueue<T> = Class|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericEntities;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TEntity<T> = class'#13#10 +
    '    ID: T;'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    '  TOrderItem = class(TEntity<integer>)'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    '  TOrder = class(TEntity<integer>)'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    '  TCustomer = class(TEntity<TGUID>)'#13#10 +
    '  end;',
    '',
    [ttErrors],
    [
      'Types\TEntity<T>|TEntity<T> = Class|scPublic',
      'Types\TEntity<T>\Fields\ID|ID : T|scPublished',
      'Types\TOrderItem|TOrderItem = Class(TEntity<integer>)|scPublic',
      'Types\TOrder|TOrder = Class(TEntity<integer>)|scPublic',
      'Types\TCustomer|TCustomer = Class(TEntity<TGUID>)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericInterfaceConstraint;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  IStoppable = interface'#13#10 +
    '    procedure Stop;'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    '  TWidget<T: IStoppable> = class'#13#10 +
    '    FProcess: T;'#13#10 +
    '    procedure StopProcess;'#13#10 +
    '  end;',
    'procedure TWidget<T>.StopProcess;'#13#10 +
    'begin'#13#10 +
    '  FProcess.Stop;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\IStoppable|IStoppable = Interface|scPublic',
      'Types\IStoppable\Methods\Stop|Procedure Stop|scPublic',
      'Types\TWidget<T>|TWidget<T> = Class|scPublic',
      'Types\TWidget<T>\Fields\FProcess|FProcess : T|scPublished',
      'Types\TWidget<T>\Methods\StopProcess|Procedure StopProcess|scPublished',
      'Implemented Methods\TWidget<T>\StopProcess|Procedure StopProcess|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericInterfaces;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  IMyInterface<T> = interface'#13#10 +
    '    procedure DoSomething(aType: T);'#13#10 +
    '  end;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\IMyInterface<T>|IMyInterface<T> = Interface|scPublic',
      'Types\IMyInterface<T>\Methods\DoSomething|Procedure DoSomething(aType : T)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericClassConstraint;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TSomeClass<T: class> = class'#13#10 +
    '    function GetType: T;'#13#10 +
    '  end;',
    '',
    [ttErrors],
    [
      'Types\TSomeClass<T>|TSomeClass<T> = Class|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericMethod;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TWidgetMaker = class'#13#10 +
    '  public'#13#10 +
    '    function CreateWidget<T: TWidget>(aWidgetName: string): T;'#13#10 +
    '  end;',
    'Procedure Test;'#13#10 +
    'begin'#13#10 +
    '  MyWidget := TWidgetMaker.CreateWidget<TSpecialWidget>(''SpecialWidget'');'#13#10 +
    'end;'#13#10,
    [ttErrors],
    [
      'Types\TWidgetMaker|TWidgetMaker = Class|scPublic',
      'Types\TWidgetMaker\Methods\CreateWidget<T>|Function CreateWidget<T>(aWidgetName : String) : T|scPublic',
      'Implemented Methods\Test|Procedure Test|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericMultiConstraint;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TConstraintedType<T: constraint1, constraint2> = class'#13#10 +
    '  '#13#10 +
    '  end;',
    '',
    [ttErrors],
    [
      'Types\TConstraintedType<T>|TConstraintedType<T> = Class|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericMultiDefType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyType = TDictionary<Integer, String>;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyType|TMyType = TDictionary<Integer, String>|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericPassingRecordsAsParameters;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TFoo<T> = class'#13#10 +
    '    AnyType: T;'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    '  TSomeRecord = record'#13#10 +
    '    procedure Blech;'#13#10 +
    '  end;',
    'var'#13#10 +
    '  Foo: TFoo<TSomeRecord>;'#13#10 +
    ''#13#10 +
    'procedure TSomeRecord.Blech;'#13#10 +
    'begin'#13#10 +
    '  WriteLn(''Blech!'');'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'Procedure Test;'#13#10 +
    'begin'#13#10 +
    '  Foo := TFoo<TSomeRecord>.Create;'#13#10 +
    '  try'#13#10 +
    '    Foo.AnyType.Blech;'#13#10 +
    '  finally'#13#10 +
    '    Foo.Free;'#13#10 +
    '  end;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\TFoo<T>|TFoo<T> = Class|scPublic',
      'Types\TFoo<T>\Fields\AnyType|AnyType : T|scPublished',
      'Types\TSomeRecord|TSomeRecord = Record|scPublic',
      'Types\TSomeRecord\Methods\Blech|Procedure Blech|scPublic',
      'Variables\Foo|Foo : TFoo<TSomeRecord>|scPrivate',
      'Implemented Methods\TSomeRecord\Blech|Procedure Blech|scPublic',
      'Implemented Methods\Test|Procedure Test|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericProcVariable;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Test();'#13#10 +
    'var '#13#10 +
    '  ButtonStack: TStack<TButton>; '#13#10 +
    'Begin'#13#10 +
    '  ButtonStack := TStack<TButton>.Create;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Test\Variables\ButtonStack|ButtonStack : TStack<TButton>|scLocal',
      'Implemented Methods\Test|Procedure Test|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericSimplyConstraint;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TConstraintedType<T: constraint> = class'#13#10 +
    '  end;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TConstraintedType<T>|TConstraintedType<T> = Class|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericsTStack;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TStack<T> = class'#13#10 +
    '  private'#13#10 +
    '    FStack : array of T;'#13#10 +
    '  public'#13#10 +
    '    procedure Push(X : T);'#13#10 +
    '    function Pop : T;'#13#10 +
    '  end;',
    '',
    [ttErrors],
    [
      'Types\TStack<T>|TStack<T> = Class|scPublic',
      'Types\TStack<T>\Fields\FStack|FStack : Array Of T|scPrivate',
      'Types\TStack<T>\Methods\Push|Procedure Push(X : T)|scPublic',
      'Types\TStack<T>\Methods\Pop|Function Pop : T|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericFunctionTArrayResult;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    Function  GetBytes: TArray<Byte>;'#13#10 +
    '  End;',
    'Function TMyClass.GetBytes : TArray<Byte>; Begin End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Methods\GetBytes|Function GetBytes : TArray<Byte>|scPublished',
      'Implemented Methods\TMyClass\GetBytes|Function GetBytes : TArray<Byte>|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericTEnum;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TEnum = record'#13#10 +
    '  public'#13#10 +
    '    class function AsString<T>(aEnum: T): string; static;'#13#10 +
    '    class function AsInteger<T>(aEnum: T): Integer; static;'#13#10 +
    '  end;',
    'class function TEnum.AsString<T>(aEnum: T): string;'#13#10 +
    'begin'#13#10 +
    '  Result := GetEnumName(TypeInfo(T), AsInteger(aEnum));'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'class function TEnum.AsInteger<T>(aEnum: T): Integer;'#13#10 +
    'begin'#13#10 +
    '  case Sizeof(T) of'#13#10 +
    '    1: Result := pByte(@aEnum)^;'#13#10 +
    '    2: Result := pWord(@aEnum)^;'#13#10 +
    '    4: Result := pCardinal(@aEnum)^;'#13#10 +
    '  end;'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\TEnum|TEnum = Record|scPublic',
      'Types\TEnum\Methods\AsString<T>|Class Function AsString<T>(aEnum : T) : String; Static|scPublic',
      'Types\TEnum\Methods\AsInteger<T>|Class Function AsInteger<T>(aEnum : T) : Integer; Static|scPublic',
      'Implemented Methods\TEnum\AsString<T>|Class Function AsString<T>(aEnum : T) : String|scPublic',
      'Implemented Methods\TEnum\AsInteger<T>|Class Function AsInteger<T>(aEnum : T) : Integer|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericTEnumDemo;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'type'#13#10 +
    '  TNick = (Blah, Yech, Floo);'#13#10 +
    'Procedure Test;'#13#10 +
    'begin'#13#10 +
    '  WriteLn(TEnum.AsString<TNick>(Blah)); // writes �Blah�'#13#10 +
    '  WriteLn(TEnum.AsString<TNick>(Yech)); // writes �Yech�'#13#10 +
    '  WriteLn(TEnum.AsString<TNick>(Floo)); // writes �Floo�'#13#10 +
    ''#13#10 +
    '  WriteLn(TEnum.AsInteger<TNick>(Blah)); // writes 0'#13#10 +
    '  WriteLn(TEnum.AsInteger<TNick>(Yech)); // writes 1'#13#10 +
    '  WriteLn(TEnum.AsInteger<TNick>(Floo)); // writes 2'#13#10 +
    ''#13#10 +
    '  ReadLn;'#13#10 +
    'end;',
    [ttErrors],
    [
      'Types\TNick|TNick = (Blah, Yech, Floo)|scPrivate',
      'Implemented Methods\Test|Procedure Test|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericTMultipleTypes;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMultipleTypes<T1, T2, T3, T4> = class;',
    '',
    [ttErrors],
    [
      'Types\TMultipleTypes<T1, T2, T3, T4>|TMultipleTypes<T1, T2, T3, T4> = Class|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestGenericTypeConstructor;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'type'#13#10 +
    '  TSomeClass<T: constructor> = class'#13#10 +
    '    function GetType: T;'#13#10 +
    '  end;',
    'function TSomeClass<T>.GetType: T;'#13#10 +
    'begin'#13#10 +
    '  Result := T.Create;'#13#10 +
    'end;'#13#10 +
    'procedure Test;'#13#10 +
    'begin'#13#10 +
    '  SomeClass := TSomeClass<SomeObject>;'#13#10 +
    'end;'#13#10,
    [ttErrors, ttWarnings],
    [
      'Types\TSomeClass<T>|TSomeClass<T> = Class|scPublic',
      'Types\TSomeClass<T>\Methods\GetType|Function GetType : T|scPublished',
      'Implemented Methods\TSomeClass<T>\GetType|Function GetType : T|scPublished',
      'Implemented Methods\Test|Procedure Test|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestGoal;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestIfStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  if Hello Then'#13#10 +
    '    exit;'#13#10 +
    '  if Hello then'#13#10 +
    '    statement'#13#10 +
    '  else'#13#10 +
    '    anotherstatement;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestImplementationSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Uses'#13#10 +
    '  Windows, DGHLibrary;'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  c = 1;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  i : Integer;'#13#10 +
    ''#13#10 +
    'Exports'#13#10 +
    '  DGHProc;',
    [ttErrors, ttWarnings],
    [
      'Uses\Implementation\Windows|Windows|scPrivate',
      'Uses\Implementation\DGHLibrary|DGHLibrary|scPrivate',
      'Constants\c|c = 1|scPrivate',
      'Variables\i|i : Integer|scPrivate',
      'Exports\DGHProc|DGHProc|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestInitSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Initialization'#13#10 +
    '  DoSomething;',
    [ttErrors, ttwarnings],
    []
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Initialization'#13#10 +
    '  DoSomething;'#13#10 +
    'Finalization'#13#10 +
    '  DoSomethingMore;',
    [ttErrors, ttwarnings],
    []
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'BEGIN'#13#10 +
    '  DoSomething;'#13#10 +
    '  DoSomethingMore;',
    [ttErrors, ttwarnings],
    []
  );
End;

Procedure TestTPascalModule.TestInLineConstDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure test;'#13#10 +
    'begin'#13#10 +
    '  const M: Integer = (L + H) div 2;'#13#10 +
    '  const N = (L + H) div 2;'#13#10 +
    'end;',
    [ttErrors],
    [
      'Implemented Methods\test\Constants\M|M = (L + H) div 2|scLocal',
      'Implemented Methods\test\Constants\N|N = (L + H) div 2|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestInLineForDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure test;'#13#10 + 
    'begin'#13#10 +
    '  for var I : Integer := 1 to 1 do'#13#10 +
    '    writeln(i);'#13#10 +
    'end;',
    [ttErrors],
    ['Implemented Methods\test\Variables\I|I : Integer|scLocal']
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure test;'#13#10 +
    'begin'#13#10 +
    '  for var Item: TItemType in Collection Do'#13#10 +
    '    WriteLn(Item.ToString);'#13#10 +
    'end;',
    [ttErrors],
    ['Implemented Methods\test\Variables\Item|Item : TItemType|scLocal']
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure test;'#13#10 +
    'begin'#13#10 +
    '  for var I := 1 To 10 Do'#13#10 +
    '    WriteLn(I);'#13#10 +
    'end;',
    [ttErrors],
    ['Implemented Methods\test\Variables\I|I|scLocal']
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure test;'#13#10 +
    'begin'#13#10 +
    ' for var Item In Collection Do'#13#10 +
    '   WriteLn(Item.ToString);'#13#10 +
    'end;',
    [ttErrors],
    ['Implemented Methods\test\Variables\Item|Item|scLocal']
  );
End;

Procedure TestTPascalModule.TestInLineVarsDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure Test;'#13#10 + 
    'begin'#13#10 +
    '  var I: Integer;'#13#10 +
    '  I := 22;'#13#10 +
    '  ShowMessage(I.ToString);'#13#10 +
    'end;',
    [ttErrors],
    ['Implemented Methods\Test\Variables\I|I : Integer|scLocal']
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure Test2;'#13#10 +
    'begin'#13#10 +
    '  var I, K: Integer;'#13#10 +
    '  I := 22;'#13#10 +
    '  K := I + 10;'#13#10 +
    '  ShowMessage (K.ToString);'#13#10 +
    'end;',
    [ttErrors],
    [
      'Implemented Methods\Test2\Variables\I|I : Integer|scLocal',
      'Implemented Methods\Test2\Variables\K|K : Integer|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestInLineVarsScope;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure Test;'#13#10 +
    'begin'#13#10 +
    '  var I: Integer := 2;'#13#10 +
    '  ShowMessage(I.ToString);'#13#10 +
    'end;',
    [ttErrors],
    ['Implemented Methods\Test\Variables\I|I : Integer|scLocal']
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure Test1;'#13#10 +
    'begin'#13#10 +
    '  var I: Integer := 22;'#13#10 +
    '  var J: Integer;'#13#10 +
    '  J := 22 + I;'#13#10 +
    '  var K: Integer := I + J;'#13#10 +
    '  ShowMessage(K.ToString);'#13#10 +
    'end;',
    [ttErrors],
    [
      'Implemented Methods\Test1\Variables\I|I : Integer|scLocal',
      'Implemented Methods\Test1\Variables\J|J : Integer|scLocal',
      'Implemented Methods\Test1\Variables\K|K : Integer|scLocal'
    ]
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure Test2;'#13#10 +
    'begin'#13#10 +
    '  var I: Integer := 22;'#13#10 +
    '  if I > 10 then'#13#10 +
    '  begin'#13#10 +
    '    var J: Integer := 3;'#13#10 +
    '    ShowMessage(J.ToString);'#13#10 +
    '  end'#13#10 +
    '  else'#13#10 +
    '  begin'#13#10 +
    '    var K: Integer := 3;'#13#10 +
    '    ShowMessage(J.ToString);'#13#10 +
    '  end;'#13#10 +
    'end;',
    [ttErrors],
    [
      'Implemented Methods\Test2\Variables\I|I : Integer|scLocal',
      'Implemented Methods\Test2\Variables\J|J : Integer|scLocal',
      'Implemented Methods\Test2\Variables\K|K : Integer|scLocal'
    ]
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure Test99;'#13#10 +
    'begin'#13#10 +
    '  if (something) then'#13#10 +
    '  begin'#13#10 +
    '    var Intf: IInterface := GetInterface;'#13#10 +
    '    var MRec: TManagedRecord := GetMRecValue;'#13#10 +
    '    UseIntf(Intf);'#13#10 +
    '    UseMRec(MRec);'#13#10 +
    '  end;'#13#10 +
    'end;',
    [ttErrors],
    [
      'Implemented Methods\Test99\Variables\Intf|Intf : IInterface|scLocal',
      'Implemented Methods\Test99\Variables\Mrec|MRec : TManagedRecord|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestInLineVarsTypeInf;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure Test;'#13#10 + 
    'begin'#13#10 +
    '  var I: Integer;'#13#10 +
    '  I := 22;'#13#10 +
    '  ShowMessage(I.ToString);'#13#10 +
    'end;',
    [ttErrors],
    ['Implemented Methods\Test\Variables\I|I : Integer|scLocal']
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'procedure NewTest;'#13#10 +
    'begin'#13#13 +
    '  var MyDictionary := TDictionary<String, Integer>.Create;'#13#13 +
    '  MyDictionary.Add(''one'', 1);'#13#13 +
    '  var APair := MyDictionary.ExtractPair(''one'');'#13#13 +
    '  ShowMessage(APair.Value.ToString);'#13#13 +
    'end;',
    [ttErrors],
    [
      'Implemented Methods\NewTest\Variables\MyDictionary|MyDictionary|scLocal',
      'Implemented Methods\NewTest\Variables\APair|APair|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestInterfaceDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Uses'#13#10 +
    '  Windows;'#13#10 +
    ''#13#10 +
    'Type'#13#10 +
    '  t = Integer;'#13#10 +
    ''#13#10 +
    'const'#13#10 +
    '  c = 0;'#13#10 +
    ''#13#10 +
    'resourcestring'#13#10 +
    '  rs = ''hello.'';'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    '  v : string;'#13#10 +
    ''#13#10 +
    'threadvar'#13#10 +
    '  tv : integer;'#13#10 +
    ''#13#10 +
    'Exports'#13#10 +
    '  Blobby;'#13#10 +
    ''#13#10 +
    'procedure implode;',
    'procedure implode;'#13#10 +
    'begin'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Uses\Interface\Windows|Windows|scPublic',
      'Types\t|t = Integer|scPublic',
      'Constants\c|c = 0|scPublic',
      'Resource Strings\rs|rs = ''hello.''|scPublic',
      'Variables\v|v : String|scPublic',
      'Thread Variables\tv|tv : Integer|scPublic',
      'Exports\Blobby|Blobby|scPublic',
      'Exported Headings\implode|Procedure implode|scPublic',
      'Implemented Methods\implode|Procedure implode|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestInterfaceHeritage;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyInterface = Interface(IUnknown, IInterfaceedObject, ISomethingElse)'#13#10 +
    '    Procedure MyProc;'#13#10 +
    '    Procedure MyProc2;'#13#10 +
    '    Property Count : Integer Read GetCount;'#13#10 +
    '    Property Count2 : Integer Read GetCount2;'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyInterface|TMyInterface = Interface(IUnknown, IInterfaceedObject, ISomethingElse)|scPrivate',
      'Types\TMyInterface\Methods\MyProc|Procedure MyProc|scPublic',
      'Types\TMyInterface\Methods\MyProc2|Procedure MyProc2|scPublic',
      'Types\TMyInterface\Properties\Count|Property Count : Integer Read GetCount|scPublic',
      'Types\TMyInterface\Properties\Count2|Property Count2 : Integer Read GetCount2|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestInterfaceSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Uses'#13#10 +
    '  Windows;'#13#10 +
    ''#13#10 +
    'Type'#13#10 +
    '  t = Integer;'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    '  v : string;',
    '',
    [ttErrors, ttWarnings],
    [
      'Uses\Interface\Windows|Windows|scPublic',
      'Types\t|t = Integer|scPublic',
      'Variables\v|v : String|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestInterfaceType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyInterface1 = Interface'#13#10 +
    '  End;'#13#10 +
    '  TMyInterface2 = Interface(IUnknown)'#13#10 +
    '  End;'#13#10 +
    '  TMyInterface3 = Interface(IUnknown)'#13#10 +
    '    Procedure MyProc;'#13#10 +
    '    Procedure MyProc2;'#13#10 +
    '    Property Count : Integer Read GetCount;'#13#10 +
    '    Property Count2 : Integer Read GetCount2;'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyInterface1|TMyInterface1 = Interface|scPrivate',
      'Types\TMyInterface2|TMyInterface2 = Interface(IUnknown)|scPrivate',
      'Types\TMyInterface3|TMyInterface3 = Interface(IUnknown)|scPrivate',
      'Types\TMyInterface3\Methods\MyProc|Procedure MyProc|scPublic',
      'Types\TMyInterface3\Methods\MyProc2|Procedure MyProc2|scPublic',
      'Types\TMyInterface3\Properties\Count|Property Count : Integer Read GetCount|scPublic',
      'Types\TMyInterface3\Properties\Count2|Property Count2 : Integer Read GetCount2|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestReservedWords;

Var
  Words : TKeyWords;
  i : Integer;

Begin
  Words := FPascalModule.ReservedWords;
  CheckEquals(0, Low(Words));
  CheckEquals(73, High(Words));
  For i := Low(Words) To Pred(High(Words)) Do
    Check(Words[i] < Words[i + 1], Words[i] + '!<' + Words[i + 1]);
End;

Procedure TestTPascalModule.TestLabelDeclSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Label'#13#10 +
    '  Dave, DGH, Hoyle;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(i);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Labels\Dave|Dave|scLocal',
      'Implemented Methods\Hello\Labels\DGH|DGH|scLocal',
      'Implemented Methods\Hello\Labels\Hoyle|Hoyle|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestLoopStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure H73ello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  repeat'#13#10 +
    '    Inc(i);'#13#10 +
    '  until i > 10;'#13#10 +
    '  while i < 0 Do'#13#10 +
    '    Inc(i);'#13#10 +
    '  for i := 0 To 10 Do'#13#10 +
    '    Inc(j);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\H73ello|Procedure H73ello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestMethodHeading;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    '  MySecondObject = Object(TObject)'#13#10 +
    '    MyField : Integer;'#13#10 +
    '    Procedure MyMethod;'#13#10 +
    '    Function MyFunction : Integer;'#13#10 +
    '    Constructor Create;'#13#10 +
    '    Destructor Destroy;'#13#10 +
    '  End;',
    'Type'#13#10 +
    '  MyOtherObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure MySecondObject.MyMethod;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Function MySecondObject.MyFunction : Integer;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Constructor MySecondObject.Create;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Destructor MySecondObject.Destroy;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\MyObject|MyObject = Object(TObject)|scPublic',
      'Types\MySecondObject|MySecondObject = Object(TObject)|scPublic',
      'Types\MySecondObject\Fields\MyField|MyField : Integer|scPublic',
      'Types\MySecondObject\Methods\MyMethod|Procedure MyMethod|scPublic',
      'Types\MySecondObject\Methods\MyFunction|Function MyFunction : Integer|scPublic',
      'Types\MySecondObject\Methods\Create|Constructor Create|scPublic',
      'Types\MySecondObject\Methods\Destroy|Destructor Destroy|scPublic',
      'Types\MyOtherObject|MyOtherObject = Object(TObject)|scPrivate',
      'Implemented Methods\MySecondObject\MyMethod|Procedure MyMethod|scPublic',
      'Implemented Methods\MySecondObject\MyFunction|Function MyFunction : Integer|scPublic',
      'Implemented Methods\MySecondObject\Create|Constructor Create|scPublic',
      'Implemented Methods\MySecondObject\Destroy|Destructor Destroy|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestMethodList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    '  MySecondObject = Object(TObject)'#13#10 +
    '    MyField : Integer;'#13#10 +
    '    Procedure MyMethod;'#13#10 +
    '    Function MyFunction : Integer;'#13#10 +
    '    Constructor Create;'#13#10 +
    '    Destructor Destroy;'#13#10 +
    '  End;',
    'Type'#13#10 +
    '  MyOtherObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure MySecondObject.MyMethod;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Function MySecondObject.MyFunction : Integer;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Constructor MySecondObject.Create;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Destructor MySecondObject.Destroy;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\MyObject|MyObject = Object(TObject)|scPublic',
      'Types\MySecondObject|MySecondObject = Object(TObject)|scPublic',
      'Types\MySecondObject\Fields\MyField|MyField : Integer|scPublic',
      'Types\MySecondObject\Methods\MyMethod|Procedure MyMethod|scPublic',
      'Types\MySecondObject\Methods\MyFunction|Function MyFunction : Integer|scPublic',
      'Types\MySecondObject\Methods\Create|Constructor Create|scPublic',
      'Types\MySecondObject\Methods\Destroy|Destructor Destroy|scPublic',
      'Types\MyOtherObject|MyOtherObject = Object(TObject)|scPrivate',
      'Implemented Methods\MySecondObject\MyMethod|Procedure MyMethod|scPublic',
      'Implemented Methods\MySecondObject\MyFunction|Function MyFunction : Integer|scPublic',
      'Implemented Methods\MySecondObject\Create|Constructor Create|scPublic',
      'Implemented Methods\MySecondObject\Destroy|Destructor Destroy|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestMulOp;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  d := 1.2 * 2.3;'#13#10 +
    '  d := 1.2 / 4.2;'#13#10 +
    '  d := 1 Div 2;'#13#10 +
    '  d := 1 Mod 2;'#13#10 +
    '  d := 1 And 2;'#13#10 +
    '  d := 1 Shr 2;'#13#10 +
    '  d := 1 Shl 2;'#13#10 +
    'End;',
    [ttErrors, ttwarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestObjectEmpty;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyObject = Object'#13#10 +
    '  Strict Private'#13#10 +
    '  Private'#13#10 +
    '  Strict Protected'#13#10 +
    '  Protected'#13#10 +
    '  Public'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    ['Types\TMyObject|TMyObject = Object|scPublic']
  );
End;

Procedure TestTPascalModule.TestObjectOneOfEachMember;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyObject = Object'#13#10 +
    '  Strict Private'#13#10 +
    '    FInt : Integer;'#13#10 +
    '  Private'#13#10 +
    '    Const i = 10;'#13#10 +
    '    Var j : Integer;'#13#10 +
    '    Type T = (First, Last);'#13#10 +
    '    Class Var q : String;'#13#10 +
    '  Protected'#13#10 +
    '    Constructor Create;'#13#10 +
    '    Destructor Destroy;'#13#10 +
    '    Procedure Add;'#13#10 +
    '  Public'#13#10 +
    '    Function Hello : String;'#13#10 +
    '    Property Qwerty : Integer Read FInt;'#13#10 +
    '    //Class Operator Implicit(a, b : Integer) : Integer;'#13#10 +
    '  End;',
    'Constructor TMyObject.Create; Begin End;'#13#10 +
    ''#13#10 +
    'Destructor TMyObject.Destroy; Begin End;'#13#10 +
    ''#13#10 +
    'Procedure TMyObject.Add; Begin End;'#13#10 +
    ''#13#10 +
    'Function TMyObject.Hello : String; Begin End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyObject|TMyObject = Object|scPublic',
      'Types\TMyObject\Fields\FInt|FInt : Integer|scPrivate',
      'Types\TMyObject\Constants\i|i = 10|scPrivate',
      'Types\TMyObject\Variables\j|j : Integer|scPrivate',
      'Types\TMyObject\Types\T|T = (First, Last)|scPrivate',
      'Types\TMyObject\Class Variables\q|q : String|scPrivate',
      'Types\TMyObject\Methods\Create|Constructor Create|scProtected',
      'Types\TMyObject\Methods\Destroy|Destructor Destroy|scProtected',
      'Types\TMyObject\Methods\Add|Procedure Add|scProtected',
      'Types\TMyObject\Methods\Hello|Function Hello : String|scPublic',
      'Types\TMyObject\Properties\Qwerty|Property Qwerty : Integer Read FInt|scPublic',
      'Implemented Methods\TMyObject\Create|Constructor Create|scProtected',
      'Implemented Methods\TMyObject\Destroy|Destructor Destroy|scProtected',
      'Implemented Methods\TMyObject\Add|Procedure Add|scProtected',
      'Implemented Methods\TMyObject\Hello|Function Hello : String|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestObjectType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyObject = Object'#13#10 +
    '  End;'#13#10 +
    '  MySecondObject = Object'#13#10 +
    '    Procedure MyMethod;'#13#10 +
    '  End;',
    'Type'#13#10 +
    '  MyOtherObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure MySecondObject.MyMethod;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\MyObject|MyObject = Object|scPublic',
      'Types\MySecondObject|MySecondObject = Object|scPublic',
      'Types\MySecondObject\Methods\MyMethod|Procedure MyMethod|scPublic',
      'Types\MyOtherObject|MyOtherObject = Object(TObject)|scPrivate',
      'Implemented Methods\MySecondObject\MyMethod|Procedure MyMethod|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestObjFieldList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    '  MySecondObject = Object(TObject)'#13#10 +
    '    MyField : Integer;'#13#10 +
    '    MyField2, MyField3 : String;'#13#10 +
    '    Procedure MyMethod;'#13#10 +
    '  End;',
    'Type'#13#10 +
    '  MyOtherObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure MySecondObject.MyMethod;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\MyObject|MyObject = Object(TObject)|scPublic',
      'Types\MySecondObject|MySecondObject = Object(TObject)|scPublic',
      'Types\MySecondObject\Fields\MyField|MyField : Integer|scPublic',
      'Types\MySecondObject\Fields\MyField2|MyField2 : String|scPublic',
      'Types\MySecondObject\Fields\MyField3|MyField3 : String|scPublic',
      'Types\MySecondObject\Methods\MyMethod|Procedure MyMethod|scPublic',
      'Types\MyOtherObject|MyOtherObject = Object(TObject)|scPrivate',
      'Implemented Methods\MySecondObject\MyMethod|Procedure MyMethod|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestObjHeritage;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  MyObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    '  MySecondObject = Object(TObject)'#13#10 +
    '    MyField : Integer;'#13#10 +
    '    Procedure MyMethod;'#13#10 +
    '  End;',
    'Type'#13#10 +
    '  MyOtherObject = Object(TObject)'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure MySecondObject.MyMethod;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\MyObject|MyObject = Object(TObject)|scPublic',
      'Types\MySecondObject|MySecondObject = Object(TObject)|scPublic',
      'Types\MySecondObject\Fields\MyField|MyField : Integer|scPublic',
      'Types\MySecondObject\Methods\MyMethod|Procedure MyMethod|scPublic',
      'Types\MyOtherObject|MyOtherObject = Object(TObject)|scPrivate',
      'Implemented Methods\MySecondObject\MyMethod|Procedure MyMethod|scPublic'
    ]
  );
End;

procedure TestTPascalModule.TestOperatorAdd;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Add(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Add(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Add|Class Operator Add(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Add|Class Operator Add(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorBitwiseAnd;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator BitwiseAnd(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.BitwiseAnd(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\BitwiseAnd|Class Operator BitwiseAnd(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\BitwiseAnd|Class Operator BitwiseAnd(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorBitwiseNot;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator BitwiseNot(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.BitwiseNot(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\BitwiseNot|Class Operator BitwiseNot(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\BitwiseNot|Class Operator BitwiseNot(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorBitwiseOr;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator BitwiseOr(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.BitwiseOr(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\BitwiseOr|Class Operator BitwiseOr(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\BitwiseOr|Class Operator BitwiseOr(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorBitwiseXor;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator BitwiseXor(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.BitwiseXor(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|FInt : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\BitwiseXor|Class Operator BitwiseXor(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\BitwiseXor|Class Operator BitwiseXor(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorDec;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Inc(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Inc(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Inc|Class Operator Inc(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Inc|Class Operator Inc(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorDivide;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Divide(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Divide(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Divide|Class Operator Divide(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Divide|Class Operator Divide(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorEqual;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Equal(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Equal(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Equal|Class Operator Equal(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Equal|Class Operator Equal(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorExplicit;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Explicit(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Explicit(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Explicit|Class Operator Explicit(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Explicit|Class Operator Explicit(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorGreaterThan;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator GreaterThan(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.GreaterThan(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\GreaterThan|Class Operator GreaterThan(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\GreaterThan|Class Operator GreaterThan(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorGreaterThanOrEqual;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator GreaterThanOrEqual(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.GreaterThanOrEqual(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\GreaterThanOrEqual|Class Operator GreaterThanOrEqual(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\GreaterThanOrEqual|Class Operator GreaterThanOrEqual(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorImplicit;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Implicit(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Implicit(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|FInt : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Implicit|Class Operator Implicit(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Implicit|Class Operator Implicit(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorInc;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Inc(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Inc(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Inc|Class Operator Inc(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Inc|Class Operator Inc(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorIntDivide;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator IntDivide(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.IntDivide(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\IntDivide|Class Operator IntDivide(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\IntDivide|Class Operator IntDivide(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorLeftShift;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator LeftShift(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.LeftShift(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\LeftShift|Class Operator LeftShift(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\LeftShift|Class Operator LeftShift(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorLessThan;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator LessThan(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.LessThan(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\LessThan|Class Operator LessThan(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\LessThan|Class Operator LessThan(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorLessThanOrEqual;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator LessThanOrEqual(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.LessThanOrEqual(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [ 'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\LessThanOrEqual|Class Operator LessThanOrEqual(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\LessThanOrEqual|Class Operator LessThanOrEqual(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorLogicalAnd;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator LogicalAnd(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.LogicalAnd(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\LogicalAnd|Class Operator LogicalAnd(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\LogicalAnd|Class Operator LogicalAnd(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorLogicalNot;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator LogicalNot(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.LogicalNot(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [ 'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\LogicalNot|Class Operator LogicalNot(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\LogicalNot|Class Operator LogicalNot(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorLogicalOr;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator LogicalOr(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.LogicalOr(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\LogicalOr|Class Operator LogicalOr(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\LogicalOr|Class Operator LogicalOr(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorLogicalXor;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator LogicalXor(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.LogicalXor(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\LogicalXor|Class Operator LogicalXor(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\LogicalXor|Class Operator LogicalXor(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorModulus;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Modulus(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Modulus(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Modulus|Class Operator Modulus(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Modulus|Class Operator Modulus(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorMultiply;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Multiply(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Multiply(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Multiply|Class Operator Multiply(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Multiply|Class Operator Multiply(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorNegative;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Negative(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Negative(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Negative|Class Operator Negative(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Negative|Class Operator Negative(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorNotEqual;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator NotEqual(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.NotEqual(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\NotEqual|Class Operator NotEqual(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\NotEqual|Class Operator NotEqual(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorPositive;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Positive(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Positive(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Positive|Class Operator Positive(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Positive|Class Operator Positive(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorRightShift;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator RightShift(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.RightShift(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\RightShift|Class Operator RightShift(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\RightShift|Class Operator RightShift(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorRound;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Round(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Round(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Round|Class Operator Round(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Round|Class Operator Round(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorSubtract;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Subtract(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Subtract(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Subtract|Class Operator Subtract(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Subtract|Class Operator Subtract(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOperatorTrunc;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    Strict Private'#13#10 +
    '      FInt : Integer;'#13#10 +
    '    Public'#13#10 +
    '      Constructor Create(i : Integer);'#13#10 +
    '      Class Operator Trunc(a, b : TMyRecord) : TMyRecord;'#13#10 +
    'End;',
    'Constructor TMyRecord.Create(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  FInt := i;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Class Operator TMyRecord.Trunc(a, b : TMyRecord) : TMyRecord;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Result := TMyRecord.Create(a + b);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|Fint : Integer|scPrivate',
      'Types\TMyRecord\Methods\Create|Constructor Create(i : Integer)|scPublic',
      'Types\TMyRecord\Methods\Trunc|Class Operator Trunc(a, b : TMyRecord) : TMyRecord|scPublic',
      'Implemented Methods\TMyRecord\Create|Constructor Create(i : Integer)|scPublic',
      'Implemented Methods\TMyRecord\Trunc|Class Operator Trunc(a, b : TMyRecord) : TMyRecord|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOPLibrary;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Library MyLibrary;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(''Hello'');'#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    []
  );
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Library MyLibrary.Namespace;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(''Hello'');'#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestOPPackage;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Package MyPackage;'#13#10 +
    ''#13#10 +
    'Requires'#13#10 +
    '  VCL50;'#13#10 +
    ''#13#10 +
    'Contains'#13#10 +
    '  DGHLibrary In ''DGHLibrary.pas'';'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Requires\VCL50|VCL50|scNone',
      'Contains\DGHLibrary|DGHLibrary In ''DGHLibrary.pas''|scNone'
    ]
  );
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Package MyPackage.Namespace;'#13#10 +
    ''#13#10 +
    'Requires'#13#10 +
    '  VCL50;'#13#10 +
    ''#13#10 +
    'Contains'#13#10 +
    '  DGHLibrary In ''DGHLibrary.pas'';'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Requires\VCL50|VCL50|scNone',
      'Contains\DGHLibrary|DGHLibrary In ''DGHLibrary.pas''|scNone'
    ]
  );
End;

Procedure TestTPascalModule.TestOPProgram;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Program MyProgram;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(''Hello'');'#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    []
  );
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Program MyProgram.Namespace;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(''Hello'');'#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestOPType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  a = THello;'#13#10 +
    '  b = [1..2];'#13#10 +
    '  c = (eOne, eTwo);'#13#10 +
    '  d = record'#13#10 +
    '      end;'#13#10 +
    '  e = ^d;'#13#10 +
    '  f = String;'#13#10 +
    '  g = function(i : Integer) : integer;'#13#10 +
    '  h = variant;'#13#10 +
    '  i = class of THello;',
    '',
    [ttErrors, ttwarnings],
    [
      'Types\a|a = THello|scPublic',
      'Types\b|b = [1..2]|scPublic',
      'Types\c|c = (eOne, eTwo)|scPublic',
      'Types\d|d = Record|scPublic',
      'Types\e|e = ^d|scPublic',
      'Types\f|f = String|scPublic',
      'Types\g|g = Function(i : Integer) : Integer|scPublic',
      'Types\h|h = Variant|scPublic',
      'Types\i|i = Class Of THello|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOPUnit;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Unit MyUnit;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Uses'#13#10 +
    '  Windows;'#13#10 +
    ''#13#10 +
    '  Procedure Hello;'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  i = 10;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(i);'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Uses\Interface\Windows|Windows|scPublic',
      'Exported Headings\Hello|Procedure Hello|scPublic',
      'Constants\i|i = 10|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPublic'
    ]
  );
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Unit MyUnit.Namespace;'#13#10 +
    ''#13#10 +
    'Interface'#13#10 +
    ''#13#10 +
    'Uses'#13#10 +
    '  Windows;'#13#10 +
    ''#13#10 +
    '  Procedure Hello;'#13#10 +
    ''#13#10 +
    'Implementation'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  i = 10;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(i);'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Uses\Interface\Windows|Windows|scPublic',
      'Exported Headings\Hello|Procedure Hello|scPublic',
      'Constants\i|i = 10|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestOrdIdent;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = ShortInt;'#13#10 +
    '  t02 = SmallInt;'#13#10 +
    '  t03 = Integer;'#13#10 +
    '  t04 = Byte;'#13#10 +
    '  t05 = LongInt;'#13#10 +
    '  t06 = Int64;'#13#10 +
    '  t07 = Word;'#13#10 +
    '  t08 = Boolean;'#13#10 +
    '  t09 = Char;'#13#10 +
    '  t10 = WideChar;'#13#10 +
    '  t11 = LongWord;'#13#10 +
    '  t12 = PChar;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = ShortInt|scPrivate',
      'Types\t02|t02 = Smallint|scPrivate',
      'Types\t03|t03 = Integer|scPrivate',
      'Types\t04|t04 = Byte|scPrivate',
      'Types\t05|t05 = LongInt|scPrivate',
      'Types\t06|t06 = Int64|scPrivate',
      'Types\t07|t07 = Word|scPrivate',
      'Types\t08|t08 = Boolean|scPrivate',
      'Types\t09|t09 = Char|scPrivate',
      'Types\t10|t10 = WideChar|scPrivate',
      'Types\t11|t11 = LongWord|scPrivate',
      'Types\t12|t12 = PChar|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestOrdinalType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  a = 1..2;'#13#10 +
    '  b = (eOne, eTwo);'#13#10 +
    '  c = Byte;',
    [ttErrors, ttWarnings],
    [
      'Types\a|a = 1..2|scPrivate',
      'Types\b|b = (eOne, eTwo)|scPrivate',
      'Types\c|c = Byte|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestParameter;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Ident1(i);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Ident2(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Ident3(i : String);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Ident4(i : File);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Ident5(i : Array Of Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Ident6(i : Integer = 0);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Ident1|Procedure Ident1(i)|scPrivate',
      'Implemented Methods\Ident2|Procedure Ident2(i : Integer)|scPrivate',
      'Implemented Methods\Ident3|Procedure Ident3(i : String)|scPrivate',
      'Implemented Methods\Ident4|Procedure Ident4(i : File)|scPrivate',
      'Implemented Methods\Ident5|Procedure Ident5(i : Array Of Integer)|scPrivate',
      'Implemented Methods\Ident6|Procedure Ident6(i : Integer = 0)|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestPointerType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = ^Integer;'#13#10 +
    '  t02 = ^TSomething platform;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = ^Integer|scPrivate',
      'Types\t02|t02 = ^TSomething|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestPortabilityDirective;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  t = Integer library;'#13#10 +
    '  u = Class'#13#10 +
    '    property oops library;'#13#10 +
    '  End deprecated;'#13#10 +
    '  a = Array[1..2] of Integer platform;'#13#10 +
    '  r = record'#13#10 +
    '    myField : String platform;'#13#10 +
    '  end library;'#13#10 +
    '  s = set of integer deprecated;'#13#10 +
    '  f = file of integer deprecated;'#13#10 +
    '  p = ^Integer platform;',
    'Const'#13#10 +
    '  i = 1 deprecated;'#13#10 +
    '  j : Integer = 2 deprecated;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  k : Integer platform;'#13#10 +
    ''#13#10 +
    'ThreadVar'#13#10 +
    '  str : Integer platform;'#13#10 +
    ''#13#10 +
    'procedure Hello; platform'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function Hello1 : integer; platform'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'function Hello2 : integer; platform deprecated'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'procedure Hello3; platform; deprecated;'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'constructor create; platform'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;'#13#10 +
    ''#13#10 +
    'destructor destroy; platform'#13#10 +
    ''#13#10 +
    'begin'#13#10 +
    'end;',
    [ttErrors, ttWarnings],
    [
      'Types\t|t = Integer|scPublic',
      'Types\u|u = Class|scPublic',
      'Types\u\Properties\oops|Property oops|scPublished',
      'Types\a|a = Array[1..2] of Integer|scPublic',
      'Types\r|r = Record|scPublic',
      'Types\r\Fields\myField|myField : String|scPublic',
      'Types\s|s = set of integer|scPublic',
      'Types\f|f = file of integer|scPublic',
      'Types\p|p = ^Integer|scPublic',
      'Constants\i|i = 1|scPrivate',
      'Constants\j|j : Integer = 2|scPrivate',
      'Variables\k|k : Integer|scPrivate',
      'Thread Variables\str|str : Integer|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello1|Function Hello1 : integer|scPrivate',
      'Implemented Methods\Hello2|Function Hello2 : integer|scPrivate',
      'Implemented Methods\Hello3|Procedure Hello3|scPrivate',
      'Implemented Methods\Create|Constructor Create|scPrivate',
      'Implemented Methods\Destroy|Destructor Destroy|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestProcedureDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello; Virtual; Platform'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello; Virtual|scPrivate']
  );
End;

Procedure TestTPascalModule.TestProcedureDeclSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Function Hello2 : Boolean;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Constructor Create;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Destructor Destroy;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello2|Function Hello2 : Boolean|scPrivate',
      'Implemented Methods\Create|Constructor Create|scPrivate',
      'Implemented Methods\Destroy|Destructor Destroy|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestProcedureHeading;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Ident;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Ident2;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Procedure Ident3(i : Integer);'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Ident|Procedure Ident|scPrivate',
      'Implemented Methods\Ident2|Procedure Ident2|scPrivate',
      'Implemented Methods\Ident3|Procedure Ident3(i : Integer)|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestProcedureType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Procedure;'#13#10 +
    '  t02 = Procedure(i : Integer);'#13#10 +
    '  t03 = Procedure(i, j : Integer);'#13#10 +
    '  t04 = Procedure(i, j : Integer; k : Integer);'#13#10 +
    '  t05 = Procedure(i : Integer) Of Object;'#13#10 +
    '  t06 = Function(i, j : Integer; s : String) : Boolean Of Object;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Procedure|scPrivate',
      'Types\t02|t02 = Procedure(i : Integer)|scPrivate',
      'Types\t03|t03 = Procedure(i, j : Integer)|scPrivate',
      'Types\t04|t04 = Procedure(i, j, k : Integer)|scPrivate',
      'Types\t05|t05 = Procedure(i : Integer) Of Object|scPrivate',
      'Types\t06|t06 = Function(i, j : Integer; s : String) : Boolean Of Object|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestProcessCompilerDirective;

Begin
  TestGrammarForErrors( // Test IFDEF ENDIF
    TPascalModule,
    strUnit,
    '{$DEFINE DGH}'#13#10,
    '{$IFDEF DGH}'#13#10 +
    'Const iMyConstant : Integer = 1;'#13#10 +
    '{$ENDIF}',
    [ttErrors, ttWarnings],
    [
      'Constants\iMyConstant|iMyConstant : Integer = 1|scPrivate'
    ], 0, 0, 0, 0, 0, 0, '$IFDEF $ENDIF'
  );
  TestGrammarForErrors( // Test IFDEF ELSE ENDIF 1
    TPascalModule,
    strUnit,
    '{$DEFINE DGH}'#13#10,
    '{$IFDEF DGH}'#13#10 +
    'Const iMyConstant : Integer = 0;'#13#10 +
    '{$ELSE}'#13#10 +
    'Const iMyConstant : Integer = 1;'#13#10 +
    '{$ENDIF}',
    [ttErrors, ttWarnings],
    [
      'Constants\iMyConstant|iMyConstant : Integer = 0|scPrivate'
    ], 0, 0, 0, 0, 0, 0, '$IFDEF $ELSE $ENDIF 1'
  );
  TestGrammarForErrors( // Test IFDEF ELSE ENDIF 2
    TPascalModule,
    strUnit,
    '{$DEFINE DGH1}'#13#10,
    '{$IFDEF DGH}'#13#10 +
    'Const iMyConstant : Integer = 0;'#13#10 +
    '{$ELSE}'#13#10 +
    'Const iMyConstant : Integer = 1;'#13#10 +
    '{$ENDIF}',
    [ttErrors, ttWarnings],
    [
      'Constants\iMyConstant|iMyConstant : Integer = 1|scPrivate'
    ], 0, 0, 0, 0, 0, 0, '$IFDEF $ELSE $ENDIF 1'
  );
  TestGrammarForErrors( // Test IFNDEF ELSE ENDIF 1
    TPascalModule,
    strUnit,
    '{$DEFINE DGH}'#13#10,
    '{$IFDEF DGH}'#13#10 +
    'Const iMyConstant : Integer = 0;'#13#10 +
    '{$ELSE}'#13#10 +
    'Const iMyConstant : Integer = 1;'#13#10 +
    '{$ENDIF}',
    [ttErrors, ttWarnings],
    [
      'Constants\iMyConstant|iMyConstant : Integer = 0|scPrivate'
    ], 0, 0, 0, 0, 0, 0, '$IFNDEF $ELSE $ENDIF 0'
  );
  TestGrammarForErrors( // Test IFNDEF ELSE ENDIF 2
    TPascalModule,
    strUnit,
    '{$DEFINE DGH1}'#13#10,
    '{$IFDEF DGH}'#13#10 +
    'Const iMyConstant : Integer = 0;'#13#10 +
    '{$ELSE}'#13#10 +
    'Const iMyConstant : Integer = 1;'#13#10 +
    '{$ENDIF}',
    [ttErrors, ttWarnings],
    [
      'Constants\iMyConstant|iMyConstant : Integer = 1|scPrivate'
    ], 0, 0, 0, 0, 0, 0, '$IFNDEF $ELSE $ENDIF 0'
  );
  TestGrammarForErrors( // Test IF IFEND
    TPascalModule,
    strUnit,
    '',
    'type'#13#10 +
    '  TMyclass = class'#13#10 +
    '    property qwerty;'#13#10 +
    '    //{$if CompilerVersion >= 34}property Hello;{$ifend}'#13#10 +
    '    property Goodbye;'#1#10 +
    '  end;',
    [ttErrors, ttWarnings],
    [], 0, 0, 0, 0, 0, 0, '$IF $IFEND'
  );
  //---------------------------------------------------------------------------------------------
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '{$DEFINE DGH}'#13#10 +
    '{$DEFINE DGH1}'#13#10 +
    '{$UNDEF DGH1}',
    '{$IFDEF DGH}'#13#10 +
    'Const iMyConstant : Integer = 1;'#13#10 +
    '{$ELSE}'#13#10 +
    'Const iMyConstant : Integer = 0;'#13#10 +
    '{$ENDIF}'#13#10 +
    ''#13#10 +
    '{$IFNDEF DGH}'#13#10 +
    'Var iMyVar : Integer;'#13#10 +
    '{$ENDIF}'#13#10 +
    ''#13#10 +
    'Procedure Test();'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  {$IFOPT R=}'#13#10 +
    '  WriteLn(''Hello!'');'#13#10 +
    '  {$ENDIF}'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    '{$EXTERNALSYM MySymbol}',
    [ttErrors, ttWarnings],
    [
      'Constants\iMyConstant|iMyConstant : Integer = 1|scPrivate'
    ], 0, 0, 0, 0, 0, 0, 'Complex 1'
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Uses'#13#10 +
    '  Classes,'#13#10 +
    '  {$IFNDEF CONSOLE}'#13#10 +
    '  Forms,'#13#10 +
    '  {$ENDIF}'#13#10 +
    '  SysUtils;'#13#10 +
    ''#13#10 +
    '{$IFDEF PROFILECODE}'#13#10 +
    'Type'#13#10 +
    '  TProfiler = Class'#13#10 +
    '  Strict Private'#13#10 +
    '    FStackTop : Integer;'#13#10 +
    '    {$IFNDEF CONSOLE}'#13#10 +
    '    FLabel : TLabel;'#13#10 +
    '    {$ENDIF}'#13#10 +
    '  Strict Protected'#13#10 +
    '  Public'#13#10 +
    '  End;'#13#10 +
    '{$ENDIF}'#13#10 +
    '',
    '{$IFDEF PROFILECODE}'#13#10 +
    '{$ENDIF}',
    [ttErrors, ttWarnings],
    [], 0, 0, 0, 0, 0, 0, 'Complex 2'
  );
End;

Procedure TestTPascalModule.TestProgramBlock;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Program MyProgram;'#13#10 +
    ''#13#10 +
    'Uses'#13#10 +
    '  SysUtils, Windows;'#13#10 +
    ''#13#10 +
    'ResourceString'#13#10 +
    '  strHello = ''Hello'';'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(strHello);'#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Uses\SysUtils|SysUtils|scPublic',
      'Uses\Windows|Windows|scPublic',
      'Resource Strings\strHello|strHello = ''Hello''|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestPropertyInterface;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  private'#13#10 +
    '    Property MyPrivateProperty[Ident1, Ident2 : Integer; Ident3 : String] : Boolean;'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPrivate',
      'Types\TMyClass\Properties\MyPrivateProperty|Property MyPrivateProperty[Ident1, Ident2 : Integer; Ident3 : String] : Boolean|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestPropertyList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  private'#13#10 +
    '    Property MyPrivateProperty;'#13#10 +
    '  protected'#13#10 +
    '    Property MyProtectedProperty : Boolean;'#13#10 +
    '  public'#13#10 +
    '    Property MyPublicProperty[iIndex : Integer] : Boolean;'#13#10 +
    '  published'#13#10 +
    '    Property MyPublishedProperty : String Read FProp;'#13#10 +
    '  strict private'#13#10 +
    '    Property MyStrictPrivateProperty : String Write FProp;'#13#10 +
    '  strict protected'#13#10 +
    '    Property MyStrictProtectedProperty Platform;'#13#10 +
    '    Property MyStrictProtectedProperty2;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Properties\MyPrivateProperty|Property MyPrivateProperty|scPrivate',
      'Types\TMyClass\Properties\MyProtectedProperty|Property MyProtectedProperty : Boolean|scProtected',
      'Types\TMyClass\Properties\MyPublicProperty|Property MyPublicProperty[iIndex : Integer] : Boolean|scPublic',
      'Types\TMyClass\Properties\MyPublishedProperty|Property MyPublishedProperty : String Read FProp|scPublished',
      'Types\TMyClass\Properties\MyStrictPrivateProperty|Property MyStrictPrivateProperty : String Write FProp|scPrivate',
      'Types\TMyClass\Properties\MyStrictProtectedProperty|Property MyStrictProtectedProperty|scProtected',
      'Types\TMyClass\Properties\MyStrictProtectedProperty2|Property MyStrictProtectedProperty2|scProtected'
    ]
  );
End;

Procedure TestTPascalModule.TestPropertyParameterList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  private'#13#10 +
    '    Property MyPrivateProperty[Ident1, Ident2 : Integer; Ident3 : String] : Boolean;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Properties\MyPrivateProperty|Property MyPrivateProperty[Ident1, Ident2 : Integer; Ident3 : String] : Boolean|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestPropertySpecifiers;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '  private'#13#10 +
    '    Property MyProperty1 : Boolean Index 1 + 2 / 3;'#13#10 +
    '    Property MyProperty2 : Boolean Read FProp;'#13#10 +
    '    Property MyProperty3 : Boolean Write FProp;'#13#10 +
    '    Property MyProperty5 : Boolean Stored FIdent;'#13#10 +
    '    Property MyProperty6 : Boolean Stored Value;'#13#10 +
    '    Property MyProperty7 : Boolean default 1 + 2;'#13#10 +
    '    Property MyProperty8 : Boolean nodefault ;'#13#10 +
    '    Property MyProperty9 : Boolean implements mythingy;'#13#10 +
    '    Property MyPropertyA : Boolean implements mythingy, mythingy2;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Properties\MyProperty1|Property MyProperty1 : Boolean Index 1 + 2 / 3|scPrivate',
      'Types\TMyClass\Properties\MyProperty2|Property MyProperty2 : Boolean Read FProp|scPrivate',
      'Types\TMyClass\Properties\MyProperty3|Property MyProperty3 : Boolean Write FProp|scPrivate',
      'Types\TMyClass\Properties\MyProperty5|Property MyProperty5 : Boolean Stored FIdent|scPrivate',
      'Types\TMyClass\Properties\MyProperty6|Property MyProperty6 : Boolean Stored Value|scPrivate',
      'Types\TMyClass\Properties\MyProperty7|Property MyProperty7 : Boolean Default 1 + 2|scPrivate',
      'Types\TMyClass\Properties\MyProperty8|Property MyProperty8 : Boolean|scPrivate',
      'Types\TMyClass\Properties\MyProperty9|Property MyProperty9 : Boolean Implements mythingy|scPrivate',
      'Types\TMyClass\Properties\MyPropertyA|Property MyPropertyA : Boolean Implements mythingy, mythingy2|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestRaiseStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  raise exception.create;'#13#10 +
    '  raise exception.create at $FFFFFFFF;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestRealType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  r1 = Real48;'#13#10 +
    '  r2 = Real;'#13#10 +
    '  r3 = Single;'#13#10 +
    '  r4 = Double;'#13#10 +
    '  r5 = Extended;'#13#10 +
    '  r6 = Currency;'#13#10 +
    '  r7 = Comp;',
    [ttErrors, ttWarnings],
    [
      'Types\r1|r1 = Real48|scPrivate',
      'Types\r2|r2 = Real|scPrivate',
      'Types\r3|r3 = Single|scPrivate',
      'Types\r4|r4 = Double|scPrivate',
      'Types\r5|r5 = Extended|scPrivate',
      'Types\r6|r6 = Currency|scPrivate',
      'Types\r7|r7 = Comp|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestRecordConstant;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  k : Array[1..2] of TRec = ('#13#10 +
    '    (Name: ''Hello''; Value : 1),'#13#10 +
    '    (Name: ''Hello''; Value : 1)'#13#10 +
    '  );'#13#10 +
    ''#13#10 +
    'Begin;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Constants\k|k : Array[1..2] of TRec = ((Name : ''Hello''; Value : 1), (Name : ''Hello''; Value : 1))|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestRecordEmpty;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Packed Record'#13#10 +
    '  End;',
    '',
    [ttErrors],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRecordFieldConstant;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  k : Array[1..2] of TRec = ('#13#10 +
    '    (Name: ''Hello''; Value : 1 * 2 + 3 /4),'#13#10 +
    '    (Name: ''Hello''; Value : 1.0)'#13#10 +
    '  );'#13#10 +
    ''#13#10 +
    'Begin;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Constants\k|k : Array[1..2] of TRec = ((Name : ''Hello''; Value : 1 * 2 + 3 / 4), (Name : ''Hello''; Value : 1.0))|scLocal'
    ]
  );
End;

procedure TestTPascalModule.TestRecordHelper;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TRecordHelper = Record Helper For Integer'#13#10 +
    '    Function AsString(i : Integer) : String;'#13#10 +
    '  End;',
    'Function TRecordHelper.AsString(i : Integer) : String;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TRecordHelper|TRecordHelper = Record Helper For Integer|scPublic',
      'Types\TRecordHelper\Methods\AsString|Function AsString(i : Integer) : String|scPublic',
      'Implemented Methods\TRecordHelper\AsString|Function AsString(i : Integer) : String|scPublic'
    ]
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TRecordHelper = Record Helper For System.Integer'#13#10 +
    '    Function AsString(i : Integer) : String;'#13#10 +
    '  End;',
    'Function TRecordHelper.AsString(i : Integer) : String;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TRecordHelper|TRecordHelper = Record Helper For System.Integer|scPublic',
      'Types\TRecordHelper\Methods\AsString|Function AsString(i : Integer) : String|scPublic',
      'Implemented Methods\TRecordHelper\AsString|Function AsString(i : Integer) : String|scPublic'
    ]
  );
End;

procedure TestTPascalModule.TestRecordHelperWithHeritage;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TRecordHelper = Record Helper (TOtherRecordHelper) For Integer'#13#10 +
    '    Function AsString(i : Integer) : String;'#13#10 +
    '  End;',
    'Function TRecordHelper.AsString(i : Integer) : String;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TRecordHelper|TRecordHelper = Record Helper(TOtherRecordHelper) For Integer|scPublic',
      'Types\TRecordHelper\Methods\AsString|Function AsString(i : Integer) : String|scPublic',
      'Implemented Methods\TRecordHelper\AsString|Function AsString(i : Integer) : String|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRecordOneMemberPerVisibility;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Packed Record'#13#10 +
    '  Private'#13#10 +
    '    FInt : Integer;'#13#10 +
    '  Strict Private'#13#10 +
    '    Procedure Add;'#13#10 +
    '  Private'#13#10 +
    '    Const i = 10;'#13#10 +
    '  Strict Private'#13#10 +
    '    Var j : Integer;'#13#10 +
    '  Public'#13#10 +
    '    Type TEnum = (First, Last);'#13#10 +
    '  Public'#13#10 +
    '    Class Var k : String;'#13#10 +
    '  End;',
    '',
    [ttErrors],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FInt|FInt : Integer|scPrivate',
      'Types\TMyRecord\Methods\Add|Procedure Add|scPrivate',
      'Types\TMyRecord\Constants\i|i = 10|scPrivate',
      'Types\TMyRecord\Variables\j|j : Integer|scPrivate',
      'Types\TMyRecord\Types\TEnum|TEnum = (First, Last)|scPublic',
      'Types\TMyRecord\Class Variables\k|k : String|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRecordVisibilityOnly;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyRecord = Packed Record'#13#10 +
    '  Private'#13#10 +
    '  Strict Private'#13#10 +
    '  Public'#13#10 +
    '  End;',
    '',
    [ttErrors],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRecType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Record'#13#10 +
    '    FField : Integer;'#13#10 +
    '  End;'#13#10 +
    '  t02 = Record'#13#10 +
    '    FField : Integer;'#13#10 +
    '  End platform;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Record|scPrivate',
      'Types\t01\Fields\FField|FField : Integer|scPublic',
      'Types\t02|t02 = Record|scPrivate',
      'Types\t02\Fields\FField|FField : Integer|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRecVariant;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Record'#13#10 +
    '    FField1 : Integer;'#13#10 +
    '    FField2 : String;'#13#10 +
    '  End;'#13#10 +
    '  THInfo = Record'#13#10 +
    '    dblBearing : Double;'#13#10 +
    '    Case THInfoType Of'#13#10 +
    '      itSetout  : (dblEasting, dblNorthing  : Double);'#13#10 +
    '      itMeasure, itCompare : (dblChainage : Double;'#13#10 +
    '        Case THInfoType Of'#13#10 +
    '          itMeasure: (dblOffset : Double);'#13#10 +
    '          itCompare: (dblDistance : Double);'#13#10 +
    '    );'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Record|scPrivate',
      'Types\t01\Fields\FField1|FField1 : Integer|scPublic',
      'Types\t01\Fields\FField2|FField2 : String|scPublic',
      'Types\THInfo|THInfo = Record|scPrivate',
      'Types\THInfo\Fields\dblBearing|dblBearing : Double|scPublic',
      'Types\THInfo\Fields\dblEasting|dblEasting : Double|scPublic',
      'Types\THInfo\Fields\dblNorthing|dblNorthing : Double|scPublic',
      'Types\THInfo\Fields\dblChainage|dblChainage : Double|scPublic',
      'Types\THInfo\Fields\dblOffset|dblOffset : Double|scPublic',
      'Types\THInfo\Fields\dblDistance|dblDistance : Double|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestReferenceSymbol;

Var
  T : TTokenInfo;

Begin
  T := TTokenInfo.Create('Hello1', 0, 0, 0, 5, ttIdentifier);
  Try
    CheckEquals(False, FPascalModule.ReferenceSymbol(T));
  Finally
    T.Free;
  End;
  T := TTokenInfo.Create('Hello', 0, 0, 0, 5, ttIdentifier);
  Try
    CheckEquals(True, FPascalModule.ReferenceSymbol(T));
  Finally
    T.Free;
  End;
End;

Procedure TestTPascalModule.TestRelOp;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  bool := 1 > 2;'#13#10 +
    '  bool := 1 < 2;'#13#10 +
    '  bool := 1 <= 2;'#13#10 +
    '  bool := 1 >= 2;'#13#10 +
    '  bool := 1 <> 2;'#13#10 +
    '  bool := fsBold In MyStyles;'#13#10 +
    '  bool := MyClass Is TDGHObject;'#13#10 +
    '  (MyObject As TClass);'#13#10 +
    '  bool := 1 = 2;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestRepeatStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  repeat'#13#10 +
    '    Inc(i);'#13#10 +
    '  until i > 10;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestRequiresClause;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strNone,
    'Package MyPackage;'#13#10 +
    ''#13#10 +
    'Requires'#13#10 +
    '  VCL50,'#13#10 +
    '  DesignIDE;'#13#10 +
    ''#13#10 +
    'Contains'#13#10 +
    '  DGHLibrary In ''DGHLibrary.pas'';'#13#10 +
    ''#13#10 +
    'End.',
    '',
    [ttErrors, ttWarnings],
    [
      'Requires\VCL50|VCL50|scNone',
      'Requires\DesignIDE|DesignIDE|scNone',
      'Contains\DGHLibrary|DGHLibrary In ''DGHLibrary.pas''|scNone'
    ]
  );
End;

Procedure TestTPascalModule.TestResourceStringDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'ResourceString'#13#10 +
    '  str1 = ''Hello'';',
    'ResourceString'#13#10 +
    '  str2 = ''Hello'' + '#13#10 +
    '    '' Goodbye'';'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'ResourceString'#13#10 +
    '  str3 = ''Hello'';'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(i);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Resource Strings\str1|str1 = ''Hello''|scPublic',
      'Resource Strings\str2|str2 = ''Hello'' + '' Goodbye''|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Resource Strings\str3|str3 = ''Hello''|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestResStringSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'ResourceString'#13#10 +
    '  str1 = ''Hello'';',
    'ResourceString'#13#10 +
    '  str2 = ''Hello'';'#13#10 +
    '  str4 = ''Hello'';'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'ResourceString'#13#10 +
    '  str3 = ''Hello'';'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  WriteLn(i);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Resource Strings\str1|str1 = ''Hello''|scPublic',
      'Resource Strings\str2|str2 = ''Hello''|scPrivate',
      'Resource Strings\str4|str4 = ''Hello''|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Resource Strings\str3|str3 = ''Hello''|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestRestrictedType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  a = Object End;'#13#10 +
    '  b = Object(TMyObject)'#13#10 +
    '  End;'#13#10 +
    '  c = Class;'#13#10 +
    '  d = Class(TObecjt)'#13#10 +
    '  End;'#13#10 +
    '  e = Interface;'#13#10 +
    '  f = Interface(IInterface)'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\a|a = Object|scPublic',
      'Types\b|b = Object(TMyObject)|scPublic',
      'Types\c|c = Class|scPublic',
      'Types\d|d = Class(TObecjt)|scPublic',
      'Types\e|e = Interface|scPublic',
      'Types\f|f = Interface(IInterface)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesClass;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [Custom]'#13#10 +
    '  TMyClass = Class(TObject)'#13#10 +
    '  Strict Private'#13#10 +
    '    [Custom(Hello)]'#13#10 +
    '    FInteger : Integer;'#13#10 +
    '  Strict Protected'#13#10 +
    '    [Custom, Custom1(''Hello'')]'#13#10 +
    '    Procedure MyProc(i : Integer); Abstract;'#13#10 +
    '  Public'#13#10 +
    '    [Custom2()]'#13#10 +
    '    Property Int : Integer Read FInteger;'#13#10 +
    '  End;',
    'Procedure TMyClass.MyProc(i : Integer); Begin End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class(TObject)|scPublic',
      'Types\TMyClass\Fields\FInteger|FInteger : Integer|scPrivate',
      'Types\TMyClass\Methods\MyProc|Procedure MyProc(i : Integer); Abstract|scProtected',
      'Types\TMyClass\Properties\Int|Property Int : Integer Read FInteger|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesComplexType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [Custom(Arguemnt1, Argument2, Argument3)]'#13#10 +
    '  TSimpleType = Set Of (stOne, stTwo, stThree);',
    '',
    [ttErrors, ttWarnings],
    ['Types\TSimpleType|TSimpleType = Set Of (stOne, stTwo, stThree)|scPublic']
  );
End;

procedure TestTPascalModule.TestRTTIAttributesGalore;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +                                              //   5
    '  SimpleAttribute = Class(TCustomAttribute);'#13#10 +      //
    ''#13#10 +                                                  //
    '  [Simple]'#13#10 +                                        //
    '  TMyRecord = Record'#13#10 +                              //
    '  Strict Private'#13#10 +                                  //  10
    '    [Simple]'#13#10 +                                      //
    '    FInt : Integer;'#13#10 +                               //
    '  Private'#13#10 +                                         //
    '    Type'#13#10 +                                          //
    '    [Simple]'#13#10 +                                      //  15
    '      TMyEnum = (myFirst, meLast);'#13#10 +                //
    '  //Strict Protected // Not permitted'#13#10 +             //
    '    Var'#13#10 +                                           //
    '    [Simple]'#13#10 +                                      //
    '      i : Integer;'#13#10 +                                //  20
    '    Const'#13#10 +                                         //
    '    [Simple]'#13#10 +                                      //
    '      j = 10;'#13#10 +                                     //
    '    Class Var'#13#10 +                                     //
    '    [Simple]'#13#10 +                                      //  25
    '      q : String;'#13#10 +                                 //
    '  Public'#13#10 +                                          //
    '    [Simple]'#13#10 +                                      //
    '    Procedure Add;'#13#10 +                                //
    '    [Simple]'#13#10 +                                      //  30
    '    Constructor Create(i : Integer);'#13#10 +              //
    '    //: @note this is not allowed here Destructor Destroy;'#13#10 +
    '    [Simple]'#13#10 +                                      //
    '    Class Operator Add(a, b : TMyRecord) : TMyRecord;'#13#10 +
    '    [Simple]'#13#10 +                                      //  35
    '    Property Hello : Integer Read FInt;'#13#10 +           //
    '  End;'#13#10 +                                            //
    ''#13#10 +                                                  //
    '  [Simple]'#13#10 +                                        //
    '  TMyObject = Object'#13#10 +                              //  40
    '  Strict Private'#13#10 +                                  //
    '    [Simple]'#13#10 +                                      //
    '    FInt : Integer;'#13#10 +                               //
    '  Private'#13#10 +                                         //
    '    Const'#13#10 +                                         //  45
    '    [Simple]'#13#10 +                                      //
    '      i = 10;'#13#10 +                                     //
    '    Var'#13#10 +                                           //
    '    [Simple]'#13#10 +                                      //
    '      j : Integer;'#13#10 +                                //  50
    '    Type'#13#10 +                                          //
    '    [Simple]'#13#10 +                                      //
    '      T = (First, Last);'#13#10 +                          //
    '  Strict Protected'#13#10 +                                //
    '    Class Var'#13#10 +                                     //  55
    '    [Simple] q : String;'#13#10 +                          //
    '  Protected'#13#10 +                                       //
    '    [Simple]'#13#10 +                                      //
    '    Constructor Create;'#13#10 +                           //
    '    [Simple]'#13#10 +                                      //  60
    '    Destructor Destroy;'#13#10 +                           //
    '    [Simple]'#13#10 +                                      //
    '    Procedure Add;'#13#10 +                                //
    '  Public'#13#10 +                                          //
    '    [Simple]'#13#10 +                                      //  65
    '    Function Hello : String;'#13#10 +                      //
    '  //Published // Not permitted'#13#10 +                    //
    '    [Simple]'#13#10 +                                      //
    '    Property Qwerty : Integer Read FInt;'#13#10 +          //  69
    '    //Class Operator Implicit(a, b : Integer) : Integer;'#13#10 +
    '  End;'#13#10 +                                            //
    ''#13#10 +                                                  //
    '  [Simple]'#13#10 +                                        //
    '  TMyClass = Class'#13#10 +                                //
    '  Strict Private'#13#10 +                                  //  75
    '    [Simple]'#13#10 +                                      //
    '    FInt : Integer;'#13#10 +                               //
    '    Const'#13#10 +                                         //
    '    [Simple] i = 10;'#13#10 +                              //
    '    Var'#13#10 +                                           //  80
    '    [Simple] j : Integer;'#13#10 +                         //
    '    Type'#13#10 +                                          //
    '    [Simple] T = (qFirst, qLast);'#13#10 +                 //
    '    Class Var'#13#10 +                                     //
    '    [Simple] q : String;'#13#10 +                          //  85
    '  Protected'#13#10 +                                       //
    '  Public'#13#10 +                                          //
    '    [Simple]'#13#10 +                                      //
    '    Procedure Add;'#13#10 +                                //
    '  Published'#13#10 +                                       //  90
    '  End;'#13#10 +                                            //
    ''#13#10 +                                                  //
    '  [Simple]'#13#10 +                                        //
    '  TMyInterface = Interface'#13#10 +                        //
    '  //: @note Private'#13#10 +                               //  95
    '    //FInt : Integer;'#13#10 +                             //
    '    Function GetHello : Boolean;'#13#10 +                  //
    '    Procedure Add;'#13#10 +                                //
    '    Property Hello : Boolean Read GetHello;'#13#10 +       //
    '  End;',                                                   // 100
    'Var'#13#10 +                                               // 104
    '  [Simple]'#13#10 +                                        // 105
    '  iHello : INteger;'#13#10 +                               //
    ''#13#10 +                                                  //
    '[Custom]'#13#10 +                                          //
    'Class Operator TMyRecord.Add(a, b : TMyRecord) : TMyRecord; Begin End;'#13#10 +
    ''#13#10 +                                                  // 110
    '[Custom]'#13#10 +                                          //
    'Constructor TMyRecord.Create(i : Integer); Begin ENd;'#13#10 +
    ''#13#10 +                                                  //
    '[Custom]'#13#10 +                                          //
    'Procedure TMyRecord.Add; Begin End;'#13#10 +               // 115
    ''#13#10 +                                                  //
    '[Custom]'#13#10 +                                          //
    'Constructor TMyObject.Create; Begin End;'#13#10 +          //
    ''#13#10 +                                                  //
    '[Custom]'#13#10 +                                          //
    'Destructor TMyObject.Destroy; Begin End;'#13#10 +          //
    ''#13#10 +                                                  //
    '[Custom]'#13#10 +                                          //
    'Procedure TMyObject.Add; Begin End;'#13#10 +               //
    ''#13#10 +                                                  //
    '[Custom]'#13#10 +                                          //
    'Function TMyObject.Hello : String; Begin End;'#13#10 +     //
    ''#13#10 +                                                  //
    '[Custom]'#13#10 +                                          //
    'Procedure TMyClass.Add; Begin End;',                       //
    [ttErrors, ttWarnings],
    []
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesInterface;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [Custom(MyInterface, 1)]'#13#10 +
    '  TMyInterface = Interface'#13#10 +
    '    [GetterMethod(1), Custom()]'#13#10 +
    '    Function GetSomething : Boolean;'#13#10 +
    '    [Custom1(MyProc, 1, 2, 3, x, y, z)]'#13#10 +
    '    Property Something : Boolean Read GetSomething;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyInterface|TMyInterface = Interface|scPublic',
      'Types\TMyInterface\Methods\GetSomething|Function GetSomething : Boolean|scPublic',
      'Types\TMyInterface\Properties\Something|Property Something : Boolean Read GetSomething|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesMultiFunction;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    [Custom1, Custom2(MyAergument)]'#13#10 +
    '    Function IsReady : Boolean;'#13#10 +
    '  End;',
    'Function TMyClass.IsReady : Boolean;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Methods\IsReady|Function IsReady : Boolean|scPublished',
      'Implemented Methods\TMyClass\IsReady|Function IsReady : Boolean|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesMultiOnTypeWithComment;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  (** This is a comment. **)'#13#10+
    '  [Custom(''Hello'')]'#13#10 +
    '  [Custom1(''Hello'')]'#13#10 +
    '  [Custom2(''Hello'')]'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    [Custom1, Custom2(MyArgument)]'#13#10 +
    '    [Custom4(MyArgument)]'#13#10 +
    '    FField : Boolean;'#13#10 +
    '    [Custom2(), Custom3, Custom4(i, x, y, z)]'#13#10 +
    '    [Custom5, Custom7(x, y, z)]'#13#10 +
    '    Procedure MyProc( i : Integer);'#13#10 +
    '  End;',
    '',
    [ttErrors],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FField|FField : Boolean|scPublic',
      'Types\TMyRecord\Methods\MyProc|Procedure MyProc(i : Integer)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesMultiPerFuncton;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [Custom(''Hello'')]'#13#10 +
    '  [Custom1(''Hello'')]'#13#10 +
    '  [Custom2(''Hello'')]'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    [Custom1, Custom2(MyArgument)]'#13#10 +
    '    [Custom4(MyArgument)]'#13#10 +
    '    FField : Boolean;'#13#10 +
    '    [Custom2(), Custom3, Custom4(i, x, y, z)]'#13#10 +
    '    [Custom5, Custom7(x, y, z)]'#13#10 +
    '    Procedure MyProc( i : Integer);'#13#10 +
    '  End;',
    '',
    [ttErrors],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FField|FField : Boolean|scPublic',
      'Types\TMyRecord\Methods\MyProc|Procedure MyProc(i : Integer)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesMultiPerLine;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [Custom(''Hello'')][Custom1][Custom2(x, y)]'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    [Custom1, Custom2(MyArgument)]'#13#10 +
    '    FField : Boolean;'#13#10 +
    '    [Custom2(), Custom3, Custom4(i, x, y, z)]'#13#10 +
    '    Procedure MyProc( i : Integer);'#13#10 +
    '  End;',
    '',
    [ttErrors],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FField|FField : Boolean|scPublic',
      'Types\TMyRecord\Methods\MyProc|Procedure MyProc(i : Integer)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesRecord;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [Custom(''Hello'')]'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '    [Custom1, Custom2(MyArgument)]'#13#10 +
    '    FField : Boolean;'#13#10 +
    '    [Custom2(), Custom3, Custom4(i, x, y, z)]'#13#10 +
    '    Procedure MyProc( i : Integer);'#13#10 +
    '  End;',
    '',
    [ttErrors],
    [
      'Types\TMyRecord|TMyRecord = Record|scPublic',
      'Types\TMyRecord\Fields\FField|FField : Boolean|scPublic',
      'Types\TMyRecord\Methods\MyProc|Procedure MyProc(i : Integer)|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesMultiFields;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    [Custom1]'#13#10 +
    '    [Custom2(MyArgument)]'#13#10 +
    '    FString : String;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Fields\FString|FString : String|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesSingleClass;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [CustomAttribute]'#13#10 +
    '  TMyClass = Class;',
    '',
    [ttErrors, ttWarnings],
    ['Types\TMyClass|TMyClass = Class|scPublic']
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesSingleMethod;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    [Custom]'#13#10 +
    '    Procedure DoSomething;'#13#10 +
    '  End;',
    'Procedure TMyClass.DoSomething;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Methods\DoSomething|Procedure DoSomething|scPublished',
      'Implemented Methods\TMyClass\DoSomething|Procedure DoSomething|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesSingleProperty;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  TMyClass = Class'#13#10 +
    '    [Custom1, Custom2(MyArgument)]'#13#10 +
    '    Property IsReady : Boolean;'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    [
      'Types\TMyClass|TMyClass = Class|scPublic',
      'Types\TMyClass\Properties\IsReady|Property IsReady : Boolean|scPublished'
    ]
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesSingleRecord;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  [Custom()]'#13#10 +
    '  TMyRecord = Record'#13#10 +
    '  End;',
    '',
    [ttErrors, ttWarnings],
    ['Types\TMyRecord|TMyRecord = Record|scPublic']
  );
End;

Procedure TestTPascalModule.TestRTTIAttributesSingleTypeConst;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Const'#13#10 +
    '  a = 10;'#13#10 +
    '  b = 20;'#13#10 +
    ''#13#10 +
    'Type'#13#10 +
    '  [Something(a + b)]'#13#10 +
    '  TSomeType = Record'#13#10 +
    '  End;'#13#10 +
    ''#13#10 +
    'Procedure DoSomething;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  rec : TSomeType;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  rec;'#13#10 +
    'End;'#13#10 +
    ''#13#10 +
    'Initialization'#13#10 +
    ' DoSomething;',
    [ttErrors, ttWarnings],
    [
      'Constants\a|a = 10|scPrivate',
      'Constants\b|b = 20|scPrivate',
      'Types\TSomeType|TSomeType = Record|scPrivate',
      'Implemented Methods\DoSomething|Procedure DoSomething|scPrivate',
      'Implemented Methods\DoSomething\Variables\rec|rec : TSomeType|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestSetConstructor;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := [1..2, 4..5, 6, 7];'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestSetElement;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := [1..2];'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestSetType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Set Of TEnum;'#13#10 +
    '  t02 = Set Of TEnums platform;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Set Of TEnum|scPrivate',
      'Types\t02|t02 = Set Of TEnums|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestSimpleExpression;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := + 10 + 1;'#13#10 +
    '  i := - 10 + 1;'#13#10 +
    '  i := - 10 - 1;'#13#10 +
    '  i := + 10 - 1;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

procedure TestTPascalModule.TestSimpleStatement;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  Designator;'#13#10 +
    '  Designator(1, 2, Hello, ''Qwerty'');'#13#10+
    '  Designator := 1 + 2 / Hello * $FF;'#13#10 +
    '  Inherited Create;'#13#10 +
    '  Goto MyLabel;'#13#10 +
    '  Designator := (Helli + 1 * 4 Shl 5);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestSimpleType;

Begin
  TestGrammarForErrors(
    TPascalModule,
   strUnit,
   '',
   'Type'#13#10 +
    '  a = 1..2;'#13#10 +
    '  b = (eOne, eTwo);'#13#10 +
    '  c = Byte;'#13#10 +
    '  d = Single;',
   [ttErrors, ttWarnings],
   [
     'Types\a|a = 1..2|scPrivate',
     'Types\b|b = (eOne, eTwo)|scPrivate',
     'Types\c|c = Byte|scPrivate',
     'Types\d|d = Single|scPrivate'
   ]
  );
End;

Procedure TestTPascalModule.TestStatement;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Label'#13#10 +
    '  labelID;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'LabelId: Hello;'#13#10 +
    '  SimpleStatement;'#13#10+
    '  If True Then'#13#10 +
    '    Exit;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Labels\labelID|labelID|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestStmtList;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Label'#13#10 +
    '  labelID;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'LabelId: Hello;'#13#10 +
    '  SimpleStatement;'#13#10+
    '  If True Then'#13#10 +
    '    Exit;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Labels\labelID|labelID|scLocal'
    ]
  );
End;

procedure TestTPascalModule.TestEmptyBeginEndBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Repeat'#13#10 +
    '    Write;'#13#10 +
    '  Until True;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    'End;',
    'WriteLN;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyCaseBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Case X Of'#13#10 +
    '    0: WriteLn;'#13#10 +
    '  Else'#13#10 +
    '    WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Case X Of'#13#10 +
    '    0: ;'#13#10 +
    '  Else'#13#10 +
    '    WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Case X Of'#13#10 +
    '    0: ;'#13#10 +
    '  Else'#13#10 +
    '    WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    '  WriteLn();', 
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  Case X Of'#13#10 +
    '    0: ;'#13#10 +
    '  Else'#13#10 +
    '    WriteLn();'#13#10 +
    '  End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );

  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Case X Of'#13#10 +
    '    0: WriteLn;'#13#10 +
    '  Else'#13#10 +
    '    WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Case X Of'#13#10 +
    '    0: WriteLn();'#13#10 +
    '  Else'#13#10 +
    ''#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Case X Of'#13#10 +
    '    0: WriteLn();'#13#10 +
    '  Else'#13#10 +
    ''#13#10 +
    '  End;'#13#10 +
    'End;',
    '  WriteLn();', 
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  Case X Of'#13#10 +
    '    0: WriteLn;'#13#10 +
    '  Else'#13#10 +
    ''#13#10 +
    '  End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyElseBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    '    WriteLn()'#13#10 +
    '  Else'#13#10 +
    '    WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    '    WriteLn()'#13#10 +
    '  Else'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    '    WriteLn()'#13#10 +
    '  Else'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  If True Then'#13#10 +
    '    WriteLn()'#13#10 +
    '  Else'#13#10,
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyExceptBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '    WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '  End;'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '  End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyFinalizationBlock;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Initialization'#13#10 +
    'Finalization'#13#10 +
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Initialization'#13#10 +
    'Finalization',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 2, 0
  );
End;

Procedure TestTPascalModule.TestEmptyFinallyBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Finally'#13#10 +
    '    WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Finally'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Finally'#13#10 +
    '  End;'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Finally'#13#10 +
    '  End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyForBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  For i := 0 To 10 Do'#13#10 +
    '  Write;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  For i := 0 To 10 Do'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  For i := 0 To 10 Do'#13#10 +
    'End;',
    'WriteLN;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  For i := 0 To 10 Do',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyInitializationBlock;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Initialization'#13#10 +
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Initialization'#13#10 +
    '',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyMethods;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Repeat'#13#10 +
    '    Write;'#13#10 +
    '  Until True;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    'End;',
    'WriteLN;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyRepeatBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Repeat'#13#10 +
    '    Write;'#13#10 +
    '  Until True;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Repeat'#13#10 +
    '  Until True;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Repeat'#13#10 +
    '  Until True;'#13#10 +
    'End;',
    'WriteLN;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  Repeat'#13#10 +
    '  Until True;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyThenBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    '    WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  If True Then',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestEmptyWhileBlocks;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  While True Do'#13#10 +
    '    Write;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  While True Do'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  While True Do'#13#10 +
    'End;',
    'WriteLN;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  While True Do',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestExceptionEating;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '    On E : EMyException Do'#13#10 +
    '      WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '    On E : Exception Do'#13#10 +
    '      WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '    On E : Exception Do'#13#10 +
    '      WriteLn();'#13#10 +
    '  End;'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  Try'#13#10 +
    '    WriteLn();'#13#10 +
    '  Except'#13#10 +
    '    On E : Exception Do'#13#10 +
    '      WriteLn();'#13#10 +
    '  End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestHardCodedIntegers;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
    );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(2);'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(2);'#13#10 +
    'End;',
    '  WriteLN();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  WriteLn(2);',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
End;

Procedure TestTPascalModule.TestHardCodedNumbers;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
    );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(1.0);'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(1.0);'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  WriteLn(1.0);',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
End;

Procedure TestTPascalModule.TestHardCodedStrings;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
    );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(''Hello'');'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(''Hello'');'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    '',
    '  WriteLn(''Hello'');',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
End;

Procedure TestTPascalModule.TestStringType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = String;'#13#10 +
    '  t02 = AnsiString;'#13#10 +
    '  t03 = WideString;'#13#10 +
    '  t04 = String[10];'#13#10 +
    '  t05 = String[1 + 2 * 3];',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = String|scPrivate',
      'Types\t02|t02 = AnsiString|scPrivate',
      'Types\t03|t03 = WideString|scPrivate',
      'Types\t04|t04 = String[10]|scPrivate',
      'Types\t05|t05 = String[1 + 2 * 3]|scPrivate'
    ]
  );
End;

procedure TestTPascalModule.TestLongMethodImplementations;

Var
  R: TBADIMetricRecord;

Begin
  R := TBADIOptions.BADIOptions.ModuleMetric[mmToxicity];
  R.FLimit := 10.0;
  TBADIOptions.BADIOptions.ModuleMetric[mmToxicity] := R;
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    '  WriteLn;'#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    ''#13#10#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    '  WriteLn;'#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    ''#13#10#13#10#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    '  WriteLn;'#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    ''#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10 +
    ''#13#10#13#10#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
  R.FLimit := 1.0;
  TBADIOptions.BADIOptions.ModuleMetric[mmToxicity] := R;
End;

Procedure TestTPascalModule.TestLongMethodParameterLists;

Var
  R: TBADIMetricRecord;

Begin
  R := TBADIOptions.BADIOptions.ModuleMetric[mmToxicity];
  R.FLimit := 10.0;
  TBADIOptions.BADIOptions.ModuleMetric[mmToxicity] := R;
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc(Const A, B, C, D, E, F, G : Integer);',
    'Procedure MyProc(Const A, B, C, D, E, F, G : Integer);'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc(Const A, B, C, D, E, F, G, H : Integer);',
    'Procedure MyProc(Const A, B, C, D, E, F, G, H : Integer);'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc(Const A, B, C, D, E, F, G, H : Integer);'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    'WriteLn();', 
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
  R.FLimit := 1.0;
  TBADIOptions.BADIOptions.ModuleMetric[mmToxicity] := R;
End;

Procedure TestTPascalModule.TestLongMethodVariableLists;

Var
  R: TBADIMetricRecord;

Begin
  R := TBADIOptions.BADIOptions.ModuleMetric[mmToxicity];
  R.FLimit := 10.0;
  TBADIOptions.BADIOptions.ModuleMetric[mmToxicity] := R;
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Var A, B, C, D, E, F, G : Integer;'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
    );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Var A, B, C, D, E, F, G, H : Integer;'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc();'#13#10 +
    'Var A, B, C, D, E, F, G, H : Integer;'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
    );
  R.FLimit := 1.0;
  TBADIOptions.BADIOptions.ModuleMetric[mmToxicity] := R;
End;

Procedure TestTPascalModule.TestMethodCyclometricComplexity;

Begin
  SetMetricLimit(mmToxicity, 10);
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True {Or False} Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    '  If True Or False Then'#13#10 +
    '    WriteLn();'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
//  TestGrammarForErrors(
//    TPascalModule,
//    strProgram,
//    '',
//    '  If True Or False Then'#13#10 +
//    '    WriteLn();'#13#10 +
//    '  If True Or False Then'#13#10 +
//    '    WriteLn();'#13#10 +
//    '  If True Or False Then'#13#10 +
//    '    WriteLn();'#13#10 +
//    '  If True Or False Then'#13#10 +
//    '    WriteLn();',
//    [ttErrors, ttWarnings, ttChecksAndMetrics],
//    [],
//    0, 0, 0, 0, 1
//  );
End;

Procedure TestTPascalModule.TestMethodToxicity;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc(Const A, B, C, D, E : Integer);',
    'Procedure MyProc(Const A, B, C, D, E : Integer);'#13#10 +
    'Var U, V, W, X, Y, Z : String;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    '    WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc(Const A, B, C, D, E : Integer);'#13#10 +
    'Var U, V, W, X, Y, Z : String;'#13#10 +
    'Begin'#13#10 +
    '  If True Then'#13#10 +
    '    WriteLn();'#13#10 +
    'End;',
    '  WriteLN();', 
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
End;

Procedure TestTPascalModule.TestMissingCONSTInParameters;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc(Const X : Integer);',
    'Procedure MyProc(Const X : Integer);'#13#10 +
    'Begin'#13#10 +
    '  WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc(X : Integer);',
    'Procedure MyProc(X : Integer);'#13#10 +
    'Begin'#13#10 +
    '  WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc(X : Integer);'#13#10 +
    'Begin'#13#10 +
    '  WriteLn();'#13#10 +
    'End;',
    '  WriteLN();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
  );
End;

Procedure TestTPascalModule.TestNestedIFDepth;

Begin
  SetMetricLimit(mmToxicity, 10);
  SetMetricLimit(mmCyclometricComplexity, 100);
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If A Then'#13#10 +
    '    If B Then'#13#10 +
    '      If C Then'#13#10 +
    '        If D THen'#13#10 +
    '          If E Then'#13#10 +
    '            WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 0
  );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc;',
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If A Then'#13#10 +
    '    If B Then'#13#10 +
    '      If C Then'#13#10 +
    '        If D THen'#13#10 +
    '          If E Then'#13#10 +
    '            IF F Then'#13#10 +
    '              WriteLn();'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc;'#13#10 +
    'Begin'#13#10 +
    '  If A Then'#13#10 +
    '    If B Then'#13#10 +
    '      If C Then'#13#10 +
    '        If D THen'#13#10 +
    '          If E Then'#13#10 +
    '            IF F Then'#13#10 +
    '              WriteLn();'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 0, 1
  );
End;

Procedure TestTPascalModule.TestStructStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  begin'#13#10 +
    '    i := 1 + 2;'#13#10+
    '  end;'#13#10 +
    '  if i > 0 then'#13#10 +
    '    exit;'#13#10 +
    '  for i := 0 to 1 do'#13#10 +
    '    Dosomething;'#13#10 +
    '  with frogs do'#13#10 +
    '    croak;'#13#10 +
    '  sl := tstringlist.create;'#13#10 +
    '  try'#13#10 +
    '    sl.clear;'#13#10 +
    '  finally'#13#10 +
    '    sl.free;'#13#10 +
    '  end;'#13#10 +
    '  try'#13#10 +
    '    dosomething;'#13#10 +
    '  except'#13#10 +
    '    on e : exception do'#13#10 +
    '      break;'#13#10 +
    '  end;'#13#10 +
    '  raise exception.create(''Hello'');'#13#10 +
    '  asm'#13#10 +
    '    MOV DX,BX'#13#10 +
    '    ADD DX,BS'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestStrucType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Packed Array of Integer;'#13#10 +
    '  t02 = Set Of Integer;'#13#10 +
    '  t03 = File Of Word;'#13#10 +
    '  t04 = Record'#13#10 +
    '  End;'#13#10 +
    '  t05 = Array Of Byte Packed;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Packed Array of Integer|scPrivate',
      'Types\t02|t02 = Set Of Integer|scPrivate',
      'Types\t03|t03 = File of Word|scPrivate',
      'Types\t04|t04 = Record|scPrivate',
      'Types\t05|t05 = Packed Array of Byte|scPrivate'
    ]
  );
End;

procedure TestTPascalModule.TestUnsortedMethods;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc1();'#13#10 +
    'Procedure MyProc2();',
    'Procedure MyProc1();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;'#13#10 +
    'Procedure MyProc2();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
    );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc1();'#13#10 +
    'Procedure MyProc2();',
    'Procedure MyProc2();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;'#13#10 +
    'Procedure MyProc1();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc2();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;'#13#10 +
    'Procedure MyProc1();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    '  WriteLn();', 
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
End;

Procedure TestTPascalModule.TestUseOfGOTOStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
    );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Const s = ''Hello'';'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(s);'#13#10 +
    '  GOTO ERRHND;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc();'#13#10 +
    'Const s = ''Hello'';'#13#10 +
    'Begin'#13#10 +
    '  WriteLn(s);'#13#10 +
    '  GOTO ERRHND;'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
End;

Procedure TestTPascalModule.TestUseOfWITHStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Begin'#13#10 +
    '  WriteLn;'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    []
    );
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Procedure MyProc();',
    'Procedure MyProc();'#13#10 +
    'Const s = ''Hello'';'#13#10 + 
    'Begin'#13#10 +
    '  With X Do WriteLn(s);'#13#10 +
    'End;',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
  TestGrammarForErrors(
    TPascalModule,
    strProgram,
    'Procedure MyProc();'#13#10 +
    'Const s = ''Hello'';'#13#10 + 
    'Begin'#13#10 +
    '  With X Do WriteLn(s);'#13#10 +
    'End;',
    '  WriteLn();',
    [ttErrors, ttWarnings, ttChecks, ttMetrics],
    [],
    0, 0, 0, 0, 1, 0
    );
End;

Procedure TestTPascalModule.TestSubRangeType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = 1..2;'#13#10 +
    '  t02 = i..j;'#13#10 +
    '  t03 = 1 + 2..3 * 4;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = 1..2|scPrivate',
      'Types\t02|t02 = i..j|scPrivate',
      'Types\t03|t03 = 1 + 2..3 * 4|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestTerm;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  i := 10 * 1;'#13#10 +
    '  i := 10 / 1;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestThreadVarDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'ThreadVar'#13#10 +
    '  v1 : Integer;'#13#10 +
    '  v2 : String;',
    'ThreadVar'#13#10 +
    '  v3 : String;'#13#10 +
    '  v4, v5, v6 : Integer;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Thread Variables\v1|v1 : Integer|scPublic',
      'Thread Variables\v2|v2 : String|scPublic',
      'Thread Variables\v3|v3 : String|scPrivate',
      'Thread Variables\v4|v4 : Integer|scPrivate',
      'Thread Variables\v5|v5 : Integer|scPrivate',
      'Thread Variables\v6|v6 : Integer|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestThreadVarSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'ThreadVar'#13#10 +
    '  v1 : Integer;'#13#10 +
    '  v2 : String;',
    'ThreadVar'#13#10 +
    '  v3 : String;'#13#10 +
    '  v4, v5, v6 : Integer;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Thread Variables\v1|v1 : Integer|scPublic',
      'Thread Variables\v2|v2 : String|scPublic',
      'Thread Variables\v3|v3 : String|scPrivate',
      'Thread Variables\v4|v4 : Integer|scPrivate',
      'Thread Variables\v5|v5 : Integer|scPrivate',
      'Thread Variables\v6|v6 : Integer|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestTryExceptAndFinallyStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  sl := tstringlist.create;'#13#10 +
    '  try'#13#10 +
    '    sl.clear;'#13#10 +
    '  finally'#13#10 +
    '    sl.free;'#13#10 +
    '  end;'#13#10 +
    '  '#13#10 +
    '  try'#13#10 +
    '    sl.clear;'#13#10 +
    '  except'#13#10 +
    '    on e : exception do'#13#10 +
    '      exit;'#13#10 +
    '  end;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

Procedure TestTPascalModule.TestTypedConstant;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Const'#13#10 +
    '  i : integer = 1 * 2 + 3 /4;',
    'Const'#13#10 +
    '  j : Array[1..2] Of String = (''one'', ''two'');'#13#10 +
    ''#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Const'#13#10 +
    '  k : Array[1..2] of TRec = ('#13#10 +
    '    (Name: ''Hello''; Value : 1),'#13#10 +
    '    (Name: ''Hello''; Value : 1)'#13#10 +
    '  );'#13#10 +
    ''#13#10 +
    'Begin;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Constants\i|i : Integer = 1 * 2 + 3 / 4|scPublic',
      'Constants\j|j : Array[1..2] Of String = (''one'', ''two'')|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Constants\k|k : Array[1..2] of TRec = ((Name : ''Hello''; Value : 1), (Name : ''Hello''; Value : 1))|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestTypeDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  t = type Integer platform;'#13#10 +
    '  u = Class;',
    'Type'#13#10 +
    '  t1 = Integer;'#13#10 +
    '  u2 = type Class;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Type'#13#10 +
    '  t = type Integer;'#13#10 +
    '  u = Class;'#13#10 +
    ''#13#10 +
    'Begin;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\t|t = type Integer|scPublic',
      'Types\u|u = Class|scPublic',
      'Types\t1|t1 = Integer|scPrivate',
      'Types\u2|u2 = type Class|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Types\t|t = type Integer|scLocal',
      'Implemented Methods\Hello\Types\u|u = Class|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestTypeSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Type'#13#10 +
    '  t = Integer;'#13#10 +
    '  u = Class;',
    'Type'#13#10 +
    '  t1 = Integer;'#13#10 +
    '  u2 = Class;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Type'#13#10 +
    '  t = Integer;'#13#10 +
    '  u = Class;'#13#10 +
    ''#13#10 +
    'Begin;'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Types\t|t = Integer|scPublic',
      'Types\u|u = Class|scPublic',
      'Types\t1|t1 = Integer|scPrivate',
      'Types\u2|u2 = Class|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Types\t|t = Integer|scLocal',
      'Implemented Methods\Hello\Types\u|u = Class|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestUsesClause;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Uses'#13#10 +
    '  SysUtils, Windows;',
    'Uses'#13#10 +
    '  Classes;',
    [ttErrors, ttWarnings],
    [
      'Uses\Interface\SysUtils|SysUtils|scPublic',
      'Uses\Interface\Windows|Windows|scPublic',
      'Uses\Implementation\Classes|Classes|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestVarDecl;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Var'#13#10 +
    '  v1 : Integer;'#13#10 +
    '  v2 : String;',
    'Var'#13#10 +
    '  v3 : String;'#13#10 +
    '  v4, v5, v6 : Integer;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  v13 : String;'#13#10 +
    '  v14, v25, v36 : Integer;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Variables\v1|v1 : Integer|scPublic',
      'Variables\v2|v2 : String|scPublic',
      'Variables\v3|v3 : String|scPrivate',
      'Variables\v4|v4 : Integer|scPrivate',
      'Variables\v5|v5 : Integer|scPrivate',
      'Variables\v6|v6 : Integer|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Variables\v13|v13 : String|scLocal',
      'Implemented Methods\Hello\Variables\v14|v14 : Integer|scLocal',
      'Implemented Methods\Hello\Variables\v25|v25 : Integer|scLocal',
      'Implemented Methods\Hello\Variables\v36|v36 : Integer|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestVariantSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Record'#13#10 +
    '    FField1 : Integer;'#13#10 +
    '    FField2 : String;'#13#10 +
    '  End;'#13#10 +
    '  THInfo = Record'#13#10 +
    '    dblBearing : Double;'#13#10 +
    '    Case THInfoType Of'#13#10 +
    '      itSetout  : (dblEasting, dblNorthing  : Double);'#13#10 +
    '      itMeasure, itCompare : (dblChainage : Double;'#13#10 +
    '        Case THInfoType Of'#13#10 +
    '          itMeasure: (dblOffset : Double);'#13#10 +
    '          itCompare: (dblDistance : Double);'#13#10 +
    '    );'#13#10 +
    '  End;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Record|scPrivate',
      'Types\t01\Fields\FField1|FField1 : Integer|scPublic',
      'Types\t01\Fields\FField2|FField2 : String|scPublic',
      'Types\THInfo|THInfo = Record|scPrivate',
      'Types\THInfo\Fields\dblEasting|dblEasting : Double|scPublic',
      'Types\THInfo\Fields\dblNorthing|dblNorthing : Double|scPublic',
      'Types\THInfo\Fields\dblChainage|dblChainage : Double|scPublic',
      'Types\THInfo\Fields\dblOffset|dblOffset : Double|scPublic',
      'Types\THInfo\Fields\dblDistance|dblDistance : Double|scPublic'
    ]
  );
End;

Procedure TestTPascalModule.TestVariantType;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Type'#13#10 +
    '  t01 = Variant;'#13#10 +
    '  t02 = OLEVariant;',
    [ttErrors, ttWarnings],
    [
      'Types\t01|t01 = Variant|scPrivate',
      'Types\t02|t02 = OLEVariant|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestVarSection;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    'Var'#13#10 +
    '  v1 : Integer;'#13#10 +
    '  v2 : String;',
    'Var'#13#10 +
    '  v3 : String;'#13#10 +
    '  v4, v5, v6 : Integer;'#13#10 +
    ''#13#10 +
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Var'#13#10 +
    '  v7, v8 : Byte;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Variables\v1|v1 : Integer|scPublic',
      'Variables\v2|v2 : String|scPublic',
      'Variables\v3|v3 : String|scPrivate',
      'Variables\v4|v4 : Integer|scPrivate',
      'Variables\v5|v5 : Integer|scPrivate',
      'Variables\v6|v6 : Integer|scPrivate',
      'Implemented Methods\Hello|Procedure Hello|scPrivate',
      'Implemented Methods\Hello\Variables\v7|v7 : Byte|scLocal',
      'Implemented Methods\Hello\Variables\v8|v8 : Byte|scLocal'
    ]
  );
End;

Procedure TestTPascalModule.TestWhileStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  while i < 0 Do'#13#10 +
    '    Inc(i);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    [
      'Implemented Methods\Hello|Procedure Hello|scPrivate'
    ]
  );
End;

Procedure TestTPascalModule.TestWithStmt;

Begin
  TestGrammarForErrors(
    TPascalModule,
    strUnit,
    '',
    'Procedure Hello;'#13#10 +
    ''#13#10 +
    'Begin'#13#10 +
    '  with objDGH Do'#13#10 +
    '    Inc(i);'#13#10 +
    '  with objDGH, dghObject Do'#13#10 +
    '    Inc(i);'#13#10 +
    'End;',
    [ttErrors, ttWarnings],
    ['Implemented Methods\Hello|Procedure Hello|scPrivate']
  );
End;

initialization
  TBADIOptions.BADIOptions.Options := TBADIOptions.BADIOptions.Options - [doShowChildCountInTitles];
  // Register any test cases with the test runner
  RegisterTest('PascalModule Tests', TestTPascalModule.Suite);
end.
