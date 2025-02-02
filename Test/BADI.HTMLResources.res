        ��  ��                  �  L   ��
 B R O W S E A N D D O C I T C S S S C R E E N       0 	        /**

  This file contains CSS information for the Browse And Doc It HTML Output.

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

**/
a:active {
  background       : Red;
  color            : Yellow;
}

a:link {
  color            : Blue;
}

a:visited {
  color            : Navy;
}

a:hover {
  background       : Green;
  color            : White;
}

body {
  background       : #FFFFFF;
  font-family      : "Tahoma", Times, Serif;
  font-size        : 10pt;
}

div.Contents {
  margin           : 2pt;
  position         : absolute;
  top              : 5em;
  bottom           : 0;
  left             : 25em;
  right            : 0;
  overflow         : auto;
  margin           : 5px;
}

div.Indent {
  margin-left      : 2em;
}

div.List {
  margin-bottom    : 2pt;
  font-weight      : Bold;
  border           : solid thin;
}

div.Module {
  margin-left      : 5pt;
  margin-right     : 5pt;
  padding-top      : 2pt;
  padding-bottom   : 2pt;
  font-weight      : normal;
}

div.Module:hover {
  background       : Green;
  color            : White;
}

div.Modules {
  position         : absolute;
  top              : 0;
  bottom           : 0;
  left             : 0;
  width            : 24em;
  overflow         : auto;
  margin           : 1em;
}

div.ModuleTitle {
  background       : #EEEEFF;
  padding-top      : 1em;
  padding-left     : 1em;
  padding-right    : 1em;
  padding-bottom   : 1.7em;
  border-bottom    : solid thin;
}

div.Section {
  margin-left      : 5pt;
  margin-right     : 5pt;
  padding-top      : 2pt;
  padding-bottom   : 2pt;
  float            : left;
}

div.Section:hover {
  background       : Green;
  color            : White;
}

div.Sections {
  position         : absolute;
  top              : 0;
  left             : 25em;
  height           : 4em;
  right            : 0;
  background       : #EEEEFF;
  margin-top       : 1em;
  margin-left      : 0.2em;
  margin-bottom    : 1em;
  margin-right     : 0.2em;
  border           : solid 1px;
}

h1 {
  color            : black;
  font-family      : times;
  border-top       : Thin;
  border-bottom    : Thin;
}

h2 {
  color            : navy;
  font-family      : times;
}

h3 {
  color            : maroon;
  font-family      : times;
}

h4 {
  color            : green;
  font-family      : times;
  margin           : 1em;
}

h5 {
  color            : purple;
  font-family      : times;
}

h6 {
  color            : black;
  font-family      : times;
}

img.left {
  float            : Left;
  margin           : 5pt;
}

img.right {
  float            : Right;
  margin           : 5pt;
}

img.verticallymiddle {
  vertical-align : middle;
}

li.DocConflictIncorrect {
  list-style-image : URL('../Images/DocConflictIncorrect.gif');
}

li.DocConflictItem {
  list-style-image : URL('../Images/DocConflictItem.gif');
}

li.DocConflictMissing {
  list-style-image : URL('../Images/DocConflictMissing.gif');
}

li.Error {
  list-style-image : URL('../Images/Error.gif');
}

li.Hint {
  list-style-image : URL('../Images/Hint.gif');
}

li.SpecialTag {
  color            : maroon;
}

li.ToDoItem {
  list-style-image : URL('../Images/TodoItem.gif');
}

li.Warning {
  list-style-image : URL('../Images/Warning.gif');
}

p {
  margin-top     : 0.5em;
  margin-bottom  : 0.5em;
}

p.Comment {
  color            : blue;
}

p.TagHeader {
  color            : purple;
  text-decoration  : underline;
  font-weight      : bold;
}

pre.code {
  border-bottom    : solid thin gray;
  color            : black;
  margin-top       : -0.5em;
  margin-bottom    : 0em;
  margin-left      : -0.5em;
  margin-right     : -0.5em;
  padding          : 0.5em;
}

pre.Tag {
  color            : black;
  margin-top       : 0em;
  margin-bottom    : 0em;
  margin-left      : 0em;
  margin-right     : 0em;
  padding          : 0em;
}

table {
  border           : solid thin gray;
  border-collapse  : collapse;
  border-spacing   : 0em;
}

table.Tags {
  color            : maroon
}

td {
  border           : solid thin gray;
  color            : black;
  padding-left     : 0.5em;
  padding-right    : 0.5em;
  padding-top      : 0.5em;
  padding-bottom   : 0em;
  vertical-align   : top;
}

td.TagName {
  font-weight      : bold;
}

td.Red {
  background       : #FFCCCC;
}

td.Green {
  background       : #CCFFCC;
}

td.Yellow {
  background       : #FFFFCC;
}

th {
  background       : #EEEEFF;
  border           : solid thin gray;
  color            : black;
  padding-left     : 0.5em;
  padding-right    : 0.5em;
  padding-top      : 0.25em;
  padding-bottom   : 0.25em;
  text-align       : left;
}

ul {
  margin-top       : 0em;
  margin-left      : 0em;
  margin-right     : 0em;
}
 d  L   ��
 B R O W S E A N D D O C I T C S S P R I N T         0 	        /**

  This file contains CSS information for the Browse And Doc It HTML Output.

  @Author  David Hoyle
  @Version 1.008
  @Date    20 Sep 2020

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

**/
body {
  background       : #FFFFFF;
  font-family      : "Tahoma", Times, Serif;
  font-size        : 10pt;
}

div.Indent {
  margin-left      : 2em;
}

div.List {
  visibility       : hidden;
}

div.Module {
  visibility       : hidden;
}

div.Modules {
  visibility       : hidden;
  height           : 0;
  width            : 0;
}

div.ModuleTitle {
  visibility       : hidden;
}

div.Section {
  visibility       : hidden;
}

div.Sections {
  visibility       : hidden;
  height           : 0;
  width            : 0;
}

h1 {
  color            : black;
  font-family      : times;
  border-top       : Thin;
  border-bottom    : Thin;
}

h2 {
  color            : navy;
  font-family      : times;
}

h3 {
  color            : maroon;
  font-family      : times;
}

h4 {
  color            : green;
  font-family      : times;
  margin           : 1em;
}

h5 {
  color            : purple;
  font-family      : times;
}

h6 {
  color            : black;
  font-family      : times;
}

img.left {
  float            : Left;
  margin           : 5pt;
}

img.right {
  float            : Right;
  margin           : 5pt;
}

img.verticallymiddle {
  vertical-align : middle;
}

li.DocConflictIncorrect {
  list-style-image : URL('../Images/DocConflictIncorrect.gif');
}

li.DocConflictItem {
  list-style-image : URL('../Images/DocConflictItem.gif');
}

li.DocConflictMissing {
  list-style-image : URL('../Images/DocConflictMissing.gif');
}

li.Error {
  list-style-image : URL('../Images/Error.gif');
}

li.Hint {
  list-style-image : URL('../Images/Hint.gif');
}

li.SpecialTag {
  color            : maroon;
}

li.ToDoItem {
  list-style-image : URL('../Images/TodoItem.gif');
}

li.Warning {
  list-style-image : URL('../Images/Warning.gif');
}

p {
  margin-top     : 0.5em;
  margin-bottom  : 0.5em;
}

p.Comment {
  color            : blue;
}

p.TagHeader {
  color            : purple;
  text-decoration  : underline;
  font-weight      : bold;
}

pre.code {
  border-bottom    : solid thin gray;
  color            : black;
  margin-top       : -0.5em;
  margin-bottom    : 0em;
  margin-left      : -0.5em;
  margin-right     : -0.5em;
  padding          : 0.5em;
}

pre.Tag {
  color            : black;
  margin-top       : 0em;
  margin-bottom    : 0em;
  margin-left      : 0em;
  margin-right     : 0em;
  padding          : 0em;
}

table {
  border           : solid thin gray;
  border-collapse  : collapse;
  border-spacing   : 0em;
}

table.Tags {
  color            : maroon
}

td {
  border           : solid thin gray;
  color            : black;
  padding-left     : 0.5em;
  padding-right    : 0.5em;
  padding-top      : 0.5em;
  padding-bottom   : 0em;
  vertical-align   : top;
}

td.TagName {
  font-weight      : bold;
}

td.Red {
  background       : #FFCCCC;
}

td.Green {
  background       : #CCFFCC;
}

td.Yellow {
  background       : #FFFFCC;
}

th {
  background       : #EEEEFF;
  border           : solid thin gray;
  color            : black;
  padding-left     : 0.5em;
  padding-right    : 0.5em;
  padding-top      : 0.25em;
  padding-bottom   : 0.25em;
  text-align       : left;
}

ul {
  margin-top       : 0em;
  margin-left      : 0em;
  margin-right     : 0em;
}

M  T   ��
 B R O W S E A N D D O C I T H T M L T E M P L A T E         0 	        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "Schema/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <title>$TITLE$</title>
    <link rel="StyleSheet" href="Styles/BrowseAndDocItScreen.css" media="Screen"/>
    <link rel="StyleSheet" href="Styles/BrowseAndDocItPrint.css" media="Print"/>
  </head>

  <body>
  
    <div class="Modules">
      $MODULELIST$
    </div>

    <div class="Sections">
      $SECTIONLIST$
    </div>

    <div class="Contents">
      $CONTENT$
    </div>

  </body>
</html>
   �-  L   ��
 B R O W S E A N D D O C I T X H T M L L A T 1       0 	        <!-- Portions (C) International Organization for Standardization 1986
     Permission to copy in any form is granted for use with
     conforming SGML systems and applications as defined in
     ISO 8879, provided this notice is included in all copies.
-->
<!-- Character entity set. Typical invocation:
    <!ENTITY % HTMLlat1 PUBLIC
       "-//W3C//ENTITIES Latin 1 for XHTML//EN"
       "http://www.w3.org/TR/xhtml1/DTD/xhtml-lat1.ent">
    %HTMLlat1;
-->

<!ENTITY nbsp   "&#160;"> <!-- no-break space = non-breaking space,
                                  U+00A0 ISOnum -->
<!ENTITY iexcl  "&#161;"> <!-- inverted exclamation mark, U+00A1 ISOnum -->
<!ENTITY cent   "&#162;"> <!-- cent sign, U+00A2 ISOnum -->
<!ENTITY pound  "&#163;"> <!-- pound sign, U+00A3 ISOnum -->
<!ENTITY curren "&#164;"> <!-- currency sign, U+00A4 ISOnum -->
<!ENTITY yen    "&#165;"> <!-- yen sign = yuan sign, U+00A5 ISOnum -->
<!ENTITY brvbar "&#166;"> <!-- broken bar = broken vertical bar,
                                  U+00A6 ISOnum -->
<!ENTITY sect   "&#167;"> <!-- section sign, U+00A7 ISOnum -->
<!ENTITY uml    "&#168;"> <!-- diaeresis = spacing diaeresis,
                                  U+00A8 ISOdia -->
<!ENTITY copy   "&#169;"> <!-- copyright sign, U+00A9 ISOnum -->
<!ENTITY ordf   "&#170;"> <!-- feminine ordinal indicator, U+00AA ISOnum -->
<!ENTITY laquo  "&#171;"> <!-- left-pointing double angle quotation mark
                                  = left pointing guillemet, U+00AB ISOnum -->
<!ENTITY not    "&#172;"> <!-- not sign = angled dash,
                                  U+00AC ISOnum -->
<!ENTITY shy    "&#173;"> <!-- soft hyphen = discretionary hyphen,
                                  U+00AD ISOnum -->
<!ENTITY reg    "&#174;"> <!-- registered sign = registered trade mark sign,
                                  U+00AE ISOnum -->
<!ENTITY macr   "&#175;"> <!-- macron = spacing macron = overline
                                  = APL overbar, U+00AF ISOdia -->
<!ENTITY deg    "&#176;"> <!-- degree sign, U+00B0 ISOnum -->
<!ENTITY plusmn "&#177;"> <!-- plus-minus sign = plus-or-minus sign,
                                  U+00B1 ISOnum -->
<!ENTITY sup2   "&#178;"> <!-- superscript two = superscript digit two
                                  = squared, U+00B2 ISOnum -->
<!ENTITY sup3   "&#179;"> <!-- superscript three = superscript digit three
                                  = cubed, U+00B3 ISOnum -->
<!ENTITY acute  "&#180;"> <!-- acute accent = spacing acute,
                                  U+00B4 ISOdia -->
<!ENTITY micro  "&#181;"> <!-- micro sign, U+00B5 ISOnum -->
<!ENTITY para   "&#182;"> <!-- pilcrow sign = paragraph sign,
                                  U+00B6 ISOnum -->
<!ENTITY middot "&#183;"> <!-- middle dot = Georgian comma
                                  = Greek middle dot, U+00B7 ISOnum -->
<!ENTITY cedil  "&#184;"> <!-- cedilla = spacing cedilla, U+00B8 ISOdia -->
<!ENTITY sup1   "&#185;"> <!-- superscript one = superscript digit one,
                                  U+00B9 ISOnum -->
<!ENTITY ordm   "&#186;"> <!-- masculine ordinal indicator,
                                  U+00BA ISOnum -->
<!ENTITY raquo  "&#187;"> <!-- right-pointing double angle quotation mark
                                  = right pointing guillemet, U+00BB ISOnum -->
<!ENTITY frac14 "&#188;"> <!-- vulgar fraction one quarter
                                  = fraction one quarter, U+00BC ISOnum -->
<!ENTITY frac12 "&#189;"> <!-- vulgar fraction one half
                                  = fraction one half, U+00BD ISOnum -->
<!ENTITY frac34 "&#190;"> <!-- vulgar fraction three quarters
                                  = fraction three quarters, U+00BE ISOnum -->
<!ENTITY iquest "&#191;"> <!-- inverted question mark
                                  = turned question mark, U+00BF ISOnum -->
<!ENTITY Agrave "&#192;"> <!-- latin capital letter A with grave
                                  = latin capital letter A grave,
                                  U+00C0 ISOlat1 -->
<!ENTITY Aacute "&#193;"> <!-- latin capital letter A with acute,
                                  U+00C1 ISOlat1 -->
<!ENTITY Acirc  "&#194;"> <!-- latin capital letter A with circumflex,
                                  U+00C2 ISOlat1 -->
<!ENTITY Atilde "&#195;"> <!-- latin capital letter A with tilde,
                                  U+00C3 ISOlat1 -->
<!ENTITY Auml   "&#196;"> <!-- latin capital letter A with diaeresis,
                                  U+00C4 ISOlat1 -->
<!ENTITY Aring  "&#197;"> <!-- latin capital letter A with ring above
                                  = latin capital letter A ring,
                                  U+00C5 ISOlat1 -->
<!ENTITY AElig  "&#198;"> <!-- latin capital letter AE
                                  = latin capital ligature AE,
                                  U+00C6 ISOlat1 -->
<!ENTITY Ccedil "&#199;"> <!-- latin capital letter C with cedilla,
                                  U+00C7 ISOlat1 -->
<!ENTITY Egrave "&#200;"> <!-- latin capital letter E with grave,
                                  U+00C8 ISOlat1 -->
<!ENTITY Eacute "&#201;"> <!-- latin capital letter E with acute,
                                  U+00C9 ISOlat1 -->
<!ENTITY Ecirc  "&#202;"> <!-- latin capital letter E with circumflex,
                                  U+00CA ISOlat1 -->
<!ENTITY Euml   "&#203;"> <!-- latin capital letter E with diaeresis,
                                  U+00CB ISOlat1 -->
<!ENTITY Igrave "&#204;"> <!-- latin capital letter I with grave,
                                  U+00CC ISOlat1 -->
<!ENTITY Iacute "&#205;"> <!-- latin capital letter I with acute,
                                  U+00CD ISOlat1 -->
<!ENTITY Icirc  "&#206;"> <!-- latin capital letter I with circumflex,
                                  U+00CE ISOlat1 -->
<!ENTITY Iuml   "&#207;"> <!-- latin capital letter I with diaeresis,
                                  U+00CF ISOlat1 -->
<!ENTITY ETH    "&#208;"> <!-- latin capital letter ETH, U+00D0 ISOlat1 -->
<!ENTITY Ntilde "&#209;"> <!-- latin capital letter N with tilde,
                                  U+00D1 ISOlat1 -->
<!ENTITY Ograve "&#210;"> <!-- latin capital letter O with grave,
                                  U+00D2 ISOlat1 -->
<!ENTITY Oacute "&#211;"> <!-- latin capital letter O with acute,
                                  U+00D3 ISOlat1 -->
<!ENTITY Ocirc  "&#212;"> <!-- latin capital letter O with circumflex,
                                  U+00D4 ISOlat1 -->
<!ENTITY Otilde "&#213;"> <!-- latin capital letter O with tilde,
                                  U+00D5 ISOlat1 -->
<!ENTITY Ouml   "&#214;"> <!-- latin capital letter O with diaeresis,
                                  U+00D6 ISOlat1 -->
<!ENTITY times  "&#215;"> <!-- multiplication sign, U+00D7 ISOnum -->
<!ENTITY Oslash "&#216;"> <!-- latin capital letter O with stroke
                                  = latin capital letter O slash,
                                  U+00D8 ISOlat1 -->
<!ENTITY Ugrave "&#217;"> <!-- latin capital letter U with grave,
                                  U+00D9 ISOlat1 -->
<!ENTITY Uacute "&#218;"> <!-- latin capital letter U with acute,
                                  U+00DA ISOlat1 -->
<!ENTITY Ucirc  "&#219;"> <!-- latin capital letter U with circumflex,
                                  U+00DB ISOlat1 -->
<!ENTITY Uuml   "&#220;"> <!-- latin capital letter U with diaeresis,
                                  U+00DC ISOlat1 -->
<!ENTITY Yacute "&#221;"> <!-- latin capital letter Y with acute,
                                  U+00DD ISOlat1 -->
<!ENTITY THORN  "&#222;"> <!-- latin capital letter THORN,
                                  U+00DE ISOlat1 -->
<!ENTITY szlig  "&#223;"> <!-- latin small letter sharp s = ess-zed,
                                  U+00DF ISOlat1 -->
<!ENTITY agrave "&#224;"> <!-- latin small letter a with grave
                                  = latin small letter a grave,
                                  U+00E0 ISOlat1 -->
<!ENTITY aacute "&#225;"> <!-- latin small letter a with acute,
                                  U+00E1 ISOlat1 -->
<!ENTITY acirc  "&#226;"> <!-- latin small letter a with circumflex,
                                  U+00E2 ISOlat1 -->
<!ENTITY atilde "&#227;"> <!-- latin small letter a with tilde,
                                  U+00E3 ISOlat1 -->
<!ENTITY auml   "&#228;"> <!-- latin small letter a with diaeresis,
                                  U+00E4 ISOlat1 -->
<!ENTITY aring  "&#229;"> <!-- latin small letter a with ring above
                                  = latin small letter a ring,
                                  U+00E5 ISOlat1 -->
<!ENTITY aelig  "&#230;"> <!-- latin small letter ae
                                  = latin small ligature ae, U+00E6 ISOlat1 -->
<!ENTITY ccedil "&#231;"> <!-- latin small letter c with cedilla,
                                  U+00E7 ISOlat1 -->
<!ENTITY egrave "&#232;"> <!-- latin small letter e with grave,
                                  U+00E8 ISOlat1 -->
<!ENTITY eacute "&#233;"> <!-- latin small letter e with acute,
                                  U+00E9 ISOlat1 -->
<!ENTITY ecirc  "&#234;"> <!-- latin small letter e with circumflex,
                                  U+00EA ISOlat1 -->
<!ENTITY euml   "&#235;"> <!-- latin small letter e with diaeresis,
                                  U+00EB ISOlat1 -->
<!ENTITY igrave "&#236;"> <!-- latin small letter i with grave,
                                  U+00EC ISOlat1 -->
<!ENTITY iacute "&#237;"> <!-- latin small letter i with acute,
                                  U+00ED ISOlat1 -->
<!ENTITY icirc  "&#238;"> <!-- latin small letter i with circumflex,
                                  U+00EE ISOlat1 -->
<!ENTITY iuml   "&#239;"> <!-- latin small letter i with diaeresis,
                                  U+00EF ISOlat1 -->
<!ENTITY eth    "&#240;"> <!-- latin small letter eth, U+00F0 ISOlat1 -->
<!ENTITY ntilde "&#241;"> <!-- latin small letter n with tilde,
                                  U+00F1 ISOlat1 -->
<!ENTITY ograve "&#242;"> <!-- latin small letter o with grave,
                                  U+00F2 ISOlat1 -->
<!ENTITY oacute "&#243;"> <!-- latin small letter o with acute,
                                  U+00F3 ISOlat1 -->
<!ENTITY ocirc  "&#244;"> <!-- latin small letter o with circumflex,
                                  U+00F4 ISOlat1 -->
<!ENTITY otilde "&#245;"> <!-- latin small letter o with tilde,
                                  U+00F5 ISOlat1 -->
<!ENTITY ouml   "&#246;"> <!-- latin small letter o with diaeresis,
                                  U+00F6 ISOlat1 -->
<!ENTITY divide "&#247;"> <!-- division sign, U+00F7 ISOnum -->
<!ENTITY oslash "&#248;"> <!-- latin small letter o with stroke,
                                  = latin small letter o slash,
                                  U+00F8 ISOlat1 -->
<!ENTITY ugrave "&#249;"> <!-- latin small letter u with grave,
                                  U+00F9 ISOlat1 -->
<!ENTITY uacute "&#250;"> <!-- latin small letter u with acute,
                                  U+00FA ISOlat1 -->
<!ENTITY ucirc  "&#251;"> <!-- latin small letter u with circumflex,
                                  U+00FB ISOlat1 -->
<!ENTITY uuml   "&#252;"> <!-- latin small letter u with diaeresis,
                                  U+00FC ISOlat1 -->
<!ENTITY yacute "&#253;"> <!-- latin small letter y with acute,
                                  U+00FD ISOlat1 -->
<!ENTITY thorn  "&#254;"> <!-- latin small letter thorn,
                                  U+00FE ISOlat1 -->
<!ENTITY yuml   "&#255;"> <!-- latin small letter y with diaeresis,
                                  U+00FF ISOlat1 -->
 #  T   ��
 B R O W S E A N D D O C I T X H T M L S P E C I A L         0 	        <!-- Special characters for XHTML -->

<!-- Character entity set. Typical invocation:
     <!ENTITY % HTMLspecial PUBLIC
        "-//W3C//ENTITIES Special for XHTML//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml-special.ent">
     %HTMLspecial;
-->

<!-- Portions (C) International Organization for Standardization 1986:
     Permission to copy in any form is granted for use with
     conforming SGML systems and applications as defined in
     ISO 8879, provided this notice is included in all copies.
-->

<!-- Relevant ISO entity set is given unless names are newly introduced.
     New names (i.e., not in ISO 8879 list) do not clash with any
     existing ISO 8879 entity names. ISO 10646 character numbers
     are given for each character, in hex. values are decimal
     conversions of the ISO 10646 values and refer to the document
     character set. Names are Unicode names. 
-->

<!-- C0 Controls and Basic Latin -->
<!ENTITY quot    "&#34;"> <!--  quotation mark, U+0022 ISOnum -->
<!ENTITY amp     "&#38;#38;"> <!--  ampersand, U+0026 ISOnum -->
<!ENTITY lt      "&#38;#60;"> <!--  less-than sign, U+003C ISOnum -->
<!ENTITY gt      "&#62;"> <!--  greater-than sign, U+003E ISOnum -->
<!ENTITY apos	 "&#39;"> <!--  apostrophe = APL quote, U+0027 ISOnum -->

<!-- Latin Extended-A -->
<!ENTITY OElig   "&#338;"> <!--  latin capital ligature OE,
                                    U+0152 ISOlat2 -->
<!ENTITY oelig   "&#339;"> <!--  latin small ligature oe, U+0153 ISOlat2 -->
<!-- ligature is a misnomer, this is a separate character in some languages -->
<!ENTITY Scaron  "&#352;"> <!--  latin capital letter S with caron,
                                    U+0160 ISOlat2 -->
<!ENTITY scaron  "&#353;"> <!--  latin small letter s with caron,
                                    U+0161 ISOlat2 -->
<!ENTITY Yuml    "&#376;"> <!--  latin capital letter Y with diaeresis,
                                    U+0178 ISOlat2 -->

<!-- Spacing Modifier Letters -->
<!ENTITY circ    "&#710;"> <!--  modifier letter circumflex accent,
                                    U+02C6 ISOpub -->
<!ENTITY tilde   "&#732;"> <!--  small tilde, U+02DC ISOdia -->

<!-- General Punctuation -->
<!ENTITY ensp    "&#8194;"> <!-- en space, U+2002 ISOpub -->
<!ENTITY emsp    "&#8195;"> <!-- em space, U+2003 ISOpub -->
<!ENTITY thinsp  "&#8201;"> <!-- thin space, U+2009 ISOpub -->
<!ENTITY zwnj    "&#8204;"> <!-- zero width non-joiner,
                                    U+200C NEW RFC 2070 -->
<!ENTITY zwj     "&#8205;"> <!-- zero width joiner, U+200D NEW RFC 2070 -->
<!ENTITY lrm     "&#8206;"> <!-- left-to-right mark, U+200E NEW RFC 2070 -->
<!ENTITY rlm     "&#8207;"> <!-- right-to-left mark, U+200F NEW RFC 2070 -->
<!ENTITY ndash   "&#8211;"> <!-- en dash, U+2013 ISOpub -->
<!ENTITY mdash   "&#8212;"> <!-- em dash, U+2014 ISOpub -->
<!ENTITY lsquo   "&#8216;"> <!-- left single quotation mark,
                                    U+2018 ISOnum -->
<!ENTITY rsquo   "&#8217;"> <!-- right single quotation mark,
                                    U+2019 ISOnum -->
<!ENTITY sbquo   "&#8218;"> <!-- single low-9 quotation mark, U+201A NEW -->
<!ENTITY ldquo   "&#8220;"> <!-- left double quotation mark,
                                    U+201C ISOnum -->
<!ENTITY rdquo   "&#8221;"> <!-- right double quotation mark,
                                    U+201D ISOnum -->
<!ENTITY bdquo   "&#8222;"> <!-- double low-9 quotation mark, U+201E NEW -->
<!ENTITY dagger  "&#8224;"> <!-- dagger, U+2020 ISOpub -->
<!ENTITY Dagger  "&#8225;"> <!-- double dagger, U+2021 ISOpub -->
<!ENTITY permil  "&#8240;"> <!-- per mille sign, U+2030 ISOtech -->
<!ENTITY lsaquo  "&#8249;"> <!-- single left-pointing angle quotation mark,
                                    U+2039 ISO proposed -->
<!-- lsaquo is proposed but not yet ISO standardized -->
<!ENTITY rsaquo  "&#8250;"> <!-- single right-pointing angle quotation mark,
                                    U+203A ISO proposed -->
<!-- rsaquo is proposed but not yet ISO standardized -->

<!-- Currency Symbols -->
<!ENTITY euro   "&#8364;"> <!--  euro sign, U+20AC NEW -->
 6  P   ��
 B R O W S E A N D D O C I T X H T M L S Y M B O L       0 	        <!-- Mathematical, Greek and Symbolic characters for XHTML -->

<!-- Character entity set. Typical invocation:
     <!ENTITY % HTMLsymbol PUBLIC
        "-//W3C//ENTITIES Symbols for XHTML//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml-symbol.ent">
     %HTMLsymbol;
-->

<!-- Portions (C) International Organization for Standardization 1986:
     Permission to copy in any form is granted for use with
     conforming SGML systems and applications as defined in
     ISO 8879, provided this notice is included in all copies.
-->

<!-- Relevant ISO entity set is given unless names are newly introduced.
     New names (i.e., not in ISO 8879 list) do not clash with any
     existing ISO 8879 entity names. ISO 10646 character numbers
     are given for each character, in hex. values are decimal
     conversions of the ISO 10646 values and refer to the document
     character set. Names are Unicode names. 
-->

<!-- Latin Extended-B -->
<!ENTITY fnof     "&#402;"> <!-- latin small letter f with hook = function
                                    = florin, U+0192 ISOtech -->

<!-- Greek -->
<!ENTITY Alpha    "&#913;"> <!-- greek capital letter alpha, U+0391 -->
<!ENTITY Beta     "&#914;"> <!-- greek capital letter beta, U+0392 -->
<!ENTITY Gamma    "&#915;"> <!-- greek capital letter gamma,
                                    U+0393 ISOgrk3 -->
<!ENTITY Delta    "&#916;"> <!-- greek capital letter delta,
                                    U+0394 ISOgrk3 -->
<!ENTITY Epsilon  "&#917;"> <!-- greek capital letter epsilon, U+0395 -->
<!ENTITY Zeta     "&#918;"> <!-- greek capital letter zeta, U+0396 -->
<!ENTITY Eta      "&#919;"> <!-- greek capital letter eta, U+0397 -->
<!ENTITY Theta    "&#920;"> <!-- greek capital letter theta,
                                    U+0398 ISOgrk3 -->
<!ENTITY Iota     "&#921;"> <!-- greek capital letter iota, U+0399 -->
<!ENTITY Kappa    "&#922;"> <!-- greek capital letter kappa, U+039A -->
<!ENTITY Lambda   "&#923;"> <!-- greek capital letter lamda,
                                    U+039B ISOgrk3 -->
<!ENTITY Mu       "&#924;"> <!-- greek capital letter mu, U+039C -->
<!ENTITY Nu       "&#925;"> <!-- greek capital letter nu, U+039D -->
<!ENTITY Xi       "&#926;"> <!-- greek capital letter xi, U+039E ISOgrk3 -->
<!ENTITY Omicron  "&#927;"> <!-- greek capital letter omicron, U+039F -->
<!ENTITY Pi       "&#928;"> <!-- greek capital letter pi, U+03A0 ISOgrk3 -->
<!ENTITY Rho      "&#929;"> <!-- greek capital letter rho, U+03A1 -->
<!-- there is no Sigmaf, and no U+03A2 character either -->
<!ENTITY Sigma    "&#931;"> <!-- greek capital letter sigma,
                                    U+03A3 ISOgrk3 -->
<!ENTITY Tau      "&#932;"> <!-- greek capital letter tau, U+03A4 -->
<!ENTITY Upsilon  "&#933;"> <!-- greek capital letter upsilon,
                                    U+03A5 ISOgrk3 -->
<!ENTITY Phi      "&#934;"> <!-- greek capital letter phi,
                                    U+03A6 ISOgrk3 -->
<!ENTITY Chi      "&#935;"> <!-- greek capital letter chi, U+03A7 -->
<!ENTITY Psi      "&#936;"> <!-- greek capital letter psi,
                                    U+03A8 ISOgrk3 -->
<!ENTITY Omega    "&#937;"> <!-- greek capital letter omega,
                                    U+03A9 ISOgrk3 -->

<!ENTITY alpha    "&#945;"> <!-- greek small letter alpha,
                                    U+03B1 ISOgrk3 -->
<!ENTITY beta     "&#946;"> <!-- greek small letter beta, U+03B2 ISOgrk3 -->
<!ENTITY gamma    "&#947;"> <!-- greek small letter gamma,
                                    U+03B3 ISOgrk3 -->
<!ENTITY delta    "&#948;"> <!-- greek small letter delta,
                                    U+03B4 ISOgrk3 -->
<!ENTITY epsilon  "&#949;"> <!-- greek small letter epsilon,
                                    U+03B5 ISOgrk3 -->
<!ENTITY zeta     "&#950;"> <!-- greek small letter zeta, U+03B6 ISOgrk3 -->
<!ENTITY eta      "&#951;"> <!-- greek small letter eta, U+03B7 ISOgrk3 -->
<!ENTITY theta    "&#952;"> <!-- greek small letter theta,
                                    U+03B8 ISOgrk3 -->
<!ENTITY iota     "&#953;"> <!-- greek small letter iota, U+03B9 ISOgrk3 -->
<!ENTITY kappa    "&#954;"> <!-- greek small letter kappa,
                                    U+03BA ISOgrk3 -->
<!ENTITY lambda   "&#955;"> <!-- greek small letter lamda,
                                    U+03BB ISOgrk3 -->
<!ENTITY mu       "&#956;"> <!-- greek small letter mu, U+03BC ISOgrk3 -->
<!ENTITY nu       "&#957;"> <!-- greek small letter nu, U+03BD ISOgrk3 -->
<!ENTITY xi       "&#958;"> <!-- greek small letter xi, U+03BE ISOgrk3 -->
<!ENTITY omicron  "&#959;"> <!-- greek small letter omicron, U+03BF NEW -->
<!ENTITY pi       "&#960;"> <!-- greek small letter pi, U+03C0 ISOgrk3 -->
<!ENTITY rho      "&#961;"> <!-- greek small letter rho, U+03C1 ISOgrk3 -->
<!ENTITY sigmaf   "&#962;"> <!-- greek small letter final sigma,
                                    U+03C2 ISOgrk3 -->
<!ENTITY sigma    "&#963;"> <!-- greek small letter sigma,
                                    U+03C3 ISOgrk3 -->
<!ENTITY tau      "&#964;"> <!-- greek small letter tau, U+03C4 ISOgrk3 -->
<!ENTITY upsilon  "&#965;"> <!-- greek small letter upsilon,
                                    U+03C5 ISOgrk3 -->
<!ENTITY phi      "&#966;"> <!-- greek small letter phi, U+03C6 ISOgrk3 -->
<!ENTITY chi      "&#967;"> <!-- greek small letter chi, U+03C7 ISOgrk3 -->
<!ENTITY psi      "&#968;"> <!-- greek small letter psi, U+03C8 ISOgrk3 -->
<!ENTITY omega    "&#969;"> <!-- greek small letter omega,
                                    U+03C9 ISOgrk3 -->
<!ENTITY thetasym "&#977;"> <!-- greek theta symbol,
                                    U+03D1 NEW -->
<!ENTITY upsih    "&#978;"> <!-- greek upsilon with hook symbol,
                                    U+03D2 NEW -->
<!ENTITY piv      "&#982;"> <!-- greek pi symbol, U+03D6 ISOgrk3 -->

<!-- General Punctuation -->
<!ENTITY bull     "&#8226;"> <!-- bullet = black small circle,
                                     U+2022 ISOpub  -->
<!-- bullet is NOT the same as bullet operator, U+2219 -->
<!ENTITY hellip   "&#8230;"> <!-- horizontal ellipsis = three dot leader,
                                     U+2026 ISOpub  -->
<!ENTITY prime    "&#8242;"> <!-- prime = minutes = feet, U+2032 ISOtech -->
<!ENTITY Prime    "&#8243;"> <!-- double prime = seconds = inches,
                                     U+2033 ISOtech -->
<!ENTITY oline    "&#8254;"> <!-- overline = spacing overscore,
                                     U+203E NEW -->
<!ENTITY frasl    "&#8260;"> <!-- fraction slash, U+2044 NEW -->

<!-- Letterlike Symbols -->
<!ENTITY weierp   "&#8472;"> <!-- script capital P = power set
                                     = Weierstrass p, U+2118 ISOamso -->
<!ENTITY image    "&#8465;"> <!-- black-letter capital I = imaginary part,
                                     U+2111 ISOamso -->
<!ENTITY real     "&#8476;"> <!-- black-letter capital R = real part symbol,
                                     U+211C ISOamso -->
<!ENTITY trade    "&#8482;"> <!-- trade mark sign, U+2122 ISOnum -->
<!ENTITY alefsym  "&#8501;"> <!-- alef symbol = first transfinite cardinal,
                                     U+2135 NEW -->
<!-- alef symbol is NOT the same as hebrew letter alef,
     U+05D0 although the same glyph could be used to depict both characters -->

<!-- Arrows -->
<!ENTITY larr     "&#8592;"> <!-- leftwards arrow, U+2190 ISOnum -->
<!ENTITY uarr     "&#8593;"> <!-- upwards arrow, U+2191 ISOnum-->
<!ENTITY rarr     "&#8594;"> <!-- rightwards arrow, U+2192 ISOnum -->
<!ENTITY darr     "&#8595;"> <!-- downwards arrow, U+2193 ISOnum -->
<!ENTITY harr     "&#8596;"> <!-- left right arrow, U+2194 ISOamsa -->
<!ENTITY crarr    "&#8629;"> <!-- downwards arrow with corner leftwards
                                     = carriage return, U+21B5 NEW -->
<!ENTITY lArr     "&#8656;"> <!-- leftwards double arrow, U+21D0 ISOtech -->
<!-- Unicode does not say that lArr is the same as the 'is implied by' arrow
    but also does not have any other character for that function. So lArr can
    be used for 'is implied by' as ISOtech suggests -->
<!ENTITY uArr     "&#8657;"> <!-- upwards double arrow, U+21D1 ISOamsa -->
<!ENTITY rArr     "&#8658;"> <!-- rightwards double arrow,
                                     U+21D2 ISOtech -->
<!-- Unicode does not say this is the 'implies' character but does not have 
     another character with this function so rArr can be used for 'implies'
     as ISOtech suggests -->
<!ENTITY dArr     "&#8659;"> <!-- downwards double arrow, U+21D3 ISOamsa -->
<!ENTITY hArr     "&#8660;"> <!-- left right double arrow,
                                     U+21D4 ISOamsa -->

<!-- Mathematical Operators -->
<!ENTITY forall   "&#8704;"> <!-- for all, U+2200 ISOtech -->
<!ENTITY part     "&#8706;"> <!-- partial differential, U+2202 ISOtech  -->
<!ENTITY exist    "&#8707;"> <!-- there exists, U+2203 ISOtech -->
<!ENTITY empty    "&#8709;"> <!-- empty set = null set, U+2205 ISOamso -->
<!ENTITY nabla    "&#8711;"> <!-- nabla = backward difference,
                                     U+2207 ISOtech -->
<!ENTITY isin     "&#8712;"> <!-- element of, U+2208 ISOtech -->
<!ENTITY notin    "&#8713;"> <!-- not an element of, U+2209 ISOtech -->
<!ENTITY ni       "&#8715;"> <!-- contains as member, U+220B ISOtech -->
<!ENTITY prod     "&#8719;"> <!-- n-ary product = product sign,
                                     U+220F ISOamsb -->
<!-- prod is NOT the same character as U+03A0 'greek capital letter pi' though
     the same glyph might be used for both -->
<!ENTITY sum      "&#8721;"> <!-- n-ary summation, U+2211 ISOamsb -->
<!-- sum is NOT the same character as U+03A3 'greek capital letter sigma'
     though the same glyph might be used for both -->
<!ENTITY minus    "&#8722;"> <!-- minus sign, U+2212 ISOtech -->
<!ENTITY lowast   "&#8727;"> <!-- asterisk operator, U+2217 ISOtech -->
<!ENTITY radic    "&#8730;"> <!-- square root = radical sign,
                                     U+221A ISOtech -->
<!ENTITY prop     "&#8733;"> <!-- proportional to, U+221D ISOtech -->
<!ENTITY infin    "&#8734;"> <!-- infinity, U+221E ISOtech -->
<!ENTITY ang      "&#8736;"> <!-- angle, U+2220 ISOamso -->
<!ENTITY and      "&#8743;"> <!-- logical and = wedge, U+2227 ISOtech -->
<!ENTITY or       "&#8744;"> <!-- logical or = vee, U+2228 ISOtech -->
<!ENTITY cap      "&#8745;"> <!-- intersection = cap, U+2229 ISOtech -->
<!ENTITY cup      "&#8746;"> <!-- union = cup, U+222A ISOtech -->
<!ENTITY int      "&#8747;"> <!-- integral, U+222B ISOtech -->
<!ENTITY there4   "&#8756;"> <!-- therefore, U+2234 ISOtech -->
<!ENTITY sim      "&#8764;"> <!-- tilde operator = varies with = similar to,
                                     U+223C ISOtech -->
<!-- tilde operator is NOT the same character as the tilde, U+007E,
     although the same glyph might be used to represent both  -->
<!ENTITY cong     "&#8773;"> <!-- approximately equal to, U+2245 ISOtech -->
<!ENTITY asymp    "&#8776;"> <!-- almost equal to = asymptotic to,
                                     U+2248 ISOamsr -->
<!ENTITY ne       "&#8800;"> <!-- not equal to, U+2260 ISOtech -->
<!ENTITY equiv    "&#8801;"> <!-- identical to, U+2261 ISOtech -->
<!ENTITY le       "&#8804;"> <!-- less-than or equal to, U+2264 ISOtech -->
<!ENTITY ge       "&#8805;"> <!-- greater-than or equal to,
                                     U+2265 ISOtech -->
<!ENTITY sub      "&#8834;"> <!-- subset of, U+2282 ISOtech -->
<!ENTITY sup      "&#8835;"> <!-- superset of, U+2283 ISOtech -->
<!ENTITY nsub     "&#8836;"> <!-- not a subset of, U+2284 ISOamsn -->
<!ENTITY sube     "&#8838;"> <!-- subset of or equal to, U+2286 ISOtech -->
<!ENTITY supe     "&#8839;"> <!-- superset of or equal to,
                                     U+2287 ISOtech -->
<!ENTITY oplus    "&#8853;"> <!-- circled plus = direct sum,
                                     U+2295 ISOamsb -->
<!ENTITY otimes   "&#8855;"> <!-- circled times = vector product,
                                     U+2297 ISOamsb -->
<!ENTITY perp     "&#8869;"> <!-- up tack = orthogonal to = perpendicular,
                                     U+22A5 ISOtech -->
<!ENTITY sdot     "&#8901;"> <!-- dot operator, U+22C5 ISOamsb -->
<!-- dot operator is NOT the same character as U+00B7 middle dot -->

<!-- Miscellaneous Technical -->
<!ENTITY lceil    "&#8968;"> <!-- left ceiling = APL upstile,
                                     U+2308 ISOamsc  -->
<!ENTITY rceil    "&#8969;"> <!-- right ceiling, U+2309 ISOamsc  -->
<!ENTITY lfloor   "&#8970;"> <!-- left floor = APL downstile,
                                     U+230A ISOamsc  -->
<!ENTITY rfloor   "&#8971;"> <!-- right floor, U+230B ISOamsc  -->
<!ENTITY lang     "&#9001;"> <!-- left-pointing angle bracket = bra,
                                     U+2329 ISOtech -->
<!-- lang is NOT the same character as U+003C 'less than sign' 
     or U+2039 'single left-pointing angle quotation mark' -->
<!ENTITY rang     "&#9002;"> <!-- right-pointing angle bracket = ket,
                                     U+232A ISOtech -->
<!-- rang is NOT the same character as U+003E 'greater than sign' 
     or U+203A 'single right-pointing angle quotation mark' -->

<!-- Geometric Shapes -->
<!ENTITY loz      "&#9674;"> <!-- lozenge, U+25CA ISOpub -->

<!-- Miscellaneous Symbols -->
<!ENTITY spades   "&#9824;"> <!-- black spade suit, U+2660 ISOpub -->
<!-- black here seems to mean filled as opposed to hollow -->
<!ENTITY clubs    "&#9827;"> <!-- black club suit = shamrock,
                                     U+2663 ISOpub -->
<!ENTITY hearts   "&#9829;"> <!-- black heart suit = valentine,
                                     U+2665 ISOpub -->
<!ENTITY diams    "&#9830;"> <!-- black diamond suit, U+2666 ISOpub -->
�c  P   ��
 B R O W S E A N D D O C I T X H T M L S T R I C T       0 	        <!--
   Extensible HTML version 1.0 Strict DTD

   This is the same as HTML 4 Strict except for
   changes due to the differences between XML and SGML.

   Namespace = http://www.w3.org/1999/xhtml

   For further information, see: http://www.w3.org/TR/xhtml1

   Copyright (c) 1998-2002 W3C (MIT, INRIA, Keio),
   All Rights Reserved. 

   This DTD module is identified by the PUBLIC and SYSTEM identifiers:

   PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   SYSTEM "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"

   $Revision: 1.1 $
   $Date: 2002/08/01 13:56:03 $

-->

<!--================ Character mnemonic entities =========================-->

<!ENTITY % HTMLlat1 PUBLIC
   "-//W3C//ENTITIES Latin 1 for XHTML//EN"
   "xhtml-lat1.ent">
%HTMLlat1;

<!ENTITY % HTMLsymbol PUBLIC
   "-//W3C//ENTITIES Symbols for XHTML//EN"
   "xhtml-symbol.ent">
%HTMLsymbol;

<!ENTITY % HTMLspecial PUBLIC
   "-//W3C//ENTITIES Special for XHTML//EN"
   "xhtml-special.ent">
%HTMLspecial;

<!--================== Imported Names ====================================-->

<!ENTITY % ContentType "CDATA">
    <!-- media type, as per [RFC2045] -->

<!ENTITY % ContentTypes "CDATA">
    <!-- comma-separated list of media types, as per [RFC2045] -->

<!ENTITY % Charset "CDATA">
    <!-- a character encoding, as per [RFC2045] -->

<!ENTITY % Charsets "CDATA">
    <!-- a space separated list of character encodings, as per [RFC2045] -->

<!ENTITY % LanguageCode "NMTOKEN">
    <!-- a language code, as per [RFC3066] -->

<!ENTITY % Character "CDATA">
    <!-- a single character, as per section 2.2 of [XML] -->

<!ENTITY % Number "CDATA">
    <!-- one or more digits -->

<!ENTITY % LinkTypes "CDATA">
    <!-- space-separated list of link types -->

<!ENTITY % MediaDesc "CDATA">
    <!-- single or comma-separated list of media descriptors -->

<!ENTITY % URI "CDATA">
    <!-- a Uniform Resource Identifier, see [RFC2396] -->

<!ENTITY % UriList "CDATA">
    <!-- a space separated list of Uniform Resource Identifiers -->

<!ENTITY % Datetime "CDATA">
    <!-- date and time information. ISO date format -->

<!ENTITY % Script "CDATA">
    <!-- script expression -->

<!ENTITY % StyleSheet "CDATA">
    <!-- style sheet data -->

<!ENTITY % Text "CDATA">
    <!-- used for titles etc. -->

<!ENTITY % Length "CDATA">
    <!-- nn for pixels or nn% for percentage length -->

<!ENTITY % MultiLength "CDATA">
    <!-- pixel, percentage, or relative -->

<!ENTITY % Pixels "CDATA">
    <!-- integer representing length in pixels -->

<!-- these are used for image maps -->

<!ENTITY % Shape "(rect|circle|poly|default)">

<!ENTITY % Coords "CDATA">
    <!-- comma separated list of lengths -->

<!--=================== Generic Attributes ===============================-->

<!-- core attributes common to most elements
  id       document-wide unique id
  class    space separated list of classes
  style    associated style info
  title    advisory title/amplification
-->
<!ENTITY % coreattrs
 "id          ID             #IMPLIED
  class       CDATA          #IMPLIED
  style       %StyleSheet;   #IMPLIED
  title       %Text;         #IMPLIED"
  >

<!-- internationalization attributes
  lang        language code (backwards compatible)
  xml:lang    language code (as per XML 1.0 spec)
  dir         direction for weak/neutral text
-->
<!ENTITY % i18n
 "lang        %LanguageCode; #IMPLIED
  xml:lang    %LanguageCode; #IMPLIED
  dir         (ltr|rtl)      #IMPLIED"
  >

<!-- attributes for common UI events
  onclick     a pointer button was clicked
  ondblclick  a pointer button was double clicked
  onmousedown a pointer button was pressed down
  onmouseup   a pointer button was released
  onmousemove a pointer was moved onto the element
  onmouseout  a pointer was moved away from the element
  onkeypress  a key was pressed and released
  onkeydown   a key was pressed down
  onkeyup     a key was released
-->
<!ENTITY % events
 "onclick     %Script;       #IMPLIED
  ondblclick  %Script;       #IMPLIED
  onmousedown %Script;       #IMPLIED
  onmouseup   %Script;       #IMPLIED
  onmouseover %Script;       #IMPLIED
  onmousemove %Script;       #IMPLIED
  onmouseout  %Script;       #IMPLIED
  onkeypress  %Script;       #IMPLIED
  onkeydown   %Script;       #IMPLIED
  onkeyup     %Script;       #IMPLIED"
  >

<!-- attributes for elements that can get the focus
  accesskey   accessibility key character
  tabindex    position in tabbing order
  onfocus     the element got the focus
  onblur      the element lost the focus
-->
<!ENTITY % focus
 "accesskey   %Character;    #IMPLIED
  tabindex    %Number;       #IMPLIED
  onfocus     %Script;       #IMPLIED
  onblur      %Script;       #IMPLIED"
  >

<!ENTITY % attrs "%coreattrs; %i18n; %events;">

<!--=================== Text Elements ====================================-->

<!ENTITY % special.pre
   "br | span | bdo | map">


<!ENTITY % special
   "%special.pre; | object | img ">

<!ENTITY % fontstyle "tt | i | b | big | small ">

<!ENTITY % phrase "em | strong | dfn | code | q |
                   samp | kbd | var | cite | abbr | acronym | sub | sup ">

<!ENTITY % inline.forms "input | select | textarea | label | button">

<!-- these can occur at block or inline level -->
<!ENTITY % misc.inline "ins | del | script">

<!-- these can only occur at block level -->
<!ENTITY % misc "noscript | %misc.inline;">

<!ENTITY % inline "a | %special; | %fontstyle; | %phrase; | %inline.forms;">

<!-- %Inline; covers inline or "text-level" elements -->
<!ENTITY % Inline "(#PCDATA | %inline; | %misc.inline;)*">

<!--================== Block level elements ==============================-->

<!ENTITY % heading "h1|h2|h3|h4|h5|h6">
<!ENTITY % lists "ul | ol | dl">
<!ENTITY % blocktext "pre | hr | blockquote | address">

<!ENTITY % block
     "p | %heading; | div | %lists; | %blocktext; | fieldset | table">

<!ENTITY % Block "(%block; | form | %misc;)*">

<!-- %Flow; mixes block and inline and is used for list items etc. -->
<!ENTITY % Flow "(#PCDATA | %block; | form | %inline; | %misc;)*">

<!--================== Content models for exclusions =====================-->

<!-- a elements use %Inline; excluding a -->

<!ENTITY % a.content
   "(#PCDATA | %special; | %fontstyle; | %phrase; | %inline.forms; | %misc.inline;)*">

<!-- pre uses %Inline excluding big, small, sup or sup -->

<!ENTITY % pre.content
   "(#PCDATA | a | %fontstyle; | %phrase; | %special.pre; | %misc.inline;
      | %inline.forms;)*">

<!-- form uses %Block; excluding form -->

<!ENTITY % form.content "(%block; | %misc;)*">

<!-- button uses %Flow; but excludes a, form and form controls -->

<!ENTITY % button.content
   "(#PCDATA | p | %heading; | div | %lists; | %blocktext; |
    table | %special; | %fontstyle; | %phrase; | %misc;)*">

<!--================ Document Structure ==================================-->

<!-- the namespace URI designates the document profile -->

<!ELEMENT html (head, body)>
<!ATTLIST html
  %i18n;
  id          ID             #IMPLIED
  xmlns       %URI;          #FIXED 'http://www.w3.org/1999/xhtml'
  >

<!--================ Document Head =======================================-->

<!ENTITY % head.misc "(script|style|meta|link|object)*">

<!-- content model is %head.misc; combined with a single
     title and an optional base element in any order -->

<!ELEMENT head (%head.misc;,
     ((title, %head.misc;, (base, %head.misc;)?) |
      (base, %head.misc;, (title, %head.misc;))))>

<!ATTLIST head
  %i18n;
  id          ID             #IMPLIED
  profile     %URI;          #IMPLIED
  >

<!-- The title element is not considered part of the flow of text.
       It should be displayed, for example as the page header or
       window title. Exactly one title is required per document.
    -->
<!ELEMENT title (#PCDATA)>
<!ATTLIST title 
  %i18n;
  id          ID             #IMPLIED
  >

<!-- document base URI -->

<!ELEMENT base EMPTY>
<!ATTLIST base
  href        %URI;          #REQUIRED
  id          ID             #IMPLIED
  >

<!-- generic metainformation -->
<!ELEMENT meta EMPTY>
<!ATTLIST meta
  %i18n;
  id          ID             #IMPLIED
  http-equiv  CDATA          #IMPLIED
  name        CDATA          #IMPLIED
  content     CDATA          #REQUIRED
  scheme      CDATA          #IMPLIED
  >

<!--
  Relationship values can be used in principle:

   a) for document specific toolbars/menus when used
      with the link element in document head e.g.
        start, contents, previous, next, index, end, help
   b) to link to a separate style sheet (rel="stylesheet")
   c) to make a link to a script (rel="script")
   d) by stylesheets to control how collections of
      html nodes are rendered into printed documents
   e) to make a link to a printable version of this document
      e.g. a PostScript or PDF version (rel="alternate" media="print")
-->

<!ELEMENT link EMPTY>
<!ATTLIST link
  %attrs;
  charset     %Charset;      #IMPLIED
  href        %URI;          #IMPLIED
  hreflang    %LanguageCode; #IMPLIED
  type        %ContentType;  #IMPLIED
  rel         %LinkTypes;    #IMPLIED
  rev         %LinkTypes;    #IMPLIED
  media       %MediaDesc;    #IMPLIED
  >

<!-- style info, which may include CDATA sections -->
<!ELEMENT style (#PCDATA)>
<!ATTLIST style
  %i18n;
  id          ID             #IMPLIED
  type        %ContentType;  #REQUIRED
  media       %MediaDesc;    #IMPLIED
  title       %Text;         #IMPLIED
  xml:space   (preserve)     #FIXED 'preserve'
  >

<!-- script statements, which may include CDATA sections -->
<!ELEMENT script (#PCDATA)>
<!ATTLIST script
  id          ID             #IMPLIED
  charset     %Charset;      #IMPLIED
  type        %ContentType;  #REQUIRED
  src         %URI;          #IMPLIED
  defer       (defer)        #IMPLIED
  xml:space   (preserve)     #FIXED 'preserve'
  >

<!-- alternate content container for non script-based rendering -->

<!ELEMENT noscript %Block;>
<!ATTLIST noscript
  %attrs;
  >

<!--=================== Document Body ====================================-->

<!ELEMENT body %Block;>
<!ATTLIST body
  %attrs;
  onload          %Script;   #IMPLIED
  onunload        %Script;   #IMPLIED
  >

<!ELEMENT div %Flow;>  <!-- generic language/style container -->
<!ATTLIST div
  %attrs;
  >

<!--=================== Paragraphs =======================================-->

<!ELEMENT p %Inline;>
<!ATTLIST p
  %attrs;
  >

<!--=================== Headings =========================================-->

<!--
  There are six levels of headings from h1 (the most important)
  to h6 (the least important).
-->

<!ELEMENT h1  %Inline;>
<!ATTLIST h1
   %attrs;
   >

<!ELEMENT h2 %Inline;>
<!ATTLIST h2
   %attrs;
   >

<!ELEMENT h3 %Inline;>
<!ATTLIST h3
   %attrs;
   >

<!ELEMENT h4 %Inline;>
<!ATTLIST h4
   %attrs;
   >

<!ELEMENT h5 %Inline;>
<!ATTLIST h5
   %attrs;
   >

<!ELEMENT h6 %Inline;>
<!ATTLIST h6
   %attrs;
   >

<!--=================== Lists ============================================-->

<!-- Unordered list -->

<!ELEMENT ul (li)+>
<!ATTLIST ul
  %attrs;
  >

<!-- Ordered (numbered) list -->

<!ELEMENT ol (li)+>
<!ATTLIST ol
  %attrs;
  >

<!-- list item -->

<!ELEMENT li %Flow;>
<!ATTLIST li
  %attrs;
  >

<!-- definition lists - dt for term, dd for its definition -->

<!ELEMENT dl (dt|dd)+>
<!ATTLIST dl
  %attrs;
  >

<!ELEMENT dt %Inline;>
<!ATTLIST dt
  %attrs;
  >

<!ELEMENT dd %Flow;>
<!ATTLIST dd
  %attrs;
  >

<!--=================== Address ==========================================-->

<!-- information on author -->

<!ELEMENT address %Inline;>
<!ATTLIST address
  %attrs;
  >

<!--=================== Horizontal Rule ==================================-->

<!ELEMENT hr EMPTY>
<!ATTLIST hr
  %attrs;
  >

<!--=================== Preformatted Text ================================-->

<!-- content is %Inline; excluding "img|object|big|small|sub|sup" -->

<!ELEMENT pre %pre.content;>
<!ATTLIST pre
  %attrs;
  xml:space (preserve) #FIXED 'preserve'
  >

<!--=================== Block-like Quotes ================================-->

<!ELEMENT blockquote %Block;>
<!ATTLIST blockquote
  %attrs;
  cite        %URI;          #IMPLIED
  >

<!--=================== Inserted/Deleted Text ============================-->

<!--
  ins/del are allowed in block and inline content, but its
  inappropriate to include block content within an ins element
  occurring in inline content.
-->
<!ELEMENT ins %Flow;>
<!ATTLIST ins
  %attrs;
  cite        %URI;          #IMPLIED
  datetime    %Datetime;     #IMPLIED
  >

<!ELEMENT del %Flow;>
<!ATTLIST del
  %attrs;
  cite        %URI;          #IMPLIED
  datetime    %Datetime;     #IMPLIED
  >

<!--================== The Anchor Element ================================-->

<!-- content is %Inline; except that anchors shouldn't be nested -->

<!ELEMENT a %a.content;>
<!ATTLIST a
  %attrs;
  %focus;
  charset     %Charset;      #IMPLIED
  type        %ContentType;  #IMPLIED
  name        NMTOKEN        #IMPLIED
  href        %URI;          #IMPLIED
  hreflang    %LanguageCode; #IMPLIED
  rel         %LinkTypes;    #IMPLIED
  rev         %LinkTypes;    #IMPLIED
  shape       %Shape;        "rect"
  coords      %Coords;       #IMPLIED
  >

<!--===================== Inline Elements ================================-->

<!ELEMENT span %Inline;> <!-- generic language/style container -->
<!ATTLIST span
  %attrs;
  >

<!ELEMENT bdo %Inline;>  <!-- I18N BiDi over-ride -->
<!ATTLIST bdo
  %coreattrs;
  %events;
  lang        %LanguageCode; #IMPLIED
  xml:lang    %LanguageCode; #IMPLIED
  dir         (ltr|rtl)      #REQUIRED
  >

<!ELEMENT br EMPTY>   <!-- forced line break -->
<!ATTLIST br
  %coreattrs;
  >

<!ELEMENT em %Inline;>   <!-- emphasis -->
<!ATTLIST em %attrs;>

<!ELEMENT strong %Inline;>   <!-- strong emphasis -->
<!ATTLIST strong %attrs;>

<!ELEMENT dfn %Inline;>   <!-- definitional -->
<!ATTLIST dfn %attrs;>

<!ELEMENT code %Inline;>   <!-- program code -->
<!ATTLIST code %attrs;>

<!ELEMENT samp %Inline;>   <!-- sample -->
<!ATTLIST samp %attrs;>

<!ELEMENT kbd %Inline;>  <!-- something user would type -->
<!ATTLIST kbd %attrs;>

<!ELEMENT var %Inline;>   <!-- variable -->
<!ATTLIST var %attrs;>

<!ELEMENT cite %Inline;>   <!-- citation -->
<!ATTLIST cite %attrs;>

<!ELEMENT abbr %Inline;>   <!-- abbreviation -->
<!ATTLIST abbr %attrs;>

<!ELEMENT acronym %Inline;>   <!-- acronym -->
<!ATTLIST acronym %attrs;>

<!ELEMENT q %Inline;>   <!-- inlined quote -->
<!ATTLIST q
  %attrs;
  cite        %URI;          #IMPLIED
  >

<!ELEMENT sub %Inline;> <!-- subscript -->
<!ATTLIST sub %attrs;>

<!ELEMENT sup %Inline;> <!-- superscript -->
<!ATTLIST sup %attrs;>

<!ELEMENT tt %Inline;>   <!-- fixed pitch font -->
<!ATTLIST tt %attrs;>

<!ELEMENT i %Inline;>   <!-- italic font -->
<!ATTLIST i %attrs;>

<!ELEMENT b %Inline;>   <!-- bold font -->
<!ATTLIST b %attrs;>

<!ELEMENT big %Inline;>   <!-- bigger font -->
<!ATTLIST big %attrs;>

<!ELEMENT small %Inline;>   <!-- smaller font -->
<!ATTLIST small %attrs;>

<!--==================== Object ======================================-->
<!--
  object is used to embed objects as part of HTML pages.
  param elements should precede other content. Parameters
  can also be expressed as attribute/value pairs on the
  object element itself when brevity is desired.
-->

<!ELEMENT object (#PCDATA | param | %block; | form | %inline; | %misc;)*>
<!ATTLIST object
  %attrs;
  declare     (declare)      #IMPLIED
  classid     %URI;          #IMPLIED
  codebase    %URI;          #IMPLIED
  data        %URI;          #IMPLIED
  type        %ContentType;  #IMPLIED
  codetype    %ContentType;  #IMPLIED
  archive     %UriList;      #IMPLIED
  standby     %Text;         #IMPLIED
  height      %Length;       #IMPLIED
  width       %Length;       #IMPLIED
  usemap      %URI;          #IMPLIED
  name        NMTOKEN        #IMPLIED
  tabindex    %Number;       #IMPLIED
  >

<!--
  param is used to supply a named property value.
  In XML it would seem natural to follow RDF and support an
  abbreviated syntax where the param elements are replaced
  by attribute value pairs on the object start tag.
-->
<!ELEMENT param EMPTY>
<!ATTLIST param
  id          ID             #IMPLIED
  name        CDATA          #IMPLIED
  value       CDATA          #IMPLIED
  valuetype   (data|ref|object) "data"
  type        %ContentType;  #IMPLIED
  >

<!--=================== Images ===========================================-->

<!--
   To avoid accessibility problems for people who aren't
   able to see the image, you should provide a text
   description using the alt and longdesc attributes.
   In addition, avoid the use of server-side image maps.
   Note that in this DTD there is no name attribute. That
   is only available in the transitional and frameset DTD.
-->

<!ELEMENT img EMPTY>
<!ATTLIST img
  %attrs;
  src         %URI;          #REQUIRED
  alt         %Text;         #REQUIRED
  longdesc    %URI;          #IMPLIED
  height      %Length;       #IMPLIED
  width       %Length;       #IMPLIED
  usemap      %URI;          #IMPLIED
  ismap       (ismap)        #IMPLIED
  >

<!-- usemap points to a map element which may be in this document
  or an external document, although the latter is not widely supported -->

<!--================== Client-side image maps ============================-->

<!-- These can be placed in the same document or grouped in a
     separate document although this isn't yet widely supported -->

<!ELEMENT map ((%block; | form | %misc;)+ | area+)>
<!ATTLIST map
  %i18n;
  %events;
  id          ID             #REQUIRED
  class       CDATA          #IMPLIED
  style       %StyleSheet;   #IMPLIED
  title       %Text;         #IMPLIED
  name        NMTOKEN        #IMPLIED
  >

<!ELEMENT area EMPTY>
<!ATTLIST area
  %attrs;
  %focus;
  shape       %Shape;        "rect"
  coords      %Coords;       #IMPLIED
  href        %URI;          #IMPLIED
  nohref      (nohref)       #IMPLIED
  alt         %Text;         #REQUIRED
  >

<!--================ Forms ===============================================-->
<!ELEMENT form %form.content;>   <!-- forms shouldn't be nested -->

<!ATTLIST form
  %attrs;
  action      %URI;          #REQUIRED
  method      (get|post)     "get"
  enctype     %ContentType;  "application/x-www-form-urlencoded"
  onsubmit    %Script;       #IMPLIED
  onreset     %Script;       #IMPLIED
  accept      %ContentTypes; #IMPLIED
  accept-charset %Charsets;  #IMPLIED
  >

<!--
  Each label must not contain more than ONE field
  Label elements shouldn't be nested.
-->
<!ELEMENT label %Inline;>
<!ATTLIST label
  %attrs;
  for         IDREF          #IMPLIED
  accesskey   %Character;    #IMPLIED
  onfocus     %Script;       #IMPLIED
  onblur      %Script;       #IMPLIED
  >

<!ENTITY % InputType
  "(text | password | checkbox |
    radio | submit | reset |
    file | hidden | image | button)"
   >

<!-- the name attribute is required for all but submit & reset -->

<!ELEMENT input EMPTY>     <!-- form control -->
<!ATTLIST input
  %attrs;
  %focus;
  type        %InputType;    "text"
  name        CDATA          #IMPLIED
  value       CDATA          #IMPLIED
  checked     (checked)      #IMPLIED
  disabled    (disabled)     #IMPLIED
  readonly    (readonly)     #IMPLIED
  size        CDATA          #IMPLIED
  maxlength   %Number;       #IMPLIED
  src         %URI;          #IMPLIED
  alt         CDATA          #IMPLIED
  usemap      %URI;          #IMPLIED
  onselect    %Script;       #IMPLIED
  onchange    %Script;       #IMPLIED
  accept      %ContentTypes; #IMPLIED
  >

<!ELEMENT select (optgroup|option)+>  <!-- option selector -->
<!ATTLIST select
  %attrs;
  name        CDATA          #IMPLIED
  size        %Number;       #IMPLIED
  multiple    (multiple)     #IMPLIED
  disabled    (disabled)     #IMPLIED
  tabindex    %Number;       #IMPLIED
  onfocus     %Script;       #IMPLIED
  onblur      %Script;       #IMPLIED
  onchange    %Script;       #IMPLIED
  >

<!ELEMENT optgroup (option)+>   <!-- option group -->
<!ATTLIST optgroup
  %attrs;
  disabled    (disabled)     #IMPLIED
  label       %Text;         #REQUIRED
  >

<!ELEMENT option (#PCDATA)>     <!-- selectable choice -->
<!ATTLIST option
  %attrs;
  selected    (selected)     #IMPLIED
  disabled    (disabled)     #IMPLIED
  label       %Text;         #IMPLIED
  value       CDATA          #IMPLIED
  >

<!ELEMENT textarea (#PCDATA)>     <!-- multi-line text field -->
<!ATTLIST textarea
  %attrs;
  %focus;
  name        CDATA          #IMPLIED
  rows        %Number;       #REQUIRED
  cols        %Number;       #REQUIRED
  disabled    (disabled)     #IMPLIED
  readonly    (readonly)     #IMPLIED
  onselect    %Script;       #IMPLIED
  onchange    %Script;       #IMPLIED
  >

<!--
  The fieldset element is used to group form fields.
  Only one legend element should occur in the content
  and if present should only be preceded by whitespace.
-->
<!ELEMENT fieldset (#PCDATA | legend | %block; | form | %inline; | %misc;)*>
<!ATTLIST fieldset
  %attrs;
  >

<!ELEMENT legend %Inline;>     <!-- fieldset label -->
<!ATTLIST legend
  %attrs;
  accesskey   %Character;    #IMPLIED
  >

<!--
 Content is %Flow; excluding a, form and form controls
--> 
<!ELEMENT button %button.content;>  <!-- push button -->
<!ATTLIST button
  %attrs;
  %focus;
  name        CDATA          #IMPLIED
  value       CDATA          #IMPLIED
  type        (button|submit|reset) "submit"
  disabled    (disabled)     #IMPLIED
  >

<!--======================= Tables =======================================-->

<!-- Derived from IETF HTML table standard, see [RFC1942] -->

<!--
 The border attribute sets the thickness of the frame around the
 table. The default units are screen pixels.

 The frame attribute specifies which parts of the frame around
 the table should be rendered. The values are not the same as
 CALS to avoid a name clash with the valign attribute.
-->
<!ENTITY % TFrame "(void|above|below|hsides|lhs|rhs|vsides|box|border)">

<!--
 The rules attribute defines which rules to draw between cells:

 If rules is absent then assume:
     "none" if border is absent or border="0" otherwise "all"
-->

<!ENTITY % TRules "(none | groups | rows | cols | all)">
  
<!-- horizontal alignment attributes for cell contents

  char        alignment char, e.g. char=':'
  charoff     offset for alignment char
-->
<!ENTITY % cellhalign
  "align      (left|center|right|justify|char) #IMPLIED
   char       %Character;    #IMPLIED
   charoff    %Length;       #IMPLIED"
  >

<!-- vertical alignment attributes for cell contents -->
<!ENTITY % cellvalign
  "valign     (top|middle|bottom|baseline) #IMPLIED"
  >

<!ELEMENT table
     (caption?, (col*|colgroup*), thead?, tfoot?, (tbody+|tr+))>
<!ELEMENT caption  %Inline;>
<!ELEMENT thead    (tr)+>
<!ELEMENT tfoot    (tr)+>
<!ELEMENT tbody    (tr)+>
<!ELEMENT colgroup (col)*>
<!ELEMENT col      EMPTY>
<!ELEMENT tr       (th|td)+>
<!ELEMENT th       %Flow;>
<!ELEMENT td       %Flow;>

<!ATTLIST table
  %attrs;
  summary     %Text;         #IMPLIED
  width       %Length;       #IMPLIED
  border      %Pixels;       #IMPLIED
  frame       %TFrame;       #IMPLIED
  rules       %TRules;       #IMPLIED
  cellspacing %Length;       #IMPLIED
  cellpadding %Length;       #IMPLIED
  >

<!ATTLIST caption
  %attrs;
  >

<!--
colgroup groups a set of col elements. It allows you to group
several semantically related columns together.
-->
<!ATTLIST colgroup
  %attrs;
  span        %Number;       "1"
  width       %MultiLength;  #IMPLIED
  %cellhalign;
  %cellvalign;
  >

<!--
 col elements define the alignment properties for cells in
 one or more columns.

 The width attribute specifies the width of the columns, e.g.

     width=64        width in screen pixels
     width=0.5*      relative width of 0.5

 The span attribute causes the attributes of one
 col element to apply to more than one column.
-->
<!ATTLIST col
  %attrs;
  span        %Number;       "1"
  width       %MultiLength;  #IMPLIED
  %cellhalign;
  %cellvalign;
  >

<!--
    Use thead to duplicate headers when breaking table
    across page boundaries, or for static headers when
    tbody sections are rendered in scrolling panel.

    Use tfoot to duplicate footers when breaking table
    across page boundaries, or for static footers when
    tbody sections are rendered in scrolling panel.

    Use multiple tbody sections when rules are needed
    between groups of table rows.
-->
<!ATTLIST thead
  %attrs;
  %cellhalign;
  %cellvalign;
  >

<!ATTLIST tfoot
  %attrs;
  %cellhalign;
  %cellvalign;
  >

<!ATTLIST tbody
  %attrs;
  %cellhalign;
  %cellvalign;
  >

<!ATTLIST tr
  %attrs;
  %cellhalign;
  %cellvalign;
  >


<!-- Scope is simpler than headers attribute for common tables -->
<!ENTITY % Scope "(row|col|rowgroup|colgroup)">

<!-- th is for headers, td for data and for cells acting as both -->

<!ATTLIST th
  %attrs;
  abbr        %Text;         #IMPLIED
  axis        CDATA          #IMPLIED
  headers     IDREFS         #IMPLIED
  scope       %Scope;        #IMPLIED
  rowspan     %Number;       "1"
  colspan     %Number;       "1"
  %cellhalign;
  %cellvalign;
  >

<!ATTLIST td
  %attrs;
  abbr        %Text;         #IMPLIED
  axis        CDATA          #IMPLIED
  headers     IDREFS         #IMPLIED
  scope       %Scope;        #IMPLIED
  rowspan     %Number;       "1"
  colspan     %Number;       "1"
  %cellhalign;
  %cellvalign;
  >

