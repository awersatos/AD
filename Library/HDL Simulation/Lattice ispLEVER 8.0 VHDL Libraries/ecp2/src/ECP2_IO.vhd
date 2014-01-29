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
-- Simulation Library File for ECP2
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/ecp2/src/RCS/ECP2_IO.vhd,v 1.2 2005/07/13 21:48:42 rag Exp $ 
--


--
----- cell tsall -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;

-- entity declaration --
ENTITY tsall IS

   PORT(
      tsall           : IN std_logic := 'Z');

END tsall;

-- architecture body --
ARCHITECTURE v OF tsall IS

BEGIN

   --------------------
   --  behavior section
   --------------------
   tsallnet <= tsall;

END v;


--
----- cell bb -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bb IS

   PORT(
      b               :  INOUT std_logic;
      i               :  IN std_logic;
      t               :  IN std_logic;
      o               :  OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bb : ENTITY IS TRUE;

END bb;

-- architecture body --
ARCHITECTURE v OF bb IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b, i, t, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      b_zd := VitalBUFIF0 (data => i, enable => tri);
      o_zd := VitalBUF(b);

      b <= b_zd;
      o <= o_zd;

   END PROCESS;

END v;



--
----- cell bbpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bbpd IS

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bbpd : ENTITY IS TRUE;
 
END bbpd;

-- architecture body --
ARCHITECTURE v OF bbpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b, i, t, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      b_zd := VitalBUFIF0 (data => i, enable => tri, 
                          resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      b <= b_zd;
      o <= o_zd;

   END PROCESS;

END v;


--
----- cell bbpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bbpu IS

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bbpu : ENTITY IS TRUE;
 
END bbpu;

-- architecture body --
ARCHITECTURE v OF bbpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b, i, t, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      b_zd := VitalBUFIF0 (data => i, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      b <= b_zd;
      o <= o_zd;

   END PROCESS;

END v;


--
----- cell bbw -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bbw IS

   PORT(
      b               :  INOUT std_logic;
      i               :  IN std_logic;
      t               :  IN std_logic;
      o               :  OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bbw : ENTITY IS TRUE;

END bbw;

-- architecture body --
ARCHITECTURE v OF bbw IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_int  : std_logic := 'L';

BEGIN

   --------------------
   --  behavior section
   --------------------
   KEEP : PROCESS (b)
   BEGIN
        IF (b'event) THEN
           IF (b = '1') THEN
              b_int <= 'H';
           ELSIF (b = '0') THEN
              b_int <= 'L';
           END IF;
        END IF;
   END PROCESS;

   b <= b_int;

   VitalBehavior : PROCESS (b, i, t, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      b_zd := VitalBUFIF0 (data => i, enable => tri);
      o_zd := VitalBUF(b);

      b <= b_zd;
      o <= o_zd;

   END PROCESS;

END v;



--
----- cell ib -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ib IS

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ib : ENTITY IS TRUE;
 
END ib;

-- architecture body --
ARCHITECTURE v OF ib IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o <= VitalBUF(i);

   END PROCESS;

END v;



--
----- cell ibpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibpd IS

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibpd : ENTITY IS TRUE;
 
END ibpd;

-- architecture body --
ARCHITECTURE v OF ibpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i,
                           resultmap => ('U','X','0','1','L'));
      o <= VitalBUF(i_ipd2);

   END PROCESS;

END v;



--
----- cell ibpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibpu IS

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibpu : ENTITY IS TRUE;
 
END ibpu;

-- architecture body --
ARCHITECTURE v OF ibpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i,
                           resultmap => ('U','X','0','1','H'));
      o <= VitalBUF(i_ipd2);

   END PROCESS;

END v;



--
----- cell ifs1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ifs1p3bx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3bx : ENTITY IS TRUE;

END ifs1p3bx ;

-- architecture body --
ARCHITECTURE v OF ifs1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 7) := (
 -- viol  pre  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '0', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '1', '1', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '0', '-', '-', '1', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '-', '-', '-', 'X' ),  -- ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '/', '1', '-', '1' ),  -- d=1 on rising sclk => q=1
	( '-', 'X', '1', 'A', '1', '-', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', 'F', '-', '1', 'S' ),  -- preserve q (=1) on any possible falling edge of sclk, or
	( '-', 'X', '-', 'B', '-', '1', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '1', 'S' ) );  -- a stable x clock
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
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

    preset := VitalOR2 (a => NOT(set_reset), b => pd);  

    vitalstatetable (statetable => ff_table,
	    datain => (violation, preset, sp, sclk, d),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ifs1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1p3dx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3dx : ENTITY IS TRUE;

END ifs1p3dx ;

-- architecture body --
ARCHITECTURE v OF ifs1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 7) := (
 -- viol  clr  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '0', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '0', '0', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '0', '-', '-', '0', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '-', '-', '-', 'X' ),  -- ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '/', '0', '-', '0' ),  -- d=0 on rising sclk => q=0
	( '-', 'X', '1', 'A', '0', '-', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', 'F', '-', '0', 'S' ),  -- preserve q (=0) on any possible falling edge of sclk, or
	( '-', 'X', '-', 'B', '-', '0', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '0', 'S' ) );  -- a stable x clock
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
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

    clear := VitalOR2 (a => NOT(set_reset), b => cd);  

    vitalstatetable (statetable => ff_table,
	    datain => (violation, clear, sp, sclk, d),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ifs1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ifs1p3ix IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3ix : ENTITY IS TRUE;

END ifs1p3ix ;

-- architecture body --
ARCHITECTURE v OF ifs1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 8) := (
 -- viol  clr  scl  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- scl=1 on rising sclk => q=0
	( '-', '1', '1', '-', 'A', '-', '0', 'S' ),  -- preserve q(=0) if scl=1 & sclk is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X' ),  -- q=(1 or x) => q=x
	( '-', '1', 'X', '-', 'R', '0', '0', 'S' ),  -- preserve q if scl=x & sclk is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '0', 'S' ),  -- & either d & q are 0 or ce=0 & q=0
	( '-', '1', 'X', '-', 'R', '-', '-', 'X' ),  -- otherwise => q=x
	( '-', '1', '-', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '0', '0', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '-', '0', '-', '-', '0', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '0', '-', '-', '-', 'X' ),  -- scl=0 & ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '0' ),  -- scl=1 on rising sclk => q=0
	( '-', 'X', '1', '-', 'A', '-', '0', 'S' ),  -- preserve q(=0) if scl=1 & sclk is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X' ),  -- q=(1 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X' ),  -- scl=x on rising sclk & (d q != 0 0) & (ce q != 0 0) => q=x
	( '-', 'X', '-', '1', '/', '0', '-', '0' ),  -- d=0 on rising sclk => q=0
	( '-', 'X', '0', '1', 'A', '0', '-', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', '-', 'F', '-', '0', 'S' ),  -- preserve q (=0) on any possible falling edge of sclk, or
	( '-', 'X', '-', '-', 'B', '-', '0', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '0', 'S' ) );  -- a stable x clock
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
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

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, cd, sp, sclk, d),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;



--
----- cell ifs1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ifs1p3jx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3jx : ENTITY IS TRUE;

END ifs1p3jx ;

-- architecture body --
ARCHITECTURE v OF ifs1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 8) := (
 -- viol  pre  spr  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- spr=1 on rising sclk => q=1
	( '-', '1', '1', '-', 'A', '-', '1', 'S' ),  -- preserve q(=1) if spr=1 & sclk is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X' ),  -- q=(0 or x) => q=x
	( '-', '1', 'X', '-', 'R', '1', '1', 'S' ),  -- preserve q if spr=x & sclk is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '1', 'S' ),  -- & either d & q are 1 or ce=0 & q=1
	( '-', '1', 'X', '-', 'R', '-', '-', 'X' ),  -- otherwise => q=x
	( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '1', '-', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '1', '1', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '-', '0', '-', '-', '1', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '0', '-', '-', '-', 'X' ),  -- spr=0 & ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '1' ),  -- spr=1 on rising sclk => q=1
	( '-', 'X', '1', '-', 'A', '-', '1', 'S' ),  -- preserve q(=1) if spr=1 & sclk is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X' ),  -- q=(0 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X' ),  -- spr=x on rising sclk & (d q != 1 1) & (ce q != 0 1) => q=x
	( '-', 'X', '-', '1', '/', '1', '-', '1' ),  -- d=1 on rising sclk => q=1
	( '-', 'X', '0', '1', 'A', '1', '-', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', '-', 'F', '-', '1', 'S' ),  -- preserve q (=1) on any possible falling edge of sclk, or
	( '-', 'X', '-', '-', 'B', '-', '1', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '1', 'S' ) );  -- a stable x clock
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
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
 
    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, pd, sp, sclk, d),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;



--
----- cell ifs1s1b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ifs1s1b IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1b : ENTITY IS TRUE;

END ifs1s1b ;

-- architecture body --
ARCHITECTURE v OF ifs1s1b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sclk, pd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  pre  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '1' ),  -- async. preset 
	( '-', '0', '0', '-', '-', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '0', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '0', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
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

    preset := VitalOR2 (a => NOT(set_reset), b => pd);  

    vitalstatetable (statetable => latch_table,
	    datain => (violation, preset, sclk, d),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ifs1s1d -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ifs1s1d IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1d : ENTITY IS TRUE;

END ifs1s1d ;

-- architecture body --
ARCHITECTURE v OF ifs1s1d IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sclk, cd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  clr  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '0' ),  -- async. clear 
	( '-', '0', '0', '-', '-', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '0', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '0', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
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
 
    clear := VitalOR2 (a => NOT(set_reset), b => cd);  

    vitalstatetable (statetable => latch_table,
	    datain => (violation, clear, sclk, d),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;
 
END v;


--
----- cell ifs1s1i -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ifs1s1i IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1i : ENTITY IS TRUE;

END ifs1s1i ;

-- architecture body --
ARCHITECTURE v OF ifs1s1i IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, cd, sclk, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  clr  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '0' ),  -- async. clear (active low)
        ( '-', '1', '0', '-', '-', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
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

    synclr := VitalAND2 (a => d, b => NOT(cd));  

    vitalstatetable (statetable => latch_table,
	    datain => (violation, set_reset, sclk, synclr),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ifs1s1j -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ifs1s1j IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1j : ENTITY IS TRUE;

END ifs1s1j ;

-- architecture body --
ARCHITECTURE v OF ifs1s1j IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, pd, sclk, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  pre  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '1' ),  -- async. preset (active low)
        ( '-', '1', '0', '-', '-', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	

   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
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

    vitalstatetable (statetable => latch_table,
	    datain => (violation, set_reset, sclk, synpre),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ob -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY ob IS

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ob : ENTITY IS TRUE;

END ob;

-- architecture body --
ARCHITECTURE v OF ob IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i, tsallnet)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o <= VitalBUFIF1 (data => i, enable => tsallnet);

   END PROCESS;

END v;


--
----- cell obco -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY obco IS

   PORT(
      i               : IN std_logic;
      ot              : OUT std_logic;
      oc              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obco : ENTITY IS TRUE;

END obco;

-- architecture body --
ARCHITECTURE v OF obco IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      ot <= VitalBUF(i);
      oc <= VitalINV(i);

   END PROCESS;

END v;


--
----- cell obz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz IS

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz : ENTITY IS TRUE;
 
END obz;

-- architecture body --
ARCHITECTURE v OF obz IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i, t, tsallnet)

   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      o <= VitalBUFIF0 (data => i, enable => tri);

END PROCESS;

END v;



--
----- cell obzpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obzpd IS

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obzpd : ENTITY IS TRUE;

END obzpd;

-- architecture body --
ARCHITECTURE v OF obzpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i, t, tsallnet)

   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      o <= VitalBUFIF0 (data => i, enable => tri,
                         resultmap => ('U','X','0','1','L'));

   END PROCESS;

END v;


--
----- cell obzpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obzpu IS

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obzpu : ENTITY IS TRUE;
 
END obzpu;

-- architecture body --
ARCHITECTURE v OF obzpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i, t, tsallnet)

   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      o <= VitalBUFIF0 (data => i, enable => tri,
                         resultmap => ('U','X','0','1','H'));

   END PROCESS;

END v;



--
----- cell obw -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obw IS

   PORT(
      i               : IN std_logic;
      t               : IN std_logic;
      o               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obw : ENTITY IS TRUE;

END obw;

-- architecture body --
ARCHITECTURE v OF obw IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL o_int  : std_logic := 'X';
   SIGNAL b_int  : std_logic := 'L';

BEGIN

   --------------------
   --  behavior section
   --------------------

   KEEP : PROCESS (o_int)
   BEGIN
        IF (o_int'event) THEN
           IF (o_int = '1') THEN
              b_int <= 'H';
           ELSIF (o_int = '0') THEN
              b_int <= 'L';
           END IF;
        END IF;
   END PROCESS;

   o_int <= b_int;

   VitalBehavior : PROCESS (i, t, tsallnet, o_int)

   VARIABLE tri     : std_logic := 'X';

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t);
      o_int <= VitalBUFIF0 (data => i, enable => tri);
      o <= o_int;

   END PROCESS;

END v;


--
-----cell ofs1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ofs1p3bx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofs1p3bx : ENTITY IS TRUE;

END ofs1p3bx ;

-- architecture body --
ARCHITECTURE v OF ofs1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 7) := (
 -- viol  pre  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '0', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '1', '1', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '0', '-', '-', '1', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '-', '-', '-', 'X' ),  -- ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '/', '1', '-', '1' ),  -- d=1 on rising sclk => q=1
	( '-', 'X', '1', 'A', '1', '-', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', 'F', '-', '1', 'S' ),  -- preserve q (=1) on any possible falling edge of sclk, or
	( '-', 'X', '-', 'B', '-', '1', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '1', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
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

    preset := VitalOR2 (a => NOT(set_reset), b => pd);

    vitalstatetable (statetable => ff_table,
            datain => (violation, preset, sp, sclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ofs1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ofs1p3dx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofs1p3dx : ENTITY IS TRUE;

END ofs1p3dx ;

-- architecture body --
ARCHITECTURE v OF ofs1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 7) := (
 -- viol  clr  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '0', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '0', '0', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '0', '-', '-', '0', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '-', '-', '-', 'X' ),  -- ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '/', '0', '-', '0' ),  -- d=0 on rising sclk => q=0
	( '-', 'X', '1', 'A', '0', '-', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', 'F', '-', '0', 'S' ),  -- preserve q (=0) on any possible falling edge of sclk, or
	( '-', 'X', '-', 'B', '-', '0', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '0', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE clear       : std_logic := 'X';

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    clear := VitalOR2 (a => NOT(set_reset), b => cd);

    vitalstatetable (statetable => ff_table,
            datain => (violation, clear, sp, sclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ofs1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ofs1p3ix IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofs1p3ix : ENTITY IS TRUE;

END ofs1p3ix ;

-- architecture body --
ARCHITECTURE v OF ofs1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 8) := (
 -- viol  clr  scl  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- scl=1 on rising sclk => q=0
	( '-', '1', '1', '-', 'A', '-', '0', 'S' ),  -- preserve q(=0) if scl=1 & sclk is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X' ),  -- q=(1 or x) => q=x
	( '-', '1', 'X', '-', 'R', '0', '0', 'S' ),  -- preserve q if scl=x & sclk is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '0', 'S' ),  -- & either d & q are 0 or ce=0 & q=0
	( '-', '1', 'X', '-', 'R', '-', '-', 'X' ),  -- otherwise => q=x
	( '-', '1', '-', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '0', '0', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '-', '0', '-', '-', '0', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '0', '-', '-', '-', 'X' ),  -- scl=0 & ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '0' ),  -- scl=1 on rising sclk => q=0
	( '-', 'X', '1', '-', 'A', '-', '0', 'S' ),  -- preserve q(=0) if scl=1 & sclk is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X' ),  -- q=(1 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X' ),  -- scl=x on rising sclk & (d q != 0 0) & (ce q != 0 0) => q=x
	( '-', 'X', '-', '1', '/', '0', '-', '0' ),  -- d=0 on rising sclk => q=0
	( '-', 'X', '0', '1', 'A', '0', '-', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', '-', 'F', '-', '0', 'S' ),  -- preserve q (=0) on any possible falling edge of sclk, or
	( '-', 'X', '-', '-', 'B', '-', '0', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '0', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, cd, sp, sclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;



--
----- cell ofs1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofs1p3jx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofs1p3jx : ENTITY IS TRUE;

END ofs1p3jx ;

-- architecture body --
ARCHITECTURE v OF ofs1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, sclk, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 8) := (
 -- viol  pre  spr  ce   sclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- spr=1 on rising sclk => q=1
	( '-', '1', '1', '-', 'A', '-', '1', 'S' ),  -- preserve q(=1) if spr=1 & sclk is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X' ),  -- q=(0 or x) => q=x
	( '-', '1', 'X', '-', 'R', '1', '1', 'S' ),  -- preserve q if spr=x & sclk is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '1', 'S' ),  -- & either d & q are 1 or ce=0 & q=1
	( '-', '1', 'X', '-', 'R', '-', '-', 'X' ),  -- otherwise => q=x
	( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '1', '-', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '1', '1', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '-', '0', '-', '-', '1', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '0', '-', '-', '-', 'X' ),  -- spr=0 & ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '1' ),  -- spr=1 on rising sclk => q=1
	( '-', 'X', '1', '-', 'A', '-', '1', 'S' ),  -- preserve q(=1) if spr=1 & sclk is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X' ),  -- q=(0 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X' ),  -- spr=x on rising sclk & (d q != 1 1) & (ce q != 0 1) => q=x
	( '-', 'X', '-', '1', '/', '1', '-', '1' ),  -- d=1 on rising sclk => q=1
	( '-', 'X', '0', '1', 'A', '1', '-', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', '-', 'F', '-', '1', 'S' ),  -- preserve q (=1) on any possible falling edge of sclk, or
	( '-', 'X', '-', '-', 'B', '-', '1', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '1', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, pd, sp, sclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;



--
----- cell ofe1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofe1p3bx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofe1p3bx : ENTITY IS TRUE;

END ofe1p3bx ;

-- architecture body --
ARCHITECTURE v OF ofe1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 7) := (
 -- viol  pre  ce   eclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising eclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising eclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & eclk edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of eclk, and
	( '-', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of eclk, or
	( '-', '0', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '1', '1', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '0', '-', '-', '1', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '-', '-', '-', 'X' ),  -- ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '/', '1', '-', '1' ),  -- d=1 on rising eclk => q=1
	( '-', 'X', '1', 'A', '1', '-', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) eclk edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', 'F', '-', '1', 'S' ),  -- preserve q (=1) on any possible falling edge of eclk, or
	( '-', 'X', '-', 'B', '-', '1', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '1', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
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

    preset := VitalOR2 (a => NOT(set_reset), b => pd);

    vitalstatetable (statetable => ff_table,
            datain => (violation, preset, sp, eclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ofe1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ofe1p3dx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofe1p3dx : ENTITY IS TRUE;

END ofe1p3dx ;

-- architecture body --
ARCHITECTURE v OF ofe1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 25, 1 to 7) := (
 -- viol  clr  ce   eclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising eclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising eclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & eclk edge is (0->x or x->1), and
	( '-', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of eclk, and
	( '-', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '0', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of eclk, or
	( '-', '0', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '0', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '0', '0', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '0', '-', '-', '0', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '-', '-', '-', 'X' ),  -- ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '/', '0', '-', '0' ),  -- d=0 on rising eclk => q=0
	( '-', 'X', '1', 'A', '0', '-', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) eclk edge => q=x
	( '-', 'X', '1', 'R', '-', '-', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', 'F', '-', '0', 'S' ),  -- preserve q (=0) on any possible falling edge of eclk, or
	( '-', 'X', '-', 'B', '-', '0', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', 'X', '-', '0', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE clear       : std_logic := 'X';

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    clear := VitalOR2 (a => NOT(set_reset), b => cd);

    vitalstatetable (statetable => ff_table,
            datain => (violation, clear, sp, eclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ofe1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ofe1p3ix IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofe1p3ix : ENTITY IS TRUE;

END ofe1p3ix ;

-- architecture body --
ARCHITECTURE v OF ofe1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, cd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 8) := (
 -- viol  clr  scl  ce   eclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- scl=1 on rising sclk => q=0
	( '-', '1', '1', '-', 'A', '-', '0', 'S' ),  -- preserve q(=0) if scl=1 & sclk is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X' ),  -- q=(1 or x) => q=x
	( '-', '1', 'X', '-', 'R', '0', '0', 'S' ),  -- preserve q if scl=x & sclk is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '0', 'S' ),  -- & either d & q are 0 or ce=0 & q=0
	( '-', '1', 'X', '-', 'R', '-', '-', 'X' ),  -- otherwise => q=x
	( '-', '1', '-', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '0', '0', 'S' ),  -- when clr=x: preserve q(=0) if d & q are 0
	( '-', 'X', '-', '0', '-', '-', '0', 'S' ),  -- also preservce q(=0) if ce=0 & q=0
	( '-', 'X', '0', '0', '-', '-', '-', 'X' ),  -- scl=0 & ce=0 & q=(1 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '0' ),  -- scl=1 on rising sclk => q=0
	( '-', 'X', '1', '-', 'A', '-', '0', 'S' ),  -- preserve q(=0) if scl=1 & sclk is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X' ),  -- q=(1 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X' ),  -- scl=x on rising sclk & (d q != 0 0) & (ce q != 0 0) => q=x
	( '-', 'X', '-', '1', '/', '0', '-', '0' ),  -- d=0 on rising sclk => q=0
	( '-', 'X', '0', '1', 'A', '0', '-', 'X' ),  -- d=0 & q=(1 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X' ),  -- d=(1 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 0 0) => q=x
	( '-', 'X', '-', '-', 'F', '-', '0', 'S' ),  -- preserve q (=0) on any possible falling edge of sclk, or
	( '-', 'X', '-', '-', 'B', '-', '0', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '0', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, cd, sp, eclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ofe1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

ENTITY ofe1p3jx IS
    GENERIC (
        gsr             : String := "ENABLED");

    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ofe1p3jx : ENTITY IS TRUE;

END ofe1p3jx ;

-- architecture body --
ARCHITECTURE v OF ofe1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, pd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 35, 1 to 8) := (
 -- viol  pre  spr  ce   eclk  d    q  qnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- spr=1 on rising sclk => q=1
	( '-', '1', '1', '-', 'A', '-', '1', 'S' ),  -- preserve q(=1) if spr=1 & sclk is (0->x or x->1)
	( '-', '1', '1', '-', 'A', '-', '-', 'X' ),  -- q=(0 or x) => q=x
	( '-', '1', 'X', '-', 'R', '1', '1', 'S' ),  -- preserve q if spr=x & sclk is any possible rising edge
	( '-', '1', 'X', '0', 'R', '-', '1', 'S' ),  -- & either d & q are 1 or ce=0 & q=1
	( '-', '1', 'X', '-', 'R', '-', '-', 'X' ),  -- otherwise => q=x
	( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising sclk
	( '-', '1', '-', '1', '/', '1', '-', '1' ),  -- high d->q on rising sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
	( '-', '1', '0', '1', 'A', '0', '0', 'S' ),  -- if ce is 1 & sclk edge is (0->x or x->1), and
	( '-', '1', '0', '1', 'A', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', '1', 'A', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '0', 'X', 'R', '0', '0', 'S' ),  -- if ce is x on any pssible rising edge of sclk, and
	( '-', '1', '0', 'X', 'R', '1', '1', 'S' ),  -- d & q are equal, then q remains the same
	( '-', '1', '0', 'X', 'R', '-', '-', 'X' ),  -- otherwise, q becomes x
	( '-', '1', '-', '-', 'F', '-', '-', 'S' ),  -- preserve q on any possible falling edge of sclk, or
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', '1', '-', '-', 'X', '-', '-', 'S' ),  -- a stable x clock
	( '-', 'X', '-', '-', '-', '1', '1', 'S' ),  -- when pre=x: preserve q(=1) if d & q are 1
	( '-', 'X', '-', '0', '-', '-', '1', 'S' ),  -- also preservce q(=1) if ce=0 & q=1
	( '-', 'X', '0', '0', '-', '-', '-', 'X' ),  -- spr=0 & ce=0 & q=(0 or x) => q=x
	( '-', 'X', '1', '-', '/', '-', '-', '1' ),  -- spr=1 on rising sclk => q=1
	( '-', 'X', '1', '-', 'A', '-', '1', 'S' ),  -- preserve q(=1) if spr=1 & sclk is (0->x or x->1)
	( '-', 'X', '1', '-', 'A', '-', '-', 'X' ),  -- q=(0 or x) => q=x
	( '-', 'X', 'X', '-', 'R', '-', '-', 'X' ),  -- spr=x on rising sclk & (d q != 1 1) & (ce q != 0 1) => q=x
	( '-', 'X', '-', '1', '/', '1', '-', '1' ),  -- d=1 on rising sclk => q=1
	( '-', 'X', '0', '1', 'A', '1', '-', 'X' ),  -- d=1 & q=(0 or x) on (0->x or x->1) sclk edge => q=x
	( '-', 'X', '0', '1', 'R', '-', '-', 'X' ),  -- d=(0 or x) on any possible rising edge => q=x
	( '-', 'X', '0', 'X', 'R', '-', '-', 'X' ),  -- ce=x on any possible rising edge (d q != 1 1) => q=x
	( '-', 'X', '-', '-', 'F', '-', '1', 'S' ),  -- preserve q (=1) on any possible falling edge of sclk, or
	( '-', 'X', '-', '-', 'B', '-', '1', 'S' ),  -- a stable 0 or 1 clock, or
	( '-', 'X', '-', '-', 'X', '-', '1', 'S' ) );  -- a stable x clock
	

   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, pd, sp, eclk, d),
            numstates => 1,
            result => results,
            previousdatain => prevdata);

    q <= q_zd;

   END PROCESS;

END v;


--
----- cell ilvds -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY ilvds IS

   PORT(
      a               : IN std_logic;
      an              : IN std_logic;
      z               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilvds : ENTITY IS TRUE;

END ilvds;

-- architecture body --
ARCHITECTURE v OF ilvds IS
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
      z <= VitalBUF(a);

   END PROCESS;

END v;


--
----- cell olvds -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY olvds IS

   PORT(
      a               : IN std_logic;
      z               : OUT std_logic;
      zn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF olvds : ENTITY IS TRUE;

END olvds;

-- architecture body --
ARCHITECTURE v OF olvds IS
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
      z <= VitalBUF(a);
      zn <= VitalINV(a);

   END PROCESS;

END v;

