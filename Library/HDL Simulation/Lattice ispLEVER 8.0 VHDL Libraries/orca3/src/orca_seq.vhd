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
-- Simulation Library File for ORCA3
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCA_SEQ.vhd,v 1.17 2005/05/19 20:04:55 pradeep Exp $ 
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
   GENERIC(
      timingcheckson  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "gsr");
 
   PORT(
      gsr             : IN std_logic := 'Z');

END gsr;
 
-- architecture body --
ARCHITECTURE v OF gsr IS
 
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
   gsrnet <= gsr;
 
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
      timingcheckson  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "pur");
 
   PORT(
      pur             : IN std_logic := 'Z');
 
END pur;
 
-- architecture body --
ARCHITECTURE v OF pur IS
 
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
   purnet <= pur;
 
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

        disabled_gsr    : string := "0";

        timingcheckson  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3ax";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge	: VitalDelayType := 0.01 ns;
        tpw_ck_negedge	: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3ax : ENTITY IS TRUE;

END fd1p3ax ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3ax IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, 
            TestSignalname => "d", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd='1'),
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, 
            TestSignalname => "sp", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		3 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3ay";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3ay : ENTITY IS TRUE;

END fd1p3ay ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, 
            TestSignalname => "d", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd='1'),
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, 
            TestSignalname => "sp", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		3 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3bx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3bx : ENTITY IS TRUE;

END fd1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1', '0' ),  -- async. preset 
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, 
            TestSignalname => "d", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, 
            TestSignalname => "sp", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, 
            TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, 
            Violation => tviol_pd, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_sp OR tviol_ck OR tviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3dx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3dx : ENTITY IS TRUE;

END fd1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0', '1' ),  -- async. clear 
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE clear	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, 
            TestSignalname => "d", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, 
            TestSignalname => "sp", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_sp OR tviol_ck OR tviol_cd;
 
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
    clear := VitalOR2 (a => not(set_reset), b => cd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, clear, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, 
      XOn => XOn, 
      MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3ix";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_cd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3ix : ENTITY IS TRUE;

END fd1p3ix ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 9) := (
      -- viol  clr  scl  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0', '1' ),  -- sync. clear 
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, 
            TestSignalname => "d", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', 
            MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, 
            TestSignalname => "cd",
            RefSignal => ck_ipd, 
            RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck_noedge_posedge, 
            SetupLow => tsetup_cd_ck_noedge_posedge,
            HoldHigh => thold_cd_ck_noedge_posedge, 
            HoldLow => thold_cd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/',
            MsgOn => MsgOn, 
            XOn => XOn,
            HeaderMsg => InstancePath, 
            TimingData => cd_ck_timingdatash,
            Violation => tsviol_cd, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, 
            TestSignalname => "sp", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn,
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, 
            XOn => XOn,
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tsviol_cd OR tviol_sp OR tviol_ck OR tviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, cd_ipd, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3iz IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3iz";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_cd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3iz : ENTITY IS TRUE;

END fd1p3iz ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synclr	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck_noedge_posedge, 
            SetupLow => tsetup_cd_ck_noedge_posedge,
            HoldHigh => thold_cd_ck_noedge_posedge, 
            HoldLow => thold_cd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_ck_timingdatash,
            Violation => tsviol_cd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tsviol_cd OR tviol_sp OR tviol_ck OR tviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => not(cd_ipd));  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, synclr),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3jx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_pd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3jx : ENTITY IS TRUE;

END fd1p3jx ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 9) := (
      -- viol  pre  spr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1', '0' ),  -- sync. preset
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck_noedge_posedge, 
            SetupLow => tsetup_pd_ck_noedge_posedge,
            HoldHigh => thold_pd_ck_noedge_posedge, 
            HoldLow => thold_pd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tsviol_pd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, 
            TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, 
            Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tsviol_pd OR tviol_sp OR tviol_ck OR tviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, pd_ipd, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1p3jz IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1p3jz";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_pd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1p3jz : ENTITY IS TRUE;

END fd1p3jz ;
 
-- architecture body --
ARCHITECTURE v OF fd1p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synpre	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck_noedge_posedge, 
            SetupLow => tsetup_pd_ck_noedge_posedge,
            HoldHigh => thold_pd_ck_noedge_posedge, 
            HoldLow => thold_pd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tsviol_pd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, 
            TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, 
            Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tsviol_pd OR tviol_sp OR tviol_ck OR tviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, synpre),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1s1a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s1a IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s1a";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s1a : ENTITY IS TRUE;

END fd1s1a ;
 
-- architecture body --
ARCHITECTURE v OF fd1s1a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_negedge, 
            SetupLow => tsetup_d_ck_noedge_negedge,
            HoldHigh => thold_d_ck_noedge_negedge, 
            HoldLow => thold_d_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_qn, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		3 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1s1ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s1ay IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s1ay";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s1ay : ENTITY IS TRUE;

END fd1s1ay ;
 
-- architecture body --
ARCHITECTURE v OF fd1s1ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_negedge, 
            SetupLow => tsetup_d_ck_noedge_negedge,
            HoldHigh => thold_d_ck_noedge_negedge, 
            HoldLow => thold_d_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_qn, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		3 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1s1b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s1b IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s1b";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s1b : ENTITY IS TRUE;

END fd1s1b ;
 
-- architecture body --
ARCHITECTURE v OF fd1s1b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '1', '0' ),  -- async. preset 
	( '-', '0', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '0', '1', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '0', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_negedge, 
            SetupLow => tsetup_d_ck_noedge_negedge,
            HoldHigh => thold_d_ck_noedge_negedge, 
            HoldLow => thold_d_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck OR tviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd_ipd);  

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, preset, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_qn, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1s1d -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s1d IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s1d";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s1d : ENTITY IS TRUE;

END fd1s1d ;
 
-- architecture body --
ARCHITECTURE v OF fd1s1d IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '0', '1' ),  -- async. clear 
	( '-', '0', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '0', '1', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '0', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE clear	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_negedge, 
            SetupLow => tsetup_d_ck_noedge_negedge,
            HoldHigh => thold_d_ck_noedge_negedge, 
            HoldLow => thold_d_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck OR tviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => not(set_reset), b => cd_ipd);  

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, clear, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		3 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1s1i -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s1i IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s1i";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_cd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge          : VitalDelayType := 0.01 ns;
        tpw_cd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s1i : ENTITY IS TRUE;

END fd1s1i ;
 
-- architecture body --
ARCHITECTURE v OF fd1s1i IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, cd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
        ( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synclr 	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_negedge, 
            SetupLow => tsetup_d_ck_noedge_negedge,
            HoldHigh => thold_d_ck_noedge_negedge, 
            HoldLow => thold_d_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck_noedge_negedge, 
            SetupLow => tsetup_cd_ck_noedge_negedge,
            HoldHigh => thold_cd_ck_noedge_negedge, 
            HoldLow => thold_cd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_ck_timingdatash,
            Violation => tsviol_cd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, 
            XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tsviol_cd OR tviol_ck OR tviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => not(cd_ipd));  

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, synclr),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_qn, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fd1s1j -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fd1s1j IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s1j";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_pd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s1j : ENTITY IS TRUE;

END fd1s1j ;
 
-- architecture body --
ARCHITECTURE v OF fd1s1j IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, pd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
        ( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synpre 	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_negedge, 
            SetupLow => tsetup_d_ck_noedge_negedge,
            HoldHigh => thold_d_ck_noedge_negedge, 
            HoldLow => thold_d_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck_noedge_negedge, 
            SetupLow => tsetup_pd_ck_noedge_negedge,
            HoldHigh => thold_pd_ck_noedge_negedge, 
            HoldLow => thold_pd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tsviol_pd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, 
            Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tsviol_pd OR tviol_ck OR tviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);  

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, synpre),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_qn, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s3ax";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3ax : ENTITY IS TRUE;

END fd1s3ax ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3ax IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		2 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		2 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s3ay";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3ay : ENTITY IS TRUE;

END fd1s3ay ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		2 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		2 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s3bx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3bx : ENTITY IS TRUE;

END fd1s3bx ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '1', '0' ),  -- async. preset 
	( '-', '0', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '0', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, 
            Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck OR tviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		3 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s3dx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3dx : ENTITY IS TRUE;

END fd1s3dx ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '0', '1' ),  -- async. clear
	( '-', '0', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '0', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '0', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE clear	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_ck OR tviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => not(set_reset), b => cd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, clear, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		3 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s3ix";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_cd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3ix : ENTITY IS TRUE;

END fd1s3ix ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE d_ck_TimingDatash      : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash      : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synclr 	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck_noedge_posedge, 
            SetupLow => tsetup_cd_ck_noedge_posedge,
            HoldHigh => thold_cd_ck_noedge_posedge, 
            HoldLow => thold_cd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, 
            TimingData => cd_ck_timingdatash,
            Violation => tsviol_cd, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_posedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_cd OR tviol_ck OR tsviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => not(cd_ipd));  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck_ipd, synclr),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		2 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		2 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fd1s3jx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_pd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        ck              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fd1s3jx : ENTITY IS TRUE;

END fd1s3jx ;
 
-- architecture body --
ARCHITECTURE v OF fd1s3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising edge ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising edge ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synpre 	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck_noedge_posedge, 
            SetupLow => tsetup_d_ck_noedge_posedge,
            HoldHigh => thold_d_ck_noedge_posedge, 
            HoldLow => thold_d_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => pd_ipd, TestSignalname => "pd", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_pd_ck_noedge_posedge, 
            SetupLow => tsetup_pd_ck_noedge_posedge,
            HoldHigh => thold_pd_ck_noedge_posedge, 
            HoldLow => thold_pd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => pd_ck_timingdatash, 
	    Violation => tsviol_pd, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, 
            TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, 
            Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_pd OR tviol_ck OR tsviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck_ipd, synpre),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		2 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		2 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3ay";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3ay : ENTITY IS TRUE;

END fl1p3ay ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, 
            TestSignalname => "d0", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd='1' AND sd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, 
            TestSignalname => "d1", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd='1' AND sd_ipd='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, 
            TestSignalname => "sp", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, 
            TestSignalname => "sd", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3az";
        -- propagation delayS
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3az : ENTITY IS TRUE;

END fl1p3az ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3az IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, 
            TestSignalname => "d0", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd='1' AND sd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, 
            TestSignalname => "d1", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd='1' AND sd_ipd='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, 
            TestSignalname => "sp", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, 
            TestSignalname => "sd", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		4 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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


        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3bx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	pd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3bx : ENTITY IS TRUE;

END fl1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, pd_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1', '0' ),  -- async. preset
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, 
            TestSignalname => "d0", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd='1' 
                             AND sd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, 
            TestSignalname => "d1", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd='1' 
                             AND sd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, 
            TestSignalname => "sp", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, 
            TestSignalname => "sd", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, 
            TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, 
            Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_sd OR tviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd_ipd);

    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, sp_ipd, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
                2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3dx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	cd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3dx : ENTITY IS TRUE;

END fl1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, cd_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0', '1' ),  -- async. clear
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, 
            TestSignalname => "d0", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (purnet='1' AND cd_ipd='0' AND sp_ipd='1' 
                             AND sd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, 
            TestSignalname => "d1", 
	    RefSignal => ck_ipd, 
            RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (purnet='1' AND cd_ipd='0' AND sp_ipd='1' 
                             AND sd_ipd='1'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, 
            TestSignalname => "sp", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (purnet='1' AND cd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, 
            MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, 
            TestSignalname => "sd", 
            RefSignal => ck_ipd, 
            RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (purnet='1' AND cd_ipd='0'), 
            RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, 
            TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, 
            MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, 
            TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, 
            Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, 
            TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, 
            Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, 
            CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_sd OR tviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => cd_ipd);

    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, sp_ipd, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
                2 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3iy";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
	tsetup_cd_ck_noedge_posedge     : VitalDelayType := 0.01 ns;
        thold_cd_ck_noedge_posedge      : VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	cd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3iy : ENTITY IS TRUE;

END fl1p3iy ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3iy IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, cd_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 9) := (
      -- viol  clr  scl  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0', '1' ),  -- sync. clear
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='1' AND sp_ipd='1' 
                             AND sd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='1' AND sp_ipd='1' 
                             AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck_noedge_posedge, 
            SetupLow => tsetup_cd_ck_noedge_posedge,
            HoldHigh => thold_cd_ck_noedge_posedge, 
            HoldLow => thold_cd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_ck_timingdatash,
            Violation => tsviol_cd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalname => "sp", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, TestSignalname => "sd", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_cd OR tviol_sd OR tsviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, cd_ipd, sp_ipd, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3iz IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3iz";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
	tsetup_cd_ck_noedge_posedge     : VitalDelayType := 0.01 ns;
        thold_cd_ck_noedge_posedge      : VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	cd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3iz : ENTITY IS TRUE;

END fl1p3iz ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, cd_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  clr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synclr      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1' AND sd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1' AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck_noedge_posedge, 
            SetupLow => tsetup_cd_ck_noedge_posedge,
            HoldHigh => thold_cd_ck_noedge_posedge, 
            HoldLow => thold_cd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_ck_timingdatash,
            Violation => tsviol_cd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalname => "sp", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, TestSignalname => "sd", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_cd OR tviol_sd OR tsviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    synclr := VitalAND2 (a => muxout, b => not(cd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, synclr),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3jy";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
	tsetup_pd_ck_noedge_posedge     : VitalDelayType := 0.01 ns;
        thold_pd_ck_noedge_posedge      : VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	pd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3jy : ENTITY IS TRUE;

END fl1p3jy ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3jy IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, pd_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 9) := (
      -- viol  pre  spr  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1', '0' ),  -- sync. preset
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='1' AND sp_ipd='1' 
                             AND sd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='1' AND sp_ipd='1' 
                             AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck_noedge_posedge, 
            SetupLow => tsetup_pd_ck_noedge_posedge,
            HoldHigh => thold_pd_ck_noedge_posedge, 
            HoldLow => thold_pd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tsviol_pd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalname => "sp", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, TestSignalname => "sd", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_pd OR tviol_sd OR tsviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, pd_ipd, sp_ipd, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1p3jz IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1p3jz";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
	tsetup_pd_ck_noedge_posedge     : VitalDelayType := 0.01 ns;
        thold_pd_ck_noedge_posedge      : VitalDelayType := 0.01 ns;
        tsetup_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sp              : IN std_logic;
        ck              : IN std_logic;
	sd              : IN std_logic;
	pd              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1p3jz : ENTITY IS TRUE;

END fl1p3jz ;
 
-- architecture body --
ARCHITECTURE v OF fl1p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, pd_ipd, sd_ipd, sp_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- viol  pre  ce   ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synpre      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1' AND sd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1' AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck_noedge_posedge, 
            SetupLow => tsetup_pd_ck_noedge_posedge,
            HoldHigh => thold_pd_ck_noedge_posedge, 
            HoldLow => thold_pd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tsviol_pd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalname => "sp", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sp_ck_noedge_posedge, 
            SetupLow => tsetup_sp_ck_noedge_posedge,
            HoldHigh => thold_sp_ck_noedge_posedge, 
            HoldLow => thold_sp_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
            Violation => tviol_sp, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, TestSignalname => "sd", 
            RefSignal => ck_ipd, RefSignalName => "ck", 
            SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
            Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sp OR tviol_pd OR tviol_sd OR tsviol_pd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    synpre := VitalOR2 (a => muxout, b => pd_ipd);

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, synpre),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
                3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_qn, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1s1a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s1a IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s1a";
        -- propagation delays
        tpd_d0_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d0_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s1a : ENTITY IS TRUE;

END fl1s1a ;
 
-- architecture body --
ARCHITECTURE v OF fl1s1a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_negedge, 
            SetupLow => tsetup_d0_ck_noedge_negedge,
            HoldHigh => thold_d0_ck_noedge_negedge, 
            HoldLow => thold_d0_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_negedge, 
            SetupLow => tsetup_d1_ck_noedge_negedge,
            HoldHigh => thold_d1_ck_noedge_negedge, 
            HoldLow => thold_d1_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sd_ipd, TestSignalname => "sd", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sd_ck_noedge_negedge, 
            SetupLow => tsetup_sd_ck_noedge_negedge,
            HoldHigh => thold_sd_ck_noedge_negedge, 
            HoldLow => thold_sd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
	    Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_q, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_q, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_qn, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1s1ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s1ay IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s1ay";
        -- propagation delays
        tpd_d0_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d0_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s1ay : ENTITY IS TRUE;

END fl1s1ay ;
 
-- architecture body --
ARCHITECTURE v OF fl1s1ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_negedge, 
            SetupLow => tsetup_d0_ck_noedge_negedge,
            HoldHigh => thold_d0_ck_noedge_negedge, 
            HoldLow => thold_d0_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_negedge, 
            SetupLow => tsetup_d1_ck_noedge_negedge,
            HoldHigh => thold_d1_ck_noedge_negedge, 
            HoldLow => thold_d1_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sd_ipd, TestSignalname => "sd", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sd_ck_noedge_negedge, 
            SetupLow => tsetup_sd_ck_noedge_negedge,
            HoldHigh => thold_sd_ck_noedge_negedge, 
            HoldLow => thold_sd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
	    Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_q, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_q, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		5 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_qn, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		5 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1s1b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s1b IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s1b";
        -- propagation delays
        tpd_d0_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d0_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s1b : ENTITY IS TRUE;

END fl1s1b ;
 
-- architecture body --
ARCHITECTURE v OF fl1s1b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, pd_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '1', '0' ),  -- async. preset 
	( '-', '0', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '0', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '0', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_negedge, 
            SetupLow => tsetup_d0_ck_noedge_negedge,
            HoldHigh => thold_d0_ck_noedge_negedge, 
            HoldLow => thold_d0_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_negedge, 
            SetupLow => tsetup_d1_ck_noedge_negedge,
            HoldHigh => thold_d1_ck_noedge_negedge, 
            HoldLow => thold_d1_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sd_ipd, TestSignalname => "sd", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sd_ck_noedge_negedge, 
            SetupLow => tsetup_sd_ck_noedge_negedge,
            HoldHigh => thold_sd_ck_noedge_negedge, 
            HoldLow => thold_sd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
	    Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_pd OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd_ipd);

    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, preset, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_q, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_q, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
                4 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		6 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_qn, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
                4 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		6 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1s1d -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s1d IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s1d";
        -- propagation delays
        tpd_d0_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d0_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s1d : ENTITY IS TRUE;

END fl1s1d ;
 
-- architecture body --
ARCHITECTURE v OF fl1s1d IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, cd_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '0', '1' ),  -- async. clear 
	( '-', '0', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '0', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '0', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE clear       : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_negedge, 
            SetupLow => tsetup_d0_ck_noedge_negedge,
            HoldHigh => thold_d0_ck_noedge_negedge, 
            HoldLow => thold_d0_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_negedge, 
            SetupLow => tsetup_d1_ck_noedge_negedge,
            HoldHigh => thold_d1_ck_noedge_negedge, 
            HoldLow => thold_d1_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sd_ipd, TestSignalname => "sd", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sd_ck_noedge_negedge, 
            SetupLow => tsetup_sd_ck_noedge_negedge,
            HoldHigh => thold_sd_ck_noedge_negedge, 
            HoldLow => thold_sd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
	    Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sd OR tviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => not(set_reset), b => cd_ipd);

    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, clear, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_q, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_q, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
                4 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		6 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_qn, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
                4 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		6 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1s1i -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s1i IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s1i";
        -- propagation delays
        tpd_d0_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d0_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_ck_noedge_negedge     : VitalDelayType := 0.01 ns;
        thold_cd_ck_noedge_negedge      : VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_negedge     : VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_negedge      : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_cd      	: VitalDelayType := 0.01 ns;
        tpw_cd_posedge		: VitalDelayType := 0.01 ns;
        tpw_cd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s1i : ENTITY IS TRUE;

END fl1s1i ;
 
-- architecture body --
ARCHITECTURE v OF fl1s1i IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, cd_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synclr      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_negedge, 
            SetupLow => tsetup_d0_ck_noedge_negedge,
            HoldHigh => thold_d0_ck_noedge_negedge, 
            HoldLow => thold_d0_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_negedge, 
            SetupLow => tsetup_d1_ck_noedge_negedge,
            HoldHigh => thold_d1_ck_noedge_negedge, 
            HoldLow => thold_d1_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck_noedge_negedge, 
            SetupLow => tsetup_cd_ck_noedge_negedge,
            HoldHigh => thold_cd_ck_noedge_negedge, 
            HoldLow => thold_cd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_ck_timingdatash,
            Violation => tsviol_cd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, TestSignalname => "sd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_sd_ck_noedge_negedge, 
            SetupLow => tsetup_sd_ck_noedge_negedge,
            HoldHigh => thold_sd_ck_noedge_negedge, 
            HoldLow => thold_sd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash,
            Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => cd_ipd, TestSignalname => "cd", 
	    Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge, 
	    PulseWidthLow => tpw_cd_negedge, 
	    Perioddata => periodcheckinfo_cd, Violation => tviol_cd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_cd OR tviol_ck OR tviol_sd OR tsviol_cd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    synclr := VitalAND2 (a => muxout, b => not(cd_ipd));

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, synclr),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_q, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_q, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		6 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_qn, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (cd_ipd'last_event, tpd_cd_qn, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		6 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell fl1s1j -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY fl1s1j IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s1j";
        -- propagation delays
        tpd_d0_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d0_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d1_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_ck_noedge_negedge    : VitalDelayType := 0.01 ns;
        thold_pd_ck_noedge_negedge     : VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_negedge    : VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_negedge     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;
        tperiod_pd      	: VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
	pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s1j : ENTITY IS TRUE;

END fl1s1j ;
 
-- architecture body --
ARCHITECTURE v OF fl1s1j IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, pd_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- low d->q on high ck
	( '-', '1', '1', '1', '-', '1', '0' ),  -- high d->q on high ck
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE synpre      : std_logic := 'X';
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_negedge, 
            SetupLow => tsetup_d0_ck_noedge_negedge,
            HoldHigh => thold_d0_ck_noedge_negedge, 
            HoldLow => thold_d0_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_negedge, 
            SetupLow => tsetup_d1_ck_noedge_negedge,
            HoldHigh => thold_d1_ck_noedge_negedge, 
            HoldLow => thold_d1_ck_noedge_negedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck_noedge_negedge, 
            SetupLow => tsetup_pd_ck_noedge_negedge,
            HoldHigh => thold_pd_ck_noedge_negedge, 
            HoldLow => thold_pd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tsviol_pd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => sd_ipd, TestSignalname => "sd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_sd_ck_noedge_negedge, 
            SetupLow => tsetup_sd_ck_noedge_negedge,
            HoldHigh => thold_sd_ck_noedge_negedge, 
            HoldLow => thold_sd_ck_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash,
            Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => pd_ipd, TestSignalname => "pd", 
	    Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge, 
	    PulseWidthLow => tpw_pd_negedge, 
	    Perioddata => periodcheckinfo_pd, Violation => tviol_pd, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_pd OR tviol_ck OR tsviol_pd OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    synpre := VitalOR2 (a => muxout, b => pd_ipd);

    VitalStateTable (StateTable => latch_table,
	    DataIn => (Violation, set_reset, ck_ipd, synpre),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_q, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_q, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_q, TRUE),
		4 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		6 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (d0_ipd'last_event, tpd_d0_qn, TRUE),
		2 => (d1_ipd'last_event, tpd_d1_qn, TRUE),
		3 => (sd_ipd'last_event, tpd_sd_qn, TRUE),
		4 => (pd_ipd'last_event, tpd_pd_qn, TRUE),
		5 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		6 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s3ax";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s3ax : ENTITY IS TRUE;

END fl1s3ax ;
 
-- architecture body --
ARCHITECTURE v OF fl1s3ax IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  clr  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- async. clear (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "01";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sd_ipd, TestSignalname => "sd", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
	    Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		2 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		2 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
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

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "fl1s3ay";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d0_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d1_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sd_ck_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d0		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_d1		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck      	: VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d0              : IN std_logic;
        d1              : IN std_logic;
	sd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic;
        qn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fl1s3ay : ENTITY IS TRUE;

END fl1s3ay ;
 
-- architecture body --
ARCHITECTURE v OF fl1s3ay IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d0_ipd  : std_logic := '0';
    SIGNAL d1_ipd  : std_logic := '0';
    SIGNAL sd_ipd  : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d0_ipd, d0, tipd_d0);
       VitalWireDelay(d1_ipd, d1, tipd_d1);
       VitalWireDelay(sd_ipd, sd, tipd_sd);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sd_ipd, ck_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- viol  pre  ck    d    q  qnew qnnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- async. preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- low d->q on rising ck
	( '-', '1', '/', '1', '-', '1', '0' ),  -- high d->q on rising ck
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- clock an x if d is x
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d0    : X01 := '0';
   VARIABLE tviol_d1    : X01 := '0';
   VARIABLE tviol_sd    : X01 := '0';
   VARIABLE d0_ck_TimingDatash : VitalTimingDataType;
   VARIABLE d1_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 2) := "10";
   ALIAS q_zd 		: std_ulogic IS results(1);
   ALIAS qn_zd 		: std_ulogic IS results(2);
   VARIABLE muxout      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_gsr_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_qn 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
   VARIABLE qn_GlitchData    : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d0_ipd, TestSignalname => "d0", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d0_ck_noedge_posedge, 
            SetupLow => tsetup_d0_ck_noedge_posedge,
            HoldHigh => thold_d0_ck_noedge_posedge, 
            HoldLow => thold_d0_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d0_ck_timingdatash, 
	    Violation => tviol_d0, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => d1_ipd, TestSignalname => "d1", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d1_ck_noedge_posedge, 
            SetupLow => tsetup_d1_ck_noedge_posedge,
            HoldHigh => thold_d1_ck_noedge_posedge, 
            HoldLow => thold_d1_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d1_ck_timingdatash, 
	    Violation => tviol_d1, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sd_ipd, TestSignalname => "sd", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sd_ck_noedge_posedge, 
            SetupLow => tsetup_sd_ck_noedge_posedge,
            HoldHigh => thold_sd_ck_noedge_posedge, 
            HoldLow => thold_sd_ck_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sd_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sd_ck_timingdatash, 
	    Violation => tviol_sd, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck_posedge, 
	    PulseWidthLow => tpw_ck_negedge, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d0 OR tviol_d1 OR tviol_ck OR tviol_sd;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    muxout := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, ck_ipd, muxout),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		2 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => qn,
      OutSignalname => "qn",
      OutTemp => qn_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_qn, 
		      PathCondition => TRUE),
		1 => (gsrnet'last_event, tpd_gsr_qn, TRUE),
		2 => (purnet'last_event, tpd_pur_qn, TRUE)),
      GlitchData => qn_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell cfd1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY cfd1p3bx IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "cfd1p3bx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck	: VitalDelayType := 0.01 ns;
        thold_ck_d	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck	: VitalDelayType := 0.01 ns;
        thold_ck_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cfd1p3bx : ENTITY IS TRUE;

END cfd1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF cfd1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   ck    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge ck
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge ck
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector(1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck, SetupLow => tsetup_d_ck,
            HoldHigh => thold_ck_d, HoldLow => thold_ck_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck, SetupLow => tsetup_sp_ck,
            HoldHigh => thold_ck_sp, HoldLow => thold_ck_sp,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck, 
	    PulseWidthLow => tpw_ck, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => not(set_reset), b => pd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, preset, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell cfd1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY cfd1p3dx IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "cfd1p3dx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck	: VitalDelayType := 0.01 ns;
        thold_ck_d	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck	: VitalDelayType := 0.01 ns;
        thold_ck_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cfd1p3dx : ENTITY IS TRUE;

END cfd1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF cfd1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   ck    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge ck
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge ck
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE clear	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck, SetupLow => tsetup_d_ck,
            HoldHigh => thold_ck_d, HoldLow => thold_ck_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck, SetupLow => tsetup_sp_ck,
            HoldHigh => thold_ck_sp, HoldLow => thold_ck_sp,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck, 
	    PulseWidthLow => tpw_ck, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => not(set_reset), b => cd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, clear, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- cell cfd1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY cfd1p3ix IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "cfd1p3ix";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck	: VitalDelayType := 0.01 ns;
        thold_ck_d	: VitalDelayType := 0.01 ns;
        tsetup_cd_ck	: VitalDelayType := 0.01 ns;
        thold_ck_cd	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck	: VitalDelayType := 0.01 ns;
        thold_ck_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cfd1p3ix : ENTITY IS TRUE;

END cfd1p3ix ;
 
-- architecture body --
ARCHITECTURE v OF cfd1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  clr  scl  ce   ck    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- sync. clear 
	( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge ck
	( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck, SetupLow => tsetup_d_ck,
            HoldHigh => thold_ck_d, HoldLow => thold_ck_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck, SetupLow => tsetup_cd_ck,
            HoldHigh => thold_ck_cd, HoldLow => thold_ck_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_ck_timingdatash,
            Violation => tviol_cd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck, SetupLow => tsetup_sp_ck,
            HoldHigh => thold_ck_sp, HoldLow => thold_ck_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck, 
	    PulseWidthLow => tpw_ck, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_cd OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, cd_ipd, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell cfd1p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY cfd1p3iz IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "cfd1p3iz";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck	: VitalDelayType := 0.01 ns;
        thold_ck_d	: VitalDelayType := 0.01 ns;
        tsetup_cd_ck	: VitalDelayType := 0.01 ns;
        thold_ck_cd	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck	: VitalDelayType := 0.01 ns;
        thold_ck_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cfd1p3iz : ENTITY IS TRUE;

END cfd1p3iz ;
 
-- architecture body --
ARCHITECTURE v OF cfd1p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   ck    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge ck
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck, SetupLow => tsetup_d_ck,
            HoldHigh => thold_ck_d, HoldLow => thold_ck_d,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalname => "cd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_cd_ck, SetupLow => tsetup_cd_ck,
            HoldHigh => thold_ck_cd, HoldLow => thold_ck_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_ck_timingdatash,
            Violation => tviol_cd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck, SetupLow => tsetup_sp_ck,
            HoldHigh => thold_ck_sp, HoldLow => thold_ck_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck, 
	    PulseWidthLow => tpw_ck, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_cd OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => not(cd_ipd));  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, synclr),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell cfd1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY cfd1p3jx IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "cfd1p3jx";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck	: VitalDelayType := 0.01 ns;
        thold_ck_d	: VitalDelayType := 0.01 ns;
        tsetup_pd_ck	: VitalDelayType := 0.01 ns;
        thold_ck_pd	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck	: VitalDelayType := 0.01 ns;
        thold_ck_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cfd1p3jx : ENTITY IS TRUE;

END cfd1p3jx ;
 
-- architecture body --
ARCHITECTURE v OF cfd1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  pre  spr  ce   ck    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- sync. preset
	( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge ck
	( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge ck
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck, SetupLow => tsetup_d_ck,
            HoldHigh => thold_ck_d, HoldLow => thold_ck_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck, SetupLow => tsetup_pd_ck,
            HoldHigh => thold_ck_pd, HoldLow => thold_ck_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tviol_pd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck, SetupLow => tsetup_sp_ck,
            HoldHigh => thold_ck_sp, HoldLow => thold_ck_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck, 
	    PulseWidthLow => tpw_ck, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_pd OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, pd_ipd, sp_ipd, ck_ipd, d_ipd),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell cfd1p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY cfd1p3jz IS
    GENERIC (

        disabled_gsr    : string := "0";

        timingcheckson	: boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "cfd1p3jz";
        -- propagation delays
        tpd_ck_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_ck	: VitalDelayType := 0.01 ns;
        thold_ck_d	: VitalDelayType := 0.01 ns;
        tsetup_pd_ck	: VitalDelayType := 0.01 ns;
        thold_ck_pd	: VitalDelayType := 0.01 ns;
        tsetup_sp_ck	: VitalDelayType := 0.01 ns;
        thold_ck_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_ck	: VitalDelayType := 0.01 ns;
        tpw_ck		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        ck              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cfd1p3jz : ENTITY IS TRUE;

END cfd1p3jz ;
 
-- architecture body --
ARCHITECTURE v OF cfd1p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ck_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ck_ipd, ck, tipd_ck);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, ck_ipd, pd_ipd, gsrnet, purnet)
   
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   ck    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing Violation
	( '-', '0', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge ck
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge ck
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_ck    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_ck_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_ck_TimingDatash : VitalTimingDataType;
   VARIABLE sp_ck_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_ck : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE Violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (timingcheckson) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalname => "d", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_d_ck, SetupLow => tsetup_d_ck,
            HoldHigh => thold_ck_d, HoldLow => thold_ck_d,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_ck_timingdatash, 
	    Violation => tviol_d, MsgSeverity => Warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalname => "pd",
            RefSignal => ck_ipd, RefSignalName => "ck",
            SetupHigh => tsetup_pd_ck, SetupLow => tsetup_pd_ck,
            HoldHigh => thold_ck_pd, HoldLow => thold_ck_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_ck_timingdatash,
            Violation => tviol_pd, MsgSeverity => Warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalname => "sp", 
	    RefSignal => ck_ipd, RefSignalName => "ck", 
	    SetupHigh => tsetup_sp_ck, SetupLow => tsetup_sp_ck,
            HoldHigh => thold_ck_sp, HoldLow => thold_ck_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_ck_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => Warning);
        VitalPeriodPulseCheck (
	    TestSignal => ck_ipd, TestSignalname => "ck", 
	    Period => tperiod_ck,
            PulseWidthHigh => tpw_ck, 
	    PulseWidthLow => tpw_ck, 
	    Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => Warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    Violation := tviol_d OR tviol_pd OR tviol_sp OR tviol_ck;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);  

    VitalStateTable (StateTable => ff_table,
	    DataIn => (Violation, set_reset, sp_ipd, ck_ipd, synpre),
	    Numstates => 1,
	    Result =>results,
	    PreviousDataIn => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalname => "q",
      OutTemp => q_zd,
      Paths => (0 => (InputChangeTime => ck_ipd'last_event, 
	              PathDelay => tpd_ck_q, 
		      PathCondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

 
END PROCESS;
 
END v;


