-- $Header: /devl/xcs/repo/env/Databases/ip/src2/L/xbip_dsp48_mux2_v2_0/simulation/bip_dsp48_mux2_pkg_v2_0.vhd,v 1.3 2009/09/08 16:46:35 akennedy Exp $
--
--  (c) Copyright 2007 Xilinx, Inc. All rights reserved.
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.conv_std_logic_vector;

library xilinxcorelib;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

-------------------------------------------------------------------------------
-- Designer note!!
-- This file is for the top level component declaration and any types and functions
-- which calling cores may require. Internal functions, types and component declarations
-- should be in the dsp48_mux2_hdl_pkg file.
-------------------------------------------------------------------------------

package bip_dsp48_mux2_pkg_v2_0 is

  constant ci_max_latency       : integer := 4;
  type t_dsp48_mux2_pipe is array (0 to ci_max_latency) of integer;
  type t_dsp48_mux2_latency is record
                                 used : integer;
                                 pipe : t_dsp48_mux2_pipe;
                               end record;

  constant ci_stage1 : integer := 1;
  constant ci_stage2 : integer := 2;
  constant ci_stage3 : integer := 3;
  constant ci_stage4 : integer := 4;
  
  function fn_dsp48_mux2_check_generics (
    P_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    P_XDEVICEFAMILY   : string  := "virtex4";
    P_LATENCY         : integer := 1
    ) return integer;
  
  function fn_dsp48_mux2_latency (
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string)
    return t_dsp48_mux2_latency;

  --core_if on component xbip_dsp48_mux2
  component xbip_dsp48_mux2
    generic (
      C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := -1
      );
    port (
      CLK   : in  std_logic                                                           := '1';
      CE    : in  std_logic                                                           := '1';
      SCLR  : in  std_logic                                                           := '0';
      SELA  : in  std_logic                                                           := '0';
      SELB  : in  std_logic                                                           := '0';
      X     : in  std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
      Z     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                       := (others => '0');
      PCOUT : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      P     : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0')
      );
  end component;
  --core_if off

  --core_if on component bip_dsp48_mux2_synth
  component bip_dsp48_mux2_synth
    generic (
      C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := -1
      );
    port (
      CLK   : in  std_logic                                                           := '1';
      CE    : in  std_logic                                                           := '1';
      SCLR  : in  std_logic                                                           := '0';
      SELA  : in  std_logic                                                           := '0';
      SELB  : in  std_logic                                                           := '0';
      X     : in  std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
      Z     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                       := (others => '0');
      PCOUT : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      P     : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0')
      );
  end component;
  --core_if off

  --core_if on component bip_dsp48_mux2_rtl
  component bip_dsp48_mux2_rtl
    generic (
      C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := -1
      );
    port (
      CLK   : in  std_logic                                                           := '1';
      CE    : in  std_logic                                                           := '1';
      SCLR  : in  std_logic                                                           := '0';
      SELA  : in  std_logic                                                           := '0';
      SELB  : in  std_logic                                                           := '0';
      X     : in  std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
      Z     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                       := (others => '0');
      PCOUT : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      P     : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0')
      );
  end component;
  --core_if off

  --core_if on component bip_dsp48_mux2_behv
  component bip_dsp48_mux2_behv
    generic (
      C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := -1
      );
    port (
      CLK   : in  std_logic                                                           := '1';
      CE    : in  std_logic                                                           := '1';
      SCLR  : in  std_logic                                                           := '0';
      SELA  : in  std_logic                                                           := '0';
      SELB  : in  std_logic                                                           := '0';
      X     : in  std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
      Z     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                       := (others => '0');
      PCOUT : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      P     : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0')
      );
  end component;
  --core_if off
end package bip_dsp48_mux2_pkg_v2_0;

package body bip_dsp48_mux2_pkg_v2_0 is

  function fn_dsp48_mux2_check_generics (
    P_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    P_XDEVICEFAMILY   : string  := "virtex4";
    P_LATENCY         : integer := 1
    ) return integer is
  begin
    assert P_VERBOSITY = 0 or P_VERBOSITY = 1 or P_VERBOSITY = 2
      report "ERROR : xbip_dsp48_mux2: P_VERBOSITY out of range 0 to 2"
      severity error;
    assert P_MODEL_TYPE = 0 or P_MODEL_TYPE = 1 or P_MODEL_TYPE = 2
      report "ERROR: xbip_dsp48_mux2: P_MODEL_TYPE out of range 0 to 2"
      severity error;
    assert not(P_XDEVICEFAMILY = "")
      report "ERROR: xbip_dsp48_mux2: C_XDEVICEFAMILY not set"
      severity error;
    assert (P_LATENCY >= -1 and P_LATENCY <= 2) or (P_LATENCY >= 16 and P_LATENCY <= 31)
      report "ERROR: xbip_dsp48_mux2: C_LATENCY out of range"
      severity ERROR;
    return 0;
  end function fn_dsp48_mux2_check_generics;

  function fn_dsp48_mux2_latency (
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string)
    return t_dsp48_mux2_latency is
    variable ret_val : t_dsp48_mux2_latency;
    variable v_latency_left : integer;
    variable v_slv_latency : std_logic_vector(ci_max_latency+1 downto 1) := (others => '0');
  begin
    --initialise all latency stages to 0.
    for i  in 0 to ci_max_latency loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used := 0;
    v_latency_left := p_latency;

    if p_latency >= 2**ci_max_latency and p_latency < 2**(ci_max_latency+1) then
      --hand-placed latency 'allocation'
      
      v_slv_latency(ci_max_latency+1 downto 1) := conv_std_logic_vector(p_latency, ci_max_latency+1);

      assert (v_slv_latency(1) = '0') and (v_slv_latency(2) = '0')
        report "ERROR: xbip_dsp48_mux2 does not currently support stage 1 or stage 2 registers."
        severity error;
      for i in 3 to ci_max_latency loop
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

      --usually lump any excess latency on last stage, but for usecases just error.
      if v_latency_left > 0 then
        assert false
          report "ERROR: excess latency in xbip_dsp48_mux2."
          severity error;
      end if;
    end if;
    return ret_val;
    
  end function fn_dsp48_mux2_latency;

end package body bip_dsp48_mux2_pkg_v2_0;
