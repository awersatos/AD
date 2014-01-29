-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 2.1
--  \   \        Filename: $RCSfile: bip_bram18k_pkg_v2_1.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:20 $
-- /___/   /\    Date Created: 2007
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : xbip_bram18k_v2_1
-- Purpose : Package for single 18K BRAM memory
--
--------------------------------------------------------------------------------
--  (c) Copyright 2007, 2009 Xilinx, Inc. All rights reserved.
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
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

package bip_bram18k_pkg_v2_1 is

  type t_BRAM18k_init_val is array (0 to 2**9-1) of std_logic_vector(35 downto 0);
  type t_BRAM18k_9_36_init_val  is array (0 to 2**9-1)  of std_logic_vector(35 downto 0);
  type t_BRAM18k_10_18_init_val is array (0 to 2**10-1) of std_logic_vector(17 downto 0);
  type t_BRAM18k_11_9_init_val  is array (0 to 2**11-1) of std_logic_vector(8 downto 0);
  type t_BRAM18k_12_4_init_val  is array (0 to 2**12-1) of std_logic_vector(3 downto 0);
  type t_BRAM18k_13_2_init_val  is array (0 to 2**13-1) of std_logic_vector(1 downto 0);
  type t_BRAM18k_14_1_init_val  is array (0 to 2**14-1) of std_logic_vector(0 downto 0);

  function fn_BRAM18k_conv_10_18_to_init (
    p_10_18_init_val : t_BRAM18k_10_18_init_val)
    return t_BRAM18k_init_val;
  function fn_BRAM18k_conv_11_9_to_init (
    p_11_9_init_val : t_BRAM18k_11_9_init_val)
    return t_BRAM18k_init_val;
  function fn_BRAM18k_conv_12_4_to_init (
    p_12_4_init_val : t_BRAM18k_12_4_init_val)
    return t_BRAM18k_init_val;
  function fn_BRAM18k_conv_13_2_to_init (
    p_13_2_init_val : t_BRAM18k_13_2_init_val)
    return t_BRAM18k_init_val;
  function fn_BRAM18k_conv_14_1_to_init (
    p_14_1_init_val : t_BRAM18k_14_1_init_val)
    return t_BRAM18k_init_val;

  component xbip_bram18k
    generic (
      C_XDEVICEFAMILY : string := "virtex4";
      C_LATENCY        : integer := -1;
      C_VERBOSITY      : integer := 0;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
      C_OPTIMIZE_GOAL  : integer := 0;  --0 = area, 1 = speed.
      C_MODEL_TYPE     : integer := 1;  --0 = synth, 1 = RTL
      C_ADDR_WIDTH     : integer := 10;
      C_DATA_WIDTH     : integer := 18;
      C_INIT_VAL       : t_BRAM18k_init_val := (others => (others => '0'))
      );
    PORT (
      CLK       : in  std_logic                    := '1';
      CE        : in  std_logic                    := '1';
      SCLR      : in  std_logic                    := '0';
      WE1       : in  std_logic                    := '0';
      WE2       : in  std_logic                    := '0';
      ADDR1     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0'); 
      ADDR2     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0'); 
      DATAIN1   : in  std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
      DATAIN2   : in  std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
      DATAOUT1  : out std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
      DATAOUT2  : out std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0')
      );
  --core_if off
  end component;
  
  function check_generics (
    P_XDEVICEFAMILY : string  ;--:= "virtex4";
    P_LATENCY       : integer ;--:= 1;
    P_VERBOSITY     : integer ;--:= 0;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
    P_OPTIMIZE_GOAL : integer ;--:= 0;  --0 = area, 1 = speed.
    P_MODEL_TYPE    : integer ;--:= 1;  --0 = synth, 1 = RTL
    P_ADDR_WIDTH    : integer ;--:= 10;
    P_DATA_WIDTH    : integer ;--:= 18;
    P_INIT_VAL      : t_BRAM18k_init_val -- := (others => (others => '0'))
    )
    return integer;

  
  constant ci_max_latency       : integer := 3;
  constant ci_rom_ip_stage      : integer := 1;
  constant ci_rom_op_stage      : integer := 2;
  constant ci_rom_speedup_stage : integer := 3;

  type t_BRAM18k_pipe is array (0 to ci_max_latency) of integer;
  type t_BRAM18k_latency is record
                                 used : integer;
                                 pipe : t_BRAM18k_pipe;
                               end record;
  function fn_BRAM18k_latency(
    P_LATENCY       : integer;-- := 0;
    P_OPTIMIZE_GOAL : integer -- := 0
    )
    return t_BRAM18k_latency;
    
end package bip_bram18k_pkg_v2_1;

package body bip_bram18k_pkg_v2_1 is

  function check_generics (
    P_XDEVICEFAMILY : string  ;--:= "virtex4";
    P_LATENCY       : integer ;--:= 1;
    P_VERBOSITY     : integer ;--:= 0;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
    P_OPTIMIZE_GOAL : integer ;--:= 0;  --0 = area, 1 = speed.
    P_MODEL_TYPE    : integer ;--:= 1;  --0 = synth, 1 = RTL
    P_ADDR_WIDTH    : integer ;--:= 10;
    P_DATA_WIDTH    : integer ;--:= 18;
    P_INIT_VAL      : t_BRAM18k_init_val --:= (others => (others => '0'))
    )
    return integer is
  begin
    assert P_LATENCY = -1 or P_LATENCY = 1 or P_LATENCY = 2 or P_LATENCY = 3
      report "ERROR: xbip_bram18k_v2_1: Invalid latency value"
      severity ERROR;
    assert P_OPTIMIZE_GOAL = 0 or P_OPTIMIZE_GOAL = 1
      report "ERROR: xbip_bram18k_v2_1: Invalid optimization goal value"
      severity error;
    assert P_MODEL_TYPE = 0 or P_MODEL_TYPE = 1 or P_MODEL_TYPE = 2
      report "ERROR: xbip_bram18k_v2_1: Invalid model type value."
      severity error;
    assert P_ADDR_WIDTH >= 9 and P_ADDR_WIDTH <= 14
      report "ERROR: xbip_bram18k_v2_1: Address Width must be in range 9 to 14."
      severity error;
    assert (P_ADDR_WIDTH = 9 and P_DATA_WIDTH = 36) or
      (P_ADDR_WIDTH = 10 and P_DATA_WIDTH = 18) or
      (P_ADDR_WIDTH = 11 and P_DATA_WIDTH = 9) or
      (P_ADDR_WIDTH = 12 and P_DATA_WIDTH = 4) or
      (P_ADDR_WIDTH = 13 and P_DATA_WIDTH = 2) or
      (P_ADDR_WIDTH = 14 and P_DATA_WIDTH = 1)
      report "ERROR: xbip_bram18k_v2_1: Address and Data width must be (9,36) or (10,18) or (11,9) or (12,4) or (13, 2) or (14,1)."
      severity error;
      
    return 0;
  end check_generics;

  function fn_BRAM18k_latency(
    P_LATENCY       : integer ;--:= 0;
    P_OPTIMIZE_GOAL : integer --:= 0
    )
    return t_BRAM18k_latency is
    variable ret_val : t_BRAM18k_latency;
    variable v_latency_left : integer;
  begin
    for i  in 0 to ci_max_latency loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used := 0;
    v_latency_left := p_latency;
    if v_latency_left /= 0 then
      v_latency_left := v_latency_left-1;
      ret_val.pipe(ci_rom_ip_stage) := ret_val.pipe(ci_rom_ip_stage) +1;
      ret_val.used := ret_val.used +1;
    end if;
    if v_latency_left /= 0 then
      v_latency_left := v_latency_left-1;
      ret_val.pipe(ci_rom_op_stage) := ret_val.pipe(ci_rom_op_stage) +1;
      ret_val.used := ret_val.used +1;
    end if;
    if v_latency_left /= 0 and P_OPTIMIZE_GOAL = 1 then
      v_latency_left := v_latency_left-1;
      ret_val.pipe(ci_rom_speedup_stage) := ret_val.pipe(ci_rom_speedup_stage) +1;
      ret_val.used := ret_val.used +1;
    end if;
    if v_latency_left > 0 then
      ret_val.pipe(ci_rom_speedup_stage) := ret_val.pipe(ci_rom_speedup_stage) + v_latency_left;
      ret_val.used := ret_val.used +v_latency_left;
    end if;
    return ret_val;
  end fn_BRAM18k_latency;
  
  function fn_BRAM18k_conv_10_18_to_init (
    p_10_18_init_val : t_BRAM18k_10_18_init_val)
    return t_BRAM18k_init_val is
    variable ret_val : t_BRAM18k_init_val := (others => (others => '0'));
  begin
    for i in 0 to 2**9-1 loop
      ret_val(i) := p_10_18_init_val(i*2+1)(17 downto 16) & p_10_18_init_val(i*2)(17 downto 16) &
                    p_10_18_init_val(i*2+1)(15 downto 0)  & p_10_18_init_val(i*2)(15 downto 0);
    end loop;  -- addr
    return ret_val;
  end fn_BRAM18k_conv_10_18_to_init;
  
  function fn_BRAM18k_conv_11_9_to_init (
    p_11_9_init_val : t_BRAM18k_11_9_init_val)
    return t_BRAM18k_init_val is
    variable ret_val : t_BRAM18k_init_val := (others => (others => '0'));
  begin
    for i in 0 to 2**9-1 loop
      ret_val(i) := p_11_9_init_val(i*4+3)(8) & p_11_9_init_val(i*4+2)(8) & p_11_9_init_val(i*4+1)(8) & p_11_9_init_val(i*4)(8) &
                    p_11_9_init_val(i*4+3)(7 downto 0) & p_11_9_init_val(i*4+2)(7 downto 0) & p_11_9_init_val(i*4+1)(7 downto 0) & p_11_9_init_val(i*4)(7 downto 0);
    end loop;  -- addr
    return ret_val;
  end fn_BRAM18k_conv_11_9_to_init;
  
  function fn_BRAM18k_conv_12_4_to_init (
    p_12_4_init_val : t_BRAM18k_12_4_init_val)
    return t_BRAM18k_init_val is
    variable ret_val : t_BRAM18k_init_val := (others => (others => '0'));
  begin
    for i in 0 to 2**9-1 loop
      for splice in 0 to 7 loop
        ret_val(i)(splice*4+3 downto splice*4) := p_12_4_init_val(i*8+splice);
      end loop;  -- splice
    end loop;  --       addr
    return ret_val;
  end fn_BRAM18k_conv_12_4_to_init;
  
  function fn_BRAM18k_conv_13_2_to_init (
    p_13_2_init_val : t_BRAM18k_13_2_init_val)
    return t_BRAM18k_init_val is
    variable ret_val : t_BRAM18k_init_val := (others => (others => '0'));
  begin
    for i in 0 to 2**9-1 loop
      for splice in 0 to 15 loop
        ret_val(i)(splice*2+1 downto splice*2) := p_13_2_init_val(i*16+splice);
      end loop;  -- splice
    end loop;  -- addr
    return ret_val;
  end fn_BRAM18k_conv_13_2_to_init;
  
  function fn_BRAM18k_conv_14_1_to_init (
    p_14_1_init_val : t_BRAM18k_14_1_init_val)
    return t_BRAM18k_init_val is
    variable ret_val : t_BRAM18k_init_val := (others => (others => '0'));
  begin
    for i in 0 to 2**9-1 loop
      for splice in 0 to 31 loop
        ret_val(i)(splice downto splice) := p_14_1_init_val(i*32+splice);
      end loop;  -- splice
    end loop;  -- addr
    return ret_val;
  end fn_BRAM18k_conv_14_1_to_init;


end package body bip_bram18k_pkg_v2_1;
