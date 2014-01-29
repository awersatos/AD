-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
----------------------------------------------------------------------------
-- Multiplier Generator Constants Package
-- June 21st 2001
----------------------------------------------------------------------------
-- Filename:  mult_const_pkg_v6_0.vhd
--      
-- Description:  
--      This package lists all the constants used in the 
--      multiplier cores 
----------------------------------------------------------------------------
-- Author:      Neil Ritchie (based on original packages by Restu Ismail)
-- History:
--      Neil    06/21/2001
----------------------------------------------------------------------------

library xilinxcorelib;
use xilinxcorelib.prims_constants_v6_0.all;

package mult_const_pkg_v6_0 is

   constant A_MIN_WIDTH     : integer := 1;
   constant A_MAX_WIDTH     : integer := 64;
   constant A_DEFAULT_WIDTH : integer := 16;

   constant B_MIN_WIDTH     : integer := 1;
   constant B_MAX_WIDTH     : integer := 64;
   constant B_DEFAULT_WIDTH : integer := 16;

   constant OUT_MIN_WIDTH     : integer := 1;
   constant OUT_MAX_WIDTH     : integer := 129;
   constant OUT_DEFAULT_WIDTH : integer := 32;

   constant DEFAULT_TYPE : integer := c_signed;

   constant DEFAULT_CONSTANT_B : integer := c_signed;

   constant DEFAULT_CONSTANT_B_VAL : string  := "0000000000000001";
   constant DEFAULT_A_TYPE         : integer := c_signed;
   constant DEFAULT_B_TYPE         : integer := c_signed;
   constant DEFAULT_OUTPUT_HOLD    : integer := 0;

   constant DEFAULT_HAS_0 : integer := 0;  -- not registered
   constant DEFAULT_HAS_Q : integer := 1;  -- registered

   constant DEFAULT_REG_A_B_INPUTS : integer := 1;  -- inputs A, B registered

   constant DEFAULT_HAS_ACLR : integer := 0;  -- default : no aclr pin
   constant DEFAULT_HAS_SCLR : integer := 0;  -- default : no sclr pin

   constant DEFAULT_HAS_CE       : integer := 0;  -- default : no ce pin
   constant DEFAULT_HAS_A_SIGNED : integer := 0;  -- default : no a_signed pin

   constant DEFAULT_ENABLE_RLOCS : integer := 1;  -- default : RLOCS enabled
   constant DEFAULT_HAS_LOADB    : integer := 0;  -- default : no LOADB pin

   constant DEFAULT_HAS_LOAD_DONE : integer := 0;  -- default : no LOAD_DONE pin
   constant DEFAULT_HAS_SWAPB     : integer := 0;  -- default : no SWAPB pin

   -- symbolic public variables for the MULT_TYPE
   constant PARALLEL     : integer := 0;  -- ip var: c_parallel
   constant V2_PARALLEL  : integer := 1;  -- ip_var: c_v2_parallel
   constant CCM          : integer := 2;  -- ip_var: c_ccm
   constant STATIC_RCCM  : integer := 3;  -- ip_var: c_static_rccm
   constant DYNAMIC_RCCM : integer := 4;  -- ip_var: c_dynamic_rccm

   constant DEFAULT_MULT_TYPE : integer := PARALLEL;  -- default: parallel multiplier, c_parallel

   -- symbolic public variables for MEM_TYPE
   constant c_distributed : integer := 0;  -- ip var: c_distributed
   constant c_sp_block    : integer := 1;  -- ip var: c_sp_block
   constant c_dp_block    : integer := 2;  -- ip var: c_dp_block

   constant DEFAULT_MEM_TYPE : integer := c_distributed;  -- default, DISTRIBUTED MEM or c_distributed

   constant DEFAULT_BAAT : integer := 16;  -- one clock cycle processing by default

   constant DEFAULT_PIPELINED : integer := 0;  -- default: not pipelines

   constant DEFAULT_LATENCY : integer := 1;  -- default: latency = 1

   constant DEFAULT_HAS_RDY : integer := 0;  -- default : no RDY signal

   constant DEFAULT_HAS_RFD : integer := 0;  -- default : no RFD signal

   constant DEFAULT_HAS_ND   : integer := 0;  -- default: no data
   constant DEFAULT_HAS_BUSY : integer := 1;  -- default: busy enabled.

   constant DEFAULT_SYNC_ENABLE : integer := 0;
   
end mult_const_pkg_v6_0;
