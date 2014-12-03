------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2WHY COMPONENTS                           --
--                                                                          --
--                                G R A P H                                 --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                  Copyright (C) 2013-2014, Altran UK Limited              --
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

with Ada.Containers.Doubly_Linked_Lists;

with System.Strings;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with GNAT.OS_Lib;    use GNAT.OS_Lib;

use type Ada.Containers.Count_Type;

package body Graph is

   ----------------------------------------------------------------------
   --  Local types
   ----------------------------------------------------------------------

   type Vertex_To_Vertex_T is array (Vertex_Id range <>) of Vertex_Id;

   ----------------------------------------------------------------------
   --  Local operations for local callers
   ----------------------------------------------------------------------

   ----------------------------------------------------------------------
   --  Basic operations
   ----------------------------------------------------------------------

   ---------------
   -- Is_Frozen --
   ---------------

   function Is_Frozen (G : T'Class) return Boolean is (G.Frozen);

   ------------
   -- Create --
   ------------

   function Create (Colour : Edge_Colours := Edge_Colours'First) return T is
   begin
      return (Vertices       => VL.Empty_Vector,
              Default_Colour => Colour,
              Frozen         => False,
              Clusters       => 0);
   end Create;

   function Create (G             : T'Class;
                    Copy_Clusters : Boolean := False)
                    return T
   is
      R : T := Create (G.Default_Colour);
   begin
      for V of G.Vertices loop
         R.Vertices.Append ((Key            => V.Key,
                             In_Neighbours  => VIS.Empty_Set,
                             Out_Neighbours => EAM.Empty_Map,
                             Cluster        => (if Copy_Clusters
                                                then V.Cluster
                                                else Null_Cluster)));
      end loop;

      R.Frozen   := True;
      if Copy_Clusters then
         R.Clusters := G.Clusters;
      end if;

      return R;
   end Create;

   ----------------------------------------------------------------------
   --  Vertex operations
   ----------------------------------------------------------------------

   ----------------
   -- Get_Vertex --
   ----------------

   function Get_Vertex (G : T'Class; V : Vertex_Key) return Vertex_Id is
   begin
      for J in Valid_Vertex_Id range 1 .. G.Vertices.Last_Index loop
         if Test_Key (G.Vertices (J).Key, V) then
            return J;
         end if;
      end loop;

      return Null_Vertex;
   end Get_Vertex;

   -------------
   -- Get_Key --
   -------------

   function Get_Key (G : T'Class; V : Vertex_Id) return Vertex_Key is
   begin
      return G.Vertices (V).Key;
   end Get_Key;

   ----------------
   -- Add_Vertex --
   ----------------

   procedure Add_Vertex
     (G  : in out T'Class;
      V  : Vertex_Key;
      Id : out Vertex_Id) is
   begin
      G.Vertices.Append ((Key            => V,
                          In_Neighbours  => VIS.Empty_Set,
                          Out_Neighbours => EAM.Empty_Map,
                          Cluster        => Null_Cluster));
      Id := G.Vertices.Last_Index;
   end Add_Vertex;

   procedure Add_Vertex
     (G  : in out T'Class;
      Id : out Vertex_Id) is
   begin
      G.Vertices.Append ((Key            => Null_Key,
                          In_Neighbours  => VIS.Empty_Set,
                          Out_Neighbours => EAM.Empty_Map,
                          Cluster        => Null_Cluster));
      Id := G.Vertices.Last_Index;
   end Add_Vertex;

   procedure Add_Vertex
     (G  : in out T'Class;
      V  : Vertex_Key) is
   begin
      G.Vertices.Append ((Key            => V,
                          In_Neighbours  => VIS.Empty_Set,
                          Out_Neighbours => EAM.Empty_Map,
                          Cluster        => Null_Cluster));
   end Add_Vertex;

   -----------------
   -- Vertex_Hash --
   -----------------

   function Vertex_Hash
     (Element : Vertex_Id) return Ada.Containers.Hash_Type is
   begin
      return Ada.Containers.Hash_Type (Element);
   end Vertex_Hash;

   ----------------------------------------------------------------------
   --  Edge operations
   ----------------------------------------------------------------------

   --------------------------
   --  In_Neighbour_Count  --
   --------------------------

   function In_Neighbour_Count
     (G : T'Class;
      V : Vertex_Id) return Natural is
   begin
      return Natural (G.Vertices (V).In_Neighbours.Length);
   end In_Neighbour_Count;

   ---------------------------
   --  Out_Neighbour_Count  --
   ---------------------------

   function Out_Neighbour_Count
     (G : T'Class;
      V : Vertex_Id) return Natural is
   begin
      return Natural (G.Vertices (V).Out_Neighbours.Length);
   end Out_Neighbour_Count;

   -----------------
   -- Edge_Exists --
   -----------------

   function Edge_Exists
     (G        : T'Class;
      V_1, V_2 : Vertex_Id) return Boolean is
   begin
      --  Sanity check the indices.
      pragma Assert
        (V_1 <= G.Vertices.Last_Index
         and V_2 <= G.Vertices.Last_Index);

      return G.Vertices (V_1).Out_Neighbours.Contains (V_2);
   end Edge_Exists;

   function Edge_Exists
     (G        : T'Class;
      V_1, V_2 : Vertex_Key) return Boolean is
   begin
      return Edge_Exists (G,
                          Get_Vertex (G, V_1),
                          Get_Vertex (G, V_2));
   end Edge_Exists;

   --------------
   -- Add_Edge --
   --------------

   procedure Add_Edge
     (G        : in out T'Class;
      V_1, V_2 : Vertex_Id;
      Colour   : Edge_Colours) is
   begin
      --  Sanity check the indices.
      pragma Assert
        (V_1 <= G.Vertices.Last_Index
         and V_2 <= G.Vertices.Last_Index);

      --  Do no work if we already have this edge.
      if G.Edge_Exists (V_1, V_2) then
         return;
      end if;

      --  Add to V_1's out neighbours and edge attribute list.
      G.Vertices (V_1).Out_Neighbours.Include
        (V_2, Edge_Attributes'(Marked => False,
                               Colour => Colour));

      --  Add to V_2's in neighbours.
      G.Vertices (V_2).In_Neighbours.Include (V_1);
   end Add_Edge;

   procedure Add_Edge
     (G        : in out T'Class;
      V_1, V_2 : Vertex_Key;
      Colour   : Edge_Colours) is
   begin
      G.Add_Edge (G.Get_Vertex (V_1), G.Get_Vertex (V_2), Colour);
   end Add_Edge;

   -----------------
   -- Remove_Edge --
   -----------------

   procedure Remove_Edge
     (G        : in out T'Class;
      V_1, V_2 : Vertex_Id) is
   begin
      --  Sanity check the indices.
      pragma Assert
        (V_1 <= G.Vertices.Last_Index
         and V_2 <= G.Vertices.Last_Index);

      if G.Edge_Exists (V_1, V_2) then
         --  Note the use of delete, so we better check if there is an
         --  edge we can delete first.
         G.Vertices (V_1).Out_Neighbours.Delete (V_2);
         G.Vertices (V_2).In_Neighbours.Delete (V_1);
      end if;
   end Remove_Edge;

   ---------------
   -- Mark_Edge --
   ---------------

   procedure Mark_Edge
     (G        : in out T'Class;
      V_1, V_2 : Vertex_Id) is
   begin
      --  Sanity check the indices.
      pragma Assert
        (V_1 <= G.Vertices.Last_Index
         and V_2 <= G.Vertices.Last_Index);

      --  Mark the edge
      G.Vertices (V_1).Out_Neighbours (V_2).Marked := True;
   end Mark_Edge;

   ------------------
   -- Clear_Vertex --
   ------------------

   procedure Clear_Vertex
     (G : in out T'Class;
      V : Vertex_Id) is
   begin
      --  Sanity check the index.
      pragma Assert (V <= G.Vertices.Last_Index);

      for V_I of G.Vertices (V).In_Neighbours loop
         G.Vertices (V_I).Out_Neighbours.Delete (V);
      end loop;
      G.Vertices (V).In_Neighbours := Empty_Set;

      for C in G.Vertices (V).Out_Neighbours.Iterate loop
         declare
            V_O : Vertex_Id renames Key (C);
         begin
            G.Vertices (V_O).In_Neighbours.Delete (V);
         end;
      end loop;
      G.Vertices (V).Out_Neighbours := Empty_Map;
   end Clear_Vertex;

   ------------------
   --  Copy_Edges  --
   ------------------

   procedure Copy_Edges
     (G : in out T'Class;
      O : T'Class) is
   begin
      --  Sanity check the length of the two graphs.
      pragma Assert (G.Vertices.Length = O.Vertices.Length);

      for V_A in Valid_Vertex_Id range 1 .. O.Vertices.Last_Index loop
         for C in O.Vertices (V_A).Out_Neighbours.Iterate loop
            declare
               V_B : constant Valid_Vertex_Id := Key (C);
               Atr : constant Edge_Attributes := Element (C);
            begin
               G.Add_Edge (V_A, V_B, Atr.Colour);
               if Atr.Marked then
                  G.Mark_Edge (V_A, V_B);
               end if;
            end;
         end loop;
      end loop;
   end Copy_Edges;

   ------------
   -- Parent --
   ------------

   function Parent
     (G : T'Class;
      V : Vertex_Id)
      return Vertex_Id
   is
   begin
      for P of G.Vertices (V).In_Neighbours loop
         return P;
      end loop;
      return Null_Vertex;
   end Parent;

   -----------
   -- Child --
   -----------

   function Child
     (G : T'Class;
      V : Vertex_Id)
      return Vertex_Id
   is
   begin
      for C in G.Vertices (V).Out_Neighbours.Iterate loop
         return Key (C);
      end loop;
      return Null_Vertex;
   end Child;

   ----------------------------------------------------------------------
   --  Clusters
   ----------------------------------------------------------------------

   -----------------
   -- New_Cluster --
   -----------------

   procedure New_Cluster (G : in out T'Class;
                          C :    out Cluster_Id)
   is
   begin
      G.Clusters := G.Clusters + 1;
      C          := G.Clusters;
   end New_Cluster;

   -----------------
   -- Set_Cluster --
   -----------------

   procedure Set_Cluster (G : in out T'Class;
                          V : Vertex_Id;
                          C : Cluster_Id)
   is
   begin
      pragma Assert (C <= G.Clusters);
      G.Vertices (V).Cluster := C;
   end Set_Cluster;

   -----------------
   -- Get_Cluster --
   -----------------

   function Get_Cluster (G : T'Class;
                         V : Vertex_Id)
                         return Cluster_Id
   is
   begin
      return G.Vertices (V).Cluster;
   end Get_Cluster;

   ----------------------------------------------------------------------
   --  Iterators
   ----------------------------------------------------------------------

   type Iterator is new List_Iterators.Forward_Iterator with record
      The_Collection : Vertex_Collection_T;
   end record;

   overriding function First
     (Object : Iterator) return Cursor;
   overriding function Next
     (Object   : Iterator;
      Position : Cursor) return Cursor;

   -----------
   -- First --
   -----------

   function First (Object : Iterator) return Cursor is
      G : access constant T renames Object.The_Collection.The_Graph;
   begin
      case Object.The_Collection.The_Type is
         when In_Neighbours =>
            return Cursor'(Collection_Type   => In_Neighbours,
                           The_Collection    => Object.The_Collection,
                           VIS_Native_Cursor => G.Vertices
                             (Object.The_Collection.Id).In_Neighbours.First);
         when Out_Neighbours =>
            return Cursor'(Collection_Type   => Out_Neighbours,
                           The_Collection    => Object.The_Collection,
                           EAM_Native_Cursor => G.Vertices
                             (Object.The_Collection.Id).Out_Neighbours.First);
         when All_Vertices =>
            return Cursor'(Collection_Type   => All_Vertices,
                           The_Collection    => Object.The_Collection,
                           VL_Native_Cursor  => G.Vertices.First);
      end case;
   end First;

   ----------
   -- Next --
   ----------

   function Next (Object : Iterator; Position : Cursor) return Cursor is
   begin
      case Object.The_Collection.The_Type is
         when In_Neighbours =>
            return Cursor'(Collection_Type   => In_Neighbours,
                           The_Collection    => Object.The_Collection,
                           VIS_Native_Cursor => Next
                             (Position.VIS_Native_Cursor));
         when Out_Neighbours =>
            return Cursor'(Collection_Type   => Out_Neighbours,
                           The_Collection    => Object.The_Collection,
                           EAM_Native_Cursor => Next
                             (Position.EAM_Native_Cursor));
         when All_Vertices =>
            return Cursor'(Collection_Type   => All_Vertices,
                           The_Collection    => Object.The_Collection,
                           VL_Native_Cursor  => Next
                             (Position.VL_Native_Cursor));
      end case;
   end Next;

   --------------------
   -- Get_Collection --
   --------------------

   function Get_Collection
     (G        : T'Class;
      V        : Vertex_Id;
      The_Type : Vertex_Based_Collection) return Vertex_Collection_T'Class is
   begin
      return Vertex_Collection_T'(The_Type  => The_Type,
                                  The_Graph => G'Unrestricted_Access,
                                  Id        => V);
   end Get_Collection;

   function Get_Collection
     (G        : T'Class;
      The_Type : Graph_Based_Collection) return Vertex_Collection_T'Class is
   begin
      return Vertex_Collection_T'(The_Type  => The_Type,
                                  The_Graph => G'Unrestricted_Access,
                                  Id        => Null_Vertex);
   end Get_Collection;

   -----------------
   -- Has_Element --
   -----------------

   function Has_Element (Pos : Cursor) return Boolean is
   begin
      case Pos.Collection_Type is
         when In_Neighbours =>
            return Has_Element (Pos.VIS_Native_Cursor);
         when Out_Neighbours =>
            return Has_Element (Pos.EAM_Native_Cursor);
         when All_Vertices =>
            return Has_Element (Pos.VL_Native_Cursor);
      end case;
   end Has_Element;

   -------------
   -- Iterate --
   -------------

   function Iterate
     (Container : Vertex_Collection_T)
      return List_Iterators.Forward_Iterator'Class is
   begin
      return Iterator'(The_Collection => Container);
   end Iterate;

   ---------------------------
   -- Get_Current_Vertex_Id --
   ---------------------------

   function Get_Current_Vertex_Id
     (Container : Vertex_Collection_T;
      Pos       : Cursor) return Vertex_Id
   is
      pragma Unreferenced (Container);
   begin
      case Pos.Collection_Type is
         when In_Neighbours =>
            return Element (Pos.VIS_Native_Cursor);
         when Out_Neighbours =>
            return Key (Pos.EAM_Native_Cursor);
         when All_Vertices =>
            return To_Index (Pos.VL_Native_Cursor);
      end case;
   end Get_Current_Vertex_Id;

   ----------------------------------------------------------------------
   --  Complex queries
   ----------------------------------------------------------------------

   -------------------------------
   --  Non_Trivial_Path_Exists  --
   -------------------------------

   function Non_Trivial_Path_Exists
     (G        : T'Class;
      A        : Vertex_Id;
      B        : Vertex_Id;
      Reversed : Boolean := False)
      return Boolean
   is
      Path_Exists : Boolean := False;

      procedure Are_We_There_Yet
         (V  : Vertex_Id;
          TV : out Simple_Traversal_Instruction);
      --  Repeatedly checks if we've arrived at out destination.

      procedure Are_We_There_Yet
         (V  : Vertex_Id;
          TV : out Simple_Traversal_Instruction) is
      begin
         if V = B then
            Path_Exists := True;

            TV := Abort_Traversal;
         else
            TV := Continue;
         end if;
      end Are_We_There_Yet;

   begin
      G.DFS (Start         => A,
             Include_Start => False,
             Visitor       => Are_We_There_Yet'Access,
             Reversed      => Reversed);
      return Path_Exists;
   end Non_Trivial_Path_Exists;

   function Non_Trivial_Path_Exists
     (G        : T'Class;
      A        : Vertex_Id;
      F        : access function (V : Vertex_Id) return Boolean;
      Reversed : Boolean := False)
      return Boolean
   is
      Path_Exists : Boolean := False;

      procedure Are_We_There_Yet
         (V  : Vertex_Id;
          TV : out Simple_Traversal_Instruction);
      --  Repeatedly checks if we've arrived at out destination.

      procedure Are_We_There_Yet
        (V  : Vertex_Id;
         TV : out Simple_Traversal_Instruction) is
      begin
         if F (V) then
            Path_Exists := True;

            TV := Abort_Traversal;
         else
            TV := Continue;
         end if;
      end Are_We_There_Yet;
   begin
      G.DFS (Start         => A,
             Include_Start => False,
             Visitor       => Are_We_There_Yet'Access,
             Reversed      => Reversed);
      return Path_Exists;
   end Non_Trivial_Path_Exists;

   ----------------------------------------------------------------------
   --  Visitors
   ----------------------------------------------------------------------

   ---------
   -- DFS --
   ---------

   procedure DFS
     (G             : T'Class;
      Start         : Vertex_Id;
      Include_Start : Boolean;
      Visitor       : access procedure
        (V  : Vertex_Id;
         TV : out Simple_Traversal_Instruction);
      Reversed      : Boolean := False)
   is
      type Bit_Field is array
        (Valid_Vertex_Id range 1 .. G.Vertices.Last_Index) of Boolean;

      Will_Visit : Bit_Field         := Bit_Field'(others => False);
      Stack      : Vertex_Index_List := VIL.Empty_Vector;
      TV         : Simple_Traversal_Instruction;

      procedure Schedule_Vertex (V : Valid_Vertex_Id);
      --  Add V to the stack of vertices to visit and flag it as "to
      --  be visited".

      procedure Schedule_Children (V : Valid_Vertex_Id);
      --  Add all out-neighbours of V (but not V itself) to the stack
      --  of vertices to visit and flag them as "to be visited".

      ---------------------
      -- Schedule_Vertex --
      ---------------------

      procedure Schedule_Vertex (V : Valid_Vertex_Id) is
      begin
         Stack.Append (V);
         Will_Visit (V) := True;
      end Schedule_Vertex;

      -----------------------
      -- Schedule_Children --
      -----------------------

      procedure Schedule_Children (V : Valid_Vertex_Id) is
      begin
         if Reversed then
            --  If we're in reversed mode we just go through the in
            --  neighbours instead of the out neighbours. No other
            --  difference.
            for Out_Node of G.Vertices (V).In_Neighbours loop
               if not Will_Visit (Out_Node) then
                  Schedule_Vertex (Out_Node);
               end if;
            end loop;
         else
            for C in G.Vertices (V).Out_Neighbours.Iterate loop
               declare
                  Out_Node : constant Valid_Vertex_Id := Key (C);
               begin
                  if not Will_Visit (Out_Node) then
                     Schedule_Vertex (Out_Node);
                  end if;
               end;
            end loop;
         end if;
      end Schedule_Children;

   begin
      --  Seed the stack with either the start node or all its
      --  neighbours.

      if Include_Start then
         Schedule_Vertex (Start);
      else
         Schedule_Children (Start);
      end if;

      while Stack.Length > 0 loop
         declare
            Current_Node : constant Valid_Vertex_Id := Stack.Last_Element;
         begin
            --  Pop from the stack
            Stack.Delete_Last;

            --  Visit the node
            Visitor (Current_Node, TV);

            case TV is
               when Continue =>
                  --  Visit all children
                  Schedule_Children (Current_Node);
               when Skip_Children =>
                  null;
               when Abort_Traversal =>
                  return;
            end case;
         end;
      end loop;
   end DFS;

   ---------
   -- BFS --
   ---------

   procedure BFS
     (G             : T'Class;
      Start         : Vertex_Id;
      Include_Start : Boolean;
      Visitor       : access procedure
        (V      : Vertex_Id;
         Origin : Vertex_Id;
         Depth  : Natural;
         T_Ins  : out Simple_Traversal_Instruction);
      Reversed      : Boolean := False)
   is
      type Index_And_Depth is record
         Origin : Valid_Vertex_Id;
         Index  : Valid_Vertex_Id;
         Depth  : Natural;
      end record;

      package Queues is new Ada.Containers.Doubly_Linked_Lists
        (Element_Type => Index_And_Depth);

      type Bit_Field is array
        (Valid_Vertex_Id range 1 .. G.Vertices.Last_Index) of Boolean;

      Q      : Queues.List;
      Marked : Bit_Field := Bit_Field'(others => False);

      procedure Enqueue (A : Valid_Vertex_Id;
                         B : Valid_Vertex_Id;
                         D : Natural);
      --  Add a single A -> B link to the queue.

      procedure Enqueue_Children (V : Valid_Vertex_Id;
                                  D : Natural);
      --  Add all children of V to the queue.

      procedure Enqueue (A : Valid_Vertex_Id;
                         B : Valid_Vertex_Id;
                         D : Natural) is
      begin
         Q.Append (Index_And_Depth'(Origin => A,
                                    Index  => B,
                                    Depth  => D));
         Marked (B) := True;
      end Enqueue;

      procedure Enqueue_Children (V : Valid_Vertex_Id;
                                  D : Natural) is
      begin
         if Reversed then
            for W of G.Vertices (V).In_Neighbours loop
               if not Marked (W) then
                  Enqueue (A => V,
                           B => W,
                           D => D + 1);
               end if;
            end loop;
         else
            for C in G.Vertices (V).Out_Neighbours.Iterate loop
               declare
                  W : constant Valid_Vertex_Id := Key (C);
               begin
                  if not Marked (W) then
                     Enqueue (A => V,
                              B => W,
                              D => D + 1);
                  end if;
               end;
            end loop;
         end if;
      end Enqueue_Children;

   begin

      if Include_Start then
         Enqueue (A => Start,
                  B => Start,
                  D => 0);
      else
         Enqueue_Children (Start, 0);
      end if;

      while not Q.Is_Empty loop
         declare
            Origin : constant Valid_Vertex_Id := Q.First_Element.Origin;
            V      : constant Valid_Vertex_Id := Q.First_Element.Index;
            D      : constant Natural         := Q.First_Element.Depth;
            T_Ins  : Simple_Traversal_Instruction;
         begin
            Q.Delete_First;

            Visitor (V, Origin, D, T_Ins);

            case T_Ins is
               when Continue =>
                  Enqueue_Children (V, D);
               when Skip_Children =>
                  null;
               when Abort_Traversal =>
                  exit;
            end case;
         end;
      end loop;

   end BFS;

   -------------------
   -- Shortest_Path --
   -------------------

   procedure Shortest_Path
     (G             : T'Class;
      Start         : Vertex_Id;
      Allow_Trivial : Boolean;
      Search        : access procedure
        (V           : Vertex_Id;
         Instruction : out Traversal_Instruction);
      Step          : access procedure (V : Vertex_Id);
      Reversed      : Boolean := False)
   is
      package Vertex_Maps is new Ada.Containers.Hashed_Maps
        (Key_Type        => Valid_Vertex_Id,
         Element_Type    => Valid_Vertex_Id,
         Hash            => Vertex_Hash,
         Equivalent_Keys => "=",
         "="             => "=");

      Tree  : Vertex_Maps.Map   := Vertex_Maps.Empty_Map;
      Dest  : Vertex_Id         := Null_Vertex;
      Route : Vertex_Index_List := VIL.Empty_Vector;

      procedure Make_Tree (V      : Vertex_Id;
                           Origin : Vertex_Id;
                           Depth  : Natural;
                           T_Ins  : out Simple_Traversal_Instruction);
      --  Internal visitor for the BFS. This will construct a tree
      --  which we can use to find our way home.

      procedure Make_Tree (V      : Vertex_Id;
                           Origin : Vertex_Id;
                           Depth  : Natural;
                           T_Ins  : out Simple_Traversal_Instruction)
      is
         pragma Unreferenced (Depth);
         Tmp : Traversal_Instruction;
      begin
         Search (V, Tmp);
         if Tmp = Found_Destination then
            T_Ins := Abort_Traversal;
            Dest  := V;
         else
            T_Ins := Tmp;
         end if;

         Tree.Include (V, Origin);
      end Make_Tree;

   begin

      BFS (G             => G,
           Start         => Start,
           Include_Start => Allow_Trivial,
           Visitor       => Make_Tree'Access,
           Reversed      => Reversed);

      if Dest /= Null_Vertex then
         declare
            P : Valid_Vertex_Id := Dest;
         begin
            while P /= Start loop
               Route.Append (P);
               P := Tree (P);
            end loop;
            Route.Append (P);
         end;

         for V of reverse Route loop
            Step (V);
         end loop;
      end if;

   end Shortest_Path;

   ----------------------------------------------------------------------
   --  Graph-wide operations
   ----------------------------------------------------------------------

   ------------
   -- Invert --
   ------------

   function Invert (G : T'Class) return T is
      R : T;
   begin
      --  Start with an empty graph, with the same vertices.
      R := Create (G);

      --  Add reversed edges.
      for V_1 in Valid_Vertex_Id range 1 .. G.Vertices.Last_Index loop
         for C in G.Vertices (V_1).Out_Neighbours.Iterate loop
            declare
               V_2 : Valid_Vertex_Id renames Key (C);
               Atr : Edge_Attributes renames Element (C);
            begin
               R.Vertices (V_2).Out_Neighbours.Include (V_1, Atr);
               R.Vertices (V_1).In_Neighbours.Include (V_2);
            end;
         end loop;
      end loop;

      return R;
   end Invert;

   -----------------------------
   -- Dominator_Tree_Internal --
   -----------------------------

   function Dominator_Tree_Internal
     (G : T'Class;
      R : Vertex_Id) return Vertex_To_Vertex_T;
   --  Compute the dominator tree, but return a vertex-to-vertex map,
   --  instead of a graph representing a tree. The Dominator_Tree
   --  function calls this, and so does Dominance_Frontier as its
   --  easier to work with the array representation.

   function Dominator_Tree_Internal
     (G : T'Class;
      R : Vertex_Id) return Vertex_To_Vertex_T
   is
      subtype V_To_V is Vertex_To_Vertex_T (0 .. G.Vertices.Last_Index);
      type V_To_VIL is array
        (Valid_Vertex_Id range 1 .. G.Vertices.Last_Index)
        of Vertex_Index_List;

      Parent, Ancestor, Child, Vertex : V_To_V;
      Label, Semi, Size               : V_To_V   := (others => 0);

      Bucket : V_To_VIL := (others => VIL.Empty_Vector);
      Dom    : V_To_V   := (others => 0);

      N : Vertex_Id := 0;

      procedure DT_DFS (V : Valid_Vertex_Id);
      --  See paper by Tarjan and Lengauer.

      procedure Compress (V : Valid_Vertex_Id);
      --  See paper by Tarjan and Lengauer.

      function Eval (V : Valid_Vertex_Id) return Vertex_Id;
      --  See paper by Tarjan and Lengauer.

      procedure Link (V, W : Valid_Vertex_Id);
      --  See paper by Tarjan and Lengauer.

      ------------
      -- DT_DFS --
      ------------

      procedure DT_DFS (V : Valid_Vertex_Id) is
      begin
         N         := N + 1;
         Label (V) := V;

         Semi (V)     := N;
         Vertex (N)   := Label (V);
         Child (V)    := 0;
         Ancestor (V) := 0;
         Size (V)     := 1;

         for C in G.Vertices (V).Out_Neighbours.Iterate loop
            declare
               W : Valid_Vertex_Id renames Key (C);
            begin
               if Semi (W) = 0 then
                  Parent (W) := V;
                  DT_DFS (W);
               end if;
               --  In_Neighbours is our version of Pred
            end;
         end loop;
      end DT_DFS;

      --------------
      -- Compress --
      --------------

      procedure Compress (V : Valid_Vertex_Id) is
      begin
         if Ancestor (Ancestor (V)) /= 0 then
            Compress (Ancestor (V));
            if Semi (Label (Ancestor (V))) < Semi (Label (V)) then
               Label (V) := Label (Ancestor (V));
            end if;
            Ancestor (V) := Ancestor (Ancestor (V));
         end if;
      end Compress;

      ----------
      -- Eval --
      ----------

      function Eval (V : Valid_Vertex_Id) return Vertex_Id is
      begin
         if Ancestor (V) = 0 then
            return Label (V);
         else
            Compress (V);
            if Semi (Label (Ancestor (V))) >= Semi (Label (V)) then
               return Label (V);
            else
               return Label (Ancestor (V));
            end if;
         end if;
      end Eval;

      ----------
      -- Link --
      ----------

      procedure Link (V, W : Valid_Vertex_Id) is
         S : Vertex_Id := W;

         procedure Swap (A, B : in out Vertex_Id);
         --  Swap vertices A and B.

         ----------
         -- Swap --
         ----------

         procedure Swap (A, B : in out Vertex_Id) is
            Tmp : constant Vertex_Id := A;
         begin
            A := B;
            B := Tmp;
         end Swap;

      begin
         while Semi (Label (W)) < Semi (Label (Child (S))) loop
            if Size (S) + Size (Child (Child (S))) >= 2 * Size (Child (S)) then
               Ancestor (Child (S)) := S;
               Child (S)            := Child (Child (S));
            else
               Size (Child (S)) := Size (S);
               Ancestor (S)     := Child (S);
               S                := Child (S);
            end if;
         end loop;

         Label (S) := Label (W);
         Size (V)  := Size (V) + Size (W);

         if Size (V) < 2 * Size (W) then
            Swap (S, Child (V));
         end if;

         while S /= 0 loop
            Ancestor (S) := V;
            S            := Child (S);
         end loop;
      end Link;

   begin
      --  Step 1

      --  Pred is In_Neighbours and is already set.
      --  Bucket is initialized to be VIL.Empty_Vector, see above.
      --  Semi is already set to 0.

      DT_DFS (R);
      --  Size, Label and Semi are already set to 0, see above.

      for J in reverse Valid_Vertex_Id range 2 .. N loop
         declare
            W : constant Valid_Vertex_Id := Vertex (J);
         begin
            --  Step 2
            for V of G.Vertices (W).In_Neighbours loop
               declare
                  U : constant Vertex_Id := Eval (V);
               begin
                  if Semi (U) < Semi (W) then
                     Semi (W) := Semi (U);
                  end if;
               end;
            end loop;
            Bucket (Vertex (Semi (W))).Append (W);
            Link (Parent (W), W);

            --  Step 3
            while Bucket (Parent (W)).Length > 0 loop
               declare
                  V : constant Valid_Vertex_Id
                    := Bucket (Parent (W)).Last_Element;
                  U : constant Valid_Vertex_Id
                    := Eval (V);
               begin
                  Bucket (Parent (W)).Delete_Last;
                  if Semi (U) < Semi (V) then
                     Dom (V) := U;
                  else
                     Dom (V) := Parent (W);
                  end if;
               end;
            end loop;
         end;
      end loop;

      --  Step 4
      for J in Valid_Vertex_Id range 2 .. N loop
         declare
            W : constant Valid_Vertex_Id := Vertex (J);
         begin
            if Dom (W) /= Vertex (Semi (W)) then
               Dom (W) := Dom (Dom (W));
            end if;
         end;
      end loop;

      Dom (R) := 0;

      return Dom;
   end Dominator_Tree_Internal;

   --------------------
   -- Dominator_Tree --
   --------------------

   function Dominator_Tree
     (G : T'Class;
      R : Vertex_Id) return T
   is
      Dom : constant Vertex_To_Vertex_T := Dominator_Tree_Internal (G, R);
      DT  : T;
   begin
      DT := Create (G);

      for V in Valid_Vertex_Id range 1 .. Dom'Last loop
         if Dom (V) in Valid_Vertex_Id then
            DT.Add_Edge (Dom (V), V, DT.Default_Colour);
         end if;
      end loop;

      return DT;
   end Dominator_Tree;

   ------------------------
   -- Dominance_Frontier --
   ------------------------

   function Dominance_Frontier
     (G : T'Class;
      R : Vertex_Id) return T
   is
      Dom : constant Vertex_To_Vertex_T := Dominator_Tree_Internal (G, R);
      DF  : T := Create (G);
   begin
      for B in Valid_Vertex_Id range 1 .. G.Vertices.Last_Index loop
         if G.Vertices (B).In_Neighbours.Length >= 2 then
            for P of G.Vertices (B).In_Neighbours loop
               if Dom (P) in Valid_Vertex_Id then
                  declare
                     Runner : Valid_Vertex_Id := P;
                  begin
                     while Runner /= Dom (B) loop
                        DF.Add_Edge (B, Runner, DF.Default_Colour);
                        Runner := Dom (Runner);
                     end loop;
                  end;
               end if;
            end loop;
         end if;
      end loop;

      return DF;
   end Dominance_Frontier;

   -----------
   -- Close --
   -----------

   procedure Close
     (G       : in out T'Class;
      Visitor : access procedure (A, B : Vertex_Id))
   is
      type Component is new Natural;

      type Bit_Field is array
        (Valid_Vertex_Id range 1 .. G.Vertices.Last_Index) of Boolean;

      type V_To_V is array
        (Vertex_Id range 0 .. G.Vertices.Last_Index) of Vertex_Id;

      type V_To_VIS is array
        (Valid_Vertex_Id range 1 .. G.Vertices.Last_Index) of Vertex_Index_Set;

      type V_To_Comp is array
        (Valid_Vertex_Id range 1 .. G.Vertices.Last_Index) of Component;

      Visited   : Bit_Field         := Bit_Field'(others => False);
      Stack     : Vertex_Index_List := VIL.Empty_Vector;
      Root      : V_To_V            := V_To_V'(others => 0);
      Comp      : V_To_Comp         := V_To_Comp'(others => 0);
      Succ      : V_To_V            := V_To_V'(others => 0);
      Sets      : V_To_VIS          := V_To_VIS'(others => VIS.Empty_Set);

      Current_Component : Component := 0;

      procedure SIMPLE_TC (V : Valid_Vertex_Id);
      --  See Nuutila's PhD thesis.

      ---------------
      -- SIMPLE_TC --
      ---------------

      procedure SIMPLE_TC (V : Valid_Vertex_Id) is
      begin
         Visited (V) := True;

         Root (V) := V;

         Stack.Append (V);

         Succ (V) := V;
         for C in G.Vertices (V).Out_Neighbours.Iterate loop
            declare
               W : Valid_Vertex_Id renames Key (C);
            begin
               Sets (Succ (V)).Include (W);
            end;
         end loop;

         for C in G.Vertices (V).Out_Neighbours.Iterate loop
            declare
               W : Valid_Vertex_Id renames Key (C);
            begin
               if not Visited (W) then
                  SIMPLE_TC (W);
               end if;
               if Comp (W) = 0 then
                  Root (V) := Vertex_Id'Min (Root (V), Root (W));
               end if;
               Sets (Succ (V)).Union (Sets (Succ (W)));
            end;
         end loop;

         if Root (V) = V then
            Current_Component := Current_Component + 1;
            loop
               declare
                  W : constant Valid_Vertex_Id := Stack.Last_Element;
               begin
                  Stack.Delete_Last;

                  Comp (W) := Current_Component;
                  Succ (W) := Succ (V); --  Pointer copy

                  exit when W = V;
               end;
            end loop;
         end if;
      end SIMPLE_TC;

   begin
      for V in Valid_Vertex_Id range 1 .. G.Vertices.Last_Index loop
         if not Visited (V) then
            SIMPLE_TC (V);
         end if;
      end loop;

      for V in Valid_Vertex_Id range 1 .. G.Vertices.Last_Index loop
         for W of Sets (Succ (V)) loop
            if not G.Edge_Exists (V, W) then
               if Visitor /= null then
                  Visitor (V, W);
               end if;
               G.Add_Edge (V, W, G.Default_Colour);
            end if;
         end loop;
      end loop;
   end Close;

   procedure Close (G : in out T'Class) is
   begin
      Close (G, null);
   end Close;

   ----------------------------------------------------------------------
   --  IO
   ----------------------------------------------------------------------

   --------------------
   -- Write_Dot_File --
   --------------------

   procedure Write_Dot_File
     (G         : T'Class;
      Filename  : String;
      Node_Info : access function (G : T'Class;
                                   V : Vertex_Id)
                                   return Node_Display_Info;
      Edge_Info : access function (G      : T'Class;
                                   A      : Vertex_Id;
                                   B      : Vertex_Id;
                                   Marked : Boolean;
                                   Colour : Edge_Colours)
                                   return Edge_Display_Info)
   is
      function Escape (S : Unbounded_String) return String;
      --  Convert the unbounded string to a string and escape " to \"

      function Escape (S : Unbounded_String) return String
      is
         R : Unbounded_String := Null_Unbounded_String;
      begin
         for P in Positive range 1 .. Length (S) loop
            declare
               C : constant Character := Element (S, P);
            begin
               case C is
                  when '"' =>
                     Append (R, "\");
                     Append (R, C);
                  when others =>
                     Append (R, C);
               end case;
            end;
         end loop;
         return To_String (R);
      end Escape;

      FD : File_Type;
   begin
      Create (FD, Out_File, Filename & ".dot");

      Put (FD, "// ");
      Put_Line (FD, Filename);

      Put_Line (FD, "digraph G {");
      Put_Line (FD, "   graph [splines=True];");

      for C in Cluster_Id range 0 .. G.Clusters loop
         if C > 0 then
            Put (FD, "subgraph cluster");
            Put (File  => FD,
                 Item  => Integer (C),
                 Width => 0,
                 Base  => 10);
            Put_Line (FD, " {");
            Put_Line (FD, "  style=filled;");
            Put_Line (FD, "  color=lightgrey;");
            Put_Line (FD, "  node [style=filled,color=white];");
         end if;
         for J in Valid_Vertex_Id range 1 .. G.Vertices.Last_Index loop
            declare
               Info : constant Node_Display_Info := Node_Info (G, J);
            begin
               if Info.Show and then G.Vertices (J).Cluster = C then
                  Put (FD, "   ");
                  Put (FD, Valid_Vertex_Id'Image (J));
                  Put (FD, " [label=""");
                  Put (FD, Escape (Info.Label));
                  Put (FD, """");
                  case Info.Shape is
                     when Shape_Oval =>
                        null;
                     when Shape_Box =>
                        Put (FD, ",shape=""box""");
                     when Shape_Diamond =>
                        Put (FD, ",shape=""diamond""");
                     when Shape_None =>
                        Put (FD, ",shape=""plaintext""");
                  end case;
                  if Info.Colour /= Null_Unbounded_String then
                     Put (FD, ",fontcolor="""
                            & To_String (Info.Colour)
                            & """");
                  end if;
                  Put (FD, "];");
                  New_Line (FD);
               end if;
            end;
         end loop;
         if C > 0 then
            Put_Line (FD, "}");
         end if;
         New_Line (FD);
      end loop;

      for V_1 in Valid_Vertex_Id range 1 .. G.Vertices.Last_Index loop
         for C in G.Vertices (V_1).Out_Neighbours.Iterate loop
            declare
               V_2  : Valid_Vertex_Id renames Key (C);
               Atr  : Edge_Attributes renames Element (C);
               Info : constant Edge_Display_Info :=
                 Edge_Info (G, V_1, V_2, Atr.Marked, Atr.Colour);
            begin
               if Info.Show then
                  Put (FD, "   ");
                  Put (FD, Valid_Vertex_Id'Image (V_1));
                  Put (FD, " -> ");
                  Put (FD, Valid_Vertex_Id'Image (V_2));
                  Put (FD, " [");
                  case Info.Shape is
                     when Edge_Normal =>
                        Put (FD, "arrowType=""normal""");
                  end case;
                  if Info.Colour /= Null_Unbounded_String then
                     Put (FD, ",color=""" & To_String (Info.Colour) & """");
                  end if;
                  if Info.Label /=  Null_Unbounded_String then
                     Put (FD, ",label=""" & Escape (Info.Label) & """");
                  end if;
                  Put (FD, "]");
                  Put (FD, ";");
                  New_Line (FD);
               end if;
            end;
         end loop;
      end loop;

      Put_Line (FD, "}");

      Close (FD);
   end Write_Dot_File;

   --------------------
   -- Write_Pdf_File --
   --------------------

   procedure Write_Pdf_File
     (G         : T'Class;
      Filename  : String;
      Node_Info : access function (G : T'Class;
                                   V : Vertex_Id)
                                   return Node_Display_Info;
      Edge_Info : access function (G      : T'Class;
                                   A      : Vertex_Id;
                                   B      : Vertex_Id;
                                   Marked : Boolean;
                                   Colour : Edge_Colours)
                                   return Edge_Display_Info)
   is
   begin
      Write_Dot_File (G, Filename, Node_Info, Edge_Info);

      --  If we have a vast number of nodes, we don't call dot since it
      --  will simply take too much time.
      if G.Vertices.Length > 250 then
         return;
      end if;

      declare
         Success     : Boolean;
         Return_Code : Integer;

         Exec : System.Strings.String_Access :=
           Locate_Exec_On_Path ("dot");
         Args : System.Strings.String_List_Access :=
           Argument_String_To_List ("-Tpdf " & Filename & ".dot");

         pragma Unreferenced (Success, Return_Code);
      begin
         --  If "dot" not found on PATH, then do nothing
         if Exec /= null then
            Spawn (Program_Name => Exec.all,
                   Args         => Args.all,
                   Output_File  => Filename & ".pdf",
                   Success      => Success,
                   Return_Code  => Return_Code,
                   Err_To_Out   => False);

            System.Strings.Free (Exec);
         end if;
         System.Strings.Free (Args);
      end;
   end Write_Pdf_File;

   ----------------------------------------------------------------------
   --  Debug
   ----------------------------------------------------------------------

   -----------------------
   -- Vertex_To_Natural --
   -----------------------

   function Vertex_To_Natural (G : T'Class; V : Vertex_Id) return Natural is
      pragma Unreferenced (G);
   begin
      return Natural (V);
   end Vertex_To_Natural;

   ------------------------
   -- Cluster_To_Natural --
   ------------------------

   function Cluster_To_Natural (G : T'Class; C : Cluster_Id) return Natural is
      pragma Unreferenced (G);
   begin
      return Natural (C);
   end Cluster_To_Natural;

end Graph;
