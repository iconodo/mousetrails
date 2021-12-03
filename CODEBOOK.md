# mousetrails repo CODEBOOK
Joystick mouse trails in Cerebral Palsy User

     
## I.- `THE DATA FILES STRUCTURE` 

   * `deltaX    -- int` Mouse movements magnitudes in the X axis

   * `deltaY    -- int` Mouse movements magnitudes in the Y axis

   * `WHEN      -- num` Chuck's MiniAudicle virtual machine time progress

   * `SYLLABLE  -- chr` The clickable button's label in each row of the tables

   * `XofButton -- int` X coordinate of the upper left corner of the 100x100 buttons

   * `YofButton -- int` Y coordinate of the upper left corner of the 100x100 buttons

   * `XofTrace  -- int` X coordinate of the cursor position at WHEN seconds

   * `YofTrace  -- int` Y coordinate of the cursor position at WHEN seconds

## II.- `simple EXPLORATORY ANALYSIS`

   * `The buttons Map` A run of the Chuck's MiniAudicle script generates 8 buttons after the initial Yield button, at X==0, Y==0 of the script window. From file cont.txt, the script gets a number (1000, 1001, etc.) that, if even, generates a fixed button map; if odd, generates a random seeded map.

   * `The traces Map` Traces, and the initial trace (rows with label "Yield") are constituted by a cumulative sum of deltaX and deltaY magnitudes over variables XofTrace and YofTrace, respectively; with YofTrace adding the negative of the deltaY magnitude, since the MiniAudicle windowing system situates the origin of the window (x == 0, y == 0) at the upper left corner, and positive magnitudes in the Y axis are downwards for the MiniAudicle.

## III.- `SELECTED DATA FILES observations`


   * `out2221nnn.txt -- o` When..
         
   * `out2221nnn.txt MAP & TRAILS` 
