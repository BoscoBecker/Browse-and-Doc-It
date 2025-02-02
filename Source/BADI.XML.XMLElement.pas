(**

  This module contains a class to represent an XML Element.

  @Author  David Hoyle
  @Version 1.001
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
Unit BADI.XML.XMLElement;

Interface

{$INCLUDE CompilerDefinitions.inc}

Uses
  Classes,
  BADI.XML.BaseElement,
  BADI.Types,
  BADI.Comment;

Type
  (** This class represents the individual elements (tags) of the document. **)
  TXMLElement = Class(TXMLBaseElement)
  {$IFDEF D2005} Strict {$ENDIF} Private
    FAttributes : TStringList;
    FContext    : TStringList;
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Function  ContextText : String;
  Public
    Constructor Create(Const strName : String; Const AScope : TScope; Const iLine,
      iColumn : Integer; Const AImageIndex : TBADIImageIndex; Const AComment : TComment); Override;
    Destructor Destroy; Override;
    Procedure AddContextText(Const strText : String);
    Function AsString(Const boolShowIdenifier, boolForDocumentation : Boolean) : String;
      Override;
    (**
      This property returns the Attributes string list.
      @precon  None.
      @postcon Provides access to the elements attribute names.
      @return  a TStringList
    **)
    Property Attribute : TStringList Read FAttributes;
  End;

Implementation

Uses
  SysUtils,
  BADI.Options;

(**

  This method add tokens to the text (between tags).

  @precon  None.
  @postcon A token is added to the context information.

  @param   strText as a String as a Constant

**)
Procedure TXMLElement.AddContextText(Const strText: String);

Begin
  If FContext.Count < BADIOptions.TokenLimit Then
    FContext.Add(strText);
End;

(**

  This method returns a string representation of the XML Element.

  @precon  None.
  @postcon Returns a string representation of the XML Element.

  @nometric HardCodedString

  @param   boolShowIdenifier    as a Boolean as a constant
  @param   boolForDocumentation as a Boolean as a constant
  @return  a String

**)
Function TXMLElement.AsString(Const boolShowIdenifier, boolForDocumentation: Boolean): String;

Begin
  Result := '<' + BuildStringRepresentation(boolShowIdenifier, boolForDocumentation, '',
    BADIOptions.MaxDocOutputWidth, [#32, '='], [#32, '='], []) + '>' + ContextText + '</'
    + Identifier + '>';
End;

(**

  This method returns a string representation of the token in the context text (between tags).

  @precon  None.
  @postcon A string of the context tokens is return.

  @nometric HardCodedString

  @return  a String

**)
Function TXMLElement.ContextText: String;

Var
  i: Integer;

Begin
  For i := 0 To FContext.Count - 1 Do
    Result := Result + FContext[i];
  If FContext.Count > BADIOptions.TokenLimit Then
    Result := Result + '...';
  Result := Trim(Result);
End;

(**

  This is a constructor for the TXMLElement class.

  @precon  None.
  @postcon Creates an XML element with a unique name derived from the given name, line number and column
           number.

  @param   strName     as a String as a constant
  @param   AScope      as a TScope as a constant
  @param   iLine       as an Integer as a constant
  @param   iColumn     as an Integer as a constant
  @param   AImageIndex as a TBADIImageIndex as a constant
  @param   AComment    as a TComment as a constant

**)
Constructor TXMLElement.Create(Const strName: String; Const AScope: TScope; Const iLine,
  iColumn: Integer; Const AImageIndex: TBADIImageIndex; Const AComment: TComment);

Begin
  Inherited Create(strName, AScope, iLine, iColumn, AImageIndex, AComment);
  FAttributes := TStringList.Create;
  FAttributes.Sorted := True;
  FContext := TStringList.Create;
End;

(**

  This is a destructor for the TXMLElement class.

  @precon  None.
  @postcon Frees the memory used for hold attribute names.

**)
Destructor TXMLElement.Destroy;
Begin
  FContext.Free;
  FAttributes.Free;
  Inherited Destroy;
End;

End.
