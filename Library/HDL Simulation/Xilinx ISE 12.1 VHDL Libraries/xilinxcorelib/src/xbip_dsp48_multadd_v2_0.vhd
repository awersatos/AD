-- $Id: xbip_dsp48_multadd_v2_0.vhd,v 1.3 2009/09/08 16:46:33 akennedy Exp $
-------------------------------------------------------------------------------
--  (c) Copyright 2008 Xilinx, Inc. All rights reserved.
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
---------------------------------------------------------------
-- This is the Behavioural model (aka 'pure RTL')
-- This model is not intended to be synthesized.
-- Its purpose is to verify the functionality of the other model(s)
-- It should be bit and cycle accurate.
-- The workings of this model need not take account of Xilinx primitives,
-- other than to match the behaviour of the other models. E.g
-- if the DSP48 and fabric variants of a core behave identically, the
-- behavioral model needs only one architecture and the C_USE_DSP48 generic
-- can be ignored.
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all; 
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all; 
use xilinxcorelib.bip_dsp48_multadd_pkg_v2_0.all;
use xilinxcorelib.xbip_pipe_v2_0_comp.all;

--core_if on entity xbip_dsp48_multadd_behv
entity xbip_dsp48_multadd_v2_0 is
  generic (
    C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    C_XDEVICEFAMILY   : string  := "virtex4";
    C_LATENCY         : integer := -1;
    C_USE_PCIN        : integer := 0;
    C_USE_ACIN        : integer := 0;
    C_USE_BCIN        : integer := 0
    );
  port (
    CLK          : in  std_logic                                                      := '1';
    CE           : in  std_logic                                                      := '1';
    SCLR         : in  std_logic                                                      := '0';
    SUBTRACT     : in  std_logic                                                      := '0';
    CARRYIN      : in  std_logic                                                      := '0';
    PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0');
    ACIN         : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    BCIN         : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
    A            : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    B            : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
    C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                  := (others => '0');
    ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
    CARRYOUT     : out std_logic                                                      := '0';
    PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0');
    P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0')
    );
end xbip_dsp48_multadd_v2_0;
--core_if off



architecture behavioral of xbip_dsp48_multadd_v2_0 is

  -- purpose: devolved checking of generics
--  function fn_local_check_generics (
--    p_model_type : integer)
--    return integer is
--  begin  -- local_check_generics
--    --C_MODEL_TYPE
--    assert p_model_type = 2
--      report "BEHV model has been called with C_MODEL_TYPE set to something other than BEHV"
--      severity ERROR;
--    return 0;                           --keeps modelsim happy.
--  end fn_local_check_generics;
--  constant c_local_check_generics : integer := fn_local_check_generics(C_MODEL_TYPE);
  
  constant dsp48_multadd_latency : t_dsp48_multadd_latency := fn_dsp48_multadd_latency(
    P_LATENCY       => C_LATENCY,
    P_XDEVICEFAMILY => C_XDEVICEFAMILY
    );
  constant ci_pipe : t_dsp48_multadd_pipe := dsp48_multadd_latency.pipe;

  signal asel          : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)            := (others => '0');
  signal bsel          : std_logic_vector(ci_dsp48_b_width-1 downto 0)                             := (others => '0');
  signal a0reg         : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)            := (others => '0');
  signal b0reg         : std_logic_vector(ci_dsp48_b_width-1 downto 0)                             := (others => '0');
  signal a0reg2        : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)            := (others => '0');
  signal b0reg2        : std_logic_vector(ci_dsp48_b_width-1 downto 0)                             := (others => '0');
  signal a1reg         : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)            := (others => '0');
  signal b1reg         : std_logic_vector(ci_dsp48_b_width-1 downto 0)                             := (others => '0');
  signal c_i           : std_logic_vector(ci_dsp48_c_width-1 downto 0)                             := (others => '0');
  signal carryin_sel   : std_logic := '0';
  signal carryin_i     : std_logic := '0';
  signal subtract_i    : std_logic                                                                 := '0';
  signal mult_result_i : std_logic_vector(fn_a_width(C_XDEVICEFAMILY)+ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal mult_result   : std_logic_vector(fn_a_width(C_XDEVICEFAMILY)+ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal mult_result_resized   : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  signal y_i           : std_logic_vector(ci_dsp48_p_width-1 downto 0)                             := (others => '0');
  signal p_i           : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                             := (others => '0');
  signal preg          : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                             := (others => '0');
  signal carryout_i    : std_logic := '0';
  signal carryoutreg   : std_logic := '0';
begin
  asel <= std_logic_vector(resize(signed(A),fn_dsp48_a_width(C_XDEVICEFAMILY)));

  i_areg1 : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage1),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => fn_dsp48_a_width(C_XDEVICEFAMILY)
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => asel,
      Q     => a0reg
      );

  i_vx5_acasc: if supports_dsp48e(C_XDEVICEFAMILY)>0 generate
    i_a: if C_USE_ACIN = 0 generate
      a0reg2 <= a0reg;
    end generate i_a;
    i_acin: if C_USE_ACIN = 1 generate
      a0reg2 <= ACIN;
    end generate i_acin;
  end generate i_vx5_acasc;
  i_non_vx5_acasc: if not(supports_dsp48e(C_XDEVICEFAMILY)>0) generate
    a0reg2 <= a0reg;
  end generate i_non_vx5_acasc;

  i_areg2 : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage2),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => fn_dsp48_a_width(C_XDEVICEFAMILY)
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => a0reg2,
      Q     => a1reg
      );

  i_acout: if supports_dsp48e(C_XDEVICEFAMILY)>0 generate
    ACOUT <= a1reg;
  end generate i_acout;

  i_sp3adsp_bcasc: if supports_dsp48a(C_XDEVICEFAMILY)>0 generate
    i_b: if C_USE_BCIN = 0 generate
      bsel <= B;
    end generate i_b;
    i_bcin: if C_USE_BCIN = 1 generate
      bsel <= BCIN;
    end generate i_bcin;
  end generate i_sp3adsp_bcasc;
  i_vx4_vx5_bcasc: if has_dsp48(C_XDEVICEFAMILY) or supports_dsp48e(C_XDEVICEFAMILY)>0 generate
    bsel <= B;
  end generate i_vx4_vx5_bcasc;
  
  i_breg1 : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage1),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_b_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => bsel,
      Q     => b0reg
      );

  --second part of the BCASC kludge.
  i_sp3adsp_bcasc2: if supports_dsp48a(C_XDEVICEFAMILY)>0 generate
    b0reg2 <= b0reg;
  end generate i_sp3adsp_bcasc2;
  i_vx4_vx5_bcasc2: if has_dsp48(C_XDEVICEFAMILY) or supports_dsp48e(C_XDEVICEFAMILY)>0 generate
    i_b: if C_USE_BCIN = 0 generate
      b0reg2 <= b0reg;
    end generate i_b;
    i_bcin: if C_USE_BCIN = 1 generate
      b0reg2 <= BCIN;
    end generate i_bcin;
  end generate i_vx4_vx5_bcasc2;

  i_breg2 : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage2),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_b_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => b0reg2,
      Q     => b1reg
      );
  BCOUT <= b1reg;
  
  i_c : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_c_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => c,
      Q     => c_i
      );
  
  i_sub : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => 1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D(0)  => SUBTRACT,
      Q(0)  => subtract_i
      );
  
  carryin_sel <= CARRYIN;

  i_carryinreg : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => 1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D(0)  => carryin_sel,
      Q(0)  => carryin_i
      );
  
  mult_result_i <= a1reg(fn_a_width(C_XDEVICEFAMILY)-1 downto 0) * b1reg;
  i_m : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => fn_a_width(C_XDEVICEFAMILY)+ci_dsp48_b_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => mult_result_i,
      Q     => mult_result
      );
  mult_result_resized <= std_logic_vector(resize(signed(mult_result),ci_dsp48_p_width));
  
  i_usec: if C_USE_PCIN = 0 generate
    y_i <= c_i;
  end generate i_usec;
  i_usepcin: if C_USE_PCIN = 1 generate
    y_i <= PCIN;
  end generate i_usepcin; 
  p_i <= ('0'&y_i) + ('0'&mult_result_resized + carryin_i) when subtract_i = '0' else
         ('0'&y_i) - ('0'&mult_result_resized + carryin_i);
  carryout_i <= p_i(p_i'left) xor subtract_i;
  
  i_carryoutreg : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage4),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => 1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D(0)  => carryout_i,
      Q(0)  => carryoutreg
      );
  i_p : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage4),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_p_width+1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => p_i,
      Q     => preg
      );
  
--    CARRYOUT     <= carryoutreg; --Vx5 drives Cout with X when the mult is used.

  P     <= preg(ci_dsp48_p_width-1 downto 0);
  PCOUT <= preg(ci_dsp48_p_width-1 downto 0);
end behavioral;
