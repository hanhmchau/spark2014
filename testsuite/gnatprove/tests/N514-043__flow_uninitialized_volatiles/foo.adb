with System;

package body Foo
is

   procedure Test_01 (X : out Integer)
   is
      Result : Integer;
      for Result'Address use System'To_Address (16#dead_beef#);
   begin
      X := Result;
      pragma Annotate (GNATprove, False_Positive, "not initialized",
                       "This location is magically initialized.");
   end Test_01;

end Foo;
