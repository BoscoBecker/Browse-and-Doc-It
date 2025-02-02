(**
  
  This module contains a class which implements the IOTAEditorNotifier for detecting then views are
  opened and closed.

  @Author  David Hoyle
  @Version 2.184
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
Unit BADI.SourceEditorNotifier;

Interface

Uses
  ToolsAPI,
  System.Classes,
  BADI.Interfaces;

{$INCLUDE CompilerDefinitions.inc}

Type
  (** This class implements an IOTAEditorNotifier to tracker when views are created and destroyed. **)
  TBADISourceEditorNotifier = Class(TNotifierObject, IInterface, IOTANotifier, IOTAEditorNotifier)
  Strict Private
    FFileName              : String;
    {$IFDEF RS100}
    FEditViewNotifierIndex : Integer;
    {$ENDIF RS100}
    FView                  : IOTAEditView;
  Strict Protected
    procedure InstallEditViewNotifier(const View: IOTAEditView);
    procedure UninstallEditViewNotifier(const View: IOTAEditView);
    Procedure ViewActivated(Const View: IOTAEditView);
    Procedure ViewNotification(Const View: IOTAEditView; Operation: TOperation);
  Public
    Constructor Create(Const SE : IOTASourceEditor);
    Destructor Destroy; Override;
  End;

Implementation

Uses
  {$IFDEF DEBUG}
  CodeSiteLogging,
  {$ENDIF DEBUG}
  System.SysUtils,
  System.TypInfo,
  BADI.EditViewNotifier;

(**

  A constructor for the TBADISourceEditorNotifier class.

  @precon  None.
  @postcon Initialises the class and creates a view if a edit view is available. This is a workaround
           for new modules created after the IDE has started.

  @param   SE as an IOTASourceEditor as a constant

**)
Constructor TBADISourceEditorNotifier.Create(Const SE : IOTASourceEditor);

Begin
  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, 'Create', tmoTiming);{$ENDIF}
  {$IFDEF DEBUG}
  FFileName := SE.FileName;
  {$IFDEF CODESITE}
  CodeSite.Send(csmGreen, 'TBADISourceEditorNotifier.Create', ExtractFileName(FFileName)); }
  {$ENDIF CODESITE}
  {$ENDIF DEBUG}
  {$IFDEF RS100}
  FEditViewNotifierIndex := -1;
  {$ENDIF RS100}
  FView := Nil;
  // Workaround for new modules create after the IDE has started
  If SE.EditViewCount > 0 Then
    ViewNotification(SE.EditViews[0], opInsert);
End;

(**

  A destructor for the TBADISourceEditorNotifier class.

  @precon  None.
  @postcon Tries to remove the view notifier.

**)
Destructor TBADISourceEditorNotifier.Destroy;

Begin
  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, 'Destroy', tmoTiming);{$ENDIF}
  ViewNotification(FView, opRemove);
  {$IFDEF CODESITE}
  CodeSite.Send(csmRed, 'TBADISourceEditorNotifier.Destroy', ExtractFileName(FFileName));
  {$ENDIF CODESITE}
  Inherited Destroy;
End;

(**

  This method installs the Edit View Notifier.

  @precon  View must be a valid instance.
  @postcon The edit view notifier is created and installed.

  @param   View as an IOTAEditView as a constant

**)
Procedure TBADISourceEditorNotifier.InstallEditViewNotifier(Const View: IOTAEditView);

Begin
  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, 'InstallEditViewNotifier', tmoTiming);{$ENDIF}
  {$IFDEF RS100}
  If FEditViewNotifierIndex = - 1 Then
    Begin
      FView := View;
      FEditViewNotifierIndex := View.AddNotifier(TBADIEditViewNotifier.Create(FFileName));
    End;
  {$ENDIF RS100}
End;

(**

  This method uninstalls the Edit View Notifier.

  @precon  View must be a valid instance.
  @postcon The edit view notifier is removed.

  @param   View as an IOTAEditView as a constant

**)
Procedure TBADISourceEditorNotifier.UninstallEditViewNotifier(Const View: IOTAEditView);

Begin
  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, 'UninstallEditViewNotifier', tmoTiming);{$ENDIF}
  {$IFDEF RS100}
  If FEditViewNotifierIndex > - 1 Then
    Begin
      View.RemoveNotifier(FEditViewNotifierIndex);
      FEditViewNotifierIndex := - 1;
    End;
  {$ENDIF RS100}
End;

(**

  This method is called when an view is activated.

  @precon  None.
  @postcon Not used.

  @nocheck EmptyMethod
  @nohint  View

  @param   View as an IOTAEditView as a constant

**)
Procedure TBADISourceEditorNotifier.ViewActivated(Const View: IOTAEditView);

Begin
  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, 'ViewActivated', tmoTiming);{$ENDIF}
End;

(**

  This method is called when a view is created and when it is destroyer.

  @precon  None.
  @postcon This method either installs or removes an Edit View notifier for paining on the editor.

  @nocheck MissingCONSTInParam

  @param   View      as an IOTAEditView as a constant
  @param   Operation as a TOperation

**)
Procedure TBADISourceEditorNotifier.ViewNotification(Const View: IOTAEditView; Operation: TOperation);

Begin
  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, 'ViewNotification', tmoTiming);{$ENDIF}
  {$IFDEF RS100}
  If Assigned(View) Then
    Begin
      Case Operation Of
        opInsert: InstallEditViewNotifier(View);
        opRemove: UninstallEditViewNotifier(View);
      End;
    End;
  {$ENDIF RS100}
End;

End.




