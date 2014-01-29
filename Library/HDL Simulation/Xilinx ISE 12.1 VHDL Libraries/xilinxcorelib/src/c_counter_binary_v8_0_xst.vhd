-- $RCSfile: c_counter_binary_v8_0_xst.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:51 $
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
-- All rights reserved.
--

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;

USE XilinxCoreLib.prims_constants_v8_0.ALL;
USE XilinxCoreLib.c_counter_binary_v8_0_comp.ALL;

-- Synchronous binary counter
--

ENTITY c_counter_binary_v8_0_xst IS
  GENERIC (
    c_width          : INTEGER;
    c_restrict_count : INTEGER;
    c_count_to       : STRING ;
    c_count_by       : STRING ;
    c_count_mode     : INTEGER;
    c_thresh0_value  : STRING ;
    c_thresh1_value  : STRING ;
    c_thresh_early   : INTEGER;
    c_ainit_val      : STRING ;
    c_sinit_val      : STRING ;
    c_load_enable    : INTEGER; 
    c_sync_enable    : INTEGER;
    c_sync_priority  : INTEGER;
    c_pipe_stages    : INTEGER;
    c_has_thresh0    : INTEGER;
    c_has_q_thresh0  : INTEGER;
    c_has_thresh1    : INTEGER;
    c_has_q_thresh1  : INTEGER;
    c_has_ce         : INTEGER;
    c_has_up         : INTEGER;
    c_has_iv         : INTEGER;
    c_has_l          : INTEGER;
    c_has_load       : INTEGER;
    c_load_low       : INTEGER;
    c_has_aclr       : INTEGER;
    c_has_aset       : INTEGER;
    c_has_ainit      : INTEGER;
    c_has_sclr       : INTEGER;
    c_has_sset       : INTEGER;
    c_has_sinit      : INTEGER;
    c_enable_rlocs   : INTEGER
    ); 

  PORT (
    clk       : IN  STD_LOGIC                            := '0';  -- optional clock
    up        : IN  STD_LOGIC                            := '1';  -- controls direction of count - '1' = up.
    ce        : IN  STD_LOGIC                            := '1';  -- optional clock enable
    load      : IN  STD_LOGIC                            := '0';  -- optional synch load trigger
    l         : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- optional synch load value
    iv        : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- optional increment value
    aclr      : IN  STD_LOGIC                            := '0';  -- asynch init.
    aset      : IN  STD_LOGIC                            := '0';  -- optional asynch set to '1'
    ainit     : IN  STD_LOGIC                            := '0';  -- optional asynch reset to init_val
    sclr      : IN  STD_LOGIC                            := '0';  -- synch init.
    sset      : IN  STD_LOGIC                            := '0';  -- optional synch set to '1'
    sinit     : IN  STD_LOGIC                            := '0';  -- optional synch reset to init_val
    thresh0   : OUT STD_LOGIC                            := '1';
    q_thresh0 : OUT STD_LOGIC                            := '1';
    thresh1   : OUT STD_LOGIC                            := '1';
    q_thresh1 : OUT STD_LOGIC                            := '1';
    q         : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)  -- output value
    );
END c_counter_binary_v8_0_xst;

ARCHITECTURE behavioral OF c_counter_binary_v8_0_xst IS

BEGIN
  i_behv : c_counter_binary_v8_0
    GENERIC MAP(
      c_width          => c_width,
      c_restrict_count => c_restrict_count,
      c_count_to       => c_count_to,
      c_count_by       => c_count_by,
      c_count_mode     => c_count_mode,
      c_thresh0_value  => c_thresh0_value,
      c_thresh1_value  => c_thresh1_value,
      c_thresh_early   => c_thresh_early,
      c_ainit_val      => c_ainit_val,
      c_sinit_val      => c_sinit_val,
      c_load_enable    => c_load_enable,
      c_sync_enable    => c_sync_enable,
      c_sync_priority  => c_sync_priority,
      c_pipe_stages    => c_pipe_stages,
      c_has_thresh0    => c_has_thresh0,
      c_has_q_thresh0  => c_has_q_thresh0,
      c_has_thresh1    => c_has_thresh1,
      c_has_q_thresh1  => c_has_q_thresh1,
      c_has_ce         => c_has_ce,
      c_has_up         => c_has_up,
      c_has_iv         => c_has_iv,
      c_has_l          => c_has_l,
      c_has_load       => c_has_load,
      c_load_low       => c_load_low,
      c_has_aclr       => c_has_aclr,
      c_has_aset       => c_has_aset,
      c_has_ainit      => c_has_ainit,
      c_has_sclr       => c_has_sclr,
      c_has_sset       => c_has_sset,
      c_has_sinit      => c_has_sinit,
      c_enable_rlocs   => c_enable_rlocs
      ) 

    PORT MAP(
      clk       => clk,
      up        => up,
      ce        => ce,
      load      => load,
      l         => l,
      iv        => iv,
      aclr      => aclr,
      aset      => aset,
      ainit     => ainit,
      sclr      => sclr,
      sset      => sset,
      sinit     => sinit,
      thresh0   => thresh0,
      q_thresh0 => q_thresh0,
      thresh1   => thresh1,
      q_thresh1 => q_thresh1,
      q         => q
      );
END behavioral;
