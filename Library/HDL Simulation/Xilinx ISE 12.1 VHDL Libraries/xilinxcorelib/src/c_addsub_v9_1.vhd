-- $RCSfile: c_addsub_v9_1.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:42 $
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
-- Filename - c_addsub_v9_1.vhd
-- Author - Xilinx
-- Creation - 27 Oct 1998
--
-- Description - This file contains the behavior for
--                               the c_addsub_v9_1 core

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v9_1.all;
use XilinxCoreLib.prims_utils_v9_1.all;
use XilinxCoreLib.pkg_baseblox_v9_1.all;
use XilinxCoreLib.c_reg_fd_v9_1_comp.all;

-- (A)Synchronous Adder/Subtractor
--

ENTITY c_addsub_v9_1 IS
  GENERIC (
--    c_family              : STRING; behv model does not get c_family
    c_a_width             : INTEGER := 16;
    c_b_width             : INTEGER := 16;
    c_out_width           : INTEGER := 16;
    c_low_bit             : INTEGER := 0;
    c_high_bit            : INTEGER := 15;
    c_add_mode            : INTEGER := c_add;
    c_a_type              : INTEGER := c_unsigned;
    c_b_type              : INTEGER := c_unsigned;
    c_b_constant          : INTEGER := 0;
    c_b_value             : STRING  := ""; 
    c_ainit_val           : STRING  := ""; 
    c_sinit_val           : STRING  := ""; 
    c_bypass_enable       : INTEGER := c_override;
    c_bypass_low          : INTEGER := 0;
    c_sync_enable         : INTEGER := c_override;
    c_sync_priority       : INTEGER := c_clear;
    c_pipe_stages         : INTEGER := 1;
    c_latency             : INTEGER := 1;
    c_has_s               : INTEGER := 0;
    c_has_q               : INTEGER := 1;
    c_has_c_in            : INTEGER := 1;
    c_has_c_out           : INTEGER := 0;
    c_has_q_c_out         : INTEGER := 0;
    c_has_b_in            : INTEGER := 1;
    c_has_b_out           : INTEGER := 0;
    c_has_q_b_out         : INTEGER := 0;
    c_has_ovfl            : INTEGER := 0;
    c_has_q_ovfl          : INTEGER := 0;
    c_has_ce              : INTEGER := 0;
    c_has_add             : INTEGER := 0;
    c_has_bypass          : INTEGER := 0;
    c_has_a_signed        : INTEGER := 0;
    c_has_b_signed        : INTEGER := 0;
    c_has_aclr            : INTEGER := 0;
    c_has_aset            : INTEGER := 0;
    c_has_ainit           : INTEGER := 0;
    c_has_sclr            : INTEGER := 0;
    c_has_sset            : INTEGER := 0;
    c_has_sinit           : INTEGER := 0;
    c_enable_rlocs        : INTEGER := 1;
    c_has_bypass_with_cin : INTEGER := 0
    ); 

  PORT (
    a        : IN  STD_LOGIC_VECTOR(c_a_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    b        : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    clk      : IN  STD_LOGIC                              := '0';  -- clock
    add      : IN  STD_LOGIC                              := '1';  -- valid when addsub mode selected. 1 = add, 0 = subtract
    c_in     : IN  STD_LOGIC                              := '0';  -- carry in
    b_in     : IN  STD_LOGIC                              := '1';  -- borrow in
    ce       : IN  STD_LOGIC                              := '1';  -- clock enable
    bypass   : IN  STD_LOGIC                              := '0';  -- sync load of b into reg
    aclr     : IN  STD_LOGIC                              := '0';  -- asynch init.
    aset     : IN  STD_LOGIC                              := '0';  -- asynch set.
    ainit    : IN  STD_LOGIC                              := '0';  -- asynch init.
    sclr     : IN  STD_LOGIC                              := '0';  -- synch init.
    sset     : IN  STD_LOGIC                              := '0';  -- synch set.
    sinit    : IN  STD_LOGIC                              := '0';  -- synch init.
    a_signed : IN  STD_LOGIC                              := '0';  -- '0' = unsigned, '1' = signed.
    b_signed : IN  STD_LOGIC                              := '0';  -- '0' = unsigned, '1' = signed.
    ovfl     : OUT STD_LOGIC;
    c_out    : OUT STD_LOGIC;
    b_out    : OUT STD_LOGIC;           -- borrow out
    q_ovfl   : OUT STD_LOGIC;
    q_c_out  : OUT STD_LOGIC;
    q_b_out  : OUT STD_LOGIC;
    s        : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0);  -- asynch output value
    q        : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0)  -- synch output value
    );
END c_addsub_v9_1;

architecture behavioral of c_addsub_v9_1 is

  -- Clean versions of generics:
  CONSTANT enum_c_add_mode      : T_ADD_MODE     := fn_select_add_mode (c_add_mode);
  CONSTANT enum_c_bypass_enable : T_BYPASS_ENABLE:= fn_select_bypass_enable(c_bypass_enable);
  CONSTANT enum_c_sync_enable   : T_SYNC_ENABLE  := fn_select_sync_enable(c_sync_enable);
  CONSTANT enum_c_sync_priority : T_REG_PRIORITY := fn_select_sync_priority(c_sync_priority);
  CONSTANT enum_c_a_type        : T_NUMBER_FORMAT:= fn_select_number_format(c_a_type);
  CONSTANT enum_c_b_type        : T_NUMBER_FORMAT:= fn_select_number_format(c_b_type);

  CONSTANT ci_ainit_val : STD_LOGIC_VECTOR(q'range)              := str_to_bound_slv_0(c_ainit_val, q'length);
  CONSTANT ci_sinit_val : STD_LOGIC_VECTOR(q'range)              := str_to_bound_slv_0(c_sinit_val, q'length);
  CONSTANT ci_b_value   : STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := str_to_slv_0(C_B_VALUE, C_B_WIDTH);

  FUNCTION max (left, right: INTEGER) RETURN INTEGER IS
  BEGIN
    IF left > right THEN RETURN left;
    ELSE RETURN right;
    END IF;
  END max;

  -- purpose: calculates the natural output width which is just the right
  -- size to be able to cope with all possible inputs.
  -- Usually this is max(c_a_width,c_b_width) + 1 but a few cases will produce
  -- 2 bits of growth
  FUNCTION get_natural_width RETURN INTEGER IS
    VARIABLE ret_val : INTEGER;
  BEGIN
    -- no check for NUM_PIN, or for c_has_a_signed
    -- This module no longer supports these generics

    -- The valid output widths are somewhat confusing...
    -- for signed +/- signed, 1 bit natural growth regardless of c_add_mode
    -- for unsigned +/- unsigned, 1 bit growth except for adder/subtractors, which produce 2 extra bits.
    -- for unsigned +/- signed or signed +/- unsigned, things get messier.
    -- If the unsigned input is wider-than-or-equal-to the signed input, there are 2 extra bits
    --   eg: 8-bit signed + 8-bit unsigned = (-128..127) + (0..255) = (-128..382) which needs 10 bits to represent fully.
    -- If the signed input is wider than the unsigned input, there is 1 bit growth.
    -- note that for mixed signed/unsigned, c_add_mode has no effect on the growth.

    IF (enum_c_a_type = NUM_UNSIGNED AND enum_c_b_type = NUM_UNSIGNED) THEN
      -- both inputs unsigned
      IF (enum_c_add_mode = MODE_ADDSUB) THEN
        ret_val := max(c_a_width,c_b_width) + 2;
      ELSE -- pure adder or subtractor
        ret_val := max(c_a_width,c_b_width) + 1;
      END IF;
    ELSIF (enum_c_a_type = NUM_SIGNED AND enum_c_b_type = NUM_SIGNED) THEN
      -- both inputs signed

      ret_val := max(c_a_width,c_b_width) + 1;

    ELSE -- mix of signed & unsigned

      IF (enum_c_a_type = NUM_UNSIGNED AND c_a_width >= c_b_width) OR
         (enum_c_b_type = NUM_UNSIGNED AND c_b_width >= c_a_width) THEN
        -- unsigned input is wider or equal

        ret_val := max(c_a_width,c_b_width) + 2;

      ELSE
        -- signed input is wider
        ret_val := max(c_a_width,c_b_width) + 1;
      END IF;
    END IF;

    RETURN ret_val;

  END get_natural_width;

  -- Purpose: ensure that the generics supplied do not demand a nonsensical or unsupported case
  FUNCTION check_generics(
    a_width             : INTEGER;
    b_width             : INTEGER;
    out_width           : INTEGER;
    low_bit             : INTEGER;
    high_bit            : INTEGER;
    enum_add_mode            : T_ADD_MODE;
    enum_a_type              : T_NUMBER_FORMAT;
    enum_b_type              : T_NUMBER_FORMAT;
    b_constant          : INTEGER;
    b_value             : STRING ; 
    ainit_val           : STRING ; 
    sinit_val           : STRING ; 
    enum_bypass_enable       : T_BYPASS_ENABLE;
    bypass_low          : INTEGER;      
    sync_enable         : INTEGER;
    sync_priority       : INTEGER;
    pipe_stages         : INTEGER;      
    latency             : INTEGER;      
    has_s               : INTEGER;      
    has_q               : INTEGER;      
    has_c_in            : INTEGER;      
    has_c_out           : INTEGER;      
    has_q_c_out         : INTEGER;      
    has_b_in            : INTEGER;      
    has_b_out           : INTEGER;      
    has_q_b_out         : INTEGER;      
    has_ovfl            : INTEGER;      
    has_q_ovfl          : INTEGER;      
    has_ce              : INTEGER;      
    has_add             : INTEGER;      
    has_bypass          : INTEGER;      
    has_a_signed        : INTEGER;      
    has_b_signed        : INTEGER;      
    has_aclr            : INTEGER;      
    has_aset            : INTEGER;      
    has_ainit           : INTEGER;      
    has_sclr            : INTEGER;      
    has_sset            : INTEGER;      
    has_sinit           : INTEGER;      
    enable_rlocs        : INTEGER;      
    has_bypass_with_cin : INTEGER
    )
    RETURN INTEGER IS
  BEGIN
    -- simple checks
    ASSERT a_width >= 1 AND a_width <= 258
      REPORT "ERROR - addsub: c_a_width must be in the range 1..258"
      SEVERITY FAILURE;
    ASSERT b_width >= 1 AND b_width <= 258
      REPORT "ERROR - addsub: c_b_width must be in the range 1..258"
      SEVERITY FAILURE;
    -- signed types need at least 2 bits
    ASSERT a_width >= 2 OR (enum_a_type /= NUM_SIGNED AND enum_a_type /= NUM_PIN)
      REPORT "ERROR - addsub: c_a_width must be at least 2 bits if it is to be a signed type"
      SEVERITY FAILURE;
    ASSERT b_width >= 2 OR (enum_b_type /= NUM_SIGNED AND enum_b_type /= NUM_PIN)
      REPORT "ERROR - addsub: c_b_width must be at least 2 bits if it is to be a signed type"
      SEVERITY FAILURE;
    ASSERT high_bit = out_width - 1
      REPORT "ERROR - addsub: c_high_bit must equal c_out_width - 1"
      SEVERITY FAILURE;
    ASSERT low_bit = 0
      REPORT "ERROR - addsub: c_low_bit must equal zero"
      SEVERITY FAILURE;
    ASSERT b_constant = 0 OR b_constant = 1
      REPORT "ERROR - addsub: Invalid value in generic c_b_constant (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT bypass_low = 0 OR bypass_low = 1
      REPORT "ERROR - addsub: Invalid value in generic c_bypass_low (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT pipe_stages = 0 OR pipe_stages = 1
      REPORT "WARNING - addsub: c_pipe_stages generic is no longer supported; it will be ignored. If you want pipelining, use the c_latency generic"
      SEVERITY WARNING;
    ASSERT has_s = 0 OR has_s = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_s (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_q = 0 OR has_q = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_q (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_c_in = 0 OR has_c_in = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_c_in (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_c_out = 0 OR has_c_out = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_c_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_q_c_out = 0 OR has_q_c_out = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_q_c_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_b_in = 0 OR has_b_in = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_b_in (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_b_out = 0 OR has_b_out = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_b_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_q_b_out = 0 OR has_q_b_out = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_q_b_out (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_ovfl = 0 OR has_ovfl = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_ovfl (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_q_ovfl = 0 OR has_q_ovfl = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_q_ovfl (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_ce = 0 OR has_ce = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_ce (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_add = 0 OR has_add = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_add (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_bypass = 0 OR has_bypass = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_bypass (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_a_signed = 0
      REPORT "ERROR - addsub: c_has_a_signed deprecated as of baseblox_v8_0"
      SEVERITY FAILURE;
    ASSERT has_b_signed = 0
      REPORT "ERROR - addsub: c_has_b_signed deprecated as of baseblox_v8_0"
      SEVERITY FAILURE;
    ASSERT has_aclr = 0 OR has_aclr = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_aclr (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_aset = 0 OR has_aset = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_aset (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_ainit = 0 OR has_ainit = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_ainit (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_sclr = 0 OR has_sclr = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_sclr (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_sset = 0 OR has_sset = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_sset (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_sinit = 0 OR has_sinit = 1
      REPORT "ERROR - addsub: Invalid value in generic c_has_sinit (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT has_bypass_with_cin = 0
      REPORT "ERROR - addsub: c_has_bypass_with_cin deprecated as of baseblox_v8_0"
      SEVERITY FAILURE;
    ASSERT enable_rlocs = 0
      REPORT "WARNING - addsub: Relative location constraints (c_has_rlocs) no longer supported as of baseblox_v8_0"
      SEVERITY WARNING;

    -- More complex checks
    ASSERT has_s = 1 OR has_q = 1
      REPORT "WARNING - addsub: No output port (S or Q) requested"
      SEVERITY WARNING;

    -- c_has_add and c_add_mode redundancy..
    ASSERT NOT (enum_add_mode = MODE_ADDSUB AND has_add = 0)
      REPORT "ERROR - addsub: Adder/subtractors require an ADD pin - set c_has_add to 1"
      SEVERITY FAILURE;
    ASSERT NOT (enum_add_mode /= MODE_ADDSUB AND has_add = 1)
      REPORT "ERROR - addsub: ADD pin is needed only for adder/subtractors"
      SEVERITY FAILURE;

    IF enum_add_mode = MODE_ADD OR enum_add_mode = MODE_ADDSUB THEN
      ASSERT has_b_in = 0 AND has_b_out = 0 AND has_q_b_out = 0
        REPORT "ERROR - addsub: Borrow in/out not available for adders or adder/subtractors (use c_in and c_out instead)"
        SEVERITY FAILURE;
    ELSE -- enum_add_mode = MODE_SUB
      ASSERT has_c_in = 0 AND has_c_out = 0 AND has_q_c_out = 0
        REPORT "ERROR - addsub: Carry in/out not available for subtractors (use b_in and b_out instead)"
        SEVERITY FAILURE;
    END IF;

    ASSERT out_width >= max(a_width,b_width)
      REPORT "ERROR - addsub: A or B is wider than the output"
      SEVERITY ERROR;

    ASSERT out_width <= get_natural_width
      REPORT "ERROR - addsub: c_out_width too large - see data sheet for allowable values"
      SEVERITY FAILURE;

    IF has_ovfl = 1 OR has_q_ovfl = 1 THEN
      ASSERT enum_a_type = NUM_SIGNED AND enum_b_type = NUM_SIGNED
        REPORT "ERROR - addsub: Overflow is only permitted when both inputs are signed"
        SEVERITY FAILURE;
    END IF;

    IF has_c_out = 1 OR has_b_out = 1 OR has_q_c_out = 1 OR has_q_b_out = 1 THEN
      ASSERT enum_a_type = NUM_UNSIGNED AND enum_b_type = NUM_UNSIGNED
        REPORT "ERROR - addsub: Carry/borrow out are only permitted when both inputs are unsigned"
        SEVERITY FAILURE;
    END IF;

    IF out_width >= get_natural_width THEN -- output has enough bits to cope with all cases
      ASSERT has_ovfl = 0 AND has_q_ovfl = 0
        REPORT "ERROR - addsub: The core has sufficient bit-growth to render overflow redundant"
        SEVERITY FAILURE;
      ASSERT has_c_out = 0 AND has_q_c_out = 0
        REPORT "ERROR - addsub: The core has sufficient bit-growth to render carry-out redundant"
        SEVERITY FAILURE;
      ASSERT has_b_out = 0 AND has_q_b_out = 0
        REPORT "ERROR - addsub: The core has sufficient bit-growth to render borrow-out redundant"
        SEVERITY FAILURE;
    END IF;

    -- Warning for nonintuitive behaviour
    --
    -- it's not clear what the Right Thing to do is with c_b_value
    -- when it's narrower than c_b_width; but I go on the basis
    -- that "1" probably means one and not minus one, and therefore
    -- zero-extend and not sign-extend.
    IF b_constant = 1 THEN
      IF enum_b_type = NUM_SIGNED THEN
        ASSERT NOT (c_b_value'LENGTH < b_width)
          REPORT "WARNING - addsub: c_b_value is narrower than c_b_width, will pad with zeroes. If a negative number is required, it must be the same width as c_b_width"
          SEVERITY WARNING;
      END IF;
    END IF;

    -- Async and sync controls together will create extra logic
    ASSERT (has_ainit = 0 AND has_aset = 0 AND has_aclr = 0) OR
           (has_sinit = 0 AND has_sset = 0 AND has_sclr = 0)
      REPORT "WARNING - addsub: Including both asynchronous (aclr, aset or ainit)"
           & "and synchronous controls (sclr, sset or sinit) will add extra logic and impact performance"
      SEVERITY WARNING;

    -- FIXME pipelining-specific generics need to be considered
    IF latency > 1 THEN -- Pipelined module
      ASSERT has_s = 0 AND has_c_out = 0 AND has_b_out = 0 AND has_ovfl = 0
        REPORT "ERROR - addsub: Cannot have pipelining and asynchronous outputs (s, c_out, b_out, ovfl); use the synchronous versions (q, q_c_out, q_b_out, q_ovfl) instead"
        SEVERITY FAILURE;

      IF has_ce = 1 AND has_bypass = 1 THEN
        ASSERT enum_bypass_enable = CE_OVERRIDES_BYPASS
          REPORT "ERROR - addsub: BYPASS over CE does not make sense in a pipelined module"
          SEVERITY FAILURE;
      END IF;

      IF has_aclr = 1 OR has_aset = 1 OR has_ainit = 1 THEN
        ASSERT FALSE
          REPORT "WARNING - addsub: In the interests of speed, aclr/aset/ainit are ignored for pipelined modules"
          SEVERITY WARNING;
      END IF;

      IF has_sset = 1 OR has_sinit = 1 THEN
        ASSERT FALSE
          REPORT "WARNING - addsub: In the interests of efficiency, sset and sinit are ignored for pipelined modules"
          SEVERITY WARNING;
      END IF;
    END IF;

    RETURN 0;
  END check_generics;

  -- The following line should make sure that check_generics
  -- is called on instantiation
  CONSTANT check_gens : INTEGER := check_generics(
    c_a_width             ,
    c_b_width             ,
    c_out_width           ,
    c_low_bit             ,
    c_high_bit            ,
    enum_c_add_mode            ,
    enum_c_a_type              ,
    enum_c_b_type              ,
    c_b_constant          ,
    c_b_value             , 
    c_ainit_val           , 
    c_sinit_val           , 
    enum_c_bypass_enable       ,
    c_bypass_low          ,      
    c_sync_enable         ,
    c_sync_priority       ,
    c_pipe_stages         ,      
    c_latency             ,      
    c_has_s               ,      
    c_has_q               ,      
    c_has_c_in            ,      
    c_has_c_out           ,      
    c_has_q_c_out         ,      
    c_has_b_in            ,      
    c_has_b_out           ,      
    c_has_q_b_out         ,      
    c_has_ovfl            ,      
    c_has_q_ovfl          ,      
    c_has_ce              ,      
    c_has_add             ,      
    c_has_bypass          ,      
    c_has_a_signed        ,      
    c_has_b_signed        ,      
    c_has_aclr            ,      
    c_has_aset            ,      
    c_has_ainit           ,      
    c_has_sclr            ,      
    c_has_sset            ,      
    c_has_sinit           ,      
    c_enable_rlocs        ,      
    c_has_bypass_with_cin 
    );




  FUNCTION fn_pipe_has_ctrl (
    core_has_ctrl : integer;
    latency : integer
    ) RETURN integer is
    begin
      if latency > 1 then
        RETURN 0;
      else
        RETURN core_has_ctrl;
      END if;
    end;
      
   constant timeunit : time := 100 ps;
   CONSTANT C_HAS_SSET_PIPE  : integer := fn_pipe_has_ctrl(c_has_sset , c_latency);
   CONSTANT C_HAS_SINIT_PIPE : integer := fn_pipe_has_ctrl(c_has_sinit, c_latency);
   CONSTANT C_HAS_ACLR_PIPE  : integer := fn_pipe_has_ctrl(c_has_aclr , c_latency);
   CONSTANT C_HAS_ASET_PIPE  : integer := fn_pipe_has_ctrl(c_has_aset , c_latency);
   CONSTANT C_HAS_AINIT_PIPE : integer := fn_pipe_has_ctrl(c_has_ainit, c_latency);

  FUNCTION fn_sclr_init (
    has_sclr : integer;
    has_sinit: integer
    ) RETURN integer is
    begin
      if has_sclr /= 0 OR has_sinit /= 0 then
        RETURN 1;
      else
        RETURN 0;
      END if;
    end;
      
   CONSTANT C_HAS_SCLR_INIT : integer := fn_sclr_init(c_has_sclr, c_has_sinit_pipe);

   -- signals for optional pins...
   signal intS               : std_logic_vector(C_HIGH_BIT downto C_LOW_BIT) := (others => 'X');
   signal intQ               : std_logic_vector(C_HIGH_BIT downto C_LOW_BIT) := (others => 'X');
   signal intBconst          : std_logic_vector(C_B_WIDTH-1 downto 0)        := (others => 'X');
   signal intB               : std_logic_vector(C_B_WIDTH-1 downto 0)        := (others => 'X');
   signal intCE              : std_logic                                     := '1';
   signal intQCE             : std_logic                                     := '1';
   signal intADD             : std_logic                                     := '0';
   signal intBYPASS          : std_logic                                     := '0';
   signal intBYPASS_WITH_CIN : std_logic                                     := '0';
   signal intC_IN            : std_logic                                     := '0';
   signal intB_IN            : std_logic                                     := '1';
   signal intC_OUT           : std_logic                                     := '0';
   signal intB_OUT           : std_logic                                     := '1';
   signal intOVFL            : std_logic                                     := '0';
   signal intQ_C_OUT         : std_logic                                     := '0';
   signal intQ_B_OUT         : std_logic                                     := '1';
   signal intQ_OVFL          : std_logic                                     := '0';
   signal intA_SIGNED        : std_logic                                     := '0';
   signal intB_SIGNED        : std_logic                                     := '0';

   -- pipelining signals
   signal intQpipeend       : std_logic_vector(C_HIGH_BIT downto C_LOW_BIT);
   type   pipetype is array (C_LATENCY+2 downto 0) of std_logic_vector(C_HIGH_BIT-C_LOW_BIT downto 0);
   signal intQpipe          : pipetype                               := (others => (others => 'X'));
   signal intQ_C_OUTpipe    : std_logic_vector(C_LATENCY+2 downto 0) := (others => 'X');
   signal intQ_C_OUTpipeend : std_logic                              := 'X';
   signal intQ_B_OUTpipe    : std_logic_vector(C_LATENCY+2 downto 0) := (others => 'X');
   signal intQ_B_OUTpipeend : std_logic                              := 'X';
   signal intQ_OVFLpipe     : std_logic_vector(C_LATENCY+2 downto 0) := (others => 'X');
   signal intQ_OVFLpipeend  : std_logic                              := 'X';
   signal lastADD           : std_logic                              := 'X';

   signal intACLR, intASET, intAINIT : std_logic := '0';
   signal intSCLR, intSSET, intSINIT : std_logic := '0';
   signal intACLR_INIT               : std_logic := '0';
   signal intSCLR_INIT               : std_logic := '0';


begin

   ac1 : if C_HAS_ACLR = 1 generate
      intACLR <= ACLR;
   end generate;
   ac0 : if C_HAS_ACLR = 0 generate
      intACLR <= '0';
   end generate;

   as1 : if C_HAS_ASET = 1 generate
      intASET <= ASET;
   end generate;
   as0 : if C_HAS_ASET = 0 generate
      intASET <= '0';
   end generate;

   ai1 : if C_HAS_AINIT = 1 generate
      intAINIT <= AINIT;
   end generate;
   ai0 : if C_HAS_AINIT = 0 generate
      intAINIT <= '0';
   end generate;

   sc1 : if C_HAS_SCLR = 1 generate
      soc : if C_SYNC_ENABLE = c_override generate
         intSCLR <= SCLR;
      end generate;
      cos : if C_SYNC_ENABLE = c_no_override generate
         intSCLR <= SCLR AND intCE;
      end generate;
   end generate;
   sc0 : if C_HAS_SCLR = 0 generate
      intSCLR <= '0';
   end generate;

   ss1 : if C_HAS_SSET = 1 generate
      soc : if C_SYNC_ENABLE = c_override generate
         intSSET <= SSET;
      end generate;
      cos : if C_SYNC_ENABLE = c_no_override generate
         intSSET <= SSET AND intCE;
      end generate;
   end generate;
   ss0 : if C_HAS_SSET = 0 generate
      intSSET <= '0';
   end generate;

   si1 : if C_HAS_SINIT = 1 generate
      soc : if C_SYNC_ENABLE = c_override generate
         intSINIT <= SINIT;
      end generate;
      cos : if C_SYNC_ENABLE = c_no_override generate
         intSINIT <= SINIT AND intCE;
      end generate;
   end generate;
   si0 : if C_HAS_SINIT = 0 generate
      intSINIT <= '0';
   end generate;

   ce1 : if C_HAS_CE = 1 generate
      intCE <= CE;
   end generate;
   ce0 : if not (C_HAS_CE = 1) generate
      intCE <= '1';
   end generate;

   asig1 : if C_HAS_A_SIGNED = 1 generate
      intA_SIGNED <= A_SIGNED;
   end generate;
   asig0 : if not (C_HAS_A_SIGNED = 1) generate
      intA_SIGNED <= '0';
   end generate;

   bsig1 : if C_HAS_B_SIGNED = 1 generate
      intB_SIGNED <= B_SIGNED;
   end generate;
   bsig0 : if not (C_HAS_B_SIGNED = 1) generate
      intB_SIGNED <= '0';
   end generate;

   b1 : if C_B_CONSTANT = 1 generate
      intBconst <= ci_b_value;
   end generate;
   b0 : if not (C_B_CONSTANT = 1) generate
      intBconst <= B;
   end generate;

ad1 : if C_HAS_ADD = 1 generate      -- add_sub mode implied!
       intADD <= ADD;
end generate;

   
   ad0 : if not (C_HAS_ADD = 1) generate
      ad00 : if C_ADD_MODE = c_add generate
         intADD <= '1';
      end generate;
      ad01 : if C_ADD_MODE = c_sub generate
         intADD <= '0';
      end generate;
   end generate;

   bypasswithcin : if C_HAS_BYPASS_WITH_CIN = 1 generate
      intBYPASS_WITH_CIN <= '1';
   end generate;

   bypass1 : if C_HAS_BYPASS = 1 generate
      byp0 : if C_BYPASS_LOW = 1 generate
         intBYPASS <= not BYPASS;
      end generate;
      byp1 : if C_BYPASS_LOW = 0 generate
         intBYPASS <= BYPASS;
      end generate;
   end generate;
   bypass0 : if not (C_HAS_BYPASS = 1) generate
      intBYPASS <= '0';
   end generate;

   qce1 : if C_HAS_CE = 1 generate
      byp1 : if C_HAS_BYPASS = 1 generate
         bypov0 : if C_BYPASS_ENABLE = c_override generate
            intQCE <= CE or intBYPASS;
         end generate;
         bypov1 : if C_BYPASS_ENABLE = c_no_override generate
            intQCE <= CE;
         end generate;
      end generate;
      byp0 : if C_HAS_BYPASS = 0 generate
         intQCE <= CE;
      end generate;
   end generate;
   qce0 : if C_HAS_CE = 0 generate
      intQCE <= '1';
   end generate;

   cin1 : if C_HAS_C_IN = 1 generate
      intC_IN <= C_IN;
   end generate;
   cin0 : if not (C_HAS_C_IN = 1) generate
      cin0_addsub : if (C_HAS_ADD = 1) generate  -- add_sub mode!
         intC_IN <= not intADD;
      end generate;
      cin0_add_or_sub : if not (C_HAS_ADD = 1) generate
         intC_IN <= '0';
      end generate;
   end generate;

   bin1 : if C_HAS_B_IN = 1 generate
      intB_IN <= B_IN;
   end generate;
   bin0 : if not (C_HAS_B_IN = 1) generate
      intB_IN <= '1';
   end generate;

   p1 : process(A, B, intBconst, intB, intADD, intBYPASS, intC_IN, intB_IN, intA_SIGNED, intB_SIGNED, intACLR, intASET, intAINIT, intSCLR, intSSET, intSINIT)
      
      variable tmpWidth : integer := max(A'length, intB'length) + 2;
      variable tmpA     : std_logic_vector(tmpWidth - 1 downto 0);
      variable tmpB     : std_logic_vector(tmpWidth - 1 downto 0);
      variable tmpC     : std_logic_vector(tmpWidth - 1 downto 0);
      variable tmpBC    : std_logic_vector(tmpWidth - 1 downto 0);
      variable tmpABC   : std_logic_vector(tmpWidth - 1 downto 0);
      variable tmpD     : std_logic_vector(tmpWidth - 2 downto 0);
      variable tmpE     : std_logic_vector(tmpWidth - 2 downto 0);
      variable tmpF     : std_logic_vector(tmpWidth - 2 downto 0);
      
      
   begin
      
      if intBYPASS = '1' then
         intB <= B;
      else
         intB <= intBconst;
      end if;

      intACLR_INIT <= intACLR or intAINIT;
      intSCLR_INIT <= intSCLR or intSINIT;

      tmpC := (others => '0');

      if intBYPASS = '1' then  -- When the Bypass is high then always use Carry in                                             
         tmpC(0) := intC_IN;            -- when BYPASS_WITH_CIN is selected.
      elsif intC_IN /= '0' then         -- Active high carry in to an adder?
         if ((C_ADD_MODE = c_add_sub and intADD = '1') or C_ADD_MODE = c_add) then
            tmpC    := (others => '0');
            tmpC(0) := intC_IN;
         end if;
      elsif intC_IN /= '1' and C_ADD_MODE = c_add_sub and intADD = '0' then  -- Active low borrow in to a subtractor?
         tmpC    := (others => '0');
         tmpC(0) := not intC_IN;
      elsif intB_IN /= '1' and C_ADD_MODE = c_sub then  -- Subtractor with active low borrow
         tmpC    := (others => '0');
         tmpC(0) := not intB_IN;
      end if;

      -- Set up the internal (variable) signals to be signed versions of
      -- the inputs. This allows simpler use of the addition functions

      if C_A_TYPE = c_signed or (C_A_TYPE = c_pin and intA_SIGNED = '1') then  -- Sign extend tmpA
         l1 : for i in tmpA'length - 1 downto A'length loop
            tmpA(i) := A(A'length-1);
         end loop;  -- l1
      elsif C_A_TYPE = c_unsigned or (C_A_TYPE = c_pin and intA_SIGNED = '0') then  -- pad with zeros
         l2 : for i in tmpA'length - 1 downto A'length loop
            tmpA(i) := '0';
         end loop;  -- l1
      elsif C_A_TYPE = c_pin and intA_SIGNED = 'X' then  -- pad with zeros
         l2a : for i in tmpA'length - 1 downto A'length loop
            tmpA(i) := 'X';
         end loop;  -- l1
      end if;

      tmpA(A'length-1 downto 0) := A;

      if C_B_TYPE = c_signed or (C_B_TYPE = c_pin and intB_SIGNED = '1') then  -- Sign extend tmpB
         l3 : for i in tmpB'length - 1 downto intB'length loop
            tmpB(i) := intB(intB'length-1);
         end loop;  -- l3
      elsif C_B_TYPE = c_unsigned or (C_B_TYPE = c_pin and intB_SIGNED = '0') then  -- pad with zeros
         l4 : for i in tmpB'length - 1 downto intB'length loop
            tmpB(i) := '0';
         end loop;  -- l4
      elsif C_B_TYPE = c_pin and intB_SIGNED = 'X' then  -- pad with zeros
         l4a : for i in tmpB'length - 1 downto intB'length loop
            tmpB(i) := 'X';
         end loop;  -- l4
      end if;

      tmpB(intB'length-1 downto 0) := intB;


      -- Examine the BYPASS signal and the inputs for 'X's, 
      -- before doing the addition/subtraction as required.

      if (intBYPASS_WITH_CIN = '0' and intBYPASS = '1') then
         intS <= tmpB(C_HIGH_BIT downto C_LOW_BIT);-- after timeunit;
 
          if is_X(tmpB) then
             intC_OUT <= 'X';
             intB_OUT <= 'X';
             intOVFL  <= 'X';
--         elsif is_X(intB) then
--             intC_OUT <= 'X';
--             intB_OUT <= 'X';
--             intOVFL  <= 'X';
             
          else
             intC_OUT <= '0';
             intB_OUT <= '0';
             intOVFL  <= '0';
          end if;

           
            
         
      elsif is_X(tmpA) or is_X(tmpB) or is_X(intADD)
         or is_X(intBYPASS) or is_X(tmpC)  then
         intS     <= (others => 'X');-- after timeunit;
         intC_OUT <= 'X';
         intB_OUT <= 'X';
         intOVFL  <= 'X';
      elsif (intBYPASS_WITH_CIN = '1' and intBYPASS = '1') then --New code to test the bypass_with_cin mode.
                                                                --It adds the c_in value to the B input under
                                                                -- bypass conditions.
            tmpBC := std_logic_vector( signed(tmpB) + signed(tmpC) );
         
         intS <= tmpBC(C_HIGH_BIT downto C_LOW_BIT);-- after timeunit;
            if C_HAS_C_OUT = 1 or C_HAS_Q_C_OUT = 1 then -- No extra output bit, but there IS a c_out pin
                intC_OUT <= tmpBC(tmpWidth-2);-- after timeunit;
			end if;
			--	intOVFL <= '0' after timeunit;
            if C_HAS_OVFL = 1 or C_HAS_Q_OVFL = 1 then
            -- We need to get hold of the carry into the final bit
            -- and xor it with the carry OUT of the final bit.
            tmpD(tmpWidth-2 downto 0) := (others => '0');
            tmpE(tmpWidth-3 downto 0) := tmpBC(tmpWidth-3 downto 0);
            if(C_B_TYPE = c_signed) or (C_B_TYPE = c_pin and intB_SIGNED = '1') then
               tmpE(tmpWidth-2) := tmpBC(tmpWidth-1);
            else
               tmpE(tmpWidth-2) := '0';
            end if;
            if (C_ADD_MODE = c_add_sub and intADD = '1')
               or C_ADD_MODE = c_add then
               tmpF := std_logic_vector( signed(tmpD) + signed(tmpE) );
            elsif (C_ADD_MODE = c_add_sub and intADD = '0')
               or C_ADD_MODE = c_sub then
               tmpF := std_logic_vector( signed(tmpD) - signed(tmpE) );
            end if;
            -- Now xor the carry out from tmpF
            intOVFL <= tmpF(tmpWidth-3) xor tmpBC(tmpWidth-2);-- after timeunit;
         end if;
      else
         -- Handle Carry In here by adding the carry to the tmpB value.
         if (C_ADD_MODE = c_add_sub and intADD = '1') or
            C_ADD_MODE = c_add then
            tmpBC := std_logic_vector( signed(tmpB) + signed(tmpC) );
         elsif (C_ADD_MODE = c_add_sub and intADD = '0') or
            C_ADD_MODE = c_sub then
            tmpBC := std_logic_vector( signed(tmpB) + signed(tmpC) );
         end if;

         if (C_ADD_MODE = c_add_sub and intADD = '1')
            or C_ADD_MODE = c_add then
            tmpABC := std_logic_vector( signed(tmpA) + signed(tmpBC) );
         elsif (C_ADD_MODE = c_add_sub and intADD = '0')
            or C_ADD_MODE = c_sub then
            tmpABC := std_logic_vector( signed(tmpA) - signed(tmpBC) );
         end if;

         intS <= tmpABC(C_HIGH_BIT downto C_LOW_BIT);-- after timeunit;

         if C_HAS_C_OUT = 1 or C_HAS_Q_C_OUT = 1 then  -- No extra output bit, but there IS a c_out pin
            if ((C_ADD_MODE = c_add_sub and intADD = '1') or
               C_ADD_MODE = c_add) then
               intC_OUT <= tmpABC(tmpWidth-2);-- after timeunit;
            elsif (C_ADD_MODE = c_add_sub and intADD = '0') then
               intC_OUT <= not tmpABC(tmpWidth-2);-- after timeunit;
--            elsif is_X(intQ)then 
--               intC_OUT <= 'X';
            end if;
         end if;

         if C_HAS_B_OUT = 1 or C_HAS_Q_B_OUT = 1 then
            intB_OUT <= not tmpABC(tmpWidth-2);-- after timeunit;
         end if;

         if C_HAS_OVFL = 1 or C_HAS_Q_OVFL = 1 then
            -- We need to get hold of the carry into the final bit
            -- and xor it with the carry OUT of the final bit.
            tmpD(tmpWidth-3 downto 0) := tmpA(tmpWidth-3 downto 0);
            if(C_A_TYPE = c_signed) or (C_A_TYPE = c_pin and intA_SIGNED = '1') then
               tmpD(tmpWidth-2) := tmpA(tmpWidth-1);
            else
               tmpD(tmpWidth-2) := '0';
            end if;
            tmpE(tmpWidth-3 downto 0) := tmpBC(tmpWidth-3 downto 0);
            if(C_B_TYPE = c_signed) or (C_B_TYPE = c_pin and intB_SIGNED = '1') then
               tmpE(tmpWidth-2) := tmpBC(tmpWidth-1);
            else
               tmpE(tmpWidth-2) := '0';
            end if;
            if (C_ADD_MODE = c_add_sub and intADD = '1')
               or C_ADD_MODE = c_add then
               tmpF := std_logic_vector( signed(tmpD) + signed(tmpE) );
            elsif (C_ADD_MODE = c_add_sub and intADD = '0')
               or C_ADD_MODE = c_sub then
               tmpF := std_logic_vector( signed(tmpD) - signed(tmpE) );
            end if;
            -- Now xor the carry out from tmpF
            intOVFL <= tmpF(tmpWidth-3) xor tmpABC(tmpWidth-2);-- after timeunit;
         end if;
         
     end if;
      
      
   end process;  -- p1

   g1 : if C_HAS_Q = 1 generate         -- Need a register on the output
      opreg : c_reg_fd_v9_1
        generic map(
          C_WIDTH         => (C_HIGH_BIT-C_LOW_BIT)+1,
          C_AINIT_VAL     => C_AINIT_VAL,
          C_SINIT_VAL     => C_SINIT_VAL,
          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
          C_SYNC_ENABLE   => C_SYNC_ENABLE,
          C_HAS_CE        => C_HAS_CE,
          C_HAS_ACLR      => C_HAS_ACLR_PIPE,
          C_HAS_ASET      => C_HAS_ASET_PIPE,
          C_HAS_AINIT     => C_HAS_AINIT_PIPE,
          C_HAS_SCLR      => C_HAS_SCLR,
          C_HAS_SSET      => C_HAS_SSET_PIPE,
          C_HAS_SINIT     => C_HAS_SINIT_PIPE,
          C_ENABLE_RLOCS  => C_ENABLE_RLOCS
          )
        port map(
          D     => intQpipeend,
          CLK   => CLK,
          CE    => intQCE,
          ACLR  => ACLR,
          ASET  => ASET,
          AINIT => AINIT,
          SCLR  => intSCLR,
          SSET  => intSSET,
          SINIT => intSINIT,
          Q     => intQ
          );

   end generate;

   ha1 : process(CLK)
   begin
      if intCE = '1' and CLK = '1' and CLK'last_value = '0' then
         lastADD <= intADD;
      end if;
   end process;  -- ha1

--     pipeadd : process (CLK)
--     begin
--       if CLK'event and CLK = '1' and C_LATENCY > 0 then
--          intADDpipe(0) <= ADD;
--          for i in 1 to C_LATENCY-1 loop
--             intADDpipe(i) <= intADDpipe(i-1);
--          end loop;
-- --         intADD <= intADDpipe(C_LATENCY-1);        
--       end if;
--     end process;
   intQpipe(C_LATENCY+1) <= intS;
   pipe: FOR depth IN 0 TO c_latency GENERATE
     pipereg : c_reg_fd_v9_1
       generic map(
         C_WIDTH         => C_HIGH_BIT -C_LOW_BIT +1,
         C_SYNC_ENABLE   => C_SYNC_ENABLE,
         C_HAS_CE        => C_HAS_CE,
         C_HAS_SCLR      => C_HAS_SCLR,
         C_ENABLE_RLOCS  => C_ENABLE_RLOCS
         )
       port map(
         D     => intQpipe(depth +1),
         CLK   => CLK,
         CE    => intQCE,
         SCLR  => intSCLR,
         Q     => intQpipe(depth)
         );
    
   END GENERATE pipe;
     
--   pipeq : process (CLK, intACLR)
--   begin
--      if ((intSCLR = '1' and (CLK'event and CLK='1')) or intACLR = '1') then 
--        for i in 0 to C_LATENCY+2 loop
--          intQpipe(i) <= (others => '0');       
--        end loop;
--      elsif intQCE = '1' and (CLK'event and CLK = '1') and CLK'last_value = '0' and C_LATENCY > 1 then
--         pipeloop : for p in 2 to C_LATENCY-1 loop
--           intQpipe(p) <= intQpipe(p+1);
--         end loop;  -- pipeloop
--
--         intQpipe(C_LATENCY) <= intS;
--      elsif ((intQCE = 'X' and CLK'event and CLK='1') or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
--         pipeloopx : for p in 2 to C_LATENCY-1 loop
--            pipeloopxinner : for p1 in 0 to C_HIGH_BIT-C_LOW_BIT loop
--               if intQpipe(p)(p1) /= intQpipe(p+1)(p1) then
--                  intQpipe(p)(p1) <= 'X';
--               end if;
--            end loop;  -- pipeloopxinner
--         end loop;  -- pipeloopx
--         pipeloopxlast : for p1 in 0 to C_HIGH_BIT-C_LOW_BIT loop
--            if intQpipe(C_LATENCY)(p1) /= intS(p1) then
--               intQpipe(C_LATENCY)(p1) <= 'X';
--            end if;
--         end loop;  -- pipeloopxlast
--      end if;
--   end process;  -- pipeq

   ps1 : if C_LATENCY < 2 generate
      intQpipeend <= intS;
   end generate;
   ps1b : if C_LATENCY > 1 generate
      intQpipeend <= intQpipe(2);
   end generate;


   q1 : if C_HAS_Q = 1 AND c_latency < 2 generate
      Q <= intQ AFTER timeunit;
   end generate;
   q2: IF C_HAS_Q = 1 AND c_latency >1 GENERATE
     Q <= intQpipe(1) AFTER timeunit;
   END GENERATE q2;
   q0 : if not (C_HAS_Q = 1) generate
      Q <= (others => 'X');
   end generate;

   s0 : if not (C_HAS_S = 1) generate
      S <= (others => 'X');
   end generate;
   s1 : if C_HAS_S = 1 generate
      S <= intS;
   end generate;

   g2a1 : if C_HAS_Q_C_OUT = 1 generate
     coutreg : c_reg_fd_v9_1 generic map(
       C_WIDTH         => 1,
       C_AINIT_VAL     => "0",
       C_SINIT_VAL     => "0",
       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
       C_SYNC_ENABLE   => C_SYNC_ENABLE,
       C_HAS_CE        => C_HAS_CE,
       C_HAS_ACLR      => C_HAS_ACLR_PIPE,
       C_HAS_SCLR      => C_HAS_SCLR_INIT,
       C_HAS_ASET      => C_HAS_ASET_PIPE,
       C_HAS_SSET      => C_HAS_SSET_PIPE,
       C_HAS_AINIT     => C_HAS_AINIT_PIPE,
       C_HAS_SINIT     => 0,--C_HAS_SINIT_PIPE, CR206054
       C_ENABLE_RLOCS  => C_ENABLE_RLOCS
       )
     port map(
       D(0)  => intQ_C_OUTpipeend,
       CLK   => CLK,
       CE    => intQCE,
       ACLR  => intACLR_INIT,
       ASET  => ASET,
       AINIT => AINIT,
       SCLR  => intSCLR_INIT,
       SSET  => intSSET,
       SINIT => intSINIT,
       Q(0)  => intQ_C_OUT
       );
     
   end generate;
   pipeq_c_out : process (CLK)
   begin
      --  removed "and (not(is_X(intQpipe(C_LATENCY-1))))" to match verilog model and fix sim bug.
      if (((intSCLR = '1' and CLK = '1')
           --or intACLR = '1' CR204743
           ) and (C_ADD_MODE = c_add OR C_ADD_MODE = c_add_sub) ) then
         pipeloop0 : for p in 2 to C_LATENCY loop
            intQ_C_OUTpipe(p) <= '0';
         end loop;        
      
      elsif intQCE = '1' and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 then

         pipeloop : for p in 2 to C_LATENCY-1 loop
            intQ_C_OUTpipe(p) <= intQ_C_OUTpipe(p+1);
         end loop;
         intQ_C_OUTpipe(C_LATENCY) <= intC_OUT;

--      elsif (is_X(intQpipe(C_LATENCY-1))) then
--         intQ_C_OUTpipe(2) <= 'X';

      elsif (intQCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
         pipeloopx : for p in 2 to C_LATENCY-1 loop
            if intQ_C_OUTpipe(p) /= intQ_C_OUTpipe(p+1) then
               intQ_C_OUTpipe(p) <= 'X';
            end if;
         end loop;  -- pipeloopx
         if intQ_C_OUTpipe(C_LATENCY) /= intC_OUT then
            intQ_C_OUTpipe(C_LATENCY) <= 'X';
         end if;
      end if;
   end process;  -- pipeq_c_out

   ps2 : if C_LATENCY < 2 generate
      intQ_C_OUTpipeend <= intC_OUT;
   end generate;
   ps2b : if C_LATENCY > 1 generate
      pipeqctox : process(intADD, lastADD, intQ_C_OUTpipe(2))
      begin
         intQ_C_OUTpipeend <= intQ_C_OUTpipe(2);
      end process;
   end generate;

   qcout1 : if C_HAS_Q_C_OUT = 1 generate
      Q_C_OUT <= intQ_C_OUT AFTER timeunit;
   end generate;
   qcout0 : if not (C_HAS_Q_C_OUT = 1) generate
      Q_C_OUT <= 'X';
   end generate;


   g2b1 : if C_HAS_C_OUT = 1 generate
      C_OUT <= intC_OUT;
   end generate;
   g2b0 : if not(C_HAS_C_OUT = 1) generate
      C_OUT <= 'X';
   end generate;

   g3a1 : if C_HAS_Q_OVFL = 1 generate
      coutreg : c_reg_fd_v9_1
        generic map(
          C_WIDTH         => 1,
          C_AINIT_VAL     => "0",
          C_SINIT_VAL     => "0",
          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
          C_SYNC_ENABLE   => C_SYNC_ENABLE,
          C_HAS_CE        => C_HAS_CE,
          C_HAS_ACLR      => C_HAS_ACLR_PIPE,
          C_HAS_SCLR      => C_HAS_SCLR_INIT,
          C_HAS_ASET      => C_HAS_ASET_PIPE,
          C_HAS_SSET      => C_HAS_SSET_PIPE,
          C_HAS_AINIT     => C_HAS_AINIT_PIPE,
          C_HAS_SINIT     => 0,--C_HAS_SINIT_PIPE, CR206054
          C_ENABLE_RLOCS  => C_ENABLE_RLOCS
          )
        port map(
          D(0)  => intQ_OVFLpipeend,
          CLK   => CLK,
          CE    => intQCE,
          ACLR  => intACLR_INIT,
          ASET  => ASET,
          AINIT => AINIT,
          SCLR  => intSCLR_INIT,
          SSET  => intSSET,
          SINIT => intSINIT,
          Q(0)  => intQ_OVFL
          );

   end generate;
   pipeq_ovfl : process (CLK)
   begin

     if rising_edge(clk) then
       if intSCLR = '1' then
         pipeloop0 : for p in 2 to C_LATENCY loop
            intQ_OVFLpipe(p) <= '0';
         end loop;  -- pipeloop
       elsif intQCE = '1' and C_LATENCY > 1 then
         pipeloop : for p in 2 to C_LATENCY-1 loop
            intQ_OVFLpipe(p) <= intQ_OVFLpipe(p+1);
         end loop;  -- pipeloop
         intQ_OVFLpipe(C_LATENCY) <= intOVFL;
       end if;
     end if;
--      if (((intSCLR = '1' and CLK = '1')
--           --or intACLR = '1' CR204743
--           ) and C_ADD_MODE = c_add ) then
--         pipeloop0 : for p in 2 to C_LATENCY loop
--            intQ_OVFLpipe(p) <= '0';
--         end loop;  -- pipeloop
--      elsif intQCE = '1' and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 then
--         pipeloop : for p in 2 to C_LATENCY-1 loop
--            intQ_OVFLpipe(p) <= intQ_OVFLpipe(p+1);
--         end loop;  -- pipeloop
--
--         intQ_OVFLpipe(C_LATENCY) <= intOVFL;
----      elsif (is_X(intQpipe(C_LATENCY-1))) then
----         intQ_OVFLpipe(2) <= 'X';
--
--      elsif (intQCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
--         pipeloopx : for p in 2 to C_LATENCY-1 loop
--            if intQ_OVFLpipe(p) /= intQ_OVFLpipe(p+1) then
--               intQ_OVFLpipe(p) <= 'X';
--            end if;
--         end loop;  -- pipeloopx
--         if intQ_OVFLpipe(C_LATENCY) /= intOVFL then
--            intQ_OVFLpipe(C_LATENCY) <= 'X';
--         end if;
--      end if;
   end process;  -- pipeq_ovfl

   ps3 : if C_LATENCY < 2 generate
      intQ_OVFLpipeend <= intOVFL;
   end generate;
   ps3b : if C_LATENCY > 1 generate
      pipeqovfltox : process(intADD, lastADD, intQ_OVFLpipe(2))
      begin
         intQ_OVFLpipeend <= intQ_OVFLpipe(2);
      end process;
   end generate;

   qovfl1 : if C_HAS_Q_OVFL = 1 generate
      Q_OVFL <= intQ_OVFL AFTER timeunit;
   end generate;
   qovfl0 : if not (C_HAS_Q_OVFL = 1) generate
      Q_OVFL <= 'X';
   end generate;

   g3b1 : if C_HAS_OVFL = 1 generate
      OVFL <= intOVFL;
   end generate;
   g3b0 : if not (C_HAS_OVFL = 1) generate
      OVFL <= 'X';
   end generate;


   g4a1 : if C_HAS_Q_B_OUT = 1 generate
     signal gated_aclr : std_logic;
   begin
     gated_aclr <= ASET when intACLR_INIT = '0' else '0';
     coutreg : c_reg_fd_v9_1
       generic map(
         C_WIDTH         => 1,
         C_AINIT_VAL     => "1",
         C_SINIT_VAL     => "1",
         C_SYNC_PRIORITY => 1-C_SYNC_PRIORITY,
         C_SYNC_ENABLE   => C_SYNC_ENABLE,
         C_HAS_CE        => C_HAS_CE,
         C_HAS_ACLR      => C_HAS_ASET_PIPE,          
         C_HAS_SCLR      => C_HAS_SSET_PIPE,
         C_HAS_ASET      => C_HAS_ACLR_PIPE,          
         C_HAS_SSET      => C_HAS_SCLR_INIT,  --sset/sclr reversed CR207220
         C_HAS_AINIT     => C_HAS_AINIT_PIPE,
         C_HAS_SINIT     => 0,--C_HAS_SINIT_PIPE, CR206054
         C_ENABLE_RLOCS  => C_ENABLE_RLOCS
         )
       port map(
         D(0)  => intQ_B_OUTpipeend,
         CLK   => CLK,
         CE    => intQCE,
         ACLR  => gated_aclr,--ASET,
         ASET  => intACLR_INIT,
         AINIT => AINIT,
         SCLR  => intSSET,
         SSET  => intSCLR_INIT,--sset/sclr reversed CR207220
         SINIT => intSINIT,
         Q(0)  => intQ_B_OUT
         );
      
   end generate;
   pipeq_b_out : process (CLK)
   begin
--      if intQCE = '1'  and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 and (not(is_X(intQpipe(C_LATENCY-1)))) then
      if intQCE = '1'  and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 then

         pipeloop : for p in 2 to C_LATENCY-1 loop
            intQ_B_OUTpipe(p) <= intQ_B_OUTpipe(p+1);
         end loop;  -- pipeloop
         
         intQ_B_OUTpipe(C_LATENCY) <= intB_OUT;
      elsif (intQCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
         pipeloopx : for p in 2 to C_LATENCY-1 loop
            if intQ_B_OUTpipe(p) /= intQ_B_OUTpipe(p+1) then
               intQ_B_OUTpipe(p) <= 'X';
            end if;
         end loop;  -- pipeloopx
         if intQ_B_OUTpipe(C_LATENCY) /= intB_OUT then
            intQ_B_OUTpipe(C_LATENCY) <= 'X';
         end if;
      end if;
      
   end process;  -- pipeq_b_out

   ps4 : if C_LATENCY < 2 generate
      intQ_B_OUTpipeend <= intB_OUT;
   end generate;
   ps4b : if C_LATENCY > 1 generate
      pipeqbtox : process(intADD, lastADD, intQ_B_OUTpipe(2))
      begin
         intQ_B_OUTpipeend <= intQ_B_OUTpipe(2);
      end process;
   end generate;

   qbout1 : if C_HAS_Q_B_OUT = 1 generate
      Q_B_OUT <= intQ_B_OUT AFTER timeunit;
   end generate;
   qbout0 : if not (C_HAS_Q_B_OUT = 1) generate
      Q_B_OUT <= 'X';
   end generate;

   g4b1 : if C_HAS_B_OUT = 1 generate
      B_OUT <= intB_OUT;
   end generate;
   g4b0 : if not(C_HAS_B_OUT = 1) generate
      B_OUT <= 'X';
   end generate;

   
end behavioral;




