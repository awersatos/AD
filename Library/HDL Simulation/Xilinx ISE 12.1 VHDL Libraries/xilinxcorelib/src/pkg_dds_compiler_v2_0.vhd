-- $Header
--
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
library std, ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

package pkg_dds_compiler_v2_0 IS

  --circuit constants
  constant c_sin_cos_addr_limit : integer := 12;
  constant ci_max_no_channels   : integer := 16;
  constant ci_adder_pipe_thresh : integer := 12;  -- width above which adder must be piped to achieve 400MHz
  
  --poor man's enumerated types
  --C_PHASE_INCREMENT
  constant c_phase_inc_none  : integer := 0;
  constant c_phase_inc_prog  : integer := 1;
  constant c_phase_inc_fixed : integer := 2;

  --C_PHASE_OFFSET
  constant c_phase_adj_none  : integer := 0;
  constant c_phase_adj_prog  : integer := 1;
  constant c_phase_adj_fixed : integer := 2;

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


  type t_rom_type is (BLOCK_ROM, DIST_ROM);

  function fn_dither_width (
    p_accumulator_width : integer;
    p_phase_angle_width : integer)
    return integer;
  
  function fn_eff_to_follow (
    p_noise_shaping : integer)
    return integer;
  
  function fn_mem_type (
    P_MEM_TYPE          : integer;
    P_PHASE_ANGLE_WIDTH : integer;
    P_FAMILY            : string
    )
    return integer;

  function check_generics (
    P_FAMILY                : string;
    P_XDEVICEFAMILY         : string;
    P_ACCUMULATOR_LATENCY   : integer;  --ONE_CYCLE;
    P_ACCUMULATOR_WIDTH     : integer;
    P_CHANNELS              : integer;
    P_DATA_WIDTH            : integer;
    P_ENABLE_RLOCS          : integer;
    P_HAS_CE                : integer;
    P_HAS_CHANNEL_INDEX     : integer;
    P_HAS_RDY               : integer;
    P_HAS_RFD               : integer;
    P_HAS_SCLR              : integer;
    P_LATENCY               : integer;
    P_MEM_TYPE              : integer;  --DIST_ROM;
    P_NEGATIVE_COSINE       : integer;
    P_NEGATIVE_SINE         : integer;
    P_NOISE_SHAPING         : integer;
    P_OUTPUTS_REQUIRED      : integer;  --SINE_AND_COSINE;
    P_OUTPUT_WIDTH          : integer;
    P_PHASE_ANGLE_WIDTH     : integer;
    P_PHASE_INCREMENT       : integer;  --REG;
    P_PHASE_INCREMENT_VALUE : string ;
    P_PHASE_OFFSET          : integer;  --CONST;
    P_PHASE_OFFSET_VALUE    : string ;
    P_PIPELINED             : integer
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

  function fn_sin_cos_allocate_latency (
    p_latency       : integer;
    p_family        : string;
    p_xdevicefamily : string;
    p_eff_to_follow : integer;
    p_addr_width    : integer
    )
    return t_sin_cos_lat_alloc_return;
  
  -----------------------------------------------------------------------------
  -- Function to allocate latency to latency opportunities for the top level
  -- synth model. This is partly used by the behv model to get offset delays.
  -----------------------------------------------------------------------------
  --latency stages
  constant ci_pipe_ops_top      : integer := 12;
  constant ci_ctrl2dsp_stage    : integer := 1;
  constant ci_phase_acc_stage   : integer := 2;
  constant ci_phase_adj_stage   : integer := 3;
  constant ci_dither_add_stage  : integer := 4;
  constant ci_accel_stage       : integer := 5;  -- allowed piped adders
  constant ci_phase_final_stage : integer := 6;  
  constant ci_LUT_stage         : integer := 7;
  constant ci_EFF_premult_stage : integer := 8;
  constant ci_EFF_mult_stage    : integer := 9;
  constant ci_EFF_add_stage     : integer := 10;
  constant ci_pre_op_stage      : integer := 11;
  constant ci_op_reg_stage      : integer := 12;

  type t_pipe_top is array (0 to ci_pipe_ops_top) of integer;
  type t_latency_allocation_return is record
                                        used : integer;
                                        pipe : t_pipe_top;
                                      end record;
  function fn_alloc_lat_top(
    p_family            : string;
    p_xdevicefamily     : string;
    p_latency           : integer;
    p_acc_latency       : integer;
    p_accumulator_width : integer;
    p_noise_shaping     : integer;
    p_phase_angle_width : integer;
    p_phase_offset      : integer;
    p_optimization_goal : integer;
    p_use_dsp48         : integer;
    p_channels          : integer
    )
    return t_latency_allocation_return;

  function fn_get_pi (
    p_width   : integer)
    return std_logic_vector;                                                         
  

end package pkg_dds_compiler_v2_0;

package body pkg_dds_compiler_v2_0 IS

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
    P_FAMILY            : string
    )
    return integer is
    variable ret : integer;
  begin
    if P_MEM_TYPE /= c_rom_auto then
      return P_MEM_TYPE;
    else
      if p_family = "virtex5" or p_family = "VIRTEX5" then
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
    P_FAMILY                : string;
    P_XDEVICEFAMILY         : string;
    P_ACCUMULATOR_LATENCY   : integer;  
    P_ACCUMULATOR_WIDTH     : integer;
    P_CHANNELS              : integer;
    P_DATA_WIDTH            : integer;
    P_ENABLE_RLOCS          : integer;
    P_HAS_CE                : integer;
    P_HAS_CHANNEL_INDEX     : integer;
    P_HAS_RDY               : integer;
    P_HAS_RFD               : integer;
    P_HAS_SCLR              : integer;
    P_LATENCY               : integer;
    P_MEM_TYPE              : integer;  --dtributed or block;
    P_NEGATIVE_COSINE       : integer;
    P_NEGATIVE_SINE         : integer;
    P_NOISE_SHAPING         : integer;
    P_OUTPUTS_REQUIRED      : integer;  --SINE and/or COSINE;
    P_OUTPUT_WIDTH          : integer;
    P_PHASE_ANGLE_WIDTH     : integer;
    P_PHASE_INCREMENT       : integer;  --none, programable, constant;
    P_PHASE_INCREMENT_VALUE : string ;
    P_PHASE_OFFSET          : integer;  --none, programable, constant;
    P_PHASE_OFFSET_VALUE    : string ;
    P_PIPELINED             : integer
    )
    return integer is
    variable v_mem_type : integer := fn_mem_type(
      P_MEM_TYPE          => P_MEM_TYPE          ,
      P_PHASE_ANGLE_WIDTH => P_PHASE_ANGLE_WIDTH ,
      P_FAMILY            => P_FAMILY
      );
  begin

    --C_ENABLE_RLOCS
    assert P_ENABLE_RLOCS = 0
      report "Location constraints are not supported"
      severity warning;

    --C_ACCUMULATOR_LATENCY
    assert P_ACCUMULATOR_LATENCY = 0 or P_ACCUMULATOR_LATENCY = 1
      report "ERROR: C_ACCUMULATOR_LATENCY must be 0 or 1"
      severity ERROR;

    assert P_ACCUMULATOR_LATENCY = 1 or P_LATENCY = 0
      report "ERROR: C_ACCUMULATOR_LATENCY can only be 0 when C_LATENCY = 0"
      severity ERROR;

    --C_ACCUMULATOR_WIDTH
    assert P_ACCUMULATOR_WIDTH > 1 AND P_ACCUMULATOR_WIDTH <= 36
      report "ERROR: C_ACCUMULATOR_WIDTH must be between 2 and 36 inclusive"
      severity ERROR;

    assert P_ACCUMULATOR_WIDTH >= P_OUTPUT_WIDTH
      report "WARNING: C_ACCUMULATOR_WIDTH is less than C_OUTPUT_WIDTH. This can reduce the achieved SFDR."
      severity WARNING;
   
    --C_CHANNELS              
    assert P_CHANNELS > 0 AND P_CHANNELS <= 16
      report "ERROR: C_CHANNELS must be between 1 and 16"
      severity ERROR;
    
    --C_DATA_WIDTH            
    assert P_DATA_WIDTH > 1 AND P_DATA_WIDTH <= 36
      report "ERROR: C_DATA_WIDTH must be between 2 and 36 inclusive"
      severity ERROR;

    assert (P_DATA_WIDTH <= P_ACCUMULATOR_WIDTH) or (P_PHASE_INCREMENT /= c_phase_inc_prog and P_PHASE_OFFSET /= c_phase_adj_prog)
      report "ERROR: C_DATA_WIDTH must not be greater than C_ACCUMULATOR_WIDTH"
      severity ERROR;
    --Ignore data width if inc and adj are both none or constants.
    
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
    
    --C_LATENCY               
    assert P_LATENCY = -1 or (P_LATENCY >= 0 AND P_LATENCY <= 15)
      report "ERROR: C_LATENCY must be -1 or between 0 and 15"
      severity ERROR;

    --block ROM requires latency
    assert not(P_LATENCY = 0 and v_mem_type = c_rom_block)
      report "ERROR: Block ROM memory type requires at least one level of latency"
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

    --C_OUTPUTS_REQUIRED
    assert P_NOISE_SHAPING = 0 or P_NOISE_SHAPING = 1 or P_NOISE_SHAPING = 2
      report "ERROR: C_NOISE_SHAPING must be 0, 1, or 2"
      severity ERROR;

    --C_OUTPUT_WIDTH          
    assert P_OUTPUT_WIDTH > 2 and P_OUTPUT_WIDTH <= 21
      report "ERROR: C_OUTPUT_WIDTH must be in the range 2 to 21"
      severity ERROR;
    --when using taylor, output_width must be greater than C_PHASE_ANGLE_WIDTH
    assert P_OUTPUT_WIDTH > P_PHASE_ANGLE_WIDTH or P_NOISE_SHAPING /= c_noise_shaping_taylor 
      report "ERROR: C_OUTPUT_WIDTH must be greater than C_PHASE_ANGLE_WIDTH when C_NOISE_SHAPING=2 (Taylor Series correction)"
      severity ERROR;

    --C_PHASE_ANGLE_WIDTH
    if P_NOISE_SHAPING = c_noise_shaping_dither then
      assert (P_PHASE_ANGLE_WIDTH > 1 and P_PHASE_ANGLE_WIDTH <= 16)
        report "ERROR: C_PHASE_ANGLE_WIDTH must be in the range 2 to 16 for dithered cases"
        severity ERROR;
    else
      assert (P_PHASE_ANGLE_WIDTH > 1 and P_PHASE_ANGLE_WIDTH <= 12)
        report "ERROR: C_PHASE_ANGLE_WIDTH must be in the range 2 to 12 inclusive"
        severity ERROR;
    end if;

    assert (P_PHASE_ANGLE_WIDTH <= P_ACCUMULATOR_WIDTH)
      report "ERROR: phase angle width must not be greater than accumulator width"
      severity ERROR;

    assert (P_OUTPUT_WIDTH/2 <= P_PHASE_ANGLE_WIDTH)
      report "ERROR: C_OUTPUT_WIDTH must not be greater than twice than C_PHASE_ANGLE_WIDTH, as precision will be lost"
      severity ERROR;
    
    --C_PHASE_INCREMENT
    assert P_PHASE_INCREMENT = 1 or P_PHASE_INCREMENT = 2
      report "ERROR: C_PHASE_INCREMENT must be 1 or 2"
      severity ERROR;
    
    --C_PHASE_INCREMENT_VALUE  is a string, so checking is delegated to the parser    

    --C_PHASE_OFFSET            
    assert P_PHASE_OFFSET = 0 or P_PHASE_OFFSET = 1 or P_PHASE_OFFSET = 2
      report "ERROR: C_PHASE_OFFSET must be 0, 1, or 2"
      severity ERROR;
    
    --C_PHASE_OFFSET_VALUE  is a string, so checking is delegated to the parser    

    --C_PIPELINED             
    assert P_PIPELINED = 0
      report "WARNING: C_PIPELINED is no longer supported (see C_LATENCY) and is ignored"
      severity WARNING;

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
    p_latency       : integer;
    p_family        : string;
    p_xdevicefamily : string;
    p_eff_to_follow : integer;
    p_addr_width    : integer
    )
    return t_sin_cos_lat_alloc_return is
    variable v_latency_left : integer;
    variable ret_val : t_sin_cos_lat_alloc_return;
    variable v_has_input_mapping_stage : integer;
    variable v_has_output_mapping_stage : integer;
  begin  -- fn_allocate_latency
    for i  in 0 to ci_rom_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used := 0;

    if p_addr_width <= c_sin_cos_addr_limit-2 then  --full wave or double width
      v_has_input_mapping_stage := 0;
      v_has_output_mapping_stage := 0;
    elsif p_addr_width = c_sin_cos_addr_limit-1 then  --half wave
      v_has_input_mapping_stage := 1;
      v_has_output_mapping_stage := 0;
    else                                              --quarter wave
      v_has_input_mapping_stage := 1;
      v_has_output_mapping_stage := 1;
    end if;
      
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
    if p_xdevicefamily="spartan3adsp" or p_xdevicefamily="SPARTAN3ADSP" or p_family = "virtex4" or p_family = "VIRTEX4" or p_family = "virtex5" or p_family = "VIRTEX5" then
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



  function fn_alloc_lat_top(
    p_family            : string;
    p_xdevicefamily     : string;
    p_latency           : integer;
    p_acc_latency       : integer;
    p_accumulator_width : integer;
    p_noise_shaping     : integer;
    p_phase_angle_width : integer;
    p_phase_offset      : integer;
    p_optimization_goal : integer;
    p_use_dsp48         : integer;
    p_channels          : integer 
    )
    return t_latency_allocation_return is
    variable v_latency_left : integer;
    variable v_sin_cos_lat_alloc : t_sin_cos_lat_alloc_return;
    variable v_sin_cos_max : integer;
    variable v_sin_cos_tally : integer;
    variable v_eff_to_follow : integer;
    variable ret_val : t_latency_allocation_return;
    variable pi_use_dsp48 : integer := 0;
    variable has_dsp48 : integer := 0;
    variable has_dsp48a : integer := 0;
  begin
    for i in 0 to ci_pipe_ops_top loop
      ret_val.pipe(i) := 0;
    end loop;
    ret_val.used := 0;
    v_latency_left := p_latency;

    case p_noise_shaping is
      when c_noise_shaping_off =>
        v_eff_to_follow := 0;
      when c_noise_shaping_dither =>
        v_eff_to_follow := 0;
      when c_noise_shaping_taylor =>
        v_eff_to_follow := 1;
      when others =>
        assert false
          report "Unknown p_noise_shaping sent to fn_sin_cos_lat_alloc"
          severity ERROR;
        v_eff_to_follow := 0;
    end case;

    v_sin_cos_lat_alloc := fn_sin_cos_allocate_latency(
      p_latency       =>  -1,
      p_family        => p_family,
      p_xdevicefamily => p_xdevicefamily,
      p_eff_to_follow => v_eff_to_follow,
      p_addr_width    => p_phase_angle_width
      );
    v_sin_cos_max := v_sin_cos_lat_alloc.used;
    v_sin_cos_tally := 0;

    --local poor man's version of has_dsp48 (if I use the real one I end up in
    --library hell).
    if (p_family = "virtex4" or p_family = "VIRTEX4" or p_family = "virtex5" or p_family = "VIRTEX5") then
      has_dsp48 := 1;
    elsif ((p_family = "spartan3" or p_family = "SPARTAN3") and ((p_xdevicefamily = "spartan3adsp") or (p_xdevicefamily = "SPARTAN3ADSP"))) then
      has_dsp48a := 1;
    end if;

    if p_use_dsp48 = 1 and (has_dsp48 = 1 or has_dsp48a = 1) then
      pi_use_dsp48 := 1;
    end if;
     
    --accumulator
    if p_acc_latency = 1 then
      ret_val.pipe(ci_phase_acc_stage) := ret_val.pipe(ci_phase_acc_stage) + 1;
      ret_val.used := ret_val.used +1;
    end if;

    --sin/cos LUT - mandatory register inside BRAM.
    if v_latency_left /= 0 then
      v_latency_left := v_latency_left - 1;
      ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
      ret_val.used := ret_val.used +1;
      v_sin_cos_tally := v_sin_cos_tally +1;
    end if;

    --output reg
    if p_noise_shaping = c_noise_shaping_taylor and ((has_dsp48 = 1) or (has_dsp48a = 1)) then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_EFF_add_stage) := ret_val.pipe(ci_EFF_add_stage) + 1;
        ret_val.used := ret_val.used +1;
      else
        assert false
          report "WARNING: No output registers, so sclr will not clear outputs. Behv mismatches"
          severity WARNING;
      end if;
      
    else
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_op_reg_stage) := ret_val.pipe(ci_op_reg_stage) + 1;
        ret_val.used := ret_val.used +1;
      else
        assert false
          report "WARNING: No output registers, so sclr will not clear outputs. Behv mismatches"
          severity WARNING;
      end if;
    end if;

    --phase_add
    --fabric version is the same (in latency) as spartan3adsp
    if (pi_use_dsp48 = 0 or has_dsp48a = 1) and p_phase_offset /= c_phase_adj_none then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_phase_adj_stage) := ret_val.pipe(ci_phase_adj_stage) + 1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    --phase_add register for DSP48
    --Note: I'd love to use has_DSP48 and similar functions, but that would
    --mean duplicating this package because of the libraries dichotomy.
    if pi_use_dsp48 = 1 and has_dsp48 = 1 and (p_phase_offset /= c_phase_adj_none or p_noise_shaping = c_noise_shaping_dither) then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_phase_adj_stage) := ret_val.pipe(ci_phase_adj_stage) + 1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;
    
    --mult reg
    if p_noise_shaping = c_noise_shaping_taylor then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_EFF_mult_stage) := ret_val.pipe(ci_EFF_mult_stage) + 1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;
    
    --premult reg
    if p_noise_shaping = c_noise_shaping_taylor then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_EFF_premult_stage) := ret_val.pipe(ci_EFF_premult_stage) + 1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;
    
    --sin/cos LUT
    if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
      v_latency_left := v_latency_left - 1;
      ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
      ret_val.used := ret_val.used +1;
      v_sin_cos_tally := v_sin_cos_tally +1;
    end if;
    
    --dither
    --fabric and spartan3adsp implementations are very similar
    if p_noise_shaping = c_noise_shaping_dither then
      if pi_use_dsp48 = 0 or has_dsp48a = 1 then
        if v_latency_left /= 0 then
          v_latency_left := v_latency_left - 1;
          ret_val.pipe(ci_dither_add_stage) := ret_val.pipe(ci_dither_add_stage) + 1;
          ret_val.used := ret_val.used +1;
        end if;
      end if;
    end if;
    
    --sin/cos LUT
    if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
      v_latency_left := v_latency_left - 1;
      ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
      ret_val.used := ret_val.used +1;
      v_sin_cos_tally := v_sin_cos_tally +1;
    end if;
    
    --sin/cos LUT
    if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
      v_latency_left := v_latency_left - 1;
      ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
      ret_val.used := ret_val.used +1;
      v_sin_cos_tally := v_sin_cos_tally +1;
    end if;
    
--    --EFF_add NOTE: this has become the output register stage, handled above
--    if p_noise_shaping = c_noise_shaping_taylor then
--      if v_latency_left /= 0 then
--        v_latency_left := v_latency_left - 1;
--        ret_val.pipe(ci_EFF_add_stage) := ret_val.pipe(ci_EFF_add_stage) + 1;
--        ret_val.used := ret_val.used +1;
--      end if;
--    end if;
    
    --sin/cos LUT
    if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
      v_latency_left := v_latency_left - 1;
      ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
      ret_val.used := ret_val.used +1;
      v_sin_cos_tally := v_sin_cos_tally +1;
    end if;

    --sin/cos LUT
    if v_latency_left /= 0 and v_sin_cos_tally < v_sin_cos_max then
      v_latency_left := v_latency_left - 1;
      ret_val.pipe(ci_LUT_stage) := ret_val.pipe(ci_LUT_stage) + 1;
      ret_val.used := ret_val.used +1;
      v_sin_cos_tally := v_sin_cos_tally +1;
    end if;

    --ctrl2dsp speedup register
    if pi_use_dsp48 = 1 and p_channels > 1 then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_ctrl2dsp_stage) := ret_val.pipe(ci_ctrl2dsp_stage) + 1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    --DSP48 (accumulator path) speedup register
    if pi_use_dsp48 = 1 and p_optimization_goal = c_opt_speed then
      if v_latency_left /= 0 then
        v_latency_left := v_latency_left - 1;
        ret_val.pipe(ci_phase_final_stage) := ret_val.pipe(ci_phase_final_stage) + 1;
        ret_val.used := ret_val.used +1;
      end if;
    end if;

    --Accumulator and following adders pipeline (two stage)
    if p_optimization_goal = c_opt_speed and pi_use_dsp48 = 0 then
      if p_accumulator_width > ci_adder_pipe_thresh then
        if v_latency_left /= 0 then
          ret_val.pipe(ci_accel_stage) := ret_val.pipe(ci_accel_stage)+1;
          v_latency_left := v_latency_left-1;
          ret_val.used := ret_val.used + 1;
        end if;
      end if;
    end if;
    
    --Accumulator and following adders pipeline (three stage)
    if p_optimization_goal = c_opt_speed and pi_use_dsp48 = 0 then
      if p_accumulator_width > 2*ci_adder_pipe_thresh then
        if v_latency_left /= 0 then
          ret_val.pipe(ci_accel_stage) := ret_val.pipe(ci_accel_stage)+1;
          v_latency_left := v_latency_left-1;
          ret_val.used := ret_val.used + 1;
        end if;
      end if;
    end if;
    
    --lump any remaining latency on pre-output regs
    if v_latency_left > 0 then
      if p_noise_shaping = c_noise_shaping_taylor then
        ret_val.pipe(ci_op_reg_stage) := ret_val.pipe(ci_op_reg_stage) + 1;
        ret_val.used := ret_val.used + 1;
        v_latency_left := v_latency_left - 1;
      else
        ret_val.pipe(ci_pre_op_stage) := ret_val.pipe(ci_pre_op_stage) + v_latency_left;
        ret_val.used := ret_val.used + v_latency_left;
        v_latency_left := v_latency_left - v_latency_left;
      end if;
    end if;
    if v_latency_left > 0 then
      ret_val.pipe(ci_pre_op_stage) := ret_val.pipe(ci_pre_op_stage) + v_latency_left;
      ret_val.used := ret_val.used + v_latency_left;
      v_latency_left := v_latency_left - v_latency_left;
    end if;
    assert v_latency_left <= 0 report "latency left = "&INTEGER'IMAGE(v_latency_left) severity failure;
    
    return ret_val;
  end function fn_alloc_lat_top;

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
  
end package body pkg_dds_compiler_v2_0;

