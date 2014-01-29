-- $RCSfile: c_accum_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:48 $
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
-- All rights reserved.

--
-- Filename - c_accum_v8_0.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description - This file contains the behavior for
--                               the C_ACCUM_V8_0 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;
USE XilinxCoreLib.prims_utils_v8_0.ALL;
USE XilinxCoreLib.pkg_baseblox_v8_0.ALL;
USE XilinxCoreLib.c_addsub_v8_0_comp.ALL;
USE XilinxCoreLib.c_reg_fd_v8_0_comp.ALL;

-- (A)Synchronous Accumulator
--

ENTITY c_accum_v8_0 IS
  GENERIC (
    c_b_width             : INTEGER := 16;
    c_out_width           : INTEGER := 16;
    c_low_bit             : INTEGER := 0;
    c_high_bit            : INTEGER := 15;
    c_add_mode            : INTEGER := c_add;
    c_b_type              : INTEGER := c_unsigned;
    c_b_constant          : INTEGER := 0;
    c_b_value             : STRING  := "0000000000000000";                        
    c_scale               : INTEGER := 0;
    c_saturate            : INTEGER := 0;
    c_ainit_val           : STRING  := "0000000000000000";                        
    c_sinit_val           : STRING  := "0000000000000000";                        
    c_bypass_enable       : INTEGER := c_no_override;
    c_bypass_low          : INTEGER := 0;
    c_sync_enable         : INTEGER := c_override;
    c_sync_priority       : INTEGER := c_clear;
    c_pipe_stages         : INTEGER := 0;
    c_has_s               : INTEGER := 0;
    c_has_c_in            : INTEGER := 1;
    c_has_c_out           : INTEGER := 0;
    c_has_q_c_out         : INTEGER := 0;
    c_has_b_in            : INTEGER := 0;
    c_has_b_out           : INTEGER := 0;
    c_has_q_b_out         : INTEGER := 0;
    c_has_ovfl            : INTEGER := 0;
    c_has_q_ovfl          : INTEGER := 0;
    c_has_ce              : INTEGER := 0;
    c_has_add             : INTEGER := 0;
    c_has_bypass          : INTEGER := 0;
    c_has_b_signed        : INTEGER := 0;
    c_has_aclr            : INTEGER := 0;
    c_has_aset            : INTEGER := 0;
    c_has_ainit           : INTEGER := 0;
    c_has_sclr            : INTEGER := 0;
    c_has_sset            : INTEGER := 0;
    c_has_sinit           : INTEGER := 0;
    c_has_bypass_with_cin : INTEGER := 0;
    c_enable_rlocs        : INTEGER := 1
    ); 

  PORT (
    b        : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    clk      : IN  STD_LOGIC                              := '0';  -- clock
    add      : IN  STD_LOGIC                              := '1';
    ovfl     : OUT STD_LOGIC;
    q_ovfl   : OUT STD_LOGIC;
    c_in     : IN  STD_LOGIC                              := '0';  -- carry in
    c_out    : OUT STD_LOGIC;
    q_c_out  : OUT STD_LOGIC;
    b_in     : IN  STD_LOGIC                              := '0';  -- borrow in
    b_out    : OUT STD_LOGIC;
    q_b_out  : OUT STD_LOGIC;
    ce       : IN  STD_LOGIC                              := '1';  -- clock enable
    b_signed : IN  STD_LOGIC                              := '0';
    bypass   : IN  STD_LOGIC                              := '0';  -- sync load of b into reg
    aclr     : IN  STD_LOGIC                              := '0';  -- asynch init.
    aset     : IN  STD_LOGIC                              := '0';  -- asynch set.
    ainit    : IN  STD_LOGIC                              := '0';  -- asynch init.
    sclr     : IN  STD_LOGIC                              := '0';  -- synch init.
    sset     : IN  STD_LOGIC                              := '0';  -- synch set.
    sinit    : IN  STD_LOGIC                              := '0';  -- synch init.
    s        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit);
    q        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit)  -- synch output value
    );
END c_accum_v8_0;

ARCHITECTURE behavioral OF c_accum_v8_0 IS

-------------------------------------------------------------------------------
-- code copied from hdl (due to libraries dichotomy) starts here
-------------------------------------------------------------------------------
  -- Types inherited from pkg_baseblox:
  -- TYPE T_SYNC_ENABLE
  -- TYPE T_REG_PRIORITY
  -- TYPE T_ADD_MODE
  --
  -- Local types:
  TYPE T_BYPASS_ENABLE IS (CE_OVERRIDES_BYPASS, BYPASS_OVERRIDES_CE);

  FUNCTION fn_select_bypass_enable (c_bypass_enable : INTEGER) RETURN T_BYPASS_ENABLE IS
    VARIABLE ret_val : t_bypass_enable;
  BEGIN
    CASE c_bypass_enable IS
      WHEN c_override    => ret_val := BYPASS_OVERRIDES_CE;
      WHEN c_no_override => ret_val := CE_OVERRIDES_BYPASS;
      WHEN OTHERS => ASSERT FALSE REPORT "ERROR - accum: Invalid value found in c_bypass_enable"
                     SEVERITY FAILURE;
    END CASE;
    RETURN ret_val;
  END;

  -- Clean versions of generics:
  CONSTANT enum_c_add_mode      : T_ADD_MODE     := fn_select_add_mode (c_add_mode);
  CONSTANT enum_c_bypass_enable : T_BYPASS_ENABLE:= fn_select_bypass_enable(c_bypass_enable);
  CONSTANT enum_c_sync_enable   : T_SYNC_ENABLE  := fn_select_sync_enable(c_sync_enable);
  CONSTANT enum_c_sync_priority : T_REG_PRIORITY := fn_select_sync_priority(c_sync_priority);
  CONSTANT enum_c_b_type        : T_NUMBER_FORMAT:= fn_select_number_format(c_b_type);

  CONSTANT ci_ainit_val : STD_LOGIC_VECTOR(c_out_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_ainit_val, c_out_width);
  CONSTANT ci_sinit_val : STD_LOGIC_VECTOR(c_out_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_sinit_val, c_out_width);
  CONSTANT ci_b_value   : STD_LOGIC_VECTOR(c_b_width - 1 DOWNTO 0)   := str_to_bound_slv_0(c_b_value, c_b_width);

  -- Calculates the power-on-reset value for the accumulator.
  -- this value depends on the pins present (aclr,aset,ainit,sclr,sset,sinit).
  -- If none are present, defaults to c_ainit_val.
  FUNCTION get_POR_value RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret_val : STD_LOGIC_VECTOR(c_out_width - 1 DOWNTO 0);
  BEGIN
    ret_val := ci_ainit_val; -- default for no pins
    IF c_has_aclr = 1 THEN
      ret_val :=(OTHERS => '0');
    ELSIF c_has_aset = 1 THEN
      ret_val := (OTHERS => '1');
    ELSIF c_has_ainit = 1 THEN
      ret_val := ci_ainit_val;
    ELSIF c_has_sclr = 1 THEN
      ret_val := (OTHERS => '0');
    ELSIF c_has_sset = 1 THEN
      ret_val := (OTHERS => '1');
    ELSIF c_has_sinit = 1 THEN
      ret_val := ci_sinit_val;
    END IF;
    RETURN ret_val;
  END;

  -- Calculates the power-on-reset value for the q_c_out, q_b_out and q_ovfl
  -- output flipflops.
  FUNCTION get_flipflop_value RETURN STD_LOGIC IS
    VARIABLE ret_val : STD_LOGIC;
  BEGIN
    ret_val := '0';
    IF c_has_aclr = 1 THEN
      ret_val := '0';
    ELSIF c_has_aset = 1 THEN
      ret_val := '1';
    ELSIF c_has_ainit = 1 THEN
      ret_val := '0';
    ELSIF c_has_sclr = 1 THEN
      ret_val := '0';
    ELSIF c_has_sset = 1 THEN
      ret_val := '1';
    ELSIF c_has_sinit = 1 THEN
      ret_val := '0';
    END IF;
    RETURN ret_val;
  END;

  -- Purpose: ensure that the generics supplied do not demand a nonsensical or unsupported case
  FUNCTION check_generics RETURN INTEGER IS
  BEGIN
    -- bounds checking
    ASSERT c_b_width > 0 AND c_b_width <= 256
      REPORT "ERROR - accum: Invalid value for c_b_width; must be in the range 1..256"
      SEVERITY FAILURE;
    ASSERT c_out_width > 0 AND c_out_width <= 258
      REPORT "ERROR - accum: Invalid value for c_out_width; must be in the range 1..258"
      SEVERITY FAILURE;
    ASSERT c_low_bit = 0
      REPORT "ERROR - accum: Invalid value for c_low_bit; c_low_bit must equal 0"
      SEVERITY FAILURE;
    ASSERT c_high_bit = c_out_width - 1
      REPORT "ERROR - accum: Invalid value for c_high_bit; c_high_bit must equal c_out_width - 1"
      SEVERITY FAILURE;
    ASSERT c_has_add = 0 OR c_has_add = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_add (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_b_constant = 0 OR c_b_constant = 1
      REPORT "ERROR - accum: Invalid value in generic c_b_constant (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_scale < c_out_width
      REPORT "ERROR - accum: c_scale must be less than c_out_width"
      SEVERITY FAILURE;
    ASSERT c_scale >= 0 AND c_scale <= 8
      REPORT "ERROR - accum: Invalid value in generic c_scale (must be in range 0..8)"
      SEVERITY FAILURE;
    ASSERT c_saturate = 0
      REPORT "ERROR - accum: Saturation has been deprecated as of baseblox_v8_0"
      SEVERITY FAILURE;
    ASSERT c_bypass_low = 0 OR c_bypass_low = 1
      REPORT "ERROR - accum: Invalid value in generic c_bypass_low (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_s = 0 OR c_has_s = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_s (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_c_in = 0 OR c_has_c_in = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_c_in (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_c_out = 0 OR c_has_c_out = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_c_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_q_c_out = 0 OR c_has_q_c_out = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_q_c_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_b_in = 0 OR c_has_b_in = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_b_in (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_b_out = 0 OR c_has_b_out = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_b_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_q_b_out = 0 OR c_has_q_b_out = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_q_b_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_ovfl = 0 OR c_has_ovfl = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_ovfl (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_q_ovfl = 0 OR c_has_q_ovfl = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_q_ovfl (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_ce = 0 OR c_has_ce = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_ce (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_bypass = 0 OR c_has_bypass = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_bypass (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT enum_c_b_type /= NUM_PIN
      REPORT "ERROR - accum: Use of the B_SIGNED pin is deprecated as of baseblox_v8_0"
      SEVERITY FAILURE;
    ASSERT c_has_b_signed = 0
      REPORT "ERROR - accum: c_has_b_signed deprecated as of baseblox_v8_0"
      SEVERITY FAILURE;
    ASSERT c_has_aclr = 0 OR c_has_aclr = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_aclr (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_aset = 0 OR c_has_aset = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_aset (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_ainit = 0 OR c_has_ainit = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_ainit (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_sclr = 0 OR c_has_sclr = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_sclr (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_sset = 0 OR c_has_sset = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_sset (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_sinit = 0 OR c_has_sinit = 1
      REPORT "ERROR - accum: Invalid value in generic c_has_sinit (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT c_has_bypass_with_cin = 0
      REPORT "ERROR - accum: c_has_sinit deprecated as of baseblox_v8_0"
      SEVERITY FAILURE;
    ASSERT c_enable_rlocs = 0
      REPORT "WARNING - accum: RLOCS no longer supported, will ignore user request"
      SEVERITY WARNING;

    -- Less straightforward checks
    ASSERT (c_has_add = 1) = (enum_c_add_mode = MODE_ADDSUB)
      REPORT "ERROR - accum: Add pin is required if and only if c_add_mode = c_add_sub"
      SEVERITY FAILURE;
    ASSERT c_b_width <= c_out_width
      REPORT "ERROR - accum: Port B cannot be wider than output"
      SEVERITY FAILURE;
    ASSERT enum_c_b_type = NUM_SIGNED OR (c_has_ovfl = 0 AND c_has_q_ovfl = 0)
      REPORT "ERROR - accum: Overflow outputs are only supported when the accumulator output is signed"
      SEVERITY FAILURE;
    ASSERT enum_c_b_type = NUM_UNSIGNED OR (c_has_c_out = 0 AND c_has_q_c_out = 0
                                        AND c_has_b_out = 0 AND c_has_q_b_out = 0)
      REPORT "ERROR - accum: Carry/borrow outputs are only supported when the accumulator output is unsigned"
      SEVERITY FAILURE;
    ASSERT c_has_c_in = 0 OR enum_c_add_mode /= MODE_SUB
      REPORT "ERROR - accum: c_in (carry in) is prohibited for subtractor-based accumulators; perhaps you wanted b_in?"
      SEVERITY FAILURE;
    ASSERT (c_has_c_out = 0 AND c_has_q_c_out = 0) OR enum_c_add_mode /= MODE_SUB
      REPORT "ERROR - accum: Carry out (c_out or q_c_out) is prohibited for subtractor-based accumulators; perhaps you wanted borrow out (b_out or q_b_out)?"
      SEVERITY FAILURE;
    ASSERT c_has_b_in = 0 OR enum_c_add_mode = MODE_SUB
      REPORT "ERROR - accum: b_in (borrow in) is prohibited unless c_add_mode = c_sub; perhaps you wanted c_in?"
      SEVERITY FAILURE;
    ASSERT (c_has_b_out = 0 AND c_has_q_b_out = 0) OR enum_c_add_mode = MODE_SUB
      REPORT "ERROR - accum: Borrow out (b_out or q_b_out) is prohibited unless c_add_mode = c_sub; perhaps you wanted carry out (c_out or q_c_out)?"
      SEVERITY FAILURE;
    IF c_scale /= 0 AND c_b_width < c_out_width THEN
      -- The adder at the centre has bit growth, so carry out/borrow out/overflow are
      -- all a bit pointless. Warn the user about this.
      -- deal with overflow
      ASSERT c_has_ovfl = 0 AND c_has_q_ovfl = 0
        REPORT "WARNING - accum: Overflow will never occur in this accumulator"
        SEVERITY WARNING;
      -- deal with carry and borrow out
      IF enum_c_add_mode = MODE_ADD THEN
        ASSERT c_has_c_out = 0 AND c_has_q_c_out = 0
          REPORT "WARNING - accum: Carry out will never be active for this accumulator"
          SEVERITY WARNING;
      ELSIF enum_c_add_mode = MODE_SUB THEN
        ASSERT c_has_b_out = 0 AND c_has_q_b_out = 0
          REPORT "WARNING - accum: Borrow out outputs are redundant; they will always equal the MSB of the output"
          SEVERITY WARNING;
      ELSIF enum_c_add_mode = MODE_ADDSUB THEN
        -- slightly more complex; since the ADD pin is another bit of input to the ADDSUB
        IF c_b_width < c_out_width - 1 THEN
          ASSERT c_has_c_out = 0 AND c_has_q_c_out = 0
            REPORT "WARNING - accum: c_out is redundant; in ADD mode, it will always be 0, and in SUB mode, it will always equal the MSB of the output"
            SEVERITY WARNING;
        END IF;
      END IF;
    END IF;
    ASSERT c_pipe_stages = 1 OR c_pipe_stages = 0 -- since the default value seems to be 0
      REPORT "ERROR - accum: Pipelining not implemented."
      SEVERITY FAILURE;
    ASSERT c_has_ainit = 0 OR (c_has_aclr = 0 AND c_has_aset = 0)
      REPORT "ERROR - accum: ainit is mutually exclusive with aclr or aset"
      SEVERITY FAILURE;
    ASSERT c_has_sinit = 0 OR (c_has_sclr = 0 AND c_has_sset = 0)
      REPORT "ERROR - accum: sinit is mutually exclusive with sclr or sset"
      SEVERITY FAILURE;
    RETURN 0;
  END check_generics;

  -- The following line should make sure that check_generics
  -- is called on instantiation
  CONSTANT check_gens : INTEGER := check_generics;

-------------------------------------------------------------------------------
-- code copied from hdl ends here.
-------------------------------------------------------------------------------

  
  CONSTANT timeunit : TIME := 1 NS;

  -- signals for optional pins...

  SIGNAL intS             : STD_LOGIC_VECTOR(C_OUT_WIDTH-1 DOWNTO 0);
  SIGNAL intFB            : STD_LOGIC_VECTOR(C_OUT_WIDTH-1 DOWNTO 0);
  SIGNAL intFBq           : STD_LOGIC_VECTOR(C_OUT_WIDTH-1 DOWNTO 0);
  SIGNAL intB_SIGNED      : STD_LOGIC;
  SIGNAL intC_OUT         : STD_LOGIC;
  SIGNAL intB_OUT         : STD_LOGIC;
  SIGNAL intSCLR          : STD_LOGIC;
  SIGNAL intSSET          : STD_LOGIC;
  SIGNAL intSCLR_TO_ADDER : STD_LOGIC;
  SIGNAL intSSET_TO_ADDER : STD_LOGIC;
  SIGNAL intSCLR_TO_MSB   : STD_LOGIC;
  SIGNAL intSSET_TO_MSB   : STD_LOGIC;
  SIGNAL intSCLR_TO_REST  : STD_LOGIC;
  SIGNAL intSSET_TO_REST  : STD_LOGIC;
  SIGNAL intSCLRbase      : STD_LOGIC;
  SIGNAL intSSETbase      : STD_LOGIC;
  SIGNAL intCE            : STD_LOGIC;
  SIGNAL intB             : STD_LOGIC;
  SIGNAL tempCE           : STD_LOGIC;
  SIGNAL tmpB             : STD_LOGIC_VECTOR(C_B_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');

  -- pipelining signals

  FUNCTION getAType(C_TYPE : INTEGER) RETURN INTEGER IS
  BEGIN
    IF C_TYPE = c_pin THEN
      RETURN c_signed;
    ELSE
      RETURN C_TYPE;
    END IF;
  END getAType;


  FUNCTION setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (C_SATURATE = 1 AND (C_HAS_CE = 1 AND (C_HAS_SSET = 1 OR C_HAS_SCLR = 1 ) AND C_SYNC_ENABLE = 0)) THEN
      RETURN 1;
    ELSE
      RETURN C_SYNC_ENABLE;
    END IF;
  END setSyncEnable;
  
  
BEGIN

  -- Deal with optional pins...
  bs1 : IF C_HAS_B_SIGNED = 1 GENERATE
    intB_SIGNED <= B_SIGNED;
  END GENERATE;
  bs0 : IF NOT (C_HAS_B_SIGNED = 1) GENERATE
    intB_SIGNED <= '0';
  END GENERATE;

  sclr1 : IF C_HAS_SCLR = 1 GENERATE
    intSCLR <= SCLR;
  END GENERATE;
  sclr0 : IF NOT(C_HAS_SCLR = 1) GENERATE
    intSCLR <= '0';
  END GENERATE;

  ss1 : IF C_HAS_SSET = 1 GENERATE
    intSSET <= SSET;
  END GENERATE;
  ss0 : IF NOT(C_HAS_SSET = 1) GENERATE
    intSSET <= '0';
  END GENERATE;

  strconvconst1 : IF C_B_CONSTANT = 1 GENERATE
    tmpB <= str_to_bound_slv_0(C_B_VALUE, C_B_WIDTH);
  END GENERATE;

  strconvconst0 : IF NOT (C_B_CONSTANT = 1) GENERATE
    tmpB <= B;
  END GENERATE;

  -- Deal with the saturation logic. 
  -- The adder ALWAYS has SCLR and SSET inputs and C_OUT and B_OUT outputs.
  -- The correct values must be placed on the inputs depending on the
  -- Saturation setting and the availability of those signals from outside.
  sat0 : IF NOT(C_SATURATE = 1) GENERATE
    -- Instanciate an addsub module
    addsub : c_addsub_v8_0
      GENERIC MAP (
        C_A_WIDTH             => C_OUT_WIDTH,
        C_B_WIDTH             => C_B_WIDTH,
        C_OUT_WIDTH           => C_OUT_WIDTH,
        C_LOW_BIT             => 0,
        C_HIGH_BIT            => C_OUT_WIDTH-1,
        C_ADD_MODE            => C_ADD_MODE,
        C_A_TYPE              => getAType(C_B_TYPE),
        C_B_TYPE              => C_B_TYPE,
        C_B_CONSTANT          => C_B_CONSTANT,
        C_B_VALUE             => C_B_VALUE,
        C_AINIT_VAL           => C_AINIT_VAL,
        C_SINIT_VAL           => C_SINIT_VAL,
        C_BYPASS_ENABLE       => C_BYPASS_ENABLE,
        C_BYPASS_LOW          => C_BYPASS_LOW,
        C_SYNC_ENABLE         => C_SYNC_ENABLE,
        C_SYNC_PRIORITY       => C_SYNC_PRIORITY,
        C_PIPE_STAGES         => C_PIPE_STAGES,
        C_HAS_S               => C_HAS_S,
        C_HAS_Q               => 1,
        C_HAS_C_IN            => C_HAS_C_IN,
        C_HAS_C_OUT           => C_HAS_C_OUT,
        C_HAS_Q_C_OUT         => C_HAS_Q_C_OUT,
        C_HAS_B_IN            => C_HAS_B_IN,
        C_HAS_B_OUT           => C_HAS_B_OUT,
        C_HAS_Q_B_OUT         => C_HAS_Q_B_OUT,
        C_HAS_OVFL            => C_HAS_OVFL,
        C_HAS_Q_OVFL          => C_HAS_Q_OVFL,
        C_HAS_CE              => C_HAS_CE,
        C_HAS_ADD             => C_HAS_ADD,
        C_HAS_BYPASS          => C_HAS_BYPASS,
        C_HAS_A_SIGNED        => C_HAS_B_SIGNED,
        C_HAS_B_SIGNED        => C_HAS_B_SIGNED,
        C_HAS_ACLR            => C_HAS_ACLR,
        C_HAS_ASET            => C_HAS_ASET,
        C_HAS_AINIT           => C_HAS_AINIT,
        C_HAS_SCLR            => C_HAS_SCLR,
        C_HAS_SSET            => C_HAS_SSET,
        C_HAS_SINIT           => C_HAS_SINIT,
        C_HAS_BYPASS_WITH_CIN => C_HAS_BYPASS_WITH_CIN,
        C_ENABLE_RLOCS        => C_ENABLE_RLOCS
        )
      PORT MAP (
        A        => intFB,
        B        => B,
        CLK      => CLK,
        ADD      => ADD,
        C_IN     => C_IN,
        B_IN     => B_IN,
        CE       => CE,
        BYPASS   => BYPASS,
        ACLR     => ACLR,
        ASET     => ASET,
        AINIT    => AINIT,
        SCLR     => SCLR,
        SSET     => SSET,
        SINIT    => SINIT,
        A_SIGNED => B_SIGNED,
        B_SIGNED => B_SIGNED,
        OVFL     => OVFL,
        C_OUT    => intC_OUT,
        B_OUT    => intB_OUT,
        Q_OVFL   => Q_OVFL,
        Q_C_OUT  => Q_C_OUT,
        Q_B_OUT  => Q_B_OUT,
        S        => intS,
        Q        => intFBq
        );
  END GENERATE;  -- sat0

  sat1 : IF C_SATURATE = 1 GENERATE     -- We DO want saturation logic
    unsinsat1 : IF C_B_TYPE = c_unsigned AND C_ADD_MODE = c_add GENERATE  -- Unsigned adder
      sata : IF NOT(C_HAS_SSET = 1) AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intC_OUT;
        intSCLR_TO_ADDER <= intSCLR;
      END GENERATE;
      satb : IF NOT(C_HAS_SSET = 1) AND C_HAS_SCLR = 1 GENERATE
        intSSET_TO_ADDER <= intC_OUT AND NOT(intSCLR);
        intSCLR_TO_ADDER <= intSCLR;
      END GENERATE;
      satc : IF C_HAS_SSET = 1 AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intC_OUT OR intSSET;
        intSCLR_TO_ADDER <= intSCLR;
      END GENERATE;
      satd : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
        intSSET_TO_ADDER <= NOT(intSCLR) AND (intC_OUT OR intSSET);
        intSCLR_TO_ADDER <= intSCLR;
      END GENERATE;
      sate : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
        intSSET_TO_ADDER <= intSSET OR (intC_OUT AND NOT(intSCLR));
        intSCLR_TO_ADDER <= intSCLR AND NOT(intSSET);
      END GENERATE;
    END GENERATE;  -- unsinsat1
    unsinsat2 : IF C_B_TYPE = c_unsigned AND C_ADD_MODE = c_sub AND (C_HAS_BYPASS = 0) GENERATE  -- Unsigned adder
      sata : IF NOT(C_HAS_SSET = 1) AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= NOT(intB_OUT);
      END GENERATE;
      satb : IF NOT(C_HAS_SSET = 1) AND C_HAS_SCLR = 1 GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= NOT(intB_OUT) OR intSCLR;
      END GENERATE;
      satc : IF C_HAS_SSET = 1 AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= NOT(intB_OUT) AND NOT(intSSET);
      END GENERATE;
      satd : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
        intSSET_TO_ADDER <= intSSET AND NOT(intSCLR);
        intSCLR_TO_ADDER <= intSCLR OR (NOT(intB_OUT) AND NOT(intSSET));
      END GENERATE;
      sate : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT intSSET) AND (intSCLR OR NOT(intB_OUT));
      END GENERATE;
    END GENERATE;  -- unsinsat2
    unsinsat2a : IF C_B_TYPE = c_unsigned AND C_ADD_MODE = c_sub AND (C_HAS_BYPASS = 1 AND C_BYPASS_LOW = 1) GENERATE  -- Unsigned adder
      sata : IF NOT(C_HAS_SSET = 1) AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT(intB_OUT) AND BYPASS);
      END GENERATE;
      satb : IF NOT(C_HAS_SSET = 1) AND C_HAS_SCLR = 1 GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT(intB_OUT) AND BYPASS)OR intSCLR;
      END GENERATE;
      satc : IF C_HAS_SSET = 1 AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT(intB_OUT) AND BYPASS) AND NOT(intSSET);
      END GENERATE;
      satd : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
        intSSET_TO_ADDER <= intSSET AND NOT(intSCLR);
        intSCLR_TO_ADDER <= intSCLR OR ((NOT(intB_OUT) AND BYPASS) AND NOT(intSSET));
      END GENERATE;
      sate : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT intSSET) AND (intSCLR OR (NOT(intB_OUT) AND BYPASS));
      END GENERATE;
    END GENERATE;  -- unsinsat2a
    unsinsat2b : IF C_B_TYPE = c_unsigned AND C_ADD_MODE = c_sub AND (C_HAS_BYPASS = 1 AND C_BYPASS_LOW = 0) GENERATE  -- Unsigned adder
      sata : IF NOT(C_HAS_SSET = 1) AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT(intB_OUT) AND NOT(BYPASS));
      END GENERATE;
      satb : IF NOT(C_HAS_SSET = 1) AND C_HAS_SCLR = 1 GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT(intB_OUT) AND NOT(BYPASS))OR intSCLR;
      END GENERATE;
      satc : IF C_HAS_SSET = 1 AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT(intB_OUT) AND NOT(BYPASS)) AND NOT(intSSET);
      END GENERATE;
      satd : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
        intSSET_TO_ADDER <= intSSET AND NOT(intSCLR);
        intSCLR_TO_ADDER <= intSCLR OR ((NOT(intB_OUT) AND NOT(BYPASS)) AND NOT(intSSET));
      END GENERATE;
      sate : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (NOT intSSET) AND (intSCLR OR (NOT(intB_OUT) AND NOT(BYPASS)));
      END GENERATE;
    END GENERATE;  -- unsinsat2b
    unsinsat3 : IF C_B_TYPE = c_unsigned AND C_ADD_MODE = c_add_sub AND (C_HAS_BYPASS = 0) GENERATE  -- Unsigned adder
      sata : IF NOT(C_HAS_SSET = 1) AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intC_OUT AND ADD;
        intSCLR_TO_ADDER <= (NOT(intC_OUT) AND NOT(ADD));
      END GENERATE;
      satb : IF NOT(C_HAS_SSET = 1) AND C_HAS_SCLR = 1 GENERATE
        intSSET_TO_ADDER <= intC_OUT AND NOT(intSCLR) AND ADD;
        intSCLR_TO_ADDER <= intSCLR OR (NOT(intC_OUT) AND NOT(ADD));
      END GENERATE;
      satc : IF C_HAS_SSET = 1 AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= (intC_OUT AND ADD) OR intSSET;
        intSCLR_TO_ADDER <= NOT(intSSET) AND (NOT(intC_OUT) AND NOT(ADD));
      END GENERATE;
      satd : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
        intSSET_TO_ADDER <= (NOT(intSCLR) AND intC_OUT AND ADD) OR (intSSET AND NOT(intSCLR));
        intSCLR_TO_ADDER <= intSCLR OR (NOT(intSSET) AND NOT(intC_OUT) AND NOT(ADD));
      END GENERATE;
      sate : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
        intSSET_TO_ADDER <= intSSET OR (intC_OUT AND ADD AND NOT(intSCLR));
        intSCLR_TO_ADDER <= (intSCLR AND NOT(intSSET)) OR (NOT(intSSET) AND NOT(intC_OUT) AND NOT(ADD));
      END GENERATE;
    END GENERATE;  -- unsinsat3

    unsinsat4 : IF C_B_TYPE = c_unsigned AND C_ADD_MODE = c_add_sub AND (C_HAS_BYPASS = 1 AND (C_BYPASS_LOW = 1)) GENERATE  -- Unsigned adder
      sata : IF NOT(C_HAS_SSET = 1) AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intC_OUT AND ADD;
        intSCLR_TO_ADDER <= (NOT(intC_OUT) AND NOT(ADD) AND BYPASS);
      END GENERATE;
      satb : IF NOT(C_HAS_SSET = 1) AND C_HAS_SCLR = 1 GENERATE
        intSSET_TO_ADDER <= intC_OUT AND NOT(intSCLR) AND ADD;
        intSCLR_TO_ADDER <= intSCLR OR (NOT(intC_OUT) AND NOT(ADD) AND BYPASS);
      END GENERATE;
      satc : IF C_HAS_SSET = 1 AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= (intC_OUT AND ADD) OR intSSET;
        intSCLR_TO_ADDER <= NOT(intSSET) AND (NOT(intC_OUT) AND NOT(ADD) AND BYPASS);
      END GENERATE;
      satd : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
        intSSET_TO_ADDER <= (NOT(intSCLR) AND intC_OUT AND ADD) OR (intSSET AND NOT(intSCLR));
        intSCLR_TO_ADDER <= intSCLR OR (NOT(intSSET) AND NOT(intC_OUT) AND NOT(ADD) AND BYPASS);
      END GENERATE;
      sate : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
        intSSET_TO_ADDER <= intSSET OR (intC_OUT AND ADD AND NOT(intSCLR));
        intSCLR_TO_ADDER <= (intSCLR AND NOT(intSSET)) OR (NOT(intSSET) AND NOT(intC_OUT) AND NOT(ADD) AND BYPASS);
      END GENERATE;
    END GENERATE;  -- unsinsat4

    unsinsat5 : IF C_B_TYPE = c_unsigned AND C_ADD_MODE = c_add_sub AND (C_HAS_BYPASS = 1 AND (C_BYPASS_LOW = 0)) GENERATE  -- Unsigned adder
      sata : IF NOT(C_HAS_SSET = 1) AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= intC_OUT AND ADD;
        intSCLR_TO_ADDER <= (NOT(intC_OUT) AND NOT(ADD) AND NOT(BYPASS));
      END GENERATE;
      satb : IF NOT(C_HAS_SSET = 1) AND C_HAS_SCLR = 1 GENERATE
        intSSET_TO_ADDER <= intC_OUT AND NOT(intSCLR) AND ADD;
        intSCLR_TO_ADDER <= intSCLR OR (NOT(intC_OUT) AND NOT(ADD) AND NOT(BYPASS));
      END GENERATE;
      satc : IF C_HAS_SSET = 1 AND NOT(C_HAS_SCLR = 1) GENERATE
        intSSET_TO_ADDER <= (intC_OUT AND ADD) OR intSSET;
        intSCLR_TO_ADDER <= NOT(intSSET) AND (NOT(intC_OUT) AND NOT(ADD) AND NOT(BYPASS));
      END GENERATE;
      satd : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
        intSSET_TO_ADDER <= (NOT(intSCLR) AND intC_OUT AND ADD) OR (intSSET AND NOT(intSCLR));
        intSCLR_TO_ADDER <= intSCLR OR (NOT(intSSET) AND NOT(intC_OUT) AND NOT(ADD) AND NOT(BYPASS));
      END GENERATE;
      sate : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
        intSSET_TO_ADDER <= intSSET OR (intC_OUT AND ADD AND NOT(intSCLR));
        intSCLR_TO_ADDER <= (intSCLR AND NOT(intSSET)) OR (NOT(intSSET) AND NOT(intC_OUT) AND NOT(ADD) AND NOT(BYPASS));
      END GENERATE;
    END GENERATE;  -- unsinsat5


    satcegen : IF (C_HAS_CE = 1 AND (C_HAS_SSET = 1 OR C_HAS_SCLR = 1 ) AND C_SYNC_ENABLE = 0) GENERATE
      tempCE <= CE OR intSSET OR intSCLR;
      --        tempSyncEnable := 1;
    END GENERATE;
    nosatcegen : IF (NOT(C_HAS_CE = 1 AND (C_HAS_SSET = 1 OR C_HAS_SCLR = 1 ) AND C_SYNC_ENABLE = 0)) GENERATE
      tempCE <= CE;
      --        tempSyncEnable := C_SYNC_ENABLE;
    END GENERATE;



    unsinsatadder : IF C_B_TYPE = c_unsigned GENERATE
      -- Instanciate an addsub module
      addsub : c_addsub_v8_0
        GENERIC MAP (
          C_A_WIDTH             => C_OUT_WIDTH,
          C_B_WIDTH             => C_B_WIDTH,
          C_OUT_WIDTH           => C_OUT_WIDTH,
          C_LOW_BIT             => 0,
          C_HIGH_BIT            => C_OUT_WIDTH-1,
          C_ADD_MODE            => C_ADD_MODE,
          C_A_TYPE              => C_B_TYPE,
          C_B_TYPE              => C_B_TYPE,
          C_B_CONSTANT          => C_B_CONSTANT,
          C_B_VALUE             => C_B_VALUE,
          C_AINIT_VAL           => "",
          C_SINIT_VAL           => "",
          C_BYPASS_ENABLE       => C_BYPASS_ENABLE,
          C_BYPASS_LOW          => C_BYPASS_LOW,
          C_SYNC_ENABLE         => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
          C_SYNC_PRIORITY       => C_SYNC_PRIORITY,
          C_PIPE_STAGES         => C_PIPE_STAGES,
          C_HAS_S               => C_HAS_S,
          C_HAS_Q               => 1,
          C_HAS_C_IN            => C_HAS_C_IN,
          C_HAS_C_OUT           => 1,
          C_HAS_Q_C_OUT         => C_HAS_Q_C_OUT,
          C_HAS_B_IN            => C_HAS_B_IN,
          C_HAS_B_OUT           => 1,
          C_HAS_Q_B_OUT         => C_HAS_Q_B_OUT,
          C_HAS_OVFL            => C_HAS_OVFL,
          C_HAS_Q_OVFL          => C_HAS_Q_OVFL,
          C_HAS_CE              => C_HAS_CE,
          C_HAS_ADD             => C_HAS_ADD,
          C_HAS_BYPASS          => C_HAS_BYPASS,
          C_HAS_A_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_B_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_ACLR            => 0,
          C_HAS_ASET            => 0,
          C_HAS_AINIT           => 0,
          C_HAS_SCLR            => 1,
          C_HAS_SSET            => 1,
          C_HAS_SINIT           => 0,
          C_HAS_BYPASS_WITH_CIN => C_HAS_BYPASS_WITH_CIN,
          C_ENABLE_RLOCS        => C_ENABLE_RLOCS
          )
        PORT MAP (
          A        => intFB,
          B        => B,
          CLK      => CLK,
          ADD      => ADD,
          C_IN     => C_IN,
          B_IN     => B_IN,
          CE       => tempCE,
          BYPASS   => BYPASS,
          ACLR     => ACLR,
          ASET     => ASET,
          AINIT    => AINIT,
          SCLR     => intSCLR_TO_ADDER,
          SSET     => intSSET_TO_ADDER,
          SINIT    => SINIT,
          A_SIGNED => B_SIGNED,
          B_SIGNED => B_SIGNED,
          OVFL     => OVFL,
          C_OUT    => intC_OUT,
          B_OUT    => intB_OUT,
          Q_OVFL   => Q_OVFL,
          Q_C_OUT  => Q_C_OUT,
          Q_B_OUT  => Q_B_OUT,
          S        => intS,
          Q        => intFBq
          );
    END GENERATE;  -- unsinsatadder
    sinsat1 : IF C_B_TYPE = c_signed OR C_B_TYPE = c_pin GENERATE  -- signed accum wanted - we need to pull the register out of the adder to get at the 
                                                                   -- MSB register which has different control to the rest

      -- Instanciate an addsub module
      addsub : c_addsub_v8_0
        GENERIC MAP (
          C_A_WIDTH             => C_OUT_WIDTH,
          C_B_WIDTH             => C_B_WIDTH,
          C_OUT_WIDTH           => C_OUT_WIDTH,
          C_LOW_BIT             => 0,
          C_HIGH_BIT            => C_OUT_WIDTH-1,
          C_ADD_MODE            => C_ADD_MODE,
          C_A_TYPE              => C_B_TYPE,
          C_B_TYPE              => C_B_TYPE,
          C_B_CONSTANT          => C_B_CONSTANT,
          C_B_VALUE             => C_B_VALUE,
          C_AINIT_VAL           => "",
          C_SINIT_VAL           => "",
          C_BYPASS_ENABLE       => C_BYPASS_ENABLE,
          C_BYPASS_LOW          => C_BYPASS_LOW,
          C_SYNC_ENABLE         => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
          C_SYNC_PRIORITY       => C_SYNC_PRIORITY,
          C_PIPE_STAGES         => C_PIPE_STAGES,
          C_HAS_S               => 1,
          C_HAS_Q               => 0,
          C_HAS_C_IN            => C_HAS_C_IN,
          C_HAS_C_OUT           => 1,
          C_HAS_Q_C_OUT         => C_HAS_Q_C_OUT,
          C_HAS_B_IN            => C_HAS_B_IN,
          C_HAS_B_OUT           => 1,
          C_HAS_Q_B_OUT         => C_HAS_Q_B_OUT,
          C_HAS_OVFL            => C_HAS_OVFL,
          C_HAS_Q_OVFL          => C_HAS_Q_OVFL,
          C_HAS_CE              => C_HAS_CE,
          C_HAS_ADD             => C_HAS_ADD,
          C_HAS_BYPASS          => C_HAS_BYPASS,
          C_HAS_A_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_B_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_ACLR            => C_HAS_ACLR,
          C_HAS_ASET            => C_HAS_ASET,
          C_HAS_AINIT           => 0,
          C_HAS_SCLR            => C_HAS_SCLR,
          C_HAS_SSET            => C_HAS_SSET,
          C_HAS_SINIT           => 0,
          C_HAS_BYPASS_WITH_CIN => C_HAS_BYPASS_WITH_CIN,
          C_ENABLE_RLOCS        => C_ENABLE_RLOCS
          )
        PORT MAP (
          A        => intFB,
          B        => B,
          CLK      => CLK,
          ADD      => ADD,
          C_IN     => C_IN,
          B_IN     => B_IN,
          CE       => tempCE,
          BYPASS   => BYPASS,
          ACLR     => ACLR,
          ASET     => ASET,
          AINIT    => AINIT,
          SCLR     => SCLR,
          SSET     => SSET,
          SINIT    => SINIT,
          A_SIGNED => B_SIGNED,
          B_SIGNED => B_SIGNED,
          OVFL     => OVFL,
          C_OUT    => intC_OUT,
          B_OUT    => intB_OUT,
          Q_OVFL   => Q_OVFL,
          Q_C_OUT  => Q_C_OUT,
          Q_B_OUT  => Q_B_OUT,
          S        => intS
          );

      -- A single bit register for the MSB
      msb_reg : C_REG_FD_V8_0
        GENERIC MAP(
          C_WIDTH         => 1,
          C_AINIT_VAL     => "",
          C_SINIT_VAL     => "",
          C_SYNC_ENABLE   => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
          C_HAS_CE        => C_HAS_CE,
          C_HAS_ACLR      => 0,
          C_HAS_ASET      => 0,
          C_HAS_AINIT     => 0,
          C_HAS_SCLR      => 1,
          C_HAS_SSET      => 1,
          C_HAS_SINIT     => 0,
          C_ENABLE_RLOCS  => C_ENABLE_RLOCS
          )
        PORT MAP(
          D(0)  => intS(C_OUT_WIDTH-1),
          CLK   => CLK,
          CE    => intCE,
          ACLR  => ACLR,
          ASET  => ASET,
          AINIT => AINIT,
          SCLR  => intSCLR_TO_MSB,
          SSET  => intSSET_TO_MSB,
          SINIT => SINIT,
          Q(0)  => intFBq(C_OUT_WIDTH-1)
          );


      -- A register for lower bits
      cbwidthgt1 : IF C_B_WIDTH > 1 GENERATE
        rest_reg : C_REG_FD_V8_0
          GENERIC MAP(
            C_WIDTH         => C_OUT_WIDTH-1,
            C_AINIT_VAL     => "",
            C_SINIT_VAL     => "",
            C_SYNC_ENABLE   => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
            C_SYNC_PRIORITY => C_SYNC_PRIORITY,
            C_HAS_CE        => C_HAS_CE,
            C_HAS_ACLR      => 0,
            C_HAS_ASET      => 0,
            C_HAS_AINIT     => 0,
            C_HAS_SCLR      => 1,
            C_HAS_SSET      => 1,
            C_HAS_SINIT     => 0,
            C_ENABLE_RLOCS  => C_ENABLE_RLOCS
            )
          PORT MAP(
            D     => intS(C_OUT_WIDTH-2 DOWNTO 0),
            CLK   => CLK,
            CE    => intCE,
            ACLR  => ACLR,
            ASET  => ASET,
            AINIT => AINIT,
            SCLR  => intSCLR_TO_REST,
            SSET  => intSSET_TO_REST,
            SINIT => SINIT,
            Q     => intFBq(C_OUT_WIDTH-2 DOWNTO 0)
            );
      END GENERATE;

      s1 : IF C_B_CONSTANT = 1 GENERATE
        intB <= tmpB(C_B_WIDTH-1);
      END GENERATE;
      s3 : IF C_B_CONSTANT = 0 GENERATE
        intB <= B(C_B_WIDTH-1);
      END GENERATE;


      bissigned : IF C_B_TYPE = c_signed GENERATE
        satadd : IF C_ADD_MODE = c_add GENERATE
          sata : intSCLRbase <= intS(C_HIGH_BIT) AND NOT(intFBq(C_HIGH_BIT)) AND NOT(intB);
          satb : intSSETbase <= NOT(intS(C_HIGH_BIT)) AND intFBq(C_HIGH_BIT) AND intB;
        END GENERATE;
        satsub : IF C_ADD_MODE = c_sub GENERATE
          satc : intSCLRbase <= intS(C_HIGH_BIT) AND NOT(intFBq(C_HIGH_BIT)) AND intB;
          satd : intSSETbase <= NOT(intS(C_HIGH_BIT)) AND intFBq(C_HIGH_BIT) AND NOT(intB);  --was not(intB) ;
        END GENERATE;
        satads : IF C_ADD_MODE = c_add_sub GENERATE
          sate : intSCLRbase <= (NOT(ADD) AND intS(C_HIGH_BIT) AND NOT(intFBq(C_HIGH_BIT)) AND intB) OR (ADD AND intS(C_HIGH_BIT) AND NOT(intFBq(C_HIGH_BIT)) AND NOT(intB));
          satf : intSSETbase <= (NOT(ADD) AND NOT(intS(C_HIGH_BIT)) AND intFBq(C_HIGH_BIT) AND NOT(intB)) OR (ADD AND NOT(intS(C_HIGH_BIT)) AND intFBq(C_HIGH_BIT) AND intB);
        END GENERATE;
      END GENERATE;
      bispin : IF C_B_TYPE = c_pin GENERATE
        satadd : IF C_ADD_MODE = c_add GENERATE
          sata : intSCLRbase <= (NOT(intB_SIGNED) AND NOT(intFBq(C_HIGH_BIT)) AND intS(C_HIGH_BIT)) OR (intB_SIGNED AND NOT(intFBq(C_HIGH_BIT)) AND intS(C_HIGH_BIT) AND NOT(intB));
          satb : intSSETbase <= intB_SIGNED AND intFBq(C_HIGH_BIT) AND NOT(intS(C_HIGH_BIT)) AND intB;
        END GENERATE;
        satsub : IF C_ADD_MODE = c_sub GENERATE
          satc : intSCLRbase <= intB_SIGNED AND NOT(intFBq(C_HIGH_BIT)) AND intS(C_HIGH_BIT) AND intB;
          satd : intSSETbase <= (NOT(intB_SIGNED) AND intFBq(C_HIGH_BIT) AND NOT(intS(C_HIGH_BIT))) OR (intB_SIGNED AND intFBq(C_HIGH_BIT) AND NOT(intS(C_HIGH_BIT)) AND NOT(intB));
        END GENERATE;
        satads : IF C_ADD_MODE = c_add_sub GENERATE
          sate : intSCLRbase <= (NOT(ADD) AND intB_SIGNED AND NOT(intFBq(C_HIGH_BIT)) AND intS(C_HIGH_BIT) AND intB)
                                OR (ADD AND ((NOT(intB_SIGNED) AND NOT(intFBq(C_HIGH_BIT)) AND intS(C_HIGH_BIT))
                                             OR (intB_SIGNED AND NOT(intFBq(C_HIGH_BIT)) AND intS(C_HIGH_BIT) AND NOT(intB))));
          satf : intSSETbase <= (NOT(ADD) AND ((NOT(intB_SIGNED) AND intFBq(C_HIGH_BIT) AND NOT(intS(C_HIGH_BIT)))
                                               OR (intB_SIGNED AND intFBq(C_HIGH_BIT) AND NOT(intS(C_HIGH_BIT)) AND NOT(intB)))) 
                                OR (ADD AND intB_SIGNED AND intFBq(C_HIGH_BIT) AND NOT(intS(C_HIGH_BIT)) AND intB);
        END GENERATE;
      END GENERATE;

      bplow : IF (C_HAS_BYPASS = 1) AND (C_BYPASS_LOW = 1) GENERATE
        byce : IF (C_BYPASS_ENABLE = c_override) GENERATE
          intCE <= (NOT BYPASS) OR tempCE;
        END GENERATE;
        bycn : IF (C_BYPASS_ENABLE = c_no_override) GENERATE
          intCE <= tempCE;
        END GENERATE;
        satg : IF (C_HAS_SSET = 0) AND (C_HAS_SCLR = 0) GENERATE
          intSCLR_TO_MSB  <= intSCLRbase AND BYPASS;
          intSSET_TO_MSB  <= intSSETbase AND BYPASS;
          intSCLR_TO_REST <= intSSET_TO_MSB;
          intSSET_TO_REST <= intSCLR_TO_MSB;
        END GENERATE;
        sath : IF (C_HAS_SSET = 0) AND (C_HAS_SCLR = 1) GENERATE
          intSCLR_TO_MSB  <= (intSCLRbase AND BYPASS) OR SCLR;
          intSSET_TO_MSB  <= (intSSETbase AND BYPASS) AND NOT(SCLR);
          intSCLR_TO_REST <= (intSSETbase AND BYPASS) OR SCLR;
          intSSET_TO_REST <= (intSCLRbase AND BYPASS) AND NOT(SCLR);
        END GENERATE;
        sati : IF (C_HAS_SSET = 1) AND (C_HAS_SCLR = 0) GENERATE
          intSCLR_TO_MSB  <= (intSCLRbase AND BYPASS) AND NOT(SSET);
          intSSET_TO_MSB  <= (intSSETbase AND BYPASS) OR SSET;
          intSCLR_TO_REST <= (intSSETbase AND BYPASS) AND NOT (SSET);
          intSSET_TO_REST <= (intSCLRbase AND BYPASS) OR SSET;
        END GENERATE;
        satj : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
          intSCLR_TO_MSB  <= ((intSCLRbase AND NOT SSET) AND BYPASS) OR SCLR;
          intSSET_TO_MSB  <= ((intSSETbase AND BYPASS) OR SSET) AND NOT(SCLR);
          intSCLR_TO_REST <= ((intSSETbase AND BYPASS) AND NOT SSET) OR SCLR;
          intSSET_TO_REST <= ((intSCLRbase AND BYPASS) OR SSET) AND NOT(SCLR);
        END GENERATE;
        satk : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
          intSCLR_TO_MSB  <= ((intSCLRbase AND BYPASS) OR SCLR) AND NOT(SSET);
          intSSET_TO_MSB  <= ((intSSETbase AND NOT SCLR)AND BYPASS) OR SSET;
          intSCLR_TO_REST <= ((intSSETbase AND BYPASS) OR SCLR) AND NOT(SSET);
          intSSET_TO_REST <= (intSCLRbase AND BYPASS) OR SSET;
        END GENERATE;
      END GENERATE;
      bphigh : IF (C_HAS_BYPASS = 1) AND (C_BYPASS_LOW = 0) GENERATE
        byce : IF (C_BYPASS_ENABLE = c_override) GENERATE
          intCE <= BYPASS OR tempCE;
        END GENERATE;
        bycn : IF (C_BYPASS_ENABLE = c_no_override) GENERATE
          intCE <= tempCE;
        END GENERATE;
        satl : IF (C_HAS_SSET = 0) AND (C_HAS_SCLR = 0) GENERATE
          intSCLR_TO_MSB  <= intSCLRbase AND NOT(BYPASS);
          intSSET_TO_MSB  <= intSSETbase AND NOT(BYPASS);
          intSCLR_TO_REST <= intSSET_TO_MSB;
          intSSET_TO_REST <= intSCLR_TO_MSB;
        END GENERATE;
        satm : IF (C_HAS_SSET = 0) AND (C_HAS_SCLR = 1) GENERATE
          intSCLR_TO_MSB  <= (intSCLRbase AND NOT(BYPASS)) OR SCLR;
          intSSET_TO_MSB  <= (intSSETbase AND NOT(BYPASS)) AND NOT(SCLR);
          intSCLR_TO_REST <= (intSSETbase AND NOT(BYPASS)) OR SCLR;
          intSSET_TO_REST <= (intSCLRbase AND NOT(BYPASS)) AND NOT(SCLR);
        END GENERATE;
        satn : IF (C_HAS_SSET = 1) AND (C_HAS_SCLR = 0) GENERATE
          intSCLR_TO_MSB  <= (intSCLRbase AND NOT(BYPASS)) AND NOT(SSET);
          intSSET_TO_MSB  <= (intSSETbase AND NOT(BYPASS)) OR SSET;
          intSCLR_TO_REST <= (intSSETbase AND NOT(BYPASS)) AND NOT (SSET);
          intSSET_TO_REST <= (intSCLRbase AND NOT(BYPASS)) OR SSET;
        END GENERATE;
        sato : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
          intSCLR_TO_MSB  <= ((intSCLRbase AND NOT SSET) AND NOT(BYPASS)) OR SCLR;
          intSSET_TO_MSB  <= ((intSSETbase AND NOT(BYPASS)) OR SSET) AND NOT(SCLR);
          intSCLR_TO_REST <= ((intSSETbase AND NOT(BYPASS) AND NOT SSET)) OR SCLR;  -- added and not SSET)
          intSSET_TO_REST <= ((intSCLRbase AND NOT(BYPASS)) OR SSET) AND NOT(SCLR);
        END GENERATE;
        satp : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
          intSCLR_TO_MSB  <= ((intSCLRbase AND NOT(BYPASS)) OR SCLR) AND NOT(SSET);
          intSSET_TO_MSB  <= ((intSSETbase AND NOT SCLR)AND NOT(BYPASS) AND NOT SCLR) OR SSET;
          intSCLR_TO_REST <= ((intSSETbase AND NOT(BYPASS)) OR SCLR) AND NOT(SSET);
          intSSET_TO_REST <= (intSCLRbase AND NOT(BYPASS) AND NOT SCLR) OR SSET;
        END GENERATE;
      END GENERATE;
      bpnot : IF (C_HAS_BYPASS = 0) GENERATE
        byce : intCE <= tempCE;
        satq : IF (C_HAS_SSET = 0) AND (C_HAS_SCLR = 0) GENERATE
          intSCLR_TO_MSB  <= intSCLRbase;
          intSSET_TO_MSB  <= intSSETbase;
          intSCLR_TO_REST <= intSSET_TO_MSB;
          intSSET_TO_REST <= intSCLR_TO_MSB;
        END GENERATE;
        satr : IF (C_HAS_SSET = 0) AND (C_HAS_SCLR = 1) GENERATE
          intSCLR_TO_MSB  <= intSCLRbase OR SCLR;
          intSSET_TO_MSB  <= intSSETbase AND NOT(SCLR);
          intSCLR_TO_REST <= intSSETbase OR SCLR;
          intSSET_TO_REST <= intSCLRbase AND NOT(SCLR);
        END GENERATE;
        sats : IF (C_HAS_SSET = 1) AND (C_HAS_SCLR = 0) GENERATE
          intSCLR_TO_MSB  <= intSCLRbase AND NOT(SSET);
          intSSET_TO_MSB  <= intSSETbase OR SSET;
          intSCLR_TO_REST <= intSSETbase AND NOT (SSET);
          intSSET_TO_REST <= intSCLRbase OR SSET;
        END GENERATE;
        satt : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_clear GENERATE
          intSCLR_TO_MSB  <= (intSCLRbase AND NOT SSET) OR SCLR;
          intSSET_TO_MSB  <= (intSSETbase OR SSET) AND NOT(SCLR);
          intSCLR_TO_REST <= (intSSETbase AND NOT SSET) OR SCLR;
          intSSET_TO_REST <= (intSCLRbase OR SSET) AND NOT(SCLR);
        END GENERATE;
        satu : IF C_HAS_SSET = 1 AND C_HAS_SCLR = 1 AND C_SYNC_PRIORITY = c_set GENERATE
          intSCLR_TO_MSB  <= (intSCLRbase OR SCLR) AND NOT(SSET);
          intSSET_TO_MSB  <= (intSSETbase AND NOT SCLR)OR SSET;
          intSCLR_TO_REST <= (intSSETbase OR SCLR) AND NOT(SSET);
          intSSET_TO_REST <= (intSCLRbase AND NOT SCLR) OR SSET;
        END GENERATE;
      END GENERATE;

      -- Now generate the signals to feed to the registers above
--                      bplow1: if C_BYPASS_LOW = 1 generate
--                              sata: if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
--                                      intSSET_TO_MSB <= intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--                                      intSCLR_TO_MSB <= not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--                                      intSSET_TO_REST <= intSCLR_TO_MSB;
--                                      intSCLR_TO_REST <= intSSET_TO_MSB;
--                              end generate;
--                              satb: if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
--                                      intSSET_TO_MSB <= intSCLR or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_MSB <= intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSSET_TO_REST <= intSCLR or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_REST <= intSCLR nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                              end generate;
--                              satc: if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
--                                      intSSET_TO_MSB <= intSSET nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_MSB <= intSSET or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSSET_TO_REST <= intSSET nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_REST <= intSSET or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                              end generate;
--                              satd: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
--                                      intSSET_TO_MSB <= intSCLR nand (intSSET or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_MSB <= intSCLR or (intSSET nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSSET_TO_REST <= intSCLR nand (intSSET or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_REST <= intSCLR or (intSSET nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                              end generate;
--                              sate: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
--                                      intSSET_TO_MSB <= intSSET or (intSCLR nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_MSB <= intSSET nand (intSCLR or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSSET_TO_REST <= intSSET or (intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_REST <= intSSET nand (intSCLR or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                              end generate;
--                      end generate; -- bplow1
--                      bplow0: if not(C_BYPASS_LOW = 1) generate
--                              sata: if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
--                                      intSSET_TO_MSB <= intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--                                      intSCLR_TO_MSB <= not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--                                      intSSET_TO_REST <= intSCLR_TO_MSB;
--                                      intSCLR_TO_REST <= intSSET_TO_MSB;
--                              end generate;
--                              satb: if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
--                                      intSSET_TO_MSB <= intSCLR or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_MSB <= intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSSET_TO_REST <= intSCLR or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_REST <= intSCLR nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                              end generate;
--                              satc: if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
--                                      intSSET_TO_MSB <= intSSET nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_MSB <= intSSET or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSSET_TO_REST <= intSSET nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                                      intSCLR_TO_REST <= intSSET or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--                              end generate;
--                              satd: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
--                                      intSSET_TO_MSB <= intSCLR nand (intSSET or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_MSB <= intSCLR or (intSSET nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSSET_TO_REST <= intSCLR nand (intSSET or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_REST <= intSCLR or (intSSET nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                              end generate;
--                              sate: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
--                                      intSSET_TO_MSB <= intSSET or (intSCLR nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_MSB <= intSSET nand (intSCLR or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSSET_TO_REST <= intSSET or (intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                                      intSCLR_TO_REST <= intSSET nand (intSCLR or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--                              end generate;
--                      end generate; -- bplow0
    END GENERATE;  -- sinsat1
  END GENERATE;  -- sat1

  -- Feed the asynch output out if necessary
  s1 : IF C_HAS_S = 1 GENERATE
    S <= intS(C_HIGH_BIT DOWNTO C_LOW_BIT);
  END GENERATE;
  s0 : IF NOT (C_HAS_S = 1) GENERATE
    S <= (OTHERS => 'X');
  END GENERATE;

  co1 : IF C_HAS_C_OUT = 1 GENERATE
    C_OUT <= intC_OUT;
  END GENERATE;
  co0 : IF NOT (C_HAS_C_OUT = 1) GENERATE
    C_OUT <= 'X';
  END GENERATE;

  bo1 : IF C_HAS_B_OUT = 1 GENERATE
    B_OUT <= intB_OUT;
  END GENERATE;
  bo0 : IF NOT (C_HAS_B_OUT = 1) GENERATE
    B_OUT <= 'X';
  END GENERATE;


  -- Feedback the correct signals, conditioned by C_SCALE

  scaling_s : IF(C_B_TYPE = c_signed) GENERATE
    intFB(C_OUT_WIDTH-1-C_SCALE DOWNTO 0) <= intFBq(C_OUT_WIDTH-1 DOWNTO C_SCALE);
    scgt0 : IF C_SCALE > 0 GENERATE
      intFB(C_OUT_WIDTH-1 DOWNTO C_OUT_WIDTH-C_SCALE) <= (OTHERS => intFBq(C_OUT_WIDTH-1));
    END GENERATE;
  END GENERATE;
  scaling_u : IF(C_B_TYPE = c_unsigned) GENERATE
    intFB(C_OUT_WIDTH-1-C_SCALE DOWNTO 0) <= intFBq(C_OUT_WIDTH-1 DOWNTO C_SCALE);
    scgt0 : IF C_SCALE > 0 GENERATE
      intFB(C_OUT_WIDTH-1 DOWNTO C_OUT_WIDTH-C_SCALE) <= (OTHERS => '0');
    END GENERATE;
  END GENERATE;
  scaling_p : IF(C_B_TYPE = c_pin) GENERATE
    intFB(C_OUT_WIDTH-1-C_SCALE DOWNTO 0) <= intFBq(C_OUT_WIDTH-1 DOWNTO C_SCALE);
    scgt0 : IF C_SCALE > 0 GENERATE
      intFB(C_OUT_WIDTH-1 DOWNTO C_OUT_WIDTH-C_SCALE) <= (OTHERS => intFBq(C_OUT_WIDTH-1));  -- and intB_SIGNED));
    END GENERATE;
  END GENERATE;

  Q <= intFBq;
  
END behavioral;

