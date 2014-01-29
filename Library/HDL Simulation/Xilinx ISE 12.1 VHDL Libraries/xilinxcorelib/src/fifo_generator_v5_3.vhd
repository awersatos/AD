-------------------------------------------------------------------------------
--
-- FIFO Generator - VHDL Behavioral Model
--
-------------------------------------------------------------------------------
-- (c) Copyright 1995 - 2009 Xilinx, Inc. All rights reserved.
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
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
-- Filename: fifo_generator_v5_3.vhd
--
-- Author     : Xilinx
--
-------------------------------------------------------------------------------
-- Structure:
--
-- fifo_generator_v5_3.vhd
--    |
--    +-fifo_generator_v5_3_bhv_as
--    |
--    +-fifo_generator_v5_3_bhv_ss
--    |
--    +-fifo_generator_v5_3_bhv_preload0
--
-------------------------------------------------------------------------------
-- Description:
--
-- The VHDL behavioral model for the FIFO Generator.
--
--   The behavioral model has three parts:
--      - The behavioral model for independent clocks FIFOs (_as)
--      - The behavioral model for common clock FIFOs (_ss)
--      - The "preload logic" block which implements First-word Fall-through
--
-------------------------------------------------------------------------------


--#############################################################################
--#############################################################################
--  Independent Clocks FIFO Behavioral Model
--#############################################################################
--#############################################################################

-------------------------------------------------------------------------------
-- Library Declaration
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-------------------------------------------------------------------------------
-- Independent Clocks Entity Declaration - This is NOT the top-level entity
-------------------------------------------------------------------------------
ENTITY fifo_generator_v5_3_bhv_as IS

  GENERIC (
    ---------------------------------------------------------------------------
    -- Generic Declarations
    ---------------------------------------------------------------------------
    C_DIN_WIDTH                    : integer := 8;
    C_DOUT_RST_VAL                 : string  := "";
    C_DOUT_WIDTH                   : integer := 8;
    C_FULL_FLAGS_RST_VAL           : integer := 1;
    C_HAS_ALMOST_EMPTY             : integer := 0;
    C_HAS_ALMOST_FULL              : integer := 0;
    C_HAS_OVERFLOW                 : integer := 0;
    C_HAS_RD_DATA_COUNT            : integer := 2;
    C_HAS_RST                      : integer := 1;
    C_HAS_UNDERFLOW                : integer := 0;
    C_HAS_VALID                    : integer := 0;
    C_HAS_WR_ACK                   : integer := 0;
    C_HAS_WR_DATA_COUNT            : integer := 2;
    C_MEMORY_TYPE                  : integer := 1;
    C_OVERFLOW_LOW                 : integer := 0;
    C_PRELOAD_LATENCY              : integer := 1;
    C_PRELOAD_REGS                 : integer := 0;
    C_PROG_EMPTY_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_EMPTY_TYPE              : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL  : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL  : integer := 0;
    C_PROG_FULL_TYPE               : integer := 0;
    C_RD_DATA_COUNT_WIDTH          : integer := 0;
    C_RD_DEPTH                     : integer := 256;
    C_RD_PNTR_WIDTH                : integer := 8;
    C_UNDERFLOW_LOW                : integer := 0;
    C_USE_DOUT_RST                 : integer := 0;
    C_USE_ECC                      : integer := 0;
    C_USE_EMBEDDED_REG             : integer := 0;
    C_USE_FWFT_DATA_COUNT          : integer := 0;
    C_VALID_LOW                    : integer := 0;
    C_WR_ACK_LOW                   : integer := 0;
    C_WR_DATA_COUNT_WIDTH          : integer := 0;
    C_WR_DEPTH                     : integer := 256;
    C_WR_PNTR_WIDTH                : integer := 8;
    C_TCQ                          : time    := 100 ps;
    C_ENABLE_RST_SYNC              : integer := 1;
    C_ERROR_INJECTION_TYPE         : integer := 0
    );
  PORT(
    ---------------------------------------------------------------------------
    -- Input and Output Declarations
    ---------------------------------------------------------------------------
    RST                      : IN std_logic;
    WR_RST                   : IN std_logic;
    RD_RST                   : IN std_logic;
    DIN                      : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0);
    RD_CLK                   : IN std_logic;
    RD_EN                    : IN std_logic;
    RD_EN_USER               : IN std_logic;
    WR_CLK                   : IN std_logic;
    WR_EN                    : IN std_logic;
    PROG_EMPTY_THRESH        : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH_ASSERT : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH_NEGATE : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH         : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH_ASSERT  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH_NEGATE  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    INJECTDBITERR            : IN std_logic := '0';
    INJECTSBITERR            : IN std_logic := '0';
    USER_EMPTY_FB            : IN std_logic := '1';
    
    EMPTY                    : OUT std_logic := '1';
    FULL                     : OUT std_logic := '0'; 
    ALMOST_EMPTY             : OUT std_logic := '1';
    ALMOST_FULL              : OUT std_logic := '0'; 
    PROG_EMPTY               : OUT std_logic := '1';
    PROG_FULL                : OUT std_logic := '0'; 
    DOUT                     : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    VALID                    : OUT std_logic := '0';
    WR_ACK                   : OUT std_logic := '0';
    UNDERFLOW                : OUT std_logic := '0';
    OVERFLOW                 : OUT std_logic := '0';
    RD_DATA_COUNT            : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0)
                             := (OTHERS => '0');
    WR_DATA_COUNT            : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0)
                             := (OTHERS => '0');
    SBITERR                  : OUT std_logic := '0';
    DBITERR                  : OUT std_logic := '0'
    );



END fifo_generator_v5_3_bhv_as;



-------------------------------------------------------------------------------
-- Architecture Heading
-------------------------------------------------------------------------------
ARCHITECTURE behavioral OF fifo_generator_v5_3_bhv_as IS

  -----------------------------------------------------------------------------
  -- FUNCTION actual_fifo_depth
  -- Returns the actual depth of the FIFO (may differ from what the user 
  -- specified)
  --
  -- The FIFO depth is always represented as 2^n (16,32,64,128,256)
  -- However, the ACTUAL fifo depth may be 2^n+1 or 2^n-1 depending on certain
  -- options. This function returns the actual depth of the fifo, as seen by
  -- the user.
  -------------------------------------------------------------------------------
  FUNCTION actual_fifo_depth(
    C_FIFO_DEPTH : integer; 
    C_PRELOAD_REGS : integer; 
    C_PRELOAD_LATENCY : integer) 
  RETURN integer IS
  BEGIN
    RETURN C_FIFO_DEPTH - 1;
  END actual_fifo_depth;

  -----------------------------------------------------------------------------
  -- FUNCTION div_roundup
  -- Returns data_value / divisor, with the result rounded-up (if fractional)
  -------------------------------------------------------------------------------
  FUNCTION divroundup (
    data_value : integer;
    divisor : integer)
  RETURN integer IS
    VARIABLE div                   : integer;
  BEGIN
    div   := data_value/divisor;
    IF ( (data_value MOD divisor) /= 0) THEN
      div := div+1;
    END IF;
    RETURN div;
  END divroundup;

  -----------------------------------------------------------------------------
  -- FUNCTION int_2_std_logic
  -- Returns a single bit (as std_logic) from an integer 1/0 value.
  -------------------------------------------------------------------------------

  FUNCTION int_2_std_logic(value : integer) RETURN std_logic IS
  BEGIN
    IF (value=1) THEN
      RETURN '1';
    ELSE
      RETURN '0';
    END IF;
  END int_2_std_logic; 

  -----------------------------------------------------------------------------
  -- FUNCTION if_then_else
  -- Returns a true case or flase case based on the condition
  -------------------------------------------------------------------------------

    FUNCTION if_then_else (
      condition : boolean; 
      true_case : integer; 
      false_case : integer) 
    RETURN integer IS
      VARIABLE retval : integer := 0;
    BEGIN
      IF NOT condition THEN
        retval:=false_case;
      ELSE
        retval:=true_case;
      END IF;
      RETURN retval;
    END if_then_else;

  -----------------------------------------------------------------------------
  -- FUNCTION hexstr_to_std_logic_vec
  -- Returns a std_logic_vector for a hexadecimal string
  -------------------------------------------------------------------------------

    FUNCTION hexstr_to_std_logic_vec( 
      arg1 : string; 
      size : integer ) 
    RETURN std_logic_vector IS
      VARIABLE result : std_logic_vector(size-1 DOWNTO 0) := (OTHERS => '0');
      VARIABLE bin    : std_logic_vector(3 DOWNTO 0);
      VARIABLE index  : integer                           := 0;
    BEGIN
      FOR i IN arg1'reverse_range LOOP
        CASE arg1(i) IS
          WHEN '0' => bin := (OTHERS => '0');
          WHEN '1' => bin := (0 => '1', OTHERS => '0');
          WHEN '2' => bin := (1 => '1', OTHERS => '0');
          WHEN '3' => bin := (0 => '1', 1 => '1', OTHERS => '0');
          WHEN '4' => bin := (2 => '1', OTHERS => '0');
          WHEN '5' => bin := (0 => '1', 2 => '1', OTHERS => '0');
          WHEN '6' => bin := (1 => '1', 2 => '1', OTHERS => '0');
          WHEN '7' => bin := (3 => '0', OTHERS => '1');
          WHEN '8' => bin := (3 => '1', OTHERS => '0');
          WHEN '9' => bin := (0 => '1', 3 => '1', OTHERS => '0');
          WHEN 'A' => bin := (0 => '0', 2 => '0', OTHERS => '1');
          WHEN 'a' => bin := (0 => '0', 2 => '0', OTHERS => '1');
          WHEN 'B' => bin := (2 => '0', OTHERS => '1');
          WHEN 'b' => bin := (2 => '0', OTHERS => '1');
          WHEN 'C' => bin := (0 => '0', 1 => '0', OTHERS => '1');
          WHEN 'c' => bin := (0 => '0', 1 => '0', OTHERS => '1');
          WHEN 'D' => bin := (1 => '0', OTHERS => '1');
          WHEN 'd' => bin := (1 => '0', OTHERS => '1');
          WHEN 'E' => bin := (0 => '0', OTHERS => '1');
          WHEN 'e' => bin := (0 => '0', OTHERS => '1');
          WHEN 'F' => bin := (OTHERS => '1');
          WHEN 'f' => bin := (OTHERS => '1');
          WHEN OTHERS =>
            FOR j IN 0 TO 3 LOOP
              bin(j) := 'X';
            END LOOP;
        END CASE;
        FOR j IN 0 TO 3 LOOP
          IF (index*4)+j < size THEN
            result((index*4)+j) := bin(j);
          END IF;
        END LOOP;
        index := index + 1;
      END LOOP;
      RETURN result;
    END hexstr_to_std_logic_vec;

  -----------------------------------------------------------------------------
  -- FUNCTION get_lesser
  -- Returns a minimum value
  -------------------------------------------------------------------------------
  
  FUNCTION get_lesser(a: INTEGER; b: INTEGER) RETURN INTEGER IS
  BEGIN
    IF (a < b) THEN
      RETURN a;
    ELSE
      RETURN b;
    END IF;
  END FUNCTION;

  -----------------------------------------------------------------------------
  -- Derived Constants
  -----------------------------------------------------------------------------
  CONSTANT C_FIFO_WR_DEPTH      : integer 
    := actual_fifo_depth(C_WR_DEPTH, C_PRELOAD_REGS, C_PRELOAD_LATENCY);
  CONSTANT C_FIFO_RD_DEPTH      : integer 
    := actual_fifo_depth(C_RD_DEPTH, C_PRELOAD_REGS, C_PRELOAD_LATENCY);
  CONSTANT C_SMALLER_DATA_WIDTH : integer 
    := get_lesser(C_DIN_WIDTH, C_DOUT_WIDTH);
  CONSTANT C_DEPTH_RATIO_WR     : integer 
    := if_then_else( (C_WR_DEPTH > C_RD_DEPTH), (C_WR_DEPTH/C_RD_DEPTH), 1);
  CONSTANT C_DEPTH_RATIO_RD     : integer 
    := if_then_else( (C_RD_DEPTH > C_WR_DEPTH), (C_RD_DEPTH/C_WR_DEPTH), 1);

  -- "Extra Words" is the number of write words which fit into the two
  -- first-word fall-through output register stages (if using FWFT).
  -- For ratios of 1:4 and 1:8, the fractional result is rounded up to 1.
  -- This value is used to calculate the adjusted PROG_FULL threshold
  -- value for FWFT.
  -- EXTRA_WORDS = 2 * C_DEPTH_RATIO_WR / C_DEPTH_RATIO_RD
  -- WR_DEPTH : RD_DEPTH = 1:2 => EXTRA_WORDS = 1
  -- WR_DEPTH : RD_DEPTH = 1:4 => EXTRA_WORDS = 1 (rounded to ceiling)
  -- WR_DEPTH : RD_DEPTH = 2:1 => EXTRA_WORDS = 4
  -- WR_DEPTH : RD_DEPTH = 4:1 => EXTRA_WORDS = 8
  CONSTANT EXTRA_WORDS          : integer := divroundup(2 * C_DEPTH_RATIO_WR, C_DEPTH_RATIO_RD);
--  CONSTANT EXTRA_WORDS      : std_logic_vector (C_PNTR_WIDTH DOWNTO 0)
--                           := conv_std_logic_vector(
--                              if_then_else ((C_DEPTH_RATIO_WR=1),2
--                              ,(2 * C_DEPTH_RATIO_WR/C_DEPTH_RATIO_RD))
--                              ,C_PNTR_WIDTH+1);

  -- "Extra words dc" is used for calculating the adjusted WR_DATA_COUNT
  -- value for the core when using FWFT.
  -- extra_words_dc = 2 * C_DEPTH_RATIO_WR / C_DEPTH_RATIO_RD
  --  C_DEPTH_RATIO_WR | C_DEPTH_RATIO_RD | C_PNTR_WIDTH    | EXTRA_WORDS_DC
  --  -----------------|------------------|-----------------|---------------
  --  1                | 8                | C_RD_PNTR_WIDTH | 2
  --  1                | 4                | C_RD_PNTR_WIDTH | 2
  --  1                | 2                | C_RD_PNTR_WIDTH | 2
  --  1                | 1                | C_WR_PNTR_WIDTH | 2
  --  2                | 1                | C_WR_PNTR_WIDTH | 4
  --  4                | 1                | C_WR_PNTR_WIDTH | 8
  --  8                | 1                | C_WR_PNTR_WIDTH | 16
--  SIGNAL EXTRA_WORDS_DC    : integer
--                           := if_then_else ((C_DEPTH_RATIO_RD > 2),0,
--                              (2 * C_DEPTH_RATIO_WR/C_DEPTH_RATIO_RD));
  SIGNAL EXTRA_WORDS_DC    : integer
                           := if_then_else ((C_DEPTH_RATIO_WR = 1),2,
                              (2 * C_DEPTH_RATIO_WR/C_DEPTH_RATIO_RD));

  CONSTANT C_PE_THR_ASSERT_ADJUSTED  : integer
    :=if_then_else((C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0),
                    C_PROG_EMPTY_THRESH_ASSERT_VAL - 2, --FWFT
                    C_PROG_EMPTY_THRESH_ASSERT_VAL );   --NO FWFT
  CONSTANT C_PE_THR_NEGATE_ADJUSTED  : integer
    :=if_then_else((C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0),
                    C_PROG_EMPTY_THRESH_NEGATE_VAL - 2, --FWFT
                    C_PROG_EMPTY_THRESH_NEGATE_VAL);    --NO FWFT
  
  CONSTANT C_PE_THR_ASSERT_VAL_I : integer := C_PE_THR_ASSERT_ADJUSTED;
  CONSTANT C_PE_THR_NEGATE_VAL_I : integer := C_PE_THR_NEGATE_ADJUSTED;

  -- NO_ERR_INJECTION will be 1 if ECC is OFF or ECC is ON but no error
  -- injection is selected.
  CONSTANT NO_ERR_INJECTION      : integer 
           := if_then_else(C_USE_ECC = 0,1,
              if_then_else(C_ERROR_INJECTION_TYPE = 0,1,0));

  -- SBIT_ERR_INJECTION will be 1 if ECC is ON and single bit error injection
  -- is selected.
  CONSTANT SBIT_ERR_INJECTION    : integer 
           := if_then_else((C_USE_ECC = 1 AND C_ERROR_INJECTION_TYPE = 1),1,0);

  -- DBIT_ERR_INJECTION will be 1 if ECC is ON and double bit error injection
  -- is selected.
  CONSTANT DBIT_ERR_INJECTION    : integer 
           := if_then_else((C_USE_ECC = 1 AND C_ERROR_INJECTION_TYPE = 2),1,0);

  -- BOTH_ERR_INJECTION will be 1 if ECC is ON and both single and double bit
  -- error injection are selected.
  CONSTANT BOTH_ERR_INJECTION    : integer 
           := if_then_else((C_USE_ECC = 1 AND C_ERROR_INJECTION_TYPE = 3),1,0);

  -------------------------------------------------------------------------------
  -- Signals Declaration
  -------------------------------------------------------------------------------
  SIGNAL wr_point       : integer   := 0;
  SIGNAL rd_point       : integer   := 0;
  SIGNAL wr_point_d1    : integer   := 0;
  SIGNAL rd_point_d1    : integer   := 0;
  SIGNAL num_wr_words   : integer   := 0;
  SIGNAL num_rd_words   : integer   := 0;
  SIGNAL adj_wr_point   : integer   := 0;
  SIGNAL adj_rd_point   : integer   := 0;
  SIGNAL adj_wr_point_d1: integer   := 0;
  SIGNAL adj_rd_point_d1: integer   := 0;

  SIGNAL rd_rst_asreg    : std_logic:= '0';
  SIGNAL rd_rst_asreg_d1 : std_logic:= '0';
  SIGNAL rd_rst_asreg_d2 : std_logic:= '0';
  SIGNAL rd_rst_comb     : std_logic:= '0';
  SIGNAL rd_rst_reg      : std_logic:= '0';
  SIGNAL rd_rst_i        : std_logic:= '0';
  SIGNAL wr_rst_asreg    : std_logic:= '0';
  SIGNAL wr_rst_asreg_d1 : std_logic:= '0';
  SIGNAL wr_rst_asreg_d2 : std_logic:= '0';
  SIGNAL wr_rst_comb     : std_logic:= '0';
  SIGNAL wr_rst_reg      : std_logic:= '0';
  SIGNAL wr_rst_i        : std_logic:= '0';
  SIGNAL wr_rst_d1       : std_logic:= '0';

  SIGNAL wr_ack_i        : std_logic := '0';
  SIGNAL overflow_i      : std_logic := '0';
  SIGNAL valid_i         : std_logic := '0';
  SIGNAL valid_d1        : std_logic := '0';
  SIGNAL valid_out       : std_logic := '0';
  SIGNAL underflow_i     : std_logic := '0';


  SIGNAL prog_full_reg     : std_logic := '0';
  SIGNAL prog_empty_reg    : std_logic := '1';
  SIGNAL dout_i            : std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0) 
                           := (OTHERS => '0');
  SIGNAL width_gt1         : std_logic := '0'; 
  SIGNAL sbiterr_i         : std_logic := '0'; 
  SIGNAL dbiterr_i         : std_logic := '0'; 

  SIGNAL wr_pntr            : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL wr_pntr_rd1        : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL wr_pntr_rd2        : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL wr_pntr_rd3        : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL wr_pntr_rd         : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL adj_wr_pntr_rd     : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) 
                            := (OTHERS=>'0');
  SIGNAL wr_data_count_int  : std_logic_vector(C_WR_PNTR_WIDTH DOWNTO 0) 
                            := (OTHERS=>'0');
  SIGNAL wdc_fwft_ext_as    : std_logic_vector(C_WR_PNTR_WIDTH DOWNTO 0) 
                            := (OTHERS=>'0');
  SIGNAL rdc_fwft_ext_as    : std_logic_vector (C_RD_PNTR_WIDTH DOWNTO 0)
                            := (OTHERS => '0');
  SIGNAL rd_pntr            : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL rd_pntr_wr_d1      : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL rd_pntr_wr_d2      : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL rd_pntr_wr_d3      : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL rd_pntr_wr_d4      : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)
                            := (OTHERS=>'0');
  SIGNAL rd_pntr_wr         : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) 
                            := (OTHERS=>'0');
  SIGNAL adj_rd_pntr_wr     : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) 
                            := (OTHERS=>'0');
  SIGNAL rd_data_count_int  : std_logic_vector(C_RD_PNTR_WIDTH DOWNTO 0) 
                            := (OTHERS=>'0');
  SIGNAL empty_int          : boolean   := TRUE;
  SIGNAL empty_comb         : std_logic := '1';
  SIGNAL ram_rd_en          : std_logic := '0';
  SIGNAL ram_rd_en_d1       : std_logic := '0';
  SIGNAL empty_comb_d1      : std_logic := '1';
  SIGNAL almost_empty_int   : boolean   := TRUE;
  SIGNAL full_int           : boolean   := FALSE;
  SIGNAL full_comb          : std_logic := '0';
  SIGNAL ram_wr_en          : std_logic := '0';
  SIGNAL almost_full_int    : boolean   := FALSE;
  SIGNAL rd_fwft_cnt        : std_logic_vector(3 downto 0)   := (others=>'0');
  SIGNAL stage1_valid       : std_logic := '0';
  SIGNAL stage2_valid       : std_logic := '0';

  SIGNAL diff_pntr_wr       : integer := 0;
  SIGNAL diff_pntr_rd       : integer := 0;

  -------------------------------------------------------------------------------
  --Linked List types
  -------------------------------------------------------------------------------
  TYPE listtyp;
  TYPE listptr IS ACCESS listtyp;
  TYPE listtyp IS RECORD
      data  : std_logic_vector(C_SMALLER_DATA_WIDTH + 1 DOWNTO 0);
      older : listptr;
      newer : listptr;
    END RECORD;

  -------------------------------------------------------------------------------
  --Processes for linked list implementation. The functions are
  --1. "newlist" - Create a new linked list
  --2. "add"     - Add a data element to a linked list
  --3. "read"    - Read the data from the tail of the linked list
  --4. "remove"  - Remove the tail from the linked list
  --5. "sizeof"  - Calculate the size of the linked list
  -------------------------------------------------------------------------------
  --1. Create a new linked list
  PROCEDURE newlist (
    head   : INOUT listptr; 
    tail   : INOUT listptr;
    cntr   : INOUT integer) IS
  BEGIN
    head   := NULL;
    tail   := NULL;
    cntr   := 0;
  END;  

  --2. Add a data element to a linked list
  PROCEDURE add (
    head    : INOUT listptr; 
    tail    : INOUT listptr; 
    data    : IN std_logic_vector;
    cntr    : INOUT integer;
    inj_err : IN std_logic_vector(2 DOWNTO 0)
    ) IS
    VARIABLE oldhead        : listptr;
    VARIABLE newhead        : listptr;
    VARIABLE corrupted_data : std_logic_vector(1 DOWNTO 0);
  BEGIN
    --------------------------------------------------------------------------
    --a. Create a pointer to the existing head, if applicable
    --b. Create a new node for the list
    --c. Make the new node point to the old head
    --d. Make the old head point back to the new node (for doubly-linked list)
    --e. Put the data into the new head node
    --f. If the new head we just created is the only node in the list, 
    --   make the tail point to it
    --g. Return the new head pointer
    --------------------------------------------------------------------------
    IF (head /= NULL) THEN
      oldhead       := head;
    END IF;
    newhead         := NEW listtyp;
    newhead.older   := oldhead;
    IF (head /= NULL) THEN
      oldhead.newer := newhead;
    END IF;

    CASE (inj_err(1 DOWNTO 0)) IS
      -- For both error injection, pass only the double bit error injection
      -- as dbit error has priority over single bit error injection
      WHEN "11"   => newhead.data := inj_err(1) & '0' & data;
      WHEN "10"   => newhead.data := inj_err(1) & '0' & data;
      WHEN "01"   => newhead.data := '0' & inj_err(0) & data;
      WHEN OTHERS => newhead.data := '0' & '0' & data;
    END CASE;

    -- Increment the counter when data is added to the list
    cntr := cntr + 1;
    IF (newhead.older = NULL) THEN
      tail          := newhead;
    END IF;
    head            := newhead;
  END;  

  --3. Read the data from the tail of the linked list
  PROCEDURE read (
    tail : INOUT listptr; 
    data : OUT std_logic_vector;
    err_type : OUT std_logic_vector(1 DOWNTO 0)
    ) IS
  VARIABLE data_int     : std_logic_vector(C_SMALLER_DATA_WIDTH + 1 DOWNTO 0) := (OTHERS => '0');
  VARIABLE err_type_int : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    data_int := tail.data;
    -- MSB two bits carry the error injection type.
    err_type_int := data_int(data_int'high DOWNTO C_SMALLER_DATA_WIDTH);
    IF (err_type_int(1) = '0') THEN
      data     := data_int(C_SMALLER_DATA_WIDTH - 1 DOWNTO 0);
    ELSIF (C_DOUT_WIDTH = 2) THEN
        data     := NOT data_int(C_SMALLER_DATA_WIDTH - 1 DOWNTO 0);
    ELSIF (C_DOUT_WIDTH > 2) THEN
        data     := NOT data_int(data_int'high-2) & NOT data_int(data_int'high-3) &
                    data_int(data_int'high-4 DOWNTO 0);
    ELSE
      data     := data_int(C_SMALLER_DATA_WIDTH - 1 DOWNTO 0);
    END IF;

    err_type := err_type_int;

  END;  

  --4. Remove the tail from the linked list
  PROCEDURE remove (
    head : INOUT listptr; 
    tail : INOUT listptr;
    cntr : INOUT integer) IS
    VARIABLE oldtail     :       listptr;
    VARIABLE newtail     :       listptr;
  BEGIN
    --------------------------------------------------------------------------
    --Make a copy of the old tail pointer
    --a. If there is no newer node, then set the tail pointer to nothing 
    --   (list is empty)
    --   otherwise, make the next newer node the new tail, and make it point 
    --   to nothing older
    --b. Clean up the memory for the old tail node
    --c. If the new tail is nothing, then we have an empty list, and head 
    --   should also be set to nothing
    --d. Return the new tail
    --------------------------------------------------------------------------
    oldtail         := tail;
    IF (oldtail.newer = NULL) THEN
      newtail       := NULL;
    ELSE
      newtail       := oldtail.newer;
      newtail.older := NULL;
    END IF;
    DEALLOCATE(oldtail);
    IF (newtail = NULL) THEN
      head          := NULL;
    END IF;
    tail            := newtail;
    -- Decrement the counter when data is removed from the list
    cntr := cntr - 1;
  END; 


  --5. Calculate the size of the linked list
  PROCEDURE sizeof (head : INOUT listptr; size : OUT integer) IS
    VARIABLE curlink     :       listptr;
    VARIABLE tmpsize     :       integer := 0;
  BEGIN
    --------------------------------------------------------------------------
    --a. If head is null, then there is nothing in the list to traverse
    --   start with the head node (which implies at least one node exists)
    --   Loop through each node until you find the one that points to nothing 
    --   (the tail)
    --b. Return the number of nodes
    --------------------------------------------------------------------------
    IF (head /= NULL) THEN
      curlink                            := head;
      tmpsize                            := 1;
      WHILE (curlink.older /= NULL) LOOP
        tmpsize                          := tmpsize + 1;
        curlink                          := curlink.older;
      END LOOP;
    END IF;
    size                                 := tmpsize;
  END;  


  -----------------------------------------------------------------------------
  -- converts integer to specified length std_logic_vector : dropping least
  -- significant bits if integer is bigger than what can be represented by
  -- the vector
  -----------------------------------------------------------------------------
  FUNCTION count( 
    fifo_count    : IN integer;
    pointer_width : IN integer;
    counter_width : IN integer)
  RETURN std_logic_vector IS
    VARIABLE temp   :    std_logic_vector(pointer_width-1 DOWNTO 0)   
                    := (OTHERS => '0');
    VARIABLE output :    std_logic_vector(counter_width - 1 DOWNTO 0) 
                    := (OTHERS => '0');
  BEGIN
    temp     := CONV_STD_LOGIC_VECTOR(fifo_count, pointer_width);
    IF (counter_width <= pointer_width) THEN
      output := temp(pointer_width - 1 DOWNTO pointer_width - counter_width);
    ELSE
      output := temp(counter_width - 1 DOWNTO 0);
    END IF;
    RETURN output;
  END count;

-------------------------------------------------------------------------------
-- architecture begins here
-------------------------------------------------------------------------------
BEGIN

  wr_pntr       <= conv_std_logic_vector(wr_point,C_WR_PNTR_WIDTH);
  rd_pntr       <= conv_std_logic_vector(rd_point,C_RD_PNTR_WIDTH);

  -------------------------------------------------------------------------------
  -- If there is a reset input, generate internal reset signals
  -- The latency of reset will match the core behavior
  -------------------------------------------------------------------------------
  --Single RST
  grst_sync : IF (C_ENABLE_RST_SYNC = 1) GENERATE
    grst : IF (C_HAS_RST=1) GENERATE
      PROCESS (WR_CLK, RST)
      BEGIN
        IF (RST = '1') THEN
          wr_rst_asreg <=   '1' after C_TCQ;
        ELSIF (WR_CLK'event and WR_CLK = '1') THEN
          IF (wr_rst_asreg_d1 = '1') THEN
            wr_rst_asreg <= '0' after C_TCQ;
          ELSE
            wr_rst_asreg <= wr_rst_asreg after C_TCQ;
          END IF;
        END IF;
    
        IF (WR_CLK'event and WR_CLK = '1') THEN
          wr_rst_asreg_d1 <= wr_rst_asreg after C_TCQ;
          wr_rst_asreg_d2 <= wr_rst_asreg_d1 after C_TCQ;
        END IF;
      END PROCESS;
      
      PROCESS (wr_rst_asreg, wr_rst_asreg_d2)
      BEGIN
        wr_rst_comb <= NOT wr_rst_asreg_d2 AND wr_rst_asreg;
      END PROCESS;
    
      PROCESS (WR_CLK, wr_rst_comb)
      BEGIN
        IF (wr_rst_comb = '1') THEN
          wr_rst_reg <= '1' after C_TCQ;
        ELSIF (WR_CLK'event and WR_CLK = '1') THEN
          wr_rst_reg <= '0' after C_TCQ;
        END IF;
      END PROCESS;
      
      PROCESS (RD_CLK, RST)
      BEGIN
        IF (RST = '1') THEN
          rd_rst_asreg <=   '1' after C_TCQ;
        ELSIF (RD_CLK'event and RD_CLK = '1') THEN
          IF (rd_rst_asreg_d1 = '1') THEN
            rd_rst_asreg <= '0' after C_TCQ;
          ELSE
            rd_rst_asreg <= rd_rst_asreg after C_TCQ;
          END IF;
        END IF;
    
        IF (RD_CLK'event and RD_CLK = '1') THEN
          rd_rst_asreg_d1 <= rd_rst_asreg after C_TCQ;
          rd_rst_asreg_d2 <= rd_rst_asreg_d1 after C_TCQ;
        END IF;
      END PROCESS;
      
      PROCESS (rd_rst_asreg, rd_rst_asreg_d2)
      BEGIN
        rd_rst_comb <= NOT rd_rst_asreg_d2 AND rd_rst_asreg;
      END PROCESS;
    
      PROCESS (RD_CLK, rd_rst_comb)
      BEGIN
        IF (rd_rst_comb = '1') THEN
          rd_rst_reg <= '1' after C_TCQ;
        ELSIF (RD_CLK'event and RD_CLK = '1') THEN
          rd_rst_reg <= '0' after C_TCQ;
        END IF;
      END PROCESS;
    
    
      wr_rst_i <= wr_rst_reg;
      rd_rst_i <= rd_rst_reg;
    
    END GENERATE grst;
  END GENERATE grst_sync;
      
  PROCESS (WR_CLK, wr_rst_i)
  BEGIN
    IF (wr_rst_i='1') THEN
      wr_rst_d1 <= '1' after C_TCQ;
    ELSIF (WR_CLK'event AND WR_CLK = '1') THEN
      wr_rst_d1 <= wr_rst_i after C_TCQ;
    END IF;
  END PROCESS;

  gnrst_sync : IF (C_ENABLE_RST_SYNC = 0) GENERATE
      wr_rst_i <= WR_RST;
      rd_rst_i <= RD_RST;
  END GENERATE gnrst_sync;
  
  
  -------------------------------------------------------------------------------
  -- No reset ports. Tie internal resets to zero.
  -------------------------------------------------------------------------------
  norst  : IF (C_HAS_RST = 0 AND C_ENABLE_RST_SYNC = 1) GENERATE
    rd_rst_i <= '0';
    wr_rst_i <= '0';
    wr_rst_d1<= '0';
  END GENERATE norst;
  
  -------------------------------------------------------------------------------
  -- calculate number of words in wr and rd domain according to the deepest port
  --
  -- These steps circumvent the linked-list data structure and keep track of
  -- wr_point and rd_point pointers much like the core itself does. The behavioral
  -- model uses these to calculate WR_DATA_COUNT and RD_DATA_COUNT. This was done
  -- because the sizeof() function always returns the exact number of words in
  -- the linked list, and can not account for delays when crossing clock domains.
  -------------------------------------------------------------------------------
  adj_wr_point   <= wr_point * C_DEPTH_RATIO_RD;
  adj_rd_point   <= rd_point * C_DEPTH_RATIO_WR;
  adj_wr_point_d1<= wr_point_d1 * C_DEPTH_RATIO_RD;
  adj_rd_point_d1<= rd_point_d1 * C_DEPTH_RATIO_WR;

  width_gt1 <= '1' WHEN (C_DIN_WIDTH = 2) ELSE '0'; 
 
  PROCESS (adj_wr_point, adj_wr_point_d1, adj_rd_point, adj_rd_point_d1)
  BEGIN
    IF (adj_wr_point >= adj_rd_point_d1) THEN
      num_wr_words <= adj_wr_point - adj_rd_point_d1;
    ELSE
      num_wr_words <= C_WR_DEPTH*C_DEPTH_RATIO_RD + adj_wr_point - adj_rd_point_d1;
    END IF;
    IF (adj_wr_point_d1 >= adj_rd_point) THEN
      num_rd_words <= adj_wr_point_d1 - adj_rd_point;
    ELSE
      num_rd_words <= C_RD_DEPTH*C_DEPTH_RATIO_WR + adj_wr_point_d1 - adj_rd_point;
    END IF;
  END PROCESS;
  
  -------------------------------------------------------------------------------
  --Calculate WR_ACK based on C_WR_ACK_LOW parameters
  -------------------------------------------------------------------------------
  gwalow : IF (C_WR_ACK_LOW = 0) GENERATE
    WR_ACK <= wr_ack_i;
  END GENERATE gwalow;
  
  gwahgh : IF (C_WR_ACK_LOW = 1) GENERATE
    WR_ACK <= NOT wr_ack_i;
  END GENERATE gwahgh;
  
  -------------------------------------------------------------------------------
  --Calculate OVERFLOW based on C_OVERFLOW_LOW parameters
  -------------------------------------------------------------------------------
  govlow : IF (C_OVERFLOW_LOW = 0) GENERATE
    OVERFLOW <= overflow_i;
  END GENERATE govlow;
  
  govhgh : IF (C_OVERFLOW_LOW = 1) GENERATE
    OVERFLOW <= NOT overflow_i;
  END GENERATE govhgh;
  
  -------------------------------------------------------------------------------
  --Calculate VALID based on C_VALID_LOW
  -------------------------------------------------------------------------------

  gnvl : IF (C_VALID_LOW = 0) GENERATE
    VALID <= valid_out;
  END GENERATE gnvl;
  
  gnvh : IF (C_VALID_LOW = 1) GENERATE
    VALID <= NOT valid_out;
  END GENERATE gnvh;
  
  -------------------------------------------------------------------------------
  --Calculate UNDERFLOW based on C_UNDERFLOW_LOW
  -------------------------------------------------------------------------------
  gnul  : IF (C_UNDERFLOW_LOW = 0) GENERATE
    UNDERFLOW <= underflow_i;
  END GENERATE gnul;
  
  gnuh  : IF (C_UNDERFLOW_LOW = 1) GENERATE
    UNDERFLOW <= NOT underflow_i;
  END GENERATE gnuh;
  
  -------------------------------------------------------------------------------
  --Assign PROG_FULL and PROG_EMPTY
  -------------------------------------------------------------------------------
  PROG_FULL <= prog_full_reg;
  PROG_EMPTY <= prog_empty_reg;
  
  -------------------------------------------------------------------------------
  --Assign RD_DATA_COUNT and WR_DATA_COUNT
  -------------------------------------------------------------------------------
  rdc: IF (C_HAS_RD_DATA_COUNT=1) GENERATE
    grdc_fwft_ext: IF (C_USE_FWFT_DATA_COUNT = 1) GENERATE
      RD_DATA_COUNT <= rdc_fwft_ext_as(C_RD_PNTR_WIDTH DOWNTO C_RD_PNTR_WIDTH+1-C_RD_DATA_COUNT_WIDTH);
    END GENERATE grdc_fwft_ext;
  
    gnrdc_fwft_ext: IF (C_USE_FWFT_DATA_COUNT = 0) GENERATE
      RD_DATA_COUNT <= rd_data_count_int(C_RD_PNTR_WIDTH DOWNTO C_RD_PNTR_WIDTH+1-C_RD_DATA_COUNT_WIDTH);
    END GENERATE gnrdc_fwft_ext;
  END GENERATE rdc;

  nrdc: IF (C_HAS_RD_DATA_COUNT=0) GENERATE
    RD_DATA_COUNT <= (OTHERS=>'0');
  END GENERATE nrdc;
  
  wdc: IF (C_HAS_WR_DATA_COUNT = 1) GENERATE
    gwdc_fwft_ext: IF (C_USE_FWFT_DATA_COUNT = 1) GENERATE
      WR_DATA_COUNT <= wdc_fwft_ext_as(C_WR_PNTR_WIDTH DOWNTO C_WR_PNTR_WIDTH+1-C_WR_DATA_COUNT_WIDTH);
    END GENERATE gwdc_fwft_ext;
  
    gnwdc_fwft_ext: IF (C_USE_FWFT_DATA_COUNT = 0) GENERATE
      WR_DATA_COUNT <= wr_data_count_int(C_WR_PNTR_WIDTH DOWNTO C_WR_PNTR_WIDTH+1-C_WR_DATA_COUNT_WIDTH);
    END GENERATE gnwdc_fwft_ext;
  END GENERATE wdc;
  nwdc: IF (C_HAS_WR_DATA_COUNT=0) GENERATE
    WR_DATA_COUNT <= (OTHERS=>'0');
  END GENERATE nwdc;


  -------------------------------------------------------------------------------
  -- Write data count calculation if Use Extra Logic option is used 
  -------------------------------------------------------------------------------
  wdc_fwft_ext: IF (C_HAS_WR_DATA_COUNT = 1 AND C_USE_FWFT_DATA_COUNT = 1) GENERATE 

    CONSTANT C_PNTR_WIDTH    : integer           
                             := if_then_else ((C_WR_PNTR_WIDTH>=C_RD_PNTR_WIDTH),
                                C_WR_PNTR_WIDTH, C_RD_PNTR_WIDTH);
    SIGNAL adjusted_wr_pntr  : std_logic_vector (C_PNTR_WIDTH-1 DOWNTO 0)
                             := (OTHERS => '0');
    SIGNAL adjusted_rd_pntr  : std_logic_vector (C_PNTR_WIDTH-1 DOWNTO 0)
                             := (OTHERS => '0');
    CONSTANT EXTRA_WORDS     : std_logic_vector (C_PNTR_WIDTH DOWNTO 0)
                             := conv_std_logic_vector(
                                if_then_else ((C_DEPTH_RATIO_WR=1),2
                                ,(2 * C_DEPTH_RATIO_WR/C_DEPTH_RATIO_RD))
                                ,C_PNTR_WIDTH+1);
    SIGNAL diff_wr_rd_tmp    : std_logic_vector (C_PNTR_WIDTH-1 DOWNTO 0)
                             := (OTHERS => '0');
    SIGNAL diff_wr_rd        : std_logic_vector (C_PNTR_WIDTH DOWNTO 0)
                             := (OTHERS => '0');
    SIGNAL wr_data_count_i   : std_logic_vector (C_PNTR_WIDTH DOWNTO 0)
                             := (OTHERS => '0');

  BEGIN
    -----------------------------------------------------------------------------
    --Adjust write and read pointer to the deepest port width
    -----------------------------------------------------------------------------
    --C_PNTR_WIDTH=C_WR_PNTR_WIDTH
    gpadr: IF (C_WR_PNTR_WIDTH > C_RD_PNTR_WIDTH) GENERATE
      adjusted_wr_pntr <= wr_pntr;
      adjusted_rd_pntr(C_PNTR_WIDTH-1 DOWNTO C_PNTR_WIDTH-C_RD_PNTR_WIDTH) 
        <= rd_pntr_wr;
      adjusted_rd_pntr(C_PNTR_WIDTH-C_RD_PNTR_WIDTH-1 DOWNTO 0)<=(OTHERS=>'0');
    END GENERATE gpadr;
  
    --C_PNTR_WIDTH=C_RD_PNTR_WIDTH
    gpadw: IF (C_WR_PNTR_WIDTH < C_RD_PNTR_WIDTH) GENERATE
      adjusted_wr_pntr(C_PNTR_WIDTH-1 DOWNTO C_PNTR_WIDTH-C_WR_PNTR_WIDTH) 
        <= wr_pntr;
      adjusted_wr_pntr(C_PNTR_WIDTH-C_WR_PNTR_WIDTH-1 DOWNTO 0)<=(OTHERS=>'0');
      adjusted_rd_pntr <= rd_pntr_wr;
    END GENERATE gpadw;
  
    --C_PNTR_WIDTH=C_WR_PNTR_WIDTH=C_RD_PNTR_WIDTH
    ngpad: IF (C_WR_PNTR_WIDTH = C_RD_PNTR_WIDTH) GENERATE
      adjusted_wr_pntr <= wr_pntr;
      adjusted_rd_pntr <= rd_pntr_wr;
    END GENERATE ngpad;
  
    -----------------------------------------------------------------------------
    --Calculate words in write domain
    -----------------------------------------------------------------------------
    --Subtract the pointers to get the number of words in the RAM, *THEN* pad
    --the result
    diff_wr_rd_tmp <= adjusted_wr_pntr - adjusted_rd_pntr;
  
    diff_wr_rd <= '0' & diff_wr_rd_tmp;
  
    pwdc : PROCESS   (WR_CLK, wr_rst_i)
    BEGIN
      IF (wr_rst_i = '1') THEN
        wr_data_count_i <= (OTHERS=>'0');
      ELSIF (WR_CLK'event AND WR_CLK = '1') THEN
        wr_data_count_i <= diff_wr_rd + extra_words;
      END IF;
    END PROCESS pwdc;
  
    gdc0: IF (C_WR_PNTR_WIDTH >= C_RD_PNTR_WIDTH) GENERATE
      wdc_fwft_ext_as
        <= wr_data_count_i(C_PNTR_WIDTH DOWNTO 0);
    END GENERATE gdc0;
  
    gdc1: IF (C_WR_PNTR_WIDTH < C_RD_PNTR_WIDTH) GENERATE
      wdc_fwft_ext_as
        <= wr_data_count_i(C_PNTR_WIDTH DOWNTO C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH);
    END GENERATE gdc1;
  
  END GENERATE wdc_fwft_ext;
 
 
  -------------------------------------------------------------------------------
  -- Read data count calculation if Use Extra Logic option is used 
  -------------------------------------------------------------------------------
  rdc_fwft_ext: IF (C_HAS_RD_DATA_COUNT = 1 AND C_USE_FWFT_DATA_COUNT = 1) GENERATE 

    SIGNAL diff_wr_rd_tmp      : std_logic_vector (C_RD_PNTR_WIDTH-1 DOWNTO 0)
      := (OTHERS => '0');
    SIGNAL diff_wr_rd          : std_logic_vector (C_RD_PNTR_WIDTH DOWNTO 0)
      := (OTHERS => '0');
    SIGNAL zero                : std_logic_vector (C_RD_PNTR_WIDTH DOWNTO 0)
      := (OTHERS => '0');
    SIGNAL one                 : std_logic_vector (C_RD_PNTR_WIDTH DOWNTO 0)
      := conv_std_logic_vector(1, C_RD_PNTR_WIDTH+1);
    SIGNAL two                 : std_logic_vector (C_RD_PNTR_WIDTH DOWNTO 0)
      := conv_std_logic_vector(2, C_RD_PNTR_WIDTH+1);
    SIGNAL adjusted_wr_pntr_r : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) 
      := (OTHERS=>'0');

  BEGIN

    ----------------------------------------------------------------------------
    -- If write depth is smaller than read depth, pad write pointer.
    -- If write depth is bigger than read depth, trim write pointer.
    ----------------------------------------------------------------------------
    gpad : IF (C_RD_PNTR_WIDTH>C_WR_PNTR_WIDTH) GENERATE
      adjusted_wr_pntr_r(C_RD_PNTR_WIDTH-1 DOWNTO C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH)
        <= WR_PNTR_RD;
      adjusted_wr_pntr_r(C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH-1 DOWNTO 0) 
        <= (OTHERS => '0');
    END GENERATE gpad;
  
    gtrim : IF (C_RD_PNTR_WIDTH<=C_WR_PNTR_WIDTH)	GENERATE
      adjusted_wr_pntr_r 
        <= WR_PNTR_RD(C_WR_PNTR_WIDTH-1 DOWNTO C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH);
    END GENERATE gtrim;
  
    -----------------------------------------------------------------------------
    -- This accounts for preload 0 by explicitly handling the preload states
    -- which do not have both output stages filled. As a result, the rd_data_count
    -- produced will always accurately reflect the number of READABLE words at
    -- a given time.
    -----------------------------------------------------------------------------
  
    diff_wr_rd_tmp <= adjusted_wr_pntr_r - RD_PNTR;
    diff_wr_rd <= '0' & diff_wr_rd_tmp;
  
    prdc : PROCESS (RD_CLK, rd_rst_i)
    BEGIN
      IF (rd_rst_i = '1') THEN
        rdc_fwft_ext_as <= zero;
      ELSIF (RD_CLK'event AND RD_CLK = '1') THEN
--        IF (rd_fwft_cnt = X"0") THEN
        IF (stage2_valid = '0') THEN
          rdc_fwft_ext_as <= zero;
--        ELSIF (rd_fwft_cnt = X"1") THEN 
        ELSIF (stage2_valid = '1' AND stage1_valid = '0') THEN 
          rdc_fwft_ext_as <= one;
        ELSE
          rdc_fwft_ext_as <= diff_wr_rd + two;
        END IF;
      END IF;
    END PROCESS prdc;
  
  END GENERATE rdc_fwft_ext;
  
  -------------------------------------------------------------------------------
  -- Write pointer adjustment based on pointers width for EMPTY/ALMOST_EMPTY generation
  -------------------------------------------------------------------------------
  gpad : IF (C_RD_PNTR_WIDTH > C_WR_PNTR_WIDTH) GENERATE
    adj_wr_pntr_rd(C_RD_PNTR_WIDTH-1 DOWNTO C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH)
      <= wr_pntr_rd;
    adj_wr_pntr_rd(C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH-1 DOWNTO 0) 
      <= (OTHERS => '0');
  END GENERATE gpad;

  gtrim : IF (C_RD_PNTR_WIDTH<=C_WR_PNTR_WIDTH)	GENERATE
    adj_wr_pntr_rd 
      <= wr_pntr_rd(C_WR_PNTR_WIDTH-1 DOWNTO C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH);
  END GENERATE gtrim;
  
  -------------------------------------------------------------------------------
  -- Generate Empty
  -------------------------------------------------------------------------------
  -- ram_rd_en used to determine EMPTY should depend on the EMPTY.
  ram_rd_en <= RD_EN AND (NOT empty_comb);
  empty_int <= ((adj_wr_pntr_rd = rd_pntr) OR (ram_rd_en = '1' AND
                (adj_wr_pntr_rd = conv_std_logic_vector((conv_integer(rd_pntr)+1),C_RD_PNTR_WIDTH))));
  
  -------------------------------------------------------------------------------
  -- Generate Almost Empty
  -------------------------------------------------------------------------------
  almost_empty_int <= ((adj_wr_pntr_rd = conv_std_logic_vector((conv_integer(rd_pntr)+1),C_RD_PNTR_WIDTH)) OR (ram_rd_en = '1' AND
                (adj_wr_pntr_rd = conv_std_logic_vector((conv_integer(rd_pntr)+2),C_RD_PNTR_WIDTH))));

  -------------------------------------------------------------------------------
  -- Registering Empty & Almost Empty 
  -- Generate read data count if Use Extra Logic is not selected.
  -------------------------------------------------------------------------------
  empty_proc : PROCESS (RD_CLK, rd_rst_i)
  BEGIN
    IF (rd_rst_i = '1') THEN
      empty_comb             <= '1' AFTER C_TCQ;
      empty_comb_d1          <= '1' AFTER C_TCQ;
      ALMOST_EMPTY           <= '1' AFTER C_TCQ;
      rd_data_count_int      <= (OTHERS => '0') AFTER C_TCQ;
    ELSIF (RD_CLK'event AND RD_CLK = '1') THEN
      rd_data_count_int      <= ((adj_wr_pntr_rd(C_RD_PNTR_WIDTH-1 DOWNTO 0) - 
                                 rd_pntr(C_RD_PNTR_WIDTH-1 DOWNTO 0)) & '0') AFTER C_TCQ;
      empty_comb_d1          <= empty_comb AFTER C_TCQ;
      IF (empty_int) THEN
        empty_comb           <= '1' AFTER C_TCQ;
      ELSE
        empty_comb           <= '0' AFTER C_TCQ;
      END IF;
      IF (empty_comb = '0') THEN
        IF (almost_empty_int) THEN
          ALMOST_EMPTY       <= '1' AFTER C_TCQ;
        ELSE
          ALMOST_EMPTY       <= '0' AFTER C_TCQ;
        END IF;
      END IF;
    END IF;
  END PROCESS empty_proc;

  -------------------------------------------------------------------------------
  -- Read pointer adjustment based on pointers width for FULL/ALMOST_FULL generation
  -------------------------------------------------------------------------------
  gfpad : IF (C_WR_PNTR_WIDTH > C_RD_PNTR_WIDTH)	GENERATE
    adj_rd_pntr_wr
    (C_WR_PNTR_WIDTH-1 DOWNTO C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH)
      <= rd_pntr_wr;
    adj_rd_pntr_wr(C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH-1 DOWNTO 0)
      <= (OTHERS => '0');
  END GENERATE gfpad;

  gftrim : IF (C_WR_PNTR_WIDTH <= C_RD_PNTR_WIDTH) GENERATE 
    adj_rd_pntr_wr 
      <= rd_pntr_wr(C_RD_PNTR_WIDTH-1 DOWNTO C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH);
  END GENERATE gftrim;

  -------------------------------------------------------------------------------
  -- Generate Full
  -------------------------------------------------------------------------------
  -- ram_wr_en used to determine FULL should depend on the FULL.
  ram_wr_en <= WR_EN AND (NOT full_comb);
  full_int <= ((adj_rd_pntr_wr = conv_std_logic_vector((conv_integer(wr_pntr)+1),C_WR_PNTR_WIDTH)) OR (ram_wr_en = '1' AND
                (adj_rd_pntr_wr = conv_std_logic_vector((conv_integer(wr_pntr)+2),C_WR_PNTR_WIDTH))));
  
  -------------------------------------------------------------------------------
  -- Generate Almost Full
  -------------------------------------------------------------------------------
  almost_full_int <= ((adj_rd_pntr_wr = conv_std_logic_vector((conv_integer(wr_pntr)+2),C_WR_PNTR_WIDTH)) OR (ram_wr_en = '1' AND
                (adj_rd_pntr_wr = conv_std_logic_vector((conv_integer(wr_pntr)+3),C_WR_PNTR_WIDTH))));

  -------------------------------------------------------------------------------
  -- Registering Full & Almost Full
  -- Generate write data count if Use Extra Logic is not selected.
  -------------------------------------------------------------------------------
  full_proc : PROCESS (WR_CLK, wr_rst_i)
  BEGIN
    IF (wr_rst_i = '1') THEN
      full_comb              <= int_2_std_logic(C_FULL_FLAGS_RST_VAL) AFTER C_TCQ;
      ALMOST_FULL            <= int_2_std_logic(C_FULL_FLAGS_RST_VAL) AFTER C_TCQ;
      wr_data_count_int      <= (OTHERS => '0') AFTER C_TCQ;
    ELSIF (WR_CLK'event AND WR_CLK = '1') THEN
      wr_data_count_int      <= ((wr_pntr(C_WR_PNTR_WIDTH-1 DOWNTO 0) -
                                adj_rd_pntr_wr(C_WR_PNTR_WIDTH-1 DOWNTO 0)) & '0') AFTER C_TCQ;
      IF (full_int) THEN
        full_comb  <= '1' AFTER C_TCQ;
      ELSE
        full_comb  <= '0' AFTER C_TCQ;
      END IF;
      IF (wr_rst_d1='1' AND wr_rst_i='0') THEN
        ALMOST_FULL     <= '0' AFTER C_TCQ;
      ELSIF (full_comb = '0') THEN
        IF (almost_full_int) THEN
          ALMOST_FULL   <= '1' AFTER C_TCQ;
        ELSE
          ALMOST_FULL   <= '0' AFTER C_TCQ;
        END IF;
      END IF;
    END IF;
  END PROCESS full_proc;

  -------------------------------------------------------------------------------
  -- Counter that determines the FWFT read duration.
  -------------------------------------------------------------------------------
  -- C_PRELOAD_LATENCY will be 0 for Non-Built-in FIFO with FWFT.
  grd_fwft: IF (C_PRELOAD_LATENCY = 0) GENERATE
    SIGNAL user_empty_fb_d1 : std_logic := '1';
  BEGIN
    grd_fwft_proc : PROCESS (RD_CLK, rd_rst_i)
    BEGIN
      IF (rd_rst_i = '1') THEN
        rd_fwft_cnt <= (others => '0');
        user_empty_fb_d1 <= '1';
        stage1_valid    <= '0';
        stage2_valid    <= '0';
      ELSIF (RD_CLK'event AND RD_CLK = '1') THEN
        user_empty_fb_d1 <= USER_EMPTY_FB;
        IF (user_empty_fb_d1 = '0' AND USER_EMPTY_FB = '1') THEN
          rd_fwft_cnt <= (others => '0') AFTER C_TCQ;
        ELSIF (empty_comb = '0') THEN
          IF (RD_EN = '1' AND rd_fwft_cnt < X"5") THEN
            rd_fwft_cnt <= rd_fwft_cnt + "1" AFTER C_TCQ;
          END IF;
        END IF;

        IF (stage1_valid = '0' AND stage2_valid = '0') THEN
          IF (empty_comb = '0') THEN
            stage1_valid    <= '1' AFTER C_TCQ;
          ELSE
            stage1_valid    <= '0' AFTER C_TCQ;
          END IF;
        ELSIF (stage1_valid = '1' AND stage2_valid = '0') THEN
          IF (empty_comb = '1') THEN
            stage1_valid    <= '0' AFTER C_TCQ;
            stage2_valid    <= '1' AFTER C_TCQ;
          ELSE
            stage1_valid    <= '1' AFTER C_TCQ;
            stage2_valid    <= '1' AFTER C_TCQ;
          END IF;
        ELSIF (stage1_valid = '0' AND stage2_valid = '1') THEN
          IF (empty_comb = '1' AND RD_EN_USER = '1') THEN
            stage1_valid    <= '0' AFTER C_TCQ;
            stage2_valid    <= '0' AFTER C_TCQ;
          ELSIF (empty_comb = '0' AND RD_EN_USER = '1') THEN
            stage1_valid    <= '1' AFTER C_TCQ;
            stage2_valid    <= '0' AFTER C_TCQ;
          ELSIF (empty_comb = '0' AND RD_EN_USER = '0') THEN
            stage1_valid    <= '1' AFTER C_TCQ;
            stage2_valid    <= '1' AFTER C_TCQ;
          ELSE
            stage1_valid    <= '0' AFTER C_TCQ;
            stage2_valid    <= '1' AFTER C_TCQ;
          END IF;
        ELSIF (stage1_valid = '1' AND stage2_valid = '1') THEN
          IF (empty_comb = '1' AND RD_EN_USER = '1') THEN
            stage1_valid    <= '0' AFTER C_TCQ;
            stage2_valid    <= '1' AFTER C_TCQ;
          ELSE
            stage1_valid    <= '1' AFTER C_TCQ;
            stage2_valid    <= '1' AFTER C_TCQ;
          END IF;
        ELSE
          stage1_valid    <= '0' AFTER C_TCQ;
          stage2_valid    <= '0' AFTER C_TCQ;
        END IF;

      END IF;
    END PROCESS grd_fwft_proc;
  END GENERATE grd_fwft;

  gnrd_fwft: IF (C_PRELOAD_LATENCY > 0) GENERATE 
        rd_fwft_cnt <= X"2";
  END GENERATE gnrd_fwft;
  
  -------------------------------------------------------------------------------
  -- Assign FULL, EMPTY, ALMOST_FULL and ALMOST_EMPTY
  -------------------------------------------------------------------------------
  FULL          <= full_comb;
  EMPTY         <= empty_comb;
  
  -------------------------------------------------------------------------------
  -- Asynchronous FIFO using linked lists
  -------------------------------------------------------------------------------

  
--  diff_pntr_rd <= 0 WHEN (rd_rst_i = '1')  ELSE conv_integer(adj_wr_pntr_rd - rd_pntr)
--                    WHEN (ram_rd_en = '0') ELSE conv_integer(adj_wr_pntr_rd - rd_pntr) - 1
--                    WHEN (ram_rd_en = '1') ELSE diff_pntr_rd;

  FIFO_PROC : PROCESS (WR_CLK, RD_CLK, rd_rst_i, wr_rst_i)

    --Declare the linked-list head/tail pointers and the size value
    VARIABLE head              : listptr;
    VARIABLE tail              : listptr;
    VARIABLE size              : integer := 0;
    VARIABLE cntr              : integer := 0;
    VARIABLE cntr_size_var_int : integer := 0;

    --Data is the internal version of the DOUT bus
    VARIABLE data : std_logic_vector(c_dout_width - 1 DOWNTO 0) 
      := hexstr_to_std_logic_vec( C_DOUT_RST_VAL, c_dout_width);
    VARIABLE err_type : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0'); 

    --Temporary values for calculating adjusted prog_empty/prog_full thresholds
    VARIABLE prog_empty_actual_assert_thresh : integer := 0;
    VARIABLE prog_empty_actual_negate_thresh : integer := 0;
    VARIABLE prog_full_actual_assert_thresh : integer := 0;
    VARIABLE prog_full_actual_negate_thresh : integer := 0;
    VARIABLE diff_pntr                      : integer := 0;
  
  BEGIN

    -- Calculate the current contents of the FIFO (size)
    -- Warning: This value should only be calculated once each time this
    -- process is entered.
    -- It is updated instantaneously for both write and read operations,
    -- so it is not ideal to use for signals which must consider the
    -- latency of crossing clock domains.

    -- cntr_size_var_int is updated only once when the process is entered
    -- This variable is used in the conditions instead of cntr which has the
    -- latest value.
    cntr_size_var_int := cntr;


    -- RESET CONDITIONS
    IF wr_rst_i = '1' THEN
  
      wr_point           <= 0 after C_TCQ;
      wr_point_d1        <= 0 after C_TCQ;
      wr_pntr_rd1        <= (OTHERS => '0') after C_TCQ;
      rd_pntr_wr_d2      <= (OTHERS => '0') after C_TCQ;
      rd_pntr_wr_d3      <= (OTHERS => '0') after C_TCQ;
      rd_pntr_wr_d4      <= (OTHERS => '0') after C_TCQ;
      rd_pntr_wr         <= (OTHERS => '0') after C_TCQ;

  
      --Create new linked list
      newlist(head, tail,cntr);

      diff_pntr         := 0;
  
    ---------------------------------------------------------------------------
    -- Write to FIFO
    ---------------------------------------------------------------------------
    ELSIF WR_CLK'event AND WR_CLK = '1' THEN

      -- Delay the write pointer before passing to RD_CLK domain to accommodate
      -- the binary to gray converion
      wr_pntr_rd1     <= wr_pntr after C_TCQ;

      -- Read pointer synchronization in WR_CLK domain
      rd_pntr_wr_d2   <= rd_pntr_wr_d1 after C_TCQ;
      rd_pntr_wr_d3   <= rd_pntr_wr_d2 after C_TCQ;
      rd_pntr_wr_d4   <= rd_pntr_wr_d2 after C_TCQ;

      -- Delay the synchronized read pointer to accommodate the gray to binary
      -- converion in WR_CLK domain
      rd_pntr_wr          <= rd_pntr_wr_d4 after C_TCQ;

      wr_point_d1 <= wr_point after C_TCQ;
  
      --The following IF statement setup default values of full_i and almost_full_i.
      --The values might be overwritten in the next IF statement.
--      IF (WR_EN = '1' and full_i = '0') THEN
--      IF (WR_EN = '1' and full_comb = '0') THEN
        --If writing, then it is not possible to predict how many
        --words will actually be in the FIFO after the write concludes
        --(because the number of reads which happen in this time can
        -- not be determined).
        --Therefore, treat it pessimistically and always assume that
        -- the write will happen without a read (assume the FIFO is
        -- C_DEPTH_RATIO_RD fuller than it is).
        --Note:
        --1. cntr_size_var_int is the deepest depth between write depth and read depth
        --   cntr_size_var_int/C_DEPTH_RATIO_RD is number of words in the write domain.
        --2. cntr_size_var_int+C_DEPTH_RATIO_RD: number of write words in the next clock cycle
        --   if wr_en=1 (C_DEPTH_RATIO_RD=one write word)
        --3. For asymmetric FIFO, if write width is narrower than read width. Don't
        --   have to consider partial words.
        --4. For asymmetric FIFO, if read width is narrower than write width,
        --   the worse case that FIFO is going to full is depicted in the following 
        --   diagram. Both rd_pntr_a and rd_pntr_b will cause FIFO full. rd_pntr_a
        --   is the worse case. Therefore, in the calculation, actual FIFO depth is
        --   substarcted to one write word and added one read word.
        --              -------
        --              |  |  |
        --    wr_pntr-->|  |---
        --              |  |  |
        --              ---|---
        --              |  |  |
        --              |  |---
        --              |  |  |
        --              ---|---
        --              |  |  |<--rd_pntr_a
        --              |  |---
        --              |  |  |<--rd_pntr_b
        --              ---|---
        
  
      -- Update full_i and almost_full_i if user is writing to the FIFO.
      -- Assign overflow and wr_ack.
      IF WR_EN = '1' THEN
  
        IF full_comb /= '1' THEN
        -- User is writing to a FIFO which is NOT reporting FULL
  
          IF cntr_size_var_int/C_DEPTH_RATIO_RD = C_FIFO_WR_DEPTH THEN
            -- FIFO really is Full
            --Report Overflow and do not acknowledge the write
  
          ELSIF cntr_size_var_int/C_DEPTH_RATIO_RD + 1 = C_FIFO_WR_DEPTH THEN
            -- FIFO is almost full
            -- This write will succeed, and FIFO will go FULL
            FOR h IN C_DEPTH_RATIO_RD DOWNTO 1 LOOP
              add(head, tail, 
              DIN((C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1)),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));
            END LOOP;
            wr_point   <= (wr_point + 1) MOD C_WR_DEPTH after C_TCQ;
  
          ELSIF cntr_size_var_int/C_DEPTH_RATIO_RD + 2 = C_FIFO_WR_DEPTH THEN
            -- FIFO is one away from almost full
            -- This write will succeed, and FIFO will go almost_full_i
            FOR h IN C_DEPTH_RATIO_RD DOWNTO 1 LOOP
              add(head, tail, 
              DIN((C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1)),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));
            END LOOP;
            wr_point    <= (wr_point + 1) MOD C_WR_DEPTH after C_TCQ;
  
          ELSE
            -- FIFO is no where near FULL
            --Write will succeed, no change in status
            FOR h IN C_DEPTH_RATIO_RD DOWNTO 1 LOOP
              add(head, tail, 
              DIN((C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1)),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));
            END LOOP;
            wr_point   <= (wr_point + 1) MOD C_WR_DEPTH after C_TCQ;
          END IF;
  
        ELSE --IF full_i = '1'
          -- User is writing to a FIFO which IS reporting FULL
          --Write will fail
        END IF;  --full_i
  
      ELSE                              --WR_EN/='1'
        --No write attempted, so neither overflow or acknowledge
      END IF;  --WR_EN
  
    END IF;  --WR_CLK
  
    ---------------------------------------------------------------------------
    -- Read from FIFO
    ---------------------------------------------------------------------------

    IF rd_rst_i = '1' THEN
      -- Whenever user is attempting to read from
      -- an EMPTY FIFO, the core should report an underflow error, even if
      -- the core is in a RESET condition.
  
      rd_point          <= 0 after C_TCQ;
      rd_point_d1       <= 0 after C_TCQ;
      rd_pntr_wr_d1    <= (OTHERS => '0') after C_TCQ;
      wr_pntr_rd2      <= (OTHERS => '0') after C_TCQ;
      wr_pntr_rd3      <= (OTHERS => '0') after C_TCQ;
      wr_pntr_rd       <= (OTHERS => '0') after C_TCQ;
  
      -- DRAM resets asynchronously
      IF (C_MEMORY_TYPE = 2 AND C_USE_DOUT_RST = 1) THEN
        data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
      END IF;
  
      -- BRAM resets synchronously
      IF (C_MEMORY_TYPE < 2 AND C_USE_DOUT_RST = 1) THEN
        IF (RD_CLK'event AND RD_CLK = '1') THEN
          data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
        END IF;
      END IF;

      -- Reset only if ECC is not selected as ECC does not support reset.
      IF (C_USE_ECC = 0) THEN
        err_type        := (OTHERS => '0');
      END IF ;
  
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN

      -- Delay the read pointer before passing to WR_CLK domain to accommodate
      -- the binary to gray converion
      rd_pntr_wr_d1 <= rd_pntr after C_TCQ;

      -- Write pointer synchronization in RD_CLK domain
      wr_pntr_rd2   <= wr_pntr_rd1 after C_TCQ;
      wr_pntr_rd3   <= wr_pntr_rd2 after C_TCQ;

      -- Delay the synchronized write pointer to accommodate the gray to binary
      -- converion in RD_CLK domain
      wr_pntr_rd    <= wr_pntr_rd3 after C_TCQ;

      rd_point_d1 <= rd_point after C_TCQ;
      
      
      ---------------------------------------------------------------------------
      -- Read Latency 1
      ---------------------------------------------------------------------------
  
      --The following IF statement setup default values of empty_i and 
      --almost_empty_i. The values might be overwritten in the next IF statement.
      --Note:
      --cntr_size_var_int/C_DEPTH_RATIO_WR : number of words in read domain.

      IF (ram_rd_en = '1') THEN
  
        IF empty_comb /= '1' THEN
          IF cntr_size_var_int/C_DEPTH_RATIO_WR = 2 THEN
            --FIFO is going almost empty
            FOR h IN C_DEPTH_RATIO_WR DOWNTO 1 LOOP
              read(tail, 
              data((C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1)),
              err_type);
              remove(head, tail,cntr);
            END LOOP;
            rd_point     <= (rd_point + 1) MOD C_RD_DEPTH after C_TCQ;
          
          ELSIF cntr_size_var_int/C_DEPTH_RATIO_WR = 1 THEN
            --FIFO is going empty
            FOR h IN C_DEPTH_RATIO_WR DOWNTO 1 LOOP
              read(tail, 
              data((C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1)),
              err_type);
              remove(head, tail,cntr);
            END LOOP;
            rd_point     <= (rd_point + 1) MOD C_RD_DEPTH after C_TCQ;
  
          ELSIF cntr_size_var_int/C_DEPTH_RATIO_WR = 0 THEN
          --FIFO is empty
  
          ELSE
          --FIFO is not empty
            FOR h IN C_DEPTH_RATIO_WR DOWNTO 1 LOOP
              read(tail, 
              data((C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1)),
              err_type);
              remove(head, tail,cntr);
            END LOOP;
            rd_point     <= (rd_point + 1) MOD C_RD_DEPTH after C_TCQ;
          END IF;
        ELSE
          --FIFO is empty
        END IF;
  
      END IF;  --RD_EN
  
    END IF;  --RD_CLK
  
    dout_i    <= data after C_TCQ;
    sbiterr_i <= err_type(0) after C_TCQ;
    dbiterr_i <= err_type(1) after C_TCQ;
  
  END PROCESS;
  
  -----------------------------------------------------------------------------
  -- Programmable FULL flags
  -----------------------------------------------------------------------------

  proc_pf: PROCESS(WR_CLK, wr_rst_i)
  BEGIN
    IF (wr_rst_i = '1') THEN
      prog_full_reg      <= int_2_std_logic(C_FULL_FLAGS_RST_VAL);
      diff_pntr_wr       <= 0;
    ELSIF (WR_CLK'event AND WR_CLK = '1') THEN

      IF (ram_wr_en = '0') THEN
        diff_pntr_wr <= conv_integer(wr_pntr - adj_rd_pntr_wr) after C_TCQ;
      ELSIF (ram_wr_en = '1') THEN
        diff_pntr_wr <= conv_integer(wr_pntr - adj_rd_pntr_wr) + 1 after C_TCQ;
      END IF;

      IF (wr_rst_d1 = '1' AND wr_rst_i = '0') THEN
        prog_full_reg <= '0' after C_TCQ;
      ELSIF (C_PROG_FULL_TYPE = 1) THEN
        IF (full_comb = '0') THEN
          IF (diff_pntr_wr >= C_PROG_FULL_THRESH_ASSERT_VAL) THEN
            prog_full_reg <= '1' after C_TCQ;
          ELSE
            prog_full_reg <= '0' after C_TCQ;
          END IF;
        ELSE
          prog_full_reg   <= prog_full_reg after C_TCQ;
        END IF;  
      ELSIF (C_PROG_FULL_TYPE = 2) THEN
        IF (full_comb = '0') THEN
          IF (diff_pntr_wr >= C_PROG_FULL_THRESH_ASSERT_VAL) THEN
            prog_full_reg <= '1' after C_TCQ;
          ELSIF (diff_pntr_wr < C_PROG_FULL_THRESH_NEGATE_VAL) THEN
            prog_full_reg <= '0' after C_TCQ;
          ELSE
            prog_full_reg <= prog_full_reg after C_TCQ;
          END IF;
        ELSE
          prog_full_reg   <= prog_full_reg after C_TCQ;
        END IF;  
      ELSIF (C_PROG_FULL_TYPE = 3) THEN
        IF (full_comb = '0') THEN
          IF (diff_pntr_wr >= conv_integer(PROG_FULL_THRESH)) THEN
            prog_full_reg <= '1' after C_TCQ;
          ELSE
            prog_full_reg <= '0' after C_TCQ;
          END IF;
        ELSE
          prog_full_reg   <= prog_full_reg after C_TCQ;
        END IF;  
      ELSIF (C_PROG_FULL_TYPE = 4) THEN
        IF (full_comb = '0') THEN
          IF (diff_pntr_wr >= conv_integer(PROG_FULL_THRESH_ASSERT)) THEN
            prog_full_reg <= '1' after C_TCQ;
          ELSIF (diff_pntr_wr < conv_integer(PROG_FULL_THRESH_NEGATE)) THEN
            prog_full_reg <= '0' after C_TCQ;
          ELSE
            prog_full_reg <= prog_full_reg after C_TCQ;
          END IF;
        ELSE
          prog_full_reg   <= prog_full_reg after C_TCQ;
        END IF;  
      END IF;  --C_PROG_FULL_TYPE
    END IF;  -- WR_CLK
  END PROCESS proc_pf;

  
  ---------------------------------------------------------------------------
  -- Programmable EMPTY Flags
  ---------------------------------------------------------------------------

  proc_pe: PROCESS(RD_CLK, rd_rst_i)
    VARIABLE pe_thr_assert_val  : integer := 0;
    VARIABLE pe_thr_negate_val  : integer := 0;
  BEGIN
    IF (rd_rst_i = '1') THEN
      diff_pntr_rd       <= 0;
      prog_empty_reg     <= '1';
      pe_thr_assert_val  := 0;
      pe_thr_negate_val  := 0;
    ELSIF (RD_CLK'event AND RD_CLK = '1') THEN
      IF (ram_rd_en = '0') THEN
        diff_pntr_rd     <= conv_integer(adj_wr_pntr_rd - rd_pntr) after C_TCQ;
      ELSIF (ram_rd_en = '1') THEN
        diff_pntr_rd     <= conv_integer(adj_wr_pntr_rd - rd_pntr) - 1 after C_TCQ;
      ELSE
        diff_pntr_rd     <= diff_pntr_rd after C_TCQ;
      END IF;

      IF (C_PROG_EMPTY_TYPE = 1) THEN
        IF (empty_comb = '0') THEN
          IF (diff_pntr_rd <= C_PE_THR_ASSERT_VAL_I) THEN
            prog_empty_reg <= '1' after C_TCQ;
          ELSE
            prog_empty_reg <= '0' after C_TCQ;
          END IF;
        ELSE
          prog_empty_reg   <= prog_empty_reg after C_TCQ;
        END IF;  
      ELSIF (C_PROG_EMPTY_TYPE = 2) THEN
        IF (empty_comb = '0') THEN
          IF (diff_pntr_rd <= C_PE_THR_ASSERT_VAL_I) THEN
            prog_empty_reg <= '1' after C_TCQ;
          ELSIF (diff_pntr_rd > C_PE_THR_NEGATE_VAL_I) THEN
            prog_empty_reg <= '0' after C_TCQ;
          ELSE
            prog_empty_reg <= prog_empty_reg after C_TCQ;
          END IF;
        ELSE
          prog_empty_reg   <= prog_empty_reg after C_TCQ;
        END IF;  
      ELSIF (C_PROG_EMPTY_TYPE = 3) THEN

        -- If empty input threshold is selected, then subtract 2 for FWFT to
        -- compensate the FWFT stage, otherwise assign the input value.
        IF (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 0) THEN -- FWFT
          pe_thr_assert_val := conv_integer(PROG_EMPTY_THRESH) - 2;
        ELSE
          pe_thr_assert_val := conv_integer(PROG_EMPTY_THRESH);
        END IF;  

        IF (empty_comb = '0') THEN
          IF (diff_pntr_rd <= pe_thr_assert_val) THEN
            prog_empty_reg <= '1' after C_TCQ;
          ELSE
            prog_empty_reg <= '0' after C_TCQ;
          END IF;
        ELSE
          prog_empty_reg   <= prog_empty_reg after C_TCQ;
        END IF;  
      ELSIF (C_PROG_EMPTY_TYPE = 4) THEN

        -- If empty input threshold is selected, then subtract 2 for FWFT to
        -- compensate the FWFT stage, otherwise assign the input value.
        IF (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 0) THEN -- FWFT
          pe_thr_assert_val := conv_integer(PROG_EMPTY_THRESH_ASSERT) - 2;
          pe_thr_negate_val := conv_integer(PROG_EMPTY_THRESH_NEGATE) - 2;
        ELSE
          pe_thr_assert_val := conv_integer(PROG_EMPTY_THRESH_ASSERT);
          pe_thr_negate_val := conv_integer(PROG_EMPTY_THRESH_NEGATE);
        END IF;  

        IF (empty_comb = '0') THEN
          IF (diff_pntr_rd >= pe_thr_assert_val) THEN
            prog_empty_reg <= '1' after C_TCQ;
          ELSIF (diff_pntr_rd > pe_thr_negate_val) THEN
            prog_empty_reg <= '0' after C_TCQ;
          ELSE
            prog_empty_reg <= prog_empty_reg after C_TCQ;
          END IF;
        ELSE
          prog_empty_reg   <= prog_empty_reg after C_TCQ;
        END IF;  
      END IF;  --C_PROG_EMPTY_TYPE
    END IF;  -- RD_CLK
  END PROCESS proc_pe;

  -----------------------------------------------------------------------------
  -- overflow_i generation: Asynchronous FIFO
  -----------------------------------------------------------------------------
  govflw: IF (C_HAS_OVERFLOW = 1) GENERATE
    povflw: PROCESS (WR_CLK)
    BEGIN
      IF WR_CLK'event AND WR_CLK = '1' THEN
         overflow_i  <= full_comb AND WR_EN after C_TCQ;
      END IF;
    END PROCESS povflw;
  END GENERATE govflw;

  -----------------------------------------------------------------------------
  -- underflow_i generation: Asynchronous FIFO
  -----------------------------------------------------------------------------
  gunflw: IF (C_HAS_UNDERFLOW = 1) GENERATE
    punflw: PROCESS (RD_CLK)
    BEGIN
      IF RD_CLK'event AND RD_CLK = '1' THEN
        underflow_i <= empty_comb and RD_EN after C_TCQ;
      END IF;
    END PROCESS punflw;
  END GENERATE gunflw;

  -----------------------------------------------------------------------------
  -- wr_ack_i generation: Asynchronous FIFO
  -----------------------------------------------------------------------------  
  gwack: IF (C_HAS_WR_ACK = 1) GENERATE
    pwack: PROCESS (WR_CLK,wr_rst_i)
    BEGIN
      IF wr_rst_i = '1' THEN
        wr_ack_i           <= '0' after C_TCQ;
      ELSIF WR_CLK'event AND WR_CLK = '1' THEN
        wr_ack_i     <= '0' after C_TCQ;
        IF WR_EN = '1' THEN
          IF full_comb /= '1' THEN
            wr_ack_i <= '1' after C_TCQ;
          END IF;
        END IF;
      END IF;
    END PROCESS pwack;
  END GENERATE gwack;

  ----------------------------------------------------------------------------
  -- valid_i generation: Asynchronous FIFO
  ---------------------------------------------------------------------------- 
 gvld_i: IF (C_HAS_VALID = 1) GENERATE

    PROCESS (rd_rst_i  , RD_CLK  )
    BEGIN
      IF rd_rst_i = '1' THEN
        valid_i           <= '0' after C_TCQ;
      ELSIF RD_CLK'event AND RD_CLK = '1' THEN
        valid_i     <= '0' after C_TCQ;
        IF RD_EN = '1' THEN
          IF empty_comb /= '1' THEN
            valid_i <= '1' after C_TCQ;
          END IF;
        END IF;
      END IF;
    END PROCESS;

    -----------------------------------------------------------------
    -- Delay valid_d1
    --if C_MEMORY_TYPE=0 or 1, C_USE_EMBEDDED_REG=1
    -----------------------------------------------------------------

    gv0_as: IF (C_USE_EMBEDDED_REG=1
             AND (C_MEMORY_TYPE=0 OR C_MEMORY_TYPE=1)) GENERATE
      PROCESS (rd_rst_i  , RD_CLK  )
      BEGIN
        IF rd_rst_i = '1' THEN
          valid_d1          <= '0' after C_TCQ;
        ELSIF RD_CLK'event AND RD_CLK = '1' THEN
          valid_d1    <= valid_i after C_TCQ;
        END IF;
      END PROCESS;
    END GENERATE gv0_as;

    gv1_as: IF NOT (C_USE_EMBEDDED_REG=1
             AND (C_MEMORY_TYPE=0 OR C_MEMORY_TYPE=1)) GENERATE
      valid_d1 <= valid_i;
    END GENERATE gv1_as;


END GENERATE gvld_i;



  -----------------------------------------------------------------------------
  --Use delayed Valid AND DOUT if we have a LATENCY=2 configurations
  --  ( if C_MEMORY_TYPE=0 or 1, C_PRELOAD_REGS=0, C_USE_EMBEDDED_REG=1 )
  --Otherwise, connect the valid and DOUT values up directly, with no
  --additional latency.
  -----------------------------------------------------------------------------
  gv0: IF (C_PRELOAD_LATENCY=2 
           AND (C_MEMORY_TYPE=0 OR C_MEMORY_TYPE=1)) GENERATE

    gv1: IF (C_HAS_VALID = 1) GENERATE
      valid_out <= valid_d1;
    END GENERATE gv1;

    PROCESS (rd_rst_i  , RD_CLK  )
    BEGIN
      IF (rd_rst_i   = '1') THEN
        -- BRAM resets synchronously
        IF (C_USE_DOUT_RST = 1) THEN
          IF (RD_CLK  'event AND RD_CLK   = '1') THEN
            DOUT     <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH) after C_TCQ;
          END IF;
        END IF;
        IF (C_USE_ECC = 0) THEN
          SBITERR  <= '0' after C_TCQ;
          DBITERR  <= '0' after C_TCQ;
        END IF;
        ram_rd_en_d1 <= '0' after C_TCQ;
      ELSIF (RD_CLK  'event AND RD_CLK   = '1') THEN
        ram_rd_en_d1 <= ram_rd_en after C_TCQ;
        IF (ram_rd_en_d1 = '1') THEN
          DOUT     <= dout_i after C_TCQ;
          SBITERR  <= sbiterr_i after C_TCQ;
          DBITERR  <= dbiterr_i after C_TCQ;
        END IF;
      END IF;
    END PROCESS;
  END GENERATE gv0;
  
  gv1: IF NOT (C_PRELOAD_LATENCY=2 
              AND (C_MEMORY_TYPE=0 OR C_MEMORY_TYPE=1)) GENERATE

    gv2a: IF (C_HAS_VALID = 1) GENERATE
      valid_out <= valid_i;
    END GENERATE gv2a;

    DOUT     <= dout_i;
    SBITERR  <= sbiterr_i after C_TCQ;
    DBITERR  <= dbiterr_i after C_TCQ;
  END GENERATE gv1;

END behavioral;


--#############################################################################
--#############################################################################
--  Common Clock FIFO Behavioral Model
--#############################################################################
--#############################################################################

-------------------------------------------------------------------------------
-- Library Declaration
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-------------------------------------------------------------------------------
-- Common-Clock Entity Declaration - This is NOT the top-level entity
-------------------------------------------------------------------------------
ENTITY fifo_generator_v5_3_bhv_ss IS

  GENERIC (
    --------------------------------------------------------------------------------
    -- Generic Declarations (alphabetical)
    --------------------------------------------------------------------------------
    C_DATA_COUNT_WIDTH             : integer := 2;  
    C_DIN_WIDTH                    : integer := 8;  
    C_DOUT_RST_VAL                 : string  := ""; 
    C_DOUT_WIDTH                   : integer := 8;  
    C_FULL_FLAGS_RST_VAL           : integer := 1;
    C_HAS_ALMOST_EMPTY             : integer := 0;  
    C_HAS_ALMOST_FULL              : integer := 0;  
    C_HAS_DATA_COUNT               : integer := 0;  
    C_HAS_OVERFLOW                 : integer := 0;  
    C_HAS_RST                      : integer := 0;  
    C_HAS_SRST                     : integer := 0;  
    C_HAS_UNDERFLOW                : integer := 0;
    C_HAS_VALID                    : integer := 0;  
    C_HAS_WR_ACK                   : integer := 0;  
    C_MEMORY_TYPE                  : integer := 1;  
    C_OVERFLOW_LOW                 : integer := 0;  
    C_PRELOAD_LATENCY              : integer := 1;  
    C_PRELOAD_REGS                 : integer := 0;  
    C_PROG_EMPTY_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_EMPTY_TYPE              : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL  : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL  : integer := 0;
    C_PROG_FULL_TYPE               : integer := 0;
    C_RD_DEPTH                     : integer := 256;
    C_RD_PNTR_WIDTH                : integer := 8;  
    C_UNDERFLOW_LOW                : integer := 0;  
    C_USE_DOUT_RST                 : integer := 0;  
    C_USE_ECC                      : integer := 0;
    C_USE_EMBEDDED_REG             : integer := 0; 
    C_VALID_LOW                    : integer := 0;  
    C_WR_ACK_LOW                   : integer := 0;  
    C_WR_DEPTH                     : integer := 256;
    C_WR_PNTR_WIDTH                : integer := 8;
    C_TCQ                          : time    := 100 ps;
    C_ENABLE_RST_SYNC              : integer := 1;
    C_ERROR_INJECTION_TYPE         : integer := 0
    );


  PORT(
    --------------------------------------------------------------------------------
    -- Input and Output Declarations
    --------------------------------------------------------------------------------
    CLK                      : IN std_logic   := '0';
    RST                      : IN std_logic   := '0';
    SRST                     : IN std_logic   := '0';
    DIN                      : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0)     
                             := (OTHERS => '0');
    RD_EN                    : IN std_logic   := '0';
    WR_EN                    : IN std_logic   := '0';
    PROG_EMPTY_THRESH        : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) 
                             := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) 
                             := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) 
                             := (OTHERS => '0');
    PROG_FULL_THRESH         : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) 
                             := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) 
                             := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) 
                             := (OTHERS => '0');
    INJECTDBITERR            : IN  std_logic := '0';
    INJECTSBITERR            : IN  std_logic := '0';

    DOUT                     : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0) :=    (OTHERS => '0');
    EMPTY                    : OUT std_logic := '1';
    FULL                     : OUT std_logic := '0'; 
    ALMOST_EMPTY             : OUT std_logic := '1';
    ALMOST_FULL              : OUT std_logic := '0'; 
    PROG_EMPTY               : OUT std_logic := '1';
    PROG_FULL                : OUT std_logic := '0'; 
    OVERFLOW                 : OUT std_logic := '0';
    WR_ACK                   : OUT std_logic := '0';
    VALID                    : OUT std_logic := '0';
    UNDERFLOW                : OUT std_logic := '0';
    DATA_COUNT               : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0) 
                             :=    (OTHERS => '0');
    SBITERR                  : OUT std_logic := '0';
    DBITERR                  : OUT std_logic := '0'
    );

END fifo_generator_v5_3_bhv_ss;


-------------------------------------------------------------------------------
-- Architecture Heading
-------------------------------------------------------------------------------
ARCHITECTURE behavioral OF fifo_generator_v5_3_bhv_ss IS


  -----------------------------------------------------------------------------
  -- FUNCTION actual_fifo_depth
  -- Returns the actual depth of the FIFO (may differ from what the user 
  -- specified)
  --
  -- The FIFO depth is always represented as 2^n (16,32,64,128,256)
  -- However, the ACTUAL fifo depth may be 2^n+1 or 2^n-1 depending on certain
  -- options. This function returns the actual depth of the fifo, as seen by
  -- the user.
  -------------------------------------------------------------------------------
  FUNCTION actual_fifo_depth(
    C_FIFO_DEPTH : integer; 
    C_PRELOAD_REGS : integer; 
    C_PRELOAD_LATENCY : integer; 
    C_COMMON_CLOCK : integer) 
  RETURN integer IS
  BEGIN
    RETURN C_FIFO_DEPTH;
  END actual_fifo_depth;

  -----------------------------------------------------------------------------
  -- FUNCTION int_2_std_logic
  -- Returns a single bit (as std_logic) from an integer 1/0 value.
  -------------------------------------------------------------------------------
  FUNCTION int_2_std_logic(value : integer) RETURN std_logic IS
  BEGIN
    IF (value=1) THEN
      RETURN '1';
    ELSE
      RETURN '0';
    END IF;
  END int_2_std_logic; 

  -----------------------------------------------------------------------------
  -- FUNCTION hexstr_to_std_logic_vec
  -- Returns a std_logic_vector for a hexadecimal string
  -------------------------------------------------------------------------------

    FUNCTION hexstr_to_std_logic_vec( 
      arg1 : string; 
      size : integer ) 
    RETURN std_logic_vector IS
      VARIABLE result : std_logic_vector(size-1 DOWNTO 0) := (OTHERS => '0');
      VARIABLE bin    : std_logic_vector(3 DOWNTO 0);
      VARIABLE index  : integer                           := 0;
    BEGIN
      FOR i IN arg1'reverse_range LOOP
        CASE arg1(i) IS
          WHEN '0' => bin := (OTHERS => '0');
          WHEN '1' => bin := (0 => '1', OTHERS => '0');
          WHEN '2' => bin := (1 => '1', OTHERS => '0');
          WHEN '3' => bin := (0 => '1', 1 => '1', OTHERS => '0');
          WHEN '4' => bin := (2 => '1', OTHERS => '0');
          WHEN '5' => bin := (0 => '1', 2 => '1', OTHERS => '0');
          WHEN '6' => bin := (1 => '1', 2 => '1', OTHERS => '0');
          WHEN '7' => bin := (3 => '0', OTHERS => '1');
          WHEN '8' => bin := (3 => '1', OTHERS => '0');
          WHEN '9' => bin := (0 => '1', 3 => '1', OTHERS => '0');
          WHEN 'A' => bin := (0 => '0', 2 => '0', OTHERS => '1');
          WHEN 'a' => bin := (0 => '0', 2 => '0', OTHERS => '1');
          WHEN 'B' => bin := (2 => '0', OTHERS => '1');
          WHEN 'b' => bin := (2 => '0', OTHERS => '1');
          WHEN 'C' => bin := (0 => '0', 1 => '0', OTHERS => '1');
          WHEN 'c' => bin := (0 => '0', 1 => '0', OTHERS => '1');
          WHEN 'D' => bin := (1 => '0', OTHERS => '1');
          WHEN 'd' => bin := (1 => '0', OTHERS => '1');
          WHEN 'E' => bin := (0 => '0', OTHERS => '1');
          WHEN 'e' => bin := (0 => '0', OTHERS => '1');
          WHEN 'F' => bin := (OTHERS => '1');
          WHEN 'f' => bin := (OTHERS => '1');
          WHEN OTHERS =>
            FOR j IN 0 TO 3 LOOP
              bin(j) := 'X';
            END LOOP;
        END CASE;
        FOR j IN 0 TO 3 LOOP
          IF (index*4)+j < size THEN
            result((index*4)+j) := bin(j);
          END IF;
        END LOOP;
        index := index + 1;
      END LOOP;
      RETURN result;
    END hexstr_to_std_logic_vec;

  -----------------------------------------------------------------------------
  -- FUNCTION get_lesser
  -- Returns a minimum value
  -------------------------------------------------------------------------------
  
  FUNCTION get_lesser(a: INTEGER; b: INTEGER) RETURN INTEGER IS
  BEGIN
    IF (a < b) THEN
      RETURN a;
    ELSE
      RETURN b;
    END IF;
  END FUNCTION;

  --------------------------------------------------------------------------------
  -- Constant Declaration
  --------------------------------------------------------------------------------
  CONSTANT C_FIFO_WR_DEPTH : integer 
    := actual_fifo_depth(C_WR_DEPTH, C_PRELOAD_REGS, C_PRELOAD_LATENCY, 1);
  CONSTANT C_SMALLER_DATA_WIDTH : integer := get_lesser(C_DIN_WIDTH, C_DOUT_WIDTH);

  -------------------------------------------------------------------------------
  -- Internal Signals
  -------------------------------------------------------------------------------
  SIGNAL empty_i        : std_logic := '1';
  SIGNAL full_i         : std_logic := '0'; 
  SIGNAL almost_empty_i : std_logic := '1';
  SIGNAL almost_full_i  : std_logic := '0';

  SIGNAL rst_asreg      : std_logic := '0';
  SIGNAL rst_asreg_d1   : std_logic := '0';
  SIGNAL rst_asreg_d2   : std_logic := '0';
  SIGNAL rst_comb       : std_logic := '0';
  SIGNAL rst_reg        : std_logic := '0';
  SIGNAL rst_i          : std_logic := '0';
  SIGNAL srst_i         : std_logic := '0';

  SIGNAL diff_count     : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)       
                        := (OTHERS => '0');

  SIGNAL wr_ack_i       : std_logic := '0';
  SIGNAL overflow_i     : std_logic := '0';

  SIGNAL valid_i        : std_logic := '0';
  SIGNAL valid_d1       : std_logic := '0';
  SIGNAL underflow_i    : std_logic := '0';

  --The delayed reset is used to deassert prog_full
  SIGNAL rst_q          : std_logic := '0';

  SIGNAL prog_full_reg   : std_logic := '0'; 
  SIGNAL prog_full_noreg : std_logic := '0'; 
  SIGNAL prog_empty_reg  : std_logic := '1';
  SIGNAL prog_empty_noreg: std_logic := '1';
  SIGNAL dout_i          : std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0) 
                         := (OTHERS => '0');
  SIGNAL width_gt1       : std_logic := '0'; 
  SIGNAL sbiterr_i       : std_logic := '0'; 
  SIGNAL dbiterr_i       : std_logic := '0'; 
  SIGNAL ram_rd_en_d1    : std_logic := '0';

  -----------------------------------------------------------------------------
  -- Linked List types
  -----------------------------------------------------------------------------
  TYPE listtyp;
  TYPE listptr IS ACCESS listtyp;
  TYPE listtyp IS RECORD
                    data  : std_logic_vector(C_SMALLER_DATA_WIDTH + 1 DOWNTO 0);
                    older : listptr;
                    newer : listptr;
                  END RECORD;

  -------------------------------------------------------------------------------
  --Processes for linked list implementation. The functions are
  --1. Create a new linked list
  --2. Add a data element to a linked list
  --3. Read the data from the tail of the linked list
  --4. Remove the tail from the linked list
  --5. Calculate the size of the linked list
  -------------------------------------------------------------------------------
  --1. Create a new linked list
  PROCEDURE newlist (
    head : INOUT listptr; 
    tail : INOUT listptr;
    cntr : INOUT integer) IS
  BEGIN
    head := NULL;
    tail := NULL;
    cntr := 0;
  END;  

  --2. Add a data element to a linked list
  PROCEDURE add (
    head    : INOUT listptr; 
    tail    : INOUT listptr; 
    data    : IN std_logic_vector;
    cntr    : INOUT integer;
    inj_err : IN std_logic_vector(2 DOWNTO 0)
    ) IS
    VARIABLE oldhead        : listptr;
    VARIABLE newhead        : listptr;
    VARIABLE corrupted_data : std_logic_vector(1 DOWNTO 0);
  BEGIN
    --------------------------------------------------------------------------
    --a. Create a pointer to the existing head, if applicable
    --b. Create a new node for the list
    --c. Make the new node point to the old head
    --d. Make the old head point back to the new node (for doubly-linked list)
    --e. Put the data into the new head node
    --f. If the new head we just created is the only node in the list, 
    --   make the tail point to it
    --g. Return the new head pointer
    --------------------------------------------------------------------------
    IF (head /= NULL) THEN
      oldhead       := head;
    END IF;
    newhead         := NEW listtyp;
    newhead.older   := oldhead;
    IF (head /= NULL) THEN
      oldhead.newer := newhead;
    END IF;

    -- Error injection logic. Corrupt MSB and LSB of data and keep it. Based on 
    -- error injection type, pass the corrupted_data to the link list.
    corrupted_data := NOT data(data'high) & NOT data(data'low);
    IF (inj_err(1) = '0') THEN
      -- Do not change the data content for single bit errir injection or
      -- for no error injection. Just pass the data as is to the link list
      newhead.data := '0' & inj_err(0) & data;
    ELSE -- Double bit error injection is set
      IF (inj_err(2) = '1') THEN 
      -- Data width is 2. So, add only the corrupted data in the link list
        newhead.data := inj_err(1) & '0' & corrupted_data;
      ELSE
      -- Data width is >2. So, add corrupted_data and data to the link list,
      -- where data is 2 bits less (2 MSB is occupied by corrupted_data)
        newhead.data := inj_err(1) & '0' & corrupted_data & data(data'high-2 DOWNTO data'low);
      END IF;
    END IF;

    -- Increment the counter when data is added to the list
    cntr := cntr + 1;
    IF (newhead.older = NULL) THEN
      tail          := newhead;
    END IF;
    head            := newhead;
  END;  

  --3. Read the data from the tail of the linked list
  PROCEDURE read (
    tail : INOUT listptr; 
    data : OUT std_logic_vector;
    err_type : OUT std_logic_vector(1 DOWNTO 0)
    ) IS
  VARIABLE data_int : std_logic_vector(C_SMALLER_DATA_WIDTH + 1 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    data_int := tail.data;
    data     := data_int(C_SMALLER_DATA_WIDTH - 1 DOWNTO 0);
    err_type := data_int(data_int'high DOWNTO C_SMALLER_DATA_WIDTH);
  END;  

  --4. Remove the tail from the linked list
  PROCEDURE remove (
    head : INOUT listptr; 
    tail : INOUT listptr;
    cntr : INOUT integer) IS
    VARIABLE oldtail     :       listptr;
    VARIABLE newtail     :       listptr;
  BEGIN
    --------------------------------------------------------------------------
    --Make a copy of the old tail pointer
    --a. If there is no newer node, then set the tail pointer to nothing 
    --   (list is empty)
    --   otherwise, make the next newer node the new tail, and make it point 
    --   to nothing older
    --b. Clean up the memory for the old tail node
    --c. If the new tail is nothing, then we have an empty list, and head 
    --   should also be set to nothing
    --d. Return the new tail
    --------------------------------------------------------------------------
    oldtail         := tail;
    IF (oldtail.newer = NULL) THEN
      newtail       := NULL;
    ELSE
      newtail       := oldtail.newer;
      newtail.older := NULL;
    END IF;
    DEALLOCATE(oldtail);
    IF (newtail = NULL) THEN
      head          := NULL;
    END IF;
    tail            := newtail;
    -- Decrement the counter when data is removed from the list
    cntr := cntr - 1; 
  END; 


  --5. Calculate the size of the linked list
  PROCEDURE sizeof (head : INOUT listptr; size : OUT integer) IS
    VARIABLE curlink     :       listptr;
    VARIABLE tmpsize     :       integer := 0;
  BEGIN
    --------------------------------------------------------------------------
    --a. If head is null, then there is nothing in the list to traverse
    --   start with the head node (which implies at least one node exists)
    --   Loop through each node until you find the one that points to nothing 
    --   (the tail)
    --b. Return the number of nodes
    --------------------------------------------------------------------------
    IF (head /= NULL) THEN
      curlink                            := head;
      tmpsize                            := 1;
      WHILE (curlink.older /= NULL) LOOP
        tmpsize                          := tmpsize + 1;
        curlink                          := curlink.older;
      END LOOP;
    END IF;
    size                                 := tmpsize;
  END;  


  -----------------------------------------------------------------------------
  -- converts integer to specified length std_logic_vector : dropping least
  -- significant bits if integer is bigger than what can be represented by
  -- the vector
  -----------------------------------------------------------------------------
  FUNCTION count( 
    fifo_count    : IN integer;
    pointer_width : IN integer;
    counter_width : IN integer)
  RETURN std_logic_vector IS
    VARIABLE temp   :    std_logic_vector(pointer_width-1 DOWNTO 0)   
                    := (OTHERS => '0');
    VARIABLE output :    std_logic_vector(counter_width - 1 DOWNTO 0) 
                    := (OTHERS => '0');
  BEGIN
    temp     := CONV_STD_LOGIC_VECTOR(fifo_count, pointer_width);
    IF (counter_width <= pointer_width) THEN
      output := temp(pointer_width - 1 DOWNTO pointer_width - counter_width);
    ELSE
      output := temp(counter_width - 1 DOWNTO 0);
    END IF;
    RETURN output;
  END count;


-------------------------------------------------------------------------------
-- architecture begins here
-------------------------------------------------------------------------------
BEGIN

  width_gt1 <= '1' WHEN (C_DIN_WIDTH = 2) ELSE '0'; 

  -------------------------------------------------------------------------------
  -- If there is a reset input, generate internal reset signals
  -- The latency of reset will match the core behavior.
  -------------------------------------------------------------------------------
  --Single RST
  grst_sync : IF (C_ENABLE_RST_SYNC = 1) GENERATE
    grst : IF (C_HAS_RST=1) GENERATE
      PROCESS (CLK, RST)
      BEGIN
        IF (RST = '1') THEN
          rst_asreg <=   '1' after C_TCQ;
        ELSIF (CLK'event and CLK = '1') THEN
          IF (rst_asreg_d1 = '1') THEN
            rst_asreg <= '0' after C_TCQ;
          ELSE
            rst_asreg <= rst_asreg after C_TCQ;
          END IF;
        END IF;
    
        IF (CLK'event and CLK = '1') THEN
          rst_asreg_d1 <= rst_asreg after C_TCQ;
          rst_asreg_d2 <= rst_asreg_d1 after C_TCQ;
        END IF;
      END PROCESS;
      
      PROCESS (rst_asreg, rst_asreg_d2)
      BEGIN
        rst_comb <= NOT rst_asreg_d2 AND rst_asreg;
      END PROCESS;
    
      PROCESS (CLK, rst_comb)
      BEGIN
        IF (rst_comb = '1') THEN
          rst_reg <= '1' after C_TCQ;
        ELSIF (CLK'event and CLK = '1') THEN
          rst_reg <= '0' after C_TCQ;
        END IF;
      END PROCESS;
    
      rst_i <= rst_reg;
    
    END GENERATE grst;
  END GENERATE grst_sync;

  --No RST
  norst  : IF ((C_HAS_RST = 0) OR (C_ENABLE_RST_SYNC = 0)) GENERATE
    rst_i <= '0';
  END GENERATE norst;
  
  --SRST
  gsrst  : IF (C_HAS_SRST=1) GENERATE
    srst_i <= SRST;
  END GENERATE gsrst;
  
  --No SRST
  nosrst  : IF (C_HAS_SRST=0) GENERATE
    srst_i <= '0';
  END GENERATE nosrst;

  gdc : IF (C_HAS_DATA_COUNT = 1) GENERATE

   gdcb : IF (C_DATA_COUNT_WIDTH > C_RD_PNTR_WIDTH) GENERATE
      DATA_COUNT(C_RD_PNTR_WIDTH-1 DOWNTO 0)    <= diff_count;
      DATA_COUNT(C_DATA_COUNT_WIDTH-1) <= '0' ; 
    END GENERATE;

    gdcs : IF (C_DATA_COUNT_WIDTH <= C_RD_PNTR_WIDTH) GENERATE
      DATA_COUNT <= 
      diff_count(C_RD_PNTR_WIDTH-1 DOWNTO C_RD_PNTR_WIDTH-C_DATA_COUNT_WIDTH);
    END GENERATE;
  END GENERATE;

  gndc    : IF (C_HAS_DATA_COUNT = 0) GENERATE
      DATA_COUNT <= (OTHERS => '0');
  END GENERATE;

  --Calculate WR_ACK based on C_WR_ACK_LOW parameters
  gwalow : IF (C_WR_ACK_LOW = 0) GENERATE
    WR_ACK <= wr_ack_i;
  END GENERATE gwalow;
  gwahgh : IF (C_WR_ACK_LOW = 1) GENERATE
    WR_ACK <= NOT wr_ack_i;
  END GENERATE gwahgh;

  --Calculate OVERFLOW based on C_OVERFLOW_LOW parameters
  govlow : IF (C_OVERFLOW_LOW = 0) GENERATE
    OVERFLOW <= overflow_i;
  END GENERATE govlow;
  govhgh : IF (C_OVERFLOW_LOW = 1) GENERATE
    OVERFLOW <= NOT overflow_i;
  END GENERATE govhgh;

  --Calculate VALID based on C_PRELOAD_LATENCY and C_VALID_LOW settings
  gvlat1 : IF (C_PRELOAD_LATENCY = 1 OR C_PRELOAD_LATENCY=2) GENERATE
    gnvl : IF (C_VALID_LOW = 0) GENERATE
      VALID <= valid_d1;
    END GENERATE gnvl;
    gnvh : IF (C_VALID_LOW = 1) GENERATE
      VALID <= NOT valid_d1;
    END GENERATE gnvh;
  END GENERATE gvlat1;

  --Calculate UNDERFLOW based on C_PRELOAD_LATENCY and C_UNDERFLOW_LOW settings
  guflat1 : IF (C_PRELOAD_LATENCY = 1 OR C_PRELOAD_LATENCY=2) GENERATE
    gnul  : IF (C_UNDERFLOW_LOW = 0) GENERATE
      UNDERFLOW <= underflow_i;
    END GENERATE gnul;
    gnuh  : IF (C_UNDERFLOW_LOW = 1) GENERATE
      UNDERFLOW <= NOT underflow_i;
    END GENERATE gnuh;
  END GENERATE guflat1;

  PROG_FULL <= prog_full_reg;
  PROG_EMPTY <= prog_empty_reg;

  FULL <= full_i;
  ALMOST_FULL <= almost_full_i;
  EMPTY         <= empty_i;
  ALMOST_EMPTY  <= almost_empty_i;

  -------------------------------------------------------------------------------
  -- Common-clock FIFO using linked lists
  -------------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Simultaneous Write and Read
  -- Write process will always happen before the read the process
  -----------------------------------------------------------------------------
  FIFO_PROC : PROCESS (CLK, rst_i)

  VARIABLE data : std_logic_vector(c_dout_width - 1 DOWNTO 0) :=
    hexstr_to_std_logic_vec( C_DOUT_RST_VAL, c_dout_width);
  VARIABLE head : listptr;
  VARIABLE tail : listptr;
  VARIABLE size : integer                                     := 0;
  VARIABLE cntr : integer := 0;
  VARIABLE cntr_size_var_int : integer := 0;
  VARIABLE err_type : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
  BEGIN

    ---------------------------------------------------------------------------
    --Calculate the current contents of the FIFO (size)
    -- Warning: This value should only be calculated once each time this
    -- process is entered. It is updated instantaneously.
    ---------------------------------------------------------------------------
    -- sizeof(head, size);
    -- cntr_size_var_int is updated only once when the process is entered
    -- This variable is used in the conditions instead of cntr which has the
    -- latest value.
    cntr_size_var_int := cntr; 

    -- RESET CONDITIONS
    IF (rst_i = '1') THEN
      rst_q       <= '1' after C_TCQ;

      full_i          <= int_2_std_logic(C_FULL_FLAGS_RST_VAL) after C_TCQ;
      almost_full_i   <= int_2_std_logic(C_FULL_FLAGS_RST_VAL) after C_TCQ;
      prog_full_reg   <= int_2_std_logic(C_FULL_FLAGS_RST_VAL) after C_TCQ;
      prog_full_noreg <= int_2_std_logic(C_FULL_FLAGS_RST_VAL) after C_TCQ;

      --Create new linked list
      newlist(head, tail,cntr);

      --Most memories asynchronously reset
      IF ((C_MEMORY_TYPE = 2 OR C_MEMORY_TYPE = 3) AND C_USE_DOUT_RST = 1) THEN         
        data := 
        hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
      END IF;

      -- Reset only if ECC is not selected as ECC does not support reset.
      IF (C_USE_ECC = 0) THEN
        err_type        := (OTHERS => '0');
      END IF ;

      --Block Memory Synchronously resets
      IF ((C_MEMORY_TYPE = 0 OR C_MEMORY_TYPE = 1) AND C_USE_DOUT_RST = 1) THEN
        IF (CLK'event AND CLK = '1') THEN
          data := 
          hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
        END IF;
      END IF;

      --Clear data output queue
      -- Whenever user is attempting to read from
      -- an EMPTY FIFO, the core should report an underflow error, even if
      -- the core is in a RESET condition.
      empty_i           <= '1' after C_TCQ;
      almost_empty_i    <= '1' after C_TCQ;
      prog_empty_reg    <= '1' after C_TCQ;
      prog_empty_noreg  <= '1' after C_TCQ;

      diff_count        <= (OTHERS => '0') after C_TCQ;

    ELSIF (CLK'event AND CLK = '1') THEN
      
      --Synchronous Reset
      IF (srst_i = '1') THEN 
        rst_q       <= '0' after C_TCQ; 
 
        full_i          <= '0' after C_TCQ;
        almost_full_i   <= '0' after C_TCQ;
        prog_full_reg   <= '0' after C_TCQ;
        prog_full_noreg <= '0' after C_TCQ;

        --Create new linked list
        newlist(head, tail,cntr);

        IF (C_MEMORY_TYPE < 4 AND C_USE_DOUT_RST = 1) THEN  
        --SRST is available only for BRAM, DRAM and SRAM
          data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
        END IF;

        -- Reset only if ECC is not selected as ECC does not support reset.
        IF (C_USE_ECC = 0) THEN
          err_type        := (OTHERS => '0');
        END IF ;

        --Clear data output queue
        -- Whenever user is attempting to read from
        -- an EMPTY FIFO, the core should report an underflow error, even if
        -- the core is in a RESET condition.
        empty_i           <= '1' after C_TCQ;
        almost_empty_i    <= '1' after C_TCQ;
        prog_empty_reg    <= '1' after C_TCQ;
        prog_empty_noreg  <= '1' after C_TCQ;

        diff_count        <= (OTHERS => '0') after C_TCQ;
      
      ELSE --srst_i=0
        --Create registered versions of these internal signals
        --This signal is used to deassert PROG_EMPTY and PROG_FULL
        rst_q       <= rst_i after C_TCQ;

        -------------------------------------------------------------------------
        -- Synchronous FIFO. There are four conditions. 
        -- 1 : Writing and not reading
        -- 2 : Reading and not writing
        -- 3 : Writing and Reading
        -- 4 : Not writing and not reading
        -------------------------------------------------------------------------
        -- Condition #1 : Writing and not reading
        IF ((WR_EN = '1') AND (RD_EN = '0')) THEN

          -- FIFO is FULL
          IF (cntr_size_var_int = C_FIFO_WR_DEPTH) THEN
            --Report Overflow and do not acknowledge the write

            --FIFO Remains FULL & ALMOST_FULL
            full_i        <= '1' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;

            --Report no underflow. Output not valid.

            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --No write, so do not update diff_count

          --FIFO is reporting FULL (Start-up condition)
          --When C_FULL_FLAGS_RST_VAL=1 
          --and right after internal reset is deasserted.
          ELSIF ((cntr_size_var_int < C_FIFO_WR_DEPTH) AND (full_i = '1')) THEN
            --Report Overflow and do not acknowledge the write

            --FIFO is not "really" FULL, so clear these values
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --Report no underflow. Output not valid.

            --FIFO EMPTY in this state can not be determined

            --No write, so do not update diff_count

          -- FIFO is one from FULL
          ELSIF (cntr_size_var_int + 1 = C_FIFO_WR_DEPTH) THEN
            -- This write will succeed, and FIFO will go FULL
            full_i        <= '1' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Report no underflow. Output not valid.

            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int+1),C_RD_PNTR_WIDTH) after C_TCQ;

          --FIFO is two from FULL
          ELSIF cntr_size_var_int + 2 = C_FIFO_WR_DEPTH THEN
            -- This write will succeed, and FIFO will go ALMOST_FULL
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Report no underflow. Output not valid.

            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int+1),C_RD_PNTR_WIDTH) after C_TCQ;

          --FIFO is ALMOST EMPTY
          ELSIF cntr_size_var_int = 1 THEN
            -- This write will succeed, and FIFO will no longer be ALMOST EMPTY
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Report no underflow. Output not valid.

            --FIFO is leaving ALMOST_EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int+1),C_RD_PNTR_WIDTH) after C_TCQ;

          --FIFO is EMPTY
          ELSIF cntr_size_var_int = 0 THEN
            -- This write will succeed, and FIFO will no longer be EMPTY
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Report no underflow. Output not valid.

            --FIFO is leaving EMPTY, but is still ALMOST_EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

             --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int+1),C_RD_PNTR_WIDTH) after C_TCQ;

          --FIFO has two or more words in the FIFO, but is not near FULL
          -- cntr_size_var_int>1 and cntr_size_var_int<C_FIFO_DEPTH-2
          ELSE 
            -- This write will succeed, and FIFO will no longer be EMPTY
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Report no underflow. Output not valid.

            --FIFO is no longer EMPTY or ALMOST_EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int+1),C_RD_PNTR_WIDTH) after C_TCQ;

          END IF;


        -- Condition #2 : Reading and not writing
        ELSIF ((WR_EN = '0') AND (RD_EN = '1')) THEN

          --FIFO is EMPTY or reporting EMPTY
          IF ((cntr_size_var_int = 0) OR (EMPTY_i = '1')) THEN
            --No write attempted, but a read will succeed
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --Successful read
            --FIFO is going EMPTY
            empty_i        <= '1' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

            --No read, so do not update diff_count

          --FIFO is ALMOST EMPTY
          ELSIF (cntr_size_var_int = 1) THEN
            --No write attempted, but a read will succeed
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --Successful read
            --FIFO is going EMPTY
            empty_i        <= '1' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

            --This read will succeed, but it's the last one
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int-1),C_RD_PNTR_WIDTH) after C_TCQ;

          -- FIFO is two from EMPTY
          ELSIF (cntr_size_var_int = 2) THEN
            --No write attempted, but a read will succeed
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --Successful read
            --FIFO is going ALMOST_EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int-1),C_RD_PNTR_WIDTH) after C_TCQ;

          -- FIFO is one from FULL
          ELSIF (cntr_size_var_int + 1 = C_FIFO_WR_DEPTH) THEN
            --No write attempted, but a read will succeed
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --Successful read
            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int-1),C_RD_PNTR_WIDTH) after C_TCQ;

          -- FIFO is FULL
          ELSIF (cntr_size_var_int = C_FIFO_WR_DEPTH) THEN
            --No write attempted, but a read will succeed
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;

            --Successful read
            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int-1),C_RD_PNTR_WIDTH) after C_TCQ;



          --FIFO has two or more words in the FIFO, but is not near FULL
          ELSE -- cntr_size_var_int>2 and cntr_size_var_int<C_FIFO_DEPTH-1
            --No write attempted, but a read will succeed
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --Successful read
            --FIFO is going EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --This read will succeed, but it's the last one
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int-1),C_RD_PNTR_WIDTH);

          END IF;


        -- Condition #3 : Reading and writing
        ELSIF ((WR_EN = '1') AND (RD_EN = '1')) THEN

          -- FIFO is FULL
          IF (cntr_size_var_int = C_FIFO_WR_DEPTH) THEN
            -- Write to FULL FIFO will fail
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;

            -- Read will be successful.

            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int-1),C_RD_PNTR_WIDTH) after C_TCQ;

          -- FIFO is reporting FULL, but it is empty
          --  (this is a special case, when coming out of RST)
          ELSIF ((cntr_size_var_int = 0) AND (full_i = '1')) THEN
            -- Write to FULL FIFO will fail

            --Clear the FULL flags for normal use
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            -- Read will be unsuccessful, because we're empty

            --FIFO EMPTY in this state can not be determined
            empty_i        <= '1' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

            --Do Not Read

            --No read or write, don't update data count

          -- FIFO is one from FULL
          ELSIF (cntr_size_var_int + 1 = C_FIFO_WR_DEPTH) THEN
            -- Write will be successful
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Successful read
            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Simulaneous read and write, no change in diff_count

          --FIFO is ALMOST EMPTY
          ELSIF (cntr_size_var_int = 1) THEN
            -- Write will be successful
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Successful read
            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Simulaneous read and write, no change in diff_count

          --FIFO is EMPTY
          ELSIF ((cntr_size_var_int = 0) OR (EMPTY_i = '1')) THEN
            -- Write will be successful
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Read will fail, because core is reporting EMPTY
            --FIFO is no longer EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((cntr_size_var_int+1),C_RD_PNTR_WIDTH) after C_TCQ;


          --FIFO has two or more words in the FIFO, but is not near FULL
          ELSE -- cntr_size_var_int>1 and cntr_size_var_int<C_FIFO_DEPTH-1
            -- Write will be successful
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),cntr,
              (width_gt1 & INJECTDBITERR & INJECTSBITERR));

            --Successful read
            --FIFO is nowhere near EMPTY
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ),
            err_type);
            remove(head, tail,cntr);

            --Simulaneous read and write, no change in diff_count

          END IF;

        -- Condition #4 : Not reading or writing
        ELSE -- ((WR_EN = '0') AND (RD_EN = '0'))

          --FULL
          IF (cntr_size_var_int = C_FIFO_WR_DEPTH) THEN  
            -- No write
            full_i        <= '1' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;

            --No read
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

          --ALMOST_FULL
          ELSIF (cntr_size_var_int >= C_FIFO_WR_DEPTH - 1) THEN  
            -- No write
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '1' after C_TCQ;

            --No read
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

          -- ALMOST_EMPTY
          ELSIF (cntr_size_var_int = 1) THEN  
            -- No write
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --No read
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

          -- EMPTY
          ELSIF (cntr_size_var_int = 0) THEN  
            -- No write
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --No read
            empty_i        <= '1' after C_TCQ;
            almost_empty_i <= '1' after C_TCQ;

          -- Not near FULL or EMPTY
          ELSE  
            -- No write
            full_i        <= '0' after C_TCQ;
            almost_full_i <= '0' after C_TCQ;

            --No read
            empty_i        <= '0' after C_TCQ;
            almost_empty_i <= '0' after C_TCQ;

          END IF;

        END IF;  -- WR_EN, RD_EN


        ------------------------------------------------------------------------
        -- Programmable FULL flags
        ------------------------------------------------------------------------

     IF  ( NOT (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0) ) THEN -- rle, calculation for standard fifo and latency = 2

        IF (C_PROG_FULL_TYPE /= 0) THEN

          -- single input threshold
          IF (C_PROG_FULL_TYPE = 3) THEN
            IF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH)-1) AND WR_EN = '1'
                   AND RD_EN = '0') THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH)) AND WR_EN = '0'
                 AND RD_EN = '1') THEN
                prog_full_noreg <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int >= conv_integer(PROG_FULL_THRESH)) THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int < conv_integer(PROG_FULL_THRESH)) THEN
                prog_full_noreg <= '0' after C_TCQ;
            END IF;

          -- dual input thresholds
          ELSIF (C_PROG_FULL_TYPE = 4) THEN
            IF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH_ASSERT)-1)
                 AND WR_EN = '1' AND RD_EN = '0') THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH_NEGATE))
                 AND WR_EN = '0' AND RD_EN = '1') THEN
                prog_full_noreg <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int >= conv_integer(PROG_FULL_THRESH_ASSERT)) THEN 
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int < conv_integer(PROG_FULL_THRESH_NEGATE)) THEN 
                prog_full_noreg <= '0' after C_TCQ;
            END IF;

          -- dual constant thresholds
          ELSIF (C_PROG_FULL_TYPE = 2) THEN
            IF ((cntr_size_var_int = C_PROG_FULL_THRESH_ASSERT_VAL-1) AND WR_EN = '1'
                AND RD_EN = '0') THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = C_PROG_FULL_THRESH_NEGATE_VAL) AND RD_EN = '1'
                   AND WR_EN = '0') THEN
                prog_full_noreg <= '0' after C_TCQ;
            END IF;

          -- single constant thresholds
          ELSE
            IF ((cntr_size_var_int = C_PROG_FULL_THRESH_ASSERT_VAL-1) AND WR_EN = '1'
                AND RD_EN = '0') THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF (((cntr_size_var_int = C_PROG_FULL_THRESH_ASSERT_VAL) AND RD_EN = '1'
               AND WR_EN = '0')) THEN
                prog_full_noreg <= '0' after C_TCQ;
            END IF;

          END IF; --C_PROG_FULL_TYPE

          IF (rst_q='1' and rst_i='0') THEN
            prog_full_reg <= '0' after C_TCQ;
            prog_full_noreg <= '0' after C_TCQ;
          ELSE
            prog_full_reg <= prog_full_noreg after C_TCQ;
          END IF;

        END IF;  --C_PROG_FULL_TYPE /= 0
      
     END IF; --  ( NOT (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0) )


     IF  (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0)  THEN -- rle, calculation for FWFT fifo
 
        IF (C_PROG_FULL_TYPE /= 0) THEN
 
          -- single input threshold
          IF (C_PROG_FULL_TYPE = 3) THEN
            IF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH)-1 - 2) AND WR_EN = '1'
                   AND RD_EN = '0') THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH) - 2) AND WR_EN = '0'
                 AND RD_EN = '1') THEN
                prog_full_noreg <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int >= conv_integer(PROG_FULL_THRESH) - 2) THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int < conv_integer(PROG_FULL_THRESH) - 2) THEN
                prog_full_noreg <= '0' after C_TCQ;
            END IF;
 
          -- dual input thresholds
          ELSIF (C_PROG_FULL_TYPE = 4) THEN
            IF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH_ASSERT)-1 - 2) 
                 AND WR_EN = '1' AND RD_EN = '0') THEN    
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = conv_integer(PROG_FULL_THRESH_NEGATE) - 2)
                 AND WR_EN = '0' AND RD_EN = '1') THEN    
                prog_full_noreg <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int >= conv_integer(PROG_FULL_THRESH_ASSERT) - 2) THEN 
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int < conv_integer(PROG_FULL_THRESH_NEGATE) - 2) THEN 
                prog_full_noreg <= '0' after C_TCQ;
            END IF;
 
          -- dual constant thresholds
          ELSIF (C_PROG_FULL_TYPE = 2) THEN
            IF ((cntr_size_var_int = C_PROG_FULL_THRESH_ASSERT_VAL-1 - 2) AND WR_EN = '1' 
                AND RD_EN = '0') THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = C_PROG_FULL_THRESH_NEGATE_VAL - 2) AND RD_EN = '1'
                   AND WR_EN = '0') THEN
                prog_full_noreg <= '0' after C_TCQ;
            END IF;
 
          -- single constant thresholds
          ELSE
            IF ((cntr_size_var_int = C_PROG_FULL_THRESH_ASSERT_VAL-1 - 2) AND WR_EN = '1'
                AND RD_EN = '0') THEN
                prog_full_noreg <= '1' after C_TCQ;
            ELSIF (((cntr_size_var_int = C_PROG_FULL_THRESH_ASSERT_VAL - 2) AND RD_EN = '1'
               AND WR_EN = '0')) THEN
                prog_full_noreg <= '0' after C_TCQ;
            END IF;
 
          END IF; --C_PROG_FULL_TYPE
 
          IF (rst_q='1' and rst_i='0') THEN
            prog_full_reg <= '0' after C_TCQ;
            prog_full_noreg <= '0' after C_TCQ;
          ELSE
            prog_full_reg <= prog_full_noreg after C_TCQ;
          END IF;
 
        END IF;  --C_PROG_FULL_TYPE /= 0
         
     END IF; --   (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0) 



        ------------------------------------------------------------------------
        -- Programmable EMPTY Flags
        ------------------------------------------------------------------------

     IF  ( NOT (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0) ) THEN -- rle, calculation for standard fifo and latency =2
        IF C_PROG_EMPTY_TYPE /= 0 THEN
          -- single input threshold
          IF C_PROG_EMPTY_TYPE = 3 THEN
            IF ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH)+1) 
                 AND RD_EN = '1' AND WR_EN = '0') THEN
              prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH)) 
                 AND RD_EN = '0' AND WR_EN = '1') THEN
              prog_empty_noreg      <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int <= conv_integer(PROG_EMPTY_THRESH)) THEN
              prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int > conv_integer(PROG_EMPTY_THRESH)) THEN
              prog_empty_noreg      <= '0' after C_TCQ;
            END IF;           

          -- dual input threshold
          ELSIF C_PROG_EMPTY_TYPE = 4 THEN
            IF ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH_ASSERT)+1) 
                 AND RD_EN = '1' AND WR_EN = '0') THEN
                prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF  ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH_NEGATE)) 
                 AND RD_EN = '0' AND WR_EN = '1')  THEN
                prog_empty_noreg      <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int <= conv_integer(PROG_EMPTY_THRESH_ASSERT)) THEN
                prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int > conv_integer(PROG_EMPTY_THRESH_NEGATE)) THEN
                prog_empty_noreg      <= '0' after C_TCQ;
            END IF; 

          -- dual constant thresholds
          ELSIF C_PROG_EMPTY_TYPE = 2 THEN
            IF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_ASSERT_VAL+1) AND RD_EN = '1'
                AND WR_EN = '0') THEN
                prog_empty_noreg          <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_NEGATE_VAL) AND WR_EN = '1'
                   AND RD_EN = '0') THEN
                prog_empty_noreg          <= '0' after C_TCQ;
            END IF;


          -- single constant threshold
          ELSIF C_PROG_EMPTY_TYPE = 1 THEN
            IF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_ASSERT_VAL+1) 
                AND RD_EN = '1' AND WR_EN = '0') THEN
                prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_ASSERT_VAL) 
                   AND WR_EN = '1' AND RD_EN = '0') THEN
                prog_empty_noreg      <= '0' after C_TCQ;
            END IF;

          END IF; -- C_PROG_EMPTY_TYPE

          prog_empty_reg <= prog_empty_noreg;

        END IF; -- C_PROG_EMPTY_TYPE /= 0
      END IF ; -- ( NOT (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0) )


     IF  (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0)  THEN -- rle, calculation for FWFT fifo 
        IF C_PROG_EMPTY_TYPE /= 0 THEN
          -- single input threshold  
          IF C_PROG_EMPTY_TYPE = 3 THEN
            IF ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH)+1 - 2)
                 AND RD_EN = '1' AND WR_EN = '0') THEN    
              prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH) - 2) 
                 AND RD_EN = '0' AND WR_EN = '1') THEN
              prog_empty_noreg      <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int <= conv_integer(PROG_EMPTY_THRESH) - 2) THEN
              prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int > conv_integer(PROG_EMPTY_THRESH) - 2) THEN
              prog_empty_noreg      <= '0' after C_TCQ;
            END IF;              
 
          -- dual input threshold
          ELSIF C_PROG_EMPTY_TYPE = 4 THEN
            IF ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH_ASSERT)+1 - 2)
                 AND RD_EN = '1' AND WR_EN = '0') THEN
                prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF  ((cntr_size_var_int = conv_integer(PROG_EMPTY_THRESH_NEGATE) - 2)
                 AND RD_EN = '0' AND WR_EN = '1')  THEN
                prog_empty_noreg      <= '0' after C_TCQ;
            ELSIF (cntr_size_var_int <= conv_integer(PROG_EMPTY_THRESH_ASSERT) - 2) THEN
                prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF (cntr_size_var_int > conv_integer(PROG_EMPTY_THRESH_NEGATE) - 2) THEN
                prog_empty_noreg      <= '0' after C_TCQ;
            END IF;
 
          -- dual constant thresholds
          ELSIF C_PROG_EMPTY_TYPE = 2 THEN
            IF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_ASSERT_VAL+1 - 2) AND RD_EN = '1'
                AND WR_EN = '0') THEN
                prog_empty_noreg          <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_NEGATE_VAL - 2) AND WR_EN = '1'
                   AND RD_EN = '0') THEN
                prog_empty_noreg          <= '0' after C_TCQ;
            END IF;
 
 
          -- single constant threshold
          ELSIF C_PROG_EMPTY_TYPE = 1 THEN
            IF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_ASSERT_VAL+1 - 2)
                AND RD_EN = '1' AND WR_EN = '0') THEN
                prog_empty_noreg      <= '1' after C_TCQ;
            ELSIF ((cntr_size_var_int = C_PROG_EMPTY_THRESH_ASSERT_VAL - 2)
                   AND WR_EN = '1' AND RD_EN = '0') THEN
                prog_empty_noreg      <= '0' after C_TCQ;
            END IF;
 
          END IF; -- C_PROG_EMPTY_TYPE
          prog_empty_reg <= prog_empty_noreg after C_TCQ;
 
        END IF; --C_PROG_EMPTY_TYPE /= 0

      END IF ; --  (C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=0)
 
     
      END IF; --not SRST

    END IF;     --CLK

    dout_i    <= data after C_TCQ;
    sbiterr_i <= err_type(0) after C_TCQ;
    dbiterr_i <= err_type(1) after C_TCQ;

  END PROCESS;

-------------------------------------------------------------------------------
  -- overflow_i generation: Synchronous FIFO
-------------------------------------------------------------------------------
  govflw: IF (C_HAS_OVERFLOW = 1) GENERATE
    povflw: PROCESS (CLK)
    BEGIN
      IF CLK'event AND CLK = '1' THEN
        overflow_i  <= full_i AND WR_EN after C_TCQ;
      END IF;
    END PROCESS povflw;
  END GENERATE govflw;

-------------------------------------------------------------------------------
  -- underflow_i generation: Synchronous FIFO
-------------------------------------------------------------------------------
  gunflw: IF (C_HAS_UNDERFLOW = 1) GENERATE
    punflw: PROCESS (CLK)
    BEGIN
      IF CLK'event AND CLK = '1' THEN
        underflow_i <= empty_i and RD_EN after C_TCQ;
      END IF;
    END PROCESS punflw;
  END GENERATE gunflw;

-------------------------------------------------------------------------------
  -- wr_ack_i generation: Synchronous FIFO
-------------------------------------------------------------------------------
  gwack: IF (C_HAS_WR_ACK = 1) GENERATE
    pwack: PROCESS (CLK,rst_i)
    BEGIN
      IF rst_i = '1' THEN
        wr_ack_i           <= '0' after C_TCQ;
      ELSIF CLK'event AND CLK = '1' THEN
        wr_ack_i     <= '0' after C_TCQ;
        IF srst_i = '1' THEN
           wr_ack_i     <= '0' after C_TCQ;
        ELSIF WR_EN = '1' THEN
            IF full_i /= '1' THEN
              wr_ack_i <= '1' after C_TCQ;
            END IF;
        END IF;
      END IF;
    END PROCESS pwack;
  END GENERATE gwack;

 -----------------------------------------------------------------------------
  -- valid_i generation: Synchronous FIFO
  -----------------------------------------------------------------------------
gvld_i: IF (C_HAS_VALID = 1) GENERATE

    PROCESS (rst_i  , CLK  )
    BEGIN
      IF rst_i = '1' THEN
        valid_i           <= '0' after C_TCQ;
      ELSIF CLK'event AND CLK = '1' THEN
        IF srst_i = '1' THEN
           valid_i     <= '0' after C_TCQ;
        ELSE --srst_i=0
           -- Setup default value for underflow and valid
           valid_i     <= '0' after C_TCQ;
           IF RD_EN = '1' THEN
             IF empty_i /= '1' THEN
               valid_i <= '1' after C_TCQ;
             END IF;
           END IF;
        END IF;
      END IF;
    END PROCESS;
 END GENERATE gvld_i;

  -----------------------------------------------------------------------------
  --Delay Valid AND DOUT 
  --if C_MEMORY_TYPE=0 or 1, C_USE_EMBEDDED_REG=1, STD
  -----------------------------------------------------------------------------
  gv0: IF (C_USE_EMBEDDED_REG=1 AND (NOT (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 0))
           AND (C_MEMORY_TYPE=0 OR C_MEMORY_TYPE=1)) GENERATE
    PROCESS (rst_i  , CLK  )
    BEGIN
      IF (rst_i   = '1') THEN
        IF (C_USE_DOUT_RST = 1) THEN
          IF (CLK'event AND CLK = '1') THEN
            DOUT     <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH) after C_TCQ;
          END IF;
        END IF;
        IF (C_USE_ECC = 0) THEN
          SBITERR  <= '0' after C_TCQ;
          DBITERR  <= '0' after C_TCQ;
        END IF;
        ram_rd_en_d1 <= '0' after C_TCQ;
        valid_d1 <= '0' after C_TCQ;
      ELSIF (CLK  'event AND CLK   = '1') THEN
        ram_rd_en_d1 <= RD_EN AND (NOT empty_i) after C_TCQ;
        valid_d1 <= valid_i after C_TCQ;
        IF (srst_i = '1') THEN
          IF (C_USE_DOUT_RST = 1) THEN
            DOUT     <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH) after C_TCQ;
          END IF;
          ram_rd_en_d1 <= '0' after C_TCQ;
          valid_d1     <= '0' after C_TCQ;
        ELSIF (ram_rd_en_d1 = '1') THEN
          DOUT     <= dout_i after C_TCQ;
          SBITERR  <= sbiterr_i after C_TCQ;
          DBITERR  <= dbiterr_i after C_TCQ;
        END IF;
      END IF;
    END PROCESS;
  END GENERATE gv0;

  gv1: IF NOT(C_USE_EMBEDDED_REG=1 AND (NOT (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 0))
              AND (C_MEMORY_TYPE=0 OR C_MEMORY_TYPE=1)) GENERATE
    valid_d1 <= valid_i;
    DOUT     <= dout_i;
    SBITERR  <= sbiterr_i;
    DBITERR  <= dbiterr_i;
  END GENERATE gv1;
END behavioral;


--#############################################################################
--#############################################################################
--  Preload Latency 0 (First-Word Fall-Through) Module
--#############################################################################
--#############################################################################
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY fifo_generator_v5_3_bhv_preload0 IS

  GENERIC (
    C_DOUT_RST_VAL           : string  := "";
    C_DOUT_WIDTH             : integer := 8;
    C_HAS_RST                : integer := 0;
    C_HAS_SRST               : integer := 0;
    C_USE_DOUT_RST           : integer := 0;
    C_USE_ECC                : integer := 0;
    C_USERVALID_LOW          : integer := 0;
    C_USERUNDERFLOW_LOW      : integer := 0;
    C_TCQ                    : time    := 100 ps;
    C_ENABLE_RST_SYNC        : integer := 1;
    C_ERROR_INJECTION_TYPE   : integer := 0;
    C_MEMORY_TYPE            : integer := 0
   );
  PORT (
    RD_CLK          : IN  std_logic;
    RD_RST          : IN  std_logic;
    SRST            : IN  std_logic;
    RD_EN           : IN  std_logic;
    FIFOEMPTY       : IN  std_logic;
    FIFODATA        : IN  std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    FIFOSBITERR     : IN  std_logic;
    FIFODBITERR     : IN  std_logic;
    USERDATA        : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    USERVALID       : OUT std_logic;
    USERUNDERFLOW   : OUT std_logic;
    USEREMPTY       : OUT std_logic;
    USERALMOSTEMPTY : OUT std_logic;
    RAMVALID        : OUT std_logic;
    FIFORDEN        : OUT std_logic;
    USERSBITERR     : OUT std_logic := '0';
    USERDBITERR     : OUT std_logic := '0'
    );

END fifo_generator_v5_3_bhv_preload0;

ARCHITECTURE behavioral OF fifo_generator_v5_3_bhv_preload0 IS

  -----------------------------------------------------------------------------
  -- FUNCTION hexstr_to_std_logic_vec
  -- Returns a std_logic_vector for a hexadecimal string
  -------------------------------------------------------------------------------

    FUNCTION hexstr_to_std_logic_vec( 
      arg1 : string; 
      size : integer ) 
    RETURN std_logic_vector IS
      VARIABLE result : std_logic_vector(size-1 DOWNTO 0) := (OTHERS => '0');
      VARIABLE bin    : std_logic_vector(3 DOWNTO 0);
      VARIABLE index  : integer                           := 0;
    BEGIN
      FOR i IN arg1'reverse_range LOOP
        CASE arg1(i) IS
          WHEN '0' => bin := (OTHERS => '0');
          WHEN '1' => bin := (0 => '1', OTHERS => '0');
          WHEN '2' => bin := (1 => '1', OTHERS => '0');
          WHEN '3' => bin := (0 => '1', 1 => '1', OTHERS => '0');
          WHEN '4' => bin := (2 => '1', OTHERS => '0');
          WHEN '5' => bin := (0 => '1', 2 => '1', OTHERS => '0');
          WHEN '6' => bin := (1 => '1', 2 => '1', OTHERS => '0');
          WHEN '7' => bin := (3 => '0', OTHERS => '1');
          WHEN '8' => bin := (3 => '1', OTHERS => '0');
          WHEN '9' => bin := (0 => '1', 3 => '1', OTHERS => '0');
          WHEN 'A' => bin := (0 => '0', 2 => '0', OTHERS => '1');
          WHEN 'a' => bin := (0 => '0', 2 => '0', OTHERS => '1');
          WHEN 'B' => bin := (2 => '0', OTHERS => '1');
          WHEN 'b' => bin := (2 => '0', OTHERS => '1');
          WHEN 'C' => bin := (0 => '0', 1 => '0', OTHERS => '1');
          WHEN 'c' => bin := (0 => '0', 1 => '0', OTHERS => '1');
          WHEN 'D' => bin := (1 => '0', OTHERS => '1');
          WHEN 'd' => bin := (1 => '0', OTHERS => '1');
          WHEN 'E' => bin := (0 => '0', OTHERS => '1');
          WHEN 'e' => bin := (0 => '0', OTHERS => '1');
          WHEN 'F' => bin := (OTHERS => '1');
          WHEN 'f' => bin := (OTHERS => '1');
          WHEN OTHERS =>
            FOR j IN 0 TO 3 LOOP
              bin(j) := 'X';
            END LOOP;
        END CASE;
        FOR j IN 0 TO 3 LOOP
          IF (index*4)+j < size THEN
            result((index*4)+j) := bin(j);
          END IF;
        END LOOP;
        index := index + 1;
      END LOOP;
      RETURN result;
    END hexstr_to_std_logic_vec;


  SIGNAL USERDATA_int : std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0) := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
  SIGNAL preloadstage1     : std_logic := '0';
  SIGNAL preloadstage2     : std_logic := '0';
  SIGNAL ram_valid_i       : std_logic := '0';
  SIGNAL read_data_valid_i : std_logic := '0';
  SIGNAL ram_regout_en     : std_logic := '0';
  SIGNAL ram_rd_en         : std_logic := '0';
  SIGNAL empty_i           : std_logic := '1';
  SIGNAL empty_q           : std_logic := '1';
  SIGNAL rd_en_q           : std_logic := '0';
  SIGNAL almost_empty_i    : std_logic := '1';
  SIGNAL almost_empty_q    : std_logic := '1';
  SIGNAL rd_rst_i          : std_logic := '0';
  SIGNAL srst_i            : std_logic := '0';


BEGIN  -- behavioral

  grst: IF (C_HAS_RST = 1 OR C_ENABLE_RST_SYNC = 0) GENERATE
    rd_rst_i <= RD_RST;
  end generate grst;
  
  ngrst: IF (C_HAS_RST = 0 AND C_ENABLE_RST_SYNC = 1) GENERATE
    rd_rst_i <= '0';
  END GENERATE ngrst;
  
   
  --SRST
  gsrst  : IF (C_HAS_SRST=1) GENERATE
    srst_i <= SRST;
  END GENERATE gsrst;
   
  --SRST
  ngsrst  : IF (C_HAS_SRST=0) GENERATE
    srst_i <= '0';
  END GENERATE ngsrst;
  

  --------------------------------------------------------------------------------
  --  preloadstage2 indicates that stage2 needs to be updated. This is true
  --  whenever read_data_valid is false, and RAM_valid is true.
  --------------------------------------------------------------------------------
  preloadstage2 <= ram_valid_i AND (NOT read_data_valid_i OR RD_EN);
  
  --------------------------------------------------------------------------------
  --  preloadstage1 indicates that stage1 needs to be updated. This is true
  --  whenever the RAM has data (RAM_EMPTY is false), and either RAM_Valid is
  --  false (indicating that Stage1 needs updating), or preloadstage2 is active
  --  (indicating that Stage2 is going to update, so Stage1, therefore, must
  --  also be updated to keep it valid.
  --------------------------------------------------------------------------------
  preloadstage1 <= (((NOT ram_valid_i) OR preloadstage2) AND (NOT FIFOEMPTY));
  
  --------------------------------------------------------------------------------
  -- Calculate RAM_REGOUT_EN
  --  The output registers are controlled by the ram_regout_en signal.
  --  These registers should be updated either when the output in Stage2 is
  --  invalid (preloadstage2), OR when the user is reading, in which case the
  --  Stage2 value will go invalid unless it is replenished.
  --------------------------------------------------------------------------------
  ram_regout_en <= preloadstage2;
  
  --------------------------------------------------------------------------------
  -- Calculate RAM_RD_EN
  --   RAM_RD_EN will be asserted whenever the RAM needs to be read in order to
  --  update the value in Stage1.
  --   One case when this happens is when preloadstage1=true, which indicates
  --  that the data in Stage1 or Stage2 is invalid, and needs to automatically
  --  be updated.
  --   The other case is when the user is reading from the FIFO, which guarantees
  --  that Stage1 or Stage2 will be invalid on the next clock cycle, unless it is
  --  replinished by data from the memory. So, as long as the RAM has data in it,
  --  a read of the RAM should occur.
  --------------------------------------------------------------------------------
  ram_rd_en     <= (RD_EN AND NOT FIFOEMPTY) OR preloadstage1;
  
  --------------------------------------------------------------------------------
  -- Calculate ram_valid
  --   ram_valid indicates that the data in Stage1 is valid.
  --
  --   If the RAM is being read from on this clock cycle (ram_rd_en=1), then
  --   ram_valid is certainly going to be true.
  --   If the RAM is not being read from, but the output registers are being
  --   updated to fill Stage2 (ram_regout_en=1), then Stage1 will be emptying,
  --   therefore causing ram_valid to be false.
  --   Otherwise, ram_valid will remain unchanged.
  --------------------------------------------------------------------------------
  regout_valid: PROCESS (RD_CLK, rd_rst_i)
  BEGIN  -- PROCESS regout_valid
    IF rd_rst_i = '1' THEN                -- asynchronous reset (active high)
      ram_valid_i <= '0' after C_TCQ;
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF srst_i = '1' THEN                -- synchronous reset (active high)
        ram_valid_i <= '0' after C_TCQ;
      ELSE
        IF ram_rd_en = '1' THEN
          ram_valid_i <= '1' after C_TCQ;
        ELSE
          IF ram_regout_en = '1' THEN
            ram_valid_i <= '0' after C_TCQ;
          ELSE
            ram_valid_i <= ram_valid_i after C_TCQ;
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS regout_valid;
  
  --------------------------------------------------------------------------------
  -- Calculate READ_DATA_VALID
  --  READ_DATA_VALID indicates whether the value in Stage2 is valid or not.
  --  Stage2 has valid data whenever Stage1 had valid data and ram_regout_en_i=1,
  --  such that the data in Stage1 is propogated into Stage2.
  --------------------------------------------------------------------------------
  regout_dvalid : PROCESS (RD_CLK, rd_rst_i)
  BEGIN
    IF (rd_rst_i='1') THEN
      read_data_valid_i <= '0' after C_TCQ;
    ELSIF (RD_CLK'event AND RD_CLK='1') THEN
      IF (srst_i='1') THEN
        read_data_valid_i <= '0' after C_TCQ;
      ELSE
        read_data_valid_i <= ram_valid_i OR (read_data_valid_i AND NOT RD_EN) after C_TCQ;
      END IF;
    END IF; --RD_CLK
  END PROCESS regout_dvalid;
  
  -------------------------------------------------------------------------------
  -- Calculate EMPTY
  --  Defined as the inverse of READ_DATA_VALID
  --
  -- Description:
  --
  --  If read_data_valid_i indicates that the output is not valid,
  -- and there is no valid data on the output of the ram to preload it
  -- with, then we will report empty.
  --
  --  If there is no valid data on the output of the ram and we are
  -- reading, then the FIFO will go empty.
  --
  
  -------------------------------------------------------------------------------
  regout_empty :  PROCESS (RD_CLK, rd_rst_i)       --This is equivalent to (NOT read_data_valid_i)
  BEGIN
    IF (rd_rst_i='1') THEN
      empty_i <= '1' after C_TCQ;
    ELSIF (RD_CLK'event AND RD_CLK='1') THEN
      IF (srst_i='1') THEN
        empty_i <= '1' after C_TCQ;
      ELSE
        empty_i  <= (NOT ram_valid_i AND NOT read_data_valid_i) OR (NOT ram_valid_i AND RD_EN) after C_TCQ;
      END IF;
    END IF; --RD_CLK
  END PROCESS regout_empty;
  


  regout_empty_q: PROCESS (RD_CLK)
  BEGIN  -- PROCESS regout_rd_en
    IF RD_CLK'event AND RD_CLK = '1' THEN  --
        empty_q  <= empty_i after C_TCQ;
    END IF;
  END PROCESS regout_empty_q;

  regout_rd_en: PROCESS (RD_CLK)                                                                   
  BEGIN  -- PROCESS regout_rd_en                                                                             
    IF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge                                           
        rd_en_q <= RD_EN after C_TCQ;
    END IF;                                                                                                  
  END PROCESS regout_rd_en;
  -------------------------------------------------------------------------------
  -- Calculate user_almost_empty
  --  user_almost_empty is defined such that, unless more words are written
  --  to the FIFO, the next read will cause the FIFO to go EMPTY.
  --
  --  In most cases, whenever the output registers are updated (due to a user
  -- read or a preload condition), then user_almost_empty will update to
  -- whatever RAM_EMPTY is.
  --
  --  The exception is when the output is valid, the user is not reading, and
  -- Stage1 is not empty. In this condition, Stage1 will be preloaded from the
  -- memory, so we need to make sure user_almost_empty deasserts properly under
  -- this condition.
  -------------------------------------------------------------------------------
  regout_aempty: PROCESS (RD_CLK, rd_rst_i)
  BEGIN  -- PROCESS regout_empty
    IF rd_rst_i = '1' THEN                -- asynchronous reset (active high)
      almost_empty_i <= '1' after C_TCQ;
      almost_empty_q <= '1' after C_TCQ;
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF srst_i = '1' THEN                -- synchronous reset (active high)
        almost_empty_i <= '1' after C_TCQ;
        almost_empty_q <= '1' after C_TCQ;
      ELSE
        IF ((ram_regout_en = '1') OR (FIFOEMPTY = '0' AND read_data_valid_i = '1' AND  RD_EN='0')) THEN
          almost_empty_i <= FIFOEMPTY after C_TCQ;
        END IF;
        almost_empty_q   <= almost_empty_i after C_TCQ;
      END IF;
    END IF;
  END PROCESS regout_aempty;
  
  USEREMPTY <= empty_i;
  USERALMOSTEMPTY <= almost_empty_i;
  FIFORDEN  <= ram_rd_en;
  RAMVALID  <= ram_valid_i;
  
  guvh: IF C_USERVALID_LOW=0 GENERATE
    USERVALID <= read_data_valid_i;
  END GENERATE guvh;
  guvl: if C_USERVALID_LOW=1 GENERATE
    USERVALID <= NOT read_data_valid_i;
  END GENERATE guvl;
  
  gufh: IF C_USERUNDERFLOW_LOW=0 GENERATE
    USERUNDERFLOW <= empty_q AND rd_en_q;
  END GENERATE gufh;
  gufl: if C_USERUNDERFLOW_LOW=1 GENERATE
    USERUNDERFLOW <= NOT (empty_q AND rd_en_q);
  END GENERATE gufl;

  regout_lat0: PROCESS (RD_CLK, rd_rst_i)
  BEGIN  -- PROCESS regout_lat0
    IF (rd_rst_i = '1') THEN              -- asynchronous reset (active high)
      IF (C_USE_ECC = 0) THEN  -- Reset S/DBITERR only if ECC is OFF
        USERSBITERR  <= '0' after C_TCQ;
        USERDBITERR  <= '0' after C_TCQ;
      END IF;

      -- DRAM resets asynchronously
      IF (C_USE_DOUT_RST = 1 AND C_MEMORY_TYPE = 2) THEN 
        USERDATA_int <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH) after C_TCQ;
      END IF;

      -- BRAM resets synchronously
      IF (C_USE_DOUT_RST = 1 AND C_MEMORY_TYPE < 2) THEN 
        IF (RD_CLK'event AND RD_CLK = '1') THEN
          USERDATA_int <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH) after C_TCQ;
        END IF;
      END IF;

    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF (srst_i = '1') THEN              -- synchronous reset (active high)
        IF (C_USE_ECC = 0) THEN  -- Reset S/DBITERR only if ECC is OFF
          USERSBITERR  <= '0' after C_TCQ;
          USERDBITERR  <= '0' after C_TCQ;
        END IF;
        IF (C_USE_DOUT_RST = 1) THEN              -- synchronous reset (active high)
          USERDATA_int <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH) after C_TCQ;
        END IF;
      ELSE
        IF (ram_regout_en = '1') THEN
          USERDATA_int <= FIFODATA after C_TCQ;
          USERSBITERR  <= FIFOSBITERR after C_TCQ;
          USERDBITERR  <= FIFODBITERR after C_TCQ;
        END IF;
      END IF;
    END IF;
  END PROCESS regout_lat0;

  USERDATA <= USERDATA_int ; -- rle, fixed bug R62
  

END behavioral;



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--  Top-level Behavioral Model
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.fifo_generator_v5_3_bhv_as;
USE XilinxCoreLib.fifo_generator_v5_3_bhv_ss;


-------------------------------------------------------------------------------
-- Top-level Entity Declaration - This is the top-level of the FIFO Bhv Model
-------------------------------------------------------------------------------
ENTITY fifo_generator_v5_3 IS
  GENERIC (
    ---------------------------------------------------------------------------
    -- Generic Declarations
    ---------------------------------------------------------------------------
    C_COMMON_CLOCK                : integer := 0;
    C_COUNT_TYPE                  : integer := 0;  --not used
    C_DATA_COUNT_WIDTH            : integer := 2;
    C_DEFAULT_VALUE               : string  := "";  --not used
    C_DIN_WIDTH                   : integer := 8;
    C_DOUT_RST_VAL                : string  := "";
    C_DOUT_WIDTH                  : integer := 8;
    C_ENABLE_RLOCS                : integer := 0;  --not used
    C_FAMILY                      : string  := "";  --not used in bhv model
    C_FULL_FLAGS_RST_VAL          : integer := 1;
    C_HAS_ALMOST_EMPTY            : integer := 0;
    C_HAS_ALMOST_FULL             : integer := 0;
    C_HAS_BACKUP                  : integer := 0;  --not used
    C_HAS_DATA_COUNT              : integer := 0;
    C_HAS_INT_CLK                 : integer := 0;  --not used in bhv model
    C_HAS_MEMINIT_FILE            : integer := 0;  --not used
    C_HAS_OVERFLOW                : integer := 0;
    C_HAS_RD_DATA_COUNT           : integer := 0;
    C_HAS_RD_RST                  : integer := 0;  --not used
    C_HAS_RST                     : integer := 1;
    C_HAS_SRST                    : integer := 0;
    C_HAS_UNDERFLOW               : integer := 0;
    C_HAS_VALID                   : integer := 0;
    C_HAS_WR_ACK                  : integer := 0;
    C_HAS_WR_DATA_COUNT           : integer := 0;
    C_HAS_WR_RST                  : integer := 0;  --not used
    C_IMPLEMENTATION_TYPE         : integer := 0;
    C_INIT_WR_PNTR_VAL            : integer := 0;  --not used
    C_MEMORY_TYPE                 : integer := 1;
    C_MIF_FILE_NAME               : string  := "";  --not used
    C_OPTIMIZATION_MODE           : integer := 0;  --not used
    C_OVERFLOW_LOW                : integer := 0;
    C_PRELOAD_LATENCY             : integer := 1;
    C_PRELOAD_REGS                : integer := 0;
    C_PRIM_FIFO_TYPE              : string  := "4kx4";  --not used in bhv model
    C_PROG_EMPTY_THRESH_ASSERT_VAL: integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL: integer := 0;
    C_PROG_EMPTY_TYPE             : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_FULL_TYPE              : integer := 0;
    C_RD_DATA_COUNT_WIDTH         : integer := 2;
    C_RD_DEPTH                    : integer := 256;
    C_RD_FREQ                     : integer := 1;  --not used in bhv model
    C_RD_PNTR_WIDTH               : integer := 8;
    C_UNDERFLOW_LOW               : integer := 0;
    C_USE_DOUT_RST                : integer := 0;
    C_USE_ECC                     : integer := 0;
    C_USE_EMBEDDED_REG            : integer := 0;
    C_USE_FIFO16_FLAGS            : integer := 0;  --not used in bhv model
    C_USE_FWFT_DATA_COUNT         : integer := 0;
    C_VALID_LOW                   : integer := 0;
    C_WR_ACK_LOW                  : integer := 0;
    C_WR_DATA_COUNT_WIDTH         : integer := 2;
    C_WR_DEPTH                    : integer := 256;
    C_WR_FREQ                     : integer := 1;  --not used in bhv model
    C_WR_PNTR_WIDTH               : integer := 8;
    C_WR_RESPONSE_LATENCY         : integer := 1;  --not used
    C_MSGON_VAL                   : integer := 1;  --not used in bhv model 
    C_ENABLE_RST_SYNC             : integer := 1;
    C_ERROR_INJECTION_TYPE        : integer := 0
    );
  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    BACKUP                    : IN  std_logic := '0';
    BACKUP_MARKER             : IN  std_logic := '0';
    CLK                       : IN  std_logic := '0';
    RST                       : IN  std_logic := '0';
    SRST                      : IN  std_logic := '0';
    WR_CLK                    : IN  std_logic := '0';
    WR_RST                    : IN  std_logic := '0';
    RD_CLK                    : IN  std_logic := '0';
    RD_RST                    : IN  std_logic := '0';
    DIN                       : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0); --
    WR_EN                     : IN  std_logic;  --Mandatory input
    RD_EN                     : IN  std_logic;  --Mandatory input
    --Mandatory input
    PROG_EMPTY_THRESH         : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH          : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    INT_CLK                   : IN  std_logic := '0';
    INJECTDBITERR             : IN  std_logic := '0';
    INJECTSBITERR             : IN  std_logic := '0';

    DOUT                      : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    FULL                      : OUT std_logic;
    ALMOST_FULL               : OUT std_logic;
    WR_ACK                    : OUT std_logic;
    OVERFLOW                  : OUT std_logic;
    EMPTY                     : OUT std_logic;
    ALMOST_EMPTY              : OUT std_logic;
    VALID                     : OUT std_logic;
    UNDERFLOW                 : OUT std_logic;
    DATA_COUNT                : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
    RD_DATA_COUNT             : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
    WR_DATA_COUNT             : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);
    PROG_FULL                 : OUT std_logic;
    PROG_EMPTY                : OUT std_logic;
    SBITERR                   : OUT std_logic := '0';
    DBITERR                   : OUT std_logic := '0'
    );

END fifo_generator_v5_3;

-------------------------------------------------------------------------------
-- Definition of Parameters
-------------------------------------------------------------------------------
--     C_COMMON_CLOCK                : Common Clock (1), Independent Clocks (0)
--     C_COUNT_TYPE                  :   --not used
--     C_DATA_COUNT_WIDTH            : Width of DATA_COUNT bus
--     C_DEFAULT_VALUE               :   --not used
--     C_DIN_WIDTH                   : Width of DIN bus
--     C_DOUT_RST_VAL                : Reset value of DOUT
--     C_DOUT_WIDTH                  : Width of DOUT bus
--     C_ENABLE_RLOCS                :   --not used
--     C_FAMILY                      : not used in bhv model
--     C_FULL_FLAGS_RST_VAL          : Full flags rst val (0 or 1)
--     C_HAS_ALMOST_EMPTY            : 1=Core has ALMOST_EMPTY flag
--     C_HAS_ALMOST_FULL             : 1=Core has ALMOST_FULL flag
--     C_HAS_BACKUP                  :   --not used
--     C_HAS_DATA_COUNT              : 1=Core has DATA_COUNT bus
--     C_HAS_INT_CLK                 : not used in bhv model
--     C_HAS_MEMINIT_FILE            :   --not used
--     C_HAS_OVERFLOW                : 1=Core has OVERFLOW flag
--     C_HAS_RD_DATA_COUNT           : 1=Core has RD_DATA_COUNT bus
--     C_HAS_RD_RST                  :   --not used
--     C_HAS_RST                     : 1=Core has Async Rst
--     C_HAS_SRST                    : 1=Core has Sync Rst
--     C_HAS_UNDERFLOW               : 1=Core has UNDERFLOW flag
--     C_HAS_VALID                   : 1=Core has VALID flag
--     C_HAS_WR_ACK                  : 1=Core has WR_ACK flag
--     C_HAS_WR_DATA_COUNT           : 1=Core has WR_DATA_COUNT bus
--     C_HAS_WR_RST                  :   --not used
--     C_IMPLEMENTATION_TYPE         : 0=Common-Clock Bram/Dram
--                                     1=Common-Clock ShiftRam
--                                     2=Indep. Clocks Bram/Dram
--                                     3=Virtex-4 Built-in
--                                     4=Virtex-5 Built-in
--     C_INIT_WR_PNTR_VAL            :  --not used
--     C_MEMORY_TYPE                 : 1=Block RAM
--                                     2=Distributed RAM
--                                     3=Shift RAM
--                                     4=Built-in FIFO
--     C_MIF_FILE_NAME               :  --not used
--     C_OPTIMIZATION_MODE           :  --not used
--     C_OVERFLOW_LOW                : 1=OVERFLOW active low
--     C_PRELOAD_LATENCY             : Latency of read: 0, 1, 2
--     C_PRELOAD_REGS                : 1=Use output registers
--     C_PRIM_FIFO_TYPE              : not used in bhv model
--     C_PROG_EMPTY_THRESH_ASSERT_VAL: PROG_EMPTY assert threshold
--     C_PROG_EMPTY_THRESH_NEGATE_VAL: PROG_EMPTY negate threshold
--     C_PROG_EMPTY_TYPE             : 0=No programmable empty
--                                     1=Single prog empty thresh constant
--                                     2=Multiple prog empty thresh constants
--                                     3=Single prog empty thresh input
--                                     4=Multiple prog empty thresh inputs
--     C_PROG_FULL_THRESH_ASSERT_VAL : PROG_FULL assert threshold
--     C_PROG_FULL_THRESH_NEGATE_VAL : PROG_FULL negate threshold
--     C_PROG_FULL_TYPE              : 0=No prog full
--                                     1=Single prog full thresh constant
--                                     2=Multiple prog full thresh constants
--                                     3=Single prog full thresh input
--                                     4=Multiple prog full thresh inputs
--     C_RD_DATA_COUNT_WIDTH         : Width of RD_DATA_COUNT bus
--     C_RD_DEPTH                    : Depth of read interface (2^N)
--     C_RD_FREQ                     : not used in bhv model
--     C_RD_PNTR_WIDTH               : always log2(C_RD_DEPTH)
--     C_UNDERFLOW_LOW               : 1=UNDERFLOW active low
--     C_USE_DOUT_RST                : 1=Resets DOUT on RST
--     C_USE_ECC                     : not used in bhv model
--     C_USE_EMBEDDED_REG            : 1=Use BRAM embedded output register
--     C_USE_FIFO16_FLAGS            : not used in bhv model
--     C_USE_FWFT_DATA_COUNT         : 1=Use extra logic for FWFT data count
--     C_VALID_LOW                   : 1=VALID active low
--     C_WR_ACK_LOW                  : 1=WR_ACK active low
--     C_WR_DATA_COUNT_WIDTH         : Width of WR_DATA_COUNT bus
--     C_WR_DEPTH                    : Depth of write interface (2^N)
--     C_WR_FREQ                     : not used in bhv model
--     C_WR_PNTR_WIDTH               : always log2(C_WR_DEPTH)
--     C_WR_RESPONSE_LATENCY         :   --not used
-------------------------------------------------------------------------------
-- Definition of Ports
-------------------------------------------------------------------------------
--   BACKUP       : Not used
--   BACKUP_MARKER: Not used
--   CLK          : Clock
--   DIN          : Input data bus
--   PROG_EMPTY_THRESH       : Threshold for Programmable Empty Flag
--   PROG_EMPTY_THRESH_ASSERT: Threshold for Programmable Empty Flag
--   PROG_EMPTY_THRESH_NEGATE: Threshold for Programmable Empty Flag
--   PROG_FULL_THRESH        : Threshold for Programmable Full Flag
--   PROG_FULL_THRESH_ASSERT : Threshold for Programmable Full Flag
--   PROG_FULL_THRESH_NEGATE : Threshold for Programmable Full Flag
--   RD_CLK       : Read Domain Clock
--   RD_EN        : Read enable
--   RD_RST       : Not used
--   RST          : Asynchronous Reset
--   SRST         : Synchronous Reset
--   WR_CLK       : Write Domain Clock
--   WR_EN        : Write enable
--   WR_RST       : Not used
--   INT_CLK      : Internal Clock
--   ALMOST_EMPTY : One word remaining in FIFO
--   ALMOST_FULL  : One empty space remaining in FIFO
--   DATA_COUNT   : Number of data words in fifo( synchronous to CLK)
--   DOUT         : Output data bus
--   EMPTY        : Empty flag
--   FULL         : Full flag
--   OVERFLOW     : Last write rejected
--   PROG_EMPTY   : Programmable Empty Flag
--   PROG_FULL    : Programmable Full Flag
--   RD_DATA_COUNT: Number of data words in fifo (synchronous to RD_CLK)
--   UNDERFLOW    : Last read rejected
--   VALID        : Last read acknowledged, DOUT bus VALID
--   WR_ACK       : Last write acknowledged
--   WR_DATA_COUNT: Number of data words in fifo (synchronous to WR_CLK)
--   SBITERR      : Single Bit ECC Error Detected
--   DBITERR      : Double Bit ECC Error Detected
-------------------------------------------------------------------------------


ARCHITECTURE behavioral OF fifo_generator_v5_3 IS

  -----------------------------------------------------------------------------
  -- FUNCTION two_comp
  -- Returns a 2's complement value
  -------------------------------------------------------------------------------
  	
    FUNCTION two_comp(
      vect : std_logic_vector)
    RETURN std_logic_vector IS
      VARIABLE local_vect : std_logic_vector(vect'high DOWNTO 0);
      VARIABLE toggle     : integer := 0;
    BEGIN
      FOR i IN 0 TO vect'high LOOP
        IF (toggle = 1) THEN
          IF (vect(i) = '0') THEN
            local_vect(i) := '1';
          ELSE
            local_vect(i) := '0';
          END IF;
        ELSE
          local_vect(i)   := vect(i);
          IF (vect(i) = '1') THEN
            toggle        := 1;
          END IF;
        END IF;
      END LOOP;
      RETURN local_vect;
    END two_comp;

  -----------------------------------------------------------------------------
  -- FUNCTION int_2_std_logic_vector
  -- Returns a std_logic_vector for an integer value for a given width.
  -------------------------------------------------------------------------------
  
    FUNCTION int_2_std_logic_vector( 
      value, bitwidth : integer )
    RETURN std_logic_vector IS
      VARIABLE running_value  : integer := value;
      VARIABLE running_result : std_logic_vector(bitwidth-1 DOWNTO 0);
    BEGIN
      IF (value < 0) THEN
        running_value := -1 * value;
      END IF;
  
      FOR i IN 0 TO bitwidth-1 LOOP
        IF running_value MOD 2 = 0 THEN
          running_result(i) := '0';
        ELSE
          running_result(i) := '1';
        END IF;
        running_value       := running_value/2;
      END LOOP;
      
      IF (value < 0) THEN                 -- find the 2s complement
        RETURN two_comp(running_result);
      ELSE
        RETURN running_result;
      END IF;
    
    END int_2_std_logic_vector;

  COMPONENT fifo_generator_v5_3_bhv_as

    GENERIC (
      --------------------------------------------------------------------------------
      -- Generic Declarations
      --------------------------------------------------------------------------------
      C_DIN_WIDTH                    :    integer := 8;
      C_DOUT_RST_VAL                 :    string  := "";
      C_DOUT_WIDTH                   :    integer := 8;
      C_FULL_FLAGS_RST_VAL           :    integer := 1;
      C_HAS_ALMOST_EMPTY             :    integer := 0;
      C_HAS_ALMOST_FULL              :    integer := 0;
      C_HAS_OVERFLOW                 :    integer := 0;
      C_HAS_RD_DATA_COUNT            :    integer := 2;
      C_HAS_RST                      :    integer := 1;
      C_HAS_UNDERFLOW                :    integer := 0;
      C_HAS_VALID                    :    integer := 0;
      C_HAS_WR_ACK                   :    integer := 0;
      C_HAS_WR_DATA_COUNT            :    integer := 2;
      C_MEMORY_TYPE                  :    integer := 1;
      C_OVERFLOW_LOW                 :    integer := 0;
      C_PRELOAD_LATENCY              :    integer := 1;
      C_PRELOAD_REGS                 :    integer := 0;
      C_PROG_EMPTY_THRESH_ASSERT_VAL :    integer := 0;
      C_PROG_EMPTY_THRESH_NEGATE_VAL :    integer := 0;
      C_PROG_EMPTY_TYPE              :    integer := 0;
      C_PROG_FULL_THRESH_ASSERT_VAL  :    integer := 0;
      C_PROG_FULL_THRESH_NEGATE_VAL  :    integer := 0;
      C_PROG_FULL_TYPE               :    integer := 0;
      C_RD_DATA_COUNT_WIDTH          :    integer := 0;
      C_RD_DEPTH                     :    integer := 256;
      C_RD_PNTR_WIDTH                :    integer := 8;
      C_UNDERFLOW_LOW                :    integer := 0;
      C_USE_DOUT_RST                 :    integer := 0;
      C_USE_ECC                      :    integer := 0;
      C_USE_EMBEDDED_REG             :    integer := 0;
      C_USE_FWFT_DATA_COUNT          :    integer := 0;
      C_VALID_LOW                    :    integer := 0;
      C_WR_ACK_LOW                   :    integer := 0;
      C_WR_DATA_COUNT_WIDTH          :    integer := 0;
      C_WR_DEPTH                     :    integer := 256;
      C_WR_PNTR_WIDTH                :    integer := 8;
      C_TCQ                          :    time    := 100 ps;
      C_ENABLE_RST_SYNC              :    integer := 1;
      C_ERROR_INJECTION_TYPE         :    integer := 0
      );
    PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
      DIN                            : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH              : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH_ASSERT       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH_NEGATE       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH               : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH_ASSERT        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH_NEGATE        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      RD_CLK                         : IN std_logic;
      RD_EN                          : IN std_logic;
      RD_EN_USER                     : IN std_logic;
      RST                            : IN std_logic;
      WR_RST                         : IN std_logic;
      RD_RST                         : IN std_logic;
      WR_CLK                         : IN std_logic;
      WR_EN                          : IN std_logic;
      INJECTDBITERR                  : IN std_logic := '0';
      INJECTSBITERR                  : IN std_logic := '0';
      USER_EMPTY_FB                  : IN std_logic := '1';

      ALMOST_EMPTY                   : OUT std_logic;
      ALMOST_FULL                    : OUT std_logic;
      DOUT                           : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
      EMPTY                          : OUT std_logic;
      FULL                           : OUT std_logic;
      OVERFLOW                       : OUT std_logic;
      PROG_EMPTY                     : OUT std_logic;
      PROG_FULL                      : OUT std_logic;
      VALID                          : OUT std_logic;
      RD_DATA_COUNT                  : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
      UNDERFLOW                      : OUT std_logic;
      WR_ACK                         : OUT std_logic;
      WR_DATA_COUNT                  : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);
      DBITERR                        : OUT std_logic := '0';
      SBITERR                        : OUT std_logic := '0'
      );

  END COMPONENT;



  COMPONENT fifo_generator_v5_3_bhv_ss

    GENERIC (
    --------------------------------------------------------------------------------
    -- Generic Declarations (alphabetical)
    --------------------------------------------------------------------------------
    C_DATA_COUNT_WIDTH             : integer := 2;
    C_DIN_WIDTH                    : integer := 8;
    C_DOUT_RST_VAL                 : string  := "";
    C_DOUT_WIDTH                   : integer := 8;
    C_FULL_FLAGS_RST_VAL           : integer := 1;
    C_HAS_ALMOST_EMPTY             : integer := 0;
    C_HAS_ALMOST_FULL              : integer := 0;
    C_HAS_DATA_COUNT               : integer := 0;
    C_HAS_OVERFLOW                 : integer := 0;
    C_HAS_RST                      : integer := 0;
    C_HAS_SRST                     : integer := 0;
    C_HAS_UNDERFLOW                : integer := 0;
    C_HAS_VALID                    : integer := 0;
    C_HAS_WR_ACK                   : integer := 0;
    C_MEMORY_TYPE                  : integer := 1;
    C_OVERFLOW_LOW                 : integer := 0;
    C_PRELOAD_LATENCY              : integer := 1;
    C_PRELOAD_REGS                 : integer := 0;
    C_PROG_EMPTY_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_EMPTY_TYPE              : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL  : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL  : integer := 0;
    C_PROG_FULL_TYPE               : integer := 0;
    C_RD_DEPTH                     : integer := 256;
    C_RD_PNTR_WIDTH                : integer := 8;
    C_UNDERFLOW_LOW                : integer := 0;
    C_USE_ECC                      : integer := 0;
    C_USE_DOUT_RST                 : integer := 0;
    C_USE_EMBEDDED_REG             : integer := 0;
    C_VALID_LOW                    : integer := 0;
    C_WR_ACK_LOW                   : integer := 0;
    C_WR_DEPTH                     : integer := 256;
    C_WR_PNTR_WIDTH                : integer := 8;
    C_TCQ                          : time    := 100 ps;
    C_ENABLE_RST_SYNC              : integer := 1;
    C_ERROR_INJECTION_TYPE         : integer := 0
    );


  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    CLK                      : IN std_logic                                    := '0';
    DIN                      : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0)     := (OTHERS => '0');
    PROG_EMPTY_THRESH        : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH         : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    RD_EN                    : IN std_logic                                    := '0';
    RST                      : IN std_logic                                    := '0';
    SRST                     : IN std_logic                                    := '0';
    WR_EN                    : IN std_logic                                    := '0';
    INJECTDBITERR            : IN std_logic := '0';
    INJECTSBITERR            : IN std_logic := '0';

    ALMOST_EMPTY             : OUT std_logic;
    ALMOST_FULL              : OUT std_logic;
    DATA_COUNT               : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
    DOUT                     : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY                    : OUT std_logic;
    FULL                     : OUT std_logic;
    OVERFLOW                 : OUT std_logic;
    PROG_EMPTY               : OUT std_logic;
    PROG_FULL                : OUT std_logic;
    VALID                    : OUT std_logic;
    UNDERFLOW                : OUT std_logic;
    WR_ACK                   : OUT std_logic;
    DBITERR                  : OUT std_logic := '0';
    SBITERR                  : OUT std_logic := '0'
    );

  END COMPONENT;

  COMPONENT fifo_generator_v5_3_bhv_preload0
    GENERIC (
      C_DOUT_RST_VAL         : string;
      C_DOUT_WIDTH           : integer;
      C_HAS_RST              : integer;
      C_HAS_SRST             : integer;
      C_USE_DOUT_RST         : integer := 0;
      C_USE_ECC              : integer := 0;
      C_USERVALID_LOW        : integer := 0;
      C_USERUNDERFLOW_LOW    : integer := 0;
      C_TCQ                  : time    := 100 ps; 
      C_ENABLE_RST_SYNC      : integer := 1;
      C_ERROR_INJECTION_TYPE : integer := 0;
      C_MEMORY_TYPE          : integer := 0
   );
    PORT (
      RD_CLK                 : IN  std_logic;
      RD_RST                 : IN  std_logic;
      SRST                   : IN  std_logic;
      RD_EN                  : IN  std_logic;
      FIFOEMPTY              : IN  std_logic;
      FIFODATA               : IN  std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
      FIFOSBITERR            : IN  std_logic;
      FIFODBITERR            : IN  std_logic;
      USERDATA               : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
      USERVALID              : OUT std_logic;
      USERUNDERFLOW          : OUT std_logic;
      USEREMPTY              : OUT std_logic;
      USERALMOSTEMPTY        : OUT std_logic;
      RAMVALID               : OUT std_logic;
      FIFORDEN               : OUT std_logic;
      USERSBITERR            : OUT std_logic;
      USERDBITERR            : OUT std_logic
      );
  END COMPONENT;

  -- Constant to have clock to register delay
  CONSTANT C_TCQ : time := 100 ps;

  SIGNAL zero : std_logic := '0';
  SIGNAL CLK_INT : std_logic := '0';



  -----------------------------------------------------------------------------
  -- Internal Signals
  --  In the normal case, these signals tie directly to the FIFO's inputs and
  --  outputs.
  --  In the case of Preload Latency 0 or 1, these are the intermediate
  --  signals between the internal FIFO and the preload logic.
  -----------------------------------------------------------------------------
    SIGNAL rd_en_fifo_in          : std_logic;
    SIGNAL dout_fifo_out          : std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    SIGNAL empty_fifo_out         : std_logic;
    SIGNAL almost_empty_fifo_out  : std_logic;
    SIGNAL valid_fifo_out         : std_logic;
    SIGNAL underflow_fifo_out     : std_logic;
    SIGNAL rd_data_count_fifo_out : std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
    SIGNAL wr_data_count_fifo_out : std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);
    SIGNAL data_count_fifo_out    : std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
    SIGNAL DATA_COUNT_FWFT        : std_logic_vector(C_RD_PNTR_WIDTH DOWNTO 0) := (OTHERS => '0');
    SIGNAL SS_FWFT_RD             : std_logic := '0' ;
    SIGNAL SS_FWFT_WR             : std_logic := '0' ;
    SIGNAL FULL_int               : std_logic ;

    SIGNAL dout_p0_out            : std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    signal valid_p0_out           : std_logic;
    signal empty_p0_out           : std_logic;
    signal underflow_p0_out       : std_logic;
    signal almost_empty_p0_out    : std_logic;

    signal empty_p0_out_q         : std_logic;
    signal almost_empty_p0_out_q  : std_logic;

    SIGNAL ram_valid              : std_logic;  --Internal signal used to monitor the
                                                --ram_valid state
    signal rst_fwft               : std_logic;
    signal sbiterr_fifo_out       : std_logic;
    signal dbiterr_fifo_out       : std_logic;

BEGIN

  --Assign Ground Signal
  zero <= '0';
  
  ASSERT (C_MEMORY_TYPE /= 4) REPORT "FAILURE : Behavioral models for Virtex-4, Virtex-5 and Virtex-6 built-in FIFO configurations is currently not supported. Please select the structural simulation model option in CORE Generator. You can enable this in CORE Generator by selecting Project -> Project Options -> Generation tab -> Structural Simulation. See the FIFO Generator User Guide for more information." SEVERITY FAILURE;
  
  ASSERT (C_IMPLEMENTATION_TYPE /= 2) REPORT "WARNING: Behavioral models for independent clock FIFO configurations are not cycle-accurate. You may wish to choose the structural simulation model instead of the behavioral model. This will ensure accurate behavior and latencies during simulation. You can enable this from CORE Generator by selecting Project -> Project Options -> Generation tab -> Structural Simulation. See the FIFO Generator User Guide for more information." SEVERITY NOTE;


  gen_ss : IF ((C_IMPLEMENTATION_TYPE = 0) OR (C_IMPLEMENTATION_TYPE = 1)) GENERATE
    fgss : fifo_generator_v5_3_bhv_ss
      GENERIC MAP (
        C_DATA_COUNT_WIDTH             => C_DATA_COUNT_WIDTH,
        C_DIN_WIDTH                    => C_DIN_WIDTH,
        C_DOUT_RST_VAL                 => C_DOUT_RST_VAL,
        C_DOUT_WIDTH                   => C_DOUT_WIDTH,
        C_FULL_FLAGS_RST_VAL           => C_FULL_FLAGS_RST_VAL,
        C_HAS_ALMOST_EMPTY             => C_HAS_ALMOST_EMPTY,
        C_HAS_ALMOST_FULL              => C_HAS_ALMOST_FULL,
        C_HAS_DATA_COUNT               => C_HAS_DATA_COUNT,
        C_HAS_OVERFLOW                 => C_HAS_OVERFLOW,
        C_HAS_RST                      => C_HAS_RST,
        C_HAS_SRST                     => C_HAS_SRST,
        C_HAS_UNDERFLOW                => C_HAS_UNDERFLOW,
        C_HAS_VALID                    => C_HAS_VALID,
        C_HAS_WR_ACK                   => C_HAS_WR_ACK,
        C_MEMORY_TYPE                  => C_MEMORY_TYPE,
        C_OVERFLOW_LOW                 => C_OVERFLOW_LOW,
        C_PRELOAD_LATENCY              => C_PRELOAD_LATENCY,
        C_PRELOAD_REGS                 => C_PRELOAD_REGS,
        C_PROG_EMPTY_THRESH_ASSERT_VAL => C_PROG_EMPTY_THRESH_ASSERT_VAL,
        C_PROG_EMPTY_THRESH_NEGATE_VAL => C_PROG_EMPTY_THRESH_NEGATE_VAL,
        C_PROG_EMPTY_TYPE              => C_PROG_EMPTY_TYPE,
        C_PROG_FULL_THRESH_ASSERT_VAL  => C_PROG_FULL_THRESH_ASSERT_VAL,
        C_PROG_FULL_THRESH_NEGATE_VAL  => C_PROG_FULL_THRESH_NEGATE_VAL,
        C_PROG_FULL_TYPE               => C_PROG_FULL_TYPE,
        C_RD_DEPTH                     => C_RD_DEPTH,
        C_RD_PNTR_WIDTH                => C_RD_PNTR_WIDTH,
        C_UNDERFLOW_LOW                => C_UNDERFLOW_LOW,
        C_USE_ECC                      => C_USE_ECC,
        C_USE_DOUT_RST                 => C_USE_DOUT_RST,
        C_USE_EMBEDDED_REG             => C_USE_EMBEDDED_REG,
        C_VALID_LOW                    => C_VALID_LOW,
        C_WR_ACK_LOW                   => C_WR_ACK_LOW,
        C_WR_DEPTH                     => C_WR_DEPTH,
        C_WR_PNTR_WIDTH                => C_WR_PNTR_WIDTH,
        C_TCQ                          => C_TCQ,
        C_ENABLE_RST_SYNC              => C_ENABLE_RST_SYNC,
        C_ERROR_INJECTION_TYPE         => C_ERROR_INJECTION_TYPE
        )
      PORT MAP(
        --Inputs
        CLK                            => CLK,
        DIN                            => DIN,
        PROG_EMPTY_THRESH              => PROG_EMPTY_THRESH,
        PROG_EMPTY_THRESH_ASSERT       => PROG_EMPTY_THRESH_ASSERT,
        PROG_EMPTY_THRESH_NEGATE       => PROG_EMPTY_THRESH_NEGATE,
        PROG_FULL_THRESH               => PROG_FULL_THRESH,
        PROG_FULL_THRESH_ASSERT        => PROG_FULL_THRESH_ASSERT,
        PROG_FULL_THRESH_NEGATE        => PROG_FULL_THRESH_NEGATE,
        RD_EN                          => rd_en_fifo_in,
        RST                            => RST,
        SRST                           => SRST,
        WR_EN                          => WR_EN,
        INJECTDBITERR                  => INJECTDBITERR,
        INJECTSBITERR                  => INJECTSBITERR,

        --Outputs
        ALMOST_EMPTY                   => almost_empty_fifo_out,
        ALMOST_FULL                    => ALMOST_FULL,
        DATA_COUNT                     => data_count_fifo_out,
        DOUT                           => dout_fifo_out,
        EMPTY                          => empty_fifo_out,
        FULL                           => FULL_int,
        OVERFLOW                       => OVERFLOW,
        PROG_EMPTY                     => PROG_EMPTY,
        PROG_FULL                      => PROG_FULL,
        UNDERFLOW                      => underflow_fifo_out,
        VALID                          => valid_fifo_out,
        WR_ACK                         => WR_ACK,
        DBITERR                        => dbiterr_fifo_out,
        SBITERR                        => sbiterr_fifo_out
        );
  END GENERATE gen_ss;



  gen_as : IF (C_IMPLEMENTATION_TYPE = 2) GENERATE

    fgas : fifo_generator_v5_3_bhv_as
      GENERIC MAP (
        C_DIN_WIDTH                    => C_DIN_WIDTH,
        C_DOUT_RST_VAL                 => C_DOUT_RST_VAL,
        C_DOUT_WIDTH                   => C_DOUT_WIDTH,
        C_FULL_FLAGS_RST_VAL           => C_FULL_FLAGS_RST_VAL,
        C_HAS_ALMOST_EMPTY             => C_HAS_ALMOST_EMPTY,
        C_HAS_ALMOST_FULL              => C_HAS_ALMOST_FULL,
        C_HAS_OVERFLOW                 => C_HAS_OVERFLOW,
        C_HAS_RD_DATA_COUNT            => C_HAS_RD_DATA_COUNT,
        C_HAS_RST                      => C_HAS_RST,
        C_HAS_UNDERFLOW                => C_HAS_UNDERFLOW,
        C_HAS_VALID                    => C_HAS_VALID,
        C_HAS_WR_ACK                   => C_HAS_WR_ACK,
        C_HAS_WR_DATA_COUNT            => C_HAS_WR_DATA_COUNT,
        C_MEMORY_TYPE                  => C_MEMORY_TYPE,
        C_OVERFLOW_LOW                 => C_OVERFLOW_LOW,
        C_PRELOAD_LATENCY              => C_PRELOAD_LATENCY,
        C_PRELOAD_REGS                 => C_PRELOAD_REGS,
        C_PROG_EMPTY_THRESH_ASSERT_VAL => C_PROG_EMPTY_THRESH_ASSERT_VAL,
        C_PROG_EMPTY_THRESH_NEGATE_VAL => C_PROG_EMPTY_THRESH_NEGATE_VAL,
        C_PROG_EMPTY_TYPE              => C_PROG_EMPTY_TYPE,
        C_PROG_FULL_THRESH_ASSERT_VAL  => C_PROG_FULL_THRESH_ASSERT_VAL,
        C_PROG_FULL_THRESH_NEGATE_VAL  => C_PROG_FULL_THRESH_NEGATE_VAL,
        C_PROG_FULL_TYPE               => C_PROG_FULL_TYPE,
        C_RD_DATA_COUNT_WIDTH          => C_RD_DATA_COUNT_WIDTH,
        C_RD_DEPTH                     => C_RD_DEPTH,
        C_RD_PNTR_WIDTH                => C_RD_PNTR_WIDTH,
        C_UNDERFLOW_LOW                => C_UNDERFLOW_LOW,
        C_USE_ECC                      => C_USE_ECC,
        C_USE_DOUT_RST                 => C_USE_DOUT_RST,
        C_USE_EMBEDDED_REG             => C_USE_EMBEDDED_REG,
        C_USE_FWFT_DATA_COUNT          => C_USE_FWFT_DATA_COUNT,
        C_VALID_LOW                    => C_VALID_LOW,
        C_WR_ACK_LOW                   => C_WR_ACK_LOW,
        C_WR_DATA_COUNT_WIDTH          => C_WR_DATA_COUNT_WIDTH,
        C_WR_DEPTH                     => C_WR_DEPTH,
        C_WR_PNTR_WIDTH                => C_WR_PNTR_WIDTH,
        C_TCQ                          => C_TCQ,
        C_ENABLE_RST_SYNC              => C_ENABLE_RST_SYNC,
        C_ERROR_INJECTION_TYPE         => C_ERROR_INJECTION_TYPE

        )
      PORT MAP(
        --Inputs
        WR_CLK                         => WR_CLK,
        RD_CLK                         => RD_CLK,
        RST                            => RST,
        WR_RST                         => WR_RST,
        RD_RST                         => RD_RST,
        DIN                            => DIN,
        WR_EN                          => WR_EN,
        RD_EN                          => rd_en_fifo_in,
        RD_EN_USER                     => RD_EN,
        PROG_FULL_THRESH               => PROG_FULL_THRESH,
        PROG_EMPTY_THRESH_ASSERT       => PROG_EMPTY_THRESH_ASSERT,
        PROG_EMPTY_THRESH_NEGATE       => PROG_EMPTY_THRESH_NEGATE,
        PROG_EMPTY_THRESH              => PROG_EMPTY_THRESH,
        PROG_FULL_THRESH_ASSERT        => PROG_FULL_THRESH_ASSERT,
        PROG_FULL_THRESH_NEGATE        => PROG_FULL_THRESH_NEGATE,
        INJECTDBITERR                  => INJECTDBITERR,
        INJECTSBITERR                  => INJECTSBITERR,
        USER_EMPTY_FB                  => empty_p0_out,

        --Outputs
        DOUT                           => dout_fifo_out,
        FULL                           => FULL_int,
        ALMOST_FULL                    => ALMOST_FULL,
        WR_ACK                         => WR_ACK,
        OVERFLOW                       => OVERFLOW,
        EMPTY                          => empty_fifo_out,
        ALMOST_EMPTY                   => almost_empty_fifo_out,
        VALID                          => valid_fifo_out,
        UNDERFLOW                      => underflow_fifo_out,
        RD_DATA_COUNT                  => rd_data_count_fifo_out,
        WR_DATA_COUNT                  => wr_data_count_fifo_out,
        PROG_FULL                      => PROG_FULL,
        PROG_EMPTY                     => PROG_EMPTY,
        DBITERR                        => dbiterr_fifo_out,
        SBITERR                        => sbiterr_fifo_out
        );

  END GENERATE gen_as;

-------------------------------------------------------------------------
-- Connect internal clock used for FWFT logic based on C_COMMON_CLOCK ---
-------------------------------------------------------------------------


  clock_fwft_common: IF (C_COMMON_CLOCK=1 ) GENERATE
     CLK_INT <= CLK;
  END GENERATE clock_fwft_common;

  clock_fwft: IF (C_COMMON_CLOCK= 0 ) GENERATE 
     CLK_INT <= RD_CLK; 
  END GENERATE clock_fwft; 


  -----------------------------------------------------------------------------
  -- Connect Internal Signals
  --  In the normal case, these signals tie directly to the FIFO's inputs and
  --  outputs.
  --  In the case of Preload Latency 0 or 1, these are the intermediate
  --  signals between the internal FIFO and the preload logic.
  -----------------------------------------------------------------------------
  latnrm: IF (C_PRELOAD_LATENCY=1 OR C_PRELOAD_LATENCY=2) GENERATE
     rd_en_fifo_in <= RD_EN;
     DOUT          <= dout_fifo_out;
     VALID         <= valid_fifo_out;
     EMPTY         <= empty_fifo_out;
     ALMOST_EMPTY  <= almost_empty_fifo_out;
     UNDERFLOW     <= underflow_fifo_out;
     RD_DATA_COUNT <= rd_data_count_fifo_out;
     WR_DATA_COUNT <= wr_data_count_fifo_out;
     SBITERR       <= sbiterr_fifo_out;
     DBITERR       <= dbiterr_fifo_out;
  END GENERATE latnrm;


  lat0: IF ((C_PRELOAD_REGS = 1) AND (C_PRELOAD_LATENCY = 0)) GENERATE

    rst_fwft <= RD_RST WHEN (C_ENABLE_RST_SYNC = 0) ELSE RST;

    lat0logic : fifo_generator_v5_3_bhv_preload0
      GENERIC MAP (
        C_DOUT_RST_VAL         => C_DOUT_RST_VAL,
        C_DOUT_WIDTH           => C_DOUT_WIDTH,
        C_HAS_RST              => C_HAS_RST,
        C_HAS_SRST             => C_HAS_SRST,
        C_USE_DOUT_RST         => C_USE_DOUT_RST,
        C_USE_ECC              => C_USE_ECC,
        C_USERVALID_LOW        => C_VALID_LOW,
        C_USERUNDERFLOW_LOW    => C_UNDERFLOW_LOW,
        C_ENABLE_RST_SYNC      => C_ENABLE_RST_SYNC,
        C_ERROR_INJECTION_TYPE => C_ERROR_INJECTION_TYPE,
        C_MEMORY_TYPE          => C_MEMORY_TYPE
        )
      PORT MAP (
        RD_CLK                 => CLK_INT,
        RD_RST                 => rst_fwft,
        SRST                   => SRST,
        RD_EN                  => RD_EN,
        FIFOEMPTY              => empty_fifo_out,
        FIFODATA               => dout_fifo_out,
        FIFOSBITERR            => sbiterr_fifo_out,
        FIFODBITERR            => dbiterr_fifo_out,
        USERDATA               => dout_p0_out,
        USERVALID              => valid_p0_out,
        USEREMPTY              => empty_p0_out,
        USERALMOSTEMPTY        => almost_empty_p0_out,
        USERUNDERFLOW          => underflow_p0_out,
        RAMVALID               => ram_valid, --Used for observing the state of the ram_valid
        FIFORDEN               => rd_en_fifo_in,
        USERSBITERR            => SBITERR,
        USERDBITERR            => DBITERR
        );

    rdcg: IF (C_USE_FWFT_DATA_COUNT=1 AND (C_RD_DATA_COUNT_WIDTH > C_RD_PNTR_WIDTH)) GENERATE
      eclk: PROCESS (CLK_INT)
      BEGIN  -- process eclk
        IF (rst_fwft='1') THEN
          empty_p0_out_q        <= '1' after C_TCQ;
          almost_empty_p0_out_q <= '1' after C_TCQ;
        ELSIF CLK_INT'event AND CLK_INT = '1' THEN  -- rising clock edge
          empty_p0_out_q        <= empty_p0_out after C_TCQ;
          almost_empty_p0_out_q <= almost_empty_p0_out after C_TCQ;
        END IF;
      END PROCESS eclk;

      rcsproc: PROCESS (rd_data_count_fifo_out, empty_p0_out_q, 
                        almost_empty_p0_out_q)
      BEGIN  -- process rcsproc
        IF (empty_p0_out_q='1' OR rst_fwft='1') THEN
          RD_DATA_COUNT <= int_2_std_logic_vector(0, C_RD_DATA_COUNT_WIDTH);
        ELSIF (almost_empty_p0_out_q='1') THEN
          RD_DATA_COUNT <= int_2_std_logic_vector(1, C_RD_DATA_COUNT_WIDTH);
        ELSE
          RD_DATA_COUNT <= rd_data_count_fifo_out ;
        END IF;
      END PROCESS rcsproc;

    END GENERATE rdcg;

    rdcg1: IF (C_USE_FWFT_DATA_COUNT=1 AND (C_RD_DATA_COUNT_WIDTH <= C_RD_PNTR_WIDTH)) GENERATE
      eclk1: PROCESS (CLK_INT)
      BEGIN  -- process eclk
        IF (rst_fwft='1') THEN
          empty_p0_out_q        <= '1' after C_TCQ;
          almost_empty_p0_out_q <= '1' after C_TCQ;
        ELSIF CLK_INT'event AND CLK_INT = '1' THEN  -- rising clock edge
          empty_p0_out_q        <= empty_p0_out after C_TCQ;
          almost_empty_p0_out_q <= almost_empty_p0_out after C_TCQ;
        END IF;
      END PROCESS eclk1;
 
      rcsproc1: PROCESS (rd_data_count_fifo_out, empty_p0_out_q,
                        almost_empty_p0_out_q)
      BEGIN  -- process rcsproc
        IF (empty_p0_out_q='1' OR rst_fwft='1') THEN
          RD_DATA_COUNT <= int_2_std_logic_vector(0, C_RD_DATA_COUNT_WIDTH);
        ELSIF (almost_empty_p0_out_q='1') THEN
          RD_DATA_COUNT <= int_2_std_logic_vector(0, C_RD_DATA_COUNT_WIDTH);
        ELSE
          RD_DATA_COUNT <= rd_data_count_fifo_out ;
        END IF;
      END PROCESS rcsproc1;
    END GENERATE rdcg1;

    nrdcg: IF (C_USE_FWFT_DATA_COUNT=0) GENERATE
      RD_DATA_COUNT <= rd_data_count_fifo_out;
    END GENERATE nrdcg;


    WR_DATA_COUNT <= wr_data_count_fifo_out;
    
    ---------------------------------------------------
    -- logics for common-clock data count with fwft
    --  For common-clock FIFOs with FWFT, data count
    -- is calculated as an up-down counter to maintain
    -- accuracy.
    ---------------------------------------------------
    
    gfwft_rd: IF (C_VALID_LOW = 0) GENERATE
      SS_FWFT_RD <= RD_EN AND valid_p0_out ;
    END GENERATE gfwft_rd;
    
    ngfwft_rd: IF (C_VALID_LOW = 1) GENERATE
      SS_FWFT_RD <= RD_EN AND NOT valid_p0_out ;
    END GENERATE ngfwft_rd;
    
    SS_FWFT_WR <= WR_EN AND (NOT FULL_int) ;  

  cc_data_cnt:  IF (C_HAS_DATA_COUNT = 1 AND C_USE_FWFT_DATA_COUNT = 1) GENERATE
     count_fwft: PROCESS (CLK, RST)
      BEGIN
        IF (RST = '1' AND C_HAS_RST=1) THEN
           DATA_COUNT_FWFT <= (OTHERS=>'0') after C_TCQ;
        ELSIF CLK'event AND CLK = '1' THEN
          IF (SRST='1' AND C_HAS_SRST=1) THEN
            DATA_COUNT_FWFT <= (OTHERS=>'0') after C_TCQ;
          ELSE
            IF (SS_FWFT_WR = '0' and SS_FWFT_RD ='0')  THEN
               DATA_COUNT_FWFT <= DATA_COUNT_FWFT after C_TCQ;
            ELSIF (SS_FWFT_WR = '0' and SS_FWFT_RD ='1')  THEN
               DATA_COUNT_FWFT <= DATA_COUNT_FWFT - 1 after C_TCQ;
            ELSIF (SS_FWFT_WR = '1' and SS_FWFT_RD ='0')  THEN
                DATA_COUNT_FWFT <= DATA_COUNT_FWFT + 1 after C_TCQ;
            ELSE
               DATA_COUNT_FWFT <= DATA_COUNT_FWFT after C_TCQ;
            END IF ;
          END IF;
        END IF;
      END PROCESS count_fwft;
  END GENERATE cc_data_cnt;

----------------------------------------------

    DOUT          <= dout_p0_out;
    VALID         <= valid_p0_out;
    EMPTY         <= empty_p0_out;
    ALMOST_EMPTY  <= almost_empty_p0_out;
    UNDERFLOW     <= underflow_p0_out;

  END GENERATE lat0;


  gdc_fwft: IF (C_HAS_DATA_COUNT = 1) GENERATE
  begin 
    ss_count:  IF ((NOT ((C_PRELOAD_REGS = 1) AND (C_PRELOAD_LATENCY = 0)) ) OR
                   (C_USE_FWFT_DATA_COUNT = 0) )GENERATE
    begin  
      DATA_COUNT   <= data_count_fifo_out ;
    end generate ss_count ;
  
    ss_count_fwft1:  IF ((C_PRELOAD_REGS = 1) AND (C_PRELOAD_LATENCY = 0) AND
                         (C_DATA_COUNT_WIDTH > C_RD_PNTR_WIDTH) AND
                         (C_USE_FWFT_DATA_COUNT = 1) ) GENERATE 
    begin 
      DATA_COUNT   <= DATA_COUNT_FWFT(C_RD_PNTR_WIDTH DOWNTO 0) ;
    end generate ss_count_fwft1 ;
  
    ss_count_fwft2:  IF ((C_PRELOAD_REGS = 1) AND (C_PRELOAD_LATENCY = 0) AND
                         (C_DATA_COUNT_WIDTH <= C_RD_PNTR_WIDTH)  AND
                         (C_USE_FWFT_DATA_COUNT = 1)) GENERATE
    begin  
      DATA_COUNT   <= DATA_COUNT_FWFT(C_RD_PNTR_WIDTH  DOWNTO C_RD_PNTR_WIDTH-C_DATA_COUNT_WIDTH+1) ;
    end generate ss_count_fwft2 ;
  end generate gdc_fwft;

  FULL <= FULL_int;


END behavioral;
