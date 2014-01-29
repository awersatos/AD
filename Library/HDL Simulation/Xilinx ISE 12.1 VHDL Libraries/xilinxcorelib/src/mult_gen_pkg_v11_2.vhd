-- $Id: mult_gen_pkg_v11_2.vhd,v 1.3 2009/12/04 11:46:26 akennedy Exp $
--------------------------------------------------------------------------------
-- (c) Copyright 2006 - 2009 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 
--------------------------------------------------------------------------------
-- Master package for Multiplier core
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

package mult_gen_pkg_v11_2 is

  -----------------------------------------------------------------------------
  -- Constants and functions for use all over the core
  -----------------------------------------------------------------------------

  -- enable/disable debug output from functions
  constant debug : boolean := false;

  -- enable assert statements to debug progress through function hierarchy
  constant fn_debug : boolean := false;

  -- enable debug output for CCM functions
  constant ccm_debug : boolean := false;
  
  -- enumerated constants for c_mult_type
  constant LUT           : integer := 0;
  constant EMBEDDED_MULT : integer := 1;
  constant FIXED_CCM     : integer := 2;

  -- enumerated constants for c_optimize_goal
  constant EMB_MULT_RESOURCES : integer := 0;
  constant CORE_SPEED         : integer := 1;

  -- enumerated constants for the on/off pins e.g. CE, SCLR
  constant MG_NO  : integer := 0;
  constant MG_YES : integer := 1;

  -- enumerated constants for c_ccm_imp
  constant DIST_MEM : integer := 0;
  constant BRAM     : integer := 1;
  constant MULTS    : integer := 2;
  constant CSD      : integer := 3;

  constant PIPELINE_CFG_BREAKPT : integer := 1000000000;

  constant MAX_PIPE_STAGES : integer := 30;

  constant MAX_PRODUCT_WIDTH : integer := 128;

  -- constants for the 3 possible hybrid configurations
  constant BASE_MULT : integer := 0;  -- no fabric required - just use the base DSP48 or Mult18x18 multiplier
  constant ONE_MULT  : integer := 1;  -- fabric multiplier only needed on one side of the partial-product array
  constant TWO_MULT  : integer := 2;  -- 2 fabric multipliers and a fabric adder needed around the embedded mult array

  -- default generics for all core components etc.
  constant DEF_C_VERBOSITY         : integer := 0;
  constant DEF_C_MODEL_TYPE        : integer := 1;
  constant DEF_C_XDEVICEFAMILY     : string  := "no_family";
  constant DEF_C_A_WIDTH           : integer := 18;
  constant DEF_C_A_TYPE            : integer := 0;
  constant DEF_C_B_WIDTH           : integer := 18;
  constant DEF_C_B_TYPE            : integer := 0;
  constant DEF_C_OUT_HIGH          : integer := 35;
  constant DEF_C_OUT_LOW           : integer := 0;
  constant DEF_C_MULT_TYPE         : integer := EMBEDDED_MULT;
  constant DEF_C_OPTIMIZE_GOAL     : integer := CORE_SPEED;
  constant DEF_C_HAS_CE            : integer := MG_NO;
  constant DEF_C_HAS_SCLR          : integer := MG_NO;
  constant DEF_C_CE_OVERRIDES_SCLR : integer := MG_NO;
  constant DEF_C_LATENCY           : integer := 1;
  constant DEF_C_CCM_IMP           : integer := DIST_MEM;
  constant DEF_C_B_VALUE           : string  := "111111111111111111";
  constant DEF_C_HAS_ZERO_DETECT   : integer := MG_NO;
  constant DEF_C_ROUND_OUTPUT      : integer := MG_NO;
  constant DEF_C_ROUND_PT          : integer := 0;

  constant DSP_P_WIDTH : integer := 48;
  
  -----------------------------------------------------------------------------
  -- TYPES AND RECORDS
  -----------------------------------------------------------------------------

  -- record to define the widths of all the ports that may be required when building a block-based multiplier
  type PORT_ASPECTS is record
    a : integer;                        -- size of port A
    b : integer;                        -- size of port B
    m : integer;                        -- size of M register after mult
    c : integer;                        -- size of port C
    p : integer;                        -- size of port P
  end record PORT_ASPECTS;

  -- a record to store the width of the a and b operands and if they should be
  -- swapped internally for the best mapping/resource use
  type WIDTH_REC is record
    a      : integer;
    b      : integer;
    a_type : integer;
    b_type : integer;
    swap   : boolean;
  end record WIDTH_REC;

  type BLOCK_MULT_REC is record
    a_width : integer;                  -- width of A operand on block mult
    a_type  : integer;                  -- datatype of A operand on block mult
    b_width : integer;                  -- width of B operand on block mult
    b_type  : integer;                  -- datatype of B operand on block mult
  end record BLOCK_MULT_REC;

  type ONE_MULT_REC is record
    a         : integer;                -- width of A input to fabric mult
    b         : integer;                -- width of B input to fabric mult
    a_type    : integer;                -- type of A input to fabric mult
    b_type    : integer;                -- type of B input to fabric mult
    out_width : integer;                -- output width of fabric mult
    bypass    : integer;                -- number of bypass bits
    a_offset  : integer;  -- the offset on the A operand due to the mult configuration and # bypass bits
    b_offset  : integer;  -- the offset on the B operand due to the mult configuration and # bypass bits
  end record ONE_MULT_REC;

  type TWO_MULT_REC is record
    a_top          : integer;  -- width of A operand on top fabric mult
    b_top          : integer;  -- width of B operand on top fabric mult
    a_type_top     : integer;           -- type of A operand on top fabric mult
    b_type_top     : integer;           -- type of B operand on top fabric mult
    out_width_top  : integer;           -- output width of top fabric mult
    a_side         : integer;  -- width of A operand on side fabric mult
    b_side         : integer;  -- width of B operand on side fabric mult
    a_type_side    : integer;  -- type of A operand on side fabric mult
    b_type_side    : integer;  -- type of B operand on side fabric mult
    out_width_side : integer;           -- output width of side fabric mult
    mult_bypass    : integer;  -- number of bypass bits from top fabric mult
    add_bypass     : integer;  -- number of bypass bits from fabric adder
    a_offset       : integer;  -- offset for A operand into block multiplier
    b_offset       : integer;  -- offset for B operand into block multiplier
  end record TWO_MULT_REC;

  -- Record holding the resolved generics with any user misconfiguration or
  -- invalid settings removed
  type T_RESOLVED_GENERICS is record
    R_A_WIDTH           : integer;
    R_A_TYPE            : integer;
    R_B_WIDTH           : integer;
    R_B_TYPE            : integer;
    R_OUT_HIGH          : integer;
    R_OUT_LOW           : integer;
    R_MULT_TYPE         : integer;
    R_OPT_GOAL          : integer;
    R_HAS_CE            : integer;
    R_HAS_SCLR          : integer;
    R_CE_OVERRIDES_SCLR : integer;
    R_LATENCY           : integer;
    R_CCM_IMP           : integer;
    R_B_VALUE           : string(1 to 64);
    R_HAS_ZERO_DETECT   : integer;
    R_ROUND_OUTPUT      : integer;
    R_ROUND_PT          : integer;
  end record T_RESOLVED_GENERICS;

  -- record to hold details of the DSP48 partial products so they can all be passed
  -- back from a single function
  type R_DSP_PP is record
    a_pp       : integer;
    b_pp       : integer;
    extra_b_pp : integer;
  end record R_DSP_PP;

  -- record to hold the resource counts for use by the core's GUI
  type R_MULT_RESOURCES is record
    LUTs       : integer;
    DSPs       : integer;
    MULT18X18s : integer;
    BRAMS      : integer;
  end record R_MULT_RESOURCES;
  
  -----------------------------------------------------------------------------
  -- FUNCTIONS
  -----------------------------------------------------------------------------

  -- purpose: validates the generics for the whole core, traps any bad combinations
  function check_generics(c_xdevicefamily                         : string;
                          a_width, a_type, b_width, b_type        : integer;
                          out_high, out_low                       : integer;
                          mult_type, opt_goal                     : integer;
                          has_ce, has_sclr, ce_overrides_sclr     : integer;
                          latency, ccm_imp                        : integer;
                          b_value                                 : string;
                          has_zero_detect, round_output, round_pt : integer) return T_RESOLVED_GENERICS;

  -- purpose: catches the case where the xdevicefamily is Spartan-3E, 3A or 3ADSP and modifies the family info accordingly
  -- There aren't any shared functions to do this, but the only piece of IP where this really matters is the multiplier
--  function modify_family(family_str : string) return string;

  -- converts a std_logic bit to an integer representation
  function sl_to_int(sl : std_logic) return integer;

  -- reports the 'logarithm' (base 2) of an INTEGER
  function mult_gen_log2(x : integer) return integer;

  -- reports the 'logarithm' (base 2) of an INTEGER
  -- the value it returns is constrained to the integer value
  -- e.g. log(4) = 2, log(6) = 2, log(8) = 3, log(10) = 3
  function mult_gen_log2d(x : integer) return integer;

  -- purpose: calculates the a_pp and b_pp partial product configurations for
  -- DSP48 multipliers, and deals with irregular structures used for some optimisations
  function calc_dsp48_pps (family : string; op_width : WIDTH_REC) return R_DSP_PP;

  -- purpose: calculates term number for LUT6 mult
  function func_term_number(an : integer; bn : integer; s : integer) return integer;  

  -- purpose: calculates number of adder layers for LUT6 mult
  function adder_layer_number_calc(width : integer) return integer;
  
  -- purpose: works out for the multiplier specification provided what the fully-pipelined latency will be
  -- This is the public interface to the core's latency function
  function mult_gen_v11_2_calc_fully_pipelined_latency (family : string; a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : integer; b_value : string) return integer;
  
  -- purpose: works out for the multiplier specification provided what the fully-pipelined latency will be
  -- Used when calling the multiplier from inside another core
  function mult_gen_v11_2_calc_fully_pipelined_latency_internal (family : string; a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : integer; b_value : string; standalone : integer := 1) return integer;

  -- purpose: works out if the operands need to be swapped around and generates the correct widths for them
  -- these values can then be used to control the wire swapping in the hardware generation  
  function get_true_widths(family : string; c_a_width, c_b_width, c_a_type, c_b_type : integer; port_size : PORT_ASPECTS) return WIDTH_REC;

  -- purpose: works out how many partial products are required for the A operand (number of DSPs/MULT18X18s)
  function calc_a_pp(family : string; op_width : WIDTH_REC) return integer;

  -- purpose: works out how many partial products are required for the B operand (number of DSPs/MULT18X18s)
  -- note that there is no family restriction here because MULT18X18, DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier  
  function calc_b_pp(op_width : WIDTH_REC) return integer;

  -- purpose: works out how many partial products are required for the A operand (number of DSPs/MULT18X18s)
  function hybrid_calc_a_pp(family : string; op_width : WIDTH_REC) return integer;

  -- purpose: works out how many partial products are required for the B operand (number of DSPs/MULT18X18s)
  -- note that there is no family restriction here because MULT18X18, DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier
  function hybrid_calc_b_pp(family : string; op_width : WIDTH_REC) return integer;

  -- purpose: works out which configuration of hybrid is required based on the input operand widths
  -- and types and the multiplier primitive being used
  function get_hybrid_configuration(family     : string;
                                    a_pp, b_pp : integer;
                                    op_width   : WIDTH_REC;
                                    port_size  : PORT_ASPECTS)return integer;

  -- purpose: works out the operand widths and types for the block multiplier subcomponent
  function get_block_mult_cfg (family     : string;
                               a_pp, b_pp : integer;
                               op_width   : WIDTH_REC;
                               hybrid_cfg : integer;
                               port_size  : PORT_ASPECTS) return BLOCK_MULT_REC;

  function get_one_mult_cfg(width                                                    : WIDTH_REC;
                            block_a_width, block_a_type, block_b_width, block_b_type : integer;
                            hybrid_cfg                                               : integer;
                            port_size                                                : PORT_ASPECTS) return ONE_MULT_REC;

  -- purpose: works out the required operand widths of the fabric multiplier for the 'two mult' case
  function get_two_mult_cfg(op_width                         : WIDTH_REC;
                            a_width, a_type, b_width, b_type : integer;
                            hybrid_cfg                       : integer) return TWO_MULT_REC;

  -- purpose: works out fully-pipelined latency of a LUT multiplier
  function fab_mult_full_pipe_lat(a_width, b_width : integer) return integer;

  -- purpose: works out how many pipeline stages a particular configuration of DSPs or MULT18s needs
  -- for max performance
  function get_emb_mult_max_pipe_stages (family : string; a_pp, b_pp : integer) return integer;

  -- purpose: works out the depth of the adder tree on the LUT multiplier(s)
  -- to see what the maximum fully-pipelined latency will be
  function get_LUT_max_pipe_stages (one_mult_cfg : ONE_MULT_REC; two_mult_cfg : TWO_MULT_REC; hybrid_configuration : integer) return integer;

  -- purpose: checks to see if the constant has any zeros at the MSB (left) side of the string and
  -- returns an integer to say how many consecutive zeros there are
  -- These zeros don't need to go through the multiplier, so we could save some
  -- logic in a few cases
  -- If the constant is of signed type, we need to keep one of the leading zeros
  -- If the constant is signed though, we can also check for leading ones and
  -- trim them, stopping when we find "10" when searching from the left-hand side
  function get_trimmed_leading_bits (b_value : string; b_type : integer; mult_type : integer) return integer;

  -- purpose: counts the number of LSB zeros in the supplied constant STRING
  -- If the bits are zero, we don't need to pass these bits into the multiplier
  -- and we can just right-shift the output by these number of bits 
  function get_output_scaling (b_value : string; b_type : integer; mult_type : integer) return integer;

  -- purpose: checks if the constant is all-zeros, in which case there is no point in creating logic!
  function check_b_value_all_zeros (b_value : string; b_value_length : integer) return boolean;

--  -- purpose: returns the c_family equivalent of a string value
--  function t_device_family_to_c_family (family : string) return string;

--  -- purpose: returns the c_xdevicefamily equivalent of a string value
--  function t_device_family_to_c_xdevicefamily (family : string) return string;

  -- purpose: checks if the constant string represents a power of two
  function check_const_power_of_two (b_value : string; b_type, mult_type : integer) return boolean;
  
-------------------------------------------------------------------------------
-- Functions, constants, types imported from ccm_pkg.vhd
-------------------------------------------------------------------------------  

  constant C_DISTRIBUTED : integer := 0;
  constant C_SP_BLOCK    : integer := 1;
  constant C_DP_BLOCK    : integer := 2;

  constant NEW_LINE : string(1 to 1) := (1 => LF);  -- FOR ASSERTION REPORTS

  constant A_MAX_WIDTH : integer := 64;

  -- a_max_width is the only thing that needs to be modified in order to
  -- support wider input busses
  -- max number of partial products - add 2 as contingency for a_signed
  constant MAX_NUM_PPS : integer := (A_MAX_WIDTH+2)/4;


  function calc_reqd_b_value(b_value      : string;
                             b_width      : integer;
                             b_type       : integer;
                             reqd_b_width : integer) return string;

  function bitstorep_string(a_value : string;
                            a_type  : integer) return integer;--natural;

  function calc_shift_bits(b_value    : string;
                           b_constant : integer) return integer;

  function get_rom_addr_width(family : string; mem_type : integer) return integer;

  function calc_a_input_width(operand_width, has_a_signed, rom_addr_width, b_constant : integer) return integer;

  function calc_num_pps(a_width, rom_addr_width : integer) return integer;

  -- TYPE for storing information about symmetric adders
  type adder_info_type is record
    a_input         : integer;
    b_input         : integer;
    a_width         : integer;
    b_width         : integer;
    b_type          : integer;
    b_pipe_regs     : integer;
    scale_by        : integer;
    drop_lsbs       : integer;
    out_width       : integer;
    pipe_stages     : integer;          -- new in V9.0!
    row             : integer;          -- redundant
    col             : integer;          -- redundant
    height_limit    : integer;          -- redundant
    height          : integer;          -- redundant
    has_o           : boolean;          -- redundant
    has_q           : boolean;          -- redundant
    place_above_mem : boolean;          -- redundant
  end record;

  function calc_adder_level(adder_num, max_add_levels : integer) return integer;
  
  function calc_last_pp_input_width(operand_width, has_a_signed,
                                    rom_addr_width, b_constant : integer) return integer;

  function calc_pp_width(b_width      : integer;
                         b_type       : integer;
                         b_value      : string;
                         b_constant   : integer;
                         a_width      : integer;
                         a_type       : integer;
                         has_a_signed : integer;
                         last_pp      : boolean;
                         full_prod    : boolean) return integer;

  function calc_last_pp_adder(num_pps          : integer;
                              max_add_levels   : integer;
                              num_adders       : integer;
                              num_extra_adders : integer) return integer;

  function calc_last_rom_contents(b_width            : integer;
                                  a_width            : integer;
                                  a_type             : integer;
                                  b_type             : integer;
                                  has_a_signed       : integer;
                                  rom_addr_width     : integer;
                                  rom_depth          : integer;
                                  rom_width          : integer;
                                  start_bit          : integer;
                                  b_value            : string;
                                  b_constant         : integer;
                                  num_rom_bits       : integer;
                                  number_of_pps      : integer;
                                  a_signed_extension : boolean)  return bit_vector;

  function calc_rom_contents(b_width        : integer;
                             b_type         : integer;
                             rom_addr_width : integer;
                             rom_depth      : integer;
                             rom_width      : integer;
                             start_bit      : integer;
                             b_value        : string;
                             num_rom_bits   : integer) return bit_vector;

  function calc_rom_start_bit(b_width          : integer;
                              b_value          : string;
                              b_constant       : integer;
                              pp_width         : integer;
                              a_type           : integer;
                              rom_has_a_signed : integer;
                              mem_type         : integer;
                              mem_addr_width   : integer;
                              pipeline         : integer;
                              num_adders       : integer;
                              has_q            : integer;
                              last_mem         : boolean) return integer;

  function calc_num_extra_adders(num_pps, max_num_pps : integer) return integer;
  
  function get_mem_type(family          : string;
                        mem_type        : integer;
                        bram_addr_width : integer;
                        has_swapb       : integer;
                        a_width         : integer;
                        a_type          : integer;
                        has_a_signed    : integer;
                        b_constant      : integer;
                        has_o           : integer) return integer;

  function bitsneededtorepresent(a_value : integer) return integer;--(a_value : natural) return natural;
  
  function bitstorep_bv(a_value    : bit_vector;
                        a_type     : integer;
                        a_positive : boolean) return integer;--natural;

  function mult_gen_max_of(i0, i1 : integer) return integer;

  function multiply_bv(a, b : bit_vector; a_signed, b_signed : boolean) return bit_vector;

  function natural_to_bit_vector(in_val : in integer; length : in integer) return bit_vector; --(in_val : in natural; length : in natural) return bit_vector;

  function mult_gen_select_string(i0 : string; i1 : string; sel : boolean) return string;

  function select_val(i0 : integer; i1 : integer; sel : boolean) return integer;

  function select_val_int(i0 : integer; i1 : integer; sel : integer) return integer;

  function mult_gen_str_to_bv(bitsin : string; nbits : integer) return bit_vector;

  function mult_gen_bv_to_str(bitsin : bit_vector; nbits : integer) return string;
  
  function slv_to_str(bitsin : std_logic_vector; nbits : integer) return string;

  -----------------------------------------------------------------------------
  -- Functions, types, constants from ccm_mem_utils
  -----------------------------------------------------------------------------

  -- Cannot have a dist mem > 'deepest_dist_mem' - have to use block mem
  constant deepest_dist_mem : integer := 256;--natural := 256;

  constant c_automatic : integer := -1;

  function calc_depth(reqd_depth : integer; mem_type : integer) return integer;

  -----------------------------------------------------------------------------
  -- Functions to be translated by VTFC for use only in the GUI
  -----------------------------------------------------------------------------

  function calc_lut_mult_resources (c_a_width, c_b_width : integer) return integer;

  function calc_hybrid_emb_mults (family : string; op_width : WIDTH_REC) return integer;

  function calc_hybrid_luts (family : string; op_width : WIDTH_REC) return integer;
  
  function calc_emb_mults (family : string; op_width : WIDTH_REC) return integer;

  function calc_reqd_b_width (c_b_value : string; c_b_width, c_b_type : integer; reloadable : boolean) return integer;

  function mult_gen_v11_2_luts (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)    
    return integer;
  
  function mult_gen_v11_2_mults (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)    
    return integer;
  
  function mult_gen_v11_2_brams (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)    
    return integer;  
  
  function mult_gen_v11_2_gui_resources (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)
    return R_MULT_RESOURCES;

  function get_port_sizes (family : string) return PORT_ASPECTS;
  
end package mult_gen_pkg_v11_2;

package body mult_gen_pkg_v11_2 is

  -- purpose: validates the generics for the whole core, traps any bad combinations
  function check_generics(c_xdevicefamily                         : string;
                          a_width, a_type, b_width, b_type        : integer;
                          out_high, out_low                       : integer;
                          mult_type, opt_goal                     : integer;
                          has_ce, has_sclr, ce_overrides_sclr     : integer;
                          latency, ccm_imp                        : integer;
                          b_value                                 : string;
                          has_zero_detect, round_output, round_pt : integer)   return T_RESOLVED_GENERICS is
    variable r_generics       : T_RESOLVED_GENERICS;
  begin  -- FUNCTION check_generics

    -- Assign the incoming generics to the record elements
    -- We will update them as required when the checks are performed
    -- before the record is returned
    r_generics.R_A_WIDTH                      := a_width;
    r_generics.R_A_TYPE                       := a_type;
    r_generics.R_B_WIDTH                      := b_width;
    r_generics.R_B_TYPE                       := b_type;
    r_generics.R_OUT_HIGH                     := out_high;
    r_generics.R_OUT_LOW                      := out_low;
    r_generics.R_MULT_TYPE                    := mult_type;
    r_generics.R_OPT_GOAL                     := opt_goal;
    r_generics.R_HAS_CE                       := has_ce;
    r_generics.R_HAS_SCLR                     := has_sclr;
    r_generics.R_CE_OVERRIDES_SCLR            := ce_overrides_sclr;
    r_generics.R_LATENCY                      := latency;
    r_generics.R_CCM_IMP                      := ccm_imp;
    -- This syntax ensures that the string for the constant
    -- will be represented as (1 to N) throughout the core
    -- This is necessary for VTFC support
    r_generics.R_B_VALUE(1 to b_value'length) := b_value;
    r_generics.R_HAS_ZERO_DETECT              := has_zero_detect;
    r_generics.R_ROUND_OUTPUT                 := round_output;
    r_generics.R_ROUND_PT                     := round_pt;

    -- check that the A and B types are valid
    assert r_generics.R_A_TYPE = C_SIGNED or r_generics.R_A_TYPE = C_UNSIGNED report "ERROR: mult_gen: c_a_type should be 0 (signed) or 1 (unsigned)" severity failure;
    assert r_generics.R_B_TYPE = C_SIGNED or r_generics.R_B_TYPE = C_UNSIGNED report "ERROR: mult_gen: c_b_type should be 0 (signed) or 1 (unsigned)" severity failure;

    -- check that the port widths are valid, based on the operand types and the multiplier type
    assert r_generics.R_A_WIDTH+r_generics.R_A_TYPE >= 2 and r_generics.R_A_WIDTH < 65 report "ERROR: mult_gen: c_a_width must be in the range 2->64 for signed data and 1->64 for unsigned data" severity failure;
    assert r_generics.R_B_WIDTH+r_generics.R_B_TYPE >= 2 and r_generics.R_B_WIDTH < 65 report "ERROR: mult_gen: c_b_width must be in the range 2->64 for signed data and 1->64 for unsigned data" severity failure;
    
    -- check that MULT_TYPE is valid
    assert r_generics.R_MULT_TYPE = LUT or r_generics.R_MULT_TYPE = EMBEDDED_MULT or r_generics.R_MULT_TYPE = FIXED_CCM report "ERROR: mult_gen: c_mult_type must be 0, 1 or 2" severity failure;

    -- check that opt_goal is valid
    if r_generics.R_MULT_TYPE = EMBEDDED_MULT then
      if r_generics.R_OPT_GOAL /= EMB_MULT_RESOURCES and r_generics.R_OPT_GOAL /= CORE_SPEED then
        report "WARNING: mult_gen: c_optimize_goal must be 0 (optimize for embedded mult resources) or 1 (optimize for core speed).  Optimizing for speed..." severity warning;
        r_generics.R_OPT_GOAL := CORE_SPEED;
      end if;
    else
      -- don't care - generic doesn't apply to CCM or LUT mult
      null;
    end if;

    -- check has_ce, has_sclr, ce_overrides_sclr
    assert r_generics.R_HAS_CE = MG_NO or r_generics.R_HAS_CE = MG_YES report "ERROR: mult_gen: c_has_ce must be 0 or 1" severity failure;

    if r_generics.R_HAS_CE /= 0 and r_generics.R_LATENCY = 0 then
      report "WARNING: mult_gen: c_has_ce is set to 1, but no clock enable is required as the core latency is zero.  Setting c_has_ce to 0 internally" severity warning;
      r_generics.R_HAS_CE := 0;
    end if;

    assert r_generics.R_HAS_SCLR = MG_NO or r_generics.R_HAS_SCLR = MG_YES report "ERROR: mult_gen: c_has_sclr must be 0 or 1" severity failure;
    if r_generics.R_HAS_SCLR /= 0 and r_generics.R_LATENCY = 0 then
      report "WARNING: mult_gen: c_has_sclr is set to 1, but no synchronous clear is required as the core latency is zero.  Setting c_has_sclr to 0 internally" severity warning;
      r_generics.R_HAS_SCLR := 0;
    end if;

    if r_generics.R_HAS_SCLR = MG_YES and r_generics.R_HAS_ZERO_DETECT = MG_YES then
      report "ERROR: mult_gen: c_has_sclr must be set to 0 if c_has_zero_detect is to be used" severity failure;
    end if;
    
    assert r_generics.R_CE_OVERRIDES_SCLR = MG_NO or r_generics.R_CE_OVERRIDES_SCLR = MG_YES report "ERROR: mult_gen: c_ce_overrides_sclr must be 0 or 1" severity failure;

    -- check latency is valid, and account for auto-pipelining
    if r_generics.R_LATENCY = -1 then
      -- let the core decide on the optimum number of pipeline stages
      r_generics.R_LATENCY := mult_gen_v11_2_calc_fully_pipelined_latency(C_XDEVICEFAMILY, r_generics.R_A_WIDTH, r_generics.R_A_TYPE, r_generics.R_B_WIDTH, r_generics.R_B_TYPE, r_generics.R_MULT_TYPE, r_generics.R_OPT_GOAL, r_generics.R_CCM_IMP, r_generics.R_B_VALUE);
      assert not(debug) report "INFO: mult_gen: The core calculated that " & integer'image(r_generics.R_LATENCY) & " pipeline stages are required for this multiplier" severity note;
    else
      -- just check that the supplied latency value is in the supported range(s)
      assert (r_generics.R_LATENCY >= 0 and r_generics.R_LATENCY <= MAX_PIPE_STAGES) or r_generics.R_LATENCY >= PIPELINE_CFG_BREAKPT report "ERROR: mult_gen: C_LATENCY must be > 0 and < " & integer'image(MAX_PIPE_STAGES) & " (or >= " & integer'image(PIPELINE_CFG_BREAKPT) & " for bit pattern mode)" severity failure;
    end if;

    -- check ccm_imp is valid - depends on MULT_TYPE
    if r_generics.R_MULT_TYPE = FIXED_CCM then
      assert r_generics.R_CCM_IMP = DIST_MEM or r_generics.R_CCM_IMP = BRAM or r_generics.R_CCM_IMP = MULTS report "ERROR: mult_gen: c_ccm_imp must be 0, 1 or 2" severity failure;
    else
      -- we don't care - it's a parallel multiplier - set it to zero
      r_generics.R_CCM_IMP := 0;
      null;
    end if;

    -- check b_value is not a null string if it's a CCM
    if r_generics.R_MULT_TYPE = FIXED_CCM then
      assert r_generics.R_B_VALUE'length /= 0 report "ERROR: mult_gen: c_b_value string length is zero" severity failure;
    else
      -- we don't care, as b_value's not used
      r_generics.R_B_VALUE(1 to 64) := (others => 'Z');
      null;
    end if;

    if r_generics.R_MULT_TYPE = LUT or r_generics.R_MULT_TYPE = EMBEDDED_MULT then
      assert r_generics.R_HAS_ZERO_DETECT = MG_NO or r_generics.R_HAS_ZERO_DETECT = MG_YES report "ERROR: mult_gen: c_has_zero_detect must be 0 or 1" severity failure;
    else
      assert r_generics.R_HAS_ZERO_DETECT = MG_NO report "WARNING: mult_gen: Zero Detection is only supported for parallel multipliers" severity warning;
      r_generics.R_HAS_ZERO_DETECT := 0;
    end if;

    if r_generics.R_MULT_TYPE = EMBEDDED_MULT and (supports_dsp48(C_XDEVICEFAMILY) = 1 or supports_dsp48e(C_XDEVICEFAMILY) > 0) then
      assert r_generics.R_ROUND_OUTPUT = MG_NO or r_generics.R_ROUND_OUTPUT = MG_YES report "ERROR: mult_gen: c_round_output must be 0 or 1" severity failure;
      if supports_dsp48(C_XDEVICEFAMILY) = 1 and r_generics.R_ROUND_OUTPUT = MG_YES then
        assert r_generics.R_A_WIDTH+r_generics.R_A_TYPE <= 18 and r_generics.R_B_WIDTH+r_generics.R_B_TYPE <= 18 report "ERROR: mult_gen: Symmetric rounding is only supported for a single DSP48 in Virtex-4" severity failure;
      elsif supports_dsp48e(C_XDEVICEFAMILY) > 0 and r_generics.R_ROUND_OUTPUT = MG_YES then
        assert r_generics.R_A_WIDTH+r_generics.R_A_TYPE <= 25 and r_generics.R_B_WIDTH+r_generics.R_B_TYPE <= 18 report "ERROR: mult_gen: Symmetric rounding is only supported for a single DSP48E in Virtex-5" severity failure;
      end if;
    else
      -- don't allow rounding for other multipliers - expensive
      assert r_generics.R_ROUND_OUTPUT = MG_NO report "WARNING: mult_gen: Rounding is only supported for Virtex-4 and Virtex-5 DSP48(E)-based multipliers" severity warning;
      r_generics.R_ROUND_OUTPUT := 0;
    end if;

    return r_generics;
  end function check_generics;

  function sl_to_int(sl : std_logic) return integer is
  begin  -- FUNCTION sl_to_int
    if sl = '1' then
      return 1;
    else
      return 0;
    end if;
  end function sl_to_int;

  function mult_gen_log2(x : integer) return integer is
    variable y            : integer;
    variable two_to_the_y : integer;
  begin
    y            := 0;
    two_to_the_y := 1;

    while (two_to_the_y < x) loop
      y            := y+1;
      two_to_the_y := two_to_the_y * 2;
    end loop;

    return y;
  end mult_gen_log2;

  function mult_gen_log2d(x : integer) return integer is
    variable y            : integer;
    variable two_to_the_y : integer;
  begin
    y            := 0;
    two_to_the_y := 1;

    while (two_to_the_y < x) loop
      y            := y+1;
      two_to_the_y := two_to_the_y * 2;
    end loop;

    if two_to_the_y > x then
      y := y - 1;
    end if;

    return y;
  end mult_gen_log2d;

  -- purpose: figures out the number of PPs in each dimension of the multiplier array
  -- may require an extra PP for optimised DSP48E-based implementations
  function calc_dsp48_pps (family : string; op_width : WIDTH_REC) return R_DSP_PP is
    variable pps : R_DSP_PP := (a_pp => 0, b_pp => 0, extra_b_pp => 0);
  begin  -- function calc_pps
    if supports_dsp48e(family) = 0 then
      -- no asymmetric multiplier...
      pps.a_pp       := calc_a_pp(family, op_width);
      pps.b_pp       := calc_b_pp(op_width);
      pps.extra_b_pp := 0;
    else            
      -- scope for some optimisations to reduce DSP count
      pps.a_pp                       := calc_a_pp(family, op_width);
      if (op_width.a > 42 and op_width.a <= 59 and op_width.b > 52 and op_width.b <= 59)
        or (op_width.a > 25 and op_width.a <= 42 and op_width.b > 35 and op_width.b <= 42)
        or (op_width.a > 25 and op_width.a <= 42 and op_width.b > 52 and op_width.b <= 59) then
        -- can perform this multiply in only 10 DSPs, rather than 12.
        -- subtract one row from B, and one to the extra_b_pp element
        -- this should yield a_pp = 3, b_pp = 3, extra_b_pp = 1
        pps.b_pp := calc_b_pp(op_width) - 1;
        pps.extra_b_pp := 1;       
      else
        pps.b_pp       := calc_b_pp(op_width);
        pps.extra_b_pp := 0;      
      end if;
    end if;
    return pps;
  end function calc_dsp48_pps;

  function func_term_number(an : integer; bn : integer; s : integer) return integer is
    variable mn : integer;
  begin       
    mn := bn;
    if (an = bn) then
      return 2*mn+s-1;
    else
      return 2*mn+s;
    end if;
  end function func_term_number;

  function adder_layer_number_calc(width : integer) return integer is
    variable layer_counter : integer := 0;
    variable adder_counter : integer;
    variable input_counter : integer;
  begin
    input_counter := width;
    while input_counter > 1 loop
      layer_counter := layer_counter + 1;
      adder_counter := input_counter/3;
      if adder_counter = 0 and input_counter = 2 then  -- Final two-input counter
        adder_counter := 1;
        input_counter := 1;
      else
        input_counter := input_counter - adder_counter*3;  -- count the unused inputs
        input_counter := input_counter + adder_counter;  -- add the outputs from the adders
      end if;
--      report "ADDER TREE: Adder number is " & integer'image(adder_counter) &", output = "&integer'image(input_counter) &" in layer "& integer'image(layer_counter);
    end loop;
--    report "Layer number is " & integer'image(layer_counter) severity note;
    return layer_counter;
  end function adder_layer_number_calc;  
  
  function mult_gen_v11_2_calc_fully_pipelined_latency (family                                                         : string;
                                                        a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : integer;
                                                        b_value                                                        : string) return integer is
  begin
    return mult_gen_v11_2_calc_fully_pipelined_latency_internal(family, a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp, b_value, 1);
  end function mult_gen_v11_2_calc_fully_pipelined_latency;

  -- If 'standalone' is set to 1, the latency of a Spartan-6 multiplier will be
  -- 2 cycles.  If 'standalone' = 0, we assume that the adder will be used, so
  -- the latency will be 3 cycles
  function mult_gen_v11_2_calc_fully_pipelined_latency_internal (family                                                         : string;
                                                                 a_width, a_type, b_width, b_type, mult_type, opt_goal, ccm_imp : integer;
                                                                 b_value                                                        : string;
                                                                 standalone                                                     : integer := 1) return integer is
    -- General use variables
    variable latency                    : integer := 0;
    variable a_pp                       : integer := 0;
    variable b_pp                       : integer := 0;
    variable num_pp                     : integer := 0;
    variable dsp_pps                    : R_DSP_PP := (a_pp => 0, b_pp => 0, extra_b_pp => 0);
    variable op_width                   : WIDTH_REC;
    variable port_size                  : PORT_ASPECTS := get_port_sizes(family);
    -- variables for the CCM calculations
    variable rom_latency                : integer := 0;
    variable rom_addr_width             : integer := 0;
    variable a_input_width              : integer := 0;
    variable num_pps                    : integer := 0;
    variable const_power_of_two         : boolean := false;
    variable const_is_zero              : boolean := false;
    -- variables for the hybrid configurations
    variable widths                     : WIDTH_REC;
    variable block_mult_pipeline        : integer;
    variable block_mult_output_pipeline : integer;
    variable hybrid_cfg                 : integer;
    variable block_mult_cfg             : BLOCK_MULT_REC;
    variable one_mult_cfg               : ONE_MULT_REC;
    variable two_mult_cfg               : TWO_MULT_REC;
    variable top_mult_a_width           : integer := 0;
    variable top_mult_b_width           : integer := 0;
    variable side_mult_a_width          : integer := 0;
    variable side_mult_b_width          : integer := 0;
    variable deepest_lut_mult_tree      : integer := 0;
    variable deepest_pipeline           : integer := 0;
    variable adder_latency              : integer := 0;
    variable fab_prereg                 : integer := 0;
    variable Creg                       : integer := 0;
    -- variables for the embedded mult CCM
    variable reqd_b_value : string(1 to calc_reqd_b_width(b_value,b_width, b_type, false));
    variable trimmed_msbs               : integer := 0;
    variable trimmed_lsbs               : integer := 0;
    -- variables for LUT6 mult (area optimised)
    variable sign_correction : integer := 0;
    variable a_digit_number, b_digit_number : integer := 0;
  begin  -- FUNCTION mult_gen_v11_2_calc_fully_pipelined_latency_internal

    if mult_type = FIXED_CCM then
      -- check to see if the constant is exactly a (positive) power of 2
      -- use this to set up the latency of the fixed CCM later on
      trimmed_msbs       := get_trimmed_leading_bits(b_value, b_type, mult_type);
      trimmed_lsbs       := calc_shift_bits(b_value, 1);
      const_power_of_two := check_const_power_of_two(b_value, b_type, mult_type);
      -- b_width should represent the length of the b_value string - required
      -- for VTFC support, as 'length cannot be used
      const_is_zero      := check_b_value_all_zeros(b_value, b_width);
    end if;

    -- swap the operands around to get the best operand size for each PORT
    -- Any invalid families will be caught in this routine
    op_width := get_true_widths(family, a_width, b_width, a_type, b_type, port_size);

    case mult_type is
      when LUT =>

        if opt_goal = CORE_SPEED then
          if get_min(a_width, b_width) = 1 then
            latency := 1;
          else
            latency := mult_gen_log2(get_min(a_width, b_width));
          end if;
        else
          if a_type = 1 and b_type = 1 then
            -- unsigned
            sign_correction := 0;
          else
            sign_correction := 1;
          end if;
          a_digit_number := (mult_gen_max_of(a_width, b_width)+2)/3;
          b_digit_number := (get_min(a_width, b_width)+2)/3;
          latency        := adder_layer_number_calc(func_term_number(a_digit_number, b_digit_number, sign_correction)) + 1;
        end if;
        
      when EMBEDDED_MULT =>
        case opt_goal is
          when CORE_SPEED =>
            -- To account for possible extra DSP in V5 optimised cases
            dsp_pps := calc_dsp48_pps(family, op_width);
            num_pp := (dsp_pps.a_pp * dsp_pps.b_pp) + dsp_pps.extra_b_pp;
            
            a_pp := dsp_pps.a_pp;
            b_pp := dsp_pps.b_pp;

            if supports_dsp48(family) = 1 or supports_dsp48e(family) > 0 then
              -- latency is determined by # DSP48(E)s used - call a_pp and b_pp calculation functions
              latency := num_pp + 2;  -- A/Breg + Mreg in first DSP + Pregs in all DSPs above it in the column
            elsif supports_dsp48a(family) > 0 then
              -- There's no simple formula to work out what the latency will
              -- be based on the number of DSPs.  It depends how many wireshifts we need in
              -- the fabric (i.e. how many times the C port needs to be used)
              if a_pp = 1 and b_pp = 1 then
                if supports_dsp48a1(family) > 0 and standalone = 1 then
                  -- 2-cycle mult in Spartan-6
                  latency := 2;
                else
                  latency := 3;
                end if;
              elsif a_pp = 2 and b_pp = 1 then
                latency := 5;
              elsif a_pp = 3 and b_pp = 1 then
                latency := 7;
              elsif a_pp = 4 and b_pp = 1 then
                latency := 9;
              elsif a_pp = 2 and b_pp = 2 then
                latency := 8;
              elsif a_pp = 3 and b_pp = 2 then
                latency := 11;
              elsif a_pp = 3 and b_pp = 3 then
                latency := 15;
              elsif a_pp = 4 and b_pp = 2 then
                latency := 14;
              elsif a_pp = 4 and b_pp = 3 then
                latency := 19;
              elsif a_pp = 4 and b_pp = 4 then
                latency := 24;
              end if;
            elsif supports_mult18x18s(family) = 1 or supports_mult18x18sio(family) = 1 then
              -- latency is determined by depth of adder tree required, which is determined by the number of Mult18x18s required
              -- Add two for the register stage and fabric register in V2 and S3 multipliers, add 3 for the
              -- Mult18x18SIO in S3E - 2 for the multiplier and 1 for the post-output fabric
              latency := mult_gen_log2(num_pp) + 2 + (boolean'pos(supports_mult18x18sio(family) = 1));
            else
              report "ERROR: invalid family caught in EMB_MULT/CORE_SPEED in mult_gen_v11_2_calc_fully_pipelined_latency"
                severity failure;
            end if;
          when EMB_MULT_RESOURCES =>
            -- fully-pipelined latency depends on if the fabric portion or the
            -- embedded mult portion is deeper in terms of registers

            -- Account for operand swapping
            if a_width > b_width then
              widths.a        := a_width;
              widths.a_type   := a_type;
              widths.b        := b_width;
              widths.b_type   := b_type;
              op_width.a      := a_width;
              op_width.a_type := a_type;
              op_width.b      := b_width;
              op_width.b_type := b_type;
            else
              widths.a        := b_width;
              widths.a_type   := b_type;
              widths.b        := a_width;
              widths.b_type   := a_type;
              op_width.a      := b_width;
              op_width.a_type := b_type;
              op_width.b      := a_width;
              op_width.b_type := a_type;
            end if;

            assert not(debug) report "widths.a " & integer'image(widths.a)  severity note;
            assert not(debug) report "widths.a_type " & integer'image(widths.a_type)  severity note;
            assert not(debug) report "widths.b " & integer'image(widths.b)  severity note;
            assert not(debug) report "widths.b_type " & integer'image(widths.b_type)  severity note;                        
            
            if supports_dsp48(family) = 1 or supports_dsp48e(family) > 0 or supports_dsp48a(family) > 0 then

                -- New approach
                -- Consider paths to the adder in the DSP48x

                -- Areg/Breg + Mreg gives 2 cycles of latency
                block_mult_pipeline := 2;

                -- The pipeline after the DSP48x adder is defined by the number
                -- of DSPs used (number of registers in the P cascade)
                a_pp                       := hybrid_calc_a_pp(family, op_width);
                b_pp                       := hybrid_calc_b_pp(family, op_width);
                block_mult_output_pipeline := a_pp * b_pp;
                assert not(debug) report "a_pp " & integer'image(a_pp) severity note;
                assert not(debug) report "b_pp " & integer'image(b_pp) severity note;
                assert not(debug) report "block_mult_output_pipeline " & integer'image(block_mult_output_pipeline) severity note;                
                assert not(debug) report "block_mult_output_pipeline is " & integer'image(block_mult_output_pipeline) severity note;

                hybrid_cfg     := get_hybrid_configuration(family, a_pp, b_pp, widths, port_size);
                block_mult_cfg := get_block_mult_cfg (family, a_pp, b_pp, widths, hybrid_cfg, port_size);
                assert not(debug) report "hybrid_cfg is " & integer'image(hybrid_cfg) severity note;

                assert not(debug) report "block_mult_cfg.a_width " & integer'image(block_mult_cfg.a_width) severity note;
                assert not(debug) report "block_mult_cfg.a_type " & integer'image(block_mult_cfg.a_type) severity note;                
                assert not(debug) report "block_mult_cfg.b_width " & integer'image(block_mult_cfg.b_width) severity note;                
                assert not(debug) report "block_mult_cfg.b_type " & integer'image(block_mult_cfg.b_type) severity note;
                
                if hybrid_cfg = ONE_MULT then
                  one_mult_cfg := get_one_mult_cfg(widths,
                                                   block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type,
                                                   hybrid_cfg, port_size);
                  top_mult_a_width      := one_mult_cfg.a;
                  top_mult_b_width      := one_mult_cfg.b;
                  side_mult_a_width     := 0;
                  side_mult_b_width     := 0;
                  assert not(debug) report "top_mult_a_width = " & integer'image(top_mult_a_width) severity note;
                  assert not(debug) report "top_mult_b_width = " & integer'image(top_mult_b_width) severity note;
                  assert not(debug) report "side_mult_a_width = " & integer'image(side_mult_a_width) severity note;
                  assert not(debug) report "side_mult_b_width = " & integer'image(side_mult_b_width) severity note;                  
                  deepest_lut_mult_tree := fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width);
                elsif hybrid_cfg = TWO_MULT then
                  two_mult_cfg          := get_two_mult_cfg(widths, block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type, hybrid_cfg);
                  top_mult_a_width      := two_mult_cfg.a_top;
                  top_mult_b_width      := two_mult_cfg.b_top;
                  side_mult_a_width     := two_mult_cfg.a_side;
                  side_mult_b_width     := two_mult_cfg.b_side;
                  assert not(debug) report "top_mult_a_width = " & integer'image(top_mult_a_width) severity note;
                  assert not(debug) report "top_mult_b_width = " & integer'image(top_mult_b_width) severity note;
                  assert not(debug) report "side_mult_a_width = " & integer'image(side_mult_a_width) severity note;
                  assert not(debug) report "side_mult_b_width = " & integer'image(side_mult_b_width) severity note;
                  deepest_lut_mult_tree := mult_gen_max_of(fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width), fab_mult_full_pipe_lat(side_mult_a_width, side_mult_b_width));
                end if;

                if hybrid_cfg = BASE_MULT then
                  adder_latency := 0;
                  Creg          := 0;
                elsif hybrid_cfg = ONE_MULT then
                  adder_latency := 0;
                  Creg          := 1;
                elsif hybrid_cfg = TWO_MULT then
                  adder_latency := 1;
                  Creg          := 1;
                end if;

                assert not(debug) report "deepest_lut_mult_tree is " & integer'image(deepest_lut_mult_tree) severity note;

                -- Work out the deepest path to the adder in the LS DSP48
                deepest_pipeline := mult_gen_max_of(block_mult_pipeline, (deepest_lut_mult_tree + adder_latency + Creg));

                -- Don't actually need the pre-register for best performance...
                fab_prereg := 0;

                latency := fab_prereg + deepest_pipeline + block_mult_output_pipeline;
                
            elsif supports_mult18x18s(family) = 1 or supports_mult18x18sio(family) = 1 then
                -- calc number of emb mults
                -- calc_tree_latency via mult_gen_log2 routine
                -- if V2 or S3, add 2 to tree lat
                -- if S3E, add 3 to tree lat
                -- get configuration of hybrid
                -- get widths of lut mults
                -- get max depth of the lut mults, if they are required
                -- work out max depth from lut mults and the embedded mult
                -- add in any adder latency to this final value
                a_pp   := hybrid_calc_a_pp(family, op_width);
                b_pp   := hybrid_calc_b_pp(family, op_width);
                num_pp := a_pp * b_pp;
                -- work out the latency of the adder tree based on the number
                -- on embedded multipliers used, and then add the latency of
                -- the embedded multipliers themselves for best performance
                if supports_mult18x18s(family) = 1 then
                  block_mult_pipeline := mult_gen_log2(num_pp) + 2;
                elsif supports_mult18x18sio(family) = 1 then
                  block_mult_pipeline := mult_gen_log2(num_pp) + 3;
                end if;

                hybrid_cfg     := get_hybrid_configuration(family, a_pp, b_pp, widths, port_size);
                block_mult_cfg := get_block_mult_cfg (family, a_pp, b_pp, widths, hybrid_cfg, port_size);

                if hybrid_cfg = ONE_MULT then
                  one_mult_cfg := get_one_mult_cfg(widths,
                                                   block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type,
                                                   hybrid_cfg, port_size);
                  top_mult_a_width      := one_mult_cfg.a;
                  top_mult_b_width      := one_mult_cfg.b;
                  side_mult_a_width     := 0;
                  side_mult_b_width     := 0;
                  deepest_lut_mult_tree := fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width);
                elsif hybrid_cfg = TWO_MULT then
                  two_mult_cfg          := get_two_mult_cfg(widths, block_mult_cfg.a_width, block_mult_cfg.a_type, block_mult_cfg.b_width, block_mult_cfg.b_type, hybrid_cfg);
                  top_mult_a_width      := two_mult_cfg.a_top;
                  top_mult_b_width      := two_mult_cfg.b_top;
                  side_mult_a_width     := two_mult_cfg.a_side;
                  side_mult_b_width     := two_mult_cfg.b_side;
                  deepest_lut_mult_tree := mult_gen_max_of(fab_mult_full_pipe_lat(top_mult_a_width, top_mult_b_width), fab_mult_full_pipe_lat(side_mult_a_width, side_mult_b_width));
                end if;

                if hybrid_cfg = BASE_MULT then
                  adder_latency := 0;
                elsif hybrid_cfg = ONE_MULT then
                  adder_latency := 0;
                elsif hybrid_cfg = TWO_MULT then
                  adder_latency := 1;
                end if;

                deepest_pipeline := mult_gen_max_of(block_mult_pipeline, (deepest_lut_mult_tree + adder_latency));

                -- Add one cycle of latency for the register on the final adder
                -- which sums all the partial products together
                latency := deepest_pipeline + 1;
                
            else
                report "ERROR: invalid family caught in EMB_MULT/EMB_MULT_RESOURCES in mult_gen_v11_2_calc_fully_pipelined_latency"
                  severity failure;
            end if;
          when others => null;
        end case;
      when FIXED_CCM =>
        if const_power_of_two or const_is_zero then
          -- can perform the multiply just by bit-shifting - no logic required
          -- or just generate constant zeros at the output
          latency := 0;
        else
          case ccm_imp is

            when DIST_MEM =>
              rom_latency := 1;

              if supports_lut6(family) = 1 then
                rom_addr_width := 6;
              else
                rom_addr_width := 4;
              end if;

              a_input_width := calc_a_input_width(a_width, 0, rom_addr_width, 0);
              num_pps       := calc_num_pps(a_input_width, rom_addr_width);

              -- log2 function will return 0 if 0 is input, which works for this application          
              latency := mult_gen_log2((num_pps * boolean'pos(num_pps > 1))) + rom_latency;
              
            when BRAM =>
              if supports_ramb18(family) > 0 or supports_ramb16bwer(family) > 0 or supports_ramb16(family) = 1 then
                -- add 1 cycle for speed-up register
                rom_latency := 3;
              else
                rom_latency := 2;
              end if;
              
              -- Fixed width for all supported families (18K BRAM)
              rom_addr_width := 9;

              a_input_width := calc_a_input_width(a_width, 0, rom_addr_width, 0);
              num_pps       := calc_num_pps(a_input_width, rom_addr_width);

              -- log2 function will return 0 if 0 is input, which works for this application
              latency := mult_gen_log2((num_pps * boolean'pos(num_pps > 1))) + rom_latency;
             
            when MULTS =>
              reqd_b_value := calc_reqd_b_value(b_value, b_width, b_type, calc_reqd_b_width(b_value,b_width, b_type, false));
              -- modify op_width.b to reflect the number of bits from the
              -- constant value that actually need to go through the multiplier
              trimmed_lsbs := get_output_scaling(b_value, b_type, mult_type);
              trimmed_msbs := get_trimmed_leading_bits(b_value, b_type, mult_type);
              -- Completely reset the op_width record contents
              op_width := get_true_widths(family, a_width, (reqd_b_value'length - (trimmed_lsbs + trimmed_msbs)), a_type, b_type, port_size);
              
              -- calc_dsp48_pps will work for mult18x18-based families too!
              dsp_pps := calc_dsp48_pps(family, op_width);
              num_pp := (dsp_pps.a_pp * dsp_pps.b_pp) + dsp_pps.extra_b_pp;

              a_pp := dsp_pps.a_pp;
              b_pp := dsp_pps.b_pp;
              
              if supports_dsp48(family) = 1 or supports_dsp48e(family) > 0 then
                -- latency is determined by # DSP48(E)s used - call a_pp and b_pp calculation functions
                latency := num_pp + 2;  -- A/Breg + Mreg in first DSP + Pregs in all DSPs above it in the column
              elsif supports_dsp48a(family) > 0 then
                -- There's no simple formula to work out what the latency will
                -- be based on the number of DSPs.  It depends how many wireshifts we need in
                -- the fabric (i.e. how many times the C port needs to be used)
                if a_pp = 1 and b_pp = 1 then
                  if supports_dsp48a1(family) > 0 and standalone = 1 then
                    -- 2-cycle mult in Spartan-6
                    latency := 2;
                  else
                    latency := 3;
                  end if;
                elsif a_pp = 2 and b_pp = 1 then
                  latency := 5;
                elsif a_pp = 3 and b_pp = 1 then
                  latency := 7;
                elsif a_pp = 4 and b_pp = 1 then
                  latency := 9;
                elsif a_pp = 2 and b_pp = 2 then
                  latency := 8;
                elsif a_pp = 3 and b_pp = 2 then
                  latency := 11;
                elsif a_pp = 3 and b_pp = 3 then
                  latency := 15;
                elsif a_pp = 4 and b_pp = 2 then
                  latency := 14;
                elsif a_pp = 4 and b_pp = 3 then
                  latency := 19;
                elsif a_pp = 4 and b_pp = 4 then
                  latency := 24;
                end if;
              elsif supports_mult18x18s(family) = 1 or supports_mult18x18sio(family) = 1 then
                -- latency is determined by depth of adder tree required, which is determined by the number of Mult18x18s required
                -- Add one for the register stage in V2 and S3 multipliers, add 3 for the Mult18x18SIO in S3E - 2 for the multiplier and 1 for the post-output fabric
                latency := mult_gen_log2(num_pp) + 2 + (boolean'pos(supports_mult18x18sio(family) = 1));
              else
                report "ERROR: invalid family caught in FIXED_CCM/MULTS in mult_gen_v11_2_calc_fully_pipelined_latency"
                  severity failure;
              end if;
              
            when CSD =>

              report "WARNING: The core cannot calculate the fully-pipelined latency - check XST log (if available)" severity warning;
              latency := 0;
              
            when others =>
              report "ERROR: invalid c_ccm_imp caught in mult_gen_v11_2_calc_fully_pipelined_latency" severity failure;
              
          end case;
        end if;
      when others =>
        report "ERROR: invalid mult_type caught in mult_gen_v11_2_calc_fully_pipelined_latency" severity failure;
    end case;
    return latency;
  end function mult_gen_v11_2_calc_fully_pipelined_latency_internal;

  -- purpose: works out if the operands need to be swapped around and generates the correct widths for them
  -- these values can then be used to control the wire swapping in the hardware generation
  function get_true_widths(family                                   : string;
                           c_a_width, c_b_width, c_a_type, c_b_type : integer;
                           port_size                                : PORT_ASPECTS) return WIDTH_REC is
    variable ret            : WIDTH_REC := (a => 0, b => 0, a_type => 0, b_type => 0, swap => false);
    constant full_a_width   : integer   := c_a_width+c_a_type;
    constant full_b_width   : integer   := c_b_width+c_b_type;
    variable a_pp_1, a_pp_2 : integer   := 0;
    variable b_pp_1, b_pp_2 : integer   := 0;
    variable res_1, res_2   : integer   := 0;
    variable widths         : WIDTH_REC := (a => 0, b => 0, a_type => 0, b_type => 0, swap => false);
  begin  -- FUNCTION get_true_widths
    assert not(fn_debug) report "entered get_true_widths" severity note;
    if supports_dsp48(family) = 1 or supports_mult18x18s(family) = 1 or supports_mult18x18sio(family) = 1 or supports_dsp48a(family) > 0 then
      -- All the families with 18x18 multipliers, be they mult18s or DSP primitives
      if full_a_width >= full_b_width then
        -- no swapping required
        ret.swap := false;
        if c_a_type = C_SIGNED then
          ret.a := c_a_width;
        elsif c_a_type = C_UNSIGNED then
          ret.a := c_a_width+1;
        end if;
        if c_b_type = C_SIGNED then
          ret.b := c_b_width;
        elsif c_b_type = C_UNSIGNED then
          ret.b := c_b_width+1;
        end if;
        ret.a_type := c_a_type;
        ret.b_type := c_b_type;
      else
        -- need to swap the operands around
        ret.swap := true;
        if c_b_type = 0 then
          ret.a := c_b_width;
        elsif c_b_type = 1 then
          ret.a := c_b_width+1;
        end if;
        if c_a_type = C_SIGNED then
          ret.b := c_a_width;
        elsif c_a_type = C_UNSIGNED then
          ret.b := c_a_width+1;
        end if;
        ret.a_type := c_b_type;
        ret.b_type := c_a_type;
      end if;
    elsif supports_dsp48e(family) > 0 then
      -- Harder to work out when we need to swap the operands over here
      -- because of the asymmetric multiplier - more efficient for some widths not to swap the operands!

      -- Check to see if the operand sizes as they are supplied to the core
      -- fit one of the optimal array configurations - if not, we want to
      -- swap A and B over since that will fit one of the patterns
      -- i.e. 42x64 and 64x42 will both be implemented on an a_pp=2, b_pp=4
      -- array rather than using the (much larger) a_pp=4, b_pp=3 array

      -- don't swap operands over - the last argument doesn't matter here!
      widths := (a => c_a_width, b => c_b_width, a_type => c_a_type, b_type => c_b_type, swap => false);
      a_pp_1 := calc_a_pp(family, widths);
      b_pp_1 := calc_b_pp(widths);

      -- swap the operands over - the last argument doesn't matter here!
      widths := (a => c_b_width, b => c_a_width, a_type => c_b_type, b_type => c_a_type, swap => false);
      a_pp_2 := calc_a_pp(family, widths);
      b_pp_2 := calc_b_pp(widths);

      -- compare the two results - pick the smallest one!
      res_1 := a_pp_1 * b_pp_1;
      res_2 := a_pp_2 * b_pp_2;

      assert not(debug) report "res_1 (a_pp_1 * b_pp_1) is " & integer'image(res_1);
      assert not(debug) report "res_2 (a_pp_2 * b_pp_2) is " & integer'image(res_2);

      if res_1 <= res_2 then
        -- leave as is - don't swap the operands
        ret.swap := false;
        if c_a_type = C_SIGNED then
          ret.a := c_a_width;
        elsif c_a_type = C_UNSIGNED then
          ret.a := c_a_width+1;
        end if;
        if c_b_type = C_SIGNED then
          ret.b := c_b_width;
        elsif c_b_type = C_UNSIGNED then
          ret.b := c_b_width+1;
        end if;
        ret.a_type := c_a_type;
        ret.b_type := c_b_type;
      else
        -- operand sizes don't fit one of the optimal patterns,
        -- so swap them around so that they will fit one of the patterns
        ret.swap := true;
        assert not(debug) report "swapping operands internally" severity note;
        if c_b_type = 0 then
          ret.a := c_b_width;
        elsif c_b_type = 1 then
          ret.a := c_b_width+1;
        end if;
        if c_a_type = C_SIGNED then
          ret.b := c_a_width;
        elsif c_a_type = C_UNSIGNED then
          ret.b := c_a_width+1;
        end if;
        ret.a_type := c_b_type;
        ret.b_type := c_a_type;
      end if;
      
    else
      
      report "ERROR: mult_pkg.vhd: invalid family " & family & " caught in dsp.vhd/get_true_widths()"
        severity error;
    end if;
    -- if an operand is smaller than the port width for a DSP,
    -- round it up so it uses the full port width - this helps when the
    -- multiplier is to be inferred
    if ret.a < port_size.a then
      ret.a := port_size.a;
    end if;
    if ret.b < port_size.b then
      ret.b := port_size.b;
    end if;
    assert not(fn_debug) report "leaving get_true_widths" severity note;
    return ret;
  end function get_true_widths;

  -- purpose: works out how many partial products are required for the A operand (number of DSPs)
  function calc_a_pp(family : string; op_width : WIDTH_REC) return integer is
    variable a_pp                : integer := 0;
    constant width_minus_18      : integer := op_width.a - 18;
    constant width_minus_25      : integer := op_width.a - 25;
    constant width_gt_18         : boolean := (op_width.a > 18);
    constant width_gt_25         : boolean := (op_width.a > 25);
    constant arg1                : integer := (width_minus_18/17)*boolean'pos(width_gt_18);
    constant arg2                : integer := boolean'pos(width_minus_18 mod 17 /= 0 and width_gt_18);
    constant arg11               : integer := (width_minus_25/17)*boolean'pos(width_gt_25);
    constant arg21               : integer := boolean'pos(width_minus_25 mod 17 /= 0 and width_gt_25);
    constant supports_25bit_mult : boolean := (supports_dsp48e(family) > 0);
  begin  -- FUNCTION calc_a_pp
    assert not(fn_debug) report "entered calc_a_pp" severity note;
    assert not(debug) report "op_width.a is " & integer'image(op_width.a) severity note;
    if supports_25bit_mult then
      a_pp := 1 + arg11 + arg21;
    else
      a_pp := 1 + arg1 + arg2;
    end if;
    assert not(debug) report "a_pp count: " & integer'image(a_pp) severity note;
    assert not(fn_debug) report "leaving calc_a_pp" severity note;
    return a_pp;
  end function calc_a_pp;
  
  -- purpose: works out how many partial products are required for the B operand (number of DSPs)
  -- note that there is no family restriction here because DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier
  function calc_b_pp(op_width : WIDTH_REC) return integer is
    variable b_pp      : integer := 0;
    constant width_minus_18 : integer := op_width.b - 18;
    constant width_gt_18 : boolean := (op_width.b > 18);
    constant arg1 : integer := (width_minus_18/17)*boolean'pos(width_gt_18);
    constant arg2 : integer := boolean'pos(width_minus_18 mod 17 /= 0 and width_gt_18);
  begin  -- FUNCTION calc_b_pp
    assert not(fn_debug) report "entered calc_b_pp" severity note;
    assert not(debug) report "op_width.b is " & integer'image(op_width.b) severity note;
    b_pp := 1 + arg1 + arg2;
    assert not(debug) report "b_pp count: " & integer'image(b_pp) severity note;
    assert not(fn_debug) report "leaving calc_b_pp" severity note;    
    return b_pp;
  end function calc_b_pp;
  
  -- purpose: works out how many partial products are required for the A operand (number of DSPs/MULT18X18s)
  function hybrid_calc_a_pp(family : string; op_width : WIDTH_REC) return integer is
    variable a_pp        : integer := 0;
    constant port_size_a : integer := 18+(7*boolean'pos(supports_dsp48e(family) > 0));
    variable found_match : boolean := false;

    constant a : integer := op_width.a+op_width.a_type;
    constant b : integer := op_width.b+op_width.b_type;
    
  begin  -- FUNCTION hybrid_calc_a_pp

    if supports_dsp48e(family) > 0 then
      -- pick out the particular configurations that are supported

      -- widths will be swapped so that the largest is on the A operand
      -- perform the PP allocation in reverse order so that we don't need to trap as many cases
      
      if op_width.a+op_width.a_type >= 42 and op_width.b+op_width.b_type >= 35 then
        -- 2x2 configuration
        a_pp := 2;
        assert not(debug) report "DSP48E 2x2 configuration - a_pp" severity note;

      elsif op_width.a+op_width.a_type >= 35 then

        -- could implement a 2x1 or 1x2 array here - depends on the operand
        -- widths to get best logic utilisation

        if a >= 35 and a < 42 and b >= 25 then
          -- 1x2 - shorter carry chain
          a_pp := 1;
        elsif a >= 42 and b >= 25 then
          -- 2x1 - no choice
          a_pp := 2;
        elsif a >= 35 and a < 42 and b < 25 then
          -- 1x2
          a_pp := 1;
        elsif a >= 42 and b < 25 then
          a_pp := 2;
        elsif a >= 42 and b >= 25 then
          a_pp := 2;
        end if;
        
      elsif (op_width.a+op_width.a_type >= 25 and op_width.b+op_width.b_type >= 18)
        or (op_width.a+op_width.a_type                                      <= 25 and op_width.b+op_width.b_type >= 18)
        or (op_width.a+op_width.a_type >= 25 and op_width.b+op_width.b_type <= 18) then
        -- 1x1 CONFIGURATION
        a_pp                                                                := 1;
        assert not(debug) report "DSP48E 1x1 configuration - a_pp" severity note;
      elsif op_width.a+op_width.a_type <= 25 and op_width.b+op_width.b_type <= 18 then
        -- base mult - no fabric
        a_pp := 1;
        assert not(debug) report "DSP48E base mult configuration - a_pp" severity note;
      end if;
    else
      a_pp := calc_a_pp(family, op_width);
      if (op_width.a-(port_size_a)) mod 17 /= 0 and op_width.a > port_size_a then
        a_pp := a_pp-1;
      end if;
    end if;

    assert not(debug) report "hybrid a_pp count: " & integer'image(a_pp) severity note;

    return a_pp;
  end function hybrid_calc_a_pp;

  -- purpose: works out how many partial products are required for the B operand (number of DSPs/MULT18X18s)
  -- note that there is no family restriction here because MULT18X18, DSP48 and DSP48E
  -- both have 18-bit B ports on the multiplier
  function hybrid_calc_b_pp(family : string; op_width : WIDTH_REC) return integer is
    variable b_pp        : integer := 0;
    variable int_width   : integer := op_width.b;
    constant port_size_b : integer := 18;
    variable found_match : boolean := false;

    constant a : integer := op_width.a+op_width.a_type;
    constant b : integer := op_width.b+op_width.b_type;
    
  begin  -- FUNCTION hybrid_calc_b_pp

    if supports_dsp48e(family) > 0 then
  
        -- widths will be swapped so that the largest is on the A operand
        -- perform the PP allocation in reverse order so that we don't need to trap as many cases
        
        if op_width.a+op_width.a_type >= 42 and op_width.b+op_width.b_type >= 35 then
          -- 2x2 configuration
          b_pp := 2;
          assert not(debug) report "DSP48E 2x2 configuration - b_pp" severity note;

        elsif op_width.a+op_width.a_type >= 35 then

          -- could implement a 2x1 or 1x2 array here - depends on the operand
          -- widths to get best logic utilisation

          if a >= 35 and a < 42 and b >= 25 then
            -- 1x2 - shorter carry chain
            b_pp := 2;
          elsif a >= 42 and b >= 25 then
            -- 2x1 - no choice
            b_pp := 1;
          elsif a >= 35 and a < 42 and b < 25 then
            -- 1x2
            b_pp := 2;
          elsif a >= 42 and b < 25 then
            b_pp := 1;
          elsif a >= 42 and b >= 25 then
            b_pp := 1;
          end if;
          
        elsif (op_width.a+op_width.a_type >= 25 and op_width.b+op_width.b_type >= 18)
          or (op_width.a+op_width.a_type                                      <= 25 and op_width.b+op_width.b_type >= 18)
          or (op_width.a+op_width.a_type >= 25 and op_width.b+op_width.b_type <= 18) then
          -- 1x1 CONFIGURATION
          b_pp                                                                := 1;
          assert not(debug) report "DSP48E 1x1 configuration - b_pp" severity note;
        elsif op_width.a+op_width.a_type <= 25 and op_width.b+op_width.b_type <= 18 then
          -- base mult - no fabric
          b_pp := 1;
          assert not(debug) report "DSP48E base mult configuration - b_pp" severity note;
        end if;
    else
        b_pp := calc_b_pp(op_width);
        if (op_width.b-(port_size_b)) mod 17 /= 0 and op_width.b > port_size_b then
          b_pp := b_pp-1;
        end if;
    end if;

    assert not(debug) report "hybrid b_pp count: " & integer'image(b_pp) severity note;

    return b_pp;
  end function hybrid_calc_b_pp;

  -- purpose: works out which configuration of hybrid is required based on the input operand widths
  -- and types and the multiplier primitive being used
  function get_hybrid_configuration(family     : string;
                                    a_pp, b_pp : integer;
                                    op_width   : WIDTH_REC;
                                    port_size  : PORT_ASPECTS)return integer is
    variable full_a_width : integer := 0;
    variable full_b_width : integer := 0;
    variable ret          : integer := 99;  -- error code - should always be assigned later
    constant right_shift  : integer := 17;
  begin  -- FUNCTION get_hybrid_configuration

    full_a_width := op_width.a+op_width.a_type;
    full_b_width := op_width.b+op_width.b_type;

    assert not(debug) report "full_a_width is " & integer'image(full_a_width) severity note;
    assert not(debug) report "full_b_width is " & integer'image(full_b_width) severity note;

    if a_pp = 1 and b_pp = 1 then
      if full_a_width <= port_size.a and full_b_width <= port_size.b then
        ret := BASE_MULT;
        assert not(debug) report "1x1 base mult" severity note;
      elsif (full_a_width > port_size.a and full_b_width <= port_size.b) or (full_a_width <= port_size.a and full_b_width > port_size.b) then
        ret := ONE_MULT;
        assert not(debug) report "1x1 one fabric mult" severity note;
      elsif full_a_width > port_size.a and full_b_width > port_size.b then
        ret := TWO_MULT;
        assert not(debug) report "1x1 two fabric mults" severity note;
      end if;
    elsif (a_pp = 2 and b_pp = 1) then
      if full_a_width <= port_size.a+right_shift and full_b_width <= port_size.b then
        ret := BASE_MULT;
        assert not(debug) report "2x1 base mult" severity note;
      elsif (full_a_width > port_size.a+right_shift and full_b_width <= port_size.b) or (full_a_width <= port_size.a+right_shift and full_b_width >= port_size.b) then
        ret := ONE_MULT;
        assert not(debug) report "2x1 one fabric mult" severity note;
      elsif full_a_width > port_size.a+right_shift and full_b_width >= port_size.b then
        ret := TWO_MULT;
        assert not(debug) report "2x1 two fabric mults" severity note;
      end if;
    elsif a_pp = 1 and b_pp = 2 then
      if (full_b_width <= port_size.a and full_a_width <= port_size.b+right_shift) then
        ret := BASE_MULT;
        assert not(debug) report "1x2 base mult" severity note;
      elsif (full_b_width <= port_size.a and full_a_width >= port_size.b+right_shift) or (full_b_width >= port_size.a and full_a_width <= port_size.b+right_shift) then
        ret := ONE_MULT;
        assert not(debug) report "1x2 one fabric mult" severity note;
      elsif (full_b_width > port_size.a and full_a_width > port_size.b+right_shift) then
        ret := TWO_MULT;
        assert not(debug) report "1x2 two fabric mults" severity note;
      end if;
      
    elsif a_pp = 2 and b_pp = 2 then
      if full_a_width <= port_size.a+right_shift and full_b_width <= port_size.b+right_shift then
        ret := BASE_MULT;
        assert not(debug) report "2x2 base mult" severity note;
      elsif (full_a_width > port_size.a+right_shift and full_b_width <= port_size.b+right_shift) or (full_a_width <= port_size.a+right_shift and full_b_width > port_size.b+right_shift) then
        ret := ONE_MULT;
        assert not(debug) report "2x2 one fabric mult" severity note;
      elsif full_a_width > port_size.a+right_shift and full_b_width > port_size.b+right_shift then
        ret := TWO_MULT;
        assert not(debug) report "2x2 two fabric mults" severity note;
      end if;
    end if;

    assert not(debug) report "hybrid_configuration is " & integer'image(ret) severity note;

    assert ret /= 99 report "no valid configuration found" severity failure;

    return ret;
  end function get_hybrid_configuration;

  -- purpose: works out the operand widths and types for the block multiplier subcomponent
  function get_block_mult_cfg (family     : string;
                               a_pp, b_pp : integer;
                               op_width   : WIDTH_REC;
                               hybrid_cfg : integer;
                               port_size  : PORT_ASPECTS) return BLOCK_MULT_REC is
    variable ret         : BLOCK_MULT_REC;
    constant wire_shift  : integer := 17;
    variable mult_blocks : integer := 0;
    constant a_width     : integer := op_width.a;
    constant a_type      : integer := op_width.a_type;
    constant b_width     : integer := op_width.b;
    constant b_type      : integer := op_width.b_type;
    
    variable a_port_size : integer := 0;
    variable b_port_size : integer := 0;
    
  begin  -- FUNCTION get_block_mult_cfg
    
    if a_width < port_size.a then
      a_port_size := a_width;
    else
      a_port_size := port_size.a;
    end if;

    if b_width < port_size.b then
      b_port_size := b_width;
    else
      b_port_size := port_size.b;
    end if;

    if a_pp = 1 and b_pp = 1 then
      ret.a_width := a_port_size - boolean'pos(a_type = C_UNSIGNED and a_width >= port_size.a);
      ret.b_width := b_port_size - boolean'pos(b_type = C_UNSIGNED and b_width >= port_size.b);
      ret.a_type  := a_type;
      ret.b_type  := b_type;
      mult_blocks := 1;
    elsif a_pp = 2 and b_pp = 1 then
      ret.a_width := port_size.a+wire_shift - boolean'pos(a_type = C_UNSIGNED and a_width >= port_size.a);
      ret.b_width := b_port_size - boolean'pos(b_type = C_UNSIGNED and b_width >= port_size.b);
      ret.a_type  := a_type;
      ret.b_type  := b_type;
      mult_blocks := 2;
    elsif a_pp = 1 and b_pp = 2 then
      -- the operands will be swapped around so that the A operand is the largest
      -- this means that we need to swap the a_type and b_type values over so
      -- that they remain correct w.r.t. the operand widths

      ret.a_width := port_size.b+wire_shift - boolean'pos(a_type = C_UNSIGNED);
      ret.b_width := a_port_size - boolean'pos(b_type = C_UNSIGNED);
      ret.a_type  := a_type;
      ret.b_type  := b_type;

      mult_blocks := 2;
    elsif a_pp = 2 and b_pp = 2 then
      ret.a_width := port_size.a+wire_shift - boolean'pos(a_type = C_UNSIGNED);
      ret.b_width := port_size.b+wire_shift - boolean'pos(b_type = C_UNSIGNED);
      ret.a_type  := a_type;
      ret.b_type  := b_type;
      mult_blocks := 4;
    end if;

    assert not(debug) report "Building hybrid around a " & integer'image(ret.a_width) & "x" & integer'image(ret.b_width) & " multiplier using " & integer'image(mult_blocks) & " block multipliers" severity note;

    assert not(debug) report CR & "block_mult_cfg is: " &
      CR & "a_width: " & integer'image(ret.a_width) &
      CR & "b_width: " & integer'image(ret.b_width) &
      CR & "a_type: " & integer'image(ret.a_type) &
      CR & "b_type: " & integer'image(ret.b_type) & CR severity note;
    
    return ret;
  end function get_block_mult_cfg;

  -- purpose: works out the required operand widths of the fabric multiplier for the 'one mult' case
  function get_one_mult_cfg(width                                                    : WIDTH_REC;
                            block_a_width, block_a_type, block_b_width, block_b_type : integer;
                            hybrid_cfg                                               : integer;
                            port_size                                                : PORT_ASPECTS) return ONE_MULT_REC is
    constant x_width     : integer := block_a_width;
    constant y_width     : integer := block_b_width;
    variable ret         : ONE_MULT_REC;
    variable print_debug : boolean := false;
  begin  -- FUNCTION get_one_mult_cfg

    -- set defaults to avoid MTI disappearing...
    ret.a         := 0;
    ret.b         := 0;
    ret.a_type    := 0;
    ret.b_type    := 0;
    ret.out_width := 0;
    ret.bypass    := 0;
    ret.a_offset  := 0;
    ret.b_offset  := 0;

    assert not(debug) report "-------------------------------------------------------"
      & CR & "get_one_mult_cfg width.a: " & integer'image(width.a) &
      CR & "get_one_mult_cfg width.a_type: " & integer'image(width.a_type) &
      CR & "get_one_mult_cfg width.b: " & integer'image(width.b) &
      CR & "get_one_mult_cfg width.b_type: " & integer'image(width.b_type) &

      CR & "get_one_mult_cfg hybrid_cfg " & integer'image(hybrid_cfg) &
      CR & "get_one_mult_cfg x_width " &integer'image(x_width) &
      CR & "get_one_mult_cfg y_width " & integer'image(y_width) &
      CR & "-------------------------------------------------------" severity note;

    if (width.a > x_width and (width.b <= y_width or y_width < port_size.b)) and hybrid_cfg = ONE_MULT then

      assert not(debug) report "a_width > x_width and b_width <= y_width" severity note;
      ret.a        := width.a-x_width;
      ret.b        := width.b;
      ret.a_type   := C_UNSIGNED;
      ret.b_type   := width.b_type;
      ret.bypass   := ret.a;
      ret.b_offset := 0;
      ret.a_offset := ret.a;
      print_debug  := true;
    end if;

    -- this one doesn't work - do we even need this clause since the operands
    -- are always swapped to make A the largest?  What about the 1x2 V5 case?
    if (width.a <= x_width and (width.b > y_width or y_width < port_size.b)) and hybrid_cfg = ONE_MULT then
      assert not(debug) report "a_width <= x_width and b_width > y_width" severity note;
      ret.a        := width.a;
      ret.b        := width.b-y_width;
      ret.a_type   := width.a_type;
      ret.b_type   := C_UNSIGNED;
      ret.bypass   := ret.b;
      ret.b_offset := ret.b;
      ret.a_offset := 0;
      print_debug  := true;
    end if;

    ret.out_width := ret.a+ret.b;

    assert not(debug) report CR & "one_mult_cfg is: " &
      CR & "a: " & integer'image(ret.a) &
      CR & "b: " & integer'image(ret.b) &
      CR & "a_type: " & integer'image(ret.a_type) &
      CR & "b_type: " & integer'image(ret.b_type) &
      CR & "bypass: " & integer'image(ret.bypass) &
      CR & "a_offset: " & integer'image(ret.a_offset) &
      CR & "b_offset: " & integer'image(ret.b_offset) & CR severity note;
    
    return ret;
    
  end function get_one_mult_cfg;

  -- purpose: works out the required operand widths of the fabric multiplier for the 'two mult' case
  function get_two_mult_cfg(op_width                         : WIDTH_REC;
                            a_width, a_type, b_width, b_type : integer;
                            hybrid_cfg                       : integer) return TWO_MULT_REC is
    constant x_width     : integer := a_width;
    constant y_width     : integer := b_width;
    variable ret         : TWO_MULT_REC;
    variable print_debug : boolean := false;

    constant full_width_a : integer := op_width.a;  --+op_width.a_type;
    constant full_width_b : integer := op_width.b;  --+op_width.b_type;
    
  begin  -- FUNCTION get_two_mult_cfg

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

    assert not(debug) report "get_two_mult_cfg x_width is " & integer'image(x_width) severity note;
    assert not(debug) report "get_two_mult_cfg y_width is " & integer'image(y_width) severity note;
    assert not(debug) report "get_two_mult_cfg full_width_a is " & integer'image(full_width_a) severity note;
    assert not(debug) report "get_two_mult_cfg full_width_b is " & integer'image(full_width_b) severity note;

    if (full_width_a >= x_width and full_width_b >= y_width) and hybrid_cfg = TWO_MULT then  -- condition for this configuration to be valid

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
      print_debug        := true;

    elsif (full_width_b >= x_width and full_width_a >= y_width) and hybrid_cfg = TWO_MULT then

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
      print_debug        := true;
      
    end if;

    assert not(debug) report CR & "two_mult_cfg is: " &
      CR & "a_top: " & integer'image(ret.a_top) &
      CR & "b_top: " & integer'image(ret.b_top) &
      CR & "a_type_top: " & integer'image(ret.a_type_top) &
      CR & "b_type_top: " & integer'image(ret.b_type_top) &
      CR & "out_width_top: " & integer'image(ret.out_width_top) &
      CR & "a_side: " & integer'image(ret.a_side) &
      CR & "b_side: " & integer'image(ret.b_side) &
      CR & "a_type_side: " & integer'image(ret.a_type_side) &
      CR & "b_type_side: " & integer'image(ret.b_type_side) &
      CR & "out_width_side: " & integer'image(ret.out_width_side) &
      CR & "mult_bypass: " & integer'image(ret.mult_bypass) &
      CR & "add_bypass: " & integer'image(ret.add_bypass) &
      CR & "a_offset: " & integer'image(ret.a_offset) &
      CR & "b_offset: " & integer'image(ret.b_offset) & CR severity note;
    
    return ret;
    
  end function get_two_mult_cfg;

  -- purpose: works out the fully-pipelined latency of a LUT multiplier
  function fab_mult_full_pipe_lat(a_width, b_width : integer) return integer is
    variable b : integer := 0;
  begin  -- FUNCTION fab_mult_full_pipe_lat
    b := get_min(a_width, b_width);
    if b = 1 then
      -- Need to trap this, otherwise a 35x1 multiplier would have a
      -- fully-pipelined latency of zero!
      return 1;
    else
      return mult_gen_log2(b);
    end if;
  end function fab_mult_full_pipe_lat;

  -- purpose: works out how many pipeline stages a particular configuration of DSP blocks needs
  function get_emb_mult_max_pipe_stages (family : string; a_pp, b_pp : integer) return integer is
    variable ret : integer := 0;
  begin  -- FUNCTION get_DSP_max_pipe_stages
    if supports_dsp48(family) = 1 or supports_dsp48e(family) > 0 then
      if a_pp = 1 and b_pp = 1 then
        ret := 3;
      elsif a_pp = 2 and b_pp = 1 then
        ret := 4;
      elsif a_pp = 1 and b_pp = 2 then
        ret := 4;
      elsif a_pp = 2 and b_pp = 2 then
        ret := 6;
      else
        ret := 99;                      -- unsupported configuration
        report "ERROR: caught unsupported hybrid configuration in get_DSP_max_pipe_stages in mult_pkg"
          severity failure;
      end if;
    elsif supports_dsp48a(family) > 0 then
      -- There's no simple formula to work out what the latency will
      -- be based on the number of DSPs.  It depends how many wireshifts we need in
      -- the fabric (i.e. how many times the C port needs to be used)
      if a_pp = 1 and b_pp = 1 then
        ret := 3;
      elsif a_pp = 2 and b_pp = 1 then
        ret := 5;
      elsif a_pp = 2 and b_pp = 2 then
        ret := 8;
      else
        ret := 99;                      -- unsupported configuration
        report "ERROR: caught unsupported hybrid configuration in get_DSP_max_pipe_stages in mult_pkg"
          severity failure;
      end if;
    elsif supports_mult18x18s(family) = 1 or supports_mult18x18sio(family) = 1 then
      -- number of pipeline stages dictated by number of partial products
      -- which determines the depth of the adder tree + registers in and
      -- after the multiplier block
      ret := mult_gen_log2(a_pp * b_pp) + 2;
      if supports_mult18x18sio(family) = 1 then
        -- add another register for after the multiplier blocks
        ret := ret + 1;
      end if;
    else
      report "ERROR: caught invalid family in get_emb_mult_max_pipe_stages"
        severity failure;
    end if;
    return ret;
  end function get_emb_mult_max_pipe_stages;

  -- purpose: works out the depth of the adder tree on the LUT multiplier(s)
  -- to see what the maximum fully-pipelined latency will be
  function get_LUT_max_pipe_stages (one_mult_cfg : ONE_MULT_REC; two_mult_cfg : TWO_MULT_REC; hybrid_configuration : integer) return integer is
    variable true_b_width_side : integer := 0;
    variable true_b_width_top  : integer := 0;
    variable ret               : integer := 0;
  begin  -- FUNCTION get_LUT_max_pipe_stages
    if hybrid_configuration = 0 then
      ret := 0;
    elsif hybrid_configuration = 1 then
      -- only one fabric multiplier - use one_mult_cfg
      ret := fab_mult_full_pipe_lat(one_mult_cfg.a, one_mult_cfg.b);
    elsif hybrid_configuration = 2 then
      -- two fabric multipliers - work out which is the largest aka deepest
      true_b_width_top  := get_min(two_mult_cfg.a_top, two_mult_cfg.b_top);
      true_b_width_side := get_min(two_mult_cfg.a_side, two_mult_cfg.b_side);
      if true_b_width_top > true_b_width_side then
        ret := mult_gen_log2(true_b_width_top);
      else
        ret := mult_gen_log2(true_b_width_side);
      end if;
    else
      report "ERROR: invalid hybrid configuration value caught in get_LUT_max_pipe_stages in mult_pkg"
        severity failure;
      ret := 99;
    end if;
    return ret;
  end function get_LUT_max_pipe_stages;

  -- purpose: counts the number of LSB zeros in the supplied constant STRING
  -- If the bits are zero, we don't need to pass these bits into the multiplier
  -- and we can just right-shift the output by these number of bits 
  function get_output_scaling (b_value : string; b_type : integer; mult_type : integer)return integer is
    variable shift    : integer                       := 0;
    variable can_trim : boolean                       := true;
    variable all_ones : string(1 to b_value'length-1);
  begin  -- FUNCTION get_output_scaling   

    -- VTFC doesn't support (others => '1') assignment to a string
    -- so we have to initialise the variable this way instead
    for i in 1 to all_ones'length loop
      all_ones(i) := '1';
    end loop;  -- i

    if mult_type = FIXED_CCM then
      -- first check if the constant is a negative power of 2
      -- if it is, we can't trim the LS zeros

      -- Assume that the input string will always be (1 to N) ranged
      -- for support by VTFC
      if b_value(b_value'high) = '0' and b_value(b_value'low to b_value'high-1) = all_ones then
        can_trim := false;
      end if;

      if can_trim then
        -- start at the LSB and work our way left gaining bit significance
        for i in b_value'high downto b_value'low loop
          if b_value(i) = '1' then
            exit;
          else
            shift := shift + 1;
          end if;
        end loop;  -- i      
      end if;

-- OLD CODE - COVERS ALL POSSIBLE STRING ORIENTATIONS
--      if b_value'ascending then
--        if b_value(b_value'right) = '0' and b_value(b_value'left to b_value'right-1) = all_ones then
--          can_trim := false;
--        end if;
--      else
--        if b_value(b_value'right) = '0' and b_value(b_value'left downto b_value'right+1) = all_ones then
--          can_trim := false;
--        end if;
--      end if;

--      if can_trim then
--        -- start at the LSB and work our way left gaining bit significance
--        -- Account for the strings being TO or DOWNTO
--        if b_value'ascending then
--          for i in b_value'right downto b_value'left loop
--            if b_value(i) = '1' then
--              exit;
--            else
--              shift := shift + 1;
--            end if;
--          end loop;  -- i      
--        else                            -- b_value'descending
--          for i in b_value'right to b_value'left loop
--            if b_value(i) = '1' then
--              exit;
--            else
--              shift := shift + 1;
--            end if;
--          end loop;  -- i        
--        end if;
--      end if;

      assert not(debug) report "shift value is " & integer'image(shift) severity note;
    end if;

    return shift;
  end function get_output_scaling;

  -- purpose: checks to see if the constant has any zeros at the MSB (left) side of the string and
  -- returns an integer to say how many consecutive zeros there are
  -- These zeros don't need to go through the multiplier, so we could save some
  -- logic in a few cases
  -- If the constant is of signed type, we need to keep one of the leading zeros
  -- If the constant is signed though, we can also check for leading ones and
  -- trim them, stopping when we find "10" when searching from the left-hand side
  function get_trimmed_leading_bits (b_value : string; b_type : integer; mult_type : integer) return integer is
    variable zeros_to_trim : integer := 0;
    variable ones_to_trim  : integer := 0;
    variable bits_to_trim  : integer := 0;
  begin  -- FUNCTION get_trimmed_leading_bits

    -- To make this function compatible with VTFC (for the GUI), we need to do
    -- away with the 'ascending, 'left, 'right attributes and use only 'length,
    -- 'low and 'high.  This is based on the assumption that only strings with
    -- (1 to N) ranges will be passed into this function

    if mult_type = FIXED_CCM then
      
      for i in b_value'low to b_value'high loop
        if b_value(i) = '1' then
          exit;
        else
          zeros_to_trim := zeros_to_trim + 1;
        end if;
      end loop;  -- i


      -- New loop for V10.0 that avoids the array indexing error for -1
      if b_type = C_SIGNED and zeros_to_trim = 0 then
        for i in b_value'low to b_value'high loop
          if b_value(i) = '1' then
            if i+1 <= b_value'high then
              if b_value(i+1) = '0' then
                exit;
              end if;
            else
              null;
            end if;
          else
            ones_to_trim := ones_to_trim + 1;
          end if;
        end loop;  -- i

      end if;

-- OLD CODE - COVERS THE ASCENDING AND DESCENDING STRING CASES
-- BUT DOESN'T SUPPORT VTFC
--    if mult_type = FIXED_CCM then
--      -- Account for the strings being TO or DOWNTO
--      if b_value'ascending then
--        for i in b_value'left to b_value'right loop
--          if b_value(i) = '1' then
--            exit;
--          else
--            zeros_to_trim := zeros_to_trim + 1;
--          end if;
--        end loop;  -- i
--      else                              -- b_value'descending
--        for i in b_value'left downto b_value'right loop
--          if b_value(i) = '1' then
--            exit;
--          else
--            zeros_to_trim := zeros_to_trim + 1;
--          end if;
--        end loop;  -- i
--      end if;

--      -- New loop for V10.0 that avoids the array indexing error for -1
--      if b_type = C_SIGNED and zeros_to_trim = 0 then
--        -- Account for the strings being TO or DOWNTO
--        if b_value'ascending then
--          for i in b_value'left to b_value'right loop
--            if b_value(i) = '1' then
--              if i+1 <= b_value'right then
--                if b_value(i+1) = '0' then
--                  exit;
--                end if;
--              else
--                null;
--              end if;
--            else
--              ones_to_trim := ones_to_trim + 1;
--            end if;
--          end loop;  -- i
--        else                            -- b_value'descending
--          for i in b_value'left downto b_value'right loop
--            if b_value(i) = '1' then
--              if i-1 >= b_value'right then
--                if b_value(i-1) = '0' then
--                  exit;
--                end if;
--              else
--                null;
--              end if;
--            else
--              ones_to_trim := ones_to_trim + 1;
--            end if;
--          end loop;  -- i
--        end if;
--      end if;

      -- need to keep the MSB zero in the signed case to allow for correct
      -- operand extension in the subcores
      if b_type = C_SIGNED and zeros_to_trim > 0 then
        zeros_to_trim := zeros_to_trim - 1;
      end if;

      bits_to_trim := ones_to_trim + zeros_to_trim;  -- only one of these will be non-zero      
      assert not(debug) report "trimming " & integer'image(bits_to_trim) & " leading ones or zeros" severity note;
    end if;

    return bits_to_trim;
  end function get_trimmed_leading_bits;

  -- purpose: checks if the constant is all-zeros, in which case there is no point in creating logic!
  function check_b_value_all_zeros (b_value : string; b_value_length : integer) return boolean is
    variable ret : boolean := false;
  begin  -- FUNCTION check_b_value_all_zeros
    for i in 1 to b_value_length loop
      if b_value(i) = '1' then
        ret := false;
        exit;
      end if;
      ret := true;
    end loop;  -- i
    assert ret = false report "b_value constant is exactly zero - no logic will be created" severity warning;
    return ret;
  end function check_b_value_all_zeros;

  function check_const_power_of_two (b_value : string; b_type, mult_type : integer) return boolean is
    variable trimmed_msbs : integer := get_trimmed_leading_bits(b_value, b_type, mult_type);
    variable trimmed_lsbs : integer := calc_shift_bits(b_value, boolean'pos(mult_type = FIXED_CCM));
    variable ret          : boolean := false;
  begin
    -- Assume that the input string has a range of (1 to N) for VTFC support
    if b_value(b_value'low) = '1' and b_type = C_SIGNED then
      -- signed constant - can't represent by shifting alone
      ret := false;
    else
      ret := (b_value'length - (trimmed_lsbs + trimmed_msbs) = 1);
    end if;
    
-- OLD CODE - COVERS ALL POSSIBLE STRINGS
--    if b_value'ascending then
--      if b_value(b_value'low) = '1' and b_type = C_SIGNED then
--        -- signed constant - can't represent by shifting alone
--        ret := false;
--      else
--        ret := (b_value'length - (trimmed_lsbs + trimmed_msbs) = 1);
--      end if;
--    else                                -- b_value'descending
--      if b_value(b_value'high) = '1' and b_type = C_SIGNED then
--        -- signed constant - can't represent by shifting alone
--        ret := false;
--      else
--        ret := (b_value'length - (trimmed_lsbs + trimmed_msbs) = 1);
--      end if;
--    end if;
    
    return ret;
  end function check_const_power_of_two;
  
-------------------------------------------------------------------------------
-- Functions imported from ccm_pkg.vhd
-------------------------------------------------------------------------------  

  function calc_reqd_b_value(b_value      : string;
                             b_width      : integer;
                             b_type       : integer;
                             reqd_b_width : integer) return string is
    constant b_lsb        : integer := b_value'high;
    variable b_bit        : integer;
    variable reqd_b_value : string(1 to reqd_b_width);
  begin

    for bit in 1 to reqd_b_width loop
      b_bit := bit + b_lsb - reqd_b_width;
      if b_bit > 0 then
        reqd_b_value(bit) := b_value(b_bit);
      else
        if b_type = C_SIGNED then
          reqd_b_value(bit) := b_value(1);
        else
          reqd_b_value(bit) := '0';
        end if;  -- b_type
      end if;  -- b_bit
    end loop;

    assert not(ccm_debug) report "calc_reqd_b_value returning " & reqd_b_value severity note;
    
    return reqd_b_value;

    
  end calc_reqd_b_value;

  function bitstorep_string(a_value : string;
                            a_type  : integer) return integer is
    variable return_value : integer;
  begin
    return_value := a_value'length;

    if a_type = C_UNSIGNED then

      -- a_value represents an unsigned number
      --    FOR i IN a_value'RANGE LOOP -- Doesn't work with XCC
      for i in a_value'low to a_value'high loop
        if a_value(i) = '1' then
          exit;                         -- EXIT when the msb is found
        elsif a_value(i) = '0' then
          return_value := return_value - 1;
        else
          null;
        end if;
      end loop;
      
    else

      -- a_value represents a signed number
      -- Look for ms '1' followed by a '0'
      -- FOR i IN a_value'RANGE LOOP -- Doesn't work with XCC
      for i in a_value'low to a_value'high loop
        if a_value(i) = '1' then
          
          if i < a_value'high then
            if a_value(i+1) = '0' then
              exit;                     -- EXIT when the msb is found
            else
              return_value := return_value - 1;
            end if;
          else
            exit;                       -- EXIT when end of STRING reached
          end if;
          
        elsif a_value(i) = '0' then
          return_value := return_value - 1;
        else
          null;
        end if;
      end loop;
      
    end if;

    if return_value <= 0 then
      return 1;
    else
      return return_value;
    end if;

  end bitstorep_string;

  function calc_shift_bits(b_value    : string;
                           b_constant : integer) return integer is
    variable bit        : integer;
    variable shift_bits : integer;
  begin
    shift_bits := 0;

    assert not(ccm_debug) report "calc_shift_bits params: " & b_value & " " & integer'image(b_constant) severity note;
    
    if b_constant /= 0 then
      bit := b_value'high;

      while (bit >= b_value'low) loop
        if b_value(bit) = '0' then
          shift_bits := shift_bits + 1;
        else
          exit;
        end if;
        bit := bit - 1;
      end loop;
      
    end if;

    if shift_bits >= b_value'high then
      shift_bits := 0;                  -- All zeroes value
    end if;

    assert not(ccm_debug) report "calc_shift_bits returning " & integer'image(shift_bits) severity note;
    return shift_bits;
    
  end calc_shift_bits;

  function get_rom_addr_width(family : string; mem_type : integer) return integer is
  begin
    if mem_type = C_DISTRIBUTED then
      if supports_lut6(family) = 1 then
        assert not(debug) report "distributed ram address width is 6 - 64x1 RAM (LUT6)" severity note;
        return 6;
      else
        assert not(debug) report "distributed ram address width is 4 - 16x1 RAM (LUT4)" severity note;
        return 4;
      end if;
    else
      -- use a 9-bit address width
      -- use the 18K BRAM for V5 as well
      return 9;
    end if;
  end get_rom_addr_width;

  function calc_a_input_width(operand_width, has_a_signed, rom_addr_width, b_constant : integer) return integer is
    variable effective_op_width : integer;
  begin
    if has_a_signed = 0 or b_constant = 0 then
      effective_op_width := operand_width;
    else
      -- Allow extra input for 'a_signed'
      effective_op_width := operand_width + 1;
    end if;


    if (effective_op_width mod rom_addr_width = 0) then
      return effective_op_width;
    else
      return effective_op_width + rom_addr_width - (effective_op_width mod rom_addr_width);
    end if;
  end calc_a_input_width;

  function calc_num_pps(a_width, rom_addr_width : integer) return integer is
  begin
    if (a_width mod rom_addr_width /= 0) then
      return (a_width / rom_addr_width) + 1;
    else
      return (a_width / rom_addr_width);
    end if;
  end calc_num_pps;

  ------------------------------------------------------------------------------
  -- Returns the number of input bits required by the last partial product ROM.
  -- Does not include a_signed bit.
  ------------------------------------------------------------------------------
  function calc_last_pp_input_width(operand_width, has_a_signed,
                                    rom_addr_width, b_constant : integer) return integer is
  begin
    if (operand_width mod rom_addr_width /= 0) then
      return operand_width mod rom_addr_width;
    else
      -- There is an extra pp in this case due to the msb and 'a_signed' having
      -- to have a separate LUT
      if has_a_signed /= 0 and b_constant /= 0 then
        return 1;
      else
        return rom_addr_width;
      end if;
    end if;
  end calc_last_pp_input_width;


  ------------------------------------------------------------------------------
  -- Calculate amount to delay signal which drives addsub add input.
  ------------------------------------------------------------------------------
  function calc_add_lastpp_delay(reg_a_b_inputs  : integer;
                                 pipeline        : integer;
                                 num_pipe_stages : integer) return integer is
    variable delay : integer;
  begin
    if reg_a_b_inputs = 0 then
      delay := 0;
    else
      delay := 1;
    end if;

    if pipeline /= 0 then
      delay := num_pipe_stages + 1;     -- Add 1 for RAM output register
    end if;

    return delay;
  end calc_add_lastpp_delay;

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
  function calc_rom_start_bit(b_width          : integer;
                              b_value          : string;
                              b_constant       : integer;
                              pp_width         : integer;
                              a_type           : integer;
                              rom_has_a_signed : integer;
                              mem_type         : integer;
                              mem_addr_width   : integer;
                              pipeline         : integer;
                              num_adders       : integer;
                              has_q            : integer;
                              last_mem         : boolean) return integer is

    variable b_bit     : integer;
    variable start_bit : integer;
  begin
    start_bit := 0;
    b_bit     := b_value'high;          -- STRINGs go from 1 to N (lsb = N)

    if b_bit > 1 and b_constant /= 0 and mem_type = C_DISTRIBUTED and rom_has_a_signed = 0
      and ((num_adders > 0 and pipeline = 0) or (num_adders = 0 and has_q = 0)) then

      if b_value(b_bit) = '1' then
        start_bit := 1;

        while start_bit < pp_width loop

          -- Increment start_bit if 1st bit = '1' and next ms bit = '0'
          if b_bit > b_value'low then
            
            b_bit := b_bit - 1;
            if b_value(b_bit) = '0' then
              start_bit := start_bit + 1;
            else
              exit;
            end if;
            
          else
            start_bit := start_bit + 1;
          end if;  -- b_bit > b_value'LOW
          
        end loop;  -- WHILE ...
        
      end if;  -- b_value(b_value'HIGH) = '1'
      
    end if;  -- b_constant /= 0

    -- Do not allow start_bit to exceed mem_addr_width if last mem and
    -- a is signed
    if last_mem and a_type = C_SIGNED and start_bit > mem_addr_width then
      start_bit := mem_addr_width;
    end if;

    return start_bit;
    
  end calc_rom_start_bit;

  -- andreww restructured calc_rom_contents to work better with XST
  -- previously the call the multiply_bv was made within the nested FOR loops,
  -- which could result in extra memory overhead.  Moving this outside to an independent
  -- FOR loop and assembling a constant array is much easier on XST
  -- 16 November 2005
  function calc_rom_contents(b_width        : integer;
                             b_type         : integer;
                             rom_addr_width : integer;
                             rom_depth      : integer;
                             rom_width      : integer;
                             start_bit      : integer;
                             b_value        : string;
                             num_rom_bits   : integer) return bit_vector is

    variable b_value_bv   : bit_vector(b_width-1 downto 0);
    variable prod         : bit_vector(rom_addr_width+b_width-1 downto 0);
    variable rom_contents : bit_vector(num_rom_bits-1 downto 0);
    -- new things
    type T_PROD is array (0 to rom_depth-1) of bit_vector(rom_addr_width+b_width-1 downto 0);
    variable prod_array   : T_PROD;
    variable prod_el      : bit_vector(rom_addr_width+b_width-1 downto 0);
  begin
    b_value_bv := mult_gen_str_to_bv(b_value, b_width);

    for rom_addr in 0 to rom_depth-1 loop
      prod_array(rom_addr) := multiply_bv(natural_to_bit_vector(rom_addr, rom_addr_width), b_value_bv, false, (b_type = C_SIGNED));
    end loop;  -- rom_addr

    for rom_addr in 0 to rom_depth-1 loop
      -- Multiply rom_addr by c_b_value

      -- get the bit vector out of the array
      prod_el := prod_array(rom_addr);

      rom_contents((rom_addr*rom_width + rom_width-1) downto (rom_addr*rom_width + 0)) := prod_el((rom_width-1 + start_bit) downto (0 + start_bit));
      
    end loop;

    return rom_contents;
    
  end calc_rom_contents;

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
  function calc_last_rom_contents(b_width            : integer;
                                  a_width            : integer;  -- not incl a_signed
                                  a_type             : integer;
                                  b_type             : integer;
                                  has_a_signed       : integer;
                                  rom_addr_width     : integer;
                                  rom_depth          : integer;
                                  rom_width          : integer;
                                  start_bit          : integer;
                                  b_value            : string;
                                  b_constant         : integer;
                                  num_rom_bits       : integer;
                                  number_of_pps      : integer;
                                  a_signed_extension : boolean) return bit_vector is

    constant a_signed     : boolean := ((a_type = C_SIGNED) or (has_a_signed /= 0));
    constant max_val      : integer := 2**(a_width-1);
    constant prod_width   : integer := a_width + b_width;
    variable b_value_bv   : bit_vector(b_width-1 downto 0);
    variable prod         : bit_vector(prod_width-1 downto 0);
    variable rom_contents : bit_vector(num_rom_bits-1 downto 0);
    variable debug_string : string(1 to prod_width);
  begin

    if (has_a_signed = 0 and a_type = C_UNSIGNED) or (b_constant = 0) then
      return calc_rom_contents(b_width, b_type, a_width, rom_depth, rom_width, start_bit, b_value, num_rom_bits);
    else
      b_value_bv := mult_gen_str_to_bv(b_value, b_width);

      for rom_addr in 0 to rom_depth-1 loop

        -- Multiply rom_addr by c_b_value
        prod := multiply_bv(natural_to_bit_vector(rom_addr, a_width), b_value_bv, a_signed, (b_type = C_SIGNED));

        rom_contents((rom_addr*rom_width + rom_width-1) downto (rom_addr*rom_width + 0)) := prod((rom_width-1 + start_bit) downto (0 + start_bit));
        
      end loop;

      return rom_contents;
      
    end if;
    
  end calc_last_rom_contents;

  ------------------------------------------------------------------------------
  -- Return adder level within the symmetric tree for a given adder number.
  -- Adder numbers start from 0. Level 1 is the level nearest the pprods.
  ------------------------------------------------------------------------------
  function calc_adder_level(adder_num, max_add_levels : integer) return integer is
    type num_al_type is array(1 to max_add_levels) of integer;
    variable add_level : integer;
    variable num_al    : num_al_type;
  begin
    for i in 1 to max_add_levels loop
      num_al(i) := 0;
    end loop;

    add_level := 1;

    for i in 0 to (adder_num-1) loop
      num_al(add_level) := num_al(add_level) + 1;

      if (num_al(add_level) = 2) then
        num_al(add_level) := 0;
        add_level         := add_level + 1;
      else
        add_level := 1;
      end if;
      
    end loop;

    return add_level;
    
  end calc_adder_level;

  ------------------------------------------------------------------------------
  -- Return the adder number of the adder whose b input is the last partial
  -- product. Adders are numbered 0 to n.
  ------------------------------------------------------------------------------
  function calc_last_pp_adder(num_pps          : integer;
                              max_add_levels   : integer;
                              num_adders       : integer;
                              num_extra_adders : integer) return integer is
    variable add_num : integer;
  begin
    if num_extra_adders > 0 and (num_pps mod 2 /= 0) then
      -- First extra adder is the last pp adder
      return num_adders-num_extra_adders;
    else
      add_num := 0;

      for p in 0 to num_pps-2 loop
        for l in 1 to max_add_levels loop
          
          if ((p+1) mod 2**l = 0) then
            add_num := add_num + 1;
          end if;
          
        end loop;  -- l
      end loop;  -- p

      return add_num;
      
    end if;  -- num_extra_adders > 0 ...
  end calc_last_pp_adder;


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
  function calc_num_extra_adders(num_pps, max_num_pps : integer)
    return integer is
    variable adder_count   : integer;
    variable pps_group     : integer;
    variable pps_remaining : integer;
  begin
    
    pps_remaining := num_pps;
    pps_group     := max_num_pps;
    adder_count   := 0;

    while ((pps_group > 1) and (pps_group /= pps_remaining)) loop
      
      if (pps_remaining > pps_group) then
        adder_count   := adder_count + 1;
        pps_remaining := pps_remaining - pps_group;
      end if;

      pps_group := pps_group / 2;
    end loop;

    return adder_count;
  end calc_num_extra_adders;

  ------------------------------------------------------------------------------
  -- Return width of partial or full product
  -- Set full_prod to TRUE if width of total final product is to be returned.
  ------------------------------------------------------------------------------
  function calc_pp_width(b_width      : integer;
                         b_type       : integer;
                         b_value      : string;
                         b_constant   : integer;
                         a_width      : integer;
                         a_type       : integer;
                         has_a_signed : integer;
                         last_pp      : boolean;
                         full_prod    : boolean) return integer is

    variable a_all_1s : bit_vector(a_width-1 downto 0);
    variable b_all_1s : bit_vector(b_width-1 downto 0);

    -- a_type is always unsigned for partial products if b is not constant
    constant act_a_type : integer :=
      select_val(a_type, C_UNSIGNED, b_constant = 0 and not(full_prod));
    constant act_a_sgnd : integer :=
      select_val(has_a_signed, 0, b_constant = 0 and not(full_prod));
    
    variable min_a               : bit_vector(a_width-1 downto 0);
    variable a_value_bv          : bit_vector(a_width-1 downto 0);
    variable b_value_bv          : bit_vector(b_width-1 downto 0);
    variable pp_width            : integer;
    variable pp_width_a_negative : integer;
  begin

    assert not(ccm_debug) report "calc_pp_width args "
      & integer'image(b_width)
      & " " & integer'image(b_type)
      & " " & b_value
      & " " & integer'image(b_constant)
      & " " & integer'image(a_width)
      & " " & integer'image(a_type)
      & " " & integer'image(has_a_signed)
      & " " & boolean'image(last_pp)
      & " " & boolean'image(full_prod) severity note;
    
    -- Workaround for VTFC not handling bit_vector type correctly
    for i in a_width-1 downto 0 loop
      a_all_1s(i) := '1';      
    end loop;  -- i

    for i in b_width-1 downto 0 loop
      b_all_1s(i) := '1';
    end loop;  -- i

    assert not(ccm_debug) report "0: pp_width is " & integer'image(pp_width) severity note;
    
    if b_width = 1 and b_type = C_UNSIGNED then
      if b_value(b_value'high) = '0' and b_constant /= 0 then
        pp_width := 1;                  -- Special case for multiplying by 0
      else
        pp_width := a_width;
        -- a_signed is not part of pp input if b_constant/=0
        if last_pp and act_a_sgnd /= 0 then
          pp_width := pp_width + 1;
        end if;
      end if;  -- b_value
    else
      -- Return minimum number of bits to represent maximum possible pp value
      if b_constant = 0 then
        if b_type = C_UNSIGNED then
          -- Must assume max possible B value
          b_value_bv := b_all_1s;
        else
          if b_width > 1 then
            -- Use loop assignment for VTFC support
            for i in b_width-2 downto 0 loop
              b_value_bv(i) := '0';
            end loop;  -- i
          end if;
          b_value_bv(b_width-1) := '1';
        end if;  -- b_type = C_UNSIGNED
      else
        b_value_bv := mult_gen_str_to_bv(b_value, b_width);
      end if;

      -- A input always treated as unsigned except for last pp
      if not(last_pp) or act_a_type = C_UNSIGNED then
        if a_width = 1 and b_value_bv = b_all_1s and b_type /= C_UNSIGNED and b_constant /= 0 then
          pp_width := 1;                -- -1 * (0 or 1) only needs 1 bit
        else
          pp_width := bitstorep_bv(multiply_bv(a_all_1s, b_value_bv, false, (b_type = C_SIGNED)), b_type, (b_type /= C_SIGNED));
        end if;  -- a_width = 1 AND ...

      -- a_signed input has effect on last PP
      elsif act_a_sgnd /= 0 then        -- 1 is added later
        pp_width := bitstorep_bv(multiply_bv(a_all_1s, b_value_bv, false, (b_type = C_SIGNED)), b_type, (b_type /= C_SIGNED));
        -- Add 1 to last pp width if extra bit has to be added due to
        -- c_has_a_signed as above result always +ve if b_type unsigned
        if b_type = C_UNSIGNED then
          pp_width := pp_width + 1;
        else
          -- Get minimum possible A value
          if a_width > 1 then
            -- Use loop assignment for VTFC support
            for i in a_width-1 downto 0 loop
              a_value_bv(i) := '0';
            end loop;  -- i
          end if;
          a_value_bv(a_width-1) := '1';

          -- Min A * Min B to get max +ve output
          pp_width_a_negative := bitstorep_bv(multiply_bv(a_value_bv, b_value_bv, true, true), C_UNSIGNED, true);  -- -ve (A) * -ve (B) = +ve
          if pp_width_a_negative >= pp_width then
            pp_width := pp_width + 1;
          end if;
        end if;

      else  -- last_pp and a_type=C_SIGNED and c_has_a_signed=0

        if a_width = 1 then             -- Worst case = -1
          pp_width := bitstorep_bv(multiply_bv("11", b_value_bv, true, (b_type = C_SIGNED)), C_SIGNED, (b_type = C_SIGNED));
        else
          -- Lowest possible A value
          -- Use loop assignment for VTFC support
          for i in a_width-1 downto 0 loop
            min_a(i) := '0';
          end loop;  -- i
          min_a(a_width-1)          := '1';

          -- Determine type of widest possible PP
          -- -ve * -ve = +ve, -ve * +ve = -ve
          pp_width := bitstorep_bv(multiply_bv(min_a, b_value_bv, true, (b_type = C_SIGNED)), C_SIGNED, (b_type = C_SIGNED));

        end if;

      end if;  -- NOT(last_pp) OR ...

    end if;

    assert not(ccm_debug) report "INFO: pp_width calculated as " & integer'image(pp_width) severity note;
    return pp_width;
  end calc_pp_width;

  ------------------------------------------------------------------------------
  -- Sometimes specified c_mem_type parameter is illegal. Check and change to a
  -- legal value if necessary.
  ------------------------------------------------------------------------------
  function get_mem_type(family          : string;
                        mem_type        : integer;
                        bram_addr_width : integer;
                        has_swapb       : integer;
                        a_width         : integer;
                        a_type          : integer;
                        has_a_signed    : integer;
                        b_constant      : integer;
                        has_o           : integer) return integer is
    constant rom_addr_width : integer := get_rom_addr_width(family, mem_type);

    constant a_input_width : integer := calc_a_input_width(a_width, has_a_signed, rom_addr_width, b_constant);

    constant number_of_pps : integer := calc_num_pps(a_input_width, rom_addr_width);

    constant need_addsub : boolean := b_constant = 0 and (a_type /= C_UNSIGNED or has_a_signed /= 0);

    -- Single PP but need an addsub to negate result
    constant need_0_minus_pp : boolean := need_addsub and number_of_pps <= 1;

    constant number_of_adders : integer := select_val(number_of_pps-1, 1, need_0_minus_pp);

    variable mem_type_i : integer;
  begin
    if mem_type /= C_DISTRIBUTED and has_swapb = 0 and has_o /= 0 and number_of_adders < 1 then

      mem_type_i := C_DISTRIBUTED;

      
        report "ERROR: CCM - the O output is not available with block memory " &
        "and this parameter combination." & new_line &
        "                            Select distributed memory if the O " &
        "output is required in this case." & new_line
        severity failure;
    else
      mem_type_i := mem_type;
    end if;

    return mem_type_i;
  end get_mem_type;

  -----------------------------------------------------------------------------
  -- FUNCTIONS FROM CCM_UTILS_V9_0
  -----------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Return number of bits required to represent the supplied parameter
--------------------------------------------------------------------------------
  function bitsneededtorepresent(a_value : integer) return integer is--(a_value : natural) return natural is
    variable return_value : integer := 1;
  begin

    for i in 30 downto 0 loop
      if a_value >= 2**i then
        return_value := i+1;
        exit;
      end if;
    end loop;

    return return_value;

  end bitsneededtorepresent;

-------------------------------------------------------------------------------
-- bitstorep_bv updated by andreww 19th May 06 - Worked correctly with MTI 6.1e,
-- but not with XST I.31 - simplified code to ease debug
-- Assumes that the bit_vector a_value is a DOWNTO vector
-------------------------------------------------------------------------------
  function bitstorep_bv(a_value    : bit_vector;
                        a_type     : integer;
                        a_positive : boolean) return integer is
    variable str_rep : string(1 to a_value'length);
    variable return_value : integer := a_value'length;
  begin

--    assert not(ccm_debug) report "bitstorep_bv args " & slv_to_str(bv_to_slv(a_value)) & " " & integer'image(a_type) & " " & boolean'image(a_positive) severity note;
    
    -- For VTFC support, we need to convert to a string before analysing the
    -- vector.  Only 'length, 'low and 'high are supported by VTFC at present.
    -- Assumes that the bit_vector is DOWNTO and has LSB at index zero
    for i in str_rep'low-1 to str_rep'high-1 loop
      if a_value(i) = '1' then
        str_rep(i+1) := '1';
      elsif a_value(i) = '0' then
        str_rep(i+1) := '0';
      else
        
          report "ERROR: mult_gen: non-binary value caught in bitstorep_bv"
          severity failure;
      end if;
    end loop;  -- i
    
    if a_type = C_UNSIGNED then

      -- str_rep represents an unsigned number    
      for i in str_rep'high downto str_rep'low loop
        if str_rep(i) = '1' then
          exit;                         -- EXIT when the msb is found
        elsif str_rep(i) = '0' then
          return_value := return_value - 1;
        end if;
      end loop;
      
    else

      -- str_rep represents a signed number
      
      if a_positive then

        -- Look for ms '1' then add 1 for a leading 0      
        for i in str_rep'high downto str_rep'low loop
          if i-1 > 0 then
            if str_rep(i) = '0' and str_rep(i-1) = '1' then
              exit;
            else
              return_value := return_value - 1;
            end if;
          else
            exit;
          end if;
        end loop;  -- i
        
      else

        -- Look for ms '1' followed by a '0'
        for i in str_rep'high downto str_rep'low loop
          if i-1 > 0 then
            if str_rep(i) = '1' and str_rep(i-1) = '0' then
              exit;
            else
              return_value := return_value - 1;
            end if;
          else
            exit;
          end if;
        end loop;  -- i
        
      end if;  -- a_positive
      
    end if;

    if return_value <= 0 then
      return 1;
    elsif a_type /= c_unsigned and return_value <= 2 then
      return 2;  -- always need at least 2 bits to represent signed numbers
    else
      return return_value;
    end if;

  end bitstorep_bv;

--------------------------------------------------------------------------------
-- Convert STD_LOGIC_VECTOR to STRING
-- Assumes STRING is of type (n TO n+length-1) with MSB in 'n' position.
-- Returns STD_LOGIC_VECTOR of type (nbits-1 DOWNTO 0) with LSB in 0 position.
--------------------------------------------------------------------------------
  function slv_to_str(bitsin : std_logic_vector; nbits : integer) return string is
    variable ret     : string(1 to nbits);
    variable bit_num : integer;
  begin
    ret := (others => '0');

    bit_num := 1;

    for i in bitsin'range loop
      
      if bitsin(i) = '1' then
        ret(bit_num) := '1';
      elsif bitsin(i) = '0' then
        ret(bit_num) := '0';
      elsif (bitsin(i) = 'L') then
        ret(bit_num) := 'L';
      elsif (bitsin(i) = 'H') then
        ret(bit_num) := 'H';
      elsif (bitsin(i) = 'Z') then
        ret(bit_num) := 'Z';
      elsif (bitsin(i) = 'W') then
        ret(bit_num) := 'W';
      elsif (bitsin(i) = 'U') then
        ret(bit_num) := 'U';
      elsif (bitsin(i) = 'X') then
        ret(bit_num) := 'X';
      elsif (bitsin(i) = '-') then
        ret(bit_num) := '-';
      else
        
          report "ERROR: invalid character passed to slv_to_str function." &
          new_line
          severity failure;
      end if;

      bit_num := bit_num + 1;

      if bit_num > nbits then
        exit;  -- Ignore ms bits in SLV if SLV is longer than STRING
      end if;
    end loop;

    return ret;
    
  end slv_to_str;

--------------------------------------------------------------------------------
-- Return i0 if sel = 0, i1 if sel = 1
--------------------------------------------------------------------------------
  function mult_gen_max_of(i0, i1 : integer) return integer is
  begin
    if (i0 > i1) then
      return i0;
    else
      return i1;
    end if;
  end mult_gen_max_of;

-------------------------------------------------------------------------------
-- function modified by andreww 13th May 06 - need to account for signed and
-- unsigned products
-------------------------------------------------------------------------------
  use ieee.std_logic_signed.all;

  function multiply_bv(a, b : bit_vector; a_signed, b_signed : boolean) return bit_vector is
    constant a_slv    : std_logic_vector(a'range) := to_stdlogicvector(a);
    constant b_slv    : std_logic_vector(b'range) := to_stdlogicvector(b);
    variable ai       : std_logic_vector(a'high+1 downto a'low);
    variable bi       : std_logic_vector(b'high+1 downto b'low);
    variable prod     : std_logic_vector(ai'length+bi'length-1 downto 0);
    -- create an intermediate variable to assign the bit_vector into
    -- if we don't do this and return directly from the to_bitvector function,
    -- XST assumes that the returned bit_vector is (0 TO N-1) rather than the
    -- (N-1 downto 0) that we require (and all other functions assume...)
    variable prod_slv : std_logic_vector(a'length+b'length-1 downto 0);
    variable prod_bv  : bit_vector(a'length+b'length-1 downto 0);
  begin

--    assert not(ccm_debug) report "multiply_bv args " & slv_to_str(bv_to_slv(a)) & " " & slv_to_str(bv_to_slv(b)) & " " & boolean'image(a_signed) & " " & boolean'image(b_signed) severity note;

--    -- Original code in v11.0 - this doesn't work with modelsim 6.4a/b (at least)
--    if a_signed then
--      ai := std_logic_vector(resize(signed(to_Stdlogicvector(a)), ai'length));
--    else
--      ai := std_logic_vector(resize(unsigned(to_Stdlogicvector(a)), ai'length));
--    end if;
--    if b_signed then
--      bi := std_logic_vector(resize(signed(to_Stdlogicvector(b)), bi'length));
--    else
--      bi := std_logic_vector(resize(unsigned(to_Stdlogicvector(b)), bi'length));
--    end if;

    if a_signed then
      ai := std_logic_vector(resize(signed(a_slv), ai'length));
    else
      ai := std_logic_vector(resize(unsigned(a_slv), ai'length));
    end if;
    if b_signed then
      bi := std_logic_vector(resize(signed(b_slv), bi'length));
    else
      bi := std_logic_vector(resize(unsigned(b_slv), bi'length));
    end if;
    
    -- since we've manually sign- (or zero-) extended, we can perform a signed multiplication
    prod := ieee.std_logic_signed."*"(ai, bi);
   
    -- return only the necessary width - don't use the resize() function here as it can give the wrong results 
    prod_bv := to_bitvector(prod(a'length+b'length-1 downto 0));  -- this line doesn't work with VTFC - no arguments passed to to_bitvector

    return prod_bv;
    
  end multiply_bv;

--------------------------------------------------------------------------------
-- Convert NATURAL to BIT_VECTOR
-- The ls length bits of in_val are returned.
--------------------------------------------------------------------------------
  function natural_to_bit_vector(in_val : in integer; length : in integer)
    return bit_vector is
    variable temp   : integer                       := in_val;
    variable result : bit_vector(length-1 downto 0) := (others => '0');
  begin
    result := to_bitvector(std_logic_vector(resize(to_unsigned(in_val, 32), length)));
    return result;
  end natural_to_bit_vector;

--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
  function mult_gen_select_string(i0 : string; i1 : string; sel : boolean)
    return string is
  begin
    if sel then
      return i1;
    else
      return i0;
    end if;  -- sel
  end mult_gen_select_string;

--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
  function select_val(i0 : integer; i1 : integer; sel : boolean) return integer is
  begin
    if sel then
      return i1;
    else
      return i0;
    end if;  -- sel
  end select_val;

  function select_val_int(i0 : integer; i1 : integer; sel : integer) return integer is
  begin
    if sel = 1 then
      return i1;
    else
      return i0;
    end if;  -- sel
  end select_val_int;

--------------------------------------------------------------------------------
-- Convert STRING to BIT_VECTOR
-- Assumes STRING is of type (n TO n+length-1) with MSB in 'n' position.
-- Returns BIT_VECTOR of type (nbits-1 DOWNTO 0) with LSB in 0 position.
--------------------------------------------------------------------------------
  function mult_gen_str_to_bv(bitsin : string; nbits : integer) return bit_vector is
    variable ret     : bit_vector(nbits-1 downto 0);
    variable bit_num : integer;
  begin
    ret := (others => '0');

    if (bitsin'length = 0) then         -- Make all '0's
      return ret;
    end if;

    bit_num := 0;

    --  FOR i IN bitsin'REVERSE_RANGE LOOP -- doesn't work with XCC
    for i in bitsin'high downto bitsin'low loop
      
      if bitsin(i) = '1' then
        ret(bit_num) := '1';
      elsif bitsin(i) = '0' then
        ret(bit_num) := '0';
      else        
          report "ERROR: non 0 or 1 character passed to mult_gen_str_to_bv function. String passed in was: " & bitsin
          severity failure;
      end if;

      bit_num := bit_num + 1;

      if bit_num >= nbits then
        exit;  -- Ignore ms characters in STRING if STRING is longer than BV
      end if;
    end loop;

    return ret;
    
  end mult_gen_str_to_bv;

  function mult_gen_bv_to_str(bitsin : bit_vector; nbits : integer) return string is
    variable ret     : string(1 to bitsin'length);
    variable bit_num : integer;
  begin
    ret := (others => '0');

    if (bitsin'length = 0) then         -- Make all '0's
      return ret;
    end if;

    bit_num := 0;

    for i in bitsin'high downto bitsin'low loop
      
      if bitsin(i) = '1' then
        ret(bit_num) := '1';
      elsif bitsin(i) = '0' then
        ret(bit_num) := '0';
      else        
          report "ERROR: non 0 or 1 character passed to mult_gen_bv_to_str function"
          severity failure;
      end if;

      bit_num := bit_num + 1;

      if bit_num >= nbits then
        exit;  -- Ignore ms characters in bit_vector if bit_vector is longer than string
      end if;
    end loop;

    return ret;
    
  end mult_gen_bv_to_str;
  
  -----------------------------------------------------------------------------
  -- functions imported from ccm_mem_utils_v9.0.vhd

  function calc_depth(reqd_depth : integer; mem_type : integer) return integer is
    variable extra      : integer := 0;
    variable addr_width : integer := bitsneededtorepresent(reqd_depth-1);
  begin
    if mem_type = c_distributed then
      extra := reqd_depth mod 2**addr_width;  --16;

      if (extra = 0) then
        return reqd_depth;
      else
        return (reqd_depth + (2**addr_width) - extra);  --16 - extra);
      end if;
    else
      -- Must be block mem. Block mems must be 16, 32, 64, 128, 256 or n * 256 deep
      if reqd_depth <= 16 then
        return 16;
      elsif reqd_depth <= 256 then
        return 2**(bitsneededtorepresent(reqd_depth-1));
      else
        return 256 + (256 * ((reqd_depth-1)/256));
      end if;  -- reqd_depth
      
    end if;  -- mem_type
  end calc_depth;

  -----------------------------------------------------------------------------  
  -- Resource estimation functions to be converted by VTFC
  -----------------------------------------------------------------------------

  -- purpose: this routine works out the LUT count for the LUT multiplier in a
  -- LUT4 binary adder structure and is accurate to +/- 1-% of characterisation data
  function calc_lut_mult_resources (c_a_width, c_b_width : integer) return integer is
    -- calculation variables
    variable opa                                                                  : integer := 0;
    variable opb                                                                  : integer := 0;
    variable PPs                                                                  : integer := 0;
    variable carrychainlength                                                     : integer := 0;
    variable treestages                                                           : integer := 0;
    variable stage1adders, stage2adders, stage3adders, stage4adders, stage5adders : integer := 0;
    -- the final return value
    variable lutcount                                                             : integer := 0;
  begin  -- function calc_lut_mult_resources

    opa     := mult_gen_max_of(c_a_width, c_b_width);
    opb     := get_min(c_a_width, c_b_width);

    assert not(debug) report "      opa is " & integer'image(opa);
    assert not(debug) report "      opb is " & integer'image(opb);    
    
    -- work out how many PP generators there are
    if (opb mod 2) /= 0 then
      PPs := (opb+1)/2;
    else
      PPs := opb / 2;
    end if;

    carrychainlength := opa + 2;

    -- Set the lut count for the PP generators to be rounded down if PPs is odd
    -- - the LUTs will be sucked into the adder tree
    if opb > 1 then
      lutcount := (opb / 2) * carrychainlength;
    else
      lutcount := opa;
    end if;

    if (opb mod 2) /= 0 and PPs > 1 then
      lutcount := lutcount + opb;
    end if;

    case PPs is
      when 1        => treestages := 0;
      when 2        => treestages := 1;
      when 3 to 4   => treestages := 2;
      when 5 to 8   => treestages := 3;
      when 9 to 16  => treestages := 4;
      when 17 to 32 => treestages := 5;
      when others   => null;
    end case;

    case PPs is
      when 1 =>
        stage1adders := 0;
        stage2adders := 0;
        stage3adders := 0;
        stage4adders := 0;
        stage5adders := 0;
      when 2 =>
        stage1adders := 1;
        stage2adders := 0;
        stage3adders := 0;
        stage4adders := 0;
        stage5adders := 0;
      when 3 =>
        stage1adders := 1;
        stage2adders := 1;
        stage3adders := 0;
        stage4adders := 0;
        stage5adders := 0;
      when 4 =>
        stage1adders := 2;
        stage2adders := 1;
        stage3adders := 0;
        stage4adders := 0;
        stage5adders := 0;
      when 5 =>
        stage1adders := 2;
        stage2adders := 1;
        stage3adders := 1;
        stage4adders := 0;
        stage5adders := 0;
      when 6 =>
        stage1adders := 3;
        stage2adders := 1;
        stage3adders := 1;
        stage4adders := 0;
        stage5adders := 0;
      when 7 =>
        stage1adders := 3;
        stage2adders := 2;
        stage3adders := 1;
        stage4adders := 0;
        stage5adders := 0;
      when 8 =>
        stage1adders := 4;
        stage2adders := 2;
        stage3adders := 1;
        stage4adders := 0;
        stage5adders := 0;
      when 9 =>
        stage1adders := 4;
        stage2adders := 2;
        stage3adders := 1;
        stage4adders := 1;
        stage5adders := 0;
      when 10 =>
        stage1adders := 5;
        stage2adders := 2;
        stage3adders := 1;
        stage4adders := 1;
        stage5adders := 0;
      when 11 =>
        stage1adders := 5;
        stage2adders := 2;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 0;
      when 12 =>
        stage1adders := 6;
        stage2adders := 3;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 0;
      when 13 =>
        stage1adders := 6;
        stage2adders := 3;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 0;
      when 14 =>
        stage1adders := 7;
        stage2adders := 2;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 0;
      when 15 =>
        stage1adders := 7;
        stage2adders := 3;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 0;
      when 16 =>
        stage1adders := 8;
        stage2adders := 4;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 0;
      when 17 =>
        stage1adders := 8;
        stage2adders := 4;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 1;
      when 18 =>
        stage1adders := 9;
        stage2adders := 4;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 1;
      when 19 =>
        stage1adders := 9;
        stage2adders := 5;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 1;
      when 20 =>
        stage1adders := 10;
        stage2adders := 5;
        stage3adders := 2;
        stage4adders := 1;
        stage5adders := 1;
      when 21 =>
        stage1adders := 10;
        stage2adders := 5;
        stage3adders := 3;
        stage4adders := 1;
        stage5adders := 1;
      when 22 =>
        stage1adders := 11;
        stage2adders := 6;
        stage3adders := 3;
        stage4adders := 1;
        stage5adders := 1;
      when 23 =>
        stage1adders := 11;
        stage2adders := 6;
        stage3adders := 3;
        stage4adders := 2;
        stage5adders := 1;
      when 24 =>
        stage1adders := 12;
        stage2adders := 6;
        stage3adders := 3;
        stage4adders := 1;
        stage5adders := 1;
      when 25 =>
        stage1adders := 12;
        stage2adders := 7;
        stage3adders := 3;
        stage4adders := 1;
        stage5adders := 1;
      when 26 =>
        stage1adders := 13;
        stage2adders := 7;
        stage3adders := 3;
        stage4adders := 1;
        stage5adders := 1;
      when 27 =>
        stage1adders := 13;
        stage2adders := 7;
        stage3adders := 3;
        stage4adders := 2;
        stage5adders := 1;
      when 28 =>
        stage1adders := 14;
        stage2adders := 7;
        stage3adders := 3;
        stage4adders := 2;
        stage5adders := 1;
      when 29 =>
        stage1adders := 14;
        stage2adders := 7;
        stage3adders := 4;
        stage4adders := 2;
        stage5adders := 1;
      when 30 =>
        stage1adders := 15;
        stage2adders := 7;
        stage3adders := 4;
        stage4adders := 2;
        stage5adders := 1;
      when 31 =>
        stage1adders := 15;
        stage2adders := 8;
        stage3adders := 4;
        stage4adders := 2;
        stage5adders := 1;
      when 32 =>
        stage1adders := 16;
        stage2adders := 8;
        stage3adders := 4;
        stage4adders := 2;
        stage5adders := 1;
      when others => null;
    end case;

    lutcount := lutcount + (stage1adders * carrychainlength);
    lutcount := lutcount + (stage2adders * (carrychainlength+2));
    lutcount := lutcount + (stage3adders * (carrychainlength+2+4));
    lutcount := lutcount + (stage4adders * (carrychainlength+2+4+8));
    lutcount := lutcount + (stage5adders * (carrychainlength+2+4+8+16));    
    return lutcount;
  end function calc_lut_mult_resources;

  -- purpose: Calculates number of embedded multipliers used to build a
  -- hybrid multiplier
  function calc_hybrid_emb_mults (
    family   : string;
    op_width : WIDTH_REC) return integer is
    variable a_pp  : integer := hybrid_calc_a_pp(family, op_width);
    variable b_pp  : integer := hybrid_calc_b_pp(family, op_width);
    variable mults : integer := 0;
  begin  -- function calc_hybrid_emb_mults
    mults := a_pp * b_pp;
    return mults;
  end function calc_hybrid_emb_mults;
 
  -- purpose: calculates roughly how many LUTs are used in building a given
  -- hybrid multiplier
  function calc_hybrid_luts (
    family              : string;
    op_width            : WIDTH_REC) return integer is
    -- calculation variables and constants
    constant BASE_MULT  : integer      := 0;
    constant ONE_MULT   : integer      := 1;
    constant TWO_MULT   : integer      := 2;
    constant wire_shift : integer      := 17;
    -- set up the port sizes for all families
    constant port_size  : PORT_ASPECTS := (a => 18+(7*boolean'pos(supports_dsp48e(family) > 0)), b => 18, m => 36+(7*boolean'pos(supports_dsp48e(family) > 0)), c => 48, p => 48);
 
    variable hybrid_cfg        : integer := 0;
    variable a_pp              : integer := 0;
    variable b_pp              : integer := 0;
    variable top_mult_a_width  : integer := 0;
    variable top_mult_b_width  : integer := 0;
    variable side_mult_a_width : integer := 0;
    variable side_mult_b_width : integer := 0;
    variable block_a_width     : integer := 0;
    variable block_b_width     : integer := 0;
    variable a_port_size : integer := 0;
    variable b_port_size : integer := 0;
    variable x_width     : integer := 0;
    variable y_width           : integer := 0;

    variable block_a_type   : integer := 0;
    variable block_b_type   : integer := 0;
    variable largest_output : integer := 0;
    
    -- final return value
    variable lutcount : integer := 0;
  begin  -- function calc_hybrid_luts

    ---------------------------------------------------------------------------
    -- This code was translated from the Tcl's calc_hybrid_lut_mult_dimensions()
    ---------------------------------------------------------------------------

    a_pp := hybrid_calc_a_pp(family, op_width);
    b_pp := hybrid_calc_b_pp(family, op_width);
    
    a_port_size := mult_gen_max_of(op_width.a, port_size.a);
    b_port_size := mult_gen_max_of(op_width.b, port_size.b);

    if a_pp = 1 and b_pp = 1 then
      -- one mult block
      block_a_width := a_port_size;
      if op_width.a_type = C_UNSIGNED and op_width.a >= port_size.a then
        block_a_width := block_a_width - 1;
      end if;
      block_b_width := port_size.b;
      if op_width.b_type = C_UNSIGNED and op_width.b >= port_size.b then
        block_b_width := block_b_width - 1;
      end if;
      block_a_type := op_width.a_type;
      block_b_type := op_width.b_type;
    elsif a_pp = 2 and b_pp = 1 then
      -- two mult blocks
      block_a_width := port_size.a+wire_shift;
      if op_width.a_type = C_UNSIGNED and op_width.a >= port_size.a then
        block_a_width := block_a_width - 1;
      end if;
      block_b_width := port_size.b;
      if op_width.b_type = C_UNSIGNED and op_width.b >= port_size.b then
        block_b_width := block_b_width - 1;
      end if;
      block_a_type := op_width.a_type;
      block_b_type := op_width.b_type;
    elsif a_pp = 1 and b_pp = 2 then
      -- two mult blocks
      -- The operands will be swapped arund so that the A operand is the
      -- largest.  This means that we need to swap the a_type and b_type values over
      -- so that they remain correct w.r.t. the operand widths
      block_a_width := port_size.b+wire_shift;
      if op_width.a_type = C_UNSIGNED then
        block_a_width := block_a_width - 1;
      end if;
      block_b_width := port_size.a;
      if op_width.b_type = C_UNSIGNED then
        block_b_width := block_b_width - 1;
      end if;
      -- REVISIT: andreww: is there a bug here? should these values be swapped?
      block_a_type := op_width.a_type;
      block_b_type := op_width.b_type;
    elsif a_pp = 2 and b_pp = 2 then      
      -- four mult blocks
      block_a_width := port_size.a+wire_shift;
      if op_width.a_type = C_UNSIGNED then
        block_a_width := block_a_width - 1;
      end if;
      block_b_width := port_size.b+wire_shift;
      if op_width.b_type = C_UNSIGNED then
        block_b_width := block_b_width - 1;
      end if;
      block_a_type := op_width.a_type;
      block_b_type := op_width.b_type;
    end if;

    hybrid_cfg := get_hybrid_configuration(family, a_pp, b_pp, op_width, port_size);

    x_width := block_a_width;
    y_width := block_b_width;

    if (op_width.a > x_width and (op_width.b <= y_width or y_width < port_size.b)) and hybrid_cfg = ONE_MULT then
      top_mult_a_width := op_width.a - x_width;
      top_mult_b_width := op_width.b;
    end if;
    
    if (op_width.a <= x_width and (op_width.b > y_width or y_width < port_size.b)) and hybrid_cfg = ONE_MULT then
      top_mult_a_width := op_width.a;
      top_mult_b_width := op_width.b - y_width;
    end if;

    -- set up cfg for two LUT mults
    -- this is the code from get_two_mult_cfg in the HDL
    -- Also need to account for the fabric adder here    
    if op_width.a >= x_width and op_width.b >= y_width and hybrid_cfg = TWO_MULT then
	-- The code above will automatically swap the operands so that the largest is
	-- on the A bus.  Because we only make 2 cuts in the partial product
	-- array, this means that we want to make the A operand shorter than the B
	-- operand to balance out the carry chain lengths for e.g. 22x20 multipliers

      -- top fabric mult
      top_mult_a_width := x_width;
      top_mult_b_width := op_width.b - y_width;
      -- side fabric mult
      side_mult_a_width := op_width.a - x_width;
      side_mult_b_width := op_width.b;
    elsif op_width.b >= x_width and op_width.a >= y_width and hybrid_cfg = TWO_MULT then
      -- top fabric mult
      top_mult_a_width := y_width;
      top_mult_b_width := op_width.b - x_width;
      -- side fabric mult
      side_mult_a_width := op_width.a - x_width;
      side_mult_b_width := op_width.b;
    end if;
    
    ---------------------------------------------------------------------------
    -- End code translated from the Tcl's calc_hybrid_lut_mult_dimensions()
    ---------------------------------------------------------------------------
    
    if hybrid_cfg = ONE_MULT then
      lutcount := calc_lut_mult_resources(top_mult_a_width, top_mult_b_width);
    elsif hybrid_cfg = TWO_MULT then
      lutcount := (calc_lut_mult_resources(top_mult_a_width, top_mult_b_width)) + (calc_lut_mult_resources(side_mult_a_width, side_mult_b_width));
    end if;

    if hybrid_cfg = TWO_MULT then
      if supports_dsp48e(family) > 0 or supports_dsp48(family) = 1 or supports_dsp48a(family) > 0 then
        -- Use the LS adder - no extra logic unless it's a TWO_MULT case
        largest_output := mult_gen_max_of(top_mult_a_width+top_mult_b_width, side_mult_a_width+side_mult_b_width);
        -- add in the LUTs (roughly) for the adder bringing together the two fabric PPs
        lutcount       := lutcount + largest_output + 1;
      else
        -- Virtex-2, Spartan-3 etc. - always require at least 1 extra adder, two if it's a TWO_MULT configuration
        largest_output := mult_gen_max_of(top_mult_a_width+top_mult_b_width, side_mult_a_width+side_mult_b_width);
        -- add in the LUTs (roughly) fo rthe adder bringing together the two fabric PPs
        lutcount       := lutcount + largest_output + 1;
        -- now add in the LUTs for the adder which brings together the output
        -- of the large mult - this shoudl be 1 bit more than the output width of the
        -- embedded mult part
        lutcount       := lutcount + block_a_width + block_b_width;
      end if;
    end if;
    return lutcount;
  end function calc_hybrid_luts;

  -- purpose: works out how many embedded multipliers (DSPs or 18x18s) will be
  -- used for a particular configuration
  function calc_emb_mults (
    family   : string;
    op_width : WIDTH_REC) return integer is
    variable dsp_pps    : R_DSP_PP;
    variable a_pp, b_pp : integer := 0;
    variable mults      : integer := 0;
  begin  -- function calc_emb_mults

    assert not(fn_debug) report "entered calc_emb_mults" severity note;
    if has_dsp(family) then      
      assert not(fn_debug) report "calling calc_dsp48_pps for DSPs" severity note;
      dsp_pps := calc_dsp48_pps(family, op_width);
      mults   := (dsp_pps.a_pp * dsp_pps.b_pp) + dsp_pps.extra_b_pp;
    else
      a_pp  := calc_a_pp(family, op_width);
      b_pp  := calc_b_pp(op_width);
      mults := a_pp * b_pp;
    end if;
    assert not(fn_debug) report "leaving calc_emb_mults" severity note;
    return mults;
  end function calc_emb_mults;

  function calc_reqd_b_width (c_b_value : string; c_b_width, c_b_type : integer; reloadable : boolean) return integer is
  begin
    return select_val (c_b_width, bitstorep_string(c_b_value, c_b_type), not(reloadable));
  end function calc_reqd_b_width;

  function mult_gen_v11_2_luts (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)    
    return integer is
    constant rec : R_MULT_RESOURCES := mult_gen_v11_2_gui_resources(family, c_a_width, c_a_type, c_b_width, c_b_type, c_mult_type, c_optimize_goal, c_latency, c_ccm_imp, c_b_value);
    constant luts : integer := rec.LUTs;
  begin
    return luts;
  end function mult_gen_v11_2_luts;

  function mult_gen_v11_2_mults (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)    
    return integer is
    constant rec : R_MULT_RESOURCES := mult_gen_v11_2_gui_resources(family, c_a_width, c_a_type, c_b_width, c_b_type, c_mult_type, c_optimize_goal, c_latency, c_ccm_imp, c_b_value);
    constant mults : integer := rec.MULT18X18s + rec.DSPs;    -- only one of these values will be non-zero
  begin
    return mults;
  end function mult_gen_v11_2_mults;

  function mult_gen_v11_2_brams (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)    
    return integer is
    constant rec : R_MULT_RESOURCES := mult_gen_v11_2_gui_resources(family, c_a_width, c_a_type, c_b_width, c_b_type, c_mult_type, c_optimize_goal, c_latency, c_ccm_imp, c_b_value);
    constant brams : integer := rec.BRAMs;
  begin
    return brams;
  end function mult_gen_v11_2_brams;  
  
  -- purpose: calculates the FPGA resources for all supported multiplier configurations
  -- For use with VTFC to provide resource counts in the mult_gen CoreGen GUI
  function mult_gen_v11_2_gui_resources (
    family          : string;
    c_a_width       : integer;
    c_a_type        : integer;
    c_b_width       : integer;
    c_b_type        : integer;
    c_mult_type     : integer;
    c_optimize_goal : integer;
    c_latency       : integer;
    c_ccm_imp       : integer;
    c_b_value       : string)
    return R_MULT_RESOURCES is
    -- The values we will eventually return
    variable mult_resources   : R_MULT_RESOURCES := (LUTs => 0, DSPs => 0, MULT18X18s => 0, BRAMs => 0);
    -- Intermediate variables and constants
    constant port_size        : PORT_ASPECTS     := get_port_sizes(family);
    constant op_width         : WIDTH_REC        := get_true_widths(family, c_a_width, c_b_width, c_a_type, c_b_type, port_size);
    constant reloadable       : boolean          := false;
    variable number_of_pps    : integer          := 0;
    variable pp_width         : integer          := 0;
    variable last_pp_width    : integer          := 0;
    variable need_addsub      : boolean          := false;
    variable need_0_minus_pp  : boolean          := false;
    variable trimmed_msbs     : integer          := 0;
    variable trimmed_lsbs     : integer          := 0;
    variable num_brams        : integer          := 0;
    variable adder_luts       : integer          := 0;
    variable b_length         : integer          := 0;
    variable new_b_width      : integer          := 0;
    variable largest_pp       : integer          := 0;
    variable reqd_b_value     : string(1 to calc_reqd_b_width(c_b_value, c_b_width, c_b_type, false));
    variable number_of_adders : integer          := 0;
  begin  -- function mult_gen_v11_2_gui_resources

    assert not(fn_debug) report "entered mult_gen_v11_2_gui_resources" severity note;
    
    case c_mult_type is
      when LUT =>
        mult_resources.LUTs       := calc_lut_mult_resources(c_a_width, c_b_width);
        mult_resources.DSPs       := 0;
        mult_resources.MULT18X18s := 0;
        mult_resources.BRAMs      := 0;
      when EMBEDDED_MULT =>
        if supports_dsp48e(family) > 0 or supports_dsp48(family) = 1 or supports_dsp48a(family) > 0 then
          -- DSP-based implementations
          case c_optimize_goal is
            when EMB_MULT_RESOURCES =>
              assert false report "WARNING: The LUT results (maybe also the DSP result) will be wrong because the widths need to swapped so A is largest" severity warning;
              mult_resources.DSPs       := calc_hybrid_emb_mults(family, op_width);
              mult_resources.LUTs       := calc_hybrid_luts(family, op_width);
              mult_resources.MULT18X18s := 0;
              mult_resources.BRAMs      := 0;
            when CORE_SPEED =>
              assert not(fn_debug) report "calling calc_emb_mults" severity note;
              mult_resources.DSPs       := calc_emb_mults(family, op_width);
              mult_resources.LUTs       := 0;
              mult_resources.MULT18X18s := 0;
              mult_resources.BRAMs      := 0;
            when others =>
              null;
          end case;
        else
          case c_optimize_goal is
            -- Mult18x18-based implementations
            when EMB_MULT_RESOURCES =>
              assert false report "WARNING: The LUT results (maybe also the DSP result) will be wrong because the widths need to swapped so A is largest" severity warning;              
              mult_resources.DSPs       := 0;
              mult_resources.LUTs       := calc_hybrid_luts(family, op_width);
              mult_resources.MULT18X18s := calc_hybrid_emb_mults(family, op_width);
              mult_resources.BRAMs      := 0;
            when CORE_SPEED =>
              mult_resources.DSPs       := 0;
              mult_resources.LUTs       := 0;
              mult_resources.MULT18X18s := calc_emb_mults(family, op_width);
              mult_resources.BRAMs      := 0;
            when others =>
              null;
          end case;
        end if;
      when FIXED_CCM =>
        if check_const_power_of_two(c_b_value, c_b_type, c_mult_type) then
          -- constant is a power of two
          mult_resources.DSPs       := 0;
          mult_resources.LUTs       := 0;
          mult_resources.MULT18X18s := 0;
          mult_resources.BRAMS      := 0;
        else
          case c_ccm_imp is
            when DIST_MEM =>
             mult_resources.DSPs             := 0;
              mult_resources.MULT18X18s       := 0;
              mult_resources.BRAMs            := 0;
              number_of_pps    := calc_num_pps(calc_a_input_width(c_b_width, 0, get_rom_addr_width(family, c_ccm_imp), 1), get_rom_addr_width(family, c_ccm_imp));
              pp_width         := calc_pp_width(c_b_width, c_b_type, c_b_value, 1, c_a_width, c_a_type, 0, false, false);
              last_pp_width    := calc_pp_width(c_b_width, c_b_type, c_b_value, 1, c_a_width, c_a_type, 0, true, false);
              need_addsub      := false;
              need_0_minus_pp  := false;
              number_of_adders := select_val(number_of_pps-1, 1, need_0_minus_pp);
              adder_luts       := (number_of_adders * mult_gen_max_of(pp_width, last_pp_width));
              mult_resources.LUTs             := ((number_of_pps-1)*pp_width) + last_pp_width + adder_luts;
            when BRAM =>
              mult_resources.DSPs             := 0;
              mult_resources.MULT18X18s       := 0;
              number_of_pps    := calc_num_pps(calc_a_input_width(c_b_width, 0, get_rom_addr_width(family, c_ccm_imp), 1), get_rom_addr_width(family, c_ccm_imp));
              pp_width         := calc_pp_width(c_b_width, c_b_type, c_b_value, 1, c_a_width, c_a_type, 0, false, false);
              last_pp_width    := calc_pp_width(c_b_width, c_b_type, c_b_value, 1, c_a_width, c_a_type, 0, true, false);
              need_addsub      := false;
              need_0_minus_pp  := false;
              number_of_adders := select_val(number_of_pps-1, 1, need_0_minus_pp);
              num_brams        := (number_of_pps + 1) / 2;
              if num_brams > 1 then
                largest_pp := mult_gen_max_of(pp_width, last_pp_width);
                adder_luts := (number_of_adders * largest_pp) - (largest_pp / 2);
              else
                adder_luts := 0;
              end if;
              mult_resources.LUTs := adder_luts;
              if supports_dsp48e(family) > 0 then
                -- we can pack 2x 18K BRAMs into a 36K BRAM, so need further division here to give
                -- true number of BRAM blocks - need to round up to account for odd # BRAMs
                -- This will indicate that a whole 36K is used, even though only half may actually be
                if num_brams > 1 then
                  mult_resources.BRAMs := (num_brams + 1) / 2;
                end if;
              else
                mult_resources.BRAMs := num_brams;
              end if;
            when MULTS =>
              reqd_b_value := calc_reqd_b_value(c_b_value, c_b_width, c_b_type, calc_reqd_b_width(c_b_value, c_b_width, c_b_type, false));
              b_length     := reqd_b_value'length;
              trimmed_msbs := get_trimmed_leading_bits(c_b_value, c_b_type, c_mult_type);
              trimmed_lsbs := calc_shift_bits(reqd_b_value, 1);
              new_b_width  := b_length - (trimmed_msbs + trimmed_lsbs);
              mult_resources.BRAMS    := 0;
              if supports_dsp48e(family) > 0 or supports_dsp48(family) = 1 or supports_dsp48a(family) > 0 then
                mult_resources.DSPs       := calc_emb_mults(family, op_width);
                mult_resources.MULT18X18s := 0;
                mult_resources.LUTs       := 0;
              else
                mult_resources.DSPs       := 0;
                mult_resources.MULT18X18s := calc_emb_mults(family, op_width);
                mult_resources.LUTs       := 0;
              end if;
            when others =>
              null;
          end case;
        end if;
      when others =>
        null;
    end case;
    
    return mult_resources;
    
  end function mult_gen_v11_2_gui_resources;

  function get_port_sizes (family : string) return PORT_ASPECTS is
    variable port_size : PORT_ASPECTS;
  begin
    -- set up the port sizes for all families
    port_size.a := 18+(7*boolean'pos(supports_dsp48e(family) > 0));
    port_size.b := 18;
    port_size.m := 36+(7*boolean'pos(supports_dsp48e(family) > 0));
    port_size.c := 48;
    port_size.p := 48;
    return port_size;
  end function get_port_sizes;
  
end package body mult_gen_pkg_v11_2;
