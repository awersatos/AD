-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 4.0
--  \   \        Filename: $RCSfile: dds_compiler_v4_0_eff.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:31 $
-- /___/   /\    Date Created: 2009
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : dds_compiler_v4_0
-- Purpose : Taylor series correction (Synthesizable model)
-------------------------------------------------------------------------------
--  (c) Copyright 2009 Xilinx, Inc. All rights reserved.
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
-- DESCRIPTION
--
-- The EFF (Error Feed Forward) entity performs what is also known as Taylor
-- Series Correction to the DDS output. Since, for high precision DDS designs
-- the accumulator and output buses may be in the 12 to 21 bit wide region, it
-- would be impractical to have a 21x21 bit Lookup table. The RAM would be
-- huge. Hence, only the top 11 bits of the accumulated phase are fed to the
-- RAM. The RAM holds two quadrants and address mapping so that it appears to
-- be an 11x18 RAM. The remaining bits of the accumulated phase are turned into
-- radians (multiplied by PI in a constant coefficient multiplier). This radian
-- error is then use to adjust the primary SIN and COS outputs by taking a
-- tangent to the SIN/COS curves. The gradient is available from the other
-- output in each case since SIN and COS are each other's first differential.
-- This gradient is multiplied by the radian error. It looks like interpolation
-- between the RAM addresses, but is strictly speaking extrapolation.
-- The bus widths and weights are very complicated. To keep the design as small
-- as possible, the width of the EFF component is keep to a minimum by figuring
-- the output width. A guard bit is added for each operation, hence the bit
-- growth in the earlier parts of the calculation. Also the phase error to
-- radians calculation is PI* some power of two. The power of two is handled by
-- shifting the bus indices - hence the confusing indexing.
-- Some attempt was made to make use of the DSP48A pre-adder (to suck in part
-- of the CCM) but since the preadder to multiplier bus is fixed, the same bus
-- index manipulation isn't possible. This would have led to subtle behavioural
-- differences between the DSP48A and other models, so I gave up on this
-- optimization. (5 slices max anyway).
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;

library xilinxcorelib;
use xilinxcorelib.xbip_pipe_v2_0_xst_comp.all;

library xilinxcorelib;
use xilinxcorelib.pkg_dds_compiler_v4_0.all;
use xilinxcorelib.dds_compiler_v4_0_sim_comps.all;

entity dds_compiler_v4_0_eff is
  generic (
    C_XDEVICEFAMILY     : string;
    C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
    C_ACCUMULATOR_WIDTH : integer;
    CI_PIPE             : t_pipe_top;
    C_HAS_CE            : integer;
    C_OUTPUT_WIDTH      : integer;
    C_OPTIMISE_GOAL     : integer;
    CI_RAM_DATA_WIDTH   : integer;
    CI_RAM_ADDR_WIDTH   : integer;
    C_NEGATIVE_SINE     : integer;
    C_NEGATIVE_COSINE   : integer
    );
  port (
    clk                 : in  std_logic                                         := '0';
    ce_i                : in  std_logic                                         := '0';
    mute_i              : in  std_logic                                         := '0';
    sin_x               : in  std_logic_vector(CI_RAM_DATA_WIDTH-1 downto 0)    := (others => '0');
    cos_x               : in  std_logic_vector(CI_RAM_DATA_WIDTH-1 downto 0)    := (others => '0');
    acc_phase_to_lut    : in  std_logic_vector(C_ACCUMULATOR_WIDTH -1 downto 0) := (others => '0');
    pre_final_sin       : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0)       := (others => '0');
    pre_final_cos       : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0)       := (others => '0')
    );
end dds_compiler_v4_0_eff;

architecture synth of dds_compiler_v4_0_eff is

  constant C_TAYLOR_ORDER    : integer := fn_get_taylor_order(C_OUTPUT_WIDTH);
  constant C_SC_LUT_LAT      : integer := CI_PIPE(ci_LUT_stage);               -- Latency of sin-cos lut (i.e. delay of  sin_x over acc_phase_to_lut)
  constant ci_eff_stretch    : integer := C_OUTPUT_WIDTH - CI_RAM_ADDR_WIDTH;  -- amount EFF has to expand accuracy by
  constant ci_internal_width : integer := ci_dsp48_p_width;
  constant ci_mult_width     : integer := ci_dsp48_b_width;

  -- Specifies whether to use a multiplier or BRAM to calculate 2*((x-0.5)*pi)^2 in second order taylor
  constant ci_use_mult_not_bram : boolean := false;

  type int_array is array(natural range <>) of integer;
  constant ci_eff_max_latency : integer := 8;
  constant ci_eff_stage0 : integer := 0;
  constant ci_eff_stage1 : integer := 1;
  constant ci_eff_stage2 : integer := 2;
  constant ci_eff_stage3 : integer := 3;
  constant ci_eff_stage4 : integer := 4;
  constant ci_eff_stage5 : integer := 5;
  constant ci_eff_stage6 : integer := 6;
  constant ci_eff_stage7 : integer := 7;

  type t_latency_alloc is array (0 to ci_eff_max_latency -1) of integer;

  -- purpose: allocate latency
  function fn_latency_pattern (
    p_pipe         : t_pipe_top;
    p_taylor_order : integer
    )
    return t_latency_alloc is
    variable ret_val : t_latency_alloc;
  begin  -- fn_latency_pattern
    for i in 0 to ci_eff_max_latency -1  loop
      ret_val(i) := 0;
    end loop;  -- i
    case p_pipe(ci_LUT_stage) is
      when 0      => ret_val(0 to 2) := (0,0,0);
      when 1      => ret_val(0 to 2) := (0,0,1);
      when 2      => ret_val(0 to 2) := (1,0,1);
      when others => ret_val(0 to 2) := (1,1,1);
    end case;
    if p_taylor_order = 1 then
      case p_pipe(ci_eff_stage) is
        when 0      => ret_val(3 to 5) := (0,0,0);
        when 1      => ret_val(3 to 5) := (0,0,1);
        when 2      => ret_val(3 to 5) := (1,0,1);
        when 3      => ret_val(3 to 5) := (1,1,1);
        when others =>
          assert false
            report "ERROR: too much latency in eff"
            severity error;
      end case;
    else
      case p_pipe(ci_eff_stage) is
        when 0      => ret_val(3 to 7) := (0,0,0,0,0);
        when 1      => ret_val(3 to 7) := (0,1,0,0,0);   -- make sure there is a 1 in 3 or 4 to give bram 1 cycle
        when 2      => ret_val(3 to 7) := (0,1,0,0,1);
        when 3      => ret_val(3 to 7) := (0,1,1,0,1);
        when 4      => ret_val(3 to 7) := (1,1,1,0,1);
        when 5      => ret_val(3 to 7) := (1,1,1,1,1);
        when others =>
          assert false
            report "ERROR: too much latency in eff"
            severity error;
      end case;
    end if;
    return ret_val;
  end fn_latency_pattern;


  constant pipe_regs : t_latency_alloc := fn_latency_pattern(
    p_pipe         => CI_PIPE,
    p_taylor_order => C_TAYLOR_ORDER
    );

  signal PI_fixed_point   : std_logic_vector(ci_mult_width-1 downto 0) := "011001001000011111";  --Pi*2^15, 17 bits
  signal PI_fixed_squared : std_logic_vector(ci_mult_width-1 downto 0) := "010011101111010011";  --(Pi^2)*2^13, 17 bits

  constant ci_pi          : std_logic_vector(ci_eff_stretch + 2 -1 downto 0) := fn_get_pi(ci_eff_stretch+2);
  signal diag_pi          : std_logic_vector(ci_eff_stretch + 2 -1 downto 0) := ci_pi;

  signal dx_pi            : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal dx_pi_s2         : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal dx_pi_s3         : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal dx_pi_squared    : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal dx_pi_squared18  : std_logic_vector(17 downto 0)                  := (others => '0');

  signal sin_s0           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_s0           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_ccm_s0       : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_ccm_s0       : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_ccm_s1       : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_ccm_s1       : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_s1i          : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_s1i          : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_s2i          : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_s2i          : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_s1           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_s1           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_s2           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_s2           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_s3           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_s3           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_s4           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_s4           : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal sin_x_delayed    : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal cos_x_delayed    : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');

  constant ci_phase_error_width : integer := C_ACCUMULATOR_WIDTH-CI_RAM_ADDR_WIDTH;

  signal accum_fraction_s0         : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal accum_fraction_s0_delayed : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');
  signal accum_frac                : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal accum_frac_s0             : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal accum_frac_s2             : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal accum_frac_s1i            : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal accum_frac_s2i            : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal sin_ccm_s2i               : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal cos_ccm_s2i               : std_logic_vector(ci_mult_width-1 downto 0)     := (others => '0');
  signal accum_fraction_squared    : std_logic_vector(ci_internal_width-1 downto 0) := (others => '0');

  --The following 2 signals control the coefficient sign to accommodate
  --C_NEGATIVE_SINE and C_NEGATIVE_COSINE
  signal sub_sin          : std_logic := '0';
  signal sub_cos          : std_logic := '0';

  constant pi_slv         : std_logic_vector(ci_internal_width-1 downto 0) := "000000000000000110010010000111110000000000000000";  --Pi*2^15, 17 bits;
  constant half_pi_neg    : std_logic_vector(ci_internal_width-1 downto 0) := std_logic_vector(-signed(pi_slv));
  constant dx_pi_shift    : integer := CI_RAM_ADDR_WIDTH+1;
  -- This value is derived to maximize the use of the DSP48s.
  constant s1_shift       : integer := 6; -- This is the amount by which the first stage sine must be scaled down to align with product

  function slv_to_real(x : std_logic_vector; fw : integer) return real is
    variable res  : real    := 0.0;
  begin
    if x'length > 30 then
      res := real(to_integer(unsigned(x(29 downto 0))));
      res := res + real(to_integer(signed(x(x'left downto 30))))*2.0**30;
    else
      res := real(to_integer(signed(x)));
    end if;
    return res*(2.0**(-fw));
  end function slv_to_real;

  signal a_s1_sin_u           : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
  signal a_s1_cos_u           : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
  signal a_mult_pi_u          : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
  signal a_mult_pi2_u         : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
  signal a_mult_pi2_u_partial : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
  signal a_s2_sin_u           : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
  signal a_s2_cos_u           : std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
  signal a_mult_bram_u        : std_logic_vector(9 downto 0)                                   := (others => '0');

-- For debug
--   signal debug_sin_x          : real;
--   signal debug_cos_x          : real;
--   signal debug_accum_frac     : real;
--   signal debug_dx_pi_s2       : real;
--   signal debug_PI_fixed_point : real;
--   signal debug_half_pi_neg    : real;
--   signal debug_a_s1_sin_u     : real;
--   signal debug_dx_pi_s3       : real;
--   signal debug_sin_s1i        : real;
--   signal debug_sin_s1         : real;
--   signal debug_pre_final_sin  : real;
--   signal debug_pre_final_cos  : real;
--   signal debug_a_mult_bram_u   : real;
--   signal debug_dx_pi_squared18 : real;
--   signal debug_a_s2_cos_u      : real;
--   signal debug_cos_s2i         : real;
--   signal debug_cos_s2          : real;
--   signal a                     : signed(27 downto 0);
--   signal a_trunc               : signed(17 downto 0);
--   signal asq                   : signed(35 downto 0);
--   signal debug_a               : real;
--   signal debug_a_trunc         : real;
--   signal debug_asq             : real;
--   signal a_mult_bram_u_2       : std_logic_vector(9 downto 0)                   := (others => '0');
--   signal dx_pi_squared18_2     : std_logic_vector(17 downto 0)                  := (others => '0');

begin

  accum_fraction_s0(ci_internal_width-1) <= '0';  -- make sure that this is a positive number

  AC_FRAC_EXTEND : if(ci_phase_error_width < ci_internal_width-1) generate
  begin
    accum_fraction_s0(ci_internal_width-2 downto ci_internal_width-ci_phase_error_width-1) <= acc_phase_to_lut(ci_phase_error_width-1 downto 0);
    accum_fraction_s0(ci_internal_width-ci_phase_error_width-2 downto 0)                   <= (others => '0');
  end generate AC_FRAC_EXTEND;

  AC_FRAC_TRUNCATE : if(ci_phase_error_width >= ci_internal_width-1) generate
  begin
    accum_fraction_s0(ci_internal_width-2 downto 0) <= acc_phase_to_lut(ci_internal_width-2 downto 0);
  end generate AC_FRAC_TRUNCATE;

  sin_s0(ci_internal_width-1 downto ci_internal_width-ci_ram_data_width) <= sin_x;
  sin_s0(ci_internal_width-ci_ram_data_width-1)                          <= '1';
  sin_s0(ci_internal_width-ci_ram_data_width-2 downto 0)                 <= (others => '0');

  cos_s0(ci_internal_width-1 downto ci_internal_width-ci_ram_data_width) <= cos_x;
  cos_s0(ci_internal_width-ci_ram_data_width-1)                          <= '1';
  cos_s0(ci_internal_width-ci_ram_data_width-2 downto 0)                 <= (others => '0');

  accum_frac <= accum_fraction_s0(ci_internal_width-1 downto ci_internal_width-ci_mult_width);

  -- First term of Taylor series
  a_mult_pi_u <= std_logic_vector(resize(signed(accum_frac),fn_dsp48_a_width(C_XDEVICEFAMILY)));

  MULT_PI_U : dds_compiler_v4_0_multadd_wrapper
    generic map (
      --BaseIP common generics
      C_XDEVICEFAMILY => C_XDEVICEFAMILY,
      C_LATENCY       => 16+2*pipe_regs(ci_eff_stage0)+4*pipe_regs(ci_eff_stage1)+8*pipe_regs(ci_eff_stage2),
      C_MODEL_TYPE    =>  2
      )
    port map (
      clk      => clk,
      ce       => ce_i,
      A        => a_mult_pi_u,    -- 1.17 * 2^-11    (scope for increase?)
      B        => PI_fixed_point, -- 3.15     (pi)
      C        => half_pi_neg,    -- 3.32
      P        => dx_pi_s2        -- 4.32 * 2^-11
      );

-- synthesis translate_off
--  Enable these to see what is going on
--  debug_accum_frac     <= slv_to_real(accum_frac, ci_mult_width-1)/2.0**11;     -- 1.17 * 2^-11
--  debug_PI_fixed_point <= slv_to_real(PI_fixed_point, ci_mult_width-3);         -- 3.15 * 2^-0
--  debug_half_pi_neg    <= slv_to_real(half_pi_neg, ci_mult_width*2-4)/2.0**11;  -- 4.32 * 2^-11
--  debug_dx_pi_s2       <= slv_to_real(dx_pi_s2, ci_mult_width*2-4)/2.0**11;     -- 4.32 * 2^-11
-- synthesis translate_on

-- synthesis translate_off
--  Enable these to see what is going on
    --debug_sin_x <= slv_to_real(sin_x, sin_x'length-1);
    --debug_cos_x <= slv_to_real(cos_x, sin_x'length-1);
-- synthesis translate_on

  STG3_SIN_DELAY : xbip_pipe_v2_0_xst
     generic map(
       C_LATENCY => pipe_regs(ci_eff_stage3),
       C_HAS_CE  => C_HAS_CE,
       C_WIDTH   => ci_internal_width
       )
     port map(
       CLK => CLK,
       CE  => ce_i,
       D   => sin_s0,
       Q   => sin_s3
       );

  STG3_COS_DELAY : xbip_pipe_v2_0_xst
     generic map(
       C_LATENCY => pipe_regs(ci_eff_stage3),
       C_HAS_CE  => C_HAS_CE,
       C_WIDTH   => ci_internal_width
       )
     port map(
       CLK => CLK,
       CE  => ce_i,
       D   => cos_s0,
       Q   => cos_s3
       );

  -- Shift down by s1_shift
  sin_s1i(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-2*ci_mult_width) <= sin_s3(ci_internal_width-1 downto ci_internal_width-2*ci_mult_width);
  cos_s1i(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-2*ci_mult_width) <= cos_s3(ci_internal_width-1 downto ci_internal_width-2*ci_mult_width);
  sin_s1i(ci_internal_width-1 downto ci_internal_width-s1_shift) <= (others => sin_s3(ci_internal_width-1));  -- sign extension
  cos_s1i(ci_internal_width-1 downto ci_internal_width-s1_shift) <= (others => cos_s3(ci_internal_width-1));  -- sign extension

  -- Simple rounding to reduce truncation error of sin_s1 (put a 1 in the bit before lsb)
  sin_s1i(ci_internal_width-s1_shift-2*ci_mult_width-1) <= '1';
  cos_s1i(ci_internal_width-s1_shift-2*ci_mult_width-1) <= '1';

  I_NORM_SIGNS : if C_NEGATIVE_COSINE = C_NEGATIVE_SINE generate
    sub_sin <= '0';
    sub_cos <= '1';
  end generate I_NORM_SIGNS;

  I_DIFF_SIGNS : if C_NEGATIVE_COSINE /= C_NEGATIVE_SINE generate
    sub_sin <= '1';
    sub_cos <= '0';
  end generate I_DIFF_SIGNS;

  -- We can absorb this delay into the multiplier (when TAYLOR_ORDER = 2)
  STG3_DX_PI : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY => C_SC_LUT_LAT-pipe_regs(ci_eff_stage0)-pipe_regs(ci_eff_stage1)-pipe_regs(ci_eff_stage2),
      C_HAS_CE  => C_HAS_CE,
      C_WIDTH   => ci_mult_width
      )
    port map(
      CLK => CLK,
      CE  => ce_i,
      D   => dx_pi_s2(ci_mult_width*2-1 downto ci_mult_width),
      Q   => dx_pi_s3
      );

  a_s1_sin_u <= std_logic_vector(resize(signed(cos_s0(ci_internal_width-1 downto ci_internal_width-ci_mult_width)),fn_dsp48_a_width(C_XDEVICEFAMILY)));

  S1_SIN_U : dds_compiler_v4_0_multadd_wrapper
    generic map (
      --BaseIP common generics
      C_XDEVICEFAMILY => C_XDEVICEFAMILY,
      C_LATENCY       => 16+2*pipe_regs(ci_eff_stage3)+4*pipe_regs(ci_eff_stage4)+8*pipe_regs(ci_eff_stage5),
      C_MODEL_TYPE    =>  2
      )
    port map (
      clk      => clk,
      ce       => ce_i,
      subtract => sub_sin,
      A        => a_s1_sin_u,
      B        => dx_pi_s3,
      C        => sin_s1i,
      P        => sin_s1
      );

-- synthesis translate_off
--  Enable these to see what is going on
--  debug_a_s1_sin_u     <= slv_to_real(a_s1_sin_u, ci_mult_width-1);      -- 1.17
--  debug_dx_pi_s3       <= slv_to_real(dx_pi_s3, ci_mult_width+6);        -- 4.24  4.32-18+11-1 (-1 to get 2*pi)
--  debug_sin_s1i        <= slv_to_real(sin_s1i, ci_mult_width*2+5);       -- 5.41  (35+11-5=41)
--  debug_sin_s1         <= slv_to_real(sin_s1, ci_mult_width*2+5 );       -- 4.41
-- synthesis translate_on

  a_s1_cos_u <= std_logic_vector(resize(signed(sin_s0(ci_internal_width-1 downto ci_internal_width-ci_mult_width)),fn_dsp48_a_width(C_XDEVICEFAMILY)));
  S1_COS_U : dds_compiler_v4_0_multadd_wrapper
    generic map (
      --BaseIP common generics
      C_XDEVICEFAMILY => C_XDEVICEFAMILY,
      C_LATENCY       => 16+2*pipe_regs(ci_eff_stage3)+4*pipe_regs(ci_eff_stage4)+8*pipe_regs(ci_eff_stage5),
      C_MODEL_TYPE    =>  2
      )
    port map (
      clk      => clk,
      ce       => ce_i,
      subtract => sub_cos,
      A        => a_s1_cos_u,
      B        => dx_pi_s3,
      C        => cos_s1i,
      P        => cos_s1
      );

-- synthesis translate_off
--  debug_a_s1_cos_u     <= slv_to_real(a_s1_cos_u, ci_mult_width-1);      -- 1.17
--  debug_dx_pi_s3       <= slv_to_real(dx_pi_s3, ci_mult_width+6);        -- 4.24  4.32-18+11-1 (-1 to get 2*pi)
--  debug_cos_s1i        <= slv_to_real(cos_s1i, ci_mult_width*2+5);       -- 5.41  (35+11-5=41)
--  debug_cos_s1         <= slv_to_real(cos_s1, ci_mult_width*2+5 );       -- 4.41
-- synthesis translate_on

  --Note: C_TAYLOR_ORDER is set by a function which never returns zero, 
  --      so this is currently redundant

--  zero_order_approximation: if (C_TAYLOR_ORDER = 0) generate
--  begin
--    prel_final_sin_delay : xbip_pipe_v2_0_xst
--      generic map(
--        C_LATENCY => CI_PIPE(ci_eff_stage),
--        C_HAS_CE  => C_HAS_CE,
--        C_WIDTH   => C_OUTPUT_WIDTH
--        )
--      port map(
--        CLK => CLK,
--        CE  => ce_i,
--        D   => sin_s0(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH),
--        Q   => pre_final_sin
--        );
--
--    prel_final_cos_delay : xbip_pipe_v2_0_xst
--      generic map(
--        C_LATENCY => CI_PIPE(ci_eff_stage),
--        C_HAS_CE  => C_HAS_CE,
--        C_WIDTH   => C_OUTPUT_WIDTH
--        )
--      port map(
--        CLK => CLK,
--        CE  => ce_i,
--        D   => cos_s0(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH),
--        Q   => pre_final_cos
--        );
--
----    pre_final_sin <= sin_s0(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH);
----    pre_final_cos <= cos_s0(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH);
--  end generate zero_order_approximation;

  FIRST_ORDER_APPROXIMATION: if (C_TAYLOR_ORDER = 1) generate
  begin
    PREL_FINAL_SIN_DELAY : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY => pipe_regs(ci_eff_stage6)+pipe_regs(ci_eff_stage7),
        C_HAS_CE  => C_HAS_CE,
        C_WIDTH   => C_OUTPUT_WIDTH
        )
      port map(
        CLK => CLK,
        CE  => ce_i,
        D   => sin_s1(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-C_OUTPUT_WIDTH),
        Q   => pre_final_sin
        );
    -- sin_s1 : 4.41 -> 42-1 downto (42-C_OUTPUT_WIDTH) -> 1.(C_OUTPUT_W-1)

    PREL_FINAL_COS_DELAY : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY => pipe_regs(ci_eff_stage6)+pipe_regs(ci_eff_stage7),
        C_HAS_CE  => C_HAS_CE,
        C_WIDTH   => C_OUTPUT_WIDTH
        )
      port map(
        CLK => CLK,
        CE  => ce_i,
        D   => cos_s1(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-C_OUTPUT_WIDTH),
        Q   => pre_final_cos
        );
    -- synthesis translate_off
    --  Enable these to see what is going on 
    --debug_pre_final_sin     <= slv_to_real(sin_s1(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-C_OUTPUT_WIDTH), C_OUTPUT_WIDTH-1);
    --debug_pre_final_cos     <= slv_to_real(cos_s1(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-C_OUTPUT_WIDTH), C_OUTPUT_WIDTH-1);
    -- synthesis translate_on  
  end generate FIRST_ORDER_APPROXIMATION;

  -- Second term of Taylor series
  SECOND_ORDER_APPROXIMATION: if (C_TAYLOR_ORDER = 2) generate
  begin

    use_bram_mult : if not ci_use_mult_not_bram generate
    begin
      -- Need to use phase error directly, so delay to align with stage 2
      STG3_PHASE_DELAY : xbip_pipe_v2_0_xst
         generic map(
           C_LATENCY => C_SC_LUT_LAT,
           C_HAS_CE  => C_HAS_CE,
           C_WIDTH   => ci_mult_width
           )
         port map(
           CLK => CLK,
           CE  => ce_i,
           D   => accum_frac,
           Q   => accum_frac_s2
         );

       a_mult_bram_u <=  accum_frac_s2(ci_mult_width-2 downto ci_mult_width-11);

       -- Performs 2*((a-0.5)*pi)^2
       mult_pi2_u : dds_compiler_v4_0_eff_lut
         generic map (
           C_XDEVICEFAMILY => C_XDEVICEFAMILY,
           C_LATENCY       => pipe_regs(ci_eff_stage3)+pipe_regs(ci_eff_stage4),
           C_MODEL_TYPE    => C_MODEL_TYPE
           )
         port map (
           clk  => clk,
           ce   => ce_i,
           A    => a_mult_bram_u,         -- 0.11 (11-bits, no sign)
           D    => dx_pi_squared18        -- 10.8 (8 fractional)
           );

        -- This is an alternative implementation (useful for debug)
        -- a_mult_bram_u_2 <=  not(accum_frac_s2(ci_mult_width-2)) & accum_frac_s2(ci_mult_width-3 downto ci_mult_width-11);
        -- a       <= signed(PI_fixed_point)*signed(a_mult_bram_u_2);        -- 3.15 * 0.10 = 3.25   2^-11
        -- a_trunc <= a(27 downto 10);                                       -- 3.25 -> 3.15  2^-11
        -- asq     <= a_trunc*a_trunc;                                       -- 6.30 2^-22
        -- dx_pi_squared18_2 <= "000" & std_logic_vector(asq(35 downto 21)); -- 6.9 -> 10.8 with (2*pi*a)/2

-- synthesis translate_off
--  Enable these to see what is going on
--      debug_a               <= slv_to_real(std_logic_vector(a), 25+11);
--      debug_a_trunc         <= slv_to_real(std_logic_vector(a_trunc), 15+11);
--      debug_asq             <= slv_to_real(std_logic_vector(asq), 30+22);
--      debug_a_mult_bram_u   <= slv_to_real(a_mult_bram_u, 11+11);
--      debug_dx_pi_squared18 <= slv_to_real(dx_pi_squared18, 8+22);
-- synthesis translate_on

    end generate USE_BRAM_MULT;

    USE_DSP48_MULT : if ci_use_mult_not_bram generate
    begin
      a_mult_pi2_u <= std_logic_vector(resize(signed(dx_pi_s3), fn_dsp48_a_width(C_XDEVICEFAMILY)));
      a_mult_pi2_u_partial(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto fn_dsp48_a_width(C_XDEVICEFAMILY)-10) <= a_mult_pi2_u(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto fn_dsp48_a_width(C_XDEVICEFAMILY)-10);

      MULT_PI2_U : dds_compiler_v4_0_multadd_wrapper
        generic map (
          --BaseIP common generics
          C_XDEVICEFAMILY => C_XDEVICEFAMILY,
          C_LATENCY       => pipe_regs(ci_eff_stage3)+pipe_regs(ci_eff_stage4),
          C_MODEL_TYPE    =>  2
          )
        port map (
          clk      => clk,
          ce       => ce_i,
          A        => a_mult_pi2_u_partial,
          B        => dx_pi_s3,
          P        => dx_pi_squared
          );
      dx_pi_squared18 <= dx_pi_squared(ci_mult_width*2+1 downto ci_mult_width+2);

    end generate USE_DSP48_MULT;

    sin_s2i(ci_internal_width-1 downto ci_internal_width-2*ci_mult_width) <= sin_s1(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-2*ci_mult_width);
    cos_s2i(ci_internal_width-1 downto ci_internal_width-2*ci_mult_width) <= cos_s1(ci_internal_width-s1_shift-1 downto ci_internal_width-s1_shift-2*ci_mult_width);
    
    -- Simple rounding to reduce truncation error of sin_s1 (put a 1 in the bit before lsb)
    sin_s2i(ci_internal_width-2*ci_mult_width-1) <= '1';
    cos_s2i(ci_internal_width-2*ci_mult_width-1) <= '1';

    STG4_SIN_DELAY : xbip_pipe_v2_0_xst
       generic map(
         C_LATENCY => pipe_regs(ci_eff_stage4),
         C_HAS_CE  => C_HAS_CE,
         C_WIDTH   => ci_internal_width
         )
       port map(
         CLK => CLK,
         CE  => ce_i,
         D   => sin_s3,
         Q   => sin_s4
         );

    STG4_COS_DELAY : xbip_pipe_v2_0_xst
       generic map(
         C_LATENCY => pipe_regs(ci_eff_stage4),
         C_HAS_CE  => C_HAS_CE,
         C_WIDTH   => ci_internal_width
         )
       port map(
         CLK => CLK,
         CE  => ce_i,
         D   => cos_s3,
         Q   => cos_s4
         );

    a_s2_sin_u <= std_logic_vector(resize(signed(sin_s4(ci_internal_width-1 downto ci_internal_width-ci_mult_width)), fn_dsp48_a_width(C_XDEVICEFAMILY)));
    S2_SIN_U : dds_compiler_v4_0_multadd_wrapper
      generic map (
        --BaseIP common generics
        C_XDEVICEFAMILY => C_XDEVICEFAMILY,
        C_LATENCY       => 16+2*pipe_regs(ci_eff_stage5)+4*pipe_regs(ci_eff_stage6)+8*pipe_regs(ci_eff_stage7),
        C_MODEL_TYPE    =>  2
        )
      port map (
        clk      => clk,
        ce       => ce_i,
        subtract => '1',
        A        => a_s2_sin_u,
        B        => dx_pi_squared18,
        C        => sin_s2i,
        P        => sin_s2
        );

    a_s2_cos_u <= std_logic_vector(resize(signed(cos_s4(ci_internal_width-1 downto ci_internal_width-ci_mult_width)), fn_dsp48_a_width(C_XDEVICEFAMILY)));
    S2_COS_U : dds_compiler_v4_0_multadd_wrapper
      generic map (
        --BaseIP common generics
        C_XDEVICEFAMILY => C_XDEVICEFAMILY,
        C_LATENCY       => 16+2*pipe_regs(ci_eff_stage5)+4*pipe_regs(ci_eff_stage6)+8*pipe_regs(ci_eff_stage7),
        C_MODEL_TYPE    =>  2
        )
      port map (
        clk      => clk,
        ce       => ce_i,
        subtract => '1',
        A        => a_s2_cos_u,             -- 1.17
        B        => dx_pi_squared18,        -- 4.8 * 2^-22
        C        => cos_s2i,                -- 1.47
        P        => cos_s2                  -- 1.47
        );

    pre_final_sin <= sin_s2(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH);
    pre_final_cos <= cos_s2(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH);

-- synthesis translate_off
--  Enable these to see what is going on
--    debug_a_s2_cos_u      <= slv_to_real(a_s2_cos_u, ci_mult_width-1);
--    debug_dx_pi_squared18 <= slv_to_real(dx_pi_squared18, ci_mult_width+6);
--    debug_cos_s2i         <= slv_to_real(cos_s2i, 47);
--    debug_cos_s2          <= slv_to_real(cos_s2, 47 );
--    debug_pre_final_sin     <= slv_to_real(sin_s2(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH), C_OUTPUT_WIDTH-1);
--    debug_pre_final_cos     <= slv_to_real(cos_s2(ci_internal_width-1 downto ci_internal_width-C_OUTPUT_WIDTH), C_OUTPUT_WIDTH-1);
-- synthesis translate_on

  end generate SECOND_ORDER_APPROXIMATION;

end synth;
