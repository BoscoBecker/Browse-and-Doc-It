(**
  
  This module contains DUnit test for the Browse and Doc It code.

  @Author  David Hoyle
  @Version 1.0
  @Date    21 Jun 2019

  @license

    Browse and Doc It is a RAD Studio plug-in for browsing, checking and
    documenting your code.
    
    Copyright (C) 2019  David Hoyle (https://github.com/DGH2112/Browse-and-Doc-It/)

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
Unit Test.BADI.VB.Option;

Interface

uses
  Test.BADI.Base.Module,
  BADI.VB.Option;

Type
  //
  // Test Class for the TVBOption Class Methods.
  //
  TestTVBOption = Class(TExtendedTestCase)
  Strict Private
    FVBOption : TVBOption;
  Public
    Procedure SetUp; Override;
    Procedure TearDown; Override;
  Published
    Procedure TestCreate;
    Procedure TestAsString;
  End;

Implementation

uses
  BADI.Types,
  BADI.Functions,
  TestFramework;

//
// Test methods for the class TVBOption.
//
Procedure TestTVBOption.Setup;

Begin
  FVBOption := TVBOption.Create('Option', scNone, 12, 23, iiUsesItem, Nil);
End;

Procedure TestTVBOption.TearDown;

Begin
  FVBOption.Free;
End;

Procedure TestTVBOption.TestAsString;

Begin
  CheckEquals('Option', FVBOption.AsString(True, True));
End;

procedure TestTVBOption.TestCreate;
begin
  CheckEquals('Option', FVBOption.Identifier);
  CheckEquals(scNone, FVBOption.Scope);
  CheckEquals(12, FVBOption.Line);
  CheckEquals(23, FVBOption.Column);
  CheckEquals(BADIImageIndex(iiUsesItem, scNone), FVBOption.ImageIndexAdjustedForScope);
  Check(Nil = FVBOption.Comment);
end;

initialization
  RegisterTest('VB Module Tests', TestTVBOption.Suite);
End.
