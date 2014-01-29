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
-- $Header: /home/rlp/Orfdry/env_rcs/vhdl/pkg/vhdsclibs/data/orca5mj/src/RCS/MACHXO_MISC.vhd,v 1.9 2005/10/11 20:29:22 pradeep Exp $ 
--
----- CELL MULT2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MULT2 is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := False;
      tpd_A0_P0                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_A1_P0                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_A2_P1                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_A3_P1                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B0_P0                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B1_P0                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B2_P1                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B3_P1                      :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_CI_P0                     :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_CI_P1                     :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_A0_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_A1_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_A2_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_A3_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B0_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B1_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B2_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B3_CO                    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_CI_CO                   :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CI                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A0                             :	in    STD_ULOGIC;
      A1                             :	in    STD_ULOGIC;
      A2                             :	in    STD_ULOGIC;
      A3                             :	in    STD_ULOGIC;
      B0                             :	in    STD_ULOGIC;
      B1                             :	in    STD_ULOGIC;
      B2                             :	in    STD_ULOGIC;
      B3                             :	in    STD_ULOGIC;
      CI                            :	in    STD_ULOGIC;
      P0                             :	out   STD_ULOGIC;
      P1                             :	out   STD_ULOGIC;
      CO                           :	out   STD_ULOGIC);
attribute VITAL_LEVEL0 of MULT2 : entity is TRUE;
end MULT2;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MULT2 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A0_ipd	 : STD_ULOGIC := 'X';
   SIGNAL A1_ipd	 : STD_ULOGIC := 'X';
   SIGNAL A2_ipd	 : STD_ULOGIC := 'X';
   SIGNAL A3_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B0_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B1_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B2_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B3_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CI_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (CI_ipd, CI, tipd_CI);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, B0_ipd, A1_ipd, B1_ipd, A2_ipd, B2_ipd, A3_ipd, B3_ipd, CI_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 3) := (others => 'X');
   ALIAS P0_zd : STD_LOGIC is Results(1);
   ALIAS P1_zd : STD_LOGIC is Results(2);
   ALIAS CO_zd : STD_LOGIC is Results(3);

   -- output glitch detection variables
   VARIABLE P0_GlitchData	: VitalGlitchDataType;
   VARIABLE P1_GlitchData	: VitalGlitchDataType;
   VARIABLE CO_GlitchData	: VitalGlitchDataType;
   VARIABLE C_int         : STD_LOGIC := 'X';

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      P0_zd := ((B0_ipd) AND (A0_ipd)) XOR ((B1_ipd) AND (A1_ipd)) XOR (CI_ipd);
      C_int :=
       (A0_ipd AND B0_ipd AND A1_ipd AND B1_ipd) OR (A0_ipd AND B0_ipd AND CI_ipd) OR (A1_ipd AND B1_ipd AND CI_ipd);

      P1_zd := ((B2_ipd) AND (A2_ipd)) XOR ((B3_ipd) AND (A3_ipd)) XOR (C_int);
      CO_zd :=
       (A2_ipd AND B2_ipd AND A3_ipd AND B3_ipd) OR (A2_ipd AND B2_ipd AND C_int) OR (A3_ipd AND B3_ipd AND C_int);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => P0,
       GlitchData => P0_GlitchData,
       OutSignalName => "P0",
       OutTemp => P0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_P0, TRUE),
		 1 => (A1_ipd'last_event, tpd_A1_P0, TRUE),
                 2 => (B0_ipd'last_event, tpd_B0_P0, TRUE),
		 3 => (B1_ipd'last_event, tpd_B1_P0, TRUE),
                 4 => (CI_ipd'last_event, tpd_CI_P0, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

      VitalPathDelay01 (
       OutSignal => P1,
       GlitchData => P1_GlitchData,
       OutSignalName => "P1",
       OutTemp => P1_zd,
       Paths => (0 => (A2_ipd'last_event, tpd_A2_P1, TRUE),
		 1 => (A3_ipd'last_event, tpd_A3_P1, TRUE),
                 2 => (B2_ipd'last_event, tpd_B2_P1, TRUE),
		 3 => (B3_ipd'last_event, tpd_B3_P1, TRUE),
                 4 => (CI_ipd'last_event, tpd_CI_P1, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

      VitalPathDelay01 (
       OutSignal => CO,
       GlitchData => CO_GlitchData,
       OutSignalName => "CO",
       OutTemp => CO_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_CO, TRUE),
		 1 => (A1_ipd'last_event, tpd_A1_CO, TRUE),
		 2 => (A2_ipd'last_event, tpd_A2_CO, TRUE),
		 3 => (A3_ipd'last_event, tpd_A3_CO, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_CO, TRUE),
		 5 => (B1_ipd'last_event, tpd_B1_CO, TRUE),
		 6 => (B2_ipd'last_event, tpd_B2_CO, TRUE),
		 7 => (B3_ipd'last_event, tpd_B3_CO, TRUE),
                 8 => (CI_ipd'last_event, tpd_CI_CO, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end V;

configuration CFG_MULT2_V of MULT2 is
   for V
   end for;
end CFG_MULT2_V;


--
----- cell ehxpllc -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;


-- entity declaration --
ENTITY ehxpllc IS
   GENERIC (
      FIN                : string  := "100.0";
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 1;
      CLKOK_DIV          : Integer   := 1;
      PHASEADJ           : Integer   := 0;
      FDEL               : Integer   := 0;
      DUTY               : Integer   := 4;
      DELAY_CNTL         : String    := "STATIC";
      WAKE_ON_LOCK       : String    := "ON";
      LOCK_DELAY         : Integer   := 100;
      LOCK_CYC           : Integer   := 2;
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "ehxpllc";
      tpd_clki_clkop     : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clki_clkos     : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clki_clkok     : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clki_lock      : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clki_clkintfb     : VitalDelayType01 := (0.00 ns, 0.00 ns);
      tpd_clkfb_clkop       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clkfb_clkos       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clkfb_clkok       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clkfb_lock        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_clkfb_clkintfb    : VitalDelayType01 := (0.00 ns, 0.00 ns);
      tipd_clki             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rst              : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddamode          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaizr           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddailag          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaidel0         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaidel1         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaidel2         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb            : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rst                   : in std_logic;
      ddamode               : in std_logic;
      ddaizr                : in std_logic;
      ddailag               : in std_logic;
      ddaidel0              : in std_logic;
      ddaidel1              : in std_logic;
      ddaidel2              : in std_logic;
      clkos                 : out std_logic;
      clkop                 : out std_logic;
      clkok                 : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic);

    ATTRIBUTE Vital_Level0 OF ehxpllc : ENTITY IS TRUE;

END ehxpllc ;

-- ARCHITECTURE body --
ARCHITECTURE V OF ehxpllc IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clki_ipd          : std_logic := '0';
    SIGNAL clkfb_ipd         : std_logic := '0';
    SIGNAL rst_ipd           : std_logic := '0';
    SIGNAL ddamode_ipd           : std_logic := '0';
    SIGNAL ddaizr_ipd           : std_logic := '0';
    SIGNAL ddailag_ipd           : std_logic := '0';
    SIGNAL ddaidel0_ipd           : std_logic := '0';
    SIGNAL ddaidel1_ipd           : std_logic := '0';
    SIGNAL ddaidel2_ipd           : std_logic := '0';
    SIGNAL PHASEADJ_REG           : Integer := (PHASEADJ / 45);
    SIGNAL false_clk          : std_logic := '0';
    SIGNAL DDA_DLY            : std_logic_vector(2 downto 0) := "000";
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;
    SIGNAL pll_dly_re         : Integer := 0 ;
    SIGNAL pll_dly_stepd         : Integer := 0 ;
    SIGNAL pll_dly_steps         : Integer := FDEL ;
--    SIGNAL pll_dly_re         : Real := (0.25 * FDEL) ;
    SIGNAL pll_dly_step         : Integer := 0 ;
    SIGNAL pll_dly_value         : Time	 := 0 ps;
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_vco              : time := 0 ns;
    SIGNAL ha_vco              : time := 0 ns;
    SIGNAL duty_vco              : time := 0 ns;
    SIGNAL ha_vco_r           : real := 0.0;
    SIGNAL round_err          : real := 0.0;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL out_clk_valid      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL false_t1_int       : time := 5 ns;
    SIGNAL false_t_int        : time := 0 ns;
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL t_fb_clk           : time := 0 ns;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL intfb_out          : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL first_time7        : std_logic := '1';
    SIGNAL real_delay2        : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL vir_intfb          : std_logic := '0';
    SIGNAL vir_intfb1          : std_logic := '0';
    SIGNAL vir_lock           : std_logic := '0';
    SIGNAL vir_kclk           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL final_sclk           : std_logic := '0';
    SIGNAL lock_delay_reg     : time := 1 ns;
    SIGNAL lock1              : std_logic := '0';
    SIGNAL d_lock             : std_logic := '1';
    SIGNAL d1_lock            : std_logic := '1';
    SIGNAL d2_lock            : std_logic := '1';
    SIGNAL d3_lock            : std_logic := '1';
    SIGNAL d4_lock            : std_logic := '1';
    SIGNAL dly_change         : std_logic := '0';


BEGIN
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(rst_ipd, rst, tipd_rst);
   VitalWireDelay(clki_ipd, clki, tipd_clki);
   VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
   VitalWireDelay(ddamode_ipd, ddamode, tipd_ddamode);
   VitalWireDelay(ddaizr_ipd, ddaizr, tipd_ddaizr);
   VitalWireDelay(ddailag_ipd, ddailag, tipd_ddailag);
   VitalWireDelay(ddaidel0_ipd, ddaidel0, tipd_ddaidel0);
   VitalWireDelay(ddaidel1_ipd, ddaidel1, tipd_ddaidel1);
   VitalWireDelay(ddaidel2_ipd, ddaidel2, tipd_ddaidel2);
   END BLOCK;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
--------------------------------------------------------------------

   DDA_DLY <= ddaidel2_ipd & ddaidel1_ipd & ddaidel0_ipd;

   P1 : PROCESS (ddamode_ipd, ddaizr_ipd, ddailag_ipd, DDA_DLY)
   BEGIN
      IF (ddamode_ipd = '0') THEN
         pll_dly_stepd <= FDEL;
         IF (ddamode_ipd'event) THEN
            dly_change <= not dly_change;
         END IF;
      ELSIF (ddamode_ipd = '1') THEN
         IF (ddaizr_ipd = '1') THEN
            pll_dly_stepd <= 0;
            IF (ddaizr_ipd'event) THEN
               dly_change <= not dly_change;
            END IF;
         ELSIF (ddaizr_ipd = '0') THEN
            IF (ddailag_ipd = '1') THEN
               CASE DDA_DLY is
                  WHEN "111"     => pll_dly_stepd <= -8;
                  WHEN "110"     => pll_dly_stepd <= -7;
                  WHEN "101"     => pll_dly_stepd <= -6;
                  WHEN "100"     => pll_dly_stepd <= -5;
                  WHEN "011"     => pll_dly_stepd <= -4;
                  WHEN "010"     => pll_dly_stepd <= -3;
                  WHEN "001"     => pll_dly_stepd <= -2;
                  WHEN "000"     => pll_dly_stepd <= -1;
                  WHEN others  => pll_dly_stepd <= 0;
               END CASE;
               dly_change <= not dly_change;
            ELSIF (ddailag_ipd = '0') THEN
               CASE DDA_DLY is
                  WHEN "111"     => pll_dly_stepd <= 8;
                  WHEN "110"     => pll_dly_stepd <= 7;
                  WHEN "101"     => pll_dly_stepd <= 6;
                  WHEN "100"     => pll_dly_stepd <= 5;
                  WHEN "011"     => pll_dly_stepd <= 4;
                  WHEN "010"     => pll_dly_stepd <= 3;
                  WHEN "001"     => pll_dly_stepd <= 2;
                  WHEN "000"     => pll_dly_stepd <= 1;
                  WHEN others  => pll_dly_stepd <= 0;
               END CASE;
               dly_change <= not dly_change;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P2 : PROCESS (pll_dly_stepd, pll_dly_steps)
   BEGIN
      IF (DELAY_CNTL = "STATIC") THEN
         pll_dly_step <= pll_dly_steps;
      ELSIF (DELAY_CNTL = "DYNAMIC") THEN
         pll_dly_step <= pll_dly_stepd;
      END IF;
  
   END PROCESS;

   pll_dly_value <= (250 ps * pll_dly_step);

   P51 : PROCESS (clki_ipd, pll_dly_value, dly_change, rst_ipd)
   BEGIN
      IF (pll_dly_value'event or dly_change'event or (rst_ipd = '1')) THEN
         d_lock <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         IF (d_lock = '0') THEN
            d_lock <= '1';
         END IF;
      END IF;
   END PROCESS;

   P52 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d1_lock <= d_lock;
      END IF;
   END PROCESS;

   P53 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d3_lock <= d1_lock;
      END IF;
   END PROCESS;
 
   d2_lock <= d_lock and d1_lock;
   d4_lock <= d_lock and d1_lock and d3_lock;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF ((t_in_clk = t_in_clk1) and (t_in_clk = t_in_clk2) and (t_in_clk = t_in_clk3)) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_invalid <= '0';
             ELSE
                  clock_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

------------------------------------------------
-- measure the feedback delay value
------------------------------------------------
   P100 : PROCESS (clkfb_ipd)
   VARIABLE fb_count : Integer := 0;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
         fb_count := fb_count + 1;
         IF (fb_count = 3) THEN
            clkop_first_time <= '0';
         END IF;
      END IF;
   END PROCESS;

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   FB_PERIOD : PROCESS (clkfb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
   END PROCESS;

   false_t_int <= 2 * false_t1_int;

   INT_FB : PROCESS (t_fb_clk)
   BEGIN
      IF (t_fb_clk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(false_t_int)) );
      END IF;
   END PROCESS;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1, clki_ipd)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   net_divide <= (real(CLKFB_DIV) * ext_divider);

   P6 : PROCESS (t_in_clk, net_divide)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_vco <= ((t_in_clk * CLKI_DIV) / net_divide);  -- vco oscillating cycle
         ha_vco_r <= ((real(time'pos(t_in_clk)) * real(CLKI_DIV)) / net_divide) / 2.0;
      END IF;
   END PROCESS;

   ha_vco <= (t_vco / 2.0);  -- vco oscillating half-cycle
   duty_vco <= ((t_vco * DUTY) / 8);  -- duty_cycle

   P106 : PROCESS (ha_vco)
   BEGIN
      IF (ha_vco > 0 ps) THEN
         round_err <= (real(time'pos(t_in_clk)) - ((real(time'pos(ha_vco)) * 2.0 * net_divide) / real(CLKI_DIV))) / 2.0;
      END IF;
   END PROCESS;

   P7 : PROCESS (clki_ipd, rst_ipd, d_lock)
   BEGIN
      IF ((rst_ipd = '1') or (d_lock = '0')) THEN
         out_clk_valid <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         out_clk_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (out_clk_valid, intfb_out)
      VARIABLE index : real := 0.0;
   BEGIN
      IF (out_clk_valid  = '0') THEN
         intfb_out <= '0';
         first_time7 <= '1';
         index := 0.0;
      ELSE
         IF (first_time7 = '1') THEN
            intfb_out <= '1';
            first_time7 <= '0';
            index := 0.0;
         ELSE
            index := index + 1.0;
            IF (index = net_divide) THEN
--               intfb_out <= not intfb_out after time'val(integer(ha_vco_r + round_err));
               intfb_out <= not intfb_out after (ha_vco + time'val(integer(round_err)));
               index := 0.0;
            ELSE
               intfb_out <= not intfb_out after ha_vco;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   real_delay2 <= ((t_vco * PHASEADJ_REG) / 8);

   real_delay <= (real_delay1 + real_delay2);

   vir_intfb1 <= transport intfb_out after real_delay1;

   P9 : PROCESS (vir_intfb1, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_intfb <= '0';
      ELSIF (pll_dly_value  >= 0 ps) THEN
         vir_intfb <= transport vir_intfb1 after pll_dly_value;
      ELSE
         vir_intfb <= transport vir_intfb1 after (t_in_clk + pll_dly_value);
      END IF;
   END PROCESS;

   P108 : PROCESS (intfb_out)
   BEGIN
      IF (out_clk_valid  = '0') THEN
         vir_lock <= '0';
      ELSE
         vir_lock <= '1';
      END IF;
   END PROCESS;

   P91 : PROCESS (vir_intfb, d2_lock)
   VARIABLE index1 : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (d2_lock = '0') THEN
         vir_kclk <= '0';
         first_time := true;
      ELSE
         IF (vir_intfb'event) THEN
            IF (first_time) THEN
               IF (vir_intfb = '1') THEN
                  vir_kclk <= '1';
                  IF (out_clk_valid = '0') THEN
                     first_time := true;
                  ELSE
                     first_time := false;
                  END IF;
                  index1 := 0;
               END IF;
            ELSE
               index1 := index1 + 1;
               IF (index1 = CLKOK_DIV) THEN
                  vir_kclk <= NOT vir_kclk;
                  index1 := 0;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (rst_ipd, vir_lock, out_clk_valid, clock_invalid)
   BEGIN
      IF (rst_ipd = '1') THEN
         lock_all <= '0';
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
        ELSIF out_clk_valid = '1' THEN
           lock_all <= transport vir_lock after (LOCK_DELAY * lock_delay_reg);
        END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (vir_intfb, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_sclk <= '0';
      ELSIF (vir_intfb'event and vir_intfb = '1') THEN
         vir_sclk <= '1', '0' after duty_vco;
      END IF;
   END PROCESS;

   P54 : PROCESS (vir_sclk, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         final_sclk <= '0';
      ELSE
         final_sclk <= transport vir_sclk after real_delay2;
      END IF;
   END PROCESS;

   P12 : PROCESS (out_clk_valid, vir_intfb, lock_all, vir_kclk, final_sclk, false_clk, rst_ipd, clkop_first_time)
   BEGIN
      IF (clkop_first_time = '1') THEN
         clkop <= false_clk;
         clkos <= false_clk;
         clkintfb <= false_clk;
         clkok <= false_clk;
         lock1 <= '0';
      ELSIF (rst_ipd = '1') THEN
         clkop <= '0';
         clkos <= '0';
         clkintfb <= '0';
         clkok <= '0';
         lock1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkop <= vir_intfb;
         clkos <= final_sclk;
         clkok <= vir_kclk;
         clkintfb <= vir_intfb;
         lock1 <= lock_all;
      END IF;
   END PROCESS;

   lock <= lock1 and d4_lock;
END V;


--
---
library ieee, std;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;


-- ************************************************************************
-- Entity definition
-- ************************************************************************

entity CCU2 is

   generic (
      inject1_0 : string := "YES";
      inject1_1 : string := "YES";
      init0: string := "0x0000";
      init1: string := "0x0000"

   );

   port (
      A0,A1 : in std_ulogic;
      B0,B1 : in std_ulogic;
      C0,C1 : in std_ulogic;
      D0,D1 : in std_ulogic;
      CIN : in std_ulogic;
      S0,S1 : out std_ulogic;
      COUT0,COUT1 : out std_ulogic
   );

end CCU2;

architecture bev of CCU2 is
   ------------------------------------------------------------------
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (3 downto 0);
   begin
        case hex is
          when '0' =>
             result := "0000";
          when '1' =>
             result := "0001";
          when '2' =>
             result := "0010";
          when '3' =>
             result := "0011";
          when '4' =>
             result := "0100";
          when '5' =>
             result := "0101";
          when '6' =>
             result := "0110";
          when '7' =>
             result := "0111";
          when '8' =>
             result := "1000";
          when '9' =>
             result := "1001";
          when 'A'|'a' =>
             result := "1010";
          when 'B'|'b' =>
             result := "1011";
          when 'C'|'c' =>
             result := "1100";
          when 'D'|'d' =>
             result := "1101";
          when 'E'|'e' =>
             result := "1110";
          when 'F'|'f' =>
             result := "1111";
          when others =>
             null;
        end case;
        return result;
   end;
 
   function hex2bin (hex: String) return STD_LOGIC_VECTOR is
        -- skip 0x of hex string
        constant length : Integer := hex'length - 2;
        variable result : STD_LOGIC_VECTOR (4*length-1 downto 0);
   begin
        for i in 0 to length-1 loop
           result ((length-i)*4-1 downto (length-i-1)*4) := hex2bin(hex(i+3));
        end loop;
        return result;
   end;

   -----------------------------------------------------

   signal init_vec0 : std_logic_vector( 15 downto 0);
   signal init_vec1 : std_logic_vector( 15 downto 0);

   signal lut2_init0 : std_logic_vector (3 downto 0); 
   signal lut2_init1 : std_logic_vector (3 downto 0);

   signal lut2_sel0, lut2_sel1, lut4_sel0, lut4_sel1 : integer :=0;
   signal lut2_out0, lut2_out1 : std_ulogic;
   signal prop0, prop1, gen0, gen1, cout_sig0, cout_sig1 : std_ulogic;
 
   -----------------------------------------------------

begin


   init_vec0 <= hex2bin(init0);
   init_vec1 <= hex2bin(init1);

   lut2_init0 <= init_vec0( 15 downto 12 );
   lut2_init1 <= init_vec1( 15 downto 12 );

   lut2_sel0 <= conv_integer (B0 & A0);
   lut2_sel1 <= conv_integer (B1 & A1);
   lut4_sel0 <= conv_integer (D0 & C0 & B0 & A0);
   lut4_sel1 <= conv_integer (D1 & C1 & B1 & A1);

   prop0 <= init_vec0(lut4_sel0) ; 
   prop1 <= init_vec1(lut4_sel1); 

   lut2_out0 <= lut2_init0(lut2_sel0); 
   lut2_out1 <= lut2_init1(lut2_sel1); 

   gen0 <= '1' when (inject1_0 = "YES") else
           '1' when (inject1_0 = "yes") else
           not(lut2_out0) ;
   gen1 <= '1' when (inject1_1 = "YES") else 
           '1' when (inject1_0 = "yes") else
           not(lut2_out1) ;

   cout_sig0 <= (not(prop0) and gen0 ) or (prop0 and CIN);
   cout_sig1 <= (not(prop1) and gen1 ) or (prop1 and cout_sig0);

   COUT0 <= cout_sig0;
   COUT1 <= cout_sig1; 

   S0 <=  prop0 xor CIN;  
   S1 <=  prop1 xor cout_sig0;

end bev;

