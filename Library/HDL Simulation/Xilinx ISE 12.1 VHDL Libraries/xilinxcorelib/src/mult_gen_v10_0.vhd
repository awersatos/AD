-- $RCSfile: mult_gen_v10_0.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/09 15:23:36 $
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.numeric_std.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.pkg_mult_gen_v10_0.ALL;
USE XilinxCoreLib.prims_constants_v9_1.ALL;
USE XilinxCoreLib.prims_utils_v9_1.ALL;
USE XilinxCoreLib.pkg_baseblox_v9_1.ALL;

ENTITY mult_gen_v10_0 IS
  GENERIC (
    c_xdevicefamily     : STRING  := "virtex4";  -- specifies target Xilinx FPGA name
    c_a_width           : INTEGER := 18;  -- width of A port
    c_a_type            : INTEGER := C_SIGNED;   -- datatype of A port
    c_b_width           : INTEGER := 18;  -- width of B port
    c_b_type            : INTEGER := C_SIGNED;   -- datatype of B port
    c_out_high          : INTEGER := 35;  -- MSB of P output port (N-1 downto 0 convention)
    c_out_low           : INTEGER := 0;  -- LSB of P output port (N-1 downto 0 convention)
    c_mult_type         : INTEGER := 1;  -- Type of multiplier to implement
    c_opt_goal          : INTEGER := 1;  -- Optimization of multiplier
    c_has_ce            : INTEGER := 0;  -- Use clock enable on all registers
    c_has_sclr          : INTEGER := 0;  -- Use Synchronous clear on all registers
    c_ce_overrides_sclr : INTEGER := 1;  -- Priority of CE and SCLR
    c_pipe_stages       : INTEGER := 1;  -- Number of register stages required
    c_ccm_imp           : INTEGER := 0;  -- Implementation of CCM (if selected by c_mult_type)
    c_b_value           : STRING  := "111111111111111111";  -- Value for (initial) B port constant for CCM
    c_elaboration_dir   : STRING  := "./";     -- CoreGen-specific generic
    c_has_load_done     : INTEGER := 0;  -- Offer load_done flag pin on output (reloadable CCMs only)
    c_has_zero_detect   : INTEGER := 0;  -- Offer zero detection of W-2 LSB bits on WxW multiplier
    c_round_output      : INTEGER := 0;  -- Specifies if P output should be symmetrically rounded
    c_round_pt          : INTEGER := 0;  -- Specifies the bit of the full-width product below which rounding should occur
    c_mem_init_prefix   : STRING  := "mult";  -- MIF file prefix for multiple CCM instantiations
    c_use_p_cascade_out : INTEGER := 0);
  PORT (
    clk         : IN  STD_LOGIC                              := '1';
    a           : IN  STD_LOGIC_VECTOR(c_a_width-1 DOWNTO 0) := (OTHERS => '0');
    b           : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');
    loadb       : IN  STD_LOGIC                              := '0';
    swapb       : IN  STD_LOGIC                              := '0';
    ce          : IN  STD_LOGIC                              := '1';
    sclr        : IN  STD_LOGIC                              := '0';
    load_done   : OUT STD_LOGIC;
    zero_detect : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    p           : OUT STD_LOGIC_VECTOR(c_out_high-c_out_low DOWNTO 0)); 
END mult_gen_v10_0;


ARCHITECTURE behavioral OF mult_gen_v10_0 IS

  -- internally-formatted device family generics
  CONSTANT ci_xdevicefamily : STRING := lcase(c_xdevicefamily);

  CONSTANT ci_family   : STRING          := modify_family(ci_xdevicefamily);
  CONSTANT enum_family : T_DEVICE_FAMILY := fn_check_family(ci_family);
  
  CONSTANT validate_generics : BOOLEAN := check_generics(enum_family,
                                                         ci_family,
                                                         ci_xdevicefamily,
                                                         c_a_width,
                                                         c_a_type,
                                                         c_b_width,
                                                         c_b_type,
                                                         c_out_high,
                                                         c_out_low,
                                                         c_mult_type,
                                                         c_opt_goal,
                                                         c_has_ce,
                                                         c_has_sclr,
                                                         c_ce_overrides_sclr,
                                                         c_pipe_stages,
                                                         c_ccm_imp,
                                                         c_b_value,
                                                         c_elaboration_dir,
                                                         c_has_load_done,
                                                         c_has_zero_detect,
                                                         c_round_output,
                                                         c_round_pt,
                                                         c_mem_init_prefix,
                                                         c_use_p_cascade_out);

  TYPE T_PIPE IS ARRAY (0 TO MAX_PIPE_STAGES-1) OF INTEGER RANGE 0 TO 1;

  FUNCTION get_pipeline_depth(pipe_delay : INTEGER) RETURN INTEGER IS
    VARIABLE accum      : INTEGER := 0;
    VARIABLE int_value  : INTEGER := 0;
    VARIABLE pipe_array : T_PIPE  := (OTHERS => 0);
  BEGIN
    IF pipe_delay >= PIPELINE_CFG_BREAKPT THEN
      -- custom pipeline CONFIGURATION
      -- subract the breakpoint value
      int_value := pipe_delay-PIPELINE_CFG_BREAKPT;
      -- convert the resulting integer value to a binary representation
      FOR x IN 0 TO MAX_PIPE_STAGES-1 LOOP  -- max_reg
        pipe_array(x) := sl_to_int(int_to_slv(int_value, MAX_PIPE_STAGES)(x));
      END LOOP;  -- x
      -- accumulate all the bits in the resulting 'binary' integer array to get pipeline latency
      FOR i IN 0 TO binary_width_of_integer(int_value)-1 LOOP
        accum := accum + pipe_array(i);
      END LOOP;  -- i
      ASSERT false REPORT "returned a custom pipeline delay of " & INTEGER'image(accum) SEVERITY note;
      RETURN accum;
    ELSE
      -- use c_pipe_stages directly
      ASSERT false REPORT "returned a simple delay of " & INTEGER'image(pipe_delay) SEVERITY note;
      RETURN pipe_delay;
    END IF;
  END FUNCTION get_pipeline_depth;

  CONSTANT max_a_width : INTEGER := 64;
  CONSTANT max_b_width : INTEGER := 64;

  SIGNAL ai : STD_LOGIC_VECTOR(c_a_width DOWNTO 0) := (OTHERS => '0');
  SIGNAL bi : STD_LOGIC_VECTOR(c_b_width DOWNTO 0) := (OTHERS => '0');

  SIGNAL ce_i   : STD_LOGIC := '1';
  SIGNAL sclr_i : STD_LOGIC := '0';

  SIGNAL pm       : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');
  SIGNAL pm_round : STD_LOGIC_VECTOR(pm'range)     := (OTHERS => '0');

  SIGNAL pi : STD_LOGIC_VECTOR(pm'range) := (OTHERS => '0');

  SIGNAL zero_detect_i : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');

  CONSTANT pipeline_latency : INTEGER := get_pipeline_depth(c_pipe_stages);

  -- purpose: configures the rounding constant when symmetric rounding is to be implemented
  FUNCTION get_rounding_const(round_output, round_pt : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret : STD_LOGIC_VECTOR(47 DOWNTO 0) := (OTHERS => '0');
  BEGIN  -- FUNCTION get
    IF round_pt /= 0 THEN
      -- no point in trying to round if we have the full output width!
      FOR i IN ret'low TO ret'high LOOP
        IF i = round_pt-1 THEN
          EXIT;
        END IF;
        ret(i) := '1';
      END LOOP;  -- i
    END IF;
    RETURN ret;
  END FUNCTION get_rounding_const;

  CONSTANT round_const : STD_LOGIC_VECTOR(47 DOWNTO 0) := get_rounding_const(c_round_output, c_round_pt);

  -- pipelined versions of the multiplier's input MSBs to allow correct rounding 
  SIGNAL ai_round : STD_LOGIC := '0';
  SIGNAL bi_round : STD_LOGIC := '0';

  -- purpose: checks if the supplied constant is exactly a power of two, assuming that the constant is unsigned
  FUNCTION check_const_power_two (const : STRING; const_type : INTEGER) RETURN BOOLEAN IS
    VARIABLE leading_zeros  : INTEGER := 0;
    VARIABLE trailing_zeros : INTEGER := 0;
    CONSTANT const_len      : INTEGER := const'length;
    VARIABLE sum            : INTEGER := 0;
  BEGIN  -- FUNCTION check_const_power_two
    IF const_type = C_UNSIGNED THEN

      -- count leading zeros
      -- account for TO and DOWNTO strings
      IF const'ascending THEN
        FOR i IN const'left TO const'right LOOP
          IF const(i) = '0' THEN
            leading_zeros := leading_zeros + 1;
          END IF;
          IF const(i) = '1' THEN
            EXIT;
          END IF;
        END LOOP;  -- i
      ELSE                              -- const'descending
        FOR i IN const'left DOWNTO const'right LOOP
          IF const(i) = '0' THEN
            leading_zeros := leading_zeros + 1;
          END IF;
          IF const(i) = '1' THEN
            EXIT;
          END IF;
        END LOOP;  -- i
      END IF;

      -- count trailing zeros
      -- account for TO and DOWNTO strings
      IF const'ascending THEN
        FOR i IN const'right DOWNTO const'left LOOP
          IF const(i) = '0' THEN
            trailing_zeros := trailing_zeros + 1;
          END IF;
          IF const(i) = '1' THEN
            EXIT;
          END IF;
        END LOOP;  -- i
      ELSE                              -- const'descending
        FOR i IN const'right TO const'left LOOP
          IF const(i) = '0' THEN
            trailing_zeros := trailing_zeros + 1;
          END IF;
          IF const(i) = '1' THEN
            EXIT;
          END IF;
        END LOOP;  -- i
      END IF;

      -- add the trailing and leading zero counts - if const_len - (sum) == 1
      -- then the constant is exactly a power of two

      sum := leading_zeros + trailing_zeros;

      IF (const_len - sum) = 1 THEN
        RETURN true;
      ELSE
        RETURN false;
      END IF;
      
    ELSE                                -- signed data
      RETURN false;
    END IF;
  END FUNCTION check_const_power_two;
  
BEGIN

  parallel_multiplier : IF c_mult_type = LUT OR c_mult_type = EMBEDDED_MULT OR c_mult_type = FIXED_CCM GENERATE
    -- we need a separate SCLR signal for the BRAM implementations of the CCM
    -- since the address registers on the BRAMs don't have an SCLR - only the
    -- output and fabric speed-up registers do
    SIGNAL bram_addr_sclr : STD_LOGIC := '0';
  BEGIN

    -- some extra generates to aid ModelSim debugging
    is_fixed_ccm     : IF c_mult_type = FIXED_CCM GENERATE
      -- do nothing
    END GENERATE is_fixed_ccm;
    is_parallel_mult : IF c_mult_type = LUT OR c_mult_type = EMBEDDED_MULT GENERATE
      -- do nothing
    END GENERATE is_parallel_mult;

    -- adjust operands for signed/unsigned
    a_signed : IF c_a_type = C_SIGNED GENERATE
      ai <= a(a'high) & a;
    END GENERATE a_signed;
    a_unsigned : IF c_a_type = C_UNSIGNED GENERATE
      ai <= "0" & a;
    END GENERATE a_unsigned;

    b_signed : IF c_b_type = C_SIGNED GENERATE
      bi <= b(b'high) & b;
    END GENERATE b_signed;
    b_unsigned : IF c_b_type = C_UNSIGNED GENERATE
      bi <= "0" & b;
    END GENERATE b_unsigned;

    -- sort out CE and SCLR
    has_ce : IF c_has_ce /= 0 GENERATE
      ce_i <= ce;
    END GENERATE has_ce;
    no_ce : IF c_has_ce = 0 GENERATE
      ce_i <= '1';
    END GENERATE no_ce;

    has_sclr : IF c_has_sclr /= 0 GENERATE
      ce_overrides_sclr : IF c_ce_overrides_sclr /= 0 GENERATE
        sclr_i <= sclr AND ce_i;
      END GENERATE ce_overrides_sclr;
      sclr_overrides_ce : IF c_ce_overrides_sclr = 0 GENERATE
        sclr_i <= sclr;
      END GENERATE sclr_overrides_ce;
    END GENERATE has_sclr;
    no_sclr : IF c_has_sclr = 0 GENERATE
      sclr_i <= '0';
    END GENERATE no_sclr;

    parm : IF c_mult_type = LUT OR c_mult_type = EMBEDDED_MULT GENERATE
      -- do the multiply and expand the product to the full allowed width
      signed_multiply : IF c_a_type = C_SIGNED OR c_b_type = C_SIGNED GENERATE
        pm <= STD_LOGIC_VECTOR(RESIZE(SIGNED(ieee.std_logic_signed."*"(ai, bi)), 128));
      END GENERATE signed_multiply;
      unsigned_multiply : IF NOT(c_a_type = C_SIGNED OR c_b_type = C_SIGNED) GENERATE
        pm <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(ieee.std_logic_unsigned."*"(ai, bi)), 128));
      END GENERATE unsigned_multiply;
    END GENERATE parm;

    ccm : IF c_mult_type = FIXED_CCM GENERATE
      SIGNAL b_value_ext : STD_LOGIC_VECTOR(c_b_value'length DOWNTO 0) := (OTHERS => '0');
    BEGIN

      -- manually sign- (or zero-) extend the B constant value
      us_b_value_ext : IF c_b_type = C_UNSIGNED GENERATE
        b_value_ext <= STD_LOGIC_VECTOR(resize(UNSIGNED(str_to_slv(c_b_value)), b_value_ext'length));
      END GENERATE us_b_value_ext;
      s_b_value_ext : IF c_b_type = C_SIGNED GENERATE
        b_value_ext <= STD_LOGIC_VECTOR(resize(SIGNED(str_to_slv(c_b_value)), b_value_ext'length));
      END GENERATE s_b_value_ext;

      -- do the multiply and expand the product to the full allowed width
      signed_multiply : IF c_a_type = C_SIGNED OR c_b_type = C_SIGNED GENERATE
        pm <= STD_LOGIC_VECTOR(RESIZE(SIGNED(ieee.std_logic_signed."*"(ai, b_value_ext)), 128));
      END GENERATE signed_multiply;
      unsigned_multiply : IF NOT(c_a_type = C_SIGNED OR c_b_type = C_SIGNED) GENERATE
        pm <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(ieee.std_logic_unsigned."*"(ai, b_value_ext)), 128));
      END GENERATE unsigned_multiply;
      
    END GENERATE ccm;

    -- implement any required symmetric rounding on the output
    do_round : IF c_round_output /= 0 AND c_round_pt > 0 GENERATE
      pm_round <= NOT(ai(ai'high) XOR bi(bi'high)) + round_const + pm;
    END GENERATE do_round;
    no_round : IF c_round_output = 0 OR c_round_pt = 0 GENERATE
      pm_round <= pm;
    END GENERATE no_round;

    -- configure the SCLR for the BRAM CCM, if applicable
    -- Need an additional check for if the constant is exactly +one because we
    -- only need a delay line to model that and it doesn't need a separate SCLR
    is_bram_ccm : IF c_mult_type = FIXED_CCM AND c_ccm_imp = BRAM AND NOT(check_const_power_two(c_b_value, c_b_type)) GENERATE
      bram_addr_sclr <= '0';
    END GENERATE is_bram_ccm;
    not_bram_ccm : IF NOT(c_mult_type = FIXED_CCM AND c_ccm_imp = BRAM AND NOT(check_const_power_two(c_b_value, c_b_type))) GENERATE
      bram_addr_sclr <= sclr_i;
    END GENERATE not_bram_ccm;

    -- implement the pipelining as a delay line
    pipe0 : IF pipeline_latency = 0 GENERATE
      pi <= pm_round;
    END GENERATE pipe0;
    pipe1 : IF pipeline_latency = 1 GENERATE
      PROCESS (clk) IS
      BEGIN
        IF rising_edge(clk) THEN
          IF bram_addr_sclr = '1' THEN
            pi <= (OTHERS => '0');
          ELSE
            IF ce_i = '1' THEN
              pi <= pm_round;
            END IF;
          END IF;
        END IF;
      END PROCESS;
    END GENERATE pipe1;
    pipe2 : IF pipeline_latency = 2 GENERATE
      SIGNAL ff : STD_LOGIC_VECTOR(pi'range) := (OTHERS => '0');
    BEGIN
      -- create single-cycle delay with separate SCLR
      PROCESS (clk) IS
      BEGIN
        IF rising_edge(clk) THEN
          IF bram_addr_sclr = '1' THEN
            ff <= (OTHERS => '0');
          ELSE
            IF ce_i = '1' THEN
              ff <= pm_round;
            END IF;
          END IF;
        END IF;
      END PROCESS;
      -- create another single-cycle delay with global SCLR
      PROCESS (clk) IS
      BEGIN
        IF rising_edge(clk) THEN
          IF sclr_i = '1' THEN
            pi <= (OTHERS => '0');
          ELSE
            IF ce_i = '1' THEN
              pi <= ff;
            END IF;
          END IF;
        END IF;
      END PROCESS;
    END GENERATE pipe2;
    pipeX : IF pipeline_latency > 2 GENERATE
      TYPE   T_DELAY IS ARRAY (0 TO pipeline_latency-2) OF STD_LOGIC_VECTOR(pi'range);
      SIGNAL delay_line : T_DELAY                    := (OTHERS => (OTHERS => '0'));
      SIGNAL ff         : STD_LOGIC_VECTOR(pi'range) := (OTHERS => '0');
    BEGIN
      -- create single-cycle delay with separate SCLR
      PROCESS (clk) IS
      BEGIN
        IF rising_edge(clk) THEN
          IF bram_addr_sclr = '1' THEN
            ff <= (OTHERS => '0');
          ELSE
            IF ce_i = '1' THEN
              ff <= pm_round;
            END IF;
          END IF;
        END IF;
      END PROCESS;
      -- create delay LINE
      PROCESS (clk) IS
      BEGIN
        IF rising_edge(clk) THEN
          IF sclr_i = '1' THEN
            delay_line <= (OTHERS => (OTHERS => '0'));
          ELSE
            IF ce_i = '1' THEN
              delay_line <= ff & delay_line(0 TO pipeline_latency-3);
            END IF;
          END IF;
        END IF;
      END PROCESS;
      pi <= delay_line(pipeline_latency-2);
    END GENERATE pipeX;

    -- pick out the requested slice of the full-width product
    p <= pi(c_out_high DOWNTO c_out_low);

    has_zero_detect : IF c_has_zero_detect /= 0 AND c_mult_type /= FIXED_CCM GENERATE
      CONSTANT zeros : STD_LOGIC_VECTOR(c_a_width-3 DOWNTO 0) := (OTHERS => '0');
    BEGIN
      -- rather than performing bit-true modelling, we just duplicate the
      -- output for all parallel multipliers
      -- NOTE THAT THE *AND* OF THESE TWO SIGNALS IS CHECKED IN THE TESTBENCH
      -- AND THIS MODEL WILL NOT MATCH ALL MULTIPLIER VARIANTS EXACTLY
      -- THE ASSUMPTION IS THAT THE FPO CORE (WHICH IS THE ONLY USER OF THIS
      -- FEATURE) WILL ALWAYS *AND* THE TWO OUTPUTS IN SOME EXTERNAL LOGIC
      zero_detect(0) <= '1' WHEN pi(c_a_width-3 DOWNTO 0) = zeros ELSE '0';
      zero_detect(1) <= '1' WHEN pi(c_a_width-3 DOWNTO 0) = zeros ELSE '0';
    END GENERATE has_zero_detect;
    
  END GENERATE parallel_multiplier;
  
END ARCHITECTURE behavioral;
