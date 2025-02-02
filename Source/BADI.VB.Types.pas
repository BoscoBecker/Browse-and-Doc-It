(**

  This module contains a number of VB specific general types for use in the parser.

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
Unit BADI.VB.Types;

Interface

Type
  (** A type to define at upper and lower limits of an array. **)
  TArrayDimensions = Array[1..2] Of String;

  (** A type to define the type of properties supported by visual basic. **)
  TVBPropertyType = (ptUnknown, ptGet, ptLet, ptSet);

  (** An enumerate to represent the different module types in visual basic. **)
  TVBModuleType = (mtModule, mtForm, mtClass);

Implementation

End.
