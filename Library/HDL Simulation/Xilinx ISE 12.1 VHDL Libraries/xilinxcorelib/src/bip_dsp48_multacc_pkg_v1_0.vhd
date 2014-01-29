-- $Header: /devl/xcs/repo/env/Databases/ip/src2/K/xbip_dsp48_multacc_v1_0/simulation/bip_dsp48_multacc_pkg_v1_0.vhd,v 1.4 2008/09/10 09:50:38 akennedy Exp $
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
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.conv_std_logic_vector;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;

-------------------------------------------------------------------------------
-- Designer note!!
-- This file is for the top level component declaration and any types and functions
-- which calling cores may require. Internal functions, types and component declarations
-- should be in the dsp48_multacc_hdl_pkg file.
-------------------------------------------------------------------------------

package bip_dsp48_multacc_pkg_v1_0 is

  constant ci_max_latency       : integer := 4;
  type t_dsp48_multacc_pipe is array (0 to ci_max_latency) of integer;
  type t_dsp48_multacc_latency is record
                                 used : integer;
                                 pipe : t_dsp48_multacc_pipe;
                               end record;

  constant ci_stage1 : integer := 1;
  constant ci_stage2 : integer := 2;
  constant ci_stage3 : integer := 3;
  constant ci_stage4 : integer := 4;
  
  function fn_dsp48_multacc_check_generics (
    P_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    P_XDEVICEFAMILY   : string  := "virtex4";
    P_LATENCY         : integer := 1;
    P_USE_ACIN        : integer := 0;
    P_USE_BCIN        : integer := 0;
    P_USE_PCIN        : integer := 0
    ) return integer;
  
  function fn_dsp48_multacc_latency (
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string)
    return t_dsp48_multacc_latency;

  --core_if on component bip_dsp48_multacc_synth
  component bip_dsp48_multacc_synth
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
      MULTSIGNOUT : out std_logic                                                          := '0';            
      PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0');
      ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)     := (others => '0');
      BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                      := (others => '0');
      P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0')
      );
  end component;
  --core_if off

  --core_if on component bip_dsp48_multacc_rtl
  component bip_dsp48_multacc_rtl
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
      MULTSIGNOUT : out std_logic                                                          := '0';            
      PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0');
      ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)     := (others => '0');
      BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                      := (others => '0');
      P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0')
      );
  end component;
  --core_if off

  --core_if on component bip_dsp48_multacc_behv
  component bip_dsp48_multacc_behv
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
      MULTSIGNOUT : out std_logic                                                          := '0';            
      PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0');
      ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)     := (others => '0');
      BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                      := (others => '0');
      P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                      := (others => '0')
      );
  end component;
  --core_if off
end package bip_dsp48_multacc_pkg_v1_0;

package body bip_dsp48_multacc_pkg_v1_0 is

  function fn_dsp48_multacc_check_generics (
    P_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    P_XDEVICEFAMILY   : string  := "virtex4";
    P_LATENCY         : integer := 1;
    P_USE_ACIN        : integer := 0;
    P_USE_BCIN        : integer := 0;
    P_USE_PCIN        : integer := 0
    ) return integer is
  begin
    assert P_USE_ACIN = 0 or P_USE_ACIN = 1
      report "ERROR: xbip_dsp48_multacc: C_USE_ACIN out of range"
      severity error;
    assert P_USE_ACIN = 0 or has_dsp48e(P_XDEVICEFAMILY)
      report "ERROR: xbip_dsp48_multacc: ACIN can only be used for Virtex 5"
      severity error;
    assert P_USE_BCIN = 0 or P_USE_BCIN = 1
      report "ERROR: xbip_dsp48_multacc: C_USE_BCIN out of range"
      severity error;
    assert P_USE_PCIN = 0 or P_USE_PCIN = 1
      report "ERROR: xbip_dsp48_multacc: C_USE_PCIN out of range"
      severity error;
    assert (P_LATENCY >= -1 and P_LATENCY <= 4) or (P_LATENCY >= 16 and P_LATENCY <= 31)
      report "ERROR: xbip_dsp48_multacc: C_LATENCY out of range"
      severity ERROR;
    return 0;
  end function fn_dsp48_multacc_check_generics;

  function fn_dsp48_multacc_latency (
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string)
    return t_dsp48_multacc_latency is
    variable ret_val : t_dsp48_multacc_latency;
    variable v_latency_left : integer;
    variable v_slv_latency : std_logic_vector(5 downto 1) := (others => '0');
  begin
    --initialise all latency stages to 0.
    for i in 0 to ci_max_latency loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used   := 0;
    v_latency_left := p_latency;

    if p_latency >= 2**ci_max_latency and p_latency < 2**(ci_max_latency+1) then
      --hand-placed latency 'allocation'
      
      v_slv_latency(ci_max_latency+1 downto 1) := conv_std_logic_vector(p_latency, ci_max_latency+1);

      for i in 1 to ci_max_latency loop
        if v_slv_latency(i) = '1' then
          ret_val.pipe(i) := 1;
          ret_val.used    := ret_val.used + 1;
        end if;
      end loop;  -- i
    else
      --conventional latency allocation.
      --deal out latency according to generics and architecture for optimal speed
      --and resource
      if v_latency_left /= 0 then
        v_latency_left          := v_latency_left-1;
        ret_val.pipe(ci_stage4) := ret_val.pipe(ci_stage4) +1;
        ret_val.used            := ret_val.used +1;
      end if;

      if v_latency_left /= 0 then
        v_latency_left          := v_latency_left-1;
        ret_val.pipe(ci_stage3) := ret_val.pipe(ci_stage3) +1;
        ret_val.used            := ret_val.used +1;
      end if;

      if v_latency_left /= 0 then
        v_latency_left          := v_latency_left-1;
        ret_val.pipe(ci_stage2) := ret_val.pipe(ci_stage2) +1;
        ret_val.used            := ret_val.used +1;
      end if;

      if v_latency_left /= 0 then
        v_latency_left          := v_latency_left-1;
        ret_val.pipe(ci_stage1) := ret_val.pipe(ci_stage1) +1;
        ret_val.used            := ret_val.used +1;
      end if;

      --usually lump any excess latency on last stage, but for usecases just error.
      if v_latency_left > 0 then
        assert false
          report "ERROR: excess latency in xbip_dsp48_multacc."
          severity error;
      end if;
    end if;
    return ret_val;
    
  end function fn_dsp48_multacc_latency;

end package body bip_dsp48_multacc_pkg_v1_0;
