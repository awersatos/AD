-- $RCSfile: c_shift_ram_v9_1.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:53 $
--------------------------------------------------------------------------------
--  Copyright(C) 1995-2006 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY std;
USE std.textio.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v9_1.ALL;
USE xilinxcorelib.prims_utils_v9_1.ALL;
USE xilinxcorelib.pkg_baseblox_v9_1.ALL;
USE xilinxcorelib.c_reg_fd_v9_1_comp.ALL;

ENTITY c_shift_ram_v9_1 IS
  GENERIC (
    c_family             : STRING  := "virtex2";
    c_width              : INTEGER := 16;  -- Default is 16
    c_depth              : INTEGER := 16;  -- Delay line depth (default = 16 = 1x SRL16/SRL32) 
    c_addr_width         : INTEGER := 4;  -- Dependent on c_width value specified
    c_shift_type         : INTEGER := 0;  -- 0=fixed, 1=lossless, 2=lossy
    c_opt_goal           : INTEGER := 0;  -- 0=area, 1=speed
    c_ainit_val          : STRING  := "0000000000000000";  -- Applies only to registered output
    c_sinit_val          : STRING  := "0000000000000000";  -- Applies only to registered output    
    c_default_data       : STRING  := "0000000000000000";  -- If no (MIF) init details, use this val
    c_default_data_radix : INTEGER := 1;  -- 0=no init values, 1=hex ,2=bin, 3=dec
    c_has_a              : INTEGER := 0;  -- Address bus only exists for var length
    c_has_ce             : INTEGER := 0;
    c_reg_last_bit       : INTEGER := 1;  -- Register last output bit (with FF)
    c_sync_priority      : INTEGER := 1;  -- Applies only to registered output
    c_sync_enable        : INTEGER := 0;  -- Applies only to registered output
    c_has_aclr           : INTEGER := 0;  -- Applies only to registered output    
    c_has_aset           : INTEGER := 0;  -- Applies only to registered output
    c_has_ainit          : INTEGER := 0;  -- Applies only to registered output    
    c_has_sclr           : INTEGER := 0;  -- Applies only to registered output
    c_has_sset           : INTEGER := 0;  -- Applies only to registered output
    c_has_sinit          : INTEGER := 0;  -- Applies only to registered output
    c_mem_init_file      : STRING  := "init.mif";
    c_elaboration_dir    : STRING  := "./";
    c_mem_init_radix     : INTEGER := 1;  -- for backwards compatibility
    c_generate_mif       : INTEGER := 0;  -- Unused by the behavioural model    
    c_read_mif           : INTEGER := 0;  -- Redundant in VHDL core
    c_enable_rlocs       : INTEGER := 0   -- Not used with VHDL core
    ); 

  PORT (
    a     : IN  STD_LOGIC_VECTOR(c_addr_width-1 DOWNTO 0) := (OTHERS => '0');
    d     : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)      := (OTHERS => '0');
    clk   : IN  STD_LOGIC                                 := '0';
    ce    : IN  STD_LOGIC                                 := '1';
    aclr  : IN  STD_LOGIC                                 := '0';
    aset  : IN  STD_LOGIC                                 := '0';
    ainit : IN  STD_LOGIC                                 := '0';
    sclr  : IN  STD_LOGIC                                 := '0';
    sset  : IN  STD_LOGIC                                 := '0';
    sinit : IN  STD_LOGIC                                 := '0';
    q     : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)
    ); 
END c_shift_ram_v9_1;
--
-- behavior describing a parameterized ram based shift register
--
ARCHITECTURE behavioral OF c_shift_ram_v9_1 IS

  CONSTANT timeunit : TIME := 100 ps;
  SIGNAL   Qint     : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);

  CONSTANT ci_family : STRING := lcase(c_family);

  -- purpose: converts an SLV to a string with range 1 to N
  FUNCTION std_logic_vector_to_string (slv : STD_LOGIC_VECTOR) RETURN STRING IS
    VARIABLE ret : STRING(1 TO slv'high-slv'low+1);
    VARIABLE y : INTEGER := 1;
  BEGIN  -- FUNCTION std_logic_vector_to_string

    -- account for the fact that the input SLV may be in either range direction
    IF slv'ascending THEN
      FOR i IN slv'left TO slv'right LOOP
        IF slv(i) = '1' THEN
          ret(y) := '1';
        ELSIF (slv(i) = 'X') THEN
          ret(y) := 'X';
        ELSIF (slv(i) = 'Z') THEN
          ret(y) := 'Z';
        ELSIF (slv(i) = 'U') THEN
          ret(y) := 'U';
        ELSIF (slv(i) = '0') THEN
          ret(y) := '0';
        ELSE
          REPORT "Unknown CHARACTER - setting to '0'" SEVERITY warning;
          ret(y) := '0';
        END IF;
        y := y+1;
      END LOOP;
    ELSE
      FOR i IN slv'left DOWNTO slv'right LOOP
        IF slv(i) = '1' THEN
          ret(y) := '1';
        ELSIF (slv(i) = 'X') THEN
          ret(y) := 'X';
        ELSIF (slv(i) = 'Z') THEN
          ret(y) := 'Z';
        ELSIF (slv(i) = 'U') THEN
          ret(y) := 'U';
        ELSIF (slv(i) = '0') THEN
          ret(y) := '0';
        ELSE
          REPORT "Unknown CHARACTER - setting to '0'" SEVERITY warning;
          ret(y) := '0';
        END IF;
        y := y+1;
      END LOOP;
    END IF;

    RETURN ret;    
  END FUNCTION std_logic_vector_to_string;
  
  -- purpose: retargets the lossy shift type, if seelcted for a Virtex5 part, to lossless mode and warns the user
  FUNCTION retarget_shift_type(family : STRING; shift_type : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION retarget_shift_type
    IF family = "virtex5" AND shift_type = c_variable_lossy THEN
      ASSERT false
        REPORT "WARNING: c_shift_ram_v9_1: Variable-length lossy mode not available for Virtex5 - retargeting to variable-length lossless mode..."
        SEVERITY warning;
      RETURN c_variable_lossless;
    ELSE
      RETURN shift_type;
    END IF;
  END FUNCTION retarget_shift_type;

  CONSTANT ci_shift_type : INTEGER := retarget_shift_type(ci_family, c_shift_type);

  -- purpose: works out, based on device family, what size the device's SRL primitive is
  FUNCTION get_srl_depth(family : STRING) RETURN INTEGER IS
  BEGIN  -- FUNCTION get_srl_depth
    IF family = "virtex5" THEN
      RETURN 32;
    ELSE
      RETURN 16;
    END IF;
  END FUNCTION get_srl_depth;

  CONSTANT srl_depth : INTEGER := get_srl_depth(ci_family);

  -- purpose: verifies that the supplied generics are legal for the core
  FUNCTION check_generics(c_width, c_depth, c_has_a, c_addr_width, c_opt_goal, c_shift_type, c_reg_last_bit, c_generate_mif                              : INTEGER;
                          c_has_ainit, c_has_aclr, c_has_aset, c_has_sinit, c_has_sclr, c_has_sset, c_has_ce, c_sync_priority, c_sync_enable, c_read_mif : INTEGER;
                          srl_depth                                                                                                                      : INTEGER;
                          c_default_data, c_family                                                                                                       : STRING)
    RETURN INTEGER IS
  BEGIN

    ASSERT c_family = "spartan2" OR c_family = "virtex" OR c_family = "virtex2" OR c_family = "virtex2p" OR c_family = "spartan3" OR c_family = "virtex4" OR c_family = "virtex5"
      REPORT "ERROR: c_shift_ram_v9_1: Valid c_family values are (case-sensitive): spartan2, virtex, virtex2, virtex2p, spartan3, virtex4, virtex5"
      SEVERITY error;

    -- Ensure generic values are sensible
    ASSERT c_shift_type = 0 OR c_shift_type = 1 OR c_shift_type = 2
      REPORT "ERROR: c_shift_ram_v9_1: Invalid c_shift_type value found - must be c_fixed(0), c_variable_lossless(1) or c_variable_lossy(2)"
      SEVERITY failure;
    ASSERT c_opt_goal = c_area OR c_opt_goal = c_speed REPORT "ERROR: c_shift_ram_v9_1: Invalid c_opt_goal value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_a = 0 OR c_has_a = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_a value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_ce = 0 OR c_has_ce = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_ce value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_reg_last_bit = 0 OR c_reg_last_bit = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_reg_last_bit value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_sync_priority = 0 OR c_sync_priority = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_sync_priority value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_sync_enable = 0 OR c_sync_enable = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_sync_enable value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_aclr = 0 OR c_has_aclr = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_aclr value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_aset = 0 OR c_has_aset = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_aset value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_ainit = 0 OR c_has_ainit = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_ainit value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_sclr = 0 OR c_has_sclr = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_sclr value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_sset = 0 OR c_has_sset = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_sset value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_has_sinit = 0 OR c_has_sinit = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_has_sinit value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_read_mif = 0 OR c_read_mif = 1 REPORT "ERROR: c_shift_ram_v9_1: Invalid c_read_mif value found - must be 0 or 1" SEVERITY failure;
    ASSERT c_generate_mif = 0 REPORT "WARNING: c_shift_ram_v9_1: Writing of .mif files is not supported in this core version" SEVERITY warning;

    ASSERT c_width > 0 AND c_width < 257 REPORT "ERROR: c_shift_ram_v9_1: Invalid width value - the valid range is 1 to 256 inclusive" SEVERITY failure;

    IF c_reg_last_bit = 0 THEN
      ASSERT c_has_ainit = 0 AND c_has_aclr = 0 AND c_has_aset = 0 REPORT "WARNING: c_shift_ram_v9_1: Asynchronous controls not available without registered output" SEVERITY warning;
      ASSERT c_has_sinit = 0 AND c_has_sclr = 0 AND c_has_sset = 0 REPORT "WARNING: c_shift_ram_v9_1: Synchronous controls not available without registered output" SEVERITY warning;
    ELSE                                -- c_reg_last_bit /= 0
      ASSERT c_has_ainit = 0 OR (c_has_aclr = 0 AND c_has_aset = 0)
        REPORT "ERROR: c_shift_ram_v9_1: ASET and/or ACLR cannot exist in conjunction with AINIT"
        SEVERITY failure;
      ASSERT c_has_sinit = 0 OR (c_has_sclr = 0 AND c_has_sset = 0)
        REPORT "ERROR: c_shift_ram_v9_1: SSET and/or SCLR cannot exist in conjunction with SINIT"
        SEVERITY failure;
    END IF;

    ASSERT NOT((c_has_ainit /= 0 OR c_has_aclr /= 0 OR c_has_aset /= 0) AND (c_has_sinit /= 0 OR c_has_sclr /= 0 OR c_has_sset /= 0) AND c_reg_last_bit /= 0)
      REPORT "WARNING: c_shift_ram_v9_1: Including both asynchronous (aclr, aset or ainit) AND synchronous controls " &
      "(sclr, sset or sinit) will add a layer of logic and impact performance"
      SEVERITY warning;

    ASSERT NOT(c_opt_goal = c_speed AND NOT(c_shift_type = c_fixed)) REPORT "NOTE: c_shift_ram_v9_1: Optimising for speed" SEVERITY note;
    ASSERT NOT(c_opt_goal = c_speed AND (c_has_aclr /= 0 OR c_has_aset /= 0 OR c_has_ainit /= 0 OR c_has_sclr /= 0 OR c_has_sset /= 0 OR c_has_sinit /= 0) AND c_reg_last_bit /= 0 AND c_shift_type = c_variable_lossless)
      REPORT "NOTE: c_shift_ram_v9_1: Register controls will only be implemented on the output register and not on pipeline registers" SEVERITY note;
    ASSERT NOT(c_opt_goal = c_speed AND c_has_ce /= 0 AND c_shift_type = c_variable_lossless) REPORT "NOTE: c_shift_ram_v9_1: CE controls will be implemented on all pipeline registers in addition to the output register, if selected" SEVERITY note;

    ASSERT NOT(c_opt_goal = c_area AND NOT(c_shift_type = c_fixed)) REPORT "NOTE: c_shift_ram_v9_1: Optimising for area" SEVERITY note;

    IF c_shift_type = c_fixed THEN
      ASSERT c_has_a = 0 REPORT "WARNING: c_shift_ram_v9_1: Address bus not required for fixed-length shift register" SEVERITY warning;
      IF c_depth /= 0 AND NOT(c_depth = 1 AND c_reg_last_bit = 1) THEN
        IF c_reg_last_bit /= 0 THEN
          ASSERT c_depth > 1 AND c_depth < 1090 REPORT "ERROR: c_shift_ram_v9_1: Invalid RAM depth value for registered output - the valid range is 2 to 1089 inclusive" SEVERITY failure;
        ELSE
          ASSERT c_depth > 0 AND c_depth < 1089 REPORT "ERROR: c_shift_ram_v9_1: Invalid RAM depth value - the valid range is 1 to 1088 inclusive" SEVERITY failure;
        END IF;
      END IF;
    END IF;

    IF c_shift_type = c_variable_lossless OR c_shift_type = c_variable_lossy THEN
      ASSERT c_has_a /= 0 REPORT "ERROR: c_shift_ram_v9_1: Variable-length register must have an address bus input" SEVERITY failure;
--      ASSERT c_addr_width > 3 REPORT "ERROR: c_shift_ram_v9_1: c_addr_width must be at least 4 bits wide" SEVERITY failure;

      ASSERT c_addr_width > 0 REPORT "ERROR: c_shift_ram_v9_1: c_addr_width must be at least 1 bit wide" SEVERITY failure;

      -- V9.1 UPDATE
      -- Just use warnings rather than errors for these depths - this provides backwards-compatability for users who previously just set the address width
      -- to be 4 for all depths <= 16
      IF c_depth <= 2 THEN
        ASSERT c_addr_width = 1 REPORT "WARNING: c_shift_ram_v9_1: Address bus should be 1 for this memory depth - only bits (0 downto 0) will be used" SEVERITY warning;
      ELSIF c_depth > 2 AND c_depth <= 4 THEN
        ASSERT c_addr_width = 2 REPORT "WARNING: c_shift_ram_v9_1: Address bus should be 2 for this memory depth - only bits (1 downto 0) will be used" SEVERITY warning;
      ELSIF c_depth > 4 AND c_depth <= 8 THEN
        ASSERT c_addr_width = 3 REPORT "WARNING: c_shift_ram_v9_1: Address bus should be 3 for this memory depth - only bits (2 downto 0) will be used" SEVERITY warning;
      ELSIF c_depth > 8 AND c_depth <= 16 THEN
        ASSERT c_addr_width = 4 REPORT "WARNING: c_shift_ram_v9_1: Address bus should be 4 for this memory depth - only bits (3 downto 0) will be used" SEVERITY warning;        
      ELSIF c_depth > 16 AND c_depth <= 32 THEN
        ASSERT c_addr_width = 5 REPORT "ERROR: c_shift_ram_v9_1: Address bus width should be 5 for this memory depth" SEVERITY failure;
      ELSIF c_depth > 32 AND c_depth <= 64 THEN
        ASSERT c_addr_width = 6 REPORT "ERROR: c_shift_ram_v9_1: Address bus width should be 6 for this memory depth" SEVERITY failure;
      ELSIF c_depth > 64 AND c_depth <= 128 THEN
        ASSERT c_addr_width = 7 REPORT "ERROR: c_shift_ram_v9_1: Address bus width should be 7 for this memory depth" SEVERITY failure;
      ELSIF c_depth > 128 AND c_depth <= 256 THEN
        ASSERT c_addr_width = 8 REPORT "ERROR: c_shift_ram_v9_1: Address bus width should be 8 for this memory depth" SEVERITY failure;
      ELSIF c_depth > 256 AND c_depth <= 512 THEN
        ASSERT c_addr_width = 9 REPORT "ERROR: c_shift_ram_v9_1: Address bus width should be 9 for this memory depth" SEVERITY failure;
      ELSIF c_depth > 512 AND c_depth <= 1024 THEN
        ASSERT c_addr_width = 10 REPORT "ERROR: c_shift_ram_v9_1: Address bus width should be 10 for this memory depth" SEVERITY failure;
      END IF;

      CASE c_reg_last_bit IS
        WHEN 0 =>
          IF c_shift_type = c_variable_lossless THEN
            CASE c_opt_goal IS
              WHEN 0 => ASSERT c_depth > 0 AND c_depth < 1025
                          REPORT "ERROR: c_shift_ram_v9_1: Invalid depth value for variable-length RAM - minimum is 1, maximum is 1024" SEVERITY failure;  -- area, no reg
              WHEN 1 => ASSERT c_depth > 0 AND c_depth < 1025
                          REPORT "ERROR: c_shift_ram_v9_1: Invalid depth value for variable-length RAM - minimum is 1, maximum is 1024" SEVERITY failure;  -- speed, no reg
                        IF c_depth > srl_depth AND c_depth < (8*srl_depth)+1 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v9_1: The minimum shift register delay will be 2 cycles with no registered output" SEVERITY note;
                        END IF;
                        IF c_depth > 8*srl_depth AND c_depth < 1027 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v9_1: Implementing pipelining inside the multiplexer - the minimum shift register delay will be 3 cycles" SEVERITY note;
                        END IF;
              WHEN OTHERS => NULL;
            END CASE;
          ELSIF c_shift_type = c_variable_lossy THEN
            ASSERT c_depth > 0 AND c_depth < 1025
              REPORT "ERROR: c_shift_ram_v9_1: Invalid depth value for variable-length lossy RAM - minimum delay selectable is 1, maximum is 1024" SEVERITY failure;
          END IF;
        WHEN 1 =>
          IF c_shift_type = c_variable_lossless THEN
            CASE c_opt_goal IS
              WHEN 0 => ASSERT c_depth > 1 AND c_depth < 1026
                          REPORT "ERROR: c_shift_ram_v9_1: Invalid depth value for variable-length RAM - minimum delay selectable is 2, maximum is 1025 due to output register" SEVERITY failure;  -- area, reg
              WHEN 1 => ASSERT c_depth > 1 AND c_depth < 1026
                          REPORT "ERROR: c_shift_ram_v9_1: Invalid depth value for variable-length RAM - minimum delay selectable is 2, maximum is 1025 due to output register" SEVERITY failure;  -- speed, reg
                        IF c_depth > srl_depth AND c_depth < (8*srl_depth)+1 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v9_1: The minimum shift register delay will be 3 cycles with a registered output" SEVERITY note;
                        END IF;
                        IF c_depth > (8*srl_depth) AND c_depth < 1026 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v9_1: Implementing pipelining inside the multiplexer - the minimum shift register delay will be 4 cycles with a registered output" SEVERITY note;
                        END IF;
              WHEN OTHERS => NULL;
            END CASE;
          ELSIF c_shift_type = c_variable_lossy THEN
            ASSERT c_depth > 1 AND c_depth < 1026
              REPORT "ERROR: c_shift_ram_v9_1: Invalid depth value for variable-length lossy RAM - minimum delay selectable is 2, maximum is 1025 due to output register" SEVERITY failure;
          END IF;
        WHEN OTHERS => NULL;
      END CASE;
    END IF;
    REPORT "NOTE: c_shift_ram_v9_1: completed check generics" SEVERITY note;
    RETURN 0;
  END check_generics;

-- Verify that the generics are valid and will be supported by the
-- synthesizable model as well
  CONSTANT verify_generics : INTEGER RANGE 0 TO 0 := check_generics(c_width, c_depth, c_has_a, c_addr_width, c_opt_goal, ci_shift_type, c_reg_last_bit, c_generate_mif,
                                                                    c_has_ainit, c_has_aclr, c_has_aset, c_has_sinit, c_has_sclr, c_has_sset, c_has_ce, c_sync_priority, c_sync_enable, c_read_mif,
                                                                    srl_depth,
                                                                    c_default_data, ci_family);

  SIGNAL shift_out : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');

  TYPE T_PIPE_SIGNAL IS ARRAY (0 TO C_DEPTH) OF STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);

  SIGNAL intA    : STD_LOGIC_VECTOR(C_ADDR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL init    : T_PIPE_SIGNAL                             := (OTHERS => (OTHERS => '0'));
  SIGNAL initclr : T_PIPE_SIGNAL                             := (OTHERS => (OTHERS => '0'));
  SIGNAL int_ce  : STD_LOGIC                                 := '0';
  SIGNAL pipe1   : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
  SIGNAL pipe2   : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);

  -- Use utility function str_to_bound_slv_0 to convert the init values to std_logic_vectors
  CONSTANT ainit_val : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := str_to_bound_slv_0(c_ainit_val, c_width);
  CONSTANT sinit_val : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := str_to_bound_slv_0(c_sinit_val, c_width);
  
  -- purpose: calculates the actual depth of the shift register (the implementation length) so that addressing above the specified c_depth value
  -- will yield correct results in simulation
  FUNCTION getRealDepth(depth : INTEGER; c_reg_last_bit : INTEGER; shift_type : INTEGER; srl_depth : INTEGER) RETURN INTEGER IS
    VARIABLE temp_depth : INTEGER := depth;
    VARIABLE count_rams : INTEGER := 0;
    VARIABLE ret        : INTEGER := 0;
  BEGIN

    IF shift_type = c_fixed THEN
      IF depth = 0 OR depth = 1 THEN
        RETURN srl_depth+1;
      ELSIF depth MOD srl_depth /= 0 THEN
        RETURN ((depth/srl_depth)*srl_depth) + srl_depth;
      ELSE
        RETURN depth;
      END IF;
    ELSIF shift_type = c_variable_lossless THEN
      IF depth MOD srl_depth /= 0 THEN
        RETURN ((depth/srl_depth)*srl_depth)+srl_depth;
      ELSE
        RETURN depth;
      END IF;
    ELSIF shift_type = c_variable_lossy THEN
      IF depth MOD srl_depth /= 0 THEN
        RETURN ((depth/srl_depth)*srl_depth)+srl_depth;
      ELSE
        RETURN depth;
      END IF;
    END IF;

    ASSERT false REPORT "getRealDepth return value is " & INTEGER'image(ret) SEVERITY note;
    RETURN ret;
    
  END getRealDepth;

-- purpose: determines if any 'X's are present in the supplied vector
  FUNCTION anyX(vect : STD_LOGIC_VECTOR)
    RETURN BOOLEAN IS
  BEGIN
    FOR i IN vect'range LOOP
      IF (rat(vect(i)) = 'X') THEN
        RETURN true;
      END IF;
    END LOOP;
    RETURN false;
  END anyX;

-------------------------------------------------------------------------------
-- new functions as used in the synth model to read in a mif file
-------------------------------------------------------------------------------

  TYPE T_MEM_INIT_ARRAY IS ARRAY (0 TO c_width-1, 0 TO getRealDepth(c_depth, c_reg_last_bit, ci_shift_type, srl_depth)-1) OF STD_LOGIC;

  FUNCTION get_default_data (def_data : STRING; width : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE dd      : STRING(1 TO width);
    VARIABLE ret_slv : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (OTHERS => '0');
  BEGIN  -- FUNCTION get_default_data
    IF def_data'length > width THEN
      dd(1 TO width) := def_data(1 TO width);
    ELSE
      dd(1 TO def_data'length) := def_data;
    END IF;

    FOR i IN 1 TO width LOOP
      CASE dd(i) IS
        WHEN '0' =>
          ret_slv(width-i) := '0';
        WHEN '1' =>
          ret_slv(width-i) := '1';
        WHEN OTHERS =>
          ASSERT false
            REPORT "WARNING: c_shift_ram_v9_1: Filling unspecified c_default_data locations with zeros up to MSB"
            SEVERITY warning;
          ret_slv(width-i) := '0';
      END CASE;
    END LOOP;  -- i
    RETURN ret_slv;
  END FUNCTION get_default_data;

  FUNCTION init_array(width, depth : INTEGER; def_data : STRING) RETURN T_MEM_INIT_ARRAY IS
    VARIABLE filled_array : T_MEM_INIT_ARRAY;
    CONSTANT default_data : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := get_default_data(def_data, width);
  BEGIN  -- FUNCTION init_array
    FOR i IN 0 TO width-1 LOOP
      FOR j IN 0 TO depth-1 LOOP
        filled_array(i, j) := default_data(width-1-i);  -- coded this way to ensure left-most bit in default data string is the MSB (top bit) of the shift RAM
      END LOOP;  -- j
    END LOOP;  -- i
    RETURN filled_array;
  END FUNCTION init_array;

  IMPURE FUNCTION read_mif_data(read_mif, generate_mif, width, depth : INTEGER; filename, elaboration_dir : STRING; default_data : STRING) RETURN STD_LOGIC_VECTOR IS

    FILE initfile        : TEXT;
    VARIABLE initline    : LINE;
    VARIABLE bits_good   : BOOLEAN          := true;
    VARIABLE ret_vec     : T_MEM_INIT_ARRAY := init_array(width, depth, default_data);
    VARIABLE bitchar     : CHARACTER;
    VARIABLE bitline     : STRING (1 TO width);
    VARIABLE mif_status  : FILE_OPEN_STATUS;
    CONSTANT pathandfile : STRING           := elaboration_dir & filename;
    CONSTANT offset      : INTEGER          := width;
    VARIABLE ret_slv     : STD_LOGIC_VECTOR((width*depth)-1 DOWNTO 0);
    VARIABLE output_vec  : T_MEM_INIT_ARRAY;
    
  BEGIN  -- FUNCTION read_data

    IF read_mif /= 0 THEN  -- if we don't want to use a mif file, don't try and read one      
      
      ASSERT false REPORT "NOTE: c_shift_ram_v9_1: Reading mif file..." SEVERITY note;

      FILE_OPEN(mif_status, initfile, pathandfile, read_mode);  -- access file only when c_read_mif = 1

      IF mif_status /= open_ok THEN
        ASSERT false
          REPORT "ERROR: c_shift_ram_v9_1: Couldn't open memory initialization file"
          SEVERITY failure;
      END IF;

      FOR lines IN 0 TO c_depth-1 LOOP
        IF NOT(endfile(initfile)) THEN
          readline(initfile, initline);
          EXIT WHEN endfile (initfile);  -- fix to avoid "Line <MY_LINE> has not enough elements for target- <MY_DATA>" error
          FOR i IN 0 TO width-1 LOOP
            read(initline, bitchar, bits_good);
            IF ((bits_good = false) OR ((bitchar /= ' ') AND (bitchar /= CR) AND (bitchar /= HT) AND (bitchar /= LF) AND (bitchar /= '0') AND (bitchar /= '1') AND (bitchar /= 'X') AND (bitchar /= 'Z'))) THEN
              ASSERT false
                REPORT "WARNING: c_shift_ram_v9_1: Unknown or illegal character encountered while reading MIF on line " & INTEGER'image(lines+1) & " - finishing file read" & CR &
                "This could be due to an undersized MIF file"
                SEVERITY warning;
              EXIT;                     -- abort the file read
            END IF;
            CASE bitchar IS
              WHEN '0'    => ret_vec(i, lines) := '0';
              WHEN '1'    => ret_vec(i, lines) := '1';
              WHEN OTHERS =>
                ASSERT false
                  REPORT "WARNING: c_shift_ram_v9_1: STD_LOGIC type other than '0' or '1' detected on LINE " & INTEGER'image(lines+1) & " position " & INTEGER'image(i) & " - writing '0' to this memory location"
                  SEVERITY warning;
                ret_vec(i, lines) := '0';
            END CASE;
          END LOOP;  -- i
          
        END IF;
      END LOOP;  -- lines          

      FILE_CLOSE(initfile);             -- explicitly close the file
      ASSERT false REPORT "NOTE: c_shift_ram_v9_1: File read complete" SEVERITY note;
      
    END IF;  -- read_mif /= 0

    FOR deep IN 0 TO depth-1 LOOP
      FOR wide IN 0 TO width-1 LOOP
        ret_slv(wide+(deep*offset)) := ret_vec(((width-1)-wide), deep);
      END LOOP;  -- wide      
    END LOOP;  -- deep

    -- We return the array in all cases - if the mif file has been read, the
    -- array will have the data in it - if not, it will contain all zeros to
    -- initialise the SRL16s and the registers
    RETURN ret_slv;
    
  END FUNCTION read_mif_data;

  CONSTANT zeros : STRING(1 TO c_width) := (OTHERS => '0');
  
BEGIN

-------------------------------------------------------------------------------
-- internal ce generation
-------------------------------------------------------------------------------

  cegen1 : IF (c_has_ce = 1) GENERATE
    int_ce <= ce;
  END GENERATE;

  cegen0 : IF (c_has_ce = 0) GENERATE
    int_ce <= '1';
  END GENERATE;

-------------------------------------------------------------------------------
-- fixed-length behaviour
-------------------------------------------------------------------------------

  -- the fixed length version can be modelled simply with a
  -- pipeline of fds and a final output register if required
  fixed : IF (ci_shift_type = c_fixed) GENERATE
    
    reged : IF c_reg_last_bit = 1 GENERATE
      depth0 : IF c_depth = 0 GENERATE
        qout21 : c_reg_fd_v9_1
          GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width) 
          PORT MAP (d     => d,
                    clk   => clk,
                    ce    => ce,
                    aclr  => aclr,
                    aset  => aset,
                    ainit => ainit,
                    sclr  => sclr,
                    sset  => sset,
                    sinit => sinit,
                    q     => qint);         
      END GENERATE depth0;
      depth1 : IF c_depth = 1 GENERATE
        SIGNAL depth1_shiftout : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      BEGIN
        qout11 : c_reg_fd_v9_1
          GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width) 
          PORT MAP (d     => d,
                    clk   => clk,
                    ce    => ce,
                    aclr  => aclr,
                    aset  => aset,
                    ainit => ainit,
                    sclr  => sclr,
                    sset  => sset,
                    sinit => sinit,
                    q     => qint);         
      END GENERATE depth1;
      depth_gt_1 : IF c_depth > 1 GENERATE
        qout31 : c_reg_fd_v9_1
          GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width) 
          PORT MAP (d     => shift_out,
                    clk   => clk,
                    ce    => ce,
                    aclr  => aclr,
                    aset  => aset,
                    ainit => ainit,
                    sclr  => sclr,
                    sset  => sset,
                    sinit => sinit,
                    q     => qint);          
      END GENERATE depth_gt_1;
    END GENERATE reged;

    unreg : IF NOT(c_reg_last_bit = 1) AND c_depth /= 0 GENERATE
      qint <= shift_out;
    END GENERATE;

    route_thru : IF (c_depth = 0 AND c_reg_last_bit = 0) GENERATE
      qint <= d;
    END GENERATE;

-- core memory process
    PROCESS (clk)
      TYPE     shifttype IS ARRAY(0 TO c_depth-1-c_reg_last_bit) OF STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      VARIABLE shift     : shifttype;
      CONSTANT mem_bits  : INTEGER := c_depth * c_width;
      VARIABLE memdvect  : STD_LOGIC_VECTOR(mem_bits-1 DOWNTO 0);
      VARIABLE bits_good : BOOLEAN;
      VARIABLE lineno    : INTEGER := 0;
      VARIABLE offset    : INTEGER := 0;
      VARIABLE def_data  : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      VARIABLE startup   : BOOLEAN := true;
    BEGIN
      -- startup section reads mif file if necessary.          
      IF (c_depth-c_reg_last_bit > 0) THEN
        IF (startup) THEN

          -- call function in all cases - use to assign default data as well          
          memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, c_depth, c_mem_init_file, c_elaboration_dir, c_default_data);

          FOR i IN 0 TO c_depth -1-c_reg_last_bit LOOP
            FOR j IN 0 TO c_width-1 LOOP
              shift(i)(j) := memdvect(j + i*c_width);
            END LOOP;
          END LOOP;

          startup := false;
        ELSE                            -- not first
          IF (clk'event AND int_ce = '1' AND clk'last_value = '0' AND clk = '1') THEN  -- rising edge!
            FOR i IN c_depth-1-c_reg_last_bit DOWNTO 1 LOOP
              shift(i) := shift(i-1);
            END LOOP;
            shift(0) := d;
          ELSIF (clk'event AND (int_ce = 'X' OR (clk'last_value = '0' AND clk = 'X') OR (clk'last_value = 'X' AND clk = '1'))) THEN
            FOR i IN 0 TO c_depth-1-c_reg_last_bit LOOP
              shift(i) := (OTHERS => 'X');
            END LOOP;
          END IF;
          shift_out <= shift(c_depth-1-c_reg_last_bit);
        END IF;
      END IF;
    END PROCESS;
  END GENERATE;

  a1 : IF (c_has_a = 1) GENERATE
    inta <= a;
  END GENERATE;
  a0 : IF (c_has_a = 0) GENERATE
    inta <= STD_LOGIC_VECTOR(to_unsigned(c_depth-1, c_addr_width));
  END GENERATE;

-------------------------------------------------------------------------------
-- lossless behaviour
-------------------------------------------------------------------------------

  -- the lossless version is also fairly straight forward
  -- updated - 9th november 2004 - account for new pipelining option
  -- when c_opt_goal is set to 1 (speed optimisation)
  lossless : IF (ci_shift_type = c_variable_lossless) GENERATE
    opt_area : IF (c_opt_goal = c_area) OR (c_depth < srl_depth+1) generate--OR (c_depth = srl_depth+1 AND c_reg_last_bit /= 0) GENERATE
      reged : IF (c_reg_last_bit /= 0) GENERATE
        -- just an output register
        qout1 : c_reg_fd_v9_1
          GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width) 
          PORT MAP (d     => shift_out,
                    clk   => clk,
                    ce    => int_ce,
                    aclr  => aclr,
                    aset  => aset,
                    ainit => ainit,
                    sclr  => sclr,
                    sset  => sset,
                    sinit => sinit,
                    q     => qint);
      END GENERATE reged;
      unreg : IF c_reg_last_bit = 0 GENERATE
        qint <= shift_out;
      END GENERATE;
    END GENERATE opt_area;

--    opt_speed : IF (c_opt_goal = c_speed) AND ((c_depth > srl_depth+1) OR (c_depth = srl_depth+1 AND c_reg_last_bit = 0)) GENERATE
    opt_speed : IF (c_opt_goal = c_speed) AND (c_depth >= srl_depth+1) GENERATE    
      lat1 : IF c_depth <= 8*srl_depth GENERATE
        -- latency will be at least 1 cycle
        -- qout1 is a pipeline register, so gets limited controls
        qout1 : c_reg_fd_v9_1
          GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit, ainit_val, sinit_val, c_width)),  --c_ainit_val,
                       c_has_aclr      => 0,
                       c_has_ainit     => 0,
                       c_has_aset      => 0,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => 0,
                       c_has_sinit     => 0,
                       c_has_sset      => 0,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width) 
          PORT MAP (d     => shift_out,
                    clk   => clk,
                    ce    => int_ce,
                    aclr  => '0',
                    aset  => '0',
                    ainit => '0',
                    sclr  => '0',
                    sset  => '0',
                    sinit => '0',
                    q     => pipe1);             
        reged : IF (c_reg_last_bit /= 0) GENERATE
          -- output register
          qout2 : c_reg_fd_v9_1
            GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                         c_has_aclr      => c_has_aclr,
                         c_has_ainit     => c_has_ainit,
                         c_has_aset      => c_has_aset,
                         c_has_ce        => c_has_ce,
                         c_has_sclr      => c_has_sclr,
                         c_has_sinit     => c_has_sinit,
                         c_has_sset      => c_has_sset,
                         c_sinit_val     => std_logic_vector_to_string(sinit_val),
                         c_sync_enable   => c_sync_enable,
                         c_sync_priority => c_sync_priority,
                         c_width         => c_width) 
            PORT MAP (d     => pipe1,
                      clk   => clk,
                      ce    => int_ce,
                      aclr  => aclr,
                      aset  => aset,
                      ainit => ainit,
                      sclr  => sclr,
                      sset  => sset,
                      sinit => sinit,
                      q     => qint);
        END GENERATE reged;
        unreg : IF c_reg_last_bit = 0 GENERATE
          qint <= pipe1;
        END GENERATE;
      END GENERATE lat1;
      lat2 : IF c_depth > 8*srl_depth GENERATE
        -- latency will be at least 2 cycles
        -- qout1 and qout2 are pipeline registers and get limited controls
        qout1 : c_reg_fd_v9_1
          GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit, ainit_val, sinit_val, c_width)),  --c_ainit_val,
                       c_has_aclr      => 0,
                       c_has_ainit     => 0,
                       c_has_aset      => 0,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => 0,
                       c_has_sinit     => 0,
                       c_has_sset      => 0,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width) 
          PORT MAP (d     => shift_out,
                    clk   => clk,
                    ce    => int_ce,
                    aclr  => '0',
                    aset  => '0',
                    ainit => '0',
                    sclr  => '0',
                    sset  => '0',
                    sinit => '0',
                    q     => pipe1);
        qout2 : c_reg_fd_v9_1
          GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit, ainit_val, sinit_val, c_width)),  --c_ainit_val,
                       c_has_aclr      => 0,
                       c_has_ainit     => 0,
                       c_has_aset      => 0,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => 0,
                       c_has_sinit     => 0,
                       c_has_sset      => 0,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width) 
          PORT MAP (d     => pipe1,
                    clk   => clk,
                    ce    => int_ce,
                    aclr  => '0',
                    aset  => '0',
                    ainit => '0',
                    sclr  => '0',
                    sset  => '0',
                    sinit => '0',
                    q     => pipe2);            
        reged : IF (c_reg_last_bit = 1) GENERATE
          qout3 : c_reg_fd_v9_1
            GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                         c_has_aclr      => c_has_aclr,
                         c_has_ainit     => c_has_ainit,
                         c_has_aset      => c_has_aset,
                         c_has_ce        => c_has_ce,
                         c_has_sclr      => c_has_sclr,
                         c_has_sinit     => c_has_sinit,
                         c_has_sset      => c_has_sset,
                         c_sinit_val     => std_logic_vector_to_string(sinit_val),
                         c_sync_enable   => c_sync_enable,
                         c_sync_priority => c_sync_priority,
                         c_width         => c_width) 
            PORT MAP (d     => pipe2,
                      clk   => clk,
                      ce    => int_ce,
                      aclr  => aclr,
                      aset  => aset,
                      ainit => ainit,
                      sclr  => sclr,
                      sset  => sset,
                      sinit => sinit,
                      q     => qint);
        END GENERATE reged;
        unreg : IF NOT(c_reg_last_bit = 1) GENERATE
          qint <= pipe2;
        END GENERATE;
      END GENERATE lat2;
    END GENERATE opt_speed;

    PROCESS (clk, inta)
      VARIABLE rdeep : INTEGER := getRealDepth(c_depth, c_reg_last_bit, ci_shift_type, srl_depth);
      TYPE     shifttype IS ARRAY(0 TO rdeep-1) OF STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      VARIABLE first : BOOLEAN := true;
      VARIABLE shift : shifttype;

      CONSTANT mem_bits  : INTEGER := rdeep * c_width;
      VARIABLE memdvect  : STD_LOGIC_VECTOR(mem_bits-1 DOWNTO 0);
      VARIABLE bits_good : BOOLEAN;
      VARIABLE lineno    : INTEGER := 0;
      VARIABLE offset    : INTEGER := 0;
      VARIABLE def_data  : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      
    BEGIN

      -- startup section reads and/or writes mif file if necessary.
      
      IF (first) THEN

        -- call function in all cases - use to assign default data as well        
        memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, rdeep, c_mem_init_file, c_elaboration_dir, c_default_data);

        FOR i IN 0 TO rdeep-1 LOOP
          FOR j IN 0 TO c_width-1 LOOP
            shift(i)(j) := memdvect(j + i*c_width);
          END LOOP;
        END LOOP;
        IF (anyx(inta)) THEN
          shift_out <= (OTHERS => 'X');
        ELSIF (to_integer(UNSIGNED(inta)) >= rdeep) THEN
          shift_out <= (OTHERS => '0');
        ELSE
          shift_out <= shift(to_integer(UNSIGNED(inta)));
        END IF;

        first := false;
      ELSE                              -- not first
        IF (clk'event AND int_ce = '1' AND clk'last_value = '0' AND clk = '1') THEN  -- rising edge!
          FOR i IN rdeep-1 DOWNTO 1 LOOP
            shift(i) := shift(i-1);
          END LOOP;
          shift(0) := d;
        ELSIF (clk'event AND (int_ce = 'X' OR (clk'last_value = '0' AND clk = 'X') OR (clk'last_value = 'X' AND clk = '1'))) THEN
          FOR i IN 0 TO rdeep-1 LOOP
            shift(i) := (OTHERS => 'X');
          END LOOP;
        END IF;
        IF (anyx(inta)) THEN
          shift_out <= (OTHERS => 'X');
        ELSIF (to_integer(UNSIGNED(inta)) >= rdeep) THEN
          shift_out <= (OTHERS => 'X');  -- dlunn modified from '0' for illegal addressing
        ELSE
          shift_out <= shift(to_integer(UNSIGNED(inta)));
        END IF;
      END IF;
    END PROCESS;
  END GENERATE lossless;

-------------------------------------------------------------------------------
-- lossy behaviour
-------------------------------------------------------------------------------
-- we don't allow lossy behavior in this version for virtex5
-- core retargets to lossless behavior and it is blocked in the gui
-- lossless mode makes more efficient use of the dedicated routing and offers
-- easily-understandable behavior
-------------------------------------------------------------------------------

-- the lossy version requires some assesment of which value to
-- feed into the last sixteen locations.
  lossy : IF (ci_shift_type = c_variable_lossy) GENERATE
    reged : IF (c_reg_last_bit = 1) GENERATE
      qout : c_reg_fd_v9_1
        GENERIC MAP (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                     c_has_aclr      => c_has_aclr,
                     c_has_ainit     => c_has_ainit,
                     c_has_aset      => c_has_aset,
                     c_has_ce        => c_has_ce,
                     c_has_sclr      => c_has_sclr,
                     c_has_sinit     => c_has_sinit,
                     c_has_sset      => c_has_sset,
                     c_sinit_val     => std_logic_vector_to_string(sinit_val),
                     c_sync_enable   => c_sync_enable,
                     c_sync_priority => c_sync_priority,
                     c_width         => c_width) 
        PORT MAP (d     => shift_out,
                  clk   => clk,
                  ce    => int_ce,
                  aclr  => aclr,
                  aset  => aset,
                  ainit => ainit,
                  sclr  => sclr,
                  sset  => sset,
                  sinit => sinit,
                  q     => qint);     
    END GENERATE;
    unreg : IF NOT (c_reg_last_bit = 1) GENERATE
      qint <= shift_out;
    END GENERATE;


    PROCESS (clk, inta)
      VARIABLE rdeep     : INTEGER                      := getRealDepth(c_depth, c_reg_last_bit, ci_shift_type, srl_depth);
      TYPE     shifttype IS ARRAY(0 TO rdeep-1) OF STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      VARIABLE first     : BOOLEAN                      := true;
      VARIABLE shift     : shifttype;
      VARIABLE last16    : INTEGER;
      VARIABLE addtop    : STD_LOGIC_VECTOR(c_addr_width-1 DOWNTO 4*BOOLEAN'pos(c_addr_width > 4));
      VARIABLE addlow    : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
      VARIABLE addti     : INTEGER;
      CONSTANT mem_bits  : INTEGER                      := rdeep * c_width;
      VARIABLE memdvect  : STD_LOGIC_VECTOR(mem_bits-1 DOWNTO 0);
      VARIABLE bits_good : BOOLEAN;
      VARIABLE lineno    : INTEGER                      := 0;
      VARIABLE offset    : INTEGER                      := 0;
      VARIABLE def_data  : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);

    BEGIN

      -- startup section reads and/or writes mif file if necessary.
      
      IF (first) THEN

        --   shift(rdeep-16 to rdeep-1) := (others => def_data);

        -- call function in all cases - use to assign default data as well
        memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, rdeep, c_mem_init_file, c_elaboration_dir, c_default_data);

        FOR i IN 0 TO rdeep -1 LOOP
          FOR j IN 0 TO c_width-1 LOOP
            shift(i)(j) := memdvect(j + i*c_width);
          END LOOP;
        END LOOP;

        last16 := rdeep - 16;

        IF(c_addr_width > 4) THEN
          addlow := inta(3 DOWNTO 0);
        ELSE
          addlow(c_addr_width-1 DOWNTO 0) := inta;
        END IF;

        IF (anyx(addlow)) THEN
          shift_out <= (OTHERS => 'X');
        ELSE
          shift_out <= shift(last16+(to_integer(UNSIGNED(addlow))));
        END IF;

        first := false;
        
      ELSE                              -- not first
        
        IF(c_addr_width > 4) THEN
          addtop := inta(c_addr_width-1 DOWNTO 4*BOOLEAN'pos(c_addr_width > 4));
          addlow := inta(3 DOWNTO 0);
        ELSE
          addlow(c_addr_width-1 DOWNTO 0) := inta;
          addtop                          := (OTHERS => '0');
        END IF;

        IF (clk'event AND int_ce = '1' AND clk'last_value = '0' AND clk = '1') THEN  -- rising edge!
          FOR i IN rdeep-1 DOWNTO last16+1 LOOP
            shift(i) := shift(i-1);
          END LOOP;
          IF (anyx(addtop)) THEN
            shift(last16) := (OTHERS => 'X');
          ELSE
            addti := to_integer(UNSIGNED(addtop))*16;
            IF(addti >= rdeep) THEN
              shift(last16) := (OTHERS => 'X');  -- dlunn modified from '0' for illegal addressing
            ELSIF(addti = 0) THEN
              shift(last16) := d;
            ELSE
              shift(last16) := shift(addti-1);
            END IF;
          END IF;
          FOR i IN last16-1 DOWNTO 1 LOOP
            shift(i) := shift(i-1);
          END LOOP;
          shift(0) := d;
        ELSIF (clk'event AND (int_ce = 'X' OR (clk'last_value = '0' AND clk = 'X') OR (clk'last_value = 'X' AND clk = '1'))) THEN
          FOR i IN 0 TO rdeep-1 LOOP
            shift(i) := (OTHERS => 'X');
          END LOOP;
        END IF;

        IF (anyx(addlow)) THEN
          shift_out <= (OTHERS => 'X');
        ELSE
          shift_out <= shift(last16 + to_integer(UNSIGNED(addlow)));
        END IF;
        
      END IF;
    END PROCESS;
  END GENERATE lossy;

  q <= qint AFTER timeunit;

END behavioral;
