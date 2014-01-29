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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCA_MPI.vhd,v 1.18 2005/05/19 20:04:55 pradeep Exp $ 
--

--
--    cell pur
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;
 
 
ENTITY pur IS
    GENERIC(
        timingcheckson  : boolean      := FALSE;
        XOn             : boolean      := FALSE;
        MsgOn           : boolean      := FALSE;
        InstancePath    : string       := "pur"
        );
 
    PORT(
        pur             : IN STD_LOGIC := 'Z'
        );
END pur;
 

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
--    cell mpicore
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;
USE work.global.purnet;

ENTITY mpicore IS
    PORT(
        validacc: IN  STD_LOGIC;
        resetacc: OUT STD_LOGIC;

        clk:       IN  STD_LOGIC;
        rdwrn:     IN  STD_LOGIC;
        addr:      IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
        din:       IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);

        ddrvctl:   OUT STD_LOGIC;
        irqn:      OUT STD_LOGIC;
        ackn:      OUT STD_LOGIC;
        dout:      OUT STD_LOGIC_VECTOR( 7 DOWNTO 0);
 
        uend:      IN  STD_LOGIC;
        uirqn:     IN  STD_LOGIC;
        udout:     IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);

        mpgsr:     OUT STD_LOGIC;
        urdwrn:    OUT STD_LOGIC;
        ustart:    OUT STD_LOGIC;
        uaddr:     OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
        udin:      OUT STD_LOGIC_VECTOR( 7 DOWNTO 0)
        );

    ATTRIBUTE Vital_Level0 OF mpicore : ENTITY IS TRUE;

END mpicore;
 
 
ARCHITECTURE v OF mpicore IS
    
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    TYPE   mpi_op  IS (idle, sys_rdwr, ack, user);
 
    SIGNAL mpi_state:    mpi_op;
 
    SIGNAL ctrl_reg1:    STD_LOGIC_vector(7 DOWNTO 0) := "1X1XXXX0";
    SIGNAL ctrl_reg2:    STD_LOGIC_vector(7 DOWNTO 0) := "XX000000";
    SIGNAL scra_reg:     STD_LOGIC_vector(7 DOWNTO 0) := "XXXXXXXX";
    SIGNAL stat_reg:     STD_LOGIC_vector(7 DOWNTO 0) := "XXXXXXXX";
    SIGNAL sdout:        STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL ackn_int:     STD_LOGIC;
    SIGNAL irq_enbl:     STD_LOGIC;
    SIGNAL irq_pend:     STD_LOGIC;
 
BEGIN
 
    urdwrn  <= rdwrn;
    uaddr   <= addr(3 DOWNTO 0);
    udin    <= din;
 
    ackn    <= ackn_int;
    mpgsr   <= ctrl_reg1(0);
    dout    <= sdout WHEN addr(4) = '0'
        ELSE  udout;
 
    main : PROCESS ( clk, validacc, purnet)
    BEGIN
        IF (purnet = '0') THEN
            ctrl_reg1 <= "10100000";
            ctrl_reg2 <= "00000000";
            scra_reg  <= "00000000";
--            stat_reg  <= "00000000";
            mpi_state <= idle;
            ackn_int  <= '1';
            ustart    <= '0';
            ddrvctl   <= '1';
            sdout     <= "00000000";
            irq_pend <= '0';
 
        ELSIF (validacc = '0') THEN
            mpi_state <= idle;
            ackn_int  <= '1';
            ustart    <= '0';
            ddrvctl   <= '1';
 
        ELSIF
           (clk'event AND clk = '1') THEN
 
        case mpi_state is
            when idle =>
                    ddrvctl <= '1';
                    ackn_int  <= '1';
                if (addr(4) = '0') then
                    mpi_state <= sys_rdwr;
                else
                    mpi_state <= user;
                end if;
 
            when sys_rdwr =>
                mpi_state <= ack;
                CASE addr(3 DOWNTO 0) IS
                    WHEN "0000" =>
                        IF (rdwrn = '1') THEN
                            sdout     <= ctrl_reg1;
                        ELSE
                            ctrl_reg1 <= din;
                        END IF;
                    WHEN "0001" =>
                        IF (rdwrn = '1') THEN
                            sdout     <= ctrl_reg2;
                        ELSE
                            ctrl_reg2 <= din;
                        END IF;
                    WHEN "0010" =>
                        IF (rdwrn = '1') THEN
                            sdout     <= scra_reg;
                        ELSE
                            scra_reg  <= din;
                        END IF;
                    WHEN "0011" =>
                        IF (rdwrn = '1') THEN
                            sdout     <= stat_reg;
                            irq_pend <= '0'; 
                        END IF;
                    WHEN OTHERS =>
                        ASSERT false
                            REPORT "Access to unsupported register!"
                            SEVERITY WARNING;
                END CASE;
                IF (rdwrn = '1') THEN
                    ddrvctl   <= '0';
                ELSE
                    ddrvctl   <= '1';
                END IF;
 
            when ack =>
                mpi_state <= idle;
                ackn_int  <= '0';
                ustart    <= '0';
 
            when user =>
                ustart  <= '1';
                IF (rdwrn = '1') THEN
                    ddrvctl   <= '0';
                ELSE
                    ddrvctl   <= '1';
                END IF;
                IF (uend = '1') THEN
                    mpi_state <= ack;
                ELSE
                    mpi_state <= user;
                END IF;
 
        END CASE;
      END IF;
    END PROCESS main;
 
    irq_set: PROCESS (purnet, uirqn, clk)
    BEGIN
            IF (purnet = '0') THEN
            stat_reg  <= "00000000";
            ELSIF (uirqn = '0') THEN
               IF ((mpi_state /= sys_rdwr) or (addr /="00011") or (rdwrn /= '1')) THEN
                  stat_reg(2) <= '1';
            ELSE 
               IF (clk'event and clk = '1') THEN 
                 IF ((mpi_state = sys_rdwr) and (addr ="00011") and (rdwrn = '1')) THEN
                    stat_reg(2) <= irq_pend;
                 END IF;
               END IF;
               END IF;
            END IF;
    END PROCESS irq_set;
 
    rst_acc: PROCESS ( clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF ackn_int = '0' THEN
                resetacc <= '1';
            ELSE
                resetacc <= '0';
            END IF;
        END IF;
    END PROCESS rst_acc;
 
    irq_enbl <= ctrl_reg2(2);
 
    irq : PROCESS (uirqn, irq_enbl, purnet)
    BEGIN
        IF (purnet = '0') THEN
            irqn    <= '1';
        ELSIF (irq_enbl  = '1') THEN
            irqn    <= uirqn;
        END IF;
    END PROCESS irq;
 
END v;


--
--    cell mpippc
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;
USE work.global.purnet;

ENTITY mpippc IS
 
    GENERIC(
        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean          := TRUE;
        XOn             : Boolean          := FALSE;
        MsgOn           : Boolean          := TRUE;
        InstancePath    : String           := "mpippc";
 
        -- Input Signal Delays
        tipd_clk        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cs0n       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cs1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rdwrn      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_tsn        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_a27        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_a28        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_a29        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_a30        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_a31        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din7       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din6       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din5       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din4       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din3       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din2       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din1       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_din0       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_uend       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_uirqn      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout7     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout6     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout5     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout4     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout3     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout2     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout1     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout0     : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
        -- Output Signal Delays
        tpd_clk_bin       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_tan       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rdwrn_urdwrn  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_ustart    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_a28_ua3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_a29_ua2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_a30_ua1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_a31_ua0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_irqn    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_ddrvctl : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_tants   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout7   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout6   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout5   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout4   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout3   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout2   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_mpgsr   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin7   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin6   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin5   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin4   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin3   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin2   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin0   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- setup and hold constraints
        tsetup_cs1_tsn_noedge_posedge       : VitalDelayType := 0.01 ns;
        thold_cs1_tsn_noedge_posedge        : VitalDelayType := 0.01 ns;
        tsetup_cs0n_tsn_noedge_posedge      : VitalDelayType := 0.01 ns;
        thold_cs0n_tsn_noedge_posedge       : VitalDelayType := 0.01 ns;
        tsetup_uend_clk_noedge_posedge      : VitalDelayType := 0.01 ns;
        thold_uend_clk_noedge_posedge       : VitalDelayType := 0.01 ns);
 
   PORT(
        -- MP I/O
        clk:     IN  STD_LOGIC;
        cs0n:    IN  STD_LOGIC;
        cs1:     IN  STD_LOGIC;
        rdwrn:   IN  STD_LOGIC;
        tsn:     IN  STD_LOGIC;
        a27:     IN  STD_LOGIC;
        a28:     IN  STD_LOGIC;
        a29:     IN  STD_LOGIC;
        a30:     IN  STD_LOGIC;
        a31:     IN  STD_LOGIC;
        din7:    IN  STD_LOGIC;
        din6:    IN  STD_LOGIC;
        din5:    IN  STD_LOGIC;
        din4:    IN  STD_LOGIC;
        din3:    IN  STD_LOGIC;
        din2:    IN  STD_LOGIC;
        din1:    IN  STD_LOGIC;
        din0:    IN  STD_LOGIC;

        uend:    IN  STD_LOGIC;
        uirqn:   IN  STD_LOGIC;
        udout7:  IN  STD_LOGIC;
        udout6:  IN  STD_LOGIC;
        udout5:  IN  STD_LOGIC;
        udout4:  IN  STD_LOGIC;
        udout3:  IN  STD_LOGIC;
        udout2:  IN  STD_LOGIC;
        udout1:  IN  STD_LOGIC;
        udout0:  IN  STD_LOGIC;

        dout7:   OUT STD_LOGIC;
        dout6:   OUT STD_LOGIC;
        dout5:   OUT STD_LOGIC;
        dout4:   OUT STD_LOGIC;
        dout3:   OUT STD_LOGIC;
        dout2:   OUT STD_LOGIC;
        dout1:   OUT STD_LOGIC;
        dout0:   OUT STD_LOGIC;
        ddrvctl: OUT STD_LOGIC;
        bin:     OUT STD_LOGIC;
        irqn:    OUT STD_LOGIC;
        tan:     OUT STD_LOGIC;
        tants:  OUT STD_LOGIC;
 
        mpgsr:   OUT STD_LOGIC;
        urdwrn:  OUT STD_LOGIC;
        ustart:  OUT STD_LOGIC;
        ua3:     OUT STD_LOGIC;
        ua2:     OUT STD_LOGIC;
        ua1:     OUT STD_LOGIC;
        ua0:     OUT STD_LOGIC;
        udin7:   OUT STD_LOGIC;
        udin6:   OUT STD_LOGIC;
        udin5:   OUT STD_LOGIC;
        udin4:   OUT STD_LOGIC;
        udin3:   OUT STD_LOGIC;
        udin2:   OUT STD_LOGIC;
        udin1:   OUT STD_LOGIC;
        udin0:   OUT STD_LOGIC
        );

    ATTRIBUTE Vital_Level0 OF mpippc : ENTITY IS TRUE;
 
END mpippc;
 
ARCHITECTURE v OF mpippc IS

    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    COMPONENT mpicore
        PORT (
            validacc: IN  STD_LOGIC;
            resetacc: OUT STD_LOGIC;
            clk:       IN  STD_LOGIC;
            rdwrn:     IN  STD_LOGIC;
            addr:      IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
            din:       IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
            ddrvctl:   OUT STD_LOGIC;
            irqn:      OUT STD_LOGIC;
            ackn:      OUT STD_LOGIC;
            dout:      OUT STD_LOGIC_VECTOR( 7 DOWNTO 0);
            uend:      IN  STD_LOGIC;
            uirqn:     IN  STD_LOGIC;
            udout:     IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
            mpgsr:     OUT STD_LOGIC;
            urdwrn:    OUT STD_LOGIC;
            ustart:    OUT STD_LOGIC;
            uaddr:     OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
            udin:      OUT STD_LOGIC_VECTOR( 7 DOWNTO 0)
            );
    END COMPONENT;

    SIGNAL clk_ipd:      STD_LOGIC := 'X';
    SIGNAL cs0n_ipd:     STD_LOGIC := 'X';
    SIGNAL cs1_ipd:      STD_LOGIC := 'X';
    SIGNAL rdwrn_ipd:    STD_LOGIC := 'X';
    SIGNAL tsn_ipd:      STD_LOGIC := 'X';
    SIGNAL a_ipd:        STD_LOGIC_vector(27 TO 31)   := (others => 'X');
    SIGNAL din_ipd:      STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL uend_ipd:     STD_LOGIC := 'X';
    SIGNAL uirqn_ipd:    STD_LOGIC := 'X';
    SIGNAL udout_ipd:    STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL bin_tmp:      STD_LOGIC := 'X';
    SIGNAL tants_tmp:   STD_LOGIC := 'X';
    SIGNAL tan_hold:     STD_LOGIC := 'X';
    SIGNAL ddrvctl_tmp:  STD_LOGIC := 'X';
    SIGNAL irqn_tmp:     STD_LOGIC := 'X';
    SIGNAL tan_tmp:      STD_LOGIC := 'X';
    SIGNAL dout_tmp:     STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL mpgsr_tmp:    STD_LOGIC := 'X';
    SIGNAL urdwrn_tmp:   STD_LOGIC := 'X';
    SIGNAL ustart_tmp:   STD_LOGIC := 'X';
    SIGNAL ua_tmp:       STD_LOGIC_vector(3 DOWNTO 0) := (others => 'X');
    SIGNAL udin_tmp:     STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL set_acc  :    STD_LOGIC := '0';
    SIGNAL validacc:    STD_LOGIC := '0';
    SIGNAL resetacc:    STD_LOGIC := '0';
 
BEGIN
 
    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : BLOCK
    BEGIN
        VitalWireDelay (clk_ipd,      clk,     tipd_clk);
        VitalWireDelay (cs0n_ipd,     cs0n,    tipd_cs0n);
        VitalWireDelay (cs1_ipd,      cs1,     tipd_cs1);
        VitalWireDelay (rdwrn_ipd,    rdwrn,   tipd_rdwrn);
        VitalWireDelay (tsn_ipd,      tsn,     tipd_tsn);
        VitalWireDelay (a_ipd(27),    a27,     tipd_a27);
        VitalWireDelay (a_ipd(28),    a28,     tipd_a28);
        VitalWireDelay (a_ipd(29),    a29,     tipd_a29);
        VitalWireDelay (a_ipd(30),    a30,     tipd_a30);
        VitalWireDelay (a_ipd(31),    a31,     tipd_a31);
        VitalWireDelay (din_ipd(7),   din7,    tipd_din7);
        VitalWireDelay (din_ipd(6),   din6,    tipd_din6);
        VitalWireDelay (din_ipd(5),   din5,    tipd_din5);
        VitalWireDelay (din_ipd(4),   din4,    tipd_din4);
        VitalWireDelay (din_ipd(3),   din3,    tipd_din3);
        VitalWireDelay (din_ipd(2),   din2,    tipd_din2);
        VitalWireDelay (din_ipd(1),   din1,    tipd_din1);
        VitalWireDelay (din_ipd(0),   din0,    tipd_din0);
        VitalWireDelay (uend_ipd,     uend,    tipd_uend);
        VitalWireDelay (uirqn_ipd,    uirqn,   tipd_uirqn);
        VitalWireDelay (udout_ipd(7), udout7,  tipd_udout7);
        VitalWireDelay (udout_ipd(6), udout6,  tipd_udout6);
        VitalWireDelay (udout_ipd(5), udout5,  tipd_udout5);
        VitalWireDelay (udout_ipd(4), udout4,  tipd_udout4);
        VitalWireDelay (udout_ipd(3), udout3,  tipd_udout3);
        VitalWireDelay (udout_ipd(2), udout2,  tipd_udout2);
        VitalWireDelay (udout_ipd(1), udout1,  tipd_udout1);
        VitalWireDelay (udout_ipd(0), udout0,  tipd_udout0);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
 
    bin_tmp <= tan_tmp;

    chk_acc : PROCESS (cs0n_ipd, cs1_ipd, tsn_ipd, resetacc, purnet)
    BEGIN
        IF (purnet = '0') OR (resetacc = '1') OR
           (cs0n_ipd /= '0') OR (cs1_ipd /= '1') THEN
            validacc <= '0';
            set_acc   <= '0';
        ELSE
            IF tsn_ipd = '0' THEN
                set_acc <= '1';
            ELSE
                validacc <= set_acc;
            END IF;
        END IF;
    END PROCESS chk_acc;

    tri_contl : PROCESS ( purnet, clk)
    BEGIN
        IF  (clk'event AND clk = '0') THEN
           tan_hold <= tan_tmp;
        END IF;
    END PROCESS tri_contl;

    tants_tmp <= tan_hold and tan_tmp;
 
    mpicore0: mpicore
    PORT MAP (
        validacc => validacc,
        resetacc => resetacc,
        clk       => clk_ipd,
        rdwrn     => rdwrn_ipd,
        addr      => a_ipd,
        din       => din_ipd,
        ddrvctl   => ddrvctl_tmp,
        irqn      => irqn_tmp,
        ackn      => tan_tmp,
        dout      => dout_tmp,
        uend      => uend_ipd,
        uirqn     => uirqn_ipd,
        udout     => udout_ipd,
        mpgsr     => mpgsr_tmp,
        urdwrn    => urdwrn_tmp,
        ustart    => ustart_tmp,
        uaddr     => ua_tmp,
        udin      => udin_tmp
        );
 
    vital_output : PROCESS (purnet, clk_ipd, tants_tmp, 
                      bin_tmp, ddrvctl_tmp, irqn_tmp, tan_tmp, dout_tmp,
                      mpgsr_tmp, urdwrn_tmp, ua_tmp, ustart_tmp, udin_tmp)
        VARIABLE bin_zd:              STD_LOGIC;
        VARIABLE ddrvctl_zd:          STD_LOGIC;
        VARIABLE irqn_zd:             STD_LOGIC;
        VARIABLE tan_zd:              STD_LOGIC;
        VARIABLE tants_zd:           STD_LOGIC;
        VARIABLE dout_zd:             STD_LOGIC_vector(7 DOWNTO 0);
        VARIABLE mpgsr_zd:            STD_LOGIC;
        VARIABLE urdwrn_zd:           STD_LOGIC;
        VARIABLE ua_zd:               STD_LOGIC_vector(3 DOWNTO 0);
        VARIABLE ustart_zd:           STD_LOGIC;
        VARIABLE udin_zd:             STD_LOGIC_vector(7 DOWNTO 0);

     -- timing check results
        VARIABLE tviol_uend   : x01 := '0';
        VARIABLE tviol_cs1    : x01 := '0';
        VARIABLE tviol_cs0n   : x01 := '0';
        VARIABLE uend_clk_TimingDatash : VitalTimingDataType;
        VARIABLE cs1_tsn_TimingDatash  : VitalTimingDataType;
        VARIABLE cs0n_tsn_TimingDatash : VitalTimingDataType;

     -- functionality results
        VARIABLE violation : x01 := '0';

     -- output glitch results
        VARIABLE bin_GlitchData:      VitalGlitchDataType;
        VARIABLE tan_GlitchData:      VitalGlitchDataType;
        VARIABLE tsn_GlitchData:      VitalGlitchDataType;
        VARIABLE urdwrn_GlitchData:   VitalGlitchDataType;
        VARIABLE ua3_GlitchData:      VitalGlitchDataType;
        VARIABLE ua2_GlitchData:      VitalGlitchDataType;
        VARIABLE ua1_GlitchData:      VitalGlitchDataType;
        VARIABLE ua0_GlitchData:      VitalGlitchDataType;
        VARIABLE ustart_GlitchData:   VitalGlitchDataType;
        VARIABLE ddrvctl_GlitchData:  VitalGlitchDataType;
        VARIABLE irqn_GlitchData:     VitalGlitchDataType;
        VARIABLE tants_GlitchData:   VitalGlitchDataType;
        VARIABLE dout7_GlitchData:    VitalGlitchDataType;
        VARIABLE dout6_GlitchData:    VitalGlitchDataType;
        VARIABLE dout5_GlitchData:    VitalGlitchDataType;
        VARIABLE dout4_GlitchData:    VitalGlitchDataType;
        VARIABLE dout3_GlitchData:    VitalGlitchDataType;
        VARIABLE dout2_GlitchData:    VitalGlitchDataType;
        VARIABLE dout1_GlitchData:    VitalGlitchDataType;
        VARIABLE dout0_GlitchData:    VitalGlitchDataType;
        VARIABLE mpgsr_GlitchData:    VitalGlitchDataType;
        VARIABLE udin7_GlitchData:    VitalGlitchDataType;
        VARIABLE udin6_GlitchData:    VitalGlitchDataType;
        VARIABLE udin5_GlitchData:    VitalGlitchDataType;
        VARIABLE udin4_GlitchData:    VitalGlitchDataType;
        VARIABLE udin3_GlitchData:    VitalGlitchDataType;
        VARIABLE udin2_GlitchData:    VitalGlitchDataType;
        VARIABLE udin1_GlitchData:    VitalGlitchDataType;
        VARIABLE udin0_GlitchData:    VitalGlitchDataType;

    BEGIN

   -----------------------
   -- timing check section
   -----------------------
        IF (TimingChecksOn) THEN

           -- setup and hold checks
           VitalSetupHoldCheck (
                TestSignal => uend_ipd,
                TestSignalName => "uend",
                RefSignal => clk_ipd,
                RefSignalName => "clk",
                SetupHigh => tsetup_uend_clk_noedge_posedge,
                setuplow => tsetup_uend_clk_noedge_posedge,
                HoldHigh => thold_uend_clk_noedge_posedge,
                HoldLow => thold_uend_clk_noedge_posedge,
                CheckEnabled => purnet='1',
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => uend_clk_TimingDatash,
                Violation => tviol_uend,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => cs1_ipd,
                TestSignalName => "cs1",
                RefSignal => tsn_ipd,
                RefSignalName => "tsn",
                SetupHigh => tsetup_cs1_tsn_noedge_posedge,
                setuplow => tsetup_cs1_tsn_noedge_posedge,
                HoldHigh => thold_cs1_tsn_noedge_posedge,
                Holdlow => thold_cs1_tsn_noedge_posedge,
                CheckEnabled => purnet='1',
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => cs1_tsn_TimingDatash,
                Violation => tviol_cs1,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => cs0n_ipd,
                TestSignalName => "cs0n",
                RefSignal => tsn_ipd,
                RefSignalName => "tsn",
                SetupHigh => tsetup_cs0n_tsn_noedge_posedge,
                Setuplow => tsetup_cs0n_tsn_noedge_posedge,
                HoldHigh => thold_cs0n_tsn_noedge_posedge,
                Holdlow => thold_cs0n_tsn_noedge_posedge,
                CheckEnabled => purnet='1',
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => cs0n_tsn_TimingDatash,
                Violation => tviol_cs0n,
                MsgSeverity => warning);
   END IF;

   ------------------------
   -- functionality section
   ------------------------

        Violation := tviol_uend OR tviol_cs1 OR tviol_cs0n;

--   IF (Violation = '0') THEN
        bin_zd      := bin_tmp;
        ddrvctl_zd  := ddrvctl_tmp;
        irqn_zd     := irqn_tmp;
        tan_zd      := tan_tmp;
        tants_zd   := tants_tmp;
        dout_zd     := dout_tmp;
        mpgsr_zd    := mpgsr_tmp;
        urdwrn_zd   := urdwrn_tmp;
        ua_zd       := ua_tmp;
        ustart_zd   := ustart_tmp;
        udin_zd     := udin_tmp;
--    ELSE
--        bin_zd      := 'X';
--        ddrvctl_zd  := 'X';
--        irqn_zd     := 'X';
--        tan_zd      := 'X';
--        tants_zd   := 'X';
--        dout_zd     := "XXXXXXXX";
--        mpgsr_zd    := 'X';
--        urdwrn_zd   := 'X';
--        ua_zd       := "XXXX";
--        ustart_zd   := 'X';
--        udin_zd     := "XXXXXXXX";
--    END IF; 

    VitalPathDelay01 (
        OutSignal  => bin, OutSignalName => "bin", OutTemp => bin_zd,
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_bin, TRUE)),
        GlitchData => bin_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => ddrvctl, OutSignalName => "ddrvctl", OutTemp => ddrvctl_zd,
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_ddrvctl, TRUE)),
        GlitchData => ddrvctl_GlitchData,
        Mode => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => irqn, OutSignalName => "irqn", OutTemp => irqn_zd,
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_irqn, TRUE)),
        GlitchData => irqn_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => tan, OutSignalName => "tan", OutTemp => tan_zd,
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_tan, TRUE)),
        GlitchData => tan_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => tants, OutSignalName => "tants", OutTemp => tants_zd,
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_tants, TRUE)),
        GlitchData => tants_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout7, OutSignalName => "dout7", OutTemp => dout_zd(7),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout7, TRUE)),
        GlitchData => dout7_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout6, OutSignalName => "dout6", OutTemp => dout_zd(6),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout6, TRUE)),
        GlitchData => dout6_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout5, OutSignalName => "dout5", OutTemp => dout_zd(5),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout5, TRUE)),
        GlitchData => dout5_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout4, OutSignalName => "dout4", OutTemp => dout_zd(4),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout4, TRUE)),
        GlitchData => dout4_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout3, OutSignalName => "dout3", OutTemp => dout_zd(3),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout3, TRUE)),
        GlitchData => dout3_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout2, OutSignalName => "dout2", OutTemp => dout_zd(2),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout2, TRUE)),
        GlitchData => dout2_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout1, OutSignalName => "dout1", OutTemp => dout_zd(1),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout1, TRUE)),
        GlitchData => dout1_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => dout0, OutSignalName => "dout0", OutTemp => dout_zd(0),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout0, TRUE)),
        GlitchData => dout0_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => mpgsr, OutSignalName => "mpgsr", OutTemp => mpgsr_zd,
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_mpgsr, TRUE)),
        GlitchData => mpgsr_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => urdwrn, OutSignalName => "urdwrn", OutTemp => urdwrn_zd,
        Paths      => (0 => (rdwrn_ipd'last_event, tpd_rdwrn_urdwrn, TRUE)),
        GlitchData => urdwrn_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn);
    VitalPathDelay01 (
        OutSignal  => ua3, OutSignalName => "ua3", OutTemp => ua_zd(3),
        Paths      => (0 => (a_ipd(28)'last_event, tpd_a28_ua3, TRUE)),
        GlitchData => ua3_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => ua2, OutSignalName => "ua2", OutTemp => ua_zd(2),
        Paths      => (0 => (a_ipd(29)'last_event, tpd_a29_ua2, TRUE)),
        GlitchData => ua2_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => ua1, OutSignalName => "ua1", OutTemp => ua_zd(1),
        Paths      => (0 => (a_ipd(30)'last_event, tpd_a30_ua1, TRUE)),
        GlitchData => ua1_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => ua0, OutSignalName => "ua0", OutTemp => ua_zd(0),
        Paths      => (0 => (a_ipd(31)'last_event, tpd_a31_ua0, TRUE)),
        GlitchData => ua0_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => ustart, OutSignalName => "ustart", OutTemp => ustart_zd,
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_ustart, TRUE)),
        GlitchData => ustart_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin7, OutSignalName => "udin7", OutTemp => udin_zd(7),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin7, TRUE)),
        GlitchData => udin7_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin6, OutSignalName => "udin6", OutTemp => udin_zd(6),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin6, TRUE)),
        GlitchData => udin6_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin5, OutSignalName => "udin5", OutTemp => udin_zd(5),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin5, TRUE)),
        GlitchData => udin5_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin4, OutSignalName => "udin4", OutTemp => udin_zd(4),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin4, TRUE)),
        GlitchData => udin4_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin3, OutSignalName => "udin3", OutTemp => udin_zd(3),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin3, TRUE)),
        GlitchData => udin3_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin2, OutSignalName => "udin2", OutTemp => udin_zd(2),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin2, TRUE)),
        GlitchData => udin2_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin1, OutSignalName => "udin1", OutTemp => udin_zd(1),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin1, TRUE)),
        GlitchData => udin1_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    VitalPathDelay01 (
        OutSignal  => udin0, OutSignalName => "udin0", OutTemp => udin_zd(0),
        Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin0, TRUE)),
        GlitchData => udin0_GlitchData,
        Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
        );
    END PROCESS vital_output;
END v;


--
--    cell mpi960
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;
USE work.global.purnet;
 
ENTITY mpi960 IS
 
    GENERIC(
        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean          := TRUE;
        XOn             : Boolean          := FALSE;
        MsgOn           : Boolean          := TRUE;
        InstancePath    : String           := "mpi960";
 
        -- Input Signal Delays
        tipd_clk        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cs0n       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cs1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wrrdn      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adsn       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ale        : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin7      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin6      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin5      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin4      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin3      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin2      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin1      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adin0      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_be1n       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_be0n       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rrcvnin    : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_uend       : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_uirqn      : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout7     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout6     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout5     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout4     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout3     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout2     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout1     : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_udout0     : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
        -- Output Signal Delays
        tpd_clk_rdyrcvn    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_wrrdn_urdwrn   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_ustart     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ale_ua3        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ale_ua2        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ale_ua1        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ale_ua0        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_irqn       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_ddrvctl    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_rdrcvts    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_dout0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_mpgsr      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_clk_udin0      : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- setup and hold constraints
        tsetup_adin0_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin0_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_adin1_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin1_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_adin2_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin2_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_adin3_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin3_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_adin4_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin4_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_adin5_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin5_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_adin6_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin6_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_adin7_ale_noedge_negedge       : VitalDelayType := 0.01 ns;
        thold_adin7_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        tsetup_be0n_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        thold_be0n_ale_noedge_negedge         : VitalDelayType := 0.01 ns;
        tsetup_be1n_ale_noedge_negedge        : VitalDelayType := 0.01 ns;
        thold_be1n_ale_noedge_negedge         : VitalDelayType := 0.01 ns;
        tsetup_cs0n_clk_noedge_posedge        : VitalDelayType := 0.01 ns;
        thold_cs0n_clk_noedge_posedge         : VitalDelayType := 0.01 ns;
        tsetup_cs1_clk_noedge_posedge         : VitalDelayType := 0.01 ns;
        thold_cs1_clk_noedge_posedge          : VitalDelayType := 0.01 ns;
        tsetup_uend_clk_noedge_posedge        : VitalDelayType := 0.01 ns;
        thold_uend_clk_noedge_posedge         : VitalDelayType := 0.01 ns);
 
    PORT(
        -- MP I/O
        adsn:    IN  STD_LOGIC;
        ale:     IN  STD_LOGIC;
        clk:     IN  STD_LOGIC;
        cs0n:    IN  STD_LOGIC;
        cs1:     IN  STD_LOGIC;
        wrrdn:   IN  STD_LOGIC;
        adin7:   IN  STD_LOGIC;
        adin6:   IN  STD_LOGIC;
        adin5:   IN  STD_LOGIC;
        adin4:   IN  STD_LOGIC;
        adin3:   IN  STD_LOGIC;
        adin2:   IN  STD_LOGIC;
        adin1:   IN  STD_LOGIC;
        adin0:   IN  STD_LOGIC;
        be1n:    IN  STD_LOGIC;
        be0n:    IN  STD_LOGIC;
        rrcvnin: IN  STD_LOGIC;

        uend:    IN  STD_LOGIC;
        uirqn:   IN  STD_LOGIC;
        udout7:  IN  STD_LOGIC;
        udout6:  IN  STD_LOGIC;
        udout5:  IN  STD_LOGIC;
        udout4:  IN  STD_LOGIC;
        udout3:  IN  STD_LOGIC;
        udout2:  IN  STD_LOGIC;
        udout1:  IN  STD_LOGIC;
        udout0:  IN  STD_LOGIC;

        dout7:   OUT STD_LOGIC;
        dout6:   OUT STD_LOGIC;
        dout5:   OUT STD_LOGIC;
        dout4:   OUT STD_LOGIC;
        dout3:   OUT STD_LOGIC;
        dout2:   OUT STD_LOGIC;
        dout1:   OUT STD_LOGIC;
        dout0:   OUT STD_LOGIC;
        ddrvctl: OUT STD_LOGIC;
        irqn:    OUT STD_LOGIC;
        rdyrcvn: OUT STD_LOGIC;
        rdrcvts: OUT STD_LOGIC;

        mpgsr:   OUT STD_LOGIC;
        urdwrn:  OUT STD_LOGIC;
        ustart:  OUT STD_LOGIC;
        ua3:     OUT STD_LOGIC;
        ua2:     OUT STD_LOGIC;
        ua1:     OUT STD_LOGIC;
        ua0:     OUT STD_LOGIC;
        udin7:   OUT STD_LOGIC;
        udin6:   OUT STD_LOGIC;
        udin5:   OUT STD_LOGIC;
        udin4:   OUT STD_LOGIC;
        udin3:   OUT STD_LOGIC;
        udin2:   OUT STD_LOGIC;
        udin1:   OUT STD_LOGIC;
        udin0:   OUT STD_LOGIC
        );

    ATTRIBUTE Vital_Level0 OF mpi960 : ENTITY IS TRUE;
 
END mpi960;
 
 
ARCHITECTURE v OF mpi960 IS

    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    COMPONENT mpicore
        PORT (
            validacc: IN  STD_LOGIC;
            resetacc: OUT STD_LOGIC;
            clk:       IN  STD_LOGIC;
            rdwrn:     IN  STD_LOGIC;
            addr:      IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
            din:       IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
            ddrvctl:   OUT STD_LOGIC;
            irqn:      OUT STD_LOGIC;
            ackn:      OUT STD_LOGIC;
            dout:      OUT STD_LOGIC_VECTOR( 7 DOWNTO 0);
            uend:      IN  STD_LOGIC;
            uirqn:     IN  STD_LOGIC;
            udout:     IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
            mpgsr:     OUT STD_LOGIC;
            urdwrn:    OUT STD_LOGIC;
            ustart:    OUT STD_LOGIC;
            uaddr:     OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
            udin:      OUT STD_LOGIC_VECTOR( 7 DOWNTO 0)
            );
    END COMPONENT;

    SIGNAL clk_ipd:      STD_LOGIC := 'X';
    SIGNAL cs0n_ipd:     STD_LOGIC := 'X';
    SIGNAL cs1_ipd:      STD_LOGIC := 'X';
    SIGNAL wrrdn_ipd:    STD_LOGIC := 'X';
    SIGNAL adsn_ipd:     STD_LOGIC := 'X';
    SIGNAL ale_ipd:      STD_LOGIC := 'X';
    SIGNAL ben_ipd:      STD_LOGIC_vector(1 DOWNTO 0) := (others => 'X');
    SIGNAL adin_ipd:     STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL uend_ipd:     STD_LOGIC := 'X';
    SIGNAL uirqn_ipd:    STD_LOGIC := 'X';
    SIGNAL udout_ipd:    STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL rrcvnin_ipd:  STD_LOGIC := 'X';
  
    SIGNAL ddrvctl_tmp:  STD_LOGIC := 'X';
    SIGNAL irqn_tmp:     STD_LOGIC := 'X';
    SIGNAL rdyrcvn_tmp:  STD_LOGIC := 'X';
    SIGNAL rdrcvts_tmp:  STD_LOGIC := 'X';
    SIGNAL rdrcv_hold:  STD_LOGIC := 'X';
    SIGNAL dout_tmp:     STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');
    SIGNAL mpgsr_tmp:    STD_LOGIC := 'X';
    SIGNAL urdwrn_tmp:   STD_LOGIC := 'X';
    SIGNAL ustart_tmp:   STD_LOGIC := 'X';
    SIGNAL ua_tmp:       STD_LOGIC_vector(3 DOWNTO 0) := (others => 'X');
    SIGNAL udin_tmp:     STD_LOGIC_vector(7 DOWNTO 0) := (others => 'X');

    SIGNAL rdwrn_ipd:    STD_LOGIC := 'X';
    SIGNAL a_ipd:        STD_LOGIC_vector(4 DOWNTO 0) := (others => 'X');
    SIGNAL cs_cyc0:      STD_LOGIC := '0';
    SIGNAL cs_cyc1:      STD_LOGIC := '0';
    SIGNAL cs_cyc2:      STD_LOGIC := '0';

    SIGNAL validacc:    STD_LOGIC := '0';
    SIGNAL resetacc:    STD_LOGIC := '0';
--    SIGNAL set_acc:    STD_LOGIC := '0';
 
BEGIN
 
    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : BLOCK
    BEGIN
        VitalWireDelay (clk_ipd,      clk,     tipd_clk);
        VitalWireDelay (cs0n_ipd,     cs0n,    tipd_cs0n);
        VitalWireDelay (cs1_ipd,      cs1,     tipd_cs1);
        VitalWireDelay (wrrdn_ipd,    wrrdn,   tipd_wrrdn);
        VitalWireDelay (adsn_ipd,     adsn,    tipd_adsn);
        VitalWireDelay (ale_ipd,      ale,     tipd_ale);
        VitalWireDelay (adin_ipd(7),  adin7,   tipd_adin7);
        VitalWireDelay (adin_ipd(6),  adin6,   tipd_adin6);
        VitalWireDelay (adin_ipd(5),  adin5,   tipd_adin5);
        VitalWireDelay (adin_ipd(4),  adin4,   tipd_adin4);
        VitalWireDelay (adin_ipd(3),  adin3,   tipd_adin3);
        VitalWireDelay (adin_ipd(2),  adin2,   tipd_adin2);
        VitalWireDelay (adin_ipd(1),  adin1,   tipd_adin1);
        VitalWireDelay (adin_ipd(0),  adin0,   tipd_adin0);
        VitalWireDelay (ben_ipd(1),   be1n,    tipd_be1n);
        VitalWireDelay (ben_ipd(0),   be0n,    tipd_be0n);
        VitalWireDelay (rrcvnin_ipd,  rrcvnin, tipd_rrcvnin);
        VitalWireDelay (uend_ipd,     uend,    tipd_uend);
        VitalWireDelay (uirqn_ipd,    uirqn,   tipd_uirqn);
        VitalWireDelay (udout_ipd(7), udout7,  tipd_udout7);
        VitalWireDelay (udout_ipd(6), udout6,  tipd_udout6);
        VitalWireDelay (udout_ipd(5), udout5,  tipd_udout5);
        VitalWireDelay (udout_ipd(4), udout4,  tipd_udout4);
        VitalWireDelay (udout_ipd(3), udout3,  tipd_udout3);
        VitalWireDelay (udout_ipd(2), udout2,  tipd_udout2);
        VitalWireDelay (udout_ipd(1), udout1,  tipd_udout1);
        VitalWireDelay (udout_ipd(0), udout0,  tipd_udout0);
    END BLOCK;
 
    rdwrn_ipd <= NOT wrrdn_ipd;

    latch_addr : PROCESS (ale_ipd, adin_ipd, ben_ipd, purnet)
    BEGIN
        IF (purnet = '0') THEN
            a_ipd   <= "00000";
        ELSE
            IF (ale_ipd = '1') THEN
                a_ipd(4 DOWNTO 2) <= adin_ipd(4 DOWNTO 2);
                a_ipd(1 DOWNTO 0) <= ben_ipd;
            END IF;
        END IF;
    END PROCESS latch_addr;
 

    chk_acc : PROCESS (clk, adsn_ipd, ale_ipd, purnet)
        VARIABLE  set_acc: STD_LOGIC := '0';
    BEGIN
        IF (purnet = '0') THEN
            validacc <= '0';
            set_acc   := '0';
            cs_cyc2   <= '0';
            cs_cyc1   <= '0';
            cs_cyc0   <= '0';
        ELSE
            IF clk'EVENT AND clk = '1' THEN
                IF rrcvnin_ipd = '0' THEN
                    cs_cyc2 <= '0';
                    cs_cyc1 <= '0';
                    cs_cyc0 <= '0';
                    set_acc := '0';
                ELSE
                    cs_cyc2 <= cs_cyc1;
                    cs_cyc1 <= cs_cyc0;

-- Check for beginning of address cycle
                    IF adsn_ipd = '0' THEN
                        cs_cyc0 <= '1';
                    ELSE
                      cs_cyc0 <= '0';
                      validacc <= set_acc;
                    END IF;

-- Check for clock cycles, starting with address phase (ADSN = '0')
                     IF (cs_cyc0 OR cs_cyc1 OR (NOT adsn_ipd)) = '1' THEN 
                        IF cs0n_ipd = '0' AND cs1_ipd = '1' THEN
                            set_acc := '1';
                        END IF;
                    END IF;
                END IF;

            END IF;
        END IF;
    END PROCESS chk_acc;

    rdrcv_contl : PROCESS (clk)
    BEGIN
        IF  (clk'event AND clk = '0') THEN
           rdrcv_hold <= rdyrcvn_tmp;
        END IF;
    END PROCESS rdrcv_contl;
 
    rdrcvts_tmp <= rdrcv_hold and rdyrcvn_tmp;


    mpicore0: mpicore
    PORT MAP (
        validacc => validacc,
        resetacc => resetacc,
        clk       => clk_ipd,
        rdwrn     => rdwrn_ipd,
        addr      => a_ipd,
        din       => adin_ipd,
        ddrvctl   => ddrvctl_tmp,
        irqn      => irqn_tmp,
        ackn      => rdyrcvn_tmp,
        dout      => dout_tmp,
        uend      => uend_ipd,
        uirqn     => uirqn_ipd,
        udout     => udout_ipd,
        mpgsr     => mpgsr_tmp,
        urdwrn    => urdwrn_tmp,
        ustart    => ustart_tmp,
        uaddr     => ua_tmp,
        udin      => udin_tmp
        );
 
    vital_output : PROCESS (clk_ipd,
                      ddrvctl_tmp, irqn_tmp, rdyrcvn_tmp, rdrcvts_tmp, dout_tmp,
                      mpgsr_tmp, urdwrn_tmp, ua_tmp, ustart_tmp, udin_tmp)
        VARIABLE ddrvctl_zd:          STD_LOGIC;
        VARIABLE irqn_zd:             STD_LOGIC;
        VARIABLE rdyrcvn_zd:          STD_LOGIC;
        VARIABLE rdrcvts_zd:          STD_LOGIC;
        VARIABLE dout_zd:             STD_LOGIC_vector(7 DOWNTO 0);
        VARIABLE mpgsr_zd:            STD_LOGIC;
        VARIABLE urdwrn_zd:           STD_LOGIC;
        VARIABLE ua_zd:               STD_LOGIC_vector(3 DOWNTO 0);
        VARIABLE ustart_zd:           STD_LOGIC;
        VARIABLE udin_zd:             STD_LOGIC_vector(7 DOWNTO 0);

     -- timing check results
        VARIABLE tviol_uend    : x01 := '0';
        VARIABLE tviol_cs1     : x01 := '0';
        VARIABLE tviol_cs0n    : x01 := '0';
        VARIABLE tviol_adin0   : x01 := '0';
        VARIABLE tviol_adin1   : x01 := '0';
        VARIABLE tviol_adin2   : x01 := '0';
        VARIABLE tviol_adin3   : x01 := '0';
        VARIABLE tviol_adin4   : x01 := '0';
        VARIABLE tviol_adin5   : x01 := '0';
        VARIABLE tviol_adin6   : x01 := '0';
        VARIABLE tviol_adin7   : x01 := '0';
        VARIABLE tviol_be0n    : x01 := '0';
        VARIABLE tviol_be1n    : x01 := '0';
        VARIABLE uend_clk_TimingDatash  : VitalTimingDataType;
        VARIABLE cs1_clk_TimingDatash   : VitalTimingDataType;
        VARIABLE cs0n_clk_TimingDatash  : VitalTimingDataType;
        VARIABLE adin0_ale_TimingDatash : VitalTimingDataType;
        VARIABLE adin1_ale_TimingDatash : VitalTimingDataType;
        VARIABLE adin2_ale_TimingDatash : VitalTimingDataType;
        VARIABLE adin3_ale_TimingDatash : VitalTimingDataType;
        VARIABLE adin4_ale_TimingDatash : VitalTimingDataType;
        VARIABLE adin5_ale_TimingDatash : VitalTimingDataType;
        VARIABLE adin6_ale_TimingDatash : VitalTimingDataType;
        VARIABLE adin7_ale_TimingDatash : VitalTimingDataType;
        VARIABLE be0n_ale_TimingDatash  : VitalTimingDataType;
        VARIABLE be1n_ale_TimingDatash  : VitalTimingDataType;

     -- functionality results
        VARIABLE violation : x01 := '0';

     -- output glitch results
        VARIABLE rdyrcvn_GlitchData:  VitalGlitchDataType;
        VARIABLE urdwrn_GlitchData:   VitalGlitchDataType;
        VARIABLE ua3_GlitchData:      VitalGlitchDataType;
        VARIABLE ua2_GlitchData:      VitalGlitchDataType;
        VARIABLE ua1_GlitchData:      VitalGlitchDataType;
        VARIABLE ua0_GlitchData:      VitalGlitchDataType;
        VARIABLE ustart_GlitchData:   VitalGlitchDataType;
        VARIABLE ddrvctl_GlitchData:  VitalGlitchDataType;
        VARIABLE irqn_GlitchData:     VitalGlitchDataType;
        VARIABLE rdrcvts_GlitchData:  VitalGlitchDataType;
        VARIABLE dout7_GlitchData:    VitalGlitchDataType;
        VARIABLE dout6_GlitchData:    VitalGlitchDataType;
        VARIABLE dout5_GlitchData:    VitalGlitchDataType;
        VARIABLE dout4_GlitchData:    VitalGlitchDataType;
        VARIABLE dout3_GlitchData:    VitalGlitchDataType;
        VARIABLE dout2_GlitchData:    VitalGlitchDataType;
        VARIABLE dout1_GlitchData:    VitalGlitchDataType;
        VARIABLE dout0_GlitchData:    VitalGlitchDataType;
        VARIABLE mpgsr_GlitchData:    VitalGlitchDataType;
        VARIABLE udin7_GlitchData:    VitalGlitchDataType;
        VARIABLE udin6_GlitchData:    VitalGlitchDataType;
        VARIABLE udin5_GlitchData:    VitalGlitchDataType;
        VARIABLE udin4_GlitchData:    VitalGlitchDataType;
        VARIABLE udin3_GlitchData:    VitalGlitchDataType;
        VARIABLE udin2_GlitchData:    VitalGlitchDataType;
        VARIABLE udin1_GlitchData:    VitalGlitchDataType;
        VARIABLE udin0_GlitchData:    VitalGlitchDataType;

    BEGIN

    -----------------------
    -- timing check section
    -----------------------
        IF (TimingChecksOn) THEN

           -- setup and hold checks
           VitalSetupHoldCheck (
                TestSignal => uend_ipd,
                TestSignalName => "uend",
                RefSignal => clk_ipd,
                RefSignalName => "clk",
                SetupHigh => tsetup_uend_clk_noedge_posedge,
                setuplow => tsetup_uend_clk_noedge_posedge,
                HoldHigh => thold_uend_clk_noedge_posedge,
                HoldLow => thold_uend_clk_noedge_posedge,
                CheckEnabled => purnet='1',
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => uend_clk_TimingDatash,
                Violation => tviol_uend,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => cs1_ipd,
                TestSignalName => "cs1",
                RefSignal => clk_ipd,
                RefSignalName => "clk",
                SetupHigh => tsetup_cs1_clk_noedge_posedge,
                setuplow => tsetup_cs1_clk_noedge_posedge,
                HoldHigh => thold_cs1_clk_noedge_posedge,
                Holdlow => thold_cs1_clk_noedge_posedge,
                CheckEnabled => purnet='1',
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => cs1_clk_TimingDatash,
                Violation => tviol_cs1,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => cs0n_ipd,
                TestSignalName => "cs0n",
                RefSignal => clk_ipd,
                RefSignalName => "clk",
                SetupHigh => tsetup_cs0n_clk_noedge_posedge,
                Setuplow => tsetup_cs0n_clk_noedge_posedge,
                HoldHigh => thold_cs0n_clk_noedge_posedge,
                Holdlow => thold_cs0n_clk_noedge_posedge,
                CheckEnabled => purnet='1',
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => cs0n_clk_TimingDatash,
                Violation => tviol_cs0n,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(0),
                TestSignalName => "adin0",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin0_ale_noedge_negedge,
                Setuplow => tsetup_adin0_ale_noedge_negedge,
                HoldHigh => thold_adin0_ale_noedge_negedge,
                Holdlow => thold_adin0_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin0_ale_TimingDatash,
                Violation => tviol_adin0,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(1),
                TestSignalName => "adin1",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin1_ale_noedge_negedge,
                Setuplow => tsetup_adin1_ale_noedge_negedge,
                HoldHigh => thold_adin1_ale_noedge_negedge,
                Holdlow => thold_adin1_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin1_ale_TimingDatash,
                Violation => tviol_adin1,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(2),
                TestSignalName => "adin2",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin2_ale_noedge_negedge,
                Setuplow => tsetup_adin2_ale_noedge_negedge,
                HoldHigh => thold_adin2_ale_noedge_negedge,
                Holdlow => thold_adin2_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin2_ale_TimingDatash,
                Violation => tviol_adin2,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(3),
                TestSignalName => "adin3",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin3_ale_noedge_negedge,
                Setuplow => tsetup_adin3_ale_noedge_negedge,
                HoldHigh => thold_adin3_ale_noedge_negedge,
                Holdlow => thold_adin3_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin3_ale_TimingDatash,
                Violation => tviol_adin3,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(4),
                TestSignalName => "adin4",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin4_ale_noedge_negedge,
                Setuplow => tsetup_adin4_ale_noedge_negedge,
                HoldHigh => thold_adin4_ale_noedge_negedge,
                Holdlow => thold_adin4_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin4_ale_TimingDatash,
                Violation => tviol_adin4,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(5),
                TestSignalName => "adin5",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin5_ale_noedge_negedge,
                Setuplow => tsetup_adin5_ale_noedge_negedge,
                HoldHigh => thold_adin5_ale_noedge_negedge,
                Holdlow => thold_adin5_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin5_ale_TimingDatash,
                Violation => tviol_adin5,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(6),
                TestSignalName => "adin6",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin6_ale_noedge_negedge,
                Setuplow => tsetup_adin6_ale_noedge_negedge,
                HoldHigh => thold_adin6_ale_noedge_negedge,
                Holdlow => thold_adin6_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin6_ale_TimingDatash,
                Violation => tviol_adin6,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => adin_ipd(7),
                TestSignalName => "adin7",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_adin7_ale_noedge_negedge,
                Setuplow => tsetup_adin7_ale_noedge_negedge,
                HoldHigh => thold_adin7_ale_noedge_negedge,
                Holdlow => thold_adin7_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => adin7_ale_TimingDatash,
                Violation => tviol_adin7,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => ben_ipd(0),
                TestSignalName => "be0n",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_be0n_ale_noedge_negedge,
                Setuplow => tsetup_be0n_ale_noedge_negedge,
                HoldHigh => thold_be0n_ale_noedge_negedge,
                Holdlow => thold_be0n_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => be0n_ale_TimingDatash,
                Violation => tviol_be0n,
                MsgSeverity => warning);
            VitalSetupHoldCheck(
                TestSignal => ben_ipd(1),
                TestSignalName => "be1n",
                RefSignal => ale_ipd,
                RefSignalName => "ale",
                SetupHigh => tsetup_be1n_ale_noedge_negedge,
                Setuplow => tsetup_be1n_ale_noedge_negedge,
                HoldHigh => thold_be1n_ale_noedge_negedge,
                Holdlow => thold_be1n_ale_noedge_negedge,
                CheckEnabled => purnet='1',
                RefTransition => '\',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => be1n_ale_TimingDatash,
                Violation => tviol_be1n,
                MsgSeverity => warning);

   END IF;

   ------------------------
   -- functionality section
   ------------------------

        Violation := tviol_uend OR tviol_cs1 OR tviol_cs0n OR tviol_adin0 OR tviol_adin1
                     OR tviol_adin2 OR tviol_adin3 OR tviol_adin4 OR tviol_adin5 OR 
                     tviol_adin6 OR tviol_adin7 OR tviol_be0n OR tviol_be1n;

        ddrvctl_zd  := ddrvctl_tmp;
        irqn_zd     := irqn_tmp;
        rdyrcvn_zd  := rdyrcvn_tmp;
        rdrcvts_zd  := rdrcvts_tmp;
        dout_zd     := dout_tmp;
        mpgsr_zd    := mpgsr_tmp;
        urdwrn_zd   := urdwrn_tmp;
        ua_zd       := ua_tmp;
        ustart_zd   := ustart_tmp;
        udin_zd     := udin_tmp;
 
        VitalPathDelay01 (
            OutSignal  => rdyrcvn, OutSignalName => "rdyrcvn", OutTemp => rdyrcvn_zd,
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_rdyrcvn, TRUE)),
            GlitchData => rdyrcvn_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => urdwrn, OutSignalName => "urdwrn", OutTemp => urdwrn_zd,
            Paths      => (0 => (wrrdn_ipd'last_event, tpd_wrrdn_urdwrn, TRUE)),
            GlitchData => urdwrn_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => ua3, OutSignalName => "ua3", OutTemp => ua_zd(3),
            Paths      => (0 => (ale_ipd'last_event, tpd_ale_ua3, TRUE)),
            GlitchData => ua3_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => ua2, OutSignalName => "ua2", OutTemp => ua_zd(2),
            Paths      => (0 => (ale_ipd'last_event, tpd_ale_ua2, TRUE)),
            GlitchData => ua2_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => ua1, OutSignalName => "ua1", OutTemp => ua_zd(1),
            Paths      => (0 => (ale_ipd'last_event, tpd_ale_ua1, TRUE)),
            GlitchData => ua1_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => ua0, OutSignalName => "ua0", OutTemp => ua_zd(0),
            Paths      => (0 => (ale_ipd'last_event, tpd_ale_ua0, TRUE)),
            GlitchData => ua0_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => ustart, OutSignalName => "ustart", OutTemp => ustart_zd,
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_ustart, TRUE)),
            GlitchData => ustart_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => ddrvctl, OutSignalName => "ddrvctl", OutTemp => ddrvctl_zd,
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_ddrvctl, TRUE)),
            GlitchData => ddrvctl_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => irqn, OutSignalName => "irqn", OutTemp => irqn_zd,
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_irqn, TRUE)),
            GlitchData => irqn_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => rdrcvts, OutSignalName => "rdrcvts", OutTemp => rdrcvts_zd,
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_rdrcvts, TRUE)),
            GlitchData => rdrcvts_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout7, OutSignalName => "dout7", OutTemp => dout_zd(7),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout7, TRUE)),
            GlitchData => dout7_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout6, OutSignalName => "dout6", OutTemp => dout_zd(6),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout6, TRUE)),
            GlitchData => dout6_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout5, OutSignalName => "dout5", OutTemp => dout_zd(5),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout5, TRUE)),
            GlitchData => dout5_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout4, OutSignalName => "dout4", OutTemp => dout_zd(4),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout4, TRUE)),
            GlitchData => dout4_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout3, OutSignalName => "dout3", OutTemp => dout_zd(3),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout3, TRUE)),
            GlitchData => dout3_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout2, OutSignalName => "dout2", OutTemp => dout_zd(2),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout2, TRUE)),
            GlitchData => dout2_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout1, OutSignalName => "dout1", OutTemp => dout_zd(1),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout1, TRUE)),
            GlitchData => dout1_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => dout0, OutSignalName => "dout0", OutTemp => dout_zd(0),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_dout0, TRUE)),
            GlitchData => dout0_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
          OutSignal    => mpgsr, OutSignalName => "mpgsr", OutTemp => mpgsr_zd,
          Paths        => (0 => (clk_ipd'last_event, tpd_clk_mpgsr, TRUE)),
            GlitchData => mpgsr_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin7, OutSignalName => "udin7", OutTemp => udin_zd(7),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin7, TRUE)),
            GlitchData => udin7_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin6, OutSignalName => "udin6", OutTemp => udin_zd(6),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin6, TRUE)),
            GlitchData => udin6_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin5, OutSignalName => "udin5", OutTemp => udin_zd(5),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin5, TRUE)),
            GlitchData => udin5_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin4, OutSignalName => "udin4", OutTemp => udin_zd(4),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin4, TRUE)),
            GlitchData => udin4_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin3, OutSignalName => "udin3", OutTemp => udin_zd(3),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin3, TRUE)),
            GlitchData => udin3_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin2, OutSignalName => "udin2", OutTemp => udin_zd(2),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin2, TRUE)),
            GlitchData => udin2_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin1, OutSignalName => "udin1", OutTemp => udin_zd(1),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin1, TRUE)),
            GlitchData => udin1_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );
        VitalPathDelay01 (
            OutSignal  => udin0, OutSignalName => "udin0", OutTemp => udin_zd(0),
            Paths      => (0 => (clk_ipd'last_event, tpd_clk_udin0, TRUE)),
            GlitchData => udin0_GlitchData,
            Mode       => ondetect, XOn => XOn, MsgOn => MsgOn
            );

    END PROCESS vital_output;
END v;
