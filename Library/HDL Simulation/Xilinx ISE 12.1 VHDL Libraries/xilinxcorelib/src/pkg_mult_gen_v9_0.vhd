-- $RCSfile: pkg_mult_gen_v9_0.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:49 $
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
--  of this text at all times. (c) Copyright 2006 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_0.ALL;
USE XilinxCoreLib.prims_utils_v9_0.ALL;
USE XilinxCoreLib.pkg_baseblox_v9_0.ALL;

PACKAGE pkg_mult_gen_v9_0 IS

  -----------------------------------------------------------------------------
  -- Constants and functions for use all over the core
  -----------------------------------------------------------------------------

  -- enumerated constants for c_mult_type
  CONSTANT LUT           : INTEGER := 0;
  CONSTANT EMBEDDED_MULT : INTEGER := 1;
  CONSTANT FIXED_CCM     : INTEGER := 2;
  CONSTANT STATIC_RCCM   : INTEGER := 3;
  CONSTANT DYNAMIC_RCCM  : INTEGER := 4;

  -- enumerated constants for c_opt_goal
  CONSTANT EMB_MULT_RESOURCES : INTEGER := 0;
  CONSTANT CORE_SPEED         : INTEGER := 1;

  -- enumerated constants for the on/off pins e.g. CE, SCLR
  CONSTANT MG_NO  : INTEGER := 0;
  CONSTANT MG_YES : INTEGER := 1;

  -- enumerated constants for c_ccm_imp
  CONSTANT DIST_MEM : INTEGER := 0;
  CONSTANT BRAM     : INTEGER := 1;
  CONSTANT MULTS    : INTEGER := 2;
  CONSTANT CSD      : INTEGER := 3;

  -- default generics for all core components etc.
  CONSTANT DEF_C_XDEVICEFAMILY     : STRING  := "virtex4";
  CONSTANT DEF_C_A_WIDTH           : INTEGER := 18;
  CONSTANT DEF_C_A_TYPE            : INTEGER := 0;
  CONSTANT DEF_C_B_WIDTH           : INTEGER := 18;
  CONSTANT DEF_C_B_TYPE            : INTEGER := 0;
  CONSTANT DEF_C_OUT_HIGH          : INTEGER := 35;
  CONSTANT DEF_C_OUT_LOW           : INTEGER := 0;
  CONSTANT DEF_C_MULT_TYPE         : INTEGER := EMBEDDED_MULT;
  CONSTANT DEF_C_OPT_GOAL          : INTEGER := EMB_MULT_RESOURCES;
  CONSTANT DEF_C_HAS_CE            : INTEGER := MG_NO;
  CONSTANT DEF_C_HAS_SCLR          : INTEGER := MG_NO;
  CONSTANT DEF_C_CE_OVERRIDES_SCLR : INTEGER := MG_NO;
  CONSTANT DEF_C_PIPE_STAGES       : INTEGER := 1;
  CONSTANT DEF_C_CCM_IMP           : INTEGER := DIST_MEM;
  CONSTANT DEF_C_B_VALUE           : STRING  := "111111111111111111";
  CONSTANT DEF_C_ELABORATION_DIR   : STRING  := "./";
  CONSTANT DEF_C_HAS_LOAD_DONE     : INTEGER := MG_NO;
  CONSTANT DEF_C_HAS_ZERO_DETECT   : INTEGER := MG_NO;
  CONSTANT DEF_C_ROUND_OUTPUT      : INTEGER := MG_NO;
  CONSTANT DEF_C_ROUND_PT          : INTEGER := 0;
  CONSTANT DEF_C_MEM_INIT_PREFIX   : STRING  := "mgv9";

  CONSTANT PIPELINE_CFG_BREAKPT : INTEGER := 1000000000;

  CONSTANT MAX_PIPE_STAGES : INTEGER := 32;

  -- purpose: validates the generics for the whole core, traps any bad combinations
  FUNCTION check_generics(family                                                   : T_DEVICE_FAMILY;
                          i_family                                                 : STRING;
                          xdevicefamily                                            : STRING;
                          a_width, a_type, b_width, b_type                         : INTEGER;
                          out_high, out_low                                        : INTEGER;
                          mult_type, opt_goal                                      : INTEGER;
                          has_ce, has_sclr, ce_overrides_sclr                      : INTEGER;
                          pipe_stages, ccm_imp                                     : INTEGER;
                          b_value, elaboration_dir                                 : STRING;
                          has_load_done, has_zero_detect, round_output, c_round_pt : INTEGER) RETURN BOOLEAN;  
  
  FUNCTION sl_to_int(sl : STD_LOGIC) RETURN INTEGER;
  
END PACKAGE pkg_mult_gen_v9_0;

PACKAGE BODY pkg_mult_gen_v9_0 IS

  -- purpose: validates the generics for the whole core, traps any bad combinations
  FUNCTION check_generics(family                                                   : T_DEVICE_FAMILY;
                          i_family                                                 : STRING;
                          xdevicefamily                                            : STRING;
                          a_width, a_type, b_width, b_type                         : INTEGER;
                          out_high, out_low                                        : INTEGER;
                          mult_type, opt_goal                                      : INTEGER;
                          has_ce, has_sclr, ce_overrides_sclr                      : INTEGER;
                          pipe_stages, ccm_imp                                     : INTEGER;
                          b_value, elaboration_dir                                 : STRING;
                          has_load_done, has_zero_detect, round_output, c_round_pt : INTEGER)   RETURN BOOLEAN IS
  BEGIN  -- FUNCTION check_generics

    -- check that the family info is valid - leave all other checks up to CoreGen and the XCD file
    ASSERT derived(xdevicefamily, "any") REPORT "ERROR: mult_gen_v9_0: c_xdevicefamily generic invalid" SEVERITY failure;
    ASSERT derived(i_family, "any") REPORT "INTERNAL ERROR: mult_gen_v9_0: ci_family invalid" SEVERITY failure;

    -- check that the A and B types are valid
    ASSERT a_type = C_SIGNED OR a_type = C_UNSIGNED REPORT "ERROR: mult_gen_v9_0: c_a_type should be 0 (signed) or 1 (unsigned)" SEVERITY error;
    ASSERT b_type = C_SIGNED OR b_type = C_UNSIGNED REPORT "ERROR: mult_gen_v9_0: c_b_type should be 0 (signed) or 1 (unsigned)" SEVERITY error;

    -- check that the port widths are valid, based on the operand types and the multiplier type
    ASSERT a_width+a_type >= 2 AND a_width < 65 REPORT "ERROR: mult_gen_v9_0: c_a_width must be in the range 2->64 for signed data and 1->64 for unsigned data" SEVERITY failure;
    ASSERT b_width+b_type >= 2 AND b_width < 65 REPORT "ERROR: mult_gen_v9_0: c_b_width must be in the range 2->64 for signed data and 1->64 for unsigned data" SEVERITY failure;

    -- check that c_out_high and c_out_low are valid
    ASSERT out_high >= 0 AND out_high <= 127 REPORT "ERROR: mult_gen_v9_0: c_out_high must be in the range 0 to 127" SEVERITY failure;
    ASSERT out_low >= 0 AND out_low   <= 127 AND out_low <= out_high REPORT "ERROR: mult_gen_v9_0: c_out_low must be in the range 0 to 127 and <= c_out_high" SEVERITY failure;

    -- check that mult_type is valid
    ASSERT mult_type = LUT OR mult_type = EMBEDDED_MULT OR mult_type = FIXED_CCM REPORT "ERROR: mult_gen_v9_0: c_mult_type must be 0, 1 or 2" SEVERITY failure;

    IF mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM THEN
      REPORT "Static and dynamic reloadable CCMs are not supported in Multiplier V9.0 - use a parallel multiplier if this functionality is required" SEVERITY failure;
    END IF;
    
    -- some specific checks on mult_type based on the family info
    IF mult_type = EMBEDDED_MULT THEN
      ASSERT i_family /= "virtex" REPORT "ERROR: mult_gen_v9_0: Virtex (or Spartan-2) does not have embedded multipliers - set c_mult_type to 0 for a LUT multiplier" SEVERITY failure;
    END IF;

    -- check that opt_goal is valid
    IF mult_type = LUT OR mult_type = EMBEDDED_MULT THEN
      ASSERT opt_goal = EMB_MULT_RESOURCES OR opt_goal = CORE_SPEED REPORT "ERROR: mult_gen_v9_0: c_opt_goal must be 0 (optimize for embedded mult resources) or 1 (optimize for core speed)" SEVERITY failure;
    ELSE
      -- don't care - generic doesn't apply to CCMs
      NULL;
    END IF;

    -- check has_ce, has_sclr, ce_overrides_sclr
    ASSERT has_ce = MG_NO OR has_ce = MG_YES REPORT "ERROR: mult_gen_v9_0: c_has_ce must be 0 or 1" SEVERITY failure;
    ASSERT has_Sclr = MG_NO OR has_sclr = MG_YES REPORT "ERROR: mult_gen_v9_0: c_has_sclr must be 0 or 1" SEVERITY failure;
    ASSERT ce_overrides_sclr = MG_NO OR ce_overrides_sclr = MG_YES REPORT "ERROR: mult_gen_v9_0: c_ce_overrides_sclr must be 0 or 1" SEVERITY failure;

    -- check pipe_stages is valid
    ASSERT (pipe_stages >= 0 AND pipe_stages <= MAX_PIPE_STAGES) OR pipe_stages >= PIPELINE_CFG_BREAKPT REPORT "ERROR: mult_gen_v9_0: c_pipe_stages must be > 0 and < " & integer'image(MAX_PIPE_STAGES) & " (or >= " & integer'image(PIPELINE_CFG_BREAKPT) & " for bit pattern mode)" SEVERITY failure;

    -- check ccm_imp is valid - depends on mult_type
    IF mult_type = FIXED_CCM THEN
      ASSERT ccm_imp = DIST_MEM OR ccm_imp = BRAM OR ccm_imp = MULTS REPORT "ERROR: mult_gen_v9_0: c_ccm_imp must be 0, 1 or 2" SEVERITY failure;
    ELSE
      -- we don't care - it's a parallel multiplier
      NULL;
    END IF;

    -- check b_value is not a null string if it's a CCM
    IF mult_type = FIXED_CCM THEN    
      ASSERT b_value'length /= 0 REPORT "ERROR: mult_gen_v9_0: c_b_value string length is zero" SEVERITY failure;
    ELSE
      -- we don't care, as b_value's not used
      NULL;
    END IF;

    -- check elaboration dir is not a null STRING
    IF mult_type = FIXED_CCM THEN    
      ASSERT elaboration_dir'length /= 0 REPORT "ERROR: mult_gen_v9_0: c_elaboration_dir STRING length is zero" SEVERITY failure;
    ELSE
      -- we don't care as we don't write out MIF files...
      NULL;
    END IF;

    IF mult_type = LUT OR mult_type = EMBEDDED_MULT THEN
      ASSERT has_zero_detect = MG_NO OR has_zero_detect = MG_YES REPORT "ERROR: mult_gen_v9_0: c_has_zero_detect must be 0 or 1" SEVERITY failure;
    ELSE
      ASSERT has_zero_detect = MG_NO REPORT "WARNING: mult_gen_v9_0: Zero Detection is only supported for parallel multipliers" SEVERITY warning;
    END IF;

    IF mult_type = EMBEDDED_MULT AND ((fn_check_family(i_family)) = VIRTEX4 OR (fn_check_family(i_family)) = VIRTEX5) THEN
      ASSERT round_output = MG_NO OR round_output = MG_YES REPORT "ERROR: mult_gen_v9_0: c_round_output must be 0 or 1" SEVERITY failure;
      IF fn_check_family(i_family) = VIRTEX4 AND round_output = MG_YES THEN
        ASSERT a_width+a_type <= 18 AND b_width+b_type <= 18 REPORT "ERROR: mult_gen_v9_0: Symmetric rounding is only supported for a single DSP48 in Virtex-4" SEVERITY failure;
      ELSIF fn_check_family(i_family) = VIRTEX5 AND round_output = MG_YES THEN
        ASSERT a_width+a_type <= 25 AND b_width+b_type <= 18 REPORT "ERROR: mult_gen_v9_0: Symmetric rounding is only supported for a single DSP48E in Virtex-5" SEVERITY failure;
      END IF;
    ELSE
      -- don't allow rounding for other multipliers - expensive
      ASSERT round_output = MG_NO REPORT "ERROR: mult_gen_v9_0: Rounding is only supported for Virtex-4 and Virtex-5 DSP48(E)-based multipliers" SEVERITY failure;
    END IF;

    RETURN true;
  END FUNCTION check_generics;
  
  -- purpose: converts a std_logic 1 to an integer 1 and the equivalent for a zero
  FUNCTION sl_to_int(sl : STD_LOGIC) RETURN INTEGER IS
  BEGIN  -- FUNCTION sl_to_int
    IF sl = '1' THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION sl_to_int;

END PACKAGE BODY pkg_mult_gen_v9_0;
