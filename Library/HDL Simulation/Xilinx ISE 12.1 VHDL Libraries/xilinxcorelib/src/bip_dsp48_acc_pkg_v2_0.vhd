-- $Id: bip_dsp48_acc_pkg_v2_0.vhd,v 1.3 2009/09/08 16:46:31 akennedy Exp $
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
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;

-------------------------------------------------------------------------------
-- Designer note!!
-- This file is for the top level component declaration and any types and functions
-- which calling cores may require. Internal functions, types and component declarations
-- should be in the dsp48_acc_hdl_pkg file.
-------------------------------------------------------------------------------

package bip_dsp48_acc_pkg_v2_0 is

  --core_if on component xbip_dsp48_acc
  component xbip_dsp48_acc
    GENERIC (
      C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := -1;
      C_HAS_SUBTRACT    : integer := 1;          -- see check generics for explanation
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
  end component xbip_dsp48_acc;

  constant ci_max_latency       : integer := 4;
  type t_dsp48_acc_pipe is array (0 to ci_max_latency) of integer;
  type t_dsp48_acc_latency is record
                                 used : integer;
                                 pipe : t_dsp48_acc_pipe;
                               end record;

  constant ci_stage1 : integer := 1;
  constant ci_stage2 : integer := 2;
  constant ci_stage3 : integer := 3;
  constant ci_stage4 : integer := 4;
  
  function fn_dsp48_acc_check_generics (
    P_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    P_XDEVICEFAMILY   : string  := "virtex4";
    P_LATENCY         : integer := 1;
    P_HAS_SUBTRACT    : integer := 1;   --see check generics for explanation
    P_USE_PCIN        : integer := 0;
    P_USE_CARRYCASCIN : integer := 0
    ) return integer;
  
  function fn_dsp48_acc_latency (
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string)
    return t_dsp48_acc_latency;


  --core_if on component bip_dsp48_acc_synth
  component bip_dsp48_acc_synth
    GENERIC (
      C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := -1;
      C_HAS_SUBTRACT    : integer := 1;          -- see check generics for explanation
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
  end component bip_dsp48_acc_synth;

  --core_if on component bip_dsp48_acc_rtl
  component bip_dsp48_acc_rtl
    GENERIC (
      C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := -1;
      C_HAS_SUBTRACT    : integer := 1;          -- see check generics for explanation
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
  end component bip_dsp48_acc_rtl;

  --core_if on component bip_dsp48_acc_behv
  component bip_dsp48_acc_behv
    GENERIC (
      C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := -1;
      C_HAS_SUBTRACT    : integer := 1;          -- see check generics for explanation
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
  end component bip_dsp48_acc_behv;
end package bip_dsp48_acc_pkg_v2_0;

package body bip_dsp48_acc_pkg_v2_0 is

  function fn_dsp48_acc_check_generics (
    P_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    P_XDEVICEFAMILY   : string  := "virtex4";
    P_LATENCY         : integer := 1;
    P_HAS_SUBTRACT    : integer := 1;   --see check generics for explanation
    P_USE_PCIN        : integer := 0;
    P_USE_CARRYCASCIN : integer := 0
    ) return integer is
  begin
    assert P_VERBOSITY > -1 and P_VERBOSITY < 3
      report "ERROR: xbip_dsp48_acc: C_VERBOSITY out of range 0 to 2"
      severity error;
    assert P_MODEL_TYPE > -1 and P_MODEL_TYPE < 3
      report "ERROR: xbip_dsp48_acc: C_MODEL_TYPE out of range 0 to 2"
      severity error;    
    assert P_USE_PCIN = 0 or P_USE_PCIN = 1
      report "ERROR: xbip_dsp48_acc: C_USE_PCIN out of range"
      severity error;
    assert P_HAS_SUBTRACT = 0 or P_HAS_SUBTRACT = 1
      report "ERROR: xbip_dsp48_acc: C_HAS_SUBTRACT out of range"
      severity error;
    assert P_HAS_SUBTRACT = 0 or P_USE_PCIN = 0  --or has_dsp48e(P_XDEVICEFAMILY) 
      report "ERROR: xbip_dsp48_acc: SUBTRACT with PCIN is not supported "
      severity error;
    assert P_USE_CARRYCASCIN = 0 or P_USE_CARRYCASCIN = 1
      report "ERROR: xbip_dsp48_acc: C_USE_CARRYCASCIN out of range"
      severity error;
    assert P_USE_CARRYCASCIN = 0 or supports_dsp48a(P_XDEVICEFAMILY)>0 or supports_dsp48e(P_XDEVICEFAMILY)>0
      report "ERROR: xbip_dsp48_acc: C_USE_CARRYCASCIN not supported for Virtex4"
      severity error;
    assert ((P_USE_CARRYCASCIN + P_USE_PCIN) < 2) or supports_dsp48(P_XDEVICEFAMILY)>0 or supports_dsp48a(P_XDEVICEFAMILY)>0
      report "ERROR: xbip_dsp48_addsub: C_USE_CARRYCASCIN and C_USE_PCIN are mutually-exclusive in V5"
      severity error;

--    assert (P_LATENCY >= -1 and P_LATENCY <= 4) or (P_LATENCY >= 16 and P_LATENCY <= 31)
    assert (P_LATENCY = -1 or P_LATENCY = 1 or P_LATENCY = 2 or P_LATENCY = 24 or P_LATENCY = 28)    
      report "ERROR: xbip_dsp48_acc: C_LATENCY out of range" & CR & "Supported values are -1, 1, 2, 24 and 28)"
      severity ERROR;
    return 0;
  end function fn_dsp48_acc_check_generics;

  function fn_dsp48_acc_latency (
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string)
    return t_dsp48_acc_latency is
    variable ret_val : t_dsp48_acc_latency;
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
      -- MSB is set as 'flag' to say "custom latency allocation"
      -- LSBs are then the register stages to enable
      -- Stages 1 and 2 (SLV(0), SLV(1)) are not supported for accumulator
      
      v_slv_latency(ci_max_latency+1 downto 1) := conv_std_logic_vector(p_latency, ci_max_latency+1);

      assert v_slv_latency(1) = '0' and v_slv_latency(2) = '0'
        report "ERROR: xbip_dsp48_acc does not currently support stage 1 or stage 2 registers."
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
          report "ERROR: excess latency in xbip_dsp48_acc."
          severity error;
      end if;
    end if;
    return ret_val;
    
  end function fn_dsp48_acc_latency;

end package body bip_dsp48_acc_pkg_v2_0;
