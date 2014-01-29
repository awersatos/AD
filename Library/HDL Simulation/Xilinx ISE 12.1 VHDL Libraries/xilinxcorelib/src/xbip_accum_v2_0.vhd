
-- $Id: xbip_accum_v2_0.vhd,v 1.3 2009/09/08 16:38:07 akennedy Exp $
--
--  (c) Copyright 1995-2008 Xilinx, Inc. All rights reserved.
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
-- Behavioural Model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_signed.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY XilinxCoreLib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.xbip_accum_v2_0_pkg.all;

--
--core_if on entity xbip_accum_v2_0
  entity xbip_accum_v2_0 is
    GENERIC (
      C_XDEVICEFAMILY       : STRING  := "no_family";
      C_USE_DSP48           : INTEGER := 0;
      C_VERBOSITY           : integer := 0;
      C_LATENCY             : integer := 0;
      C_BYPASS_LOW          : integer := 0;
      C_B_WIDTH             : INTEGER := 16;
      C_OUT_WIDTH           : INTEGER := 16;
      C_CE_OVERRIDES_SCLR   : INTEGER := 0; --0=SYNC over CE, 1 = CE over SYNC
      C_DATA_TYPE           : INTEGER := 1; --0=signed, 1=unsigned;
      C_HAS_BYPASS          : INTEGER := 1; --0=no_bypass, 1=bypass;
      C_ADD_MODE            : INTEGER := 0 --0=add, 1=sub, 2=addsub;
      );
    PORT (
      B        : in  std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');  -- input value
      CLK      : in  std_logic                              := '0';  -- clock
      ADDF     : in  std_logic                              := '1';
      C_IN     : in  std_logic                              := '0';  -- carry in
      CE       : in  std_logic                              := '1';  -- clock enable
      BYPASS   : in  std_logic                              := '0';  -- sync load of b into reg
      SCLR     : in  std_logic                              := '0';  -- synch init.
      Q        : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')  -- synch output value
      );
--core_if off
END xbip_accum_v2_0;


ARCHITECTURE behavioral OF xbip_accum_v2_0 IS

  constant check_generics : integer := fn_xbip_accum_v2_0_check_generics(
    p_xdevicefamily  => C_XDEVICEFAMILY,
    p_use_dsp48 => C_USE_DSP48,
    p_verbosity => C_VERBOSITY,
    p_latency => C_LATENCY,
    p_bypass_low => C_BYPASS_LOW,
    p_b_width => C_B_WIDTH,
    p_out_width => C_OUT_WIDTH,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_data_type => C_DATA_TYPE,
    p_has_bypass => C_HAS_BYPASS,
    p_add_mode => C_ADD_MODE
    );
  constant ci_pipe_all : t_xbip_accum_v2_0_latency := fn_xbip_accum_v2_0_latency(
    p_xdevicefamily  => C_XDEVICEFAMILY,
    p_use_dsp48 => C_USE_DSP48,
    p_verbosity => C_VERBOSITY,
    p_latency => C_LATENCY,
    p_bypass_low => C_BYPASS_LOW,
    p_b_width => C_B_WIDTH,
    p_out_width => C_OUT_WIDTH,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_data_type => C_DATA_TYPE,
    p_has_bypass => C_HAS_BYPASS,
    p_add_mode => C_ADD_MODE
    );
  constant ci_resources : t_xbip_accum_v2_0_resources := fn_xbip_accum_v2_0_get_resources(
    p_xdevicefamily  => C_XDEVICEFAMILY,
    p_use_dsp48 => C_USE_DSP48,
    p_verbosity => C_VERBOSITY,
    p_latency => C_LATENCY,
    p_bypass_low => C_BYPASS_LOW,
    p_b_width => C_B_WIDTH,
    p_out_width => C_OUT_WIDTH,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_data_type => C_DATA_TYPE,
    p_has_bypass => C_HAS_BYPASS,
    p_add_mode => C_ADD_MODE
    );
 
  constant pipe_used : integer := ci_pipe_all.used;
  signal diag_pipe : t_xbip_accum_v2_0_latency := ci_pipe_all;
  signal diag_resources : t_xbip_accum_v2_0_resources := ci_resources;

  function fn_bypass_sense(
    p_bypass_low    : integer
    )
    return std_logic is
    variable ret_val : std_logic := '1';
  begin
    if (p_bypass_low = 0) then
      ret_val := '1';
      return ret_val;
    else
      ret_val := '0';
      return ret_val;
    end if;
  end function fn_bypass_sense;
 

  constant bypass_sense : std_logic := fn_bypass_sense(C_BYPASS_LOW);

  signal bypass_i : std_logic := '0';
  signal addf_i : std_logic := '0';
  signal c_in_i : std_logic := '0';
  signal sclr_i : std_logic := '0';
  signal b_i : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');
  signal q_i : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');
  signal q_p : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');
  signal b_i_ext : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');

BEGIN
  sclr_i <= SCLR when C_CE_OVERRIDES_SCLR=0 else (SCLR and CE);

  with_bypass: if c_has_bypass = 1 generate
    bypass_i <= bypass;
  end generate with_bypass;
  no_bypass: if c_has_bypass = 0 generate
    bypass_i <= not(bypass_sense);
  end generate no_bypass;
  mode_add: if c_add_mode = 0 generate
    addf_i <= '0';
  end generate mode_add;
  mode_sub: if c_add_mode = 1 generate
    addf_i <= '1';
  end generate mode_sub;
  mode_addsub: if c_add_mode = 2 generate
    addf_i <= ADDF;
  end generate mode_addsub;
    c_in_i <= C_IN;
    b_i <= B;


  equal_widths: if (C_OUT_WIDTH = C_B_WIDTH) generate
    b_i_ext <= b_i;
  end generate equal_widths;
  resize_b: if (C_OUT_WIDTH > C_B_WIDTH) generate
    b_i_ext <= std_logic_vector(resize(signed(b_i),C_OUT_WIDTH)) when C_DATA_TYPE=c_signed else 
        std_logic_vector(resize(unsigned(b_i),C_OUT_WIDTH)); 
  end generate resize_b;

  accumulation: process (clk)
  begin 
    if rising_edge(clk) then
      if sclr_i = '1' then
        q_i <= (others => '0');
      elsif CE = '1' then
        if bypass_i = bypass_sense then 
          q_i <= b_i_ext; 
        else
          if addf_i = '0' then
            q_i <= q_i + (b_i_ext + c_in_i); 
          else 
            q_i <= q_i - (b_i_ext + c_in_i);
          end if;
        end if;
      end if;
    end if;
  end process accumulation;

  latency_1 : if pipe_used = 1 generate
    Q <= q_i;
  end generate latency_1;

  latency_gt_1 : if pipe_used > 1 generate
    delay_reg: process (clk)
      constant ndelays : integer := pipe_used-1;
      type delaymem is array(1 to ndelays) of std_logic_vector(C_OUT_WIDTH-1 downto 0);
      variable srmem : delaymem := (others => (others => '0'));
    begin
      if rising_edge(clk) then
        if sclr_i = '1' then
          for i in ndelays downto 1 loop
            srmem(i) := (others => '0');
          end loop;
          q_p <= (others => '0');
        elsif CE = '1' then
          for i in ndelays downto 2 loop
            srmem(i) := srmem(i-1);
          end loop;
          srmem(1) := q_i;
          q_p <= srmem(ndelays);
        end if;
      end if;
    end process delay_reg;
    Q <= q_p;
  end generate latency_gt_1;

END behavioral;
