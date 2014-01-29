-- $Header
--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 2007 Xilinx, Inc.
--  All rights reserved.

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;

package bip_bram18k_v1_0_pkg is

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
    P_XDEVICEFAMILY : string  := "virtex4";
    P_LATENCY       : integer := 1;
    P_VERBOSITY     : integer := 0;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
    P_OPTIMIZE_GOAL : integer := 0;  --0 = area, 1 = speed.
    P_MODEL_TYPE    : integer := 1;  --0 = synth, 1 = RTL
    P_ADDR_WIDTH    : integer := 10;
    P_DATA_WIDTH    : integer := 18;
    P_INIT_VAL      : t_BRAM18k_init_val := (others => (others => '0'))
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
    P_LATENCY       : integer := 0;
    P_OPTIMIZE_GOAL : integer := 0
    )
    return t_BRAM18k_latency;
    
end package bip_bram18k_v1_0_pkg;

package body bip_bram18k_v1_0_pkg is

  function check_generics (
    P_XDEVICEFAMILY : string  := "virtex4";
    P_LATENCY       : integer := 1;
    P_VERBOSITY     : integer := 0;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
    P_OPTIMIZE_GOAL : integer := 0;  --0 = area, 1 = speed.
    P_MODEL_TYPE    : integer := 1;  --0 = synth, 1 = RTL
    P_ADDR_WIDTH    : integer := 10;
    P_DATA_WIDTH    : integer := 18;
    P_INIT_VAL      : t_BRAM18k_init_val := (others => (others => '0'))
    )
    return integer is
  begin
    assert P_LATENCY = -1 or P_LATENCY = 1 or P_LATENCY = 2 or P_LATENCY = 3
      report "ERROR: BRAM18k_v1_0: Invalid latency value"
      severity ERROR;
    assert P_OPTIMIZE_GOAL = 0 or P_OPTIMIZE_GOAL = 1
      report "ERROR: BRAM18k_v1_0: Invalid optimization goal value"
      severity error;
    assert P_MODEL_TYPE = 0 or P_MODEL_TYPE = 1 or P_MODEL_TYPE = 2
      report "ERROR: BRAM18k_v1_0: Invalid model type value."
      severity error;
    assert P_ADDR_WIDTH >= 9 and P_ADDR_WIDTH <= 14
      report "ERROR: BRAM18k_v1_0: Address Width must be in range 9 to 14."
      severity error;
    assert (P_ADDR_WIDTH = 9 and P_DATA_WIDTH = 36) or
      (P_ADDR_WIDTH = 10 and P_DATA_WIDTH = 18) or
      (P_ADDR_WIDTH = 11 and P_DATA_WIDTH = 9) or
      (P_ADDR_WIDTH = 12 and P_DATA_WIDTH = 4) or
      (P_ADDR_WIDTH = 13 and P_DATA_WIDTH = 2) or
      (P_ADDR_WIDTH = 14 and P_DATA_WIDTH = 1)
      report "ERROR: BRAM18k_v1_0: Address and Data width must be (9,36) or (10,18) or (11,9) or (12,4) or (13, 2) or (14,1)."
      severity error;
      
    return 0;
  end check_generics;

  function fn_BRAM18k_latency(
    P_LATENCY       : integer := 0;
    P_OPTIMIZE_GOAL : integer := 0
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


end package body bip_bram18k_v1_0_pkg;
