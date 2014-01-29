-- $RCSfile: c_accum_v9_1_xst_comp.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:41 $
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

--library baseblox_utils_v9_1;
--use baseblox_utils_v9_1.prims_constants_v9_1.all;

package c_accum_v9_1_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  COMPONENT c_accum_v9_1_xst
    GENERIC (
      c_family              : STRING  := "virtex2";
      c_use_dsp48           : INTEGER := 0;
      c_b_width             : INTEGER := 16;
      c_out_width           : INTEGER := 16;
      c_low_bit             : INTEGER := 0;
      c_high_bit            : INTEGER := 15;
      c_add_mode            : INTEGER := 0;--c_add;
      c_b_type              : INTEGER := 1;--c_unsigned;
      c_b_constant          : INTEGER := 0;
      c_b_value             : STRING  := "0000000000000000";                        
      c_scale               : INTEGER := 0;
      c_saturate            : INTEGER := 0;
      c_ainit_val           : STRING  := "0000000000000000";                        
      c_sinit_val           : STRING  := "0000000000000000";                        
      c_bypass_enable       : INTEGER := 1;--c_no_override;
      c_bypass_low          : INTEGER := 0;
      c_sync_enable         : INTEGER := 0;--c_override;
      c_sync_priority       : INTEGER := 1;--c_clear;
      c_pipe_stages         : INTEGER := 0;
      c_has_s               : INTEGER := 0;
      c_has_c_in            : INTEGER := 1;
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
      c_has_b_signed        : INTEGER := 0;
      c_has_aclr            : INTEGER := 0;
      c_has_aset            : INTEGER := 0;
      c_has_ainit           : INTEGER := 0;
      c_has_sclr            : INTEGER := 0;
      c_has_sset            : INTEGER := 0;
      c_has_sinit           : INTEGER := 0;
      c_has_bypass_with_cin : INTEGER := 0;
      c_enable_rlocs        : INTEGER := 0;
      c_use_infered_rtl     : INTEGER := 0
      );
    PORT (
      b        : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
      clk      : IN  STD_LOGIC                              := '0';  -- clock
      add      : IN  STD_LOGIC                              := '1';
      ovfl     : OUT STD_LOGIC;
      q_ovfl   : OUT STD_LOGIC;
      c_in     : IN  STD_LOGIC                              := '0';  -- carry in
      c_out    : OUT STD_LOGIC;
      q_c_out  : OUT STD_LOGIC;
      b_in     : IN  STD_LOGIC                              := '0';  -- borrow in
      b_out    : OUT STD_LOGIC;
      q_b_out  : OUT STD_LOGIC;
      ce       : IN  STD_LOGIC                              := '1';  -- clock enable
      b_signed : IN  STD_LOGIC                              := '0';
      bypass   : IN  STD_LOGIC                              := '0';  -- sync load of b into reg
      aclr     : IN  STD_LOGIC                              := '0';  -- asynch init.
      aset     : IN  STD_LOGIC                              := '0';  -- asynch set.
      ainit    : IN  STD_LOGIC                              := '0';  -- asynch init.
      sclr     : IN  STD_LOGIC                              := '0';  -- synch init.
      sset     : IN  STD_LOGIC                              := '0';  -- synch set.
      sinit    : IN  STD_LOGIC                              := '0';  -- synch init.
      s        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit);
      q        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit)  -- synch output value
      );

  END COMPONENT;

end c_accum_v9_1_xst_comp;

