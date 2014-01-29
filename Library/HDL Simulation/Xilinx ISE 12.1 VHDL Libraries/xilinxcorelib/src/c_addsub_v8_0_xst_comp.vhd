-- $RCSfile: c_addsub_v8_0_xst_comp.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:49 $
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

--library baseblox_utils_v8_0;
--use baseblox_utils_v8_0.prims_constants_v8_0.all;

package c_addsub_v8_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  COMPONENT c_addsub_v8_0_xst
    GENERIC (
      c_a_width             : INTEGER := 16;
      c_b_width             : INTEGER := 16;
      c_out_width           : INTEGER := 16;
      c_low_bit             : INTEGER := 0;
      c_high_bit            : INTEGER := 15;
      c_add_mode            : INTEGER := 0;--c_add;
      c_a_type              : INTEGER := 1;--c_unsigned;
      c_b_type              : INTEGER := 1;--c_unsigned;
      c_b_constant          : INTEGER := 0;
      c_b_value             : STRING  := "0"; 
      c_ainit_val           : STRING  := "0"; 
      c_sinit_val           : STRING  := "0"; 
      c_bypass_enable       : INTEGER := 0;--c_no_override;
      c_bypass_low          : INTEGER := 0;
      c_sync_enable         : INTEGER := 0;--c_override;
      c_sync_priority       : INTEGER := 1;--c_clear;
      c_pipe_stages         : INTEGER := 0;
      c_latency             : INTEGER := 1;
      c_has_s               : INTEGER := 0;
      c_has_q               : INTEGER := 1;
      c_has_c_in            : INTEGER := 0;
      c_has_c_out           : INTEGER := 0;
      c_has_q_c_out         : INTEGER := 0;
      c_has_b_in            : INTEGER := 0;
      c_has_b_out           : INTEGER := 0;
      c_has_q_b_out         : INTEGER := 0;
      c_has_ovfl            : INTEGER := 0;
      c_has_q_ovfl          : INTEGER := 0;
      c_has_ce              : INTEGER := 0;
      c_has_add             : INTEGER := 0;
      c_has_bypass          : INTEGER := 0;
      c_has_a_signed        : INTEGER := 0;
      c_has_b_signed        : INTEGER := 0;
      c_has_aclr            : INTEGER := 0;
      c_has_aset            : INTEGER := 0;
      c_has_ainit           : INTEGER := 0;
      c_has_sclr            : INTEGER := 0;
      c_has_sset            : INTEGER := 0;
      c_has_sinit           : INTEGER := 0;
      c_enable_rlocs        : INTEGER := 0;
      c_has_bypass_with_cin : INTEGER := 0
      );
    PORT (
      a        : IN  STD_LOGIC_VECTOR(c_a_width-1 DOWNTO 0) := (OTHERS => '0');  
      b        : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');  
      clk      : IN  STD_LOGIC                              := '0';  
      add      : IN  STD_LOGIC                              := '1';  
      c_in     : IN  STD_LOGIC                              := '0';  
      b_in     : IN  STD_LOGIC                              := '1';  
      ce       : IN  STD_LOGIC                              := '1';  
      bypass   : IN  STD_LOGIC                              := '0';  
      aclr     : IN  STD_LOGIC                              := '0';  
      aset     : IN  STD_LOGIC                              := '0';  
      ainit    : IN  STD_LOGIC                              := '0';  
      sclr     : IN  STD_LOGIC                              := '0';  
      sset     : IN  STD_LOGIC                              := '0';  
      sinit    : IN  STD_LOGIC                              := '0';  
      a_signed : IN  STD_LOGIC                              := '0';  
      b_signed : IN  STD_LOGIC                              := '0';  
      ovfl     : OUT STD_LOGIC;
      c_out    : OUT STD_LOGIC;
      b_out    : OUT STD_LOGIC;           
      q_ovfl   : OUT STD_LOGIC;
      q_c_out  : OUT STD_LOGIC;
      q_b_out  : OUT STD_LOGIC;
      s        : OUT STD_LOGIC_VECTOR(c_out_width - 1 DOWNTO 0);  
      q        : OUT STD_LOGIC_VECTOR(c_out_width - 1 DOWNTO 0)  
      );

  END COMPONENT;

end c_addsub_v8_0_xst_comp;

