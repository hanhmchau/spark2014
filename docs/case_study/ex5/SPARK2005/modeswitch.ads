package ModeSwitch
--# own in Inputs : Modes;
is
   type Modes is (off, cont, timed);

   procedure Read( Value : out Modes);
   --# global  in Inputs;
   --# derives Value from Inputs;
   --# post (Value = Inputs~); -- simplified postcondition valid for single reads
   --
   -- Reads the position of the mode switch.

end ModeSwitch;
