-- $RCSfile: c_twos_comp_v9_1_xst_comp.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:54 $
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

package c_twos_comp_v9_1_xst_comp is

  COMPONENT c_twos_comp_v9_1_xst
    GENERIC (
      c_width          : INTEGER := 16;
      c_ainit_val      : STRING  := "0";
      c_sinit_val      : STRING  := "0";
      c_bypass_enable  : INTEGER := 0;
      c_bypass_low     : INTEGER := 0;
      c_sync_priority  : INTEGER := 0;  --T_REG_PRIORITY := RESET_OVERRIDES_SET;
      c_sync_enable    : INTEGER := 0;  --T_SYNC_ENABLE  := SYNC_OVERRIDES_CE;
      c_pipe_stages    : INTEGER := 0;
      c_has_bypass     : INTEGER := 0;
      c_has_ce         : INTEGER := 0;
      c_has_aclr       : INTEGER := 0;
      c_has_aset       : INTEGER := 0;
      c_has_ainit      : INTEGER := 0;
      c_has_sclr       : INTEGER := 0;
      c_has_sset       : INTEGER := 0;
      c_has_sinit      : INTEGER := 0;
      c_has_s          : INTEGER := 0;
      c_has_q          : INTEGER := 1;
      c_enable_rlocs   : INTEGER := 0
      );
    PORT (
      a      : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- signed input value!
      bypass : IN  STD_LOGIC                            := '0';  -- control of negation : '0' = negate input
      clk    : IN  STD_LOGIC                            := '0';  -- clock
      ce     : IN  STD_LOGIC                            := '1';  -- clock enable
      aclr   : IN  STD_LOGIC                            := '0';  -- asynch init.
      aset   : IN  STD_LOGIC                            := '0';  -- asynch set.
      ainit  : IN  STD_LOGIC                            := '0';  -- asynch init.
      sclr   : IN  STD_LOGIC                            := '0';  -- synch init.
      sset   : IN  STD_LOGIC                            := '0';  -- synch set.
      sinit  : IN  STD_LOGIC                            := '0';  -- synch init.
      s      : OUT STD_LOGIC_VECTOR(c_width DOWNTO 0);  -- asynch output
      q      : OUT STD_LOGIC_VECTOR(c_width DOWNTO 0)  -- registered output value
      );

  END COMPONENT;


end c_twos_comp_v9_1_xst_comp;

