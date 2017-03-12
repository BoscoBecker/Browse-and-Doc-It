(**

  Tihs module contains a class to represent an XML Include Element.

  @Author  David Hoyle
  @Version 1.0
  @Date    11 mar 2017

**)
Unit BADI.XML.XMLIncludeElement;

Interface

Uses
  BADI.XML.BaseElement;

Type
  (** This class represents the individual xml PERef declarations in the document. **)
  TXMLIncludeElement = Class(TXMLBaseElement)
  Public
    Function AsString(boolShowIdenifier, boolForDocumentation: Boolean): String; Override;
  End;

Implementation

Uses
  BADI.Options;

(**

  This method returns a string presentation of the XML PE Ref element.

  @precon  None.
  @postcon Returns a string presentation of the XML PE Ref element.

  @param   boolShowIdenifier    as a Boolean
  @param   boolForDocumentation as a Boolean
  @return  a String

**)
Function TXMLIncludeElement.AsString(boolShowIdenifier, boolForDocumentation: Boolean): String;

Begin
  Result := BuildStringRepresentation(True, False, '', BrowseAndDocItOptions.MaxDocOutputWidth,
    [']'], ['[']);
End;

End.