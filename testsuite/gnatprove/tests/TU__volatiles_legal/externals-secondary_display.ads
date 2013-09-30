private package Externals.Secondary_Display
   with Abstract_State => (State with External => Async_Readers,
                                      Part_Of  => Externals.Displays)
is
   procedure Display (Text: in String)
      with Global => (Output => State),
           Depends => (State => Text);
end Externals.Secondary_Display;