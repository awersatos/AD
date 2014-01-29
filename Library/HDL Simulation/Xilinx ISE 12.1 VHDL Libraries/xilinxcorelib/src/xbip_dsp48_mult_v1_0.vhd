-- $Id: xbip_dsp48_mult_v1_0.vhd,v 1.3 2008/09/10 09:50:41 akennedy Exp $
-------------------------------------------------------------------------------
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.
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
use xilinxcorelib.bip_utils_pkg_v1_0.all; 
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;
use xilinxcorelib.xbip_pipe_v1_0_comp.all;
use xilinxcorelib.bip_dsp48_mult_pkg_v1_0.all;   

--core_if on entity xbip_dsp48_mult_v1_0
  entity xbip_dsp48_mult_v1_0 is
    GENERIC (
      C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := -1;
      C_USE_PCIN      : integer := 0;
      C_USE_ACIN      : integer := 0;
      C_USE_BCIN      : integer := 0
      );
    PORT (
      CLK      : in  std_logic                                                      := '1';
      CE       : in  std_logic                                                      := '1';
      SCLR     : in  std_logic                                                      := '0';
      SUBTRACT : in  std_logic                                                      := '0';
      CARRYIN  : in  std_logic                                                      := '0';
      PCIN     : in  std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0');
      ACIN     : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
      BCIN     : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
      A        : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
      B        : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
-- <!--Aldec correction start
      C        : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                  := (others => '0');
-- Aldec correction end -->
      ACOUT    : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
      BCOUT    : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
      PCOUT    : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0');
      P        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0')
      );
--core_if off
  end entity xbip_dsp48_mult_v1_0;


architecture behavioral of xbip_dsp48_mult_v1_0 is
  -- purpose: devolved checking of generics
  function fn_local_check_generics (
    P_XDEVICEFAMILY : string;
    P_USE_PCIN : integer;
    p_model_type : integer)
    return integer is
  begin  -- local_check_generics
    --C_MODEL_TYPE
    assert p_model_type = 1
      report "RTL model has been called with C_MODEL_TYPE set to something other than RTL"
      severity ERROR;
    
    assert not(has_dsp48a(P_XDEVICEFAMILY) and P_USE_PCIN=1)
      report "ERROR: bip_dsp48_mult_rtl: spartan3adsp mult cannot accept shiftP input"
      severity error;
    return 0;                           --keeps modelsim happy.
  end fn_local_check_generics;
  constant c_local_check_generics : integer := fn_local_check_generics(
    p_xdevicefamily => C_XDEVICEFAMILY,
    p_use_pcin      => C_USE_PCIN,
    p_model_type    => C_MODEL_TYPE);
  
  constant dsp48_mult_latency : t_dsp48_mult_latency := fn_dsp48_mult_latency(
    P_LATENCY       => C_LATENCY,
    P_XDEVICEFAMILY => C_XDEVICEFAMILY
    );
  constant ci_pipe : t_dsp48_mult_pipe := dsp48_mult_latency.pipe;
  
  -- signals section
  signal carryin_i    : std_logic := '0';
  signal carryinreg   : std_logic := '0';
  signal a_i         : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)    := (others => '0');
  signal b_i         : std_logic_vector(ci_dsp48_b_width-1 downto 0)               := (others => '0');
  signal a0reg       : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)    := (others => '0');
  signal a0reg2      : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)    := (others => '0');
  signal b0reg       : std_logic_vector(ci_dsp48_b_width-1 downto 0)               := (others => '0');
  signal b0reg2      : std_logic_vector(ci_dsp48_b_width-1 downto 0)               := (others => '0');
  signal a1reg       : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)    := (others => '0');
  signal b1reg       : std_logic_vector(ci_dsp48_b_width-1 downto 0)               := (others => '0');
  signal mult_result : std_logic_vector(fn_dsp48_amult_width(C_XDEVICEFAMILY)+ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal mult_result_reg : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  signal mult_result_resized   : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  signal creg        : std_logic_vector(ci_dsp48_c_width-1 downto 0)               := (others => '0');
  signal subtractreg : std_logic                                                   := '0';
  signal y_i         : std_logic_vector(ci_dsp48_p_width-1 downto 0)               := (others => '0');
  signal p_i         : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)               := (others => '0');
  signal preg        : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)               := (others => '0');

begin
   --A and B port routing is horrible. In Spartan3, cascaded units are 2 reg opportunities skewed.
  --In Vx4/Vx5, only one stage skews, so the Bcasc has to skip stage1 and enter
  --at stage 2.

  --A port
  a_i <= std_logic_vector(resize(signed(A),fn_dsp48_a_width(C_XDEVICEFAMILY)));

  i_areg1 : xbip_pipe_v1_0
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
      D     => a_i,
      Q     => a0reg
      );

  i_vx5_acasc: if has_dsp48e(C_XDEVICEFAMILY) generate
    i_a: if C_USE_ACIN = 0 generate
      a0reg2 <= a0reg;
    end generate i_a;
    i_acin: if C_USE_ACIN = 1 generate
      a0reg2 <= ACIN;
    end generate i_acin;
  end generate i_vx5_acasc;
  i_non_vx5_acasc: if not(has_dsp48e(C_XDEVICEFAMILY)) generate
    a0reg2 <= a0reg;
  end generate i_non_vx5_acasc;

  i_areg2 : xbip_pipe_v1_0
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
  
  --A cascade is vx5 only...
  i_acout: if has_dsp48e(C_XDEVICEFAMILY) generate
    ACOUT <= a1reg;
  end generate i_acout;

  --B port
  i_sp3adsp_bcasc: if has_dsp48a(C_XDEVICEFAMILY) generate
    i_b: if C_USE_BCIN = 0 generate
      b_i <= B;
    end generate i_b;
    i_bcin: if C_USE_BCIN = 1 generate
      b_i <= BCIN;
    end generate i_bcin;
  end generate i_sp3adsp_bcasc;
  i_vx4_vx5_bcasc: if has_dsp48(C_XDEVICEFAMILY) or has_dsp48e(C_XDEVICEFAMILY) generate
    b_i <= B;
  end generate i_vx4_vx5_bcasc;

  i_breg1 : xbip_pipe_v1_0
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
      D     => b_i,
      Q     => b0reg
      );

  i_sp3adsp_bcasc2: if has_dsp48a(C_XDEVICEFAMILY) generate
    b0reg2 <= b0reg;
  end generate i_sp3adsp_bcasc2;
  i_vx4_vx5_bcasc2: if has_dsp48(C_XDEVICEFAMILY) or has_dsp48e(C_XDEVICEFAMILY) generate
    i_b: if C_USE_BCIN = 0 generate
      b0reg2 <= b0reg;
    end generate i_b;
    i_bcin: if C_USE_BCIN = 1 generate
      b0reg2 <= BCIN;
    end generate i_bcin;
  end generate i_vx4_vx5_bcasc2;

  i_breg2 : xbip_pipe_v1_0
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

  --...but b cascade is fun for all the families.
  BCOUT <= b1reg;
 
  carryin_i <= CARRYIN;
  
  mult_result <= a1reg(fn_dsp48_amult_width(C_XDEVICEFAMILY)-1 downto 0)*b1reg;
  mult_result_resized <= std_logic_vector(resize(signed(mult_result),ci_dsp48_p_width));
  
  --stage3 regs
  i_mreg : xbip_pipe_v1_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_p_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => mult_result_resized,
      Q     => mult_result_reg
      );
  i_cinreg : xbip_pipe_v1_0
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
      D(0)  => carryin_i,
      Q(0)  => carryinreg
      );
  i_subreg : xbip_pipe_v1_0
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
      Q(0)  => subtractreg
      );

  --adder operation (addition of partial products from below)
  i_usepcin: if C_USE_PCIN = 1 generate
    y_i <= std_logic_vector(resize(signed(PCIN(ci_dsp48_c_width-1 downto ci_dsp48_b_width-1)),ci_dsp48_p_width)) ;
  end generate i_usepcin; 

  p_i <= ('0'&y_i) + (('0'&mult_result_reg) + carryinreg) when subtractreg = '0' else
         ('0'&y_i) - (('0'&mult_result_reg) + carryinreg);

  --stage4 regs
  i_preg : xbip_pipe_v1_0
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

  P     <= preg(ci_dsp48_p_width-1 downto 0);
  PCOUT <= preg(ci_dsp48_p_width-1 downto 0);



end behavioral;
