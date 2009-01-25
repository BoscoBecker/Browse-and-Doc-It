(**

  This module contains code to parser VB/VBA code (and perhaps will be extended
  to parser VB.NET code later).

  @Version    1.0
  @Date       25 Jan 2009
  @Author     David Hoyle

**)
Unit VBModule;

Interface

Uses
  SysUtils, Classes, Contnrs, Controls, BaseLanguageModule;

{$INCLUDE CompilerDefinitions.Inc}

Type
  (** An imlpementation for visual basic comments. **)
  TVBComment = Class(TComment)
  Public
    Class Function CreateComment(strComment: String; iLine,
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

  (** A class to represent method (SUB & FUNCTION) in visual basic. **)
  TVBMethod = Class(TGenericMethodDecl)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FHasPush : Boolean;
    FHasPop : Boolean;
    FPushName : String;
    FPushParams : TStringList;
    FHasErrorHnd : Boolean;
    FHasExit : Boolean;
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Constructor Create(MethodType : TMethodType; strName : String;
      AScope : TScope; iLine, iCol : Integer); Override;
    Destructor Destroy; Override;
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    (**
      This property determine if the method has a Exception.Push handler.
      @precon  None.
      @postcon Determine if the method has a Exception.Push handler.
      @return  a Boolean
    **)
    Property HasPush : Boolean Read FHasPush Write FHasPush;
    (**
      This property determine if the method has a Exception.Pop handler.
      @precon  None.
      @postcon Determine if the method has a Exception.Pop handler.
      @return  a Boolean
    **)
    Property HasPop  : Boolean Read FHasPop  Write FHasPop;
    (**
      This property returns the name of the pushed method.
      @precon  None.
      @postcon Returns the name of the pushed method.
      @return  a String
    **)
    Property PushName : String Read FPushName Write FPushName;
    (**
      This property returns a string list of the methods parameters.
      @precon  None.
      @postcon Returns a string list of the methods parameters.
      @return  a TStringList
    **)
    Property PushParams : TStringList Read FPushParams;
    (**
      This property determines if the method has an error handler.
      @precon  None.
      @postcon Determines if the method has an error handler.
      @return  a Boolean
    **)
    Property HasErrorHnd : Boolean Read FHasErrorHnd Write FHasErrorHnd;
    (**
      This property determines if the method has an exit statement.
      @precon  None.
      @postcon Determines if the method has an exit statement.
      @return  a Boolean
    **)
    Property HasExit : Boolean Read FHasExit Write FHasExit;
  End;

  (** A class to represent constants in visual basic. **)
  TVBConstant = Class(TGenericConstant)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A type to define at upper and lower limits of an array. **)
  TArrayDimensions = Array[1..2] Of Integer;

  (** A class to represent variables in visual basic. **)
  TVBVar = Class(TGenericVariable)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FDimensions, T : Array Of TArrayDimensions;
    FWithEvents : Boolean;
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Function GetDimensions : Integer;
  Public
    Constructor Create(strName : String; AScope : TScope; iLine,
      iColumn : Integer; AImageIndex : TImageIndex; AComment : TComment); Override;
    Destructor Destroy; Override;
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    Procedure AddDimension(iLow, iHigh : Integer);
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
  TVBProperty = Class(TVBMethod)
  {$IFDEF D2005} Strict {$ENDIF} Private
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Constructor Create(PropertyType : TPropertyType; strName : String;
      AScope : TScope; iLine, iCol : Integer); Reintroduce; Virtual;
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    Procedure CheckDocumentation(var boolCascade : Boolean); Override;
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
  TVBField = Class(TElementContainer)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (** A class to represent VB Enumerate Value  **)
  TVBEnumIdent = Class(TElementContainer)
  {$IFDEF D2005} Strict {$ENDIF} Protected
  Public
    Function AsString(boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
  End;

  (**

    This is the main class for dealing with object pascal units and program
    source files. It creates and manages instances of the other classes as
    needed.

  **)
  TVBModule = Class(TBaseLanguageModule)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FTypesLabel: TLabelContainer;
    FConstantsLabel: TLabelContainer;
    FResourceStringsLabel: TLabelContainer;
    FVariablesLabel: TLabelContainer;
    FThreadVarsLabel: TLabelContainer;
    FImplementedMethodsLabel: TLabelContainer;
    FDeclaredMethodsLabel: TLabelContainer;
    FImplementedPropertiesLabel: TLabelContainer;
    FAttributesLabel: TLabelContainer;
    FOptionsLabel: TLabelContainer;
    FSourceStream: TStream;
    FModuleType : TModuleType;
    Procedure TokenizeStream;
    { Grammer Parsers }
    Procedure Goal;
    Function  Version : Boolean;
    procedure VBBegin(C : TElementContainer);
    Function  Attributes : Boolean;
    Procedure Attribute(C : TElementContainer);
    Function  Options : Boolean;
    Function  Declarations : Boolean;
    Function  Privates(C : TComment) : Boolean;
    Function  Publics(C : TComment) : Boolean;
    Function  Consts(Scope : TScope; C : TComment) : Boolean;
    Function  Dims(Scope : TScope; C : TComment) : Boolean;
    Function  Subs(Scope : TScope; C : TComment; boolStatic : Boolean;
      DeclareLabel : TLabelContainer) : Boolean;
    Function  Functions(Scope : TScope; C : TComment; boolStatic : Boolean;
      DeclareLabel : TLabelContainer) : Boolean;
    Function  Declares(Scope : TScope; C: TComment) : Boolean;
    Function  Friends(C: TComment) : Boolean;
    Function  Props(Scope : TScope; C : TComment; boolStatic : Boolean) : Boolean;
    Function  Records(Scope : TScope; C : TComment) : Boolean;
    Function  Enum(Scope : TScope; C: TComment) : Boolean;
    Procedure Parameters(Method : TGenericMethodDecl);
    Procedure MethodDecl(M : TGenericMethodDecl; C : TComment);
    Procedure FindMethodEnd(Method : TVBMethod; strMethodType : String);
    Function Vars(Scope : TScope; C : TComment) : Boolean;
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Procedure ProcessCompilerDirective(var iSkip : Integer); Override;
    procedure TidyUpEmptyElements;
    Function GetComment(
      CommentPosition : TCommentPosition = cpBeforeCurrentToken) : TComment;
      Override;
    Procedure NextNonCommentToken; Override;
    Procedure CheckExceptionHandling;
  Public
    Constructor CreateParser(Source : TStream; strFileName : String;
      IsModified : Boolean; ModuleOptions : TModuleOptions); Override;
    Destructor Destroy; Override;
    Function KeyWords : TKeyWords; Override;
    { Properties }
  End;

ResourceString
  (** A label for versions. **)
  strVersionLabel = 'Version';
  (** A label for attributes **)
  strAttributesLabel = 'Attributes';
  (** A label for options. **)
  strOptionsLabel = 'Options';
  (** A label for declared functions and procedures. **)
  strDeclaresLabel = 'Declarations';

Implementation

Uses
  Windows;

Const
  (** A set of characters for alpha characaters **)
  strTokenChars : Set Of Char = ['_', 'a'..'z', 'A'..'Z'];
  (** A set of numbers **)
  strNumbers : Set Of Char = ['&', '0'..'9'];
  (** A set of characters for general symbols **)
  strSymbols : Set Of Char = ['&', '(', ')', '*', '+',
    ',', '-', '.', '/', ':', ';', '<', '=', '>', '@', '[', ']', '^', '{', '}'];
  (** A set of characters for quotes **)
  strQuote : Set Of Char = ['"'];
  (**
    A sorted list of keywords. Used for identifying tokens as keyword.

    This key words nil and string have been disables as there are used like
    identifiers and as types.

  **)
  strReservedWords : Array[1..139] Of String = (
    'addhandler', 'addressof', 'andalso', 'alias', 'and', 'ansi', 'as', 'assembly',
    'auto', 'base', 'boolean', 'byref', 'byte', 'byval', 'call', 'case', 'catch',
    'cbool', 'cbyte', 'cchar', 'cdate', 'cdec', 'cdbl', 'char', 'cint', 'class',
    'clng', 'cobj', 'compare', 'const', 'cshort', 'csng', 'cstr', 'ctype', 'date',
    'decimal', 'declare', 'default', 'delegate', 'dim', 'directcast', 'do', 'double',
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
  strDirectives : Array[1..2] Of String = (
    'false', 'true'
  );

  (** A set of token to be searched for after an error. **)
  strSeekTokens : Array[1..6] Of String = (
    'const', 'dim', 'function', 'private', 'public', 'sub'
  );

  (** A constant array of method names. **)
  strMethodType : Array[Low(TMethodType)..High(TMethodType)] Of String = (
    '', '', 'Sub', 'Function'
  );

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
  (** A warning message for no pop method. **)
  strExceptionPop = 'The method ''%s'' has no Exception.Pop method.';
  (** A warning message for no error handling. **)
  strErrorHandling = 'The method ''%s'' has no error handling.';
  (** A warning message for an exit statement and error handling. **)
  strExitStatement = 'The method ''%s'' has an Exit statement which may be i' +
    'n conflict with the error handling.';

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
class function TVBComment.CreateComment(strComment: String; iLine,
  iCol: Integer): TComment;
begin
  Result := Inherited Create(StringReplace(strComment, '''', '', [rfReplaceAll]),
    iLine, iCol);
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
constructor TVBMethod.Create(MethodType: TMethodType; strName: String;
  AScope: TScope; iLine, iCol: Integer);
begin
  inherited;
  FPushParams := TStringList.Create;
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
  If (MethodType = mtFunction) And (ReturnType <> Nil) Then
    Begin
      Result := Result + #32'As'#32 + ReturnType.AsString(boolShowIdentifier,
        boolForDocumentation);
    End;
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
  Result := BuildStringRepresentation(boolShowIdentifier, boolForDocumentation, 'As',
    BrowseAndDocItOptions.MaxDocOutputWidth);
End;

{ TVBVar }

(**

  This method adds an array dimension to the varaiable declaration.

  @precon  None.
  @postcon Adds an array dimension to the varaiable declaration.

  @param   iLow  as an Integer
  @param   iHigh as an Integer

**)
procedure TVBVar.AddDimension(iLow, iHigh: Integer);

Var
  i : Integer;

begin
  T := Nil;
  If FDimensions = Nil Then
    Begin
      SetLength(FDimensions, 1);
      FDimensions[0][1] := iLow;
      FDimensions[0][2] := iHigh;
    End Else
    Begin
      T := Copy(FDimensions);
      SetLength(FDimensions, Succ(Succ(High(FDimensions))));
      For i := Low(T) To High(T) Do
        FDimensions[i] := T[i];
      FDimensions[High(FDimensions)][1] := iLow;
      FDimensions[High(FDimensions)][2] := iHigh;
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
          If FDimensions[i][1] > -1 Then
            Result := Result + Format('%d to %d', [FDimensions[i][1],
              FDimensions[i][2]]);
        End;
      Result := Result + ')';
    End;
  Result := Result + BuildStringRepresentation(False,
    boolForDocumentation, 'As', BrowseAndDocItOptions.MaxDocOutputWidth);
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
Constructor TVBVar.Create(strName : String; AScope : TScope; iLine,
  iColumn : Integer; AImageIndex : TImageIndex; AComment : TComment);

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
  Case MethodType Of
    mtFunction: Result := Result + 'Get ';
    mtProcedure: Result := Result + 'Let ';
    mtConstructor: Result := Result + 'Set ';
  End;
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
  If (MethodType = mtFunction) And (ReturnType <> Nil) Then
    Begin
      Result := Result + #32'As'#32 + ReturnType.AsString(boolShowIdentifier,
        boolForDocumentation);
    End;
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
  If MethodType In [mtFunction] Then
    Begin
       If ReturnType = Nil Then
         AddIssue(Format(strProperyRequiresReturn, [Identifier]), scNone,
           'CheckDocumentation', Line, Column, etError);
    End Else
    Begin
       If ParamCount = 0 Then
         AddIssue(Format(strProperyRequireParam, [Identifier]), scNone,
           'CheckDocumentation', Line, Column, etError);
    End;
end;

(**

  This is a constructor for the TVBProperty class.

  @precon  None.
  @postcon Maps the property type to an internal method type + creates a string
           list for pushed parameters.

  @param   PropertyType as a TPropertyType
  @param   strName      as a String
  @param   AScope       as a TScope
  @param   iLine        as an Integer
  @param   iCol         as an Integer

**)
constructor TVBProperty.Create(PropertyType: TPropertyType; strName: String;
  AScope: TScope; iLine, iCol: Integer);

Var
  MT : TMethodType;

begin
  Case PropertyType Of
    ptGet: MT := mtFunction;
    ptLet: MT := mtProcedure;
    ptSet: MT := mtConstructor;
  Else
    MT := mtFunction;
  End;
  Inherited Create(MT, strName, AScope, iLine, iCol);
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
  Result := BuildStringRepresentation(False, boolForDocumentation, '',
   BrowseAndDocItOptions.MaxDocOutputWidth);
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
    '=', BrowseAndDocItOptions.MaxDocOutputWidth);
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
    '', BrowseAndDocItOptions.MaxDocOutputWidth);
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
    '', BrowseAndDocItOptions.MaxDocOutputWidth);
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
    'As', BrowseAndDocItOptions.MaxDocOutputWidth);
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
    BrowseAndDocItOptions.MaxDocOutputWidth);
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

  @param   Source        as a TStream
  @param   strFileName   as a String
  @param   IsModified    as a Boolean
  @param   ModuleOptions as a TModuleOptions

**)
Constructor TVBModule.CreateParser(Source : TStream; strFileName : String;
  IsModified : Boolean; ModuleOptions : TModuleOptions);

var
  boolCascade: Boolean;

Begin
  Inherited CreateParser(Source, strFileName, IsModified, ModuleOptions);
  FTypesLabel                 := Nil;
  FConstantsLabel             := Nil;
  FResourceStringsLabel       := Nil;
  FVariablesLabel             := Nil;
  FThreadVarsLabel            := Nil;
  FImplementedMethodsLabel    := Nil;
  FImplementedPropertiesLabel := Nil;
  FDeclaredMethodsLabel       := Nil;
  FAttributesLabel            := Nil;
  FOptionsLabel               := Nil;
  CompilerDefines.Assign(BrowseAndDocItOptions.Defines);
  FSourceStream := Source;
  AddTickCount('Start');
  CommentClass := TVBComment;
  If AnsiCompareText(ExtractFileExt(FileName), '.cls') = 0 Then
    FModuleType := mtClass
  Else If AnsiCompareText(ExtractFileExt(FileName), '.frm') = 0 Then
    FModuleType := mtForm
  Else
    FModuleType := mtModule;
  TokenizeStream;
  AddTickCount('Tokenize');
  If moParse In ModuleOptions Then
    Begin
      Goal;
      AddTickCount('Parse');
      AddTickCount('Resolve');
      Add(strErrors, iiErrorFolder, scNone, Nil);
      Add(strWarnings, iiWarningFolder, scNone, Nil);
      Add(strHints, iiHintFolder, scNone, Nil);
      Add(strDocumentationConflicts, iiDocConflictFolder, scNone, Nil);
      If FindElement(strErrors).ElementCount = 0 Then
        CheckReferences;
      AddTickCount('Refs');
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
  Inherited Destroy;
End;

(**


  This method returns an array of key words for use in the explorer module.

  @precon  None.
  @postcon Returns an array of key words for use in the explorer module.

  @return  a TKeyWords

**)
function TVBModule.KeyWords: TKeyWords;

Var
  i, j : Integer;
  str : String;

begin
  SetLength(Result, Succ(High(strReservedWords)) + Succ(High(strDirectives)));
  For i := Low(strReservedWords) To High(strReservedWords) Do
    Result[i] := strReservedWords[i];
  For i := Low(strDirectives) To High(strDirectives) Do
    Result[High(strReservedWords) + i] := strDirectives[i];
  For i := Low(Result) To Pred(High(Result)) Do
    For j := i + 1 To High(Result) Do
      If Result[i] > Result[j] Then
        Begin
          str := Result[i];
          Result[i] := Result[j];
          Result[j] := str;
        End;
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
  boolEOF : Boolean;
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

Begin
  BlockType := btNoBlock;
  iStreamPos := 0;
  iTokenLine := 1;
  iTokenColumn := 1;
  boolEOF := False;
  CurCharType := ttUnknown;
  LastToken := ttUnknown;
  iStreamCount := 0;
  iLine := 1;
  iColumn := 1;
  Ch := #0;
  strToken := '';
  
  iTokenLen := 0;
  SetLength(strToken, iTokenCapacity);
  
  If FSourceStream <> Nil Then
    Begin
      Repeat
        If FSourceStream.Read(ch, 1) > 0 Then
          Begin
            Inc(iStreamCount);
            LastToken := CurCharType;

            If ch In strWhiteSpace Then
              CurCharType := ttWhiteSpace
            Else If ch In strTokenChars Then
              Begin
                If (LastToken = ttNumber) And (Ch In ['A'..'F', 'H', 'a'..'f', 'h']) Then
                  CurCharType := ttNumber
                Else
                  If Not (LastToken In [ttIdentifier]) And (Ch In ['_']) Then
                    CurCharType := ttLineContinuation
                  Else
                    CurCharType := ttIdentifier;
              End
            Else If ch In strNumbers Then
              Begin
                CurCharType := ttNumber;
                If LastToken = ttIdentifier Then
                  CurCharType := ttIdentifier;
              End
            Else If ch In strLineEnd Then
              CurCharType := ttLineEnd
            Else If ch In strQuote Then
              CurCharType := ttStringLiteral
            Else If ch In strSymbols Then
              Begin
                CurCharType := ttSymbol;
                If (Ch = '.') And (LastToken = ttNumber) Then
                  CurCharType := ttNumber;
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
                      If Not (strToken[1] In strWhiteSpace) Then
                        Begin
                          If LastToken = ttIdentifier Then
                            Begin
                              If IsKeyWord(strToken, strReservedWords) Then
                                LastToken := ttReservedWord;
                              If IsKeyWord(strToken, strDirectives) Then
                                LastToken := ttDirective;
                            End;
                          If BlockType = btLineComment Then
                            LastToken := ttComment;
                          If (LastToken = ttComment) And (Length(strToken) > 2) Then
                            If (strToken[1] = '{') And (strToken[2] = '$') Then
                              LastToken := ttCompilerDirective;
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
            If CurCharType = ttStringLiteral Then
              If BlockType = btStringLiteral Then
                BlockType := btNoBlock
              Else If BlockType = btNoBlock Then
                BlockType := btStringLiteral;

              // Check for block Comments
              If (BlockType = btNoBlock) And (Ch = '{') Then
                Begin
                  CurCharType := ttComment;
                  BlockType := btBraceComment;
                End;
              If (BlockType = btBraceComment) And (Ch = '}') Then
                Begin
                  CurCharType := ttComment;
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
          End Else
            boolEOF := True;
      Until boolEOF;
      If iTokenLen > 0 Then
        Begin
          SetLength(strToken, iTokenLen);
          If iTokenLen > 0 Then
            If Not (strToken[1] In strWhiteSpace) Then
              Begin
                If LastToken = ttIdentifier Then
                  Begin
                    If IsKeyWord(strToken, strReservedWords) Then
                      LastToken := ttReservedWord;
                    If IsKeyWord(strToken, strDirectives) Then
                      LastToken := ttDirective;
                  End;
                AddToken(TTokenInfo.Create(strToken, iStreamPos,
                  iTokenLine, iTokenColumn, Length(strToken), LastToken));
              End;
        End;
      AddToken(TTokenInfo.Create('', iStreamPos, iTokenLine, iTokenColumn, 0,
        ttFileEnd));
    End;
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

begin
  Result := Nil;
  iLine := 0;
  iColumn := 0;
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
      iLine := T.Line;
      iColumn := T.Column;
      If T.TokenType = ttComment Then
        Begin
          If strComment <> '' Then strComment := #13#10 + strComment;
          strComment := T.Token + strComment;
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
  Methods : Array[1..4] Of Function : Boolean Of Object;

begin
  Try
    While Token.TokenType In [ttComment, ttLineEnd] Do
      NextNonCommentToken;
    Methods[1] := Version;
    Methods[2] := Attributes;
    Methods[3] := Options;
    Methods[4] := Declarations;
    For iMethod := Low(Methods) To High(Methods) Do
      If  Not EndOfTokens Then
        Begin
          If Comment = Nil Then
            Comment := GetComment;
          If Methods[iMethod] Then
            While Not EndOfTokens And (Token.TokenType In [ttLineEnd]) Do
              NextNonCommentToken;
        End;
  Except
    On E : EParserAbort Do
      AddIssue(E.Message, scNone, 'Goal', 0, 0, etError);
  End;
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
      L := Add(TLabelContainer.Create(strVersionLabel, scNone, 0, 0,
        iiUsesLabel, Nil)) As TLabelContainer;
      V := L.Add(TVBVersion.Create(Token.Token, scNone, Token.Line,
        Token.Column, iiUsesLabel, Nil)) As TVBVersion;
      NextNonCommentToken;
      If Token.TokenType In [ttNumber] Then
        Begin
          AddToExpression(V);
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

(**

  This method processes variable declarations.

  @precon  None.
  @postcon Processes variable declarations.

  @param   Scope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
function TVBModule.Vars(Scope: TScope; C: TComment): Boolean;

Var
  boolWithEvents : Boolean;
  V : TVBVar;
  iLow: Integer;
  iHigh: Integer;

begin
  Result := False;
  Repeat
    boolWithevents := Token.UToken = 'WITHEVENTS';
    If boolWithEvents Then
      NextNonCommentToken;
    If Token.TokenType In [ttIdentifier] Then
      Begin
        Result := True;
        V := TVBVar.Create(Token.Token, Scope, Token.Line, Token.Column,
          iiPublicVariable, C);
        If FVariablesLabel = Nil Then
          FVariablesLabel := Add(TLabelContainer.Create(strVarsLabel, scNone, 0, 0,
            iiPublicVariablesLabel, Nil)) As TLabelContainer;
        V := FVariablesLabel.Add(V) As TVBVar;
        V.Referenced := True;
        V.Comment := C;
        V.WithEvents := boolWithEvents;
        NextNonCommentToken;
        If Token.Token = '(' Then
          Begin
            NextNonCommentToken;
            If Token.Token <> ')' Then
              Begin
                Repeat
                  If Token.TokenType In [ttNumber] Then
                    Begin
                      iLow := StrToInt(Token.Token);
                      iHigh := iLow;
                      NextNonCommentToken;
                      If Token.UToken = 'TO' Then
                        Begin
                          NextNonCommentToken;
                          If Token.TokenType In [ttNumber] Then
                            Begin
                              iHigh := StrToInt(Token.Token);
                              NextNonCommentToken;
                            End Else
                              ErrorAndSeekToken(strNumberExpected, 'Vars',
                                Token.Token, strSeekTokens, stActual);
                        End;
                      V.AddDimension(iLow, iHigh);
                    End Else
                      ErrorAndSeekToken(strNumberExpected, 'Vars', Token.Token,
                        strSeekTokens, stActual);
                Until Not IsToken(',', Nil);
                If Token.Token = ')' Then
                  NextNonCommentToken
                Else
                  ErrorAndSeekToken(strLiteralExpected, 'Vars', Token.Token,
                    strSeekTokens, stActual);
              End Else
              Begin
                V.AddDimension(-1, 0);
                NextNonCommentToken;
              End;
          End;
        If Token.UToken = 'AS' Then
          Begin
            NextNonCommentToken;
            If Token.UToken = 'NEW' Then
              AddToExpression(V);
            If Token.TokenType In [ttIdentifier, ttReservedWord] Then
              AddToExpression(V)
            Else
              ErrorAndSeekToken(strIdentExpected, 'Vars', Token.Token,
                strSeekTokens, stActual);
            If Token.Token = '.' Then
              Begin
                AddToExpression(V);
                If Token.TokenType In [ttIdentifier, ttReservedWord] Then
                  AddToExpression(V)
                Else
                  ErrorAndSeekToken(strIdentExpected, 'Vars', Token.Token,
                    strSeekTokens, stActual);
              End;
          End;
      End Else
        ErrorAndSeekToken(strIdentExpected, 'Vars', Token.Token,
          strSeekTokens, stActual);
  Until Token.Token <> ',';
  If Token.TokenType In [ttLineEnd] Then
    NextNonCommentToken
  Else
    ErrorAndSeekToken(strLineEndExpected, 'Vars', Token.Token,
      strSeekTokens, stActual);
end;

(**

  This method processes the BEGIN/END section of a module version clause. 

  @precon  None. 
  @postcon Processes the BEGIN/END section of a module version clause. 

  @param   C as a TElementContainer

**)
Procedure TVBModule.VBBegin(C : TElementContainer);

Begin
  If IsKeyWord(Token.Token, ['begin']) Then
    Begin
      NextNonCommentToken;
      If FModuleType = mtForm Then
        If Token.TokenType In [ttIdentifier] Then
          NextNonCommentToken
        Else
          ErrorAndSeekToken(strIdentExpected, 'VBBegin',
            Token.Token, strSeekTokens, stActual);
      If Token.TokenType In [ttLineEnd] Then
        Begin
          NextNonCommentToken;
          While Token.TokenType In [ttIdentifier] Do
            Attribute(C);
          If IsKeyWord(Token.Token, ['end']) Then
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
    End Else
      ErrorAndSeekToken(strLineEndExpected, 'VBBegin',
        Token.Token, strSeekTokens, stActual);
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

Begin
  Result := False;
  While IsKeyWord(Token.Token, ['attribute']) Do
    Begin
      Result := True;
      If FAttributesLabel = Nil Then
        FAttributesLabel := Add(TLabelContainer.Create(strAttributesLabel,
          scNone, 0, 0, iiUsesLabel, Nil)) As TLabelContainer;
      NextNonCommentToken;
      Attribute(FAttributesLabel);
    End;
end;

(**

  This method parses a single attribute at the top of the module. 

  @precon  None.
  @postcon Parses a single attribute at the top of the module. 

  @param   C as a TElementContainer

**)
Procedure TVBModule.Attribute(C : TElementContainer);

Var
  A : TVBAttribute;

begin
  If Token.TokenType In [ttIdentifier] Then
    Begin
      A := C.Add(TVBAttribute.Create(Token.Token, scNone, Token.Line,
        Token.Column, iiUsesItem, Nil)) As TVBAttribute;
      NextNonCommentToken;
      If Token.Token = '=' Then
        Begin
          NextNonCommentToken;
          If Token.Token = '-' Then
            AddToExpression(A);
          If Token.TokenType In [ttNumber, ttIdentifier, ttDirective,
            ttStringLiteral] Then
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
    End Else
      ErrorAndSeekToken(strIdentExpected, 'Attribute',
        Token.Token, strSeekTokens, stActual);
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

Begin
  Result := False;
  While Token.UToken = 'OPTION' Do
    Begin
      Result := True;
      If FOptionsLabel = Nil Then
        FOptionsLabel := Add(TLabelContainer.Create(strOptionsLabel, scNone,
          0, 0, iiUsesLabel, Nil)) As TLabelContainer;
      NextNonCommentToken;
      If Token.UToken = 'BASE' Then
        Begin
          O := FOptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
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
          O := FOptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
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
          O := FOptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
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
          FOptionsLabel.Add(TVBOption.Create(Token.Token, scNone,
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

Var
  C : TComment;

Begin
  Repeat
    C := GetComment;
    Result :=
      Privates(C) Or
      Publics(C) Or
      Consts(scPublic, C) Or
      Dims(scPublic, C) Or
      Subs(scPublic, C, False, Nil) Or
      Functions(scPublic, C, False, Nil) Or
      Declares(scPublic, C) Or
      Friends(C) Or
      Props(scPublic, C, False) Or
      Records(scPublic, C) Or
      Enum(scPublic, C);
    If Not Result Then
      If Not EndOfTokens Then
        If Token.TokenType In [ttLineEnd] Then
          NextNonCommentToken
        Else
          ErrorAndSeekToken(strUnDefinedToken, 'Declarations', Token.Token,
            strSeekTokens, stActual);
  Until EndOfTokens;
End;

(**

  This method parses parameters for method and properties.

  @precon  Method must be a valid instance of a method.
  @postcon Parses parameters for method and properties.

  @param   Method as a TGenericMethodDecl

**)
Procedure TVBModule.Parameters(Method : TGenericMethodDecl);

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
        PM := pamConst;
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
          If boolOptional Then
            If Token.Token = '=' Then
              NextNonCommentToken
            Else
              ErrorAndSeekToken(strLiteralExpected, 'Parameters', '=',
                strSeekTokens, stActual)
          Else
            NextNonCommentToken;
          While (Token.Token <> ',') And (Token.Token <> ')') Do
            Begin
              DefaultValue := DefaultValue + Token.Token;
              NextNonCommentToken;
            End;
        End;
      P := TVBParameter.Create(pm, Ident.Token, boolArray, ParamType,
        DefaultValue, scLocal, Token.Line, Token.Column);
      Method.AddParameter(P);
      P.Optional := boolOptional;
      P.ParamArray := boolParamArray;
    Finally
      ParamType.Free;
    End;
  Until Not IsToken(',', Nil);
End;

(**

  This method defers parsing of subroutines to the MethodDecl method. 

  @precon  None. 
  @postcon Defers parsing of subroutines to the MethodDecl method. 

  @param   Scope        as a TScope
  @param   C            as a TComment
  @param   boolStatic   as a Boolean
  @param   DeclareLabel as a TLabelContainer
  @return  a Boolean     

**)
Function TVBModule.Subs(Scope : TScope; C : TComment; boolStatic : Boolean;
  DeclareLabel : TLabelContainer) : Boolean;

Var
  M : TVBMethod;

Begin
  Result := False;
  If Token.UToken = 'SUB' Then
    Begin
      Result := True;
      NextNonCommentToken;
      M := TVBMethod.Create(mtProcedure, Token.Token, Scope, Token.Line,
        Token.column);
      If DeclareLabel = Nil Then
        Begin
          If FImplementedMethodsLabel = Nil Then
            FImplementedMethodsLabel := Add(TLabelContainer.Create(
              strImplementedMethodsLabel, scNone, 0, 0, iiImplementedMethods, Nil)
              ) As TLabelContainer;
          M := FImplementedMethodsLabel.Add(M) As TVBMethod;
        End Else
          M := DeclareLabel.Add(M) As TVBMethod;
      MethodDecl(M, C);
      If M.Ext = '' Then
        FindMethodEnd(M, 'SUB');
    End;
End;

(**

  This method defers parsing of functions to the MethodDecl method.

  @precon  None.
  @postcon Defers parsing of function to the MethodDecl method.

  @param   Scope        as a TScope
  @param   C            as a TComment
  @param   boolStatic   as a Boolean
  @param   DeclareLabel as a TLabelContainer
  @return  a Boolean

**)
Function TVBModule.Functions(Scope : TScope; C : TComment; boolStatic : Boolean;
  DeclareLabel : TLabelContainer) : Boolean;

Var
  M : TVBMethod;

Begin
  Result := False;
  If Token.UToken = 'FUNCTION' Then
    Begin
      Result := True;
      NextNonCommentToken;
      M := TVBMethod.Create(mtFunction, Token.Token, Scope, Token.Line,
        Token.column);
      If DeclareLabel = Nil Then
        Begin
          If FImplementedMethodsLabel = Nil Then
            FImplementedMethodsLabel := Add(TLabelContainer.Create(
              strImplementedMethodsLabel, scNone, 0, 0, iiImplementedMethods, Nil)
              ) As TLabelContainer;
          M := FImplementedMethodsLabel.Add(M) As TVBMethod;
        End Else
          M := DeclareLabel.Add(M) As TVBMethod;
      MethodDecl(M, C);
      If Token.UToken = 'AS' Then
        Begin
          NextNonCommentToken;
          If Token.TokenType In [ttIdentifier, ttReservedWord] Then
            Begin
              NextNonCommentToken;
              M.ReturnType :=  TVBTypeDecl.Create(Token.Token, scNone,
                Token.Line, Token.Column, iiNone, Nil);
            End Else
              ErrorAndSeekToken(strIdentExpected, 'Functions', Token.Token,
                strSeekTokens, stActual);
        End;
      If M.Ext = '' Then
        FindMethodEnd(M, 'FUNCTION');
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

Begin
  M.Comment := C;
  M.Identifier := Token.Token;
  M.ClassNames.Add(ModuleName);
  M.Referenced := True;
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
      M.ReturnType := TVBTypeDecl.Create('', scNone, 0, 0, iiNone, Nil);
      M.ReturnType.AppendToken(Token);
      If Token.TokenType In [ttIdentifier, ttReservedWord] Then
        Begin
          NextNonCommentToken;
          If Token.Token = '.' Then
            Begin
              M.ReturnType.AddToken('.');
              NextNonCommentToken;
              M.ReturnType.AppendToken(Token);
              If Not EndOfTokens Then NextNonCommentToken Else Exit;
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

  This method attempts to find the end of the method while looking for
  exception / error handling code and exit statements.

  @precon  Method must be a valid TVBMethod instance.
  @postcon Attempts to find the end of the method while looking for
           exception / error handling code and exit statements.

  @param   Method        as a TVBMethod
  @param   strMethodType as a String

**)
Procedure TVBModule.FindMethodEnd(Method : TVBMethod; strMethodType : String);

Begin
  RollBackToken;
  Repeat
    NextNonCommentToken;
    // Check for Exception.Push & Exception.Pop
    If AnsiCompareText(Token.Token, 'Exception') = 0 Then
      Begin
        NextNonCommentToken;
        If Token.Token = '.' Then
          Begin
            NextNonCommentToken;
            If AnsiCompareText(Token.Token, 'Push') = 0 Then
              Begin
                Method.HasPush := True;
                NextNonCommentToken;
                If Token.TokenType In [ttStringLiteral] Then
                  Begin
                    Method.PushName := Token.Token;
                    NextNonCommentToken;
                    While Token.Token = ',' Do
                      Begin
                        NextNonCommentToken;
                        Method.PushParams.Add(Token.Token);
                        NextNonCommentToken;
                      End;
                  End Else
                    ErrorAndSeekToken(strStringExpected, 'FindMethodEnd',
                      Token.Token, strSeekTokens, stActual);
              End;
            If AnsiCompareText(Token.Token, 'Pop') = 0 Then
              Begin
                Method.HasPop := True;
                NextNonCommentToken;
              End;
          End;
      End;
    // Check for On Error Goto
    If AnsiCompareText(Token.Token, 'On') = 0 Then
      Begin
        NextNonCommentToken;
        If AnsiCompareText(Token.Token, 'Error') = 0 Then
          Begin
            Method.HasErrorHnd := True;
            NextNonCommentToken;
          End;
      End;
    // Check for On Error Goto
    If AnsiCompareText(Token.Token, 'Exit') = 0 Then
      Begin
        NextNonCommentToken;
        If IsKeyWord(Token.Token, ['function', 'sub']) Then
          Begin
            Method.HasExit := True;
            NextNonCommentToken;
          End;
      End;
  Until (PrevToken.UToken = 'END') And (Token.UToken = strMethodType);
  NextNonCommentToken;
  If Token.TokenType In [ttLineEnd] Then
    NextNonCommentToken
  Else
    ErrorAndSeekToken(strLineEndExpected, 'FindMethodEnd', Token.Token,
      strSeekTokens, stActual);
End;

(**

  This method sets the scope to private and defers parsing to a sub routine
  based on the key word found.

  @precon  None.
  @postcon Sets the scope to private and defers parsing to a sub routine based
           on the key word found.

  @param   C as a TComment
  @return  a Boolean

**)
Function TVBModule.Privates(C : TComment) : Boolean;
Begin
  Result := False;
  If Token.UToken = 'PRIVATE' Then
    Begin
      NextNonCommentToken;
      Result :=
        Consts(scPrivate, C) Or
        Subs(scPrivate, C, False, Nil) Or
        Functions(scPrivate, C, False, Nil) Or
        Props(scPrivate, C, False) Or
        Declares(scPrivate, C) Or
        Records(scPrivate, C) Or
        Enum(scPrivate, C) Or
        Vars(scPrivate, C);
    End;
End;

(**

  This method sets the scope to private and defers parsing to a sub routine
  based on the key word found.

  @precon  None.
  @postcon Sets the scope to private and defers parsing to a sub routine based
           on the key word found.

  @param   C as a TComment
  @return  a Boolean

**)
Function TVBModule.Publics(C : TComment) : Boolean;
Begin
  Result := False;
  If Token.UToken = 'PUBLIC' Then
    Begin
      NextNonCommentToken;
      Result :=
        Consts(scPublic, C) Or
        Subs(scPublic, C, False, Nil) Or
        Functions(scPublic, C, False, Nil) Or
        Props(scPublic, C, False) Or
        Declares(scPublic, C) Or
        Records(scPublic, C) Or
        Enum(scPublic, C) Or
        Vars(scPublic, C);
    End;
End;

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
  M : TVBMethod;
  boolNoTag: Boolean;

begin
  I := FindElement(strImplementedMethodsLabel);
  If i <> Nil Then
    Begin
      For j := 1 To I.ElementCount Do
        Begin
          M := I.Elements[j] As TVBMethod;
          boolNoTag :=
            (Comment <> Nil) And (Comment.FindTag('noexception') > -1) Or
            (M.Comment <> Nil) And (M.Comment.FindTag('noexception') > -1);
          If Not M.HasPush And Not boolNoTag Then
            AddIssue(Format(strExceptionPush, [M.Identifier]), scNone,
              'CheckExceptionHandling', M.Line, M.Column, etWarning);
          If Not M.HasPop And Not boolNoTag Then
            AddIssue(Format(strExceptionPop, [M.Identifier]), scNone,
              'CheckExceptionHandling', M.Line, M.Column, etWarning);
          boolNoTag :=
            (Comment <> Nil) And (Comment.FindTag('noerror') > -1) Or
            (M.Comment <> Nil) And (M.Comment.FindTag('noerror') > -1);
          If Not M.HasErrorHnd And Not boolNoTag Then
            AddIssue(Format(strErrorHandling, [M.Identifier]), scNone,
              'CheckExceptionHandling', M.Line, M.Column, etWarning);
          If M.HasExit And M.HasErrorHnd Then
            AddIssue(Format(strExitStatement, [M.Identifier]), scNone,
              'CheckExceptionHandling', M.Line, M.Column, etWarning);
        End;
    End;
end;

(**

  This method parses visual basic constants.

  @precon  None.
  @postcon Parses visual basic constants.

  @param   Scope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Consts(Scope : TScope; C : TComment) : Boolean;

Var
  Con : TVBConstant;

Begin
  Result := False;
  If Token.UToken = 'CONST' Then
    Begin
      Result := True;
      NextNonCommentToken;
      If Token.TokenType In [ttIdentifier] Then
        Begin
          Con := TVBConstant.Create(Token.Token, Scope, Token.Line, Token.Column,
            iiPublicConstant, C);
          If FConstantsLabel = Nil Then
            FConstantsLabel := Add(TLabelContainer.Create(strConstantsLabel, scNone, 0,
              0, iiPublicConstantsLabel, Nil)) As TLabelContainer;
          Con := FConstantsLabel.Add(Con) As TVBConstant;
          Con.Referenced := True; 
          NextNonCommentToken;
          Con.Comment := C;
          If Token.UToken = 'AS' Then
            Begin
              NextNonCommentToken;
              If Token.TokenType In [ttIdentifier, ttReservedWord, ttDirective] Then
                Begin
                  AddToExpression(Con);
                  While Token.Token = '.' Do
                    Begin
                      AddToExpression(Con);
                      If Token.TokenType In [ttIdentifier] Then
                        Con.AddToken(Token.Token)
                      Else
                        ErrorAndSeekToken(strIdentExpected, 'Consts',
                          Token.Token, strSeekTokens, stActual);
                    End;
                End Else
                  ErrorAndSeekToken(strIdentExpected, 'Consts',
                    Token.Token, strSeekTokens, stActual);
            End;
          If Token.Token = '=' Then
            Begin
              AddToExpression(Con);
              While Not (Token.TokenType In [ttReservedWord, ttLineEnd, ttFileEnd]) Do
                AddToExpression(Con);
            End;
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

  @param   Scope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Dims(Scope : TScope; C : TComment) : Boolean;

Begin
  Result := False;
  If Token.UToken = 'DIM' Then
    Begin
      Result := True;
      NextNonCommentToken;
      Vars(Scope, C);
    End;
End;

(**

  This method processes the declare statement.

  @precon  None.
  @postcon Processes the declare statement.

  @param   Scope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Declares(Scope : TScope; C: TComment) : Boolean;

Var
  R : Boolean;

begin
  Result := False;
  If Token.UToken = 'DECLARE' Then
    Begin
      Result := True;
      NextNonCommentToken;
      If FDeclaredMethodsLabel = Nil Then
        FDeclaredMethodsLabel := Add(TLabelContainer.Create(strDeclaresLabel,
          scNone, 0, 0, iiExportedHeadingsLabel, Nil)) As TLabelContainer;
      R := Subs(Scope, C, False, FDeclaredMethodsLabel);
      If Not R Then
        R := Functions(Scope, C, False, FDeclaredMethodsLabel);
      If Not R Then
        ErrorAndSeekToken(strReservedWordExpected, 'Declares', Token.Token,
          strSeekTokens, stActual);
    End;
end;

(**

  This method processes friend statements.

  @precon  None.
  @postcon Processes friend statements.

  @param   C as a TComment
  @return  a Boolean

**)
Function TVBModule.Friends(C: TComment) : Boolean;

Var
  R : Boolean;
  
begin
  Result := False;
  If Token.UToken = 'FRIEND' then
    Begin
      Result := True;
      NextNonCommentToken;
      R := Functions(scFriend, C, False, Nil);
      If Not R Then
        R := Subs(scFriend, C, False, Nil);
      If Not R Then
        R := Props(scFriend, C, True);
      If Not R Then
        ErrorAndSeekToken(strReservedWordExpected, 'Friends',
          'FUNCTION, SUB or PROPERTY', strSeekTokens, stActual);
    End;
end;

(**

  This method processes the properties statements.

  @precon  None.
  @postcon Processes the properties statements.

  @param   Scope      as a TScope
  @param   C          as a TComment
  @param   boolStatic as a Boolean
  @return  a Boolean

**)
Function TVBModule.Props(Scope : TScope; C : TComment; boolStatic : Boolean) : Boolean;

Var
  pt : TPropertyType;
  P : TVBProperty;

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
          P := TVBProperty.Create(pt, Token.Token, Scope, Token.Line, Token.Column);
          If FImplementedPropertiesLabel = Nil Then
            FImplementedPropertiesLabel := Add(TLabelContainer.Create(strPropertiesLabel,
              scNone, 0, 0, iiPropertiesLabel, Nil)) As TLabelContainer;
          P := FImplementedPropertiesLabel.Add(P) As TVBProperty;
          P.Comment := C;
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
                      P.ReturnType := TVBTypeDecl.Create('', scNone, 0, 0, iiNone, Nil);
                      AddToExpression(P.ReturnType);
                    End;
                End;
              FindMethodEnd(P, 'PROPERTY');
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

  @param   Scope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Records(Scope : TScope; C : TComment) : Boolean;

Var
  R : TVBRecordDecl;
  F : TVBField;

Begin
  Result := False;
  If Token.UToken = 'TYPE' Then
    Begin
      Result := True;
      NextNonCommentToken;
      If Token.TokenType = ttIdentifier Then
        Begin
          R := TVBRecordDecl.Create(Token.Token, Scope, Token.Line, Token.Column,
            iiPublicRecord, C);
          If FTypesLabel = Nil Then
            FTypesLabel := Add(TLabelContainer.Create(strTypesLabel, scNone, 0, 0,
              iiPublicTypesLabel, Nil)) As TLabelContainer;
          R := FTypesLabel.Add(R) As TVBRecordDecl;
          R.Comment := C;
          NextNonCommentToken;
          If Token.TokenType In [ttLineEnd] then
            Begin
              NextNonCommentToken;
              While Token.UToken <> 'END' Do
                Begin
                  If Token.TokenType In [ttIdentifier] Then
                    Begin
                      F := TVBField.Create(Token.Token, scPublic, Token.Line,
                        Token.Column, iiPublicField, GetComment);
                      F := R.Add(F) As TVBField;
                      NextNonCommentToken;
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
                    End Else
                      ErrorAndSeekToken(strIdentExpected, 'Records',
                        Token.Token, strSeekTokens, stActual);
                End;
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

  This method processes Enumerate declarations.

  @precon  None.
  @postcon Processes Enumerate declarations.

  @param   Scope as a TScope
  @param   C     as a TComment
  @return  a Boolean

**)
Function TVBModule.Enum(Scope : TScope; C: TComment) : Boolean;

Var
  E : TVBEnumerateDecl;
  I : TVBEnumIdent;

Begin
  Result := False;
  If Token.UToken = 'ENUM' Then
    Begin
      Result := True;
      NextNonCommentToken;
      If Token.TokenType = ttIdentifier Then
        Begin
          E := TVBEnumerateDecl.Create(Token.Token, Scope, Token.Line,
            Token.Column, iiPublicType, C);
          If FTypesLabel = Nil Then
            FTypesLabel := Add(TLabelContainer.Create(strTypesLabel, scNone, 0, 0,
              iiPublicTypesLabel, Nil)) As TLabelContainer;
          E := FTypesLabel.Add(E) As TVBEnumerateDecl;
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

End.

