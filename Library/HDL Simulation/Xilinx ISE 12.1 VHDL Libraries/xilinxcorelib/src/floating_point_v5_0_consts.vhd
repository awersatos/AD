-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 5.0
--  \   \        Filename: $RCSfile: floating_point_v5_0_consts.vhd,v $           
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:54 $ 
-- /___/   /\    Date Created: Dec 2005
-- \   \  /  \
--  \___\/\___\
-- 
--Device  : All
--Library : xilinxcorelib.floating_point_v5_0_consts
--Purpose : Floating-point generic defaults and useful constants
--Revision History:
--  22 Apr 05 : Created.
--------------------------------------------------------------------------------    
--  (c) Copyright 2005-2009 Xilinx, Inc. All rights reserved.
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

package floating_point_v5_0_consts is

--------------------------------------------------------------------------------
-- Useful constants
--------------------------------------------------------------------------------
  constant FLT_PT_MAX_W                    : integer := 128;

  -- Use to set generics with logical values
  constant FLT_PT_YES                      : integer := 1;
  constant FLT_PT_NO                       : integer := 0;
  constant FLT_PT_TRUE                     : integer := 1;
  constant FLT_PT_FALSE                    : integer := 0;
  
  -- C_OPTIMIZED settings 
  constant FLT_PT_SPEED_OPTIMIZED          : integer := 1;
  constant FLT_PT_LOW_LATENCY              : integer := 2;

  -- C_MULT_USAGE options
  constant FLT_PT_NO_USAGE                 : integer := 0;
  constant FLT_PT_MEDIUM_USAGE             : integer := 1;
  constant FLT_PT_FULL_USAGE               : integer := 2;
  constant FLT_PT_MAX_USAGE                : integer := 3;

  -- C_LATENCY options (at present both options result in
  -- the same core)
  constant FLT_PT_MAX_LATENCY              : integer := 1000;

  -- C_SPEED
  constant FLT_PT_AREA                     : integer := 0;
  constant FLT_PT_AREA_SPEED               : integer := 1;
  constant FLT_PT_SPEED                    : integer := 2;

  -- Op-code format
  -- <cmp_mode        ><cmp op  >
  -- <rnd mode><ext_op>< prim op>
  constant FLT_PT_STATUS_WIDTH             : integer := 5;
  constant FLT_PT_OP_CODE_WIDTH            : integer := 3;
  constant FLT_PT_COMPARE_OPERATION_WIDTH  : integer := 3;
  constant FLT_PT_ROUND_MODE_WIDTH         : integer := 2;

  constant FLT_PT_OPERATION_WIDTH          : integer :=
    FLT_PT_OP_CODE_WIDTH+FLT_PT_COMPARE_OPERATION_WIDTH;
--------------------------------------------------------------------------------
-- Type declarations to enable operation bits to be addressed
--------------------------------------------------------------------------------
  subtype  FLT_PT_OP_CODE_SLICE            is integer range
    FLT_PT_OP_CODE_WIDTH - 1 downto 0;
  subtype  FLT_PT_COMPARE_OPERATION_SLICE  is integer range
    FLT_PT_COMPARE_OPERATION_WIDTH+FLT_PT_OP_CODE_WIDTH-1 downto
    FLT_PT_OP_CODE_WIDTH;
  subtype  FLT_PT_ROUND_MODE_SLICE         is integer range
     FLT_PT_ROUND_MODE_WIDTH + FLT_PT_OP_CODE_WIDTH downto
     FLT_PT_OP_CODE_WIDTH+1;
  constant FLT_PT_SPECIAL_SLICE            : integer:=FLT_PT_OP_CODE_WIDTH;


  -- C_COMPARE_OPERATION options
  constant FLT_PT_PROGRAMMABLE             : integer := 8;
  constant FLT_PT_UNORDERED                : integer := 0;
  constant FLT_PT_LESS_THAN                : integer := 1;
  constant FLT_PT_EQUAL                    : integer := 2;
  constant FLT_PRT_LESS_THAN_OR_EQUAL      : integer := 3;
  constant FLT_PT_GREATER_THAN             : integer := 4;
  constant FLT_PT_NOT_EQUAL                : integer := 5;
  constant FLT_PT_GREATER_THAN_OR_EQUAL    : integer := 6;
  constant FLT_PT_CONDITION_CODE           : integer := 7;

  constant FLT_PT_UNORDERED_SLV            :
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "000";
  constant FLT_PT_LESS_THAN_SLV             :
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "001";
  constant FLT_PT_EQUAL_SLV                :
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "010";
  constant FLT_PRT_LESS_THAN_OR_EQUAL_SLV  :
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "011";
  constant FLT_PT_GREATER_THAN_SLV         :
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "100";
  constant FLT_PT_NOT_EQUAL_SLV            :
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "101";  
  constant FLT_PT_GREATER_THAN_OR_EQUAL_SLV:
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "110";
--------------------------------------------------------------------------------
-- Other useful constants
-------------------------------------------------------------------------------- 
-- Integer values for operation codes
--------------------------------------------------------------------------------
  constant FLT_PT_ADD_OP_CODE              : integer := 0;
  constant FLT_PT_SUBTRACT_OP_CODE         : integer := 1; 
  constant FLT_PT_MULTIPLY_OP_CODE         : integer := 2; 
  constant FLT_PT_DIVIDE_OP_CODE           : integer := 3; 
  constant FLT_PT_COMPARE_OP_CODE          : integer := 4; 
  constant FLT_PT_FLT_TO_FIX_OP_CODE       : integer := 5; 
  constant FLT_PT_FIX_TO_FLT_OP_CODE       : integer := 6;
  constant FLT_PT_SQRT_OP_CODE             : integer := 7;
  constant FLT_PT_FLT_TO_FLT_OP_CODE       : integer := 15; 
    
  constant FLT_PT_ADD_OP_CODE_SLV          : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "000";
  constant FLT_PT_SUBTRACT_OP_CODE_SLV     : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "001"; 
  constant FLT_PT_MULTIPLY_OP_CODE_SLV     : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "010"; 
  constant FLT_PT_DIVIDE_OP_CODE_SLV       : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "011"; 
  constant FLT_PT_COMPARE_OP_CODE_SLV      : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "100"; 
  constant FLT_PT_FLT_TO_FIX_OP_CODE_SLV   : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "101";
  -- The following are not yet supported 
  constant FLT_PT_FIX_TO_FLT_OP_CODE_SLV   : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "110";
  constant FLT_PT_SQRT_FTF_OP_CODE_SLV         : 
    std_logic_vector(FLT_PT_OP_CODE_WIDTH - 1 downto 0) := "111";
  
  -- Note that only round to nearest even mode currently supported  by core.
  constant FLT_PT_RND_TO_NEAREST_EVEN_SLV   :
    std_logic_vector(FLT_PT_ROUND_MODE_WIDTH-1 downto 0) := "00";
  constant FLT_PT_RND_TO_ZERO_SLV           :
    std_logic_vector(FLT_PT_ROUND_MODE_WIDTH-1 downto 0) := "01";
  constant FLT_PT_RND_TO_POS_INF_SLV        :
    std_logic_vector(FLT_PT_ROUND_MODE_WIDTH-1 downto 0) := "10";
  constant FLT_PT_RND_TO_NEG_INF_SLV        :
    std_logic_vector(FLT_PT_ROUND_MODE_WIDTH-1 downto 0) := "11";

  constant FLT_PT_RND_TO_NEAREST_EVEN       : integer := 0;
  constant FLT_PT_RND_TO_ZERO               : integer := 1;
  constant FLT_PT_RND_TO_POS_INF            : integer := 2;
  constant FLT_PT_RND_TO_NEG_INF            : integer := 3;
  constant FLT_PT_IEEE_MODES                : integer := 4;
             
--------------------------------------------------------------------------------
-- Default values for generics
--------------------------------------------------------------------------------
-- These generic values can be changed:
--------------------------------------------------------------------------------
  constant C_XDEVICEFAMILY_DEFAULT         : string  := "virtex4";
  constant C_HAS_ADD_DEFAULT               : integer := FLT_PT_FALSE;
  constant C_HAS_SUBTRACT_DEFAULT          : integer := FLT_PT_FALSE;
  constant C_HAS_MULTIPLY_DEFAULT          : integer := FLT_PT_FALSE;
  constant C_HAS_DIVIDE_DEFAULT            : integer := FLT_PT_FALSE;
  constant C_HAS_SQRT_DEFAULT              : integer := FLT_PT_FALSE;
  constant C_HAS_COMPARE_DEFAULT           : integer := FLT_PT_FALSE;
  constant C_HAS_FIX_TO_FLT_DEFAULT        : integer := FLT_PT_FALSE;
  constant C_HAS_FLT_TO_FIX_DEFAULT        : integer := FLT_PT_FALSE;
  constant C_HAS_FLT_TO_FLT_DEFAULT        : integer := FLT_PT_FALSE;
  constant C_A_WIDTH_DEFAULT               : integer := 32;
  constant C_A_FRACTION_WIDTH_DEFAULT      : integer := 24;
  constant C_B_WIDTH_DEFAULT               : integer := 32;
  constant C_B_FRACTION_WIDTH_DEFAULT      : integer := 24;
  constant C_RESULT_WIDTH_DEFAULT          : integer := 32;
  constant C_RESULT_FRACTION_WIDTH_DEFAULT : integer := 24;
  constant C_COMPARE_OPERATION_DEFAULT     : integer := FLT_PT_LESS_THAN;
  constant C_LATENCY_DEFAULT               : integer := FLT_PT_MAX_LATENCY;
  constant C_OPTIMIZATION_DEFAULT          : integer := FLT_PT_SPEED_OPTIMIZED;
  constant C_MULT_USAGE_DEFAULT            : integer := FLT_PT_FULL_USAGE;
  constant C_HAS_SCLR_DEFAULT              : integer := FLT_PT_FALSE;
  constant C_HAS_OPERATION_ND_DEFAULT      : integer := FLT_PT_FALSE;
  constant C_HAS_OPERATION_RFD_DEFAULT     : integer := FLT_PT_FALSE;
  constant C_HAS_RDY_DEFAULT               : integer := FLT_PT_FALSE;
  constant C_HAS_UNDERFLOW_DEFAULT         : integer := FLT_PT_FALSE;
  constant C_HAS_OVERFLOW_DEFAULT          : integer := FLT_PT_FALSE;
  constant C_HAS_INVALID_OP_DEFAULT        : integer := FLT_PT_FALSE;
  constant C_HAS_DIVIDE_BY_ZERO_DEFAULT    : integer := FLT_PT_FALSE;
  constant C_RATE_DEFAULT                  : integer := 1;
  constant C_HAS_CE_DEFAULT                : integer := FLT_PT_FALSE;
  constant C_SPEED_DEFAULT                 : integer := FLT_PT_SPEED;
--------------------------------------------------------------------------------  
-- These generic values cannot be changed at present.
--------------------------------------------------------------------------------  
  constant C_HAS_ACLR_DEFAULT              : integer := FLT_PT_NO;
  constant C_HAS_A_NEGATE_DEFAULT          : integer := FLT_PT_NO;
  constant C_HAS_B_NEGATE_DEFAULT          : integer := FLT_PT_NO;
  constant C_HAS_A_ND_DEFAULT              : integer := FLT_PT_NO;
  constant C_HAS_A_RFD_DEFAULT             : integer := FLT_PT_NO;
  constant C_HAS_B_ND_DEFAULT              : integer := FLT_PT_NO;
  constant C_HAS_B_RFD_DEFAULT             : integer := FLT_PT_NO;  
  constant C_HAS_CTS_DEFAULT               : integer := FLT_PT_NO;  
  constant C_HAS_STATUS_DEFAULT            : integer := FLT_PT_NO;
  constant C_STATUS_EARLY_DEFAULT          : integer := FLT_PT_NO;
  constant C_HAS_EXCEPTION_DEFAULT         : integer := FLT_PT_NO; 
  constant C_HAS_INEXACT_DEFAULT           : integer := FLT_PT_NO;
--------------------------------------------------------------------------------  
-- These generic values cannot be changed at present.
--------------------------------------------------------------------------------  
  constant FLT_PT_ONE  : std_logic_vector(FLT_PT_MAX_W-1 downto 0) := (others=>'1');
  constant FLT_PT_ZERO : std_logic_vector(FLT_PT_MAX_W-1 downto 0) := (others=>'0');
  
  -- Multiplier types supported by family
  
  constant FLT_PT_LOGIC          : integer := 0;
  constant FLT_PT_MULT18X18S     : integer := 1;  
  constant FLT_PT_DSP48          : integer := 2;
  constant FLT_PT_DSP48E         : integer := 3;
  constant FLT_PT_DSP48A         : integer := 4; 
  constant FLT_PT_DSP48E_SPD_SGL : integer := 5;  
  constant FLT_PT_DSP48E_SPD_DBL : integer := 6;
  constant FLT_PT_DSP48E_LAT_SGL : integer := 7;  
  constant FLT_PT_DSP48E_LAT_DBL : integer := 8;
  
  -- Other types for flt_round
  constant FLT_PT_DSP_OPT        : integer := 9; 

  -- MULT_USAGE offset to enable v2.0 multipliers to be obtained (unsupported feature) 
  constant FLT_PT_QQ_OFFSET    : integer := 10;
  constant FLT_PT_CARRY_LENGTH : integer := 17;
end package floating_point_v5_0_consts;







