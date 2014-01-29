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
-- $Header:  
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SLUTA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SLUTA";

        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LUT1_INITVAL    : bit_vector := X"0000";
        LUT0_INITVAL    : bit_vector := X"0000";

        -- input SIGNAL delays
        tipd_M1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FXA : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FXB : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0  : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_FXA_OFX1  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FXB_OFX1  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M1_OFX1   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_OFX0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_OFX0   : VitalDelayType01 := (0 ns, 0 ns)
        );

   PORT(
        M1, FXA, FXB, A1, B1, C1, D1                      : in std_ulogic := 'X';
        A0, B0, C0, D0, M0                                : in std_ulogic := 'X';
        OFX1, F1, OFX0, F0                                : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SLUTA : ENTITY IS TRUE;

END SLUTA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SLUTA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal M1_ipd       : std_logic := 'X';
    signal FXA_ipd      : std_logic := 'X';
    signal FXB_ipd      : std_logic := 'X';
    signal A1_ipd       : std_logic := 'X';
    signal B1_ipd       : std_logic := 'X';
    signal C1_ipd       : std_logic := 'X';
    signal D1_ipd       : std_logic := 'X';
    signal A0_ipd       : std_logic := 'X';
    signal B0_ipd       : std_logic := 'X';
    signal C0_ipd       : std_logic := 'X';
    signal D0_ipd       : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal F0_buf       : std_logic := 'X';
    signal F1_buf       : std_logic := 'X';
    signal M1_sig       : std_logic := 'X';
    signal M0_sig       : std_logic := 'X';
    signal OFX1_buf     : std_logic := 'X';
    signal OFX0_buf     : std_logic := 'X';

BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(M1_ipd, M1, tipd_M1);
      VitalWireDelay(FXA_ipd, FXA, tipd_FXA);
      VitalWireDelay(FXB_ipd, FXB, tipd_FXB);
      VitalWireDelay(A1_ipd, A1, tipd_A1);
      VitalWireDelay(B1_ipd, B1, tipd_B1);
      VitalWireDelay(C1_ipd, C1, tipd_C1);
      VitalWireDelay(D1_ipd, D1, tipd_D1);
      VitalWireDelay(A0_ipd, A0, tipd_A0);
      VitalWireDelay(B0_ipd, B0, tipd_B0);
      VitalWireDelay(C0_ipd, C0, tipd_C0);
      VitalWireDelay(D0_ipd, D0, tipd_D0);
      VitalWireDelay(M0_ipd, M0, tipd_M0);
    END BLOCK;

    P1 : PROCESS (A0_ipd, B0_ipd, C0_ipd, D0_ipd)
    BEGIN
       F0_buf <= VitalMUX
                      (data => To_StdLogicVector(LUT0_INITVAL),
                      dselect => (D0_ipd, C0_ipd, B0_ipd, A0_ipd));
    END PROCESS;

    P2 : PROCESS (A1_ipd, B1_ipd, C1_ipd, D1_ipd)
    BEGIN
       F1_buf <= VitalMUX
                      (data => To_StdLogicVector(LUT1_INITVAL),
                      dselect => (D1_ipd, C1_ipd, B1_ipd, A1_ipd));
    END PROCESS;

    P11 : PROCESS (M1_ipd, M0_ipd)
    BEGIN
       IF (M1MUX = "SIG") THEN
          M1_sig <= M1_ipd;
       ELSIF (M1MUX = "INV") THEN
          M1_sig <= not M1_ipd;
       ELSIF (M1MUX = "VHI") THEN
          M1_sig <= '1';
       ELSE
          M1_sig <= '0';
       END IF;

       IF (M0MUX = "SIG") THEN
          M0_sig <= M0_ipd;
       ELSIF (M0MUX = "INV") THEN
          M0_sig <= not M0_ipd;
       ELSIF (M0MUX = "VHI") THEN
          M0_sig <= '1';
       ELSE
          M0_sig <= '0';
       END IF;
    END PROCESS;

    P3 : PROCESS (M1_sig, FXA_ipd, FXB_ipd)
    BEGIN
       OFX1_buf <= VitalMUX
                        (data => (FXB_ipd, FXA_ipd),
                         dselect => (0 => M1_sig));
    END PROCESS;

    P4 : PROCESS (M0_sig, F1_buf, F0_buf)
    BEGIN
       OFX0_buf <= VitalMUX
                        (data => (F1_buf, F0_buf),
                         dselect => (0 => M0_sig));
    END PROCESS;


    VitalBehavior : PROCESS (M1_ipd, FXA_ipd, FXB_ipd, A1_ipd, B1_ipd, C1_ipd, D1_ipd,
      A0_ipd, B0_ipd, C0_ipd, D0_ipd, M0_ipd, OFX0_buf, OFX1_buf, F1_buf, F0_buf)

    VARIABLE OFX1_zd            : std_logic := 'X';
    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE OFX0_zd            : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE OFX1_GlitchData    : VitalGlitchDataType;
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE OFX0_GlitchData    : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;

  BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    OFX0_zd := OFX0_buf;
    OFX1_zd := OFX1_buf;
    F1_zd := F1_buf;
    F0_zd := F0_buf;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => OFX1,
       OutSignalName => "OFX1",
       OutTemp => OFX1_zd,
       Paths => (0 => (InputChangeTime => FXA_ipd'last_event, 
                       PathDelay => tpd_FXA_OFX1, 
                       PathCondition => TRUE),
                 1 => (M1_ipd'last_event, tpd_M1_OFX1, PathCondition => TRUE),
                 2 => (FXB_ipd'last_event, tpd_FXB_OFX1, PathCondition => TRUE)),
       GlitchData => OFX1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F1,
       OutSignalName => "F1",
       OutTemp => F1_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_F1,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_F1, TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_F1, TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_F1, TRUE)),
       GlitchData => F1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => OFX0,
       OutSignalName => "OFX0",
       OutTemp => OFX0_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_OFX0,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_OFX0, TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_OFX0, TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_OFX0, TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_OFX0, TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_OFX0, TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_OFX0, TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_OFX0, TRUE),
                 8 => (M0'last_event, tpd_M0_OFX0, PathCondition => TRUE)),
       GlitchData => OFX0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F0,
       OutSignalName => "F0",
       OutTemp => F0_zd,
       Paths => (0 => (InputChangeTime => A0_ipd'last_event,
                       PathDelay => tpd_A0_F0,
                       PathCondition => TRUE),
                 1 => (B0_ipd'last_event, tpd_B0_F0, TRUE),
                 2 => (C0_ipd'last_event, tpd_C0_F0, TRUE),
                 3 => (D0_ipd'last_event, tpd_D0_F0, TRUE)),
       GlitchData => F0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SLOGICB IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SLOGICB";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        LUT1_INITVAL    : bit_vector := X"0000";
        LUT0_INITVAL    : bit_vector := X"0000";
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE;

        -- input SIGNAL delays
        tipd_M1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FXA : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FXB : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_FXA_OFX1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FXB_OFX1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M1_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F1       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F1       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F1       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F1       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F0       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F0       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_F0       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_F0       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLK         : VitalDelayType := 0 ns;
        tisd_M1_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK     : VitalDelayType := 0 ns;
        tisd_DI0_CLK     : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK     : VitalDelayType := 0 ns;

        tsetup_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_LSR            : VitalDelayType := 0.001 ns;
        tpw_LSR_posedge        : VitalDelayType := 0.001 ns;
        tpw_LSR_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        M1, FXA, FXB, A1, B1, C1, D1, DI1, DI0            : in std_ulogic := 'X';
        A0, B0, C0, D0, M0, CE, CLK, LSR                  : in std_ulogic := 'X';
        OFX1, F1, Q1, OFX0, F0, Q0                        : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SLOGICB : ENTITY IS TRUE;

END SLOGICB ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SLOGICB IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal M1_ipd       : std_logic := 'X';
    signal M1_dly       : std_logic := 'X';
    signal FXA_ipd      : std_logic := 'X';
    signal FXB_ipd      : std_logic := 'X';
    signal A1_ipd       : std_logic := 'X';
    signal B1_ipd       : std_logic := 'X';
    signal C1_ipd       : std_logic := 'X';
    signal D1_ipd       : std_logic := 'X';
    signal DI1_ipd      : std_logic := 'X';
    signal DI1_dly      : std_logic := 'X';
    signal DI0_ipd      : std_logic := 'X';
    signal DI0_dly      : std_logic := 'X';
    signal A0_ipd       : std_logic := 'X';
    signal B0_ipd       : std_logic := 'X';
    signal C0_ipd       : std_logic := 'X';
    signal D0_ipd       : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal M0_dly       : std_logic := 'X';
    signal CE_ipd       : std_logic := 'X';
    signal CE_dly       : std_logic := 'X';
    signal CLK_ipd      : std_logic := 'X';
    signal CLK_dly      : std_logic := 'X';
    signal LSR_ipd      : std_logic := 'X';
    signal LSR_dly      : std_logic := 'X';
    signal F0_buf       : std_logic := 'X';
    signal F1_buf       : std_logic := 'X';
    signal M1_sig       : std_logic := 'X';
    signal M0_sig       : std_logic := 'X';
    signal CE_sig       : std_logic := 'X';
    signal LSR_sig      : std_logic := 'X';
    signal LSR_sig0     : std_logic := 'X';
    signal CLK_sig      : std_logic := 'X';
    signal D0_sig       : std_logic := 'X';
    signal D1_sig       : std_logic := 'X';
    signal posedge_clk  : std_logic := '0';
    signal negedge_clk  : std_logic := '0';
    signal OFX1_buf     : std_logic := 'X';
    signal OFX0_buf     : std_logic := 'X';
    signal QB0          : std_logic := 'X';
    signal QB1          : std_logic := 'X';

BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(M1_ipd, M1, tipd_M1);
      VitalWireDelay(FXA_ipd, FXA, tipd_FXA);
      VitalWireDelay(FXB_ipd, FXB, tipd_FXB);
      VitalWireDelay(A1_ipd, A1, tipd_A1);
      VitalWireDelay(B1_ipd, B1, tipd_B1);
      VitalWireDelay(C1_ipd, C1, tipd_C1);
      VitalWireDelay(D1_ipd, D1, tipd_D1);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(A0_ipd, A0, tipd_A0);
      VitalWireDelay(B0_ipd, B0, tipd_B0);
      VitalWireDelay(C0_ipd, C0, tipd_C0);
      VitalWireDelay(D0_ipd, D0, tipd_D0);
      VitalWireDelay(M0_ipd, M0, tipd_M0);
      VitalWireDelay(CE_ipd, CE, tipd_CE);
      VitalWireDelay(LSR_ipd, LSR, tipd_LSR);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(M1_dly, M1_ipd, tisd_M1_CLK);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLK);
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLK);
      VitalSignalDelay(M0_dly, M0_ipd, tisd_M0_CLK);
      VitalSignalDelay(CE_dly, CE_ipd, tisd_CE_CLK);
      VitalSignalDelay(LSR_dly, LSR_ipd, tisd_LSR_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
    END BLOCK;

    P1 : PROCESS (A0_ipd, B0_ipd, C0_ipd, D0_ipd)
    BEGIN
       F0_buf <= VitalMUX
                      (data => To_StdLogicVector(LUT0_INITVAL),
                      dselect => (D0_ipd, C0_ipd, B0_ipd, A0_ipd));
    END PROCESS;

    P2 : PROCESS (A1_ipd, B1_ipd, C1_ipd, D1_ipd)
    BEGIN
       F1_buf <= VitalMUX
                      (data => To_StdLogicVector(LUT1_INITVAL),
                      dselect => (D1_ipd, C1_ipd, B1_ipd, A1_ipd));
    END PROCESS;

    P11 : PROCESS (M1_ipd, M0_ipd, LSR_ipd, CE_ipd, CLK_ipd)
    BEGIN
       IF (M1MUX = "SIG") THEN
          M1_sig <= M1_ipd;
       ELSIF (M1MUX = "INV") THEN
          M1_sig <= not M1_ipd;
       ELSIF (M1MUX = "VHI") THEN
          M1_sig <= '1';
       ELSE
          M1_sig <= '0';
       END IF;

       IF (M0MUX = "SIG") THEN
          M0_sig <= M0_ipd;
       ELSIF (M0MUX = "INV") THEN
          M0_sig <= not M0_ipd;
       ELSIF (M0MUX = "VHI") THEN
          M0_sig <= '1';
       ELSE
          M0_sig <= '0';
       END IF;

       IF (LSRMUX = "SIG") THEN
          LSR_sig <= LSR_ipd;
       ELSIF (LSRMUX = "INV") THEN
          LSR_sig <= not LSR_ipd;
       ELSIF (LSRMUX = "VHI") THEN
          LSR_sig <= '1';
       ELSE
          LSR_sig <= '0';
       END IF;

       IF (CLKMUX = "SIG") THEN
          CLK_sig <= CLK_ipd;
       ELSIF (CLKMUX = "INV") THEN
          CLK_sig <= not CLK_ipd;
       ELSIF (CLKMUX = "VHI") THEN
          CLK_sig <= '1';
       ELSE
          CLK_sig <= '0';
       END IF;

       IF (CEMUX = "SIG") THEN
          CE_sig <= CE_ipd;
       ELSIF (CEMUX = "INV") THEN
          CE_sig <= not CE_ipd;
       ELSIF (CEMUX = "VHI") THEN
          CE_sig <= '1';
       ELSE
          CE_sig <= '0';
       END IF;
    END PROCESS;

    P31 : PROCESS (M0_sig, DI0_ipd, LSR_sig)
    BEGIN
       IF (REG0_SD = "VLO") THEN
          D0_sig <= M0_sig;
       ELSIF (REG0_SD = "VHI") THEN
          D0_sig <= DI0_ipd;
       ELSE
          D0_sig <= VitalMUX
                        (data => (DI0_ipd, M0_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

    P32 : PROCESS (M1_sig, DI1_ipd, LSR_sig)
    BEGIN
       IF (REG1_SD = "VLO") THEN
          D1_sig <= M1_sig;
       ELSIF (REG1_SD = "VHI") THEN
          D1_sig <= DI1_ipd;
       ELSE
          D1_sig <= VitalMUX
                        (data => (DI1_ipd, M1_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

--    D0_sig <= M0_sig when (REG0_SD = "VLO") else DI0_ipd;
--    D1_sig <= M1_sig when (REG1_SD = "VLO") else DI1_ipd;

    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    P3 : PROCESS (M1_sig, FXA_ipd, FXB_ipd)
    BEGIN
       OFX1_buf <= VitalMUX
                        (data => (FXB_ipd, FXA_ipd),
                         dselect => (0 => M1_sig));
    END PROCESS;

    P4 : PROCESS (M0_sig, F1_buf, F0_buf)
    BEGIN
       OFX0_buf <= VitalMUX
                        (data => (F1_buf, F0_buf),
                         dselect => (0 => M0_sig));
    END PROCESS;

    P101 : PROCESS (LSR_sig)
    BEGIN
       IF ((REG0_SD = "SIG") or (REG1_SD = "SIG")) THEN
          LSR_sig0 <= '0';
       ELSE
          LSR_sig0 <= LSR_sig;
       END IF;
    END PROCESS;

    GFF : if (SRMODE = "ASYNC" and REG0_REGSET = "RESET") generate
             fd1p3dx_inst0 : fd1p3dx
                        generic map (gsr => gsr)
                        port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
    end generate GFF;

    GFF1 : if (SRMODE = "ASYNC" and REG0_REGSET = "SET") generate
             fd1p3bx_inst0 : fd1p3bx
                        generic map (gsr => gsr)
                        port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
    end generate GFF1;

    GFF2 : if (SRMODE = "ASYNC" and REG1_REGSET = "RESET") generate
             fd1p3dx_inst1 : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
    end generate GFF2;

    GFF3 : if (SRMODE = "ASYNC" and REG1_REGSET = "SET") generate
             fd1p3bx_inst1 : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
    end generate GFF3;

    GFF4 : if (SRMODE = "LSR_OVER_CE" and REG0_REGSET = "RESET") generate
                 fd1p3ix_inst0 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
    end generate GFF4;

    GFF5 : if (SRMODE = "LSR_OVER_CE" and REG0_REGSET = "SET") generate
                 fd1p3jx_inst0 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
    end generate GFF5;

    GFF6 : if (SRMODE = "LSR_OVER_CE" and REG1_REGSET = "RESET") generate
                 fd1p3ix_inst1 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
    end generate GFF6;

    GFF7 : if (SRMODE = "LSR_OVER_CE" and REG1_REGSET = "SET") generate
                 fd1p3jx_inst1 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
    end generate GFF7;


    VitalBehavior : PROCESS (M1_ipd, M1_dly, FXA_ipd, FXB_ipd, A1_ipd, B1_ipd, C1_ipd, D1_ipd,
      DI1_ipd, DI1_dly, DI0_ipd, DI0_dly, A0_ipd, B0_ipd, C0_ipd, D0_ipd, M0_ipd, M0_dly, CE_dly,
      LSR_ipd, LSR_dly, CLK_ipd, CLK_dly, QB0, QB1, OFX0_buf, OFX1_buf, F1_buf, F0_buf)

    VARIABLE OFX1_zd            : std_logic := 'X';
    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE OFX0_zd            : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE OFX1_GlitchData    : VitalGlitchDataType;
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE OFX0_GlitchData    : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_M1_CLK              : x01 := '0';
    VARIABLE M1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK             : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK             : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_M0_CLK              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CE_CLK              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK             : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_CLK                 : x01 := '0';
    VARIABLE periodcheckinfo_CLK       : VitalPeriodDataType;
    VARIABLE tviol_LSR                 : x01 := '0';
    VARIABLE periodcheckinfo_LSR       : VitalPeriodDataType;

  BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_posedge,
        SetupLow => tsetup_M1_CLK_noedge_posedge,
        HoldHigh => thold_M1_CLK_noedge_posedge,
        HoldLow => thold_M1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_negedge,
        SetupLow => tsetup_M1_CLK_noedge_negedge,
        HoldHigh => thold_M1_CLK_noedge_negedge,
        HoldLow => thold_M1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_posedge,
        SetupLow => tsetup_DI1_CLK_noedge_posedge,
        HoldHigh => thold_DI1_CLK_noedge_posedge,
        HoldLow => thold_DI1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_negedge,
        SetupLow => tsetup_DI1_CLK_noedge_negedge,
        HoldHigh => thold_DI1_CLK_noedge_negedge,
        HoldLow => thold_DI1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_posedge,
        SetupLow => tsetup_DI0_CLK_noedge_posedge,
        HoldHigh => thold_DI0_CLK_noedge_posedge,
        HoldLow => thold_DI0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_negedge,
        SetupLow => tsetup_DI0_CLK_noedge_negedge,
        HoldHigh => thold_DI0_CLK_noedge_negedge,
        HoldLow => thold_DI0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_posedge,
        SetupLow => tsetup_M0_CLK_noedge_posedge,
        HoldHigh => thold_M0_CLK_noedge_posedge,
        HoldLow => thold_M0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_negedge,
        SetupLow => tsetup_M0_CLK_noedge_negedge,
        HoldHigh => thold_M0_CLK_noedge_negedge,
        HoldLow => thold_M0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_posedge,
        SetupLow => tsetup_CE_CLK_noedge_posedge,
        HoldHigh => thold_CE_CLK_noedge_posedge,
        HoldLow => thold_CE_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_CE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_negedge,
        SetupLow => tsetup_CE_CLK_noedge_negedge,
        HoldHigh => thold_CE_CLK_noedge_negedge,
        HoldLow => thold_CE_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_CE),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_posedge,
        SetupLow => tsetup_LSR_CLK_noedge_posedge,
        HoldHigh => thold_LSR_CLK_noedge_posedge,
        HoldLow => thold_LSR_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_LSR),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_negedge,
        SetupLow => tsetup_LSR_CLK_noedge_negedge,
        HoldHigh => thold_LSR_CLK_noedge_negedge,
        HoldLow => thold_LSR_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_LSR),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => LSR_ipd,
        TestSignalName => "LSR",
        Period => tperiod_LSR,
        PulseWidthHigh => tpw_LSR_posedge,
        PulseWidthLow => tpw_LSR_negedge,
        PeriodData => periodcheckinfo_LSR,
        Violation => tviol_LSR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    Q0_zd := QB0;
    Q1_zd := QB1;
    OFX0_zd := OFX0_buf;
    OFX1_zd := OFX1_buf;
    F1_zd := F1_buf;
    F0_zd := F0_buf;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => OFX1,
       OutSignalName => "OFX1",
       OutTemp => OFX1_zd,
       Paths => (0 => (InputChangeTime => FXA_ipd'last_event, 
                       PathDelay => tpd_FXA_OFX1, 
                       PathCondition => TRUE),
                 1 => (M1_ipd'last_event, tpd_M1_OFX1, PathCondition => TRUE),
                 2 => (FXB_ipd'last_event, tpd_FXB_OFX1, PathCondition => TRUE)),
       GlitchData => OFX1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F1,
       OutSignalName => "F1",
       OutTemp => F1_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_F1,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_F1, TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_F1, TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_F1, TRUE)),
       GlitchData => F1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q1,
       OutSignalName => "Q1",
       OutTemp => Q1_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q1,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q1, PathCondition => TRUE)),
       GlitchData => Q1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => OFX0,
       OutSignalName => "OFX0",
       OutTemp => OFX0_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_OFX0,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_OFX0, TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_OFX0, TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_OFX0, TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_OFX0, TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_OFX0, TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_OFX0, TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_OFX0, TRUE),
                 8 => (M0'last_event, tpd_M0_OFX0, PathCondition => TRUE)),
       GlitchData => OFX0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F0,
       OutSignalName => "F0",
       OutTemp => F0_zd,
       Paths => (0 => (InputChangeTime => A0_ipd'last_event,
                       PathDelay => tpd_A0_F0,
                       PathCondition => TRUE),
                 1 => (B0_ipd'last_event, tpd_B0_F0, TRUE),
                 2 => (C0_ipd'last_event, tpd_C0_F0, TRUE),
                 3 => (D0_ipd'last_event, tpd_D0_F0, TRUE)),
       GlitchData => F0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q0,
       OutSignalName => "Q0",
       OutTemp => Q0_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q0,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q0, PathCondition => TRUE)),
       GlitchData => Q0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SRIPPLEB IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SRIPPLEB";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        ALU2_MULT_MODE  : string := "ADD";  -- "ADD", "SUB", "ADDSUB", "CNTUP", "CNTDN", "CNTUPDN", "MULT", "A_GE_B", "A_NE_B"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE;

        -- input SIGNAL delays
        tipd_M1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FCI : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLK_Q1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_FCO   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_F1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_F0    : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLK         : VitalDelayType := 0 ns;
        tisd_M1_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK     : VitalDelayType := 0 ns;
        tisd_DI0_CLK     : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK     : VitalDelayType := 0 ns;

        tsetup_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_LSR            : VitalDelayType := 0.001 ns;
        tpw_LSR_posedge        : VitalDelayType := 0.001 ns;
        tpw_LSR_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        M1, A1, B1, C1, D1, DI1, DI0                   : in std_ulogic := 'X';
        A0, B0, C0, D0, FCI, M0, CE, CLK, LSR          : in std_ulogic := 'X';
        FCO, F1, Q1, F0, Q0                            : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SRIPPLEB : ENTITY IS TRUE;

END SRIPPLEB ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SRIPPLEB IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal M1_ipd       : std_logic := 'X';
    signal M1_dly       : std_logic := 'X';
    signal A1_ipd       : std_logic := 'X';
    signal B1_ipd       : std_logic := 'X';
    signal C1_ipd       : std_logic := 'X';
    signal D1_ipd       : std_logic := 'X';
    signal DI1_ipd      : std_logic := 'X';
    signal DI1_dly      : std_logic := 'X';
    signal DI0_ipd      : std_logic := 'X';
    signal DI0_dly      : std_logic := 'X';
    signal A0_ipd       : std_logic := 'X';
    signal B0_ipd       : std_logic := 'X';
    signal C0_ipd       : std_logic := 'X';
    signal D0_ipd       : std_logic := 'X';
    signal FCI_ipd      : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal M0_dly       : std_logic := 'X';
    signal CE_ipd       : std_logic := 'X';
    signal CE_dly       : std_logic := 'X';
    signal CLK_ipd      : std_logic := 'X';
    signal CLK_dly      : std_logic := 'X';
    signal LSR_ipd      : std_logic := 'X';
    signal LSR_dly      : std_logic := 'X';
    signal M1_sig       : std_logic := 'X';
    signal M0_sig       : std_logic := 'X';
    signal CE_sig       : std_logic := 'X';
    signal LSR_sig      : std_logic := 'X';
    signal LSR_sig0     : std_logic := 'X';
    signal CLK_sig      : std_logic := 'X';
    signal D0_sig       : std_logic := 'X';
    signal D1_sig       : std_logic := 'X';
    signal COUT         : std_logic := 'X';
    signal S0           : std_logic := 'X';
    signal S1           : std_logic := 'X';
    signal posedge_clk  : std_logic := '0';
    signal negedge_clk  : std_logic := '0';
    signal QB0          : std_logic := 'X';
    signal QB1          : std_logic := 'X';

BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(M1_ipd, M1, tipd_M1);
      VitalWireDelay(A1_ipd, A1, tipd_A1);
      VitalWireDelay(B1_ipd, B1, tipd_B1);
      VitalWireDelay(C1_ipd, C1, tipd_C1);
      VitalWireDelay(D1_ipd, D1, tipd_D1);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(A0_ipd, A0, tipd_A0);
      VitalWireDelay(B0_ipd, B0, tipd_B0);
      VitalWireDelay(C0_ipd, C0, tipd_C0);
      VitalWireDelay(D0_ipd, D0, tipd_D0);
      VitalWireDelay(FCI_ipd, FCI, tipd_FCI);
      VitalWireDelay(M0_ipd, M0, tipd_M0);
      VitalWireDelay(CE_ipd, CE, tipd_CE);
      VitalWireDelay(LSR_ipd, LSR, tipd_LSR);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(M1_dly, M1_ipd, tisd_M1_CLK);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLK);
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLK);
      VitalSignalDelay(M0_dly, M0_ipd, tisd_M0_CLK);
      VitalSignalDelay(CE_dly, CE_ipd, tisd_CE_CLK);
      VitalSignalDelay(LSR_dly, LSR_ipd, tisd_LSR_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
    END BLOCK;

    P11 : PROCESS (M1_dly, M0_dly, LSR_dly, CE_dly, CLK_dly)
    BEGIN
       IF (M1MUX = "SIG") THEN
          M1_sig <= M1_dly;
       ELSIF (M1MUX = "INV") THEN
          M1_sig <= not M1_dly;
       ELSIF (M1MUX = "VHI") THEN
          M1_sig <= '1';
       ELSE
          M1_sig <= '0';
       END IF;

       IF (M0MUX = "SIG") THEN
          M0_sig <= M0_dly;
       ELSIF (M0MUX = "INV") THEN
          M0_sig <= not M0_dly;
       ELSIF (M0MUX = "VHI") THEN
          M0_sig <= '1';
       ELSE
          M0_sig <= '0';
       END IF;

       IF (LSRMUX = "SIG") THEN
          LSR_sig <= LSR_dly;
       ELSIF (LSRMUX = "INV") THEN
          LSR_sig <= not LSR_dly;
       ELSIF (LSRMUX = "VHI") THEN
          LSR_sig <= '1';
       ELSE
          LSR_sig <= '0';
       END IF;

       IF (CLKMUX = "SIG") THEN
          CLK_sig <= CLK_dly;
       ELSIF (CLKMUX = "INV") THEN
          CLK_sig <= not CLK_dly;
       ELSIF (CLKMUX = "VHI") THEN
          CLK_sig <= '1';
       ELSE
          CLK_sig <= '0';
       END IF;

       IF (CEMUX = "SIG") THEN
          CE_sig <= CE_dly;
       ELSIF (CEMUX = "INV") THEN
          CE_sig <= not CE_dly;
       ELSIF (CEMUX = "VHI") THEN
          CE_sig <= '1';
       ELSE
          CE_sig <= '0';
       END IF;
    END PROCESS;

    P31 : PROCESS (M0_sig, DI0_ipd, LSR_sig)
    BEGIN
       IF (REG0_SD = "VLO") THEN
          D0_sig <= M0_sig;
       ELSIF (REG0_SD = "VHI") THEN
          D0_sig <= DI0_ipd;
       ELSE
          D0_sig <= VitalMUX
                        (data => (DI0_ipd, M0_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

    P32 : PROCESS (M1_sig, DI1_ipd, LSR_sig)
    BEGIN
       IF (REG1_SD = "VLO") THEN
          D1_sig <= M1_sig;
       ELSIF (REG1_SD = "VHI") THEN
          D1_sig <= DI1_ipd;
       ELSE
          D1_sig <= VitalMUX
                        (data => (DI1_ipd, M1_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

--    D0_sig <= M0_sig when (REG0_SD = "VLO") else DI0_dly;
--    D1_sig <= M1_sig when (REG1_SD = "VLO") else DI1_dly;

    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    ALU_ADD : if (ALU2_MULT_MODE = "ADD") generate
       FADD2B_INST : fadd2b
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              ci => FCI_ipd, cout => COUT, s0 => S0, s1 => S1);
    end generate ALU_ADD;

    ALU_SUB : if (ALU2_MULT_MODE = "SUB") generate
       FSUB2B_INST : fsub2b
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              bi => FCI_ipd, bout => COUT, s0 => S0, s1 => S1);
    end generate ALU_SUB;


    ALU_ADDSUB : if (ALU2_MULT_MODE = "ADDSUB") generate
       FADSU2_INST : fadsu2
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, con => D0_ipd, 
                              bci => FCI_ipd, bco => COUT, s0 => S0, s1 => S1);
    end generate ALU_ADDSUB;

    ALU_AGEB : if (ALU2_MULT_MODE = "A_GE_B") generate
       AGEB2_INST : ageb2
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              ci => FCI_ipd, ge => COUT);
    end generate ALU_AGEB;

    ALU_ANEB : if (ALU2_MULT_MODE = "A_NE_B") generate
       ANEB2_INST : aneb2
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              ci => FCI_ipd, ne => COUT);
    end generate ALU_ANEB;

    ALU_CNTUP : if (ALU2_MULT_MODE = "CNTUP") generate
       CU2_INST : cu2
                    port map (ci => FCI_ipd, pc0 => A0_ipd, pc1 => A1_ipd, 
                              co => COUT, nc0 => S0, nc1 => S1);
    end generate ALU_CNTUP;

    ALU_CNTDN : if (ALU2_MULT_MODE = "CNTDN") generate
       CD2_INST : cd2
                    port map (ci => FCI_ipd, pc0 => A0_ipd, pc1 => A1_ipd, 
                              co => COUT, nc0 => S0, nc1 => S1);
    end generate ALU_CNTDN;

    ALU_CNTUPDN : if (ALU2_MULT_MODE = "CNTUPDN") generate
       CB2_INST : cb2
                    port map (ci => FCI_ipd, pc0 => A0_ipd, pc1 => A1_ipd, con => D0_ipd, 
                              co => COUT, nc0 => S0, nc1 => S1);
    end generate ALU_CNTUPDN;

    ALU_MULT : if (ALU2_MULT_MODE = "MULT") generate
       MULT2_INST : mult2
                    port map (a0 => A0_ipd, a1 => C0_ipd, a2 => A1_ipd, a3 => C1_ipd, 
                              b0 => B0_ipd, b1 => D0_ipd, b2 => B1_ipd, b3 => D1_ipd, 
                              ci => FCI_ipd, co => COUT, p0 => S0, p1 => S1);
    end generate ALU_MULT;

    P101 : PROCESS (LSR_sig)
    BEGIN
       IF ((REG0_SD = "SIG") or (REG1_SD = "SIG")) THEN
          LSR_sig0 <= '0';
       ELSE
          LSR_sig0 <= LSR_sig;
       END IF;
    END PROCESS;

    GFF : if (SRMODE = "ASYNC") generate
          GFF1 : if (REG0_REGSET = "RESET") generate
                 fd1p3dx_inst0 : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF1;

          GFF2 : if (REG0_REGSET = "SET") generate
                 fd1p3bx_inst0 : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF2;

          GFF3 : if (REG1_REGSET = "RESET") generate
                 fd1p3dx_inst1 : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF3;
          GFF4 : if (REG1_REGSET = "SET") generate
                 fd1p3bx_inst1 : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF4;
    end generate GFF;

    GFF20 : if (SRMODE = "LSR_OVER_CE") generate
          GFF10 : if (REG0_REGSET = "RESET") generate
                 fd1p3ix_inst0 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF10;
          GFF11 : if (REG0_REGSET = "SET") generate
                 fd1p3jx_inst0 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF11;

          GFF12 : if (REG1_REGSET = "RESET") generate
                 fd1p3ix_inst1 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF12;
          GFF13 : if (REG1_REGSET = "SET") generate
                 fd1p3jx_inst1 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF13;
    end generate GFF20;


    VitalBehavior : PROCESS (M1_ipd, M1_dly, A1_ipd, B1_ipd, C1_ipd, D1_ipd, DI1_ipd, DI1_dly,
      DI0_ipd, DI0_dly, A0_ipd, B0_ipd, C0_ipd, D0_ipd, FCI_ipd, M0_ipd, M0_dly, CE_dly,
      LSR_ipd, LSR_dly, CLK_ipd, CLK_dly, QB0, QB1, COUT, S1, S0)

    VARIABLE FCO_zd             : std_logic := 'X';
    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE FCO_GlitchData     : VitalGlitchDataType;
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_M1_CLK              : x01 := '0';
    VARIABLE M1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK             : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK             : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_M0_CLK              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CE_CLK              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK             : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_CLK                 : x01 := '0';
    VARIABLE periodcheckinfo_CLK       : VitalPeriodDataType;
    VARIABLE tviol_LSR                 : x01 := '0';
    VARIABLE periodcheckinfo_LSR       : VitalPeriodDataType;

  BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_posedge,
        SetupLow => tsetup_M1_CLK_noedge_posedge,
        HoldHigh => thold_M1_CLK_noedge_posedge,
        HoldLow => thold_M1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_negedge,
        SetupLow => tsetup_M1_CLK_noedge_negedge,
        HoldHigh => thold_M1_CLK_noedge_negedge,
        HoldLow => thold_M1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_posedge,
        SetupLow => tsetup_DI1_CLK_noedge_posedge,
        HoldHigh => thold_DI1_CLK_noedge_posedge,
        HoldLow => thold_DI1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_negedge,
        SetupLow => tsetup_DI1_CLK_noedge_negedge,
        HoldHigh => thold_DI1_CLK_noedge_negedge,
        HoldLow => thold_DI1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_posedge,
        SetupLow => tsetup_DI0_CLK_noedge_posedge,
        HoldHigh => thold_DI0_CLK_noedge_posedge,
        HoldLow => thold_DI0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_negedge,
        SetupLow => tsetup_DI0_CLK_noedge_negedge,
        HoldHigh => thold_DI0_CLK_noedge_negedge,
        HoldLow => thold_DI0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_posedge,
        SetupLow => tsetup_M0_CLK_noedge_posedge,
        HoldHigh => thold_M0_CLK_noedge_posedge,
        HoldLow => thold_M0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_negedge,
        SetupLow => tsetup_M0_CLK_noedge_negedge,
        HoldHigh => thold_M0_CLK_noedge_negedge,
        HoldLow => thold_M0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_posedge,
        SetupLow => tsetup_CE_CLK_noedge_posedge,
        HoldHigh => thold_CE_CLK_noedge_posedge,
        HoldLow => thold_CE_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_CE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_negedge,
        SetupLow => tsetup_CE_CLK_noedge_negedge,
        HoldHigh => thold_CE_CLK_noedge_negedge,
        HoldLow => thold_CE_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_CE),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_posedge,
        SetupLow => tsetup_LSR_CLK_noedge_posedge,
        HoldHigh => thold_LSR_CLK_noedge_posedge,
        HoldLow => thold_LSR_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_LSR),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_negedge,
        SetupLow => tsetup_LSR_CLK_noedge_negedge,
        HoldHigh => thold_LSR_CLK_noedge_negedge,
        HoldLow => thold_LSR_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_LSR),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => LSR_ipd,
        TestSignalName => "LSR",
        Period => tperiod_LSR,
        PulseWidthHigh => tpw_LSR_posedge,
        PulseWidthLow => tpw_LSR_negedge,
        PeriodData => periodcheckinfo_LSR,
        Violation => tviol_LSR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    Q0_zd := QB0;
    Q1_zd := QB1;
    FCO_zd := COUT;
    F1_zd := S1;
    F0_zd := S0;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => F1,
       OutSignalName => "F1",
       OutTemp => F1_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_F1,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_F1, PathCondition => TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_F1, PathCondition => TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_F1, PathCondition => TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_F1, PathCondition => TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_F1, PathCondition => TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_F1, PathCondition => TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_F1, PathCondition => TRUE),
                 8 => (FCI_ipd'last_event, tpd_FCI_F1, PathCondition => TRUE)),
       GlitchData => F1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F0,
       OutSignalName => "F0",
       OutTemp => F0_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_F0,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_F0, PathCondition => TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_F0, PathCondition => TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_F0, PathCondition => TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_F0, PathCondition => TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_F0, PathCondition => TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_F0, PathCondition => TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_F0, PathCondition => TRUE),
                 8 => (FCI_ipd'last_event, tpd_FCI_F0, PathCondition => TRUE)),
       GlitchData => F0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => FCO,
       OutSignalName => "FCO",
       OutTemp => FCO_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_FCO,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_FCO, PathCondition => TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_FCO, PathCondition => TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_FCO, PathCondition => TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_FCO, PathCondition => TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_FCO, PathCondition => TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_FCO, PathCondition => TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_FCO, PathCondition => TRUE),
                 8 => (FCI_ipd'last_event, tpd_FCI_FCO, PathCondition => TRUE)),
       GlitchData => FCO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q1,
       OutSignalName => "Q1",
       OutTemp => Q1_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q1,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q1, PathCondition => TRUE)),
       GlitchData => Q1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q0,
       OutSignalName => "Q0",
       OutTemp => Q0_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q0,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q0, PathCondition => TRUE)),
       GlitchData => Q0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SCCU2B IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SCCU2B";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"
        CCU2_INJECT1_0  : string := "YES";     -- "NO", "YES"
        CCU2_INJECT1_1  : string := "YES";     -- "NO", "YES"
        INIT0_INITVAL   : string := "0x0000";
        INIT1_INITVAL   : string := "0x0000";

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE;

        -- input SIGNAL delays
        tipd_M1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FCI : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLK_Q1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_FCO   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_F1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_F0    : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLK         : VitalDelayType := 0 ns;
        tisd_M1_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK     : VitalDelayType := 0 ns;
        tisd_DI0_CLK     : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK     : VitalDelayType := 0 ns;

        tsetup_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_LSR            : VitalDelayType := 0.001 ns;
        tpw_LSR_posedge        : VitalDelayType := 0.001 ns;
        tpw_LSR_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        M1, A1, B1, C1, D1, DI1, DI0                   : in std_ulogic := 'X';
        A0, B0, C0, D0, FCI, M0, CE, CLK, LSR          : in std_ulogic := 'X';
        FCO, F1, Q1, F0, Q0                            : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SCCU2B : ENTITY IS TRUE;

END SCCU2B ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SCCU2B IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal M1_ipd       : std_logic := 'X';
    signal M1_dly       : std_logic := 'X';
    signal A1_ipd       : std_logic := 'X';
    signal B1_ipd       : std_logic := 'X';
    signal C1_ipd       : std_logic := 'X';
    signal D1_ipd       : std_logic := 'X';
    signal DI1_ipd      : std_logic := 'X';
    signal DI1_dly      : std_logic := 'X';
    signal DI0_ipd      : std_logic := 'X';
    signal DI0_dly      : std_logic := 'X';
    signal A0_ipd       : std_logic := 'X';
    signal B0_ipd       : std_logic := 'X';
    signal C0_ipd       : std_logic := 'X';
    signal D0_ipd       : std_logic := 'X';
    signal FCI_ipd      : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal M0_dly       : std_logic := 'X';
    signal CE_ipd       : std_logic := 'X';
    signal CE_dly       : std_logic := 'X';
    signal CLK_ipd      : std_logic := 'X';
    signal CLK_dly      : std_logic := 'X';
    signal LSR_ipd      : std_logic := 'X';
    signal LSR_dly      : std_logic := 'X';
    signal M1_sig       : std_logic := 'X';
    signal M0_sig       : std_logic := 'X';
    signal CE_sig       : std_logic := 'X';
    signal LSR_sig      : std_logic := 'X';
    signal LSR_sig0     : std_logic := 'X';
    signal CLK_sig      : std_logic := 'X';
    signal D0_sig       : std_logic := 'X';
    signal D1_sig       : std_logic := 'X';
    signal COUT         : std_logic := 'X';
    signal S0           : std_logic := 'X';
    signal S1           : std_logic := 'X';
    signal posedge_clk  : std_logic := '0';
    signal negedge_clk  : std_logic := '0';
    signal QB0          : std_logic := 'X';
    signal QB1          : std_logic := 'X';

BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(M1_ipd, M1, tipd_M1);
      VitalWireDelay(A1_ipd, A1, tipd_A1);
      VitalWireDelay(B1_ipd, B1, tipd_B1);
      VitalWireDelay(C1_ipd, C1, tipd_C1);
      VitalWireDelay(D1_ipd, D1, tipd_D1);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(A0_ipd, A0, tipd_A0);
      VitalWireDelay(B0_ipd, B0, tipd_B0);
      VitalWireDelay(C0_ipd, C0, tipd_C0);
      VitalWireDelay(D0_ipd, D0, tipd_D0);
      VitalWireDelay(FCI_ipd, FCI, tipd_FCI);
      VitalWireDelay(M0_ipd, M0, tipd_M0);
      VitalWireDelay(CE_ipd, CE, tipd_CE);
      VitalWireDelay(LSR_ipd, LSR, tipd_LSR);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(M1_dly, M1_ipd, tisd_M1_CLK);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLK);
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLK);
      VitalSignalDelay(M0_dly, M0_ipd, tisd_M0_CLK);
      VitalSignalDelay(CE_dly, CE_ipd, tisd_CE_CLK);
      VitalSignalDelay(LSR_dly, LSR_ipd, tisd_LSR_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
    END BLOCK;

    P11 : PROCESS (M1_dly, M0_dly, LSR_dly, CE_dly, CLK_dly)
    BEGIN
       IF (M1MUX = "SIG") THEN
          M1_sig <= M1_dly;
       ELSIF (M1MUX = "INV") THEN
          M1_sig <= not M1_dly;
       ELSIF (M1MUX = "VHI") THEN
          M1_sig <= '1';
       ELSE
          M1_sig <= '0';
       END IF;

       IF (M0MUX = "SIG") THEN
          M0_sig <= M0_dly;
       ELSIF (M0MUX = "INV") THEN
          M0_sig <= not M0_dly;
       ELSIF (M0MUX = "VHI") THEN
          M0_sig <= '1';
       ELSE
          M0_sig <= '0';
       END IF;

       IF (LSRMUX = "SIG") THEN
          LSR_sig <= LSR_dly;
       ELSIF (LSRMUX = "INV") THEN
          LSR_sig <= not LSR_dly;
       ELSIF (LSRMUX = "VHI") THEN
          LSR_sig <= '1';
       ELSE
          LSR_sig <= '0';
       END IF;

       IF (CLKMUX = "SIG") THEN
          CLK_sig <= CLK_dly;
       ELSIF (CLKMUX = "INV") THEN
          CLK_sig <= not CLK_dly;
       ELSIF (CLKMUX = "VHI") THEN
          CLK_sig <= '1';
       ELSE
          CLK_sig <= '0';
       END IF;

       IF (CEMUX = "SIG") THEN
          CE_sig <= CE_dly;
       ELSIF (CEMUX = "INV") THEN
          CE_sig <= not CE_dly;
       ELSIF (CEMUX = "VHI") THEN
          CE_sig <= '1';
       ELSE
          CE_sig <= '0';
       END IF;
    END PROCESS;

    P31 : PROCESS (M0_sig, DI0_ipd, LSR_sig)
    BEGIN
       IF (REG0_SD = "VLO") THEN
          D0_sig <= M0_sig;
       ELSIF (REG0_SD = "VHI") THEN
          D0_sig <= DI0_ipd;
       ELSE
          D0_sig <= VitalMUX
                        (data => (DI0_ipd, M0_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

    P32 : PROCESS (M1_sig, DI1_ipd, LSR_sig)
    BEGIN
       IF (REG1_SD = "VLO") THEN
          D1_sig <= M1_sig;
       ELSIF (REG1_SD = "VHI") THEN
          D1_sig <= DI1_ipd;
       ELSE
          D1_sig <= VitalMUX
                        (data => (DI1_ipd, M1_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

--    D0_sig <= M0_sig when (REG0_SD = "VLO") else DI0_dly;
--    D1_sig <= M1_sig when (REG1_SD = "VLO") else DI1_dly;

    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    CCU2B_INST : ccu2b
                generic map (inject1_0 => ccu2_inject1_0, inject1_1 => ccu2_inject1_1, 
                             init0 => init0_initval, init1 => init1_initval)
                port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                          c0 => C0_ipd, c1 => C1_ipd, d0 => D0_ipd, d1 => D1_ipd, 
                          cin => FCI_ipd, cout => COUT, s0 => S0, s1 => S1);

    P101 : PROCESS (LSR_sig)
    BEGIN
       IF ((REG0_SD = "SIG") or (REG1_SD = "SIG")) THEN
          LSR_sig0 <= '0';
       ELSE
          LSR_sig0 <= LSR_sig;
       END IF;
    END PROCESS;

    GFF : if (SRMODE = "ASYNC") generate
          GFF1 : if (REG0_REGSET = "RESET") generate
                 fd1p3dx_inst0 : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF1;

          GFF2 : if (REG0_REGSET = "SET") generate
                 fd1p3bx_inst0 : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF2;

          GFF3 : if (REG1_REGSET = "RESET") generate
                 fd1p3dx_inst1 : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF3;
          GFF4 : if (REG1_REGSET = "SET") generate
                 fd1p3bx_inst1 : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF4;
    end generate GFF;

    GFF20 : if (SRMODE = "LSR_OVER_CE") generate
          GFF10 : if (REG0_REGSET = "RESET") generate
                 fd1p3ix_inst0 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF10;
          GFF11 : if (REG0_REGSET = "SET") generate
                 fd1p3jx_inst0 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF11;

          GFF12 : if (REG1_REGSET = "RESET") generate
                 fd1p3ix_inst1 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF12;
          GFF13 : if (REG1_REGSET = "SET") generate
                 fd1p3jx_inst1 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF13;
    end generate GFF20;


    VitalBehavior : PROCESS (M1_ipd, M1_dly, A1_ipd, B1_ipd, C1_ipd, D1_ipd, DI1_ipd, DI1_dly,
      DI0_ipd, DI0_dly, A0_ipd, B0_ipd, C0_ipd, D0_ipd, FCI_ipd, M0_ipd, M0_dly, CE_dly,
      LSR_ipd, LSR_dly, CLK_ipd, CLK_dly, QB0, QB1, COUT, S1, S0)

    VARIABLE FCO_zd             : std_logic := 'X';
    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE FCO_GlitchData     : VitalGlitchDataType;
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_M1_CLK              : x01 := '0';
    VARIABLE M1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK             : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK             : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_M0_CLK              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CE_CLK              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK             : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_CLK                 : x01 := '0';
    VARIABLE periodcheckinfo_CLK       : VitalPeriodDataType;
    VARIABLE tviol_LSR                 : x01 := '0';
    VARIABLE periodcheckinfo_LSR       : VitalPeriodDataType;

  BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_posedge,
        SetupLow => tsetup_M1_CLK_noedge_posedge,
        HoldHigh => thold_M1_CLK_noedge_posedge,
        HoldLow => thold_M1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_negedge,
        SetupLow => tsetup_M1_CLK_noedge_negedge,
        HoldHigh => thold_M1_CLK_noedge_negedge,
        HoldLow => thold_M1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_posedge,
        SetupLow => tsetup_DI1_CLK_noedge_posedge,
        HoldHigh => thold_DI1_CLK_noedge_posedge,
        HoldLow => thold_DI1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_negedge,
        SetupLow => tsetup_DI1_CLK_noedge_negedge,
        HoldHigh => thold_DI1_CLK_noedge_negedge,
        HoldLow => thold_DI1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_posedge,
        SetupLow => tsetup_DI0_CLK_noedge_posedge,
        HoldHigh => thold_DI0_CLK_noedge_posedge,
        HoldLow => thold_DI0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_negedge,
        SetupLow => tsetup_DI0_CLK_noedge_negedge,
        HoldHigh => thold_DI0_CLK_noedge_negedge,
        HoldLow => thold_DI0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_posedge,
        SetupLow => tsetup_M0_CLK_noedge_posedge,
        HoldHigh => thold_M0_CLK_noedge_posedge,
        HoldLow => thold_M0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_negedge,
        SetupLow => tsetup_M0_CLK_noedge_negedge,
        HoldHigh => thold_M0_CLK_noedge_negedge,
        HoldLow => thold_M0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_posedge,
        SetupLow => tsetup_CE_CLK_noedge_posedge,
        HoldHigh => thold_CE_CLK_noedge_posedge,
        HoldLow => thold_CE_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_CE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_negedge,
        SetupLow => tsetup_CE_CLK_noedge_negedge,
        HoldHigh => thold_CE_CLK_noedge_negedge,
        HoldLow => thold_CE_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_CE),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_posedge,
        SetupLow => tsetup_LSR_CLK_noedge_posedge,
        HoldHigh => thold_LSR_CLK_noedge_posedge,
        HoldLow => thold_LSR_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_LSR),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_negedge,
        SetupLow => tsetup_LSR_CLK_noedge_negedge,
        HoldHigh => thold_LSR_CLK_noedge_negedge,
        HoldLow => thold_LSR_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_LSR),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => LSR_ipd,
        TestSignalName => "LSR",
        Period => tperiod_LSR,
        PulseWidthHigh => tpw_LSR_posedge,
        PulseWidthLow => tpw_LSR_negedge,
        PeriodData => periodcheckinfo_LSR,
        Violation => tviol_LSR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    Q0_zd := QB0;
    Q1_zd := QB1;
    FCO_zd := COUT;
    F1_zd := S1;
    F0_zd := S0;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => F1,
       OutSignalName => "F1",
       OutTemp => F1_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_F1,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_F1, PathCondition => TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_F1, PathCondition => TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_F1, PathCondition => TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_F1, PathCondition => TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_F1, PathCondition => TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_F1, PathCondition => TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_F1, PathCondition => TRUE),
                 8 => (FCI_ipd'last_event, tpd_FCI_F1, PathCondition => TRUE)),
       GlitchData => F1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F0,
       OutSignalName => "F0",
       OutTemp => F0_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_F0,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_F0, PathCondition => TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_F0, PathCondition => TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_F0, PathCondition => TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_F0, PathCondition => TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_F0, PathCondition => TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_F0, PathCondition => TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_F0, PathCondition => TRUE),
                 8 => (FCI_ipd'last_event, tpd_FCI_F0, PathCondition => TRUE)),
       GlitchData => F0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => FCO,
       OutSignalName => "FCO",
       OutTemp => FCO_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_FCO,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_FCO, PathCondition => TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_FCO, PathCondition => TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_FCO, PathCondition => TRUE),
                 4 => (A0_ipd'last_event, tpd_A0_FCO, PathCondition => TRUE),
                 5 => (B0_ipd'last_event, tpd_B0_FCO, PathCondition => TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_FCO, PathCondition => TRUE),
                 7 => (D0_ipd'last_event, tpd_D0_FCO, PathCondition => TRUE),
                 8 => (FCI_ipd'last_event, tpd_FCI_FCO, PathCondition => TRUE)),
       GlitchData => FCO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q1,
       OutSignalName => "Q1",
       OutTemp => Q1_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q1,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q1, PathCondition => TRUE)),
       GlitchData => Q1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q0,
       OutSignalName => "Q0",
       OutTemp => Q0_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q0,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q0, PathCondition => TRUE)),
       GlitchData => Q0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SRAMWA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SRAMWA";

        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
                            
        check_LSR       : boolean := FALSE;

        -- input SIGNAL delays
        tipd_A1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- setup and hold constraints
        ticd_CLK         : VitalDelayType := 0 ns;
        tisd_LSR_CLK     : VitalDelayType := 0 ns;

        tsetup_LSR_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;

        -- propagation delays
        tpd_A1_WDO0   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_WDO1   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_WDO2   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_WDO3   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_WADO0  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_WADO1  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_WADO2  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_WADO3  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_WCKO  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_WREO  : VitalDelayType01 := (0 ns, 0 ns);

        tperiod_LSR            : VitalDelayType := 0.001 ns;
        tpw_LSR_posedge        : VitalDelayType := 0.001 ns;
        tpw_LSR_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns);


   PORT(
        A1, B1, C1, D1, A0, B0, C0, D0, CLK, LSR                       : in std_ulogic := 'X';
        WDO0, WDO1, WDO2, WDO3, WADO0, WADO1, WADO2, WADO3, WCKO, WREO : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SRAMWA : ENTITY IS TRUE;

END SRAMWA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SRAMWA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal A1_ipd       : std_logic := 'X';
    signal B1_ipd       : std_logic := 'X';
    signal C1_ipd       : std_logic := 'X';
    signal D1_ipd       : std_logic := 'X';
    signal A0_ipd       : std_logic := 'X';
    signal B0_ipd       : std_logic := 'X';
    signal C0_ipd       : std_logic := 'X';
    signal D0_ipd       : std_logic := 'X';
    signal CLK_ipd      : std_logic := 'X';
    signal LSR_ipd      : std_logic := 'X';
    signal LSR_sig      : std_logic := 'X';
    signal CLK_sig      : std_logic := 'X';
    signal CLK_dly      : std_logic := 'X';
    signal LSR_dly      : std_logic := 'X';
                                                           
    signal posedge_clk  : std_logic := '0';
    signal negedge_clk  : std_logic := '0';

BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(A1_ipd, A1, tipd_A1);
      VitalWireDelay(B1_ipd, B1, tipd_B1);
      VitalWireDelay(C1_ipd, C1, tipd_C1);
      VitalWireDelay(D1_ipd, D1, tipd_D1);
      VitalWireDelay(A0_ipd, A0, tipd_A0);
      VitalWireDelay(B0_ipd, B0, tipd_B0);
      VitalWireDelay(C0_ipd, C0, tipd_C0);
      VitalWireDelay(D0_ipd, D0, tipd_D0);
      VitalWireDelay(LSR_ipd, LSR, tipd_LSR);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(LSR_dly, LSR_ipd, tisd_LSR_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
    END BLOCK;

    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    P11 : PROCESS (LSR_ipd, CLK_ipd)
    BEGIN
       IF (LSRMUX = "SIG") THEN
          LSR_sig <= LSR_ipd;
       ELSIF (LSRMUX = "INV") THEN
          LSR_sig <= not LSR_ipd;
       ELSIF (LSRMUX = "VHI") THEN
          LSR_sig <= '1';
       ELSE
          LSR_sig <= '0';
       END IF;

       IF (CLKMUX = "SIG") THEN
          CLK_sig <= CLK_ipd;
       ELSIF (CLKMUX = "INV") THEN
          CLK_sig <= not CLK_ipd;
       ELSIF (CLKMUX = "VHI") THEN
          CLK_sig <= '1';
       ELSE
          CLK_sig <= '0';
       END IF;
    END PROCESS;


    VitalBehavior : PROCESS (A1_ipd, B1_ipd, C1_ipd, D1_ipd,
      A0_ipd, B0_ipd, C0_ipd, D0_ipd, LSR_ipd, LSR_sig, LSR_dly, CLK_dly, CLK_ipd, CLK_sig)

    VARIABLE WDO0_zd             : std_logic := 'X';
    VARIABLE WDO1_zd             : std_logic := 'X';
    VARIABLE WDO2_zd             : std_logic := 'X';
    VARIABLE WDO3_zd             : std_logic := 'X';
    VARIABLE WADO0_zd            : std_logic := 'X';
    VARIABLE WADO1_zd            : std_logic := 'X';
    VARIABLE WADO2_zd            : std_logic := 'X';
    VARIABLE WADO3_zd            : std_logic := 'X';
    VARIABLE WCKO_zd             : std_logic := 'X';
    VARIABLE WREO_zd             : std_logic := 'X';

    VARIABLE WDO0_GlitchData     : VitalGlitchDataType;
    VARIABLE WDO1_GlitchData     : VitalGlitchDataType;
    VARIABLE WDO2_GlitchData     : VitalGlitchDataType;
    VARIABLE WDO3_GlitchData     : VitalGlitchDataType;
    VARIABLE WADO0_GlitchData    : VitalGlitchDataType;
    VARIABLE WADO1_GlitchData    : VitalGlitchDataType;
    VARIABLE WADO2_GlitchData    : VitalGlitchDataType;
    VARIABLE WADO3_GlitchData    : VitalGlitchDataType;
    VARIABLE WCKO_GlitchData     : VitalGlitchDataType;
    VARIABLE WREO_GlitchData     : VitalGlitchDataType;

    VARIABLE tviol_LSR_CLK             : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash      : VitalTimingDataType;
                                                                                    
    VARIABLE tviol_LSR              : x01 := '0';
    VARIABLE periodcheckinfo_LSR    : VitalPeriodDataType;
    VARIABLE tviol_CLK              : x01 := '0';
    VARIABLE periodcheckinfo_CLK    : VitalPeriodDataType;

  BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_posedge,
        SetupLow => tsetup_LSR_CLK_noedge_posedge,
        HoldHigh => thold_LSR_CLK_noedge_posedge,
        HoldLow => thold_LSR_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_LSR),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_negedge,
        SetupLow => tsetup_LSR_CLK_noedge_negedge,
        HoldHigh => thold_LSR_CLK_noedge_negedge,
        HoldLow => thold_LSR_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_LSR),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
                                                                                            
      VitalPeriodPulseCheck (
        TestSignal => LSR_ipd,
        TestSignalName => "LSR",
        Period => tperiod_LSR,
        PulseWidthHigh => tpw_LSR_posedge,
        PulseWidthLow => tpw_LSR_negedge,
        PeriodData => periodcheckinfo_LSR,
        Violation => tviol_LSR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    WDO0_zd  := A1_ipd;
    WDO1_zd  := B1_ipd;
    WDO2_zd  := C1_ipd;
    WDO3_zd  := D1_ipd;
    WADO0_zd := A0_ipd;
    WADO1_zd := B0_ipd;
    WADO2_zd := C0_ipd;
    WADO3_zd := D0_ipd;
    WCKO_zd  := CLK_sig;
    WREO_zd  := LSR_sig;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => WDO0,
       OutSignalName => "WDO0",
       OutTemp => WDO0_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_WDO0,
                       PathCondition => TRUE)),
       GlitchData => WDO0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WDO1,
       OutSignalName => "WDO1",
       OutTemp => WDO1_zd,
       Paths => (0 => (InputChangeTime => B1_ipd'last_event,
                       PathDelay => tpd_B1_WDO1,
                       PathCondition => TRUE)),
       GlitchData => WDO1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WDO2,
       OutSignalName => "WDO2",
       OutTemp => WDO2_zd,
       Paths => (0 => (InputChangeTime => C1_ipd'last_event,
                       PathDelay => tpd_C1_WDO2,
                       PathCondition => TRUE)),
       GlitchData => WDO2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WDO3,
       OutSignalName => "WDO3",
       OutTemp => WDO3_zd,
       Paths => (0 => (InputChangeTime => D1_ipd'last_event,
                       PathDelay => tpd_D1_WDO3,
                       PathCondition => TRUE)),
       GlitchData => WDO3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WADO0,
       OutSignalName => "WADO0",
       OutTemp => WADO0_zd,
       Paths => (0 => (InputChangeTime => A0_ipd'last_event,
                       PathDelay => tpd_A0_WADO0,
                       PathCondition => TRUE)),
       GlitchData => WADO0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WADO1,
       OutSignalName => "WADO1",
       OutTemp => WADO1_zd,
       Paths => (0 => (InputChangeTime => B0_ipd'last_event,
                       PathDelay => tpd_B0_WADO1,
                       PathCondition => TRUE)),
       GlitchData => WADO1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WADO2,
       OutSignalName => "WADO2",
       OutTemp => WADO2_zd,
       Paths => (0 => (InputChangeTime => C0_ipd'last_event,
                       PathDelay => tpd_C0_WADO2,
                       PathCondition => TRUE)),
       GlitchData => WADO2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WADO3,
       OutSignalName => "WADO3",
       OutTemp => WADO3_zd,
       Paths => (0 => (InputChangeTime => D0_ipd'last_event,
                       PathDelay => tpd_D0_WADO3,
                       PathCondition => TRUE)),
       GlitchData => WADO3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WCKO,
       OutSignalName => "WCKO",
       OutTemp => WCKO_zd,
       Paths => (0 => (InputChangeTime => CLK_ipd'last_event,
                       PathDelay => tpd_CLK_WCKO,
                       PathCondition => TRUE)),
       GlitchData => WCKO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => WREO,
       OutSignalName => "WREO",
       OutTemp => WREO_zd,
       Paths => (0 => (InputChangeTime => LSR_ipd'last_event,
                       PathDelay => tpd_LSR_WREO,
                       PathCondition => TRUE)),
       GlitchData => WREO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SDPRAMB IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SDPRAMB";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"

        -- timing check enable for each port
        check_RAD0      : boolean := FALSE;
        check_RAD1      : boolean := FALSE;
        check_RAD2      : boolean := FALSE;
        check_RAD3      : boolean := FALSE;
        check_WD1       : boolean := FALSE;
        check_WD0       : boolean := FALSE;
        check_WAD0      : boolean := FALSE;
        check_WAD1      : boolean := FALSE;
        check_WAD2      : boolean := FALSE;
        check_WAD3      : boolean := FALSE;
        CHECK_WRE       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_M1        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE;

        -- input SIGNAL delays
        tipd_M1   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RAD0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RAD1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RAD2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RAD3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WD1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WD0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WAD0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WAD1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WAD2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WAD3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WRE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WCK  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0  : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLK_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD0_F1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD1_F1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD2_F1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD3_F1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD0_F0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD1_F0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD2_F0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RAD3_F0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_WCK_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_WCK_F0     : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLK         : VitalDelayType := 0 ns;
        tisd_RAD0_CLK    : VitalDelayType := 0 ns;
        tisd_RAD1_CLK    : VitalDelayType := 0 ns;
        tisd_RAD2_CLK    : VitalDelayType := 0 ns;
        tisd_RAD3_CLK    : VitalDelayType := 0 ns;
        tisd_M1_CLK      : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK     : VitalDelayType := 0 ns;
        tisd_DI0_CLK     : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK     : VitalDelayType := 0 ns;
        ticd_WCK         : VitalDelayType := 0 ns;
        tisd_WD1_WCK     : VitalDelayType := 0 ns;
        tisd_WD0_WCK     : VitalDelayType := 0 ns;
        tisd_WAD0_WCK    : VitalDelayType := 0 ns;
        tisd_WAD1_WCK    : VitalDelayType := 0 ns;
        tisd_WAD2_WCK    : VitalDelayType := 0 ns;
        tisd_WAD3_WCK    : VitalDelayType := 0 ns;
        tisd_WRE_WCK     : VitalDelayType := 0 ns;

        tsetup_RAD0_CLK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_RAD1_CLK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_RAD2_CLK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_RAD3_CLK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_WD1_WCK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_WD0_WCK_noedge_posedge    : VitalDelayType := 0 ns;
        tsetup_WAD0_WCK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_WAD1_WCK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_WAD2_WCK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_WAD3_WCK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_WRE_WCK_noedge_posedge    : VitalDelayType := 0 ns;

        thold_RAD0_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_RAD1_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_RAD2_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_RAD3_CLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_WD1_WCK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_WD0_WCK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_WAD0_WCK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_WAD1_WCK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_WAD2_WCK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_WAD3_WCK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_WRE_WCK_noedge_posedge     : VitalDelayType := 0 ns;

        tsetup_RAD0_CLK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_RAD1_CLK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_RAD2_CLK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_RAD3_CLK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_WD1_WCK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_WD0_WCK_noedge_negedge    : VitalDelayType := 0 ns;
        tsetup_WAD0_WCK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_WAD1_WCK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_WAD2_WCK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_WAD3_WCK_noedge_negedge   : VitalDelayType := 0 ns;
        tsetup_WRE_WCK_noedge_negedge    : VitalDelayType := 0 ns;

        thold_RAD0_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_RAD1_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_RAD2_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_RAD3_CLK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge      : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_WD1_WCK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_WD0_WCK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_WAD0_WCK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_WAD1_WCK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_WAD2_WCK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_WAD3_WCK_noedge_negedge    : VitalDelayType := 0 ns;
        thold_WRE_WCK_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_WCK            : VitalDelayType := 0.001 ns;
        tpw_WCK_posedge        : VitalDelayType := 0.001 ns;
        tpw_WCK_negedge        : VitalDelayType := 0.001 ns;
        tperiod_LSR            : VitalDelayType := 0.001 ns;
        tpw_LSR_posedge        : VitalDelayType := 0.001 ns;
        tpw_LSR_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        M1, RAD0, RAD1, RAD2, RAD3, WD1, WD0, WAD0, WAD1, WAD2, WAD3, WRE, WCK : in std_ulogic := 'X';
        M0, CE, CLK, LSR, DI1, DI0                                             : in std_ulogic := 'X';
        F0, Q0, F1, Q1                                                         : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SDPRAMB : ENTITY IS TRUE;

END SDPRAMB ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SDPRAMB IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal RAD0_ipd     : std_logic := 'X';
    signal RAD0_dly     : std_logic := 'X';
    signal RAD1_ipd     : std_logic := 'X';
    signal RAD1_dly     : std_logic := 'X';
    signal RAD2_ipd     : std_logic := 'X';
    signal RAD2_dly     : std_logic := 'X';
    signal RAD3_ipd     : std_logic := 'X';
    signal RAD3_dly     : std_logic := 'X';
    signal WD1_ipd      : std_logic := 'X';
    signal WD1_dly      : std_logic := 'X';
    signal WD0_ipd      : std_logic := 'X';
    signal WD0_dly      : std_logic := 'X';
    signal WAD0_ipd     : std_logic := 'X';
    signal WAD0_dly     : std_logic := 'X';
    signal WAD1_ipd     : std_logic := 'X';
    signal WAD1_dly     : std_logic := 'X';
    signal WAD2_ipd     : std_logic := 'X';
    signal WAD2_dly     : std_logic := 'X';
    signal WAD3_ipd     : std_logic := 'X';
    signal WAD3_dly     : std_logic := 'X';
    signal WRE_ipd      : std_logic := 'X';
    signal WRE_dly      : std_logic := 'X';
    signal WCK_ipd      : std_logic := 'X';
    signal WCK_dly      : std_logic := 'X';
    signal M1_ipd       : std_logic := 'X';
    signal M1_dly       : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal M0_dly       : std_logic := 'X';
    signal DI1_ipd      : std_logic := 'X';
    signal DI1_dly      : std_logic := 'X';
    signal DI0_ipd      : std_logic := 'X';
    signal DI0_dly      : std_logic := 'X';
    signal CE_ipd       : std_logic := 'X';
    signal CE_dly       : std_logic := 'X';
    signal CLK_ipd      : std_logic := 'X';
    signal CLK_dly      : std_logic := 'X';
    signal LSR_ipd      : std_logic := 'X';
    signal LSR_dly      : std_logic := 'X';
    signal M1_sig       : std_logic := 'X';
    signal M0_sig       : std_logic := 'X';
    signal CE_sig       : std_logic := 'X';
    signal LSR_sig      : std_logic := 'X';
    signal LSR_sig0     : std_logic := 'X';
    signal CLK_sig      : std_logic := 'X';
    signal D0_sig       : std_logic := 'X';
    signal D1_sig       : std_logic := 'X';
    signal posedge_clk  : std_logic := '0';
    signal negedge_clk  : std_logic := '0';
    signal QB0          : std_logic := 'X';
    signal QB1          : std_logic := 'X';
    signal DO0          : std_logic := 'X';
    signal DO1          : std_logic := 'X';

BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(RAD0_ipd, RAD0, tipd_RAD0);
      VitalWireDelay(RAD1_ipd, RAD1, tipd_RAD1);
      VitalWireDelay(RAD2_ipd, RAD2, tipd_RAD2);
      VitalWireDelay(RAD3_ipd, RAD3, tipd_RAD3);
      VitalWireDelay(M1_ipd, M1, tipd_M1);
      VitalWireDelay(M0_ipd, M0, tipd_M0);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(CE_ipd, CE, tipd_CE);
      VitalWireDelay(LSR_ipd, LSR, tipd_LSR);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
      VitalWireDelay(WD1_ipd, WD1, tipd_WD1);
      VitalWireDelay(WD0_ipd, WD0, tipd_WD0);
      VitalWireDelay(WAD0_ipd, WAD0, tipd_WAD0);
      VitalWireDelay(WAD1_ipd, WAD1, tipd_WAD1);
      VitalWireDelay(WAD2_ipd, WAD2, tipd_WAD2);
      VitalWireDelay(WAD3_ipd, WAD3, tipd_WAD3);
      VitalWireDelay(WRE_ipd, WRE, tipd_WRE);
      VitalWireDelay(WCK_ipd, WCK, tipd_WCK);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(RAD0_dly, RAD0_ipd, tisd_RAD0_CLK);
      VitalSignalDelay(RAD1_dly, RAD1_ipd, tisd_RAD1_CLK);
      VitalSignalDelay(RAD2_dly, RAD2_ipd, tisd_RAD2_CLK);
      VitalSignalDelay(RAD3_dly, RAD3_ipd, tisd_RAD3_CLK);
      VitalSignalDelay(M1_dly, M1_ipd, tisd_M1_CLK);
      VitalSignalDelay(M0_dly, M0_ipd, tisd_M0_CLK);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLK);
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLK);
      VitalSignalDelay(CE_dly, CE_ipd, tisd_CE_CLK);
      VitalSignalDelay(LSR_dly, LSR_ipd, tisd_LSR_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
      VitalSignalDelay(WD1_dly, WD1_ipd, tisd_WD1_WCK);
      VitalSignalDelay(WD0_dly, WD0_ipd, tisd_WD0_WCK);
      VitalSignalDelay(WAD0_dly, WAD0_ipd, tisd_WAD0_WCK);
      VitalSignalDelay(WAD1_dly, WAD1_ipd, tisd_WAD1_WCK);
      VitalSignalDelay(WAD2_dly, WAD2_ipd, tisd_WAD2_WCK);
      VitalSignalDelay(WAD3_dly, WAD3_ipd, tisd_WAD3_WCK);
      VitalSignalDelay(WRE_dly, WRE_ipd, tisd_WRE_WCK);
      VitalSignalDelay(WCK_dly, WCK_ipd, ticd_WCK);
    END BLOCK;

    P11 : PROCESS (M1_dly, M0_dly, LSR_dly, CE_dly, CLK_dly)
    BEGIN
       IF (M1MUX = "SIG") THEN
          M1_sig <= M1_dly;
       ELSIF (M1MUX = "INV") THEN
          M1_sig <= not M1_dly;
       ELSIF (M1MUX = "VHI") THEN
          M1_sig <= '1';
       ELSE
          M1_sig <= '0';
       END IF;

       IF (M0MUX = "SIG") THEN
          M0_sig <= M0_dly;
       ELSIF (M0MUX = "INV") THEN
          M0_sig <= not M0_dly;
       ELSIF (M0MUX = "VHI") THEN
          M0_sig <= '1';
       ELSE
          M0_sig <= '0';
       END IF;

       IF (LSRMUX = "SIG") THEN
          LSR_sig <= LSR_dly;
       ELSIF (LSRMUX = "INV") THEN
          LSR_sig <= not LSR_dly;
       ELSIF (LSRMUX = "VHI") THEN
          LSR_sig <= '1';
       ELSE
          LSR_sig <= '0';
       END IF;

       IF (CLKMUX = "SIG") THEN
          CLK_sig <= CLK_dly;
       ELSIF (CLKMUX = "INV") THEN
          CLK_sig <= not CLK_dly;
       ELSIF (CLKMUX = "VHI") THEN
          CLK_sig <= '1';
       ELSE
          CLK_sig <= '0';
       END IF;

       IF (CEMUX = "SIG") THEN
          CE_sig <= CE_dly;
       ELSIF (CEMUX = "INV") THEN
          CE_sig <= not CE_dly;
       ELSIF (CEMUX = "VHI") THEN
          CE_sig <= '1';
       ELSE
          CE_sig <= '0';
       END IF;
    END PROCESS;

    P31 : PROCESS (M0_sig, DI0_ipd, LSR_sig)
    BEGIN
       IF (REG0_SD = "VLO") THEN
          D0_sig <= M0_sig;
       ELSIF (REG0_SD = "VHI") THEN
          D0_sig <= DI0_ipd;
       ELSE
          D0_sig <= VitalMUX
                        (data => (DI0_ipd, M0_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

    P32 : PROCESS (M1_sig, DI1_ipd, LSR_sig)
    BEGIN
       IF (REG1_SD = "VLO") THEN
          D1_sig <= M1_sig;
       ELSIF (REG1_SD = "VHI") THEN
          D1_sig <= DI1_ipd;
       ELSE
          D1_sig <= VitalMUX
                        (data => (DI1_ipd, M1_sig),
                         dselect => (0 => LSR_sig));
       END IF;
    END PROCESS;

--    D0_sig <= M0_sig when (REG0_SD = "VLO") else DI0_dly;
--    D1_sig <= M1_sig when (REG1_SD = "VLO") else DI1_dly;

    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    DPR16X4A_INST : DPR16X4A
                   port map (di0 => WD0_dly, di1 => WD1_dly, di2 => '0', di3 => '0', 
                             wad0 => WAD0_dly, wad1 => WAD1_dly, wad2 => WAD2_dly, wad3 => WAD3_dly, 
                             wre => WRE_dly, wck => WCK_dly, 
                             rad0 => RAD0_dly, rad1 => RAD1_dly, rad2 => RAD2_dly, rad3 => RAD3_dly, 
                             do0 => DO0, do1 => DO1, do2 => open, do3 => open);

    P101 : PROCESS (LSR_sig)
    BEGIN
       IF ((REG0_SD = "SIG") or (REG1_SD = "SIG")) THEN
          LSR_sig0 <= '0';
       ELSE
          LSR_sig0 <= LSR_sig;
       END IF;
    END PROCESS;

    GFF : if (SRMODE = "ASYNC") generate
          GFF1 : if (REG0_REGSET = "RESET") generate
                 fd1p3dx_inst0 : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF1;

          GFF2 : if (REG0_REGSET = "SET") generate
                 fd1p3bx_inst0 : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF2;

          GFF3 : if (REG1_REGSET = "RESET") generate
                 fd1p3dx_inst1 : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF3;
          GFF4 : if (REG1_REGSET = "SET") generate
                 fd1p3bx_inst1 : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF4;
    end generate GFF;

    GFF20 : if (SRMODE = "LSR_OVER_CE") generate
          GFF10 : if (REG0_REGSET = "RESET") generate
                 fd1p3ix_inst0 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF10;
          GFF11 : if (REG0_REGSET = "SET") generate
                 fd1p3jx_inst0 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF11;

          GFF12 : if (REG1_REGSET = "RESET") generate
                 fd1p3ix_inst1 : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF12;
          GFF13 : if (REG1_REGSET = "SET") generate
                 fd1p3jx_inst1 : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF13;
    end generate GFF20;


    VitalBehavior : PROCESS (M1_ipd, M1_dly, M0_ipd, M0_dly, DI1_ipd, DI1_dly, DI0_ipd, DI0_dly,
      RAD0_ipd, RAD0_dly, RAD1_ipd, RAD1_dly, RAD2_ipd, RAD2_dly, RAD3_ipd, RAD3_dly,
      CE_dly, LSR_ipd, LSR_dly, CLK_ipd, CLK_dly, WD0_dly, WD1_dly,
      WAD0_dly, WAD1_dly, WAD2_dly, WAD3_dly, WRE_dly, WCK_ipd, WCK_dly,
      QB0, QB1, DO0, DO1)

    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_RAD0_CLK            : x01 := '0';
    VARIABLE RAD0_CLK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_RAD1_CLK            : x01 := '0';
    VARIABLE RAD1_CLK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_RAD2_CLK            : x01 := '0';
    VARIABLE RAD2_CLK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_RAD3_CLK            : x01 := '0';
    VARIABLE RAD3_CLK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_M1_CLK              : x01 := '0';
    VARIABLE M1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_M0_CLK              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK             : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK             : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_CE_CLK              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK             : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_WD0_WCK             : x01 := '0';
    VARIABLE WD0_WCK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_WD1_WCK             : x01 := '0';
    VARIABLE WD1_WCK_TimingDatash      : VitalTimingDataType;
    VARIABLE tviol_WAD0_WCK            : x01 := '0';
    VARIABLE WAD0_WCK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_WAD1_WCK            : x01 := '0';
    VARIABLE WAD1_WCK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_WAD2_WCK            : x01 := '0';
    VARIABLE WAD2_WCK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_WAD3_WCK            : x01 := '0';
    VARIABLE WAD3_WCK_TimingDatash     : VitalTimingDataType;
    VARIABLE tviol_WRE_WCK             : x01 := '0';
    VARIABLE WRE_WCK_TimingDatash      : VitalTimingDataType;

    VARIABLE tviol_WCK              : x01 := '0';
    VARIABLE periodcheckinfo_WCK    : VitalPeriodDataType;
    VARIABLE tviol_LSR              : x01 := '0';
    VARIABLE periodcheckinfo_LSR    : VitalPeriodDataType;
    VARIABLE tviol_CLK              : x01 := '0';
    VARIABLE periodcheckinfo_CLK    : VitalPeriodDataType;

  BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => RAD0_dly,
        TestSignalName => "RAD0",
        TestDelay => tisd_RAD0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD0_CLK_noedge_posedge,
        SetupLow => tsetup_RAD0_CLK_noedge_posedge,
        HoldHigh => thold_RAD0_CLK_noedge_posedge,
        HoldLow => thold_RAD0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_RAD0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD0_CLK_TimingDatash,
        Violation => tviol_RAD0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RAD0_dly,
        TestSignalName => "RAD0",
        TestDelay => tisd_RAD0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD0_CLK_noedge_negedge,
        SetupLow => tsetup_RAD0_CLK_noedge_negedge,
        HoldHigh => thold_RAD0_CLK_noedge_negedge,
        HoldLow => thold_RAD0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_RAD0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD0_CLK_TimingDatash,
        Violation => tviol_RAD0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RAD1_dly,
        TestSignalName => "RAD1",
        TestDelay => tisd_RAD1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD1_CLK_noedge_posedge,
        SetupLow => tsetup_RAD1_CLK_noedge_posedge,
        HoldHigh => thold_RAD1_CLK_noedge_posedge,
        HoldLow => thold_RAD1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_RAD1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD1_CLK_TimingDatash,
        Violation => tviol_RAD1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RAD1_dly,
        TestSignalName => "RAD1",
        TestDelay => tisd_RAD1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD1_CLK_noedge_negedge,
        SetupLow => tsetup_RAD1_CLK_noedge_negedge,
        HoldHigh => thold_RAD1_CLK_noedge_negedge,
        HoldLow => thold_RAD1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_RAD1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD1_CLK_TimingDatash,
        Violation => tviol_RAD1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RAD2_dly,
        TestSignalName => "RAD2",
        TestDelay => tisd_RAD2_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD2_CLK_noedge_posedge,
        SetupLow => tsetup_RAD2_CLK_noedge_posedge,
        HoldHigh => thold_RAD2_CLK_noedge_posedge,
        HoldLow => thold_RAD2_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_RAD2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD2_CLK_TimingDatash,
        Violation => tviol_RAD2_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RAD2_dly,
        TestSignalName => "RAD2",
        TestDelay => tisd_RAD2_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD2_CLK_noedge_negedge,
        SetupLow => tsetup_RAD2_CLK_noedge_negedge,
        HoldHigh => thold_RAD2_CLK_noedge_negedge,
        HoldLow => thold_RAD2_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_RAD2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD2_CLK_TimingDatash,
        Violation => tviol_RAD2_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RAD3_dly,
        TestSignalName => "RAD3",
        TestDelay => tisd_RAD3_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD3_CLK_noedge_posedge,
        SetupLow => tsetup_RAD3_CLK_noedge_posedge,
        HoldHigh => thold_RAD3_CLK_noedge_posedge,
        HoldLow => thold_RAD3_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_RAD3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD3_CLK_TimingDatash,
        Violation => tviol_RAD3_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RAD3_dly,
        TestSignalName => "RAD3",
        TestDelay => tisd_RAD3_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_RAD3_CLK_noedge_negedge,
        SetupLow => tsetup_RAD3_CLK_noedge_negedge,
        HoldHigh => thold_RAD3_CLK_noedge_negedge,
        HoldLow => thold_RAD3_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_RAD3),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RAD3_CLK_TimingDatash,
        Violation => tviol_RAD3_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_posedge,
        SetupLow => tsetup_DI1_CLK_noedge_posedge,
        HoldHigh => thold_DI1_CLK_noedge_posedge,
        HoldLow => thold_DI1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI1_CLK_noedge_negedge,
        SetupLow => tsetup_DI1_CLK_noedge_negedge,
        HoldHigh => thold_DI1_CLK_noedge_negedge,
        HoldLow => thold_DI1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_posedge,
        SetupLow => tsetup_DI0_CLK_noedge_posedge,
        HoldHigh => thold_DI0_CLK_noedge_posedge,
        HoldLow => thold_DI0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DI0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI0_CLK_noedge_negedge,
        SetupLow => tsetup_DI0_CLK_noedge_negedge,
        HoldHigh => thold_DI0_CLK_noedge_negedge,
        HoldLow => thold_DI0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DI0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_posedge,
        SetupLow => tsetup_M1_CLK_noedge_posedge,
        HoldHigh => thold_M1_CLK_noedge_posedge,
        HoldLow => thold_M1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M1_dly,
        TestSignalName => "M1",
        TestDelay => tisd_M1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M1_CLK_noedge_negedge,
        SetupLow => tsetup_M1_CLK_noedge_negedge,
        HoldHigh => thold_M1_CLK_noedge_negedge,
        HoldLow => thold_M1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_posedge,
        SetupLow => tsetup_M0_CLK_noedge_posedge,
        HoldHigh => thold_M0_CLK_noedge_posedge,
        HoldLow => thold_M0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_M0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_M0_CLK_noedge_negedge,
        SetupLow => tsetup_M0_CLK_noedge_negedge,
        HoldHigh => thold_M0_CLK_noedge_negedge,
        HoldLow => thold_M0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_M0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_posedge,
        SetupLow => tsetup_CE_CLK_noedge_posedge,
        HoldHigh => thold_CE_CLK_noedge_posedge,
        HoldLow => thold_CE_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_CE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_negedge,
        SetupLow => tsetup_CE_CLK_noedge_negedge,
        HoldHigh => thold_CE_CLK_noedge_negedge,
        HoldLow => thold_CE_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_CE),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_posedge,
        SetupLow => tsetup_LSR_CLK_noedge_posedge,
        HoldHigh => thold_LSR_CLK_noedge_posedge,
        HoldLow => thold_LSR_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_LSR),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_LSR_CLK_noedge_negedge,
        SetupLow => tsetup_LSR_CLK_noedge_negedge,
        HoldHigh => thold_LSR_CLK_noedge_negedge,
        HoldLow => thold_LSR_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_LSR),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WD0_dly,
        TestSignalName => "WD0",
        TestDelay => tisd_WD0_WCK,
        RefSignal => WCK_dly,
        RefSignalName => "WCK",
        RefDelay => ticd_WCK,
        SetupHigh => tsetup_WD0_WCK_noedge_posedge,
        SetupLow => tsetup_WD0_WCK_noedge_posedge,
        HoldHigh => thold_WD0_WCK_noedge_posedge,
        HoldLow => thold_WD0_WCK_noedge_posedge,
        CheckEnabled => (check_WD0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WD0_WCK_TimingDatash,
        Violation => tviol_WD0_WCK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WD1_dly,
        TestSignalName => "WD1",
        TestDelay => tisd_WD1_WCK,
        RefSignal => WCK_dly,
        RefSignalName => "WCK",
        RefDelay => ticd_WCK,
        SetupHigh => tsetup_WD1_WCK_noedge_posedge,
        SetupLow => tsetup_WD1_WCK_noedge_posedge,
        HoldHigh => thold_WD1_WCK_noedge_posedge,
        HoldLow => thold_WD1_WCK_noedge_posedge,
        CheckEnabled => (check_WD1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WD1_WCK_TimingDatash,
        Violation => tviol_WD1_WCK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WAD0_dly,
        TestSignalName => "WAD0",
        TestDelay => tisd_WAD0_WCK,
        RefSignal => WCK_dly,
        RefSignalName => "WCK",
        RefDelay => ticd_WCK,
        SetupHigh => tsetup_WAD0_WCK_noedge_posedge,
        SetupLow => tsetup_WAD0_WCK_noedge_posedge,
        HoldHigh => thold_WAD0_WCK_noedge_posedge,
        HoldLow => thold_WAD0_WCK_noedge_posedge,
        CheckEnabled => (check_WAD0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WAD0_WCK_TimingDatash,
        Violation => tviol_WAD0_WCK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WAD1_dly,
        TestSignalName => "WAD1",
        TestDelay => tisd_WAD1_WCK,
        RefSignal => WCK_dly,
        RefSignalName => "WCK",
        RefDelay => ticd_WCK,
        SetupHigh => tsetup_WAD1_WCK_noedge_posedge,
        SetupLow => tsetup_WAD1_WCK_noedge_posedge,
        HoldHigh => thold_WAD1_WCK_noedge_posedge,
        HoldLow => thold_WAD1_WCK_noedge_posedge,
        CheckEnabled => (check_WAD1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WAD1_WCK_TimingDatash,
        Violation => tviol_WAD1_WCK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WAD2_dly,
        TestSignalName => "WAD2",
        TestDelay => tisd_WAD2_WCK,
        RefSignal => WCK_dly,
        RefSignalName => "WCK",
        RefDelay => ticd_WCK,
        SetupHigh => tsetup_WAD2_WCK_noedge_posedge,
        SetupLow => tsetup_WAD2_WCK_noedge_posedge,
        HoldHigh => thold_WAD2_WCK_noedge_posedge,
        HoldLow => thold_WAD2_WCK_noedge_posedge,
        CheckEnabled => (check_WAD2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WAD2_WCK_TimingDatash,
        Violation => tviol_WAD2_WCK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WAD3_dly,
        TestSignalName => "WAD3",
        TestDelay => tisd_WAD3_WCK,
        RefSignal => WCK_dly,
        RefSignalName => "WCK",
        RefDelay => ticd_WCK,
        SetupHigh => tsetup_WAD3_WCK_noedge_posedge,
        SetupLow => tsetup_WAD3_WCK_noedge_posedge,
        HoldHigh => thold_WAD3_WCK_noedge_posedge,
        HoldLow => thold_WAD3_WCK_noedge_posedge,
        CheckEnabled => (check_WAD3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WAD3_WCK_TimingDatash,
        Violation => tviol_WAD3_WCK,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WRE_dly,
        TestSignalName => "WRE",
        TestDelay => tisd_WRE_WCK,
        RefSignal => WCK_dly,
        RefSignalName => "WCK",
        RefDelay => ticd_WCK,
        SetupHigh => tsetup_WRE_WCK_noedge_posedge,
        SetupLow => tsetup_WRE_WCK_noedge_posedge,
        HoldHigh => thold_WRE_WCK_noedge_posedge,
        HoldLow => thold_WRE_WCK_noedge_posedge,
        CheckEnabled => (check_WRE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WRE_WCK_TimingDatash,
        Violation => tviol_WRE_WCK,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => LSR_ipd,
        TestSignalName => "LSR",
        Period => tperiod_LSR,
        PulseWidthHigh => tpw_LSR_posedge,
        PulseWidthLow => tpw_LSR_negedge,
        PeriodData => periodcheckinfo_LSR,
        Violation => tviol_LSR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => WCK_ipd,
        TestSignalName => "WCK",
        Period => tperiod_WCK,
        PulseWidthHigh => tpw_WCK_posedge,
        PulseWidthLow => tpw_WCK_negedge,
        PeriodData => periodcheckinfo_WCK,
        Violation => tviol_WCK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    Q1_zd := QB1;
    Q0_zd := QB0;
    F1_zd := DO1;
    F0_zd := DO0;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => Q1,
       OutSignalName => "Q1",
       OutTemp => Q1_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q1,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q1, PathCondition => TRUE)),
       GlitchData => Q1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q0,
       OutSignalName => "Q0",
       OutTemp => Q0_zd,
       Paths => (0 => (InputChangeTime => clk_ipd'last_event,
                       PathDelay => tpd_clk_Q0,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q0, PathCondition => TRUE)),
       GlitchData => Q0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F1,
       OutSignalName => "F1",
       OutTemp => F1_zd,
       Paths => (0 => (InputChangeTime => RAD0_ipd'last_event,
                       PathDelay => tpd_RAD0_F1,
                       PathCondition => TRUE),
                 1 => (RAD1_ipd'last_event, tpd_RAD1_F1, PathCondition => TRUE),
                 2 => (RAD2_ipd'last_event, tpd_RAD2_F1, PathCondition => TRUE),
                 3 => (RAD3_ipd'last_event, tpd_RAD3_F1, PathCondition => TRUE)),
       GlitchData => F1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F0,
       OutSignalName => "F0",
       OutTemp => F0_zd,
       Paths => (0 => (InputChangeTime => RAD0_ipd'last_event,
                       PathDelay => tpd_RAD0_F0,
                       PathCondition => TRUE),
                 1 => (RAD1_ipd'last_event, tpd_RAD1_F0, PathCondition => TRUE),
                 2 => (RAD2_ipd'last_event, tpd_RAD2_F0, PathCondition => TRUE),
                 3 => (RAD3_ipd'last_event, tpd_RAD3_F0, PathCondition => TRUE)),
       GlitchData => F0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SBRAMB IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SBRAMB";

        DATA_WIDTH_A               : Integer  := 18;
        DATA_WIDTH_B               : Integer  := 18;
        REGMODE_A                  : String  := "NOREG";
        REGMODE_B                  : String  := "NOREG";
        RESETMODE                  : String  := "SYNC";
        CSDECODE_A                 : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_B                 : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE_A                : String  := "NORMAL";
        WRITEMODE_B                : String  := "NORMAL";
        GSR                        : String  := "DISABLED";

        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";

        CLKA_NEGEDGE    : boolean := FALSE;
        CLKB_NEGEDGE    : boolean := FALSE;

        check_DIA0      : boolean := FALSE;
        check_DIA1      : boolean := FALSE;
        check_DIA2      : boolean := FALSE;
        check_DIA3      : boolean := FALSE;
        check_DIA4      : boolean := FALSE;
        check_DIA5      : boolean := FALSE;
        check_DIA6      : boolean := FALSE;
        check_DIA7      : boolean := FALSE;
        check_DIA8      : boolean := FALSE;
        check_DIA9      : boolean := FALSE;
        check_DIA10      : boolean := FALSE;
        check_DIA11      : boolean := FALSE;
        check_DIA12      : boolean := FALSE;
        check_DIA13      : boolean := FALSE;
        check_DIA14      : boolean := FALSE;
        check_DIA15      : boolean := FALSE;
        check_DIA16      : boolean := FALSE;
        check_DIA17      : boolean := FALSE;
        check_ADA0      : boolean := FALSE;
        check_ADA1      : boolean := FALSE;
        check_ADA2      : boolean := FALSE;
        check_ADA3      : boolean := FALSE;
        check_ADA4      : boolean := FALSE;
        check_ADA5      : boolean := FALSE;
        check_ADA6      : boolean := FALSE;
        check_ADA7      : boolean := FALSE;
        check_ADA8      : boolean := FALSE;
        check_ADA9      : boolean := FALSE;
        check_ADA10      : boolean := FALSE;
        check_ADA11      : boolean := FALSE;
        check_ADA12      : boolean := FALSE;
        check_ADA13      : boolean := FALSE;
        check_CEA        : boolean := FALSE;
        check_WEA        : boolean := FALSE;
        check_CSA0       : boolean := FALSE;
        check_CSA1       : boolean := FALSE;
        check_CSA2       : boolean := FALSE;
        check_RSTA       : boolean := FALSE;

        check_DIB0      : boolean := FALSE;
        check_DIB1      : boolean := FALSE;
        check_DIB2      : boolean := FALSE;
        check_DIB3      : boolean := FALSE;
        check_DIB4      : boolean := FALSE;
        check_DIB5      : boolean := FALSE;
        check_DIB6      : boolean := FALSE;
        check_DIB7      : boolean := FALSE;
        check_DIB8      : boolean := FALSE;
        check_DIB9      : boolean := FALSE;
        check_DIB10      : boolean := FALSE;   
        check_DIB11      : boolean := FALSE; 
        check_DIB12      : boolean := FALSE; 
        check_DIB13      : boolean := FALSE; 
        check_DIB14      : boolean := FALSE; 
        check_DIB15      : boolean := FALSE; 
        check_DIB16      : boolean := FALSE; 
        check_DIB17      : boolean := FALSE; 
        check_ADB0      : boolean := FALSE;   
        check_ADB1      : boolean := FALSE;
        check_ADB2      : boolean := FALSE;
        check_ADB3      : boolean := FALSE;
        check_ADB4      : boolean := FALSE;
        check_ADB5      : boolean := FALSE;
        check_ADB6      : boolean := FALSE;
        check_ADB7      : boolean := FALSE;
        check_ADB8      : boolean := FALSE;
        check_ADB9      : boolean := FALSE;
        check_ADB10      : boolean := FALSE;
        check_ADB11      : boolean := FALSE;
        check_ADB12      : boolean := FALSE;
        check_ADB13      : boolean := FALSE;
        check_CEB        : boolean := FALSE;
        check_WEB        : boolean := FALSE;
        check_CSB0       : boolean := FALSE;
        check_CSB1       : boolean := FALSE;
        check_CSB2       : boolean := FALSE;
        check_RSTB       : boolean := FALSE;

        -- input SIGNAL delays
        tipd_DIA0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA10  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA11  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA12  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA13  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA14  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA15  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA16  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIA17  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA10  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA11  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA12  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADA13  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CEA    : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WEA    : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSA0   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSA1   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSA2   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RSTA   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLKA   : VitalDelayType01 := (0.0 ns, 0.0 ns);

        tipd_DIB0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB10  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB11  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB12  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB13  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB14  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB15  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB16  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DIB17  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB0  : VitalDelayType01 := (0.0 ns, 0.0 ns);   
        tipd_ADB1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB10  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB11  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB12  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ADB13  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CEB    : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WEB    : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSB0   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSB1   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSB2   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RSTB   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLKB   : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLKA_DOA0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKA_DOA17     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOB17     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKB_DOA17     : VitalDelayType01 := (0 ns, 0 ns);

        tpd_RSTA_DOA0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTA_DOA17     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOB17     : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLKA          : VitalDelayType := 0 ns;
        tisd_DIA0_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA1_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA2_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA3_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA4_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA5_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA6_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA7_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA8_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA9_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA10_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA11_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA12_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA13_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA14_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA15_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA16_CLKA      : VitalDelayType := 0 ns;
        tisd_DIA17_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA0_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA1_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA2_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA3_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA4_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA5_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA6_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA7_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA8_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA9_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA10_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA11_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA12_CLKA      : VitalDelayType := 0 ns;
        tisd_ADA13_CLKA      : VitalDelayType := 0 ns;
        tisd_CEA_CLKA      : VitalDelayType := 0 ns;
        tisd_WEA_CLKA      : VitalDelayType := 0 ns;
        tisd_CSA0_CLKA      : VitalDelayType := 0 ns;
        tisd_CSA1_CLKA      : VitalDelayType := 0 ns;
        tisd_CSA2_CLKA      : VitalDelayType := 0 ns;
        tisd_RSTA_CLKA      : VitalDelayType := 0 ns;

        ticd_CLKB          : VitalDelayType := 0 ns;
        tisd_DIB0_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB1_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB2_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB3_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB4_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB5_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB6_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB7_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB8_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB9_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB10_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB11_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB12_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB13_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB14_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB15_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB16_CLKB      : VitalDelayType := 0 ns;
        tisd_DIB17_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB0_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB1_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB2_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB3_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB4_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB5_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB6_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB7_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB8_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB9_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB10_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB11_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB12_CLKB      : VitalDelayType := 0 ns;
        tisd_ADB13_CLKB      : VitalDelayType := 0 ns;
        tisd_CEB_CLKB      : VitalDelayType := 0 ns;
        tisd_WEB_CLKB      : VitalDelayType := 0 ns;
        tisd_CSB0_CLKB      : VitalDelayType := 0 ns;
        tisd_CSB1_CLKB      : VitalDelayType := 0 ns;
        tisd_CSB2_CLKB      : VitalDelayType := 0 ns;
        tisd_RSTB_CLKB      : VitalDelayType := 0 ns;

        tsetup_DIA0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA3_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA4_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA5_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA6_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA7_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA8_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA9_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA10_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA11_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA12_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA13_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA14_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA15_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA16_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIA17_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA3_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA4_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA5_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA6_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA7_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA8_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA9_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA10_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA11_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA12_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADA13_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CEA_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_WEA_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSA0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSA1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSA2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_RSTA_CLKA_noedge_posedge     : VitalDelayType := 0 ns;

        tsetup_DIA0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA3_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA4_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA5_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA6_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA7_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA8_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA9_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA10_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA11_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA12_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA13_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA14_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA15_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA16_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIA17_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA3_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA4_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA5_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA6_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA7_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA8_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA9_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA10_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA11_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA12_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADA13_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CEA_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_WEA_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSA0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSA1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSA2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_RSTA_CLKA_noedge_negedge     : VitalDelayType := 0 ns;

        tsetup_DIB0_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB1_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB2_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB3_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB4_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB5_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB6_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB7_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB8_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB9_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB10_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB11_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB12_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB13_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB14_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB15_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB16_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB17_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB0_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB1_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB2_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB3_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB4_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB5_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB6_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB7_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB8_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB9_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB10_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB11_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB12_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_ADB13_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CEB_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_WEB_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSB0_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSB1_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSB2_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_RSTB_CLKB_noedge_posedge     : VitalDelayType := 0 ns;

        tsetup_DIB0_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB1_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB2_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB3_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB4_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB5_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB6_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB7_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB8_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB9_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB10_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB11_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB12_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB13_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB14_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB15_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB16_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB17_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB0_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB1_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB2_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB3_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB4_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB5_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB6_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB7_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB8_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB9_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB10_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB11_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB12_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_ADB13_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CEB_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_WEB_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSB0_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSB1_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSB2_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_RSTB_CLKB_noedge_negedge     : VitalDelayType := 0 ns;

        tsetup_DIB0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB3_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB4_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB5_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB6_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB7_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB8_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB9_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB10_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB11_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB12_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB13_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB14_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB15_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB16_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DIB17_CLKA_noedge_posedge     : VitalDelayType := 0 ns;

        tsetup_DIB0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB3_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB4_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB5_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB6_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB7_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB8_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB9_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB10_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB11_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB12_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB13_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB14_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB15_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB16_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DIB17_CLKA_noedge_negedge     : VitalDelayType := 0 ns;

        thold_DIA0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA3_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA4_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA5_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA6_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA7_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA8_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA9_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA10_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA11_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA12_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA13_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA14_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA15_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA16_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIA17_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA3_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA4_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA5_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA6_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA7_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA8_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA9_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA10_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA11_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA12_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADA13_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CEA_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_WEA_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSA0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSA1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSA2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_RSTA_CLKA_noedge_posedge     : VitalDelayType := 0 ns;

        thold_DIA0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA3_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA4_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA5_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA6_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA7_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA8_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA9_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA10_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA11_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA12_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA13_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA14_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA15_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA16_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIA17_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA3_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA4_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA5_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA6_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA7_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA8_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA9_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA10_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA11_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA12_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADA13_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CEA_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_WEA_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSA0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSA1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSA2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_RSTA_CLKA_noedge_negedge     : VitalDelayType := 0 ns;

        thold_DIB0_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB1_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB2_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB3_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB4_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB5_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB6_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB7_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB8_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB9_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB10_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB11_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB12_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB13_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB14_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB15_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB16_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB17_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB0_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB1_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB2_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB3_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB4_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB5_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB6_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB7_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB8_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB9_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB10_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB11_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB12_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_ADB13_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CEB_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_WEB_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSB0_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSB1_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSB2_CLKB_noedge_posedge     : VitalDelayType := 0 ns;
        thold_RSTB_CLKB_noedge_posedge     : VitalDelayType := 0 ns;

        thold_DIB0_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB1_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB2_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB3_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB4_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB5_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB6_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB7_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB8_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB9_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB10_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB11_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB12_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB13_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB14_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB15_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB16_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB17_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB0_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB1_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB2_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB3_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB4_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB5_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB6_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB7_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB8_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB9_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB10_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB11_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB12_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_ADB13_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CEB_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_WEB_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSB0_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSB1_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSB2_CLKB_noedge_negedge     : VitalDelayType := 0 ns;
        thold_RSTB_CLKB_noedge_negedge     : VitalDelayType := 0 ns;

        thold_DIB0_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB1_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB2_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB3_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB4_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB5_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB6_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB7_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB8_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB9_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB10_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB11_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB12_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB13_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB14_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB15_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB16_CLKA_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DIB17_CLKA_noedge_posedge     : VitalDelayType := 0 ns;

        thold_DIB0_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB1_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB2_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB3_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB4_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB5_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB6_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB7_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB8_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB9_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB10_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB11_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB12_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB13_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB14_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB15_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB16_CLKA_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DIB17_CLKA_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_CLKA            : VitalDelayType := 0.001 ns;
        tpw_CLKA_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLKA_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLKB            : VitalDelayType := 0.001 ns;
        tpw_CLKB_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLKB_negedge        : VitalDelayType := 0.001 ns;
        tperiod_RSTA            : VitalDelayType := 0.001 ns;
        tpw_RSTA_posedge        : VitalDelayType := 0.001 ns;
        tpw_RSTA_negedge        : VitalDelayType := 0.001 ns;
        tperiod_RSTB            : VitalDelayType := 0.001 ns;
        tpw_RSTB_posedge        : VitalDelayType := 0.001 ns;
        tpw_RSTB_negedge        : VitalDelayType := 0.001 ns
);

   PORT(
        DIA0, DIA1, DIA2, DIA3, DIA4, DIA5, DIA6, DIA7, DIA8            : in std_logic := 'X';
        DIA9, DIA10, DIA11, DIA12, DIA13, DIA14, DIA15, DIA16, DIA17    : in std_logic := 'X';
        ADA0, ADA1, ADA2, ADA3, ADA4, ADA5, ADA6, ADA7, ADA8            : in std_logic := 'X';
        ADA9, ADA10, ADA11, ADA12, ADA13                                : in std_logic := 'X';
        CEA, CLKA, WEA, CSA0, CSA1, CSA2, RSTA                          : in std_logic := 'X';
        DIB0, DIB1, DIB2, DIB3, DIB4, DIB5, DIB6, DIB7, DIB8            : in std_logic := 'X';
        DIB9, DIB10, DIB11, DIB12, DIB13, DIB14, DIB15, DIB16, DIB17    : in std_logic := 'X';
        ADB0, ADB1, ADB2, ADB3, ADB4, ADB5, ADB6, ADB7, ADB8            : in std_logic := 'X';
        ADB9, ADB10, ADB11, ADB12, ADB13                                : in std_logic := 'X';
        CEB, CLKB, WEB, CSB0, CSB1, CSB2, RSTB                          : in std_logic := 'X';

        DOA0, DOA1, DOA2, DOA3, DOA4, DOA5, DOA6, DOA7, DOA8            : out std_logic := 'X';
        DOA9, DOA10, DOA11, DOA12, DOA13, DOA14, DOA15, DOA16, DOA17    : out std_logic := 'X';
        DOB0, DOB1, DOB2, DOB3, DOB4, DOB5, DOB6, DOB7, DOB8            : out std_logic := 'X';
        DOB9, DOB10, DOB11, DOB12, DOB13, DOB14, DOB15, DOB16, DOB17    : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF SBRAMB : ENTITY IS TRUE;

END SBRAMB ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SBRAMB IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal DIA0_ipd       : std_logic := 'X';
    signal DIA1_ipd       : std_logic := 'X';
    signal DIA2_ipd       : std_logic := 'X';
    signal DIA3_ipd       : std_logic := 'X';
    signal DIA4_ipd       : std_logic := 'X';
    signal DIA5_ipd       : std_logic := 'X';
    signal DIA6_ipd       : std_logic := 'X';
    signal DIA7_ipd       : std_logic := 'X';
    signal DIA8_ipd       : std_logic := 'X';
    signal DIA9_ipd       : std_logic := 'X';
    signal DIA10_ipd       : std_logic := 'X';
    signal DIA11_ipd       : std_logic := 'X';
    signal DIA12_ipd       : std_logic := 'X';
    signal DIA13_ipd       : std_logic := 'X';
    signal DIA14_ipd       : std_logic := 'X';
    signal DIA15_ipd       : std_logic := 'X';
    signal DIA16_ipd       : std_logic := 'X';
    signal DIA17_ipd       : std_logic := 'X';
    signal ADA0_ipd       : std_logic := 'X';
    signal ADA1_ipd       : std_logic := 'X';
    signal ADA2_ipd       : std_logic := 'X';
    signal ADA3_ipd       : std_logic := 'X';
    signal ADA4_ipd       : std_logic := 'X';
    signal ADA5_ipd       : std_logic := 'X';
    signal ADA6_ipd       : std_logic := 'X';
    signal ADA7_ipd       : std_logic := 'X';
    signal ADA8_ipd       : std_logic := 'X';
    signal ADA9_ipd       : std_logic := 'X';
    signal ADA10_ipd       : std_logic := 'X';
    signal ADA11_ipd       : std_logic := 'X';
    signal ADA12_ipd       : std_logic := 'X';
    signal ADA13_ipd       : std_logic := 'X';
    signal CEA_ipd       : std_logic := 'X';
    signal WEA_ipd       : std_logic := 'X';
    signal CSA0_ipd       : std_logic := 'X';
    signal CSA1_ipd       : std_logic := 'X';
    signal CSA2_ipd       : std_logic := 'X';
    signal RSTA_ipd       : std_logic := 'X';
    signal DIB0_ipd       : std_logic := 'X'; 
    signal DIB1_ipd       : std_logic := 'X';
    signal DIB2_ipd       : std_logic := 'X';
    signal DIB3_ipd       : std_logic := 'X';
    signal DIB4_ipd       : std_logic := 'X';
    signal DIB5_ipd       : std_logic := 'X';
    signal DIB6_ipd       : std_logic := 'X';
    signal DIB7_ipd       : std_logic := 'X';
    signal DIB8_ipd       : std_logic := 'X';
    signal DIB9_ipd       : std_logic := 'X';
    signal DIB10_ipd       : std_logic := 'X';
    signal DIB11_ipd       : std_logic := 'X';
    signal DIB12_ipd       : std_logic := 'X';
    signal DIB13_ipd       : std_logic := 'X';
    signal DIB14_ipd       : std_logic := 'X';
    signal DIB15_ipd       : std_logic := 'X';
    signal DIB16_ipd       : std_logic := 'X';
    signal DIB17_ipd       : std_logic := 'X';
    signal ADB0_ipd       : std_logic := 'X';
    signal ADB1_ipd       : std_logic := 'X';
    signal ADB2_ipd       : std_logic := 'X';
    signal ADB3_ipd       : std_logic := 'X';
    signal ADB4_ipd       : std_logic := 'X';
    signal ADB5_ipd       : std_logic := 'X';
    signal ADB6_ipd       : std_logic := 'X';
    signal ADB7_ipd       : std_logic := 'X';
    signal ADB8_ipd       : std_logic := 'X';
    signal ADB9_ipd       : std_logic := 'X';
    signal ADB10_ipd       : std_logic := 'X';
    signal ADB11_ipd       : std_logic := 'X';
    signal ADB12_ipd       : std_logic := 'X';
    signal ADB13_ipd       : std_logic := 'X';
    signal CEB_ipd       : std_logic := 'X';
    signal WEB_ipd       : std_logic := 'X';
    signal CSB0_ipd       : std_logic := 'X';
    signal CSB1_ipd       : std_logic := 'X';
    signal CSB2_ipd       : std_logic := 'X';
    signal RSTB_ipd       : std_logic := 'X';
    signal CLKA_ipd       : std_logic := 'X';
    signal CLKB_ipd       : std_logic := 'X';

    signal DIA0_dly       : std_logic := 'X';
    signal DIA1_dly       : std_logic := 'X';
    signal DIA2_dly       : std_logic := 'X';
    signal DIA3_dly       : std_logic := 'X';
    signal DIA4_dly       : std_logic := 'X';
    signal DIA5_dly       : std_logic := 'X';
    signal DIA6_dly       : std_logic := 'X';
    signal DIA7_dly       : std_logic := 'X';
    signal DIA8_dly       : std_logic := 'X';
    signal DIA9_dly       : std_logic := 'X';
    signal DIA10_dly       : std_logic := 'X';
    signal DIA11_dly       : std_logic := 'X';
    signal DIA12_dly       : std_logic := 'X';
    signal DIA13_dly       : std_logic := 'X';
    signal DIA14_dly       : std_logic := 'X';
    signal DIA15_dly       : std_logic := 'X';
    signal DIA16_dly       : std_logic := 'X';
    signal DIA17_dly       : std_logic := 'X';
    signal ADA0_dly       : std_logic := 'X';
    signal ADA1_dly       : std_logic := 'X';
    signal ADA2_dly       : std_logic := 'X';
    signal ADA3_dly       : std_logic := 'X';
    signal ADA4_dly       : std_logic := 'X';
    signal ADA5_dly       : std_logic := 'X';
    signal ADA6_dly       : std_logic := 'X';
    signal ADA7_dly       : std_logic := 'X';
    signal ADA8_dly       : std_logic := 'X';
    signal ADA9_dly       : std_logic := 'X';
    signal ADA10_dly       : std_logic := 'X';
    signal ADA11_dly       : std_logic := 'X';
    signal ADA12_dly       : std_logic := 'X';
    signal ADA13_dly       : std_logic := 'X';
    signal CEA_dly       : std_logic := 'X';
    signal WEA_dly       : std_logic := 'X';
    signal CSA0_dly       : std_logic := 'X';
    signal CSA1_dly       : std_logic := 'X';
    signal CSA2_dly       : std_logic := 'X';
    signal RSTA_dly       : std_logic := 'X';
    signal DIB0_dly       : std_logic := 'X'; 
    signal DIB1_dly       : std_logic := 'X';
    signal DIB2_dly       : std_logic := 'X';
    signal DIB3_dly       : std_logic := 'X';
    signal DIB4_dly       : std_logic := 'X';
    signal DIB5_dly       : std_logic := 'X';
    signal DIB6_dly       : std_logic := 'X';
    signal DIB7_dly       : std_logic := 'X';
    signal DIB8_dly       : std_logic := 'X';
    signal DIB9_dly       : std_logic := 'X';
    signal DIB10_dly       : std_logic := 'X';
    signal DIB11_dly       : std_logic := 'X';
    signal DIB12_dly       : std_logic := 'X';
    signal DIB13_dly       : std_logic := 'X';
    signal DIB14_dly       : std_logic := 'X';
    signal DIB15_dly       : std_logic := 'X';
    signal DIB16_dly       : std_logic := 'X';
    signal DIB17_dly       : std_logic := 'X';
    signal ADB0_dly       : std_logic := 'X';
    signal ADB1_dly       : std_logic := 'X';
    signal ADB2_dly       : std_logic := 'X';
    signal ADB3_dly       : std_logic := 'X';
    signal ADB4_dly       : std_logic := 'X';
    signal ADB5_dly       : std_logic := 'X';
    signal ADB6_dly       : std_logic := 'X';
    signal ADB7_dly       : std_logic := 'X';
    signal ADB8_dly       : std_logic := 'X';
    signal ADB9_dly       : std_logic := 'X';
    signal ADB10_dly       : std_logic := 'X';
    signal ADB11_dly       : std_logic := 'X';
    signal ADB12_dly       : std_logic := 'X';
    signal ADB13_dly       : std_logic := 'X';
    signal CEB_dly       : std_logic := 'X';
    signal WEB_dly       : std_logic := 'X';
    signal CSB0_dly       : std_logic := 'X';
    signal CSB1_dly       : std_logic := 'X';
    signal CSB2_dly       : std_logic := 'X';
    signal RSTB_dly       : std_logic := 'X';
    signal CLKA_dly       : std_logic := 'X';
    signal CLKB_dly       : std_logic := 'X';
    signal DOA0_dly       : std_logic := 'X';
    signal DOA1_dly       : std_logic := 'X';
    signal DOA2_dly       : std_logic := 'X';
    signal DOA3_dly       : std_logic := 'X';
    signal DOA4_dly       : std_logic := 'X';
    signal DOA5_dly       : std_logic := 'X';
    signal DOA6_dly       : std_logic := 'X';
    signal DOA7_dly       : std_logic := 'X';
    signal DOA8_dly       : std_logic := 'X';
    signal DOA9_dly       : std_logic := 'X';
    signal DOA10_dly       : std_logic := 'X';
    signal DOA11_dly       : std_logic := 'X';
    signal DOA12_dly       : std_logic := 'X';
    signal DOA13_dly       : std_logic := 'X';
    signal DOA14_dly       : std_logic := 'X';
    signal DOA15_dly       : std_logic := 'X';
    signal DOA16_dly       : std_logic := 'X';
    signal DOA17_dly       : std_logic := 'X';
    signal DOB0_dly       : std_logic := 'X';
    signal DOB1_dly       : std_logic := 'X';
    signal DOB2_dly       : std_logic := 'X';
    signal DOB3_dly       : std_logic := 'X';
    signal DOB4_dly       : std_logic := 'X';
    signal DOB5_dly       : std_logic := 'X';
    signal DOB6_dly       : std_logic := 'X';
    signal DOB7_dly       : std_logic := 'X';
    signal DOB8_dly       : std_logic := 'X';
    signal DOB9_dly       : std_logic := 'X';
    signal DOB10_dly       : std_logic := 'X';
    signal DOB11_dly       : std_logic := 'X';
    signal DOB12_dly       : std_logic := 'X';
    signal DOB13_dly       : std_logic := 'X';
    signal DOB14_dly       : std_logic := 'X';
    signal DOB15_dly       : std_logic := 'X';
    signal DOB16_dly       : std_logic := 'X';
    signal DOB17_dly       : std_logic := 'X';

    BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(DIA0_ipd, DIA0, tipd_DIA0);
      VitalWireDelay(DIA1_ipd, DIA1, tipd_DIA1);
      VitalWireDelay(DIA2_ipd, DIA2, tipd_DIA2);
      VitalWireDelay(DIA3_ipd, DIA3, tipd_DIA3);
      VitalWireDelay(DIA4_ipd, DIA4, tipd_DIA4);
      VitalWireDelay(DIA5_ipd, DIA5, tipd_DIA5);
      VitalWireDelay(DIA6_ipd, DIA6, tipd_DIA6);
      VitalWireDelay(DIA7_ipd, DIA7, tipd_DIA7);
      VitalWireDelay(DIA8_ipd, DIA8, tipd_DIA8);
      VitalWireDelay(DIA9_ipd, DIA9, tipd_DIA9);
      VitalWireDelay(DIA10_ipd, DIA10, tipd_DIA10);
      VitalWireDelay(DIA11_ipd, DIA11, tipd_DIA11);
      VitalWireDelay(DIA12_ipd, DIA12, tipd_DIA12);
      VitalWireDelay(DIA13_ipd, DIA13, tipd_DIA13);
      VitalWireDelay(DIA14_ipd, DIA14, tipd_DIA14);
      VitalWireDelay(DIA15_ipd, DIA15, tipd_DIA15);
      VitalWireDelay(DIA16_ipd, DIA16, tipd_DIA16);
      VitalWireDelay(DIA17_ipd, DIA17, tipd_DIA17);
      VitalWireDelay(ADA0_ipd, ADA0, tipd_ADA0);
      VitalWireDelay(ADA1_ipd, ADA1, tipd_ADA1);
      VitalWireDelay(ADA2_ipd, ADA2, tipd_ADA2);
      VitalWireDelay(ADA3_ipd, ADA3, tipd_ADA3);
      VitalWireDelay(ADA4_ipd, ADA4, tipd_ADA4);
      VitalWireDelay(ADA5_ipd, ADA5, tipd_ADA5);
      VitalWireDelay(ADA6_ipd, ADA6, tipd_ADA6);
      VitalWireDelay(ADA7_ipd, ADA7, tipd_ADA7);
      VitalWireDelay(ADA8_ipd, ADA8, tipd_ADA8);
      VitalWireDelay(ADA9_ipd, ADA9, tipd_ADA9);
      VitalWireDelay(ADA10_ipd, ADA10, tipd_ADA10);
      VitalWireDelay(ADA11_ipd, ADA11, tipd_ADA11);
      VitalWireDelay(ADA12_ipd, ADA12, tipd_ADA12);
      VitalWireDelay(ADA13_ipd, ADA13, tipd_ADA13);
      VitalWireDelay(CEA_ipd, CEA, tipd_CEA);
      VitalWireDelay(WEA_ipd, WEA, tipd_WEA);
      VitalWireDelay(CSA0_ipd, CSA0, tipd_CSA0);
      VitalWireDelay(CSA1_ipd, CSA1, tipd_CSA1);
      VitalWireDelay(CSA2_ipd, CSA2, tipd_CSA2);
      VitalWireDelay(RSTA_ipd, RSTA, tipd_RSTA);
      VitalWireDelay(DIB0_ipd, DIB0, tipd_DIB0);
      VitalWireDelay(DIB1_ipd, DIB1, tipd_DIB1);
      VitalWireDelay(DIB2_ipd, DIB2, tipd_DIB2);
      VitalWireDelay(DIB3_ipd, DIB3, tipd_DIB3);
      VitalWireDelay(DIB4_ipd, DIB4, tipd_DIB4);
      VitalWireDelay(DIB5_ipd, DIB5, tipd_DIB5);
      VitalWireDelay(DIB6_ipd, DIB6, tipd_DIB6);
      VitalWireDelay(DIB7_ipd, DIB7, tipd_DIB7);
      VitalWireDelay(DIB8_ipd, DIB8, tipd_DIB8);
      VitalWireDelay(DIB9_ipd, DIB9, tipd_DIB9);
      VitalWireDelay(DIB10_ipd, DIB10, tipd_DIB10);
      VitalWireDelay(DIB11_ipd, DIB11, tipd_DIB11);
      VitalWireDelay(DIB12_ipd, DIB12, tipd_DIB12);
      VitalWireDelay(DIB13_ipd, DIB13, tipd_DIB13);
      VitalWireDelay(DIB14_ipd, DIB14, tipd_DIB14);
      VitalWireDelay(DIB15_ipd, DIB15, tipd_DIB15);
      VitalWireDelay(DIB16_ipd, DIB16, tipd_DIB16);
      VitalWireDelay(DIB17_ipd, DIB17, tipd_DIB17);
      VitalWireDelay(ADB0_ipd, ADB0, tipd_ADB0);  
      VitalWireDelay(ADB1_ipd, ADB1, tipd_ADB1);
      VitalWireDelay(ADB2_ipd, ADB2, tipd_ADB2);
      VitalWireDelay(ADB3_ipd, ADB3, tipd_ADB3);
      VitalWireDelay(ADB4_ipd, ADB4, tipd_ADB4);
      VitalWireDelay(ADB5_ipd, ADB5, tipd_ADB5);
      VitalWireDelay(ADB6_ipd, ADB6, tipd_ADB6);
      VitalWireDelay(ADB7_ipd, ADB7, tipd_ADB7);
      VitalWireDelay(ADB8_ipd, ADB8, tipd_ADB8);
      VitalWireDelay(ADB9_ipd, ADB9, tipd_ADB9);
      VitalWireDelay(ADB10_ipd, ADB10, tipd_ADB10);
      VitalWireDelay(ADB11_ipd, ADB11, tipd_ADB11);
      VitalWireDelay(ADB12_ipd, ADB12, tipd_ADB12);
      VitalWireDelay(ADB13_ipd, ADB13, tipd_ADB13);
      VitalWireDelay(CEB_ipd, CEB, tipd_CEB);  
      VitalWireDelay(WEB_ipd, WEB, tipd_WEB);
      VitalWireDelay(CSB0_ipd, CSB0, tipd_CSB0);
      VitalWireDelay(CSB1_ipd, CSB1, tipd_CSB1);
      VitalWireDelay(CSB2_ipd, CSB2, tipd_CSB2);
      VitalWireDelay(RSTB_ipd, RSTB, tipd_RSTB);
      VitalWireDelay(CLKA_ipd, CLKA, tipd_CLKA);
      VitalWireDelay(CLKB_ipd, CLKB, tipd_CLKB);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(DIA0_dly, DIA0_ipd, tisd_DIA0_CLKA);
      VitalSignalDelay(DIA1_dly, DIA1_ipd, tisd_DIA1_CLKA);
      VitalSignalDelay(DIA2_dly, DIA2_ipd, tisd_DIA2_CLKA);
      VitalSignalDelay(DIA3_dly, DIA3_ipd, tisd_DIA3_CLKA);
      VitalSignalDelay(DIA4_dly, DIA4_ipd, tisd_DIA4_CLKA);
      VitalSignalDelay(DIA5_dly, DIA5_ipd, tisd_DIA5_CLKA);
      VitalSignalDelay(DIA6_dly, DIA6_ipd, tisd_DIA6_CLKA);
      VitalSignalDelay(DIA7_dly, DIA7_ipd, tisd_DIA7_CLKA);
      VitalSignalDelay(DIA8_dly, DIA8_ipd, tisd_DIA8_CLKA);
      VitalSignalDelay(DIA9_dly, DIA9_ipd, tisd_DIA9_CLKA);
      VitalSignalDelay(DIA10_dly, DIA10_ipd, tisd_DIA10_CLKA);
      VitalSignalDelay(DIA11_dly, DIA11_ipd, tisd_DIA11_CLKA);
      VitalSignalDelay(DIA12_dly, DIA12_ipd, tisd_DIA12_CLKA);
      VitalSignalDelay(DIA13_dly, DIA13_ipd, tisd_DIA13_CLKA);
      VitalSignalDelay(DIA14_dly, DIA14_ipd, tisd_DIA14_CLKA);
      VitalSignalDelay(DIA15_dly, DIA15_ipd, tisd_DIA15_CLKA);
      VitalSignalDelay(DIA16_dly, DIA16_ipd, tisd_DIA16_CLKA);
      VitalSignalDelay(DIA17_dly, DIA17_ipd, tisd_DIA17_CLKA);
      VitalSignalDelay(ADA0_dly, ADA0_ipd, tisd_ADA0_CLKA);
      VitalSignalDelay(ADA1_dly, ADA1_ipd, tisd_ADA1_CLKA);
      VitalSignalDelay(ADA2_dly, ADA2_ipd, tisd_ADA2_CLKA);
      VitalSignalDelay(ADA3_dly, ADA3_ipd, tisd_ADA3_CLKA);
      VitalSignalDelay(ADA4_dly, ADA4_ipd, tisd_ADA4_CLKA);
      VitalSignalDelay(ADA5_dly, ADA5_ipd, tisd_ADA5_CLKA);
      VitalSignalDelay(ADA6_dly, ADA6_ipd, tisd_ADA6_CLKA);
      VitalSignalDelay(ADA7_dly, ADA7_ipd, tisd_ADA7_CLKA);
      VitalSignalDelay(ADA8_dly, ADA8_ipd, tisd_ADA8_CLKA);
      VitalSignalDelay(ADA9_dly, ADA9_ipd, tisd_ADA9_CLKA);
      VitalSignalDelay(ADA10_dly, ADA10_ipd, tisd_ADA10_CLKA);
      VitalSignalDelay(ADA11_dly, ADA11_ipd, tisd_ADA11_CLKA);
      VitalSignalDelay(ADA12_dly, ADA12_ipd, tisd_ADA12_CLKA);
      VitalSignalDelay(ADA13_dly, ADA13_ipd, tisd_ADA13_CLKA);
      VitalSignalDelay(CEA_dly, CEA_ipd, tisd_CEA_CLKA);
      VitalSignalDelay(WEA_dly, WEA_ipd, tisd_WEA_CLKA);
      VitalSignalDelay(CSA0_dly, CSA0_ipd, tisd_CSA0_CLKA);
      VitalSignalDelay(CSA1_dly, CSA1_ipd, tisd_CSA1_CLKA);
      VitalSignalDelay(CSA2_dly, CSA2_ipd, tisd_CSA2_CLKA);
      VitalSignalDelay(RSTA_dly, RSTA_ipd, tisd_RSTA_CLKA);
      VitalSignalDelay(DIB0_dly, DIB0_ipd, tisd_DIB0_CLKB);
      VitalSignalDelay(DIB1_dly, DIB1_ipd, tisd_DIB1_CLKB);
      VitalSignalDelay(DIB2_dly, DIB2_ipd, tisd_DIB2_CLKB);
      VitalSignalDelay(DIB3_dly, DIB3_ipd, tisd_DIB3_CLKB);
      VitalSignalDelay(DIB4_dly, DIB4_ipd, tisd_DIB4_CLKB);
      VitalSignalDelay(DIB5_dly, DIB5_ipd, tisd_DIB5_CLKB);
      VitalSignalDelay(DIB6_dly, DIB6_ipd, tisd_DIB6_CLKB);
      VitalSignalDelay(DIB7_dly, DIB7_ipd, tisd_DIB7_CLKB);
      VitalSignalDelay(DIB8_dly, DIB8_ipd, tisd_DIB8_CLKB);
      VitalSignalDelay(DIB9_dly, DIB9_ipd, tisd_DIB9_CLKB);
      VitalSignalDelay(DIB10_dly, DIB10_ipd, tisd_DIB10_CLKB);
      VitalSignalDelay(DIB11_dly, DIB11_ipd, tisd_DIB11_CLKB);
      VitalSignalDelay(DIB12_dly, DIB12_ipd, tisd_DIB12_CLKB);
      VitalSignalDelay(DIB13_dly, DIB13_ipd, tisd_DIB13_CLKB);
      VitalSignalDelay(DIB14_dly, DIB14_ipd, tisd_DIB14_CLKB);
      VitalSignalDelay(DIB15_dly, DIB15_ipd, tisd_DIB15_CLKB);
      VitalSignalDelay(DIB16_dly, DIB16_ipd, tisd_DIB16_CLKB);
      VitalSignalDelay(DIB17_dly, DIB17_ipd, tisd_DIB17_CLKB);
      VitalSignalDelay(ADB0_dly, ADB0_ipd, tisd_ADB0_CLKB);  
      VitalSignalDelay(ADB1_dly, ADB1_ipd, tisd_ADB1_CLKB); 
      VitalSignalDelay(ADB2_dly, ADB2_ipd, tisd_ADB2_CLKB); 
      VitalSignalDelay(ADB3_dly, ADB3_ipd, tisd_ADB3_CLKB); 
      VitalSignalDelay(ADB4_dly, ADB4_ipd, tisd_ADB4_CLKB); 
      VitalSignalDelay(ADB5_dly, ADB5_ipd, tisd_ADB5_CLKB);
      VitalSignalDelay(ADB6_dly, ADB6_ipd, tisd_ADB6_CLKB);
      VitalSignalDelay(ADB7_dly, ADB7_ipd, tisd_ADB7_CLKB);
      VitalSignalDelay(ADB8_dly, ADB8_ipd, tisd_ADB8_CLKB);
      VitalSignalDelay(ADB9_dly, ADB9_ipd, tisd_ADB9_CLKB);
      VitalSignalDelay(ADB10_dly, ADB10_ipd, tisd_ADB10_CLKB);
      VitalSignalDelay(ADB11_dly, ADB11_ipd, tisd_ADB11_CLKB);
      VitalSignalDelay(ADB12_dly, ADB12_ipd, tisd_ADB12_CLKB);
      VitalSignalDelay(ADB13_dly, ADB13_ipd, tisd_ADB13_CLKB);
      VitalSignalDelay(CEB_dly, CEB_ipd, tisd_CEB_CLKB);   
      VitalSignalDelay(WEB_dly, WEB_ipd, tisd_WEB_CLKB);
      VitalSignalDelay(CSB0_dly, CSB0_ipd, tisd_CSB0_CLKB);  
      VitalSignalDelay(CSB1_dly, CSB1_ipd, tisd_CSB1_CLKB);
      VitalSignalDelay(CSB2_dly, CSB2_ipd, tisd_CSB2_CLKB);
      VitalSignalDelay(RSTB_dly, RSTB_ipd, tisd_RSTB_CLKB);
      VitalSignalDelay(CLKA_dly, CLKA_ipd, ticd_CLKA);
      VitalSignalDelay(CLKB_dly, CLKB_ipd, ticd_CLKB);
    END BLOCK;

    dp16kb_INST : dp16kb
                 generic map (DATA_WIDTH_A => DATA_WIDTH_A,
                              DATA_WIDTH_B => DATA_WIDTH_B,
                              REGMODE_A => REGMODE_A,
                              REGMODE_B => REGMODE_B,
                              RESETMODE => RESETMODE,
                              CSDECODE_A => CSDECODE_A,
                              CSDECODE_B => CSDECODE_B,
                              WRITEMODE_A => WRITEMODE_A,
                              WRITEMODE_B => WRITEMODE_B,
                              GSR => GSR,
                              initval_00 => initval_00,
                              initval_01 => initval_01,
                              initval_02 => initval_02,
                              initval_03 => initval_03,
                              initval_04 => initval_04,
                              initval_05 => initval_05,
                              initval_06 => initval_06,
                              initval_07 => initval_07,
                              initval_08 => initval_08,
                              initval_09 => initval_09,
                              initval_0a => initval_0a,
                              initval_0b => initval_0b,
                              initval_0c => initval_0c,
                              initval_0d => initval_0d,
                              initval_0e => initval_0e,
                              initval_0f => initval_0f,
                              initval_10 => initval_10,
                              initval_11 => initval_11,
                              initval_12 => initval_12,
                              initval_13 => initval_13,
                              initval_14 => initval_14,
                              initval_15 => initval_15,
                              initval_16 => initval_16,
                              initval_17 => initval_17,
                              initval_18 => initval_18,
                              initval_19 => initval_19,
                              initval_1a => initval_1a,
                              initval_1b => initval_1b,
                              initval_1c => initval_1c,
                              initval_1d => initval_1d,
                              initval_1e => initval_1e,
                              initval_1f => initval_1f,
                              initval_20 => initval_20,
                              initval_21 => initval_21,
                              initval_22 => initval_22,
                              initval_23 => initval_23,
                              initval_24 => initval_24,
                              initval_25 => initval_25,
                              initval_26 => initval_26,
                              initval_27 => initval_27,
                              initval_28 => initval_28,
                              initval_29 => initval_29,
                              initval_2a => initval_2a,
                              initval_2b => initval_2b,
                              initval_2c => initval_2c,
                              initval_2d => initval_2d,
                              initval_2e => initval_2e,
                              initval_2f => initval_2f,
                              initval_30 => initval_30,
                              initval_31 => initval_31,
                              initval_32 => initval_32,
                              initval_33 => initval_33,
                              initval_34 => initval_34,
                              initval_35 => initval_35,
                              initval_36 => initval_36,
                              initval_37 => initval_37,
                              initval_38 => initval_38,
                              initval_39 => initval_39,
                              initval_3a => initval_3a,
                              initval_3b => initval_3b,
                              initval_3c => initval_3c,
                              initval_3d => initval_3d,
                              initval_3e => initval_3e,
                              initval_3f => initval_3f)

                 port map (DIA0 => DIA0_dly,    
                           DIA1 => DIA1_dly,   
                           DIA2 => DIA2_dly,   
                           DIA3 => DIA3_dly,   
                           DIA4 => DIA4_dly,   
                           DIA5 => DIA5_dly,   
                           DIA6 => DIA6_dly,   
                           DIA7 => DIA7_dly,   
                           DIA8 => DIA8_dly,   
                           DIA9 => DIA9_dly,   
                           DIA10 => DIA10_dly,   
                           DIA11 => DIA11_dly,   
                           DIA12 => DIA12_dly,   
                           DIA13 => DIA13_dly,   
                           DIA14 => DIA14_dly,   
                           DIA15 => DIA15_dly,   
                           DIA16 => DIA16_dly,   
                           DIA17 => DIA17_dly,   
                           ADA0 => ADA0_dly,   
                           ADA1 => ADA1_dly,   
                           ADA2 => ADA2_dly,
                           ADA3 => ADA3_dly,
                           ADA4 => ADA4_dly,
                           ADA5 => ADA5_dly,
                           ADA6 => ADA6_dly,
                           ADA7 => ADA7_dly,
                           ADA8 => ADA8_dly,
                           ADA9 => ADA9_dly,
                           ADA10 => ADA10_dly,
                           ADA11 => ADA11_dly,
                           ADA12 => ADA12_dly,
                           ADA13 => ADA13_dly,
                           CEA => CEA_dly,
                           WEA => WEA_dly,
                           CSA0 => CSA0_dly,
                           CSA1 => CSA1_dly,
                           CSA2 => CSA2_dly,
                           RSTA => RSTA_dly,
                           DIB0 => DIB0_dly,   
                           DIB1 => DIB1_dly,   
                           DIB2 => DIB2_dly,
                           DIB3 => DIB3_dly,
                           DIB4 => DIB4_dly,
                           DIB5 => DIB5_dly,
                           DIB6 => DIB6_dly,
                           DIB7 => DIB7_dly,
                           DIB8 => DIB8_dly,
                           DIB9 => DIB9_dly,
                           DIB10 => DIB10_dly,
                           DIB11 => DIB11_dly,
                           DIB12 => DIB12_dly,
                           DIB13 => DIB13_dly,
                           DIB14 => DIB14_dly,
                           DIB15 => DIB15_dly,
                           DIB16 => DIB16_dly,
                           DIB17 => DIB17_dly,
                           ADB0 => ADB0_dly,   
                           ADB1 => ADB1_dly,   
                           ADB2 => ADB2_dly,
                           ADB3 => ADB3_dly,
                           ADB4 => ADB4_dly,
                           ADB5 => ADB5_dly,
                           ADB6 => ADB6_dly,
                           ADB7 => ADB7_dly,
                           ADB8 => ADB8_dly,
                           ADB9 => ADB9_dly,
                           ADB10 => ADB10_dly,
                           ADB11 => ADB11_dly,
                           ADB12 => ADB12_dly,
                           ADB13 => ADB13_dly,
                           CEB => CEB_dly,
                           WEB => WEB_dly,
                           CSB0 => CSB0_dly,
                           CSB1 => CSB1_dly,
                           CSB2 => CSB2_dly,
                           RSTB => RSTB_dly,
                           DOA0 => DOA0_dly,
                           DOA1 => DOA1_dly,
                           DOA2 => DOA2_dly,
                           DOA3 => DOA3_dly,
                           DOA4 => DOA4_dly,
                           DOA5 => DOA5_dly,
                           DOA6 => DOA6_dly,
                           DOA7 => DOA7_dly,
                           DOA8 => DOA8_dly,
                           DOA9 => DOA9_dly,
                           DOA10 => DOA10_dly,
                           DOA11 => DOA11_dly,
                           DOA12 => DOA12_dly,
                           DOA13 => DOA13_dly,
                           DOA14 => DOA14_dly,
                           DOA15 => DOA15_dly,
                           DOA16 => DOA16_dly,
                           DOA17 => DOA17_dly,
                           DOB0 => DOB0_dly,
                           DOB1 => DOB1_dly,
                           DOB2 => DOB2_dly,
                           DOB3 => DOB3_dly,
                           DOB4 => DOB4_dly,
                           DOB5 => DOB5_dly,
                           DOB6 => DOB6_dly,
                           DOB7 => DOB7_dly,
                           DOB8 => DOB8_dly,
                           DOB9 => DOB9_dly,
                           DOB10 => DOB10_dly,
                           DOB11 => DOB11_dly,
                           DOB12 => DOB12_dly,
                           DOB13 => DOB13_dly,
                           DOB14 => DOB14_dly,
                           DOB15 => DOB15_dly,
                           DOB16 => DOB16_dly,
                           DOB17 => DOB17_dly);

    VitalBehavior : PROCESS (DIA0_dly, DIA1_dly, DIA2_dly, DIA3_dly, DIA4_dly, DIA5_dly, DIA6_dly, DIA7_dly, DIA8_dly,
    DIA9_dly, DIA10_dly, DIA11_dly, DIA12_dly, DIA13_dly, DIA14_dly, DIA15_dly, DIA16_dly, DIA17_dly, 
    ADA0_dly, ADA1_dly, ADA2_dly, ADA3_dly, ADA4_dly, ADA5_dly, ADA6_dly, ADA7_dly, ADA8_dly, ADA9_dly, ADA10_dly,
    ADA11_dly, ADA12_dly, ADA13_dly, CEA_dly, WEA_dly, CLKA_dly, CSA0_dly, CSA1_dly, CSA2_dly, RSTA_dly,
    DIB0_dly, DIB1_dly, DIB2_dly, DIB3_dly, DIB4_dly, DIB5_dly, DIB6_dly, DIB7_dly, DIB8_dly,
    DIB9_dly, DIB10_dly, DIB11_dly, DIB12_dly, DIB13_dly, DIB14_dly, DIB15_dly, DIB16_dly, DIB17_dly,
    ADB0_dly, ADB1_dly, ADB2_dly, ADB3_dly, ADB4_dly, ADB5_dly, ADB6_dly, ADB7_dly, ADB8_dly, ADB9_dly, ADB10_dly,
    ADB11_dly, ADB12_dly, ADB13_dly, CEB_dly, WEB_dly, CLKB_dly, CSB0_dly, CSB1_dly, CSB2_dly, RSTB_dly,
    DOA0_dly, DOA1_dly, DOA2_dly, DOA3_dly, DOA4_dly, DOA5_dly, DOA6_dly, DOA7_dly, DOA8_dly,
    DOA9_dly, DOA10_dly, DOA11_dly, DOA12_dly, DOA13_dly, DOA14_dly, DOA15_dly, DOA16_dly, DOA17_dly,
    DOB0_dly, DOB1_dly, DOB2_dly, DOB3_dly, DOB4_dly, DOB5_dly, DOB6_dly, DOB7_dly, DOB8_dly,
    DOB9_dly, DOB10_dly, DOB11_dly, DOB12_dly, DOB13_dly, DOB14_dly, DOB15_dly, DOB16_dly, DOB17_dly, CLKA_ipd, CLKB_ipd)

    VARIABLE DOA0_zd          : std_logic := 'X';
    VARIABLE DOA0_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA1_zd          : std_logic := 'X';
    VARIABLE DOA1_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA2_zd          : std_logic := 'X';
    VARIABLE DOA2_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA3_zd          : std_logic := 'X';
    VARIABLE DOA3_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA4_zd          : std_logic := 'X';
    VARIABLE DOA4_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA5_zd          : std_logic := 'X';
    VARIABLE DOA5_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA6_zd          : std_logic := 'X';
    VARIABLE DOA6_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA7_zd          : std_logic := 'X';
    VARIABLE DOA7_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA8_zd          : std_logic := 'X';
    VARIABLE DOA8_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA9_zd          : std_logic := 'X';
    VARIABLE DOA9_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA10_zd          : std_logic := 'X';
    VARIABLE DOA10_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA11_zd          : std_logic := 'X';
    VARIABLE DOA11_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA12_zd          : std_logic := 'X';
    VARIABLE DOA12_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA13_zd          : std_logic := 'X';
    VARIABLE DOA13_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA14_zd          : std_logic := 'X';
    VARIABLE DOA14_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA15_zd          : std_logic := 'X';
    VARIABLE DOA15_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA16_zd          : std_logic := 'X';
    VARIABLE DOA16_GlitchData  : VitalGlitchDataType;
    VARIABLE DOA17_zd          : std_logic := 'X';
    VARIABLE DOA17_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB0_zd          : std_logic := 'X';
    VARIABLE DOB0_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB1_zd          : std_logic := 'X';
    VARIABLE DOB1_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB2_zd          : std_logic := 'X';
    VARIABLE DOB2_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB3_zd          : std_logic := 'X';
    VARIABLE DOB3_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB4_zd          : std_logic := 'X';
    VARIABLE DOB4_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB5_zd          : std_logic := 'X';
    VARIABLE DOB5_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB6_zd          : std_logic := 'X';
    VARIABLE DOB6_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB7_zd          : std_logic := 'X';
    VARIABLE DOB7_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB8_zd          : std_logic := 'X';
    VARIABLE DOB8_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB9_zd          : std_logic := 'X';
    VARIABLE DOB9_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB10_zd          : std_logic := 'X';
    VARIABLE DOB10_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB11_zd          : std_logic := 'X';
    VARIABLE DOB11_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB12_zd          : std_logic := 'X';
    VARIABLE DOB12_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB13_zd          : std_logic := 'X';
    VARIABLE DOB13_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB14_zd          : std_logic := 'X';
    VARIABLE DOB14_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB15_zd          : std_logic := 'X';
    VARIABLE DOB15_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB16_zd          : std_logic := 'X';
    VARIABLE DOB16_GlitchData  : VitalGlitchDataType;
    VARIABLE DOB17_zd          : std_logic := 'X';
    VARIABLE DOB17_GlitchData  : VitalGlitchDataType;

    VARIABLE tviol_DIA0_CLKA        : x01 := '0';
    VARIABLE DIA0_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA1_CLKA        : x01 := '0';
    VARIABLE DIA1_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA2_CLKA        : x01 := '0';
    VARIABLE DIA2_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA3_CLKA        : x01 := '0';
    VARIABLE DIA3_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA4_CLKA        : x01 := '0';
    VARIABLE DIA4_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA5_CLKA        : x01 := '0';
    VARIABLE DIA5_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA6_CLKA        : x01 := '0';
    VARIABLE DIA6_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA7_CLKA        : x01 := '0';
    VARIABLE DIA7_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA8_CLKA        : x01 := '0';
    VARIABLE DIA8_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA9_CLKA        : x01 := '0';
    VARIABLE DIA9_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA10_CLKA        : x01 := '0';
    VARIABLE DIA10_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA11_CLKA        : x01 := '0';
    VARIABLE DIA11_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA12_CLKA        : x01 := '0';
    VARIABLE DIA12_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA13_CLKA        : x01 := '0';
    VARIABLE DIA13_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA14_CLKA        : x01 := '0';
    VARIABLE DIA14_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA15_CLKA        : x01 := '0';
    VARIABLE DIA15_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA16_CLKA        : x01 := '0';
    VARIABLE DIA16_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIA17_CLKA        : x01 := '0';
    VARIABLE DIA17_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA0_CLKA        : x01 := '0';
    VARIABLE ADA0_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA1_CLKA        : x01 := '0';
    VARIABLE ADA1_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA2_CLKA        : x01 := '0';
    VARIABLE ADA2_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA3_CLKA        : x01 := '0';
    VARIABLE ADA3_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA4_CLKA        : x01 := '0';
    VARIABLE ADA4_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA5_CLKA        : x01 := '0';
    VARIABLE ADA5_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA6_CLKA        : x01 := '0';
    VARIABLE ADA6_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA7_CLKA        : x01 := '0';
    VARIABLE ADA7_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA8_CLKA        : x01 := '0';
    VARIABLE ADA8_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA9_CLKA        : x01 := '0';
    VARIABLE ADA9_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA10_CLKA        : x01 := '0';
    VARIABLE ADA10_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA11_CLKA        : x01 := '0';
    VARIABLE ADA11_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA12_CLKA        : x01 := '0';
    VARIABLE ADA12_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADA13_CLKA        : x01 := '0';
    VARIABLE ADA13_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CEA_CLKA        : x01 := '0';
    VARIABLE CEA_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_WEA_CLKA        : x01 := '0';
    VARIABLE WEA_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSA0_CLKA        : x01 := '0';
    VARIABLE CSA0_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSA1_CLKA        : x01 := '0';
    VARIABLE CSA1_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSA2_CLKA        : x01 := '0';
    VARIABLE CSA2_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_RSTA_CLKA        : x01 := '0';
    VARIABLE RSTA_CLKA_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CLKA             : x01 := '0';
    VARIABLE periodcheckinfo_CLKA       : VitalPeriodDataType;
    VARIABLE tviol_RSTA             : x01 := '0';
    VARIABLE periodcheckinfo_RSTA       : VitalPeriodDataType;
    VARIABLE tviol_RSTB             : x01 := '0';
    VARIABLE periodcheckinfo_RSTB       : VitalPeriodDataType;

    VARIABLE tviol_DIB0_CLKB        : x01 := '0';
    VARIABLE DIB0_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB1_CLKB        : x01 := '0';
    VARIABLE DIB1_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB2_CLKB        : x01 := '0';
    VARIABLE DIB2_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB3_CLKB        : x01 := '0';
    VARIABLE DIB3_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB4_CLKB        : x01 := '0';
    VARIABLE DIB4_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB5_CLKB        : x01 := '0';
    VARIABLE DIB5_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB6_CLKB        : x01 := '0';
    VARIABLE DIB6_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB7_CLKB        : x01 := '0';
    VARIABLE DIB7_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB8_CLKB        : x01 := '0';
    VARIABLE DIB8_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB9_CLKB        : x01 := '0';
    VARIABLE DIB9_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB10_CLKB        : x01 := '0';
    VARIABLE DIB10_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB11_CLKB        : x01 := '0';
    VARIABLE DIB11_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB12_CLKB        : x01 := '0';
    VARIABLE DIB12_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB13_CLKB        : x01 := '0';
    VARIABLE DIB13_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB14_CLKB        : x01 := '0';
    VARIABLE DIB14_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB15_CLKB        : x01 := '0';
    VARIABLE DIB15_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB16_CLKB        : x01 := '0';
    VARIABLE DIB16_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DIB17_CLKB        : x01 := '0';
    VARIABLE DIB17_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB0_CLKB        : x01 := '0';
    VARIABLE ADB0_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB1_CLKB        : x01 := '0';
    VARIABLE ADB1_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB2_CLKB        : x01 := '0';
    VARIABLE ADB2_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB3_CLKB        : x01 := '0';
    VARIABLE ADB3_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB4_CLKB        : x01 := '0';
    VARIABLE ADB4_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB5_CLKB        : x01 := '0';
    VARIABLE ADB5_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB6_CLKB        : x01 := '0';
    VARIABLE ADB6_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB7_CLKB        : x01 := '0';
    VARIABLE ADB7_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB8_CLKB        : x01 := '0';
    VARIABLE ADB8_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB9_CLKB        : x01 := '0';
    VARIABLE ADB9_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB10_CLKB        : x01 := '0';
    VARIABLE ADB10_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB11_CLKB        : x01 := '0';
    VARIABLE ADB11_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB12_CLKB        : x01 := '0';
    VARIABLE ADB12_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_ADB13_CLKB        : x01 := '0';
    VARIABLE ADB13_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CEB_CLKB        : x01 := '0';
    VARIABLE CEB_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_WEB_CLKB        : x01 := '0';
    VARIABLE WEB_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSB0_CLKB        : x01 := '0';
    VARIABLE CSB0_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSB1_CLKB        : x01 := '0';
    VARIABLE CSB1_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSB2_CLKB        : x01 := '0';
    VARIABLE CSB2_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_RSTB_CLKB        : x01 := '0';
    VARIABLE RSTB_CLKB_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CLKB             : x01 := '0';
    VARIABLE periodcheckinfo_CLKB       : VitalPeriodDataType;

  BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => DIA0_dly,
        TestSignalName => "DIA0",
        TestDelay => tisd_DIA0_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA0_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA0_CLKA_noedge_posedge,
        HoldHigh => thold_DIA0_CLKA_noedge_posedge,
        HoldLow => thold_DIA0_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA0_CLKA_TimingDatash,
        Violation => tviol_DIA0_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA0_dly,
        TestSignalName => "DIA0",
        TestDelay => tisd_DIA0_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA0_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA0_CLKA_noedge_negedge,
        HoldHigh => thold_DIA0_CLKA_noedge_negedge,
        HoldLow => thold_DIA0_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA0_CLKA_TimingDatash,
        Violation => tviol_DIA0_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA1_dly,
        TestSignalName => "DIA1",
        TestDelay => tisd_DIA1_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA1_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA1_CLKA_noedge_posedge,
        HoldHigh => thold_DIA1_CLKA_noedge_posedge,
        HoldLow => thold_DIA1_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA1_CLKA_TimingDatash,
        Violation => tviol_DIA1_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA1_dly,
        TestSignalName => "DIA1",
        TestDelay => tisd_DIA1_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA1_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA1_CLKA_noedge_negedge,
        HoldHigh => thold_DIA1_CLKA_noedge_negedge,
        HoldLow => thold_DIA1_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA1_CLKA_TimingDatash,
        Violation => tviol_DIA1_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA2_dly,
        TestSignalName => "DIA2",
        TestDelay => tisd_DIA2_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA2_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA2_CLKA_noedge_posedge,
        HoldHigh => thold_DIA2_CLKA_noedge_posedge,
        HoldLow => thold_DIA2_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA2_CLKA_TimingDatash,
        Violation => tviol_DIA2_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA2_dly,
        TestSignalName => "DIA2",
        TestDelay => tisd_DIA2_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA2_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA2_CLKA_noedge_negedge,
        HoldHigh => thold_DIA2_CLKA_noedge_negedge,
        HoldLow => thold_DIA2_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA2_CLKA_TimingDatash,
        Violation => tviol_DIA2_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA3_dly,
        TestSignalName => "DIA3",
        TestDelay => tisd_DIA3_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA3_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA3_CLKA_noedge_posedge,
        HoldHigh => thold_DIA3_CLKA_noedge_posedge,
        HoldLow => thold_DIA3_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA3_CLKA_TimingDatash,
        Violation => tviol_DIA3_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA3_dly,
        TestSignalName => "DIA3",
        TestDelay => tisd_DIA3_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA3_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA3_CLKA_noedge_negedge,
        HoldHigh => thold_DIA3_CLKA_noedge_negedge,
        HoldLow => thold_DIA3_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA3),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA3_CLKA_TimingDatash,
        Violation => tviol_DIA3_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA4_dly,
        TestSignalName => "DIA4",
        TestDelay => tisd_DIA4_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA4_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA4_CLKA_noedge_posedge,
        HoldHigh => thold_DIA4_CLKA_noedge_posedge,
        HoldLow => thold_DIA4_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA4),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA4_CLKA_TimingDatash,
        Violation => tviol_DIA4_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA4_dly,
        TestSignalName => "DIA4",
        TestDelay => tisd_DIA4_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA4_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA4_CLKA_noedge_negedge,
        HoldHigh => thold_DIA4_CLKA_noedge_negedge,
        HoldLow => thold_DIA4_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA4),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA4_CLKA_TimingDatash,
        Violation => tviol_DIA4_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA5_dly,
        TestSignalName => "DIA5",
        TestDelay => tisd_DIA5_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA5_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA5_CLKA_noedge_posedge,
        HoldHigh => thold_DIA5_CLKA_noedge_posedge,
        HoldLow => thold_DIA5_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA5),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA5_CLKA_TimingDatash,
        Violation => tviol_DIA5_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA5_dly,
        TestSignalName => "DIA5",
        TestDelay => tisd_DIA5_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA5_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA5_CLKA_noedge_negedge,
        HoldHigh => thold_DIA5_CLKA_noedge_negedge,
        HoldLow => thold_DIA5_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA5),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA5_CLKA_TimingDatash,
        Violation => tviol_DIA5_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA6_dly,
        TestSignalName => "DIA6",
        TestDelay => tisd_DIA6_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA6_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA6_CLKA_noedge_posedge,
        HoldHigh => thold_DIA6_CLKA_noedge_posedge,
        HoldLow => thold_DIA6_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA6),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA6_CLKA_TimingDatash,
        Violation => tviol_DIA6_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA6_dly,
        TestSignalName => "DIA6",
        TestDelay => tisd_DIA6_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA6_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA6_CLKA_noedge_negedge,
        HoldHigh => thold_DIA6_CLKA_noedge_negedge,
        HoldLow => thold_DIA6_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA6),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA6_CLKA_TimingDatash,
        Violation => tviol_DIA6_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA7_dly,
        TestSignalName => "DIA7",
        TestDelay => tisd_DIA7_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA7_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA7_CLKA_noedge_posedge,
        HoldHigh => thold_DIA7_CLKA_noedge_posedge,
        HoldLow => thold_DIA7_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA7),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA7_CLKA_TimingDatash,
        Violation => tviol_DIA7_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA7_dly,
        TestSignalName => "DIA7",
        TestDelay => tisd_DIA7_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA7_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA7_CLKA_noedge_negedge,
        HoldHigh => thold_DIA7_CLKA_noedge_negedge,
        HoldLow => thold_DIA7_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA7),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA7_CLKA_TimingDatash,
        Violation => tviol_DIA7_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA8_dly,
        TestSignalName => "DIA8",
        TestDelay => tisd_DIA8_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA8_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA8_CLKA_noedge_posedge,
        HoldHigh => thold_DIA8_CLKA_noedge_posedge,
        HoldLow => thold_DIA8_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA8),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA8_CLKA_TimingDatash,
        Violation => tviol_DIA8_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA8_dly,
        TestSignalName => "DIA8",
        TestDelay => tisd_DIA8_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA8_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA8_CLKA_noedge_negedge,
        HoldHigh => thold_DIA8_CLKA_noedge_negedge,
        HoldLow => thold_DIA8_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA8),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA8_CLKA_TimingDatash,
        Violation => tviol_DIA8_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA9_dly,
        TestSignalName => "DIA9",
        TestDelay => tisd_DIA9_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA9_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA9_CLKA_noedge_posedge,
        HoldHigh => thold_DIA9_CLKA_noedge_posedge,
        HoldLow => thold_DIA9_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA9),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA9_CLKA_TimingDatash,
        Violation => tviol_DIA9_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA9_dly,
        TestSignalName => "DIA9",
        TestDelay => tisd_DIA9_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA9_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA9_CLKA_noedge_negedge,
        HoldHigh => thold_DIA9_CLKA_noedge_negedge,
        HoldLow => thold_DIA9_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA9),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA9_CLKA_TimingDatash,
        Violation => tviol_DIA9_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA10_dly,
        TestSignalName => "DIA10",
        TestDelay => tisd_DIA10_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA10_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA10_CLKA_noedge_posedge,
        HoldHigh => thold_DIA10_CLKA_noedge_posedge,
        HoldLow => thold_DIA10_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA10),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA10_CLKA_TimingDatash,
        Violation => tviol_DIA10_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA10_dly,
        TestSignalName => "DIA10",
        TestDelay => tisd_DIA10_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA10_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA10_CLKA_noedge_negedge,
        HoldHigh => thold_DIA10_CLKA_noedge_negedge,
        HoldLow => thold_DIA10_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA10),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA10_CLKA_TimingDatash,
        Violation => tviol_DIA10_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA11_dly,
        TestSignalName => "DIA11",
        TestDelay => tisd_DIA11_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA11_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA11_CLKA_noedge_posedge,
        HoldHigh => thold_DIA11_CLKA_noedge_posedge,
        HoldLow => thold_DIA11_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA11),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA11_CLKA_TimingDatash,
        Violation => tviol_DIA11_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA11_dly,
        TestSignalName => "DIA11",
        TestDelay => tisd_DIA11_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA11_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA11_CLKA_noedge_negedge,
        HoldHigh => thold_DIA11_CLKA_noedge_negedge,
        HoldLow => thold_DIA11_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA11),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA11_CLKA_TimingDatash,
        Violation => tviol_DIA11_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA12_dly,
        TestSignalName => "DIA12",
        TestDelay => tisd_DIA12_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA12_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA12_CLKA_noedge_posedge,
        HoldHigh => thold_DIA12_CLKA_noedge_posedge,
        HoldLow => thold_DIA12_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA12),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA12_CLKA_TimingDatash,
        Violation => tviol_DIA12_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA12_dly,
        TestSignalName => "DIA12",
        TestDelay => tisd_DIA12_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA12_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA12_CLKA_noedge_negedge,
        HoldHigh => thold_DIA12_CLKA_noedge_negedge,
        HoldLow => thold_DIA12_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA12),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA12_CLKA_TimingDatash,
        Violation => tviol_DIA12_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA13_dly,
        TestSignalName => "DIA13",
        TestDelay => tisd_DIA13_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA13_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA13_CLKA_noedge_posedge,
        HoldHigh => thold_DIA13_CLKA_noedge_posedge,
        HoldLow => thold_DIA13_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA13),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA13_CLKA_TimingDatash,
        Violation => tviol_DIA13_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA13_dly,
        TestSignalName => "DIA13",
        TestDelay => tisd_DIA13_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA13_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA13_CLKA_noedge_negedge,
        HoldHigh => thold_DIA13_CLKA_noedge_negedge,
        HoldLow => thold_DIA13_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA13),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA13_CLKA_TimingDatash,
        Violation => tviol_DIA13_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA14_dly,
        TestSignalName => "DIA14",
        TestDelay => tisd_DIA14_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA14_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA14_CLKA_noedge_posedge,
        HoldHigh => thold_DIA14_CLKA_noedge_posedge,
        HoldLow => thold_DIA14_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA14),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA14_CLKA_TimingDatash,
        Violation => tviol_DIA14_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA14_dly,
        TestSignalName => "DIA14",
        TestDelay => tisd_DIA14_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA14_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA14_CLKA_noedge_negedge,
        HoldHigh => thold_DIA14_CLKA_noedge_negedge,
        HoldLow => thold_DIA14_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA14),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA14_CLKA_TimingDatash,
        Violation => tviol_DIA14_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA15_dly,
        TestSignalName => "DIA15",
        TestDelay => tisd_DIA15_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA15_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA15_CLKA_noedge_posedge,
        HoldHigh => thold_DIA15_CLKA_noedge_posedge,
        HoldLow => thold_DIA15_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA15),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA15_CLKA_TimingDatash,
        Violation => tviol_DIA15_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA15_dly,
        TestSignalName => "DIA15",
        TestDelay => tisd_DIA15_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA15_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA15_CLKA_noedge_negedge,
        HoldHigh => thold_DIA15_CLKA_noedge_negedge,
        HoldLow => thold_DIA15_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA15),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA15_CLKA_TimingDatash,
        Violation => tviol_DIA15_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA16_dly,
        TestSignalName => "DIA16",
        TestDelay => tisd_DIA16_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA16_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA16_CLKA_noedge_posedge,
        HoldHigh => thold_DIA16_CLKA_noedge_posedge,
        HoldLow => thold_DIA16_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA16),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA16_CLKA_TimingDatash,
        Violation => tviol_DIA16_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA16_dly,
        TestSignalName => "DIA16",
        TestDelay => tisd_DIA16_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA16_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA16_CLKA_noedge_negedge,
        HoldHigh => thold_DIA16_CLKA_noedge_negedge,
        HoldLow => thold_DIA16_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA16),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA16_CLKA_TimingDatash,
        Violation => tviol_DIA16_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIA17_dly,
        TestSignalName => "DIA17",
        TestDelay => tisd_DIA17_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA17_CLKA_noedge_posedge,
        SetupLow => tsetup_DIA17_CLKA_noedge_posedge,
        HoldHigh => thold_DIA17_CLKA_noedge_posedge,
        HoldLow => thold_DIA17_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_DIA17),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA17_CLKA_TimingDatash,
        Violation => tviol_DIA17_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIA17_dly,
        TestSignalName => "DIA17",
        TestDelay => tisd_DIA17_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_DIA17_CLKA_noedge_negedge,
        SetupLow => tsetup_DIA17_CLKA_noedge_negedge,
        HoldHigh => thold_DIA17_CLKA_noedge_negedge,
        HoldLow => thold_DIA17_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_DIA17),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIA17_CLKA_TimingDatash,
        Violation => tviol_DIA17_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA0_dly,
        TestSignalName => "ADA0",
        TestDelay => tisd_ADA0_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA0_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA0_CLKA_noedge_posedge,
        HoldHigh => thold_ADA0_CLKA_noedge_posedge,
        HoldLow => thold_ADA0_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA0_CLKA_TimingDatash,
        Violation => tviol_ADA0_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA0_dly,
        TestSignalName => "ADA0",
        TestDelay => tisd_ADA0_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA0_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA0_CLKA_noedge_negedge,
        HoldHigh => thold_ADA0_CLKA_noedge_negedge,
        HoldLow => thold_ADA0_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA0_CLKA_TimingDatash,
        Violation => tviol_ADA0_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA1_dly,
        TestSignalName => "ADA1",
        TestDelay => tisd_ADA1_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA1_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA1_CLKA_noedge_posedge,
        HoldHigh => thold_ADA1_CLKA_noedge_posedge,
        HoldLow => thold_ADA1_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA1_CLKA_TimingDatash,
        Violation => tviol_ADA1_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA1_dly,
        TestSignalName => "ADA1",
        TestDelay => tisd_ADA1_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA1_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA1_CLKA_noedge_negedge,
        HoldHigh => thold_ADA1_CLKA_noedge_negedge,
        HoldLow => thold_ADA1_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA1_CLKA_TimingDatash,
        Violation => tviol_ADA1_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA2_dly,
        TestSignalName => "ADA2",
        TestDelay => tisd_ADA2_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA2_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA2_CLKA_noedge_posedge,
        HoldHigh => thold_ADA2_CLKA_noedge_posedge,
        HoldLow => thold_ADA2_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA2_CLKA_TimingDatash,
        Violation => tviol_ADA2_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA2_dly,
        TestSignalName => "ADA2",
        TestDelay => tisd_ADA2_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA2_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA2_CLKA_noedge_negedge,
        HoldHigh => thold_ADA2_CLKA_noedge_negedge,
        HoldLow => thold_ADA2_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA2_CLKA_TimingDatash,
        Violation => tviol_ADA2_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA3_dly,
        TestSignalName => "ADA3",
        TestDelay => tisd_ADA3_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA3_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA3_CLKA_noedge_posedge,
        HoldHigh => thold_ADA3_CLKA_noedge_posedge,
        HoldLow => thold_ADA3_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA3_CLKA_TimingDatash,
        Violation => tviol_ADA3_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA3_dly,
        TestSignalName => "ADA3",
        TestDelay => tisd_ADA3_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA3_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA3_CLKA_noedge_negedge,
        HoldHigh => thold_ADA3_CLKA_noedge_negedge,
        HoldLow => thold_ADA3_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA3),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA3_CLKA_TimingDatash,
        Violation => tviol_ADA3_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA4_dly,
        TestSignalName => "ADA4",
        TestDelay => tisd_ADA4_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA4_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA4_CLKA_noedge_posedge,
        HoldHigh => thold_ADA4_CLKA_noedge_posedge,
        HoldLow => thold_ADA4_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA4),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA4_CLKA_TimingDatash,
        Violation => tviol_ADA4_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA4_dly,
        TestSignalName => "ADA4",
        TestDelay => tisd_ADA4_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA4_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA4_CLKA_noedge_negedge,
        HoldHigh => thold_ADA4_CLKA_noedge_negedge,
        HoldLow => thold_ADA4_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA4),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA4_CLKA_TimingDatash,
        Violation => tviol_ADA4_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA5_dly,
        TestSignalName => "ADA5",
        TestDelay => tisd_ADA5_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA5_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA5_CLKA_noedge_posedge,
        HoldHigh => thold_ADA5_CLKA_noedge_posedge,
        HoldLow => thold_ADA5_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA5),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA5_CLKA_TimingDatash,
        Violation => tviol_ADA5_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA5_dly,
        TestSignalName => "ADA5",
        TestDelay => tisd_ADA5_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA5_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA5_CLKA_noedge_negedge,
        HoldHigh => thold_ADA5_CLKA_noedge_negedge,
        HoldLow => thold_ADA5_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA5),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA5_CLKA_TimingDatash,
        Violation => tviol_ADA5_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA6_dly,
        TestSignalName => "ADA6",
        TestDelay => tisd_ADA6_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA6_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA6_CLKA_noedge_posedge,
        HoldHigh => thold_ADA6_CLKA_noedge_posedge,
        HoldLow => thold_ADA6_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA6),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA6_CLKA_TimingDatash,
        Violation => tviol_ADA6_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA6_dly,
        TestSignalName => "ADA6",
        TestDelay => tisd_ADA6_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA6_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA6_CLKA_noedge_negedge,
        HoldHigh => thold_ADA6_CLKA_noedge_negedge,
        HoldLow => thold_ADA6_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA6),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA6_CLKA_TimingDatash,
        Violation => tviol_ADA6_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA7_dly,
        TestSignalName => "ADA7",
        TestDelay => tisd_ADA7_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA7_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA7_CLKA_noedge_posedge,
        HoldHigh => thold_ADA7_CLKA_noedge_posedge,
        HoldLow => thold_ADA7_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA7),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA7_CLKA_TimingDatash,
        Violation => tviol_ADA7_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA7_dly,
        TestSignalName => "ADA7",
        TestDelay => tisd_ADA7_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA7_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA7_CLKA_noedge_negedge,
        HoldHigh => thold_ADA7_CLKA_noedge_negedge,
        HoldLow => thold_ADA7_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA7),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA7_CLKA_TimingDatash,
        Violation => tviol_ADA7_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA8_dly,
        TestSignalName => "ADA8",
        TestDelay => tisd_ADA8_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA8_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA8_CLKA_noedge_posedge,
        HoldHigh => thold_ADA8_CLKA_noedge_posedge,
        HoldLow => thold_ADA8_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA8),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA8_CLKA_TimingDatash,
        Violation => tviol_ADA8_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA8_dly,
        TestSignalName => "ADA8",
        TestDelay => tisd_ADA8_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA8_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA8_CLKA_noedge_negedge,
        HoldHigh => thold_ADA8_CLKA_noedge_negedge,
        HoldLow => thold_ADA8_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA8),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA8_CLKA_TimingDatash,
        Violation => tviol_ADA8_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA9_dly,
        TestSignalName => "ADA9",
        TestDelay => tisd_ADA9_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA9_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA9_CLKA_noedge_posedge,
        HoldHigh => thold_ADA9_CLKA_noedge_posedge,
        HoldLow => thold_ADA9_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA9),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA9_CLKA_TimingDatash,
        Violation => tviol_ADA9_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA9_dly,
        TestSignalName => "ADA9",
        TestDelay => tisd_ADA9_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA9_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA9_CLKA_noedge_negedge,
        HoldHigh => thold_ADA9_CLKA_noedge_negedge,
        HoldLow => thold_ADA9_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA9),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA9_CLKA_TimingDatash,
        Violation => tviol_ADA9_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA10_dly,
        TestSignalName => "ADA10",
        TestDelay => tisd_ADA10_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA10_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA10_CLKA_noedge_posedge,
        HoldHigh => thold_ADA10_CLKA_noedge_posedge,
        HoldLow => thold_ADA10_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA10),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA10_CLKA_TimingDatash,
        Violation => tviol_ADA10_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA10_dly,
        TestSignalName => "ADA10",
        TestDelay => tisd_ADA10_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA10_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA10_CLKA_noedge_negedge,
        HoldHigh => thold_ADA10_CLKA_noedge_negedge,
        HoldLow => thold_ADA10_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA10),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA10_CLKA_TimingDatash,
        Violation => tviol_ADA10_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA11_dly,
        TestSignalName => "ADA11",
        TestDelay => tisd_ADA11_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA11_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA11_CLKA_noedge_posedge,
        HoldHigh => thold_ADA11_CLKA_noedge_posedge,
        HoldLow => thold_ADA11_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA11),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA11_CLKA_TimingDatash,
        Violation => tviol_ADA11_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA11_dly,
        TestSignalName => "ADA11",
        TestDelay => tisd_ADA11_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA11_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA11_CLKA_noedge_negedge,
        HoldHigh => thold_ADA11_CLKA_noedge_negedge,
        HoldLow => thold_ADA11_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA11),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA11_CLKA_TimingDatash,
        Violation => tviol_ADA11_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA12_dly,
        TestSignalName => "ADA12",
        TestDelay => tisd_ADA12_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA12_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA12_CLKA_noedge_posedge,
        HoldHigh => thold_ADA12_CLKA_noedge_posedge,
        HoldLow => thold_ADA12_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA12),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA12_CLKA_TimingDatash,
        Violation => tviol_ADA12_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA12_dly,
        TestSignalName => "ADA12",
        TestDelay => tisd_ADA12_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA12_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA12_CLKA_noedge_negedge,
        HoldHigh => thold_ADA12_CLKA_noedge_negedge,
        HoldLow => thold_ADA12_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA12),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA12_CLKA_TimingDatash,
        Violation => tviol_ADA12_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADA13_dly,
        TestSignalName => "ADA13",
        TestDelay => tisd_ADA13_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA13_CLKA_noedge_posedge,
        SetupLow => tsetup_ADA13_CLKA_noedge_posedge,
        HoldHigh => thold_ADA13_CLKA_noedge_posedge,
        HoldLow => thold_ADA13_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_ADA13),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA13_CLKA_TimingDatash,
        Violation => tviol_ADA13_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADA13_dly,
        TestSignalName => "ADA13",
        TestDelay => tisd_ADA13_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_ADA13_CLKA_noedge_negedge,
        SetupLow => tsetup_ADA13_CLKA_noedge_negedge,
        HoldHigh => thold_ADA13_CLKA_noedge_negedge,
        HoldLow => thold_ADA13_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_ADA13),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADA13_CLKA_TimingDatash,
        Violation => tviol_ADA13_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CEA_dly,
        TestSignalName => "CEA",
        TestDelay => tisd_CEA_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CEA_CLKA_noedge_posedge,
        SetupLow => tsetup_CEA_CLKA_noedge_posedge,
        HoldHigh => thold_CEA_CLKA_noedge_posedge,
        HoldLow => thold_CEA_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_CEA),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CEA_CLKA_TimingDatash,
        Violation => tviol_CEA_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CEA_dly,
        TestSignalName => "CEA",
        TestDelay => tisd_CEA_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CEA_CLKA_noedge_negedge,
        SetupLow => tsetup_CEA_CLKA_noedge_negedge,
        HoldHigh => thold_CEA_CLKA_noedge_negedge,
        HoldLow => thold_CEA_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_CEA),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CEA_CLKA_TimingDatash,
        Violation => tviol_CEA_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WEA_dly,
        TestSignalName => "WEA",
        TestDelay => tisd_WEA_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_WEA_CLKA_noedge_posedge,
        SetupLow => tsetup_WEA_CLKA_noedge_posedge,
        HoldHigh => thold_WEA_CLKA_noedge_posedge,
        HoldLow => thold_WEA_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_WEA),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WEA_CLKA_TimingDatash,
        Violation => tviol_WEA_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => WEA_dly,
        TestSignalName => "WEA",
        TestDelay => tisd_WEA_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_WEA_CLKA_noedge_negedge,
        SetupLow => tsetup_WEA_CLKA_noedge_negedge,
        HoldHigh => thold_WEA_CLKA_noedge_negedge,
        HoldLow => thold_WEA_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_WEA),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WEA_CLKA_TimingDatash,
        Violation => tviol_WEA_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSA0_dly,
        TestSignalName => "CSA0",
        TestDelay => tisd_CSA0_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CSA0_CLKA_noedge_posedge,
        SetupLow => tsetup_CSA0_CLKA_noedge_posedge,
        HoldHigh => thold_CSA0_CLKA_noedge_posedge,
        HoldLow => thold_CSA0_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_CSA0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSA0_CLKA_TimingDatash,
        Violation => tviol_CSA0_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSA0_dly,
        TestSignalName => "CSA0",
        TestDelay => tisd_CSA0_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CSA0_CLKA_noedge_negedge,
        SetupLow => tsetup_CSA0_CLKA_noedge_negedge,
        HoldHigh => thold_CSA0_CLKA_noedge_negedge,
        HoldLow => thold_CSA0_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_CSA0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSA0_CLKA_TimingDatash,
        Violation => tviol_CSA0_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSA1_dly,
        TestSignalName => "CSA1",
        TestDelay => tisd_CSA1_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CSA1_CLKA_noedge_posedge,
        SetupLow => tsetup_CSA1_CLKA_noedge_posedge,
        HoldHigh => thold_CSA1_CLKA_noedge_posedge,
        HoldLow => thold_CSA1_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_CSA1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSA1_CLKA_TimingDatash,
        Violation => tviol_CSA1_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSA1_dly,
        TestSignalName => "CSA1",
        TestDelay => tisd_CSA1_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CSA1_CLKA_noedge_negedge,
        SetupLow => tsetup_CSA1_CLKA_noedge_negedge,
        HoldHigh => thold_CSA1_CLKA_noedge_negedge,
        HoldLow => thold_CSA1_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_CSA1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSA1_CLKA_TimingDatash,
        Violation => tviol_CSA1_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSA2_dly,
        TestSignalName => "CSA2",
        TestDelay => tisd_CSA2_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CSA2_CLKA_noedge_posedge,
        SetupLow => tsetup_CSA2_CLKA_noedge_posedge,
        HoldHigh => thold_CSA2_CLKA_noedge_posedge,
        HoldLow => thold_CSA2_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_CSA2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSA2_CLKA_TimingDatash,
        Violation => tviol_CSA2_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSA2_dly,
        TestSignalName => "CSA2",
        TestDelay => tisd_CSA2_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_CSA2_CLKA_noedge_negedge,
        SetupLow => tsetup_CSA2_CLKA_noedge_negedge,
        HoldHigh => thold_CSA2_CLKA_noedge_negedge,
        HoldLow => thold_CSA2_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_CSA2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSA2_CLKA_TimingDatash,
        Violation => tviol_CSA2_CLKA,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RSTA_dly,
        TestSignalName => "RSTA",
        TestDelay => tisd_RSTA_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_RSTA_CLKA_noedge_posedge,
        SetupLow => tsetup_RSTA_CLKA_noedge_posedge,
        HoldHigh => thold_RSTA_CLKA_noedge_posedge,
        HoldLow => thold_RSTA_CLKA_noedge_posedge,
        CheckEnabled => ((CLKA_NEGEDGE = FALSE) and check_RSTA),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RSTA_CLKA_TimingDatash,
        Violation => tviol_RSTA_CLKA,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RSTA_dly,
        TestSignalName => "RSTA",
        TestDelay => tisd_RSTA_CLKA,
        RefSignal => CLKA_dly,
        RefSignalName => "CLKA",
        RefDelay => ticd_CLKA,
        SetupHigh => tsetup_RSTA_CLKA_noedge_negedge,
        SetupLow => tsetup_RSTA_CLKA_noedge_negedge,
        HoldHigh => thold_RSTA_CLKA_noedge_negedge,
        HoldLow => thold_RSTA_CLKA_noedge_negedge,
        CheckEnabled => (CLKA_NEGEDGE and check_RSTA),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RSTA_CLKA_TimingDatash,
        Violation => tviol_RSTA_CLKA,
        MsgSeverity => warning);

---
      VitalSetupHoldCheck (
        TestSignal => DIB0_dly,
        TestSignalName => "DIB0",
        TestDelay => tisd_DIB0_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB0_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB0_CLKB_noedge_posedge,
        HoldHigh => thold_DIB0_CLKB_noedge_posedge,
        HoldLow => thold_DIB0_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB0_CLKB_TimingDatash,
        Violation => tviol_DIB0_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB0_dly,
        TestSignalName => "DIB0",
        TestDelay => tisd_DIB0_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB0_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB0_CLKB_noedge_negedge,
        HoldHigh => thold_DIB0_CLKB_noedge_negedge,
        HoldLow => thold_DIB0_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB0_CLKB_TimingDatash,
        Violation => tviol_DIB0_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB1_dly,
        TestSignalName => "DIB1",
        TestDelay => tisd_DIB1_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB1_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB1_CLKB_noedge_posedge,
        HoldHigh => thold_DIB1_CLKB_noedge_posedge,
        HoldLow => thold_DIB1_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB1_CLKB_TimingDatash,
        Violation => tviol_DIB1_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB1_dly,
        TestSignalName => "DIB1",
        TestDelay => tisd_DIB1_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB1_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB1_CLKB_noedge_negedge,
        HoldHigh => thold_DIB1_CLKB_noedge_negedge,
        HoldLow => thold_DIB1_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB1_CLKB_TimingDatash,
        Violation => tviol_DIB1_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB2_dly,
        TestSignalName => "DIB2",
        TestDelay => tisd_DIB2_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB2_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB2_CLKB_noedge_posedge,
        HoldHigh => thold_DIB2_CLKB_noedge_posedge,
        HoldLow => thold_DIB2_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB2_CLKB_TimingDatash,
        Violation => tviol_DIB2_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB2_dly,
        TestSignalName => "DIB2",
        TestDelay => tisd_DIB2_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB2_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB2_CLKB_noedge_negedge,
        HoldHigh => thold_DIB2_CLKB_noedge_negedge,
        HoldLow => thold_DIB2_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB2_CLKB_TimingDatash,
        Violation => tviol_DIB2_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB3_dly,
        TestSignalName => "DIB3",
        TestDelay => tisd_DIB3_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB3_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB3_CLKB_noedge_posedge,
        HoldHigh => thold_DIB3_CLKB_noedge_posedge,
        HoldLow => thold_DIB3_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB3_CLKB_TimingDatash,
        Violation => tviol_DIB3_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB3_dly,
        TestSignalName => "DIB3",
        TestDelay => tisd_DIB3_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB3_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB3_CLKB_noedge_negedge,
        HoldHigh => thold_DIB3_CLKB_noedge_negedge,
        HoldLow => thold_DIB3_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB3),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB3_CLKB_TimingDatash,
        Violation => tviol_DIB3_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB4_dly,
        TestSignalName => "DIB4",
        TestDelay => tisd_DIB4_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB4_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB4_CLKB_noedge_posedge,
        HoldHigh => thold_DIB4_CLKB_noedge_posedge,
        HoldLow => thold_DIB4_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB4),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB4_CLKB_TimingDatash,
        Violation => tviol_DIB4_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB4_dly,
        TestSignalName => "DIB4",
        TestDelay => tisd_DIB4_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB4_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB4_CLKB_noedge_negedge,
        HoldHigh => thold_DIB4_CLKB_noedge_negedge,
        HoldLow => thold_DIB4_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB4),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB4_CLKB_TimingDatash,
        Violation => tviol_DIB4_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB5_dly,
        TestSignalName => "DIB5",
        TestDelay => tisd_DIB5_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB5_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB5_CLKB_noedge_posedge,
        HoldHigh => thold_DIB5_CLKB_noedge_posedge,
        HoldLow => thold_DIB5_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB5),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB5_CLKB_TimingDatash,
        Violation => tviol_DIB5_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB5_dly,
        TestSignalName => "DIB5",
        TestDelay => tisd_DIB5_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB5_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB5_CLKB_noedge_negedge,
        HoldHigh => thold_DIB5_CLKB_noedge_negedge,
        HoldLow => thold_DIB5_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB5),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB5_CLKB_TimingDatash,
        Violation => tviol_DIB5_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB6_dly,
        TestSignalName => "DIB6",
        TestDelay => tisd_DIB6_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB6_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB6_CLKB_noedge_posedge,
        HoldHigh => thold_DIB6_CLKB_noedge_posedge,
        HoldLow => thold_DIB6_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB6),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB6_CLKB_TimingDatash,
        Violation => tviol_DIB6_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB6_dly,
        TestSignalName => "DIB6",
        TestDelay => tisd_DIB6_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB6_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB6_CLKB_noedge_negedge,
        HoldHigh => thold_DIB6_CLKB_noedge_negedge,
        HoldLow => thold_DIB6_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB6),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB6_CLKB_TimingDatash,
        Violation => tviol_DIB6_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB7_dly,
        TestSignalName => "DIB7",
        TestDelay => tisd_DIB7_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB7_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB7_CLKB_noedge_posedge,
        HoldHigh => thold_DIB7_CLKB_noedge_posedge,
        HoldLow => thold_DIB7_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB7),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB7_CLKB_TimingDatash,
        Violation => tviol_DIB7_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB7_dly,
        TestSignalName => "DIB7",
        TestDelay => tisd_DIB7_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB7_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB7_CLKB_noedge_negedge,
        HoldHigh => thold_DIB7_CLKB_noedge_negedge,
        HoldLow => thold_DIB7_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB7),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB7_CLKB_TimingDatash,
        Violation => tviol_DIB7_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB8_dly,
        TestSignalName => "DIB8",
        TestDelay => tisd_DIB8_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB8_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB8_CLKB_noedge_posedge,
        HoldHigh => thold_DIB8_CLKB_noedge_posedge,
        HoldLow => thold_DIB8_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB8),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB8_CLKB_TimingDatash,
        Violation => tviol_DIB8_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB8_dly,
        TestSignalName => "DIB8",
        TestDelay => tisd_DIB8_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB8_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB8_CLKB_noedge_negedge,
        HoldHigh => thold_DIB8_CLKB_noedge_negedge,
        HoldLow => thold_DIB8_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB8),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB8_CLKB_TimingDatash,
        Violation => tviol_DIB8_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB9_dly,
        TestSignalName => "DIB9",
        TestDelay => tisd_DIB9_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB9_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB9_CLKB_noedge_posedge,
        HoldHigh => thold_DIB9_CLKB_noedge_posedge,
        HoldLow => thold_DIB9_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB9),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB9_CLKB_TimingDatash,
        Violation => tviol_DIB9_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB9_dly,
        TestSignalName => "DIB9",
        TestDelay => tisd_DIB9_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB9_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB9_CLKB_noedge_negedge,
        HoldHigh => thold_DIB9_CLKB_noedge_negedge,
        HoldLow => thold_DIB9_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB9),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB9_CLKB_TimingDatash,
        Violation => tviol_DIB9_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB10_dly,
        TestSignalName => "DIB10",
        TestDelay => tisd_DIB10_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB10_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB10_CLKB_noedge_posedge,
        HoldHigh => thold_DIB10_CLKB_noedge_posedge,
        HoldLow => thold_DIB10_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB10),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB10_CLKB_TimingDatash,
        Violation => tviol_DIB10_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB10_dly,
        TestSignalName => "DIB10",
        TestDelay => tisd_DIB10_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB10_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB10_CLKB_noedge_negedge,
        HoldHigh => thold_DIB10_CLKB_noedge_negedge,
        HoldLow => thold_DIB10_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB10),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB10_CLKB_TimingDatash,
        Violation => tviol_DIB10_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB11_dly,
        TestSignalName => "DIB11",
        TestDelay => tisd_DIB11_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB11_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB11_CLKB_noedge_posedge,
        HoldHigh => thold_DIB11_CLKB_noedge_posedge,
        HoldLow => thold_DIB11_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB11),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB11_CLKB_TimingDatash,
        Violation => tviol_DIB11_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB11_dly,
        TestSignalName => "DIB11",
        TestDelay => tisd_DIB11_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB11_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB11_CLKB_noedge_negedge,
        HoldHigh => thold_DIB11_CLKB_noedge_negedge,
        HoldLow => thold_DIB11_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB11),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB11_CLKB_TimingDatash,
        Violation => tviol_DIB11_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB12_dly,
        TestSignalName => "DIB12",
        TestDelay => tisd_DIB12_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB12_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB12_CLKB_noedge_posedge,
        HoldHigh => thold_DIB12_CLKB_noedge_posedge,
        HoldLow => thold_DIB12_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB12),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB12_CLKB_TimingDatash,
        Violation => tviol_DIB12_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB12_dly,
        TestSignalName => "DIB12",
        TestDelay => tisd_DIB12_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB12_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB12_CLKB_noedge_negedge,
        HoldHigh => thold_DIB12_CLKB_noedge_negedge,
        HoldLow => thold_DIB12_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB12),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB12_CLKB_TimingDatash,
        Violation => tviol_DIB12_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB13_dly,
        TestSignalName => "DIB13",
        TestDelay => tisd_DIB13_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB13_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB13_CLKB_noedge_posedge,
        HoldHigh => thold_DIB13_CLKB_noedge_posedge,
        HoldLow => thold_DIB13_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB13),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB13_CLKB_TimingDatash,
        Violation => tviol_DIB13_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB13_dly,
        TestSignalName => "DIB13",
        TestDelay => tisd_DIB13_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB13_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB13_CLKB_noedge_negedge,
        HoldHigh => thold_DIB13_CLKB_noedge_negedge,
        HoldLow => thold_DIB13_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB13),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB13_CLKB_TimingDatash,
        Violation => tviol_DIB13_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB14_dly,
        TestSignalName => "DIB14",
        TestDelay => tisd_DIB14_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB14_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB14_CLKB_noedge_posedge,
        HoldHigh => thold_DIB14_CLKB_noedge_posedge,
        HoldLow => thold_DIB14_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB14),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB14_CLKB_TimingDatash,
        Violation => tviol_DIB14_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB14_dly,
        TestSignalName => "DIB14",
        TestDelay => tisd_DIB14_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB14_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB14_CLKB_noedge_negedge,
        HoldHigh => thold_DIB14_CLKB_noedge_negedge,
        HoldLow => thold_DIB14_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB14),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB14_CLKB_TimingDatash,
        Violation => tviol_DIB14_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB15_dly,
        TestSignalName => "DIB15",
        TestDelay => tisd_DIB15_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB15_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB15_CLKB_noedge_posedge,
        HoldHigh => thold_DIB15_CLKB_noedge_posedge,
        HoldLow => thold_DIB15_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB15),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB15_CLKB_TimingDatash,
        Violation => tviol_DIB15_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB15_dly,
        TestSignalName => "DIB15",
        TestDelay => tisd_DIB15_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB15_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB15_CLKB_noedge_negedge,
        HoldHigh => thold_DIB15_CLKB_noedge_negedge,
        HoldLow => thold_DIB15_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB15),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB15_CLKB_TimingDatash,
        Violation => tviol_DIB15_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB16_dly,
        TestSignalName => "DIB16",
        TestDelay => tisd_DIB16_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB16_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB16_CLKB_noedge_posedge,
        HoldHigh => thold_DIB16_CLKB_noedge_posedge,
        HoldLow => thold_DIB16_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB16),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB16_CLKB_TimingDatash,
        Violation => tviol_DIB16_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB16_dly,
        TestSignalName => "DIB16",
        TestDelay => tisd_DIB16_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB16_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB16_CLKB_noedge_negedge,
        HoldHigh => thold_DIB16_CLKB_noedge_negedge,
        HoldLow => thold_DIB16_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB16),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB16_CLKB_TimingDatash,
        Violation => tviol_DIB16_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DIB17_dly,
        TestSignalName => "DIB17",
        TestDelay => tisd_DIB17_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB17_CLKB_noedge_posedge,
        SetupLow => tsetup_DIB17_CLKB_noedge_posedge,
        HoldHigh => thold_DIB17_CLKB_noedge_posedge,
        HoldLow => thold_DIB17_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_DIB17),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB17_CLKB_TimingDatash,
        Violation => tviol_DIB17_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DIB17_dly,
        TestSignalName => "DIB17",
        TestDelay => tisd_DIB17_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_DIB17_CLKB_noedge_negedge,
        SetupLow => tsetup_DIB17_CLKB_noedge_negedge,
        HoldHigh => thold_DIB17_CLKB_noedge_negedge,
        HoldLow => thold_DIB17_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_DIB17),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DIB17_CLKB_TimingDatash,
        Violation => tviol_DIB17_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB0_dly,
        TestSignalName => "ADB0",
        TestDelay => tisd_ADB0_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB0_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB0_CLKB_noedge_posedge,
        HoldHigh => thold_ADB0_CLKB_noedge_posedge,
        HoldLow => thold_ADB0_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB0_CLKB_TimingDatash,
        Violation => tviol_ADB0_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB0_dly,
        TestSignalName => "ADB0",
        TestDelay => tisd_ADB0_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB0_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB0_CLKB_noedge_negedge,
        HoldHigh => thold_ADB0_CLKB_noedge_negedge,
        HoldLow => thold_ADB0_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB0_CLKB_TimingDatash,
        Violation => tviol_ADB0_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB1_dly,
        TestSignalName => "ADB1",
        TestDelay => tisd_ADB1_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB1_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB1_CLKB_noedge_posedge,
        HoldHigh => thold_ADB1_CLKB_noedge_posedge,
        HoldLow => thold_ADB1_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB1_CLKB_TimingDatash,
        Violation => tviol_ADB1_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB1_dly,
        TestSignalName => "ADB1",
        TestDelay => tisd_ADB1_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB1_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB1_CLKB_noedge_negedge,
        HoldHigh => thold_ADB1_CLKB_noedge_negedge,
        HoldLow => thold_ADB1_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB1_CLKB_TimingDatash,
        Violation => tviol_ADB1_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB2_dly,
        TestSignalName => "ADB2",
        TestDelay => tisd_ADB2_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB2_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB2_CLKB_noedge_posedge,
        HoldHigh => thold_ADB2_CLKB_noedge_posedge,
        HoldLow => thold_ADB2_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB2_CLKB_TimingDatash,
        Violation => tviol_ADB2_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB2_dly,
        TestSignalName => "ADB2",
        TestDelay => tisd_ADB2_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB2_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB2_CLKB_noedge_negedge,
        HoldHigh => thold_ADB2_CLKB_noedge_negedge,
        HoldLow => thold_ADB2_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB2_CLKB_TimingDatash,
        Violation => tviol_ADB2_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB3_dly,
        TestSignalName => "ADB3",
        TestDelay => tisd_ADB3_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB3_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB3_CLKB_noedge_posedge,
        HoldHigh => thold_ADB3_CLKB_noedge_posedge,
        HoldLow => thold_ADB3_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB3_CLKB_TimingDatash,
        Violation => tviol_ADB3_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB3_dly,
        TestSignalName => "ADB3",
        TestDelay => tisd_ADB3_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB3_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB3_CLKB_noedge_negedge,
        HoldHigh => thold_ADB3_CLKB_noedge_negedge,
        HoldLow => thold_ADB3_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB3),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB3_CLKB_TimingDatash,
        Violation => tviol_ADB3_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB4_dly,
        TestSignalName => "ADB4",
        TestDelay => tisd_ADB4_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB4_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB4_CLKB_noedge_posedge,
        HoldHigh => thold_ADB4_CLKB_noedge_posedge,
        HoldLow => thold_ADB4_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB4),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB4_CLKB_TimingDatash,
        Violation => tviol_ADB4_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB4_dly,
        TestSignalName => "ADB4",
        TestDelay => tisd_ADB4_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB4_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB4_CLKB_noedge_negedge,
        HoldHigh => thold_ADB4_CLKB_noedge_negedge,
        HoldLow => thold_ADB4_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB4),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB4_CLKB_TimingDatash,
        Violation => tviol_ADB4_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB5_dly,
        TestSignalName => "ADB5",
        TestDelay => tisd_ADB5_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB5_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB5_CLKB_noedge_posedge,
        HoldHigh => thold_ADB5_CLKB_noedge_posedge,
        HoldLow => thold_ADB5_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB5),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB5_CLKB_TimingDatash,
        Violation => tviol_ADB5_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB5_dly,
        TestSignalName => "ADB5",
        TestDelay => tisd_ADB5_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB5_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB5_CLKB_noedge_negedge,
        HoldHigh => thold_ADB5_CLKB_noedge_negedge,
        HoldLow => thold_ADB5_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB5),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB5_CLKB_TimingDatash,
        Violation => tviol_ADB5_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB6_dly,
        TestSignalName => "ADB6",
        TestDelay => tisd_ADB6_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB6_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB6_CLKB_noedge_posedge,
        HoldHigh => thold_ADB6_CLKB_noedge_posedge,
        HoldLow => thold_ADB6_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB6),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB6_CLKB_TimingDatash,
        Violation => tviol_ADB6_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB6_dly,
        TestSignalName => "ADB6",
        TestDelay => tisd_ADB6_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB6_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB6_CLKB_noedge_negedge,
        HoldHigh => thold_ADB6_CLKB_noedge_negedge,
        HoldLow => thold_ADB6_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB6),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB6_CLKB_TimingDatash,
        Violation => tviol_ADB6_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB7_dly,
        TestSignalName => "ADB7",
        TestDelay => tisd_ADB7_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB7_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB7_CLKB_noedge_posedge,
        HoldHigh => thold_ADB7_CLKB_noedge_posedge,
        HoldLow => thold_ADB7_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB7),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB7_CLKB_TimingDatash,
        Violation => tviol_ADB7_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB7_dly,
        TestSignalName => "ADB7",
        TestDelay => tisd_ADB7_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB7_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB7_CLKB_noedge_negedge,
        HoldHigh => thold_ADB7_CLKB_noedge_negedge,
        HoldLow => thold_ADB7_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB7),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB7_CLKB_TimingDatash,
        Violation => tviol_ADB7_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB8_dly,
        TestSignalName => "ADB8",
        TestDelay => tisd_ADB8_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB8_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB8_CLKB_noedge_posedge,
        HoldHigh => thold_ADB8_CLKB_noedge_posedge,
        HoldLow => thold_ADB8_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB8),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB8_CLKB_TimingDatash,
        Violation => tviol_ADB8_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB8_dly,
        TestSignalName => "ADB8",
        TestDelay => tisd_ADB8_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB8_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB8_CLKB_noedge_negedge,
        HoldHigh => thold_ADB8_CLKB_noedge_negedge,
        HoldLow => thold_ADB8_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB8),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB8_CLKB_TimingDatash,
        Violation => tviol_ADB8_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB9_dly,
        TestSignalName => "ADB9",
        TestDelay => tisd_ADB9_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB9_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB9_CLKB_noedge_posedge,
        HoldHigh => thold_ADB9_CLKB_noedge_posedge,
        HoldLow => thold_ADB9_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB9),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB9_CLKB_TimingDatash,
        Violation => tviol_ADB9_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB9_dly,
        TestSignalName => "ADB9",
        TestDelay => tisd_ADB9_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB9_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB9_CLKB_noedge_negedge,
        HoldHigh => thold_ADB9_CLKB_noedge_negedge,
        HoldLow => thold_ADB9_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB9),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB9_CLKB_TimingDatash,
        Violation => tviol_ADB9_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB10_dly,
        TestSignalName => "ADB10",
        TestDelay => tisd_ADB10_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB10_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB10_CLKB_noedge_posedge,
        HoldHigh => thold_ADB10_CLKB_noedge_posedge,
        HoldLow => thold_ADB10_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB10),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB10_CLKB_TimingDatash,
        Violation => tviol_ADB10_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB10_dly,
        TestSignalName => "ADB10",
        TestDelay => tisd_ADB10_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB10_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB10_CLKB_noedge_negedge,
        HoldHigh => thold_ADB10_CLKB_noedge_negedge,
        HoldLow => thold_ADB10_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB10),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB10_CLKB_TimingDatash,
        Violation => tviol_ADB10_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB11_dly,
        TestSignalName => "ADB11",
        TestDelay => tisd_ADB11_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB11_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB11_CLKB_noedge_posedge,
        HoldHigh => thold_ADB11_CLKB_noedge_posedge,
        HoldLow => thold_ADB11_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB11),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB11_CLKB_TimingDatash,
        Violation => tviol_ADB11_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB11_dly,
        TestSignalName => "ADB11",
        TestDelay => tisd_ADB11_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB11_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB11_CLKB_noedge_negedge,
        HoldHigh => thold_ADB11_CLKB_noedge_negedge,
        HoldLow => thold_ADB11_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB11),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB11_CLKB_TimingDatash,
        Violation => tviol_ADB11_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB12_dly,
        TestSignalName => "ADB12",
        TestDelay => tisd_ADB12_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB12_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB12_CLKB_noedge_posedge,
        HoldHigh => thold_ADB12_CLKB_noedge_posedge,
        HoldLow => thold_ADB12_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB12),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB12_CLKB_TimingDatash,
        Violation => tviol_ADB12_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB12_dly,
        TestSignalName => "ADB12",
        TestDelay => tisd_ADB12_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB12_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB12_CLKB_noedge_negedge,
        HoldHigh => thold_ADB12_CLKB_noedge_negedge,
        HoldLow => thold_ADB12_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB12),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB12_CLKB_TimingDatash,
        Violation => tviol_ADB12_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => ADB13_dly,
        TestSignalName => "ADB13",
        TestDelay => tisd_ADB13_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB13_CLKB_noedge_posedge,
        SetupLow => tsetup_ADB13_CLKB_noedge_posedge,
        HoldHigh => thold_ADB13_CLKB_noedge_posedge,
        HoldLow => thold_ADB13_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_ADB13),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB13_CLKB_TimingDatash,
        Violation => tviol_ADB13_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => ADB13_dly,
        TestSignalName => "ADB13",
        TestDelay => tisd_ADB13_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_ADB13_CLKB_noedge_negedge,
        SetupLow => tsetup_ADB13_CLKB_noedge_negedge,
        HoldHigh => thold_ADB13_CLKB_noedge_negedge,
        HoldLow => thold_ADB13_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_ADB13),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ADB13_CLKB_TimingDatash,
        Violation => tviol_ADB13_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CEB_dly,
        TestSignalName => "CEB",
        TestDelay => tisd_CEB_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CEB_CLKB_noedge_posedge,
        SetupLow => tsetup_CEB_CLKB_noedge_posedge,
        HoldHigh => thold_CEB_CLKB_noedge_posedge,
        HoldLow => thold_CEB_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_CEB),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CEB_CLKB_TimingDatash,
        Violation => tviol_CEB_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CEB_dly,
        TestSignalName => "CEB",
        TestDelay => tisd_CEB_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CEB_CLKB_noedge_negedge,
        SetupLow => tsetup_CEB_CLKB_noedge_negedge,
        HoldHigh => thold_CEB_CLKB_noedge_negedge,
        HoldLow => thold_CEB_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_CEB),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CEB_CLKB_TimingDatash,
        Violation => tviol_CEB_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WEB_dly,
        TestSignalName => "WEB",
        TestDelay => tisd_WEB_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_WEB_CLKB_noedge_posedge,
        SetupLow => tsetup_WEB_CLKB_noedge_posedge,
        HoldHigh => thold_WEB_CLKB_noedge_posedge,
        HoldLow => thold_WEB_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_WEB),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WEB_CLKB_TimingDatash,
        Violation => tviol_WEB_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => WEB_dly,
        TestSignalName => "WEB",
        TestDelay => tisd_WEB_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_WEB_CLKB_noedge_negedge,
        SetupLow => tsetup_WEB_CLKB_noedge_negedge,
        HoldHigh => thold_WEB_CLKB_noedge_negedge,
        HoldLow => thold_WEB_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_WEB),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WEB_CLKB_TimingDatash,
        Violation => tviol_WEB_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSB0_dly,
        TestSignalName => "CSB0",
        TestDelay => tisd_CSB0_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CSB0_CLKB_noedge_posedge,
        SetupLow => tsetup_CSB0_CLKB_noedge_posedge,
        HoldHigh => thold_CSB0_CLKB_noedge_posedge,
        HoldLow => thold_CSB0_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_CSB0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSB0_CLKB_TimingDatash,
        Violation => tviol_CSB0_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSB0_dly,
        TestSignalName => "CSB0",
        TestDelay => tisd_CSB0_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CSB0_CLKB_noedge_negedge,
        SetupLow => tsetup_CSB0_CLKB_noedge_negedge,
        HoldHigh => thold_CSB0_CLKB_noedge_negedge,
        HoldLow => thold_CSB0_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_CSB0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSB0_CLKB_TimingDatash,
        Violation => tviol_CSB0_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSB1_dly,
        TestSignalName => "CSB1",
        TestDelay => tisd_CSB1_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CSB1_CLKB_noedge_posedge,
        SetupLow => tsetup_CSB1_CLKB_noedge_posedge,
        HoldHigh => thold_CSB1_CLKB_noedge_posedge,
        HoldLow => thold_CSB1_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_CSB1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSB1_CLKB_TimingDatash,
        Violation => tviol_CSB1_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSB1_dly,
        TestSignalName => "CSB1",
        TestDelay => tisd_CSB1_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CSB1_CLKB_noedge_negedge,
        SetupLow => tsetup_CSB1_CLKB_noedge_negedge,
        HoldHigh => thold_CSB1_CLKB_noedge_negedge,
        HoldLow => thold_CSB1_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_CSB1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSB1_CLKB_TimingDatash,
        Violation => tviol_CSB1_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSB2_dly,
        TestSignalName => "CSB2",
        TestDelay => tisd_CSB2_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CSB2_CLKB_noedge_posedge,
        SetupLow => tsetup_CSB2_CLKB_noedge_posedge,
        HoldHigh => thold_CSB2_CLKB_noedge_posedge,
        HoldLow => thold_CSB2_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_CSB2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSB2_CLKB_TimingDatash,
        Violation => tviol_CSB2_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSB2_dly,
        TestSignalName => "CSB2",
        TestDelay => tisd_CSB2_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_CSB2_CLKB_noedge_negedge,
        SetupLow => tsetup_CSB2_CLKB_noedge_negedge,
        HoldHigh => thold_CSB2_CLKB_noedge_negedge,
        HoldLow => thold_CSB2_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_CSB2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSB2_CLKB_TimingDatash,
        Violation => tviol_CSB2_CLKB,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RSTB_dly,
        TestSignalName => "RSTB",
        TestDelay => tisd_RSTB_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_RSTB_CLKB_noedge_posedge,
        SetupLow => tsetup_RSTB_CLKB_noedge_posedge,
        HoldHigh => thold_RSTB_CLKB_noedge_posedge,
        HoldLow => thold_RSTB_CLKB_noedge_posedge,
        CheckEnabled => ((CLKB_NEGEDGE = FALSE) and check_RSTB),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RSTB_CLKB_TimingDatash,
        Violation => tviol_RSTB_CLKB,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RSTB_dly,
        TestSignalName => "RSTB",
        TestDelay => tisd_RSTB_CLKB,
        RefSignal => CLKB_dly,
        RefSignalName => "CLKB",
        RefDelay => ticd_CLKB,
        SetupHigh => tsetup_RSTB_CLKB_noedge_negedge,
        SetupLow => tsetup_RSTB_CLKB_noedge_negedge,
        HoldHigh => thold_RSTB_CLKB_noedge_negedge,
        HoldLow => thold_RSTB_CLKB_noedge_negedge,
        CheckEnabled => (CLKB_NEGEDGE and check_RSTB),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RSTB_CLKB_TimingDatash,
        Violation => tviol_RSTB_CLKB,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLKA_ipd,
        TestSignalName => "CLKA",
        Period => tperiod_CLKA,
        PulseWidthHigh => tpw_CLKA_posedge,
        PulseWidthLow => tpw_CLKA_negedge,
        PeriodData => periodcheckinfo_CLKA,
        Violation => tviol_CLKA,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
      VitalPeriodPulseCheck (
        TestSignal => CLKB_ipd,
        TestSignalName => "CLKB",
        Period => tperiod_CLKB,
        PulseWidthHigh => tpw_CLKB_posedge,
        PulseWidthLow => tpw_CLKB_negedge,
        PeriodData => periodcheckinfo_CLKB,
        Violation => tviol_CLKB,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
      VitalPeriodPulseCheck (
        TestSignal => RSTA_ipd,
        TestSignalName => "RSTA",
        Period => tperiod_RSTA,
        PulseWidthHigh => tpw_RSTA_posedge,
        PulseWidthLow => tpw_RSTA_negedge,
        PeriodData => periodcheckinfo_RSTA,
        Violation => tviol_RSTA,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
      VitalPeriodPulseCheck (
        TestSignal => RSTB_ipd,
        TestSignalName => "RSTB",
        Period => tperiod_RSTB,
        PulseWidthHigh => tpw_RSTB_posedge,
        PulseWidthLow => tpw_RSTB_negedge,
        PeriodData => periodcheckinfo_RSTB,
        Violation => tviol_RSTB,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    DOA0_zd    := DOA0_dly;
    DOA1_zd    := DOA1_dly;
    DOA2_zd    := DOA2_dly;
    DOA3_zd    := DOA3_dly;
    DOA4_zd    := DOA4_dly;
    DOA5_zd    := DOA5_dly;
    DOA6_zd    := DOA6_dly;
    DOA7_zd    := DOA7_dly;
    DOA8_zd    := DOA8_dly;
    DOA9_zd    := DOA9_dly;
    DOA10_zd    := DOA10_dly;
    DOA11_zd    := DOA11_dly;
    DOA12_zd    := DOA12_dly;
    DOA13_zd    := DOA13_dly;
    DOA14_zd    := DOA14_dly;
    DOA15_zd    := DOA15_dly;
    DOA16_zd    := DOA16_dly;
    DOA17_zd    := DOA17_dly;
    DOB0_zd    := DOB0_dly;
    DOB1_zd    := DOB1_dly;
    DOB2_zd    := DOB2_dly;
    DOB3_zd    := DOB3_dly;
    DOB4_zd    := DOB4_dly;
    DOB5_zd    := DOB5_dly;
    DOB6_zd    := DOB6_dly;
    DOB7_zd    := DOB7_dly;
    DOB8_zd    := DOB8_dly;
    DOB9_zd    := DOB9_dly;
    DOB10_zd    := DOB10_dly;
    DOB11_zd    := DOB11_dly;
    DOB12_zd    := DOB12_dly;
    DOB13_zd    := DOB13_dly;
    DOB14_zd    := DOB14_dly;
    DOB15_zd    := DOB15_dly;
    DOB16_zd    := DOB16_dly;
    DOB17_zd    := DOB17_dly;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => DOA0,
       OutSignalName => "DOA0",
       OutTemp => DOA0_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA0,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA0, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA0, PathCondition => TRUE)),
       GlitchData => DOA0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA1,
       OutSignalName => "DOA1",
       OutTemp => DOA1_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA1,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA1, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA1, PathCondition => TRUE)),
       GlitchData => DOA1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA2,
       OutSignalName => "DOA2",
       OutTemp => DOA2_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA2,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA2, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA2, PathCondition => TRUE)),
       GlitchData => DOA2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA3,
       OutSignalName => "DOA3",
       OutTemp => DOA3_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA3,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA3, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA3, PathCondition => TRUE)),
       GlitchData => DOA3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA4,
       OutSignalName => "DOA4",
       OutTemp => DOA4_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA4,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA4, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA4, PathCondition => TRUE)),
       GlitchData => DOA4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA5,
       OutSignalName => "DOA5",
       OutTemp => DOA5_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA5,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA5, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA5, PathCondition => TRUE)),
       GlitchData => DOA5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA6,
       OutSignalName => "DOA6",
       OutTemp => DOA6_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA6,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA6, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA6, PathCondition => TRUE)),
       GlitchData => DOA6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA7,
       OutSignalName => "DOA7",
       OutTemp => DOA7_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA7,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA7, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA7, PathCondition => TRUE)),
       GlitchData => DOA7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA8,
       OutSignalName => "DOA8",
       OutTemp => DOA8_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA8,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA8, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA8, PathCondition => TRUE)),
       GlitchData => DOA8_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA9,
       OutSignalName => "DOA9",
       OutTemp => DOA9_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA9,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA9, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA9, PathCondition => TRUE)),
       GlitchData => DOA9_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA10,
       OutSignalName => "DOA10",
       OutTemp => DOA10_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA10,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA10, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA10, PathCondition => TRUE)),
       GlitchData => DOA10_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA11,
       OutSignalName => "DOA11",
       OutTemp => DOA11_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA11,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA11, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA11, PathCondition => TRUE)),
       GlitchData => DOA11_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA12,
       OutSignalName => "DOA12",
       OutTemp => DOA12_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA12,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA12, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA12, PathCondition => TRUE)),
       GlitchData => DOA12_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA13,
       OutSignalName => "DOA13",
       OutTemp => DOA13_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA13,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA13, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA13, PathCondition => TRUE)),
       GlitchData => DOA13_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA14,
       OutSignalName => "DOA14",
       OutTemp => DOA14_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA14,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA14, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA14, PathCondition => TRUE)),
       GlitchData => DOA14_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA15,
       OutSignalName => "DOA15",
       OutTemp => DOA15_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA15,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA15, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA15, PathCondition => TRUE)),
       GlitchData => DOA15_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA16,
       OutSignalName => "DOA16",
       OutTemp => DOA16_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA16,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA16, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA16, PathCondition => TRUE)),
       GlitchData => DOA16_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOA17,
       OutSignalName => "DOA17",
       OutTemp => DOA17_zd,
       Paths => (0 => (InputChangeTime => CLKA_dly'last_event,
                       PathDelay => tpd_CLKA_DOA17,
                       PathCondition => TRUE),
                 1 => (CLKB_dly'last_event, tpd_CLKB_DOA17, PathCondition => TRUE),
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA17, PathCondition => TRUE)),
       GlitchData => DOA17_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


      VitalPathDelay01 (
       OutSignal => DOB0,
       OutSignalName => "DOB0",
       OutTemp => DOB0_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB0,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB0, PathCondition => TRUE)),
       GlitchData => DOB0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB1,
       OutSignalName => "DOB1",
       OutTemp => DOB1_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB1,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB1, PathCondition => TRUE)),
       GlitchData => DOB1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB2,
       OutSignalName => "DOB2",
       OutTemp => DOB2_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB2,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB2, PathCondition => TRUE)),
       GlitchData => DOB2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB3,
       OutSignalName => "DOB3",
       OutTemp => DOB3_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB3,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB3, PathCondition => TRUE)),
       GlitchData => DOB3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB4,
       OutSignalName => "DOB4",
       OutTemp => DOB4_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB4,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB4, PathCondition => TRUE)),
       GlitchData => DOB4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB5,
       OutSignalName => "DOB5",
       OutTemp => DOB5_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB5,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB5, PathCondition => TRUE)),
       GlitchData => DOB5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB6,
       OutSignalName => "DOB6",
       OutTemp => DOB6_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB6,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB6, PathCondition => TRUE)),
       GlitchData => DOB6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB7,
       OutSignalName => "DOB7",
       OutTemp => DOB7_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB7,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB7, PathCondition => TRUE)),
       GlitchData => DOB7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB8,
       OutSignalName => "DOB8",
       OutTemp => DOB8_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB8,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB8, PathCondition => TRUE)),
       GlitchData => DOB8_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB9,
       OutSignalName => "DOB9",
       OutTemp => DOB9_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB9,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB9, PathCondition => TRUE)),
       GlitchData => DOB9_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB10,
       OutSignalName => "DOB10",
       OutTemp => DOB10_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB10,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB10, PathCondition => TRUE)),
       GlitchData => DOB10_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB11,
       OutSignalName => "DOB11",
       OutTemp => DOB11_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB11,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB11, PathCondition => TRUE)),
       GlitchData => DOB11_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB12,
       OutSignalName => "DOB12",
       OutTemp => DOB12_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB12,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB12, PathCondition => TRUE)),
       GlitchData => DOB12_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB13,
       OutSignalName => "DOB13",
       OutTemp => DOB13_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB13,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB13, PathCondition => TRUE)),
       GlitchData => DOB13_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB14,
       OutSignalName => "DOB14",
       OutTemp => DOB14_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB14,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB14, PathCondition => TRUE)),
       GlitchData => DOB14_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB15,
       OutSignalName => "DOB15",
       OutTemp => DOB15_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB15,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB15, PathCondition => TRUE)),
       GlitchData => DOB15_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB16,
       OutSignalName => "DOB16",
       OutTemp => DOB16_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB16,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB16, PathCondition => TRUE)),
       GlitchData => DOB16_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DOB17,
       OutSignalName => "DOB17",
       OutTemp => DOB17_zd,
       Paths => (0 => (InputChangeTime => CLKB_dly'last_event,
                       PathDelay => tpd_CLKB_DOB17,
                       PathCondition => TRUE),
                 1 => (RSTB_dly'last_event, tpd_RSTB_DOB17, PathCondition => TRUE)),
       GlitchData => DOB17_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


