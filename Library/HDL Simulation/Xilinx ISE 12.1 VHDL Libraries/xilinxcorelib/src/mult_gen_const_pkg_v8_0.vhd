-- $RCSfile: mult_gen_const_pkg_v8_0.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:44 $
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
-- Filename:  mult_const_pkg_v8_0.vhd
--      
-- Description:  
--      This package lists all the constants used in the 
--      multiplier cores 
----------------------------------------------------------------------------

PACKAGE mult_gen_const_pkg_v8_0 IS

  CONSTANT DEFAULT_FAMILY        : STRING := "not_set";
  CONSTANT DEFAULT_XDEVICEFAMILY : STRING := "not_set";

  CONSTANT A_MIN_WIDTH     : INTEGER := 1;
  CONSTANT A_MAX_WIDTH     : INTEGER := 64;
  CONSTANT A_DEFAULT_WIDTH : INTEGER := 18;

  CONSTANT B_MIN_WIDTH     : INTEGER := 1;
  CONSTANT B_MAX_WIDTH     : INTEGER := 64;
  CONSTANT B_DEFAULT_WIDTH : INTEGER := 18;

  CONSTANT OUT_MIN_WIDTH     : INTEGER := 1;
  CONSTANT OUT_MAX_WIDTH     : INTEGER := 129;
  CONSTANT OUT_DEFAULT_WIDTH : INTEGER := 36;

  CONSTANT DEFAULT_TYPE : INTEGER := 0;  -- c_signed

  CONSTANT DEFAULT_CONSTANT_B : INTEGER := 0;

  CONSTANT DEFAULT_CONSTANT_B_VAL : STRING  := "0000000000000001";
  CONSTANT DEFAULT_A_TYPE         : INTEGER := 0;  -- c_signed
  CONSTANT DEFAULT_B_TYPE         : INTEGER := 0;  -- c_signed
  CONSTANT DEFAULT_OUTPUT_HOLD    : INTEGER := 0;

  CONSTANT DEFAULT_HAS_O : INTEGER := 0;  -- non-registered
  CONSTANT DEFAULT_HAS_Q : INTEGER := 1;  -- registered

  CONSTANT DEFAULT_REG_A_B_INPUTS : INTEGER := 1;  -- inputs A, B registered

  CONSTANT DEFAULT_HAS_ACLR : INTEGER := 0;  -- default : no aclr pin
  CONSTANT DEFAULT_HAS_SCLR : INTEGER := 0;  -- default : no sclr pin

  CONSTANT DEFAULT_HAS_CE       : INTEGER := 0;  -- default : no ce pin
  CONSTANT DEFAULT_HAS_A_SIGNED : INTEGER := 0;  -- default : no a_signed pin

  CONSTANT DEFAULT_ENABLE_RLOCS : INTEGER := 1;  -- default : RLOCS enabled
  CONSTANT DEFAULT_HAS_LOADB    : INTEGER := 0;  -- default : no LOADB pin

  CONSTANT DEFAULT_HAS_LOAD_DONE : INTEGER := 0;  -- default : no LOAD_DONE pin
  CONSTANT DEFAULT_HAS_SWAPB     : INTEGER := 0;  -- default : no SWAPB pin

  -----------------------------------------------------------------------------
  -- symbolic public variables for the MULT_TYPE
  CONSTANT PARALLEL     : INTEGER := 0;  -- ip var: c_parallel
  CONSTANT V2_PARALLEL  : INTEGER := 1;  -- ip_var: c_v2_parallel
  CONSTANT CCM          : INTEGER := 2;  -- ip_var: c_ccm
  CONSTANT STATIC_RCCM  : INTEGER := 3;  -- ip_var: c_static_rccm
  CONSTANT DYNAMIC_RCCM : INTEGER := 4;  -- ip_var: c_dynamic_rccm
  CONSTANT V4_PARALLEL  : INTEGER := 5;
  CONSTANT HYBRID       : INTEGER := 6;

  CONSTANT DEFAULT_MULT_TYPE : INTEGER := PARALLEL;  -- default: parallel multiplier, c_parallel
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- symbolic public variables for MEM_TYPE
  CONSTANT C_DISTRIBUTED : INTEGER := 0;  -- ip var: c_distributed
  CONSTANT C_SP_BLOCK    : INTEGER := 1;  -- ip var: c_sp_block
  CONSTANT C_DP_BLOCK    : INTEGER := 2;  -- ip var: c_dp_block

  CONSTANT DEFAULT_MEM_TYPE : INTEGER := C_DISTRIBUTED;  -- default, DISTRIBUTED MEM or c_distributed
  -----------------------------------------------------------------------------

  CONSTANT DEFAULT_BAAT : INTEGER := 18;  -- one clock cycle processing by default

  CONSTANT DEFAULT_PIPELINED : INTEGER := 0;  -- default: not pipelines

  CONSTANT DEFAULT_LATENCY : INTEGER := 1;  -- default: latency = 1

  CONSTANT DEFAULT_HAS_RDY : INTEGER := 0;  -- default : no RDY signal

  CONSTANT DEFAULT_HAS_RFD : INTEGER := 0;  -- default : no RFD signal

  CONSTANT DEFAULT_HAS_ND   : INTEGER := 0;  -- default: no data
  CONSTANT DEFAULT_HAS_BUSY : INTEGER := 1;  -- default: busy enabled.

  CONSTANT DEFAULT_SYNC_ENABLE : INTEGER := 0;

  CONSTANT DEFAULT_MEM_INIT_PREFIX : STRING := "mgv8";
  
END mult_gen_const_pkg_v8_0;
