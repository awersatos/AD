-- $Header
--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.
library std, ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;

library xilinxcorelib;
use xilinxcorelib.bip_bram18k_v1_0_pkg.all;
-------------------------------------------------------------------------------
-- Designer note!!
-- This file is for core-internal use, so namespace conventions can be relaxed.
-- Any components or functions which external cores will need to access should
-- be kept in the hrdiv_pkg file.
-- This file should list all the internal component declarations
-------------------------------------------------------------------------------

package hrdiv_hdl_pkg_v1_0 IS

  -----------------------------------------------------------------------------
  -- General types and constants
  -----------------------------------------------------------------------------
  constant c_max_hrdiv_latency : integer := 30;

  constant ci_max_hrdiv_pipe_stages : integer := 30;  -- >= 256/10 which is the largest I expect
  type t_hrdiv_reg_opportunities is array (0 to ci_max_hrdiv_pipe_stages) of integer;
  type t_pipe is record                 -- latency scheme
                   used : integer;    --for automatic latency - returns actual.
                   pipe : t_hrdiv_reg_opportunities;
                 end record;

  constant ci_stage1  : integer := 1;
  constant ci_stage2  : integer := 2;
  constant ci_stage3  : integer := 3;
  constant ci_stage4  : integer := 4;
  constant ci_stage5  : integer := 5;

  --Core specifics
  constant ci_overlap           : integer := 2;
  constant ci_splice_width      : integer := 16;

  constant ci_max_carousel_latency : integer := 4;
  constant ci_guard_width : integer := 2;  -- number of guard bits in excess of desired result calculated before rounding applied.
  constant ci_denom_growth : integer := 1;  -- 2's complement denominator must be one bit wider to accommodate -2^N
  
  constant ci_vx4_op_width : integer := 68;
  constant ci_vx5_sp3_op_width : integer := 82;
  
  --C_FORMAT settings
  constant ci_fixed_operands : integer := 0;
  constant ci_float_operands : integer := 1;
  
  -----------------------------------------------------------------------------
  --estimator constants
  -----------------------------------------------------------------------------
  constant ci_est_ms_addr     : integer := 10;
  constant ci_est_data_width  : integer := 18;
  constant ci_est_fine_width  : integer := 17;
  constant ci_ms_sect_width   : integer := ci_est_ms_addr-1+ci_est_fine_width;  -- 9 = ram addr, 17 = fine adjust
  constant ci_est_coeff_width : integer := 18;

  --1 added to estimate width 26/02/08 because of pathological out of range scaledenoms.
  constant ci_estimate_width     : integer := ci_dsp48_b_width+1;
  constant ci_coarse_est_width   : integer := 22;
  constant ci_gradient_est_width : integer := 14;

  --Create lookup table of 1/x. i.e 1.0dddd = 1/0.1aaaa1
  --all the commented out code in this function is to do with the generation of
  --the coe file rather than mif file.
  function fn_ROM_table (
    p_addr_width : integer;
    p_data_width : integer)
    return t_BRAM18k_10_18_init_val;
    
  function fn_old_ROM_table (
    p_addr_width : integer;
    p_data_width : integer)
    return t_BRAM18k_10_18_init_val;
    
  -----------------------------------------------------------------------------
  -- Prescaler constants
  -----------------------------------------------------------------------------
  constant ci_prescaler_ip_width : integer := 9;
  constant ci_prescaler_ls_ext   : integer := 9;
  constant ci_prescaler_reciprocal_width : integer := 18;
  constant ci_max_iterations : integer := 4;
  constant ci_qbits_per_iter : integer := 18;
  constant ci_shift_per_iter : integer := 15;
  type t_residue_int is array (1 to ci_max_iterations) of integer;
--  type t_residue is array (1 to ci_max_iterations) of std_logic_vector(C_NUMER_WIDTH + ci_prescaler_reciprocal_width+ci_prescaler_ls_ext-1 downto 0);


  component fixed_to_float
    generic (
      C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := 1;
      C_DENOM_WIDTH     : integer := 0;
      C_HAS_SCLR        : integer := 0;
      C_HAS_DIV_BY_ZERO : integer := 0
      );
    port (
      CLK            : in  std_logic := '0';
      CE             : in  std_logic := '1';
      SCLR           : in  std_logic := '0';
      NEGATE         : out std_logic := '0';
      EXPONENT       : out std_logic_vector(log2roundup(C_DENOM_WIDTH+1)+1-1 downto 0) := (others => '0');
      DENOM          : in  std_logic_vector(C_DENOM_WIDTH-1 downto 0)   := (others => '0');
      NORMDENOM      : out std_logic_vector(C_DENOM_WIDTH-1-1 downto 0) := (others => '0');
      DIVIDE_BY_ZERO : out std_logic := '0'
      );
  end component fixed_to_float;
 
  
  component flow_ctrl is
    generic (
      C_VERBOSITY        : integer := 0;  -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE       : integer := 0;  -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY    : string  := "virtex4";
      C_LATENCY          : integer := 1;
      C_CAROUSEL_LATENCY : integer := 0;
      C_ITERATIONS       : integer := 0;
      C_HAS_SCLR         : integer := 0
      );
    port (
      CLK  : in  std_logic := '0';
      CE   : in  std_logic := '1';
      SCLR : in  std_logic := '0';
      ND   : in  std_logic := '0';
      RFD  : out std_logic := '0';
      RDY  : out std_logic := '0'
      );
  end component;
  
  -----------------------------------------------------------------------------
  -- Iterative unit - the engine!
  -----------------------------------------------------------------------------
  component iterative_unit is
    generic (
      C_VERBOSITY           : integer := 0;  -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_USE_DSP48           : integer := 0;  -- 0 = no,    1 = yes
      C_OPTIMIZE_GOAL       : integer := 0;  -- 0 = area,  1 = speed.
      C_MODEL_TYPE          : integer := 0;  -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY       : string  := "virtex4";
      C_LATENCY             : integer := 1;
      C_TAILOREDNUMER_WIDTH : integer := 16;
      C_ITERDENOM_WIDTH     : integer := 16;
      C_NUM_ITERATIONS      : integer := 1;
      C_SPLICE_WIDTH        : integer := 15;
      C_OVERLAP             : integer := 2;
      C_HAS_SCLR            : integer := 0
      );
    port (
      CLK          : in  std_logic                                          := '0';
      CE           : in  std_logic                                          := '1';
      SCLR         : in  std_logic                                          := '0';
      ND           : in  std_logic                                          := '0';
      ESTIMATE     : in  std_logic_vector(ci_estimate_width-1 downto 0)     := (others => '0');
      NUMER_IN     : in  std_logic_vector(C_TAILOREDNUMER_WIDTH-1 downto 0) := (others => '0');
      ITERDENOM    : in  std_logic_vector(C_ITERDENOM_WIDTH -1 downto 0)    := (others => '0');
      FIRST_DIGIT  : out std_logic                                          := '0';
      PENULT_DIGIT : out std_logic                                          := '0';
      LAST_DIGIT   : out std_logic                                          := '0';
      QUOT_OUT     : out std_logic_vector(C_SPLICE_WIDTH-1 downto 0)        := (others => '0')
      );
  end component iterative_unit;

  component estimator is
    generic (
      C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := 1;
      C_HAS_SCLR      : integer := 0
      );
    port (
      CLK      : in  std_logic                                  := '1';
      CE       : in  std_logic                                  := '1';
      SCLR     : in  std_logic                                  := '0';
      DENOM    : in  std_logic_vector(ci_ms_sect_width-1 downto 0) := (others => '0');
      ESTIMATE : out std_logic_vector(ci_estimate_width-1 downto 0) := (others => '0')
      );
  end component estimator;
  
  component prenormalizer is
    generic (
      C_VERBOSITY       : integer := 0;  -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;   -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := 1;
      C_SHIFT_WIDTH     : integer := 16;
      C_NORMNUMER_WIDTH : integer := 16;
      C_NUMER_WIDTH     : integer := 16;
      C_HAS_SCLR        : integer := 0
      );
    port (
      CLK       : in  std_logic                                                := '1';
      CE        : in  std_logic                                                := '1';
      SCLR      : in  std_logic                                                := '0';
      SHIFT     : in  std_logic_vector(C_SHIFT_WIDTH-1 downto 0)               := (others => '0');
      NUMER     : in  std_logic_vector(C_NUMER_WIDTH-1 downto 0)               := (others => '0');
      NORMNUMER : out std_logic_vector(C_NORMNUMER_WIDTH-1 downto 0) := (others => '0')
      );
  end component prenormalizer;
  
  component prescaler is
    generic (
      C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := 1;
      C_DENOM_WIDTH   : integer := 16;
      C_OUTPUT_WIDTH  : integer := 48;
      C_HAS_SCLR      : integer := 0
      );
    port (
      CLK        : in  std_logic                                  := '1';
      CE         : in  std_logic                                  := '1';
      SCLR       : in  std_logic                                  := '0';
      DENOM      : in  std_logic_vector(C_DENOM_WIDTH-1 downto 0) := (others => '0');
      ESTIMATE   : in  std_logic_vector(ci_estimate_width-1 downto 0) := (others => '0');
      SCALEDENOM : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0)  := (others => '0')
      );
  end component prescaler;

  component quotient_collector is
    generic (
      C_VERBOSITY        : integer := 0;  -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE       : integer := 0;  -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY    : string  := "virtex4";
      C_LATENCY          : integer := 1;
      C_CAROUSEL_LATENCY : integer := 1;
      C_SPLICE_WIDTH     : integer := 15;
      C_OVERLAP          : integer := 2;
      C_QUOT_WIDTH       : integer := 48;
      C_FRACT_WIDTH      : integer := 0;
      C_GUARD_WIDTH      : integer := 0;
      C_ALIGNMENT_WIDTH  : integer := 0;
      C_NUM_ITERATIONS   : integer := 0;
      C_HAS_SCLR         : integer := 0
      );
    port (
      CLK          : in  std_logic                                   := '0';
      CE           : in  std_logic                                   := '1';
      SCLR         : in  std_logic                                   := '0';
      NEGATE       : in  std_logic                                   := '0';
      FIRST_DIGIT  : in  std_logic                                   := '0';
      PENULT_DIGIT : in  std_logic                                   := '0';
      LAST_DIGIT   : in  std_logic                                   := '0';
      DIGIT_IN     : in  std_logic_vector(C_SPLICE_WIDTH-1 downto 0) := (others => '0');
      QUOT         : out std_logic_vector(C_QUOT_WIDTH-1 downto 0)   := (others => '0');
      FRACT        : out std_logic_vector(C_FRACT_WIDTH-1 downto 0)  := (others => '0')
      );
  end component quotient_collector;

  component quot_addsub is
    generic (
      C_VERBOSITY     : integer := 0;  -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_USE_DSP48     : integer := 0;   -- 0 = no,    1 = yes
      C_OPTIMIZE_GOAL : integer := 0;   -- 0 = area,  1 = speed.
      C_MODEL_TYPE    : integer := 0;   -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY : string  := "virtex4";
      C_LATENCY       : integer := 1;
      C_RESULT_WIDTH  : integer := 48;
      C_SPLICE_WIDTH  : integer := 16;
      C_HAS_SCLR      : integer := 0
      );
    port (
      CLK         : in  std_logic                                   := '0';
      CE          : in  std_logic                                   := '1';
      SCLR        : in  std_logic                                   := '0';
      NEGATE      : in  std_logic                                   := '0';
      FIRST_DIGIT : in  std_logic                                   := '0';
      OP_A        : in  std_logic_vector(C_RESULT_WIDTH-1 downto 0) := (others => '0');
      DIGIT_IN    : in  std_logic_vector(C_SPLICE_WIDTH-1 downto 0) := (others => '0');
      RESULT      : out std_logic_vector(C_RESULT_WIDTH-1 downto 0) := (others => '0')
      );
  end component quot_addsub;


  -----------------------------------------------------------------------------
  -- Function declarations
  -----------------------------------------------------------------------------
  function fn_fulldenom_width (
    p_format      : integer;
    p_denom_width : integer)
    return integer;

  function fn_normnumer_width (
    p_format      : integer;
    p_denom_width : integer;
    p_numer_width : integer)
    return integer;

  function fn_result_width (
    p_verbosity       : integer;
    p_quot_width      : integer;
    p_fract_width     : integer;
    p_guard_width     : integer;
    p_alignment_width : integer)
    return integer;
  
  function fn_get_num_iterations (
    p_numer_width  : integer;
    p_splice_width : integer;
    p_overlap      : integer)
    return integer;
  
  -----------------------------------------------------------------------------
  -- Latency allocation function declarations
  -----------------------------------------------------------------------------

  function fn_alloc_twos_comp_lat (
    p_latency     : integer;
    p_denom_width : integer)
    return t_pipe;

  function fn_alloc_iterative_unit (
    p_latency : integer)
    return t_pipe;

  function fn_alloc_est_lat (
    p_latency : integer)
    return t_pipe;

  function fn_alloc_prenorm_lat(
    p_verbosity     : integer;
    p_xdevicefamily : string;
    p_latency       : integer;
    p_shift_width   : integer)
    return t_pipe;

  function fn_alloc_quot_coll_lat (
    p_latency         : integer;
    p_xdevicefamily   : string;
    p_verbosity       : integer;
    p_quot_width      : integer;
    p_fract_width     : integer;
    p_guard_width     : integer;
    p_alignment_width : integer)
    return t_pipe;
  
  function fn_alloc_addsub_lat (
    p_latency       : integer;
    p_xdevicefamily : string;
    p_result_width  : integer)
    return t_pipe;
  
  function fn_get_tailorednumer_width (
    p_numer_width           : integer;
    p_normnumer_width       : integer;
    p_fract_width           : integer;
    p_guard_width           : integer)
    return integer;

  function fn_get_result_width (
    p_numer_width           : integer;
    p_fract_width           : integer;
    p_guard_width           : integer)
    return integer;

  function fn_get_denom_alignment (
    p_splices_required : integer;
    p_splice_width     : integer;
    p_scaledenom_width : integer)
    return integer;

  function fn_get_splices_required (
    p_scaledenom_width : integer;
    p_splice_width     : integer)
    return integer;

  function fn_op_width_limit (
    P_XDEVICEFAMILY : string)
    return integer;

end package hrdiv_hdl_pkg_v1_0;

package body hrdiv_hdl_pkg_v1_0 is

  -----------------------------------------------------------------------------
  -- Allocate hrdiv latency
  -----------------------------------------------------------------------------
  constant ci_carry_stages_vx4     : integer := 12;  -- Carry chain stages tolerable for max freq
  constant ci_carry_stages_vx5     : integer := 16;  -- Carry chain stages tolerable for max freq 
  constant ci_carry_stages_sp3adsp : integer := 8;   -- Carry chain stages tolerable for max freq
  constant ci_carry_stages_others  : integer := 10;  -- Carry chain stages tolerable for max freq
  -- purpose: defines number of latency stages required for fabric hrdiv to reach full speed
  function fn_carry_stages (
    P_XDEVICEFAMILY : string;
    P_WIDTH         : integer)
    return integer is
  begin  -- fn_carry_stages
    if has_DSP48(P_XDEVICEFAMILY) then
      return ci_carry_stages_vx4;
    elsif has_DSP48e(P_XDEVICEFAMILY) then
      return ci_carry_stages_vx5;
    elsif has_DSP48a(P_XDEVICEFAMILY) then
      return ci_carry_stages_sp3adsp;
    else
      return ci_carry_stages_others;
    end if;
  end fn_carry_stages;


  --Create lookup table of 1/x. i.e 1.0dddd = 1/0.1aaaa1
  --all the commented out code in this function is to do with the generation of
  --the coe file rather than mif file.
  function fn_ROM_table (
    p_addr_width : integer;
    p_data_width : integer)
    return t_BRAM18k_10_18_init_val is
    variable ret_val           : t_BRAM18k_10_18_init_val;
    variable addr              : integer;
    variable exact_result      : integer;
    constant c_max_int_power   : integer := 30;
    variable exact_slv         : std_logic_vector(c_max_int_power-p_addr_width-1+1 downto 0);
    type t_coarse_array is array (0 to 511) of std_logic_vector(ci_coarse_est_width+1-1 downto 0);
    type t_gradient_array is array (0 to 511) of std_logic_vector(ci_gradient_est_width-1 downto 0);
    variable coarse_result     : t_coarse_array;
    variable gradient_result   : t_gradient_array;
    variable temp_mod          : std_logic_vector(ci_coarse_est_width+2+1-1 downto 0);
    variable coarse_result_mod : t_coarse_array;
    variable prev_x            : integer := 0;
    variable post_x            : integer := 0;
    constant loop_length       : integer := 2**(p_addr_width-1);
    constant loop_power        : integer := p_addr_width-1+ci_coarse_est_width+2;  -- precision required
    constant rounding_extra    : integer := 1;
    constant big_one           : integer := 2**c_max_int_power;

    -- round bit is because not full precision of estimate is used. Adding
    -- rounding externally would require 3 ip adder, so done in table.
    -- Was 2**(ci_coarse_est_width-p_data_width-2) for 18 bit estimate, now -3
    -- for 19 bit estimate.
    constant round_bit         : integer := 2**(ci_coarse_est_width-p_data_width-3);
--top bit of second word, i.e bit 19
  begin
--    assert false report "big_one ="&integer'image(big_one) severity note;
--    assert false report "loop_length ="&integer'image(loop_length) severity note;
    --For better accuracy, use 1/(p+0.5) rather than 1/p
    --This also avoids the MSB problem that 1/0.5 = 2 
    for i in 0 to loop_length-1 loop
      addr         := 2*(loop_length + i)+1;  --See note 1 above
      exact_result := big_one/addr + round_bit;
--      exact_result := big_one/(addr*(2**rounding_extra))+2;
--      assert false report "exact_result = "&integer'image(exact_result) severity note;
      exact_slv    := CONV_STD_LOGIC_VECTOR(exact_result, c_max_int_power-p_addr_width+1);

      --Unfortunately, the precision required is greater than VHDL integers,
      --hence calculating to the limit of integer precision and padding on 3 bits.
--      coarse_result(i) := CONV_STD_LOGIC_VECTOR(exact_result, ci_coarse_est_width+1);
      coarse_result(i) := exact_slv(exact_slv'left-1 downto exact_slv'left - ci_coarse_est_width+2)&"100";
    end loop;  -- i

    --fill in -1/x^2 table, this is the gradient of 1/x
    --for most points this is 1/(x(i+1))-1/(x(i-1))/2, but for the end points
    --this would give index problems so a different formula is used.

    --first and last points dont have a point either side of them, so they can't
    --use the same way of calculating 'gradient'.
--    ret_val(loop_length)(ci_gradient_est_width-1 downto 0) :=
--      CONV_STD_LOGIC_VECTOR(CONV_INTEGER("01"&coarse_result(1))-CONV_INTEGER("01"&coarse_result(0)),ci_coarse_est_width)(ci_gradient_est_width-1 downto 0);
    gradient_result(0) :=
      CONV_STD_LOGIC_VECTOR(CONV_INTEGER("01"&coarse_result(1))-CONV_INTEGER("01"&coarse_result(0)), ci_coarse_est_width)(ci_gradient_est_width-1 downto 0);
    for j in 1 to loop_length -2 loop
      prev_x             := CONV_INTEGER("01"&coarse_result(j-1));
      post_x             := CONV_INTEGER("01"&coarse_result(j+1));
      gradient_result(j) := CONV_STD_LOGIC_VECTOR((post_x - prev_x)/2, ci_coarse_est_width)(ci_gradient_est_width-1 downto 0);
    end loop;  -- j
    gradient_result(loop_length-1) :=
      CONV_STD_LOGIC_VECTOR(CONV_INTEGER("01"&coarse_result(loop_length-1))-CONV_INTEGER("01"&coarse_result(loop_length-2)), ci_coarse_est_width)(ci_gradient_est_width-1 downto 0);

--    for k in 1 to loop_length-2 loop
--      --draw a line between the point above and below, get the average and add
--      --modify the central point upwards
--      --x(mid) = x(mid)/2 + x(before)/4 + x(after)/4
--      temp_mod := std_logic_vector(resize(signed(coarse_result(k)),ci_coarse_est_width+2))&'0'; 
--      temp_mod := temp_mod + (coarse_result(k+1) + coarse_result(k-1));
--      coarse_result_mod(k) := temp_mod(temp_mod'left downto 2);  --implicit /4
--    end loop;  -- k
--    --modify end points by the same amount as their neighbours.
--    coarse_result_mod(0) := coarse_result(0)+ (coarse_result_mod(1)-coarse_result(1));
--    coarse_result_mod(loop_length-1) := coarse_result(loop_length-1)+ (coarse_result_mod(loop_length-2)-coarse_result(loop_length-2));

    for m in 0 to loop_length-1 loop
      ret_val(m)     := coarse_result(m)(ci_coarse_est_width-1 downto ci_coarse_est_width-p_data_width);
      ret_val(m+512) := coarse_result(m)(ci_coarse_est_width-p_data_width-1 downto 0) & gradient_result(m);
--      ret_val(m+512)(p_data_width-1 downto p_data_width-(ci_coarse_est_width-p_data_width)) :=
--        coarse_result_mod(m)(ci_coarse_est_width-p_data_width-1 downto 0);  
    end loop;  -- m

    return ret_val;
  end fn_ROM_table;

  --Original ROM_lookup code
  --Create lookup table of 1/x. i.e 1.0dddd = 1/0.1aaaa1
  --all the commented out code in this function is to do with the generation of
  --the coe file rather than mif file.
  function fn_old_ROM_table (
    p_addr_width : integer;
    p_data_width : integer)
    return t_BRAM18k_10_18_init_val is
    variable ret_val      : t_BRAM18k_10_18_init_val;
    variable addr         : integer;
    variable exact_result : integer;
    variable slv_result   : std_logic_vector(p_data_width downto 0);
    variable prev_x : integer := 0;
    variable post_x : integer := 0;
    constant loop_length : integer := 2**(p_addr_width-1);
    constant loop_power : integer := p_addr_width-1+p_data_width+2;  -- precision required
    constant rounding_extra : integer := 1;
  begin
    for i in 0 to loop_length-1 loop
                                                  --For better accuracy, use 1/(p+0.5) rather than 1/p
                                                  --This also avoids the MSB problem that 1/0.5 = 2 
      addr         := 2*(loop_length + i)+1;  --See note 1 above


-------------------------------------------------------------------------------
-- ok, explanation required here. The estimate rounding is awkward because it
-- needs to be rounded one bit below the bottom bit used. However, for precision,
-- the coarse estimate is 18 bits, but this is then prepended by the 1 of 1.0000
-- hence the rounding bit in the multadd is one bit too low. Hence the table entries
-- are boosted by the same amount so that the net effect is a single rounding
-- bit one bit higher. Hence the +2 rather than the +4 described below.
-------------------------------------------------------------------------------
      
      exact_result := (2**(loop_power+rounding_extra))/(addr*(2**rounding_extra))+2;
--      exact_result := (2**(loop_power+rounding_extra))/(addr*(2**rounding_extra));
--      exact_result := (2**(loop_power+rounding_extra))/(addr*(2**rounding_extra))+4;
      --why +4? Well, the 0.5 becomes 1 because of the 'rounding extra' bit.
      --the other 2 bit shifts come from the fact that the estimate starts as
      --01XXXX, with 18 X's, but only the top 18 bits go to multiplies, so the bottom
      --2 Xs are lost.

      slv_result   := CONV_STD_LOGIC_VECTOR(exact_result, p_data_width+1);
      ret_val(i)   := slv_result(p_data_width-1 downto 0);  --p_data_width-1 downto 0?
    end loop;  -- i

    --fill in -1/x^2 table, this is the gradient of 1/x
    --for most points this is 1/(x(i+1))-1/(x(i-1))/2, but for the end points
    --this would give index problems so a different formula is used.

    --first and last points dont have a point either side of them, so they can't
    --use the same way of calculating 'gradient'.
    ret_val(loop_length) := CONV_STD_LOGIC_VECTOR(CONV_INTEGER("01"&ret_val(1))-CONV_INTEGER("01"&ret_val(0)),p_data_width);
    for j in 1 to loop_length -2 loop
      prev_x := CONV_INTEGER("01"&ret_val(j-1));
      post_x := CONV_INTEGER("01"&ret_val(j+1));
      ret_val(j+loop_length) := CONV_STD_LOGIC_VECTOR((post_x - prev_x)/2,p_data_width);
    end loop;  -- j
    ret_val(loop_length*2-1) := CONV_STD_LOGIC_VECTOR(CONV_INTEGER("01"&ret_val(loop_length-1))-CONV_INTEGER("01"&ret_val(loop_length-2)),18);
    return ret_val;
  end fn_old_ROM_table;

  -- purpose: depending on fixed or float format, the internal denominator width varies
  function fn_fulldenom_width (
    p_format      : integer;
    p_denom_width : integer)
    return integer is
  begin  -- fn_fulldenom_width
    if p_format = ci_fixed_operands then
      return p_denom_width+ci_denom_growth;   -- -2 +2 (decapitated then recapitated)+1 for
-- sign extension (must accommodate DENOM = -2^N)      
    end if;
    return p_denom_width+2;             --extra 2 are leading "01"
  end fn_fulldenom_width;

  function fn_normnumer_width (
    p_format      : integer;
    p_denom_width : integer;
    p_numer_width : integer)
    return integer is
  begin
    if p_format = ci_fixed_operands then
      return p_denom_width + p_numer_width-1;  --the -1 is because the max
--shift is one less than numer_width
    else
      return p_numer_width + 2;         -- prepend "01"
    end if;
  end fn_normnumer_width;

  --calculates width of result for quotient collecter
  function fn_result_width (
    p_verbosity       : integer;
    p_quot_width      : integer;
    p_fract_width     : integer;
    p_guard_width     : integer;
    p_alignment_width : integer)
    return integer is
    variable ret_val : integer := 0;
  begin  -- fn_result_width
    assert p_verbosity < 2 report "NOTE: C_QUOT_WIDTH = "&integer'image(p_quot_width)
      severity note;
    assert p_verbosity < 2 report "NOTE: C_FRACT_WIDTH = "&integer'image(p_fract_width)
      severity note;
    assert p_verbosity < 2 report "NOTE: C_GUARD_WIDTH = "&integer'image(p_guard_width)
      severity note;
    assert p_verbosity < 2 report "NOTE: C_ALIGNMENT_WIDTH = "&integer'image(p_alignment_width)
      severity note;
    ret_val := p_quot_width+p_fract_width+p_guard_width+p_alignment_width;
    assert p_verbosity < 2 report "NOTE: ci_result_width = "&integer'image(ret_val)
      severity note;
    return ret_val;
  end fn_result_width;
  -----------------------------------------------------------------------------
  -- Latency allocation functions
  -----------------------------------------------------------------------------

  function fn_alloc_iterative_unit (
    p_latency : integer)
    return t_pipe is
    variable ret_val : t_pipe;
    variable v_latency_left : integer;
  begin
    --initialise all latency stages to 0.
    for i in 0 to ci_max_hrdiv_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used   := 0;
    v_latency_left := p_latency;

    --deal out latency according to generics and architecture for optimal speed
    --and resource
    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(ci_stage4) := ret_val.pipe(ci_stage4) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(ci_stage2) := ret_val.pipe(ci_stage2) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(ci_stage3) := ret_val.pipe(ci_stage3) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(ci_stage1) := ret_val.pipe(ci_stage1) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left > 0 then
      assert false
        report "ERROR: excess latency in fn_alloc_iterative_unit."
        severity error;
    end if;
    return ret_val;
  end fn_alloc_iterative_unit;

  function fn_alloc_twos_comp_lat (
    p_latency     : integer;
    p_denom_width : integer)
    return t_pipe is
    variable ret_val : t_pipe;
    variable v_latency_left : integer;
  begin
    --initialise all latency stages to 0.
    for i in 0 to ci_max_hrdiv_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used   := 0;
    v_latency_left := p_latency;

    --deal out latency according to generics and architecture for optimal speed
    --and resource
    if p_denom_width > ci_dsp48_p_width-1 then
      if v_latency_left /= 0 then
        v_latency_left          := v_latency_left-1;
        ret_val.pipe(ci_stage4) := ret_val.pipe(ci_stage4) +1;
        ret_val.used            := ret_val.used +1;
      end if;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(ci_stage2) := ret_val.pipe(ci_stage2) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if p_denom_width > ci_dsp48_p_width-1 then
      if v_latency_left /= 0 then
        v_latency_left          := v_latency_left-1;
        ret_val.pipe(ci_stage3) := ret_val.pipe(ci_stage3) +1;
        ret_val.used            := ret_val.used +1;
      end if;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(ci_stage1) := ret_val.pipe(ci_stage1) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left > 0 then
      assert false
        report "ERROR: excess latency in fn_alloc_twos_comp_lat."
        severity error;
    end if;
    return ret_val;
  end fn_alloc_twos_comp_lat;

  function fn_alloc_est_lat (
    p_latency : integer)
    return t_pipe is
    variable ret_val : t_pipe;
    variable v_latency_left : integer;
  begin  -- fn_alloc_est_lat
    --initialise all latency stages to 0.
    for i in 0 to ci_max_hrdiv_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used   := 0;
    v_latency_left := p_latency;

    --deal out latency according to generics and architecture for optimal speed
    --and resource
    --The first one is essential. This is the fixed BRAM register stage. 
    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(1) := ret_val.pipe(1) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(5) := ret_val.pipe(5) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(3) := ret_val.pipe(3) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(2) := ret_val.pipe(2) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left          := v_latency_left-1;
      ret_val.pipe(4) := ret_val.pipe(4) +1;
      ret_val.used            := ret_val.used +1;
    end if;

    --Error if excess.
    if v_latency_left > 0 then
      assert false
        report "ERROR: excess latency in xbip_hrdiv:estimator"
        severity error;
    end if;
    return ret_val;
  end fn_alloc_est_lat;

  -- purpose: allocate latency to prenormalizer
  function fn_alloc_prenorm_lat (
    p_verbosity     : integer;
    p_xdevicefamily : string;
    p_latency       : integer;
    p_shift_width   : integer)
    return t_pipe is
    variable ret_val : t_pipe;
    variable v_latency_left : integer;
  begin  -- fn_alloc_prenorm_lat
    --initialise all latency stages to 0.
    for i in 0 to ci_max_hrdiv_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used   := 0;
    v_latency_left := p_latency;

    --allocate latency to each other stage since we're told
    --that 4:1 mux is possible at full speed - revisit if wrong.
    for i in 1 to p_shift_width/2 loop
      if v_latency_left /= 0 then
        v_latency_left    := v_latency_left-1;
        ret_val.pipe(i*2) := ret_val.pipe(i*2) +1;
        ret_val.used      := ret_val.used +1;
      end if;
    end loop;  -- i

    --ensure any odd last stage is registered
    if v_latency_left /= 0 then
      v_latency_left    := v_latency_left-1;
      ret_val.pipe(p_shift_width) := ret_val.pipe(p_shift_width) +1;
      ret_val.used      := ret_val.used +1;
    end if;
    --Lump excess on last stage
    if v_latency_left > 0 then
      ret_val.pipe(p_shift_width) := ret_val.pipe(p_shift_width)+v_latency_left;
      ret_val.used                := ret_val.used +v_latency_left;
      v_latency_left              := v_latency_left-v_latency_left;  --anal, but force of habit
    end if;
    return ret_val;
  end fn_alloc_prenorm_lat;

  function fn_alloc_quot_coll_lat (
    p_latency         : integer;
    p_xdevicefamily   : string;
    p_verbosity       : integer;
    p_quot_width      : integer;
    p_fract_width     : integer;
    p_guard_width     : integer;
    p_alignment_width : integer
    )
    return t_pipe is
    variable v_result_width : integer := 0;
    constant ci_result_width        : integer := fn_get_result_width(
      p_numer_width => p_quot_width,
      p_fract_width => p_fract_width,
      p_guard_width => ci_guard_width
      );
    constant ci_num_iterations      : integer := fn_get_num_iterations(
      p_numer_width  => ci_result_width,
      p_splice_width => ci_splice_width,
      p_overlap      => ci_overlap
      );
  begin
    v_result_width := (ci_splice_width-ci_overlap)*ci_num_iterations+ci_overlap;
--    v_result_width := fn_result_width(
--      p_verbosity       => p_verbosity       ,      
--      p_quot_width      => p_quot_width      ,
--      p_fract_width     => p_fract_width     ,
--      p_guard_width     => p_guard_width     ,
--      p_alignment_width => p_alignment_width
--      );
    return fn_alloc_addsub_lat(
      p_latency       => p_latency,
      p_xdevicefamily => p_xdevicefamily,
      p_result_width  => v_result_width
      );
  end fn_alloc_quot_coll_lat;
  
  function fn_alloc_addsub_lat (
    p_latency       : integer;
    p_xdevicefamily : string;
    p_result_width  : integer
    )
    return t_pipe is
    variable ret_val : t_pipe;
    variable v_latency_left : integer;
  begin
    --initialise all latency stages to 0.
    for i in 0 to ci_max_hrdiv_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    ret_val.used   := 0;
    v_latency_left := p_latency;

    --two DSP48s required
    if p_result_width > ci_dsp48_p_width then
      --Vx4 requires doesn't have carryout, so requires 4 stage latency
      if has_dsp48(P_XDEVICEFAMILY) then
        if v_latency_left /= 0 then
          v_latency_left  := v_latency_left-1;
          ret_val.pipe(4) := ret_val.pipe(4) +1;
          ret_val.used    := ret_val.used +1;
        end if;
      else
        if v_latency_left /= 0 then
          v_latency_left  := v_latency_left-1;
          ret_val.pipe(3) := ret_val.pipe(3) +1;
          ret_val.used    := ret_val.used +1;
        end if;
      end if;
    end if;

    if v_latency_left /= 0 then
      v_latency_left  := v_latency_left-1;
      ret_val.pipe(2) := ret_val.pipe(2) +1;
      ret_val.used    := ret_val.used +1;
    end if;

    if v_latency_left /= 0 then
      v_latency_left  := v_latency_left-1;
      ret_val.pipe(1) := ret_val.pipe(1) +1;
      ret_val.used    := ret_val.used +1;
    end if;

    if p_result_width > ci_dsp48_p_width then
      if has_dsp48(P_XDEVICEFAMILY) then
        if v_latency_left /= 0 then
          v_latency_left  := v_latency_left-1;
          ret_val.pipe(3) := ret_val.pipe(3) +1;
          ret_val.used    := ret_val.used +1;
        end if;
      end if;
    end if;

    if v_latency_left > 0 then
      assert false
        report "ERROR: xbip_hrdiv: excess latency in quotient collector"
        severity error;
    end if;
    return ret_val;
  end function fn_alloc_addsub_lat;

  function fn_get_num_iterations (
    p_numer_width  : integer;
    p_splice_width : integer;
    p_overlap      : integer)
    return integer is
  begin
    return (p_numer_width-1)/(p_splice_width-p_overlap) + 1;
  end fn_get_num_iterations;

  -- purpose: does what it says on the tin
  function fn_get_tailorednumer_width (
    p_numer_width           : integer;
    p_normnumer_width       : integer;
    p_fract_width           : integer;
    p_guard_width           : integer)
    return integer is
    variable v_natural_width : integer := 0;
  begin  -- fn_get_tailorednumer_width
    --How many bits feed into the iterative engine?
    --Answer: only as many as we have. The iterative engine will create zeros
    --as required. Hence if answer required is bigger because of large fractional
    --then supply only the whole normnumer - the iterative engine will pad with
    --zeros for the number of iterations required.
    v_natural_width := p_numer_width+p_fract_width+p_guard_width;
    if v_natural_width > p_normnumer_width then
      return p_normnumer_width;
    end if;
    return v_natural_width;
  end fn_get_tailorednumer_width;
  
  function fn_get_result_width (
    p_numer_width           : integer;
    p_fract_width           : integer;
    p_guard_width           : integer
    )
    return integer is
  begin  -- fn_get_result_width
    --How many bits feed into the iterative engine?
    --Answer: only as many as we have. The iterative engine will create zeros
    --as required. Hence if answer required is bigger because of large fractional
    --then supply only the whole normnumer - the iterative engine will pad with
    --zeros for the number of iterations required.
    return p_numer_width+p_fract_width+p_guard_width;
  end fn_get_result_width;
  
  function fn_get_denom_alignment (
    p_splices_required : integer;
    p_splice_width     : integer;
    p_scaledenom_width : integer)
    return integer is
  begin
    return (p_splices_required-1)*p_splice_width+3-(p_scaledenom_width);
  end fn_get_denom_alignment;

  function fn_get_splices_required (
    p_scaledenom_width : integer;
    p_splice_width     : integer)
    return integer is
  begin  -- fn_get_splices_required
    return (p_scaledenom_width-3-1)/p_splice_width +2;
  end fn_get_splices_required;
  
  function fn_op_width_limit (
    P_XDEVICEFAMILY : string)
    return integer is
  begin
    if has_DSP48(p_xdevicefamily) then
      return ci_vx4_op_width;
    end if;
    return ci_vx5_sp3_op_width;
  end;
  
end hrdiv_hdl_pkg_v1_0;
