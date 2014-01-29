-- $RCSfile: xbip_multaccum_v2_0.vhd,v $ $Date: 2009/12/04 11:46:45 $ $Revision: 1.4 $
--
--  (c) Copyright 2008-2009 Xilinx, Inc. All rights reserved.
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
-- Behavioral Model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

library XilinxCoreLib;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.xbip_pipe_v2_0_comp.all;
use xilinxcorelib.xbip_multaccum_pkg_v2_0.all;
--use xilinxcorelib.xbip_accum_v2_0_pkg.all;


--core_if on entity xbip_multaccum_v2_0
entity xbip_multaccum_v2_0 is
  generic (
    C_VERBOSITY         :     integer                                  := 0;
    C_XDEVICEFAMILY     :     string                                   := "NO_FAMILY";
    C_USE_DSP48         :     integer                                  := 1;  -- 1:DSP48, this is the only option in this version
    C_LATENCY           :     integer                                  := -1;  -- -1: corresponds to automatic latency
    C_ACCUM_WIDTH       :     integer                                  := 45;
    C_A_WIDTH           :     integer                                  := 16;
    C_B_WIDTH           :     integer                                  := 16;
    C_A_TYPE            :     integer                                  := 0;  -- 0:signed, 1:unsigned
    C_B_TYPE            :     integer                                  := 0;  -- 0:signed, 1:unsigned
    C_OUT_WIDTH         :     integer                                  := 45;
    C_ROUND_TYPE        :     integer                                  := 0;  -- 0:truncation (all that is supported in v1)
    C_HAS_BYPASS        :     integer                                  := 0;  -- 0:no BYPASS,  1:BYPASS
    C_BYPASS_LOW        :     integer                                  := 0;  -- 0:active High,  1:active Low
    C_ACCUM_MODE        :     integer                                  := 0;  -- 0:add,  1:subtract, 2:add/sub
    C_CE_OVERRIDES_SCLR :     integer                                  := 0  -- 0:SCLR overrides CE,  1:CE overrides SCLR
    );
  port (
    CLK                 : in  std_logic                                := '0';
    CE                  : in  std_logic                                := '1';
    SCLR                : in  std_logic                                := '0';
    BYPASS              : in  std_logic                                := '0';
    SUBTRACT            : in  std_logic                                := '0';  -- used with accum_mode=2, 0=>add, 1=>sub
    A                   : in  std_logic_vector(C_A_WIDTH-1 downto 0)   := (others => '0');
    B                   : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');
    S                   : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')
    );
--core_if off
end xbip_multaccum_v2_0;


architecture behavioral of xbip_multaccum_v2_0 is

  function fn_bypass_sense(
    p_bypass_low     : integer;
    p_has_bypass     : integer
    )
    return std_logic is
    variable ret_val : std_logic := '1';
  begin
    if (p_bypass_low = 0 or p_has_bypass = 0) then
      ret_val                    := '1';
      return ret_val;
    else
      ret_val                    := '0';
      return ret_val;
    end if;
  end function fn_bypass_sense;

  constant bypass_sense   : std_logic := fn_bypass_sense(
    P_BYPASS_LOW => C_BYPASS_LOW,
    P_HAS_BYPASS => C_HAS_BYPASS
    );
  constant prod_tmp_width : integer   := C_A_WIDTH+1+C_B_WIDTH+1;

  constant multaccum_latency : t_xbip_multaccum_v2_0_latency := fn_xbip_multaccum_v2_0_latency(
    P_VERBOSITY         => C_VERBOSITY,
    P_XDEVICEFAMILY     => C_XDEVICEFAMILY,
    P_USE_DSP48         => C_USE_DSP48,
    P_LATENCY           => C_LATENCY,
    P_ACCUM_WIDTH       => C_ACCUM_WIDTH,
    P_A_WIDTH           => C_A_WIDTH,
    P_B_WIDTH           => C_B_WIDTH,
    P_A_TYPE            => C_A_TYPE,
    P_B_TYPE            => C_B_TYPE,
    P_OUT_WIDTH         => C_OUT_WIDTH,
    P_ROUND_TYPE        => C_ROUND_TYPE,
    P_HAS_BYPASS        => C_HAS_BYPASS,
    P_BYPASS_LOW        => C_BYPASS_LOW,
    P_ACCUM_MODE        => C_ACCUM_MODE,
    P_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR
    );

  constant check_gens : integer := fn_check_generics_xbip_multaccum_v2_0(
    C_VERBOSITY         => C_VERBOSITY,
    C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
    C_USE_DSP48         => C_USE_DSP48,
    C_LATENCY           => C_LATENCY,
    C_ACCUM_WIDTH       => C_ACCUM_WIDTH,
    C_A_WIDTH           => C_A_WIDTH,
    C_B_WIDTH           => C_B_WIDTH,
    C_A_TYPE            => C_A_TYPE,
    C_B_TYPE            => C_B_TYPE,
    C_OUT_WIDTH         => C_OUT_WIDTH,
    C_ROUND_TYPE        => C_ROUND_TYPE,
    C_HAS_BYPASS        => C_HAS_BYPASS,
    C_BYPASS_LOW        => C_BYPASS_LOW,
    C_ACCUM_MODE        => C_ACCUM_MODE,
    C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR
    );


  constant latency_total : integer := multaccum_latency.total_latency;
  constant r_accum_width : integer := C_ACCUM_WIDTH + C_A_TYPE + C_B_TYPE;

  signal a_i         : std_logic_vector(C_A_WIDTH downto 0)        := (others => '0');
  signal b_i         : std_logic_vector(C_B_WIDTH downto 0)        := (others => '0');
  signal prod_tmp    : std_logic_vector(prod_tmp_width-1 downto 0) := (others => '0');
  signal q_i         : std_logic_vector(r_accum_width-1 downto 0)  := (others => '0');
  signal product_ext : std_logic_vector(r_accum_width-1 downto 0)  := (others => '0');
  signal s_i         : std_logic_vector(C_OUT_WIDTH-1 downto 0)    := (others => '0');

  signal ce_i       : std_logic := '1';
  signal sclr_i     : std_logic := '0';
  signal bypass_i   : std_logic := '0';
  signal subtract_i : std_logic := '1';

begin
  addition    : if (C_ACCUM_MODE = 0) generate
    subtract_i <= '0';
  end generate addition;
  subtraction : if (C_ACCUM_MODE = 1) generate
    subtract_i <= '1';
  end generate subtraction;
  addsub      : if (C_ACCUM_MODE = 2) generate
    subtract_i <= SUBTRACT;
  end generate addsub;

  has_bypass    : if (C_HAS_BYPASS = 1) generate
    bypass_i <= BYPASS;
  end generate has_bypass;
  has_no_bypass : if (C_HAS_BYPASS = 0) generate
    bypass_i <= '0';
  end generate has_no_bypass;

  ce_i <= CE;

  ce_overrides_sclr : if (C_CE_OVERRIDES_SCLR = 1) generate
    sclr_i <= ce_i and SCLR;
  end generate ce_overrides_sclr;
  sclr_overrides_ce : if (C_CE_OVERRIDES_SCLR = 0) generate
    sclr_i <= SCLR;
  end generate sclr_overrides_ce;

  signed_A   : if (C_A_TYPE = c_signed) generate
    a_i <= a(C_A_WIDTH-1) & a;
  end generate signed_A;
  unsigned_A : if (C_A_TYPE = c_unsigned) generate
    a_i <= '0' & a;
  end generate unsigned_A;

  signed_B   : if (C_B_TYPE = c_signed) generate
    b_i <= b(C_B_WIDTH-1) & b;
  end generate signed_B;
  unsigned_B : if (C_B_TYPE = c_unsigned) generate
    b_i <= '0' & b;
  end generate unsigned_B;

  prod_tmp <= a_i * b_i;

  uns_uns               : if (C_A_TYPE = c_unsigned) and (C_B_TYPE = c_unsigned) generate
    constant prod_width : integer := C_A_WIDTH+C_B_WIDTH;
    signal   product    : std_logic_vector(prod_width-1 downto 0);
  begin
    product     <= prod_tmp(prod_width-1 downto 0);
    product_ext <= std_logic_vector(resize(unsigned(product), r_accum_width));
  end generate uns_uns;

  s_s                   : if (C_A_TYPE = c_signed) and (C_B_TYPE = c_signed) generate
    constant prod_width : integer := C_A_WIDTH+C_B_WIDTH;
    signal   product    : std_logic_vector(prod_width-1 downto 0);
  begin
    product     <= prod_tmp(prod_width-1 downto 0);
    product_ext <= std_logic_vector(resize(signed(product), r_accum_width));
  end generate s_s;

  mixed_sign            : if ((C_A_TYPE = c_unsigned) and (C_B_TYPE = c_signed)) or ((C_A_TYPE = c_signed) and (C_B_TYPE = c_unsigned)) generate
    constant prod_width : integer := C_A_WIDTH+C_B_WIDTH+1;
    signal   product    : std_logic_vector(prod_width-1 downto 0);
  begin
    product     <= prod_tmp(prod_width-1 downto 0);
    product_ext <= std_logic_vector(resize(signed(product), r_accum_width));
  end generate mixed_sign;

  accumulation : process (clk)
  begin
    if rising_edge(clk) then
      if sclr_i = '1' then
        q_i     <= (others => '0');
      elsif ce_i = '1' then
        if bypass_i = bypass_sense then
          q_i   <= product_ext;
        else
          if subtract_i = '0' then
            q_i <= q_i + product_ext;
          else
            q_i <= q_i - product_ext;
          end if;
        end if;
      end if;
    end if;
  end process accumulation;

  s_i <= q_i(r_accum_width-1 downto r_accum_width-C_OUT_WIDTH);
  pipe_delay : xbip_pipe_v2_0
    generic map(
      c_latency  => latency_total -1,
      c_has_ce   => 1,
      c_has_sclr => 1,
      c_width    => C_OUT_WIDTH
      )
    port map(
      CLK        => clk,
      CE         => ce_i,
      SCLR       => sclr_i,
      D          => s_i,
      Q          => S
      );

end behavioral;

