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
----- PACKAGE global -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE global IS
	SIGNAL gsrnet: std_logic := 'H';
	SIGNAL purnet: std_logic := 'H';
 	SIGNAL tsallnet: std_logic := 'H';
	
END global;

PACKAGE BODY global IS 
END global;


--
----- cell gsr -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
 
-- entity declaration --
ENTITY gsr IS
 
   PORT(
      gsr             : IN std_logic := 'Z');

END gsr;
 
-- architecture body --
ARCHITECTURE v OF gsr IS
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   gsrnet <= gsr;
 
END v;

--
----- cell sgsr -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;


-- entity declaration --
ENTITY sgsr IS

   PORT(
      clk              : IN std_logic;
      gsr             : IN std_logic := 'Z');

END sgsr;

-- architecture body --
ARCHITECTURE v OF sgsr IS
   SIGNAL gsrnet1 : std_logic := '1';

BEGIN

   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (clk, gsr)
   BEGIN
      IF (gsr = '0') THEN
         gsrnet <= gsr;
      ELSIF (clk'event and clk = '1') THEN
         gsrnet <= transport gsrnet1 after 1 ps;
      END IF;
   END PROCESS;

   P2 : PROCESS (clk)
   BEGIN
      IF (clk'event and clk = '1') THEN
         gsrnet1 <= gsr;
      END IF;
   END PROCESS;

END v;



--
----- cell pur -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;
 
 
-- entity declaration --
ENTITY pur IS
   GENERIC(
      RST_PULSE       : integer := 1);
 
   PORT(
      pur             : IN std_logic := 'Z');
 
END pur;
 
-- architecture body --
ARCHITECTURE v OF pur IS
    SIGNAL delay_reg     : time := 1 ns;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   purnet <= '0', '1' after (RST_PULSE * delay_reg);
 
END v;


--
----- cell fd1p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3ax IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3ax : ENTITY IS TRUE;

END fd1p3ax ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3ax IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '0', '-', '-', '0', 'S', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', '1', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
 
   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3ay IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3ay : ENTITY IS TRUE;

END fd1p3ay ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '0', '-', '-', '1', 'S', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', '1', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3bx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3bx : ENTITY IS TRUE;

END fd1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, ck, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1', '0' ),  -- async. preset
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '0', '-', '-', '1', 'S', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', '1', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, sp, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3dx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3dx : ENTITY IS TRUE;

END fd1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, ck, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0', '1' ),  -- async. clear
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '0', '-', '-', '0', 'S', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', '1', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE clear	: std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
 
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
    clear := VitalOR2 (a => not(set_reset), b => cd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, clear, sp, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3ix IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3ix : ENTITY IS TRUE;

END fd1p3ix ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, ck, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 9) := (
 -- viol  clr  scl  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0', '1' ),  -- scl=1 on rising ck => q=0
	( '-', '1', '1', '-', 'A', '-', '0', 'S', 'S' ),  -- preserve q(=0) if scl=1 & ck is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(1 or x) => q=x
	( '-', '1', 'X', '-', 'R', '0', '0', 'S', 'S' ),  -- preserve q if scl=x & ck is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '0', 'S', 'S' ),  -- & either d & q are 0 or ce=0 & q=0
	( '-', '1', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- otherwise => q=x
	( '-', '1', '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '-', '0', '-', '-', '0', 'S', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '0', '-', '-', '-', 'X', 'X' ),  -- scl=0 & ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '0', '1' ),  -- scl=1 on rising ck => q=0
	( '-', 'X', '1', '-', 'A', '-', '0', 'S', 'S' ),  -- preserve q(=0) if scl=1 & ck is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(1 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- scl=x on rising ck & (d q != 0 0) & (ce q != 0 0) => q=x
	( '-', 'X', '-', '1', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', '0', '1', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', '-', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', '-', '-', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, cd, sp, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3jx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3jx : ENTITY IS TRUE;

END fd1p3jx ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, ck, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 9) := (
 -- viol  pre  spr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1', '0' ),  -- spr=1 on rising ck => q=1
	( '-', '1', '1', '-', 'A', '-', '1', 'S', 'S' ),  -- preserve q(=1) if spr=1 & ck is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(0 or x) => q=x
	( '-', '1', 'X', '-', 'R', '1', '1', 'S', 'S' ),  -- preserve q if spr=x & ck is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '1', 'S', 'S' ),  -- & either d & q are 1 or ce=0 & q=1
	( '-', '1', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- otherwise => q=x
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '-', '0', '-', '-', '1', 'S', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '0', '-', '-', '-', 'X', 'X' ),  -- spr=0 & ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '1', '0' ),  -- spr=1 on rising ck => q=1
	( '-', 'X', '1', '-', 'A', '-', '1', 'S', 'S' ),  -- preserve q(=1) if spr=1 & ck is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(0 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- spr=x on rising ck & (d q != 1 1) & (ce q != 0 1) => q=x
	( '-', 'X', '-', '1', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', '0', '1', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', '-', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', '-', '-', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, pd, sp, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;



--
----- cell fd1s3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s3ax IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3ax : ENTITY IS TRUE;

END fd1s3ax ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3ax IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1s3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s3ay IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3ay : ENTITY IS TRUE;

END fd1s3ay ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1s3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s3bx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3bx : ENTITY IS TRUE;

END fd1s3bx ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, ck, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '1', '0' ),  -- async. preset
	( '-', '0', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '0', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '0', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1s3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s3dx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3dx : ENTITY IS TRUE;

END fd1s3dx ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, ck, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '0', '1' ),  -- async. clear
	( '-', '0', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '0', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '0', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE clear	: std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => not(set_reset), b => cd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, clear, ck, d),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1s3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s3ix IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3ix : ENTITY IS TRUE;

END fd1s3ix ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr 	: std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d, b => not(cd));  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck, synclr),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fd1s3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s3jx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3jx : ENTITY IS TRUE;

END fd1s3jx ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre 	: std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d, b => pd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck, synpre),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fl1p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3ay IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3ay : ENTITY IS TRUE;

END fl1p3ay ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, sd, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '0', '-', '-', '1', 'S', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', '1', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fl1p3az -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3az IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3az : ENTITY IS TRUE;

END fl1p3az ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3az IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, sd, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '0', '-', '-', '0', 'S', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', '1', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fl1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3bx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3bx : ENTITY IS TRUE;

END fl1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, pd, sd, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1', '0' ),  -- async. preset
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '0', '-', '-', '1', 'S', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', '1', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd);

    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, sp, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fl1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3dx IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3dx : ENTITY IS TRUE;

END fl1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, cd, sd, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 8) := (
 -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0', '1' ),  -- async. clear
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '0', '-', '-', '0', 'S', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '-', '-', '-', 'X', 'X' ),  -- ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', '1', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', '-', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => cd);

    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, sp, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fl1p3iy -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3iy IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3iy : ENTITY IS TRUE;

END fl1p3iy ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3iy IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, cd, sd, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 9) := (
 -- viol  clr  scl  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0', '1' ),  -- scl=1 on rising ck => q=0
	( '-', '1', '1', '-', 'A', '-', '0', 'S', 'S' ),  -- preserve q(=0) if scl=1 & ck is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(1 or x) => q=x
	( '-', '1', 'X', '-', 'R', '0', '0', 'S', 'S' ),  -- preserve q if scl=x & ck is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '0', 'S', 'S' ),  -- & either d & q are 0 or ce=0 & q=0
	( '-', '1', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- otherwise => q=x
	( '-', '1', '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '-', '0', '-', '-', '0', 'S', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '0', '-', '-', '-', 'X', 'X' ),  -- scl=0 & ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '0', '1' ),  -- scl=1 on rising ck => q=0
	( '-', 'X', '1', '-', 'A', '-', '0', 'S', 'S' ),  -- preserve q(=0) if scl=1 & ck is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(1 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- scl=x on rising ck & (d q != 0 0) & (ce q != 0 0) => q=x
	( '-', 'X', '-', '1', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', '0', '1', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', '-', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', '-', '-', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, cd, sp, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;



--
----- cell fl1p3jy -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3jy IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3jy : ENTITY IS TRUE;

END fl1p3jy ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3jy IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, pd, sd, sp, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 9) := (
 -- viol  pre  spr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1', '0' ),  -- spr=1 on rising ck => q=1
	( '-', '1', '1', '-', 'A', '-', '1', 'S', 'S' ),  -- preserve q(=1) if spr=1 & ck is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(0 or x) => q=x
	( '-', '1', 'X', '-', 'R', '1', '1', 'S', 'S' ),  -- preserve q if spr=x & ck is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '1', 'S', 'S' ),  -- & either d & q are 1 or ce=0 & q=1
	( '-', '1', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- otherwise => q=x
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S', 'S' ),  -- if ce is 1 & ck edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S', 'S' ),  -- if ce is x on any pssible rising edge of ck, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '-', '0', '-', '-', '1', 'S', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '0', '-', '-', '-', 'X', 'X' ),  -- spr=0 & ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '1', '0' ),  -- spr=1 on rising ck => q=1
	( '-', 'X', '1', '-', 'A', '-', '1', 'S', 'S' ),  -- preserve q(=1) if spr=1 & ck is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X', 'X' ),  -- q=(0 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X', 'X' ),  -- spr=x on rising ck & (d q != 1 1) & (ce q != 0 1) => q=x
	( '-', 'X', '-', '1', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', '0', '1', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', '-', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', '-', '-', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, pd, sp, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;



--
----- cell fl1s3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s3ax IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s3ax : ENTITY IS TRUE;

END fl1s3ax ;
 
-- architecture body --
ARCHITECTURE v OF fl1s3ax IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, sd, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '0', '0', 'S', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '/', '0', '-', '0', '1' ),  -- d=0 on rising ck => q=0
	( '-', 'X', 'A', '0', '-', 'X', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '0', 'S', 'S' ),  -- preserve q (=0) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '0', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '0', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell fl1s3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s3ay IS
    GENERIC (
        gsr             : String  := "ENABLED");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s3ay : ENTITY IS TRUE;

END fl1s3ay ;
 
-- architecture body --
ARCHITECTURE v OF fl1s3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, sd, ck, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 18, 1 to 7) := (
 -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'A', '0', '0', 'S', 'S' ),  -- if ck edge is (0->x or x->1), and
	( '-', '1', 'A', '1', '1', 'S', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', 'A', '-', '-', 'X', 'X' ),  -- otherwise, q becomes x
	( '-', '1', 'F', '-', '-', 'S', 'S' ),  -- preserve q on any possible falling edge of ck, or
	( '-', '1', 'B', '-', '-', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', 'X', '-', '-', 'S', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '1', '1', 'S', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '/', '1', '-', '1', '0' ),  -- d=1 on rising ck => q=1
	( '-', 'X', 'A', '1', '-', 'X', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) ck edge => q=x
	( '-', 'X', 'R', '-', '-', 'X', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'F', '-', '1', 'S', 'S' ),  -- preserve q (=1) on any possible falling edge of ck, or
	( '-', 'X', 'B', '-', '1', 'S', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', 'X', '-', '1', 'S', 'S' ) );  -- a stable x clock
	
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE muxout      : std_logic := 'X';
 
   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1, d0),
                  dselect => (0 => sd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    q <= q_zd;
 
   END PROCESS;
 
END v;

