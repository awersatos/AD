-- $RCSfile: c_compare_v9_0.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:43 $
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

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_0.ALL;
USE XilinxCoreLib.prims_utils_v9_0.ALL;
USE XilinxCoreLib.c_reg_fd_v9_0_comp.ALL;

-- (A)Synchronous Comparator
--

--core_if on entity no_coregen_specials
  entity c_compare_v9_0 is
    GENERIC (
      c_width : INTEGER :=  16;
      c_ainit_val : STRING :=  "0";
      c_data_type : INTEGER :=  0;
      c_b_constant : INTEGER :=  0;
      c_b_value : STRING :=  "0000000000000000";
      c_sync_enable : INTEGER :=  0;
      c_sync_priority : INTEGER :=  1;
      c_pipe_stages : INTEGER :=  0;
      c_has_a_eq_b : INTEGER :=  1;
      c_has_a_ne_b : INTEGER :=  0;
      c_has_a_lt_b : INTEGER :=  0;
      c_has_a_gt_b : INTEGER :=  0;
      c_has_a_le_b : INTEGER :=  0;
      c_has_a_ge_b : INTEGER :=  0;
      c_has_qa_eq_b : INTEGER :=  0;
      c_has_qa_ne_b : INTEGER :=  0;
      c_has_qa_lt_b : INTEGER :=  0;
      c_has_qa_gt_b : INTEGER :=  0;
      c_has_qa_le_b : INTEGER :=  0;
      c_has_qa_ge_b : INTEGER :=  0;
      c_has_ce : INTEGER :=  0;
      c_has_aclr : INTEGER :=  0;
      c_has_aset : INTEGER :=  0;
      c_has_sclr : INTEGER :=  0;
      c_has_sset : INTEGER :=  0;
      c_enable_rlocs : INTEGER :=  0;
      c_carry_chain_eq_ne : INTEGER :=  0;
      c_infered_rtl_const_compare : INTEGER :=  0;
      c_dense_lut_packing : INTEGER :=  0
      );
    PORT (
      a : IN STD_LOGIC_VECTOR(c_width-1 DOWNTO 0):= (OTHERS => '0');
      b : IN STD_LOGIC_VECTOR(c_width-1 DOWNTO 0):= (OTHERS => '0');
      clk : IN STD_LOGIC:= '0';
      ce : IN STD_LOGIC:= '1';
      aclr : IN STD_LOGIC:= '0';
      aset : IN STD_LOGIC:= '0';
      sclr : IN STD_LOGIC:= '0';
      sset : IN STD_LOGIC:= '0';
      a_eq_b : OUT STD_LOGIC;
      a_ne_b : OUT STD_LOGIC;
      a_lt_b : OUT STD_LOGIC;
      a_gt_b : OUT STD_LOGIC;
      a_le_b : OUT STD_LOGIC;
      a_ge_b : OUT STD_LOGIC;
      qa_eq_b : OUT STD_LOGIC;
      qa_ne_b : OUT STD_LOGIC;
      qa_lt_b : OUT STD_LOGIC;
      qa_gt_b : OUT STD_LOGIC;
      qa_le_b : OUT STD_LOGIC;
      qa_ge_b : OUT STD_LOGIC
      );
--core_if off
END c_compare_v9_0;

ARCHITECTURE behavioral OF c_compare_v9_0 IS

  CONSTANT timeunit : TIME := 100 ps;

  -- signals for optional pins...
  SIGNAL intA_EQ_B  : STD_LOGIC                            := 'X';
  SIGNAL intA_NE_B  : STD_LOGIC                            := 'X';
  SIGNAL intA_LT_B  : STD_LOGIC                            := 'X';
  SIGNAL intA_GT_B  : STD_LOGIC                            := 'X';
  SIGNAL intA_LE_B  : STD_LOGIC                            := 'X';
  SIGNAL intA_GE_B  : STD_LOGIC                            := 'X';
  SIGNAL intQA_EQ_B : STD_LOGIC                            := 'X';
  SIGNAL intQA_NE_B : STD_LOGIC                            := 'X';
  SIGNAL intQA_LT_B : STD_LOGIC                            := 'X';
  SIGNAL intQA_GT_B : STD_LOGIC                            := 'X';
  SIGNAL intQA_LE_B : STD_LOGIC                            := 'X';
  SIGNAL intQA_GE_B : STD_LOGIC                            := 'X';
  SIGNAL intB       : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');

  SIGNAL zero  : STD_LOGIC := '0';
  SIGNAL one   : STD_LOGIC := '1';
  SIGNAL intCE : STD_LOGIC;

-- purpose: verifies correct combinations of generics
  FUNCTION check_generics(c_width, c_data_type, c_b_constant , c_sync_enable , c_sync_priority , c_pipe_stages ,
                          c_has_a_eq_b , c_has_a_ne_b , c_has_a_lt_b , c_has_a_gt_b , c_has_a_le_b , c_has_a_ge_b ,
                          c_has_qa_eq_b , c_has_qa_ne_b , c_has_qa_lt_b , c_has_qa_gt_b , c_has_qa_le_b , c_has_qa_ge_b ,
                          c_has_ce , c_has_aclr , c_has_aset , c_has_sclr , c_has_sset , c_enable_rlocs , lut_size : INTEGER;
                          c_b_value, c_ainit_val                                                                   : STRING) RETURN INTEGER IS
  BEGIN  -- FUNCTION check_generics
    
    IF c_data_type = c_unsigned THEN
      ASSERT c_width > 0 AND c_width < 257
        REPORT "ERROR: c_compare_v9_0 : Input width must be in the range 1 to 256 for UNSIGNED data"
        SEVERITY failure;
    ELSIF c_data_type = c_signed THEN
      ASSERT c_width > 1 AND c_width < 257
        REPORT "ERROR: c_compare_v9_0 : Input width must be in the range 2 to 256 for SIGNED data"
        SEVERITY failure;
    END IF;

    ASSERT c_data_type = c_signed OR c_data_type = c_unsigned
      REPORT "ERROR: c_compare_v9_0 : Invalid data type specified - possible values are 0 (signed) or 1 (unsigned)"
      SEVERITY failure;

    IF c_b_constant /= 0 THEN
      ASSERT c_b_value'length /= 0
        REPORT "WARNING: c_compare_v9_0 : Constant B port value undefined - defaulting to all zeros"
        SEVERITY warning;
--      IF c_width > c_b_value'length THEN
--        ASSERT false
--          REPORT "WARNING: c_compare_v9_0 : Constant B value (c_b_value) is shorter than " & INTEGER'image(c_width) & " bits - it will be zero-extended up to the MSB"
--          SEVERITY warning;
--      ELSIF c_width < c_b_value'length THEN
--        ASSERT false
--          REPORT "WARNING: c_compare_v9_0 : Constant B value (c_b_value) is longer than " & INTEGER'image(c_width) & " bits - it will be truncated at the LSB (right-hand side) end"
--          SEVERITY warning;
--      END IF;
    END IF;

    ASSERT c_sync_enable = 0 OR c_sync_enable = 1
      REPORT "ERROR: c_compare_v9_0 : Invalid value for c_sync_enable - possible values are 0 (SYNC_OVERRIDES_CE) or 1 (CE_OVERRIDES_SYNC)"
      SEVERITY failure;

    ASSERT c_sync_priority = 0 OR c_sync_priority = 1
      REPORT "ERROR: c_compare_v9_0 : Invalid value for c_sync_enable - possible values are 0 (SET_OVERRIDES_RESET) or 1 (RESET_OVERRIDES_SET)"
      SEVERITY failure;

    IF c_has_qa_eq_b = 0 AND c_has_qa_ne_b = 0 AND c_has_qa_lt_b = 0 AND c_has_qa_gt_b = 0 AND c_has_qa_le_b = 0 AND c_has_qa_ge_b = 0 THEN
      IF c_has_a_eq_b = 0 AND c_has_a_ne_b = 0 AND c_has_a_lt_b = 0 AND c_has_a_gt_b = 0 AND c_has_a_le_b = 0 AND c_has_a_ge_b = 0 THEN
        ASSERT false
          REPORT "ERROR: c_compare_v9_0 : At least one output must be selected for the comparator!"
          SEVERITY failure;
        ASSERT c_has_aclr = 0 AND c_has_aset = 0 AND c_has_sclr = 0 AND c_has_sset = 0 AND c_has_ce = 0 AND (NOT(c_pipe_stages > 0))
          REPORT "WARNING: c_compare_v9_0 : No synchronous output has been selected - CE, async controls or sync controls will not be implemented"
          SEVERITY warning;
      END IF;
    END IF;

    ASSERT c_pipe_stages < 6
      REPORT "ERROR: c_compare_v9_0 : c_pipe_stages generic is invalid - the valid range is 0 to 5, depending on core input width and function"
      SEVERITY failure;

    IF c_pipe_stages > 0 THEN
      -- allow users to generate sync AND async outputs even if the core is pipelined - just tap the 'async' output off from before the output REGISTER

      -- equality comparisons
      IF c_has_a_eq_b /= 0 OR c_has_qa_eq_b /= 0 OR c_has_a_ne_b /= 0 OR c_has_qa_ne_b /= 0 THEN
        IF c_b_constant = 0 THEN
          CASE lut_size IS
            WHEN 4 =>
              CASE c_pipe_stages IS
                WHEN 1      => ASSERT c_width > 2 REPORT "ERROR: c_compare_v9_0 : c_width must be > 2 for 1 pipeline stage" SEVERITY failure;
                WHEN 2      => ASSERT c_width > 8 REPORT "ERROR: c_compare_v9_0 : c_width must be > 8 for 2 pipeline stages" SEVERITY failure;
                WHEN 3      => ASSERT c_width > 32 REPORT "ERROR: c_compare_v9_0 : c_width must be > 32 for 3 pipeline stages" SEVERITY failure;
                WHEN 4      => ASSERT c_width > 128 REPORT "ERROR: c_compare_v9_0 : c_width must be > 128 for 4 pipeline stages" SEVERITY failure;
                WHEN OTHERS => ASSERT false
                                 REPORT "ERROR: c_compare_v9_0 : Invalid c_width value entered - c_pipe_stages should be in the range 0 to 4 for variable equality comparison"
                                 SEVERITY failure;
              END CASE;
            WHEN OTHERS => ASSERT false REPORT "ERROR: c_compare_v9_0 : Invalid lut_size detected in check_generics in c_compare_v9_0 " SEVERITY failure;
          END CASE;
        ELSIF c_b_constant /= 0 THEN
          CASE lut_size IS
            WHEN 4 =>
              CASE c_pipe_stages IS
                WHEN 1      => ASSERT c_width > 4 REPORT "ERROR: c_compare_v9_0 : c_width must be > 4 for 1 pipeline stage" SEVERITY failure;
                WHEN 2      => ASSERT c_width > 16 REPORT "ERROR: c_compare_v9_0 : c_width must be > 16 for 2 pipeline stages" SEVERITY failure;
                WHEN 3      => ASSERT c_width > 64 REPORT "ERROR: c_compare_v9_0 : c_width must be > 64 for 3 pipeline stages" SEVERITY failure;
                WHEN OTHERS => ASSERT false
                                 REPORT "ERROR: c_compare_v9_0 : Invalid c_width value entered - c_pipe_stages should be in the range 0 to 3 for constant equality comparison"
                                 SEVERITY failure;
              END CASE;
            WHEN OTHERS => ASSERT false REPORT "ERROR: c_compare_v9_0 : Invalid lut_size detected in check_generics in c_compare_v9_0 " SEVERITY failure;
          END CASE;
        END IF;
      END IF;

      -- Inequality comparisons
      IF c_has_a_lt_b /= 0 OR c_has_qa_lt_b /= 0 OR c_has_a_gt_b /= 0 OR c_has_qa_gt_b /= 0
        OR c_has_a_le_b /= 0 OR c_has_qa_le_b /= 0 OR c_has_a_ge_b /= 0 OR c_has_qa_ge_b /= 0 THEN
        -- Difference is only in the first stage LUTs, not in the core structure,
        -- so only allow max. 1 level of pipelining independent of variable or constant compares
        CASE c_pipe_stages IS
          WHEN 0      => ASSERT false REPORT "NOTE: c_compare_v9_0 : No pipelining has been implemented" SEVERITY note;  -- this should not be executed
          WHEN OTHERS => ASSERT false REPORT "NOTE: c_compare_v9_0 : One level of pipelining implemented" SEVERITY note;
--          WHEN OTHERS => ASSERT false REPORT "ERROR: c_compare_v9_0 : Maximum of one pipeline stage supported for inequality comparisons" SEVERITY failure;
        END CASE;
      END IF;
      
    END IF;  -- c_pipe_stages /= 0

    ASSERT c_enable_rlocs = 0
      REPORT "WARNING: c_compare_v9_0 : RLOCs are not supported in this core version"
      SEVERITY warning;
    
    ASSERT ((c_has_a_eq_b /= 0 OR c_has_qa_eq_b /= 0)
            XOR (c_has_a_ne_b /= 0 OR c_has_qa_ne_b /= 0)
            XOR (c_has_a_lt_b /= 0 OR c_has_qa_lt_b /= 0)
            XOR (c_has_a_gt_b /= 0 OR c_has_qa_gt_b /= 0)
            XOR (c_has_a_ge_b /= 0 OR c_has_qa_ge_b /= 0)
            XOR (c_has_a_le_b /= 0 OR c_has_qa_le_b /= 0))
      REPORT "ERROR: c_compare_v9_0 : Only one comparison (with registered and/or non-registered outputs) can be performed per instantiated core"
      SEVERITY failure;

    IF (c_has_aclr /= 0 OR c_has_aset /= 0) AND (c_has_sclr /= 0 OR c_has_sset /= 0) AND c_pipe_stages > 0 THEN
      ASSERT false
        REPORT "WARNING: c_compare_v9_0 : Including both asynchronous (ACLR, ASET) AND synchronous controls " &
        "(SCLR, SSET) will add a layer of logic and impact performance"
        SEVERITY warning;
    END IF;

    IF (c_ainit_val'length = 0
        AND (c_has_qa_eq_b /= 0
             OR c_has_qa_ne_b /= 0
             OR c_has_qa_lt_b /= 0
             OR c_has_qa_gt_b /= 0
             OR c_has_qa_le_b /= 0
             OR c_has_qa_ge_b /= 0)) THEN
      ASSERT false
        REPORT "WARNING: c_compare_v9_0 : No output register power-on value specified in c_ainit_val - defaulting to '0'"
        SEVERITY warning;
    END IF;

    RETURN 0;
  END FUNCTION check_generics;

  CONSTANT verify_generics : INTEGER RANGE 0 TO 0 := check_generics(c_width, c_data_type, c_b_constant , c_sync_enable , c_sync_priority , c_pipe_stages ,
                                                                    c_has_a_eq_b , c_has_a_ne_b , c_has_a_lt_b , c_has_a_gt_b , c_has_a_le_b , c_has_a_ge_b ,
                                                                    c_has_qa_eq_b , c_has_qa_ne_b , c_has_qa_lt_b , c_has_qa_gt_b , c_has_qa_le_b , c_has_qa_ge_b ,
                                                                    c_has_ce , c_has_aclr , c_has_aset , c_has_sclr , c_has_sset , c_enable_rlocs , 4, c_b_value, c_ainit_val);
  
  -- purpose: Determines what the POR value should be from the register controls that are present
  FUNCTION fn_get_por_value(c_has_aclr, c_has_aset, c_has_sclr, c_has_sset : INTEGER;
                            c_ainit_val                                    : STRING;
                            c_width                                        : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret : STD_LOGIC_VECTOR(c_width+1 DOWNTO 0) := (OTHERS => '0');
  BEGIN  -- FUNCTION fn_get_por_value
    -- define power-up value
    IF c_has_aclr /= 0 AND c_has_sclr = 0 AND c_has_sset = 0 THEN  -- account for pipeline control restrictions
      ret := (OTHERS => '0');
    ELSIF c_has_aset /= 0 AND c_has_sclr = 0 AND c_has_sset = 0 THEN  -- account for pipeline control restrictions
      ret := (OTHERS => '1');
    ELSIF (c_has_sclr /= 0) THEN
      ret := (OTHERS => '0');
    ELSIF (c_has_sset /= 0) THEN
      ret := (OTHERS => '1');
    ELSE
      IF c_ainit_val = "0" THEN
        ret := (OTHERS => '0');
      ELSIF c_ainit_val = "1" THEN
        ret := (OTHERS => '1');
      ELSE
        ret := (OTHERS => '0');
        ASSERT false REPORT "WARNING: c_compare_v9_0 : Illegal (or no) c_ainit_val caught in c_compare_v9_0 - defaulting to zero" SEVERITY warning;
      END IF;
    END IF;
    RETURN ret;
  END FUNCTION fn_get_por_value;

  CONSTANT reg_por_val : STD_LOGIC_VECTOR(c_pipe_stages+1 DOWNTO 0) := fn_get_por_value(c_has_aclr, c_has_aset, c_has_sclr, c_has_sset, c_ainit_val, c_pipe_Stages);

  -- pipelining signals
  SIGNAL intQA_EQ_Bpipeend : STD_LOGIC;
  SIGNAL intQA_NE_Bpipeend : STD_LOGIC;
  SIGNAL intQA_LT_Bpipeend : STD_LOGIC;
  SIGNAL intQA_GT_Bpipeend : STD_LOGIC;
  SIGNAL intQA_LE_Bpipeend : STD_LOGIC;
  SIGNAL intQA_GE_Bpipeend : STD_LOGIC;
  SIGNAL intQA_EQ_Bpipe    : STD_LOGIC_VECTOR(C_PIPE_STAGES+1 DOWNTO 0) := reg_por_val;
  SIGNAL intQA_NE_Bpipe    : STD_LOGIC_VECTOR(C_PIPE_STAGES+1 DOWNTO 0) := reg_por_val;
  SIGNAL intQA_LT_Bpipe    : STD_LOGIC_VECTOR(C_PIPE_STAGES+1 DOWNTO 0) := reg_por_val;
  SIGNAL intQA_GT_Bpipe    : STD_LOGIC_VECTOR(C_PIPE_STAGES+1 DOWNTO 0) := reg_por_val;
  SIGNAL intQA_LE_Bpipe    : STD_LOGIC_VECTOR(C_PIPE_STAGES+1 DOWNTO 0) := reg_por_val;
  SIGNAL intQA_GE_Bpipe    : STD_LOGIC_VECTOR(C_PIPE_STAGES+1 DOWNTO 0) := reg_por_val;

  -- pipelining signals for the async outputs
  SIGNAL intA_EQ_Bpipeend : STD_LOGIC;
  SIGNAL intA_NE_Bpipeend : STD_LOGIC;
  SIGNAL intA_LT_Bpipeend : STD_LOGIC;
  SIGNAL intA_GT_Bpipeend : STD_LOGIC;
  SIGNAL intA_LE_Bpipeend : STD_LOGIC;
  SIGNAL intA_GE_Bpipeend : STD_LOGIC;

  -- use unconstrained vector to allow for over-specified constant values
  SIGNAL intBslv : STD_LOGIC_VECTOR(C_B_VALUE'range);
  
BEGIN
  
  ce1 : IF C_HAS_CE = 1 GENERATE
    intCE <= CE;
  END GENERATE;
  ce0 : IF NOT (C_HAS_CE = 1) GENERATE
    intCE <= '1';
  END GENERATE;

  b1 : IF C_B_CONSTANT = 1 GENERATE
    -- if the string supplied is too long, we truncate at the RIGHT
    check_str_length : IF C_B_VALUE'length > C_WIDTH GENERATE
--      intBslv <= str_to_slv(C_B_VALUE);                       -- convert to SLV
----      intB    <= intBslv(intBslv'left TO intBslv'left+C_WIDTH-1);  -- trim at right
--    intB <= intBslv(intBslv'length-c_width TO intBslv'length);
    intB <= str_to_bound_slv_0(C_B_VALUE,C_WIDTH);
    END GENERATE check_str_length;
    str_right_size : IF C_B_VALUE'length <= C_WIDTH GENERATE  -- sign extension if needed should never be needed?
      intB <= str_to_slv_0(C_B_VALUE, C_WIDTH);
    END GENERATE str_right_size;
--      
--      check_ascending : IF (C_B_VALUE'ascending) GENERATE
--        sgn_ext_0 : IF C_B_VALUE(C_B_VALUE'left TO C_B_VALUE'left) = "0" OR (C_B_VALUE(C_B_VALUE'left TO C_B_VALUE'left) = "1" AND C_DATA_TYPE = c_unsigned) GENERATE
--          intB <= str_to_slv_0(C_B_VALUE, C_WIDTH);
--        END GENERATE sgn_ext_0;
--        sgn_ext_1 : IF C_B_VALUE(C_B_VALUE'left TO C_B_VALUE'left) = "1" AND C_DATA_TYPE = c_signed GENERATE
--          intB <= str_to_slv_1(C_B_VALUE, C_WIDTH);
--        END GENERATE sgn_ext_1;
--      END GENERATE check_ascending;
--      check_descending : IF NOT(C_B_VALUE'ascending) GENERATE
--        sgn_ext_0 : IF C_B_VALUE(C_B_VALUE'left DOWNTO C_B_VALUE'left) = "0" OR (C_B_VALUE(C_B_VALUE'left DOWNTO C_B_VALUE'left) = "1" AND C_DATA_TYPE = c_unsigned) GENERATE
--          intB <= str_to_slv_0(C_B_VALUE, C_WIDTH);
--        END GENERATE sgn_ext_0;
--        sgn_ext_1 : IF C_B_VALUE(C_B_VALUE'left DOWNTO C_B_VALUE'left) = "1" AND C_DATA_TYPE = c_signed GENERATE
--          intB <= str_to_slv_1(C_B_VALUE, C_WIDTH);
--        END GENERATE sgn_ext_1;
--      END GENERATE check_descending;
--    END GENERATE str_right_size;
  END GENERATE;
  b0 : IF NOT (C_B_CONSTANT = 1) GENERATE
    intB <= B;
  END GENERATE;

  p1 : PROCESS(A, intB)
    VARIABLE aeqb, aneb, altb, agtb, aleb, ageb : STD_LOGIC                            := 'X';
    VARIABLE notdone                            : INTEGER                              := 1;
    VARIABLE a_low, a_high, b_low, b_high       : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
    VARIABLE allXs                              : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
    VARIABLE allUs                              : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'U');
    VARIABLE all1s                              : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '1');
    VARIABLE all0s                              : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    
    aeqb := '0';
    aneb := '0';
    altb := '0';
    agtb := '0';
    aleb := '0';
    ageb := '0';

    IF is_X(A) OR is_X(intB) THEN
      -- We need to be a bit smarter than simply setting all outputs to 'X'...

      notdone := 1;

      IF ((is_X(A) AND (A = allXs OR A = allUs)) AND (is_X(intB) AND (intB = allXs OR intB = allUs))) THEN
        aeqb    := 'X';
        aneb    := 'X';
        altb    := 'X';
        agtb    := 'X';
        aleb    := 'X';
        ageb    := 'X';
        notdone := 0;
        
      ELSIF C_DATA_TYPE = c_signed THEN

        IF (NOT is_X(A(C_WIDTH-1))) AND (NOT is_X(intB(C_WIDTH-1))) THEN
          -- The sign bits are both known
          IF A(C_WIDTH-1) /= intB(C_WIDTH-1) THEN
                                        -- different signs!
            IF A(C_WIDTH-1) = '1' THEN
              -- A is negative and B is positive
              aeqb    := '0';
              aneb    := '1';
              altb    := '1';
              agtb    := '0';
              aleb    := '1';
              ageb    := '0';
              notdone := 0;
            ELSE                        -- A is +ve and B is -ve
              aeqb    := '0';
              aneb    := '1';
              altb    := '0';
              agtb    := '1';
              aleb    := '0';
              ageb    := '1';
              notdone := 0;
            END IF;
            
          END IF;
          
        END IF;
        
      END IF;

      IF notdone = 1 THEN               -- check further                      
        -- Make copies of A and B with all X's substituted with 0's and 1's
        a_low  := A;
        a_high := A;
        b_low  := intB;
        b_high := intB;
        FOR i IN C_WIDTH-2 DOWNTO 0 LOOP
          IF is_X(a_low(i)) THEN
            a_low(i)  := '0';
            a_high(i) := '1';
          END IF;
          IF is_X(b_low(i)) THEN
            b_low(i)  := '0';
            b_high(i) := '1';
          END IF;
        END LOOP;
        -- we now (almost - need to check possible sign bits) have worst-case values which must agree on the comparison result 
        -- if that result is not to be unknown...
        IF C_DATA_TYPE = c_signed THEN
          IF is_X(a_low(C_WIDTH-1)) THEN
            a_low(C_WIDTH-1)  := '1';
            a_high(C_WIDTH-1) := '0';
          END IF;
          IF is_X(b_low(C_WIDTH-1)) THEN
            b_low(C_WIDTH-1)  := '1';
            b_high(C_WIDTH-1) := '0';
          END IF;
          IF SIGNED(a_high) < SIGNED(b_low) THEN
                                        -- A is definitely < than B
            aeqb := '0';
            aneb := '1';
            altb := '1';
            agtb := '0';
            aleb := '1';
            ageb := '0';
          ELSIF SIGNED(a_low) > SIGNED(b_high) THEN
                                        -- A is definitely > than B     
            aeqb := '0';
            aneb := '1';
            altb := '0';
            agtb := '1';
            aleb := '0';
            ageb := '1';
          ELSIF SIGNED(a_high) = SIGNED(b_low) THEN
                                        -- A is <= B
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := '0';
            aleb := '1';
            ageb := 'X';
          ELSIF SIGNED(a_low) = SIGNED(b_high) THEN
                                        -- A is >= B
            aeqb := 'X';
            aneb := 'X';
            altb := '0';
            agtb := 'X';
            aleb := 'X';
            ageb := '1';
          ELSIF SIGNED(a_low) /= SIGNED(b_low) AND SIGNED(a_low) /= SIGNED(b_high) AND
            SIGNED(a_high) /= SIGNED(b_low) AND SIGNED(a_high) /= SIGNED(b_high) AND NOT((intB = allXs) OR (A = allXs) OR (intB = allUs) OR (A = allUs)) THEN
                                        -- A /= B
            aeqb := '0';
            aneb := '1';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          ELSE  -- There is > 1 overlap between the ranges so all X's
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          END IF;
        ELSE                            -- unsigned data
          IF is_X(a_low(C_WIDTH-1)) THEN
            a_low(C_WIDTH-1)  := '0';
            a_high(C_WIDTH-1) := '1';
          END IF;
          IF is_X(b_low(C_WIDTH-1)) THEN
            b_low(C_WIDTH-1)  := '0';
            b_high(C_WIDTH-1) := '1';
          END IF;
          IF UNSIGNED(a_high) < UNSIGNED(b_low) THEN
                                        -- A is definitely < than B
            aeqb := '0';
            aneb := '1';
            altb := '1';
            agtb := '0';
            aleb := '1';
            ageb := '0';
          ELSIF UNSIGNED(a_low) > UNSIGNED(b_high) THEN
                                        -- A is definitely > than B     
            aeqb := '0';
            aneb := '1';
            altb := '0';
            agtb := '1';
            aleb := '0';
            ageb := '1';
          ELSIF UNSIGNED(a_high) = UNSIGNED(b_low) THEN
                                        -- A is <= B
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := '0';
            aleb := '1';
            ageb := 'X';
          ELSIF UNSIGNED(a_low) = UNSIGNED(b_high) THEN
                                        -- A is >= B
            aeqb := 'X';
            aneb := 'X';
            altb := '0';
            agtb := 'X';
            aleb := 'X';
            ageb := '1';
          ELSIF UNSIGNED(a_low) /= UNSIGNED(b_low) AND UNSIGNED(a_low) /= UNSIGNED(b_high) AND
            UNSIGNED(a_high) /= UNSIGNED(b_low) AND UNSIGNED(a_high) /= UNSIGNED(b_high) AND NOT((intB = allXs) OR (A = allXs) OR (intB = allUs) OR (A = allUs)) THEN
                                        -- A /= B
            aeqb := '0';
            aneb := '1';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          ELSE  -- There is > 1 overlap between the ranges so all X's
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          END IF;
        END IF;
      END IF;
    ELSIF C_DATA_TYPE = c_signed THEN
      IF SIGNED(A) = SIGNED(intB) THEN
        aeqb := '1';
        aneb := '0';
        altb := '0';
        agtb := '0';
      END IF;
      IF SIGNED(A) < SIGNED(intB) THEN
        aeqb := '0';
        aneb := '1';
        altb := '1';
        agtb := '0';
      END IF;
      IF SIGNED(A) > SIGNED(intB) THEN
        aeqb := '0';
        aneb := '1';
        altb := '0';
        agtb := '1';
      END IF;
      IF aeqb = '1' OR altb = '1' THEN
        aleb := '1';
      END IF;
      IF aeqb = '1' OR agtb = '1' THEN
        ageb := '1';
      END IF;
    ELSE                                -- unsigned data
      IF UNSIGNED(A) = UNSIGNED(intB) THEN
        aeqb := '1';
        aneb := '0';
        altb := '0';
        agtb := '0';
      END IF;
      IF UNSIGNED(A) < UNSIGNED(intB) THEN
        aeqb := '0';
        aneb := '1';
        altb := '1';
        agtb := '0';
      END IF;
      IF UNSIGNED(A) > UNSIGNED(intB) THEN
        aeqb := '0';
        aneb := '1';
        altb := '0';
        agtb := '1';
      END IF;
      IF aeqb = '1' OR altb = '1' THEN
        aleb := '1';
      END IF;
      IF aeqb = '1' OR agtb = '1' THEN
        ageb := '1';
      END IF;
    END IF;

    intA_EQ_B <= aeqb;-- AFTER timeunit;
    intA_NE_B <= aneb;-- AFTER timeunit;
    intA_LT_B <= altb;-- AFTER timeunit;
    intA_GT_B <= agtb;-- AFTER timeunit;
    intA_LE_B <= aleb;-- AFTER timeunit;
    intA_GE_B <= ageb;-- AFTER timeunit;
    
  END PROCESS;

  aeqb0 : IF NOT (C_HAS_A_EQ_B = 1) GENERATE
    A_EQ_B <= 'X';
  END GENERATE;
  aeqb1 : IF C_HAS_A_EQ_B = 1 AND C_PIPE_STAGES < 1 GENERATE
    A_EQ_B <= intA_EQ_B;
  END GENERATE aeqb1;
  aeqb2 : IF C_HAS_A_EQ_B = 1 AND C_PIPE_STAGES > 0 GENERATE
    A_EQ_B <= intA_EQ_Bpipeend;
  END GENERATE aeqb2;

  aneb0 : IF NOT (C_HAS_A_NE_B = 1) GENERATE
    A_NE_B <= 'X';
  END GENERATE;
  aneb1 : IF C_HAS_A_NE_B = 1 AND C_PIPE_STAGES < 1 GENERATE
    A_NE_B <= intA_NE_B;
  END GENERATE aneb1;
  aneb2 : IF C_HAS_A_NE_B = 1 AND C_PIPE_STAGES > 0 GENERATE
    A_NE_B <= intA_NE_Bpipeend;
  END GENERATE aneb2;

  altb0 : IF NOT (C_HAS_A_LT_B = 1) GENERATE
    A_LT_B <= 'X';
  END GENERATE;
  altb1 : IF C_HAS_A_LT_B = 1 AND C_PIPE_STAGES < 1 GENERATE
    A_LT_B <= intA_LT_B;
  END GENERATE;
  altb2 : IF C_HAS_A_LT_B = 1 AND C_PIPE_STAGES > 0 GENERATE
    A_LT_B <= intA_LT_Bpipeend;
  END GENERATE altb2;

  agtb0 : IF NOT (C_HAS_A_GT_B = 1) GENERATE
    A_GT_B <= 'X';
  END GENERATE;
  agtb1 : IF C_HAS_A_GT_B = 1 AND C_PIPE_STAGES < 1 GENERATE
    A_GT_B <= intA_GT_B;
  END GENERATE;
  agtb2 : IF C_HAS_A_GT_B = 1 AND C_PIPE_STAGES > 0 GENERATE
    A_GT_B <= intA_GT_Bpipeend;
  END GENERATE agtb2;

  aleb0 : IF NOT (C_HAS_A_LE_B = 1) GENERATE
    A_LE_B <= 'X';
  END GENERATE;
  aleb1 : IF C_HAS_A_LE_B = 1 AND C_PIPE_STAGES < 1 GENERATE
    A_LE_B <= intA_LE_B;
  END GENERATE;
  aleb2 : IF C_HAS_A_LE_B = 1 AND C_PIPE_STAGES > 0 GENERATE
    A_LE_B <= intA_LE_Bpipeend;
  END GENERATE aleb2;

  ageb0 : IF NOT (C_HAS_A_GE_B = 1) GENERATE
    A_GE_B <= 'X';
  END GENERATE;
  ageb1 : IF C_HAS_A_GE_B = 1 AND C_PIPE_STAGES < 1 GENERATE
    A_GE_B <= intA_GE_B;
  END GENERATE ageb1;
  ageb2 : IF C_HAS_A_GE_B = 1 AND C_PIPE_STAGES > 0 GENERATE
    A_GE_B <= intA_GE_Bpipeend;
  END GENERATE ageb2;

-------------------------------------------------------------------------------
-- Equal-to comparison
-------------------------------------------------------------------------------

  aeqbr1 : IF C_HAS_QA_EQ_B = 1 GENERATE  -- allow all controls on the output register
    aeqbreg : c_reg_fd_v9_0 GENERIC MAP (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      PORT MAP(D(0) => intQA_EQ_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_EQ_B);
  END GENERATE;

  pipeeq : PROCESS (CLK, ACLR, ASET)
  BEGIN

    -- Only allow async controls on the pipeline registers if no sync controls
    -- are present
    IF ACLR = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aclr : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_EQ_Bpipe(p) <= '0';
      END LOOP;  -- pipeloop
    ELSIF ASET = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aset : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_EQ_Bpipe(p) <= '1';
      END LOOP;  -- pipeloop    

      -- Always allow sync controls on the registers if present - take
      -- priorities etc. into account
    ELSIF c_sync_enable = 0 THEN        -- SYNC_OVERRIDES_CE
      IF CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop0a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF SCLR = '1' THEN
            pipeloop0b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' THEN
            pipeloop0c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_EQ_Bpipe(p) <= intQA_EQ_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_EQ_Bpipe(C_PIPE_STAGES) <= intA_EQ_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop0d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop0e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' THEN
            pipeloop0f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_EQ_Bpipe(p) <= intQA_EQ_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_EQ_Bpipe(C_PIPE_STAGES) <= intA_EQ_B;
          END IF;
        END IF;
      END IF;
    ELSIF c_sync_enable = 1 THEN
      IF intCE = '1' AND CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIEDS_RESET
          IF SSET = '1' THEN
            pipeloop1a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF SCLR = '1' THEN
            pipeloop1b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_EQ_Bpipe(p) <= intQA_EQ_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_EQ_Bpipe(C_PIPE_STAGES) <= intA_EQ_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop1d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop1e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_EQ_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_EQ_Bpipe(p) <= intQA_EQ_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_EQ_Bpipe(C_PIPE_STAGES) <= intA_EQ_B;
          END IF;
        END IF;
      END IF;
    END IF;

--    IF intCE = '1' AND CLK = '1' AND CLK'last_value /= 'X' AND C_PIPE_STAGES > 0 THEN
--      pipeloop : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        intQA_EQ_Bpipe(p) <= intQA_EQ_Bpipe(p+1);
--      END LOOP;  -- pipeloop
--      intQA_EQ_Bpipe(C_PIPE_STAGES) <= intA_EQ_B;
--    ELSIF (intCE = 'X' OR (CLK = 'X' AND CLK'last_value = '0') OR (CLK = '1' AND CLK'last_value = 'X')) AND C_PIPE_STAGES > 0 THEN
--      pipeloopx : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        IF intQA_EQ_Bpipe(p) /= intQA_EQ_Bpipe(p+1) THEN
--          intQA_EQ_Bpipe(p) <= 'X';
--        END IF;
--      END LOOP;  -- pipeloop
--      IF intQA_EQ_Bpipe(C_PIPE_STAGES) /= intA_EQ_B THEN
--        intQA_EQ_Bpipe(C_PIPE_STAGES) <= 'X';
--      END IF;
--    END IF;
    
  END PROCESS;  -- pipeq

  ps1 : IF C_PIPE_STAGES < 1 GENERATE
    intQA_EQ_Bpipeend <= intA_EQ_B;
  END GENERATE;
  ps1b : IF C_PIPE_STAGES > 0 GENERATE
    intQA_EQ_Bpipeend <= intQA_EQ_Bpipe(1);
    intA_EQ_Bpipeend  <= intQA_EQ_Bpipe(1);  -- avoid output register for async output
  END GENERATE;

  qeq1 : IF C_HAS_QA_EQ_B = 1 GENERATE
    QA_EQ_B <= intQA_EQ_B AFTER timeunit;
  END GENERATE;
  qeq0 : IF NOT (C_HAS_QA_EQ_B = 1) GENERATE
    QA_EQ_B <= 'X';
  END GENERATE;

-------------------------------------------------------------------------------
-- Not-equal comparison
-------------------------------------------------------------------------------

  anebr1 : IF C_HAS_QA_NE_B = 1 GENERATE  -- allow all controls on the output register
    anebreg : c_reg_fd_v9_0 GENERIC MAP (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      PORT MAP(D(0) => intQA_NE_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_NE_B);
  END GENERATE;

  pipene : PROCESS (CLK, ACLR, ASET)
  BEGIN

    -- Only allow async controls on the pipeline registers if no sync controls
    -- are present
    IF ACLR = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aclr : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_NE_Bpipe(p) <= '0';
      END LOOP;  -- pipeloopaclr
    ELSIF ASET = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aset : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_NE_Bpipe(p) <= '1';
      END LOOP;  -- pipeloopaset    

      -- Always allow sync controls on the registers if present - take
      -- priorities etc. into account
    ELSIF c_sync_enable = 0 THEN        -- SYNC_OVERRIDES_CE
      IF CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop0a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSIF SCLR = '1' THEN
            pipeloop0b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSIF intCE = '1' THEN
            pipeloop0c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_NE_Bpipe(p) <= intQA_NE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_NE_Bpipe(C_PIPE_STAGES) <= intA_NE_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop0d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSIF SSET = '1' THEN
            pipeloop0e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSIF intCE = '1' THEN
            pipeloop0f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_NE_Bpipe(p) <= intQA_NE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_NE_Bpipe(C_PIPE_STAGES) <= intA_NE_B;
          END IF;
        END IF;
      END IF;
    ELSIF c_sync_enable = 1 THEN        -- CE_OVERRIDES_SYNC
      IF intCE = '1' AND CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop1a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSIF SCLR = '1' THEN
            pipeloop1b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSE
            pipeloop1c : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= intQA_NE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_NE_Bpipe(C_PIPE_STAGES) <= intA_NE_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop1d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSIF SSET = '1' THEN
            pipeloop1e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSE
            pipeloop1f : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_NE_Bpipe(p) <= intQA_NE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_NE_Bpipe(C_PIPE_STAGES) <= intA_NE_B;
          END IF;
        END IF;
      END IF;
    END IF;

    -- The old code...
--    IF intCE = '1' AND CLK = '1' AND CLK'last_value /= 'X' AND C_PIPE_STAGES > 0 THEN
--      pipeloop : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        intQA_NE_Bpipe(p) <= intQA_NE_Bpipe(p+1);
--      END LOOP;  -- pipeloop
--      intQA_NE_Bpipe(C_PIPE_STAGES) <= intA_NE_B;
--    ELSIF (intCE = 'X' OR (CLK = 'X' AND CLK'last_value = '0') OR (CLK = '1' AND CLK'last_value = 'X')) AND C_PIPE_STAGES > 0 THEN
--      pipeloopx : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        IF intQA_NE_Bpipe(p) /= intQA_NE_Bpipe(p+1) THEN
--          intQA_NE_Bpipe(p) <= 'X';
--        END IF;
--      END LOOP;  -- pipeloop
--      IF intQA_NE_Bpipe(C_PIPE_STAGES) /= intA_NE_B THEN
--        intQA_NE_Bpipe(C_PIPE_STAGES) <= 'X';
--      END IF;
--    END IF;
    
  END PROCESS;  -- pipeq

  ps2 : IF C_PIPE_STAGES < 1 GENERATE
    intQA_NE_Bpipeend <= intA_NE_B;
  END GENERATE;
  ps2b : IF C_PIPE_STAGES > 0 GENERATE
    intQA_NE_Bpipeend <= intQA_NE_Bpipe(1);
    intA_NE_Bpipeend  <= intQA_NE_Bpipe(1);  -- avoid output register for async output
  END GENERATE;

  qne1 : IF C_HAS_QA_NE_B = 1 GENERATE
    QA_NE_B <= intQA_NE_B AFTER timeunit;
  END GENERATE;
  qne0 : IF NOT (C_HAS_QA_NE_B = 1) GENERATE
    QA_NE_B <= 'X';
  END GENERATE;

-------------------------------------------------------------------------------
-- Less-than comparison
-------------------------------------------------------------------------------

  altbr1 : IF C_HAS_QA_LT_B = 1 GENERATE  -- allow all controls on the output register
    altbreg : c_reg_fd_v9_0 GENERIC MAP (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      PORT MAP(D(0) => intQA_LT_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_LT_B);
  END GENERATE;

  pipelt : PROCESS (CLK, ACLR, ASET)
  BEGIN

    -- Only allow async controls on the pipeline registers if no sync controls
    -- are present
    IF ACLR = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aclr : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_LT_Bpipe(p) <= '0';
      END LOOP;  -- pipeloop      
    ELSIF ASET = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aset : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_LT_Bpipe(p) <= '1';
      END LOOP;  -- pipeloop      

      -- Always allow sync controls on the registers if present - take
      -- priorities etc. into account
    ELSIF c_sync_enable = 0 THEN        -- SYNC_OVERRIDES_CE
      IF CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop0a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSIF SCLR = '1' THEN
            pipeloop0b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSIF intCE = '1' THEN
            pipeloop0c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LT_Bpipe(p) <= intQA_LT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LT_Bpipe(C_PIPE_STAGES) <= intA_LT_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop0d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSIF SSET = '1' THEN
            pipeloop0e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSIF intCE = '1' THEN
            pipeloop0f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LT_Bpipe(p) <= intQA_LT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LT_Bpipe(C_PIPE_STAGES) <= intA_LT_B;
          END IF;
        END IF;
      END IF;
    ELSIF c_sync_enable = 1 THEN
      IF intCE = '1' AND CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop0g : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSIF SCLR = '1' THEN
            pipeloop0h : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSE
            pipeloop0i : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LT_Bpipe(p) <= intQA_LT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LT_Bpipe(C_PIPE_STAGES) <= intA_LT_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop0j : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop            
          ELSIF SSET = '1' THEN
            pipeloop0k : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop            
          ELSE
            pipeloop0l : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LT_Bpipe(p) <= intQA_LT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LT_Bpipe(C_PIPE_STAGES) <= intA_LT_B;
          END IF;
        END IF;
      END IF;
    END IF;

    -- The old code....
--    IF intCE = '1' AND CLK = '1' AND CLK'last_value /= 'X' AND C_PIPE_STAGES > 0 THEN
--      pipeloop : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        intQA_LT_Bpipe(p) <= intQA_LT_Bpipe(p+1);
--      END LOOP;  -- pipeloop
--      intQA_LT_Bpipe(C_PIPE_STAGES) <= intA_LT_B;
--    ELSIF (intCE = 'X' OR (CLK = 'X' AND CLK'last_value = '0') OR (CLK = '1' AND CLK'last_value = 'X')) AND C_PIPE_STAGES > 0 THEN
--      pipeloopx : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        IF intQA_LT_Bpipe(p) /= intQA_LT_Bpipe(p+1) THEN
--          intQA_LT_Bpipe(p) <= 'X';
--        END IF;
--      END LOOP;  -- pipeloop
--      IF intQA_LT_Bpipe(C_PIPE_STAGES) /= intA_LT_B THEN
--        intQA_LT_Bpipe(C_PIPE_STAGES) <= 'X';
--      END IF;
--    END IF;
    
  END PROCESS;  -- pipeq

  ps3 : IF C_PIPE_STAGES < 1 GENERATE
    intQA_LT_Bpipeend <= intA_LT_B;
  END GENERATE;
  ps3b : IF C_PIPE_STAGES > 0 GENERATE
    intQA_LT_Bpipeend <= intQA_LT_Bpipe(1);
    -- allow a non-registered pipelined module
    intA_LT_Bpipeend  <= intQA_LT_Bpipe(1);  -- avoid output register    
  END GENERATE;

  qlt1 : IF C_HAS_QA_LT_B = 1 GENERATE
    QA_LT_B <= intQA_LT_B AFTER timeunit;
  END GENERATE;
  qlt0 : IF NOT (C_HAS_QA_LT_B = 1) GENERATE
    QA_LT_B <= 'X';
  END GENERATE;

-------------------------------------------------------------------------------
-- Greater-than comparison
-------------------------------------------------------------------------------

  agtbr1 : IF C_HAS_QA_GT_B = 1 GENERATE
    agtbreg : c_reg_fd_v9_0 GENERIC MAP (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      PORT MAP(D(0) => intQA_GT_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_GT_B);
  END GENERATE;

  pipegt : PROCESS (CLK, ACLR, ASET)
  BEGIN

    -- Only allow async controls on the pipeline registers if no sync controls
    -- are present
    IF ACLR = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aclr : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_GT_Bpipe(p) <= '0';
      END LOOP;  -- pipeloop   
    ELSIF ASET = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aset : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_GT_Bpipe(p) <= '1';
      END LOOP;  -- pipeloop   

      -- Always allow sync controls on the registers if present - take
      -- priorities etc. into account
    ELSIF c_sync_enable = 0 THEN        -- SYNC_OVERRIDES_CE
      IF CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop0a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop                       
          ELSIF SCLR = '1' THEN
            pipeloop0b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' THEN
            pipeloop0c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GT_Bpipe(p) <= intQA_GT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GT_Bpipe(C_PIPE_STAGES) <= intA_GT_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop0d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop0e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' THEN
            pipeloop0f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GT_Bpipe(p) <= intQA_GT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GT_Bpipe(C_PIPE_STAGES) <= intA_GT_B;
          END IF;
        END IF;
      END IF;
    ELSIF c_sync_enable = 1 THEN
      IF intCE = '1' AND CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIEDS_RESET
          IF SSET = '1' THEN
            pipeloop1a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF SCLR = '1' THEN
            pipeloop1b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GT_Bpipe(p) <= intQA_GT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GT_Bpipe(C_PIPE_STAGES) <= intA_GT_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop1d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop1e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GT_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GT_Bpipe(p) <= intQA_GT_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GT_Bpipe(C_PIPE_STAGES) <= intA_GT_B;
          END IF;
        END IF;
      END IF;
    END IF;

    -- The old code for this section...
--    IF intCE = '1' AND CLK = '1' AND CLK'last_value /= 'X' AND C_PIPE_STAGES > 0 THEN
--      pipeloop : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        intQA_GT_Bpipe(p) <= intQA_GT_Bpipe(p+1);
--      END LOOP;  -- pipeloop
--      intQA_GT_Bpipe(C_PIPE_STAGES) <= intA_GT_B;
--    ELSIF (intCE = 'X' OR (CLK = 'X' AND CLK'last_value = '0') OR (CLK = '1' AND CLK'last_value = 'X')) AND C_PIPE_STAGES > 0 THEN
--      pipeloopx : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        IF intQA_GT_Bpipe(p) /= intQA_GT_Bpipe(p+1) THEN
--          intQA_GT_Bpipe(p) <= 'X';
--        END IF;
--      END LOOP;  -- pipeloop
--      IF intQA_GT_Bpipe(C_PIPE_STAGES) /= intA_GT_B THEN
--        intQA_GT_Bpipe(C_PIPE_STAGES) <= 'X';
--      END IF;
--    END IF;
    
  END PROCESS;  -- pipeq

  ps4 : IF C_PIPE_STAGES < 1 GENERATE
    intQA_GT_Bpipeend <= intA_GT_B;
  END GENERATE;
  ps4b : IF C_PIPE_STAGES > 0 GENERATE
    intQA_GT_Bpipeend <= intQA_GT_Bpipe(1);
    intA_GT_Bpipeend  <= intQA_GT_Bpipe(1);  -- avoid output register for async output
  END GENERATE;

  qgt1 : IF C_HAS_QA_GT_B = 1 GENERATE
    QA_GT_B <= intQA_GT_B AFTER timeunit;
  END GENERATE;
  qgt0 : IF NOT (C_HAS_QA_GT_B = 1) GENERATE
    QA_GT_B <= 'X';
  END GENERATE;

-------------------------------------------------------------------------------
-- Less-than-equal comparison
-------------------------------------------------------------------------------

  alebr1 : IF C_HAS_QA_LE_B = 1 GENERATE
    alebreg : c_reg_fd_v9_0 GENERIC MAP (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      PORT MAP(D(0) => intQA_LE_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_LE_B);
  END GENERATE;

  pipele : PROCESS (CLK, ACLR, ASET)
  BEGIN

    -- Only allow async controls on the pipeline registers if no sync controls
    -- are present
    IF ACLR = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aclr : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_LE_Bpipe(p) <= '0';
      END LOOP;  -- pipeloop
    ELSIF ASET = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aset : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_LE_Bpipe(p) <= '1';
      END LOOP;  -- pipeloop

      -- Always allow sync controls on the registers if present - take
      -- priorities etc. into account
    ELSIF c_sync_enable = 0 THEN        -- SYNC_OVERRIDES_CE
      IF CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop0a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF SCLR = '1' THEN
            pipeloop0b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' THEN
            pipeloop0c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LE_Bpipe(p) <= intQA_LE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LE_Bpipe(C_PIPE_STAGES) <= intA_LE_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop0d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop0e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' THEN
            pipeloop0f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LE_Bpipe(p) <= intQA_LE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LE_Bpipe(C_PIPE_STAGES) <= intA_LE_B;
          END IF;
        END IF;
      END IF;
    ELSIF c_sync_enable = 1 THEN
      IF intCE = '1' AND CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIEDS_RESET
          IF SSET = '1' THEN
            pipeloop1a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF SCLR = '1' THEN
            pipeloop1b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LE_Bpipe(p) <= intQA_LE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LE_Bpipe(C_PIPE_STAGES) <= intA_LE_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop1d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop1e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_LE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_LE_Bpipe(p) <= intQA_LE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_LE_Bpipe(C_PIPE_STAGES) <= intA_LE_B;
          END IF;
        END IF;
      END IF;
    END IF;

    -- the old code from this section...
--    IF intCE = '1' AND CLK = '1' AND CLK'last_value /= 'X' AND C_PIPE_STAGES > 0 THEN
--      pipeloop : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        intQA_LE_Bpipe(p) <= intQA_LE_Bpipe(p+1);
--      END LOOP;  -- pipeloop
--      intQA_LE_Bpipe(C_PIPE_STAGES) <= intA_LE_B;
--    ELSIF (intCE = 'X' OR (CLK = 'X' AND CLK'last_value = '0') OR (CLK = '1' AND CLK'last_value = 'X')) AND C_PIPE_STAGES > 0 THEN
--      pipeloopx : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        IF intQA_LE_Bpipe(p) /= intQA_LE_Bpipe(p+1) THEN
--          intQA_LE_Bpipe(p) <= 'X';
--        END IF;
--      END LOOP;  -- pipeloop
--      IF intQA_LE_Bpipe(C_PIPE_STAGES) /= intA_LE_B THEN
--        intQA_LE_Bpipe(C_PIPE_STAGES) <= 'X';
--      END IF;
--    END IF;
    
  END PROCESS;  -- pipeq

  ps5 : IF C_PIPE_STAGES < 1 GENERATE
    intQA_LE_Bpipeend <= intA_LE_B;
  END GENERATE;
  ps5b : IF C_PIPE_STAGES > 0 GENERATE
    intQA_LE_Bpipeend <= intQA_LE_Bpipe(1);
    intA_LE_Bpipeend  <= intQA_LE_Bpipe(1);  -- avoid output register for async output
  END GENERATE;

  qle1 : IF C_HAS_QA_LE_B = 1 GENERATE
    QA_LE_B <= intQA_LE_B AFTER timeunit;
  END GENERATE;
  qle0 : IF NOT (C_HAS_QA_LE_B = 1) GENERATE
    QA_LE_B <= 'X';
  END GENERATE;

-------------------------------------------------------------------------------
-- Greater-than-equal comparison
-------------------------------------------------------------------------------

  agebr1 : IF C_HAS_QA_GE_B = 1 GENERATE  -- allow all controls on output register
    agebreg : c_reg_fd_v9_0 GENERIC MAP (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      PORT MAP(D(0) => intQA_GE_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_GE_B);
  END GENERATE;

  pipege : PROCESS (CLK, ACLR, ASET)
  BEGIN

    -- Only allow async controls on the pipeline registers if no sync controls
    -- are present
    IF ACLR = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aclr : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_GE_Bpipe(p) <= '0';
      END LOOP;  -- pipeloop
    ELSIF ASET = '1' AND c_has_sclr = 0 AND c_has_sset = 0 THEN
      pipeloop0aset : FOR p IN 1 TO C_PIPE_STAGES LOOP
        intQA_GE_Bpipe(p) <= '1';
      END LOOP;  -- pipeloop

      -- Always allow sync controls on the registers if present - take
      -- priorities etc. into account
    ELSIF c_sync_enable = 0 THEN        -- SYNC_OVERRIDES_CE
      IF CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIDES_RESET
          IF SSET = '1' THEN
            pipeloop0a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF SCLR = '1' THEN
            pipeloop0b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' AND SSET = '0' AND SCLR = '0' THEN
            pipeloop0c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GE_Bpipe(p) <= intQA_GE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GE_Bpipe(C_PIPE_STAGES) <= intA_GE_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop0d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop0e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF intCE = '1' AND SSET = '0' AND SCLR = '0' THEN
            pipeloop0f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GE_Bpipe(p) <= intQA_GE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GE_Bpipe(C_PIPE_STAGES) <= intA_GE_B;
          END IF;
        END IF;
      END IF;
    ELSIF c_sync_enable = 1 THEN
      IF intCE = '1' AND CLK = '1' AND CLK'event AND C_PIPE_STAGES > 0 THEN
        IF c_sync_priority = 0 THEN     -- SET_OVERRIEDS_RESET
          IF SSET = '1' THEN
            pipeloop1a : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSIF SCLR = '1' THEN
            pipeloop1b : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1c : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GE_Bpipe(p) <= intQA_GE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GE_Bpipe(C_PIPE_STAGES) <= intA_GE_B;
          END IF;
        ELSE                            -- RESET_OVERRIDES_SET
          IF SCLR = '1' THEN
            pipeloop1d : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '0';
            END LOOP;  -- pipeloop
          ELSIF SSET = '1' THEN
            pipeloop1e : FOR p IN 1 TO C_PIPE_STAGES LOOP
              intQA_GE_Bpipe(p) <= '1';
            END LOOP;  -- pipeloop
          ELSE
            pipeloop1f : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
              intQA_GE_Bpipe(p) <= intQA_GE_Bpipe(p+1);
            END LOOP;  -- pipeloop            
            intQA_GE_Bpipe(C_PIPE_STAGES) <= intA_GE_B;
          END IF;
        END IF;
      END IF;
    END IF;

--    IF intCE = '1' AND CLK = '1' AND CLK'last_value /= 'X' AND C_PIPE_STAGES > 0 THEN
--      pipeloop : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        intQA_GE_Bpipe(p) <= intQA_GE_Bpipe(p+1);
--      END LOOP;  -- pipeloop
--      intQA_GE_Bpipe(C_PIPE_STAGES) <= intA_GE_B;
--    ELSIF (intCE = 'X' OR (CLK = 'X' AND CLK'last_value = '0') OR (CLK = '1' AND CLK'last_value = 'X')) AND C_PIPE_STAGES > 0 THEN
--      pipeloopx : FOR p IN 1 TO C_PIPE_STAGES-1 LOOP
--        IF intQA_GE_Bpipe(p) /= intQA_GE_Bpipe(p+1) THEN
--          intQA_GE_Bpipe(p) <= 'X';
--        END IF;
--      END LOOP;  -- pipeloop
--      IF intQA_GE_Bpipe(C_PIPE_STAGES) /= intA_GE_B THEN
--        intQA_GE_Bpipe(C_PIPE_STAGES) <= 'X';
--      END IF;
--    END IF;
    
  END PROCESS;  -- pipeq

  ps6 : IF C_PIPE_STAGES < 1 GENERATE
    intQA_GE_Bpipeend <= intA_GE_B;
  END GENERATE;
  ps6b : IF C_PIPE_STAGES > 0 GENERATE
    intQA_GE_Bpipeend <= intQA_GE_Bpipe(1);
    intA_GE_Bpipeend  <= intQA_GE_Bpipe(1);  -- avoid output register for async output    
  END GENERATE;

  qge1 : IF C_HAS_QA_GE_B = 1 GENERATE
    QA_GE_B <= intQA_GE_B AFTER timeunit;
  END GENERATE;
  qge0 : IF NOT (C_HAS_QA_GE_B = 1) GENERATE
    QA_GE_B <= 'X';
  END GENERATE;
  
  
END behavioral;


