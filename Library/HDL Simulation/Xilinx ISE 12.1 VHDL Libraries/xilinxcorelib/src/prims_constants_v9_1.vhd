-- $RCSfile: prims_constants_v9_1.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:39 $
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
--
-- Filename - prims_constants_v9_1.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains the type declarations for
--                               baseblocks primitives enumerated types for generic parameters.

PACKAGE prims_constants_v9_1 IS

  CONSTANT c_set   : INTEGER := 0;
  CONSTANT c_clear : INTEGER := 1;

  CONSTANT c_override    : INTEGER := 0;
  CONSTANT c_no_override : INTEGER := 1;

  CONSTANT c_signed   : INTEGER := 0;
  CONSTANT c_unsigned : INTEGER := 1;
  CONSTANT c_pin      : INTEGER := 2;

  --T_REG_TYPE
  CONSTANT c_reg_undefined : INTEGER := 0;  -- to match java code
  CONSTANT c_reg_fd        : INTEGER := 1;  -- a flipflop
  CONSTANT c_reg_ld        : INTEGER := 2;  -- a latch

  CONSTANT c_add     : INTEGER := 0;
  CONSTANT c_sub     : INTEGER := 1;
  CONSTANT c_add_sub : INTEGER := 2;

  CONSTANT c_and  : INTEGER := 0;
  CONSTANT c_nand : INTEGER := 1;
  CONSTANT c_or   : INTEGER := 2;
  CONSTANT c_nor  : INTEGER := 3;
  CONSTANT c_xor  : INTEGER := 4;
  CONSTANT c_xnor : INTEGER := 5;
  CONSTANT c_inv  : INTEGER := 6;
  CONSTANT c_buf  : INTEGER := 7;

  -- These must match the c_add, c_sub and c_add_sub values respectively!
  CONSTANT c_up     : INTEGER := 0;
  CONSTANT c_down   : INTEGER := 1;
  CONSTANT c_updown : INTEGER := 2;

  -- For C_DIST_MEM...
  CONSTANT c_rom    : INTEGER := 0;
  CONSTANT c_sp_ram : INTEGER := 1;
  CONSTANT c_dp_ram : INTEGER := 2;
  CONSTANT c_srl16  : INTEGER := 3;

  CONSTANT c_single_port : INTEGER := 0;
  CONSTANT c_dual_port   : INTEGER := 1;

  CONSTANT c_lut_based  : INTEGER := 0;
  CONSTANT c_buft_based : INTEGER := 1;

  CONSTANT c_fixed             : INTEGER := 0;
  CONSTANT c_variable_lossless : INTEGER := 1;
  CONSTANT c_variable_lossy    : INTEGER := 2;

  CONSTANT c_lsb_to_msb    : INTEGER := 0;
  CONSTANT c_msb_to_lsb    : INTEGER := 1;
  CONSTANT c_bidirectional : INTEGER := 2;

  CONSTANT c_zeros : INTEGER := 0;
  CONSTANT c_ones  : INTEGER := 1;
  CONSTANT c_lsb   : INTEGER := 2;
  CONSTANT c_msb   : INTEGER := 3;
  CONSTANT c_wrap  : INTEGER := 4;
  CONSTANT c_sdin  : INTEGER := 5;

  -- For Shift RAM
  CONSTANT c_area : INTEGER := 0;
  CONSTANT c_speed : INTEGER := 1;
  
END prims_constants_v9_1;

