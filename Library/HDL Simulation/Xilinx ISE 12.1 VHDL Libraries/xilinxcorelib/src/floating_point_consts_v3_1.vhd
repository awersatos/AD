-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 3.0
--  \   \        Filename: $RCSfile: floating_point_consts_v3_1.vhd,v $           
--  /   /        Date Last Modified: $Date: 2008/09/09 20:27:02 $ 
-- /___/   /\    Date Created: Dec 2005
-- \   \  /  \
--  \___\/\___\
-- 
--Device  : All
--Library : xilinxcorelib.floating_point_consts
--Purpose : Floating-point generic defaults and useful constants
--Revision History:
--  22 Apr 05 : Created.
--------------------------------------------------------------------------------    
--  Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package floating_point_consts_v3_1 is
  
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
  constant FLT_PT_SPEED_OPTIMIZED 		       : integer := 1;
  constant FLT_PT_LOW_LATENCY              : integer := 2;
  
  -- C_MULT_USAGE options
  constant FLT_PT_NO_USAGE				             : integer := 0;
  constant FLT_PT_MEDIUM_USAGE		           : integer := 1;
  constant FLT_PT_FULL_USAGE			            : integer := 2;
  constant FLT_PT_MAX_USAGE			             : integer := 3;
    
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
  constant FLT_PT_ROUND_MODE_WIDTH         : integer := 1;
  
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
  constant FLT_PT_PROGRAMMABLE 		          : integer := 8;
  constant FLT_PT_UNORDERED                : integer := 0;
  constant FLT_PT_LESS_THAN	               : integer := 1;
  constant FLT_PT_EQUAL                    : integer := 2;
  constant FLT_PRT_LESS_THAN_OR_EQUAL	     : integer := 3;
  constant FLT_PT_GREATER_THAN             : integer := 4;
  constant FLT_PT_NOT_EQUAL                : integer := 5;
  constant FLT_PT_GREATER_THAN_OR_EQUAL    : integer := 6;
  constant FLT_PT_CONDITION_CODE           : integer := 7;
    
  constant FLT_PT_UNORDERED_SLV            : 
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "000";
  constant FLT_PT_LESS_THAN_SLV		          : 
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "001";  
  constant FLT_PT_EQUAL_SLV                : 
    std_logic_vector(FLT_PT_COMPARE_OPERATION_WIDTH - 1 downto 0) := "010";  
  constant FLT_PRT_LESS_THAN_OR_EQUAL_SLV	 :
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
        
  constant FLT_PT_RND_TO_NEAREST_EVEN      :
    std_logic_vector(FLT_PT_ROUND_MODE_WIDTH-1 downto 0) := "0";
  constant FLT_PT_RND_TO_ZERO              :
    std_logic_vector(FLT_PT_ROUND_MODE_WIDTH-1 downto 0) := "1";    

--------------------------------------------------------------------------------
-- Default values for generics
--------------------------------------------------------------------------------
-- These generic values can be changed:
--------------------------------------------------------------------------------
  constant C_FAMILY_DEFAULT                : string  := "virtex2";
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
  constant C_B_FRACTION_WIDTH_DEFAULT			   : integer := 24;
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
  constant C_HAS_UNDERFLOW_DEFAULT	        : integer := FLT_PT_FALSE;
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
  
  constant FLT_PT_LOGIC      : integer := 0;
  constant FLT_PT_MULT18X18S : integer := 1;  
  constant FLT_PT_DSP48      : integer := 2;
  constant FLT_PT_DSP48E     : integer := 3; 
  
  -- MULT_USAGE offset to enable v2.0 multipliers to be obtained (unsupported feature) 
  constant FLT_PT_QQ_OFFSET    : integer := 10;
  constant FLT_PT_CARRY_LENGTH : integer := 17;
end package floating_point_consts_v3_1;







