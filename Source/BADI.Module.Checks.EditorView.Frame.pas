(**
  
  This module contains a frame for displaying module methods and their checks.

  @Author  David Hoyle
  @Version 1.218
  @Date    21 Nov 2021

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

  @note    If vstStatistics.ScrollBarOptions.AlwaysVisible is not TRUE track pad scrolling AVs editor.
  
**)
Unit BADI.Module.Checks.EditorView.Frame;

Interface

Uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  VirtualTrees,
  BADI.Base.Module,
  BADI.ElementContainer,
  BADI.Generic.FunctionDecl,
  ImgList,
  ExtCtrls, 
  Actions,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  Menus,
  ActnPopup,
  ToolsAPI,
  Themes,
  BADI.Types,
  BADI.CustomVirtualStringTree,
  UITypes;

{$INCLUDE CompilerDefinitions.inc}

Type
  (** A frame to display a modules methods and their metrics. **)
  TframeBADIModuleChecksEditorView = Class(TFrame)
    ilScopeImages: TImageList;
    tmFocusTimer: TTimer;
    pabContextMenu: TPopupActionBar;
    alActions: TActionList;
    actExpandAll: TAction;
    actCollapseAll: TAction;
    actExpand: TAction;
    actCollapse: TAction;
    ExpandAll1: TMenuItem;
    CollapseAll1: TMenuItem;
    N1: TMenuItem;
    Expand1: TMenuItem;
    Collapse1: TMenuItem;
    actExpandIssues: TAction;
    N2: TMenuItem;
    ExpandIssues1: TMenuItem;
    actShowAllColumns: TAction;
    N3: TMenuItem;
    ShowAllColumns1: TMenuItem;
    Procedure actExpandAllExecute(Sender: TObject);
    Procedure actCollapseAllExecute(Sender: TObject);
    Procedure actExpandUpdate(Sender: TObject);
    Procedure actExpandExecute(Sender: TObject);
    Procedure actCollapseExecute(Sender: TObject);
    Procedure actCollapseUpdate(Sender: TObject);
    Procedure actExpandIssuesExecute(Sender: TObject);
    Procedure vstChecksFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    Procedure tmFocusTimerTimer(Sender: TObject);
    procedure actShowAllColumnsExecute(Sender: TObject);
  Strict Private
    Type
      (** A custom virtual string tree to stop a Dark Themed IDE raising Access Violations due to some
          sort of RTTI clash. **)
      TBADIEditorViewVirtualStringTree = Class(TBADICustomVirtualStringTree);
      (** A record to describe the data to be held in a tree node. **)
      TBADICheckRecord = Record
        FNodeType        : TBADINodeType;
        FFileName        : String;
        FText            : String;
        FImageIndex      : Integer;
        FChecks          : Array[Low(TBADIModuleCheck)..High(TBADIModuleCheck)] Of Double;
        FTotal           : Double;
        FIssueCount      : Integer;
        FCheckOverrides  : TBADIModuleChecks;
        FIdentLine       : Integer;
        FIdentColumn     : Integer;
        FCommentLine     : Integer;
        FCommentColumn   : Integer;
      End;
      (** A pointer to the above record. **)
      PBADICheckRecord = ^TBADICheckRecord;
      (** A record type to hold the return information from recursing nodes. **)
      TNodeResultRecord = Record
        FNode: PVirtualNode;
        FChildCount: Integer;
        FIssueCount: Integer;
        Class Operator Add(Const R1, R2: TNodeResultRecord): TNodeResultRecord;
        Constructor Create(Const Node: PVirtualNode);
      End;
  Strict Private
    FFileName      : String;
    FModuleCount   : Integer;
    FMethodCount   : Integer;
    FUnderLimit    : Integer;
    FOverLimit     : Integer;
    FVSTChecks     : TBADIEditorViewVirtualStringTree;
    {$IFDEF RS102}
    FThemingServicesNotifierIndex : Integer;
    FStyleServices : TCustomStyleServices;
    {$ENDIF RS102}
  Strict Protected
    Procedure vstChecksGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; Var CellText: String);
    Procedure vstChecksBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      Var ContentRect: TRect);
    Procedure vstChecksGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; Var Ghosted: Boolean; Var ImageIndex: TImageIndex);
    Procedure vstChecksCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; Var Result: Integer);
    Procedure vstChecksPaintText(Sender: TBaseVirtualTree; Const TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    Function RecurseContainer(Const Container: TElementContainer;
      Const Parent: PVirtualNode): TNodeResultRecord;
    Procedure UpdateStats;
    Function ProcessFunction(Const NodeData : PBADICheckRecord;
      Const AFunction : TGenericFunction) : TNodeResultRecord;
    Procedure DeleteExistingModuleNode(Const Module : TBaseLanguageModule);
    Procedure SortAndExpand(Const NodeResult : TNodeResultRecord;
      Const setRenderOptions : TBADIRenderOptions);
    Function  HasIssues(Const Node : PVirtualNode) : Boolean;
    Procedure ExtractMaxFromChildren(Const ParentNode : PVirtualNode);
    Procedure CreateVirtualStringTree;
    Procedure HideZeroColumns;
    Procedure ExpandIssues;
    Procedure HookThemingServices(Sender : TObject);
    Procedure vstChecksDblClick(Sender : TObject);
    Function  CreateModule(Const Module: TBaseLanguageModule): TNodeResultRecord;
  Public
    //: @nometric MissingCONSTInParam
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure RenderModule(Const Module: TBaseLanguageModule;
      Const setRenderOptions: TBADIRenderOptions);
    Procedure CopyToClipboard;
    Procedure FocusResults;
  Published
    (**
      This property returns the number of modules.
      @precon  None.
      @postcon Returns the number of modules.
      @return  an Integer
    **)
    Property ModuleCount: Integer Read FModuleCount;
    (**
      This property returns the number of methods.
      @precon  None.
      @postcon Returns the number of methods.
      @return  an Integer
    **)
    Property MethodCount: Integer Read FMethodCount;
    (**
      This property returns the number of method metrics which are under the limit.
      @precon  None.
      @postcon Returns the number of method metrics which are under the limit.
      @return  an Integer
    **)
    Property UnderLimit: Integer Read FUnderLimit;
    (**
      This property returns the number of method metrics which are over the limit.
      @precon  None.
      @postcon Returns the number of method metrics which are over the limit.
      @return  an Integer
    **)
    Property OverLimit: Integer Read FOverLimit;
  End;

Implementation

Uses
  {$IFDEF CODESITE}
  CodeSiteLogging,
  {$ENDIF CODESITE}
  BADI.ResourceStrings,
  BADI.Options,
  BADI.Functions,
  ClipBrd, 
  BADI.IDEThemingNotifier,
  BADI.ToolsAPIUtils,
  BADI.Constants;

{$R *.dfm}


Type
  (** An enumerate to define the columns in the report. **)
  TBADICheckColumn = (
    ccText,
    ccHardCodedIntegers,
    ccHardCodedNumbers,
    ccHardCodedStrings,
    ccUnsortedMethod,
    ccUseOfWithStatements,
    ccUseOfGOTOStatements,
    ccEmptyEXCEPT,
    ccEmptyFINALLY,
    ccExceptionEating,
    ccEmptyTHEN,
    ccEmptyELSE,
    ccEmptyCASE,
    ccEmptyFOR,
    ccEmptyWHILE,
    ccEmptyREPEAT,
    ccEmptyBEGINEND,
    ccEmptyIntialization,
    ccEmptyFinalization,
    ccEmptyMethod,
    ccMissingCONSTInParemterList,
    ccTotal);
  (** A record to describe check column information. **)
  TCheckColumnInfo = Record
    FName      : String;
    FWidth     : Integer;
    FMinWidth  : Integer;
    FAlignment : TAlignment;
    FCheck     : TBADIModuleCheck;
  End;

Const
  (** A constant array of column information for rendering. **)
  CheckColumns : Array[TBADICheckColumn] Of TCheckColumnInfo = (
    (FName: 'Method';   FWidth: 400; FMinWidth: 400; FAlignment: taLeftJustify; FCheck: mcHardCodedIntegers),
    (FName: 'Integer';  FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcHardCodedIntegers),
    (FName: 'Number';   FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcHardCodedNumbers),
    (FName: 'String';   FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcHardCodedStrings),
    (FName: 'Unsorted'; FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcUnsortedMethod),
    (FName: 'With';     FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcUseOfWithStatements),
    (FName: 'Goto';     FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcUseOfGOTOStatements),
    (FName: 'Except';   FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyEXCEPT),
    (FName: 'Finally';  FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyFINALLY),
    (FName: 'Eating';   FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcExceptionEating),
    (FName: 'Then';     FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyTHEN),
    (FName: 'Else';     FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyELSE),
    (FName: 'Case';     FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyCASE),
    (FName: 'For';      FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyFOR),
    (FName: 'While';    FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyWHILE),
    (FName: 'Repeat';   FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyREPEAT),
    (FName: 'Begin End'; FWidth: 75;  FMinWidth: 0;  FAlignment: taCenter;      FCheck: mcEmptyBEGINEND),
    (FName: 'Initialization'; FWidth: 75;  FMinWidth: 0; FAlignment: taCenter;  FCheck: mcEmptyIntialization),
    (FName: 'Finalization'; FWidth: 75;  FMinWidth: 0; FAlignment: taCenter;    FCheck: mcEmptyFinalization),
    (FName: 'Method';   FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcEmptyMethod),
    (FName: 'Const';    FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcMissingCONSTInParemterList),
    (FName: 'Total';    FWidth: 75;  FMinWidth: 0;   FAlignment: taCenter;      FCheck: mcMissingCONSTInParemterList)
  );

(**

  This is an operator overload for the Add operation.

  @precon  None.
  @postcon Adds the numeric fields of the 2 record to a new result.

  @param   R1 as a TNodeResultRecord as a constant
  @param   R2 as a TNodeResultRecord as a constant
  @return  a TNodeResultRecord

**)
Class Operator TframeBADIModuleChecksEditorView.TNodeResultRecord.Add(Const R1,
  R2: TNodeResultRecord): TNodeResultRecord;

Begin
  Result.FNode := R1.FNode;
  Result.FChildCount := R1.FChildCount + R2.FChildCount;
  Result.FIssueCount := R1.FIssueCount + R2.FIssueCount;
End;

(**

  A constructor for the TNodeResultRecord class.

  @precon  None.
  @postcon Initialises the record.

  @param   Node as a PVirtualNode as a constant

**)
Constructor TframeBADIModuleChecksEditorView.TNodeResultRecord.Create(Const Node: PVirtualNode);

Begin
  Inherited;
  FNode := Node;
  FChildCount := 0;
  FIssueCount := 0;
End;

(**

  This is an on execute event handler for the Collapse All action.

  @precon  None.
  @postcon Collapses all the treeview nodes.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actCollapseAllExecute(Sender: TObject);

Begin
  FVSTChecks.FullCollapse();
End;

(**

  This is an on execute event handler for the Collapse action.

  @precon  None.
  @postcon Collapses the focused treeview node.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actCollapseExecute(Sender: TObject);

Begin
  FVSTChecks.FullCollapse(FVSTChecks.FocusedNode);
End;

(**

  This is an on update event handler for the Collapse Update action.

  @precon  None.
  @postcon Enables the Collapse action is there is a focused node, it has children and is currently
           expanded.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actCollapseUpdate(Sender: TObject);

Var
  A: TAction;

Begin
  If Sender Is TAction Then
    Begin
      A := Sender As TAction;
      A.Enabled :=
        Assigned(FVSTChecks.FocusedNode) And
        (FVSTChecks.ChildCount[FVSTChecks.FocusedNode] > 0) And
        FVSTChecks.Expanded[FVSTChecks.FocusedNode];
    End;
End;

(**

  This is an on execute event handler for the Expand All action.

  @precon  None.
  @postcon Expands all the nodes in the treeview.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actExpandAllExecute(Sender: TObject);

Begin
  FVSTChecks.FullExpand();
End;

(**

  This is an on execute event handler for the Expand action.

  @precon  None.
  @postcon Expands the focused node in the treeview.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actExpandExecute(Sender: TObject);

Begin
  FVSTChecks.FullExpand(FVSTChecks.FocusedNode);
End;

(**

  This is an on execute event handler for the ExpandIssues action.

  @precon  None.
  @postcon Expand all root nodes that have issues in them and collapses all others.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actExpandIssuesExecute(Sender: TObject);

Var
  N: PVirtualNode;

Begin
  N := FVSTChecks.GetFirst();
  While Assigned(N) Do
    Begin
      If HasIssues(N) Then
        FVSTChecks.FullExpand(N)
      Else
        FVSTChecks.FullCollapse(N);
      N := FVSTChecks.GetNextSibling(N);
    End;
End;

(**

  This is an on update event handler for the Expand action.

  @precon  None.
  @postcon Enables the expand action of there is a focused node, it has children and is collapsed.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actExpandUpdate(Sender: TObject);

Var
  A: TAction;

Begin
  If Sender Is TAction Then
    Begin
      A := Sender As TAction;
      A.Enabled :=
        Assigned(FVSTChecks.FocusedNode) And
        (FVSTChecks.ChildCount[FVSTChecks.FocusedNode] > 0) And
        Not FVSTChecks.Expanded[FVSTChecks.FocusedNode];
    End;
End;

(**

  This is an on execute event handler for the Show All Columns action.

  @precon  None.
  @postcon Shows all the columns in the report.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.actShowAllColumnsExecute(Sender: TObject);

Var
  iColumn: Integer;
  C: TVirtualTreeColumn;

Begin
  For iColumn := 0 To FVSTChecks.Header.Columns.Count - 1 Do
    Begin
      C := FVSTChecks.Header.Columns[iColumn];
      C.Options := C.Options + [coVisible];
    End;
End;

(**

  This method copies the treeview information to the clipboard.

  @precon  None.
  @postcon The treeview information is copied to the clipboard.

**)
Procedure TframeBADIModuleChecksEditorView.CopyToClipboard;

  (**

    This method counts the number of parent nodes to the given node.

    @precon  Node must be a valid instance or Nil.
    @postcon Returns the number of parent nodes to the given node.

    @param   Node as a PVirtualNode as a constant
    @return  an Integer

  **)
  Function ParentCount(Const Node: PVirtualNode): Integer;

  Var
    P: PVirtualNode;

  Begin
    Result := 0;
    P := Node.Parent;
    While Assigned(P) Do
      Begin
        Inc(Result);
        P := P.Parent;
      End;
  End;

ResourceString
  strClipboardHeader = 'BADI Checks for %s'#13#10;

Const
  iMultipler = 2;

Var
  CB: TClipBoard;
  strText: String;
  strLine: String;
  Node: PVirtualNode;
  iColumn: Integer;

Begin
  CB := TClipBoard.Create;
  Try
    CB.Open;
    Try
      strText := Format(strClipboardHeader, [FFileName]);
      Node := FVSTChecks.GetFirst();
      While Assigned(Node) Do
        Begin
          strLine := '';
          For iColumn := 0 To FVSTChecks.Header.Columns.Count - 1 Do
            Begin
              If strLine <> '' Then
                strLine := strLine + #9;
              Case iColumn Of
                0: strLine := strLine + StringOfChar(#32, iMultipler * ParentCount(Node)) +
                    FVSTChecks.Text[Node, iColumn];
              Else
                strLine := strLine + FVSTChecks.Text[Node, iColumn];
              End;
            End;
          strText := strText + strLine + #13#10;
          Node := FVSTChecks.GetNext(Node);
        End;
      CB.SetTextBuf(PWideChar(strText));
    Finally
      CB.Close;
    End;
  Finally
    CB.Free;
  End;
End;

(**

  A constructor for the TframeBADIModuleChecksEditorView class.

  @precon  None.
  @postcon Initialises the treeview and the image list.

  @nocheck MissingCONSTInParam

  @param   AOwner as a TComponent

**)
Constructor TframeBADIModuleChecksEditorView.Create(AOwner: TComponent);

{$IFDEF RS102}
Var
  ITS : IOTAIDEThemingServices;
{$ENDIF RS102}
  
Begin
  Inherited Create(AOwner);
  CreateVirtualStringTree;
  FVSTChecks.NodeDataSize := SizeOf(TBADICheckRecord);
  LoadBADIImages(ilScopeImages);
  HookThemingServices(Nil);
  {$IFDEF RS102}
  FThemingServicesNotifierIndex := -1;
  If Supports(BorlandIDEServices, IOTAIDEThemingServices, ITS) Then
    FThemingServicesNotifierIndex := ITS.AddNotifier(TBADIIDEThemeNotifier.Create(HookThemingServices));
  {$ENDIF RS102}
End;

(**

  This method creates the module tree node for the spelling mistakes to sit under.

  @precon  Module must be a valid instance.
  @postcon The module node in the tree view is created.

  @param   Module as a TBaseLanguageModule as a constant
  @return  a TNodeResultRecord

**)
Function TframeBADIModuleChecksEditorView.CreateModule(Const Module:
  TBaseLanguageModule): TNodeResultRecord;

Var
  NodeData : PBADICheckRecord;
  eCheck : TBADIModuleCheck;
    
Begin
  Result.Create(FVSTChecks.AddChild(Nil));
  NodeData := FVSTChecks.GetNodeData(Result.FNode);
  NodeData.FNodeType := ntModule;
  NodeData.FFileName := Module.FileName;
  NodeData.FText := Module.AsString(True, False);
  NodeData.FImageIndex := BADIImageIndex(Module.ImageIndex, Module.Scope);
  NodeData.FIdentLine := Module.Line;
  NodeData.FIdentColumn := Module.Column;
  NodeData.FCommentLine := 0;
  NodeData.FCommentColumn := 0;
  If Assigned(Module.Comment) Then
    Begin
      NodeData.FCommentLine := Module.Comment.Line;
      NodeData.FCommentColumn := Module.Comment.Column;
    End;
  For eCheck := Low(TBADIModuleCheck) To High(TBADIModuleCheck) Do
    NodeData.FChecks[eCheck] := 0;
  NodeData.FTotal := 0;
  NodeData.FIssueCount := 0;
End;

(**

  This method creates the virtual string tree to display the checks.

  @precon  None.
  @postcon The virtual string tree is created.

  @nocheck HardCodedInteger HardCodedString
  @nometric LongMethod Toxicity

**)
Procedure TframeBADIModuleChecksEditorView.CreateVirtualStringTree;

Var
  C: TVirtualTreeColumn;
  eColumn: TBADICheckColumn;

Begin
  FVSTChecks := TBADIEditorViewVirtualStringTree.Create(Self);
  FVSTChecks.Name := 'vstChecks';
  FVSTChecks.Parent := Self;
  FVSTChecks.Align := alClient;
  FVSTChecks.EmptyListMessage := 'Nothing to see here....';
  FVSTChecks.Header.AutoSizeIndex := 0;
  FVSTChecks.Images := ilScopeImages;
  FVSTChecks.PopupMenu := pabContextMenu;
  FVSTChecks.ScrollBarOptions.AlwaysVisible := True;
  FVSTChecks.TabOrder := 0;
  FVSTChecks.OnBeforeCellPaint := vstChecksBeforeCellPaint;
  FVSTChecks.OnCompareNodes := vstChecksCompareNodes;
  FVSTChecks.OnFreeNode := vstChecksFreeNode;
  FVSTChecks.OnGetText := vstChecksGetText;
  FVSTChecks.OnPaintText := vstChecksPaintText;
  FVSTChecks.OnGetImageIndex := vstChecksGetImageIndex;
  FVSTChecks.OnDblClick := vstChecksDblClick;
  For eColumn := Low(TBADICheckColumn) To High(TBADICheckColumn) Do
    Begin
      C := FVSTChecks.Header.Columns.Add;
      C.MinWidth := CheckColumns[eColumn].FMinWidth;
      C.Position := Integer(eColumn);
      C.Style := vsOwnerDraw;
      C.Width := CheckColumns[eColumn].FWidth;
      C.Text := CheckColumns[eColumn].FName;
      C.Alignment := CheckColumns[eColumn].FAlignment;
    End;
  FVSTChecks.Header.Columns[0].Options := FVSTChecks.Header.Columns[0].Options + [coFixed];
End;

(**

  This method deletes a root node from the treeview if it matches the given module name.

  @precon  Module must be a valid instance.
  @postcon The modules node it deleted if found.

  @param   Module as a TBaseLanguageModule as a constant

**)
Procedure TframeBADIModuleChecksEditorView.DeleteExistingModuleNode(Const Module : TBaseLanguageModule);

Var
  Node: PVirtualNode;

Begin
  Node := FVSTChecks.GetFirstChild(FVSTChecks.RootNode);
  While Assigned(Node) Do
    Begin
      If FVSTChecks.Text[Node, 0] = Module.AsString(True, False) Then
        Begin
          FVSTChecks.DeleteNode(Node);
          Break;
        End;
      Node := FVSTChecks.GetNextSibling(Node);
    End;
End;

(**

  A destructor for the TframeBADIModuleChecksEditorView class.

  @precon  None.
  @postcon Does nothing.

**)
Destructor TframeBADIModuleChecksEditorView.Destroy;
  
{$IFDEF RS102}
Var
  ITS : IOTAIDEThemingServices;
{$ENDIF RS102}
  
Begin
  {$IFDEF RS102}
  FThemingServicesNotifierIndex := -1;
  If Supports(BorlandIDEServices, IOTAIDEThemingServices, ITS) Then
    If FThemingServicesNotifierIndex > -1 Then
      ITS.RemoveNotifier(FThemingServicesNotifierIndex);
  {$ENDIF RS102}
  Inherited Destroy;
End;

(**

  This method expands methods with metrics above their limits.

  @precon  None.
  @postcon Methods with metrics above their limits are expanded / visible.

**)
Procedure TframeBADIModuleChecksEditorView.ExpandIssues;

Var
  N: PVirtualNode;
  NodeData : PBADICheckRecord;

Begin
  N := FVSTChecks.GetFirst;
  While Assigned(N) Do
    Begin
      NodeData := FVSTChecks.GetNodeData(N);
      If NodeData.FNodeType = ntMethod Then
        If NodeData.FTotal > 0 Then
          FVSTChecks.VisiblePath[N] := True;
      N := FVSTChecks.GetNext(N);
    End;
End;

(**

  This method searches the given nodes children and updates the parent node with the max values from the
  child nodes.

  @precon  ParentNode must be a valid reference.
  @postcon The parent node is updates with max values from the child nodes.

  @param   ParentNode as a PVirtualNode as a constant

**)
Procedure TframeBADIModuleChecksEditorView.ExtractMaxFromChildren(Const ParentNode : PVirtualNode);

  (**

    This procedure updates the parent node with the given nodes metric information is not overridden.

    @precon  NodeData and ParentNodeData must be valid.
    @postcon The parent node metric information is updated.

    @param   NodeData       as a PBADICheckRecord as a constant
    @param   ParentNodeData as a PBADICheckRecord as a constant
    @param   eCheck         as a TBADIModuleCheck as a constant

  **)
  Procedure ProcessCheck(Const NodeData, ParentNodeData : PBADICheckRecord;
    Const eCheck : TBADIModuleCheck);

  Begin
    If Not (eCheck In NodeData.FCheckOverrides) Then
      If NodeData.FChecks[eCheck] > ParentNodeData.FChecks[eCheck] Then
        ParentNodeData.FChecks[eCheck] := NodeData.FChecks[eCheck];
  End;

Var
  ParentNodeData : PBADICheckRecord;
  NodeData : PBADICheckRecord;
  Node: PVirtualNode;
  eColumn: TBADICheckColumn;

Begin
  If Not Assigned(ParentNode) Then
    Exit;
  ParentNodeData := FVSTChecks.GetNodeData(ParentNode);
  Node := FVSTChecks.GetFirstChild(ParentNode);
  While Assigned(Node) Do
    Begin
      NodeData := FVSTChecks.GetNodeData(Node);
      If NodeData.FNodeType = ntMethod Then
        Begin
          For eColumn := Succ(Low(TBADICheckColumn)) To Pred(High(TBADICheckColumn)) Do
            ProcessCheck(NodeData, ParentNodeData, CheckColumns[eColumn].FCheck);
          If NodeData.FTotal > ParentNodeData.FTotal Then
            ParentNodeData.FTotal := NodeData.FTotal;
        End;
      Node := FVSTChecks.GetNext(Node);
    End;
End;

(**

  This method starts the time to focus the frames treeview to prevent AVs in the editor if there is no
  focused control.

  @precon  None.
  @postcon The timer is started to focus the treeview.

**)
Procedure TframeBADIModuleChecksEditorView.FocusResults;

Begin
  HideZeroColumns;
  tmFocusTimer.Enabled := True;
End;

(**

  This method counts the number of issues in all the given nodes children and returns true if that
  number is not zero.

  @precon  Node must be a valid node reference.
  @postcon Returns true if any child node has issues.

  @param   Node as a PVirtualNode as a constant
  @return  a Boolean

**)
Function TframeBADIModuleChecksEditorView.HasIssues(Const Node: PVirtualNode): Boolean;

Var
  iCounter : Integer;
  
Begin
  FVSTChecks.IterateSubtree(
    Node,
    Procedure(Sender: TBaseVirtualTree; ptrNode: PVirtualNode; ptrData: Pointer; Var boolAbort: Boolean)
    Var
      NodeData : PBADICheckRecord;
    Begin
      NodeData := Sender.GetNodeData(ptrNode);
      Inc(iCounter, NodeData.FIssueCount);
    End,
    Nil);
  Result := iCounter > 0;
End;

(**

  This method hides some of the columns if they have no issues to make the view narrower.

  @precon  None.
  @postcon Any column with no issues is hidden (except method and total).

**)
Procedure TframeBADIModuleChecksEditorView.HideZeroColumns;

Var
  eColumn : TBADICheckColumn;
  iCount: Integer;
  N: PVirtualNode;
  NodeData : PBADICheckRecord;

Begin
  For eColumn := Succ(Low(TBADICheckColumn)) To Pred(High(TBADICheckColumn)) Do
    If doAutoHideChecksWithNoissues In TBADIOptions.BADIOptions.Options Then
      Begin
        iCount := 0;
        N := FVSTChecks.GetFirst();
        While Assigned(N) Do
          Begin
            NodeData := FVSTChecks.GetNodeData(N);
            Inc(iCount, Trunc(NodeData.FChecks[CheckColumns[eColumn].FCheck]));
            N := FVSTChecks.GetNext(N);
          End;
        If iCount = 0 Then
          FVSTChecks.Header.Columns[Integer(eColumn)].Options :=
            FVSTChecks.Header.Columns[Integer(eColumn)].Options - [coVisible]
        Else
          FVSTChecks.Header.Columns[Integer(eColumn)].Options :=
            FVSTChecks.Header.Columns[Integer(eColumn)].Options + [coVisible];
      End Else
        FVSTChecks.Header.Columns[Integer(eColumn)].Options :=
          FVSTChecks.Header.Columns[Integer(eColumn)].Options + [coVisible];
End;

(**

  This method Hooks the IDEs Style Services if they are available and enabled.

  @precon  None.
  @postcon The IDEs style services are hooked if available and enabled else its set to nil.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.HookThemingServices(Sender : TObject);

{$IFDEF RS102}
Var
  ITS : IOTAIDEThemingServices;
{$ENDIF RS102}
  
Begin
  {$IFDEF RS102}
  FStyleServices := Nil;
  If Supports(BorlandIDEServices, IOTAIDEThemingServices, ITS) Then
    If ITS.IDEThemingEnabled Then
      Begin
        FStyleServices := ITS.StyleServices;
        ITS.ApplyTheme(Self);
      End;
  {$ENDIF RS102}
End;

(**

  This method processes the given function and returns its method information.

  @precon  None.
  @postcon The metric information for the given function is returned.

  @param   NodeData  as a PBADICheckRecord as a constant
  @param   AFunction as a TGenericFunction as a constant
  @return  a TNodeResultRecord

**)
Function TframeBADIModuleChecksEditorView.ProcessFunction(Const NodeData : PBADICheckRecord;
  Const AFunction : TGenericFunction) : TNodeResultRecord;

  (**

    This procedure updates the issue count for the node and result is the given metric is not overridden.

    @precon  None.
    @postcon The issue counts are updated.

    @param   eCheck as a TBADIModuleCheck as a constant

  **)
  Procedure ProcessCheck(Const eCheck : TBADIModuleCheck);

  Begin
    NodeData.FChecks[eCheck] := AFunction.Check[eCheck];
    If Not (eCheck In NodeData.FCheckOverrides) Then
      Begin
        NodeData.FTotal := NodeData.FTotal + NodeData.FChecks[eCheck];
        Inc(Result.FIssueCount, Integer(NodeData.FChecks[eCheck] > 0));
        Inc(NodeData.FIssueCount, Integer(NodeData.FChecks[eCheck] > 0));
      End;
  End;
  
Var
  eColumn: TBADICheckColumn;
  
Begin
  Result.Create(Nil);
  NodeData.FNodeType := ntMethod;
  NodeData.FCheckOverrides := AFunction.CheckOverrides;
  For eColumn := Succ(Low(TBADICheckColumn)) To Pred(High(TBADICheckColumn)) Do
    ProcessCheck(CheckColumns[eColumn].FCheck);
  Inc(Result.FChildCount);
End;

(**

  This method recursively walks the given container rendering its contents in the tree view. If the 
  container is a generic function, metrics are extracted from the method and displayed. Any branches with
  out methods are pruned.

  @precon  Container must be a valid instance.
  @postcon The metrics of the module method are displayed.

  @param   Container as a TElementContainer as a constant
  @param   Parent    as a PVirtualNode as a constant
  @return  a TNodeResultRecord

**)
Function TframeBADIModuleChecksEditorView.RecurseContainer(Const Container: TElementContainer;
  Const Parent: PVirtualNode): TNodeResultRecord;

Var
  NodeData: PBADICheckRecord;
  iElement: Integer;
  M: TGenericFunction;

Begin
  Result.Create(FVSTChecks.AddChild(Parent));
  NodeData := FVSTChecks.GetNodeData(Result.FNode);
  NodeData.FNodeType := ntUnkown;
  NodeData.FText := Container.AsString(True, False);
  NodeData.FImageIndex := BADIImageIndex(Container.ImageIndex, Container.Scope);
  NodeData.FIdentLine := Container.Line;
  NodeData.FIdentColumn := Container.Column;
  If Assigned(Container.Comment) Then
    Begin
      NodeData.FCommentLine := Container.Comment.Line;
      NodeData.FCommentColumn := Container.Comment.Column;
    ENd;
  If Container Is TGenericFunction Then
    Begin
      M := Container As TGenericFunction;
      If Not M.IsDeclarationOnly Then
        Result := Result + ProcessFunction(NodeData, M);
    End;
  For iElement := 1 To Container.ElementCount Do
    Result := Result + RecurseContainer(Container.Elements[iElement], Result.FNode);
  If Result.FChildCount = 0 Then
    Begin
      FVSTChecks.DeleteNode(Result.FNode);
      Result.FNode := Nil;
    End;
  If Not (Container Is TGenericFunction) Then
    ExtractMaxFromChildren(Result.FNode);
End;

(**

  This method starts the process of rendering the module contents.

  @precon  Module must be valid.
  @postcon The modules methods and their metrics are rendered.

  @param   Module           as a TBaseLanguageModule as a constant
  @param   setRenderOptions as a TBADIRenderOptions as a constant

**)
Procedure TframeBADIModuleChecksEditorView.RenderModule(Const Module: TBaseLanguageModule;
  Const setRenderOptions: TBADIRenderOptions);

Var
  NodeResult: TNodeResultRecord;
  ImplementedMethods: TElementContainer;

Begin
  If Assigned(Module) And Assigned(FVSTChecks) Then
    Begin
      FFileName := Module.FileName;
      FVSTChecks.BeginUpdate;
      Try
        If roClear In setRenderOptions Then
          FVSTChecks.Clear
        Else
          DeleteExistingModuleNode(Module);
        NodeResult := CreateModule(Module);
        ImplementedMethods := Module.FindElement(strImplementedMethodsLabel);
        If Assigned(ImplementedMethods) Then
          NodeResult := NodeResult + RecurseContainer(ImplementedMethods, NodeResult.FNode);
        SortAndExpand(NodeResult, setRenderOptions);
        UpdateStats;
      Finally
        FVSTChecks.EndUpdate;
      End;
    End;
  FocusResults;
End;

(**

  This method sorts and expands the rendered module.

  @precon  None.
  @postcon The rendered node (if valid) is sorted and expanded.

  @param   NodeResult       as a TNodeResultRecord as a constant
  @param   setRenderOptions as a TBADIRenderOptions as a constant

**)
Procedure TframeBADIModuleChecksEditorView.SortAndExpand(Const NodeResult : TNodeResultRecord;
  Const setRenderOptions : TBADIRenderOptions);

Begin
  If Assigned(NodeResult.FNode) Then
    If roAutoExpand In setRenderOptions Then
      Begin
        If ((roAutoExpandOnError In setRenderOptions) And (NodeResult.FIssueCount > 0)) Or
          Not (roAutoExpandOnError In setRenderOptions) Then
        ExpandIssues;
      End;
End;

(**

  This treeview needs to be focus to stop mouse scrolling message being directed to the editor (which
  does not exists) so this timer waits for the treeview to be visible and then gives it focus.

  @precon  None.
  @postcon Focuses the treeview when it is visible.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.tmFocusTimerTimer(Sender: TObject);

Begin
  If FVSTChecks.CanFocus Then
    Begin
      tmFocusTimer.Enabled := False;
      FVSTChecks.SetFocus;
    End;
End;

(**

  This method updates the module count, method count and under, at and over limits counts.

  @precon  None.
  @postcon The counts are updated.

**)
Procedure TframeBADIModuleChecksEditorView.UpdateStats;

  (**

    This procedure updates the FUnderLimit or FOverLimit fields depending upon the value
    of the metric compared to the limit.

    @precon  None.
    @postcon Updates the FUnderLimit or FOverLimit fields depending upon the value
             of the metric compared to the limit.

    @param   dblValue as a Double as a constant

  **)
  Procedure Update(Const dblValue: Double);

  Begin
    If dblValue = 0 Then
      Inc(FUnderLimit)
    Else 
      Inc(FOverLimit);
  End;

Var
  Node: PVirtualNode;
  NodeData: PBADICheckRecord;
  eColumn: TBADICheckColumn;

Begin
  FModuleCount := 0;
  FMethodCount := 0;
  FUnderLimit := 0;
  FOverLimit := 0;
  Node := FVSTChecks.GetFirst();
  While Assigned(Node) Do
    Begin
      NodeData := FVSTChecks.GetNodeData(Node);
      Case NodeData.FNodeType Of
        ntModule: Inc(FModuleCount);
        ntMethod:
          Begin
            Inc(FMethodCount);
            For eColumn := Succ(Low(TBADICheckColumn)) To Pred(High(TBADICheckColumn)) Do
              Update(NodeData.FChecks[CheckColumns[eColumn].FCheck]);
          End;
      End;
      Node := FVSTChecks.GetNext(Node);
    End;
End;

(**

  This is an on before cell paint method.

  @precon  None.
  @postcon The metric cells are colours as follows: Light Green for up to 95% of the limit; Amber for
           95% to 105% of the limit and Light Red for over 105% of the limit.

  @param   Sender        as a TBaseVirtualTree
  @param   TargetCanvas  as a TCanvas
  @param   Node          as a PVirtualNode
  @param   Column        as a TColumnIndex
  @param   CellPaintMode as a TVTCellPaintMode
  @param   CellRect      as a TRect
  @param   ContentRect   as a TRect as a reference

**)
Procedure TframeBADIModuleChecksEditorView.vstChecksBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
  CellRect: TRect; Var ContentRect: TRect);

  (**

    This function returns the colours to be used based on the value and the limit.

    @precon  dblValue cannot be zero.
    @postcon Returns the colours to be used based on the value and the limit.

    @param   dblValue as a Double as a constant
    @return  a TColor

  **)
  Function Colour(Const dblValue : Double): TColor;

  Const
    dblBlendRatioModule = 0.25;

  Begin
    Result := TargetCanvas.Brush.Color;
    If dblValue > 0 Then
      Result := BlendColour(iLightRed, Result, dblBlendRatioModule)
  End;

Var
  NodeData: PBADICheckRecord;

Begin
  NodeData := FVSTChecks.GetNodeData(Node);
  TargetCanvas.Brush.Color := clWindow;
  {$IFDEF RS102}
  If Assigned(FStyleServices) Then
    TargetCanvas.Brush.Color := FStyleServices.GetSystemColor(clWindow);
  {$ENDIF RS102}
  Case TBADICheckColumn(Column) Of
    ccHardCodedIntegers..ccMissingCONSTInParemterList:
      Begin
        TargetCanvas.Brush.Color :=
          Colour(NodeData.FChecks[CheckColumns[TBADICheckColumn(Column)].FCheck]);
        If CheckColumns[TBADICheckColumn(Column)].FCheck In NodeData.FCheckOverrides Then
          TargetCanvas.Brush.Color := iLightAqua;
      End;
    ccTotal: TargetCanvas.Brush.Color := Colour(NodeData.FTotal);
  End;
  TargetCanvas.FillRect(CellRect);
End;

(**

  This is an on compare node event handler for the treeview.

  @precon  None.
  @postcon Ensures the nodes are sorted.

  @param   Sender as a TBaseVirtualTree
  @param   Node1  as a PVirtualNode
  @param   Node2  as a PVirtualNode
  @param   Column as a TColumnIndex
  @param   Result as an Integer as a reference

**)
Procedure TframeBADIModuleChecksEditorView.vstChecksCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; Var Result: Integer);

Begin
  Result := CompareText(FVSTChecks.Text[Node1, 0], FVSTChecks.Text[Node2, 0]);
End;

(**

  This method attempts to display the method that was double clicked on.

  @precon  None.
  @postcon The method that was clicked on is displayed if it can be shown.

  @param   Sender as a TObject

**)
Procedure TframeBADIModuleChecksEditorView.vstChecksDblClick(Sender: TObject);

Var
  Node : PVirtualNode;
  NodeData : PBADICheckRecord;
  strFileName : String;
  MS : IOTAModuleServices;
  Module: IOTAModule;
  
Begin
  Node := FVSTChecks.FocusedNode;
  While Assigned(Node) Do
    Begin
      NodeData := FVSTChecks.GetNodeData(Node);
      If Length(NodeData.FFileName) > 0 Then
        strFileName := NodeData.FFileName;
      Node := FVSTChecks.NodeParent[Node];
    End;
  If Supports(BorlandIDEServices, IOTAModuleServices, MS) Then
    Begin
      Module := MS.FindModule(strFileName);
      If Not Assigned(Module) Then
        Module := MS.OpenModule(strFileName);
      If Assigned(Module) Then
        Begin
          Module.Show;
          Node := FVSTChecks.FocusedNode;
          NodeData := FVSTChecks.GetNodeData(Node);
          TBADIToolsAPIFunctions.PositionCursor(NodeData.FIdentLine, NodeData.FIdentColumn,
            NodeData.FCommentLine, TBADIOptions.BADIOptions.BrowsePosition);
        End;
    End;
End;

(**

  This is an on Free Node event handler for the treeview.

  @precon  None.
  @postcon Ensures that the managed types in the node are freed.

  @param   Sender as a TBaseVirtualTree
  @param   Node   as a PVirtualNode

**)
Procedure TframeBADIModuleChecksEditorView.vstChecksFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);

Var
  NodeData : PBADICheckRecord;
  
Begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^);
End;

(**

  This is an on get image index event handler for the treeview.

  @precon  None.
  @postcon Returns the node icon for the tree item.

  @param   Sender     as a TBaseVirtualTree
  @param   Node       as a PVirtualNode
  @param   Kind       as a TVTImageKind
  @param   Column     as a TColumnIndex
  @param   Ghosted    as a Boolean as a reference
  @param   ImageIndex as a TImageIndex as a reference

**)
Procedure TframeBADIModuleChecksEditorView.vstChecksGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; Var Ghosted: Boolean;
  Var ImageIndex: TImageIndex);

Var
  NodeData: PBADICheckRecord;

Begin
  If Column = 0 Then
    Begin
      NodeData := FVSTChecks.GetNodeData(Node);
      If Kind In [ikNormal, ikSelected] Then
        ImageIndex := NodeData.FImageIndex;
    End;
End;

(**

  This is an on get text event handler for the treeview.

  @precon  None.
  @postcon Returns the text to be shown for the tree node and column.

  @param   Sender   as a TBaseVirtualTree
  @param   Node     as a PVirtualNode
  @param   Column   as a TColumnIndex
  @param   TextType as a TVSTTextType
  @param   CellText as a String as a reference

**)
Procedure TframeBADIModuleChecksEditorView.vstChecksGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; Var CellText: String);

Var
  NodeData: PBADICheckRecord;
  eCheck: TBADIModuleCheck;

Begin
  NodeData := FVSTChecks.GetNodeData(Node);
  CellText := '';
  Case TBADICheckColumn(Column) Of
    ccText: CellText := NodeData.FText;
    ccTotal: 
      If NodeData.FTotal > 0 Then
        CellText := Format('%1.0n', [NodeData.FTotal]);
  Else
    eCheck := CheckColumns[TBADICheckColumn(Column)].FCheck;
    If NodeData.FChecks[eCheck] > 0 Then
      CellText := Format('%1.0n', [NodeData.FChecks[eCheck]]);
  End;
End;

(**

  This is an on Paint Text event handler for the treeview.

  @precon  None.
  @postcon If the node has no parent (i.e. its a root node) then make it bold and blue.

  @param   Sender       as a TBaseVirtualTree
  @param   TargetCanvas as a TCanvas as a constant
  @param   Node         as a PVirtualNode
  @param   Column       as a TColumnIndex
  @param   TextType     as a TVSTTextType

**)
Procedure TframeBADIModuleChecksEditorView.vstChecksPaintText(Sender: TBaseVirtualTree;
  Const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);

Var
  NodeData : PBADICheckRecord;
  
Begin
  TargetCanvas.Font.Style := [];
  TargetCanvas.Font.Color := clWindowText;
  {$IFDEF RS102}
  If Assigned(FStyleServices) Then
    TargetCanvas.Font.Color := FStyleServices.GetSystemColor(clWindowText);
  {$ENDIF RS102}
  Case TBADICheckColumn(Column) Of
    ccHardCodedIntegers..ccTotal: TargetCanvas.Font.Color := clBlack;
  End;
  NodeData := FVSTChecks.GetNodeData(Node);
  If Not (NodeData.FNodeType In [ntMethod]) Then
    Begin
      If Column = 0 Then
        TargetCanvas.Font.Style := [fsBold];
    End;
End;

End.
