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

--
----- cell ageb2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY ageb2 IS

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      ci              :	IN    std_logic := '1';
      ge              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF ageb2 : ENTITY IS TRUE;

END ageb2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF ageb2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, b1, ci)

   VARIABLE a, b    : std_logic_vector(0 to 1) := (others => 'X');

   BEGIN

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a1, a0);
      b := std_logic_vector'(b1, b0);

      -- if a = b, then output carry-in (ge from the lower stage)
      -- note: carry-in on the first stage is tied high
      IF (a > b) THEN
	ge <= '1'; 
      ELSIF (a = b) THEN
	ge <= ci;
      ELSE
	ge <= '0';
      END IF;

   END PROCESS;

END v;



--
----- cell aleb2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aleb2 IS

   PORT(
      a0, a1   : IN std_logic;
      b0, b1   : IN std_logic;
      ci       : IN std_logic := '1';
      le       : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF aleb2 : ENTITY IS TRUE;

END aleb2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aleb2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, b1, ci) 

   VARIABLE a, b    : std_logic_vector(0 to 1) := (others => 'X');

   BEGIN

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a1, a0);
      b := std_logic_vector'(b1, b0);

      -- if a = b, then output carry-in (le from the lower stage)
      -- note: carry-in on the first stage is tied high
      IF (a < b) THEN
	le <= '1'; 
      ELSIF (a = b) THEN
	le <= ci;
      ELSE
	le <= '0';
      END IF;

   END PROCESS;

END v;


--
----- cell aneb2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aneb2 IS

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      ci              :	IN    std_logic := '0';
      ne              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF aneb2 : ENTITY IS TRUE;

END aneb2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aneb2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, b1, ci)

   VARIABLE a, b    : std_logic_vector(0 to 1) := (others => 'X');

   BEGIN

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a1, a0);
      b := std_logic_vector'(b1, b0);

      -- IF a = b, THEN pass on carry-in input (ne from the previous stage)
      -- note: carry-in on the first stage is tied low
      IF (a = b) THEN
	ne <= ci; 
      ELSE
	ne <= '1';
      END IF;

   END PROCESS;

END v;


--
----- cell and2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and2 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF and2 : ENTITY IS TRUE;

END and2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a AND b);

   END PROCESS;

END v;


--
----- cell and3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and3 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT   std_logic); 

   ATTRIBUTE Vital_Level0 OF and3 : ENTITY IS TRUE;

END and3;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and3 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a AND b AND c);

   END PROCESS;

END v;


--
----- cell and4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and4 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF and4 : ENTITY IS TRUE;

END and4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a AND b AND c AND d);

   END PROCESS;

END v;


--
----- cell and5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and5 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF and5 : ENTITY IS TRUE;

END and5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and5 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a AND b AND c AND d AND e);

END PROCESS;

END v;



--
----- cell fadd2b -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadd2b IS

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      ci              :	IN    std_logic;
      s0              :	OUT   std_logic;
      s1              :	OUT   std_logic;
      cout            :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadd2b : ENTITY IS TRUE;

END fadd2b;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadd2b IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, b1, ci)

   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS cout0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS cout_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);

   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    ci   |   co   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (a0, b0, ci)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (a1, b1, cout0_zd)
                );

      s0 <= s0_zd;
      s1 <= s1_zd;
      cout <= cout_zd;

   END PROCESS;

END v;


--
----- cell fsub2b -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fsub2b IS

   PORT(
      a0                     :	IN    std_logic;
      a1                     :	IN    std_logic;
      b0                     :	IN    std_logic;
      b1                     :	IN    std_logic;
      bi                     :	IN    std_logic;
      bout                   :	OUT   std_logic;
      s0                     :	OUT   std_logic;
      s1                     :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fsub2b : ENTITY IS TRUE;

END fsub2b;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fsub2b IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, b1, bi)

   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS bout0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS bout_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);

   constant sub_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    bi   |   bo   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a0, b0, bi)
                );
      results2 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a1, b1, bout0_zd)
                );

      s0 <= s0_zd;
      s1 <= s1_zd;
      bout <= bout_zd;

   END PROCESS;

END v;



----- cell fadsu2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadsu2 IS

   PORT(
      a0             :  IN    std_logic;
      a1             :  IN    std_logic;
      b0             :  IN    std_logic;
      b1             :  IN    std_logic;
      bci            :  IN    std_logic;
      con            :  IN    std_logic;
      bco            :  OUT   std_logic;
      s0             :  OUT   std_logic;
      s1             :  OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadsu2 : ENTITY IS TRUE;

END fadsu2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadsu2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, b1, bci, con)

   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
--   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
--   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS bc0_zd     : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS bco_zd     : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);

   constant adsu_table : vitaltruthtabletype := (
   --------------------------------------------
   --   a    b   bci  con  |   bco   s
   --------------------------------------------
      ('0', '0', '0', '1',     '0', '0'),
      ('1', '0', '0', '1',     '0', '1'),
      ('0', '1', '0', '1',     '0', '1'),
      ('1', '1', '0', '1',     '1', '0'),
      ('0', '0', '1', '1',     '0', '1'),
      ('1', '0', '1', '1',     '1', '0'),
      ('0', '1', '1', '1',     '1', '0'),
      ('1', '1', '1', '1',     '1', '1'),
      ('0', '0', '0', '0',     '0', '1'),
      ('1', '0', '0', '0',     '1', '0'),
      ('0', '1', '0', '0',     '0', '0'),
      ('1', '1', '0', '0',     '0', '1'),
      ('0', '0', '1', '0',     '1', '0'),
      ('1', '0', '1', '0',     '1', '1'),
      ('0', '1', '1', '0',     '0', '1'),
      ('1', '1', '1', '0',     '1', '0'));

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a0, b0, bci, con)
                );
      results2 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a1, b1, bc0_zd, con)
                );

      s0 <= s0_zd;
      s1 <= s1_zd;
      bco <= bco_zd;

   END PROCESS;

END v;



--
----- cell inv -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY inv IS

   PORT(
      a                              :	IN    std_logic;
      z                              :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF inv : ENTITY IS TRUE;

END inv;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF inv IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (NOT a);

   END PROCESS;

END v;


--
----- cell mux21 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux21 IS

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      sd              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux21 : ENTITY IS TRUE;

END mux21;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux21 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, sd)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

   END PROCESS;

END v;



--
----- cell l6mux21 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY l6mux21 IS

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      sd              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF l6mux21 : ENTITY IS TRUE;

END l6mux21;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF l6mux21 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, sd)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

   END PROCESS;

END v;


--
----- cell mux41 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;

ENTITY mux41 IS

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      d2              :	IN    std_logic;
      d3              :	IN    std_logic;
      sd1             :	IN    std_logic;
      sd2             :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux41 : ENTITY IS TRUE;

END mux41;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux41 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, d2, d3, sd1, sd2)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d3, d2, d1, d0),
                  dselect => (sd2, sd1));

   END PROCESS;

END v;


--
----- cell mux81 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux81 IS

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux81 : ENTITY IS TRUE;

END mux81;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux81 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, d2, d3, d4, d5, d6, d7, sd1, sd2, sd3)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d7, d6, d5, d4, d3, d2, d1, d0),
                  dselect => (sd3, sd2, sd1));

   END PROCESS;

END v;


--
----- cell mux161 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux161 IS

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      d8              : IN    std_logic;
      d9              : IN    std_logic;
      d10             : IN    std_logic;
      d11             : IN    std_logic;
      d12             : IN    std_logic;
      d13             : IN    std_logic;
      d14             : IN    std_logic;
      d15             : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      sd4             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux161 : ENTITY IS TRUE;

END mux161;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux161 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, sd1, sd2, sd3, sd4)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1, d0),
                  dselect => (sd4, sd3, sd2, sd1));

   END PROCESS;

END v;


--
----- cell mux321 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux321 IS

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      d8              : IN    std_logic;
      d9              : IN    std_logic;
      d10             : IN    std_logic;
      d11             : IN    std_logic;
      d12             : IN    std_logic;
      d13             : IN    std_logic;
      d14             : IN    std_logic;
      d15             : IN    std_logic;
      d16             : IN    std_logic;
      d17             : IN    std_logic;
      d18             : IN    std_logic;
      d19             : IN    std_logic;
      d20             : IN    std_logic;
      d21             : IN    std_logic;
      d22             : IN    std_logic;
      d23             : IN    std_logic;
      d24             : IN    std_logic;
      d25             : IN    std_logic;
      d26             : IN    std_logic;
      d27             : IN    std_logic;
      d28             : IN    std_logic;
      d29             : IN    std_logic;
      d30             : IN    std_logic;
      d31             : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      sd4             : IN    std_logic;
      sd5             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux321 : ENTITY IS TRUE;

END mux321;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux321 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31, sd1, sd2, sd3, sd4, sd5)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d31, d30, d29, d28, d27, d26, d25, d24, d23, d22, d21, d20, d19, d18, d17, d16, d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1, d0),
                  dselect => (sd5, sd4, sd3, sd2, sd1));

   END PROCESS;

END v;



--
----- cell nd2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd2 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd2 : ENTITY IS TRUE;

END nd2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a AND b);

   END PROCESS;

END v;


--
----- cell nd3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd3 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd3 : ENTITY IS TRUE;

END nd3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd3 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a AND b AND c);

   END PROCESS;

END v;


--
----- cell nd4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd4 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd4 : ENTITY IS TRUE;

END nd4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a AND b AND c AND d);

   END PROCESS;

END v;


--
----- cell nd5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd5 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd5 : ENTITY IS TRUE;

END nd5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd5 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a AND b AND c AND d AND e);

   END PROCESS;

END v;


--
----- cell nr2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr2 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr2 : ENTITY IS TRUE;

END nr2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a OR b);

   END PROCESS;

END v;


--
----- cell nr3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr3 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr3 : ENTITY IS TRUE;

END nr3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr3 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a OR b OR c);

   END PROCESS;

END v;


--
----- cell nr4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr4 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr4 : ENTITY IS TRUE;

END nr4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a OR b OR c OR d);

   END PROCESS;

END v;


--
----- cell nr5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr5 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr5 : ENTITY IS TRUE;

END nr5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr5 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a OR b OR c OR d OR e);

   END PROCESS;

END v;


--
----- cell or2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or2 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF or2 : ENTITY IS TRUE;

END or2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a OR b);

   END PROCESS;

END v;


--
----- cell or3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or3 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF or3 : ENTITY IS TRUE;

END or3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or3 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a OR b OR c);

   END PROCESS;

END v;


--
----- cell or4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or4 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF or4 : ENTITY IS TRUE;

END or4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a OR b OR c OR d);

   END PROCESS;

END v;


--
----- cell or5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or5 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF or5 : ENTITY IS TRUE;

END or5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or5 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a OR b OR c OR d OR e);

   END PROCESS;

END v;


--
----- cell pfumx -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY pfumx IS

   PORT(
      alut            :	IN    std_logic;
      blut            :	IN    std_logic;
      c0              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF pfumx : ENTITY IS TRUE;

END pfumx;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF pfumx IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (alut, blut, c0)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (alut, blut),
                  dselect => (0 => c0));

   END PROCESS;

END v;



--
----- cell start -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY start IS

   PORT(
      startclk : in std_logic);

    ATTRIBUTE Vital_Level0 OF start : ENTITY IS TRUE;
 
END start ;

-- ARCHITECTURE body --
ARCHITECTURE V OF start IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

END V;


--
----- cell vhi -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY vhi IS

   PORT(
      z               :	OUT  std_logic := '1');

   ATTRIBUTE Vital_Level0 OF vhi : ENTITY IS TRUE;

END vhi;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF vhi IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   z <= '1';

END v;


--
----- cell vlo -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY vlo IS

   PORT(
      z               :	OUT  std_logic := '0');

   ATTRIBUTE Vital_Level0 OF vlo : ENTITY IS TRUE;

END vlo;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF vlo IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   z <= '0';

END v;


--
----- cell xnor2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor2 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor2 : ENTITY IS TRUE;

END xnor2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a XOR b);

   END PROCESS;

END v;


--
----- cell xnor3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor3 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor3 : ENTITY IS TRUE;

END xnor3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor3 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a XOR b XOR c);

   END PROCESS;

END v;


--
----- cell xnor4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor4 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor4 : ENTITY IS TRUE;

END xnor4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a XOR b XOR c XOR d);

   END PROCESS;

END v;

--
----- cell xnor5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor5 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor5 : ENTITY IS TRUE;

END xnor5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor5 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= NOT (a XOR b XOR c XOR d XOR e);

   END PROCESS;

END v;


--
----- cell xor2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor2 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF xor2 : ENTITY IS TRUE;

END xor2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b);

   END PROCESS;

END v;


--
----- cell xor3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor3 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xor3 : ENTITY IS TRUE;

END xor3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor3 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b XOR c);

   END PROCESS;

END v;


--
----- cell xor4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor4 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xor4 : ENTITY IS TRUE;

END xor4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b XOR c XOR d);

   END PROCESS;

END v;


--
----- cell xor5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor5 IS

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xor5 : ENTITY IS TRUE;

END xor5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor5 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b XOR c XOR d XOR e);

   END PROCESS;

END v;


--
----- cell xor11 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor11 IS

   PORT(
      a, b, c, d, e, f, g, h, i, j, k : IN std_logic;
      z                               : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF xor11 : ENTITY IS TRUE;

END xor11;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor11 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e, f, g, h, i, j, k)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b XOR c XOR d XOR e xor f XOR g XOR h XOR i XOR j XOR k);

   END PROCESS;

END v;


--
----- cell xor21 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor21 IS

   PORT(
      a, b, c, d, e, f, g, h, i, j, k : IN std_logic;
      l, m, n, o, p, q, r, s, t, u    : IN std_logic;
      z				      :	OUT std_logic);

   ATTRIBUTE Vital_Level0 OF xor21 : ENTITY IS TRUE;

END xor21;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor21 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b XOR c XOR d XOR e xor f XOR g XOR h XOR i XOR j XOR k XOR l XOR m XOR n XOR o xor p)
			XOR (q XOR r XOR s XOR t XOR u);

   END PROCESS;

END v;


--
----- cell bufba -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY bufba IS
   GENERIC(
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               : IN   std_logic;
      z               : OUT  std_logic);

    ATTRIBUTE Vital_Level0 OF bufba : ENTITY IS TRUE;

END bufba;

-- architecture body --
ARCHITECTURE v OF bufba IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= VitalBUF(a_ipd);

   END PROCESS;

END v;


--
----- cell oscf -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY oscf IS
    GENERIC (
        NOM_FREQ        : string := "2.5");

    PORT (
        osc  : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF oscf : ENTITY IS TRUE;

END oscf ;

-- architecture body --
ARCHITECTURE v OF oscf IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL test_ipd  : std_logic := '1';
    SIGNAL half_clk  : time := 0.0 ns;

BEGIN

   --------------------
   --  behavior section
   --------------------

   P1 : PROCESS
   BEGIN
      IF (NOM_FREQ = "2.5") THEN
         half_clk <= 200.0 ns;
      ELSIF (NOM_FREQ = "4.3") THEN
         half_clk <= 116.28 ns;
      ELSIF (NOM_FREQ = "5.4") THEN
         half_clk <= 92.59 ns;
      ELSIF (NOM_FREQ = "6.9") THEN
         half_clk <= 72.46 ns;
      ELSIF (NOM_FREQ = "8.1") THEN
         half_clk <= 61.73 ns;
      ELSIF (NOM_FREQ = "9.2") THEN
         half_clk <= 54.35 ns;
      ELSIF (NOM_FREQ = "10.0") THEN
         half_clk <= 50.0 ns;
      ELSIF (NOM_FREQ = "13.0") THEN
         half_clk <= 38.462 ns;
      ELSIF (NOM_FREQ = "15.0") THEN
         half_clk <= 33.333 ns;
      ELSIF (NOM_FREQ = "20.0") THEN
         half_clk <= 25.0 ns;
      ELSIF (NOM_FREQ = "26.0") THEN
         half_clk <= 19.231 ns;
      ELSIF (NOM_FREQ = "30.0") THEN
         half_clk <= 16.667 ns;
      ELSIF (NOM_FREQ = "34.0") THEN
         half_clk <= 14.706 ns;
      ELSIF (NOM_FREQ = "41.0") THEN
         half_clk <= 12.195 ns;
      ELSIF (NOM_FREQ = "45.0") THEN
         half_clk <= 11.111 ns;
      ELSIF (NOM_FREQ = "51.0") THEN
         half_clk <= 9.804 ns;
      ELSIF (NOM_FREQ = "55.0") THEN
         half_clk <= 9.091 ns;
      ELSIF (NOM_FREQ = "60.0") THEN
         half_clk <= 8.333 ns;
      ELSIF (NOM_FREQ = "130.0") THEN
         half_clk <= 3.846 ns;
      ELSE
	 half_clk <= 200.0 ns;
	 assert (false)
	     report "Wrong oscillator frequency; default to 2.5 MHz!"
	     severity Warning;
      END IF;

      wait;
   END PROCESS;

   test_ipd <= not test_ipd after half_clk;

   osc <= test_ipd;

END v;


--
----- cell SEDCA -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
use std.textio.all;

-- entity declaration --
ENTITY SEDCA IS
   GENERIC (
      OSC_DIV       : integer := 1;
      CHECKALWAYS   : string  := "DISABLED";
      AUTORECONFIG  : string   := "OFF";
      MCCLK_FREQ    : string   := "2.5";
      DEV_DENSITY   : string   := "95K");

   PORT(
      SEDENABLE        : in std_logic;
      SEDSTART         : in std_logic;
      SEDFRCERR        : in std_logic;
      SEDERR           : out std_logic;
      SEDDONE          : out std_logic;
      SEDINPROG        : out std_logic;
      SEDCLKOUT        : out std_logic;
      AUTODONE         : out std_logic);

    ATTRIBUTE Vital_Level0 OF SEDCA : ENTITY IS TRUE;

END SEDCA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SEDCA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    SIGNAL clkout  : std_logic := '0';
    SIGNAL SEDCLKOUTB  : std_logic := '0';
    SIGNAL done  : std_logic := '0';
    SIGNAL start  : std_logic := '0';
    SIGNAL err  : std_logic := '0';
    SIGNAL inprog  : std_logic := '0';
    SIGNAL count  : integer := 0;
    SIGNAL sed_count  : integer := 0;
                                                                                
  function str2rel(s: in string) return real is
    variable res : real := 0.0;
    variable l : line;
  begin
    write(l, s, RIGHT, s'length);
    read(l, res);
    return res;
  end function str2rel;
                                                                                
    CONSTANT clk_freq : real := str2rel(MCCLK_FREQ);
--    CONSTANT real_half_clk : real := (clk_freq / real(OSC_DIV));
    CONSTANT osc_half_clk : time := ((500 ns * OSC_DIV)/ clk_freq );
                                                                                
BEGIN
                                                                                
   clkout <= not clkout after osc_half_clk;
                                                                                
   P1 : PROCESS
   BEGIN
      IF (DEV_DENSITY = "95K") THEN
         sed_count <= 18966262;
      ELSIF (DEV_DENSITY = "70K") THEN
         sed_count <= 18966262;
      ELSIF (DEV_DENSITY = "150K") THEN
         sed_count <= 30241118;
      ELSIF (DEV_DENSITY = "35K") THEN
         sed_count <= 7060902;
      ELSIF (DEV_DENSITY = "17K") THEN
         sed_count <= 3987142;
      ELSE
        sed_count <= 18966262;
      END IF;
                                                                                
      wait;
   END PROCESS;
                                                                                
  P2 : PROCESS(SEDENABLE, clkout)
  BEGIN
     IF (SEDENABLE = '1') THEN
        SEDCLKOUTB <= clkout;
     ELSE
        SEDCLKOUTB <= '0';
     END IF;
  END PROCESS;
                                                                                
  P3 : PROCESS(clkout, done)
  BEGIN
     IF (done = '0') THEN
        IF (clkout'event and clkout = '1') THEN
           IF (SEDSTART = '1') THEN
              start <= '1';
           END IF;
        END IF;
     ELSIF (done = '1') THEN
           start <= '0';
     END IF;
  END PROCESS;
                                                                                
  P4 : PROCESS(clkout, done)
  BEGIN
     IF (done = '0') THEN
        IF (clkout'event and clkout = '1') THEN
           IF (start = '1') THEN
              inprog <= '1';
           END IF;
        END IF;
     ELSIF (done = '1') THEN
        inprog <= '0';
     END IF;
  END PROCESS;
                                                                                
  P5 : PROCESS(SEDFRCERR, SEDENABLE)
  BEGIN
     IF (SEDENABLE = '1' and SEDFRCERR = '1') THEN
        err <= transport '1' after 10 ns;
     ELSE
        err <= '0';
     END IF;
  END PROCESS;
                                                                                
   P6 : PROCESS (clkout)
   BEGIN
      IF (clkout'event and clkout = '1') THEN
         IF (count < sed_count) THEN
            done <= '0';
            IF (start = '1') THEN
               count <= count + 1;
            END IF;
         ELSIF (count = sed_count) THEN
            done <= '1';
            count <= 0;
         END IF;
      END IF;
   END PROCESS;

  SEDERR <= err;
  SEDDONE <= done;
  SEDINPROG <= inprog;
  SEDCLKOUT <= SEDCLKOUTB;
  AUTODONE <= '1';

END V;


--
----- cell jtage -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY jtage IS
   GENERIC(
      ER1              : string := "ENABLED";
      ER2              : string := "ENABLED");

   PORT(
      tck                :      IN    std_logic;
      tms                :      IN    std_logic;
      tdi                :      IN    std_logic;
      jtdo1              :      IN    std_logic;
      jtdo2              :      IN    std_logic;
      tdo                :      OUT  std_logic;
      jtck               :      OUT  std_logic;
      jtdi               :      OUT  std_logic;
      jshift             :      OUT  std_logic;
      jupdate            :      OUT  std_logic;
      jrstn              :      OUT  std_logic;
      jce1               :      OUT  std_logic;
      jce2               :      OUT  std_logic;
      jrti1              :      OUT  std_logic;
      jrti2              :      OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF jtage : ENTITY IS TRUE;

END jtage;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF jtage IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
      assert FALSE
         report "Empty model is being used for block ""JTAGE"", for the full functional model please use either the encrypted or the pre-compiled models."
         severity WARNING;

      tdo <= '0';
      jtck <= '0';
      jtdi <= '0';
      jshift <= '0';
      jupdate <= '0';
      jrstn <= '0';
      jce1 <= '0';
      jce2 <= '0';
      jrti1 <= '0';
      jrti2 <= '0';

END v;


--
----- cell SPIM -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY SPIM IS

   PORT(
      SEL           : in std_logic;
      A0            : in std_logic;
      A1            : in std_logic;
      A2            : in std_logic;
      A3            : in std_logic;
      A4            : in std_logic;
      A5            : in std_logic;
      A6            : in std_logic;
      A7            : in std_logic);

    ATTRIBUTE Vital_Level0 OF SPIM : ENTITY IS TRUE;

END SPIM ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SPIM IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

END V;


--
----- cell AMBOOTA -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY AMBOOTA IS
   GENERIC (
      CS_SS          : string := "STATIC";
      AUTOREBOOT     : string := "OFF";
      CS_SS_VAL      : string := "CHIP1";
      SECTOR_ADDRESS : string := "0x00");

   PORT(
      CSI, AUTOREBOOTI, A7, A6, A5, A4, A3, A2, A1, A0 : in std_logic;
      CSO, O7, O6, O5, O4, O3, O2, O1, O0 : out std_logic);

   ATTRIBUTE Vital_Level0 OF AMBOOTA : ENTITY IS TRUE;

END AMBOOTA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF AMBOOTA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

   CSO <= '0';
   O0  <= '0';
   O1  <= '0';
   O2  <= '0';
   O3  <= '0';
   O4  <= '0';
   O5  <= '0';
   O6  <= '0';
   O7  <= '0';

END V;


--
----- cell PERREGA -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY PERREGA IS

   port (D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0 : in std_logic;
         Q15, Q14, Q13, Q12, Q11, Q10, Q9, Q8, Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0 : out std_logic);

    ATTRIBUTE Vital_Level0 OF PERREGA : ENTITY IS TRUE;

END PERREGA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF PERREGA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

    Q0 <= '0';
    Q1 <= '0';
    Q2 <= '0';
    Q3 <= '0';
    Q4 <= '0';
    Q5 <= '0';
    Q6 <= '0';
    Q7 <= '0';
    Q8 <= '0';
    Q9 <= '0';
    Q10 <= '0';
    Q11 <= '0';
    Q12 <= '0';
    Q13 <= '0';
    Q14 <= '0';
    Q15 <= '0';

END V;


--
----- cell DTSA -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY DTSA IS

   port (DTSI3, DTSI2, DTSI1, DTSI0 : in std_logic;
         DTSO                       : out std_logic);

   ATTRIBUTE Vital_Level0 OF DTSA : ENTITY IS TRUE;

END DTSA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF DTSA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

    DTSO <= '0';

END V;

