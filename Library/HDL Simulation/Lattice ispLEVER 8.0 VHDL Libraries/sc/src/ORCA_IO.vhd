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
-- $Header: /home/rel01/env5_1a.34/vhdl/pkg/vhdsclibs/data/orca5/src/RCS/ORCA_IO.vhd,v 1.22 2005/05/31 21:31:58 pradeep Exp $ 
--
 
--
----- package mem4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE mem4 IS
   FUNCTION conv_c_del (str: in string) RETURN time;
   FUNCTION conv_f_del (str: in string) RETURN time;
END mem4;

PACKAGE BODY mem4 IS

   FUNCTION conv_c_del (str : in string) return time is
        VARIABLE result : time;
   BEGIN
      IF (str = "CDEL0") THEN
         result := 0 ns;
      ELSIF (str = "CDEL1") THEN
         result := 0.672 ns;
      ELSIF (str = "CDEL2") THEN
         result := (2 * 0.672 ns);
      ELSIF (str = "CDEL3") THEN
         result := (3 * 0.672 ns);
      END IF;
      RETURN result;
   END;

   FUNCTION conv_f_del (str : in string) return time is
        VARIABLE result : time;
   BEGIN
      IF (str = "FDEL0") THEN
         result := 0 ns;
      ELSIF (str = "FDEL1") THEN
         result := 0.021 ns;
      ELSIF (str = "FDEL2") THEN
         result := (2 * 0.021 ns);
      ELSIF (str = "FDEL3") THEN
         result := (3 * 0.021 ns);
      ELSIF (str = "FDEL4") THEN
         result := (4 * 0.021 ns);
      ELSIF (str = "FDEL5") THEN
         result := (5 * 0.021 ns);
      ELSIF (str = "FDEL6") THEN
         result := (6 * 0.021 ns);
      ELSIF (str = "FDEL7") THEN
         result := (7 * 0.021 ns);
      ELSIF (str = "FDEL8") THEN
         result := (8 * 0.021 ns);
      ELSIF (str = "FDEL9") THEN
         result := (9 * 0.021 ns);
      ELSIF (str = "FDEL10") THEN
         result := (10 * 0.021 ns);
      ELSIF (str = "FDEL11") THEN
         result := (11 * 0.021 ns);
      ELSIF (str = "FDEL12") THEN
         result := (12 * 0.021 ns);
      ELSIF (str = "FDEL13") THEN
         result := (13 * 0.021 ns);
      ELSIF (str = "FDEL14") THEN
         result := (14 * 0.021 ns);
      ELSIF (str = "FDEL15") THEN
         result := (15 * 0.021 ns);
      ELSIF (str = "FDEL16") THEN
         result := (16 * 0.021 ns);
      ELSIF (str = "FDEL17") THEN
         result := (17 * 0.021 ns);
      ELSIF (str = "FDEL18") THEN
         result := (18 * 0.021 ns);
      ELSIF (str = "FDEL19") THEN
         result := (19 * 0.021 ns);
      ELSIF (str = "FDEL20") THEN
         result := (20 * 0.021 ns);
      ELSIF (str = "FDEL21") THEN
         result := (21 * 0.021 ns);
      ELSIF (str = "FDEL22") THEN
         result := (22 * 0.021 ns);
      ELSIF (str = "FDEL23") THEN
         result := (23 * 0.021 ns);
      ELSIF (str = "FDEL24") THEN
         result := (24 * 0.021 ns);
      ELSIF (str = "FDEL25") THEN
         result := (25 * 0.021 ns);
      ELSIF (str = "FDEL26") THEN
         result := (26 * 0.021 ns);
      ELSIF (str = "FDEL27") THEN
         result := (27 * 0.021 ns);
      ELSIF (str = "FDEL28") THEN
         result := (28 * 0.021 ns);
      ELSIF (str = "FDEL29") THEN
         result := (29 * 0.021 ns);
      ELSIF (str = "FDEL30") THEN
         result := (30 * 0.021 ns);
      ELSIF (str = "FDEL31") THEN
         result := (31 * 0.021 ns);
      ELSIF (str = "FDEL32") THEN
         result := (32 * 0.021 ns);
      ELSIF (str = "FDEL33") THEN
         result := (33 * 0.021 ns);
      ELSIF (str = "FDEL34") THEN
         result := (34 * 0.021 ns);
      ELSIF (str = "FDEL35") THEN
         result := (35 * 0.021 ns);
      ELSIF (str = "FDEL36") THEN
         result := (36 * 0.021 ns);
      ELSIF (str = "FDEL37") THEN
         result := (37 * 0.021 ns);
      ELSIF (str = "FDEL38") THEN
         result := (38 * 0.021 ns);
      ELSIF (str = "FDEL39") THEN
         result := (39 * 0.021 ns);
      ELSIF (str = "FDEL40") THEN
         result := (40 * 0.021 ns);
      ELSIF (str = "FDEL41") THEN
         result := (41 * 0.021 ns);
      ELSIF (str = "FDEL42") THEN
         result := (42 * 0.021 ns);
      ELSIF (str = "FDEL43") THEN
         result := (43 * 0.021 ns);
      ELSIF (str = "FDEL44") THEN
         result := (44 * 0.021 ns);
      ELSIF (str = "FDEL45") THEN
         result := (45 * 0.021 ns);
      ELSIF (str = "FDEL46") THEN
         result := (46 * 0.021 ns);
      ELSIF (str = "FDEL47") THEN
         result := (47 * 0.021 ns);
      END IF;
      RETURN result;
   END;


END mem4 ;

 
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
      tsalln           : IN std_logic := 'Z');

END tsall;
 
-- architecture body --
ARCHITECTURE v OF tsall IS
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   tsallnet <= tsalln;
 
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
----- ilf2p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3bx IS
    GENERIC (
        gsr             : String := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic; 
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3bx : ENTITY IS TRUE;

END ilf2p3bx ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, sclk, pd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock low
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on rising edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on rising edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   clk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck

	( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
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
            datain => (violation, eclk, d),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, preset, sp, sclk, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    q <= q_zd;

END PROCESS;
 
END v;


--
----- ilf2p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3dx IS
    GENERIC (
        gsr             : String := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3dx : ENTITY IS TRUE;

END ilf2p3dx ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, sclk, cd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
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

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk, d),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, clear, sp, sclk, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    q <= q_zd;

END PROCESS;
 
END v;


--
----- ilf2p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3ix IS
    GENERIC (
        gsr             : String := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3ix : ENTITY IS TRUE;

END ilf2p3ix ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, sclk, cd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  clr  scl  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- sync. clear
	( '-', '1', '-', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '-', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '-', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr      : std_logic := 'X';
 
   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk, d),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, cd, sp, sclk, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    q <= q_zd;

END PROCESS;
 
END v;


--
----- ilf2p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3iz IS
    GENERIC (
        gsr             : String := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3iz : ENTITY IS TRUE;

END ilf2p3iz ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, sclk, cd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on faling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on faling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr1     : std_logic := 'X';
   VARIABLE synclr2     : std_logic := 'X';
 
   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk, d),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    synclr2 := VitalAND2 (a => latched(1), b => NOT(cd));

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, sp, sclk, synclr2),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    q <= q_zd;

END PROCESS;
 
END v;


--
----- ilf2p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3jx IS
    GENERIC (
        gsr             : String := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3jx : ENTITY IS TRUE;

END ilf2p3jx ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, sclk, pd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  pre  spr  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- sync. preset
	( '-', '1', '-', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '-', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '-', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre      : std_logic := 'X';
 
   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk, d),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, pd, sp, sclk, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    q <= q_zd;

END PROCESS;
 
END v;


--
----- ilf2p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3jz IS
    GENERIC (
        gsr             : String := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3jz : ENTITY IS TRUE;

END ilf2p3jz ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d, sp, eclk, sclk, pd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre1     : std_logic := 'X';
   VARIABLE synpre2     : std_logic := 'X';
 
   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk, d),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    synpre2 := VitalOR2 (a => latched(1), b => pd);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, sp, sclk, synpre2),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

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
----- ofs1p3dx -----
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
----- ofs1p3ix -----
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
----- ofs1p3jx -----
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
----- ofe1p3dx -----
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
----- ofe1p3ix -----
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
----- ofe1p3jx -----
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
----- cell clkdiv -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
 
-- entity declaration --
ENTITY clkdiv IS
   GENERIC(
      gsr                  : String := "ENABLED";
      div                  : Integer := 1);
 
   PORT(
      clki, lsr            :   IN   std_logic;
      clko, elsr           :   OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF clkdiv : ENTITY IS TRUE;
 
END clkdiv;
 
-- architecture body --
ARCHITECTURE v OF clkdiv IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL div_reg     : Integer   := 0;
   SIGNAL elsr_int0   : std_logic := '1';
   SIGNAL elsr_int1   : std_logic := '1';
   SIGNAL elsr_int2   : std_logic := '1';
   SIGNAL q0          : std_logic := '0';
   SIGNAL q1          : std_logic := '0';
   SIGNAL q2          : std_logic := '0';
   SIGNAL q3          : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   div_reg <= div;

   P1 : PROCESS (clki, gsrnet, purnet)
   VARIABLE set_reset : std_logic := '1';
   VARIABLE reset : std_logic := 'X';
   BEGIN
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    reset := VitalOR2 (a => NOT(set_reset), b => lsr);

      IF (clki'event and clki = '1') THEN
            elsr_int0 <= reset;
            elsr_int1 <= elsr_int0;
            elsr_int2 <= elsr_int1;
      END IF;
   END PROCESS;

   P2 : PROCESS (clki)
   BEGIN
      IF (clki'event and clki = '1') THEN
         IF (elsr_int2 = '1') THEN
            IF (div_reg = 2) THEN
               q0 <= '1';
               q1 <= '0';
               q2 <= '1';
               q3 <= '0';
            ELSIF (div_reg = 4) THEN
               q0 <= '0';
               q1 <= '0';
               q2 <= '1';
               q3 <= '1';
            END IF;
         ELSE 
            q0 <= q3;
            q1 <= q0;
            q2 <= q1;
            q3 <= q2;
         END IF;
      END IF;
   END PROCESS;


   VitalBehavior : PROCESS (q3, clki, elsr_int2)
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      IF (div_reg = 1) THEN
         clko <= clki;
      ELSE
         clko <= q3;
      END IF;
         
      elsr <= VitalBUF(elsr_int2);
 
END PROCESS;
 
END v;
 
 
--
----- cell isrx1a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY isrx1a IS
    GENERIC (
        AILRST          : string := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        q               : OUT std_logic;
        update               : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF isrx1a : ENTITY IS TRUE;

END isrx1a ;
-- architecture body --
ARCHITECTURE v OF isrx1a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL q_int   : std_logic := '0';
    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   update <= '0';

   P1 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (q_int /= d) THEN
            q_int <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '0' and clk = '1') THEN
         IF (rst = '1') THEN
            q_int <= '0';
         ELSIF (rst = '0') THEN
            q_int <= d;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (d, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail = '1') THEN
            IF (data_count < 3) THEN
               data_count <= data_count + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (clk, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (clk'event and clk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (clk'event and clk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (q_int, lock_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= VitalBUF(q_int);
      lock <= VitalBUF(lock_int);

END PROCESS;
 
END v;


--
----- cell isrx2a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY isrx2a IS
    GENERIC (
        AILRST          : string := "ENABLED";
        lsrmode 	: string := "LOCAL";
        updt 	        : string := "POS");
 
    PORT (
        d               : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail             : IN std_logic;
        q0              : OUT std_logic;
        q1              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF isrx2a : ENTITY IS TRUE;

END isrx2a ;
 
-- architecture body --
ARCHITECTURE v OF isrx2a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL q0_int   : std_logic := '0';
    SIGNAL q1_int   : std_logic := '0';
    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL d_int0   : std_logic := '0';
    SIGNAL d_int1   : std_logic := '0';
    SIGNAL d_int2   : std_logic := '0';
    SIGNAL d_int3   : std_logic := '0';
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '1';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;
 
   P20 : PROCESS (d, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail = '1') THEN
            IF (data_count < 3) THEN
               data_count <= data_count + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P21 : PROCESS (eclk, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

  -------------------------------------------------------------
  --  Shift Generation
  -------------------------------------------------------------
   P7 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (d_int0 /= d) THEN
            d_int0 <= 'X';
         END IF;
         IF (d_int1 /= d_int0) THEN
            d_int1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            d_int0 <= '0';
            d_int1 <= '0';
         ELSE
            d_int0 <= d;
            d_int1 <= d_int0;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (d_int2 /= d_int0) THEN
            d_int2 <= 'X';
         END IF;
         IF (d_int3 /= d_int1) THEN
            d_int3 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            d_int2 <= '0';
            d_int3 <= '0';
         ELSE
            IF (up_pos = '1') THEN
               d_int2 <= d_int0;
               d_int3 <= d_int1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (sclk)
   BEGIN
      IF (sclk = 'X') THEN
         IF (q0_int /= d_int3) THEN
            q0_int <= 'X';
         END IF;
         IF (q1_int /= d_int2) THEN
            q1_int <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            q0_int <= '0';
            q1_int <= '0';
         ELSE
            q0_int <= d_int3;
            q1_int <= d_int2;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (q0_int, q1_int, update_int, lock_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q0 <= VitalBUF(q0_int);
      q1 <= VitalBUF(q1_int);
      update <= VitalBUF(update_int);
      lock <= VitalBUF(lock_int);

END PROCESS;
 
END v;


--
----- cell isrx4a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY isrx4a IS
    GENERIC (
        AILRST          : string := "ENABLED";
        lsrmode 	: string := "LOCAL";
        updt 	        : string := "POS");
 
    PORT (
        d               : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail             : IN std_logic;
        q0              : OUT std_logic;
        q1              : OUT std_logic;
        q2              : OUT std_logic;
        q3              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF isrx4a : ENTITY IS TRUE;

END isrx4a ;
 
-- architecture body --
ARCHITECTURE v OF isrx4a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL q0_int   : std_logic := '0';
    SIGNAL q1_int   : std_logic := '0';
    SIGNAL q2_int   : std_logic := '0';
    SIGNAL q3_int   : std_logic := '0';
    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL d_int0   : std_logic := '0';
    SIGNAL d_int1   : std_logic := '0';
    SIGNAL d_int2   : std_logic := '0';
    SIGNAL d_int3   : std_logic := '0';
    SIGNAL d_int4   : std_logic := '0';
    SIGNAL d_int5   : std_logic := '0';
    SIGNAL d_int6   : std_logic := '0';
    SIGNAL d_int7   : std_logic := '0';
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '0';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;
 
   P20 : PROCESS (d, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail = '1') THEN
            IF (data_count < 3) THEN
               data_count <= data_count + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P21 : PROCESS (eclk, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

  -------------------------------------------------------------
  --  Shift Generation
  -------------------------------------------------------------
   P7 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (d_int0 /= d) THEN
            d_int0 <= 'X';
         END IF;
         IF (d_int1 /= d_int0) THEN
            d_int1 <= 'X';
         END IF;
         IF (d_int2 /= d_int1) THEN
            d_int2 <= 'X';
         END IF;
         IF (d_int3 /= d_int2) THEN
            d_int3 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            d_int0 <= '0';
            d_int1 <= '0';
            d_int2 <= '0';
            d_int3 <= '0';
         ELSE
            d_int0 <= d;
            d_int1 <= d_int0;
            d_int2 <= d_int1;
            d_int3 <= d_int2;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (d_int4 /= d_int0) THEN
            d_int4 <= 'X';
         END IF;
         IF (d_int5 /= d_int1) THEN
            d_int5 <= 'X';
         END IF;
         IF (d_int6 /= d_int2) THEN
            d_int6 <= 'X';
         END IF;
         IF (d_int7 /= d_int3) THEN
            d_int7 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            d_int4 <= '0';
            d_int5 <= '0';
            d_int6 <= '0';
            d_int7 <= '0';
         ELSE
            IF (up_pos = '1') THEN
               d_int4 <= d_int0;
               d_int5 <= d_int1;
               d_int6 <= d_int2;
               d_int7 <= d_int3;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (sclk)
   BEGIN
      IF (sclk = 'X') THEN
         IF (q0_int /= d_int7) THEN
            q0_int <= 'X';
         END IF;
         IF (q1_int /= d_int6) THEN
            q1_int <= 'X';
         END IF;
         IF (q2_int /= d_int5) THEN
            q2_int <= 'X';
         END IF;
         IF (q3_int /= d_int4) THEN
            q3_int <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            q0_int <= '0';
            q1_int <= '0';
            q2_int <= '0';
            q3_int <= '0';
         ELSE
            q0_int <= d_int7;
            q1_int <= d_int6;
            q2_int <= d_int5;
            q3_int <= d_int4;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (q0_int, q1_int, q2_int, q3_int, update_int, lock_int)

   BEGIN

    -- functionality section.
    -----------------------------------
      q0 <= VitalBUF(q0_int);
      q1 <= VitalBUF(q1_int);
      q2 <= VitalBUF(q2_int);
      q3 <= VitalBUF(q3_int);
      update <= VitalBUF(update_int);
      lock <= VitalBUF(lock_int);

END PROCESS;
 
END v; 



--
----- cell iddra -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY iddra IS
    GENERIC (
        AILRST	        : string := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF iddra : ENTITY IS TRUE;

END iddra ;
 
-- architecture body --
ARCHITECTURE v OF iddra IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL qa_int  : std_logic := '0';
    SIGNAL qb_int  : std_logic := '0';
    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   update <= '0';

   P1 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (qa_int /= d) THEN
            qa_int <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '0' and clk = '1') THEN
         IF (rst = '1') THEN
            qa_int <= '0';
         ELSIF (rst = '0') THEN
            qa_int <= d;
         END IF;
      END IF;
   END PROCESS;

   P2 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (qb_int /= d) THEN
            qb_int <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '1' and clk = '0') THEN
         IF (rst = '1') THEN
            qb_int <= '0';
         ELSIF (rst = '0') THEN
            qb_int <= d;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (d, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail = '1') THEN
            IF (data_count < 3) THEN 
               data_count <= data_count + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;
 
   P4 : PROCESS (clk, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (clk'event and clk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN 
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN 
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (clk'event and clk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN 
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN 
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;
 

   VitalBehavior : PROCESS (qa_int, qb_int, lock_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa <= VitalBUF(qa_int);
      qb <= VitalBUF(qb_int);
      lock <= VitalBUF(lock_int);

END PROCESS;
 
END v;



--
----- cell iddrxa -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY iddrxa IS
    GENERIC (
        AILRST          : string := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        clk              : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail             : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF iddrxa : ENTITY IS TRUE;

END iddrxa ;
 
-- architecture body --
ARCHITECTURE v OF iddrxa IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL qa_int  : std_logic := '0';
    SIGNAL qb_int  : std_logic := '0';
    SIGNAL q2_int  : std_logic := '0';
    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   update <= '0';

   P1 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (qa_int /= d) THEN
            qa_int <= 'X';
         END IF;
         IF (q2_int /= qb_int) THEN
            q2_int <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '0' and clk = '1') THEN
         IF (rst = '1') THEN
            qa_int <= '0';
            q2_int <= '0';
         ELSIF (rst = '0') THEN
            qa_int <= d;
            q2_int <= qb_int;
         END IF;
      END IF;
   END PROCESS;

   P2 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (qb_int /= d) THEN
            qb_int <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '1' and clk = '0') THEN
         IF (rst = '1') THEN
            qb_int <= '0';
         ELSIF (rst = '0') THEN
            qb_int <= d;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (d, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail = '1') THEN
            IF (data_count < 3) THEN
               data_count <= data_count + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;
   P4 : PROCESS (clk, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (clk'event and clk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (clk'event and clk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (qa_int, q2_int, lock_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa <= VitalBUF(qa_int);
      qb <= VitalBUF(q2_int);
      lock <= VitalBUF(lock_int);

END PROCESS;
 
END v;



--
----- cell iddrx1a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY iddrx1a IS
    GENERIC (
        AILRST          : string := "ENABLED");
 
    PORT (
        d               : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail             : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic;
        update              : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF iddrx1a : ENTITY IS TRUE;

END iddrx1a ;
 
-- architecture body --
ARCHITECTURE v OF iddrx1a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL qp0_int : std_logic := '0';
    SIGNAL qp1_int : std_logic := '0';
    SIGNAL qp2_int : std_logic := '0';
    SIGNAL qn0_int : std_logic := '0';
    SIGNAL qn1_int : std_logic := '0';
    SIGNAL qn2_int : std_logic := '0';
    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   update <= '0';

   P1 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (qp0_int /= d) THEN
            qp0_int <= 'X';
         END IF;
         IF (qp1_int /= qp0_int) THEN
            qp1_int <= 'X';
         END IF;
         IF (qn1_int /= qn0_int) THEN
            qn1_int <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            qp0_int <= '0';
            qp1_int <= '0';
            qn1_int <= '0';
         ELSIF (rst = '0') THEN
            qp0_int <= d;
            qp1_int <= qp0_int;
            qn1_int <= qn0_int;
         END IF;
      END IF;
   END PROCESS;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (qn0_int /= d) THEN
            qn0_int <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '1' and eclk = '0') THEN
         IF (rst = '1') THEN
            qn0_int <= '0';
         ELSIF (rst = '0') THEN
            qn0_int <= d;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (sclk)
   BEGIN
      IF (sclk = 'X') THEN
         IF (qp2_int /= qp1_int) THEN
            qp2_int <= 'X';
         END IF;
         IF (qn2_int /= qn1_int) THEN
            qn2_int <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            qp2_int <= '0';
            qn2_int <= '0';
         ELSIF (rst = '0') THEN
            qp2_int <= qp1_int;
            qn2_int <= qn1_int;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (d, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail = '1') THEN
            IF (data_count < 3) THEN
               data_count <= data_count + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (eclk, rstail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (qp2_int, qn2_int, lock_int)

   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa <= VitalBUF(qp2_int);
      qb <= VitalBUF(qn2_int);
      lock <= VitalBUF(lock_int);

END PROCESS;
 
END v;



--
----- cell iddrx2a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY iddrx2a IS
    GENERIC (
        AILRST          : string := "ENABLED";
        lsrmode         : string := "LOCAL";
        updt            : string := "POS");
 
    PORT (
        d               : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail             : IN std_logic;
        qa0              : OUT std_logic;
        qb0              : OUT std_logic;
        qa1              : OUT std_logic;
        qb1              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF iddrx2a : ENTITY IS TRUE;

END iddrx2a ;
 
-- architecture body --
ARCHITECTURE v OF iddrx2a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL QP0      : std_logic := '0';
    SIGNAL QN0      : std_logic := '0';
    SIGNAL QP1      : std_logic := '0';
    SIGNAL QN1      : std_logic := '0';
    SIGNAL Q0P2     : std_logic := '0';
    SIGNAL Q1P2     : std_logic := '0';
    SIGNAL Q0N2     : std_logic := '0';
    SIGNAL Q1N2     : std_logic := '0';
    SIGNAL Q0P3     : std_logic := '0';
    SIGNAL Q1P3     : std_logic := '0';
    SIGNAL Q0N3     : std_logic := '0';
    SIGNAL Q1N3     : std_logic := '0';
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '1';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;

   P20 : PROCESS (d, rstail, runail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1' or (runail'event and runail'last_value = '0' and runail = '1')) THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail'event and runail'last_value = '0' and runail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P21 : PROCESS (eclk, rstail, runail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1' or (runail'event and runail'last_value = '0' and runail = '1')) THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail'event and runail'last_value = '0' and runail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSE
            IF (eclk'event and eclk = '1') THEN
               IF (runail = '1') THEN
                  IF (lock_count < 32) THEN
                     lock_int <= '0';
                     lock_count <= lock_count + 1;
                  ELSIF (lock_count >= 32) THEN
                     IF (data_count >= 1) THEN
                        lock_int <= '1';
                     END IF;
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

  -------------------------------------------------------------
  --  Shift Generation
  -------------------------------------------------------------
   P7 : PROCESS (eclk)   -- posedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (QP0 /= d) THEN
            QP0 <= 'X';
         END IF;
         IF (QP1 /= QP0) THEN
            QP1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            QP0 <= '0';
            QP1 <= '0';
         ELSE
            QP0 <= d;
            QP1 <= QP0;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)   -- negedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (QN0 /= d) THEN
            QN0 <= 'X';
         END IF;
         IF (QN1 /= QN0) THEN
            QN1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '1' and eclk = '0') THEN
         IF (rst = '1') THEN
            QN0 <= '0';
            QN1 <= '0';
         ELSE
            QN0 <= d;
            QN1 <= QN0;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (eclk)   -- posedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P2 /= QP0) THEN
            Q0P2 <= 'X';
         END IF;
         IF (Q1P2 /= QP1) THEN
            Q1P2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            Q0P2 <= '0';
            Q1P2 <= '0';
         ELSE
            IF (up_pos = '1') THEN
               Q0P2 <= QP0;
               Q1P2 <= QP1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (eclk)   -- negedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0N2 /= QN0) THEN
            Q0N2 <= 'X';
         END IF;
         IF (Q1N2 /= QN1) THEN
            Q1N2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '1' and eclk = '0') THEN
         IF (rst = '1') THEN
            Q0N2 <= '0';
            Q1N2 <= '0';
         ELSE
            IF (up_neg = '1') THEN
               Q0N2 <= QN0;
               Q1N2 <= QN1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P11 : PROCESS (sclk)   -- posedge
   BEGIN
      IF (sclk = 'X') THEN
         IF (Q0P3 /= Q0P2) THEN
            Q0P3 <= 'X';
         END IF;
         IF (Q1P3 /= Q1P2) THEN
            Q1P3 <= 'X';
         END IF;
         IF (Q0N3 /= Q0N2) THEN
            Q0N3 <= 'X';
         END IF;
         IF (Q1N3 /= Q1N2) THEN
            Q1N3 <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            Q0P3 <= '0';
            Q1P3 <= '0';
            Q0N3 <= '0';
            Q1N3 <= '0';
         ELSE
            Q0P3 <= Q0P2;
            Q1P3 <= Q1P2;
            Q0N3 <= Q0N2;
            Q1N3 <= Q1N2;
         END IF;
      END IF;
   END PROCESS;


   VitalBehavior : PROCESS (Q0P3, Q1P3, Q0N3, Q1N3, update_int, lock_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa0 <= VitalBUF(Q1N3);
      qa1 <= VitalBUF(Q0N3);
      qb0 <= VitalBUF(Q1P3);
      qb1 <= VitalBUF(Q0P3);
      lock <= VitalBUF(lock_int);
      update <= VitalBUF(update_int);

END PROCESS;
 
END v;



--
----- cell iddrx4a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY iddrx4a IS
    GENERIC (
        AILRST          : string := "ENABLED";
        lsrmode         : string := "LOCAL";
        updt            : string := "POS");
 
    PORT (
        d               : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail             : IN std_logic;
        qa0              : OUT std_logic;
        qb0              : OUT std_logic;
        qa1              : OUT std_logic;
        qb1              : OUT std_logic;
        qa2              : OUT std_logic;
        qb2              : OUT std_logic;
        qa3              : OUT std_logic;
        qb3              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF iddrx4a : ENTITY IS TRUE;

END iddrx4a ;
 
-- architecture body --
ARCHITECTURE v OF iddrx4a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL lock_int   : std_logic := '0';
    SIGNAL lock_sig   : std_logic := '0';
    SIGNAL lock_count : Integer := 0;
    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL QP0      : std_logic := '0';
    SIGNAL QN0      : std_logic := '0';
    SIGNAL Q0P1     : std_logic := '0';
    SIGNAL Q1P1     : std_logic := '0';
    SIGNAL Q2P1     : std_logic := '0';
    SIGNAL Q0N1     : std_logic := '0';
    SIGNAL Q1N1     : std_logic := '0';
    SIGNAL Q2N1     : std_logic := '0';
    SIGNAL Q0P2     : std_logic := '0';
    SIGNAL Q1P2     : std_logic := '0';
    SIGNAL Q2P2     : std_logic := '0';
    SIGNAL Q3P2     : std_logic := '0';
    SIGNAL Q0N2     : std_logic := '0';
    SIGNAL Q1N2     : std_logic := '0';
    SIGNAL Q2N2     : std_logic := '0';
    SIGNAL Q3N2     : std_logic := '0';
    SIGNAL Q0P3     : std_logic := '0';
    SIGNAL Q1P3     : std_logic := '0';
    SIGNAL Q2P3     : std_logic := '0';
    SIGNAL Q3P3     : std_logic := '0';
    SIGNAL Q0N3     : std_logic := '0';
    SIGNAL Q1N3     : std_logic := '0';
    SIGNAL Q2N3     : std_logic := '0';
    SIGNAL Q3N3     : std_logic := '0';
    SIGNAL data_count : Integer := 0;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '0';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;

   P20 : PROCESS (d, rstail, runail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1' or (runail'event and runail'last_value = '0' and runail = '1')) THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail'event and runail'last_value = '0' and runail = '1') THEN
            data_count <= 0;
         ELSE
            IF (runail = '1') THEN
               IF (data_count < 3) THEN
                  data_count <= data_count + 1;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P21 : PROCESS (eclk, rstail, runail)
   BEGIN
      IF (AILRST = "ENABLED") THEN
         IF (rstail = '1' or (runail'event and runail'last_value = '0' and runail = '1')) THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSIF (eclk'event and eclk = '1') THEN
            IF (runail = '1') THEN
               IF (lock_count < 32) THEN
                  lock_int <= '0';
                  lock_count <= lock_count + 1;
               ELSIF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            ELSIF (runail = '0') THEN
               IF (lock_count >= 32) THEN
                  IF (data_count >= 1) THEN
                     lock_int <= '1';
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF (runail'event and runail'last_value = '0' and runail = '1') THEN
            lock_int <= '0';
            lock_count <= 0;
         ELSE
            IF (eclk'event and eclk = '1') THEN
               IF (runail = '1') THEN
                  IF (lock_count < 32) THEN
                     lock_int <= '0';
                     lock_count <= lock_count + 1;
                  ELSIF (lock_count >= 32) THEN
                     IF (data_count >= 1) THEN
                        lock_int <= '1';
                     END IF;
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

  -------------------------------------------------------------
  --  Shift Generation
  -------------------------------------------------------------
   P7 : PROCESS (eclk)   -- posedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (QP0 /= d) THEN
            QP0 <= 'X';
         END IF;
         IF (Q0P1 /= QP0) THEN
            Q0P1 <= 'X';
         END IF;
         IF (Q1P1 /= Q0P1) THEN
            Q1P1 <= 'X';
         END IF;
         IF (Q2P1 /= Q1P1) THEN
            Q2P1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            QP0 <= '0';
            Q0P1 <= '0';
            Q1P1 <= '0';
            Q2P1 <= '0';
         ELSE
            QP0 <= d;
            Q0P1 <= QP0;
            Q1P1 <= Q0P1;
            Q2P1 <= Q1P1;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)   -- negedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (QN0 /= d) THEN
            QN0 <= 'X';
         END IF;
         IF (Q0N1 /= QN0) THEN
            Q0N1 <= 'X';
         END IF;
         IF (Q1N1 /= Q0N1) THEN
            Q1N1 <= 'X';
         END IF;
         IF (Q2N1 /= Q1N1) THEN
            Q2N1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '1' and eclk = '0') THEN
         IF (rst = '1') THEN
            QN0 <= '0';
            Q0N1 <= '0';
            Q1N1 <= '0';
            Q2N1 <= '0';
         ELSE
            QN0 <= d;
            Q0N1 <= QN0;
            Q1N1 <= Q0N1;
            Q2N1 <= Q1N1;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (eclk)   -- posedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P2 /= QP0) THEN
            Q0P2 <= 'X';
         END IF;
         IF (Q1P2 /= Q0P1) THEN
            Q1P2 <= 'X';
         END IF;
         IF (Q2P2 /= Q1P1) THEN
            Q2P2 <= 'X';
         END IF;
         IF (Q3P2 /= Q2P1) THEN
            Q3P2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            Q0P2 <= '0';
            Q1P2 <= '0';
            Q2P2 <= '0';
            Q3P2 <= '0';
         ELSE
            IF (up_pos = '1') THEN
               Q0P2 <= QP0;
               Q1P2 <= Q0P1;
               Q2P2 <= Q1P1;
               Q3P2 <= Q2P1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (eclk)   -- negedge
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0N2 /= QN0) THEN
            Q0N2 <= 'X';
         END IF;
         IF (Q1N2 /= Q0N1) THEN
            Q1N2 <= 'X';
         END IF;
         IF (Q2N2 /= Q1N1) THEN
            Q2N2 <= 'X';
         END IF;
         IF (Q3N2 /= Q2N1) THEN
            Q3N2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '1' and eclk = '0') THEN
         IF (rst = '1') THEN
            Q0N2 <= '0';
            Q1N2 <= '0';
            Q2N2 <= '0';
            Q3N2 <= '0';
         ELSE
            IF (up_neg = '1') THEN
               Q0N2 <= QN0;
               Q1N2 <= Q0N1;
               Q2N2 <= Q1N1;
               Q3N2 <= Q2N1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P11 : PROCESS (sclk)   -- posedge
   BEGIN
      IF (sclk = 'X') THEN
         IF (Q0P3 /= Q0P2) THEN
            Q0P3 <= 'X';
         END IF;
         IF (Q1P3 /= Q1P2) THEN
            Q1P3 <= 'X';
         END IF;
         IF (Q2P3 /= Q2P2) THEN
            Q2P3 <= 'X';
         END IF;
         IF (Q3P3 /= Q3P2) THEN
            Q3P3 <= 'X';
         END IF;
         IF (Q0N3 /= Q0N2) THEN
            Q0N3 <= 'X';
         END IF;
         IF (Q1N3 /= Q1N2) THEN
            Q1N3 <= 'X';
         END IF;
         IF (Q2N3 /= Q2N2) THEN
            Q2N3 <= 'X';
         END IF;
         IF (Q3N3 /= Q3N2) THEN
            Q3N3 <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            Q0P3 <= '0';
            Q1P3 <= '0';
            Q2P3 <= '0';
            Q3P3 <= '0';
            Q0N3 <= '0';
            Q1N3 <= '0';
            Q2N3 <= '0';
            Q3N3 <= '0';
         ELSE
            Q0P3 <= Q0P2;
            Q1P3 <= Q1P2;
            Q2P3 <= Q2P2;
            Q3P3 <= Q3P2;
            Q0N3 <= Q0N2;
            Q1N3 <= Q1N2;
            Q2N3 <= Q2N2;
            Q3N3 <= Q3N2;
         END IF;
      END IF;
   END PROCESS;


   VitalBehavior : PROCESS (Q0P3, Q1P3, Q2P3, Q3P3, Q0N3, Q1N3, Q2N3, Q3N3, update_int, lock_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa0 <= VitalBUF(Q3N3);
      qb0 <= VitalBUF(Q3P3);
      qa1 <= VitalBUF(Q2N3);
      qb1 <= VitalBUF(Q2P3);
      qa2 <= VitalBUF(Q1N3);
      qb2 <= VitalBUF(Q1P3);
      qa3 <= VitalBUF(Q0N3);
      qb3 <= VitalBUF(Q0P3);
      lock <= VitalBUF(lock_int);
      update <= VitalBUF(update_int);

END PROCESS;
 
END v;


--
----- cell osrx1a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY osrx1a IS
    GENERIC (
        REGSET          : string  := "RESET");
 
    PORT (
        d              : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        q          : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF osrx1a : ENTITY IS TRUE;

END osrx1a ;
 
-- architecture body --
ARCHITECTURE v OF osrx1a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL Q0P0    : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   P7 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (Q0P0 /= d) THEN
            Q0P0 <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '0' and clk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P0 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P0 <= '1';
            END IF;
         ELSE
            Q0P0 <= d;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (Q0P0)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= VitalBUF(Q0P0);

END PROCESS;
 
END v;


--
----- cell osrx2a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY osrx2a IS
    GENERIC (
        lsrmode 	: string := "LOCAL";
        updt            : string := "POS";
        REGSET          : string  := "RESET");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF osrx2a : ENTITY IS TRUE;

END osrx2a ;
 
-- architecture body --
ARCHITECTURE v OF osrx2a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL q_int    : std_logic := '0';
    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL Q0P0     : std_logic := '0';
    SIGNAL Q1P0     : std_logic := '0';
    SIGNAL Q0P1     : std_logic := '0';
    SIGNAL Q1P1     : std_logic := '0';
    SIGNAL Q0P2     : std_logic := '0';
    SIGNAL Q1P2     : std_logic := '0';
    SIGNAL new1_Q0P : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '1';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;
 
  -------------------------------------------------------------
  --  Shift Generation
  -------------------------------------------------------------
   P7 : PROCESS (sclk)
   BEGIN
      IF (sclk = 'X') THEN
         IF (Q0P0 /= d0) THEN
            Q0P0 <= 'X';
         END IF;
         IF (Q1P0 /= d1) THEN
            Q1P0 <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P0 <= '0';
               Q1P0 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P0 <= '1';
               Q1P0 <= '1';
            END IF;
         ELSE
            Q0P0 <= d0;
            Q1P0 <= d1;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P1 /= Q0P0) THEN
            Q0P1 <= 'X';
         END IF;
         IF (Q1P1 /= Q1P0) THEN
            Q1P1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P1 <= '0';
               Q1P1 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P1 <= '1';
               Q1P1 <= '1';
            END IF;
         ELSE
            IF (up_pos = '1') THEN
               Q0P1 <= Q0P0;
               Q1P1 <= Q1P0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P81 : PROCESS (Q0P1, up_pos, Q1P2)
   BEGIN
      IF (up_pos = '1') THEN
         new1_Q0P <= Q0P1;
      ELSIF (up_pos = '0') THEN
         new1_Q0P <= Q1P2;
      END IF;
   END PROCESS;

   P9 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P2 /= new1_Q0P) THEN
            Q0P2 <= 'X';
         END IF;
         IF (Q1P2 /= Q1P1) THEN
            Q1P2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P2 <= '0';
               Q1P2 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P2 <= '1';
               Q1P2 <= '1';
            END IF;
         ELSE
            Q0P2 <= new1_Q0P;
            IF (up_pos = '1') THEN
               Q1P2 <= Q1P1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (Q0P2, update_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= VitalBUF(Q0P2);
      update <= VitalBUF(update_int);

END PROCESS;
 
END v;


--
----- cell osrx4a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY osrx4a IS
    GENERIC (
        lsrmode 	: string := "LOCAL";
        updt            : string := "POS";
        REGSET          : string  := "RESET");
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
        d2              : IN std_logic;
        d3              : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF osrx4a : ENTITY IS TRUE;

END osrx4a ;
 
-- architecture body --
ARCHITECTURE v OF osrx4a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL q_int    : std_logic := '0';
    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL Q0P0     : std_logic := '0';
    SIGNAL Q1P0     : std_logic := '0';
    SIGNAL Q2P0     : std_logic := '0';
    SIGNAL Q3P0     : std_logic := '0';
    SIGNAL Q0P1     : std_logic := '0';
    SIGNAL Q1P1     : std_logic := '0';
    SIGNAL Q2P1     : std_logic := '0';
    SIGNAL Q3P1     : std_logic := '0';
    SIGNAL Q0P2     : std_logic := '0';
    SIGNAL Q1P2     : std_logic := '0';
    SIGNAL Q2P2     : std_logic := '0';
    SIGNAL Q3P2     : std_logic := '0';
    SIGNAL new1_Q0P : std_logic := '0';
    SIGNAL new2_Q0P : std_logic := '0';
    SIGNAL new3_Q0P : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '0';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;
 
  -------------------------------------------------------------
  --  Shift Generation
  -------------------------------------------------------------
   P7 : PROCESS (sclk)
   BEGIN
      IF (sclk = 'X') THEN
         IF (Q0P0 /= d0) THEN
            Q0P0 <= 'X';
         END IF;
         IF (Q1P0 /= d1) THEN
            Q1P0 <= 'X';
         END IF;
         IF (Q2P0 /= d2) THEN
            Q2P0 <= 'X';
         END IF;
         IF (Q3P0 /= d3) THEN
            Q3P0 <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P0 <= '0';
               Q1P0 <= '0';
               Q2P0 <= '0';
               Q3P0 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P0 <= '1';
               Q1P0 <= '1';
               Q2P0 <= '1';
               Q3P0 <= '1';
            END IF;
         ELSE
            Q0P0 <= d0;
            Q1P0 <= d1;
            Q2P0 <= d2;
            Q3P0 <= d3;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P1 /= Q0P0) THEN
            Q0P1 <= 'X';
         END IF;
         IF (Q1P1 /= Q1P0) THEN
            Q1P1 <= 'X';
         END IF;
         IF (Q2P1 /= Q2P0) THEN
            Q2P1 <= 'X';
         END IF;
         IF (Q3P1 /= Q3P0) THEN
            Q3P1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P1 <= '0';
               Q1P1 <= '0';
               Q2P1 <= '0';
               Q3P1 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P1 <= '1';
               Q1P1 <= '1';
               Q2P1 <= '1';
               Q3P1 <= '1';
            END IF;
         ELSE
            IF (up_pos = '1') THEN
               Q0P1 <= Q0P0;
               Q1P1 <= Q1P0;
               Q2P1 <= Q2P0;
               Q3P1 <= Q3P0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P81 : PROCESS (Q0P1, Q1P1, Q2P1, up_pos, Q1P2, Q2P2, Q3P2)
   BEGIN
      IF (up_pos = '1') THEN
         new1_Q0P <= Q0P1;
         new2_Q0P <= Q1P1;
         new3_Q0P <= Q2P1;
      ELSIF (up_pos = '0') THEN
         new1_Q0P <= Q1P2;
         new2_Q0P <= Q2P2;
         new3_Q0P <= Q3P2;
      END IF;
   END PROCESS;

   P9 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P2 /= new1_Q0P) THEN
            Q0P2 <= 'X';
         END IF;
         IF (Q1P2 /= new2_Q0P) THEN
            Q1P2 <= 'X';
         END IF;
         IF (Q2P2 /= new3_Q0P) THEN
            Q2P2 <= 'X';
         END IF;
         IF (Q3P2 /= Q3P1) THEN
            Q3P2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P2 <= '0';
               Q1P2 <= '0';
               Q2P2 <= '0';
               Q3P2 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P2 <= '1';
               Q1P2 <= '1';
               Q2P2 <= '1';
               Q3P2 <= '1';
            END IF;
         ELSE
            Q0P2 <= new1_Q0P;
            Q1P2 <= new2_Q0P;
            Q2P2 <= new3_Q0P;
            IF (up_pos = '1') THEN
               Q3P2 <= Q3P1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (Q0P2, update_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= VitalBUF(Q0P2);
      update <= VitalBUF(update_int);

END PROCESS;
 
END v;


--
----- cell oddra -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY oddra IS
    GENERIC (
        REGSET        	: string  := "RESET");
 
    PORT (
        da              : IN std_logic;
        db              : IN std_logic;
        clk              : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF oddra : ENTITY IS TRUE;

END oddra ;
 
-- architecture body --
ARCHITECTURE v OF oddra IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL QP       : std_logic := '0';
    SIGNAL QN       : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   P7 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (QP /= da) THEN
            QP <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '0' and clk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               QP <= '0';
            ELSIF (REGSET = "SET") THEN
               QP <= '1';
            END IF;
         ELSE
            QP <= da;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (QN /= db) THEN
            QN <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '1' and clk = '0') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               QN <= '0';
            ELSIF (REGSET = "SET") THEN
               QN <= '1';
            END IF;
         ELSE
            QN <= db;
         END IF;
      END IF;
   END PROCESS;


   VitalBehavior : PROCESS (clk, QP, QN)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= vitalmux
                 (data => (QN, QP),
                  dselect => (0 => clk));

END PROCESS;
 
END v;


--
----- cell oddrxa -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY oddrxa IS
    GENERIC (
        REGSET          : string  := "RESET");
 
    PORT (
        da              : IN std_logic;
        db              : IN std_logic;
        clk              : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF oddrxa : ENTITY IS TRUE;

END oddrxa ;
 
-- architecture body --
ARCHITECTURE v OF oddrxa IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL QP        : std_logic := '0';
    SIGNAL QN0       : std_logic := '0';
    SIGNAL QN1       : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   P7 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (QP /= da) THEN
            QP <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '0' and clk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               QP <= '0';
            ELSIF (REGSET = "SET") THEN
               QP <= '1';
            END IF;
         ELSE
            QP <= da;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (QN0 /= db) THEN
            QN0 <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '0' and clk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               QN0 <= '0';
            ELSIF (REGSET = "SET") THEN
               QN0 <= '1';
            END IF;
         ELSE
            QN0 <= db;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (clk)
   BEGIN
      IF (clk = 'X') THEN
         IF (QN1 /= QN0) THEN
            QN1 <= 'X';
         END IF;
      ELSIF (clk'event and clk'last_value = '1' and clk = '0') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               QN1 <= '0';
            ELSIF (REGSET = "SET") THEN
               QN1 <= '1';
            END IF;
         ELSE
            QN1 <= QN0;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (clk, QP, QN1)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= vitalmux
                 (data => (QN1, QP),
                  dselect => (0 => clk));

END PROCESS;
 
END v;


--
----- cell oddrx2a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY oddrx2a IS
    GENERIC (
        lsrmode         : string := "LOCAL";
        updt            : string := "POS";
        REGSET          : string  := "RESET");
 
    PORT (
        da0              : IN std_logic;
        db0              : IN std_logic;
        da1              : IN std_logic;
        db1              : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF oddrx2a : ENTITY IS TRUE;

END oddrx2a ;
 
-- architecture body --
ARCHITECTURE v OF oddrx2a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL Q0P0     : std_logic := '0';
    SIGNAL Q0N0     : std_logic := '0';
    SIGNAL Q1P0     : std_logic := '0';
    SIGNAL Q1N0     : std_logic := '0';
    SIGNAL Q0P1      : std_logic := '0';
    SIGNAL Q0N1      : std_logic := '0';
    SIGNAL Q1P1      : std_logic := '0';
    SIGNAL Q1N1      : std_logic := '0';
    SIGNAL Q0P2      : std_logic := '0';
    SIGNAL Q0N2      : std_logic := '0';
    SIGNAL Q1P2      : std_logic := '0';
    SIGNAL Q1N2      : std_logic := '0';
    SIGNAL new1_Q0N  : std_logic := '0';
    SIGNAL new2_Q0N  : std_logic := '0';
    SIGNAL new1_Q0P  : std_logic := '0';
    SIGNAL new2_Q0P  : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '1';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;

   P7 : PROCESS (sclk)
   BEGIN
      IF (sclk = 'X') THEN
         IF (Q0P0 /= db0) THEN
            Q0P0 <= 'X';
         END IF;
         IF (Q0N0 /= da0) THEN
            Q0N0 <= 'X';
         END IF;
         IF (Q1P0 /= db1) THEN
            Q1P0 <= 'X';
         END IF;
         IF (Q1N0 /= da1) THEN
            Q1N0 <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P0 <= '0';
               Q0N0 <= '0';
               Q1P0 <= '0';
               Q1N0 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P0 <= '1';
               Q0N0 <= '1';
               Q1P0 <= '1';
               Q1N0 <= '1';
            END IF;
         ELSE
            Q0P0 <= db0;
            Q0N0 <= da0;
            Q1P0 <= db1;
            Q1N0 <= da1;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P1 /= Q0P0) THEN
            Q0P1 <= 'X';
         END IF;
         IF (Q1P1 /= Q1P0) THEN
            Q1P1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P1 <= '0';
               Q1P1 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P1 <= '1';
               Q1P1 <= '1';
            END IF;
         ELSE
            IF (up_pos = '1') THEN
               Q0P1 <= Q0P0;
               Q1P1 <= Q1P0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0N1 /= Q0N0) THEN
            Q0N1 <= 'X';
         END IF;
         IF (Q1N1 /= Q1N0) THEN
            Q1N1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0N1 <= '0';
               Q1N1 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0N1 <= '1';
               Q1N1 <= '1';
            END IF;
         ELSE
            IF (up_pos = '1') THEN
               Q0N1 <= Q0N0;
               Q1N1 <= Q1N0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P81 : PROCESS (Q0P1, Q1P1, up_pos, Q1P2)
   BEGIN
      IF (up_pos = '1') THEN
         new1_Q0P <= Q0P1;
         new2_Q0P <= Q1P1;
      ELSIF (up_pos = '0') THEN
         new1_Q0P <= Q1P2;
      END IF;
   END PROCESS;

   P10 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P2 /= new1_Q0P) THEN
            Q0P2 <= 'X';
         END IF;
         IF (Q1P2 /= new2_Q0P) THEN
            Q1P2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P2 <= '0';
               Q1P2 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P2 <= '1';
               Q1P2 <= '1';
            END IF;
         ELSE
            Q0P2 <= new1_Q0P;
            Q1P2 <= new2_Q0P;
         END IF;
      END IF;
   END PROCESS;

   P91 : PROCESS (Q0N1, Q1N1, up_neg, Q1N2)
   BEGIN
      IF (up_neg = '1') THEN
         new1_Q0N <= Q0N1;
         new2_Q0N <= Q1N1;
      ELSIF (up_neg = '0') THEN
         new1_Q0N <= Q1N2;
      END IF;
   END PROCESS;

   P11 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0N2 /= new1_Q0N) THEN
            Q0N2 <= 'X';
         END IF;
         IF (Q1N2 /= new2_Q0N) THEN
            Q1N2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '1' and eclk = '0') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0N2 <= '0';
               Q1N2 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0N2 <= '1';
               Q1N2 <= '1';
            END IF;
         ELSE
            Q0N2 <= new1_Q0N;
            Q1N2 <= new2_Q0N;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (eclk, Q0P2, Q0N2, update_int)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= vitalmux
                 (data => (Q0N2, Q0P2),
                  dselect => (0 => eclk));
      update <= VitalBUF(update_int);

END PROCESS;
 
END v;


--
----- cell oddrx4a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY oddrx4a IS
    GENERIC (
        lsrmode         : string := "LOCAL";
        updt            : string := "POS";
        REGSET          : string  := "RESET");
 
    PORT (
        da0              : IN std_logic;
        db0              : IN std_logic;
        da1              : IN std_logic;
        db1              : IN std_logic;
        da2              : IN std_logic;
        db2              : IN std_logic;
        da3              : IN std_logic;
        db3              : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF oddrx4a : ENTITY IS TRUE;

END oddrx4a ;
 
-- architecture body --
ARCHITECTURE v OF oddrx4a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL update_int : std_logic := '0';
    SIGNAL rst_int0 : std_logic := '1';
    SIGNAL rst_int1 : std_logic := '1';
    SIGNAL rst_int2 : std_logic := '1';
    SIGNAL rst_int  : std_logic := '1';
    SIGNAL up_q0    : std_logic := '0';
    SIGNAL up_q1    : std_logic := '0';
    SIGNAL up_q2    : std_logic := '0';
    SIGNAL up_pos   : std_logic := '0';
    SIGNAL up_neg   : std_logic := '0';
    SIGNAL Q0P0     : std_logic := '0';
    SIGNAL Q0N0     : std_logic := '0';
    SIGNAL Q1P0     : std_logic := '0';
    SIGNAL Q1N0     : std_logic := '0';
    SIGNAL Q2P0     : std_logic := '0';
    SIGNAL Q2N0     : std_logic := '0';
    SIGNAL Q3P0     : std_logic := '0';
    SIGNAL Q3N0     : std_logic := '0';
    SIGNAL Q0P1      : std_logic := '0';
    SIGNAL Q0N1      : std_logic := '0';
    SIGNAL Q1P1      : std_logic := '0';
    SIGNAL Q1N1      : std_logic := '0';
    SIGNAL Q2P1      : std_logic := '0';
    SIGNAL Q2N1      : std_logic := '0';
    SIGNAL Q3P1      : std_logic := '0';
    SIGNAL Q3N1      : std_logic := '0';
    SIGNAL Q0P2      : std_logic := '0';
    SIGNAL Q0N2      : std_logic := '0';
    SIGNAL Q1P2      : std_logic := '0';
    SIGNAL Q1N2      : std_logic := '0';
    SIGNAL Q2P2      : std_logic := '0';
    SIGNAL Q2N2      : std_logic := '0';
    SIGNAL Q3P2      : std_logic := '0';
    SIGNAL Q3N2      : std_logic := '0';
    SIGNAL new1_Q0N  : std_logic := '0';
    SIGNAL new2_Q0N  : std_logic := '0';
    SIGNAL new3_Q0N  : std_logic := '0';
    SIGNAL new1_Q0P  : std_logic := '0';
    SIGNAL new2_Q0P  : std_logic := '0';
    SIGNAL new3_Q0P  : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   --  UPDATE Generation --

   P1 : PROCESS (sclk)
   BEGIN
      IF (sclk'event and sclk = '1') THEN
            rst_int0 <= rst;
            rst_int1 <= rst_int0;
      END IF;
   END PROCESS;

   rst_int2 <= rst_int1 after 300 ps;

   P2 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (lsrmode = "LOCAL") THEN
            rst_int <= rst_int2;
         ELSIF (lsrmode = "EDGE") THEN
            rst_int <= rst;
         END IF;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '1') THEN
         IF (rst_int = '1') THEN
            up_q0 <= '0';
            up_q1 <= '0';
            up_q2 <= '1';
            up_pos <= '0';
         ELSE
            up_q0 <= up_pos;
            up_q1 <= up_q0;
            up_q2 <= up_q1;
            up_pos <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk)
   BEGIN
      IF (eclk'event and eclk = '0') THEN
         IF (rst_int = '1') THEN
            up_neg <= '0';
         ELSE
            up_neg <= up_q2;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (up_pos, up_neg)
   BEGIN
      IF (updt = "POS") THEN
         update_int <= up_pos;
      ELSIF (updt = "NEG") THEN
         update_int <= up_neg;
      END IF;
   END PROCESS;

   P7 : PROCESS (sclk)
   BEGIN
      IF (sclk = 'X') THEN
         IF (Q0P0 /= db0) THEN
            Q0P0 <= 'X';
         END IF;
         IF (Q0N0 /= da0) THEN
            Q0N0 <= 'X';
         END IF;
         IF (Q1P0 /= db1) THEN
            Q1P0 <= 'X';
         END IF;
         IF (Q1N0 /= da1) THEN
            Q1N0 <= 'X';
         END IF;
         IF (Q2P0 /= db2) THEN
            Q2P0 <= 'X';
         END IF;
         IF (Q2N0 /= da2) THEN
            Q2N0 <= 'X';
         END IF;
         IF (Q3P0 /= db3) THEN
            Q3P0 <= 'X';
         END IF;
         IF (Q3N0 /= da3) THEN
            Q3N0 <= 'X';
         END IF;
      ELSIF (sclk'event and sclk'last_value = '0' and sclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P0 <= '0';
               Q0N0 <= '0';
               Q1P0 <= '0';
               Q1N0 <= '0';
               Q2P0 <= '0';
               Q2N0 <= '0';
               Q3P0 <= '0';
               Q3N0 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P0 <= '1';
               Q0N0 <= '1';
               Q1P0 <= '1';
               Q1N0 <= '1';
               Q2P0 <= '1';
               Q2N0 <= '1';
               Q3P0 <= '1';
               Q3N0 <= '1';
            END IF;
         ELSE
            Q0P0 <= db0;
            Q0N0 <= da0;
            Q1P0 <= db1;
            Q1N0 <= da1;
            Q2P0 <= db2;
            Q2N0 <= da2;
            Q3P0 <= db3;
            Q3N0 <= da3;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P1 /= Q0P0) THEN
            Q0P1 <= 'X';
         END IF;
         IF (Q1P1 /= Q1P0) THEN
            Q1P1 <= 'X';
         END IF;
         IF (Q2P1 /= Q2P0) THEN
            Q2P1 <= 'X';
         END IF;
         IF (Q3P1 /= Q3P0) THEN
            Q3P1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P1 <= '0';
               Q1P1 <= '0';
               Q2P1 <= '0';
               Q3P1 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P1 <= '1';
               Q1P1 <= '1';
               Q2P1 <= '1';
               Q3P1 <= '1';
            END IF;
         ELSE
            IF (up_pos = '1') THEN
               Q0P1 <= Q0P0;
               Q1P1 <= Q1P0;
               Q2P1 <= Q2P0;
               Q3P1 <= Q3P0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0N1 /= Q0N0) THEN
            Q0N1 <= 'X';
         END IF;
         IF (Q1N1 /= Q1N0) THEN
            Q1N1 <= 'X';
         END IF;
         IF (Q2N1 /= Q2N0) THEN
            Q2N1 <= 'X';
         END IF;
         IF (Q3N1 /= Q3N0) THEN
            Q3N1 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0N1 <= '0';
               Q1N1 <= '0';
               Q2N1 <= '0';
               Q3N1 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0N1 <= '1';
               Q1N1 <= '1';
               Q2N1 <= '1';
               Q3N1 <= '1';
            END IF;
         ELSE
            IF (up_pos = '1') THEN
               Q0N1 <= Q0N0;
               Q1N1 <= Q1N0;
               Q2N1 <= Q2N0;
               Q3N1 <= Q3N0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P81 : PROCESS (Q0P1, Q1P1, Q2P1, up_pos, Q1P2, Q2P2, Q3P2)
   BEGIN
      IF (up_pos = '1') THEN
         new1_Q0P <= Q0P1;
         new2_Q0P <= Q1P1;
         new3_Q0P <= Q2P1;
      ELSIF (up_pos = '0') THEN
         new1_Q0P <= Q1P2;
         new2_Q0P <= Q2P2;
         new3_Q0P <= Q3P2;
      END IF;
   END PROCESS;

   P10 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0P2 /= new1_Q0P) THEN
            Q0P2 <= 'X';
         END IF;
         IF (Q1P2 /= new2_Q0P) THEN
            Q1P2 <= 'X';
         END IF;
         IF (Q2P2 /= new3_Q0P) THEN
            Q2P2 <= 'X';
         END IF;
         IF (Q3P2 /= Q3P1) THEN
            Q3P2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '0' and eclk = '1') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0P2 <= '0';
               Q1P2 <= '0';
               Q2P2 <= '0';
               Q3P2 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0P2 <= '1';
               Q1P2 <= '1';
               Q2P2 <= '1';
               Q3P2 <= '1';
            END IF;
         ELSE
            Q0P2 <= new1_Q0P;
            Q1P2 <= new2_Q0P;
            Q2P2 <= new3_Q0P;
            IF (up_pos = '1') THEN
               Q3P2 <= Q3P1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P91 : PROCESS (Q0N1, Q1N1, Q2N1, up_neg, Q1N2, Q2N2, Q3N2)
   BEGIN
      IF (up_neg = '1') THEN
         new1_Q0N <= Q0N1;
         new2_Q0N <= Q1N1;
         new3_Q0N <= Q2N1;
      ELSIF (up_neg = '0') THEN
         new1_Q0N <= Q1N2;
         new2_Q0N <= Q2N2;
         new3_Q0N <= Q3N2;
      END IF;
   END PROCESS;

   P11 : PROCESS (eclk)
   BEGIN
      IF (eclk = 'X') THEN
         IF (Q0N2 /= new1_Q0N) THEN
            Q0N2 <= 'X';
         END IF;
         IF (Q1N2 /= new2_Q0N) THEN
            Q1N2 <= 'X';
         END IF;
         IF (Q2N2 /= new3_Q0N) THEN
            Q2N2 <= 'X';
         END IF;
         IF (Q3N2 /= Q3N1) THEN
            Q3N2 <= 'X';
         END IF;
      ELSIF (eclk'event and eclk'last_value = '1' and eclk = '0') THEN
         IF (rst = '1') THEN
            IF (REGSET = "RESET") THEN
               Q0N2 <= '0';
               Q1N2 <= '0';
               Q2N2 <= '0';
               Q3N2 <= '0';
            ELSIF (REGSET = "SET") THEN
               Q0N2 <= '1';
               Q1N2 <= '1';
               Q2N2 <= '1';
               Q3N2 <= '1';
            END IF;
         ELSE
            Q0N2 <= new1_Q0N;
            Q1N2 <= new2_Q0N;
            Q2N2 <= new3_Q0N;
            IF (up_neg = '1') THEN
               Q3N2 <= Q3N1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (eclk, Q0P2, Q0N2, update_int)

   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= vitalmux
                 (data => (Q0N2, Q0P2),
                  dselect => (0 => eclk));
      update <= VitalBUF(update_int);

END PROCESS;
 
END v;



--
----- cell delay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
use work.mem4.all;


-- entity declaration --
ENTITY delay IS
   GENERIC(
      DELAYTYPE       : in String := "CFGBIT";
      COARSE          : in String := "CDEL0";
      FINE            : in String := "FDEL0";
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "delay";
      tipd_dcntl0     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl1     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl2     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl3     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl4     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl5     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl6     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl7     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dcntl8     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN std_logic;
      dcntl0          :	IN std_logic;
      dcntl1          :	IN std_logic;
      dcntl2          :	IN std_logic;
      dcntl3          :	IN std_logic;
      dcntl4          :	IN std_logic;
      dcntl5          :	IN std_logic;
      dcntl6          :	IN std_logic;
      dcntl7          :	IN std_logic;
      dcntl8          :	IN std_logic;
      z               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF delay : ENTITY IS TRUE;
 
END delay;

-- architecture body --
ARCHITECTURE v OF delay IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := '0';
   SIGNAL dcntl_ipd	 : std_logic_vector(8 downto 0) := "000000000";
   SIGNAL delta     	 : time  := 0.02 ns;
   CONSTANT c_delay   	 : time  := conv_c_del(COARSE);
   CONSTANT f_delay   	 : time  := conv_f_del(FINE);
   SIGNAL cntl_delay  	 : time  := 0 ns;
   SIGNAL cntl_reg_int 	 : integer  := 0;
   SIGNAL a_delay	 : std_logic := '0';
   SIGNAL a_man_del	 : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (dcntl_ipd(0), dcntl0, tipd_dcntl0);
   VitalWireDelay (dcntl_ipd(1), dcntl1, tipd_dcntl1);
   VitalWireDelay (dcntl_ipd(2), dcntl2, tipd_dcntl2);
   VitalWireDelay (dcntl_ipd(3), dcntl3, tipd_dcntl3);
   VitalWireDelay (dcntl_ipd(4), dcntl4, tipd_dcntl4);
   VitalWireDelay (dcntl_ipd(5), dcntl5, tipd_dcntl5);
   VitalWireDelay (dcntl_ipd(6), dcntl6, tipd_dcntl6);
   VitalWireDelay (dcntl_ipd(7), dcntl7, tipd_dcntl7);
   VitalWireDelay (dcntl_ipd(8), dcntl8, tipd_dcntl8);
   END BLOCK;

   
   --------------------
   --  behavior section
   --------------------
   cntl_reg_int <= conv_integer(dcntl_ipd);

   cntl_delay <= (cntl_reg_int * delta);

   a_delay <= transport a_ipd after cntl_delay;

   a_man_del <= transport a_ipd after (c_delay + f_delay);

   VitalBehavior : PROCESS (a_man_del, a_delay)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      IF (DELAYTYPE = "DLL") THEN
         z <= a_delay;
      ELSE
         z <= a_man_del;
      END IF;

END PROCESS;

END v;



--
----- cell clkcntl -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
ENTITY clkcntl IS
    GENERIC (
        CLKMODE         : String := "ECLK");
    PORT (
        d               : IN std_logic;
        clk             : IN std_logic;
        ce              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF clkcntl : ENTITY IS TRUE;

END clkcntl ;
-- architecture body --
ARCHITECTURE v OF clkcntl IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL qb_int   : std_logic := '0';
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (clk, ce)
   BEGIN
      IF (ce = '1') THEN
         qb_int <= '1';
      ELSIF (clk'event and clk = '0') THEN
         qb_int <= ce;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (qb_int, d)

   BEGIN
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= (qb_int AND d);

END PROCESS;

END v;

--
----- cell pvtioctrl -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY pvtioctrl IS

   PORT(
      update             : IN std_logic := 'Z');

END pvtioctrl;

-- architecture body --
ARCHITECTURE v OF pvtioctrl IS

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   --  empty
   END BLOCK;

   --------------------
   --  behavior section
   --------------------

END v;
 
