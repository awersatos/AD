-- $RCSfile: pkg_baseblox_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:41 $
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

LIBRARY std, ieee;
USE std.standard.ALL;
USE ieee.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;

PACKAGE pkg_baseblox_v8_0 IS

  TYPE T_REGTYPE IS (REGTYPE_FD, REGTYPE_LD);
  TYPE T_SYNC_ENABLE IS (SYNC_OVERRIDES_CE, CE_OVERRIDES_SYNC);
  TYPE T_REG_PRIORITY IS (RESET_OVERRIDES_SET, SET_OVERRIDES_RESET);
  TYPE T_BYPASS_ENABLE IS (BYPASS_OVERRIDES_CE, CE_OVERRIDES_BYPASS);
  TYPE T_ADD_MODE IS (MODE_ADD, MODE_SUB, MODE_ADDSUB);
  -- NUM_PIN is for pin-specified signed/unsigned numbers
  TYPE T_NUMBER_FORMAT IS (NUM_SIGNED, NUM_UNSIGNED, NUM_PIN);
  TYPE T_DEVICE_FAMILY IS (SPARTAN2, SPARTAN3, VIRTEX, VIRTEX2, VIRTEX4);

  FUNCTION fn_select_sync_enable (sync_enable     : INTEGER) RETURN T_SYNC_ENABLE;
  FUNCTION fn_select_bypass_enable (bypass_enable : INTEGER) RETURN T_BYPASS_ENABLE;
  FUNCTION fn_select_sync_priority (sync_priority : INTEGER) RETURN T_REG_PRIORITY;
  FUNCTION fn_select_reg_type (reg_type           : INTEGER) RETURN T_REGTYPE;
  FUNCTION fn_select_add_mode (add_mode           : INTEGER) RETURN T_ADD_MODE;
  FUNCTION fn_select_number_format (number_format : INTEGER) RETURN T_NUMBER_FORMAT;
  FUNCTION fn_check_family(family                 : STRING) RETURN T_DEVICE_FAMILY;
  FUNCTION fn_syncs_in_d_lut (has_sclr, has_sset, has_sinit,
                              has_aclr, has_aset, has_ainit : INTEGER  -- the legacy type
                              ) RETURN INTEGER;
  FUNCTION fn_get_lut_size(device_family : T_DEVICE_FAMILY) RETURN INTEGER;
  FUNCTION fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit : INTEGER;
                            ainit_val, sinit_val                                                     : STD_LOGIC_VECTOR;
                            c_width                                                                  : INTEGER) RETURN STD_LOGIC_VECTOR;

END pkg_baseblox_v8_0;

PACKAGE BODY pkg_baseblox_v8_0 IS
  FUNCTION fn_select_sync_enable (
    sync_enable : INTEGER               -- the legacy type
    )
    RETURN T_SYNC_ENABLE IS
  BEGIN
    CASE sync_enable IS
      WHEN c_override =>
        RETURN SYNC_OVERRIDES_CE;
      WHEN c_no_override =>
        RETURN CE_OVERRIDES_SYNC;
      WHEN OTHERS =>
        ASSERT false REPORT "illegal value of sync_enable. Defaulting to sync_overrides_ce" SEVERITY warning;
        RETURN SYNC_OVERRIDES_CE;
    END CASE;
  END;  --fn_select_sync_enable
  
  FUNCTION fn_select_bypass_enable (
    bypass_enable : INTEGER             -- the legacy type
    )
    RETURN T_BYPASS_ENABLE IS
  BEGIN
    CASE bypass_enable IS
      WHEN c_override =>
        RETURN BYPASS_OVERRIDES_CE;
      WHEN c_no_override =>
        RETURN CE_OVERRIDES_BYPASS;
      WHEN OTHERS =>
        ASSERT false REPORT "illegal value of BYPASS_enable. Defaulting to BYPASS_overrides_ce" SEVERITY warning;
        RETURN BYPASS_OVERRIDES_CE;
    END CASE;
  END;  --fn_select_BYPASS_enable
  
  FUNCTION fn_select_sync_priority (
    sync_priority : INTEGER             -- the legacy type
    )
    RETURN T_REG_PRIORITY IS
  BEGIN
    CASE sync_priority IS
      WHEN c_set =>
        RETURN SET_OVERRIDES_RESET;
      WHEN c_clear =>
        RETURN RESET_OVERRIDES_SET;
      WHEN OTHERS =>
        ASSERT false REPORT "illegal value of sync_priority. Defaulting to reset overrides set" SEVERITY warning;
        RETURN RESET_OVERRIDES_SET;
    END CASE;
  END;  --fn_select_sync_priority
  
  FUNCTION fn_select_reg_type (
    reg_type : INTEGER                  -- the legacy type
    )
    RETURN T_REGTYPE IS
  BEGIN
    CASE reg_type IS
      WHEN c_reg_undefined =>
        ASSERT false REPORT "Undefined Register type. Must be FF or latch" SEVERITY warning;
        RETURN REGTYPE_FD;
      WHEN c_reg_fd =>
        RETURN REGTYPE_FD;
      WHEN c_reg_ld =>
        RETURN REGTYPE_LD;
      WHEN OTHERS =>
        ASSERT false REPORT "Unknown Register type. Must be FF or latch" SEVERITY warning;
        RETURN REGTYPE_FD;
    END CASE;
  END;  --fn_select_reg_type

  FUNCTION fn_select_add_mode(add_mode : INTEGER) RETURN T_ADD_MODE IS
    VARIABLE ret_val : T_ADD_MODE;
  BEGIN
    CASE add_mode IS
      WHEN c_add     => ret_val := MODE_ADD;
      WHEN c_sub     => ret_val := MODE_SUB;
      WHEN c_add_sub => ret_val := MODE_ADDSUB;
      WHEN OTHERS    =>
        ASSERT false REPORT "Invalid add mode value. Must be add, subtract, or add/subtract. Defaulting to add" SEVERITY warning;
        ret_val := MODE_ADD;
    END CASE;
    RETURN ret_val;
  END;

  FUNCTION fn_select_number_format(number_format : INTEGER) RETURN T_NUMBER_FORMAT IS
    VARIABLE ret_val : T_NUMBER_FORMAT;
  BEGIN
    CASE number_format IS
      WHEN c_signed   => ret_val := NUM_SIGNED;
      WHEN c_unsigned => ret_val := NUM_UNSIGNED;
      WHEN c_pin      => ret_val := NUM_PIN;
      WHEN OTHERS     =>
        ASSERT false REPORT "Invalid number format specified. Must be c_signed, c_unsigned or c_pin. Defaulting to c_signed" SEVERITY warning;
        ret_val := NUM_SIGNED;
    END CASE;
    RETURN ret_val;
  END;

  -- purpose: Checks the family generic string for a valid device family name
  -- and defaults to virtex2 if it is not specified or misspelt
  -- We define an 8-character string and put the family string into it.
  -- This avoids the warning from XST that the string lengths in the IF statement
  -- comparisons are different lengths.  
  FUNCTION fn_check_family(family : STRING) RETURN T_DEVICE_FAMILY IS
    VARIABLE fam : STRING(1 TO 9) := "         ";
  BEGIN  -- FUNCTION fn_check_family
    fam(1 TO family'length) := family;
    IF fam = "spartan2 " THEN
      RETURN SPARTAN2;
    ELSIF fam = "spartan3 " THEN        -- spartan3e appears as spartan3 in CoreGen
      RETURN SPARTAN3;
    ELSIF fam = "virtex   " THEN
      RETURN VIRTEX;
    ELSIF fam = "virtex2  " THEN
      RETURN VIRTEX2;
    ELSIF fam = "virtex2p " THEN         -- some cores differentiate between V2 and V2P
      RETURN VIRTEX2;
    ELSIF fam = "virtex4  " THEN
      RETURN VIRTEX4;
    ELSE
      ASSERT false
        REPORT "WARNING: Invalid or misspelt device family generic specified - defaulting to virtex2 family implementation"
        SEVERITY warning;
      ASSERT false
        REPORT "NOTE: Valid families are: spartan2, spartan3, spartan3e, virtex, virtex2, virtex2p, virtex4"
        SEVERITY note;
      RETURN VIRTEX2;
    END IF;
  END;

  --The following utility function calculates the number of synchronous
  --controls which must be gated into the logic for the d input of a register
  --This can be useful in optimising logic to the register.
  FUNCTION fn_syncs_in_d_lut (
    has_sclr, has_sset, has_sinit, has_aclr, has_aset, has_ainit : INTEGER  -- the legacy type
    )
    RETURN INTEGER IS
  BEGIN
    IF has_aclr = 0 AND has_aset = 0 AND has_ainit = 0 THEN
      RETURN 0;
    ELSIF has_sinit /= 0 THEN
      RETURN 1;
    ELSIF has_sclr = 0 THEN
      IF has_sset = 0 THEN
        RETURN 0;
      ELSE
        RETURN 1;
      END IF;
    ELSE
      IF has_sset = 0 THEN
        RETURN 1;
      ELSE
        RETURN 2;
      END IF;
    END IF;
  END;  --fn_select_reg_type

-- purpose: Determines the LUT size used in the target architecture specified by device_family
  FUNCTION fn_get_lut_size(device_family : T_DEVICE_FAMILY) RETURN INTEGER IS
  BEGIN  -- FUNCTION fn_get_lut_size
    CASE device_family IS
      WHEN VIRTEX4 | VIRTEX2 | SPARTAN3 | VIRTEX | SPARTAN2 => RETURN 4;
      WHEN OTHERS                                           => ASSERT false
                       REPORT "ERROR: Invalid device_family detected in fn_get_lut_size, so cannot determine LUT size - defaulting to four-input LUT and returning 4"
                       SEVERITY warning;
                     RETURN 4;
    END CASE;
  END FUNCTION fn_get_lut_size;
  
  -- purpose: Determines what the POR value should be from the register controls that are present
  FUNCTION fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit : INTEGER;
                            ainit_val, sinit_val                                                     : STD_LOGIC_VECTOR;
                            c_width                                                                  : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret : STD_LOGIC_VECTOR(c_width DOWNTO 1);
  BEGIN  -- FUNCTION fn_get_por_value
    -- define power-up value
    IF c_has_aclr /= 0 THEN
      ret := (OTHERS => '0');
    ELSIF c_has_aset /= 0 THEN
      ret := (OTHERS => '1');
    ELSIF c_has_ainit /= 0 THEN
      ret := ainit_val;
    ELSIF (c_has_sclr /= 0) THEN
      ret := (OTHERS => '0');
    ELSIF (c_has_sset /= 0) THEN
      ret := (OTHERS => '1');
    ELSIF (c_has_sinit /= 0) THEN
      ret := sinit_val;
    ELSE
      ret := ainit_val;
    END IF;
    RETURN ret;
  END FUNCTION fn_get_por_value;

END pkg_baseblox_v8_0;
