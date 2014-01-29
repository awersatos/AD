-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
--------------------------------------------------------------------------------
-- $Id: c_mac_v4_0_comp.vhd,v 1.12 2008/09/08 20:09:09 akennedy Exp $
--------------------------------------------------------------------------------
-- Unit     : mac_v4_0
-- Author   : Bill Allaire
-- Function : Component declarations
--------------------------------------------------------------------------------
-- Description
-- ===========
-- 
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v7_0.all;

PACKAGE mac_v4_0_comp IS
  COMPONENT mac_v4_0 
    GENERIC (c_clk_freq	     : real;
             c_auto_pipeline : boolean;
             c_mac_count     : integer;
             c_a_width       : integer;
	       c_a_type	     : integer;
             c_b_width       : integer;
             c_b_type        : integer;
             c_mac_result_width      : integer;
             c_round_operation       : integer;
             c_has_saturation        : boolean;
             c_clks_per_mult         : integer;
             c_use_embedded_mult     : boolean;
             c_limit_accum_height    : boolean;
             c_accum_height          : integer;
             c_has_clock_enable      : boolean;
             c_has_reset             : boolean;
             c_has_mult_input_reg    : boolean;
             c_has_mult_pipeline_reg : boolean;
             c_has_mult_output_reg   : boolean;
             c_has_output_reg        : boolean;
             c_enable_rlocs          : integer);
        PORT (a         : IN  std_logic_vector((c_a_width - 1) downto 0);
              b         : IN  std_logic_vector((c_b_width - 1) downto 0);
              q         : OUT std_logic_vector((c_mac_result_width - 1) downto 0);
              clk       : IN  std_logic;
              ce        : IN  std_logic;
              rst       : IN  std_logic;
              fd        : IN  std_logic;
              nd        : IN  std_logic;
              rdy       : OUT std_logic);
          END COMPONENT;
END mac_v4_0_comp;
