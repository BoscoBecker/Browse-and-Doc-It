(**

  This module contains all the simple types used through the Browse and Doc It application.

  @Author  David Hoyle
  @Version 1.593
  @Date    06 Sep 2020

  @license

    Browse and Doc It is a RAD Studio plug-in for browsing, checking and
    documenting your code.
    
    Copyright (C) 2020  David Hoyle (https://github.com/DGH2112/Browse-and-Doc-It/)

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
Unit BADI.Types;

Interface

Uses
  SysUtils,
  Classes,
  Graphics;

Type
  (** Type to distinguish Stream position from token index. **)
  TStreamPosition = Integer;
  (** Type to distinguish Stream position from token index. **)
  TTokenIndex = Integer;
  (** An enumerate type to define the stream status and token types. **)
  TBADITokenType = (
    ttUnknown,
    ttWhiteSpace,
    ttReservedWord,
    ttIdentifier,
    ttNumber,
    ttSymbol,
    ttLineEnd,
    ttSingleLiteral,
    ttDoubleLiteral,
    ttLineComment,
    ttBlockComment,
    ttHTMLStartTag,
    ttHTMLEndTag,
    ttDirective,
    ttCompilerDirective,
    ttLinkTag,
    ttTreeHeader,
    ttFileEnd,
    ttLineContinuation,
    ttCustomUserToken,
    ttExplorerHighlight,
    ttPlainText,
    ttCommentText,
    ttTagHeaderText,
    ttTagText,
    ttSearchHighlight,
    ttLineHighlight,
    ttDocIssueEditorText
  );
  (** An enumerate for the scoping of identifiers. **)
  TScope = (
    scNone,
    scGlobal,
    scLocal,
    scPrivate,
    scProtected,
    scPublic,
    scPublished,
    scFriend
  );
  (** A set to represent combinations of scopes. **)
  TScopes = Set Of TScope;
  (** An enumerate for the parameter modifiers of methods. **)
  TParamModifier = (pamNone, pamVar, pamConst, pamOut);
  (** An enumerate for the types of modules that can be parsed. **)
  TModuleType = (mtProgram, mtPackage, mtLibrary, mtUnit);
  (** An enumerate for the different methods. **)
  TMethodType = (mtConstructor, mtDestructor, mtProcedure, mtFunction, mtOperator);
  (** An enumerate for warning and errors. **)
  TErrorType = (etHint, etWarning, etError);
  (** An enumerate for the type of documentation conflict. **)
  TBADIConflictType = (ctDocumentation, ctMetric, ctCheck, ctSpelling);
  (** A type to return an array of strings **)
  TKeyWords = Array of String;
  (** A type for a set of AnsiChar - used for the function IsInSet() **)
  TSetOfAnsiChar = Set Of AnsiChar;

  (** An enumerate to describe the grouping of the module explorer options. **)
  TDocOptionGroup = (
    dogGeneral,
    dogErrors,
    dogWarnings,
    dogHints,
    dogConflicts,
    dogChecks,
    dogMetrics,
    dogSpelling,
    dogDoNotFollow,
    dogTypes,
    dogModule,
    dogMethod,
    dogProperty,
    dogInitializationFinalization,
    dogMiscellaneous
  );

  (** This is a list of options available for the display of module information **)
  TDocOption = (
    doCustomDrawing,
    doShowCommentHints,
    doShowChildCountInTitles,
    doFollowEditorCursor,
    doShowDocIssueTotalsInEditor,
    doAutoUpdateModuleDate,
    doAutoUpdateModuleVersion,

    doShowErrors,
    doExpandErrors,
    doSyntaxHighlightErrors,
    doShowErrorIconsInEditor,
    doShowErrorMsgsInEditor,
    doShowIDEErrors,

    doShowWarnings,
    doExpandWarnings,
    doSyntaxHighlightWarnings,
    doShowWarningIconsInEditor,
    doShowWarningMsgsInEditor,

    doShowHints,
    doExpandHints,
    doSyntaxHighlightHints,
    doShowHintIconsInEditor,
    doShowHintMsgsInEditor,

    doShowConflicts,
    doExpandDocConflicts,
    doSyntaxHighlightConflict,
    doShowConflictIconsInEditor,
    doShowConflictMsgsInEditor,

    doShowChecks,
    doExpandChecks,
    doSyntaxHighlightChecks,
    doAutoHideChecksWithNoissues,
    doShowCheckIconsInEditor,
    doShowCheckMsgsInEditor,

    doShowMetrics,
    doExpandMetrics,
    doSyntaxHighlightMetrics,
    doAutoHideMetricsWithNoissues,
    doShowMetricIconsInEditor,
    doShowMetricMsgsInEditor,

    doShowSpelling,
    doExpandSpelling,
    doSyntaxHighlightSpelling,
    doAutoHideSpellingWithNoissues,
    doShowSpellingIconsInEditor,
    doShowSpellingMsgsInEditor,
    doSpellCheckComments,
    doSpellCheckTags,
    doSpellCheckResourceStrings,
    doSpellCheckConstants,
    doSpellCheckLiterals,
    doSpellCheckDFMLiterals,

    doDoNotFollowEditorIfErrors,
    doDoNotFollowEditorIfWarnings,
    doDoNotFollowEditorIfHints,
    doDoNotFollowEditorIfConflicts,
    doDoNotFollowEditorIfChecks,
    doDoNotFollowEditorIfMetrics,
    doDoNotFollowEditorIfSpelling,

    doShowUndocumentedTypes,
    doShowUndocumentedRecords,
    doShowUndocumentedObjects,
    doShowUndocumentedClasses,
    doShowUndocumentedInterfaces,
    doShowUndocumentedVars,
    doShowUndocumentedConsts,
    doShowUndocumentedFields,
    doShowUndocumentedClassDecls,

    doShowUndocumentedModule,
    doShowMissingModuleDate,
    doShowCheckModuleDate,
    doShowMissingModuleVersion,
    doShowMissingModuleAuthor,

    doShowMethodMissingDocs,
    doShowMethodMissingDocDesc,
    doShowMethodDiffParamCount,
    doShowMethodUndocumentedParams,
    doShowMethodIncorrectParamType,
    doShowMethodUndocumentedReturn,
    doShowMethodIncorrectReturnType,
    doShowMethodMissingPreCons,
    doShowMethodMissingPostCons,

    doShowPropertyMissingDoc,
    doShowPropertyMissingDocDesc,
    doShowPropertyDiffPropParamCount,
    doShowPropertyUndocumentedParams,
    doShowPropertyIncorrectParamType,
    doShowPropertyUndocumentedReturn,
    doShowPropertyIncorrectReturnType,
    doShowPropertyMissingPreCons,
    doShowPropertyMissingPostCons,

    doShowMissingInitComment,
    doShowMissingFinalComment,

    {doShowIDEErrorsOnSuccessfulParse,}
    { doShowParserErrorOrigin, }
    doShowUnReferencedSymbols,
    doShowPerformanceCountersInModuleExplorer,
    doShowPrefCountersInDocSummary,
    doStrictConstantExpressions,
    doShowMissingVBExceptionWarnings,
    doAddPreAndPostToComment
  );

  (** An enumerate to associate images with different types of Elements. **)
  TBADIImageIndex = (
    iiNone,

    iiModule,

    iiErrorFolder,
    iiError,
    iiWarningFolder,
    iiWarning,
    iiHintFolder,
    iiHint,

    iiDocConflictFolder,
    iiDocConflictIncorrect,
    iiDocConflictItem,
    iiDocConflictMissing,

    iiMetricFolder,
    iiMetricIncorrect,
    iiMetricItem,
    iiMetricMissing,

    iiCheckFolder,
    iiCheckIncorrect,
    iiCheckItem,
    iiCheckMissing,

    iiRedWarning,
    iiAmberWarning,
    iiYellowWarning,
    iiGreenWarning,
    iiBlueWarning,

    iiRedStop,
    iiAmberStop,
    iiYellowStop,
    iiGreenStop,
    iiBlueStop,

    iiRedProhibited,
    iiAmberProhibited,
    iiYellowProhibited,
    iiGreenProhibited,
    iiBlueProhibited,

    iiRedBug,
    iiAmberBug,
    iiYellowBug,
    iiGreenBug,
    iiBlueBug,

    iiRedUpArrow,
    iiAmberUpArrow,
    iiYellowUpArrow,
    iiGreenUpArrow,
    iiBlueUpArrow,

    iiRedRightArrow,
    iiAmberRightArrow,
    iiYellowRightArrow,
    iiGreenRightArrow,
    iiBlueRightArrow,

    iiRedDownArrow,
    iiAmberDownArrow,
    iiYellowDownArrow,
    iiGreenDownArrow,
    iiBlueDownArrow,

    iiRedLeftArrow,
    iiAmberLeftArrow,
    iiYellowLeftArrow,
    iiGreenLeftArrow,
    iiBlueLeftArrow,

    iiRedBookmark,
    iiAmberBookmark,
    iiYellowBookmark,
    iiGreenBookmark,
    iiBlueBookmark,

    iiRedTick,
    iiAmberTick,
    iiYellowTick,
    iiGreenTick,
    iiBlueTick,

    iiRedToDoTick,
    iiAmberToDoTick,
    iiYellowToDoTick,
    iiGreenToDoTick,
    iiBlueToDoTick,

    iiRedToDoCross,
    iiAmberToDoCross,
    iiYellowToDoCross,
    iiGreenToDoCross,
    iiBlueToDoCross,

    iiSpellingFolder,
    iiSpellingItem,

    iiBadTag,

    iiUsesLabel,
    iiUsesItem,

    iiPublicTypesLabel,
    iiPublicType,

    iiRecordsLabel,
    iiPublicRecord,

    iiFieldsLabel,
    iiPublicField,

    iiObjectsLabel,
    iiPublicObject,

    iiPublicConstructor,
    iiPublicDestructor,
    iiPublicProcedure,
    iiPublicFunction,

    iiClassesLabel,
    iiPublicClass,

    iiPropertiesLabel,
    iiPublicProperty,

    iiInterfacesLabel,
    iiPublicInterface,

    iiDispInterfacesLabel,
    iiPublicDispInterface,

    iiPublicConstantsLabel,
    iiPublicConstant,

    iiPublicResourceStringsLabel,
    iiPublicResourceString,

    iiPublicVariablesLabel,
    iiPublicVariable,

    iiPublicThreadVarsLabel,
    iiPublicThreadVar,

    iiPublicClassVariablesLabel,
    iiPublicClassVariable,

    iiExportedHeadingsLabel,

    iiExportedFunctionsLabel,
    iiPublicExportedFunction,

    iiPublicLabelsLabel,
    iiPublicLabel,

    iiImplementedMethods,
    iiMethodsLabel,

    iiInitialization,
    iiFinalization,

    iiToDoFolder,
    iiToDoItem,

    iiUnknownClsObj
  );

  (** This is a set of display options. **)
  TDocOptions = Set of TDocOption;

  (** This is an enumerate to define the options for the parsing of a module. **)
  TModuleOption = (moParse, moCheckForDocumentConflicts, moProfiling);
  (** This is a set of Module Option enumerates. **)
  TModuleOptions = Set Of TModuleOption;

  (** A type to define the position before a token of the comment to be
      associated with the identifier. **)
  TCommentPosition = (cpBeforeCurrentToken, cpBeforePreviousToken);

  (** An enumerate to define the type of conflict and hence icon. **)
  TDocConflictIcon = (dciItem, dciIncorrect, dciMissing);

  (** An enumerate to index document conflict information. **)
  TDocConflictType = (
    dctModuleMissingDocumentation,
    dctModuleMissingDate,
    dctModuleIncorrectDate,
    dctModuleCheckDateError,
    dctModuleMissingVersion,
    dctModuleMissingAuthor,

    dctTypeClauseUndocumented,
    dctConstantClauseUndocumented,
    dctResourceStringClauseUndocumented,
    dctVariableClauseUndocumented,
    dctThreadVarClauseUndocumented,
    dctFieldClauseUndocumented,

    dctClassClauseUndocumented,
    dctRecordClauseUndocumented,
    dctObjectClauseUndocumented,
    dctInterfaceClauseUndocumented,
    dctDispInterfaceClauseUndocumented,

    dctFunctionUndocumented,
    dctFunctionHasNoDesc,
    dctFunctionPreconNotDocumented,
    dctFunctionDiffParamCount,
    dctFunctionMissingPreCon,
    dctFunctionTooManyPrecons,
    dctFunctionUndocumentedParam,
    dctFunctionIncorrectParamType,
    dctFunctionPostconNotDocumented,
    dctFunctionUndocumentedReturn,
    dctFunctionIncorrectReturntype,
    dctFunctionReturnNotRequired,
    dctFunctionMissingPostCon,
    dctFunctionTooManyPostCons,

    dctMissingInitComment,
    dctMissingFinalComment,

    dctTooManyConflicts
  );

  (** This record refined a pairing of Resource Name and Image Mask Colour for
      the imported images from the Executable File associated with the
      Image Index enumerate. **)
  TImageIndexInfo = Record
    FResourcename : String;
    FMaskColour   : Integer;
  End;

  (** This is a record that contains the description and the default for a
      TDocOption enumerate. **)
  TDocOptionRec = Record
    FDescription : String;
    FEnabled     : Boolean;
    FGroup       : TDocOptionGroup;
  End;

  (** A record type to contain a token and its line and column in the editor. **)
  TIdentInfo = Record
    FIdent : String;
    FLine  : Integer;
    FCol   : Integer;
    FScope : TScope;
  End;

  (** This is a record to describe the position of a token in the editor. **)
  TTokenPosition = Record
    FLine      : Integer;
    FColumn    : Integer;
    FBufferPos : Integer;
  End;

  (** This enumerate determines the status of the token's reference resolution. **)
  TTokenReference = (trUnknown, trUnresolved, trResolved);

  (** A type of a set of Characters. **)
  TSymbols = Set Of AnsiChar;

  (** A record to describe document conflict information. **)
  TDocConflictTable = Record
    FMessage      : String;
    FDescription  : String;
    FConflictType : TDocConflictIcon;
  End;

  (** This enumerate defines the type of information to find. **)
  TFindType = (ftName, ftIdentifier);

  (** This is a type for a set of characters and the return type of several
      properties. **)
  TCharSet = Set of AnsiChar;

  (** A type to define the type of token search. **)
  TSeekToken = (stActual, stFirst);

  (** A type to define an array of integers. **)
  TArrayOfInteger = Array Of Integer;

  (** This enumerate defines the type of compiler condition placed on the stack. **)
  TCompilerDefType = (cdtIFDEF, cdtIFNDEF, cdtELSE, cdtENDIF);
  (** An enumerate to define the condition of the compiler definition. **)
  TCompilerCondition = (ccIncludeCode, ccExcludeCode);

  (** This enumerate define the position of the editor when an item is selected
      in the module explorer. **)
  TBrowsePosition = (
    bpCommentTop,
    bpCommentCentre,
    bpIdentifierTop,
    bpIdentifierCentre,
    bpIdentifierCentreShowAllComment
  );

  (** A record to define the font information for each token type. **)
  TTokenFontInfo = Record
    FForeColour : TColor;
    FStyles     : TFontStyles;
    FBackColour : TColor;
  End;

  (** This is an array of token font info records for each token type **)
  TBADITokenFontInfoTokenSet = Array[Low(TBADITokenType)..High(TBADITokenType)] Of TTokenFontInfo;

  (** An enumerate to define the different types of issues to limit output for. **)
  TLimitType = (ltErrors, ltWarnings, ltHints, ltConflicts, ltChecks, ltMetrics, ltSpelling);
  (** A set of the above enumerates. **)
  TLimitTypes = Set of TLimitType;

  (** This enumerate described the different types of doc comment .**)
  TCommentStyle = (csBlock, csLine, csInSitu);
  (** An enumerate to define the type of comment output that can be generated by
      WriteComment. @nospellings **)
  TCommentType = (ctNone, ctPascalBlock, ctPascalBrace, ctCPPBlock, ctCPPLine, ctVBLine, ctXML);

  (** A set of the above comment types. **)
  TCommentTypes = Set Of TCommentType;

  (** A silent parser abort exception. **)
  EBADIParserAbort = Class(Exception);
  (** An exception or an error when parsing a file. **)
  EBADIParserError = Class(EBADIParserAbort);

  (** This is an enumerate to defines the BADI Menu Items. **)
  TBADIMenu = (
    bmModuleExplorer,
    bmDocumentation,
    bmDUnit,
    bmProfiling,
    bmSep1,
    bmFocusEditor,
    bmMethodComment,
    bmPropertyComment,
    bmBlockComment,
    bmLineComment,
    bmInSituComment,
    bmToDoComment,
    bmSep2,
    bmRefactorConstant,
    bmBADIMetrics,
    bmBADIChecks,
    bmBADISpelling,
    bmSep3,
    bmOptions
  );

  (** A record to describe the menu defaults values. **)
  TBADIMenuRecord = Record
    FName      : String;
    FCaption   : String;
    FShortCut  : String;
    FMaskColor : TColor;
  End;

  (** An event handler signature to provide a call back function to request whether the given
     shortcut has already been implemented. **)
  TBADIShortcutUsedEvent = Function(Const iShortcut : TShortcut;
    Var strActionName : String) : Boolean Of Object;

  (** An enumerate to define the properties of a comment tag. **)
  TBADITagProperty = (tpShowInTree, tpAutoExpand, tpShowInDoc, tpFixed, tpSyntax, tpShowInEditor);

  (** A set of tag properties. **)
  TBADITagProperties = Set Of TBADITagProperty;

  (** A record to describe the attributes of a special tag in the options dialogue. **)
  TBADISpecialTag = Record
    FName          : String;
    FDescription   : String;
    FTagProperties : TBADITagProperties;
    FFontStyles    : TFontStyles;
    FFontColour    : TColor;
    FBackColour    : TColor;
    FIconImage     : TBADIImageIndex;
    Constructor Create(Const strName, strDescription: String;
  Const setTagProperties: TBADITagProperties; Const eImageIndex : TBADIImageIndex);
  End;

  (** An enumerate to describe each of the metrics. **)
  TBADIModuleMetric = (
    mmLongMethods,
    mmLongParameterLists,
    mmLongMethodVariableLists,
    mmNestedIFDepth,
    mmCyclometricComplexity,
    mmToxicity
  );
  (** A set of the above module metrics. **)
  TBADIModuleMetrics = Set Of TBADIModuleMetric;
  (** An enumerate to define metric sub-options. **)
  TBADIModuleMetricSubOp = (
    mmsoMethodCCIncIF,
    mmsoMethodCCIncCASE,
    mmsoMethodCCIncWHILE,
    mmsoMethodCCIncREPEAT,
    mmsoMethodCCIncludeExpression,
    mmsoToxicityIncMethodLen,
    mmsoToxicityIncParamLen,
    mmsoToxicityIncVarLen,
    mmsoToxicityIncIFDepth,
    mmsoToxicityIncCycloComp
  );
  (** A set of the above metric sub-options. **)
  TBADIModuleMetricSubOps = Set Of TBADIModuleMetricSubOp;

  (** An enumerate to describe each of the checks. **)
  TBADIModuleCheck = (
    mcHardCodedIntegers,
    mcHardCodedNumbers,
    mcHardCodedStrings,
    mcUnsortedMethod,
    mcUseOfWithStatements,
    mcUseOfGOTOStatements,
    mcEmptyEXCEPT,
    mcEmptyFINALLY,
    mcExceptionEating,
    mcEmptyTHEN,
    mcEmptyELSE,
    mcEmptyCASE,
    mcEmptyFOR,
    mcEmptyWHILE,
    mcEmptyREPEAT,
    mcEmptyBEGINEND,
    mcEmptyIntialization,
    mcEmptyFinalization,
    mcEmptyMethod,
    mcMissingCONSTInParemterList
  );
  (** A set of the above module checks. **)
  TBADIModuleChecks = Set Of TBADIModuleCheck;
  (** An enumerate to define check sub-options. **)
  TBADIModuleCheckSubOp = (
      mcsoHCIntIgnoreZero,
      mcsoHCIntIgnoreOne,
      mcsoHCIntIgnoreDIV2,
      mcsoHCNumIgmoreZero,
      mcsoHCStrIgnoreEmpty,
      mcsoHCStrIgnoreSingle,
      mcsoMCParmListIgnoreEvents
  );
  (** A set of the above metric sub-options. **)
  TBADIModuleCheckSubOps = Set Of TBADIModuleCheckSubOp;

  (** An enumerate to define the type of the metric limit. **)
  TBADILimitType = (ltInteger, ltFloat, ltNone);

  (** A record to describe the attributes of each metric. **)
  TBADIMetricRecord = Record
    FName            : String;
    FCategory        : String;
    FMessage         : String;
    FDescription     : String;
    FConflictType    : TDocConflictIcon;
    FEnabled         : Boolean;
    FLimit           : Double;
    FLimitType       : TBADILimitType;
  End;
  (** A record to describe the attributes of each metric sub option. **)
  TBADIMetricSubOpRecord = Record
    FName            : String;
    FDescription     : String;
    FParentMetric    : TBADIModuleMetric;
  End;
  (** A record to describe the attributes of each metric. **)
  TBADICheckRecord = Record
    FName            : String;
    FCategory        : String;
    FMessage         : String;
    FDescription     : String;
    FConflictType    : TDocConflictIcon;
    FEnabled         : Boolean;
    FLimit           : Double;
    FLimitType       : TBADILimitType;
  End;
  (** A record to describe the attributes of each check sub option. **)
  TBADICheckSubOpRecord = Record
    FName            : String;
    FDescription     : String;
    FParentCheck     : TBADIModuleCheck;
  End;

  (** An enumerate to define how the toxicity metric is combined. **)
  TBADIToxicitySummation = (tsAddBeforePower, tsAddAfterPower);

  (** An enumerate to define the type of exclusion **)
  TBADIExclusionType = (etDocumentation, etMetrics, etChecks, etSpelling);
  (** A set of the above exclusion types to be referenced against each exclusion pattern. **)
  TBADIExclusionTypes = Set Of TBADIExclusionType;

  (** A record to describe the attributes of a exclusions (Document, Metric or Check) **)
  TBADIExclusionRec = Record
    FExclusionPattern: String;
    FExclusions: TBADIExclusionTypes;
  End;

  (** An enumerate to define the Abstract Syntax Tree Labels that a module can use. **)
  TBADIASTLabel = (
    alTypesLabel,
    alConstantsLabel,
    alResourceStringsLabel,
    alVariablesLabel,         
    alThreadVarsLabel,        
    alExportedHeadingsLabel,  
    alExportsHeadingsLabel,
    alImplementedMethodsLabel
  );

  (** An enumerate to define the type of information stored in each node - used for counting later. **)
  TBADINodeType = (ntUnkown, ntModule, ntMethod);

  (** An enumerate to define some options for when rendering the module metrics, checks, etc. **)
  TBADIRenderOption = (
    roClear,            // Clears the treeview before rendering
    roAutoExpand,       // Auto expands the the treeview for the rendered module
    roAutoExpandOnError // Auto expands the the treeview for the rendered module ONLY IF there are
                        // issued
  );
  (** A set of the above enumerate options. **)
  TBADIRenderOptions = Set Of TBADIRenderOption;

  (** An enumerate to define the types of spelling issue. **)
  TBADISpellingIssueType = (sitComment, sitTag, sitResourceString, sitConstant, sitLiteral);
  
  (** A record to describe the start, end and markers for different comment
      types. **)
  TCommentTypeRec = Record
    FStart: String;
    FMiddle: String;
    FBlockEnd: String;
    FLineEnd: String;
  End;

Implementation

(**

  A constructor for the TBADISpecialTag class.

  @precon  None.
  @postcon Initialises the special tag record.

  @param   strName          as a String as a constant
  @param   strDescription   as a String as a constant
  @param   setTagProperties as a TBADITagProperties as a constant
  @param   eImageIndex      as a TBADIImageIndex as a constant

**)
Constructor TBADISpecialTag.Create(Const strName, strDescription: String;
  Const setTagProperties: TBADITagProperties; Const eImageIndex : TBADIImageIndex);

Begin
  FName := strName;
  FDescription := strDescription;
  FTagProperties := setTagProperties;
  FFontStyles := [];
  FFontColour := clNone;
  FBackColour := clNone;
  FIconImage := eImageIndex;
End;

End.
