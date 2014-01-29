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
-- Simulation Library File for SC
--
-- $Header: /home/rlp/Orfdry/env_rcs/vhdl/pkg/vhdsclibs/data/orca5/src/RCS/ORCA_CMB.vhd,v 1.14 2005/09/07 20:15:18 pradeep Exp $ 
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
----- cell jtaga -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY jtaga IS
   GENERIC(
      JTAG_FLASH_PRGRM : string := "ENABLED");

   PORT(
      tck                :	IN    std_logic;
      tms                :	IN    std_logic;
      tdi                :	IN    std_logic;
      psrout1            :	IN    std_logic;
      psrout2            :	IN    std_logic;
      psrout3            :	IN    std_logic;
      jtdo1              :	IN    std_logic;
      jtdo2              :	IN    std_logic;
      jtdo3              :	IN    std_logic;
      jtdo4              :	IN    std_logic;
      jtdo5              :	IN    std_logic;
      jtdo6              :	IN    std_logic;
      jtdo7              :	IN    std_logic;
      jtdo8              :	IN    std_logic;
      tdo                :	OUT  std_logic;
      treset             :	OUT  std_logic;
      psrsftn            :	OUT  std_logic;
      psrcap             :	OUT  std_logic;
      psrenable1         :	OUT  std_logic;
      psrenable2         :	OUT  std_logic;
      psrenable3         :	OUT  std_logic;
      scanenable1        :	OUT  std_logic;
      scanenable2        :	OUT  std_logic;
      scanenable3        :	OUT  std_logic;
      scanenable4        :	OUT  std_logic;
      scanenable5        :	OUT  std_logic;
      scanenable6        :	OUT  std_logic;
      scanenable7        :	OUT  std_logic;
      scanenable8        :	OUT  std_logic;
      scani              :	OUT  std_logic;
      jtck               :	OUT  std_logic;
      jtdi               :	OUT  std_logic;
      jshift             :	OUT  std_logic;
      jupdate            :	OUT  std_logic;
      jrstn              :	OUT  std_logic;
      jce1               :	OUT  std_logic;
      jce2               :	OUT  std_logic;
      jce3               :	OUT  std_logic;
      jce4               :	OUT  std_logic;
      jce5               :	OUT  std_logic;
      jce6               :	OUT  std_logic;
      jce7               :	OUT  std_logic;
      jce8               :	OUT  std_logic;
      jrti1              :	OUT  std_logic;
      jrti2              :	OUT  std_logic;
      jrti3              :	OUT  std_logic;
      jrti4              :	OUT  std_logic;
      jrti5              :	OUT  std_logic;
      jrti6              :	OUT  std_logic;
      jrti7              :	OUT  std_logic;
      jrti8              :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF jtaga : ENTITY IS TRUE;

END jtaga;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF jtaga IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
      assert FALSE
         report "Empty model is being used for block ""JTAGA"", for the full functional model please use either the encrypted or the pre-compiled models."
         severity WARNING;

      tdo <= '0';
      treset <= '0';
      psrsftn <= '0';
      psrcap  <= '0';
      psrenable1 <= '0';
      psrenable2 <= '0';
      psrenable3 <= '0';
      scanenable1 <= '0';
      scanenable2 <= '0';
      scanenable3 <= '0';
      scanenable4 <= '0';
      scanenable5 <= '0';
      scanenable6 <= '0';
      scanenable7 <= '0';
      scanenable8 <= '0';
      scani <= '0';
      jtck <= '0';
      jtdi <= '0';
      jshift <= '0';
      jupdate <= '0';
      jrstn <= '0';
      jce1 <= '0';
      jce2 <= '0';
      jce3 <= '0';
      jce4 <= '0';
      jce5 <= '0';
      jce6 <= '0';
      jce7 <= '0';
      jce8 <= '0';
      jrti1 <= '0';
      jrti2 <= '0';
      jrti3 <= '0';
      jrti4 <= '0';
      jrti5 <= '0';
      jrti6 <= '0';
      jrti7 <= '0';
      jrti8 <= '0';


END v;


--
----- cell fadd2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadd2 IS

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      ci              :	IN    std_logic;
      s0              :	OUT   std_logic;
      s1              :	OUT   std_logic;
      cout0           :	OUT   std_logic;
      cout1           :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadd2 : ENTITY IS TRUE;

END fadd2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadd2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, 
			    b1, ci)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS cout0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS cout1_zd      : std_ulogic IS results2(1);
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
     
      cout0 <= cout0_zd;
      cout1 <= cout1_zd;
      s0 <= s0_zd;
      s1 <= s1_zd;

END PROCESS;

END v;


--
----- cell fsub2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fsub2 IS

   PORT(
      a0                     :	IN    std_logic;
      a1                     :	IN    std_logic;
      b0                     :	IN    std_logic;
      b1                     :	IN    std_logic;
      bi                     :	IN    std_logic;
      bout0                  :	OUT   std_logic;
      bout1                  :	OUT   std_logic;
      s0                     :	OUT   std_logic;
      s1                     :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fsub2 : ENTITY IS TRUE;

END fsub2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fsub2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0, a1, b0, 
			    b1, bi)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS bout0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS bout1_zd      : std_ulogic IS results2(1);
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
      bout0 <= bout0_zd;
      bout1 <= bout1_zd;
      s0 <= s0_zd;
      s1 <= s1_zd;
 
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
----- cell osca -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
-- entity declaration --
ENTITY osca IS
    GENERIC (
        DIV             : integer := 1);
 
    PORT (
        osc  : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF osca : ENTITY IS TRUE;
 
END osca ;
 
-- architecture body --
ARCHITECTURE v OF osca IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL test_ipd  : std_logic := '0';
    SIGNAL ckout2    : std_logic := '0';
    SIGNAL ckout4    : std_logic := '0';
    SIGNAL ckout8    : std_logic := '0';
    SIGNAL ckout16   : std_logic := '0';
    SIGNAL ckout32   : std_logic := '0';
    SIGNAL ckout64   : std_logic := '0';
    SIGNAL ckout128  : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------

   test_ipd <= not test_ipd after 5 ns;

   P1 : PROCESS (test_ipd, ckout2, ckout4, ckout8, ckout16, ckout32, ckout64)
   BEGIN
      IF (test_ipd'event and test_ipd = '1') THEN
         ckout2 <= not ckout2;
      END IF;
      IF (ckout2'event and ckout2 = '1') THEN
         ckout4 <= not ckout4;
      END IF;
      IF (ckout4'event and ckout4 = '1') THEN
         ckout8 <= not ckout8;
      END IF;
      IF (ckout8'event and ckout8 = '1') THEN
         ckout16 <= not ckout16;
      END IF;
      IF (ckout16'event and ckout16 = '1') THEN
         ckout32 <= not ckout32;
      END IF;
      IF (ckout32'event and ckout32 = '1') THEN
         ckout64 <= not ckout64;
      END IF;
      IF (ckout64'event and ckout64 = '1') THEN
         ckout128 <= not ckout128;
      END IF;

   END PROCESS;

   P2 : PROCESS (test_ipd, ckout2, ckout4, ckout8, ckout16, ckout32, ckout64, ckout128)
   BEGIN
      IF (DIV = 1) THEN
         osc <= test_ipd;
      ELSIF (DIV = 2) THEN
         osc <= ckout2; 
      ELSIF (DIV = 4) THEN
         osc <= ckout4; 
      ELSIF (DIV = 8) THEN
         osc <= ckout8; 
      ELSIF (DIV = 16) THEN
         osc <= ckout16; 
      ELSIF (DIV = 32) THEN
         osc <= ckout32; 
      ELSIF (DIV = 64) THEN
         osc <= ckout64; 
      ELSIF (DIV = 128) THEN
         osc <= ckout128; 
      END IF;

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
----- cell rdbk -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY rdbk IS
   GENERIC (
      FF_RDCFG		 : string  := "ENABLED";
      FF_RDCFG_CLK	 : string  := "USER";
      RDCFG_DATA_SYNC	 : string  := "RISE");

   PORT(
      rdcfgn		 : in std_logic;
      ffrdcfg		 : in std_logic;
      ffrdcfgclk	 : in std_logic;
      rddata		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF rdbk : ENTITY IS TRUE;
 
END rdbk ;

-- ARCHITECTURE body --
ARCHITECTURE V OF rdbk IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

END V;


--
----- cell strtup -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY strtup IS

   PORT(
      uclk		 : in std_logic);

    ATTRIBUTE Vital_Level0 OF strtup : ENTITY IS TRUE;
 
END strtup ;

-- ARCHITECTURE body --
ARCHITECTURE V OF strtup IS
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
   VitalBehavior : PROCESS (a, b, c, d, e, f, 
		g, h, i, j, k)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b XOR c XOR d XOR e xor
		f XOR g XOR h XOR i XOR j XOR 
		k);


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
   VitalBehavior : PROCESS (a, b, c, d, e, f, 
		g, h, i, j, k, l, m, n,
		o, p, q, r, s, t, u)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= (a XOR b XOR c XOR d XOR e xor
		f XOR g XOR h XOR i XOR j XOR 
		k XOR l XOR m XOR n XOR o xor
		p) XOR (q XOR r XOR s XOR t XOR 
		u);

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
      buf_delay       : time := 0 ns;
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
   SIGNAL a_sig  : std_logic := 'X';

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
   a_sig <= transport a_ipd after buf_delay;

   VitalBehavior : PROCESS (a_sig)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= VitalBUF(a_sig);

END PROCESS;

END v;


