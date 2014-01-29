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
-- Simulation Library File for XP2
--
-- $Header:  
--

----- CELL ORCALUT4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT4 is
   generic(
      INIT                          :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT4 : entity is TRUE;
end ORCALUT4;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT4 is
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
                 (data => To_StdLogicVector(INIT),
                  dselect => (D, C, B, A));

   end process;

end V;

configuration CFG_ORCALUT4_V of ORCALUT4 is
   for V
   end for;
end CFG_ORCALUT4_V;

----- CELL ORCALUT5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT5 is
   generic(
      INIT                           :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT5 : entity is TRUE;
end ORCALUT5;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT5 is
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
                 (data => To_StdLogicVector(INIT),
                  dselect => (E, D, C, B, A));

   end process;

end V;

configuration CFG_ORCALUT5_V of ORCALUT5 is
   for V
   end for;
end CFG_ORCALUT5_V;

----- CELL ORCALUT6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT6 is
   generic(
      INIT                           :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT6 : entity is TRUE;
end ORCALUT6;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT6 is
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
                 (data => To_StdLogicVector(INIT),
                  dselect => (F, E, D, C, B, A));

   end process;

end V;

configuration CFG_ORCALUT6_V of ORCALUT6 is
   for V
   end for;
end CFG_ORCALUT6_V;

----- CELL ORCALUT7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT7 is
   generic(
      INIT                           :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC;
      G                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT7 : entity is TRUE;
end ORCALUT7;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT7 is
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
                 (data => To_StdLogicVector(INIT),
                  dselect => (G, F, E, D, C, B, A));

   end process;

end V;

configuration CFG_ORCALUT7_V of ORCALUT7 is
   for V
   end for;
end CFG_ORCALUT7_V;

----- CELL ORCALUT8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT8 is
   generic(
      INIT                           :	bit_vector);

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
attribute VITAL_LEVEL0 of ORCALUT8 : entity is TRUE;
end ORCALUT8;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT8 is
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
                 (data => To_StdLogicVector(INIT),
                  dselect => (H, G, F, E, D, C, B, A));

   end process;

end V;

configuration CFG_ORCALUT8_V of ORCALUT8 is
   for V
   end for;
end CFG_ORCALUT8_V;

