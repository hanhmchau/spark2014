package Flight_Manager is

   type Engine_Values is record
      X_Speed, Y_Speed : Integer;
   end record;

   function Set_Engine_Speed
     (Position_X, Position_Y : Integer; Target_X, Target_Y : Integer)
      return Engine_Values
   with
     Post => ((Position_X + Set_Engine_Speed'Result.X_Speed) - Target_X) <
     (Position_X + Set_Engine_Speed'Result.X_Speed)
     and ((Position_Y + Set_Engine_Speed'Result.Y_Speed) - Target_Y) <
     (Position_Y + Set_Engine_Speed'Result.Y_Speed);

end Flight_Manager;
