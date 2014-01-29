-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 4.0
--  \   \        Filename: $RCSfile: dds_compiler_v4_0.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:31 $
-- /___/   /\    Date Created: 2006
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : dds_compiler_v4_0
-- Purpose : Entity-architecture for behavioural model
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
---------------------------------------------------------------------------
-- GENERICS:
--  C_POR_MODE : Set to 0 to get 'X' when output not ready, otherwise
--               set to 1 to get whatever value is in the pipeline.
---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.xcc_utils_v2_0.all;
use xilinxcorelib.pkg_dds_compiler_v4_0.all;
use xilinxcorelib.dds_compiler_v4_0_sim_comps.all;
use xilinxcorelib.xbip_pipe_v2_0_xst_comp.all;
--
--core_if on entity dds_compiler_v4_0
  entity dds_compiler_v4_0 is
    generic (
      C_XDEVICEFAMILY         : string  := "virtex4";
      C_ACCUMULATOR_WIDTH     : integer := 28;         -- width of accum and associated paths. Factor in Frequency resolution
      C_CHANNELS              : integer := 1;          -- number of time-multiplexed channels output
      C_HAS_CE                : integer := 0;          -- enables input CE port.
      C_HAS_CHANNEL_INDEX     : integer := 0;          -- enables CHANNEL output port
      C_HAS_RDY               : integer := 1;          -- enables RDY output port
      C_HAS_RFD               : integer := 0;          -- enables RFD input port (RFD is always true)
      C_HAS_SCLR              : integer := 0;          -- enables SCLR input port
      C_HAS_PHASE_OUT         : integer := 0;          -- phase_out pin visible
      C_HAS_PHASEGEN          : integer := 1;          -- generate the phase accumulator
      C_HAS_SINCOS            : integer := 1;          -- generate the sin/cos block
      C_LATENCY               : integer := -1;         -- Selects overall latency, -1 means 'fully pipelined for max performance'
      C_MEM_TYPE              : integer := 1;          -- 0= Auto, 1 = Block ROM, 2 = DIST_ROM
      C_NEGATIVE_COSINE       : integer := 0;          -- 0 = normal cosine, 1 = negated COSINE output port
      C_NEGATIVE_SINE         : integer := 0;          -- 0 = normal sine, 1 = negated SINE output port
      C_NOISE_SHAPING         : integer := 0;          -- 0 = none, 1 = Dither, 2 = Error Feed Forward (Taylor)
      C_OUTPUTS_REQUIRED      : integer := 2;          -- 0 = SIN, 1 = COS, 2 = Both;
      C_OUTPUT_WIDTH          : integer := 6;          -- sets width of output port (factor in SFDR)
      C_PHASE_ANGLE_WIDTH     : integer := 6;          -- width of phase fed to RAM (factor in RAM resource used)
      C_PHASE_INCREMENT       : integer := 2;          -- 1 = register, 2 = constant, 3 = streaming (input port);
      C_PHASE_INCREMENT_VALUE : string  := "0";        -- string of values for PINC, one for each channel.
      C_PHASE_OFFSET          : integer := 0;          -- 0 = none, 1 = reg, 2 = const, 3 = stream (input port);
      C_PHASE_OFFSET_VALUE    : string  := "0";        -- string of values for POFF, one for each channel
      C_OPTIMISE_GOAL         : integer := 0;          -- 0 = area, 1 = speed
      C_USE_DSP48             : integer := 0;          -- 0 = minimal 1 = max. Determines DSP48 use in phase accumulation.
      C_POR_MODE              : integer := 0;          -- Power-on-reset behaviour (for behavioral model)
      C_AMPLITUDE             : integer := 0           -- 0 = full scale (+/- 2^N-2), 1 = unit circle (+/- 2^(N-1))
      );
    port (
      ADDR       : in  std_logic_vector(sel_lines_reqd(C_CHANNELS)-1 downto 0) := (others => '0');  -- selects channel for register write
      REG_SELECT : in  std_logic                                               := '0';              -- selects between PINC (0) and POFF (1)
      CE         : in  std_logic                                               := '0';              -- clock enable
      CLK        : in  std_logic                                               := '0';              -- clock
      SCLR       : in  std_logic                                               := '0';              -- sync reset.
      WE         : in  std_logic                                               := '0';              -- Write enable to PINC and POFF registers.
      DATA       : in  std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0)        := (others => '0');  -- data in to PINC and POFF registers
      PINC_IN    : in  std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0)        := (others => '0');  -- PINC streaming input
      POFF_IN    : in  std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0)        := (others => '0');  -- POFF streaming input
      PHASE_IN   : in  std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0)        := (others => '0');  -- phase input (used for SIN/COS LUT only case)
      RDY        : out std_logic;                                                                   -- output validity flag
      RFD        : out std_logic;                                                                   -- input validity flag (always true)
      CHANNEL    : out std_logic_vector(sel_lines_reqd(C_CHANNELS)-1 downto 0);                     -- channel output. Identifies channel of SIN and COS outputs
      COSINE     : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                 -- Main Cosine output
      SINE       : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                 -- Main Sin output
      PHASE_OUT  : out std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0)                             -- Output of phase accumulator (includes dithering and POFF if present)
      );
--core_if off
end dds_compiler_v4_0;

architecture behavioral of dds_compiler_v4_0 is

  constant C_ACCUMULATOR_LATENCY : integer := 1; -- Legacy generic, retained for removal in future release
  constant ci_check_generics : integer := check_generics(
    P_XDEVICEFAMILY         => C_XDEVICEFAMILY,
    P_ACCUMULATOR_WIDTH     => C_ACCUMULATOR_WIDTH,
    P_CHANNELS              => C_CHANNELS,
    P_HAS_CE                => C_HAS_CE,
    P_HAS_CHANNEL_INDEX     => C_HAS_CHANNEL_INDEX,
    P_HAS_RDY               => C_HAS_RDY,
    P_HAS_RFD               => C_HAS_RFD,
    P_HAS_SCLR              => C_HAS_SCLR,
    P_HAS_PHASE_OUT         => C_HAS_PHASE_OUT,
    P_HAS_PHASEGEN          => C_HAS_PHASEGEN,
    P_HAS_SINCOS            => C_HAS_SINCOS,
    P_LATENCY               => C_LATENCY,
    P_MEM_TYPE              => C_MEM_TYPE,
    P_NEGATIVE_COSINE       => C_NEGATIVE_COSINE,
    P_NEGATIVE_SINE         => C_NEGATIVE_SINE,
    P_NOISE_SHAPING         => C_NOISE_SHAPING,
    P_OUTPUTS_REQUIRED      => C_OUTPUTS_REQUIRED,
    P_OUTPUT_WIDTH          => C_OUTPUT_WIDTH,
    P_PHASE_ANGLE_WIDTH     => C_PHASE_ANGLE_WIDTH,
    P_PHASE_INCREMENT       => C_PHASE_INCREMENT,
    P_PHASE_INCREMENT_VALUE => C_PHASE_INCREMENT_VALUE,
    P_PHASE_OFFSET          => C_PHASE_OFFSET,
    P_PHASE_OFFSET_VALUE    => C_PHASE_OFFSET_VALUE,
    P_OPTIMISE_GOAL         => C_OPTIMISE_GOAL,
    P_USE_DSP48             => C_USE_DSP48,
    P_POR_MODE              => C_POR_MODE,   
    P_AMPLITUDE             => C_AMPLITUDE
    );

  -- purpose: resolve dsp48 according to generic and family
  function fn_use_dsp48 (
    p_use_dsp48     : integer;
    p_xdevicefamily : string)
    return integer is
  begin  -- fn_use_dsp48
    if has_dsp(p_xdevicefamily) then
      return p_use_dsp48;
    end if;
    return 0;
  end fn_use_dsp48;

  constant ci_use_dsp48 : integer := fn_use_dsp48(C_USE_DSP48, C_XDEVICEFAMILY);
  
  ---------------------------------------------------------------------------
  -- Create the values of the sin/cos lookup table
  ---------------------------------------------------------------------------

  function fn_sin_cos_address (
    p_acc_width : integer)
    return integer is
  begin  -- fn_sin_cos_address
    if p_acc_width < c_sin_cos_addr_limit then
      return p_acc_width;
    else
      return c_sin_cos_addr_limit;
    end if;
  end fn_sin_cos_address;
  
  constant ci_ram_addr_width : integer := C_PHASE_ANGLE_WIDTH;

  -- purpose: determines if the rom is quarter, half or full sine wave
  function fn_calc_rom_range (
    p_addr_width     : integer)
    return enum_range is
  begin  -- calc_rom_range
    case p_addr_width is
      when c_sin_cos_addr_limit =>
        return e_quarter;
      when c_sin_cos_addr_limit-1 =>
        return e_half;
      when others =>
        return e_full;
    end case;
  end fn_calc_rom_range;

  constant ci_range            : enum_range := fn_calc_rom_range(ci_ram_addr_width);

  constant ci_ram_output_width : integer := fn_ram_output_width(C_OUTPUT_WIDTH, C_NOISE_SHAPING);
  constant ci_ram_data_width   : integer := ci_ram_output_width ;

  subtype t_addr is integer range 0 to 15;


  type t_ROM_table   is array (0 to 2**ci_ram_addr_width-1) of std_logic_vector(ci_ram_output_width-1 downto 0);
  --Create lookup table of 1/x. i.e 1.0dddd = 1/0.1aaaa1
  --all the commented out code in this function is to do with the generation of
  --the coe file rather than mif file.
  function fn_ROM_table(
    p_addr_width       : integer;
    p_data_width       : integer;
    p_scaling_width    : integer;  -- used for scaling
    p_range            : enum_range;
    p_phase_offset_req : boolean;
    p_eff_bias         : boolean
    )
    return t_ROM_table is

    -- Note, changes should be made in sin_cos.vhd, and then copied across.
    -- Or this could be put in the package by fixing the output type.

    variable ret_val : t_ROM_table:= (others=>(others=>'0'));

    variable sin_i   : integer;
    constant delta   : real := 4.7936899621426287e-5; --2.0*MATH_PI*2.0**(-CI_SIN_ADDRESS_WIDTH);
    variable alpha   : real := 1.1489731724373268e-9; --2.0*sin(delta/2.0)**2;
    variable beta    : real := 4.7936899603068881e-5; --sin(delta);
    variable sinda_1 : real;
    variable cosda_1 : real;
    variable sinda   : real;
    variable cosda   : real;
    variable beta_1  : real := beta;
    variable alpha_1 : real := alpha;
    variable sinda_2 : real;
    variable cosda_2 : real;
    variable beta_2  : real;
    variable alpha_2 : real;
    variable sin_r   : real;
    variable sin_s_r : real;
    variable sin_m_r : real;
    variable offset  : real;
    
    variable n       : integer := 0;
    variable b       : integer := 0;
    variable idx_off : integer;
    variable dummy   : boolean;
    variable sin_x   : real;
    variable start   : integer := 0;
    variable x1      : real;
    variable x2      : real;
    variable x3      : real;
    
    begin
    
    case p_range is
     when e_quarter => n := 1; -- 1 quarterwave
                       b := 0; -- starting angle
     when e_half    => n := 2; -- 2 quartewaves
                       b := 1; -- increase start angle by x2
     when e_full    => n := 4;
                       b := 2;
     when e_double  => n := 8;
                       b := 3;
     when others => null;
    end case;
    
    -- generate sin(delta) and cos(delta)
    sinda_1 := beta;
    cosda_1 := 1.0-alpha;
    
    -- Grow rotation in powers of 2. Stop
    -- when we have half of table increments
    for j in 1 to (CI_SIN_ADDRESS_WIDTH-p_addr_width-3+b) loop
      sinda   := sinda_1;
      cosda   := cosda_1;
    
      sinda_1 := sinda -alpha*sinda+beta*cosda;
      cosda_1 := cosda -alpha*cosda-beta*sinda;

      -- keep beta and alpha for D/2
      beta_1  := sinda_1;
      alpha_1 := 2.0*sinda*sinda;

      beta    := sinda_1;
      alpha   := 2.0*sinda*sinda;
    
    end loop;
    
    -- Double angle to that we have an angle that takes
    -- us from one table entry to the next (table phase increment)
    sinda_2   := sinda_1 -alpha_1*sinda_1+beta_1*cosda_1;
    cosda_2   := cosda_1 -alpha_1*cosda_1-beta_1*sinda_1;

    beta_2    := sinda_2;
    alpha_2   := 2.0*sinda_1*sinda_1;
    
    if p_phase_offset_req then
      -- Start with half angle (of 0.5 ULP of phase)
      sinda   := sinda_1;
      cosda   := cosda_1;
      offset  := 0.5;
      idx_off := 1;
    else
      sinda   := 0.0;
      cosda   := 1.0;
      offset  := 0.0;
      idx_off := 0;
    end if;
    
    if p_eff_bias then
      -- we need a couple of extra iterations to prime the loop
      -- for taylor 
      start := -1;
    end if;
      
    for i in start to 2**p_addr_width-1 loop
     
      if i <= 2**p_addr_width/n - idx_off then
      -- in the first quadrant we calculate values from the recurrence equation
      -- elsewhere we use these values. In this way a value is only calculated
      -- one way, and it is the same way whether it is a quarter, half, full or
      -- double table
      
      -- For reference purposes, this is what we expect the sine to be
      -- sinda := sin(2.0*MATH_PI*(real(i)+offset)*2.0**(-p_addr_width));
      
        if p_range=e_quarter then
          -- don't need to keep sign
          sin_x := 2.0*sinda;
        else
          sin_x := sinda;
        end if;     
      
        if(C_AMPLITUDE = 0) then
          -- create an integer by scaling (include 1-2^W to avoid 1)
         sin_r := sin_x*(1.0-1.0/2.0**p_scaling_width);
        else
          sin_r := sin_x*0.5;
        end if;

        if p_eff_bias then
        -- calculate a better point using values either side
          if i=-1 then     -- prime calculation
            x2 := -sin_r;  -- we are assuming an offset sinewave
            x3 := sin_r; 
          else
            x1 := x2;
            x2 := x3;
            x3 := sin_r;
            sin_r  := (x1 + 14.0*x2 + x3)/16.0;                                  
          end if;     
        end if;
      
        if i>=0 then
          if p_data_width > 30 then
            -- need to do in two chunks
            sin_s_r                 := sin_r *2.0**(p_data_width-30-1); 
            sin_m_r                 := floor(sin_s_r);  -- bits above first 30
            ret_val(i)(p_data_width-1 downto 30) := CONV_STD_LOGIC_VECTOR(integer(sin_m_r), p_data_width-30);
            ret_val(i)(29 downto 0) := CONV_STD_LOGIC_VECTOR(integer(floor((sin_s_r - sin_m_r)*2.0**30 +0.5)), 30);
          else
            sin_s_r := floor(sin_r*2.0**(p_data_width-1)+0.5);        
            ret_val(i)(p_data_width-1 downto 0) := CONV_STD_LOGIC_VECTOR(integer(sin_s_r), p_data_width);
          end if;
        end if;
    
    
        -- Rotate by table phase increment
        sinda_1 := sinda-alpha_2*sinda+beta_2*cosda;
        cosda   := cosda-alpha_2*cosda-beta_2*sinda;
        sinda   := sinda_1;
    
      elsif i < (2**p_addr_width*2)/n then
        -- Second quarter which only gets executed for half, full and double
        if p_range = e_half then
          -- need 3rd quadrant (rather than second), so just invert first quadrant
          ret_val(i)(p_data_width-1 downto 0) := not(ret_val(i-(2**p_addr_width)/n)(p_data_width-1 downto 0))+1;
        else        
          -- second quadrant, so just flip first quadrant
          ret_val(i)(p_data_width-1 downto 0) := ret_val((2**p_addr_width*2)/n-i- idx_off)(p_data_width-1 downto 0);
        end if;
      elsif i < (2**p_addr_width*3)/n then
        -- Third quarter - only gets executed for full and double
        -- Is first but negated
        ret_val(i)(p_data_width-1 downto 0) := not(ret_val(i-(2**p_addr_width*2)/n)(p_data_width-1 downto 0)) + 1;
      elsif i < (2**p_addr_width*4)/n then
        -- Fourth quadrant. Only gets executed for full and double
        -- Is first but fipped and negated
        ret_val(i)(p_data_width-1 downto 0) := not(ret_val((2**p_addr_width*4)/n-i-idx_off)(p_data_width-1 downto 0))+1;
      else
        -- Must be double, in which case the second half of the table is a cosine
        -- which can be copied from the sine just calculated (but shift by 90 degrees)
        ret_val(i)(p_data_width-1 downto 0) := ret_val((i-(2**p_addr_width*3)/n) mod ((2**p_addr_width*4)/n))(p_data_width-1 downto 0);
      end if;
    end loop; 
    
    if p_range = e_double then
      for i in 0 to 2**p_addr_width-1 loop   
        if  i < (2**p_addr_width*4)/n then
          -- In the first half of the table we have sine
          if C_NEGATIVE_SINE = 1 then
            ret_val(i)(p_data_width-1 downto 0) := not(ret_val(i)(p_data_width-1 downto 0))+ 1;
          end if;
        else
          -- in the second half we have cosine
          if C_NEGATIVE_COSINE = 1 then
            ret_val(i)(p_data_width-1 downto 0) := not(ret_val(i)(p_data_width-1 downto 0))+ 1;
          end if;
        end if;
      end loop;
    end if;
    
    return ret_val;
  end fn_ROM_table;
  
  -- Need to include 0.5LSB phase offset if truncating phase in LUT
  constant CI_PHASE_OFFSET_REQ : boolean := fn_phase_offset_req(p_has_phasegen      => C_HAS_PHASEGEN,
                                                                p_has_sincos        => C_HAS_SINCOS,
                                                                p_noise_shaping     => C_NOISE_SHAPING,
                                                                p_output_width      => C_OUTPUT_WIDTH,
                                                                p_accumulator_width => C_ACCUMULATOR_WIDTH,
                                                                p_phase_angle_width => C_PHASE_ANGLE_WIDTH); 

  constant EFF_BIAS            : boolean := fn_get_eff_bias(p_noise_shaping => C_NOISE_SHAPING,
                                                            p_output_width  => C_OUTPUT_WIDTH);

  constant sin_lut             : t_ROM_table := fn_ROM_table(p_addr_width       => ci_ram_addr_width,
                                                             p_data_width       => ci_ram_output_width,
                                                             p_scaling_width    => ci_ram_output_width-2,
                                                             p_range            => e_full,
                                                             p_phase_offset_req => CI_PHASE_OFFSET_REQ,
                                                             p_eff_bias         => EFF_BIAS);

  signal diag_lut              : t_ROM_table := sin_lut;

  -----------------------------------------------------------------------------
  --calculate latency distribution
  constant c_lat_alloc : t_latency_allocation_return := fn_dds_compiler_v4_0_latency(
    p_xdevicefamily       => C_XDEVICEFAMILY,
    p_has_phasegen        => C_HAS_PHASEGEN,
    p_has_sincos          => C_HAS_SINCOS,
    p_latency             => C_LATENCY,
    p_mem_type            => C_MEM_TYPE,   
    p_accumulator_width   => C_ACCUMULATOR_WIDTH,
    p_noise_shaping       => C_NOISE_SHAPING,
    p_phase_angle_width   => C_PHASE_ANGLE_WIDTH,
    p_phase_increment     => C_PHASE_INCREMENT,
    p_phase_offset        => C_PHASE_OFFSET,
    p_optimise_goal       => C_OPTIMISE_GOAL,
    p_use_dsp48           => ci_use_dsp48,
    p_channels            => C_CHANNELS,
    p_output_width        => C_OUTPUT_WIDTH
    );
  signal diag_lat     : t_latency_allocation_return;

  constant ci_pipe    : t_pipe_top := c_lat_alloc.pipe;
  signal diag_pipe    : t_pipe_top := ci_pipe;
  constant ci_latency : integer := c_lat_alloc.used;
  signal diag_latency : integer := ci_latency;

  constant CI_PHASEGEN_LAT  : integer :=  c_lat_alloc.pg_lat;

  constant CI_SINCOS_LAT    : integer := c_lat_alloc.sc_lat;
  
  -- This is used to provide excess latency
  constant CI_OP_LAT        : integer := c_lat_alloc.pipe(ci_pre_op_stage);

  constant ci_acc_zero      : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');

  -- purpose: determines the length of the equalizing delay for dither
  -- Note that in the HDL, the datapath is flexible, but the dither add is
  -- largely fixed. In the simulation model, the datapath is flexible, but
  -- differs from the hdl datapath. If these paths are A, B and C respectively,
  -- with D being the simulation dither latency, then A-B = C-D. Solving for D
  -- gives D = C+B-A or sim data + hdl dither - hdl data.
  -- Note that delays which are identical in both models can be ignored
  -- since they will cancel out.
  type t_dither_delays is record        -- record of two balun lengths
                            datapath   : integer;  -- ditherpath
                            ditherpath : integer;
                          end record;
  function fn_dither_delay (
    p_pipe            : t_pipe_top;
    p_use_DSP48       : integer;
    p_xdevicefamily   : string;
    p_channels        : integer;
    p_phase_increment : integer;
    p_phase_offset    : integer)
    return t_dither_delays is
    variable ret            : t_dither_delays;
    variable hdl_data_del   : integer := 0;
    variable hdl_dither_del : integer := 0;
    variable sim_data_del   : integer := 0;
    variable sim_dither_del : integer := 0;
    constant ci_local_debug : integer := 0;  --0 = off, 1 = on.
  begin  -- fn_dither_delay
    ret.datapath   := 0;
    ret.ditherpath := 0;
    --Triple add DSP48 implementation only uses one DSP48 whereas for
    --fabric and for DSP48A two two-input add stages are used, hence the difference
    --in latency stages.

    --calculate hdl_data_del:
    hdl_data_del := ci_pipe(ci_phase_acc_stage);
    --after accumulator
    if p_use_DSP48 = 0 or supports_dsp48a(p_xdevicefamily)>0 then
      hdl_data_del := hdl_data_del + ci_pipe(ci_phase_adj_stage);
    end if;
    --before accumulator
    if p_use_DSP48 = 1  then
      hdl_data_del := hdl_data_del + ci_pipe(ci_ctrl2dsp_stage);
    end if;
    assert ci_local_debug = 0 report "hdl data delay = "&integer'image(hdl_data_del) severity note;
    
    --calculate hdl_dither_del
    hdl_dither_del := 0;            --relative to sim (new dither circuit)
    if p_use_dsp48 = 1 then
      if supports_dsp48(p_xdevicefamily)>0 then
        hdl_dither_del := hdl_dither_del + ci_pipe(ci_phase_acc_stage);
      else
        if p_phase_offset = c_phase_adj_none then  --taken from fn_ab_reg
          hdl_dither_del := hdl_dither_del + ci_pipe(ci_phase_acc_stage);
        else
          hdl_dither_del := hdl_dither_del + ci_pipe(ci_phase_adj_stage);
        end if;
      end if;
    end if;
    assert ci_local_debug = 0 report "hdl dither delay = "&integer'image(hdl_dither_del) severity note;
    
    --calculate sim_data_del
    sim_data_del := ci_pipe(ci_phase_acc_stage);
    assert ci_local_debug = 0 report "sim data delay = "&integer'image(sim_data_del) severity note;
    
    --calculate sim_dither_del
    sim_dither_del := sim_data_del + hdl_dither_del - hdl_data_del; --new dither circuit

    assert ci_local_debug = 0 report "new calc method ="&INTEGER'IMAGE(sim_dither_del) severity note;

    if sim_dither_del < 0 then
      ret.ditherpath := 0;
      ret.datapath := 0 - sim_dither_del;
    else
      ret.ditherpath := sim_dither_del;
      ret.datapath := 0;
    end if;
    return ret;
  end fn_dither_delay;

  constant ci_dither_delay : t_dither_delays := fn_dither_delay(
    p_pipe            => ci_pipe,
    p_use_dsp48       => ci_use_dsp48,
    p_xdevicefamily   => C_XDEVICEFAMILY,
    p_channels        => C_CHANNELS,
    p_phase_increment => C_PHASE_INCREMENT,
    p_phase_offset    => C_PHASE_OFFSET
    );

  signal ci_dither_delay_dummy    : t_dither_delays;

  constant ci_dspreg_as_poff      : boolean := fn_dspreg_as_poff(C_CHANNELS,ci_use_dsp48,C_PHASE_INCREMENT,C_PHASE_OFFSET,C_OPTIMISE_GOAL);
  constant ci_chan_width          : integer := sel_lines_reqd(C_CHANNELS);

  constant ci_phase_inc_inits     : t_ram_type := fn_init_ram(C_PHASE_INCREMENT_VALUE,C_CHANNELS,ci_chan_width,C_ACCUMULATOR_WIDTH);
  constant ci_phase_adj_inits     : t_ram_type := fn_init_ram(C_PHASE_OFFSET_VALUE,C_CHANNELS,ci_chan_width,C_ACCUMULATOR_WIDTH);
  constant ci_phase_inc_acc_inits : t_ram_type := fn_init_ram(C_PHASE_INCREMENT_VALUE,C_CHANNELS,ci_chan_width,C_ACCUMULATOR_WIDTH);
  constant ci_phase_adj_acc_inits : t_ram_type := fn_init_ram(C_PHASE_OFFSET_VALUE,C_CHANNELS,ci_chan_width,C_ACCUMULATOR_WIDTH);

  constant ci_phase_inc           : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := ci_phase_inc_acc_inits(0)(C_ACCUMULATOR_WIDTH-1 downto 0);
  constant ci_phase_adj           : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := ci_phase_adj_acc_inits(0)(C_ACCUMULATOR_WIDTH-1 downto 0);
  constant ci_rom_type            : t_rom_type                                       := BLOCK_ROM;
  constant ci_dither_width        : integer                                          := fn_dither_width(C_ACCUMULATOR_WIDTH,C_PHASE_ANGLE_WIDTH);
  constant ci_dither_shift        : integer                                          := C_ACCUMULATOR_WIDTH - ci_ram_addr_width - ci_dither_width +1;
  constant c_slv_dither_shift     : std_logic_vector(ci_dither_shift -1 downto 0)    := (others => '0');
  constant ci_zero_lat_acc        : integer                                          := C_LATENCY;

  constant ci_big_one             : std_logic_vector(3 downto 0) := "0001";
  constant ci_one                 : std_logic_vector(ci_chan_width-1 downto 0) := ci_big_one(ci_chan_width-1 downto 0);
  constant ci_op_zero             : std_logic_vector(C_OUTPUT_WIDTH-1 downto 0) := (others => '0');

  -- signals section
  signal sclr_i                   : std_logic := '0';     -- optional
  signal ce_i                     : std_logic := '1';     -- optional
  signal rdy_i                    : std_logic := '0';
  signal data_i                   : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal addr_i                   : std_logic_vector(3 downto 0) := (others => '0');
  signal reg_select_i             : std_logic := '0';
  signal phase_inc_we             : std_logic := '0';     --write enable for phase increment RAM
  signal phase_adj_we             : std_logic := '0';     --write enable for phase adjust RAM
  signal phase_inc_ram            : t_ram_type := ci_phase_inc_inits;
  signal phase_adj_ram            : t_ram_type := ci_phase_adj_inits;
  signal phase_acc_ram            : t_ram_type := (others=>(others=>'0'));

  signal phase_acc_ram_op         : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal chan_addr                : std_logic_vector(ci_chan_width-1 downto 0) := ci_one;
  signal op_channel               : std_logic_vector(ci_chan_width-1 downto 0) := (others => '0');
  signal chan_addr_del1           : std_logic_vector(ci_chan_width-1 downto 0) := (others => '0');
  signal chan_addr_del2           : std_logic_vector(ci_chan_width-1 downto 0) := (others => '0');
  signal chan_addr_del3           : std_logic_vector(ci_chan_width-1 downto 0) := (others => '0');
  signal chan_addr_adj            : std_logic_vector(ci_chan_width-1 downto 0) := (others => '0');

  signal pre_phase_inc            : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal pre_phase_inc_stretch    : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal phase_inc                : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := ci_phase_inc;
  signal acc_phase                : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal acc_phasea               : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal acc_phaseb               : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal acc_phasec               : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal acc_phase_adjusted       : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal acc_phase_adjusted_d1    : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal acc_phase_shaped         : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal acc_phase_to_lut         : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal op_phase_out             : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal phase_adj                : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others => '0');
  signal phase_adj_d1             : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := ci_phase_adj;
  signal dither                   : std_logic_vector(ci_dither_width-1 downto 0)     := (others => '0');
  signal sin_rom_addr             : std_logic_vector(ci_ram_addr_width-1 downto 0):= (others => '0');
  signal cos_rom_addr             : std_logic_vector(ci_ram_addr_width-1 downto 0):= (others => '0');
  signal pre_sin_x                : std_logic_vector(ci_ram_output_width-1 downto 0):= (others => '0');
  signal pre_cos_x                : std_logic_vector(ci_ram_output_width-1 downto 0):= (others => '0');
  signal sin_x                    : std_logic_vector(ci_ram_data_width-1 downto 0):= (others => '0');
  signal cos_x                    : std_logic_vector(ci_ram_data_width-1 downto 0):= (others => '0');

  signal pre_sine                 : std_logic_vector(C_OUTPUT_WIDTH-1 downto 0) := (others => '0');
  signal pre_cosine               : std_logic_vector(C_OUTPUT_WIDTH-1 downto 0) := (others => '0');
  signal op_sine                  : std_logic_vector(C_OUTPUT_WIDTH-1 downto 0) := (others => '0');
  signal op_cosine                : std_logic_vector(C_OUTPUT_WIDTH-1 downto 0) := (others => '0');

begin

  DEBUG : if FALSE generate
    -- For debug
    diag_lut <= fn_ROM_table(p_addr_width       => ci_ram_addr_width,
                                                   p_data_width       => ci_ram_output_width,
                                                   p_scaling_width    => ci_ram_output_width-2,
                                                   p_range            => e_full,
  						                                     p_phase_offset_req => CI_PHASE_OFFSET_REQ,
                                                   p_eff_bias         => EFF_BIAS);
  
    ci_dither_delay_dummy <= fn_dither_delay(
       p_pipe            => ci_pipe,
       p_use_dsp48       => ci_use_dsp48,
       p_xdevicefamily   => C_XDEVICEFAMILY,
       p_channels        => C_CHANNELS,
       p_phase_increment => C_PHASE_INCREMENT,
       p_phase_offset    => C_PHASE_OFFSET
       );
       
    diag_lat <= fn_dds_compiler_v4_0_latency(
         p_xdevicefamily       => C_XDEVICEFAMILY,
         p_has_phasegen        => C_HAS_PHASEGEN,
         p_has_sincos          => C_HAS_SINCOS,
         p_latency             => C_LATENCY,
         p_mem_type            => C_MEM_TYPE,      
         p_accumulator_width   => C_ACCUMULATOR_WIDTH,
         p_noise_shaping       => C_NOISE_SHAPING,
         p_phase_angle_width   => C_PHASE_ANGLE_WIDTH,
         p_phase_increment     => C_PHASE_INCREMENT,
         p_phase_offset        => C_PHASE_OFFSET,
         p_optimise_goal       => C_OPTIMISE_GOAL,
         p_use_dsp48           => ci_use_dsp48,
         p_channels            => C_CHANNELS,
         p_output_width        => C_OUTPUT_WIDTH
       );
  end generate DEBUG;

  --optional pins
  i_sclr: if C_HAS_SCLR = 1 generate
    sclr_i <= sclr;
  end generate i_sclr;
  i_ce: if C_HAS_CE = 1 generate
    ce_i <= ce;
  end generate i_CE;

  -- always generate an internal ready as used for qualifying output
  i_multi_channel : if C_CHANNELS > 1 generate
    i_rdy : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_latency,
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => 1,
        C_WIDTH    => 1
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D(0) => '1',
        Q(0) => rdy_i
        );
  end generate i_multi_channel;

  i_single_channel: if C_CHANNELS = 1 generate
    i_rdy : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_latency,
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => 1,
        C_WIDTH    => 1
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D(0) => '1',
        Q(0) => rdy_i
        );
  end generate i_single_channel;

  i_rdy: if C_HAS_RDY = 1 generate
    rdy <= rdy_i;
  end generate i_rdy;
  i_rfd: if C_HAS_RFD = 1 generate
    rfd <= '1';
  end generate i_rfd;

  I_PHASEGEN : if (C_HAS_PHASEGEN = 1) generate
    i_no_inc_off : if C_PHASE_INCREMENT /= 1 and C_PHASE_OFFSET /= 1 generate
      reg_select_i <= '0';              -- not required, but included for completeness
    end generate i_no_inc_off;
    i_inc_no_off : if C_PHASE_INCREMENT = 1 and C_PHASE_OFFSET /= 1 generate
      reg_select_i <= '0';
    end generate i_inc_no_off;
    i_off_no_inc : if C_PHASE_INCREMENT /= 1 and C_PHASE_OFFSET = 1 generate
      reg_select_i <= '1';
    end generate i_off_no_inc;
    i_inc_and_off : if C_PHASE_INCREMENT = 1 and C_PHASE_OFFSET = 1 generate
      reg_select_i <= reg_select;
    end generate i_inc_and_off;
    -----------------------------------------------------------------------------
    -- data port and address delay (allows we signals to be piped)
    -----------------------------------------------------------------------------
    i_speed_decode: if C_OPTIMISE_GOAL = c_opt_speed generate
      i_port_delay: process (clk)
      begin  -- process i_port_delay
        if rising_edge(clk) then
          data_i <= data;
          if C_CHANNELS > 1 then
            addr_i(addr'LEFT downto 0) <= addr;
          end if;
          if we = '1' then
            if reg_select_i = '0' then
              phase_inc_we <= '1';
              phase_adj_we <= '0';
            else
              phase_inc_we <= '0';
              phase_adj_we <= '1';
            end if;
          else
            phase_inc_we <= '0';
            phase_adj_we <= '0';
          end if;
        end if;
      end process i_port_delay;
    end generate i_speed_decode;

    i_area_decode: if C_OPTIMISE_GOAL = c_opt_area generate
      data_i       <= data;
      i_addr: if C_CHANNELS > 1 generate
        addr_i(addr'LEFT downto 0) <= addr;
      end generate i_addr;
      phase_inc_we <= '1' when reg_select_i = '0' and we = '1' else '0';
      phase_adj_we <= '1' when reg_select_i = '1' and we = '1' else '0';
    end generate i_area_decode;

    -----------------------------------------------------------------------------
    -- Multichannel channel index
    -----------------------------------------------------------------------------
    i_multichan: if C_CHANNELS >1 generate
      i_chancount: process(clk)
      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            chan_addr      <= ci_one; --(others => '0');
            chan_addr_del1 <= (others => '0');
            chan_addr_del2 <= (others => '0');
            chan_addr_del3 <= (others => '0');
          elsif ce_i = '1' then
            if CONV_INTEGER('0'&chan_addr) = C_CHANNELS-1 then
              chan_addr <= (others => '0');
            else
              chan_addr <= chan_addr+ci_one;
            end if;
            chan_addr_del1 <= chan_addr;
            chan_addr_del2 <= chan_addr_del1;
            chan_addr_del3 <= chan_addr_del2;
          end if;
        end if;
      end process i_chancount;
    end generate i_multichan;
    -----------------------------------------------------------------------------
    -- Phase inc port
    -----------------------------------------------------------------------------
    i_phase_inc_solo: if C_CHANNELS = 1 generate
      i_const_freq: if C_PHASE_INCREMENT = c_phase_inc_fixed generate
        pre_phase_inc <= ci_phase_inc;
      end generate i_const_freq;
      i_prog_freq: if C_PHASE_INCREMENT = c_phase_inc_prog generate
      
        function fn_phase_inc_init (
          c_dspreg_as_pinc : boolean;
          p_phase_inc      : std_logic_vector;
          p_width          : integer)
          return std_logic_vector is

          variable ret : std_logic_vector(p_width-1 downto 0);
        begin  -- fn_phase_inc_init
  
          if c_dspreg_as_pinc then
            ret := (others => '0');
          else        
            ret := p_phase_inc;
          end if;
          return ret;
        end fn_phase_inc_init;

        constant c_dspreg_as_pinc : boolean:= fn_dspreg_as_pinc(
          p_channels              => C_CHANNELS,
          --p_accumulator_width : integer;      -- Inputs commented out are for future capability
          p_use_dsp48             => C_USE_DSP48,
          p_phase_increment       => C_PHASE_INCREMENT,
          --p_phase_increment_value : string;
          p_phase_offset          => C_PHASE_OFFSET,
          --p_phase_offset_value    : string;
          p_optimise_goal         => C_OPTIMISE_GOAL);

        constant ci_shift_phase_inc : std_logic_vector(C_ACCUMULATOR_WIDTH downto 1) := fn_phase_inc_init(c_dspreg_as_pinc,ci_phase_inc,C_ACCUMULATOR_WIDTH);
        constant ci_str_phase_inc   : string(1 to C_ACCUMULATOR_WIDTH) := slv_to_str(ci_shift_phase_inc);
      begin
        i_prog_freq : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY   => 1,
            C_HAS_CE    => 1,
            C_HAS_SCLR  => 0,
            C_AINIT_VAL => ci_str_phase_inc,
            C_WIDTH     => C_ACCUMULATOR_WIDTH
            )
          port map(
            CLK  => CLK,
            CE   => phase_inc_we,
            D    => data_i,
            Q    => pre_phase_inc
            );
      end generate i_prog_freq;

      i_stream_freq: if C_PHASE_INCREMENT = c_phase_inc_streaming generate
        pre_phase_inc <= PINC_IN;
      end generate i_stream_freq;

    end generate i_phase_inc_solo;

    i_phase_inc_multi: if C_CHANNELS > 1 generate
      i_multi_freq: if C_PHASE_INCREMENT = c_phase_inc_prog or C_PHASE_INCREMENT = c_phase_inc_fixed generate
        signal phase_inc_addra : t_addr;
        signal phase_inc_int   : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others=>'0');      
      begin

        i_prog_freq: if C_PHASE_INCREMENT = c_phase_inc_prog generate
          i_proc_prog_freq : process(clk)
            variable phase_inc_addra : t_addr;
            variable phase_inc_addrb : t_addr;
          begin
            if rising_edge(clk) then
              if phase_inc_we = '1' then
                phase_inc_addrb := CONV_INTEGER('0'&addr_i);
                phase_inc_ram(phase_inc_addrb)(C_ACCUMULATOR_WIDTH-1 downto 0) <= data_i;
              end if;
            end if;
          end process i_proc_prog_freq;            
        end generate i_prog_freq;    

        phase_inc_addra <= CONV_INTEGER('0'&chan_addr);
        phase_inc_int   <= phase_inc_ram(phase_inc_addra)(C_ACCUMULATOR_WIDTH-1 downto 0); 

        i_store_reg : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY  => ci_pipe(ci_store_stage),
            C_HAS_CE   => C_HAS_CE,
            C_HAS_SCLR => C_HAS_SCLR,
            C_WIDTH    => C_ACCUMULATOR_WIDTH
            )
          port map(
            CLK  => CLK,
            CE   => ce_i,
            SCLR => sclr_i,
            D    => phase_inc_int,
            Q    => pre_phase_inc
            );          
      end generate i_multi_freq;

      i_stream_freq: if C_PHASE_INCREMENT = c_phase_inc_streaming generate
        pre_phase_inc <= PINC_IN;
      end generate i_stream_freq;

    end generate i_phase_inc_multi;

    pre_phase_inc_stretch <= std_logic_vector(resize(unsigned(pre_phase_inc),C_ACCUMULATOR_WIDTH));

    -- no longer required, but retained for reference
    i_ph_inc_ctrl2dsp_speedup : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => 0,  --ci_pipe(ci_ctrl2dsp_stage),
        C_HAS_CE   => C_HAS_CE,
        C_WIDTH    => C_ACCUMULATOR_WIDTH
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        D    => pre_phase_inc_stretch,
        Q    => phase_inc
        );
    -----------------------------------------------------------------------------
    -- Phase Accumulator
    -----------------------------------------------------------------------------
    i_acc_solo: if C_CHANNELS = 1 generate
      acc_phaseb <= acc_phasea + phase_inc;
    end generate i_acc_solo;

    i_acc_multi: if C_CHANNELS > 1 generate
      constant MUTE_COUNT_MAX  : integer := C_CHANNELS-1 + ci_pipe(ci_store_stage);
      signal mute              : boolean := MUTE_COUNT_MAX > 0;
    begin
      -- We use the increment immediately when streaming
      acc_phaseb <= (others=>'0') when mute and not(C_PHASE_INCREMENT = c_phase_inc_streaming) else
                    phase_inc     when mute and C_PHASE_INCREMENT = c_phase_inc_streaming else
                    phase_acc_ram_op + phase_inc;

      i_phase_acc_ram : process(clk)
        variable phase_acc_addra : t_addr;
        variable phase_acc_addrb : t_addr;
        variable mute_count      : integer := MUTE_COUNT_MAX;

      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            for i  in 0 to C_CHANNELS-1 loop
              phase_acc_ram(i)(C_ACCUMULATOR_WIDTH-1 downto 0) <= ci_acc_zero;
            end loop;  -- i
            phase_acc_ram_op <= (others => '0');
            -- Set-up mute to disable input
            mute_count := MUTE_COUNT_MAX; -- (one cycle in accumulator)
            if mute_count > 0 then
              mute <= TRUE;
            end if;
          elsif ce_i = '1' then          
            if mute_count <= 1 then
              mute <= FALSE;
            else
              mute_count := mute_count-1; 
            end if;
            phase_acc_addra := CONV_INTEGER('0'&chan_addr_del1);
            phase_acc_ram(phase_acc_addra)(C_ACCUMULATOR_WIDTH-1 downto 0) <= acc_phaseb;

            --not really in ce_i domain, since synth can't be, but needs to be
            --outwith sclr
            phase_acc_addrb := CONV_INTEGER('0'&chan_addr);
            phase_acc_ram_op <= phase_acc_ram(phase_acc_addrb)(C_ACCUMULATOR_WIDTH-1 downto 0);
          end if;
        end if;
      end process i_phase_acc_ram;

    end generate i_acc_multi;

    i_phase_acc : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY     => 1,
        C_HAS_CE      => C_HAS_CE,
        C_HAS_SCLR    => C_HAS_SCLR,
        C_WIDTH       => C_ACCUMULATOR_WIDTH
        )
      port map(
        CLK   => CLK,
        CE    => ce_i,
        SCLR  => sclr_i,
        D     => acc_phaseb,
        Q     => acc_phasea
        );
  

    i_zero_latency: if ci_pipe(ci_phase_acc_stage) = 0 generate
      acc_phase <= acc_phaseb;
    end generate i_zero_latency;

    i_non_zero_latency: if ci_pipe(ci_phase_acc_stage) = 1 generate
      acc_phase <= acc_phasea;
    end generate i_non_zero_latency;

    -----------------------------------------------------------------------------
    -- Phase adjust port
    -----------------------------------------------------------------------------
    i_phase_adj_solo: if C_CHANNELS = 1 generate

      i_const_phase: if C_PHASE_OFFSET = c_phase_adj_fixed generate
        phase_adj <= ci_phase_adj;
      end generate i_const_phase;

      i_prog_phase: if C_PHASE_OFFSET = c_phase_adj_prog generate
        -- purpose: determine init value of poff, or 0 for special case
        function fn_poff_init (
          p_dspreg_as_poff   : boolean;
          pi_shift_phase_adj : std_logic_vector(C_ACCUMULATOR_WIDTH downto 1))
          return string is
          constant null_slv : std_logic_vector(1 to C_ACCUMULATOR_WIDTH) := (others => '0');
        begin  -- fn_poff_init
          if p_dspreg_as_poff then
            return slv_to_str(null_slv);
          else
            return slv_to_str(pi_shift_phase_adj);
          end if;
        end fn_poff_init;
        constant ci_shift_phase_adj : std_logic_vector(C_ACCUMULATOR_WIDTH downto 1) := ci_phase_adj(C_ACCUMULATOR_WIDTH-1 downto 0);
        constant ci_str_phase_adj : string(1 to C_ACCUMULATOR_WIDTH) := fn_poff_init(ci_dspreg_as_poff, ci_shift_phase_adj);
        signal reg_out : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0):= (others => '0');
      begin
        i_prog_freq : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY   => 1,
            C_HAS_CE    => 1,
            C_HAS_SCLR  => 0,
            C_AINIT_VAL => ci_str_phase_adj,
            C_WIDTH     => C_ACCUMULATOR_WIDTH
            )
          port map(
            CLK  => CLK,
            CE   => phase_adj_we,
            D    => data_i,
            Q    => reg_out
            );
        phase_adj <= std_logic_vector(resize(signed(reg_out),C_ACCUMULATOR_WIDTH));
      end generate i_prog_phase;

      i_stream_phase: if C_PHASE_OFFSET = c_phase_adj_streaming generate
        i_poff_in_del : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY   => ci_pipe(ci_store_stage), -- This ensures that we don't get an imbalance with PINC 
            C_HAS_CE    => 1,                      
            C_HAS_SCLR  => 0,
            C_WIDTH     => C_ACCUMULATOR_WIDTH
            )
          port map(
            CLK  => CLK,
            CE   => ce_i,
            D    => POFF_IN,
            Q    => phase_adj
            );
      end generate i_stream_phase;

    end generate i_phase_adj_solo;
  
    i_phase_adj_multi: if C_CHANNELS > 1 generate
        -- channel counter is advanced by 1, so
        -- we must create zero at reset, and then pipe in
        -- channel, giving 0,1,..0,1
        i_prog_freq : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY   => 1, -- equalize fixed 1 cycle delay inserted in channel
            C_HAS_CE    => 1,
            C_HAS_SCLR  => 1,
            C_WIDTH     => chan_addr'length
            )
          port map(
            CLK  => CLK,
            CE   => ce_i,
            SCLR => sclr_i,
            D    => chan_addr,
            Q    => chan_addr_adj
            );

      i_multi_offset: if C_PHASE_OFFSET = c_phase_adj_prog or C_PHASE_OFFSET = c_phase_adj_fixed generate
        signal phase_adj_addra : t_addr;
        signal phase_adj_int   : std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0) := (others=>'0');
      begin
        
        i_prog_offset: if C_PHASE_OFFSET = c_phase_adj_prog generate
          i_proc_prog_offset : process(clk)
            variable phase_adj_addrb : t_addr;
          begin
            if rising_edge(clk) then
              if phase_adj_we = '1' then
                phase_adj_addrb := CONV_INTEGER('0'&addr_i);
                phase_adj_ram(phase_adj_addrb)(C_ACCUMULATOR_WIDTH-1 downto 0) <= data_i;
              end if;
            end if;
          end process i_proc_prog_offset;
        end generate i_prog_offset;
 
        phase_adj_addra <= CONV_INTEGER('0'&chan_addr_adj);
        phase_adj_int <= phase_adj_ram(phase_adj_addra)(C_ACCUMULATOR_WIDTH-1 downto 0);
       
        i_store_reg : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY  => ci_pipe(ci_store_stage),
            C_HAS_CE   => C_HAS_CE,
            --C_HAS_SCLR => C_HAS_SCLR, -- I have removed this as is results in an incorrect output with zero latency accumulator
            C_WIDTH    => C_ACCUMULATOR_WIDTH
            )
          port map(
            CLK  => CLK,
            CE   => ce_i,

            D    => phase_adj_int,
            Q    => phase_adj
            );
      end generate i_multi_offset;   

      i_stream_phase: if C_PHASE_OFFSET = c_phase_adj_streaming generate
        i_poff_in_del : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY   => ci_pipe(ci_store_stage), -- This ensures that we don't get an imbalance with POFF 
            C_HAS_CE    => 1,                      
            C_HAS_SCLR  => 0,
            C_WIDTH     => C_ACCUMULATOR_WIDTH
            )
          port map(
            CLK  => CLK,
            CE   => ce_i,
            D    => POFF_IN,
            Q    => phase_adj
            );
      end generate i_stream_phase;

    end generate i_phase_adj_multi;
  
    -----------------------------------------------------------------------------
    -- Phase adjust latency balance
    -----------------------------------------------------------------------------
    i_dsp48_phase_adj: if ci_use_dsp48 = 1 and false generate
      --the ctrl2dsp stage register could be in the same place in the behv model
      --as the synth model, but this upsets the reset circuitry which is very fragile.
      --alternatively, the delay is compensated for in the phase adjust path.
      function fn_poff_balun (
        p_acc_stage      : integer;
        p_ctrl2dsp_stage : integer;
        p_dspreg_as_poff : boolean
        ) return integer is
      begin
        if p_dspreg_as_poff then
          return 0;
        else
          return p_acc_stage - p_ctrl2dsp_stage;
        end if;
      end function fn_poff_balun;
      constant ci_poff_balun : integer := fn_poff_balun(ci_pipe(ci_phase_acc_stage),ci_pipe(ci_ctrl2dsp_stage),ci_dspreg_as_poff);
    begin

      i_phase_acc : xbip_pipe_v2_0_xst
        generic map(
          C_LATENCY     => ci_poff_balun,
          C_HAS_CE      => C_HAS_CE,
          C_WIDTH       => C_ACCUMULATOR_WIDTH
          )
        port map(
          CLK   => CLK,
          CE    => ce_i,
          D     => phase_adj,
          Q     => phase_adj_d1
          );
    end generate i_dsp48_phase_adj;
    i_fabric_phase_adj: if ci_use_dsp48 = 0 or true generate
      phase_adj_d1 <= phase_adj;
    end generate i_fabric_phase_adj;
    -----------------------------------------------------------------------------
    -- Phase adjuster
    -----------------------------------------------------------------------------
    i_phase_no_adj: if C_PHASE_OFFSET = c_phase_adj_none generate
      acc_phase_adjusted <= acc_phase;
    end generate i_phase_no_adj;
    i_phase_adj: if C_PHASE_OFFSET /= c_phase_adj_none generate
      acc_phase_adjusted <= acc_phase + phase_adj_d1;  --used to have balancing delay. Removed.
    end generate i_phase_adj;
  
    -----------------------------------------------------------------------------
    -- Dither datapath balun
    -- In the behv model all latency was intended to be lumped at the end of the datapath.
    -- Unfortunately, to mimic the timing of the dither signal versus the accumulated
    -- phase would require a psychic circuit now that there is almost no delay in
    -- the dither generation. Hence a datapath balun is required.
    -----------------------------------------------------------------------------
  
    i_datapath_balun : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY     => ci_dither_delay.datapath,
        C_HAS_CE      => C_HAS_CE,
        C_WIDTH       => C_ACCUMULATOR_WIDTH
        )
      port map(
        CLK   => CLK,
        CE    => ce_i,
        D     => acc_phase_adjusted,
        Q     => acc_phase_adjusted_d1
        );

    -----------------------------------------------------------------------------
    -- Dither add
    -----------------------------------------------------------------------------
    i_dither: if C_NOISE_SHAPING = c_noise_shaping_dither generate
      constant ci_phase_err_width : integer := C_ACCUMULATOR_WIDTH - C_PHASE_ANGLE_WIDTH;
      signal pre_dither           : std_logic_vector(ci_dither_width downto 1):= (others => '0');
      signal lfsr                 : std_logic_vector(c_max_lfsr_size downto 1) := (others => '0');
    begin
    i_small_lfsr: if CI_PHASE_ERR_WIDTH <= ci_small_lfsr_max generate

      --Derived from x^10 + x^7 + 1 = 0
      i_lfsr: process(clk)
        variable temp : std_logic_vector(c_max_lfsr_size downto 1);
      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            lfsr <= (others => '0');
          elsif ce_i = '1' then
            temp := lfsr;
            for i in 1 to 10 loop
              temp := temp(temp'LEFT-1 downto 1)&(temp(10) xor temp(7) xor '1');
            end loop;  -- i
            lfsr <= temp;
          end if;
        end if;
      end process;
    end generate i_small_lfsr;

    i_medium_lfsr: if CI_PHASE_ERR_WIDTH > ci_small_lfsr_max and CI_PHASE_ERR_WIDTH <= ci_medium_lfsr_max generate
      -- derived from x^18 + x^11 + 1 = 0
      i_lfsr: process(clk)
        variable temp : std_logic_vector(c_max_lfsr_size downto 1);
      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            lfsr <= (others => '0');
          elsif ce_i = '1' then
            temp := lfsr;
            for i in 1 to 10 loop
              temp := temp(temp'LEFT-1 downto 1)&(temp(18) xor temp(11) xor '1');
            end loop;  -- i
            lfsr <= temp;
          end if;
        end if;
      end process;
    end generate i_medium_lfsr;
  
    i_large_lfsr: if CI_PHASE_ERR_WIDTH > ci_medium_lfsr_max and CI_PHASE_ERR_WIDTH <= ci_large_lfsr_max generate
      -- derived from x^25 + x^22 + 1 = 0
      i_lfsr: process(clk)
        variable temp : std_logic_vector(c_max_lfsr_size downto 1);
      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            lfsr <= (others => '0');
          elsif ce_i = '1' then
            temp := lfsr;
            for i in 1 to 10 loop
              temp := temp(temp'LEFT-1 downto 1)&(temp(25) xor temp(22) xor '1');
            end loop;  -- i
            lfsr <= temp;
          end if;
        end if;
      end process;
    end generate i_large_lfsr;

    i_xtralarge_lfsr: if CI_PHASE_ERR_WIDTH > ci_large_lfsr_max generate
      --deived from x^33 + x^20 + 1 = 0
      i_lfsr: process(clk)
        variable temp : std_logic_vector(c_max_lfsr_size downto 1);
      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            lfsr <= (others => '0');
          elsif ce_i = '1' then
            temp := lfsr;
            for i in 1 to 10 loop
              temp := temp(temp'LEFT-1 downto 1)&(temp(33) xor temp(20) xor '1');
            end loop;  -- i
            lfsr <= temp;
          end if;
        end if;
      end process;
    end generate i_xtralarge_lfsr;

    pre_dither <= lfsr(CI_DITHER_WIDTH downto 1);

    -------------------------------------------------------------------
    -- Original pseudo-gaussian lfsr, retained for reference
    -------------------------------------------------------------------
    --i_lfsr1: process(clk)
  --    begin
  --      if rising_edge(clk) then
  --        if sclr_i = '1' then
  --          lfsr1 <= (others => '0');
  --          lfsr2 <= (others => '0');
  --          lfsr3 <= (others => '0');
  --          lfsr4 <= (others => '0');
  --        elsif ce_i = '1' then
  --          lfsr1 <= lfsr1(11 downto 0)& NOT(lfsr1(12) xor lfsr1(10) xor lfsr1(9) xor lfsr1(0));
  --          lfsr2 <= lfsr2(12 downto 0)& NOT(lfsr2(13) xor lfsr2(8) xor lfsr2(4) xor lfsr2(0));
  --          lfsr3 <= lfsr3(13 downto 0)& NOT(lfsr3(14) xor lfsr3(0));
  --          lfsr4 <= lfsr4(14 downto 0)& NOT(lfsr4(15) xor lfsr4(13) xor lfsr4(4) xor lfsr4(0));
  --        end if;
  --      end if;
  --    end process;
  --    combine1 <= (lfsr1(ci_dither_width-1)&lfsr1(ci_dither_width-1 downto 0))   + (lfsr2(ci_dither_width-1)&lfsr2(ci_dither_width-1 downto 0));
  --    combine2 <= (lfsr3(ci_dither_width-1)&lfsr3(ci_dither_width-1 downto 0))   + (lfsr4(ci_dither_width-1)&lfsr4(ci_dither_width-1 downto 0));
  --    combine3 <= (combine1(ci_dither_width)&combine1(ci_dither_width downto 0)) + (combine2(ci_dither_width)&combine2(ci_dither_width downto 0));
  
      --the timing of dither add is different depending on DSP48 use. This is
      --because the behv model and synth model agree as far as the output of the
      --accumulator in terms of timing, but thereafter, the synth has pipes in the
      --datapath, but the behv model doesn't. The synth model delays dither by 2,
      --then adds it after the adjust stage. However, in the case of dsp48, the
      --dither is added in parallel with phase adjust, hence the variations.
  
      i_dither_delay: block
      begin  -- block i_dither_delay
        i_dither_del : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY  => ci_dither_delay.ditherpath,
            C_HAS_CE   => C_HAS_CE,
            C_HAS_SCLR => C_HAS_SCLR,
            C_WIDTH    => ci_dither_width
            )
          port map(
            CLK  => CLK,
            CE   => ce_i,
            SCLR => sclr_i,
            D    => pre_dither,
            Q    => dither
            );
        
      end block i_dither_delay;


      acc_phase_shaped <= acc_phase_adjusted_d1 + (dither&c_slv_dither_shift);
    end generate i_dither;
    
    i_no_dither: if C_NOISE_SHAPING = c_noise_shaping_off or C_NOISE_SHAPING = c_noise_shaping_taylor generate
      acc_phase_shaped <= acc_phase_adjusted_d1;
    end generate i_no_dither;

    i_pipe_angle : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY   => CI_PHASEGEN_LAT-ci_dither_delay.datapath,  --see dither delay for comments
      C_HAS_CE    => C_HAS_CE,
      C_HAS_SINIT => 0,
      C_WIDTH     => C_ACCUMULATOR_WIDTH
      )
    port map(
      CLK   => CLK,
      CE    => ce_i,
      D     => acc_phase_shaped,
      Q     => acc_phase_to_lut
      );

  end generate I_PHASEGEN;

  I_NO_PHASEGEN : if (C_HAS_PHASEGEN /= 1) generate
    acc_phase_to_lut(C_ACCUMULATOR_WIDTH-1 downto 0) <= PHASE_IN;
  end generate I_NO_PHASEGEN;
  
  i_pipe_phase_out : xbip_pipe_v2_0_xst
  generic map(
    C_LATENCY   => CI_SINCOS_LAT*C_HAS_SINCOS 
                  + CI_OP_LAT, -- lumped delay should only be present once
    C_HAS_CE    => C_HAS_CE,
    C_HAS_SINIT => 0,
    C_WIDTH     => C_ACCUMULATOR_WIDTH
    )
  port map(
    CLK   => CLK,
    CE    => ce_i,
    D     => acc_phase_to_lut,
    Q     => op_phase_out
    );

  I_SINCOS : if (C_HAS_SINCOS = 1) generate
    -----------------------------------------------------------------------------
    -- Sine-Cosine LUT
    -----------------------------------------------------------------------------
    --this is the RTL model, remember? Hence, dont worry about quarter wave/halfwave
    --etc. Just look up a table and get on with it.
    i_block_rom: if ci_rom_type = BLOCK_ROM generate
    begin
      sin_rom_addr <= acc_phase_to_lut(C_ACCUMULATOR_WIDTH-1 downto C_ACCUMULATOR_WIDTH-ci_ram_addr_width);
      cos_rom_addr <= sin_rom_addr + 2**(ci_ram_addr_width-2);  --quarter wave advance

      i_pos_sin: if C_NEGATIVE_SINE = 0 generate
        pre_sin_x <= sin_lut(CONV_INTEGER('0'&sin_rom_addr));
      end generate i_pos_sin;
      i_neg_sin: if C_NEGATIVE_SINE = 1 generate
        pre_sin_x <= CONV_STD_LOGIC_VECTOR(0,ci_ram_output_width) - sin_lut(CONV_INTEGER('0'&sin_rom_addr));
      end generate i_neg_sin;
      
      i_pos_cos: if C_NEGATIVE_COSINE = 0 generate
        pre_cos_x <= sin_lut(CONV_INTEGER('0'&cos_rom_addr));
      end generate i_pos_cos;
      i_neg_cos: if C_NEGATIVE_COSINE = 1 generate
        pre_cos_x <= CONV_STD_LOGIC_VECTOR(0,ci_ram_output_width) - sin_lut(CONV_INTEGER('0'&cos_rom_addr));
      end generate i_neg_cos;
    end generate i_block_rom;

    sin_x <= pre_sin_x;
    cos_x <= pre_cos_x;

    -----------------------------------------------------------------------------
    -- Non-EFF
    -----------------------------------------------------------------------------
    i_no_eff: if C_NOISE_SHAPING /= c_noise_shaping_taylor generate
      pre_sine   <= sin_x(ci_ram_data_width-1 downto ci_ram_data_width-C_OUTPUT_WIDTH);
      pre_cosine <= cos_x(ci_ram_data_width-1 downto ci_ram_data_width-C_OUTPUT_WIDTH);
    end generate i_no_eff;
    -----------------------------------------------------------------------------
    -- EFF
    -----------------------------------------------------------------------------
    i_eff: if C_NOISE_SHAPING = c_noise_shaping_taylor generate

      i_eff: dds_compiler_v4_0_eff
        generic map(
          C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
          C_MODEL_TYPE        => 1,               -- = RTL
          C_ACCUMULATOR_WIDTH => C_ACCUMULATOR_WIDTH,
          CI_PIPE             => (others=>0), 
          C_HAS_CE            => C_HAS_CE,
          C_OUTPUT_WIDTH      => C_OUTPUT_WIDTH,
          C_OPTIMISE_GOAL     => C_OPTIMISE_GOAL,
          CI_RAM_DATA_WIDTH   => CI_RAM_DATA_WIDTH,
          CI_RAM_ADDR_WIDTH   => CI_RAM_ADDR_WIDTH,
          C_NEGATIVE_SINE     => C_NEGATIVE_SINE,
          C_NEGATIVE_COSINE   => C_NEGATIVE_COSINE
          )
        port map(
          clk              => clk,
          ce_i             => ce_i,
          mute_i           => '0',
          sin_x            => sin_x,
          cos_x            => cos_x,
          acc_phase_to_lut => acc_phase_to_lut,
          pre_final_sin    => pre_sine,
          pre_final_cos    => pre_cosine
          );
    end generate i_eff;

    -- purpose: pipelines to mimic latency
    i_sincos_op_pipes: block
      -- purpose: find length of pipe (differs for single channel because of accumulator reset
      function fn_clear_del (
        p_channels : integer;
        p_pipe     : t_pipe_top)
        return integer is
      begin  -- fn_clear_del
        if p_channels = 1 then
          return p_pipe(ci_phase_acc_stage);
        end if;
        return 0;
      end fn_clear_del;
    begin  -- block i_output_pipes
      i_has_sine : if C_OUTPUTS_REQUIRED = c_sine_op_reqd or C_OUTPUTS_REQUIRED = c_both_op_reqd generate
        i_pipe_sin : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY   => CI_SINCOS_LAT+CI_OP_LAT,  --see dither delay for comments
            C_HAS_CE    => C_HAS_CE,
            C_WIDTH     => C_OUTPUT_WIDTH
            )
          port map(
            CLK   => CLK,
            CE    => ce_i,
            D     => pre_sine,
            Q     => op_sine
            );
        SINE <= op_sine when rdy_i = '1' or C_POR_MODE=1 else (others => 'X');
      end generate i_has_sine;

      i_has_cos : if C_OUTPUTS_REQUIRED = c_cosine_op_reqd or C_OUTPUTS_REQUIRED = c_both_op_reqd generate
        i_pipe_cos : xbip_pipe_v2_0_xst
          generic map(
            C_LATENCY   => CI_SINCOS_LAT+CI_OP_LAT, --see dither delay for comments
            C_HAS_CE    => C_HAS_CE,
            C_WIDTH     => C_OUTPUT_WIDTH
            )
          port map(
            CLK   => CLK,
            CE    => ce_i,
            D     => pre_cosine,
            Q     => op_cosine
            );
         COSINE <= op_cosine when rdy_i = '1' or C_POR_MODE=1 else (others => 'X');
      end generate i_has_cos;
    end block i_sincos_op_pipes;  
  end generate I_SINCOS;

  i_channel_index : if C_HAS_CHANNEL_INDEX = 1 generate
    i_pipe_channel : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY   => ci_latency,
        C_HAS_CE    => C_HAS_CE,
        C_WIDTH     => ci_chan_width
        )
      port map(
        CLK   => CLK,
        CE    => ce_i,
        D     => chan_addr_del1,
        Q     => op_channel
        ); 
    CHANNEL <= op_channel when rdy_i = '1' or C_POR_MODE=1 else (others => 'X');
  end generate i_channel_index;

  I_PHASE_OUT : if C_HAS_PHASE_OUT = 1 generate
    PHASE_OUT <= op_phase_out  when rdy_i='1' or C_POR_MODE=1 else (others=>'X');
  end generate I_PHASE_OUT;

end behavioral;

