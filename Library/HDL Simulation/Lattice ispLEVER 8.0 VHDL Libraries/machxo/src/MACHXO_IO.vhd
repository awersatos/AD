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
-- Simulation Library File for XO
--
-- $Header: /home/rlp/Orfdry/env_rcs/vhdl/pkg/vhdsclibs/data/orca5mj/src/RCS/MACHXO_IO.vhd,v 1.7 2005/10/14 20:29:45 pradeep Exp $ 
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
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "tsall");
 
   PORT(
      tsall           : IN std_logic := 'Z');

END tsall;
 
-- architecture body --
ARCHITECTURE v OF tsall IS
 
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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bb";
      tpd_i_b         :  VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_b         :  VitalDelayType01z :=
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_b_o         :  VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_b          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :  VitalDelayType01 := (0.0 ns, 0.0 ns));

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

   SIGNAL b_ipd  : std_logic := 'X';
   SIGNAL i_ipd  : std_logic := 'X';
   SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData        : VitalGlitchDataType;
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bbpd";
      tpd_i_b         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_b_o         :	VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

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

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri, 
                          resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bbpu";
      tpd_i_b         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_b_o         :	VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

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

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      Keepermode      : boolean := FALSE;
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bbw";
      tpd_i_b         :  VitalDelayType01z :=
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_b         :  VitalDelayType01z :=
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_b_o         :  VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_b          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :  VitalDelayType01 := (0.0 ns, 0.0 ns));

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
   SIGNAL b_ipd  : std_logic := 'X';
   SIGNAL i_ipd  : std_logic := 'X';
   SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

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

   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z :=
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData        : VitalGlitchDataType;
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ib";
      tpd_i_o         :	VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ib : ENTITY IS TRUE;
 
END ib;

-- architecture body --
ARCHITECTURE v OF ib IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUF(i_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibpd";
      tpd_i_o         :	VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibpd : ENTITY IS TRUE;
 
END ibpd;

-- architecture body --
ARCHITECTURE v OF ibpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibpu";
      tpd_i_o         :	VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibpu : ENTITY IS TRUE;
 
END ibpu;

-- architecture body --
ARCHITECTURE v OF ibpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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

        gsr             : String := "ENABLED";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3bx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_pd_q        : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_sp_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.0 ns;
        thold_eclk_d	: VitalDelayType := 0.0 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.0 ns;
        thold_sclk_sp	: VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.001 ns;
        tpw_eclk	: VitalDelayType := 0.001 ns;
        tperiod_sclk	: VitalDelayType := 0.001 ns;
        tpw_sclk	: VitalDelayType := 0.001 ns);
 
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

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL pd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

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
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_eclk or tviol_sclk;

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => NOT(set_reset), b => pd_ipd);  

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, preset, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

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

        gsr             : String := "ENABLED";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3dx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_cd_q        : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_sp_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.0 ns;
        thold_eclk_d	: VitalDelayType := 0.0 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.0 ns;
        thold_sclk_sp	: VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.001 ns;
        tpw_eclk	: VitalDelayType := 0.001 ns;
        tperiod_sclk	: VitalDelayType := 0.001 ns;
        tpw_sclk	: VitalDelayType := 0.001 ns);
 
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

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL cd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

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
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE clear       : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_eclk or tviol_sclk;

    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => NOT(set_reset), b => cd_ipd);  

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, clear, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

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

        gsr             : String := "ENABLED";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3ix";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_sp_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.0 ns;
        thold_eclk_d	: VitalDelayType := 0.0 ns;
        tsetup_cd_sclk  : VitalDelayType := 0.0 ns;
        thold_sclk_cd   : VitalDelayType := 0.0 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.0 ns;
        thold_sclk_sp	: VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.001 ns;
        tpw_eclk	: VitalDelayType := 0.001 ns;
        tperiod_sclk	: VitalDelayType := 0.001 ns;
        tpw_sclk	: VitalDelayType := 0.001 ns);
 
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

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL cd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

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
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk, SetupLow => tsetup_cd_sclk,
            HoldHigh => thold_sclk_cd, HoldLow => thold_sclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, cd_ipd, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

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

        gsr             : String := "ENABLED";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3iz";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_sp_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.0 ns;
        thold_eclk_d	: VitalDelayType := 0.0 ns;
        tsetup_cd_sclk  : VitalDelayType := 0.0 ns;
        thold_sclk_cd   : VitalDelayType := 0.0 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.0 ns;
        thold_sclk_sp	: VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.001 ns;
        tpw_eclk	: VitalDelayType := 0.001 ns;
        tperiod_sclk	: VitalDelayType := 0.001 ns;
        tpw_sclk	: VitalDelayType := 0.001 ns);
 
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

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL cd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

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
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
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
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk, SetupLow => tsetup_cd_sclk,
            HoldHigh => thold_sclk_cd, HoldLow => thold_sclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    synclr2 := VitalAND2 (a => latched(1), b => NOT(cd_ipd));

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, sp_ipd, sclk_ipd, synclr2),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

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

        gsr             : String := "ENABLED";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3jx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_sp_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.0 ns;
        thold_eclk_d	: VitalDelayType := 0.0 ns;
        tsetup_pd_sclk  : VitalDelayType := 0.0 ns;
        thold_sclk_pd   : VitalDelayType := 0.0 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.0 ns;
        thold_sclk_sp	: VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.001 ns;
        tpw_eclk	: VitalDelayType := 0.001 ns;
        tperiod_sclk	: VitalDelayType := 0.001 ns;
        tpw_sclk	: VitalDelayType := 0.001 ns);
 
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

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL pd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

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
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk, SetupLow => tsetup_pd_sclk,
            HoldHigh => thold_sclk_pd, HoldLow => thold_sclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, pd_ipd, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

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

        gsr             : String := "ENABLED";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3jz";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_sp_q	: VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.0 ns;
        thold_eclk_d	: VitalDelayType := 0.0 ns;
        tsetup_pd_sclk  : VitalDelayType := 0.0 ns;
        thold_sclk_pd   : VitalDelayType := 0.0 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.0 ns;
        thold_sclk_sp	: VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.001 ns;
        tpw_eclk	: VitalDelayType := 0.001 ns;
        tperiod_sclk	: VitalDelayType := 0.001 ns;
        tpw_sclk	: VitalDelayType := 0.001 ns);
 
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

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL pd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

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
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
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
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.001 ns, 0.001 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk, SetupLow => tsetup_pd_sclk,
            HoldHigh => thold_sclk_pd, HoldLow => thold_sclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (gsr = "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    synpre2 := VitalOR2 (a => latched(1), b => pd_ipd);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, sp_ipd, sclk_ipd, synpre2),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ob";
      tpd_i_o         :	VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ob : ENTITY IS TRUE;
 
END ob;

-- architecture body --
ARCHITECTURE v OF ob IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);
   VARIABLE tpd_tsall_o : VitalDelayType01 := (0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tsallnet);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (tsallnet'last_event, tpd_tsall_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz";
      tpd_i_o         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz : ENTITY IS TRUE;
 
END obz;

-- architecture body --
ARCHITECTURE v OF obz IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obzpd";
      tpd_i_o         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obzpd : ENTITY IS TRUE;
 
END obzpd;

-- architecture body --
ARCHITECTURE v OF obzpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obzpu";
      tpd_i_o         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obzpu : ENTITY IS TRUE;
 
END obzpu;

-- architecture body --
ARCHITECTURE v OF obzpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obw";
      tpd_i_o         : VitalDelayType01z :=
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tpd_t_o         : VitalDelayType01z :=
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);
      tipd_i          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          : VitalDelayType01 := (0.0 ns, 0.0 ns));

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
   SIGNAL i_ipd  : std_logic := 'X';
   SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

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

   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet, o_int)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z :=
               (0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns, 0.001 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => tsallnet, b => t_ipd);
      o_int <= VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := o_int;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ilvds";
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_an_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_an         : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               : IN std_logic;
      an              : IN std_logic;
      z               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilvds : ENTITY IS TRUE;

END ilvds;

-- architecture body --
ARCHITECTURE v OF ilvds IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd   : std_logic := 'X';
   SIGNAL an_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (an_ipd, an, tipd_an);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := VitalBUF(a_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, (tpd_a_z), TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

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
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "olvds";
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a_zn        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               : IN std_logic;
      z               : OUT std_logic;
      zn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF olvds : ENTITY IS TRUE;

END olvds;

-- architecture body --
ARCHITECTURE v OF olvds IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd   : std_logic := 'X';

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

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS z_zd : std_ulogic IS results(1);
   ALIAS zn_zd : std_ulogic IS results(2);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
   VARIABLE zn_GlitchData       : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := VitalBUF(a_ipd);
      zn_zd := VitalINV(a_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, (tpd_a_z), TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => zn,
       OutSignalName => "zn",
       OutTemp => zn_zd,
       Paths => (0 => (a_ipd'last_event, (tpd_a_zn), TRUE)),
       GlitchData => zn_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;
 
