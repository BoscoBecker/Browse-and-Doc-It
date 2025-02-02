(**

  This module contains a class to represent spelling issues in a module.

  @Author  David Hoyle
  @Version 1.892
  @Date    19 Sep 2020

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
Unit BADI.SpellingIssue;

Interface

Uses
  BADI.ElementContainer,
  BADI.Types;

{$INCLUDE CompilerDefinitions.inc}

Type
  (** This class defines a document error. **)
  TBADISpellingIssue = Class(TElementContainer)
  Strict Private
    FUniqueReference : Integer;
    FSpellingIssueType : TBADISpellingIssueType;
  Strict Protected
    Function  GetName : String; Override;
  Public
    Constructor Create(Const strWord : String; Const AScope : TScope;
      Const eSpellingIssueType : TBADISpellingIssueType;
      Const iLine, iCol, iCommentLine, iCommentCol: Integer);
    Destructor Destroy; Override; 
    Function AsString(Const boolShowIdentifier, boolForDocumentation : Boolean) : String; Override;
    (**
      This property returns the type of the spelling issue.
      @precon  None.
      @postcon Returns the type of the spelling issue.
      @return  a TBADISpellingIssueType
    **)
    Property SpellingIssueType : TBADISpellingIssueType Read FSpellingIssueType;
  End;

Implementation

Uses
  System.SysUtils,
  BADI.Comment;

Var
  (** A counter to uniquely identify spelling issues **)
  iSpellingCounter : Integer;

(**

  This method returns a string representation of the spelling issue.

  @precon  None.
  @postcon Returns a string representation of the spelling issue.

  @nohints 

  @param   boolShowIdentifier   as a Boolean as a constant
  @param   boolForDocumentation as a Boolean as a constant
  @return  a String

**)
Function TBADISpellingIssue.AsString(Const boolShowIdentifier, boolForDocumentation: Boolean): String;

Begin
  Result := Format('%s (%d,%d)', [Identifier, Line, Column]);
End;

(**

  A constructor for the TBADISpellingIssue class.

  @precon  None.
  @postcon Creates the element and a pseudo comment.

  @param   strWord            as a String as a constant
  @param   AScope             as a TScope as a constant
  @param   eSpellingIssueType as a TBADISpellingIssueType as a constant
  @param   iLine              as an Integer as a constant
  @param   iCol               as an Integer as a constant
  @param   iCommentLine       as an Integer as a constant
  @param   iCommentCol        as an Integer as a constant

**)
Constructor TBADISpellingIssue.Create(Const strWord : String;
  Const AScope : TScope; Const eSpellingIssueType : TBADISpellingIssueType;
  Const iLine, iCol, iCommentLine, iCommentCol: Integer);

Begin
  Inherited Create(strWord, AScope, iLine, iCol, iiSpellingItem, Nil);
  FUniqueReference := iSpellingCounter;
  FSpellingIssueType := eSpellingIssueType;
  Inc(iSpellingCounter);
  Comment := TComment.Create('', iCommentLine, iCommentCol, 0);
End;

(**

  A destructor for the TBADISpellingIssue class.

  @precon  None.
  @postcon Frees the comment.

**)
Destructor TBADISpellingIssue.Destroy;

Begin
  Comment.Free;
  Inherited Destroy;
End;

(**

  This is an overridden getter method for the Name property.

  @precon  None.
  @postcon Returns a unique name for the spelling mistake.

  @return  a String

**)
Function TBADISpellingIssue.GetName: String;

Const
  strOutputFmt = '%s%6.6d';

Begin
  Result := Inherited GetName;
  Result := Format(strOutputFmt, [Result, FUniqueReference]);
End;

(** Initialises a counter to make the spelling issues unique. **)
Initialization
  iSpellingCounter := 1;
End.
