(**

  This module encapsulates the creation of menus in the IDE.

  @Version 23.735
  @Author  David Hoyle
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

**)
Unit BADI.IDEMenuInstaller;

Interface

Uses
  ToolsAPI,
  Menus,
  Classes,
  BADI.EditorNotifier,
  BADI.Base.Module,
  Windows,
  BADI.ProfilingForm,
  BADI.Types,
  Contnrs,
  ActnList,
  Graphics;

{$INCLUDE CompilerDefinitions.inc}

Type
  (** This class manages the creation and destruction of the IDE menus. **)
  TBADIIDEMenuInstaller = Class
  Strict Private
    FBADIMenu       : TMenuItem;
    FBADIActions    : Array[Low(TBADIMenu)..High(TBADIMenu)] Of TAction;
    FEditorNotifier : TEditorNotifier;
  Strict Protected
    Function  CreateMenuItem(Const mmiParent: TMenuItem; Const eBADIMenu: TBADIMenu;
      Const ClickProc, UpdateProc: TNotifyEvent; Const iImageIndex : Integer) : TMenuItem;
    Procedure InsertCommentBlock(Const CommentStyle: TCommentStyle; Const CommentType: TCommentType);
    Function  IsTextSelected(Const SourceEditor : IOTASourceEditor): Boolean;
    Function  SelectedText(Const boolDelete : Boolean): String;
    Procedure DeleteExistingComment(Const Source: IOTASourceEditor; Const iStartLine, iEndLine: Integer);
    Procedure InsertComment(Const strComment: String; Const Writer: IOTAEditWriter;
      Const iInsertLine: Integer);
    Procedure PositionCursorInFunction(Const CursorDelta: TPoint; Const iInsertLine: Integer;
      Const strComment: String);
    Procedure ProcessProfilingCode(Const Module : TBaseLanguageModule; Const SE: IOTASourceEditor;
      Const ProfileJob: TProfileJob; Const iTabs: Integer);
    Procedure InsertProfileCode(Const SE: IOTASourceEditor; Const ProfileJob: TProfileJob;
      Const strProlog, strEpilog: String);
    Procedure RemoveProfileCode(Const SE: IOTASourceEditor; Const ProfileJob: TProfileJob;
      Const slProlog, slEpilog: TStringList);
    Procedure DeleteProfileCode(Const SE: IOTASourceEditor; Const iStartLine, iEndLine: Integer);
    Procedure MethodCommentClick(Sender: TObject);
    Procedure PropertyCommentClick(Sender: TObject);
    Procedure BlockCommentClick(Sender: TObject);
    Procedure LineCommentClick(Sender: TObject);
    Procedure InSituCommentClick(Sender: TObject);
    Procedure TaggedCommentClick(Sender: TObject);
    Procedure DocumentationClick(Sender: TObject);
    Procedure DUnitClick(Sender: TObject);
    Procedure ProfilingClick(Sender: TObject);
    Procedure OptionsClick(Sender: TObject);
    Procedure ModuleExplorerClick(Sender: TObject);
    Procedure MetricsClick(Sender : TObject);
    Procedure ChecksClick(Sender : TObject);
    Procedure SpellingClick(Sender : TObject);
    Procedure CreateBADIMainMenu;
    Procedure RemoveActionsFromToolbars;
    Function  AddImagesToIDE : Integer;
    function  BlockStartCursorPos(const ES: IOTAEditorServices): TOTAEditPos;
    Procedure NilActions;
    Procedure FreeActions;
    Function  InsertLineComments(Const strComment: String; Const iCol : Integer;
      Const strCmtText : String) : String;
    Procedure InsertTaggedComment(Const strTagName: String; Const eCommentType: TCommentType);
    Procedure MoveCursorToBlockStart(Const ES: IOTAEditorServices; Const Writer: IOTAEditWriter);
    Procedure RefactorConstantClick(Sender : TObject);
  Public
    Constructor Create(Const EditorNotifier : TEditorNotifier);
    Destructor Destroy; Override;
    Procedure SelectionChange(Const iIdentLine, iIdentCol, iCommentLine : Integer);
    Procedure Focus(Sender: TObject);
    Procedure OptionsChange(Sender: TObject);
    Procedure UpdateMenuShortcuts;
  End;

Implementation

Uses
  {$IFDEF DEBUG}
  CodeSiteLogging,
  {$ENDIF}
  SysUtils,
  StrUtils,
  BADI.Documentation.Dispatcher,
  BADI.ToolsAPIUtils,
  BADI.DocumentationOptionsForm,
  ShellAPI,
  Forms,
  BADI.DUnitCreator,
  BADI.DUnitForm,
  Dialogs,
  Controls,
  BADI.CommonIDEFunctions,
  BADI.DockableModuleExplorer,
  BADI.ProgressForm,
  BADI.Module.Dispatcher,
  BADI.ElementContainer,
  BADI.Generic.FunctionDecl,
  BADI.ResourceStrings,
  BADI.Generic.MethodDecl,
  BADI.Generic.PropertyDecl,
  BADI.Options,
  BADI.Functions,
  ComCtrls,
  BADI.Constants, 
  BADI.Base.Documentation, 
  BADI.Refactor.Constant, 
  BADI.Module.Metrics, 
  BADI.Module.Checks, 
  BADI.Module.Spelling, BADI.CommentCodeForm;

ResourceString
  (** This is a resource message to confirm whether the selected text should be
      moved. **)
  strThereIsSelectedText = 'There is selected text in the editor. Do you want to move this text ' +
    'within the new comment';

Const
  (** A constant name suffix tag for images names in the new IDE virtual image list. **)
  strImage = 'Image';

(**

  This method adds multiple images from the projects resource (bitmap) to the IDEs image list.
  The image name in the resource must end in Image as this is appended to the given name.
  An integer for the position of the first image in the IDEs image list is returned.

  @precon  None.
  @postcon The named image is loaded from the projects resource and put into the IDEs
           image list and its index returned.

  @return  an Integer

**)
Function TBADIIDEMenuInstaller.AddImagesToIDE : Integer;

Var
  NTAS : INTAServices;
  {$IFNDEF RS110}
  ilImages : TImageList;
  {$ENDIF RS110}
  BM : TBitMap;
  iMenu: TBADIMenu;

begin
  Result := -1;
  NTAS := (BorlandIDEServices As INTAServices);
  {$IFNDEF RS110}
  ilImages := TImageList.Create(Nil);
  Try
  {$ENDIF RS110}
    For iMenu := Low(TBADIMenu) To High(TBADIMenu) Do
      If FindResource(hInstance, PChar(BADIMenus[iMenu].FName + strImage), RT_BITMAP) > 0 Then
        Begin
          BM := TBitMap.Create;
          Try
            BM.LoadFromResourceName(hInstance, BADIMenus[iMenu].FName + strImage);
            {$IFDEF RS110}
            NTAS.AddImage(BADIMenus[iMenu].FName + strImage, [BM]);
            {$ELSE}
            ilImages.AddMasked(BM, BADIMenus[iMenu].FMaskColor);
            {$ENDIF RS110}
          Finally
            BM.Free;
          End;
        End;
  {$IFNDEF RS110}
    Result := NTAS.AddImages(ilImages);
  Finally
    ilImages.Free;
  End;
  {$ENDIF RS110}
end;

(**

  This method is a menu On Click event for the insertion of a comment block at
  the cursor.

  This simple adds a comment block at the current cursor position in the active
  source code editor.

  @precon  Sender is the object initiating the event.
  @postcon Inserts a block comment into the editor.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.BlockCommentClick(Sender: TObject);

Var
  SE: IOTASourceEditor;

Begin
  SE := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If SE <> Nil Then
    InsertCommentBlock(csBlock, TBADIDispatcher.BADIDispatcher.GetCommentType(SE.FileName, csBlock));
End;

(**

  This method returns the block start editor position.

  @precon  None.
  @postcon Returns the block start editor position.

  @param   ES as an IOTAEditorServices as a constant
  @return  a TOTAEditPos

**)
Function TBADIIDEMenuInstaller.BlockStartCursorPos(Const ES: IOTAEditorServices): TOTAEditPos;

Begin
  If ES.TopBuffer.BlockVisible Then
    Begin
      Result.Col := ES.TopBuffer.BlockStart.CharIndex + 1;
      Result.Line := ES.TopBuffer.BlockStart.Line;
    End Else
      Result := ES.TopView.CursorPos;
End;

(**

  This is an on action event handler for the BADI Checks project editor view.

  @precon  None.
  @postcon Displays the editor view of module/method checks.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.ChecksClick(Sender: TObject);

Begin
  TBADIModuleChecksEditorView.CreateEditorView; 
End;

(**

  A constructor for the TBADIIDEMenuInstaller class.

  @precon  None.
  @postcon Creates the IDE menus.

  @param   EditorNotifier as a TEditorNotifier as a Constant

**)
Constructor TBADIIDEMenuInstaller.Create(Const EditorNotifier : TEditorNotifier);

Var
  iImageIndex: Integer;

Begin
  NilActions;
  FEditorNotifier := EditorNotifier;
  CreateBADIMainMenu;
  iImageIndex := AddImagesToIDE;
  CreateMenuItem(FBADIMenu, bmModuleExplorer, ModuleExplorerClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmDocumentation, DocumentationClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmDunit, DUnitClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmProfiling, ProfilingClick, Nil, iImageIndex);
  CreateMenuItem(FBADIMenu, bmSep1, Nil, Nil, 0);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmFocusEditor, Focus, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmMethodComment, MethodCommentClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmPropertyComment, PropertyCommentClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmBlockComment, BlockCommentClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmLineComment, LineCommentClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmInSituComment, InSituCommentClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmToDoComment, TaggedCommentClick, Nil, iImageIndex);
  CreateMenuItem(FBADIMenu, bmSep2, Nil, Nil, 0);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmRefactorConstant, RefactorConstantClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmBADIMetrics, MetricsClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmBADIChecks, ChecksClick, Nil, iImageIndex);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmBADISpelling, SpellingClick, Nil, iImageIndex);
  CreateMenuItem(FBADIMenu, bmSep3, Nil, Nil, 0);
  Inc(iImageIndex);
  CreateMenuItem(FBADIMenu, bmOptions, OptionsClick, Nil, iImageIndex);
End;

(**

  This method creates the main BADI menu item and stores it for later disposal.

  @precon  None.
  @postcon The main BADI menu it added to the IDE.

**)
Procedure TBADIIDEMenuInstaller.CreateBADIMainMenu;

ResourceString
  {$IFDEF DEBUG}
  strBrowseAndDocItDEBUG = '&Browse and Doc It %d.%d%s BETA (Build %d.%d.%d.%d)';
  {$ELSE}
  strBrowseAndDocIt = '&Browse and Doc It %d.%d%s';
  {$ENDIF}

  Const
  iMenuOffset = 2;

Var
  mmiMainMenu: TMainMenu;
  iMajor, iMinor, iBugFix, iBuild : Integer;

Begin
  mmiMainMenu := (BorlandIDEServices As INTAServices).MainMenu;
  FBADIMenu := TMenuItem.Create(mmiMainMenu);
  BuildNumber(iMajor, iMinor, iBugFix, iBuild);
  {$IFDEF DEBUG}
  FBADIMenu.Caption := Format(strBrowseAndDocItDEBUG, [iMajor, iMinor, strRevision[Succ(iBugfix)],
    iMajor, iMinor, iBugfix, iBuild]);
  {$ELSE}
  FBADIMenu.Caption := Format(strBrowseAndDocIt, [iMajor, iMinor, strRevision[Succ(iBugfix)]]);
  {$ENDIF}
  mmiMainMenu.Items.Insert(mmiMainMenu.Items.Count - iMenuOffset, FBADIMenu);
End;

(**

  This method creates menu items using the passed information.

  @precon  mmiParent must be a valid parent menu item in the IDE .
  @postcon A Sub menu item is created under mmiParent .

  @param   mmiParent   as a TMenuItem as a constant
  @param   eBADIMenu   as a TBADIMenu as a constant
  @param   ClickProc   as a TNotifyEvent as a constant
  @param   UpdateProc  as a TNotifyEvent as a constant
  @param   iImageIndex as an Integer as a constant
  @return  a TMenuItem

**)
Function TBADIIDEMenuInstaller.CreateMenuItem(Const mmiParent: TMenuItem; Const eBADIMenu : TBADIMenu;
  Const ClickProc, UpdateProc : TNotifyEvent; Const iImageIndex : Integer) : TMenuItem;

Const
  strAction = 'Action';
  strCategory = 'BADIActions';
  strMenu = 'Menu';
  
Var
  NTAS: INTAServices;
  Actn : TAction;

Begin
  NTAS := (BorlandIDEServices As INTAServices);
  // Create the IDE action (cached for removal later)
  Actn := Nil;
  Result := TMenuItem.Create(NTAS.MainMenu);
  If Assigned(ClickProc) Then
    Begin
      Actn := TAction.Create(NTAS.ActionList);
      Actn.ActionList := NTAS.ActionList;
      Actn.Name := BADIMenus[eBADIMenu].FName + strAction;
      Actn.Caption := BADIMenus[eBADIMenu].FCaption;
      Actn.OnExecute := ClickProc;
      Actn.OnUpdate := UpdateProc;
      Actn.ShortCut := TextToShortCut(TBADIOptions.BADIOptions.MenuShortcut[eBADIMenu]);
      {$IFDEF RS110}
      Actn.ImageName := BADIMenus[eBADIMenu].FName + strImage;
      {$ELSE}
      Actn.ImageIndex := iImageIndex;
      {$ENDIF RS110}
      Actn.Category := strCategory;
      FBADIActions[eBADIMenu] := Actn;
    End Else
  If BADIMenus[eBADIMenu].FCaption <> '' Then
    Begin
      Result.Caption := BADIMenus[eBADIMenu].FCaption;
      Result.ImageIndex := iImageIndex;
    End Else
      Result.Caption := '-';
  // Create menu (removed through parent menu)
  Result.Action := Actn;
  Result.Name := BADIMenus[eBADIMenu].FName + strMenu;
  // Create Action and Menu.
  mmiParent.Add(Result);
End;

(**

  This method deletes the comment between the start and end lines of the editor.

  @precon  None.
  @postcon Deletes the comment between the start and end lines of the editor.

  @param   Source     as an IOTASourceEditor as a constant
  @param   iStartLine as an Integer as a constant
  @param   iEndLine   as an Integer as a constant

**)
Procedure TBADIIDEMenuInstaller.DeleteExistingComment(Const Source: IOTASourceEditor; Const iStartLine,
  iEndLine: Integer);

Var
  EditorSvcs              : IOTAEditorServices;
  Writer                  : IOTAEditWriter;
  ptStart, ptEnd          : TOTACharPos;
  iBufferStart, iBufferEnd: Integer;

Begin
  Writer := Source.CreateUndoableWriter;
  Try
    If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
      Begin
        ptStart.Line := iStartLine;
        ptStart.CharIndex := 0;
        iBufferStart := EditorSvcs.TopView.CharPosToPos(ptStart);
        Writer.CopyTo(iBufferStart);
        ptEnd.Line := iEndLine;
        ptEnd.CharIndex := 0;
        iBufferEnd := EditorSvcs.TopView.CharPosToPos(ptEnd);
        Writer.DeleteTo(iBufferEnd);
      End;
  Finally
    Writer := Nil;
  End;
End;

(**

  This method deletes the profile code from the editor window.

  @precon  SE must be a valid instance.
  @postcon Deletes the profile text between the given line numbers.

  @param   SE         as an IOTASourceEditor as a constant
  @param   iStartLine as an Integer as a constant
  @param   iEndLine   as an Integer as a constant

**)
Procedure TBADIIDEMenuInstaller.DeleteProfileCode(Const SE: IOTASourceEditor; Const iStartLine,
  iEndLine: Integer);

Var
  EditorSvcs              : IOTAEditorServices;
  Writer                  : IOTAEditWriter;
  C1, C2                  : TOTACharPos;
  iBufferPos1, iBufferPos2: Integer;

Begin
  Writer := SE.CreateUndoableWriter;
  Try
    If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
      Begin
        C1.Line      := iStartLine;
        C1.CharIndex := 0;
        iBufferPos1  := EditorSvcs.TopView.CharPosToPos(C1);
        C2.Line      := iEndLine + 1;
        C2.CharIndex := 0;
        iBufferPos2  := EditorSvcs.TopView.CharPosToPos(C2);
        Writer.CopyTo(iBufferPos1);
        Writer.DeleteTo(iBufferPos2);
      End;
  Finally
    Writer := Nil;
  End;
End;

(**

  A destructor for the TBADIIDEMenuInstaller class.

  @precon  None.
  @postcon Uninstalls the menu from the IDE.

**)
Destructor TBADIIDEMenuInstaller.Destroy;

Begin
  If FBADIMenu <> Nil Then
    FBADIMenu.Free;
  RemoveActionsFromToolbars;
  FreeActions;
  Inherited Destroy;
End;

(**


  This is an on click event handler for the documentation menu.

  @precon  None.
  @postcon Invokes the documentation of the current active project.


  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.DocumentationClick(Sender: TObject);

Const
  strDocumentation = 'Documentation';
  strVerb = 'open';
  
Var
  ADocType: TDocType;
  AProject: IOTAProject;
  i       : Integer;
  DD : TBaseDocumentation;

Begin
  AProject := TBADIToolsAPIFunctions.ActiveProject;
  If AProject <> Nil Then
    If TfrmDocumentationOptions.Execute(ADocType) Then
      Begin
        DD := DocumentDispatcher(
          ExtractFilePath(AProject.FileName) + strDocumentation,
          {$IFDEF D2005}
          ExtractFileName(AProject.ProjectOptions.TargetName), ADocType)
          {$ELSE}
          ExtractFileName(AProject.FileName), ADocType)
          {$ENDIF};
        Try
          DD.Add(AProject.FileName);
          For i := 0 To AProject.ModuleFileCount - 1 Do
            DD.Add(AProject.ModuleFileEditors[i].FileName);
          For i := 0 To AProject.GetModuleCount - 1 Do
            DD.Add(AProject.GetModule(i).FileName);
          DD.OutputDocumentation;
          ShellExecute(Application.Handle, strVerb, PChar(DD.MainDocument), '', '', SW_SHOWNORMAL);
        Finally
          DD.Free;
        End;
      End;
End;

(**

  This method creates an instance of a DUnit form and passes a class instance
  that can create projects and units for the form.

  @precon  None.
  @postcon Creates an instance of a DUnit form and passes a class instance
           that can create projects and units for the form.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.DUnitClick(Sender: TObject);

ResourceString
  strSelectSourceCode = 'You must select a source code editor to create unit tests.';
  strNoSelectedProject = 'There is no active project in the project group.';

Var
  D: TDUnitCreator;

Begin
  If TBADIToolsAPIFunctions.ActiveSourceEditor <> Nil Then
    Begin
      If TBADIToolsAPIFunctions.ActiveProject <> Nil Then
        Begin
          D := TDUnitCreator.Create;
          Try
            TfrmDUnit.Execute(D);
          Finally
            D.Free;
          End;
        End
      Else
        MessageDlg(strNoSelectedProject, mtError, [mbOK], 0);
    End
  Else
    MessageDlg(strSelectSourceCode, mtError, [mbOK], 0);
End;

(**

  This method is an event handler for the On Focus event from the explorer
  frame.

  @precon  None.
  @postcon Focuses the active editor.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.Focus(Sender: TObject);

Begin
  TBADIToolsAPIFunctions.FocusActiveEditor;
End;

(**

  This method cycles through the BADI Menu Actions and frees any that have been created.

  @precon  None.
  @postcon All BADI Actions are freed and removed from the IDE.

**)
Procedure TBADIIDEMenuInstaller.FreeActions;

Var
  iBADIMenu: TBADIMenu;

Begin
  For iBADIMenu := Low(TBADIMenu) To High(TBADIMenu) Do
    If Assigned(FBADIActions[iBADIMenu]) Then
      FBADIActions[iBADIMenu].Free;
End;

(**

  This method inserts the given comment into the editor at the given insert line.

  @precon  None.
  @postcon Inserts the given comment into the editor at the given insert line.

  @param   strComment  as a String as a constant
  @param   Writer      as an IOTAEditWriter as a constant
  @param   iInsertLine as an Integer as a constant

**)
Procedure TBADIIDEMenuInstaller.InsertComment(Const strComment: String; Const Writer: IOTAEditWriter;
  Const iInsertLine: Integer);

Var
  EditorSvcs : IOTAEditorServices;
  iBufferPos : Integer;
  C          : TOTACharPos;

Begin
  If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
    Begin
      C.Line      := iInsertLine;
      C.CharIndex := 0;
      iBufferPos  := EditorSvcs.TopView.CharPosToPos(C);
      Writer.CopyTo(iBufferPos);
      TBADIToolsAPIFunctions.OutputText(Writer, strComment);
    End;
End;

(**

  This method inserts either a Block, Line or In-Situ comment at the position of the current cursor 
  depending on the passed parameter.

  @precon  None.
  @postcon Inserts the specified comment.

  @param   CommentStyle as a TCommentStyle as a constant
  @param   CommentType  as a TCommentType as a constant

**)
Procedure TBADIIDEMenuInstaller.InsertCommentBlock(Const CommentStyle: TCommentStyle; Const CommentType: TCommentType);

Const
  iDefaultSpacignIndent = 2;
  iNonBlockIndent = 4;
  iBlockHeight = 5;
  
Var
  SourceEditor   : IOTASourceEditor;
  EditorSvcs     : IOTAEditorServices;
  EditPos        : TOTAEditPos;
  CharPos        : TOTACharPos;
  Writer         : IOTAEditWriter;
  iIndent        : Integer;
  strSelectedText: String;
  EV : IOTAEditView;

Begin
  If CommentType = ctNone Then
    Exit;
  SourceEditor := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If Assigned(SourceEditor) Then
    Begin
      If IsTextSelected(SourceEditor) Then
        Case MessageDlg(strThereIsSelectedText, mtConfirmation, [mbYes, mbNo, mbCancel], 0) Of
          mrCancel: Exit;
          mrNo:     strSelectedText := '';
        Else
          strSelectedText := SelectedText(True);
        End;
      If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
        Begin
          EV := EditorSvcs.TopView;
          EditPos := EV.CursorPos;
          iIndent := EV.CursorPos.Col;
          Writer := SourceEditor.CreateUndoableWriter;
          Try
            CharPos.Line      := EditPos.Line;
            CharPos.CharIndex := EditPos.Col;
            Writer.CopyTo((BorlandIDEServices As IOTAEditorServices).TopView.CharPosToPos(CharPos) - 1);
            TBADIToolsAPIFunctions.OutputText(Writer, BuildBlockComment(CommentType, CommentStyle, iIndent,
              strSelectedText));
          Finally
            Writer := Nil;
          End;
          // Get header in view if not already
          Case CommentStyle Of
            csBlock: SelectionChange(EditPos.Line + iBlockHeight, EditPos.Col, EditPos.Line);
          Else
            SelectionChange(EditPos.Line + 1, EditPos.Col, EditPos.Line);
          End;
          // Place cursor at start of comment
          Case CommentStyle Of
            csBlock:
              Begin
                EditPos.Line := EditPos.Line + iDefaultSpacignIndent;
                EditPos.Col  := EditPos.Col + iDefaultSpacignIndent;
              End;
          Else
            EditPos.Col := EditPos.Col + iNonBlockIndent;
          End;
          EV.CursorPos := EditPos;
          EV.Paint;
        End;
    End;
End;

(**

  This method inserts the line comment start for all lines in the given comment except the first.

  @precon  None.
  @postcon The comment text provided is returned with comment starts inserted at the given indent.

  @param   strComment as a String as a constant
  @param   iCol       as an Integer as a constant
  @param   strCmtText as a String as a constant
  @return  a String

**)
Function TBADIIDEMenuInstaller.InsertLineComments(Const strComment: String; Const iCol : Integer;
  Const strCmtText : String) : String;

Var
  sl : TStringList;
  iIndent : Integer;
  iLine: Integer;
  strLine: String;
  
Begin
  sl := TStringList.Create;
  Try
    {$IFDEF RS101}
    sl.TrailingLineBreak := False;
    {$ENDIF RS101}
    iIndent := iCol - 1;
    sl.text := strComment;
    For iLine := 1 To sl.Count - 1 Do //: @note Starting at 1 is deliberate
      Begin
        strLine := sl[iLine];
        strLine.Insert(iIndent, strCmtText + #32);
        sl[iLine] := strLine;
      End;
    Result := sl.Text;
  Finally
    sl.Free;
  End;
End;

(**

  This method inserts profiling code into the editor.

  @precon  SE and ProfileJob must be valid instances.
  @postcon Inserts into the editor profiling code for the given profiling job.

  @param   SE         as an IOTASourceEditor as a constant
  @param   ProfileJob as a TProfileJob as a constant
  @param   strProlog  as a String as a constant
  @param   strEpilog  as a String as a constant

**)
Procedure TBADIIDEMenuInstaller.InsertProfileCode(Const SE: IOTASourceEditor;
  Const ProfileJob: TProfileJob; Const strProlog, strEpilog: String);

Var
  EditorSvcs : IOTAEditorServices;
  Writer     : IOTAEditWriter;
  iBufferPos : Integer;
  C          : TOTACharPos;

Begin
  If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
    Begin
      Writer := SE.CreateUndoableWriter;
      Try
        C.Line      := ProfileJob.EndLine + 1;
        C.CharIndex := 0;
        iBufferPos  := EditorSvcs.TopView.CharPosToPos(C);
        Writer.CopyTo(iBufferPos);
        TBADIToolsAPIFunctions.OutputText(Writer, strEpilog);
      Finally
        Writer := Nil;
      End;
      Writer := SE.CreateUndoableWriter;
      Try
        C.Line      := ProfileJob.StartLine;
        C.CharIndex := 0;
        iBufferPos  := EditorSvcs.TopView.CharPosToPos(C);
        Writer.CopyTo(iBufferPos);
        TBADIToolsAPIFunctions.OutputText(Writer, strProlog);
      Finally
        Writer := Nil;
      End;
    End;
End;

(**

  This method inserts a tagged comment with optional selected text into the edit at the cursor position.

  @precon  None.
  @postcon The tagged comment is inserted.

  @param   strTagName   as a String as a constant
  @param   eCommentType as a TCommentType as a constant

**)
Procedure TBADIIDEMenuInstaller.InsertTaggedComment(Const strTagName: String;
  Const eCommentType: TCommentType);

Var
  SE: IOTASourceEditor;
  ES: IOTAEditorServices;
  EditPos: TOTAEditPos;
  Writer: IOTAEditWriter;
  strComment : String;
  
Begin
  SE := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If Assigned(SE) Then
    If Supports(BorlandIDEServices, IOTAEditorServices, ES) Then
      Begin
        EditPos := BlockStartCursorPos(ES);
        Writer := SE.CreateUndoableWriter;
        Try
          MoveCursorToBlockStart(ES, Writer);
          strComment := SelectedText(True);
          Case eCommentType Of
            ctPascalBlock, ctPascalBrace, ctCPPBlock, ctXML:
              strComment := Format('%s %s %s %s', [
                  astrCmtTerminals[eCommentType].FStart,
                  IfThen(strTagName.Length > 0, '@' + strTagName, ''),
                  strComment,
                  astrCmtTerminals[eCommentType].FBlockEnd
                ]);
            ctCPPLine, ctVBLine:
              Begin
                strComment := InsertLineComments(strComment, EditPos.Col,
                  astrCmtTerminals[eCommentType].FStart);
                strComment := Format('%s %s %s', [
                    astrCmtTerminals[eCommentType].FStart,
                    IfThen(strTagName.Length > 0, '@' + strTagName, ''),
                    strComment
                  ]);
              End;
          End;
          TBADIToolsAPIFunctions.OutputText(Writer, strComment);
          EditPos.Col := EditPos.Col + Format('%s %s ', [
            astrCmtTerminals[eCommentType].FStart,
            IfThen(strTagName.Length > 0, '@' + strTagName, '')]).Length;
        Finally
          Writer := Nil;
        End;
        ES.TopView.CursorPos := EditPos;
      End;
End;

(**

  This is an action for the Insert In Situ Comment event handler. It inserts an
  in situ comment at the current cursor position.

  @precon  None.
  @postcon Inserts an In-Situ comment into the editor.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.InSituCommentClick(Sender: TObject);
Var
  SE: IOTASourceEditor;

Begin
  SE := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If SE <> Nil Then
    InsertCommentBlock(csInSitu, TBADIDispatcher.BADIDispatcher.GetCommentType(SE.FileName, csInSitu));
End;

(**

  This method test whether there is selected text in the editors current view.

  @precon  None.
  @postcon Returns true of there is selected text.

  @param   SourceEditor as an IOTASourceEditor as a constant
  @return  a Boolean

**)
Function TBADIIDEMenuInstaller.IsTextSelected(Const SourceEditor : IOTASourceEditor): Boolean;

Var
  Reader: IOTAEditReader;
  ES : IOTAEditorServices;

Begin
  Result := False;
  If Assigned(SourceEditor) Then
    Begin
      Reader := SourceEditor.CreateReader;
      Try
        If Supports(BorlandIDEServices, IOTAEditorServices, ES) Then
          Result := ES.TopView.Block.Visible;
      Finally
        Reader := Nil;
      End;
    End;
End;

(**

  This method is an on click event handler for the Insert Line Comment action.

  @precon  None.
  @postcon Inserts a line comment at the cursor location in the editor.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.LineCommentClick(Sender: TObject);
Var
  SE: IOTASourceEditor;

Begin
  SE := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If SE <> Nil Then
    InsertCommentBlock(csLine, TBADIDispatcher.BADIDispatcher.GetCommentType(SE.FileName, csLine));
End;

(**

  This is a menu On Click event for the insertion of a method comment. This method
  searches the IDE for the current module being edited and then creates a
  memory stream of the source and passes it to the Unit parser. It then finds
  the first method declaration prior to the cursor position, parses the
  declaration and output the information in as comment immediately above the
  method declaration. This comment block starts with '(**' to signify an
  Browse and Doc It comment that can be used by the documentation system.

  @precon  Sender is the object initiating the event .
  @postcon Inserts a Method comment into the editor avoid the current method .

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.MethodCommentClick(Sender: TObject);

Var
  EditorSvcs      : IOTAEditorServices;
  Module          : TBaseLanguageModule;
  EditPos         : TOTAEditPos;
  T               : TElementContainer;
  F               : TGenericFunction;
  Writer          : IOTAEditWriter;
  Source          : IOTASourceEditor;
  CursorDelta     : TPoint;
  iIndent         : Integer;
  strComment      : String;
  iInsertLine     : Integer;
  iMaxCommentWidth: Integer;

Begin
  Source := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If Assigned(Source) Then
    Begin
      Module := TBADIDispatcher.BADIDispatcher.Dispatcher(TBADIToolsAPIFunctions.EditorAsString(Source),
        Source.FileName, Source.Modified, [moParse]);
      If Assigned(Module) Then
        Try
          If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
            Begin
              EditPos := EditorSvcs.TopView.CursorPos;
              T       := Module.FindElement(strImplementedMethodsLabel);
              If T <> Nil Then
                Begin
                  F := FindFunction(EditPos.Line, T, TGenericMethodDecl);
                  If F <> Nil Then
                    Begin
                      iIndent := FindIndentOfFirstTokenOnLine(Module, F.Line) - 1;
                      If F.Comment <> Nil Then
                        Begin
                          If MessageDlg(Format(strMethodAlreadyExists, [F.QualifiedName]),
                            mtWarning, [mbYes, mbNo, mbCancel], 0) <> mrYes Then
                            Exit;
                          iInsertLine := F.Comment.Line;
                          DeleteExistingComment(Source, F.Comment.Line, F.Line);
                        End
                      Else
                        iInsertLine    := F.Line;
                      iMaxCommentWidth := Source.EditViews[0].Buffer.BufferOptions.RightMargin;
                      Writer           := Source.CreateUndoableWriter;
                      Try
                        strComment := WriteComment(F,
                          TBADIDispatcher.BADIDispatcher.GetCommentType(Source.FileName, csBlock), iIndent,
                          True, CursorDelta, iMaxCommentWidth);
                        InsertComment(strComment, Writer, iInsertLine);
                      Finally
                        Writer := Nil;
                      End;
                      PositionCursorInFunction(CursorDelta, iInsertLine, strComment);
                    End
                  Else
                    MessageDlg(strNoMethodFound, mtWarning, [mbOK], 0);
                End;
            End;
        Finally
          Module.Free;
        End;
    End;
End;

(**

  This method displays the module statistics for the currently visible module.

  @precon  None.
  @postcon The module statistics are displays with the current modules information.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.MetricsClick(Sender: TObject);

Begin
  TBADIModuleMetricsEditorView.CreateEditorView; 
End;

(**

  This is a on click event. If display the module explorer if its not
  visible else hide or focuses the explorer.

  @precon  Sender is the object initiating the event.
  @postcon Displays the Module Explorer.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.ModuleExplorerClick(Sender: TObject);

Begin
  TfrmDockableModuleExplorer.ShowDockableModuleExplorer;
End;

(**

  This method moves the writer insertion position to the start of the selected block.

  @precon  ES and Writer must be valid instances.
  @postcon The cursor position is moved.

  @param   ES     as an IOTAEditorServices as a constant
  @param   Writer as an IOTAEditWriter as a constant

**)
Procedure TBADIIDEMenuInstaller.MoveCursorToBlockStart(Const ES: IOTAEditorServices;
  Const Writer: IOTAEditWriter);

Var
  CharPos: TOTACharPos;

Begin
  If ES.TopBuffer.BlockVisible Then
    CharPos := ES.TopBuffer.BlockStart
  Else
    Begin
      CharPos.Line := ES.TopView.CursorPos.Line;
      CharPos.CharIndex := ES.TopView.CursorPos.Col - 1;
    End;
  Writer.CopyTo(ES.TopView.CharPosToPos(CharPos));
End;

(**

  This method ensures all the BADI Menu Actions are initialised to NIL.

  @precon  None.
  @postcon All BADI menu actions are nil.

**)
Procedure TBADIIDEMenuInstaller.NilActions;

Var
  iBADIMenu: TBADIMenu;

Begin
  For iBADIMenu := Low(TBADIMenu) To High(TBADIMenu) Do
    If Assigned(FBADIActions[iBADIMenu]) Then
      FBADIActions[iBADIMenu] := Nil;
End;

(**

  This is an event handler to be hooked the the Module Explorer Frames
  On Options Change event handler.

  @precon  None.
  @postcon Refreshes the current module view.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.OptionsChange(Sender: TObject);

Begin
  FEditorNotifier.ResetLastupdateTickCount(1);
End;

(**

  This is a on click event. it invokes the Options dialogue.

  @precon  Sender is the object initiating the event.
  @postcon Displays the wizards Options dialogue.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.OptionsClick(Sender: TObject);

Const
  strBADI = 'Browse and Doc It';

Begin
  {$IFDEF DXE00}
  (BorlandIDEServices As IOTAServices).GetEnvironmentOptions.EditOptions('', strBADI);
  {$ELSE}
  If TfrmOptions.Execute([Low(TVisibleTab)..High(TVisibleTab)]) Then
    Begin
      FEditorNotifier.ResetLastupdateTickCount(1);
      UpdateMenuShortcuts;
    End;
  {$ENDIF}
End;

(**

  This method positions the comment and function according to the options and then places the cursor in 
  the appropriate position for editing.

  @precon  None.
  @postcon Positions the comment and function according to the options and then places the cursor in the
           appropriate position for editing.

  @param   CursorDelta as a TPoint as a constant
  @param   iInsertLine as an Integer as a constant
  @param   strComment  as a String as a constant

**)
Procedure TBADIIDEMenuInstaller.PositionCursorInFunction(Const CursorDelta: TPoint;
  Const iInsertLine: Integer; Const strComment: String);

Var
  EditorSvcs : IOTAEditorServices;
  Pt: TPoint;
  C : TOTAEditPos;

Begin
  If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
    Begin
      SelectionChange(iInsertLine + CharCount(#13, strComment), 1, iInsertLine);
      Pt.Y := iInsertLine;
      Pt.X := 1;
      Inc(Pt.Y, CursorDelta.Y);
      Inc(Pt.X, CursorDelta.X);
      C.Col  := Pt.X;
      C.Line := Pt.Y;
      EditorSvcs.TopView.CursorPos := C;
    End;
End;

(**

  This method processes each of the profiling jobs given determining whether they are insertions or 
  removals.

  @precon  SE and ProfileJob must be valid instances.
  @postcon Processes each of the profiling jobs given determining whether they are insertions or 
           removals.

  @param   Module     as a TBaseLanguageModule as a constant
  @param   SE         as an IOTASourceEditor as a constant
  @param   ProfileJob as a TProfileJob as a constant
  @param   iTabs      as an Integer as a constant

**)
Procedure TBADIIDEMenuInstaller.ProcessProfilingCode(Const Module : TBaseLanguageModule;
  Const SE: IOTASourceEditor; Const ProfileJob: TProfileJob; Const iTabs: Integer);

Var
  strTemplate       : String;
  slProlog, slEpilog: TStringList;

Begin
  strTemplate := StringReplace(TBADIOptions.BADIOptions.ProfilingCode[Module.ClassName],
    '|', #13#10, [rfReplaceAll]);
  slProlog := PrologCode(strTemplate, ProfileJob.Method, ProfileJob.Indent + iTabs);
  Try
    slEpilog := EpilogCode(strTemplate, ProfileJob.Method, ProfileJob.Indent + iTabs);
    Try
      Case ProfileJob.CodeType Of
        pctInsert:
          InsertProfileCode(SE, ProfileJob, slProlog.Text, slEpilog.Text);
        pctRemove:
          RemoveProfileCode(SE, ProfileJob, slProlog, slEpilog);
      End;
    Finally
      slEpilog.Free;
    End;
  Finally
    slProlog.Free;
  End;
End;

(**

  This is an on click event handler for the Profiling menu item.

  @precon  None.
  @postcon Invokes the profiling dialogue for selecting the methods to be
           profiled.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.ProfilingClick(Sender: TObject);

ResourceString
  strSelectSourceCode = 'You must select a source code editor to create unit tests.';
  strStartingToProcess = 'Starting to process profiling information...';
  strProfiling = 'Profiling...';
  strProfilingMethod = 'Processing method "%s"...';
  strNothingToDo = 'Nothing to do!';
  strTheEditorBufferIsReadOnly = 'The editor buffer is read only.';


Var
  SE         : IOTASourceEditor;
  M          : TBaseLanguageModule;
  ProfileJobs: TProfileJobs;
  i          : Integer;
  iTabs      : Integer;
  frm        : TfrmProgress;

Begin
  SE := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If SE <> Nil Then
    Begin
      If Not SE.EditViews[0].Buffer.IsReadOnly Then
        Begin
          M := TBADIDispatcher.BADIDispatcher.Dispatcher(TBADIToolsAPIFunctions.EditorAsString(SE),
            SE.FileName, SE.Modified, [moParse, moProfiling]);
          Try
            ProfileJobs := TfrmProfiling.Execute(M);
            Try
              If ProfileJobs <> Nil Then
                Begin
                  If (ProfileJobs.Count > 0) Then
                    Begin
                      iTabs := (BorlandIDEServices As IOTAEditorServices)
                        .EditOptions.BlockIndent;
                      frm := TfrmProgress.Create(Nil);
                      Try
                        frm.Init(ProfileJobs.Count - 1, strProfiling, strStartingToProcess);
                        For i := 0 To ProfileJobs.Count - 1 Do
                          Begin
                            ProcessProfilingCode(M, SE, ProfileJobs.ProfileJob[i], iTabs);
                            frm.UpdateProgress(i, Format(strProfilingMethod, [
                              ProfileJobs.ProfileJob[i].Method]));
                          End;
                      Finally
                        frm.Free;
                      End;
                    End
                  Else
                    MessageDlg(strNothingToDo, mtError, [mbOK], 0);
                End;
            Finally
              ProfileJobs.Free;
            End;
          Finally
            M.Free;
          End;
        End
      Else
        MessageDlg(strTheEditorBufferIsReadOnly, mtError, [mbOK], 0);
    End
  Else
    MessageDlg(strSelectSourceCode, mtError, [mbOK], 0);
End;

(**

  This is a menu On Click event for the insertion of a property comment. This
  method searches the IDE for the current module being edited and then
  creates a memory stream of the source and passes it to the Unit parser.

  It then finds the first property declaration prior to the cursor position,
  parses the declaration and output the information in as comment immediately
  above the property declaration.

  This comment block starts with '(**' to signify an Browse and Doc It comment
  that can be used by the documentation system.

  @precon  Sender is the object initiating the event.
  @postcon Inserts a property comment into the editor for the current property.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.PropertyCommentClick(Sender: TObject);

Var
  EditorSvcs      : IOTAEditorServices;
  Module          : TBaseLanguageModule;
  EditPos         : TOTAEditPos;
  Source          : IOTASourceEditor;
  T               : TElementContainer;
  F               : TGenericFunction;
  Writer          : IOTAEditWriter;
  iInsertLine     : Integer;
  iIndent         : Integer;
  strComment      : String;
  CursorDelta     : TPoint;
  iMaxCommentWidth: Integer;

Begin
  Source := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If Assigned(Source) Then
    Begin
      Module := TBADIDispatcher.BADIDispatcher.Dispatcher(
        TBADIToolsAPIFunctions.EditorAsString(Source), Source.FileName,
        Source.Modified, [moParse]);
      If Assigned(Module) Then
        Try
          If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
            Begin
              EditPos := EditorSvcs.TopView.CursorPos;
              T       := Module.FindElement(strTypesLabel);
              If T <> Nil Then
                Begin
                  F := FindFunction(EditPos.Line, Module, TGenericProperty);
                  If F <> Nil Then
                    Begin
                      iIndent := FindIndentOfFirstTokenOnLine(Module, F.Line) - 1;
                      If F.Comment <> Nil Then
                        Begin
                          If MessageDlg(Format(strPropertyAlreadyExists, [F.Identifier]),
                            mtWarning, [mbYes, mbNo, mbCancel], 0) <> mrYes Then
                            Exit;
                          iInsertLine := F.Comment.Line;
                          DeleteExistingComment(Source, F.Comment.Line, F.Line);
                        End
                      Else
                        iInsertLine := F.Line;
                      Writer        := Source.CreateUndoableWriter;
                      Try
                        iMaxCommentWidth := Source.EditViews[0].Buffer.BufferOptions.RightMargin;
                        strComment       := WriteComment(F,
                          TBADIDispatcher.BADIDispatcher.GetCommentType(Source.FileName,
                          csBlock), iIndent, False, CursorDelta, iMaxCommentWidth);
                        InsertComment(strComment, Writer, iInsertLine);
                      Finally
                        Writer := Nil;
                      End;
                      PositionCursorInFunction(CursorDelta, iInsertLine, strComment);
                    End
                  Else
                    MessageDlg(strNoPropertyFound, mtWarning, [mbOK], 0);
                End;
            End;
        Finally
          Module.Free;
        End;
    End;
End;

(**

  This method invokes the refactor constant code.

  @precon  None.
  @postcon The refactor constant code is invoked.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.RefactorConstantClick(Sender: TObject);

ResourceString
  strMsg = 'Refactoring is not available in this editor view.';

Var
  EditSvrs : IOTAEditorServices;
  TopView : IOTAEditView;
  Cursor: TOTAEditPos;
  
Begin
  If Supports(BorlandIDEServices, IOTAEditorServices, EditSvrs) Then
    If Assigned(EditSvrs.TopView) Then
      Begin
        TopView := EditSvrs.TopView;
        Cursor := TopView.CursorPos;
        TBADIRefactorConstant.Refactor(TBADIToolsAPIFunctions.ActiveSourceEditor, Cursor.Line,
          Cursor.Col);
      End Else
        MessageDlg(strMsg, mtError, [mbOK], 0);
End;

(**

  This method removes any BADI actions from any of the IDE tool bars to prevent AVs.

  @precon  None.
  @postcon All BADI actions are removed from the IDE tool bars.

**)
Procedure TBADIIDEMenuInstaller.RemoveActionsFromToolbars;

  (**

    This function checks to see whether the given action is in our action list and returns true if it is.

    @precon  None.
    @postcon Checks to see whether the given action is in our action list and returns true if it is.

    @param   Action as a TBasicAction as a constant
    @return  a Boolean

  **)
  Function IsCustomAction(Const Action : TBasicAction) : Boolean;

  Var
    iBADIMenu: TBADIMenu;

  Begin
    Result := False;
    For iBADIMenu := Low(TBADIMenu) To High(TBADIMenu) Do
      If Action = FBADIActions[iBADIMenu] Then
        Begin
          Result := True;
          Break;
        End;
  End;

  (**

    This method iterates over the buttons on a tool bar and removed the button if its action corresponds 
    to an action from this expert.

    @precon  None.
    @postcon Iterates over the buttons on a tool bar and removed the button if its action corresponds to 
             an action from this expert.

    @param   TB as a TToolbar as a constant

  **)
  Procedure RemoveAction(Const TB : TToolbar);

  Var
    i: Integer;

  Begin
    If TB <> Nil Then
      For i := TB.ButtonCount - 1 DownTo 0 Do
        Begin
          If IsCustomAction(TB.Buttons[i].Action) Then
            TB.RemoveControl(TB.Buttons[i]);
        End;
  End;

Var
  NTAS : INTAServices;

Begin
  NTAS := (BorlandIDEServices As INTAServices);
  RemoveAction(NTAS.ToolBar[sCustomToolBar]);
  RemoveAction(NTAS.Toolbar[sStandardToolBar]);
  RemoveAction(NTAS.Toolbar[sDebugToolBar]);
  RemoveAction(NTAS.Toolbar[sViewToolBar]);
  RemoveAction(NTAS.Toolbar[sDesktopToolBar]);
  {$IFDEF D0006}
  RemoveAction(NTAS.Toolbar[sInternetToolBar]);
  RemoveAction(NTAS.Toolbar[sCORBAToolBar]);
  {$IFDEF D2009}
  RemoveAction(NTAS.Toolbar[sAlignToolbar]);
  RemoveAction(NTAS.Toolbar[sBrowserToolbar]);
  RemoveAction(NTAS.Toolbar[sHTMLDesignToolbar]);
  RemoveAction(NTAS.Toolbar[sHTMLFormatToolbar]);
  RemoveAction(NTAS.Toolbar[sHTMLTableToolbar]);
  RemoveAction(NTAS.Toolbar[sPersonalityToolBar]);
  RemoveAction(NTAS.Toolbar[sPositionToolbar]);
  RemoveAction(NTAS.Toolbar[sSpacingToolbar]);
  {$ENDIF}
  {$ENDIF}
End;

(**

  This method removes the profiling code from the editor after checking that the code is what is expected
  .

  @precon  SE and ProfileJob must be valid instances.
  @postcon Removes the profiling code from the editor after checking that the code is what is expected.

  @param   SE         as an IOTASourceEditor as a constant
  @param   ProfileJob as a TProfileJob as a constant
  @param   slProlog   as a TStringList as a constant
  @param   slEpilog   as a TStringList as a constant

**)
Procedure TBADIIDEMenuInstaller.RemoveProfileCode(Const SE: IOTASourceEditor;
  Const ProfileJob: TProfileJob; Const slProlog, slEpilog: TStringList);

ResourceString
  strRemoveMsg =
    'The current profiling does not match the %s code in the method "%s". ' +
    'Expected "%s" but found "%s". Profiling code has NOT been ' +
    'removed for this method. Do you want to continue processing?';

Const
  iPadding = 2;
  strEpilog = 'Epilog';
  strProlog = 'Prolog';

Var
  EditorSvcs : IOTAEditorServices;
  Reader     : IOTAEditReader;
  C1, C2     : TOTACharPos;
  iLine      : Integer;
  iBufferPos1: Integer;
  iBufferPos2: Integer;
  strBuffer  : AnsiString;
  iRead      : Integer;
  iBufferSize: Integer;
  strLine    : String;

Begin
  If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
    Begin
      Reader := SE.CreateReader;
      Try
        For iLine := 0 To slEpilog.Count - 1 Do
          Begin
            C1.Line      := ProfileJob.EndLine - iLine;
            C1.CharIndex := 0;
            iBufferPos1  := EditorSvcs.TopView.CharPosToPos(C1);
            C2.Line      := ProfileJob.EndLine - iLine + 1;
            C2.CharIndex := 0;
            iBufferPos2  := EditorSvcs.TopView.CharPosToPos(C2);
            iBufferSize  := iBufferPos2 - iBufferPos1;
            SetLength(strBuffer, iBufferSize);
            iRead := Reader.GetText(iBufferPos1, PAnsiChar(strBuffer), iBufferSize);
            SetLength(strBuffer, iRead);
            strLine   := slEpilog[slEpilog.Count - 1 - iLine];
            strBuffer := Copy(strBuffer, 1, Length(strBuffer) - iPadding);
            If Not Like('*' + Trim(strLine) + '*', String(strBuffer)) Then
              Case MessageDlg(Format(strRemoveMsg, [strEpilog, ProfileJob.Method,
                strBuffer, strLine]), mtError, [mbYes, mbNo], 0) Of
                mrYes: Exit;
                mrNo:  Abort;
              End;
          End;
      Finally
        Reader := Nil;
      End;
      Reader := SE.CreateReader;
      Try
        For iLine := 0 To slProlog.Count - 1 Do
          Begin
            C1.Line      := ProfileJob.StartLine + iLine;
            C1.CharIndex := 0;
            iBufferPos1  := EditorSvcs.TopView.CharPosToPos(C1);
            C2.Line      := ProfileJob.StartLine + iLine + 1;
            C2.CharIndex := 0;
            iBufferPos2  := EditorSvcs.TopView.CharPosToPos(C2);
            iBufferSize  := iBufferPos2 - iBufferPos1;
            SetLength(strBuffer, iBufferSize);
            iRead := Reader.GetText(iBufferPos1, PAnsiChar(strBuffer), iBufferSize);
            SetLength(strBuffer, iRead);
            strLine   := Trim(slProlog[iLine]);
            strBuffer := Copy(strBuffer, 1, Length(strBuffer) - iPadding);
            If Not Like('*' + strLine + '*', String(strBuffer)) Then
              Case MessageDlg(Format(strRemoveMsg, [strProlog, ProfileJob.Method,
                strBuffer, strLine]), mtError, [mbYes, mbNo], 0) Of
                mrYes: Exit;
                mrNo:  Abort;
              End;
          End;
      Finally
        Reader := Nil;
      End;
      DeleteProfileCode(SE, ProfileJob.EndLine - slEpilog.Count + 1, ProfileJob.EndLine);
      DeleteProfileCode(SE, ProfileJob.StartLine, ProfileJob.StartLine + slProlog.Count - 1);
    End;
End;

(**

  This method returns the selected text in the active editor window and optionally deletes this text.

  @precon  None.
  @postcon Returns the selected text in the active editor window and optionally deletes this text.

  @param   boolDelete as a Boolean as a constant
  @return  a String

**)
Function TBADIIDEMenuInstaller.SelectedText(Const boolDelete: Boolean): String;

Var
  EditorSvcs                    : IOTAEditorServices;
  SE                            : IOTASourceEditor;
  Reader                        : IOTAEditReader;
  strBuffer                     : AnsiString;
  iRead                         : Integer;
  Block                         : IOTAEditBlock;
  cpStart, cpEnd                : TOTACharPos;
  Writer                        : IOTAEditWriter;
  iBufferPosStart, iBufferPosEnd: Integer;
  boolVisible                   : Boolean;

Begin
  Result          := '';
  boolVisible     := False;
  iBufferPosStart := 0;
  iBufferPosEnd   := 0;
  SE              := TBADIToolsAPIFunctions.ActiveSourceEditor;
  If SE <> Nil Then
    Begin
      Reader := SE.CreateReader;
      Try
        If Supports(BorlandIDEServices, IOTAEditorServices, EditorSvcs) Then
          Begin
            Block := EditorSvcs.TopView.Block;
            If Block.Visible Then
              Begin
                boolVisible       := True;
                cpStart.Line      := Block.StartingRow;
                cpStart.CharIndex := Block.StartingColumn - 1;
                iBufferPosStart   := EditorSvcs.TopView.CharPosToPos(cpStart);
                cpEnd.Line        := Block.EndingRow;
                cpEnd.CharIndex   := Block.EndingColumn - 1;
                iBufferPosEnd     := EditorSvcs.TopView.CharPosToPos(cpEnd);
                SetLength(strBuffer, iBufferPosEnd - iBufferPosStart);
                iRead := Reader.GetText(iBufferPosStart, PAnsiChar(strBuffer),
                  iBufferPosEnd - iBufferPosStart);
                SetLength(strBuffer, iRead);
                {$IFNDEF D2009}
                Result := strBuffer;
                {$ELSE}
                Result := String(strBuffer);
                {$ENDIF}
              End;
          End;
      Finally
        Reader := Nil;
      End;
      If boolVisible And boolDelete Then
        Begin
          Writer := SE.CreateUndoableWriter;
          Try
            Writer.CopyTo(iBufferPosStart);
            Writer.DeleteTo(iBufferPosEnd);
          Finally
            Writer := Nil;
          End;
        End;
    End;
End;

(**

  This method move the active editors cursor to the supplied position and centres the cursor on the
  screen.

  @precon  None.
  @postcon When a selection is made in the explorer the cursor is placed in the editor.

  @param   iIdentLine   as an Integer as a constant
  @param   iIdentCol    as an Integer as a constant
  @param   iCommentLine as an Integer as a constant

**)
Procedure TBADIIDEMenuInstaller.SelectionChange(Const iIdentLine, iIdentCol, iCommentLine : Integer);

Begin
  TBADIToolsAPIFunctions.PositionCursor(iIdentLine, iIdentCol, iCommentLine,
    TBADIOptions.BADIOptions.BrowsePosition);
End;

(**

  This method display the Spelling Checker Editor window showing the spelling mistakes in the active
  project.

  @precon  None.
  @postcon The spelling checker editor view is displayed.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.SpellingClick(Sender: TObject);

Begin
  TBADIModuleSpellingEditorView.CreateEditorView; 
End;

(**

  This in an on click event handler for the Insert To Do Comment menu item.

  @precon  None.
  @postcon Inserts in the the menu at the cursor a to do line comment.

  @param   Sender as a TObject

**)
Procedure TBADIIDEMenuInstaller.TaggedCommentClick(Sender: TObject);

Var
  MS : IOTAModuleServices;
  strExt : String;
  strTagName : String;
  eCommentType : TCommentType;

Begin
  If Supports(BorlandIDEServices, IOTAModuleServices, MS) And Assigned(MS.CurrentModule) Then
    Begin
      strExt := ExtractFileExt(MS.CurrentModule.FileName);
      strTagName := TBADIOptions.BADIOptions.CommentTagName[strExt];
      eCommentType := TBADIOptions.BADIOptions.CommentType[strExt];
      If TfrmCommentCode.Execute(strTagName, eCommentType) Then
        Begin
          TBADIOptions.BADIOptions.CommentTagName[strExt] := strTagName;
          TBADIOptions.BADIOptions.CommentType[strExt] := eCommentType;
          InsertTaggedComment(strTagName, eCommentType);
        End;
    End;

End;

(**

  This method cycles through the BADI Menu Actions and updates the shortcuts to pick up any changes
  to the shortcuts in the options.

  @precon  None.
  @postcon The BADI Menu Action shortcuts are updated.

**)
Procedure TBADIIDEMenuInstaller.UpdateMenuShortcuts;

Var
  iBADIMenu: TBADIMenu;

Begin
  For iBADIMenu := Low(TBADIMenu) To High(TBADIMenu) Do
    If Assigned(FBADIActions[iBADIMenu]) Then
      FBADIActions[iBADIMenu].ShortCut :=
        TextToShortcut(TBADIOptions.BADIOptions.MenuShortcut[iBADIMenu]);
End;

End.
