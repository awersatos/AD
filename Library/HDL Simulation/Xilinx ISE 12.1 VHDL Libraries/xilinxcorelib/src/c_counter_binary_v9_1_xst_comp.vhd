-- $RCSfile: c_counter_binary_v9_1_xst_comp.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:46 $
--------------------------------------------------------------------------------

--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

--LIBRARY baseblox_utils_v9_1;
--USE baseblox_utils_v9_1.prims_constants_v9_1.ALL;

package c_counter_binary_v9_1_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  component c_counter_binary_v9_1_xst
    generic (
      c_family         : string  := "virtex2";
      c_width          : integer := 16;
      c_restrict_count : integer := 0;
      c_count_to       : string  := "0";
      c_count_by       : string  := "1";
      c_count_mode     : integer := 0;  --c_up;
      c_thresh0_value  : string  := "0";
      c_thresh1_value  : string  := "0";
      c_thresh_early   : integer := 0;
      c_ainit_val      : string  := "0";
      c_sinit_val      : string  := "0";
      c_load_enable    : integer := 0;  --c_override;
      c_sync_enable    : integer := 0;  --c_override;
      c_sync_priority  : integer := 1;  --c_clear;
      c_pipe_stages    : integer := 0;
      c_has_thresh0    : integer := 0;
      c_has_q_thresh0  : integer := 0;
      c_has_thresh1    : integer := 0;
      c_has_q_thresh1  : integer := 0;
      c_has_ce         : integer := 0;
      c_has_up         : integer := 0;
      c_has_iv         : integer := 0;
      c_has_l          : integer := 0;
      c_has_load       : integer := 0;
      c_load_low       : integer := 0;
      c_has_aclr       : integer := 0;
      c_has_aset       : integer := 0;
      c_has_ainit      : integer := 0;
      c_has_sclr       : integer := 0;
      c_has_sset       : integer := 0;
      c_has_sinit      : integer := 0;
      c_enable_rlocs   : integer := 0
      );
    port (
      clk       : in  std_logic                            := '0';  -- Optional clock
      up        : in  std_logic                            := '1';  -- Controls direction of count - '1' = up.
      ce        : in  std_logic                            := '1';  -- Optional Clock enable
      load      : in  std_logic                            := '0';  -- Optional Synch load trigger
      l         : in  std_logic_vector(c_width-1 downto 0) := (others => '0');  -- Optional Synch load value
      iv        : in  std_logic_vector(c_width-1 downto 0) := (others => '0');  -- Optional Increment value
      aclr      : in  std_logic                            := '0';  -- Asynch init.
      aset      : in  std_logic                            := '0';  -- optional asynch set to '1'
      ainit     : in  std_logic                            := '0';  -- optional asynch reset to init_val
      sclr      : in  std_logic                            := '0';  -- Synch init.
      sset      : in  std_logic                            := '0';  -- optional synch set to '1'
      sinit     : in  std_logic                            := '0';  -- Optional synch reset to init_val
      thresh0   : out std_logic                            := '1';
      q_thresh0 : out std_logic                            := '1';
      thresh1   : out std_logic                            := '1';
      q_thresh1 : out std_logic                            := '1';
      q         : out std_logic_vector(c_width-1 downto 0)  -- Output value
      );

  end component;

end c_counter_binary_v9_1_xst_comp;

