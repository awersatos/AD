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
-- Simulation Library File for ORCA2
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca2/src/RCS/ORCA_SEQ.vhd,v 1.6 2005/05/19 20:04:11 pradeep Exp $ 
--
 
--
----- PACKAGE GLOBAL -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package GLOBAL is
	signal GSRNET: STD_LOGIC := 'H';
        signal TSALLNET: STD_LOGIC := 'H';
end GLOBAL;

package body GLOBAL is 
end GLOBAL;


--
----- CELL GSR -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
 
-- entity declaration --
entity GSR is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "GSR");
 
   port(
      GSR             : in STD_LOGIC := 'Z');

end GSR;
 
-- architecture body --
architecture V of GSR is
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   --  empty
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   GSRNET <= GSR;
 
end V;


--
----- CELL FD1P3AX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3AX is
    generic (
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3AX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3AX : entity is TRUE;

end FD1P3AX ;
 
-- architecture body --
architecture V of FD1P3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  CLR  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND SP_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_SP OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, SP_ipd, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- CELL FD1P3AY -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3AY is
    generic (
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3AY";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3AY : entity is TRUE;

end FD1P3AY ;
 
-- architecture body --
architecture V of FD1P3AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  PRE  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND SP_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_SP OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, SP_ipd, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1P3BX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3BX is
    generic (
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3BX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_QN       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3BX : entity is TRUE;

end FD1P3BX ;
 
-- architecture body --
architecture V of FD1P3BX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, PD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  PRE  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '-', '1', '0' ),  -- Async. Preset 
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Preset      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0' AND SP_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_SP OR Tviol_CK;
 
    Preset := VitalOR2 (a => NOT(GSRNET), b => PD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Preset, SP_ipd, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (PD_ipd'LAST_EVENT, tpd_PD_Q, TRUE),
		3 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (PD_ipd'LAST_EVENT, tpd_PD_QN, TRUE),
		3 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1P3DX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3DX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3DX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_QN       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3DX : entity is TRUE;

end FD1P3DX ;
 
-- architecture body --
architecture V of FD1P3DX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, CD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  CLR  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear 
	( '-', '0', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '0', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '0', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '0', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Clear	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0' AND SP_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_SP OR Tviol_CK;
 
    Clear := VitalOR2 (a => NOT(GSRNET), b => CD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Clear, SP_ipd, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (CD_ipd'LAST_EVENT, tpd_CD_Q, TRUE),
		3 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (CD_ipd'LAST_EVENT, tpd_CD_QN, TRUE),
		3 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1P3IX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3IX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3IX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_CD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_CD	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3IX : entity is TRUE;

end FD1P3IX ;
 
-- architecture body --
architecture V of FD1P3IX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, CD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 9, 1 to 9) := (
      -- Viol  CLR  SCL  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0', '1' ),  -- Sync. Clear 
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_CD    : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE CD_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0' AND SP_ipd ='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
            Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => CD_ipd, TestSignalName => "CD",
            RefSignal => CK_ipd, RefSignalName => "CK",
            SetupHigh => tsetup_CD_CK, SetupLow => tsetup_CD_CK,
            HoldHigh => thold_CK_CD, HoldLow => thold_CK_CD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => CD_CK_TimingDataSH,
            Violation => Tviol_CD, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CD OR Tviol_SP OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CD_ipd, SP_ipd, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1P3IZ -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3IZ is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3IZ";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_CD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_CD	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3IZ : entity is TRUE;

end FD1P3IZ ;
 
-- architecture body --
architecture V of FD1P3IZ is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, CD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  CLR  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_CD    : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE CD_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE SynClr	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND SP_ipd ='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => CD_ipd, TestSignalName => "CD",
            RefSignal => CK_ipd, RefSignalName => "CK",
            SetupHigh => tsetup_CD_CK, SetupLow => tsetup_CD_CK,
            HoldHigh => thold_CK_CD, HoldLow => thold_CK_CD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => CD_CK_TimingDataSH,
            Violation => Tviol_CD, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CD OR Tviol_SP OR Tviol_CK;
 
    SynClr := VitalAND2 (a => D_ipd, b => NOT(CD_ipd));  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, VitalBUF(GSRNET), SP_ipd, CK_ipd, SynClr),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1P3JX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3JX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3JX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_PD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_PD	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3JX : entity is TRUE;

end FD1P3JX ;
 
-- architecture body --
architecture V of FD1P3JX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, PD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 9, 1 to 9) := (
      -- Viol  PRE  SPR  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1', '0' ),  -- Sync. Preset
	( '-', '1', '0', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '0', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '0', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', '0', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '1', '-', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_PD    : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PD_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0' AND SP_ipd ='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => PD_ipd, TestSignalName => "PD",
            RefSignal => CK_ipd, RefSignalName => "CK",
            SetupHigh => tsetup_PD_CK, SetupLow => tsetup_PD_CK,
            HoldHigh => thold_CK_PD, HoldLow => thold_CK_PD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => PD_CK_TimingDataSH,
            Violation => Tviol_PD, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_PD OR Tviol_SP OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, PD_ipd, SP_ipd, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1P3JZ -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1P3JZ is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1P3JZ";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_PD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_PD	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        SP              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1P3JZ : entity is TRUE;

end FD1P3JZ ;
 
-- architecture body --
architecture V of FD1P3JZ is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, SP_ipd, CK_ipd, PD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  PRE  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- CE is X on rising edge of CK
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_PD    : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PD_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE SynPre	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND SP_ipd ='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => PD_ipd, TestSignalName => "PD",
            RefSignal => CK_ipd, RefSignalName => "CK",
            SetupHigh => tsetup_PD_CK, SetupLow => tsetup_PD_CK,
            HoldHigh => thold_CK_PD, HoldLow => thold_CK_PD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => PD_CK_TimingDataSH,
            Violation => Tviol_PD, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => SP_ipd, TestSignalName => "SP", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
	    Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_PD OR Tviol_SP OR Tviol_CK;
 
    SynPre := VitalOR2 (a => D_ipd, b => PD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, SP_ipd, CK_ipd, SynPre),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S1A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S1A is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S1A";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D_Q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S1A : entity is TRUE;

end FD1S1A ;
 
-- architecture body --
architecture V of FD1S1A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- Low d->q on high CK
	( '-', '1', '1', '1', '-', '1', '0' ),  -- High d->q on high CK
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, GSRNET, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (D_ipd'LAST_EVENT, tpd_D_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (D_ipd'LAST_EVENT, tpd_D_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S1AY -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S1AY is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S1AY";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D_Q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S1AY : entity is TRUE;

end FD1S1AY ;
 
-- architecture body --
architecture V of FD1S1AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- Low d->q on high CK
	( '-', '1', '1', '1', '-', '1', '0' ),  -- High d->q on high CK
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, GSRNET, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (D_ipd'LAST_EVENT, tpd_D_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (D_ipd'LAST_EVENT, tpd_D_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S1B -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S1B is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S1B";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D_Q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_PD	: VitalDelayType := 0.1 ns;
        tpw_PD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S1B : entity is TRUE;

end FD1S1B ;
 
-- architecture body --
architecture V of FD1S1B is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, PD_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '1', '0' ),  -- Async. Preset 
	( '-', '0', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '0', '1', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '0', '1', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '0', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Preset      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    Preset := VitalOR2 (a => NOT(GSRNET), b => PD_ipd);  

    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, Preset, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (D_ipd'LAST_EVENT, tpd_D_Q, TRUE),
		2 => (PD_ipd'LAST_EVENT, tpd_PD_Q, TRUE),
		3 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (D_ipd'LAST_EVENT, tpd_D_QN, TRUE),
		2 => (PD_ipd'LAST_EVENT, tpd_PD_QN, TRUE),
		3 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S1D -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S1D is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S1D";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_CD	: VitalDelayType := 0.1 ns;
        tpw_CD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S1D : entity is TRUE;

end FD1S1D ;
 
-- architecture body --
architecture V of FD1S1D is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, CD_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '0', '1' ),  -- Async. Clear 
	( '-', '0', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '0', '1', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '0', '1', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '0', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Clear	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    Clear := VitalOR2 (a => NOT(GSRNET), b => CD_ipd);  

    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, Clear, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (CD_ipd'LAST_EVENT, tpd_CD_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (CD_ipd'LAST_EVENT, tpd_CD_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S1I -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S1I is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S1I";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_CD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_CD	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_CD	: VitalDelayType := 0.1 ns;
        tpw_CD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S1I : entity is TRUE;

end FD1S1I ;
 
-- architecture body --
architecture V of FD1S1I is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CD_ipd, CK_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
        ( '-', '1', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '1', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_CD     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE CD_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE SynClr 	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => CD_ipd, TestSignalName => "CD",
            RefSignal => CK_ipd, RefSignalName => "CK",
            SetupHigh => tsetup_CD_CK, SetupLow => tsetup_CD_CK,
            HoldHigh => thold_CK_CD, HoldLow => thold_CK_CD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => CD_CK_TimingDataSH,
            Violation => Tviol_CD, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CD OR Tviol_CK;
 
    SynClr := VitalAND2 (a => D_ipd, b => NOT(CD_ipd));  

    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, GSRNET, CK_ipd, SynClr),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S1J -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S1J is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S1J";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_PD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_PD	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_PD	: VitalDelayType := 0.1 ns;
        tpw_PD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S1J : entity is TRUE;

end FD1S1J ;
 
-- architecture body --
architecture V of FD1S1J is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, PD_ipd, CK_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
        ( '-', '1', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '1', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_PD    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PD_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE SynPre 	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => PD_ipd, TestSignalName => "PD",
            RefSignal => CK_ipd, RefSignalName => "CK",
            SetupHigh => tsetup_PD_CK, SetupLow => tsetup_PD_CK,
            HoldHigh => thold_CK_PD, HoldLow => thold_CK_PD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => PD_CK_TimingDataSH,
            Violation => Tviol_PD, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_PD OR Tviol_CK;
 
    SynPre := VitalOR2 (a => D_ipd, b => PD_ipd);  

    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, GSRNET, CK_ipd, SynPre),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S3AX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S3AX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S3AX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S3AX : entity is TRUE;

end FD1S3AX ;
 
-- architecture body --
architecture V of FD1S3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S3AY -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S3AY is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S3AY";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S3AY : entity is TRUE;

end FD1S3AY ;
 
-- architecture body --
architecture V of FD1S3AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S3BX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S3BX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S3BX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_PD	: VitalDelayType := 0.1 ns;
        tpw_PD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S3BX : entity is TRUE;

end FD1S3BX ;
 
-- architecture body --
architecture V of FD1S3BX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, PD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '1', '0' ),  -- Async. Preset 
	( '-', '0', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '0', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '0', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Preset      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    Preset := VitalOR2 (a => NOT(GSRNET), b => PD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Preset, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (PD_ipd'LAST_EVENT, tpd_PD_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (PD_ipd'LAST_EVENT, tpd_PD_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S3DX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S3DX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S3DX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_CD	: VitalDelayType := 0.1 ns;
        tpw_CD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S3DX : entity is TRUE;

end FD1S3DX ;
 
-- architecture body --
architecture V of FD1S3DX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, CD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '0', '1' ),  -- Async. Clear
	( '-', '0', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '0', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '0', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Clear	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CK;
 
    Clear := VitalOR2 (a => NOT(GSRNET), b => CD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Clear, CK_ipd, D_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (CD_ipd'LAST_EVENT, tpd_CD_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (CD_ipd'LAST_EVENT, tpd_CD_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S3IX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S3IX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S3IX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_CD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_CD	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_CD	: VitalDelayType := 0.1 ns;
        tpw_CD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S3IX : entity is TRUE;

end FD1S3IX ;
 
-- architecture body --
architecture V of FD1S3IX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_CD     : X01 := '0';
   VARIABLE D_CK_TimingDataSH      : VitalTimingDataType;
   VARIABLE CD_CK_TimingDataSH      : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE SynClr 	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => CD_ipd, TestSignalName => "CD",
            RefSignal => CK_ipd, RefSignalName => "CK",
            SetupHigh => tsetup_CD_CK, SetupLow => tsetup_CD_CK,
            HoldHigh => thold_CK_CD, HoldLow => thold_CK_CD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => CD_CK_TimingDataSH,
            Violation => Tviol_CD, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_CD OR Tviol_CK;
 
    SynClr := VitalAND2 (a => D_ipd, b => NOT(CD_ipd));  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, SynClr),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FD1S3JX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FD1S3JX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FD1S3JX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D	: VitalDelayType := 0.1 ns;
        tsetup_PD_CK	: VitalDelayType := 0.1 ns;
        thold_CK_PD	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;
        tperiod_PD	: VitalDelayType := 0.1 ns;
        tpw_PD		: VitalDelayType := 0.1 ns);
 
    port (
        D               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FD1S3JX : entity is TRUE;

end FD1S3JX ;
 
-- architecture body --
architecture V of FD1S3JX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D_ipd, D, tipd_D);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising edge CK
	( '-', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising edge CK
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D     : X01 := '0';
   VARIABLE Tviol_PD    : X01 := '0';
   VARIABLE D_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PD_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE SynPre 	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D_ipd, TestSignalName => "D", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D_CK, SetupLow => tsetup_D_CK,
            HoldHigh => thold_CK_D, HoldLow => thold_CK_D,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D_CK_TimingDataSH, 
	    Violation => Tviol_D, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => PD_ipd, TestSignalName => "PD", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_PD_CK, SetupLow => tsetup_PD_CK,
            HoldHigh => thold_CK_PD, HoldLow => thold_CK_PD,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => PD_CK_TimingDataSH, 
	    Violation => Tviol_PD, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D OR Tviol_PD OR Tviol_CK;
 
    SynPre := VitalOR2 (a => D_ipd, b => PD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, SynPre),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FJ1S3AX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FJ1S3AX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FJ1S3AX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_J_CK	: VitalDelayType := 0.1 ns;
        thold_CK_J	: VitalDelayType := 0.1 ns;
        tsetup_K_CK	: VitalDelayType := 0.1 ns;
        thold_CK_K	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_J		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_K		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        J               : in STD_LOGIC;
        K               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FJ1S3AX : entity is TRUE;

end FJ1S3AX ;
 
-- architecture body --
architecture V of FJ1S3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal J_ipd   : STD_LOGIC := '0';
    signal K_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(J_ipd, J, tipd_J);
       VitalWireDelay(K_ipd, K, tipd_K);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (J_ipd, K_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- Viol  CLR  CK    J    K    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '/', '0', '0', '-', 'S', 'S' ),  -- Low j&k on rising CK
	( '-', '1', '/', '0', '1', '-', '0', '1' ),  -- High k->low q on rising CK
	( '-', '1', '/', '1', '0', '-', '1', '0' ),  -- High j->q on rising CK
	( '-', '1', '/', '1', '1', '0', '1', '0' ),  -- High j&k on rising CK
	( '-', '1', '/', '1', '1', '1', '0', '1' ),  -- High j&k on rising CK
	( '-', '1', '/', 'X', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'B', '-', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_J     : X01 := '0';
   VARIABLE Tviol_K     : X01 := '0';
   VARIABLE J_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE K_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => J_ipd, TestSignalName => "J", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_J_CK, SetupLow => tsetup_J_CK,
            HoldHigh => thold_CK_J, HoldLow => thold_CK_J,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => J_CK_TimingDataSH, 
	    Violation => Tviol_J, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => K_ipd, TestSignalName => "K", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_K_CK, SetupLow => tsetup_K_CK,
            HoldHigh => thold_CK_K, HoldLow => thold_CK_K,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => K_CK_TimingDataSH, 
	    Violation => Tviol_K, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_J OR Tviol_K OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, J_ipd, K_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FJ1S3BX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FJ1S3BX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FJ1S3BX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_QN       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_J_CK	: VitalDelayType := 0.1 ns;
        thold_CK_J	: VitalDelayType := 0.1 ns;
        tsetup_K_CK	: VitalDelayType := 0.1 ns;
        thold_CK_K	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_J		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_K		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        J               : in STD_LOGIC;
        K               : in STD_LOGIC;
        PD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FJ1S3BX : entity is TRUE;

end FJ1S3BX ;
 
-- architecture body --
architecture V of FJ1S3BX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal J_ipd   : STD_LOGIC := '0';
    signal K_ipd   : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(J_ipd, J, tipd_J);
       VitalWireDelay(K_ipd, K, tipd_K);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (J_ipd, K_ipd, PD_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- Viol  PRE  CK    J    K    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '-', '1', '0' ),  -- Async. Preset
	( '-', '0', '/', '0', '0', '-', 'S', 'S' ),  -- Low j&k on rising CK
	( '-', '0', '/', '0', '1', '-', '0', '1' ),  -- High k->low q on rising CK
	( '-', '0', '/', '1', '0', '-', '1', '0' ),  -- High j->q on rising CK
	( '-', '0', '/', '1', '1', '0', '1', '0' ),  -- High j&k on rising CK
	( '-', '0', '/', '1', '1', '1', '0', '1' ),  -- High j&k on rising CK
	( '-', '0', '/', 'X', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '0', 'B', '-', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_J     : X01 := '0';
   VARIABLE Tviol_K     : X01 := '0';
   VARIABLE J_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE K_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Preset	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => J_ipd, TestSignalName => "J", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_J_CK, SetupLow => tsetup_J_CK,
            HoldHigh => thold_CK_J, HoldLow => thold_CK_J,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => J_CK_TimingDataSH, 
	    Violation => Tviol_J, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => K_ipd, TestSignalName => "K", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_K_CK, SetupLow => tsetup_K_CK,
            HoldHigh => thold_CK_K, HoldLow => thold_CK_K,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => K_CK_TimingDataSH, 
	    Violation => Tviol_K, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_J OR Tviol_K OR Tviol_CK;
 
    Preset := VitalOR2 (a => NOT(GSRNET), b => PD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Preset, CK_ipd, J_ipd, K_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
                1 => (PD_ipd'LAST_EVENT, tpd_PD_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
                1 => (PD_ipd'LAST_EVENT, tpd_PD_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FJ1S3DX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FJ1S3DX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FJ1S3DX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_QN       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_J_CK	: VitalDelayType := 0.1 ns;
        thold_CK_J	: VitalDelayType := 0.1 ns;
        tsetup_K_CK	: VitalDelayType := 0.1 ns;
        thold_CK_K	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_J		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_K		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        J               : in STD_LOGIC;
        K               : in STD_LOGIC;
        CD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FJ1S3DX : entity is TRUE;

end FJ1S3DX ;
 
-- architecture body --
architecture V of FJ1S3DX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal J_ipd   : STD_LOGIC := '0';
    signal K_ipd   : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(J_ipd, J, tipd_J);
       VitalWireDelay(K_ipd, K, tipd_K);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (J_ipd, K_ipd, CD_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- Viol  CLR  CK    J    K    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear
	( '-', '0', '/', '0', '0', '-', 'S', 'S' ),  -- Low j&k on rising CK
	( '-', '0', '/', '0', '1', '-', '0', '1' ),  -- High k->low q on rising CK
	( '-', '0', '/', '1', '0', '-', '1', '0' ),  -- High j->q on rising CK
	( '-', '0', '/', '1', '1', '0', '1', '0' ),  -- High j&k on rising CK
	( '-', '0', '/', '1', '1', '1', '0', '1' ),  -- High j&k on rising CK
	( '-', '0', '/', 'X', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '0', 'B', '-', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_J     : X01 := '0';
   VARIABLE Tviol_K     : X01 := '0';
   VARIABLE J_CK_TimingDataSH      : VitalTimingDataType;
   VARIABLE K_CK_TimingDataSH      : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Clear	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => J_ipd, TestSignalName => "J", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_J_CK, SetupLow => tsetup_J_CK,
            HoldHigh => thold_CK_J, HoldLow => thold_CK_J,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => J_CK_TimingDataSH, 
	    Violation => Tviol_J, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => K_ipd, TestSignalName => "K", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_K_CK, SetupLow => tsetup_K_CK,
            HoldHigh => thold_CK_K, HoldLow => thold_CK_K,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => K_CK_TimingDataSH, 
	    Violation => Tviol_K, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_J OR Tviol_K OR Tviol_CK;
 
    Clear := VitalOR2 (a => NOT(GSRNET), b => CD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Clear, CK_ipd, J_ipd, K_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
                1 => (CD_ipd'LAST_EVENT, tpd_CD_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
                1 => (CD_ipd'LAST_EVENT, tpd_CD_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FL1P3AY -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FL1P3AY is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FL1P3AY";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D0	: VitalDelayType := 0.1 ns;
        tsetup_D1_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D1	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D0              : in STD_LOGIC;
        D1              : in STD_LOGIC;
	SD              : in STD_LOGIC;
	SP              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FL1P3AY : entity is TRUE;

end FL1P3AY ;
 
-- architecture body --
architecture V of FL1P3AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D0_ipd  : STD_LOGIC := '0';
    signal D1_ipd  : STD_LOGIC := '0';
    signal SD_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D0_ipd, D0, tipd_D0);
       VitalWireDelay(D1_ipd, D1, tipd_D1);
       VitalWireDelay(SD_ipd, SD, tipd_SD);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, SD_ipd, SP_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  PRE  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising CK
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising CK
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce IS x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE Tviol_D0    : X01 := '0';
   VARIABLE Tviol_D1    : X01 := '0';
   VARIABLE D0_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE D1_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Muxout      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D0_ipd, TestSignalName => "D0", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D0_CK, SetupLow => tsetup_D0_CK,
            HoldHigh => thold_CK_D0, HoldLow => thold_CK_D0,
            CheckEnabled => (GSRNET='1' AND SP_ipd='1' AND SD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D0_CK_TimingDataSH, 
	    Violation => Tviol_D0, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => D1_ipd, TestSignalName => "D1", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D1_CK, SetupLow => tsetup_D1_CK,
            HoldHigh => thold_CK_D1, HoldLow => thold_CK_D1,
            CheckEnabled => (GSRNET='1' AND SP_ipd='1' AND SD_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D1_CK_TimingDataSH, 
	    Violation => Tviol_D1, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => SP_ipd, TestSignalName => "SP", 
            RefSignal => CK_ipd, RefSignalName => "CK", 
            SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
            Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D0 OR Tviol_D1 OR Tviol_CK OR Tviol_SP;
 
    Muxout := VitalMUX
                 (data => (D1_ipd, D0_ipd),
                  dselect => (0 => SD_ipd));

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, SP_ipd, CK_ipd, Muxout),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
                1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FL1P3AZ -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FL1P3AZ is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FL1P3AZ";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D0	: VitalDelayType := 0.1 ns;
        tsetup_D1_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D1	: VitalDelayType := 0.1 ns;
        tsetup_SP_CK	: VitalDelayType := 0.1 ns;
        thold_CK_SP	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D0              : in STD_LOGIC;
        D1              : in STD_LOGIC;
	SD              : in STD_LOGIC;
	SP              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FL1P3AZ : entity is TRUE;

end FL1P3AZ ;
 
-- architecture body --
architecture V of FL1P3AZ is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D0_ipd  : STD_LOGIC := '0';
    signal D1_ipd  : STD_LOGIC := '0';
    signal SD_ipd  : STD_LOGIC := '0';
    signal SP_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D0_ipd, D0, tipd_D0);
       VitalWireDelay(D1_ipd, D1, tipd_D1);
       VitalWireDelay(SD_ipd, SD, tipd_SD);
       VitalWireDelay(SP_ipd, SP, tipd_SP);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, SD_ipd, SP_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  CLR  CE   CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- Clock disabled
	( '-', '1', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising CK
	( '-', '1', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising CK
	( '-', '1', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
        ( '-', '1', 'X', '/', '-', '-', 'X', 'X' ),  -- ce IS x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_SP    : X01 := '0';
   VARIABLE Tviol_D0    : X01 := '0';
   VARIABLE Tviol_D1    : X01 := '0';
   VARIABLE D0_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE D1_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE SP_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Muxout      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D0_ipd, TestSignalName => "D0", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D0_CK, SetupLow => tsetup_D0_CK,
            HoldHigh => thold_CK_D0, HoldLow => thold_CK_D0,
            CheckEnabled => (GSRNET='1' AND SP_ipd='1' AND SD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D0_CK_TimingDataSH, 
	    Violation => Tviol_D0, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => D1_ipd, TestSignalName => "D1", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D1_CK, SetupLow => tsetup_D1_CK,
            HoldHigh => thold_CK_D1, HoldLow => thold_CK_D1,
            CheckEnabled => (GSRNET='1' AND SP_ipd='1' AND SD_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D1_CK_TimingDataSH, 
	    Violation => Tviol_D1, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
            TestSignal => SP_ipd, TestSignalName => "SP", 
            RefSignal => CK_ipd, RefSignalName => "CK", 
            SetupHigh => tsetup_SP_CK, SetupLow => tsetup_SP_CK,
            HoldHigh => thold_CK_SP, HoldLow => thold_CK_SP,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, TimingData => SP_CK_TimingDataSH, 
            Violation => Tviol_SP, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D0 OR Tviol_D1 OR Tviol_CK OR Tviol_SP;
 
    Muxout := VitalMUX
                 (data => (D1_ipd, D0_ipd),
                  dselect => (0 => SD_ipd));

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, SP_ipd, CK_ipd, Muxout),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
                1 => (SP_ipd'LAST_EVENT, tpd_SP_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (SP_ipd'LAST_EVENT, tpd_SP_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FL1S1A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FL1S1A is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FL1S1A";
        -- Propagation Delays
        tpd_D0_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D0_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D1_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D1_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SD_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SD_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D0	: VitalDelayType := 0.1 ns;
        tsetup_D1_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D1	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D0              : in STD_LOGIC;
        D1              : in STD_LOGIC;
	SD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FL1S1A : entity is TRUE;

end FL1S1A ;
 
-- architecture body --
architecture V of FL1S1A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D0_ipd  : STD_LOGIC := '0';
    signal D1_ipd  : STD_LOGIC := '0';
    signal SD_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D0_ipd, D0, tipd_D0);
       VitalWireDelay(D1_ipd, D1, tipd_D1);
       VitalWireDelay(SD_ipd, SD, tipd_SD);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, SD_ipd, CK_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- Low d->q on high CK
	( '-', '1', '1', '1', '-', '1', '0' ),  -- High d->q on high CK
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D0    : X01 := '0';
   VARIABLE Tviol_D1    : X01 := '0';
   VARIABLE D0_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE D1_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Muxout      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D0_ipd, TestSignalName => "D0", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D0_CK, SetupLow => tsetup_D0_CK,
            HoldHigh => thold_CK_D0, HoldLow => thold_CK_D0,
            CheckEnabled => (GSRNET='1' AND SD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D0_CK_TimingDataSH, 
	    Violation => Tviol_D0, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => D1_ipd, TestSignalName => "D1", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D1_CK, SetupLow => tsetup_D1_CK,
            HoldHigh => thold_CK_D1, HoldLow => thold_CK_D1,
            CheckEnabled => (GSRNET='1' AND SD_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D1_CK_TimingDataSH, 
	    Violation => Tviol_D1, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D0 OR Tviol_D1 OR Tviol_CK;
 
    Muxout := VitalMUX
                 (data => (D1_ipd, D0_ipd),
                  dselect => (0 => SD_ipd));

    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, GSRNET, CK_ipd, Muxout),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (D0_ipd'LAST_EVENT, tpd_D0_Q, TRUE),
		2 => (D1_ipd'LAST_EVENT, tpd_D1_Q, TRUE),
		3 => (SD_ipd'LAST_EVENT, tpd_SD_Q, TRUE),
		4 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (D0_ipd'LAST_EVENT, tpd_D0_QN, TRUE),
		2 => (D1_ipd'LAST_EVENT, tpd_D1_QN, TRUE),
		3 => (SD_ipd'LAST_EVENT, tpd_SD_QN, TRUE),
		4 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FL1S1AY -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FL1S1AY is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FL1S1AY";
        -- Propagation Delays
        tpd_D0_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D0_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D1_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_D1_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SD_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SD_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D0	: VitalDelayType := 0.1 ns;
        tsetup_D1_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D1	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D0              : in STD_LOGIC;
        D1              : in STD_LOGIC;
	SD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FL1S1AY : entity is TRUE;

end FL1S1AY ;
 
-- architecture body --
architecture V of FL1S1AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D0_ipd  : STD_LOGIC := '0';
    signal D1_ipd  : STD_LOGIC := '0';
    signal SD_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D0_ipd, D0, tipd_D0);
       VitalWireDelay(D1_ipd, D1, tipd_D1);
       VitalWireDelay(SD_ipd, SD, tipd_SD);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, SD_ipd, CK_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '0', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '1', '1', '0', '-', '0', '1' ),  -- Low d->q on high CK
	( '-', '1', '1', '1', '-', '1', '0' ),  -- High d->q on high CK
	( '-', '1', '1', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D0    : X01 := '0';
   VARIABLE Tviol_D1    : X01 := '0';
   VARIABLE D0_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE D1_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Muxout      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D0_ipd, TestSignalName => "D0", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D0_CK, SetupLow => tsetup_D0_CK,
            HoldHigh => thold_CK_D0, HoldLow => thold_CK_D0,
            CheckEnabled => (GSRNET='1' AND SD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D0_CK_TimingDataSH, 
	    Violation => Tviol_D0, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => D1_ipd, TestSignalName => "D1", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D1_CK, SetupLow => tsetup_D1_CK,
            HoldHigh => thold_CK_D1, HoldLow => thold_CK_D1,
            CheckEnabled => (GSRNET='1' AND SD_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D1_CK_TimingDataSH, 
	    Violation => Tviol_D1, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D0 OR Tviol_D1 OR Tviol_CK;
 
    Muxout := VitalMUX
                 (data => (D1_ipd, D0_ipd),
                  dselect => (0 => SD_ipd));

    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, GSRNET, CK_ipd, Muxout),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (D0_ipd'LAST_EVENT, tpd_D0_Q, TRUE),
		2 => (D1_ipd'LAST_EVENT, tpd_D1_Q, TRUE),
		3 => (SD_ipd'LAST_EVENT, tpd_SD_Q, TRUE),
		4 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (D0_ipd'LAST_EVENT, tpd_D0_QN, TRUE),
		2 => (D1_ipd'LAST_EVENT, tpd_D1_QN, TRUE),
		3 => (SD_ipd'LAST_EVENT, tpd_SD_QN, TRUE),
		4 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FL1S3AX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FL1S3AX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FL1S3AX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D0	: VitalDelayType := 0.1 ns;
        tsetup_D1_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D1	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D0              : in STD_LOGIC;
        D1              : in STD_LOGIC;
	SD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FL1S3AX : entity is TRUE;

end FL1S3AX ;
 
-- architecture body --
architecture V of FL1S3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D0_ipd  : STD_LOGIC := '0';
    signal D1_ipd  : STD_LOGIC := '0';
    signal SD_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D0_ipd, D0, tipd_D0);
       VitalWireDelay(D1_ipd, D1, tipd_D1);
       VitalWireDelay(SD_ipd, SD, tipd_SD);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, SD_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  CLR  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising CK
	( '-', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising CK
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D0    : X01 := '0';
   VARIABLE Tviol_D1    : X01 := '0';
   VARIABLE D0_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE D1_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Muxout      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D0_ipd, TestSignalName => "D0", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D0_CK, SetupLow => tsetup_D0_CK,
            HoldHigh => thold_CK_D0, HoldLow => thold_CK_D0,
            CheckEnabled => (GSRNET='1' AND SD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D0_CK_TimingDataSH, 
	    Violation => Tviol_D0, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => D1_ipd, TestSignalName => "D1", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D1_CK, SetupLow => tsetup_D1_CK,
            HoldHigh => thold_CK_D1, HoldLow => thold_CK_D1,
            CheckEnabled => (GSRNET='1' AND SD_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D1_CK_TimingDataSH, 
	    Violation => Tviol_D1, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D0 OR Tviol_D1 OR Tviol_CK;
 
    Muxout := VitalMUX
                 (data => (D1_ipd, D0_ipd),
                  dselect => (0 => SD_ipd));

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, Muxout),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FL1S3AY -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FL1S3AY is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FL1S3AY";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D0	: VitalDelayType := 0.1 ns;
        tsetup_D1_CK	: VitalDelayType := 0.1 ns;
        thold_CK_D1	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        D0              : in STD_LOGIC;
        D1              : in STD_LOGIC;
	SD              : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FL1S3AY : entity is TRUE;

end FL1S3AY ;
 
-- architecture body --
architecture V of FL1S3AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal D0_ipd  : STD_LOGIC := '0';
    signal D1_ipd  : STD_LOGIC := '0';
    signal SD_ipd  : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(D0_ipd, D0, tipd_D0);
       VitalWireDelay(D1_ipd, D1, tipd_D1);
       VitalWireDelay(SD_ipd, SD, tipd_SD);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, SD_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 6, 1 to 7) := (
      -- Viol  PRE  CK    D    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '1', '0' ),  -- Async. Preset (active low)
	( '-', '1', '/', '0', '-', '0', '1' ),  -- Low d->q on rising CK
	( '-', '1', '/', '1', '-', '1', '0' ),  -- High d->q on rising CK
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if d is X
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_D0    : X01 := '0';
   VARIABLE Tviol_D1    : X01 := '0';
   VARIABLE D0_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE D1_CK_TimingDataSH : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Muxout      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => D0_ipd, TestSignalName => "D0", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D0_CK, SetupLow => tsetup_D0_CK,
            HoldHigh => thold_CK_D0, HoldLow => thold_CK_D0,
            CheckEnabled => (GSRNET='1' AND SD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D0_CK_TimingDataSH, 
	    Violation => Tviol_D0, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => D1_ipd, TestSignalName => "D1", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_D1_CK, SetupLow => tsetup_D1_CK,
            HoldHigh => thold_CK_D1, HoldLow => thold_CK_D1,
            CheckEnabled => (GSRNET='1' AND SD_ipd='1'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => D1_CK_TimingDataSH, 
	    Violation => Tviol_D1, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_D0 OR Tviol_D1 OR Tviol_CK;
 
    Muxout := VitalMUX
                 (data => (D1_ipd, D0_ipd),
                  dselect => (0 => SD_ipd));

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, Muxout),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FS1S1A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FS1S1A is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FS1S1A";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_S_CK	: VitalDelayType := 0.1 ns;
        thold_CK_S	: VitalDelayType := 0.1 ns;
        tsetup_R_CK	: VitalDelayType := 0.1 ns;
        thold_CK_R	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_S		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_R		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        S               : in STD_LOGIC;
        R               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FS1S1A : entity is TRUE;

end FS1S1A ;
 
-- architecture body --
architecture V of FS1S1A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal S_ipd   : STD_LOGIC := '0';
    signal R_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(S_ipd, S, tipd_S);
       VitalWireDelay(R_ipd, R, tipd_R);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (S_ipd, R_ipd, CK_ipd, GSRNET)

   CONSTANT Latch_table : VitalStateTableType (1 to 8, 1 to 8) := (
      -- Viol  CLR  CK    S    R    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S', 'S' ),  -- Clock low
	( '-', '1', '1', '0', '0', '-', 'S', 'S' ),  -- Low s&r on high CK
	( '-', '1', '1', '0', '1', '-', '0', '1' ),  -- High r->low q on high CK
	( '-', '1', '1', '1', '0', '-', '1', '0' ),  -- High s->q on high CK
	( '-', '1', '1', '1', '1', '-', '0', '1' ),  -- High r->low q on high CK
	( '-', '1', '1', 'X', 'X', '-', 'X', 'X' ) );  -- Clock an X if d is X
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_S     : X01 := '0';
   VARIABLE Tviol_R     : X01 := '0';
   VARIABLE S_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE R_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => S_ipd, TestSignalName => "S", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_S_CK, SetupLow => tsetup_S_CK,
            HoldHigh => thold_CK_S, HoldLow => thold_CK_S,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => S_CK_TimingDataSH, 
	    Violation => Tviol_S, MsgSeverity => WARNING);
        VitalSetupHoldCheck (
	    TestSignal => R_ipd, TestSignalName => "R", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_R_CK, SetupLow => tsetup_R_CK,
            HoldHigh => thold_CK_R, HoldLow => thold_CK_R,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => R_CK_TimingDataSH, 
	    Violation => Tviol_R, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_S OR Tviol_R OR Tviol_CK;
 
    VitalStateTable (StateTable => Latch_table,
	    DataIn => (Violation, GSRNET, CK_ipd, S_ipd, R_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FT1S3AX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FT1S3AX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FT1S3AX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_T_CK	: VitalDelayType := 0.1 ns;
        thold_CK_T	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_T		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        T               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FT1S3AX : entity is TRUE;

end FT1S3AX ;
 
-- architecture body --
architecture V of FT1S3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal T_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(T_ipd, T, tipd_T);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (T_ipd, CK_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 7, 1 to 7) := (
      -- Viol  CLR  CK    T    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '0', '-', '-', '-', '0', '1' ),  -- Async. Clear (active low)
	( '-', '1', '/', '0', '-', 'S', 'S' ),  -- Low t on rising edge CK
	( '-', '1', '/', '1', '0', '1', '0' ),  -- High t on rising edge CK
	( '-', '1', '/', '1', '1', '0', '1' ),  -- High t on rising edge CK
	( '-', '1', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if t is X
	( '-', '1', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_T     : X01 := '0';
   VARIABLE T_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => T_ipd, TestSignalName => "T", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_T_CK, SetupLow => tsetup_T_CK,
            HoldHigh => thold_CK_T, HoldLow => thold_CK_T,
            CheckEnabled => (GSRNET='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => T_CK_TimingDataSH, 
	    Violation => Tviol_T, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_T OR Tviol_CK;
 
    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, GSRNET, CK_ipd, T_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
		1 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FT1S3BX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FT1S3BX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FT1S3BX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_QN       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_T_CK	: VitalDelayType := 0.1 ns;
        thold_CK_T	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_T		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        T               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        PD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FT1S3BX : entity is TRUE;

end FT1S3BX ;
 
-- architecture body --
architecture V of FT1S3BX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal T_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal PD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(T_ipd, T, tipd_T);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(PD_ipd, PD, tipd_PD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (T_ipd, CK_ipd, PD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 7, 1 to 7) := (
      -- Viol  PRE  CK    T    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '1', '0' ),  -- Async. Preset
	( '-', '0', '/', '0', '-', 'S', 'S' ),  -- Low t on rising edge CK
	( '-', '0', '/', '1', '0', '1', '0' ),  -- High t on rising edge CK
	( '-', '0', '/', '1', '1', '0', '1' ),  -- High t on rising edge CK
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if t is X
	( '-', '0', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_T     : X01 := '0';
   VARIABLE T_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "10";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Preset      : STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => T_ipd, TestSignalName => "T", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_T_CK, SetupLow => tsetup_T_CK,
            HoldHigh => thold_CK_T, HoldLow => thold_CK_T,
            CheckEnabled => (GSRNET='1' AND PD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => T_CK_TimingDataSH, 
	    Violation => Tviol_T, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_T OR Tviol_CK;
 
    Preset := VitalOR2 (a => NOT(GSRNET), b => PD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Preset, CK_ipd, T_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
                1 => (PD_ipd'LAST_EVENT, tpd_PD_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
                1 => (PD_ipd'LAST_EVENT, tpd_PD_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


--
----- FT1S3DX -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.GSRNET;
 
entity FT1S3DX is
    generic (
        TimingChecksOn	: Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath	: String := "FT1S3DX";
        -- Propagation Delays
        tpd_CK_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_QN       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_T_CK	: VitalDelayType := 0.1 ns;
        thold_CK_T	: VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_T		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK	: VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns);
 
    port (
        T               : in STD_LOGIC;
        CK              : in STD_LOGIC;
        CD              : in STD_LOGIC;
        Q               : out STD_LOGIC;
        QN              : out STD_LOGIC);

    attribute VITAL_LEVEL0 of FT1S3DX : entity is TRUE;

end FT1S3DX ;
 
-- architecture body --
architecture V of FT1S3DX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

    signal T_ipd   : STD_LOGIC := '0';
    signal CK_ipd  : STD_LOGIC := '0';
    signal CD_ipd  : STD_LOGIC := '0';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(T_ipd, T, tipd_T);
       VitalWireDelay(CK_ipd, CK, tipd_CK);
       VitalWireDelay(CD_ipd, CD, tipd_CD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (T_ipd, CK_ipd, CD_ipd, GSRNET)

   CONSTANT FF_table : VitalStateTableType (1 to 7, 1 to 7) := (
      -- Viol  CLR  CK    T    Q  Qnew QNnew
	( 'X', '-', '-', '-', '-', 'X', 'X' ),  -- Timing Violation
	( '-', '1', '-', '-', '-', '0', '1' ),  -- Async. Clear
	( '-', '0', '/', '0', '-', 'S', 'S' ),  -- Low t on rising edge CK
	( '-', '0', '/', '1', '0', '1', '0' ),  -- High t on rising edge CK
	( '-', '0', '/', '1', '1', '0', '1' ),  -- High t on rising edge CK
	( '-', '0', '/', 'X', '-', 'X', 'X' ),  -- Clock an X if t is X
	( '-', '0', 'B', '-', '-', 'S', 'S' ) );  -- Non-X clock (e.g. falling) preserve Q
	
   -- Timing Check results 
   VARIABLE Tviol_CK    : X01 := '0';
   VARIABLE Tviol_T     : X01 := '0';
   VARIABLE T_CK_TimingDataSH  : VitalTimingDataType;
   VARIABLE PeriodCheckInfo_CK : VitalPeriodDataType;
 
   -- Functionality results 
   VARIABLE Violation   : X01 := '0';
   VARIABLE PrevData    : STD_LOGIC_VECTOR (0 to 5) := (others=>'X');
   VARIABLE Results     : STD_LOGIC_VECTOR (1 to 2) := "01";
   ALIAS Q_zd 		: STD_ULOGIC is Results(1);
   ALIAS QN_zd 		: STD_ULOGIC is Results(2);
   VARIABLE Clear	: STD_LOGIC := 'X';
   VARIABLE tpd_GSR_Q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_GSR_QN 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- Output Glitch detection variables
   VARIABLE Q_GlitchData     : VitalGlitchDataType;
   VARIABLE QN_GlitchData    : VitalGlitchDataType;

 
   begin

   ------------------------
   --  Timing Check Section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => T_ipd, TestSignalName => "T", 
	    RefSignal => CK_ipd, RefSignalName => "CK", 
	    SetupHigh => tsetup_T_CK, SetupLow => tsetup_T_CK,
            HoldHigh => thold_CK_T, HoldLow => thold_CK_T,
            CheckEnabled => (GSRNET='1' AND CD_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => T_CK_TimingDataSH, 
	    Violation => Tviol_T, MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
	    TestSignal => CK_ipd, TestSignalName => "CK", 
	    Period => tperiod_CK,
            PulseWidthHigh => tpw_CK, 
	    PulseWidthLow => tpw_CK, 
	    PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => WARNING);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Violation := Tviol_T OR Tviol_CK;
 
    Clear := VitalOR2 (a => NOT(GSRNET), b => CD_ipd);  

    VitalStateTable (StateTable => FF_table,
	    DataIn => (Violation, Clear, CK_ipd, T_ipd),
	    NumStates => 1,
	    Result => Results,
	    PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => Q,
      OutSignalName => "Q",
      OutTemp => Q_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_Q, 
		      PathCondition => TRUE),
                1 => (CD_ipd'LAST_EVENT, tpd_CD_Q, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_Q, TRUE)),
      GlitchData => Q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

    VitalPathDelay01 (
      OutSignal => QN,
      OutSignalName => "QN",
      OutTemp => QN_zd,
      Paths => (0 => (InputChangeTime => CK_ipd'LAST_EVENT, 
	              PathDelay => tpd_CK_QN, 
		      PathCondition => TRUE),
                1 => (CD_ipd'LAST_EVENT, tpd_CD_QN, TRUE),
		2 => (GSRNET'LAST_EVENT, tpd_GSR_QN, TRUE)),
      GlitchData => QN_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
end process;
 
end V;


