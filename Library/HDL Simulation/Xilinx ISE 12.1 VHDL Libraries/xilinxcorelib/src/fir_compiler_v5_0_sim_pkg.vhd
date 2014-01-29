-------------------------------------------------------------------------------
-- $RCSfile: fir_compiler_v5_0_sim_pkg.vhd,v $ $Revision: 1.4 $ $Date: 2009/12/04 11:47:01 $
-------------------------------------------------------------------------------
-- Copyright (c) 2006 - 2009 Xilinx, Inc. All rights reserved.
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
-- PART OF THIS FILE AT ALL TIMES
-------------------------------------------------------------------------------
-- Description:
--    Automatically generated file
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

library xilinxcorelib;
--use XilinxCoreLib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_utils_pkg_v2_0.get_max;
use xilinxcorelib.bip_utils_pkg_v2_0.get_min;
use xilinxcorelib.bip_utils_pkg_v2_0.log2roundup;
use xilinxcorelib.bip_utils_pkg_v2_0.equalignorecase;
use xilinxcorelib.bip_utils_pkg_v2_0.derived;
use xilinxcorelib.bip_utils_pkg_v2_0.int_to_str;
use xilinxcorelib.bip_utils_pkg_v2_0.int_to_string;
use xilinxcorelib.bip_utils_pkg_v2_0.divroundup;


-------------------------------------------------------------------------------
package fir_compiler_v5_0_sim_pkg is

--------------------------------------------------------------------------------
--From:  ../../hdl/toolbox/toolbox_pkg.vhd

type t_int_array is array (integer range <>) of integer;

function ext_bus(input_bus: std_logic_vector; width:integer; sign: integer) return std_logic_vector;

function select_integer (
         i0  : integer;
         i1  : integer;
         sel : boolean)
         return integer;

function select_int_array (
         i0  : t_int_array;
         i1  : t_int_array;
         sel : boolean)
         return t_int_array;

function select_string (
         i0  : string;
         i1  : string;
         sel : boolean)
         return string;

function select_slv (
         i0  : std_logic_vector;
         i1  : std_logic_vector;
         sel : boolean)
         return std_logic_vector;

function select_sl (
         i0  : std_logic;
         i1  : std_logic;
         sel : boolean)
         return std_logic;

function bmg2v1_bram_prim_sel(width:integer;depth:integer) return integer;

function str_ext(src:string;dest_len:integer) return string;

function split_bus( index:integer; bus_in:std_logic_vector; bus_width:t_int_array) return std_logic_vector;

function bus_high(index: integer;bus_widths:t_int_array) return integer;

function bus_low(index: integer;bus_widths:t_int_array) return integer;

function is_pow_of_2(val:integer) return boolean;

function add_const(in_array:t_int_array; const:integer) return t_int_array;

function slv_to_string (
         bitsin : std_logic_vector;
         nbits  : integer)
         return string;

function string_to_slv (
         bitsin : string;
         nbits  : integer)
         return std_logic_vector;

type t_bram_depth is array (integer range <>)
     of integer;

constant v4_bram_depth : t_bram_depth(1 to 36) --48)
         := ( 1=> integer(2**14),                                        -- 1-bit
              2=> integer(2**13),                                        -- 2-bit
              3=> integer(2**12), 4=> integer(2**12),                                  -- 4-bit
              5=> integer(2**11), 6=> integer(2**11),7=> integer(2**11),8=> integer(2**11),9=> integer(2**11),                -- 9-bit
              10=> integer(2**10),11=> integer(2**10),12=> integer(2**10),13=> integer(2**10),                      -- 18-bit
              14=> integer(2**10),15=> integer(2**10),16=> integer(2**10),17=> integer(2**10),18=> integer(2**10),                -- 18-bit
              19=> integer(2**9),20=> integer(2**9),21=> integer(2**9),22=> integer(2**9),23=> integer(2**9),24=> integer(2**9),25=> integer(2**9),26=> integer(2**9),27=> integer(2**9), -- 36-bit
              28=> integer(2**9),29=> integer(2**9),30=> integer(2**9),31=> integer(2**9),32=> integer(2**9),33=> integer(2**9),34=> integer(2**9),35=> integer(2**9),36=> integer(2**9));--, -- 36-bit

type t_bram_prim_bmg2v1 is array (integer range <>)
     of integer;

constant bmg2v1_bram_prim : t_bram_prim_bmg2v1 (1 to 36) := (
              1=> 0,                                      -- 1-bit
              2=> 1,                                      -- 2-bit
              3=> 2,4=> 2,                                    -- 4-bit
              5=> 3,6=> 3,7=> 3,8=> 3,9=> 3,                              -- 9-bit
              10=> 4,11=> 4,12=> 4,13=> 4,14=> 4,15=> 4,16=> 4,17=> 4,18=> 4,                      -- 18-bit
              19=> 5,20=> 5,21=> 5,22=> 5,23=> 5,24=> 5,25=> 5,26=> 5,27=> 5,28=> 5,29=> 5,30=> 5,31=> 5,32=> 5,33=> 5,34=> 5,35=> 5,36=> 5     -- 36-bit
             --,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,    -- 72-bit
             -- 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6     -- 72-bit
              );

type t_emb_calc_prim is (
      p_dsp48e1,
      p_dsp48e,
      p_dsp48a1,
      p_dsp48a,
      p_dsp48,
      p_mult18s,
      p_mult18sio );

type t_family is
record
  emb_calc_prim   : t_emb_calc_prim;
  treat_as_s3adsp : boolean;
  has_fabric_dsp48: boolean;
  supports_dsp48e : boolean;
  lut6            : boolean;
  lut_depth       : integer;
  adder_max       : integer;
  bram_regs       : integer;
end record;  

function family_val( xdevicefamily: string) return t_family;

function select_rounding_const( round_mode   : integer;
                                accum_width  : integer;
                                output_width : integer  ) return std_logic_vector;

function sum_vals(in_array:t_int_array) return integer;

function max_val(in_array:t_int_array) return integer;

function next_nonzero(in_array:t_int_array; current_index: integer) return integer;

function prev_zero(in_array:t_int_array; current_index: integer) return integer;

function next_zero(in_array:t_int_array; current_index: integer) return integer;

function get_num_indp_paths(num_paths:integer;src:t_int_array) return integer;

function get_indp_paths(num_paths:integer;src:t_int_array) return t_int_array;

constant c_signed   : integer:=0;

constant c_unsigned : integer:=1;

constant c_area   : integer:=1;

constant c_speed  : integer:=0;--default, to achieve best speed results

constant c_srl16  :integer:=0;

constant c_bram   :integer:=1;

constant c_dram   :integer:=2;

constant c_regs   :integer:=3;--primarily for the delay blocks to implement as individual regsters, for multicolumn

constant c_preadd_add         : integer:=0;

constant c_preadd_sub         : integer:=1;

constant c_preadd_addsub      : integer:=2;

constant c_preadd_subadd      : integer:=3;

constant c_preadd_add_swapped : integer:=4;--Currently only for Sandia sr halfband

constant c_full_precision     : integer := 0;

constant c_truncate_lsbs      : integer := 1;

constant c_symmetric_zero     : integer := 2;

constant c_symmetric_inf      : integer := 3;

constant c_convergent_even    : integer := 4;

constant c_convergent_odd     : integer := 5;

constant c_non_symmetric_down : integer := 6;

constant c_non_symmetric_up   : integer := 7;

function lat_addsub(has_pre_reg:integer;has_mid_reg:integer;num_mid_reg:integer) return integer;

type t_emb_calc_func is (
                      PCIN,
                      PCIN_add_P,
                      PCIN_add_C,
                      NOP,
                      PCIN_add_A_mult_B,
                      A_mult_B,
                      P_add_A_mult_B,
                      C_add_A_mult_B,
                      P_add_A_concat_B,
                      P_add_P,
                      C_add_C,
                      PCIN_add_A_concat_B,
                      P_add_C,
                      A_concat_B,
                      C_add_A_concat_B,
                      C
                      );

type t_calc_func_used is array (t_emb_calc_func) of boolean;

type t_calc_func_list is array (integer range <>) of t_emb_calc_func;

constant num_calc_func_used:integer:=16;

constant calc_func_used_translate: t_calc_func_list(num_calc_func_used-1 downto 0):=(
    0 =>PCIN,
    1 =>PCIN_add_P,
    2 =>PCIN_add_C,
    3 =>NOP,
    4 =>PCIN_add_A_mult_B,
    5 =>A_mult_B,
    6 =>P_add_A_mult_B,
    7 =>C_add_A_mult_B,
    8 =>P_add_A_concat_B,
    9 =>P_add_P,
    10=>C_add_C,
    11=>PCIN_add_A_concat_B,
    12=>P_add_C,
    13=>A_concat_B,
    14=>C_add_A_concat_B,
    15=>C);

type t_emb_calc is
record
  family          : t_family;
  implementation  : integer;
  pre_add         : integer;
  pre_add_func    : integer;
  pre_add_ipreg   : integer;--only for when fabric adder
  pre_add_midreg  : integer;
  a_delay         : integer;
  b_delay         : integer;
  p_delay         : integer;--only supported when non-DSP48 family and post adder is split
  a_src           : integer;
  a_sign          : integer;
  b_sign          : integer;
  d_sign          : integer;
  reg_opcode      : integer;
  enable_pat_det  : boolean;
  -- gui trans_off
  pattern         : bit_vector(47 downto 0);
  mask            : bit_vector(47 downto 0);
  -- gui trans_on
  --resource_opt    : integer;
  post_add_width  : integer;
  calc_func_used  : t_calc_func_used;
  split_post_adder: boolean;
  has_redundant   : integer;
  a_width         : integer;
  b_width         : integer;
end record;

constant p_none       : integer:=0;

constant p_C          : integer:=1;

constant p_A_concat_B : integer:=2;

type t_emb_calc_array is array (integer range <>) of t_emb_calc;

type t_emb_calc_details is
record
  op_code_width    : integer;
  bin_width        : integer;
  extra_carry_bits : integer;
  --cin_sel_width:integer;
  pre_add_ipreg    : integer;
  pre_add_midreg   : integer;
  extra_b_dly      : integer;
  extra_a_dly      : integer;
  latency          : integer;
  pout_latency     : integer;
  pcin_latency     : integer;
end record;

type t_emb_calc_details_array is array (integer range <>) of t_emb_calc_details;

function dtls_emb_calc(param:t_emb_calc) return t_emb_calc_details;

function opcode_emb_calc(func:t_emb_calc_func;param:t_emb_calc) return std_logic_vector;

function funcs_emb_calc(func_list:t_calc_func_list) return t_calc_func_used;

function select_func_list(func_list1,func_list2:t_calc_func_list;sel: boolean) return t_calc_func_list;

function num_funcs(func_used:t_calc_func_used) return integer;

function get_funcs(func_used:t_calc_func_used) return t_calc_func_list;

function uses_PCIN(param:t_emb_calc) return boolean;

function uses_CIN(param:t_emb_calc) return boolean;

function uses_A_concat_B(param:t_emb_calc) return boolean;

function insert_redundant_bits(bus_in:std_logic_vector;param:t_emb_calc) return std_logic_vector;

type t_ram is
record
  family          : t_family;
  implementation  : integer;
  mem_type        : integer;--srl16=0 bram=1 dram=2
  write_mode      : integer;--only for bram/dram
  has_ce          : integer;--for subcores
  use_mif         : integer;
  resource_opt    : integer;
  is_rom          : boolean;
end record;

function lat_ram( param: t_ram; num_ports:integer) return integer;

type ramTypeMax is array (integer range <>) of std_logic_vector(768 downto 0);--(255 downto 0);

function ram_content(depth: integer; width: integer; use_mif: integer; mif_file:string) return ramTypeMax;

type t_lat_tap_memory_add_casc is
record
  data: integer;
  coef: integer;
end record;

type t_tap_memory_add_casc is
record
  family          : t_family;
  implementation  : integer;
  data_mem_type   : integer;
  coef_mem_type   : integer;
  data_comb       : integer;
  coef_comb       : integer;
  data_coef_comb  : integer;
  no_data_mem     : integer;
  coef_mem_depth  : integer;
  has_ce          : integer;
  coef_reload     : integer;
  coef_reload_depth : integer;
  symmetric       : integer;
  resource_opt    : integer;
end record;

function lat_tap_memory_add_casc( param: t_tap_memory_add_casc) return t_lat_tap_memory_add_casc;

type t_filt_arm_add_casc_outputs is ( p_P_OUT,
                                      p_PC_OUT,
                                      p_D_OUT,
                                      p_D_SYM_OUT,
                                      p_C_OUT,
                                      p_WE_OUT,
                                      p_WE_SYM_OUT,
                                      p_WE_SYM_OUT_2,
                                      p_ADDSUB_OUT,
                                      p_ADDSUP_OUT );

type t_filt_arm_add_casc_output_index is array (t_filt_arm_add_casc_outputs) of integer;

constant max_dsp_columns: integer:=15;--11;

constant max_dsps       : integer:=2016;--1056;

type t_split_col_len is array (max_dsp_columns-1 downto 0) of integer;

function str_to_posint(str_in:string) return integer;

function str_to_col_len(col_str:string) return t_split_col_len;

constant max_independant_col: integer:=32;

type t_indp_col_param is
record
  data_src    : t_int_array(max_independant_col-1 downto 0);
  data_width  : t_int_array(max_independant_col-1 downto 0);
  data_sign   : t_int_array(max_independant_col-1 downto 0);
  coef_src    : t_int_array(max_independant_col-1 downto 0);
  coef_width  : t_int_array(max_independant_col-1 downto 0);
  coef_sign   : t_int_array(max_independant_col-1 downto 0);
  pin_width   : t_int_array(max_independant_col-1 downto 0);
  cntrl_src   : t_int_array(max_independant_col-1 downto 0);
end record;

type t_filt_arm_add_casc is
record
  family          : t_family;
  implementation  : integer;
  num_taps        : integer;
  inter_we_cycles : integer;
  inter_tap_delay : integer;
  inter_sym_tap_delay : integer;
  symmetric       : integer;
  odd_symmetry    : integer;
  pre_add_func    : integer; --0=add,1=sub,2=addsub,3=subadd
  data_mem_type   : integer;
  coef_mem_type   : integer;
  data_comb       : integer;
  coef_comb       : integer;
  data_coef_comb  : integer;
  data_cascade    : integer;
  no_data_mem     : integer;
  data_dual       : integer;
  coef_mem_depth  : integer;
  data_mem_depth  : integer;
  p_src           : integer;
  has_ce          : integer;

  reload          : integer;
  reload_strms    : integer;
  reload_depth    : integer;

  -- gui trans_off
  output_index    : t_filt_arm_add_casc_output_index;
  output_src      : t_filt_arm_add_casc_output_index;
  -- gui trans_on

  num_split_col       : integer;
  inter_split_col_dly : integer;
  split_col_len       : t_split_col_len;

  dynamic_opcode      : integer;
  sym_para_struct     : integer;
  para_casc_we_src    : integer;
  resource_opt        : integer;
  datapath_mem_type   : integer;

  pat_det_tap_num     : integer;
  -- gui trans_off
  pattern             : bit_vector(47 downto 0);
  mask                : bit_vector(47 downto 0);
  -- gui trans_on

  dynamic_calc_func_used  : t_calc_func_used;
  split_adder_chain   : boolean;
  p_has_redundant     : boolean;

  num_independant_col : integer;
  indp_col_param      : t_indp_col_param;

  opt_mac             : t_int_array( max_dsps downto 1 );

  pcout_used          : boolean;
  next_c_used         : boolean;

end record;

type t_filt_arm_add_casc_tap_types is
record
    tap_1 : t_emb_calc;
    tap_x : t_emb_calc;
    tap_n : t_emb_calc;
end record;

type t_filt_arm_add_casc_tap_types_array is array (max_independant_col-1 downto 0) of t_filt_arm_add_casc_tap_types;

type t_lat_filt_arm_add_casc is
record
  --Config for architecture
  mem_x                 : t_tap_memory_add_casc;
  memory_path_lat       : t_lat_tap_memory_add_casc;
  config                : t_filt_arm_add_casc_tap_types_array;

  -- gui trans_off
  pc_width            : t_int_array(max_independant_col-1 downto 0);
  -- gui trans_on

  opt_dsp             : t_int_array( max_dsps downto 1 );

  --Top level feed back info
  cascaded              : integer;
  tap                   : integer;
  sym_inter_buff_depth  : integer;
  pre_add_ipreg         : integer;
  pre_add_midreg        : integer;
  coef_addr_extra_delay : integer;
  data_addr_extra_delay : integer;
  para_sym_slice_est    : integer;
  data_extra_reg        : integer;
  coef_extra_reg        : integer;
  -- gui insert_on
  -- num_datapath_bram         : integer;
  -- gui insert_off
end record;

function dtls_filt_arm_add_casc( param: t_filt_arm_add_casc) return t_lat_filt_arm_add_casc;

function count_col(cur_col:integer;col_len:t_split_col_len) return integer;

function calc_num_split_col(num_taps:integer;col_len:t_split_col_len) return integer;

type t_filt_arm_transpose is
record
  family          : t_family;
  implementation  : integer;
  num_taps        : integer;
  result_phasing  : integer;
  --used to indicate how many phase results exist on the filt arm
  cycles_per_op   : integer;
  data_mem_type   : integer;
  coef_mem_type   : integer;
  coef_comb       : integer;
  coef_mem_depth  : integer;
  data_mem_depth  : integer;
  no_data_mem     : integer;
  p_src           : integer;
  has_ce          : integer;
  num_filter_sets : integer;

  reload          : integer;
  reload_strms    : integer;
  reload_depth    : integer;

  -- gui trans_off
  output_index    : t_filt_arm_add_casc_output_index;
  output_src      : t_filt_arm_add_casc_output_index;
  -- gui trans_on

  num_split_col       : integer;
  inter_split_col_dly : integer;
  split_col_len       : t_split_col_len;

  data_fanout         : integer;

  dynamic_opcode      : integer;
  resource_opt        : integer;

  pat_det_tap_num     : integer;
  -- gui trans_off
  pattern             : bit_vector(47 downto 0);
  mask                : bit_vector(47 downto 0);
  round_const_lower : t_int_array(max_independant_col-1 downto 0);
  round_const_upper : t_int_array(max_independant_col-1 downto 0);
  apply_rounding      : boolean;
  -- gui trans_on

  dynamic_calc_func_used_broadcast  : t_calc_func_used;
  dynamic_calc_func_used_break  : t_calc_func_used;
  split_adder_chain   : boolean;
  p_has_redundant     : boolean;

  num_independant_col : integer;
  indp_col_param      : t_indp_col_param;
end record;

type t_filt_arm_transpose_tap_types is
record
    tap_b : t_emb_calc;
    tap_x : t_emb_calc;
    tap_1 : t_emb_calc;
end record;

type t_filt_arm_transpose_tap_types_array is array (max_independant_col-1 downto 0) of t_filt_arm_transpose_tap_types;

type t_dtls_filt_arm_transpose is
record
  --Config for architecture
  coef_ram              : t_ram;
  coef_ram_lat          : integer;
  data_ram              : t_ram;
  data_ram_lat          : integer;
  config                : t_filt_arm_transpose_tap_types_array;
  -- gui trans_off
  pc_width              : t_int_array(max_independant_col-1 downto 0);
  -- gui trans_on
  pout_lat_max          : integer;

  --Top level feed back info
  cascaded              : integer;
  tap                   : integer;
  coef_addr_extra_delay : integer;
  data_addr_extra_delay : integer;
end record;

function dtls_filt_arm_transpose( param: t_filt_arm_transpose) return t_dtls_filt_arm_transpose;

type t_counter_priority is (
          p_C0,
          p_C1,
          p_C2,
          p_not_C0_and_not_C1,
          p_C0_and_C1,
          p_C0_and_not_C1,
          p_C1_and_C2,
          p_C1_and_not_C2,
          p_not_C1_and_C2,
          p_C0_and_C2,
          p_C0_and_not_C2,
          p_C0_and_C1_and_C2,
          p_C0_and_C1_and_not_C2,
          p_C0_and_not_C1_and_C2,          
          p_C0_or_C1,
          p_C1_or_C2,
          p_C0_or_C2,
          p_C0_or_C1_or_C2,
          p_not_C1_or_C2,
          p_not_C0_and_not_C1_and_C2,
          p_decode );--can add more as required

function select_counter_priority(
         i0  : t_counter_priority;
         i1  : t_counter_priority;
         sel : boolean)
         return t_counter_priority;         

type t_counter_operation is (
          add_constant,
          sub_x_val,
          add_x_val);

type t_counter_clause is
record
  condition: t_counter_priority;
  operation: t_counter_operation;
  const_val: integer;
end record;

type t_counter_clause_array is array (integer range <>) of t_counter_clause;

function add_c( condition:t_counter_priority) return t_counter_clause;

function add_x( condition:t_counter_priority) return t_counter_clause;

function sub_x( condition:t_counter_priority) return t_counter_clause;

type t_casc_counters is
record
  cnt1_max_val    : integer;
  cnt2_max_val    : integer;
  cnt3_max_val    : integer;
  cnt2_max_qual   : integer;
  family          : t_family;
  implementation  : integer;
end record;

type t_data_address is
record
  family          : t_family;
  implementation  : integer;
  mem_type        : integer;
  base_cnt        : integer;
  block_cnt       : integer;
  symmetric       : integer;
  addr_width      : integer;
  sym_addr_width  : integer;
  combined        : integer;
  addr_packed     : integer;
  srl16_sequence  : integer;
  use_sym_cntrl   : integer;
  resource_opt    : integer;
  adv_sym         : integer;
  alt_rolling     : boolean;
  has_ce          : integer;

  en_dly          : integer;
  block_end_dly   : integer;
  last_block_dly  : integer;
  write_phase_dly : integer;
  sub_block_end_dly: integer;
end record;

function lat_data_address(param:t_data_address) return integer;

type t_rfd_gen is
record
  family          : t_family;
  implementation  : integer;
  cnt             : integer;
  cnt_long        : integer;
  has_nd          : integer;
end record;

type t_coef_address is
record
  family          : t_family;
  implementation  : integer;
  base_cnt        : integer;
  block_cnt       : integer;
  addr_packed     : integer;
  addr_width      : integer;
  num_filters     : integer;
  multi_page_reload : integer;
  offset          : integer;
  has_ce          : integer;
  use_count_src   : integer;
  en_dly          : integer;
  base_max_dly      : integer;
  skip_base_max_dly : integer;
  count_max_dly     : integer;
  filt_sel_dly      : integer;
  resource_opt      : integer;
end record;

function lat_coef_address(param:t_coef_address) return integer;

type t_twopage_address is
record
  family          : t_family;
  implementation  : integer;
  addr_width      : integer;
  page_size       : integer;
  num_enables     : integer;
end record;

type t_mod_counter is
record
  family          : t_family;
  implementation  : integer;
  base_val        : integer;
  step_val        : integer;
  latch_cnt_wrap  : integer;
  has_clr         : integer;
  has_init        : integer;
  init_val        : integer;
  clr_point       : integer;
end record;

type t_coef_reload_cntrl is
record
  family          : t_family;
  implementation  : integer;
  reload_base_cnt : integer;
  coef_addr_packed: integer;
  num_filts       : integer;
  coef_mem_depth  : integer;
  num_macs        : integer;
  has_hb          : integer;

  has_ce          : integer;
  coef_width      : integer;
  filt_sel_width  : integer;
  filt_sel_width_out : integer;
  reload_width    : integer;
  resource_opt    : integer;
  latch_filt_sel  : integer;
  --coef_mem_lat    : integer;
  extra_dly       : integer;
  num_reload_strms: integer;
  complete_after_update: integer;
end record;

type t_coef_reload_cntrl_lat is
record
  filt_sel_lat: integer;
  reload_lat  : integer;
end record;

function lat_coef_reload_cntrl(param:t_coef_reload_cntrl) return t_coef_reload_cntrl_lat;

--------------------------------------------------------------------------------
--From:  ../../hdl/mif_file/mif_file_pkg.vhd

constant max_coef_width      : integer := 50;--49;

type t_coefficients is array (natural range <>)
     of std_logic_vector (max_coef_width-1 downto 0);

function convert_bin_mif_to_hex (
         elab_dir   : string;
         mif_file   : string;
         num_taps   : integer;
         coef_width : integer;
         num_filts  : integer )
         return integer;

function read_coef_data (
         filename         : string;
         number_of_values : integer;
         coef_width       : integer;
         offset           : integer )
         return t_coefficients;

function read_coef_data_bin (
         filename         : string;
         number_of_values : integer;
         coef_width       : integer;
         offset           : integer )
         return t_coefficients;

function write_coef_data_hex (
         filename         : string;
         number_of_values : integer;
         coef_width       : integer;
         coef_data        : t_coefficients )
         return integer;

function write_coef_data (
         filename         : string;
         number_of_values : integer;
         coef_width       : integer;
         coef_data        : t_coefficients;
         append           : boolean:=false )
         return integer;

function get_number_of_inputs (
         filename: string )
         return integer;

function hex_to_std_logic_vector (
         hexstring : string;
         width     : integer )
         return std_logic_vector;

function std_logic_vector_to_hex (
         slv : std_logic_vector )
         return string;

--------------------------------------------------------------------------------
--From:  ../../hdl/da_elements/da_elements_pkg.vhd

--------------------------------------------------------------------------------
--From:  ../../hdl/da_elements/da_elements_pkg.vhd

--------------------------------------------------------------------------------
--From:  ../../hdl/da_elements/da_elements_pkg.vhd

function map_da_type ( type_in  : integer ) return integer;

function get_da_baat (
         filt_type    : integer;
         databits     : integer;
         clk_per_samp : integer;
         symmetry     : integer)
         return integer;

function map_da_rate (
         type_in     : integer;
         interp_rate : integer;
         decim_rate  : integer )
         return integer;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_elements_pkg.vhd

constant c_single_rate                : integer := 0;

constant c_polyphase_decimating       : integer := 1;

constant c_polyphase_interpolating    : integer := 2;

constant c_hilbert_transform          : integer := 3;

constant c_interpolated_transform     : integer := 4;

constant c_halfband_transform         : integer := 5;

constant c_decimating_half_band       : integer := 6;

constant c_interpolating_half_band    : integer := 7;

constant c_polyphase_pq               : integer := 9;--8;

constant c_interpolating_symmetry     : integer := 10;--9;

constant c_channelizer_receiver       : integer := 11;

constant c_transpose_single_rate      : integer := 12;

constant c_transpose_decimating       : integer := 13;

constant c_transpose_interpolating    : integer := 14;

constant c_channelizer_transmitter    : integer := 15;

constant c_polyphase_pq_dec_alt       : integer := 16;

constant c_mem_auto       : integer:=0;

constant c_mem_forced_dist : integer:=1;--dram or srl16

constant c_mem_forced_bram : integer:=2;

constant max_paths  : integer := max_independant_col; --this places a constraint on the core

constant max_taps   : integer :=4032;--for large P/Q rates

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_elements_pkg.vhd

type t_path_reqs is
record
  data_src    : t_int_array(max_paths-1 downto 0);
  data_width  : t_int_array(max_paths-1 downto 0);
  data_sign   : t_int_array(max_paths-1 downto 0);
  coef_src    : t_int_array(max_paths-1 downto 0);
  coef_width  : t_int_array(max_paths-1 downto 0);
  coef_sign   : t_int_array(max_paths-1 downto 0);
  accum_width : t_int_array(max_paths-1 downto 0);
  output_width: t_int_array(max_paths-1 downto 0);
  round_const_lower : t_int_array(max_paths-1 downto 0);
  round_const_upper : t_int_array(max_paths-1 downto 0);
end record;

type t_reqs is
record
  family              : t_family;
  filter_type         : integer;
  deci_rate           : integer;
  inter_rate          : integer;
  rate_type           : integer;
  num_taps            : integer;
  clk_per_samp        : integer;
  num_channels        : integer;
  chan_in_adv         : integer;
  num_filts           : integer;
  symmetry            : integer;
  neg_symmetry        : integer;
  zero_packing_factor : integer;
  coef_reload         : integer;
  data_width          : integer;
  coef_width          : integer;
  filt_sel_width      : integer;
  chan_width          : integer;
  round_mode          : integer;
  accum_width         : integer;
  output_width        : integer;
  allow_approx        : integer;
  data_mem_type       : integer;--0=auto 1=srl16/dram 2=bram
  coef_mem_type       : integer;
  ipbuff_mem_type     : integer;
  opbuff_mem_type     : integer;
  datapath_mem_type   : integer;
  data_sign           : integer;--1=unsigned 0=signed
  coef_sign           : integer;
  reg_output          : integer;
  has_nd              : integer;
  has_ce              : integer;
  has_sclr            : integer;
  has_chan0_in        : integer;
  has_data_valid      : integer;
  col_mode            : integer;
  -- col_1st_len         : integer;
  -- col_wrap_len        : integer;
  col_pipe_len        : integer;
  col_config          : t_split_col_len;
  resource_opt        : integer;
  fft_compatible_op   : integer;
  --Multi-path generics
  num_paths           : integer;
  path_reqs           : t_path_reqs;--_array(max_paths-1 downto 0);
  has_ext_output_src  : boolean;
  ext_src_delay       : integer;
  --Only applied to first multi-path
  has_ext_pat_det     : boolean;
  -- gui trans_off
  ext_pattern         : bit_vector(47 downto 0);
  ext_mask            : bit_vector(47 downto 0);
  -- gui trans_on
  sclr_determ         : integer;
end record;

type t_param is
record
  family              : t_family;
  filter_type         : integer;
  deci_rate           : integer;
  inter_rate          : integer;
  num_taps            : integer;
  clk_per_samp        : integer;
  num_channels        : integer;
  num_filts           : integer;
  symmetry            : integer;
  odd_symmetry        : integer;
  neg_symmetry        : integer;
  zero_packing_factor : integer;
  coef_reload         : integer;
  data_sign           : integer;--1=unsigned 0=signed
  coef_sign           : integer;
  single_mac          : integer;
  centre_mac          : integer;

  num_taps_calced     : integer;
  clk_per_chan        : integer;
  num_macs            : integer;
  base_count          : integer;
  base_data_space     : integer;
  base_coef_space     : integer;

  data_mem_depth      : integer;
  data_mem_type       : integer; --0=srl16 1=bram 2=dram
  datasym_mem_depth   : integer;
  datasym_mem_type    : integer;
  datasym_mem_offset  : integer;

  data_combined       : integer;
  data_packed         : integer;
  no_data_mem         : integer;
  full_parallel       : integer;

  coef_mem_depth      : integer;
  coef_mem_type       : integer;
  coef_mem_offset     : integer;
  coef_combined       : integer;
  coef_packed         : integer;

  data_coef_combined  : integer;

  num_paths           : integer;
  path_reqs           : t_path_reqs;

end record;

type t_reorder_info is
record
  combination : integer;
  paths       : integer;
  index_1     : integer;
  index_2     : integer;
  upper_dest  : t_int_array(1 downto 0);
  upper_src   : t_int_array(1 downto 0);
end record;

type t_reorder_info_array  is array (integer range <>) of t_reorder_info;

type t_gen_mif_status is
record
  OK          : boolean;
  num_opt_mac : integer;
  opt_mac     : t_int_array( max_dsps downto 1 );
  -- synthesis translate_off
  reorder_seq : t_reorder_info_array( max_taps-1 downto 0);
  -- synthesis translate_on
end record;

type t_mac_structures is (
  mac_fir_v5,
  single_rate,
  polyphase_decimation,
  polyphase_interpolation,
  polyphase_interpolation_symmetry,
  polyphase_pq_decimation,
  polyphase_pq_interpolation,
  hilbert,
  interpolated,
  halfband,
  halfband_decimation,
  halfband_interpolation,
  channelizer,
  extended_mult,
  transpose,
  polyphase_pq_decimation_alt
  );

type t_configuration is
record
  reqs: t_reqs;
  struct: t_mac_structures;
end record;

type t_split_wide_mif_accum is
record
  coef_sums_lower_bits:integer;
  coef_sums_upper_bits:integer;
end record;

type t_polyphase_decimation_sym_wrap is
record
  family            : t_family;
  implementation    : integer;
  base_count        : integer;
  num_phases        : integer;
  num_channels      : integer;
  sym_type          : integer;--0=even 1=odd
  driving_mem_type  : integer;
  driving_mem_lat   : integer;
  force_srl16_mem   : integer;
  has_ce            : integer;
  has_nd            : integer;
end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_elements_pkg.vhd

function memory_calcs(reqs:t_reqs;
                      ip_param: t_param;
                      data_depth_unpacked: integer;
                      data_depth_packed: integer;
                      data_depth_rolling: integer;
                      coef_depth_unpacked: integer;
                      coef_depth_packed: integer;
                      use_rolling : boolean;
                      mem_comb: boolean) return t_param;

function lat_polyphase_decimation_sym_wrap(param :  t_polyphase_decimation_sym_wrap) return integer;

function gen_mif_files ( elab_dir   : string;
                         gen_mif_prefix : string;
                         mif_file   : string;
                         param      : t_param;
                         gen_mif    : boolean;
                         gen_reload_seq : boolean )
                         return t_gen_mif_status;

function gen_pattern ( round_mode, accum_width, output_width : integer; doubled : boolean; width: integer ) return bit_vector;

function gen_mask ( accum_width, output_width : integer; doubled : boolean; width: integer ) return bit_vector;

function split_wide_mif ( file_name : string;
                          num_taps,
                          num_filts,
                          coef_width_in,
                          coef_path_max_width,
                          coef_path_0_extra_bit,
                          inter_rate,
                          deci_rate : integer;
                          gen_mif_files : boolean ) return t_split_wide_mif_accum;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_single_rate.vhd

  type t_define_single_rate is
  record
    param               : t_param;

    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    --Can't limit ranges to reqs.num_paths because this instantiation is
    --ported into the simulation packge the definition will break
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;

    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    we_sym_dly          : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_single_rate.vhd

  function define_single_rate(reqs:t_reqs;
                              elab_dir,
                              comp_name,
                              mif_file:string;
                              gen_mif: boolean;
                              gen_reorder_seq: boolean) return t_define_single_rate ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_decimation.vhd

  type t_define_decimation is
  record
    param               : t_param;

    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    accum_c_as_pcin     : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    output_buffer         : t_ram;
    output_buffer_in_addr : t_twopage_address;
    output_buffer_out_addr: t_twopage_address;
    output_rate_counter   : t_casc_counters;
    output_buffer_depth   : integer;
    output_buffer_lat     : integer;
    extra_opb_reg         : integer;
    has_output_buffer     : boolean;
    output_rate           : integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    use_c_port_as_storage : boolean;
    filter_sel_lat        : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc_array(max_paths-1 downto 0);
    rounder_delay         : integer;

    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
    wrap_over_param     : t_polyphase_decimation_sym_wrap;
    wrap_over_lat       : integer;
    para_sym_delay      : integer;
    para_sym_struct     : integer;
    para_sym_addr_delay : integer;
    add_sup_dly         : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    sample_latency      : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off

  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_decimation.vhd

  function define_decimation( reqs:t_reqs;
                              elab_dir,
                              comp_name,
                              mif_file:string;
                              gen_mif: boolean;
                              gen_reorder_seq: boolean) return t_define_decimation ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband.vhd

  type t_define_halfband is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    centre_tap_coef       : t_ram;
    centre_tap_coef_lat   : integer;
    centre_tap_coef_extra_reg: integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;

    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    we_sym_dly          : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband.vhd

  function define_halfband( reqs:t_reqs;
                                    elab_dir,
                                    comp_name,
                                    mif_file:string;
                                    gen_mif: boolean;
                                    gen_reorder_seq: boolean) return t_define_halfband ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_interpolated.vhd

  type t_define_interpolated is
  record
    param               : t_param;

    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;
    
    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    we_sym_dly          : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_interpolated.vhd

  function define_interpolated( reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_interpolated ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_hilbert.vhd

  type t_define_hilbert is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;
    
    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    we_sym_dly          : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_hilbert.vhd

  function define_hilbert(reqs:t_reqs;
                          elab_dir,
                          comp_name,
                          mif_file:string;
                          gen_mif: boolean;
                          gen_reorder_seq: boolean) return t_define_hilbert ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_interpolation.vhd

  type t_define_interpolation is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    reg_output            : integer;
    vector_cnt_len        : integer;

    --input buffer
    has_input_buffer      : boolean;
    input_buffer          : t_ram;
    input_buffer_in_addr  : t_twopage_address;
    input_buffer_depth    : integer;
    input_buffer_cntrl_dly: integer;
    input_buffer_lat      : integer;
    
    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	add_sup_dly         : integer;
    
    --General control values
    base_count_op_rate  : integer;
    shorter_px_time     : boolean;
    data_dly            : integer;
    addr_dly            : integer;
    filt_dly            : integer;
    data_dly_modifier   : integer;
    first_tap_extra_dly : integer;
    sing_chan_short_block: boolean;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_interpolation.vhd

  function define_interpolation(reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_interpolation ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband_decimation.vhd

  type t_define_halfband_decimation is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    reg_output            : integer;
    vector_cnt_len        : integer;

    --Center coef tap ram
    centre_tap_coef       : t_ram;
    centre_tap_coef_lat   : integer;
    centre_tap_coef_extra_reg: integer;
    
    --input buffer
    input_buffer          : t_ram;
    input_buffer_in_addr  : t_twopage_address;
    input_buffer_depth    : integer;
    input_buffer_lat      : integer;

    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    we_sym_dly          : integer;
    
    --General control values
    base_count_op_rate    : integer;
    shorter_px_time       : boolean;
    shorter_px_time_smac  : boolean;
    data_dly              : integer;
    addr_dly              : integer;
    filt_dly              : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband_decimation.vhd

  function define_halfband_decimation(reqs:t_reqs;
                                      elab_dir,
                                      comp_name,
                                      mif_file:string;
                                      gen_mif: boolean;
                                      gen_reorder_seq: boolean) return t_define_halfband_decimation ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband_interpolation.vhd

  type t_define_halfband_interpolation is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_details       : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    add_partial_prod      : t_emb_calc_array(max_paths-1 downto 0);
    add_partial_prod_dtls : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_extra_dly       : integer;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    shorter_px_time       : boolean;
    shorter_px_time_smac  : boolean;
    centre_tap_coef       : t_ram;
    centre_tap_coef_lat   : integer;
    centre_tap_coef_extra_reg: integer;
    
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    output_buffer         : t_ram;
    output_rate_counter   : t_casc_counters;
    output_buffer_depth   : integer;
    output_buffer_lat     : integer;
    output_rate           : integer;

    addr_hold_struct      : boolean;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;

    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    we_sym_dly          : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband_interpolation.vhd

  function define_halfband_interpolation( reqs:t_reqs;
                                          elab_dir,
                                          comp_name,
                                          mif_file:string;
                                          gen_mif: boolean;
                                          gen_reorder_seq: boolean) return t_define_halfband_interpolation ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_sympair_interpolation.vhd

  type t_define_sympair_interpolation is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_details       : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_lat           : integer;
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    data_addr_odd_phase_param : t_data_address;
    data_addr_odd_phase_lat   : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    output_buffer         : t_ram;
    output_rate_counter   : t_casc_counters;
    output_buffer_depth   : integer;
    output_buffer_lat     : integer;
    output_rate           : integer;
    has_output_buffer     : boolean;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    use_dsp_reg_as_storage : boolean;
    gen_extra_cycle       : boolean;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    use_doubled_rnd_const : boolean;
    rounder               : t_emb_calc_array(max_paths-1 downto 0);

    rounder_delay         : integer;

    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    odd_and_even        : integer;
    sym_calc_odd_sym    : integer;
    we_sym_dly          : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_sympair_interpolation.vhd

  function define_sympair_interpolation(reqs:t_reqs;
                                        elab_dir,
                                        comp_name,
                                        mif_file:string;
                                        gen_mif: boolean;
                                        gen_reorder_seq: boolean) return t_define_sympair_interpolation ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_interpolation.vhd

  type t_define_pq_interpolation is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    base_chan_param     : t_casc_counters;
    inter_param           : t_mod_counter;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    --input buffer
    has_input_buffer      : boolean;
    input_buffer          : t_ram;
    input_buffer_in_addr  : t_twopage_address;
    input_buffer_depth    : integer;
    input_buffer_cntrl_dly: integer;
    input_buffer_lat      : integer;

    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;

    add_sup_dly         : integer;

    --General control values
    base_count_op_rate  : integer;
    shorter_px_time     : boolean;
    data_dly            : integer;
    addr_dly            : integer;
    filt_dly            : integer;
    data_dly_modifier   : integer;
    first_tap_extra_dly : integer;
    pipeline_addr_en    : integer;
    no_addr_latch       : integer;
    no_nd_need_hold     : boolean;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_interpolation.vhd

  function define_pq_interpolation( reqs:t_reqs;
                                    elab_dir,
                                    comp_name,
                                    mif_file:string;
                                    gen_mif: boolean;
                                    gen_reorder_seq: boolean) return t_define_pq_interpolation ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_decimation.vhd

  type t_define_pq_decimation is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    accum_c_as_pcin     : boolean;
    base_inter_chan_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    output_buffer         : t_ram;
    output_buffer_in_addr : t_twopage_address;
    output_buffer_out_addr: t_twopage_address;
    output_rate_counter   : t_casc_counters;
    output_buffer_depth   : integer;
    output_buffer_lat     : integer;
    extra_opb_reg         : integer;
    has_output_buffer     : boolean;
    output_rate           : integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    use_c_port_as_storage : boolean;
    filter_sel_lat        : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    -- rounder               : t_emb_calc;
    rounder               : t_emb_calc_array(max_paths-1 downto 0);
    rounder_delay         : integer;
    
    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	cyc_to_data_out     : integer;
    cyc_to_write        : integer;
    num_cyc_read_earily : integer;
    extra_dly           : integer;
    change_src          : integer;
    add_sup_dly         : integer;
    
    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    sample_latency      : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_decimation.vhd

  function define_pq_decimation(reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_pq_decimation ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_decimation_alt.vhd

  type t_define_pq_decimation_alt is
  record
    param               : t_param;
    
    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    accum_req           : boolean;
    base_chan_param     : t_casc_counters;
    
    input_count_next_output : t_mod_counter;
    data_addr_lat         : integer;
    read_addr_dly         : integer;
    write_addr_dly        : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_threshold         : integer;
    addr_cntrl_lat        : integer;
    reg_output            : integer;
    vector_cnt_len        : integer;

    --input buffer
    input_buffer          : t_ram;
    input_buffer_depth    : integer;
    input_buffer_lat      : integer;
    
    --symmetric structure control
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;
  	add_sup_dly         : integer;
    
    --General control values
    base_count_op_rate  : integer;
    shorter_px_time     : boolean;
    data_dly            : integer;
    addr_dly            : integer;
    filt_dly            : integer;
    data_dly_modifier   : integer;
    first_tap_extra_dly : integer;
    sing_chan_short_block: boolean;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_decimation_alt.vhd

  function define_pq_decimation_alt(reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_pq_decimation_alt ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_extended_mult.vhd

  type t_define_extended_mult is
  record
    config      : t_configuration;
    data_paths  : integer;
    coef_paths  : integer;
    num_paths   : integer;
    adder       : t_emb_calc_array(2 downto 0);
    adder_dtls  : t_emb_calc_details_array(2 downto 0);
    four_path_mid_src1 : integer;
    four_path_mid_src2 : integer;
    path_1_weight : integer;
    path_2_weight : integer;
    path_3_weight : integer;
    path_comb_lat : integer;
    accum_widths  : t_int_array((max_independant_col/2)-1 downto 0);
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_extended_mult.vhd

  function define_extended_mult(reqs:t_reqs;
                                elab_dir:string;
                                comp_name: string;
                                mif_file: string;
                                gen_mif_files: boolean) return t_define_extended_mult ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_transpose.vhd

  type t_define_transpose is
  record
    param               : t_param;

    --blocks used in structure
    filt_arm            : t_filt_arm_transpose;
    filt_arm_lat        : t_dtls_filt_arm_transpose;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    p_extra_bits         : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;
    filter_sel_lat        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;
    
    -- other parameters
    coef_ram              : t_ram;
    coef_ram_lat          : integer;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;
    
    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_transpose.vhd

  function define_transpose(reqs:t_reqs;
                            elab_dir,
                            comp_name,
                            mif_file:string;
                            gen_mif: boolean;
                            gen_reorder_seq: boolean) return t_define_transpose ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_channelizer.vhd

  type t_define_channelizer is
  record
    param               : t_param;

    --blocks used in structure
    filt_arm            : t_filt_arm_add_casc;
    filt_arm_lat        : t_lat_filt_arm_add_casc;
    accum               : t_emb_calc_array(max_paths-1 downto 0);
    accum_lat           : t_emb_calc_details_array(max_paths-1 downto 0);
    --Can't limit ranges to reqs.num_paths because this instantiation is
    --ported into the simulation packge the definition will break
    accum_req           : boolean;
    base_chan_phase_param : t_casc_counters;
    data_addr_param       : t_data_address;
    data_addr_lat         : integer;
    coef_addr_param       : t_coef_address;
    coef_addr_lat         : integer;
    rfd_param             : t_rfd_gen;
    addr_cntrl_lat        : integer;
    shorter_px_time       : boolean;
    data_dly_modifier     : integer;
    first_tap_extra_dly   : integer;
    -- gui trans_off
    pcin_width            : t_int_array(max_paths-1 downto 0);
    -- gui trans_on
    reg_output            : integer;
    vector_cnt_len        : integer;

    -- Rounding parameters
    has_rounder           : boolean;
    cmux_required         : boolean;
    pinfb_dynamic         : boolean;
    pinfb_constant        : boolean;
    round_first_cycle     : boolean;
    round_spare_cycle     : boolean;
    use_approx            : boolean;
    use_rounder_cport     : boolean;
    use_rounder_pcin      : boolean;
    rounder               : t_emb_calc;
    rounder_delay         : integer;
    
    mem_param           : t_tap_memory_add_casc;
    memory_path_lat     : t_lat_tap_memory_add_casc;

    --reload
    reload_cntrl_param  :t_coef_reload_cntrl;
    reload_cntrl_param_lat: t_coef_reload_cntrl_lat;

    --Output buffer parameters
    buffer_config   : t_ram;
    buffer_depth   : integer;

    has_output_buffer     : boolean;
    output_buffer_in_addr : t_twopage_address;
    output_buffer_lat     : integer;
    extra_opb_reg         : integer;

    --Input buffer
    has_input_buffer     : boolean;
    input_buffer_in_addr : t_twopage_address;
    input_buffer_out_addr : t_twopage_address;
    input_buffer_lat     : integer;

    --Output delay, fully parallel
    has_output_delay      : boolean;

    --Core latency values
    latency             : integer;
    buffer_page_size    : integer;
    buffer_type         : integer; --0=none,1=ip,2=op

    -- synthesis translate_off
    reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
    -- synthesis translate_on

    -- gui insert_on
    -- num_bram            : integer;
    -- num_dsp             : integer;
    -- num_dsp_per_path    : integer;
    -- gui insert_off
  end record;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_channelizer.vhd

  function define_channelizer(reqs:t_reqs;
                              elab_dir,
                              comp_name,
                              mif_file:string;
                              gen_mif: boolean;
                              gen_reorder_seq: boolean) return t_define_channelizer ;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir.vhd

  function choose_structure(C_FAMILY            : string;
                            C_XDEVICEFAMILY     : string;
                            C_ELABORATION_DIR   : string;
                            C_COMPONENT_NAME    : string;
                            C_MEM_INIT_FILE     : string;
                            FILTER_TYPE         : integer;
                            INTERP_RATE         : integer;
                            DECIM_RATE          : integer;
                            RATE_CHANGE_TYPE    : integer;
                            ZERO_PACKING_FACTOR : integer;
                            NUM_CHANNELS        : integer;
                            CHAN_IN_ADV         : integer;
                            CHAN_SEL_WIDTH      : integer;
                            NUM_TAPS            : integer;
                            CLOCK_FREQ          : integer;
                            SAMPLE_FREQ         : integer;
                            FILTER_ARCH         : integer;
                            DATA_TYPE           : integer;
                            DATA_WIDTH          : integer;
                            COEF_TYPE           : integer;
                            COEF_WIDTH          : integer;
                            ROUND_MODE          : integer;
                            ACCUM_WIDTH         : integer;
                            OUTPUT_WIDTH        : integer;
                            ALLOW_APPROX        : integer;
                            OUTPUT_REG          : integer;
                            SYMMETRY            : integer;
                            ODD_SYMMETRY        : integer;
                            NEG_SYMMETRY        : integer;
                            COEF_RELOAD         : integer;
                            NUM_FILTS           : integer;
                            FILTER_SEL_WIDTH    : integer;
                            C_HAS_SCLR          : integer;
                            C_HAS_CE            : integer;
                            C_HAS_ND            : integer;
                            C_HAS_CHAN0_IN      : integer;
                            C_HAS_DATA_VALID    : integer;
                            DATA_MEMTYPE        : integer;
                            COEF_MEMTYPE        : integer;
                            IPBUFF_MEMTYPE      : integer;
                            OPBUFF_MEMTYPE      : integer;
                            DATAPATH_MEMTYPE    : integer;
                            COL_MODE            : integer;
                            -- COL_1ST_LEN         : integer;
                            -- COL_WRAP_LEN        : integer;
                            COL_PIPE_LEN        : integer;
                            COL_CONFIG          : string;
                            C_LATENCY           : integer;
                            C_RESOURCE_OPT      : integer;
                            XIL_FFT_COMPATIBLE  : integer;
                            NUM_PATHS           : integer;
                            SCLR_DETERMINISTIC  : integer)
                            return t_configuration ;

--------------------------------------------------------------------------------
--From:  ./model_pkg.vhd

constant c_da_symmetric : integer := 0;

constant c_da_non_symmetric : integer := 1;

constant c_da_neg_symmetric : integer := 2;

constant c_da_signed : integer := 0;

constant c_da_unsigned : integer := 1;

constant c_da_nrz : integer := 2;

constant c_da_single_rate_fir : integer := 0;

constant c_da_polyphase_interpolating : integer := 1;

constant c_da_polyphase_decimating : integer := 2;

constant c_da_hilbert_transform : integer := 3;

constant c_da_interpolated_fir : integer := 4;

constant c_da_half_band : integer := 5;

constant c_da_decimating_half_band : integer := 6;

constant c_da_interpolating_half_band : integer := 7;

constant c_da_no_reload : integer := 0;

constant c_da_stop_during_reload : integer := 1;

constant c_da_first_loader_write_delay_dist_memory : integer := 5;

constant c_da_first_loader_write_delay_block_memory : integer := 6;

constant c_da_number_clocks_per_lut : integer := 64;

constant c_da_reload_overhead_clock_cycles : integer := 1;

function bin_to_int (
         binstring : string;
         width     : integer;
         signed    : boolean )
         return integer;

FUNCTION get_gcd(x,y : INTEGER) RETURN INTEGER;

function calc_coe_width (
         c_family         : string;
         c_xdevicefamily  : string;
         filter_arch      : integer;
         filter_type      : integer;
         rate_change_type : integer;
         interp_rate      : integer;
         num_taps         : integer;
         symmetry         : integer;
         coef_type        : integer;
         coef_width       : integer  )
         return integer;

function get_da_fir_latency (
            filtertype    : integer;
            bitsatatime   : integer;
            datawidth     : integer;
            datatype      : integer;
            numbertaps    : integer;
            moderate      : integer;
            symmetric     : boolean;
            registeredout : boolean ) return integer;

function get_da_fir_AdderTreeLevel ( number: integer) return integer;

function get_da_fir_reloadDelay(
            filterType        : integer;
            dataWidth         : integer;
            baat              : integer;
            zeroPackingFactor : integer;
            numberChannels    : integer;
            numberTaps        : integer;
            modeRate          : integer;
            symmetric         : boolean;
            useBlockMemory    : boolean) return integer;

function get_da_fir_ClearDelay(
            filterType        : integer;
            dataWidth         : integer;
            symmetric         : boolean;
            blockMemory       : boolean;
            zeroPackingFactor : integer;
            baat              : integer;
            numberChannels    : integer ) return integer;

function get_da_fir_reloadDelay_sub(
            filterType        : integer;
            numberTaps        : integer;
            modeRate          : integer;
            symmetric         : boolean;
            useBlockMemory    : boolean) return integer;


end fir_compiler_v5_0_sim_pkg;

-------------------------------------------------------------------------------
package body fir_compiler_v5_0_sim_pkg is

--------------------------------------------------------------------------------
--From:  ../../hdl/toolbox/toolbox_pkg.vhd

function lat_addsub(has_pre_reg:integer;has_mid_reg:integer;num_mid_reg:integer) return integer is
  variable latency:integer:=1;
begin

  if has_pre_reg=1 then
    latency:=latency+1;
  end if;
  -- latency:=latency+has_pre_reg;

  if has_mid_reg=1 then
    latency:=latency+num_mid_reg;
  end if;

  return latency;

end;

function dtls_filt_arm_add_casc( param: t_filt_arm_add_casc) return t_lat_filt_arm_add_casc is

  variable details:t_lat_filt_arm_add_casc;

  variable tap_x_dtls,tap_x_dtls_max : t_emb_calc_details;
  constant srl16base_depth:integer:=param.family.lut_depth+1;--select_integer(17,33,has_lut6(param.family));
  variable tap_slices, pre_add_midreg_max,pout_latency_max: integer:=0;
  variable pre_add_lat, pout_lat: t_int_array(param.num_independant_col-1 downto 0);
  variable cport_used:boolean:=false;
  variable this_tap,prev_tap:integer;
  variable extra_coef_reg,extra_data_reg: integer:=0;
begin

  --Define filt arm add cascade configuration.
  details.mem_x:=(
    family           =>param.family,
    implementation   =>param.implementation,
    data_mem_type    =>param.data_mem_type,
    coef_mem_type    =>param.coef_mem_type,
    data_comb        =>select_integer(param.data_comb,2,param.data_dual=1),
    coef_comb        =>param.coef_comb,
    data_coef_comb   =>param.data_coef_comb,
    no_data_mem      =>param.no_data_mem,
    coef_mem_depth   =>param.coef_mem_depth,
    has_ce           =>param.has_ce,
    coef_reload      =>param.reload,
    coef_reload_depth=>param.reload_depth,
    symmetric        =>param.symmetric,
    resource_opt     =>param.resource_opt );

  details.memory_path_lat :=lat_tap_memory_add_casc(details.mem_x);

  --Path 0, defaults
  details.config(0).tap_1:=(
    family         => param.family,
    implementation => param.implementation,
    pre_add        => param.symmetric,
    pre_add_func   => param.pre_add_func,
    pre_add_ipreg  => select_integer(0,1,param.resource_opt=c_speed and param.data_mem_type=c_bram and param.no_data_mem=0),
    pre_add_midreg => select_integer(0,1,param.resource_opt=c_speed and param.indp_col_param.data_width(param.indp_col_param.data_src(0))>param.family.adder_max),--get_adder_max(param.family)
    a_delay        => 0,
    b_delay        => 0,
    p_delay        => 0,
    a_src          => 0,  --alway from fabric
    a_sign         => param.indp_col_param.data_sign(param.indp_col_param.data_src(0)),
    b_sign         => param.indp_col_param.coef_sign(param.indp_col_param.coef_src(0)),
    d_sign         => param.indp_col_param.data_sign(param.indp_col_param.data_src(0)),
    a_width        => param.indp_col_param.data_width(param.indp_col_param.data_src(0)),
    b_width        => param.indp_col_param.coef_width(param.indp_col_param.coef_src(0)),    
    reg_opcode     => select_integer(0,1,param.dynamic_opcode=1),
    enable_pat_det => param.pat_det_tap_num=1,
    -- gui trans_off
    pattern        => param.pattern,
    mask           => param.mask,
    -- gui trans_on
    split_post_adder => param.split_adder_chain,
    post_add_width => param.indp_col_param.pin_width(0),
    calc_func_used => funcs_emb_calc(
                        select_func_list(
                          (0=>C_add_A_mult_B),
                          get_funcs(param.dynamic_calc_func_used),
                          param.dynamic_opcode=1)),
    has_redundant => select_integer(p_none,p_C,param.p_src=0 and param.p_has_redundant)
    );

  details.config(0).tap_x                 :=details.config(0).tap_1;
  details.config(0).tap_x.a_delay         :=select_integer(0,1,param.data_cascade=1);
  details.config(0).tap_x.a_src           :=param.data_cascade;
  details.config(0).tap_x.enable_pat_det  :=false;
  details.config(0).tap_x.calc_func_used  :=funcs_emb_calc((0=>PCIN_add_A_mult_B));
  details.config(0).tap_x.has_redundant   :=p_none;

  details.config(0).tap_n                 :=details.config(0).tap_x;
  details.config(0).tap_n.enable_pat_det  :=param.pat_det_tap_num=param.num_taps;

  tap_x_dtls:=dtls_emb_calc(details.config(0).tap_x);
  tap_x_dtls_max:=tap_x_dtls;
  -- gui trans_off
  details.pc_width(0):=param.indp_col_param.pin_width(0)+tap_x_dtls.extra_carry_bits;
  -- gui trans_on
  pout_lat(0):=tap_x_dtls.pout_latency;
  pout_latency_max:=get_max(pout_latency_max,tap_x_dtls.pout_latency);
  pre_add_midreg_max:=get_max(pre_add_midreg_max,tap_x_dtls.pre_add_midreg);
  pre_add_lat(0):=tap_x_dtls.pre_add_midreg;
  
  for path in 1 to param.num_independant_col-1 loop
    details.config(path).tap_1                :=details.config(0).tap_1;
    details.config(path).tap_1.pre_add_midreg :=
      select_integer(0,1,param.resource_opt=c_speed and param.indp_col_param.data_width(param.indp_col_param.data_src(path))>param.family.adder_max);
    details.config(path).tap_1.a_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_1.b_sign         := param.indp_col_param.coef_sign(param.indp_col_param.coef_src(path));
    details.config(path).tap_1.d_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_1.a_width        := param.indp_col_param.data_width(param.indp_col_param.data_src(path));
    details.config(path).tap_1.b_width        := param.indp_col_param.coef_width(param.indp_col_param.coef_src(path));    
    details.config(path).tap_1.post_add_width := param.indp_col_param.pin_width(path);
    details.config(path).tap_x                :=details.config(0).tap_x;
    details.config(path).tap_x.pre_add_midreg :=
      select_integer(0,1,param.resource_opt=c_speed and param.indp_col_param.data_width(param.indp_col_param.data_src(path))>param.family.adder_max);
    details.config(path).tap_x.a_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_x.b_sign         := param.indp_col_param.coef_sign(param.indp_col_param.coef_src(path));
    details.config(path).tap_x.d_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_x.a_width        := param.indp_col_param.data_width(param.indp_col_param.data_src(path));
    details.config(path).tap_x.b_width        := param.indp_col_param.coef_width(param.indp_col_param.coef_src(path));    
    details.config(path).tap_x.post_add_width := param.indp_col_param.pin_width(path);
    details.config(path).tap_n                :=details.config(0).tap_n;
    details.config(path).tap_n.pre_add_midreg :=
      select_integer(0,1,param.resource_opt=c_speed and param.indp_col_param.data_width(param.indp_col_param.data_src(path))>param.family.adder_max);
    details.config(path).tap_n.a_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_n.b_sign         := param.indp_col_param.coef_sign(param.indp_col_param.coef_src(path));
    details.config(path).tap_n.d_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_n.a_width        := param.indp_col_param.data_width(param.indp_col_param.data_src(path));
    details.config(path).tap_n.b_width        := param.indp_col_param.coef_width(param.indp_col_param.coef_src(path));    
    details.config(path).tap_n.post_add_width := param.indp_col_param.pin_width(path);
    tap_x_dtls:=dtls_emb_calc(details.config(path).tap_x);
    -- gui trans_off
    details.pc_width(path):=param.indp_col_param.pin_width(path)+tap_x_dtls.extra_carry_bits;
    -- gui trans_on
    pout_lat(path):=tap_x_dtls.pout_latency;
    pout_latency_max:=get_max(pout_latency_max,tap_x_dtls.pout_latency);
    pre_add_midreg_max:=get_max(pre_add_midreg_max,tap_x_dtls.pre_add_midreg);
    pre_add_lat(path):=tap_x_dtls.pre_add_midreg;

    if tap_x_dtls.latency>tap_x_dtls_max.latency then
      tap_x_dtls_max:=tap_x_dtls;
    end if;

  end loop;

  --Check if paths need to balance preadder latency
  for path in 0 to param.num_independant_col-1 loop
    if pre_add_lat(path)< pre_add_midreg_max then
      details.config(path).tap_1.pre_add_ipreg:=details.config(path).tap_1.pre_add_ipreg+pre_add_midreg_max-pre_add_lat(path);
      details.config(path).tap_x.pre_add_ipreg:=details.config(path).tap_x.pre_add_ipreg+pre_add_midreg_max-pre_add_lat(path);
      details.config(path).tap_n.pre_add_ipreg:=details.config(path).tap_n.pre_add_ipreg+pre_add_midreg_max-pre_add_lat(path);
    end if;
    if pout_lat(path)< pout_latency_max then
      details.config(path).tap_n.p_delay:=pout_latency_max-pout_lat(path);
      if param.dynamic_opcode=1 and param.num_taps=1 then
        details.config(path).tap_1.p_delay:=details.config(path).tap_n.p_delay;
      end if;
    end if;
  end loop;
  
  --Determine which dsp48's can be skipped.
  details.opt_dsp:=param.opt_mac;
  if param.data_cascade=1 then
    --Can't optimise, dubious decision to use cascade.
    details.opt_dsp:=(others=>0);
  end if;
  if param.num_taps>1 then
    if param.pcout_used or
       (param.family.has_fabric_dsp48 and param.resource_opt=c_speed) then
      --can't optimise the last mac need back on P carry or need to reconstruct split cascade
      for path in 0 to param.num_independant_col-1 loop
        -- gui trans_off
        details.opt_dsp((param.indp_col_param.coef_src(path)+1)*param.num_taps):=0;
        -- gui trans_on
        -- gui insert_on
        -- details.opt_dsp(tcl_to_int((param.indp_col_param.coef_src(path)+1)*param.num_taps)):=0;
        -- gui insert_off
      end loop;
    end if;
    
    if param.family.emb_calc_prim=p_dsp48 then
      --when Virtex 4 then have to share C ports between adjenct dsp48s, puts a restriction on how often
      --a dsp48 can be optimised.
      for path in 0 to param.num_independant_col-1 loop
        if param.p_src=1 then --fabric to C port
          cport_used:=true;
        else
          cport_used:=false;
        end if;

        for tap in 2 to param.num_taps loop
          this_tap:=integer((param.indp_col_param.coef_src(path)*param.num_taps)+tap);  --VTFC compatibility
          prev_tap:=integer((param.indp_col_param.coef_src(path)*param.num_taps)+tap-1);

          --if details.opt_dsp((param.indp_col_param.coef_src(path)*param.num_taps)+tap)=1 and cport_used and details.opt_dsp((param.indp_col_param.coef_src(path)*param.num_taps)+tap-1)=0 then
          if details.opt_dsp(this_tap)=1 and cport_used and details.opt_dsp(prev_tap)=0 then
            --can't optimise this dsp as the previous tap used the C port and
            --the next dsp used will need the c port.
            -- gui trans_off
            details.opt_dsp((param.indp_col_param.coef_src(path)*param.num_taps)+tap):=0;
            -- gui trans_on
            -- gui insert_on
            -- details.opt_dsp(tcl_to_int((param.indp_col_param.coef_src(path)*param.num_taps)+tap)):=0;
            -- gui insert_off
            cport_used:=false;
          --elsif details.opt_dsp((param.indp_col_param.coef_src(path)*param.num_taps)+tap)=0 and details.opt_dsp((param.indp_col_param.coef_src(path)*param.num_taps)+tap-1)=1 then
          elsif details.opt_dsp(this_tap)=0 and details.opt_dsp(prev_tap)=1 then
            --previous tap optimised so the c port will be used.
            cport_used:=true;
          --elsif details.opt_dsp((param.indp_col_param.coef_src(path)*param.num_taps)+tap)=0 then
          elsif details.opt_dsp(this_tap)=0 then
            --not optimised and not following an optimisation so no c port
            cport_used:=false;
          end if;
        end loop;

        if cport_used and param.next_c_used and param.pcout_used then
          --can't optimise 2nd last tap
          details.opt_dsp((param.indp_col_param.coef_src(path)*param.num_taps)+param.num_taps-1):=0;
        end if;
      end loop;
    end if;
  end if;

  extra_coef_reg:=0;
  if param.coef_mem_depth>1 and
     param.resource_opt=c_speed and
     param.num_independant_col/get_num_indp_paths(param.num_independant_col,param.indp_col_param.coef_src)>1 and
     param.coef_mem_type=c_bram then
    --extra delay on coef path as BRAM are unable to drive multiple srcs
    extra_coef_reg:=1;
  end if;

  extra_data_reg:=0;
  if param.no_data_mem=0 and
     param.resource_opt=c_speed and
     param.num_independant_col/get_num_indp_paths(param.num_independant_col,param.indp_col_param.data_src)>1 and
     param.data_mem_type=c_bram then
    --extra delay on data path as BRAM are unable to drive multiple srcs
    extra_data_reg:=1;
  end if;

  details.data_extra_reg:=extra_data_reg;
  details.coef_extra_reg:=extra_coef_reg;

  --Calculate cascade latency
  details.cascaded:=param.num_taps-1+((param.num_split_col-1)*(param.inter_split_col_dly+1));

  --Calculate tap latency
  details.tap:=get_max(details.memory_path_lat.data+extra_data_reg,details.memory_path_lat.coef+extra_coef_reg)+tap_x_dtls_max.latency;

  --Feedback adder settings
  details.pre_add_ipreg:=tap_x_dtls_max.pre_add_ipreg;
  details.pre_add_midreg:=tap_x_dtls_max.pre_add_midreg;

  details.coef_addr_extra_delay:=tap_x_dtls_max.extra_b_dly;
  details.data_addr_extra_delay:=tap_x_dtls_max.extra_a_dly;

  --Add difference in ram latency to fedback offset as no longer applied on DSP48 i/p registers
  if (details.memory_path_lat.coef+extra_coef_reg)>(details.memory_path_lat.data+extra_data_reg) then
    details.data_addr_extra_delay:=details.data_addr_extra_delay+
                                   ((details.memory_path_lat.coef+extra_coef_reg)-(details.memory_path_lat.data+extra_data_reg));
  else
    details.coef_addr_extra_delay:=details.coef_addr_extra_delay+
                                   ((details.memory_path_lat.data+extra_data_reg)-(details.memory_path_lat.coef+extra_coef_reg));
  end if;

  --Calculate inter sym buffer depth for parallel symmetric structures
  details.sym_inter_buff_depth:=1;--this needs populated when nd parallel sym.
  if (param.no_data_mem=1 and param.sym_para_struct=1 and param.symmetric=1) then
    details.sym_inter_buff_depth:=(param.num_taps-1)*(param.inter_tap_delay-1);
  end if;
  if (param.no_data_mem=1 and param.sym_para_struct=3 and param.symmetric=1) then
    details.sym_inter_buff_depth:=(2*(param.num_taps-1)*(param.inter_tap_delay-1))+select_integer(0,param.inter_sym_tap_delay-1,param.odd_symmetry=0);
  end if;

  --Estimate slice utilisation for symmetric parallel structure
  details.para_sym_slice_est:=0;
  -- gui insert_on
  -- details.num_datapath_bram:=0;
  -- gui insert_off
  if (param.no_data_mem=1 and param.symmetric=1 and(param.sym_para_struct=1 or param.sym_para_struct=3)) then
    for tap in 1 to param.num_taps loop
      --other para structures est not supported.
      if param.sym_para_struct=1 then
        tap_slices:=((param.num_taps-tap)*(param.inter_sym_tap_delay-1));

        -- gui insert_on
        -- for path in 0 to param.num_independant_col-1 loop
        --   if param.indp_col_param.data_src(path)=path then
        --     details.num_datapath_bram:=details.num_datapath_bram+calc_delay_bram(param.indp_col_param.data_width(path),tap_slices,param.datapath_mem_type,param.family);
        --   end if;
        -- end loop;
        -- gui insert_off

        tap_slices:=(tap_slices/srl16base_depth)+select_integer(0,1,tap_slices rem srl16base_depth > 0);
        --above is LUT/MEM per bit for delay
        tap_slices:=tap_slices+1;--plus 1 for latch reg
        tap_slices:=tap_slices*param.indp_col_param.data_width(0);
        details.para_sym_slice_est:=details.para_sym_slice_est+tap_slices;
        --report "SLICE EST: tap: "&int_to_str(tap)&" est: "&int_to_str(tap_slices)&" accumed: "&int_to_str(latency.para_sym_slice_est);
      elsif param.sym_para_struct=3 then
        tap_slices:=(2*((param.num_taps-tap)*(param.inter_sym_tap_delay-1)))+select_integer(0,param.inter_sym_tap_delay-1,param.odd_symmetry=0);
        
        -- gui insert_on
        -- for path in 0 to param.num_independant_col-1 loop
        --   if param.indp_col_param.data_src(path)=path then
        --     details.num_datapath_bram:=details.num_datapath_bram+calc_delay_bram(param.indp_col_param.data_width(path),tap_slices,param.datapath_mem_type,param.family);
        --   end if;
        -- end loop;
        -- gui insert_off

        tap_slices:=(tap_slices/srl16base_depth)+select_integer(0,1,tap_slices rem srl16base_depth > 0);
        --above is LUT/MEM per bit for delay
        tap_slices:=tap_slices*param.indp_col_param.data_width(0);
        details.para_sym_slice_est:=details.para_sym_slice_est+tap_slices;
        --report "SLICE EST: tap: "&int_to_str(tap)&" est: "&int_to_str(tap_slices)&" accumed: "&int_to_str(latency.para_sym_slice_est);
      end if;
    end loop;
  end if;

  return details;
end;

function dtls_filt_arm_transpose( param: t_filt_arm_transpose) return t_dtls_filt_arm_transpose is

  variable details: t_dtls_filt_arm_transpose;

  variable tap_x_dtls,tap_x_dtls_max : t_emb_calc_details;
  variable pout_latency_max: integer:=0;
  variable pout_lat: t_int_array(param.num_independant_col-1 downto 0);
  variable extra_data_reg,
           extra_coef_reg: integer:=0;
begin

  --Ram parameters
  details.data_ram:=( family              => param.family,
                      implementation      => param.implementation,
                      mem_type            => param.data_mem_type,
                      write_mode          => 1,--write first
                      has_ce              => param.has_ce,
                      use_mif             => 0,
                      resource_opt        => param.resource_opt,
                      is_rom              => false );
  details.coef_ram:=( family              => param.family,
                      implementation      => param.implementation,
                      mem_type            => param.coef_mem_type,
                      write_mode          => 0,
                      has_ce              => param.has_ce,
                      use_mif             => 1,
                      resource_opt        => param.resource_opt,
                      is_rom              => param.reload=0 );

  details.data_ram_lat:=lat_ram(details.data_ram,1);
  if param.no_data_mem=1 then
    details.data_ram_lat:=0;
  end if;

  extra_data_reg:=0;
  if details.data_ram.mem_type=c_bram and param.resource_opt=c_speed and param.no_data_mem=0 then
    extra_data_reg:=1;
  end if;

  if param.coef_mem_depth=1 then
    details.coef_ram_lat:=0;
  elsif param.reload=1 or param.coef_comb=1 then
    details.coef_ram_lat:=lat_ram(details.coef_ram,2);
  else
    details.coef_ram_lat:=lat_ram(details.coef_ram,1);
  end if;
  
  extra_coef_reg:=0;
  if param.coef_mem_depth>1 and
     param.resource_opt=c_speed and
     param.num_independant_col/get_num_indp_paths(param.num_independant_col,param.indp_col_param.coef_src)>1 and
     param.coef_mem_type=c_bram then
    extra_coef_reg:=1;
  end if;

  --Path 0, defaults
  details.config(0).tap_x:=(
    family         => param.family,
    implementation => param.implementation,
    pre_add        => 0,
    pre_add_func   => c_preadd_add,
    pre_add_ipreg  => 0,
    pre_add_midreg => 0,
    a_delay        => 0,
    b_delay        => 0,
    p_delay        => 0,
    a_src          => 0,  --alway from fabric
    a_sign         => param.indp_col_param.data_sign(param.indp_col_param.data_src(0)),
    b_sign         => param.indp_col_param.coef_sign(param.indp_col_param.coef_src(0)),
    d_sign         => param.indp_col_param.data_sign(param.indp_col_param.data_src(0)),
    a_width        => param.indp_col_param.data_width(param.indp_col_param.data_src(0)),
    b_width        => param.indp_col_param.coef_width(param.indp_col_param.coef_src(0)),    
    reg_opcode     => select_integer(0,1,param.dynamic_opcode=1),
    enable_pat_det => false,
    -- gui trans_off
    pattern        => param.pattern,
    mask           => param.mask,
    -- gui trans_on
    split_post_adder => param.split_adder_chain,
    post_add_width => param.indp_col_param.pin_width(0),
    calc_func_used => funcs_emb_calc(
                        select_func_list(
                          (0=>PCIN_add_A_mult_B),
                          get_funcs(param.dynamic_calc_func_used_broadcast),
                          param.dynamic_opcode=1)),
    has_redundant => p_none
    );

  details.config(0).tap_1                 :=details.config(0).tap_x;
  details.config(0).tap_1.enable_pat_det  :=param.pat_det_tap_num=1;

  details.config(0).tap_b                 :=details.config(0).tap_x;
  details.config(0).tap_b.has_redundant   :=select_integer(p_none,p_C,param.split_adder_chain);

  if param.num_taps=1 then
    --in this case the tap_b parameters will be given to the single mac
    details.config(0).tap_b.enable_pat_det  :=param.pat_det_tap_num=1;
  end if;

  if param.dynamic_opcode=0 then
    details.config(0).tap_b.calc_func_used :=funcs_emb_calc((0=>C_add_A_mult_B));
  else
     details.config(0).tap_b.calc_func_used :=param.dynamic_calc_func_used_break;
  end if;

  tap_x_dtls:=dtls_emb_calc(details.config(0).tap_x);
  tap_x_dtls_max:=tap_x_dtls;
  -- gui trans_off
  details.pc_width(0):=param.indp_col_param.pin_width(0)+tap_x_dtls.extra_carry_bits;
  -- gui trans_on
  pout_lat(0):=tap_x_dtls.pout_latency;
  pout_latency_max:=get_max(pout_latency_max,tap_x_dtls.pout_latency);

  for path in 1 to param.num_independant_col-1 loop
    details.config(path).tap_1                :=details.config(0).tap_1;
    details.config(path).tap_1.a_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_1.b_sign         := param.indp_col_param.coef_sign(param.indp_col_param.coef_src(path));
    details.config(path).tap_1.d_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_1.a_width        := param.indp_col_param.data_width(param.indp_col_param.data_src(path));
    details.config(path).tap_1.b_width        := param.indp_col_param.coef_width(param.indp_col_param.coef_src(path));    
    details.config(path).tap_1.post_add_width := param.indp_col_param.pin_width(path);
    details.config(path).tap_x                :=details.config(0).tap_x;
    details.config(path).tap_x.a_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_x.b_sign         := param.indp_col_param.coef_sign(param.indp_col_param.coef_src(path));
    details.config(path).tap_x.d_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_x.a_width        := param.indp_col_param.data_width(param.indp_col_param.data_src(path));
    details.config(path).tap_x.b_width        := param.indp_col_param.coef_width(param.indp_col_param.coef_src(path));    
    details.config(path).tap_x.post_add_width := param.indp_col_param.pin_width(path);
    details.config(path).tap_b                :=details.config(0).tap_b;
    details.config(path).tap_b.a_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_b.b_sign         := param.indp_col_param.coef_sign(param.indp_col_param.coef_src(path));
    details.config(path).tap_b.d_sign         := param.indp_col_param.data_sign(param.indp_col_param.data_src(path));
    details.config(path).tap_b.a_width        := param.indp_col_param.data_width(param.indp_col_param.data_src(path));
    details.config(path).tap_b.b_width        := param.indp_col_param.coef_width(param.indp_col_param.coef_src(path));    
    details.config(path).tap_b.post_add_width := param.indp_col_param.pin_width(path);
    tap_x_dtls:=dtls_emb_calc(details.config(path).tap_x);
    -- gui trans_off
    details.pc_width(path):=param.indp_col_param.pin_width(path)+tap_x_dtls.extra_carry_bits;
    -- gui trans_on
    pout_lat(path):=tap_x_dtls.pout_latency;
    pout_latency_max:=get_max(pout_latency_max,tap_x_dtls.pout_latency);

    if tap_x_dtls.latency>tap_x_dtls_max.latency then
      tap_x_dtls_max:=tap_x_dtls;
    end if;
  end loop;

  --Check if paths need to balance p_out latency
  for path in 0 to param.num_independant_col-1 loop
    if pout_lat(path)< pout_latency_max then
      details.config(path).tap_1.p_delay:=pout_latency_max-pout_lat(path);
    end if;
  end loop;
  
  details.pout_lat_max:=pout_latency_max;

  --Calculate cascade latency
  if param.num_split_col=1 then
    details.cascaded:=((param.num_taps-1)/param.data_fanout);--+((param.num_split_col-1)*(param.inter_split_col_dly+1));
  else
    details.cascaded:=0;
    for col in 0 to param.num_split_col-1 loop
      if col/=param.num_split_col-1 then
        details.cascaded:=details.cascaded+( (param.split_col_len(col)-1)/param.data_fanout)+param.inter_split_col_dly+1;
      else
        details.cascaded:=details.cascaded+( (param.num_taps-count_col(col,param.split_col_len)-1)/param.data_fanout);
      end if;
    end loop;
  end if;

  --Calculate tap latency
  details.tap:=get_max(details.data_ram_lat+extra_data_reg,details.coef_ram_lat+extra_coef_reg)+tap_x_dtls_max.latency;

  details.coef_addr_extra_delay:=tap_x_dtls_max.extra_b_dly;
  details.data_addr_extra_delay:=tap_x_dtls_max.extra_a_dly;

  --Add difference in ram latency to fedback offset as no longer applied on DSP48 i/p registers
  if (details.coef_ram_lat+extra_coef_reg)>(details.data_ram_lat+extra_data_reg) then
    details.data_addr_extra_delay:=details.data_addr_extra_delay+
                                   ((details.coef_ram_lat+extra_coef_reg)-(details.data_ram_lat+extra_data_reg));
  else
    details.coef_addr_extra_delay:=details.coef_addr_extra_delay+
                                   ((details.data_ram_lat+extra_data_reg)-(details.coef_ram_lat+extra_coef_reg));
  end if;

  return details;

end;

function count_col(cur_col:integer;col_len:t_split_col_len) return integer is
  variable total:integer:=0;
begin
  if (cur_col>0) then
    for i in 0 to cur_col-1 loop
      total:=total+col_len(i);
    end loop;
  end if;

  return total;
end;

function calc_num_split_col(num_taps:integer;col_len:t_split_col_len) return integer is
  variable num_cols:integer:=0;
  variable tap_count:integer:=col_len(0);
begin
  while tap_count<num_taps and num_cols<max_dsp_columns-1 loop  --added to stop error in GUI
    num_cols:=num_cols+1;
    tap_count:=tap_count+col_len(num_cols);
  end loop;
  return num_cols+1;
end;

function lat_ram( param: t_ram; num_ports:integer) return integer is
begin
  if (param.mem_type=c_srl16) then
    return 1;--srl16, from address to dataout but from we to data out is really 2 cycles
  else
    if (num_ports=2) then
      if (param.mem_type=c_dram) then
        return 1;  --dram
      else
        -- if (param.family=s3 or param.family=s3a or param.family=s3e or param.family=v2) then-- and param.resource_opt=c_area then
          -- return 1;
        -- else
          -- return 2;  --bram
        -- end if;
        return param.family.bram_regs;
      end if;
    else
      if (param.mem_type=c_bram) then
        -- if (param.family=s3 or param.family=s3a or param.family=s3e or param.family=v2) then --and param.resource_opt=c_area then
          -- return 1;
        -- else
          -- return 2;  --bram
        -- end if;        
        return param.family.bram_regs;
      else
        --dram
        if (param.write_mode=1) then
          return 2;
        else
          return 1;
        end if;
      end if;
    end if;
  end if;
end;

function lat_tap_memory_add_casc( param: t_tap_memory_add_casc) return t_lat_tap_memory_add_casc is
  variable latency: t_lat_tap_memory_add_casc;
  constant data_ram_param: t_ram:=( family              => param.family,
                                    implementation      => param.implementation,
                                    mem_type            => param.data_mem_type,
                                    write_mode          => 1,--write first
                                    has_ce              => param.has_ce,
                                    use_mif             => 0,
                                    resource_opt        => param.resource_opt,
                                    is_rom              => false );

  constant coef_ram_param: t_ram:=( family              => param.family,
                                    implementation      => param.implementation,
                                    mem_type            => param.coef_mem_type,
                                    write_mode          => select_integer(0,1,
                                                              (param.data_coef_comb=1) ),
                                    has_ce              => param.has_ce,
                                    use_mif             => 1,
                                    resource_opt        => param.resource_opt,
                                    is_rom              => ((param.data_coef_comb=0 or param.no_data_mem=1) and
                                                            param.coef_reload=0 and
                                                            param.coef_comb=0 and
                                                            param.coef_mem_depth>1) );
begin

  --Data
  if param.no_data_mem=1 then
    latency.data:=0;
  elsif param.data_comb=2 then
    --dpr data ram
    latency.data:=lat_ram(data_ram_param,2);
    if param.data_mem_type=c_dram then
      --extra delay added to make first tap memory operate correctly as write first
      latency.data:=latency.data+1;
    end if;
  elsif param.data_comb=1 then
    --dp data ram
    latency.data:=lat_ram(data_ram_param,2);
  elsif param.data_coef_comb=1 then
    --dp data ram
    --latency.data:=lat_ram(coef_ram_param,2);
    latency.data:=lat_ram(data_ram_param,2);
  else
     --sp data ram
    latency.data:=lat_ram(data_ram_param,1);
  end if;

  --Coef
  if param.coef_reload=1 then
    if param.coef_mem_type=c_dram then
      --effectively sp
      --latency.coef:=lat_ram(coef_ram_param,1);
      latency.coef:=lat_ram(coef_ram_param,2);
    else
      --dp ram
      latency.coef:=lat_ram(coef_ram_param,2);
    end if;
  elsif param.data_coef_comb=1 then
    --dp coef ram
    latency.coef:=lat_ram(coef_ram_param,2);
  else
    --sp coef ram
    if param.coef_mem_depth>1 then
      latency.coef:=lat_ram(coef_ram_param,1);
    else
      --constant
      latency.coef:=0;
    end if;
  end if;

  return latency;
end;

function dtls_emb_calc(param:t_emb_calc) return t_emb_calc_details is
  variable details : t_emb_calc_details;
  variable a_dly,dly_on_a,b_dly: integer:=0;
  variable use_emb_preadd: boolean:=false;

  --For non-DSP48 implementation
  constant dynamic_opcode: boolean:=(num_funcs(param.calc_func_used)>1);
  constant split_adder_width  : integer := select_integer(param.post_add_width,param.family.adder_max,param.split_post_adder);
  constant num_adder_splits   : integer := param.post_add_width/split_adder_width + select_integer(0,1, param.post_add_width rem split_adder_width > 0);
  constant num_redundant_bits : integer := num_adder_splits-1;
  constant last_adder_length  : integer := select_integer(split_adder_width,param.post_add_width rem split_adder_width,param.post_add_width rem split_adder_width > 0);
  constant pcin_recomb : boolean:=(uses_PCIN(param) and dynamic_opcode and param.split_post_adder );

begin
  use_emb_preadd:=false;

  --NOTES:
  --This function and block have been changed to report the latency NOT including .a_delay and .b_delay. Delays due to the pre-adder
  --Are passed back via extra_b_dly parameter. Extra_a_dly has becomde redundant currently but will be left.

  --New check
  if param.a_src=1 and param.a_delay>1 then
    report "FAILURE: FIR Compiler v5.0: emb_calc cannot support a_delay>1 and uses the data cascade" severity failure;
  end if;

  --Latency
  details.latency:=0;
  details.pre_add_ipreg:=0;
  details.pre_add_midreg:=0;
  details.extra_b_dly:=0;
  details.pout_latency:=0;
  details.extra_a_dly:=0;
  details.pcin_latency:=0;

  --Default for dsp48 families
  details.extra_carry_bits:=48-param.post_add_width;

  case param.family.emb_calc_prim is
  when p_dsp48 | p_dsp48e | p_dsp48e1 =>
    
    if (param.pre_add=1) then
      if param.family.emb_calc_prim=p_dsp48e1 and
         (param.b_width<=18-param.b_sign) then
        --embedded pre add
        details.latency:=details.latency+1;
        use_emb_preadd:=true;
      else
        --fabric pre add
        details.latency:=details.latency+lat_addsub(param.pre_add_ipreg,param.pre_add_midreg,1);--lat_addsub(0);
        details.pre_add_ipreg:=param.pre_add_ipreg;
        details.pre_add_midreg:=param.pre_add_midreg;
      end if;
    end if;

    details.latency:=details.latency+3;--standard dly in dsp48
    
    if use_emb_preadd then
      a_dly:=1;
    else
      a_dly:=select_integer(0,lat_addsub(param.pre_add_ipreg,param.pre_add_midreg,1),
                            param.pre_add=1);
    end if;

    details.extra_b_dly:=a_dly;

  when p_dsp48a | p_dsp48a1 =>
    if (param.pre_add=1) then
      details.latency:=details.latency+1;
    end if;

    details.latency:=details.latency+3;

    --if param.b_delay=1 and param.pre_add=1 then
    if param.pre_add=1 then
      details.extra_b_dly:=1;
    end if;
  when others =>
    if (param.pre_add=1) then
      --fabric pre add
      details.latency:=details.latency+lat_addsub(param.pre_add_ipreg,param.pre_add_midreg,1);--lat_addsub(0);
      details.pre_add_ipreg:=param.pre_add_ipreg;
      details.pre_add_midreg:=param.pre_add_midreg;
    end if;

    --Multiplier+post_adder
    details.latency:=details.latency+2;

    --if (param.family=v2 or param.family=s3) and param.split_post_adder then
    if param.split_post_adder then
      --extra reg added to output of mult18's
      details.latency:=details.latency+1;
    end if;

    if param.family.emb_calc_prim=p_mult18sio then --param.family=s3a or param.family=s3e then
      --extra delay for mult_sio input regs
      details.latency:=details.latency+1;
    end if;

    --Delay to reconstruct pc_in delay
    if pcin_recomb then
      details.latency:=details.latency+num_adder_splits;--+1;
      details.pcin_latency:=num_adder_splits;
    end if;

    --reconstruction of p
    if param.split_post_adder then
      details.pout_latency:=num_adder_splits;
      details.extra_carry_bits:=num_redundant_bits;
    else
      details.extra_carry_bits:=0;
    end if;

    --Delays
    dly_on_a :=select_integer(
                 0,
                 lat_addsub(param.pre_add_ipreg,param.pre_add_midreg,1),-- -param.a_delay,
                 param.pre_add=1);

    details.extra_b_dly  := dly_on_a;
    details.extra_a_dly  := 0;

  -- when others =>
    -- null;
  end case;

  --Opcode width
  case param.family.emb_calc_prim is
  when p_dsp48 | p_dsp48e | p_dsp48e1 =>
    details.op_code_width:=7;
  when others =>
    details.op_code_width:=4;
  -- when others =>
    -- details.op_code_width:=1;
  end case;
  
  --BIN width
  if param.family.supports_dsp48e then --param.family=v5 or param.family=v6 then
    details.bin_width:=30;
  else
    details.bin_width:=18;
  end if;

  return details;
end;

function opcode_emb_calc(func:t_emb_calc_func;param:t_emb_calc) return std_logic_vector is
  constant details:t_emb_calc_details:=dtls_emb_calc(param);
  variable opcode:std_logic_vector(details.op_code_width-1 downto 0);
begin
  -- report "FIR Compiler v5.0: opcode_emb_calc: family: "&t_family'image(param.family)&" opcode: "&t_emb_calc_func'image(func) severity warning;
  case param.family.emb_calc_prim is
  when p_dsp48 | p_dsp48e | p_dsp48e1 =>
    case func is
      when PCIN =>
        opcode:="0010000";
      when PCIN_add_P =>
        opcode:="0010010";
      when PCIN_add_C =>
        opcode:="0011100";
      when NOP =>
        opcode:="0000010";--hold P
      when PCIN_add_A_mult_B =>
        opcode:="0010101";
      when A_mult_B =>
        opcode:="0000101";
      when P_add_A_mult_B =>
        opcode:="0100101";
      when C_add_A_mult_B =>
        opcode:="0110101";
      when P_add_A_concat_B =>
        opcode:="0100011";
      when P_add_P =>
        opcode:="0100010";
      when C_add_C =>
        opcode:="0111100";
      when PCIN_add_A_concat_B =>
        opcode:="0010011";
      when P_add_C =>
        opcode:="0101100";
      when A_concat_B =>
        opcode:="0000011";
      when C_add_A_concat_B =>
        opcode:="0110011";
      when C =>
        opcode:="0110000";
    end case;
  when others =>   --muxZ(3:2) & muxX(1:0)   ( does Z - X )
     case func is
      when PCIN =>
        opcode:="0100";
      when PCIN_add_P =>
        opcode:="0110";
      when PCIN_add_C =>
        opcode:="0000";--not supported
        -- report "FAILURE: FIR Compiler v5.0: Unsupported opcode for family" severity failure;
        report "FAILURE: FIR Compiler v5.0: Unsupported opcode for family" severity warning;
      when NOP =>
        opcode:="0010";
      when PCIN_add_A_mult_B =>
        opcode:="0101";
      when A_mult_B =>
        opcode:="0001";
      when P_add_A_mult_B =>
        opcode:="1001";
      when C_add_A_mult_B =>
        opcode:="1101";
      when P_add_A_concat_B =>
        opcode:="1011";
      when P_add_P =>
        opcode:="1010";
      when C_add_C =>
        opcode:="0000";--not supported
        -- report "FAILURE: FIR Compiler v5.0: Unsupported opcode for family" severity failure;
        report "FAILURE: FIR Compiler v5.0: Unsupported opcode for family" severity warning;
      when PCIN_add_A_concat_B =>
        opcode:="0111";
      when P_add_C =>
        opcode:="1110";
      when A_concat_B =>
        opcode:="0011";
      when C_add_A_concat_B =>
        opcode:="1111";
      when C =>
        opcode:="1100";
    end case;
  -- when others =>
    -- opcode:=(others=>'0');
  end case;

  return opcode;

end;

function funcs_emb_calc(func_list:t_calc_func_list) return t_calc_func_used is
  variable func_used:t_calc_func_used:=(others=>false);
begin
  for i in func_list'LOW to func_list'HIGH loop
    func_used(func_list(i)):=true;
  end loop;
  return func_used;
end;

function select_func_list(func_list1,func_list2:t_calc_func_list;sel: boolean) return t_calc_func_list is
begin
  if sel then
    return func_list2;
  else
    return func_list1;
  end if;
end;

function num_funcs(func_used:t_calc_func_used) return integer is
  variable cnt: integer:=0;
begin
  for i in 0 to num_calc_func_used-1 loop
    if func_used(calc_func_used_translate(i))=true then
      cnt:=cnt+1;
    end if;
  end loop;
  return cnt;
end;

function get_funcs(func_used:t_calc_func_used) return t_calc_func_list is
  variable return_list:t_calc_func_list(num_funcs(func_used)-1 downto 0);
  variable j:integer:=0;
begin
  for i in 0 to num_calc_func_used-1 loop
    if func_used(calc_func_used_translate(i))=true then
      return_list(j):=calc_func_used_translate(i);
      j:=j+1;
    end if;
  end loop;
  return return_list;
end;

function uses_PCIN(param:t_emb_calc) return boolean is
  variable opcode:std_logic_vector(select_integer(6,3,param.family.treat_as_s3adsp) downto 0);
  variable found: boolean:=false;
begin
  if not param.family.treat_as_s3adsp then
    return true;
    --no impact on anything
  else
    for i in 0 to num_calc_func_used-1 loop
      if param.calc_func_used(calc_func_used_translate(i))=true then
        case calc_func_used_translate(i) is
        when  PCIN |
              PCIN_add_P |
              PCIN_add_C |
              PCIN_add_A_mult_B |
              PCIN_add_A_concat_B =>
          found:=true;
        when others=>
          null;
        end case;
      end if;
    end loop;
    return found;
  end if;
end;

function uses_CIN(param:t_emb_calc) return boolean is
  variable found: boolean:=false;
begin
  if not param.family.treat_as_s3adsp then
    return true;
    --no impact on anything
  else
    for i in 0 to num_calc_func_used-1 loop
      if param.calc_func_used(calc_func_used_translate(i))=true then
        case calc_func_used_translate(i) is
        when  C_add_A_mult_B |
              PCIN_add_C |
              C_add_C |
              C_add_A_concat_B |
              C |
              P_add_C =>
          found:=true;
        when others=>
          null;
        end case;
      end if;
    end loop;
    return found;
  end if;
end;

function uses_A_concat_B(param:t_emb_calc) return boolean is
  variable found: boolean:=false;
begin
  for i in 0 to num_calc_func_used-1 loop
    if param.calc_func_used(calc_func_used_translate(i))=true then
      case calc_func_used_translate(i) is
      when  PCIN_add_A_concat_B |
            P_add_A_concat_B |
            A_concat_B |
            C_add_A_concat_B =>
        found:=true;
      when others=>
        null;
      end case;
    end if;
  end loop;
  return found;
end;

function insert_redundant_bits(bus_in:std_logic_vector;param:t_emb_calc) return std_logic_vector is

  variable dtls:t_emb_calc_details:=dtls_emb_calc(param);
  variable bus_ret:std_logic_vector(bus_in'HIGH-bus_in'LOW downto 0);
  variable adder_width:integer;
  variable src_bot,dest_bot:integer:=0;
begin
  bus_ret:=(others=>'0');
  if param.family.has_fabric_dsp48 and dtls.extra_carry_bits>0 and param.split_post_adder then
    adder_width:=param.family.adder_max;

    for i in 1 to dtls.extra_carry_bits loop
      -- report "dest_bot: "&int_to_str(dest_bot);
--       report "src_bot: "&int_to_str(src_bot);
      bus_ret( dest_bot+adder_width-1 downto dest_bot):=bus_in(src_bot+adder_width-1 downto src_bot);
      dest_bot:=dest_bot+adder_width+1;
      src_bot:=src_bot+adder_width;
    end loop;
    -- report "dest_bot: "&int_to_str(dest_bot);
--     report "src_bot: "&int_to_str(src_bot);
    bus_ret( dest_bot+((bus_in'HIGH-dtls.extra_carry_bits)-src_bot) downto dest_bot):=bus_in(bus_in'HIGH-dtls.extra_carry_bits downto src_bot);

    return bus_ret;
  else
    return bus_in;
  end if;
end;

function select_counter_priority(
         i0  : t_counter_priority;
         i1  : t_counter_priority;
         sel : boolean)
         return t_counter_priority is
begin
  if sel then
    return i1;
  else
    return i0;
  end if;
end;

function add_c( condition:t_counter_priority) return t_counter_clause is
  variable return_val:t_counter_clause;
begin
  return_val.condition:=condition;
  return_val.operation:=add_constant;
  return return_val;
end;

function add_x( condition:t_counter_priority) return t_counter_clause is
  variable return_val:t_counter_clause;
begin
  return_val.condition:=condition;
  return_val.operation:=add_x_val;
  return return_val;
end;

function sub_x( condition:t_counter_priority) return t_counter_clause is
  variable return_val:t_counter_clause;
begin
  return_val.condition:=condition;
  return_val.operation:=sub_x_val;
  return return_val;
end;

function lat_data_address(param:t_data_address) return integer is
  constant no_base:integer:=select_integer(0,1,param.base_cnt*param.block_cnt = 1);
  variable latency:integer;
begin
  if no_base=1 then
    --addr is not used in this scenario?
    if param.block_cnt>1 and param.srl16_sequence=1 then
      if param.mem_type=c_srl16 then
        latency:=2;
      else
        latency:=1;
      end if;
    else
      latency:=0;
    end if;
  elsif param.symmetric=1 then
    if param.mem_type>c_srl16 and param.addr_packed=2 and param.base_cnt/=1 then
      if param.block_cnt>1 and not param.alt_rolling then
        latency:=2;
      else
        latency:=1;
      end if;
    elsif param.mem_type>c_srl16 then
      if param.block_cnt>1 and (param.addr_packed=1 and not
                                                            ((is_pow_of_2(param.base_cnt) and param.combined=0) or
                                                             (is_pow_of_2(param.base_cnt) and
                                                              is_pow_of_2(param.block_cnt*param.base_cnt) and
                                                              param.combined=1)) ) then
        latency:=3;
      else
        latency:=2;
      end if;
    else
      latency:=1;
    end if;
  else
    if param.mem_type>c_srl16 and param.addr_packed=2 and param.base_cnt/=1 then
      if param.block_cnt>1 and not param.alt_rolling then
        latency:=2;
      else
        latency:=1;
      end if;
    elsif param.block_cnt>1 and (param.addr_packed=1 and not is_pow_of_2(param.base_cnt) and param.mem_type>c_srl16) then
      latency:=2;
    else
      if param.mem_type=c_srl16 and param.srl16_sequence=1 then
        latency:=2;
      else
        latency:=1;
      end if;
    end if;
  end if;

  if param.resource_opt=c_speed and param.family.treat_as_s3adsp then
    latency:=latency+1;
  end if;

  return latency;

end;

function lat_coef_address(param:t_coef_address) return integer is

  constant max_depth:integer:=param.family.lut_depth*2;--select_integer(32,64,has_lut6(param.family));

  constant effective_num_filters: integer:=integer(2**log2roundup(param.num_filters))*select_integer(1,2,param.multi_page_reload=1);

  constant decode_rom_param: t_ram:=( family              => param.family,
                                      implementation      => param.implementation,
                                      mem_type            => c_dram,
                                      write_mode          => 0,--read first
                                      has_ce              => param.has_ce,
                                      use_mif             => 1,
                                      resource_opt        => c_area,
                                      is_rom              => true );

  constant decode_rom_lat:integer:=lat_ram(decode_rom_param,1);--sp ram

  constant no_base:integer:=select_integer(0,1,param.base_cnt*param.block_cnt = 1);
  variable latency:integer;
begin
  if (effective_num_filters>1 and param.addr_packed=1) then
    if no_base=0 then
      latency:=decode_rom_lat+2;
    else
      latency:=decode_rom_lat+1;
    end if;
  else
    if no_base=0 then
      --return 1;
      latency:=1;
    else
      --return 0;
      latency:=0;
    end if;
  end if;

  if (param.resource_opt=c_speed and param.family.treat_as_s3adsp and not(effective_num_filters>1 and param.addr_packed=1)) then
    latency:=latency+1;
    if effective_num_filters>1 and no_base=1 then
      --special delay to get correct effect
      latency:=latency+1;
    end if;
  end if;

  return latency;
end;

function lat_coef_reload_cntrl(param:t_coef_reload_cntrl) return t_coef_reload_cntrl_lat is
  variable latency:t_coef_reload_cntrl_lat;

  constant srl16_mem_depth_thres: integer:=param.family.lut_depth*2;--select_integer(32,64,
                                                          -- has_lut6(param.family));
  constant dram_mem_depth_thres: integer:=param.family.lut_depth;--select_integer(16,32,
                                                         -- has_lut6(param.family));

  constant reload_base_cnt_param: t_casc_counters:=(
      cnt1_max_val    => 1,
      cnt2_max_val    => param.reload_base_cnt,
      cnt3_max_val    => 1,
      cnt2_max_qual   => 0,
      family          => param.family,
      implementation  => param.implementation );

  constant coef_reload_addr_param: t_coef_address:=(
      family          => param.family,
      implementation  => param.implementation,
      base_cnt        => param.reload_base_cnt,
      block_cnt       => 1,
      addr_packed     => param.coef_addr_packed,
      addr_width      => get_max(1,log2roundup( param.coef_mem_depth )),
      num_filters     => param.num_filts,--*2,
      multi_page_reload => 1,
      offset          => 0,
      has_ce          => param.has_ce,
      use_count_src   => 1,
      en_dly            => 0,
      base_max_dly      => 0,
      skip_base_max_dly => 0,
      count_max_dly     => 0,
      filt_sel_dly      => 0,
      resource_opt      => param.resource_opt);

  constant coef_reload_addr_lat: integer:=lat_coef_address(coef_reload_addr_param);

  constant page_ram: t_ram:=(
          family              => param.family,
          implementation      => param.implementation,
          mem_type            => c_dram,
          write_mode          => 0,--read first
          has_ce              => param.has_ce,
          use_mif             => 0,
          resource_opt        => c_area,
          is_rom              => false );


  constant page_ram_lat:integer:=lat_ram(page_ram,2);


begin
    latency.filt_sel_lat:=2;
    latency.reload_lat:=1+coef_reload_addr_lat;
  return latency;
end;

function ram_content(depth: integer; width: integer; use_mif: integer; mif_file:string) return ramTypeMax is
  variable ram_init    : ramTypeMax(0 to depth-1):=(others=>(others=>'0'));
  file     filepointer : text;-- open read_mode is filename;
  variable mif_status  : file_open_status;
  variable lines       : integer := 0;
  variable dataline    : line;
  --variable binvector   : bit_vector(width-1 downto 0);
  -- variable strvector   : string(1 to width);
  variable slvvector   : std_logic_vector(width-1 downto 0);
  variable read_from_line_OK : boolean;
begin
  if use_mif=0 or use_mif=2 then
    ram_init:=(others=>(others=>'0'));
    if use_mif=2 then
      ram_init:=(others=>(others=>'1'));
    end if;
  else
    file_open(mif_status,filepointer,mif_file,read_mode);

    while (not(endfile(filepointer)) and (lines < depth)) loop
      readline(filepointer, dataline);
      exit when endfile(filepointer);
      --read(dataline, binvector);
      -- read(dataline, strvector);
      read(dataline, slvvector);
      --ram_init(lines)(width-1 downto 0):=to_stdlogicvector(binvector);
      -- ram_init(lines)(width-1 downto 0):=str_to_slv(strvector);
      ram_init(lines)(width-1 downto 0):=slvvector;
      lines:=lines+1;
    end loop;

    file_close(filepointer);
  end if;

  return ram_init;
end;

function ext_bus(input_bus: std_logic_vector; width:integer; sign: integer) return std_logic_vector is
variable return_bus: std_logic_vector(width-1 downto 0);
--constant input_width:integer:=input_bus'high + 1 - input_bus'low;
constant input_width:integer:=input_bus'LENGTH;
variable input_bus_int: std_logic_vector(input_width-1 downto 0);
begin
  input_bus_int:=input_bus;
  
  if ( input_width< width ) then
    --extend or pad
    return_bus(input_width-1 downto 0):=input_bus_int;

    if (sign=c_signed) then --signed
      --extend remaing bits with sign
      return_bus((width-1) downto input_width) := (others=>input_bus_int(input_bus_int'high));
    else            --unsigned
      --pad remaing bits with 0
      return_bus((width-1) downto input_width) := (others=>'0');
    end if;

  elsif (input_width=width) then
    --same width
    return_bus := input_bus_int;
  else
    --larger
    return_bus := input_bus_int(width-1 downto 0);--input_bus((width-1)+input_bus'low downto input_bus'low);
  end if;

  return return_bus;
end;

function select_integer (
         i0  : integer;
         i1  : integer;
         sel : boolean)
         return integer is
begin
  if sel then
    return i1;
  else
    return i0;
  end if; -- sel
end select_integer;

function select_int_array (
         i0  : t_int_array;
         i1  : t_int_array;
         sel : boolean)
         return t_int_array is
begin
  if sel then
    return i1;
  else
    return i0;
  end if; -- sel
end select_int_array;

function select_string (
         i0  : string;
         i1  : string;
         sel : boolean)
         return string is
begin
  if sel then
    return i1;
  else
    return i0;
  end if; -- sel
end select_string;

function select_slv (
         i0  : std_logic_vector;
         i1  : std_logic_vector;
         sel : boolean)
         return std_logic_vector is
begin
  if sel then
    return i1;
  else
    return i0;
  end if; -- sel
end select_slv;

function select_sl (
         i0  : std_logic;
         i1  : std_logic;
         sel : boolean)
         return std_logic is
begin
  if sel then
    return i1;
  else
    return i0;
  end if; -- sel
end select_sl;

function bmg2v1_bram_prim_sel(width:integer;depth:integer) return integer is
variable widthOK: integer;
begin

  widthOK:=width;
  
  if widthOK>v4_bram_depth'LENGTH then
    widthOK:=v4_bram_depth'LENGTH;
  end if;

  while widthOK>0 loop
    if (v4_bram_depth(widthOK)>=depth) then
      return bmg2v1_bram_prim(widthOK);
    else
      widthOK:=widthOK-1;
    end if;
  end loop;
  
  return bmg2v1_bram_prim(1);--return deepest primative

end bmg2v1_bram_prim_sel;

function str_ext(src:string;dest_len:integer) return string is
  variable fill_str:string(dest_len downto 1);
begin
  fill_str(src'HIGH downto 0):=src;
  return fill_str;
end str_ext;

function split_bus( index:integer; bus_in:std_logic_vector; bus_width:t_int_array) return std_logic_vector is
  variable return_bus:std_logic_vector(bus_width(index+bus_width'LOW)-1 downto 0);
  variable index_bottom:integer:=0;
begin
  -- report "FIR: split_bus: index: "&int_to_str(index);
--   report "FIR: split_bus: num_buses: "&int_to_str(bus_width'HIGH-bus_width'LOW+1);

  if (index<=bus_width'HIGH-bus_width'LOW+1) then

    if (index>0) then
      for i in 0 to index-1 loop
        index_bottom:=index_bottom+bus_width(i+bus_width'LOW);
      end loop;
    end if;

    return_bus:=bus_in(bus_width(index+bus_width'LOW)+index_bottom-1+bus_in'LOW downto index_bottom+bus_in'LOW);

  else
  end if;

  return return_bus;
end;

function is_pow_of_2(val:integer) return boolean is
  variable pow:integer:=0;
begin
  while integer(2**pow) <= val loop
    if integer(2**pow) = val then
      return true;
    end if;
    pow:=pow+1;
  end loop;
  return false;
end;

function slv_to_string (
         bitsin : std_logic_vector;
         nbits  : integer)
         return string is
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
      assert false
        report "NOTE   : FIR Compiler v5.0: invalid character passed to ";
        report "FAILURE: FIR Compiler v5.0: slv_to_string function."
        severity failure;
    end if;

    bit_num := bit_num + 1;

    if bit_num > nbits then
      EXIT; -- Ignore ms bits in SLV if SLV is longer than string
    end if;
  end loop;

  return ret;

end;

function string_to_slv (
         bitsin : string;
         nbits  : integer)
         return std_logic_vector is

  -- string types range from 1 to len!!!
  variable ret     : std_logic_vector(nbits-1 downto 0);
  variable bit_num : integer;
begin

  ret := (others => '0');

  if (bitsin'LENGTH = 0) then -- Make all '0's
    return ret;
  end if;

  bit_num := 0;

  for i in bitsin'high downto bitsin'low loop

    if bitsin(i) = '1' then
      ret(bit_num) := '1';
    elsif bitsin(i) = '0' then
      ret(bit_num) := '0';
    elsif (bitsin(i) = 'U' or bitsin(i) = 'u') then
      ret(bit_num) := 'U';
    elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
      ret(bit_num) := 'X';
    elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
      ret(bit_num) := 'Z';
    elsif (bitsin(i) = 'W' or bitsin(i) = 'w') then
      ret(bit_num) := 'W';
    elsif (bitsin(i) = 'L' or bitsin(i) = 'l') then
      ret(bit_num) := 'L';
    elsif (bitsin(i) = 'H' or bitsin(i) = 'h') then
      ret(bit_num) := 'H';
    elsif (bitsin(i) = '-') then
      ret(bit_num) := '-';
    else
      assert false
        report "NOTE   : FIR Compiler v5.0: invalid character passed to string_to_std_logic_vector function.";
        report "FAILURE: FIR Compiler v5.0: string passed in was: " & bitsin
        severity failure;
    end if;

    bit_num := bit_num + 1;

    if bit_num >= nbits then
      EXIT; -- Ignore ms characters in string if string is longer than BV
    end if;
  end loop;

  return ret;

end;

function family_val( xdevicefamily: string) return t_family is
  variable family_dtls: t_family;
begin
  family_dtls.supports_dsp48e:=false;
  if derived(xdevicefamily,"spartan6") then
    family_dtls.emb_calc_prim   :=p_dsp48a1;
    family_dtls.treat_as_s3adsp  :=true;
    family_dtls.has_fabric_dsp48:=false;
    family_dtls.lut6            :=true;
    family_dtls.lut_depth       :=32;
    family_dtls.adder_max       :=8;--leave as 8 as same Fmax target
    family_dtls.bram_regs       :=2;
  elsif derived(xdevicefamily,"spartan3adsp") then
    family_dtls.emb_calc_prim   :=p_dsp48a;
    family_dtls.treat_as_s3adsp  :=true;
    family_dtls.has_fabric_dsp48:=false;
    family_dtls.lut6            :=false;
    family_dtls.lut_depth       :=16;
    family_dtls.adder_max       :=8;
    family_dtls.bram_regs       :=2;
  elsif derived(xdevicefamily,"spartan3a") then
    family_dtls.emb_calc_prim   :=p_mult18sio;
    family_dtls.treat_as_s3adsp  :=true;
    family_dtls.has_fabric_dsp48:=true;
    family_dtls.lut6            :=false;
    family_dtls.lut_depth       :=16;
    family_dtls.adder_max       :=8;
    family_dtls.bram_regs       :=1;
  elsif derived(xdevicefamily,"spartan3e") then
    family_dtls.emb_calc_prim   :=p_mult18sio;
    family_dtls.treat_as_s3adsp  :=true;
    family_dtls.has_fabric_dsp48:=true;
    family_dtls.lut6            :=false;
    family_dtls.lut_depth       :=16;
    family_dtls.adder_max       :=8;
    family_dtls.bram_regs       :=1;
  elsif derived(xdevicefamily,"spartan3") or derived(xdevicefamily,"virtex2") then
    family_dtls.emb_calc_prim   :=p_mult18s;
    family_dtls.treat_as_s3adsp  :=true;
    family_dtls.has_fabric_dsp48:=true;
    family_dtls.lut6            :=false;
    family_dtls.lut_depth       :=16;
    family_dtls.adder_max       :=8;    
    family_dtls.bram_regs       :=1;
  elsif derived(xdevicefamily,"virtex6") then
    family_dtls.emb_calc_prim   :=p_dsp48e1;
    family_dtls.treat_as_s3adsp  :=false;
    family_dtls.has_fabric_dsp48:=false;
    family_dtls.lut6            :=true;
    family_dtls.lut_depth       :=32;
    family_dtls.adder_max       :=12;
    family_dtls.bram_regs       :=2;
    family_dtls.supports_dsp48e :=true;
  elsif derived(xdevicefamily,"virtex5") then
    family_dtls.emb_calc_prim   :=p_dsp48e;
    family_dtls.treat_as_s3adsp  :=false;
    family_dtls.has_fabric_dsp48:=false;
    family_dtls.lut6            :=true;
    family_dtls.lut_depth       :=32;
    family_dtls.adder_max       :=12;
    family_dtls.bram_regs       :=2;
    family_dtls.supports_dsp48e :=true;
  elsif derived(xdevicefamily,"virtex4") then
    family_dtls.emb_calc_prim   :=p_dsp48;
    family_dtls.treat_as_s3adsp  :=false;
    family_dtls.has_fabric_dsp48:=false;
    family_dtls.lut6            :=false;
    family_dtls.lut_depth       :=16;
    family_dtls.adder_max       :=12;
    family_dtls.bram_regs       :=2;  
  else
    --Any future families, essientially V6 configuration
    family_dtls.emb_calc_prim   :=p_dsp48e1;
    family_dtls.treat_as_s3adsp  :=false;
    family_dtls.has_fabric_dsp48:=false;
    family_dtls.lut6            :=true;
    family_dtls.lut_depth       :=32;
    family_dtls.adder_max       :=12;
    family_dtls.bram_regs       :=2;
    family_dtls.supports_dsp48e :=true;
  end if;

  return family_dtls;

end;

function select_rounding_const( round_mode   : integer;
                                accum_width  : integer;
                                output_width : integer  ) return std_logic_vector is

  variable round_const : std_logic_vector(accum_width-1 downto 0) := (others=>'0');

begin

  case round_mode is
    when c_full_precision      => round_const := (others=>'0');
    when c_truncate_lsbs       => round_const := (others=>'0');
    when c_symmetric_zero      => round_const(accum_width-output_width-2 downto 0) := (others=>'1');
    when c_symmetric_inf       => round_const(accum_width-output_width-2 downto 0) := (others=>'1');
    when c_convergent_even     => round_const(accum_width-output_width-1         ) := '1';
    when c_convergent_odd      => round_const(accum_width-output_width-2 downto 0) := (others=>'1');
    when c_non_symmetric_down  => round_const(accum_width-output_width-2 downto 0) := (others=>'1');
    when c_non_symmetric_up    => round_const(accum_width-output_width-1         ) := '1';
    when others                => report "WARNING: FIR Compiler v5.0: Unsupported rounding mode specified!";
  end case;

  return round_const;

end;

function sum_vals(in_array:t_int_array) return integer is
  variable ret_val: integer:=0;
begin
  for i in in_array'RANGE loop
    ret_val:=ret_val+in_array(i);
  end loop;
  return ret_val;
end;

function max_val(in_array:t_int_array) return integer is
  variable ret_val: integer:=0;
begin
  for i in in_array'RANGE loop
    ret_val:=get_max(ret_val,in_array(i));
  end loop;
  return ret_val;
end;

function bus_high(index: integer;bus_widths:t_int_array) return integer is
begin
--   report "index: "&int_to_str(index);
  return sum_vals(bus_widths(index downto 0))-1;
end;

function bus_low(index: integer;bus_widths:t_int_array) return integer is
begin
  return sum_vals(bus_widths(index downto 0))-bus_widths(index);
end;

function add_const(in_array:t_int_array; const:integer) return t_int_array is
  variable out_array:t_int_array(in_array'RANGE):=in_array;
begin
  for i in out_array'RANGE loop
    out_array(i):=out_array(i)+const;
  end loop;
  return out_array;
end;

function next_nonzero(in_array:t_int_array; current_index: integer) return integer is
  variable in_array_int:t_int_array(in_array'LENGTH-1 downto 0);
begin
  in_array_int:=in_array;
  for i in current_index+1 to in_array_int'LENGTH-1 loop
    if in_array_int(i)>0 then
      return i;
    end if;
  end loop;
  return -1;
end;

function next_zero(in_array:t_int_array; current_index: integer) return integer is
begin
  for i in current_index+1+in_array'LOW to in_array'HIGH loop
    if in_array(i)=0 then
      return i-in_array'LOW;
    end if;
  end loop;
  return -1;
end;

function prev_zero(in_array:t_int_array; current_index: integer) return integer is
  variable relative_array:t_int_array(in_array'LENGTH downto 1):=in_array;
begin
--   report "prev_zero: "&int_to_str(current_index)&" src: "&int_to_str(in_array'LOW)&" "&int_to_str(in_array'HIGH);
--   report "prev_zero: "&int_to_str(current_index)&" rel: "&int_to_str(relative_array'LOW)&" "&int_to_str(relative_array'HIGH);
  if current_index>relative_array'LOW then
    --for i in current_index-1+in_array'LOW downto in_array'LOW loop
    for i in current_index-1 downto relative_array'LOW loop
--       report "i: "&int_to_str(i);
      if relative_array(i)=0 then
--         report "ret: "&int_to_str(i);--i-in_array'LOW);
        return i;--i-in_array'LOW;
      end if;
    end loop;
  end if;
  return relative_array'LOW-1;-- -1;
end;

function get_num_indp_paths(num_paths:integer;src:t_int_array) return integer is
  variable count:integer:=0;
begin
  --Need this function for VTFC compatibility
  for i in 0 to num_paths-1 loop
    if src(i)=i then
      count:=count+1;
    end if;
  end loop;
  return count;
end;

function get_indp_paths(num_paths:integer;src:t_int_array) return t_int_array is
  variable indp_paths:t_int_array(get_num_indp_paths(num_paths,src)-1 downto 0);
  variable num_indp_paths:integer:=0;
begin
  for i in 0 to num_paths-1 loop
    if src(i)=i then
      num_indp_paths:=num_indp_paths+1;
      indp_paths(num_indp_paths-1):=i;
    end if;
  end loop;
  return indp_paths;
end;

function str_to_posint(str_in:string) return integer is
  variable calc_integer: integer:=0;
  variable col_weight: integer:=1;
begin
  for i in str_in'RIGHT downto str_in'LEFT loop
    --start in 1's column
    -- report "NOTE: FIR Compiler v5.0: str_to_posint: character: "&str_in(i);
    case str_in(i) is
    when '0' => calc_integer:=calc_integer;--unnecessary but in for completeness
    when '1' => calc_integer:=calc_integer+col_weight;
    when '2' => calc_integer:=calc_integer+(2*col_weight);
    when '3' => calc_integer:=calc_integer+(3*col_weight);
    when '4' => calc_integer:=calc_integer+(4*col_weight);
    when '5' => calc_integer:=calc_integer+(5*col_weight);
    when '6' => calc_integer:=calc_integer+(6*col_weight);
    when '7' => calc_integer:=calc_integer+(7*col_weight);
    when '8' => calc_integer:=calc_integer+(8*col_weight);
    when '9' => calc_integer:=calc_integer+(9*col_weight);
    when others => report "ERROR: FIR Compiler v5.0: str_to_posint: Invalid character: "&str_in severity failure;
    end case;
    col_weight:=col_weight*10;
  end loop;
  -- report "NOTE: FIR Compiler v5.0: str_to_posint input: "&str_in&" output: "&integer'image(calc_integer);
  return calc_integer;
end;

function str_to_col_len(col_str:string) return t_split_col_len is
  variable cols:t_split_col_len:=(others=>0);
  variable last_index:integer:=1;
  variable col_index:integer:=0;
  -- gui insert_on
  -- variable top,bottom,str_i: integer:=0;
  -- variable base_str:string(1 to 10);
  -- gui insert_off
begin
  for str_index in col_str'LOW to col_str'HIGH loop
    if col_str(str_index)=',' or str_index=col_str'HIGH then
      --cols(col_index):=integer'value(col_str(last_index to str_index-select_integer(0,1,col_str(str_index)=',')));
      -- gui trans_off   
      cols(col_index):=str_to_posint(col_str(last_index to str_index-select_integer(0,1,col_str(str_index)=',')));
      -- gui trans_on
      -- gui insert_on
      -- bottom:=last_index;
      -- top:=str_index-select_integer(0,1,col_str(str_index)=',');
      -- str_i:=1;
      -- base_str:="          ";
      -- for i in bottom to top loop
        -- base_str(str_i):=col_str(i);
        -- str_i:=str_i+1;
      -- end loop;
      -- cols(col_index):=str_to_posint(base_str);
      -- gui insert_off
      
      last_index:=str_index+1;
      col_index:=col_index+1;      
    end if;
  end loop;
  --duplicate last column length into remaing columns, this duplicates previous behaviour and acts as a bit of extra robustness
  
  -- gui trans_off        
  cols(max_dsp_columns-1 downto col_index):=(others=>cols(col_index-1));
  -- gui trans_on
  -- gui insert_on
  -- for i in max_dsp_columns-1 downto col_index loop
    -- cols(i):=cols(col_index-1);
  -- end loop;
  -- gui insert_off
  
  return cols;
end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mif_file/mif_file_pkg.vhd

function convert_bin_mif_to_hex (
         elab_dir   : string;
         mif_file   : string;
         num_taps   : integer;
         coef_width : integer;
         num_filts  : integer )
         return integer is
         
variable coefficients : t_coefficients(num_filts*num_taps-1 downto 0);

variable write_res : integer;

constant elab_mif_file : string := elab_dir & mif_file;

begin

  -- Check number of entries in input mif file
  if (get_number_of_inputs(elab_mif_file) < num_taps*num_filts) then
  -- Changed for XST, getnuminput seemed to return one more than in file

    report "FAILURE: FIR Compiler v5.0: input binary mif file has incorrect number of values" severity failure;

  else

    -- Fetch all the binary coefficients from the mif file
    coefficients(num_filts*num_taps-1 downto 0) :=
                     read_coef_data_bin( elab_mif_file,
                                         num_taps*num_filts,
                                         coef_width,
                                         0);

    -- Create filenames for mac mif files and mif files
    write_res := write_coef_data_hex( elab_dir
                                    & "hex_" 
                                    & mif_file,
                                      num_taps*num_filts,
                                      coef_width,
                                      coefficients         );

  end if;

  return 1; -- convert_bin_mif_to_hex;
end;

function read_coef_data ( filename         : string;
                          number_of_values : integer;
                          coef_width       : integer;
                          offset           : integer )
                          return t_coefficients is

  variable data        : t_coefficients(number_of_values-1 downto 0);
  file     filepointer : text;-- open read_mode is filename;
  variable dataline    : line;
  -- variable bv          : bit_vector(coef_width-1 downto 0);
  -- variable sv          : string(1 to coef_width);
  variable slv         : std_logic_vector(coef_width-1 downto 0);
  variable lines       : integer := 0;
  variable mif_status  : file_open_status;

begin

  file_open(mif_status,filepointer,filename,read_mode);

  while (not(endfile(filepointer)) and (lines < number_of_values+offset)) loop
    readline(filepointer, dataline);
    -- read(dataline, bv);
    -- read(dataline, sv);
    read(dataline, slv);
    if (lines>(offset-1)) then
      -- data(lines-offset)(coef_width-1 downto 0) := to_stdlogicvector(bv);
      -- data(lines-offset)(coef_width-1 downto 0) := str_to_slv(sv);
      data(lines-offset)(coef_width-1 downto 0) := slv;
    end if;
    lines := lines + 1;
  end loop;

  file_close(filepointer);

  return data;

end read_coef_data;

function read_coef_data_bin ( filename         : string;
                              number_of_values : integer;
                              coef_width       : integer;
                              offset           : integer )
                              return t_coefficients is

  variable data        : t_coefficients(number_of_values-1 downto 0);
  file     filepointer : text;-- open read_mode is filename;
  variable dataline    : line;
  variable binstring   : string(1 to coef_width);
  variable bitval      : std_logic_vector((coef_width-1) downto 0);
  variable lines       : integer := 0;
  variable mif_status  : file_open_status;

begin

  file_open(mif_status,filepointer,filename,read_mode);
  
  while (not(endfile(filepointer)) and (lines < number_of_values+offset)) loop
    readline(filepointer, dataline);
    read(dataline, binstring);
    
    if (lines>(offset-1)) then
      data(lines-offset)(coef_width-1 downto 0) := string_to_slv(binstring,coef_width);
    end if;
    lines := lines + 1;
  end loop;
  
  file_close(filepointer);
  
  return data;
end read_coef_data_bin;

function write_coef_data_hex ( filename         : string;
                               number_of_values : integer;
                               coef_width       : integer;
                               coef_data        : t_coefficients )
                               return integer is

  file     filepointer : text;
  variable mif_status  : file_open_status;
  constant hexlength   : integer := (coef_width+3)/4;
  variable hex_string  : string(1 to hexlength);
  variable write_line  : line;
  variable bitchar     : character;

begin

  file_open(mif_status,filepointer,filename,write_mode);

  for loc in 0 to number_of_values-1 loop
    hex_string := std_logic_vector_to_hex(coef_data(loc)(coef_width-1 downto 0));
    write(write_line,hex_string);
    writeline(filepointer,write_line);
  end loop;

  file_close(filepointer);

  return 0;
end write_coef_data_hex;

function write_coef_data ( filename         : string;
                           number_of_values : integer;
                           coef_width       : integer;
                           coef_data        : t_coefficients;
                           append           : boolean:=false )
                           return integer is

  file     filepointer: text;
  variable mif_status  : file_open_status;
  variable write_line: line;
  variable write_line_slv: std_logic_vector((coef_width - 1) downto 0);
  --The variable below is used to get Verfic file writing working, as it doesn't seem to be able to embedded a function
  --call to generate the string it will output.
  -- variable write_line_str: string(1 to coef_width);
begin

  if append then
    file_open(mif_status,filepointer,filename,append_mode);
  else
    file_open(mif_status,filepointer,filename,write_mode);
  end if;

  for loc in 0 to number_of_values-1 loop
    --write_line_slv:=std_logic_vector'(coef_data(loc)(coef_width-1 downto 0));
    write_line_slv:=coef_data(loc)(coef_width-1 downto 0);
    -- write_line_str:=slv_to_str(write_line_slv);
    --write(write_line,to_bitvector(write_line_slv));
    -- write(write_line,write_line_str);
    write(write_line,write_line_slv);
    writeline(filepointer,write_line);
    
    -- write(write_line,test);
    -- writeline(filepointer,write_line);
  end loop;

  file_close(filepointer);

  return 0;
end write_coef_data;

function get_number_of_inputs(filename: string) return integer is
file     inpfile    : text;-- open read_mode is filename;
variable oneline    : line;
variable decvalue   : integer;
variable count      : integer := 0;
variable mif_status  : file_open_status;

begin
--         report "*** get_number_of_inputs ***" severity note;
--         report "MIF_FILE : " & filename severity note;

        file_open(mif_status,inpfile,filename,read_mode);

        while (not(endfile(inpfile))) loop
                readline(inpfile, oneline);
                count := count + 1;
        end loop;
        
        file_close(inpfile);
        return count;
end get_number_of_inputs;

function hex_to_std_logic_vector( hexstring: string; width: integer) RETURN std_logic_vector IS

constant length   : integer := hexstring'length;
variable bitval   : std_logic_vector(((length*4) - 1) downto 0);
variable posn     : integer := ((length * 4) - 1);
variable ch       : character;

begin
  -- initialize the return std_logic_vector to all 0's
  bitval := (others => '0');
  -- loop through each character and convert to the equivalent hex bits
  for i in 1 to length loop
    ch := hexstring(i);
    case ch is
      when '0'        => bitval(posn downto posn - 3) := "0000";
      when '1'        => bitval(posn downto posn - 3) := "0001";
      when '2'        => bitval(posn downto posn - 3) := "0010";
      when '3'        => bitval(posn downto posn - 3) := "0011";
      when '4'        => bitval(posn downto posn - 3) := "0100";
      when '5'        => bitval(posn downto posn - 3) := "0101";
      when '6'        => bitval(posn downto posn - 3) := "0110";
      when '7'        => bitval(posn downto posn - 3) := "0111";
      when '8'        => bitval(posn downto posn - 3) := "1000";
      when '9'        => bitval(posn downto posn - 3) := "1001";
      when 'A' | 'a'  => bitval(posn downto posn - 3) := "1010";
      when 'B' | 'b'  => bitval(posn downto posn - 3) := "1011";
      when 'C' | 'c'  => bitval(posn downto posn - 3) := "1100";
      when 'D' | 'd'  => bitval(posn downto posn - 3) := "1101";
      when 'E' | 'e'  => bitval(posn downto posn - 3) := "1110";
      when 'F' | 'f'  => bitval(posn downto posn - 3) := "1111";
      when others     => assert false
        report "ERROR: FIR Compiler v5.0: invalid hex value." severity error;
        bitval(posn downto posn - 3) := "XXXX";
     end case;
     posn := posn - 4;
  end loop;

  return bitval(width-1 downto 0);--for when width not divable by 4 get lower bits

end hex_to_std_logic_vector;

function std_logic_vector_to_hex( slv: std_logic_vector ) RETURN string IS

constant hexlength : integer := (slv'length+3)/4;
variable hexval    : string(1 to hexlength);
variable bitval    : std_logic_vector((4*hexlength - 1) downto 0);
variable posn      : integer := 4*hexlength-1;
variable slv4      : std_logic_vector(3 downto 0);
variable nibble    : string(1 to 4);

begin

  -- Initialize the temporary std_logic_vector to all 0's
  bitval := (others => '0');
  -- then overload slv to LSBs
  bitval(slv'length-1 downto 0) := slv;
  
  -- loop through each nibble and convert to the equivalent hex char
  for i in 1 to hexlength loop
    slv4   := bitval(posn downto posn-3);
    nibble := slv_to_string(slv4,4);
    case nibble is
      when "0000" => hexval(i):= '0';
      when "0001" => hexval(i):= '1';
      when "0010" => hexval(i):= '2';
      when "0011" => hexval(i):= '3';
      when "0100" => hexval(i):= '4';
      when "0101" => hexval(i):= '5';
      when "0110" => hexval(i):= '6';
      when "0111" => hexval(i):= '7';
      when "1000" => hexval(i):= '8';
      when "1001" => hexval(i):= '9';
      when "1010" => hexval(i):= 'A';
      when "1011" => hexval(i):= 'B';
      when "1100" => hexval(i):= 'C';
      when "1101" => hexval(i):= 'D';
      when "1110" => hexval(i):= 'E';
      when "1111" => hexval(i):= 'F';
      when others => assert false
        report "ERROR: FIR Compiler v5.0: invalid binary value." severity error;
        hexval(i) := 'X';
     end case;
     posn := posn-4;
  end loop;

  return hexval;

end std_logic_vector_to_hex;

--------------------------------------------------------------------------------
--From:  ../../hdl/da_elements/da_elements_pkg.vhd

function map_da_type ( type_in  : integer ) return integer is
  variable type_out : integer;
begin

  type_out := type_in; -- Generally its a direct mapping

  -- Swap round interpolating and decimating cases
  -- This is only being done for safety, should be synchronized in future
  -- releases after VHDL DA FIR core is developed
  if type_in = c_polyphase_interpolating then
    type_out := c_polyphase_decimating;
  elsif type_in = c_polyphase_decimating then
    type_out := c_polyphase_interpolating;
  end if;
  
  return type_out;
  
end map_da_type;

function get_da_baat (
         filt_type    : integer;
         databits     : integer;
         clk_per_samp : integer;
         symmetry     : integer)
         return integer is

  variable bits : integer := 0;
  variable baat : integer := 0;

begin
  
  if symmetry = 0
  or filt_type = c_polyphase_interpolating
  or filt_type = c_interpolating_half_band  then
    bits := databits;
  else
    bits := databits + 1;
  end if;
  
  if ( clk_per_samp = 1 ) then
    baat := databits; -- PDA case
  else
    baat := ( bits + (clk_per_samp - 1) ) / clk_per_samp;
  end if;
  
  return baat;
  
end get_da_baat;

function map_da_rate (
         type_in     : integer;
         interp_rate : integer;
         decim_rate  : integer )
         return integer is
  variable rate_out : integer;
begin

  if    ( type_in=c_polyphase_interpolating
       or type_in=c_interpolating_symmetry  ) then
    rate_out := interp_rate;
  elsif ( type_in=c_polyphase_decimating ) then
    rate_out := decim_rate;
  elsif ( type_in=c_interpolating_half_band
       or type_in=c_decimating_half_band) then
    rate_out := 2;
  else
    rate_out := 1;
  end if;

  return rate_out;
  
end map_da_rate;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_elements_pkg.vhd

function memory_calcs(reqs:t_reqs;
                      ip_param:t_param;
                      data_depth_unpacked: integer;
                      data_depth_packed: integer;
                      data_depth_rolling: integer;
                      coef_depth_unpacked: integer;
                      coef_depth_packed: integer;
                      use_rolling : boolean;
                      mem_comb: boolean) return t_param is
  variable param:t_param;
  constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                          -- has_lut6(reqs.family));
  constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                         -- has_lut6(reqs.family));
  --Not practical to have different mem type on different filter arms as they would need
  --seperate address generators so calc max width.
  constant max_path_data_width:integer:=max_val(reqs.path_reqs.data_width);
  constant max_path_coef_width:integer:=max_val(reqs.path_reqs.coef_width);
  
  constant data_dual_port: boolean:=(ip_param.filter_type=c_polyphase_pq_dec_alt);
begin
  param:=ip_param;

  --Data

  if (reqs.data_mem_type=c_mem_auto) then --auto

    if (data_depth_packed<=srl16_mem_depth_thres and not data_dual_port) then
      param.data_mem_type:=c_srl16; --srl16
      param.data_mem_depth:=data_depth_packed;
      param.data_packed:=1;
    elsif (data_depth_packed<=dram_mem_depth_thres) then
       param.data_mem_type:=c_dram;
      param.data_mem_depth:=data_depth_rolling;
      param.data_packed:=2;
    else
      param.data_mem_type:=c_bram; --bram
      if use_rolling then
        param.data_mem_depth:=data_depth_rolling;
        param.data_packed:=2;--0;
      else
        param.data_mem_depth:=data_depth_unpacked;
        param.data_packed:=0;
      end if;
    end if;

  elsif (reqs.data_mem_type=c_mem_forced_dist) then --dist mem
    if (data_depth_packed>1024 or data_dual_port) then
      param.data_mem_type:=c_dram; --dram
      if use_rolling then
        param.data_mem_depth:=data_depth_rolling;
        param.data_packed:=2;
      else
        param.data_mem_depth:=data_depth_packed;
        param.data_packed:=1;
      end if;
    else
      param.data_mem_type:=c_srl16; --srl16
      param.data_mem_depth:=data_depth_packed;
      param.data_packed:=1;
    end if;
  else --bram
    param.data_mem_type:=c_bram; --bram
    if (  data_depth_unpacked>v4_bram_depth(max_path_data_width) and
          (data_depth_rolling>v4_bram_depth(max_path_data_width) or not use_rolling) and
          data_depth_packed<=v4_bram_depth(max_path_data_width)) and data_dual_port then
      param.data_mem_depth:=data_depth_packed;
      param.data_packed:=1;
    elsif (not ( data_depth_unpacked<=v4_bram_depth(max_path_data_width) and
                 data_depth_rolling>v4_bram_depth(max_path_data_width) ) and use_rolling) or data_dual_port then
      param.data_mem_depth:=data_depth_rolling;
      param.data_packed:=2;
    else
      param.data_mem_depth:=data_depth_unpacked;
      param.data_packed:=0;
    end if;

  end if;

  --Symmetric Data
  param.data_combined := 0;
  param.datasym_mem_depth:=0;
  param.datasym_mem_type:=param.data_mem_type;
  param.datasym_mem_offset:=0;

  if (param.symmetry=1) then

    if (param.data_mem_type=c_bram) then --BRAM

      if ( 2*data_depth_rolling <= v4_bram_depth(max_path_data_width) and use_rolling) then
        -- report "FIR: will fit both data and symmetrical data into 1 ram" severity note;
        param.data_combined := 1;
        param.datasym_mem_depth:=data_depth_rolling;
        param.datasym_mem_offset:=data_depth_rolling;
        param.data_packed:=2;
      elsif (2*integer(2**log2roundup(data_depth_unpacked)) <= v4_bram_depth(max_path_data_width)) then
        -- report "FIR: will fit both data and symmetrical data into 1 ram" severity note;
        param.data_combined := 1;
        param.datasym_mem_depth:=data_depth_unpacked;
        param.datasym_mem_offset:=integer(2**log2roundup(data_depth_unpacked));--2*2**log2roundup(data_depth_unpacked);
        param.data_packed:=0;
      elsif (2*data_depth_packed <= v4_bram_depth(max_path_data_width)) then
        -- report "FIR: will fit both data and symmetrical data into 1 ram" severity note;
        param.data_combined := 1;
        param.datasym_mem_depth:=data_depth_packed;
        param.datasym_mem_offset:=data_depth_packed;
        param.data_packed:=1;
      else
        -- report "FIR: unable to fit data and symmetrical data into 1 ram" severity note;
        param.datasym_mem_depth:=param.data_mem_depth;
        param.datasym_mem_offset:=0;
      end if;
    else
      param.datasym_mem_depth:=param.data_mem_depth;
    end if;
  end if;

  --Coef
  param.coef_mem_offset:=0;
  param.data_coef_combined:=0;
  param.coef_combined:=0;

  if reqs.coef_reload=1 then

    if (reqs.coef_mem_type=c_mem_auto) then --auto
      if ( integer(2**log2roundup(coef_depth_unpacked))<=dram_mem_depth_thres) then
        param.coef_mem_type:=c_dram;--dram
        param.coef_mem_depth:=integer(2**log2roundup(coef_depth_unpacked));
        param.coef_packed:=0;
      elsif ( integer(2**log2roundup(coef_depth_packed))<=dram_mem_depth_thres) then
        param.coef_mem_type:=c_dram;--dram
        param.coef_mem_depth:=integer(2**log2roundup(coef_depth_packed));
        param.coef_packed:=1;
      else --bram
        param.coef_mem_type:=c_bram;
        if ( integer(2**log2roundup(coef_depth_unpacked))<= v4_bram_depth(max_path_coef_width)) then
          param.coef_mem_depth:=integer(2**log2roundup(coef_depth_unpacked));
          param.coef_packed:=0;
        elsif ( integer(2**log2roundup(coef_depth_packed))<= v4_bram_depth(max_path_coef_width)) then
          param.coef_mem_depth:=integer(2**log2roundup(coef_depth_packed));
          param.coef_packed:=1;
        else
          param.coef_mem_depth:=integer(2**log2roundup(coef_depth_unpacked));
          param.coef_packed:=0;
        end if;
      end if;
    elsif (reqs.coef_mem_type=c_mem_forced_dist) then --dram
      param.coef_mem_type:=c_dram;
      if integer(2**log2roundup(coef_depth_packed)) < integer(2**log2roundup(coef_depth_unpacked)) then
        param.coef_mem_depth:=integer(2**log2roundup(coef_depth_packed));
        param.coef_packed:=1;
      else
        param.coef_mem_depth:=integer(2**log2roundup(coef_depth_unpacked));
        param.coef_packed:=0;
      end if;
      --no point in being pack if no benfit, also if fully parallel then can have problems with
      --the address decode rom.
    elsif (reqs.coef_mem_type=c_mem_forced_bram) then --bram
      param.coef_mem_type:=c_bram;
      if ( integer(2**log2roundup(coef_depth_unpacked))<= v4_bram_depth(max_path_coef_width)) then
        param.coef_mem_depth:=integer(2**log2roundup(coef_depth_unpacked));
        param.coef_packed:=0;
      elsif ( integer(2**log2roundup(coef_depth_packed))<= v4_bram_depth(max_path_coef_width)) then
        param.coef_mem_depth:=integer(2**log2roundup(coef_depth_packed));
        param.coef_packed:=1;
      else
        param.coef_mem_depth:=integer(2**log2roundup(coef_depth_unpacked));
        param.coef_packed:=0;
      end if;
    end if;
  else --Normal
    
    if (reqs.coef_mem_type=c_mem_auto) then -- or param.no_data_mem=1) then --auto

      if (coef_depth_unpacked<=srl16_mem_depth_thres) then  --dram
        param.coef_mem_depth:=coef_depth_unpacked;
        param.coef_mem_type:=c_dram;
        param.coef_packed:=0;
      elsif (coef_depth_packed<=srl16_mem_depth_thres) then --dram
        param.coef_mem_depth:=coef_depth_packed;
        param.coef_mem_type:=c_dram;
        param.coef_packed:=1;
      else --bram
        param.coef_mem_type:=c_bram;
        if ( coef_depth_unpacked<= v4_bram_depth(max_path_coef_width)) then
          param.coef_mem_depth:=coef_depth_unpacked;
          param.coef_packed:=0;
        elsif ( coef_depth_packed<= v4_bram_depth(max_path_coef_width)) then
          param.coef_mem_depth:=coef_depth_packed;
          param.coef_packed:=1;
        else
          param.coef_mem_depth:=coef_depth_unpacked;
          param.coef_packed:=0;
        end if;
      end if;

    elsif (reqs.coef_mem_type=c_mem_forced_dist) then --forced dram
      
      if (coef_depth_unpacked<=srl16_mem_depth_thres) then
        param.coef_mem_depth:=coef_depth_unpacked;
        param.coef_mem_type:=c_dram;
        param.coef_packed:=0;
      else
        param.coef_mem_depth:=coef_depth_packed;
        param.coef_mem_type:=c_dram;
        param.coef_packed:=1;
      end if;

    else --forced bram
      param.coef_mem_type:=c_bram;
      if ( coef_depth_unpacked<= v4_bram_depth(max_path_coef_width)) then
        param.coef_mem_depth:=coef_depth_unpacked;
        param.coef_packed:=0;
      elsif ( coef_depth_packed<= v4_bram_depth(max_path_coef_width)) then
        param.coef_mem_depth:=coef_depth_packed;
        param.coef_packed:=1;
      else
        param.coef_mem_depth:=coef_depth_unpacked;
        param.coef_packed:=0;
      end if;
    end if;
    
  end if; --end normal coefficient memory

  --if either coef ram in bram and data not or vice versa, try to fit into one ram
  if ( (param.data_mem_type=c_bram or param.coef_mem_type=c_bram) and
        param.data_combined=0 and
        param.no_data_mem=0 and
        param.symmetry=0 and 
        coef_depth_packed>1 and
        reqs.coef_reload=0 and
        mem_comb) then

    if (coef_depth_unpacked+integer(2**log2roundup(get_max(data_depth_rolling,coef_depth_unpacked))) <= v4_bram_depth(get_max(max_path_data_width,max_path_coef_width)) and use_rolling) then
      param.coef_mem_offset:=integer(2**log2roundup(get_max(data_depth_rolling,coef_depth_unpacked)));
      param.data_coef_combined:=1;
      param.coef_mem_depth:=coef_depth_unpacked;
      param.data_mem_depth:=data_depth_rolling;
      param.coef_packed:=0;
      param.data_packed:=2;
      param.coef_mem_type:=c_bram;
      param.data_mem_type:=c_bram;
    elsif (coef_depth_unpacked+integer(2**log2roundup(get_max(data_depth_unpacked,coef_depth_unpacked))) <= v4_bram_depth(get_max(max_path_data_width,max_path_coef_width))) then
      param.coef_mem_offset:=integer(2**log2roundup(get_max(data_depth_unpacked,coef_depth_unpacked)));
      param.data_coef_combined:=1;
      param.coef_mem_depth:=coef_depth_unpacked;
      param.data_mem_depth:=data_depth_unpacked;
      param.coef_packed:=0;
      param.data_packed:=0;
      param.coef_mem_type:=c_bram;
      param.data_mem_type:=c_bram;
    elsif (coef_depth_packed+data_depth_packed <= v4_bram_depth(get_max(max_path_data_width,max_path_coef_width))) then
      param.coef_mem_offset:=data_depth_unpacked;
      param.data_coef_combined:=1;
      param.coef_mem_depth:=coef_depth_packed;
      param.data_mem_depth:=data_depth_packed;
      param.coef_packed:=1;
      param.data_packed:=1;
      param.coef_mem_type:=c_bram;
      param.data_mem_type:=c_bram;
    end if;
  else
    if param.coef_mem_type=c_bram and coef_depth_packed>1 and reqs.coef_reload=0 and param.num_macs>1 then--and not mem_comb then
      --simple packing so it can be done on the fly in the filter arm block
      if 2*integer(2**log2roundup(param.coef_mem_depth))<=v4_bram_depth(max_path_coef_width) then
        param.coef_combined:=1;
      end if;
    end if;

    if param.data_mem_type=c_bram and
       param.no_data_mem=0 and
       param.symmetry=0 then
      --can also pack adjacent data memories

      if 2*integer(2**log2roundup(param.data_mem_depth))<=v4_bram_depth(max_path_data_width) and param.num_macs>1 then
        param.data_combined:=1;
      end if;

    end if;
  end if;
  
  if data_dual_port then
    --Used to indicate that both port of the data memory are used for the non-sym data path
    param.data_combined:=2;
  end if;
  
  return param;
end;

function lat_polyphase_decimation_sym_wrap(param :  t_polyphase_decimation_sym_wrap) return integer is
  variable ram_param: t_ram;
  variable ram_lat,
           srl16_mem_depth_thres,
           parallel_depth
           : integer;
begin
  if param.base_count>1 then
    --currently not supported, latency not required to be reported
    return 0;
  else
    srl16_mem_depth_thres:=param.family.lut_depth*2;--select_integer(32,64,has_lut6(param.family));

    parallel_depth:=param.num_phases+select_integer(0,1,param.sym_type=1);
    parallel_depth:=param.num_channels*integer(2**log2roundup(parallel_depth));

    ram_param:=(family              => param.family,
                implementation      => param.implementation,
                mem_type            => select_integer(c_bram,c_dram,parallel_depth<=srl16_mem_depth_thres or param.force_srl16_mem=1),
                write_mode          => 0,--read first
                has_ce              => param.has_ce,
                use_mif             => 0,
                resource_opt        => c_area,
                is_rom              => false );
    ram_lat:=lat_ram(ram_param,1);
    if param.sym_type=0 and param.has_nd=0 then
      return ram_lat;
    else
      return ram_lat+1;
    end if;
  end if;
end;

function gen_mif_files (
         elab_dir   : string;
         gen_mif_prefix : string;
         mif_file   : string;
         param      : t_param;
         gen_mif    : boolean;
         gen_reload_seq : boolean )
         return t_gen_mif_status is

constant indp_coef_paths: t_int_array:=get_indp_paths(param.num_paths,param.path_reqs.coef_src);
constant indp_coef_paths_0index: t_int_array(indp_coef_paths'LENGTH-1 downto 0):=indp_coef_paths;

-- gui trans_off
variable input_coefficients : t_coefficients(param.num_filts*param.num_taps-1 downto 0);

variable coefficients,
         mod_coefficients : t_coefficients(param.num_taps_calced-1 downto 0):=(others=>(others=>'0'));

type t_mac_coefficients is array (param.num_macs-1 downto 0)--indp_coef_paths'range,
     of t_coefficients(param.coef_mem_depth+param.coef_mem_offset+1-1 downto 0);
                                                         --extra plus 1 for extra output location
variable mac_coefficients : t_mac_coefficients:=(others=>(others=>(others=>'0')));

variable mac_nonzero: t_int_array(param.num_macs-1 downto 0):=(others=>0);

variable half_band_centre_value : t_coefficients(
                                    select_integer(param.num_filts,
                                                   param.num_filts*2,
                                                   param.coef_reload=1)+1-1 downto 0):=(others=>(others=>'0'));
                                                   --extra plus 1 for extra output location
-- gui trans_on

-- gui insert_on
-- variable input_coefficients : t_int_array(tcl_to_int(param.num_filts*param.num_taps)-1 downto 0);
-- 
-- variable coefficients,
--          mod_coefficients : t_int_array(tcl_to_int(param.num_taps_calced)-1 downto 0):=(others=>0);
--
-- subtype t_single_mac is t_int_array(tcl_to_int(param.coef_mem_depth+param.coef_mem_offset)+1-1 downto 0);
-- type t_mac_coefficients is array (tcl_to_int(param.num_macs)-1 downto 0)
--      of t_single_mac;
--
-- variable mac_coefficients : t_mac_coefficients:=(others=>(others=>0));
-- 
-- variable mac_nonzero: t_int_array(tcl_to_int(param.num_macs)-1 downto 0);
--
-- variable half_band_centre_value : t_int_array(
--                                     select_integer(param.num_filts,
--                                                    param.num_filts*2,
--                                                    param.coef_reload=1)+1-1 downto 0):=(others=>0);
-- gui insert_off

variable tap_offset,
         taps_reqed,
         tap,
         step,
         phase,
         phase_offset,
         phase_last_mod,
         inter_sym_loop_len,
         base_count,
         mac,
         mac_mem_pos,
         write_result,
         coef_width,
         coef_sign,
         data_width,
         output_path,
         bit_offset,
         mac_base,
         write_i,
         read_i_1,
         read_i_2
         : integer;
-- gui trans_off
variable phase_order,
         pq_deci_new_data_phase,
         mac_order
         : t_int_array(select_integer(
                        param.num_macs,
                        select_integer(
                          param.deci_rate,
                          param.inter_rate,
                          param.deci_rate<param.inter_rate),
                        param.filter_type=c_polyphase_pq or
                        param.filter_type=c_polyphase_pq_dec_alt)
                        -1 downto 0);
-- gui trans_on

-- gui insert_on
-- variable phase_order,
--          pq_deci_new_data_phase,
--          mac_order
--          : t_int_array(tcl_to_int(select_integer(
--                         param.num_macs,
--                         select_integer(
--                           param.deci_rate,
--                           param.inter_rate,
--                           param.deci_rate<param.inter_rate),
--                         param.filter_type=c_polyphase_pq))
--                         -1 downto 0);
-- variable retval : boolean;
-- gui insert_off

variable next_mac: integer:=-1;

variable status : t_gen_mif_status;
-- synthesis translate_off
-- gui trans_on
variable reload_src: t_reorder_info_array(param.num_taps_calced-1 downto 0);
-- synthesis translate_on

begin

  status.num_opt_mac:=0;
  -- gui trans_off
  status.opt_mac:=(others=>0);
  -- gui trans_on
  -- gui insert_on
  -- for i in max_dsps downto 1 loop
  --   status.opt_mac(i):=0;
  -- end loop;
  -- gui insert_off
  status.OK:=true;

  --Read all paths and filters-----------------------------------------------
  for path in 0 to indp_coef_paths_0index'LENGTH-1 loop
    -- gui trans_off
    mac_nonzero:=(others=>0);
    -- gui trans_on
    -- gui insert_on
    -- for i in tcl_to_int(param.num_macs)-1 downto 0 loop
    --   mac_nonzero(i):=0;
    -- end loop;
    -- gui insert_off

    --Select parameters of source
    coef_width:=param.path_reqs.coef_width(indp_coef_paths(path));
    data_width:=param.path_reqs.data_width(indp_coef_paths(path));
    coef_sign :=param.path_reqs.coef_sign(indp_coef_paths(path));

    -- Check number of entries in input mif file

    -- gui trans_off
    if (get_number_of_inputs(elab_dir&select_string(mif_file,mif_file&"_"&int_to_str(indp_coef_paths(path)),indp_coef_paths'LENGTH>1 and gen_mif))--not split_mif and
                <param.num_taps*param.num_filts) then
    -- gui trans_on
    -- gui insert_on
    -- if (get_number_of_inputs(elab_dir&select_string(mif_file,mif_file&"_"&int_to_str(indp_coef_paths(path)),indp_coef_paths'LENGTH>1 and gen_mif))
    --             <param.num_taps) then
    -- gui insert_off

      -- Changed for XST, getnuminput seem to return one more than in file
      status.OK:=false;
      report "NOTE : FIR Compiler v5.0 : gen_mif_files: input mif file has incorrect number of values" severity note;
      report "NOTE : FIR Compiler v5.0 : NUM INPUTS    : "&int_to_str(get_number_of_inputs(elab_dir&mif_file) ) severity note;
      report "ERROR: FIR Compiler v5.0 : EXPECT INPUTS : "&int_to_str(param.num_taps*param.num_filts ) severity failure;

    else


      --Determine tap offset-----------------------------------------------------
      tap_offset:=0;
      taps_reqed:=param.num_taps;
      if (param.symmetry=1) then
        if ( param.num_taps rem 2 > 0 ) then -- Odd symmetry
          taps_reqed:=(param.num_taps/2)+1;
        else
          taps_reqed:=(param.num_taps/2);
        end if;
        tap_offset:=param.num_taps_calced-taps_reqed;

        if (param.filter_type=c_interpolating_symmetry and param.odd_symmetry=1 and param.inter_rate rem 2 >0 ) then
          tap_offset:=tap_offset-(param.inter_rate/2);
        end if;
      end if;


      --Read coefficients from source MIF------------------------------------
      input_coefficients:=
                       read_coef_data( elab_dir&select_string(mif_file,mif_file&"_"&int_to_str(indp_coef_paths(path)),indp_coef_paths'LENGTH>1 and gen_mif),--not split_mif and
                                       -- gui trans_off
                                       param.num_filts*param.num_taps,
                                       -- gui trans_on
                                       -- gui insert_on
                                       -- param.num_taps,
                                       -- gui insert_off
                                       coef_width,
                                       0);
      -- gui trans_off
      for filter in 0 to param.num_filts-1 loop
      -- gui trans_on
      -- gui insert_on
      -- for filter in 0 to 0 loop
      -- gui insert_off

        --Extract this filters coefficients
        
        -- gui trans_off
        coefficients:=(others=>(others=>'0'));
        -- gui trans_on

        -- gui insert_on
        -- for i in param.num_taps_calced-1 downto 0 loop
        --   coefficients(i):=0;
        -- end loop;
        -- gui insert_off

        if (param.filter_type=c_interpolating_symmetry and param.odd_symmetry=1 and param.inter_rate rem 2 >0 ) then
          -- gui trans_off
          coefficients(taps_reqed+tap_offset+(param.inter_rate/2)-1 downto tap_offset):=
            input_coefficients( (filter*param.num_taps)+taps_reqed+(param.inter_rate/2)-1 downto filter*param.num_taps);
          -- gui trans_on

          -- gui insert_on
          -- for tap_assign in 0 to taps_reqed-1 loop
          --   coefficients(tap_assign+tap_offset+(param.inter_rate/2)):=
          --     input_coefficients( (filter*param.num_taps)+tap_assign+(param.inter_rate/2));
          -- end loop;
          -- gui insert_off
        else
          -- gui trans_off
          coefficients(taps_reqed+tap_offset-1 downto tap_offset):=
            input_coefficients( (filter*param.num_taps)+taps_reqed-1 downto filter*param.num_taps);
          -- gui trans_on

          -- gui insert_on
          -- for tap_assign in 0 to taps_reqed-1 loop
          --   coefficients(tap_assign+tap_offset):=
          --     input_coefficients( (filter*param.num_taps)+tap_assign);
          -- end loop;
          -- gui insert_off
        end if;


        --Generate symmetric pair coefficients if required---------------------
        if (param.filter_type=c_interpolating_symmetry and 
            not (param.inter_rate=2 and param.odd_symmetry=1) ) then
          tap:=0;
          while tap<=param.num_taps_calced-1 loop
            
            -- synthesis translate_off
            -- gui trans_on
            reload_src(tap).paths:=path+1;
            reload_src(tap).upper_dest(path):=coef_width;
            reload_src(tap).upper_src(path):=coef_width-coef_sign-1;
            -- synthesis translate_on

            phase_last_mod:=0;
            phase_offset:=0;
            if (param.inter_rate rem 2 /=0) then
              --get centre phase as it will be symmetric
              mod_coefficients(tap):=coefficients(tap+((param.inter_rate/2)));

              -- synthesis translate_off
              -- gui trans_on
              reload_src(tap).combination:=0;
              reload_src(tap).index_1    :=tap+((param.inter_rate/2));
              -- synthesis translate_on

              phase_offset:=1;
            end if;

            phase:=0;
            inter_sym_loop_len:=(param.inter_rate/2);

            if (param.inter_rate rem 2 =0) and (param.odd_symmetry=1) then
              mod_coefficients(tap):=coefficients(tap+((param.inter_rate/2)-1));
              mod_coefficients(tap+param.inter_rate-1):=coefficients(tap+((param.inter_rate)-1));

              -- synthesis translate_off
              -- gui trans_on
              reload_src(tap).paths:=path+1;
              reload_src(tap).combination:=0;
              reload_src(tap).index_1    :=tap+((param.inter_rate/2)-1);
              reload_src(tap).upper_dest(path):=coef_width;
              reload_src(tap).upper_src(path):=coef_width-coef_sign-1;
              reload_src(tap+param.inter_rate-1).paths:=path+1;
              reload_src(tap+param.inter_rate-1).combination:=0;
              reload_src(tap+param.inter_rate-1).index_1    :=tap+((param.inter_rate)-1);
              reload_src(tap+param.inter_rate-1).upper_dest(path):=coef_width;
              reload_src(tap+param.inter_rate-1).upper_src(path):=coef_width-coef_sign-1;
              -- synthesis translate_on

              phase_offset:=1;
              phase_last_mod:=1;
              inter_sym_loop_len:=(param.inter_rate-2)/2;--shorten loop so don't overwrite last phase
            end if;

            for phase_loop in 0 to inter_sym_loop_len-1 loop

              write_i:=tap+(2*phase)+1+phase_offset;
              read_i_1:=tap+phase;
              read_i_2:= (param.inter_rate+tap-1-phase_last_mod)-(phase);

              -- gui trans_off
              mod_coefficients(write_i)(coef_width-1 downto 0):= std_logic_vector(signed(coefficients(read_i_1)(coef_width-1 downto 0))
                                                                                  +signed(coefficients(read_i_2)(coef_width-1 downto 0)));
              -- gui trans_on

              -- gui insert_on
              -- mod_coefficients(write_i):= coefficients(read_i_1)+coefficients(read_i_2);
              -- gui insert_off

              -- synthesis translate_off
              -- gui trans_on
              reload_src(write_i).combination:=1;--add
              reload_src(write_i).index_1:=read_i_1;
              reload_src(write_i).index_2:=read_i_2;
              reload_src(write_i).paths:=path+1;
              reload_src(write_i).upper_dest(path):=coef_width;
              reload_src(write_i).upper_src(path):=coef_width-coef_sign-1;
              -- synthesis translate_on

              write_i:=tap+(2*phase)+phase_offset;

              -- gui trans_off
              mod_coefficients(write_i)(coef_width-1 downto 0):= std_logic_vector(signed(coefficients(read_i_1)(coef_width-1 downto 0))
                                                                                  -signed(coefficients(read_i_2)(coef_width-1 downto 0)));
              -- gui trans_on

              -- gui insert_on
              -- mod_coefficients(write_i):= coefficients(read_i_1)-coefficients(read_i_2);
              -- gui insert_off

              
              -- synthesis translate_off
              -- gui trans_on
              reload_src(write_i).combination:=2;--sub
              reload_src(write_i).index_1:=read_i_1;
              reload_src(write_i).index_2:=read_i_2;
              reload_src(write_i).paths:=path+1;
              reload_src(write_i).upper_dest(path):=coef_width;
              reload_src(write_i).upper_src(path):=coef_width-coef_sign-1;
              -- synthesis translate_on

              phase:=phase+1;
            end loop;

            --put back into src coefficient array
            -- gui trans_off
            coefficients(tap+param.inter_rate-1 downto tap):=mod_coefficients(tap+param.inter_rate-1 downto tap);
            -- gui trans_on
            -- gui insert_on
            -- for i in tap+param.inter_rate-1 downto tap loop
            --   coefficients(i):=mod_coefficients(i);
            -- end loop;
            -- gui insert_off

            tap:=tap+param.inter_rate;
          end loop;
        elsif gen_reload_seq then
          --generate source indexes
          -- synthesis translate_off
          -- gui trans_on
          for i in 0 to param.num_taps_calced-1 loop
            reload_src(i).combination:=0;
            reload_src(i).index_1    :=i;
            reload_src(i).paths      :=path+1;
          end loop;
          -- synthesis translate_on
        end if;

        --Fill mac memory contents---------------------------------------------
        tap:=0;
        step:=1;
        mac:=-1;
        base_count:=0;
        phase:=0;
        phase_offset:=0;

        case param.filter_type is
          when c_polyphase_decimating =>
            phase:=param.deci_rate-1;
          when c_channelizer_receiver =>
            phase:=param.num_channels-1;
          when c_channelizer_transmitter =>
            phase:=0;
          when c_halfband_transform |
               c_decimating_half_band |
               c_interpolating_half_band |
               c_hilbert_transform =>
            if tap_offset rem 2 > 0 then
              tap:=1;
            else
              tap:=0;
            end if;
            step:=2;
            --skip zero coefficients when halfband
          when c_polyphase_pq =>
            if param.inter_rate<param.deci_rate then
            --decimation
              phase:=param.deci_rate-1;
              for i in 0 to param.deci_rate-1 loop
                phase_order(phase):=i;
                pq_deci_new_data_phase(phase):=phase_offset;
                if (phase-param.inter_rate)<0 then
                  phase_offset:=phase_offset+param.deci_rate;
                  --value replicates the value used below fro phase offset but us used as a range to determine if a
                  --set of coefficients should be rotated to compenstate for a write that hasn't occured yet
                end if;
                phase:=(phase-param.inter_rate) mod param.deci_rate;
              end loop;
              phase:=0;
              phase_offset:=0;
            else
              --interpolation
              for i in 0 to param.inter_rate-1 loop
                phase_order(phase):=i;
                phase:=(phase+param.deci_rate)mod param.inter_rate;
              end loop;
              phase:=0;
            end if;
          when c_transpose_single_rate =>
            mac_base:=0;
            if param.num_channels>1 then
              phase:=0;
              phase_offset:=0;--borrow variables
              for i in 0 to param.num_macs-1 loop
                mac_order(i):=phase;
                phase:=phase+param.num_channels;
                if phase>param.num_macs-1 then
                  phase_offset:=phase_offset+1;
                  phase:=phase_offset;
                end if;
              end loop;
            end if;
          when c_transpose_interpolating =>
            mac_base:=0;
            phase:=0;
            phase_offset:=0;--just reusing variable, name not really correct.
            for i in 0 to param.num_macs-1 loop
              mac_order(i):=phase;
              phase_order(i):=phase_offset;
              phase:=phase+param.inter_rate;
              if phase>param.num_macs-1 then
                phase_offset:=phase_offset+1;
                phase:=phase_offset;
              end if;
            end loop;
            phase:=0;
            phase_offset:=0;
          when c_polyphase_pq_dec_alt => 
            --phase:=param.inter_rate-1;
            -- phase:=(param.deci_rate-1) mod param.inter_rate;
            --phase:=((param.inter_rate-1)*param.deci_rate) mod param.inter_rate;
            phase:=0;
            for i in 0 to param.inter_rate-1 loop
              phase_order((((i+1)*param.deci_rate)-1) mod param.inter_rate):=i;
            end loop;
            
          when others =>
        end case;

        while tap<=param.num_taps_calced-1 loop

          --offset applied when data and coefficients packed in one memory
          mac_mem_pos:=param.coef_mem_offset;

          -- not packed memory, add binary offset
          if (param.coef_packed=0) then
            mac_mem_pos:=(integer(2**log2roundup(param.base_coef_space))*filter)+mac_mem_pos;
          else
            mac_mem_pos:=(param.base_coef_space*filter)+mac_mem_pos;
          end if;

          case param.filter_type is
            when c_single_rate |
                 c_halfband_transform |
                 c_decimating_half_band |
                 c_interpolating_half_band |
                 c_hilbert_transform |
                 c_interpolated_transform =>
              --Actual address in mac
              mac_mem_pos:=base_count+mac_mem_pos;

              --track position
              if base_count=0 then
                mac:=mac+1;
              end if;
              if base_count=param.base_count-1 then
                base_count:=0;
              else
                base_count:=base_count+1;
              end if;
            when c_polyphase_decimating=>
              --Actual address in mac
              mac_mem_pos:=(phase*param.base_count)+base_count+mac_mem_pos;

              --track position
              if base_count=0 and phase=param.deci_rate-1 then
                mac:=mac+1;
              end if;
              if phase=0 then
                phase:=param.deci_rate-1;
                if base_count=param.base_count-1 then
                  base_count:=0;
                else
                  base_count:=base_count+1;
                end if;
              else
                phase:=phase-1;
              end if;
            when c_channelizer_receiver =>
              --Actual address in mac
              mac_mem_pos:=(phase*param.base_count)+base_count+mac_mem_pos;

              --track position
              if base_count=0 and phase=param.num_channels-1 then
                mac:=mac+1;
              end if;
              if phase=0 then
                phase:=param.num_channels-1;
                if base_count=param.base_count-1 then
                  base_count:=0;
                else
                  base_count:=base_count+1;
                end if;
              else
                phase:=phase-1;
              end if;
            when c_channelizer_transmitter =>
              --Actual address in mac
              mac_mem_pos:=(phase*param.base_count)+base_count+mac_mem_pos;

              --track position
              if base_count=0 and phase=0 then
                mac:=mac+1;
              end if;
              if phase=param.num_channels-1 then
                phase:=0;
                if base_count=param.base_count-1 then
                  base_count:=0;
                else
                  base_count:=base_count+1;
                end if;
              else
                phase:=phase+1;
              end if;
            when c_polyphase_interpolating|c_interpolating_symmetry =>
              --Actual address in mac
              mac_mem_pos:=(phase*param.base_count)+base_count+mac_mem_pos;

              --track position
              if base_count=0 and phase=0 then
                mac:=mac+1;
              end if;
              if phase=param.inter_rate-1 then
                phase:=0;
                if base_count=param.base_count-1 then
                  base_count:=0;
                else
                  base_count:=base_count+1;
                end if;
              else
                phase:=phase+1;
              end if;
            when c_polyphase_pq =>
              if param.inter_rate>param.deci_rate then
              --Interpolation

                --Actual address in mac
                mac_mem_pos:=(phase_order(phase)*param.base_count)+base_count+mac_mem_pos;

                --track position
                if base_count=0 and phase=0 then
                  mac:=mac+1;
                end if;

                if phase=param.inter_rate-1 then
                  --next phase goes back to zero so been round all phases
                  if base_count=param.base_count-1 then
                    base_count:=0;
                  else
                    base_count:=base_count+1;
                  end if;
                  phase:=0;
                else
                  phase:=phase+1;
                end if;
              else
              --Decimation

                --Actual address in mac
                if param.data_mem_type=c_srl16 then
                  mac_mem_pos:=((((phase_order(phase)*param.inter_rate)+phase_offset)mod(param.deci_rate*param.inter_rate))
                                *param.base_count)
                                +base_count
                                +mac_mem_pos;
                else
                  if (((phase_order(phase)*param.inter_rate)+phase_offset)mod(param.deci_rate*param.inter_rate))>=pq_deci_new_data_phase(phase) then
                    --fresh data so coefficient don't need to be barrel shifted
                    mac_mem_pos:=((((phase_order(phase)*param.inter_rate)+phase_offset)mod(param.deci_rate*param.inter_rate))
                                  *param.base_count)
                                  +base_count
                                  +mac_mem_pos;
                  else
                    --old data so need to barrel shift coefficients
                    mac_mem_pos:=((((phase_order(phase)*param.inter_rate)+phase_offset)mod(param.deci_rate*param.inter_rate))
                                  *param.base_count)
                                  +((base_count+1)mod param.base_count)
                                  +mac_mem_pos;
                  end if;
                end if;

                --track position
                if base_count=0 and phase=0 and phase_offset=0 then
                  mac:=mac+1;
                end if;

                if phase=param.deci_rate-1 then
                  phase:=0;
                  if phase_offset=((param.inter_rate-1)*param.deci_rate) then
                    phase_offset:=0;
                    if base_count=param.base_count-1 then
                      base_count:=0;
                    else
                      base_count:=base_count+1;
                    end if;
                  else
                    phase_offset:=phase_offset+param.deci_rate;
                  end if;
                else
                  phase:=phase+1;
                end if;

              end if;
            when c_transpose_single_rate =>

              mac_mem_pos:=(tap / param.num_macs) + base_count + mac_mem_pos;

              if mac+1> param.num_macs then
                base_count:=base_count+1;
              end if;

              mac_base:=(tap mod param.num_macs);
              if param.num_channels=1 then
                mac:=mac_base;
              else
                mac:=mac_order(mac_base);
              end if;

            when c_transpose_decimating =>

              phase:=param.deci_rate-1-(tap mod param.deci_rate);

              mac_mem_pos:= base_count + (phase*param.base_count) + mac_mem_pos;--( (tap/param.deci_rate) / param.num_macs)

              mac:=( (tap/param.deci_rate) mod param.num_macs);

              if mac+1= param.num_macs and (tap mod param.deci_rate)=param.deci_rate-1 then
                base_count:=base_count+1;
              end if;

            when c_transpose_interpolating =>

              mac_base:=( (tap/param.inter_rate) mod param.num_macs);
              mac:=mac_order(mac_base);

              phase:=((tap mod param.inter_rate)-phase_order(mac_base)) mod param.inter_rate;

              mac_mem_pos:= (phase*param.base_count)+ base_count + mac_mem_pos;

              if (mac_base+1= param.num_macs) and ((tap mod param.inter_rate)=param.inter_rate-1) then
                base_count:=base_count+1;
              end if;
              
            when c_polyphase_pq_dec_alt =>
              --Actual address in mac
              -- mac_mem_pos:=( ((phase+(param.deci_rate rem param.inter_rate)) mod param.inter_rate)*param.base_count)+base_count+mac_mem_pos;
              -- mac_mem_pos:=(phase*param.base_count)+base_count+mac_mem_pos;
              mac_mem_pos:=(phase_order(phase)*param.base_count)+base_count+mac_mem_pos;
              
              --track position
              -- if base_count=0 and phase=param.inter_rate-1 then
                -- mac:=mac+1;
              -- end if;
              
              -- if phase=0 then
                -- phase:=param.inter_rate-1;
                -- if base_count=param.base_count-1 then
                  -- base_count:=0;
                -- else
                  -- base_count:=base_count+1;
                -- end if;
              -- else
                -- phase:=phase-1;
              -- end if;
              
              -- if (phase=(param.deci_rate-1) mod param.inter_rate) and base_count=0 then
              -- if (phase=((param.inter_rate-1)*param.deci_rate) mod param.inter_rate) and base_count=0 then
              if (phase=0 and base_count=0) then
                mac:=mac+1;
              end if;
              
              -- report "tap: "&integer'image(tap);
              -- report "phase: "&integer'image(phase_order(phase));
              -- report "mac: "&integer'image(mac);
              -- report "base_count: "&integer'image(base_count);
              -- report "mac_mem_pos: "&integer'image(mac_mem_pos);
              
              -- phase:=(phase+param.deci_rate) mod param.inter_rate;
              phase:=phase+1;
              
              --if phase=(param.deci_rate-1) mod param.inter_rate then
              -- if phase=((param.inter_rate-1)*param.deci_rate) mod param.inter_rate then
              if phase=param.inter_rate then
                phase:=0;
                --moving onto the start phase again
                if base_count=param.base_count-1 then
                  base_count:=0;
                else
                  base_count:=base_count+1;
                end if;
              end if;
              
            when others =>
          end case;

          --Extend coefficient values if signed coeff and memory packed and data width > coef width
          -- gui trans_off
          if (  param.data_coef_combined=1 and
                data_width > coef_width and
                coef_sign = c_signed ) then
            mac_coefficients(mac)(mac_mem_pos)(data_width-1 downto 0):=
              ext_bus(coefficients(tap)(coef_width-1 downto 0),data_width,coef_sign);
          else
            mac_coefficients(mac)(mac_mem_pos):=coefficients(tap);
          end if;
          -- gui trans_on

          -- gui insert_on
          -- mac_coefficients(mac)(mac_mem_pos):=coefficients(tap);
          -- gui insert_off

          -- report "MAC: "&int_to_str(mac)&" POS: "&int_to_str(mac_mem_pos)&" TAP: "&int_to_str(tap);

          -- synthesis translate_off
          -- gui trans_on
          if filter=0 and path=indp_coef_paths_0index'LENGTH-1 and param.filter_type/=c_channelizer_receiver and param.filter_type/=c_channelizer_transmitter then
            if param.filter_type=c_transpose_single_rate or
               param.filter_type=c_transpose_decimating or
               param.filter_type=c_transpose_interpolating then
              -- gui trans_off
              status.reorder_seq(((mac)*(param.base_coef_space))+
                                mac_mem_pos-param.coef_mem_offset):=reload_src(tap);
              -- gui trans_on
              -- gui insert_on
              -- if gen_reload_seq then
              --   retval:=add_to_reorder_seq(
              --       param.num_taps_calced,
              --       ((mac)*(param.base_coef_space))+mac_mem_pos-param.coef_mem_offset,
              --       reload_src(tap).combination,
              --       reload_src(tap).paths,
              --       reload_src(tap).index_1,
              --       reload_src(tap).index_2,
              --       reload_src(tap).upper_dest(0),
              --       reload_src(tap).upper_dest(1),
              --       reload_src(tap).upper_src(0),
              --       reload_src(tap).upper_src(1));
              -- end if;
              -- gui insert_off
            else
              -- gui trans_off
              status.reorder_seq(((param.num_macs-1-mac)*(param.base_coef_space))+
                                mac_mem_pos-param.coef_mem_offset):=reload_src(tap);
              -- gui trans_on
              -- gui insert_on
              -- if gen_reload_seq then
              --   retval:=add_to_reorder_seq(
              --       param.num_taps_calced,
              --       ((param.num_macs-1-mac)*(param.base_coef_space))+mac_mem_pos-param.coef_mem_offset,
              --       reload_src(tap).combination,
              --       reload_src(tap).paths,
              --       reload_src(tap).index_1,
              --       reload_src(tap).index_2,
              --       reload_src(tap).upper_dest(0),
              --       reload_src(tap).upper_dest(1),
              --       reload_src(tap).upper_src(0),
              --       reload_src(tap).upper_src(1));
              -- end if;
              -- gui insert_off
            end if;
          end if;
          -- synthesis translate_on

          -- gui trans_off
          if unsigned(coefficients(tap)(param.path_reqs.coef_width(indp_coef_paths(path))-1 downto 0)) > 0 or
             (param.filter_type=c_transpose_single_rate or
              param.filter_type=c_transpose_decimating or
              param.filter_type=c_transpose_interpolating) then
            mac_nonzero(mac):=1;
          end if;
          -- gui trans_on

          -- gui insert_on
          -- if coefficients(tap) /= 0 or
          -- (param.filter_type=c_transpose_single_rate or
          --  param.filter_type=c_transpose_decimating or
          --  param.filter_type=c_transpose_interpolating)then
          --   mac_nonzero(mac):=1;
          -- end if;
          -- gui insert_off


          tap:=tap+step;
        end loop;

        --Centre tap for halfband structures
        if (param.filter_type=c_decimating_half_band  or
            param.filter_type=c_interpolating_half_band or
            param.filter_type=c_halfband_transform) then

          if param.num_macs=1 and param.single_mac=1 then
            --Reset mac_mem_pos value
            mac_mem_pos:=param.coef_mem_offset;

            -- not packed memory, add binary offset
            if (param.coef_packed=0) then
              mac_mem_pos:=(integer(2**log2roundup(param.base_coef_space))*filter)+mac_mem_pos;
            else
              mac_mem_pos:=(param.base_coef_space*filter)+mac_mem_pos;
            end if;

            mac_mem_pos:=param.base_coef_space-1+mac_mem_pos;

            --Centre tap will be in main coefficient memory
            mac_coefficients(mac)(mac_mem_pos):=coefficients(param.num_taps_calced-1);

            -- synthesis translate_off
            -- gui trans_on
            if filter=0 and path=indp_coef_paths_0index'LENGTH-1 and param.filter_type/=c_channelizer_receiver and param.filter_type/=c_channelizer_transmitter then
              -- gui trans_off
              status.reorder_seq(mac_mem_pos-param.coef_mem_offset):=reload_src(param.num_taps_calced-1);
              -- gui trans_on
              -- gui insert_on
              -- if gen_reload_seq then
              --   retval:=add_to_reorder_seq(
              --       param.num_taps_calced,
              --       mac_mem_pos-param.coef_mem_offset,
              --       reload_src(param.num_taps_calced-1).combination,
              --       reload_src(param.num_taps_calced-1).paths,
              --       reload_src(param.num_taps_calced-1).index_1,
              --       reload_src(param.num_taps_calced-1).index_2,
              --       reload_src(param.num_taps_calced-1).upper_dest(0),
              --       reload_src(param.num_taps_calced-1).upper_dest(1),
              --       reload_src(param.num_taps_calced-1).upper_src(0),
              --       reload_src(param.num_taps_calced-1).upper_src(1));
              -- end if;
              -- gui insert_off
            end if;
            -- synthesis translate_on

          else
            if param.filter_type/=c_channelizer_receiver and param.filter_type/=c_channelizer_transmitter then
              --If not in main filter mem tack on end of reload sequence
              -- synthesis translate_off
              status.reorder_seq( (param.num_macs*param.base_coef_space)):=reload_src(param.num_taps_calced-1);
              -- synthesis translate_on
              -- gui insert_on
              -- if gen_reload_seq then
              --   retval:=add_to_reorder_seq(
              --       param.num_taps_calced,
              --       (param.num_macs*param.base_coef_space),
              --       reload_src(param.num_taps_calced-1).combination,
              --       reload_src(param.num_taps_calced-1).paths,
              --       reload_src(param.num_taps_calced-1).index_1,
              --       reload_src(param.num_taps_calced-1).index_2,
              --       reload_src(param.num_taps_calced-1).upper_dest(0),
              --       reload_src(param.num_taps_calced-1).upper_dest(1),
              --       reload_src(param.num_taps_calced-1).upper_src(0),
              --       reload_src(param.num_taps_calced-1).upper_src(1));
              -- end if;
              -- gui insert_off
            end if;
          end if;
--           else
          --Centre tap will be in seperate memory/constant
          half_band_centre_value(filter):=coefficients(param.num_taps_calced-1);
--           end if;
        end if;


      end loop; --filter

      --Output MIF files---------------------------------------------------------
      for mac in 0 to  param.num_macs-1 loop

        -- gui trans_off
        if gen_mif then

          if param.coef_reload=0 then
            next_mac:=next_nonzero(mac_nonzero,mac);
          end if;

          write_result := write_coef_data( elab_dir
                                      & gen_mif_prefix
                                      & "COEFF_auto"
                                      & int_to_str(indp_coef_paths(path))
                                      & "_"
                                      & int_to_str(mac)
                                      & ".mif",
                                        param.coef_mem_depth+param.coef_mem_offset
                                        +select_integer(1,0,param.coef_combined=1 and
                                                            next_mac>mac and
                                                            next_mac<param.num_macs and
                                                            param.coef_reload=0 and
                                                            param.coef_mem_type=c_bram),
                                        select_integer( param.path_reqs.coef_width(indp_coef_paths(path)),
                                                        get_max(param.path_reqs.coef_width(indp_coef_paths(path)),param.path_reqs.data_width(indp_coef_paths(path))),
                                                        param.data_coef_combined=1),
                                        mac_coefficients(mac));
          ------------------------------------------------------------------------
          -- Note : To use BRAM with data and coefficients together, need to make
          -- baseblock both ports same width, this means need to output the
          -- larger into the mif files.  The type t_coefficients is set to 18 get_max
          ------------------------------------------------------------------------

          if  (param.coef_combined=1 and
               next_mac>mac and
               next_mac<param.num_macs and
               param.coef_reload=0 and
               param.coef_mem_type=c_bram ) then

            --add next macs contents to mif file in case core can pack two taps memories into one BRAM
            write_result := write_coef_data( elab_dir
                                      & gen_mif_prefix
                                      & "COEFF_auto"
                                      & int_to_str(indp_coef_paths(path)) --int_to_str(output_path) --
                                      & "_"
                                      & int_to_str(mac)
                                      & ".mif",
                                        param.coef_mem_depth+1,
                                        param.path_reqs.coef_width(indp_coef_paths(path)),
                                        mac_coefficients(next_mac),
                                        true);

          end if;
        end if;
        -- gui trans_on

        if mac_nonzero(mac)=0 and
           param.coef_reload=0 then
          --no coefficients so can optimise DSP48s
          status.num_opt_mac:=status.num_opt_mac+1;
          -- gui trans_off
          status.opt_mac(mac+1+(indp_coef_paths(path)*param.num_macs)):=1;
          -- gui trans_on
          -- gui insert_on
          -- status.opt_mac(tcl_to_int(mac+1+(indp_coef_paths(path)*param.num_macs))):=1;
          -- gui insert_off
        end if;

      end loop;

      -- gui trans_off
      if (param.filter_type=c_decimating_half_band  or
          param.filter_type=c_interpolating_half_band or
          param.filter_type=c_halfband_transform)
         and gen_mif then

        write_result := write_coef_data( elab_dir
                                    & gen_mif_prefix
                                    & "COEFF_auto_HALFBAND_CENTRE"
                                    & int_to_str(indp_coef_paths(path))
                                    &".mif",
                                      select_integer(param.num_filts,
                                                     param.num_filts*2,
                                                     param.coef_reload=1)+1,
                                      param.path_reqs.coef_width(indp_coef_paths(path)),
                                      half_band_centre_value);
        --fixed depth memory
      end if;
      -- gui trans_on

    end if;
  end loop; --path

  return status;

end;

function gen_pattern ( round_mode, accum_width, output_width : integer;
                       doubled                               : boolean;
                       width: integer
                     )
                     return bit_vector is
  --variable pattern : bit_vector(47 downto 0) := (others=>'0');
  variable pattern : bit_vector(width-1 downto 0) := (others=>'0');
begin
  
  if    round_mode = 4 then     -- Convergent Even
    if doubled then
      pattern(accum_width-output_width+1) := '1';
    else
      pattern(accum_width-output_width) := '1';
    end if;
  elsif round_mode = 5 then     -- Convergent Odd
    if doubled then
      for i in accum_width-output_width downto 1 loop
        pattern(i) := '1';
      end loop;
    else
      for i in accum_width-output_width-1 downto 0 loop
        pattern(i) := '1';
      end loop;
    end if;
  end if;
  
  return pattern;

end gen_pattern;

function gen_mask ( accum_width, output_width : integer;
                    doubled                   : boolean;
                    width: integer
                  )
                  return bit_vector is
  variable mask : bit_vector(width-1 downto 0) := (others=>'1');
begin

  if doubled then
    for i in accum_width-output_width+1 downto 1 loop
      mask(i) := '0';
    end loop;
  else
    for i in accum_width-output_width downto 0 loop
      mask(i) := '0';
    end loop;
  end if;

  return mask;

end gen_mask;

function split_wide_mif ( file_name : string;
                          num_taps,
                          num_filts,
                          coef_width_in,
                          coef_path_max_width,
                          coef_path_0_extra_bit,
                          inter_rate,
                          deci_rate : integer;
                          gen_mif_files : boolean ) return t_split_wide_mif_accum is
  
  file     read_file,
           write_file0,
           write_file1 : text;
  variable dataline,
           outline     : line;
  -- variable bv,
           -- bv_zeros    : bit_vector(coef_width_in-1 downto 0):=(others=>'0');
  
  variable slv,
           slv_zeros    : std_logic_vector(coef_width_in-1 downto 0):=(others=>'0');
           
  -- variable sv,
           -- sv_zeros    : string(1 to coef_width_in);
           
  variable mif_status  : file_open_status;

  variable  coef_sums_lower_ovr,
            coef_sums_upper_ovr,
            coef_sums_lower,
            coef_sums_upper
            : t_int_array(inter_rate-1 downto 0):=(others=>0);

  variable  max_coef_sums_lower,
            max_coef_sums_upper,
            max_coef_sums_lower_ovr,
            max_coef_sums_upper_ovr,
            phase,
            phase_wrap: integer:=0;

  variable accum: t_split_wide_mif_accum;
  variable next_coef : integer;
  
  variable slv_out0:std_logic_vector(select_integer(coef_path_max_width,coef_path_max_width+2,coef_path_0_extra_bit>0)-1 downto 0);
  variable slv_out1:std_logic_vector(select_integer(coef_width_in-1,coef_width_in-coef_path_0_extra_bit-1,coef_path_0_extra_bit>0)  downto coef_path_max_width);
begin

  -- NOTE: this function has been modified to calculate the number of bits
  -- required for each path not just the acutal coefficient sum, easier to handle
  -- >32bit accumulation.


  file_open(mif_status,read_file,file_name,read_mode);
  if gen_mif_files then
    file_open(mif_status,write_file0,file_name&"_0",write_mode);
    file_open(mif_status,write_file1,file_name&"_1",write_mode);
  end if;

  for line in 0 to num_taps*num_filts-1 loop
    readline(read_file, dataline);
    --read(dataline, bv);
    -- read(dataline,sv);
    -- bv:=to_bitvector(str_to_slv(sv));
    read(dataline,slv);

    --generate accumulation of coefficient so accum_width can be optimized for each column.

    -- next_coef:=to_integer(unsigned(to_stdlogicvector(bv(coef_path_max_width-1 downto 0))));
    next_coef:=to_integer(unsigned(slv(coef_path_max_width-1 downto 0)));
    --if next_coef>natural'HIGH-coef_sums_lower(phase)  then --next_coef>max_int-coef_sums_lower(phase)
    if next_coef>integer(2**30)-1-coef_sums_lower(phase)  then
      --Overflow
      coef_sums_lower_ovr(phase):=coef_sums_lower_ovr(phase)+1;
      coef_sums_lower(phase):=coef_sums_lower(phase)+next_coef-integer(2**30);--natural'HIGH-1;
    else
      --Normal accumulation
      coef_sums_lower(phase):=coef_sums_lower(phase)+next_coef;
    end if;

    -- next_coef:=to_integer(unsigned(to_stdlogicvector(bv(coef_width_in-coef_path_0_extra_bit-1 downto coef_path_max_width))));
    next_coef:=to_integer(unsigned(slv(coef_width_in-coef_path_0_extra_bit-1 downto coef_path_max_width)));

    --if next_coef>natural'HIGH-coef_sums_upper(phase) then -- next_coef>max_int-coef_sums_upper(phase)
    if next_coef>integer(2**30)-1-coef_sums_upper(phase) then -- next_coef>max_int-coef_sums_upper(phase)
      --Overflow
      coef_sums_upper_ovr(phase):=coef_sums_upper_ovr(phase)+1;
      coef_sums_upper(phase):=coef_sums_upper(phase)+next_coef-integer(2**30);--natural'HIGH-1;
    else
      --Normal accumulation
      coef_sums_upper(phase):=coef_sums_upper(phase)+next_coef;
    end if;
    
     if inter_rate>1 and deci_rate>1 and inter_rate>deci_rate then
      --PQ inter
      --the more than one interpolation phase contributes to an output
      phase_wrap:=(phase_wrap+1) mod inter_rate;
      if phase_wrap=0 then
        phase:=0;
      else
        phase:=(phase+1) mod deci_rate;
      end if;
    else
      phase:=(phase+1) mod inter_rate;
    end if;

    if gen_mif_files then
      if coef_path_0_extra_bit>0 then
        --write(outline,"00"&bv(coef_path_max_width-1 downto 0));
        -- write(outline,sv(1 to coef_path_max_width)&"00");
        -- write(outline,"00"&sv(coef_width_in-coef_path_max_width+1 to coef_width_in));
        slv_out0:="00"&slv(coef_path_max_width-1 downto 0);
        -- write(outline,"00"&slv(coef_path_max_width-1 downto 0));
        write(outline,slv_out0);
        
        writeline(write_file0,outline);
        --write(outline,bv(coef_width_in-coef_path_0_extra_bit-1 downto coef_path_max_width));
        -- write(outline,sv(coef_path_max_width+1 to coef_width_in-coef_path_0_extra_bit));
        -- write(outline,sv(coef_path_0_extra_bit+1 to coef_width_in-coef_path_max_width));
        slv_out1:=slv(coef_width_in-coef_path_0_extra_bit-1 downto coef_path_max_width);
        -- write(outline,slv(coef_width_in-coef_path_0_extra_bit-1 downto coef_path_max_width));
        write(outline,slv_out1);
        
        writeline(write_file1,outline);
      else
        --write(outline,bv(coef_path_max_width-1 downto 0));
        --write(outline,sv(1 to coef_path_max_width));
        -- write(outline,sv(coef_width_in-coef_path_max_width+1 to coef_width_in));
        slv_out0:=slv(coef_path_max_width-1 downto 0);
        -- write(outline,slv(coef_path_max_width-1 downto 0));
        write(outline,slv_out0);
        
        writeline(write_file0,outline);
        --write(outline,bv(coef_width_in-1 downto coef_path_max_width));
        --write(outline,sv(coef_path_max_width+1 to coef_width_in));
        -- write(outline,sv(1 to coef_width_in-coef_path_max_width));
        slv_out1:=slv(coef_width_in-1 downto coef_path_max_width);
        -- write(outline,slv(coef_width_in-1 downto coef_path_max_width));
        write(outline,slv_out1);
        
        writeline(write_file1,outline);
      end if;
      --Had to change to use a different line variable than is used to read in for the source mif
      --as XST kept crashing. Its happy when a different variable name is used.
    end if;
    
    -- report "coef_sums_lower(phase): "&int_to_str(coef_sums_lower(phase))&" coef_sums_lower_ovr(phase): "&int_to_str(coef_sums_lower_ovr(phase))&" coef_sums_upper(phase): "&int_to_str(coef_sums_upper(phase))&" coef_sums_upper_ovr(phase): "&int_to_str(coef_sums_upper_ovr(phase))&" coef_width_in: "&int_to_str(coef_width_in)&" coef_path_max_width: "&int_to_str(coef_path_max_width)&" coef_path_0_extra_bit: "&int_to_str(coef_path_0_extra_bit);

    if (line+1) mod num_taps = 0 then
      max_coef_sums_lower:=get_max(max_coef_sums_lower,max_val(coef_sums_lower));
      max_coef_sums_upper:=get_max(max_coef_sums_upper,max_val(coef_sums_upper));
      max_coef_sums_lower_ovr:=get_max(max_coef_sums_lower_ovr,max_val(coef_sums_lower_ovr));
      max_coef_sums_upper_ovr:=get_max(max_coef_sums_upper_ovr,max_val(coef_sums_upper_ovr));
      coef_sums_lower:=(others=>0);
      coef_sums_upper:=(others=>0);
      coef_sums_lower_ovr:=(others=>0);
      coef_sums_upper_ovr:=(others=>0);
    end if;

  end loop;

  --Write extra line to output mifs, XST bug that maybe still occurs
  -- sv_zeros:=slv_to_str(to_stdlogicvector(bv_zeros));  
  if gen_mif_files then
    if coef_path_0_extra_bit>0 then
      slv_out0:="00"&slv_zeros(coef_path_max_width-1 downto 0);
      -- write(outline,"00"&slv_zeros(coef_path_max_width-1 downto 0));
      write(outline,slv_out0);
      writeline(write_file0,outline);
      slv_out1:=slv_zeros(coef_width_in-coef_path_0_extra_bit-1 downto coef_path_max_width);
      -- write(outline,slv_zeros(coef_width_in-coef_path_0_extra_bit-1 downto coef_path_max_width));
      write(outline,slv_out1);
      writeline(write_file1,outline);
    else
      --write(outline,bv_zeros(coef_path_max_width-1 downto 0));
      -- write(outline,sv_zeros(1 to coef_path_max_width));
      slv_out0:=slv(coef_path_max_width-1 downto 0);
      -- write(outline,slv_zeros(coef_path_max_width-1 downto 0));
      write(outline,slv_out0);
      writeline(write_file0,outline);
      --write(outline,bv_zeros(coef_width_in-1 downto coef_path_max_width));
      -- write(outline,sv_zeros(coef_path_max_width+1 to coef_width_in));
      slv_out1:=slv(coef_width_in-1 downto coef_path_max_width);
      -- write(outline,slv_zeros(coef_width_in-1 downto coef_path_max_width));
      write(outline,slv_out1);
      writeline(write_file1,outline);
    end if;
  end if;

  file_close(read_file);

  if gen_mif_files then
    file_close(write_file0);
    file_close(write_file1);
  end if;
  
  accum.coef_sums_lower_bits:=select_integer(log2roundup(max_coef_sums_lower),(31+log2roundup(max_coef_sums_lower_ovr)),max_coef_sums_lower_ovr>0);
  accum.coef_sums_upper_bits:=select_integer(log2roundup(max_coef_sums_upper),(31+log2roundup(max_coef_sums_upper_ovr)),max_coef_sums_upper_ovr>0);

  return accum;
end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_single_rate.vhd

  function define_single_rate(reqs:t_reqs;
                              elab_dir,
                              comp_name,
                              mif_file:string;
                              gen_mif: boolean;
                              gen_reorder_seq: boolean) return t_define_single_rate is
  ------------------------------------------------------------------------------

    variable struct: t_define_single_rate;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              filter_sel_dly,
              addr_dly,
              pre_sym_delay,
              sym_param_est_orig,
              casc_data_width,
              p_WE_SYM_OUT_index :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    -- variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.data_sign:=reqs.data_sign;
    struct.param.coef_sign:=reqs.coef_sign;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=reqs.symmetry;
    struct.param.neg_symmetry:=reqs.neg_symmetry;
    struct.param.odd_symmetry:=select_integer(0,reqs.num_taps rem 2,struct.param.symmetry=1);
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+struct.param.odd_symmetry;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;

      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;
          
      struct.param.base_count := struct.param.clk_per_chan;

      struct.param.num_macs := struct.param.num_taps_calced/struct.param.base_count;

      if ( struct.param.num_taps_calced rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      struct.param.base_count:=struct.param.num_taps_calced/struct.param.num_macs;
      if (struct.param.num_taps_calced rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;

      if struct.param.base_count<struct.param.clk_per_chan then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count;

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := 1;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;

      if (struct.param.clk_per_chan=1 and
          struct.param.num_channels=1 and
          struct.param.symmetry=0 and
          (not reqs.family.has_fabric_dsp48) ) then
        --use data cascade

        --clear sign for filt_arm as will be extended at this level
        if (reqs.family.supports_dsp48e) then
          casc_data_width:=30;
          if max_val(reqs.path_reqs.coef_width)+max_val(reqs.path_reqs.coef_sign) > 18 then
            casc_data_width:=18;
          end if;
        else
          casc_data_width:=18;
        end if;
        for path in 0 to struct.param.path_reqs.data_width'LENGTH-1 loop
          struct.param.path_reqs.data_width(path):=0;
          if path < reqs.num_paths then
            struct.param.path_reqs.data_width(path):=casc_data_width;
          end if;
        end loop;
      end if;


      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*reqs.num_channels;
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);


      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);
      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb        =>struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.cyc_to_data_out:=struct.memory_path_lat.data+1;--plus one for the latch (min depth of 1 in delay)

      struct.cyc_to_write:=0;
      if (struct.mem_param.data_mem_type/=c_srl16) then
        struct.cyc_to_write:=struct.param.base_count; --inter_we_cycles
      end if;

      struct.num_cyc_read_earily:= select_integer(0,1,struct.cyc_to_write+struct.param.odd_symmetry-struct.cyc_to_data_out<0)
                                  +select_integer(0,1,struct.param.odd_symmetry=1);
      --add odd sym when calc if need earily read as when odd sym will read data earily this gives longer to get
      --data out of memory. So then check if still don't have enough time to get data out of memory

      struct.change_src:=select_integer(0,1,struct.num_cyc_read_earily>=struct.param.base_count);

      struct.extra_dly:=select_integer(
                          0,
                          select_integer(
                            reqs.num_channels-1,
                            reqs.num_channels,
                            struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                            --test is moved past another WE pulse by reading earily
                          struct.num_cyc_read_earily-struct.param.odd_symmetry>0 and
                          struct.change_src=0);

      --------------------------------------------------------------------------
      struct.add_sup_dly:=struct.memory_path_lat.data;

      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      --------------------------------------------------------------------------
      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.base_count=1 and struct.param.num_macs>1) or (struct.param.num_macs=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );

      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;

      struct.cmux_required  := false;
      struct.pinfb_dynamic  := false;
      struct.pinfb_constant := false;
      
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;

      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if; 
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;

      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
      --when rounder used with multi-path assume that all accum_widths are the same. When
      --used for >18/25-bit rounding occurs external to this block.

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder and pass=0 then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      --Previously this was just set in the record below and referenced through but
      --for the GUI the output_index and output_src are removed from the record.
      p_WE_SYM_OUT_index:=struct.param.num_macs+(struct.cyc_to_data_out-1)-struct.num_cyc_read_earily;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => struct.param.num_channels+1,
          inter_sym_tap_delay => struct.param.num_channels+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb       => struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => select_integer(0,1,
                                            struct.param.clk_per_chan=1 and
                                            struct.param.num_channels=1 and
                                            struct.param.symmetry=0 and
                                            (not reqs.family.has_fabric_dsp48)),
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder
                                              and (struct.param.single_mac=1 or struct.param.full_parallel=1)),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => p_WE_SYM_OUT_index,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => select_integer(1,0,struct.change_src=1),
                            p_D_SYM_OUT   => 0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len             => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                         -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.num_macs=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> reqs.has_nd,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               ((reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                               not struct.accum_req and
                               not struct.has_rounder)
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;
      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;
      
      if struct.param.no_data_mem=1 and struct.param.symmetry=1 and struct.filt_arm.sym_para_struct=1 then
        pre_sym_delay:=(struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1);
        if reqs.family.lut6 then
          pre_sym_delay:=(pre_sym_delay/33)+select_integer(0,1,pre_sym_delay rem 33 > 0);
        else
          pre_sym_delay:=(pre_sym_delay/17)+select_integer(0,1,pre_sym_delay rem 17 > 0);
        end if;
        pre_sym_delay:=pre_sym_delay*max_val(reqs.path_reqs.data_width);

        sym_param_est_orig:=pre_sym_delay+struct.filt_arm_lat.para_sym_slice_est;

        struct.filt_arm.sym_para_struct:=3;
        struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        --change to fully delay sym structure

        if struct.filt_arm_lat.para_sym_slice_est >= sym_param_est_orig then
          --revert back to predelay structure
          struct.filt_arm.sym_para_struct:=1;
          struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        end if;
      end if;

      if (  struct.param.symmetry=1 and
            pass=0 and
            struct.filt_arm_lat.sym_inter_buff_depth>1089 and
            reqs.data_mem_type=c_mem_forced_dist ) then

        --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
        struct.param.symmetry:=0;
        struct.param.neg_symmetry:=0;
        struct.param.odd_symmetry:=0;
        struct.param.num_taps_calced:=reqs.num_taps;
        pass:=1;
      else
        pass:=2;
      end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on

    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,
          --this delay has been calced for the output of the filter arm, reuse but
          --multiply by 2 as need to account for recombination of pcin
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(i),
          b_sign         => struct.param.path_reqs.coef_sign(i),
          d_sign         => struct.param.path_reqs.data_sign(i),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                  select_func_list(
                                    (0=>PCIN_add_C,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    reqs.family.treat_as_s3adsp),
                                  struct.round_first_cycle),
                                (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then -- and i=0 then
        --struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;
      -- gui trans_on

--       report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));

    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => 1,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                               struct.shorter_px_time),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count,
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,
    
      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 1,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time);

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1 < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat;
    end if;

    --Check delays for latching signal for sym wrap over-----
    struct.we_sym_dly:=struct.addr_cntrl_lat
                       +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                       +struct.first_tap_extra_dly;

    if p_WE_SYM_OUT_index<=0 and
       struct.param.symmetry=1 then
      --will not be able to get latching signal for wrap over as not enough mac in filt arm
      --if struct.we_sym_dly-1+struct.filt_arm.output_index(p_WE_SYM_OUT)<0 then
      if struct.we_sym_dly-1+p_WE_SYM_OUT_index<0 then
        --not enough latency to read earily from generation delay so add latency to addr gen.
        addr_dly:=addr_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        filter_sel_dly:=filter_sel_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.we_sym_dly:=struct.addr_cntrl_lat
                           +get_max(struct.data_addr_lat,struct.coef_addr_lat);
      end if;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.write_phase_dly :=struct.data_addr_param.write_phase_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.sub_block_end_dly :=struct.data_addr_param.sub_block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );

    struct.vector_cnt_len:=select_integer(
                              select_integer(
                                reqs.num_taps,
                                (reqs.num_taps/2)+struct.param.num_taps_calced,
                                struct.param.symmetry=1),
                              ((struct.param.num_taps_calced*integer(2**struct.param.symmetry))-struct.param.odd_symmetry),
                              reqs.coef_reload=1);

    --Latency Calculation
    struct.buffer_type:=0;
    struct.buffer_page_size:=0;
    struct.latency:=struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
      -- struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
      -- macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
      -- if struct.accum_req and
        -- (not reqs.family.has_fabric_dsp48) then
        -- struct.num_dsp:=struct.num_dsp+1;
      -- end if;
      -- if struct.has_rounder and
        -- (not reqs.family.has_fabric_dsp48) then
        -- struct.num_dsp:=struct.num_dsp+1;
      -- end if;
      -- struct.num_dsp_per_path:=struct.num_dsp;
      -- if  struct.param.data_combined=0 and
          -- struct.param.data_coef_combined=0 and
          -- struct.param.no_data_mem=0 and
          -- struct.param.data_mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
      -- end if;
    -- 
      -- if  struct.param.symmetry=1 and
          -- struct.param.no_data_mem=0 and
          -- struct.param.data_mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
      -- end if;
    -- 
      -- if struct.param.coef_mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
      -- end if;
    -- else
      -- for path in 0 to reqs.num_paths-1 loop
        -- struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
        -- macs_used:=struct.param.num_macs;
        -- for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
          -- if struct.filt_arm_lat.opt_dsp(mac)=1 then
            -- struct.num_dsp:=struct.num_dsp-1;
          -- end if;
          -- if mif_status.opt_mac(mac)=1 then
            -- macs_used:=macs_used-1;
          -- end if;
        -- end loop;
        -- if struct.accum_req and
           -- (not reqs.family.has_fabric_dsp48) then
          -- struct.num_dsp:=struct.num_dsp+1;
        -- end if;
        -- if struct.has_rounder and
        -- (not reqs.family.has_fabric_dsp48) then
          -- struct.num_dsp:=struct.num_dsp+1;
        -- end if;
        -- if path = 0 then
          -- struct.num_dsp_per_path:=struct.num_dsp;
        -- end if;
        -- if reqs.path_reqs.data_src(path)=path then
          -- if  struct.param.no_data_mem=0 and
              -- struct.param.data_mem_type=c_bram then
            -- if struct.param.data_combined=1 then
              -- if struct.param.symmetry=1 then
                -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
              -- else
                -- struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
              -- end if;
            -- else
              -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
              -- if struct.param.symmetry=1 then
                -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
              -- end if;
            -- end if;
          -- end if;
        -- end if;
    -- 
        -- if reqs.path_reqs.coef_src(path)=path then
          -- if struct.param.coef_mem_type=c_bram then
            -- if struct.param.coef_combined=1 then
              -- struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
            -- else
              -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
            -- end if;
          -- end if;
        -- end if;
      -- end loop;
    -- end if;
    -- 
    -- if struct.param.symmetry=1 then
      -- struct.num_bram:=struct.num_bram+calc_delay_bram(reqs.data_width,
                                                       -- select_integer(
                                                          -- select_integer(
                                                            -- struct.filt_arm.inter_tap_delay-1+struct.extra_dly,
                                                            -- select_integer(
                                                              -- (struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1),
                                                              -- 0,
                                                              -- struct.filt_arm.sym_para_struct=3),
                                                            -- reqs.has_nd=1 and struct.param.no_data_mem=1),
                                                          -- 0,
                                                          -- reqs.has_nd=0 and struct.param.no_data_mem=1 and struct.param.odd_symmetry=1),
                                                       -- select_integer(
                                                        -- c_mem_forced_dist,
                                                        -- reqs.datapath_mem_type,
                                                        -- reqs.has_nd=1 and struct.param.no_data_mem=1),
                                                       -- reqs.family);
      -- struct.num_bram:=struct.num_bram+struct.filt_arm_lat.num_datapath_bram;
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_decimation.vhd

  function define_decimation( reqs:t_reqs;
                              elab_dir,
                              comp_name,
                              mif_file:string;
                              gen_mif: boolean;
                              gen_reorder_seq: boolean) return t_define_decimation is
  ------------------------------------------------------------------------------

    variable struct: t_define_decimation;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              filter_sel_dly,
              addr_dly
              :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- variable wrap_over_settings: t_settings;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=reqs.symmetry;
    struct.param.neg_symmetry:=reqs.neg_symmetry;
    struct.param.odd_symmetry:=select_integer(0,reqs.num_taps rem 2,struct.param.symmetry=1);
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+struct.param.odd_symmetry;

    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;
          
      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;

      struct.param.base_count := struct.param.clk_per_chan;

      taps_per_phase:= struct.param.num_taps_calced / reqs.deci_rate;
      if ( struct.param.num_taps_calced rem reqs.deci_rate > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/struct.param.base_count;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      struct.param.base_count:=taps_per_phase/struct.param.num_macs;
      if (taps_per_phase rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;

      if struct.param.base_count<struct.param.clk_per_chan and struct.param.base_count>1 then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;

      struct.param.base_coef_space := struct.param.base_count*reqs.deci_rate;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*reqs.deci_rate;

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := reqs.deci_rate;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;

      struct.output_rate:=struct.param.clk_per_chan*reqs.deci_rate;

      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;


      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_count))*(reqs.num_channels*reqs.deci_rate);
      data_depth_packed:=struct.param.base_count*reqs.num_channels*reqs.deci_rate;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_count*reqs.num_channels*reqs.deci_rate));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb       => struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     => reqs.resource_opt );
  
      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.wrap_over_param:=(
        family            =>struct.param.family,
        implementation    =>1,
        base_count        =>struct.param.base_count,
        num_phases        =>struct.param.deci_rate,
        num_channels      =>struct.param.num_channels,
        sym_type          =>struct.param.odd_symmetry,
        driving_mem_type  =>struct.param.data_mem_type,
        driving_mem_lat   =>struct.memory_path_lat.data,
        force_srl16_mem   =>select_integer(0,1,reqs.datapath_mem_type=c_mem_forced_dist),
        has_ce            =>reqs.has_ce,
        has_nd            =>reqs.has_nd );

      struct.wrap_over_lat:=lat_polyphase_decimation_sym_wrap(struct.wrap_over_param);

      if reqs.has_nd=0 and struct.param.base_count=1 and struct.param.symmetry=1 then

        if struct.wrap_over_lat>=struct.param.num_macs then
          struct.para_sym_struct:=1;
        else
          struct.para_sym_struct:=2;
        end if;

      elsif reqs.has_nd=1 and struct.param.base_count=1 and struct.param.symmetry=1 then
        struct.para_sym_struct:=1;
      else
        struct.para_sym_struct:=0;
      end if;

      struct.add_sup_dly:=struct.memory_path_lat.data;
      
      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.single_mac=1) then
        struct.accum_req:=false;
      end if;
      
      struct.has_rounder :=
            (  reqs.round_mode>1                       and reqs.num_channels>1 and struct.param.full_parallel=1 and struct.param.single_mac=1)
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or (  reqs.round_mode=3                       and reqs.family.emb_calc_prim=p_dsp48 and reqs.num_channels>1 and struct.param.single_mac=1
                                                       and (reqs.accum_width-reqs.output_width)>35 and reqs.allow_approx=0 and struct.shorter_px_time)
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.allow_approx=0 and not struct.shorter_px_time )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.allow_approx=1 and struct.param.full_parallel=1 and reqs.num_channels>1 );

      --Rounding settings---------------------------------------
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;

      struct.pinfb_dynamic :=  reqs.round_mode>1
                           and not struct.has_rounder
                           and reqs.num_channels>1
                           and not struct.round_spare_cycle
                           and struct.param.single_mac=0
                           and (reqs.family.treat_as_s3adsp or (reqs.family.emb_calc_prim=p_dsp48 and (reqs.accum_width-reqs.output_width)>35) ); 

      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  )--;
                              and not(struct.pinfb_dynamic);

      struct.cmux_required  :=  reqs.round_mode>1
                            and not struct.has_rounder
                            and reqs.num_channels>1
                            and (  struct.param.single_mac=1
                                or (struct.round_spare_cycle and reqs.family.emb_calc_prim=p_dsp48 and (reqs.accum_width-reqs.output_width)>35)
                                );

      struct.pinfb_constant := struct.param.single_mac=1
                           and not struct.has_rounder
                           and reqs.num_channels=1
                           and reqs.round_mode>1;

      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;
  
        --struct.rounder_delay:=struct.rounder_delay+struct.accum_lat.pout_latency;
      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if; 
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;

      struct.rounder(0):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => reqs.path_reqs.accum_width(0),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
      --The rounder in this structure can be used in extened multiply structures so need one for
      --each path with the correct post add width set.

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder(0).pattern:=reqs.ext_pattern;
        struct.rounder(0).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder(0));
        if struct.accum_req or not struct.use_rounder_pcin then
          struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
        end if;
        --if rounder_pcin used then the delay added for the pout_lat from the filter arm is the only extra
        --delay required for p cascade recombination.
        --struct.rounder_delay:=struct.rounder_delay+dtls_emb_calc(struct.rounder(0)).pout_latency;
      end if;
      
      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => (struct.param.num_channels*reqs.deci_rate)+1,
          inter_sym_tap_delay => (struct.param.num_channels*reqs.deci_rate)+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb       => struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,--fabric
                                            (struct.param.single_mac=1 and reqs.num_channels>1 and not struct.cmux_required)
                                            or (struct.param.single_mac=1 and reqs.num_channels>1 and struct.cmux_required)
                                            or (struct.pinfb_dynamic or struct.pinfb_constant)),
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs
                                             +select_integer(
                                                0,
                                                -1,
                                                struct.para_sym_struct=2),
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs
                                             +select_integer(
                                                0,
                                                -1,
                                                struct.para_sym_struct=2),
                            p_WE_SYM_OUT  => struct.param.num_macs,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs-1 ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => 1,
                            p_D_SYM_OUT   => 0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.single_mac=1),
          sym_para_struct => select_integer(0,1,struct.para_sym_struct=1),--reqs.has_nd,
          para_casc_we_src=> select_integer(0,1, reqs.has_nd=1 or struct.shorter_px_time),
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
                                 
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>C_add_A_mult_B,2=>P_add_A_mult_B,3=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>C_add_A_mult_B,2=>P_add_A_mult_B,3=>P_add_C,4=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed,
          p_has_redundant => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed and struct.param.single_mac=1,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (reqs.num_channels>1 and not(reqs.family.treat_as_s3adsp)) or
                               (reqs.num_channels=1 and struct.round_first_cycle and not(reqs.family.treat_as_s3adsp)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );
          --para_casc_we_src selects if a constant we is used which is OK but the parallel structure can be a long delay line
          --even when no ND when there is not enough taps to to look forward enough. The struct.para_sym_struct parammeter
          --controls the symmetric structure used

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;
      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

      if (  struct.param.symmetry=1 and
            pass=0 and
            struct.filt_arm_lat.sym_inter_buff_depth>1089 and
            reqs.data_mem_type=c_mem_forced_dist ) then

        --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
        struct.param.symmetry:=0;
        struct.param.neg_symmetry:=0;
        struct.param.odd_symmetry:=0;
        struct.param.num_taps_calced:=reqs.num_taps;
        pass:=1;
      else
        pass:=2;
      end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    
    struct.accum_c_as_pcin:=false;
    if reqs.num_paths>1 and 
       reqs.family.has_fabric_dsp48 and 
       reqs.resource_opt=c_speed and 
       reqs.num_channels>1  and
       struct.accum_req and
       reqs.has_ext_output_src then
      --need to re-arrange how the split sums are recombined. Use filt arm recombine, ie P_OUT rather than
      --PC_OUT. Route to C of accum. This is required for multi-channel as the phase results are stored externally
      --and if PC_OUT is used the accum_op_casc can be generated at different times for each path as the accum_width
      --for each path can be different. So, need the input to each paths accum to be at the same time, and if P_OUT is
      --use they will be balanced and occur at the same time.
      for i in 0 to reqs.num_paths-1 loop
        if struct.filt_arm_lat.config(i).tap_n.p_delay>0 then
        --only need to do this if there is a big enough difference in
        --accum width such that there is differing number of splits
        --in the accumulator for each path
          struct.accum_c_as_pcin:=true;
        end if;
      end loop;
    end if;

    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => select_integer(2,1,struct.accum_c_as_pcin)*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          --implement_extra_dly => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_A_concat_B,2=>PCIN_add_P,3=>NOP),
                                  (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                  struct.round_first_cycle and reqs.num_channels=1),
                                select_func_list(
                                  (0=>C,1=>C_add_A_concat_B,2=>P_add_C,3=>NOP),
                                  (0=>C_add_A_concat_B,1=>P_add_C,2=>NOP),
                                  struct.round_first_cycle and reqs.num_channels=1),
                                struct.accum_c_as_pcin)),
                          --parameter only relavent to non-DSP48 familys
          split_post_adder => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed,
          has_redundant => select_integer(p_none,p_A_concat_B,reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed)
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;
      -- gui trans_on

      --Borrow loop for mutlipath rounder assignments
      struct.rounder(i):=struct.rounder(0); --get defaults
      struct.rounder(i).p_delay:=struct.filt_arm_lat.config(i).tap_n.p_delay;
      struct.rounder(i).post_add_width:=struct.param.path_reqs.accum_width(i);

    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req and not struct.accum_c_as_pcin)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    struct.use_c_port_as_storage:=true;
    if (   reqs.resource_opt=c_speed and reqs.has_ce=1 and struct.param.no_data_mem=0 )
        or struct.cmux_required
        or reqs.num_channels=1 then
        
      struct.use_c_port_as_storage:=false;
    end if;
    
    --Output buffer ram settings---------------------------------
    struct.output_buffer_depth:=2*reqs.num_channels;

    struct.has_output_buffer:=false;
    if reqs.num_channels>1 then
      struct.has_output_buffer:=true;
    end if;

    struct.output_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.output_buffer_depth>dram_mem_depth_thres and reqs.opbuff_mem_type/=c_mem_forced_dist) or
                               reqs.opbuff_mem_type=c_mem_forced_bram ),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    struct.output_buffer_in_addr:=(
      family => reqs.family,
      implementation => implementation,
      addr_width => get_max(1,log2roundup(struct.output_buffer_depth)),
      page_size => reqs.num_channels,
      num_enables => 1 );
    
    struct.output_buffer_out_addr:=struct.output_buffer_in_addr;

    struct.output_rate_counter:=(
        cnt1_max_val    => struct.output_rate,
        cnt2_max_val    => 1,
        cnt3_max_val    => 1,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );

    struct.extra_opb_reg:=0;
    if struct.has_output_buffer and reqs.resource_opt=c_speed and struct.output_buffer.mem_type=c_dram then
        struct.extra_opb_reg:=1;
    end if;

    if struct.has_output_buffer then
      struct.output_buffer_lat:=lat_ram(struct.output_buffer,2);
    else
      struct.output_buffer_lat:=0;
    end if;

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => reqs.deci_rate,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels*reqs.deci_rate,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                               struct.shorter_px_time),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count, 
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.deci_rate,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count*reqs.deci_rate,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 0,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => select_integer(0,1,reqs.num_channels>1),
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);
    struct.reload_cntrl_param_lat.filt_sel_lat:=struct.reload_cntrl_param_lat.filt_sel_lat+1;-- +2;--1;
    --add one as filter sel latch is done using we_gen_dly , rather than nd_rfd. This is    --we_gen
    --to allign correctly with first_phase   
    --UPDATE: the delay struct.filter_sel_lat generates the delay of one cycle, only need to account
    --for an extra delay

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time);

    if reqs.num_filts>1 or reqs.coef_reload=1 then --same delay effects reload
      struct.filter_sel_lat:=1;
      --have added a delay to filter sel as need to recycle value
    else
      struct.filter_sel_lat:=0;
    end if;

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat-struct.filter_sel_lat;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    
    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.para_sym_addr_delay:=0;
    if struct.para_sym_struct=2 then

      struct.para_sym_delay:=(struct.param.deci_rate*reqs.num_channels)+1
                             -struct.wrap_over_lat;

    elsif struct.para_sym_struct=1 then

--       report "FIR: addr gen delay: "&int_to_str(get_max(struct.data_addr_lat,struct.coef_addr_lat)+struct.addr_cntrl_lat);---1);
--       report "FIR: wrap buffer delay: "&int_to_str(struct.wrap_over_lat);

      if (get_max(struct.data_addr_lat,struct.coef_addr_lat)+struct.addr_cntrl_lat-- -1
          +struct.data_dly_modifier) > struct.wrap_over_lat then
        struct.para_sym_delay:= (get_max(struct.data_addr_lat,struct.coef_addr_lat)+struct.addr_cntrl_lat+struct.data_dly_modifier) -
                                struct.wrap_over_lat;
      else
        struct.para_sym_delay:=0;
        struct.para_sym_addr_delay:=struct.wrap_over_lat -
                                    (get_max(struct.data_addr_lat,struct.coef_addr_lat)+struct.addr_cntrl_lat-- -1
                                     +struct.data_dly_modifier);

        struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly         +struct.para_sym_addr_delay;
        struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly  +struct.para_sym_addr_delay;
        struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly +struct.para_sym_addr_delay;
        struct.coef_addr_param.en_dly             :=struct.coef_addr_param.en_dly             +struct.para_sym_addr_delay;
        struct.coef_addr_param.base_max_dly       :=struct.coef_addr_param.base_max_dly       +struct.para_sym_addr_delay;
        struct.coef_addr_param.skip_base_max_dly  :=struct.coef_addr_param.skip_base_max_dly  +struct.para_sym_addr_delay;
        struct.coef_addr_param.count_max_dly      :=struct.coef_addr_param.count_max_dly      +struct.para_sym_addr_delay;
        struct.coef_addr_param.filt_sel_dly       :=struct.coef_addr_param.filt_sel_dly       +struct.para_sym_addr_delay;
      end if;
    end if;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );

    struct.vector_cnt_len:=get_max(
                           select_integer(
                              select_integer(
                                taps_per_phase,
                                taps_per_phase+(struct.param.num_taps_calced/struct.param.deci_rate),--some phases have even sym
                                struct.param.symmetry=1),
                              (((struct.param.num_taps_calced/struct.param.deci_rate)*integer(2**struct.param.symmetry))),
                              reqs.coef_reload=1),
                            2);--need to count out a minimum of one output when rate=taps as first output could be corrupt, second will be OK

    --Latency Calculation
    struct.buffer_type:=select_integer(0,2,struct.has_output_buffer);
    struct.buffer_page_size:=reqs.num_channels;
    struct.sample_latency:=(reqs.num_channels*(reqs.deci_rate-1))+1;
    struct.latency:=struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.para_sym_addr_delay
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pout_latency+select_integer(0,1,struct.accum_c_as_pcin),struct.accum_req)
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +select_integer(0,struct.output_buffer_lat+
                                      struct.output_rate+
                                      struct.extra_opb_reg+
                                      select_integer(0,3,reqs.has_chan0_in=1),
                                    struct.has_output_buffer)
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.param.symmetry=1 then
    --   if struct.para_sym_struct=1 then
    --     struct.num_bram:=struct.num_bram+calc_delay_bram(reqs.data_width,(struct.param.num_macs-1)*(struct.filt_arm.inter_tap_delay-1),reqs.datapath_mem_type,reqs.family);
    --   end if;
    --   wrap_over_settings:=gen_settings(struct.wrap_over_param);
    --   if wrap_over_settings.ram_param.mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+calc_num_bram(reqs.data_width,
    --                                                     struct.wrap_over_param.num_channels*(integer(2**log2roundup(
    --                                                       struct.wrap_over_param.num_phases
    --                                                       +select_integer(0,1,struct.wrap_over_param.sym_type=1)))),
    --                                                    reqs.family);
    --   end if;
    --   struct.num_bram:=struct.num_bram+struct.filt_arm_lat.num_datapath_bram;
    -- end if;
    -- 
    -- if struct.has_output_buffer and struct.output_buffer.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.output_width,struct.output_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband.vhd

  function define_halfband( reqs:t_reqs;
                                    elab_dir,
                                    comp_name,
                                    mif_file:string;
                                    gen_mif: boolean;
                                    gen_reorder_seq: boolean) return t_define_halfband is
  ------------------------------------------------------------------------------

    variable struct: t_define_halfband;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- reqs.family.lut6);
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- reqs.family.lut6);
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              filter_sel_dly,
              addr_dly,
              pre_sym_delay,
              sym_param_est_orig,
              p_WE_SYM_OUT_index :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=1;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+1;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;

      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;
          
      struct.param.base_count := struct.param.clk_per_chan;

      taps_per_phase:= struct.param.num_taps_calced/ 2;
      if ( struct.param.num_taps_calced rem 2 > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs :=taps_per_phase/ struct.param.base_count;

      struct.param.single_mac:=0;
      if struct.param.num_macs=0 then
        struct.param.single_mac:=1;
      end if;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      if struct.param.single_mac=1 then
        --SMAC
        struct.param.base_count:=taps_per_phase+1;
      else
        --Normal
        struct.param.base_count:=taps_per_phase/struct.param.num_macs;
        if (taps_per_phase rem struct.param.num_macs >0) then
          struct.param.base_count:=struct.param.base_count+1;
        end if;
      end if;

      if struct.param.base_count<struct.param.clk_per_chan then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*(struct.param.base_count-struct.param.single_mac)*2;
      --base count is extended by one for single mac but the multiply by 2 shouldn't be applied to that
      --extra value as the *2 is to insert the zero phase which the centre tap is one off.

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := 2;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;

      --Structural decisions------------------------------------------------------


      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*(reqs.num_channels*2);
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels*2;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels*2));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb        =>struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.cyc_to_data_out:=struct.memory_path_lat.data+1;--plus one for the latch (min depth of 1 in delay)

      struct.cyc_to_write:=0;
      if (struct.mem_param.data_mem_type/=c_srl16) then
        struct.cyc_to_write:=struct.param.base_count; --inter_we_cycles
      end if;

      struct.num_cyc_read_earily:= select_integer(0,1,struct.cyc_to_write+struct.param.odd_symmetry-struct.cyc_to_data_out<0)
                                  +select_integer(0,1,struct.param.odd_symmetry=1);
      --add odd sym when calc if need earily read as when odd sym will read data earily this gives longer to get
      --data out of memory. So then check if still don't have enough time to get data out of memory

      struct.change_src:=select_integer(0,1,struct.num_cyc_read_earily>=struct.param.base_count);

      struct.extra_dly:=select_integer(
                          0,
                          select_integer(
                            (2*reqs.num_channels)-1,--1,
                            (2*reqs.num_channels),--2,
                            struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                            --test is moved past another WE pulse by reading earily
                          struct.num_cyc_read_earily-struct.param.odd_symmetry>0 and
                          struct.change_src=0);

      struct.add_sup_dly:=struct.memory_path_lat.data;

      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.single_mac=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );


      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;

      struct.cmux_required  := false;
      struct.pinfb_dynamic  := struct.round_first_cycle and struct.param.full_parallel=0 and struct.param.single_mac=0
                           and not struct.has_rounder;
      struct.pinfb_constant := (  ( struct.round_first_cycle and (struct.param.full_parallel=1 or struct.param.single_mac=1) )
                               or ( struct.round_spare_cycle and struct.param.single_mac=1                                   )
                               )
                           and not struct.has_rounder;

      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;
        
      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if; 
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;

      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
      
      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      p_WE_SYM_OUT_index:=struct.param.num_macs+(struct.cyc_to_data_out-1)-struct.num_cyc_read_earily;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => (struct.param.num_channels*2)+1,
          inter_sym_tap_delay => (struct.param.num_channels*2)+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_add_swapped,(reqs.family.emb_calc_prim=p_dsp48a or reqs.family.emb_calc_prim=p_dsp48a1) and struct.param.single_mac=1),--add
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb        =>struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => select_integer(
                                                struct.param.num_macs,
                                                struct.param.centre_mac,
                                                struct.param.symmetry=0),
                                              --when sym=0 then sym has been disable, sym=1 is default
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,-- +1,
                            p_WE_SYM_OUT  => p_WE_SYM_OUT_index,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2=> select_integer(
                                                struct.param.num_macs,
                                                struct.param.centre_mac,
                                                struct.param.symmetry=0)
                                              +struct.memory_path_lat.data ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => select_integer(1,0,struct.change_src=1),
                            p_D_SYM_OUT   => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_C_OUT       => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2=> 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.single_mac=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> reqs.has_nd,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48))
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;

      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

      if struct.param.no_data_mem=1 and struct.param.symmetry=1 and struct.filt_arm.sym_para_struct=1 then
        pre_sym_delay:=(struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1);
        if reqs.family.lut6 then
          pre_sym_delay:=(pre_sym_delay/33)+select_integer(0,1,pre_sym_delay rem 33 > 0);
        else
          pre_sym_delay:=(pre_sym_delay/17)+select_integer(0,1,pre_sym_delay rem 17 > 0);
        end if;
        pre_sym_delay:=pre_sym_delay*max_val(reqs.path_reqs.data_width);
        
        sym_param_est_orig:=pre_sym_delay+struct.filt_arm_lat.para_sym_slice_est;
        
        struct.filt_arm.sym_para_struct:=3;
        struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        --change to fully delay sym structure

        if struct.filt_arm_lat.para_sym_slice_est >= sym_param_est_orig then
          --revert back to predelay structure
          struct.filt_arm.sym_para_struct:=1;
          struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        end if;
      end if;

--       if (  struct.param.symmetry=1 and
--             pass=0 and
--             struct.filt_arm_lat.sym_inter_buff_depth>1089 and
--             reqs.data_mem_type=c_mem_forced_dist ) then
-- 
--         --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
--         struct.param.symmetry:=0;
--         struct.param.neg_symmetry:=0;
--         struct.param.odd_symmetry:=0;
--         struct.param.num_taps_calced:=reqs.num_taps;
--         pass:=1;
--       else
        pass:=2;
--       end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          b_sign         => struct.param.path_reqs.coef_sign(struct.param.path_reqs.coef_src(i)),
          d_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          a_width        => 1,
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern         => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask            => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                (0=>PCIN_add_A_mult_B,1=>PCIN_add_P,2=>NOP),
                                (0=>PCIN_add_A_mult_B,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        --struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));
  
      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));
      -- gui trans_on

    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Centre tap coefficient store-------------------------------
    struct.centre_tap_coef:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                                select_integer(
                                  c_dram,
                                  select_integer(c_bram,c_dram,reqs.coef_mem_type=c_mem_forced_dist),
                                  reqs.num_filts > srl16_mem_depth_thres),
                                select_integer(
                                  c_dram,
                                  select_integer(c_bram,c_dram,reqs.coef_mem_type=c_mem_forced_dist),
                                  reqs.num_filts*2 >dram_mem_depth_thres),
                                reqs.coef_reload=1 ),
      write_mode          => 0,
      has_ce              => reqs.has_ce,
      use_mif             => 1,
      resource_opt        => c_area,
      is_rom              => reqs.coef_reload=0 );

    if reqs.coef_reload=1 then
      struct.centre_tap_coef_lat:=lat_ram(struct.centre_tap_coef,2);
    else
      struct.centre_tap_coef_lat:=lat_ram(struct.centre_tap_coef,1);
    end if;
    
    struct.centre_tap_coef_extra_reg:=0;
    if reqs.resource_opt=c_speed and
       reqs.num_paths/get_num_indp_paths(reqs.num_paths,reqs.path_reqs.coef_src)>1 and
       struct.centre_tap_coef.mem_type=c_bram then
      struct.centre_tap_coef_extra_reg:=1;
    end if;

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => 2,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels*2,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                               struct.shorter_px_time),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => select_integer(reqs.resource_opt,c_area,struct.param.single_mac=1),
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );
        --for SMAC the data address is modified with an add, does not need extra
        --register for Sandia.

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count,
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);
    
    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => select_integer(1,0,struct.param.single_mac=1),
      latch_filt_sel => 1,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time);

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1 < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat;
    end if;

    --Check delays for latching signal for sym wrap over-----
    struct.we_sym_dly:=struct.addr_cntrl_lat
                       +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                       +struct.first_tap_extra_dly
                       -1;

    if p_WE_SYM_OUT_index<=0 and struct.param.symmetry=1 then
      --will not be able to get latching signal for wrap over as not enough mac in filt arm
      if struct.we_sym_dly-1+p_WE_SYM_OUT_index<0 then
        --not enough latency to read earily from generation delay so add latency to addr gen.
        addr_dly:=addr_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        filter_sel_dly:=filter_sel_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.we_sym_dly:=struct.addr_cntrl_lat
                          +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                          -1;
      end if;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    
    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +struct.param.single_mac
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +struct.param.single_mac
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +struct.param.single_mac
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +struct.param.single_mac
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +struct.param.single_mac
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
                                            
    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.addr_cntrl_lat:=struct.addr_cntrl_lat+struct.param.single_mac;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );

    struct.vector_cnt_len:=select_integer(
                            select_integer(
                              reqs.num_taps,
                              (reqs.num_taps/2)+struct.param.num_taps_calced,
                              struct.param.symmetry=1),
                            ((struct.param.num_taps_calced*integer(2**struct.param.symmetry))-struct.param.odd_symmetry),
                            reqs.coef_reload=1);

    --Latency Calculation
    struct.buffer_type:=0;
    struct.buffer_page_size:=0;
    struct.latency:=struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req  then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     not reqs.family.has_fabric_dsp48 then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    --
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    --
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    --
    --   if struct.accum_req and struct.centre_tap_coef.mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+calc_num_bram(reqs.coef_width,select_integer(reqs.num_filts,2*reqs.num_filts,reqs.coef_reload=1),reqs.family);
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --        not reqs.family.has_fabric_dsp48 then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    --
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --
    --       if struct.accum_req and struct.centre_tap_coef.mem_type=c_bram then
    --         struct.num_bram:=struct.num_bram+calc_num_bram(reqs.path_reqs.coef_width(path),select_integer(reqs.num_filts,2*reqs.num_filts,reqs.coef_reload=1),reqs.family);
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    --
    -- if struct.param.symmetry=1 then
    --   struct.num_bram:=struct.num_bram+calc_delay_bram(reqs.data_width,
    --                                                    select_integer(
    --                                                     struct.filt_arm.inter_tap_delay-1+struct.extra_dly,
    --                                                     select_integer(
    --                                                         (struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1),
    --                                                         0,
    --                                                         struct.filt_arm.sym_para_struct=3),
    --                                                     reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                    select_integer(
    --                                                     c_mem_forced_dist,
    --                                                     reqs.datapath_mem_type,
    --                                                     reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                    reqs.family);
    --   struct.num_bram:=struct.num_bram+struct.filt_arm_lat.num_datapath_bram;
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_interpolated.vhd

  function define_interpolated( reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_interpolated is
  ------------------------------------------------------------------------------

    variable struct: t_define_interpolated;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              filter_sel_dly,
              addr_dly,
              pre_sym_delay,
              sym_param_est_orig,
              p_WE_SYM_OUT_index :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=reqs.symmetry;
    struct.param.neg_symmetry:=reqs.neg_symmetry;
    struct.param.odd_symmetry:=select_integer(0,reqs.num_taps rem 2,struct.param.symmetry=1);
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+struct.param.odd_symmetry;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;

      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;
          
      struct.param.base_count := struct.param.clk_per_chan;

      struct.param.num_macs := struct.param.num_taps_calced/struct.param.base_count;

      if ( struct.param.num_taps_calced rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      struct.param.base_count:=struct.param.num_taps_calced/struct.param.num_macs;
      if (struct.param.num_taps_calced rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;

      if struct.param.base_count<struct.param.clk_per_chan then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count;

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := reqs.zero_packing_factor;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;

      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*(reqs.num_channels*reqs.zero_packing_factor);
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels*reqs.zero_packing_factor;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels*reqs.zero_packing_factor));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb        =>struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);
  
      struct.cyc_to_data_out:=struct.memory_path_lat.data+1;--plus one for the latch (min depth of 1 in delay)
      
      struct.cyc_to_write:=0;
      if (struct.mem_param.data_mem_type/=c_srl16) then
        struct.cyc_to_write:=struct.param.base_count; --inter_we_cycles
      end if;

      struct.num_cyc_read_earily:= select_integer(0,1,struct.cyc_to_write+struct.param.odd_symmetry-struct.cyc_to_data_out<0)
                                  +select_integer(0,1,struct.param.odd_symmetry=1);
      --add odd sym when calc if need earily read as when odd sym will read data earily this gives longer to get
      --data out of memory. So then check if still don't have enough time to get data out of memory

      struct.change_src:=select_integer(0,1,struct.num_cyc_read_earily>=struct.param.base_count);

      struct.extra_dly:=select_integer(
                          0,
                          select_integer(
                            (reqs.zero_packing_factor*reqs.num_channels)-1,
                            (reqs.zero_packing_factor*reqs.num_channels),
                            struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                            --test is moved past another WE pulse by reading earily
                          struct.num_cyc_read_earily-struct.param.odd_symmetry>0 and
                          struct.change_src=0);

      struct.add_sup_dly:=struct.memory_path_lat.data;

      struct.first_tap_extra_dly:=0;
      
      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.base_count=1 and struct.param.num_macs>1) or (struct.param.num_macs=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );

      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;
  
      struct.cmux_required  := false;
      struct.pinfb_dynamic  := false;
      struct.pinfb_constant := false;
      
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;
        
        --struct.rounder_delay:=struct.rounder_delay+struct.accum_lat.pout_latency;
      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if;
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;
  
      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      p_WE_SYM_OUT_index:=struct.param.num_macs+(struct.cyc_to_data_out-1)-struct.num_cyc_read_earily;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => (struct.param.num_channels*reqs.zero_packing_factor)+1,
          inter_sym_tap_delay => (struct.param.num_channels*reqs.zero_packing_factor)+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb        =>struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder and (struct.param.single_mac=1 or struct.param.full_parallel=1)),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => p_WE_SYM_OUT_index,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => select_integer(1,0,struct.change_src=1),
                            p_D_SYM_OUT   => 0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.num_macs=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> reqs.has_nd,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and 
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;
      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;
      
      if struct.param.no_data_mem=1 and struct.param.symmetry=1 and struct.filt_arm.sym_para_struct=1 then
        pre_sym_delay:=(struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1);
        if reqs.family.lut6 then--has_lut6(reqs.family) then
          pre_sym_delay:=(pre_sym_delay/33)+select_integer(0,1,pre_sym_delay rem 33 > 0);
        else
          pre_sym_delay:=(pre_sym_delay/17)+select_integer(0,1,pre_sym_delay rem 17 > 0);
        end if;
        pre_sym_delay:=pre_sym_delay*max_val(reqs.path_reqs.data_width);
        
        sym_param_est_orig:=pre_sym_delay+struct.filt_arm_lat.para_sym_slice_est;
        
        struct.filt_arm.sym_para_struct:=3;
        struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        --change to fully delay sym structure

        if struct.filt_arm_lat.para_sym_slice_est >= sym_param_est_orig then
          --revert back to predelay structure
          struct.filt_arm.sym_para_struct:=1;
          struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        end if;
      end if;

      if (  struct.param.symmetry=1 and
            pass=0 and
            struct.filt_arm_lat.sym_inter_buff_depth>1089 and
            reqs.data_mem_type=c_mem_forced_dist ) then

        --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
        struct.param.symmetry:=0;
        struct.param.neg_symmetry:=0;
        struct.param.odd_symmetry:=0;
        struct.param.num_taps_calced:=reqs.num_taps;
        pass:=1;
      else
        pass:=2;
      end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(i),
          b_sign         => struct.param.path_reqs.coef_sign(i),
          d_sign         => struct.param.path_reqs.data_sign(i),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                  select_func_list(
                                    (0=>PCIN_add_C,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    reqs.family.treat_as_s3adsp),
                                  struct.round_first_cycle),
                                (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));
      -- gui trans_on
    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => reqs.zero_packing_factor,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels*reqs.zero_packing_factor,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                               struct.shorter_px_time),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count, 
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                 struct.shorter_px_time),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 1,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time);

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1 < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat;
    end if;

    --Check delays for latching signal for sym wrap over-----
    struct.we_sym_dly:=struct.addr_cntrl_lat
                       +struct.first_tap_extra_dly
                       +get_max(struct.data_addr_lat,struct.coef_addr_lat);

    if p_WE_SYM_OUT_index<=0 and struct.param.symmetry=1 then
      --will not be able to get latching signal for wrap over as not enough mac in filt arm
      if struct.we_sym_dly-1+p_WE_SYM_OUT_index<0 then
        --not enough latency to read earily from generation delay so add latency to addr gen.
        addr_dly:=addr_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        filter_sel_dly:=filter_sel_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.we_sym_dly:=struct.addr_cntrl_lat
                           +get_max(struct.data_addr_lat,struct.coef_addr_lat);
      end if;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );

    struct.vector_cnt_len:=((select_integer(
                              select_integer(
                                reqs.num_taps,
                                (reqs.num_taps/2)+struct.param.num_taps_calced,
                                struct.param.symmetry=1),
                              ((struct.param.num_taps_calced*integer(2**struct.param.symmetry))-struct.param.odd_symmetry),
                              reqs.coef_reload=1)-1)*reqs.zero_packing_factor);

    --Latency Calculation
    struct.buffer_type:=0;
    struct.buffer_page_size:=0;
    struct.latency:=struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.param.symmetry=1 then
    --   struct.num_bram:=struct.num_bram+calc_delay_bram(reqs.data_width,
    --                                                    select_integer(
    --                                                       select_integer(
    --                                                         struct.filt_arm.inter_tap_delay-1+struct.extra_dly,
    --                                                         select_integer(
    --                                                           (struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1),
    --                                                           0,
    --                                                           struct.filt_arm.sym_para_struct=3),
    --                                                         reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                       0,
    --                                                       reqs.has_nd=0 and struct.param.no_data_mem=1 and struct.param.odd_symmetry=1),
    --                                                    select_integer(
    --                                                     c_mem_forced_dist,
    --                                                     reqs.datapath_mem_type,
    --                                                     reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                    reqs.family);
    --   struct.num_bram:=struct.num_bram+struct.filt_arm_lat.num_datapath_bram;
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_hilbert.vhd

  function define_hilbert(reqs:t_reqs;
                          elab_dir,
                          comp_name,
                          mif_file:string;
                          gen_mif: boolean;
                          gen_reorder_seq: boolean) return t_define_hilbert is
  ------------------------------------------------------------------------------

    variable struct: t_define_hilbert;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- reqs.family.lut6);
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- reqs.family.lut6);
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              filter_sel_dly,
              addr_dly,
              pre_sym_delay,
              sym_param_est_orig,
              p_WE_SYM_OUT_index  :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=1;
    struct.param.neg_symmetry:=1;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+1;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;

      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;
          
      struct.param.base_count := struct.param.clk_per_chan;

      taps_per_phase:= struct.param.num_taps_calced/ 2;
      if ( struct.param.num_taps_calced rem 2 > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/struct.param.base_count;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      struct.param.base_count:=taps_per_phase/struct.param.num_macs;
      if (taps_per_phase rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;
      
      if struct.param.base_count<struct.param.clk_per_chan then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*2;

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := 2;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;

      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*(reqs.num_channels*2);
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels*2;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels*2));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb       => struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);
  
      struct.cyc_to_data_out:=struct.memory_path_lat.data+1;--plus one for the latch (min depth of 1 in delay)

      struct.cyc_to_write:=0;
      if (struct.mem_param.data_mem_type/=c_srl16) then
        struct.cyc_to_write:=struct.param.base_count; --inter_we_cycles
      end if;

      struct.num_cyc_read_earily:= select_integer(0,1,struct.cyc_to_write+struct.param.odd_symmetry-struct.cyc_to_data_out<0)
                                  +select_integer(0,1,struct.param.odd_symmetry=1);
      --add odd sym when calc if need earily read as when odd sym will read data earily this gives longer to get
      --data out of memory. So then check if still don't have enough time to get data out of memory

      struct.change_src:=select_integer(0,1,struct.num_cyc_read_earily>=struct.param.base_count);

      struct.extra_dly:=select_integer(
                          0,
                          select_integer(
                            (2*reqs.num_channels)-1,--1,
                            (2*reqs.num_channels),--2,
                            struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                            --test is moved past another WE pulse by reading earily
                          struct.num_cyc_read_earily-struct.param.odd_symmetry>0 and
                          struct.change_src=0);

      struct.add_sup_dly:=struct.memory_path_lat.data;
      
      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      -- struct.has_rounder := true;
      struct.accum_req:=true;
      if (struct.param.base_count=1 and struct.param.num_macs>1) or
         (struct.param.num_macs=1) then
        struct.accum_req:=false;
      end if;
      
      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );

      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;
      
      struct.cmux_required  := false;
      struct.pinfb_dynamic  := false;
      struct.pinfb_constant := false;
      
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;
        
        --struct.rounder_delay:=struct.rounder_delay+struct.accum_lat.pout_latency;
      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if; 
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;
  
      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;--struct.rounder_delay:=struct.rounder_delay+dtls_emb_calc(struct.rounder).pout_latency;
      end if;


      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      p_WE_SYM_OUT_index:=struct.param.num_macs+(struct.cyc_to_data_out-1)-struct.num_cyc_read_earily;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => (struct.param.num_channels*2)+1,
          inter_sym_tap_delay => (struct.param.num_channels*2)+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb       => struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder and (struct.param.single_mac=1 or struct.param.full_parallel=1)),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => select_integer(
                                                struct.param.num_macs,
                                                struct.param.centre_mac,
                                                struct.param.symmetry=0),
                                              --when sym=0 then sym has been disable, sym=1 is default
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => p_WE_SYM_OUT_index,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => select_integer(
                                                  struct.param.num_macs,
                                                  struct.param.centre_mac,
                                                  struct.param.symmetry=0)
                                                +struct.memory_path_lat.data ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => select_integer(1,0,struct.change_src=1),
                            p_D_SYM_OUT   => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_C_OUT       => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len   => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.num_macs=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> reqs.has_nd,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;
      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

      if struct.param.no_data_mem=1 and struct.param.symmetry=1 and struct.filt_arm.sym_para_struct=1 then
        pre_sym_delay:=(struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1);
        if reqs.family.lut6 then
          pre_sym_delay:=(pre_sym_delay/33)+select_integer(0,1,pre_sym_delay rem 33 > 0);
        else
          pre_sym_delay:=(pre_sym_delay/17)+select_integer(0,1,pre_sym_delay rem 17 > 0);
        end if;
        pre_sym_delay:=pre_sym_delay*max_val(reqs.path_reqs.data_width);
        
        sym_param_est_orig:=pre_sym_delay+struct.filt_arm_lat.para_sym_slice_est;
        
        struct.filt_arm.sym_para_struct:=3;
        struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        --change to fully delay sym structure

        if struct.filt_arm_lat.para_sym_slice_est >= sym_param_est_orig then
          --revert back to predelay structure
          struct.filt_arm.sym_para_struct:=1;
          struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        end if;
      end if;

      if (  struct.param.symmetry=1 and
            pass=0 and
            struct.filt_arm_lat.sym_inter_buff_depth>1089 and
            reqs.data_mem_type=c_mem_forced_dist ) then

        --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
        struct.param.symmetry:=0;
        struct.param.neg_symmetry:=0;
        struct.param.odd_symmetry:=0;
        struct.param.num_taps_calced:=reqs.num_taps;
        pass:=1;
      else
        pass:=2;
      end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(i),
          b_sign         => struct.param.path_reqs.coef_sign(i),
          d_sign         => struct.param.path_reqs.data_sign(i),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                  select_func_list(
                                    (0=>PCIN_add_C,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    reqs.family.treat_as_s3adsp),
                                  struct.round_first_cycle),
                                (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));
      -- gui trans_on

    end loop;

    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => 2,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels*2,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                               struct.shorter_px_time),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count,
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                 struct.shorter_px_time),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 1,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time);

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1 < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat;
    end if;

    --Check delays for latching signal for sym wrap over-----
    struct.we_sym_dly:=struct.addr_cntrl_lat
                       +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                       +struct.first_tap_extra_dly;

    if p_WE_SYM_OUT_index<=0 and struct.param.symmetry=1 then
      --will not be able to get latching signal for wrap over as not enough mac in filt arm
      if struct.we_sym_dly-1+p_WE_SYM_OUT_index<0 then
        --not enough latency to read earily from generation delay so add latency to addr gen.
        addr_dly:=addr_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        filter_sel_dly:=filter_sel_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.we_sym_dly:=struct.addr_cntrl_lat
                           +get_max(struct.data_addr_lat,struct.coef_addr_lat);
      end if;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    
    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    
    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;
    
    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );

    struct.vector_cnt_len:=select_integer(
                              select_integer(
                                reqs.num_taps,
                                (reqs.num_taps/2)+struct.param.num_taps_calced,
                                struct.param.symmetry=1),
                              ((struct.param.num_taps_calced*integer(2**struct.param.symmetry))-struct.param.odd_symmetry),
                              reqs.coef_reload=1);

    --Latency Calculation
    struct.buffer_type:=0;
    struct.buffer_page_size:=0;
    struct.latency:=struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    --
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    --
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    --
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    --
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --
    --     end if;
    --   end loop;
    -- end if;
    --
    -- if struct.param.symmetry=1 then
    --   struct.num_bram:=struct.num_bram+calc_delay_bram(reqs.data_width,
    --                                                    select_integer(
    --                                                     struct.filt_arm.inter_tap_delay-1+struct.extra_dly,
    --                                                     select_integer(
    --                                                         (struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1),
    --                                                         0,
    --                                                         struct.filt_arm.sym_para_struct=3),
    --                                                     reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                    select_integer(
    --                                                     c_mem_forced_dist,
    --                                                     reqs.datapath_mem_type,
    --                                                     reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                    reqs.family);
    --   struct.num_bram:=struct.num_bram+struct.filt_arm_lat.num_datapath_bram;
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_interpolation.vhd

  function define_interpolation(reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_interpolation is
  ------------------------------------------------------------------------------

    variable struct: t_define_interpolation;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              data_addr_dly,
              coef_addr_dly
              :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;
    
    struct.param.symmetry:=0;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+struct.param.odd_symmetry;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;

      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;

      if (struct.param.clk_per_chan rem reqs.inter_rate > 0) then
        -- report "FIR: the available clock cycles is not evenly divisable by the interpolation rate, this means there will be unused clock cycles" severity note;
      end if;

      struct.param.base_count := struct.param.clk_per_chan / reqs.inter_rate;
      
      taps_per_phase:= struct.param.num_taps_calced/ reqs.inter_rate;
      if ( struct.param.num_taps_calced rem reqs.inter_rate > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/struct.param.base_count;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      struct.base_count_op_rate:=struct.param.base_count;

      --Adjust for unused cycles
      struct.param.base_count:=taps_per_phase/struct.param.num_macs;
      if (taps_per_phase rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;

      struct.shorter_px_time:=false;
      if struct.base_count_op_rate>struct.param.base_count then
        struct.shorter_px_time:=true;
      end if;
      
      struct.sing_chan_short_block:=false;
      if reqs.num_channels=1 and struct.shorter_px_time=false and
         (struct.param.clk_per_chan > struct.param.base_count*reqs.inter_rate) then
        struct.sing_chan_short_block:=true;
      end if;

      struct.param.centre_mac:=struct.param.num_macs;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count*reqs.inter_rate;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*reqs.inter_rate;

      struct.param.inter_rate := reqs.inter_rate;
      struct.param.deci_rate  := 1;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.full_parallel := 1;
        if (reqs.num_channels=1) then
          struct.param.no_data_mem := 1;
        end if;
      end if;

      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*reqs.num_channels;
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb        =>struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.add_sup_dly:=struct.memory_path_lat.data;

      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.base_count=1 and struct.param.num_macs>1) or
         (struct.param.num_macs=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );
    
      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;
  
      struct.cmux_required  := false;
      struct.pinfb_dynamic  := false;
      struct.pinfb_constant := false;
      
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;
        
        --struct.rounder_delay:=struct.rounder_delay+struct.accum_lat.pout_latency;
      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if;
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;
  
      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          --implement_extra_dly => 0,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => struct.param.num_channels+1,
          inter_sym_tap_delay => 0,
          --no symmetry support in this structure
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb        =>struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder and (struct.param.single_mac=1 or struct.param.full_parallel=1)),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => struct.param.num_macs,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => 0,
                            p_D_SYM_OUT   => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_C_OUT       => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.num_macs=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> 1,--reqs.has_nd,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and 
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
    
    struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;
    struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_addr_extra_delay;
    struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(i),
          b_sign         => struct.param.path_reqs.coef_sign(i),
          d_sign         => struct.param.path_reqs.data_sign(i),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          --implement_extra_dly => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                  select_func_list(
                                    (0=>PCIN_add_C,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    reqs.family.treat_as_s3adsp),
                                  struct.round_first_cycle),
                                (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;
      -- gui trans_on
    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Input buffer settings--------------------------------------
    struct.has_input_buffer:=false;
    struct.input_buffer_lat:=0;
    struct.input_buffer_depth:=2*reqs.num_channels;
    struct.input_buffer_cntrl_dly:=0;

    if struct.shorter_px_time then
      struct.input_buffer_cntrl_dly:=1;
    end if;

    struct.input_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.input_buffer_depth>dram_mem_depth_thres and reqs.ipbuff_mem_type/=c_mem_forced_dist) or
                               reqs.ipbuff_mem_type=c_mem_forced_bram ),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    struct.input_buffer_in_addr:=(
      family => reqs.family,
      implementation => implementation,
      addr_width => get_max(1,log2roundup(struct.input_buffer_depth)),
      page_size => reqs.num_channels,
      num_enables => 2 );

    if reqs.num_channels>1 then
      struct.has_input_buffer:=true;
      struct.input_buffer_lat:=lat_ram(struct.input_buffer,2);

      if struct.shorter_px_time then
        struct.input_buffer_lat:=struct.input_buffer_lat+1;
        --need to qualify chan_max in this case to push out input buffer latency by a cycle
        --will it tolerate a delay on starting the read, ie will the addresses over lap,
        --maybe prob in fully parallel.
      end if;

    end if;

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => select_integer(
                              struct.param.base_count,
                              struct.base_count_op_rate,
                              struct.shorter_px_time),
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => reqs.inter_rate,
        cnt2_max_qual   => select_integer(1,0,struct.shorter_px_time),
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 1,--use the repeat address structure
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time or
                                                struct.sing_chan_short_block),
        block_end_dly   => select_integer(0,1, struct.param.base_count=1 and reqs.num_channels>1 and
                                                ((reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time) ),
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false);

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count, 
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.inter_rate,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time or
                                                struct.sing_chan_short_block),
        base_max_dly      => select_integer(0,1, struct.param.base_count=1 and reqs.num_channels>1 and
                                                ((reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time) ),
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count*struct.param.inter_rate,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 0,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => select_integer(0,1,struct.param.num_channels>1),
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time or
                                struct.sing_chan_short_block) ;

    --Balance delays
    
    if struct.has_input_buffer then
      if struct.input_buffer_lat>(struct.addr_cntrl_lat) then
        struct.data_dly:=0;
        struct.filt_dly:=0;
        struct.addr_dly:=struct.input_buffer_lat-(struct.addr_cntrl_lat);
      else
        struct.data_dly:=(struct.addr_cntrl_lat)-struct.input_buffer_lat;
        struct.filt_dly:=(struct.addr_cntrl_lat)-struct.input_buffer_lat;
        struct.addr_dly:=0;
      end if;
    else
      struct.filt_dly:=struct.addr_cntrl_lat;
      struct.data_dly:=struct.addr_cntrl_lat;
      struct.addr_dly:=0;
    end if;

    if reqs.coef_reload=1 then

      if struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat) <= 0 then
        --need to delay address generation
        struct.addr_dly:=struct.addr_dly+abs( (struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat)) );
        struct.data_dly:=struct.data_dly+abs( (struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat)) );
        --also need to delay data to allign correctly
        struct.filt_dly:=0;
      else
        --subtract some delay from filt dly
        struct.filt_dly:=struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat);
      end if;

    end if;

    data_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat);

    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.write_phase_dly :=struct.data_addr_param.write_phase_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.sub_block_end_dly :=struct.data_addr_param.sub_block_end_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    coef_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat);

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  := struct.coef_addr_param.base_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly := struct.coef_addr_param.skip_base_max_dly+
                                                coef_addr_dly+
                                                struct.addr_dly
                                                +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly := struct.coef_addr_param.count_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=  struct.coef_addr_param.filt_sel_dly+
                                            coef_addr_dly+
                                            struct.filt_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,        
        has_nd          => reqs.has_nd );

    struct.vector_cnt_len:=select_integer(
                              ((reqs.num_taps/reqs.inter_rate)+
                                select_integer(0,1,reqs.num_taps rem reqs.inter_rate>0))
                              *reqs.inter_rate,
                              struct.param.num_taps_calced,
                              reqs.coef_reload=1)-(struct.param.inter_rate-1);
    --Latency Calculation
    struct.buffer_type:=select_integer(0,1,struct.has_input_buffer);
    struct.buffer_page_size:=reqs.num_channels;
    struct.latency:=select_integer(0,1,struct.has_input_buffer)
                    --only have latency of 1 to gen the ipb_start_op signal as the memory latency gets reflected in addr_dly
                    +struct.base_count_op_rate
                    +struct.addr_cntrl_lat-- -1
                    +struct.addr_dly
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.has_input_buffer and struct.input_buffer.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.data_width,struct.input_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband_decimation.vhd

  function define_halfband_decimation(reqs:t_reqs;
                                      elab_dir,
                                      comp_name,
                                      mif_file:string;
                                      gen_mif: boolean;
                                      gen_reorder_seq: boolean) return t_define_halfband_decimation is
  ------------------------------------------------------------------------------

    variable struct: t_define_halfband_decimation;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- reqs.family.lut6);
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- reqs.family.lut6);
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              data_addr_dly,
              coef_addr_dly,
              pre_sym_delay,
              sym_param_est_orig,
              p_WE_SYM_OUT_index :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=1;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+1;

    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;
          
      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;

      struct.param.base_count := (reqs.clk_per_samp*2) / reqs.num_channels;
      
      taps_per_phase:= struct.param.num_taps_calced/ 2;
      if ( struct.param.num_taps_calced rem 2 > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/struct.param.base_count;

      struct.param.single_mac:=0;
      if struct.param.num_macs=0 then
        struct.param.single_mac:=1;
      end if;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      struct.base_count_op_rate:=struct.param.base_count;

      --Adjust for unused cycles
      if struct.param.single_mac=1 then
        --in this case the px time will always be shorter than the output rate as the input rate is mutliplied by two
        --this always gives an even time available and in a single mac case will only ever need odd num cycles for
        --calculations so cal assume it will generate the shorter_px_time structure
        struct.param.base_count:=taps_per_phase;

      else
        struct.param.base_count:=taps_per_phase/struct.param.num_macs;
        if (taps_per_phase rem struct.param.num_macs >0) then
          struct.param.base_count:=struct.param.base_count+1;
        end if;
      end if;

      struct.shorter_px_time:=false;
      if struct.base_count_op_rate>struct.param.base_count then
        struct.shorter_px_time:=true;
      end if;

      struct.shorter_px_time_smac:=false;
      if struct.base_count_op_rate>struct.param.base_count+1 then
        struct.shorter_px_time_smac:=true;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count+struct.param.single_mac;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*2;

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := 1;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;


      --Structural decisions------------------------------------------------------


      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*reqs.num_channels;
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb       => struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.cyc_to_data_out:=struct.memory_path_lat.data+1;--plus one for the latch (min depth of 1 in delay)

      struct.cyc_to_write:=0;
      --need to account for when has a short px time
      if (struct.mem_param.data_mem_type/=c_srl16) then
        struct.cyc_to_write:=struct.cyc_to_write+struct.param.base_count; --inter_we_cycles
      end if;

      struct.num_cyc_read_earily:= select_integer(0,1,struct.cyc_to_write+struct.param.odd_symmetry-struct.cyc_to_data_out<0)
                                  +select_integer(0,1,struct.param.odd_symmetry=1);
      --add odd sym when calc if need earily read as when odd sym will read data earily this gives longer to get
      --data out of memory. So then check if still don't have enough time to get data out of memory

      struct.change_src:=select_integer(0,1,struct.num_cyc_read_earily>=struct.param.base_count);


      struct.extra_dly:=select_integer(
                          0,
                          select_integer(
                            reqs.num_channels-1,
                            reqs.num_channels,
                            struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                            --test is moved past another WE pulse by reading earily
                          struct.num_cyc_read_earily-struct.param.odd_symmetry>0 and
                          struct.change_src=0);

      struct.add_sup_dly:=struct.memory_path_lat.data
                          +(2*struct.param.single_mac);

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;

      struct.has_rounder :=
            (   (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (    reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or (   (reqs.round_mode=2 or reqs.round_mode=3)
            and (reqs.allow_approx=0
            and not ( (struct.shorter_px_time_smac and struct.param.single_mac=1)
                    or (struct.shorter_px_time     and struct.param.single_mac=0)
                    )
                )
            );

      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not (  (struct.shorter_px_time_smac and struct.param.single_mac=1)
                                          or (struct.shorter_px_time      and struct.param.single_mac=0)
                                          )
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and (  (struct.shorter_px_time_smac and struct.param.single_mac=1)
                                    or (struct.shorter_px_time      and struct.param.single_mac=0)
                                    );

      struct.cmux_required  := false;
      struct.pinfb_dynamic  := struct.round_first_cycle and struct.param.full_parallel=0 and struct.param.single_mac=0;
      struct.pinfb_constant := struct.round_first_cycle and (struct.param.full_parallel=1 or struct.param.single_mac=1);
      
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;

      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if; 
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;
  
      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
      
      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

    --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      p_WE_SYM_OUT_index:=struct.param.num_macs+(struct.cyc_to_data_out-1)-struct.num_cyc_read_earily;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => struct.param.num_channels+1,
          inter_sym_tap_delay => struct.param.num_channels+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => c_preadd_add,
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb       => struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => select_integer(
                                              struct.param.num_macs+1,
                                              struct.param.num_macs,
                                              struct.param.single_mac=1),--so accum not attached to any other dsp48's
                            p_PC_OUT      => select_integer(
                                              struct.param.num_macs+1,
                                              struct.param.num_macs,
                                              struct.param.single_mac=1),
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => p_WE_SYM_OUT_index,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT      => 0,
                            p_D_OUT       => select_integer(1,0,struct.change_src=1 and struct.param.single_mac=0),
                            --when smac will do the src change at this level as need output of ram on the d_out port
                            p_D_SYM_OUT   => 1,--0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => 0,
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> reqs.has_nd,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc((0=>NOP)),--filt arm not used for single mac
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48))
          );
          
      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

      if struct.param.no_data_mem=1 and struct.param.symmetry=1 and struct.filt_arm.sym_para_struct=1 then
        pre_sym_delay:=(struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1);
        if reqs.family.lut6 then
          pre_sym_delay:=(pre_sym_delay/33)+select_integer(0,1,pre_sym_delay rem 33 > 0);
        else
          pre_sym_delay:=(pre_sym_delay/17)+select_integer(0,1,pre_sym_delay rem 17 > 0);
        end if;
        pre_sym_delay:=pre_sym_delay*max_val(reqs.path_reqs.data_width);

        sym_param_est_orig:=pre_sym_delay+struct.filt_arm_lat.para_sym_slice_est;
        
        struct.filt_arm.sym_para_struct:=3;
        struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        --change to fully delay sym structure

        if struct.filt_arm_lat.para_sym_slice_est >= sym_param_est_orig then
          --revert back to predelay structure
          struct.filt_arm.sym_para_struct:=1;
          struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        end if;
      end if;

--       if (  struct.param.symmetry=1 and
--             pass=0 and
--             struct.filt_arm_lat.sym_inter_buff_depth>1089 and
--             reqs.data_mem_type=c_mem_forced_dist ) then
-- 
--         --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
--         struct.param.symmetry:=0;
--         struct.param.neg_symmetry:=0;
--         struct.param.odd_symmetry:=0;
--         struct.param.num_taps_calced:=reqs.num_taps;
--         pass:=1;
--       else
        pass:=2;
--       end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          b_sign         => struct.param.path_reqs.coef_sign(struct.param.path_reqs.coef_src(i)),
          d_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                (0=>PCIN_add_A_mult_B,1=>PCIN_add_P,2=>NOP),
                                (0=>PCIN_add_A_mult_B,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
  
      if struct.param.single_mac=1 then
        struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 1,
          pre_add_func   => select_integer(c_preadd_add,c_preadd_add_swapped,reqs.family.emb_calc_prim=p_dsp48a or reqs.family.emb_calc_prim=p_dsp48a1),
          pre_add_ipreg  => struct.filt_arm_lat.config(i).tap_1.pre_add_ipreg,
          pre_add_midreg => struct.filt_arm_lat.config(i).tap_1.pre_add_midreg,
          a_delay        => struct.filt_arm_lat.config(i).tap_1.a_delay,
          b_delay        => struct.filt_arm_lat.config(i).tap_1.b_delay,
          p_delay        => struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,  --alway from fabric
          a_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          b_sign         => struct.param.path_reqs.coef_sign(struct.param.path_reqs.coef_src(i)),
          d_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          a_width        => struct.param.path_reqs.data_width(struct.param.path_reqs.data_src(i)),
          b_width        => struct.param.path_reqs.coef_width(struct.param.path_reqs.coef_src(i)),
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                  (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                  struct.round_first_cycle),
                                (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
      end if;

      -- gui trans_off
      if reqs.has_ext_pat_det then -- and i=0 then
--         struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));
      
      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));
      -- gui trans_on
    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req and struct.param.single_mac/=1)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Input buffer settings--------------------------------------
    struct.input_buffer_lat:=0;
    struct.input_buffer_depth:=4*reqs.num_channels;

    struct.input_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.input_buffer_depth>dram_mem_depth_thres and reqs.ipbuff_mem_type/=c_mem_forced_dist) or
                               reqs.ipbuff_mem_type=c_mem_forced_bram),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    struct.input_buffer_lat:=lat_ram(struct.input_buffer,2);

    struct.input_buffer_in_addr:=(
      family => reqs.family,
      implementation => implementation,
      addr_width => get_max(1,log2roundup(struct.input_buffer_depth)),
      page_size => 2*reqs.num_channels,
      num_enables => 2 );
      
    --Centre tap coefficient store-------------------------------
    struct.centre_tap_coef:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                                select_integer(c_dram,select_integer(c_bram,c_dram,reqs.coef_mem_type=c_mem_forced_dist),reqs.num_filts>srl16_mem_depth_thres),
                                select_integer(c_dram,select_integer(c_bram,c_dram,reqs.coef_mem_type=c_mem_forced_dist),reqs.num_filts>dram_mem_depth_thres),
                                reqs.coef_reload=1 ),
      write_mode          => 0,
      has_ce              => reqs.has_ce,
      use_mif             => 1,
      resource_opt        => c_area,
      is_rom              => reqs.coef_reload=0 );

    if reqs.coef_reload=1 then
      struct.centre_tap_coef_lat:=lat_ram(struct.centre_tap_coef,2);
    else
      struct.centre_tap_coef_lat:=lat_ram(struct.centre_tap_coef,1);
    end if;

    struct.centre_tap_coef_extra_reg:=0;
    if reqs.resource_opt=c_speed and
       reqs.num_paths/get_num_indp_paths(reqs.num_paths,reqs.path_reqs.coef_src)>1 and
       struct.centre_tap_coef.mem_type=c_bram then
      struct.centre_tap_coef_extra_reg:=1;
    end if;
    
    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => select_integer(
                              struct.param.base_count,
                              struct.base_count_op_rate,
                              struct.shorter_px_time),
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => 1,
        cnt2_max_qual   => select_integer(1,0,struct.shorter_px_time and struct.param.data_mem_type/=c_srl16),
        --need unqualified so chan_max alligns with base_max_px
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count, 
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count+struct.param.single_mac,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,((reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time) and
                                                struct.param.single_mac=0),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);
    
    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count+struct.param.single_mac,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => select_integer(1,0,struct.param.single_mac=1),
      latch_filt_sel => 0,
      --coef_mem_lat => struct.memory_path_lat.coef,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time );

    --Balance delays
    -- +1 is added to the input buffer latency as it takes 2 cycles to generate the input buffer read address
    if (struct.input_buffer_lat+1)>(struct.addr_cntrl_lat) then
      struct.data_dly:=0;
      struct.filt_dly:=0;
      struct.addr_dly:=(struct.input_buffer_lat+1)-(struct.addr_cntrl_lat);
    else
      struct.data_dly:=(struct.addr_cntrl_lat)-(struct.input_buffer_lat+1);
      struct.filt_dly:=(struct.addr_cntrl_lat)-(struct.input_buffer_lat+1);
      struct.addr_dly:=0;
    end if;

    if struct.data_dly=0 and struct.param.data_mem_type=c_srl16 then
    --delay will be modifed so data and WE are earily of the address,
    --in this case it will not be able to make it any earily so
    --add a delay to everything
      struct.data_dly:=struct.data_dly+1;
      struct.filt_dly:=struct.filt_dly+1;
      struct.addr_dly:=struct.addr_dly+1;
    end if;

      struct.data_dly:=struct.data_dly+2;
      struct.addr_dly:=struct.addr_dly+2;

    if reqs.coef_reload=1 then

      if struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat) <= 0 then
        --need to delay address generation
        struct.addr_dly:=struct.addr_dly+abs( (struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat)) );
        struct.data_dly:=struct.data_dly+abs( (struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat)) );
        struct.filt_dly:=0;
      else
        --subtract some delay from filt dly
        struct.filt_dly:=struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat);
      end if;

    end if;
    
    --Check delays for latching signal for sym wrap over-----
    struct.we_sym_dly:=struct.addr_cntrl_lat
                       +struct.addr_dly
                       +get_max(struct.data_addr_lat,struct.coef_addr_lat);

    if p_WE_SYM_OUT_index<=0 and struct.param.symmetry=1 then
      --will not be able to get latching signal for wrap over as not enough mac in filt arm
      if struct.we_sym_dly-1+p_WE_SYM_OUT_index<0 then
        --not enough latency to read earily from generation delay so add latency to addr gen.
        struct.addr_dly:=struct.addr_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.filt_dly:=struct.filt_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.we_sym_dly:=struct.addr_cntrl_lat
                           +struct.addr_dly
                           +get_max(struct.data_addr_lat,struct.coef_addr_lat);
      end if;
    end if;

    data_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat);

    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    struct.data_dly:=struct.data_dly+struct.filt_arm_lat.data_addr_extra_delay;

    coef_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat);

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  := struct.coef_addr_param.base_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly := struct.coef_addr_param.skip_base_max_dly+
                                                coef_addr_dly+
                                                struct.addr_dly
                                                +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly := struct.coef_addr_param.count_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=  struct.coef_addr_param.filt_sel_dly+
                                            coef_addr_dly+
                                            struct.filt_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    if ( (reqs.clk_per_samp*2) / reqs.num_channels >
         (reqs.clk_per_samp / reqs.num_channels) * 2 ) and
         --check if gained an extra cycle from different evaluation that would require 
         --a varing input period of rfd
       ( struct.param.base_count+struct.param.single_mac = struct.base_count_op_rate )then
         --check that have used the extra cycle before unecessarily generating
         --varying input period.
      struct.rfd_param:=(
          family          => reqs.family,
          implementation  => implementation,
          cnt             => (reqs.clk_per_samp/reqs.num_channels),
          cnt_long        => (reqs.clk_per_samp/reqs.num_channels)+1,
          has_nd          => reqs.has_nd );
    else
      struct.rfd_param:=(
          family          => reqs.family,
          implementation  => implementation,
          cnt             => struct.param.clk_per_chan,
          cnt_long        => struct.param.clk_per_chan,
          has_nd          => reqs.has_nd );
    end if;

    struct.vector_cnt_len:=(struct.param.num_taps_calced); -- *2/2 -- mult by 2 for sym , div by 2 for halfband deci rate.

    --Latency Calculation
    struct.buffer_type:=1;
    struct.buffer_page_size:=2*reqs.num_channels;
    struct.latency:=1--struct.input_buffer_lat
                    --only need a delay of 1 for input buffer and mem access time accounted for in addr_dly
                    +struct.base_count_op_rate--struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +struct.addr_dly
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.param.single_mac=0 then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     not reqs.family.has_fabric_dsp48 then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.single_mac=0 and struct.centre_tap_coef.mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+calc_num_bram(reqs.coef_width,select_integer(reqs.num_filts,2*reqs.num_filts,reqs.coef_reload=1),reqs.family);
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.param.single_mac=0 then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --        not reqs.family.has_fabric_dsp48 then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    -- 
    --       if struct.param.single_mac=0 and struct.centre_tap_coef.mem_type=c_bram then
    --         struct.num_bram:=struct.num_bram+calc_num_bram(reqs.path_reqs.coef_width(path),select_integer(reqs.num_filts,2*reqs.num_filts,reqs.coef_reload=1),reqs.family);
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.param.symmetry=1 then
    --   struct.num_bram:=struct.num_bram+calc_delay_bram(reqs.data_width,
    --                                                    select_integer(
    --                                                     struct.filt_arm.inter_tap_delay-1+struct.extra_dly,
    --                                                     select_integer(
    --                                                         (struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1),
    --                                                         0,
    --                                                         struct.filt_arm.sym_para_struct=3),
    --                                                     reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                    select_integer(
    --                                                     c_mem_forced_dist,
    --                                                     reqs.datapath_mem_type,
    --                                                     reqs.has_nd=1 and struct.param.no_data_mem=1),
    --                                                    reqs.family);
    --   struct.num_bram:=struct.num_bram+struct.filt_arm_lat.num_datapath_bram;
    -- end if;
    -- 
    -- struct.num_bram:=struct.num_bram+calc_delay_bram(
    --                                   reqs.data_width,
    --                                   ((struct.param.num_taps_calced/2)*reqs.num_channels)-(reqs.num_channels-1),
    --                                   reqs.data_mem_type,
    --                                   reqs.family);
    -- if struct.input_buffer.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.data_width,struct.input_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_halfband_interpolation.vhd

  function define_halfband_interpolation( reqs:t_reqs;
                                          elab_dir,
                                          comp_name,
                                          mif_file:string;
                                          gen_mif: boolean;
                                          gen_reorder_seq: boolean) return t_define_halfband_interpolation is
  ------------------------------------------------------------------------------

    variable struct: t_define_halfband_interpolation;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- reqs.family.lut6);
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- reqs.family.lut6);
    variable implementation:integer:=1;--structural
    variable  data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              taps_per_phase,
              filter_sel_dly,
              addr_dly,
              pre_sym_delay,
              sym_param_est_orig,
              p_WE_SYM_OUT_index :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=1;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+1;
    
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;
          
      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;

      if (struct.param.clk_per_chan rem 2 > 0) then
        report "FIR: the available clock cycles is not evenly divisable by the interpolation rate, this means there will be unused clock cycles" severity note;
      end if;

      struct.param.base_count := struct.param.clk_per_chan;--(struct.param.clk_per_chan / 2)*2; --not sure if this is necessary now
      --use all avaiable cycles

      taps_per_phase:= struct.param.num_taps_calced/ 2;
      if ( struct.param.num_taps_calced rem 2 > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs :=taps_per_phase/ struct.param.base_count;
      
      struct.param.single_mac:=0;
      if struct.param.num_macs=0 then
        struct.param.single_mac:=1;
      end if;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      if struct.param.single_mac=1 then
        --SMAC
        struct.param.base_count:=taps_per_phase;
      else
        --Normal
        struct.param.base_count:=taps_per_phase/struct.param.num_macs;
        if (taps_per_phase rem struct.param.num_macs >0) then
          struct.param.base_count:=struct.param.base_count+1;
        end if;
      end if;
      
      if struct.param.base_count<struct.param.clk_per_chan then
        struct.shorter_px_time := true;
      else
        struct.shorter_px_time := false;
      end if;

      if struct.param.base_count+1<struct.param.clk_per_chan then
        struct.shorter_px_time_smac:=true;
      else
        struct.shorter_px_time_smac:=false;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;
      
      struct.output_rate:=struct.param.clk_per_chan/2;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count+struct.param.single_mac;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*2;

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := 1;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then --should never occur
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;

      --Structural decisions------------------------------------------------------

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*reqs.num_channels;
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb        =>struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.cyc_to_data_out:=struct.memory_path_lat.data+1;--plus one for the latch (min depth of 1 in delay)

      struct.cyc_to_write:=0;
      if (struct.mem_param.data_mem_type/=c_srl16) then
        struct.cyc_to_write:=struct.param.base_count; --inter_we_cycles
      end if;

      struct.num_cyc_read_earily:= select_integer(0,1,struct.cyc_to_write+struct.param.odd_symmetry-struct.cyc_to_data_out<0)
                                  +select_integer(0,1,struct.param.odd_symmetry=1);
      --add odd sym when calc if need earily read as when odd sym will read data earily this gives longer to get
      --data out of memory. So then check if still don't have enough time to get data out of memory

      struct.change_src:=select_integer(0,1,struct.num_cyc_read_earily>=struct.param.base_count);

      struct.extra_dly:=select_integer(
                          0,
                          select_integer(
                            reqs.num_channels-1,
                            reqs.num_channels,
                            struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                            --test is moved past another WE pulse by reading earily
                          struct.num_cyc_read_earily-struct.param.odd_symmetry>0 and
                          struct.change_src=0);

      struct.add_sup_dly:=struct.memory_path_lat.data+1;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.single_mac=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder :=
            (   reqs.round_mode=2                                                  )
         or (   reqs.round_mode=3 and reqs.family.treat_as_s3adsp                   )
         or (   reqs.round_mode=3
            and reqs.allow_approx=0
            and not (  (struct.shorter_px_time_smac and struct.param.single_mac=1)
                    or (struct.shorter_px_time      and struct.param.single_mac=0)
                    )
            )
         or (   reqs.round_mode=3
            and struct.param.base_count=2
            and not (  (struct.shorter_px_time_smac and struct.param.single_mac=1)
                    or (struct.shorter_px_time      and struct.param.single_mac=0)
                    )
            );
    
      --Rounding settings---------------------------------------
      struct.cmux_required  := not reqs.family.treat_as_s3adsp and reqs.round_mode>1 and not struct.has_rounder and struct.param.single_mac=0;
  
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   reqs.round_mode=3
                                    and not (  (struct.shorter_px_time_smac and struct.param.single_mac=1)
                                            or (struct.shorter_px_time      and struct.param.single_mac=0)
                                            )
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := reqs.round_mode=3
                                  and not struct.has_rounder
                                  and (  (struct.shorter_px_time_smac and struct.param.single_mac=1)
                                      or (struct.shorter_px_time      and struct.param.single_mac=0)
                                      );
  
      struct.pinfb_dynamic  := reqs.round_mode>1
                           and not struct.has_rounder
                           and not struct.round_spare_cycle
                           and struct.param.full_parallel=0
                           and struct.param.single_mac=0;
      
      struct.pinfb_constant := reqs.round_mode>1
                           and not struct.has_rounder
                           and (struct.param.full_parallel=1 or struct.param.single_mac=1);
  
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;

      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if;
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;
  
      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on
      
      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      p_WE_SYM_OUT_index:=struct.param.num_macs+(struct.cyc_to_data_out-1)-struct.num_cyc_read_earily;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => struct.param.num_channels+1,
          inter_sym_tap_delay => struct.param.num_channels+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_add_swapped,(reqs.family.emb_calc_prim=p_dsp48a or reqs.family.emb_calc_prim=p_dsp48a1) and struct.param.single_mac=1),--select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb        =>struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => select_integer(0,1,
                                            struct.param.clk_per_chan=1 and
                                            struct.param.num_channels=1 and 
                                            struct.param.symmetry=0),
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,-- +1,
                            p_WE_SYM_OUT  => p_WE_SYM_OUT_index,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs+struct.memory_path_lat.data ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => select_integer(1,0,struct.change_src=1),
                            p_D_SYM_OUT   => 0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.single_mac=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> reqs.has_nd,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(0,1,
                                                (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det)
                                            and struct.param.single_mac=1
                                            and not struct.accum_req
                                            and not struct.has_rounder
                                           ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          select_func_list(
                                            (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                            (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                            reqs.round_mode>1 and not struct.has_rounder),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => reqs.round_mode>1 and not struct.has_rounder
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

      if struct.param.no_data_mem=1 and struct.param.symmetry=1 and struct.filt_arm.sym_para_struct=1 then
        pre_sym_delay:=(struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1);
        if reqs.family.lut6 then
          pre_sym_delay:=(pre_sym_delay/33)+select_integer(0,1,pre_sym_delay rem 33 > 0);
        else
          pre_sym_delay:=(pre_sym_delay/17)+select_integer(0,1,pre_sym_delay rem 17 > 0);
        end if;
        pre_sym_delay:=pre_sym_delay*max_val(reqs.path_reqs.data_width);
        
        sym_param_est_orig:=pre_sym_delay+struct.filt_arm_lat.para_sym_slice_est;

        struct.filt_arm.sym_para_struct:=3;
        struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        --change to fully delay sym structure

        if struct.filt_arm_lat.para_sym_slice_est >= sym_param_est_orig then
          --revert back to predelay structure
          struct.filt_arm.sym_para_struct:=1;
          struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
        end if;
      end if;

--       if (  struct.param.symmetry=1 and
--             pass=0 and
--             struct.filt_arm_lat.sym_inter_buff_depth>1089 and
--             reqs.data_mem_type=c_mem_forced_dist ) then
-- 
--         --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
--         struct.param.symmetry:=0;
--         struct.param.neg_symmetry:=0;
--         struct.param.odd_symmetry:=0;
--         struct.param.num_taps_calced:=reqs.num_taps;
--         pass:=1;
--       else
        pass:=2;
--       end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          b_sign         => struct.param.path_reqs.coef_sign(struct.param.path_reqs.coef_src(i)),
          d_sign         => struct.param.path_reqs.data_sign(struct.param.path_reqs.data_src(i)),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                (0=>A_mult_B,1=>PCIN,2=>PCIN_add_P,3=>NOP),
                                (0=>C_add_A_mult_B,1=>PCIN,2=>PCIN_add_P,3=>NOP),
                                reqs.round_mode>1 and not struct.has_rounder)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        --struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_details(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_details(i).extra_carry_bits;

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));
      -- gui trans_on
    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_details(0).pout_latency:=struct.accum_details(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    struct.accum_extra_dly:=0;
    if reqs.family.treat_as_s3adsp and struct.param.single_mac=0 then
      for i in 0 to reqs.num_paths-1 loop
        struct.add_partial_prod(i):=(
          family         => reqs.family,
          implementation => 1,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,--fabric
          a_sign         => c_unsigned,
          b_sign         => c_unsigned,
          d_sign         => c_unsigned,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => false,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc( (0=>PCIN_add_A_concat_B,1=>PCIN)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_A_concat_B--p_none
          );

        struct.add_partial_prod_dtls(i):=dtls_emb_calc(struct.add_partial_prod(i));

        --this block will recombine pcin but pcout is used so the paths can not balanced
        --using p_delay. The paths with less latency need to be balance before the final 
        --accum as the opcode is generated for the longest latency path. Will need a delay
        --on PCOUT.
      end loop;

      --this is to account for the extra dsp48 to do the pre-add
      --of the first and second partial product that can't be
      --done on the accumulator normally.
      struct.accum_extra_dly:=1+struct.add_partial_prod_dtls(0).pout_latency;
    end if;

    --Centre tap coefficient store-------------------------------
    struct.centre_tap_coef:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                                select_integer(c_dram,select_integer(c_bram,c_dram,reqs.coef_mem_type=c_mem_forced_dist),reqs.num_filts>srl16_mem_depth_thres),
                                select_integer(c_dram,select_integer(c_bram,c_dram,reqs.coef_mem_type=c_mem_forced_dist),reqs.num_filts>dram_mem_depth_thres),
                                reqs.coef_reload=1 ),
      write_mode          => 0,
      has_ce              => reqs.has_ce,
      use_mif             => 1,
      resource_opt        => c_area,
      is_rom              => reqs.coef_reload=0 );

    if reqs.coef_reload=1 then
      struct.centre_tap_coef_lat:=lat_ram(struct.centre_tap_coef,2);
    else
      struct.centre_tap_coef_lat:=lat_ram(struct.centre_tap_coef,1);
    end if;
    
    struct.centre_tap_coef_extra_reg:=0;
    if reqs.resource_opt=c_speed and
       reqs.num_paths/get_num_indp_paths(reqs.num_paths,reqs.path_reqs.coef_src)>1 and
       struct.centre_tap_coef.mem_type=c_bram then
      struct.centre_tap_coef_extra_reg:=1;
    end if;
    
    --Output buffer ram settings---------------------------------
    struct.output_buffer_depth:=2*integer(2**log2roundup(2*reqs.num_channels));

    struct.output_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.output_buffer_depth>dram_mem_depth_thres and reqs.opbuff_mem_type/=c_mem_forced_dist) or
                              reqs.opbuff_mem_type=c_mem_forced_bram),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    struct.output_rate_counter:=(
        cnt1_max_val    => struct.output_rate,
        cnt2_max_val    => 2*reqs.num_channels,
        cnt3_max_val    => 1,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );

    struct.output_buffer_lat:=lat_ram(struct.output_buffer,2);

    --Address generator block settings---------------------------
    
    if (reqs.has_nd=1 and struct.param.no_data_mem=0) or struct.shorter_px_time then
      struct.addr_hold_struct:=true;
    else
      struct.addr_hold_struct:=false;
    end if;

    struct.base_chan_phase_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => 1,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,struct.addr_hold_struct),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count, 
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count+struct.param.single_mac,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,struct.addr_hold_struct and struct.param.single_mac=0),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count+struct.param.single_mac,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => select_integer(1,0,struct.param.single_mac=1),
      latch_filt_sel => 1,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                struct.addr_hold_struct);

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1 < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat;
    end if;

    --Check delays for latching signal for sym wrap over-----
    struct.we_sym_dly:=struct.addr_cntrl_lat
                       +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                       +struct.filt_arm_lat.data_addr_extra_delay;

    if p_WE_SYM_OUT_index<=0 and struct.param.symmetry=1 then
      --will not be able to get latching signal for wrap over as not enough mac in filt arm
      if struct.we_sym_dly-1+p_WE_SYM_OUT_index<0 then
        --not enough latency to read earily from generation delay so add latency to addr gen.
        addr_dly:=addr_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        filter_sel_dly:=filter_sel_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.we_sym_dly:=struct.addr_cntrl_lat
                           +get_max(struct.data_addr_lat,struct.coef_addr_lat);
      end if;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );

    
    struct.vector_cnt_len:=select_integer(
                            (reqs.num_taps/2)+struct.param.num_taps_calced,
                            ((struct.param.num_taps_calced*integer(2**struct.param.symmetry))-struct.param.odd_symmetry),
                            reqs.coef_reload=1);

    --Latency Calculation
    struct.buffer_type:=2;
    struct.buffer_page_size:=2*reqs.num_channels;
    struct.latency:=struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_details(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_details(0).pcin_latency+struct.accum_extra_dly,struct.accum_req)
                    +1 --for 2nd value generated
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +struct.output_buffer_lat
                    +struct.output_rate
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
      -- struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
      -- macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
      -- if reqs.family.treat_as_s3adsp and struct.param.single_mac=0 and
        -- (not reqs.family.has_fabric_dsp48) then
        -- struct.num_dsp:=struct.num_dsp+1;
      -- end if;
      -- if struct.accum_req then
        -- struct.num_dsp:=struct.num_dsp+1;
      -- end if;
      -- if struct.has_rounder and
        -- (not reqs.family.has_fabric_dsp48) then
        -- struct.num_dsp:=struct.num_dsp+1;
      -- end if;
      -- struct.num_dsp_per_path:=struct.num_dsp;
        -- --   if  struct.param.data_combined=0 and
          -- struct.param.data_coef_combined=0 and
          -- struct.param.no_data_mem=0 and
          -- struct.param.data_mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
      -- end if;
        -- --   if  struct.param.symmetry=1 and
          -- struct.param.no_data_mem=0 and
          -- struct.param.data_mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
      -- end if;
    -- 
      -- if struct.param.coef_mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
      -- end if;
    -- 
      -- if struct.accum_req and struct.centre_tap_coef.mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+calc_num_bram(reqs.coef_width,select_integer(reqs.num_filts,2*reqs.num_filts,reqs.coef_reload=1),reqs.family);
      -- end if;
    -- else
      -- for path in 0 to reqs.num_paths-1 loop
        -- struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
        -- macs_used:=struct.param.num_macs;
        -- for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
          -- if struct.filt_arm_lat.opt_dsp(mac)=1 then
            -- struct.num_dsp:=struct.num_dsp-1;
          -- end if;
          -- if mif_status.opt_mac(mac)=1 then
            -- macs_used:=macs_used-1;
          -- end if;
        -- end loop;
        -- if reqs.family.treat_as_s3adsp and struct.param.single_mac=0 and
          -- (not reqs.family.has_fabric_dsp48) then
          -- struct.num_dsp:=struct.num_dsp+1;
        -- end if;
        -- if struct.accum_req then
          -- struct.num_dsp:=struct.num_dsp+1;
        -- end if;
        -- if struct.has_rounder and
        -- (not reqs.family.has_fabric_dsp48) then
          -- struct.num_dsp:=struct.num_dsp+1;
        -- end if;
        -- if path = 0 then
          -- struct.num_dsp_per_path:=struct.num_dsp;
        -- end if;
        -- if reqs.path_reqs.data_src(path)=path then
          -- if  struct.param.no_data_mem=0 and
              -- struct.param.data_mem_type=c_bram then
            -- if struct.param.data_combined=1 then
              -- if struct.param.symmetry=1 then
                -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
              -- else
                -- struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
              -- end if;
            -- else
              -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
              -- if struct.param.symmetry=1 then
                -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
              -- end if;
            -- end if;
          -- end if;
        -- end if;
    -- 
        -- if reqs.path_reqs.coef_src(path)=path then
          -- if struct.param.coef_mem_type=c_bram then
            -- if struct.param.coef_combined=1 then
              -- struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
            -- else
              -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
            -- end if;
          -- end if;
        -- --       if struct.accum_req and struct.centre_tap_coef.mem_type=c_bram then
            -- struct.num_bram:=struct.num_bram+calc_num_bram(reqs.path_reqs.coef_width(path),select_integer(reqs.num_filts,2*reqs.num_filts,reqs.coef_reload=1),reqs.family);
          -- end if;
        -- end if;
      -- end loop;
    -- end if;
    -- 
    -- if struct.param.symmetry=1 then
      -- struct.num_bram:=struct.num_bram+calc_delay_bram(reqs.data_width,
                                                       -- select_integer(
                                                        -- struct.filt_arm.inter_tap_delay-1+struct.extra_dly,
                                                        -- select_integer(
                                                            -- (struct.param.num_macs-struct.param.odd_symmetry)*(struct.filt_arm.inter_tap_delay-1),
                                                            -- 0,
                                                            -- struct.filt_arm.sym_para_struct=3),
                                                        -- reqs.has_nd=1 and struct.param.no_data_mem=1),
                                                       -- select_integer(
                                                        -- c_mem_forced_dist,
                                                        -- reqs.datapath_mem_type,
                                                        -- reqs.has_nd=1 and struct.param.no_data_mem=1),
                                                       -- reqs.family);
      -- struct.num_bram:=struct.num_bram+struct.filt_arm_lat.num_datapath_bram;
    -- end if;
    -- if struct.output_buffer.mem_type=c_bram then
      -- struct.num_bram:=struct.num_bram+calc_num_bram(reqs.output_width,struct.output_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_sympair_interpolation.vhd

  function define_sympair_interpolation(reqs:t_reqs;
                                        elab_dir,
                                        comp_name,
                                        mif_file:string;
                                        gen_mif: boolean;
                                        gen_reorder_seq: boolean) return t_define_sympair_interpolation is
  ------------------------------------------------------------------------------

    variable struct: t_define_sympair_interpolation;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              filter_sel_dly,
              addr_dly,
              accum_extra_bit,
              vector_mod,
              vector_half,
              p_WE_SYM_OUT_index
              :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.data_sign:=reqs.data_sign;
    struct.param.coef_sign:=reqs.coef_sign;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=reqs.symmetry;
    struct.param.neg_symmetry:=reqs.neg_symmetry;
    struct.param.odd_symmetry:=select_integer(0,reqs.num_taps rem 2,struct.param.symmetry=1);
    
    --struct.dual_sym_structure:=0;
    struct.odd_and_even:=0;
    if (reqs.inter_rate rem 2 = 0 and struct.param.odd_symmetry=1) then
      --struct.dual_sym_structure:=1;
      struct.odd_and_even:=1;
    end if;

    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))
                                  +select_integer(0,(reqs.inter_rate/2)+1,struct.param.odd_symmetry=1 and struct.odd_and_even=0)
                                  +select_integer(0,1,reqs.num_taps rem integer(2**struct.param.symmetry) > 0 and struct.odd_and_even=1);

    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    accum_extra_bit:=0;
    if reqs.family.has_fabric_dsp48 then
      --need to allow for double values so add one to width
      accum_extra_bit := 1;
    end if;

    --loop round here once checked depth of inter tap buffer depth
     pass:=0;
     while pass<2 loop
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;

      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;

      if (struct.param.clk_per_chan rem reqs.inter_rate > 0) then
        -- report "FIR: the available clock cycles is not evenly divisable by the interpolation rate, this means there will be unused clock cycles" severity note;
      end if;

      struct.param.base_count := struct.param.clk_per_chan / reqs.inter_rate;
      
      taps_per_phase:= struct.param.num_taps_calced/ reqs.inter_rate;
      if ( struct.param.num_taps_calced rem reqs.inter_rate > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/struct.param.base_count;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      struct.param.base_count:=taps_per_phase/struct.param.num_macs;
      if (taps_per_phase rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;

      if (struct.param.base_count*reqs.inter_rate)<struct.param.clk_per_chan then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      struct.gen_extra_cycle:=false;
      if  struct.shorter_px_time and
          struct.odd_and_even=1 and
          reqs.inter_rate=2 and
          struct.param.clk_per_chan-(struct.param.base_count*reqs.inter_rate)>1 then
        --enable the generation of an extra cycle between the the 1st and 2nd phase
        --when a rate of 2 with odd number of taps
        struct.gen_extra_cycle:=true;
      end if;

      if pass=0 then
        struct.param.centre_mac:=struct.param.num_macs;
      end if;

      struct.param.base_coef_space := struct.param.base_count*reqs.inter_rate;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*reqs.inter_rate;

      struct.param.inter_rate := reqs.inter_rate;
      struct.param.deci_rate  := 1;

      struct.param.no_data_mem:= 0;
      struct.param.full_parallel:= 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem:= 1;
        struct.param.full_parallel:= 1;
      end if;

      struct.output_rate:=struct.param.clk_per_chan/reqs.inter_rate;

      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.odd_and_even=1 and reqs.inter_rate=2 and struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;
      --never a single mac structure as need accumulator to process phase results

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_count))*(reqs.num_channels);
      data_depth_packed:=struct.param.base_count*reqs.num_channels;
      data_depth_rolling:=0;
      --Can't use rolling address gen

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  false,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb       => struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );
  
      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      --local odd sym variable so can be disabled. When implementing the earily shift
      --for when even rate odd sym the actual effect is a even filter that is shifted earily
      struct.sym_calc_odd_sym:=struct.param.odd_symmetry;

      struct.cyc_to_data_out:=struct.memory_path_lat.data+1;--plus one for the latch (min depth of 1 in delay)
      
      struct.cyc_to_write:=0;
      if (struct.mem_param.data_mem_type/=c_srl16) then
        struct.cyc_to_write:=(struct.param.base_count); --inter_we_cycles
      end if;

      if struct.param.no_data_mem=0 then
        struct.num_cyc_read_earily:= select_integer(0,1,struct.cyc_to_write+struct.sym_calc_odd_sym-struct.cyc_to_data_out<0)
                                    +select_integer(0,1,struct.sym_calc_odd_sym=1);
        --add odd sym when calc if need earily read as when odd sym will read data earily this gives longer to get
        --data out of memory. So then check if still don't have enough time to get data out of memory
  
        struct.change_src:=select_integer(0,1,struct.num_cyc_read_earily>=(struct.param.base_count) );
  
        struct.extra_dly:=select_integer(
                            0,
                            select_integer(
                              (reqs.num_channels)-1,
                              (reqs.num_channels),
                              struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                              --test is moved past another WE pulse by reading earily
                            struct.num_cyc_read_earily-struct.sym_calc_odd_sym>0 and
                            struct.change_src=0);

        if struct.odd_and_even=1 and struct.param.data_mem_type=c_srl16 then
        --different extra dly values
          struct.extra_dly:=select_integer(
                            0,
                            select_integer(
                              reqs.num_channels,
                              reqs.num_channels+1,
                              struct.cyc_to_data_out-struct.num_cyc_read_earily<=struct.cyc_to_write),
                              --test is moved past another WE pulse by reading earily
                            struct.num_cyc_read_earily-struct.sym_calc_odd_sym>0 and
                            struct.change_src=0);
        end if;

        if (struct.change_src=1) then

          struct.extra_dly:=((struct.param.base_count-struct.sym_calc_odd_sym)
                             *reqs.num_channels)
                             ---select_integer(0,1,struct.mem_param.data_mem_type=0)
                             -reqs.num_channels; --this is what intertap delay will be, this is used on sym wrap buffer

          if struct.odd_and_even=1 and struct.param.data_mem_type=c_srl16 then
            struct.extra_dly:=struct.extra_dly+1;
          end if;

        end if;
      else

        if struct.odd_and_even=1 and (reqs.num_channels=1) then
          struct.sym_calc_odd_sym:=0;
        end if;

        struct.change_src:=0;
        struct.extra_dly:=0;
        struct.num_cyc_read_earily:=select_integer(0,1,struct.sym_calc_odd_sym=1);

      end if;

      struct.add_sup_dly:=struct.memory_path_lat.data;

      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if struct.param.single_mac=1 or
         (reqs.inter_rate=2 and struct.odd_and_even=1 and struct.param.full_parallel=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder := (    reqs.round_mode>1 and not(struct.odd_and_even=1 and reqs.inter_rate=2) )
                         or (   (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
                         or (    reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48                                   )
                         or (   (reqs.round_mode=2 or reqs.round_mode=3)
                            and reqs.allow_approx=0
                            and not (struct.shorter_px_time and struct.gen_extra_cycle)                 );

      --Rounder settings---------------------------------------
      struct.cmux_required  := false;
      struct.pinfb_dynamic  := false;
      struct.pinfb_constant := reqs.round_mode>1
                           and not struct.has_rounder
                           and struct.odd_and_even=1 and reqs.inter_rate=2
                           and not struct.accum_req;

      -- Decide on the structure and inputs of the rounding DSP48
      if struct.has_rounder then
        if (struct.odd_and_even=1 and reqs.inter_rate=2) then
          if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
            -- Always need a fabric carry for Spartan-3A DSP
            -- Pass the accum_result to C port of rounder and add the rounding constant via
            -- the A:B concat port
            struct.use_rounder_cport     := true;
            struct.use_rounder_pcin      := false;
            struct.use_doubled_rnd_const := false;
            struct.rounder_delay         := 2;
          elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
            -- Need a fabric carry for symmetric round to zero in V-4
            -- Pass the accum_result to C port of rounder and add the rounding constant via
            -- the A:B concat port
            struct.use_rounder_cport     := true;
            struct.use_rounder_pcin      := false;
            struct.use_doubled_rnd_const := false;
            struct.rounder_delay         := 2;
          else
            -- Round normally using rounding constant on C port added to PCOUT of accumulator
            struct.use_rounder_cport     := false;
            struct.use_rounder_pcin      := true;
            struct.use_doubled_rnd_const := false;
            struct.rounder_delay         := 1;
          end if;
  
        elsif (reqs.round_mode=2 or reqs.round_mode=3) then
          -- Can't do symmetric rounding properly with PCIN, as MSB value can't be doubled
          -- even if constant can
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.use_doubled_rnd_const := false;
          struct.rounder_delay         := 2;

        elsif reqs.family.treat_as_s3adsp and struct.param.no_data_mem=1 and (reqs.inter_rate rem 2 > 0 or struct.odd_and_even=1) then
          -- Mux on output of accum, so have to route through fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.use_doubled_rnd_const := false;
          struct.rounder_delay         := 2;

        elsif (reqs.family.emb_calc_prim=p_dsp48 and (max_val(reqs.path_reqs.accum_width)+1) > 35) and not(struct.odd_and_even=1 and reqs.inter_rate=2) then
          -- Fabric adder case, need to take input from fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.use_doubled_rnd_const := false;
          struct.rounder_delay         := 2;
        
        else
          -- Round using doubled rounding constant (by wire shifting left) added to PCOUT of
          -- accumulator, then wire shift result right to get final divide by 2
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.use_doubled_rnd_const := true;
          struct.rounder_delay         := 1;
        end if;

      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.use_doubled_rnd_const := false;
        struct.rounder_delay         := 0;
      end if; 

      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not (struct.shorter_px_time and struct.gen_extra_cycle)
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.gen_extra_cycle
                                  and struct.shorter_px_time;
                                  
      if not struct.round_spare_cycle then
        struct.gen_extra_cycle := false;
      end if;
      
      struct.rounder(0):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- pattern        => gen_pattern(reqs.round_mode,max_val(reqs.path_reqs.accum_width),max_val(reqs.path_reqs.output_width),struct.use_doubled_rnd_const),
--           mask           => gen_mask(max_val(reqs.path_reqs.accum_width),max_val(reqs.path_reqs.output_width),struct.use_doubled_rnd_const),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),struct.use_doubled_rnd_const,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),struct.use_doubled_rnd_const,48),
          -- gui trans_on
          post_add_width => reqs.path_reqs.accum_width(0)+accum_extra_bit,--max_val(reqs.path_reqs.accum_width)+accum_extra_bit,
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed and struct.odd_and_even=1 and reqs.inter_rate=2,
          has_redundant => p_none
          );
      --For this structure it is necessary to have multiple rounder configurations for each path
      --This is the only structure where the rounder will be needed for the extended mutliply
      --so the paths will have different accumulator widths. The other paths are assigned to
      --in the accumulator loop, this is to save looping and we also need the p_delay
      --values calculated by the filter arm funciton.
      
      -- gui trans_off
      if reqs.has_ext_pat_det then
        if struct.use_doubled_rnd_const then
          struct.rounder(0).pattern(47 downto 1):=reqs.ext_pattern(46 downto 0);
          struct.rounder(0).mask(47 downto 1):=reqs.ext_mask(46 downto 0);
        else
          struct.rounder(0).pattern:=reqs.ext_pattern;
          struct.rounder(0).mask:=reqs.ext_mask;
        end if;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder(0));
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not (struct.shorter_px_time and struct.gen_extra_cycle) 
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      p_WE_SYM_OUT_index:=struct.param.num_macs+(struct.cyc_to_data_out-1)-struct.num_cyc_read_earily;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count*
                                select_integer(
                                  select_integer(
                                    1,
                                    reqs.inter_rate,
                                    struct.param.data_mem_type=c_srl16),
                                    --when bram can't increase processing time as will get an extra delay
                                  select_integer(
                                    1,
                                    reqs.inter_rate-1,
                                    struct.param.data_mem_type=c_srl16),
                                  struct.odd_and_even=1),
          inter_tap_delay => (struct.param.num_channels)+1,
          inter_sym_tap_delay =>select_integer(
                                  (struct.param.num_channels)+1,
                                  select_integer(
                                    (1)+1,
                                    (struct.param.num_channels)+1,
                                    struct.param.no_data_mem=1),
                                    --dual phase parallel structure is expecting the original depth
                                    --for the inter_sym_tap_delay
                                  struct.odd_and_even=1),
          --the plus 1 is because the filt_arm was block was changed to have the variable and I keep the expection of an extra 1
          --present so it is simpler to change all the other structures.
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(
                              c_preadd_addsub,--addsub
                              c_preadd_subadd,--subadd
                              reqs.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb       => struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder),--fabric
          has_ce          => reqs.has_ce,
          para_casc_we_src=> 1,--always need write pulse on data casc
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => p_WE_SYM_OUT_index,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => select_integer(1,0,struct.change_src=1),
                            p_D_SYM_OUT   => 0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.odd_and_even=1 and reqs.inter_rate=2 and struct.param.num_macs=1),
          sym_para_struct => select_integer(0,2,struct.odd_and_even=1 and
                                                 ( (struct.param.no_data_mem=1 and  reqs.num_channels>1) or
                                                   (struct.param.no_data_mem=0) ) ),
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and 
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
                  --only used when single MAC and on non-DSP48 families
          split_adder_chain => reqs.resource_opt=c_speed and struct.odd_and_even=1 and reqs.inter_rate=2,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => (others=>c_signed),
                                   pin_width  => add_const(struct.param.path_reqs.accum_width,accum_extra_bit),
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (   struct.odd_and_even=1 and reqs.inter_rate=2 and
                                  ((struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                                   (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp)) )) or
                                not( struct.odd_and_even=1 and reqs.inter_rate=2)
          );
      
      -- Rabassa doesn't support others
      -- gui insert_on
      -- for i in max_independant_col-1 downto 0 loop
        -- struct.filt_arm.indp_col_param.coef_sign(i):=c_signed;
      -- end loop;
      -- gui insert_off
      
      if struct.odd_and_even=1 and reqs.inter_rate=2 then
        --Use the sign provided by customer as in this case the core is provided
        --the requested coefficient width NOT one padded to allow for the generation
        --of the symmetric pairs
        struct.filt_arm.indp_col_param.coef_sign:=struct.param.path_reqs.coef_sign;
      end if;

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;
      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

      if (  struct.param.symmetry=1 and
            pass=0 and
            struct.filt_arm_lat.sym_inter_buff_depth>1089 and
            reqs.data_mem_type=c_mem_forced_dist ) then

        --disable symmetry as srl16 will be forced for the delay and its is not able to support >1089
        struct.param.symmetry:=0;
        struct.param.neg_symmetry:=0;
        struct.param.odd_symmetry:=0;
        struct.param.num_taps_calced:=reqs.num_taps;
        pass:=1;
      else
        pass:=2;
      end if;

    end loop;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i)+accum_extra_bit,
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>P_add_P,1=>P_add_C,2=>PCIN_add_A_concat_B,3=>PCIN_add_P,4=>NOP),
                                  (0=>A_concat_B,1=>PCIN_add_A_concat_B,2=>P_add_C),
                                  struct.param.no_data_mem/=0),
                                select_func_list(
                                  select_func_list(
                                    (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    struct.round_first_cycle),
                                  (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                  struct.round_spare_cycle),
                                struct.odd_and_even=1 and reqs.inter_rate=2)  ),
                      --only used for non-DSP48 familes
          split_post_adder => reqs.resource_opt=c_speed and struct.odd_and_even=1 and reqs.inter_rate=2,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then--and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_details(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := reqs.path_reqs.accum_width(i)+accum_extra_bit+struct.accum_details(i).extra_carry_bits;

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));
      -- gui trans_on

      --Borrow loop for mutlipath rounder assignments
      struct.rounder(i):=struct.rounder(0); --get defaults
      struct.rounder(i).p_delay:=struct.filt_arm_lat.config(i).tap_n.p_delay;
      struct.rounder(i).post_add_width:=struct.param.path_reqs.accum_width(i)+accum_extra_bit;

    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_details(0).pout_latency:=struct.accum_details(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    struct.accum_lat:=1+select_integer(
                            0,
                            1,
                            (reqs.family.emb_calc_prim=p_dsp48 and max_val(reqs.path_reqs.accum_width)+1>35 and not(struct.odd_and_even=1 and reqs.inter_rate=2) ) or
                            (reqs.family.treat_as_s3adsp and struct.param.no_data_mem=1 and (reqs.inter_rate rem 2 > 0 or (struct.odd_and_even=1 and reqs.inter_rate/=2)))  );


    struct.use_dsp_reg_as_storage:=true;
    if reqs.resource_opt=c_speed and reqs.has_ce=1 then
      struct.use_dsp_reg_as_storage:=false;
    end if;

    --Output buffer ram settings---------------------------------
    struct.output_buffer_depth:=2*reqs.num_channels*reqs.inter_rate;

    struct.output_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.output_buffer_depth>dram_mem_depth_thres and reqs.opbuff_mem_type/=c_mem_forced_dist) or
                              reqs.opbuff_mem_type=c_mem_forced_bram),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    struct.output_rate_counter:=(
        cnt1_max_val    => struct.output_rate,
        cnt2_max_val    => 1,
        cnt3_max_val    => 1,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );

    struct.output_buffer_lat:=lat_ram(struct.output_buffer,2);

    struct.has_output_buffer:=true;

    if struct.odd_and_even=1 and reqs.inter_rate=2 and reqs.num_channels=1 and not struct.shorter_px_time then
      struct.has_output_buffer:=false;
    end if;

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.inter_rate,
        cnt3_max_val    => reqs.num_channels,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );

    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                          struct.shorter_px_time),
        block_end_dly   => 0,
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => select_integer(0,1,struct.odd_and_even=1 and struct.param.data_mem_type/=c_srl16 and reqs.num_channels=1),
        adv_sym         => 0,
        resource_opt => reqs.resource_opt,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_odd_phase_param:=struct.data_addr_param;
    if struct.data_addr_odd_phase_param.addr_packed=0 then
      struct.data_addr_odd_phase_param.use_sym_cntrl:=1;
    else
      struct.data_addr_odd_phase_param.adv_sym:=1;
    end if;

    struct.data_addr_odd_phase_lat:=lat_data_address(struct.data_addr_odd_phase_param);

    if struct.odd_and_even=1 and reqs.num_channels>1 then
      --increase latency to generate data addr as there will be a mux or a constant address
      struct.data_addr_lat:=struct.data_addr_lat+1;
      struct.data_addr_odd_phase_lat:=struct.data_addr_odd_phase_lat+1;
    end if;

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count, 
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count*reqs.inter_rate,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                            struct.shorter_px_time),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count*reqs.inter_rate,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 1,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time);

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1 < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat;
    end if;

    --Check delays for latching signal for sym wrap over-----
    struct.we_sym_dly:=struct.addr_cntrl_lat
                       +struct.first_tap_extra_dly
                       +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                       -1;

    if p_WE_SYM_OUT_index<=0 and struct.param.symmetry=1 then
      --will not be able to get latching signal for wrap over as not enough mac in filt arm
      if struct.we_sym_dly-1+p_WE_SYM_OUT_index<0 then
        --not enough latency to read earily from generation delay so add latency to addr gen.
        addr_dly:=addr_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        filter_sel_dly:=filter_sel_dly+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+abs(struct.we_sym_dly-1+p_WE_SYM_OUT_index);
        struct.we_sym_dly:=struct.addr_cntrl_lat
                          +struct.first_tap_extra_dly
                          +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                          -1;
      end if;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    --had forgot to apply the same delays to the data_addr odd phase generator.
    struct.data_addr_odd_phase_param:=struct.data_addr_param;
    --struct.data_addr_odd_phase_param.use_sym_cntrl:=1;
    if struct.data_addr_odd_phase_param.addr_packed=0 then
      struct.data_addr_odd_phase_param.use_sym_cntrl:=1;
    else
      struct.data_addr_odd_phase_param.adv_sym:=1;
    end if;

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );

    vector_mod:=0;
    if struct.param.odd_symmetry=1 and struct.odd_and_even=0 then
      vector_mod:=reqs.inter_rate/2;
      vector_half:=(reqs.num_taps/2)-vector_mod;
    else
      vector_half:=(reqs.num_taps/2);
    end if;

    vector_half:=((vector_half/reqs.inter_rate)+select_integer(0,1,vector_half rem reqs.inter_rate>0))*reqs.inter_rate;

    struct.vector_cnt_len:=struct.param.num_taps_calced;

    if reqs.coef_reload=1 then
      struct.vector_cnt_len:=struct.vector_cnt_len
                             +struct.param.num_taps_calced
                             -vector_mod
                             -(reqs.inter_rate-1);
    else
      struct.vector_cnt_len:=struct.vector_cnt_len
                             +vector_half
                             -(reqs.inter_rate-1);
    end if;


    --Latency Calculation
    struct.buffer_type:=select_integer(0,2,struct.has_output_buffer);
    struct.buffer_page_size:=reqs.inter_rate*reqs.num_channels;
    struct.latency:=struct.param.base_count*select_integer(struct.param.inter_rate,1,not struct.has_output_buffer)
                                                            --this case is currenlty only when there is no op buffer
                    +struct.addr_cntrl_lat---1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_details(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,struct.accum_lat+struct.accum_details(0).pcin_latency,struct.accum_req)
                    +select_integer(0,1,struct.gen_extra_cycle)
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +select_integer(0,1
                                      --1 because of the way data is writen, always in blocks of 2
                                      +select_integer(
                                          struct.output_buffer_lat+1,
                                          struct.output_buffer_lat,
                                          --not writen in block of 2 in this structure
                                          struct.odd_and_even=1 and reqs.inter_rate=2)
                                      --plus one on buffer that generates latch_op
                                      +struct.output_rate,
                                      struct.has_output_buffer)
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48)then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48)then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.has_output_buffer and struct.output_buffer.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.output_width,struct.output_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_interpolation.vhd

  function define_pq_interpolation( reqs:t_reqs;
                                    elab_dir,
                                    comp_name,
                                    mif_file:string;
                                    gen_mif: boolean;
                                    gen_reorder_seq: boolean) return t_define_pq_interpolation is
  ------------------------------------------------------------------------------

    variable struct: t_define_pq_interpolation;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              data_addr_dly,
              coef_addr_dly,
              vector_taps
              :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;
    
    struct.param.symmetry:=0;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+struct.param.odd_symmetry;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --Calculate details of the filter-------------------------------------------
    --Number of macs and number of taps per mac
    if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
      report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
    elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
      -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
    end if;

    struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;

    if (struct.param.clk_per_chan rem reqs.inter_rate > 0) then
      -- report "FIR: the available clock cycles is not evenly divisable by the interpolation rate, this means there will be unused clock cycles" severity note;
    end if;

    struct.param.base_count := (struct.param.clk_per_chan * reqs.deci_rate)/ reqs.inter_rate;

    --Below gives constant output rate only
    --struct.param.base_count := (struct.param.clk_per_chan / reqs.inter_rate)*reqs.deci_rate;

    taps_per_phase:= struct.param.num_taps_calced/ reqs.inter_rate;
    if ( struct.param.num_taps_calced rem reqs.inter_rate > 0) then
      taps_per_phase:=taps_per_phase+1;
    end if;

    struct.param.num_macs := taps_per_phase/struct.param.base_count;

    if ( taps_per_phase rem struct.param.base_count > 0 ) then
    -- Add extra mac, this mac will need the filter coefficients padded out.
      struct.param.num_macs:=struct.param.num_macs+1;
    end if;

    struct.base_count_op_rate:=struct.param.base_count;

    --Adjust for unused cycles
    struct.param.base_count:=taps_per_phase/struct.param.num_macs;
    if (taps_per_phase rem struct.param.num_macs >0) then
      struct.param.base_count:=struct.param.base_count+1;
    end if;

    struct.shorter_px_time:=false;
    if struct.base_count_op_rate>struct.param.base_count then
      struct.shorter_px_time:=true;
    end if;
    
    struct.no_nd_need_hold:=false;
    if not struct.shorter_px_time and reqs.has_nd=0 and ( (struct.param.clk_per_chan * reqs.deci_rate) rem reqs.inter_rate /=0) then
      --need to hold address as there will be cases where the core has to wait until there is enough input data
      struct.no_nd_need_hold:=true;
    end if;

    struct.param.centre_mac:=struct.param.num_macs;

    struct.param.base_data_space := struct.param.base_count;
    struct.param.base_coef_space := struct.param.base_count*reqs.inter_rate;

    -- Modify and update so get actual filter size
    struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*reqs.inter_rate;

    struct.param.inter_rate := reqs.inter_rate;
    struct.param.deci_rate  := reqs.deci_rate;

    struct.param.no_data_mem   := 0;
    struct.param.full_parallel := 0;
    if (struct.param.base_count = 1) then
      struct.param.full_parallel := 1;
      if (reqs.num_channels=1) then
        struct.param.no_data_mem := 1;
      end if;
    end if;

    --Structural decisions------------------------------------------------------
    struct.param.single_mac:=0;
    if struct.param.num_macs=1 then
      struct.param.single_mac:=1;
    end if;

    --Memory calculations-------------------------------------
    data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*reqs.num_channels;
    data_depth_packed:=struct.param.base_data_space*reqs.num_channels;
    data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels));

    coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
    coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

    struct.param:=memory_calcs( reqs,
                                struct.param,
                                data_depth_unpacked,
                                data_depth_packed,
                                data_depth_rolling,
                                coef_depth_unpacked,
                                coef_depth_packed,
                                true,
                                reqs.num_paths=1);

    --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
    --need to know latency of memory implmented
    struct.mem_param:=( family           =>reqs.family,
                        implementation   =>implementation,
                        data_mem_type    =>struct.param.data_mem_type,
                        coef_mem_type    =>struct.param.coef_mem_type,
                        data_comb        =>struct.param.data_combined,
                        coef_comb        =>struct.param.coef_combined,
                        data_coef_comb   =>struct.param.data_coef_combined,
                        no_data_mem      =>struct.param.no_data_mem,
                        coef_mem_depth  => struct.param.coef_mem_depth,
                        has_ce           =>reqs.has_ce,
                        coef_reload      =>reqs.coef_reload,
                        coef_reload_depth=>struct.param.base_coef_space,
                        symmetric        =>struct.param.symmetry,
                        resource_opt     =>reqs.resource_opt );

    struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

    struct.add_sup_dly:=struct.memory_path_lat.data;

    struct.first_tap_extra_dly:=0;

    if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
      struct.data_dly_modifier:=-1;
    else
      struct.data_dly_modifier:=0;
    end if;

    -- First need to decide whether or not we will have an accumulator and/or a rounding block
    struct.accum_req:=true;
    if (struct.param.base_count=1 and struct.param.num_macs>1) or
       (struct.param.num_macs=1) then
      struct.accum_req:=false;
    end if;

      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );

    --Rounding settings---------------------------------------
    struct.round_first_cycle := not struct.has_rounder
                            and ( reqs.round_mode > 3
                               or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.shorter_px_time
                                  and reqs.allow_approx=1
                                  )
                                );
    struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                and not struct.has_rounder
                                and struct.shorter_px_time;

    struct.cmux_required  := false;
    struct.pinfb_dynamic  := false;
    struct.pinfb_constant := false;

    if struct.has_rounder then
      if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
        -- Always need a fabric carry for Spartan-3A DSP
        -- Pass the accum_result to C port of rounder and add the rounding constant via
        -- the A:B concat port and the carryin bit via fabric
        struct.use_rounder_cport     := true;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 2;
      elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
        -- Need a fabric carry for symmetric round to zero in V-4
        -- Pass the accum_result to C port of rounder and add the rounding constant via
        -- the A:B concat port and the carryin bit via fabric
        struct.use_rounder_cport     := true;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 2;
      else
        -- Any V5 case and V-4 symmetric round to infinity
        -- Round normally using rounding constant on C port added to PCOUT of accumulator
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := true;
        struct.rounder_delay         := 1;
      end if;
      
      --struct.rounder_delay:=struct.rounder_delay+struct.accum_lat.pout_latency;
    else
      struct.use_rounder_cport     := false;
      struct.use_rounder_pcin      := false;
      struct.rounder_delay         := 0;
    end if; 

    struct.use_approx := false;
    if        (reqs.round_mode=2 or reqs.round_mode=3)
      and     reqs.allow_approx=1
      and not struct.shorter_px_time
      and not struct.has_rounder
      and     struct.round_first_cycle
      then
      struct.use_approx := true;
    end if;

    struct.rounder:=(
        family         => reqs.family,
        implementation => implementation,
        pre_add        => 0,
        pre_add_func   => 0,
        pre_add_ipreg  => 0,
        pre_add_midreg => 0,
        a_delay        => 0,
        b_delay        => 0,
        p_delay        => 0,
        a_src          => 0,
        a_sign         => c_signed,
        b_sign         => c_signed,
        d_sign         => c_signed,
        a_width        => 1,--only used for preadder calc
        b_width        => 1,
        reg_opcode     => 1,
        enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
        -- gui trans_off
        pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        -- gui trans_on
        post_add_width => max_val(reqs.path_reqs.accum_width),
        calc_func_used => funcs_emb_calc(
                            select_func_list(
                              select_func_list(
                                (0=>PCIN_add_C),
                                (0=>PCIN_add_A_concat_B),
                                struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                              (0=>C_add_A_concat_B),
                              struct.use_rounder_cport) ),
        split_post_adder => reqs.resource_opt=c_speed,
        has_redundant => p_none
        );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

    --Filter arm settings-------------------------------------
    if (reqs.col_mode=1) then
      num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
    else
      num_col:=1;
    end if;

    struct.filt_arm:= (
        family          => reqs.family,
        implementation  => implementation,
        num_taps        => struct.param.num_macs,
        inter_we_cycles => struct.param.base_count,
        inter_tap_delay => struct.param.num_channels+1,
        inter_sym_tap_delay => 0,
        --no symmetric support in this structure
        symmetric       => struct.param.symmetry,
        pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
        data_mem_type   => struct.param.data_mem_type,
        coef_mem_type   => struct.param.coef_mem_type,
        data_comb       => struct.param.data_combined,
        coef_comb       =>struct.param.coef_combined,
        data_coef_comb  => struct.param.data_coef_combined,
        data_cascade    => 0,
        no_data_mem     => struct.param.no_data_mem,
        data_dual       => 0,
        coef_mem_depth  => struct.param.coef_mem_depth,
        data_mem_depth  => struct.param.data_mem_depth,
        p_src           => select_integer(2,0,not struct.has_rounder and (struct.param.single_mac=1 or struct.param.full_parallel=1)),--fabric
        has_ce          => reqs.has_ce,
        reload          => reqs.coef_reload,
        reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
        reload_depth    => struct.param.base_coef_space,
        -- gui trans_off
        output_index    => (
                          p_P_OUT       => struct.param.num_macs+1,
                          p_PC_OUT      => struct.param.num_macs+1,
                          p_D_OUT       => struct.param.num_macs,
                          p_D_SYM_OUT   => struct.param.num_macs,
                          p_C_OUT       => struct.param.num_macs,
                          p_WE_OUT      => struct.param.num_macs,
                          p_WE_SYM_OUT  => struct.param.num_macs,
                          p_ADDSUB_OUT  => struct.param.num_macs+1,
                          p_ADDSUP_OUT  => struct.param.num_macs+1,
                          p_WE_SYM_OUT_2    => struct.param.num_macs ),
        output_src      => (
                          p_P_OUT       => 0,
                          p_PC_OUT       => 0,
                          p_D_OUT       => 0,
                          p_D_SYM_OUT   => 0,
                          p_WE_OUT      => 0,
                          p_WE_SYM_OUT  => 0,
                          p_C_OUT       => 0,
                          p_ADDSUB_OUT  => 0,
                          p_ADDSUP_OUT  => 0,
                          p_WE_SYM_OUT_2    => 0 ),
        -- gui trans_on
        num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
        inter_split_col_dly => reqs.col_pipe_len,
        split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                 -- others=>reqs.col_wrap_len),
        dynamic_opcode  => select_integer(0,1,struct.param.num_macs=1),
        sym_para_struct => reqs.has_nd,
        para_casc_we_src=> 1,
        resource_opt    => reqs.resource_opt,
        datapath_mem_type => reqs.datapath_mem_type,
        odd_symmetry    => struct.param.odd_symmetry,
        pat_det_tap_num => select_integer(
                             0,
                             select_integer(
                               select_integer(0,1,struct.param.single_mac=1),
                               struct.param.num_macs,
                               struct.param.full_parallel=1
                             ),
                             (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                             not struct.accum_req and
                             not struct.has_rounder
                           ),
        -- gui trans_off
        pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        -- gui trans_on
        dynamic_calc_func_used => funcs_emb_calc(
                                    select_func_list(
                                      select_func_list(
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                        (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                        struct.round_first_cycle),
                                      (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                      struct.round_spare_cycle) ),
        split_adder_chain => reqs.resource_opt=c_speed,
        p_has_redundant => false,
        num_independant_col => struct.param.num_paths,
        indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                 data_width => struct.param.path_reqs.data_width,
                                 data_sign  => struct.param.path_reqs.data_sign,
                                 coef_src   => struct.param.path_reqs.coef_src,
                                 coef_width => struct.param.path_reqs.coef_width,
                                 coef_sign  => struct.param.path_reqs.coef_sign,
                                 pin_width  => struct.param.path_reqs.accum_width,
                                 cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
        );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

    struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(i),
          b_sign         => struct.param.path_reqs.coef_sign(i),
          d_sign         => struct.param.path_reqs.data_sign(i),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                  select_func_list(
                                    (0=>PCIN_add_C,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    reqs.family.treat_as_s3adsp),
                                  struct.round_first_cycle),
                                (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;
      -- gui trans_on
    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Input buffer settings--------------------------------------
    struct.has_input_buffer:=false;
    struct.input_buffer_lat:=0;
    struct.input_buffer_depth:=2*reqs.num_channels;
    struct.input_buffer_cntrl_dly:=0;

    if struct.shorter_px_time then
      struct.input_buffer_cntrl_dly:=1;
    end if;

    struct.input_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.input_buffer_depth>dram_mem_depth_thres and reqs.ipbuff_mem_type/=c_mem_forced_dist) or
                              reqs.ipbuff_mem_type=c_mem_forced_bram),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    struct.input_buffer_in_addr:=(
      family => reqs.family,
      implementation => implementation,
      addr_width => get_max(1,log2roundup(struct.input_buffer_depth)),
      page_size => reqs.num_channels,
      num_enables => 2 );

    if reqs.num_channels>1 then
      struct.has_input_buffer:=true;
      struct.input_buffer_lat:=lat_ram(struct.input_buffer,2);

      if struct.shorter_px_time then
        struct.input_buffer_lat:=struct.input_buffer_lat+1;
        --need to qualify chan_max in this case to push out input buffer latency by a cycle
        --will it tolerate a delay on starting the read, ie will the addresses over lap,
        --maybe prob in fully parallel.
      end if;

    end if;
    
    --
    struct.no_addr_latch:=0;
    if (struct.param.base_count=1 and struct.param.data_mem_type=c_srl16 and reqs.num_channels>1) then
    --in this case shouldn't need to latch address to get last data location as always 0
      struct.no_addr_latch:=1;
    end if;

    --Address generator block settings---------------------------
    struct.base_chan_param:=(
        cnt1_max_val    => select_integer(
                              struct.param.base_count,
                              struct.base_count_op_rate,
                              struct.shorter_px_time),
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => 1,
        cnt2_max_qual   => select_integer(1,0,struct.shorter_px_time),
        family          => reqs.family,
        implementation  => implementation );
        
    struct.inter_param :=(
        family          => reqs.family,
        implementation  => implementation,
        base_val        => reqs.inter_rate,
        step_val        => reqs.deci_rate,
        latch_cnt_wrap  => 0,
        has_clr         => 0,
        has_init        => 0,
        init_val        => 0,
        clr_point       => 0 );
        
    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 1,--use the repeat address structure
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0 and struct.no_addr_latch=0) or
                                                struct.shorter_px_time or
                                                struct.no_nd_need_hold), --delay of one due to the generation of addr_en
        block_end_dly   => select_integer(0,1, struct.param.base_count=1 and reqs.num_channels>1 and
                                                ((reqs.has_nd=1 and struct.param.no_data_mem=0 and struct.no_addr_latch=0) or
                                                struct.shorter_px_time or
                                                struct.no_nd_need_hold) ),--0,
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt    => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count, 
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.inter_rate,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0 and struct.no_addr_latch=0) or
                                                struct.shorter_px_time or
                                                struct.no_nd_need_hold),
        base_max_dly      => select_integer(0,1, struct.param.base_count=1 and reqs.num_channels>1 and
                                                ((reqs.has_nd=1 and struct.param.no_data_mem=0 and struct.no_addr_latch=0) or
                                                struct.shorter_px_time or
                                                struct.no_nd_need_hold) ),--0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => (struct.param.base_count*struct.param.inter_rate),
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 0,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => select_integer(0,1,struct.param.num_channels>1),
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.pipeline_addr_en:=0;
    if ((reqs.has_nd=1 and struct.param.no_data_mem=0 and struct.no_addr_latch=0) or struct.no_nd_need_hold) and not struct.shorter_px_time then
      struct.pipeline_addr_en:=1;
    end if;

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2+struct.pipeline_addr_en,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0 and struct.no_addr_latch=0) or
                                struct.shorter_px_time or
                                struct.no_nd_need_hold);

    --Balance delays

    if struct.has_input_buffer then
      if struct.input_buffer_lat>(struct.addr_cntrl_lat) then
        struct.data_dly:=0;
        struct.filt_dly:=0;
        struct.addr_dly:=struct.input_buffer_lat-(struct.addr_cntrl_lat);
      else
        struct.data_dly:=(struct.addr_cntrl_lat)-struct.input_buffer_lat;
        struct.filt_dly:=(struct.addr_cntrl_lat)-struct.input_buffer_lat;
        struct.addr_dly:=0;
      end if;
    else
      struct.filt_dly:=struct.addr_cntrl_lat;
      struct.data_dly:=struct.addr_cntrl_lat;
      struct.addr_dly:=0;
    end if;

    if not struct.has_input_buffer and reqs.num_filts>1 then
      --extra delay on filter sel generation
      struct.filt_dly:=struct.filt_dly-1;
    end if;

    if reqs.coef_reload=1 then
      if struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat) <= 0 then
        --need to delay address generation
        struct.addr_dly:=struct.addr_dly+abs( (struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat)) );
        struct.data_dly:=struct.data_dly+abs( (struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat)) );
        --also need to delay data to allign correctly
        struct.filt_dly:=0;
      else
        --subtract some delay from filt dly
        struct.filt_dly:=struct.filt_dly - (struct.reload_cntrl_param_lat.filt_sel_lat);
      end if;
    end if;

    data_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat);

    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.write_phase_dly :=struct.data_addr_param.write_phase_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.sub_block_end_dly :=struct.data_addr_param.sub_block_end_dly+
                                            data_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    coef_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat);

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  := struct.coef_addr_param.base_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly := struct.coef_addr_param.skip_base_max_dly+
                                                coef_addr_dly+
                                                struct.addr_dly
                                                +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly := struct.coef_addr_param.count_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=  struct.coef_addr_param.filt_sel_dly+
                                            coef_addr_dly+
                                            struct.filt_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;
    
    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );
    
    vector_taps:=select_integer(
                  reqs.num_taps,
                  struct.param.num_taps_calced,
                  reqs.coef_reload=1);

    struct.vector_cnt_len:= ((vector_taps-1)/struct.param.deci_rate)+1-
                            ((struct.param.inter_rate-1-
                              (vector_taps -
                               ((((vector_taps-1)/struct.param.deci_rate)*struct.param.deci_rate)+1)))/struct.param.deci_rate); --last tap in last phase output before 0 coefficients
    -- struct.vector_cnt_len:= divroundup(vector_taps,struct.param.deci_rate);
    
    --Latency Calculation
    struct.buffer_type:=select_integer(0,1,struct.has_input_buffer);
    struct.buffer_page_size:=reqs.num_channels;
    struct.latency:=select_integer(0,1,struct.has_input_buffer)
                    +struct.base_count_op_rate
                    +struct.addr_cntrl_lat
                    +struct.addr_dly
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48)then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48)then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.has_input_buffer and struct.input_buffer.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.data_width,struct.input_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_decimation.vhd

  function define_pq_decimation(reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_pq_decimation is
  ------------------------------------------------------------------------------

    variable struct: t_define_pq_decimation;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              filter_sel_dly,
              addr_dly :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=0;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+struct.param.odd_symmetry;

    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;

      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;
          
      struct.param.base_count := struct.param.clk_per_chan / reqs.inter_rate;

      taps_per_phase:= struct.param.num_taps_calced / reqs.deci_rate;
      if ( struct.param.num_taps_calced rem reqs.deci_rate > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/(struct.param.base_count*reqs.inter_rate);

      if ( taps_per_phase rem (struct.param.base_count*reqs.inter_rate) > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      struct.param.base_count:=taps_per_phase/struct.param.num_macs;
      if (taps_per_phase rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;
      if ( struct.param.base_count rem reqs.inter_rate > 0 ) then
        struct.param.base_count:= ((struct.param.base_count/reqs.inter_rate)+1);
      else
        struct.param.base_count:= (struct.param.base_count/reqs.inter_rate);
      end if;

      if struct.param.base_count<(struct.param.clk_per_chan/reqs.inter_rate) then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      struct.param.centre_mac:=struct.param.num_macs;

      struct.param.base_coef_space := struct.param.base_count*reqs.inter_rate*reqs.deci_rate;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*reqs.inter_rate*reqs.deci_rate;

      struct.param.inter_rate := reqs.inter_rate;
      struct.param.deci_rate  := reqs.deci_rate;

      struct.param.no_data_mem:= 0;
      struct.param.full_parallel := 0;

      struct.output_rate:=struct.param.clk_per_chan / reqs.inter_rate*reqs.deci_rate;

      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_count))*(reqs.num_channels*reqs.deci_rate);
      data_depth_packed:=struct.param.base_count*reqs.num_channels*reqs.deci_rate;
      
      data_depth_rolling:=0;
      --can't use bram rolling address scheme as the channel/deci phase control is generated externally

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  false,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb       => struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.add_sup_dly:=struct.memory_path_lat.data;
      
      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.single_mac=1) then
        struct.accum_req:=false;
      end if;

      -- Structure can't support symmetric rounding without significant modification - future feature
      struct.has_rounder :=
                (   reqs.round_mode>1                       and reqs.num_channels>1 and struct.param.full_parallel=1 and struct.param.single_mac=1)
                or (reqs.round_mode=2 or reqs.round_mode=3);

      --Rounding settings---------------------------------------
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;

      struct.pinfb_dynamic :=  reqs.round_mode>1
                           and not struct.has_rounder
                           and reqs.num_channels>1
                           and not struct.round_spare_cycle
                           and struct.param.single_mac=0
                           and (reqs.family.treat_as_s3adsp or (reqs.family.emb_calc_prim=p_dsp48 and (reqs.accum_width-reqs.output_width)>35) );
      
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  )
                              and not(struct.pinfb_dynamic);
  
      struct.cmux_required  :=  reqs.round_mode>1
                            and not struct.has_rounder
                            and reqs.num_channels>1
                            and (  struct.param.single_mac=1
                                or (struct.round_spare_cycle and reqs.family.emb_calc_prim=p_dsp48 and (reqs.accum_width-reqs.output_width)>35)
                                );

      struct.pinfb_constant := struct.param.single_mac=1
                           and not struct.has_rounder
                           and reqs.num_channels=1
                           and reqs.round_mode>1;

      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;

      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if; 
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;
  
      struct.rounder(0):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => reqs.path_reqs.accum_width(0),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder(0).pattern:=reqs.ext_pattern;
        struct.rounder(0).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder(0));
        if struct.accum_req or not struct.use_rounder_pcin then
          struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
        end if;
      end if;

      --Filter arm settings-------------------------------------
      
      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => (struct.param.num_channels*reqs.deci_rate)+2,
          inter_sym_tap_delay => 0,
          --no symmetric support in this structure
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb       => struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,--fabric
                                            (struct.param.single_mac=1 and reqs.num_channels>1 and not struct.cmux_required)
                                            or (struct.param.single_mac=1 and reqs.num_channels>1 and struct.cmux_required)
                                            or (struct.pinfb_dynamic or struct.pinfb_constant)),
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => struct.param.num_macs,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => 0,
                            p_D_SYM_OUT   => 0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                   -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.single_mac=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> 2,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and 
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>C_add_A_mult_B,2=>P_add_A_mult_B,3=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>C_add_A_mult_B,2=>P_add_A_mult_B,3=>P_add_C,4=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed,
          p_has_redundant => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed and struct.param.single_mac=1,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (reqs.num_channels>1 and not(reqs.family.treat_as_s3adsp)) or
                               (reqs.num_channels=1 and struct.round_first_cycle and not(reqs.family.treat_as_s3adsp)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

      struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
      struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    
    struct.accum_c_as_pcin:=false;
    if reqs.num_paths>1 and 
       reqs.family.has_fabric_dsp48 and 
       reqs.resource_opt=c_speed and 
       reqs.num_channels>1  and
       struct.accum_req and
       reqs.has_ext_output_src then
      --need to re-arrange how the split sums are recombined. Use filt arm recombine, ie P_OUT rather than
      --PC_OUT. Route to C of accum. This is required for multi-channel as the phase results are stored externally
      --and if PC_OUT is used the accum_op_casc can be generated at different times for each path as the accum_width
      --for each path can be different. So, need the input to each paths accum to be at the same time, and if P_OUT is
      --use they will be balanced and occur at the same time.
      for i in 0 to reqs.num_paths-1 loop
        if struct.filt_arm_lat.config(i).tap_n.p_delay>0 then
        --only need to do this if there is a big enough difference in
        --accum width such that there is differing number of splits
        --in the accumulator for each path
          struct.accum_c_as_pcin:=true;
        end if;
      end loop;
    end if;

    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => select_integer(2,1,struct.accum_c_as_pcin)*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_A_concat_B,2=>PCIN_add_P,3=>NOP),
                                  (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                  struct.round_first_cycle and reqs.num_channels=1),
                                select_func_list(
                                  (0=>C,1=>C_add_A_concat_B,2=>P_add_C,3=>NOP),
                                  (0=>C_add_A_concat_B,1=>P_add_C,2=>NOP),
                                  struct.round_first_cycle and reqs.num_channels=1),
                                struct.accum_c_as_pcin)),
                          --parameter only relavent to non-DSP48 familys
          split_post_adder => reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed,
          has_redundant => select_integer(p_none,p_A_concat_B,reqs.family.has_fabric_dsp48 and reqs.resource_opt=c_speed)
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;
      -- gui trans_on

      --Borrow loop for mutlipath rounder assignments
      struct.rounder(i):=struct.rounder(0); --get defaults
      struct.rounder(i).p_delay:=struct.filt_arm_lat.config(i).tap_n.p_delay;
      struct.rounder(i).post_add_width:=struct.param.path_reqs.accum_width(i);
      
    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req and not struct.accum_c_as_pcin)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    struct.use_c_port_as_storage:=true;
    if (   reqs.resource_opt=c_speed and reqs.has_ce=1 and struct.param.no_data_mem=0 )
        or struct.cmux_required
        or reqs.num_channels=1 then
        
      struct.use_c_port_as_storage:=false;
    end if;

    --Output buffer ram settings---------------------------------
    struct.output_buffer_depth:=2*reqs.num_channels*reqs.inter_rate;
    
    struct.has_output_buffer:=false;
    if reqs.num_channels>1 or
       (reqs.num_channels=1 and (struct.param.clk_per_chan rem reqs.inter_rate > 0)) or
       struct.shorter_px_time then
      struct.has_output_buffer:=true;
    end if;

    struct.output_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.output_buffer_depth>dram_mem_depth_thres and reqs.opbuff_mem_type/=c_mem_forced_dist) or
                              reqs.opbuff_mem_type=c_mem_forced_bram),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    struct.output_buffer_in_addr:=(
      family => reqs.family,
      implementation => implementation,
      addr_width => get_max(1,log2roundup(struct.output_buffer_depth)),
      page_size => reqs.num_channels*reqs.inter_rate,
      num_enables => 1 );

    struct.output_buffer_out_addr:=struct.output_buffer_in_addr;
    
    struct.output_rate_counter:=(
        cnt1_max_val    => struct.output_rate,
        cnt2_max_val    => 1,
        cnt3_max_val    => 1,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );

    struct.extra_opb_reg:=0;
    if struct.has_output_buffer and reqs.resource_opt=c_speed and struct.output_buffer.mem_type=c_dram then
        struct.extra_opb_reg:=1;
    end if;

    if struct.has_output_buffer then
      struct.output_buffer_lat:=lat_ram(struct.output_buffer,2);
    else
      struct.output_buffer_lat:=0;
    end if;

    --Address generator block settings---------------------------
    struct.base_inter_chan_param:=(
        cnt1_max_val    => struct.param.base_count,
        cnt2_max_val    => reqs.inter_rate,
        cnt3_max_val    => reqs.num_channels,
        cnt2_max_qual   => 1,
        family          => reqs.family,
        implementation  => implementation );

    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => select_integer(
                            select_integer(1,reqs.deci_rate,reqs.num_channels=1),
                            reqs.num_channels*reqs.deci_rate,
                            struct.param.data_mem_type=c_srl16),
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => select_integer(1,0,struct.param.data_mem_type=c_srl16),
        --need to repeat addresses before shift, not sure about srl16 reqs yet but for packed data address, single channel need to set this signal
        en_dly          => 0,
        block_end_dly   => 0,
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt    => select_integer(reqs.resource_opt,c_area,
                                  (struct.param.data_mem_type/=c_srl16 and struct.param.data_packed=1 and reqs.num_channels>1) or
                                  struct.param.data_mem_type=c_srl16),
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );


    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count,
    --this occurs with 0 latency when latency is 1

    if reqs.num_channels>1 or struct.param.data_mem_type=c_srl16 then
      --add delay on for external generation
      if struct.param.data_mem_type/=c_srl16 then
        struct.data_addr_param.en_dly:=struct.data_addr_param.en_dly+1;
        struct.data_addr_param.block_end_dly:=struct.data_addr_param.block_end_dly+1;
        struct.data_addr_param.last_block_dly:=struct.data_addr_param.last_block_dly+1;
        struct.data_addr_param.sub_block_end_dly:=struct.data_addr_param.sub_block_end_dly+1;
        struct.data_addr_param.write_phase_dly:=struct.data_addr_param.write_phase_dly+1;
        if struct.param.data_packed=0 or struct.param.base_count=1 then
          struct.data_addr_lat:=struct.data_addr_lat+1;
        else
          struct.data_addr_lat:=struct.data_addr_lat+2;
        end if;
      else
        struct.data_addr_lat:=struct.data_addr_lat+1;
        --don't need to delay the generation of the address but need to increase
        --latency by 1

      end if;
    end if;

    --special case where the delay for data address is not correct, the extra for speed opt is
    --not being added on correctly
    if reqs.resource_opt=c_speed and
       reqs.family.treat_as_s3adsp and 
       struct.param.base_count=1 and
       struct.param.data_mem_type/=c_srl16 and
       reqs.num_channels>1 then
      struct.data_addr_lat:=struct.data_addr_lat+1;
    end if;

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count*reqs.inter_rate,
        block_cnt       => reqs.deci_rate,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => 0,
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt    => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count*reqs.inter_rate*reqs.deci_rate,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt    => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 0,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => select_integer(0,1,reqs.num_channels>1),
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);
    struct.reload_cntrl_param_lat.filt_sel_lat:=struct.reload_cntrl_param_lat.filt_sel_lat+1;
    --add one as filter sel latch is done using we_gen, rather than nd_rfd. This is
    --to allign correctly with first_phase

    struct.addr_cntrl_lat:=2;

    struct.filter_sel_lat:=2;

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat-struct.filter_sel_lat;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.sub_block_end_dly :=struct.data_addr_param.sub_block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.write_phase_dly :=struct.data_addr_param.write_phase_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    
    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;
    
    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd);

    struct.vector_cnt_len:=struct.param.num_taps_calced/reqs.deci_rate;--taps_per_phase;
                           --Need to use taps_calced as the data vector is padded out.

    --Latency Calculation
    struct.buffer_type:=2;
    if struct.has_output_buffer then
      struct.buffer_page_size:=reqs.num_channels*reqs.inter_rate;
      struct.sample_latency:=(reqs.num_channels*(reqs.deci_rate-1))+1;
      struct.latency:=struct.param.base_count*reqs.inter_rate
                      --the point in the sequence that final latch_accum is generated for a block of results
                      --will be when the deci phase finished at the end of a base block of base * interrate
                      +struct.addr_cntrl_lat---1
                      +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                      +struct.filt_arm_lat.cascaded
                      +struct.filt_arm_lat.tap
                      +struct.accum_lat(0).pout_latency
                      --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                      +select_integer(0,1+struct.accum_lat(0).pout_latency+select_integer(0,1,struct.accum_c_as_pcin),struct.accum_req)
                      +select_integer(0,1,struct.round_spare_cycle)
                      +struct.rounder_delay
                      --the output is not delayed for the output buffer latency
                      +select_integer(0,struct.output_rate+
                                      struct.extra_opb_reg+
                                      select_integer(0,3,reqs.has_chan0_in=1),struct.has_output_buffer)
                      +struct.reg_output
                      +select_integer(0,1,struct.reg_output=0 and reqs.has_data_valid=1)
                      +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);
    else
      struct.buffer_page_size:=0;
      struct.sample_latency:=(reqs.deci_rate/reqs.inter_rate)+select_integer(0,1,reqs.deci_rate rem reqs.inter_rate > 0);
      struct.latency:=struct.param.base_count*(reqs.deci_rate rem reqs.inter_rate)
                      --need to calculate last phase of current output
                      +struct.addr_cntrl_lat---1
                      +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                      +struct.filt_arm_lat.cascaded
                      +struct.filt_arm_lat.tap
                      +struct.accum_lat(0).pout_latency
                      --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                      +select_integer(0,1+struct.accum_lat(0).pout_latency+select_integer(0,1,struct.accum_c_as_pcin),struct.accum_req)
                      +select_integer(0,1,struct.round_spare_cycle)
                      +struct.rounder_delay
                      +struct.reg_output
                      +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);
    end if;

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --     (not reqs.family.has_fabric_dsp48) then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.has_output_buffer and struct.output_buffer.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.output_width,struct.output_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_polyphase_pq_decimation_alt.vhd

  function define_pq_decimation_alt(reqs:t_reqs;
                                elab_dir,
                                comp_name,
                                mif_file:string;
                                gen_mif: boolean;
                                gen_reorder_seq: boolean) return t_define_pq_decimation_alt is
  ------------------------------------------------------------------------------

    variable struct: t_define_pq_decimation_alt;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  taps_per_phase,
              data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              pass,
              data_addr_dly,
              coef_addr_dly,
              ip_buff_overhead
              :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;
    
    struct.param.symmetry:=0;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=(reqs.num_taps/integer(2**struct.param.symmetry))+struct.param.odd_symmetry;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
      if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
      elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
        -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
      end if;
      
      --clk_per_chan is at the output rate for this structure
      struct.param.clk_per_chan := reqs.clk_per_samp / reqs.num_channels;
      
      if struct.param.clk_per_chan < divroundup(reqs.deci_rate,reqs.inter_rate) then
        report "ERROR: FIR Compiler v5.0: not enough clock cycles per output sample("&integer'image(struct.param.clk_per_chan)&") to process all associated inputs("&integer'image(divroundup(reqs.deci_rate,reqs.inter_rate))&")" severity error;
      end if;
      
      struct.param.base_count := struct.param.clk_per_chan;
      
      taps_per_phase:= struct.param.num_taps_calced/ reqs.inter_rate;
      if ( struct.param.num_taps_calced rem reqs.inter_rate > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/struct.param.base_count;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      struct.base_count_op_rate:=struct.param.base_count;

      --Adjust for unused cycles
      struct.param.base_count:=taps_per_phase/struct.param.num_macs;
      if (taps_per_phase rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;
      --Need to guard against a base count of 1, will always need a minimum number of processing cycles given the P/Q fraction
      struct.param.base_count:=get_max(struct.param.base_count,divroundup(reqs.deci_rate,reqs.inter_rate));

      struct.shorter_px_time:=false;
      if struct.base_count_op_rate>struct.param.base_count then
        struct.shorter_px_time:=true;
      end if;
            
      struct.param.centre_mac:=struct.param.num_macs;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count*reqs.inter_rate;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*reqs.inter_rate;

      struct.param.inter_rate := reqs.inter_rate;
      struct.param.deci_rate  := reqs.deci_rate;
      
      --No fully parallel configuration in this structure as will always have a min shift of two or one
      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      
      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;

      --Memory calculations-------------------------------------
      data_depth_rolling:=integer(2**log2roundup( (struct.param.base_data_space*reqs.num_channels)+divroundup(struct.param.deci_rate,struct.param.inter_rate) ));
      data_depth_unpacked:=data_depth_rolling;
      data_depth_packed:=data_depth_rolling;

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);
      
      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,--use rolling
                                  false);--don't pack data and coeff in single memory

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      --need to know latency of memory implmented
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb        =>struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.add_sup_dly:=struct.memory_path_lat.data;

      struct.first_tap_extra_dly:=0;

      --Only use DRAM or BRAM in this structure due to using 2 ports for the data memory. So the data position does not 
      -- need to be modified. It is not possible to use SRL16 due to sequence that data is passed in. In multi-channel
      -- configuration would end up with a non-periodic sequence of data i.e. C0,C0,C1,C1,C2,C2,C0,C1,C2,C0,C1,.......
      struct.data_dly_modifier:=0;
      
      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      -- Will always need an accumulator - why?
      struct.accum_req:=true;
      if (struct.param.base_count=1 and struct.param.num_macs>1) or
         (struct.param.num_macs=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );
    
      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;
  
      struct.cmux_required  := false;
      struct.pinfb_dynamic  := false;
      struct.pinfb_constant := false;
      
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;
        
        --struct.rounder_delay:=struct.rounder_delay+struct.accum_lat.pout_latency;
      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if;
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;
  
      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          --implement_extra_dly => 0,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => 0,
          inter_sym_tap_delay => 0,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb       => struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 1,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder and (struct.param.single_mac=1 or struct.param.full_parallel=1)),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => struct.param.num_macs,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => 0,
                            p_D_SYM_OUT   => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_C_OUT       => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len       => reqs.col_config,
          dynamic_opcode  => select_integer(0,1,struct.param.num_macs=1),
          sym_para_struct => 0,
          para_casc_we_src=> 0,
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and 
                               not struct.accum_req and
                               not struct.has_rounder
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);
    
    struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;
    struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_addr_extra_delay;
    struct.add_sup_dly:=struct.add_sup_dly+struct.filt_arm_lat.data_extra_reg;

    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(i),
          b_sign         => struct.param.path_reqs.coef_sign(i),
          d_sign         => struct.param.path_reqs.data_sign(i),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          --implement_extra_dly => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          mask           => gen_mask(struct.param.path_reqs.accum_width(0),struct.param.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                  select_func_list(
                                    (0=>PCIN_add_C,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    reqs.family.treat_as_s3adsp),
                                  struct.round_first_cycle),
                                (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
  
      -- gui trans_off
      if reqs.has_ext_pat_det then --and i=0 then
        -- struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;
      -- gui trans_on
    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);

    --Inital latency of control from nd/rfd to base_en high------
    struct.addr_cntrl_lat:=1;
    
    --Input buffer settings--------------------------------------    
    -- struct.input_buffer_depth:=(reqs.num_channels*(reqs.deci_rate-divroundup(((reqs.deci_rate/struct.base_count_op_rate)*reqs.deci_rate),reqs.inter_rate)))+(struct.addr_cntrl_lat+1)+divroundup(struct.param.deci_rate,struct.param.inter_rate);
    
    struct.input_buffer_depth:=(reqs.deci_rate*reqs.num_channels)
                               --inputs recieved from a full set of outputs i.e. 4/7 generates 4 outputs for every 7 inputs
                               -(divroundup((divroundup((reqs.deci_rate*reqs.num_channels),struct.base_count_op_rate)/reqs.num_channels)*reqs.deci_rate,reqs.inter_rate)*reqs.num_channels)
                               --the number of input samples used up generating outputs samples during the period receiving all the inputs samples at the clock rate
                               +(((divroundup(struct.param.deci_rate,struct.param.inter_rate)-1)*reqs.num_channels)+1)
                               --number of input samples required before generating the first input sample
                               +(struct.addr_cntrl_lat+1)--;
                               --control latency in initiating an output calculation
                               +2;
                               --plus 2 added as it looks like because rfd takes a cycle to respond to a change in diff_cnt, this means the number of input samples can
                               --become to low to generate an output, meaning the core will not run at full rate. i.e. base_en high all the time. +1 was not sufficient so +2 used
                               
    
    -- Further explanation of input buffer depth calcuation:
    -- 
    -- How much do you need to buffer to retain max through put?
    --
    -- When decimating by p/q, p outputs are generated for every q inputs. Consider recieving all the inputs in a continous 
    -- stream at the clock rate. They may actually be dispersed at the input sample rate but this may not be periodic,
    -- so its simpler to consider the inputs at full rate with a period where no inputs are recieved, essientially the worse case 
    --
    -- This gives a block of samples (reqs.deci_rate*reqs.num_channels) long on the input.
    -- How many output samples are generated in that period of time? roundup( (reqs.deci_rate*reqs.num_channels) / struct.base_count_op_rate )
    -- How many input samples are used up by generating those output samples?
    -- First divide those outputs up by the number of channels: roundup( (reqs.deci_rate*reqs.num_channels) / struct.base_count_op_rate ) / reqs.num_channels
    -- Then calculate how many input samples have been received for those outputs generated: roundup( above value / reqs.inter_rate )
    -- Note: There is an opertunity to be more accurate as the number of outputs generated by not be evenly divisable by the number 
    -- of channels, so slight more inputs could be used for some channels than the other channels. Currently not considered and left as the lower number.
    -- Now multiply up by the number of channels, giving the total number of inputs used by the outputs during the input period. 
    -- This is the calculation done on the second line of the buffer depth calculation above.
    
    --RFD Threshold
    --need to look for the value less the input latency so by the time rfd is generated we've not overflowed the input buffer
    struct.rfd_threshold:=struct.input_buffer_depth
                          -(struct.addr_cntrl_lat+1);
                          
    --rfd is used to control the input rate, the primarly depth struct.input_buffer_depth is set to determines the 
    --through put and is calculate as such. But, other values are added to struct.input_buffer_depth to ensure there is enough
    --data to generate an output. When implementing a multi-channel filter it is possible to allow data to be written to the 
    --input buffer and overwrite unused data, this is because of the way data is read out of the buffer. It is not
    --read out sequentally but in step of num_channels. This means that a bit of over head has to be added to the buffer to 
    --allow the new data to be stored until the previous data is finshed with
    ip_buff_overhead:=(divroundup(struct.param.deci_rate,struct.param.inter_rate)-1)*reqs.num_channels;
    
    report "---> alt PQ Deci buffer details: "&integer'image(struct.rfd_threshold)&" , "&integer'image(ip_buff_overhead)&" , "&integer'image(struct.input_buffer_depth);
    
    if (2**log2roundup(struct.input_buffer_depth) - struct.input_buffer_depth <  ip_buff_overhead ) then
      --overhead is not included in default input buffer implementation so must be allowed for in the following ways
      if struct.rfd_threshold - ip_buff_overhead > (((divroundup(struct.param.deci_rate,struct.param.inter_rate)-1)*reqs.num_channels)+1) then
        --The rfd threashold can be reduced by the overhead amount but still be high enough to store enough inputs to generate the first output
        struct.rfd_threshold:=struct.rfd_threshold-ip_buff_overhead;
      else
        --Otherwise we need to increase depth
        struct.input_buffer_depth:=struct.input_buffer_depth+ip_buff_overhead;
      end if;
    end if;    
    
    report "---> "&integer'image(struct.rfd_threshold)&" , "&integer'image(ip_buff_overhead)&" , "&integer'image(struct.input_buffer_depth);
    
    struct.input_buffer:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            => select_integer(
                              c_dram,--dram
                              c_bram,--bram
                              (struct.input_buffer_depth>dram_mem_depth_thres and reqs.ipbuff_mem_type/=c_mem_forced_dist) or
                               reqs.ipbuff_mem_type=c_mem_forced_bram ),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );
    
    struct.input_buffer_lat:=lat_ram(struct.input_buffer,2);
    
    --This mod counter is used to calculate how many inputs are required for the next output
    struct.input_count_next_output :=(
        family          => reqs.family,
        implementation  => implementation,
        base_val        => reqs.deci_rate,
        step_val        => reqs.inter_rate,
        latch_cnt_wrap  => 0,
        has_clr         => 0,
        has_init        => 1,
        init_val        => ((divroundup(struct.param.deci_rate,struct.param.inter_rate))*struct.param.inter_rate) mod struct.param.deci_rate,
        clr_point       => 0 );
        
    --Address generator block settings---------------------------
    struct.base_chan_param:=(
        cnt1_max_val    => select_integer(
                              struct.param.base_count,
                              struct.base_count_op_rate,
                              struct.shorter_px_time),
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => reqs.inter_rate,--1,
        cnt2_max_qual   => 0,
        family          => reqs.family,
        implementation  => implementation );
            
    --Custom data address generation
    struct.read_addr_dly:=1;
    struct.write_addr_dly:=struct.memory_path_lat.data-1;
    --need to offset to allign with data exiting ram
    struct.data_addr_lat:=2;

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.inter_rate,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => 0,
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_coef_space,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 0,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,--select_integer(0,1,struct.param.num_channels>1),
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);


    --Balance delays
    struct.data_dly:=0;
    struct.filt_dly:=-1;--0;--sub 1 for latching filter sel value
    struct.addr_dly:=struct.input_buffer_lat+1;
    --delay address and control to match when data exiting input buffer. Control to input buffer address has a further 1 register
    --hence the +1
        
    if reqs.coef_reload=1 then
      -- if reqs.num_filts>1 then        
        struct.filt_dly:=0;
        --filter sel coming from buffer to will have additional deley due to reload circuitry
        --model had difficulty in matching the latency for the single filt case so both cases now use the same delay structure
        struct.addr_dly:=struct.addr_dly+struct.reload_cntrl_param_lat.filt_sel_lat+1;
        struct.data_dly:=struct.data_dly+struct.reload_cntrl_param_lat.filt_sel_lat+1;
        --plus 1 to allow for holding the filter sel value external to the reload cntrl block
      -- else
        -- struct.filt_dly:=0;          
        -- if struct.reload_cntrl_param_lat.filt_sel_lat > struct.addr_dly then
          -- struct.addr_dly:=struct.addr_dly+(struct.reload_cntrl_param_lat.filt_sel_lat-struct.addr_dly);
          -- struct.data_dly:=struct.data_dly+(struct.reload_cntrl_param_lat.filt_sel_lat-struct.addr_dly);
        -- else
          -- struct.filt_dly:=struct.filt_dly+(struct.addr_dly-struct.reload_cntrl_param_lat.filt_sel_lat);
        -- end if;
      -- end if;
    end if;

    data_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat);
    
    struct.read_addr_dly:=struct.read_addr_dly+
                          data_addr_dly+
                          struct.addr_dly
                          +struct.filt_arm_lat.data_addr_extra_delay;
    struct.write_addr_dly:=struct.write_addr_dly+
                          data_addr_dly+
                          struct.addr_dly
                          +struct.filt_arm_lat.data_addr_extra_delay;
 
    coef_addr_dly:=select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat);

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  := struct.coef_addr_param.base_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly := struct.coef_addr_param.skip_base_max_dly+
                                                coef_addr_dly+
                                                struct.addr_dly
                                                +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly := struct.coef_addr_param.count_max_dly+
                                            coef_addr_dly+
                                            struct.addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=  struct.coef_addr_param.filt_sel_dly+
                                            coef_addr_dly+
                                            struct.filt_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
                                            
    if struct.coef_addr_param.filt_sel_dly < 0 then
      --Balance delays, or at least try too....
      --Everything needs to be delayed a little apart from the filter sel path
      struct.addr_dly:=struct.addr_dly+abs(struct.coef_addr_param.filt_sel_dly);
      struct.data_dly:=abs(struct.coef_addr_param.filt_sel_dly);
      
      struct.read_addr_dly:=struct.read_addr_dly+
                          abs(struct.coef_addr_param.filt_sel_dly);
      struct.write_addr_dly:=struct.write_addr_dly+
                            abs(struct.coef_addr_param.filt_sel_dly);
                            
      struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            abs(struct.coef_addr_param.filt_sel_dly);
      struct.coef_addr_param.base_max_dly  := struct.coef_addr_param.base_max_dly+
                                              abs(struct.coef_addr_param.filt_sel_dly);
      struct.coef_addr_param.skip_base_max_dly := struct.coef_addr_param.skip_base_max_dly+
                                                  abs(struct.coef_addr_param.filt_sel_dly);
      struct.coef_addr_param.count_max_dly := struct.coef_addr_param.count_max_dly+
                                              abs(struct.coef_addr_param.filt_sel_dly);
      struct.coef_addr_param.filt_sel_dly :=0;
    end if;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.vector_cnt_len:=get_max(
                            select_integer(
                              ((reqs.num_taps/reqs.inter_rate)+
                                select_integer(0,1,reqs.num_taps rem reqs.inter_rate>0))
                              *reqs.inter_rate,
                              struct.param.num_taps_calced,
                              reqs.coef_reload=1)-(struct.param.inter_rate-1),
                            2);--minimum of one sample must be output to ensure the data vector has new data
    --Latency Calculation
    struct.buffer_type:=1;
    struct.buffer_page_size:=reqs.num_channels;--this value is not valid, page size changes. Parameter not used, redundant
    struct.latency:=struct.base_count_op_rate
                    +struct.addr_cntrl_lat
                    +struct.addr_dly
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
      -- struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
      -- macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
      -- if struct.accum_req and
        -- (not reqs.family.has_fabric_dsp48) then
        -- struct.num_dsp:=struct.num_dsp+1;
      -- end if;
      -- if struct.has_rounder and
        -- (not reqs.family.has_fabric_dsp48) then
        -- struct.num_dsp:=struct.num_dsp+1;
      -- end if;
      -- struct.num_dsp_per_path:=struct.num_dsp;
    -- 
      -- if  struct.param.data_mem_type=c_bram then
        -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
      -- end if;
    -- 
      -- if struct.param.coef_mem_type=c_bram then
        -- if struct.param.coef_combined=1 then
          -- struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(0),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
        -- else
          -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(0),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
        -- end if;
      -- end if;
    -- else
      -- for path in 0 to reqs.num_paths-1 loop
        -- struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
        -- macs_used:=struct.param.num_macs;
        -- for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
          -- if struct.filt_arm_lat.opt_dsp(mac)=1 then
            -- struct.num_dsp:=struct.num_dsp-1;
          -- end if;
          -- if mif_status.opt_mac(mac)=1 then
            -- macs_used:=macs_used-1;
          -- end if;
        -- end loop;
        -- if struct.accum_req and
           -- (not reqs.family.has_fabric_dsp48) then
          -- struct.num_dsp:=struct.num_dsp+1;
        -- end if;
        -- if struct.has_rounder and
        -- (not reqs.family.has_fabric_dsp48) then
          -- struct.num_dsp:=struct.num_dsp+1;
        -- end if;
        -- if path = 0 then
          -- struct.num_dsp_per_path:=struct.num_dsp;
        -- end if;
        -- if reqs.path_reqs.data_src(path)=path then
          -- if  struct.param.data_mem_type=c_bram then
            -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));              
          -- end if;
        -- end if;
    -- 
        -- if reqs.path_reqs.coef_src(path)=path then
          -- if struct.param.coef_mem_type=c_bram then
            -- if struct.param.coef_combined=1 then
              -- struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
            -- else
              -- struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
            -- end if;
          -- end if;
        -- end if;
      -- end loop;
    -- end if;
    -- 
    -- if struct.input_buffer.mem_type=c_bram then
      -- struct.num_bram:=struct.num_bram+calc_num_bram(reqs.data_width,struct.input_buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_extended_mult.vhd

  function define_extended_mult(reqs:t_reqs;
                                elab_dir:string;
                                comp_name: string;
                                mif_file: string;
                                gen_mif_files: boolean) return t_define_extended_mult is
  ------------------------------------------------------------------------------
  --This block currently assumes that bits will not be any bigger 
  --than 35/49 bits so will only generate two columns for coefficients.
  --A future enhancement would be to support any size of coefficient
  --width.
    
    constant data_width_in    : integer:=reqs.path_reqs.data_width(0);
    constant coef_width_in    : integer:=reqs.path_reqs.coef_width(0);
    constant output_width_in  : integer:=reqs.path_reqs.output_width(0);
    constant accum_width_in   : integer:=reqs.path_reqs.accum_width(0);

    variable struct:t_define_extended_mult;
    variable data_path_max_width,
             coef_path_max_width,
             data_path_max_width_orig,
             coef_path_max_width_orig,
             coef_path_0_extra_bit,
             bit_growth,
             accum_0_extra,
             accum_1_extra,
             accum_2_extra,
             accum_3_extra,
             iterations
              : integer;

    variable split_accum_widths: t_split_wide_mif_accum;
    variable max_coef_sums_lower_bits, max_coef_sums_upper_bits: integer:=0;

    --Rounding variables
    -- gui trans_off
    variable rounding_const:std_logic_vector(88 downto 0);
    variable pattern,
             mask: bit_vector(88 downto 0);
    -- gui trans_on
    variable config_OK: boolean:=false;
    variable sym_pairs: boolean:=false;
--     variable halt_config: boolean:=false;
    constant max_iterations: integer := 10;
  begin

    --inherit reqs
    struct.config.reqs:=reqs;

    -- gui trans_off
    struct.config.reqs.path_reqs:=(
                                 data_src    =>(others=>0),
                                 data_width  =>(others=>0),
                                 data_sign   =>(others=>0),
                                 coef_src    =>(others=>0),
                                 coef_width  =>(others=>0),
                                 coef_sign   =>(others=>0),
                                 accum_width =>(others=>0),
                                 output_width=>(others=>0),
                                 round_const_lower=>(others=>0),
                                 round_const_upper=>(others=>0));
    -- gui trans_on

    --Assign to path reqs seperately for VTFC compatibility
    -- gui insert_on
    -- for path_assign in 0 to max_paths-1 loop
    --   struct.config.reqs.path_reqs.data_src(path_assign):=0;
    --   struct.config.reqs.path_reqs.data_width(path_assign):=0;
    --   struct.config.reqs.path_reqs.data_sign(path_assign):=0;
    --   struct.config.reqs.path_reqs.coef_src(path_assign):=0;
    --   struct.config.reqs.path_reqs.coef_width(path_assign):=0;
    --   struct.config.reqs.path_reqs.coef_sign(path_assign):=0;
    --   struct.config.reqs.path_reqs.accum_width(path_assign):=0;
    --   struct.config.reqs.path_reqs.output_width(path_assign):=0;
    --   struct.config.reqs.path_reqs.round_const_lower(path_assign):=0;
    --   struct.config.reqs.path_reqs.round_const_upper(path_assign):=0;
    -- end loop;
    -- gui insert_off

    struct.config.reqs.path_reqs.data_width(0):=data_width_in;
    struct.config.reqs.path_reqs.data_sign(0):=reqs.data_sign;
    struct.config.reqs.path_reqs.coef_width(0):=coef_width_in;
    struct.config.reqs.path_reqs.coef_sign(0):=reqs.coef_sign;
    struct.config.reqs.path_reqs.output_width(0):=output_width_in;

    --Override rounding mode when convergent as rounding
    --done at this level but still need a rounding constant
    --applied to the columns
    if reqs.round_mode=c_convergent_even then
      struct.config.reqs.round_mode:=c_non_symmetric_up;
      struct.config.reqs.has_ext_pat_det:=true;
    elsif reqs.round_mode=c_convergent_odd then
      struct.config.reqs.round_mode:=c_non_symmetric_down;
      struct.config.reqs.has_ext_pat_det:=true;
    end if;

    -- gui trans_off
    rounding_const:= ext_bus(select_rounding_const( struct.config.reqs.round_mode,
                                            accum_width_in,
                                            output_width_in),rounding_const'HIGH+1,c_unsigned);

    pattern:=gen_pattern(reqs.round_mode,accum_width_in,output_width_in,false,pattern'HIGH+1);
    mask   :=gen_mask(accum_width_in,output_width_in,false,mask'HIGH+1);
    -- gui trans_on
    
    --set filter type to be implemented by mac_fir_select , dup of code in mac_fir top level.
    case reqs.filter_type is
      when c_single_rate =>
        struct.config.struct:=single_rate;
      when c_polyphase_decimating =>
        struct.config.struct:=polyphase_decimation;
      when c_polyphase_interpolating =>
        if reqs.symmetry=1 then
          struct.config.struct:=polyphase_interpolation_symmetry;
          struct.config.reqs.filter_type:=c_interpolating_symmetry;
          -- coef_sym_pair:=1;
        else
          struct.config.struct:=polyphase_interpolation;
        end if;
      when c_interpolating_symmetry =>
        struct.config.struct:=polyphase_interpolation_symmetry;
        -- coef_sym_pair:=1;
      when c_hilbert_transform =>
        struct.config.struct:=hilbert;
      when c_interpolated_transform =>
        struct.config.struct:=interpolated;
      when c_halfband_transform =>
        struct.config.struct:=halfband;
      when c_decimating_half_band =>
        struct.config.struct:=halfband_decimation;
      when c_interpolating_half_band =>
        struct.config.struct:=halfband_interpolation;
      when c_polyphase_pq =>
        if reqs.inter_rate>reqs.deci_rate then
          struct.config.struct:=polyphase_pq_interpolation;
        else
          struct.config.struct:=polyphase_pq_decimation;
        end if;
      when c_channelizer_receiver | c_channelizer_transmitter =>
        struct.config.struct:=channelizer;
      when c_transpose_single_rate | c_transpose_decimating | c_transpose_interpolating =>
        struct.config.struct:=transpose;
      when c_polyphase_pq_dec_alt =>
        struct.config.struct:=polyphase_pq_decimation_alt;
      when others =>
        report "FAILURE: FIR Compiler v5.0: Unrecognised filter type: "&integer'image(reqs.filter_type) severity failure;
    end case;

    --Determine structure.
    struct.data_paths:=1;
    struct.coef_paths:=1;

    --Path requirements
    if reqs.family.supports_dsp48e then

      --Swapped so coefficient width is the controlling field, this
      --matches the GUI as it will allow coefficient width > data width
      if coef_width_in+select_integer(reqs.coef_sign,0,struct.config.reqs.filter_type=c_interpolating_symmetry)<=18 then
        --single path
        data_path_max_width:=24;
        coef_path_max_width:=17;
      elsif coef_width_in+select_integer(reqs.coef_sign,0,struct.config.reqs.filter_type=c_interpolating_symmetry)<=25 then
        --single path
        data_path_max_width:=17;
        coef_path_max_width:=24;
      elsif coef_width_in+select_integer(reqs.coef_sign,0,struct.config.reqs.filter_type=c_interpolating_symmetry)<=17+18 then
        data_path_max_width:=24;
        coef_path_max_width:=17;
        struct.coef_paths:=2;
      --else Needs to be a specific check to detect when using mutli-col for large number taps, only on v5
      elsif coef_width_in+select_integer(reqs.coef_sign,0,struct.config.reqs.filter_type=c_interpolating_symmetry)>17+18 then
        data_path_max_width:=17;
        coef_path_max_width:=24;
        struct.coef_paths:=2;
      end if;

      if data_width_in+reqs.data_sign+reqs.symmetry>data_path_max_width+1 then
        --mutli-path
        struct.data_paths:=2;
        if data_width_in+reqs.data_sign+reqs.symmetry>data_path_max_width+data_path_max_width+1 then
          --can't use the path that been allocated to data as the total data width is
          --greater than the supportable width.
          if data_path_max_width=24 or
             (struct.coef_paths=2 and coef_path_max_width=24) then
            report "FAILURE: FIR Compiler v5.0: Extended mult - Unable to support data and coefficient width combination" severity failure;
          else
            data_path_max_width:=24;
            --if coef_path=2 then either data_path_max_width will be set to 24 or
            --the coefficient path needs 24-bits, the above clause will catch it.
            --So coefficient must be on a single path
            struct.coef_paths:=2;
            coef_path_max_width:=17;
          end if;
        end if;
      end if;

    else
      data_path_max_width:=17;
      coef_path_max_width:=17;
      if data_width_in+reqs.data_sign+reqs.symmetry>18 then
        struct.data_paths:=2;
      end if;
      if coef_width_in+select_integer(reqs.coef_sign,0,struct.config.reqs.filter_type=c_interpolating_symmetry)>18 then--+coef_sym_pair
        struct.coef_paths:=2;
      end if;
    end if;
    
    if struct.data_paths=2 and reqs.symmetry=1 then
      --need a smaller offset as will grow a bit in the pre-adder
      data_path_max_width:=data_path_max_width-1;
    end if;

    sym_pairs:=false;
    if struct.config.reqs.filter_type=c_interpolating_symmetry and
       not (reqs.inter_rate=2 and (reqs.num_taps rem 2) > 0 ) then
      sym_pairs:=true;
    end if;

    coef_path_0_extra_bit:=0;
    if struct.coef_paths=2 and sym_pairs then
      --as with symmetric data in this circumstance the coefficient a pre-processed so
      --there will be a bit of growth
      coef_path_max_width:=coef_path_max_width-1;
      coef_path_0_extra_bit:=2;--1;
    end if;

    if struct.coef_paths=1 and struct.data_paths=1 then
      --data and coefficient width do not warrent multi-col
      if accum_width_in>48 and (reqs.family.supports_dsp48e) then
        --Using multi-column for large num taps, should only happen on V5
        struct.data_paths:=2;
        data_path_max_width:=(data_width_in+reqs.data_sign+reqs.symmetry)/2;
      else
        report "FAILURE: FIR Compiler v5.0: Extended mult - Trying to using extended mult block for single column filter" severity failure;
      end if;
    end if;

    --Configure the paths, there is the possibility that the number
    --paths needs to change from 2 to 4 to support the required
    --acuumulator widths
    data_path_max_width_orig:=data_path_max_width;
    coef_path_max_width_orig:=coef_path_max_width;
    -- halt_config:=false;
    iterations:=0;
    while not config_OK and iterations<max_iterations loop --not halt_config

      --Generate split mif files
      if struct.coef_paths>1 then
        -- Check number of entries in input mif file
        -- gui trans_off
        if (get_number_of_inputs(elab_dir&mif_file)<reqs.num_taps*reqs.num_filts) then
        -- gui trans_on
        -- gui insert_on
        -- if (get_number_of_inputs(elab_dir&mif_file)<reqs.num_taps) then
        -- gui insert_off
          -- Changed for XST, getnuminput seem to return one more than in file

          report "NOTE   : FIR Compiler v5.0: mac_fir_extended_mult" severity note;
          report "NOTE   : FIR Compiler v5.0: input mif file has incorrect number of values" severity note;
          report "NOTE   : FIR Compiler v5.0: "&int_to_str(get_number_of_inputs(elab_dir&mif_file) ) severity note;
          report "FAILURE: FIR Compiler v5.0: "&int_to_str(reqs.num_taps*reqs.num_filts ) severity failure;
  
        else
          
          if struct.config.struct=channelizer then
            split_accum_widths:=split_wide_mif (  elab_dir&mif_file,
                                                  reqs.num_taps,
                                                  reqs.num_filts,
                                                  coef_width_in,
                                                  coef_path_max_width,
                                                  coef_path_0_extra_bit,
                                                  reqs.num_channels,
                                                  1,
                                                  gen_mif_files);
          else
            split_accum_widths:=split_wide_mif (  elab_dir&mif_file,
                                                  reqs.num_taps,
                                                  reqs.num_filts,
                                                  coef_width_in,
                                                  coef_path_max_width,
                                                  coef_path_0_extra_bit,
                                                  reqs.inter_rate,
                                                  reqs.deci_rate,
                                                  gen_mif_files);
          end if;
          max_coef_sums_lower_bits:=split_accum_widths.coef_sums_lower_bits;
          max_coef_sums_upper_bits:=split_accum_widths.coef_sums_upper_bits;
        end if;
        
--          report "max_coef_sums_lower_bits: "&int_to_str(max_coef_sums_lower_bits)&cr&
--                 "max_coef_sums_upper_bits: "&int_to_str(max_coef_sums_upper_bits);
      end if;

      struct.config.reqs.has_ext_output_src:=true;
      
      --Setup paths and input/output widths on instaniated FIR
      if struct.data_paths=2 and struct.coef_paths=1 then
        struct.num_paths:=2;
        struct.config.reqs.path_reqs.data_src(1):=1;--make second path unique and not shared
        struct.config.reqs.path_reqs.data_width(0):=data_path_max_width;
        struct.config.reqs.path_reqs.data_sign(0) :=c_unsigned;
        struct.config.reqs.path_reqs.data_width(1):=data_width_in-data_path_max_width;
        struct.config.reqs.path_reqs.data_sign(1) :=reqs.data_sign;
        --Calc accum width for each path
        struct.config.reqs.path_reqs.accum_width(0):=accum_width_in
                                                     -(data_width_in)--+reqs.data_sign)
                                                     +struct.config.reqs.path_reqs.data_width(0)
                                                     +c_unsigned
                                                     +reqs.coef_sign;--need to consider result sign as path output will be sign extended

        struct.config.reqs.path_reqs.accum_width(1):=accum_width_in
                                                      -(data_width_in)
                                                      +struct.config.reqs.path_reqs.data_width(1)
                                                      +reqs.data_sign;

        --Reset accum width to sum of paths
        struct.config.reqs.accum_width:=0;
        for sum in 0 to 1 loop
          struct.config.reqs.accum_width:=struct.config.reqs.accum_width+struct.config.reqs.path_reqs.accum_width(sum);
        end loop;
  
        struct.path_1_weight:=data_path_max_width;

      elsif struct.data_paths=1 and struct.coef_paths=2 then
        struct.num_paths:=2;
        struct.config.reqs.path_reqs.coef_src(1):=1;--make second path unique and not shared
        struct.config.reqs.path_reqs.coef_width(0):=coef_path_max_width+coef_path_0_extra_bit;
        struct.config.reqs.path_reqs.coef_sign(0) :=c_unsigned;
        struct.config.reqs.path_reqs.coef_width(1):=coef_width_in-coef_path_0_extra_bit-coef_path_max_width;
        struct.config.reqs.path_reqs.coef_sign(1) :=reqs.coef_sign;
        --Calc accum width for each path
        if reqs.coef_reload=1 then
          bit_growth:=accum_width_in-coef_width_in-data_width_in;
          if (reqs.coef_sign=c_signed and reqs.data_sign=c_unsigned) then
            --extra bit added on in TCL for this case, this structure always considers data sign so sub
            bit_growth:=bit_growth-1;
          end if;
          if sym_pairs then
            --the coef_width added onto accum_width in GUI is the width specified by the user,
            --not the altered width that's supplied to the core for this structure.
            bit_growth:=bit_growth+1+reqs.coef_sign;
          end if;
          struct.config.reqs.path_reqs.accum_width(0):=bit_growth
                                                        +data_width_in
                                                        +reqs.data_sign
                                                        +struct.config.reqs.path_reqs.coef_width(0)
                                                        +select_integer(c_unsigned,0,coef_path_0_extra_bit>0);
          struct.config.reqs.path_reqs.accum_width(1):=bit_growth
                                                        +data_width_in
                                                        +reqs.data_sign
                                                        +struct.config.reqs.path_reqs.coef_width(1);
          --don't need to consider unsigned as accum width calc is already considering this.
        else
          struct.config.reqs.path_reqs.accum_width(0):=data_width_in+reqs.data_sign+max_coef_sums_lower_bits+c_unsigned;
          struct.config.reqs.path_reqs.accum_width(1):=data_width_in+reqs.data_sign+max_coef_sums_upper_bits;
        end if;
        --Reset accum width to sum of paths
        struct.config.reqs.accum_width:=0;
        for sum in 0 to 1 loop
          struct.config.reqs.accum_width:=struct.config.reqs.accum_width+struct.config.reqs.path_reqs.accum_width(sum);
        end loop;

        struct.path_1_weight:=coef_path_max_width;

      else --both paths>1
        struct.num_paths:=4;
        struct.config.reqs.path_reqs.coef_src(1):=1;
        struct.config.reqs.path_reqs.coef_src(3):=1;
        struct.config.reqs.path_reqs.data_src(2):=2;
        struct.config.reqs.path_reqs.data_src(3):=2;
        struct.config.reqs.path_reqs.data_width(0):=data_path_max_width;
        struct.config.reqs.path_reqs.data_sign(0) :=c_unsigned;
        struct.config.reqs.path_reqs.data_width(2):=data_width_in-data_path_max_width;
        struct.config.reqs.path_reqs.data_sign(2) :=reqs.data_sign;
        struct.config.reqs.path_reqs.coef_width(0):=coef_path_max_width+coef_path_0_extra_bit;
        struct.config.reqs.path_reqs.coef_sign(0) :=c_unsigned;
        struct.config.reqs.path_reqs.coef_width(1):=coef_width_in-coef_path_0_extra_bit-coef_path_max_width;
        struct.config.reqs.path_reqs.coef_sign(1) :=reqs.coef_sign;
        --Calc accum width for each path
        if reqs.coef_reload=1 then
          bit_growth:=accum_width_in-coef_width_in-data_width_in;
          if (reqs.coef_sign=c_signed and reqs.data_sign=c_unsigned) then
            --extra bit added on in TCL for this case, this structure always considers data sign so sub
            bit_growth:=bit_growth-1;
          end if;
          if sym_pairs then
            --the coef_width added onto accum_width in GUI is the width specified by the user,
            --not the altered width that's supplied to the core for this structure.
            bit_growth:=bit_growth+1+reqs.coef_sign;
          end if;

          struct.config.reqs.path_reqs.accum_width(0):=bit_growth
                                                       +struct.config.reqs.path_reqs.coef_width(0)
                                                       +struct.config.reqs.path_reqs.data_width(0)
                                                       +struct.config.reqs.path_reqs.data_sign(0)
                                                       +struct.config.reqs.path_reqs.coef_sign(0);
          struct.config.reqs.path_reqs.accum_width(1):=bit_growth
                                                       +struct.config.reqs.path_reqs.coef_width(1)
                                                       +struct.config.reqs.path_reqs.data_width(0)
                                                       +struct.config.reqs.path_reqs.data_sign(0)
                                                       +struct.config.reqs.path_reqs.coef_sign(1);
          struct.config.reqs.path_reqs.accum_width(2):=bit_growth
                                                       +struct.config.reqs.path_reqs.coef_width(0)
                                                       +struct.config.reqs.path_reqs.data_width(2)
                                                       +struct.config.reqs.path_reqs.data_sign(2)
                                                       +struct.config.reqs.path_reqs.coef_sign(0);
          struct.config.reqs.path_reqs.accum_width(3):=bit_growth
                                                       +struct.config.reqs.path_reqs.coef_width(1)
                                                       +struct.config.reqs.path_reqs.data_width(2)
                                                       +struct.config.reqs.path_reqs.data_sign(2)
                                                       +struct.config.reqs.path_reqs.coef_sign(1);
        else
          struct.config.reqs.path_reqs.accum_width(0):=struct.config.reqs.path_reqs.data_width(0)+
                                                       max_coef_sums_lower_bits+
                                                       struct.config.reqs.path_reqs.data_sign(0)+
                                                       struct.config.reqs.path_reqs.coef_sign(0);
          struct.config.reqs.path_reqs.accum_width(1):=struct.config.reqs.path_reqs.data_width(0)+
                                                       max_coef_sums_upper_bits+
                                                       struct.config.reqs.path_reqs.data_sign(0)+
                                                       struct.config.reqs.path_reqs.coef_sign(1);
          struct.config.reqs.path_reqs.accum_width(2):=struct.config.reqs.path_reqs.data_width(2)+
                                                       max_coef_sums_lower_bits+
                                                       struct.config.reqs.path_reqs.data_sign(2)+
                                                       struct.config.reqs.path_reqs.coef_sign(0);
          struct.config.reqs.path_reqs.accum_width(3):=struct.config.reqs.path_reqs.data_width(2)+
                                                       max_coef_sums_upper_bits+
                                                       struct.config.reqs.path_reqs.data_sign(2)+
                                                       struct.config.reqs.path_reqs.coef_sign(1);
        
        end if;
  
        --Reset accum width to sum of paths
        struct.config.reqs.accum_width:=0;
        for sum in 0 to 3 loop
          struct.config.reqs.accum_width:=struct.config.reqs.accum_width+struct.config.reqs.path_reqs.accum_width(sum);
        end loop;

        struct.four_path_mid_src1:=1; -- D_lower C_high
        struct.four_path_mid_src2:=2; -- D_high C_lower

        struct.path_1_weight:=coef_path_max_width;
        struct.path_2_weight:=data_path_max_width;
        struct.path_3_weight:=data_path_max_width+coef_path_max_width;

        if coef_path_max_width>data_path_max_width then
          --Not just V5 that can have different weights as when symmetry data_width_max will be reduced
          --in size
          struct.four_path_mid_src1:=2;  -- D_high C_lower
          struct.four_path_mid_src2:=1;  -- D_lower C_high
          
          struct.path_1_weight:=data_path_max_width;
          struct.path_2_weight:=coef_path_max_width;
          struct.path_3_weight:=data_path_max_width+coef_path_max_width;

        end if;



      end if;

      config_OK:=true;

--       report "Coef: "&int_to_str(struct.coef_paths)&" Data: "&int_to_str(struct.data_paths);
--       report "Data(0) :"&int_to_str(struct.config.reqs.path_reqs.data_width(0));
--       report "Data(1) :"&int_to_str(struct.config.reqs.path_reqs.data_width(1));
--       report "Data(2) :"&int_to_str(struct.config.reqs.path_reqs.data_width(2));
--       report "Data(3) :"&int_to_str(struct.config.reqs.path_reqs.data_width(3));
--       report "Coef(0) :"&int_to_str(struct.config.reqs.path_reqs.coef_width(0));
--       report "Coef(1) :"&int_to_str(struct.config.reqs.path_reqs.coef_width(1));
--       report "Coef(2) :"&int_to_str(struct.config.reqs.path_reqs.coef_width(2));
--       report "Coef(3) :"&int_to_str(struct.config.reqs.path_reqs.coef_width(3));
--       report "Accum(0) :"&int_to_str(struct.config.reqs.path_reqs.accum_width(0));
--       report "Accum(1) :"&int_to_str(struct.config.reqs.path_reqs.accum_width(1));
--       report "Accum(2) :"&int_to_str(struct.config.reqs.path_reqs.accum_width(2));
--       report "Accum(3) :"&int_to_str(struct.config.reqs.path_reqs.accum_width(3));
--       report "Accum bus :"&int_to_str(struct.config.reqs.accum_width);

      --Check that all the paths can support the required accum width in V5
      --for other families data_width+coef_width does not place a restriction
      --on the max number of taps.
      if reqs.family.supports_dsp48e then
        if struct.data_paths=2 and struct.coef_paths=1 then
          if struct.config.reqs.path_reqs.accum_width(0)>48 then
            --Reduce data width and re-evaluate
            data_path_max_width:=data_path_max_width-(struct.config.reqs.path_reqs.accum_width(0)-48);
  
            config_OK:=false;
          elsif struct.config.reqs.path_reqs.accum_width(1)>48 or
                (struct.config.reqs.path_reqs.data_width(1)+reqs.data_sign>data_path_max_width_orig+1) then
            --Need to switch into 4 col
            coef_path_max_width:=get_min(
                                  coef_path_max_width-select_integer(0,1,sym_pairs),
                                  coef_width_in-( get_max(0,(struct.config.reqs.path_reqs.accum_width(1)-48)
                                                             -(data_path_max_width_orig-data_path_max_width))));
            data_path_max_width:=data_path_max_width_orig;
            struct.coef_paths:=2;
            if sym_pairs then
              coef_path_0_extra_bit:=2;
            end if;
            --reset 2nd data path reqs.
            struct.config.reqs.path_reqs.data_width(1):=0;
            struct.config.reqs.path_reqs.data_src(1):=0;

            config_OK:=false;
          end if;
        elsif struct.data_paths=1 and struct.coef_paths=2 then
          if struct.config.reqs.path_reqs.accum_width(0)>48 then
            coef_path_max_width:=coef_path_max_width-(struct.config.reqs.path_reqs.accum_width(0)-48);

            config_OK:=false;
--           elsif struct.config.reqs.path_reqs.accum_width(1)>48 or
--                 (struct.config.reqs.path_reqs.coef_width(1)+reqs.coef_sign>
--                   coef_path_max_width_orig+1-select_integer(0,1+reqs.coef_sign,sym_pairs)) then
          elsif struct.config.reqs.path_reqs.accum_width(1)>48 or
                (struct.config.reqs.path_reqs.coef_width(1)+select_integer(reqs.coef_sign,0,sym_pairs)>
                 coef_path_max_width_orig+1+select_integer(0,1,sym_pairs)) then
            --Note: when sym pairs the coefficient width provided will already include sign and extra bit growth so 
            --need to correct the check to only add sign when not sym pair.

            --Need to switch into 4 col
            data_path_max_width:=get_min(
                                  data_path_max_width,
                                  data_width_in-( get_max(0,(struct.config.reqs.path_reqs.accum_width(1)-48)
                                                             -(coef_path_max_width_orig-coef_path_max_width))));
            coef_path_max_width:=coef_path_max_width_orig;
            struct.data_paths:=2;
            --reset 2nd coef path reqs.
            struct.config.reqs.path_reqs.coef_width(1):=0;
            struct.config.reqs.path_reqs.coef_src(1):=0;
            config_OK:=false;
          end if;
        else--4 paths

            accum_0_extra:=struct.config.reqs.path_reqs.accum_width(0)-48;
            accum_1_extra:=struct.config.reqs.path_reqs.accum_width(1)-48;
            accum_2_extra:=struct.config.reqs.path_reqs.accum_width(2)-48;
            accum_3_extra:=struct.config.reqs.path_reqs.accum_width(3)-48;

--             report "accum_0_extra: "&int_to_str(accum_0_extra);
--             report "accum_1_extra: "&int_to_str(accum_1_extra);
--             report "accum_2_extra: "&int_to_str(accum_2_extra);
--             report "accum_3_extra: "&int_to_str(accum_3_extra);

            if accum_0_extra>0 or
               accum_1_extra>0 or
               accum_2_extra>0 or
               accum_3_extra>0 then
              config_OK:=false;
              
              if accum_0_extra>0 then
                if accum_1_extra<0 then
                  coef_path_max_width:=coef_path_max_width-abs(accum_1_extra);
                elsif accum_2_extra<0 then
                  data_path_max_width:=data_path_max_width-abs(accum_2_extra);
                end if;
              elsif accum_1_extra>0 and accum_0_extra<0 then
                coef_path_max_width:=coef_path_max_width+abs(accum_0_extra);
              elsif accum_2_extra>0 and accum_0_extra<0 then
                data_path_max_width:=data_path_max_width+abs(accum_0_extra);
              end if;
            end if;

        end if;
      end if;--v5
      iterations:=iterations+1;
    end loop;

    if iterations=max_iterations then
      --This is to catch invalid configurations passed by GUI.
      report "FAILURE: FIR Compiler v5.0: Extended mult - unable to support data/coefficient width and number of taps" severity failure;
    end if;

    --Configure adder blocks
    if struct.num_paths=4 then

      struct.adder(0):=(
            family         => reqs.family,
            implementation => 1,
            pre_add        => 0,
            pre_add_func   => c_preadd_add,
            pre_add_ipreg  => 0,
            pre_add_midreg => 0,
            a_delay        => 0,
            b_delay        => 0,
            p_delay        => 0,
            a_src          => 0,--fabric
            a_sign         => c_signed,
            b_sign         => c_signed,
            d_sign         => c_signed,
            a_width        => 1,--only used for preadder calc
            b_width        => 1,
            reg_opcode     => 0,
            enable_pat_det => false,
            -- gui trans_off
            pattern        => (others=>'0'),
            mask           => (others=>'1'),
            -- gui trans_on
            post_add_width =>  get_max(
                                  get_max(struct.config.reqs.path_reqs.accum_width(1),struct.config.reqs.path_reqs.accum_width(2))+
                                  abs(struct.path_1_weight-struct.path_2_weight),
                                  struct.config.reqs.path_reqs.accum_width(0)-struct.path_1_weight),
            --when Virtex 5 there are different shifts so there is different weights to add together, this means
            --that the two mid adders have to span a larger number of bits.
            calc_func_used => funcs_emb_calc( (0=>C_add_A_concat_B)),
            split_post_adder => reqs.resource_opt=c_speed,
            has_redundant => p_none
            );
      struct.adder_dtls(0):=dtls_emb_calc(struct.adder(0));
      
      struct.adder(1):=(
            family         => reqs.family,
            implementation => 1,
            pre_add        => 0,
            pre_add_func   => c_preadd_add,
            pre_add_ipreg  => 0,
            pre_add_midreg => 0,
            a_delay        => 0,
            b_delay        => 0,
            p_delay        => 0,
            a_src          => 0,--fabric
            a_sign         => c_signed,
            b_sign         => c_signed,
            d_sign         => c_signed,
            a_width        => 1,--only used for preadder calc
            b_width        => 1,
            reg_opcode     => 0,
            enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5),
            -- gui trans_off
            pattern        => (others=>'0'),
            mask           => (others=>'1'),
            -- gui trans_on
            post_add_width =>  get_max(struct.config.reqs.path_reqs.accum_width(1),struct.config.reqs.path_reqs.accum_width(2))+
                               abs(struct.path_1_weight-struct.path_2_weight),
            calc_func_used => funcs_emb_calc( (0=>PCIN_add_C)),
            split_post_adder => reqs.resource_opt=c_speed,
            has_redundant => p_none
            );

      struct.adder_dtls(1):=dtls_emb_calc(struct.adder(1));

      if struct.adder(1).post_add_width>48 or
         struct.adder(0).post_add_width>48 or
         reqs.family.treat_as_s3adsp then  --s3adsp does not support PCIN_add_C opcode
        
        if struct.four_path_mid_src1=1 then
          struct.adder(0).post_add_width:=get_max(
                                            struct.config.reqs.path_reqs.accum_width(1),
                                            struct.config.reqs.path_reqs.accum_width(0)-struct.path_1_weight);
          struct.adder(1).post_add_width:=get_max(
                                            struct.config.reqs.path_reqs.accum_width(1)-abs(struct.path_1_weight-struct.path_2_weight),
                                            struct.config.reqs.path_reqs.accum_width(2));
        else
          struct.adder(0).post_add_width:=get_max(
                                            struct.config.reqs.path_reqs.accum_width(2),
                                            struct.config.reqs.path_reqs.accum_width(0)-struct.path_1_weight);
          struct.adder(1).post_add_width:=get_max(
                                            struct.config.reqs.path_reqs.accum_width(2)-abs(struct.path_1_weight-struct.path_2_weight),
                                            struct.config.reqs.path_reqs.accum_width(1));
        end if;
        
        struct.adder(1).calc_func_used:=funcs_emb_calc( (0=>C_add_A_concat_B));
        struct.adder(0).enable_pat_det:=struct.adder(1).enable_pat_det;
        struct.adder_dtls(0):=dtls_emb_calc(struct.adder(0));
        struct.adder_dtls(1):=dtls_emb_calc(struct.adder(1));

      end if;

      struct.adder(2):=(
            family         => reqs.family,
            implementation => 1,
            pre_add        => 0,
            pre_add_func   => c_preadd_add,
            pre_add_ipreg  => 0,
            pre_add_midreg => 0,
            a_delay        => 0,
            b_delay        => 0,
            p_delay        => 0,
            a_src          => 0,--fabric
            a_sign         => c_signed,
            b_sign         => c_signed,
            d_sign         => c_signed,
            a_width        => 1,--only used for preadder calc
            b_width        => 1,
            reg_opcode     => 0,
            enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5),
            -- gui trans_off
            pattern        => (others=>'0'),
            mask           => (others=>'1'),
            -- gui trans_on
            post_add_width =>  get_max(struct.config.reqs.path_reqs.accum_width(3),
                                       struct.config.reqs.path_reqs.accum_width(2)-struct.path_3_weight),
            calc_func_used => funcs_emb_calc( (0=>C_add_A_concat_B)),
            split_post_adder => reqs.resource_opt=c_speed,
            has_redundant => p_none
            );
      struct.adder_dtls(2):=dtls_emb_calc(struct.adder(2));
      
      struct.config.reqs.ext_src_delay:=struct.adder_dtls(0).pout_latency+2   --1st adder
                                        +1+struct.adder_dtls(1).pout_latency  --2nd adder
                                        +2+struct.adder_dtls(2).pout_latency; --3rd adder

      -- gui trans_off
      struct.config.reqs.path_reqs.round_const_lower(0):=to_integer(unsigned(rounding_const(struct.path_1_weight-1 downto 0)));
      struct.config.reqs.path_reqs.round_const_lower(1):=to_integer(unsigned(rounding_const(struct.path_3_weight-1 downto struct.path_1_weight)));
      struct.config.reqs.path_reqs.round_const_lower(3):=to_integer(unsigned(rounding_const(30+struct.path_3_weight downto struct.path_3_weight)));
      struct.config.reqs.path_reqs.round_const_upper(3):=to_integer(unsigned(rounding_const(48+struct.path_3_weight-1 downto 31+struct.path_3_weight)));

      --Pattern detect on lower bit occur in mac_fir_ block, only for v5
      struct.config.reqs.ext_pattern(struct.path_1_weight-1 downto 0):=pattern(struct.path_1_weight-1 downto 0);
      struct.config.reqs.ext_mask(struct.path_1_weight-1 downto 0):=mask(struct.path_1_weight-1 downto 0);
      struct.adder(1).pattern(struct.path_2_weight-1 downto 0):=pattern(struct.path_3_weight-1 downto struct.path_1_weight);
      struct.adder(1).mask(struct.path_2_weight-1 downto 0):=mask(struct.path_3_weight-1 downto struct.path_1_weight);
      struct.adder(2).pattern:=pattern(struct.path_3_weight+47 downto struct.path_3_weight);
      struct.adder(2).mask:=mask(struct.path_3_weight+47 downto struct.path_3_weight);
      -- gui trans_on

      if struct.adder(1).calc_func_used(C_add_A_concat_B) or
         struct.path_2_weight > struct.path_1_weight then
        -- gui trans_off
        --where the two middle paths have the different weights and the adders outputs are at those different weights
        struct.adder(0).pattern(struct.path_2_weight-struct.path_1_weight-1 downto 0):=pattern(struct.path_2_weight-1 downto struct.path_1_weight);
        struct.adder(0).mask(struct.path_2_weight-struct.path_1_weight-1 downto 0):=mask(struct.path_2_weight-1 downto struct.path_1_weight);
        struct.adder(1).pattern(struct.path_3_weight-struct.path_2_weight-1 downto 0):=pattern(struct.path_3_weight-1 downto struct.path_2_weight);
        struct.adder(1).mask(struct.path_3_weight-struct.path_2_weight-1 downto 0):=mask(struct.path_3_weight-1 downto struct.path_2_weight);

        if struct.four_path_mid_src1=1 then
          --This check is to stop XST crashing, it doesn't like the null range being passed to unsigned or to_integer
          if struct.path_2_weight > struct.path_1_weight then
            struct.config.reqs.path_reqs.round_const_lower(1):=to_integer(unsigned(rounding_const(struct.path_2_weight-1 downto struct.path_1_weight)));
          else
            struct.config.reqs.path_reqs.round_const_lower(1):=0;
          end if;
          struct.config.reqs.path_reqs.round_const_lower(2):=to_integer(unsigned(rounding_const(struct.path_3_weight-1 downto struct.path_2_weight)));
        else
          if struct.path_2_weight > struct.path_1_weight then
            struct.config.reqs.path_reqs.round_const_lower(2):=to_integer(unsigned(rounding_const(struct.path_2_weight-1 downto struct.path_1_weight)));
          else
            struct.config.reqs.path_reqs.round_const_lower(2):=0;
          end if;
          struct.config.reqs.path_reqs.round_const_lower(1):=to_integer(unsigned(rounding_const(struct.path_3_weight-1 downto struct.path_2_weight)));

        end if;
        -- gui trans_on
        if struct.adder(1).calc_func_used(C_add_A_concat_B) then
          struct.config.reqs.ext_src_delay:=struct.config.reqs.ext_src_delay+1;
          --latency increases by one with the off the A:B port registers
        end if;
      end if;

    else
      struct.adder(0):=(
            family         => reqs.family,
            implementation => 1,
            pre_add        => 0,
            pre_add_func   => c_preadd_add,
            pre_add_ipreg  => 0,
            pre_add_midreg => 0,
            a_delay        => 0,
            b_delay        => 0,
            p_delay        => 0,
            a_src          => 0,--fabric
            a_sign         => c_signed,
            b_sign         => c_signed,
            d_sign         => c_signed,
            a_width        => 1,--only used for preadder calc
            b_width        => 1,
            reg_opcode     => 0,
            enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5),
            -- gui trans_off
            pattern        => (others=>'0'),
            mask           => (others=>'1'),
            -- gui trans_on
            post_add_width =>  struct.config.reqs.path_reqs.accum_width(1),
            calc_func_used => funcs_emb_calc( (0=>C_add_A_concat_B)),
            split_post_adder => reqs.resource_opt=c_speed,
            has_redundant => p_none
            );
      struct.adder_dtls(0):=dtls_emb_calc(struct.adder(0));
      struct.config.reqs.ext_src_delay:=struct.adder_dtls(0).pout_latency+2;

      -- gui trans_off
      struct.config.reqs.path_reqs.round_const_lower(0):=to_integer(unsigned(rounding_const(struct.path_1_weight-1 downto 0)));
      struct.config.reqs.path_reqs.round_const_lower(1):=to_integer(unsigned(rounding_const(struct.path_1_weight+30 downto struct.path_1_weight)));
      struct.config.reqs.path_reqs.round_const_upper(1):=to_integer(unsigned(rounding_const(48+struct.path_1_weight-1 downto struct.path_1_weight+31)));

      --Pattern detect on lower bit occur in mac_fir_ block, only for v5
      struct.config.reqs.ext_pattern(struct.path_1_weight-1 downto 0):=pattern(struct.path_1_weight-1 downto 0);
      struct.config.reqs.ext_mask(struct.path_1_weight-1 downto 0):=mask(struct.path_1_weight-1 downto 0);
      struct.adder(1).pattern(47 downto 0):=pattern(struct.path_1_weight+47 downto struct.path_1_weight);
      struct.adder(1).mask(47 downto 0):=mask(struct.path_1_weight+47 downto struct.path_1_weight);
      -- gui trans_on

    end if;

    if reqs.num_paths>1 then
      for path in 1 to reqs.num_paths-1 loop
        --duplicate the base paths for the extended multiply for each of the parallel path
        for ext_paths in 0 to struct.num_paths-1 loop
          struct.config.reqs.path_reqs.data_src(ext_paths+(path*struct.num_paths)):=struct.config.reqs.path_reqs.data_src(ext_paths)+(path*struct.num_paths);
          --need to move the data src to the parallel data path, everything below should be a copy.
          struct.config.reqs.path_reqs.data_width(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.data_width(ext_paths);
          struct.config.reqs.path_reqs.data_sign(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.data_sign(ext_paths);
          struct.config.reqs.path_reqs.coef_src(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.coef_src(ext_paths);
          struct.config.reqs.path_reqs.coef_width(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.coef_width(ext_paths);
          struct.config.reqs.path_reqs.coef_sign(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.coef_sign(ext_paths);
          struct.config.reqs.path_reqs.accum_width(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.accum_width(ext_paths);
          struct.config.reqs.path_reqs.output_width(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.output_width(ext_paths);
          -- gui trans_off
          struct.config.reqs.path_reqs.round_const_lower(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.round_const_lower(ext_paths);
          struct.config.reqs.path_reqs.round_const_upper(ext_paths+path*struct.num_paths):=struct.config.reqs.path_reqs.round_const_upper(ext_paths);
          -- gui trans_on
        end loop;
      end loop;
      --assign single extended path accum width to all parallel paths
      -- gui trans_off
      struct.accum_widths(reqs.num_paths-1 downto 0):=(others=>struct.config.reqs.accum_width);
      -- gui trans_on
      -- gui insert_on
      -- for tmp_loop in reqs.num_paths-1 downto 0 loop
      --   struct.accum_widths(tmp_loop):=struct.config.reqs.accum_width;
      -- end loop;
      -- gui insert_off

      --Multiply up the total accum width parameter, the output width should already be multiplied for each path?
      struct.config.reqs.accum_width:=struct.config.reqs.accum_width*reqs.num_paths;
      struct.config.reqs.num_paths:=struct.num_paths*reqs.num_paths;
    else
      struct.config.reqs.num_paths:=struct.num_paths;
      struct.accum_widths(0):=struct.config.reqs.accum_width;
    end if;
    
    struct.path_comb_lat:=struct.config.reqs.ext_src_delay;

    if reqs.resource_opt=c_speed then
      struct.config.reqs.ext_src_delay:=struct.config.reqs.ext_src_delay+1;
    end if;

    return struct;
  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_transpose.vhd

  function define_transpose(reqs:t_reqs;
                            elab_dir,
                            comp_name,
                            mif_file:string;
                            gen_mif: boolean;
                            gen_reorder_seq: boolean) return t_define_transpose is
  ------------------------------------------------------------------------------

    variable struct: t_define_transpose;
    
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- has_lut6(reqs.family));
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- has_lut6(reqs.family));
    variable implementation:integer:=1;--structural
    variable  data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              filter_sel_dly,
              addr_dly,
              -- coef_comb,
              taps_per_phase,
              num_phases,
              base_count_orig
              :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    -- variable split_col_lengths : t_split_col_len;
    -- gui trans_off
    variable rounding_const: std_logic_vector(47 downto 0);
    -- gui trans_on
    -- gui insert_on
    -- variable macs_used: integer;
    -- variable phases_to_gen,delay_scaling: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.data_sign:=reqs.data_sign;
    struct.param.coef_sign:=reqs.coef_sign;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;--1;--
    --currently transpose will only work on single channel.
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=0;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=reqs.num_taps;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;

    --Calculate details of the filter-------------------------------------------
    --Number of macs and number of taps per mac
    if ( reqs.clk_per_samp/struct.param.num_channels = 0 ) then
      report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
    elsif ( reqs.clk_per_samp rem struct.param.num_channels > 0 ) then
      -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
    end if;

     struct.param.clk_per_chan := reqs.clk_per_samp / struct.param.num_channels;

    struct.param.base_count := struct.param.clk_per_chan / reqs.inter_rate;

    taps_per_phase:=struct.param.num_taps_calced;
    num_phases:=1;

    if reqs.filter_type=c_transpose_decimating then
      taps_per_phase:= struct.param.num_taps_calced / reqs.deci_rate;
      if ( struct.param.num_taps_calced rem reqs.deci_rate > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;
      num_phases:=reqs.deci_rate;
    elsif reqs.filter_type=c_transpose_interpolating then
      taps_per_phase:= struct.param.num_taps_calced / reqs.inter_rate;
      if ( struct.param.num_taps_calced rem reqs.inter_rate > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;
      num_phases:=reqs.inter_rate;
    end if;

    struct.param.num_macs := taps_per_phase/struct.param.base_count;

    if (taps_per_phase rem struct.param.base_count > 0 ) then
    -- Add extra mac, this mac will need the filter coefficients padded out.
      struct.param.num_macs:=struct.param.num_macs+1;
    end if;


    base_count_orig:=struct.param.base_count;

    --Adjust for unused cycles
    struct.param.base_count:=taps_per_phase/struct.param.num_macs;
    if (taps_per_phase rem struct.param.num_macs >0) then
      struct.param.base_count:=struct.param.base_count+1;
    end if;

    if struct.param.base_count<base_count_orig then
      struct.shorter_px_time:=true;
    else
      struct.shorter_px_time:=false;
    end if;

    struct.param.centre_mac:=struct.param.num_macs;

    struct.param.base_data_space := struct.param.base_count;
    struct.param.base_coef_space := struct.param.base_count*num_phases;

    -- Modify and update so get actual filter size
    struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*num_phases;

    struct.param.inter_rate := reqs.inter_rate;
    struct.param.deci_rate  := reqs.deci_rate;

    struct.param.no_data_mem   := 0;
    struct.param.full_parallel := 0;
    if (struct.param.base_count = 1) then
      struct.param.no_data_mem   := 1;
      struct.param.full_parallel := 1;
    end if;

    --Structural decisions------------------------------------------------------
    struct.param.single_mac:=0;
    if struct.param.num_macs=1 then
      struct.param.single_mac:=1;
    end if;

    --Memory calculations-------------------------------------
    data_depth_rolling:=integer(2**log2roundup(struct.param.num_taps_calced*struct.param.num_channels));
    data_depth_unpacked:=data_depth_rolling;
    data_depth_packed:=data_depth_rolling;
    --always want to use rolling address scheme when bram

    coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
    coef_depth_packed:=coef_depth_unpacked;
    --For this structure to offer a glitch free switch to a new coefficient set
    --the filter block needs to be able to strip off filter sel address.

    struct.param:=memory_calcs( reqs,
                                struct.param,
                                data_depth_unpacked,
                                data_depth_packed,
                                data_depth_rolling,
                                coef_depth_unpacked,
                                coef_depth_packed,
                                true,
                                false);
    --override coef mem packed so always unpacked, only has relavence for multi-set
    --or reload and this requires unpacked coefficient memory.
    struct.param.coef_packed:=0;

    --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

    --Memory parameters needed for calcs
    struct.coef_ram:= ( family              => reqs.family,
                        implementation      => 1,
                        mem_type            => struct.param.coef_mem_type,
                        write_mode          => 0,
                        has_ce              => reqs.has_ce,
                        use_mif             => 1,
                        resource_opt        => reqs.resource_opt,
                        is_rom              => reqs.coef_reload=0 );

    if struct.param.coef_mem_depth=1 then
      struct.coef_ram_lat:=0;
    elsif reqs.coef_reload=1 or struct.param.coef_combined=1 then
      struct.coef_ram_lat:=lat_ram(struct.coef_ram,2);
    else
      struct.coef_ram_lat:=lat_ram(struct.coef_ram,1);
    end if;

    --------------------------------------------------------------------------
    struct.first_tap_extra_dly:=0;

    if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
      struct.data_dly_modifier:=-1;
    else
      struct.data_dly_modifier:=0;
    end if;

    --------------------------------------------------------------------------
    -- First need to decide whether or not we will have an accumulator and/or a rounding block
    struct.has_rounder :=
          ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
       or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
       or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );

    --Rounding settings---------------------------------------
    struct.round_first_cycle := true;
    struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                and not struct.has_rounder
                                and struct.shorter_px_time;

    struct.cmux_required  := false;
    struct.pinfb_dynamic  := false;
    struct.pinfb_constant := false;

    if struct.has_rounder then
      if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
        -- Always need a fabric carry for Spartan-3A DSP
        -- Pass the accum_result to C port of rounder and add the rounding constant via
        -- the A:B concat port and the carryin bit via fabric
        struct.use_rounder_cport     := true;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 2;
      elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
        -- Need a fabric carry for symmetric round to zero in V-4
        -- Pass the accum_result to C port of rounder and add the rounding constant via
        -- the A:B concat port and the carryin bit via fabric
        struct.use_rounder_cport     := true;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 2;
      else
        -- Any V5 case and V-4 symmetric round to infinity
        -- Round normally using rounding constant on C port added to PCOUT of accumulator
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := true;
        struct.rounder_delay         := 1;
      end if;
    else
      struct.use_rounder_cport     := false;
      struct.use_rounder_pcin      := false;
      struct.rounder_delay         := 0;
    end if;

    struct.use_approx := false;
    if        (reqs.round_mode=2 or reqs.round_mode=3)
      and     reqs.allow_approx=1
      and not struct.shorter_px_time
      and not struct.has_rounder
      and     struct.round_first_cycle
      then
      struct.use_approx := true;
    end if;

    struct.rounder:=(
        family         => reqs.family,
        implementation => implementation,
        pre_add        => 0,
        pre_add_func   => 0,
        pre_add_ipreg  => 0,
        pre_add_midreg => 0,
        a_delay        => 0,
        b_delay        => 0,
        p_delay        => 0,
        a_src          => 0,
        a_sign         => c_signed,
        b_sign         => c_signed,
        d_sign         => c_signed,
        a_width        => 1,--only used for preadder calc
        b_width        => 1,
        reg_opcode     => 1,
        enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
        -- gui trans_off
        pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        -- gui trans_on
        post_add_width => max_val(reqs.path_reqs.accum_width),
        calc_func_used => funcs_emb_calc(
                            select_func_list(
                              select_func_list(
                                (0=>PCIN_add_C),
                                (0=>PCIN_add_A_concat_B),
                                struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                              (0=>C_add_A_concat_B),
                              struct.use_rounder_cport) ),
        split_post_adder => false,--reqs.resource_opt=c_speed,
        has_redundant => p_none
        );
    --when rounder used with multi-path assume that all accum_widths are the same. When
    --used for >18/25-bit rounding occurs external to this block.

    -- gui trans_off
    if reqs.has_ext_pat_det then
      struct.rounder.pattern:=reqs.ext_pattern;
      struct.rounder.mask:=reqs.ext_mask;
    end if;
    -- gui trans_on

    if struct.has_rounder then
      rounder_dtls:=dtls_emb_calc(struct.rounder);
      struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;
    end if;

    --Filter arm settings-------------------------------------

    if (reqs.col_mode=1) then
      num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
    else
      num_col:=1;
    end if;

    --For use below to pass rounding constant filter arm,
    --all paths will have same widths for standard multipath, can't do this when 
    --being used for extended mult structure
    -- gui trans_off
    if not reqs.has_ext_output_src then
      rounding_const:=ext_bus(
                        select_rounding_const(
                          reqs.round_mode,
                          reqs.path_reqs.accum_width(0),
                          reqs.path_reqs.output_width(0)),
                        rounding_const'LENGTH,
                        c_unsigned);
    end if;
    -- gui trans_on
    
    struct.filt_arm:= (
        family          => reqs.family,
        implementation  => implementation,
        num_taps        => struct.param.num_macs,
        result_phasing  => select_integer(
                              reqs.inter_rate,
                              struct.param.num_channels,
                              reqs.filter_type=c_transpose_single_rate),
        cycles_per_op   => struct.param.base_count,
        data_mem_type   => struct.param.data_mem_type,
        coef_mem_type   => struct.param.coef_mem_type,
        no_data_mem     => struct.param.no_data_mem,
        coef_comb       => struct.param.coef_combined,
        coef_mem_depth  => struct.param.coef_mem_depth,
        data_mem_depth  => struct.param.data_mem_depth,
        num_filter_sets => reqs.num_filts*select_integer(1,2,struct.param.coef_reload=1),
        --p_src           => select_integer(2,0,(reqs.round_mode>1 and not struct.has_rounder)),--fabric
        p_src           => select_integer(0,2,struct.param.full_parallel=1 and reqs.filter_type=c_transpose_single_rate and not (reqs.round_mode>1 and not struct.has_rounder) ),
                            --this structure needs to use the C port on the first dsp in the column other wise it would need
                            --a unique opcode not using C or PCIN. Only fully parallel structures can set it to 2 and only when
                            --a rounding constant is not being applied.
        has_ce          => reqs.has_ce,
        reload          => reqs.coef_reload,
        reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.coef_ram_lat>1),
        reload_depth    => struct.param.base_coef_space,
        -- gui trans_off
        output_index    => ( others=>1),
        output_src      => ( others=> 0),
        -- gui trans_on
        num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
        inter_split_col_dly => reqs.col_pipe_len,
        split_col_len             => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                       -- others=>reqs.col_wrap_len),
        dynamic_opcode  => select_integer(1,0,struct.param.full_parallel=1 and reqs.filter_type=c_transpose_single_rate and not(not struct.has_rounder and reqs.round_mode>1) ),
        resource_opt    => reqs.resource_opt,
        pat_det_tap_num => select_integer(
                             0,
                             1,
                             ((reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                             not struct.has_rounder)),
        -- gui trans_off
        pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
        round_const_lower =>(others=>to_integer(unsigned(rounding_const(30 downto 0)))),
        round_const_upper =>(others=>to_integer(unsigned(rounding_const(47 downto 31)))),
        apply_rounding => (reqs.round_mode>1) and not struct.has_rounder,
        -- gui trans_on
        dynamic_calc_func_used_broadcast => funcs_emb_calc(
                                              select_func_list(
                                               ( 0=>NOP,1=>P_add_A_mult_B,2=>PCIN_add_A_mult_B ),
                                               ( 0=>NOP,1=>P_add_A_mult_B,2=>PCIN_add_A_mult_B, 3=>C ),
                                               reqs.round_mode>1 and not struct.has_rounder)),
        dynamic_calc_func_used_break => funcs_emb_calc(
                                          select_func_list(
                                            ( 0=>NOP,1=>P_add_A_mult_B,2=>C_add_A_mult_B),
                                            ( 0=>NOP,1=>P_add_A_mult_B,2=>C_add_A_mult_B, 3=>C ),
                                            reqs.round_mode>1 and not struct.has_rounder)),
        split_adder_chain => false,
        p_has_redundant => false,
        num_independant_col => struct.param.num_paths,
        indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                 data_width => struct.param.path_reqs.data_width,
                                 data_sign  => struct.param.path_reqs.data_sign,
                                 coef_src   => struct.param.path_reqs.coef_src,
                                 coef_width => struct.param.path_reqs.coef_width,
                                 coef_sign  => struct.param.path_reqs.coef_sign,
                                 pin_width  => struct.param.path_reqs.accum_width,
                                 cntrl_src  => (others=>0) ),
        data_fanout     => select_integer(16,10,reqs.family.treat_as_s3adsp)
        );

    -- gui trans_off
    if reqs.has_ext_pat_det then
      struct.filt_arm.pattern:=reqs.ext_pattern;
      struct.filt_arm.mask:=reqs.ext_mask;
    end if;
    
    if reqs.has_ext_output_src then
      struct.filt_arm.round_const_lower:=reqs.path_reqs.round_const_lower;
      struct.filt_arm.round_const_upper:=reqs.path_reqs.round_const_upper;
    end if;
    -- gui trans_on

    struct.filt_arm_lat:=dtls_filt_arm_transpose(struct.filt_arm);

    struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;

    --Determine the width of p for each path
    -- gui trans_off
    struct.pcin_width:=(others=>0);

    for i in 0 to reqs.num_paths-1 loop
      struct.pcin_width(i):=struct.filt_arm_lat.pc_width(i);
      struct.p_extra_bits(i):=struct.filt_arm_lat.pc_width(i)-reqs.path_reqs.accum_width(i);

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));

    end loop;
    -- gui trans_on

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => select_integer(
                            struct.param.base_count,
                            base_count_orig,
                            reqs.filter_type=c_transpose_interpolating and struct.shorter_px_time),
        cnt2_max_val    => num_phases,
        cnt3_max_val    => struct.param.num_channels,
        cnt2_max_qual   => select_integer(
                              1,
                              0,
                              (struct.param.full_parallel=1 and reqs.filter_type=c_transpose_decimating) or
                              (reqs.filter_type=c_transpose_interpolating and struct.shorter_px_time) ),
        family          => reqs.family,
        implementation  => implementation );

    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count*
                           select_integer(struct.param.num_channels,1,struct.param.data_mem_type=c_srl16),--different address generation for srl16s
        block_cnt       => struct.param.num_macs*
                           select_integer(1,struct.param.num_channels,struct.param.data_mem_type=c_srl16)*
                           select_integer(num_phases,1,reqs.filter_type=c_transpose_interpolating),
        symmetric       => 0,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => 1,
        combined        => 0,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => 0,
        block_end_dly   => 0,
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => true  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count,
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count*num_phases,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => 0,
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count*num_phases,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,
    
      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => select_integer(1,0,reqs.filter_type=c_transpose_decimating),
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.coef_ram_lat>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);
    if reqs.filter_type=c_transpose_decimating then
      struct.reload_cntrl_param_lat.filt_sel_lat:=struct.reload_cntrl_param_lat.filt_sel_lat+1;
      --Add one as filter_sel latch is done using we_gen_dly rather than nd_int
    end if;


    struct.addr_cntrl_lat:=1;

    struct.filter_sel_lat:=0;
    if (reqs.coef_reload=1 or reqs.num_filts>1) and reqs.filter_type=c_transpose_decimating then
      struct.filter_sel_lat:=1;
    end if;

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1+struct.filter_sel_lat)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat-struct.filter_sel_lat;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.write_phase_dly :=struct.data_addr_param.write_phase_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;
    struct.data_addr_param.sub_block_end_dly :=struct.data_addr_param.sub_block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay;

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay;

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    struct.rfd_param:=(
        family          => reqs.family,
        implementation  => implementation,
        cnt             => struct.param.clk_per_chan,
        cnt_long        => struct.param.clk_per_chan,
        has_nd          => reqs.has_nd );
    
    if reqs.filter_type=c_transpose_single_rate then
      if reqs.coef_reload=0 then
        struct.vector_cnt_len:=reqs.num_taps;
      else
        struct.vector_cnt_len:=struct.param.num_taps_calced;
      end if;
    elsif reqs.filter_type=c_transpose_decimating then
      if reqs.coef_reload=1 then
        struct.vector_cnt_len:=struct.param.num_taps_calced/reqs.deci_rate;
      else
        struct.vector_cnt_len:=taps_per_phase;
      end if;
      struct.vector_cnt_len:=get_max(struct.vector_cnt_len,2);--need to count out a minimum of one output when rate=taps as first output could be corrupt, second will be OK
    else
      --Interpolation
      if reqs.coef_reload=0 then
        struct.vector_cnt_len:=((reqs.num_taps/reqs.inter_rate)+select_integer(0,1,reqs.num_taps rem reqs.inter_rate>0))
                                *reqs.inter_rate;
      else
        struct.vector_cnt_len:=struct.param.num_taps_calced;
      end if;
      struct.vector_cnt_len:=struct.vector_cnt_len-(struct.param.inter_rate-1);
    end if;

    --Latency Calculation
    struct.buffer_type:=0;
    struct.buffer_page_size:=0;
    struct.latency:=struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- for path in 0 to reqs.num_paths-1 loop
    --   struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --   if struct.has_rounder and
    --      (not reqs.family.has_fabric_dsp48) then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if path = 0 then
    --     struct.num_dsp_per_path:=struct.num_dsp;
    --   end if;
    --   if reqs.path_reqs.data_src(path)=path then
    --     if  struct.param.no_data_mem=0 and
    --         struct.param.data_mem_type=c_bram then
    --
    --       struct.num_bram:=struct.num_bram+calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family);
    -- 
    --       phases_to_gen:=select_integer(struct.filt_arm.num_taps,struct.filt_arm.result_phasing,struct.filt_arm.num_taps>struct.filt_arm.result_phasing);
    --       if phases_to_gen>0 then
    --         for i in 1 to phases_to_gen-1 loop
    --           delay_scaling:=(struct.filt_arm.num_taps/struct.filt_arm.result_phasing)+
    --                                       select_integer(0,1,(struct.filt_arm.num_taps rem struct.filt_arm.result_phasing)>(i-1));
    --           struct.num_bram:=struct.num_bram+calc_delay_bram(
    --                                             reqs.path_reqs.data_width(path),
    --                                             struct.filt_arm.cycles_per_op*((delay_scaling*struct.filt_arm.result_phasing)-1),
    --                                             select_integer(0,1,struct.filt_arm.data_mem_type=c_srl16),
    --                                             reqs.family);
    --         end loop;
    --       end if;
    --     end if;
    --   end if;
    -- 
    --   if reqs.path_reqs.coef_src(path)=path then
    --     if struct.param.coef_mem_type=c_bram then
    --       if struct.param.coef_combined=1 then
    --         struct.num_bram:=struct.num_bram+(tcl_to_int((struct.param.num_macs+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --       else
    --         struct.num_bram:=struct.num_bram+(struct.param.num_macs*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth,reqs.family));
    --       end if;
    --     end if;
    --   end if;
    -- end loop;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir_channelizer.vhd

  function define_channelizer(reqs:t_reqs;
                              elab_dir,
                              comp_name,
                              mif_file:string;
                              gen_mif: boolean;
                              gen_reorder_seq: boolean) return t_define_channelizer is
  ------------------------------------------------------------------------------

    variable struct: t_define_channelizer;
    constant srl16_mem_depth_thres: integer:=reqs.family.lut_depth*2;--select_integer(32,64,
                                                            -- reqs.family.lut6);
    constant dram_mem_depth_thres: integer:=reqs.family.lut_depth;--select_integer(16,32,
                                                           -- reqs.family.lut6);
    variable implementation:integer:=1;--structural
    variable  data_depth_unpacked,
              data_depth_packed,
              data_depth_rolling,
              coef_depth_unpacked,
              coef_depth_packed,
              num_col,
              filter_sel_dly,
              addr_dly,
              taps_per_phase
              :integer;
    variable mif_status:t_gen_mif_status;
    variable rounder_dtls : t_emb_calc_details;
    variable split_col_lengths : t_split_col_len;
    -- gui insert_on
    -- variable macs_used: integer;
    -- gui insert_off
  begin
    --Defaults and direct copies
    struct.param.family:=reqs.family;
    struct.param.filter_type:=reqs.filter_type;
    struct.param.coef_reload:=reqs.coef_reload;
    struct.param.data_sign:=reqs.data_sign;
    struct.param.coef_sign:=reqs.coef_sign;
    struct.param.num_paths:=reqs.num_paths;
    struct.param.path_reqs:=reqs.path_reqs;
    struct.param.clk_per_samp:=reqs.clk_per_samp;
    struct.param.num_channels:=reqs.num_channels;
    struct.param.num_taps:=reqs.num_taps;
    struct.param.num_filts:=reqs.num_filts;
    struct.param.zero_packing_factor:=reqs.zero_packing_factor;

    struct.param.symmetry:=0;
    struct.param.neg_symmetry:=0;
    struct.param.odd_symmetry:=0;
    struct.param.num_taps_calced:=reqs.num_taps;
    struct.reg_output:=reqs.reg_output;
    if reqs.sclr_determ=1 and reqs.has_sclr=1 then
      struct.reg_output:=1;
    end if;
    
      --Calculate details of the filter-------------------------------------------
      --Number of macs and number of taps per mac
--       if ( reqs.clk_per_samp/reqs.num_channels = 0 ) then
--         report "ERROR: FIR Compiler v5.0: not enough clock cycles per sample to process all channels, must have a minimum of 1 clk cycle per channel" severity error;
--       elsif ( reqs.clk_per_samp rem reqs.num_channels > 0 ) then
--         -- report "FIR: number of channels does not fit fully into clock cycles per sample, there will be unused clock cycles" severity note;
--       end if;

      if reqs.filter_type=c_channelizer_transmitter then
        struct.param.clk_per_chan := reqs.clk_per_samp/reqs.num_channels;
      else
        struct.param.clk_per_chan := reqs.clk_per_samp;-- / reqs.num_channels;
      end if;
          
      struct.param.base_count := struct.param.clk_per_chan;

      taps_per_phase:= struct.param.num_taps_calced / reqs.num_channels;
      if ( struct.param.num_taps_calced rem reqs.num_channels > 0) then
        taps_per_phase:=taps_per_phase+1;
      end if;

      struct.param.num_macs := taps_per_phase/struct.param.base_count;

      if ( taps_per_phase rem struct.param.base_count > 0 ) then
      -- Add extra mac, this mac will need the filter coefficients padded out.
        struct.param.num_macs:=struct.param.num_macs+1;
      end if;

      --Adjust for unused cycles
      struct.param.base_count:=taps_per_phase/struct.param.num_macs;
      if (taps_per_phase rem struct.param.num_macs >0) then
        struct.param.base_count:=struct.param.base_count+1;
      end if;

      if struct.param.base_count<struct.param.clk_per_chan then
        struct.shorter_px_time:=true;
      else
        struct.shorter_px_time:=false;
      end if;

      struct.param.centre_mac:=struct.param.num_macs;

      struct.param.base_data_space := struct.param.base_count;
      struct.param.base_coef_space := struct.param.base_count*reqs.num_channels;

      -- Modify and update so get actual filter size
      struct.param.num_taps_calced:=struct.param.num_macs*struct.param.base_count*reqs.num_channels;

      struct.param.inter_rate := 1;
      struct.param.deci_rate  := 1;

      struct.param.no_data_mem   := 0;
      struct.param.full_parallel := 0;
      if (struct.param.base_count = 1) then
        struct.param.no_data_mem   := 1;
        struct.param.full_parallel := 1;
      end if;

      --Structural decisions------------------------------------------------------
      struct.param.single_mac:=0;
      if struct.param.num_macs=1 then
        struct.param.single_mac:=1;
      end if;

      --Memory calculations-------------------------------------
      data_depth_unpacked:=integer(2**log2roundup(struct.param.base_data_space))*reqs.num_channels;
      data_depth_packed:=struct.param.base_data_space*reqs.num_channels;
      data_depth_rolling:=integer(2**log2roundup(struct.param.base_data_space*reqs.num_channels));

      coef_depth_unpacked:=integer(2**log2roundup( integer(2**log2roundup(struct.param.base_coef_space))*struct.param.num_filts))*integer(2**struct.param.coef_reload);
      coef_depth_packed:=struct.param.base_coef_space*struct.param.num_filts*integer(2**struct.param.coef_reload);

      struct.param:=memory_calcs( reqs,
                                  struct.param,
                                  data_depth_unpacked,
                                  data_depth_packed,
                                  data_depth_rolling,
                                  coef_depth_unpacked,
                                  coef_depth_packed,
                                  true,
                                  reqs.num_paths=1);

      --Generate mif files and determine optimised taps
      mif_status:=gen_mif_files(elab_dir,
                                comp_name,
                                mif_file,
                                struct.param,
                                gen_mif,
                                gen_reorder_seq);

      -- synthesis translate_off
      struct.reorder_seq:=mif_status.reorder_seq;
      -- synthesis translate_on

      --Symmetric wrap over calculations-------------------------
      struct.mem_param:=( family           =>reqs.family,
                          implementation   =>implementation,
                          data_mem_type    =>struct.param.data_mem_type,
                          coef_mem_type    =>struct.param.coef_mem_type,
                          data_comb        =>struct.param.data_combined,
                          coef_comb        =>struct.param.coef_combined,
                          data_coef_comb   =>struct.param.data_coef_combined,
                          no_data_mem      =>struct.param.no_data_mem,
                          coef_mem_depth  => struct.param.coef_mem_depth,
                          has_ce           =>reqs.has_ce,
                          coef_reload      =>reqs.coef_reload,
                          coef_reload_depth=>struct.param.base_coef_space,
                          symmetric        =>struct.param.symmetry,
                          resource_opt     =>reqs.resource_opt );

      struct.memory_path_lat:=lat_tap_memory_add_casc(struct.mem_param);

      struct.first_tap_extra_dly:=0;

      if struct.param.data_mem_type=c_srl16 and struct.param.no_data_mem=0 then
        struct.data_dly_modifier:=-1;
      else
        struct.data_dly_modifier:=0;
      end if;

      --------------------------------------------------------------------------
      -- First need to decide whether or not we will have an accumulator and/or a rounding block
      struct.accum_req:=true;
      if (struct.param.base_count=1 and struct.param.num_macs>1) or (struct.param.num_macs=1) then
        struct.accum_req:=false;
      end if;

      struct.has_rounder :=
            ( (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp )
         or (  reqs.round_mode=2                       and reqs.family.emb_calc_prim=p_dsp48   )
         or ( (reqs.round_mode=2 or reqs.round_mode=3) and ( reqs.allow_approx=0 and not struct.shorter_px_time ) );

      --Rounding settings---------------------------------------
      struct.round_first_cycle := not struct.has_rounder
                              and ( reqs.round_mode > 3
                                 or (   (reqs.round_mode=2 or reqs.round_mode=3)
                                    and not struct.shorter_px_time
                                    and reqs.allow_approx=1
                                    )
                                  );
      struct.round_spare_cycle := (reqs.round_mode=2 or reqs.round_mode=3)
                                  and not struct.has_rounder
                                  and struct.shorter_px_time;
  
      struct.cmux_required  := false;
      struct.pinfb_dynamic  := false;
      struct.pinfb_constant := false;
      
      if struct.has_rounder then
        if (reqs.round_mode=2 or reqs.round_mode=3) and reqs.family.treat_as_s3adsp then
          -- Always need a fabric carry for Spartan-3A DSP
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        elsif reqs.round_mode=2 and reqs.family.emb_calc_prim=p_dsp48 then
          -- Need a fabric carry for symmetric round to zero in V-4
          -- Pass the accum_result to C port of rounder and add the rounding constant via
          -- the A:B concat port and the carryin bit via fabric
          struct.use_rounder_cport     := true;
          struct.use_rounder_pcin      := false;
          struct.rounder_delay         := 2;
        else
          -- Any V5 case and V-4 symmetric round to infinity
          -- Round normally using rounding constant on C port added to PCOUT of accumulator
          struct.use_rounder_cport     := false;
          struct.use_rounder_pcin      := true;
          struct.rounder_delay         := 1;
        end if;

        --struct.rounder_delay:=struct.rounder_delay+struct.accum_lat.pout_latency;
      else
        struct.use_rounder_cport     := false;
        struct.use_rounder_pcin      := false;
        struct.rounder_delay         := 0;
      end if;
  
      struct.use_approx := false;
      if        (reqs.round_mode=2 or reqs.round_mode=3)
        and     reqs.allow_approx=1
        and not struct.shorter_px_time
        and not struct.has_rounder
        and     struct.round_first_cycle
        then
        struct.use_approx := true;
      end if;

      struct.rounder:=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => 0,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 0,
          b_delay        => 0,
          p_delay        => 0,
          a_src          => 0,
          a_sign         => c_signed,
          b_sign         => c_signed,
          d_sign         => c_signed,
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => max_val(reqs.path_reqs.accum_width),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN_add_C),
                                  (0=>PCIN_add_A_concat_B),
                                  struct.use_rounder_pcin and reqs.family.treat_as_s3adsp),
                                (0=>C_add_A_concat_B),
                                struct.use_rounder_cport) ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );
      --when rounder used with multi-path assume that all accum_widths are the same. When
      --used for >18/25-bit rounding occurs external to this block.

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.rounder.pattern:=reqs.ext_pattern;
        struct.rounder.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      if struct.has_rounder then
        rounder_dtls:=dtls_emb_calc(struct.rounder);
        struct.rounder_delay:=struct.rounder_delay+rounder_dtls.pout_latency;--dtls_emb_calc(struct.rounder).pout_latency;
      end if;

      --Filter arm settings-------------------------------------

      if (reqs.col_mode=1) then
        num_col:=calc_num_split_col(struct.param.num_macs,reqs.col_config);
      else
        num_col:=1;
      end if;

      struct.filt_arm:= (
          family          => reqs.family,
          implementation  => implementation,
          num_taps        => struct.param.num_macs,
          inter_we_cycles => struct.param.base_count,
          inter_tap_delay => struct.param.num_channels+1,
          inter_sym_tap_delay => struct.param.num_channels+1,
          symmetric       => struct.param.symmetry,
          pre_add_func    => select_integer(c_preadd_add,c_preadd_sub,struct.param.neg_symmetry=1),
          data_mem_type   => struct.param.data_mem_type,
          coef_mem_type   => struct.param.coef_mem_type,
          data_comb       => struct.param.data_combined,
          coef_comb        =>struct.param.coef_combined,
          data_coef_comb  => struct.param.data_coef_combined,
          data_cascade    => 0,
          no_data_mem     => struct.param.no_data_mem,
          data_dual       => 0,
          coef_mem_depth  => struct.param.coef_mem_depth,
          data_mem_depth  => struct.param.data_mem_depth,
          p_src           => select_integer(2,0,not struct.has_rounder
                                              and (struct.param.single_mac=1 or struct.param.full_parallel=1)),--fabric
          has_ce          => reqs.has_ce,
          reload          => reqs.coef_reload,
          reload_strms    => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
          reload_depth    => struct.param.base_coef_space,
          -- gui trans_off
          output_index    => (
                            p_P_OUT       => struct.param.num_macs+1,
                            p_PC_OUT      => struct.param.num_macs+1,
                            p_D_OUT       => struct.param.num_macs,
                            p_D_SYM_OUT   => struct.param.num_macs,
                            p_C_OUT       => struct.param.num_macs,
                            p_WE_OUT      => struct.param.num_macs,
                            p_WE_SYM_OUT  => struct.param.num_macs,
                            p_ADDSUB_OUT  => struct.param.num_macs+1,
                            p_ADDSUP_OUT  => struct.param.num_macs+1,
                            p_WE_SYM_OUT_2    => struct.param.num_macs ),
          output_src      => (
                            p_P_OUT       => 0,
                            p_PC_OUT       => 0,
                            p_D_OUT       => 0,
                            p_D_SYM_OUT   => 0,
                            p_C_OUT       => 0,
                            p_WE_OUT      => 0,
                            p_WE_SYM_OUT  => 0,
                            p_ADDSUB_OUT  => 0,
                            p_ADDSUP_OUT  => 0,
                            p_WE_SYM_OUT_2    => 0 ),
          -- gui trans_on
          num_split_col       => select_integer(1,num_col,reqs.col_mode=1),
          inter_split_col_dly => reqs.col_pipe_len,
          split_col_len             => reqs.col_config,--( 0 => select_integer(reqs.col_wrap_len,reqs.col_1st_len,reqs.col_mode=1),
                                         -- others=>reqs.col_wrap_len),
          dynamic_opcode  => select_integer(0,1,struct.param.num_macs=1),
          sym_para_struct => reqs.has_nd,
          para_casc_we_src=> select_integer(0,1,reqs.has_nd=1 or (reqs.filter_type=c_channelizer_transmitter and struct.param.no_data_mem=1)),
          resource_opt    => reqs.resource_opt,
          datapath_mem_type => reqs.datapath_mem_type,
          odd_symmetry    => struct.param.odd_symmetry,
          pat_det_tap_num => select_integer(
                               0,
                               select_integer(
                                 select_integer(0,1,struct.param.single_mac=1),
                                 struct.param.num_macs,
                                 struct.param.full_parallel=1
                               ),
                               ((reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and
                               not struct.accum_req and
                               not struct.has_rounder)
                             ),
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          dynamic_calc_func_used => funcs_emb_calc(
                                      select_func_list(
                                        select_func_list(
                                          (0=>A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          (0=>C_add_A_mult_B,1=>P_add_A_mult_B,2=>NOP),
                                          struct.round_first_cycle),
                                        (0=>A_mult_B,1=>P_add_A_mult_B,2=>P_add_C,3=>NOP),
                                        struct.round_spare_cycle) ),
          ----pin_width       => reqs.accum_width,
          split_adder_chain => reqs.resource_opt=c_speed,
          p_has_redundant => false,
          num_independant_col => struct.param.num_paths,
          indp_col_param      => ( data_src   => struct.param.path_reqs.data_src,
                                   data_width => struct.param.path_reqs.data_width,
                                   data_sign  => struct.param.path_reqs.data_sign,
                                   coef_src   => struct.param.path_reqs.coef_src,
                                   coef_width => struct.param.path_reqs.coef_width,
                                   coef_sign  => struct.param.path_reqs.coef_sign,
                                   pin_width  => struct.param.path_reqs.accum_width,
                                   cntrl_src  => (others=>0) ),
          opt_mac           => mif_status.opt_mac,
          pcout_used        => (struct.accum_req and not(reqs.family.has_fabric_dsp48) ) or
                               (struct.has_rounder and struct.use_rounder_pcin),
          next_c_used       => (struct.round_spare_cycle and not(reqs.family.has_fabric_dsp48)) or
                               (struct.round_first_cycle and not(reqs.family.treat_as_s3adsp))
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then
        struct.filt_arm.pattern:=reqs.ext_pattern;
        struct.filt_arm.mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.filt_arm_lat:=dtls_filt_arm_add_casc(struct.filt_arm);

        struct.first_tap_extra_dly:=struct.first_tap_extra_dly+struct.filt_arm_lat.data_addr_extra_delay;
        struct.data_dly_modifier:=struct.data_dly_modifier+struct.filt_arm_lat.data_addr_extra_delay;


    -- gui trans_off
    struct.pcin_width:=(others=>0);
    -- gui trans_on
    --Accumulator settings---------------------------------------
    for i in 0 to reqs.num_paths-1 loop
      struct.accum(i):=(
          family         => reqs.family,
          implementation => implementation,
          pre_add        => 0,
          pre_add_func   => c_preadd_add,
          pre_add_ipreg  => 0,
          pre_add_midreg => 0,
          a_delay        => 1,
          b_delay        => 1,
          p_delay        => 2*struct.filt_arm_lat.config(i).tap_n.p_delay,--this delay has been calced for the output of the filter arm, reuse
          a_src          => 0,--fabric
          a_sign         => struct.param.path_reqs.data_sign(i),
          b_sign         => struct.param.path_reqs.coef_sign(i),
          d_sign         => struct.param.path_reqs.data_sign(i),
          a_width        => 1,--only used for preadder calc
          b_width        => 1,
          reg_opcode     => 1,
          enable_pat_det => (reqs.round_mode=4 or reqs.round_mode=5 or reqs.has_ext_pat_det) and not struct.has_rounder,
          -- gui trans_off
          pattern        => gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          mask           => gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
          -- gui trans_on
          post_add_width => struct.param.path_reqs.accum_width(i),
          calc_func_used => funcs_emb_calc(
                              select_func_list(
                                select_func_list(
                                  (0=>PCIN,1=>PCIN_add_P,2=>NOP),
                                  select_func_list(
                                    (0=>PCIN_add_C,1=>PCIN_add_P,2=>NOP),
                                    (0=>PCIN_add_A_concat_B,1=>PCIN_add_P,2=>NOP),
                                    reqs.family.treat_as_s3adsp),
                                  struct.round_first_cycle),
                                (0=>PCIN,1=>PCIN_add_P,2=>P_add_C,3=>NOP),
                                struct.round_spare_cycle)  ),
          split_post_adder => reqs.resource_opt=c_speed,
          has_redundant => p_none
          );

      -- gui trans_off
      if reqs.has_ext_pat_det then--and i=0 then
        --struct.accum(i).enable_pat_det:=true;
        struct.accum(i).pattern:=reqs.ext_pattern;
        struct.accum(i).mask:=reqs.ext_mask;
      end if;
      -- gui trans_on

      struct.accum_lat(i):=dtls_emb_calc(struct.accum(i));

      -- gui trans_off
      struct.pcin_width(i) := struct.param.path_reqs.accum_width(i)+struct.accum_lat(i).extra_carry_bits;

      -- report "struct.pcin_width: "&int_to_str(struct.pcin_width(i));
      -- gui trans_on

    end loop;
    
    --The latancy function for the accum bloack does not add this value into the returned latency value. When the core is built with multiple
    --paths this value is used to balance the paths when the split adders for each path have different latencys
    struct.accum_lat(0).pout_latency:=struct.accum_lat(0).pout_latency+(select_integer(1,2,struct.accum_req)*struct.filt_arm_lat.config(0).tap_n.p_delay);


    --General buffer settings
    struct.buffer_depth:=2*reqs.num_channels;
    
    struct.buffer_config:=(
      family              => reqs.family,
      implementation      => implementation,
      mem_type            =>  select_integer(
                                select_integer(
                                  c_dram,--dram
                                  c_bram,--bram
                                  (struct.buffer_depth>dram_mem_depth_thres and reqs.opbuff_mem_type/=c_mem_forced_dist) or
                                   reqs.opbuff_mem_type=c_mem_forced_bram ),
                                select_integer(
                                  c_dram,--dram
                                  c_bram,--bram
                                  (struct.buffer_depth>dram_mem_depth_thres and reqs.ipbuff_mem_type/=c_mem_forced_dist) or
                                   reqs.ipbuff_mem_type=c_mem_forced_bram ),
                                reqs.filter_type=c_channelizer_transmitter),
      write_mode          => 0,--read first
      has_ce              => reqs.has_ce,
      use_mif             => 0,
      resource_opt        => c_area,
      is_rom              => false );

    
    --Output buffer settings---------------------------------

    struct.has_output_buffer:=false;
    if reqs.fft_compatible_op=1 and reqs.filter_type/=c_channelizer_transmitter then
      struct.has_output_buffer:=true;
    end if;
    
    struct.has_output_delay:=false;
    -- if reqs.fft_compatible_op=1 and struct.param.base_count=1 then
--       struct.has_output_delay:=true;
--     end if;

    struct.output_buffer_in_addr:=(
      family => reqs.family,
      implementation => implementation,
      addr_width => get_max(1,log2roundup(struct.buffer_depth)),
      page_size => reqs.num_channels,
      num_enables => 1 );
    
    struct.extra_opb_reg:=0;
    if struct.has_output_buffer and reqs.resource_opt=c_speed and struct.buffer_config.mem_type=c_dram then
        struct.extra_opb_reg:=1;
    end if;

    if struct.has_output_buffer then
      struct.output_buffer_lat:=lat_ram(struct.buffer_config,2);
    else
      struct.output_buffer_lat:=0;
    end if;

    --Input buffer settings---------------------------------
    struct.has_input_buffer:=false;
    if reqs.filter_type=c_channelizer_transmitter then
      struct.has_input_buffer:=true;
    end if;

    struct.input_buffer_in_addr:=(
      family => reqs.family,
      implementation => implementation,
      addr_width => get_max(1,log2roundup(struct.buffer_depth)),
      page_size => reqs.num_channels,
      num_enables => 2 );
    
    struct.input_buffer_out_addr:=struct.output_buffer_in_addr;
    
    if struct.has_input_buffer then
      struct.input_buffer_lat:=lat_ram(struct.buffer_config,2)+1;
      --struct.data_dly_modifier:=struct.data_dly_modifier+struct.input_buffer_lat;
    else
      struct.input_buffer_lat:=0;
    end if;

    --Address generator block settings---------------------------
    struct.base_chan_phase_param:=(
        cnt1_max_val    => select_integer(
                              struct.param.base_count,
                              struct.param.clk_per_chan,
                              reqs.filter_type=c_channelizer_transmitter and struct.shorter_px_time),
        cnt2_max_val    => reqs.num_channels,
        cnt3_max_val    => 1,
        cnt2_max_qual   => select_integer(1,0,reqs.filter_type=c_channelizer_transmitter and struct.shorter_px_time),
        family          => reqs.family,
        implementation  => implementation );

    struct.data_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        mem_type        => struct.param.data_mem_type,
        base_cnt        => struct.param.base_count,
        block_cnt       => reqs.num_channels,
        symmetric       => struct.param.symmetry,
        addr_width      => get_max(1,log2roundup(struct.param.data_mem_depth)),
        sym_addr_width  => get_max(1,log2roundup(struct.param.datasym_mem_depth+struct.param.datasym_mem_offset)),
        combined        => struct.param.data_combined,
        addr_packed     => struct.param.data_packed,
        srl16_sequence  => 0,--uses standard address sequence
        en_dly          => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                               struct.shorter_px_time or
                                               (reqs.filter_type=c_channelizer_transmitter and reqs.has_nd=1)),
        block_end_dly   => 0,  --delay of one due to the generation of addr_en
        last_block_dly  => 0,
        write_phase_dly => 0,
        sub_block_end_dly => 0,
        use_sym_cntrl   => 0,
        resource_opt => reqs.resource_opt,
        adv_sym         => 0,
        has_ce          => reqs.has_ce,
        alt_rolling     => false  );

    struct.data_addr_lat:=lat_data_address(struct.data_addr_param);

    struct.data_addr_lat:=get_max(0,struct.data_addr_lat-1);
    --sub 1 as only interested in the first location of the count,
    --this occurs with 0 latency when latency is 1

    struct.coef_addr_param:=(
        family          => reqs.family,
        implementation  => implementation,
        base_cnt        => struct.param.base_count*reqs.num_channels,
        block_cnt       => 1,
        addr_packed     => struct.param.coef_packed,
        addr_width      => get_max(1,log2roundup( struct.param.coef_mem_depth
                                                  +struct.param.coef_mem_offset )),
        num_filters     => reqs.num_filts,--*select_integer(1,2,struct.param.coef_reload=1),
        multi_page_reload => struct.param.coef_reload,
        offset          => struct.param.coef_mem_offset,
        has_ce          => reqs.has_ce,
        use_count_src   => 0,
        en_dly            => select_integer(0,1,(reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                                struct.shorter_px_time or
                                                (reqs.filter_type=c_channelizer_transmitter and reqs.has_nd=1)),
        base_max_dly      => 0,
        skip_base_max_dly => 0,
        count_max_dly     => 0,
        filt_sel_dly      => 0,
        resource_opt => reqs.resource_opt);

    struct.coef_addr_lat:=lat_coef_address(struct.coef_addr_param);

    struct.coef_addr_lat:=get_max(0,struct.coef_addr_lat-1);

    struct.reload_cntrl_param:=(
      family          => reqs.family,
      implementation  => implementation,
      reload_base_cnt => struct.param.base_count*reqs.num_channels,
      coef_addr_packed=> struct.param.coef_packed,
      num_filts       => reqs.num_filts,
      coef_mem_depth  => struct.param.coef_mem_depth,
      num_macs        => struct.param.num_macs,

      has_ce          => reqs.has_ce,
      coef_width      => reqs.coef_width,
      filt_sel_width  => reqs.filt_sel_width,
      filt_sel_width_out => select_integer(1,reqs.filt_sel_width+1, reqs.num_filts>1),
      reload_width    => get_max(1,log2roundup( struct.param.coef_mem_depth)),
      resource_opt => reqs.resource_opt,
      has_hb       => 0,
      latch_filt_sel => 1,
      num_reload_strms => select_integer(1,2,struct.param.coef_mem_type=c_bram and struct.memory_path_lat.coef>1),
      complete_after_update => 0,
      extra_dly => 0 );

    struct.reload_cntrl_param_lat:=lat_coef_reload_cntrl(struct.reload_cntrl_param);

    struct.addr_cntrl_lat:=select_integer(
                                1,
                                2,
                                (reqs.has_nd=1 and struct.param.no_data_mem=0) or
                                struct.shorter_px_time or
                                (reqs.filter_type=c_channelizer_transmitter and reqs.has_nd=1));

    if reqs.coef_reload=1 then
      if struct.reload_cntrl_param_lat.filt_sel_lat-1 < struct.addr_cntrl_lat then
        filter_sel_dly:=struct.addr_cntrl_lat-(struct.reload_cntrl_param_lat.filt_sel_lat-1);
        addr_dly:=0;
      else
        filter_sel_dly:=0;
        addr_dly:=(struct.reload_cntrl_param_lat.filt_sel_lat-1)-struct.addr_cntrl_lat;
        struct.addr_cntrl_lat:=struct.addr_cntrl_lat+addr_dly;
      end if;
    else
      addr_dly:=0;
      filter_sel_dly:=struct.addr_cntrl_lat;
    end if;

    --Balance delays
    struct.data_addr_param.en_dly         :=struct.data_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.data_addr_param.block_end_dly  :=struct.data_addr_param.block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.data_addr_param.last_block_dly :=struct.data_addr_param.last_block_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.data_addr_param.write_phase_dly :=struct.data_addr_param.write_phase_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.data_addr_param.sub_block_end_dly :=struct.data_addr_param.sub_block_end_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat>struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.data_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);

    struct.coef_addr_param.en_dly         :=struct.coef_addr_param.en_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.coef_addr_param.base_max_dly  :=struct.coef_addr_param.base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.coef_addr_param.skip_base_max_dly :=struct.coef_addr_param.skip_base_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.coef_addr_param.count_max_dly :=struct.coef_addr_param.count_max_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +addr_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);
    struct.coef_addr_param.filt_sel_dly :=struct.coef_addr_param.filt_sel_dly+
                                            select_integer(0,abs(struct.data_addr_lat-struct.coef_addr_lat),struct.coef_addr_lat<struct.data_addr_lat)
                                            +filter_sel_dly
                                            +struct.filt_arm_lat.coef_addr_extra_delay
                                            +select_integer(0,struct.input_buffer_lat-1,struct.has_input_buffer);

    struct.reload_cntrl_param.extra_dly := struct.coef_addr_param.filt_sel_dly;

    if reqs.filter_type=c_channelizer_transmitter then
     struct.rfd_param:=(
          family          => reqs.family,
          implementation  => implementation,
          cnt             => 1,
          cnt_long        => struct.param.clk_per_samp-reqs.num_channels,
          has_nd          => reqs.has_nd );
    else
      struct.rfd_param:=(
          family          => reqs.family,
          implementation  => implementation,
          cnt             => struct.param.clk_per_chan,
          cnt_long        => struct.param.clk_per_chan,
          has_nd          => reqs.has_nd );
    end if;

    struct.vector_cnt_len:=struct.param.num_taps_calced;

    --Latency Calculation
    struct.buffer_type:=0;
    if struct.has_output_buffer or struct.has_input_buffer then
      struct.buffer_page_size:=reqs.num_channels;
    else
      struct.buffer_page_size:=0;
    end if;
    struct.latency:=struct.input_buffer_lat
--                     +select_integer(0,1,struct.has_input_buffer)
                    +struct.param.base_count
                    +struct.addr_cntrl_lat-- -1
                    +get_max(struct.data_addr_lat,struct.coef_addr_lat)
                    --+struct.first_tap_extra_dly
                    +struct.filt_arm_lat.cascaded
                    +struct.filt_arm_lat.tap
                    +struct.accum_lat(0).pout_latency
                    --always need to add even if no accum as will have last tap in cascade or it is a SMAC
                    +select_integer(0,1+struct.accum_lat(0).pcin_latency,struct.accum_req)
                    +select_integer(0,1,struct.round_spare_cycle)
                    +struct.rounder_delay
                    +select_integer(0,struct.output_buffer_lat+1+
                                      --struct.output_rate+
                                      struct.extra_opb_reg,
                                    struct.has_output_buffer)
                    +struct.reg_output
                    +select_integer(0,reqs.ext_src_delay,reqs.has_ext_output_src);

    --Resource estimation
    -- gui insert_on
    -- struct.num_bram:=0;
    -- struct.num_dsp:=0;
    -- if reqs.num_paths=1 then
    --   struct.num_dsp:=struct.param.num_macs-sum_vals(struct.filt_arm_lat.opt_dsp);
    --   macs_used:=struct.param.num_macs-sum_vals(mif_status.opt_mac);
    --   if struct.accum_req and
    --     not reqs.family.has_fabric_dsp48 then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   if struct.has_rounder and
    --     not reqs.family.has_fabric_dsp48 then
    --     struct.num_dsp:=struct.num_dsp+1;
    --   end if;
    --   struct.num_dsp_per_path:=struct.num_dsp;
    --   if  struct.param.data_combined=0 and
    --       struct.param.data_coef_combined=0 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.data_mem_depth,reqs.family));
    --   end if;
    -- 
    --   if  struct.param.symmetry=1 and
    --       struct.param.no_data_mem=0 and
    --       struct.param.data_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.data_width,struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --   end if;
    -- 
    --   if struct.param.coef_mem_type=c_bram then
    --     struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.coef_width,struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --   end if;
    -- else
    --   for path in 0 to reqs.num_paths-1 loop
    --     struct.num_dsp:=struct.num_dsp+struct.param.num_macs;
    --     macs_used:=struct.param.num_macs;
    --     for mac in tcl_to_int((struct.param.num_macs*struct.filt_arm.indp_col_param.coef_src(path))+1)to tcl_to_int(struct.param.num_macs*(struct.filt_arm.indp_col_param.coef_src(path)+1)) loop
    --       if struct.filt_arm_lat.opt_dsp(mac)=1 then
    --         struct.num_dsp:=struct.num_dsp-1;
    --       end if;
    --       if mif_status.opt_mac(mac)=1 then
    --         macs_used:=macs_used-1;
    --       end if;
    --     end loop;
    --     if struct.accum_req and
    --        not reqs.family.has_fabric_dsp48 then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if struct.has_rounder and
    --        not reqs.family.has_fabric_dsp48 then
    --       struct.num_dsp:=struct.num_dsp+1;
    --     end if;
    --     if path = 0 then
    --       struct.num_dsp_per_path:=struct.num_dsp;
    --     end if;
    --     if reqs.path_reqs.data_src(path)=path then
    --       if  struct.param.no_data_mem=0 and
    --           struct.param.data_mem_type=c_bram then
    --         if struct.param.data_combined=1 then
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth+struct.param.datasym_mem_offset,reqs.family));
    --           else
    --             struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.data_width(path),2*integer(2**log2roundup(struct.param.data_mem_depth)),reqs.family));
    --           end if;
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.data_mem_depth,reqs.family));
    --           if struct.param.symmetry=1 then
    --             struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.data_width(path),struct.param.datasym_mem_depth,reqs.family));
    --           end if;
    --         end if;
    --       end if;
    --     end if;
    -- 
    --     if reqs.path_reqs.coef_src(path)=path then
    --       if struct.param.coef_mem_type=c_bram then
    --         if struct.param.coef_combined=1 then
    --           struct.num_bram:=struct.num_bram+(tcl_to_int((macs_used+1)/2)*calc_num_bram(reqs.path_reqs.coef_width(path),2*integer(2**log2roundup(struct.param.coef_mem_depth)),reqs.family));
    --         else
    --           struct.num_bram:=struct.num_bram+(macs_used*calc_num_bram(reqs.path_reqs.coef_width(path),struct.param.coef_mem_depth+struct.param.coef_mem_offset,reqs.family));
    --         end if;
    --       end if;
    --     end if;
    --   end loop;
    -- end if;
    -- 
    -- if struct.has_output_buffer and struct.buffer_config.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.output_width,struct.buffer_depth,reqs.family);
    -- end if;
    -- 
    -- if struct.has_input_buffer and struct.buffer_config.mem_type=c_bram then
    --   struct.num_bram:=struct.num_bram+calc_num_bram(reqs.data_width,struct.buffer_depth,reqs.family);
    -- end if;
    -- gui insert_off

    return struct;

  end;

--------------------------------------------------------------------------------
--From:  ../../hdl/mac_elements/mac_fir.vhd

  function choose_structure(C_FAMILY            : string;
                            C_XDEVICEFAMILY     : string;
                            C_ELABORATION_DIR   : string;
                            C_COMPONENT_NAME    : string;
                            C_MEM_INIT_FILE     : string;
                            FILTER_TYPE         : integer;
                            INTERP_RATE         : integer;
                            DECIM_RATE          : integer;
                            RATE_CHANGE_TYPE    : integer;
                            ZERO_PACKING_FACTOR : integer;
                            NUM_CHANNELS        : integer;
                            CHAN_IN_ADV         : integer;
                            CHAN_SEL_WIDTH      : integer;
                            NUM_TAPS            : integer;
                            CLOCK_FREQ          : integer;
                            SAMPLE_FREQ         : integer;
                            FILTER_ARCH         : integer;
                            DATA_TYPE           : integer;
                            DATA_WIDTH          : integer;
                            COEF_TYPE           : integer;
                            COEF_WIDTH          : integer;
                            ROUND_MODE          : integer;
                            ACCUM_WIDTH         : integer;
                            OUTPUT_WIDTH        : integer;
                            ALLOW_APPROX        : integer;
                            OUTPUT_REG          : integer;
                            SYMMETRY            : integer;
                            ODD_SYMMETRY        : integer;
                            NEG_SYMMETRY        : integer;
                            COEF_RELOAD         : integer;
                            NUM_FILTS           : integer;
                            FILTER_SEL_WIDTH    : integer;
                            C_HAS_SCLR          : integer;
                            C_HAS_CE            : integer;
                            C_HAS_ND            : integer;
                            C_HAS_CHAN0_IN      : integer;
                            C_HAS_DATA_VALID    : integer;
                            DATA_MEMTYPE        : integer;
                            COEF_MEMTYPE        : integer;
                            IPBUFF_MEMTYPE      : integer;
                            OPBUFF_MEMTYPE      : integer;
                            DATAPATH_MEMTYPE    : integer;
                            COL_MODE            : integer;
                            -- COL_1ST_LEN         : integer;
                            -- COL_WRAP_LEN        : integer;
                            COL_PIPE_LEN        : integer;
                            COL_CONFIG          : string;
                            C_LATENCY           : integer;
                            C_RESOURCE_OPT      : integer;
                            XIL_FFT_COMPATIBLE  : integer;
                            NUM_PATHS           : integer;
                            SCLR_DETERMINISTIC  : integer)
                            return t_configuration is
    variable mac_config: t_configuration;
    variable  filter_type_ol,
              round_mode_ol
              : integer;
    --VTFC Compatibility
    variable data_src_path,
             data_width_path,
             data_sign_path,
             coef_src_path,
             coef_width_path,
             coef_sign_path,
             accum_width_path,
             output_width_path,
             round_const_lower_path,
             round_const_upper_path : t_int_array(max_paths-1 downto 0):=(others=>0);
  begin
    -- if  equalIgnoreCase(C_FAMILY,"virtex6") or
        -- derived(C_FAMILY,"virtex5") or
        -- derived(C_FAMILY,"virtex4") or
        -- derived(C_FAMILY,"virtex2") or
        -- equalIgnoreCase(C_FAMILY,"spartan6") or
        -- derived(C_FAMILY,"spartan3") then

      case FILTER_TYPE is
        when c_single_rate =>
          mac_config.struct:=single_rate;
          filter_type_ol:=FILTER_TYPE;

        when c_polyphase_decimating =>
          mac_config.struct:=polyphase_decimation;
          filter_type_ol:=FILTER_TYPE;

        when c_polyphase_interpolating =>
          if SYMMETRY=1 then
            mac_config.struct:=polyphase_interpolation_symmetry;
            filter_type_ol:=c_interpolating_symmetry;
          else
            mac_config.struct:=polyphase_interpolation;
            filter_type_ol:=FILTER_TYPE;
          end if;

        when c_hilbert_transform =>
          mac_config.struct:=hilbert;
          filter_type_ol:=FILTER_TYPE;

        when c_interpolated_transform =>
          mac_config.struct:=interpolated;
          filter_type_ol:=FILTER_TYPE;

        when c_halfband_transform =>
          mac_config.struct:=halfband;
          filter_type_ol:=FILTER_TYPE;

        when c_decimating_half_band =>
          mac_config.struct:=halfband_decimation;
          filter_type_ol:=FILTER_TYPE;

        when c_interpolating_half_band =>
          mac_config.struct:=halfband_interpolation;
          filter_type_ol:=FILTER_TYPE;

        when c_polyphase_pq =>
          if INTERP_RATE>DECIM_RATE then
            mac_config.struct:=polyphase_pq_interpolation;            
            filter_type_ol:=FILTER_TYPE;
          else
            if ( (CLOCK_FREQ/SAMPLE_FREQ)/NUM_CHANNELS < INTERP_RATE) or
               ( (CLOCK_FREQ/SAMPLE_FREQ)/NUM_CHANNELS mod INTERP_RATE /= 0) then
              report "NOTE: FIR Compiler v5.0: Using alternative PQ decimation structure" severity note;
              mac_config.struct:=polyphase_pq_decimation_alt;            
              filter_type_ol:=c_polyphase_pq_dec_alt;
            else
              mac_config.struct:=polyphase_pq_decimation;            
              filter_type_ol:=FILTER_TYPE;
            end if;
          end if;

        when c_channelizer_receiver | c_channelizer_transmitter =>
          mac_config.struct:=channelizer;
          filter_type_ol:=FILTER_TYPE;

        when c_transpose_single_rate | c_transpose_decimating | c_transpose_interpolating =>
          mac_config.struct:=transpose;
          filter_type_ol:=FILTER_TYPE;

        when others =>
          report "FAILURE: FIR Compiler v5.0: Invalid filter type." severity failure;
      end case;

      if DATA_TYPE=c_unsigned and COEF_TYPE=c_unsigned then
        if ROUND_MODE=c_symmetric_zero  then
          round_mode_ol:=c_non_symmetric_down;
        elsif ROUND_MODE=c_symmetric_inf then
          round_mode_ol:=c_non_symmetric_up;
        else
          round_mode_ol:=ROUND_MODE;
        end if;
      else
        round_mode_ol:=ROUND_MODE;
      end if;


      --Assign to path reqs seperately for VTFC compatibility
      -- gui insert_on
      -- for path_assign in 0 to max_paths-1 loop
      --   data_src_path(path_assign):=0;
      --   data_width_path(path_assign):=0;
      --   data_sign_path(path_assign):=0;
      --   coef_src_path(path_assign):=0;
      --   coef_width_path(path_assign):=0;
      --   coef_sign_path(path_assign):=0;
      --   accum_width_path(path_assign):=0;
      --   output_width_path(path_assign):=0;
      --   round_const_lower_path(path_assign):=0;
      --   round_const_upper_path(path_assign):=0;
      -- end loop;
      -- gui insert_off

      --Assign to first path
      data_width_path(0):=DATA_WIDTH;
      data_sign_path(0):=DATA_TYPE;
      coef_width_path(0):=COEF_WIDTH;
      coef_sign_path(0):=COEF_TYPE;
      accum_width_path(0):=ACCUM_WIDTH;
      output_width_path(0):=OUTPUT_WIDTH;

      mac_config.reqs := (
        family              => family_val(C_XDEVICEFAMILY),--select_string(C_FAMILY,
                                                        -- C_XDEVICEFAMILY,
                                                        -- derived(C_FAMILY,"spartan3"))),
        filter_type         => filter_type_ol,
        deci_rate           => DECIM_RATE,
        inter_rate          => INTERP_RATE,
        rate_type           => RATE_CHANGE_TYPE,
        num_taps            => NUM_TAPS,
        clk_per_samp        => select_integer(
                                  CLOCK_FREQ/SAMPLE_FREQ,
                                  --CLOCK_FREQ/get_max(integer((real(SAMPLE_FREQ)*real(INTERP_RATE))/real(DECIM_RATE)),1),--put catch in to stop any issues if expression is evaluated but not used
                                  --switched to using real as was overflowing integer at times
                                  CLOCK_FREQ/get_max(
                                                  ((SAMPLE_FREQ/DECIM_RATE)*INTERP_RATE)+
                                                  (((SAMPLE_FREQ rem DECIM_RATE)*INTERP_RATE)/DECIM_RATE),
                                                  1),
                                  --using real's seemed to result in loss of precision so trying to split the sum up to avoid overflow but use integer
                                  mac_config.struct=polyphase_pq_decimation_alt),
        num_channels        => NUM_CHANNELS,
        chan_in_adv         => CHAN_IN_ADV,
        num_filts           => NUM_FILTS,
        symmetry            => SYMMETRY,
        neg_symmetry        => NEG_SYMMETRY,
        zero_packing_factor => ZERO_PACKING_FACTOR,
        coef_reload         => COEF_RELOAD,
        data_width          => DATA_WIDTH*NUM_PATHS,
        coef_width          => COEF_WIDTH,
        filt_sel_width      => FILTER_SEL_WIDTH,
        chan_width          => CHAN_SEL_WIDTH,
        round_mode          => round_mode_ol,
        accum_width         => ACCUM_WIDTH*NUM_PATHS,
        output_width        => OUTPUT_WIDTH*NUM_PATHS,
        allow_approx        => ALLOW_APPROX,
        data_mem_type       => DATA_MEMTYPE,
        coef_mem_type       => COEF_MEMTYPE,
        ipbuff_mem_type     => IPBUFF_MEMTYPE,
        opbuff_mem_type     => OPBUFF_MEMTYPE,
        datapath_mem_type   => DATAPATH_MEMTYPE,
        data_sign           => DATA_TYPE,
        coef_sign           => COEF_TYPE,
        reg_output          => OUTPUT_REG,
        has_nd              => C_HAS_ND,
        has_ce              => C_HAS_CE,
        has_sclr            => C_HAS_SCLR,
        has_chan0_in        => C_HAS_CHAN0_IN,
        has_data_valid      => C_HAS_DATA_VALID,
        col_mode            => COL_MODE,
        -- col_1st_len         => COL_1ST_LEN,
        -- col_wrap_len        => COL_WRAP_LEN,
        col_pipe_len        => COL_PIPE_LEN,
        col_config          => str_to_col_len(COL_CONFIG),
        resource_opt        => C_RESOURCE_OPT,
        num_paths           => NUM_PATHS,--1,
        path_reqs           => ( data_src    =>data_src_path,
                                 data_width  =>data_width_path,
                                 data_sign   =>data_sign_path,
                                 coef_src    =>coef_src_path,
                                 coef_width  =>coef_width_path,
                                 coef_sign   =>coef_sign_path,
                                 accum_width =>accum_width_path,
                                 output_width=>output_width_path,
                                 round_const_lower=>round_const_lower_path,
                                 round_const_upper=>round_const_upper_path
                                ),
        has_ext_output_src  => false,
        ext_src_delay    => 0,
        has_ext_pat_det  => false,
        -- gui trans_off
        ext_pattern      => (others=>'0'),
        ext_mask         => (others=>'1'),
        -- gui trans_on
        fft_compatible_op=>  XIL_FFT_COMPATIBLE,
        sclr_determ      =>  SCLR_DETERMINISTIC
      );

      if NUM_PATHS>1 then
          for i in 0 to NUM_PATHS-1 loop
            mac_config.reqs.path_reqs.data_src(i):=i;
            mac_config.reqs.path_reqs.data_width(i):=DATA_WIDTH;
            mac_config.reqs.path_reqs.data_sign(i):=DATA_TYPE;
            mac_config.reqs.path_reqs.accum_width(i):=ACCUM_WIDTH;
            mac_config.reqs.path_reqs.output_width(i):=OUTPUT_WIDTH;
          end loop;
      end if;

      if ( (mac_config.reqs.family.treat_as_s3adsp or
           mac_config.reqs.family.emb_calc_prim=p_dsp48) and
           (DATA_WIDTH + DATA_TYPE + SYMMETRY >18 or
            mac_config.reqs.coef_width+select_integer(COEF_TYPE,0,filter_type_ol=c_interpolating_symmetry)>18 ) )
         or
         ( mac_config.reqs.family.supports_dsp48e and
           ( get_max(DATA_WIDTH+DATA_TYPE + SYMMETRY,mac_config.reqs.coef_width+select_integer(COEF_TYPE,0,filter_type_ol=c_interpolating_symmetry))>25 or
             (DATA_WIDTH+DATA_TYPE + SYMMETRY>18 and mac_config.reqs.coef_width+select_integer(COEF_TYPE,0,filter_type_ol=c_interpolating_symmetry)>18) ))
         or
         ( ACCUM_WIDTH > 48 ) then
        mac_config.struct:=extended_mult;
      end if;


    -- else
      -- report "FAILURE: FIR Compiler v5.0 : Unsupported family: "&C_FAMILY severity failure;
    -- end if;

    return mac_config;
  end;

--------------------------------------------------------------------------------
--From:  ./model_pkg.vhd

function bin_to_int( binstring: string; width: integer; signed: boolean) return integer IS

variable str      : string (1 to width) := binstring;
variable ch       : character;
--constant length   : integer := binstring'length;
variable intval   : integer := 0;

begin
  -- initialize the return integer to zero
  intval := 0;
  -- loop through each character and convert to the equivalent hex bits
  for i in width downto 2 loop
    ch := str(i);
    --report "i = " & int_to_string(i) &", bit = " & ch;
    case ch is
      when '0'    => null;
      when '1'    => intval := intval + 2**(width-i);
      when others => assert false
                     report "ERROR: FIR Compiler v4.0: bin_to_int: Invalid binary value." severity error;
                     intval := 0;
    end case;
    --report "---> intval = " & int_to_string(intval);
  end loop;
  ch := str(1);
  if ch = '1' then
    if signed then
      intval := intval - 2**(width-1);
    else
      intval := intval + 2**(width-1);
    end if;
  end if;
  --report "i = 1, bit = " & ch;
  --report "---> intval = " & int_to_string(intval);
  return intval;

end bin_to_int;

function get_gcd(x,y : integer) return integer is

  variable int_x : integer := x;
  variable int_y : integer := y;
  variable int_t : integer;

begin

  while int_x > 0 loop
    if (int_x < int_y) then
      int_t := int_x;
      int_x := int_y;
      int_y := int_t;
    end if;
    int_x := int_x - int_y;
  end loop;

  return int_y;

end get_gcd;

function calc_coe_width ( c_family         : string;
                          c_xdevicefamily  : string;
                          filter_arch      : integer;
                          filter_type      : integer;
                          rate_change_type : integer;
                          interp_rate      : integer;
                          num_taps         : integer;
                          symmetry         : integer;
                          coef_type        : integer;
                          coef_width       : integer  )
                          return integer is


begin
  
  if (derived(c_family,"virtex4") or derived(c_family,"virtex5") or c_xdevicefamily="spartan3adsp") and
     filter_arch = 1 and
     (filter_type=c_interpolating_symmetry or filter_type=c_polyphase_interpolating) and
     rate_change_type=0 and     
     symmetry=1 then
     
    if coef_type = c_signed then
      report "Interpolating symmetric case with Signed coefficients, coef_width = " & int_to_string(coef_width-1);
      return coef_width-1;
    else
      report "Interpolating symmetric case with Unsigned coefficients, coef_width = " & int_to_string(coef_width-2);
      return coef_width-2;
    end if;
    
  else
    report "Normal case, coef_width = " & int_to_string(coef_width);
    return coef_width;
    
  end if;
    
end calc_coe_width;

function get_da_fir_latency (
            filtertype    : integer;
            bitsatatime   : integer;
            datawidth     : integer;
            datatype      : integer;
            numbertaps    : integer;
            moderate      : integer;
            symmetric     : boolean;
            registeredout : boolean ) return integer is

  variable  latency,
            processingclockcycles,
            index,
            maxSubFilterLatency,
            subFilterLatency,
            symmetricTap,
            subFilterIndex,
            numberSections,
            subFilterLoop,
            innerLoop,
            nextFilterIndex,
            pairIndex,
            thisLatency,
            maxLatency,
            effectiveNumberTaps,
            centerTapLatency,
            effectiveDataWidth,
            levelsOfSlices,
            clocksPerSlice,
            effectiveNumberBitsAtATime,
            compareLevel
            : integer;
  variable  subfiltertaplength,
            partnerTap,
            subFilterLatency_array,
            endTaps,
            adderTreeLatency
            : t_int_array( moderate-1 downto 0):=(others=>0);
  variable  PDAFilter,
            subFilterFound
            : boolean;
begin
  latency:=-1;
  processingclockcycles:=0;

  -- check for legal input values
  if ( bitsatatime > 0 and datawidth > 0 and numbertaps > 0 ) then

    if ( filtertype = c_da_polyphase_interpolating ) then
      -- loop through and determine the length of each sub-filter
      index:=moderate-1;
      for tap in 0 to numbertaps-1 loop
        subfiltertaplength(index):=subfiltertaplength(index)+1;
        index:=index-1;
        if index<0 then
          index:=moderate-1;
        end if;
      end loop;

      -- now loop through and determine the latency of each sub-filter and find the largest latency
      maxSubFilterLatency := 0;
      subFilterLatency := 0;

      for subfilterloop in 0 to moderate-1 loop
        -- get this sub-filters latency
        subFilterLatency:=get_da_fir_latency(
                            c_da_single_rate_fir,
                            bitsatatime,
                            datawidth,
                            datatype,
                            subfiltertaplength(subfilterloop),
                            0,
                            false,
                            false);
        if subFilterLatency>maxSubFilterLatency then
          maxSubFilterLatency:=subFilterLatency;
        end if;
      end loop;

      -- The largest latency is what is used to determine the overall latency through the filter. Note that
      -- the scaling accumulator is already added into the maxLatency number, so to get the "full" latency
      -- only need to add in the latency for the sub-filters adder tree.
      -- The final + 1 is to account for the extra input or output register delay.
      latency:= maxSubFilterLatency+1;

      -- if the output is registered then an additional clock cycle of latency is required
      if registeredout then
        latency:=latency+1;
      end if;

    elsif ( filtertype = c_da_polyphase_decimating ) then
      -- decimating filters lateny is a function of the sub-filters latencies and how the filters
      -- results are added together. The sub-filters that are symmetric are combined together first
      -- then all of the pairings are combined together. This creates situations where latencies through
      -- smaller filters (less latency) that have been combined because of symmetry now match the non-combined
      -- filters. To account for this the architecture of the overall filter must be matched and the the
      -- latencies accounted. This section matches the way the filters are combined and determines the
      -- overall latencies.

      -- set all of the partners to invalid -- insuring that the filters start out as non-symmetric
      for i in 0 to moderate-1 loop
        partnerTap(i):=-1;
      end loop;

      -- loop through and determine the length of each sub-filter
      index:=0;
      for tap in 0 to numbertaps-1 loop
        subFilterTapLength(index):=subFilterTapLength(index)+1;
        index:=index+1;
        if index>=moderate then
          index:=0;
        end if;
      end loop;
      
      -- determine the partner for each of the sub-filters --
      -- ONLY needed if filter is symmetric, else there are no partners
      symmetricTap:=0;
      if symmetric then
        -- Determine what the last tap is for each of the sub-filters, which is the center tap for the
        -- sub-filter. Because the filter is symmetric this sub-filter will either be symmetric with itself or
        -- in combination with another sub-filter. When the filter is symmetric with another filter the data runs
        -- through the first portion of each sub-filter and then run through the back portion of the partner.
        -- NOTE that we loop through because it is difficult to create a simple algorithm that finds each of the
        -- sub-filters last taps -- looping through is simple and sure-fire.
        subFilterIndex:=0;
        for tap in 0 to numbertaps-1 loop
          endTaps(subFilterIndex):=tap;
          subFilterIndex:=subFilterIndex+1;
          if subFilterIndex >= moderate then
            subFilterIndex:=0;
          end if;
        end loop;
        
        -- looping through for each of the sub-filters find its partners based on the end tap that each
        -- filter is processing
        for subfilter in 0 to moderate-1 loop
          -- Calculate the symmetric "partner" for this filters. The overall filter is symmetric which
          -- means that the first and the last tap are the same coefficient, second and second to last, etc. To
          -- find the symmetric partner use the distance from the 0th tap from the 1st and last tap moving to the
          -- center. For example if we are doing the 2nd tap with a 11 tap filter the distance from the 0th tap is
          -- 2 and so the symmetric partner is found by moving in 2 from the last tap to towards the center, or tap 9.
          symmetricTap := (numberTaps - 1 - subFilter);
          
          --with the symmetric partner tap calculated find it in the "END TAPS" table
          for i in 0 to moderate-1 loop
            if symmetricTap = endTaps(i) then
              partnerTap(subFilter):= i;
             end if;
          end loop;
        end loop;
      end if;
      
      -- determine the latency for each of the sub-filters
      for subFilterLoop in 0 to moderate-1 loop
        subFilterLatency_array(subFilterLoop):=get_da_fir_latency(
                                            c_da_single_rate_fir,
                                            bitsatatime,
                                            datawidth,
                                            datatype,
                                            subfiltertaplength(subfilterloop),
                                            0,
                                            symmetric,
                                            false);
        if bitsatatime < datawidth then
          subFilterLatency_array(subFilterLoop):=subFilterLatency_array(subFilterLoop)-1;
        end if;
--         report "subFilterLatency_array(subFilterLoop):"&int_to_str(subFilterLatency_array(subFilterLoop));
      end loop;
      
      -------------------------------------------------------------------------
      --    Determine which sub-filters need to be combined together
      -------------------------------------------------------------------------
      numberSections:=0;
      -- symmetric filters have "partners" -- first combine the filters with partners
      if symmetric then
        for subFilterLoop in 0 to moderate-1 loop
          if ( (partnerTap(subFilterLoop) /= subFilterLoop) and (partnerTap(subFilterLoop) > subFilterLoop) ) then
            adderTreeLatency(numberSections):= subFilterLatency_array(subFilterLoop) + 1;
            numberSections:=numberSections+1;
          end if;
        end loop;
      end if;
      
      -- now combine the filters without "partners"
      subFilterLoop     := 0;   -- start at the first filter
      innerLoop       := 0;       -- this is the index for the second filter
      nextFilterIndex := 0;
      pairIndex       := 0;
      subFilterFound  := false;
      while ( subFilterLoop < moderate ) loop
        subFilterFound :=false;
        thisLatency:=0;
        if symmetric then
          -- check if this sub-filter is symmetric with itself
          if partnerTap( subFilterLoop ) = subFilterLoop then
            -- symmetric with itself
            -- find another "symmetric with itself" sub-filter
            innerloop:= subFilterloop + 1;

            pairindex:= 0;
            -- search through the table of partners to find this filters partner
            while ( (innerLoop < modeRate) and not subFilterFound ) loop

              if partnerTap(innerLoop) = innerLoop then
                subfilterfound:=true;
                pairindex:=innerloop;
              else
                innerloop:=innerloop+1;
              end if;
            end loop;

            -- determine the largest latency and record it
            thisLatency:=subFilterLatency_array(subFilterLoop);
            if subFilterFound and (subFilterLatency_array(pairIndex) > thisLatency) then
              thisLatency:= subFilterLatency_array(pairIndex);
            end if;

            adderTreeLatency(numberSections):=thisLatency;
            if subFilterFound then
              adderTreeLatency(numberSections):=adderTreeLatency(numberSections)+1;
            end if;
            numberSections:=numberSections+1;
            
            --start the search at the "next" filter in the table
            subFilterLoop := innerLoop + 1;
          else
            subFilterLoop:=subFilterLoop+1;
          end if;
        else -- not symmetric filters, just combine together two of the sub-filters
             -- combine the filters
          if subFilterLoop < (modeRate - 1) then
            pairIndex:=subFilterLoop+1;
            subFilterFound:=true;
          else
            pairIndex:=0;
            subFilterFound:=false;
          end if;

          -- determine the largest latency and record it
          thisLatency:= subFilterLatency_array(subFilterLoop);
          if  subFilterFound and (subFilterLatency_array(pairIndex) > thisLatency) then
            thisLatency:=subFilterLatency_array(pairIndex);
          end if;
          
          adderTreeLatency(numberSections):= thisLatency;
          if subFilterFound then
            adderTreeLatency(numberSections):=adderTreeLatency(numberSections)+1;
          end if;
          numberSections:=numberSections+1;

          if subFilterFound then
            subFilterLoop:=subFilterLoop+2;
          else
            subFilterLoop:=modeRate;
          end if;

        end if;
      end loop;

      -- now that the "first" layers have been latency accounted for use the numberSections to determine the
      -- remaining number of clock cycles required for the adder tree and accumlator (if needed)
      -- first find the largest latency
      maxLatency:=0;
      for i in 0 to numberSections-1 loop
        if maxLatency< adderTreeLatency(i) then
          maxLatency:=adderTreeLatency(i);
        end if;
      end loop;

      -- calculate the overall delay -- maximum filter pairing latency + how many levelsof adders to combine pairings + input register
      latency := maxLatency + get_da_fir_AdderTreeLevel(numberSections) + 1;

      -- if this is NOT a parallel filter then a scaling accumulator is required, 1 extrac clock of latency
      if ( bitsAtATime < dataWidth ) then
        latency:=latency+1;
      end if;

      -- if the output is registered then an additional clock cycle of latency is required
      if ( registeredOut ) then
        latency:=latency+1;
      end if;

    elsif ( filtertype = c_da_interpolating_half_band ) then
      -- half-band INTERPOLATING Filter

      -- determine the latency through the "main" section of the filter which is a single-rate
      effectiveNumberTaps:=(numberTaps+1)/2;
      
      -- the overall latency is the time through the main filter PLUS the additional delay of the output section (1 clock)
      latency:=get_da_fir_latency(
                  c_da_single_rate_fir,
                  bitsatatime,
                  datawidth,
                  datatype,
                  effectiveNumberTaps,
                  0,
                  symmetric,
                  false)+1;
      
      -- if the output is registered then an additional clock cycle of latency is required
      if ( registeredOut ) then
        latency:=latency+1;
      end if;
    
    elsif ( filtertype = c_da_decimating_half_band ) then
      
      -- determine the latency through the "main" section of the filter which is a single-rate
      effectiveNumberTaps:=(numberTaps+1)/2;
      latency:=get_da_fir_latency(
                  c_da_single_rate_fir,
                  bitsatatime,
                  datawidth,
                  datatype,
                  effectiveNumberTaps,
                  0,
                  symmetric,
                  false)+2;
      
      -- SPECIAL case for PDA filters
      -- when the "main" filter is small in a PDA implementation then the center tap filter (single tap FIR)
      -- can have the same length delay BUT there is an extra clock delay due to the center taps data needing to
      -- delayed -- so the latency is actually increased by 1 clock cycle. The one exception to this rule is when
      -- the filters total length is 3 taps. In this case there is no delay necessary for the center tap -- so don't adjust.
      if ( bitsAtATime = dataWidth ) then
        centerTapLatency:=get_da_fir_latency(
                            c_da_single_rate_fir,
                            bitsatatime,
                            datawidth,
                            datatype,
                            1,
                            0,
                            symmetric,
                            false);
        if (centerTapLatency+2 >= latency) and (numbertaps>3) then
          latency:=centerTapLatency+3;
        end if;
      end if;
      
      -- if the output is registered then an additional clock cycle of latency is required
      if ( registeredOut ) then
        latency:=latency+1;
      end if;
    
    else
      -- default for all "standard" filters
      PDAFilter:=(bitsatatime >= datawidth);
      effectiveDataWidth:=datawidth;
      if symmetric then
        effectiveDataWidth:=effectiveDataWidth+1;
      end if;

      -- calculate the number of clock cycles required to process a single sample
      if PDAFilter then
        processingClockCycles:=1;
      else
        processingClockCycles:= ( effectiveDataWidth + ( bitsAtATime - 1 ) )/ bitsAtATime;
      end if;

      -- determine how many "effective" taps are required to implement the filter
      effectiveNumberTaps:=numbertaps;
      if (filterType= c_da_hilbert_transform) then
        effectiveNumberTaps:= (numberTaps + 1)/2;
      elsif ( filterType=c_da_half_band) then
        effectiveNumberTaps:= ((numberTaps + 1)/2)+1;
      end if;
      if symmetric then
        effectiveNumberTaps:= (effectiveNumberTaps + 1)/2;
      end if;

      -- the effective number taps determines how many levels of slices are required
      -- take the log base 2 of this number and that determines how many level there are
      levelsOfSlices:=get_da_fir_AdderTreeLevel(((effectiveNumberTaps + 3)/4) );
      
      -- The number of clock cycles required to process data through each slice is determined by the number of
      -- LUTs required for each table. This is based on the number of bits per clock cycle being processed.
      clocksPerSlice:=1;
      effectiveNumberBitsAtATime:= bitsAtATime;
      
      -- if the this is a PDAFilter AND Symmetric then after combining the two data words an extra bit is generated and needs to be put through
      -- the DA_LUT which needs to be accounted for.
      if PDAFilter and symmetric and not (dataType=c_da_nrz) then
        effectiveNumberBitsAtATime:=effectiveNumberBitsAtATime+1;
      end if;

      compareLevel:=1;
      while (compareLevel<effectiveNumberBitsAtATime) loop
        compareLevel:=compareLevel*2;
        clocksPerSlice:=clocksPerSlice+1;
      end loop;
      
      -- calculate the total latency
      if PDAFilter then
        latency:= clocksPerSlice + levelsOfSlices + 1;
      else
        -- NOT a PDA filter, add in the number of clock cycles to process the data
        latency:= clocksPerSlice + levelsOfSlices + processingClockCycles + 2;
      end if;
      
      -- for symmetry an extra clock cycle is required to account for the "folding" of the data
      if symmetric then
        latency:=latency+1;
      end if;
      
      -- if the output is registered then an additional clock cycle of latency is required
      if ( registeredOut ) then
        latency:=latency+1;
      end if;
    end if;
  end if;

  return latency;

end;

function get_da_fir_AdderTreeLevel ( number: integer) return integer is
  variable numberLevelsAdderTree,compareLevels: integer;
begin
  numberLevelsAdderTree:=0;
  compareLevels:=1;

  while compareLevels< number loop
    compareLevels:=compareLevels*2;
    numberLevelsAdderTree:=numberLevelsAdderTree+1;
  end loop;
  return numberLevelsAdderTree;
end;

function get_da_fir_reloadDelay(
            filterType        : integer;
            dataWidth         : integer;
            baat              : integer;
            zeroPackingFactor : integer;
            numberChannels    : integer;
            numberTaps        : integer;
            modeRate          : integer;
            symmetric         : boolean;
            useBlockMemory    : boolean) return integer is
  variable clearClks,reloadClks:integer;
begin
  clearClks:=get_da_fir_ClearDelay( filterType, dataWidth, symmetric, useBlockMemory, zeroPackingFactor, baat, numberChannels );
  reloadClks:=get_da_fir_ReloadDelay_sub( filterType, numberTaps, modeRate, symmetric, useBlockMemory );
  
  if ( clearClks < reloadClks ) then
    return reloadClks;
  else
    return clearClks;
  end if;
end;

function get_da_fir_ClearDelay(
            filterType        : integer;
            dataWidth         : integer;
            symmetric         : boolean;
            blockMemory       : boolean;
            zeroPackingFactor : integer;
            baat              : integer;
            numberChannels    : integer ) return integer is
  variable effectiveDataWidth,
           clksPerSample,
           firstWriteDelay
           :integer;

begin
  effectiveDataWidth:=dataWidth;
  if symmetric then
    effectiveDataWidth:=effectiveDataWidth+1;
  end if;

  --calculate how deep the time skew buffers are
  clksPerSample:= (effectiveDataWidth + (baat -1))/baat;

  --special cases account for coefficient zeros which are additional delays in the time skew buffers
  if filterType=c_da_interpolated_fir then
    clksPerSample:=clksPerSample*(zeroPackingFactor + 1);
  elsif ( filterType=c_da_half_band or
          filterType=c_da_hilbert_transform or
          filterType=c_da_decimating_half_band or
          filterType=c_da_interpolating_half_band ) then
    clksPerSample:=clksPerSample*2;
  end if;

  -- calculate the total delay which is equal to (the depth of the time skew buffer) * (number of channels) *
  -- (four time skew buffers strung together) + (an offset for waiting for first write to the filter's coefficient luts)
  -- ( plus 16 clocks for the settling delay on the loadModeState )
  firstWriteDelay:=c_da_first_loader_write_delay_dist_memory;
  if blockMemory then
    firstWriteDelay:=c_da_first_loader_write_delay_block_memory;
  end if;

  return ( (clksPerSample * numberChannels * 4) + firstWriteDelay + 16 );
end;

function get_da_fir_reloadDelay_sub(
            filterType        : integer;
            numberTaps        : integer;
            modeRate          : integer;
            symmetric         : boolean;
            useBlockMemory    : boolean) return integer is
 variable latency,
          effectiveNumberTaps,
          tapIndex:integer;
 variable numberTapsPerSubFilter:t_int_array(modeRate-1 downto 0):=(others=>0);
 variable symmetric_int:boolean;
begin
  latency:=-1;
  effectiveNumberTaps:= numberTaps;
  if ( filterType=c_da_single_rate_fir or filterType=c_da_interpolated_fir) then
    if symmetric then
      effectiveNumberTaps:= (numberTaps + 1)/2;
    end if;
    --calculate the number DA LUTs that need to be loaded and multiply by the number clocks per table to reload
    latency:= ( ((effectiveNumberTaps + 3)/ 4) * c_da_number_clocks_per_lut);
  elsif ( filterType=c_da_half_band) then
    effectiveNumberTaps:= ((numberTaps + 1)/2); -- remove the zeros
    if ( symmetric ) then
      effectiveNumberTaps :=effectiveNumberTaps/2;  -- adjust for use of symmtery
    end if;
    effectiveNumberTaps:=effectiveNumberTaps+1;     -- account for the center tap

    --calculate the number DA LUTs that need to be loaded and multiply by the number clocks per table to reload
    latency:= ( ((effectiveNumberTaps + 3)/ 4) * c_da_number_clocks_per_lut);
  elsif ( filterType=c_da_hilbert_transform) then
    effectiveNumberTaps:= ((numberTaps + 1)/2); -- remove the zeros
    if ( symmetric ) then
      effectiveNumberTaps :=effectiveNumberTaps/ 2;  -- adjust for use of symmtery
    end if;

    --calculate the number DA LUTs that need to be loaded and multiply by the number clocks per table to reload
    latency := ( ((effectiveNumberTaps + 3)/ 4) * c_da_number_clocks_per_lut);
  elsif ( filterType=c_da_polyphase_interpolating or filterType=c_da_polyphase_decimating) then
    tapIndex:=0;
    latency:=0;
    if filterType=c_da_polyphase_interpolating then --interpolate filters do not use symmetry
      symmetric_int:=false;
    else
      symmetric_int:=symmetric;
    end if;
    if symmetric_int then --symmetric then
      effectiveNumberTaps:= ((numberTaps + 1)/2);--adjust for use of symmtery
    end if;
    --calculate the number of taps in each subfilter
    for tap in 0 to effectiveNumberTaps-1 loop
      numberTapsPerSubFilter(tapIndex):= numberTapsPerSubFilter(tapIndex)+ 1;
      tapIndex:=tapIndex+1;
      if ( tapIndex >= modeRate ) then
        tapIndex:= 0;
      end if;
    end loop;

    --loop through and get the reload timing for each of the sub-filters
    for subFilterIndex in 0 to modeRate-1 loop
      latency := latency+( ((numberTapsPerSubFilter(subFilterIndex) + 3)/ 4) * c_da_number_clocks_per_lut);
    end loop;
  elsif (filterType=c_da_decimating_half_band or filterType=c_da_interpolating_half_band) then
    effectiveNumberTaps:= ((numberTaps + 1)/2); -- remove the zeros
    if ( symmetric ) then
      effectiveNumberTaps := effectiveNumberTaps/2;  --adjust for use of symmtery
    end if;

    --get the main part of the filters Reload timing
    latency := ( ((effectiveNumberTaps + 3)/ 4) * c_da_number_clocks_per_lut);

    --get the time it takes for the center tap to be reloaded
    latency :=latency+ c_da_number_clocks_per_lut;
  end if;
  
  if ( filterType=c_da_single_rate_fir or filterType=c_da_interpolated_fir or
       filterType=c_da_half_band or filterType=c_da_hilbert_transform or
       filterType=c_da_polyphase_interpolating or filterType=c_da_polyphase_decimating or
       filterType=c_da_decimating_half_band or filterType=c_da_interpolating_half_band ) then
    --add in the overhead clock cycles
    latency:=latency+c_da_reload_overhead_clock_cycles;
    
    --block memories are registered and require 1 extra clock
    if useBlockMemory then
      latency:=latency+1;
    end if;
    
    --the DA FIR added an additional 16 clocks worth of delay to let the internal loading process complete
    latency:=latency+16;
  end if;
  
  return latency;
end;


end fir_compiler_v5_0_sim_pkg;
