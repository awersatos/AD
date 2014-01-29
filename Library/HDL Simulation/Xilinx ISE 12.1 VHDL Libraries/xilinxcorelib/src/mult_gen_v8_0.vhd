-- $RCSfile: mult_gen_v8_0.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:47 $
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v8_0.ALL;
USE xilinxcorelib.prims_utils_v8_0.ALL;
USE xilinxcorelib.mult_gen_const_pkg_v8_0.ALL;
USE xilinxcorelib.mult_gen_v8_0_non_seq_comp.ALL;
USE xilinxcorelib.mult_gen_v8_0_services.ALL;
USE xilinxcorelib.iputils_family.ALL;

-------------------------------------------------
-- c_family and c_xdevicefamily settings
-------------------------------------------------
-- Target Family  -  c_family  - c_xdevicefamily
-------------------------------------------------
--   Virtex       - "virtex"   - same as c_family
--   Spartan-2    - "virtex"   - same as c_family
--   Virtex-2     - "virtex2"  - same as c_family
--   Virtex-2P    - "virtex2p" - same as c_family
--   Spartan-3    - "spartan3" - same as c_family 
--   Spartan-3E   - "spartan3" - same as c_family 
--   Virtex-4     - "virtex4"  - same as c_family 
-------------------------------------------------

ENTITY mult_gen_v8_0 IS
  GENERIC (
    c_family          : STRING  := DEFAULT_FAMILY;
    c_xdevicefamily   : STRING  := DEFAULT_XDEVICEFAMILY;  -- ignored
    c_a_width         : INTEGER := A_DEFAULT_WIDTH;
    c_b_width         : INTEGER := B_DEFAULT_WIDTH;
    c_out_width       : INTEGER := OUT_DEFAULT_WIDTH;
    c_has_q           : INTEGER := DEFAULT_HAS_Q;
    c_has_o           : INTEGER := 0;
    c_reg_a_b_inputs  : INTEGER := DEFAULT_REG_A_B_INPUTS;
    c_a_type          : INTEGER := DEFAULT_A_TYPE;
    c_b_type          : INTEGER := DEFAULT_B_TYPE;
    c_b_value         : STRING  := DEFAULT_CONSTANT_B_VAL;
    c_has_aclr        : INTEGER := DEFAULT_HAS_ACLR;
    c_has_sclr        : INTEGER := DEFAULT_HAS_SCLR;
    c_has_ce          : INTEGER := DEFAULT_HAS_CE;
    c_mem_type        : INTEGER := DEFAULT_MEM_TYPE;
    c_mult_type       : INTEGER := DEFAULT_MULT_TYPE;
    -- determines which kind of multiplier to instantiate:
    -- 0- LUT based parallel
    -- 1- MULT18X18-based parallel (Virtex-2(P), Spartan-3(E) only)
    -- 2- parallel CCM
    -- 3- static RCCM
    -- 4- dynamic RCCM
    -- 5- DSP48 only (Virtex-4 only)
    -- 6- embedded multiplier + fabric hybrid (Virtex-2(P), Spartan-3(E), Virtex-4 only)
    c_elaboration_dir : STRING  := "./";                   -- ignored
    c_has_nd          : INTEGER := DEFAULT_HAS_ND;
    c_has_rdy         : INTEGER := DEFAULT_HAS_RDY;
    c_has_rfd         : INTEGER := DEFAULT_HAS_RFD;
    c_pipeline        : INTEGER := DEFAULT_PIPELINED;
    c_sync_enable     : INTEGER := DEFAULT_SYNC_ENABLE;
    c_has_load_done   : INTEGER := DEFAULT_HAS_LOAD_DONE;
    -- deprecated generics - these are set internally before being passed to
    -- lower levels and hence have no effect when set here
    c_b_constant      : INTEGER := 0;
    c_has_a_signed    : INTEGER := 0;
    c_enable_rlocs    : INTEGER := 0;
    c_has_loadb       : INTEGER := 0;
    c_baat            : INTEGER := 0;
    c_has_swapb       : INTEGER := 0;
    c_output_hold     : INTEGER := 0;
    c_sqm_type        : INTEGER := 0;
    c_has_b           : INTEGER := 0;
    c_stack_adders    : INTEGER := 0;
    bram_addr_width   : INTEGER := 0;
    c_mem_init_prefix : STRING  := "mem";
    c_standalone      : INTEGER := 0;
    c_use_luts        : INTEGER := 0;
    c_v2_speed        : INTEGER := 0);
  PORT (
    clk       : IN  STD_LOGIC                                := '0';
    a         : IN  STD_LOGIC_VECTOR(c_a_width-1 DOWNTO 0)   := (OTHERS => '0');
    b         : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0)   := (OTHERS => '0');
    o         : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0);
    q         : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0) := (OTHERS => '0');
    a_signed  : IN  STD_LOGIC                                := '0';
    loadb     : IN  STD_LOGIC                                := '0';
    load_done : OUT STD_LOGIC;
    swapb     : IN  STD_LOGIC                                := '0';
    ce        : IN  STD_LOGIC                                := '0';
    aclr      : IN  STD_LOGIC                                := '0';
    sclr      : IN  STD_LOGIC                                := '0';
    rfd       : OUT STD_LOGIC;
    nd        : IN  STD_LOGIC                                := '1';
    rdy       : OUT STD_LOGIC
    );
END mult_gen_v8_0;


ARCHITECTURE behavioral OF mult_gen_v8_0 IS

  -- purpose: sets c_sync_enable to the default when CE is not present
  FUNCTION set_sync_en (has_ce, sync_enable : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (has_ce = 1) THEN
      RETURN sync_enable;
    ELSE
      RETURN 0;
    END IF;
  END set_sync_en;

  -- purpose: used to set c_b_constant_i depending on mult type
  FUNCTION get_c_b_constant(mult_type : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION get_c_b_constant
    IF mult_type = CCM OR mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION get_c_b_constant;

  -- purpose: sets the deprecated generic c_has_a_signed
  FUNCTION get_c_has_a_signed(a_type : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION set_has_a_signed
    IF a_type = C_PIN THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION get_c_has_a_signed;

  -- purpose: used to set c_has_loadb if it's an RCCM
  FUNCTION get_c_has_loadb(mult_type : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION get_c_has_loadb
    IF mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION get_c_has_loadb;

  -- purpose: used to set c_has_swapb if it's a dynamic RCCM
  FUNCTION get_c_has_swapb(mult_type : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION get_c_has_swapb
    IF mult_type = DYNAMIC_RCCM THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION get_c_has_swapb;

  -- purpose: used to set c_has_b_i depending on mult type
  FUNCTION get_c_has_b(mult_type : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION get_c_has_b
    IF mult_type /= CCM THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION get_c_has_b;

  -- internal signals to allow for delayed output
  SIGNAL int_o         : STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0);
  SIGNAL int_q         : STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0);
  SIGNAL int_load_done : STD_LOGIC;
  SIGNAL int_rdy       : STD_LOGIC;
  SIGNAL int_rfd       : STD_LOGIC;

  -- internal constants to replace the deprecated generics
  CONSTANT c_b_constant_i      : INTEGER := get_c_b_constant(c_mult_type);
  CONSTANT c_has_a_signed_i    : INTEGER := get_c_has_a_signed(c_a_type);
  CONSTANT c_enable_rlocs_i    : INTEGER := 0;
  CONSTANT c_has_loadb_i       : INTEGER := get_c_has_loadb(c_mult_type);
  CONSTANT c_baat_i            : INTEGER := c_a_width;
  CONSTANT c_has_swapb_i       : INTEGER := get_c_has_swapb(c_mult_type);
  CONSTANT c_output_hold_i     : INTEGER := 0;  -- was only an option for SQM
  CONSTANT c_sqm_type_i        : INTEGER := 0;  -- was only an option for SQM
  CONSTANT c_has_b_i           : INTEGER := get_c_has_b(c_mult_type);
  CONSTANT c_stack_adders_i    : INTEGER := 0;
  CONSTANT bram_addr_width_i   : INTEGER := get_bram_addr_width(c_family);
  CONSTANT c_standalone_i      : INTEGER := 1;
  CONSTANT c_use_luts_i        : INTEGER := 0;
  CONSTANT c_mem_init_prefix_i : STRING  := DEFAULT_MEM_INIT_PREFIX;


-- purpose: Verifies that the generics passed to the core are valid
  FUNCTION check_generics (family ,
                           xdevicefamily   : STRING;
                           a_width ,
                           b_width ,
                           out_width ,
                           has_q ,
                           has_o ,
                           reg_a_b_inputs ,
                           a_type ,
                           b_type ,
                           b_constant      : INTEGER;
                           b_value         : STRING;
                           has_aclr ,
                           has_sclr ,
                           has_ce ,
                           has_a_signed ,
                           enable_rlocs ,
                           has_loadb ,
                           mem_type ,
                           mult_type ,
                           baat ,
                           has_swapb ,
                           has_nd ,
                           has_rdy,
                           has_rfd ,
                           sync_enable ,
                           pipeline ,
                           output_hold ,
                           has_load_done ,
                           sqm_type ,
                           has_b ,
                           stack_adders,
                           bram_addr_width : INTEGER;
                           mem_init_prefix : STRING;
                           standalone ,
                           use_luts ,
                           v2_speed        : INTEGER) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION check_generics

    -- do some basic checks first to ensure generics are in range to be interpreted correctly
    -- we ignore bram_addr_width as it is now internally set and b_value and mem_init_prefix as they are strings.
    -- the family passed in has already been lower-cased, as has xdevicefamily
    ASSERT family = "virtex" OR family = "virtex2" OR family = "virtex2p" OR family = "spartan3" OR family = "virtex4"
      REPORT "ERROR: mult_gen_v8_0: c_family must be one of the following values - virtex, virtex2, virtex2p, spartan3, virtex4.  Use virtex for Spartan-II(E)." SEVERITY failure;

    IF mult_type /= CCM AND mult_type /= STATIC_RCCM AND mult_type /= DYNAMIC_RCCM THEN
      ASSERT a_width > 0 AND a_width < 65 REPORT "ERROR: mult_gen_v8_0: c_a_width must be in the range 1 to 64 (2 to 64 if A is signed)" SEVERITY failure;
      ASSERT b_width > 0 AND b_width < 65 REPORT "ERROR: mult_gen_v8_0: c_b_width must be in the range 1 to 64 (2 to 64 if B is signed)" SEVERITY failure;
    ELSE
      ASSERT a_width > 0 AND a_width < 33 REPORT "ERROR: mult_gen_v8_0: c_a_width must be in the range 1 to 32 (2 to 32 if A is signed)" SEVERITY failure;
      ASSERT b_width > 0 AND b_width < 33 REPORT "ERROR: mult_gen_v8_0: c_b_width must be in the range 1 to 32 (2 to 32 if B is signed)" SEVERITY failure;
    END IF;

    ASSERT out_width > 0 AND out_width < (129+has_a_signed) REPORT "ERROR: mult_gen_v8_0: c_out_width must be greater than 0 and less than " & INTEGER'image(128+has_a_signed) SEVERITY failure;
    ASSERT has_q = 0 OR has_q = 1 REPORT "ERROR: mult_gen_v8_0: c_has_q must be 0 or 1" SEVERITY failure;
    ASSERT has_o = 0 OR has_o = 1 REPORT "ERROR: mult_gen_v8_0: c_has_o must be 0 or 1" SEVERITY failure;
    ASSERT reg_a_b_inputs = 0 OR reg_a_b_inputs = 1 REPORT "ERROR: mult_gen_v8_0: c_reg_a_b_inputs must be 0, 1 or 2" SEVERITY failure;
    ASSERT a_type = 0 OR a_type = 1 OR a_type = 2 REPORT "ERROR: mult_gen_v8_0: c_a_type must be 0, 1 or 2" SEVERITY failure;
    ASSERT b_type = 0 OR b_type = 1 REPORT "ERROR: mult_gen_v8_0: c_b_type must be 0 or 1" SEVERITY failure;
    ASSERT has_aclr = 0 OR has_aclr = 1 REPORT "ERROR: mult_gen_v8_0: c_has_aclr must be 0 or 1" SEVERITY failure;
    ASSERT has_sclr = 0 OR has_sclr = 1 REPORT "ERROR: mult_gen_v8_0: c_has_sclr must be 0 or 1" SEVERITY failure;
    ASSERT has_ce = 0 OR has_ce = 1 REPORT "ERROR: mult_gen_v8_0: c_has_ce must be 0 or 1" SEVERITY failure;
    ASSERT mem_type = C_DISTRIBUTED OR mem_type = C_SP_BLOCK OR mem_type = C_DP_BLOCK REPORT "ERROR: mult_gen_v8_0: c_mem_type must be 0 (Distributed), 1 (SP block) or 2 (DP block)" SEVERITY failure;
    ASSERT mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM OR mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM OR mult_type = V4_PARALLEL OR mult_type = HYBRID
      REPORT "ERROR: mult_gen_v8_0: c_mult_type must be 0 (LUTs, parallel), 1 (18x18-based), 2 (CCM), 3 (Static RCCM), 4 (Dynamic RCCM), 5 (DSP48), 6 (Hybrid)" SEVERITY failure;
    ASSERT has_nd = 0 OR has_nd = 1 REPORT "ERROR: mult_gen_v8_0: c_has_nd must be 0 or 1" SEVERITY failure;
    ASSERT has_rdy = 0 OR has_rdy = 1 REPORT "ERROR: mult_gen_v8_0: c_has_rdy must be 0 or 1" SEVERITY failure;
    ASSERT has_rfd = 0 OR has_rfd = 1 REPORT "ERROR: mult_gen_v8_0: c_has_rfd must be 0 or 1" SEVERITY failure;
    ASSERT sync_enable = 0 OR sync_enable = 1 REPORT "ERROR: mult_gen_v8_0: c_sync_enable must be 0 or 1" SEVERITY failure;
    ASSERT pipeline = 0 OR pipeline = 1 REPORT "ERROR: mult_gen_v8_0: c_pipeline must be 0 or 1" SEVERITY failure;
    ASSERT has_load_done = 0 OR has_load_done = 1 REPORT "ERROR: mult_gen_v8_0: c_has_load_done must be 0 or 1" SEVERITY failure;

    IF mult_type = CCM THEN
      ASSERT b_value'length = b_width REPORT "ERROR: mult_gen_v8_0: c_b_value string must be the same width as that specified by c_b_width" SEVERITY failure;
    END IF;
    
    -- deprecated generics
    ASSERT has_swapb = 0 REPORT "WARNING: mult_gen_v8_0: c_has_swapb is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT has_a_signed = 0 REPORT "WARNING: mult_gen_v8_0: c_has_a_signed is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY failure;
    ASSERT has_loadb = 0 REPORT "WARNING: mult_gen_v8_0: c_has_loadb is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT enable_rlocs = 0 REPORT "WARNING: mult_gen_v8_0: c_enable_rlocs is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT b_constant = 0 REPORT "WARNING: mult_gen_v8_0: c_b_constant is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT baat = c_a_width
      REPORT "WARNING: mult_gen_v8_0: c_baat is deprecated in version 8 - it should be set to the same value as c_a_width (" & INTEGER'image(c_a_width) & ") to avoid this warning" SEVERITY warning;
    ASSERT output_hold = 0 REPORT "WARNING: mult_gen_v8_0: c_output_hold is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT sqm_type = 0 REPORT "WARNING: mult_gen_v8_0: c_sqm_type is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT has_b = 0 REPORT "WARNING: mult_gen_v8_0: c_has_b is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT stack_adders = 0 REPORT "WARNING: mult_gen_v8_0: c_stack_adders is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT standalone = 0 REPORT "WARNING: mult_gen_v8_0: c_standalone is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT use_luts = 0 REPORT "WARNING: mult_gen_v8_0: c_use_luts is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT v2_speed = 0 REPORT "WARNING: mult_gen_v8_0: c_v2_speed is deprecated in version 8 - it should be set to 0 to avoid this warning" SEVERITY warning;
    ASSERT bram_addr_width = 8 OR bram_addr_width = 9 REPORT "ERROR: mult_gen_v8_0: bram_addr_width should be set to 8 for Virtex and Spartan-2 and 9 for Virtex-2, Spartan-3 and Virtex-4" SEVERITY failure;

    -- now do some more in-depth checks to ensure that the combinations of generics are OK
    IF a_type = C_SIGNED OR a_type = C_PIN THEN
      ASSERT a_width > 1 REPORT "ERROR: mult_gen_v8_0: c_a_width must be at least 2 bits wide for signed input or input controlled by pin" SEVERITY failure;
    END IF;
    IF b_type = C_SIGNED THEN
      ASSERT b_width > 1 REPORT "ERROR: mult_gen_v8_0: c_b_width must be at least 2 bits wide for signed input or input controlled by pin" SEVERITY failure;
    END IF;

    -- check that the type of multiplier being generated has the correct
    -- family and required generics set
    IF mult_type = V2_PARALLEL THEN
      ASSERT family = "virtex2" OR family = "virtex2p" OR family = "spartan3"
        REPORT "ERROR: mult_gen_v8_0: 18x18(S)(SIO) block multipliers are only available on V2, V2P and S3(E) devices" SEVERITY failure;
    END IF;
    IF mult_type = V4_PARALLEL THEN
      ASSERT family = "virtex4" REPORT "ERROR: mult_gen_v8_0: DSP48-based multipliers can only be generated for a Virtex4 device" SEVERITY failure;
      ASSERT has_aclr = 0 REPORT "ERROR: mult_gen_v8_0: ACLR not supported on XtremeDSP Slice (DSP48) multiplier" SEVERITY failure;
    END IF;
    IF mult_type = HYBRID THEN
      ASSERT family = "virtex4" OR family = "virtex2" OR family = "virtex2p" OR family = "spartan3" REPORT "ERROR: mult_gen_v8_0: Hybrid multipliers can only be generated for Virtex-2(P), Spartan-3(E) and Virtex-4 devices" SEVERITY failure;
      ASSERT has_aclr = 0 REPORT "ERROR: ACLR not supported on hybrid multiplier" SEVERITY failure;
      -- check that the widths are in range for the hybrid
      ASSERT (a_width+BOOLEAN'pos(a_type = C_UNSIGNED OR a_type = C_PIN) <= 35) AND (b_width+b_type <= 35)
        REPORT "ERROR: mult_gen_v8_0: Only operand widths up to 35 bit (signed) or 34 bit (unsigned/pin) are supported by the hybrid multiplier" SEVERITY failure;
      -- assert false if the implementation is going to be inefficient
      ASSERT (a_width+BOOLEAN'pos(a_type = C_UNSIGNED OR a_type = C_PIN) <= 25 AND b_width+b_type <= 25) OR (a_width+BOOLEAN'pos(a_type = C_UNSIGNED OR a_type = C_PIN) <= 25 AND b_width+b_type <= 18)
        REPORT "WARNING: mult_gen_v8_0: Implementation using c_mult_type = 5 (DSP48-only) is likely to use less silicon area and give better performance with these operand widths" SEVERITY warning;
    END IF;

    IF mult_type /= STATIC_RCCM AND mult_type /= DYNAMIC_RCCM THEN
      ASSERT has_load_done = 0 REPORT "ERROR: Load Done is only applicable to Reloadable Constant Coeff multipliers (c_mult_type = 3 and c_mult_type = 4)" SEVERITY failure;
    END IF;

    ASSERT has_q /= 0 OR has_o /= 0 REPORT "ERROR: mult_gen_v8_0: Multiplier must have at least one output - c_has_q and c_has_o currently both set to 0" SEVERITY failure;


    -- now output warnings to the user to indicate the effect of the generic
    -- choices on speed and/or resources

    ASSERT sync_enable /= 1 REPORT "WARNING: mult_gen_v8_0: Reversing CE/SCLR priority such that CE overrides SCLR does not reflect primitive behavior " & CR
      & "This will increase LUT usage in your design" SEVERITY warning;

    IF (mult_type = V2_PARALLEL OR mult_type = V4_PARALLEL) AND (has_o /= 0 OR has_q /= 0) THEN
      ASSERT (has_o /= 0 XOR has_q /= 0) REPORT "WARNING: mult_gen_v8_0: Using non-registered outputs in conjunction with registered outputs will restrict logic packing and reduce core speed" SEVERITY warning;
    END IF;

    IF has_ce /= 0 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = V4_PARALLEL OR mult_type = HYBRID) THEN
      ASSERT (pipeline /= 0 OR reg_a_b_inputs /= 0 OR has_q /= 0)
        REPORT "WARNING: mult_gen_v8_0: c_has_ce generic will be ignored since there are no registers present in the design" SEVERITY warning;
    END IF;

    IF has_sclr /= 0 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = V4_PARALLEL OR mult_type = HYBRID) THEN
      ASSERT (pipeline /= 0 OR reg_a_b_inputs /= 0 OR has_q /= 0)
        REPORT "WARNING: mult_gen_v8_0: c_has_sclr generic will be ignored since there are no registers present in the design" SEVERITY warning;
    END IF;

    IF has_aclr /= 0 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL) THEN
      ASSERT (pipeline /= 0 OR reg_a_b_inputs /= 0 OR has_q /= 0)
        REPORT "WARNING: mult_gen_v8_0: c_has_aclr generic will be ignored since there are no registers present in the design" SEVERITY warning;
    END IF;

    IF has_nd /= 0 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = V4_PARALLEL OR mult_type = HYBRID) THEN
      ASSERT (pipeline /= 0 OR reg_a_b_inputs /= 0 OR has_q /= 0)
        REPORT "WARNING: mult_gen_v8_0: c_has_nd generic will be ignored since there are no registers present in the design" SEVERITY warning;
    END IF;

    IF has_rdy /= 0 THEN
      ASSERT has_nd /= 0 REPORT "ERROR: mult_gen_v8_0: c_has_rdy = 1 only allowed when c_has_nd = 1" SEVERITY failure;
    END IF;

    RETURN true;
  END FUNCTION check_generics;

  -- purpose: takes a string generic and converts it to lower case - the contents are not analysed
  FUNCTION toLowerCaseString(s : STRING) RETURN STRING IS
    VARIABLE ret : STRING(s'low TO s'high);
  BEGIN  -- FUNCTION toLowerCaseString
    FOR i IN s'low TO s'high LOOP
      ret(i) := toLowerCaseChar(s(i));
    END LOOP;  -- i
    RETURN ret;
  END FUNCTION toLowerCaseString;

  CONSTANT c_family_i        : STRING := toLowerCaseString(c_family);
  CONSTANT c_xdevicefamily_i : STRING := toLowerCaseString(c_xdevicefamily);
  
  CONSTANT verify_generics : BOOLEAN := check_generics(c_family_i ,
                                                       c_xdevicefamily_i ,
                                                       c_a_width ,
                                                       c_b_width ,
                                                       c_out_width ,
                                                       c_has_q ,
                                                       c_has_o ,
                                                       c_reg_a_b_inputs ,
                                                       c_a_type ,
                                                       c_b_type ,
                                                       c_b_constant,
                                                       c_b_value,
                                                       c_has_aclr ,
                                                       c_has_sclr ,
                                                       c_has_ce ,
                                                       c_has_a_signed ,
                                                       c_enable_rlocs ,
                                                       c_has_loadb ,
                                                       c_mem_type ,
                                                       c_mult_type ,
                                                       c_baat_i ,
                                                       c_has_swapb ,
                                                       c_has_nd ,
                                                       c_has_rdy,
                                                       c_has_rfd ,
                                                       c_sync_enable ,
                                                       c_pipeline ,
                                                       c_output_hold ,
                                                       c_has_load_done ,
                                                       c_sqm_type ,
                                                       c_has_b ,
                                                       c_stack_adders ,
                                                       bram_addr_width_i ,
                                                       c_mem_init_prefix ,
                                                       c_standalone ,
                                                       c_use_luts ,
                                                       c_v2_speed);

  -- convert the c_b_value string into an INTEGER
  -- we don't actually care if it's a signed or unsigned string because we only
  -- want to check if the binary string is zero
  CONSTANT c_b_value_int : INTEGER := to_integer(unsigned(str_to_bound_slv_0(c_b_value,32)));

BEGIN
 
  i0 : IF (c_b_value_int = 0 AND c_mult_type = CCM) GENERATE
    i00 : IF (c_has_o /= 0) GENERATE
      int_o <= (OTHERS => '0');
    END GENERATE i00;
    i01 : IF (c_has_o = 0) GENERATE
      int_o <= (OTHERS => 'X');
    END GENERATE i01;
    i02 : IF (c_has_q /= 0) GENERATE
      int_q <= (OTHERS => '0');
    END GENERATE i02;
    i03 : IF (c_has_q = 0) GENERATE
      int_q <= (OTHERS => 'X');
    END GENERATE i03;
    i04 : IF (c_has_nd /= 0 AND c_has_rdy /= 0) GENERATE
      int_rdy <= nd;
    END GENERATE i04;
    i05 : IF (c_has_nd = 0 AND c_has_rdy /= 0) GENERATE
      int_rdy <= '1';
    END GENERATE i05;
    i06 : IF (c_has_rdy = 0) GENERATE
      int_rdy <= 'X';
    END GENERATE i06;
    i07 : IF (c_has_rfd /= 0 AND c_has_sclr /= 0 AND c_has_aclr /= 0) GENERATE
      int_rfd <= NOT(sclr OR aclr);
    END GENERATE i07;
    i08 : IF (c_has_rfd /= 0 AND c_has_sclr /= 0 AND c_has_aclr = 0) GENERATE
      int_rfd <= NOT(sclr);
    END GENERATE i08;
    i09 : IF (c_has_rfd /= 0 AND c_has_sclr = 0 AND c_has_aclr /= 0) GENERATE
      int_rfd <= NOT(aclr);
    END GENERATE i09;
    i010 : IF (c_has_rfd /= 0 AND c_has_sclr = 0 AND c_has_aclr = 0) GENERATE
      int_rfd <= '1';
    END GENERATE i010;
    i011 : IF (c_has_rfd = 0) GENERATE
      int_rfd <= 'X';
    END GENERATE i011;
  END GENERATE i0;


  i1 : IF NOT(c_b_value_int = 0 AND c_mult_type = CCM) GENERATE
    mult_non_seq : mult_gen_v8_0_non_seq
      GENERIC MAP (c_family          => c_family,
                   c_a_width         => c_a_width,
                   c_b_width         => c_b_width,
                   c_out_width       => c_out_width,
                   c_has_q           => c_has_q,
                   c_has_o           => c_has_o,
                   c_reg_a_b_inputs  => c_reg_a_b_inputs,
                   c_a_type          => c_a_type,
                   c_b_type          => c_b_type,
                   c_b_constant      => c_b_constant,
                   c_b_value         => c_b_value,
                   c_has_aclr        => c_has_aclr,
                   c_has_sclr        => c_has_sclr,
                   c_has_ce          => c_has_ce,
                   c_has_a_signed    => c_has_a_signed_i,
                   c_enable_rlocs    => c_enable_rlocs_i,
                   c_has_loadb       => c_has_loadb_i,
                   c_mem_type        => c_mem_type,
                   c_mult_type       => c_mult_type,
                   c_baat            => c_baat_i,
                   c_has_swapb       => c_has_swapb_i,
                   c_has_nd          => c_has_nd,
                   c_has_rdy         => c_has_rdy,
                   c_has_rfd         => c_has_rfd,
                   c_pipeline        => c_pipeline,
                   c_predelay        => 0,
                   c_sync_enable     => set_sync_en(c_has_ce, c_sync_enable),
                   c_has_load_done   => c_has_load_done,
                   c_output_hold     => c_output_hold_i,
                   c_sqm_type        => c_sqm_type_i,
                   c_has_b           => c_has_b_i,
                   c_stack_adders    => c_stack_adders_i,
                   bram_addr_width   => bram_addr_width_i,
                   c_mem_init_prefix => c_mem_init_prefix_i,
                   c_standalone      => c_standalone_i,
                   c_use_luts        => c_use_luts_i)   
      PORT MAP (clk       => clk,
                a         => a,
                b         => b,
                o         => int_o,
                q         => int_q,
                a_signed  => a_signed,
                loadb     => loadb,
                load_done => int_load_done,
                swapb     => swapb,
                ce        => ce,
                aclr      => aclr,
                sclr      => sclr,
                rfd       => int_rfd,
                nd        => nd,
                rdy       => int_rdy);
  END GENERATE i1;

  -- conditionally assign outputs
  -- If registers are present in the design, the output is effectively synchronous, so we delay the assignments to the output ports
  -- If there are no registers present, the outputs are assigned immediately to the output ports
  has_registers : IF (c_has_q /= 0 OR c_pipeline /= 0 OR c_reg_a_b_inputs /= 0) OR (c_mult_type = CCM AND c_mem_type = C_DP_BLOCK) GENERATE
    has_o : IF c_has_o /= 0 GENERATE
      o <= int_o AFTER 100 ps;
    END GENERATE has_o;
    has_q : IF c_has_q /= 0 GENERATE
      q <= int_q AFTER 100 ps;
    END GENERATE has_q;
    has_load_done : IF c_has_load_done /= 0 GENERATE
      load_done <= int_load_done AFTER 100 ps;
    END GENERATE has_load_done;
    has_rfd : IF c_has_rfd /= 0 GENERATE
      rfd <= int_rfd AFTER 100 ps;
    END GENERATE has_rfd;
    has_rdy : IF c_has_rdy /= 0 GENERATE
      rdy <= int_rdy AFTER 100 ps;
    END GENERATE has_rdy;
  END GENERATE has_registers;
  no_registers : IF NOT((c_has_q /= 0 OR c_pipeline /= 0 OR c_reg_a_b_inputs /= 0) OR (c_mult_type = CCM AND c_mem_type = C_DP_BLOCK)) GENERATE
    has_o : IF c_has_o /= 0 GENERATE
      o <= int_o;
    END GENERATE has_o;
    has_q : IF c_has_q /= 0 GENERATE
      q <= int_q;
    END GENERATE has_q;
    has_load_done : IF c_has_load_done /= 0 GENERATE
      load_done <= int_load_done;
    END GENERATE has_load_done;
    has_rfd : IF c_has_rfd /= 0 GENERATE
      rfd <= int_rfd;
    END GENERATE has_rfd;
    has_rdy : IF c_has_rdy /= 0 GENERATE
      rdy <= int_rdy;
    END GENERATE has_rdy;
  END GENERATE no_registers;
  
END behavioral;
