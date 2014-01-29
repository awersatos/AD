-- $Header: /devl/xcs/repo/env/Databases/ip/src2/K/xbip_dsp48_multacc_v1_0/simulation/xbip_dsp48_multacc_v1_0.vhd,v 1.4 2008/09/10 09:50:38 akennedy Exp $
--
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
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all; 
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all; 
use xilinxcorelib.bip_dsp48_multacc_pkg_v1_0.all;   
use xilinxcorelib.xbip_pipe_v1_0_comp.all;

--core_if on entity bip_dsp48_multacc_v1_0
entity xbip_dsp48_multacc_v1_0 is
  generic (
    C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    C_XDEVICEFAMILY   : string  := "virtex4";
    C_LATENCY         : integer := -1;
    C_USE_ACIN        : integer := 0;
    C_USE_BCIN        : integer := 0;
    C_USE_PCIN        : integer := 0
    );
  port (
    CLK          : in  std_logic                                                          := '1';
    CE           : in  std_logic                                                          := '1';
    SCLR         : in  std_logic                                                          := '0';
    CARRYIN      : in  std_logic                                                          := '0';
    A            : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    B            : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                      := (others => '0');
    C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                      := (others => '0');
    ACIN         : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)     := (others => '0');
    BCIN         : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                      := (others => '0');
    PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0');
    LOAD         : in  std_logic                                                          := '0';
    SUBTRACT     : in  std_logic                                                          := '0';
    CARRYOUT     : out std_logic                                                          := '0';
    CARRYCASCOUT : out std_logic                                                          := '0';
    MULTSIGNOUT  : out std_logic := '0';
    PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0');
    ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)     := (others => '0');
    BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                      := (others => '0');
    P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0')
    );
end xbip_dsp48_multacc_v1_0;
--core_if off



architecture behavioral of xbip_dsp48_multacc_v1_0 is

--  -- purpose: devolved checking of generics
--  function fn_local_check_generics (
--    p_model_type : integer)
--    return integer is
--  begin  -- local_check_generics
--    --C_MODEL_TYPE
--    assert p_model_type = 2
--      report "ERROR: xbip_dsp48_multacc_behv: BEHV model has been called with C_MODEL_TYPE set to something other than BEHV"
--      severity ERROR;
--    return 0;                           --keeps modelsim happy.
--  end fn_local_check_generics;
--  constant c_local_check_generics : integer := fn_local_check_generics(C_MODEL_TYPE);
  
  
  constant dsp48_multacc_latency : t_dsp48_multacc_latency := fn_dsp48_multacc_latency(
    P_LATENCY       => C_LATENCY,
    P_XDEVICEFAMILY => C_XDEVICEFAMILY
    );
  constant ci_pipe : t_dsp48_multacc_pipe := dsp48_multacc_latency.pipe;

  signal asel       : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)                  := (others => '0');
  signal bsel       : std_logic_vector(ci_dsp48_b_width-1 downto 0)                                       := (others => '0');
  signal a_i        : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)                  := (others => '0');
  signal b_i        : std_logic_vector(ci_dsp48_b_width-1 downto 0)                                       := (others => '0');
  signal c_i        : std_logic_vector(ci_dsp48_c_width-1 downto 0)                                       := (others => '0');
  signal load_i     : std_logic                                                                           := '0';
  signal subtract_i : std_logic                                                                           := '0';
  signal carryin_i  : std_logic                                                                           := '0';
  signal m_i        : std_logic_vector(fn_dsp48_amult_width(C_XDEVICEFAMILY)+ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal mult_result_resized_tmp : std_logic_vector(m_i'range) := (others => '0');
  signal mult_result_resized : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  signal z_i        : std_logic_vector(ci_dsp48_p_width-1 downto 0)                                       := (others => '0');
  signal p_i        : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                                       := (others => '0');
  signal preg       : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                                       := (others => '0');
  signal carryout_i  : std_logic := '0';
  signal carryoutreg : std_logic := '0';
begin
  --select A source
  i_a: if C_USE_ACIN = 0 generate
    asel <= A;
  end generate i_a;
  i_acin: if C_USE_ACIN = 1 generate
    asel <= ACIN;
  end generate i_acin;

  --select B source
  i_b: if C_USE_BCIN = 0 generate
    bsel <= B;
  end generate i_b;
  i_bcin: if C_USE_BCIN = 1 generate
    bsel <= BCIN;
  end generate i_bcin;

  i_areg : xbip_pipe_v1_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage1)+ci_pipe(ci_stage2),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => fn_dsp48_a_width(C_XDEVICEFAMILY)
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => asel,
      Q     => a_i
      );

  i_breg : xbip_pipe_v1_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage1)+ci_pipe(ci_stage2),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_b_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => bsel,
      Q     => b_i
      );

  i_creg : xbip_pipe_v1_0
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
      D     => C,
      Q     => c_i
      );

  i_loadreg : xbip_pipe_v1_0
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
      D(0)  => LOAD,
      Q(0)  => load_i
      );

  i_subtractreg : xbip_pipe_v1_0
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

  i_carryinreg : xbip_pipe_v1_0
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
      D(0)  => CARRYIN,
      Q(0)  => carryin_i
      );

  --tap off CASCADE outputs for A and B
  i_acout: if has_dsp48e(C_XDEVICEFAMILY) generate
    ACOUT <= a_i;
  end generate i_acout;

  BCOUT <= b_i;

  --perform the operation!
  m_i <= a_i(fn_dsp48_amult_width(C_XDEVICEFAMILY)-1 downto 0) * b_i;

  i_mreg : xbip_pipe_v1_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => m_i'length
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => m_i,
      Q     => mult_result_resized_tmp
      );  

  mult_result_resized <= std_logic_vector(resize(signed(mult_result_resized_tmp),ci_dsp48_p_width));
  
  i_usec: if C_USE_PCIN = 0 generate
    z_i <= c_i when load_i = '1' else preg(ci_dsp48_p_width-1 downto 0);
  end generate i_usec;
  i_usepcin: if C_USE_PCIN = 1 generate
    z_i <= PCIN when load_i = '1' else preg(ci_dsp48_p_width-1 downto 0);
  end generate i_usepcin; 
  p_i <= ('0'&z_i) + (('0'&mult_result_resized) + carryin_i) when subtract_i = '0' else
         ('0'&z_i) - (('0'&mult_result_resized) + carryin_i);

  i_p : xbip_pipe_v1_0
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

  i_sp3adsp: if has_DSP48a(C_XDEVICEFAMILY) generate
    CARRYCASCOUT <= p_i(p_i'LEFT);
  end generate i_sp3adsp;
  i_vx5: if has_dsp48e(C_XDEVICEFAMILY) generate
    CARRYCASCOUT <= preg(preg'LEFT);

    -- Delay multsignout to match the P register
    i_msignout : xbip_pipe_v1_0
      generic map(
        C_LATENCY  => ci_pipe(ci_stage4),
        C_HAS_CE   => 1,
        C_HAS_SCLR => 1,
        C_WIDTH    => 1)
      port map(
        CLK  => CLK,
        CE   => CE,
        SCLR => SCLR,
        D(0)    => mult_result_resized(mult_result_resized'left),
        Q(0)    => MULTSIGNOUT);
    
--    CARRYOUT     <= carryoutreg; --Vx5 drives Cout with X when the mult is used.
  end generate i_vx5;

  P     <= preg(ci_dsp48_p_width-1 downto 0);
  PCOUT <= preg(ci_dsp48_p_width-1 downto 0);
end behavioral;
