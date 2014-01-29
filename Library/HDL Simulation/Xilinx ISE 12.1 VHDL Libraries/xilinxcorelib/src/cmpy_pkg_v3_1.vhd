-- $RCSfile: cmpy_pkg_v3_1.vhd,v $ $Date: 2009/12/02 13:23:23 $ $Revision: 1.2 $
--
-- (c) Copyright 2009 Xilinx, Inc. All rights reserved.
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
-- Shared package for cmpy_v3_1
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

library xilinxcorelib;
use xilinxcorelib.mult_gen_pkg_v11_2.all;

package cmpy_pkg_v3_1 is

  -- Enable general debug output
  constant cmpy_v3_1_debug : boolean := false;

  -- Enable assert statements to debug progress through function hierarchy
  constant cmpy_v3_1_fn_debug : boolean := false;

  -- Enable assert statements to debug resource usage
  constant cmpy_v3_1_resource_debug : boolean := false;

  -- Min/Max allowed latency stages
  constant cmpy_v3_1_min_latency : integer := -1;  -- "fully-pipelined" - "0" is first true configurable latency setting
  constant cmpy_v3_1_max_latency : integer := 50;
  
  constant min_a_width, min_b_width : integer := 8;
  constant max_a_width, max_b_width : integer := 63;
  constant max_msb                  : integer := 126;
  constant min_msb, min_lsb         : integer := 0;

  -- Constants for 3-multiplier DSP-based structure
  constant max_c_port_add_bits      : integer := 46;
  -- Important: We can only add a maximum of 46 bits into the C port of the
  -- lowest DSP48.  If we add 47 bits, the addition of C+(A*B) can spill into
  -- the MSB.  When the result is right-shifted, this MSB is sign-extended and
  -- ends up making the partial product passed to the next DSP up the column look
  -- negative.  This almost all works out, apart from the corrupted result with
  -- have the wrong value in the 2^48 bit position.
  -- This error appeared more often with the DSP48E because of the larger partial
  -- product, but could have conceivably appeared with DSP48 and DSP48A too,
  -- just a lot less frequently.
  -- Changing the dsp_add_bits constant will move the number of bits fed to the
  -- C port if it turns out that 46 bits is still too much.
  constant dsp_add_bits : integer :=  max_c_port_add_bits;
  
  ---------------------------------------------------------------------------
  -- For support of the single-output FFT
  ---------------------------------------------------------------------------
  -- Add two cycles of delay for SO for the sync'ing of Re and Im
  constant XFFT_SO_CMPY_SYNC_LATENCY     : integer := 2;
  -- We register the muxing that provides the cross-optimisation in the CMPY
  -- components, so add this latency for all cases - applies to all families
  constant XFFT_SO_INPUT_MUX_REG_LATENCY : integer := 1;
  -- The two values together give...
  constant XFFT_SO_EXTRA_LATENCY : integer := XFFT_SO_CMPY_SYNC_LATENCY + XFFT_SO_INPUT_MUX_REG_LATENCY;
  ---------------------------------------------------------------------------
  
  type R_GENERICS is record
    R_VERBOSITY         : integer;
    R_A_WIDTH           : integer;
    R_B_WIDTH           : integer;
    R_OUT_HIGH          : integer;
    R_OUT_LOW           : integer;
    R_LATENCY           : integer;
    R_MULT_TYPE         : integer;
    R_OPTIMIZE_GOAL     : integer;
    R_HAS_CE            : integer;
    R_HAS_SCLR          : integer;
    R_CE_OVERRIDES_SCLR : integer;
    R_HAS_NEGATE        : integer;
    R_SINGLE_OUTPUT     : integer;
    R_ROUND             : integer;
    R_USE_DSP_CASCADES  : integer;
  end record R_GENERICS;

  type T_CMPY_ARCH is (THREE_MULT, FOUR_MULT);

  type R_ALLOW_PRE_ADDER is record
    allow_preadd : integer;
    extra_b_pp   : integer;
  end record R_ALLOW_PRE_ADDER;

  constant OPTIMIZE_DSP_COUNT   : integer := 0;
  constant OPTIMIZE_PERFORMANCE : integer := 1;
  
  function check_and_resolve_generics(C_VERBOSITY         : integer;
                                      C_XDEVICEFAMILY     : string;
                                      C_XDEVICE           : string;
                                      C_A_WIDTH           : integer;
                                      C_B_WIDTH           : integer;
                                      C_OUT_HIGH          : integer;
                                      C_OUT_LOW           : integer;
                                      C_LATENCY           : integer;
                                      C_MULT_TYPE         : integer;
                                      C_OPTIMIZE_GOAL     : integer;
                                      C_HAS_CE            : integer;
                                      C_HAS_SCLR          : integer;
                                      C_CE_OVERRIDES_SCLR : integer;
                                      HAS_NEGATE          : integer;
                                      SINGLE_OUTPUT       : integer;
                                      ROUND               : integer;
                                      USE_DSP_CASCADES    : integer) return R_GENERICS;

  function mult_gen_latency(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY : integer) return integer;

  function allow_pre_adder(C_XDEVICEFAMILY : string; A_WIDTH, B_WIDTH : integer; A_IS_ADDEND : integer := 0; swap_widths : boolean) return R_ALLOW_PRE_ADDER;
  
  function calc_cmpy_3_mults(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH : integer; RETURN_CONFIG : integer := 0) return integer;

  function calc_cmpy_4_mults(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH, SINGLE_OUTPUT : integer) return integer;

  function select_cmpy_arch(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT : integer) return T_CMPY_ARCH;

  function cmpy_v3_1_latency(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, OUT_HIGH, OUT_LOW, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer;

  function cmpy_v3_1_latency_internal(XDEVICEFAMILY : string; ARCH : T_CMPY_ARCH; A_WIDTH, B_WIDTH, OUT_HIGH, OUT_LOW, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer;
   
  function cmpy_v3_1_mults(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer;

  function cmpy_v3_1_mults_internal(XDEVICEFAMILY : string; ARCH : T_CMPY_ARCH; A_WIDTH, B_WIDTH, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer;
  
  function compare_cmpy_structures(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT : integer) return integer;

  function mult_gen_mults(C_XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, LATENCY, get_luts, get_mults : integer) return integer;
  
  function cmpy_3_dsp48_need_fabric_postadd(C_OPERAND_WIDTH : integer) return integer;

  function v6_special_preadd_case_valid(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH : integer) return boolean;

  function allow_use_dsp_cascades_maximum(XDEVICEFAMILY, XDEVICE : string; A_WIDTH, B_WIDTH, OUT_HIGH, OUT_LOW, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return boolean;

  function mult_gen_has_extra_b_pp(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH : integer) return boolean;
  
end package cmpy_pkg_v3_1;

package body cmpy_pkg_v3_1 is

  function check_and_resolve_generics(C_VERBOSITY         : integer;
                                      C_XDEVICEFAMILY     : string;
                                      C_XDEVICE           : string;
                                      C_A_WIDTH           : integer;
                                      C_B_WIDTH           : integer;
                                      C_OUT_HIGH          : integer;
                                      C_OUT_LOW           : integer;
                                      C_LATENCY           : integer;
                                      C_MULT_TYPE         : integer;
                                      C_OPTIMIZE_GOAL     : integer;
                                      C_HAS_CE            : integer;
                                      C_HAS_SCLR          : integer;
                                      C_CE_OVERRIDES_SCLR : integer;
                                      HAS_NEGATE          : integer;
                                      SINGLE_OUTPUT       : integer;
                                      ROUND               : integer;
                                      USE_DSP_CASCADES    : integer) return R_GENERICS is
    variable RGEN : R_GENERICS;
  begin

    ---------------------------------------------------------------------------
    -- Basic range checks
    ---------------------------------------------------------------------------
    if C_VERBOSITY /= 0 and C_VERBOSITY /= 1 and C_VERBOSITY /= 2 then
      assert false report "ERROR : cmpy_v3_1 : C_VERBOSITY is out of range 0 to 2. Value is " & integer'image(C_VERBOSITY) severity failure;
    end if;

    if C_A_WIDTH < min_a_width or C_A_WIDTH > max_a_width then
      assert false report "ERROR : cmpy_v3_1 : C_A_WIDTH is out of range. Value is " & integer'image(C_A_WIDTH) severity failure;
    end if;

    if C_B_WIDTH < min_b_width or C_B_WIDTH > max_b_width then
      assert false report "ERROR : cmpy_v3_1 : C_B_WIDTH is out of range. Value is " & integer'image(C_B_WIDTH) severity failure;
    end if;

    if C_OUT_HIGH < min_msb or C_OUT_HIGH < C_OUT_LOW or C_OUT_HIGH > max_msb then
      assert false report "ERROR : cmpy_v3_1 : C_OUT_HIGH is invalid. It must be >= C_OUT_LOW and positive and <= " & integer'image(max_msb) & ". Value is " & integer'image(C_OUT_HIGH) severity failure;
    end if;

    if C_OUT_LOW < min_lsb or C_OUT_LOW > C_OUT_HIGH then
      assert false report "ERROR : cmpy_v3_1 : C_OUT_LOW is invalid. It must be positive and <= C_OUT_HIGH. Value is " & integer'image(C_OUT_LOW) severity failure;
    end if;

    if C_LATENCY < cmpy_v3_1_min_latency or C_LATENCY > cmpy_v3_1_max_latency then
      assert false report "ERROR : cmpy_v3_1 : C_LATENCY is out of range " & integer'image(cmpy_v3_1_min_latency) & " to " & integer'image(cmpy_v3_1_max_latency) & ". Value is " & integer'image(C_LATENCY) severity failure;
    end if;

    if C_MULT_TYPE /= 0 and C_MULT_TYPE /= 1 then
      assert false report "ERROR : cmpy_v3_1 : C_MULT_TYPE is out of range 0 to 1. Value is " & integer'image(C_MULT_TYPE) severity failure;
    end if;

    if C_OPTIMIZE_GOAL /= 0 and C_OPTIMIZE_GOAL /= 1 and C_OPTIMIZE_GOAL /= 2 then
      -- Only two values are visible to customers
      -- 0 = Resource optimisation
      -- 1 = Performance optimisation
      -- 2 = Force Resource optimisation (for internal benchmarking)
      assert false report "ERROR : cmpy_v3_1 : C_OPTIMIZE_GOAL is out of range 0 to 2. Value is " & integer'image(C_OPTIMIZE_GOAL) severity failure;
    end if;

    if C_HAS_CE /= 0 and C_HAS_CE /= 1 then
      assert false report "ERROR : cmpy_v3_1 : C_HAS_CE is out of range 0 to 1. Value is " & integer'image(C_HAS_CE) severity failure;      
    end if;

    if C_HAS_SCLR /= 0 and C_HAS_SCLR /= 1 then
      assert false report "ERROR : cmpy_v3_1 : C_HAS_SCLR is out of range 0 to 1. Value is " & integer'image(C_HAS_SCLR) severity failure;            
    end if;

    if C_CE_OVERRIDES_SCLR /= 0 and C_CE_OVERRIDES_SCLR /= 1 then
      assert false report "ERROR : cmpy_v3_1 : C_CE_OVERRIDES_SCLR is out of range 0 to 1. Value is " & integer'image(C_CE_OVERRIDES_SCLR) severity failure;            
    end if;
    
    if HAS_NEGATE /= 0 and HAS_NEGATE /= 1 and HAS_NEGATE /= 2 then
      -- 0 = no negation
      -- 1 = negate B inputs
      -- 2 = negate A inputs
      assert false report "ERROR : cmpy_v3_1 : NEGATE_A is out of range 0 to 2. Value is " & integer'image(HAS_NEGATE) severity failure;
    end if;

    if SINGLE_OUTPUT /= 0 and SINGLE_OUTPUT /= 1 then
      -- Internal use only - for FFT
      assert false report "ERROR : cmpy_v3_1 : SINGLE_OUTPUT is out of range 0 to 1. Value is " & integer'image(SINGLE_OUTPUT) severity failure;
    end if;

    if ROUND /= 0 and ROUND /= 1 and ROUND /= 2 then
      -- Setting of 2 is for FFT use only
      -- 0 = no rounding constant added, ROUND_CY ignored
      -- 1 = add rounding constant and ROUND_CY
      -- 2 = only add rounding constant - ignore ROUND_CY
      assert false report "ERROR : cmpy_v3_1 : ROUND is out of range 0 to 2. Value is " & integer'image(ROUND) severity failure;
    end if;

    if USE_DSP_CASCADES /= 0 and USE_DSP_CASCADES /= 1 and USE_DSP_CASCADES /= 2 then
      -- 0 = Split cascades to allow placement (not implemented in cmpy_v3_1, ignored)
      -- 1 = Normal cascade use
      -- 2 = Chain all DSPs as far as possible.  Use C_XDEVICE setting to
      -- determine if this is valid for the device in question, or force when C_XDEVICE = "override"
      assert false report "ERROR : cmpy_v3_1 : USE_DSP_CASCADES is out of range 0 to 2.  Value is " & integer'image(USE_DSP_CASCADES) severity failure;
    end if;
    
    ---------------------------------------------------------------------------
    -- Assign all generics to record elements
    ---------------------------------------------------------------------------
    RGEN.R_VERBOSITY         := C_VERBOSITY;
    RGEN.R_A_WIDTH           := C_A_WIDTH;
    RGEN.R_B_WIDTH           := C_B_WIDTH;
    RGEN.R_OUT_HIGH          := C_OUT_HIGH;
    RGEN.R_OUT_LOW           := C_OUT_LOW;
    RGEN.R_LATENCY           := C_LATENCY;
    RGEN.R_MULT_TYPE         := C_MULT_TYPE;
    RGEN.R_OPTIMIZE_GOAL     := C_OPTIMIZE_GOAL;
    RGEN.R_HAS_CE            := C_HAS_CE;
    RGEN.R_HAS_SCLR          := C_HAS_SCLR;
    RGEN.R_CE_OVERRIDES_SCLR := C_CE_OVERRIDES_SCLR;
    RGEN.R_HAS_NEGATE        := HAS_NEGATE;
    RGEN.R_SINGLE_OUTPUT     := SINGLE_OUTPUT;
    RGEN.R_ROUND             := ROUND;
    RGEN.R_USE_DSP_CASCADES  := USE_DSP_CASCADES;

    ---------------------------------------------------------------------------
    -- More in-depth checks
    ---------------------------------------------------------------------------
    if RGEN.R_MULT_TYPE = 0 and RGEN.R_OPTIMIZE_GOAL = 1 and RGEN.R_SINGLE_OUTPUT = 0 then
      -- If the LUT CMPY is to be used for a single-output FFT architecture, it
      -- is valid to use the 4-multiplier structure as this will use fewer LUTs (no preadders)
      assert false report "WARNING : cmpy_v3_1 : Optimizing a LUT multiplier for performance (4-mult structure) does not make sense - setting C_OPTIMIZE_GOAL to 0 internally" severity warning;
      RGEN.R_OPTIMIZE_GOAL := 0;
    end if;

    if RGEN.R_ROUND /= 0 and RGEN.R_OUT_LOW = 0 then
      assert false report "WARNING: cmpy_v3_1: Full-precision product has been selected - rounding shall not be implemented" severity warning;
      RGEN.R_ROUND := 0;
    end if;

    if RGEN.R_CE_OVERRIDES_SCLR = 1 and (RGEN.R_HAS_CE = 0 or RGEN.R_HAS_SCLR = 0) then
      assert false report "WARNING: cmpy_v3_1: CE and/or SCLR are not present, but C_CE_OVERRIDES_SCLR = 1 - setting C_CE_OVERRIDES_SCLR to 0" severity warning;
      RGEN.R_CE_OVERRIDES_SCLR := 0;
    end if;

    if RGEN.R_LATENCY = 0 and RGEN.R_HAS_CE = 1 then
      assert false report "WARNING: cmpy_v3_1: CE is not required when C_LATENCY = 0 - setting C_HAS_CE to 0 internally" severity warning;
      RGEN.R_HAS_CE := 0;
    end if;

    if RGEN.R_LATENCY = 0 and RGEN.R_HAS_SCLR = 1 then
      assert false report "WARNING: cmpy_v3_1: SCLR is not required when C_LATENCY = 0 - setting C_HAS_SCLR to 0 internally" severity warning;
      RGEN.R_HAS_SCLR := 0;      
    end if;   

    ---------------------------------------------------------------------------
    -- Turns out that this call is very expensive in runtime terms!
    -- To evaluate this function requires determination of basically the whole
    -- CMPY structure, something that we basically have to repeat again later
    -- anyway, which leads to a huge runtime with the XST classic parser
    ---------------------------------------------------------------------------
--    if allow_use_dsp_cascades_maximum(C_XDEVICEFAMILY, C_XDEVICE, RGEN.R_A_WIDTH, RGEN.R_B_WIDTH, RGEN.R_OUT_HIGH, RGEN.R_OUT_LOW, RGEN.R_LATENCY, RGEN.R_MULT_TYPE, RGEN.R_OPTIMIZE_GOAL, RGEN.R_SINGLE_OUTPUT, RGEN.R_HAS_NEGATE, RGEN.R_ROUND) = false
--      and RGEN.R_USE_DSP_CASCADES = 2 then
--      assert false report "WARNING: cmpy_v3_1: DSP column is not long enough to do maximum chaining - setting to normal chaining" severity warning;
--      RGEN.R_USE_DSP_CASCADES := 1;
--    end if;

    assert not(cmpy_v3_1_fn_debug) report "exiting check_generics" severity note;
    
    return RGEN;

  end function check_and_resolve_generics;

  function mult_gen_latency(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY : integer) return integer is
  begin
    if LATENCY = 0 then
      assert not(cmpy_v3_1_fn_debug) report "exiting mult_gen_latency 0" severity note;
      return 0;
    elsif LATENCY = -1 then
      assert not(cmpy_v3_1_fn_debug) report "exiting mult_gen_latency -1" severity note;      
      return mult_gen_v11_2_calc_fully_pipelined_latency_internal(family     => XDEVICEFAMILY,
                                                                  a_width    => A_WIDTH,
                                                                  a_type     => C_SIGNED,
                                                                  b_width    => B_WIDTH,
                                                                  b_type     => C_SIGNED,
                                                                  mult_type  => MULT_TYPE,
                                                                  opt_goal   => 1,
                                                                  ccm_imp    => 0,
                                                                  b_value    => "0",
                                                                  -- In most cases we are using the adder in the DSP slice, hence mult is not standalone
                                                                  -- This generic needs to be set to ensure we get a 3-cycle latency for Spartan-6
                                                                  standalone => 0);
    else
      assert not(cmpy_v3_1_fn_debug) report "ERROR: cmpy_v3_1: Unsupported latency value " & integer'image(LATENCY) & " caught in mult_gen_latency" severity error;
      return -2;
    end if;

  end function mult_gen_latency;

  function select_cmpy_arch(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT : integer) return T_CMPY_ARCH is
  begin
    if OPTIMIZE_GOAL = 2 then
      -- Force THREE_MULT configuration, for benchmarking purposes
      assert not(cmpy_v3_1_fn_debug) report "leaving select cmpy arch three_mult" severity note;
      return THREE_MULT;
    elsif OPTIMIZE_GOAL = 0 and SINGLE_OUTPUT = 0 then
      if compare_cmpy_structures(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT) = 0 then
      assert not(cmpy_v3_1_fn_debug) report "leaving select cmpy arch three_mult b2" severity note;
        return THREE_MULT;
      else
      assert not(cmpy_v3_1_fn_debug) report "leaving select cmpy arch four_mult b2" severity note;        
        return FOUR_MULT;
      end if;
    elsif OPTIMIZE_GOAL = 1 or SINGLE_OUTPUT = 1 then
      assert not(cmpy_v3_1_fn_debug) report "leaving select cmpy arch four_mult" severity note;      
      return FOUR_MULT;
    else
      -- Default to stop XST warning; should never get here
      assert not cmpy_v3_1_debug report "WARNING: cmpy_v3_1/select_cmpy_arch: Exception clause reached" severity warning;
      return FOUR_MULT;
    end if;
  end function select_cmpy_arch;

  function cmpy_v3_1_latency(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, OUT_HIGH, OUT_LOW, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer is
    constant arch : T_CMPY_ARCH := select_cmpy_arch(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT);
  begin
    return cmpy_v3_1_latency_internal(XDEVICEFAMILY, arch, A_WIDTH, B_WIDTH, OUT_HIGH, OUT_LOW, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND);
  end function cmpy_v3_1_latency;
  
  function cmpy_v3_1_latency_internal(XDEVICEFAMILY : string; ARCH : T_CMPY_ARCH; A_WIDTH, B_WIDTH, OUT_HIGH, OUT_LOW, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer is
    variable lat                  : integer      := 0;
    constant FABRIC_ADD_DELAY     : integer      := 1;
    constant NEGATE_DELAY         : integer      := 1;
    constant PRE_ADDER_BIT_GROWTH : integer      := 1;
    constant CREG_LATENCY         : integer      := 1;
    -- Number of DSP48 P registers that are present when you come in via the C port
    variable PREG_STACK_LATENCY   : integer      := 0;
    -- Use functions from mult_gen package to get PP configuration for DSP48A(1) cases
    -- 'port_size' has to be a variable, otherwise Verific complains that "Initial value for constant declaration is not constant"
    variable port_size            : PORT_ASPECTS := (a => 18+(7*boolean'pos(supports_dsp48e(XDEVICEFAMILY) > 0)), b => 18, m => 36+(7*boolean'pos(supports_dsp48e(XDEVICEFAMILY) > 0)), c => 48, p => 48);   
    variable DSP48_PPs            : R_DSP_PP;
    variable a_pp                 : integer;
    variable b_pp                 : integer;
  begin

    assert not(cmpy_v3_1_fn_debug) report "entered cmpy_v3_1_latency_internal" severity note;
    
    if LATENCY /= -1 then
      lat := LATENCY;
    else
      case arch is
        when THREE_MULT =>
          if supports_mult18x18s(XDEVICEFAMILY) = 1 or supports_mult18x18sio(XDEVICEFAMILY) = 1 or MULT_TYPE = 0 then
            -- Latency is optional negate delay (1 cycle) + pre-adder delay (1 cycle) + shared multiplier delay (N
            -- cycles) + post-adder delay (1 cycle) + optional round adder delay (1 cycle)
            lat := NEGATE_DELAY*boolean'pos(HAS_NEGATE > 0)
                   + FABRIC_ADD_DELAY
                   + get_max(mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH+PRE_ADDER_BIT_GROWTH, MULT_TYPE, LATENCY), mult_gen_latency(XDEVICEFAMILY, A_WIDTH+PRE_ADDER_BIT_GROWTH, B_WIDTH, MULT_TYPE, LATENCY))
                   + FABRIC_ADD_DELAY
                   + FABRIC_ADD_DELAY*boolean'pos(ROUND > 0)
                   - boolean'pos(ROUND /= 0 and has_lut6(XDEVICEFAMILY) and MULT_TYPE = 0);
          else
            -- Changed to a variable to avoid calculating for every configuration
            if supports_dsp48(XDEVICEFAMILY) = 1 or supports_dsp48e(XDEVICEFAMILY) > 0 then
              PREG_STACK_LATENCY := mult_gen_mults(XDEVICEFAMILY, A_WIDTH+1, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, LATENCY, 0, 1);
              lat                := boolean'pos(HAS_NEGATE > 0)
                                    + FABRIC_ADD_DELAY
                                    + mult_gen_mults(XDEVICEFAMILY, A_WIDTH, B_WIDTH+PRE_ADDER_BIT_GROWTH, MULT_TYPE, OPTIMIZE_GOAL, LATENCY, 0, 1)+2
                                    + CREG_LATENCY
                                    + PREG_STACK_LATENCY
                                    + cmpy_3_dsp48_need_fabric_postadd(A_WIDTH+B_WIDTH+1)
                                    + boolean'pos(OUT_LOW*boolean'pos(ROUND > 0) > max_c_port_add_bits);
            else
              -- Use the mult_gen's functions to calculate latency because of
              -- the extra latency stages required for DSP48A implementations
              -- to register the C port
              PREG_STACK_LATENCY := mult_gen_latency(XDEVICEFAMILY, A_WIDTH+1, B_WIDTH, MULT_TYPE, LATENCY) - 2;
              lat                := boolean'pos(HAS_NEGATE > 0)
                                    + FABRIC_ADD_DELAY
                                    + mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH+PRE_ADDER_BIT_GROWTH, MULT_TYPE, LATENCY)
                                    + CREG_LATENCY
                                    + PREG_STACK_LATENCY
                                    + cmpy_3_dsp48_need_fabric_postadd(A_WIDTH+B_WIDTH+1)
                                    + boolean'pos(OUT_LOW*boolean'pos(ROUND > 0) > max_c_port_add_bits);
            end if;
          end if;
        when FOUR_MULT =>
          if supports_mult18x18s(XDEVICEFAMILY) = 1 or supports_mult18x18sio(XDEVICEFAMILY) = 1 or MULT_TYPE = 0 then
            lat := NEGATE_DELAY*boolean'pos(HAS_NEGATE > 0)
                   + mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)
                   + FABRIC_ADD_DELAY
                   + FABRIC_ADD_DELAY*boolean'pos(ROUND > 0)
                   - boolean'pos(ROUND /= 0 and has_lut6(XDEVICEFAMILY) and MULT_TYPE = 0);
          else
            -- Fully-pipelined latency of a DSP48 implementation is the height of the DSP column,
            -- plus 2.  This works out to be 2x the latency of a real multiplier,
            -- minus two when DSP48 or DSP48E(1) are used.
            if supports_DSP48(XDEVICEFAMILY) = 1 or supports_DSP48E(XDEVICEFAMILY) > 0 then
              lat := 2 * (mult_gen_mults(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, LATENCY, 0, 1)+2) - 2;
            else
              -- Different for DSP48A(1) because the 17-bit wireshift has to be
              -- done in fabric and we need to use the C port + Creg to get back
              -- into the next DSP.  We subtract 2, and also subtract the number
              -- of wireshifts that have to be performed.
              DSP48_PPs := calc_dsp48_pps(XDEVICEFAMILY, get_true_widths(XDEVICEFAMILY, A_WIDTH, B_WIDTH, C_SIGNED, C_SIGNED, port_size));
              a_pp := DSP48_PPs.a_pp;
              b_pp := DSP48_PPs.b_pp;
              if a_pp = 1 and b_pp = 1 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 2;
              elsif a_pp = 2 and b_pp = 1 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 3;
              elsif a_pp = 3 and b_pp = 1 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 4;
              elsif a_pp = 4 and b_pp = 1 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 5;
              elsif a_pp = 2 and b_pp = 2 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 4;
              elsif a_pp = 3 and b_pp = 2 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 5;
              elsif a_pp = 3 and b_pp = 3 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 6;
              elsif a_pp = 4 and b_pp = 2 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 6;
              elsif a_pp = 4 and b_pp = 3 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 7;
              elsif a_pp = 4 and b_pp = 4 then
                lat := (2 * mult_gen_latency(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, LATENCY)) - 8;
              end if;
            end if;
            if (ROUND > 0 and (OUT_LOW-1) >= 47) then
              -- Cannot add in all of rounding constant into DSP48 C port
              -- Need rounding adder in fabric afterwards - fixed latency of 1 cycle
              lat := lat + 1;
            end if;
          end if;
          -- Applies to all multiplier types in 4-mult structure...
          if SINGLE_OUTPUT = 1 then
            -- Add extra cycles for the sync logic required in the single-output
            -- FFT architecture
            lat := lat + XFFT_SO_INPUT_MUX_REG_LATENCY + XFFT_SO_CMPY_SYNC_LATENCY;
          end if;
        when others => null;
      end case;
    end if;

    assert not(cmpy_v3_1_fn_debug) report "leaving cmpy_v3_1_latency_internal" severity note;
    assert not cmpy_v3_1_debug report "returning latency " & integer'image(lat) severity note;
    return lat;
  end function cmpy_v3_1_latency_internal;

  function cmpy_v3_1_mults(XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer is
    constant arch  : T_CMPY_ARCH := select_cmpy_arch(XDEVICEFAMILY, A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT);
  begin
    return cmpy_v3_1_mults_internal(XDEVICEFAMILY, arch, A_WIDTH, B_WIDTH, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND);
  end function cmpy_v3_1_mults;
  
  function cmpy_v3_1_mults_internal(XDEVICEFAMILY : string; ARCH : T_CMPY_ARCH; A_WIDTH, B_WIDTH, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return integer is
    variable mults : integer := 0;
  begin
    if MULT_TYPE = 0 then
      mults := 0;                       -- LUT multipliers
    else
      case arch is
        when THREE_MULT =>
          mults := calc_cmpy_3_mults(XDEVICEFAMILY, A_WIDTH, B_WIDTH);
        when FOUR_MULT =>
          mults := calc_cmpy_4_mults(XDEVICEFAMILY, A_WIDTH, B_WIDTH, SINGLE_OUTPUT);
        when others =>
          report "ERROR: cmpy_v3_1/cmpy_v3_1_mults: unrecognised architecture" severity failure;
      end case;
    end if;
    return mults;
  end function cmpy_v3_1_mults_internal;
       
  -----------------------------------------------------------------------------
  -- compare_cmpy_structures establishes if it makes sense to use the 3-mult
  -- structure to save DSP48 resources, or if the 4-mult structure is actually
  -- cheaper, for a given set of generics
  -- It takes into account that swapping the operands over may yield a smaller
  -- 3-mult structure
  --
  -- Returns the optimize_goal values that should be used internally for the
  -- best implementation, if C_OPTIMIZE_GOAL was set to 0, otherwise
  -- C_OPTIMIZE_GOAL is passed straight through
  -----------------------------------------------------------------------------
  function compare_cmpy_structures(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT : integer) return integer is
    variable three_mult_dsp48s : integer := 0;
    variable four_mult_dsp48s  : integer := 0;
    variable can_use_pre_adder : integer := 0;  -- maybe use to indicate pre-
                                                -- adder use: 0=not possible 1=
                                                -- use pre-adder without
                                                -- swapping operands 2=use pre-
                                                -- adder,but swap operands for
                                                -- better utilization
  begin
    assert not(cmpy_v3_1_fn_debug) report "entered compare_cmpy_structures" severity note;
    if MULT_TYPE = 0 then
      -- LUTs requested
      if SINGLE_OUTPUT = 0 then
        return OPTIMIZE_DSP_COUNT;
      else
        return OPTIMIZE_PERFORMANCE;
      end if;
    else
      if OPTIMIZE_GOAL = 0 then
        three_mult_dsp48s    := calc_cmpy_3_mults(C_XDEVICEFAMILY, C_A_WIDTH, C_B_WIDTH);
        four_mult_dsp48s     := calc_cmpy_4_mults(C_XDEVICEFAMILY, C_A_WIDTH, C_B_WIDTH, SINGLE_OUTPUT);
        if three_mult_dsp48s < four_mult_dsp48s then
          return OPTIMIZE_DSP_COUNT;
        else
          return OPTIMIZE_PERFORMANCE;
        end if;
      else
        if OPTIMIZE_GOAL = 2 then
          -- Force 3-mult configuration
          return 0;
        else
        return OPTIMIZE_GOAL;
        end if;
      end if;
    end if;
  end function compare_cmpy_structures;

  function mult_gen_mults(C_XDEVICEFAMILY : string; A_WIDTH, B_WIDTH, MULT_TYPE, OPTIMIZE_GOAL, LATENCY, get_luts, get_mults : integer) return integer is
    variable resource_count : integer := 0;
    constant wide           : integer := get_max(A_WIDTH, B_WIDTH);
    constant narrow         : integer := get_min(A_WIDTH, B_WIDTH);
  begin  -- mult_gen_mults
    assert not(cmpy_v3_1_fn_debug) report "entered mult_gen_mults" severity note;
    assert (get_luts = 1 and get_mults = 0)
      or (get_luts = 0 and get_mults = 1)
      report "ERROR : cmpy_v3_1/mult_gen_mults : Can only return resources for one primitive at a time"
      severity error;
    -- Call functions only as and when required
    if get_luts = 1 then
      resource_count := mult_gen_v11_2_luts(C_XDEVICEFAMILY, A_WIDTH, C_SIGNED, B_WIDTH, C_SIGNED, MULT_TYPE, OPTIMIZE_PERFORMANCE, LATENCY, 0, "0");
    elsif get_mults = 1 then
      -------------------------------------------------------------------------
      -- It's obviously undesirable to have local code with magic numbers, but
      -- it's required here to make the generation time of the core practical.
      -- XST classic takes far too long to synthesise when using the mult_gen
      -- function, so we hard-code the embedded multiplier counts here instead
      -------------------------------------------------------------------------
      -- It's important to note that the IF branches are ordered by multiplier
      -- count rather than by the operand sizes (like you can do with V4/S3ADSP/S6)
      -- If this is not done, you get the wrong values returned because you hit
      -- a size that the requested case fits into, but may be bigger than you expected.
      -- This will cause mismatches with the behv model (the RTL will correct)
      -------------------------------------------------------------------------
      if supports_dsp48e(C_XDEVICEFAMILY) > 0 then
        if wide <= 25 and narrow <= 18 then
          resource_count := 1;
        elsif wide <= 35 and narrow <= 25 then
          resource_count := 2;
        elsif wide <= 42 and narrow <= 18 then
          resource_count := 2;
        elsif wide <= 52 and narrow <= 25 then
          resource_count := 3;
        elsif wide <= 59 and narrow <= 18 then
          resource_count := 3;
        elsif wide <= 69 and narrow <= 25 then
          resource_count := 4;
        elsif wide <= 42 and narrow <= 35 then
          resource_count := 4;
        elsif wide <= 76 and narrow <= 18 then
          resource_count := 4;
        elsif wide <= 42 and narrow <= 42 then  -- extra b_pp
          resource_count := 5;
        elsif wide <= 52 and narrow <= 42 then
          resource_count := 6;
        elsif wide <= 59 and narrow <= 35 then
          resource_count := 6;
        elsif wide <= 59 and narrow <= 42 then  -- extra b_pp
          resource_count := 7;
        elsif wide <= 69 and narrow <= 42 then
          resource_count := 8;
        elsif wide <= 76 and narrow <= 35 then
          resource_count := 8;
        elsif wide <= 59 and narrow <= 52 then
          resource_count := 9;
        elsif wide <= 59 and narrow <= 59 then  -- extra b_pp
          resource_count := 10;
        elsif wide <= 69 and narrow <= 59 then
          resource_count := 12;
        elsif wide <= 76 and narrow <= 52 then
          resource_count := 12;
        elsif wide <= 76 and narrow <= 69 then
          resource_count := 16;
        else
          resource_count := 0;
          assert false report "WARNING: no resource count was selected in DSP48E-based branch of mult_gen_mults" severity warning;
        end if;
      elsif supports_dsp48(C_XDEVICEFAMILY) = 1 or supports_dsp48a(C_XDEVICEFAMILY) > 0 or supports_mult18x18(C_XDEVICEFAMILY) = 1 or supports_mult18x18sio(C_XDEVICEFAMILY) = 1 then
        if wide <= 18 and narrow <= 18 then
          resource_count := 1;
        elsif wide <= 35 and narrow <= 18 then
          resource_count := 2;
        elsif wide <= 35 and narrow <= 35 then
          resource_count := 4;
        elsif wide <= 52 and narrow <= 18 then
          resource_count := 3;
        elsif wide <= 52 and narrow <= 35 then
          resource_count := 6;
        elsif wide <= 52 and narrow <= 52 then
          resource_count := 9;
        elsif wide <= 64 and narrow <= 18 then
          resource_count := 4;
        elsif wide <= 64 and narrow <= 35 then
          resource_count := 8;
        elsif wide <= 64 and narrow <= 52 then
          resource_count := 12;
        elsif wide <= 64 and narrow <= 64 then
          resource_count := 16;
        else
          resource_count := 0;
          assert false report "WARNING: no resource count was selected in DSP48/DSP48A-based branch of mult_gen_mults" severity warning;
        end if;
      else
        -- Fall back to function in mult core (very slow in XST classic parser)
        resource_count := mult_gen_v11_2_mults(C_XDEVICEFAMILY, A_WIDTH, C_SIGNED, B_WIDTH, C_SIGNED, MULT_TYPE, OPTIMIZE_PERFORMANCE, LATENCY, 0, "0");
        assert false report "WARNING: Falling back to using mult_gen_v11_2_mults function" severity warning;
      end if;
    end if;
    assert not(cmpy_v3_1_fn_debug) report "leaving mult_gen_mults" severity note;    
    return resource_count;
  end mult_gen_mults;

  -- Returns a record so that we can re-use some of the information calculated
  -- (extra_b_pp) later on in the modules that call this function
  function allow_pre_adder(C_XDEVICEFAMILY : string; A_WIDTH, B_WIDTH : integer; A_IS_ADDEND : integer := 0; swap_widths : boolean) return R_ALLOW_PRE_ADDER is
    variable can_use_preadd     : integer      := 0;
    variable a_width_internal   : integer      := 0;
    variable b_width_internal   : integer      := 0;
    -- We can use the pre-adders in Virtex-6 when the A bus is cascaded
    -- (unchanged) up the column on ACOUT/ACIN
    -- Because we can't cascade the pre-adder output, we need to duplicate the
    -- pre-adders in each DSP and delay the D input accordingly in slice logic.
    -- Here we work out if that is the case by calling the functions from the
    -- multiplier package to see what the partial product array configuration is
    -- going to be.  If the 'a_pp' dimension is '1', then we can use the pre-adders.
    -- So this works for 25x18, 35x25, 52x25 and 63x25 /real/ multipliers
    variable mult_gen_port_size : PORT_ASPECTS;
    variable mult_gen_op_width  : WIDTH_REC;
    variable mult_gen_pps       : R_DSP_PP;
    variable a_pp               : integer;
    variable extra_b_pp         : integer           := 0;
    variable ret                : R_ALLOW_PRE_ADDER := (allow_preadd => 0, extra_b_pp => 0);
  begin  -- allow_pre_adder
    assert not(cmpy_v3_1_fn_debug) report "entered allow_pre_adder" severity note;
    if swap_widths then
      a_width_internal := B_WIDTH;
      b_width_internal := A_WIDTH;
    else
      a_width_internal := A_WIDTH;
      b_width_internal := B_WIDTH;
    end if;
    
    if supports_dsp48e1(C_XDEVICEFAMILY) > 0 then
      mult_gen_port_size := (a => 18+((boolean'pos(supports_dsp48e(C_XDEVICEFAMILY) > 0))*7), b => 18, m => 36+((boolean'pos(supports_dsp48e(C_XDEVICEFAMILY) > 0))*7), c => 48, p => 48);
      mult_gen_op_width := get_true_widths(C_XDEVICEFAMILY, A_WIDTH, B_WIDTH, 0, 0, mult_gen_port_size);
      mult_gen_pps := calc_dsp48_pps(C_XDEVICEFAMILY, mult_gen_op_width);
      a_pp := mult_gen_pps.a_pp;
      extra_b_pp := mult_gen_pps.extra_b_pp;
      -- 25-bit pre-adder in Virtex
      if ((a_width_internal <= 24 and A_IS_ADDEND = 1) or (b_width_internal <= 24 and A_IS_ADDEND = 0 and not(v6_special_preadd_case_valid(C_XDEVICEFAMILY, A_WIDTH, B_WIDTH))))
      and (a_pp = 1) then
        can_use_preadd := 1;
      else
        can_use_preadd := 0;
      end if;
    elsif supports_dsp48a(C_XDEVICEFAMILY) > 0 then
      -- 18-bit pre-adder in Spartans
      if (a_width_internal <= 17 and A_IS_ADDEND = 1) or (b_width_internal <= 17 and A_IS_ADDEND = 0) then
        can_use_preadd := 1;
      else
        can_use_preadd := 0;
      end if;
    else
      -- No pre-adder
      can_use_preadd := 0;
    end if;
    assert not cmpy_v3_1_debug report "allow_pre_adder returned " & integer'image(can_use_preadd) severity note;
    ret.allow_preadd := can_use_preadd;
    ret.extra_b_pp := extra_b_pp;
    return ret;
  end allow_pre_adder;

  function calc_cmpy_3_mults(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH : integer; RETURN_CONFIG : integer := 0) return integer is
    variable dsp_count    : integer := 0;
    variable config0_dsps : integer := 0;
    variable config1_dsps : integer := 0;
    variable config_used  : integer := -1;
    constant mults_cfg1   : integer := mult_gen_mults(C_XDEVICEFAMILY, C_A_WIDTH, C_B_WIDTH+1, 1, OPTIMIZE_PERFORMANCE, -1, 0, 1);
    constant mults_cfg2   : integer := mult_gen_mults(C_XDEVICEFAMILY, C_A_WIDTH+1, C_B_WIDTH, 1, OPTIMIZE_PERFORMANCE, -1, 0, 1);
  begin  -- calc_cmpy_3_mults

    assert not(cmpy_v3_1_resource_debug) report "mults_cfg1 " & integer'image(mults_cfg1) severity note;
    assert not(cmpy_v3_1_resource_debug) report "mults_cfg2 " & integer'image(mults_cfg2) severity note;
    
    assert not(cmpy_v3_1_fn_debug) report "entered calc_cmpy_3_mults" severity note;
    if supports_mult18x18s(C_XDEVICEFAMILY) = 1 or supports_mult18x18sio(C_XDEVICEFAMILY) = 1 then
      -- Re-using 'dsp' variables for mult18x18 cases...
      -- calculate Mult18s for first configuration
      config0_dsps    := mults_cfg1 + 2*mults_cfg2;
      -- calculate Mult18s for second configuration
      config1_dsps    := mults_cfg2 + 2*mults_cfg1;
      -- Return smallest
      if config0_dsps <= config1_dsps then
        dsp_count   := config0_dsps;
        config_used := 0;
      else
        dsp_count   := config1_dsps;
        config_used := 1;
      end if;
    else
      -- We need to test two configurations to establish if there is a better
      -- way to map the operands, then pick the smaller one.  We should also
      -- check if there is an advantage to using the pre-adder, and check that
      -- this is the same case as the smallest configuration of DSP48s.  If it'
      -- s not, we have a problem - we'd need to give the user the option to
      -- use more fabric or more DSPs!

      config0_dsps := mults_cfg1 + 2*mults_cfg2;
      
      -- calculate DSPs for second configuration
      config1_dsps := mults_cfg2 + 2*mults_cfg1;
      dsp_count    := config1_dsps;

      assert not(cmpy_v3_1_resource_debug) report "config0_dsps " & integer'image(config0_dsps) severity note;
      assert not(cmpy_v3_1_resource_debug) report "config1_dsps " & integer'image(config1_dsps) severity note;
      
      if config0_dsps < config1_dsps then
        dsp_count   := config0_dsps;
        config_used := 0;
      elsif config0_dsps > config1_dsps then
        dsp_count   := config1_dsps;
        config_used := 1;        
      else
        -- equal values - should consider DSP preadder usage before picking config
        dsp_count := config0_dsps;
        config_used := 2;
      end if;
      
    end if;

    assert not(cmpy_v3_1_resource_debug) report "config0_dsps " & integer'image(config0_dsps) severity note;
    assert not(cmpy_v3_1_resource_debug) report "config1_dsps " & integer'image(config1_dsps) severity note;
    assert not(cmpy_v3_1_resource_debug) report "config_used " & integer'image(config_used) severity note;    
    
    assert not cmpy_v3_1_debug report "Calculated " & integer'image(dsp_count) & " DSPs for 3-mult structure" severity note;
    assert not(cmpy_v3_1_fn_debug) report "leaving calc_cmpy_3_mults" severity note;

    if RETURN_CONFIG = 0 then
      return dsp_count;
    else
      return config_used;
    end if;
    
  end calc_cmpy_3_mults;

  function calc_cmpy_4_mults(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH, SINGLE_OUTPUT : integer) return integer is
    variable dsp_count : integer := 0;
  begin  -- calc_cmpy_4_mults
    assert not(cmpy_v3_1_fn_debug) report "entered calc_cmpy_4_mults" severity note;
    if supports_mult18x18s(C_XDEVICEFAMILY) = 1 or supports_mult18x18sio(C_XDEVICEFAMILY) = 1 then
      -- Fix for CR512142
      dsp_count := 2 * (1+boolean'pos(SINGLE_OUTPUT = 0)) * mult_gen_mults(C_XDEVICEFAMILY, C_A_WIDTH, C_B_WIDTH, OPTIMIZE_PERFORMANCE, OPTIMIZE_PERFORMANCE, -1, 0, 1);
    else
      -- Complex mult requires 4x the DSP48 resources of a real multiplier:
      -- @ Each half uses 2x the number of DSPs
      -- @ There are two halves (real, imaginary) unless it's a single-output CMPY for the FFT, in which case we drop
      --   the imaginary half
      --
      -- Examples:
      -- 18x18 CMPY uses 2 DSP48s for the real part and 2 DSP48s for the imaginary
      -- part = 4
      -- 35x18 CMPY uses 4 DSP48s for the real part and 4 DSP48s for the imaginary
      -- part = 8
      dsp_count := 2 * (1+boolean'pos(SINGLE_OUTPUT = 0)) * mult_gen_mults(C_XDEVICEFAMILY, C_A_WIDTH, C_B_WIDTH, OPTIMIZE_PERFORMANCE, OPTIMIZE_PERFORMANCE, -1, 0, 1);
    end if;
    assert not cmpy_v3_1_debug report "Calculated " & integer'image(dsp_count) & " DSPs for 4-mult structure" severity note;
    assert not(cmpy_v3_1_fn_debug) report "leaving calc_cmpy_4_mults" severity note;    
    return dsp_count;
  end calc_cmpy_4_mults;

  function cmpy_3_dsp48_need_fabric_postadd(C_OPERAND_WIDTH : integer) return integer is
  begin
    assert not(cmpy_v3_1_fn_debug) report "entered cmpy_3_dsp48_need_fabric_postadd" severity note;
    if C_OPERAND_WIDTH > max_c_port_add_bits then
    assert not(cmpy_v3_1_fn_debug) report "leaving cmpy_3_dsp48_need_fabric_postadd 1" severity note;      
      return 1;
    else
    assert not(cmpy_v3_1_fn_debug) report "leaving cmpy_3_dsp48_need_fabric_postadd 0" severity note;            
      return 0;
    end if;
  end function cmpy_3_dsp48_need_fabric_postadd;

  -- Indicates a special case where we don't want to swap the ports - they are
  -- already in the right configuration (A larger than B) to make best use of the
  -- preadders in DSP48E1
  -- Account for the case where B > A as well - we need to use this function
  -- before we decide if the operands will be swapped, so do the swapping
  -- manually here
  function v6_special_preadd_case_valid(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH : integer) return boolean is
  begin
    assert not(cmpy_v3_1_fn_debug) report "entered v6_special_preadd_case_valid" severity note;
    if supports_dsp48e1(C_XDEVICEFAMILY) > 0 and ((C_A_WIDTH > 18 and C_A_WIDTH < 25 and C_B_WIDTH < 18) or (C_B_WIDTH > 18 and C_B_WIDTH < 25 and C_A_WIDTH < 18)) then
      assert not(cmpy_v3_1_fn_debug) report "leaving v6_special_preadd_case_valid true" severity note;
      return true;
    else
      assert not(cmpy_v3_1_fn_debug) report "leaving v6_special_preadd_case_valid false" severity note;
      return false;
    end if;
  end function v6_special_preadd_case_valid;

  function dsp_per_column (XDEVICE : string) return integer is
  begin
    assert not(cmpy_v3_1_fn_debug) report "entered dsp_per_column" severity note;
    -- Can't use 'case' because it won't compile when a string is used to select
    -------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    -------------------------------------------------------------------------
    
    
    
    
    -------------------------------------------------------------------------
    
    
    
    
    
    
    
    -------------------------------------------------------------------------    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    -------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    -------------------------------------------------------------------------
    -- For Spartan DSP, pick the shortest column length
    
    
    -------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    -------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    -- Internal use setting to force chaining
    if XDEVICE = "override" then return 512; end if;
    -- If we got here, we didn't recognise any part
    return 0;
  end function dsp_per_column;

  -- Function that returns info on whether the two/three parts of the CMPY can
  -- be chained together on the DSP cascade to guide placement and/or improve performance
  function allow_use_dsp_cascades_maximum(XDEVICEFAMILY, XDEVICE : string; A_WIDTH, B_WIDTH, OUT_HIGH, OUT_LOW, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND : integer) return boolean is
    constant cmpy_mults  : integer := cmpy_v3_1_mults(XDEVICEFAMILY, A_WIDTH, B_WIDTH, LATENCY, MULT_TYPE, OPTIMIZE_GOAL, SINGLE_OUTPUT, HAS_NEGATE, ROUND);
    constant dsp_per_col : integer := dsp_per_column(XDEVICE);
  begin
    assert not(cmpy_v3_1_fn_debug) report "entered allow_use_dsp_cascades_maximum" severity note;
    if cmpy_mults = 0 then
      -- LUT CMPY, don't allow
      return false;
    else
      if dsp_per_col = 0 then
        -- family not recognised
        return false;
      elsif cmpy_mults <= dsp_per_col then
        -- Can chain the halves/thirds together
        return true;
      else
        -- Can't chain - would go over the top of a column
        return false;
      end if;
    end if;
  end function allow_use_dsp_cascades_maximum;

  function mult_gen_has_extra_b_pp(C_XDEVICEFAMILY : string; C_A_WIDTH, C_B_WIDTH : integer) return boolean is
    -- These functions are all used at the top of the mult_gen code, in dsp.vhd
    constant port_size  : PORT_ASPECTS := (a => 18+((boolean'pos(supports_dsp48e(C_XDEVICEFAMILY) > 0))*7), b => 18, m => 36+((boolean'pos(supports_dsp48e(C_XDEVICEFAMILY) > 0))*7), c => 48, p => 48);
    constant C_SIGNED   : integer      := 0;
    -- Changed to variables to speed up generation for devices that don't have DSP48E/E1
    variable op_width   : WIDTH_REC    ;--:= get_true_widths(C_XDEVICEFAMILY, C_A_WIDTH, C_B_WIDTH, C_SIGNED, C_SIGNED, port_size);
    variable pps        : R_DSP_PP     ;--:= calc_dsp48_pps(C_XDEVICEFAMILY, op_width);
  begin
    assert not(cmpy_v3_1_fn_debug) report "entered mult_gen_has_extra_b_pp" severity note;
    if supports_dsp48e(C_XDEVICEFAMILY) > 0 then
      op_width := get_true_widths(C_XDEVICEFAMILY, C_A_WIDTH, C_B_WIDTH, C_SIGNED, C_SIGNED, port_size);
      pps := calc_dsp48_pps(C_XDEVICEFAMILY, op_width);
      if pps.extra_b_pp = 1 then
        return true;
      else
        return false;
      end if;
    else
      return false;
    end if;
  end function mult_gen_has_extra_b_pp;
  
end package body cmpy_pkg_v3_1;
