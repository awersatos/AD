-- $RCSfile: mult_gen_v11_0.vhd,v $ $Revision: 1.3 $ $Date: 2009/09/08 15:51:09 $
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.mult_gen_pkg_v11_0.all;

entity mult_gen_v11_0 is
  generic (
    C_VERBOSITY         : integer := 0;
    C_MODEL_TYPE        : integer := 0;
    C_XDEVICEFAMILY     : string  := "virtex4";
    C_A_WIDTH           : integer := 18;
    C_A_TYPE            : integer := 0;
    C_B_WIDTH           : integer := 18;
    C_B_TYPE            : integer := 0;
    C_OUT_HIGH          : integer := 35;
    C_OUT_LOW           : integer := 0;
    C_MULT_TYPE         : integer := 1;
    C_OPTIMIZE_GOAL     : integer := 1;
    C_HAS_CE            : integer := 0;
    C_HAS_SCLR          : integer := 0;
    C_CE_OVERRIDES_SCLR : integer := 1;
    C_LATENCY           : integer := -1;
    C_CCM_IMP           : integer := 0;
    C_B_VALUE           : string  := "111111111111111111";
    C_HAS_ZERO_DETECT   : integer := 0;
    C_ROUND_OUTPUT      : integer := 0;
    C_ROUND_PT          : integer := 0);
  port (
    CLK         : in  std_logic                                       := '1';
    A           : in  std_logic_vector(C_A_WIDTH-1 downto 0)          := (others => '0');
    B           : in  std_logic_vector(C_B_WIDTH-1 downto 0)          := (others => '0');
    CE          : in  std_logic                                       := '1';
    SCLR        : in  std_logic                                       := '0';
    ZERO_DETECT : out std_logic_vector(1 downto 0)                    := (others => '0');
    P           : out std_logic_vector(C_OUT_HIGH-C_OUT_LOW downto 0) := (others => '0');
    PCASC       : out std_logic_vector(47 downto 0)                   := (others => '0'));
end mult_gen_v11_0;


architecture behavioral of mult_gen_v11_0 is

  constant validated_generics : T_RESOLVED_GENERICS := check_generics(
    C_XDEVICEFAMILY,
    C_A_WIDTH,
    C_A_TYPE,
    C_B_WIDTH,
    C_B_TYPE,
    C_OUT_HIGH,
    C_OUT_LOW,
    C_MULT_TYPE,
    C_OPTIMIZE_GOAL,
    C_HAS_CE,
    C_HAS_SCLR,
    C_CE_OVERRIDES_SCLR,
    C_LATENCY,
    C_CCM_IMP,
    C_B_VALUE,
    C_HAS_ZERO_DETECT,
    C_ROUND_OUTPUT,
    C_ROUND_PT);

  -- Resolved generics, after they have passed through check_generics
  constant R_A_WIDTH           : integer                := validated_generics.R_A_WIDTH;
  constant R_A_TYPE            : integer                := validated_generics.R_A_TYPE;
  constant R_B_WIDTH           : integer                := validated_generics.R_B_WIDTH;
  constant R_B_TYPE            : integer                := validated_generics.R_B_TYPE;
  constant R_OUT_HIGH          : integer                := validated_generics.R_OUT_HIGH;
  constant R_OUT_LOW           : integer                := validated_generics.R_OUT_LOW;
  constant R_MULT_TYPE         : integer                := validated_generics.R_MULT_TYPE;
  constant R_OPT_GOAL          : integer                := validated_generics.R_OPT_GOAL;
  constant R_HAS_CE            : integer                := validated_generics.R_HAS_CE;
  constant R_HAS_SCLR          : integer                := validated_generics.R_HAS_SCLR;
  constant R_CE_OVERRIDES_SCLR : integer                := validated_generics.R_CE_OVERRIDES_SCLR;
  constant R_LATENCY           : integer                := validated_generics.R_LATENCY;
  constant R_CCM_IMP           : integer                := validated_generics.R_CCM_IMP;
  constant R_B_VALUE           : string(1 to R_B_WIDTH) := validated_generics.R_B_VALUE(1 to R_B_WIDTH);
  constant R_HAS_ZERO_DETECT   : integer                := validated_generics.R_HAS_ZERO_DETECT;
  constant R_ROUND_OUTPUT      : integer                := validated_generics.R_ROUND_OUTPUT;
  constant R_ROUND_PT          : integer                := validated_generics.R_ROUND_PT;

  type T_PIPE is array (0 to MAX_PIPE_STAGES-1) of integer range 0 to 1;

  function get_pipeline_depth(pipe_delay : integer) return integer is
    variable accum      : integer := 0;
    variable int_value  : integer := 0;
    variable pipe_array : T_PIPE  := (others => 0);
  begin
    if pipe_delay >= PIPELINE_CFG_BREAKPT then
      -- custom pipeline CONFIGURATION
      -- subract the breakpoint value
      int_value := pipe_delay-PIPELINE_CFG_BREAKPT;
      -- convert the resulting integer value to a binary representation
      for x in 0 to MAX_PIPE_STAGES-1 loop  -- max_reg
        pipe_array(x) := sl_to_int(int_to_slv(int_value, MAX_PIPE_STAGES)(x));
      end loop;  -- x
      -- accumulate all the bits in the resulting 'binary' integer array to get pipeline latency
      for i in 0 to binary_width_of_integer(int_value)-1 loop
        accum := accum + pipe_array(i);
      end loop;  -- i
--      ASSERT false REPORT "returned a custom pipeline delay of " & INTEGER'image(accum) SEVERITY note;
      return accum;
    else
      -- use c_latency directly
--      ASSERT false REPORT "returned a simple delay of " & INTEGER'image(pipe_delay) SEVERITY note;
      return pipe_delay;
    end if;
  end function get_pipeline_depth;

  constant max_a_width : integer := 64;
  constant max_b_width : integer := 64;

  signal ai : std_logic_vector(R_A_WIDTH downto 0) := (others => '0');
  signal bi : std_logic_vector(R_B_WIDTH downto 0) := (others => '0');

  signal ce_i   : std_logic := '1';
  signal sclr_i : std_logic := '0';

  signal pm       : std_logic_vector(127 downto 0) := (others => '0');
  signal pm_round : std_logic_vector(pm'range)     := (others => '0');

  signal pi : std_logic_vector(pm'range) := (others => '0');

  signal zero_detect_i : std_logic_vector(1 downto 0) := (others => '0');

  constant pipeline_latency : integer := get_pipeline_depth(R_LATENCY);

  -- purpose: configures the rounding constant when symmetric rounding is to be implemented
  function get_rounding_const(round_output, round_pt : integer) return std_logic_vector is
    variable ret : std_logic_vector(47 downto 0) := (others => '0');
  begin  -- FUNCTION get
    if round_pt /= 0 then
      -- no point in trying to round if we have the full output width!
      for i in ret'low to ret'high loop
        if i = round_pt-1 then
          exit;
        end if;
        ret(i) := '1';
      end loop;  -- i
    end if;
    return ret;
  end function get_rounding_const;

  constant round_const : std_logic_vector(47 downto 0) := get_rounding_const(R_ROUND_OUTPUT, R_ROUND_PT);

  -- pipelined versions of the multiplier's input MSBs to allow correct rounding 
  signal ai_round : std_logic := '0';
  signal bi_round : std_logic := '0';

  -- purpose: checks if the supplied constant is exactly a power of two, assuming that the constant is unsigned
  function check_const_power_two (const : string; const_type : integer) return boolean is
    variable leading_zeros  : integer := 0;
    variable trailing_zeros : integer := 0;
    constant const_len      : integer := const'length;
    variable sum            : integer := 0;
  begin  -- FUNCTION check_const_power_two
    if const_type = C_UNSIGNED then

      -- count leading zeros
      -- account for TO and DOWNTO strings
      if const'ascending then
        for i in const'left to const'right loop
          if const(i) = '0' then
            leading_zeros := leading_zeros + 1;
          end if;
          if const(i) = '1' then
            exit;
          end if;
        end loop;  -- i
      else                              -- const'descending
        for i in const'left downto const'right loop
          if const(i) = '0' then
            leading_zeros := leading_zeros + 1;
          end if;
          if const(i) = '1' then
            exit;
          end if;
        end loop;  -- i
      end if;

      -- count trailing zeros
      -- account for TO and DOWNTO strings
      if const'ascending then
        for i in const'right downto const'left loop
          if const(i) = '0' then
            trailing_zeros := trailing_zeros + 1;
          end if;
          if const(i) = '1' then
            exit;
          end if;
        end loop;  -- i
      else                              -- const'descending
        for i in const'right to const'left loop
          if const(i) = '0' then
            trailing_zeros := trailing_zeros + 1;
          end if;
          if const(i) = '1' then
            exit;
          end if;
        end loop;  -- i
      end if;

      -- add the trailing and leading zero counts - if const_len - (sum) == 1
      -- then the constant is exactly a power of two

      sum := leading_zeros + trailing_zeros;

      if (const_len - sum) = 1 then
        return true;
      else
        return false;
      end if;
      
    else                                -- signed data
      return false;
    end if;
  end function check_const_power_two;
  
begin

  parallel_multiplier : if R_MULT_TYPE = LUT or R_MULT_TYPE = EMBEDDED_MULT or R_MULT_TYPE = FIXED_CCM generate
    -- we need a separate SCLR signal for the BRAM implementations of the CCM
    -- since the address registers on the BRAMs don't have an SCLR - only the
    -- output and fabric speed-up registers do
    signal bram_addr_sclr : std_logic := '0';
  begin

    -- some extra generates to aid ModelSim debugging
    is_fixed_ccm     : if R_MULT_TYPE = FIXED_CCM generate
    -- do nothing
    end generate is_fixed_ccm;
    is_parallel_mult : if R_MULT_TYPE = LUT or R_MULT_TYPE = EMBEDDED_MULT generate
    -- do nothing
    end generate is_parallel_mult;

    -- adjust operands for signed/unsigned
    a_signed : if R_A_TYPE = C_SIGNED generate
      ai <= a(a'high) & a;
    end generate a_signed;
    a_unsigned : if R_A_TYPE = C_UNSIGNED generate
      ai <= "0" & a;
    end generate a_unsigned;

    b_signed : if R_B_TYPE = C_SIGNED generate
      bi <= b(b'high) & b;
    end generate b_signed;
    b_unsigned : if R_B_TYPE = C_UNSIGNED generate
      bi <= "0" & b;
    end generate b_unsigned;

    -- sort out CE and SCLR
    has_ce : if R_HAS_CE /= 0 generate
      ce_i <= ce;
    end generate has_ce;
    no_ce : if R_HAS_CE = 0 generate
      ce_i <= '1';
    end generate no_ce;

    has_sclr : if R_HAS_SCLR /= 0 generate
      ce_overrides_sclr : if R_CE_OVERRIDES_SCLR /= 0 generate
        sclr_i <= sclr and ce_i;
      end generate ce_overrides_sclr;
      sclr_overrides_ce : if R_CE_OVERRIDES_SCLR = 0 generate
        sclr_i <= sclr;
      end generate sclr_overrides_ce;
    end generate has_sclr;
    no_sclr : if R_HAS_SCLR = 0 generate
      sclr_i <= '0';
    end generate no_sclr;

    parm : if R_MULT_TYPE = LUT or R_MULT_TYPE = EMBEDDED_MULT generate
      -- do the multiply and expand the product to the full allowed width
      signed_multiply : if R_A_TYPE = C_SIGNED or R_B_TYPE = C_SIGNED generate
        pm <= std_logic_vector(RESIZE(signed(ieee.std_logic_signed."*"(ai, bi)), MAX_PRODUCT_WIDTH));
      end generate signed_multiply;
      unsigned_multiply : if not(R_A_TYPE = C_SIGNED or R_B_TYPE = C_SIGNED) generate
        pm <= std_logic_vector(RESIZE(unsigned(ieee.std_logic_unsigned."*"(ai, bi)), MAX_PRODUCT_WIDTH));
      end generate unsigned_multiply;
    end generate parm;

    ccm : if R_MULT_TYPE = FIXED_CCM generate
      signal b_value_ext : std_logic_vector(R_B_VALUE'length downto 0) := (others => '0');
    begin

      -- manually sign- (or zero-) extend the B constant value
      us_b_value_ext : if R_B_TYPE = C_UNSIGNED generate
        b_value_ext <= std_logic_vector(resize(unsigned(str_to_slv(R_B_VALUE)), b_value_ext'length));
      end generate us_b_value_ext;
      s_b_value_ext : if R_B_TYPE = C_SIGNED generate
        b_value_ext <= std_logic_vector(resize(signed(str_to_slv(R_B_VALUE)), b_value_ext'length));
      end generate s_b_value_ext;

      -- do the multiply and expand the product to the full allowed width
      signed_multiply : if R_A_TYPE = C_SIGNED or R_B_TYPE = C_SIGNED generate
        pm <= std_logic_vector(RESIZE(signed(ieee.std_logic_signed."*"(ai, b_value_ext)), MAX_PRODUCT_WIDTH));
      end generate signed_multiply;
      unsigned_multiply : if not(R_A_TYPE = C_SIGNED or R_B_TYPE = C_SIGNED) generate
        pm <= std_logic_vector(RESIZE(unsigned(ieee.std_logic_unsigned."*"(ai, b_value_ext)), MAX_PRODUCT_WIDTH));
      end generate unsigned_multiply;
      
    end generate ccm;

    -- implement any required symmetric rounding on the output
    do_round : if R_ROUND_OUTPUT /= 0 and R_ROUND_PT > 0 generate
      pm_round <= not(ai(ai'high) xor bi(bi'high)) + round_const + pm;
    end generate do_round;
    no_round : if R_ROUND_OUTPUT = 0 or R_ROUND_PT = 0 generate
      pm_round <= pm;
    end generate no_round;

    -- configure the SCLR for the BRAM CCM, if applicable
    -- Need an additional check for if the constant is exactly +one because we
    -- only need a delay line to model that and it doesn't need a separate SCLR
    is_bram_ccm : if R_MULT_TYPE = FIXED_CCM and R_CCM_IMP = BRAM and not(check_const_power_two(R_B_VALUE, R_B_TYPE)) generate
      bram_addr_sclr <= '0';
    end generate is_bram_ccm;
    not_bram_ccm : if not(R_MULT_TYPE = FIXED_CCM and R_CCM_IMP = BRAM and not(check_const_power_two(R_B_VALUE, R_B_TYPE))) generate
      bram_addr_sclr <= sclr_i;
    end generate not_bram_ccm;

    -- implement the pipelining as a delay line
    pipe0 : if pipeline_latency = 0 generate
      pi <= pm_round;
    end generate pipe0;
    pipe1 : if pipeline_latency = 1 generate
      process (clk) is
      begin
        if rising_edge(clk) then
          if bram_addr_sclr = '1' then
            pi <= (others => '0');
          else
            if ce_i = '1' then
              pi <= pm_round;
            end if;
          end if;
        end if;
      end process;
    end generate pipe1;
    pipe2 : if pipeline_latency = 2 generate
      signal ff : std_logic_vector(pi'range) := (others => '0');
    begin
      -- create single-cycle delay with separate SCLR
      process (clk) is
      begin
        if rising_edge(clk) then
          if bram_addr_sclr = '1' then
            ff <= (others => '0');
          else
            if ce_i = '1' then
              ff <= pm_round;
            end if;
          end if;
        end if;
      end process;
      -- create another single-cycle delay with global SCLR
      process (clk) is
      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            pi <= (others => '0');
          else
            if ce_i = '1' then
              pi <= ff;
            end if;
          end if;
        end if;
      end process;
    end generate pipe2;
    pipeX : if pipeline_latency > 2 generate
      type T_DELAY is array (0 to pipeline_latency-2) of std_logic_vector(pi'range);
      signal delay_line : T_DELAY                    := (others => (others => '0'));
      signal ff         : std_logic_vector(pi'range) := (others => '0');
    begin
      -- create single-cycle delay with separate SCLR
      process (clk) is
      begin
        if rising_edge(clk) then
          if bram_addr_sclr = '1' then
            ff <= (others => '0');
          else
            if ce_i = '1' then
              ff <= pm_round;
            end if;
          end if;
        end if;
      end process;
      -- create delay LINE
      process (clk) is
      begin
        if rising_edge(clk) then
          if sclr_i = '1' then
            delay_line <= (others => (others => '0'));
          else
            if ce_i = '1' then
              delay_line <= ff & delay_line(0 to pipeline_latency-3);
            end if;
          end if;
        end if;
      end process;
      pi <= delay_line(pipeline_latency-2);
    end generate pipeX;

    -- pick out the requested slice of the full-width product
--    p <= pi(R_OUT_HIGH downto R_OUT_LOW);

    -- Using the full MAX_PRODUCT_WIDTH product doesn't work for cases where
    -- symmetric rounding has been used and the product is extended above the MSB.
    -- We need to pull out the true full product (sum of input widths) and then
    -- (un)sign-extend that back up to the 128 bits, then pull out the bits
    -- that the user wants.  Phew!
    assign_outputs : if true generate
      -- the maximum output product width
      signal max_product : std_logic_vector(MAX_PRODUCT_WIDTH-1 downto 0) := (others => '0');
    begin

      -- extend the result to the full allowable output width
      usign : if R_A_TYPE /= C_SIGNED and R_B_TYPE /= C_SIGNED generate
        max_product <= std_logic_vector(RESIZE(unsigned(pi(R_A_WIDTH+R_B_WIDTH-1 downto 0)), MAX_PRODUCT_WIDTH));
      end generate usign;
      sign : if R_A_TYPE = C_SIGNED or R_B_TYPE = C_SIGNED generate
        max_product <= std_logic_vector(RESIZE(signed(pi(R_A_WIDTH+R_B_WIDTH-1 downto 0)), MAX_PRODUCT_WIDTH));
      end generate sign;

      -- if output requested is shorter than full output product, just pick out that slice
      P <= max_product(R_OUT_HIGH downto R_OUT_LOW);
      
    end generate assign_outputs;

    has_zero_detect : if R_HAS_ZERO_DETECT /= 0 and R_MULT_TYPE /= FIXED_CCM generate
      constant zeros : std_logic_vector(R_A_WIDTH-3 downto 0) := (others => '0');
    begin
      -- rather than performing bit-true modelling, we just duplicate the
      -- output for all parallel multipliers
      -- NOTE THAT THE *AND* OF THESE TWO SIGNALS IS CHECKED IN THE TESTBENCH
      -- AND THIS MODEL WILL NOT MATCH ALL MULTIPLIER VARIANTS EXACTLY
      -- THE ASSUMPTION IS THAT THE FPO CORE (WHICH IS THE ONLY USER OF THIS
      -- FEATURE) WILL ALWAYS *AND* THE TWO OUTPUTS IN SOME EXTERNAL LOGIC
      zero_detect(0) <= '1' when pi(R_A_WIDTH-3 downto 0) = zeros else '0';
      zero_detect(1) <= '1' when pi(R_A_WIDTH-3 downto 0) = zeros else '0';
    end generate has_zero_detect;
    
  end generate parallel_multiplier;
  
end architecture behavioral;
