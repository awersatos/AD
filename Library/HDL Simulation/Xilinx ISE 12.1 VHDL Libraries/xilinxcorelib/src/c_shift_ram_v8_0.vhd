-- $RCSfile: c_shift_ram_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:55 $
--------------------------------------------------------------------------------
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY std;
USE std.textio.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v8_0.ALL;
USE xilinxcorelib.prims_utils_v8_0.ALL;
USE xilinxcorelib.c_reg_fd_v8_0_comp.ALL;

ENTITY c_shift_ram_v8_0 IS
  GENERIC (
    c_width              : INTEGER := 16;  -- Default is 16
    c_depth              : INTEGER := 16;  -- SRL16 depth (default = 16 = 1x SRL16) 
    c_addr_width         : INTEGER := 4;  -- Dependent on c_width value specified
    c_shift_type         : INTEGER := 0;  --c_variable_lossy;  -- 0=fixed, 1=lossless, 2=lossy
    c_opt_goal           : INTEGER := 0;  -- 0=area, 1=speed
    c_ainit_val          : STRING  := "0000000000000000";  -- Applies only to registered output
    c_sinit_val          : STRING  := "0000000000000000";  -- Applies only to registered output    
    c_default_data       : STRING  := "0000000000000000";  -- No init details, use this val
    c_default_data_radix : INTEGER := 1;  -- 0=no init values, 1=hex ,2=bin, 3=dec
    c_has_a              : INTEGER := 0;  -- Address bus only exists for var length
    c_has_ce             : INTEGER := 0;
    c_reg_last_bit       : INTEGER := 0;  -- Register last output bit (with FF)
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
END c_shift_ram_v8_0;
--
-- behavior describing a parameterized ram based shift register
--
ARCHITECTURE behavioral OF C_SHIFT_RAM_V8_0 IS

  FUNCTION check_generics(c_width, c_depth, c_has_a, c_addr_width, c_opt_goal, c_shift_type, c_reg_last_bit, c_generate_mif : INTEGER;
                          c_has_ainit, c_has_aclr, c_has_aset, c_has_sinit, c_has_sclr, c_has_sset, c_has_ce                : INTEGER;
                          c_default_data                                                                                    : STRING)
    RETURN INTEGER IS
  BEGIN

    ASSERT c_generate_mif = 0
      REPORT "ERROR: c_shift_ram_v8_0_xst: Writing of .mif files is not supported in this core version"
      SEVERITY failure;
    ASSERT c_width > 0 AND c_width < 257
      REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid RAM width value - the valid range is 1 to 256 inclusive"
      SEVERITY failure;

    IF c_reg_last_bit = 0 THEN
      ASSERT c_has_ainit = 0 AND c_has_aclr = 0 AND c_has_aset = 0
        REPORT "WARNING: c_shift_ram_v8_0_xst: Asynchronous controls not available without registered output"
        SEVERITY warning;
      ASSERT c_has_sinit = 0 AND c_has_sclr = 0 AND c_has_sset = 0
        REPORT "WARNING: c_shift_ram_v8_0_xst: Synchronous controls not available without registered output"
        SEVERITY warning;
    ELSE                                -- c_reg_last_bit /= 0
      IF c_has_ainit /= 0 THEN
        ASSERT c_has_aset = 0 AND c_has_aclr = 0
          REPORT "ERROR: c_shift_ram_v8_0_xst: ASET and/or ACLR cannot exist in conjunction with AINIT"
          SEVERITY failure;
      END IF;
      IF c_has_sinit /= 0 THEN
        ASSERT c_has_sset = 0 AND c_has_sclr = 0
          REPORT "ERROR: c_shift_ram_v8_0_xst: SSET and/or SCLR cannot exist in conjunction with SINIT"
          SEVERITY failure;
      END IF;
      IF c_has_aclr /= 0 OR c_has_aset /= 0 THEN
        ASSERT c_has_ainit = 0
          REPORT "ERROR: c_shift_ram_v8_0_xst: AINIT cannot exist in conjunction with ACLR and/or ASET"
          SEVERITY failure;
      END IF;
      IF c_has_sclr /= 0 OR c_has_sset /= 0 THEN
        ASSERT c_has_sinit = 0
          REPORT "ERROR: c_shift_ram_v8_0_xst: SINIT cannot exist in conjunction with SCLR and/or SSET"
          SEVERITY failure;
      END IF;
    END IF;

    IF (c_has_ainit /= 0 OR c_has_aclr /= 0 OR c_has_aset /= 0) AND (c_has_sinit /= 0 OR c_has_sclr /= 0 OR c_has_sset /= 0) AND c_reg_last_bit /= 0 THEN
      ASSERT false
        REPORT "WARNING: c_shift_ram_v8_0_xst: Including both asynchronous (aclr, aset or ainit) AND synchronous controls " &
        "(sclr, sset or sinit) will add a layer of logic and impact performance"
        SEVERITY warning;
    END IF;

    IF c_shift_type = c_fixed THEN
      ASSERT c_has_a = 0
        REPORT "WARNING: c_shift_ram_v8_0_xst: Address bus not required for fixed-length register"
        SEVERITY warning;
      IF c_depth /= 0 AND NOT(c_depth = 1 AND c_reg_last_bit = 1) THEN
        IF c_reg_last_bit /= 0 THEN
          ASSERT c_depth > 1 AND c_depth < 1090
            REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid RAM depth value for registered output - the valid range is 2 to 1089 inclusive"
            SEVERITY failure;
        ELSE
          ASSERT c_depth > 0 AND c_depth < 1089
            REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid RAM depth value - the valid range is 1 to 1088 inclusive"
            SEVERITY failure;
        END IF;
      END IF;
    END IF;

    IF c_shift_type = c_variable_lossless OR c_shift_type = c_variable_lossy THEN
      ASSERT c_has_a /= 0
        REPORT "ERROR: c_shift_ram_v8_0_xst: Variable-length register must have an address bus input"
        SEVERITY failure;
      ASSERT c_addr_width > 3
        REPORT "ERROR: c_shift_ram_v8_0_xst: c_addr_width must be at least 4 bits wide"
        SEVERITY failure;
      IF c_reg_last_bit = 0 THEN
        IF c_depth <= 16 THEN
          ASSERT c_addr_width = 4
            REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 4 for this memory depth"
            SEVERITY failure;
        ELSIF c_depth > 16 AND c_depth <= 32 THEN
          ASSERT c_addr_width = 5
            REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 5 for this memory depth"
            SEVERITY failure;
        ELSIF c_depth > 32 AND c_depth <= 64 THEN
          ASSERT c_addr_width = 6
            REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 6 for this memory depth"
            SEVERITY failure;
        ELSIF c_depth > 64 AND c_depth <= 128 THEN
          ASSERT c_addr_width = 7
            REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 7 for this memory depth"
            SEVERITY failure;
        ELSIF c_depth > 128 AND c_depth <= 256 THEN
          ASSERT c_addr_width = 8
            REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 8 for this memory depth"
            SEVERITY failure;
        ELSIF c_depth > 256 AND c_depth <= 512 THEN
          ASSERT c_addr_width = 9
            REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 9 for this memory depth"
            SEVERITY failure;
        ELSIF c_depth > 512 AND c_depth <= 1024 THEN
          ASSERT c_addr_width = 10
            REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 10 for this memory depth"
            SEVERITY failure;
        END IF;
      ELSE                              -- c_reg_last_bit /= 0
        IF (c_depth MOD 16) = 1 THEN
          -- address bus width reduced by 1 if we have the case where the register
          -- provides the final delay and not an SRL16 (depth=17, 33, 49 etc.)
          IF c_depth <= 17 THEN
            ASSERT c_addr_width = 4
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 4 for this memory depth when using a registered output"
              SEVERITY failure;
          ELSIF c_depth > 17 AND c_depth <= 33 THEN
            ASSERT c_addr_width = 5
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 5 for this memory depth when using a registered output"
              SEVERITY failure;
          ELSIF c_depth > 33 AND c_depth <= 65 THEN
            ASSERT c_addr_width = 6
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 6 for this memory depth when using a registered output"
              SEVERITY failure;
          ELSIF c_depth > 65 AND c_depth <= 129 THEN
            ASSERT c_addr_width = 7
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 7 for this memory depth when using a registered output"
              SEVERITY failure;
          ELSIF c_depth > 129 AND c_depth <= 257 THEN
            ASSERT c_addr_width = 8
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 8 for this memory depth when using a registered output"
              SEVERITY failure;
          ELSIF c_depth > 257 AND c_depth <= 513 THEN
            ASSERT c_addr_width = 9
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 9 for this memory depth when using a registered output"
              SEVERITY failure;
          ELSIF c_depth > 513 AND c_depth <= 1025 THEN
            ASSERT c_addr_width = 10
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 10 for this memory depth when using a registered output"
              SEVERITY failure;
          END IF;
        ELSE                            -- delay length /= 17, 33, 49 etc.
          IF c_depth <= 16 THEN
            ASSERT c_addr_width = 4
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 4 for this memory depth"
              SEVERITY failure;
          ELSIF c_depth > 16 AND c_depth <= 32 THEN
            ASSERT c_addr_width = 5
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 5 for this memory depth"
              SEVERITY failure;
          ELSIF c_depth > 32 AND c_depth <= 64 THEN
            ASSERT c_addr_width = 6
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 6 for this memory depth"
              SEVERITY failure;
          ELSIF c_depth > 64 AND c_depth <= 128 THEN
            ASSERT c_addr_width = 7
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 7 for this memory depth"
              SEVERITY failure;
          ELSIF c_depth > 128 AND c_depth <= 256 THEN
            ASSERT c_addr_width = 8
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 8 for this memory depth"
              SEVERITY failure;
          ELSIF c_depth > 256 AND c_depth <= 512 THEN
            ASSERT c_addr_width = 9
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 9 for this memory depth"
              SEVERITY failure;
          ELSIF c_depth > 512 AND c_depth <= 1024 THEN
            ASSERT c_addr_width = 10
              REPORT "ERROR: c_shift_ram_v8_0_xst: Address bus width should be 10 for this memory depth"
              SEVERITY failure;
          END IF;
        END IF;
      END IF;

      IF c_opt_goal = 1 AND c_shift_type /= c_variable_lossless THEN
        ASSERT false REPORT "WARNING: c_shift_ram_v8_0_xst: Speed optimisation is not available in modes other than variable-length lossless" SEVERITY warning;
      END IF;
      IF c_opt_goal = 0 AND c_shift_type = c_variable_lossless THEN  -- area optimisation
        ASSERT false REPORT "NOTE: c_shift_ram_v8_0_xst: Optimising for area" SEVERITY note;
      END IF;
      IF c_opt_goal = 1 AND c_shift_type = c_variable_lossless THEN  -- speed optimisation
        ASSERT false REPORT "NOTE: c_shift_ram_v8_0_xst: Optimising for speed" SEVERITY note;
        IF (c_has_aclr /= 0 OR c_has_aset /= 0 OR c_has_ainit /= 0 OR c_has_sclr /= 0 OR c_has_sset /= 0 OR c_has_sinit /= 0) AND c_reg_last_bit /= 0 THEN
          ASSERT false REPORT "NOTE: c_shift_ram_v8_0_xst: Register controls will only be implemented on the output register and not on pipeline registers" SEVERITY note;
        END IF;
        IF c_has_ce /= 0 THEN
          ASSERT false REPORT "NOTE: c_shift_ram_v8_0_xst: CE controls will be implemented on all pipeline registers in addition to the output register, if selected" SEVERITY note;
        END IF;
      END IF;
      CASE c_reg_last_bit IS
        WHEN 0 =>
          IF c_shift_type = c_variable_lossless THEN
            CASE c_opt_goal IS
              WHEN 0 => ASSERT c_depth > 0 AND c_depth < 1025
                          REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid depth value for variable-length RAM - minimum is 1, maximum is 1024" SEVERITY failure;  -- area, no reg
              WHEN 1 => ASSERT c_depth > 0 AND c_depth < 1025
                          REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid depth value for variable-length RAM - minimum is 1, maximum is 1024" SEVERITY failure;  -- speed, no reg
                        IF c_depth > 16 AND c_depth < 129 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v8_0_xst: The minimum delay will be 2 cycles with no registered output" SEVERITY note;
                        END IF;
                        IF c_depth > 128 AND c_depth < 1027 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v8_0_xst: Implementing pipelining inside the multiplexer - the minimum delay will be 3 cycles" SEVERITY note;
                        END IF;
              WHEN OTHERS => NULL;
            END CASE;
          ELSIF c_shift_type = c_variable_lossy THEN
            ASSERT c_depth > 0 AND c_depth < 1025
              REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid depth value for variable-length lossy RAM - minimum delay selectable is 1, maximum is 1024" SEVERITY failure;
          END IF;
        WHEN 1 =>
          IF c_shift_type = c_variable_lossless THEN
            CASE c_opt_goal IS
              WHEN 0 => ASSERT c_depth > 1 AND c_depth < 1026
                          REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid depth value for variable-length RAM - minimum delay selectable is 2, maximum is 1025 due to output register" SEVERITY failure;  -- area, reg
              WHEN 1 => ASSERT c_depth > 1 AND c_depth < 1026
                          REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid depth value for variable-length RAM - minimum delay selectable is 2, maximum is 1025 due to output register" SEVERITY failure;  -- speed, reg
                        IF c_depth > 16 AND c_depth < 129 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v8_0_xst: The minimum delay will be 3 cycles with a registered output" SEVERITY note;
                        END IF;
                        IF c_depth > 128 AND c_depth < 1026 THEN
                          ASSERT false
                            REPORT "NOTE: c_shift_ram_v8_0_xst: Implementing pipelining inside the multiplexer - minimum delay selectable will be 4 cycles with a registered output" SEVERITY note;
                        END IF;
              WHEN OTHERS => NULL;
            END CASE;
          ELSIF c_shift_type = c_variable_lossy THEN
            ASSERT c_depth > 1 AND c_depth < 1026
              REPORT "ERROR: c_shift_ram_v8_0_xst: Invalid depth value for variable-length lossy RAM - minimum delay selectable is 2, maximum is 1025 due to output register" SEVERITY failure;
          END IF;
        WHEN OTHERS => NULL;
      END CASE;
    END IF;

    RETURN 0;
  END check_generics;

  -- Verify that the generics are valid and will be supported by the
  -- synthesizable model as well
  CONSTANT verify_generics : INTEGER RANGE 0 TO 0 := check_generics(c_width, c_depth, c_has_a, c_addr_width, c_opt_goal, c_shift_type, c_reg_last_bit, c_generate_mif,
                                                                    c_has_ainit, c_has_aclr, c_has_aset, c_has_sinit, c_has_sclr, c_has_sset, c_has_ce,
                                                                    c_default_data);
  
  SIGNAL shift_out : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');

  TYPE T_PIPE_SIGNAL IS ARRAY (0 TO C_DEPTH) OF STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);

  SIGNAL d_pipe  : T_PIPE_SIGNAL                             := (OTHERS => (OTHERS => '0'));
  SIGNAL intA    : STD_LOGIC_VECTOR(C_ADDR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL init    : T_PIPE_SIGNAL                             := (OTHERS => (OTHERS => '0'));
  SIGNAL initclr : T_PIPE_SIGNAL                             := (OTHERS => (OTHERS => '0'));
  SIGNAL int_ce  : STD_LOGIC                                 := '0';
  SIGNAL pipe1   : STD_LOGIC_VECTOR(C_width-1 DOWNTO 0);
  SIGNAL pipe2   : STD_LOGIC_VECTOR(C_width-1 DOWNTO 0);

  -- Use utility function str_to_bound_slv_0 to convert the init values to std_logic_vectors
  CONSTANT ainit_val : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := str_to_bound_slv_0(c_ainit_val, c_width);
  CONSTANT sinit_val : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := str_to_bound_slv_0(c_sinit_val, c_width);

  FUNCTION getRealDepth(depth : INTEGER; c_reg_last_bit : INTEGER; c_shift_type : INTEGER) RETURN INTEGER IS
    VARIABLE temp_depth : INTEGER := depth;
  VARIABLE count_rams : INTEGER := 0;
  BEGIN
    -- In the v8 shift RAM, when the depth of the register is equal to a
    -- multiple of 16 and the output is registered, we don't use another SRL16,
    -- but just allow the output register to make up the final element of the
    -- delay chain

    IF c_shift_type = c_fixed THEN
      IF((depth MOD 16) > 0) THEN
        RETURN(((depth/16)+1)*16);
      ELSE
        RETURN(depth);
      END IF;

    ELSIF c_shift_type = c_variable_lossless THEN

      IF (c_reg_last_bit = 1) THEN
        IF ((depth-1) MOD 16 = 0) THEN
          RETURN depth-1;
        ELSE
          RETURN ((depth/16)*16 + 16);
        END IF;
      ELSE
        IF (depth MOD 16 = 0) THEN
          RETURN depth;
        ELSE
          RETURN ((depth /16)*16) +16;
        END IF;
      END IF;

    ELSIF (c_shift_type = c_variable_lossy) THEN

      WHILE temp_depth > 15 LOOP
        temp_depth := temp_depth - 16;
        count_rams := count_rams + 1;
      END LOOP;
      IF temp_depth = 1 AND c_reg_last_bit /= 0 THEN
        RETURN count_rams*16;
      ELSIF temp_depth = 1 AND c_reg_last_bit = 0 THEN
        RETURN count_rams*16 + 16;
      ELSIF temp_depth > 1 THEN
        RETURN (count_rams+1)*16;
      ELSE
        RETURN count_rams*16;
      END IF;
      
    END IF;

  END getRealDepth;



  FUNCTION rat(value : STD_LOGIC)
    RETURN STD_LOGIC IS
  BEGIN
    CASE value IS
      WHEN '0' | '1' => RETURN value;
      WHEN 'H'       => RETURN '1';
      WHEN 'L'       => RETURN '0';
      WHEN OTHERS    => RETURN 'X';
    END CASE;
  END rat;

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

  TYPE T_MEM_INIT_ARRAY IS ARRAY (0 TO c_width-1, 0 TO getRealDepth(c_depth, c_reg_last_bit, c_shift_type)-1) OF STD_LOGIC;

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
            REPORT "WARNING: c_shift_ram_v8_0: Filling unspecified c_default_data locations with zeros up to MSB"
            SEVERITY warning;
          ret_slv(width-i) := '0';
      END CASE;
    END LOOP;  -- i
    RETURN ret_slv;
  END FUNCTION get_default_data;

  FUNCTION init_array(width, depth : INTEGER; def_data : STRING) RETURN T_MEM_INIT_ARRAY IS
    VARIABLE filled_array : T_MEM_INIT_ARRAY;
    CONSTANT default_data : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := get_default_data(def_data, width);
  BEGIN  -- FUNCTION init_array
    FOR i IN 0 TO width-1 LOOP
      FOR j IN 0 TO depth-1 LOOP
        filled_array(i, j) := default_data(width-1-i);  -- coded this way to ensure left-most bit in default data string is the MSB (top bit) of the shift RAM
      END LOOP;  -- j
    END LOOP;  -- i
    RETURN filled_array;
  END FUNCTION init_array;

  IMPURE FUNCTION read_mif_data(read_mif, generate_mif, width, depth : INTEGER; filename, elaboration_dir : STRING; default_data : STRING) RETURN STD_LOGIC_VECTOR IS

    FILE initfile       : TEXT;
    VARIABLE initline   : LINE;
    VARIABLE bits_good  : BOOLEAN          := true;
    VARIABLE ret_vec    : T_MEM_INIT_ARRAY := init_array(width, depth, default_data);
    VARIABLE bitchar    : CHARACTER;
    VARIABLE bitline    : STRING (1 TO width);
    VARIABLE mif_status : FILE_OPEN_STATUS;
    CONSTANT pathandfile : STRING := elaboration_dir & filename;
    CONSTANT offset     : INTEGER          := width;
    VARIABLE ret_slv    : STD_LOGIC_VECTOR((width*depth)-1 DOWNTO 0);
    VARIABLE output_vec : T_MEM_INIT_ARRAY;
    
  BEGIN  -- FUNCTION read_data

    IF read_mif /= 0 THEN  -- if we don't want to use a mif file, don't try and read one      
      
      ASSERT false REPORT "NOTE: c_shift_ram_v8_0: Reading mif file" SEVERITY note;

      FILE_OPEN(mif_status, initfile, pathandfile, read_mode);  -- access file only when c_read_mif = 1

      IF mif_status /= open_ok THEN
        ASSERT false
          REPORT "ERROR: c_shift_ram_v8_0: Couldn't open memory initialization file"
          SEVERITY failure;
      END IF;

      FOR lines IN 0 TO depth-1 LOOP
        IF NOT(endfile(initfile)) AND (lines < depth) THEN
          readline(initfile, initline);
          FOR i IN 0 TO width-1 LOOP
            read(initline, bitchar, bits_good);
            IF ((bits_good = false) OR ((bitchar /= ' ') AND (bitchar /= CR) AND (bitchar /= HT) AND (bitchar /= LF) AND (bitchar /= '0') AND (bitchar /= '1') AND (bitchar /= 'X') AND (bitchar /= 'Z'))) THEN
              ASSERT false
                REPORT "WARNING: c_shift_ram_v8_0: Unknown or illegal character encountered while reading MIF on line " & INTEGER'image(lines+1) & " - aborting file read" & CR &
                  "This could be due to an undersized MIF file"
                SEVERITY warning;
              EXIT;                     -- abort the file read
            END IF;
              CASE bitchar IS
                WHEN '0'    => ret_vec(i, lines) := '0';
                WHEN '1'    => ret_vec(i, lines) := '1';
                WHEN OTHERS =>
                  ASSERT false
                    REPORT "WARNING: c_shift_ram_v8_0: STD_LOGIC type other than '0' or '1' detected on LINE " & INTEGER'image(lines+1) & " position " & INTEGER'image(i) & " - writing '0' to this memory location"
                    SEVERITY warning;
                  ret_vec(i, lines) := '0';
              END CASE;
          END LOOP;  -- i
          
        END IF;
      END LOOP;  -- lines          

      FILE_CLOSE(initfile);             -- explicitly close the file
      ASSERT false REPORT "NOTE: c_shift_ram_v8_0: File read complete" SEVERITY note;
      
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
  
BEGIN

-------------------------------------------------------------------------------
-- Internal CE generation
-------------------------------------------------------------------------------

  cegen1 : IF (c_has_ce = 1) GENERATE
    cegen11 : int_ce <= ce;
  END GENERATE;

  cegen0 : IF (c_has_ce = 0) GENERATE
    cegen01 : int_ce <= '1';
  END GENERATE;

-------------------------------------------------------------------------------
-- Fixed-length behaviour
-------------------------------------------------------------------------------

  -- The fixed length version can be modelled simply with a
  -- pipeline of FDs and a final output register if required
  fixed : IF (C_SHIFT_TYPE = c_fixed) GENERATE
    
    reged: IF c_reg_last_bit = 1 GENERATE
      depth0: IF c_depth = 0 GENERATE
        qout21 : C_REG_FD_V8_0
          GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                       C_HAS_ACLR      => C_HAS_ACLR,
                       C_HAS_AINIT     => C_HAS_AINIT,
                       C_HAS_ASET      => C_HAS_ASET,
                       C_HAS_CE        => C_HAS_CE,
                       C_HAS_SCLR      => C_HAS_SCLR,
                       C_HAS_SINIT     => C_HAS_SINIT,
                       C_HAS_SSET      => C_HAS_SSET,
                       C_SINIT_VAL     => C_SINIT_VAL,
                       C_SYNC_ENABLE   => C_SYNC_ENABLE,
                       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                       C_WIDTH         => C_WIDTH) 
          PORT MAP (D     => D,
                    CLK   => CLK,
                    CE    => CE,
                    ACLR  => ACLR,
                    ASET  => ASET,
                    AINIT => AINIT,
                    SCLR  => SCLR,
                    SSET  => SSET,
                    SINIT => SINIT,
                    Q     => Q);         
      END GENERATE depth0;
      depth1: IF c_depth = 1 GENERATE
        SIGNAL depth1_shiftout : STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      BEGIN     
        qout11 : C_REG_FD_V8_0
          GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                       C_HAS_ACLR      => C_HAS_ACLR,
                       C_HAS_AINIT     => C_HAS_AINIT,
                       C_HAS_ASET      => C_HAS_ASET,
                       C_HAS_CE        => C_HAS_CE,
                       C_HAS_SCLR      => C_HAS_SCLR,
                       C_HAS_SINIT     => C_HAS_SINIT,
                       C_HAS_SSET      => C_HAS_SSET,
                       C_SINIT_VAL     => C_SINIT_VAL,
                       C_SYNC_ENABLE   => C_SYNC_ENABLE,
                       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                       C_WIDTH         => C_WIDTH) 
          PORT MAP (D     => D,
                    CLK   => CLK,
                    CE    => CE,
                    ACLR  => ACLR,
                    ASET  => ASET,
                    AINIT => AINIT,
                    SCLR  => SCLR,
                    SSET  => SSET,
                    SINIT => SINIT,
                    Q     => Q);         
      END GENERATE depth1;
      depth_gt_1: IF c_depth > 1 GENERATE
        qout31 : C_REG_FD_V8_0
          GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                       C_HAS_ACLR      => C_HAS_ACLR,
                       C_HAS_AINIT     => C_HAS_AINIT,
                       C_HAS_ASET      => C_HAS_ASET,
                       C_HAS_CE        => C_HAS_CE,
                       C_HAS_SCLR      => C_HAS_SCLR,
                       C_HAS_SINIT     => C_HAS_SINIT,
                       C_HAS_SSET      => C_HAS_SSET,
                       C_SINIT_VAL     => C_SINIT_VAL,
                       C_SYNC_ENABLE   => C_SYNC_ENABLE,
                       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                       C_WIDTH         => C_WIDTH) 
          PORT MAP (D     => shift_out,
                    CLK   => CLK,
                    CE    => CE,
                    ACLR  => ACLR,
                    ASET  => ASET,
                    AINIT => AINIT,
                    SCLR  => SCLR,
                    SSET  => SSET,
                    SINIT => SINIT,
                    Q     => Q);          
      END GENERATE depth_gt_1;
    END GENERATE reged;

    unreg : IF NOT(C_REG_LAST_BIT = 1) AND c_depth /= 0 GENERATE
      Q <= shift_out;
    END GENERATE;    

      route_thru : IF (c_depth = 0 AND c_reg_last_bit = 0) GENERATE
        Q <= D;
      END GENERATE;
    
-- Core Memory process
    PROCESS (CLK)
--   
      TYPE     shifttype IS ARRAY(0 TO C_DEPTH-1-C_REG_LAST_BIT) OF STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
      VARIABLE shift : shifttype;

      CONSTANT mem_bits  : INTEGER := C_DEPTH * C_WIDTH;
      VARIABLE memdvect  : STD_LOGIC_VECTOR(mem_bits-1 DOWNTO 0);
      VARIABLE bits_good : BOOLEAN;
      VARIABLE lineno    : INTEGER := 0;
      VARIABLE offset    : INTEGER := 0;
      VARIABLE def_data  : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
      VARIABLE startup   : BOOLEAN := true;

    BEGIN

      -- Startup section reads and/or writes mif file if necessary.     
      
      IF (c_depth-c_reg_last_bit > 0) THEN
        IF (startup) THEN

          -- Call function in all cases - use to assign default data as well          
          memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, c_depth, c_mem_init_file, c_elaboration_dir, c_default_data);

          FOR i IN 0 TO C_DEPTH -1-C_REG_LAST_BIT LOOP
            FOR j IN 0 TO C_WIDTH-1 LOOP
              shift(i)(j) := memdvect(j + i*C_WIDTH);
            END LOOP;
          END LOOP;

          startup := false;
        ELSE                            -- Not FIRST
          IF (CLK'event AND int_CE = '1' AND CLK'last_value = '0' AND CLK = '1') THEN  -- rising edge!
            FOR i IN C_DEPTH-1-C_REG_LAST_BIT DOWNTO 1 LOOP
              shift(i) := shift(i-1);
            END LOOP;
            shift(0) := D;
          ELSIF (CLK'event AND (int_CE = 'X' OR
                                (CLK'last_value = '0' AND CLK = 'X') OR
                                (CLK'last_value = 'X' AND CLK = '1'))) THEN
            FOR i IN 0 TO C_DEPTH-1-C_REG_LAST_BIT LOOP
              shift(i) := (OTHERS => 'X');
            END LOOP;
          END IF;
          shift_out <= shift(C_DEPTH-1-C_REG_LAST_BIT);
        END IF;
      END IF;
    END PROCESS;
  END GENERATE;

  a1 : IF (C_HAS_A = 1) GENERATE
    intA <= A;
  END GENERATE;
  a0 : IF (C_HAS_A = 0) GENERATE
    intA <= STD_LOGIC_VECTOR(to_unsigned(C_DEPTH-1, C_ADDR_WIDTH));
  END GENERATE;

-------------------------------------------------------------------------------
-- Lossless behaviour
-------------------------------------------------------------------------------

  -- The lossless version is also fairly straight forward
  -- Updated - andreww 9th November 2004 - account for new pipelining option
  -- when c_opt_goal is set to 1 (speed optimisation)
  -- Also applies new BaseBlox v8 convention for pipeline register controls (no
  -- async controls if sync controls present)
  lossless : IF (C_SHIFT_TYPE = c_variable_lossless) GENERATE
    opt_area : IF (c_opt_goal = 0) OR (c_depth < 17) OR (c_depth = 17 AND c_reg_last_bit /= 0) GENERATE
      reged : IF (C_REG_LAST_BIT /= 0) GENERATE
        -- just an output register
        qout1 : C_REG_FD_V8_0
          GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                       C_HAS_ACLR      => C_HAS_ACLR,
                       C_HAS_AINIT     => C_HAS_AINIT,
                       C_HAS_ASET      => C_HAS_ASET,
                       C_HAS_CE        => C_HAS_CE,
                       C_HAS_SCLR      => C_HAS_SCLR,
                       C_HAS_SINIT     => C_HAS_SINIT,
                       C_HAS_SSET      => C_HAS_SSET,
                       C_SINIT_VAL     => C_SINIT_VAL,
                       C_SYNC_ENABLE   => C_SYNC_ENABLE,
                       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                       C_WIDTH         => C_WIDTH) 
          PORT MAP (D     => shift_out,
                    CLK   => CLK,
                    CE    => int_CE,
                    ACLR  => ACLR,
                    ASET  => ASET,
                    AINIT => AINIT,
                    SCLR  => SCLR,
                    SSET  => SSET,
                    SINIT => SINIT,
                    Q     => Q);
      END GENERATE reged;
      unreg : IF C_REG_LAST_BIT = 0 GENERATE
        Q <= shift_out;
      END GENERATE;
    END GENERATE opt_area;

    opt_speed : IF (c_opt_goal = 1) AND ((c_depth > 17) OR (c_depth = 17 AND c_reg_last_bit = 0)) GENERATE
      lat1 : IF c_depth <= 128 GENERATE
        -- latency will be at least 1 cycle
        -- qout1 is a pipeline register, so gets limited controls
        qout1 : C_REG_FD_V8_0
          GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                       C_HAS_ACLR      => 0,
                       C_HAS_AINIT     => 0,
                       C_HAS_ASET      => 0,
                       C_HAS_CE        => C_HAS_CE,
                       C_HAS_SCLR      => 0,
                       C_HAS_SINIT     => 0,
                       C_HAS_SSET      => 0,
                       C_SINIT_VAL     => C_SINIT_VAL,
                       C_SYNC_ENABLE   => C_SYNC_ENABLE,
                       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                       C_WIDTH         => C_WIDTH) 
          PORT MAP (D     => shift_out,
                    CLK   => CLK,
                    CE    => int_CE,
                    ACLR  => '0',
                    ASET  => '0',
                    AINIT => '0',
                    SCLR  => '0',
                    SSET  => '0',
                    SINIT => '0',
                    Q     => pipe1);             
        reged : IF (C_REG_LAST_BIT /= 0) GENERATE
          -- output register
          qout2 : C_REG_FD_V8_0
            GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                         C_HAS_ACLR      => C_HAS_ACLR,
                         C_HAS_AINIT     => C_HAS_AINIT,
                         C_HAS_ASET      => C_HAS_ASET,
                         C_HAS_CE        => C_HAS_CE,
                         C_HAS_SCLR      => C_HAS_SCLR,
                         C_HAS_SINIT     => C_HAS_SINIT,
                         C_HAS_SSET      => C_HAS_SSET,
                         C_SINIT_VAL     => C_SINIT_VAL,
                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                         C_WIDTH         => C_WIDTH) 
            PORT MAP (D     => pipe1,
                      CLK   => CLK,
                      CE    => int_CE,
                      ACLR  => ACLR,
                      ASET  => ASET,
                      AINIT => AINIT,
                      SCLR  => SCLR,
                      SSET  => SSET,
                      SINIT => SINIT,
                      Q     => Q);
        END GENERATE reged;
        unreg : IF C_REG_LAST_BIT = 0 GENERATE
          Q <= pipe1;
        END GENERATE;
      END GENERATE lat1;
      lat2 : IF c_depth > 128 GENERATE
        -- latency will be at least 2 cycles
        -- qout1 AND qout2 are pipeline registers and get limited controls
        qout1 : C_REG_FD_V8_0
          GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                       C_HAS_ACLR      => 0,
                       C_HAS_AINIT     => 0,
                       C_HAS_ASET      => 0,
                       C_HAS_CE        => C_HAS_CE,
                       C_HAS_SCLR      => 0,
                       C_HAS_SINIT     => 0,
                       C_HAS_SSET      => 0,
                       C_SINIT_VAL     => C_SINIT_VAL,
                       C_SYNC_ENABLE   => C_SYNC_ENABLE,
                       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                       C_WIDTH         => C_WIDTH) 
          PORT MAP (D     => shift_out,
                    CLK   => CLK,
                    CE    => int_CE,
                    ACLR  => '0',
                    ASET  => '0',
                    AINIT => '0',
                    SCLR  => '0',
                    SSET  => '0',
                    SINIT => '0',
                    Q     => pipe1);
        qout2 : C_REG_FD_V8_0
          GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                       C_HAS_ACLR      => 0,
                       C_HAS_AINIT     => 0,
                       C_HAS_ASET      => 0,
                       C_HAS_CE        => C_HAS_CE,
                       C_HAS_SCLR      => 0,
                       C_HAS_SINIT     => 0,
                       C_HAS_SSET      => 0,
                       C_SINIT_VAL     => C_SINIT_VAL,
                       C_SYNC_ENABLE   => C_SYNC_ENABLE,
                       C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                       C_WIDTH         => C_WIDTH) 
          PORT MAP (D     => pipe1,
                    CLK   => CLK,
                    CE    => int_CE,
                    ACLR  => '0',
                    ASET  => '0',
                    AINIT => '0',
                    SCLR  => '0',
                    SSET  => '0',
                    SINIT => '0',
                    Q     => pipe2);            
        reged : IF (C_REG_LAST_BIT = 1) GENERATE
          qout3 : C_REG_FD_V8_0
            GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                         C_HAS_ACLR      => C_HAS_ACLR,
                         C_HAS_AINIT     => C_HAS_AINIT,
                         C_HAS_ASET      => C_HAS_ASET,
                         C_HAS_CE        => C_HAS_CE,
                         C_HAS_SCLR      => C_HAS_SCLR,
                         C_HAS_SINIT     => C_HAS_SINIT,
                         C_HAS_SSET      => C_HAS_SSET,
                         C_SINIT_VAL     => C_SINIT_VAL,
                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                         C_WIDTH         => C_WIDTH) 
            PORT MAP (D     => pipe2,
                      CLK   => CLK,
                      CE    => int_CE,
                      ACLR  => ACLR,
                      ASET  => ASET,
                      AINIT => AINIT,
                      SCLR  => SCLR,
                      SSET  => SSET,
                      SINIT => SINIT,
                      Q     => Q);
        END GENERATE reged;
        unreg : IF NOT(C_REG_LAST_BIT = 1) GENERATE
          Q <= pipe2;
        END GENERATE;
      END GENERATE lat2;
    END GENERATE opt_speed;

    PROCESS (CLK, intA)
      VARIABLE rdeep : INTEGER := getRealDepth(C_DEPTH, c_reg_last_bit, c_shift_type);
      TYPE     shifttype IS ARRAY(0 TO rdeep-1) OF STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
      VARIABLE first : BOOLEAN := true;
      VARIABLE shift : shifttype;

      CONSTANT mem_bits  : INTEGER := rdeep * C_WIDTH;
      VARIABLE memdvect  : STD_LOGIC_VECTOR(mem_bits-1 DOWNTO 0);
      VARIABLE bits_good : BOOLEAN;
      VARIABLE lineno    : INTEGER := 0;
      VARIABLE offset    : INTEGER := 0;
      VARIABLE def_data  : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
      
    BEGIN

      -- Startup section reads and/or writes mif file if necessary.
      
      IF (first) THEN

        -- Call function in all cases - use to assign default data as well        
        memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, rdeep, c_mem_init_file, c_elaboration_dir, c_default_data);

        FOR i IN 0 TO rdeep-1 LOOP
          FOR j IN 0 TO C_WIDTH-1 LOOP
            shift(i)(j) := memdvect(j + i*C_WIDTH);
          END LOOP;
        END LOOP;
        IF (anyX(intA)) THEN
          shift_out <= (OTHERS => 'X');
        ELSIF (to_integer(UNSIGNED(intA)) >= rdeep) THEN
          shift_out <= (OTHERS => '0');
        ELSE
          shift_out <= shift(to_integer(UNSIGNED(intA)));
        END IF;

        first := false;
      ELSE                              -- Not FIRST
        IF (CLK'event AND int_CE = '1' AND CLK'last_value = '0' AND CLK = '1') THEN  -- rising edge!
          FOR i IN rdeep-1 DOWNTO 1 LOOP
            shift(i) := shift(i-1);
          END LOOP;
          shift(0) := D;
        ELSIF (CLK'event AND (int_CE = 'X' OR
                              (CLK'last_value = '0' AND CLK = 'X') OR
                              (CLK'last_value = 'X' AND CLK = '1'))) THEN
          FOR i IN 0 TO rdeep-1 LOOP
            shift(i) := (OTHERS => 'X');
          END LOOP;
        END IF;
        IF (anyX(intA)) THEN
          shift_out <= (OTHERS => 'X');
        ELSIF (to_integer(UNSIGNED(intA)) >= rdeep) THEN
          shift_out <= (OTHERS => 'X');  -- DLUNN MODIFIED FROM '0' FOR ILLEGAL ADDRESSING
        ELSE
          shift_out <= shift(to_integer(UNSIGNED(intA)));
        END IF;
      END IF;
    END PROCESS;
  END GENERATE;

-------------------------------------------------------------------------------
-- Lossy behaviour
-------------------------------------------------------------------------------

-- The lossy version requires some assesment of which value to
-- feed into the last sixteen locations.
  lossy : IF (C_SHIFT_TYPE = c_variable_lossy) GENERATE
    reged : IF (C_REG_LAST_BIT = 1) GENERATE
      qout : C_REG_FD_V8_0
        GENERIC MAP (C_AINIT_VAL     => C_AINIT_VAL,
                     C_HAS_ACLR      => C_HAS_ACLR,
                     C_HAS_AINIT     => C_HAS_AINIT,
                     C_HAS_ASET      => C_HAS_ASET,
                     C_HAS_CE        => C_HAS_CE,
                     C_HAS_SCLR      => C_HAS_SCLR,
                     C_HAS_SINIT     => C_HAS_SINIT,
                     C_HAS_SSET      => C_HAS_SSET,
                     C_SINIT_VAL     => C_SINIT_VAL,
                     C_SYNC_ENABLE   => C_SYNC_ENABLE,
                     C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                     C_WIDTH         => C_WIDTH) 
        PORT MAP (D     => shift_out,
                  CLK   => CLK,
                  CE    => int_CE,
                  ACLR  => ACLR,
                  ASET  => ASET,
                  AINIT => AINIT,
                  SCLR  => SCLR,
                  SSET  => SSET,
                  SINIT => SINIT,
                  Q     => Q);     
    END GENERATE;
    unreg : IF NOT (C_REG_LAST_BIT = 1) GENERATE
      Q <= shift_out;
    END GENERATE;


    PROCESS (CLK, intA)
      VARIABLE rdeep     : INTEGER                      := getRealDepth(C_DEPTH, c_reg_last_bit, c_shift_type);
      TYPE     shifttype IS ARRAY(0 TO rdeep-1) OF STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
      VARIABLE first     : BOOLEAN                      := true;
      VARIABLE shift     : shifttype;
      VARIABLE last16    : INTEGER;
      VARIABLE addtop    : STD_LOGIC_VECTOR(C_ADDR_WIDTH-1 DOWNTO 4*BOOLEAN'pos(C_ADDR_WIDTH > 4));
      VARIABLE addlow    : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
      VARIABLE addti     : INTEGER;
      CONSTANT mem_bits  : INTEGER                      := rdeep * C_WIDTH;
      VARIABLE memdvect  : STD_LOGIC_VECTOR(mem_bits-1 DOWNTO 0);
      VARIABLE bits_good : BOOLEAN;
      VARIABLE lineno    : INTEGER                      := 0;
      VARIABLE offset    : INTEGER                      := 0;
      VARIABLE def_data  : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);

    BEGIN

      -- Startup section reads and/or writes mif file if necessary.
      
      IF (first) THEN

     --   shift(rdeep-16 TO rdeep-1) := (OTHERS => def_data);

        -- Call function in all cases - use to assign default data as well
        memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, rdeep, c_mem_init_file, c_elaboration_dir, c_default_data);

        FOR i IN 0 TO rdeep -1 LOOP      
          FOR j IN 0 TO C_WIDTH-1 LOOP
            shift(i)(j) := memdvect(j + i*C_WIDTH);
          END LOOP;
        END LOOP;

        last16 := rdeep - 16;

        IF(C_ADDR_WIDTH > 4) THEN
          addlow := intA(3 DOWNTO 0);
        ELSE
          addlow(C_ADDR_WIDTH-1 DOWNTO 0) := intA;
        END IF;

        IF (anyX(addlow)) THEN
          shift_out <= (OTHERS => 'X');
        ELSE
          shift_out <= shift(last16+(to_integer(UNSIGNED(addlow))));
        END IF;

        first := false;
        
      ELSE                              -- Not FIRST
        
        IF(C_ADDR_WIDTH > 4) THEN
          addtop := intA(C_ADDR_WIDTH-1 DOWNTO 4*BOOLEAN'pos(C_ADDR_WIDTH > 4));
          addlow := intA(3 DOWNTO 0);
        ELSE
          addlow(C_ADDR_WIDTH-1 DOWNTO 0) := intA;
          addtop                          := (OTHERS => '0');
        END IF;

        IF (CLK'event AND int_CE = '1' AND CLK'last_value = '0' AND CLK = '1') THEN  -- rising edge!
          FOR i IN rdeep-1 DOWNTO last16+1 LOOP
            shift(i) := shift(i-1);
          END LOOP;
          IF (anyX(addtop)) THEN
            shift(last16) := (OTHERS => 'X');
          ELSE
            addti := to_integer(UNSIGNED(addtop))*16;
            IF(addti >= rdeep) THEN
              shift(last16) := (OTHERS => 'X');  -- DLUNN MODIFIED FROM '0' FOR ILLEGAL ADDRESSING
            ELSIF(addti = 0) THEN
              shift(last16) := D;
            ELSE
              shift(last16) := shift(addti-1);
            END IF;
          END IF;
          FOR i IN last16-1 DOWNTO 1 LOOP
            shift(i) := shift(i-1);
          END LOOP;
          shift(0) := D;
        ELSIF (CLK'event AND (int_CE = 'X' OR (CLK'last_value = '0' AND CLK = 'X') OR (CLK'last_value = 'X' AND CLK = '1'))) THEN
          FOR i IN 0 TO rdeep-1 LOOP
            shift(i) := (OTHERS => 'X');
          END LOOP;
        END IF;

        IF (anyX(addlow)) THEN
          shift_out <= (OTHERS => 'X');
        ELSE
          shift_out <= shift(last16 + to_integer(UNSIGNED(addlow)));
        END IF;
        
      END IF;
    END PROCESS;
  END GENERATE;


END behavioral;
