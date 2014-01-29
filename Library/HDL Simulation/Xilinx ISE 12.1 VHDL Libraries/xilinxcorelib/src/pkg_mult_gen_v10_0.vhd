-- $Id: pkg_mult_gen_v10_0.vhd,v 1.7 2008/09/09 15:23:36 akennedy Exp $
--------------------------------------------------------------------------------
--  Copyright(C) 2006, 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 2006, 2007 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY std;
USE std.standard.ALL;
USE std.textio.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_1.ALL;
USE XilinxCoreLib.prims_utils_v9_1.ALL;
USE XilinxCoreLib.pkg_baseblox_v9_1.ALL;

PACKAGE pkg_mult_gen_v10_0 IS

  -----------------------------------------------------------------------------
  -- Constants and functions for use all over the core
  -----------------------------------------------------------------------------

  CONSTANT debug : BOOLEAN := false;
  
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
  CONSTANT DEF_C_OPT_GOAL          : INTEGER := CORE_SPEED;
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

  -- constants for the 3 possible hybrid configurations
  CONSTANT BASE_MULT : INTEGER := 0;  -- no fabric required - just use the base DSP48 or Mult18x18 multiplier
  CONSTANT ONE_MULT  : INTEGER := 1;  -- fabric multiplier only needed on one side of the partial-product array
  CONSTANT TWO_MULT  : INTEGER := 2;  -- 2 fabric multipliers and a fabric adder needed around the embedded mult array

  -----------------------------------------------------------------------------
  -- TYPES AND RECORDS
  -----------------------------------------------------------------------------
  
  -- record to define the widths of all the ports that may be required when building a block-based multiplier
  TYPE PORT_ASPECTS IS RECORD
    a : INTEGER;                        -- size of port A
    b : INTEGER;                        -- size of port B
    m : INTEGER;                        -- size of M register after mult
    c : INTEGER;                        -- size of port C
    p : INTEGER;                        -- size of port P
  END RECORD PORT_ASPECTS;

  -- a record to store the width of the a and b operands and if they should be
  -- swapped internally for the best mapping/resource use
  TYPE WIDTH_REC IS RECORD
    a      : INTEGER;
    b      : INTEGER;
    a_type : INTEGER;
    b_type : INTEGER;
    swap   : BOOLEAN;
  END RECORD WIDTH_REC;

  TYPE BLOCK_MULT_REC IS RECORD
    a_width : INTEGER;                  -- width of A operand on block mult
    a_type  : INTEGER;                  -- datatype of A operand on block mult
    b_width : INTEGER;                  -- width of B operand on block mult
    b_type  : INTEGER;                  -- datatype of B operand on block mult
  END RECORD BLOCK_MULT_REC;

  TYPE ONE_MULT_REC IS RECORD
    a         : INTEGER;                -- width of A input to fabric mult
    b         : INTEGER;                -- width of B input to fabric mult
    a_type    : INTEGER;                -- type of A input to fabric mult
    b_type    : INTEGER;                -- type of B input to fabric mult
    out_width : INTEGER;                -- output width of fabric mult
    bypass    : INTEGER;                -- number of bypass bits
    a_offset  : INTEGER;  -- the offset on the A operand due to the mult configuration and # bypass bits
    b_offset  : INTEGER;  -- the offset on the B operand due to the mult configuration and # bypass bits
  END RECORD ONE_MULT_REC;

  TYPE TWO_MULT_REC IS RECORD
    a_top          : INTEGER;  -- width of A operand on top fabric mult
    b_top          : INTEGER;  -- width of B operand on top fabric mult
    a_type_top     : INTEGER;           -- type of A operand on top fabric mult
    b_type_top     : INTEGER;           -- type of B operand on top fabric mult
    out_width_top  : INTEGER;           -- output width of top fabric mult
    a_side         : INTEGER;  -- width of A operand on side fabric mult
    b_side         : INTEGER;  -- width of B operand on side fabric mult
    a_type_side    : INTEGER;  -- type of A operand on side fabric mult
    b_type_side    : INTEGER;  -- type of B operand on side fabric mult
    out_width_side : INTEGER;           -- output width of side fabric mult
    mult_bypass    : INTEGER;  -- number of bypass bits from top fabric mult
    add_bypass     : INTEGER;  -- number of bypass bits from fabric adder
    a_offset       : INTEGER;  -- offset for A operand into block multiplier
    b_offset       : INTEGER;  -- offset for B operand into block multiplier
  END RECORD TWO_MULT_REC;

  -----------------------------------------------------------------------------
  -- FUNCTIONS
  -----------------------------------------------------------------------------

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
                          has_load_done, has_zero_detect, round_output, c_round_pt : INTEGER;
                          mem_init_prefix                                          : STRING;
                          use_p_cascade_out                                        : INTEGER) RETURN BOOLEAN;

  -- purpose: catches the case where the xdevicefamily is Spartan-3E, 3A or 3ADSP and modifies the family info accordingly
  -- There aren't any shared functions to do this, but the only piece of IP where this really matters is the multiplier
  FUNCTION modify_family(family_str : STRING) RETURN STRING;
  
  -- converts a std_logic bit to an integer representation
  FUNCTION sl_to_int(sl : STD_LOGIC) RETURN INTEGER;

  -- reports the 'logarithm' (base 2) of an INTEGER
  FUNCTION mult_gen_log2(x : INTEGER) RETURN INTEGER;

  -- reports the 'logarithm' (base 2) of an INTEGER
  -- the value it returns is constrained to the integer value
  -- e.g. log(4) = 2, log(6) = 2, log(8) = 3, log(10) = 3
  FUNCTION mult_gen_log2d(x : INTEGER) RETURN INTEGER;

  -- purpose: works out for the multiplier specification provided what the fully-pipelined latency will be - OVERLOADED VERSION FOR USE OUTSIDE THE CORE  
  FUNCTION calc_fully_pipelined_latency (family : STRING; a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : INTEGER; b_value : STRING) RETURN INTEGER;
  
  -- purpose: works out for the multiplier specification provided what the fully-pipelined latency will be
  FUNCTION calc_fully_pipelined_latency (family : T_DEVICE_FAMILY; a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : INTEGER; b_value : STRING) RETURN INTEGER;

  -- purpose: Performs any operand swapping for Virtex and Spartan-2 cores
  -- Don't have embedded multipliers in these families, so never add 1 for
  -- unsigned mults
  FUNCTION get_true_widths_virtex (family : T_DEVICE_FAMILY; c_a_width, c_b_width, c_a_type, c_b_type : INTEGER) RETURN WIDTH_REC;

  -- purpose: works out if the operands need to be swapped around and generates the correct widths for them
  -- these values can then be used to control the wire swapping in the hardware generation  
  FUNCTION get_true_widths(family : T_DEVICE_FAMILY; c_a_width, c_b_width, c_a_type, c_b_type : INTEGER; port_size : PORT_ASPECTS) RETURN WIDTH_REC;

  -- purpose: works out how many partial products are required for the A operand (number of DSPs/MULT18X18s)
  FUNCTION calc_a_pp(family : T_DEVICE_FAMILY; op_width : WIDTH_REC) RETURN INTEGER;

  -- purpose: works out how many partial products are required for the B operand (number of DSPs/MULT18X18s)
  -- note that there is no family restriction here because MULT18X18, DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier  
  FUNCTION calc_b_pp(op_width : WIDTH_REC) RETURN INTEGER;

  -- purpose: works out how many partial products are required for the A operand (number of DSPs/MULT18X18s)
  FUNCTION hybrid_calc_a_pp(family : T_DEVICE_FAMILY; op_width : WIDTH_REC) RETURN INTEGER;

  -- purpose: works out how many partial products are required for the B operand (number of DSPs/MULT18X18s)
  -- note that there is no family restriction here because MULT18X18, DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier
  FUNCTION hybrid_calc_b_pp(family : T_DEVICE_FAMILY; op_width : WIDTH_REC) RETURN INTEGER;

  -- purpose: works out which configuration of hybrid is required based on the input operand widths
  -- and types and the multiplier primitive being used
  FUNCTION get_hybrid_configuration(family     : T_DEVICE_FAMILY;
                                    a_pp, b_pp : INTEGER;
                                    op_width   : WIDTH_REC;
                                    port_size  : PORT_ASPECTS)RETURN INTEGER;

  -- purpose: works out the operand widths and types for the block multiplier subcomponent
  FUNCTION get_block_mult_cfg (family     : T_DEVICE_FAMILY;
                               a_pp, b_pp : INTEGER;
                               op_width   : WIDTH_REC;
                               hybrid_cfg : INTEGER;
                               port_size  : PORT_ASPECTS) RETURN BLOCK_MULT_REC;

  FUNCTION get_one_mult_cfg(width                                                    : WIDTH_REC;
                            block_a_width, block_a_type, block_b_width, block_b_type : INTEGER;
                            hybrid_cfg                                               : INTEGER;
                            port_size                                                : PORT_ASPECTS) RETURN ONE_MULT_REC;

  -- purpose: works out the required operand widths of the fabric multiplier for the 'two mult' case
  FUNCTION get_two_mult_cfg(op_width                         : WIDTH_REC;
                            a_width, a_type, b_width, b_type : INTEGER;
                            hybrid_cfg                       : INTEGER) RETURN TWO_MULT_REC;

  -- purpose: works out fully-pipelined latency of a LUT multiplier
  FUNCTION fab_mult_full_pipe_lat(a_width, b_width : INTEGER) RETURN INTEGER;

  -- purpose: works out how many pipeline stages a particular configuration of DSPs or MULT18s needs
  -- for max performance
  FUNCTION get_emb_mult_max_pipe_stages (family : T_DEVICE_FAMILY; a_pp, b_pp : INTEGER) RETURN INTEGER;

  -- purpose: works out the depth of the adder tree on the LUT multiplier(s)
  -- to see what the maximum fully-pipelined latency will be
  FUNCTION get_LUT_max_pipe_stages (one_mult_cfg : ONE_MULT_REC; two_mult_cfg : TWO_MULT_REC; hybrid_configuration : INTEGER) RETURN INTEGER;

  -- purpose: checks to see if the constant has any zeros at the MSB (left) side of the string and
  -- returns an integer to say how many consecutive zeros there are
  -- These zeros don't need to go through the multiplier, so we could save some
  -- logic in a few cases
  -- If the constant is of signed type, we need to keep one of the leading zeros
  -- If the constant is signed though, we can also check for leading ones and
  -- trim them, stopping when we find "10" when searching from the left-hand side
  FUNCTION get_trimmed_leading_bits (b_value : STRING; b_type : INTEGER; mult_type : INTEGER) RETURN INTEGER;

  -- purpose: counts the number of LSB zeros in the supplied constant STRING
  -- If the bits are zero, we don't need to pass these bits into the multiplier
  -- and we can just right-shift the output by these number of bits 
  FUNCTION get_output_scaling (b_value : STRING; b_type : INTEGER; mult_type : INTEGER) RETURN INTEGER;

  -- purpose: checks if the constant is all-zeros, in which case there is no point in creating logic!
  FUNCTION check_b_value_all_zeros (b_value : STRING) RETURN BOOLEAN;
  
-------------------------------------------------------------------------------
-- Functions, constants, types imported from ccm_pkg.vhd
-------------------------------------------------------------------------------  

  CONSTANT C_DISTRIBUTED : INTEGER := 0;
  CONSTANT C_SP_BLOCK    : INTEGER := 1;
  CONSTANT C_DP_BLOCK    : INTEGER := 2;

  CONSTANT NEW_LINE : STRING(1 TO 1) := (1 => LF);  -- FOR ASSERTION REPORTS

  CONSTANT A_MAX_WIDTH : INTEGER := 64;

  -- a_max_width is the only thing that needs to be modified in order to
  -- support wider input buses (for the CCM subcore at least...)
  -- max number of partial products - add 2 as contingency for a_signed
  CONSTANT MAX_NUM_PPS : INTEGER := (A_MAX_WIDTH+2)/4;


  FUNCTION calc_reqd_b_value(b_value      : STRING;
                             b_width      : INTEGER;
                             b_type       : INTEGER;
                             reqd_b_width : INTEGER) RETURN STRING;

  FUNCTION bitstorep_string(a_value : STRING;
                            a_type  : INTEGER) RETURN NATURAL;

  FUNCTION calc_shift_bits(b_value    : STRING;
                           b_constant : INTEGER) RETURN INTEGER;

  FUNCTION get_rom_addr_width(family : T_DEVICE_FAMILY; mem_type : INTEGER) RETURN INTEGER;

  FUNCTION calc_a_input_width(operand_width, has_a_signed, rom_addr_width, b_constant : INTEGER) RETURN INTEGER;

  FUNCTION calc_num_pps(a_width, rom_addr_width : INTEGER) RETURN INTEGER;

  -- TYPE for storing information about symmetric adders
  TYPE adder_info_type IS RECORD
    a_input         : INTEGER;
    b_input         : INTEGER;
    a_width         : INTEGER;
    b_width         : INTEGER;
    b_type          : INTEGER;
    b_pipe_regs     : INTEGER;
    scale_by        : INTEGER;
    drop_lsbs       : INTEGER;
    out_width       : INTEGER;
    pipe_stages     : INTEGER;          -- new in V9.0!
    row             : INTEGER;          -- redundant
    col             : INTEGER;          -- redundant
    height_limit    : INTEGER;          -- redundant
    height          : INTEGER;          -- redundant
    has_o           : BOOLEAN;          -- redundant
    has_q           : BOOLEAN;          -- redundant
    place_above_mem : BOOLEAN;          -- redundant
  END RECORD;

  FUNCTION calc_adder_level(adder_num, max_add_levels : INTEGER) RETURN INTEGER;
  
  FUNCTION calc_last_pp_input_width(operand_width, has_a_signed,
                                    rom_addr_width, b_constant : INTEGER) RETURN INTEGER;

  FUNCTION calc_pp_width(b_width      : INTEGER;
                         b_type       : INTEGER;
                         b_value      : STRING;
                         b_constant   : INTEGER;
                         a_width      : INTEGER;
                         a_type       : INTEGER;
                         has_a_signed : INTEGER;
                         last_pp      : BOOLEAN;
                         full_prod    : BOOLEAN) RETURN INTEGER;

  FUNCTION calc_last_pp_adder(num_pps          : INTEGER;
                              max_add_levels   : INTEGER;
                              num_adders       : INTEGER;
                              num_extra_adders : INTEGER) RETURN INTEGER;

  FUNCTION calc_last_rom_contents(b_width            : INTEGER;
                                  a_width            : INTEGER;
                                  a_type             : INTEGER;
                                  b_type             : INTEGER;
                                  has_a_signed       : INTEGER;
                                  rom_addr_width     : INTEGER;
                                  rom_depth          : INTEGER;
                                  rom_width          : INTEGER;
                                  start_bit          : INTEGER;
                                  b_value            : STRING;
                                  b_constant         : INTEGER;
                                  num_rom_bits       : INTEGER;
                                  number_of_pps      : INTEGER;
                                  a_signed_extension : BOOLEAN)  RETURN BIT_VECTOR;

  FUNCTION calc_rom_contents(b_width        : INTEGER;
                             b_type         : INTEGER;
                             rom_addr_width : INTEGER;
                             rom_depth      : INTEGER;
                             rom_width      : INTEGER;
                             start_bit      : INTEGER;
                             b_value        : STRING;
                             num_rom_bits   : INTEGER) RETURN BIT_VECTOR;

  FUNCTION calc_rom_start_bit(b_width          : INTEGER;
                              b_value          : STRING;
                              b_constant       : INTEGER;
                              pp_width         : INTEGER;
                              a_type           : INTEGER;
                              rom_has_a_signed : INTEGER;
                              mem_type         : INTEGER;
                              mem_addr_width   : INTEGER;
                              pipeline         : INTEGER;
                              num_adders       : INTEGER;
                              has_q            : INTEGER;
                              last_mem         : BOOLEAN) RETURN INTEGER;

  FUNCTION calc_num_extra_adders(num_pps, max_num_pps : INTEGER) RETURN INTEGER;
  
  FUNCTION get_mem_type(family          : T_DEVICE_FAMILY;
                        mem_type        : INTEGER;
                        bram_addr_width : INTEGER;
                        has_swapb       : INTEGER;
                        a_width         : INTEGER;
                        a_type          : INTEGER;
                        has_a_signed    : INTEGER;
                        b_constant      : INTEGER;
                        has_o           : INTEGER) RETURN INTEGER;

  FUNCTION bitsneededtorepresent(a_value : NATURAL) RETURN NATURAL;
  
  FUNCTION bitstorep_bv(a_value    : BIT_VECTOR;
                        a_type     : INTEGER;
                        a_positive : BOOLEAN) RETURN NATURAL;

  FUNCTION int_2_string(int_value : INTEGER) RETURN STRING;

  FUNCTION mult_gen_max_of(i0, i1 : INTEGER) RETURN INTEGER;

  FUNCTION multiply_bv(a, b : BIT_VECTOR; a_signed, b_signed : BOOLEAN) RETURN BIT_VECTOR;

  FUNCTION natural_to_bit_vector(in_val : IN NATURAL; length : IN NATURAL) RETURN BIT_VECTOR;

  FUNCTION mult_gen_select_string(i0 : STRING; i1 : STRING; sel : BOOLEAN) RETURN STRING;

  FUNCTION select_val(i0 : INTEGER; i1 : INTEGER; sel : BOOLEAN) RETURN INTEGER;

  FUNCTION select_val_int(i0 : INTEGER; i1 : INTEGER; sel : INTEGER) RETURN INTEGER;

  FUNCTION str_to_bv(bitsin : STRING; nbits : INTEGER) RETURN BIT_VECTOR;

  FUNCTION slv_to_str(bitsin : STD_LOGIC_VECTOR; nbits : INTEGER) RETURN STRING;

  FUNCTION str_to_slv(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR;

  TYPE int_array_type IS ARRAY(NATURAL RANGE <>) OF INTEGER;

  -----------------------------------------------------------------------------
  -- Functions, types, constants from ccm_mem_utils
  -----------------------------------------------------------------------------

  -- Cannot have a dist mem > 'deepest_dist_mem' - have to use block mem
  CONSTANT deepest_dist_mem : NATURAL := 256;

  CONSTANT c_automatic : INTEGER := -1;

  FUNCTION calc_depth(reqd_depth : INTEGER; mem_type : INTEGER) RETURN INTEGER;

  IMPURE FUNCTION mult_gen_write_meminit_file(filename : IN STRING; depth : IN POSITIVE; width : IN POSITIVE; memvect : IN BIT_VECTOR) RETURN BOOLEAN;
  
END PACKAGE pkg_mult_gen_v10_0;

PACKAGE BODY pkg_mult_gen_v10_0 IS

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
                          has_load_done, has_zero_detect, round_output, c_round_pt : INTEGER;
                          mem_init_prefix                                          : STRING;
                          use_p_cascade_out                                        : INTEGER)   RETURN BOOLEAN IS
  BEGIN  -- FUNCTION check_generics

    -- check that the family info is valid - leave all other checks up to CoreGen and the XCD file
    ASSERT derived(xdevicefamily, "any") REPORT "ERROR: mult_gen_v10_0: c_xdevicefamily generic invalid" SEVERITY failure;
    ASSERT derived(i_family, "any") REPORT "INTERNAL ERROR: mult_gen_v10_0: ci_family invalid" SEVERITY failure;

    -- check that the A and B types are valid
    ASSERT a_type = C_SIGNED OR a_type = C_UNSIGNED REPORT "ERROR: mult_gen_v10_0: c_a_type should be 0 (signed) or 1 (unsigned)" SEVERITY error;
    ASSERT b_type = C_SIGNED OR b_type = C_UNSIGNED REPORT "ERROR: mult_gen_v10_0: c_b_type should be 0 (signed) or 1 (unsigned)" SEVERITY error;

    -- check that the port widths are valid, based on the operand types and the multiplier type
    ASSERT a_width+a_type >= 2 AND a_width < 65 REPORT "ERROR: mult_gen_v10_0: c_a_width must be in the range 2->64 for signed data and 1->64 for unsigned data" SEVERITY failure;
    ASSERT b_width+b_type >= 2 AND b_width < 65 REPORT "ERROR: mult_gen_v10_0: c_b_width must be in the range 2->64 for signed data and 1->64 for unsigned data" SEVERITY failure;

    -- check that c_out_high and c_out_low are valid - allow a larger upper bound if the FPO is calling the multiplier and is using the PCOUT port
    IF use_p_cascade_out = 1 THEN
      ASSERT out_high >= 0 AND out_high <= 147 REPORT "ERROR: mult_gen_v10_0_xst: c_out_high must be in the range 0 to 147" SEVERITY failure;
      ASSERT out_low >= 0 AND out_low   <= 147 AND out_low <= out_high REPORT "ERROR: mult_gen_v10_0_xst: c_out_low must be in the range 0 to 147 and <= c_out_high" SEVERITY failure;
    ELSE
      ASSERT out_high >= 0 AND out_high <= 127 REPORT "ERROR: mult_gen_v10_0_xst: c_out_high must be in the range 0 to 127" SEVERITY failure;
      ASSERT out_low >= 0 AND out_low   <= 127 AND out_low <= out_high REPORT "ERROR: mult_gen_v10_0_xst: c_out_low must be in the range 0 to 127 and <= c_out_high" SEVERITY failure;
    END IF;
    
    -- check that mult_type is valid
    ASSERT mult_type = LUT OR mult_type = EMBEDDED_MULT OR mult_type = FIXED_CCM REPORT "ERROR: mult_gen_v10_0: c_mult_type must be 0, 1 or 2" SEVERITY failure;

    IF mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM THEN
      REPORT "Static and dynamic reloadable CCMs are not supported in Multiplier V9.0 - use a parallel multiplier if this functionality is required" SEVERITY failure;
    END IF;

    -- some specific checks on mult_type based on the family info
    IF mult_type = EMBEDDED_MULT THEN
      ASSERT i_family /= "virtex" REPORT "ERROR: mult_gen_v10_0: Virtex (or Spartan-2) does not have embedded multipliers - set c_mult_type to 0 for a LUT multiplier" SEVERITY failure;
    END IF;

    -- check that opt_goal is valid
    IF mult_type = LUT OR mult_type = EMBEDDED_MULT THEN
      ASSERT opt_goal = EMB_MULT_RESOURCES OR opt_goal = CORE_SPEED REPORT "ERROR: mult_gen_v10_0: c_opt_goal must be 0 (optimize for embedded mult resources) or 1 (optimize for core speed)" SEVERITY failure;
    ELSE
      -- don't care - generic doesn't apply to CCMs
      NULL;
    END IF;

    -- check has_ce, has_sclr, ce_overrides_sclr
    ASSERT has_ce = MG_NO OR has_ce = MG_YES REPORT "ERROR: mult_gen_v10_0: c_has_ce must be 0 or 1" SEVERITY failure;
    ASSERT has_Sclr = MG_NO OR has_sclr = MG_YES REPORT "ERROR: mult_gen_v10_0: c_has_sclr must be 0 or 1" SEVERITY failure;
    ASSERT ce_overrides_sclr = MG_NO OR ce_overrides_sclr = MG_YES REPORT "ERROR: mult_gen_v10_0: c_ce_overrides_sclr must be 0 or 1" SEVERITY failure;

    -- check pipe_stages is valid
    ASSERT (pipe_stages >= 0 AND pipe_stages <= MAX_PIPE_STAGES) OR pipe_stages >= PIPELINE_CFG_BREAKPT REPORT "ERROR: mult_gen_v10_0: c_pipe_stages must be > 0 and < " & INTEGER'image(MAX_PIPE_STAGES) & " (or >= " & INTEGER'image(PIPELINE_CFG_BREAKPT) & " for bit pattern mode)" SEVERITY failure;

    -- check ccm_imp is valid - depends on mult_type
    IF mult_type = FIXED_CCM THEN
      ASSERT ccm_imp = DIST_MEM OR ccm_imp = BRAM OR ccm_imp = MULTS REPORT "ERROR: mult_gen_v10_0: c_ccm_imp must be 0, 1 or 2" SEVERITY failure;
    ELSE
      -- we don't care - it's a parallel multiplier
      NULL;
    END IF;

    -- check b_value is not a null string if it's a CCM
    IF mult_type = FIXED_CCM THEN
      ASSERT b_value'length /= 0 REPORT "ERROR: mult_gen_v10_0: c_b_value string length is zero" SEVERITY failure;
    ELSE
      -- we don't care, as b_value's not used
      NULL;
    END IF;

    -- check elaboration dir is not a null STRING
    IF mult_type = FIXED_CCM THEN
      ASSERT elaboration_dir'length /= 0 REPORT "ERROR: mult_gen_v10_0: c_elaboration_dir STRING length is zero" SEVERITY failure;
    ELSE
      -- we don't care as we don't write out MIF files...
      NULL;
    END IF;

    IF mult_type = LUT OR mult_type = EMBEDDED_MULT THEN
      ASSERT has_zero_detect = MG_NO OR has_zero_detect = MG_YES REPORT "ERROR: mult_gen_v10_0: c_has_zero_detect must be 0 or 1" SEVERITY failure;
    ELSE
      ASSERT has_zero_detect = MG_NO REPORT "WARNING: mult_gen_v10_0: Zero Detection is only supported for parallel multipliers" SEVERITY warning;
    END IF;

    IF mult_type = EMBEDDED_MULT AND ((fn_check_family(i_family)) = VIRTEX4 OR (fn_check_family(i_family)) = VIRTEX5) THEN
      ASSERT round_output = MG_NO OR round_output = MG_YES REPORT "ERROR: mult_gen_v10_0: c_round_output must be 0 or 1" SEVERITY failure;
      IF fn_check_family(i_family) = VIRTEX4 AND round_output = MG_YES THEN
        ASSERT a_width+a_type <= 18 AND b_width+b_type <= 18 REPORT "ERROR: mult_gen_v10_0: Symmetric rounding is only supported for a single DSP48 in Virtex-4" SEVERITY failure;
      ELSIF fn_check_family(i_family) = VIRTEX5 AND round_output = MG_YES THEN
        ASSERT a_width+a_type <= 25 AND b_width+b_type <= 18 REPORT "ERROR: mult_gen_v10_0: Symmetric rounding is only supported for a single DSP48E in Virtex-5" SEVERITY failure;
      END IF;
    ELSE
      -- don't allow rounding for other multipliers - expensive
      ASSERT round_output = MG_NO REPORT "ERROR: mult_gen_v10_0: Rounding is only supported for Virtex-4 and Virtex-5 DSP48(E)-based multipliers" SEVERITY failure;
    END IF;

    RETURN true;
  END FUNCTION check_generics;

  -- purpose: catches the case where the xdevicefamily is Spartan-3E, 3A or 3ADSP and modifies the family info accordingly
  -- There aren't any shared functions to do this, but the only piece of IP where this really matters is the multiplier
  FUNCTION modify_family(family_str : STRING) RETURN STRING IS
  BEGIN  -- FUNCTION modify_family
    IF family_str = "spartan3e" OR family_str = "aspartan3e" THEN
      RETURN "spartan3e";
    ELSIF family_str = "spartan3a" THEN
      RETURN "spartan3a";
    ELSIF family_str = "spartan3adsp" THEN
      RETURN "spartan3adsp";
    ELSE      
      RETURN c_xdevicefamily_to_c_family(family_str);
    END IF;
  END FUNCTION modify_family;
  
  FUNCTION sl_to_int(sl : STD_LOGIC) RETURN INTEGER IS
  BEGIN  -- FUNCTION sl_to_int
    IF sl = '1' THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION sl_to_int;

  FUNCTION mult_gen_log2(x : INTEGER) RETURN INTEGER IS
    VARIABLE y            : INTEGER;
    VARIABLE two_to_the_y : INTEGER;
  BEGIN
    y            := 0;
    two_to_the_y := 1;

    WHILE (two_to_the_y < x) LOOP
      y            := y+1;
      two_to_the_y := two_to_the_y * 2;
    END LOOP;

    RETURN y;
  END mult_gen_log2;

  FUNCTION mult_gen_log2d(x : INTEGER) RETURN INTEGER IS
    VARIABLE y            : INTEGER;
    VARIABLE two_to_the_y : INTEGER;
  BEGIN
    y            := 0;
    two_to_the_y := 1;

    WHILE (two_to_the_y < x) LOOP
      y            := y+1;
      two_to_the_y := two_to_the_y * 2;
    END LOOP;

    IF two_to_the_y > x THEN
      y := y - 1;
    END IF;

    RETURN y;
  END mult_gen_log2d;

  -- Overloaded version of the internal-use calc_fully_pipelined_latency which
  -- allows c_xdevicefamily to be passed in instead of having to cast to the
  -- internal device enumerated type
  FUNCTION calc_fully_pipelined_latency (family                                                         : STRING;
                                         a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : INTEGER;
                                         b_value                                                        : STRING) RETURN INTEGER IS
    CONSTANT real_family : STRING                   := modify_family(family);
    CONSTANT enum_family : T_DEVICE_FAMILY := fn_check_family(real_family);
  BEGIN
    
    RETURN calc_fully_pipelined_latency(enum_family, a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp, b_value);
    
  END calc_fully_pipelined_latency;
  
  FUNCTION calc_fully_pipelined_latency (family                                                         : T_DEVICE_FAMILY;
                                         a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : INTEGER;
                                         b_value                                                        : STRING) RETURN INTEGER IS
    -- General use variables
    VARIABLE latency               : INTEGER := 0;
    VARIABLE a_pp                  : INTEGER := 0;
    VARIABLE b_pp                  : INTEGER := 0;
    VARIABLE num_pp                : INTEGER := 0;
    VARIABLE op_width              : WIDTH_REC;
    VARIABLE port_size             : PORT_ASPECTS;
    -- variables for the CCM calculations
    VARIABLE rom_latency           : INTEGER := 0;
    VARIABLE rom_addr_width        : INTEGER := 0;
    VARIABLE a_input_width         : INTEGER := 0;
    VARIABLE num_pps               : INTEGER := 0;
    VARIABLE const_power_of_two : boolean := false;
    VARIABLE const_is_zero : BOOLEAN := false;
    -- variables for the hybrid configurations
    VARIABLE widths                : WIDTH_REC;
    VARIABLE block_mult_pipeline   : INTEGER;
    VARIABLE block_mult_output_pipeline : INTEGER;
    VARIABLE hybrid_cfg            : INTEGER;
    VARIABLE block_mult_cfg        : BLOCK_MULT_REC;
    VARIABLE one_mult_cfg          : ONE_MULT_REC;
    VARIABLE two_mult_cfg          : TWO_MULT_REC;
    VARIABLE top_mult_a_width      : INTEGER := 0;
    VARIABLE top_mult_b_width      : INTEGER := 0;
    VARIABLE side_mult_a_width     : INTEGER := 0;
    VARIABLE side_mult_b_width     : INTEGER := 0;
    VARIABLE deepest_lut_mult_tree : INTEGER := 0;
    VARIABLE deepest_pipeline      : INTEGER := 0;
    VARIABLE adder_latency         : INTEGER := 0;
    VARIABLE fab_prereg            : INTEGER := 0;
    VARIABLE Creg                  : INTEGER := 0;
    -- variables for the embedded mult CCM
    VARIABLE trimmed_msbs          : INTEGER := 0;
    VARIABLE trimmed_lsbs          : INTEGER := 0;
  BEGIN  -- FUNCTION calc_fully_pipelined_latency

    -- set up the port sizes for all families
    port_size.a := 18+(7*BOOLEAN'pos(family = VIRTEX5));
    port_size.b := 18;
    port_size.m := 36+(7*BOOLEAN'pos(family = VIRTEX5));
    port_size.c := 48;
    port_size.p := 48;

    IF mult_type = FIXED_CCM THEN
      -- check to see if the constant is exactly a (positive) power of 2
      -- use this to set up the latency of the fixed CCM later on
      trimmed_msbs := get_trimmed_leading_bits(b_value, b_type, mult_type);
      trimmed_lsbs := calc_shift_bits(b_value, 1);
      const_power_of_two := ((b_value'length - (trimmed_msbs + trimmed_lsbs)) = 1);
      const_is_zero := check_b_value_all_zeros(b_value);
    END IF;
    
    CASE family IS
      WHEN VIRTEX | SPARTAN2 =>
        -- swap the operands around to get the best operand size for each port
        op_width := get_true_widths_virtex(family, a_width, b_width, a_type, b_type);
      WHEN OTHERS =>
        -- swap the operands around to get the best operand size for each PORT
        -- Any invalid families will be caught in this routine
        op_width := get_true_widths(family, a_width, b_width, a_type, b_type, port_size);
    END CASE;

    CASE mult_type IS
      WHEN LUT =>
        IF get_min(a_width, b_width) = 1 THEN
          latency := 1;
        ELSE
          latency := mult_gen_log2(get_min(a_width, b_width));
        END IF;
      WHEN EMBEDDED_MULT =>
        CASE opt_goal IS
          WHEN CORE_SPEED =>
            a_pp   := calc_a_pp(family, op_width);
            b_pp   := calc_b_pp(op_width);
            num_pp := a_pp * b_pp;
            CASE family IS
              WHEN VIRTEX4 | VIRTEX5 =>
                -- latency is determined by # DSP48(E)s used - call a_pp and b_pp calculation functions
                latency := num_pp + 2;  -- A/Breg + Mreg in first DSP + Pregs in all DSPs above it in the column
              WHEN SPARTAN3ADSP =>
                -- There's no simple formula to work out what the latency will
                -- be based on the number of DSPs.  It depends how many wireshifts we need in
                -- the fabric (i.e. how many times the C port needs to be used)
                IF a_pp = 1 AND b_pp = 1 THEN
                  latency := 3;
                ELSIF a_pp = 2 AND b_pp = 1 THEN
                  latency := 5;
                ELSIF a_pp = 3 AND b_pp = 1 THEN
                  latency := 7;
                ELSIF a_pp = 4 AND b_pp = 1 THEN
                  latency := 9;
                ELSIF a_pp = 2 AND b_pp = 2 THEN
                  latency := 8;
                ELSIF a_pp = 3 AND b_pp = 2 THEN
                  latency := 11;
                ELSIF a_pp = 3 AND b_pp = 3 THEN
                  latency := 15;
                ELSIF a_pp = 4 AND b_pp = 2 THEN                  
                  latency := 14;
                ELSIF a_pp = 4 AND b_pp = 3 THEN
                  latency := 19;
                ELSIF a_pp = 4 AND b_pp = 4 THEN
                  latency := 24;
                END IF;                
              WHEN VIRTEX2 | SPARTAN3 | SPARTAN3E | SPARTAN3A =>
                -- latency is determined by depth of adder tree required, which is determined by the number of Mult18x18s required
                -- Add two for the register stage and fabric register in V2 and S3 multipliers, add 3 for the
                -- Mult18x18SIO in S3E - 2 for the multiplier and 1 for the post-output fabric
                latency := mult_gen_log2(num_pp) + 2 + (BOOLEAN'pos(family = SPARTAN3E OR family = SPARTAN3A));
              WHEN OTHERS =>
                REPORT "invalid family caught in EMB_MULT/CORE_SPEED in calc_fully_pipelined_latency"
                  SEVERITY failure;
            END CASE;
          WHEN EMB_MULT_RESOURCES =>
            -- fully-pipelined latency depends on if the fabric portion or the
            -- embedded mult portion is deeper in terms of registers
            widths.a      := a_width;
            widths.a_type := a_type;
            widths.b      := b_width;
            widths.b_type := b_type;
            CASE family IS
              WHEN VIRTEX4 | VIRTEX5 | SPARTAN3ADSP =>

                -- New approach
                -- Consider paths to the adder in the DSP48x

                -- Areg/Breg + Mreg gives 2 cycles of latency
                block_mult_pipeline := 2;

                -- The pipeline after the DSP48x adder is defined by the number
                -- of DSPs used (number of registers in the P cascade)
                a_pp   := hybrid_calc_a_pp(family, widths);
                b_pp   := hybrid_calc_b_pp(family, widths);
                block_mult_output_pipeline := a_pp * b_pp;                                
                ASSERT NOT(debug) REPORT "block_mult_output_pipeline is " & INTEGER'image(block_mult_output_pipeline) SEVERITY note;
                
                hybrid_cfg     := get_hybrid_configuration(family, a_pp, b_pp, widths, port_size);
                block_mult_cfg := get_block_mult_cfg (family, a_pp, b_pp, widths, hybrid_cfg, port_size);
                ASSERT NOT(debug) REPORT "hybrid_cfg is " & INTEGER'image(hybrid_cfg) SEVERITY note;
                
                IF hybrid_cfg = ONE_MULT THEN
                  one_mult_cfg := get_one_mult_cfg(widths,
                                                   block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type,
                                                   hybrid_cfg, port_size);
                  top_mult_a_width      := one_mult_cfg.a;
                  top_mult_b_width      := one_mult_cfg.b;
                  side_mult_a_width     := 0;
                  side_mult_b_width     := 0;
                  deepest_lut_mult_tree := fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width);
                ELSIF hybrid_cfg = TWO_MULT THEN
                  two_mult_cfg          := get_two_mult_cfg(widths, block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type, hybrid_cfg);
                  top_mult_a_width      := two_mult_cfg.a_top;
                  top_mult_b_width      := two_mult_cfg.b_top;
                  side_mult_a_width     := two_mult_cfg.a_side;
                  side_mult_b_width     := two_mult_cfg.b_side;
                  ASSERT NOT(debug) REPORT "top_mult_a_width = " & INTEGER'image(top_mult_a_width) SEVERITY note;
                  ASSERT NOT(debug) REPORT "top_mult_b_width = " & INTEGER'image(top_mult_b_width) SEVERITY note;
                  ASSERT NOT(debug) REPORT "side_mult_a_width = " & INTEGER'image(side_mult_a_width) SEVERITY note;
                  ASSERT NOT(debug) REPORT "side_mult_b_width = " & INTEGER'image(side_mult_b_width) SEVERITY note;
                  deepest_lut_mult_tree := get_max(fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width), fab_mult_full_pipe_lat(side_mult_a_width, side_mult_b_width));
                END IF;

                IF hybrid_cfg = BASE_MULT THEN
                  adder_latency := 0;
                  Creg := 0;
                ELSIF hybrid_cfg = ONE_MULT THEN                  
                  adder_latency := 0;
                  Creg := 1;
                ELSIF hybrid_cfg = TWO_MULT THEN
                  adder_latency := 1;
                  Creg := 1;
                END IF;

                ASSERT NOT(debug) REPORT "deepest_lut_mult_tree is " & INTEGER'image(deepest_lut_mult_tree) SEVERITY note;
                
                -- Work out the deepest path to the adder in the LS DSP48
                deepest_pipeline := get_max(block_mult_pipeline, (deepest_lut_mult_tree + adder_latency + Creg));

                ASSERT NOT(debug) REPORT "deepest_pipeline is " & INTEGER'image(deepest_pipeline) SEVERITY note;
                
                -- Don't actually need the pre-register for best performance...
                fab_prereg := 0;
                
                latency := fab_prereg + deepest_pipeline + block_mult_output_pipeline;
                                
              WHEN VIRTEX2 | SPARTAN3 | SPARTAN3E | SPARTAN3A =>
                -- calc number of emb mults
                -- calc_tree_latency via mult_gen_log2 routine
                -- if V2 or S3, add 2 to tree lat
                -- if S3E, add 3 to tree lat
                -- get configuration of hybrid
                -- get widths of lut mults
                -- get max depth of the lut mults, if they are required
                -- work out max depth from lut mults and the embedded mult
                -- add in any adder latency to this final value
                a_pp   := hybrid_calc_a_pp(family, widths);
                b_pp   := hybrid_calc_b_pp(family, widths);
                num_pp := a_pp * b_pp;

                -- work out the latency of the adder tree based on the number
                -- on embedded multipliers used, and then add the latency of
                -- the embedded multipliers themselves for best performance
                IF family = VIRTEX2 OR family = SPARTAN3 THEN
                  block_mult_pipeline := mult_gen_log2(num_pp) + 2;
                ELSIF family = SPARTAN3E OR family = SPARTAN3A THEN
                  block_mult_pipeline := mult_gen_log2(num_pp) + 3;
                END IF;

                hybrid_cfg     := get_hybrid_configuration(family, a_pp, b_pp, widths, port_size);
                block_mult_cfg := get_block_mult_cfg (family, a_pp, b_pp, widths, hybrid_cfg, port_size);

                IF hybrid_cfg = ONE_MULT THEN
                  one_mult_cfg := get_one_mult_cfg(widths,
                                                   block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type,
                                                   hybrid_cfg, port_size);
                  top_mult_a_width      := one_mult_cfg.a;
                  top_mult_b_width      := one_mult_cfg.b;
                  side_mult_a_width     := 0;
                  side_mult_b_width     := 0;
                  deepest_lut_mult_tree := fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width);
                ELSIF hybrid_cfg = TWO_MULT THEN
                  two_mult_cfg          := get_two_mult_cfg(widths, block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type, hybrid_cfg);
                  top_mult_a_width      := two_mult_cfg.a_top;
                  top_mult_b_width      := two_mult_cfg.b_top;
                  side_mult_a_width     := two_mult_cfg.a_side;
                  side_mult_b_width     := two_mult_cfg.b_side;
                  deepest_lut_mult_tree := get_max(fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width), fab_mult_full_pipe_lat(side_mult_a_width, side_mult_b_width));
                END IF;

                IF hybrid_cfg = BASE_MULT THEN
                  adder_latency := 0;
                ELSIF hybrid_cfg = ONE_MULT THEN
                  adder_latency := 0;
                ELSIF hybrid_cfg = TWO_MULT THEN
                  adder_latency := 1;
                END IF;
                
                deepest_pipeline := get_max(block_mult_pipeline, (deepest_lut_mult_tree + adder_latency));

                -- Add one cycle of latency for the register on the final adder
                -- which sums all the partial products together
                latency := deepest_pipeline + 1;

                
              WHEN OTHERS =>
                REPORT "ERROR: invalid family caught in EMB_MULT/EMB_MULT_RESOURCES in calc_fully_pipelined_latency"
                  SEVERITY failure;
            END CASE;
          WHEN OTHERS => NULL;
        END CASE;
      WHEN FIXED_CCM =>
        IF const_power_of_two OR const_is_zero THEN
          -- can perform the multiply just by bit-shifting - no logic required
          -- or just generate constant zeros at the output
          latency := 0;
        ELSE
          CASE ccm_imp IS

            WHEN DIST_MEM =>
              rom_latency := 1;

              IF family = VIRTEX5 THEN
                rom_addr_width := 6;
              ELSE
                rom_addr_width := 4;
              END IF;

              a_input_width := calc_a_input_width(a_width, 0, rom_addr_width, BOOLEAN'pos(mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM));
              num_pps       := calc_num_pps(a_input_width, rom_addr_width);

              -- log2 function will return 0 if 0 is input, which works for this application              
              latency := mult_gen_log2((num_pps * BOOLEAN'pos(num_pps > 1))) + rom_latency;
              
            WHEN BRAM =>
              IF family = VIRTEX4 OR family = VIRTEX5 OR FAMILY = SPARTAN3ADSP THEN
                -- add 1 cycle for speed-up register
                rom_latency := 3;
              ELSE
                rom_latency := 2;
              END IF;

              IF family = VIRTEX OR family = SPARTAN2 THEN
                rom_addr_width := 8;
              ELSE
                rom_addr_width := 9;
              END IF;

              a_input_width := calc_a_input_width(a_width, 0, rom_addr_width, BOOLEAN'pos(mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM));
              num_pps       := calc_num_pps(a_input_width, rom_addr_width);

              -- log2 function will return 0 if 0 is input, which works for this application
              latency := mult_gen_log2((num_pps * BOOLEAN'pos(num_pps > 1))) + rom_latency;
              
            WHEN MULTS =>
              -- modify op_width.b to reflect the number of bits from the
              -- constant value that actually need to go through the multiplier
              trimmed_lsbs := get_output_scaling(b_value, b_type, mult_type);
              trimmed_msbs := get_trimmed_leading_bits(b_value, b_type, mult_type);
              op_width.b   := b_value'length - (trimmed_lsbs + trimmed_msbs);
              a_pp         := calc_a_pp(family, op_width);
              b_pp         := calc_b_pp(op_width);
              num_pp       := a_pp * b_pp;
              CASE family IS
                WHEN VIRTEX4 | VIRTEX5 =>
                  -- latency is determined by # DSP48(E)s used - call a_pp and b_pp calculation functions
                  latency := num_pp + 2;  -- A/Breg + Mreg in first DSP + Pregs in all DSPs above it in the column
                WHEN SPARTAN3ADSP =>
                -- There's no simple formula to work out what the latency will
                -- be based on the number of DSPs.  It depends how many wireshifts we need in
                -- the fabric (i.e. how many times the C port needs to be used)
                IF a_pp = 1 AND b_pp = 1 THEN
                  latency := 3;
                ELSIF a_pp = 2 AND b_pp = 1 THEN
                  latency := 5;
                ELSIF a_pp = 3 AND b_pp = 1 THEN
                  latency := 7;
                ELSIF a_pp = 4 AND b_pp = 1 THEN
                  latency := 9;
                ELSIF a_pp = 2 AND b_pp = 2 THEN
                  latency := 8;
                ELSIF a_pp = 3 AND b_pp = 2 THEN
                  latency := 11;
                ELSIF a_pp = 3 AND b_pp = 3 THEN
                  latency := 15;
                ELSIF a_pp = 4 AND b_pp = 2 THEN                  
                  latency := 14;
                ELSIF a_pp = 4 AND b_pp = 3 THEN
                  latency := 19;
                ELSIF a_pp = 4 AND b_pp = 4 THEN
                  latency := 24;
                END IF;  
                WHEN VIRTEX2 | SPARTAN3 | SPARTAN3E | SPARTAN3A =>
                  -- latency is determined by depth of adder tree required, which is determined by the number of Mult18x18s required
                  -- Add one for the register stage in V2 and S3 multipliers, add 3 for the Mult18x18SIO in S3E - 2 for the multiplier and 1 for the post-output fabric
                  latency := mult_gen_log2(num_pp) + 2 + (BOOLEAN'pos(family = SPARTAN3E OR family = SPARTAN3A));
                WHEN OTHERS =>
                  REPORT "ERROR: invalid family caught in FIXED_CCM/MULTS in calc_fully_pipelined_latency"
                    SEVERITY failure;
              END CASE;
              
            WHEN CSD =>

              REPORT "WARNING: The core cannot calculate the fully-pipelined latency - check XST log (if available)" SEVERITY warning;
              latency := 0;
              
            WHEN OTHERS =>
              REPORT "ERROR: invalid c_ccm_imp caught in calc_fully_pipelined_latency" SEVERITY failure;
              
          END CASE;
        END IF;
      WHEN OTHERS =>
        REPORT "ERROR: invalid mult_type caught in calc_fully_pipelined_latency" SEVERITY failure;
    END CASE;
    RETURN latency;
  END FUNCTION calc_fully_pipelined_latency;

  FUNCTION get_true_widths_virtex (family                                   : T_DEVICE_FAMILY;
                                   c_a_width, c_b_width, c_a_type, c_b_type : INTEGER)   RETURN WIDTH_REC IS
    VARIABLE ret          : WIDTH_REC := (0, 0, 0, 0, false);
    CONSTANT full_a_width : INTEGER   := c_a_width;
    CONSTANT full_b_width : INTEGER   := c_b_width;
  BEGIN  -- FUNCTION get_true_widths_virtex
    IF full_a_width >= full_b_width THEN
      -- no swapping required
      ret.swap := false;
      ret.a    := c_a_width;
      ret.b    := c_b_width;
    ELSE
      -- need to swap the operands around
      ret.swap := true;
      ret.a    := c_b_width;
      ret.b    := c_a_width;
    END IF;
    RETURN ret;
  END FUNCTION get_true_widths_virtex;

  -- purpose: works out if the operands need to be swapped around and generates the correct widths for them
  -- these values can then be used to control the wire swapping in the hardware generation
  FUNCTION get_true_widths(family                                   : T_DEVICE_FAMILY;
                           c_a_width, c_b_width, c_a_type, c_b_type : INTEGER;
                           port_size                                : PORT_ASPECTS) RETURN WIDTH_REC IS
    VARIABLE ret          : WIDTH_REC := (0, 0, 0, 0, false);
    CONSTANT full_a_width : INTEGER   := c_a_width+c_a_type;
    CONSTANT full_b_width : INTEGER   := c_b_width+c_b_type;
  BEGIN  -- FUNCTION get_true_widths
    CASE family IS
      WHEN VIRTEX4 | VIRTEX2 | SPARTAN3 | SPARTAN3E | SPARTAN3A | SPARTAN3ADSP =>
        IF full_a_width >= full_b_width THEN
          -- no swapping required
          ret.swap := false;
          IF c_a_type = C_SIGNED THEN
            ret.a := c_a_width;
          ELSIF c_a_type = C_UNSIGNED THEN
            ret.a := c_a_width+1;
          END IF;
          IF c_b_type = C_SIGNED THEN
            ret.b := c_b_width;
          ELSIF c_b_type = C_UNSIGNED THEN
            ret.b := c_b_width+1;
          END IF;
          ret.a_type := c_a_type;
          ret.b_type := c_b_type;
        ELSE
          -- need to swap the operands around
          ret.swap := true;
          IF c_b_type = 0 THEN
            ret.a := c_b_width;
          ELSIF c_b_type = 1 THEN
            ret.a := c_b_width+1;
          END IF;
          IF c_a_type = C_SIGNED THEN
            ret.b := c_a_width;
          ELSIF c_a_type = C_UNSIGNED THEN
            ret.b := c_a_width+1;
          END IF;
          ret.a_type := c_b_type;
          ret.b_type := c_a_type;
        END IF;
      WHEN VIRTEX5 =>
        -- harder to work out when we need to swap the operands over here
        -- because of the asymmetric multiplier - more efficient for some widths not to swap the operands!

        -- check to see if the operand sizes as they are supplied to the core
        -- fit one of the optimal array configurations - if not, we want to
        -- swap A and B over since that will fit one of the patterns
        -- i.e. 42x64 and 64x42 will both be implemented on an a_pp=2, b_pp=4
        -- array rather than using the (much larger) a_pp=4, b_pp=3 array

        -- 1x1
        IF (full_a_width <= 25 AND full_b_width <= 18)
          -- 1x2
          OR (full_a_width                        <= 25 AND full_b_width > 18 AND full_b_width <= 35 AND NOT(full_a_width <= 18 AND full_b_width <= 25))
          -- 1x3
          OR (full_a_width                        <= 25 AND full_b_width > 35 AND full_b_width <= 52 AND NOT(full_a_width <= 18 AND full_b_width <= 42))
          -- 1x4
          OR (full_a_width                        <= 25 AND full_b_width > 52 AND full_b_width <= 69 AND NOT(full_a_width <= 18 AND full_b_width <= 69))
          -- 2x1
          OR (full_a_width > 25 AND full_a_width  <= 42 AND full_b_width <= 18)
          -- 2x2
          OR (full_a_width > 25 AND full_a_width  <= 42 AND full_b_width > 18 AND full_b_width <= 35 AND NOT(full_a_width <= 35 AND full_b_width <= 25))
          -- 2x3
          OR (full_a_width > 25 AND full_a_width  <= 42 AND full_b_width > 35 AND full_b_width <= 52 AND NOT(full_a_width <= 35 AND full_b_width <= 42))
          -- 2x4
          OR (full_a_width > 25 AND full_a_width  <= 42 AND full_b_width > 52 AND full_b_width <= 69 AND NOT(full_a_width <= 35 AND full_b_width <= 59))
          -- 3x1
          OR (full_a_width > 42 AND full_a_width  <= 59 AND full_b_width <= 18)
          -- 3x2
          OR (full_a_width > 42 AND full_a_width  <= 59 AND full_b_width > 18 AND full_b_width <= 35 AND NOT(full_a_width <= 52 AND full_b_width <= 25))
          -- 3x3
          OR (full_a_width > 42 AND full_a_width  <= 59 AND full_b_width > 35 AND full_b_width <= 52 AND NOT(full_a_width <= 52 AND full_b_width <= 42))
          -- 3x4
          OR (full_a_width > 42 AND full_a_width  <= 59 AND full_b_width > 52 AND full_b_width <= 69 AND NOT(full_a_width <= 52 AND full_b_width <= 59))
          -- 4x1
          OR (full_a_width > 59 AND full_a_width  <= 76 AND full_b_width <= 18)
          -- 4x2
          OR (full_a_width > 59 AND full_a_width  <= 76 AND full_b_width > 18 AND full_b_width <= 35 AND NOT(full_a_width <= 69 AND full_b_width <= 25))
          -- 4x3
          OR (full_a_width > 59 AND full_a_width  <= 76 AND full_b_width > 35 AND full_b_width <= 52 AND NOT(full_a_width <= 69 AND full_b_width <= 42))
          -- 4x4
          OR ((full_a_width > 59 AND full_a_width <= 76 AND full_b_width > 52 AND full_b_width <= 69) AND NOT(full_a_width <= 69 AND full_b_width <= 59)) THEN
          -- don't swap the operands round - they fit one of the optimal patterns already
          ret.swap                                := false;
          IF c_a_type = C_SIGNED THEN
            ret.a := c_a_width;
          ELSIF c_a_type = C_UNSIGNED THEN
            ret.a := c_a_width+1;
          END IF;
          IF c_b_type = C_SIGNED THEN
            ret.b := c_b_width;
          ELSIF c_b_type = C_UNSIGNED THEN
            ret.b := c_b_width+1;
          END IF;
          ret.a_type := c_a_type;
          ret.b_type := c_b_type;
        ELSE
          -- operand sizes don't fit one of the optimal patterns,
          -- so swap them around so that they will fit one of the patterns
          ret.swap := true;
          ASSERT NOT(debug) REPORT "swapping operands internally" SEVERITY note;
          IF c_b_type = 0 THEN
            ret.a := c_b_width;
          ELSIF c_b_type = 1 THEN
            ret.a := c_b_width+1;
          END IF;
          IF c_a_type = C_SIGNED THEN
            ret.b := c_a_width;
          ELSIF c_a_type = C_UNSIGNED THEN
            ret.b := c_a_width+1;
          END IF;
          ret.a_type := c_b_type;
          ret.b_type := c_a_type;
        END IF;
      WHEN OTHERS =>
        ASSERT false
          REPORT "ERROR: pkg_mult_gen_v10_0.vhd: invalid family caught in dsp.vhd/get_true_widths()"
          SEVERITY error;
    END CASE;
    -- if an operand is smaller than the port width for a DSP,
    -- round it up so it uses the full port width - this helps when the
    -- multiplier is to be inferred
    IF ret.a < port_size.a THEN
      ret.a := port_size.a;
    END IF;
    IF ret.b < port_size.b THEN
      ret.b := port_size.b;
    END IF;
    RETURN ret;
  END FUNCTION get_true_widths;


  -- purpose: works out how many partial products are required for the A operand (number of DSPs)
  FUNCTION calc_a_pp(family : T_DEVICE_FAMILY; op_width : WIDTH_REC) RETURN INTEGER IS
    VARIABLE a_pp      : INTEGER := 0;
    VARIABLE int_width : INTEGER := op_width.a;
  BEGIN  -- FUNCTION calc_a_pp
    ASSERT NOT(debug) REPORT "family is " & T_DEVICE_FAMILY'image(family) SEVERITY note;
    ASSERT NOT(debug) REPORT "op_width.a is " & INTEGER'image(op_width.a) SEVERITY note;
    CASE family IS
      WHEN VIRTEX2 | SPARTAN3 | SPARTAN3E | VIRTEX4 | SPARTAN3A | SPARTAN3ADSP =>
        IF int_width <= 18 THEN
          a_pp := 1;
        ELSE
          int_width := int_width - 18;  -- subtract left-most DSP48
          a_pp      := 1 + (int_width/17);  -- add left-most DSP48 and work out how many whole 17-bit blocks are used
          IF int_width MOD 17 /= 0 THEN
            a_pp := a_pp + 1;  -- add one for a partial 17-bit block use
          END IF;
        END IF;
      WHEN VIRTEX5 =>
        IF int_width <= 25 THEN
          a_pp := 1;
        ELSE
          int_width := int_width - 25;  -- subtract left-most DSP48E
          a_pp      := 1 + (int_width/17);  -- add left-most DSP48E and work out how many whole 17-bit blocks are used
          IF int_width MOD 17 /= 0 THEN
            a_pp := a_pp + 1;  -- add one for a partial 17-bit block use
          END IF;
        END IF;
      WHEN OTHERS =>
        ASSERT false
          REPORT "invalid family caught in calc_a_pp()"
          SEVERITY error;
    END CASE;
    ASSERT NOT(debug) REPORT "a_pp count: " & INTEGER'image(a_pp) SEVERITY note;
    RETURN a_pp;
  END FUNCTION calc_a_pp;

  -- purpose: works out how many partial products are required for the B operand (number of DSPs)
  -- note that there is no family restriction here because DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier
  FUNCTION calc_b_pp(op_width : WIDTH_REC) RETURN INTEGER IS
    VARIABLE b_pp      : INTEGER := 0;
    VARIABLE int_width : INTEGER := op_width.b;
  BEGIN  -- FUNCTION calc_b_pp
    ASSERT NOT(debug) REPORT "op_width.b is " & INTEGER'image(op_width.b) SEVERITY note;
    IF int_width <= 18 THEN
      b_pp := 1;
    ELSE
      int_width := int_width - 18;      -- subtract left-most DSP48
      b_pp      := 1+ (int_width/17);  -- work out how many whole 17-bit blocks are used
      IF int_width MOD 17 /= 0 THEN
        b_pp := b_pp + 1;  -- add one for a partial 17-bit block use
      END IF;
    END IF;
    ASSERT NOT(debug) REPORT "b_pp count: " & INTEGER'image(b_pp) SEVERITY note;
    RETURN b_pp;
  END FUNCTION calc_b_pp;

  -- purpose: works out how many partial products are required for the A operand (number of DSPs/MULT18X18s)
  FUNCTION hybrid_calc_a_pp(family : T_DEVICE_FAMILY; op_width : WIDTH_REC) RETURN INTEGER IS
    VARIABLE a_pp        : INTEGER := 0;
    CONSTANT port_size_a : INTEGER := 18+(7*BOOLEAN'pos(family = VIRTEX5));
    VARIABLE found_match : BOOLEAN := false;

    CONSTANT a : INTEGER := op_width.a+op_width.a_type;
    CONSTANT b : INTEGER := op_width.b+op_width.b_type;
    
  BEGIN  -- FUNCTION hybrid_calc_a_pp

    CASE family IS
      WHEN VIRTEX5 =>
        -- pick out the particular configurations that are supported

        -- widths will be swapped so that the largest is on the A operand
        -- perform the PP allocation in reverse order so that we don't need to trap as many cases
        
        IF op_width.a+op_width.a_type >= 42 AND op_width.b+op_width.b_type >= 35 THEN
          -- 2x2 configuration
          a_pp := 2;
          ASSERT NOT(debug) REPORT "DSP48E 2x2 configuration - a_pp" SEVERITY note;

        ELSIF op_width.a+op_width.a_type >= 35 THEN

          -- could implement a 2x1 or 1x2 array here - depends on the operand
          -- widths to get best logic utilisation

          IF a >= 35 AND a < 42 AND b >= 25 THEN
            -- 1x2 - shorter carry chain
            a_pp := 1;
          ELSIF a >= 42 AND b >= 25 THEN
            -- 2x1 - no choice
            a_pp := 2;
          ELSIF a >= 35 AND a < 42 AND b < 25 THEN
            -- 1x2
            a_pp := 1;
          ELSIF a >= 42 AND b < 25 THEN
            a_pp := 2;
          ELSIF a >= 42 AND b >= 25 THEN
            a_pp := 2;
          END IF;
          
        ELSIF (op_width.a+op_width.a_type >= 25 AND op_width.b+op_width.b_type >= 18)
          OR (op_width.a+op_width.a_type                                      <= 25 AND op_width.b+op_width.b_type >= 18)
          OR (op_width.a+op_width.a_type >= 25 AND op_width.b+op_width.b_type <= 18) THEN
          -- 1x1 CONFIGURATION
          a_pp                                                                := 1;
          ASSERT NOT(debug) REPORT "DSP48E 1x1 configuration - a_pp" SEVERITY note;
        ELSIF op_width.a+op_width.a_type <= 25 AND op_width.b+op_width.b_type <= 18 THEN
          -- base mult - no fabric
          a_pp := 1;
          ASSERT NOT(debug) REPORT "DSP48E base mult configuration - a_pp" SEVERITY note;
        END IF;
      WHEN OTHERS =>
        a_pp := calc_a_pp(family, op_width);
        IF (op_width.a-(port_size_a)) MOD 17 /= 0 AND op_width.a > port_size_a THEN
          a_pp := a_pp-1;
        END IF;
    END CASE;

    ASSERT NOT(debug) REPORT "hybrid a_pp count: " & INTEGER'image(a_pp) SEVERITY note;

    RETURN a_pp;
  END FUNCTION hybrid_calc_a_pp;

  -- purpose: works out how many partial products are required for the B operand (number of DSPs/MULT18X18s)
  -- note that there is no family restriction here because MULT18X18, DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier
  FUNCTION hybrid_calc_b_pp(family : T_DEVICE_FAMILY; op_width : WIDTH_REC) RETURN INTEGER IS
    VARIABLE b_pp        : INTEGER := 0;
    VARIABLE int_width   : INTEGER := op_width.b;
    CONSTANT port_size_b : INTEGER := 18;
    VARIABLE found_match : BOOLEAN := false;

    CONSTANT a : INTEGER := op_width.a+op_width.a_type;
    CONSTANT b : INTEGER := op_width.b+op_width.b_type;
    
  BEGIN  -- FUNCTION hybrid_calc_b_pp

    CASE family IS
      WHEN VIRTEX5 =>

        -- widths will be swapped so that the largest is on the A operand
        -- perform the PP allocation in reverse order so that we don't need to trap as many cases
        
        IF op_width.a+op_width.a_type >= 42 AND op_width.b+op_width.b_type >= 35 THEN
          -- 2x2 configuration
          b_pp := 2;
          ASSERT NOT(debug) REPORT "DSP48E 2x2 configuration - b_pp" SEVERITY note;

        ELSIF op_width.a+op_width.a_type >= 35 THEN

          -- could implement a 2x1 or 1x2 array here - depends on the operand
          -- widths to get best logic utilisation

          IF a >= 35 AND a < 42 AND b >= 25 THEN
            -- 1x2 - shorter carry chain
            b_pp := 2;
          ELSIF a >= 42 AND b >= 25 THEN
            -- 2x1 - no choice
            b_pp := 1;
          ELSIF a >= 35 AND a < 42 AND b < 25 THEN
            -- 1x2
            b_pp := 2;
          ELSIF a >= 42 AND b < 25 THEN
            b_pp := 1;
          ELSIF a >= 42 AND b >= 25 THEN
            b_pp := 1;
          END IF;
          
        ELSIF (op_width.a+op_width.a_type >= 25 AND op_width.b+op_width.b_type >= 18)
          OR (op_width.a+op_width.a_type                                      <= 25 AND op_width.b+op_width.b_type >= 18)
          OR (op_width.a+op_width.a_type >= 25 AND op_width.b+op_width.b_type <= 18) THEN
          -- 1x1 CONFIGURATION
          b_pp                                                                := 1;
          ASSERT NOT(debug) REPORT "DSP48E 1x1 configuration - b_pp" SEVERITY note;
        ELSIF op_width.a+op_width.a_type <= 25 AND op_width.b+op_width.b_type <= 18 THEN
          -- base mult - no fabric
          b_pp := 1;
          ASSERT NOT(debug) REPORT "DSP48E base mult configuration - b_pp" SEVERITY note;
        END IF;
      WHEN OTHERS =>
        b_pp := calc_b_pp(op_width);
        IF (op_width.b-(port_size_b)) MOD 17 /= 0 AND op_width.b > port_size_b THEN
          b_pp := b_pp-1;
        END IF;
    END CASE;

    ASSERT NOT(debug) REPORT "hybrid b_pp count: " & INTEGER'image(b_pp) SEVERITY note;

    RETURN b_pp;
  END FUNCTION hybrid_calc_b_pp;

  -- purpose: works out which configuration of hybrid is required based on the input operand widths
  -- and types and the multiplier primitive being used
  FUNCTION get_hybrid_configuration(family     : T_DEVICE_FAMILY;
                                    a_pp, b_pp : INTEGER;
                                    op_width   : WIDTH_REC;
                                    port_size  : PORT_ASPECTS)RETURN INTEGER IS
    VARIABLE full_a_width : INTEGER := 0;
    VARIABLE full_b_width : INTEGER := 0;
    VARIABLE ret          : INTEGER := 99;  -- error code - should always be assigned later
    CONSTANT mult_a       : INTEGER := ((a_pp-1)*(port_size.a-1))+port_size.a;
    CONSTANT mult_b       : INTEGER := ((b_pp-1)*(port_size.b-1))+port_size.b;
    CONSTANT right_shift  : INTEGER := 17;
  BEGIN  -- FUNCTION get_hybrid_configuration

    full_a_width := op_width.a+op_width.a_type;
    full_b_width := op_width.b+op_width.b_type;

    REPORT "full_a_width is " & INTEGER'image(full_a_width) SEVERITY note;
    REPORT "full_b_width is " & INTEGER'image(full_b_width) SEVERITY note;

    IF a_pp = 1 AND b_pp = 1 THEN
      IF full_a_width <= port_size.a AND full_b_width <= port_size.b THEN
        ret := BASE_MULT;
        ASSERT NOT(debug) REPORT "1x1 base mult" SEVERITY note;
      ELSIF (full_a_width > port_size.a AND full_b_width <= port_size.b) OR (full_a_width <= port_size.a AND full_b_width > port_size.b) THEN
        ret := ONE_MULT;
        ASSERT NOT(debug) REPORT "1x1 one fabric mult" SEVERITY note;
      ELSIF full_a_width > port_size.a AND full_b_width > port_size.b THEN
        ret := TWO_MULT;
        ASSERT NOT(debug) REPORT "1x1 two fabric mults" SEVERITY note;
      END IF;
    ELSIF (a_pp = 2 AND b_pp = 1) THEN
      IF full_a_width <= port_size.a+right_shift AND full_b_width <= port_size.b THEN
        ret := BASE_MULT;
        ASSERT NOT(debug) REPORT "2x1 base mult" SEVERITY note;
      ELSIF (full_a_width > port_size.a+right_shift AND full_b_width <= port_size.b) OR (full_a_width <= port_size.a+right_shift AND full_b_width >= port_size.b) THEN
        ret := ONE_MULT;
        ASSERT NOT(debug) REPORT "2x1 one fabric mult" SEVERITY note;
      ELSIF full_a_width > port_size.a+right_shift AND full_b_width >= port_size.b THEN
        ret := TWO_MULT;
        ASSERT NOT(debug) REPORT "2x1 two fabric mults" SEVERITY note;
      END IF;
    ELSIF a_pp = 1 AND b_pp = 2 THEN
      IF (full_b_width <= port_size.a AND full_a_width <= port_size.b+right_shift) THEN
        ret := BASE_MULT;
        ASSERT NOT(debug) REPORT "1x2 base mult" SEVERITY note;
      ELSIF (full_b_width <= port_size.a AND full_a_width >= port_size.b+right_shift) OR (full_b_width >= port_size.a AND full_a_width <= port_size.b+right_shift) THEN
        ret := ONE_MULT;
        ASSERT NOT(debug) REPORT "1x2 one fabric mult" SEVERITY note;
      ELSIF (full_b_width > port_size.a AND full_a_width > port_size.b+right_shift) THEN
        ret := TWO_MULT;
        ASSERT NOT(debug) REPORT "1x2 two fabric mults" SEVERITY note;
      END IF;
      
    ELSIF a_pp = 2 AND b_pp = 2 THEN
      IF full_a_width <= port_size.a+right_shift AND full_b_width <= port_size.b+right_shift THEN
        ret := BASE_MULT;
        ASSERT NOT(debug) REPORT "2x2 base mult" SEVERITY note;
      ELSIF (full_a_width > port_size.a+right_shift AND full_b_width <= port_size.b+right_shift) OR (full_a_width <= port_size.a+right_shift AND full_b_width > port_size.b+right_shift) THEN
        ret := ONE_MULT;
        ASSERT NOT(debug) REPORT "2x2 one fabric mult" SEVERITY note;
      ELSIF full_a_width > port_size.a+right_shift AND full_b_width > port_size.b+right_shift THEN
        ret := TWO_MULT;
        ASSERT NOT(debug) REPORT "2x2 two fabric mults" SEVERITY note;
      END IF;
    END IF;

    ASSERT NOT(debug) REPORT "hybrid_configuration is " & INTEGER'image(ret) SEVERITY note;

    ASSERT ret /= 99 REPORT "no valid configuration found" SEVERITY failure;

    RETURN ret;
  END FUNCTION get_hybrid_configuration;

  -- purpose: works out the operand widths and types for the block multiplier subcomponent
  FUNCTION get_block_mult_cfg (family     : T_DEVICE_FAMILY;
                               a_pp, b_pp : INTEGER;
                               op_width   : WIDTH_REC;
                               hybrid_cfg : INTEGER;
                               port_size  : PORT_ASPECTS) RETURN BLOCK_MULT_REC IS
    VARIABLE ret         : BLOCK_MULT_REC;
    CONSTANT wire_shift  : INTEGER := 17;
    VARIABLE mult_blocks : INTEGER := 0;
    CONSTANT a_width     : INTEGER := op_width.a;
    CONSTANT a_type      : INTEGER := op_width.a_type;
    CONSTANT b_width     : INTEGER := op_width.b;
    CONSTANT b_type      : INTEGER := op_width.b_type;

    VARIABLE a_port_size : INTEGER := 0;
    VARIABLE b_port_size : INTEGER := 0;
    
  BEGIN  -- FUNCTION get_block_mult_cfg
    
    IF a_width < port_size.a THEN
      a_port_size := a_width;
    ELSE
      a_port_size := port_size.a;
    END IF;

    IF b_width < port_size.b THEN
      b_port_size := b_width;
    ELSE
      b_port_size := port_size.b;
    END IF;

    IF a_pp = 1 AND b_pp = 1 THEN
      ret.a_width := a_port_size - BOOLEAN'pos(a_type = C_UNSIGNED AND a_width >= port_size.a);
      ret.b_width := b_port_size - BOOLEAN'pos(b_type = C_UNSIGNED AND b_width >= port_size.b);
      ret.a_type  := a_type;
      ret.b_type  := b_type;
      mult_blocks := 1;
    ELSIF a_pp = 2 AND b_pp = 1 THEN
      ret.a_width := port_size.a+wire_shift - BOOLEAN'pos(a_type = C_UNSIGNED AND a_width >= port_size.a);
      ret.b_width := b_port_size - BOOLEAN'pos(b_type = C_UNSIGNED AND b_width >= port_size.b);
      ret.a_type  := a_type;
      ret.b_type  := b_type;
      mult_blocks := 2;
    ELSIF a_pp = 1 AND b_pp = 2 THEN
      -- the operands will be swapped around so that the A operand is the largest
      -- this means that we need to swap the a_type and b_type values over so
      -- that they remain correct w.r.t. the operand widths

      ret.a_width := port_size.b+wire_shift - BOOLEAN'pos(a_type = C_UNSIGNED);
      ret.b_width := a_port_size - BOOLEAN'pos(b_type = C_UNSIGNED);
      ret.a_type  := a_type;
      ret.b_type  := b_type;

      mult_blocks := 2;
    ELSIF a_pp = 2 AND b_pp = 2 THEN
      ret.a_width := port_size.a+wire_shift - BOOLEAN'pos(a_type = C_UNSIGNED);
      ret.b_width := port_size.b+wire_shift - BOOLEAN'pos(b_type = C_UNSIGNED);
      ret.a_type  := a_type;
      ret.b_type  := b_type;
      mult_blocks := 4;
    END IF;

    ASSERT NOT(debug) REPORT "Building hybrid around a " & INTEGER'image(ret.a_width) & "x" & INTEGER'image(ret.b_width) & " multiplier using " & INTEGER'image(mult_blocks) & " block multipliers" SEVERITY note;

    ASSERT NOT(debug) REPORT CR & "block_mult_cfg is: " &
      CR & "a_width: " & INTEGER'image(ret.a_width) &
      CR & "b_width: " & INTEGER'image(ret.b_width) &
      CR & "a_type: " & INTEGER'image(ret.a_type) &
      CR & "b_type: " & INTEGER'image(ret.b_type) & CR SEVERITY note;
    
    RETURN ret;
  END FUNCTION get_block_mult_cfg;

  -- purpose: works out the required operand widths of the fabric multiplier for the 'one mult' case
  FUNCTION get_one_mult_cfg(width                                                    : WIDTH_REC;
                            block_a_width, block_a_type, block_b_width, block_b_type : INTEGER;
                            hybrid_cfg                                               : INTEGER;
                            port_size                                                : PORT_ASPECTS) RETURN ONE_MULT_REC IS
    CONSTANT x_width     : INTEGER := block_a_width;
    CONSTANT y_width     : INTEGER := block_b_width;
    VARIABLE ret         : ONE_MULT_REC;
  BEGIN  -- FUNCTION get_one_mult_cfg

    -- set defaults to avoid MTI disappearing...
    ret.a         := 0;
    ret.b         := 0;
    ret.a_type    := 0;
    ret.b_type    := 0;
    ret.out_width := 0;
    ret.bypass    := 0;
    ret.a_offset  := 0;
    ret.b_offset  := 0;

    ASSERT NOT(debug) REPORT "-------------------------------------------------------"
      & CR & "get_one_mult_cfg width.a: " & INTEGER'image(width.a) &
      CR & "get_one_mult_cfg width.a_type: " & INTEGER'image(width.a_type) &
      CR & "get_one_mult_cfg width.b: " & INTEGER'image(width.b) &
      CR & "get_one_mult_cfg width.b_type: " & INTEGER'image(width.b_type) &

      CR & "get_one_mult_cfg hybrid_cfg " & INTEGER'image(hybrid_cfg) &
      CR & "get_one_mult_cfg x_width " &INTEGER'image(x_width) &
      CR & "get_one_mult_cfg y_width " & INTEGER'image(y_width) &
      CR & "-------------------------------------------------------" SEVERITY note;

    IF (width.a > x_width AND (width.b <= y_width OR y_width < port_size.b)) AND hybrid_cfg = ONE_MULT THEN

      ASSERT NOT(debug) REPORT "a_width > x_width and b_width <= y_width" SEVERITY note;
      ret.a        := width.a-x_width;
      ret.b        := width.b;
      ret.a_type   := C_UNSIGNED;
      ret.b_type   := width.b_type;
      ret.bypass   := ret.a;
      ret.b_offset := 0;
      ret.a_offset := ret.a;
    END IF;

    -- this one doesn't work - do we even need this clause since the operands
    -- are always swapped to make A the largest?  What about the 1x2 V5 case?
    IF (width.a <= x_width AND (width.b > y_width OR y_width < port_size.b)) AND hybrid_cfg = ONE_MULT THEN
      ASSERT NOT(debug) REPORT "a_width <= x_width and b_width > y_width" SEVERITY note;
      ret.a        := width.a;
      ret.b        := width.b-y_width;
      ret.a_type   := width.a_type;
      ret.b_type   := C_UNSIGNED;
      ret.bypass   := ret.b;
      ret.b_offset := ret.b;
      ret.a_offset := 0;
    END IF;

    ret.out_width := ret.a+ret.b;

    ASSERT NOT(debug) REPORT CR & "one_mult_cfg is: " &
      CR & "a: " & INTEGER'image(ret.a) &
      CR & "b: " & INTEGER'image(ret.b) &
      CR & "a_type: " & INTEGER'image(ret.a_type) &
      CR & "b_type: " & INTEGER'image(ret.b_type) &
      CR & "bypass: " & INTEGER'image(ret.bypass) &
      CR & "a_offset: " & INTEGER'image(ret.a_offset) &
      CR & "b_offset: " & INTEGER'image(ret.b_offset) & CR SEVERITY note;
    
    RETURN ret;
    
  END FUNCTION get_one_mult_cfg;

  -- purpose: works out the required operand widths of the fabric multiplier for the 'two mult' case
  FUNCTION get_two_mult_cfg(op_width                         : WIDTH_REC;
                            a_width, a_type, b_width, b_type : INTEGER;
                            hybrid_cfg                       : INTEGER) RETURN TWO_MULT_REC IS
    CONSTANT x_width     : INTEGER := a_width;
    CONSTANT y_width     : INTEGER := b_width;
    VARIABLE ret         : TWO_MULT_REC;

    CONSTANT full_width_a : INTEGER := op_width.a;  --+op_width.a_type;
    CONSTANT full_width_b : INTEGER := op_width.b;  --+op_width.b_type;
    
  BEGIN  -- FUNCTION get_two_mult_cfg

    -- set defaults to avoid MTI disappearing...
    ret.a_top          := 0;
    ret.b_top          := 0;
    ret.a_type_top     := 0;
    ret.b_type_top     := 0;
    ret.out_width_top  := 0;
    ret.a_side         := 0;
    ret.b_side         := 0;
    ret.a_type_side    := 0;
    ret.b_type_side    := 0;
    ret.out_width_side := 0;
    ret.mult_bypass    := 0;
    ret.add_bypass     := 0;
    ret.a_offset       := 0;
    ret.b_offset       := 0;

    ASSERT NOT(debug) REPORT "get_two_mult_cfg x_width is " & INTEGER'image(x_width) SEVERITY note;
    ASSERT NOT(debug) REPORT "get_two_mult_cfg y_width is " & INTEGER'image(y_width) SEVERITY note;
    ASSERT NOT(debug) REPORT "get_two_mult_cfg full_width_a is " & INTEGER'image(full_width_a) SEVERITY note;
    ASSERT NOT(debug) REPORT "get_two_mult_cfg full_width_b is " & INTEGER'image(full_width_b) SEVERITY note;

    IF (full_width_a >= x_width AND full_width_b >= y_width) AND hybrid_cfg = TWO_MULT THEN  -- condition for this configuration to be valid

      -- The code above will automatically swap the operands so that the largest is
      -- on the A bus.  Because we only make 2 cuts in the partial product
      -- array, this means that we want to make the A operand shorter than the B
      -- operand to balance out the carry chain lengths for e.g. 22x20 multipliers

      -- top fabric mult
      ret.a_top          := x_width;
      ret.b_top          := full_width_b - y_width;
      ret.a_type_top     := a_type;
      ret.b_type_top     := C_UNSIGNED;
      ret.out_width_top  := ret.a_top + ret.b_top;
      -- side fabric mult
      ret.a_side         := full_width_a - x_width;
      ret.b_side         := full_width_b;
      ret.a_type_side    := C_UNSIGNED;
      ret.b_type_side    := b_type;
      ret.out_width_side := ret.a_side + ret.b_side;
      -- bypass vectors
      ret.mult_bypass    := ret.a_side;
      ret.add_bypass     := ret.b_top;
      -- offsets for the block mult array inputs
      ret.a_offset       := ret.a_side;
      ret.b_offset       := ret.b_top;

    ELSIF (full_width_b >= x_width AND full_width_a >= y_width) AND hybrid_cfg = TWO_MULT THEN

      -- top fabric mult
      ret.a_top          := y_width;
      ret.b_top          := full_width_b - x_width;
      ret.a_type_top     := a_type;
      ret.b_type_top     := C_UNSIGNED;
      ret.out_width_top  := ret.a_top + ret.b_top;
      -- side fabric mult
      ret.a_side         := full_width_a - y_width;
      ret.b_side         := full_width_b;
      ret.a_type_side    := C_UNSIGNED;
      ret.b_type_side    := b_type;
      ret.out_width_side := ret.a_side + ret.b_side;
      -- bypass vectors
      ret.mult_bypass    := ret.a_side;
      ret.add_bypass     := ret.b_top;
      -- offsets for the block mult array inputs
      ret.a_offset       := ret.a_side;
      ret.b_offset       := ret.b_top;
      
    END IF;

    ASSERT NOT(debug) REPORT CR & "two_mult_cfg is: " &
      CR & "a_top: " & INTEGER'image(ret.a_top) &
      CR & "b_top: " & INTEGER'image(ret.b_top) &
      CR & "a_type_top: " & INTEGER'image(ret.a_type_top) &
      CR & "b_type_top: " & INTEGER'image(ret.b_type_top) &
      CR & "out_width_top: " & INTEGER'image(ret.out_width_top) &
      CR & "a_side: " & INTEGER'image(ret.a_side) &
      CR & "b_side: " & INTEGER'image(ret.b_side) &
      CR & "a_type_side: " & INTEGER'image(ret.a_type_side) &
      CR & "b_type_side: " & INTEGER'image(ret.b_type_side) &
      CR & "out_width_side: " & INTEGER'image(ret.out_width_side) &
      CR & "mult_bypass: " & INTEGER'image(ret.mult_bypass) &
      CR & "add_bypass: " & INTEGER'image(ret.add_bypass) &
      CR & "a_offset: " & INTEGER'image(ret.a_offset) &
      CR & "b_offset: " & INTEGER'image(ret.b_offset) & CR SEVERITY note;
    
    RETURN ret;
    
  END FUNCTION get_two_mult_cfg;

  -- purpose: works out the fully-pipelined latency of a LUT multiplier
  FUNCTION fab_mult_full_pipe_lat(a_width, b_width : INTEGER) RETURN INTEGER IS
    VARIABLE b : INTEGER := 0;
  BEGIN  -- FUNCTION fab_mult_full_pipe_lat
    b := get_min(a_width, b_width);
    IF b = 1 THEN
      -- Need to trap this, otherwise a 35x1 multiplier would have a
      -- fully-pipelined latency of zero!
      RETURN 1;
    ELSE
      RETURN mult_gen_log2(b);
    END IF;
  END FUNCTION fab_mult_full_pipe_lat;

  -- purpose: works out how many pipeline stages a particular configuration of DSP blocks needs
  FUNCTION get_emb_mult_max_pipe_stages (family : T_DEVICE_FAMILY; a_pp, b_pp : INTEGER) RETURN INTEGER IS
    VARIABLE ret : INTEGER := 0;
  BEGIN  -- FUNCTION get_DSP_max_pipe_stages
    CASE family IS
      WHEN VIRTEX4 | VIRTEX5 =>
        IF a_pp = 1 AND b_pp = 1 THEN
          ret := 3;
        ELSIF a_pp = 2 AND b_pp = 1 THEN
          ret := 4;
        ELSIF a_pp = 1 AND b_pp = 2 THEN
          ret := 4;
        ELSIF a_pp = 2 AND b_pp = 2 THEN
          ret := 6;
        ELSE
          ret := 99;                    -- unsupported configuration
          REPORT "caught unsupported hybrid configuration in get_DSP_max_pipe_stages in pkg_mult_gen_v10_0"
            SEVERITY failure;
        END IF;
      WHEN SPARTAN3ADSP =>
        -- There's no simple formula to work out what the latency will
        -- be based on the number of DSPs.  It depends how many wireshifts we need in
        -- the fabric (i.e. how many times the C port needs to be used)
        IF a_pp = 1 AND b_pp = 1 THEN
          ret := 3;
        ELSIF a_pp = 2 AND b_pp = 1 THEN
          ret := 5;
        ELSIF a_pp = 2 AND b_pp = 2 THEN
          ret := 8;
        ELSE
          ret := 99;                    -- unsupported configuration
          REPORT "caught unsupported hybrid configuration in get_DSP_max_pipe_stages in pkg_mult_gen_v10_0"
            SEVERITY failure;
        END IF;
      WHEN VIRTEX2 | SPARTAN3 | SPARTAN3E | SPARTAN3A =>
        -- number of pipeline stages dictated by number of partial products
        -- which determines the depth of the adder tree + registers in and
        -- after the multiplier block
        ret := mult_gen_log2(a_pp * b_pp) + 2;
        IF family = SPARTAN3E OR family = SPARTAN3A THEN
          -- add another register for after the multiplier blocks
          ret := ret + 1;
        END IF;
      WHEN OTHERS =>
        REPORT "caught invalid family in get_emb_mult_max_pipe_stages"
          SEVERITY failure;
    END CASE;

    RETURN ret;
  END FUNCTION get_emb_mult_max_pipe_stages;

  -- purpose: works out the depth of the adder tree on the LUT multiplier(s)
  -- to see what the maximum fully-pipelined latency will be
  FUNCTION get_LUT_max_pipe_stages (one_mult_cfg : ONE_MULT_REC; two_mult_cfg : TWO_MULT_REC; hybrid_configuration : INTEGER) RETURN INTEGER IS
    VARIABLE true_b_width_side : INTEGER := 0;
    VARIABLE true_b_width_top  : INTEGER := 0;
    VARIABLE ret               : INTEGER := 0;
  BEGIN  -- FUNCTION get_LUT_max_pipe_stages
    IF hybrid_configuration = 0 THEN
      ret := 0;
    ELSIF hybrid_configuration = 1 THEN
      -- only one fabric multiplier - use one_mult_cfg
      ret := fab_mult_full_pipe_lat(one_mult_cfg.a, one_mult_cfg.b);
    ELSIF hybrid_configuration = 2 THEN
      -- two fabric multipliers - work out which is the largest aka deepest
      true_b_width_top  := get_min(two_mult_cfg.a_top, two_mult_cfg.b_top);
      true_b_width_side := get_min(two_mult_cfg.a_side, two_mult_cfg.b_side);
      IF true_b_width_top > true_b_width_side THEN
        ret := mult_gen_log2(true_b_width_top);
      ELSE
        ret := mult_gen_log2(true_b_width_side);
      END IF;
    ELSE
      REPORT "invalid hybrid configuration value caught in get_LUT_max_pipe_stages in pkg_mult_gen_v10_0"
        SEVERITY failure;
      ret := 99;
    END IF;
    RETURN ret;
  END FUNCTION get_LUT_max_pipe_stages;

  -- purpose: counts the number of LSB zeros in the supplied constant STRING
  -- If the bits are zero, we don't need to pass these bits into the multiplier
  -- and we can just right-shift the output by these number of bits 
  FUNCTION get_output_scaling (b_value : STRING; b_type : INTEGER; mult_type : INTEGER)RETURN INTEGER IS
    VARIABLE shift    : INTEGER                       := 0;
    VARIABLE can_trim : BOOLEAN                       := true;
    CONSTANT all_ones : STRING(1 TO b_value'length-1) := (OTHERS => '1');
  BEGIN  -- FUNCTION get_output_scaling
    IF mult_type = FIXED_CCM THEN
      -- first check if the constant is a negative power of 2
      -- if it is, we can't trim the LS zeros

      IF b_value'ascending THEN
        IF b_value(b_value'right) = '0' AND b_value(b_value'left TO b_value'right-1) = all_ones THEN
          can_trim := false;
        END IF;
      ELSE
        IF b_value(b_value'right) = '0' AND b_value(b_value'left DOWNTO b_value'right+1) = all_ones THEN
          can_trim := false;
        END IF;
      END IF;

      IF can_trim THEN
        -- start at the LSB and work our way left gaining bit significance
        -- Account for the strings being TO or DOWNTO
        IF b_value'ascending THEN
          FOR i IN b_value'right DOWNTO b_value'left LOOP
            IF b_value(i) = '1' THEN
              EXIT;
            ELSE
              shift := shift + 1;
            END IF;
          END LOOP;  -- i      
        ELSE                            -- b_value'descending
          FOR i IN b_value'right TO b_value'left LOOP
            IF b_value(i) = '1' THEN
              EXIT;
            ELSE
              shift := shift + 1;
            END IF;
          END LOOP;  -- i        
        END IF;
      END IF;

      ASSERT NOT(debug) REPORT "shift value is " & INTEGER'image(shift) SEVERITY note;
    END IF;

    RETURN shift;
  END FUNCTION get_output_scaling;

  -- purpose: checks to see if the constant has any zeros at the MSB (left) side of the string and
  -- returns an integer to say how many consecutive zeros there are
  -- These zeros don't need to go through the multiplier, so we could save some
  -- logic in a few cases
  -- If the constant is of signed type, we need to keep one of the leading zeros
  -- If the constant is signed though, we can also check for leading ones and
  -- trim them, stopping when we find "10" when searching from the left-hand side
  FUNCTION get_trimmed_leading_bits (b_value : STRING; b_type : INTEGER; mult_type : INTEGER) RETURN INTEGER IS
    VARIABLE zeros_to_trim : INTEGER := 0;
    VARIABLE ones_to_trim  : INTEGER := 0;
    VARIABLE bits_to_trim  : INTEGER := 0;
  BEGIN  -- FUNCTION get_trimmed_leading_bits
    IF mult_type = FIXED_CCM THEN
      -- Account for the strings being TO or DOWNTO
      IF b_value'ascending THEN
        FOR i IN b_value'left TO b_value'right LOOP
          IF b_value(i) = '1' THEN
            EXIT;
          ELSE
            zeros_to_trim := zeros_to_trim + 1;
          END IF;
        END LOOP;  -- i
      ELSE                              -- b_value'descending
        FOR i IN b_value'left DOWNTO b_value'right LOOP
          IF b_value(i) = '1' THEN
            EXIT;
          ELSE
            zeros_to_trim := zeros_to_trim + 1;
          END IF;
        END LOOP;  -- i
      END IF;

      -- New loop for V10.0 that avoids the array indexing error for -1
      IF b_type = C_SIGNED AND zeros_to_trim = 0 THEN
        -- Account for the strings being TO or DOWNTO
        IF b_value'ascending THEN
          FOR i IN b_value'left TO b_value'right LOOP
            IF b_value(i) = '1' THEN
              IF i+1 <= b_value'right THEN
                IF b_value(i+1) = '0' THEN
                  EXIT;
                END IF;
              ELSE
                NULL;
              END IF;
            ELSE
              ones_to_trim := ones_to_trim + 1;
            END IF;
          END LOOP;  -- i
        ELSE                            -- b_value'descending
          FOR i IN b_value'left DOWNTO b_value'right LOOP
            IF b_value(i) = '1' THEN
              IF i-1 >= b_value'right THEN
                IF b_value(i-1) = '0' THEN
                  EXIT;
                END IF;
              ELSE
                NULL;
              END IF;
            ELSE
              ones_to_trim := ones_to_trim + 1;
            END IF;
          END LOOP;  -- i
        END IF;
      END IF;

      -- need to keep the MSB zero in the signed case to allow for correct
      -- operand extension in the subcores
      IF b_type = C_SIGNED AND zeros_to_trim > 0 THEN
        zeros_to_trim := zeros_to_trim - 1;
      END IF;

      bits_to_trim := ones_to_trim + zeros_to_trim;  -- only one of these will be non-zero      
      ASSERT NOT(debug) REPORT "trimming " & INTEGER'image(bits_to_trim) & " leading ones or zeros" SEVERITY note;
    END IF;

    RETURN bits_to_trim;
  END FUNCTION get_trimmed_leading_bits;

  -- purpose: checks if the constant is all-zeros, in which case there is no point in creating logic!
  FUNCTION check_b_value_all_zeros (b_value : STRING) RETURN BOOLEAN IS
    VARIABLE ret : BOOLEAN := false;
  BEGIN  -- FUNCTION check_b_value_all_zeros
    FOR i IN b_value'range LOOP
      IF b_value(i) = '1' THEN
        ret := false;
        EXIT;
      END IF;
      ret := true;
    END LOOP;  -- i
    ASSERT ret = false REPORT "b_value constant is exactly zero - no logic will be created" SEVERITY warning;
    RETURN ret;
  END FUNCTION check_b_value_all_zeros;
  
-------------------------------------------------------------------------------
-- Functions imported from ccm_pkg.vhd
-------------------------------------------------------------------------------  

  FUNCTION calc_reqd_b_value(b_value      : STRING;
                             b_width      : INTEGER;
                             b_type       : INTEGER;
                             reqd_b_width : INTEGER) RETURN STRING IS
    CONSTANT b_lsb        : INTEGER := b_value'high;
    VARIABLE b_bit        : INTEGER;
    VARIABLE reqd_b_value : STRING(1 TO reqd_b_width);
  BEGIN
    
    FOR BIT IN 1 TO reqd_b_width LOOP
      b_bit := BIT + b_lsb - reqd_b_width;
      IF b_bit > 0 THEN
        reqd_b_value(BIT) := b_value(b_bit);
      ELSE
        IF b_type = C_SIGNED THEN
          reqd_b_value(BIT) := b_value(1);
        ELSE
          reqd_b_value(BIT) := '0';
        END IF;  -- b_type
      END IF;  -- b_bit
    END LOOP;

    RETURN reqd_b_value;
    
  END calc_reqd_b_value;

  FUNCTION bitstorep_string(a_value : STRING;
                            a_type  : INTEGER) RETURN NATURAL IS
    VARIABLE return_value : INTEGER;
  BEGIN
    return_value := a_value'length;

    --ASSERT FALSE
    --  REPORT "bitstorep_string function: a_value = " & a_value & new_line &
    --         " a_type = " & int_2_string(a_type) & new_line &
    --         " a_value'LENGTH = " & int_2_string(a_value'LENGTH) & new_line &
    --         " a_value'LOW = " & int_2_string(a_value'LOW) & new_line &
    --         " a_value'HIGH = " & int_2_string(a_value'HIGH) & new_line &
    --         new_line
    --  SEVERITY NOTE;

    IF a_type = C_UNSIGNED THEN

      -- a_value represents an unsigned number
      --    FOR i IN a_value'RANGE LOOP -- Doesn't work with XCC
      FOR i IN a_value'low TO a_value'high LOOP
        IF a_value(i) = '1' THEN
          EXIT;                         -- EXIT when the msb is found
        ELSIF a_value(i) = '0' THEN
          return_value := return_value - 1;
        ELSE
--                assert false
--                   report "ERROR: non 0 or 1 character passed to bitstorep_string function." &
--                   new_line & " STRING passed in was: " & a_value
--                   severity failure;
          NULL;
        END IF;
      END LOOP;
      
    ELSE

      -- a_value represents a signed number
      -- Look for ms '1' followed by a '0'
      -- FOR i IN a_value'RANGE LOOP -- Doesn't work with XCC
      FOR i IN a_value'low TO a_value'high LOOP
        IF a_value(i) = '1' THEN
          
          IF i < a_value'high THEN
            IF a_value(i+1) = '0' THEN
              EXIT;                     -- EXIT when the msb is found
              ELSE
                return_value := return_value - 1;
            END IF;
          ELSE
            EXIT;                       -- EXIT when end of STRING reached
          END IF;
          
        ELSIF a_value(i) = '0' THEN
          return_value := return_value - 1;
        ELSE
--               assert false
--                   report "ERROR: non 0 or 1 character passed to bitstorep_string function." &
--                   new_line & " STRING passed in was: " & a_value
--                   severity failure;
          NULL;
        END IF;
      END LOOP;
      
    END IF;

    IF return_value <= 0 THEN
      RETURN 1;
    ELSE
      RETURN return_value;
    END IF;

  END bitstorep_string;

  FUNCTION calc_shift_bits(b_value    : STRING;
                           b_constant : INTEGER) RETURN INTEGER IS
    VARIABLE BIT        : INTEGER;
    VARIABLE shift_bits : INTEGER;
  BEGIN
    shift_bits := 0;

    IF b_constant /= 0 THEN
      BIT := b_value'high;

      WHILE (BIT >= b_value'low) LOOP
        IF b_value(BIT) = '0' THEN
          shift_bits := shift_bits + 1;
        ELSE
          EXIT;
        END IF;
        BIT := BIT - 1;
      END LOOP;
      
    END IF;

    IF shift_bits >= b_value'high THEN
      shift_bits := 0;                  -- All zeroes value
    END IF;

--       assert not(debug)
--          report "calc_shift_bits debug" & new_line &
--          "          shift_bits = " & int_2_string(shift_bits) & new_line
--          severity note;

    RETURN shift_bits;
    
  END calc_shift_bits;

  FUNCTION get_rom_addr_width(family : T_DEVICE_FAMILY; mem_type : INTEGER) RETURN INTEGER IS
  BEGIN
    IF mem_type = C_DISTRIBUTED THEN
      CASE family IS
        WHEN VIRTEX5 =>
          ASSERT NOT(debug) REPORT "distributed ram address width is 6 - 64x1 RAM (LUT6)" SEVERITY note;
          RETURN 6;
        WHEN OTHERS =>
          ASSERT NOT(debug) REPORT "distributed ram address width is 4 - 16x1 RAM (LUT4)" SEVERITY note;
          RETURN 4;
      END CASE;
    ELSE

      CASE family IS
        WHEN VIRTEX5 | VIRTEX4 | SPARTAN3 | SPARTAN3E | VIRTEX2 | SPARTAN3A | SPARTAN3ADSP =>
          -- use a 9-bit address width
          -- use the 18K BRAM for V5 as well
          RETURN 9;
        WHEN OTHERS =>
          -- only use an 8-bit address width
          RETURN 8;
      END CASE;
      
    END IF;
  END get_rom_addr_width;

  FUNCTION calc_a_input_width(operand_width, has_a_signed, rom_addr_width, b_constant : INTEGER) RETURN INTEGER IS
    VARIABLE effective_op_width : INTEGER;
  BEGIN
    IF has_a_signed = 0 OR b_constant = 0 THEN
      effective_op_width := operand_width;
    ELSE
      -- Allow extra input for 'a_signed'
      effective_op_width := operand_width + 1;
    END IF;


    IF (effective_op_width MOD rom_addr_width = 0) THEN
      RETURN effective_op_width;
    ELSE
      RETURN effective_op_width + rom_addr_width - (effective_op_width MOD rom_addr_width);
    END IF;
  END calc_a_input_width;

  FUNCTION calc_num_pps(a_width, rom_addr_width : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (a_width MOD rom_addr_width /= 0) THEN
      RETURN (a_width / rom_addr_width) + 1;
    ELSE
      RETURN (a_width / rom_addr_width);
    END IF;
  END calc_num_pps;

  ------------------------------------------------------------------------------
  -- Returns the number of input bits required by the last partial product ROM.
  -- Does not include a_signed bit.
  ------------------------------------------------------------------------------
  FUNCTION calc_last_pp_input_width(operand_width, has_a_signed,
                                    rom_addr_width, b_constant : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (operand_width MOD rom_addr_width /= 0) THEN
      RETURN operand_width MOD rom_addr_width;
    ELSE
      -- There is an extra pp in this case due to the msb and 'a_signed' having
      -- to have a separate LUT
      IF has_a_signed /= 0 AND b_constant /= 0 THEN
        RETURN 1;
      ELSE
        RETURN rom_addr_width;
      END IF;
    END IF;
  END calc_last_pp_input_width;


  ------------------------------------------------------------------------------
  -- Calculate amount to delay signal which drives addsub add input.
  ------------------------------------------------------------------------------
  FUNCTION calc_add_lastpp_delay(reg_a_b_inputs  : INTEGER;
                                 pipeline        : INTEGER;
                                 num_pipe_stages : INTEGER) RETURN INTEGER IS
    VARIABLE delay : INTEGER;
  BEGIN
    IF reg_a_b_inputs = 0 THEN
      delay := 0;
    ELSE
      delay := 1;
    END IF;

    IF pipeline /= 0 THEN
      delay := num_pipe_stages + 1;     -- Add 1 for RAM output register
    END IF;

    RETURN delay;
  END calc_add_lastpp_delay;

  ------------------------------------------------------------------------------
  -- Only the product bits from 'start_bit' upwards are stored in the ROMs
  -- because the bits  below 'start_bit' are one of the address bits.
  --
  -- e.g. ROM output(0) = I0 if b(0)='1'
  --      ROM output(1) = I1 if b(1:0)='01'
  --      ROM output(2) = I2 if b(2:0)='001'
  --           ..                ..
  --      ROM output(n) = In if b(n:0)='0...01'
  ------------------------------------------------------------------------------
  FUNCTION calc_rom_start_bit(b_width          : INTEGER;
                              b_value          : STRING;
                              b_constant       : INTEGER;
                              pp_width         : INTEGER;
                              a_type           : INTEGER;
                              rom_has_a_signed : INTEGER;
                              mem_type         : INTEGER;
                              mem_addr_width   : INTEGER;
                              pipeline         : INTEGER;
                              num_adders       : INTEGER;
                              has_q            : INTEGER;
                              last_mem         : BOOLEAN) RETURN INTEGER IS

    VARIABLE b_bit     : INTEGER;
    VARIABLE start_bit : INTEGER;
  BEGIN
    start_bit := 0;
    b_bit     := b_value'high;          -- STRINGs go from 1 to N (lsb = N)

    IF b_bit > 1 AND b_constant /= 0 AND mem_type = C_DISTRIBUTED AND rom_has_a_signed = 0
      AND ((num_adders > 0 AND pipeline = 0) OR (num_adders = 0 AND has_q = 0)) THEN

      IF b_value(b_bit) = '1' THEN
        start_bit := 1;

        WHILE start_bit < pp_width LOOP

          -- Increment start_bit if 1st bit = '1' and next ms bit = '0'
          IF b_bit > b_value'low THEN
            
            b_bit := b_bit - 1;
            IF b_value(b_bit) = '0' THEN
              start_bit := start_bit + 1;
            ELSE
              EXIT;
            END IF;
            
          ELSE
            start_bit := start_bit + 1;
          END IF;  -- b_bit > b_value'LOW
          
        END LOOP;  -- WHILE ...
        
      END IF;  -- b_value(b_value'HIGH) = '1'
      
    END IF;  -- b_constant /= 0

    -- Do not allow start_bit to exceed mem_addr_width if last mem and
    -- a is signed
    IF last_mem AND a_type = C_SIGNED AND start_bit > mem_addr_width THEN
      start_bit := mem_addr_width;
    END IF;

--    ASSERT NOT(debug)
--      REPORT "calc_rom_start_bit debug" & new_line &
--      "          b_value = " & b_value & new_line &
--      "          start_bit = " & int_2_string(start_bit) & new_line
--      SEVERITY note;

    RETURN start_bit;
    
  END calc_rom_start_bit;

  -- andreww restructured calc_rom_contents to work better with XST
  -- previously the call the multiply_bv was made within the nested FOR loops,
  -- which could result in extra memory overhead.  Moving this outside to an independent
  -- FOR loop and assembling a constant array is much easier on XST
  -- 16 November 2005
  FUNCTION calc_rom_contents(b_width        : INTEGER;
                             b_type         : INTEGER;
                             rom_addr_width : INTEGER;
                             rom_depth      : INTEGER;
                             rom_width      : INTEGER;
                             start_bit      : INTEGER;
                             b_value        : STRING;
                             num_rom_bits   : INTEGER) RETURN BIT_VECTOR IS

    VARIABLE b_value_bv   : BIT_VECTOR(b_width-1 DOWNTO 0);
    VARIABLE prod         : BIT_VECTOR(rom_addr_width+b_width-1 DOWNTO 0);
    VARIABLE rom_contents : BIT_VECTOR(num_rom_bits-1 DOWNTO 0);
    -- new things
    TYPE     T_PROD IS ARRAY (0 TO rom_depth-1) OF BIT_VECTOR(rom_addr_width+b_width-1 DOWNTO 0);
    VARIABLE prod_array   : T_PROD;
    VARIABLE prod_el      : BIT_VECTOR(rom_addr_width+b_width-1 DOWNTO 0);
  BEGIN
    b_value_bv := str_to_bv(b_value, b_width);

    FOR rom_addr IN 0 TO rom_depth-1 LOOP
      prod_array(rom_addr) := multiply_bv(natural_to_bit_vector(rom_addr, rom_addr_width), b_value_bv, false, (b_type = C_SIGNED));
    END LOOP;  -- rom_addr

    --ASSERT NOT(debug)
    --  REPORT "calc_rom_contents debug: " & new_line &
    --         "                        b_value = " & b_value & new_line &
    --         "                        start_bit = " &
    --         int_2_string(start_bit) & new_line
    --  SEVERITY NOTE;

    FOR rom_addr IN 0 TO rom_depth-1 LOOP
      -- Multiply rom_addr by c_b_value

      -- get the bit vector out of the array
      prod_el := prod_array(rom_addr);

      FOR BIT IN 0 TO rom_width-1 LOOP
        -- use the BV from the array and pick bits out of it
        rom_contents(rom_addr*rom_width + BIT) := prod_el(BIT + start_bit);
      END LOOP;
      
    END LOOP;

    RETURN rom_contents;
    
  END calc_rom_contents;

  ------------------------------------------------------------------------------
  --
  -- Last ROM contents differ because 'a' may not occupy the full address bus
  -- and the MSB of 'a' may be a sign bit.
  --
  -- c_has_a_signed=0 (a=3 bits)            c_has_a_signed/=0 (a=2 bits)
  -- Location  Contents                     Location  Contents
  --    0       0 * B                          0       0 * B
  --    1       1 * B                          1       1 * B
  --    2       2 * B                          2       2 * B
  --    3       3 * B                          3       3 * B
  --    4       4 * B  <-- 2**(a_width-1)      4       0 * B  <-- 2**(a_width-1)
  --    5       3 * B                          5      -1 * B
  --    6       2 * B                          6      -2 * B
  --    7       1 * B                          7      -1 * B
  --    8       Don't care                     8       Don't care
  --    etc                                    etc
  --
  -- If b is not constant then last ROM is just the same as all the others.
  ------------------------------------------------------------------------------
  FUNCTION calc_last_rom_contents(b_width            : INTEGER;
                                  a_width            : INTEGER;  -- not incl a_signed
                                  a_type             : INTEGER;
                                  b_type             : INTEGER;
                                  has_a_signed       : INTEGER;
                                  rom_addr_width     : INTEGER;
                                  rom_depth          : INTEGER;
                                  rom_width          : INTEGER;
                                  start_bit          : INTEGER;
                                  b_value            : STRING;
                                  b_constant         : INTEGER;
                                  num_rom_bits       : INTEGER;
                                  number_of_pps      : INTEGER;
                                  a_signed_extension : BOOLEAN)
    RETURN BIT_VECTOR IS

    CONSTANT a_signed     : BOOLEAN := ((a_type = C_SIGNED) OR (has_a_signed /= 0));
    CONSTANT max_val      : INTEGER := 2**(a_width-1);
    CONSTANT prod_width   : INTEGER := a_width + b_width;
    VARIABLE b_value_bv   : BIT_VECTOR(b_width-1 DOWNTO 0);
    VARIABLE prod         : BIT_VECTOR(prod_width-1 DOWNTO 0);
    VARIABLE rom_contents : BIT_VECTOR(num_rom_bits-1 DOWNTO 0);
    VARIABLE debug_string : STRING(1 TO prod_width);
  BEGIN
--      ASSERT NOT(debug)
--       REPORT "calc_last_rom_contents debug" & new_line &
--               "          last_rom_width = " & int_2_string(rom_width) & new_line &
--               "          a_width = " & int_2_string(a_width) & new_line &
--               "          b_width = " & int_2_string(b_width) & new_line
--        SEVERITY NOTE;

    IF (has_a_signed = 0 AND a_type = C_UNSIGNED) OR (b_constant = 0) THEN
      RETURN calc_rom_contents(b_width, b_type, a_width, rom_depth, rom_width,
                               start_bit, b_value, num_rom_bits);
    ELSE
      b_value_bv := str_to_bv(b_value, b_width);

      FOR rom_addr IN 0 TO rom_depth-1 LOOP
        
        IF has_a_signed = 0 THEN
          -- Multiply rom_addr by c_b_value
          prod := multiply_bv(natural_to_bit_vector(rom_addr, a_width), b_value_bv, a_signed, (b_type = C_SIGNED));

          FOR BIT IN 0 TO rom_width-1 LOOP
            rom_contents(rom_addr*rom_width + BIT) := prod(BIT + start_bit);
          END LOOP;

        ELSE                            -- c_has_a_signed /= 0

          -- If a_signed_extension then always 0 unless a_signed='1'
          IF a_signed_extension THEN
            IF rom_addr >= 3*max_val AND rom_addr < 4*max_val THEN
              prod := multiply_bv(natural_to_bit_vector(rom_addr, a_width),
                                  b_value_bv, a_signed, (b_type = C_SIGNED));
            ELSE
              prod := (OTHERS => '0');
            END IF;
          ELSE
            IF rom_addr < 2*max_val THEN
              prod := multiply_bv(natural_to_bit_vector(rom_addr, a_width),
                                  b_value_bv, false, (b_type = C_SIGNED));
            ELSIF rom_addr < 3*max_val THEN
              FOR BIT IN start_bit TO prod_width-1 LOOP
                prod(BIT) := rom_contents(((rom_addr-(2*max_val))*rom_width)+BIT);
              END LOOP;
              
            ELSIF rom_addr < 4*max_val THEN
              prod := multiply_bv(natural_to_bit_vector(rom_addr, a_width),
                                  b_value_bv, a_signed, (b_type = C_SIGNED));
            ELSE
              prod := (OTHERS => '0');
            END IF;
          END IF;  -- a_signed_extension

          -- rom_width is always >= 2 if c_has_a_signed /= 0
          FOR BIT IN 0 TO rom_width-2 LOOP
            rom_contents(rom_addr*rom_width + BIT) := prod(BIT + start_bit);
          END LOOP;

          -- rom_width sometimes > prod_width due to a_signed
          IF b_type = C_UNSIGNED AND a_width > 1 AND rom_width > prod_width THEN
            -- An extra output bit is added to distinguish signed and unsigned
            IF rom_addr >= 3*max_val THEN  -- Sign extend
              rom_contents(rom_addr*rom_width +rom_width-1) :=
                prod(rom_width-2+start_bit);
            ELSE
              rom_contents(rom_addr*rom_width +rom_width-1) := '0';
            END IF;
          ELSE
            rom_contents(rom_addr*rom_width +rom_width-1) :=
              prod(rom_width-1+start_bit);
          END IF;

        END IF;  -- c_has_a_signed = 0
        
      END LOOP;

      RETURN rom_contents;
      
    END IF;
    
  END calc_last_rom_contents;

  ------------------------------------------------------------------------------
  -- Return adder level within the symmetric tree for a given adder number.
  -- Adder numbers start from 0. Level 1 is the level nearest the pprods.
  ------------------------------------------------------------------------------
  FUNCTION calc_adder_level(adder_num, max_add_levels : INTEGER) RETURN INTEGER IS
    TYPE     num_al_type IS ARRAY(1 TO max_add_levels) OF INTEGER;
    VARIABLE add_level : INTEGER;
    VARIABLE num_al    : num_al_type;
  BEGIN
    FOR i IN 1 TO max_add_levels LOOP
      num_al(i) := 0;
    END LOOP;

    add_level := 1;

    FOR i IN 0 TO (adder_num-1) LOOP
      num_al(add_level) := num_al(add_level) + 1;

      IF (num_al(add_level) = 2) THEN
        num_al(add_level) := 0;
        add_level         := add_level + 1;
      ELSE
        add_level := 1;
      END IF;
      
    END LOOP;

    RETURN add_level;
    
  END calc_adder_level;

  ------------------------------------------------------------------------------
  -- Return the adder number of the adder whose b input is the last partial
  -- product. Adders are numbered 0 to n.
  ------------------------------------------------------------------------------
  FUNCTION calc_last_pp_adder(num_pps          : INTEGER;
                              max_add_levels   : INTEGER;
                              num_adders       : INTEGER;
                              num_extra_adders : INTEGER) RETURN INTEGER IS
    VARIABLE add_num : INTEGER;
  BEGIN
    IF num_extra_adders > 0 AND (num_pps MOD 2 /= 0) THEN
      -- First extra adder is the last pp adder
      RETURN num_adders-num_extra_adders;
    ELSE
      add_num := 0;

      FOR p IN 0 TO num_pps-2 LOOP
        FOR l IN 1 TO max_add_levels LOOP
          
          IF ((p+1) MOD 2**l = 0) THEN
            add_num := add_num + 1;
          END IF;
          
        END LOOP;  -- l
      END LOOP;  -- p

      RETURN add_num;
      
    END IF;  -- num_extra_adders > 0 ...
  END calc_last_pp_adder;


  ------------------------------------------------------------------------------
  --
  -- Calculate number of extra add stages to place at the right.
  -- Input parameter is total number of partial products.
  --
  -- Algorithm is  (for max_num_pps = 8 example)
  -- add_count := 0
  -- pps=8? Yes --> Done
  -- pps>8? Yes --> Subtract 8, increment add_count, (pps=4?) Yes --> Done
  -- pps>4? Yes --> Subtract 4, increment add_count, (pps=2?) Yes --> Done
  -- pps>2? Yes --> Subtract 2, increment add_count, Done
  -- Done
  ------------------------------------------------------------------------------
  FUNCTION calc_num_extra_adders(num_pps, max_num_pps : INTEGER)
    RETURN INTEGER IS
    VARIABLE adder_count   : INTEGER;
    VARIABLE pps_group     : INTEGER;
    VARIABLE pps_remaining : INTEGER;
  BEGIN
    
    pps_remaining := num_pps;
    pps_group     := max_num_pps;
    adder_count   := 0;

    WHILE ((pps_group > 1) AND (pps_group /= pps_remaining)) LOOP
      
      IF (pps_remaining > pps_group) THEN
        adder_count   := adder_count + 1;
        pps_remaining := pps_remaining - pps_group;
      END IF;

      pps_group := pps_group / 2;
    END LOOP;

    RETURN adder_count;
  END calc_num_extra_adders;

  ------------------------------------------------------------------------------
  -- Return width of partial or full product
  -- Set full_prod to TRUE if width of total final product is to be returned.
  ------------------------------------------------------------------------------
  FUNCTION calc_pp_width(b_width      : INTEGER;
                         b_type       : INTEGER;
                         b_value      : STRING;
                         b_constant   : INTEGER;
                         a_width      : INTEGER;
                         a_type       : INTEGER;
                         has_a_signed : INTEGER;
                         last_pp      : BOOLEAN;
                         full_prod    : BOOLEAN) RETURN INTEGER IS
    CONSTANT a_all_1s : BIT_VECTOR(a_width-1 DOWNTO 0) := (OTHERS => '1');
    CONSTANT b_all_1s : BIT_VECTOR(b_width-1 DOWNTO 0) := (OTHERS => '1');

    -- a_type is always unsigned for partial products if b is not constant
    CONSTANT act_a_type : INTEGER :=
      select_val(a_type, C_UNSIGNED, b_constant = 0 AND NOT(full_prod));
    CONSTANT act_a_sgnd : INTEGER :=
      select_val(has_a_signed, 0, b_constant = 0 AND NOT(full_prod));
    
    VARIABLE min_a               : BIT_VECTOR(a_width-1 DOWNTO 0);
    VARIABLE a_value_bv          : BIT_VECTOR(a_width-1 DOWNTO 0);
    VARIABLE b_value_bv          : BIT_VECTOR(b_width-1 DOWNTO 0);
    VARIABLE pp_width            : INTEGER;
    VARIABLE pp_width_a_negative : INTEGER;
  BEGIN
    IF b_width = 1 AND b_type = C_UNSIGNED THEN
      IF b_value(b_value'high) = '0' AND b_constant /= 0 THEN
        pp_width := 1;                  -- Special case for multiplying by 0
      ELSE
        pp_width := a_width;

        -- a_signed is not part of pp input if b_constant/=0
        IF last_pp AND act_a_sgnd /= 0 THEN
          pp_width := pp_width + 1;
        END IF;
      END IF;  -- b_value
    ELSE
      -- Return minimum number of bits to represent maximum possible pp value
      IF b_constant = 0 THEN
        IF b_type = C_UNSIGNED THEN
          -- Must assume max possible B value
          b_value_bv := b_all_1s;
        ELSE
          IF b_width > 1 THEN
            b_value_bv(b_width-2 DOWNTO 0) := (OTHERS => '0');
          END IF;
          b_value_bv(b_width-1) := '1';
        END IF;  -- b_type = C_UNSIGNED

      ELSE
        b_value_bv := str_to_bv(b_value, b_width);
      END IF;

--      ASSERT false
--        REPORT "calc_pp_width debug" & new_line &
--        "          a_width = " & int_2_string(a_width) & new_line &
--        "          b_width = " & int_2_string(b_width) & new_line &
--        "          b_value_bv = " & bv_to_str(b_value_bv, b_width) &
--        new_line
--        SEVERITY note;

      -- A input always treated as unsigned except for last pp
      IF NOT(last_pp) OR act_a_type = C_UNSIGNED THEN
        IF a_width = 1 AND b_value_bv = b_all_1s AND b_type /= C_UNSIGNED AND
          b_constant /= 0 THEN
          pp_width := 1;                -- -1 * (0 or 1) only needs 1 bit
        ELSE
          pp_width := bitstorep_bv(multiply_bv(a_all_1s, b_value_bv, false, (b_type = C_SIGNED)), b_type, (b_type /= C_SIGNED));

--          ASSERT false
--            REPORT "calc_pp_width debug (A)" & new_line &
--            "          pp_width = " & int_2_string(pp_width) & new_line &
--            "          mult_bv = " & bv_to_str(multiply_bv(a_all_1s, b_value_bv, false, (b_type = C_SIGNED)), a_width+b_width) & new_line &
--            new_line
--            SEVERITY note;

        END IF;  -- a_width = 1 AND ...

        -- a_signed input has effect on last PP
      ELSIF act_a_sgnd /= 0 THEN        -- 1 is added later
        pp_width := bitstorep_bv(multiply_bv(a_all_1s, b_value_bv, false, (b_type = C_SIGNED)), b_type, (b_type /= C_SIGNED));
        -- Add 1 to last pp width if extra bit has to be added due to
        -- c_has_a_signed as above result always +ve if b_type unsigned
        IF b_type = C_UNSIGNED THEN
          pp_width := pp_width + 1;
        ELSE
          -- Get minimum possible A value
          IF a_width > 1 THEN
            a_value_bv(a_width-2 DOWNTO 0) := (OTHERS => '0');
          END IF;
          a_value_bv(a_width-1) := '1';

          -- Min A * Min B to get max +ve output
          pp_width_a_negative := bitstorep_bv(multiply_bv(a_value_bv, b_value_bv, true, true), C_UNSIGNED, true);  -- -ve (A) * -ve (B) = +ve

          IF pp_width_a_negative >= pp_width THEN
            pp_width := pp_width + 1;
          END IF;
          
        END IF;

--        ASSERT false
--          REPORT "calc_pp_width debug (B)" & new_line &
--          "          pp_width = " & int_2_string(pp_width) & new_line &
--          "          mult_bv = " & bv_to_str(multiply_bv(a_all_1s, b_value_bv, false, (b_type = C_SIGNED)), a_width+b_width) & new_line &
--          new_line
--          SEVERITY note;

      ELSE  -- last_pp and a_type=C_SIGNED and c_has_a_signed=0

        IF a_width = 1 THEN             -- Worst case = -1
          pp_width := bitstorep_bv(multiply_bv("11", b_value_bv, true, (b_type = C_SIGNED)), C_SIGNED, (b_type = C_SIGNED));
        ELSE
          -- Lowest possible A value
          min_a(a_width-2 DOWNTO 0) := (OTHERS => '0');
          min_a(a_width-1)          := '1';

          -- Determine type of widest possible PP
          -- -ve * -ve = +ve, -ve * +ve = -ve
          pp_width := bitstorep_bv(multiply_bv(min_a, b_value_bv, true, (b_type = C_SIGNED)), C_SIGNED, (b_type = C_SIGNED));

--          ASSERT false
--            REPORT "calc_pp_width debug (C)" & new_line &
--            "          pp_width = " & int_2_string(pp_width) & new_line &
--            "          mult_bv = " & bv_to_str(multiply_bv(min_a, b_value_bv, true, (b_type = C_SIGNED)), a_width+b_width) & new_line &
--            "          min_a = " & bv_to_str(min_a, a_width) & new_line &
--            new_line
--            SEVERITY note;
          
        END IF;

      END IF;  -- NOT(last_pp) OR ...

    END IF;

    ASSERT NOT(debug) REPORT "INFO: pp_width calculated as " & INTEGER'image(pp_width) SEVERITY note;
    RETURN pp_width;
  END calc_pp_width;

  ------------------------------------------------------------------------------
  -- Sometimes specified c_mem_type parameter is illegal. Check and change to a
  -- legal value if necessary.
  ------------------------------------------------------------------------------
  FUNCTION get_mem_type(family          : T_DEVICE_FAMILY;
                        mem_type        : INTEGER;
                        bram_addr_width : INTEGER;
                        has_swapb       : INTEGER;
                        a_width         : INTEGER;
                        a_type          : INTEGER;
                        has_a_signed    : INTEGER;
                        b_constant      : INTEGER;
                        has_o           : INTEGER) RETURN INTEGER IS
    CONSTANT rom_addr_width : INTEGER := get_rom_addr_width(family, mem_type);

    CONSTANT a_input_width : INTEGER := calc_a_input_width(a_width, has_a_signed, rom_addr_width, b_constant);

    CONSTANT number_of_pps : INTEGER := calc_num_pps(a_input_width, rom_addr_width);

    CONSTANT need_addsub : BOOLEAN := b_constant = 0 AND (a_type /= C_UNSIGNED OR has_a_signed /= 0);

    -- Single PP but need an addsub to negate result
    CONSTANT need_0_minus_pp : BOOLEAN := need_addsub AND number_of_pps <= 1;

    CONSTANT number_of_adders : INTEGER := select_val(number_of_pps-1, 1, need_0_minus_pp);

    VARIABLE mem_type_i : INTEGER;
  BEGIN
    IF mem_type /= C_DISTRIBUTED AND has_swapb = 0 AND has_o /= 0 AND number_of_adders < 1 THEN

      mem_type_i := C_DISTRIBUTED;

      ASSERT false
        REPORT "ERROR: CCM - the O output is not available with block memory " &
        "and this parameter combination." & new_line &
        "                            Select distributed memory if the O " &
        "output is required in this case." & new_line
        SEVERITY failure;
    ELSE
      mem_type_i := mem_type;
    END IF;

    RETURN mem_type_i;
  END get_mem_type;

  -----------------------------------------------------------------------------
  -- FUNCTIONS FROM CCM_UTILS_V9_0
  -----------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Return number of bits required to represent the supplied parameter
--------------------------------------------------------------------------------
  FUNCTION bitsneededtorepresent(a_value : NATURAL) RETURN NATURAL IS
    VARIABLE return_value : NATURAL := 1;
  BEGIN

    FOR i IN 30 DOWNTO 0 LOOP
      IF a_value >= 2**i THEN
        return_value := i+1;
        EXIT;
      END IF;
    END LOOP;

    RETURN return_value;

  END bitsneededtorepresent;

-------------------------------------------------------------------------------
-- bitstorep_bv updated by andreww 19th May 06 - Worked correctly with MTI 6.1e,
-- but not with XST I.31 - simplified code to ease debug
-- Assumes that the bit_vector a_value is a DOWNTO vector
-------------------------------------------------------------------------------
  FUNCTION bitstorep_bv(a_value    : BIT_VECTOR;
                        a_type     : INTEGER;
                        a_positive : BOOLEAN) RETURN NATURAL IS
    VARIABLE return_value : INTEGER := a_value'length;
  BEGIN

    IF a_type = c_unsigned THEN

      -- a_value represents an unsigned number    
      FOR i IN a_value'high DOWNTO a_value'low LOOP
        IF a_value(i) = '1' THEN
          EXIT;                         -- EXIT when the msb is found
        ELSIF a_value(i) = '0' THEN
          return_value := return_value - 1;
        END IF;
      END LOOP;
      
    ELSE

      -- a_value represents a signed number
      
      IF a_positive THEN

        -- Look for ms '1' then add 1 for a leading 0      
        FOR i IN a_value'high DOWNTO a_value'low LOOP
          IF a_value(i) = '0' AND a_value(i-1) = '1' THEN
            EXIT;
          ELSE
            return_value := return_value - 1;
          END IF;
        END LOOP;  -- i
        
      ELSE

        -- Look for ms '1' followed by a '0'
        FOR i IN a_value'high DOWNTO a_value'low LOOP
          IF a_value(i) = '1' AND a_value(i-1) = '0' THEN
            EXIT;
          ELSE
            return_value := return_value - 1;
          END IF;
        END LOOP;  -- i
        
      END IF;  -- a_positive
      
    END IF;

    IF return_value <= 0 THEN
      RETURN 1;
    ELSIF a_type /= c_unsigned AND return_value <= 2 THEN
      RETURN 2;  -- always need at least 2 bits to represent signed numbers
    ELSE
      RETURN return_value;
    END IF;

  END bitstorep_bv;

--------------------------------------------------------------------------------
-- Convert STD_LOGIC_VECTOR to STRING
-- Assumes STRING is of type (n TO n+length-1) with MSB in 'n' position.
-- Returns STD_LOGIC_VECTOR of type (nbits-1 DOWNTO 0) with LSB in 0 position.
--------------------------------------------------------------------------------
  FUNCTION slv_to_str(bitsin : STD_LOGIC_VECTOR; nbits : INTEGER) RETURN STRING IS
    VARIABLE ret     : STRING(1 TO nbits);
    VARIABLE bit_num : INTEGER;
  BEGIN
    ret := (OTHERS => '0');

    bit_num := 1;

    FOR i IN bitsin'range LOOP
      
      IF bitsin(i) = '1' THEN
        ret(bit_num) := '1';
      ELSIF bitsin(i) = '0' THEN
        ret(bit_num) := '0';
      ELSIF (bitsin(i) = 'L') THEN
        ret(bit_num) := 'L';
      ELSIF (bitsin(i) = 'H') THEN
        ret(bit_num) := 'H';
      ELSIF (bitsin(i) = 'Z') THEN
        ret(bit_num) := 'Z';
      ELSIF (bitsin(i) = 'W') THEN
        ret(bit_num) := 'W';
      ELSIF (bitsin(i) = 'U') THEN
        ret(bit_num) := 'U';
      ELSIF (bitsin(i) = 'X') THEN
        ret(bit_num) := 'X';
      ELSIF (bitsin(i) = '-') THEN
        ret(bit_num) := '-';
      ELSE
        ASSERT false
          REPORT "ERROR: invalid character passed to slv_to_str function." &
          new_line
          SEVERITY failure;
      END IF;

      bit_num := bit_num + 1;

      IF bit_num > nbits THEN
        EXIT;  -- Ignore ms bits in SLV if SLV is longer than STRING
      END IF;
    END LOOP;

    RETURN ret;
    
  END slv_to_str;

--------------------------------------------------------------------------------
-- Convert INTEGER to STRING
--------------------------------------------------------------------------------
  FUNCTION int_2_string(int_value : INTEGER) RETURN STRING IS

    VARIABLE digit        : INTEGER;
    VARIABLE value        : INTEGER;
    VARIABLE length       : INTEGER         := 0;
    VARIABLE posn         : INTEGER;
    VARIABLE start_length : INTEGER;
    CONSTANT str          : STRING(1 TO 10) := "0123456789";
    VARIABLE ret_value    : STRING(1 TO 11);

  BEGIN

    IF int_value < 0 THEN
      IF int_value = -2147483647 THEN
        RETURN ("-2147483647");  -- largest possible negative number supported by XST
      ELSE
        value        := -1 * int_value;
        start_length := 1;
        ret_value(1) := '-';
      END IF;
    ELSE
      value        := int_value;
      start_length := 0;
    END IF;

    IF (value = 0) THEN
      RETURN "0";
    ELSIF (value < 10) THEN
      length := 1 + start_length;
    ELSIF (value < 100) THEN
      length := 2 + start_length;
    ELSIF (value < 1000) THEN
      length := 3 + start_length;
    ELSIF (value < 10000) THEN
      length := 4 + start_length;
    ELSIF (value < 100000) THEN
      length := 5 + start_length;
    ELSIF (value < 1000000) THEN
      length := 6 + start_length;
    ELSIF (value < 10000000) THEN
      length := 7 + start_length;
    ELSIF (value < 100000000) THEN
      length := 8 + start_length;
    ELSIF (value < 1000000000) THEN
      length := 9 + start_length;
    ELSE
      length := 10 + start_length;
    END IF;

    IF (length > 0) THEN  -- Required because Metamor bombs without it
      posn := length;
      WHILE (value /= 0) LOOP
        digit           := value MOD 10;
        ret_value(posn) := str(digit+1);
        value           := value/10;
        posn            := posn - 1;
      END LOOP;
    END IF;

    RETURN ret_value(1 TO length);

  END int_2_string;

--------------------------------------------------------------------------------
-- Return i0 if sel = 0, i1 if sel = 1
--------------------------------------------------------------------------------
  FUNCTION mult_gen_max_of(i0, i1 : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (i0 > i1) THEN
      RETURN i0;
    ELSE
      RETURN i1;
    END IF;
  END mult_gen_max_of;

-------------------------------------------------------------------------------
-- function modified by andreww 13th May 06 - need to account for signed and
-- unsigned products
-------------------------------------------------------------------------------
  FUNCTION multiply_bv(a, b : BIT_VECTOR; a_signed, b_signed : BOOLEAN) RETURN BIT_VECTOR IS
    VARIABLE ai      : STD_LOGIC_VECTOR(a'high+1 DOWNTO a'low);
    VARIABLE bi      : STD_LOGIC_VECTOR(b'high+1 DOWNTO b'low);
    VARIABLE prod    : STD_LOGIC_VECTOR(ai'length+bi'length-1 DOWNTO 0);
    -- create an intermediate variable to assign the bit_vector into
    -- if we don't do this and return directly from the to_bitvector function,
    -- XST assumes that the returned bit_vector is (0 TO N-1) rather than the
    -- (N-1 downto 0) that we require (and all other functions assume...)
    VARIABLE prod_bv : BIT_VECTOR(a'length+b'length-1 DOWNTO 0);
  BEGIN
    
    IF a_signed THEN
      ai := STD_LOGIC_VECTOR(resize(SIGNED(to_Stdlogicvector(a)), ai'length));
    ELSE
      ai := STD_LOGIC_VECTOR(resize(UNSIGNED(to_Stdlogicvector(a)), ai'length));
    END IF;
    IF b_signed THEN
      bi := STD_LOGIC_VECTOR(resize(SIGNED(to_Stdlogicvector(b)), bi'length));
    ELSE
      bi := STD_LOGIC_VECTOR(resize(UNSIGNED(to_Stdlogicvector(b)), bi'length));
    END IF;

    -- since we've manually sign- (or zero-) extended, we can perform a signed multiplication
    prod := ieee.std_logic_signed."*"(ai, bi);

    -- return only the necessary width - don't use the resize() function here as it can give the wrong results
    prod_bv := to_bitvector(prod(a'length+b'length-1 DOWNTO 0));

    RETURN prod_bv;
    
  END multiply_bv;

--------------------------------------------------------------------------------
-- Convert NATURAL to BIT_VECTOR
-- The ls length bits of in_val are returned.
--------------------------------------------------------------------------------
  FUNCTION natural_to_bit_vector(in_val : IN NATURAL; length : IN NATURAL)
    RETURN BIT_VECTOR IS
    VARIABLE temp   : NATURAL                       := in_val;
    VARIABLE result : BIT_VECTOR(length-1 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    FOR i IN result'reverse_range LOOP
      IF (temp REM 2 = 0) THEN
        result(i) := '0';
      ELSE
        result(i) := '1';
      END IF;
      temp := temp/2;
      EXIT WHEN temp = 0;
    END LOOP;
    RETURN result;
  END natural_to_bit_vector;


--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
  FUNCTION mult_gen_select_string(i0 : STRING; i1 : STRING; sel : BOOLEAN)
    RETURN STRING IS
  BEGIN
    IF sel THEN
      RETURN i1;
    ELSE
      RETURN i0;
    END IF;  -- sel
  END mult_gen_select_string;


--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
  FUNCTION select_val(i0 : INTEGER; i1 : INTEGER; sel : BOOLEAN) RETURN INTEGER IS
  BEGIN
    IF sel THEN
      RETURN i1;
    ELSE
      RETURN i0;
    END IF;  -- sel
  END select_val;

  FUNCTION select_val_int(i0 : INTEGER; i1 : INTEGER; sel : INTEGER) RETURN INTEGER IS
  BEGIN
    IF sel = 1 THEN
      RETURN i1;
    ELSE
      RETURN i0;
    END IF;  -- sel
  END select_val_int;

--------------------------------------------------------------------------------
-- Convert STRING to STD_LOGIC_VECTOR
-- Assumes STRING is of type (n TO n+length-1) with MSB in 'n' position.
-- Returns SLV of type (nbits-1 DOWNTO 0) with LSB in 0 position.
--------------------------------------------------------------------------------
  FUNCTION str_to_slv(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR IS
    -- STRING types RANGE from 1 to len!!!
    VARIABLE ret     : STD_LOGIC_VECTOR(nbits-1 DOWNTO 0);
    VARIABLE bit_num : INTEGER;
  BEGIN
    
    ret := (OTHERS => '0');

    IF (bitsin'length = 0) THEN         -- Make all '0's
      RETURN ret;
    END IF;

    bit_num := 0;

    FOR i IN bitsin'high DOWNTO bitsin'low LOOP
      
      IF bitsin(i) = '1' THEN
        ret(bit_num) := '1';
      ELSIF bitsin(i) = '0' THEN
        ret(bit_num) := '0';
      ELSIF (bitsin(i) = 'U' OR bitsin(i) = 'u') THEN
        ret(bit_num) := 'U';
      ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
        ret(bit_num) := 'X';
      ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
        ret(bit_num) := 'Z';
      ELSIF (bitsin(i) = 'W' OR bitsin(i) = 'w') THEN
        ret(bit_num) := 'W';
      ELSIF (bitsin(i) = 'L' OR bitsin(i) = 'l') THEN
        ret(bit_num) := 'L';
      ELSIF (bitsin(i) = 'H' OR bitsin(i) = 'h') THEN
        ret(bit_num) := 'H';
      ELSIF (bitsin(i) = '-') THEN
        ret(bit_num) := '-';
      ELSE
        ASSERT false
          REPORT "ERROR: invalid character passed to str_to_slv function." &
          new_line & " STRING passed in was: " & bitsin
          SEVERITY failure;
      END IF;

      bit_num := bit_num + 1;

      IF bit_num >= nbits THEN
        EXIT;  -- Ignore ms characters in STRING if STRING is longer than BV
      END IF;
    END LOOP;

    RETURN ret;
    
  END str_to_slv;


--------------------------------------------------------------------------------
-- Convert STRING to BIT_VECTOR
-- Assumes STRING is of type (n TO n+length-1) with MSB in 'n' position.
-- Returns BIT_VECTOR of type (nbits-1 DOWNTO 0) with LSB in 0 position.
--------------------------------------------------------------------------------
  FUNCTION str_to_bv(bitsin : STRING; nbits : INTEGER) RETURN BIT_VECTOR IS
    VARIABLE ret     : BIT_VECTOR(nbits-1 DOWNTO 0);
    VARIABLE bit_num : INTEGER;
  BEGIN
    ret := (OTHERS => '0');

    IF (bitsin'length = 0) THEN         -- Make all '0's
      RETURN ret;
    END IF;

    bit_num := 0;

    --  FOR i IN bitsin'REVERSE_RANGE LOOP -- doesn't work with XCC
    FOR i IN bitsin'high DOWNTO bitsin'low LOOP
      
      IF bitsin(i) = '1' THEN
        ret(bit_num) := '1';
      ELSIF bitsin(i) = '0' THEN
        ret(bit_num) := '0';
      ELSE
        ASSERT false
          REPORT "ERROR: non 0 or 1 character passed to str_to_bv function." &
          new_line & " STRING passed in was: " & bitsin
          SEVERITY failure;
      END IF;

      bit_num := bit_num + 1;

      IF bit_num >= nbits THEN
        EXIT;  -- Ignore ms characters in STRING if STRING is longer than BV
      END IF;
    END LOOP;

    RETURN ret;
    
  END str_to_bv;

  -----------------------------------------------------------------------------
  -- functions imported from ccm_mem_utils_v9.0.vhd

  FUNCTION calc_depth(reqd_depth : INTEGER; mem_type : INTEGER) RETURN INTEGER IS
    VARIABLE extra      : INTEGER := 0;
    VARIABLE addr_width : INTEGER := bitsneededtorepresent(reqd_depth-1);
  BEGIN
    IF mem_type = c_distributed THEN
      extra := reqd_depth MOD 2**addr_width;  --16;

      IF (extra = 0) THEN
        RETURN reqd_depth;
      ELSE
        RETURN (reqd_depth + (2**addr_width) - extra);  --16 - extra);
      END IF;
    ELSE
      -- Must be block mem. Block mems must be 16, 32, 64, 128, 256 or n * 256 deep
      IF reqd_depth <= 16 THEN
        RETURN 16;
      ELSIF reqd_depth <= 256 THEN
        RETURN 2**(bitsneededtorepresent(reqd_depth-1));
      ELSE
        RETURN 256 + (256 * ((reqd_depth-1)/256));
      END IF;  -- reqd_depth
      
    END IF;  -- mem_type
  END calc_depth;

  IMPURE FUNCTION mult_gen_write_meminit_file(filename : IN STRING; depth : IN POSITIVE; width : IN POSITIVE; memvect : IN BIT_VECTOR) RETURN BOOLEAN IS
    FILE meminitfile        : TEXT;
    VARIABLE mif_status     : FILE_OPEN_STATUS;
    VARIABLE bitline        : LINE;
    VARIABLE bitslv         : STD_LOGIC_VECTOR(width DOWNTO 1);
    VARIABLE offset         : INTEGER;
    VARIABLE contents       : BIT_VECTOR(1 TO width);
    CONSTANT mem_bits       : INTEGER := depth * width;
    VARIABLE padded_memvect : BIT_VECTOR(1 TO mem_bits);
  BEGIN

    -- created a padded out vector that has the same number of bits in it as is specified by mem_bits
    padded_memvect(1 TO memvect'length) := memvect;
    IF memvect'length < mem_bits THEN
      padded_memvect(memvect'length+1 TO mem_bits) := (OTHERS => '0');
    END IF;

    file_open(mif_status, meminitfile, filename, write_mode);

    ASSERT mif_status = open_ok
      REPORT "Error: mult_gen_v10_0: Couldn't open memory initialization file: " & filename
      SEVERITY failure;
    
    IF mif_status = open_ok THEN
      offset := 0;

      FOR i IN 0 TO depth-1 LOOP
        contents := padded_memvect(padded_memvect'high-offset-width+1 TO padded_memvect'high-offset);
        WRITE(bitline, contents);
        WRITELINE(meminitfile, bitline);
        offset   := offset + width;
      END LOOP;
      
    END IF;  -- mif_status

    FILE_CLOSE(meminitfile);

    RETURN true;
    
  END mult_gen_write_meminit_file;
  
END PACKAGE BODY pkg_mult_gen_v10_0;
