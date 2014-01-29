-- $Header: /devl/xcs/repo/env/Databases/ip/src2/K/xbip_dsp48_addsub_v1_0/simulation/xbip_dsp48_addsub_v1_0.vhd,v 1.4 2008/09/10 09:49:37 akennedy Exp $
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
-- if the DSP48 and fabric variants of a core behave ident ically, the
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
use xilinxcorelib.bip_dsp48_addsub_pkg_v1_0.all;

--core_if on entity bip_dsp48_addsub_behv
entity xbip_dsp48_addsub_v1_0 is
  generic (
    C_VERBOSITY       : integer := 0;  -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE      : integer := 0;   -- 0 = synth, 1 = RTL
    C_XDEVICEFAMILY   : string  := "virtex4";
    C_LATENCY         : integer := -1;
    C_USE_CARRYCASCIN : integer := 0;
    C_USE_PCIN        : integer := 0;
    C_USE_ACIN        : integer := 0;
    C_USE_BCIN        : integer := 0
    );
  port (
    CLK          : in  std_logic                                                           := '1';
    CE           : in  std_logic                                                           := '1';
    SCLR         : in  std_logic                                                           := '0';
    SUBTRACT     : in  std_logic                                                           := '0';
    BYPASS       : in  std_logic                                                           := '0';
    CARRYIN      : in  std_logic                                                           := '0';
    CARRYCASCIN  : in  std_logic                                                           := '0';
    PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
    ACIN         : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)      := (others => '0');
    BCIN         : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                       := (others => '0');
    ABCONCAT     : in  std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                       := (others => '0');
    PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
    ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)      := (others => '0');
    BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                       := (others => '0');
    CARRYOUT     : out std_logic                                                           := '0';
    CARRYCASCOUT : out std_logic                                                           := '0';
    P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0')
    );
end xbip_dsp48_addsub_v1_0;
--core_if off


architecture synth of xbip_dsp48_addsub_v1_0 is

--   -- purpose: devolved checking of generics
--   function fn_local_check_generics (
--     p_model_type : integer)
--     return integer is
--   begin  -- local_check_generics
--     --C_MODEL_TYPE
--     assert p_model_type = 2
--       report "ERROR: xbip_dsp48_addsub_behv: BEHV model has been called with C_MODEL_TYPE set to something other than BEHV"
--       severity error;
--     return 0;                           --keeps modelsim happy.
--   end fn_local_check_generics;
--   constant c_local_check_generics : integer := fn_local_check_generics(C_MODEL_TYPE);
  
  constant dsp48_addsub_latency : t_dsp48_addsub_latency := fn_dsp48_addsub_latency(
    P_LATENCY       => C_LATENCY,
    P_XDEVICEFAMILY => C_XDEVICEFAMILY
    );
  constant ci_pipe : t_dsp48_addsub_pipe := dsp48_addsub_latency.pipe;

  signal asel          : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)                                                         := (others => '0');
  signal bsel          : std_logic_vector(ci_dsp48_b_width-1 downto 0)                                                                          := (others => '0');
  signal a_i           : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)                                                         := (others => '0');
  signal b_i           : std_logic_vector(ci_dsp48_b_width-1 downto 0)                                                                          := (others => '0');
  signal c_i           : std_logic_vector(ci_dsp48_c_width-1 downto 0)                                                                          := (others => '0');
  signal d_i           : std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-fn_dsp48_a_width(C_XDEVICEFAMILY)-ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal carryin_i     : std_logic                                                                                                              := '0';
  signal carryin_sel   : std_logic                                                                                                              := '0';
  signal carryin_i_mux : std_logic                                                                                                              := '0';
  signal subtract_i    : std_logic                                                                                                              := '0';
  signal bypass_i      : std_logic                                                                                                              := '0';
  signal dab_in        : std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0)                                                    := (others => '0');
  signal dab_i         : std_logic_vector(ci_dsp48_p_width-1 downto 0)                                                                          := (others => '0');
  signal x_i           : std_logic_vector(ci_dsp48_p_width-1 downto 0)                                                                          := (others => '0');
  signal z_i           : std_logic_vector(ci_dsp48_p_width-1 downto 0)                                                                          := (others => '0');
  signal p_i           : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                                                                        := (others => '0');
  signal preg          : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                                                                        := (others => '0');
  signal carryout_i    : std_logic                                                                                                              := '0';
  signal carryoutreg   : std_logic                                                                                                              := '0';

  constant add    : std_logic := '1';
  signal opmode_i : std_logic := '0';
  
begin
  --select A source
  i_a : if C_USE_ACIN = 0 generate
    asel <= ABCONCAT(fn_dsp48_a_width(C_XDEVICEFAMILY)+ci_dsp48_b_width-1 downto ci_dsp48_b_width);
  end generate i_a;
  i_acin : if C_USE_ACIN = 1 generate
    asel <= ACIN;
  end generate i_acin;

  --select B source
  i_b : if C_USE_BCIN = 0 generate
    bsel <= ABCONCAT(ci_dsp48_b_width-1 downto 0);
  end generate i_b;
  i_bcin : if C_USE_BCIN = 1 generate
    bsel <= BCIN;
  end generate i_bcin;

  --select CARRYIN source
  i_carryin : if C_USE_CARRYCASCIN = 0 generate
    carryin_sel <= CARRYIN;
  end generate i_carryin;
  i_carrycascin : if C_USE_CARRYCASCIN = 1 generate
    carryin_sel <= CARRYCASCIN;
  end generate i_carrycascin;

  i_areg : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage3),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => fn_dsp48_a_width(C_XDEVICEFAMILY)
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D    => asel,
      Q    => a_i
      );

  i_breg : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage3),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => ci_dsp48_b_width
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D    => bsel,
      Q    => b_i
      );

  i_d : if has_dsp48a(C_XDEVICEFAMILY) generate
    i_dreg : xbip_pipe_v1_0
      generic map(
        C_LATENCY  => ci_pipe(ci_stage3),
        C_HAS_CE   => 1,
        C_HAS_SCLR => 1,
        C_WIDTH    => fn_dsp48_concat_width(C_XDEVICEFAMILY)-fn_dsp48_a_width(C_XDEVICEFAMILY)-ci_dsp48_b_width
        )
      port map(
        CLK  => CLK,
        CE   => CE,
        SCLR => SCLR,
        D    => ABCONCAT(ABCONCAT'left downto fn_dsp48_a_width(C_XDEVICEFAMILY)+ci_dsp48_b_width),
        Q    => d_i
        );
  end generate i_d;

  i_c : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage3),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => ci_dsp48_c_width
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D    => c,
      Q    => c_i
      );

  i_sub : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage3),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D(0) => SUBTRACT,
      Q(0) => subtract_i
      );

  i_bypass : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage3),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D(0) => BYPASS,
      Q(0) => bypass_i
      );

  -- the carry-in is only registered if it's not a cascade carry-in
  --bugfix note: sp3 does have a register here, but has been shifted to the output
  --which means the primitive and model differ, but only for cascade. When
  --cascaded, there is the right number of registers in total, so all is ok.
  i_carryinreg : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage3)*boolean'pos(C_USE_CARRYCASCIN = 0 or has_dsp48a(C_XDEVICEFAMILY) = true),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D(0) => carryin_sel,
      Q(0) => carryin_i
      );

  i_opmode : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage3),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D(0) => ADD,
      Q(0) => opmode_i
      );

  --NOTE: there is no second stage register

  --tap off CASCADE outputs for A and B
  i_acout : if has_dsp48e(C_XDEVICEFAMILY) generate
    ACOUT <= a_i;
  end generate i_acout;

  BCOUT <= b_i;

  --Why start with concatenation, split then reconcantenate? Well, there's
  --ACIN, BCIN, ACOUT and BCOUT to complicate matters.
  concat_sp3 : if has_dsp48a(C_XDEVICEFAMILY) generate
    dab_in <= d_i(11 downto 0) & a_i & b_i;
  end generate concat_sp3;
  concat_vx : if has_dsp48(C_XDEVICEFAMILY) or has_dsp48e(C_XDEVICEFAMILY) generate
    dab_in(fn_dsp48_a_width(C_XDEVICEFAMILY)+ci_dsp48_b_width-1 downto 0) <= a_i & b_i;
  end generate concat_vx;
  dab_i <= std_logic_vector(resize(signed(dab_in), ci_dsp48_p_width));

  -- When the opmode register is reset (opmode_i /= add), the Xmux is set to all-zeros
  x_i <= dab_i when opmode_i = add else (others => '0');

  -- When the opmode register is reset (opmode_i /= add), the Zmux is set to all-zeros
  i_usec : if C_USE_PCIN = 0 generate
    z_i <= c_i when bypass_i = '0' and opmode_i = add else (others => '0');
  end generate i_usec;
  i_usepcin : if C_USE_PCIN = 1 generate
    z_i <= PCIN when bypass_i = '0' and opmode_i = add else (others => '0');
  end generate i_usepcin;

  no_carrycascin_mux : if C_USE_CARRYCASCIN = 0 or not(has_dsp48e(C_XDEVICEFAMILY)) generate
    carryin_i_mux <= carryin_i;
  end generate no_carrycascin_mux;
  use_carrycascin_mux : if C_USE_CARRYCASCIN = 1 and has_dsp48e(C_XDEVICEFAMILY) generate
    -- DRC checks stipulate that CARRYINSELREG should be ganged with OPMODEREG
    -- We make this assumption here.  When using CARRYCASCIN, carryinsel will be
    -- reset on an SCLR to '000', which means that the fabric carryin value
    -- will be passed to the adder.  So also assume that this will be tied to '0'
    -- since it should be unused if we are already using carrycascin.
    carryin_i_mux <= carryin_i when opmode_i = add else '0';
  end generate use_carrycascin_mux;

  --Perform the operation!
  p_i <= ('0'&z_i) + (('0'&x_i) + carryin_i_mux) when subtract_i = '0' else
         ('0'&z_i) - (('0'&x_i) + carryin_i_mux);
  
  carryout_i <= p_i(p_i'left) xor subtract_i;

  i_p : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage4),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => ci_dsp48_p_width+1  --includes CARRYOUT proto-signal
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D    => p_i,
      Q    => preg
      );
  i_carryout : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => ci_pipe(ci_stage4),
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR,
      D(0) => carryout_i,
      Q(0) => carryoutreg
      );


  i_sp3adsp_carryout : if has_dsp48a(C_XDEVICEFAMILY) generate
    --bugfix note: spartan3adsp actually has this register on the input to
    --carrycascin, but moving it here doesn't matter since when cascaded the total
    --number of registers is correct.
    --    CARRYCASCOUT <= p_i(p_i'left);
--    CARRYCASCOUT <= preg(preg'left);
    CARRYCASCOUT <= carryout_i;
  end generate i_sp3adsp_carryout;
  --Only Vx5 has fabric carryout
  i_vx5_carryout : if has_dsp48e(C_XDEVICEFAMILY) generate
    CARRYCASCOUT <= preg(preg'left);
    CARRYOUT     <= carryoutreg;
  end generate i_vx5_carryout;
  P     <= preg(ci_dsp48_p_width-1 downto 0);
  PCOUT <= preg(ci_dsp48_p_width-1 downto 0);
end synth;
