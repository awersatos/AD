-- $RCSfile: mult_gen_v8_0_services.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:44 $
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.parm_v8_0_services.ALL;
USE XilinxCoreLib.ccm_v8_0_services.ALL;
USE XilinxCoreLib.mult_gen_const_pkg_v8_0.ALL;
--USE XilinxCoreLib.sqm_v8_0_services.ALL;

PACKAGE mult_gen_v8_0_services IS

  -- See below for a description of each function

  FUNCTION get_mult_gen_v8_0_latency(c_family         : STRING;
                                     c_a_width        : INTEGER;
                                     c_b_width        : INTEGER;
                                     c_b_type         : INTEGER;
                                     c_has_a_signed   : INTEGER;
                                     c_reg_a_b_inputs : INTEGER;
                                     c_mem_type       : INTEGER;
                                     c_pipeline       : INTEGER;
                                     c_mult_type      : INTEGER;
                                     c_has_loadb      : INTEGER;
                                     c_baat           : INTEGER;
                                     c_b_value        : STRING;
                                     c_a_type         : INTEGER;
                                     c_has_swapb      : INTEGER;
                                     c_sqm_type       : INTEGER;
                                     c_has_aclr       : INTEGER;
                                     c_has_sclr       : INTEGER;
                                     c_has_ce         : INTEGER;
                                     c_sync_enable    : INTEGER;
                                     c_has_nd         : INTEGER;
                                     c_has_q          : INTEGER;
                                     bram_addr_width  : INTEGER) RETURN INTEGER;

  FUNCTION get_mult_gen_v8_0_latency_q(c_family         : STRING;
                                       c_a_width        : INTEGER;
                                       c_b_width        : INTEGER;
                                       c_b_type         : INTEGER;
                                       c_has_a_signed   : INTEGER;
                                       c_reg_a_b_inputs : INTEGER;
                                       c_mem_type       : INTEGER;
                                       c_pipeline       : INTEGER;
                                       c_mult_type      : INTEGER;
                                       c_has_loadb      : INTEGER;
                                       c_baat           : INTEGER;
                                       c_b_value        : STRING;
                                       c_a_type         : INTEGER;
                                       c_has_swapb      : INTEGER;
                                       c_sqm_type       : INTEGER;
                                       c_has_aclr       : INTEGER;
                                       c_has_sclr       : INTEGER;
                                       c_has_ce         : INTEGER;
                                       c_sync_enable    : INTEGER;
                                       c_has_nd         : INTEGER;
                                       bram_addr_width  : INTEGER;
                                       c_has_q          : INTEGER) RETURN INTEGER;

  
  FUNCTION get_mult_gen_v8_0_registers(c_family         : STRING;
                                       c_a_width        : INTEGER;
                                       c_b_width        : INTEGER;
                                       c_b_type         : INTEGER;
                                       c_has_a_signed   : INTEGER;
                                       c_reg_a_b_inputs : INTEGER;
                                       c_mem_type       : INTEGER;
                                       c_pipeline       : INTEGER;
                                       c_mult_type      : INTEGER;
                                       c_has_loadb      : INTEGER;
                                       c_baat           : INTEGER;
                                       c_b_value        : STRING;
                                       c_a_type         : INTEGER;
                                       c_has_swapb      : INTEGER;
                                       c_sqm_type       : INTEGER;
                                       c_has_aclr       : INTEGER;
                                       c_has_sclr       : INTEGER;
                                       c_has_ce         : INTEGER;
                                       c_sync_enable    : INTEGER;
                                       c_has_nd         : INTEGER;
                                       c_has_q          : INTEGER;
                                       bram_addr_width  : INTEGER
                                       ) RETURN INTEGER;

  FUNCTION get_bram_addr_width(family : STRING) RETURN INTEGER;
  
END mult_gen_v8_0_services;

PACKAGE BODY mult_gen_v8_0_services IS

-------------------------------------------------------------------------------
-- Calls calc_latency function, which is defined within the sqm_pack_v7_0 package.
-- Inputs:

  FUNCTION get_mult_gen_v8_0_latency(c_family         : STRING;
                                     c_a_width        : INTEGER;
                                     c_b_width        : INTEGER;
                                     c_b_type         : INTEGER;
                                     c_has_a_signed   : INTEGER;
                                     c_reg_a_b_inputs : INTEGER;
                                     c_mem_type       : INTEGER;
                                     c_pipeline       : INTEGER;
                                     c_mult_type      : INTEGER;
                                     c_has_loadb      : INTEGER;
                                     c_baat           : INTEGER;
                                     c_b_value        : STRING;
                                     c_a_type         : INTEGER;
                                     c_has_swapb      : INTEGER;
                                     c_sqm_type       : INTEGER;
                                     c_has_aclr       : INTEGER;
                                     c_has_sclr       : INTEGER;
                                     c_has_ce         : INTEGER;
                                     c_sync_enable    : INTEGER;
                                     c_has_nd         : INTEGER;
                                     c_has_q          : INTEGER;
                                     bram_addr_width  : INTEGER
                                     ) RETURN INTEGER IS

    VARIABLE latency      : INTEGER;
    VARIABLE c_b_constant : INTEGER;

  BEGIN

    IF (c_has_loadb = 0) THEN
      c_b_constant := 1;
    ELSE
      c_b_constant := 0;
    END IF;

    IF (c_baat = c_a_width) THEN
      -- non sqm multiplier
      IF (c_mult_type = PARALLEL OR c_mult_type = V2_PARALLEL OR c_mult_type = V4_PARALLEL OR c_mult_type = HYBRID) THEN
        -- parm_v7_0 based multiplier
        latency := get_parm_v8_0_latency(c_family, c_mult_type, c_a_width, c_a_type, c_b_width,
                                         c_b_type, c_reg_a_b_inputs, c_pipeline,
                                         c_has_aclr, c_has_sclr, c_has_ce,
                                         c_sync_enable, c_has_a_signed, c_has_nd, c_has_q);
      ELSE
        --ccm_v7_0 based multiplier
        latency :=
          get_ccm_v8_0_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                               c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                               c_b_constant, c_b_type, c_b_value, c_b_width);
      END IF;

    ELSE
      --sqm based multiplier

      ASSERT false REPORT "ERROR: mult_gen_v8_0_services: SQM not available in version 8.0" SEVERITY failure;

--      latency := get_sqm_v8_0_latency(c_reg_a_b_inputs, c_sqm_type, c_baat, c_mult_type,
--                                      c_pipeline, c_a_width, c_has_a_signed, c_a_type,
--                                      c_has_swapb, c_mem_type, bram_addr_width, c_b_width,
--                                      c_has_loadb, c_b_type, c_has_aclr,
--                                      c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, c_b_value); 

    END IF;

    RETURN latency;

  END get_mult_gen_v8_0_latency;

  -- Calls calc_latency function, which is defined within the sqm_pack_v7_0 package.
  -- This function differs from the one above in that it has a c_has_q input. This 
  -- adds an extra cycle of latency if the output is registered.
-- Inputs:

  FUNCTION get_mult_gen_v8_0_latency_q(c_family         : STRING;
                                       c_a_width        : INTEGER;
                                       c_b_width        : INTEGER;
                                       c_b_type         : INTEGER;
                                       c_has_a_signed   : INTEGER;
                                       c_reg_a_b_inputs : INTEGER;
                                       c_mem_type       : INTEGER;
                                       c_pipeline       : INTEGER;
                                       c_mult_type      : INTEGER;
                                       c_has_loadb      : INTEGER;
                                       c_baat           : INTEGER;
                                       c_b_value        : STRING;
                                       c_a_type         : INTEGER;
                                       c_has_swapb      : INTEGER;
                                       c_sqm_type       : INTEGER;
                                       c_has_aclr       : INTEGER;
                                       c_has_sclr       : INTEGER;
                                       c_has_ce         : INTEGER;
                                       c_sync_enable    : INTEGER;
                                       c_has_nd         : INTEGER;
                                       bram_addr_width  : INTEGER;
                                       c_has_q          : INTEGER
                                       ) RETURN INTEGER IS

    VARIABLE latency      : INTEGER;
    VARIABLE c_b_constant : INTEGER;

  BEGIN

    IF (c_has_loadb = 0) THEN
      c_b_constant := 1;
    ELSE
      c_b_constant := 0;
    END IF;

    IF (c_baat = c_a_width) THEN
      -- non sqm multiplier
      IF (c_mult_type = PARALLEL OR c_mult_type = V2_PARALLEL OR c_mult_type = V4_PARALLEL OR c_mult_type = HYBRID) THEN
        -- parm_v8_0 based multiplier
        latency := get_parm_v8_0_latency(c_family, c_mult_type, c_a_width, c_a_type, c_b_width,
                                         c_b_type, c_reg_a_b_inputs, c_pipeline,
                                         c_has_aclr, c_has_sclr, c_has_ce,
                                         c_sync_enable, c_has_a_signed, c_has_nd, c_has_q);
      ELSE
        --ccm_v8_0 based multiplier
        latency :=
          get_ccm_v8_0_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                               c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                               c_b_constant, c_b_type, c_b_value, c_b_width);
      END IF;

    ELSE
      --sqm based multiplier

      ASSERT false REPORT "ERROR: mult_gen_v8_0_services: SQM not available in version 8.0" SEVERITY failure;

--      latency := get_sqm_v8_0_latency(c_reg_a_b_inputs, c_sqm_type, c_baat, c_mult_type,
--                                      c_pipeline, c_a_width, c_has_a_signed, c_a_type,
--                                      c_has_swapb, c_mem_type, bram_addr_width, c_b_width,
--                                      c_has_loadb, c_b_type, c_has_aclr,
--                                      c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, c_b_value); 

    END IF;

    IF c_has_q = 1 THEN
      latency := latency+1;
    END IF;

    RETURN latency;

  END get_mult_gen_v8_0_latency_q;


  -- Latency function for the behavioural model. This returns the number of register 
  -- levels in the design.
  FUNCTION get_mult_gen_v8_0_registers(c_family         : STRING;
                                       c_a_width        : INTEGER;
                                       c_b_width        : INTEGER;
                                       c_b_type         : INTEGER;
                                       c_has_a_signed   : INTEGER;
                                       c_reg_a_b_inputs : INTEGER;
                                       c_mem_type       : INTEGER;
                                       c_pipeline       : INTEGER;
                                       c_mult_type      : INTEGER;
                                       c_has_loadb      : INTEGER;
                                       c_baat           : INTEGER;
                                       c_b_value        : STRING;
                                       c_a_type         : INTEGER;
                                       c_has_swapb      : INTEGER;
                                       c_sqm_type       : INTEGER;
                                       c_has_aclr       : INTEGER;
                                       c_has_sclr       : INTEGER;
                                       c_has_ce         : INTEGER;
                                       c_sync_enable    : INTEGER;
                                       c_has_nd         : INTEGER;
                                       c_has_q          : INTEGER;
                                       bram_addr_width  : INTEGER
                                       ) RETURN INTEGER IS

    VARIABLE latency      : INTEGER;
    VARIABLE c_b_constant : INTEGER;
    VARIABLE sqm_serial   : INTEGER;

  BEGIN

    IF (c_has_loadb = 0) THEN
      c_b_constant := 1;
    ELSE
      c_b_constant := 0;
    END IF;

    IF (c_reg_a_b_inputs = 1 AND c_sqm_type = 1) THEN
      sqm_serial := 1;
    ELSE
      sqm_serial := 0;
    END IF;

    IF (c_baat = c_a_width) THEN
      -- non sqm multiplier
      IF (c_mult_type = PARALLEL OR c_mult_type = V2_PARALLEL OR c_mult_type = V4_PARALLEL OR c_mult_type = HYBRID) THEN
        -- parm_v8_0 based multiplier
        latency := get_parm_v8_0_latency(c_family, c_mult_type, c_a_width, c_a_type, c_b_width,
                                         c_b_type, c_reg_a_b_inputs, c_pipeline,
                                         c_has_aclr, c_has_sclr, c_has_ce,
                                         c_sync_enable, c_has_a_signed, c_has_nd, c_has_q);
      ELSE
        --ccm_v8_0 based multiplier
        latency :=
          get_ccm_v8_0_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                               c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                               c_b_constant, c_b_type, c_b_value, c_b_width);
      END IF;

    ELSE
      --sqm based multiplier

      ASSERT false REPORT "ERROR: mult_gen_v8_0_services: SQM not available in version 8.0" SEVERITY failure;

--      latency := get_sqm_v8_0_latency(c_reg_a_b_inputs, c_sqm_type, c_baat, c_mult_type,
--                                      c_pipeline, c_a_width, c_has_a_signed, c_a_type,
--                                      c_has_swapb, c_mem_type, bram_addr_width, c_b_width,
--                                      c_has_loadb, c_b_type, c_has_aclr,
--                                      c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, c_b_value)
--                 - sqm_serial - calc_clocks(c_a_width, c_baat) - 1;
      
    END IF;

    RETURN latency;

  END get_mult_gen_v8_0_registers;

  -- purpose: returns the width of the BRAM address port for a particular device family
  FUNCTION get_bram_addr_width (family : STRING) RETURN INTEGER IS
  BEGIN  -- FUNCTION fn_get_bram_addr_width(family)
    IF family = "virtex2" OR family = "spartan3" OR family = "virtex4" THEN
      RETURN 9;
    ELSE
      RETURN 8;
    END IF;
  END FUNCTION get_bram_addr_width;
  
END mult_gen_v8_0_services;
