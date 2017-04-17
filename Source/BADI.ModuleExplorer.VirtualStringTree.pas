(**

  This module contains a custom virtual string tree class for the BADI module explorer.

  @Author  David Hoyle
  @Version 1.0
  @Date    16 Apr 2017

**)
Unit BADI.ModuleExplorer.VirtualStringTree;

Interface

Uses
  VirtualTrees,
  Graphics,
  BADI.ModuleExplorer.TreeNodeInfo;

Type
  (** This is a descendant of the TVirtualStringTree in order to override the
      OnGetNodeWidth method. **)
  TBADIVirtualStringTree = Class(TVirtualStringTree)
  {$IFDEF D2005} Strict {$ENDIF} Protected
    Function DoGetNodeWidth(Node: PVirtualNode; Column: TColumnIndex;
      Canvas: TCanvas = Nil) : Integer; Override;
  End;

  (** This record described the data sorted in the virtual tree view. **)
  TBADITreeData = Record
    FNode : TBADITreeNodeInfo;
  End;
  (** A type to define a pointer to the above tree record. **)
  PBADITreeData = ^TBADITreeData;

Implementation

Uses
  Classes,
  BADI.Options,
  BADI.Functions,
  BADI.Types;

(**

  This method overrides the DoGetNodeWidth of the tree view and calculates the
  modified node width.

  @precon  None.
  @postcon Returns the modified node width.

  @param   Node   as a PVirtualNode
  @param   Column as a TColumnIndex
  @param   Canvas as a TCanvas
  @return  an Integer

**)
Function TBADIVirtualStringTree.DoGetNodeWidth(Node: PVirtualNode;
  Column: TColumnIndex; Canvas: TCanvas): Integer;

Var
  NodeData: PBADITreeData;
  sl: TStringList;
  i: Integer;

Begin
  Result := 5;
  NodeData := GetNodeData(Node);
  //: @note Self.Canvas used to access the treeview canvas as Canvas from the parameters above is
  //:       NIL!
  InitCanvasFont(Self.Canvas, tpFixed In NodeData.FNode.TagProperties);
  sl := NodeData.FNode.Tokens;
  For i := 0 To sl.Count - 1 Do
    Begin
      GetFontInfo(sl, i, NodeData.FNode.Title, tpSyntax In NodeData.FNode.TagProperties,
        Self.Canvas);
      Inc(Result, Self.Canvas.TextWidth(sl[i]) + 1);
    End;
End;

End.