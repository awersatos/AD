-- --------------------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
-- --------------------------------------------------------------------
-- Copyright (c) 2005 by Lattice Semiconductor Corporation
-- --------------------------------------------------------------------
--
--
--                     Lattice Semiconductor Corporation
--                     5555 NE Moore Court
--                     Hillsboro, OR 97214
--                     U.S.A.
--
--                     TEL: 1-800-Lattice  (USA and Canada)
--                          1-408-826-6000 (other locations)
--
--                     web: http://www.latticesemi.com/
--                     email: techsupport@latticesemi.com
--
-- --------------------------------------------------------------------
--
-- Simulation Library File for ECP3
--
-- $Header:  
--

----- CELL LUT4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity LUT4 is
   generic(
      INIT                          :	std_logic_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of LUT4 : entity is TRUE;
end LUT4;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of LUT4 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

begin

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A, B, C, D)

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z <= VitalMUX
                 (data => INIT,
                  dselect => (D, C, B, A));

   end process;

end V;

configuration CFG_LUT4_V of LUT4 is
   for V
   end for;
end CFG_LUT4_V;

----- CELL LUT5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity LUT5 is
   generic(
      INIT                           :	std_logic_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of LUT5 : entity is TRUE;
end LUT5;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of LUT5 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

begin

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A, B, C, D, E)

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z <= VitalMUX
                 (data => INIT,
                  dselect => (E, D, C, B, A));

   end process;

end V;

configuration CFG_LUT5_V of LUT5 is
   for V
   end for;
end CFG_LUT5_V;

----- CELL LUT6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity LUT6 is
   generic(
      INIT                           :	std_logic_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of LUT6 : entity is TRUE;
end LUT6;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of LUT6 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

begin

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A, B, C, D, E, F)

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z <= VitalMUX
                 (data => INIT,
                  dselect => (F, E, D, C, B, A));

   end process;

end V;

configuration CFG_LUT6_V of LUT6 is
   for V
   end for;
end CFG_LUT6_V;

----- CELL LUT7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity LUT7 is
   generic(
      INIT                           :	std_logic_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC;
      G                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of LUT7 : entity is TRUE;
end LUT7;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of LUT7 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

begin

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A, B, C, D, E, F, G)

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z <= VitalMUX
                 (data => INIT,
                  dselect => (G, F, E, D, C, B, A));

   end process;

end V;

configuration CFG_LUT7_V of LUT7 is
   for V
   end for;
end CFG_LUT7_V;

----- CELL LUT8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity LUT8 is
   generic(
      INIT                           :	std_logic_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC;
      G                             :	in    STD_ULOGIC;
      H                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of LUT8 : entity is TRUE;
end LUT8;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of LUT8 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

begin

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A, B, C, D, E, F, G, H)

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z <= VitalMUX
                 (data => INIT,
                  dselect => (H, G, F, E, D, C, B, A));

   end process;

end V;

configuration CFG_LUT8_V of LUT8 is
   for V
   end for;
end CFG_LUT8_V;

