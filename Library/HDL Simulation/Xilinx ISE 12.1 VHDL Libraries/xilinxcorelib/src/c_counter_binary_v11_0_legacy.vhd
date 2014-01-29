-- $RCSfile: c_counter_binary_v11_0_legacy.vhd,v $ $Revision: 1.4 $ $Date: 2009/12/04 11:46:41 $
--  (c) Copyright 1995-2005 Xilinx, Inc. All rights reserved.
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

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;             -- for UNSIGNED data type

LIBRARY XilinxCoreLib;

USE XilinxCoreLib.bip_utils_pkg_v2_0.ALL;
USE XilinxCoreLib.bip_utils_pkg_v2_0.ALL;
USE XilinxCoreLib.bip_utils_pkg_v2_0.ALL;
--Use XilinxCoreLib.c_reg_fd_v11_0_comp.all;
USE XilinxCoreLib.c_addsub_pkg_v11_0.ALL;
USE XilinxCoreLib.c_compare_v11_0_comp.ALL;
USE XilinxCoreLib.c_mux_bus_v11_0_comp.ALL;
--Use XilinxCoreLib.c_gate_bit_v11_0_comp.all;

-- Synchronous binary counter
--

ENTITY c_counter_binary_v11_0_legacy IS
  GENERIC (
    c_family         : string;
    c_width          : INTEGER;
    c_restrict_count : INTEGER;
    c_count_to       : STRING;
    c_count_by       : STRING;
    c_count_mode     : INTEGER;
    c_thresh0_value  : STRING;
    c_thresh1_value  : STRING;
    c_thresh_early   : INTEGER;
    c_ainit_val      : STRING;
    c_sinit_val      : STRING;
    c_load_enable    : INTEGER;
    c_sync_enable    : INTEGER;
    c_sync_priority  : INTEGER;
    c_pipe_stages    : INTEGER;
    c_has_thresh0    : INTEGER;
    c_has_q_thresh0  : INTEGER;
    c_has_thresh1    : INTEGER;         -- deprecated
    c_has_q_thresh1  : INTEGER;         -- deprecated
    c_has_ce         : INTEGER;
    c_has_up         : INTEGER;
    c_has_iv         : INTEGER;
    c_has_l          : INTEGER;
    c_has_load       : INTEGER;
    c_load_low       : INTEGER;         -- deprecated
    c_has_aclr       : INTEGER;
    c_has_aset       : INTEGER;
    c_has_ainit      : INTEGER;
    c_has_sclr       : INTEGER;
    c_has_sset       : INTEGER;
    c_has_sinit      : INTEGER;
    c_enable_rlocs   : INTEGER
    ); 

  PORT (
    clk       : IN  STD_LOGIC                            := '0';  -- optional clock
    up        : IN  STD_LOGIC                            := '1';  -- controls direction of count - '1' = up.
    ce        : IN  STD_LOGIC                            := '1';  -- optional clock enable
    load      : IN  STD_LOGIC                            := '0';  -- optional synch load trigger
    l         : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- optional synch load value
    iv        : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- optional increment value
    aclr      : IN  STD_LOGIC                            := '0';  -- asynch init.
    aset      : IN  STD_LOGIC                            := '0';  -- optional asynch set to '1'
    ainit     : IN  STD_LOGIC                            := '0';  -- optional asynch reset to init_val
    sclr      : IN  STD_LOGIC                            := '0';  -- synch init.
    sset      : IN  STD_LOGIC                            := '0';  -- optional synch set to '1'
    sinit     : IN  STD_LOGIC                            := '0';  -- optional synch reset to init_val
    thresh0   : OUT STD_LOGIC                            := '1';
    q_thresh0 : OUT STD_LOGIC                            := '1';
    thresh1   : OUT STD_LOGIC                            := '1';
    q_thresh1 : OUT STD_LOGIC                            := '1';
    q         : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)  -- output value
    );
END c_counter_binary_v11_0_legacy;

ARCHITECTURE behavioral OF c_counter_binary_v11_0_legacy IS

-------------------------------------------------------------------------------
-- code copied from hdl for check generics starts here
-------------------------------------------------------------------------------
  -- Types inherited from pkg_baseblox:
  -- TYPE T_SYNC_ENABLE        IS (SYNC_OVERRIDES_CE, CE_OVERRIDES_SYNC);
  -- TYPE T_REG_PRIORITY       IS (RESET_OVERRIDES_SET,SET_OVERRIDES_RESET);

  -- Local types:
  TYPE t_count_mode IS (count_up, count_down, count_updown);
  TYPE t_load_enable IS (ce_overrides_load, load_overrides_ce);

  CONSTANT max_width  : INTEGER                                := 256;
  CONSTANT all0s      : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := (OTHERS      => '0');
  CONSTANT all1s      : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := (OTHERS      => '1');
  -- 2 ** c_width in a constant
  -- simply doing 2 ** c_width will cause overflow with c_width >=32!
--  CONSTANT maxplusone : UNSIGNED(c_width DOWNTO 0)             := ('1', OTHERS => '0');-- this is actually illegal VHDL-error from NCVHDL
  CONSTANT lotsofzeros : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');
  CONSTANT maxplusone  : UNSIGNED(c_width DOWNTO 0)           := UNSIGNED(STD_LOGIC_VECTOR("1" & lotsofzeros));  

  FUNCTION fn_select_count_mode (c_count_mode : INTEGER) RETURN t_count_mode IS
    VARIABLE ret_val : t_count_mode;
  BEGIN
    CASE c_count_mode IS
      WHEN c_up     => ret_val := count_up;
      WHEN c_down   => ret_val := count_down;
      WHEN c_updown => ret_val := count_updown;
      WHEN OTHERS   => ASSERT FALSE REPORT "ERROR - counter_binary: Invalid value found in c_count_mode"
                         SEVERITY FAILURE;  -- can't happen
    END CASE;
    RETURN ret_val;
  END;

                                                -- purpose: decide the appropriate mode of operation for the ADDSUB based on the counter's mode.
  FUNCTION count_mode2add_mode (mode : t_count_mode) RETURN INTEGER IS
    VARIABLE ret_val : INTEGER;
  BEGIN
    CASE mode IS
      WHEN count_up     => ret_val := c_add;
      WHEN count_down   => ret_val := c_sub;
      WHEN count_updown => ret_val := c_add_sub;
      WHEN OTHERS       => ASSERT FALSE REPORT "ERROR - counter_binary: invalid count mode in count_mode2add_mode"
                             SEVERITY FAILURE;  -- can't happen
    END CASE;
    RETURN ret_val;
  END;

  FUNCTION fn_select_load_enable (c_load_enable : INTEGER) RETURN t_load_enable IS
    VARIABLE ret_val : t_load_enable;
  BEGIN
    CASE c_load_enable IS
      WHEN c_override    => ret_val := load_overrides_ce;
      WHEN c_no_override => ret_val := ce_overrides_load;
      WHEN OTHERS        => ASSERT FALSE REPORT "ERROR - counter_binary: Invalid value found in c_load_enable"
                              SEVERITY FAILURE;
    END CASE;
    RETURN ret_val;
  END;

                                        -- Clean versions of generics:
  CONSTANT enum_c_count_mode    : t_count_mode   := fn_select_count_mode (c_count_mode);
  CONSTANT enum_c_load_enable   : t_load_enable  := fn_select_load_enable(c_load_enable);
  CONSTANT enum_c_sync_enable   : t_sync_enable  := fn_select_sync_enable(c_sync_enable);
  CONSTANT enum_c_sync_priority : t_reg_priority := fn_select_sync_priority(c_sync_priority);

                                        -- convert these generics to std_logic_vectors and pad with '0's
                                        -- nomenclature: ci = constant internal...
  CONSTANT ci_count_by    : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_count_by, c_width);
  CONSTANT ci_count_to    : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_count_to, c_width);
  signal diag_count_to : std_logic_vector(c_width - 1 downto 0) := ci_count_to;
  CONSTANT ci_ainit_val   : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_ainit_val, c_width);
  CONSTANT ci_sinit_val   : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_sinit_val, c_width);
  CONSTANT ci_thresh0_val : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_thresh0_value, c_width);
  SIGNAL temp_thresh0_val : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_thresh0_value, c_width);
                                        -- Not needed; use of thresh1 is deprecated
                                        -- CONSTANT ci_thresh1_val : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0) := str_to_bound_slv_0(c_thresh1_val, c_width);

                                        -- Calculates the power-on-reset value for the counter.
                                        -- this value depends on the pins present (aclr,aset,ainit,sclr,sset,sinit).
                                        -- If none are present, defaults to c_ainit_val.
  FUNCTION get_POR_value RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret_val : STD_LOGIC_VECTOR(c_width - 1 DOWNTO 0);
  BEGIN
    ret_val := ci_ainit_val;            -- default for no pins
    IF c_has_aclr = 1 THEN
      ret_val := (OTHERS => '0');
    ELSIF c_has_aset = 1 THEN
      ret_val := (OTHERS => '1');
    ELSIF c_has_ainit = 1 THEN
      ret_val := ci_ainit_val;
    ELSIF c_has_sclr = 1 OR c_restrict_count = 1 THEN
                                        -- the internal register will have an SCLR if the counter is restricted
      ret_val := (OTHERS => '0');
    ELSIF c_has_sset = 1 THEN
      ret_val := (OTHERS => '1');
    ELSIF c_has_sinit = 1 THEN
      ret_val := ci_sinit_val;
    END IF;
    RETURN ret_val;
  END;

  function fn_restrict_count_clause (
    p_restrict_count : integer;
    pi_count_to : std_logic_vector
    ) return integer is
  begin
    if p_restrict_count = 1 then
      if pi_count_to = all1s then
        return 0;
      end if;
    end if;
    return 0;
  end fn_restrict_count_clause;
  constant ci_restrict_count : integer := fn_restrict_count_clause(c_restrict_count,ci_count_to);
  
                                        -- Purpose: ensure that the generics supplied do not demand a nonsensical or unsupported case
                                        -- There are a _lot_ of nonsensical combinations!
  FUNCTION check_generics(
    p_width           : INTEGER;
    p_restrict_count  : INTEGER;
    pi_count_to       : STD_LOGIC_VECTOR;
    pi_count_by       : STD_LOGIC_VECTOR;
    enum_p_count_mode : T_COUNT_MODE;
    pi_thresh0_val    : STD_LOGIC_VECTOR;
--    pi_thresh1_val    : STD_LOGIC_VECTOR;
    p_thresh_early    : INTEGER;
    pi_ainit_val      : STD_LOGIC_VECTOR;
    pi_sinit_val      : STD_LOGIC_VECTOR;
    enum_p_load_enable     : T_LOAD_ENABLE;
    enum_p_sync_enable     : T_SYNC_ENABLE;
    enum_p_sync_priority   : T_REG_PRIORITY;
    p_pipe_stages     : INTEGER;
    p_has_thresh0     : INTEGER;
    p_has_q_thresh0   : INTEGER;
    p_has_thresh1     : INTEGER;        -- deprecated
    p_has_q_thresh1   : INTEGER;        -- deprecated
    p_has_ce          : INTEGER;
    p_has_up          : INTEGER;
    p_has_iv          : INTEGER;
    p_has_l           : INTEGER;
    p_has_load        : INTEGER;
    p_load_low        : INTEGER;        -- deprecated
    p_has_aclr        : INTEGER;
    p_has_aset        : INTEGER;
    p_has_ainit       : INTEGER;
    p_has_sclr        : INTEGER;
    p_has_sset        : INTEGER;
    p_has_sinit       : INTEGER;
    p_enable_rlocs    : INTEGER
    )
    RETURN INTEGER IS
  BEGIN
    ASSERT p_has_l = 0 OR (p_has_sclr = 0 AND p_has_sset = 0 AND p_has_sinit = 0) REPORT "Priorities of Sync controls and Load have changed since Version 7.0 for some generic combinations" SEVERITY WARNING;
    ASSERT p_width <= max_width
                      REPORT "ERROR - counter_binary: c_width value of "& int_to_str(p_width) & 
                      " exceeds maximum width (max is " & int_to_str(max_width) & ")"
                      SEVERITY FAILURE;
    ASSERT p_restrict_count = 0 OR p_restrict_count = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_restrict_count (must be 0 or 1)"
      SEVERITY FAILURE;

    ASSERT p_thresh_early = 0 OR p_thresh_early = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_thresh_early (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_thresh0 = 0 OR p_has_thresh0 = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_thresh0 (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_q_thresh0 = 0 OR p_has_q_thresh0 = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_q_thresh0 (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_thresh1 = 0
      REPORT "ERROR - counter_binary: Threshold 1 output deprecated"
      SEVERITY FAILURE;
    ASSERT p_has_q_thresh1 = 0
      REPORT "ERROR - counter_binary: Threshold 1 output deprecated"
      SEVERITY FAILURE;

    ASSERT p_has_ce = 0 OR p_has_ce = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_ce (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_iv = 0
      REPORT "ERROR - counter_binary: Variable increment deprecated - try the accumulator baseblock"
      SEVERITY FAILURE;
    ASSERT p_has_load = 0 OR p_has_load = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_load (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_l = 0 OR p_has_l = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_l (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_load_low = 0
      REPORT "ERROR - counter_binary: Active low load pin no longer implemented in version 8"
      SEVERITY FAILURE;
    ASSERT p_has_aclr = 0 OR p_has_aclr = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_aclr (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_aset = 0 OR p_has_aset = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_aset (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_ainit = 0 OR p_has_ainit = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_ainit (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_sclr = 0 OR p_has_sclr = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_sclr (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_sset = 0 OR p_has_sset = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_sset (must be 0 or 1)"
      SEVERITY FAILURE;
    ASSERT p_has_sinit = 0 OR p_has_sinit = 1
      REPORT "ERROR - counter_binary: Invalid value for generic c_has_sinit (must be 0 or 1)"
      SEVERITY FAILURE;

                                        -- The following ASSERTs regarding restricted counters may seem a little bizarre..
                                        -- Restricted count is implemented using an equality test. Because of that,
                                        -- a counter which counts in increments other than 1 may skip past the count limit
                                        -- and cause unexpected results.

                                        -- Using an equality test saves on logic but opens many trapdoors for the unwary!
                                        -- These generics hopefully will help users when they tread near one of these trapdoors.

                                        -- Not entirely sure what a restricted up/down counter would entail...
    ASSERT p_restrict_count = 0 OR enum_p_count_mode /= count_updown
      REPORT "ERROR - counter_binary: Restricted Up/down counter not allowed"
      SEVERITY FAILURE;

                                        -- Don't allow variable increment with restricted counter
    ASSERT p_restrict_count = 0 OR p_has_iv = 0
      REPORT "ERROR - counter_binary: c_restrict_count is not well-behaved with c_has_iv."
      SEVERITY FAILURE;

                                        -- Nonzero increment!
    ASSERT p_has_iv /= 0 OR pi_count_by /= all0s
      REPORT "ERROR - counter_binary: c_count_by must be nonzero"
      SEVERITY FAILURE;
                                        -- Nonzero limit!
    ASSERT p_restrict_count = 0 OR pi_count_to /= all0s
      REPORT "ERROR - counter_binary: c_count_to must be nonzero"
      SEVERITY FAILURE;

                                        -- Require upper limit to be an integer multiple of (constant) increment
    ASSERT p_restrict_count = 0 OR enum_p_count_mode /= count_up
      OR UNSIGNED(pi_count_to) MOD UNSIGNED(pi_count_by) = 0
      REPORT "ERROR - counter_binary: c_count_to must be a multiple of c_count_by"
      SEVERITY FAILURE;
                                        -- same thing for COUNT_DOWN counters
    ASSERT p_restrict_count = 0 OR enum_p_count_mode /= count_down
      OR (maxplusone - UNSIGNED(pi_count_to)) MOD UNSIGNED(pi_count_by) = 0
      REPORT "ERROR - counter_binary: (2**c_width - c_count_to) must be a multiple of c_count_by"
      SEVERITY FAILURE;

                                        -- Make sure power-on-values, a/sinit, a/set, value loading and suchlike don't mess with restricted counter.
                                        -- This means that any possible value that the counter can be set to
                                        -- must have the following properties:
                                        --  a) it must be a multiple of the c_count_by value
                                        --  b) it must be <= c_count_to.
                                        -- otherwise the counter could get into a position that it would miss the limit.
                                        -- as such, aset and sset are simply not allowed (except in the special case c_count_to = (OTHERS => '1')).
                                        -- ainit and sinit are allowed provided that ainit_val and sinit_val are well-behaved as described above

                                        -- ainit check for up counters
    ASSERT p_restrict_count = 0 OR p_has_ainit = 0 OR enum_p_count_mode /= count_up
      OR (UNSIGNED(pi_ainit_val) MOD
          UNSIGNED(pi_count_by) = 0
          AND pi_ainit_val <= pi_count_to)
      REPORT "ERROR - counter_binary: Given c_ainit_val may cause counter to skip past its c_count_to value; c_ainit_val must should be a multiple of c_count_by less than c_count_to"
      SEVERITY FAILURE;

                                        -- ainit check for down counters
    ASSERT p_restrict_count = 0 OR p_has_ainit = 0 OR enum_p_count_mode /= count_down OR pi_ainit_val = all0s
      OR ( (maxplusone - UNSIGNED(pi_ainit_val)) MOD UNSIGNED(pi_count_by) = 0 AND pi_ainit_val >= pi_count_to)
      REPORT "ERROR - counter_binary: Given c_ainit_val may cause counter to skip past its c_count_to value; c_ainit_val must should be a multiple of c_count_by less than c_count_to"
      SEVERITY FAILURE;

                                        -- sinit check for up counters
    ASSERT p_restrict_count = 0 OR p_has_sinit = 0 OR enum_p_count_mode /= count_up
      OR (UNSIGNED(pi_sinit_val) MOD UNSIGNED(pi_count_by) = 0 AND pi_sinit_val <= pi_count_to)
      REPORT "ERROR - counter_binary: Given c_sinit_val may cause counter to skip past its c_count_to value; c_sinit_val must should be a multiple of c_count_by less than c_count_to"
      SEVERITY FAILURE;
                                        -- sinit check for down counters
    ASSERT p_restrict_count = 0 OR p_has_sinit = 0 OR enum_p_count_mode /= count_down OR pi_sinit_val = all0s
      OR ((maxplusone - UNSIGNED(pi_sinit_val)) MOD UNSIGNED(pi_count_by) = 0 AND pi_sinit_val >= pi_count_to)
      REPORT "ERROR - counter_binary: Given c_sinit_val may cause counter to skip past its c_count_to value; c_sinit_val must should be a multiple of c_count_by less than c_count_to"
      SEVERITY FAILURE;

                                        -- Power-On-Reset value check for up counters
    ASSERT p_restrict_count = 0 OR enum_p_count_mode /= count_up
      OR (UNSIGNED(get_POR_value) MOD UNSIGNED(pi_count_by) = 0 AND get_POR_value <= pi_count_to)
      REPORT "ERROR - counter_binary: Power-on-value will cause counter to miss its c_count_to value"
      SEVERITY FAILURE;
                                        -- POR check for down counters
    ASSERT p_restrict_count = 0 OR enum_p_count_mode /= count_down OR get_POR_value = all0s
      OR ((maxplusone - UNSIGNED(get_POR_value)) MOD UNSIGNED(pi_count_by) = 0 AND get_POR_value >= pi_count_to)
      REPORT "ERROR - counter_binary: Power-on-value will cause counter to miss its c_count_to value"
      SEVERITY FAILURE;


    ASSERT p_restrict_count = 0 OR (pi_count_to /= all1s AND pi_count_to /= all0s)
      REPORT "ERROR - Invalid value for c_count_to - must be in range 1..(2**c_width - 2)"
      SEVERITY FAILURE;
    ASSERT p_restrict_count = 0 OR (p_has_aset = 0 AND p_has_sset = 0)
      REPORT "ERROR - counter_binary: ASET and SSET are disallowed for restricted counters"
      SEVERITY FAILURE;
                                        -- Value loading is not smart enough to detect "too-high" values being loaded.
    ASSERT p_restrict_count = 0 OR (p_has_load = 0 AND p_has_l = 0)
      REPORT "WARNING - counter_binary: The counter will not notice if a value is loaded beyond its c_count_to value"
      SEVERITY WARNING;
                                        -- Extra check to see if counter is more complicated than count-by-one - a count-by-2s up to 10
                                        -- counter will get really confused if 3 is loaded in. (3,5,7,9,11,13.. - misses 10, so doesn't reset)
    ASSERT p_restrict_count = 0 OR (p_has_load = 0 AND p_has_l = 0) OR (p_has_iv = 0 AND UNSIGNED(pi_count_by) = 1)
      REPORT "WARNING - counter_binary: Value loading in a restricted counter may cause the counter to miss its limit"
      SEVERITY WARNING;

                                        -- Up pin should be present if and only if enum_c_count_mode = count_updown
    ASSERT (p_has_up = 1) = (enum_p_count_mode = count_updown)
      REPORT "ERROR - counter_binary: Up pin is required if and only if c_count_mode = c_updown"
      SEVERITY FAILURE;

                                        -- Not allowed threshhold greater than count_to limit for up counters..
    ASSERT p_restrict_count = 0 OR enum_p_count_mode /= count_up OR
      (c_has_thresh0 = 0 AND p_has_q_thresh0 = 0) OR pi_thresh0_val <= pi_count_to
      REPORT "ERROR - counter_binary: c_thresh0_value exceeds c_count_to value and this is an up counter"
      SEVERITY FAILURE;
                                        -- ..or threshhold less than count_to limit for down counters (unless 0)
    ASSERT p_restrict_count = 0 OR enum_p_count_mode /= count_down OR
      (c_has_thresh0 = 0 AND p_has_q_thresh0 = 0) OR pi_thresh0_val = all0s OR pi_thresh0_val >= pi_count_to
      REPORT "ERROR - counter_binary: c_thresh0_value below c_count_to value and this is a down counter"
      SEVERITY FAILURE;

                                        -- No point in having LOAD without L and vice versa...
    ASSERT (p_has_load = 1) = (p_has_l = 1)
      REPORT "ERROR - counter_binary: Need both LOAD and L or neither"
      SEVERITY FAILURE;
    ASSERT p_has_ainit = 0 OR (p_has_aclr = 0 AND p_has_aset = 0)
      REPORT "ERROR - counter_binary: ainit is mutually exclusive with aclr or aset"
      SEVERITY FAILURE;
    ASSERT p_has_sinit = 0 OR (p_has_sclr = 0 AND p_has_sset = 0)
      REPORT "ERROR - counter_binary: sinit is mutually exclusive with sclr or sset"
      SEVERITY FAILURE;

                                        -- Async and sync controls together will create extra logic
    ASSERT (p_has_ainit = 0 AND p_has_aset = 0 AND p_has_aclr = 0) OR
      (p_has_sinit = 0 AND p_has_sset = 0 AND p_has_sclr = 0)
      REPORT "WARNING - counter_binary: Including both asynchronous (aclr, aset or ainit) and synchronous controls (sclr, sset or sinit) will add a layer of logic and impact performance"
      SEVERITY WARNING;
    RETURN 0;
  END check_generics;

                                        -- The following line should make sure that check_generics
                                        -- is called on instantiation
  CONSTANT check_gens : INTEGER := check_generics(
    c_width,
    ci_restrict_count,
    ci_count_to,
    ci_count_by,
    enum_c_count_mode,
    ci_thresh0_val,
--    ci_thresh1_val,
    c_thresh_early,
    ci_ainit_val,
    ci_sinit_val,
    enum_c_load_enable,
    enum_c_sync_enable,
    enum_c_sync_priority,
    c_pipe_stages,
    c_has_thresh0,
    c_has_q_thresh0,
    c_has_thresh1,                      -- deprecated
    c_has_q_thresh1,                    -- deprecated
    c_has_ce,
    c_has_up,
    c_has_iv,
    c_has_l,
    c_has_load,
    c_load_low,                         -- deprecated
    c_has_aclr,
    c_has_aset,
    c_has_ainit,
    c_has_sclr,
    c_has_sset,
    c_has_sinit,
    c_enable_rlocs
    );

-------------------------------------------------------------------------------
-- code copied from hdl for check generics ends here
-------------------------------------------------------------------------------

                                   
  CONSTANT timeunit   : TIME    := 100 ps;
  CONSTANT C_OUT_TYPE : INTEGER := 1;

  FUNCTION FN_ADDSUB_HAS_CIN
    RETURN INTEGER IS
  BEGIN  -- FN_ADDSUB_HAS_CIN
    IF C_COUNT_MODE /= 1 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FN_ADDSUB_HAS_CIN;
  
  FUNCTION FN_ADDSUB_HAS_BIN
    RETURN INTEGER IS
  BEGIN  -- FN_ADDSUB_HAS_BIN
    IF C_COUNT_MODE = 1 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END FN_ADDSUB_HAS_BIN;
  
  CONSTANT ADDSUB_HAS_CIN : INTEGER := FN_ADDSUB_HAS_CIN;
  CONSTANT ADDSUB_HAS_BIN : INTEGER := FN_ADDSUB_HAS_BIN;
  
  -- B input to the ADDSUB
  SIGNAL intB        : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  -- Q output
  SIGNAL intQ        : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  -- S output from the ADDSUB
  SIGNAL intFBs      : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  -- signal used to test for threshhold detection
  -- (equal to intFBq when C_THRESH_EARLY = 0, intFBs otherwise)
  SIGNAL intFBs_or_q : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  -- Q output from the ADDSUB
  SIGNAL intFBq      : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  -- obsolete signal which did nothing
--    signal intFBq_or_zero : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
  -- signal which abstracts away increment concerns
  -- it equals the current increment whether it's provided on port IV or
  -- provided by generic C_COUNT_BY.
  SIGNAL intCount_by : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := str_to_bound_slv_0(C_COUNT_BY, C_WIDTH);

  -- just a useful thing to have around.
  SIGNAL all_zeros : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL all_ones  : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '1');

  -- signals for optional pins...
  SIGNAL intUP          : STD_LOGIC;  -- equals '1' for c_up counters and '0' for c_down counters, otherwise equals port UP
  SIGNAL intUPbar       : STD_LOGIC;    -- what it says on the tin
  SIGNAL intCE          : STD_LOGIC;
  SIGNAL intCE_for_comp : STD_LOGIC;    -- clock enable for comparators
  SIGNAL intLOAD        : STD_LOGIC;
  SIGNAL intL           : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  SIGNAL gatedSINIT     : STD_LOGIC;  -- gated against CE if C_SYNC_ENABLE = c_no_override
  SIGNAL intACLR        : STD_LOGIC;  -- equals '0' if C_HAS_ACLR = 0, otherwise equals ACLR
  SIGNAL intASET        : STD_LOGIC;  -- equals '0' if C_HAS_ASET = 0, otherwise equals ASET
  SIGNAL intAINIT       : STD_LOGIC;  -- equals '0' if C_HAS_AINIT = 0, otherwise equals AINIT
  SIGNAL intSCLR        : STD_LOGIC;  -- equals '0' if C_HAS_SCLR = 0, otherwise equals SCLR
  SIGNAL intSSET        : STD_LOGIC;  -- equals '0' if C_HAS_SSET = 0, otherwise equals SSET
  SIGNAL intSINIT       : STD_LOGIC;  -- equals '0' if C_HAS_SINIT = 0, otherwise equals SINIT
  SIGNAL intSCLR_RESET  : STD_LOGIC;    -- SCLR for ADDSUB

  SIGNAL intSCLR_for_thresh : STD_LOGIC;  -- SCLR for comp0
  SIGNAL intACLR_for_thresh : STD_LOGIC;  -- ACLR for comp0

  SIGNAL intSCLR_for_th_to   : STD_LOGIC;  -- SCLR for comp_to
  SIGNAL intSSET_for_th_to   : STD_LOGIC;  -- SSET for comp_to
  SIGNAL intCount_to_reached : STD_LOGIC := '0';
  -- ACLR and ASET for comp_to
  SIGNAL ACLR_for_th_to      : STD_LOGIC;
  SIGNAL ASET_for_th_to      : STD_LOGIC;

  SIGNAL intThresh0 : STD_LOGIC;

  -- to allow LOAD with IV, both signals must be multiplexed into port B of the ADDSUB.
  -- this signal is for that purpose.
  SIGNAL intB_or_load : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');

  -- see explanation at cnt1: IF GENERATE statement
  SIGNAL intXLOAD : STD_LOGIC;
  SIGNAL intXL    : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);

  --CR206717 string length/ index error due to use of legacy string_to_slv_0 function.
--  FUNCTION tostdlogic(s : STRING) RETURN STD_LOGIC_VECTOR
--  IS
--    VARIABLE logic : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
--  BEGIN
--    FOR i IN 1 TO s'LENGTH LOOP
--      IF s(i) = '1' THEN
--        logic(s'LENGTH-i) := '1';
--      ELSE
--        logic(s'LENGTH-i) := '0';
--      END IF;
--    END LOOP;
--    RETURN logic;
--  END;

--  SIGNAL intSINITVAL : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := tostdlogic(C_SINIT_VAL);
  SIGNAL intSINITVAL : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := ci_sinit_val;

  FUNCTION lower_case(c : CHARACTER) RETURN CHARACTER
  IS
  BEGIN
    IF c >= 'A' AND c <= 'Z' THEN
      RETURN CHARACTER'VAL(CHARACTER'POS(c) + 32);
    ELSE RETURN c;
    END IF;
  END;

  -- compare two strings ignoring case
  FUNCTION strcmp(a, b : STRING) RETURN BOOLEAN
  IS
    ALIAS a_val             : STRING(1 TO a'LENGTH) IS a;
    ALIAS b_val             : STRING(1 TO b'LENGTH) IS b;
    VARIABLE a_char, b_char : CHARACTER;
  BEGIN
    IF a'LENGTH /= b'LENGTH THEN
      RETURN FALSE;
    ELSIF a = b THEN
      RETURN TRUE;
    END IF;
    FOR i IN 1 TO a'LENGTH LOOP
      a_char := lower_case(a_val(i));
      b_char := lower_case(b_val(i));
      IF a_char /= b_char THEN
        RETURN FALSE;
      END IF;
    END LOOP;
    RETURN TRUE;
  END;

  FUNCTION get_ainit_val(C_COUNT_TO : STRING; C_AINIT_VAL : STRING; C_HAS_AINIT : INTEGER) RETURN STRING IS
  BEGIN
    IF (C_HAS_AINIT = 1) AND (C_COUNT_TO = C_AINIT_VAL) THEN
      RETURN "1";
    ELSE
      RETURN "0";
    END IF;
  END;

  FUNCTION stringZero(test : STRING) RETURN BOOLEAN IS
    VARIABLE zero : STRING(test'RANGE);
  BEGIN
    FOR i IN test'RANGE LOOP
      zero(i) := '0';
    END LOOP;
    RETURN strcmp(test, zero);
  END stringZero;
  
BEGIN

  -- Deal with optional pins...
  ce1 : IF C_HAS_CE = 1 GENERATE
    intCE <= CE;
    ce1loaden1 : IF C_HAS_LOAD = 1 AND C_LOAD_ENABLE = c_override GENERATE
      -- because LOAD will override CE on the ADDSUB, it must do on the
      -- comparators. There is no convenient equivalent of C_LOAD_ENABLE on
      -- them, so it must be done manually.
      --
      -- There is a hazard here; if C_SYNC_ENABLE = c_no_override and
      -- C_LOAD_ENABLE = c_override then when CE is low, LOAD should override
      -- S{CLR,SET,INIT} - because the sync controls should have no effect
      -- with a low CE. Merely gating the CE to the comparator will not achieve this;
      -- the internal signals intS{CLR,SET,INIT} must be gated with CE (see sclr1en0: later)
      -- before they arrive at the comparator.
      intCE_for_comp <= CE OR intLOAD;
    END GENERATE;
    ce1loaden0 : IF NOT(C_HAS_LOAD = 1 AND C_LOAD_ENABLE = c_override) GENERATE
      intCE_for_comp <= CE;
    END GENERATE;
  END GENERATE;
  ce0 : IF NOT (C_HAS_CE = 1) GENERATE
    intCE          <= '1';
    intCE_for_comp <= '1';
  END GENERATE;

  up1 : IF C_HAS_UP = 1 GENERATE  -- UP pin only valid for an up/down counter
    intUP <= UP;
  END GENERATE;
  up0 : IF NOT (C_HAS_UP = 1) GENERATE  -- otherwise constant
    up00 : IF C_COUNT_MODE = c_up GENERATE
      intUP <= '1';
    END GENERATE;
    up01 : IF C_COUNT_MODE = c_down GENERATE
      intUP <= '0';
    END GENERATE;
  END GENERATE;

  intUPbar <= NOT intUP;

  l1 : IF C_HAS_L = 1 GENERATE
    intL <= L;
  END GENERATE;
  l0 : IF NOT (C_HAS_L = 1) GENERATE
    intL <= (OTHERS => '0');
  END GENERATE;

  iv1 : IF C_HAS_IV = 1 GENERATE
    intB <= IV;
  END GENERATE;
  iv0 : IF NOT (C_HAS_IV = 1) GENERATE
    intB <= intCount_by;
  END GENERATE;

  load1 : IF C_HAS_LOAD = 1 GENERATE
    load1_low : IF C_LOAD_LOW = 1 GENERATE
      intLOAD <= NOT LOAD;
    END GENERATE;
    load1_high : IF C_LOAD_LOW = 0 GENERATE
      intLOAD <= LOAD;
    END GENERATE;
  END GENERATE;
  load0 : IF NOT (C_HAS_LOAD = 1) GENERATE
    intLOAD <= '0';
  END GENERATE;

  gatedsinit1 : IF C_HAS_SINIT = 1 GENERATE
    gatedsinit1en1 : IF C_SYNC_ENABLE = c_override GENERATE
      gatedSINIT <= SINIT;
    END GENERATE;
    gatedsinit1en0 : IF c_SYNC_ENABLE = c_no_override GENERATE
      gatedSINIT <= SINIT AND CE;
    END GENERATE;
  END GENERATE;
  gatedsinit0 : IF NOT (C_HAS_SINIT = 1) GENERATE
    gatedSINIT <= '0';
  END GENERATE;

  aclr1 : IF C_HAS_ACLR = 1 GENERATE
    intACLR <= ACLR;
  END GENERATE;
  aclr0 : IF C_HAS_ACLR = 0 GENERATE
    intACLR <= '0';
  END GENERATE;

  aset1 : IF C_HAS_ASET = 1 GENERATE
    intASET <= ASET;
  END GENERATE;
  aset0 : IF C_HAS_ASET = 0 GENERATE
    intASET <= '0';
  END GENERATE;

  ainit1 : IF C_HAS_AINIT = 1 GENERATE
    intAINIT <= AINIT;
  END GENERATE;
  ainit0 : IF C_HAS_AINIT = 0 GENERATE
    intAINIT <= '0';
  END GENERATE;

  sclr1 : IF C_HAS_SCLR = 1 GENERATE
    sclr1en1 : IF C_SYNC_ENABLE = c_override OR C_HAS_CE = 0 GENERATE
      intSCLR <= SCLR;
    END GENERATE;
    sclr1en0 : IF NOT(C_SYNC_ENABLE = c_override OR C_HAS_CE = 0) GENERATE
      intSCLR <= SCLR AND CE;
    END GENERATE;
  END GENERATE;
  sclr0 : IF NOT (C_HAS_SCLR = 1) GENERATE
    intSCLR <= '0';
  END GENERATE;

  sset1 : IF C_HAS_SSET = 1 GENERATE
    sset1en1 : IF C_SYNC_ENABLE = c_override OR C_HAS_CE = 0 GENERATE
      intSSET <= SSET;
    END GENERATE;
    sset1en0 : IF NOT(C_SYNC_ENABLE = c_override OR C_HAS_CE = 0) GENERATE
      intSSET <= SSET AND CE;
    END GENERATE;
  END GENERATE;
  sset0 : IF NOT (C_HAS_SSET = 1) GENERATE
    intSSET <= '0';
  END GENERATE;

  sinit1 : IF C_HAS_SINIT = 1 GENERATE
    sinit1en1 : IF C_SYNC_ENABLE = c_override OR C_HAS_CE = 0 GENERATE
      intSINIT <= SINIT;
    END GENERATE;
    sinit1en0 : IF NOT(C_SYNC_ENABLE = c_override OR C_HAS_CE = 0) GENERATE
      intSINIT <= SINIT AND CE;
    END GENERATE;
  END GENERATE;
  sinit0 : IF NOT (C_HAS_SINIT = 1) GENERATE
    intSINIT <= '0';
  END GENERATE;

  sinit_eq_countto : IF C_SINIT_VAL = C_COUNT_TO GENERATE
    intSCLR_for_th_to <= intSCLR OR intSSET;
    intSSET_for_th_to <= intSINIT;
  END GENERATE;
  sinit_ne_countto : IF C_SINIT_VAL /= C_COUNT_TO GENERATE
    intSCLR_for_th_to <= intSCLR OR intSSET OR intSINIT;
    intSSET_for_th_to <= '0';
  END GENERATE;

  aclrforthtogen1 : IF (C_HAS_AINIT = 1 AND C_AINIT_VAL /= C_COUNT_TO) GENERATE
  BEGIN
    ii1 : IF (C_HAS_ACLR = 1) GENERATE
      ACLR_for_th_to <= ACLR OR AINIT;
    END GENERATE;
    ii2 : IF (C_HAS_ACLR = 0) GENERATE
      ACLR_for_th_to <= AINIT;
    END GENERATE;
    ASET_for_th_to <= '0';
  END GENERATE;
  aclrforthtogen2 : IF (C_HAS_AINIT = 1 AND C_AINIT_VAL = C_COUNT_TO) GENERATE
    ACLR_for_th_to <= ACLR;
    ASET_for_th_to <= AINIT;
  END GENERATE;
  aclrforthtogen3 : IF (C_HAS_AINIT = 0) GENERATE
    ACLR_for_th_to <= ACLR;
    ASET_for_th_to <= '0';
  END GENERATE;

  intSCLR_RESET <= (intSCLR OR (intCount_to_reached AND intCE AND NOT(intXLOAD)));

  -- any initialisation will clear the q_thresh0 register.
  intSCLR_for_thresh <= intSCLR OR intSSET OR intSINIT;
  intACLR_for_thresh <= intACLR OR intASET OR intAINIT;

  -- hack to deal with the fact that with restricted counters, SINIT is fed
  -- in through the B line of the ADDSUB and comes out of the S line.
  -- To make behaviour consistent with unrestricted counters (where the
  -- thresh0 output doesn't predict SINIT coming up), gate the output.
  tchack1 : IF C_THRESH_EARLY = 1 AND C_RESTRICT_COUNT = 1 AND C_HAS_SINIT = 1 GENERATE
--    THRESH0 <= intThresh0 AND NOT SINIT;
    THRESH0 <= intThresh0 AND NOT intSINIT;  --bugfix G.Old Note 1
  END GENERATE;
  tchack0 : IF NOT( C_THRESH_EARLY = 1 AND C_RESTRICT_COUNT = 1 AND C_HAS_SINIT = 1 ) GENERATE
    THRESH0 <= intThresh0;
  END GENERATE;

  tcearly1 : IF C_THRESH_EARLY = 1 GENERATE
    intFBs_or_q <= intFBs;  -- test against next value to arrive in counter
  END GENERATE;
  tcearly0 : IF NOT (C_THRESH_EARLY = 1) GENERATE
    intFBs_or_q <= intFBq;  -- test against current value in counter
  END GENERATE;

  -- C_RESTRICT_COUNT runs into problems if C_HAS_SINIT = 1 because
  -- intCount_to_reached tests intFBs - which is usually the _next_
  -- value of Q, but a SCLR/SET/INIT signal will not affect intFBs,
  -- only intFBq. For this reason SINIT is handled internally rather
  -- than being passed into the ADDSUB module - by (ab)using the intXLOAD
  -- data path. That way, when SINIT is held high, SINIT_VAL is put into
  -- port B on the ADDSUB module, and BYPASS is asserted - so that
  -- SINIT_VAL gets output on intFBs immediately, as well as intFBq
  -- on the next clock cycle.
  --
  -- The intXLOAD and intXL signals are therefore signals to carry
  -- either LOAD data or SINIT data to the ADDSUB module.
  --
  -- This could be achieved in a much simpler way by having the
  -- intCount_to_reached a combinatorial equality test with intFBq
  -- rather than a synchronous equality test with intFBs. However
  -- because the behavioural model is not my code, I'm trying to modify
  -- it as little as possible to test against the RTL model (which is
  -- my code).
  cnt1 : IF (C_RESTRICT_COUNT = 1 AND C_HAS_SINIT = 1) GENERATE
    cnt1load1 : IF C_HAS_LOAD = 1 GENERATE
      cntmux : c_mux_bus_v11_0
        GENERIC MAP(
          C_WIDTH        => C_WIDTH,
          C_INPUTS       => 2,
          C_SEL_WIDTH    => 1,
          C_HAS_O        => 1,
          C_HAS_Q        => 1,
          C_LATENCY      => 1,
          C_HAS_CE       => 0,
          C_HAS_EN       => 0,
          C_ENABLE_RLOCS => C_ENABLE_RLOCS
          )
        PORT MAP(
          MA   => intL,
          MB   => intSINITVAL,
          S(0) => gatedSINIT,           -- SINIT overrides LOAD
          O    => intXL
          );

      cnt1load1ce1 : IF (C_HAS_CE = 1) GENERATE
        cnt1load1or1 : IF (C_LOAD_ENABLE /= C_SYNC_ENABLE) GENERATE
          cnt1load1or1e1 : IF (C_SYNC_ENABLE = c_override) GENERATE
            intXLOAD <= intSINIT OR (intLOAD AND CE);  --bugfix G.Old Note 1
          END GENERATE;
          cnt1load1or1e0 : IF NOT (C_SYNC_ENABLE = c_override) GENERATE
            intXLOAD <= intLOAD OR (intSINIT AND CE);  --bugfix G.Old Note 1
          END GENERATE;
        END GENERATE;
        cnt1load1or0 : IF NOT (C_LOAD_ENABLE /= C_SYNC_ENABLE) GENERATE
          cnt1load1or0e1 : IF (C_SYNC_ENABLE = c_override) GENERATE
            intXLOAD <= intLOAD OR intSINIT;           --bugfix G.Old Note 1
          END GENERATE;
          cnt1load1or0e0 : IF (C_SYNC_ENABLE = c_no_override) GENERATE
            intXLOAD <= (intLOAD OR intSINIT) AND CE;  --bugfix G.Old Note 1
          END GENERATE;
        END GENERATE;
      END GENERATE;
      cnt1load1ce0 : IF NOT (C_HAS_CE = 1) GENERATE
        intXLOAD <= intLOAD OR intSINIT;               --bugfix G.Old Note 1
      END GENERATE;
      -- Instance an addsub module (use the baseblox _legacy component => .not
      -- the top-level c_addsub_v11_0)
      the_addsub : c_addsub_v11_0_legacy
        GENERIC MAP(
          C_A_WIDTH       => C_WIDTH,
          C_B_WIDTH       => C_WIDTH,
          C_OUT_WIDTH     => C_WIDTH,
          C_LOW_BIT       => 0,
          C_HIGH_BIT      => C_WIDTH-1,
          C_ADD_MODE      => C_COUNT_MODE,
          C_A_TYPE        => C_OUT_TYPE,
          C_B_TYPE        => C_OUT_TYPE,
          C_B_CONSTANT    => 0,
          C_B_VALUE       => "",
          C_AINIT_VAL     => C_AINIT_VAL,
          C_SINIT_VAL     => C_SINIT_VAL,
          C_BYPASS_ENABLE => c_override,  --C_LOAD_ENABLE,  -- DLUNN CHANGED FROM 0,
          C_BYPASS_LOW    => 0,
          C_SYNC_ENABLE   => C_SYNC_ENABLE,
          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
          C_PIPE_STAGES   => C_PIPE_STAGES,
          C_HAS_S         => 1,
          C_HAS_Q         => 1,
          C_HAS_C_IN      => ADDSUB_HAS_CIN,--1,
          C_HAS_C_OUT     => 0,
          C_HAS_Q_C_OUT   => 0,
          C_HAS_B_IN      => ADDSUB_HAS_BIN,
          C_HAS_B_OUT     => 0,
          C_HAS_Q_B_OUT   => 0,
          C_HAS_OVFL      => 0,
          C_HAS_Q_OVFL    => 0,
          C_HAS_CE        => C_HAS_CE,
          C_HAS_ADD       => C_HAS_UP,
          C_HAS_BYPASS    => 1,
          C_HAS_A_SIGNED  => 0,
          C_HAS_B_SIGNED  => 0,
          C_HAS_ACLR      => C_HAS_ACLR,
          C_HAS_ASET      => C_HAS_ASET,
          C_HAS_AINIT     => C_HAS_AINIT,

          -- FIXME -- always equals 1?
          C_HAS_SCLR => BOOLEAN'POS((C_HAS_SCLR = 1) OR (C_RESTRICT_COUNT = 1)),
          C_HAS_SSET => C_HAS_SSET,

          -- FIXME -- always equals 0?
          C_HAS_SINIT    => BOOLEAN'POS((C_HAS_SINIT = 1) AND NOT(C_RESTRICT_COUNT = 1)),
          C_ENABLE_RLOCS => C_ENABLE_RLOCS
          )
        PORT MAP(
          A      => intFBq,             -- intFBq_or_zero
          B      => intB_or_load,
          CLK    => CLK,
          ADD    => intUP,
          CE     => CE,
          C_IN   => intUPbar,  -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
          B_IN   => intUPbar,  -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
          ACLR   => ACLR,
          ASET   => ASET,
          AINIT  => AINIT,
          SCLR   => intSCLR_RESET,
          SSET   => SSET,
          SINIT  => SINIT,
          BYPASS => intXLOAD,
          S      => intFBs,
          Q      => intFBq
          );                            -- Synch Output value

    END GENERATE;

    cnt1load0 : IF NOT (C_HAS_LOAD = 1) GENERATE
      intXL    <= intSINITVAL;
      intXLOAD <= intSINIT;                  --bugfix G.Old note 1
      -- Instance an addsub module (use the baseblox _legacy component => .not
      -- the top-level c_addsub_v11_0)
      the_addsub : c_addsub_v11_0_legacy
        GENERIC MAP(
          C_A_WIDTH       => C_WIDTH,
          C_B_WIDTH       => C_WIDTH,
          C_OUT_WIDTH     => C_WIDTH,
          C_LOW_BIT       => 0,
          C_HIGH_BIT      => C_WIDTH-1,
          C_ADD_MODE      => C_COUNT_MODE,
          C_A_TYPE        => C_OUT_TYPE,
          C_B_TYPE        => C_OUT_TYPE,
          C_B_CONSTANT    => 0, C_B_VALUE => "",
          C_AINIT_VAL     => C_AINIT_VAL,
          C_SINIT_VAL     => C_SINIT_VAL,
--          C_BYPASS_ENABLE => C_LOAD_ENABLE,  -- DLUNN CHANGED FROM 0,
          C_BYPASS_ENABLE => C_SYNC_ENABLE,  -- CR207473 G.Old (SINIT is the
                                             -- only bypass, hence use sync_enable)
          C_BYPASS_LOW    => 0,
          C_SYNC_ENABLE   => C_SYNC_ENABLE,
          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
          C_PIPE_STAGES   => C_PIPE_STAGES,
          C_HAS_S         => 1,
          C_HAS_Q         => 1,
          C_HAS_C_IN      => ADDSUB_HAS_CIN,--1,
          C_HAS_C_OUT     => 0,
          C_HAS_Q_C_OUT   => 0,
          C_HAS_B_IN      => ADDSUB_HAS_BIN,--0,
          C_HAS_B_OUT     => 0,
          C_HAS_Q_B_OUT   => 0,
          C_HAS_OVFL      => 0,
          C_HAS_Q_OVFL    => 0,
          C_HAS_CE        => C_HAS_CE,
          C_HAS_ADD       => C_HAS_UP,
          C_HAS_BYPASS    => 1,
          C_HAS_A_SIGNED  => 0,
          C_HAS_B_SIGNED  => 0,
          C_HAS_ACLR      => C_HAS_ACLR,
          C_HAS_ASET      => C_HAS_ASET,
          C_HAS_AINIT     => C_HAS_AINIT,

          -- FIXME: always equals 1?
          C_HAS_SCLR => BOOLEAN'POS((C_HAS_SCLR = 1) OR (C_RESTRICT_COUNT = 1)),
          C_HAS_SSET => C_HAS_SSET,

          -- FIXME: always equals 0?
          C_HAS_SINIT    => BOOLEAN'POS((C_HAS_SINIT = 1) AND NOT(C_RESTRICT_COUNT = 1)),
          C_ENABLE_RLOCS => C_ENABLE_RLOCS
          )
        PORT MAP(
          A      => intFBq,             -- intFBq_or_zero, 
          B      => intB_or_load,
          CLK    => CLK,
          ADD    => intUP,
          CE     => CE,
          C_IN   => intUPbar,  -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
          B_IN   => intUPbar,  -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
          ACLR   => ACLR,
          ASET   => ASET,
          AINIT  => AINIT,
          SCLR   => intSCLR_RESET,
          SSET   => SSET,
          SINIT  => SINIT,
          BYPASS => intXLOAD,
          S      => intFBs,
          Q      => intFBq
          );                            -- Synch Output value

      
    END GENERATE;

    mux1 : c_mux_bus_v11_0
      GENERIC MAP(
        C_WIDTH        => C_WIDTH,
        C_INPUTS       => 2,
        C_SEL_WIDTH    => 1,
        C_HAS_O        => 1,
        C_HAS_Q        => 1,
        C_LATENCY      => 1,
        C_HAS_CE       => 0,
        C_HAS_EN       => 0,
        C_ENABLE_RLOCS => C_ENABLE_RLOCS
        )
      PORT MAP(
        MA   => intB,
        MB   => intXL,
        S(0) => intXLOAD,
        O    => intB_or_load
        );

  END GENERATE;

  cnt0 : IF NOT (C_RESTRICT_COUNT = 1 AND C_HAS_SINIT = 1) GENERATE
    intXL    <= intL;
    intXLOAD <= intLOAD;
      -- Instance an addsub module (use the baseblox _legacy component => .not
      -- the top-level c_addsub_v11_0)
    the_addsub : c_addsub_v11_0_legacy
      GENERIC MAP(
        C_A_WIDTH             => C_WIDTH,
        C_B_WIDTH             => C_WIDTH,
        C_OUT_WIDTH           => C_WIDTH,
        C_LOW_BIT             => 0,
        C_HIGH_BIT            => C_WIDTH-1,
        C_ADD_MODE            => C_COUNT_MODE,
        C_A_TYPE              => C_OUT_TYPE,
        C_B_TYPE              => C_OUT_TYPE,
        C_B_CONSTANT          => 0,
        C_B_VALUE             => "0",
        C_AINIT_VAL           => C_AINIT_VAL,
        C_SINIT_VAL           => C_SINIT_VAL,
        C_BYPASS_ENABLE       => C_LOAD_ENABLE,  -- DLUNN CHANGED FROM 0,
        C_BYPASS_LOW          => 0,
        C_SYNC_ENABLE         => C_SYNC_ENABLE,
        C_SYNC_PRIORITY       => C_SYNC_PRIORITY,
        C_PIPE_STAGES         => C_PIPE_STAGES,
        C_HAS_S               => 1,
        C_HAS_Q               => 1,
        C_HAS_C_IN            => ADDSUB_HAS_CIN,--1,
        C_HAS_C_OUT           => 0,
        C_HAS_Q_C_OUT         => 0,
        C_HAS_B_IN            => ADDSUB_HAS_BIN,--0,
        C_HAS_B_OUT           => 0,
        C_HAS_Q_B_OUT         => 0,
        C_HAS_OVFL            => 0,
        C_HAS_Q_OVFL          => 0,
        C_HAS_CE              => C_HAS_CE,
        C_HAS_ADD             => C_HAS_UP,
        C_HAS_BYPASS          => C_HAS_LOAD,
        C_HAS_A_SIGNED        => 0,
        C_HAS_B_SIGNED        => 0,
        C_HAS_ACLR            => C_HAS_ACLR,
        C_HAS_ASET            => C_HAS_ASET,
        C_HAS_AINIT           => C_HAS_AINIT,
        C_HAS_SCLR            => BOOLEAN'POS((C_HAS_SCLR = 1) OR (C_RESTRICT_COUNT = 1)),
        C_HAS_SSET            => C_HAS_SSET,
        C_HAS_SINIT           => BOOLEAN'POS((C_HAS_SINIT = 1) AND NOT(C_RESTRICT_COUNT = 1)),
        C_ENABLE_RLOCS        => C_ENABLE_RLOCS,
        C_HAS_BYPASS_WITH_CIN => 0
        )
      PORT MAP(
        A      => intFBq,               -- intFBq_or_zero, 
        B      => intB_or_load,
        CLK    => CLK,
        ADD    => intUP,
        CE     => CE,
        C_IN   => intUPbar,  -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
        B_IN   => intUPbar,  -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
        ACLR   => ACLR,
        ASET   => ASET,
        AINIT  => AINIT,
        SCLR   => intSCLR_RESET,
        SSET   => SSET,
        SINIT  => SINIT,
        BYPASS => intLOAD,
        S      => intFBs,
        Q      => intFBq
        );                              -- Synch Output value

    loadcnt1 : IF (C_HAS_LOAD = 1) GENERATE
      mux1 : c_mux_bus_v11_0
        GENERIC MAP(
          C_WIDTH        => C_WIDTH,
          C_INPUTS       => 2,
          C_SEL_WIDTH    => 1,
          C_HAS_O        => 1,
          C_HAS_Q        => 0,
          C_LATENCY      => 0,
          C_HAS_CE       => 0,
          C_HAS_EN       => 0,
          C_ENABLE_RLOCS => C_ENABLE_RLOCS
          )
        PORT MAP(
          MA   => intB,
          MB   => intXL,
          S(0) => intXLOAD,
          O    => intB_or_load
          );
    END GENERATE;

    loadcnt0 : IF NOT (C_HAS_LOAD = 1) GENERATE
      intB_or_load <= intB;
    END GENERATE;
    
    
  END GENERATE;


--    mxfb : c_mux_bus_v11_0
--                generic map(C_WIDTH => C_WIDTH,
--                            C_INPUTS => 2,
--                            C_SEL_WIDTH => 1,
--                            C_HAS_O => 1,
--                            C_HAS_Q => 0,
--                            C_HAS_EN => 0,
--                            C_ENABLE_RLOCS => C_ENABLE_RLOCS)
--                    port map(MA => intFBq,
--                             MB => all_zeros,
--                             S(0) => intXLOAD,
--                             O => intFBq_or_zero);

  th0 : IF(C_HAS_THRESH0 = 1 OR C_HAS_Q_THRESH0 = 1) GENERATE
    comp0 : c_compare_v11_0
      GENERIC MAP(
        C_WIDTH       => C_WIDTH,
        C_AINIT_VAL   => "0",
--        C_DATA_TYPE   => C_OUT_TYPE,
        C_DATA_TYPE   => 1,             --CR206722
        C_B_CONSTANT  => 1,
        C_B_VALUE     => C_THRESH0_VALUE,
        C_SYNC_ENABLE => C_SYNC_ENABLE,
        C_HAS_CE      => C_HAS_CE,
        C_HAS_ACLR    => BOOLEAN'POS(C_HAS_ACLR = 1 OR C_HAS_ASET = 1 OR C_HAS_AINIT = 1),
        C_HAS_SCLR    => BOOLEAN'POS(C_HAS_SCLR = 1 OR C_HAS_SSET = 1 OR C_HAS_SINIT = 1),
        C_HAS_A_EQ_B  => C_HAS_THRESH0,
        C_HAS_QA_EQ_B => C_HAS_Q_THRESH0
        )
      PORT MAP(
        A       => intFBs_or_q,
        CLK     => CLK,
        CE      => intCE_for_comp,
        ACLR    => intACLR_for_thresh,
        SCLR    => intSCLR_for_thresh,
        A_EQ_B  => intThresh0,
        QA_EQ_B => Q_THRESH0
        );
  END GENERATE;  -- th0


  th_to : IF(C_RESTRICT_COUNT = 1) GENERATE
  begin

      comp_to : c_compare_v11_0
        GENERIC MAP(
          C_WIDTH       => C_WIDTH,
--          C_DATA_TYPE   => C_OUT_TYPE,
          C_DATA_TYPE   => 1,           --c_unsigned
          C_B_CONSTANT  => 1,
          C_B_VALUE     => C_COUNT_TO,
          C_SYNC_ENABLE => C_SYNC_ENABLE,
          C_HAS_CE      => C_HAS_CE,
          C_HAS_ACLR    => BOOLEAN'POS((C_HAS_ACLR = 1) OR (C_HAS_AINIT = 1 AND C_AINIT_VAL /= C_COUNT_TO)),
          C_HAS_ASET    => BOOLEAN'POS((C_HAS_AINIT = 1) AND (C_AINIT_VAL = C_COUNT_TO)),
          C_HAS_SCLR    => BOOLEAN'POS((C_HAS_SCLR = 1) OR (C_HAS_SSET = 1) OR
                                       (C_HAS_SINIT = 1 AND C_COUNT_TO /= C_SINIT_VAL)),
          C_HAS_SSET    => BOOLEAN'POS(C_HAS_SINIT = 1 AND C_COUNT_TO = C_SINIT_VAL),
          C_HAS_A_EQ_B  => 0,
          C_HAS_QA_EQ_B => 1
          )
        PORT MAP(
          A       => intFBs,
          CLK     => CLK,
          CE      => intCE_for_comp,
          ACLR    => ACLR_for_th_to,
          ASET    => ASET_for_th_to,
          SCLR    => intSCLR_for_th_to,
          SSET    => intSSET_for_th_to,
          QA_EQ_B => intCount_to_reached
          );
  END GENERATE;  -- th_to

  intQ <= intFBq;

  Q <= intQ AFTER timeunit;
  
END behavioral;
