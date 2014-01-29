library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SLOGICA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SLOGICA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        M1MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        M0MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG" 
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG" 
        LUT1_INITVAL    : bit_vector := X"0000";      
        LUT0_INITVAL    : bit_vector := X"0000";      
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"    
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"    
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"    
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_FXA        : boolean := FALSE;
        check_FXB        : boolean := FALSE;
        check_A1        : boolean := FALSE;
        check_B1        : boolean := FALSE;
        check_C1        : boolean := FALSE;
        check_D1        : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_A0        : boolean := FALSE;
        check_B0        : boolean := FALSE;
        check_C0        : boolean := FALSE;
        check_D0        : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE;

        -- input SIGNAL delays
        tipd_M1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FXA : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FXB : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_FXA_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FXB_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M1_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M1_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_DI1_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CE_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_DI0_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CE_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F1     : VitalDelayType01 := (0 ns, 0 ns);
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
        ticd_CLK          : VitalDelayType := 0 ns;
        tisd_M1_CLK      : VitalDelayType := 0 ns;
        tisd_FXA_CLK      : VitalDelayType := 0 ns;
        tisd_FXB_CLK      : VitalDelayType := 0 ns;
        tisd_A1_CLK      : VitalDelayType := 0 ns;
        tisd_B1_CLK      : VitalDelayType := 0 ns;
        tisd_C1_CLK      : VitalDelayType := 0 ns;
        tisd_D1_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK      : VitalDelayType := 0 ns;
        tisd_DI0_CLK      : VitalDelayType := 0 ns;
        tisd_A0_CLK      : VitalDelayType := 0 ns;
        tisd_B0_CLK      : VitalDelayType := 0 ns;
        tisd_C0_CLK      : VitalDelayType := 0 ns;
        tisd_D0_CLK      : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK      : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
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
      ATTRIBUTE Vital_Level0 OF SLOGICA : ENTITY IS TRUE;

END SLOGICA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SLOGICA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal M1_ipd       : std_logic := 'X';
    signal M1_dly       : std_logic := 'X';
    signal FXA_ipd       : std_logic := 'X';
    signal FXA_dly       : std_logic := 'X';
    signal FXB_ipd       : std_logic := 'X';
    signal FXB_dly       : std_logic := 'X';
    signal A1_ipd       : std_logic := 'X';
    signal A1_dly       : std_logic := 'X';
    signal B1_ipd       : std_logic := 'X';
    signal B1_dly       : std_logic := 'X';
    signal C1_ipd       : std_logic := 'X';
    signal C1_dly       : std_logic := 'X';
    signal D1_ipd       : std_logic := 'X';
    signal D1_dly       : std_logic := 'X';
    signal DI1_ipd       : std_logic := 'X';
    signal DI1_dly       : std_logic := 'X';
    signal DI0_ipd       : std_logic := 'X';
    signal DI0_dly       : std_logic := 'X';
    signal A0_ipd       : std_logic := 'X';
    signal A0_dly       : std_logic := 'X';
    signal B0_ipd       : std_logic := 'X';
    signal B0_dly       : std_logic := 'X';
    signal C0_ipd       : std_logic := 'X';
    signal C0_dly       : std_logic := 'X';
    signal D0_ipd       : std_logic := 'X';
    signal D0_dly       : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal M0_dly       : std_logic := 'X';
    signal CE_ipd       : std_logic := 'X';
    signal CE_dly       : std_logic := 'X';
    signal CLK_ipd       : std_logic := 'X';
    signal CLK_dly       : std_logic := 'X';
    signal LSR_ipd       : std_logic := 'X';
    signal LSR_dly       : std_logic := 'X';
    signal F0_buf       : std_logic := 'X';
    signal F1_buf       : std_logic := 'X';
    signal M1_sig       : std_logic := 'X';
    signal M0_sig       : std_logic := 'X';
    signal CE_sig       : std_logic := 'X';
    signal LSR_sig       : std_logic := 'X';
    signal LSR_sig0      : std_logic := 'X';
    signal CLK_sig       : std_logic := 'X';
    signal CLK_sig0       : std_logic := 'X';
    signal CLK_sig1       : std_logic := 'X';
    signal CLK_sig_ce0       : std_logic := 'X';
    signal CLK_sig_ce1       : std_logic := 'X';
    signal D0_sig       : std_logic := 'X';
    signal D1_sig       : std_logic := 'X';
    signal posedge_clk       : std_logic := '0';
    signal negedge_clk       : std_logic := '0';
    signal OFX1_buf       : std_logic := 'X';
    signal OFX0_buf       : std_logic := 'X';
    signal QB0       : std_logic := 'X';
    signal QB1       : std_logic := 'X';

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
      VitalSignalDelay(FXA_dly, FXA_ipd, tisd_FXA_CLK);
      VitalSignalDelay(FXB_dly, FXB_ipd, tisd_FXB_CLK);
      VitalSignalDelay(A1_dly, A1_ipd, tisd_A1_CLK);
      VitalSignalDelay(B1_dly, B1_ipd, tisd_B1_CLK);
      VitalSignalDelay(C1_dly, C1_ipd, tisd_C1_CLK);
      VitalSignalDelay(D1_dly, D1_ipd, tisd_D1_CLK);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLK);
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLK);
      VitalSignalDelay(A0_dly, A0_ipd, tisd_A0_CLK);
      VitalSignalDelay(B0_dly, B0_ipd, tisd_B0_CLK);
      VitalSignalDelay(C0_dly, C0_ipd, tisd_C0_CLK);
      VitalSignalDelay(D0_dly, D0_ipd, tisd_D0_CLK);
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

--    D0_sig <= M0_sig when (REG0_SD = '0') else DI0_ipd;
--    D1_sig <= M1_sig when (REG1_SD = '0') else DI1_ipd;

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

    CLK_sig0 <= transport CLK_sig after CLK_BOOST0;
    CLK_sig1 <= transport CLK_sig after CLK_BOOST1;
    CLK_sig_ce0 <= CLK_sig0 and CE_sig;
    CLK_sig_ce1 <= CLK_sig1 and CE_sig;

    P101 : PROCESS (LSR_sig)
    BEGIN
       IF ((REG0_SD = "SIG") or (REG1_SD = "SIG")) THEN
          LSR_sig0 <= '0';
       ELSE
          LSR_sig0 <= LSR_sig;
       END IF;
    END PROCESS;

    GFF : if (SRMODE = "ASYNC" and REGMODE = "FF" and REG0_REGSET = "RESET") generate
             fd1p3dx_inst : fd1p3dx
                        generic map (gsr => gsr)
                        port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, cd => LSR_sig0, q => QB0);
    end generate GFF;

    GFF1 : if (SRMODE = "ASYNC" and REGMODE = "FF" and REG0_REGSET = "SET") generate
             fd1p3bx_inst : fd1p3bx
                        generic map (gsr => gsr)
                        port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, pd => LSR_sig0, q => QB0);
    end generate GFF1;

    GFF2 : if (SRMODE = "ASYNC" and REGMODE = "FF" and REG1_REGSET = "RESET") generate
             fd1p3dx_inst : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, cd => LSR_sig0, q => QB1);
    end generate GFF2;

    GFF3 : if (SRMODE = "ASYNC" and REGMODE = "FF" and REG1_REGSET = "SET") generate
             fd1p3bx_inst : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, pd => LSR_sig0, q => QB1);
    end generate GFF3;

    GLATCH0 : if (SRMODE = "ASYNC" and REGMODE = "LATCH" and REG0_REGSET = "RESET") generate
                 fd1s1d_inst : fd1s1d
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, cd => LSR_sig0, q => QB0);
    end generate GLATCH0;

    GLATCH1 : if (SRMODE = "ASYNC" and REGMODE = "LATCH" and REG0_REGSET = "SET") generate
                 fd1s1b_inst : fd1s1b
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, pd => LSR_sig0, q => QB0);
    end generate GLATCH1;

    GLATCH2 : if (SRMODE = "ASYNC" and REGMODE = "LATCH" and REG1_REGSET = "RESET") generate
                 fd1s1d_inst : fd1s1d
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, cd => LSR_sig0, q => QB1);
    end generate GLATCH2;

    GLATCH3 : if (SRMODE = "ASYNC" and REGMODE = "LATCH" and REG1_REGSET = "SET") generate
                 fd1s1b_inst : fd1s1b
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, pd => LSR_sig0, q => QB1);
    end generate GLATCH3;

    GFF4 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "FF" and REG0_REGSET = "RESET") generate
                 fd1p3ix_inst : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, cd => LSR_sig0, q => QB0);
    end generate GFF4;

    GFF5 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "FF" and REG0_REGSET = "SET") generate
                 fd1p3jx_inst : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, pd => LSR_sig0, q => QB0);
    end generate GFF5;

    GFF6 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "FF" and REG1_REGSET = "RESET") generate
                 fd1p3ix_inst : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, cd => LSR_sig0, q => QB1);
    end generate GFF6;

    GFF7 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "FF" and REG1_REGSET = "SET") generate
                 fd1p3jx_inst : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, pd => LSR_sig0, q => QB1);
    end generate GFF7;

    GLATCH4 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "LATCH" and REG0_REGSET = "RESET") generate
                 fd1s1i_inst : fd1s1i
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, cd => LSR_sig0, q => QB0);
    end generate GLATCH4;

    GLATCH5 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "LATCH" and REG0_REGSET = "SET") generate
                 fd1s1j_inst : fd1s1j
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, pd => LSR_sig0, q => QB0);
    end generate GLATCH5;

    GLATCH6 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "LATCH" and REG1_REGSET = "RESET") generate
                 fd1s1i_inst : fd1s1i
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, cd => LSR_sig0, q => QB1);
    end generate GLATCH6;

    GLATCH7 : if (SRMODE = "LSR_OVER_CE" and REGMODE = "LATCH" and REG1_REGSET = "SET") generate
                 fd1s1j_inst : fd1s1j
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, pd => LSR_sig0, q => QB1);
    end generate GLATCH7;


    VitalBehavior : PROCESS (M1_dly, M0_dly, FXA_ipd, FXB_ipd, A1_ipd, B1_ipd, DI1_ipd, DI1_dly, DI0_ipd, DI0_dly, CE_ipd, LSR_ipd,
      CLK_ipd, CLK_dly, C1_ipd, D1_ipd, QB0, QB1, OFX0_buf, OFX1_buf, F1_buf, F0_buf)

    VARIABLE OFX1_zd              : std_logic := 'X';
    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE OFX0_zd              : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE OFX1_GlitchData      : VitalGlitchDataType;
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE OFX0_GlitchData      : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_M1_CLK_pos              : x01 := '0';
    VARIABLE tviol_M1_CLK_neg              : x01 := '0';
    VARIABLE M1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI1_CLK_neg              : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI0_CLK_neg              : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_M0_CLK_pos              : x01 := '0';
    VARIABLE tviol_M0_CLK_neg              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CE_CLK_pos              : x01 := '0';
    VARIABLE tviol_CE_CLK_neg              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK_pos              : x01 := '0';
    VARIABLE tviol_LSR_CLK_neg              : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CLK_CLK              : x01 := '0';
    VARIABLE periodcheckinfo_CLK        : VitalPeriodDataType;
    VARIABLE tviol_LSR_LSR              : x01 := '0';
    VARIABLE periodcheckinfo_LSR        : VitalPeriodDataType;
    VARIABLE viol_M1                   : x01 := '0';
    VARIABLE viol_DI1                  : x01 := '0';
    VARIABLE viol_DI0                  : x01 := '0';
    VARIABLE viol_M0                   : x01 := '0';
    VARIABLE viol_CE                   : x01 := '0';
    VARIABLE viol_LSR                  : x01 := '0';
    VARIABLE viol_CLK                  : x01 := '0';

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
        CheckEnabled => ((posedge_clk = '1') and check_m1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK_pos,
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
        CheckEnabled => ((negedge_clk = '1') and check_m1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK_neg,
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
        Violation => tviol_DI1_CLK_pos,
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
        Violation => tviol_DI1_CLK_neg,
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
        Violation => tviol_DI0_CLK_pos,
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
        Violation => tviol_DI0_CLK_neg,
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
        Violation => tviol_M0_CLK_pos,
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
        Violation => tviol_M0_CLK_neg,
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
        Violation => tviol_CE_CLK_pos,
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
        Violation => tviol_CE_CLK_neg,
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
        Violation => tviol_LSR_CLK_pos,
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
        Violation => tviol_LSR_CLK_neg,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK_CLK,
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
        Violation => tviol_LSR_LSR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    IF (tviol_M0_CLK_pos = 'X' or tviol_M0_CLK_neg = 'X') THEN
        viol_M0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_M0 := '0';
    END IF;

    IF (tviol_M1_CLK_pos = 'X' or tviol_M1_CLK_neg = 'X') THEN
        viol_M1 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_M1 := '0';
    END IF;

    IF (tviol_DI0_CLK_pos = 'X' or tviol_DI0_CLK_neg = 'X') THEN
        viol_DI0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI0 := '0';
    END IF;

    IF (tviol_DI1_CLK_pos = 'X' or tviol_DI1_CLK_neg = 'X') THEN
        viol_DI1 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI1 := '0';
    END IF;

    IF (tviol_CE_CLK_pos = 'X' or tviol_CE_CLK_neg = 'X') THEN
        viol_CE := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CE := '0';
    END IF;

    IF (tviol_LSR_CLK_pos = 'X' or tviol_LSR_CLK_neg = 'X') THEN
        viol_LSR := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_LSR := '0';
    END IF;

    IF (tviol_CLK_CLK = 'X') THEN
        viol_CLK := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CLK := '0';
    END IF;

    IF ((viol_M0 = '0' and viol_DI0 = '0') and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q0_zd := QB0;
    ELSE
        Q0_zd := 'X';
    END IF;

    IF ((viol_M1 = '0' and viol_DI1 = '0') and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q1_zd := QB1;
    ELSE
        Q1_zd := 'X';
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
       OutSignal => Q1,
       OutSignalName => "Q1",
       OutTemp => Q1_zd,
       Paths => (0 => (InputChangeTime => clk_dly'last_event,
                       PathDelay => tpd_clk_Q1,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q1, PathCondition => TRUE),
                 2 => (DI1_ipd'last_event, tpd_DI1_Q1, PathCondition => (REGMODE = "LATCH"))),
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
       Paths => (0 => (InputChangeTime => clk_dly'last_event,
                       PathDelay => tpd_clk_Q0,
                       PathCondition => TRUE),
                 1 => (LSR_ipd'last_event, tpd_LSR_Q0, PathCondition => TRUE),
                 2 => (DI0_ipd'last_event, tpd_DI0_Q0, PathCondition => (REGMODE = "LATCH"))),
       GlitchData => Q0_GlitchData,
       Mode => VitalTransport,
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
ENTITY SRIPPLEA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SRIPPLEA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        M1MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        M0MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        ALU2_MODE       : string := "ADD";  -- "ADD", "SUB", "CNTUP", "CNTDN", "A_GE_B", "A_NE_B"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"
        FCIMUX          : string := "M0MUX";  -- "M0MUX", "FCI"
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_FCI        : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE;

        -- input SIGNAL delays
        tipd_M1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FCI : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLK_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_FCO     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_FCO     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_FCO     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_FCO     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_FCO     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_FCO    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_OFX1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_OFX1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_F1    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_OFX0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_OFX0    : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_M0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_FCI_F0    : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLK          : VitalDelayType := 0 ns;
        tisd_M1_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK      : VitalDelayType := 0 ns;
        tisd_DI0_CLK      : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK      : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_LSR            : VitalDelayType := 0.001 ns;
        tpw_LSR_posedge        : VitalDelayType := 0.001 ns;
        tpw_LSR_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        M1, A1, B1, DI1, DI0                           : in std_ulogic := '0';
        A0, B0, FCI, M0, CE, CLK, LSR                  : in std_ulogic := '0';
        FCO, OFX1, F1, Q1, OFX0, F0, Q0                : out std_ulogic := '0'
        );
      ATTRIBUTE Vital_Level0 OF SRIPPLEA : ENTITY IS TRUE;

END SRIPPLEA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SRIPPLEA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal M1_ipd       : std_logic := '0';
    signal M1_dly       : std_logic := '0';
    signal A1_ipd       : std_logic := '0';
    signal FCI_ipd       : std_logic := '0';
    signal DI1_ipd       : std_logic := '0';
    signal DI1_dly       : std_logic := '0';
    signal DI0_ipd       : std_logic := '0';
    signal DI0_dly       : std_logic := '0';
    signal B1_ipd       : std_logic := '0';
    signal A0_ipd       : std_logic := '0';
    signal B0_ipd       : std_logic := '0';
    signal M0_ipd       : std_logic := '0';
    signal M0_dly       : std_logic := '0';
    signal CE_ipd       : std_logic := '0';
    signal CE_dly       : std_logic := '0';
    signal CLK_ipd       : std_logic := '0';
    signal CLK_dly       : std_logic := '0';
    signal LSR_ipd       : std_logic := '0';
    signal LSR_dly       : std_logic := '0';
    signal M1_sig       : std_logic := '0';
    signal M0_sig       : std_logic := '0';
    signal CE_sig       : std_logic := '0';
    signal LSR_sig       : std_logic := '0';
    signal LSR_sig0      : std_logic := '0';
    signal CLK_sig       : std_logic := '0';
    signal CLK_sig0       : std_logic := '0';
    signal CLK_sig1       : std_logic := '0';
    signal CLK_sig_ce0       : std_logic := '0';
    signal CLK_sig_ce1       : std_logic := '0';
    signal D0_sig       : std_logic := '0';
    signal D1_sig       : std_logic := '0';
    signal CI_sig       : std_logic := '0';
    signal COUT1        : std_logic := '0';
    signal COUT0        : std_logic := '0';
    signal S0           : std_logic := '0';
    signal S1           : std_logic := '0';
    signal posedge_clk       : std_logic := '0';
    signal negedge_clk       : std_logic := '0';
    signal OFX1_buf       : std_logic := '0';
    signal OFX0_buf       : std_logic := '0';
    signal QB0       : std_logic := '0';
    signal QB1       : std_logic := '0';

    BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(M1_ipd, M1, tipd_M1);
      VitalWireDelay(FCI_ipd, FCI, tipd_FCI);
      VitalWireDelay(A1_ipd, A1, tipd_A1);
      VitalWireDelay(B1_ipd, B1, tipd_B1);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(A0_ipd, A0, tipd_A0);
      VitalWireDelay(B0_ipd, B0, tipd_B0);
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

--    D0_sig <= M0_sig when (REG0_SD = '0') else DI0_dly;
--    D1_sig <= M1_sig when (REG1_SD = '0') else DI1_dly;
    CI_sig <= M0_sig when (FCIMUX = "M0MUX") else FCI_ipd;


    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    CLK_sig0 <= transport CLK_sig after CLK_BOOST0;
    CLK_sig1 <= transport CLK_sig after CLK_BOOST1;
    CLK_sig_ce0 <= CLK_sig0 and CE_sig;
    CLK_sig_ce1 <= CLK_sig1 and CE_sig;

    ALU_ADD : if (ALU2_MODE = "ADD") generate
       FADD2_INST : fadd2 
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              ci => CI_sig, cout0 => COUT0, cout1 => COUT1, s0 => S0, s1 => S1);
    end generate ALU_ADD; 

    ALU_SUB : if (ALU2_MODE = "SUB") generate
       FSUB2_INST : fsub2 
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              bi => CI_sig, bout0 => COUT0, bout1 => COUT1, s0 => S0, s1 => S1);
    end generate ALU_SUB;

    ALU_AGEB : if (ALU2_MODE = "A_GE_B") generate
       AGEB2_INST : ageb2 
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              ci => CI_sig, ge => COUT1);
    end generate ALU_AGEB;

    ALU_ANEB : if (ALU2_MODE = "A_NE_B") generate
       ANEB2_INST : aneb2 
                    port map (a0 => A0_ipd, a1 => A1_ipd, b0 => B0_ipd, b1 => B1_ipd, 
                              ci => CI_sig, ne => COUT1);
    end generate ALU_ANEB;

    ALU_CNTUP : if (ALU2_MODE = "CNTUP") generate
       CU2_INST : cu2
                    port map (ci => CI_sig, pc0 => A0_ipd, pc1 => A1_ipd, 
                              co => COUT1, nc0 => S0, nc1 => S1);
    end generate ALU_CNTUP;

    ALU_CNTDN : if (ALU2_MODE = "CNTDN") generate
       CD2_INST : cd2
                    port map (ci => CI_sig, pc0 => A0_ipd, pc1 => A1_ipd, 
                              co => COUT1, nc0 => S0, nc1 => S1);
    end generate ALU_CNTDN;

    P101 : PROCESS (LSR_sig)
    BEGIN
       IF ((REG0_SD = "SIG") or (REG1_SD = "SIG")) THEN
          LSR_sig0 <= '0';
       ELSE
          LSR_sig0 <= LSR_sig;
       END IF;
    END PROCESS;

    GFF : if (SRMODE = "ASYNC") generate
       GFF0 : if (REGMODE = "FF") generate
          GFF1 : if (REG0_REGSET = "RESET") generate
                 fd1p3dx_inst : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF1;
          GFF2 : if (REG0_REGSET = "SET") generate
                 fd1p3bx_inst : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF2;

          GFF3 : if (REG1_REGSET = "RESET") generate
                 fd1p3dx_inst : fd1p3dx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF3;
          GFF4 : if (REG1_REGSET = "SET") generate
                 fd1p3bx_inst : fd1p3bx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF4;
       end generate GFF0;

       GLATCH0 : if (REGMODE = "LATCH") generate
          GFF5 : if (REG0_REGSET = "RESET") generate
                 fd1s1d_inst : fd1s1d
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, cd => LSR_sig0, q => QB0);
          end generate GFF5;
          GFF6 : if (REG0_REGSET = "SET") generate
                 fd1s1b_inst : fd1s1b
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, pd => LSR_sig0, q => QB0);
          end generate GFF6;

          GFF7 : if (REG1_REGSET = "RESET") generate
                 fd1s1d_inst : fd1s1d
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, cd => LSR_sig0, q => QB1);
          end generate GFF7;
          GFF8 : if (REG1_REGSET = "SET") generate
                 fd1s1b_inst : fd1s1b
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, pd => LSR_sig0, q => QB1);
          end generate GFF8;
       end generate GLATCH0;
    end generate GFF;

    GFF20 : if (SRMODE = "LSR_OVER_CE") generate
       GFF9 : if (REGMODE = "FF") generate
          GFF10 : if (REG0_REGSET = "RESET") generate
                 fd1p3ix_inst : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, cd => LSR_sig0, q => QB0);
          end generate GFF10;
          GFF11 : if (REG0_REGSET = "SET") generate
                 fd1p3jx_inst : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig0, sp => CE_sig, pd => LSR_sig0, q => QB0);
          end generate GFF11;

          GFF12 : if (REG1_REGSET = "RESET") generate
                 fd1p3ix_inst : fd1p3ix
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, cd => LSR_sig0, q => QB1);
          end generate GFF12;
          GFF13 : if (REG1_REGSET = "SET") generate
                 fd1p3jx_inst : fd1p3jx
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig1, sp => CE_sig, pd => LSR_sig0, q => QB1);
          end generate GFF13;
       end generate GFF9;

       GLATCH1 : if (REGMODE = "LATCH") generate
          GFF14 : if (REG0_REGSET = "RESET") generate
                 fd1s1i_inst : fd1s1i
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, cd => LSR_sig0, q => QB0);
          end generate GFF14;
          GFF15 : if (REG0_REGSET = "SET") generate
                 fd1s1j_inst : fd1s1j
                            generic map (gsr => gsr)
                            port map (d => D0_sig, ck => CLK_sig_ce0, pd => LSR_sig0, q => QB0);
          end generate GFF15;

          GFF16 : if (REG1_REGSET = "RESET") generate
                 fd1s1i_inst : fd1s1i
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, cd => LSR_sig0, q => QB1);
          end generate GFF16;
          GFF17 : if (REG1_REGSET = "SET") generate
                 fd1s1j_inst : fd1s1j
                            generic map (gsr => gsr)
                            port map (d => D1_sig, ck => CLK_sig_ce1, pd => LSR_sig0, q => QB1);
          end generate GFF17;
       end generate GLATCH1;
   end generate GFF20;

    VitalBehavior : PROCESS (M1_dly, A1_ipd, B1_ipd, A0_ipd, B0_ipd, FCI_ipd, CLK_ipd, LSR_ipd,
    CE_dly, LSR_dly, CLK_dly, M0_dly, M1_sig, DI1_dly, DI0_dly, QB0, QB1, COUT1, COUT0, S1, S0)
 

    VARIABLE OFX1_zd              : std_logic := 'X';
    VARIABLE FCO_zd              : std_logic := 'X';
    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE OFX0_zd              : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE OFX1_GlitchData      : VitalGlitchDataType;
    VARIABLE FCO_GlitchData      : VitalGlitchDataType;
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE OFX0_GlitchData      : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_M1_CLK_pos              : x01 := '0';
    VARIABLE tviol_M1_CLK_neg              : x01 := '0';
    VARIABLE M1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI1_CLK_neg              : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI0_CLK_neg              : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_M0_CLK_pos              : x01 := '0';
    VARIABLE tviol_M0_CLK_neg              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CE_CLK_pos              : x01 := '0';
    VARIABLE tviol_CE_CLK_neg              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK_pos              : x01 := '0';
    VARIABLE tviol_LSR_CLK_neg              : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CLK_CLK              : x01 := '0';
    VARIABLE periodcheckinfo_CLK        : VitalPeriodDataType;
    VARIABLE tviol_LSR_LSR              : x01 := '0';
    VARIABLE periodcheckinfo_LSR        : VitalPeriodDataType;
    VARIABLE viol_M1                   : x01 := '0';
    VARIABLE viol_DI1                  : x01 := '0';
    VARIABLE viol_DI0                  : x01 := '0';
    VARIABLE viol_M0                   : x01 := '0';
    VARIABLE viol_CE                   : x01 := '0';
    VARIABLE viol_LSR                  : x01 := '0';
    VARIABLE viol_CLK                  : x01 := '0';

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
        CheckEnabled => ((posedge_clk = '1') and check_m1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK_pos,
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
        CheckEnabled => ((negedge_clk = '1') and check_m1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK_neg,
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
        Violation => tviol_DI1_CLK_pos,
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
        Violation => tviol_DI1_CLK_neg,
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
        Violation => tviol_DI0_CLK_pos,
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
        Violation => tviol_DI0_CLK_neg,
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
        Violation => tviol_M0_CLK_pos,
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
        Violation => tviol_M0_CLK_neg,
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
        Violation => tviol_CE_CLK_pos,
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
        Violation => tviol_CE_CLK_neg,
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
        Violation => tviol_LSR_CLK_pos,
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
        Violation => tviol_LSR_CLK_neg,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK_CLK,
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
        Violation => tviol_LSR_LSR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    IF (tviol_M0_CLK_pos = 'X' or tviol_M0_CLK_neg = 'X') THEN
        viol_M0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_M0 := '0';
    END IF;
                                                                                
    IF (tviol_M1_CLK_pos = 'X' or tviol_M1_CLK_neg = 'X') THEN
        viol_M1 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_M1 := '0';
    END IF;
                                                                                
    IF (tviol_DI0_CLK_pos = 'X' or tviol_DI0_CLK_neg = 'X') THEN
        viol_DI0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI0 := '0';
    END IF;

    IF (tviol_DI1_CLK_pos = 'X' or tviol_DI1_CLK_neg = 'X') THEN
        viol_DI1 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI1 := '0';
    END IF;
                                                                                
    IF (tviol_CE_CLK_pos = 'X' or tviol_CE_CLK_neg = 'X') THEN
        viol_CE := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CE := '0';
    END IF;
                                                                                
    IF (tviol_LSR_CLK_pos = 'X' or tviol_LSR_CLK_neg = 'X') THEN
        viol_LSR := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_LSR := '0';
    END IF;

    IF (tviol_CLK_CLK = 'X') THEN
        viol_CLK := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CLK := '0';
    END IF;

    IF ((viol_M0 = '0' and viol_DI0 = '0') and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q0_zd := QB0;
    ELSE
        Q0_zd := 'X';
    END IF;
                                                                                
    IF ((viol_M1 = '0' and viol_DI1 = '0') and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q1_zd := QB1;
    ELSE
        Q1_zd := 'X';
    END IF;

    OFX0_zd := COUT0;
    OFX1_zd := COUT1;
    FCO_zd := COUT1;
    F1_zd := S1;
    F0_zd := S0;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => OFX1,
       OutSignalName => "OFX1",
       OutTemp => OFX1_zd,
       Paths => (0 => (InputChangeTime => A1_ipd'last_event,
                       PathDelay => tpd_A1_OFX1,
                       PathCondition => TRUE),
                 1 => (B1_ipd'last_event, tpd_B1_OFX1, PathCondition => TRUE),
                 2 => (A0_ipd'last_event, tpd_A0_OFX1, PathCondition => TRUE),
                 3 => (B0_ipd'last_event, tpd_B0_OFX1, PathCondition => TRUE),
                 4 => (M0_ipd'last_event, tpd_M0_OFX1, PathCondition => TRUE),
                 5 => (FCI_ipd'last_event, tpd_FCI_OFX1, PathCondition => TRUE)),
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
                 1 => (B1_ipd'last_event, tpd_B1_F1, PathCondition => TRUE),
                 2 => (A0_ipd'last_event, tpd_A0_F1, PathCondition => TRUE),
                 3 => (B0_ipd'last_event, tpd_B0_F1, PathCondition => TRUE),
                 4 => (M0_ipd'last_event, tpd_M0_F1, PathCondition => TRUE),
                 5 => (FCI_ipd'last_event, tpd_FCI_F1, PathCondition => TRUE)),
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
                 1 => (B1_ipd'last_event, tpd_B1_OFX0, PathCondition => TRUE),
                 2 => (A0_ipd'last_event, tpd_A0_OFX0, PathCondition => TRUE),
                 3 => (B0_ipd'last_event, tpd_B0_OFX0, PathCondition => TRUE),
                 4 => (M0_ipd'last_event, tpd_M0_OFX0, PathCondition => TRUE),
                 5 => (FCI_ipd'last_event, tpd_FCI_OFX0, PathCondition => TRUE)),
       GlitchData => OFX0_GlitchData,
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
                 2 => (A0_ipd'last_event, tpd_A0_F0, PathCondition => TRUE),
                 3 => (B0_ipd'last_event, tpd_B0_F0, PathCondition => TRUE),
                 4 => (M0_ipd'last_event, tpd_M0_F0, PathCondition => TRUE),
                 5 => (FCI_ipd'last_event, tpd_FCI_F0, PathCondition => TRUE)),
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
                 2 => (A0_ipd'last_event, tpd_A0_FCO, PathCondition => TRUE),
                 3 => (B0_ipd'last_event, tpd_B0_FCO, PathCondition => TRUE),
                 4 => (M0_ipd'last_event, tpd_M0_FCO, PathCondition => TRUE),
                 5 => (FCI_ipd'last_event, tpd_FCI_FCO, PathCondition => TRUE)),
       GlitchData => FCO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q1,
       OutSignalName => "Q1",
       OutTemp => Q1_zd,
       Paths => (0 => (InputChangeTime => clk_dly'last_event,
                       PathDelay => tpd_clk_Q1,
                       PathCondition => TRUE),
                 1 => (LSR_dly'last_event, tpd_LSR_Q1, PathCondition => TRUE)),
       GlitchData => Q1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Q0,
       OutSignalName => "Q0",
       OutTemp => Q0_zd,
       Paths => (0 => (InputChangeTime => clk_dly'last_event,
                       PathDelay => tpd_clk_Q0,
                       PathCondition => TRUE),
                 1 => (LSR_dly'last_event, tpd_LSR_Q0, PathCondition => TRUE)),
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
ENTITY SSPRAMA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SSPRAMA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        INITVAL         : string := "0x0000000000000000";
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_AD0       : boolean := FALSE;
        check_AD1       : boolean := FALSE;
        check_AD2       : boolean := FALSE;
        check_AD3       : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE;

        -- input SIGNAL delays
        tipd_AD0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_AD1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_AD2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_AD3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_M1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLK_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD0_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD1_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD2_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD3_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CE_F0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD0_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD1_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD2_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_AD3_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CE_F1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_F1     : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLK          : VitalDelayType := 0 ns;
        tisd_M1_CLK      : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_AD0_CLK      : VitalDelayType := 0 ns;
        tisd_AD1_CLK      : VitalDelayType := 0 ns;
        tisd_AD2_CLK      : VitalDelayType := 0 ns;
        tisd_AD3_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK      : VitalDelayType := 0 ns;
        tisd_DI0_CLK      : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK      : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_AD0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_AD1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_AD2_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_AD3_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_AD0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_AD1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_AD2_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_AD3_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_AD0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_AD1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_AD2_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_AD3_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_AD0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_AD1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_AD2_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_AD3_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        M0, M1, AD0, AD1, AD2, AD3, DI0, DI1, CE, CLK, LSR         : in std_ulogic := 'X';
        F1, Q1, F0, Q0                                             : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SSPRAMA : ENTITY IS TRUE;

END SSPRAMA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SSPRAMA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal M1_ipd       : std_logic := 'X';
    signal M1_dly       : std_logic := 'X';
    signal AD0_ipd       : std_logic := 'X';
    signal AD0_dly       : std_logic := 'X';
    signal AD1_ipd       : std_logic := 'X';
    signal AD1_dly       : std_logic := 'X';
    signal AD2_ipd       : std_logic := 'X';
    signal AD2_dly       : std_logic := 'X';
    signal AD3_ipd       : std_logic := 'X';
    signal AD3_dly       : std_logic := 'X';
    signal DI1_ipd       : std_logic := 'X';
    signal DI1_dly       : std_logic := 'X';
    signal DI0_ipd       : std_logic := 'X';
    signal DI0_dly       : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal M0_dly       : std_logic := 'X';
    signal CE_ipd       : std_logic := 'X';
    signal CE_dly       : std_logic := 'X';
    signal CLK_ipd       : std_logic := 'X';
    signal CLK_dly       : std_logic := 'X';
    signal LSR_ipd       : std_logic := 'X';
    signal LSR_dly       : std_logic := 'X';
    signal CE_sig       : std_logic := 'X';
    signal LSR_sig       : std_logic := 'X';
    signal CLK_sig       : std_logic := 'X';
    signal CLK_sig0       : std_logic := 'X';
    signal CLK_sig1       : std_logic := 'X';
    signal posedge_clk       : std_logic := '0';
    signal negedge_clk       : std_logic := '0';
    signal QB0       : std_logic := 'X';
    signal QB1       : std_logic := 'X';
    signal DO0       : std_logic := 'X';
    signal DO1       : std_logic := 'X';

    BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(M1_ipd, M1, tipd_M1);
      VitalWireDelay(M0_ipd, M0, tipd_M0);
      VitalWireDelay(CE_ipd, CE, tipd_CE);
      VitalWireDelay(LSR_ipd, LSR, tipd_LSR);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
      VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
      VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
      VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(M1_dly, M1_ipd, tisd_M1_CLK);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLK);
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLK);
      VitalSignalDelay(M0_dly, M0_ipd, tisd_M0_CLK);
      VitalSignalDelay(AD0_dly, AD0_ipd, tisd_AD0_CLK);
      VitalSignalDelay(AD1_dly, AD1_ipd, tisd_AD1_CLK);
      VitalSignalDelay(AD2_dly, AD2_ipd, tisd_AD2_CLK);
      VitalSignalDelay(AD3_dly, AD3_ipd, tisd_AD3_CLK);
      VitalSignalDelay(CE_dly, CE_ipd, tisd_CE_CLK);
      VitalSignalDelay(LSR_dly, LSR_ipd, tisd_LSR_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
    END BLOCK;

    P11 : PROCESS (LSR_dly, CE_dly, CLK_dly)
    BEGIN
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

    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    CLK_sig0 <= transport CLK_sig after CLK_BOOST0;
    CLK_sig1 <= transport CLK_sig after CLK_BOOST1;

    SPR16X2_INST : SPR16X2 
                 generic map (gsr => gsr,
                              initval => initval)
                 port map (di0 => M0_dly, di1 => M1_dly, ck => CLK_sig0, wre => CE_sig,
                           wpe => LSR_sig, ad0 => AD0_dly, ad1 => AD1_dly, ad2 => AD2_dly,
                           ad3 => AD3_dly, do0 => DO0, do1 => DO1);

    GFF9 : if (REGMODE = "FF") generate
       GFF10 : if (REG0_REGSET = "RESET") generate
              fd1p3dx_inst : fd1p3dx
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, sp => '1', cd => '0', q => QB0);
       end generate GFF10;
       GFF11 : if (REG0_REGSET = "SET") generate
              fd1p3bx_inst : fd1p3bx
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, sp => '1', pd => '0', q => QB0);
       end generate GFF11;


       GFF12 : if (REG1_REGSET = "RESET") generate
              fd1p3dx_inst : fd1p3dx
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, sp => '1', cd => '0', q => QB1);
       end generate GFF12;
       GFF13 : if (REG1_REGSET = "SET") generate
              fd1p3bx_inst : fd1p3bx
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, sp => '1', pd => '0', q => QB1);
       end generate GFF13;
    end generate GFF9;

    GLATCH1 : if (REGMODE = "LATCH") generate
       GFF14 : if (REG0_REGSET = "RESET") generate
              fd1s1d_inst : fd1s1d
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, cd => '0', q => QB0);
       end generate GFF14;
       GFF15 : if (REG0_REGSET = "SET") generate
              fd1s1b_inst : fd1s1b
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, pd => '0', q => QB0);
       end generate GFF15;

       GFF16 : if (REG1_REGSET = "RESET") generate
              fd1s1d_inst : fd1s1d
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, cd => '0', q => QB1);
       end generate GFF16;
       GFF17 : if (REG1_REGSET = "SET") generate
              fd1s1b_inst : fd1s1b
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, pd => '0', q => QB1);
       end generate GFF17;
    end generate GLATCH1;

    VitalBehavior : PROCESS (M1_ipd, M0_ipd, AD0_ipd, AD1_ipd, AD2_ipd, AD3_ipd, CLK_ipd, LSR_ipd, CE_ipd,
    CE_dly, LSR_dly, CLK_dly, M0_dly, M1_dly, DI1_dly, DI0_dly, DI0_ipd, DI1_ipd, QB0, QB1, DO0, DO1)

    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_M1_CLK_pos              : x01 := '0';
    VARIABLE tviol_M1_CLK_neg              : x01 := '0';
    VARIABLE M1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI1_CLK_neg              : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI0_CLK_neg              : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_M0_CLK_pos              : x01 := '0';
    VARIABLE tviol_M0_CLK_neg              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CE_CLK_pos              : x01 := '0';
    VARIABLE tviol_CE_CLK_neg              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK_pos              : x01 := '0';
    VARIABLE tviol_LSR_CLK_neg              : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_AD0_CLK_pos              : x01 := '0';
    VARIABLE tviol_AD0_CLK_neg              : x01 := '0';
    VARIABLE AD0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_AD1_CLK_pos              : x01 := '0';
    VARIABLE tviol_AD1_CLK_neg              : x01 := '0';
    VARIABLE AD1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_AD2_CLK_pos              : x01 := '0';
    VARIABLE tviol_AD2_CLK_neg              : x01 := '0';
    VARIABLE AD2_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_AD3_CLK_pos              : x01 := '0';
    VARIABLE tviol_AD3_CLK_neg              : x01 := '0';
    VARIABLE AD3_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CLK_CLK              : x01 := '0';
    VARIABLE periodcheckinfo_CLK        : VitalPeriodDataType;
    VARIABLE viol_M1                   : x01 := '0';
    VARIABLE viol_DI1                  : x01 := '0';
    VARIABLE viol_DI0                  : x01 := '0';
    VARIABLE viol_M0                   : x01 := '0';
    VARIABLE viol_CE                   : x01 := '0';
    VARIABLE viol_LSR                  : x01 := '0';
    VARIABLE viol_CLK                  : x01 := '0';

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
        CheckEnabled => ((posedge_clk = '1') and check_m1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK_pos,
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
        CheckEnabled => ((negedge_clk = '1') and check_m1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M1_CLK_TimingDatash,
        Violation => tviol_M1_CLK_neg,
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
        Violation => tviol_DI1_CLK_pos,
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
        Violation => tviol_DI1_CLK_neg,
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
        Violation => tviol_DI0_CLK_pos,
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
        Violation => tviol_DI0_CLK_neg,
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
        Violation => tviol_M0_CLK_pos,
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
        Violation => tviol_M0_CLK_neg,
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
        Violation => tviol_CE_CLK_pos,
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
        Violation => tviol_CE_CLK_neg,
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
        Violation => tviol_LSR_CLK_pos,
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
        Violation => tviol_LSR_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => AD0_dly,
        TestSignalName => "AD0",
        TestDelay => tisd_AD0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD0_CLK_noedge_posedge,
        SetupLow => tsetup_AD0_CLK_noedge_posedge,
        HoldHigh => thold_AD0_CLK_noedge_posedge,
        HoldLow => thold_AD0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_AD0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD0_CLK_TimingDatash,
        Violation => tviol_AD0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => AD0_dly,
        TestSignalName => "AD0",
        TestDelay => tisd_AD0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD0_CLK_noedge_negedge,
        SetupLow => tsetup_AD0_CLK_noedge_negedge,
        HoldHigh => thold_AD0_CLK_noedge_negedge,
        HoldLow => thold_AD0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_AD0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD0_CLK_TimingDatash,
        Violation => tviol_AD0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => AD1_dly,
        TestSignalName => "AD1",
        TestDelay => tisd_AD1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD1_CLK_noedge_posedge,
        SetupLow => tsetup_AD1_CLK_noedge_posedge,
        HoldHigh => thold_AD1_CLK_noedge_posedge,
        HoldLow => thold_AD1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_AD1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD1_CLK_TimingDatash,
        Violation => tviol_AD1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => AD1_dly,
        TestSignalName => "AD1",
        TestDelay => tisd_AD1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD1_CLK_noedge_negedge,
        SetupLow => tsetup_AD1_CLK_noedge_negedge,
        HoldHigh => thold_AD1_CLK_noedge_negedge,
        HoldLow => thold_AD1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_AD1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD1_CLK_TimingDatash,
        Violation => tviol_AD1_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => AD2_dly,
        TestSignalName => "AD2",
        TestDelay => tisd_AD2_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD2_CLK_noedge_posedge,
        SetupLow => tsetup_AD2_CLK_noedge_posedge,
        HoldHigh => thold_AD2_CLK_noedge_posedge,
        HoldLow => thold_AD2_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_AD2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD2_CLK_TimingDatash,
        Violation => tviol_AD2_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => AD2_dly,
        TestSignalName => "AD2",
        TestDelay => tisd_AD2_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD2_CLK_noedge_negedge,
        SetupLow => tsetup_AD2_CLK_noedge_negedge,
        HoldHigh => thold_AD2_CLK_noedge_negedge,
        HoldLow => thold_AD2_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_AD2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD2_CLK_TimingDatash,
        Violation => tviol_AD2_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => AD3_dly,
        TestSignalName => "AD3",
        TestDelay => tisd_AD3_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD3_CLK_noedge_posedge,
        SetupLow => tsetup_AD3_CLK_noedge_posedge,
        HoldHigh => thold_AD3_CLK_noedge_posedge,
        HoldLow => thold_AD3_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_AD3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD3_CLK_TimingDatash,
        Violation => tviol_AD3_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => AD3_dly,
        TestSignalName => "AD3",
        TestDelay => tisd_AD3_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_AD3_CLK_noedge_negedge,
        SetupLow => tsetup_AD3_CLK_noedge_negedge,
        HoldHigh => thold_AD3_CLK_noedge_negedge,
        HoldLow => thold_AD3_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_AD3),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => AD3_CLK_TimingDatash,
        Violation => tviol_AD3_CLK_neg,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK_CLK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    IF (tviol_M0_CLK_pos = 'X' or tviol_M0_CLK_neg = 'X') THEN
        viol_M0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_M0 := '0';
    END IF;
                                                                                
    IF (tviol_M1_CLK_pos = 'X' or tviol_M1_CLK_neg = 'X') THEN
        viol_M1 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_M1 := '0';
    END IF;
                                                                                
    IF (tviol_DI0_CLK_pos = 'X' or tviol_DI0_CLK_neg = 'X') THEN
        viol_DI0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI0 := '0';
    END IF;
                                                                                
    IF (tviol_DI1_CLK_pos = 'X' or tviol_DI1_CLK_neg = 'X') THEN
        viol_DI1 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI1 := '0';
    END IF;
                                                                                
    IF (tviol_CE_CLK_pos = 'X' or tviol_CE_CLK_neg = 'X') THEN
        viol_CE := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CE := '0';
    END IF;
                                                                                
    IF (tviol_LSR_CLK_pos = 'X' or tviol_LSR_CLK_neg = 'X') THEN
        viol_LSR := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_LSR := '0';
    END IF;
                                                                                
    IF (tviol_CLK_CLK = 'X') THEN
        viol_CLK := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CLK := '0';
    END IF;
                                                                                
    IF (viol_DI0 = '0' and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q0_zd := QB0;
    ELSE
        Q0_zd := 'X';
    END IF;
                                                                                
    IF (viol_DI1 = '0' and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q1_zd := QB1;
    ELSE
        Q1_zd := 'X';
    END IF;

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
                       PathCondition => TRUE)),
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
                       PathCondition => TRUE)),
       GlitchData => Q0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F1,
       OutSignalName => "F1",
       OutTemp => F1_zd,
       Paths => (0 => (InputChangeTime => AD0_ipd'last_event,
                       PathDelay => tpd_AD0_F1,
                       PathCondition => TRUE),
                 1 => (AD1_ipd'last_event, tpd_AD1_F1, PathCondition => TRUE),
                 2 => (AD2_ipd'last_event, tpd_AD2_F1, PathCondition => TRUE),
                 3 => (AD3_ipd'last_event, tpd_AD3_F1, PathCondition => TRUE),
                 4 => (CE_ipd'last_event, tpd_CE_F1, PathCondition => TRUE),
                 5 => (LSR_ipd'last_event, tpd_LSR_F1, PathCondition => TRUE),
                 6 => (CLK_ipd'last_event, tpd_CLK_F1, PathCondition => TRUE)),
       GlitchData => F1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => F0,
       OutSignalName => "F0",
       OutTemp => F0_zd,
       Paths => (0 => (InputChangeTime => AD0_ipd'last_event,
                       PathDelay => tpd_AD0_F0,
                       PathCondition => TRUE),
                 1 => (AD1_ipd'last_event, tpd_AD1_F0, PathCondition => TRUE),
                 2 => (AD2_ipd'last_event, tpd_AD2_F0, PathCondition => TRUE),
                 3 => (AD3_ipd'last_event, tpd_AD3_F0, PathCondition => TRUE),
                 4 => (CE_ipd'last_event, tpd_CE_F0, PathCondition => TRUE),
                 5 => (LSR_ipd'last_event, tpd_LSR_F0, PathCondition => TRUE),
                 6 => (CLK_ipd'last_event, tpd_CLK_F0, PathCondition => TRUE)),
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
ENTITY SDPRAMA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SDPRAMA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLK2MUX         : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        WCLKMUX         : string := "CLKMUX";      -- "CLKMUX", "CLK2MUX"
        RCLKMUX         : string := "CLK2MUX";      -- "CLKMUX", "CLK2MUX"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        INITVAL         : string := "0x0000000000000000";
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        check_M0        : boolean := FALSE;
        check_DPI       : boolean := FALSE;
        check_A0        : boolean := FALSE;
        check_B0        : boolean := FALSE;
        check_C0        : boolean := FALSE;
        check_D0        : boolean := FALSE;
        check_A1        : boolean := FALSE;
        check_B1        : boolean := FALSE;
        check_C1        : boolean := FALSE;
        check_D1        : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE;

        -- input SIGNAL delays
        tipd_M0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DPI  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_A1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_B1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_C1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_D1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLK2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_LSR : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLK_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK2_Q1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK2_Q0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A0_F0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B0_F0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C0_F0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D0_F0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_A1_F1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_B1_F1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_C1_F1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_D1_F1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CE_F0      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK2_F0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CE_F1      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_LSR_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLK2_F1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_DPI_DPO    : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLK          : VitalDelayType := 0 ns;
        ticd_CLK2          : VitalDelayType := 0 ns;
        tisd_M0_CLK      : VitalDelayType := 0 ns;
        tisd_A0_CLK      : VitalDelayType := 0 ns;
        tisd_B0_CLK      : VitalDelayType := 0 ns;
        tisd_C0_CLK      : VitalDelayType := 0 ns;
        tisd_D0_CLK      : VitalDelayType := 0 ns;
        tisd_A1_CLK      : VitalDelayType := 0 ns;
        tisd_B1_CLK      : VitalDelayType := 0 ns;
        tisd_C1_CLK      : VitalDelayType := 0 ns;
        tisd_D1_CLK      : VitalDelayType := 0 ns;
        tisd_DI1_CLK      : VitalDelayType := 0 ns;
        tisd_DI0_CLK      : VitalDelayType := 0 ns;
        tisd_CE_CLK      : VitalDelayType := 0 ns;
        tisd_LSR_CLK      : VitalDelayType := 0 ns;
        tisd_DPI_CLK      : VitalDelayType := 0 ns;
        tisd_M0_CLK2      : VitalDelayType := 0 ns;
        tisd_A0_CLK2      : VitalDelayType := 0 ns;
        tisd_B0_CLK2      : VitalDelayType := 0 ns;
        tisd_C0_CLK2      : VitalDelayType := 0 ns;
        tisd_D0_CLK2      : VitalDelayType := 0 ns;
        tisd_A1_CLK2      : VitalDelayType := 0 ns;
        tisd_B1_CLK2      : VitalDelayType := 0 ns;
        tisd_C1_CLK2      : VitalDelayType := 0 ns;
        tisd_D1_CLK2      : VitalDelayType := 0 ns;
        tisd_DI1_CLK2      : VitalDelayType := 0 ns;
        tisd_DI0_CLK2      : VitalDelayType := 0 ns;
        tisd_CE_CLK2      : VitalDelayType := 0 ns;
        tisd_LSR_CLK2      : VitalDelayType := 0 ns;
        tisd_DPI_CLK2      : VitalDelayType := 0 ns;

        tsetup_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_A0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_B0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_C0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_D0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_A1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_B1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_C1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_D1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DPI_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_A0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_B0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_C0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_D0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_A1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_B1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_C1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_D1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DPI_CLK_noedge_posedge     : VitalDelayType := 0 ns;

        tsetup_M0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_A0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_B0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_C0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_D0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_A1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_B1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_C1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_D1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DPI_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_M0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_A0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_B0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_C0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_D0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_A1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_B1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_C1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_D1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CE_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK2_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DPI_CLK2_noedge_posedge     : VitalDelayType := 0 ns;

        tsetup_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_A0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_B0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_C0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_D0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_A1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_B1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_C1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_D1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DPI_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_A0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_B0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_C0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_D0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_A1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_B1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_C1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_D1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CE_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DPI_CLK_noedge_negedge     : VitalDelayType := 0 ns;

        tsetup_M0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_A0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_B0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_C0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_D0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_A1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_B1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_C1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_D1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CE_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_LSR_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DPI_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_M0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_A0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_B0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_C0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_D0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_A1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_B1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_C1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_D1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI1_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI0_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CE_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_LSR_CLK2_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DPI_CLK2_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_CLK            : VitalDelayType := 0.001 ns;
        tpw_CLK_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLK2           : VitalDelayType := 0.001 ns;
        tpw_CLK2_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLK2_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        M0, DPI, A0, B0, C0, D0, A1, B1, C1, D1, DI0, DI1, CE, CLK, CLK2, LSR         : in std_ulogic := 'X';
        F1, Q1, F0, Q0, DPO                                             : out std_ulogic := 'X'
        );
      ATTRIBUTE Vital_Level0 OF SDPRAMA : ENTITY IS TRUE;

END SDPRAMA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SDPRAMA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal DPI_ipd       : std_logic := 'X';
    signal DPI_dly       : std_logic := 'X';
    signal M0_ipd       : std_logic := 'X';
    signal M0_dly       : std_logic := 'X';
    signal A0_ipd       : std_logic := 'X';
    signal A0_dly       : std_logic := 'X';
    signal B0_ipd       : std_logic := 'X';
    signal B0_dly       : std_logic := 'X';
    signal C0_ipd       : std_logic := 'X';
    signal C0_dly       : std_logic := 'X';
    signal D0_ipd       : std_logic := 'X';
    signal D0_dly       : std_logic := 'X';
    signal A1_ipd       : std_logic := 'X';
    signal A1_dly       : std_logic := 'X';
    signal B1_ipd       : std_logic := 'X';
    signal B1_dly       : std_logic := 'X';
    signal C1_ipd       : std_logic := 'X';
    signal C1_dly       : std_logic := 'X';
    signal D1_ipd       : std_logic := 'X';
    signal D1_dly       : std_logic := 'X';
    signal CE_ipd       : std_logic := 'X';
    signal CE_dly       : std_logic := 'X';
    signal CLK_ipd       : std_logic := 'X';
    signal CLK_dly       : std_logic := 'X';
    signal CLK2_ipd       : std_logic := 'X';
    signal CLK2_dly       : std_logic := 'X';
    signal LSR_ipd       : std_logic := 'X';
    signal LSR_dly       : std_logic := 'X';
    signal DI1_ipd       : std_logic := 'X';
    signal DI1_dly       : std_logic := 'X';
    signal DI0_ipd       : std_logic := 'X';
    signal DI0_dly       : std_logic := 'X';
    signal CE_sig       : std_logic := 'X';
    signal LSR_sig       : std_logic := 'X';
    signal CLK_sig       : std_logic := 'X';
    signal CLK2_sig       : std_logic := 'X';
    signal CLK_sig0       : std_logic := 'X';
    signal CLK_sig1       : std_logic := 'X';
    signal posedge_clk       : std_logic := '0';
    signal negedge_clk       : std_logic := '0';
    signal posedge_clk2       : std_logic := '0';
    signal negedge_clk2       : std_logic := '0';
    signal QB0       : std_logic := 'X';
    signal QB1       : std_logic := 'X';
    signal DO0       : std_logic := 'X';
    signal DO1       : std_logic := 'X';
    signal CLK_sig_new       : std_logic := 'X';
    signal CLK2_sig_new       : std_logic := 'X';


    BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(DPI_ipd, DPI, tipd_DPI);
      VitalWireDelay(M0_ipd, M0, tipd_M0);
      VitalWireDelay(CE_ipd, CE, tipd_CE);
      VitalWireDelay(LSR_ipd, LSR, tipd_LSR);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
      VitalWireDelay(CLK2_ipd, CLK2, tipd_CLK2);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(A0_ipd, A0, tipd_A0);
      VitalWireDelay(B0_ipd, B0, tipd_B0);
      VitalWireDelay(C0_ipd, C0, tipd_C0);
      VitalWireDelay(D0_ipd, D0, tipd_D0);
      VitalWireDelay(A1_ipd, A1, tipd_A1);
      VitalWireDelay(B1_ipd, B1, tipd_B1);
      VitalWireDelay(C1_ipd, C1, tipd_C1);
      VitalWireDelay(D1_ipd, D1, tipd_D1);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(M0_dly, M0_ipd, tisd_M0_CLK);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLK);
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLK);
      VitalSignalDelay(CE_dly, CE_ipd, tisd_CE_CLK);
      VitalSignalDelay(LSR_dly, LSR_ipd, tisd_LSR_CLK);
      VitalSignalDelay(DPI_dly, DPI_ipd, tisd_DPI_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
      VitalSignalDelay(CLK2_dly, CLK2_ipd, ticd_CLK2);
      VitalSignalDelay(A0_dly, A0_ipd, tisd_A0_CLK);
      VitalSignalDelay(B0_dly, B0_ipd, tisd_B0_CLK);
      VitalSignalDelay(C0_dly, C0_ipd, tisd_C0_CLK);
      VitalSignalDelay(D0_dly, D0_ipd, tisd_D0_CLK);
      VitalSignalDelay(A1_dly, A1_ipd, tisd_A1_CLK);
      VitalSignalDelay(B1_dly, B1_ipd, tisd_B1_CLK);
      VitalSignalDelay(C1_dly, C1_ipd, tisd_C1_CLK);
      VitalSignalDelay(D1_dly, D1_ipd, tisd_D1_CLK);
    END BLOCK;

    P11 : PROCESS (LSR_dly, CE_dly, CLK_dly, CLK2_dly)
    BEGIN
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

       IF (CLK2MUX = "SIG") THEN
          CLK2_sig <= CLK2_dly;
       ELSIF (CLK2MUX = "INV") THEN
          CLK2_sig <= not CLK2_dly;
       ELSIF (CLK2MUX = "VHI") THEN
          CLK2_sig <= '1';
       ELSE
          CLK2_sig <= '0';
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

    P12 : PROCESS (CLK_sig, CLK2_sig)
    BEGIN
       IF (WCLKMUX = "CLKMUX") THEN
          CLK_sig_new <= CLK_sig;
       ELSIF (WCLKMUX = "CLK2MUX") THEN
          CLK_sig_new <= CLK2_sig;
       END IF;

       IF (RCLKMUX = "CLK2MUX") THEN
          CLK2_sig_new <= CLK2_sig;
       ELSIF (RCLKMUX = "CLKMUX") THEN
          CLK2_sig_new <= CLK_sig;
       END IF;
    END PROCESS;


    posedge_clk <= '1' when (CLKMUX = "SIG") else '0';
    negedge_clk <= '1' when (CLKMUX = "INV") else '0';

    posedge_clk2 <= '1' when (CLK2MUX = "SIG") else '0';
    negedge_clk2 <= '1' when (CLK2MUX = "INV") else '0';

    CLK_sig0 <= transport CLK_sig_new after CLK_BOOST0;
    CLK_sig1 <= transport CLK2_sig_new after CLK_BOOST1;

    DPR16X2_INST : DPR16X2
                 generic map (gsr => gsr,
                              initval => INITVAL)
                 port map (di0 => M0_dly, di1 => '0', wad0 => A0_dly, wad1 => B0_dly,
                           wad2 => C0_dly, wad3 => D0_dly, wre => CE_sig, wpe => LSR_sig,
                           wck => CLK_sig_new, rad0 => A1_dly, rad1 => B1_dly, rad2 => C1_dly,
                           rad3 => D1_dly, wdo0 => DO0, rdo0 => DO1, wdo1 => open, rdo1 => open);


    GFF9 : if (REGMODE = "FF") generate
       GFF10 : if (REG0_REGSET = "RESET") generate
              fd1p3dx_inst : fd1p3dx
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, sp => '1', cd => '0', q => QB0);
       end generate GFF10;
       GFF11 : if (REG0_REGSET = "SET") generate
              fd1p3bx_inst : fd1p3bx
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, sp => '1', pd => '0', q => QB0);
       end generate GFF11;


       GFF12 : if (REG1_REGSET = "RESET") generate
              fd1p3dx_inst : fd1p3dx
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, sp => '1', cd => '0', q => QB1);
       end generate GFF12;
       GFF13 : if (REG1_REGSET = "SET") generate
              fd1p3bx_inst : fd1p3bx
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, sp => '1', pd => '0', q => QB1);
       end generate GFF13;
    end generate GFF9;

    GLATCH1 : if (REGMODE = "LATCH") generate
       GFF14 : if (REG0_REGSET = "RESET") generate
              fd1s1d_inst : fd1s1d
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, cd => '0', q => QB0);
       end generate GFF14;
       GFF15 : if (REG0_REGSET = "SET") generate
              fd1s1b_inst : fd1s1b
                         generic map (gsr => gsr)
                         port map (d => DI0_dly, ck => CLK_sig0, pd => '0', q => QB0);
       end generate GFF15;

       GFF16 : if (REG1_REGSET = "RESET") generate
              fd1s1d_inst : fd1s1d
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, cd => '0', q => QB1);
       end generate GFF16;
       GFF17 : if (REG1_REGSET = "SET") generate
              fd1s1b_inst : fd1s1b
                         generic map (gsr => gsr)
                         port map (d => DI1_dly, ck => CLK_sig1, pd => '0', q => QB1);
       end generate GFF17;
    end generate GLATCH1;

    VitalBehavior : PROCESS (M0_ipd, A0_ipd, B0_ipd, C0_ipd, D0_ipd, A1_ipd, B1_ipd, C1_ipd, D1_ipd, 
    CLK_ipd, CLK2_ipd, LSR_ipd, CE_ipd, CE_dly, LSR_dly, CLK_dly, CLK2_dly, M0_dly, DI1_dly, DI0_dly, DI0_ipd, DI1_ipd, 
    QB0, QB1, DO0, DO1, DPI_ipd, DPI_dly)

    VARIABLE F1_zd              : std_logic := 'X';
    VARIABLE Q1_zd              : std_logic := 'X';
    VARIABLE Q0_zd              : std_logic := 'X';
    VARIABLE F0_zd              : std_logic := 'X';
    VARIABLE DPO_zd              : std_logic := 'X';
    VARIABLE F1_GlitchData      : VitalGlitchDataType;
    VARIABLE Q1_GlitchData      : VitalGlitchDataType;
    VARIABLE F0_GlitchData      : VitalGlitchDataType;
    VARIABLE Q0_GlitchData      : VitalGlitchDataType;
    VARIABLE DPO_GlitchData      : VitalGlitchDataType;

    VARIABLE tviol_M0_CLK_pos              : x01 := '0';
    VARIABLE tviol_M0_CLK_neg              : x01 := '0';
    VARIABLE M0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI1_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI1_CLK_neg              : x01 := '0';
    VARIABLE DI1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DI0_CLK_pos              : x01 := '0';
    VARIABLE tviol_DI0_CLK_neg              : x01 := '0';
    VARIABLE DI0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CE_CLK_pos              : x01 := '0';
    VARIABLE tviol_CE_CLK_neg              : x01 := '0';
    VARIABLE CE_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_LSR_CLK_pos              : x01 := '0';
    VARIABLE tviol_LSR_CLK_neg              : x01 := '0';
    VARIABLE LSR_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_A0_CLK_pos              : x01 := '0';
    VARIABLE tviol_A0_CLK_neg              : x01 := '0';
    VARIABLE A0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_B0_CLK_pos              : x01 := '0';
    VARIABLE tviol_B0_CLK_neg              : x01 := '0';
    VARIABLE B0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_C0_CLK_pos              : x01 := '0';
    VARIABLE tviol_C0_CLK_neg              : x01 := '0';
    VARIABLE C0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_D0_CLK_pos              : x01 := '0';
    VARIABLE tviol_D0_CLK_neg              : x01 := '0';
    VARIABLE D0_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_A1_CLK_pos              : x01 := '0';
    VARIABLE tviol_A1_CLK_neg              : x01 := '0';
    VARIABLE A1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_B1_CLK_pos              : x01 := '0';   
    VARIABLE tviol_B1_CLK_neg              : x01 := '0';   
    VARIABLE B1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_C1_CLK_pos              : x01 := '0';
    VARIABLE tviol_C1_CLK_neg              : x01 := '0';
    VARIABLE C1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_D1_CLK_pos              : x01 := '0';
    VARIABLE tviol_D1_CLK_neg              : x01 := '0';
    VARIABLE D1_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_DPI_CLK_pos              : x01 := '0';
    VARIABLE tviol_DPI_CLK_neg              : x01 := '0';
    VARIABLE DPI_CLK_TimingDatash       : VitalTimingDataType;
    VARIABLE tviol_CLK_CLK              : x01 := '0';
    VARIABLE periodcheckinfo_CLK        : VitalPeriodDataType;
    VARIABLE tviol_CLK2_CLK2              : x01 := '0';
    VARIABLE periodcheckinfo_CLK2        : VitalPeriodDataType;
    VARIABLE viol_DI1                  : x01 := '0';
    VARIABLE viol_DI0                  : x01 := '0';
    VARIABLE viol_M0                   : x01 := '0';
    VARIABLE viol_CE                   : x01 := '0';
    VARIABLE viol_CLK                  : x01 := '0';

  BEGIN

    IF (TimingChecksOn) THEN
     IF (RCLKMUX = "CLKMUX") THEN
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
        Violation => tviol_DI1_CLK_pos,
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
        Violation => tviol_DI1_CLK_neg,
        MsgSeverity => warning);
     ELSIF (RCLKMUX = "CLK2MUX") THEN
      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_DI1_CLK2_noedge_posedge,
        SetupLow => tsetup_DI1_CLK2_noedge_posedge,
        HoldHigh => thold_DI1_CLK2_noedge_posedge,
        HoldLow => thold_DI1_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_DI1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_DI1_CLK2_noedge_negedge,
        SetupLow => tsetup_DI1_CLK2_noedge_negedge,
        HoldHigh => thold_DI1_CLK2_noedge_negedge,
        HoldLow => thold_DI1_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_DI1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLK_TimingDatash,
        Violation => tviol_DI1_CLK_neg,
        MsgSeverity => warning);
     END IF;

     IF (WCLKMUX = "CLKMUX") THEN
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
        Violation => tviol_DI0_CLK_pos,
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
        Violation => tviol_DI0_CLK_neg,
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
        Violation => tviol_M0_CLK_pos,
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
        Violation => tviol_M0_CLK_neg,
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
        Violation => tviol_CE_CLK_pos,
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
        Violation => tviol_CE_CLK_neg,
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
        Violation => tviol_LSR_CLK_pos,
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
        Violation => tviol_LSR_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DPI_dly,
        TestSignalName => "DPI",
        TestDelay => tisd_DPI_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DPI_CLK_noedge_posedge,
        SetupLow => tsetup_DPI_CLK_noedge_posedge,
        HoldHigh => thold_DPI_CLK_noedge_posedge,
        HoldLow => thold_DPI_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_DPI),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DPI_CLK_TimingDatash,
        Violation => tviol_DPI_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DPI_dly,
        TestSignalName => "DPI",
        TestDelay => tisd_DPI_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DPI_CLK_noedge_negedge,
        SetupLow => tsetup_DPI_CLK_noedge_negedge,
        HoldHigh => thold_DPI_CLK_noedge_negedge,
        HoldLow => thold_DPI_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_DPI),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DPI_CLK_TimingDatash,
        Violation => tviol_DPI_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => A0_dly,
        TestSignalName => "A0",
        TestDelay => tisd_A0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_A0_CLK_noedge_posedge,
        SetupLow => tsetup_A0_CLK_noedge_posedge,
        HoldHigh => thold_A0_CLK_noedge_posedge,
        HoldLow => thold_A0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_A0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A0_CLK_TimingDatash,
        Violation => tviol_A0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => A0_dly,
        TestSignalName => "A0",
        TestDelay => tisd_A0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_A0_CLK_noedge_negedge,
        SetupLow => tsetup_A0_CLK_noedge_negedge,
        HoldHigh => thold_A0_CLK_noedge_negedge,
        HoldLow => thold_A0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_A0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A0_CLK_TimingDatash,
        Violation => tviol_A0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => D0_dly,
        TestSignalName => "D0",
        TestDelay => tisd_D0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_D0_CLK_noedge_posedge,
        SetupLow => tsetup_D0_CLK_noedge_posedge,
        HoldHigh => thold_D0_CLK_noedge_posedge,
        HoldLow => thold_D0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_D0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D0_CLK_TimingDatash,
        Violation => tviol_D0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => D0_dly,
        TestSignalName => "D0",
        TestDelay => tisd_D0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_D0_CLK_noedge_negedge,
        SetupLow => tsetup_D0_CLK_noedge_negedge,
        HoldHigh => thold_D0_CLK_noedge_negedge,
        HoldLow => thold_D0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_D0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D0_CLK_TimingDatash,
        Violation => tviol_D0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => B0_dly,
        TestSignalName => "B0",
        TestDelay => tisd_B0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_B0_CLK_noedge_posedge,
        SetupLow => tsetup_B0_CLK_noedge_posedge,
        HoldHigh => thold_B0_CLK_noedge_posedge,
        HoldLow => thold_B0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_B0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B0_CLK_TimingDatash,
        Violation => tviol_B0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => B0_dly,
        TestSignalName => "B0",
        TestDelay => tisd_B0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_B0_CLK_noedge_negedge,
        SetupLow => tsetup_B0_CLK_noedge_negedge,
        HoldHigh => thold_B0_CLK_noedge_negedge,
        HoldLow => thold_B0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_B0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B0_CLK_TimingDatash,
        Violation => tviol_B0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => C0_dly,
        TestSignalName => "C0",
        TestDelay => tisd_C0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_C0_CLK_noedge_posedge,
        SetupLow => tsetup_C0_CLK_noedge_posedge,
        HoldHigh => thold_C0_CLK_noedge_posedge,
        HoldLow => thold_C0_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_C0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C0_CLK_TimingDatash,
        Violation => tviol_C0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => C0_dly,
        TestSignalName => "C0",
        TestDelay => tisd_C0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_C0_CLK_noedge_negedge,
        SetupLow => tsetup_C0_CLK_noedge_negedge,
        HoldHigh => thold_C0_CLK_noedge_negedge,
        HoldLow => thold_C0_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_C0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C0_CLK_TimingDatash,
        Violation => tviol_C0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => A1_dly,
        TestSignalName => "A1",
        TestDelay => tisd_A1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_A1_CLK_noedge_posedge,
        SetupLow => tsetup_A1_CLK_noedge_posedge,
        HoldHigh => thold_A1_CLK_noedge_posedge,
        HoldLow => thold_A1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_A1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A1_CLK_TimingDatash,
        Violation => tviol_A1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => A1_dly,
        TestSignalName => "A1",
        TestDelay => tisd_A1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_A1_CLK_noedge_negedge,
        SetupLow => tsetup_A1_CLK_noedge_negedge,
        HoldHigh => thold_A1_CLK_noedge_negedge,
        HoldLow => thold_A1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_A1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A1_CLK_TimingDatash,
        Violation => tviol_A1_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => D1_dly,
        TestSignalName => "D1",
        TestDelay => tisd_D1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_D1_CLK_noedge_posedge,
        SetupLow => tsetup_D1_CLK_noedge_posedge,
        HoldHigh => thold_D1_CLK_noedge_posedge,
        HoldLow => thold_D1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_D1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D1_CLK_TimingDatash,
        Violation => tviol_D1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => D1_dly,
        TestSignalName => "D1",
        TestDelay => tisd_D1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_D1_CLK_noedge_negedge,
        SetupLow => tsetup_D1_CLK_noedge_negedge,
        HoldHigh => thold_D1_CLK_noedge_negedge,
        HoldLow => thold_D1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_D1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D1_CLK_TimingDatash,
        Violation => tviol_D1_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => B1_dly,
        TestSignalName => "B1",
        TestDelay => tisd_B1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_B1_CLK_noedge_posedge,
        SetupLow => tsetup_B1_CLK_noedge_posedge,
        HoldHigh => thold_B1_CLK_noedge_posedge,
        HoldLow => thold_B1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_B1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B1_CLK_TimingDatash,
        Violation => tviol_B1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => B1_dly,
        TestSignalName => "B1",
        TestDelay => tisd_B1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_B1_CLK_noedge_negedge,
        SetupLow => tsetup_B1_CLK_noedge_negedge,
        HoldHigh => thold_B1_CLK_noedge_negedge,
        HoldLow => thold_B1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_B1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B1_CLK_TimingDatash,
        Violation => tviol_B1_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => C1_dly,
        TestSignalName => "C1",
        TestDelay => tisd_C1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_C1_CLK_noedge_posedge,
        SetupLow => tsetup_C1_CLK_noedge_posedge,
        HoldHigh => thold_C1_CLK_noedge_posedge,
        HoldLow => thold_C1_CLK_noedge_posedge,
        CheckEnabled => ((posedge_clk = '1') and check_C1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C1_CLK_TimingDatash,
        Violation => tviol_C1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => C1_dly,
        TestSignalName => "C1",
        TestDelay => tisd_C1_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_C1_CLK_noedge_negedge,
        SetupLow => tsetup_C1_CLK_noedge_negedge,
        HoldHigh => thold_C1_CLK_noedge_negedge,
        HoldLow => thold_C1_CLK_noedge_negedge,
        CheckEnabled => ((negedge_clk = '1') and check_C1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C1_CLK_TimingDatash,
        Violation => tviol_C1_CLK_neg,
        MsgSeverity => warning);
     ELSIF (WCLKMUX = "CLK2MUX") THEN
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_DI0_CLK2_noedge_posedge,
        SetupLow => tsetup_DI0_CLK2_noedge_posedge,
        HoldHigh => thold_DI0_CLK2_noedge_posedge,
        HoldLow => thold_DI0_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_DI0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_DI0_CLK2_noedge_negedge,
        SetupLow => tsetup_DI0_CLK2_noedge_negedge,
        HoldHigh => thold_DI0_CLK2_noedge_negedge,
        HoldLow => thold_DI0_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_DI0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLK_TimingDatash,
        Violation => tviol_DI0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_M0_CLK2_noedge_posedge,
        SetupLow => tsetup_M0_CLK2_noedge_posedge,
        HoldHigh => thold_M0_CLK2_noedge_posedge,
        HoldLow => thold_M0_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_M0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => M0_dly,
        TestSignalName => "M0",
        TestDelay => tisd_M0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_M0_CLK2_noedge_negedge,
        SetupLow => tsetup_M0_CLK2_noedge_negedge,
        HoldHigh => thold_M0_CLK2_noedge_negedge,
        HoldLow => thold_M0_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_M0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => M0_CLK_TimingDatash,
        Violation => tviol_M0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_CE_CLK2_noedge_posedge,
        SetupLow => tsetup_CE_CLK2_noedge_posedge,
        HoldHigh => thold_CE_CLK2_noedge_posedge,
        HoldLow => thold_CE_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_CE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_CE_CLK2_noedge_negedge,
        SetupLow => tsetup_CE_CLK2_noedge_negedge,
        HoldHigh => thold_CE_CLK2_noedge_negedge,
        HoldLow => thold_CE_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_CE),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_LSR_CLK2_noedge_posedge,
        SetupLow => tsetup_LSR_CLK2_noedge_posedge,
        HoldHigh => thold_LSR_CLK2_noedge_posedge,
        HoldLow => thold_LSR_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_LSR),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => LSR_dly,
        TestSignalName => "LSR",
        TestDelay => tisd_LSR_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_LSR_CLK2_noedge_negedge,
        SetupLow => tsetup_LSR_CLK2_noedge_negedge,
        HoldHigh => thold_LSR_CLK2_noedge_negedge,
        HoldLow => thold_LSR_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_LSR),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => LSR_CLK_TimingDatash,
        Violation => tviol_LSR_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DPI_dly,
        TestSignalName => "DPI",
        TestDelay => tisd_DPI_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_DPI_CLK2_noedge_posedge,
        SetupLow => tsetup_DPI_CLK2_noedge_posedge,
        HoldHigh => thold_DPI_CLK2_noedge_posedge,
        HoldLow => thold_DPI_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_DPI),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DPI_CLK_TimingDatash,
        Violation => tviol_DPI_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DPI_dly,
        TestSignalName => "DPI",
        TestDelay => tisd_DPI_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_DPI_CLK2_noedge_negedge,
        SetupLow => tsetup_DPI_CLK2_noedge_negedge,
        HoldHigh => thold_DPI_CLK2_noedge_negedge,
        HoldLow => thold_DPI_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_DPI),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DPI_CLK_TimingDatash,
        Violation => tviol_DPI_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => A0_dly,
        TestSignalName => "A0",
        TestDelay => tisd_A0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_A0_CLK2_noedge_posedge,
        SetupLow => tsetup_A0_CLK2_noedge_posedge,
        HoldHigh => thold_A0_CLK2_noedge_posedge,
        HoldLow => thold_A0_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_A0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A0_CLK_TimingDatash,
        Violation => tviol_A0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => A0_dly,
        TestSignalName => "A0",
        TestDelay => tisd_A0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_A0_CLK2_noedge_negedge,
        SetupLow => tsetup_A0_CLK2_noedge_negedge,
        HoldHigh => thold_A0_CLK2_noedge_negedge,
        HoldLow => thold_A0_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_A0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A0_CLK_TimingDatash,
        Violation => tviol_A0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => D0_dly,
        TestSignalName => "D0",
        TestDelay => tisd_D0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_D0_CLK2_noedge_posedge,
        SetupLow => tsetup_D0_CLK2_noedge_posedge,
        HoldHigh => thold_D0_CLK2_noedge_posedge,
        HoldLow => thold_D0_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_D0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D0_CLK_TimingDatash,
        Violation => tviol_D0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => D0_dly,
        TestSignalName => "D0",
        TestDelay => tisd_D0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_D0_CLK2_noedge_negedge,
        SetupLow => tsetup_D0_CLK2_noedge_negedge,
        HoldHigh => thold_D0_CLK2_noedge_negedge,
        HoldLow => thold_D0_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_D0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D0_CLK_TimingDatash,
        Violation => tviol_D0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => B0_dly,
        TestSignalName => "B0",
        TestDelay => tisd_B0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_B0_CLK2_noedge_posedge,
        SetupLow => tsetup_B0_CLK2_noedge_posedge,
        HoldHigh => thold_B0_CLK2_noedge_posedge,
        HoldLow => thold_B0_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_B0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B0_CLK_TimingDatash,
        Violation => tviol_B0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => B0_dly,
        TestSignalName => "B0",
        TestDelay => tisd_B0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_B0_CLK2_noedge_negedge,
        SetupLow => tsetup_B0_CLK2_noedge_negedge,
        HoldHigh => thold_B0_CLK2_noedge_negedge,
        HoldLow => thold_B0_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_B0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B0_CLK_TimingDatash,
        Violation => tviol_B0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => C0_dly,
        TestSignalName => "C0",
        TestDelay => tisd_C0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_C0_CLK2_noedge_posedge,
        SetupLow => tsetup_C0_CLK2_noedge_posedge,
        HoldHigh => thold_C0_CLK2_noedge_posedge,
        HoldLow => thold_C0_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_C0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C0_CLK_TimingDatash,
        Violation => tviol_C0_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => C0_dly,
        TestSignalName => "C0",
        TestDelay => tisd_C0_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_C0_CLK2_noedge_negedge,
        SetupLow => tsetup_C0_CLK2_noedge_negedge,
        HoldHigh => thold_C0_CLK2_noedge_negedge,
        HoldLow => thold_C0_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_C0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C0_CLK_TimingDatash,
        Violation => tviol_C0_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => A1_dly,
        TestSignalName => "A1",
        TestDelay => tisd_A1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_A1_CLK2_noedge_posedge,
        SetupLow => tsetup_A1_CLK2_noedge_posedge,
        HoldHigh => thold_A1_CLK2_noedge_posedge,
        HoldLow => thold_A1_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_A1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A1_CLK_TimingDatash,
        Violation => tviol_A1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => A1_dly,
        TestSignalName => "A1",
        TestDelay => tisd_A1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_A1_CLK2_noedge_negedge,
        SetupLow => tsetup_A1_CLK2_noedge_negedge,
        HoldHigh => thold_A1_CLK2_noedge_negedge,
        HoldLow => thold_A1_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_A1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => A1_CLK_TimingDatash,
        Violation => tviol_A1_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => D1_dly,
        TestSignalName => "D1",
        TestDelay => tisd_D1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_D1_CLK2_noedge_posedge,
        SetupLow => tsetup_D1_CLK2_noedge_posedge,
        HoldHigh => thold_D1_CLK2_noedge_posedge,
        HoldLow => thold_D1_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_D1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D1_CLK_TimingDatash,
        Violation => tviol_D1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => D1_dly,
        TestSignalName => "D1",
        TestDelay => tisd_D1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_D1_CLK2_noedge_negedge,
        SetupLow => tsetup_D1_CLK2_noedge_negedge,
        HoldHigh => thold_D1_CLK2_noedge_negedge,
        HoldLow => thold_D1_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_D1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => D1_CLK_TimingDatash,
        Violation => tviol_D1_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => B1_dly,
        TestSignalName => "B1",
        TestDelay => tisd_B1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_B1_CLK2_noedge_posedge,
        SetupLow => tsetup_B1_CLK2_noedge_posedge,
        HoldHigh => thold_B1_CLK2_noedge_posedge,
        HoldLow => thold_B1_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_B1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B1_CLK_TimingDatash,
        Violation => tviol_B1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => B1_dly,
        TestSignalName => "B1",
        TestDelay => tisd_B1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_B1_CLK2_noedge_negedge,
        SetupLow => tsetup_B1_CLK2_noedge_negedge,
        HoldHigh => thold_B1_CLK2_noedge_negedge,
        HoldLow => thold_B1_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_B1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => B1_CLK_TimingDatash,
        Violation => tviol_B1_CLK_neg,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => C1_dly,
        TestSignalName => "C1",
        TestDelay => tisd_C1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_C1_CLK2_noedge_posedge,
        SetupLow => tsetup_C1_CLK2_noedge_posedge,
        HoldHigh => thold_C1_CLK2_noedge_posedge,
        HoldLow => thold_C1_CLK2_noedge_posedge,
        CheckEnabled => ((posedge_clk2 = '1') and check_C1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C1_CLK_TimingDatash,
        Violation => tviol_C1_CLK_pos,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => C1_dly,
        TestSignalName => "C1",
        TestDelay => tisd_C1_CLK2,
        RefSignal => CLK2_dly,
        RefSignalName => "CLK2",
        RefDelay => ticd_CLK2,
        SetupHigh => tsetup_C1_CLK2_noedge_negedge,
        SetupLow => tsetup_C1_CLK2_noedge_negedge,
        HoldHigh => thold_C1_CLK2_noedge_negedge,
        HoldLow => thold_C1_CLK2_noedge_negedge,
        CheckEnabled => ((negedge_clk2 = '1') and check_C1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => C1_CLK_TimingDatash,
        Violation => tviol_C1_CLK_neg,
        MsgSeverity => warning);
     END IF;

      VitalPeriodPulseCheck (
        TestSignal => CLK_ipd,
        TestSignalName => "CLK",
        Period => tperiod_CLK,
        PulseWidthHigh => tpw_CLK_posedge,
        PulseWidthLow => tpw_CLK_negedge,
        PeriodData => periodcheckinfo_CLK,
        Violation => tviol_CLK_CLK,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
      VitalPeriodPulseCheck (
        TestSignal => CLK2_ipd,
        TestSignalName => "CLK2",
        Period => tperiod_CLK2,
        PulseWidthHigh => tpw_CLK2_posedge,
        PulseWidthLow => tpw_CLK2_negedge,
        PeriodData => periodcheckinfo_CLK2,
        Violation => tviol_CLK2_CLK2,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
    END IF;

    IF (tviol_M0_CLK_pos = 'X' or tviol_M0_CLK_neg = 'X') THEN
        viol_M0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_M0 := '0';
    END IF;
                                                                                
    IF (tviol_DI0_CLK_pos = 'X' or tviol_DI0_CLK_neg = 'X') THEN
        viol_DI0 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI0 := '0';
    END IF;
                                                                                
    IF (tviol_DI1_CLK_pos = 'X' or tviol_DI1_CLK_neg = 'X') THEN
        viol_DI1 := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_DI1 := '0';
    END IF;
                                                                                
    IF (tviol_CE_CLK_pos = 'X' or tviol_CE_CLK_neg = 'X') THEN
        viol_CE := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CE := '0';
    END IF;
                                                                                
    IF (tviol_CLK_CLK = 'X') THEN
        viol_CLK := '1';
    ELSIF ((rising_edge(CLK_dly) and posedge_clk = '1' and CE_dly = '1') or
           (falling_edge(CLK_dly) and posedge_clk = '0' and CE_dly = '1')) THEN
        viol_CLK := '0';
    END IF;
                                                                                
    IF (viol_DI0 = '0' and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q0_zd := QB0;
    ELSE
        Q0_zd := 'X';
    END IF;
                                                                                
    IF (viol_DI1 = '0' and  viol_CE = '0'  and  viol_CLK = '0' ) THEN
        Q1_zd := QB1;
    ELSE
        Q1_zd := 'X';
    END IF;

    F1_zd := DO1;
    F0_zd := DO0;
    DPO_zd := DPI_ipd;

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
                 1 => (clk2_ipd'last_event, tpd_clk2_Q1, PathCondition => TRUE)),
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
                 1 => (clk2_ipd'last_event, tpd_clk2_Q0, PathCondition => TRUE)),
       GlitchData => Q0_GlitchData,
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
                 1 => (B1_ipd'last_event, tpd_B1_F1, PathCondition => TRUE),
                 2 => (C1_ipd'last_event, tpd_C1_F1, PathCondition => TRUE),
                 3 => (D1_ipd'last_event, tpd_D1_F1, PathCondition => TRUE),
                 4 => (CLK_ipd'last_event, tpd_CLK_F1, PathCondition => TRUE),
                 5 => (CLK2_ipd'last_event, tpd_CLK2_F1, PathCondition => TRUE)),
       GlitchData => F1_GlitchData,
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
                 1 => (B0_ipd'last_event, tpd_B0_F0, PathCondition => TRUE),
                 2 => (C0_ipd'last_event, tpd_C0_F0, PathCondition => TRUE),
                 3 => (D0_ipd'last_event, tpd_D0_F0, PathCondition => TRUE),
                 4 => (CLK_ipd'last_event, tpd_CLK_F0, PathCondition => TRUE),
                 5 => (CLK2_ipd'last_event, tpd_CLK2_F0, PathCondition => TRUE)),
       GlitchData => F0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => DPO,
       OutSignalName => "DPO",
       OutTemp => DPO_zd,
       Paths => (0 => (InputChangeTime => DPI_ipd'last_event,
                       PathDelay => tpd_DPI_DPO,
                       PathCondition => TRUE)),
       GlitchData => DPO_GlitchData,
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
ENTITY SBRAMA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SBRAMA";

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

        initval_00 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_01 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_02 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_03 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_04 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_05 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_06 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_07 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_08 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_09 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_10 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_11 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_12 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_13 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_14 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_15 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_16 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_17 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_18 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_19 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_20 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_21 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_22 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_23 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_24 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_25 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_26 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_27 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_28 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_29 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_30 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_31 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_32 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_33 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_34 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_35 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_36 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_37 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_38 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_39 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

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
        tpd_RSTB_DOA0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RSTB_DOA17     : VitalDelayType01 := (0 ns, 0 ns);
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
        CEA, CLKA, WEA, CSA0, CSA1, CSA2, RSTA                         : in std_logic := 'X';
        DIB0, DIB1, DIB2, DIB3, DIB4, DIB5, DIB6, DIB7, DIB8            : in std_logic := 'X';
        DIB9, DIB10, DIB11, DIB12, DIB13, DIB14, DIB15, DIB16, DIB17    : in std_logic := 'X';
        ADB0, ADB1, ADB2, ADB3, ADB4, ADB5, ADB6, ADB7, ADB8            : in std_logic := 'X';
        ADB9, ADB10, ADB11, ADB12, ADB13                                : in std_logic := 'X';
        CEB, CLKB, WEB, CSB0, CSB1, CSB2, RSTB                         : in std_logic := 'X';

        DOA0, DOA1, DOA2, DOA3, DOA4, DOA5, DOA6, DOA7, DOA8            : out std_logic := 'X';
        DOA9, DOA10, DOA11, DOA12, DOA13, DOA14, DOA15, DOA16, DOA17    : out std_logic := 'X';
        DOB0, DOB1, DOB2, DOB3, DOB4, DOB5, DOB6, DOB7, DOB8            : out std_logic := 'X';
        DOB9, DOB10, DOB11, DOB12, DOB13, DOB14, DOB15, DOB16, DOB17    : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF SBRAMA : ENTITY IS TRUE;

END SBRAMA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SBRAMA IS
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

    dp16ka_INST : dp16ka
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
                           CLKA => CLKA_dly,
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
                           CLKB => CLKB_dly,
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA0, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA0, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA1, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA1, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA2, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA2, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA3, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA3, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA4, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA4, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA5, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA5, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA6, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA6, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA7, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA7, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA8, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA8, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA9, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA9, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA10, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA10, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA11, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA11, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA12, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA12, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA13, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA13, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA14, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA14, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA15, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA15, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA16, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA16, PathCondition => TRUE)),
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
                 2 => (RSTA_dly'last_event, tpd_RSTA_DOA17, PathCondition => TRUE),
                 3 => (RSTB_dly'last_event, tpd_RSTB_DOA17, PathCondition => TRUE)),
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
USE work.components.all;

-- entity declaration --
ENTITY SFIFOA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SFIFOA";

        DATA_WIDTH_W               : Integer  := 18;
        DATA_WIDTH_R               : Integer  := 18;
        REGMODE                    : String  := "NOREG";
        RESETMODE                  : String  := "ASYNC";
        CSDECODE_W                 : std_logic_vector(1 downto 0)  := "00";
        CSDECODE_R                 : std_logic_vector(1 downto 0)  := "00";
        AEPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AEPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER                : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER1               : std_logic_vector(14 downto 0)  := "000000000000000";
        GSR                        : String  := "DISABLED";

        CLKW_NEGEDGE    : boolean := FALSE;
        CLKR_NEGEDGE    : boolean := FALSE;

        check_DI0      : boolean := FALSE;
        check_DI1      : boolean := FALSE;
        check_DI2      : boolean := FALSE;
        check_DI3      : boolean := FALSE;
        check_DI4      : boolean := FALSE;
        check_DI5      : boolean := FALSE;
        check_DI6      : boolean := FALSE;
        check_DI7      : boolean := FALSE;
        check_DI8      : boolean := FALSE;
        check_DI9      : boolean := FALSE;
        check_DI10      : boolean := FALSE;
        check_DI11      : boolean := FALSE;
        check_DI12      : boolean := FALSE;
        check_DI13      : boolean := FALSE;
        check_DI14      : boolean := FALSE;
        check_DI15      : boolean := FALSE;
        check_DI16      : boolean := FALSE;
        check_DI17      : boolean := FALSE;
        check_DI18      : boolean := FALSE;
        check_DI19      : boolean := FALSE;
        check_DI20      : boolean := FALSE;
        check_DI21      : boolean := FALSE;
        check_DI22      : boolean := FALSE;
        check_DI23      : boolean := FALSE;
        check_DI24      : boolean := FALSE;
        check_DI25      : boolean := FALSE;
        check_DI26      : boolean := FALSE;
        check_DI27      : boolean := FALSE;
        check_DI28      : boolean := FALSE;
        check_DI29      : boolean := FALSE;
        check_DI30      : boolean := FALSE;
        check_DI31      : boolean := FALSE;
        check_DI32      : boolean := FALSE;
        check_DI33      : boolean := FALSE;
        check_DI34      : boolean := FALSE;
        check_DI35      : boolean := FALSE;
        check_FULLI        : boolean := FALSE;
        check_CSW0        : boolean := FALSE;
        check_CSW1       : boolean := FALSE;
        check_EMPTYI       : boolean := FALSE;
        check_CSR0       : boolean := FALSE;
        check_CSR1       : boolean := FALSE;
        check_WE       : boolean := FALSE;
        check_RE       : boolean := FALSE;
        check_RST       : boolean := FALSE;
        check_RPRST       : boolean := FALSE;

        -- input SIGNAL delays
        tipd_DI0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI10  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI11  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI12  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI13  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI14  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI15  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI16  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI17  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI18  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI19  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI20  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI21  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI22  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI23  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI24  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI25  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI26  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI27  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI28  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI29  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI30  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI31  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI32  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI33  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI34  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_DI35  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_FULLI  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSW0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSW1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_EMPTYI  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSR0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CSR1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_WE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RE  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RST  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_RPRST  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLKW   : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_CLKR   : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- propagation delays
        tpd_CLKR_DO0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO17     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO18     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO19     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO20     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO21     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO22     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO23     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO24     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO25     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO26     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO27     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO28     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO29     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO30     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO31     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO32     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO33     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO34     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_DO35     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO0     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO1     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO2     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO3     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO4     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO5     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO6     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO7     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO8     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO9     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO10     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO11     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO12     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO13     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO14     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO15     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO16     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO17     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO18     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO19     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO20     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO21     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO22     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO23     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO24     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO25     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO26     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO27     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO28     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO29     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO30     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO31     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO32     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO33     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO34     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DO35     : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_EF       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKR_AEF      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKW_FF      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_CLKW_AFF      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RPRST_EF       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RPRST_AEF      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_FF      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_AFF      : VitalDelayType01 := (0 ns, 0 ns);

        -- setup and hold constraints
        ticd_CLKW          : VitalDelayType := 0 ns;
        ticd_CLKR          : VitalDelayType := 0 ns;
        tisd_DI0_CLKW      : VitalDelayType := 0 ns;
        tisd_DI1_CLKW      : VitalDelayType := 0 ns;
        tisd_DI2_CLKW      : VitalDelayType := 0 ns;
        tisd_DI3_CLKW      : VitalDelayType := 0 ns;
        tisd_DI4_CLKW      : VitalDelayType := 0 ns;
        tisd_DI5_CLKW      : VitalDelayType := 0 ns;
        tisd_DI6_CLKW      : VitalDelayType := 0 ns;
        tisd_DI7_CLKW      : VitalDelayType := 0 ns;
        tisd_DI8_CLKW      : VitalDelayType := 0 ns;
        tisd_DI9_CLKW      : VitalDelayType := 0 ns;
        tisd_DI10_CLKW      : VitalDelayType := 0 ns;
        tisd_DI11_CLKW      : VitalDelayType := 0 ns;
        tisd_DI12_CLKW      : VitalDelayType := 0 ns;
        tisd_DI13_CLKW      : VitalDelayType := 0 ns;
        tisd_DI14_CLKW      : VitalDelayType := 0 ns;
        tisd_DI15_CLKW      : VitalDelayType := 0 ns;
        tisd_DI16_CLKW      : VitalDelayType := 0 ns;
        tisd_DI17_CLKW      : VitalDelayType := 0 ns;
        tisd_DI18_CLKW      : VitalDelayType := 0 ns;
        tisd_DI19_CLKW      : VitalDelayType := 0 ns;
        tisd_DI20_CLKW      : VitalDelayType := 0 ns;
        tisd_DI21_CLKW      : VitalDelayType := 0 ns;
        tisd_DI22_CLKW      : VitalDelayType := 0 ns;
        tisd_DI23_CLKW      : VitalDelayType := 0 ns;
        tisd_DI24_CLKW      : VitalDelayType := 0 ns;
        tisd_DI25_CLKW      : VitalDelayType := 0 ns;
        tisd_DI26_CLKW      : VitalDelayType := 0 ns;
        tisd_DI27_CLKW      : VitalDelayType := 0 ns;
        tisd_DI28_CLKW      : VitalDelayType := 0 ns;
        tisd_DI29_CLKW      : VitalDelayType := 0 ns;
        tisd_DI30_CLKW      : VitalDelayType := 0 ns;
        tisd_DI31_CLKW      : VitalDelayType := 0 ns;
        tisd_DI32_CLKW      : VitalDelayType := 0 ns;
        tisd_DI33_CLKW      : VitalDelayType := 0 ns;
        tisd_DI34_CLKW      : VitalDelayType := 0 ns;
        tisd_DI35_CLKW      : VitalDelayType := 0 ns;
        tisd_WE_CLKW      : VitalDelayType := 0 ns;
        tisd_CSW0_CLKW      : VitalDelayType := 0 ns;
        tisd_CSW1_CLKW      : VitalDelayType := 0 ns;
        tisd_FULLI_CLKW      : VitalDelayType := 0 ns;
        tisd_RST_CLKW      : VitalDelayType := 0 ns;
        tisd_RPRST_CLKR      : VitalDelayType := 0 ns;
        tisd_RE_CLKR      : VitalDelayType := 0 ns;
        tisd_CSR0_CLKR      : VitalDelayType := 0 ns;
        tisd_CSR1_CLKR      : VitalDelayType := 0 ns;
        tisd_EMPTYI_CLKR      : VitalDelayType := 0 ns;

        tsetup_DI0_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI2_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI3_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI4_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI5_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI6_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI7_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI8_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI9_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI10_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI11_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI12_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI13_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI14_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI15_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI16_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI17_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI18_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI19_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI20_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI21_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI22_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI23_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI24_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI25_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI26_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI27_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI28_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI29_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI30_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI31_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI32_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI33_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI34_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_DI35_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_WE_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSW0_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSW1_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_FULLI_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_RST_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_RPRST_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_RE_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSR0_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_CSR1_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        tsetup_EMPTYI_CLKR_noedge_posedge     : VitalDelayType := 0 ns;

        tsetup_DI0_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI1_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI2_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI3_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI4_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI5_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI6_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI7_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI8_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI9_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI10_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI11_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI12_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI13_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI14_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI15_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI16_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI17_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI18_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI19_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI20_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI21_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI22_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI23_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI24_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI25_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI26_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI27_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI28_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI29_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI30_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI31_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI32_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI33_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI34_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_DI35_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_WE_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSW0_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSW1_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_FULLI_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_RST_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_RPRST_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_RE_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSR0_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_CSR1_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        tsetup_EMPTYI_CLKR_noedge_negedge     : VitalDelayType := 0 ns;

        thold_DI0_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI1_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI2_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI3_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI4_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI5_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI6_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI7_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI8_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI9_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI10_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI11_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI12_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI13_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI14_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI15_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI16_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI17_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI18_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI19_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI20_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI21_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI22_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI23_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI24_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI25_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI26_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI27_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI28_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI29_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI30_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI31_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI32_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI33_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI34_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_DI35_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_WE_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSW0_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSW1_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_FULLI_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_RST_CLKW_noedge_posedge     : VitalDelayType := 0 ns;
        thold_RPRST_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        thold_RE_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSR0_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        thold_CSR1_CLKR_noedge_posedge     : VitalDelayType := 0 ns;
        thold_EMPTYI_CLKR_noedge_posedge     : VitalDelayType := 0 ns;

        thold_DI0_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI1_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI2_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI3_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI4_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI5_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI6_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI7_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI8_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI9_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI10_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI11_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI12_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI13_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI14_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI15_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI16_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI17_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI18_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI19_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI20_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI21_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI22_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI23_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI24_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI25_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI26_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI27_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI28_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI29_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI30_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI31_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI32_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI33_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI34_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_DI35_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_WE_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSW0_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSW1_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_FULLI_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_RST_CLKW_noedge_negedge     : VitalDelayType := 0 ns;
        thold_RPRST_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        thold_RE_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSR0_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        thold_CSR1_CLKR_noedge_negedge     : VitalDelayType := 0 ns;
        thold_EMPTYI_CLKR_noedge_negedge     : VitalDelayType := 0 ns;

        tperiod_CLKW            : VitalDelayType := 0.001 ns;
        tpw_CLKW_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLKW_negedge        : VitalDelayType := 0.001 ns;
        tperiod_CLKR            : VitalDelayType := 0.001 ns;
        tpw_CLKR_posedge        : VitalDelayType := 0.001 ns;
        tpw_CLKR_negedge        : VitalDelayType := 0.001 ns;
        tperiod_RST            : VitalDelayType := 0.001 ns;
        tpw_RST_posedge        : VitalDelayType := 0.001 ns;
        tpw_RST_negedge        : VitalDelayType := 0.001 ns;
        tperiod_RPRST            : VitalDelayType := 0.001 ns;
        tpw_RPRST_posedge        : VitalDelayType := 0.001 ns;
        tpw_RPRST_negedge        : VitalDelayType := 0.001 ns);

   PORT(
        DI0, DI1, DI2, DI3, DI4, DI5, DI6, DI7, DI8            : in std_logic := 'X';
        DI9, DI10, DI11, DI12, DI13, DI14, DI15, DI16, DI17    : in std_logic := 'X';
        DI18, DI19, DI20, DI21, DI22, DI23, DI24, DI25, DI26   : in std_logic := 'X';
        DI27, DI28, DI29, DI30, DI31, DI32, DI33, DI34, DI35   : in std_logic := 'X';
        FULLI, CSW0, CSW1, EMPTYI, CSR0, CSR1                     : in std_logic := 'X';
        WE, RE, CLKW, CLKR, RST, RPRST                       : in std_logic := 'X';

        DO0, DO1, DO2, DO3, DO4, DO5, DO6, DO7, DO8            : out std_logic := 'X';
        DO9, DO10, DO11, DO12, DO13, DO14, DO15, DO16, DO17    : out std_logic := 'X';
        DO18, DO19, DO20, DO21, DO22, DO23, DO24, DO25, DO26   : out std_logic := 'X';
        DO27, DO28, DO29, DO30, DO31, DO32, DO33, DO34, DO35   : out std_logic := 'X';
        EF, AEF, AFF, FF                                       : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF SFIFOA : ENTITY IS TRUE;

END SFIFOA ;

-- ARCHITECTURE body --
ARCHITECTURE V OF SFIFOA IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal DI0_ipd       : std_logic := 'X';
    signal DI1_ipd       : std_logic := 'X';
    signal DI2_ipd       : std_logic := 'X';
    signal DI3_ipd       : std_logic := 'X';
    signal DI4_ipd       : std_logic := 'X';
    signal DI5_ipd       : std_logic := 'X';
    signal DI6_ipd       : std_logic := 'X';
    signal DI7_ipd       : std_logic := 'X';
    signal DI8_ipd       : std_logic := 'X';
    signal DI9_ipd       : std_logic := 'X';
    signal DI10_ipd       : std_logic := 'X';
    signal DI11_ipd       : std_logic := 'X';
    signal DI12_ipd       : std_logic := 'X';
    signal DI13_ipd       : std_logic := 'X';
    signal DI14_ipd       : std_logic := 'X';
    signal DI15_ipd       : std_logic := 'X';
    signal DI16_ipd       : std_logic := 'X';
    signal DI17_ipd       : std_logic := 'X';
    signal DI18_ipd       : std_logic := 'X';
    signal DI19_ipd       : std_logic := 'X';
    signal DI20_ipd       : std_logic := 'X';
    signal DI21_ipd       : std_logic := 'X';
    signal DI22_ipd       : std_logic := 'X';
    signal DI23_ipd       : std_logic := 'X';
    signal DI24_ipd       : std_logic := 'X';
    signal DI25_ipd       : std_logic := 'X';
    signal DI26_ipd       : std_logic := 'X';
    signal DI27_ipd       : std_logic := 'X';
    signal DI28_ipd       : std_logic := 'X';
    signal DI29_ipd       : std_logic := 'X';
    signal DI30_ipd       : std_logic := 'X';
    signal DI31_ipd       : std_logic := 'X';
    signal DI32_ipd       : std_logic := 'X';
    signal DI33_ipd       : std_logic := 'X';
    signal DI34_ipd       : std_logic := 'X';
    signal DI35_ipd       : std_logic := 'X';
    signal FULLI_ipd       : std_logic := 'X';
    signal CSW0_ipd       : std_logic := 'X';
    signal CSW1_ipd       : std_logic := 'X';
    signal WE_ipd       : std_logic := 'X';
    signal RE_ipd       : std_logic := 'X';
    signal CSR0_ipd       : std_logic := 'X';
    signal CSR1_ipd       : std_logic := 'X';
    signal EMPTYI_ipd       : std_logic := 'X';
    signal RST_ipd       : std_logic := 'X';
    signal RPRST_ipd       : std_logic := 'X';
    signal CLKW_ipd       : std_logic := 'X';
    signal CLKR_ipd       : std_logic := 'X';

    signal DI0_dly       : std_logic := 'X';
    signal DI1_dly       : std_logic := 'X';
    signal DI2_dly       : std_logic := 'X';
    signal DI3_dly       : std_logic := 'X';
    signal DI4_dly       : std_logic := 'X';
    signal DI5_dly       : std_logic := 'X';
    signal DI6_dly       : std_logic := 'X';
    signal DI7_dly       : std_logic := 'X';
    signal DI8_dly       : std_logic := 'X';
    signal DI9_dly       : std_logic := 'X';
    signal DI10_dly       : std_logic := 'X';
    signal DI11_dly       : std_logic := 'X';
    signal DI12_dly       : std_logic := 'X';
    signal DI13_dly       : std_logic := 'X';
    signal DI14_dly       : std_logic := 'X';
    signal DI15_dly       : std_logic := 'X';
    signal DI16_dly       : std_logic := 'X';
    signal DI17_dly       : std_logic := 'X';
    signal DI18_dly       : std_logic := 'X';
    signal DI19_dly       : std_logic := 'X';
    signal DI20_dly       : std_logic := 'X';
    signal DI21_dly       : std_logic := 'X';
    signal DI22_dly       : std_logic := 'X';
    signal DI23_dly       : std_logic := 'X';
    signal DI24_dly       : std_logic := 'X';
    signal DI25_dly       : std_logic := 'X';
    signal DI26_dly       : std_logic := 'X';
    signal DI27_dly       : std_logic := 'X';
    signal DI28_dly       : std_logic := 'X';
    signal DI29_dly       : std_logic := 'X';
    signal DI30_dly       : std_logic := 'X';
    signal DI31_dly       : std_logic := 'X';
    signal DI32_dly       : std_logic := 'X';
    signal DI33_dly       : std_logic := 'X';
    signal DI34_dly       : std_logic := 'X';
    signal DI35_dly       : std_logic := 'X';
    signal FULLI_dly       : std_logic := 'X';
    signal CSW0_dly       : std_logic := 'X';
    signal CSW1_dly       : std_logic := 'X';
    signal WE_dly       : std_logic := 'X';
    signal RE_dly       : std_logic := 'X';
    signal CSR0_dly       : std_logic := 'X';
    signal CSR1_dly       : std_logic := 'X';
    signal EMPTYI_dly       : std_logic := 'X';
    signal RST_dly       : std_logic := 'X';
    signal RPRST_dly       : std_logic := 'X';
    signal CLKW_dly       : std_logic := 'X';
    signal CLKR_dly       : std_logic := 'X';

    signal DO0_dly       : std_logic := 'X';
    signal DO1_dly       : std_logic := 'X';
    signal DO2_dly       : std_logic := 'X';
    signal DO3_dly       : std_logic := 'X';
    signal DO4_dly       : std_logic := 'X';
    signal DO5_dly       : std_logic := 'X';
    signal DO6_dly       : std_logic := 'X';
    signal DO7_dly       : std_logic := 'X';
    signal DO8_dly       : std_logic := 'X';
    signal DO9_dly       : std_logic := 'X';
    signal DO10_dly       : std_logic := 'X';
    signal DO11_dly       : std_logic := 'X';
    signal DO12_dly       : std_logic := 'X';
    signal DO13_dly       : std_logic := 'X';
    signal DO14_dly       : std_logic := 'X';
    signal DO15_dly       : std_logic := 'X';
    signal DO16_dly       : std_logic := 'X';
    signal DO17_dly       : std_logic := 'X';
    signal DO18_dly       : std_logic := 'X';
    signal DO19_dly       : std_logic := 'X';
    signal DO20_dly       : std_logic := 'X';
    signal DO21_dly       : std_logic := 'X';
    signal DO22_dly       : std_logic := 'X';
    signal DO23_dly       : std_logic := 'X';
    signal DO24_dly       : std_logic := 'X';
    signal DO25_dly       : std_logic := 'X';
    signal DO26_dly       : std_logic := 'X';
    signal DO27_dly       : std_logic := 'X';
    signal DO28_dly       : std_logic := 'X';
    signal DO29_dly       : std_logic := 'X';
    signal DO30_dly       : std_logic := 'X';
    signal DO31_dly       : std_logic := 'X';
    signal DO32_dly       : std_logic := 'X';
    signal DO33_dly       : std_logic := 'X';
    signal DO34_dly       : std_logic := 'X';
    signal DO35_dly       : std_logic := 'X';
    signal EF_dly       : std_logic := 'X';
    signal AEF_dly       : std_logic := 'X';
    signal FF_dly       : std_logic := 'X';
    signal AFF_dly       : std_logic := 'X';

    BEGIN

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
      VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
      VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
      VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
      VitalWireDelay(DI4_ipd, DI4, tipd_DI4);
      VitalWireDelay(DI5_ipd, DI5, tipd_DI5);
      VitalWireDelay(DI6_ipd, DI6, tipd_DI6);
      VitalWireDelay(DI7_ipd, DI7, tipd_DI7);
      VitalWireDelay(DI8_ipd, DI8, tipd_DI8);
      VitalWireDelay(DI9_ipd, DI9, tipd_DI9);
      VitalWireDelay(DI10_ipd, DI10, tipd_DI10);
      VitalWireDelay(DI11_ipd, DI11, tipd_DI11);
      VitalWireDelay(DI12_ipd, DI12, tipd_DI12);
      VitalWireDelay(DI13_ipd, DI13, tipd_DI13);
      VitalWireDelay(DI14_ipd, DI14, tipd_DI14);
      VitalWireDelay(DI15_ipd, DI15, tipd_DI15);
      VitalWireDelay(DI16_ipd, DI16, tipd_DI16);
      VitalWireDelay(DI17_ipd, DI17, tipd_DI17);
      VitalWireDelay(DI18_ipd, DI18, tipd_DI18);
      VitalWireDelay(DI19_ipd, DI19, tipd_DI19);
      VitalWireDelay(DI20_ipd, DI20, tipd_DI20);
      VitalWireDelay(DI21_ipd, DI21, tipd_DI21);
      VitalWireDelay(DI22_ipd, DI22, tipd_DI22);
      VitalWireDelay(DI23_ipd, DI23, tipd_DI23);
      VitalWireDelay(DI24_ipd, DI24, tipd_DI24);
      VitalWireDelay(DI25_ipd, DI25, tipd_DI25);
      VitalWireDelay(DI26_ipd, DI26, tipd_DI26);
      VitalWireDelay(DI27_ipd, DI27, tipd_DI27);
      VitalWireDelay(DI28_ipd, DI28, tipd_DI28);
      VitalWireDelay(DI29_ipd, DI29, tipd_DI29);
      VitalWireDelay(DI30_ipd, DI30, tipd_DI30);
      VitalWireDelay(DI31_ipd, DI31, tipd_DI31);
      VitalWireDelay(DI32_ipd, DI32, tipd_DI32);
      VitalWireDelay(DI33_ipd, DI33, tipd_DI33);
      VitalWireDelay(DI34_ipd, DI34, tipd_DI34);
      VitalWireDelay(DI35_ipd, DI35, tipd_DI35);
      VitalWireDelay(WE_ipd, WE, tipd_WE);
      VitalWireDelay(RE_ipd, RE, tipd_RE);
      VitalWireDelay(RST_ipd, RST, tipd_RST);
      VitalWireDelay(RPRST_ipd, RPRST, tipd_RPRST);
      VitalWireDelay(FULLI_ipd, FULLI, tipd_FULLI);
      VitalWireDelay(CSW0_ipd, CSW0, tipd_CSW0);
      VitalWireDelay(CSW1_ipd, CSW1, tipd_CSW1);
      VitalWireDelay(EMPTYI_ipd, EMPTYI, tipd_EMPTYI);
      VitalWireDelay(CSR0_ipd, CSR0, tipd_CSR0);
      VitalWireDelay(CSR1_ipd, CSR1, tipd_CSR1);
      VitalWireDelay(CLKW_ipd, CLKW, tipd_CLKW);
      VitalWireDelay(CLKR_ipd, CLKR, tipd_CLKR);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(DI0_dly, DI0_ipd, tisd_DI0_CLKW);
      VitalSignalDelay(DI1_dly, DI1_ipd, tisd_DI1_CLKW);
      VitalSignalDelay(DI2_dly, DI2_ipd, tisd_DI2_CLKW);
      VitalSignalDelay(DI3_dly, DI3_ipd, tisd_DI3_CLKW);
      VitalSignalDelay(DI4_dly, DI4_ipd, tisd_DI4_CLKW);
      VitalSignalDelay(DI5_dly, DI5_ipd, tisd_DI5_CLKW);
      VitalSignalDelay(DI6_dly, DI6_ipd, tisd_DI6_CLKW);
      VitalSignalDelay(DI7_dly, DI7_ipd, tisd_DI7_CLKW);
      VitalSignalDelay(DI8_dly, DI8_ipd, tisd_DI8_CLKW);
      VitalSignalDelay(DI9_dly, DI9_ipd, tisd_DI9_CLKW);
      VitalSignalDelay(DI10_dly, DI10_ipd, tisd_DI10_CLKW);
      VitalSignalDelay(DI11_dly, DI11_ipd, tisd_DI11_CLKW);
      VitalSignalDelay(DI12_dly, DI12_ipd, tisd_DI12_CLKW);
      VitalSignalDelay(DI13_dly, DI13_ipd, tisd_DI13_CLKW);
      VitalSignalDelay(DI14_dly, DI14_ipd, tisd_DI14_CLKW);
      VitalSignalDelay(DI15_dly, DI15_ipd, tisd_DI15_CLKW);
      VitalSignalDelay(DI16_dly, DI16_ipd, tisd_DI16_CLKW);
      VitalSignalDelay(DI17_dly, DI17_ipd, tisd_DI17_CLKW);
      VitalSignalDelay(DI18_dly, DI18_ipd, tisd_DI18_CLKW);
      VitalSignalDelay(DI19_dly, DI19_ipd, tisd_DI19_CLKW);
      VitalSignalDelay(DI20_dly, DI20_ipd, tisd_DI20_CLKW);
      VitalSignalDelay(DI21_dly, DI21_ipd, tisd_DI21_CLKW);
      VitalSignalDelay(DI22_dly, DI22_ipd, tisd_DI22_CLKW);
      VitalSignalDelay(DI23_dly, DI23_ipd, tisd_DI23_CLKW);
      VitalSignalDelay(DI24_dly, DI24_ipd, tisd_DI24_CLKW);
      VitalSignalDelay(DI25_dly, DI25_ipd, tisd_DI25_CLKW);
      VitalSignalDelay(DI26_dly, DI26_ipd, tisd_DI26_CLKW);
      VitalSignalDelay(DI27_dly, DI27_ipd, tisd_DI27_CLKW);
      VitalSignalDelay(DI28_dly, DI28_ipd, tisd_DI28_CLKW);
      VitalSignalDelay(DI29_dly, DI29_ipd, tisd_DI29_CLKW);
      VitalSignalDelay(DI30_dly, DI30_ipd, tisd_DI30_CLKW);
      VitalSignalDelay(DI31_dly, DI31_ipd, tisd_DI31_CLKW);
      VitalSignalDelay(DI32_dly, DI32_ipd, tisd_DI32_CLKW);
      VitalSignalDelay(DI33_dly, DI33_ipd, tisd_DI33_CLKW);
      VitalSignalDelay(DI34_dly, DI34_ipd, tisd_DI34_CLKW);
      VitalSignalDelay(DI35_dly, DI35_ipd, tisd_DI35_CLKW);
      VitalSignalDelay(WE_dly, WE_ipd, tisd_WE_CLKW);
      VitalSignalDelay(RE_dly, RE_ipd, tisd_RE_CLKR);
      VitalSignalDelay(RST_dly, RST_ipd, tisd_RST_CLKW);
      VitalSignalDelay(RPRST_dly, RPRST_ipd, tisd_RPRST_CLKR);
      VitalSignalDelay(CSW0_dly, CSW0_ipd, tisd_CSW0_CLKW);
      VitalSignalDelay(CSW1_dly, CSW1_ipd, tisd_CSW1_CLKW);
      VitalSignalDelay(FULLI_dly, FULLI_ipd, tisd_FULLI_CLKW);
      VitalSignalDelay(CSR0_dly, CSR0_ipd, tisd_CSR0_CLKR);
      VitalSignalDelay(CSR1_dly, CSR1_ipd, tisd_CSR1_CLKR);
      VitalSignalDelay(EMPTYI_dly, EMPTYI_ipd, tisd_EMPTYI_CLKR);
      VitalSignalDelay(CLKW_dly, CLKW_ipd, ticd_CLKW);
      VitalSignalDelay(CLKR_dly, CLKR_ipd, ticd_CLKR);
    END BLOCK;

    fifo16ka_INST : fifo16ka
                 generic map (DATA_WIDTH_W => DATA_WIDTH_W,
                              DATA_WIDTH_R => DATA_WIDTH_R,
                              REGMODE => REGMODE,
                              RESETMODE => RESETMODE,
                              CSDECODE_W => CSDECODE_W,
                              CSDECODE_R => CSDECODE_R,
                              AEPOINTER => AEPOINTER,
                              AEPOINTER1 => AEPOINTER1,
                              AFPOINTER => AFPOINTER,
                              AFPOINTER1 => AFPOINTER1,
                              FULLPOINTER => FULLPOINTER,
                              FULLPOINTER1 => FULLPOINTER1,
                              GSR => GSR)

                 port map (DI0 => DI0_dly,
                           DI1 => DI1_dly,
                           DI2 => DI2_dly,
                           DI3 => DI3_dly,
                           DI4 => DI4_dly,
                           DI5 => DI5_dly,
                           DI6 => DI6_dly,
                           DI7 => DI7_dly,
                           DI8 => DI8_dly,
                           DI9 => DI9_dly,
                           DI10 => DI10_dly,
                           DI11 => DI11_dly,
                           DI12 => DI12_dly,
                           DI13 => DI13_dly,
                           DI14 => DI14_dly,
                           DI15 => DI15_dly,
                           DI16 => DI16_dly,
                           DI17 => DI17_dly,
                           DI18 => DI18_dly,
                           DI19 => DI19_dly,
                           DI20 => DI20_dly,
                           DI21 => DI21_dly,
                           DI22 => DI22_dly,
                           DI23 => DI23_dly,
                           DI24 => DI24_dly,
                           DI25 => DI25_dly,
                           DI26 => DI26_dly,
                           DI27 => DI27_dly,
                           DI28 => DI28_dly,
                           DI29 => DI29_dly,
                           DI30 => DI30_dly,
                           DI31 => DI31_dly,
                           DI32 => DI32_dly,
                           DI33 => DI33_dly,
                           DI34 => DI34_dly,
                           DI35 => DI35_dly,
                           CLKW => CLKW_dly,
                           CLKR => CLKR_dly,
                           WE => WE_dly,
                           RE => RE_dly,
                           RST => RST_dly,
                           RPRST => RPRST_dly,
                           CSW0 => CSW0_dly,
                           CSW1 => CSW1_dly,
                           FULLI => FULLI_dly,
                           EMPTYI => EMPTYI_dly,
                           CSR0 => CSR0_dly,
                           CSR1 => CSR1_dly,
                           DO0 => DO0_dly,
                           DO1 => DO1_dly,
                           DO2 => DO2_dly,
                           DO3 => DO3_dly,
                           DO4 => DO4_dly,
                           DO5 => DO5_dly,
                           DO6 => DO6_dly,
                           DO7 => DO7_dly,
                           DO8 => DO8_dly,
                           DO9 => DO9_dly,
                           DO10 => DO10_dly,
                           DO11 => DO11_dly,
                           DO12 => DO12_dly,
                           DO13 => DO13_dly,
                           DO14 => DO14_dly,
                           DO15 => DO15_dly,
                           DO16 => DO16_dly,
                           DO17 => DO17_dly,
                           DO18 => DO18_dly,
                           DO19 => DO19_dly,
                           DO20 => DO20_dly,
                           DO21 => DO21_dly,
                           DO22 => DO22_dly,
                           DO23 => DO23_dly,
                           DO24 => DO24_dly,
                           DO25 => DO25_dly,
                           DO26 => DO26_dly,
                           DO27 => DO27_dly,
                           DO28 => DO28_dly,
                           DO29 => DO29_dly,
                           DO30 => DO30_dly,
                           DO31 => DO31_dly,
                           DO32 => DO32_dly,
                           DO33 => DO33_dly,
                           DO34 => DO34_dly,
                           DO35 => DO35_dly,
                           EF => EF_dly,
                           AEF => AEF_dly,
                           FF => FF_dly,
                           AFF => AFF_dly);

    VitalBehavior : PROCESS (DI0_dly, DI1_dly, DI2_dly, DI3_dly, DI4_dly, DI5_dly, DI6_dly, DI7_dly, DI8_dly,
    DI9_dly, DI10_dly, DI11_dly, DI12_dly, DI13_dly, DI14_dly, DI15_dly, DI16_dly, DI17_dly,
    DI18_dly, DI19_dly, DI20_dly, DI21_dly, DI22_dly, DI23_dly, DI24_dly, DI25_dly, DI26_dly,
    DI27_dly, DI28_dly, DI29_dly, DI30_dly, DI31_dly, DI32_dly, DI33_dly, DI34_dly, DI35_dly, 
    WE_dly, RE_dly, RST_dly, RPRST_dly, CLKW_dly, CLKR_dly, CSW0_dly, CSW1_dly, FULLI_dly, 
    CSR0_dly, CSR1_dly, EMPTYI_dly, CLKW_ipd, CLKR_ipd,
    DO0_dly, DO1_dly, DO2_dly, DO3_dly, DO4_dly, DO5_dly, DO6_dly, DO7_dly, DO8_dly,
    DO9_dly, DO10_dly, DO11_dly, DO12_dly, DO13_dly, DO14_dly, DO15_dly, DO16_dly, DO17_dly,
    DO18_dly, DO19_dly, DO20_dly, DO21_dly, DO22_dly, DO23_dly, DO24_dly, DO25_dly, DO26_dly, 
    DO27_dly, DO28_dly, DO29_dly, DO30_dly, DO31_dly, DO32_dly, DO33_dly, DO34_dly, DO35_dly,
    EF_dly, AEF_dly, FF_dly, AFF_dly, RST_ipd, RPRST_ipd)

    VARIABLE DO0_zd          : std_logic := 'X';
    VARIABLE DO0_GlitchData  : VitalGlitchDataType;
    VARIABLE DO1_zd          : std_logic := 'X';
    VARIABLE DO1_GlitchData  : VitalGlitchDataType;
    VARIABLE DO2_zd          : std_logic := 'X';
    VARIABLE DO2_GlitchData  : VitalGlitchDataType;
    VARIABLE DO3_zd          : std_logic := 'X';
    VARIABLE DO3_GlitchData  : VitalGlitchDataType;
    VARIABLE DO4_zd          : std_logic := 'X';
    VARIABLE DO4_GlitchData  : VitalGlitchDataType;
    VARIABLE DO5_zd          : std_logic := 'X';
    VARIABLE DO5_GlitchData  : VitalGlitchDataType;
    VARIABLE DO6_zd          : std_logic := 'X';
    VARIABLE DO6_GlitchData  : VitalGlitchDataType;
    VARIABLE DO7_zd          : std_logic := 'X';
    VARIABLE DO7_GlitchData  : VitalGlitchDataType;
    VARIABLE DO8_zd          : std_logic := 'X';
    VARIABLE DO8_GlitchData  : VitalGlitchDataType;
    VARIABLE DO9_zd          : std_logic := 'X';
    VARIABLE DO9_GlitchData  : VitalGlitchDataType;
    VARIABLE DO10_zd          : std_logic := 'X';
    VARIABLE DO10_GlitchData  : VitalGlitchDataType;
    VARIABLE DO11_zd          : std_logic := 'X';
    VARIABLE DO11_GlitchData  : VitalGlitchDataType;
    VARIABLE DO12_zd          : std_logic := 'X';
    VARIABLE DO12_GlitchData  : VitalGlitchDataType;
    VARIABLE DO13_zd          : std_logic := 'X';
    VARIABLE DO13_GlitchData  : VitalGlitchDataType;
    VARIABLE DO14_zd          : std_logic := 'X';
    VARIABLE DO14_GlitchData  : VitalGlitchDataType;
    VARIABLE DO15_zd          : std_logic := 'X';
    VARIABLE DO15_GlitchData  : VitalGlitchDataType;
    VARIABLE DO16_zd          : std_logic := 'X';
    VARIABLE DO16_GlitchData  : VitalGlitchDataType;
    VARIABLE DO17_zd          : std_logic := 'X';
    VARIABLE DO17_GlitchData  : VitalGlitchDataType;
    VARIABLE DO18_zd          : std_logic := 'X';
    VARIABLE DO18_GlitchData  : VitalGlitchDataType;
    VARIABLE DO19_zd          : std_logic := 'X';
    VARIABLE DO19_GlitchData  : VitalGlitchDataType;
    VARIABLE DO20_zd          : std_logic := 'X';
    VARIABLE DO20_GlitchData  : VitalGlitchDataType;
    VARIABLE DO21_zd          : std_logic := 'X';
    VARIABLE DO21_GlitchData  : VitalGlitchDataType;
    VARIABLE DO22_zd          : std_logic := 'X';
    VARIABLE DO22_GlitchData  : VitalGlitchDataType;
    VARIABLE DO23_zd          : std_logic := 'X';
    VARIABLE DO23_GlitchData  : VitalGlitchDataType;
    VARIABLE DO24_zd          : std_logic := 'X';
    VARIABLE DO24_GlitchData  : VitalGlitchDataType;
    VARIABLE DO25_zd          : std_logic := 'X';
    VARIABLE DO25_GlitchData  : VitalGlitchDataType;
    VARIABLE DO26_zd          : std_logic := 'X';
    VARIABLE DO26_GlitchData  : VitalGlitchDataType;
    VARIABLE DO27_zd          : std_logic := 'X';
    VARIABLE DO27_GlitchData  : VitalGlitchDataType;
    VARIABLE DO28_zd          : std_logic := 'X';
    VARIABLE DO28_GlitchData  : VitalGlitchDataType;
    VARIABLE DO29_zd          : std_logic := 'X';
    VARIABLE DO29_GlitchData  : VitalGlitchDataType;
    VARIABLE DO30_zd          : std_logic := 'X';
    VARIABLE DO30_GlitchData  : VitalGlitchDataType;
    VARIABLE DO31_zd          : std_logic := 'X';
    VARIABLE DO31_GlitchData  : VitalGlitchDataType;
    VARIABLE DO32_zd          : std_logic := 'X';
    VARIABLE DO32_GlitchData  : VitalGlitchDataType;
    VARIABLE DO33_zd          : std_logic := 'X';
    VARIABLE DO33_GlitchData  : VitalGlitchDataType;
    VARIABLE DO34_zd          : std_logic := 'X';
    VARIABLE DO34_GlitchData  : VitalGlitchDataType;
    VARIABLE DO35_zd          : std_logic := 'X';
    VARIABLE DO35_GlitchData  : VitalGlitchDataType;
    VARIABLE EF_zd          : std_logic := 'X';
    VARIABLE EF_GlitchData  : VitalGlitchDataType;
    VARIABLE AEF_zd          : std_logic := 'X';
    VARIABLE AEF_GlitchData  : VitalGlitchDataType;
    VARIABLE FF_zd          : std_logic := 'X';
    VARIABLE FF_GlitchData  : VitalGlitchDataType;
    VARIABLE AFF_zd          : std_logic := 'X';
    VARIABLE AFF_GlitchData  : VitalGlitchDataType;

    VARIABLE tviol_DI0_CLKW        : x01 := '0';
    VARIABLE DI0_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI1_CLKW        : x01 := '0';
    VARIABLE DI1_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI2_CLKW        : x01 := '0';
    VARIABLE DI2_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI3_CLKW        : x01 := '0';
    VARIABLE DI3_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI4_CLKW        : x01 := '0';
    VARIABLE DI4_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI5_CLKW        : x01 := '0';
    VARIABLE DI5_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI6_CLKW        : x01 := '0';
    VARIABLE DI6_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI7_CLKW        : x01 := '0';
    VARIABLE DI7_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI8_CLKW        : x01 := '0';
    VARIABLE DI8_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI9_CLKW        : x01 := '0';
    VARIABLE DI9_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI10_CLKW        : x01 := '0';
    VARIABLE DI10_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI11_CLKW        : x01 := '0';
    VARIABLE DI11_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI12_CLKW        : x01 := '0';
    VARIABLE DI12_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI13_CLKW        : x01 := '0';
    VARIABLE DI13_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI14_CLKW        : x01 := '0';
    VARIABLE DI14_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI15_CLKW        : x01 := '0';
    VARIABLE DI15_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI16_CLKW        : x01 := '0';
    VARIABLE DI16_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI17_CLKW        : x01 := '0';
    VARIABLE DI17_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI18_CLKW        : x01 := '0';
    VARIABLE DI18_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI19_CLKW        : x01 := '0';
    VARIABLE DI19_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI20_CLKW        : x01 := '0';
    VARIABLE DI20_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI21_CLKW        : x01 := '0';
    VARIABLE DI21_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI22_CLKW        : x01 := '0';
    VARIABLE DI22_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI23_CLKW        : x01 := '0';
    VARIABLE DI23_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI24_CLKW        : x01 := '0';
    VARIABLE DI24_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI25_CLKW        : x01 := '0';
    VARIABLE DI25_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI26_CLKW        : x01 := '0';
    VARIABLE DI26_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI27_CLKW        : x01 := '0';
    VARIABLE DI27_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI28_CLKW        : x01 := '0';
    VARIABLE DI28_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI29_CLKW        : x01 := '0';
    VARIABLE DI29_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI30_CLKW        : x01 := '0';
    VARIABLE DI30_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI31_CLKW        : x01 := '0';
    VARIABLE DI31_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI32_CLKW        : x01 := '0';
    VARIABLE DI32_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI33_CLKW        : x01 := '0';
    VARIABLE DI33_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI34_CLKW        : x01 := '0';
    VARIABLE DI34_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_DI35_CLKW        : x01 := '0';
    VARIABLE DI35_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_WE_CLKW        : x01 := '0';
    VARIABLE WE_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_RE_CLKR        : x01 := '0';
    VARIABLE RE_CLKR_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_RST_CLKW        : x01 := '0';
    VARIABLE RST_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_RPRST_CLKR        : x01 := '0';
    VARIABLE RPRST_CLKR_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_FULLI_CLKW        : x01 := '0';
    VARIABLE FULLI_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSW0_CLKW        : x01 := '0';
    VARIABLE CSW0_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSW1_CLKW        : x01 := '0';
    VARIABLE CSW1_CLKW_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_EMPTYI_CLKR        : x01 := '0';
    VARIABLE EMPTYI_CLKR_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSR0_CLKR        : x01 := '0';
    VARIABLE CSR0_CLKR_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CSR1_CLKR        : x01 := '0';
    VARIABLE CSR1_CLKR_TimingDatash : VitalTimingDataType;
    VARIABLE tviol_CLKW             : x01 := '0';
    VARIABLE periodcheckinfo_CLKW       : VitalPeriodDataType;
    VARIABLE tviol_CLKR             : x01 := '0';
    VARIABLE periodcheckinfo_CLKR       : VitalPeriodDataType;
    VARIABLE tviol_RST              : x01 := '0';
    VARIABLE periodcheckinfo_RST        : VitalPeriodDataType;
    VARIABLE tviol_RPRST              : x01 := '0';
    VARIABLE periodcheckinfo_RPRST        : VitalPeriodDataType;

  BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI0_CLKW_noedge_posedge,
        SetupLow => tsetup_DI0_CLKW_noedge_posedge,
        HoldHigh => thold_DI0_CLKW_noedge_posedge,
        HoldLow => thold_DI0_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLKW_TimingDatash,
        Violation => tviol_DI0_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI0_dly,
        TestSignalName => "DI0",
        TestDelay => tisd_DI0_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI0_CLKW_noedge_negedge,
        SetupLow => tsetup_DI0_CLKW_noedge_negedge,
        HoldHigh => thold_DI0_CLKW_noedge_negedge,
        HoldLow => thold_DI0_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI0_CLKW_TimingDatash,
        Violation => tviol_DI0_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI1_CLKW_noedge_posedge,
        SetupLow => tsetup_DI1_CLKW_noedge_posedge,
        HoldHigh => thold_DI1_CLKW_noedge_posedge,
        HoldLow => thold_DI1_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLKW_TimingDatash,
        Violation => tviol_DI1_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI1_dly,
        TestSignalName => "DI1",
        TestDelay => tisd_DI1_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI1_CLKW_noedge_negedge,
        SetupLow => tsetup_DI1_CLKW_noedge_negedge,
        HoldHigh => thold_DI1_CLKW_noedge_negedge,
        HoldLow => thold_DI1_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI1_CLKW_TimingDatash,
        Violation => tviol_DI1_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI2_dly,
        TestSignalName => "DI2",
        TestDelay => tisd_DI2_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI2_CLKW_noedge_posedge,
        SetupLow => tsetup_DI2_CLKW_noedge_posedge,
        HoldHigh => thold_DI2_CLKW_noedge_posedge,
        HoldLow => thold_DI2_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI2),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI2_CLKW_TimingDatash,
        Violation => tviol_DI2_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI2_dly,
        TestSignalName => "DI2",
        TestDelay => tisd_DI2_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI2_CLKW_noedge_negedge,
        SetupLow => tsetup_DI2_CLKW_noedge_negedge,
        HoldHigh => thold_DI2_CLKW_noedge_negedge,
        HoldLow => thold_DI2_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI2),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI2_CLKW_TimingDatash,
        Violation => tviol_DI2_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI3_dly,
        TestSignalName => "DI3",
        TestDelay => tisd_DI3_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI3_CLKW_noedge_posedge,
        SetupLow => tsetup_DI3_CLKW_noedge_posedge,
        HoldHigh => thold_DI3_CLKW_noedge_posedge,
        HoldLow => thold_DI3_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI3),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI3_CLKW_TimingDatash,
        Violation => tviol_DI3_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI3_dly,
        TestSignalName => "DI3",
        TestDelay => tisd_DI3_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI3_CLKW_noedge_negedge,
        SetupLow => tsetup_DI3_CLKW_noedge_negedge,
        HoldHigh => thold_DI3_CLKW_noedge_negedge,
        HoldLow => thold_DI3_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI3),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI3_CLKW_TimingDatash,
        Violation => tviol_DI3_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI4_dly,
        TestSignalName => "DI4",
        TestDelay => tisd_DI4_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI4_CLKW_noedge_posedge,
        SetupLow => tsetup_DI4_CLKW_noedge_posedge,
        HoldHigh => thold_DI4_CLKW_noedge_posedge,
        HoldLow => thold_DI4_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI4),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI4_CLKW_TimingDatash,
        Violation => tviol_DI4_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI4_dly,
        TestSignalName => "DI4",
        TestDelay => tisd_DI4_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI4_CLKW_noedge_negedge,
        SetupLow => tsetup_DI4_CLKW_noedge_negedge,
        HoldHigh => thold_DI4_CLKW_noedge_negedge,
        HoldLow => thold_DI4_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI4),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI4_CLKW_TimingDatash,
        Violation => tviol_DI4_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI5_dly,
        TestSignalName => "DI5",
        TestDelay => tisd_DI5_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI5_CLKW_noedge_posedge,
        SetupLow => tsetup_DI5_CLKW_noedge_posedge,
        HoldHigh => thold_DI5_CLKW_noedge_posedge,
        HoldLow => thold_DI5_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI5),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI5_CLKW_TimingDatash,
        Violation => tviol_DI5_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI5_dly,
        TestSignalName => "DI5",
        TestDelay => tisd_DI5_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI5_CLKW_noedge_negedge,
        SetupLow => tsetup_DI5_CLKW_noedge_negedge,
        HoldHigh => thold_DI5_CLKW_noedge_negedge,
        HoldLow => thold_DI5_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI5),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI5_CLKW_TimingDatash,
        Violation => tviol_DI5_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI6_dly,
        TestSignalName => "DI6",
        TestDelay => tisd_DI6_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI6_CLKW_noedge_posedge,
        SetupLow => tsetup_DI6_CLKW_noedge_posedge,
        HoldHigh => thold_DI6_CLKW_noedge_posedge,
        HoldLow => thold_DI6_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI6),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI6_CLKW_TimingDatash,
        Violation => tviol_DI6_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI6_dly,
        TestSignalName => "DI6",
        TestDelay => tisd_DI6_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI6_CLKW_noedge_negedge,
        SetupLow => tsetup_DI6_CLKW_noedge_negedge,
        HoldHigh => thold_DI6_CLKW_noedge_negedge,
        HoldLow => thold_DI6_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI6),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI6_CLKW_TimingDatash,
        Violation => tviol_DI6_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI7_dly,
        TestSignalName => "DI7",
        TestDelay => tisd_DI7_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI7_CLKW_noedge_posedge,
        SetupLow => tsetup_DI7_CLKW_noedge_posedge,
        HoldHigh => thold_DI7_CLKW_noedge_posedge,
        HoldLow => thold_DI7_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI7),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI7_CLKW_TimingDatash,
        Violation => tviol_DI7_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI7_dly,
        TestSignalName => "DI7",
        TestDelay => tisd_DI7_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI7_CLKW_noedge_negedge,
        SetupLow => tsetup_DI7_CLKW_noedge_negedge,
        HoldHigh => thold_DI7_CLKW_noedge_negedge,
        HoldLow => thold_DI7_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI7),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI7_CLKW_TimingDatash,
        Violation => tviol_DI7_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI8_dly,
        TestSignalName => "DI8",
        TestDelay => tisd_DI8_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI8_CLKW_noedge_posedge,
        SetupLow => tsetup_DI8_CLKW_noedge_posedge,
        HoldHigh => thold_DI8_CLKW_noedge_posedge,
        HoldLow => thold_DI8_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI8),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI8_CLKW_TimingDatash,
        Violation => tviol_DI8_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI8_dly,
        TestSignalName => "DI8",
        TestDelay => tisd_DI8_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI8_CLKW_noedge_negedge,
        SetupLow => tsetup_DI8_CLKW_noedge_negedge,
        HoldHigh => thold_DI8_CLKW_noedge_negedge,
        HoldLow => thold_DI8_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI8),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI8_CLKW_TimingDatash,
        Violation => tviol_DI8_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI9_dly,
        TestSignalName => "DI9",
        TestDelay => tisd_DI9_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI9_CLKW_noedge_posedge,
        SetupLow => tsetup_DI9_CLKW_noedge_posedge,
        HoldHigh => thold_DI9_CLKW_noedge_posedge,
        HoldLow => thold_DI9_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI9),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI9_CLKW_TimingDatash,
        Violation => tviol_DI9_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI9_dly,
        TestSignalName => "DI9",
        TestDelay => tisd_DI9_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI9_CLKW_noedge_negedge,
        SetupLow => tsetup_DI9_CLKW_noedge_negedge,
        HoldHigh => thold_DI9_CLKW_noedge_negedge,
        HoldLow => thold_DI9_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI9),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI9_CLKW_TimingDatash,
        Violation => tviol_DI9_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI10_dly,
        TestSignalName => "DI10",
        TestDelay => tisd_DI10_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI10_CLKW_noedge_posedge,
        SetupLow => tsetup_DI10_CLKW_noedge_posedge,
        HoldHigh => thold_DI10_CLKW_noedge_posedge,
        HoldLow => thold_DI10_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI10),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI10_CLKW_TimingDatash,
        Violation => tviol_DI10_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI10_dly,
        TestSignalName => "DI10",
        TestDelay => tisd_DI10_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI10_CLKW_noedge_negedge,
        SetupLow => tsetup_DI10_CLKW_noedge_negedge,
        HoldHigh => thold_DI10_CLKW_noedge_negedge,
        HoldLow => thold_DI10_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI10),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI10_CLKW_TimingDatash,
        Violation => tviol_DI10_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI11_dly,
        TestSignalName => "DI11",
        TestDelay => tisd_DI11_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI11_CLKW_noedge_posedge,
        SetupLow => tsetup_DI11_CLKW_noedge_posedge,
        HoldHigh => thold_DI11_CLKW_noedge_posedge,
        HoldLow => thold_DI11_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI11),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI11_CLKW_TimingDatash,
        Violation => tviol_DI11_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI11_dly,
        TestSignalName => "DI11",
        TestDelay => tisd_DI11_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI11_CLKW_noedge_negedge,
        SetupLow => tsetup_DI11_CLKW_noedge_negedge,
        HoldHigh => thold_DI11_CLKW_noedge_negedge,
        HoldLow => thold_DI11_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI11),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI11_CLKW_TimingDatash,
        Violation => tviol_DI11_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI12_dly,
        TestSignalName => "DI12",
        TestDelay => tisd_DI12_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI12_CLKW_noedge_posedge,
        SetupLow => tsetup_DI12_CLKW_noedge_posedge,
        HoldHigh => thold_DI12_CLKW_noedge_posedge,
        HoldLow => thold_DI12_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI12),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI12_CLKW_TimingDatash,
        Violation => tviol_DI12_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI12_dly,
        TestSignalName => "DI12",
        TestDelay => tisd_DI12_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI12_CLKW_noedge_negedge,
        SetupLow => tsetup_DI12_CLKW_noedge_negedge,
        HoldHigh => thold_DI12_CLKW_noedge_negedge,
        HoldLow => thold_DI12_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI12),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI12_CLKW_TimingDatash,
        Violation => tviol_DI12_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI13_dly,
        TestSignalName => "DI13",
        TestDelay => tisd_DI13_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI13_CLKW_noedge_posedge,
        SetupLow => tsetup_DI13_CLKW_noedge_posedge,
        HoldHigh => thold_DI13_CLKW_noedge_posedge,
        HoldLow => thold_DI13_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI13),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI13_CLKW_TimingDatash,
        Violation => tviol_DI13_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI13_dly,
        TestSignalName => "DI13",
        TestDelay => tisd_DI13_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI13_CLKW_noedge_negedge,
        SetupLow => tsetup_DI13_CLKW_noedge_negedge,
        HoldHigh => thold_DI13_CLKW_noedge_negedge,
        HoldLow => thold_DI13_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI13),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI13_CLKW_TimingDatash,
        Violation => tviol_DI13_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI14_dly,
        TestSignalName => "DI14",
        TestDelay => tisd_DI14_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI14_CLKW_noedge_posedge,
        SetupLow => tsetup_DI14_CLKW_noedge_posedge,
        HoldHigh => thold_DI14_CLKW_noedge_posedge,
        HoldLow => thold_DI14_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI14),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI14_CLKW_TimingDatash,
        Violation => tviol_DI14_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI14_dly,
        TestSignalName => "DI14",
        TestDelay => tisd_DI14_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI14_CLKW_noedge_negedge,
        SetupLow => tsetup_DI14_CLKW_noedge_negedge,
        HoldHigh => thold_DI14_CLKW_noedge_negedge,
        HoldLow => thold_DI14_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI14),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI14_CLKW_TimingDatash,
        Violation => tviol_DI14_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI15_dly,
        TestSignalName => "DI15",
        TestDelay => tisd_DI15_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI15_CLKW_noedge_posedge,
        SetupLow => tsetup_DI15_CLKW_noedge_posedge,
        HoldHigh => thold_DI15_CLKW_noedge_posedge,
        HoldLow => thold_DI15_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI15),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI15_CLKW_TimingDatash,
        Violation => tviol_DI15_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI15_dly,
        TestSignalName => "DI15",
        TestDelay => tisd_DI15_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI15_CLKW_noedge_negedge,
        SetupLow => tsetup_DI15_CLKW_noedge_negedge,
        HoldHigh => thold_DI15_CLKW_noedge_negedge,
        HoldLow => thold_DI15_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI15),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI15_CLKW_TimingDatash,
        Violation => tviol_DI15_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI16_dly,
        TestSignalName => "DI16",
        TestDelay => tisd_DI16_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI16_CLKW_noedge_posedge,
        SetupLow => tsetup_DI16_CLKW_noedge_posedge,
        HoldHigh => thold_DI16_CLKW_noedge_posedge,
        HoldLow => thold_DI16_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI16),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI16_CLKW_TimingDatash,
        Violation => tviol_DI16_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI16_dly,
        TestSignalName => "DI16",
        TestDelay => tisd_DI16_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI16_CLKW_noedge_negedge,
        SetupLow => tsetup_DI16_CLKW_noedge_negedge,
        HoldHigh => thold_DI16_CLKW_noedge_negedge,
        HoldLow => thold_DI16_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI16),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI16_CLKW_TimingDatash,
        Violation => tviol_DI16_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI17_dly,
        TestSignalName => "DI17",
        TestDelay => tisd_DI17_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI17_CLKW_noedge_posedge,
        SetupLow => tsetup_DI17_CLKW_noedge_posedge,
        HoldHigh => thold_DI17_CLKW_noedge_posedge,
        HoldLow => thold_DI17_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI17),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI17_CLKW_TimingDatash,
        Violation => tviol_DI17_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI17_dly,
        TestSignalName => "DI17",
        TestDelay => tisd_DI17_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI17_CLKW_noedge_negedge,
        SetupLow => tsetup_DI17_CLKW_noedge_negedge,
        HoldHigh => thold_DI17_CLKW_noedge_negedge,
        HoldLow => thold_DI17_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI17),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI17_CLKW_TimingDatash,
        Violation => tviol_DI17_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI18_dly,
        TestSignalName => "DI18",
        TestDelay => tisd_DI18_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI18_CLKW_noedge_posedge,
        SetupLow => tsetup_DI18_CLKW_noedge_posedge,
        HoldHigh => thold_DI18_CLKW_noedge_posedge,
        HoldLow => thold_DI18_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI18),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI18_CLKW_TimingDatash,
        Violation => tviol_DI18_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI18_dly,
        TestSignalName => "DI18",
        TestDelay => tisd_DI18_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI18_CLKW_noedge_negedge,
        SetupLow => tsetup_DI18_CLKW_noedge_negedge,
        HoldHigh => thold_DI18_CLKW_noedge_negedge,
        HoldLow => thold_DI18_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI18),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI18_CLKW_TimingDatash,
        Violation => tviol_DI18_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI19_dly,
        TestSignalName => "DI19",
        TestDelay => tisd_DI19_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI19_CLKW_noedge_posedge,
        SetupLow => tsetup_DI19_CLKW_noedge_posedge,
        HoldHigh => thold_DI19_CLKW_noedge_posedge,
        HoldLow => thold_DI19_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI19),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI19_CLKW_TimingDatash,
        Violation => tviol_DI19_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI19_dly,
        TestSignalName => "DI19",
        TestDelay => tisd_DI19_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI19_CLKW_noedge_negedge,
        SetupLow => tsetup_DI19_CLKW_noedge_negedge,
        HoldHigh => thold_DI19_CLKW_noedge_negedge,
        HoldLow => thold_DI19_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI19),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI19_CLKW_TimingDatash,
        Violation => tviol_DI19_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI20_dly,
        TestSignalName => "DI20",
        TestDelay => tisd_DI20_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI20_CLKW_noedge_posedge,
        SetupLow => tsetup_DI20_CLKW_noedge_posedge,
        HoldHigh => thold_DI20_CLKW_noedge_posedge,
        HoldLow => thold_DI20_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI20),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI20_CLKW_TimingDatash,
        Violation => tviol_DI20_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI20_dly,
        TestSignalName => "DI20",
        TestDelay => tisd_DI20_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI20_CLKW_noedge_negedge,
        SetupLow => tsetup_DI20_CLKW_noedge_negedge,
        HoldHigh => thold_DI20_CLKW_noedge_negedge,
        HoldLow => thold_DI20_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI20),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI20_CLKW_TimingDatash,
        Violation => tviol_DI20_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI21_dly,
        TestSignalName => "DI21",
        TestDelay => tisd_DI21_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI21_CLKW_noedge_posedge,
        SetupLow => tsetup_DI21_CLKW_noedge_posedge,
        HoldHigh => thold_DI21_CLKW_noedge_posedge,
        HoldLow => thold_DI21_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI21),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI21_CLKW_TimingDatash,
        Violation => tviol_DI21_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI21_dly,
        TestSignalName => "DI21",
        TestDelay => tisd_DI21_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI21_CLKW_noedge_negedge,
        SetupLow => tsetup_DI21_CLKW_noedge_negedge,
        HoldHigh => thold_DI21_CLKW_noedge_negedge,
        HoldLow => thold_DI21_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI21),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI21_CLKW_TimingDatash,
        Violation => tviol_DI21_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI22_dly,
        TestSignalName => "DI22",
        TestDelay => tisd_DI22_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI22_CLKW_noedge_posedge,
        SetupLow => tsetup_DI22_CLKW_noedge_posedge,
        HoldHigh => thold_DI22_CLKW_noedge_posedge,
        HoldLow => thold_DI22_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI22),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI22_CLKW_TimingDatash,
        Violation => tviol_DI22_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI22_dly,
        TestSignalName => "DI22",
        TestDelay => tisd_DI22_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI22_CLKW_noedge_negedge,
        SetupLow => tsetup_DI22_CLKW_noedge_negedge,
        HoldHigh => thold_DI22_CLKW_noedge_negedge,
        HoldLow => thold_DI22_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI22),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI22_CLKW_TimingDatash,
        Violation => tviol_DI22_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI23_dly,
        TestSignalName => "DI23",
        TestDelay => tisd_DI23_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI23_CLKW_noedge_posedge,
        SetupLow => tsetup_DI23_CLKW_noedge_posedge,
        HoldHigh => thold_DI23_CLKW_noedge_posedge,
        HoldLow => thold_DI23_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI23),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI23_CLKW_TimingDatash,
        Violation => tviol_DI23_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI23_dly,
        TestSignalName => "DI23",
        TestDelay => tisd_DI23_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI23_CLKW_noedge_negedge,
        SetupLow => tsetup_DI23_CLKW_noedge_negedge,
        HoldHigh => thold_DI23_CLKW_noedge_negedge,
        HoldLow => thold_DI23_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI23),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI23_CLKW_TimingDatash,
        Violation => tviol_DI23_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI24_dly,
        TestSignalName => "DI24",
        TestDelay => tisd_DI24_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI24_CLKW_noedge_posedge,
        SetupLow => tsetup_DI24_CLKW_noedge_posedge,
        HoldHigh => thold_DI24_CLKW_noedge_posedge,
        HoldLow => thold_DI24_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI24),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI24_CLKW_TimingDatash,
        Violation => tviol_DI24_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI24_dly,
        TestSignalName => "DI24",
        TestDelay => tisd_DI24_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI24_CLKW_noedge_negedge,
        SetupLow => tsetup_DI24_CLKW_noedge_negedge,
        HoldHigh => thold_DI24_CLKW_noedge_negedge,
        HoldLow => thold_DI24_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI24),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI24_CLKW_TimingDatash,
        Violation => tviol_DI24_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI25_dly,
        TestSignalName => "DI25",
        TestDelay => tisd_DI25_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI25_CLKW_noedge_posedge,
        SetupLow => tsetup_DI25_CLKW_noedge_posedge,
        HoldHigh => thold_DI25_CLKW_noedge_posedge,
        HoldLow => thold_DI25_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI25),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI25_CLKW_TimingDatash,
        Violation => tviol_DI25_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI25_dly,
        TestSignalName => "DI25",
        TestDelay => tisd_DI25_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI25_CLKW_noedge_negedge,
        SetupLow => tsetup_DI25_CLKW_noedge_negedge,
        HoldHigh => thold_DI25_CLKW_noedge_negedge,
        HoldLow => thold_DI25_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI25),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI25_CLKW_TimingDatash,
        Violation => tviol_DI25_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI26_dly,
        TestSignalName => "DI26",
        TestDelay => tisd_DI26_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI26_CLKW_noedge_posedge,
        SetupLow => tsetup_DI26_CLKW_noedge_posedge,
        HoldHigh => thold_DI26_CLKW_noedge_posedge,
        HoldLow => thold_DI26_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI26),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI26_CLKW_TimingDatash,
        Violation => tviol_DI26_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI26_dly,
        TestSignalName => "DI26",
        TestDelay => tisd_DI26_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI26_CLKW_noedge_negedge,
        SetupLow => tsetup_DI26_CLKW_noedge_negedge,
        HoldHigh => thold_DI26_CLKW_noedge_negedge,
        HoldLow => thold_DI26_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI26),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI26_CLKW_TimingDatash,
        Violation => tviol_DI26_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI27_dly,
        TestSignalName => "DI27",
        TestDelay => tisd_DI27_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI27_CLKW_noedge_posedge,
        SetupLow => tsetup_DI27_CLKW_noedge_posedge,
        HoldHigh => thold_DI27_CLKW_noedge_posedge,
        HoldLow => thold_DI27_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI27),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI27_CLKW_TimingDatash,
        Violation => tviol_DI27_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI27_dly,
        TestSignalName => "DI27",
        TestDelay => tisd_DI27_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI27_CLKW_noedge_negedge,
        SetupLow => tsetup_DI27_CLKW_noedge_negedge,
        HoldHigh => thold_DI27_CLKW_noedge_negedge,
        HoldLow => thold_DI27_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI27),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI27_CLKW_TimingDatash,
        Violation => tviol_DI27_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI28_dly,
        TestSignalName => "DI28",
        TestDelay => tisd_DI28_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI28_CLKW_noedge_posedge,
        SetupLow => tsetup_DI28_CLKW_noedge_posedge,
        HoldHigh => thold_DI28_CLKW_noedge_posedge,
        HoldLow => thold_DI28_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI28),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI28_CLKW_TimingDatash,
        Violation => tviol_DI28_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI28_dly,
        TestSignalName => "DI28",
        TestDelay => tisd_DI28_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI28_CLKW_noedge_negedge,
        SetupLow => tsetup_DI28_CLKW_noedge_negedge,
        HoldHigh => thold_DI28_CLKW_noedge_negedge,
        HoldLow => thold_DI28_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI28),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI28_CLKW_TimingDatash,
        Violation => tviol_DI28_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI29_dly,
        TestSignalName => "DI29",
        TestDelay => tisd_DI29_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI29_CLKW_noedge_posedge,
        SetupLow => tsetup_DI29_CLKW_noedge_posedge,
        HoldHigh => thold_DI29_CLKW_noedge_posedge,
        HoldLow => thold_DI29_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI29),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI29_CLKW_TimingDatash,
        Violation => tviol_DI29_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI29_dly,
        TestSignalName => "DI29",
        TestDelay => tisd_DI29_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI29_CLKW_noedge_negedge,
        SetupLow => tsetup_DI29_CLKW_noedge_negedge,
        HoldHigh => thold_DI29_CLKW_noedge_negedge,
        HoldLow => thold_DI29_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI29),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI29_CLKW_TimingDatash,
        Violation => tviol_DI29_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI30_dly,
        TestSignalName => "DI30",
        TestDelay => tisd_DI30_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI30_CLKW_noedge_posedge,
        SetupLow => tsetup_DI30_CLKW_noedge_posedge,
        HoldHigh => thold_DI30_CLKW_noedge_posedge,
        HoldLow => thold_DI30_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI30),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI30_CLKW_TimingDatash,
        Violation => tviol_DI30_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI30_dly,
        TestSignalName => "DI30",
        TestDelay => tisd_DI30_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI30_CLKW_noedge_negedge,
        SetupLow => tsetup_DI30_CLKW_noedge_negedge,
        HoldHigh => thold_DI30_CLKW_noedge_negedge,
        HoldLow => thold_DI30_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI30),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI30_CLKW_TimingDatash,
        Violation => tviol_DI30_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI31_dly,
        TestSignalName => "DI31",
        TestDelay => tisd_DI31_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI31_CLKW_noedge_posedge,
        SetupLow => tsetup_DI31_CLKW_noedge_posedge,
        HoldHigh => thold_DI31_CLKW_noedge_posedge,
        HoldLow => thold_DI31_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI31),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI31_CLKW_TimingDatash,
        Violation => tviol_DI31_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI31_dly,
        TestSignalName => "DI31",
        TestDelay => tisd_DI31_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI31_CLKW_noedge_negedge,
        SetupLow => tsetup_DI31_CLKW_noedge_negedge,
        HoldHigh => thold_DI31_CLKW_noedge_negedge,
        HoldLow => thold_DI31_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI31),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI31_CLKW_TimingDatash,
        Violation => tviol_DI31_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI32_dly,
        TestSignalName => "DI32",
        TestDelay => tisd_DI32_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI32_CLKW_noedge_posedge,
        SetupLow => tsetup_DI32_CLKW_noedge_posedge,
        HoldHigh => thold_DI32_CLKW_noedge_posedge,
        HoldLow => thold_DI32_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI32),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI32_CLKW_TimingDatash,
        Violation => tviol_DI32_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI32_dly,
        TestSignalName => "DI32",
        TestDelay => tisd_DI32_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI32_CLKW_noedge_negedge,
        SetupLow => tsetup_DI32_CLKW_noedge_negedge,
        HoldHigh => thold_DI32_CLKW_noedge_negedge,
        HoldLow => thold_DI32_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI32),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI32_CLKW_TimingDatash,
        Violation => tviol_DI32_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI33_dly,
        TestSignalName => "DI33",
        TestDelay => tisd_DI33_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI33_CLKW_noedge_posedge,
        SetupLow => tsetup_DI33_CLKW_noedge_posedge,
        HoldHigh => thold_DI33_CLKW_noedge_posedge,
        HoldLow => thold_DI33_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI33),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI33_CLKW_TimingDatash,
        Violation => tviol_DI33_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI33_dly,
        TestSignalName => "DI33",
        TestDelay => tisd_DI33_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI33_CLKW_noedge_negedge,
        SetupLow => tsetup_DI33_CLKW_noedge_negedge,
        HoldHigh => thold_DI33_CLKW_noedge_negedge,
        HoldLow => thold_DI33_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI33),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI33_CLKW_TimingDatash,
        Violation => tviol_DI33_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI34_dly,
        TestSignalName => "DI34",
        TestDelay => tisd_DI34_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI34_CLKW_noedge_posedge,
        SetupLow => tsetup_DI34_CLKW_noedge_posedge,
        HoldHigh => thold_DI34_CLKW_noedge_posedge,
        HoldLow => thold_DI34_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI34),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI34_CLKW_TimingDatash,
        Violation => tviol_DI34_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI34_dly,
        TestSignalName => "DI34",
        TestDelay => tisd_DI34_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI34_CLKW_noedge_negedge,
        SetupLow => tsetup_DI34_CLKW_noedge_negedge,
        HoldHigh => thold_DI34_CLKW_noedge_negedge,
        HoldLow => thold_DI34_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI34),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI34_CLKW_TimingDatash,
        Violation => tviol_DI34_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => DI35_dly,
        TestSignalName => "DI35",
        TestDelay => tisd_DI35_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI35_CLKW_noedge_posedge,
        SetupLow => tsetup_DI35_CLKW_noedge_posedge,
        HoldHigh => thold_DI35_CLKW_noedge_posedge,
        HoldLow => thold_DI35_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_DI35),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI35_CLKW_TimingDatash,
        Violation => tviol_DI35_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => DI35_dly,
        TestSignalName => "DI35",
        TestDelay => tisd_DI35_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_DI35_CLKW_noedge_negedge,
        SetupLow => tsetup_DI35_CLKW_noedge_negedge,
        HoldHigh => thold_DI35_CLKW_noedge_negedge,
        HoldLow => thold_DI35_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_DI35),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI35_CLKW_TimingDatash,
        Violation => tviol_DI35_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => WE_dly,
        TestSignalName => "WE",
        TestDelay => tisd_WE_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_WE_CLKW_noedge_posedge,
        SetupLow => tsetup_WE_CLKW_noedge_posedge,
        HoldHigh => thold_WE_CLKW_noedge_posedge,
        HoldLow => thold_WE_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_WE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WE_CLKW_TimingDatash,
        Violation => tviol_WE_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => WE_dly,
        TestSignalName => "WE",
        TestDelay => tisd_WE_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_WE_CLKW_noedge_negedge,
        SetupLow => tsetup_WE_CLKW_noedge_negedge,
        HoldHigh => thold_WE_CLKW_noedge_negedge,
        HoldLow => thold_WE_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_WE),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => WE_CLKW_TimingDatash,
        Violation => tviol_WE_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSW0_dly,
        TestSignalName => "CSW0",
        TestDelay => tisd_CSW0_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_CSW0_CLKW_noedge_posedge,
        SetupLow => tsetup_CSW0_CLKW_noedge_posedge,
        HoldHigh => thold_CSW0_CLKW_noedge_posedge,
        HoldLow => thold_CSW0_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_CSW0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSW0_CLKW_TimingDatash,
        Violation => tviol_CSW0_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSW0_dly,
        TestSignalName => "CSW0",
        TestDelay => tisd_CSW0_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_CSW0_CLKW_noedge_negedge,
        SetupLow => tsetup_CSW0_CLKW_noedge_negedge,
        HoldHigh => thold_CSW0_CLKW_noedge_negedge,
        HoldLow => thold_CSW0_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_CSW0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSW0_CLKW_TimingDatash,
        Violation => tviol_CSW0_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSW1_dly,
        TestSignalName => "CSW1",
        TestDelay => tisd_CSW1_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_CSW1_CLKW_noedge_posedge,
        SetupLow => tsetup_CSW1_CLKW_noedge_posedge,
        HoldHigh => thold_CSW1_CLKW_noedge_posedge,
        HoldLow => thold_CSW1_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_CSW1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSW1_CLKW_TimingDatash,
        Violation => tviol_CSW1_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSW1_dly,
        TestSignalName => "CSW1",
        TestDelay => tisd_CSW1_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_CSW1_CLKW_noedge_negedge,
        SetupLow => tsetup_CSW1_CLKW_noedge_negedge,
        HoldHigh => thold_CSW1_CLKW_noedge_negedge,
        HoldLow => thold_CSW1_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_CSW1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSW1_CLKW_TimingDatash,
        Violation => tviol_CSW1_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => FULLI_dly,
        TestSignalName => "FULLI",
        TestDelay => tisd_FULLI_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_FULLI_CLKW_noedge_posedge,
        SetupLow => tsetup_FULLI_CLKW_noedge_posedge,
        HoldHigh => thold_FULLI_CLKW_noedge_posedge,
        HoldLow => thold_FULLI_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_FULLI),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => FULLI_CLKW_TimingDatash,
        Violation => tviol_FULLI_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => FULLI_dly,
        TestSignalName => "FULLI",
        TestDelay => tisd_FULLI_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_FULLI_CLKW_noedge_negedge,
        SetupLow => tsetup_FULLI_CLKW_noedge_negedge,
        HoldHigh => thold_FULLI_CLKW_noedge_negedge,
        HoldLow => thold_FULLI_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_FULLI),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => FULLI_CLKW_TimingDatash,
        Violation => tviol_FULLI_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RST_dly,
        TestSignalName => "RST",
        TestDelay => tisd_RST_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_RST_CLKW_noedge_posedge,
        SetupLow => tsetup_RST_CLKW_noedge_posedge,
        HoldHigh => thold_RST_CLKW_noedge_posedge,
        HoldLow => thold_RST_CLKW_noedge_posedge,
        CheckEnabled => ((CLKW_NEGEDGE = FALSE) and check_RST),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RST_CLKW_TimingDatash,
        Violation => tviol_RST_CLKW,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RST_dly,
        TestSignalName => "RST",
        TestDelay => tisd_RST_CLKW,
        RefSignal => CLKW_dly,
        RefSignalName => "CLKW",
        RefDelay => ticd_CLKW,
        SetupHigh => tsetup_RST_CLKW_noedge_negedge,
        SetupLow => tsetup_RST_CLKW_noedge_negedge,
        HoldHigh => thold_RST_CLKW_noedge_negedge,
        HoldLow => thold_RST_CLKW_noedge_negedge,
        CheckEnabled => (CLKW_NEGEDGE and check_RST),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RST_CLKW_TimingDatash,
        Violation => tviol_RST_CLKW,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RPRST_dly,
        TestSignalName => "RPRST",
        TestDelay => tisd_RPRST_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_RPRST_CLKR_noedge_posedge,
        SetupLow => tsetup_RPRST_CLKR_noedge_posedge,
        HoldHigh => thold_RPRST_CLKR_noedge_posedge,
        HoldLow => thold_RPRST_CLKR_noedge_posedge,
        CheckEnabled => ((CLKR_NEGEDGE = FALSE) and check_RPRST),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RPRST_CLKR_TimingDatash,
        Violation => tviol_RPRST_CLKR,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RPRST_dly,
        TestSignalName => "RPRST",
        TestDelay => tisd_RPRST_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_RPRST_CLKR_noedge_negedge,
        SetupLow => tsetup_RPRST_CLKR_noedge_negedge,
        HoldHigh => thold_RPRST_CLKR_noedge_negedge,
        HoldLow => thold_RPRST_CLKR_noedge_negedge,
        CheckEnabled => (CLKR_NEGEDGE and check_RPRST),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RPRST_CLKR_TimingDatash,
        Violation => tviol_RPRST_CLKR,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => RE_dly,
        TestSignalName => "RE",
        TestDelay => tisd_RE_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_RE_CLKR_noedge_posedge,
        SetupLow => tsetup_RE_CLKR_noedge_posedge,
        HoldHigh => thold_RE_CLKR_noedge_posedge,
        HoldLow => thold_RE_CLKR_noedge_posedge,
        CheckEnabled => ((CLKR_NEGEDGE = FALSE) and check_RE),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RE_CLKR_TimingDatash,
        Violation => tviol_RE_CLKR,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => RE_dly,
        TestSignalName => "RE",
        TestDelay => tisd_RE_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_RE_CLKR_noedge_negedge,
        SetupLow => tsetup_RE_CLKR_noedge_negedge,
        HoldHigh => thold_RE_CLKR_noedge_negedge,
        HoldLow => thold_RE_CLKR_noedge_negedge,
        CheckEnabled => (CLKR_NEGEDGE and check_RE),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => RE_CLKR_TimingDatash,
        Violation => tviol_RE_CLKR,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSR0_dly,
        TestSignalName => "CSR0",
        TestDelay => tisd_CSR0_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_CSR0_CLKR_noedge_posedge,
        SetupLow => tsetup_CSR0_CLKR_noedge_posedge,
        HoldHigh => thold_CSR0_CLKR_noedge_posedge,
        HoldLow => thold_CSR0_CLKR_noedge_posedge,
        CheckEnabled => ((CLKR_NEGEDGE = FALSE) and check_CSR0),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSR0_CLKR_TimingDatash,
        Violation => tviol_CSR0_CLKR,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSR0_dly,
        TestSignalName => "CSR0",
        TestDelay => tisd_CSR0_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_CSR0_CLKR_noedge_negedge,
        SetupLow => tsetup_CSR0_CLKR_noedge_negedge,
        HoldHigh => thold_CSR0_CLKR_noedge_negedge,
        HoldLow => thold_CSR0_CLKR_noedge_negedge,
        CheckEnabled => (CLKR_NEGEDGE and check_CSR0),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSR0_CLKR_TimingDatash,
        Violation => tviol_CSR0_CLKR,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => CSR1_dly,
        TestSignalName => "CSR1",
        TestDelay => tisd_CSR1_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_CSR1_CLKR_noedge_posedge,
        SetupLow => tsetup_CSR1_CLKR_noedge_posedge,
        HoldHigh => thold_CSR1_CLKR_noedge_posedge,
        HoldLow => thold_CSR1_CLKR_noedge_posedge,
        CheckEnabled => ((CLKR_NEGEDGE = FALSE) and check_CSR1),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSR1_CLKR_TimingDatash,
        Violation => tviol_CSR1_CLKR,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CSR1_dly,
        TestSignalName => "CSR1",
        TestDelay => tisd_CSR1_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_CSR1_CLKR_noedge_negedge,
        SetupLow => tsetup_CSR1_CLKR_noedge_negedge,
        HoldHigh => thold_CSR1_CLKR_noedge_negedge,
        HoldLow => thold_CSR1_CLKR_noedge_negedge,
        CheckEnabled => (CLKR_NEGEDGE and check_CSR1),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CSR1_CLKR_TimingDatash,
        Violation => tviol_CSR1_CLKR,
        MsgSeverity => warning);

      VitalSetupHoldCheck (
        TestSignal => EMPTYI_dly,
        TestSignalName => "EMPTYI",
        TestDelay => tisd_EMPTYI_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_EMPTYI_CLKR_noedge_posedge,
        SetupLow => tsetup_EMPTYI_CLKR_noedge_posedge,
        HoldHigh => thold_EMPTYI_CLKR_noedge_posedge,
        HoldLow => thold_EMPTYI_CLKR_noedge_posedge,
        CheckEnabled => ((CLKR_NEGEDGE = FALSE) and check_EMPTYI),
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => EMPTYI_CLKR_TimingDatash,
        Violation => tviol_EMPTYI_CLKR,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => EMPTYI_dly,
        TestSignalName => "EMPTYI",
        TestDelay => tisd_EMPTYI_CLKR,
        RefSignal => CLKR_dly,
        RefSignalName => "CLKR",
        RefDelay => ticd_CLKR,
        SetupHigh => tsetup_EMPTYI_CLKR_noedge_negedge,
        SetupLow => tsetup_EMPTYI_CLKR_noedge_negedge,
        HoldHigh => thold_EMPTYI_CLKR_noedge_negedge,
        HoldLow => thold_EMPTYI_CLKR_noedge_negedge,
        CheckEnabled => (CLKR_NEGEDGE and check_EMPTYI),
        RefTransition => '\',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => EMPTYI_CLKR_TimingDatash,
        Violation => tviol_EMPTYI_CLKR,
        MsgSeverity => warning);

      VitalPeriodPulseCheck (
        TestSignal => CLKW_ipd,
        TestSignalName => "CLKW",
        Period => tperiod_CLKW,
        PulseWidthHigh => tpw_CLKW_posedge,
        PulseWidthLow => tpw_CLKW_negedge,
        PeriodData => periodcheckinfo_CLKW,
        Violation => tviol_CLKW,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
      VitalPeriodPulseCheck (
        TestSignal => CLKR_ipd,
        TestSignalName => "CLKR",
        Period => tperiod_CLKR,
        PulseWidthHigh => tpw_CLKR_posedge,
        PulseWidthLow => tpw_CLKR_negedge,
        PeriodData => periodcheckinfo_CLKR,
        Violation => tviol_CLKR,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
      VitalPeriodPulseCheck (
        TestSignal => RST_ipd,
        TestSignalName => "RST",
        Period => tperiod_RST,
        PulseWidthHigh => tpw_RST_posedge,
        PulseWidthLow => tpw_RST_negedge,
        PeriodData => periodcheckinfo_RST,
        Violation => tviol_RST,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);
      VitalPeriodPulseCheck (
        TestSignal => RPRST_ipd,
        TestSignalName => "RPRST",
        Period => tperiod_RPRST,
        PulseWidthHigh => tpw_RPRST_posedge,
        PulseWidthLow => tpw_RPRST_negedge,
        PeriodData => periodcheckinfo_RPRST,
        Violation => tviol_RPRST,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    DO0_zd    := DO0_dly;
    DO1_zd    := DO1_dly;
    DO2_zd    := DO2_dly;
    DO3_zd    := DO3_dly;
    DO4_zd    := DO4_dly;
    DO5_zd    := DO5_dly;
    DO6_zd    := DO6_dly;
    DO7_zd    := DO7_dly;
    DO8_zd    := DO8_dly;
    DO9_zd    := DO9_dly;
    DO10_zd    := DO10_dly;
    DO11_zd    := DO11_dly;
    DO12_zd    := DO12_dly;
    DO13_zd    := DO13_dly;
    DO14_zd    := DO14_dly;
    DO15_zd    := DO15_dly;
    DO16_zd    := DO16_dly;
    DO17_zd    := DO17_dly;
    DO18_zd    := DO18_dly;
    DO19_zd    := DO19_dly;
    DO20_zd    := DO20_dly;
    DO21_zd    := DO21_dly;
    DO22_zd    := DO22_dly;
    DO23_zd    := DO23_dly;
    DO24_zd    := DO24_dly;
    DO25_zd    := DO25_dly;
    DO26_zd    := DO26_dly;
    DO27_zd    := DO27_dly;
    DO28_zd    := DO28_dly;
    DO29_zd    := DO29_dly;
    DO30_zd    := DO30_dly;
    DO31_zd    := DO31_dly;
    DO32_zd    := DO32_dly;
    DO33_zd    := DO33_dly;
    DO34_zd    := DO34_dly;
    DO35_zd    := DO35_dly;
    EF_zd      := EF_dly;
    AEF_zd     := AEF_dly;
    FF_zd      := FF_dly;
    AFF_zd     := AFF_dly;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => DO0,
       OutSignalName => "DO0",
       OutTemp => DO0_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO0,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO0, PathCondition => TRUE)),
       GlitchData => DO0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO1,
       OutSignalName => "DO1",
       OutTemp => DO1_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO1,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO1, PathCondition => TRUE)),
       GlitchData => DO1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO2,
       OutSignalName => "DO2",
       OutTemp => DO2_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO2,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO2, PathCondition => TRUE)),
       GlitchData => DO2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO3,
       OutSignalName => "DO3",
       OutTemp => DO3_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO3,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO3, PathCondition => TRUE)),
       GlitchData => DO3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO4,
       OutSignalName => "DO4",
       OutTemp => DO4_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO4,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO4, PathCondition => TRUE)),
       GlitchData => DO4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO5,
       OutSignalName => "DO5",
       OutTemp => DO5_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO5,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO5, PathCondition => TRUE)),
       GlitchData => DO5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO6,
       OutSignalName => "DO6",
       OutTemp => DO6_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO6,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO6, PathCondition => TRUE)),
       GlitchData => DO6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO7,
       OutSignalName => "DO7",
       OutTemp => DO7_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO7,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO7, PathCondition => TRUE)),
       GlitchData => DO7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO8,
       OutSignalName => "DO8",
       OutTemp => DO8_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO8,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO8, PathCondition => TRUE)),
       GlitchData => DO8_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO9,
       OutSignalName => "DO9",
       OutTemp => DO9_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO9,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO9, PathCondition => TRUE)),
       GlitchData => DO9_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO10,
       OutSignalName => "DO10",
       OutTemp => DO10_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO10,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO10, PathCondition => TRUE)),
       GlitchData => DO10_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO11,
       OutSignalName => "DO11",
       OutTemp => DO11_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO11,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO11, PathCondition => TRUE)),
       GlitchData => DO11_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO12,
       OutSignalName => "DO12",
       OutTemp => DO12_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO12,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO12, PathCondition => TRUE)),
       GlitchData => DO12_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO13,
       OutSignalName => "DO13",
       OutTemp => DO13_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO13,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO13, PathCondition => TRUE)),
       GlitchData => DO13_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO14,
       OutSignalName => "DO14",
       OutTemp => DO14_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO14,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO14, PathCondition => TRUE)),
       GlitchData => DO14_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO15,
       OutSignalName => "DO15",
       OutTemp => DO15_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO15,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO15, PathCondition => TRUE)),
       GlitchData => DO15_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO16,
       OutSignalName => "DO16",
       OutTemp => DO16_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO16,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO16, PathCondition => TRUE)),
       GlitchData => DO16_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO17,
       OutSignalName => "DO17",
       OutTemp => DO17_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO17,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO17, PathCondition => TRUE)),
       GlitchData => DO17_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO18,
       OutSignalName => "DO18",
       OutTemp => DO18_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO18,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO18, PathCondition => TRUE)),
       GlitchData => DO18_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO19,
       OutSignalName => "DO19",
       OutTemp => DO19_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO19,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO19, PathCondition => TRUE)),
       GlitchData => DO19_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO20,
       OutSignalName => "DO20",
       OutTemp => DO20_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO20,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO20, PathCondition => TRUE)),
       GlitchData => DO20_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO21,
       OutSignalName => "DO21",
       OutTemp => DO21_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO21,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO21, PathCondition => TRUE)),
       GlitchData => DO21_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO22,
       OutSignalName => "DO22",
       OutTemp => DO22_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO22,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO22, PathCondition => TRUE)),
       GlitchData => DO22_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO23,
       OutSignalName => "DO23",
       OutTemp => DO23_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO23,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO23, PathCondition => TRUE)),
       GlitchData => DO23_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO24,
       OutSignalName => "DO24",
       OutTemp => DO24_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO24,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO24, PathCondition => TRUE)),
       GlitchData => DO24_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO25,
       OutSignalName => "DO25",
       OutTemp => DO25_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO25,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO25, PathCondition => TRUE)),
       GlitchData => DO25_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO26,
       OutSignalName => "DO26",
       OutTemp => DO26_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO26,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO26, PathCondition => TRUE)),
       GlitchData => DO26_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO27,
       OutSignalName => "DO27",
       OutTemp => DO27_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO27,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO27, PathCondition => TRUE)),
       GlitchData => DO27_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO28,
       OutSignalName => "DO28",
       OutTemp => DO28_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO28,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO28, PathCondition => TRUE)),
       GlitchData => DO28_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO29,
       OutSignalName => "DO29",
       OutTemp => DO29_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO29,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO29, PathCondition => TRUE)),
       GlitchData => DO29_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO30,
       OutSignalName => "DO30",
       OutTemp => DO30_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO30,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO30, PathCondition => TRUE)),
       GlitchData => DO30_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO31,
       OutSignalName => "DO31",
       OutTemp => DO31_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO31,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO31, PathCondition => TRUE)),
       GlitchData => DO31_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO32,
       OutSignalName => "DO32",
       OutTemp => DO32_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO32,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO32, PathCondition => TRUE)),
       GlitchData => DO32_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO33,
       OutSignalName => "DO33",
       OutTemp => DO33_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO33,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO33, PathCondition => TRUE)),
       GlitchData => DO33_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO34,
       OutSignalName => "DO34",
       OutTemp => DO34_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO34,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO34, PathCondition => TRUE)),
       GlitchData => DO34_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => DO35,
       OutSignalName => "DO35",
       OutTemp => DO35_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_DO35,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_DO35, PathCondition => TRUE)),
       GlitchData => DO35_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => EF,
       OutSignalName => "EF",
       OutTemp => EF_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_EF,
                       PathCondition => TRUE),
                 1 => (RPRST_dly'last_event, tpd_RPRST_EF, PathCondition => TRUE)),
       GlitchData => EF_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => AEF,
       OutSignalName => "AEF",
       OutTemp => AEF_zd,
       Paths => (0 => (InputChangeTime => CLKR_dly'last_event,
                       PathDelay => tpd_CLKR_AEF,
                       PathCondition => TRUE),
                 1 => (RPRST_dly'last_event, tpd_RPRST_AEF, PathCondition => TRUE)),
       GlitchData => AEF_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => FF,
       OutSignalName => "FF",
       OutTemp => FF_zd,
       Paths => (0 => (InputChangeTime => CLKW_dly'last_event,
                       PathDelay => tpd_CLKW_FF,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_FF, PathCondition => TRUE)),
       GlitchData => FF_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => AFF,
       OutSignalName => "AFF",
       OutTemp => AFF_zd,
       Paths => (0 => (InputChangeTime => CLKW_dly'last_event,
                       PathDelay => tpd_CLKW_AFF,
                       PathCondition => TRUE),
                 1 => (RST_dly'last_event, tpd_RST_AFF, PathCondition => TRUE)),
       GlitchData => AFF_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

    END PROCESS;

END v;


