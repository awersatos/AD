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
-- Simulation Library File for ECP
--
-- $Header: /home/pradeep/fndry_src/env/vhdl/pkg/vhdsclibs/data/orca5ecp/src/RCS/ORCA_MISC.vhd,v 1.8 2005/06/22 20:19:26 pradeep Exp $
--
--
----- cell dcs -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY dcs IS
   GENERIC(
      DCSMODE         : String  := "NEG";
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "dcs";
      tpd_clk0_dcsout        : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_clk1_dcsout        : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_sel_dcsout        : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_clk0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_clk1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sel         : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clk0              : IN    std_logic;
      clk1              : IN    std_logic;
      sel              : IN    std_logic;
      dcsout               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF dcs : ENTITY IS TRUE;

END dcs;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF dcs IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL clk0_ipd         : std_logic := 'X';
   SIGNAL clk1_ipd         : std_logic := 'X';
   SIGNAL sel_ipd         : std_logic := 'X';
   SIGNAL sel_int1        : std_logic := '0';
   SIGNAL sel_int2        : std_logic := '0';
   SIGNAL sel_int3        : std_logic_vector(1 downto 0) := "00";
   SIGNAL dcsout_int1         : std_logic := '0';
   SIGNAL sel_int4        : std_logic := '0';
   SIGNAL sel_int5        : std_logic := '0';
   SIGNAL sel_int6        : std_logic_vector(1 downto 0) := "00";
   SIGNAL dcsout_int2         : std_logic := '0';
   SIGNAL sel_int7        : std_logic := '0';
   SIGNAL sel_int8        : std_logic := '0';
   SIGNAL sel_int9        : std_logic := '0';
   SIGNAL sel_int10       : std_logic := '0';
   SIGNAL dcsout_int3         : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (clk0_ipd, clk0, tipd_clk0);
   VitalWireDelay (clk1_ipd, clk1, tipd_clk1);
   VitalWireDelay (sel_ipd, sel, tipd_sel);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (clk0_ipd, clk1_ipd)
   BEGIN
        IF (clk0_ipd'event and clk0_ipd = '0') THEN
           IF (sel_ipd = '1') THEN
              sel_int1 <= sel_ipd;
           END IF;
--           ELSIF (sel_ipd = '0') THEN
           IF (sel_int1 = '0') THEN
              sel_int2 <= sel_int1;
           END IF;
        END IF;
        IF (clk1_ipd'event and clk1_ipd = '0') THEN
           IF (sel_ipd = '0') THEN
              sel_int1 <= sel_ipd;
           END IF;
--           ELSIF (sel_ipd = '1') THEN
           IF (sel_int1 = '1') THEN
              sel_int2 <= sel_int1;
           END IF;
        END IF;
   END PROCESS;       

   sel_int3 <= (sel_int2, sel_int1);

   P2 : PROCESS (clk0_ipd, clk1_ipd, sel_int3)
   BEGIN
        case sel_int3 is
           when "00" => dcsout_int1 <= clk0_ipd;
           when "01" => dcsout_int1 <= '0';
           when "10" => dcsout_int1 <= '0';
           when "11" => dcsout_int1 <= clk1_ipd;
           when others => NULL;
        end case;
   END PROCESS;

   P3 : PROCESS (clk0_ipd, clk1_ipd)
   BEGIN
        IF (clk0_ipd'event and clk0_ipd = '1') THEN
           IF (sel_ipd = '1') THEN
              sel_int4 <= sel_ipd;
           END IF;
           IF (sel_int4 = '0') THEN
              sel_int5 <= sel_int4;
           END IF;
        END IF;
        IF (clk1_ipd'event and clk1_ipd = '1') THEN
           IF (sel_ipd = '0') THEN
              sel_int4 <= sel_ipd;
           END IF;
           IF (sel_int4 = '1') THEN
              sel_int5 <= sel_int4;
           END IF;
        END IF;
   END PROCESS;

   sel_int6 <= (sel_int5, sel_int4);

   P4 : PROCESS (clk0_ipd, clk1_ipd, sel_int6)
   BEGIN
        case sel_int6 is
           when "00" => dcsout_int2 <= clk0_ipd;
           when "01" => dcsout_int2 <= '1';
           when "10" => dcsout_int2 <= '1';
           when "11" => dcsout_int2 <= clk1_ipd;
           when others => NULL;
        end case;
   END PROCESS;

   P7 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd'event and clk1_ipd = '0') THEN
            sel_int7 <= sel_ipd;
      END IF;
   END PROCESS;

   P8 : PROCESS (clk0_ipd)
   BEGIN
      IF (clk0_ipd'event and clk0_ipd = '0') THEN
            sel_int8 <= sel_ipd;
      END IF;
   END PROCESS;

   P9 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd'event and clk1_ipd = '1') THEN
            sel_int9 <= sel_ipd;
      END IF;
   END PROCESS;

   P10 : PROCESS (clk0_ipd)
   BEGIN
      IF (clk0_ipd'event and clk0_ipd = '1') THEN
            sel_int10 <= sel_ipd;
      END IF;
   END PROCESS;

   P11 : PROCESS (clk0_ipd, clk1_ipd, sel_ipd, sel_int7, sel_int8, sel_int9, sel_int10)
   BEGIN
      IF (DCSMODE = "HIGH_LOW") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, '0'),
                           dselect => (0 => sel_int7));
      ELSIF (DCSMODE = "HIGH_HIGH") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, '1'),
                           dselect => (0 => sel_int9));
      ELSIF (DCSMODE = "LOW_LOW") THEN
        dcsout_int3 <= vitalmux 
                          (data => ('0', clk0_ipd),
                           dselect => (0 => sel_int8));
      ELSIF (DCSMODE = "LOW_HIGH") THEN
        dcsout_int3 <= vitalmux 
                          (data => ('1', clk0_ipd),
                           dselect => (0 => sel_int10));
      ELSIF (DCSMODE = "CLK0") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk0_ipd, clk0_ipd),
                           dselect => (0 => sel_ipd));
      ELSIF (DCSMODE = "CLK1") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, clk1_ipd),
                           dselect => (0 => sel_ipd));
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (dcsout_int1, dcsout_int2, dcsout_int3)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS dcsout_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE dcsout_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
   IF (DCSMODE = "NEG") THEN
      dcsout_zd := dcsout_int1;
   ELSIF (DCSMODE = "POS") THEN
      dcsout_zd := dcsout_int2;
   ELSE
      dcsout_zd := dcsout_int3;
   END IF;       

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
      VitalPathDelay01 (
       OutSignal => dcsout,
       OutSignalName => "dcsout",
       OutTemp => dcsout_zd,
       Paths => (0 => (clk0_ipd'last_event, tpd_clk0_dcsout, TRUE),
                 1 => (clk1_ipd'last_event, tpd_clk1_dcsout, TRUE),
                 2 => (sel_ipd'last_event, tpd_sel_dcsout, TRUE)),
       GlitchData => dcsout_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;



--******************************************************************
----- VITAL model for cell GENERIC_PLLB -----
--******************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.VITAL_Timing.all;
use work.components.all;

-- entity declaration --
entity GENERIC_PLLB is
   generic(
   
     
      FIN  : string  := "100.0";
      CLKI_DIV      : string  := "1";
      CLKOP_DIV     : string  := "8";
      CLKFB_DIV     : string  := "1";
      FDEL  : string  := "0";
      FB_MODE  : string  := "CLOCKTREE";
      CLKOK_DIV   : string   := "2";
      WAKE_ON_LOCK  : string  := "OFF";
      DELAY_CNTL    : string  := "STATIC";
      PHASEADJ       :  string  := "0";
      DUTY        :  string  := "4";
      lock_cyc : integer := 2;
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := True;
      tpd_RST_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOP :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_clkfb_clkop       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_clkfb_clkos       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_clkfb_clkok       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_clkfb_lock        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ddamode          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaizr           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddailag          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaidel0         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaidel1         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_ddaidel2         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_CLKI    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLKFB   :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_RST   :	VitalDelayType01 := (0.000 ns, 0.000 ns)
   );

   port(
      CLKI            : in    STD_ULOGIC;
      CLKFB           : in    STD_ULOGIC;
      RST           : in    STD_ULOGIC := '0';

      DDAMODE            : in    STD_ULOGIC;
      DDAIZR            : in    STD_ULOGIC;
      DDAILAG           : in    STD_ULOGIC;
      DDAIDEL0          : in    STD_ULOGIC;
      DDAIDEL1          : in    STD_ULOGIC;
      DDAIDEL2          : in    STD_ULOGIC;

      CLKOP           : out   STD_ULOGIC;
      CLKOS          : out   STD_ULOGIC;
      CLKOK           : out   STD_ULOGIC;
      LOCK          : out   STD_ULOGIC;

      DDAOZR           : out   STD_ULOGIC;
      DDAOLAG          : out   STD_ULOGIC;
      DDAODEL0         : out   STD_ULOGIC;
      DDAODEL1         : out   STD_ULOGIC;
      DDAODEL2         : out   STD_ULOGIC
);
attribute VITAL_LEVEL0 of GENERIC_PLLB : entity is TRUE;
end GENERIC_PLLB;

-- architecture body --

architecture V of GENERIC_PLLB is
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    SIGNAL clki_ipd          : std_ulogic := '0';
    SIGNAL clkfb_ipd         : std_ulogic := '0';
    SIGNAL rst_ipd           : std_ulogic := '0';
    SIGNAL ddamode_ipd           : std_ulogic := '0';
    SIGNAL ddaizr_ipd           : std_ulogic := '0';
    SIGNAL ddailag_ipd           : std_ulogic := '0';
    SIGNAL ddaidel0_ipd           : std_ulogic := '0';
    SIGNAL ddaidel1_ipd           : std_ulogic := '0';
    SIGNAL ddaidel2_ipd           : std_ulogic := '0';
    SIGNAL false_clk          : std_ulogic := '0';
    SIGNAL DDA_DLY            : std_logic_vector(2 downto 0) := "000";
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;
    SIGNAL pll_dly_re         : Integer := 0 ;
    SIGNAL pll_dly_stepd         : Integer := 0 ;
    SIGNAL pll_dly_step         : Integer := 0 ;
    SIGNAL pll_dly_value         : Time  := 0 ps;
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_vco              : time := 0 ns;
    SIGNAL ha_vco              : time := 0 ns;
    SIGNAL duty_vco              : time := 0 ns;
    SIGNAL ha_vco_r           : real := 0.0;
    SIGNAL round_err          : real := 0.0;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL clock_valid        : std_ulogic := '0';
    SIGNAL clock_invalid      : std_ulogic := '0';
    SIGNAL out_clk_valid      : std_ulogic := '0';
    SIGNAL clkop_first_time   : std_ulogic := '1';
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL false_t1_int       : time := 5 ns;
    SIGNAL false_t_int        : time := 0 ns;
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL t_fb_clk           : time := 0 ns;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL intfb_out          : std_ulogic := '0';
    SIGNAL lock_all           : std_ulogic := '0';
    SIGNAL first_time7        : std_ulogic := '1';
    SIGNAL real_delay2        : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL vir_intfb          : std_ulogic := '0';
    SIGNAL vir_intfb1          : std_ulogic := '0';
    SIGNAL vir_lock           : std_ulogic := '0';
    SIGNAL vir_kclk           : std_ulogic := '0';
    SIGNAL vir_sclk           : std_ulogic := '0';
    SIGNAL final_sclk           : std_ulogic := '0';
    SIGNAL lock_delay_reg     : time := 1 ns;
    SIGNAL lock1              : std_ulogic := '0';
    SIGNAL d_lock             : std_ulogic := '1';
    SIGNAL d1_lock            : std_ulogic := '1';
    SIGNAL d2_lock            : std_ulogic := '1';
    SIGNAL d3_lock            : std_ulogic := '1';
    SIGNAL d4_lock            : std_ulogic := '1';
    SIGNAL dly_change         : std_ulogic := '0';
  CONSTANT secdiv_p: integer := str2int(CLKOK_DIV);
  CONSTANT div_i: integer :=  str2int(CLKI_DIV);
  CONSTANT mult_i: integer  := str2int(CLKFB_DIV);
  CONSTANT duty_i: integer := str2int(DUTY);
  CONSTANT phase_i: integer := str2int(PHASEADJ);
  SIGNAL pll_dly_steps     : integer := str2int(FDEL);
  SIGNAL pll_dly_user     : integer := str2int(FDEL);


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

   DDAOZR <= ddaizr_ipd;
   DDAOLAG <= ddailag_ipd;
   DDAODEL0 <= ddaidel0_ipd;
   DDAODEL1 <= ddaidel1_ipd;
   DDAODEL2 <= ddaidel2_ipd;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
--------------------------------------------------------------------

   DDA_DLY <= ddaidel2_ipd & ddaidel1_ipd & ddaidel0_ipd;

   P1 : PROCESS (ddamode_ipd, ddaizr_ipd, ddailag_ipd, DDA_DLY)
   BEGIN
      IF (ddamode_ipd = '0') THEN
         pll_dly_stepd <= pll_dly_user;
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

   net_divide <= (real(mult_i) * ext_divider);

   P6 : PROCESS (t_in_clk, net_divide)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_vco <= ((t_in_clk * div_i) / net_divide);  -- vco oscillating cycle
         ha_vco_r <= ((real(time'pos(t_in_clk)) * real(div_i)) / net_divide) / 2.0;
      END IF;
   END PROCESS;

   ha_vco <= (t_vco / 2.0);  -- vco oscillating half-cycle
   duty_vco <= ((t_vco * duty_i) / 8);  -- duty_cycle

   P106 : PROCESS (ha_vco)
   BEGIN
      IF (ha_vco > 0 ps) THEN
         round_err <= (real(time'pos(t_in_clk)) - ((real(time'pos(ha_vco)) * 2.0 * net_divide) / real(div_i))) / 2.0;
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

   real_delay2 <= ((t_vco * (phase_i / 45)) / 8);

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
               IF (index1 = secdiv_p) THEN
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
           lock_all <= transport vir_lock after ((lock_cyc + 1) * t_vco);
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
         clkok <= false_clk;
         lock1 <= '0';
      ELSIF (rst_ipd = '1') THEN
         clkop <= '0';
         clkos <= '0';
         clkok <= '0';
         lock1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkop <= vir_intfb;
         clkos <= final_sclk;
         clkok <= vir_kclk;
         lock1 <= lock_all;
      END IF;
   END PROCESS;

   lock <= lock1 and d4_lock;
END V;


--**********************************************************************
----- VITAL model for cell EPLLB -----
--**********************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
-- entity declaration --
entity EPLLB is
   generic(
      FIN  : string  := "100.0";
      CLKI_DIV      : string  := "1";
      CLKOP_DIV     : string  := "8";
      CLKFB_DIV     : string  := "1";
      FDEL          : string  := "0";
      FB_MODE       : string  := "CLOCKTREE";
      WAKE_ON_LOCK  : string  := "OFF";
      lock_cyc : integer := 2;
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := True;
      tpd_CLKI_CLKOP :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_CLKI    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLKFB   :	VitalDelayType01 := (0.000 ns, 0.000 ns)
   );
   port(
      CLKI            : in    STD_ULOGIC;
      RST             : in    STD_ULOGIC;
      CLKFB           : in    STD_ULOGIC;
      CLKOP           : out   STD_ULOGIC;
      LOCK            : out   STD_ULOGIC
   );
attribute VITAL_LEVEL0 of EPLLB : entity is FALSE;
end EPLLB;

-- architecture body --

architecture V of EPLLB is
  attribute VITAL_LEVEL0 of V : architecture is FALSE;
  
  ---------------------------------------------------------------------
  --  Component Declaration
  ---------------------------------------------------------------------
  component GENERIC_PLLB 
   generic(
      FIN             : string  := "100.0";
      CLKI_DIV        : string  := "1";
      CLKOP_DIV       : string  := "8";
      CLKFB_DIV       : string  := "1";
      FDEL            : string  := "0";
      FB_MODE         : string  := "CLOCKTREE";
      CLKOK_DIV       : string  := "2";
      WAKE_ON_LOCK    : string  := "OFF";
      DELAY_CNTL      : string  := "STATIC";
      PHASEADJ        : string  := "0";
      DUTY            : string  := "4";

      lock_cyc : integer := 2;
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := True;
      tpd_RST_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOP :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_CLKI    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLKFB   :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_RST   :	VitalDelayType01 := (0.000 ns, 0.000 ns)

      );

   port(
      CLKI            : in    STD_ULOGIC;
      CLKFB           : in    STD_ULOGIC;
      RST             : in    STD_ULOGIC := '0';

      DDAMODE           : in    STD_ULOGIC;
      DDAIZR            : in    STD_ULOGIC;
      DDAILAG           : in    STD_ULOGIC;
      DDAIDEL0          : in    STD_ULOGIC;
      DDAIDEL1          : in    STD_ULOGIC;
      DDAIDEL2          : in    STD_ULOGIC;

      CLKOP             : out   STD_ULOGIC;
      CLKOS             : out   STD_ULOGIC;
      CLKOK             : out   STD_ULOGIC;
      LOCK              : out   STD_ULOGIC;

      DDAOZR            : out   STD_ULOGIC;
      DDAOLAG           : out   STD_ULOGIC;
      DDAODEL0          : out    STD_ULOGIC;
      DDAODEL1          : out    STD_ULOGIC;
      DDAODEL2          : out    STD_ULOGIC
);
end component;
 
  signal open1,open2,open3,open4,open5,open6,open7 : std_logic;
  signal gnd_sig : std_logic;

begin 
-----------------------------------------------------------------------
    gnd_sig <= '0';

GENERIC_PLLB_u1: GENERIC_PLLB


   generic map (

      FIN  =>  FIN,
      CLKI_DIV => CLKI_DIV ,
      CLKOP_DIV  => CLKOP_DIV,
      CLKFB_DIV => CLKFB_DIV ,
      FDEL => FDEL,
      FB_MODE => FB_MODE,
      CLKOK_DIV   => "2",
      WAKE_ON_LOCK  => WAKE_ON_LOCK,
      DELAY_CNTL => "STATIC",
      PHASEADJ => "0",
      DUTY => "4",
      lock_cyc => lock_cyc,
      TimingChecksOn =>TimingChecksOn,
      InstancePath => InstancePath,
      Xon => Xon,
      MsgOn =>MsgOn,
      tpd_RST_LOCK => (0.0 ns, 0.0 ns),
      tpd_CLKI_CLKOP => tpd_CLKI_CLKOP,
      tpd_CLKI_LOCK => (0.0 ns, 0.0 ns),
      tpd_CLKI_CLKOK => tpd_CLKI_LOCK,
      tipd_CLKI => tipd_CLKI,
      tipd_CLKFB => tipd_CLKFB,
      tipd_RST => (0.000 ns, 0.000 ns)
   )
   
   port map(
      CLKI =>  CLKI,
      CLKFB => CLKFB,
      RST => RST,

      DDAMODE => gnd_sig,
      DDAIZR => gnd_sig,
      DDAILAG => gnd_sig,
      DDAIDEL0 => gnd_sig,
      DDAIDEL1 => gnd_sig,
      DDAIDEL2 => gnd_sig,

      CLKOP => CLKOP,
      CLKOS  => open1,
      CLKOK  => open2,
      LOCK => LOCK,

      DDAOZR => open3,
      DDAOLAG => open4,
      DDAODEL0  => open5,
      DDAODEL1  => open6,
      DDAODEL2 => open7
    );
    
end V;

configuration CFG_EPLLB_V of EPLLB is 
        for V
        end for; 
end CFG_EPLLB_V;


--******************************************************************
----- VITAL model for cell EHXPLLB -----
--******************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.VITAL_Timing.all;
use ieee.vital_primitives.all;
use work.components.all;

-- entity declaration --
entity EHXPLLB is
   generic(
   
     
      FIN  : string  := "100.0";
      CLKI_DIV      : string  := "1";
      CLKOP_DIV     : string  := "8";
      CLKFB_DIV     : string  := "1";
      FDEL  : string  := "0";
      FB_MODE  : string  := "CLOCKTREE";
      CLKOK_DIV   : string   := "2";
      WAKE_ON_LOCK  : string  := "OFF";
      DELAY_CNTL    : string  := "STATIC";
      PHASEADJ       :  string  := "0";
      DUTY        :  string  := "4";
      lock_cyc : integer := 2;
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := True;
      tpd_RST_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOP :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_CLKI    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLKFB   :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_RST   :	VitalDelayType01 := (0.000 ns, 0.000 ns)
   );

   port(
      CLKI            : in    STD_ULOGIC;
      CLKFB           : in    STD_ULOGIC;
      RST           : in    STD_ULOGIC := '0';

      DDAMODE            : in    STD_ULOGIC;
      DDAIZR            : in    STD_ULOGIC;
      DDAILAG           : in    STD_ULOGIC;
      DDAIDEL0          : in    STD_ULOGIC;
      DDAIDEL1          : in    STD_ULOGIC;
      DDAIDEL2          : in    STD_ULOGIC;

      CLKOP           : out   STD_ULOGIC;
      CLKOS          : out   STD_ULOGIC;
      CLKOK           : out   STD_ULOGIC;
      LOCK          : out   STD_ULOGIC;

      DDAOZR           : out   STD_ULOGIC;
      DDAOLAG          : out   STD_ULOGIC;
      DDAODEL0         : out   STD_ULOGIC;
      DDAODEL1         : out   STD_ULOGIC;
      DDAODEL2         : out   STD_ULOGIC
);
attribute VITAL_LEVEL0 of EHXPLLB : entity is FALSE;
end EHXPLLB;

-- architecture body --

architecture V of EHXPLLB is
  attribute VITAL_LEVEL0 of V : architecture is FALSE;

  ---------------------------------------------------------------------
  --  Component Declaration
  ---------------------------------------------------------------------
  component GENERIC_PLLB 
   generic(
      FIN             : string  := "100.0";
      CLKI_DIV        : string  := "1";
      CLKOP_DIV       : string  := "8";
      CLKFB_DIV       : string  := "1";
      FDEL            : string  := "0";
      FB_MODE         : string  := "CLOCKTREE";
      CLKOK_DIV       : string  := "2";
      WAKE_ON_LOCK    : string  := "OFF";
      DELAY_CNTL      : string  := "STATIC";
      PHASEADJ        : string  := "0";
      DUTY            : string  := "4";

      lock_cyc : integer := 2;
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := True;
      tpd_RST_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOP :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_LOCK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tpd_CLKI_CLKOK :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_CLKI    :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLKFB   :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_RST   :	VitalDelayType01 := (0.000 ns, 0.000 ns)

      );

   port(
      CLKI            : in    STD_ULOGIC;
      CLKFB           : in    STD_ULOGIC;
      RST             : in    STD_ULOGIC := '0';

      DDAMODE           : in    STD_ULOGIC;
      DDAIZR            : in    STD_ULOGIC;
      DDAILAG           : in    STD_ULOGIC;
      DDAIDEL0          : in    STD_ULOGIC;
      DDAIDEL1          : in    STD_ULOGIC;
      DDAIDEL2          : in    STD_ULOGIC;

      CLKOP             : out   STD_ULOGIC;
      CLKOS             : out   STD_ULOGIC;
      CLKOK             : out   STD_ULOGIC;
      LOCK              : out   STD_ULOGIC;

      DDAOZR            : out   STD_ULOGIC;
      DDAOLAG           : out   STD_ULOGIC;
      DDAODEL0          : out    STD_ULOGIC;
      DDAODEL1          : out    STD_ULOGIC;
      DDAODEL2          : out    STD_ULOGIC
);
end component;
 

begin 
-----------------------------------------------------------------------
GENERIC_PLLB_u2: GENERIC_PLLB

   generic map (

      FIN  =>  FIN,
      CLKI_DIV => CLKI_DIV ,
      CLKOP_DIV  => CLKOP_DIV,
      CLKFB_DIV => CLKFB_DIV ,
      FDEL => FDEL,
      FB_MODE => FB_MODE,
      CLKOK_DIV   => CLKOK_DIV,
      WAKE_ON_LOCK  => WAKE_ON_LOCK,
      DELAY_CNTL => DELAY_CNTL,
      PHASEADJ => PHASEADJ,
      DUTY => DUTY,
      lock_cyc => lock_cyc,
      TimingChecksOn =>TimingChecksOn,
      InstancePath => InstancePath,
      Xon => Xon,
      MsgOn =>MsgOn,
      tpd_RST_LOCK => tpd_RST_LOCK,
      tpd_CLKI_CLKOP => tpd_CLKI_CLKOP,
      tpd_CLKI_LOCK => tpd_CLKI_LOCK,
      tpd_CLKI_CLKOK => tpd_CLKI_LOCK,
      tipd_CLKI => tipd_CLKI,
      tipd_CLKFB => tipd_CLKFB,
      tipd_RST => tipd_RST
   )
   
   port map(
      CLKI =>  CLKI,
      CLKFB => CLKFB,
      RST => RST,

      DDAMODE => DDAMODE,
      DDAIZR => DDAIZR,
      DDAILAG => DDAILAG,
      DDAIDEL0 => DDAIDEL0,
      DDAIDEL1 => DDAIDEL1,
      DDAIDEL2 => DDAIDEL2,

      CLKOP => CLKOP,
      CLKOS  => CLKOS,
      CLKOK  => CLKOK,
      LOCK => LOCK,

      DDAOZR => DDAOZR,
      DDAOLAG => DDAOLAG,
      DDAODEL0  => DDAODEL0,
      DDAODEL1  => DDAODEL1,
      DDAODEL2 => DDAODEL2
    );
    
end V;

configuration CFG_EHXPLLB_V of EHXPLLB is 
        for V
        end for; 
end CFG_EHXPLLB_V;





--*********************************************************************
----- CELL MULT2 -----
--*********************************************************************
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
----- cell iddrxb -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY iddrxb IS
    GENERIC (
        REGSET          : string  := "RESET";
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string := "iddrxb";
        -- propagation delays
        tpd_sclk_qa     : VitalDelayType01 := (0.001 ns, 0.001 ns);
        tpd_sclk_qb     : VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_d_eclk_noedge_posedge    : VitalDelayType := 0.0 ns;
        thold_d_eclk_noedge_posedge     : VitalDelayType := 0.0 ns;
        tsetup_lsr_eclk_noedge_posedge  : VitalDelayType := 0.0 ns;
        thold_lsr_eclk_noedge_posedge   : VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_d                  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ce                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_lsr                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk               : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk               : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ddrclkpol          : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk            : VitalDelayType := 0.001 ns;
        tpw_eclk_posedge         : VitalDelayType := 0.001 ns;
        tpw_eclk_negedge         : VitalDelayType := 0.001 ns;
        tperiod_sclk             : VitalDelayType := 0.001 ns;
        tpw_sclk_posedge         : VitalDelayType := 0.001 ns;
        tpw_sclk_negedge         : VitalDelayType := 0.001 ns;
        tperiod_lsr             : VitalDelayType := 0.001 ns;
        tpw_lsr_posedge         : VitalDelayType := 0.001 ns;
        tpw_lsr_negedge         : VitalDelayType := 0.001 ns);

    PORT (
        d               : IN std_logic;
        ce              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        lsr             : IN std_logic;
        ddrclkpol       : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF iddrxb : ENTITY IS TRUE;

END iddrxb ;

-- architecture body --
ARCHITECTURE v OF iddrxb IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL ce_ipd   : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL lsr_ipd : std_logic := '0';
    SIGNAL ddrclkpol_ipd : std_logic := '0';
    SIGNAL QP      : std_logic := '0';
    SIGNAL QN      : std_logic := '0';
    SIGNAL QP_n    : std_logic := '0';
    SIGNAL QPreg   : std_logic := '0';
    SIGNAL QNreg   : std_logic := '0';
    SIGNAL sclk_pol   : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(ce_ipd, ce, tipd_ce);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(lsr_ipd, lsr, tipd_lsr);
       VitalWireDelay(ddrclkpol_ipd, ddrclkpol, tipd_ddrclkpol);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   S1 : PROCESS (sclk_ipd, ddrclkpol_ipd)
   BEGIN
      IF (ddrclkpol_ipd = '1') THEN
         sclk_pol <= not sclk_ipd;
      ELSIF (ddrclkpol_ipd = '0') THEN
         sclk_pol <= sclk_ipd;
      END IF;
   END PROCESS;

   P1 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QP /= d_ipd) THEN
            QP <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
            QP <= d_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QP_n /= QP) THEN
            QP_n <= 'X';
         END IF;
         IF (QN /= d_ipd) THEN
            QN <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '1' and eclk_ipd = '0') THEN
         QP_n <= QP;
         QN <= d_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (sclk_pol)
   BEGIN
      IF (sclk_pol = 'X') THEN
         IF (QPreg /= QP_n) THEN
            QPreg <= 'X';
         END IF;
         IF (QNreg /= QN) THEN
            QNreg <= 'X';
         END IF;
      ELSIF (sclk_pol'event and sclk_pol'last_value = '0' and sclk_pol = '1') THEN
         IF (lsr_ipd = '1') THEN
            IF (REGSET = "RESET") THEN
               QPreg <= '0';
               QNreg <= '0';
            ELSIF (REGSET = "SET") THEN
               QPreg <= '1';
               QNreg <= '1';
            END IF;
         ELSIF (lsr_ipd = '0') THEN
            QPreg <= QP_n;
            QNreg <= QN;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (QPreg, QNreg)

   -- timing check results
   VARIABLE tviol_eclk   : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_lsr   : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE lsr_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;

   -- functionality results
   VARIABLE violation   : X01 := '0';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS qa_zd          : std_ulogic IS results(1);
   ALIAS qb_zd          : std_ulogic IS results(2);
   -- output glitch detection VARIABLEs
   VARIABLE qa_GlitchData     : VitalGlitchDataType;
   VARIABLE qb_GlitchData     : VitalGlitchDataType;

   BEGIN

   ------------------------
   --  timing check section
   ------------------------

    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_d_eclk_noedge_posedge,
            SetupLow => tsetup_d_eclk_noedge_posedge,
            HoldHigh => thold_d_eclk_noedge_posedge,
            HoldLow => thold_d_eclk_noedge_posedge,
            CheckEnabled => TRUE,
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => lsr_ipd, TestSignalName => "lsr",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_lsr_eclk_noedge_posedge,
            SetupLow => tsetup_lsr_eclk_noedge_posedge,
            HoldHigh => thold_lsr_eclk_noedge_posedge,
            HoldLow => thold_lsr_eclk_noedge_posedge,
            CheckEnabled => TRUE,
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => lsr_eclk_timingdatash,
            Violation => tviol_lsr, MsgSeverity => warning);
    END IF;

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa_zd := VitalBUF(QPreg);
      qb_zd := VitalBUF(QNreg);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => qa,
      OutSignalName => "qa",
      OutTemp => qa_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event,
                      pathdelay => tpd_sclk_qa,
                      pathcondition => TRUE)),
      GlitchData => qa_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
    VitalPathDelay01 (
      OutSignal => qb,
      OutSignalName => "qb",
      OutTemp => qb_zd,
      Paths => (0 => (inputchangetime => sclk_pol'last_event,
                      pathdelay => tpd_sclk_qb,
                      pathcondition => TRUE)),
      GlitchData => qb_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;

END v;



------CELL ODDRXB------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
entity ODDRXB is
    GENERIC (
        REGSET          : string  := "RESET";
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string := "oddrxb";
        -- propagation delays
        tpd_clk_q       : VitalDelayType01 := (0.001 ns, 0.001 ns);
        -- setup and hold constraints
        tsetup_da_clk_noedge_posedge    : VitalDelayType := 0.0 ns;
        thold_da_clk_noedge_posedge     : VitalDelayType := 0.0 ns;
        tsetup_db_clk_noedge_posedge    : VitalDelayType := 0.0 ns;
        thold_db_clk_noedge_posedge     : VitalDelayType := 0.0 ns;
        tsetup_lsr_clk_noedge_posedge   : VitalDelayType := 0.0 ns;
        thold_lsr_clk_noedge_posedge    : VitalDelayType := 0.0 ns;
        -- input SIGNAL delays
        tipd_da                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_db                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_lsr                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    port(
          da		:	in	STD_LOGIC;
          db		:	in	STD_LOGIC;
          clk	        :	in	STD_LOGIC;
          lsr	        :	in	STD_LOGIC;
          q		:	out	STD_LOGIC
        );

attribute VITAL_LEVEL0 of ODDRXB : entity is TRUE;
end ODDRXB;

-- architecture body --

architecture V of ODDRXB is
  attribute VITAL_LEVEL0 of V : architecture is TRUE;
    SIGNAL da_ipd    : std_logic := '0';
    SIGNAL db_ipd    : std_logic := '0';
    SIGNAL clk_ipd    : std_logic := '0';
    SIGNAL lsr_ipd  : std_logic := '0';
    SIGNAL QP       : std_logic := '0';
    SIGNAL QN       : std_logic := '0';

begin 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(da_ipd, da, tipd_da);
       VitalWireDelay(db_ipd, db, tipd_db);
       VitalWireDelay(clk_ipd, clk, tipd_clk);
       VitalWireDelay(lsr_ipd, lsr, tipd_lsr);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------

  P1: PROCESS(clk_ipd)
  BEGIN
     IF (clk_ipd = 'X') THEN
         IF (QN /= db_ipd) THEN
            QN <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         IF (lsr_ipd = '1') THEN
            IF (REGSET = "RESET") THEN
               QN <= '0';
            ELSIF (REGSET = "SET") THEN
               QN <= '1';
            END IF;
         ELSE
            QN <= db_ipd;
         END IF;
      END IF;
   END PROCESS;
 
  P2 : PROCESS(clk_ipd, da_ipd)
   begin
       if (clk_ipd = '0') then
         QP <= da_ipd;
       else
         QP <= QP;
       end if;
  end process;  

   VitalBehavior : PROCESS (clk_ipd, QP, QN)

   -- timing check results
   VARIABLE tviol_clk   : X01 := '0';
   VARIABLE tviol_da    : X01 := '0';
   VARIABLE tviol_db    : X01 := '0';
   VARIABLE tviol_lsr   : X01 := '0';
   VARIABLE da_clk_TimingDatash  : VitalTimingDataType;
   VARIABLE db_clk_TimingDatash  : VitalTimingDataType;
   VARIABLE lsr_clk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_clk : VitalPeriodDataType;

   -- functionality results
   VARIABLE violation   : X01 := '0';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS q_zd           : std_ulogic IS results(1);
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;


   BEGIN

   ------------------------
   --  timing check section
   ------------------------

    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => da_ipd, TestSignalName => "da",
            RefSignal => clk_ipd, RefSignalName => "clk",
            SetupHigh => tsetup_da_clk_noedge_posedge,
            SetupLow => tsetup_da_clk_noedge_posedge,
            HoldHigh => thold_da_clk_noedge_posedge,
            HoldLow => thold_da_clk_noedge_posedge,
            CheckEnabled => TRUE,
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => da_clk_timingdatash,
            Violation => tviol_da, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => db_ipd, TestSignalName => "db",
            RefSignal => clk_ipd, RefSignalName => "clk",
            SetupHigh => tsetup_db_clk_noedge_posedge,
            SetupLow => tsetup_db_clk_noedge_posedge,
            HoldHigh => thold_db_clk_noedge_posedge,
            HoldLow => thold_db_clk_noedge_posedge,
            CheckEnabled => TRUE,
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => db_clk_timingdatash,
            Violation => tviol_db, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => lsr_ipd, TestSignalName => "lsr",
            RefSignal => clk_ipd, RefSignalName => "clk",
            SetupHigh => tsetup_lsr_clk_noedge_posedge,
            SetupLow => tsetup_lsr_clk_noedge_posedge,
            HoldHigh => thold_lsr_clk_noedge_posedge,
            HoldLow => thold_lsr_clk_noedge_posedge,
            CheckEnabled => TRUE,
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => lsr_clk_timingdatash,
            Violation => tviol_lsr, MsgSeverity => warning);
    END IF;

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q_zd := vitalmux
                 (data => (QP, QN),
                  dselect => (0 => clk_ipd));

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => clk_ipd'last_event,
                      pathdelay => tpd_clk_q,
                      pathcondition => TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;

END v;

configuration CFG_ODDRXB_V of ODDRXB is
   for V
   end for;
end CFG_ODDRXB_V;


--*********************************************************************
------CELL DQSDLL------
--*********************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity DQSDLL is
    generic(LOCK_CYC         : integer := 2;
	    DEL_ADJ          : string  := "PLUS";
            DEL_VAL          : string  := "0";
            LOCK_SENSITIVITY : string  := "LOW");
    port(
          CLK		:	in	STD_ULOGIC;
          RST	        :	in	STD_ULOGIC;
          UDDCNTL       :	in	STD_ULOGIC;
          LOCK		:	out	STD_ULOGIC;
          DQSDEL	:	out	STD_ULOGIC
        );

attribute VITAL_LEVEL0 of DQSDLL : entity is FALSE;
end DQSDLL;

-- architecture body --

architecture V of DQSDLL is
  attribute VITAL_LEVEL0 of V : architecture is FALSE;

  signal RST_int      :  std_logic;
  signal UDDCNTL_int  : std_logic;
  signal LOCK_int     : std_logic;
  signal DQSDEL_int   : std_logic;
  signal clkin_in     : std_logic;
  signal clk_rising_edge_count : integer := 0;

begin 

  clkin_in <= VitalBUF(CLK);
  RST_int  <= VitalBUF(RST);
  UDDCNTL_int <= VitalINV(UDDCNTL);

  LOCK  <= VitalBUF(LOCK_int);
  DQSDEL <= VitalBUF(DQSDEL_int);
  
  process(clkin_in, RST_int)
  begin
    if (RST_int = '1') then
        clk_rising_edge_count <= 0;
    elsif (clkin_in'event and clkin_in = '1') then
        clk_rising_edge_count <= clk_rising_edge_count + 1;
    end if;
  end process;

  process(clk_rising_edge_count, RST_int)
  begin
    if (RST_int = '1') then
        LOCK_int <= '0';
    elsif (clk_rising_edge_count > LOCK_CYC) then
        LOCK_int <= '1';
    end if;
  end process;

  process(LOCK_int, UDDCNTL_int, RST_int)
  begin
    if (RST_int = '1') then
        DQSDEL_int <= '0';
    elsif (UDDCNTL_int = '1') then
        DQSDEL_int <= LOCK_int;
    else
        DQSDEL_int <= DQSDEL_int;
    end if;
  end process;
 
end V;

configuration CFG_DQSDLL_V of DQSDLL is
   for V
   end for;
end CFG_DQSDLL_V;

------cell dqsbufb------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.components.all;

-- entity declaration --
ENTITY dqsbufb IS
   GENERIC(
      DEL_ADJ         : String  := "PLUS";
      DEL_VAL         : String  := "0";
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "dqsbufb";
      tipd_dqsi       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_clk        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_read       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dqsdel     : VitalDelayType01 := (0.0 ns, 0.0 ns));

    PORT(
          dqsi		:	IN	std_logic;
          clk		:	IN	std_logic;
          read	        :	IN	std_logic;
          dqsdel        :	IN	std_logic;
          dqso		:	OUT	std_logic;
          ddrclkpol	:	OUT	std_logic;
          dqsc		:	OUT	std_logic;
          prmbdet	:	OUT	std_logic
        );

ATTRIBUTE vital_level0 OF dqsbufb : ENTITY IS TRUE;
END dqsbufb;

-- architecture body --

architecture V of DQSBUFB is
  ATTRIBUTE vital_level0 OF v : ARCHITECTURE IS TRUE;
---
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
---
  SIGNAL dqsi_ipd                 : std_logic := '0';
  SIGNAL clk_ipd                  : std_logic := '0';
  SIGNAL read_ipd                 : std_logic := '0';
  SIGNAL dqsdel_ipd               : std_logic := '0';
  SIGNAL quarter_period           : time := 0 ns;
  SIGNAL clk_last_rising_edge     : time := 0 ns;
  SIGNAL A, C                     : std_logic := '0';
  SIGNAL B, D, E                  : std_logic := '0';
  SIGNAL A_inv, C_inv                     : std_logic := '0';
  SIGNAL B_inv, D_inv, E_inv                  : std_logic := '0';
  SIGNAL DDRCLKPOL_int            : std_logic := '0';
  SIGNAL CLKP                     : std_logic := '0';
  SIGNAL DQSO_int                 : std_logic := '0';
  SIGNAL DQSC_int                 : std_logic := '0';
  SIGNAL DQSO_int1                : std_logic := '0';
  SIGNAL PRMBDET_int              : std_logic := '0';
  SIGNAL DQSO_int0                : std_logic := '0';
  SIGNAL DQSO_int2                : std_logic := '0';
  SIGNAL clk_rising_edge_count    : integer := 0;

begin 

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(dqsi_ipd, dqsi, tipd_dqsi);
   VitalWireDelay(clk_ipd, clk, tipd_clk);
   VitalWireDelay(read_ipd, read, tipd_read);
   VitalWireDelay(dqsdel_ipd, dqsdel, tipd_dqsdel);
   END BLOCK;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   inst10: or2 PORT MAP (a=>read_ipd, b=>A, z=>C_inv);
   inst11: inv PORT MAP (a=>C_inv, z=>C);
   inst12: or2 PORT MAP (a=>C, b=>D, z=>A_inv);
   inst13: inv PORT MAP (a=>A_inv, z=>A);
   inst14: or2 PORT MAP (a=>D, b=>E, z=>B_inv);
   inst15: inv PORT MAP (a=>B_inv, z=>B);
   inst16: or2 PORT MAP (a=>C, b=>PRMBDET_int, z=>E_inv);
   inst17: inv PORT MAP (a=>E_inv, z=>E);
   inst18: or3 PORT MAP (a=>B, b=>read_ipd, c=>PRMBDET_int, z=>D_inv);
   inst19: inv PORT MAP (a=>D_inv, z=>D);

   P1 : PROCESS (dqsi_ipd)
   BEGIN
      IF (dqsi_ipd = 'X') THEN
         PRMBDET_int <= '1';
      ELSE
         PRMBDET_int <= dqsi_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (D)
   BEGIN
      IF (D'event and D = '0') THEN
         DDRCLKPOL_int <= clk_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (clk_ipd, DDRCLKPOL_int)
   BEGIN
      IF (DDRCLKPOL_int = '0') THEN
         CLKP <= clk_ipd;
      ELSIF (DDRCLKPOL_int = '1') THEN
         CLKP <= not clk_ipd;
      END IF;
   END PROCESS;

   P4 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd'event and clk_ipd = '1') THEN
         clk_rising_edge_count <= clk_rising_edge_count + 1;
         clk_last_rising_edge <= NOW;
      END IF;
   END PROCESS;

   P5 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd'event and clk_ipd = '0') THEN
         IF (clk_rising_edge_count >= 1) THEN
            quarter_period <= (NOW - clk_last_rising_edge) / 2;
         END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (dqsi_ipd, dqsdel_ipd)
   BEGIN
      IF (dqsdel_ipd = '1') THEN
         IF (quarter_period > 0 ps) THEN
            DQSO_int <= transport dqsi_ipd after (quarter_period - 0.8 ns);
            DQSC_int <= dqsi_ipd;
         END IF;
      ELSE
         DQSO_int <= '0';
         DQSC_int <= '0';
      END IF;
   END PROCESS;

   P7 : PROCESS (DQSO_int, CLKP)
   BEGIN
      IF (CLKP = '1') THEN
         DQSO_int1 <= '0';
      ELSIF (DQSO_int'event and DQSO_int'last_value = '0') THEN
         DQSO_int1 <= '1';
      END IF;
   END PROCESS;

   DQSO_int0 <= DQSO_int;

   DQSO_int2 <= transport (DQSO_int1 or DQSO_int0) after 0.8 ns;
   ddrclkpol <= DDRCLKPOL_int; 
   prmbdet <= PRMBDET_int;
   dqso <= DQSO_int2;
   dqsc <= DQSC_int;

END v;

CONFIGURATION dqsbufbc OF dqsbufb IS
  FOR v
    FOR ALL: or2 USE ENTITY work.or2(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
  END FOR;
END dqsbufbc;

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

