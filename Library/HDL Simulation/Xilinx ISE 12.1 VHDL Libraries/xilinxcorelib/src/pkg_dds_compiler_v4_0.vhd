-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 4.0
--  \   \        Filename: $RCSfile: pkg_dds_compiler_v4_0.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:32 $
-- /___/   /\    Date Created: 2006
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : dds_compiler_v4_0
-- Purpose : Package of common utility functions for sim, hdl and tcl
-------------------------------------------------------------------------------
--  (c) Copyright 2006-2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES.
-------------------------------------------------------------------------------
library std, ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

package pkg_dds_compiler_v4_0 IS
  
  -- Set TRUE to enable high SFDR with Noise Shaping = None
  constant CI_EXTENDED_OP       : boolean := TRUE;

  --circuit constants
  constant c_sc_only_off_thresh  : integer := 16; -- Threshold at which offset is added to sine cos LUT (allows size reduction)
  constant c_sin_cos_addr_limit  : integer := 12; -- Max address for single BRAM with half and qtr (in op width <=18)
  constant c_sc_no_trans_limit   : integer := 14; -- Maximum address size for SC LUT with no half/qrt transformation
  constant ci_max_no_channels    : integer := 16;
  constant ci_adder_pipe_thresh  : integer := 12;  -- width above which adder must be piped to achieve 400MHz

  --poor man's enumerated types
  --C_PHASE_INCREMENT
  constant c_phase_inc_none      : integer := 0;
  constant c_phase_inc_prog      : integer := 1;
  constant c_phase_inc_fixed     : integer := 2;
  constant c_phase_inc_streaming : integer := 3;

  --C_PHASE_OFFSET
  constant c_phase_adj_none      : integer := 0;
  constant c_phase_adj_prog      : integer := 1;
  constant c_phase_adj_fixed     : integer := 2;
  constant c_phase_adj_streaming : integer := 3;

  --C_NOISE_SHAPING
  constant c_noise_shaping_off    : integer := 0;
  constant c_noise_shaping_dither : integer := 1;
  constant c_noise_shaping_taylor : integer := 2;

  --C_OUTPUTS_REQUIRED
  constant c_sine_op_reqd   : integer := 0;
  constant c_cosine_op_reqd : integer := 1;
  constant c_both_op_reqd   : integer := 2;

  --C_MEM_TYPE
  constant c_rom_auto  : integer := 0;
  constant c_rom_block : integer := 1;
  constant c_rom_dist  : integer := 2;

  --C_OPTIMISE_GOAL
  constant c_opt_area  : integer := 0;
  constant c_opt_speed : integer := 1;

  constant c_mem_thresh : integer := 2048;  --the point at which block is
--better than distributed memory (needs to be justified)

  --dither operation
  constant c_max_lfsr_size : integer := 34;  --LFSR has to be bigger than error
  constant ci_small_lfsr_max : integer := 9;
  constant ci_medium_lfsr_max : integer := 17;
  constant ci_large_lfsr_max : integer := 24;

  -- Define integer opcodes for dsp48_accum
  -- The encoding use is derived from the DSP48E encoding
  constant C_ADD_AB          : integer := 15;
  constant C_ADD_P           : integer := 51;
  constant PCIN_ADD_C_ADD_AB : integer := 31;
  constant PCIN_ADD_AB       : integer := 19;

  -- Starting angle size for sin-cos table construction 
  constant CI_SIN_ADDRESS_WIDTH : integer := 17;
  -- purpose: determines if the rom is quarter, half or full sine wave
  type enum_range is (e_double, e_full, e_half, e_quarter);

  type t_we_use is (WE_NOT_USED, WE_ON_C_REG, WE_ON_ABD_REG);

  type t_rom_type is (BLOCK_ROM, DIST_ROM);

  type t_resources is record
    dsp48    : integer;
    bram18k  : integer;
    luts     : integer;
    ffs      : integer;
  end record;

  constant ci_max_channels   : integer := 16;
  constant ci_max_data_width : integer := 51;  --was 36+3 carry saves, now 48+3
  type t_ram_type is array (0 to ci_max_channels-1) of std_logic_vector(ci_max_data_width-1 downto 0);

  -- purpose: resolve dsp48 according to generic and family
  function fn_use_dsp48 (
    p_use_dsp48 : integer;
    p_xdevicefamily    : string)
    return integer;

  -- purpose: Determine width of dither generator
  function fn_dither_width (
    p_accumulator_width : integer;
    p_phase_angle_width : integer)
    return integer;

  -- purpose: Determine whether Taylor Correction (EFF) is to follow SC LUT
  function fn_eff_to_follow (
    p_noise_shaping : integer)
    return integer;

    -- purpose: resolve MEM_TYPE auto
  function fn_mem_type (
    P_MEM_TYPE          : integer;
    P_PHASE_ANGLE_WIDTH : integer;
    P_XDEVICEFAMILY     : string
    )
    return integer;

  -- purpose: Check validity of generics
  function check_generics (
    P_XDEVICEFAMILY         : string;
    P_ACCUMULATOR_WIDTH     : integer;
    P_CHANNELS              : integer;
    P_HAS_CE                : integer;
    P_HAS_CHANNEL_INDEX     : integer;
    P_HAS_RDY               : integer;
    P_HAS_RFD               : integer;
    P_HAS_SCLR              : integer;
    P_HAS_PHASE_OUT         : integer;  -- phase_out pin visible
    P_HAS_PHASEGEN          : integer;  -- generate the phase
    P_HAS_SINCOS            : integer;  -- instantiate sin/cos function
    P_LATENCY               : integer;
    P_MEM_TYPE              : integer;
    P_NEGATIVE_COSINE       : integer;
    P_NEGATIVE_SINE         : integer;
    P_NOISE_SHAPING         : integer;
    P_OUTPUTS_REQUIRED      : integer;
    P_OUTPUT_WIDTH          : integer;
    P_PHASE_ANGLE_WIDTH     : integer;
    P_PHASE_INCREMENT       : integer;
    P_PHASE_INCREMENT_VALUE : string;
    P_PHASE_OFFSET          : integer;
    P_PHASE_OFFSET_VALUE    : string;
    P_OPTIMISE_GOAL         : integer;
    P_USE_DSP48             : integer;
    P_POR_MODE              : integer;    
    P_AMPLITUDE             : integer
    )
  return integer;

  constant ci_rom_pipe_stages   : integer := 5;

  constant ci_ip_reg_stage      : integer := 0;
  constant ci_addr_mod_stage    : integer := 1;
  constant ci_rom_addr_stage    : integer := 2;
  constant ci_rom_op_stage      : integer := 3;
  constant ci_rom_speedup_stage : integer := 4;
  constant ci_data_mod_stage    : integer := 5;


  type t_acc_config is record
                         num_segments  : integer;
                         segment_width : integer;
                       end record;
  -- purpose: determines splicing of accumulated phase bus for pipelined adders
  function fn_acc_config (
    p_accumulator_width : integer;
    p_extra_latency     : integer)
    return t_acc_config;

  type t_sin_cos_pipe is array (0 to ci_rom_pipe_stages) of integer;
  type t_sin_cos_lat_alloc_return is record
                                        used : integer;
                                        pipe : t_sin_cos_pipe;
                                      end record;
                                      
  -- purpose: Determine latency (and allocate registers) for SC LUT
  function fn_sin_cos_allocate_latency (
    p_latency           : integer;
    p_xdevicefamily     : string;
    p_eff_to_follow     : integer;
    p_phase_angle_width : integer;
    p_mem_type          : integer;
    p_phase_offset_req  : boolean
    )
    return t_sin_cos_lat_alloc_return;

  constant ci_eff_pipe_stages : integer := 5;

  type t_eff_pipe is array (0 to ci_eff_pipe_stages) of integer;
  type t_eff_lat_alloc_return is record
    used : integer;
    pipe : t_eff_pipe;
  end record;

  -- purpose: Determine latency (And allocate registers) for Taylor Correction
  --          (EFF) unit
  function fn_eff_allocate_latency (
    p_latency      : integer;
    p_taylor_order : integer
    )
    return t_eff_lat_alloc_return;
  -----------------------------------------------------------------------------
  -- Function to allocate latency to latency opportunities for the top level
  -- synth model. This is partly used by the behv model to get offset delays.
  -----------------------------------------------------------------------------
  --latency stages
  constant ci_pipe_ops_top      : integer := 12;
  constant ci_store_stage       : integer := 0;  -- pinc and poff store pipeline stage
  constant ci_ctrl2dsp_stage    : integer := 1;
  constant ci_phase_acc_stage   : integer := 2;
  constant ci_phase_adj_stage   : integer := 3;
  constant ci_dither_add_stage  : integer := 4;
  constant ci_accel_stage       : integer := 5;  -- allowed piped adders
  constant ci_phase_final_stage : integer := 6;
  constant ci_LUT_stage         : integer := 7;
  constant ci_eff_stage         : integer := 8;
  constant ci_pre_op_stage      : integer := 11;
  constant ci_op_reg_stage      : integer := 12;

  type t_pipe_top is array (0 to ci_pipe_ops_top) of integer;
  type t_latency_allocation_return is record
                                        used    : integer;    -- total latency
                                        pg_lat  : integer;    -- phase generator latency
                                        sc_lat  : integer;    -- sincos LUT latency
                                        min_lat : integer; -- minimum latency
                                        pipe    : t_pipe_top;
                                      end record;

  -- purpose: Determine latency (and allocate registers) for DDS core
  function fn_dds_compiler_v4_0_latency(
    p_xdevicefamily       : string;
    p_has_phasegen        : integer;
    p_has_sincos          : integer;
    p_latency             : integer;
    p_mem_type            : integer;
    p_accumulator_width   : integer;
    p_noise_shaping       : integer;
    p_phase_angle_width   : integer;
    p_phase_increment     : integer;    
    p_phase_offset        : integer;
    p_optimise_goal       : integer;
    p_use_dsp48           : integer;
    p_channels            : integer;
    p_output_width        : integer
    )
    return t_latency_allocation_return;

  -- purpose: Determine latency of SC LUT
  function fn_get_sin_cos_latency (
    p_pipe : t_pipe_top)
    return integer;

  -- purpose: get PI to the required width
  function fn_get_pi (
    p_width   : integer)
    return std_logic_vector;

  -- purpose: Determine BRAM and DSP48 resources used by core
  function fn_dds_compiler_v4_0_resources (
    P_XDEVICEFAMILY         : string  := "virtex4";
    P_ACCUMULATOR_WIDTH     : integer := 28;  -- width of accum and associated paths. Factor in Frequency resolution
    P_CHANNELS              : integer := 1;  -- number of time-multiplexed channels output
    P_HAS_CE                : integer := 0;  -- enables input CE port.
    P_HAS_CHANNEL_INDEX     : integer := 0;  -- enables CHANNEL output port
    P_HAS_RDY               : integer := 1;  -- enables RDY output port
    P_HAS_RFD               : integer := 0;  -- enables RFD input port (RFD is always true)
    P_HAS_SCLR              : integer := 0;  -- enables SCLR input port
    P_HAS_PHASE_OUT         : integer := 0;  -- phase_out pin visible
    P_HAS_PHASEGEN          : integer := 1;  -- generate the phase accumulator
    P_HAS_SINCOS            : integer := 1;  -- generate the sin/cos block
    P_LATENCY               : integer := 5;  -- Selects overall latency, -1 means 'fully pipelined for max performance'
    P_MEM_TYPE              : integer := 1;  -- 0 = DIST_ROM, 1 = Block ROM;
    P_NEGATIVE_COSINE       : integer := 0;  -- 0 = normal cosine, 1 = negated COSINE output port
    P_NEGATIVE_SINE         : integer := 0;  -- 0 = normal sine, 1 = negated SINE output port
    P_NOISE_SHAPING         : integer := 2;  -- 0 = none, 1 = Dither, 2 = Error Feed Forward (Taylor)
    P_OUTPUTS_REQUIRED      : integer := 2;  -- 0 = SIN, 1 = COS, 2 = Both;
    P_OUTPUT_WIDTH          : integer := 23;  -- sets width of output port (factor in SFDR)
    P_PHASE_ANGLE_WIDTH     : integer := 6;  -- width of phase fed to RAM (factor in RAM resource used)
    P_PHASE_INCREMENT       : integer := 2;  -- 1 = register, 2 = constant, 3 = streaming (input port);
    P_PHASE_INCREMENT_VALUE : string  := "0";  -- string of values for PINC, one for each channel.
    P_PHASE_OFFSET          : integer := 0;  -- 0 = none, 1 = reg, 2 = const, 3 = stream (input port);
    P_PHASE_OFFSET_VALUE    : string  := "0";  -- string of values for POFF, one for each channel
    P_OPTIMISE_GOAL         : integer := 0;  -- 0 = area, 1 = speed
    P_USE_DSP48             : integer := 0;  -- 0 = minimal 1 = max. Determines DSP48 use in phase accumulation.
    P_POR_MODE              : integer := 0;
    P_AMPLITUDE             : integer := 0  -- 0 = full scale (+/- 2^N-2), 1 = unit circle (+/- 2^(N-1))
    )
    return t_resources;
  
  -- porpose: Determine order of Taylor Correction (assuming Taylor is being used)
  function fn_get_taylor_order (
    p_output_width : integer)
    return integer;

  -- For accumulator
  type t_impl is (e_fabric, e_dsp48);

  -- purpose: chooses which architecture to implement
  function fn_choose_accum_impl (
    p_xdevicefamily   : string;
    p_use_dsp48       : integer)
    return t_impl;

  -- Need to include 0.5LSB phase offset if truncating phase in LUT
  function fn_phase_offset_req(p_has_phasegen      : integer;
                               p_has_sincos        : integer;
                               p_noise_shaping     : integer;
                               p_output_width      : integer;
                               p_accumulator_width : integer;
                               p_phase_angle_width : integer) return boolean;

  -- purpose: To balance delay of PINC and POFF to get better latency model
  function fn_get_poff_bal_delay (
    p_impl : t_impl;
    p_pipe : t_pipe_top)
    return integer;

  -- purpose: determine whether or not to use c_reg of dsp48 for pinc or poff
  -- Functionality commented out is for future (requires GUI mods to enable)
  function fn_dspreg_as_pincpoff (
    p_channels              : integer;
    --p_accumulator_width     : integer;
    p_use_dsp48             : integer;
    p_phase_increment       : integer;
    --p_phase_increment_value : string;
    p_phase_offset          : integer;
    --p_phase_offset_value    : string;
    p_optimise_goal         : integer)
    return boolean;

  -- purpose: Determine whether dsp48 creg should be used for PINC register
  function fn_dspreg_as_pinc (
    p_channels             : integer;
    p_use_dsp48            : integer;
    p_phase_increment      : integer;
    p_phase_offset         : integer;
    p_optimise_goal        : integer)
    return boolean;

  -- purpose: Determine whether dsp48 creg should be used for POFF register
  function fn_dspreg_as_poff (
    p_channels             : integer;
    p_use_dsp48            : integer;
    p_phase_increment      : integer;
    p_phase_offset         : integer;
    p_optimise_goal        : integer)
    return boolean;

  -- purpose : determine when sin-cos bias required (shifts point down a little to reduce overall error)   
  function fn_get_eff_bias(
    p_noise_shaping     : integer;
    p_output_width      : integer) 
    return boolean;    

-------------------------------------------------------------------------------
-- Functions to support sin_cos component
-------------------------------------------------------------------------------
  -- purpose: convert MEM_STYLE generic into a local enumerated type
  function fn_ram_style (
    p_mem_type          : integer
    )
    return string;

  -- purpose: determines address width of ROM primitive
  function fn_rom_addr_width (
    p_addr_width     : integer;
    p_mem_type       : integer;
    p_no_half_or_qtr : boolean)
    return integer;

  -- purpose: determines if the rom is quarter, half or full sine wave
  function fn_calc_rom_range (
    p_addr_width     : integer;
    p_rom_addr_width : integer)
    return enum_range;

  -- purpose: determines data width of ROM
  function fn_rom_data_width (
    p_data_width : integer;
    p_range      : enum_range
    )
    return integer;

  -- purpose: Determine data width of ram (SC ROM)
  function fn_ram_output_width (
    p_output_width : integer;
    p_noise_shaping : integer)
    return integer;

  --This function parses the core interface string parameter holding all the PINC or POFF values into a
  --more palatable array of std_logic_vectors which can then be fed to inferrence
  --to get a RAM (with any luck)
  function fn_init_ram(
    p_val        : string;
    p_channels   : integer;
    p_chan_width : integer;   
    p_data_width : integer
    )
    return t_ram_type;

end package pkg_dds_compiler_v4_0;

package body pkg_dds_compiler_v4_0 IS

  -- purpose: resolve dsp48 according to generic and family
  function fn_use_dsp48 (
    p_use_dsp48 : integer;
    p_xdevicefamily    : string)
    return integer is
  begin  -- fn_use_dsp48
    if has_dsp(p_xdevicefamily) then
      return p_use_dsp48;
    end if;
    return 0;
  end fn_use_dsp48;

  function fn_dither_width (
    p_accumulator_width : integer;
    p_phase_angle_width : integer)
    return integer is
    variable ret : integer;
  begin
    ret := 10;                          --default
    if(p_accumulator_width - p_phase_angle_width) < 10 then
      --dont ask me, this comes straight from DDS_v5_0
      ret := p_accumulator_width-p_phase_angle_width+1;
    end if;
    return ret;
  end fn_dither_width;

  function fn_eff_to_follow (
    p_noise_shaping : integer)
    return integer is
  begin
    case p_noise_shaping is
      when c_noise_shaping_taylor => return 1;
      when others                 => return 0;
    end case;
  end fn_eff_to_follow;

  --Dont leave the decision to XST - make the decision!
  function fn_mem_type (
    P_MEM_TYPE          : integer;
    P_PHASE_ANGLE_WIDTH : integer;
    P_XDEVICEFAMILY     : string
    )
    return integer is
    variable ret : integer;
  begin
    if P_MEM_TYPE /= c_rom_auto then
      return P_MEM_TYPE;
    else
      if supports_lut6(p_xdevicefamily) > 0 then
        if P_PHASE_ANGLE_WIDTH > 5 then
          return c_rom_block;
        else
          return c_rom_dist;
        end if;
      else
        if P_PHASE_ANGLE_WIDTH > 4 then
          return c_rom_block;
        else
          return c_rom_dist;
        end if;
      end if;
    end if;
  end fn_mem_type;
  
  -----------------------------------------------------------------------------
  -- Unlike Check Generics of lore, this is really only range checking. Interactions
  -- are handled in the fn_generic_parser of the top level of the structural model.
  -----------------------------------------------------------------------------
  function check_generics (
    P_XDEVICEFAMILY         : string;
    P_ACCUMULATOR_WIDTH     : integer;
    P_CHANNELS              : integer;
    P_HAS_CE                : integer;
    P_HAS_CHANNEL_INDEX     : integer;
    P_HAS_RDY               : integer;
    P_HAS_RFD               : integer;
    P_HAS_SCLR              : integer;
    P_HAS_PHASE_OUT         : integer;  -- phase_out pin visible
    P_HAS_PHASEGEN          : integer;  -- generate the phase
    P_HAS_SINCOS            : integer;  -- instantiate sin/cos function
    P_LATENCY               : integer;
    P_MEM_TYPE              : integer;
    P_NEGATIVE_COSINE       : integer;
    P_NEGATIVE_SINE         : integer;
    P_NOISE_SHAPING         : integer;
    P_OUTPUTS_REQUIRED      : integer;
    P_OUTPUT_WIDTH          : integer;
    P_PHASE_ANGLE_WIDTH     : integer;
    P_PHASE_INCREMENT       : integer;
    P_PHASE_INCREMENT_VALUE : string;
    P_PHASE_OFFSET          : integer;
    P_PHASE_OFFSET_VALUE    : string;
    P_OPTIMISE_GOAL         : integer;
    P_USE_DSP48             : integer;
    P_POR_MODE              : integer;    
    P_AMPLITUDE             : integer
    )
    return integer is
    variable v_mem_type : integer := fn_mem_type(
      P_MEM_TYPE          => P_MEM_TYPE          ,
      P_PHASE_ANGLE_WIDTH => P_PHASE_ANGLE_WIDTH ,
      P_XDEVICEFAMILY     => P_XDEVICEFAMILY
      );
    
    constant ci_use_dsp48        : integer := fn_use_dsp48(P_USE_DSP48, P_XDEVICEFAMILY);

    -- Determine minimum latency so that we can check we are not out of bounds
    constant c_lat_alloc         : t_latency_allocation_return := fn_dds_compiler_v4_0_latency(
      p_xdevicefamily       => P_XDEVICEFAMILY,
      p_has_phasegen        => P_HAS_PHASEGEN,
      p_has_sincos          => P_HAS_SINCOS,
      p_latency             => P_LATENCY,
      p_mem_type            => P_MEM_TYPE,
      p_accumulator_width   => P_ACCUMULATOR_WIDTH,
      p_noise_shaping       => P_NOISE_SHAPING,
      p_phase_angle_width   => P_PHASE_ANGLE_WIDTH,
      p_phase_increment     => P_PHASE_INCREMENT,
      p_phase_offset        => P_PHASE_OFFSET,
      p_optimise_goal       => P_OPTIMISE_GOAL,
      p_use_dsp48           => ci_use_dsp48,
      p_channels            => P_CHANNELS,
      p_output_width        => P_OUTPUT_WIDTH
      );

     constant ci_min_lat : integer := c_lat_alloc.min_lat;
  begin

    --C_ACCUMULATOR_WIDTH
    assert P_ACCUMULATOR_WIDTH >= 3 AND P_ACCUMULATOR_WIDTH <= 48
      report "ERROR: C_ACCUMULATOR_WIDTH must be between 3 and 48 inclusive"
      severity ERROR;

    --C_CHANNELS
    assert P_CHANNELS > 0 AND P_CHANNELS <= 16
      report "ERROR: C_CHANNELS must be between 1 and 16"
      severity ERROR;

    --C_HAS_CE
    assert P_HAS_CE = 0 or P_HAS_CE = 1
      report "ERROR: C_HAS_CE must be either 0 or 1"
      severity ERROR;

    --C_HAS_CHANNEL_INDEX     
    assert P_HAS_CHANNEL_INDEX = 0 or P_HAS_CHANNEL_INDEX = 1
      report "ERROR: C_HAS_CHANNEL_INDEX must be either 0 or 1"
      severity ERROR;

    --C_HAS_RDY               
    assert P_HAS_RDY = 0 or P_HAS_RDY = 1
      report "ERROR: C_HAS_RDY must be either 0 or 1"
      severity ERROR;

    --C_HAS_RFD               
    assert P_HAS_RFD = 0 or P_HAS_RFD = 1
      report "ERROR: C_HAS_RFD must be either 0 or 1"
      severity ERROR;
    
    --C_HAS_SCLR              
    assert P_HAS_SCLR = 0 or P_HAS_SCLR = 1
      report "ERROR: C_HAS_SCLR must be either 0 or 1"
      severity ERROR;

 	 --C_HAS_PHASE_OUT
    assert P_HAS_PHASE_OUT = 0 or P_HAS_PHASE_OUT = 1
      report "ERROR: C_HAS_PHASE_OUT must be either 0 or 1"
      severity ERROR;

	 --C_HAS_PHASEGEN
    assert P_HAS_PHASEGEN = 0 or P_HAS_PHASEGEN = 1
      report "ERROR: C_HAS_PHASEGEN must be either 0 or 1"
      severity ERROR;

    -- Must have PHASE_OUT for Phase Generator
    if P_HAS_PHASEGEN = 1 and P_HAS_SINCOS = 0 then
      assert P_HAS_PHASE_OUT = 1
        report "ERROR: C_HAS_PHASE_OUT must be 1 if C_HAS_PHASEGEN is 1 and C_HAS_SINCOS is 0"
        severity ERROR;
    end if;

	 --C_HAS_SINCOS
    assert P_HAS_SINCOS = 0 or P_HAS_SINCOS = 1
      report "ERROR: C_HAS_SINCOS must be either 0 or 1"
      severity ERROR;

    --C_LATENCY
    assert P_LATENCY = -1 or (P_LATENCY >= ci_min_lat and P_LATENCY <= 15)
      report "ERROR: C_LATENCY (" & integer'image(P_LATENCY) & ") must be -1 or between " & integer'image(ci_min_lat) & " and 15"
      severity ERROR;

    --for block mem and sclr, latency must be min of 

    --C_MEM_TYPE               
    assert P_MEM_TYPE = 0 or P_MEM_TYPE = 1 or P_MEM_TYPE = 2
      report "ERROR: C_MEM_TYPE must be 0(auto), 1(block) or 2(distributed)"
      severity ERROR;

    --C_NEGATIVE_COSINE
    assert P_NEGATIVE_COSINE = 0 or P_NEGATIVE_COSINE = 1
      report "ERROR: C_NEGATIVE_COSINE must be 0 or 1"
      severity ERROR;

    --C_NEGATIVE_SINE         
    assert P_NEGATIVE_SINE = 0 or P_NEGATIVE_SINE = 1
      report "ERROR: C_NEGATIVE_SINE must be 0 or 1"
      severity ERROR;

    --C_NOISE_SHAPING
    assert P_NOISE_SHAPING = 0 or P_NOISE_SHAPING = 1 or P_NOISE_SHAPING = 2
      report "ERROR: C_NOISE_SHAPING must be 0, 1, or 2"
      severity ERROR;

    --C_OUTPUTS_REQUIRED  (ignored in C_HAS_SINCOS=0)
    assert P_OUTPUTS_REQUIRED = 0 or P_OUTPUTS_REQUIRED = 1 or P_OUTPUTS_REQUIRED = 2
      report "ERROR: C_OUTPUTS_REQUIRED must be 0, 1, or 2"
      severity ERROR;

    --C_OUTPUT_WIDTH
    assert P_OUTPUT_WIDTH > 2 and P_OUTPUT_WIDTH <= 27
      report "ERROR: C_OUTPUT_WIDTH must be in the range 2 to 27"
      severity ERROR;

    --when using taylor, output_width must be greater than C_PHASE_ANGLE_WIDTH
    assert P_OUTPUT_WIDTH > P_PHASE_ANGLE_WIDTH or P_NOISE_SHAPING /= c_noise_shaping_taylor
      report "ERROR: C_OUTPUT_WIDTH must be greater than C_PHASE_ANGLE_WIDTH when C_NOISE_SHAPING=2 (Taylor Series correction)"
      severity ERROR;
    
    -- C_PHASE_ANGLE_WIDTH
    if P_NOISE_SHAPING = c_noise_shaping_dither then
      assert (P_PHASE_ANGLE_WIDTH > 1 and P_PHASE_ANGLE_WIDTH <= 16)
        report "ERROR: C_PHASE_ANGLE_WIDTH must be in the range 2 to 16 for dithered cases"
        severity ERROR;
    elsif P_NOISE_SHAPING = c_noise_shaping_taylor then
      assert (P_PHASE_ANGLE_WIDTH > 1 and P_PHASE_ANGLE_WIDTH <= 11)
        report "ERROR: C_PHASE_ANGLE_WIDTH must be in the range 2 to 11 for taylor corrected cases"
        severity ERROR;
    else
      assert (P_PHASE_ANGLE_WIDTH > 1 and P_PHASE_ANGLE_WIDTH <= 16)
        report "ERROR: C_PHASE_ANGLE_WIDTH must be in the range 2 to 11 inclusive"
        severity ERROR;
    end if;

    assert (P_PHASE_ANGLE_WIDTH <= P_ACCUMULATOR_WIDTH)
      report "ERROR: phase angle width must not be greater than accumulator width"
      severity ERROR;

    --C_PHASE_INCREMENT
    assert P_PHASE_INCREMENT = 1 or P_PHASE_INCREMENT = 2  or P_PHASE_INCREMENT = 3
      report "ERROR: C_PHASE_INCREMENT must be 1, 2 or 3"
      severity ERROR;

    --C_PHASE_INCREMENT_VALUE  is a string, so checking is delegated to the parser

    --C_PHASE_OFFSET
    assert P_PHASE_OFFSET = 0 or P_PHASE_OFFSET = 1 or P_PHASE_OFFSET = 2 or P_PHASE_OFFSET = 3
      report "ERROR: C_PHASE_OFFSET must be 0, 1, 2 or 3"
      severity ERROR;

    --C_PHASE_OFFSET_VALUE  is a string, so checking is delegated to the parser

    --C_OPTIMISE_GOAL
    assert P_OPTIMISE_GOAL = 0 or P_OPTIMISE_GOAL = 1
      report "ERROR: C_OPTIMISE_GOAL must be 0 or 1"
      severity ERROR;

    --C_USE_DSP48
    assert P_USE_DSP48 = 0 or P_USE_DSP48 = 1
      report "ERROR: C_USE_DSP48 must be 0 or 1"
      severity ERROR;

    --P_POR_MODE
    assert P_POR_MODE = 0 or P_POR_MODE = 1
      report "ERROR: C_POR_MODE must be 0 or 1"
      severity ERROR;

    --C_AMPLITUDE
    assert P_AMPLITUDE = 0 or P_AMPLITUDE = 1
      report "ERROR: C_AMPLITUDE must be 0 or 1"
      severity ERROR;

    return 0;
  end check_generics;
    
  -- purpose: determines splicing of accumulated phase bus for pipelined adders
  function fn_acc_config (
    p_accumulator_width : integer;
    p_extra_latency     : integer)
    return t_acc_config is
    variable ret : t_acc_config;
  begin  -- fn_acc_config
    ret.num_segments := p_extra_latency +1;
    ret.segment_width := p_accumulator_width/ret.num_segments;
    return ret;
  end fn_acc_config;



  function fn_sin_cos_allocate_latency (
    p_latency           : integer;
    p_xdevicefamily     : string;
    p_eff_to_follow     : integer;
    p_phase_angle_width : integer;
    p_mem_type          : integer;
    p_phase_offset_req  : boolean

    )
    return t_sin_cos_lat_alloc_return is
    variable v_latency_left : integer;
    variable ret_val : t_sin_cos_lat_alloc_return;
    variable v_has_input_mapping_stage : integer;
    variable v_has_output_mapping_stage : integer;
    
    constant ci_mem_type         : integer := fn_mem_type(p_mem_type,p_phase_angle_width,p_xdevicefamily);
    constant ci_mem_style        : string  := fn_ram_style(ci_mem_type);
    constant ci_p_no_half_or_qtr : boolean := not(p_phase_offset_req);
    constant ci_rom_addr_width   : integer := fn_rom_addr_width(
        p_addr_width     => p_phase_angle_width,
        p_mem_type       => ci_mem_type,
        p_no_half_or_qtr => false -- need to disable optimizations if no phase offset
        );
    constant ci_range            : enum_range := fn_calc_rom_range(p_phase_angle_width, ci_rom_addr_width);

  begin  -- fn_allocate_latency
    for i  in 0 to ci_rom_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used := 0;
    
    -- This should be re-witten to use established function calls.
    case ci_range is
    when e_half =>
      v_has_input_mapping_stage := 1;
      if p_phase_offset_req then
        v_has_output_mapping_stage := 0;
      else
        -- need mapping stage to handle patch-up stage required if no phase offset      
        v_has_output_mapping_stage := 1;
      end if;
    when e_quarter =>
      v_has_input_mapping_stage := 1;
      v_has_output_mapping_stage := 1;
    when others =>
      v_has_input_mapping_stage := 0;
      v_has_output_mapping_stage := 0;
    end case;

    v_latency_left := p_latency;

    --In Vx4/5 this is the input reg. In other families, this is the output reg.
    if v_latency_left /= 0 then
      v_latency_left := v_latency_left-1;
      ret_val.pipe(ci_rom_addr_stage) := ret_val.pipe(ci_rom_addr_stage) +1;
      ret_val.used := ret_val.used +1;
    end if;

    if v_has_output_mapping_stage = 1 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left-1;
        ret_val.pipe(ci_data_mod_stage) := ret_val.pipe(ci_data_mod_stage) +1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    --if not already set addr regs, set them now.
    if ret_val.pipe(ci_rom_addr_stage) = 0 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left-1;
        ret_val.pipe(ci_rom_addr_stage) := ret_val.pipe(ci_rom_addr_stage) +1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    --This is the optional output register on the Vx4 BRAM
--    if p_xdevicefamily="spartan3adsp" or p_xdevicefamily="SPARTAN3ADSP" or p_family = "virtex4" or p_family = "VIRTEX4" or p_family = "virtex5" or p_family = "VIRTEX5" then

    --ok, I really want to ask if the BRAM has an optional register, but no
    --function exists for this. Instead, has_dsp is used because s3adsp and V4
    --onwards have optional registers and also have dsp48s.
    if has_dsp(p_xdevicefamily) then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left-1;
        ret_val.pipe(ci_rom_op_stage) := ret_val.pipe(ci_rom_op_stage) +1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    if v_has_output_mapping_stage = 1 or p_eff_to_follow = 1 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left-1;
        ret_val.pipe(ci_rom_speedup_stage) := ret_val.pipe(ci_rom_speedup_stage) +1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    if v_has_input_mapping_stage = 1 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left-1;
        ret_val.pipe(ci_addr_mod_stage) := ret_val.pipe(ci_addr_mod_stage) +1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    if v_has_output_mapping_stage = 1 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left-1;
        ret_val.pipe(ci_data_mod_stage) := ret_val.pipe(ci_data_mod_stage) +1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    if v_latency_left > 0 then
      ret_val.pipe(ci_data_mod_stage) := ret_val.pipe(ci_data_mod_stage) + v_latency_left;
      ret_val.used := ret_val.used +v_latency_left;
    end if;
    return ret_val;
  end fn_sin_cos_allocate_latency;

  -- purpose: allocate latency for taylor correction
  -- This has been superceeded in the hdl code
  function fn_eff_allocate_latency (
    p_latency      : integer;
    p_taylor_order : integer
    )          
    return t_eff_lat_alloc_return is
    variable v_latency_left : integer;
    variable ret_val : t_eff_lat_alloc_return;
  begin
    for i in 0 to ci_eff_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used := 0;
    v_latency_left := p_latency;

    if p_taylor_order = 2 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left -1;
        ret_val.pipe(5) := ret_val.pipe(5) + 1;
        ret_val.used    := ret_val.used +1;
      end if;
    end if;

    if v_latency_left /= 0 then
      v_latency_left := v_latency_left -1;
      ret_val.pipe(3) := ret_val.pipe(3) + 1;
      ret_val.used    := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left := v_latency_left -1;
      ret_val.pipe(1) := ret_val.pipe(1) + 1;
      ret_val.used    := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left := v_latency_left -1;
      ret_val.pipe(2) := ret_val.pipe(2) + 1;
      ret_val.used    := ret_val.used +1;
    end if;

    if p_taylor_order = 2 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left -1;
        ret_val.pipe(4) := ret_val.pipe(4) + 1;
        ret_val.used    := ret_val.used +1;
      end if;
    end if;

    assert v_latency_left <=0 report "ERROR: unallocated latency assigned to EFF" severity error;

    return ret_val;
  end function fn_eff_allocate_latency;

  function fn_dds_compiler_v4_0_latency(
    -- Don't get misled, this has the same interface as v3.1 but has the body of v3.0
    p_xdevicefamily       : string;
    p_has_phasegen        : integer;
    p_has_sincos          : integer;
    p_latency             : integer;
    p_mem_type            : integer;
    p_accumulator_width   : integer;
    p_noise_shaping       : integer;
    p_phase_angle_width   : integer;
    p_phase_increment     : integer;
    p_phase_offset        : integer;
    p_optimise_goal       : integer;
    p_use_dsp48           : integer;
    p_channels            : integer;
    p_output_width        : integer
    )
    return t_latency_allocation_return is
    variable v_latency_left      : integer;
    variable v_sin_cos_lat_alloc : t_sin_cos_lat_alloc_return;
    variable v_sin_cos_max       : integer;
    variable v_sin_cos_tally     : integer;
    variable v_eff_lat_alloc     : t_eff_lat_alloc_return;
    variable v_eff_max           : integer;
    variable v_eff_tally         : integer;
    variable v_taylor_order      : integer;
    variable v_eff_to_follow     : integer;
    variable ret_val             : t_latency_allocation_return;
    variable pi_use_dsp48        : integer := 0;
    variable has_dsp48           : integer := 0;
    variable has_dsp48a          : integer := 0;
    variable ci_phase_offset_req : boolean;
    variable off_path_lat        : integer := 0;
    variable inc_path_lat        : integer := 0;
    variable ci_dspreg_as_poff   : boolean;
    constant p_accumulator_latency : integer := 1; -- removed, but retained for reference
    
    constant c_dspreg_as_pinc : boolean:= fn_dspreg_as_pinc(
      p_channels              => p_channels,
      --p_accumulator_width : integer;     
      p_use_dsp48             => p_use_dsp48,
      p_phase_increment       => p_phase_increment ,
      --p_phase_increment_value : string;
      p_phase_offset          => p_phase_offset,
      --p_phase_offset_value    : string;
      p_optimise_goal         => p_optimise_goal);
      
    constant c_dspreg_as_poff : boolean:= fn_dspreg_as_poff(   
      p_channels              => p_channels,
      --p_accumulator_width : integer;
      p_use_dsp48             => p_use_dsp48,
      p_phase_increment       => p_phase_increment ,
      --p_phase_increment_value : string;
      p_phase_offset          => p_phase_offset,
      --p_phase_offset_value    : string;
      p_optimise_goal         => p_optimise_goal); 
      
    constant c_mem_type : integer := fn_mem_type(
      p_mem_type          => p_mem_type          ,
      p_phase_angle_width => p_phase_angle_width ,
      p_xdevicefamily     => p_xdevicefamily
      );

  begin

    for i in 0 to ci_pipe_ops_top loop
      ret_val.pipe(i) := 0;
    end loop;
    ret_val.used    := 0;
    ret_val.min_lat := 0;

    v_latency_left := p_latency;

    v_taylor_order  := 0;
    case p_noise_shaping is
      when c_noise_shaping_off =>
        v_eff_to_follow := 0;
      when c_noise_shaping_dither =>
        v_eff_to_follow := 0;
      when c_noise_shaping_taylor =>
        v_eff_to_follow := 1;
        v_taylor_order  := fn_get_taylor_order(p_output_width => p_output_width);
      when others =>
        assert false
          report "Unknown p_noise_shaping sent to fn_sin_cos_lat_alloc"
          severity ERROR;
        v_eff_to_follow := 0;
    end case;
    
    -- Determines if we need a half-degree phase offset
    ci_phase_offset_req := fn_phase_offset_req(p_has_phasegen      => p_has_phasegen,
                                               p_has_sincos        => p_has_sincos,
                                               p_noise_shaping     => p_noise_shaping,
                                               p_output_width      => p_output_width,
                                               p_accumulator_width => p_accumulator_width,
                                               p_phase_angle_width => p_phase_angle_width );

    -- Determines maximum latency of sin cos LUT
    v_sin_cos_lat_alloc := fn_sin_cos_allocate_latency(
      p_latency           =>  -1,
      p_xdevicefamily     => p_xdevicefamily,
      p_eff_to_follow     => v_eff_to_follow,
      p_phase_angle_width => p_phase_angle_width,
      p_mem_type          => p_mem_type,
      p_phase_offset_req  => ci_phase_offset_req
      );
    v_sin_cos_max := v_sin_cos_lat_alloc.used;
    v_sin_cos_tally := 0;

    -- Determines maximum latency of taylor correction unit
    v_eff_lat_alloc := fn_eff_allocate_latency(
      p_latency      => -1,
      p_taylor_order => v_taylor_order
      );
    v_eff_max := v_eff_lat_alloc.used;
    v_eff_tally := 0;

    --local poor man's version of has_dsp48 (if I use the real one I end up in
    --library hell).
    if (supports_dsp48(p_xdevicefamily)>0) then -- dsp48, dsp48e/1
      has_dsp48 := 1;
    elsif (supports_dsp48a(p_xdevicefamily)>0) then
      has_dsp48a := 1;
    end if;

    if p_use_dsp48 = 1 and (has_dsp48 = 1 or has_dsp48a = 1) then
      pi_use_dsp48 := 1;
    end if;


    if P_HAS_PHASEGEN = 1 then
      --accumulator
      if p_accumulator_latency = 1 then
        ret_val.pipe(ci_phase_acc_stage) := ret_val.pipe(ci_phase_acc_stage) + 1;
--      Latency specified does not include accumulator (need to add this on)
      end if;
    end if;

    -- Determine minumum latency
    if P_HAS_PHASEGEN = 1 then
      if p_phase_increment = c_phase_inc_streaming then
        ret_val.min_lat := ret_val.min_lat + ret_val.pipe(ci_phase_acc_stage);    -- accumulator forces one cycle of latency
      end if;
    end if;

    if P_HAS_SINCOS = 1 then
      if c_mem_type = c_rom_block then
        ret_val.min_lat := ret_val.min_lat + 1;
      end if;
      if v_taylor_order = 2 then
        ret_val.min_lat := ret_val.min_lat + 1;
      end if;
    end if;

    -- Determine latency
    -- To here
    if P_HAS_PHASEGEN = 1 then
      if p_channels > 1 or p_phase_increment = c_phase_inc_streaming then
        -- We include delay for streaming as this is needed to apply PINC_IN on the current cycle
        -- We also include a register on the store stage of the offset in this case. In that way,
        -- we also maintain alignment of offset. This is not simple!
        if v_latency_left /= 0 then
          v_latency_left := v_latency_left - 1;
          ret_val.pipe(ci_store_stage) := 1;
          ret_val.used := ret_val.used +1;
        end if;
      end if;
    end if;

    if P_HAS_SINCOS = 1 then
       --sin/cos LUT - mandatory register inside BRAM.
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
        ret_val.used := ret_val.used +1;
        v_sin_cos_tally := v_sin_cos_tally +1;
      end if;
    end if;

   -- EFF
    if P_HAS_SINCOS = 1 then
      --EFF LUT - mandatory register inside BRAM required in second order    
      if v_eff_to_follow = 1 then
        if v_latency_left /=0 then
          v_latency_left := v_latency_left - 1;
          ret_val.pipe(ci_eff_stage) := ret_val.pipe(ci_eff_stage) + 1;
          ret_val.used := ret_val.used +1;
          v_eff_tally := v_eff_tally +1;
        end if;
      end if;
    end if;
    
    -- From here

    if P_HAS_PHASEGEN = 1 then
      --phase_add
      --fabric version is the same (in latency) as spartan3adsp
      if (pi_use_dsp48 = 0 or has_dsp48a = 1) and p_phase_offset /= c_phase_adj_none then
        if v_latency_left /= 0 then
          v_latency_left                   := v_latency_left - 1;
          ret_val.pipe(ci_phase_adj_stage) := ret_val.pipe(ci_phase_adj_stage) + 1;
          ret_val.used                     := ret_val.used +1;
        end if;
      end if;

     --phase_add register for DSP48
     --Note: I'd love to use has_DSP48 and similar functions, but that would
     --mean duplicating this package because of the libraries dichotomy.
      if pi_use_dsp48 = 1 and has_dsp48 = 1 and (p_phase_offset /= c_phase_adj_none or p_noise_shaping = c_noise_shaping_dither) then
        if v_latency_left /= 0 then
          v_latency_left                   := v_latency_left - 1;
          ret_val.pipe(ci_phase_adj_stage) := ret_val.pipe(ci_phase_adj_stage) + 1;
          ret_val.used                     := ret_val.used +1;
        end if;
      end if;
    end if;

    if P_HAS_SINCOS = 1 then
      --sin/cos LUT
      if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
        v_latency_left             := v_latency_left - 1;
        ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
        ret_val.used               := ret_val.used +1;
        v_sin_cos_tally            := v_sin_cos_tally +1;
      end if;
    end if;

-- EFF
    if P_HAS_SINCOS = 1 then
      if v_eff_to_follow = 1 then
        if v_latency_left /=0 and v_eff_tally < v_eff_max then
          v_latency_left := v_latency_left - 1;
          ret_val.pipe(ci_eff_stage) := ret_val.pipe(ci_eff_stage) + 1;
          ret_val.used := ret_val.used +1;
          v_eff_tally := v_eff_tally +1;
        end if;
      end if;
    end if;

    if P_HAS_PHASEGEN = 1 then
      --dither
      --fabric and spartan3adsp implementations are very similar
      if p_noise_shaping = c_noise_shaping_dither then
        if pi_use_dsp48 = 0 or has_dsp48a = 1 then
          if v_latency_left /= 0 then
            v_latency_left                    := v_latency_left - 1;
            ret_val.pipe(ci_dither_add_stage) := ret_val.pipe(ci_dither_add_stage) + 1;
            ret_val.used                      := ret_val.used +1;
          end if;
        end if;
      end if;
    end if;

    if P_HAS_SINCOS = 1 then
      --sin/cos LUT
      if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
        v_latency_left             := v_latency_left - 1;
        ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
        ret_val.used               := ret_val.used +1;
        v_sin_cos_tally            := v_sin_cos_tally +1;
      end if;
    end if;

   -- EFF
    if P_HAS_SINCOS = 1 then
      if v_eff_to_follow = 1 then
        if v_latency_left /=0 then
          v_latency_left := v_latency_left - 1;
          ret_val.pipe(ci_eff_stage) := ret_val.pipe(ci_eff_stage) + 1;
          ret_val.used := ret_val.used +1;
          v_eff_tally := v_eff_tally +1;
        end if;
      end if;
    end if;

    if P_HAS_SINCOS = 1 then
      --sin/cos LUT
      if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
        v_latency_left             := v_latency_left - 1;
        ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
        ret_val.used               := ret_val.used +1;
        v_sin_cos_tally            := v_sin_cos_tally +1;
      end if;
    end if;

   -- EFF
    if P_HAS_SINCOS = 1 then
      if v_eff_to_follow = 1 then
        if v_latency_left /= 0 and v_eff_tally < v_eff_max then
          v_latency_left             := v_latency_left - 1;
          ret_val.pipe(ci_eff_stage) := ret_val.pipe(ci_eff_stage) + 1;
          ret_val.used               := ret_val.used +1;
          v_eff_tally                := v_eff_tally +1;
        end if;
      end if;
    end if;

    if P_HAS_SINCOS = 1 then
      --sin/cos LUT
      if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
        v_latency_left             := v_latency_left - 1;
        ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
        ret_val.used               := ret_val.used +1;
        v_sin_cos_tally            := v_sin_cos_tally +1;
      end if;
    end if;

    if P_HAS_SINCOS = 1 then
      --sin/cos LUT
      if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
        v_latency_left             := v_latency_left - 1;
        ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
        ret_val.used               := ret_val.used +1;
        v_sin_cos_tally            := v_sin_cos_tally +1;
      end if;
    end if;

    -- EFF
    if P_HAS_SINCOS = 1 then
      if v_eff_to_follow = 1 then
        if v_latency_left /=0 and v_eff_tally < v_eff_max then
          v_latency_left := v_latency_left - 1;
          ret_val.pipe(ci_eff_stage) := ret_val.pipe(ci_eff_stage) + 1;
          ret_val.used := ret_val.used +1;
          v_eff_tally := v_eff_tally +1;
        end if;
      end if;
    end if;

    if P_HAS_PHASEGEN = 1 then
      --ctrl2dsp speedup register
      if pi_use_dsp48 = 1 and (p_channels > 1 or 
                               p_phase_increment = c_phase_inc_streaming or
                               p_phase_offset    = c_phase_adj_streaming or
                               (p_phase_increment = c_phase_inc_prog and not(c_dspreg_as_pinc)) or
                               (p_phase_offset    = c_phase_adj_prog and not(c_dspreg_as_poff)))
      then
                               
        if v_latency_left /= 0 then
          v_latency_left                  := v_latency_left - 1;
          ret_val.pipe(ci_ctrl2dsp_stage) := ret_val.pipe(ci_ctrl2dsp_stage) + 1;
          ret_val.used                    := ret_val.used +1;
        end if;
      end if;

      --DSP48 (accumulator path) speedup register
      if pi_use_dsp48 = 1 and p_optimise_goal = c_opt_speed then
        if v_latency_left /= 0 then
          v_latency_left                     := v_latency_left - 1;
          ret_val.pipe(ci_phase_final_stage) := ret_val.pipe(ci_phase_final_stage) + 1;
          ret_val.used                       := ret_val.used +1;
        end if;
      end if;

      --Accumulator and following adders pipeline (two stage)
      if p_optimise_goal = c_opt_speed and pi_use_dsp48 = 0 then
        if p_accumulator_width > ci_adder_pipe_thresh then
          if v_latency_left /= 0 then
            ret_val.pipe(ci_accel_stage) := ret_val.pipe(ci_accel_stage)+1;
            v_latency_left               := v_latency_left-1;
            ret_val.used                 := ret_val.used + 1;
          end if;
        end if;
      end if;

      --Accumulator and following adders pipeline (three stage)
      if p_optimise_goal = c_opt_speed and pi_use_dsp48 = 0 then
        if p_accumulator_width > 2*ci_adder_pipe_thresh then
          if v_latency_left /= 0 then
            ret_val.pipe(ci_accel_stage) := ret_val.pipe(ci_accel_stage)+1;
            v_latency_left               := v_latency_left-1;
            ret_val.used                 := ret_val.used + 1;
          end if;
        end if;
      end if;
    end if;

    --lump any remaining latency on pre-output regs
    if v_latency_left > 0 then
      if p_noise_shaping = c_noise_shaping_taylor then
        ret_val.pipe(ci_op_reg_stage) := ret_val.pipe(ci_op_reg_stage) + 1;
        ret_val.used                  := ret_val.used + 1;
        v_latency_left                := v_latency_left - 1;
      else
        ret_val.pipe(ci_pre_op_stage) := ret_val.pipe(ci_pre_op_stage) + v_latency_left;
        ret_val.used                  := ret_val.used + v_latency_left;
        v_latency_left                := v_latency_left - v_latency_left;
      end if;
    end if;
    if v_latency_left > 0 then
      ret_val.pipe(ci_pre_op_stage) := ret_val.pipe(ci_pre_op_stage) + v_latency_left;
      ret_val.used                  := ret_val.used + v_latency_left;
      v_latency_left                := v_latency_left - v_latency_left;
    end if;
    assert v_latency_left <= 0 report "latency left = "&INTEGER'IMAGE(v_latency_left) severity failure;

    -- these are useful values
    ret_val.pg_lat := ret_val.pipe(ci_ctrl2dsp_stage)+
                      ret_val.pipe(ci_phase_adj_stage)+
                      ret_val.pipe(ci_dither_add_stage)+
                      ret_val.pipe(ci_accel_stage)+  -- for fabric
                      ret_val.pipe(ci_phase_final_stage);
                      -- note we are missing the lump delay, this only applies once

    ret_val.sc_lat := ret_val.pipe(ci_LUT_stage)+
                      ret_val.pipe(ci_EFF_stage)+
                      ret_val.pipe(ci_op_reg_stage);

    return ret_val;
  end function fn_dds_compiler_v4_0_latency;

  -- purpose: calculates latency of sin_cos in isolation from phase generator
  function fn_get_sin_cos_latency (
    p_pipe : t_pipe_top)
    return integer is
    variable i       : integer := 0;
    variable v_tally : integer := 0;
  begin  -- fn_get_sin_cos_latency
    v_tally := 0;
    for i in ci_LUT_stage to ci_pipe_ops_top loop
      v_tally := v_tally + p_pipe(i);
    end loop;  -- i
    return v_tally;
  end fn_get_sin_cos_latency;

  -- purpose: gets pi to the required accuracy
  function fn_get_pi (
    p_width   : integer)
    return std_logic_vector is
    variable round_pi2 : std_logic_vector(p_width downto 0);
    --define PI to lots of digits - it will be rounded to suit.
    constant ci_full_pi : std_logic_vector(27 downto 0) := "0110010010000111111011010101";
  begin  -- fn_get_pi
    round_pi2 := ci_full_pi(ci_full_pi'LEFT downto ci_full_pi'LEFT-p_width) + "01";
    return round_pi2(round_pi2'LEFT downto 1);
  end fn_get_pi;

  function fn_dds_compiler_v4_0_resources (
    P_XDEVICEFAMILY         : string  := "virtex4";
    P_ACCUMULATOR_WIDTH     : integer := 28;  -- width of accum and associated paths. Factor in Frequency resolution
    P_CHANNELS              : integer := 1;  -- number of time-multiplexed channels output
    P_HAS_CE                : integer := 0;  -- enables input CE port.
    P_HAS_CHANNEL_INDEX     : integer := 0;  -- enables CHANNEL output port
    P_HAS_RDY               : integer := 1;  -- enables RDY output port
    P_HAS_RFD               : integer := 0;  -- enables RFD input port (RFD is always true)
    P_HAS_SCLR              : integer := 0;  -- enables SCLR input port
    P_HAS_PHASE_OUT         : integer := 0;  -- phase_out pin visible
    P_HAS_PHASEGEN          : integer := 1;  -- generate the phase accumulator
    P_HAS_SINCOS            : integer := 1;  -- generate the sin/cos block
    P_LATENCY               : integer := 5;  -- Selects overall latency, -1 means 'fully pipelined for max performance'
    P_MEM_TYPE              : integer := 1;  -- 0 = DIST_ROM, 1 = Block ROM;
    P_NEGATIVE_COSINE       : integer := 0;  -- 0 = normal cosine, 1 = negated COSINE output port
    P_NEGATIVE_SINE         : integer := 0;  -- 0 = normal sine, 1 = negated SINE output port
    P_NOISE_SHAPING         : integer := 2;  -- 0 = none, 1 = Dither, 2 = Error Feed Forward (Taylor)
    P_OUTPUTS_REQUIRED      : integer := 2;  -- 0 = SIN, 1 = COS, 2 = Both;
    P_OUTPUT_WIDTH          : integer := 23;  -- sets width of output port (factor in SFDR)
    P_PHASE_ANGLE_WIDTH     : integer := 6;  -- width of phase fed to RAM (factor in RAM resource used)
    P_PHASE_INCREMENT       : integer := 2;  -- 1 = register, 2 = constant, 3 = streaming (input port);
    P_PHASE_INCREMENT_VALUE : string  := "0";  -- string of values for PINC, one for each channel.
    P_PHASE_OFFSET          : integer := 0;  -- 0 = none, 1 = reg, 2 = const, 3 = stream (input port);
    P_PHASE_OFFSET_VALUE    : string  := "0";  -- string of values for POFF, one for each channel
    P_OPTIMISE_GOAL         : integer := 0;  -- 0 = area, 1 = speed
    P_USE_DSP48             : integer := 0;  -- 0 = minimal 1 = max. Determines DSP48 use in phase accumulation.
    P_POR_MODE              : integer := 0;
    P_AMPLITUDE             : integer := 0  -- 0 = full scale (+/- 2^N-2), 1 = unit circle (+/- 2^(N-1))
    )
    return t_resources is
    variable v_resources         : t_resources;
    variable v_taylor_order      : integer;
    constant ci_phase_offset_req : boolean := fn_phase_offset_req(
        p_has_phasegen      => P_HAS_PHASEGEN,
        p_has_sincos        => P_HAS_SINCOS,
        p_noise_shaping     => P_NOISE_SHAPING,
        p_output_width      => P_OUTPUT_WIDTH,
        p_accumulator_width => P_ACCUMULATOR_WIDTH,
        p_phase_angle_width => P_PHASE_ANGLE_WIDTH);
    constant ci_mem_type         : integer := fn_mem_type(P_MEM_TYPE,P_PHASE_ANGLE_WIDTH,P_XDEVICEFAMILY);
    constant ci_mem_style        : string  := fn_ram_style(ci_mem_type);
    constant ci_p_no_half_or_qtr : boolean := not(ci_phase_offset_req);
    constant ci_rom_addr_width   : integer := fn_rom_addr_width(
        p_addr_width     => P_PHASE_ANGLE_WIDTH,
        p_mem_type       => ci_mem_type,
        p_no_half_or_qtr => ci_p_no_half_or_qtr -- need to disable optimizations if no phase offset
        );
    constant ci_ram_output_width : integer := fn_ram_output_width(P_OUTPUT_WIDTH, P_NOISE_SHAPING);
    constant ci_range            : enum_range := fn_calc_rom_range(P_PHASE_ANGLE_WIDTH, ci_rom_addr_width);
    constant ci_rom_data_width   : integer := fn_rom_data_width(ci_ram_output_width, ci_range);

    variable v_brams             : integer := 0;
    variable v_mults             : integer := 0;
  begin
    v_resources.luts    := 0;  -- Not supported
    v_resources.ffs     := 0;  -- Not supported

    ---------------------------------------------------------------------------
    --Phase Generator
    ---------------------------------------------------------------------------
    --Count DSP48s
    if P_HAS_PHASEGEN = 1 then
      if p_use_dsp48 = 1 then
        v_mults := v_mults + 1;  --the accumulator itself.
        if (has_dsp48(P_XDEVICEFAMILY) or supports_dsp48e(P_XDEVICEFAMILY) > 0) then
          if (P_PHASE_OFFSET /= c_phase_adj_none) or (P_NOISE_SHAPING = c_noise_shaping_dither) then
            v_mults := v_mults + 1;
          end if;
        elsif supports_dsp48a(P_XDEVICEFAMILY) > 0 then
          if (P_PHASE_OFFSET /= c_phase_adj_none) then
            v_mults := v_mults + 1;
          end if;
          if (P_NOISE_SHAPING = c_noise_shaping_dither) then
            v_mults := v_mults + 1;
          end if;
        end if;
      end if;
    end if;

    ---------------------------------------------------------------------------
    -- Sin Cos LUT 
    ---------------------------------------------------------------------------

    if P_HAS_SINCOS = 1 then
      -- LUT
      if fn_mem_type(P_MEM_TYPE, P_PHASE_ANGLE_WIDTH, P_XDEVICEFAMILY) = c_rom_block then
        -- Measure in terms of 18k
        if ci_rom_addr_width <= 9 then
          v_brams := v_brams + 1;
        elsif ci_rom_addr_width <= 10 then
          v_brams := v_brams + integer((ci_rom_data_width+17)/18); -- multiples of 18 bits;     Note that the case to integer is to work around a Rabassa issue
        elsif ci_rom_addr_width = 11 then
          v_brams := v_brams + integer((ci_rom_data_width+8)/9); -- multiples of 9 bits;     Note that the case to integer is to work around a Rabassa issue
        elsif ci_rom_addr_width = 12 then
          v_brams := v_brams + integer((ci_rom_data_width+3)/4); -- multiples of 4 bits;     Note that the case to integer is to work around a Rabassa issue
        elsif ci_rom_addr_width = 13 then
          v_brams := v_brams + integer((ci_rom_data_width+1)/2); -- multiples of 2 bits;     Note that the case to integer is to work around a Rabassa issue
        else
          v_brams := v_brams + integer((2**(ci_rom_addr_width-14)) * ci_rom_data_width);
        end if;
      end if;
      -- Taylor
      v_taylor_order := fn_get_taylor_order (p_output_width => P_OUTPUT_WIDTH);
      if P_NOISE_SHAPING = c_noise_shaping_taylor then
        v_mults     := v_mults + 1; -- One required for pi*angle multiplier
        if P_OUTPUTS_REQUIRED = c_sine_op_reqd or P_OUTPUTS_REQUIRED = c_cosine_op_reqd then
           if v_taylor_order=1 then
             v_mults  := v_mults + 1;
           elsif v_taylor_order=2 then
             v_mults  := v_mults + 2;
           end if;
        end if;
        if P_OUTPUTS_REQUIRED = c_both_op_reqd then
           if v_taylor_order=1 then
             v_mults  := v_mults + 2;
           elsif v_taylor_order=2 then
             v_mults  := v_mults + 4;
           end if;
        end if;
        if v_taylor_order=2 then     -- i.e. second order taylor series
          v_brams   := v_brams + 1;
        end if;
      end if;
    end if;

    v_resources.dsp48   := v_mults;
    v_resources.bram18k := v_brams;
    return v_resources;
  end fn_dds_compiler_v4_0_resources;

  function fn_get_taylor_order (
    p_output_width : integer)
    return integer is
  begin
    if p_output_width > 21 then
      return 2;
    end if;
    return 1;
  end fn_get_taylor_order;
  
  function fn_choose_accum_impl (
    p_xdevicefamily   : string;
    p_use_dsp48       : integer)
    return t_impl is
    variable ret_val : t_impl := e_fabric;
  begin  -- fn_choose_impl
    if has_dsp(p_xdevicefamily) and (p_use_dsp48 = 1) then
      ret_val := e_dsp48;
    end if;
    return ret_val;
  end fn_choose_accum_impl;

  -- Determines whether 0.5LSB phase offset require in table entries
  function fn_phase_offset_req(p_has_phasegen      : integer;
                               p_has_sincos        : integer;
                               p_noise_shaping     : integer;
                               p_output_width      : integer;
                               p_accumulator_width : integer;
                               p_phase_angle_width : integer) return boolean is
    variable ret_val : boolean := TRUE;
  begin
    if (CI_EXTENDED_OP) then                             -- If this behaviour is enabled
      if (p_has_phasegen = 1 and p_has_sincos = 1) and   -- DDS configuration 
         (p_noise_shaping = c_noise_shaping_off) and     -- Only exploited by none
         (p_accumulator_width = p_phase_angle_width) and -- When we are not truncating phase
         (p_output_width > p_phase_angle_width) then     -- When we need extended output precision (this is one to note)
       ret_val := FALSE;
      end if;
      if (p_has_phasegen = 0 and p_has_sincos = 1) and      -- SC LUT configuration
         (p_noise_shaping = c_noise_shaping_off) and        -- Do not use when none and
         (p_accumulator_width <= c_sc_only_off_thresh) then -- we are below BRAM limit without transformation
                                                            -- (transformations require phase offset)
        ret_val := FALSE;
      end if;
    end if;         
    -- Need 0.5 LSB phase offset if truncating phase or legacy
    return ret_val;
  end fn_phase_offset_req;

    -- purpose: To balance delay of PINC and POFF to get better latency model
  function fn_get_poff_bal_delay (
    p_impl : t_impl;
    p_pipe : t_pipe_top)
    return integer is
  begin  -- fn_get_poff_bal_delay
    if p_impl = e_dsp48 then
      return p_pipe(ci_ctrl2dsp_stage);
    else
      return p_pipe(ci_phase_acc_stage);
    end if;
  end fn_get_poff_bal_delay;

  -- purpose: determine whether or not to use c_reg of dsp48 for pinc or poff
  -- Functionality commented out is for future reference (requires GUI mods to enable)
  function fn_dspreg_as_pincpoff (
    p_channels              : integer;
    --p_accumulator_width     : integer;
    p_use_dsp48             : integer;
    p_phase_increment       : integer;
    --p_phase_increment_value : string;
    p_phase_offset          : integer;
    --p_phase_offset_value    : string;
    p_optimise_goal         : integer)
    return boolean is
    --constant ci_phase_inc_inits     : t_ram_type := fn_init_ram(p_phase_increment_value,p_channels, 16, p_accumulator_width);
    --constant ci_phase_adj_inits     : t_ram_type := fn_init_ram(p_phase_offset_value,p_channels,16,p_accumulator_width);
    --constant ci_zero_phase          : std_logic_vector(p_accumulator_width-1 downto 0):=(others=>'0');
    --variable v_phase_increment_zero : boolean := false;
    --variable v_phase_offset_zero    : boolean := false;
    variable dspreg_as_pincpoff : boolean := false;
  begin
    --if ci_phase_inc_inits(0) = ci_zero_phase then
    --  v_phase_increment_zero := true;
    --end if;
    --if ci_phase_adj_inits(0) = ci_zero_phase then
    --  v_phase_offset_zero := true;
    --end if;
    if p_channels = 1 and
       p_optimise_goal = c_opt_area and
       p_use_dsp48 = 1 and
       p_phase_increment /= c_phase_inc_streaming and -- this avoids a limitation of the behavioral model
       p_phase_offset    /= c_phase_adj_streaming  
       --and
       --((p_phase_increment = c_phase_inc_prog and
       --v_phase_increment_zero = true and
       --p_phase_offset = c_phase_adj_prog and
       --v_phase_offset_zero = true) or
       --(p_phase_increment /= c_phase_inc_prog and
       --p_phase_offset = c_phase_adj_prog and
       --v_phase_offset_zero = true) or
       --(p_phase_offset /= c_phase_adj_prog and
       --p_phase_increment = c_phase_inc_prog and
       --v_phase_increment_zero = true))
    then
      dspreg_as_pincpoff := true;
    end if;
    
    return dspreg_as_pincpoff;
  end fn_dspreg_as_pincpoff;

  -- purpose: determine for pinc whether or not to route data port to CREG directly to save area, but lose init value
  function fn_dspreg_as_pinc (
    p_channels             : integer;
    p_use_dsp48            : integer;
    p_phase_increment      : integer;
    p_phase_offset         : integer;
    p_optimise_goal        : integer)
    return boolean is
    
    constant ci_fn_dspreg_as_pincpoff : boolean := fn_dspreg_as_pincpoff (
      p_channels              => p_channels,
      --p_accumulator_width     : integer;
      p_use_dsp48             => p_use_dsp48,
      p_phase_increment       => p_phase_increment,
      --p_phase_increment_value : string;
      p_phase_offset          => p_phase_offset,
      --p_phase_offset_value    : string;
      p_optimise_goal         => p_optimise_goal);
      
    variable dspreg_as_pinc : boolean := false;
  begin  -- fn_dspreg_as_pinc
    if ci_fn_dspreg_as_pincpoff and
       p_phase_increment = c_phase_inc_prog
    then
      dspreg_as_pinc := true;
    end if;
    return dspreg_as_pinc;
  end fn_dspreg_as_pinc;

-- purpose: determine for poff whether or not to route data port CREG directly to save area, but lose init value
function fn_dspreg_as_poff (
  p_channels             : integer;
  p_use_dsp48            : integer;
  p_phase_increment      : integer;
  p_phase_offset         : integer;
  p_optimise_goal        : integer)
  return boolean is

  constant ci_fn_dspreg_as_pincpoff : boolean := fn_dspreg_as_pincpoff (
    p_channels              => p_channels,
    --p_accumulator_width     : integer;
    p_use_dsp48             => p_use_dsp48,
    p_phase_increment       => p_phase_increment,
    --p_phase_increment_value : string;
    p_phase_offset          => p_phase_offset,
    --p_phase_offset_value    : string;
    p_optimise_goal         => p_optimise_goal);
    
  variable dspreg_as_poff : boolean := false;
begin  -- fn_dspreg_as_poff
  if ci_fn_dspreg_as_pincpoff and
     p_phase_offset = c_phase_adj_prog
  then
    dspreg_as_poff := true;
  end if;
  return dspreg_as_poff;
end fn_dspreg_as_poff;

  -- purpose : determine when sin-cos bias required (shifts point down a little to reduce overall error)
  function fn_get_eff_bias(
    p_noise_shaping     : integer;
    p_output_width      : integer) 
    return boolean is
    variable eff_bias : boolean := FALSE;
  begin
    if p_noise_shaping = c_noise_shaping_taylor and  
       fn_get_taylor_order(p_output_width => p_output_width) = 1  -- only first order requires this
    then
      eff_bias := TRUE; 
    end if;
    return eff_bias;
  end function fn_get_eff_bias;

-------------------------------------------------------------------------------
-- Functions to support sin_cos component
-------------------------------------------------------------------------------
  -- purpose: convert MEM_STYLE generic into a local enumerated type
  function fn_ram_style (
    p_mem_type          : integer
    )
    return string is
  begin  -- fn_ram_style
    case p_mem_type is
      when c_rom_block => return "block";
      when c_rom_dist => return "distributed";
      when others =>
        assert false report "Unknown mem_type in fn_ram_style" severity failure;
        return "anything!";             --modelsim wants a return value
    end case;
  end fn_ram_style;
  
  -- purpose: determines address width of ROM primitive
  function fn_rom_addr_width (
    p_addr_width     : integer;
    p_mem_type       : integer;
    p_no_half_or_qtr : boolean)
    return integer is
    --*** Note address widths have been reduced by 1 over v3.1
  begin  -- fn_rom_addr_width
    if p_addr_width < 10 then           -- Address width of 18k BRAM configured as 1k by 18bits
      if p_mem_type = c_rom_block then
        return p_addr_width+1;          -- Double wave
      else
        return p_addr_width;            -- Single wave
      end if;
    elsif p_addr_width = 10 then
      return p_addr_width;              -- Single
    elsif p_addr_width = 11 then
      return p_addr_width-1;            -- Quarter
    else -- > 12
      return p_addr_width-2;            
    end if;                             -- Half
  end fn_rom_addr_width;

  -- purpose: determines if the rom is quarter, half or full sine wave

  function fn_calc_rom_range (
    p_addr_width     : integer;
    p_rom_addr_width : integer)
    return enum_range is
  begin  -- calc_rom_range
    case (p_addr_width - p_rom_addr_width) is
      when -1 =>
        return e_double;
      when 0 =>
        return e_full;
      when 1 =>
        return e_half;
      when 2 =>
        return e_quarter;
      when others =>
        assert false report "Illegal widths detected in calc_rom_range" severity ERROR;
        return e_quarter;
    end case;
  end fn_calc_rom_range;

  -- purpose: determines data width of ROM
  function fn_rom_data_width (
    p_data_width : integer;
    p_range      : enum_range
    )
    return integer is
    variable ret : integer;
  begin
    case p_range is
      when e_full | e_double | e_half=>
        ret := p_data_width;     -- Must store sign
      when e_quarter =>
        ret := p_data_width-1;   -- Sign is always positive so discard
      when others =>
        assert false report "Unknown enum_range in fn_rom_data_width" severity failure;
    end case;
    return ret;
  end fn_rom_data_width;
  
  -- purpose: Determine data width of ram (SC ROM)
  function fn_ram_output_width (
    p_output_width : integer;
    p_noise_shaping : integer)
    return integer is
    constant ci_taylor_order : integer := fn_get_taylor_order(p_output_width => p_output_width);
    variable v_rom_width     : integer;
  begin  -- fn_ram_output_width

    if p_output_width > 35 then
      v_rom_width := 35;
-- CR531125 relates
--    elsif p_noise_shaping = c_noise_shaping_taylor then
--      if p_output_width >18 and ci_taylor_order = 1 then
--        v_rom_width := 18;
--      else
--        v_rom_width := p_output_width;
--      end if;
    else
      v_rom_width := p_output_width;
    end if;
    return v_rom_width;
  end fn_ram_output_width;

  --This function parses the core interface string parameter holding all the PINC or POFF values into a
  --more palatable array of std_logic_vectors which can then be fed to inferrence
  --to get a RAM (with any luck)
  function fn_init_ram(
    p_val        : string;
    p_channels   : integer;
    p_chan_width : integer;
    p_data_width : integer
    )
    return t_ram_type is
    variable ret           : t_ram_type;
    variable addr          : integer;
    variable cursor        : integer;
    variable len           : integer;
    variable temp_str      : string(1 to p_val'LENGTH);  
    variable clear_str     : string(1 to p_val'LENGTH);
    variable start         : integer;
    variable v_val         : string(1 to p_val'LENGTH);
    constant c_clear_data  : std_logic_vector(p_data_width -1 downto 0) := (others => '0');
  begin  -- fn_init_ram
    v_val := p_val;                     --at least now I know the string direction!
    
    --give it some safe defaults
    for i in 0 to 2**p_chan_width-1 loop
      ret(i)(p_data_width-1 downto 0) := c_clear_data;
    end loop;  -- i

    --parse the string
    len := v_val'LENGTH;
    assert len > 0 report "WARNING: string passed to RAM is too short" severity WARNING;

    --find the first non-space character
    start := 0;
    for i in 1 to len loop
      if v_val(i) = '0' or v_val(i) = '1' then
        start := i;
        exit;
      end if;
    end loop;  -- i

    if start = 0 then
      assert false report "WARNING: no 0/1's detected in RAM init string" severity WARNING;
      return ret;                       --return default zeros since init is invalid
    end if;

    for w in temp_str'range loop
      clear_str(w) := '0';              --used to clear temp_str
    end loop;     

    temp_str := clear_str;
    addr := 0;
    cursor := 0;
    for j in start to len loop
      if v_val(j) = '1' or v_val(j) = '0' then
        cursor := cursor +1;            --keep track of its length
        temp_str(cursor) := v_val(j);   --construct element string
      else
        --next word
        ret(addr)(p_data_width-1 downto 0) := str_to_bound_slv_0(str_to_bound_str(temp_str(1 to cursor),p_data_width,"0"),p_data_width);
        temp_str := clear_str;
        cursor := 0;
        addr := addr+1;
        if addr >= p_channels then
          return ret;
        end if;
      end if;
    end loop;  -- j
    ret(addr)(p_data_width-1 downto 0) := str_to_bound_slv_0(str_to_bound_str(temp_str(1 to cursor),p_data_width,"0"),p_data_width);

    return ret;
  end fn_init_ram;
end package body pkg_dds_compiler_v4_0;

