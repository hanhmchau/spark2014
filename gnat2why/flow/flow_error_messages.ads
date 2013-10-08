------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                  F L O W _ E R R O R _ M E S S A G E S                   --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                  Copyright (C) 2013, Altran UK Limited                   --
--                                                                          --
-- gnat2why is  free  software;  you can redistribute  it and/or  modify it --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software  Foundation;  either version 3,  or (at your option)  any later --
-- version.  gnat2why is distributed  in the hope that  it will be  useful, --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public License  distributed with  gnat2why;  see file COPYING3. --
-- If not,  go to  http://www.gnu.org/licenses  for a complete  copy of the --
-- license.                                                                 --
--                                                                          --
------------------------------------------------------------------------------

--  This package provides mechanisms for emiting errors and warnings.

with Types;                 use Types;

with Flow_Types;            use Flow_Types;

package Flow_Error_Messages is

   procedure Error_Msg_Flow (Msg     : String;
                             N       : Node_Id;
                             Tag     : String := "";
                             Warning : Boolean := False);
   --  Output an error (or warning) message attached to the given
   --  node.

   procedure Error_Msg_Flow (Msg     : String;
                             N       : Types.Node_Id;
                             F1      : Flow_Id;
                             Tag     : String := "";
                             Warning : Boolean := False);
   --  Output a message attached to the given node with a substitution
   --  using F1. Use & or # as the substitution characters, which
   --  quote the flow id with or without double quotes respectively.

   procedure Error_Msg_Flow (Msg     : String;
                             N       : Node_Id;
                             F1      : Flow_Id;
                             F2      : Flow_Id;
                             Tag     : String := "";
                             Warning : Boolean := False);
   --  As above with two nodes to substitute.

end Flow_Error_Messages;
