-------------------------------------------------------------------------------
-- $RCSfile: fir_compiler_v5_0_mac_fir.vhd,v $ $Revision: 1.4 $ $Date: 2009/12/04 11:47:01 $
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
-- 
-- This behavioural model uses the basic FIR algorithm to predict the output
-- values which the core should produce.  For multi-rate cases, data is either
-- up-sampled at input or downsampled at the output in order to model the 
-- flow of data as a basic single rate filter for all cases - while this is
-- computationally less efficient, it should give a good alternative approach
-- compared to the hardware and ensures that the desired effect is achieved
-- regardless of any polyphase extraction methods.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

library xilinxcorelib;
--use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_utils_pkg_v2_0.get_max;
use xilinxcorelib.bip_utils_pkg_v2_0.get_min;
use xilinxcorelib.bip_utils_pkg_v2_0.log2roundup;
use xilinxcorelib.bip_utils_pkg_v2_0.lcase;
use xilinxcorelib.bip_utils_pkg_v2_0.divroundup;
use xilinxcorelib.fir_compiler_v5_0_sim_pkg.all;

-------------------------------------------------------------------------------

entity fir_compiler_v5_0_mac_fir is
generic (
  C_FAMILY            : string  := "virtex4";
  C_XDEVICEFAMILY     : string  := "virtex4";
  C_ELABORATION_DIR   : string  := "./";
  C_COMPONENT_NAME    : string  := "fir";
  C_MEM_INIT_FILE     : string  := "coeff.mif";
  FILTER_TYPE         : integer := 0;
  INTERP_RATE         : integer := 1;
  DECIM_RATE          : integer := 1;
  RATE_CHANGE_TYPE    : integer := 0;
  ZERO_PACKING_FACTOR : integer := 0;
  NUM_CHANNELS        : integer := 1;
  CHAN_IN_ADV         : integer := 0;
  CHAN_SEL_WIDTH      : integer := 4;
  NUM_TAPS            : integer := 16;
  CLOCK_FREQ          : integer := 400000000;
  SAMPLE_FREQ         : integer := 100000000;
  FILTER_ARCH         : integer := 1;
  DATA_TYPE           : integer := 0;
  DATA_WIDTH          : integer := 16;
  COEF_TYPE           : integer := 0;
  COEF_WIDTH          : integer := 16;
  ROUND_MODE          : integer := 0;
  ACCUM_WIDTH         : integer := 48;
  OUTPUT_WIDTH        : integer := 48;
  ALLOW_APPROX        : integer := 0;
  OUTPUT_REG          : integer := 1;
  SYMMETRY            : integer := 0;
  ODD_SYMMETRY        : integer := 0;
  NEG_SYMMETRY        : integer := 0;
  COEF_RELOAD         : integer := 0;
  NUM_FILTS           : integer := 1;
  FILTER_SEL_WIDTH    : integer := 4;
  C_HAS_SCLR          : integer := 1;
  C_HAS_CE            : integer := 0;
  C_HAS_ND            : integer := 1;
  C_HAS_CHAN0_IN      : integer := 0;
  C_HAS_DATA_VALID    : integer := 0;
  DATA_MEMTYPE        : integer := 0;
  COEF_MEMTYPE        : integer := 0;
  IPBUFF_MEMTYPE      : integer := 0;
  OPBUFF_MEMTYPE      : integer := 0;
  DATAPATH_MEMTYPE    : integer := 0;
  COL_MODE            : integer := 0;
  -- COL_1ST_LEN         : integer := 3;
  -- COL_WRAP_LEN        : integer := 4;
  COL_PIPE_LEN        : integer := 3;
  COL_CONFIG          : string  := "3,4,4,4";
  C_LATENCY           : integer := 0;
  C_OPTIMIZATION      : integer := 0;
  XIL_FFT_COMPATIBLE  : integer := 1;
  NUM_PATHS           : integer := 1;
  SCLR_DETERMINISTIC  : integer := 0
);             
port (
  SCLR                : in  std_logic:='0';
  CLK                 : in  std_logic;
  CE                  : in  std_logic:='0';

  ND                  : in  std_logic:='0';
  FILTER_SEL          : in  std_logic_vector(FILTER_SEL_WIDTH-1 downto 0):=(others=>'0');
  CHAN0_IN            : in  std_logic:='0';

  COEF_LD             : in  std_logic:='0';
  COEF_WE             : in  std_logic:='0';
  COEF_DIN            : in  std_logic_vector(COEF_WIDTH-1 downto 0):=(others=>'0');
  COEF_FILTER_SEL     : in  std_logic_vector(FILTER_SEL_WIDTH-1 downto 0):=(others=>'0');

  RFD                 : out std_logic;
  RDY                 : out std_logic;
  DATA_VALID          : out std_logic;
  CHAN_IN             : out std_logic_vector(CHAN_SEL_WIDTH-1 downto 0);
  CHAN_OUT            : out std_logic_vector(CHAN_SEL_WIDTH-1 downto 0);

  --Single path ports, NUM_PATHS=1
  DIN                 : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  
  DOUT                : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I              : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);

  --Multi-path ports, NUM_PATHS>1
  DIN_1               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_2               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_3               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_4               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_5               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_6               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_7               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_8               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_9               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_10              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_11              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_12              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_13              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_14              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_15              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_16              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');

  DOUT_1              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_1            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_1            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_2              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_2            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_2            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_3              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_3            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_3            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_4              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_4            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_4            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_5              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_5            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_5            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_6              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_6            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_6            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_7              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_7            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_7            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_8              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_8            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_8            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_9              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_9            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_9            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_10              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_10            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_10            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_11              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_11            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_11            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_12              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_12            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_12            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_13              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_13            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_13            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_14              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_14            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_14            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_15              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_15            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_15            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_16              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_16            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_16            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0)
);

end entity fir_compiler_v5_0_mac_fir;

-------------------------------------------------------------------------------

architecture behavioral of fir_compiler_v5_0_mac_fir is

-------------------------------------------------------------------------------
-- TOP-LEVEL CONSTANTS
-------------------------------------------------------------------------------
constant clocks_per_sample : integer := integer(clock_freq/sample_freq)/num_channels;
constant clks_per_samp_int : integer := integer(clock_freq/sample_freq);--clocks_per_sample*NUM_CHANNELS;

constant family_lcase        : string := lcase(C_FAMILY);
constant xdevicefamily_lcase : string := lcase(C_XDEVICEFAMILY);

-------------------------------------------------------------------------------
-- FILTER REQUIREMENTS RECORD
-------------------------------------------------------------------------------
constant fir_config:t_configuration:=choose_structure(C_FAMILY,
                                                    C_XDEVICEFAMILY,
                                                    C_ELABORATION_DIR,
                                                    C_COMPONENT_NAME,
                                                    C_MEM_INIT_FILE,
                                                    FILTER_TYPE,
                                                    INTERP_RATE,
                                                    DECIM_RATE,
                                                    RATE_CHANGE_TYPE,
                                                    ZERO_PACKING_FACTOR,
                                                    NUM_CHANNELS,
                                                    CHAN_IN_ADV,
                                                    CHAN_SEL_WIDTH,
                                                    NUM_TAPS,
                                                    CLOCK_FREQ,
                                                    SAMPLE_FREQ,
                                                    FILTER_ARCH,
                                                    DATA_TYPE,
                                                    DATA_WIDTH,
                                                    COEF_TYPE,
                                                    COEF_WIDTH,
                                                    ROUND_MODE,
                                                    ACCUM_WIDTH,
                                                    OUTPUT_WIDTH,
                                                    ALLOW_APPROX,
                                                    OUTPUT_REG,
                                                    SYMMETRY,
                                                    ODD_SYMMETRY,
                                                    NEG_SYMMETRY,
                                                    COEF_RELOAD,
                                                    NUM_FILTS,
                                                    FILTER_SEL_WIDTH,
                                                    C_HAS_SCLR,
                                                    C_HAS_CE,
                                                    C_HAS_ND,
                                                    C_HAS_CHAN0_IN,
                                                    C_HAS_DATA_VALID,
                                                    DATA_MEMTYPE,
                                                    COEF_MEMTYPE,
                                                    IPBUFF_MEMTYPE,
                                                    OPBUFF_MEMTYPE,
                                                    DATAPATH_MEMTYPE,
                                                    COL_MODE,
                                                    -- COL_1ST_LEN,
                                                    -- COL_WRAP_LEN,
                                                    COL_PIPE_LEN,
                                                    COL_CONFIG,
                                                    C_LATENCY,
                                                    C_OPTIMIZATION,
                                                    XIL_FFT_COMPATIBLE,
                                                    NUM_PATHS,
                                                    SCLR_DETERMINISTIC);

-------------------------------------------------------------------------------
-- Function to return the correct t_reqs value
-------------------------------------------------------------------------------
function select_fir(config:t_configuration) return t_reqs is
  variable reqs,ret_reqs:t_reqs;
begin
  if config.struct=extended_mult then
    reqs:=config.reqs;
    reqs.has_ext_output_src:=true;
    ret_reqs:=define_extended_mult(config.reqs,C_ELABORATION_DIR,C_COMPONENT_NAME,C_MEM_INIT_FILE,false).config.reqs;
    reqs.ext_src_delay:=ret_reqs.ext_src_delay;
    reqs.round_mode:=ret_reqs.round_mode;
    reqs.num_paths:=ret_reqs.num_paths;
    reqs.path_reqs:=ret_reqs.path_reqs;
    return reqs;
  else
    return config.reqs;
  end if;
end;

constant fir_model_reqs: t_reqs:=select_fir(fir_config);

-------------------------------------------------------------------------------
-- MAIN CORE PARAMETER CALCULATION FUNCTION
-------------------------------------------------------------------------------

-- Property record containing all useful parameters of the filter
type t_syst_mac_fir_properties is
record
  cascade_dly         : integer;
  actual_taps         : integer;
  reload_taps         : integer;
  symmetry            : integer;
  odd_symmetry        : integer;
  full_taps           : integer;
  ipbuff_depth        : integer;
  ipbuff_rate         : integer;
  ipbuff_thresh       : integer;
  ipbuff_lat          : integer;
  opbuff_depth        : integer;
  opbuff_rate         : integer;
  opbuff_thresh       : integer;
  inter_rate          : integer;
  deci_rate           : integer;
  zpf                 : integer;
  clk_per_chan        : integer;
  num_macs            : integer;
  single_mac          : integer;
  centre_mac          : integer;
  base_count          : integer;
  base_data_space     : integer;
  base_coef_space     : integer;
  coef_mem_type       : integer;
  data_mem_type       : integer;
  reload_lat          : integer;
  reorder_seq         : t_reorder_info_array( max_taps-1 downto 0);
  use_approx          : boolean;
  full_parallel       : integer;
end record; 

-------------------------------------------------------------------------------
-- Calculate full tap length
-- Takes the number of actual taps implemented after symmetry and calculates
-- the full number of filter taps after pre- and post-padding.
-------------------------------------------------------------------------------
function get_full_taps ( filter_type      : integer;
                         inter_rate       : integer;
                         num_taps         : integer;
                         actual_taps      : integer;
                         symmetry         : integer
                         )
                         return integer is

begin

  -- if filter_type = c_interpolating_symmetry then
  --   return actual_taps*(2**symmetry)-(num_taps rem (2**symmetry))-(inter_rate/2);
  -- else
    return actual_taps*(2**symmetry)-(num_taps rem (2**symmetry));
  -- end if;
                            
end get_full_taps;



-------------------------------------------------------------------------------
-- Function : fir_prop
-- Calculate required filter properties from definition of the appropriate
-- filter type.
-- This function includes overloading of interpolating symmetry filter type
-- where appropriate.
-------------------------------------------------------------------------------
function fir_prop (  reqs : t_reqs;
                        elab_dir,
                        comp_name,
                        mif_file:string ) return t_syst_mac_fir_properties is

  variable single_rate            : t_define_single_rate;
  variable decimation             : t_define_decimation;
  variable halfband               : t_define_halfband;
  variable interpolated           : t_define_interpolated;
  variable hilbert                : t_define_hilbert;
  variable interpolation          : t_define_interpolation;
  variable halfband_decimation    : t_define_halfband_decimation;
  variable halfband_interpolation : t_define_halfband_interpolation;
  variable sympair_interpolation  : t_define_sympair_interpolation;
  variable pq_interpolation       : t_define_pq_interpolation;
  variable pq_decimation          : t_define_pq_decimation;
  variable transpose              : t_define_transpose;
  variable channelizer            : t_define_channelizer;
  variable pq_decimation_alt      : t_define_pq_decimation_alt;
  variable properties             : t_syst_mac_fir_properties;
  --variable reqs_temp              : t_reqs;
    
begin
  
  -- defaults
  properties.zpf             := 1;
  properties.ipbuff_depth    := 0;
  properties.opbuff_depth    := 0;
  properties.opbuff_rate     := 0;
  properties.opbuff_thresh   := 0;
  properties.full_parallel   := 0;
  properties.ipbuff_lat      := 1;

  -- Filter type specific parameters
  case reqs.filter_type is
  when c_single_rate =>
    single_rate                   :=define_single_rate(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=single_rate.latency;
    properties.actual_taps        :=single_rate.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps;
    properties.symmetry           :=single_rate.param.symmetry;
    properties.odd_symmetry       :=single_rate.param.odd_symmetry;
    properties.clk_per_chan       :=single_rate.param.clk_per_chan;
    properties.reload_lat         :=0;--single_rate.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=single_rate.param.num_macs;
    properties.single_mac         :=single_rate.param.single_mac;
    properties.base_count         :=single_rate.param.base_count;
    properties.inter_rate         :=single_rate.param.inter_rate;
    properties.deci_rate          :=single_rate.param.deci_rate;
    properties.centre_mac         :=single_rate.param.centre_mac;
    properties.coef_mem_type      :=single_rate.param.coef_mem_type;
    properties.data_mem_type      :=single_rate.param.data_mem_type;
    properties.base_coef_space    :=single_rate.param.base_coef_space;
    properties.base_data_space    :=single_rate.param.base_coef_space;
    properties.use_approx         :=single_rate.use_approx;
    properties.full_parallel      :=single_rate.param.full_parallel;
    properties.reorder_seq        :=single_rate.reorder_seq;
  when c_polyphase_decimating =>
    decimation                    :=define_decimation(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=decimation.latency;
    properties.actual_taps        :=decimation.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps;
    properties.symmetry           :=decimation.param.symmetry;
    properties.odd_symmetry       :=decimation.param.odd_symmetry;
    if decimation.has_output_buffer then
      properties.opbuff_depth     :=decimation.buffer_page_size;
    else
      properties.opbuff_depth     :=0;
    end if;
    properties.opbuff_rate        :=decimation.output_rate;
    properties.opbuff_thresh      :=properties.opbuff_depth-1;
    properties.clk_per_chan       :=decimation.param.clk_per_chan;
    properties.reload_lat         :=2;--decimation.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=decimation.param.num_macs;
    properties.single_mac         :=decimation.param.single_mac;
    properties.base_count         :=decimation.param.base_count;
    properties.inter_rate         :=decimation.param.inter_rate;
    properties.deci_rate          :=decimation.param.deci_rate;
    properties.centre_mac         :=decimation.param.centre_mac;
    properties.coef_mem_type      :=decimation.param.coef_mem_type;
    properties.data_mem_type      :=decimation.param.data_mem_type;
    properties.base_coef_space    :=decimation.param.base_coef_space;
    properties.base_data_space    :=decimation.param.base_coef_space;
    properties.use_approx         :=decimation.use_approx;
    properties.full_parallel      :=decimation.param.full_parallel;
    properties.reorder_seq        :=decimation.reorder_seq;
  when c_polyphase_interpolating =>
    interpolation                 :=define_interpolation(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=interpolation.latency;
    properties.actual_taps        :=interpolation.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps;
    properties.symmetry           :=interpolation.param.symmetry;
    properties.odd_symmetry       :=interpolation.param.odd_symmetry;
    if interpolation.has_input_buffer then
      properties.ipbuff_depth     := interpolation.buffer_page_size;
      properties.reload_lat       := 2+interpolation.input_buffer_lat;
    else
      properties.ipbuff_depth     := 0;--1;
      properties.reload_lat       := 1;
    end if;
    properties.clk_per_chan       :=interpolation.param.clk_per_chan;
    --properties.reload_lat         :=interpolation.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=interpolation.param.num_macs;
    properties.single_mac         :=interpolation.param.single_mac;
    properties.base_count         :=interpolation.param.base_count;
    properties.inter_rate         :=interpolation.param.inter_rate;
    properties.deci_rate          :=interpolation.param.deci_rate;
    properties.centre_mac         :=interpolation.param.centre_mac;
    properties.coef_mem_type      :=interpolation.param.coef_mem_type;
    properties.data_mem_type      :=interpolation.param.data_mem_type;
    properties.base_coef_space    :=interpolation.param.base_coef_space;
    properties.base_data_space    :=interpolation.param.base_coef_space;
    properties.use_approx         :=interpolation.use_approx;
    properties.full_parallel      :=interpolation.param.full_parallel;
    properties.reorder_seq        :=interpolation.reorder_seq;
  when c_interpolating_symmetry =>
    sympair_interpolation         :=define_sympair_interpolation(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=sympair_interpolation.latency;
    properties.actual_taps        :=sympair_interpolation.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps;
    properties.symmetry           :=sympair_interpolation.param.symmetry;
    properties.odd_symmetry       :=sympair_interpolation.param.odd_symmetry;
    if sympair_interpolation.has_output_buffer then
      properties.opbuff_depth     := sympair_interpolation.buffer_page_size;
    else
      properties.opbuff_depth     := 0;
    end if;
    properties.opbuff_rate        :=sympair_interpolation.output_rate;
    properties.opbuff_thresh      :=properties.opbuff_depth-reqs.inter_rate;
    properties.clk_per_chan       :=sympair_interpolation.param.clk_per_chan;
    properties.reload_lat         :=0;--sympair_interpolation.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=sympair_interpolation.param.num_macs;
    properties.single_mac         :=sympair_interpolation.param.single_mac;
    properties.base_count         :=sympair_interpolation.param.base_count;
    properties.inter_rate         :=sympair_interpolation.param.inter_rate;
    properties.deci_rate          :=sympair_interpolation.param.deci_rate;
    properties.centre_mac         :=sympair_interpolation.param.centre_mac;
    properties.coef_mem_type      :=sympair_interpolation.param.coef_mem_type;
    properties.data_mem_type      :=sympair_interpolation.param.data_mem_type;
    properties.base_coef_space    :=sympair_interpolation.param.base_coef_space;
    properties.base_data_space    :=sympair_interpolation.param.base_coef_space;
    properties.use_approx         :=sympair_interpolation.use_approx;
    properties.full_parallel      :=sympair_interpolation.param.full_parallel;
    properties.reorder_seq        :=sympair_interpolation.reorder_seq;
  when c_hilbert_transform =>
    hilbert                       :=define_hilbert(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=hilbert.latency;
    properties.actual_taps        :=hilbert.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps/2;
    properties.symmetry           :=hilbert.param.symmetry;
    properties.odd_symmetry       :=hilbert.param.odd_symmetry;
    properties.clk_per_chan       :=hilbert.param.clk_per_chan;
    properties.reload_lat         :=0;--hilbert.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=hilbert.param.num_macs;
    properties.single_mac         :=hilbert.param.single_mac;
    properties.base_count         :=hilbert.param.base_count;
    properties.inter_rate         :=hilbert.param.inter_rate;
    properties.deci_rate          :=hilbert.param.deci_rate;
    properties.centre_mac         :=hilbert.param.centre_mac;
    properties.coef_mem_type      :=hilbert.param.coef_mem_type;
    properties.data_mem_type      :=hilbert.param.data_mem_type;
    properties.base_coef_space    :=hilbert.param.base_coef_space;
    properties.base_data_space    :=hilbert.param.base_coef_space;
    properties.use_approx         :=hilbert.use_approx;
    properties.full_parallel      :=hilbert.param.full_parallel;
    properties.reorder_seq        :=hilbert.reorder_seq;
  when c_interpolated_transform =>
    interpolated                  :=define_interpolated(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=interpolated.latency;
    properties.actual_taps        :=interpolated.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps;
    properties.symmetry           :=interpolated.param.symmetry;
    properties.odd_symmetry       :=interpolated.param.odd_symmetry;
    properties.zpf                :=reqs.zero_packing_factor;
    properties.clk_per_chan       :=interpolated.param.clk_per_chan;
    properties.reload_lat         :=0;--interpolated.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=interpolated.param.num_macs;
    properties.single_mac         :=interpolated.param.single_mac;
    properties.base_count         :=interpolated.param.base_count;
    properties.inter_rate         :=interpolated.param.inter_rate;
    properties.deci_rate          :=interpolated.param.deci_rate;
    properties.centre_mac         :=interpolated.param.centre_mac;
    properties.coef_mem_type      :=interpolated.param.coef_mem_type;
    properties.data_mem_type      :=interpolated.param.data_mem_type;
    properties.base_coef_space    :=interpolated.param.base_coef_space;
    properties.base_data_space    :=interpolated.param.base_coef_space;
    properties.use_approx         :=interpolated.use_approx;
    properties.full_parallel      :=interpolated.param.full_parallel;
    properties.reorder_seq        :=interpolated.reorder_seq;
  when c_halfband_transform =>
    halfband                      :=define_halfband(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=halfband.latency;
    properties.actual_taps        :=halfband.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps/2 + 1;
    properties.symmetry           :=halfband.param.symmetry;
    properties.odd_symmetry       :=halfband.param.odd_symmetry;
    properties.clk_per_chan       :=halfband.param.clk_per_chan;
    properties.reload_lat         :=0;--halfband.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=halfband.param.num_macs;
    properties.single_mac         :=halfband.param.single_mac;
    properties.base_count         :=halfband.param.base_count;
    properties.inter_rate         :=halfband.param.inter_rate;
    properties.deci_rate          :=halfband.param.deci_rate;
    properties.centre_mac         :=halfband.param.centre_mac;
    properties.coef_mem_type      :=halfband.param.coef_mem_type;
    properties.data_mem_type      :=halfband.param.data_mem_type;
    properties.base_coef_space    :=halfband.param.base_coef_space;
    properties.base_data_space    :=halfband.param.base_coef_space;
    properties.use_approx         :=halfband.use_approx;
    properties.full_parallel      :=halfband.param.full_parallel;
    properties.reorder_seq        :=halfband.reorder_seq;
  when c_decimating_half_band =>
    halfband_decimation           :=define_halfband_decimation(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=halfband_decimation.latency;
    properties.actual_taps        :=halfband_decimation.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps/2 + 1;
    properties.symmetry           :=halfband_decimation.param.symmetry;
    properties.odd_symmetry       :=halfband_decimation.param.odd_symmetry;
    properties.ipbuff_depth       :=halfband_decimation.buffer_page_size;
    properties.clk_per_chan       :=halfband_decimation.param.clk_per_chan;
    properties.reload_lat         :=5+halfband_decimation.input_buffer_lat;--halfband_decimation.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=halfband_decimation.param.num_macs;
    properties.single_mac         :=halfband_decimation.param.single_mac;
    properties.base_count         :=halfband_decimation.param.base_count;
    properties.inter_rate         :=halfband_decimation.param.inter_rate;
    properties.deci_rate          :=halfband_decimation.param.deci_rate;
    properties.centre_mac         :=halfband_decimation.param.centre_mac;
    properties.coef_mem_type      :=halfband_decimation.param.coef_mem_type;
    properties.data_mem_type      :=halfband_decimation.param.data_mem_type;
    properties.base_coef_space    :=halfband_decimation.param.base_coef_space;
    properties.base_data_space    :=halfband_decimation.param.base_coef_space;
    properties.use_approx         :=halfband_decimation.use_approx;
    properties.full_parallel      :=halfband_decimation.param.full_parallel;
    properties.reorder_seq        :=halfband_decimation.reorder_seq;
  when c_interpolating_half_band =>
    halfband_interpolation        :=define_halfband_interpolation(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=halfband_interpolation.latency;
    properties.actual_taps        :=halfband_interpolation.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps/2 + 1;
    properties.symmetry           :=halfband_interpolation.param.symmetry;
    properties.odd_symmetry       :=halfband_interpolation.param.odd_symmetry;
    properties.opbuff_depth       :=halfband_interpolation.buffer_page_size;
    properties.opbuff_rate        :=halfband_interpolation.output_rate;
    properties.opbuff_thresh      :=properties.opbuff_depth-2;
    properties.clk_per_chan       :=halfband_interpolation.param.clk_per_chan;
    properties.reload_lat         :=0;--halfband_interpolation.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=halfband_interpolation.param.num_macs;
    properties.single_mac         :=halfband_interpolation.param.single_mac;
    properties.base_count         :=halfband_interpolation.param.base_count;
    properties.inter_rate         :=halfband_interpolation.param.inter_rate;
    properties.deci_rate          :=halfband_interpolation.param.deci_rate;
    properties.centre_mac         :=halfband_interpolation.param.centre_mac;
    properties.coef_mem_type      :=halfband_interpolation.param.coef_mem_type;
    properties.data_mem_type      :=halfband_interpolation.param.data_mem_type;
    properties.base_coef_space    :=halfband_interpolation.param.base_coef_space;
    properties.base_data_space    :=halfband_interpolation.param.base_coef_space;
    properties.use_approx         :=halfband_interpolation.use_approx;
    properties.full_parallel      :=halfband_interpolation.param.full_parallel;
    properties.reorder_seq        :=halfband_interpolation.reorder_seq;
  when c_polyphase_pq =>
    if reqs.inter_rate>reqs.deci_rate then
      pq_interpolation            :=define_pq_interpolation(reqs,elab_dir,comp_name,mif_file,false,true);
      properties.cascade_dly      :=pq_interpolation.latency;
      properties.actual_taps      :=pq_interpolation.param.num_taps_calced;
      properties.reload_taps      :=properties.actual_taps;
      properties.symmetry         :=pq_interpolation.param.symmetry;
      properties.odd_symmetry     :=pq_interpolation.param.odd_symmetry;
      if pq_interpolation.has_input_buffer then
        properties.ipbuff_depth   := pq_interpolation.buffer_page_size;
        --properties.reload_lat     := 2;
        properties.reload_lat     := 2+pq_interpolation.input_buffer_lat;
      else
        properties.ipbuff_depth   := 1;--model always needs to use input buffer
        if pq_interpolation.param.num_filts>1 then
          properties.reload_lat   := 2;
        else
          properties.reload_lat   := 1;
        end if;
      end if;
      properties.clk_per_chan     :=pq_interpolation.param.clk_per_chan;
      --properties.reload_lat       :=pq_interpolation.reload_cntrl_param_lat.reload_lat;
      properties.num_macs         :=pq_interpolation.param.num_macs;
      properties.single_mac       :=pq_interpolation.param.single_mac;
      properties.base_count       :=pq_interpolation.param.base_count;
      properties.inter_rate       :=pq_interpolation.param.inter_rate;
      properties.deci_rate        :=pq_interpolation.param.deci_rate;
      properties.centre_mac       :=pq_interpolation.param.centre_mac;
      properties.coef_mem_type    :=pq_interpolation.param.coef_mem_type;
      properties.data_mem_type    :=pq_interpolation.param.data_mem_type;
      properties.base_coef_space  :=pq_interpolation.param.base_coef_space;
      properties.base_data_space  :=pq_interpolation.param.base_coef_space;
      properties.use_approx       :=pq_interpolation.use_approx;
      properties.full_parallel    :=pq_interpolation.param.full_parallel;
      properties.reorder_seq      :=pq_interpolation.reorder_seq;
    else
      pq_decimation               :=define_pq_decimation(reqs,elab_dir,comp_name,mif_file,false,true);
      --properties.cascade_dly      :=pq_decimation.latency;
      properties.actual_taps      :=pq_decimation.param.num_taps_calced;
      properties.reload_taps      :=properties.actual_taps;
      properties.symmetry         :=pq_decimation.param.symmetry;
      properties.odd_symmetry     :=pq_decimation.param.odd_symmetry;
      if pq_decimation.has_output_buffer then
        properties.opbuff_depth   := pq_decimation.buffer_page_size;
        --correct reported latency for use with core.
        properties.cascade_dly    :=pq_decimation.latency -(pq_decimation.param.base_count*(reqs.inter_rate-1));
      else
        properties.opbuff_depth   := 0;
        properties.cascade_dly    :=pq_decimation.latency-(pq_decimation.param.base_count*(reqs.deci_rate rem reqs.inter_rate))
                                    +pq_decimation.param.base_count;
      end if;
      properties.opbuff_rate      :=pq_decimation.output_rate;
      properties.opbuff_thresh    :=properties.opbuff_depth-1;
      properties.clk_per_chan     :=pq_decimation.param.clk_per_chan;
      properties.reload_lat       :=3;--pq_decimation.reload_cntrl_param_lat.reload_lat;
      properties.num_macs         :=pq_decimation.param.num_macs;
      properties.single_mac       :=pq_decimation.param.single_mac;
      properties.base_count       :=pq_decimation.param.base_count;
      properties.inter_rate       :=pq_decimation.param.inter_rate;
      properties.deci_rate        :=pq_decimation.param.deci_rate;
      properties.centre_mac       :=pq_decimation.param.centre_mac;
      properties.coef_mem_type    :=pq_decimation.param.coef_mem_type;
      properties.data_mem_type    :=pq_decimation.param.data_mem_type;
      properties.base_coef_space  :=pq_decimation.param.base_coef_space;
      properties.base_data_space  :=pq_decimation.param.base_coef_space;
      properties.use_approx       :=pq_decimation.use_approx;
      properties.full_parallel    :=pq_decimation.param.full_parallel;
      properties.reorder_seq      :=pq_decimation.reorder_seq;
     end if;
  when c_polyphase_pq_dec_alt =>
    pq_decimation_alt             :=define_pq_decimation_alt(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly      :=pq_decimation_alt.latency-1;--sub one due to a cycle latency introduced in model
    properties.actual_taps      :=pq_decimation_alt.param.num_taps_calced;
    properties.reload_taps      :=properties.actual_taps;
    properties.symmetry         :=pq_decimation_alt.param.symmetry;
    properties.odd_symmetry     :=pq_decimation_alt.param.odd_symmetry;
    properties.ipbuff_depth     :=pq_decimation_alt.input_buffer_depth;
                                  -- (pq_decimation_alt.param.num_channels*divroundup(pq_decimation_alt.param.deci_rate,pq_decimation_alt.param.inter_rate))
                                  -- +pq_decimation_alt.addr_cntrl_lat;
    properties.clk_per_chan     :=pq_decimation_alt.param.clk_per_chan;
    -- properties.reload_lat       :=pq_decimation_alt.reload_cntrl_param_lat.reload_lat;
    properties.num_macs         :=pq_decimation_alt.param.num_macs;
    properties.single_mac       :=pq_decimation_alt.param.single_mac;
    properties.base_count       :=pq_decimation_alt.param.base_count;
    properties.inter_rate       :=pq_decimation_alt.param.inter_rate;
    properties.deci_rate        :=pq_decimation_alt.param.deci_rate;
    properties.centre_mac       :=pq_decimation_alt.param.centre_mac;
    properties.coef_mem_type    :=pq_decimation_alt.param.coef_mem_type;
    properties.data_mem_type    :=pq_decimation_alt.param.data_mem_type;
    properties.base_coef_space  :=pq_decimation_alt.param.base_coef_space;
    properties.base_data_space  :=pq_decimation_alt.param.base_coef_space;
    properties.use_approx       :=pq_decimation_alt.use_approx;
    properties.full_parallel    :=pq_decimation_alt.param.full_parallel;
    properties.reorder_seq      :=pq_decimation_alt.reorder_seq;
    properties.ipbuff_lat       :=pq_decimation_alt.addr_cntrl_lat;
    
    properties.reload_lat       := pq_decimation_alt.input_buffer_lat+3;--2;--3;--1;--2+pq_decimation_alt.input_buffer_lat;
                                    --add a further cycle delay to account for the difference in behavour in the variables used 
                                    --in the model compared to the signals in the core
    
  when c_transpose_single_rate | c_transpose_decimating | c_transpose_interpolating =>
    transpose                     :=define_transpose(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=transpose.latency;
    properties.actual_taps        :=transpose.param.num_taps_calced;
    properties.reload_taps        :=properties.actual_taps;
    properties.symmetry           :=transpose.param.symmetry;
    properties.odd_symmetry       :=transpose.param.odd_symmetry;
    properties.clk_per_chan       :=transpose.param.clk_per_chan;
    if reqs.filter_type=c_transpose_decimating then
      properties.reload_lat         :=2;
    else
      properties.reload_lat         :=0;--single_rate.reload_cntrl_param_lat.reload_lat;
    end if;
    properties.num_macs           :=transpose.param.num_macs;
    properties.single_mac         :=transpose.param.single_mac;
    properties.base_count         :=transpose.param.base_count;
    properties.inter_rate         :=transpose.param.inter_rate;
    properties.deci_rate          :=transpose.param.deci_rate;
    properties.centre_mac         :=transpose.param.centre_mac;
    properties.coef_mem_type      :=transpose.param.coef_mem_type;
    properties.data_mem_type      :=transpose.param.data_mem_type;
    properties.base_coef_space    :=transpose.param.base_coef_space;
    properties.base_data_space    :=transpose.param.base_coef_space;
    properties.use_approx         :=transpose.use_approx;
    properties.full_parallel      :=transpose.param.full_parallel;
    properties.reorder_seq        :=transpose.reorder_seq;
  when c_channelizer_transmitter | c_channelizer_receiver =>
    channelizer                   :=define_channelizer(reqs,elab_dir,comp_name,mif_file,false,true);
    properties.cascade_dly        :=channelizer.latency;
    properties.actual_taps        :=channelizer.param.num_taps_calced/reqs.num_channels;
    properties.reload_taps        :=channelizer.param.num_taps_calced;--properties.actual_taps;
    properties.symmetry           :=0;
    properties.odd_symmetry       :=0;
    if channelizer.has_output_buffer then
      properties.opbuff_depth     :=channelizer.buffer_page_size;
    else
      properties.opbuff_depth     :=0;
    end if;
    properties.opbuff_rate        :=1;
    properties.opbuff_thresh      :=properties.opbuff_depth-1;
    if channelizer.has_input_buffer then
      properties.ipbuff_depth     := channelizer.buffer_page_size;
    else
      properties.ipbuff_depth     := 0;
    end if;
    properties.clk_per_chan       :=channelizer.param.clk_per_chan;
    properties.reload_lat         :=2;--decimation.reload_cntrl_param_lat.reload_lat;
    properties.num_macs           :=channelizer.param.num_macs;
    properties.single_mac         :=channelizer.param.single_mac;
    properties.base_count         :=channelizer.param.base_count;
    properties.inter_rate         :=channelizer.param.inter_rate;
    properties.deci_rate          :=channelizer.param.deci_rate;
    properties.centre_mac         :=channelizer.param.centre_mac;
    properties.coef_mem_type      :=channelizer.param.coef_mem_type;
    properties.data_mem_type      :=channelizer.param.data_mem_type;
    properties.base_coef_space    :=channelizer.param.base_coef_space;
    properties.base_data_space    :=channelizer.param.base_coef_space;
    properties.use_approx         :=channelizer.use_approx;
    properties.full_parallel      :=channelizer.param.full_parallel;
    properties.reorder_seq        :=channelizer.reorder_seq;
  when others =>
    report "FAILURE: FIR Compiler v4.0: Invalid filter type." severity failure;
  end case;

  -- Get the full tap count from the number of taps, the actual implemented taps
  -- the symmetry properties
  properties.full_taps := get_full_taps( reqs.filter_type,
                                         reqs.inter_rate,
                                         reqs.num_taps,
                                         properties.actual_taps,
                                         properties.symmetry);

  -- Input Buffer rate is always clocks per sample per channel divided by the
  -- interpolation rate
  if reqs.filter_type = c_decimating_half_band then
    properties.ipbuff_rate := halfband_decimation.base_count_op_rate;
  elsif reqs.filter_type = c_polyphase_pq then
    if reqs.inter_rate>reqs.deci_rate then
      properties.ipbuff_rate := properties.clk_per_chan*reqs.deci_rate/reqs.inter_rate;
    else
      properties.ipbuff_rate := properties.base_count;
    end if;
  elsif reqs.filter_type = c_polyphase_pq_dec_alt then
    properties.ipbuff_rate := pq_decimation_alt.base_count_op_rate;
  else
    properties.ipbuff_rate := properties.clk_per_chan/reqs.inter_rate;
  end if;
  
  if reqs.filter_type = c_polyphase_pq_dec_alt then
    --hyjack this parameter to pass the value used to de-assert rfd
    properties.ipbuff_thresh := pq_decimation_alt.rfd_threshold;
  else
    -- Input Buffer threshold is always buffer depth minus 1 currently
    properties.ipbuff_thresh := properties.ipbuff_depth-1;
  end if;

  -- Report parameters
  -- report "<FIR MODEL> Required taps     = " & integer'image(reqs.num_taps);
  -- report "<FIR MODEL> Actual taps       = " & integer'image(properties.actual_taps);
  -- report "<FIR MODEL> Full taps         = " & integer'image(properties.full_taps);
  -- report "<FIR MODEL> Reload taps       = " & integer'image(properties.reload_taps);
  -- report "<FIR MODEL> Casade delay      = " & integer'image(properties.cascade_dly);
  -- report "<FIR MODEL> I/P buffer depth  = " & integer'image(properties.ipbuff_depth);
  -- report "<FIR MODEL> I/P buffer rate   = " & integer'image(properties.ipbuff_rate);
  -- report "<FIR MODEL> I/P buffer thresh = " & integer'image(properties.ipbuff_thresh);
  -- report "<FIR MODEL> O/P buffer depth  = " & integer'image(properties.opbuff_depth);
  -- report "<FIR MODEL> O/P buffer rate   = " & integer'image(properties.opbuff_rate);
  -- report "<FIR MODEL> O/P buffer thresh = " & integer'image(properties.opbuff_thresh);
  -- report "<FIR MODEL> ZPF               = " & integer'image(properties.zpf);
  -- report "<FIR MODEL> Clk/Sample/Chan   = " & integer'image(properties.clk_per_chan);
  -- report "<FIR MODEL> Rld latency       = " & integer'image(properties.reload_lat);
  -- report "<FIR MODEL> Number of MACs    = " & integer'image(properties.num_macs);
  -- report "<FIR MODEL> Single MAC?       = " & integer'image(properties.single_mac);
  -- report "<FIR MODEL> Base count        = " & integer'image(properties.base_count);
  -- report "<FIR MODEL> Interp Rate       = " & integer'image(properties.inter_rate);
  -- report "<FIR MODEL> Decimation Rate   = " & integer'image(properties.deci_rate);
  -- report "<FIR MODEL> Centre MAC        = " & integer'image(properties.centre_mac);
  -- report "<FIR MODEL> Coef Mem Type     = " & integer'image(properties.coef_mem_type);
  -- report "<FIR MODEL> Data Mem Type     = " & integer'image(properties.data_mem_type);
  -- report "<FIR MODEL> Base Coef Space   = " & integer'image(properties.base_coef_space);
  -- report "<FIR MODEL> Base Data Space   = " & integer'image(properties.base_data_space);

  return properties;

end;

-- Calculate Systolic MAC FIR properties with function call
constant properties : t_syst_mac_fir_properties := fir_prop(
                                                    fir_model_reqs,
                                                    C_ELABORATION_DIR,
                                                    C_COMPONENT_NAME,
                                                    C_MEM_INIT_FILE);


-------------------------------------------------------------------------------
-- CONSTANTS
-------------------------------------------------------------------------------

-- Create integer overflow thresholds explicitly, as decisions are made based
-- on the widths of these values
constant max_int_width : integer :=  31;
constant maxint        : integer :=    2**(max_int_width-1) - 1;
constant minint        : integer := -1*2**(max_int_width-1);

-- Input buffer depth - no modifications
constant buff_in_depth  : integer := 2*properties.ipbuff_depth;

-- Determine the output buffer depth
constant buff_out_depth           : integer := (properties.opbuff_depth);
constant buff_out_depth_pq_extra  : integer := select_integer(0,(properties.opbuff_depth-1)*DECIM_RATE,
                                                                fir_model_reqs.filter_type = c_polyphase_pq and INTERP_RATE<DECIM_RATE and properties.opbuff_depth/=0);

-- Set the depth of the sample buffer.
-- This needs to be the full number of taps, plus the sample latency of the
-- filter, plus the input buffer depth if not modelled separately.
-- Use cycle latency and a fudge factor for initial debugging.
-- Multiply this depth by zero packing factor to support interpolated filter types
constant sample_delay : integer := ((properties.cascade_dly+properties.clk_per_chan)/properties.clk_per_chan);
constant buffer_fudge : integer := get_max((properties.full_taps+3)/4,INTERP_RATE);
-- added extra fudge for pq int structures where it seems the buffer can be overflowed

constant main_buffer_depth : integer := buff_in_depth +
                                        INTERP_RATE*sample_delay  +
                                        properties.zpf*properties.full_taps +
                                        buff_out_depth +
                                        buff_out_depth_pq_extra +
                                        buffer_fudge;

-- Set the offset due to padding for reading coefficients from the COE file
-- into the calculated filter coefficient array.
constant sym_padding     : integer := ((properties.full_taps-fir_model_reqs.num_taps)/2);
constant inter_sym_shift : integer:=select_integer(0,fir_model_reqs.inter_rate/2,
                                                  (fir_model_reqs.filter_type=c_interpolating_symmetry or
                                                  (fir_model_reqs.filter_type=c_polyphase_interpolating and properties.symmetry=1))
                                                  and properties.odd_symmetry=1
                                                  and (fir_model_reqs.inter_rate rem 2 >0));

constant pad_offset      : integer := select_integer(0,sym_padding-inter_sym_shift,properties.symmetry=1);

-- Cascade length is modified by :
-- 1 to allow a cycle for interpolation rate adaptation
-- 1 to allow a cycle for decimation rate adaptation
-- 1 to allow a cycle for output register
-- 1 to allow a cycle for output buffer, if present
constant rdy_dly_len    : integer := select_integer(
                                     properties.cascade_dly-3,
                                     properties.cascade_dly-4,
                                     properties.opbuff_depth>0);
 

-- Determine the regressor vector length based on Interpolated ZPF and tap count
--constant regressor_len  : integer := properties.zpf*properties.full_taps;
constant regressor_len  : integer := (properties.full_taps-1)*properties.zpf+1;


-- Determine regressor pointer default location based on full tap count and zero
-- packing factor.  Normally just taps-1, but needs to be stretched appropriately
-- by the ZPF factor along with the regressor itself.
constant pointer_start : integer := select_integer(
                                      regressor_len-1,
                                      get_max(regressor_len-1,properties.deci_rate-1),
                                      fir_model_reqs.filter_type = c_polyphase_pq_dec_alt);

--Determine if data needs to be split, in future could extend to >64 bits but leave as simple division
constant split_dwidth : integer := select_integer(DATA_WIDTH,(DATA_WIDTH+1)/2,DATA_WIDTH+DATA_TYPE>=max_int_width);--  --29

constant dpages : integer:= select_integer(1,2,DATA_WIDTH+DATA_TYPE>=max_int_width);

-- Determine the coefficient split point based on the data width
constant split_cwidth : integer := get_min( (max_int_width-split_dwidth-select_integer(DATA_TYPE,1,dpages>1)) , COEF_WIDTH );

-- Determine required coefficient pages based on partial product split
constant cpages : integer := (COEF_WIDTH+split_cwidth-1)/split_cwidth;

-- Determine if we need to split the accumulator into separate integers to avoid
-- MAXINT overflow
constant split_accum : boolean :=  ACCUM_WIDTH >= max_int_width
                               or (DATA_WIDTH+select_integer(DATA_TYPE,1,dpages>1)+COEF_WIDTH) >= max_int_width
                               or (cpages>1); --add just to make sure if coefficient are split then the correct fir function is used


-- Determine whether or not output is a signed value or not
constant signed_output : boolean := ((COEF_TYPE=0) or (DATA_TYPE=0));

-- Specify the point in the regressor buffer from which to pick the active coefficient set
constant set_index : integer := pointer_start
                                - select_integer(DECIM_RATE-1,0,
                                                 (fir_model_reqs.filter_type = c_polyphase_pq and INTERP_RATE>DECIM_RATE) or
                                                 fir_model_reqs.filter_type = c_polyphase_pq_dec_alt)
                                - select_integer(0,(properties.num_macs-1)*DECIM_RATE,--regressor_len-1-(properties.base_count),
                                                 fir_model_reqs.filter_type = c_transpose_single_rate or
                                                 fir_model_reqs.filter_type = c_transpose_decimating or
                                                 fir_model_reqs.filter_type = c_transpose_interpolating);

-- Specify the maximum number of pages to store reload data.  In the core, this is
-- just 2, as only one page is being used and one page loaded at any particular time,
-- but the switchover takes time and is distributed by rippling through the filter
-- along with the data.  The model switches instantaneously all at once, so the
-- number of pages stored by the model must be larger to allow for reloading of
-- coefficients during the interim period between load completion and switchover,
-- otherwise a subsequent reload in quick succession after the previous one might
-- end up overwriting the set currently in use.
constant reload_pointer_max : integer := 9*COEF_RELOAD;

-- Specify the length of the delay pipe for the reload set value
--constant reload_dly_len : integer := rdy_dly_len + properties.reload_lat;
constant reload_dly_len : integer := properties.reload_lat+3--;
                                     - select_integer(1,0,buff_in_depth=0);
                                     --when using input buffer it takes a cycle to
                                     --generate pop_ipbuff, this needs to be removed
                                     --from reload lat

--Used to indicate that the period of rfd will have to vary to generate the 
--appropriate input rate and processing time of the filter.
constant alter_input_rate:boolean:=(fir_model_reqs.filter_type=c_decimating_half_band) and
                                   (properties.base_count+properties.single_mac = properties.ipbuff_rate) and
                                   ((clks_per_samp_int*2)/fir_model_reqs.num_channels > (clks_per_samp_int/fir_model_reqs.num_channels)*2);

-------------------------------------------------------------------------------
-- TYPES - PART 2
-------------------------------------------------------------------------------

-- Coefficient storage types
type t_coefficients     is array (0 to   properties.full_taps-1) of integer;
type t_sets             is array (0 to             DECIM_RATE-1) of integer;
type t_reload_coeffs    is array (0 to properties.reload_taps-1) of std_logic_vector(COEF_WIDTH-1 downto 0);
type t_coefficients_slv is array (0 to properties.full_taps-1) of std_logic_vector(COEF_WIDTH-1 downto 0);
type t_split_coeff      is array (0 to                 cpages-1) of integer;
type t_coeff_pages      is array (0 to                 cpages-1) of t_coefficients;
type t_coeff_array      is array (0 to
                                  select_integer(
                                    NUM_FILTS,
                                    NUM_CHANNELS,
                                    fir_model_reqs.filter_type =c_channelizer_receiver or fir_model_reqs.filter_type =c_channelizer_transmitter)-1) of t_coeff_pages;
type t_reload_array     is array (0 to       reload_pointer_max) of t_coeff_array;

-- Data storage types
type t_data_type        is array (0 to                 dpages-1) of integer;
type t_data_paths       is array (0 to              NUM_PATHS-1) of t_data_type;
type t_input_buffer     is array (0 to          buff_in_depth-1) of t_data_type;
type t_ipbuff_array     is array (0 to                        3) of t_input_buffer;
type t_ipbuff_paths     is array (0 to              NUM_PATHS-1) of t_ipbuff_array;
type t_main_buffer      is array (0 to      main_buffer_depth-1) of t_data_type;
type t_main_buffer_int  is array (0 to      main_buffer_depth-1) of integer;
type t_buffer_array     is array (0 to           NUM_CHANNELS-1) of t_main_buffer;
type t_buffer_paths     is array (0 to              NUM_PATHS-1) of t_buffer_array;
type t_buffer_array_int is array (0 to           NUM_CHANNELS-1) of t_main_buffer_int;
type t_regressor        is array (0 to          regressor_len-1) of t_data_type;
type t_regressor_paths  is array (0 to              NUM_PATHS-1) of t_regressor;

-- Control types
type t_pointers         is array (0 to           NUM_CHANNELS-1) of integer;
type t_rdy_dly          is array (0 to            rdy_dly_len-1) of std_logic;
type t_reload_pointer   is array (0 to
                                  select_integer(
                                    NUM_FILTS,
                                    NUM_CHANNELS,
                                    fir_model_reqs.filter_type =c_channelizer_receiver or fir_model_reqs.filter_type =c_channelizer_transmitter)-1) of integer;

-- Reload matching delay types
type t_push_regressor_dly   is array (0 to     reload_dly_len-1) of boolean;
type t_filter_channel_dly   is array (0 to     reload_dly_len-1) of integer;
type t_filter_data_in_dly   is array (0 to     reload_dly_len-1) of t_data_paths;
type t_filter_fsel_dly      is array (0 to     reload_dly_len-1) of integer;
type t_ipbuff_channel1_dly  is array (0 to     reload_dly_len-1) of integer;
type t_ipbuff_data_out1_dly is array (0 to     reload_dly_len-1) of t_data_paths;
type t_ipbuff_fsel_out1_dly is array (0 to     reload_dly_len-1) of integer;

--Multi-paths types
type t_din_paths is array (0 to 15) of std_logic_vector(DATA_WIDTH-1 downto 0);
type t_result_paths is array (0 to NUM_PATHS-1) of std_logic_vector(OUTPUT_WIDTH-1 downto 0);

--Pipe delay for channelizer output when output buffer present.
--The delay is so the output is compatible with the FFT core
constant channelizer_delay: integer:=3;
type t_regout_dly is array (channelizer_delay downto 0) of t_result_paths;
type t_chan_out_dly is array (channelizer_delay downto 0) of std_logic_vector(CHAN_SEL_WIDTH-1 downto 0);


-------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Functions and types to calculate indexes of taps that contribue to the last
-- calculated value provided to the core's accumulator
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--num_last_value_indexes - calculates the number of taps that contribute to the
--                         last value added to the accumulator for each filter type
-------------------------------------------------------------------------------
function num_last_value_indexes ( reqs          : t_reqs;
                                  properties    : t_syst_mac_fir_properties ) return integer is
  variable num_indexes : integer;
begin
  case reqs.filter_type is
  when c_single_rate | c_channelizer_receiver | c_channelizer_transmitter  =>
    if properties.full_parallel=1 then
      if properties.symmetry=0 or properties.odd_symmetry=1 then
        return 1;
      else
        return 2;
      end if;
    else
      return (properties.num_macs*(2**properties.symmetry))
            -properties.odd_symmetry;
    end if;

  when c_polyphase_decimating =>
    num_indexes := (properties.num_macs*(2**properties.symmetry));
    --last result will be on 1st phase, only the last
    --phase looses a tap due to the odd symmetry
  
  when c_polyphase_interpolating =>
    
    if properties.full_parallel=1 then
      return 1;
    else
      return properties.num_macs;
    end if;

  when c_interpolating_symmetry =>
    if reqs.inter_rate=2 and odd_symmetry=1 then
      if properties.full_parallel=1 then
        return 2;
      else
        return properties.num_macs*(2**properties.symmetry);
      end if;
    else
      num_indexes := 1;
      --approximation not supported.
    end if;

  when c_hilbert_transform =>
    if properties.full_parallel=1 then
      return 2;
    else
      return properties.num_macs*(2**properties.symmetry);
    end if;

  when c_interpolated_transform =>
    if properties.full_parallel=1 then
      if  properties.symmetry=0 or properties.odd_symmetry=1 then
        return 1;
      else
        return 2;
      end if;
    else
      return (properties.num_macs*(2**properties.symmetry))-properties.odd_symmetry;
    end if;
  
  when c_halfband_transform|c_decimating_half_band =>
    if reqs.filter_type=c_halfband_transform and properties.full_parallel=1 then
      num_indexes := 1;
    elsif properties.single_mac=0 then
      num_indexes := (properties.num_macs*(2**properties.symmetry));
    else
      num_indexes := 1;
    end if;

  when c_interpolating_half_band =>
    num_indexes := (properties.num_macs*(2**properties.symmetry));
  
  when c_polyphase_pq =>
    if properties.full_parallel=1 and reqs.inter_rate>reqs.deci_rate then
      return 1;
    else
      return properties.num_macs;
    end if;
  
  when c_transpose_single_rate | c_transpose_decimating | c_transpose_interpolating =>
    return 1;
  when c_polyphase_pq_dec_alt =>
    --should never be fully parallel
    return properties.num_macs;
  when others =>
    report "FIR MODEL: unsupported filter type" severity failure;
    num_indexes := 1;
  end case;
  
  --report "<APPROX> NumIndexes = " & integer'image(num_indexes);
  return num_indexes;
  
end;

-------------------------------------------------------------------------------
--  t_last_value_indexes - this type is used to store the indexes of the taps
--                         that contribute to the last value added to the accumulator
-------------------------------------------------------------------------------
type t_last_value_indexes is
record
  phase : integer;
  list  : t_int_array( num_last_value_indexes(fir_model_reqs,properties)-1 downto 0);
end record;

-------------------------------------------------------------------------------
-- last_value_indexes_iterate - this function calculates the indexes of the last
--                              of the taps that contribute to the last value added
--                              to the accumulator
-------------------------------------------------------------------------------
function last_value_indexes_iterate ( reqs          : t_reqs;
                                      properties    : t_syst_mac_fir_properties;
                                      last_indexes  : t_last_value_indexes ) return t_last_value_indexes is
  variable indexes: t_last_value_indexes:=last_indexes;
  variable index_count: integer;
begin

  case reqs.filter_type is
  
  when c_single_rate | c_interpolated_transform | c_channelizer_receiver | c_channelizer_transmitter  =>
    if properties.full_parallel=1 then
      if properties.symmetry=0 or properties.odd_symmetry=1 then
        indexes.list(0):=properties.num_macs-1;
      else
        indexes.list(0):=properties.num_macs-1;
        indexes.list(1):=properties.num_macs;
      end if;
    else
      index_count:=properties.base_count-1;
      for i in 0 to indexes.list'HIGH loop
        indexes.list(i):=index_count;
        if properties.symmetry=1 and i=indexes.list'HIGH/2 then
          if properties.odd_symmetry=1 then
            index_count:=index_count+properties.base_count;
          else
            index_count:=index_count+1;
          end if;
        else
          index_count:=index_count+properties.base_count;
        end if;
      end loop;
    end if;

  when c_polyphase_decimating =>
    index_count:=(properties.base_count-1)*properties.deci_rate;
    for i in 0 to indexes.list'HIGH loop
      indexes.list(i):=index_count;
      if properties.symmetry=1 and i=indexes.list'HIGH/2 then
        if properties.odd_symmetry=1 then
          index_count:=index_count+((2*properties.deci_rate)-2);
        else
          index_count:=index_count+((2*properties.deci_rate)-1);
        end if;
      else
        index_count:=index_count+(properties.base_count*properties.deci_rate);
      end if;
    end loop;

  when c_polyphase_interpolating =>

    if indexes.phase/=properties.inter_rate-1 then
      indexes.phase:=indexes.phase+1;
    else
      indexes.phase:=0;
    end if;

    if properties.full_parallel=1 then
      indexes.list(0):=((properties.num_macs-1)*properties.inter_rate)+indexes.phase;
    else
      index_count:=((properties.base_count-1)*properties.inter_rate)+indexes.phase;
      for i in 0 to indexes.list'HIGH loop
        indexes.list(i):=index_count;
        index_count:=index_count+(properties.base_count*properties.inter_rate);
      end loop;
    end if;

  when c_interpolating_symmetry =>
    if (reqs.inter_rate=2 and odd_symmetry=1) then
      if indexes.phase/=properties.inter_rate-1 then
        indexes.phase:=indexes.phase+1;
      else
        indexes.phase:=0;
      end if;

      if properties.full_parallel=1 then
        if indexes.phase=0 then
          indexes.list(0):=(properties.num_macs-1)*2;
          indexes.list(1):=((properties.num_macs-1)*2)+2;
        else
          indexes.list(0):=((properties.num_macs-1)*2)+1;
          indexes.list(1):=properties.actual_taps*2;--need a location that will contain a zero coefficient
        end if;
      else
        index_count:=((properties.base_count-1)*properties.inter_rate)+indexes.phase;
        for i in 0 to indexes.list'HIGH loop
          indexes.list(i):=index_count;
  
          if i=indexes.list'HIGH/2 then
            if indexes.phase=0 then
              index_count:=index_count+2;
            else
              index_count:=index_count+(properties.base_count*properties.inter_rate);
            end if;
          else
            index_count:=index_count+(properties.base_count*properties.inter_rate);
          end if;
        end loop;
      end if;
    end if;

  when c_hilbert_transform =>
    if properties.full_parallel=1 then
      indexes.list(0):=(properties.num_macs-1)*2;
      indexes.list(1):=((properties.num_macs-1)*2)+2;
    else
      index_count:=2*properties.base_count-2;
      for i in 0 to indexes.list'HIGH loop
        indexes.list(i):=index_count;
        if i=indexes.list'HIGH/2 then
          index_count:=index_count+2;
        else
          index_count:=index_count+(2*properties.base_count);
        end if;
      end loop;
    end if;
  
  --when c_interpolated_transform =>
  when c_halfband_transform | c_decimating_half_band =>
    if reqs.filter_type=c_halfband_transform and properties.full_parallel=1 then
      indexes.list(0):=2*properties.num_macs-1;
    elsif properties.single_mac=0 then
      index_count:=2*properties.base_count-2;
      for i in 0 to indexes.list'HIGH loop
        indexes.list(i):=index_count;
        if i=indexes.list'HIGH/2 then
          index_count:=index_count+2;
        else
          index_count:=index_count+(2*properties.base_count);
        end if;
      end loop;
    else
      if reqs.filter_type=c_halfband_transform then
        indexes.list(0):=2*properties.base_count-3;
      else
        indexes.list(0):=2*properties.base_count-1;
      end if;
    end if;
  
  when c_interpolating_half_band =>
    if indexes.phase=0 then
      indexes.phase:=1;
      index_count:=2*properties.base_count-1;
      --on this phase pickup the zero values as the
      --centre tap won't be approximated it will be
      --the correct rounding.
    else
      indexes.phase:=0;
      index_count:=2*properties.base_count-2;
    end if;

    for i in 0 to indexes.list'HIGH loop
      if indexes.phase=1 and 
         (i=indexes.list'HIGH/2 or i=indexes.list'HIGH) then
        --overide as will pickup centre tap and want to avoid
        indexes.list(i):=2*properties.base_count-1;
      else
        indexes.list(i):=index_count;
      end if;

      if i=indexes.list'HIGH/2 then
        if indexes.phase=0 then
          index_count:=index_count+2;
        else
          --reset index count so pickup zeros again
          index_count:=2*properties.base_count-1;
        end if;
      else
        index_count:=index_count+(2*properties.base_count);
      end if;
    end loop;

  when c_polyphase_pq =>
    if reqs.inter_rate>reqs.deci_rate then
      --interpolation
      indexes.phase:=(indexes.phase+reqs.deci_rate) mod reqs.inter_rate;

      if properties.full_parallel=1 then
        indexes.list(0):=((properties.num_macs-1)*properties.inter_rate)+indexes.phase;
      else
        index_count:=((properties.base_count-1)*properties.inter_rate)+indexes.phase;
        for i in 0 to indexes.list'HIGH loop
          indexes.list(i):=index_count;
          index_count:=index_count+(properties.base_count*properties.inter_rate);
        end loop;
      end if;
    else
      --decimation
      indexes.phase:=(indexes.phase+1) mod reqs.inter_rate;

      index_count:= (indexes.phase*reqs.deci_rate)+( (properties.base_count-1)*reqs.inter_rate*reqs.deci_rate);
      for i in 0 to indexes.list'HIGH loop
        indexes.list(i):=index_count;
        index_count:=index_count+(properties.base_count*reqs.inter_rate*reqs.deci_rate);
      end loop;

    end if;
  when c_transpose_single_rate =>
    indexes.list(0):=properties.num_macs*(properties.base_count-1);
  when c_transpose_decimating =>
    indexes.list(0):=(properties.num_macs*properties.deci_rate*(properties.base_count-1));
  when c_transpose_interpolating =>
    if indexes.phase/=properties.inter_rate-1 then
      indexes.phase:=indexes.phase+1;
    else
      indexes.phase:=0;
    end if;
    
    indexes.list(0):=(properties.num_macs*properties.inter_rate*(properties.base_count-1))+indexes.phase;
  when c_polyphase_pq_dec_alt =>
    --!!!!! this is wrong !!!! to predict which phase will be computed
    indexes.phase:=(indexes.phase-1) mod reqs.inter_rate;
    
    index_count:=((properties.base_count-1)*properties.inter_rate)+indexes.phase;
    for i in 0 to indexes.list'HIGH loop
      indexes.list(i):=index_count;
      index_count:=index_count+(properties.base_count*properties.inter_rate);
    end loop;
  when others =>
    report "FIR MODEL: unsupported filter type" severity failure;
  end case;
  
  -- for i in 0 to indexes.list'HIGH loop
  --   report "<APPROX> LastIndex[" & integer'image(i) & "] = " & integer'image(indexes.list(i));
  -- end loop;
  
  return indexes;
  
end;

-------------------------------------------------------------------------------
-- last_value_indexes - wraps last_value_indexes_iterate so it can be called
--                      at a signal declaration. It sets the intial phase value
--                      for structures where the indexes changes for each phase output
-------------------------------------------------------------------------------
function last_value_indexes ( reqs          : t_reqs;
                              properties    : t_syst_mac_fir_properties ) return t_last_value_indexes is
  variable indexes: t_last_value_indexes;
  variable pq_deci_interations,
           pq_deci_phase_step,
           pq_deci_phase : integer:=0;
begin
  if reqs.filter_type=c_polyphase_pq_dec_alt then
    indexes.phase:=(reqs.deci_rate-1) mod reqs.inter_rate;
    --!!!!!!!!!!! this is wrong !!!!!!!!!!!!!
  elsif reqs.filter_type=c_polyphase_pq then
    if reqs.inter_rate>reqs.deci_rate then
      --interpolation
      indexes.phase:=(-1*reqs.deci_rate) mod reqs.inter_rate;
    else
      --decimation
      --this is taken from the reordering
      --done in the gen_mif function but simplified.

      --calculate the step to be applied to pq_deci_phase
      while pq_deci_interations/=1 loop
        pq_deci_interations:=(pq_deci_interations+reqs.inter_rate) mod reqs.deci_rate;
        pq_deci_phase_step:=pq_deci_phase_step+1;
      end loop;
      
      --report "FIR MODEL: determining pq deci state phase, pq_deci_phase_step: "&int_to_str(pq_deci_phase_step);

      for phase in 0 to reqs.deci_rate-1 loop
        if phase mod reqs.inter_rate = 0  then
          pq_deci_phase:=0;
        else
          pq_deci_phase:=(pq_deci_phase+pq_deci_phase_step) mod reqs.deci_rate;
        end if;
        --report "FIR MODEL: determining pq deci state phase, pq_deci_phase: "&int_to_str(pq_deci_phase);
      end loop;

      if pq_deci_phase=0 then
        indexes.phase:=0;
      else
        indexes.phase:=reqs.inter_rate - ( (pq_deci_phase*reqs.inter_rate)/reqs.deci_rate );
      end if;

      --report "FIR MODEL: determining pq deci state phase, phase: "&int_to_str(indexes.phase);
      --offset by one output iteration as  last_value_indexes_irate will increment
      --it before it uses its value
      indexes.phase:=(indexes.phase-1) mod reqs.inter_rate;
    end if;
  else
    indexes.phase:=reqs.inter_rate-1;
  end if;
  
  --call interate function to populate .list parameter.
  return last_value_indexes_iterate( reqs,properties,indexes);
end;

-------------------------------------------------------------------------------
-- Integer-based rounding function
-------------------------------------------------------------------------------
function rounding ( acc, accum_width, output_width, round_mode, acc_last_ip : integer;
                    use_approx : boolean
                  ) return integer is

  variable result       : integer := 0;
  variable midpoint     : boolean := false;
  constant half         : integer := 2**(get_max(0,(accum_width-output_width-1)));
  constant one          : integer := 2*half;
  variable last_ip      : integer := acc_last_ip;
  variable decision_acc : integer := acc;
begin

  if use_approx then
    decision_acc := acc - last_ip + (half-1);
  end if;
  --report "Using last acc input value of " & integer'image(last_ip);
  
  --report "<ROUND> Accum              = " & integer'image(acc);
  --report "<ROUND> Accum/one          = " & integer'image(acc/one);
  --report "<ROUND> Accum/half         = " & integer'image(acc/half);
  --report "<ROUND> Accum/half rem 2   = " & integer'image((acc/half) rem 2);
  --report "<ROUND> (Accum+half)/one   = " & integer'image((acc+half)/one);
  case round_mode is
    when c_full_precision      => result := acc;
    when c_truncate_lsbs       => if ( acc < 0 ) then  result := (acc-one +1)/one ;
                                  else                 result := (acc       )/one ;
                                  end if;
    when c_non_symmetric_down  => if ( acc < 0 ) then  result := (acc-half  )/one ;
                                  else                 result := (acc+half-1)/one ;
                                  end if;
    when c_non_symmetric_up    => if ( acc < 0 ) then  result := (acc-half+1)/one ;
                                  else                 result := (acc+half  )/one ;
                                  end if;
    when c_symmetric_zero      => if ( decision_acc < 0 ) then
                                    --if use_approx then report "DecisionAcc="&integer'image(decision_acc)&",Last="&integer'image(last_ip)&",ApproxCIN=1"; end if;
                                    if ( acc < 0 ) then  result := (acc-half+1)/one ;
                                    else                 result := (acc+half  )/one ;
                                    end if;
                                  else
                                    --if use_approx then report "DecisionAcc="&integer'image(decision_acc)&",Last="&integer'image(last_ip)&",ApproxCIN=0"; end if;
                                    if ( acc < 0 ) then  result := (acc-half  )/one ;
                                    else                 result := (acc+half-1)/one ;
                                    end if;
                                  end if;
    when c_symmetric_inf       => if ( decision_acc < 0 ) then
                                    --if use_approx then report "DecisionAcc="&integer'image(decision_acc)&",Last="&integer'image(last_ip)&",ApproxCIN=0"; end if;
                                    if ( acc < 0 ) then  result := (acc-half  )/one ;
                                    else                 result := (acc+half-1)/one ;
                                    end if;
                                  else
                                    --if use_approx then report "DecisionAcc="&integer'image(decision_acc)&",Last="&integer'image(last_ip)&",ApproxCIN=1"; end if;
                                    if ( acc < 0 ) then  result := (acc-half+1)/one ;
                                    else                 result := (acc+half  )/one ;
                                    end if;
                                  end if;
    when c_convergent_even     => midpoint := (acc mod one) = half;
                                  if ( acc < 0 ) then  result := (acc-half+1)/one ;
                                  else                 result := (acc+half  )/one ;
                                  end if;
                                  if midpoint and (result mod 2) = 1 then
                                    result := result-1;
                                  end if;
    when c_convergent_odd      => midpoint := (acc mod one) = half;
                                  if ( acc < 0 ) then  result := (acc-half  )/one ;
                                  else                 result := (acc+half-1)/one ;
                                  end if;
                                  if midpoint and (result mod 2) = 0 then
                                    result := result+1;
                                  end if;
    when others                => report "WARNING: FIR Compiler v4.0: Unsupported rounding mode specified!" severity warning;
  end case;
  
  --report "<ROUND> Accum Rounded = " & integer'image(result);
  return result;

end; -- fir


-------------------------------------------------------------------------------
-- Unsigned rounding function
-------------------------------------------------------------------------------
function rounding ( acc : unsigned; 
                    accum_width, result_width, round_mode : integer;
                    acc_last_ip : unsigned;
                    use_approx : boolean
                  ) return unsigned is

  variable acc_temp     : unsigned( accum_width-1 downto 0) := (others=>'0');
  variable result       : unsigned(result_width-1 downto 0) := (others=>'0');
  variable half         : unsigned( accum_width-1 downto 0) := (others=>'0');
  variable one          : unsigned( accum_width-1 downto 0) := (others=>'0');
  variable midpoint     : boolean := false;
  variable decision_acc : unsigned( accum_width-1 downto 0) := acc;
begin
  
  if accum_width-result_width>0 then
    half(accum_width-result_width-1):='1';
    one (accum_width-result_width)  :='1';
  end if;

  if use_approx then
    decision_acc := acc - acc_last_ip + (half-1);
  end if;

  --report "<ROUND> Accum         = " & int_to_string(to_integer(acc));
  case round_mode is
    when c_full_precision      => result   := acc;
    when c_truncate_lsbs       => result   := acc(accum_width-1 downto accum_width-result_width);
    when c_non_symmetric_down  => acc_temp := acc + half - 1;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_non_symmetric_up    => acc_temp := acc + half ;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_symmetric_zero      => acc_temp := acc + half - 1 + select_integer(0,1,decision_acc(accum_width-1)='1');
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_symmetric_inf       => acc_temp := acc + half - 1 + select_integer(0,1,decision_acc(accum_width-1)='0');
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_convergent_even     => midpoint := (acc mod one) = half;
                                  acc_temp := acc + half ;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
                                  if midpoint then
                                    result(0) := '0';
                                  end if;
    when c_convergent_odd      => midpoint := (acc mod one) = half;
                                  acc_temp := acc + half -1;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
                                  if midpoint then
                                    result(0) := '1';
                                  end if;
    when others                => report "WARNING: FIR Compiler v4.0: Unsupported rounding mode specified!" severity warning;
  end case;
  
  --report "<ROUND> Rounded Accum = " & int_to_string(to_integer(result));
  return result;
  
end; -- rounding(unsigned) 


-------------------------------------------------------------------------------
-- Signed rounding function
-------------------------------------------------------------------------------
function rounding ( acc : signed; 
                    accum_width, result_width, round_mode : integer;
                    acc_last_ip : signed;
                    use_approx : boolean
                  ) return signed is

  variable acc_temp     : signed( accum_width-1 downto 0) := acc;
  variable result       : signed(result_width-1 downto 0) := (others=>'0');
  variable half         : signed( accum_width-1 downto 0) := (others=>'0');
  variable one          : signed( accum_width-1 downto 0) := (others=>'0');
  variable midpoint     : boolean := false;
  variable decision_acc : signed( accum_width-1 downto 0) := acc;
begin
  if accum_width-result_width>0 then
    half(accum_width-result_width-1):='1';
    one (accum_width-result_width)  :='1';
  end if;

  if use_approx then
    decision_acc := acc - acc_last_ip + (half-1);
  end if;
  --report "<ROUND> Accum         = " & int_to_string(to_integer(acc));
  case round_mode is
    when c_full_precision      => result   := acc_temp;
    when c_truncate_lsbs       => result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_non_symmetric_down  => acc_temp := acc + half - 1;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_non_symmetric_up    => acc_temp := acc + half ;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_symmetric_zero      => acc_temp := acc + half - 1 + select_integer(0,1,decision_acc(accum_width-1)='1');
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_symmetric_inf       => acc_temp := acc + half - 1 + select_integer(0,1,decision_acc(accum_width-1)='0');
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
    when c_convergent_even     => midpoint := (acc mod one) = half;
                                  acc_temp := acc + half ;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
                                  if midpoint then
                                    result(0) := '0';
                                  end if;
    when c_convergent_odd      => midpoint := (acc mod one) = half;
                                  acc_temp := acc + half - 1 ;
                                  result   := acc_temp(accum_width-1 downto accum_width-result_width);
                                  if midpoint then
                                    result(0) := '1';
                                  end if;
    when others                => report "WARNING: FIR Compiler v4.0: Unsupported rounding mode specified!" severity warning;
  end case;
  
  --report "<ROUND> Rounded Accum = " & int_to_string(to_integer(result));
  return result;

end; -- rounding(signed)


-------------------------------------------------------------------------------
-- BASIC FIR FUNCTION WITH INTEGER OUTPUT
-- Used when result width is representable as an integer
-------------------------------------------------------------------------------
function fir ( c            : t_coefficients;
               d            : t_regressor;
               dpage        : integer;
               taps,
               zpf          : integer;
               round        : boolean:=false;
               last_indexes : t_last_value_indexes:=(phase=>0,list=>(others=>0));
               use_indexes  : boolean:=false
             ) return integer is

  variable acc         : integer := 0;
  variable acc_last_ip : integer := 0;
  variable temp        : integer := 0;
begin

  if not use_indexes then
    for i in 0 to (taps-1) loop
      acc := acc + d(i*zpf)(dpage) * c(taps-1-i);
    end loop;
  else
    for i in 0 to last_indexes.list'HIGH loop
      if last_indexes.list(i) <= c'HIGH then
        acc := acc + c(last_indexes.list(i)) * d((taps-1-last_indexes.list(i))*zpf)(dpage);
      end if;
    end loop;
  end if;

  if round then
    if properties.use_approx then
      acc_last_ip := fir(c,d,dpage,taps,zpf,false,last_indexes,true);
    end if;
    -- report "FIR MODEL: last accum input: "&integer'image(acc_last_ip);
    temp := rounding ( acc, ACCUM_WIDTH, OUTPUT_WIDTH, ROUND_MODE, acc_last_ip, properties.use_approx );
    -- report "FIR MODEL: final rounded output: "&integer'image(temp);
    return temp;
  else
    return acc;
  end if;

end; -- fir 


-------------------------------------------------------------------------------
-- FIR FUNCTION WITH UNSIGNED OUTPUT & OVERFLOW
-- Used when result width is larger than maximum representable integer width
-- A positive overflow integer is used to track the total value
-------------------------------------------------------------------------------
function fir_ovfl_unsigned ( c            : t_coefficients;
                             d            : t_regressor;
                             dpage        : integer;
                             taps,
                             zpf,
                             accum_width : integer;
                             last_indexes : t_last_value_indexes:=(phase=>0,list=>(others=>0));
                             use_indexes  : boolean:=false
                           ) return unsigned is
             
  variable inc      : natural  := 0;
  variable acc      : natural  := 0;
  variable acc_ovfl : natural  := 0;
  variable result   : unsigned(accum_width-1 downto 0) := (others=>'0');

begin

  --report "ACCUM_WIDTH = " & integer'image(accum_width);
  --report "SHIFT_BY     = " & integer'image(shift_by);
  if not use_indexes then
    for i in 0 to (taps-1) loop

      inc := d(i*zpf)(dpage) * c(taps-1-i);

      if inc>(maxint-acc) then   -- OVERFLOW
        acc      := acc+inc-(maxint+1);
        acc_ovfl := acc_ovfl+1;
        --report "Accumulator Overflow!!!   acc_ovfl = " & int_to_string(acc_ovfl);

      else                       -- NORMAL ACC
        acc := acc+inc;
      end if;

    end loop;
  else
    for i in 0 to last_indexes.list'HIGH loop
      if last_indexes.list(i) <= c'HIGH then

        inc := c(last_indexes.list(i)) * d((taps-1-last_indexes.list(i))*zpf)(dpage);--d(i*zpf) * c(taps-1-i);
        
        if inc>(maxint-acc) then   -- OVERFLOW
          acc      := acc+inc-(maxint+1);
          acc_ovfl := acc_ovfl+1;
          --report "Accumulator Overflow!!!   acc_ovfl = " & int_to_string(acc_ovfl);
    
        else                       -- NORMAL ACC
          acc := acc+inc;
        end if;

      end if;
    end loop;
  end if;

  -- if (accum_width>max_int_width) then
    result((max_int_width-1)-1 downto 0)           := to_unsigned(acc, (max_int_width-1));
    result(accum_width-1 downto (max_int_width-1)) := to_unsigned(acc_ovfl, accum_width-(max_int_width-1));
  -- else
  --   result(accum_width-1 downto shift_by) := to_unsigned(acc, accum_width-shift_by);
  -- end if;

  return result;

  --return to_unsigned(acc_ovfl, accum_width-(max_int_width-1)-shift_by) & to_unsigned(acc, (max_int_width-1)) & padding;

end; -- fir_ovfl_unsigned


-------------------------------------------------------------------------------
-- FIR FUNCTION WITH SIGNED OUTPUT & OVERFLOW & UNDERFLOW
-- Used when result width is larger than maximum representable integer width
-- A signed overflow/underflow integer is used to track the total value
-------------------------------------------------------------------------------
function fir_ovfl_signed ( c            : t_coefficients;
                           d            : t_regressor;
                           dpage        : integer;
                           taps,
                           zpf,
                           accum_width : integer;
                           last_indexes : t_last_value_indexes:=(phase=>0,list=>(others=>0));
                           use_indexes  : boolean:=false
                         ) return signed is

  variable inc      : integer  := 0;
  variable acc      : natural := 0;
  variable acc_ovfl : integer  := 0;
  variable result   : signed(accum_width-1 downto 0) := (others=>'0');

begin
  
  --report "ACCUM_WIDTH = " & integer'image(accum_width);
  if not use_indexes then
    for i in 0 to (taps-1) loop
      --report "Data  = " & integer'image(d(i*zpf));
      --report "Coeff = " & integer'image(c(taps-1-i));
      inc  := d(i*zpf)(dpage) * c(taps-1-i);
      --report "PP    = " & integer'image(inc);
  
      if inc>(maxint-acc) then   -- OVERFLOW
        acc      := acc+inc-(maxint+1);
        acc_ovfl := acc_ovfl+1;
        -- report "Positive Overflow!!!   acc_ovfl = " & int_to_string(acc_ovfl);
  
      elsif (acc+inc)<0 then     -- UNDERFLOW
        acc      := acc+inc+(maxint+1);
        acc_ovfl := acc_ovfl-1;
        -- report "Negative overflow!!!   acc_ovfl = " & int_to_string(acc_ovfl);
  
      else                       -- NORMAL ACC
        acc := acc+inc;
      end if;
  
    end loop;
  else
    for i in 0 to last_indexes.list'HIGH loop
      if last_indexes.list(i) <= c'HIGH then

        --report "Data  = " & integer'image(d(i*zpf));
        --report "Coeff = " & integer'image(c(taps-1-i));
        inc  := c(last_indexes.list(i)) * d((taps-1-last_indexes.list(i))*zpf)(dpage);--d(i*zpf) * c(taps-1-i);
        --report "PP    = " & integer'image(inc);
  
        if inc>(maxint-acc) then   -- OVERFLOW
          acc      := acc+inc-(maxint+1);
          acc_ovfl := acc_ovfl+1;
          --report "Positive Overflow!!!   acc_ovfl = " & int_to_string(acc_ovfl);

        elsif (acc+inc)<0 then     -- UNDERFLOW
          acc      := acc+inc+(maxint+1);
          acc_ovfl := acc_ovfl-1;
          --report "Negative overflow!!!   acc_ovfl = " & int_to_string(acc_ovfl);

        else                       -- NORMAL ACC
          acc := acc+inc;
        end if;
      end if;
    end loop;

  end if;

  --report "Acc    = " & integer'image(acc);
  --report "ResW   = " & integer'image(result_width);
  --report "Shift  = " & integer'image(shift_by);

    result((max_int_width-1)-1 downto 0)           := signed(to_unsigned(acc, (max_int_width-1)));
    result(accum_width-1 downto (max_int_width-1)) := to_signed(acc_ovfl, accum_width-(max_int_width-1));

  return result;

end; -- fir_ovfl_signed


-------------------------------------------------------------------------------
-- FIR FUNCTION WITH UNSIGNED OUTPUT & SPLIT COEFFICIENTS
-- Used to wrap the fir or overflow fir functions.  Produces interim results from
-- each of the coefficient pages and then adds these results in a weighted
-- manner (as std_logic_vectors) such that the overall result is correct.
-------------------------------------------------------------------------------
function split_fir_unsigned ( c            : t_coeff_pages;
                              d            : t_regressor;
                              dpages,
                              cpages,
                              taps,
                              zpf,
                              coef_width,
                              split_cwidth,
                              split_dwidth,
                              accum_width,
                              result_width : integer;
                              round : boolean := false;
                              last_indexes : t_last_value_indexes:=(phase=>0,list=>(others=>0));
                              use_indexes: boolean:=false
                            ) return unsigned is
  
  variable inc1         : unsigned( accum_width-1 downto 0) := (others=>'0');
  variable inc2         : unsigned( accum_width-1 downto 0) := (others=>'0');
  variable acc          : unsigned( accum_width-1 downto 0) := (others=>'0');
  variable result       : unsigned(result_width-1 downto 0) := (others=>'0');
  variable read_width   : integer := split_cwidth;
  variable remaining    : integer := coef_width;
  variable acc_last_ip  : unsigned( accum_width-1 downto 0) := (others=>'0');
  variable d_weighting  : integer:=0;
begin

  for j in 0 to dpages-1 loop
    read_width := split_cwidth;
    remaining  := coef_width;
    for i in 0 to cpages-1 loop
      --report "Calculating Split " & integer'image(i);
      read_width := get_min(split_cwidth,remaining);
      --report "Shifting left by " & integer'image(coef_width-remaining) & " places.";
      if (accum_width>coef_width-remaining+max_int_width-(DATA_TYPE*COEF_TYPE)) then
        --report "Running split overflow unsigned FIR";
        inc1 := fir_ovfl_unsigned ( c(i), d, j, taps, zpf, accum_width, last_indexes, use_indexes );
        inc2 := (others=>'0');
        inc2(accum_width-1 downto coef_width-remaining) := inc1(accum_width-1-(coef_width-remaining) downto 0) ;
        inc2(accum_width-1 downto d_weighting):=inc2(accum_width-1-d_weighting downto 0);
        inc2(d_weighting-1 downto 0):=(others=>'0');
      else
        --report "Running split integer unsigned FIR";
        inc1 := to_unsigned( fir( c(i), d, j, taps, zpf, false, last_indexes ,use_indexes) , accum_width );
        inc2 := (others=>'0');
        inc2(accum_width-1 downto coef_width-remaining) := inc1(accum_width-1-(coef_width-remaining) downto 0) ;
        inc2(accum_width-1 downto d_weighting):=inc2(accum_width-1-d_weighting downto 0);
        inc2(d_weighting-1 downto 0):=(others=>'0');
      end if;
--       report "Unshifted partial result for page " & integer'image(i) & " === " & slv_to_string(std_logic_vector(inc1),accum_width);
--       report "  Shifted partial result for page " & integer'image(i) & " === " & slv_to_string(std_logic_vector(inc2),accum_width);
      acc := acc + inc2;
--       report "Accumulated result                " & " "              & " === " & slv_to_string(std_logic_vector(acc),accum_width);
      remaining := remaining - read_width;
    end loop;
    d_weighting:=d_weighting+split_dwidth;
  end loop;

  if round then
    if properties.use_approx then
      acc_last_ip := split_fir_unsigned(c,d,dpages,cpages,taps,zpf,coef_width,split_cwidth,split_dwidth,accum_width,accum_width,false,last_indexes,true);
    end if;
    result := rounding ( acc, accum_width, result_width, ROUND_MODE, acc_last_ip, properties.use_approx  );
  else
    result := acc;
  end if;
  --report "Rounded result          " & " "              & " === " & UTILS_PKG_slv_to_string(std_logic_vector(result),result_width);
  
  return result;

end; -- split_fir_unsigned 


-------------------------------------------------------------------------------
-- FIR FUNCTION WITH SIGNED OUTPUT & SPLIT COEFFICIENTS
-- Used to wrap the fir or overflow fir functions.  Produces interim results from
-- each of the coefficient pages and then adds these results in a weighted
-- manner (as std_logic_vectors) such that the overall result is correct.
-------------------------------------------------------------------------------
function split_fir_signed ( c            : t_coeff_pages;
                            d            : t_regressor;
                            dpages,
                            cpages,
                            taps,
                            zpf,
                            coef_width,
                            split_cwidth,
                            split_dwidth,
                            accum_width,
                            result_width : integer;
                            round : boolean := false;
                            last_indexes : t_last_value_indexes:=(phase=>0,list=>(others=>0));
                            use_indexes: boolean:=false
                          ) return signed is
  
  variable inc1         : signed( accum_width-1 downto 0) := (others=>'0');
  variable inc2         : signed( accum_width-1 downto 0) := (others=>'0');
  variable acc          : signed( accum_width-1 downto 0) := (others=>'0');
  variable result       : signed(result_width-1 downto 0) := (others=>'0');
  variable read_width   : integer := split_cwidth;
  variable remaining    : integer := coef_width;
  variable acc_last_ip  : signed( accum_width-1 downto 0) := (others=>'0');
  variable d_weighting  : integer:=0;
begin

  for j in 0 to dpages-1 loop
    read_width := split_cwidth;
    remaining  := coef_width;
    for i in 0 to cpages-1 loop
      --report "Calculating Split " & integer'image(i);
      read_width := get_min(split_cwidth,remaining);
      --report "Shifting left by " & integer'image(coef_width-remaining) & " places.";
      if (accum_width>coef_width-remaining+max_int_width-(DATA_TYPE*COEF_TYPE)) then
--         report "Running split overflow signed FIR";
        inc1 := fir_ovfl_signed ( c(i), d, j, taps, zpf, accum_width, last_indexes, use_indexes  );
        inc2 := (others=>'0');
        inc2(accum_width-1 downto coef_width-remaining) := inc1(accum_width-1-(coef_width-remaining) downto 0) ;
        inc2(accum_width-1 downto d_weighting):=inc2(accum_width-1-d_weighting downto 0);
        inc2(d_weighting-1 downto 0):=(others=>'0');
      else
--         report "Running split integer signed FIR";
        inc1 := to_signed( fir( c(i), d, j, taps, zpf, false, last_indexes, use_indexes ) , accum_width );
        inc2 := (others=>'0');
        inc2(accum_width-1 downto coef_width-remaining) := inc1(accum_width-1-(coef_width-remaining) downto 0) ;
        inc2(accum_width-1 downto d_weighting):=inc2(accum_width-1-d_weighting downto 0);
        inc2(d_weighting-1 downto 0):=(others=>'0');
      end if;
--       report "Unshifted partial result for page " & integer'image(i) & " === " & slv_to_string(std_logic_vector(inc1),accum_width);
--       report "  Shifted partial result for page " & integer'image(i) & " === " & slv_to_string(std_logic_vector(inc2),accum_width);
--       report "Data weighting: "&int_to_str(d_weighting);
      acc := acc + inc2;
--       report "Accumulated result                " & " "              & " === " & slv_to_string(std_logic_vector(acc),accum_width);
      remaining := remaining - read_width;
    end loop;
    d_weighting:=d_weighting+split_dwidth;
  end loop;

  if round then
    if properties.use_approx then
      acc_last_ip := split_fir_signed(c,d,dpages,cpages,taps,zpf,coef_width,split_cwidth,split_dwidth,accum_width,accum_width,false,last_indexes,true);
    end if;
    result := rounding ( acc, accum_width, result_width, ROUND_MODE, acc_last_ip, properties.use_approx );
  else
    result := acc;
  end if;
  --report "Rounded result          " & " "              & " === " & UTILS_PKG_slv_to_string(std_logic_vector(result),result_width);

  return result;

end; -- split_fir_signed 

-------------------------------------------------------------------------------
--Functions to determine if a reload page update should occur, needed in two
--places
-------------------------------------------------------------------------------
type t_reload_status is
record
  reload_pntr_update   : t_reload_pointer;
  phase_count          : integer;
  interpolation_phases : integer;
  pq_int_idle          : boolean;
  pq_int_px_cnt        : integer;
end record;

function reload_status_init return t_reload_status is
  variable reload_status:t_reload_status;
begin
  reload_status.reload_pntr_update    :=(others=>0);
  --this is for use with pq decimation and coefficient reload.
  reload_status.phase_count           :=0;
  reload_status.interpolation_phases  :=2;
  --needs an initial value that will cause a snap-shot of the reload
  --pointers on first samples
  reload_status.pq_int_idle           :=false;
  reload_status.pq_int_px_cnt         :=((properties.clk_per_chan*DECIM_RATE)/INTERP_RATE)*reload_status.interpolation_phases*NUM_CHANNELS;

  return reload_status;
end;

function update_filter_page( reload_status_in   :t_reload_status;
                             push_regressor_rld : boolean;
                             filter_channel_rld : integer;
                             reload_pntr,
                             reload_pntr_current: t_reload_pointer;
                             coef_ld : std_logic;
                             coef_filter_sel,
                             filter_fsel_rld: integer ) return t_reload_status is
  variable reload_status:t_reload_status:=reload_status_in;
begin
  
  if push_regressor_rld then
    if (fir_model_reqs.filter_type =  c_polyphase_pq and INTERP_RATE<DECIM_RATE) or
       fir_model_reqs.filter_type =  c_polyphase_decimating or
       fir_model_reqs.filter_type =  c_transpose_decimating then

      if filter_channel_rld=0 then
        if reload_status.phase_count=0 then
          reload_status.reload_pntr_update:=reload_pntr;
        else
          reload_status.reload_pntr_update:=reload_pntr_current;
        end if;
      end if;

      if filter_channel_rld=NUM_CHANNELS-1 then
        if reload_status.phase_count=DECIM_RATE-1 then
          reload_status.phase_count:=0;
        else
          reload_status.phase_count:=reload_status.phase_count+1;
        end if;
      end if;
    elsif  fir_model_reqs.filter_type =  c_polyphase_pq and NUM_CHANNELS>1 then
      --pq interpolation, by default
      if filter_channel_rld=0 then
        if reload_status.interpolation_phases>1 or reload_status.pq_int_idle then
          reload_status.reload_pntr_update:=reload_pntr;
        elsif reload_status.interpolation_phases=1 then
          reload_status.reload_pntr_update:=reload_status.reload_pntr_update;
        end if;
        reload_status.pq_int_px_cnt:=0;
        reload_status.pq_int_idle:=false;
      end if;

      if filter_channel_rld=0 then

        reload_status.interpolation_phases:=((INTERP_RATE-reload_status.phase_count)/DECIM_RATE)
                                            +select_integer(0,1,(INTERP_RATE-reload_status.phase_count) rem DECIM_RATE>0);

        reload_status.phase_count:=(reload_status.phase_count+(reload_status.interpolation_phases*DECIM_RATE)) mod INTERP_RATE;
      end if;

    elsif  fir_model_reqs.filter_type =  c_polyphase_interpolating then -- or
           -- fir_model_reqs.filter_type =  c_polyphase_pq_dec_alt then
      if filter_channel_rld=0 then
        reload_status.reload_pntr_update:=reload_pntr;
      end if;
    else
      -- report "-----> FIR MODEL: reload_pntr(0): "&integer'image(reload_pntr(0));
      -- report "-----> FIR MODEL: reload_pntr(1): "&integer'image(reload_pntr(1));
      reload_status.reload_pntr_update:=reload_pntr;
      -- report "-----> FIR MODEL: reload_status.reload_pntr_update(0): "&integer'image(reload_status.reload_pntr_update(0));
      -- report "-----> FIR MODEL: reload_status.reload_pntr_update(1): "&integer'image(reload_status.reload_pntr_update(1));
      
    end if;
  end if;

  if coef_ld='1' then
    if reload_pntr_current(coef_filter_sel) /=  reload_pntr(coef_filter_sel) and
       filter_fsel_rld/=coef_filter_sel and
       reload_status.reload_pntr_update(coef_filter_sel)=reload_pntr(coef_filter_sel)
       then
      --reload page for this filter has been stepped back after the snap shot
      --has been taken at the start of the update period due to another reload
      --of the filter being started but the new page hadn't been adopted by the actual
      --filter so the page will be stepped back.
      reload_status.reload_pntr_update(coef_filter_sel) := (reload_status.reload_pntr_update(coef_filter_sel)-1) mod (reload_pointer_max+1);
    end if;
  end if;

  --Processing time counter for PQ interpolation
  if fir_model_reqs.filter_type =  c_polyphase_pq and INTERP_RATE>DECIM_RATE then
    if reload_status.pq_int_px_cnt/=((properties.clk_per_chan*DECIM_RATE)/INTERP_RATE)*reload_status.interpolation_phases*NUM_CHANNELS then
      reload_status.pq_int_px_cnt:=reload_status.pq_int_px_cnt+1;
    else
      reload_status.pq_int_idle:=true;
    end if;
  end if;

  return reload_status;
end;

-------------------------------------------------------------------------------
-- Read in the MIF file
-------------------------------------------------------------------------------
function read_miffile_data ( filename         : string;
                             num_taps         : integer;
                             full_taps        : integer;
                             pad_offset       : integer;
                             num_filts        : integer;
                             is_signed           : boolean;
                             --split_partial    : boolean;
                             coef_width       : integer;
                             split_cwidth     : integer;
                             cpages           : integer;
                             channels         : integer;
                             is_channelizer_rcvr  : boolean;
                             is_channelizer_trans : boolean
                           ) return t_coeff_array is

  variable coeffs       : t_coeff_array := (others=>(others=>(others=>0)));
  file     filepointer  : text;-- open read_mode is filename;
  variable dataline     : line;
  variable binstring    : string(1 to coef_width);
  variable mif_status   : file_open_status;
  variable read_width   : integer := split_cwidth;
  variable remaining    : integer := coef_width;
  variable start        : integer := 1;
  variable tap          : integer := 0;
  variable phase        : integer := 0;
begin

  file_open(mif_status,filepointer,filename,read_mode);
  -- report "Padding offset = " & int_to_string(pad_offset);

  if is_channelizer_rcvr or is_channelizer_trans then
    for j in 0 to num_taps-1 loop
--       for i in channels-1 downto 0 loop
      tap:=j/channels;
      if is_channelizer_trans then
        phase:=(j mod channels);
      else
        phase:=(channels-1)-(j mod channels);
      end if;

      readline(filepointer, dataline);
      read(dataline, binstring);
      --report "Binary string = " & binstring;
      remaining := coef_width;
      for k in 0 to cpages-1 loop
        read_width := get_min(split_cwidth,remaining);
        start := remaining-read_width+1;
        --report int_to_str(phase)&","&int_to_str(k)&","&int_to_str(tap+pad_offset);
        coeffs(phase)(k)(tap+pad_offset) := bin_to_int(binstring(start to remaining),read_width,(is_signed and k=(cpages-1)));
        remaining := remaining - read_width;
--       end loop;
      end loop;
    end loop;
  else
    for i in 0 to num_filts-1 loop
      for j in 0 to num_taps-1 loop
        readline(filepointer, dataline);
        read(dataline, binstring);
        --report "Binary string = " & binstring;
        remaining := coef_width;
        for k in 0 to cpages-1 loop
          read_width := get_min(split_cwidth,remaining);
          start := remaining-read_width+1;
          coeffs(i)(k)(j+pad_offset) := bin_to_int(binstring(start to remaining),read_width,(is_signed and k=(cpages-1)));
          remaining := remaining - read_width;
        end loop;
      end loop;
    end loop;
  end if;

  --report filename;
  --report int_to_string(lines);
  
  -- for i in 0 to num_filts-1 loop
  --   for j in 0 to full_taps-1 loop
  --     for k in 0 to cpages-1 loop
  --       report "Coeff(" & int_to_string(i) & ")(" & int_to_string(k) & ")(" & int_to_string(j) & ") = " & int_to_string(coeffs(i)(k)(j));
  --     end loop;
  --   end loop;
  -- end loop;

  file_close(filepointer);
  
  return coeffs;

end read_miffile_data;


-------------------------------------------------------------------------------
-- Split an std_logic_vector coefficient up into coefficient integer pages, as in the MIF
-- reading function
-------------------------------------------------------------------------------

function split_reload_coeff ( coeff            : std_logic_vector;
                              split_cwidth     : integer;
                              cpages           : integer
                           ) return t_split_coeff is

  variable coeff_temp   : t_split_coeff := (others=>0);

begin

  for k in 0 to cpages-1 loop
    if k=cpages-1 then
      if COEF_TYPE=c_signed then
        coeff_temp(k) := to_integer(signed(coeff( get_min(((k+1)*split_cwidth)-1,coeff'HIGH) downto (k*split_cwidth) )));
      else
        coeff_temp(k) := to_integer(unsigned(coeff( get_min(((k+1)*split_cwidth)-1,coeff'HIGH) downto (k*split_cwidth) )));
      end if;
    else
      coeff_temp(k) := to_integer(unsigned(coeff( ((k+1)*split_cwidth)-1 downto (k*split_cwidth) )));
    end if;
  end loop;

  return coeff_temp;
  
end split_reload_coeff;


-------------------------------------------------------------------------------
-- Reorder the reloaded coefficients according to the reload order property
-- Reload coefficients are put into their appropriate locations and then
-- symmetry is restored.
-------------------------------------------------------------------------------
function do_coeff_reorder ( reloaded : t_reload_coeffs;
                            --order    : t_rld_order
                            order    : t_reorder_info_array;
                            coef_width_in : integer
                          ) return t_coefficients_slv is

  variable coeffs   : t_coefficients_slv:= (others=>(others=>'0'));

  type t_coefficients_slv_paths is array (0 to order(0).paths-1) of t_coefficients_slv;
  variable coeffs_paths   : t_coefficients_slv_paths := (others=>(others=>(others=>'0')));

  constant full_taps_adjusted : integer := properties.full_taps-2*inter_sym_shift;

  variable path_coef: signed(coef_width_in-1 downto 0);
begin

  for i in 0 to properties.reload_taps-1 loop

    if fir_model_reqs.filter_type=c_interpolating_symmetry and
       not (fir_model_reqs.inter_rate=2 and properties.odd_symmetry=1) then
      if order(0).paths=1 then
        coeffs(order(i).index_1) := std_logic_vector(signed(coeffs(order(i).index_1)) + signed(reloaded(i)));
        if order(i).combination=1 then
          coeffs(order(i).index_2) := std_logic_vector(signed(coeffs(order(i).index_2)) + signed(reloaded(i)));
        elsif order(i).combination=2 then
          coeffs(order(i).index_2) := std_logic_vector(signed(coeffs(order(i).index_2)) - signed(reloaded(i)));
        else -- unpaired self-symmetric central phase when P is odd
          -- Double up centre phase so that we can just half everything at the end
          coeffs(order(i).index_1) := std_logic_vector(signed(coeffs(order(i).index_1)) + signed(reloaded(i)));
        end if;
      else
        for path in 0 to order(0).paths-1 loop
          if path=0 then
            path_coef:=signed(ext_bus(reloaded(i)(order(i).upper_dest(path)-1 downto 0),coef_width_in,c_signed));
          else
            path_coef:=signed(ext_bus(reloaded(i)(sum_vals(order(i).upper_dest(path downto 0))-1 downto sum_vals(order(i).upper_dest(path-1 downto 0))),coef_width_in,c_signed));
          end if;
          --Keep the different path results seperate then concat together after
          coeffs_paths(path)(order(i).index_1) := std_logic_vector(signed(coeffs_paths(path)(order(i).index_1)) + path_coef);
          if order(i).combination=1 then
            coeffs_paths(path)(order(i).index_2) := std_logic_vector(signed(coeffs_paths(path)(order(i).index_2)) + path_coef);--reloaded(i);
          elsif order(i).combination=2 then
            coeffs_paths(path)(order(i).index_2) := std_logic_vector(signed(coeffs_paths(path)(order(i).index_2)) - path_coef);--reloaded(i);
          else -- unpaired self-symmetric central phase when P is odd
            -- Double up centre phase so that we can just half everything at the end
            coeffs_paths(path)(order(i).index_1) := std_logic_vector(signed(coeffs_paths(path)(order(i).index_1)) + path_coef);--reloaded(i);
          end if;
        end loop;
      end if;
    else
      coeffs(order(i).index_1) := std_logic_vector(unsigned(coeffs(order(i).index_1)) + unsigned(reloaded(i)));
    end if;
  end loop;

  -- For interpolating symmetry, we finally divide the coefficient set by 2
  if fir_model_reqs.filter_type=c_interpolating_symmetry and
     not (fir_model_reqs.inter_rate=2 and properties.odd_symmetry=1) then
    if order(0).paths=1 then
      for i in 0 to properties.reload_taps-1 loop
        coeffs(i) := coeffs(i)(coef_width_in-1)&coeffs(i)(coef_width_in-1 downto 1);--div by 2
      end loop;
    else

      for i in 0 to properties.reload_taps-1 loop
        --assume only two paths
        --Combine paths and div by 2
        coeffs(i)(order(0).upper_src(0)-1 downto 0):=coeffs_paths(0)(i)(order(0).upper_src(0) downto 1);
        coeffs(i)(coef_width_in-1 downto order(0).upper_src(0)):=coeffs_paths(1)(i)(coef_width_in-order(0).upper_src(0)-1)& --extend by 1 bit
                                                                 coeffs_paths(1)(i)(coef_width_in-order(0).upper_src(0)-1 downto 1);

      end loop;

    end if;
  end if;

  -- Restore symmetric half of filter response, which will not have been
  -- filled out by the above operation, other than a few around the centre tap
  -- in the case of interpolating symmetric filters.
  -- This should work for all filter types, as zero locations should also be
  -- echoes - it might be possible to reduce the number of operations for such
  -- filter responses, at the expense of additional complexity.
  if properties.symmetry=1 then
    for i in 1 to (full_taps_adjusted)/2 loop
      if NEG_SYMMETRY=1 then
        coeffs(full_taps_adjusted-i) := std_logic_vector( signed(not(coeffs(i-1)))+1 );
      else
        coeffs(full_taps_adjusted-i) := coeffs(i-1);
      end if;
    end loop;
  end if;

  return coeffs;
  
end do_coeff_reorder;

-------------------------------------------------------------------------------
-- CONSTANTS USING TYPES AND FUNCTIONS
-------------------------------------------------------------------------------
constant coeff_sets : t_coeff_array
                    := read_miffile_data(
                                         C_ELABORATION_DIR&C_MEM_INIT_FILE,
                                         NUM_TAPS,
                                         properties.full_taps,
                                         pad_offset,
                                         NUM_FILTS,
                                         (COEF_TYPE=0),
                                         COEF_WIDTH,
                                         split_cwidth,
                                         cpages,
                                         NUM_CHANNELS,
                                         fir_model_reqs.filter_type =c_channelizer_receiver,
                                         fir_model_reqs.filter_type =c_channelizer_transmitter
                                        );

-------------------------------------------------------------------------------
-- SIGNALS
-------------------------------------------------------------------------------
signal int_sclr               : std_logic := '0';
signal int_ce                 : std_logic := '0';

signal reload_sets            : t_reload_array    := (others => coeff_sets);
signal reload_pntr,
       reload_pntr_current    : t_reload_pointer  := (others=>0);

signal current_coeffs         : t_coeff_pages := (others=>(others=>0));

signal sets                   : t_sets  := (others=>0);
signal set                    : integer := 0;
signal rldpg                  : integer := 0;
signal channel_in             : integer := 0;
signal channel_out            : integer := select_integer(0,NUM_CHANNELS-1,FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1);

signal ipbuff_data_out        : t_data_paths:=(others=>(others=>0));--integer        := 0;
signal ipbuff_channel         : integer        := 0;
signal ipbuff_fsel_out        : integer        := 0;
signal ipbuff_chan0_out       : integer        := 0;
signal ipbuff_data_out1       : t_data_paths:=(others=>(others=>0));--integer        := 0;
signal ipbuff_channel1        : integer        := 0;
signal ipbuff_fsel_out1       : integer        := 0;

signal filter_data_in         : t_data_paths:=(others=>(others=>0));--integer        := 0;
signal filter_channel         : integer        := 0;
signal filter_fsel            : integer        := 0;
signal filter_chan0           : integer        := 0;

signal channel_data           : t_buffer_paths := (others=>(others=>(others=>(others=>0))));
signal channel_fsel           : t_buffer_array_int := (others=>(others=>0));
signal channel_rldpg          : t_buffer_array_int := (others=>(others=>0));
signal channel_chan0          : t_buffer_array_int := (others=>(others=>0));
signal data_slice             : t_regressor_paths  := (others=>(others=>(others=>0)));

signal push_ipbuff            : boolean := false;
signal pop_ipbuff             : boolean := false;
signal push_regressor         : boolean := false;
signal pop_regressor          : boolean := false;
signal next_data              : t_data_paths:=(others=>(others=>0));
signal next_data_fsel         : integer := 0;
signal next_data_chan0        : integer := 0;

signal result                 : t_result_paths := (others=>(others=>'0'));
signal regout,
       regout_sel,
       regout_blank           : t_result_paths := (others=>(others=>'0'));
signal result_i               : t_din_paths:=(others=>(others=>'0'));
signal regout_i,
       regout_i_blank         : t_din_paths:=(others=>(others=>'0'));

signal ipbuff_rdy             : std_logic := '0';
signal ira_rdy                : std_logic := '0';
signal dra_rdy                : std_logic := '0';

signal rfd_int,
       rfd_int_alt            : std_logic := '1';

signal cascade_in             : std_logic := '0';
signal rdy_dly                : t_rdy_dly := (others=>'0');
signal cascade_out            : std_logic := '0';
signal rdy_early              : std_logic := '0';
signal rdy_int                : std_logic := '0';
signal rdy_int_dly            : std_logic_vector(channelizer_delay downto 0);
signal rdy_int_sel            : std_logic;

signal last_indexes           : t_last_value_indexes := last_value_indexes(fir_model_reqs,properties);

signal regout_dly             : t_regout_dly:=(others=>(others=>(others=>'0')));
signal chan_out_dly           : t_chan_out_dly:=(others=>(others=>'0'));
signal data_valid_dly         : std_logic_vector(channelizer_delay downto 0):=(others=>'0');
signal vector_full_dly        : std_logic_vector(channelizer_delay downto 0):=(others=>'0');
signal chan_out_reg           : std_logic_vector(CHAN_SEL_WIDTH-1 downto 0):=(others=>'0');
signal chan0_op               : integer;
signal data_valid_sel         : std_logic;
signal vector_full_sel        : std_logic;
signal vector_full_reg        : std_logic:='0';
signal enable_at_startup      : std_logic:='1';

signal din_paths            : t_din_paths;

-------------------------------------------------------------------------------
-- MAIN
-------------------------------------------------------------------------------
begin


  --Map DIN inputs into a single array
  din_paths(0)<=DIN when NUM_PATHS=1 else DIN_1;
  din_paths(1)<=DIN_2;
  din_paths(2)<=DIN_3;
  din_paths(3)<=DIN_4;
  din_paths(4)<=DIN_5;
  din_paths(5)<=DIN_6;
  din_paths(6)<=DIN_7;
  din_paths(7)<=DIN_8;
  din_paths(8)<=DIN_9;
  din_paths(9)<=DIN_10;
  din_paths(10)<=DIN_11;
  din_paths(11)<=DIN_12;
  din_paths(12)<=DIN_13;
  din_paths(13)<=DIN_14;
  din_paths(14)<=DIN_15;
  din_paths(15)<=DIN_16;

  -- Drive SCLR and CE behaviour according to generics
  int_sclr    <= SCLR when C_HAS_SCLR = 1 else '0';
  int_ce      <= CE   when C_HAS_CE   = 1 else '1';

  g_dpaths_in: for path in 0 to NUM_PATHS-1 generate
    g_dpages_1: if dpages=1 generate
      next_data(path)(0)   <= to_integer(signed(din_paths(path))) when DATA_TYPE=0 else to_integer(unsigned(din_paths(path)));
    end generate g_dpages_1;
    
    g_dpages_2: if dpages=2 generate
      next_data(path)(0)   <= to_integer(unsigned(din_paths(path)(split_dwidth-1 downto 0)));
      next_data(path)(1)   <= to_integer(signed(din_paths(path)(din_paths(path)'HIGH downto split_dwidth))) when DATA_TYPE=0 else to_integer(unsigned(din_paths(path)(din_paths(path)'HIGH downto split_dwidth)));
    end generate g_dpages_2;
  end generate g_dpaths_in;

  next_data_fsel <= to_integer(unsigned(FILTER_SEL));
  push_ipbuff    <= true when (ND='1' or C_HAS_ND=0) and rfd_int='1'  else false;
  pop_regressor  <= true when rdy_early='1'                           else false;
  next_data_chan0<= 1 when CHAN0_IN='1' and C_HAS_CHAN0_IN=1 and NUM_CHANNELS>1          else 0;

  -----------------------------------------------------------------------------
  -- INPUT BUFFER AND RATE ADAPTER
  -----------------------------------------------------------------------------
  gib2: if buff_in_depth > 0 generate
    --Signal used for c_polyphase_pq_dec_alt
    signal start_op:  t_int_array( properties.ipbuff_lat-1 downto 0):=(others=>0);
  begin

    ib2cnt: process (clk)
      variable input_buffer     : t_ipbuff_paths := (others=>(others=>(others=>(others=>0))));
      variable input_buffer1    : t_ipbuff_paths := (others=>(others=>(others=>(others=>0))));
      variable ipbuff_phase     : integer        := 0;
      variable ipbuff_wrcnt     : integer        := 0;
      variable ipbuff_rdcnt     : integer        := 0;
      variable ipbuff_rden      : boolean        := false;
      variable ipbuff_wrpntr    : integer        := 0;
      variable ipbuff_wrpntr1   : integer        := 0;
      variable ipbuff_rdpntr    : integer        := 0;
      variable ipbuff_rdpntr1   : integer        := 0;

      variable ipbuff_opthresh  : integer := select_integer(
                                                properties.ipbuff_rate,
                                                divroundup(properties.deci_rate,properties.inter_rate),
                                                fir_model_reqs.filter_type = c_polyphase_pq_dec_alt);
      variable ipbuff_rdcnt_limit    : integer;
      variable ipbuff_pq_phase       : integer := select_integer(
                                                    0,
                                                    (divroundup(properties.deci_rate,properties.inter_rate)*properties.inter_rate) mod properties.deci_rate,
                                                    fir_model_reqs.filter_type = c_polyphase_pq_dec_alt);
      variable ipbuff_pq_ops         : integer := select_integer(
                                                    1,
                                                    0,
                                                    fir_model_reqs.filter_type = c_polyphase_pq_dec_alt);
      variable update_ipbuff_rden    : boolean;
      
      --only used for c_polyphase_pq_dec_alt structure
      variable ip_per_op_buff   : t_int_array(2*properties.ipbuff_depth downto 0):=(others=>0);
      variable start_op_src : boolean:=false;
      variable dec_input_count : boolean:=false;
      variable ipbuff_wrpntr2   : integer        := 0;
    begin
      if (rising_edge(clk)) then
        if (int_sclr='1') then
          ipbuff_wrcnt    := 0;
          ipbuff_rdcnt    := 0;
          ipbuff_rden     := false;
          pop_ipbuff      <= false;
          ipbuff_rdy      <= '0';
          ipbuff_wrpntr   := 0;
          ipbuff_wrpntr1  := 0;
          ipbuff_rdpntr   := 0;
          ipbuff_rdpntr1  := 0;
          ipbuff_phase    := 0;
          input_buffer    := (others=>(others=>(others=>(others=>0))));
          input_buffer1   := (others=>(others=>(others=>(others=>0))));
          ipbuff_data_out <= (others=>(others=>0));
          ipbuff_channel  <= 0;
          ipbuff_fsel_out <= 0;
          ipbuff_pq_phase := select_integer(
                                0,
                                (divroundup(properties.deci_rate,properties.inter_rate)*properties.inter_rate) mod properties.deci_rate,
                                fir_model_reqs.filter_type = c_polyphase_pq_dec_alt);
          ipbuff_pq_ops   := 0;
          ipbuff_opthresh := select_integer(
                                properties.ipbuff_rate,
                                divroundup(properties.deci_rate,properties.inter_rate),
                                fir_model_reqs.filter_type = c_polyphase_pq_dec_alt);
                                
          
          rfd_int_alt      <='1';
          ip_per_op_buff   :=(others=>0);
          start_op<=(others=>0);
          dec_input_count:=false;
          ipbuff_wrpntr2 :=0;
          
        elsif (int_ce='1') then
          if fir_model_reqs.filter_type = c_polyphase_pq_dec_alt then
            --Different functionality for alternitive pq decimation structure
            
            rfd_int_alt     <='1';
            --ipbuff_thresh has been hyjacked to pass the rfd threashold for this structure
            if ipbuff_wrpntr1>=properties.ipbuff_thresh then
              rfd_int_alt     <='0';
            end if;
            
            --Has a static value
            ipbuff_rdcnt_limit:=properties.ipbuff_rate*num_channels;
            
            
            --Pass data straight through to data regressor vector
            pop_ipbuff       <= false;
            start_op_src     := false;
            if push_ipbuff then
            
              -- for path in 0 to NUM_PATHS-1 loop
                -- ipbuff_data_out(path)   <= next_data(path);
              -- end loop;
              -- ipbuff_channel   <= channel_in;
              -- ipbuff_fsel_out  <= next_data_fsel;
              -- ipbuff_chan0_out <= next_data_chan0;
              -- 
              -- pop_ipbuff       <= true;
              
              --Store data in input buffer
              for path in 0 to NUM_PATHS-1 loop
                input_buffer(path)(0)(ipbuff_wrpntr2)   := next_data(path);
              end loop;
              input_buffer(0)(1)(ipbuff_wrpntr2)(0):= channel_in;
              input_buffer(0)(2)(ipbuff_wrpntr2)(0):= next_data_fsel;
              input_buffer(0)(3)(ipbuff_wrpntr2)(0):= next_data_chan0;
              ipbuff_wrpntr2                    := (ipbuff_wrpntr2+1) mod buff_in_depth;
              
              ipbuff_wrcnt:=ipbuff_wrcnt+1;
              if ipbuff_wrcnt = (ipbuff_opthresh*fir_model_reqs.num_channels) then
                ipbuff_wrcnt:=0;
                start_op_src:=true;
                
                --store that inputs availble to generate outputs and the number of inputs associated with output              
                for chans in 1 to fir_model_reqs.num_channels loop
                  ipbuff_pq_ops:=ipbuff_pq_ops+1;
                  ip_per_op_buff(ipbuff_wrpntr):=ipbuff_opthresh;
                  ipbuff_wrpntr:=(ipbuff_wrpntr+1) mod ip_per_op_buff'LENGTH;
                end loop;
                
                --Update how many inputs to receive for next output              
                ipbuff_opthresh:=0;
                loop
                  ipbuff_opthresh:=ipbuff_opthresh+1;
                  ipbuff_pq_phase:=ipbuff_pq_phase+fir_model_reqs.inter_rate;
                  exit when ipbuff_pq_phase>=fir_model_reqs.deci_rate;
                end loop;
                ipbuff_pq_phase:=ipbuff_pq_phase mod fir_model_reqs.deci_rate;
              end if;
              
              --Use to mimic diff address counter in core
              ipbuff_wrpntr1:=ipbuff_wrpntr1+1;
              
            end if;
            
            --Used to replicate the input buffers latency, this is necessary to model rfd correctly
            start_op(start_op'HIGH downto 1)<=start_op(start_op'HIGH-1 downto 0);
            if start_op_src then
              start_op(0)<= 1;
            else
              start_op(0)<= 0;
            end if;
            
            if start_op(start_op'HIGH)=1 then
              if not ipbuff_rden then
                --start generating outputs
                ipbuff_rden:=true;
                ipbuff_pq_ops:=ipbuff_pq_ops-1;
              end if;
            end if;
            
            --Check before to gen cycle delay
            if dec_input_count then
              ipbuff_wrpntr1:=ipbuff_wrpntr1-1;
            end if;
            
            ipbuff_rdy <= '0';
            dec_input_count:=false;
            if ipbuff_rden then
              -- Generate an output pulse, sent to the RDY chain, based on the read counter value
              if ipbuff_rdcnt mod properties.ipbuff_rate = 0 then
                ipbuff_rdy <= '1';             
              end if;
              
              --decrement diff addr by the number of inputs assosicated with this output, over the time it takes the core
              if ipbuff_rdcnt mod properties.ipbuff_rate <ip_per_op_buff(ipbuff_rdpntr) then
                dec_input_count:=true;
                
                --read out data and generate push for data vector
                pop_ipbuff       <= true;
                for path in 0 to NUM_PATHS-1 loop
                  ipbuff_data_out(path)  <= input_buffer(path)(0)(ipbuff_rdpntr1);
                end loop;
                ipbuff_channel   <= ipbuff_rdcnt/properties.ipbuff_rate ;--input_buffer(0)(1)(ipbuff_rdpntr1)(0);
                ipbuff_fsel_out  <= input_buffer(0)(2)(ipbuff_rdpntr1)(0);
                ipbuff_chan0_out <= input_buffer(0)(3)(ipbuff_rdpntr1)(0);
                --Generate correct reading sequence
                if ipbuff_rdcnt mod properties.ipbuff_rate =ip_per_op_buff(ipbuff_rdpntr)-1 then
                  if ipbuff_rdcnt/properties.ipbuff_rate/=fir_model_reqs.num_channels-1 then
                    ipbuff_rdpntr1    := (ipbuff_rdpntr1-(fir_model_reqs.num_channels*(ip_per_op_buff(ipbuff_rdpntr)-1))+1) mod buff_in_depth;
                    --step back all read out to start of next channels inputs
                  else
                    ipbuff_rdpntr1    := (ipbuff_rdpntr1+1) mod buff_in_depth;
                  end if;
                else
                  ipbuff_rdpntr1    := (ipbuff_rdpntr1+fir_model_reqs.num_channels) mod buff_in_depth;
                end if;
              end if;
              
              if (ipbuff_rdcnt mod properties.ipbuff_rate)=properties.ipbuff_rate-1 then
                --increment the pointer to the buffer containing the number of inputs to use for the next output
                ipbuff_rdpntr:=(ipbuff_rdpntr+1) mod ip_per_op_buff'LENGTH;
                if ipbuff_rdcnt = ipbuff_rdcnt_limit-1 then
                  if ipbuff_pq_ops=0 then
                    ipbuff_rden:=false;
                  else
                    ipbuff_pq_ops:=ipbuff_pq_ops-1;
                  end if;
                else
                  ipbuff_pq_ops:=ipbuff_pq_ops-1;
                end if;
              end if;
              
              if ipbuff_rdcnt < ipbuff_rdcnt_limit-1 then
                ipbuff_rdcnt:=ipbuff_rdcnt+1;
              else
                ipbuff_rdcnt:=0;
              end if;
            end if;
            
          else
            -- rd_enable=false must come first, as setting true must take priority (by simulation order)
            -- when write and read occur on the same cycle.
  
            --Update interpolation period cnt limit
            if ipbuff_rdcnt=0 and ipbuff_rden then
              if fir_model_reqs.filter_type = c_decimating_half_band then
                ipbuff_rdcnt_limit :=(properties.ipbuff_depth/2)*properties.ipbuff_rate-1;
              elsif not(fir_model_reqs.filter_type = c_polyphase_pq and INTERP_RATE>DECIM_RATE) then
                ipbuff_rdcnt_limit :=properties.ipbuff_depth*INTERP_RATE*properties.ipbuff_rate-1;
              else
                ipbuff_pq_ops      := (INTERP_RATE-ipbuff_pq_phase)/DECIM_RATE + select_integer(0,1,(INTERP_RATE-ipbuff_pq_phase) rem DECIM_RATE > 0 );
                ipbuff_pq_phase    :=(ipbuff_pq_phase+(ipbuff_pq_ops*DECIM_RATE)) mod INTERP_RATE;
                ipbuff_rdcnt_limit :=properties.ipbuff_depth*ipbuff_pq_ops*properties.ipbuff_rate-1;
              end if;
            end if;
  
            --Generate pulse to indicate end of a interpolation cnt
            update_ipbuff_rden:=ipbuff_rdcnt = ipbuff_rdcnt_limit and ipbuff_rden;
  
            --Increment count for current processing cycle.
            if ipbuff_rden then
              if ipbuff_rdcnt < ipbuff_rdcnt_limit then
                ipbuff_rdcnt := ipbuff_rdcnt + 1;
              else
                ipbuff_rdcnt := 0;
                ipbuff_rden  := false;
              end if;
            end if;
  
            --Increament number of writes recieved to input buffer
            if push_ipbuff then
              ipbuff_wrcnt := ipbuff_wrcnt + 1;
            end if;
  
            --Check number of writes recieved when start next processing
            if update_ipbuff_rden or push_ipbuff then
              if (ipbuff_wrcnt-1 = properties.ipbuff_thresh and push_ipbuff and not ipbuff_rden) or
                 (ipbuff_wrcnt > properties.ipbuff_thresh and update_ipbuff_rden) then
                ipbuff_rden  := true;
                ipbuff_wrcnt := ipbuff_wrcnt - properties.ipbuff_depth;
              end if;
            end if;
  
            -- Accumulate samples until all phases/channels available
            if push_ipbuff then
  
              -- Update input buffer contents
              -- For decimating halfband cases, this requires a
              if (fir_model_reqs.filter_type /= c_decimating_half_band                   ) or
                 (fir_model_reqs.filter_type  = c_decimating_half_band and ipbuff_phase=0) then
                for path in 0 to NUM_PATHS-1 loop
                  input_buffer(path)(0)(ipbuff_wrpntr)   := next_data(path);
                end loop;
                input_buffer(0)(1)(ipbuff_wrpntr)(0):= channel_in;
                input_buffer(0)(2)(ipbuff_wrpntr)(0):= next_data_fsel;
                input_buffer(0)(3)(ipbuff_wrpntr)(0):= next_data_chan0;
                ipbuff_wrpntr                    := (ipbuff_wrpntr+1) mod buff_in_depth;
              else
                for path in 0 to NUM_PATHS-1 loop
                  input_buffer1(path)(0)(ipbuff_wrpntr1) := next_data(path);
                end loop;
                input_buffer1(0)(1)(ipbuff_wrpntr1)(0):= channel_in;
                input_buffer1(0)(2)(ipbuff_wrpntr1)(0):= next_data_fsel;
                ipbuff_wrpntr1                   := (ipbuff_wrpntr1+1) mod buff_in_depth;
              end if;
               
              -- increment phase if max channel reached
              if channel_in=NUM_CHANNELS-1 then
                ipbuff_phase := (ipbuff_phase+1) mod DECIM_RATE;
              end if;
            
            end if;
  
            -- Generate an output pulse to the RDY chain based on the read counter value
            if ipbuff_rden and (ipbuff_rdcnt mod properties.ipbuff_rate)=0 then
              ipbuff_rdy <= '1';
            else
              ipbuff_rdy <= '0';
            end if;
  
            -- Generate input to the main buffer based on the read counter value
            if  ipbuff_rden and
                ipbuff_rdcnt < (properties.ipbuff_depth*ipbuff_opthresh) and
               (ipbuff_rdcnt mod ipbuff_opthresh) = 0 then
              pop_ipbuff       <= true;
              for path in 0 to NUM_PATHS-1 loop
                ipbuff_data_out(path)  <= input_buffer(path)(0)(ipbuff_rdpntr);
              end loop;
              ipbuff_channel   <= input_buffer(0)(1)(ipbuff_rdpntr)(0);
              ipbuff_fsel_out  <= input_buffer(0)(2)(ipbuff_rdpntr)(0);
              ipbuff_chan0_out <= input_buffer(0)(3)(ipbuff_rdpntr)(0);
              ipbuff_rdpntr    := (ipbuff_rdpntr+1) mod buff_in_depth;
              -- Generate the second phase output
              -- Note the explicit use of separate signal for channel and fsel, for debug
              -- purposes - could be tied to the main phase for optimised performance
              if fir_model_reqs.filter_type = c_decimating_half_band then
                for path in 0 to NUM_PATHS-1 loop
                  ipbuff_data_out1(path) <= input_buffer1(path)(0)(ipbuff_rdpntr1);
                end loop;
                ipbuff_channel1  <= input_buffer1(0)(1)(ipbuff_rdpntr1)(0);
                ipbuff_fsel_out1 <= input_buffer1(0)(2)(ipbuff_rdpntr1)(0);
                ipbuff_rdpntr1   := (ipbuff_rdpntr1+1) mod buff_in_depth;
              end if;
            else
              pop_ipbuff <= false;
            end if;
            
          end if; 
        
        end if;
      end if;
    end process; -- ib2cnt  
  end generate; -- gib2


  -----------------------------------------------------------------------------
  -- INPUT BUFFER BYPASS & INTERPOLATION RATE ADAPTER
  -- Only use IRA when there is no input buffer - input buffer also handles rate
  -- adaptation.
  -----------------------------------------------------------------------------
  
  -- Bypass the input buffer
  push_regressor <= push_ipbuff     when buff_in_depth=0 else pop_ipbuff;
  filter_data_in <= next_data       when buff_in_depth=0 else ipbuff_data_out;
  filter_channel <= channel_in      when buff_in_depth=0 else ipbuff_channel;
  filter_fsel    <= ipbuff_channel  when fir_model_reqs.filter_type=c_channelizer_transmitter else
                    channel_in      when fir_model_reqs.filter_type =c_channelizer_receiver else
                    next_data_fsel  when buff_in_depth=0 else
                    ipbuff_fsel_out;
  filter_chan0   <= next_data_chan0 when buff_in_depth=0 else ipbuff_chan0_out;

  -- Perform a simple rate adaptation without buffering data
  gira1: if buff_in_depth = 0 generate
  begin
    
    ira_cnt: process (clk)
      variable ira_count_en : boolean := false;
      variable ira_count    : integer := 0;
    begin
      if (rising_edge(clk)) then     
        if (int_sclr='1') then
          ira_count_en  := false;
          ira_count     := 0;
          ira_rdy       <= '0';
        elsif (int_ce='1') then
        
          -- Increment count when enabled and disable if max count reached
          -- enable=false must come first, as setting true must take priority (by simulation order)
          -- when write and read occur on the same cycle.
          if ira_count_en then
            if ira_count < (INTERP_RATE*properties.ipbuff_rate-1) then
              ira_count := ira_count + 1;
            else
              ira_count     := 0;
              ira_count_en  := false;
            end if;
          end if;
        
          -- Enable counter when new sample arrives.  Needs to override disable statement above.
          if push_ipbuff then
            
            ira_count_en := true;
            
          end if;
        
          -- Generate an output pulse to the RDY chain based on the read counter value
          if ira_count_en and (ira_count mod properties.ipbuff_rate)=0 then
            ira_rdy <= '1';
          else
            ira_rdy <= '0';
          end if;

        end if;
      end if;
    end process; -- ira_cnt  
  end generate; -- gira1

  cascade_in <= ira_rdy when buff_in_depth=0 else ipbuff_rdy;

  -----------------------------------------------------------------------------
  -- DATA REGRESSOR VECTORS
  -----------------------------------------------------------------------------
  gndat1 : if true generate
  begin
    new_data: process (clk)
      variable pointers  : t_pointers := (others=>pointer_start);
      variable rst_shift : t_pointers := (others=>0);

      variable push_regressor_dly   : t_push_regressor_dly   := (others=>false);
      variable filter_channel_dly   : t_filter_channel_dly   := (others=>0);
      variable filter_data_in_dly   : t_filter_data_in_dly   := (others=>(others=>(others=>0)));
      variable filter_fsel_dly      : t_filter_fsel_dly      := (others=>0);
      variable filter_chan0_dly     : t_filter_fsel_dly      := (others=>0);
      variable ipbuff_channel1_dly  : t_ipbuff_channel1_dly  := (others=>0);
      variable ipbuff_data_out1_dly : t_ipbuff_data_out1_dly := (others=>(others=>(others=>0)));
      variable ipbuff_fsel_out1_dly : t_ipbuff_fsel_out1_dly := (others=>0);

      variable push_regressor_rld   : boolean:=false;
      variable filter_channel_rld   : integer:=0;
      variable filter_data_in_rld   : t_data_paths:=(others=>(others=>0));--integer:=0;
      variable filter_fsel_rld      : integer:=0;
      variable filter_chan0_rld     : integer:=0;
      variable ipbuff_channel1_rld  : integer:=0;
      variable ipbuff_data_out1_rld : t_data_paths:=(others=>(others=>0));--integer:=0;
      variable ipbuff_fsel_out1_rld : integer:=0;

      variable reload_status : t_reload_status:=reload_status_init;
    begin

      if (rising_edge(clk)) then

        if int_sclr='1' then
          channel_out <= select_integer(0,NUM_CHANNELS-1,FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1);
          for j in 0 to NUM_CHANNELS-1 loop
            for i in 0 to main_buffer_depth-rst_shift(j)-1 loop
              for path in 0 to NUM_PATHS-1 loop
                channel_data (path)(j)(i) <= channel_data (path)(j)(i+rst_shift(j));
              end loop;
              --reload page is not reset on SCLR
              channel_chan0(j)(i) <= channel_chan0(j)(i+rst_shift(j));
            end loop;
          end loop;
          channel_fsel  <= (others=>(others=>0));
          pointers  := (others=>pointer_start);
          rst_shift := (others=>0);

          push_regressor_rld := false;
          push_regressor_dly := (others=>false);
          
          last_indexes <= last_value_indexes(fir_model_reqs,properties);
          
          reload_status := reload_status_init;
        elsif (int_ce='1') then
          -- Check if samples are being removed from the stack
          if pop_regressor then

            for i in 0 to main_buffer_depth-DECIM_RATE-1 loop
              for path in 0 to NUM_PATHS-1 loop
                channel_data (path)(channel_out)(i) <= channel_data (path)(channel_out)(i+DECIM_RATE);
              end loop;
              channel_fsel (channel_out)(i) <= channel_fsel (channel_out)(i+DECIM_RATE);
              channel_rldpg(channel_out)(i) <= channel_rldpg(channel_out)(i+DECIM_RATE);
              channel_chan0(channel_out)(i) <= channel_chan0(channel_out)(i+DECIM_RATE);
            end loop;
          
            pointers(channel_out)  := pointers(channel_out) - DECIM_RATE;

            for i in 0 to DECIM_RATE-1 loop
              if rst_shift(channel_out)=0 then
                rst_shift(channel_out) := INTERP_RATE-1;
              else
                rst_shift(channel_out) := rst_shift(channel_out) - 1;
              end if;
            end loop;

            if (fir_model_reqs.filter_type = c_polyphase_interpolating or
                fir_model_reqs.filter_type = c_interpolating_symmetry or
                fir_model_reqs.filter_type = c_interpolating_half_band or
                fir_model_reqs.filter_type = c_polyphase_pq or
                fir_model_reqs.filter_type = c_transpose_interpolating) and
                properties.use_approx then
              if channel_out=NUM_CHANNELS-1 then
                for path in 0 to NUM_PATHS-1 loop
                  last_indexes<=last_value_indexes_iterate(fir_model_reqs,properties,last_indexes);
                end loop;
              end if;
            end if;
            
            if FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1 then
              if channel_out=0 then
                channel_out <= NUM_CHANNELS-1;
              else
                channel_out <= channel_out-1;
              end if;
            else
              if channel_out=NUM_CHANNELS-1 then
                channel_out <= 0;
              else
                channel_out <= channel_out+1;
              end if;
            end if;

          end if;

        
          --Delay all signals feeding the stack and the push_regressor signal
          --to allign with reload page completion.
          --Delay push_regressor to qualify coefficient reload and generate interpolation pulses?
          push_regressor_dly(1 to reload_dly_len-2)   := push_regressor_dly(0 to reload_dly_len-3);
          push_regressor_dly(0)                       := push_regressor;
          filter_channel_dly(1 to reload_dly_len-2)   := filter_channel_dly(0 to reload_dly_len-3);
          filter_channel_dly(0)                       := filter_channel;
          filter_data_in_dly(1 to reload_dly_len-2)   := filter_data_in_dly(0 to reload_dly_len-3);
          filter_data_in_dly(0)                       := filter_data_in;
          filter_fsel_dly(1 to reload_dly_len-2)      := filter_fsel_dly(0 to reload_dly_len-3);
          filter_fsel_dly(0)                          := filter_fsel;
          filter_chan0_dly(1 to reload_dly_len-2)     := filter_chan0_dly(0 to reload_dly_len-3);
          filter_chan0_dly(0)                         := filter_chan0;
          ipbuff_channel1_dly(1 to reload_dly_len-2)  := ipbuff_channel1_dly(0 to reload_dly_len-3);
          ipbuff_channel1_dly(0)                      := ipbuff_channel1;
          ipbuff_data_out1_dly(1 to reload_dly_len-2) := ipbuff_data_out1_dly(0 to reload_dly_len-3);
          ipbuff_data_out1_dly(0)                     := ipbuff_data_out1;
          ipbuff_fsel_out1_dly(1 to reload_dly_len-2) := ipbuff_fsel_out1_dly(0 to reload_dly_len-3);
          ipbuff_fsel_out1_dly(0)                     := ipbuff_fsel_out1;

          push_regressor_rld   := push_regressor_dly(reload_dly_len-3);
          filter_channel_rld   := filter_channel_dly(reload_dly_len-3);
          filter_data_in_rld   := filter_data_in_dly(reload_dly_len-3);
          filter_fsel_rld      := filter_fsel_dly(reload_dly_len-3);
          filter_chan0_rld     := filter_chan0_dly(reload_dly_len-3);
          ipbuff_channel1_rld  := ipbuff_channel1_dly(reload_dly_len-3);
          ipbuff_data_out1_rld := ipbuff_data_out1_dly(reload_dly_len-3);
          ipbuff_fsel_out1_rld := ipbuff_fsel_out1_dly(reload_dly_len-3);

          --Grab the reload status and freeze until next time the core
          --will update.
          reload_status:=update_filter_page( reload_status,
                                             push_regressor_rld and 
                                             (fir_model_reqs.filter_type /= c_polyphase_pq_dec_alt or
                                              (fir_model_reqs.filter_type = c_polyphase_pq_dec_alt and not push_regressor_dly(reload_dly_len-2))),
                                             --add extra qualification when alt pq dec structure as push_regressor will be high for multiplie clock cycles
                                             --as it is shifting in more than one sample
                                             filter_channel_rld,
                                             reload_pntr,
                                             reload_pntr_current,
                                             COEF_LD,
                                             to_integer(unsigned(COEF_FILTER_SEL)),
                                             filter_fsel_rld );

          -- Check if samples are being added to the stack
          if push_regressor_rld then

            -- Update buffer contents
            if not( fir_model_reqs.filter_type = c_polyphase_pq and INTERP_RATE>DECIM_RATE) then
              for path in 0 to NUM_PATHS-1 loop
                channel_data (path)(filter_channel_rld)(pointers(filter_channel_rld)-(DECIM_RATE-1)) <= filter_data_in_rld(path);
              end loop;
              channel_fsel (filter_channel_rld)(pointers(filter_channel_rld)-(DECIM_RATE-1)) <= filter_fsel_rld;
              channel_chan0(filter_channel_rld)(pointers(filter_channel_rld)-(DECIM_RATE-1)) <= filter_chan0_rld;
              channel_rldpg(filter_channel_rld)(pointers(filter_channel_rld)-(DECIM_RATE-1)) <= reload_status.reload_pntr_update(filter_fsel_rld);--reload_pntr(filter_fsel_rld);
            else
              for path in 0 to NUM_PATHS-1 loop
                channel_data (path)(filter_channel_rld)(pointers(filter_channel_rld)) <= filter_data_in_rld(path);
              end loop;
              channel_fsel (filter_channel_rld)(pointers(filter_channel_rld)) <= filter_fsel_rld;
              channel_chan0(filter_channel_rld)(pointers(filter_channel_rld)) <= filter_chan0_rld;
              channel_rldpg(filter_channel_rld)(pointers(filter_channel_rld)) <= reload_status.reload_pntr_update(filter_fsel_rld);--reload_pntr(filter_fsel_rld);
            end if;
            

            --Update current reload page
            if fir_model_reqs.filter_type /= c_polyphase_pq_dec_alt then
              reload_pntr_current(filter_fsel_rld)<=reload_status.reload_pntr_update(filter_fsel_rld);--reload_pntr(filter_fsel_rld);
            else
              --need to qualify the updating of the current reload page in the same way as for update_filter_page function call.
              --This is done at the end of the pulse rather than the begining, as above. Doing this update is used to indiciate
              --that a filter set has been used and the reloaded page has been used. IF the filter set is not used the reload page
              --is over-written when a reload on the same filter set occurs. Concerned that this timing of when it decides if a filter
              --set reload page has been used will be different to the core.
              if not push_regressor_dly(reload_dly_len-4) then
                reload_pntr_current(filter_fsel_rld)<=reload_status.reload_pntr_update(filter_fsel_rld);
              end if;
            end if;

            -- Insert zero samples for interpolation cases
            for i in 1 to INTERP_RATE-1 loop
              if not( fir_model_reqs.filter_type = c_polyphase_pq and INTERP_RATE>DECIM_RATE) then
                for path in 0 to NUM_PATHS-1 loop
                  channel_data (path)(filter_channel_rld)(pointers(filter_channel_rld)+i-(DECIM_RATE-1)) <= (others=>0);
                end loop;
                channel_fsel (filter_channel_rld)(pointers(filter_channel_rld)+i-(DECIM_RATE-1)) <= filter_fsel_rld;
                channel_chan0(filter_channel_rld)(pointers(filter_channel_rld)+i-(DECIM_RATE-1)) <= 0;
                channel_rldpg(filter_channel_rld)(pointers(filter_channel_rld)+i-(DECIM_RATE-1)) <= reload_status.reload_pntr_update(filter_fsel_rld);--reload_pntr(filter_fsel_rld);
              else
                for path in 0 to NUM_PATHS-1 loop
                  channel_data (path)(filter_channel_rld)(pointers(filter_channel_rld)+i) <= (others=>0);
                end loop;
                channel_fsel (filter_channel_rld)(pointers(filter_channel_rld)+i) <= filter_fsel_rld;
                channel_chan0(filter_channel_rld)(pointers(filter_channel_rld)+i) <= 0;
                channel_rldpg(filter_channel_rld)(pointers(filter_channel_rld)+i) <= reload_status.reload_pntr_update(filter_fsel_rld);--reload_pntr(filter_fsel_rld);
              end if;
            end loop;

            -- Increment write pointer
            pointers(filter_channel_rld) := pointers(filter_channel_rld) + INTERP_RATE;

            -- If filter type is decimating halfband, we have two samples per push from the input buffer,
            -- so we need to push onto the the sample stack once again and increment pointer again
            if fir_model_reqs.filter_type = c_decimating_half_band then
              -- Update buffer contents with second phase data
              for path in 0 to NUM_PATHS-1 loop
                channel_data (path)(ipbuff_channel1_rld)(pointers(ipbuff_channel1_rld)-(DECIM_RATE-1)) <= ipbuff_data_out1_rld(path);
              end loop;
              channel_fsel (ipbuff_channel1_rld)(pointers(ipbuff_channel1_rld)-(DECIM_RATE-1)) <= ipbuff_fsel_out1_rld;
              channel_rldpg(ipbuff_channel1_rld)(pointers(ipbuff_channel1_rld)-(DECIM_RATE-1)) <= reload_pntr(ipbuff_fsel_out1_rld);
              -- Increment write pointer
              pointers(ipbuff_channel1_rld) := pointers(ipbuff_channel1_rld) + 1;
            end if;

          end if;


        end if;
    
      end if;

    end process; -- new_data
  end generate;
  
  -----------------------------------------------------------------------------
  -- FIR CALCULATION
  -----------------------------------------------------------------------------

  set <= channel_fsel(channel_out)(set_index);

  rldpg <= channel_rldpg(channel_out)(set_index);

  current_coeffs <= reload_sets(rldpg)(set);

  g_fir_paths: for path in 0 to NUM_PATHS-1 generate

    -- data_slice(path) <= t_regressor(channel_data(path)(channel_out)(0 to regressor_len-1));
    data_slice(path) <= t_regressor(channel_data(path)(channel_out)(pointer_start-(regressor_len-1) to pointer_start));

    gfir1: if not split_accum and not signed_output generate
    begin

      result(path) <= std_logic_vector(
                  to_unsigned (
                    fir (
                      current_coeffs(0),
                      data_slice(path),
                      0,
                      properties.full_taps,
                      properties.zpf,
                      true,
                      last_indexes ),
                    OUTPUT_WIDTH
                  )
                );
    
    end generate; -- gfir1
  
    gfir2: if not split_accum and signed_output generate
    begin
  
      result(path) <= std_logic_vector(
                  to_signed (
                    fir (
                      current_coeffs(0),
                      data_slice(path),
                      0,
                      properties.full_taps,
                      properties.zpf,
                      true,
                      last_indexes ),
                    OUTPUT_WIDTH
                  )
                );
  
    
    end generate; -- gfir2
  
    gfir3: if split_accum and not signed_output generate
    begin
      
      result(path) <= std_logic_vector(
                  split_fir_unsigned(
                    current_coeffs,
                    data_slice(path),
                    dpages,
                    cpages,
                    properties.full_taps,
                    properties.zpf,
                    coef_width,
                    split_cwidth,
                    split_dwidth,
                    ACCUM_WIDTH,
                    OUTPUT_WIDTH,
                    true,
                    last_indexes
                  )
                );
    
    end generate; -- gfir3
  
    gfir4: if split_accum and signed_output generate
    begin
  
      result(path) <= std_logic_vector(
                  split_fir_signed(
                    current_coeffs,
                    data_slice(path),
                    dpages,
                    cpages,
                    properties.full_taps,
                    properties.zpf,
                    coef_width,
                    split_cwidth,
                    split_dwidth,
                    ACCUM_WIDTH,
                    OUTPUT_WIDTH,
                    true,
                    last_indexes
                  )
                );
    
    end generate; -- gfir4
  end generate g_fir_paths;

  g_chan0_op: process(channel_chan0,channel_out)
  begin
    if C_HAS_CHAN0_IN=1 then
      if FILTER_TYPE=c_polyphase_decimating or
         (FILTER_TYPE =  c_polyphase_pq and INTERP_RATE<DECIM_RATE) then
        chan0_op<=0;
        for i in 0 to properties.deci_rate-1 loop
          if channel_chan0(channel_out)(regressor_len-1-i)=1 then
            chan0_op<=1;
          end if;
        end loop;
      else
        chan0_op<=channel_chan0(channel_out)(regressor_len-1);
      end if;
    else
      chan0_op<=0;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- DATA OUTPUT GENERATION
  -----------------------------------------------------------------------------
  opreg1: process (clk)
    variable first_output:boolean:=true;
  begin
    if (rising_edge(clk)) then
      if int_sclr='1' then
        regout   <= (others=>(others=>'0'));
        --CHAN_OUT <= (others=>'0');
        chan_out_reg <= (others=>'0');
        regout_dly<=(others=>(others=>(others=>'0')));
        chan_out_dly<=(others=>(others=>'0'));
        first_output:=true;
      elsif (int_ce='1') then
        regout_dly(channelizer_delay downto 1)<=regout_dly(channelizer_delay-1 downto 0);
        regout_dly(0)<=regout;
        chan_out_dly(channelizer_delay downto 1)<=chan_out_dly(channelizer_delay-1 downto 0);
        chan_out_dly(0)<=chan_out_reg;

        if rdy_early='1' then
          regout   <= result;
          --Need to seperate output channel cnt from internal channel cnt for when CHAN0_IN
          --is used, currently not supported.
          if to_integer(unsigned(chan_out_reg))=NUM_CHANNELS-1 or
             first_output or 
             chan0_op=1 then
            chan_out_reg <= (others=>'0');
          else
            chan_out_reg <= std_logic_vector(unsigned(chan_out_reg)+1);
          end if;
          first_output:=false;
        end if;
      end if;
    end if;
  end process; -- opreg1

  CHAN_OUT<=(others=>'0') when FILTER_TYPE=c_channelizer_transmitter else
            chan_out_dly(channelizer_delay) when FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1 else
            chan_out_reg;

  -- Non-Hilbert output
  ghilb1: if fir_model_reqs.filter_type/=c_hilbert_transform generate
  begin
    -- Only output result from register when output is registered or RDY is high,
    -- otherwise unknown
    regout_sel<=regout_dly(channelizer_delay) when FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1 else regout;
    rdy_int_sel<=rdy_int_dly(channelizer_delay) when FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1 else rdy_int;

    gen_single_path: if NUM_PATHS=1 generate
      DOUT   <= (others=>'0') when (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1 and vector_full_sel='0' and enable_at_startup='0') else
                regout_sel(0) when OUTPUT_REG=1 or rdy_int_sel='1' or (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1) else (others=>'X');
    end generate gen_single_path;

    gen_multi_path: if NUM_PATHS>1 generate

      regout_blank<= (others=>(others=>'0')) when (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1 and vector_full_sel='0' and enable_at_startup='0') else
                      regout_sel when OUTPUT_REG=1 or rdy_int_sel='1' or (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1) else (others=>(others=>'X'));

      DOUT_1   <= regout_blank(0);
      DOUT_2   <= regout_blank(1);

      gen_3: if NUM_PATHS>2 generate
      DOUT_3   <=regout_blank(2);
      end generate gen_3;

      gen_4: if NUM_PATHS>3 generate
      DOUT_4   <=regout_blank(3);
      end generate gen_4;
  
      gen_5: if NUM_PATHS>4 generate
      DOUT_5   <=regout_blank(4);
      end generate gen_5;

      gen_6: if NUM_PATHS>5 generate
      DOUT_6   <=regout_blank(5);
      end generate gen_6;

      gen_7: if NUM_PATHS>6 generate
      DOUT_7   <=regout_blank(6);
      end generate gen_7;
  
      gen_8: if NUM_PATHS>7 generate
      DOUT_8   <=regout_blank(7);
      end generate gen_8;
  
      gen_9: if NUM_PATHS>8 generate
      DOUT_9   <=regout_blank(8);
      end generate gen_9;

      gen_10: if NUM_PATHS>9 generate
      DOUT_10  <=regout_blank(9);
      end generate gen_10;
  
      gen_11: if NUM_PATHS>10 generate
      DOUT_11  <=regout_blank(10);
      end generate gen_11;
  
      gen_12: if NUM_PATHS>11 generate
      DOUT_12  <=regout_blank(11);
      end generate gen_12;
  
      gen_13: if NUM_PATHS>12 generate
      DOUT_13  <=regout_blank(12);
      end generate gen_13;

      gen_14: if NUM_PATHS>13 generate
      DOUT_14  <=regout_blank(13);
      end generate gen_14;

      gen_15: if NUM_PATHS>14 generate
      DOUT_15  <=regout_blank(14);
      end generate gen_15;

      gen_16: if NUM_PATHS>15 generate
      DOUT_16  <=regout_blank(15);
      end generate gen_16;

    end generate gen_multi_path;

  end generate; -- ghilb1
  
  -- Hilbert In-Phase and Quadrature outputs
  ghilb2: if fir_model_reqs.filter_type=c_hilbert_transform generate
  begin

    ghil_paths: for path in 0 to NUM_PATHS-1 generate
      result_i(path) <= std_logic_vector(to_unsigned(channel_data(path)(channel_out)(properties.full_taps/2)(1),DATA_WIDTH-split_dwidth)) &
                        std_logic_vector(to_unsigned(channel_data(path)(channel_out)(properties.full_taps/2)(0),split_dwidth)) when DATA_TYPE=1 and dpages=2 else
                        std_logic_vector(  to_signed(channel_data(path)(channel_out)(properties.full_taps/2)(1),DATA_WIDTH-split_dwidth)) &
                        std_logic_vector(to_unsigned(channel_data(path)(channel_out)(properties.full_taps/2)(0),split_dwidth)) when dpages=2 else
                        std_logic_vector(to_unsigned(channel_data(path)(channel_out)(properties.full_taps/2)(0),DATA_WIDTH)) when DATA_TYPE=1 else
                        std_logic_vector(  to_signed(channel_data(path)(channel_out)(properties.full_taps/2)(0),DATA_WIDTH));
    end generate ghil_paths;

    opreg2: process (clk)
    begin
      if (rising_edge(clk)) then
        if int_sclr='1' then
          regout_i <= (others=>(others=>'0'));
        elsif (int_ce='1') then
          if rdy_early='1' then
            regout_i <= result_i;
          end if;
        end if;
      end if;
    end process; -- opreg2
  
    -- Only output result from register when output is registered or RDY is high,
    -- otherwise unknown

    gen_single_path: if NUM_PATHS=1 generate
      DOUT_Q <= (others=>'0') when (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1 and vector_full_sel='0' and enable_at_startup='0') else
                regout(0)   when OUTPUT_REG=1 or rdy_int='1' or (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1) else (others=>'X');
      DOUT_I <= (others=>'0') when (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1 and vector_full_sel='0' and enable_at_startup='0') else
                regout_i(0) when OUTPUT_REG=1 or rdy_int='1' or (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1) else (others=>'X');
    end generate gen_single_path;

    gen_multi_path: if NUM_PATHS>1 generate

      regout_blank   <= (others=>(others=>'0')) when (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1 and vector_full_sel='0' and enable_at_startup='0') else
                        regout when OUTPUT_REG=1 or rdy_int='1' or (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1) else (others=>(others=>'X'));
      regout_i_blank <= (others=>(others=>'0')) when (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1 and vector_full_sel='0' and enable_at_startup='0') else
                        regout_i when OUTPUT_REG=1 or rdy_int='1' or (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1) else (others=>(others=>'X'));

      DOUT_I_1 <=regout_i_blank(0);
      DOUT_Q_1 <=regout_blank(0);
      DOUT_I_2 <=regout_i_blank(1);
      DOUT_Q_2 <=regout_blank(1);

      gen_3: if NUM_PATHS>2 generate
      DOUT_I_3 <=regout_i_blank(2);
      DOUT_Q_3 <=regout_blank(2);
      end generate gen_3;

      gen_4: if NUM_PATHS>3 generate
      DOUT_I_4 <=regout_i_blank(3);
      DOUT_Q_4 <=regout_blank(3);
      end generate gen_4;
  
      gen_5: if NUM_PATHS>4 generate
      DOUT_I_5 <=regout_i_blank(4);
      DOUT_Q_5 <=regout_blank(4);
      end generate gen_5;
  
      gen_6: if NUM_PATHS>5 generate
      DOUT_I_6 <=regout_i_blank(5);
      DOUT_Q_6 <=regout_blank(5);
      end generate gen_6;
  
      gen_7: if NUM_PATHS>6 generate
      DOUT_I_7 <=regout_i_blank(6);
      DOUT_Q_7 <=regout_blank(6);
      end generate gen_7;

      gen_8: if NUM_PATHS>7 generate
      DOUT_I_8 <=regout_i_blank(7);
      DOUT_Q_8 <=regout_blank(7);
      end generate gen_8;
  
      gen_9: if NUM_PATHS>8 generate
      DOUT_I_9 <=regout_i_blank(8);
      DOUT_Q_9 <=regout_blank(8);
      end generate gen_9;

      gen_10: if NUM_PATHS>9 generate
      DOUT_I_10<=regout_i_blank(9);
      DOUT_Q_10<=regout_blank(9);
      end generate gen_10;

      gen_11: if NUM_PATHS>10 generate
      DOUT_I_11<=regout_i_blank(10);
      DOUT_Q_11<=regout_blank(10);
      end generate gen_11;
  
      gen_12: if NUM_PATHS>11 generate
      DOUT_I_12<=regout_i_blank(11);
      DOUT_Q_12<=regout_blank(11);
      end generate gen_12;
  
      gen_13: if NUM_PATHS>12 generate
      DOUT_I_13<=regout_i_blank(12);
      DOUT_Q_13<=regout_blank(12);
      end generate gen_13;

      gen_14: if NUM_PATHS>13 generate
      DOUT_I_14<=regout_i_blank(13);
      DOUT_Q_14<=regout_blank(13);
      end generate gen_14;

      gen_15: if NUM_PATHS>14 generate
      DOUT_I_15<=regout_i_blank(14);
      DOUT_Q_15<=regout_blank(14);
      end generate gen_15;

      gen_16: if NUM_PATHS>15 generate
      DOUT_I_16<=regout_blank(15);
      DOUT_Q_16<=regout_blank(15);
      end generate gen_16;
    end generate gen_multi_path;
  end generate; -- ghilb2

  gen_data_valid: if C_HAS_DATA_VALID=1 or (SCLR_DETERMINISTIC=1 and C_HAS_SCLR=1) generate
    function gen_vector_length return integer is
      variable  vector_length,
                taps_per_phase,
                taps,
                vector_taps,
                vector_mod,
                vector_half: integer;
    begin
      if FILTER_TYPE=c_decimating_half_band then
        vector_length:=properties.actual_taps;
      elsif FILTER_TYPE=c_polyphase_interpolating and SYMMETRY=1 then
        vector_mod:=0;
        if ODD_SYMMETRY=1 and INTERP_RATE rem 2>0 then
          vector_mod:=INTERP_RATE/2;
          vector_half:=(NUM_TAPS/2)-vector_mod;
        else
          vector_half:=(NUM_TAPS/2);
        end if;
    
        vector_half:=((vector_half/INTERP_RATE)+select_integer(0,1,vector_half rem INTERP_RATE>0))*INTERP_RATE;
    
        vector_length:=properties.actual_taps;
    
        if COEF_RELOAD=1 then
          vector_length:=vector_length
                         +properties.actual_taps
                         -vector_mod
                         -(INTERP_RATE-1);
        else
          vector_length:=vector_length
                         +vector_half
                         -(INTERP_RATE-1);
        end if;

      elsif FILTER_TYPE=c_polyphase_pq and INTERP_RATE>DECIM_RATE then
        if COEF_RELOAD=1 then
          vector_taps:=properties.actual_taps;
        else
          vector_taps:=NUM_TAPS;
        end if;
        vector_length:=((vector_taps-1)/DECIM_RATE)+1-
                            ((INTERP_RATE-1-
                              (vector_taps -
                               ((((vector_taps-1)/DECIM_RATE)*DECIM_RATE)+1)))/DECIM_RATE);
        -- vector_length:=divroundup(vector_taps,DECIM_RATE);                                       
      elsif FILTER_TYPE=c_polyphase_interpolating or 
            FILTER_TYPE=c_transpose_interpolating or 
            fir_model_reqs.filter_type =  c_polyphase_pq_dec_alt then
        if COEF_RELOAD=1 then
          vector_length:=properties.actual_taps;
        else
          vector_length:=((NUM_TAPS/INTERP_RATE)+select_integer(0,1,NUM_TAPS rem INTERP_RATE>0))*INTERP_RATE;
        end if;
        vector_length:=vector_length-(INTERP_RATE-1);
        if fir_model_reqs.filter_type =  c_polyphase_pq_dec_alt then
          vector_length:=get_max(vector_length,2);--similarly to normail decimation at least one output sample must be output before data vector will be clear 
        end if;
      elsif FILTER_TYPE=c_channelizer_transmitter or FILTER_TYPE=c_channelizer_receiver then
        vector_length:=properties.actual_taps*NUM_CHANNELS;
      elsif (FILTER_TYPE =  c_polyphase_pq and INTERP_RATE<DECIM_RATE and fir_model_reqs.filter_type /=  c_polyphase_pq_dec_alt) then
        vector_length:=properties.actual_taps/properties.deci_rate;
      elsif FILTER_TYPE=c_polyphase_decimating or
            FILTER_TYPE=c_transpose_decimating then
        if properties.symmetry=1 then
          taps:=(NUM_TAPS+1)/2;
        else
          taps:=NUM_TAPS;
        end if;
        taps_per_phase:=taps/properties.deci_rate;
        if  taps rem properties.deci_rate> 0 then
          taps_per_phase:=taps_per_phase+1;
        end if;
        if COEF_RELOAD=1 then
          vector_length:=((properties.actual_taps/properties.deci_rate)*2**properties.symmetry);-- -properties.odd_symmetry
        elsif properties.symmetry=1 then
          vector_length:=taps_per_phase+(properties.actual_taps/properties.deci_rate);-- -properties.odd_symmetry; don't sub as smoe phases have even sym
        else
          vector_length:=taps_per_phase;
        end if;
        vector_length:=get_max(vector_length,2);
      else
        if COEF_RELOAD=1 then
          vector_length:=(properties.actual_taps*2**properties.symmetry)-properties.odd_symmetry;
        elsif properties.symmetry=1 then
          vector_length:=NUM_TAPS/2+properties.actual_taps;
        else
          vector_length:=NUM_TAPS;
        end if;
      end if;

      if FILTER_TYPE=c_interpolated_transform then
        vector_length:=vector_length*ZERO_PACKING_FACTOR;
      end if;
      
      return vector_length;
    end;

    constant vector_length:integer:=gen_vector_length;

    signal vector_full_qual
           : std_logic:='0';
  begin
    process(clk)
      variable vector_count: integer:=0;
      variable deci_op_clr : boolean:=false;
      constant count_mod   : integer:=select_integer(-1,-ZERO_PACKING_FACTOR,FILTER_TYPE=c_interpolated_transform)+
                                      select_integer(0,1,NUM_CHANNELS=1);
      variable vector_full : std_logic:='0';
    begin
    	if (rising_edge(clk)) then
    		if (int_sclr='1') then
          vector_count:=0;
          vector_full:='0';
          vector_full_reg<='0';
          data_valid_dly<=(others=>'0');
          vector_full_dly<=(others=>'0');
          vector_full_qual<='0';
          enable_at_startup<='0';
    		elsif (int_ce='1') then
    		  if rdy_early='1' then
            if FILTER_TYPE=c_channelizer_transmitter or FILTER_TYPE=c_channelizer_receiver then
              if vector_full='0' then
                vector_count:=vector_count+1;
                if vector_count=vector_length then
                  vector_full:='1';
                end if;
              end if;
            else
              if chan0_op=1 or deci_op_clr then
                vector_count:=0;
                vector_full:='0';
                if FILTER_TYPE=c_polyphase_decimating or
                   (FILTER_TYPE =  c_polyphase_pq and INTERP_RATE<DECIM_RATE) then
                  if not deci_op_clr then
                    deci_op_clr:=true;
                  elsif unsigned(chan_out_reg)=NUM_CHANNELS-1 then
                    deci_op_clr:=false;
                  end if;
                end if;
        		  elsif vector_full='0' and to_integer(unsigned(chan_out_reg))=NUM_CHANNELS-1 then
                if vector_length=1 then
                  vector_full:='1';
                else
                  vector_count:=vector_count+1;
                  if vector_count=vector_length+count_mod then
                    vector_full:='1';
                  end if;
                end if;
              end if;

            end if;
          end if;
          vector_full_qual<=vector_full and rdy_early;
          vector_full_reg<=vector_full;
          data_valid_dly(channelizer_delay downto 1)<=data_valid_dly(channelizer_delay-1 downto 0);
          data_valid_dly(0)<=vector_full_qual;
          vector_full_dly(channelizer_delay downto 1)<=vector_full_dly(channelizer_delay-1 downto 0);
          vector_full_dly(0)<=vector_full_reg;
    		end if;
    	end if;
    end process;
    data_valid_sel<=data_valid_dly(channelizer_delay) when FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1 else vector_full_qual;
    vector_full_sel<=vector_full_dly(channelizer_delay) when FILTER_TYPE=c_channelizer_receiver and XIL_FFT_COMPATIBLE=1 else vector_full_reg;

    DATA_VALID<=data_valid_sel when C_HAS_DATA_VALID=1;

  end generate gen_data_valid;

  -----------------------------------------------------------------------------
  -- CASCADE DELAY MODEL
  -- This models the cascade delay of the filter block, which is cycle-based.
  -----------------------------------------------------------------------------
  casc_dly1: process (clk)
  begin
    if (rising_edge(clk)) then
      if int_sclr='1' then
        rdy_dly  <= (others=>'0');
      elsif (int_ce='1') then
        -- RDY is delayed cascade_in pulse
        rdy_dly (1 to rdy_dly_len-1) <= rdy_dly (0 to rdy_dly_len-2);
        rdy_dly (0)                  <= cascade_in;
      end if;
    end if;
  end process; -- casc_dly1

  cascade_out <= rdy_dly(rdy_dly_len-1);


  -----------------------------------------------------------------------------
  -- DECIMATION RATE ADAPTER
  -- This process reduces the output pulse count based on the decimation rate
  -- There is a possibility of merging this function with the output buffer,
  -- as has been done with the interpolation rate adapter and input buffer.
  -----------------------------------------------------------------------------
  dra_cnt: process (clk)
    variable dra_count       : integer := 0;
    constant dra_deci_rate   : integer := select_integer(DECIM_RATE-1,0,
                                                         (fir_model_reqs.filter_type=c_polyphase_pq and INTERP_RATE>DECIM_RATE) or
                                                          fir_model_reqs.filter_type=c_decimating_half_band or
                                                          fir_model_reqs.filter_type=c_polyphase_pq_dec_alt);
                                                        --disable output rate adapter for these structures as rate
                                                        --adaption is done at input buffer
    constant dra_threshold   : integer := select_integer(dra_deci_rate, 0,
                                                           fir_model_reqs.filter_type=c_decimating_half_band);--,

  begin
    if (rising_edge(clk)) then
      if (int_sclr='1') then
        dra_count := 0;
        dra_rdy   <= '0';
      elsif (int_ce='1') then
        
        if (cascade_out='1') then
          if dra_count = dra_threshold then
            dra_rdy   <= '1';
          else
            dra_rdy   <= '0';
          end if;
          if dra_count < (dra_deci_rate) then
            dra_count := dra_count + 1;
          else
            dra_count := 0;
          end if;
        else
          dra_rdy <= '0';
        end if;

      end if;
    end if;
  end process; -- dra_cnt

  -----------------------------------------------------------------------------
  -- OUTPUT BUFFER
  -- This process models the output buffering of the filter.
  -- There is a possibility of merging this function with the decimation rate
  -- adapter,as has been done with the interpolation rate adapter and input
  -- buffer.
  -----------------------------------------------------------------------------
  ob1: if buff_out_depth=0 generate

    rdy_early <= dra_rdy;

  end generate; -- ob1

  ob2: if buff_out_depth>0 generate

    ob2cnt: process (clk)
      variable opbuff_wrcnt     : integer   := 0;
      variable opbuff_rdcnt     : integer   := 0;
      variable opbuff_rden      : boolean   := false;
    begin
      if (rising_edge(clk)) then
        if (int_sclr='1') then
          opbuff_wrcnt := 0;
          opbuff_rdcnt := 0;
          opbuff_rden  := false;
          rdy_early    <= '0';
        elsif (int_ce='1') then
          
          -- rd_enable=false must come first, as setting true must take priority (by simulation order)
          -- when write and read occur on the same cycle.
          if opbuff_rden then
            if opbuff_rdcnt < (buff_out_depth*properties.opbuff_rate-1) then
              opbuff_rdcnt := opbuff_rdcnt + 1;
            else
              opbuff_rdcnt := 0;
              opbuff_rden  := false;
            end if;
          end if;
          
          -- Accumulate samples until all phases/channels available
          if (dra_rdy='1') then
            if opbuff_wrcnt = properties.opbuff_thresh then
              opbuff_rden  := true;
            end if;
            if opbuff_wrcnt < (buff_out_depth-1) then
              opbuff_wrcnt := opbuff_wrcnt + 1;
            else
              opbuff_wrcnt := 0;
            end if;
          end if;
          
          -- Generate an output RDY based on the read counter value
          if opbuff_rden and (opbuff_rdcnt mod properties.opbuff_rate)=0 then
            rdy_early <= '1';
          else
            rdy_early <= '0';
          end if;

        end if;
      end if;
    end process; -- ob2cnt  

  end generate; -- ob2

  -- Final register delay, the early signal allows output generation at the
  -- appropriate time.
  rdy_reg: process (clk)
  begin
    if (rising_edge(clk)) then
      if (int_sclr='1') then
        rdy_int <= '0';
	rdy_int_dly <=(others=>'0');
      elsif (int_ce='1') then
        rdy_int <= rdy_early;
	rdy_int_dly(channelizer_delay downto 1) <= rdy_int_dly(channelizer_delay-1 downto 0);
	rdy_int_dly(0)<=rdy_int;
      end if;
    end if;
  end process; -- no_buff_out

  RDY <= rdy_int;

  -----------------------------------------------------------------------------
  -- CHANNEL COUNTERS
  -----------------------------------------------------------------------------
  
  -- Input channel counter increments on every input and wraps based on NUM_CHANNELS
  chin_cnt: process (clk)
  begin
    if (rising_edge(clk)) then     
      if (int_sclr='1') then
        channel_in      <= 0;
      elsif (int_ce='1') then

        if push_ipbuff then
          if channel_in=NUM_CHANNELS-1 then
            channel_in <= 0;
          else
            channel_in <= channel_in+1;
          end if;
        end if;
      
      end if;
    end if;
  end process; -- ira_cnt

  --CHAN_IN  <= std_logic_vector(to_unsigned((channel_in-CHAN_IN_ADV) mod NUM_CHANNELS, CHAN_SEL_WIDTH)) when not(FILTER_TYPE=c_channelizer_receiver) and C_HAS_CHAN0_IN=0 else (others=>'0');
  CHAN_IN  <= std_logic_vector(to_unsigned((channel_in+CHAN_IN_ADV) mod NUM_CHANNELS, CHAN_SEL_WIDTH)) when not(FILTER_TYPE=c_channelizer_receiver) and C_HAS_CHAN0_IN=0 else (others=>'0');

  -----------------------------------------------------------------------------
  -- RFD GENERATION
  -- Currently all filter types use the clk_per_chan property as the basis for
  -- RFD generation counter, but this may need to be altered on a filter by
  -- filter basis in future versions.
  -- For the c_polyphase_pq_dec_alt structure rfd_int is generated in the input
  -- buffer section.
  -----------------------------------------------------------------------------
  gen_rfd_cnt: if fir_model_reqs.filter_type /= c_polyphase_pq_dec_alt generate
    rfd_cnt: process (clk)
      variable rfd_count    : integer := 0;
      variable rfd_cnt_en   : boolean := false;
      variable rfd_count_len: integer := select_integer(
                                          properties.clk_per_chan,
                                          1,
                                          fir_model_reqs.filter_type=c_channelizer_transmitter);
    begin
      if (rising_edge(clk)) then     
        if (int_sclr='1') then
          rfd_cnt_en   := false;
          rfd_count    := 0;
          rfd_int      <= '1';
          rfd_count_len:= select_integer(
                            properties.clk_per_chan,
                            1,
                            fir_model_reqs.filter_type=c_channelizer_transmitter);
        elsif (int_ce='1') then
          if push_ipbuff and rfd_count_len>1 then
            rfd_cnt_en   := true;
            rfd_int      <= '0';
          end if;
          if rfd_cnt_en and rfd_count < rfd_count_len then
            rfd_count    := rfd_count + 1;
          end if;
          if (rfd_cnt_en and rfd_count = rfd_count_len) or rfd_count_len = 1 then
            rfd_cnt_en := false;
            rfd_count  := 0;
            rfd_int    <= '1';
            if fir_model_reqs.filter_type=c_channelizer_transmitter and properties.clk_per_chan> 1 then
              if channel_in = fir_model_reqs.num_channels-1 then
                rfd_count_len:= fir_model_reqs.clk_per_samp-fir_model_reqs.num_channels+1;
                -- report "rfd count: "&int_to_str(rfd_count_len);
                if push_ipbuff then
                  rfd_cnt_en   := true;
                  rfd_int      <= '0';
                  rfd_count    := rfd_count + 1;
                end if;
              else
                rfd_count_len:= 1;
                -- report "rfd count: "&int_to_str(rfd_count_len);
              end if;
            elsif alter_input_rate and
               channel_in = fir_model_reqs.num_channels-1 then
              rfd_count_len:= properties.clk_per_chan+1;
            else
              rfd_count_len:= properties.clk_per_chan;
            end if;
          end if;
        end if;
      end if;
    end process; -- rfd_cnt
  end generate gen_rfd_cnt;
  
  gen_rfd_map: if fir_model_reqs.filter_type = c_polyphase_pq_dec_alt generate
    rfd_int<=rfd_int_alt;
  end generate gen_rfd_map;
  
  RFD <= rfd_int;


  -----------------------------------------------------------------------------
  -- RELOAD MODEL
  -----------------------------------------------------------------------------
  grld1: if COEF_RELOAD = 1 generate
  begin

    ---------------------------------------------------------------------------
    -- RELOAD INTERFACE
    -- Read in the reloaded coefficients, then re-order, and finally store in
    -- the reload array on the appropriate page
    ---------------------------------------------------------------------------
    -- RELOAD DELAY PIPE
    -- The value -1 will be used as the default value for the reload pipe and
    -- will be interpreted as a NOP.  Anything greater than 0 but less than 
    -- NUM_FILTS which emerges from the delay pipe will be regarded as a
    -- switch of reload page for the filter set corresponding to that value.
    ---------------------------------------------------------------------------
    rld1: process (clk)
      
      variable reload_count       : integer := 0;
      variable reload_cnt_en      : boolean := false;
      variable temp_set           : integer := 0;
      variable temp_coeff         : t_reload_coeffs := (others=>(others=>'0'));
      variable reordered_coeffs   : t_coefficients_slv  := (others=>(others=>'0'));
      variable reload_temp        : t_split_coeff   := (others=>0);
      variable reloaded_coeffs    : t_coeff_pages   := (others=>(others=>0));
      variable reload_done        : integer         := -1;
      variable reload_end         : integer         := -1;

      variable push_regressor_dly   : t_push_regressor_dly   := (others=>false);
      variable push_regressor_rld   : boolean:=false;
      variable filter_fsel_dly      : t_filter_fsel_dly      := (others=>0);
      variable filter_fsel_rld      : integer:=0;
      variable filter_channel_dly   : t_filter_channel_dly   := (others=>0);
      variable filter_channel_rld   : integer:=0;

      variable reload_status : t_reload_status:=reload_status_init;
    begin

      if (rising_edge(clk)) then
        
        --Core reload logic is not reset following a SCLR but the reload_status must have its phase counts
        --reset
        if (int_sclr='1') then
          reload_status:=reload_status_init;
        end if;

        if (int_ce='1') then

          --Generate local copy of push_regressor_dly and filter_fsel_dly
          push_regressor_dly(1 to reload_dly_len-2)   := push_regressor_dly(0 to reload_dly_len-3);
          push_regressor_dly(0)                       := push_regressor;
          push_regressor_rld   := push_regressor_dly(reload_dly_len-3);
          filter_fsel_dly(1 to reload_dly_len-2)      := filter_fsel_dly(0 to reload_dly_len-3);
          filter_fsel_dly(0)                          := filter_fsel;
          filter_fsel_rld      := filter_fsel_dly(reload_dly_len-3);
          filter_channel_dly(1 to reload_dly_len-2)   := filter_channel_dly(0 to reload_dly_len-3);
          filter_channel_dly(0)                       := filter_channel;
          filter_channel_rld   := filter_channel_dly(reload_dly_len-3);

          if (int_sclr='0') then
            reload_status:=update_filter_page( reload_status,
                                               push_regressor_rld and 
                                               (fir_model_reqs.filter_type /= c_polyphase_pq_dec_alt or
                                                (fir_model_reqs.filter_type = c_polyphase_pq_dec_alt and not push_regressor_dly(reload_dly_len-2))),
                                               --add extra qualification when alt pq dec structure as push_regressor will be high for multiplie clock cycles
                                               --as it is shifting in more than one sample
                                               filter_channel_rld,
                                               reload_pntr,
                                               reload_pntr_current,
                                               COEF_LD,
                                               to_integer(unsigned(COEF_FILTER_SEL)),
                                               filter_fsel_rld );
          end if;

          --Read in reload coefficients
          if reload_cnt_en and COEF_WE='1' and reload_count < properties.reload_taps and COEF_LD='0' then

            -- Read in the new coefficient and split into pages if necessary
            temp_coeff(reload_count) := COEF_DIN;

            -- Increment the count
            reload_count    := reload_count + 1;

          end if;

          -- Check for start of a reload sequence or an abort
          if COEF_LD='1' then
            reload_count  := 0;
            reload_cnt_en := true;
            temp_set      := to_integer(unsigned(COEF_FILTER_SEL));
            if reload_pntr_current(temp_set) /=  reload_pntr(temp_set) and
               not(reload_status.reload_pntr_update(filter_fsel_rld) = reload_pntr(temp_set) and
                filter_fsel_rld=temp_set) then
              reload_pntr(temp_set) <= (reload_pntr(temp_set)-1) mod (reload_pointer_max+1);

            end if;

          end if;

          reload_done := -1;
          
          -- Check for end of a reload sequence
          if (reload_cnt_en and reload_count = properties.reload_taps) then
            
            -- Reset the temporary coefficient stores
            reordered_coeffs := (others=>(others=>'0'));
            reload_temp      := (others=>0);
            reloaded_coeffs  := (others=>(others=>0));

            -- Finished reload, so reset count
            reload_cnt_en := false;
            reload_count  := 0;

            -- Pass a set switch flag down the pipe to the output stage
            reload_done   := temp_set;

            -- Reorder the coefficients according to the reload order
            reordered_coeffs := do_coeff_reorder(temp_coeff,properties.reorder_seq,COEF_WIDTH);--reload_order);--

            -- Assign the coeffs into the paged array appropriately
            for i in 0 to properties.full_taps-1 loop
              reload_temp := split_reload_coeff( reordered_coeffs(i), split_cwidth, cpages );
              for j in 0 to cpages-1 loop
                reloaded_coeffs(j)(i) := reload_temp(j);
              end loop;
            end loop;

            -- Load rearranged coefficients into the main coefficient array on
            -- the appropriate reload page
            reload_sets((reload_pntr(temp_set)+1) mod (reload_pointer_max+1))(temp_set) <= reloaded_coeffs;

            -- Reset the temporary coefficient stores
            temp_coeff := (others=>(others=>'0'));
            temp_set   := 0;

          end if;
          
          --No latency associate with reload complete now
          reload_end := reload_done;

          if (reload_end >= 0) and (reload_end < NUM_FILTS) then
            reload_pntr(reload_end) <= (reload_pntr(reload_end)+1) mod (reload_pointer_max+1);
          end if;

        end if;

      end if;
      
    end process; -- rld1

  end generate; -- grld1

end behavioral;
