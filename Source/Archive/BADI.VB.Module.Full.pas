(**

  This module contains code to parser VB/VBA code (and perhaps will be extended
  to parser VB.NET code later).

  @Version    1.0
  @Date       31 Aug 2011
  @Author     David Hoyle

**)
Unit BADI.VB.Module.Full;

Interface

Uses
  SysUtils,
  Classes,
  Contnrs,
  //Controls,
  BADI.Base.Module,
  BADI.Comment,
  BADI.Generic.Parameter,
  BADI.Generic.MethodDecl,
  BADI.Types,
  BADI.Constants,
  BADI.Generic.Constant,
  BADI.Generic.Variable,
  BADI.Generic.PropertyDecl,
  BADI.Generic.TypeDecl, BADI.ElementContainer, BADI.Generic.FunctionDecl, BADI.TokenInfo;

{$INCLUDE CompilerDefinitions.Inc}

Type
  (** An imlpementation for visual basic comments. **)
  TVBComment = Class(TComment)
  Public
    Class Function CreateComment(const strComment: String; iLine,
      iCol: Integer): TComment; Override;
  End;

  (** A class to present parameters in methods and properties. **)
  TVBParameter = Class(TGenericParameter)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FOptional : Boolean;
    FParamArray: Boolean;
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    (**
      This property determines of the parameter is optional or not.
      @precon  None.
      @postcon Determines of the parameter is optional or not.
      @return  a Boolean
    **)
    Property Optional : Boolean Read FOptional Write FOptional;
    (**
      This property determines of the parameter is a parameter array.
      @precon  None.
      @postcon Determines of the parameter is a parameter array.
      @return  a Boolean
    **)
    Property ParamArray : Boolean Read FParamArray Write FParamArray;
  End;

  (** An interface to define exception handling capabilties which are
      implemented by methods and properties. **)
  IExceptionHandling = Interface
    Function GetHasPush : Boolean;
    Procedure SetHasPush(boolValue : Boolean);
    Function GetHasPop : Boolean;
    Procedure SetHasPop(boolValue : Boolean);
    Function GetPushName : String;
    Procedure SetPushName(strValue : String);
    Function GetPushParams : TStringList;
    Function GetHasErrorHnd : Boolean;
    Procedure SetHasErrorHnd(boolValue : Boolean);
    Function GetHasExit : Boolean;
    Procedure SetHasExit(boolValue : Boolean);
    Function GetExitLine : Integer;
    Procedure SetExitLine(iLine : Integer);
    Function GetExitCol : Integer;
    Procedure SetExitCol(iCol : Integer);
    Function GetMethodName : String;
    (**
      This property determine if the method has a Exception.Push handler.
      @precon  None.
      @postcon Determine if the method has a Exception.Push handler.
      @return  a Boolean
    **)
    Property HasPush : Boolean Read GetHasPush Write SetHasPush;
    (**
      This property determine if the method has a Exception.Pop handler.
      @precon  None.
      @postcon Determine if the method has a Exception.Pop handler.
      @return  a Boolean
    **)
    Property HasPop  : Boolean Read GetHasPop  Write SetHasPop;
    (**
      This property returns the name of the pushed method.
      @precon  None.
      @postcon Returns the name of the pushed method.
      @return  a String
    **)
    Property PushName : String Read GetPushName Write SetPushName;
    (**
      This property returns a string list of the methods parameters.
      @precon  None.
      @postcon Returns a string list of the methods parameters.
      @return  a TStringList
    **)
    Property PushParams : TStringList Read GetPushParams;
    (**
      This property determines if the method has an error handler.
      @precon  None.
      @postcon Determines if the method has an error handler.
      @return  a Boolean
    **)
    Property HasErrorHnd : Boolean Read GetHasErrorHnd Write SetHasErrorHnd;
    (**
      This property determines if the method has an exit statement.
      @precon  None.
      @postcon Determines if the method has an exit statement.
      @return  a Boolean
    **)
    Property HasExit : Boolean Read GetHasExit Write SetHasExit;
    (**
      This property determines the method line of the exit statement.
      @precon  None.
      @postcon Determines the method line of the exit statement.
      @return  a Integer
    **)
    Property ExitLine : Integer Read GetExitLine Write SetExitLine;
    (**
      This property determines the method column of the exit statement.
      @precon  None.
      @postcon Determines the method column of the exit statement.
      @return  a Integer
    **)
    Property ExitCol : Integer Read GetExitCol Write SetExitCol;
    (**
      This property returns the name of the method with the ExceptionHandling.
      @precon  None.
      @postcon R
      @return  a String
    **)
    Property MethodName : String Read GetMethodName;
  End;

  (** A class to handle exception handling information for method and
      properties. **)
  TExceptionHandling = Class(TInterfacedObject, IExceptionHandling)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FHasErrorHnd : Boolean;
    FHasExit     : Boolean;
    FHasPop      : Boolean;
    FHasPush     : Boolean;
    FPushName    : String;
    FPushParams  : TStringList;
    FExitLine    : Integer;
    FExitCol     : Integer;
    FMethodName  : String;
  Public
    Constructor Create(strMethodName : String);
    Destructor Destroy; Override;
    function GetHasErrorHnd: Boolean;
    function GetHasExit: Boolean;
    function GetHasPop: Boolean;
    function GetHasPush: Boolean;
    function GetPushName: string;
    function GetPushParams: TStringList;
    Function GetExitLine : Integer;
    Function GetExitCol : Integer;
    procedure SetHasErrorHnd(boolValue: Boolean);
    procedure SetHasExit(boolValue: Boolean);
    procedure SetHasPop(boolValue: Boolean);
    procedure SetHasPush(boolValue: Boolean);
    procedure SetPushName(strValue: string);
    Procedure SetExitLine(iLine : Integer);
    Procedure SetExitCol(iCol : Integer);
    Function GetMethodName : String;
  End;

  (** A class to represent method (SUB & FUNCTION) in visual basic. **)
  TVBMethod = Class(TGenericMethodDecl, IExceptionHandling)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FPushParams: TStringList;
    FExceptionHandling : IExceptionHandling;
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Constructor Create(MethodType : TMethodType; const strName : String;
      AScope : TScope; iLine, iCol : Integer); Override;
    Destructor Destroy; Override;
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    (**
      This property implements the IExceptionHandling interface.
      @precon  None.
      @postcon Implements the IExceptionHandling interface.
      @return  an IExceptionHandling
    **)
    Property ExceptionHandling : IExceptionHandling Read FExceptionHandling
      Implements IExceptionHandling;
  End;

  (** A class to represent constants in visual basic. **)
  TVBConstant = Class(TGenericConstant)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A type to define at upper and lower limits of an array. **)
  TArrayDimensions = Array[1..2] Of String;

  (** A class to represent variables in visual basic. **)
  TVBVar = Class(TGenericVariable)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FDimensions, T : Array Of TArrayDimensions;
    FWithEvents : Boolean;
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Function GetDimensions : Integer;
  Public
    Constructor Create(const strName : String; AScope : TScope; iLine,
      iColumn : Integer; AImageIndex : TBADIImageIndex; AComment : TComment); Override;
    Destructor Destroy; Override;
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    Procedure AddDimension(strLow, strHigh : String);
    (**
      This property returns the number of dimensions in the array variable.
      @precon  None.
      @postcon Returns the number of dimensions in the array variable.
      @return  an Integer
    **)
    Property Dimensions : Integer Read GetDimensions;
    (**
      This property determines if the variable is an event interface.
      @precon  None.
      @postcon Determines if the variable is an event interface.
      @return  a Boolean
    **)
    Property WithEvents : Boolean Read FWithEvents Write FWithEvents;
  End;

  (** A type to define the type of properties supported by visual basic. **)
  TPropertyType = (ptUnknown, ptGet, ptLet, ptSet);

  (** A class to represent properties in visual basic. **)
  TVBProperty = Class(TGenericProperty, IExceptionHandling)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FPropertyType: TPropertyType;
    FExceptionHandling : IExceptionHandling;
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Function GetName : String; Override;
  Public
    Constructor Create(APropertyType : TPropertyType; strName : String;
      AScope : TScope; iLine, iCol : Integer; iImageIndex : TBADIImageIndex;
      AComment : TComment); Reintroduce; Virtual;
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    Procedure CheckDocumentation(var boolCascade : Boolean); Override;
    (**
      This property gets and sets the type of visula basic property.
      @precon  None.
      @postcon Gets and sets the type of visula basic property.
      @return  a TPropertyType
    **)
    Property PropertyType : TPropertyType Read FPropertyType Write FPropertyType;
    (**
      This property implements the IExceptionHandling interface.
      @precon  None.
      @postcon Implements the IExceptionHandling interface.
      @return  an IExceptionHandling
    **)
    Property ExceptionHandling : IExceptionHandling Read FExceptionHandling
      Implements IExceptionHandling;
  End;

  (** A class to represent records in visual basic. **)
  TVBRecordDecl = Class(TGenericTypeDecl)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A class to represent types in visual basic. **)
  TVBTypeDecl = Class(TGenericTypeDecl)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** An enumerate to represent the different module types in visual basic. **)
  TModuleType = (mtModule, mtForm, mtClass);

  (** A class to represent attributes **)
  TVBAttribute = Class(TElementContainer)
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Function GetName : String; Override;
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A class to represent options. **)
  TVBOption = Class(TElementContainer)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A class to represent versions **)
  TVBVersion = Class(TElementContainer)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A class to represent Enumerate Declarations **)
  TVBEnumerateDecl = Class(TGenericTypeDecl)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A class to represent Field Values **)
  TVBField = Class(TVBVar)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    Procedure CheckDocumentation(var boolCascade : Boolean); Override;
  End;

  (** A class to represent VB Enumerate Value  **)
  TVBEnumIdent = Class(TElementContainer)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A class to represent an Implements item. **)
  TImplementedItem = Class(TElementContainer)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A set type to define a set of Browse and Doc It Token Types **)
  TBADITokenTypes = Set Of TBADITokenType;

  (**

    This is the main class for dealing with object pascal units and program
    source files. It creates and manages instances of the other classes as
    needed.

  **)
  TVBModule = Class(TBaseLanguageModule)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FSource: String;
    FModuleType : TModuleType;
    FUnResolvedSymbols : TStringList;
    FEventHandlerPatterns: TStringList;
    Procedure TokenizeStream;
    { Grammer Parsers }
    Procedure Goal;
    Function  Version : Boolean;
    Function  VBBegin(C : TElementContainer) : Boolean;
    Function  Attributes : Boolean;
    Function  Attribute(C : TElementContainer) : Boolean;
    Function  Options : Boolean;
    Function  Implements : Boolean;
    Function Declarations : Boolean;
    Procedure InterfaceSection;
    Procedure ImplementationSection;
    Function  Consts(AScope : TScope; C : TComment) : Boolean;
    Function  Dims(AScope : TScope; C : TComment) : Boolean;
    Function  Subs(AScope : TScope; C : TComment; boolStatic : Boolean;
      DeclareLabel : TLabelContainer) : Boolean;
    Function  Functions(AScope : TScope; C : TComment; boolStatic : Boolean;
      DeclareLabel : TLabelContainer) : Boolean;
    Function  Declares(AScope : TScope; C: TComment) : Boolean;
    Function  Props(AScope : TScope; C : TComment; boolStatic : Boolean) : Boolean;
    Function  Records(AScope : TScope; C : TComment) : Boolean;
    Function  Enum(AScope : TScope; C: TComment) : Boolean;
    Procedure Parameters(Container : TElementContainer);
    Procedure MethodDecl(M : TGenericMethodDecl; C : TComment);
    Function Vars(AScope : TScope; C : TComment) : Boolean;
    Function VarDecl(AScope : TScope; C : TComment) : Boolean;
    Procedure ArraySizeDecl(Variable: TVBVar);
    Function FloatingPointLiteral(V : TVBVersion) : Boolean;
    Procedure Block;
    Function Statements : Boolean;
    Function Statement : Boolean;
    Function LabelDeclarationStatement : Boolean;
    Function LocalDeclarationStatement : Boolean;
    Function WithStatement : Boolean;
    Function EventStatement : Boolean;
    Function AssignmentStatement : Boolean;
    Function InvocationStatement : Boolean;
    Function ConditionalStatement : Boolean;
    Function LoopStatement : Boolean;
    Function ErrorHandlingStatement : Boolean;
    Function BranchStatement : Boolean;
    Function ArrayHandlingStatement : Boolean;


    Function QualifiedIdentifier(Container : TElementContainer;
      TokenTypes : TBADITokenTypes) : String;
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Procedure ProcessCompilerDirective(var iSkip : Integer); Override;
    procedure TidyUpEmptyElements;
    Function GetComment(
      CommentPosition : TCommentPosition = cpBeforeCurrentToken) : TComment;
      Override;
    Procedure NextNonCommentToken; Override;
    Procedure CheckExceptionHandling;
    Procedure ResolvedForwardReferences;
    Procedure CheckForInterfaceScope(var AScope : TScope);
    Procedure CheckForImplementationScope(var AScope : TScope);
    procedure CheckMethodEnd(strEndKeyWord : String);
    procedure ProcessVar(Variable: TVBVar);
    procedure CheckElementExceptionHandling(M: TGenericFunction;
      ExceptionHandler : IExceptionHandling);
    procedure PatchAndCheckReferences;
  Public
    Constructor CreateParser(const Source, strFileName : String;
      IsModified : Boolean; ModuleOptions : TModuleOptions); Override;
    Destructor Destroy; Override;
    Function ReservedWords : TKeyWords; Override;
    Function Directives : TKeyWords; Override;
    Function ReferenceSymbol(AToken : TTokenInfo) : Boolean; Override;
    { Properties }
  End;

ResourceString
  (** A label for versions. **)
  strVersionLabel = 'Version';
  (** A label for attributes **)
  strAttributesLabel = 'Attributes';
  (** A label for options. **)
  strOptionsLabel = 'Options';
  (** A label for implements. **)
  strImplementsLabel = 'Implements';
  (** A label for declared functions and procedures. **)
  strDeclaresLabel = 'Declarations';
  (** A label for implemented properties. **)
  strImplementedPropertiesLabel = 'Implemented Properties';

Implementation

Uses
  Windows, DGHLibrary, BADI.Functions, BADI.Options, BADI.ResourceStrings;

Const
  (** A set of characters for alpha characaters **)
  strTokenChars : Set Of AnsiChar = ['_', 'a'..'z', 'A'..'Z'];
  (** A set of numbers **)
  strNumbers : Set Of AnsiChar = ['&', '0'..'9'];
  (** A set of characters for general symbols **)
  strSymbols : Set Of AnsiChar = ['&', '(', ')', '*', '+', '%', '$', '&',
    ',', '-', '.', '/', ':', ';', '<', '=', '>', '@', '[', ']', '^', '{', '}'];
  (** A set of characters for quotes **)
  strQuote : Set Of AnsiChar = ['"'];
  (**
    A sorted list of keywords. Used for identifying tokens as keyword.

    This key words nil and string have been disables as there are used like
    identifiers and as types.

  **)
  strReservedWords : Array[1..138] Of String = (
    'addhandler', 'addressof', 'alias', 'and', 'andalso', 'ansi', 'as', 'assembly',
    'auto', 'base', 'boolean', 'byref', 'byte', 'byval', 'call', 'case', 'catch',
    'cbool', 'cbyte', 'cchar', 'cdate', 'cdbl', 'cdec', 'char', 'cint', 'class',
    'clng', 'cobj', 'compare', 'const', 'cshort', 'csng', 'cstr', 'ctype', 'date',
    'decimal', 'declare', {'default', }'delegate', 'dim', 'directcast', 'do', 'double',
    'each', 'else', 'elseif', 'end', 'enum', 'erase', 'error', 'event', 'exit',
    'explicit', {'false', }'finally', 'for', 'friend', 'function', 'get', 'gettype',
    'gosub', 'goto', 'handles', 'if', 'implements', 'imports', 'in', 'inherits',
    'integer', 'interface', 'is', 'let', 'lib', 'like', 'long', 'loop', 'me', 'mod',
    'module', 'mustinherit', 'mustoverride', 'mybase', 'myclass', 'namespace', 'new',
    'next', 'not', 'nothing', 'notinheritable', 'notoverridable', 'object', 'on',
    'option', 'optional', 'or', 'orelse', 'overloads', 'overridable', 'overrides',
    'paramarray', 'preserve', 'private', 'property', 'protected', 'public', 'raiseevent',
    'readonly', 'redim', 'rem', 'removehandler', 'resume', 'return', 'select', 'set',
    'shadows', 'shared', 'short', 'single', 'static', 'step', 'stop', 'string',
    'structure', 'sub', 'synclock', 'then', 'throw', 'to', {'true', }'try', 'type',
    'typeof', 'unicode', 'until', 'variant', 'when', 'while', 'with', 'withevents',
    'writeonly', 'xor'
  );

  (** A list of directives. **)
  strDirectives : Array[1..3] Of String = (
    'default', 'false', 'true'
  );

  (** A set of token to be searched for after an error. **)
  strSeekTokens : Array[1..6] Of String = (
    'const', 'dim', 'function', 'private', 'public', 'sub'
  );

  (** A constant array of method names. **)
  strMethodType : Array[Low(TMethodType)..High(TMethodType)] Of String = (
    '', '', 'Sub', 'Function', ''
  );
  (** A constant array to define the property types. **)
  strPropertyType : Array[Low(TPropertyType)..High(TPropertyType)] Of String = (
    'Unknown', 'Get', 'Let', 'Set');

ResourceString
  (** Exception message when an value is expected but something else is found. **)
  strValueExpected = 'Value expected but ''%s'' found at line %d column %d.';
  (** An exception messahe for when a line end token is expected. **)
  strLineEndExpected = 'Expected a line end token but ''%s'' found at line %d column %d.';
  (** A message prompt for returns on properties. **)
  strProperyRequiresReturn = 'Propery ''%s'' requires a return parameter.';
  (** A message prompt for parameters in properties. **)
  strProperyRequireParam = 'Propery ''%s'' requires at least 1 parameter.';
  (** A warning message for no push method. **)
  strExceptionPush = 'The method ''%s'' has no Exception.Push method.';
  (** A warning message for no push name. **)
  strExceptionPushName = 'The method ''%s'' has no Exception.Push name.';
  (** A warning message for no pop method. **)
  strExceptionPop = 'The method ''%s'' has no Exception.Pop method.';
  (** A warning message for no error handling. **)
  strErrorHandling = 'The method ''%s'' has no error handling.';
  (** A warning message for an exit statement and error handling. **)
  strExitStatement = 'The method ''%s'' has an Exit statement which may be i' +
    'n conflict with the error handling.';
  (** A warning message for missing push names. **)
  strExceptionPushNameIncorrect = 'The name passed to the Exception.Push me' +
  'thod (%s) is incorrect (''%s.%s'').';
  (** A warning message for missing push parameters. **)
  strExceptionPushParameter = 'The parameter ''%s'' in ''%s.%s'' does not ha' +
  've a corresponding parameter in the Exception.Push statement.';
  (** A warning message for push parameter out of order. **)
  strExceptionPushParamPos = 'The parameter ''%s'' in ''%s.%s'' is not in the ' +
    'the correct position (%d not %d) in the Exception.Push statement.';
  (** A warning message for push parameter count different. **)
  strExceptionPushParamCount = 'The function ''%s.%s'' has the wrong number of ' +
    'Exception.Push parameters (%d not %d).';
  (** A hint message for keyword GOTO found in the code. **)
  strKeywordGOTOFound = 'Keyword GOTO found in function ''%s'' at line %d co' +
  'lumn %d.';
  strStatementExpected = 'Statement expected but ''%s'' found at line %d col' +
  'umn %d.';

{ TVBComment }

(**

  This is a constructor for the TVBComment class.

  @precon  None.
  @postcon Parses a VB comment by simply stripping the single quotes from the
           text.

  @param   strComment as a String
  @param   iLine      as an Integer
  @param   iCol       as an Integer
  @return  a TComment

**)
class function TVBComment.CreateComment(const strComment: String; iLine,
  iCol: Integer): TComment;

Var
  sl : TStringList;
  iCommentLine : Integer;
  boolDocComment: Boolean;

  (**

    This function replaces the indexed character in the passed string with the
    new given character. This is a workaround for the immutable nature of
    TStringList items Strings.

    @precon  none.
    @postcon Replaces the indexed character in the passed string with the
             new given character.

    @param   strText     as a String
    @param   iIndex      as an Integer
    @param   chCharacter as a Char
    @return  a String

  **)
  Function ReplaceCharacter(strText : String; iIndex : Integer; chCharacter : Char) : String;

  Begin
    strText[iIndex] := chCharacter;
    Result := strText;
  End;

begin
  Result := Nil;
  boolDocComment := False;
  If Length(strComment) > 0 Then
    Begin
      sl := TStringList.Create;
      Try
        sl.Text := strComment;
        For iCommentLine := sl.Count - 1 DownTo 0 Do
          Begin
            If sl[iCommentLine][1] = '''' Then
              sl[iCommentLine] := ReplaceCharacter(sl[iCommentLine], 1, #32);
            If Length(sl[iCommentLine]) > 1 Then
              If (IsInSet(sl[iCommentLine][2], [':', ''''])) Then
                Begin
                  boolDocComment := True;
                  sl[iCommentLine] := ReplaceCharacter(sl[iCommentLine], 2, #32);
                End Else
                  sl.Delete(iCommentLine);
          End;
        If boolDocComment Then
          Result := Create(sl.Text, iLine, iCol);
      Finally
        sl.Free;
      End;
    End;
end;

{ TExceptionHandling }

(**

  This is a constructor for the TExceptionHandling class.

  @precon  None.
  @postcon Initialises the push parameters string list.

  @param   strMethodName as a String

**)
constructor TExceptionHandling.Create(strMethodName : String);
begin
  Inherited Create;
  FMethodName := strMethodName;
  FPushParams := TStringList.Create;
end;

(**

  This is a destructor for the TExceptionHandling class.

  @precon  None.
  @postcon Frees the push parameters string list.

**)
destructor TExceptionHandling.Destroy;
begin
  FPushParams.Free;
  Inherited Destroy;
end;

(**

  This is a getter method for the ExitCol property.

  @precon  None.
  @postcon Returns the Exit Column number.

  @return  an Integer

**)
function TExceptionHandling.GetExitCol: Integer;
begin
  Result := FExitCol;
end;

(**

  This is a getter method for the ExitLine property.

  @precon  None.
  @postcon Returns the Exit Line number.

  @return  an Integer

**)
function TExceptionHandling.GetExitLine: Integer;
begin
  Result := FExitLine;
end;

(**

  This is a getter method for the HasErrorHnd property.

  @precon  None.
  @postcon Returns whether the method / property has an error handler.

  @return  a Boolean

**)
function TExceptionHandling.GetHasErrorHnd: Boolean;
begin
  Result := FHasErrorHnd;
end;

(**

  This is a getter method for the HasExit property.

  @precon  None.
  @postcon Returns whether the method / property has an exit statement.

  @return  a Boolean

**)
function TExceptionHandling.GetHasExit: Boolean;
begin
  Result := FHasExit;
end;

(**

  This is a getter method for the HasPop property.

  @precon  None.
  @postcon Returns whether the method / property has a pop statement.

  @return  a Boolean

**)
function TExceptionHandling.GetHasPop: Boolean;
begin
  Result := FHasPop;
end;

(**

  This is a getter method for the HasPush property.

  @precon  None.
  @postcon Returns whether the method / property has a push statement.

  @return  a Boolean

**)
function TExceptionHandling.GetHasPush: Boolean;
begin
  Result := FHasPush;
end;

(**

  This is a getter method for the MethodName property.

  @precon  None.
  @postcon Returns the name of the method.

  @return  a String

**)
function TExceptionHandling.GetMethodName: String;
begin
  Result := FMethodName;
end;

(**

  This is a getter method for the HasPush property.

  @precon  None.
  @postcon Returns whether the method / property has a push statement.

  @return  a String

**)
function TExceptionHandling.GetPushName: string;
begin
  Result := FPushName;
end;

(**

  This is a getter method for the PushParams property.

  @precon  None.
  @postcon Returns a string list of push parameters.

  @return  a TStringList

**)
function TExceptionHandling.GetPushParams: TStringList;
begin
  Result := FPushParams;
end;

(**

  This is a setter method for the ExitCol property.

  @precon  None.
  @postcon Sets the Exit Column Number.

  @param   iCol as an Integer

**)
procedure TExceptionHandling.SetExitCol(iCol: Integer);
begin
  FExitCol := iCol;
end;

(**

  This is a setter method for the ExitLine property.

  @precon  None.
  @postcon Sets the Exit Line Number.

  @param   iLine as an Integer

**)
procedure TExceptionHandling.SetExitLine(iLine: Integer);
begin
  FExitLine := iLine;
end;

(**

  This is a setter method for the HasErrorHnd property.

  @precon  None.
  @postcon Sets whether the method / property has an error handler.

  @param   boolValue as a Boolean

**)
procedure TExceptionHandling.SetHasErrorHnd(boolValue: Boolean);
begin
  FHasErrorHnd := boolValue;
end;

(**

  This is a setter method for the HasExit property.

  @precon  None.
  @postcon Sets whether the method / property has an exit statement.

  @param   boolValue as a Boolean

**)
procedure TExceptionHandling.SetHasExit(boolValue: Boolean);
begin
  FHasExit := boolValue;
end;

(**

  This is a setter method for the HasPop property.

  @precon  None.
  @postcon Sets whether the method / property has a pop statement.

  @param   boolValue as a Boolean

**)
procedure TExceptionHandling.SetHasPop(boolValue: Boolean);
begin
  FHasPop := boolValue;
End;

(**

  This is a setter method for the HasPush property.

  @precon  None.
  @postcon Sets whether the method / property has a push statement.

  @param   boolValue as a Boolean

**)
procedure TExceptionHandling.SetHasPush(boolValue: Boolean);
begin
  FHasPush := boolValue;
end;

(**

  This is a setter method for the PushName property.

  @precon  None.
  @postcon Sets the method / property push name.

  @param   strValue as a String

**)
procedure TExceptionHandling.SetPushName(strValue: string);
begin
  FPushName := strValue;
end;

{ TVBMethod }

(**

  This is a constructor for the TVBMethod class.

  @precon  None.
  @postcon Adds a string list for managing Pushed parameters.

  @param   MethodType as a TMethodType
  @param   strName    as a String
  @param   AScope     as a TScope
  @param   iLine      as an Integer
  @param   iCol       as an Integer

**)
constructor TVBMethod.Create(MethodType: TMethodType; const strName: String;
  AScope: TScope; iLine, iCol: Integer);
begin
  inherited;
  FPushParams := TStringList.Create;
  FExceptionHandling := TExceptionHandling.Create(strName);
end;

(**

  This is a destructor for the TVBMethod class.

  @precon  None.
  @postcon Frees the pushed parameters list.

**)
destructor TVBMethod.Destroy;
begin
  FPushParams.Free;
  inherited;
end;

(**

  This method outputs a string presentation of the method.

  @precon  None .
  @postcon Outputs a string presentation of the method .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBMethod.AsString(boolShowIdentifier, boolForDocumentation : Boolean): String;

Var
  i : Integer;

begin
  Result := strMethodType[MethodType] + #32;
  If boolShowIdentifier Then
    Result := Result + Identifier;
  If Ext <> '' Then
    Result := Result + Format(' Lib %s', [Ext]);
  If Alias <> '' Then
    Result := Result + Format(' Alias %s', [Alias]);
  If (Ext <> '') Or (Alias <> '') Then
    Result := Result + #32;
  Result := Result + '(';
  For i := 0 To ParameterCount - 1 Do
    Begin
      If i > 0 Then
        Result := Result + ',';
      If boolForDocumentation Then
        Result := Result + #13#10
      Else
        If i > 0 Then
          Result := Result + #32;
      If boolForDocumentation Then
        Result := Result + #32#32;
      Result := Result + Parameters[i].AsString(boolShowIdentifier,
        boolForDocumentation);
    End;
  If boolForDocumentation Then
    Result := Result + #13#10;
  Result := Result + ')';
  If (MethodType = mtFunction) And (ReturnType.ElementCount > 0) Then
    Result := Result + #32'As'#32 + ReturnType.AsString(False,
      boolForDocumentation);
end;

{ TVBConstant }

(**

  This method returns a string representation of the visual basic constant.

  @precon  None .
  @postcon Returns a string representation of the visual basic constant .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBConstant.AsString(boolShowIdentifier,
  boolForDocumentation : Boolean): String;
begin
  Result := BuildStringRepresentation(boolShowIdentifier, boolForDocumentation, '',
    TBADIOptions.BADIOptions.MaxDocOutputWidth);
End;

{ TVBVar }

(**

  This method adds an array dimension to the varaiable declaration.

  @precon  None .
  @postcon Adds an array dimension to the varaiable declaration .

  @param   strLow  as a String
  @param   strHigh as a String

**)
procedure TVBVar.AddDimension(strLow, strHigh : String);

Var
  i : Integer;

begin
  T := Nil;
  If FDimensions = Nil Then
    Begin
      SetLength(FDimensions, 1);
      FDimensions[0][1] := strLow;
      FDimensions[0][2] := strHigh;
    End Else
    Begin
      T := Copy(FDimensions, 1, Length(FDimensions));
      SetLength(FDimensions, Succ(Succ(High(FDimensions))));
      For i := Low(T) To High(T) Do
        FDimensions[i] := T[i];
      FDimensions[High(FDimensions)][1] := strLow;
      FDimensions[High(FDimensions)][2] := strHigh;
    End;
end;

(**

  This method returns a string representation of the visual basic variable.

  @precon  None .
  @postcon Returns a string representation of the visual basic variable .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBVar.AsString(boolShowIdentifier, boolForDocumentation : Boolean): String;

Var
  i: Integer;

begin
  Result := '';
  If boolShowIdentifier Then
    Result := Result + Identifier;
  If WithEvents Then
    Result := 'WithEvents' + #32 + Result;
  If Dimensions > 0 Then
    Begin
      Result := Result + '(';
      For i := 0 To Dimensions - 1 Do
        Begin
          If i > 0 Then
            Result := Result + ', ';
          If FDimensions[i][1] <> '' Then
            Result := Result + Format('%s To %s', [FDimensions[i][1],
              FDimensions[i][2]]);
        End;
      Result := Result + ')';
    End;
  If TokenCount > 0 Then
    Result := Result + #32'As'#32 + BuildStringRepresentation(False,
      boolForDocumentation, '', TBADIOptions.BADIOptions.MaxDocOutputWidth);
end;

(**

  This is a constructor for the TVBVar class.

  @precon  None.
  @postcon Provides a reference for the variables array dimensions.

  @param   strName     as a String
  @param   AScope      as a TScope
  @param   iLine       as an Integer
  @param   iColumn     as an Integer
  @param   AImageIndex as a TImageIndex
  @param   AComment    as a TComment

**)
Constructor TVBVar.Create(const strName : String; AScope : TScope; iLine,
  iColumn : Integer; AImageIndex : TBADIImageIndex; AComment : TComment);

Begin
  Inherited Create(strName, AScope, iLine, iColumn, AImageIndex, AComment);
  FDimensions := Nil;
End;

(**

  This is a destructor for the TVBVar class.

  @precon  None.
  @postcon Frees the memory for array dimensions.

**)
destructor TVBVar.Destroy;
begin
  FDimensions := Nil;
  Inherited Destroy;
end;

(**

  This is a getter method for the Dimensions property.

  @precon  None.
  @postcon Returns the number of dimensions in the array variable.

  @return  an Integer

**)
function TVBVar.GetDimensions: Integer;
begin
  Result := High(FDimensions) - Low(FDimensions) + 1;
end;

{ TVBProperty }

(**

  This method returns a string representation of a visual basic property.

  @precon  None .
  @postcon Returns a string representation of a visual basic property .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBProperty.AsString(boolShowIdentifier,
  boolForDocumentation : Boolean): String;

Var
  i : Integer;

begin
  Result := 'Property ';
  Result := Result + strPropertyType[PropertyType] + ' ';
  If boolShowIdentifier Then
    Result := Result + Identifier;
  Result := Result + '(';
  For i := 0 To ParameterCount - 1 Do
    Begin
      If i > 0 Then
        Result := Result + ',';
      If boolForDocumentation Then
        Result := Result + #13#10
      Else
        If i > 0 Then
          Result := Result + #32;
      If boolForDocumentation Then
        Result := Result + #32#32;
      Result := Result + Parameters[i].AsString(boolShowIdentifier,
        boolForDocumentation);
    End;
  If boolForDocumentation Then
    Result := Result + #13#10;
  Result := Result + ')';
  If (PropertyType = ptGet) And (ReturnType.ElementCount > 0) Then
    Result := Result + #32'As'#32 + ReturnType.AsString(False,
      boolForDocumentation);
end;

(**

  This is an overridden method to additional check for property parameters.

  @precon  None.
  @postcon Overridden method to additional check for property parameters.

  @param   boolCascade as a Boolean as a reference

**)
procedure TVBProperty.CheckDocumentation(var boolCascade: Boolean);
begin
  Inherited CheckDocumentation(boolCascade);
  If PropertyType In [ptGet] Then
    Begin
       If ReturnType = Nil Then
         AddIssue(Format(strProperyRequiresReturn, [Identifier]), scNone,
           'CheckDocumentation', Line, Column, etWarning);
    End Else
    Begin
       If ParameterCount = 0 Then
         AddIssue(Format(strProperyRequireParam, [Identifier]), scNone,
           'CheckDocumentation', Line, Column, etWarning);
    End;
end;

(**

  This is a constructor for the TVBProperty class.

  @precon  None .
  @postcon Maps the property type to an internal method type + creates a string
           list for pushed parameters .

  @param   APropertyType as a TPropertyType
  @param   strName       as a String
  @param   AScope        as a TScope
  @param   iLine         as an Integer
  @param   iCol          as an Integer
  @param   iImageIndex   as a TImageIndex
  @param   AComment      as a TComment

**)
constructor TVBProperty.Create(APropertyType: TPropertyType; strName: String;
  AScope: TScope; iLine, iCol: Integer; iImageIndex : TBADIImageIndex;
  AComment : TComment);

begin
  Inherited Create(strName, AScope, iLine, iCol, iImageIndex, AComment);
  FPropertyType := APropertyType;
  FExceptionHandling := TExceptionHandling.Create(strName);
end;

(**

  This is a getter method for the TVBProperty property.

  @precon  None.
  @postcon Returns an altered identifier to distinguish between Get, Let and Set
           properties with the same name.

  @return  a String

**)
function TVBProperty.GetName: String;
begin
  Result := strPropertyType[PropertyType] + '.' + Identifier;
end;

{ TVBRecordDecl }

(**

  This method returns a string representation of the visual basic record.

  @precon  None .
  @postcon Returns a string representation of the visual basic record .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBRecordDecl.AsString(boolShowIdentifier,
  boolForDocumentation : Boolean): String;
begin
  Result := 'Type';
  If boolShowIdentifier Then
    Result := Result + #32 + Identifier;
end;

{ TVBParameter }

(**

  This method returns a string representation of the visual basic parameter.

  @precon  None .
  @postcon Returns a string representation of the visual basic parameter .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBParameter.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := '';
  If Optional Then
    Result := Result + 'Optional';
  If ParamModifier In [pamVar, pamConst] Then
    If Result <> '' Then
      Result := Result + #32;
  Case ParamModifier Of
    pamVar:   Result := Result + 'ByRef';
    pamConst: Result := Result + 'ByVal';
  End;
  If ParamArray Then
    Begin
      If Result <> '' Then
        Result := Result + #32;
      Result := Result + 'ParamArray';
    End;
  If Result <> '' Then
    Result := Result + #32;
  If boolShowIdentifier Then
    Result := Result + Identifier;
  If Result <> '' Then
    Result := Result + #32'As'#32;
  Result := Result + ParamType.AsString(boolShowIdentifier, boolForDocumentation);
  If DefaultValue <> '' Then
    Result := Result + #32 + '=' + #32 + DefaultValue;
end;

{ TVBTypeDecl }

(**

  This method returns a string representation of the visual basic return type.

  @precon  None .
  @postcon Returns a string representation of the visual basic return type .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBTypeDecl.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := BuildStringRepresentation(boolShowIdentifier, boolForDocumentation, '',
   TBADIOptions.BADIOptions.MaxDocOutputWidth);
end;


{ TVBAttribute }

(**

  This method returns a string representation of the visual basic attribute.

  @precon  None .
  @postcon Returns a string representation of the visual basic attribute .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBAttribute.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := BuildStringRepresentation(boolShowIdentifier, boolForDocumentation,
    '', TBADIOptions.BADIOptions.MaxDocOutputWidth);
end;

(**

  This is a getter method for the Name property.

  @precon  None.
  @postcon Returns an attribute name based on all tokens in the container.

  @return  a String

**)
function TVBAttribute.GetName: String;
begin
  Result := BuildStringRepresentation(True, False, '', 9999);
end;

{ TVBOption }

(**

  This method returns a string representation of the visual basic option.

  @precon  None .
  @postcon Returns a string representation of the visual basic option .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBOption.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := BuildStringRepresentation(False, boolForDocumentation,
    '', TBADIOptions.BADIOptions.MaxDocOutputWidth);
  If boolShowIdentifier Then
    If Result <> '' Then
      Result := Identifier + #32 + Result
    Else
      Result := Identifier;
end;

{ TVBVersion }

(**

  This method returns a string representation of the visual basic version.

  @precon  None .
  @postcon Returns a string representation of the visual basic version .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBVersion.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := BuildStringRepresentation(False, boolForDocumentation,
    '', TBADIOptions.BADIOptions.MaxDocOutputWidth);
  If boolShowIdentifier Then
    If Result <> '' Then
      Result := Identifier + #32 + Result
    Else
      Result := Identifier;
end;

{ TVBEnumerateDecl }

(**

  This method returns a string representation of the visual basic enumerate
  declaration.

  @precon  None .
  @postcon Returns a string representation of the visual basic enumerate
           declaration .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBEnumerateDecl.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := 'Enum';
  If boolShowIdentifier Then
    Result := Result + #32 + Identifier;
end;

{ TVBField }

(**

  This method returns a string representation of the visual basic field.

  @precon  None .
  @postcon Returns a string representation of the visual basic field .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBField.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := BuildStringRepresentation(boolShowIdentifier, boolForDocumentation,
    'As', TBADIOptions.BADIOptions.MaxDocOutputWidth);
end;

{ TVBEnumIdent }

(**

  This method returns a string representation of the visual basic enumerate
  identifier.

  @precon  None .
  @postcon Returns a string representation of the visual basic enumerate
           identifier .

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TVBEnumIdent.AsString(boolShowIdentifier, boolForDocumentation: Boolean): String;
begin
  Result := BuildStringRepresentation(boolShowIdentifier, boolForDocumentation, '=',
    TBADIOptions.BADIOptions.MaxDocOutputWidth);
end;

{ TImplementedItem }

(**

  This method returns a string representation of the Implements item.

  @precon  None .
  @postcon Returns a string representation of the imlpements item.

  @param   boolShowIdentifier   as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
function TImplementedItem.AsString(boolShowIdentifier,
  boolForDocumentation: Boolean): String;
begin
  Result := Identifier;
end;

(**

  This method remove the Implement Methods and Exported Headings IF they have
  no elements.

  @precon  None.
  @postcon Remove the Implement Methods and Exported Headings IF they have
           no elements.

**)
procedure TVBModule.TidyUpEmptyElements;

Var
  iElement : Integer;

begin
  For iElement := ElementCount DownTo 1 Do
    If Elements[iElement].ElementCount = 0 Then
      DeleteElement(iElement);
end;

(**

  This is the constructor method for the TVBDocModule class.

  @precon  Source is a valid TStream descendant containing as stream of text
           that is the contents of a source code module, Filename is the file
           name of the module being parsed and IsModified determines if the
           source code module has been modified since the last save to disk.
  @postcon Initialise the class and parses the text stream.

  @param   Source        as a String
  @param   strFileName   as a String
  @param   IsModified    as a Boolean
  @param   ModuleOptions as a TModuleOptions

**)
Constructor TVBModule.CreateParser(const Source, strFileName : String;
  IsModified : Boolean; ModuleOptions : TModuleOptions);

var
  boolCascade: Boolean;

Begin
  Inherited CreateParser(Source, strFileName, IsModified, ModuleOptions);
  FUnResolvedSymbols := TStringList.Create;
  FUnResolvedSymbols.Duplicates := dupIgnore;
  FUnResolvedSymbols.Sorted := True;
  FEventHandlerPatterns := TStringList.Create;
  FEventHandlerPatterns.Add('*_*');
  CompilerDefines.Assign(TBADIOptions.BADIOptions.Defines);
  FSource := Source;
  AddTickCount('Start');
  CommentClass := TVBComment;
  If CompareText(ExtractFileExt(FileName), '.cls') = 0 Then
    FModuleType := mtClass
  Else If CompareText(ExtractFileExt(FileName), '.frm') = 0 Then
    FModuleType := mtForm
  Else
    FModuleType := mtModule;
  ModuleName := ChangeFileExt(ExtractFileName(strFileName), '');
  TokenizeStream;
  AddTickCount('Tokenize');
  If moParse In ModuleOptions Then
    Begin
      Goal;
      AddTickCount('Parse');
      ResolvedForwardReferences;
      AddTickCount('Resolve');
      Add(strErrors, iiErrorFolder, scNone, Nil);
      Add(strWarnings, iiWarningFolder, scNone, Nil);
      Add(strHints, iiHintFolder, scNone, Nil);
      Add(strDocumentationConflicts, iiDocConflictFolder, scNone, Nil);
      PatchAndCheckReferences;
      AddTickCount('Refs');
      If doShowMissingVBExceptionWarnings In TBADIOptions.BADIOptions.Options Then
        CheckExceptionHandling;
      boolCascade := True;
      If moCheckForDocumentConflicts In ModuleOptions Then
        CheckDocumentation(boolCascade);
      AddTickCount('Check');
      TidyUpEmptyElements;
    End;
End;

(**

  This is the destructor method for the TVBDocModule class.

  @precon  None.
  @postcon Frees memory used by internal objects.

**)
Destructor TVBModule.Destroy;

Begin
  FEventHandlerPatterns.Free;
  FUnResolvedSymbols.Free;
  Inherited Destroy;
End;

(**

  This method returns an array of key words for use in the explorer module.

  @precon  None.
  @postcon Returns an array of key words for use in the explorer module.

  @return  a TKeyWords

**)
function TVBModule.ReservedWords: TKeyWords;

Var
  i : Integer;

begin
  SetLength(Result, Succ(High(strReservedWords)));
  For i := Low(strReservedWords) To High(strReservedWords) Do
    Result[i] := strReservedWords[i];
end;

(**

  This method returns an array of key words for use in the explorer module.

  @precon  None.
  @postcon Returns an array of key words for use in the explorer module.

  @return  a TKeyWords

**)
function TVBModule.Directives: TKeyWords;

Var
  i : Integer;

begin
  SetLength(Result, Succ(High(strDirectives)));
  For i := Low(strDirectives) To High(strDirectives) Do
    Result[i] := strDirectives[i];
end;

(**

  This method is an overridden method to processes compiler directives.

  @precon  None.
  @postcon Not implemented.

  @param   iSkip as an Integer as a reference

**)
procedure TVBModule.ProcessCompilerDirective(var iSkip: Integer);
begin
  {Do nothing}
end;

(**

  This method tokenises the stream of text passed to the constructor and splits
  it into visual basic tokens.

  @precon  None.
  @postcon Tokenises the stream of text passed to the constructor and splits
           it into visual basic tokens.

**)
Procedure TVBModule.TokenizeStream;

Type
  (** State machine for block types. **)
  TBlockType = (btNoBlock, btStringLiteral, btLineComment, btBraceComment);

Const
  (** Growth size of the token buffer. **)
  iTokenCapacity = 25;

Var
  (** Token buffer. **)
  strToken : String;
  CurCharType : TBADITokenType;
  LastToken : TBADITokenType;
  BlockType : TBlockType;
  (** Current line number **)
  iLine : Integer;
  (** Current column number **)
  iColumn : Integer;
  (** Token stream position. Fast to inc this than read the stream position. **)
  iStreamPos : Integer;
  (** Token line **)
  iTokenLine : Integer;
  (** Token column **)
  iTokenColumn : Integer;
  (** Current character position **)
  iStreamCount : Integer;
  Ch : Char;
  (** Token size **)
  iTokenLen : Integer;
  iChar: Integer;

Begin
  BlockType := btNoBlock;
  iStreamPos := 0;
  iTokenLine := 1;
  iTokenColumn := 1;
  CurCharType := ttUnknown;
  //: @debug LastToken := ttUnknown;
  iStreamCount := 0;
  iLine := 1;
  iColumn := 1;
  strToken := '';

  iTokenLen := 0;
  SetLength(strToken, iTokenCapacity);

  For iChar := 1 To Length(FSource) Do
    Begin
      ch := FSource[iChar];
      Inc(iStreamCount);
      LastToken := CurCharType;

      If IsInSet(ch, strWhiteSpace) Then
        CurCharType := ttWhiteSpace
      Else If IsInSet(ch, strTokenChars) Then
        Begin
          If (LastToken = ttNumber) And (IsInSet(Ch, ['A'..'F', 'H', 'a'..'f', 'h'])) Then
            CurCharType := ttNumber
          Else
            If (LastToken In [ttWhiteSpace]) And (IsInSet(Ch, ['_'])) Then
              CurCharType := ttLineContinuation
            Else
              Begin
                If LastToken In [ttLineContinuation] Then
                  LastToken := ttIdentifier;
                CurCharType := ttIdentifier
              End;
        End
      Else If IsInSet(ch, strNumbers) Then
        Begin
          CurCharType := ttNumber;
          If LastToken = ttIdentifier Then
            CurCharType := ttIdentifier;
        End
      Else If IsInSet(ch, strLineEnd) Then
        CurCharType := ttLineEnd
      Else If IsInSet(ch, strQuote) Then
        CurCharType := ttDoubleLiteral
      Else If IsInSet(ch, strSymbols) Then
        Begin
          CurCharType := ttSymbol;
          If (Ch = '.') And (LastToken = ttNumber) Then
            CurCharType := ttNumber;
          If (LastToken In [ttIdentifier]) And (IsInSet(Ch, ['%', '$', '&'])) Then
            CurCharType := ttIdentifier;
        End
      Else
        CurCharType := ttUnknown;

      If (LastToken <> CurCharType) Or (CurCharType = ttSymbol) Then
        Begin
          If ((BlockType In [btStringLiteral, btLineComment]) And
            (CurCharType <> ttLineEnd)) Or (BlockType In [btBraceComment]) Then
            Begin
              Inc(iTokenLen);
              If iTokenLen > Length(strToken) Then
                SetLength(strToken, iTokenCapacity + Length(strToken));
              strToken[iTokenLen] := Ch;
            End Else
            Begin
              SetLength(strToken, iTokenLen);
              If iTokenLen > 0 Then
                If Not (IsInSet(strToken[1], strWhiteSpace)) Then
                  Begin
                    If LastToken = ttIdentifier Then
                      Begin
                        If IsKeyWord(strToken, strReservedWords) Then
                          LastToken := ttReservedWord;
                        If IsKeyWord(strToken, strDirectives) Then
                          LastToken := ttDirective;
                      End;
                    If BlockType = btLineComment Then
                      LastToken := ttLineComment;
                    If (LastToken = ttLineComment) And (Length(strToken) > 2) Then
                      If (strToken[1] = '{') And (strToken[2] = '$') Then
                        LastToken := ttCompilerDirective;
                    If IsInSet(strToken[1], strLineEnd) Then
                      strToken := StringReplace(strToken, #13#10, '<line-end>',
                        [rfReplaceAll]);
                    AddToken(TTokenInfo.Create(strToken, iStreamPos,
                      iTokenLine, iTokenColumn, Length(strToken), LastToken));
                    //Inc(iCounter);
                  End;
              // Store Stream position, line number and column of
              // token start
              iStreamPos := iStreamCount;
              iTokenLine := iLine;
              iTokenColumn := iColumn;
              BlockType := btNoBlock;
              iTokenLen := 1;
              SetLength(strToken, iTokenCapacity);
              strToken[iTokenLen] := Ch;
            End;
        End Else
        Begin
          Inc(iTokenLen);
          If iTokenLen > Length(strToken) Then
            SetLength(strToken, iTokenCapacity + Length(strToken));
          strToken[iTokenLen] := Ch;
        End;

      // Check for line comments
      If (BlockType = btNoBlock) And (Ch = '''') Then
        BlockType := btLineComment;

      // Check for string literals
      If CurCharType = ttDoubleLiteral Then
        If BlockType = btStringLiteral Then
          BlockType := btNoBlock
        Else If BlockType = btNoBlock Then
          BlockType := btStringLiteral;

        // Check for block Comments
        If (BlockType = btNoBlock) And (Ch = '{') Then
          Begin
            CurCharType := ttLineComment;
            BlockType := btBraceComment;
          End;
        If (BlockType = btBraceComment) And (Ch = '}') Then
          Begin
            CurCharType := ttLineComment;
            BlockType := btNoBlock;
          End;
//              If BlockType = btCompoundSymbol Then
//                BlockType := btNoBlock;

      Inc(iColumn);
      If Ch = #10 Then
        Begin
          Inc(iLine);
          iColumn := 1;
          If BlockType In [btLineComment, btStringLiteral] Then
            BlockType := btNoBlock;
        End;
    End;
  If iTokenLen > 0 Then
    Begin
      SetLength(strToken, iTokenLen);
      If iTokenLen > 0 Then
        If Not (IsInSet(strToken[1], strWhiteSpace)) Then
          Begin
            If CurCharType = ttIdentifier Then
              Begin
                If IsKeyWord(strToken, strReservedWords) Then
                  CurCharType := ttReservedWord;
                If IsKeyWord(strToken, strDirectives) Then
                  CurCharType := ttDirective;
              End;
            If IsInSet(strToken[1], strLineEnd) Then
              strToken := StringReplace(strToken, #13#10, '<line-end>',
                [rfReplaceAll]);
            AddToken(TTokenInfo.Create(strToken, iStreamPos,
              iTokenLine, iTokenColumn, Length(strToken), CurCharType));
          End;
    End;
  AddToken(TTokenInfo.Create('<end-of-file>', iStreamPos, iTokenLine, iTokenColumn, 0,
    ttFileEnd));
End;

(**

  This method returns the comment before the current token.

  @precon  None.
  @postcon Returns the comment before the current token.

  @param   CommentPosition as a TCommentPosition
  @return  a TComment

**)
function TVBModule.GetComment(CommentPosition: TCommentPosition): TComment;

Var
  T : TTokenInfo;
  strComment : String;
  iToken : Integer;
  iLine, iColumn : Integer;
  iOffset: Integer;
  iLastCmtLine : Integer;

begin
  Result := Nil;
  iLine := 0;
  iColumn := 0;
  iLastCmtLine := Token.Line;
  If CommentPosition = cpBeforeCurrentToken Then
    iOffset := -1
  Else
    iOffset := -2;
  iToken := TokenIndex + iOffset;
  While iToken > -1 Do
    Begin
      While (iToken > -1) And ((Tokens[iToken] As TTokenInfo).TokenType In
        [ttLineEnd, ttLineContinuation]) Do
        Dec(iToken);
      If iToken <= -1 Then
        Break;
      T := Tokens[iToken] As TTokenInfo;
      If T.TokenType In [ttLineComment] Then
        If T.Line = iLastCmtLine - 1 Then
          Begin
            iLine := T.Line;
            iColumn := T.Column;
            If strComment <> '' Then
              strComment := #13#10 + strComment;
            strComment := T.Token + strComment;
            iLastCmtLine := T.Line;
          End Else
            Break;
      Dec(iToken);
    End;
  If strComment <> '' Then
    Begin
      Result := TVBComment.CreateComment(strComment, iLine, iColumn);
      OwnedItems.Add(Result);
    End;
end;

(**

  This method starts the process of parsing the visual basic delcarations.

  @precon  None.
  @postcon Parses the code in the stream of tokens.

**)
procedure TVBModule.Goal;

var
  iMethod : Integer;
  Methods : Array[1..5] Of Function : Boolean Of Object;

begin
  Try
    While Token.TokenType In [ttLineComment, ttBlockComment, ttLineEnd] Do
      NextNonCommentToken;
    Methods[1] := Version;
    Methods[2] := Attributes;
    Methods[3] := Options;
    Methods[4] := Implements;
    Methods[5] := Declarations;
    For iMethod := Low(Methods) To High(Methods) Do
      Begin
        If EndOfTokens Then
          Break;
        If Methods[iMethod] Then
          While Not EndOfTokens And (Token.TokenType In [ttLineEnd]) Do
            NextNonCommentToken;
      End;
  Except
    On E : EBADIParserAbort Do
      AddIssue(E.Message, scNone, 'Goal', 0, 0, etError);
  End;
end;

(**

  This mnethod parses the ImplementationSection declarations in the module.

  @precon  None.
  @postcon Parses the ImplementationSection declarations in the module.

**)
Procedure TVBModule.ImplementationSection;

Var
  C : TComment;
  boolResult : Boolean;
  AScope : TScope;

begin
  Repeat
    C := GetComment;
    CheckForImplementationScope(AScope);
    boolResult :=
      Subs(AScope, C, False, Nil) Or
      Functions(AScope, C, False, Nil) Or
      Props(AScope, C, False);
    If Not boolResult Then
      If Not EndOfTokens Then
        If Token.TokenType In [ttLineEnd] Then
          NextNonCommentToken
        Else
          ErrorAndSeekToken(strUnDefinedToken, 'ImplementationSection', Token.Token,
            strSeekTokens, stActual);
  Until EndOfTokens;
end;

(**

  This method parses any Implements delcarations in the module.

  @precon  None.
  @postcon Returns true if an implements delcaration was parsed.

  @return  a Boolean

**)
Function TVBModule.Implements : Boolean;

Var
  ImplementsLabel : TLabelContainer;
  strQID : String;
  I: TImplementedItem;
  QStartToken: TTokenInfo;

begin
  Result := False;
  While Token.UToken = 'IMPLEMENTS' Do
    Begin
      Result := True;
      ImplementsLabel := FindElement(strImplementsLabel) As TLabelContainer;
      If ImplementsLabel = Nil Then
        ImplementsLabel := Add(TLabelContainer.Create(strImplementsLabel, scNone,
          0, 0, iiInterfacesLabel, Nil)) As TLabelContainer;
      NextNonCommentToken;
      I := Nil;
      QStartToken := Token;
      Repeat
        If Token.TokenType In [ttIdentifier] Then
          Begin
            strQID := QualifiedIdentifier(Nil, [ttIdentifier]);
            I := TImplementedItem.Create(strQID, scNone, QStartToken.Line,
              QStartToken.Column, iiPublicInterface, Nil);
            ImplementsLabel.Add(I);
          End Else
            ErrorAndSeekToken(strIdentExpected, 'Implements',
              Token.Token, strSeekTokens, stActual);
      Until Not IsToken(',', I);
      If Token.TokenType In [ttLineEnd] Then
        NextNonCommentToken
      Else
        ErrorAndSeekToken(strLineEndExpected, 'Implements',
          Token.Token, strSeekTokens, stActual);
    End;
end;

(**

  This method parses the InterfaceSection declarations of the grammar.

  @precon  None.
  @postcon Parses the InterfaceSection declarations of the grammar.

**)
Procedure TVBModule.InterfaceSection;

Var
  C : TComment;
  boolResult: Boolean;
  AScope : TScope;

begin
  Repeat
    C := GetComment;
    CheckForInterfaceScope(AScope);
    boolResult :=
      Consts(AScope, C) Or
      Declares(AScope, C) Or
      Dims(AScope, C) Or
      Records(AScope, C) Or
      Enum(AScope, C) Or
      Vars(AScope, C);
  Until Not boolResult;
  If PrevToken <> Nil Then
    If IsKeyWord(PrevToken.Token, ['friend', 'private', 'public']) Then
      RollBackToken;
end;

function TVBModule.InvocationStatement: Boolean;
begin
  Result := False;
end;

function TVBModule.LabelDeclarationStatement: Boolean;
begin
  Result := False;
end;

function TVBModule.LocalDeclarationStatement: Boolean;
begin
  Result := False;
end;

function TVBModule.LoopStatement: Boolean;
begin
  Result := False;
end;

(**

  This method processes a version declarations that appears at the top of
  module, classes, etc, which are output to disk.

  @precon  None.
  @postcon Processes a version declarations that appears at the top of module,
           classes, etc, which are output to disk.

  @return  a Boolean

**)
Function TVBModule.Version : Boolean;

Var
  L : TLabelContainer;
  V : TVBVersion;

begin
  Result := False;
  If IsKeyWord(Token.Token, ['version']) Then
    Begin
      Result := True;
      If Comment = Nil Then
        Comment := GetComment;
      L := Add(TLabelContainer.Create(strVersionLabel, scNone, 0, 0,
        iiUsesLabel, Nil)) As TLabelContainer;
      V := L.Add(TVBVersion.Create(Token.Token, scNone, Token.Line,
        Token.Column, iiUsesLabel, Nil)) As TVBVersion;
      NextNonCommentToken;
      If FloatingPointLiteral(V) Then
        Begin
          If Token.UToken = 'CLASS' Then
            AddToExpression(V);
          If Token.TokenType In [ttLineEnd] Then
            Begin
              NextNonCommentToken;
              VBBegin(V);
            End Else
              ErrorAndSeekToken(strLineEndExpected, 'Version',
                Token.Token, strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strNumberExpected, 'Version',
            Token.Token, strSeekTokens, stActual);
    End;
end;

function TVBModule.WithStatement: Boolean;
begin
  Result := False;
end;

(**

  This method processes variable declarations.

  @precon  None.
  @postcon Processes variable declarations.

  @param   AScope as a TScope
  @param   C      as a TComment
  @return  a Boolean

**)
function TVBModule.Vars(AScope: TScope; C: TComment): Boolean;

begin
  Result := False;
  Repeat
    Result := VarDecl(AScope, C) Or Result;
  Until Not IsToken(',', Nil);
  If Result Then
    If Token.TokenType In [ttLineEnd] Then
      NextNonCommentToken
    Else
      ErrorAndSeekToken(strLineEndExpected, 'Vars', Token.Token,
        strSeekTokens, stActual);
end;

(**

  This method parses the VarDecl element of the grammar.

  @precon  None.
  @postcon Parses the VarDecl element of the grammar.

  @param   AScope as a TScope
  @param   C      as a TComment
  @return  a Boolean

**)
function TVBModule.VarDecl(AScope: TScope; C: TComment): Boolean;

Var
  boolWithEvents : Boolean;
  V : TVBVar;
  VarsLabel: TLabelContainer;

Begin
  Result := False;
  boolWithevents := Token.UToken = 'WITHEVENTS';
  If boolWithEvents Then
    NextNonCommentToken;
  If Token.TokenType In [ttIdentifier] Then
    Begin
      Result := True;
      V := TVBVar.Create(Token.Token, AScope, Token.Line, Token.Column,
        iiPublicVariable, C);
      VarsLabel := FindElement(strVarsLabel) As TLabelContainer;
      If VarsLabel = Nil Then
        VarsLabel := Add(TLabelContainer.Create(strVarsLabel, scNone, 0, 0,
          iiPublicVariablesLabel, Nil)) As TLabelContainer;
      V := VarsLabel.Add(V) As TVBVar;
      V.Referenced := True;
      V.Comment := C;
      V.WithEvents := boolWithEvents;
      NextNonCommentToken;
      ProcessVar(V);
    End;
End;

(**

  This method processes the BEGIN / END section of a module version clause.

  @precon  None .
  @postcon Processes the BEGIN / END section of a module version clause .

  @param   C as a TElementContainer
  @return  a Boolean

**)
Function TVBModule.VBBegin(C : TElementContainer) : Boolean;

Var
  Container : TElementContainer;
  strModifier: String;
  strQID: String;
  QStartToken: TTokenInfo;

Begin
  Result := False;
  Container := C;
  If IsKeyWord(Token.Token, ['begin', 'beginproperty']) Then
    Begin
      Result := True;
      strModifier := LowerCase(Token.Token);
      Delete(strModifier, 1, 5);
      NextNonCommentToken;
      If strModifier = '' Then
        Begin
          If Token.TokenType In [ttIdentifier, ttDirective] Then
            Begin
              QStartToken := Token;
              strQID := QualifiedIdentifier(Nil, [ttIdentifier, ttDirective]);
              Container := TVBAttribute.Create(strQID, scNone, QStartToken.Line,
                QStartToken.Column, iiUsesItem, Nil);
              Container := C.Add(Container);
              If Token.TokenType In [ttIdentifier, ttDirective] Then
                Begin
                  Container.AddToken(Token.Token);
                  NextNonCommentToken;
                End;
            End;
        End Else
        Begin
          If Token.TokenType In [ttIdentifier, ttDirective] Then
            Begin
              strQID := Token.Token;
              NextNonCommentToken;
              Container := TVBAttribute.Create(strQID, scNone, Token.Line,
                Token.Column, iiUsesItem, Nil);
              Container := C.Add(Container);
            End Else
              ErrorAndSeekToken(strIdentExpected, 'VBBegin', Token.Token,
                strSeekTokens, stActual);
        End;
      If Token.TokenType In [ttLineEnd] Then
        Begin
          NextNonCommentToken;
          Repeat
            // Do nothing
          Until Not (
            VBBegin(Container) Or
            Attribute(Container)
          );
          If IsKeyWord(Token.Token, ['end' + strModifier]) Then
            Begin
              NextNonCommentToken;
              If Token.TokenType In [ttLineEnd] Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLineEndExpected, 'VBBegin',
                  Token.Token, strSeekTokens, stActual);
            End
          Else
            ErrorAndSeekToken(strReservedWordExpected, 'VBBegin',
              'END', strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strReservedWordExpected, 'VBBegin',
            'BEGIN', strSeekTokens, stActual);
    End;
End;

(**

  This method processes a list of attributes declared at the header of a visual
  basic module.

  @precon  None.
  @postcon Processes a list of attributes declared at the header of a visual
           basic module.

  @return  a Boolean

**)
Function TVBModule.Attributes : Boolean;
var
  AttrsLabel: TLabelContainer;

Begin
  Result := False;
  While IsKeyWord(Token.Token, ['attribute']) Do
    Begin
      Result := True;
      If Comment = Nil Then
        Comment := GetComment;
      AttrsLabel := FindElement(strAttributesLabel) As TLabelContainer;
      If AttrsLabel = Nil Then
        AttrsLabel := Add(TLabelContainer.Create(strAttributesLabel,
          scNone, 0, 0, iiUsesLabel, Nil)) As TLabelContainer;
      NextNonCommentToken;
      Attribute(AttrsLabel);
    End;
end;

procedure TVBModule.Block;

begin
  While Statements Do;
end;

function TVBModule.BranchStatement: Boolean;
begin
  Result := False;
end;

(**

  This method parses a single attribute at the top of the module.

  @precon  None .
  @postcon Parses a single attribute at the top of the module .

  @param   C as a TElementContainer
  @return  a Boolean

**)
function TVBModule.AssignmentStatement: Boolean;
begin
  Result := False;
end;

Function TVBModule.Attribute(C : TElementContainer) : Boolean;

Var
  A : TVBAttribute;
  strQID : String;
  QStartToken: TTokenInfo;

begin
  Result := False;
  If (Token.TokenType In [ttIdentifier, ttDirective]) And
    (CompareText(Token.Token, 'endproperty') <> 0) Then
    Begin
      Result := True;
      QStartToken := Token;
      strQID := QualifiedIdentifier(Nil, [ttIdentifier, ttDirective]);
      A := C.Add(TVBAttribute.Create(strQID, scNone, QStartToken.Line,
        QStartToken.Column, iiUsesItem, Nil)) As TVBAttribute;
      If Token.Token = '=' Then
        Begin
          A.AddToken(Token.Token);
          NextNonCommentToken;
          If Token.Token = '-' Then
            AddToExpression(A);
          If Token.TokenType In [ttNumber, ttIdentifier, ttDirective,
            ttDoubleLiteral] Then
            Begin
              AddToExpression(A);
              If Token.Token = ':' Then
                Begin
                  AddToExpression(A);
                  If Token.TokenType In [ttNumber] Then
                    Begin
                      AddToExpression(A);
                      If Token.TokenType In [ttLineEnd] Then
                        NextNonCommentToken
                      Else
                        ErrorAndSeekToken(strLineEndExpected, 'Attribute',
                          Token.Token, strSeekTokens, stActual);
                    End Else
                      ErrorAndSeekToken(strNumberExpected, 'Attribute',
                        Token.Token, strSeekTokens, stActual);
                End Else
              If Token.TokenType In [ttLineEnd] Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLineEndExpected, 'Attribute',
                  Token.Token, strSeekTokens, stActual);
            End Else
              ErrorAndSeekToken(strValueExpected, 'Attribute',
                Token.Token, strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strLiteralExpected, 'Attribute',
            '=', strSeekTokens, stActual);
    End;
end;

(**

  This method parsers the options statements at the top of the modules.

  @precon  None.
  @postcon Parsers the options statements at the top of the modules.

  @return  a Boolean

**)
Function TVBModule.Options : Boolean;

Const
  strBases : Array[0..1] Of String = ('0', '1');
  strCompares : Array[0..2] Of String = ('binary', 'database', 'text');

Var
  O : TVBOption;
  OptionsLabel: TLabelContainer;

Begin
  Result := False;
  While Token.UToken = 'OPTION' Do
    Begin
      Result := True;
      If Comment = Nil Then
        Comment := GetComment;
      OptionsLabel := FindElement(strOptionsLabel) As TLabelContainer;
      If OptionsLabel = Nil Then
        OptionsLabel := Add(TLabelContainer.Create(strOptionsLabel, scNone,
          0, 0, iiUsesLabel, Nil)) As TLabelContainer;
      NextNonCommentToken;
      If Token.UToken = 'BASE' Then
        Begin
          O := OptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
            Token.Line, Token.Column, iiUsesItem, Nil)) As TVBOption;
          NextNonCommentToken;
          If IsKeyWord(Token.Token, strBases) Then
            Begin
              AddToExpression(O);
              If Token.TokenType In [ttLineEnd] Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLineEndExpected, 'Options', Token.Token,
                  strSeekTokens, stActual);
            End Else
              ErrorAndSeekToken(strReservedWordExpected, 'Options',
                '0 or 1', strSeekTokens, stActual);
        End Else
      If Token.UToken = 'COMPARE' Then
        Begin
          O := OptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
            Token.Line, Token.Column, iiUsesItem, Nil)) As TVBOption;
          NextNonCommentToken;
          If IsKeyWord(Token.Token, strCompares) Then
            Begin
              AddToExpression(O);
              If Token.TokenType In [ttLineEnd] Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLineEndExpected, 'Options', Token.Token,
                  strSeekTokens, stActual);
            End Else
              ErrorAndSeekToken(strReservedWordExpected, 'Options',
                'BINARY, DATABASE or TEXT', strSeekTokens, stActual);
        End Else
      If Token.UToken = 'PRIVATE' Then
        Begin
          O := OptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
            Token.Line, Token.Column, iiUsesItem, Nil)) As TVBOption;
          NextNonCommentToken;
          If Token.UToken = 'MODULE' Then
            Begin
              AddToExpression(O);
              If Token.TokenType In [ttLineEnd] Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLineEndExpected, 'Options', Token.Token,
                  strSeekTokens, stActual);
            End Else
              ErrorAndSeekToken(strReservedWordExpected, 'Options',
                'MODULE', strSeekTokens, stActual);
        End Else
      If Token.UToken = 'EXPLICIT' Then
        Begin
          OptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
            Token.Line, Token.Column, iiUsesItem, Nil));
          NextNonCommentToken;
          If Token.TokenType In [ttLineEnd] Then
            NextNonCommentToken
          Else
            ErrorAndSeekToken(strLineEndExpected, 'Options', Token.Token,
              strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strReservedWordExpected, 'Options',
            'BASE, COMPARE, EXPLICIT or PRIVATE', strSeekTokens, stActual);
    End;
End;

(**

  This method dispatches to sub functions to have the keywords found.

  @precon  None.
  @postcon Dispatches to sub functions to have the keywords found.

  @return  a Boolean

**)
Function TVBModule.Declarations : Boolean;

Begin
  Result := False;
  InterfaceSection;
  ImplementationSection;
End;

(**

  This method parses parameters for method and properties.

  @precon  Method must be a valid instance of a method .
  @postcon Parses parameters for method and properties .

  @param   Container as a TElementContainer

**)
Procedure TVBModule.Parameters(Container : TElementContainer);

Var
  boolOptional : Boolean;
  P : TVBParameter;
  PM : TParamModifier;
  boolParamArray : Boolean;
  boolArray : Boolean;
  Ident : TTokenInfo;
  ParamType : TVBTypeDecl;
  DefaultValue: String;

Begin
  Repeat
    boolOptional := Token.UToken = 'OPTIONAL';
    If boolOptional Then
      NextNonCommentToken;
    PM := pamNone;
    If Token.UToken = 'BYVAL' Then
      Begin
        PM := pamNone;
        NextNonCommentToken;
      End;
    If Token.UToken = 'BYREF' Then
      Begin
        PM := pamVar;
        NextNonCommentToken;
      End;
    boolParamArray := Token.UToken = 'PARAMARRAY';
    If boolParamArray Then
      NextNonCommentToken;
    Ident := Token;
    NextNonCommentToken;
    boolArray := False;
    If Token.Token = '(' Then
      Begin
        boolArray := True;
        NextNonCommentToken;
        If Token.Token <> ')' Then
          ErrorAndSeekToken(strLiteralExpected, 'Parameters',
            ')', strSeekTokens, stActual);
        NextNonCommentToken;
      End;
    ParamType := Nil;
    Try
      If Token.UToken = 'AS' Then
        Begin
          NextNonCommentToken;
          ParamType := TVBTypeDecl.Create('', scNone, Token.Line, Token.Column,
            iiNone, Nil);
          ParamType.AppendToken(Token);
          NextNonCommentToken;
          If Token.Token = '.' Then
            Begin
              ParamType.AddToken('.');
              NextNonCommentToken;
              ParamType.AddToken(Token.Token);
              NextNonCommentToken;
            End;
        End Else
        Begin
          ParamType := TVBTypeDecl.Create('', scNone, Token.Line, Token.Column,
            iiNone, Nil);
          ParamType.AddToken('Variant');
        End;
      DefaultValue := '';
      If (Token.Token = '=') And boolOptional Then
        Begin
          If Token.Token = '=' Then
            NextNonCommentToken
          Else
            ErrorAndSeekToken(strLiteralExpected, 'Parameters', '=',
              strSeekTokens, stActual);
          While (Token.Token <> ',') And (Token.Token <> ')') Do
            Begin
              DefaultValue := DefaultValue + Token.Token;
              NextNonCommentToken;
            End;
        End;
      P := TVBParameter.Create(pm, Ident.Token, boolArray, ParamType,
        DefaultValue, scLocal, Token.Line, Token.Column);
      If Container Is TVBMethod Then
        (Container AS TVBMethod).AddParameter(P)
      Else
        (Container AS TVBProperty).AddParameter(P);
      P.Optional := boolOptional;
      P.ParamArray := boolParamArray;
    Finally
      ParamType.Free;
    End;
  Until Not IsToken(',', Nil);
End;

Function TVBModule.Statement: Boolean;

Begin
  Result :=
    LabelDeclarationStatement Or
    LocalDeclarationStatement Or
    WithStatement Or
    EventStatement Or
    AssignmentStatement Or
    InvocationStatement Or
    ConditionalStatement Or
    LoopStatement Or
    ErrorHandlingStatement Or
    BranchStatement Or
    ArrayHandlingStatement;
End;

function TVBModule.Statements: Boolean;
begin
  Result := Statement;
  {: @debug If Not Result Then
    Begin
      Result := Statements;
      If Token.Token = ':' Then
        Begin
          NextNonCommentToken;
          If Not Statements Then
            ErrorAndSeekToken(strStatementExpected, 'Statements', Token.Token,
              strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strLiteralExpected, 'Statements', Token.Token,
            strSeekTokens, stActual);
    End;}
end;

(**

  This method defers parsing of subroutines to the MethodDecl method.

  @precon  None.
  @postcon Defers parsing of subroutines to the MethodDecl method.

  @param   AScope as a TScope
  @param   C            as a TComment
  @param   boolStatic   as a Boolean
  @param   DeclareLabel as a TLabelContainer
  @return  a Boolean

**)
Function TVBModule.Subs(AScope : TScope; C : TComment; boolStatic : Boolean;
  DeclareLabel : TLabelContainer) : Boolean;

Var
  M : TVBMethod;
  MethodsLabel: TLabelContainer;

Begin
  Result := False;
  If Token.UToken = 'SUB' Then
    Begin
      Result := True;
      NextNonCommentToken;
      M := TVBMethod.Create(mtProcedure, Token.Token, AScope, Token.Line,
        Token.column);
      If DeclareLabel = Nil Then
        Begin
          MethodsLabel := FindElement(strImplementedMethodsLabel) As TLabelContainer;
          If MethodsLabel = Nil Then
            MethodsLabel := Add(TLabelContainer.Create(
              strImplementedMethodsLabel, scNone, 0, 0, iiImplementedMethods, Nil)
              ) As TLabelContainer;
          M := MethodsLabel.Add(M) As TVBMethod;
        End Else
          M := DeclareLabel.Add(M) As TVBMethod;
      MethodDecl(M, C);
      If M.Ext = '' Then
        Begin
          Block;
          CheckMethodEnd('SUB');
        End;
    End;
End;

(**

  This method defers parsing of functions to the MethodDecl method.

  @precon  None.
  @postcon Defers parsing of function to the MethodDecl method.

  @param   AScope as a TScope
  @param   C            as a TComment
  @param   boolStatic   as a Boolean
  @param   DeclareLabel as a TLabelContainer
  @return  a Boolean

**)
Function TVBModule.Functions(AScope : TScope; C : TComment; boolStatic : Boolean;
  DeclareLabel : TLabelContainer) : Boolean;

Var
  M : TVBMethod;
  MethodsLabel: TLabelContainer;

Begin
  Result := False;
  If Token.UToken = 'FUNCTION' Then
    Begin
      Result := True;
      NextNonCommentToken;
      M := TVBMethod.Create(mtFunction, Token.Token, AScope, Token.Line,
        Token.column);
      If DeclareLabel = Nil Then
        Begin
          MethodsLabel := FindElement(strImplementedMethodsLabel) As TLabelContainer;
          If MethodsLabel = Nil Then
            MethodsLabel := Add(TLabelContainer.Create(
              strImplementedMethodsLabel, scNone, 0, 0, iiImplementedMethods, Nil)
              ) As TLabelContainer;
          M := MethodsLabel.Add(M) As TVBMethod;
        End Else
          M := DeclareLabel.Add(M) As TVBMethod;
      MethodDecl(M, C);
      If M.Ext = '' Then
        Begin
          Block;
          CheckMethodEnd('FUNCTION');
        End;
    End;
End;

(**

  This method parses the sub and function declarations.

  @precon  M must be a valid method declaration.
  @postcon Parses the sub and function declarations.

  @param   M as a TGenericMethodDecl
  @param   C as a TComment

**)
Procedure TVBModule.MethodDecl(M : TGenericMethodDecl; C : TComment);

Var
  T : TVBTypeDecl;

Begin
  M.Comment := C;
  M.Identifier := Token.Token;
  M.ClassNames.Add(ModuleName);
  NextNonCommentToken;
  If Token.UToken = 'LIB' Then
    Begin
      NextNonCommentToken;
      M.Ext := Token.Token;
      NextNonCommentToken
    End;
  If Token.UToken = 'ALIAS' Then
    Begin
      NextNonCommentToken;
      M.Alias := Token.Token;
      NextNonCommentToken
    End;
  If Token.Token = '(' Then
    NextNonCommentToken
  Else
    ErrorAndSeekToken(strLiteralExpected, 'MethodDecl',
      '(', strSeekTokens, stActual);
  If Token.Token <> ')' Then
    Parameters(M);
  If Token.Token = ')' Then
    NextNonCommentToken
  Else
    ErrorAndSeekToken(strLiteralExpected, 'MethodDecl',
      ')', strSeekTokens, stActual);
  If Token.UToken = 'AS' Then
    Begin
      NextNonCommentToken;
      T := TVBTypeDecl.Create(Token.Token, scNone, 0, 0, iiNone, Nil);
      M.ReturnType.Add(T);
      T.AppendToken(Token);
      If Token.TokenType In [ttIdentifier, ttReservedWord] Then
        Begin
          NextNonCommentToken;
          If Token.Token = '.' Then
            Begin
              T.AddToken('.');
              NextNonCommentToken;
              T.AppendToken(Token);
              If Not EndOfTokens Then
                NextNonCommentToken
              Else
                Exit;
            End;
          If Token.Token = '(' Then
            Begin
              NextNonCommentToken;
              If Token.Token = ')' Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLiteralExpected, 'MethodDecl',
                  Token.Token, strSeekTokens, stActual);
            End;
        End Else
          ErrorAndSeekToken(strIdentExpected, 'MethodDecl', Token.Token,
            strSeekTokens, stActual);
    End;
  If Token.TokenType In [ttLineEnd] Then
    NextNonCommentToken
  Else
    ErrorAndSeekToken(strLineEndExpected, 'MethodDecl', Token.Token,
      strSeekTokens, stActual);
End;


(**

  This method overrides the default NextNonCommentToken to skip line-ends if
  preceeded by a line continuation token.

  @precon  None.
  @postcon Overrides the default NextNonCommentToken to skip line-ends if
           preceeded by a line continuation token.

**)
procedure TVBModule.NextNonCommentToken;

begin
  Inherited NextNonCommentToken;
  If Token.TokenType In [ttLineContinuation] Then
    Begin
      NextToken;
      If Token.TokenType In [ttLineEnd] Then
        NextToken
      Else
        ErrorAndSeekToken(strLineEndExpected, 'NextNonCommentToken',
          Token.Token, strSeekTokens, stActual);
    End;
end;

(**

  This method checks for a gloating point literal in the code and returns true
  if found at the current token and adds the token to the expression.

  @precon  V must be a valid instance.
  @postcon Checks for a gloating point literal in the code and returns true
           if found at the current token and adds the token to the expression.

  @param   V as a TVBVersion
  @return  a Boolean

**)
function TVBModule.FloatingPointLiteral(V: TVBVersion): Boolean;

begin
  Result := False;
  If Token.TokenType In [ttNumber] Then
    Begin
      Result := True;
      AddToExpression(V);
    End;
end;

(**

  This method checks the methods and properties for exception handling code
  (TException.Push / Pop etc).

  @precon  None.
  @postcon Checks the methods and properties for exception handling code.

**)
procedure TVBModule.CheckExceptionHandling;

Var
  I : TElementContainer;
  j : Integer;

begin
  I := FindElement(strImplementedMethodsLabel);
  If i <> Nil Then
    Begin
      For j := 1 To I.ElementCount Do
        CheckElementExceptionHandling(I.Elements[j] As TVBMethod,
          (I.Elements[j] As TVBMethod).ExceptionHandling);
    End;
  I := FindElement(strImplementedPropertiesLabel);
  If i <> Nil Then
    Begin
      For j := 1 To I.ElementCount Do
        CheckElementExceptionHandling(I.Elements[j] As TVBProperty,
          (I.Elements[j] As TVBProperty).ExceptionHandling);
    End;
end;

procedure TVBModule.CheckForImplementationScope(var AScope: TScope);

begin
  AScope := scPublic;
  If IsKeyWord(Token.Token, ['friend', 'private', 'public']) Then
    Begin
      If CompareText(Token.Token, 'private') = 0 Then
        AScope := scPrivate
      Else If CompareText(Token.Token, 'friend') = 0 Then
        AScope := scFriend;
      NextNonCommentToken;
    End;
end;

(**

  This method checks for a scope changes using the scope keywords.

  @precon  None.
  @postcon If a scope change is found it changes the AScope variable to make the
           scope change and moves to the next token.

  @param   AScope as a TScope as a reference

**)
procedure TVBModule.CheckForInterfaceScope(var AScope: TScope);

begin
  AScope := scPublic;
  If IsKeyWord(Token.Token, ['private', 'public']) Then
    Begin
      If CompareText(Token.Token, 'private') = 0 Then
        AScope := scPrivate;
      NextNonCommentToken;
    End;
end;

(**

  This method parses visual basic constants.

  @precon  None.
  @postcon Parses visual basic constants.

  @param   AScope as a TScope
  @param   C      as a TComment
  @return  a Boolean

**)
function TVBModule.ConditionalStatement: Boolean;
begin
  Result := False;
end;

Function TVBModule.Consts(AScope : TScope; C : TComment) : Boolean;

Var
  Con : TVBConstant;
  ConstantsLabel: TLabelContainer;

Begin
  Result := False;
  If Token.UToken = 'CONST' Then
    Begin
      Result := True;
      NextNonCommentToken;
      If Token.TokenType In [ttIdentifier] Then
        Begin
          Con := TVBConstant.Create(Token.Token, AScope, Token.Line, Token.Column,
            iiPublicConstant, C);
          ConstantsLabel := FindElement(strConstantsLabel) As TLabelContainer;
          If ConstantsLabel = Nil Then
            ConstantsLabel := Add(TLabelContainer.Create(strConstantsLabel, scNone, 0,
              0, iiPublicConstantsLabel, Nil)) As TLabelContainer;
          Con := ConstantsLabel.Add(Con) As TVBConstant;
          Con.Referenced := True;
          NextNonCommentToken;
          Con.Comment := C;
          If Token.UToken = 'AS' Then
            Begin
              AddToExpression(Con);
              QualifiedIdentifier(Con, [ttIdentifier, ttReservedWord, ttDirective]);
            End;
          If Token.Token = '=' Then
            Begin
              AddToExpression(Con);
              While Not (Token.TokenType In [ttReservedWord, ttLineEnd, ttFileEnd]) Do
                AddToExpression(Con);
            End Else
              ErrorAndSeekToken(strLiteralExpected, 'Consts', '=', strSeekTokens,
                stActual);
          If Token.TokenType In [ttLineEnd] then
            NextNonCommentToken
          Else
            ErrorAndSeekToken(strLineEndExpected, 'Consts', Token.Token,
              strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strIdentExpected, 'Consts', Token.Token,
            strSeekTokens, stActual);
    End;
End;

(**

  This method processes DIM statements.

  @precon  None.
  @postcon Processes DIM statements.

  @param   AScope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Dims(AScope : TScope; C : TComment) : Boolean;

Begin
  Result := False;
  If IsKeyWord(Token.Token, ['dim']) Then
    Begin
      NextNonCommentToken;
      Result := Vars(AScope, C);
      If Not Result Then
        RollBackToken
    End;
End;

(**

  This method processes the declare statement.

  @precon  None.
  @postcon Processes the declare statement.

  @param   AScope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Declares(AScope : TScope; C: TComment) : Boolean;

Var
  R : Boolean;
  DeclaresLabel: TLabelContainer;

begin
  Result := False;
  If Token.UToken = 'DECLARE' Then
    Begin
      Result := True;
      NextNonCommentToken;
      DeclaresLabel := FindElement(strDeclaresLabel) As TLabelContainer;
      If DeclaresLabel = Nil Then
        DeclaresLabel := Add(TLabelContainer.Create(strDeclaresLabel,
          scNone, 0, 0, iiExportedHeadingsLabel, Nil)) As TLabelContainer;
      R := Subs(AScope, C, False, DeclaresLabel);
      If Not R Then
        R := Functions(AScope, C, False, DeclaresLabel);
      If Not R Then
        ErrorAndSeekToken(strReservedWordExpected, 'Declares', Token.Token,
          strSeekTokens, stActual);
    End;
end;

(**

  This method processes the properties statements.

  @precon  None.
  @postcon Processes the properties statements.

  @param   AScope as a TScope
  @param   C          as a TComment
  @param   boolStatic as a Boolean
  @return  a Boolean

**)
Function TVBModule.Props(AScope : TScope; C : TComment; boolStatic : Boolean) : Boolean;

Var
  pt : TPropertyType;
  P : TVBProperty;
  PropertiesLabel: TLabelContainer;
  T : TVBTypeDecl;

Begin
  Result := False;
  If Token.UToken = 'PROPERTY' Then
    Begin
      Result := True;
      NextNonCommentToken;
      pt := ptUnknown;
      If Token.UToken = 'GET' Then
        pt := ptGet
      Else If Token.UToken = 'SET' Then
        pt := ptSet
      Else If Token.UToken = 'LET' Then
        pt := ptLet
      Else
        ErrorAndSeekToken(strReservedWordExpected, 'Props',
          'GET, SET, or LET', strSeekTokens, stActual);
      If pt In [ptGet, ptLet, ptSet] Then
        Begin
          NextNonCommentToken;
          P := TVBProperty.Create(pt, Token.Token, AScope, Token.Line,
            Token.Column, iiPublicProperty, C);
          PropertiesLabel := FindElement(strImplementedPropertiesLabel) As TLabelContainer;
          If PropertiesLabel = Nil Then
            PropertiesLabel := Add(TLabelContainer.Create(strImplementedPropertiesLabel,
              scNone, 0, 0, iiPropertiesLabel, Nil)) As TLabelContainer;
          P := PropertiesLabel.Add(P) As TVBProperty;
          NextNonCommentToken;
          If Token.Token = '(' Then
            Begin
              NextNonCommentToken;
              If Token.Token <> ')' Then
                Parameters(P);
              If Token.Token = ')' Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLiteralExpected, 'Props',
                  ')', strSeekTokens, stActual);
              If Token.UToken = 'AS' Then
                Begin
                  NextNonCommentToken;
                  If Token.TokenType In [ttIdentifier, ttReservedWord] Then
                    Begin
                      T := TVBTypeDecl.Create(Token.Token, scNone, 0, 0, iiNone, Nil);
                      P.ReturnType.Add(T);
                      AddToExpression(T);
                    End;
                End;
              If Token.TokenType In [ttLineEnd] Then
                NextNonCommentToken
              Else
                ErrorAndSeekToken(strLineEndExpected, 'Props', Token.Token,
                  strSeekTokens, stActual);
              Block;
              CheckMethodEnd('PROPERTY');
            End Else
              ErrorAndSeekToken(strLiteralExpected, 'Props',
                '(', strSeekTokens, stActual);
        End;
  End;
End;

(**

  This method processes Type/Record declarations.

  @precon  None.
  @postcon Processes Type/Record declarations.

  @param   AScope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Records(AScope : TScope; C : TComment) : Boolean;

Var
  R : TVBRecordDecl;
  F : TVBField;
  T: TTokenInfo;
  Com: TComment;
  TypesLabel: TLabelContainer;

Begin
  Result := False;
  If Token.UToken = 'TYPE' Then
    Begin
      Result := True;
      NextNonCommentToken;
      If Token.TokenType In [ttIdentifier] Then
        Begin
          R := TVBRecordDecl.Create(Token.Token, AScope, Token.Line, Token.Column,
            iiPublicRecord, C);
          TypesLabel := FindElement(strTypesLabel) As TLabelContainer;
          If TypesLabel = Nil Then
            TypesLabel := Add(TLabelContainer.Create(strTypesLabel, scNone, 0, 0,
              iiPublicTypesLabel, Nil)) As TLabelContainer;
          R := TypesLabel.Add(R) As TVBRecordDecl;
          R.Comment := C;
          NextNonCommentToken;
          If Token.TokenType In [ttLineEnd] then
            Begin
              NextNonCommentToken;
              Repeat
                Begin
                  If Token.TokenType In [ttLineEnd] Then
                    NextNonCommentToken;
                  If Token.TokenType In [ttReservedWord, ttIdentifier] Then
                    Begin
                      T := Token;
                      Com := GetComment;
                      NextNonCommentToken;
                      If (PrevToken.UToken = 'END') And (Token.UToken = 'TYPE')  Then
                        Begin
                          RollBackToken;
                          Break;
                        End;
                      F := TVBField.Create(T.Token, scPublic, T.Line, T.Column,
                        iiPublicField, Com);
                      F := R.Add(F) As TVBField;
                      ProcessVar(F);
                      If Token.TokenType In [ttLineEnd] Then
                        NextNonCommentToken
                      Else
                        ErrorAndSeekToken(strLineEndExpected, 'Vars', Token.Token,
                          strSeekTokens, stActual);
                      {
                      If Token.UToken = 'AS' Then
                        Begin
                          NextNonCommentToken;
                          If Token.TokenType In [ttIdentifier, ttReservedWord] Then
                            Begin
                              AddToExpression(F);
                              If Token.TokenType In [ttLineEnd] then
                                NextNonCommentToken
                              Else
                                ErrorAndSeekToken(strLineEndExpected, 'Records',
                                  Token.Token, strSeekTokens, stActual);
                            End Else
                              ErrorAndSeekToken(strIdentExpected, 'Records',
                                Token.Token, strSeekTokens, stActual);
                        End Else
                          ErrorAndSeekToken(strLiteralExpected, 'Records',
                            'AS', strSeekTokens, stActual);
                      }
                    End Else
                      ErrorAndSeekToken(strIdentExpected, 'Records',
                        Token.Token, strSeekTokens, stActual);
                End;
              Until False;
            End Else
              ErrorAndSeekToken(strLineEndExpected, 'Records', Token.Token,
                strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strIdentExpected, 'Records',
            Token.Token, strSeekTokens, stActual);
      NextNonCommentToken;
      If Token.UToken = 'TYPE' Then
        Begin
          NextNonCommentToken;
          If Token.TokenType In [ttLineEnd] then
            NextNonCommentToken
          Else
            ErrorAndSeekToken(strLineEndExpected, 'Records', Token.Token,
              strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strReservedWordExpected, 'Records', 'TYPE',
            strSeekTokens, stActual);
    End;
End;

(**

  This method refernces symbols found in the code with respect to the variables,
  constants and types.

  @precon  None.
  @postcon Refernces symbols found in the code with respect to the variables,
           constants and types.

  @param   AToken as a TTokenInfo
  @return  a Boolean

**)
function TVBModule.ReferenceSymbol(AToken: TTokenInfo): Boolean;

  (**

    This function checks the given element for an occurrance of the token.

    @precon  None.
    @postcon Marks the element item as referenced is the token is found.

    @param   Section as a TElementContainer
    @return  a Boolean

  **)
  Function CheckElement(Section : TElementContainer) : Boolean;

  Var
    boolFound: Boolean;
    i: Integer;

  Begin
    // Check Module Local Methods, Properties, Declares, ...
    boolFound := False;
    If Section <> Nil Then
      For i := 1 To Section.ElementCount Do
        If CompareText(Section[i].Identifier, AToken.Token) = 0 Then
          Begin
            Section[i].Referenced := True;
            AToken.Reference := trResolved;
            boolFound := True;
          End;
    Result := boolFound;
    If Result Then
      Exit;
  End;

begin
  Result := ReferenceSection(AToken, FindElement(strVarsLabel) As TLabelContainer);
  If Result Then
    Exit;
  Result := ReferenceSection(AToken, FindElement(strConstantsLabel) As TLabelContainer);
  If Result Then
    Exit;
  Result := ReferenceSection(AToken, FindElement(strTypesLabel) As TLabelContainer);
  If Result Then
    Exit;
  Result := CheckElement(FindElement(strImplementedMethodsLabel) As TLabelContainer);
  If Result Then
    Exit;
  Result := CheckElement(FindElement(strImplementedPropertiesLabel) As TLabelContainer);
  If Result Then
    Exit;
  Result := CheckElement(FindElement(strDeclaresLabel) As TLabelContainer);
  If Result Then
    Exit;
end;

Procedure TVBModule.CheckMethodEnd(strEndKeyWord : String);

Begin
  If Token.UToken = 'END' Then
    Begin
      NextNonCommentToken;
      If Token.UToken = strEndKeyWord Then
        Begin
          NextNonCommentToken;
          If Token.TokenType In [ttLineEnd] Then
            NextNonCommentToken
          Else
            ErrorAndSeekToken(strLineEndExpected, 'CheckMethodEnd', Token.Token,
              strSeekTokens, stActual);
        End
      Else
        ErrorAndSeekToken(strReservedWordExpected, 'CheckMethodEnd', strEndKeyWord,
          strSeekTokens, stActual);
    End
  Else
    ErrorAndSeekToken(strReservedWordExpected, 'CheckMethodEnd', 'END', strSeekTokens,
      stActual);
End;

(**

  This method checks the references and removes event handler from being shown.

  @precon  None.
  @postcon Checks the references and removes event handler from being shown.

**)
procedure TVBModule.PatchAndCheckReferences;

  (**

    This method returns true if the identifier contains an underscore.

    @precon  None.
    @postcon Returns true if the identifier contains an underscore.

    @param   strIdentifier as a String
    @return  a Boolean

  **)
  Function IsEventHandler(strIdentifier : String) : Boolean;

  Var
    i: Integer;

  Begin
    Result := False;
    For i := 0 To FEventHandlerPatterns.Count - 1 Do
      Begin
        Result := Result Or Like(FEventHandlerPatterns[i], strIdentifier);
        If Result Then
          Break;
      End;
  End;

Var
  j: Integer;
  I: TElementContainer;

begin
  If FindElement(strErrors).ElementCount = 0 Then
    Begin
      I := FindElement(strImplementedMethodsLabel);
      If I <> Nil Then
        Begin
          For j := 1 To I.ElementCount Do
            If Not I[j].Referenced Then
              I[j].Referenced := IsEventHandler(I[j].Identifier);
        End;
      CheckReferences;
    End;
end;

(**

  This method checks the exception handling for the given function and it`s
  exception handler.

  @precon  M and ExceptionHandler must be valid instances.
  @postcon Checks the exception handling for the given function and it`s
           exception handler and outputs an issue IF something is missing.

  @param   M                as a TGenericFunction
  @param   ExceptionHandler as an IExceptionHandling

**)
procedure TVBModule.CheckElementExceptionHandling(M: TGenericFunction;
  ExceptionHandler : IExceptionHandling);

var
  boolNoTag: Boolean;
  i: Integer;
  iIndex : Integer;

begin
  // Check Exception Push and Pop
  boolNoTag :=
    (Comment <> Nil) And (Comment.FindTag('noexception') > -1) Or
    (M.Comment <> Nil) And (M.Comment.FindTag('noexception') > -1);
  If Not ExceptionHandler.HasPush And Not boolNoTag Then
    AddIssue(Format(strExceptionPush, [M.Identifier]), scNone,
     'CheckExceptionHandling', M.Line, M.Column, etWarning);
  If (ExceptionHandler.PushName = '') And Not boolNoTag Then
    AddIssue(Format(strExceptionPushName, [M.Identifier]), scNone,
    'CheckExceptionHandling', M.Line, M.Column, etWarning);
  If Not boolNoTag Then
    If CompareText(Format('"%s.%s"', [ModuleName, M.Identifier]),
      ExceptionHandler.PushName) <> 0 Then
      AddIssue(Format(strExceptionPushNameIncorrect,
        [ExceptionHandler.PushName, ModuleName, M.Identifier]), scNone,
        'CheckExceptionHandling', M.Line, M.Column, etWarning);
  If Not ExceptionHandler.HasPop And Not boolNoTag Then
    AddIssue(Format(strExceptionPop, [M.Identifier]), scNone,
      'CheckExceptionHandling', M.Line, M.Column, etWarning);
  // Check Exception Parameters
  boolNoTag :=
    (Comment <> Nil) And (Comment.FindTag('noexception') > -1) Or
    (M.Comment <> Nil) And (M.Comment.FindTag('noexception') > -1) Or
    (M.Comment <> Nil) And (M.Comment.FindTag('noexceptionparams') > -1);
  If Not boolNoTag Then
    For i := 0 To M.ParameterCount - 1 Do
      Begin
        iIndex := ExceptionHandler.PushParams.IndexOf(M.Parameters[i].Identifier);
        If iIndex = -1 Then
          AddIssue(Format(strExceptionPushParameter, [M.Parameters[i].Identifier,
            ModuleName, M.Identifier]), scNone, 'CheckExceptionHandling', M.Line,
            M.Column, etWarning)
        Else if iIndex <> i Then
          AddIssue(Format(strExceptionPushParamPos, [M.Parameters[i].Identifier,
            ModuleName, M.Identifier, i, iIndex]), scNone, 'CheckExceptionHandling', M.Line,
            M.Column, etWarning);
      End;
  If Not boolNoTag Then
    If M.ParameterCount <> ExceptionHandler.PushParams.Count Then
      AddIssue(Format(strExceptionPushParamCount, [ModuleName, M.Identifier,
        M.ParameterCount, ExceptionHandler.PushParams.Count]), scNone,
        'CheckExceptionHandling', M.Line, M.Column, etWarning);
  // Check Error Handling
  boolNoTag :=
    (Comment <> Nil) And (Comment.FindTag('noerror') > -1) Or
    (M.Comment <> Nil) And (M.Comment.FindTag('noerror') > -1);
  If Not ExceptionHandler.HasErrorHnd And Not boolNoTag Then
    AddIssue(Format(strErrorHandling, [M.Identifier]), scNone,
      'CheckExceptionHandling', M.Line, M.Column, etWarning);
  If ExceptionHandler.HasExit And ExceptionHandler.HasErrorHnd And Not boolNoTag Then
    AddIssue(Format(strExitStatement, [M.Identifier]), scNone,
      'CheckExceptionHandling', ExceptionHandler.ExitLine,
      ExceptionHandler.ExitCol, etWarning);
end;

(**

  This method tries to resolved the references for the symbols left over in
  FUnResolvedSymbols as they could be forward referenced at the time of the
  original check.

  @precon  None.
  @postcon Tries to resolved the references for the symbols left over in
           FUnResolvedSymbols as they could be forward referenced at the time
           of the original check.

**)
procedure TVBModule.ResolvedForwardReferences;

var
  i: Integer;
  T : TTokenInfo;

begin
  For i := 0 To FUnResolvedSymbols.Count - 1 Do
    Begin
      T := TTokenInfo.Create(FUnResolvedSymbols[i], 0, 0, 0, 0, ttIdentifier);
      Try
        ReferenceSymbol(T)
      Finally
        T.Free;
      End;
    End;
end;

(**

  This method processes a variable declaration on a line.

  @precon  Variable must be a value instance of a previous created variable
           descendant.
  @postcon Processes a variable declaration on a line.

  @param   Variable as a TVBVar

**)
procedure TVBModule.ProcessVar(Variable: TVBVar);

begin
  If Token.Token = '(' Then
    Begin
      NextNonCommentToken;
      If Token.Token <> ')' Then
        Begin
          ArraySizeDecl(Variable);
          If Token.Token = ')' Then
            NextNonCommentToken
          Else
            ErrorAndSeekToken(strLiteralExpected, 'ProcessVar', Token.Token,
              strSeekTokens, stActual);
        End Else
        Begin
          Variable.AddDimension('', '');
          NextNonCommentToken;
        End;
    End;
  If Token.UToken = 'AS' then
    begin
      NextNonCommentToken;
      if Token.UToken = 'NEW' then
        AddToExpression(Variable);
      QualifiedIdentifier(Variable, [ttIdentifier, ttReservedWord]);
      {
          if (PrevToken.UToken = 'STRING') and (Token.Token = '*') then
            begin
              AddToExpression(Variable);
              if Token.TokenType in [ttNumber] then
                AddToExpression(Variable)
              else
                ErrorAndSeekToken(strNumberExpected, 'ProcessVar', Token.Token,
                  strSeekTokens, stActual);
            end;
      }
    end;
end;

(**

  This method parses the ArraySizeDecl element of the grammar.

  @precon  Variable must be a valid instance.
  @postcon Parses the ArraySizeDecl element of the grammar.

  @param   Variable as a TVBVar

**)
function TVBModule.ArrayHandlingStatement: Boolean;
begin
  Result := False;
end;

Procedure TVBModule.ArraySizeDecl(Variable: TVBVar);

var
  strHigh: string;
  strLow: string;

Begin
  Repeat
    If Token.TokenType In [ttIdentifier, ttNumber] Then
      Begin
        strLow := '0';
        strHigh := Token.Token;
        NextNonCommentToken;
        If Token.UToken = 'TO' Then
          Begin
            NextNonCommentToken;
            If Token.TokenType In [ttIdentifier, ttNumber] Then
              Begin
                strLow := strHigh;
                strHigh := Token.Token;
                NextNonCommentToken;
              End Else
                ErrorAndSeekToken(strNumberExpected, 'Vars', Token.Token, strSeekTokens, stActual);
          End;
        Variable.AddDimension(strLow, strHigh);
      End Else
        ErrorAndSeekToken(strNumberExpected, 'Vars', Token.Token, strSeekTokens, stActual);
  Until Not IsToken(',', Nil);
End;

(**

  This method processes Enumerate declarations.

  @precon  None.
  @postcon Processes Enumerate declarations.

  @param   AScope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Enum(AScope : TScope; C: TComment) : Boolean;

Var
  E : TVBEnumerateDecl;
  I : TVBEnumIdent;
  TypesLabel: TLabelContainer;

Begin
  Result := False;
  If Token.UToken = 'ENUM' Then
    Begin
      Result := True;
      NextNonCommentToken;
      If Token.TokenType = ttIdentifier Then
        Begin
          E := TVBEnumerateDecl.Create(Token.Token, AScope, Token.Line,
            Token.Column, iiPublicType, C);
          TypesLabel := FindElement(strTypesLabel) As TLabelContainer;
          If TypesLabel = Nil Then
            TypesLabel := Add(TLabelContainer.Create(strTypesLabel, scNone, 0, 0,
              iiPublicTypesLabel, Nil)) As TLabelContainer;
          E := TypesLabel.Add(E) As TVBEnumerateDecl;
          E.Comment := C;
          NextNonCommentToken;
          If Token.TokenType In [ttLineEnd] then
            Begin
              NextNonCommentToken;
              While Token.UToken <> 'END' Do
                Begin
                  If Token.TokenType In [ttIdentifier] Then
                    Begin
                      I := TVBEnumIdent.Create(Token.Token, scNone, Token.Line,
                        Token.Column, iiPublicField, GetComment);
                      I := E.Add(I) As TVBEnumIdent;
                      NextNonCommentToken;
                      If Token.Token = '=' Then
                        Begin
                          NextNonCommentToken;
                          If Token.TokenType In [ttNumber] Then
                            Begin
                              AddToExpression(I);
                            End Else
                              ErrorAndSeekToken(strNumberExpected, 'Enums',
                                Token.Token, strSeekTokens, stActual);
                        End;
                      If Token.TokenType In [ttLineEnd] then
                        NextNonCommentToken
                      Else
                        ErrorAndSeekToken(strLineEndExpected, 'Enums',
                          Token.Token, strSeekTokens, stActual);
                    End Else
                      ErrorAndSeekToken(strIdentExpected, 'Enums',
                        Token.Token, strSeekTokens, stActual);
                End;
            End Else
              ErrorAndSeekToken(strLineEndExpected, 'Enums', Token.Token,
                strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strIdentExpected, 'Enums',
            Token.Token, strSeekTokens, stActual);
      NextNonCommentToken;
      If Token.UToken = 'ENUM' Then
        Begin
          NextNonCommentToken;
          If Token.TokenType In [ttLineEnd] then
            NextNonCommentToken
          Else
            ErrorAndSeekToken(strLineEndExpected, 'Enums', Token.Token,
              strSeekTokens, stActual);
        End Else
          ErrorAndSeekToken(strReservedWordExpected, 'Enums', 'Enum',
            strSeekTokens, stActual);
    End;
end;

function TVBModule.ErrorHandlingStatement: Boolean;
begin
  Result := False;
end;

function TVBModule.EventStatement: Boolean;
begin
  Result := False;
end;

(**

  This method parses a optionally Qualified identifier and adds the qualifier to
  the given container as well as returning the qualified identifier in the
  resultant string.

  @precon  None.
  @postcon Parses a optionally Qualified identifier and adds the qualifier to
           the given container as well as returning the qualified identifier in
           the resultant string.

  @param   Container  as a TElementContainer
  @param   TokenTypes as a TBADITokenTypes
  @return  a String

**)
Function TVBModule.QualifiedIdentifier(Container : TElementContainer;
  TokenTypes : TBADITokenTypes) : String;

Begin
  Result := '';
  Repeat
    If Token.TokenType In TokenTypes Then
      Begin
        If Result <> '' Then
          Result := Result + '.';
        Result := Result + Token.Token;
        AddToExpression(Container);
      End Else
        ErrorAndSeekToken(strIdentExpected, 'QualifiedIdentifier', Token.Token,
          strSeekTokens, stActual);
  Until Not IsToken('.', Container);
End;

(**

  This method checks the documentation of the field and outputs a documentation
  conflict IF the options ask for one and it the documentation is missing.

  @precon  None.
  @postcon Checks the documentation of the field and outputs a documentation
           conflict IF the options ask for one and it the documentation is
           missing.

  @param   boolCascade as a Boolean as a reference

**)
procedure TVBField.CheckDocumentation(var boolCascade: Boolean);
begin
  If doShowUndocumentedFields In TBADIOptions.BADIOptions.Options Then
    If ((Comment = Nil) Or (Comment.TokenCount = 0)) And (Scope <> scLocal) Then
      AddDocumentConflict([Identifier], Line, Column, Comment,
        strVariableDocumentation, DocConflictTable[dctFieldClauseUndocumented]);
end;

End.
