(**

  This module contains a class to represent an XML Delcaration.

  @Author  David Hoyle
  @Version 1.0
  @Date    11 Mar 2017

**)
Unit BADI.XML.XMLDecl;

Interface

Uses
  BADI.XML.BaseElement;

Type
  (** This class represents the individual xml declarations in the document. **)
  TXMLDecl = Class(TXMLBaseElement)
  Public
    Function AsString(boolShowIdenifier, boolForDocumentation: Boolean): String; Override;
  End;

Implementation

Uses
  BADI.Options;

(**

  This method returns a string representation of the XML Declaration.

  @precon  None.
  @postcon Returns a string representation of the XML Declaration.

  @param   boolShowIdenifier    as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
Function TXMLDecl.AsString(boolShowIdenifier, boolForDocumentation: Boolean): String;
Begin
  Result := BuildStringRepresentation(boolShowIdenifier, boolForDocumentation, '',
    BrowseAndDocItOptions.MaxDocOutputWidth, [#32, '=', '?'], [#32, '=', '?'], []);
End;

End.