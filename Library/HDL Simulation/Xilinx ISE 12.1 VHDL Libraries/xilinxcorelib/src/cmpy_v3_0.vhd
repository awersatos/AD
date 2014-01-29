-- $RCSfile $ $Date: 2010/01/28 12:33:16 $ $Revision: 1.5 $
--
-- (c) Copyright 2009 - 2009 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 
--
-------------------------------------------------------------------------------
-- Behavioral Model for cmpy_v3_0
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.get_min;
use xilinxcorelib.cmpy_pkg_v3_0.all;

--core_if on entity cmpy_v3_0
  entity cmpy_v3_0 is
    generic (
      C_VERBOSITY         : integer := 0;
      C_XDEVICEFAMILY     : string  := "no_family";
      C_XDEVICE           : string  := "no_family";
      C_A_WIDTH           : integer := 16;
      C_B_WIDTH           : integer := 16;
      C_OUT_HIGH          : integer := 31;           -- MSB of product
      C_OUT_LOW           : integer := 0;            -- LSB of product
      C_LATENCY           : integer := -1;           -- Latency of CMPY (-1 = fully pipelined)
      C_MULT_TYPE         : integer := 1;            -- 0 = Use LUTs, 1 = Use MULT18X18x/DSP48x
      C_OPTIMIZE_GOAL     : integer := 0;            -- 0 = Minimise mult/DSP count, 1 = Performance
      C_HAS_CE            : integer := 0;            -- 0 = No clock enable, 1 = active-high clock enable
      C_HAS_SCLR          : integer := 0;            -- 0 = No sync. clear, 1 = active-high sync. clear
      C_CE_OVERRIDES_SCLR : integer := 0;            -- Self-explanatory
      HAS_NEGATE          : integer := 0;            -- 0=NEGATE_R/I disabled, 1=Apply negation to B inputs, 2=Apply negation to A inputs
      SINGLE_OUTPUT       : integer := 0;            -- Only generate real half of CMPY
      ROUND               : integer := 0;            -- Add rounding constant for better noise performance
      USE_DSP_CASCADES    : integer := 1             -- 0 = break cascades (S3A-DSP only), 1 = use cascades normally, 2 = chain all DSPs together
      );
    port (
      AR       : in  std_logic_vector(C_A_WIDTH-1 downto 0)          := (others => '0');
      AI       : in  std_logic_vector(C_A_WIDTH-1 downto 0)          := (others => '0');
      BR       : in  std_logic_vector(C_B_WIDTH-1 downto 0)          := (others => '0');
      BI       : in  std_logic_vector(C_B_WIDTH-1 downto 0)          := (others => '0');
      CLK      : in  std_logic                                       := '0';
      CE       : in  std_logic                                       := '1';
      SCLR     : in  std_logic                                       := '0';
      ROUND_CY : in  std_logic                                       := '0';
      NEGATE_R : in  std_logic                                       := '0';
      NEGATE_I : in  std_logic                                       := '0';
      SO_START : in  std_logic                                       := '0';
      PR       : out std_logic_vector(C_OUT_HIGH-C_OUT_LOW downto 0) := (others => '0');
      PI       : out std_logic_vector(C_OUT_HIGH-C_OUT_LOW downto 0) := (others => '0')
      );
--core_if off
end cmpy_v3_0;


architecture behavioral of cmpy_v3_0 is

  constant generics : R_GENERICS := check_and_resolve_generics(C_VERBOSITY,
                                                               C_XDEVICEFAMILY,
                                                               C_XDEVICE,
                                                               C_A_WIDTH,
                                                               C_B_WIDTH,
                                                               C_OUT_HIGH,
                                                               C_OUT_LOW,
                                                               C_LATENCY,
                                                               C_MULT_TYPE,
                                                               C_OPTIMIZE_GOAL,
                                                               C_HAS_CE,
                                                               C_HAS_SCLR,
                                                               C_CE_OVERRIDES_SCLR,
                                                               HAS_NEGATE,
                                                               SINGLE_OUTPUT,
                                                               ROUND,
                                                               USE_DSP_CASCADES);

  
  constant pipeline_latency : integer := cmpy_v3_0_latency(C_XDEVICEFAMILY, generics.R_A_WIDTH, generics.R_B_WIDTH, generics.R_OUT_HIGH, generics.R_OUT_LOW, generics.R_LATENCY, generics.R_MULT_TYPE, generics.R_OPTIMIZE_GOAL, generics.R_SINGLE_OUTPUT, generics.R_HAS_NEGATE, generics.R_ROUND);

  constant max_a_width : integer := 64;
  constant max_b_width : integer := 64;

  signal ar_internal, ai_internal : std_logic_vector(max_a_width-1 downto 0) := (others => '0');
  signal br_internal, bi_internal : std_logic_vector(max_b_width-1 downto 0) := (others => '0');

  signal pr_internal, pi_internal, pr_rounded, pi_rounded, pr_delayed, pi_delayed : std_logic_vector(max_a_width-1+max_b_width-1+1 downto 0) := (others => '0');

  signal round_const : std_logic_vector(pr_rounded'range) := (others => '0');

  signal ce_i   : std_logic := '1';
  signal sclr_i : std_logic := '0';
  
begin

  has_ce: if generics.R_HAS_CE = 1 generate
    ce_i <= CE;
  end generate has_ce;

  has_sclr: if generics.R_HAS_SCLR = 1 generate
    sclr_overrides_ce: if generics.R_CE_OVERRIDES_SCLR = 0 generate
      sclr_i <= SCLR;      
    end generate sclr_overrides_ce;
    ce_overrides_sclr: if generics.R_CE_OVERRIDES_SCLR = 1 generate
      sclr_i <= ce_i and SCLR;      
    end generate ce_overrides_sclr;
  end generate has_sclr;
  
  -----------------------------------------------------------------------------
  -- Sign-extend inputs up to max. possible width
  -----------------------------------------------------------------------------
  ar_internal <= std_logic_vector(resize(signed(AR), ar_internal'length));
  ai_internal <= std_logic_vector(resize(signed(AI), ai_internal'length));

  br_internal <= std_logic_vector(resize(signed(BR), br_internal'length));
  bi_internal <= std_logic_vector(resize(signed(BI), bi_internal'length));

  -----------------------------------------------------------------------------
  -- Do complex multiply
  -----------------------------------------------------------------------------
  cmpy : process (ar_internal, ai_internal, br_internal, bi_internal, NEGATE_R, NEGATE_I) is
    variable armod : std_logic_vector(ar_internal'range)                                := (others => '0');
    variable aimod : std_logic_vector(ai_internal'range)                                := (others => '0');
    variable brmod : std_logic_vector(br_internal'range)                                := (others => '0');
    variable bimod : std_logic_vector(bi_internal'range)                                := (others => '0');
    variable arxbr : std_logic_vector(ar_internal'length+br_internal'length-1 downto 0) := (others => '0');
    variable aixbi : std_logic_vector(ai_internal'length+bi_internal'length-1 downto 0) := (others => '0');
    variable aixbr : std_logic_vector(ai_internal'length+br_internal'length-1 downto 0) := (others => '0');
    variable arxbi : std_logic_vector(ar_internal'length+bi_internal'length-1 downto 0) := (others => '0');
  begin
    
    if NEGATE_R = '1' and generics.R_HAS_NEGATE /= 0 then
      armod := ar_internal;
      brmod := -br_internal;
    else
      armod := ar_internal;
      brmod := br_internal;
    end if;

    if NEGATE_I = '1' and generics.R_HAS_NEGATE /= 0 then
      aimod := ai_internal;
      bimod := -bi_internal;
    else
      aimod := ai_internal;
      bimod := bi_internal;
    end if;

    arxbr       := armod * brmod;
    aixbi       := aimod * bimod;
    aixbr       := aimod * brmod;
    arxbi       := armod * bimod;
    pr_internal <= arxbr - aixbi;
    pi_internal <= aixbr + arxbi;
  end process cmpy;

  -----------------------------------------------------------------------------
  -- Do rounding if necessary
  -----------------------------------------------------------------------------
  no_rounding : if generics.R_ROUND = 0 generate
    pr_rounded <= pr_internal;
    pi_rounded <= pi_internal;
  end generate no_rounding;
  do_rounding : if generics.R_ROUND = 1 generate
    round_const(generics.R_OUT_LOW-2 downto 0) <= (others => '1');
    pr_rounded                        <= pr_internal + round_const + ROUND_CY;
    pi_rounded                        <= pi_internal + round_const + ROUND_CY;
  end generate do_rounding;
  do_rounding_no_cy : if generics.R_ROUND = 2 generate
    round_const(generics.R_OUT_LOW-2 downto 0) <= (others => '1');
    pr_rounded                        <= pr_internal + round_const;
    pi_rounded                        <= pi_internal + round_const;
  end generate do_rounding_no_cy;
 
  -----------------------------------------------------------------------------
  -- Delay outputs to match core
  -----------------------------------------------------------------------------
  pipe0 : if pipeline_latency = 0 generate
    pr_delayed <= pr_rounded;
    pi_delayed <= pi_rounded;
  end generate pipe0;
  pipe1 : if pipeline_latency = 1 generate
    process (CLK) is
    begin
      if rising_edge(CLK) then
        if sclr_i = '1' then
          pr_delayed <= (others => '0');
          pi_delayed <= (others => '0');
        else
          if ce_i = '1' then
            pr_delayed <= pr_rounded;
            pi_delayed <= pi_rounded;
          end if;
        end if;
      end if;
    end process;
  end generate pipe1;
  pipeX : if pipeline_latency > 1 generate
    type T_PR_DELAY is array (0 to pipeline_latency-1) of std_logic_vector(pr_rounded'range);
    type T_PI_DELAY is array (0 to pipeline_latency-1) of std_logic_vector(pi_rounded'range);
    signal pr_delay_line : T_PR_DELAY := (others => (others => '0'));
    signal pi_delay_line : T_PI_DELAY := (others => (others => '0'));
  begin
    process (CLK) is
    begin
      if rising_edge(CLK) then
        if sclr_i = '1' then
          pr_delay_line <= (others => (others => '0'));
          pi_delay_line <= (others => (others => '0'));
        else
          if ce_i = '1' then
            pr_delay_line <= pr_rounded & pr_delay_line(0 to pipeline_latency-2);
            pi_delay_line <= pi_rounded & pi_delay_line(0 to pipeline_latency-2);
          end if;
        end if;
      end if;
    end process;
    pr_delayed <= pr_delay_line(pipeline_latency-1);
    pi_delayed <= pi_delay_line(pipeline_latency-1);
  end generate pipeX;

  -----------------------------------------------------------------------------
  -- Final output, possibly rounded and delayed
  -----------------------------------------------------------------------------
  PR <= pr_delayed(generics.R_OUT_HIGH downto generics.R_OUT_LOW);
  PI <= pi_delayed(generics.R_OUT_HIGH downto generics.R_OUT_LOW);
  
end architecture behavioral;

