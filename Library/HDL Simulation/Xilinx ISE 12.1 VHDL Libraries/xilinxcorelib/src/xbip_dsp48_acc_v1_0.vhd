
-- $Id: xbip_dsp48_acc_v1_0.vhd,v 1.4 2008/09/10 09:46:18 akennedy Exp $
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.
--
-------------------------------------------------------------------------------
-- Behavioural Model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

LIBRARY XilinxCoreLib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;
use xilinxcorelib.xbip_pipe_v1_0_comp.all;
use xilinxcorelib.bip_dsp48_acc_pkg_v1_0.all;


-- (A)synchronous multi-input gate
--
--core_if on entity xbip_dsp48_acc_v1_0
  entity xbip_dsp48_acc_v1_0 is
  GENERIC (
    --BaseIP modelling generics
    C_VERBOSITY       : integer := 0;  --0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE      : integer := 0;   --0 = synth, 1 = RTL
    --BaseIP common generics
    C_XDEVICEFAMILY   : string  := "virtex4";
    C_LATENCY         : integer := -1;
    --DSP special inputs
    C_HAS_SUBTRACT    : integer := 1;   --see check generics for explanation
    C_USE_PCIN        : integer := 0;
    C_USE_CARRYCASCIN : integer := 0
    );
  PORT (
    CLK          : in  std_logic                                     := '1';
    CE           : in  std_logic                                     := '1';
    SCLR         : in  std_logic                                     := '0';
    CARRYIN      : in  std_logic                                     := '0';
    CARRYCASCIN  : in  std_logic                                     := '0';
    ACC_NLOAD    : in  std_logic                                     := '0';
    SUBTRACT     : in  std_logic                                     := '0';
    C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
    PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
    CARRYOUT     : out std_logic                                     := '0';
    CARRYCASCOUT : out std_logic                                     := '0';
    PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
    P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0')
    );
--core_if off
END xbip_dsp48_acc_v1_0;


ARCHITECTURE behavioral OF xbip_dsp48_acc_v1_0 IS
--  -- purpose: devolved checking of generics
--  function fn_local_check_generics (
--    p_model_type : integer)
--    return integer is
--  begin  -- local_check_generics
--    --C_MODEL_TYPE
--    assert p_model_type = 2
--      report "ERROR: xbip_dsp48_acc_behv: BEHV model has been called with C_MODEL_TYPE set to something other than BEHV"
--      severity ERROR;
--    return 0;                           --keeps modelsim happy.
--  end fn_local_check_generics;
--  constant c_local_check_generics : integer := fn_local_check_generics(C_MODEL_TYPE);
  
  
  constant dsp48_acc_latency : t_dsp48_acc_latency := fn_dsp48_acc_latency(
    P_LATENCY       => C_LATENCY,
    P_XDEVICEFAMILY => C_XDEVICEFAMILY
    );
  constant ci_pipe : t_dsp48_acc_pipe := dsp48_acc_latency.pipe;

  signal carryin_i    : std_logic := '0';
  signal carryinreg   : std_logic := '0';
  signal subtract_i   : std_logic := '0';
  signal subtractreg  : std_logic := '0';
  signal acc_nloadreg : std_logic := '0';
  signal creg         : std_logic_vector(ci_dsp48_c_width-1 downto 0)                     := (others => '0');
  signal y_i          : std_logic_vector(ci_dsp48_p_width-1 downto 0)                     := (others => '0');
  signal z_i          : std_logic_vector(ci_dsp48_p_width-1 downto 0)                     := (others => '0');
  signal p_i          : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                     := (others => '0');
  signal preg         : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                       := (others => '0');
  signal carryout_i   : std_logic := '0';
  signal carryoutreg  : std_logic := '0';
begin
  i_sub: if C_HAS_SUBTRACT = 1 generate
    subtract_i <= SUBTRACT;
  end generate i_sub;
  i_carryin: if C_USE_CARRYCASCIN = 0 generate
    carryin_i <= CARRYIN;
  end generate i_carryin;
  i_carrycascin: if C_USE_CARRYCASCIN = 1 generate
    carryin_i <= CARRYCASCIN;
  end generate i_carrycascin;
  
  has_carryinreg : if C_USE_CARRYCASCIN = 0  or has_DSP48a(C_XDEVICEFAMILY) generate
    i_carryreg : xbip_pipe_v1_0
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
  end generate has_carryinreg;
  no_carryinreg : if C_USE_CARRYCASCIN = 1 and not(has_DSP48a(C_XDEVICEFAMILY)) generate
    carryinreg <= carryin_i;
  end generate no_carryinreg;


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
      D(0)  => subtract_i,
      Q(0)  => subtractreg
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
      D(0)  => ACC_NLOAD,
      Q(0)  => acc_nloadreg
      );
  
  i_c : xbip_pipe_v1_0
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
      Q     => creg
      );

  i_usec: if C_USE_PCIN = 0 generate
    y_i <= creg;
  end generate i_usec;
  i_usepcin: if C_USE_PCIN = 1 generate
    y_i <= PCIN;
  end generate i_usepcin; 
  z_i <= preg(ci_dsp48_p_width-1 downto 0) when acc_nloadreg = '1' else
         (others => '0');
  --could create a ymux output to simplify the following equation
  --y = preg when acc_nload = 1, 0 when acc_nload = 0
  --p_i = z_i + y_i when subtract = 0 else z_i - y_i;
  --perform the operation!
  
  p_i <= ('0'&z_i) + (('0'&y_i) + carryinreg) when subtractreg = '0' else
         ('0'&z_i) - (('0'&y_i) + carryinreg);
  carryout_i <= p_i(p_i'LEFT) xor subtractreg;

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
  
  i_carryout : xbip_pipe_v1_0
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

  i_sp3adsp: if has_DSP48a(C_XDEVICEFAMILY) generate
    CARRYCASCOUT <= p_i(p_i'LEFT);
  end generate i_sp3adsp;
  i_vx5: if has_dsp48e(C_XDEVICEFAMILY) generate
    CARRYCASCOUT <= preg(preg'LEFT);
    CARRYOUT     <= carryoutreg;
  end generate i_vx5;
  P     <= preg(ci_dsp48_p_width-1 downto 0);
  PCOUT <= preg(ci_dsp48_p_width-1 downto 0);
  
END behavioral;

