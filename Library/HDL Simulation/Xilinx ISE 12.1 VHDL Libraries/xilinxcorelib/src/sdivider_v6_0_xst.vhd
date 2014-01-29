-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 6.0
--  \   \        Filename: $RCSfile: sdivider_v6_0_xst.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/09/08 16:11:31 $
-- /___/   /\    Date Created: 2007
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : sdivider_v6_0
-- Purpose : Behavioral model entity-architecture for serial divider
--
-------------------------------------------------------------------------------
--  (c) Copyright 2007-2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
--
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

LIBRARY XilinxCoreLib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

entity sdivider_v6_0_xst is
  GENERIC (
    C_VERBOSITY         : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_USE_DSP48         : integer := 0;          -- 0 = no,    1 = yes
    C_OPTIMIZE_GOAL     : integer := 0;          -- 0 = area,  1 = speed.
    C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
    C_XDEVICEFAMILY     : string  := "virtex4";
    C_HAS_SCLR          : integer := 0;
    C_HAS_CE            : integer := 0;
    C_CE_OVERRIDES_SYNC : integer := 0;
    DIVCLK_SEL          : integer := 1;
    DIVIDEND_WIDTH      : integer := 8;
    DIVISOR_WIDTH       : integer := 8;
    FRACTIONAL_B        : integer := 0;
    FRACTIONAL_WIDTH    : integer := 8;
    SIGNED_B            : integer := 0
    );
  PORT (
    CLK      : in  std_logic                                       := '1';
    CE       : in  std_logic                                       := '1';
    SCLR     : in  std_logic                                       := '0';
    DIVIDEND : in  std_logic_vector (Dividend_Width -1 downto 0)   := (others => '0');
    DIVISOR  : in  std_logic_vector (Divisor_Width -1 downto 0)    := (others => '0');
    QUOT     : out std_logic_vector (Dividend_Width -1 downto 0);
    REMD     : out std_logic_vector (Fractional_Width -1 downto 0);
    RFD      : out std_logic
    );
END sdivider_v6_0_xst;


ARCHITECTURE behavioral OF sdivider_v6_0_xst IS
  FUNCTION latency_value(bus_num, bus_fract, fractional : INTEGER)
    RETURN INTEGER IS
  BEGIN
    IF (fractional = 1) THEN
      RETURN bus_num + bus_fract;
    ELSE
      RETURN bus_num;
    END IF;

  END latency_value;

  FUNCTION roc_clock_val(divclk_sel : POSITIVE)
    RETURN INTEGER IS
  BEGIN
    IF divclk_sel = 1 THEN
      RETURN 0;
    ELSE
      RETURN 1;
    END IF;
  END roc_clock_val;

-- required constants for latency

  CONSTANT latency_max            : INTEGER := dividend_width + fractional_width + divclk_sel + 4;
  CONSTANT bus_latency            : INTEGER := latency_value(dividend_width, fractional_width, fractional_b);
  CONSTANT c_clock_counter_init   : INTEGER := 0;  --divclk_sel - 1;
  CONSTANT c_roc_clock_count_init : INTEGER := roc_clock_val(divclk_sel);  --divclk_sel - 1;


  TYPE quotient_array IS ARRAY(latency_max DOWNTO 0)
    OF STD_LOGIC_VECTOR(dividend_width -1 DOWNTO 0);
  TYPE remainder_array IS ARRAY(latency_max DOWNTO 0)
    OF STD_LOGIC_VECTOR(fractional_width -1 DOWNTO 0);


  FUNCTION check_generics RETURN BOOLEAN IS
    CONSTANT new_line : STRING(1 TO 1) := (1 => lf);  -- For assertion reports
  BEGIN
    -- errors
    ASSERT (NOT(fractional_b = 0 AND fractional_width /= divisor_width))
      REPORT "ERROR : Fractional width must equal divisor width for INTEGER remainder dividers" & new_line
      SEVERITY ERROR;
    ASSERT TRUE  --(NOT(dividend_width < 1 OR dividend_width > 32))
      REPORT "ERROR : Dividend width must be in the range 1 to 32" & new_line
      SEVERITY ERROR;
    ASSERT (NOT(divisor_width < 2 OR divisor_width > 32))
      REPORT "ERROR : Divisor width must be in the range 2 to 32" & new_line
      SEVERITY ERROR;
    ASSERT (NOT(fractional_b = 1 AND (fractional_width < 2 OR
                                      fractional_width > 32)))
      REPORT "ERROR : Fractional width must be in the range 2 to 32" & new_line
      SEVERITY ERROR;
    ASSERT (NOT(divclk_sel /= 1 AND divclk_sel /= 2 AND divclk_sel /= 4 AND
                divclk_sel /= 8))
      REPORT "ERROR : Clocks Per Division must be 1, 2, 4 or 8" & new_line
      SEVERITY ERROR;
    RETURN TRUE;
  END check_generics;

  CONSTANT generics_valid : BOOLEAN := check_generics;


-- latency calculation

  FUNCTION pipe_depth(n, f, div_clk, SIGNED, fract : INTEGER)
    RETURN INTEGER IS
    VARIABLE temp, result : INTEGER;
  BEGIN
    IF(SIGNED = 0) THEN
      CASE div_clk IS
        WHEN 1 =>
          temp := n + 2;
        WHEN OTHERS =>
          temp := n + 3;
      END CASE;
    ELSE
      CASE div_clk IS
        WHEN 1 =>
          temp := n + 2 + 2;
        WHEN OTHERS =>
          temp := n + 3 + 1;
      END CASE;
    END IF;
    IF(fract = 0) THEN
      RETURN temp;
    ELSE
      RETURN temp +f;
    END IF;

  END pipe_depth;

  --trace signals to show behavioural model entrails during sim - for debug
  SIGNAL s_vdividend_big : STD_LOGIC_VECTOR(dividend_width DOWNTO 0);
  SIGNAL s_vdivisor_big  : STD_LOGIC_VECTOR(divisor_width DOWNTO 0);
  SIGNAL s_quotient_big  : STD_LOGIC_VECTOR(dividend_width DOWNTO 0);
  SIGNAL s_remainder_big : STD_LOGIC_VECTOR(fractional_width DOWNTO 0);
  SIGNAL s_dividend_neg  : BOOLEAN := FALSE;
  SIGNAL s_divisor_neg   : BOOLEAN := FALSE;
  SIGNAL s_quotient_neg  : BOOLEAN := FALSE;
  SIGNAL s_remainder_neg : BOOLEAN := FALSE;
  SIGNAL s_vdivisor      : STD_LOGIC_VECTOR(divisor_width-1 DOWNTO 0);
  SIGNAL s_vdividend     : STD_LOGIC_VECTOR(dividend_width-1 DOWNTO 0);
  SIGNAL s_quotient_d    : quotient_array;
  SIGNAL s_remainder_d   : remainder_array;
  SIGNAL s_clk_cnt       : INTEGER;

BEGIN
     main :
  PROCESS(clk)
    -- initialization
    VARIABLE setup           : BOOLEAN := TRUE;
    VARIABLE roc_clock_count : INTEGER := 1;
    VARIABLE clock_counter   : INTEGER := 0;

    -- setup the pipeline value
    VARIABLE latency : INTEGER := pipe_depth(dividend_width, fractional_width, divclk_sel, signed_b, fractional_b);

    -- arrays to hold the pipelined results
    VARIABLE quotient_d  : quotient_array;
    VARIABLE remainder_d : remainder_array;

    -- dividend and divisor variables
    VARIABLE vdividend     : STD_LOGIC_VECTOR(dividend_width-1 DOWNTO 0);
    VARIABLE vdivisor      : STD_LOGIC_VECTOR(divisor_width-1 DOWNTO 0);
    VARIABLE vdividend_big : STD_LOGIC_VECTOR(dividend_width DOWNTO 0);
    VARIABLE vdivisor_big  : STD_LOGIC_VECTOR(divisor_width DOWNTO 0);

    -- bit vectors of the result
    VARIABLE vquotient     : STD_LOGIC_VECTOR(bus_latency-1 DOWNTO 0);
    VARIABLE vremainder    : STD_LOGIC_VECTOR(fractional_width-1 DOWNTO 0);
    VARIABLE quotient_big  : STD_LOGIC_VECTOR(dividend_width DOWNTO 0);
    VARIABLE remainder_big : STD_LOGIC_VECTOR(fractional_width DOWNTO 0);

    -- temp variables for std_logic calcuations
    VARIABLE vtemp, vtemp_new : STD_LOGIC_VECTOR(divisor_width DOWNTO 0);
    VARIABLE vdividend_temp   : STD_LOGIC_VECTOR(dividend_width -1 DOWNTO 0);
    VARIABLE vdivisor_temp    : STD_LOGIC_VECTOR(divisor_width DOWNTO 0);
    VARIABLE vremainder_temp  : STD_LOGIC_VECTOR(fractional_width-1 DOWNTO 0);

    -- test sign of input for signed version
    VARIABLE dividend_neg : BOOLEAN := FALSE;
    VARIABLE divisor_neg  : BOOLEAN := FALSE;

    -- should the quotient or remainder be negative
    VARIABLE quotient_neg  : BOOLEAN := FALSE;
    VARIABLE remainder_neg : BOOLEAN := FALSE;

    -- ready for data (when inputs are sampled)
    VARIABLE vrfd : STD_LOGIC := '0';

    -- loop counter
    VARIABLE i, j         : INTEGER;
    VARIABLE cin, restore : STD_LOGIC;

    -- for unsigned calculations
    VARIABLE u_divisor_width  : INTEGER;
    VARIABLE u_dividend_width : INTEGER;
    VARIABLE u_bus_latency    : INTEGER;

    VARIABLE temp_bit : STD_LOGIC;
                                        -- top bit of signed fraction must be 'x' when all others are

    --This function should be in XilinxCoreLibs
    FUNCTION rat( value : std_logic )
      RETURN std_logic IS
    BEGIN
      CASE value IS
        WHEN '0' | '1' => RETURN value;
        WHEN 'H' => RETURN '1';
        WHEN 'L' => RETURN '0';
        WHEN OTHERS => RETURN 'X';
      END CASE;
    END rat;

    FUNCTION std_logic_vector_2_var (vect: std_logic_vector) 
      RETURN std_logic_vector IS
      VARIABLE mvl: std_logic_vector(vect'LEFT DOWNTO vect'RIGHT);
    BEGIN
      FOR i IN vect'RANGE LOOP
	mvl(i) := rat(vect(i));
      END LOOP;
      RETURN mvl;
    END std_logic_vector_2_var;

    FUNCTION anyX(vect : std_logic_vector)
      RETURN BOOLEAN IS
    BEGIN
      FOR i IN vect'RANGE LOOP
        IF (rat(vect(i)) = 'X') THEN
          return TRUE;
        END IF;
      END LOOP;
      return FALSE;
    END anyX;

    FUNCTION setallx (
      width : INTEGER)
      RETURN STD_LOGIC_VECTOR IS
      VARIABLE vect : STD_LOGIC_VECTOR(width -1 DOWNTO 0);
    BEGIN  -- setall1
      FOR i IN 0 TO width-1 LOOP
        vect(i) := 'X';
      END LOOP;  -- i IN 0 to width-1 LOOP
      RETURN vect;
    END setallx;

    FUNCTION setall1 (
      width : INTEGER)
      RETURN STD_LOGIC_VECTOR IS
      VARIABLE vect : STD_LOGIC_VECTOR(width -1 DOWNTO 0);
    BEGIN  -- setall1
      FOR i IN 0 TO width-1 LOOP
        vect(i) := '1';
      END LOOP;  -- i IN 0 to width-1 LOOP
      RETURN vect;
    END setall1;

    FUNCTION setall0 (
      width : INTEGER)
      RETURN STD_LOGIC_VECTOR IS
      VARIABLE vect : STD_LOGIC_VECTOR(width -1 DOWNTO 0);
    BEGIN  -- setall1
      FOR i IN 0 TO width-1 LOOP
        vect(i) := '0';
      END LOOP;  -- i IN 0 to width-1 LOOP
      RETURN vect;
    END setall0;


    --In the structural code, the quotient array is stored as the
    --inverse, hence after reset, the quotient pipe will soon be
    --full of 1's. In the case of the fractional remainder, which
    --is derived from the quotient array, this also applies, but
    --not to the sign bit which is generated separately.
    --In the case of signed, there is another stage in the pipe after
    --the inversions, so it takes longer for the 1's to propogate
    --out
    PROCEDURE initialise (
      VARIABLE quotient_d      : OUT quotient_array;
      VARIABLE remainder_d     : OUT remainder_array;
      VARIABLE vdividend       : OUT STD_LOGIC_VECTOR(dividend_width -1 DOWNTO 0);
      VARIABLE vdivisor        : OUT STD_LOGIC_VECTOR(divisor_width -1 DOWNTO 0);
      VARIABLE vquotient       : OUT STD_LOGIC_VECTOR(bus_latency -1 DOWNTO 0);
      VARIABLE vremainder      : OUT STD_LOGIC_VECTOR(fractional_width -1 DOWNTO 0);
      VARIABLE roc_clock_count : OUT INTEGER;
      VARIABLE clock_counter   : OUT INTEGER;
      VARIABLE vrfd            : OUT STD_LOGIC
      ) IS
    BEGIN
      FOR i IN latency -1 DOWNTO 0 LOOP
        quotient_d(i)  := setall0(dividend_width);
        remainder_d(i) := setall0(fractional_width);
      END LOOP;
      vdividend       := setall0(dividend_width);
      vdivisor        := setall0(divisor_width-1)&'1';
      vquotient       := setall0(bus_latency);
      vremainder      := setall0(fractional_width);
      roc_clock_count := c_roc_clock_count_init;
      clock_counter   := c_clock_counter_init;
      IF divclk_sel = 1 THEN
        vrfd := '1';
      ELSE
        vrfd := '0';
      END IF;
    END;  --initialise

  BEGIN
    --to fix the -MAX divisor or -MAX dividend bug the unsigned division within
    --the signed operation has been increased by a bit. This increases the
    --latency by one cycle also.
    u_divisor_width  := divisor_width;
    u_dividend_width := dividend_width;
    u_bus_latency    := bus_latency;

    IF(setup = TRUE) THEN
      initialise(quotient_d, remainder_d, vdividend, vdivisor, vquotient, vremainder,
                 roc_clock_count, clock_counter, vrfd
                 );
      setup := FALSE;
      rfd   <= vrfd;
    ELSIF (rat(clk) = 'X') THEN
      -- everything set to X
      FOR i IN latency-1 DOWNTO 0 LOOP
        quotient_d(i)  := setallX(dividend_width);
        remainder_d(i) := setallX(fractional_width);
      END LOOP;

    ELSIF (rising_edge(clk)) THEN
      -- deal with c_sync_enable = 0 and sclr = '1' when ce = '0'
      IF (C_CE_OVERRIDES_SYNC = 0) AND (c_has_sclr = 1) AND (sclr = '1') THEN
        initialise(quotient_d, remainder_d, vdividend, vdivisor, vquotient, vremainder,
                   roc_clock_count, clock_counter, vrfd
                   );
        s_clk_cnt <= clock_counter;
        rfd       <= vrfd;

      ELSE
        IF ((c_has_ce = 1) AND (ce = '1')) OR (c_has_ce = 0) THEN
          IF (c_has_sclr = 1) AND (sclr = '1') THEN
            initialise(quotient_d, remainder_d, vdividend, vdivisor, vquotient, vremainder,
                       roc_clock_count, clock_counter, vrfd
                       );
            s_clk_cnt <= clock_counter;
            rfd       <= vrfd;

          ELSE
            s_clk_cnt <= clock_counter;
            IF(roc_clock_count /= 0) THEN
              -- take account of reset time
              roc_clock_count := roc_clock_count -1;

              --sorry, but there's no other place for this kludge to go.
              IF divclk_sel = 2 AND signed_b = 1 THEN
                vrfd := '1';
              ELSE
                vrfd := '0';
              END IF;
              rfd <= vrfd;
            ELSE
              clock_counter := clock_counter +1;
              s_clk_cnt     <= clock_counter;
-- END IF;

              IF signed_b = 1 THEN
                IF divclk_sel = 1 THEN
                  vrfd := '1';
                ELSE
                  IF ((divclk_sel /= 2) AND(clock_counter = divclk_sel -2)) OR
                    ((divclk_sel = 2) AND (clock_counter = 2)) THEN
                    vrfd := '1';
                  ELSE
                    vrfd := '0';
                  END IF;
                END IF;
              ELSE
                IF ((clock_counter REM divclk_sel) = divclk_sel -1) THEN
                  vrfd := '1';
                ELSE
                  vrfd := '0';
                END IF;
              END IF;
              rfd <= vrfd;

              IF (signed_b = 1) THEN
                IF((clock_counter REM divclk_sel) = divclk_sel -1) THEN
                  vdividend := std_logic_vector_2_var(dividend);
                  vdivisor  := std_logic_vector_2_var(divisor);
                END IF;
              END IF;


              IF((clock_counter REM divclk_sel) = 0) AND roc_clock_count = 0 THEN
                clock_counter := 0;
                s_clk_cnt     <= clock_counter;

                -- main part of the divisor process
                -- check first that there is no errors on the input
                IF( anyX(dividend) OR anyX(divisor)) THEN
                  vquotient  := setallX(bus_latency);
                  vremainder := setallX(fractional_width);
                ELSE

                  -- initialise variables and signed booleans
                  dividend_neg   := FALSE;
                  divisor_neg    := FALSE;
                  s_dividend_neg <= FALSE;
                  s_divisor_neg  <= FALSE;
                  IF (signed_b = 0) THEN
                    --latched in at a different phase of div_clk for signed case
                    vdividend := std_logic_vector_2_var(dividend);
                    vdivisor  := std_logic_vector_2_var(divisor);
                  END IF;
                  s_vdivisor  <= vdivisor;
                  s_vdividend <= vdividend;

                  -- check whether the dividend is negative and convert to positive
                  IF((signed_b = 1) AND (vdividend(dividend_width -1) = '1')) THEN
                    dividend_neg    := TRUE;
                    s_dividend_neg  <= TRUE;
                    vdividend_big   := NOT('0'&vdividend)+1;
                    s_vdividend_big <= vdividend_big;
                    vdividend       := vdividend_big(dividend_width-1 DOWNTO 0);
                  END IF;

                  -- check whether the divisor is negative and convert to positive
                  IF((signed_b = 1) AND (vdivisor(divisor_width -1) = '1')) THEN
                    divisor_neg    := TRUE;
                    s_divisor_neg  <= TRUE;
                    vdivisor_big   := NOT('0'&vdivisor)+1;
                    s_vdivisor_big <= vdivisor_big;
                    vdivisor       := vdivisor_big(divisor_width-1 DOWNTO 0);
                  END IF;

                  -- quotient is negative if
                  IF (dividend_neg XOR divisor_neg) THEN
                    quotient_neg := TRUE;
                  ELSE
                    quotient_neg := FALSE;
                  END IF;
                  s_quotient_neg <= quotient_neg;

                  -- remainder is negative if
                  IF (dividend_neg) THEN
                    remainder_neg := TRUE;
                  ELSE
                    remainder_neg := FALSE;
                  END IF;
                  s_remainder_neg <= remainder_neg;

                  vdividend_temp(u_dividend_width -1 DOWNTO 0) := vdividend(u_dividend_width - 1 DOWNTO 0);
                  vdivisor_temp(u_divisor_width DOWNTO 0)      := '0'&vdivisor(u_divisor_width - 1 DOWNTO 0);

                  vtemp := (OTHERS => '0');

                  -- main loop for the quotient remainder calculation 
                  FOR i IN 0 TO u_bus_latency-1 LOOP
                    restore                         := vtemp(u_divisor_width);
                    vtemp(u_divisor_width DOWNTO 1) := vtemp(u_divisor_width -1 DOWNTO 0);
                    -- add in the lowest bit of the dividend
                    IF(u_dividend_width - 1 -i >= 0) THEN
                      vtemp(0) := vdividend_temp(u_dividend_width-1-i);
                    ELSE
                      vtemp(0) := '0';
                    END IF;

                    IF (restore = '1') THEN
                      -- add vtemp to vdivsor_temp
                      -- vtemp_new := vtemp + vdivisor_temp;
                      cin := '0';
                      FOR j IN 0 TO u_divisor_width LOOP
                        vtemp_new(j) := vtemp(j) XOR vdivisor_temp(j) XOR cin;
                        cin          := (vtemp(j) AND vdivisor_temp(j))
                                        OR (cin AND vtemp(j))
                                        OR (cin AND vdivisor_temp(j));
                      END LOOP;

                    ELSE
                      -- subtract the divisor from vtemp
                      -- vtemp_new := vtemp - vdivisor_temp;
                      cin := '0';
                      FOR j IN 0 TO u_divisor_width LOOP
                        vtemp_new(j) := ((vtemp(j) XOR vdivisor_temp(j)) AND (NOT(cin)))
                                                                     OR ((NOT(vtemp(j) XOR vdivisor_temp(j)) AND cin));
                        cin := ( NOT(cin) AND (NOT(vtemp(j)) AND vdivisor_temp(j)) ) OR
                                                                     ( cin AND (NOT(vtemp(j)) OR vdivisor_temp(j)) );
                      END LOOP;
                    END IF;
                    vtemp                          := vtemp_new;
                    vquotient(u_bus_latency -1 -i) := NOT(vtemp(u_divisor_width));
                  END LOOP;
                  -- calculate the remainder
                  IF(fractional_b = 0) THEN
                    IF( vtemp(u_divisor_width) = '1') THEN
                      -- remainder is result plus divisor 
                      -- vremainder_temp := vtemp + vdivisor_temp;
                      cin := '0';
                      FOR j IN 0 TO u_divisor_width-1 LOOP
                        vremainder_temp(j) := vtemp(j) XOR vdivisor_temp(j) XOR cin;
                        cin                := (vtemp(j) AND vdivisor_temp(j))
                                                                     OR (cin AND vtemp(j))
                                                                     OR (cin AND vdivisor_temp(j));
                      END LOOP;
                    ELSE
                      vremainder_temp(u_divisor_width-1 DOWNTO 0) := vtemp(u_divisor_width -1 DOWNTO 0);
                    END IF;

                    vremainder(u_divisor_width -1 DOWNTO 0) := vremainder_temp(u_divisor_width-1 DOWNTO 0);
                  END IF;  -- not fractional

                  IF(remainder_neg) THEN
                    remainder_big   := NOT('0'&vremainder)+1;
                    s_remainder_big <= remainder_big;
                    vremainder      := remainder_big(fractional_width - 1 DOWNTO 0);
                  END IF;
                END IF;  -- clock_counter check

              END IF;  -- if anyX                

              -- move the values through the latency array by one stage
              FOR i IN latency -2 DOWNTO 0 LOOP
                quotient_d(i+1)  := quotient_d(i);
                remainder_d(i+1) := remainder_d(i);
              END LOOP;

              IF(fractional_b = 1) THEN
                IF(signed_b = 0) THEN
                  remainder_d(0) := vquotient(fractional_width-1 DOWNTO 0);
                ELSE
                  vremainder(fractional_width-1 DOWNTO 0) := '0' & vquotient(fractional_width-1 DOWNTO 1);-- fix for CR481526
                  IF (quotient_neg) THEN
                    remainder_big := NOT('0'&vremainder)+1;
                  ELSE
                    IF anyX(vremainder) THEN
                      temp_bit := 'X';
                    ELSE
                      temp_bit := '0';
                    END IF;
                    remainder_big := temp_bit&vremainder;
                  END IF;
                  remainder_d(0) := remainder_big(fractional_width-1 DOWNTO 0); -- fix for CR481526
                END IF;
              ELSE
                remainder_d(0) := vremainder;
              END IF;

              -- add in the newest results
              quotient_d(0) := vquotient(bus_latency-1 DOWNTO bus_latency - dividend_width);
              IF (quotient_neg) THEN
                quotient_big   := NOT('0'&quotient_d(0))+1;
                s_quotient_big <= quotient_big;
                quotient_d(0)  := quotient_big(dividend_width -1 DOWNTO 0);
              END IF;
            END IF;
          END IF;
        END IF;  -- sync_enable
      END IF;  -- slcr
    END IF;  -- setup

    -- put the results out to the ports
    quot          <= quotient_d(latency - 1);
    remd          <= remainder_d(latency - 1);
    s_quotient_d  <= quotient_d;
    s_remainder_d <= remainder_d;

    -- wait on the clk
    --   WAIT ON c;
--    s_vdividend_big <= vdividend_big;
--    s_vdivisor_big  <= vdivisor_big;
--    s_quotient_big  <= quotient_big;
--    s_remainder_big <= remainder_big;
--    s_dividend_neg  <= dividend_neg;
--    s_divisor_neg   <= divisor_neg;
--    s_quotient_neg  <= quotient_neg;
--    s_remainder_neg <= remainder_neg;
--    s_vdivisor      <= vdivisor;
--    s_vdividend     <= vdividend;
--    s_quotient_d    <= quotient_d;
--    s_remainder_d   <= remainder_d;
--    
  END PROCESS;
 
END behavioral;

