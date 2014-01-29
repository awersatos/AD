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
--
-------------------------------------------------------------------------------
--
-- Filename: BLK_MEM_GEN_V4_1.vhd
--
-- Description:
--   This file is the VHDL behvarial model for the
--       Block Memory Generator Core.
--
-------------------------------------------------------------------------------
-- Author: Xilinx
--
-- History: January 11, 2006: Initial revision
--          June 11, 2007   : Added independent register stages for 
--                            Port A and Port B (IP1_Jm/v2.5)
--          August 28, 2007 : Added mux pipeline stages feature (IP2_Jm/v2.6)
--          April 07, 2009  : Added support for Spartan-6 and Virtex-6
--                            features, including the following:
--                            (i)   error injection, detection and/or correction
--                            (ii) reset priority
--                            (iii)  special reset behavior
--    
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Output Register Stage Entity
-- 
-- This module builds the output register stages of the memory. This module is 
-- instantiated in the main memory module (BLK_MEM_GEN_V4_1) which is
-- declared/implemented further down in this file.
-------------------------------------------------------------------------------

LIBRARY STD;
USE STD.TEXTIO.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BLK_MEM_GEN_V4_1_output_stage IS
GENERIC (
  C_FAMILY                 : STRING  := "virtex5";
  C_XDEVICEFAMILY          : STRING  := "virtex5";
  C_RST_TYPE               : STRING  := "SYNC";
  C_HAS_RST                : INTEGER := 0;
  C_RSTRAM                 : INTEGER := 0;
  C_RST_PRIORITY           : STRING  := "CE";
  init_val                 : STD_LOGIC_VECTOR;
  C_HAS_EN                 : INTEGER := 0;
  C_HAS_REGCE              : INTEGER := 0;
  C_DATA_WIDTH             : INTEGER := 32;
  C_ADDRB_WIDTH            : INTEGER := 10;
  C_HAS_MEM_OUTPUT_REGS    : INTEGER := 0;
  C_USE_SOFTECC            : INTEGER := 0;
  C_USE_ECC                : INTEGER := 0;
  NUM_STAGES               : INTEGER := 1;
  FLOP_DELAY               : TIME    := 100 ps
);
PORT (
  CLK          : IN  STD_LOGIC;
  RST          : IN  STD_LOGIC;
  EN           : IN  STD_LOGIC;
  REGCE        : IN  STD_LOGIC;
  DIN          : IN  STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
  DOUT         : OUT STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
  SBITERR_IN   : IN  STD_LOGIC;
  DBITERR_IN   : IN  STD_LOGIC;
  SBITERR      : OUT STD_LOGIC;
  DBITERR      : OUT STD_LOGIC;
  RDADDRECC_IN : IN STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);
  RDADDRECC    : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
);
END BLK_MEM_GEN_V4_1_output_stage;
--******************************
-- Port and Generic Definitions
--******************************
  ---------------------------------------------------------------------------
  -- Generic Definitions
  ---------------------------------------------------------------------------
  -- C_FAMILY,C_XDEVICEFAMILY: Designates architecture targeted. The following
  --                           options are available - "spartan3", "spartan6", 
  --                           "virtex4", "virtex5", "virtex6" and "virtex6l".
  -- C_RST_TYPE              : Type of reset - Synchronous or Asynchronous
  -- C_HAS_RST               : Determines the presence of the RST port
  -- C_RSTRAM                : Determines if special reset behavior is used
  -- C_RST_PRIORITY          : Determines the priority between CE and SR
  -- C_INIT_VAL              : Initialization value
  -- C_HAS_EN                : Determines the presence of the EN port
  -- C_HAS_REGCE             : Determines the presence of the REGCE port
  -- C_DATA_WIDTH            : Memory write/read width
  -- C_ADDRB_WIDTH           : Width of the ADDRB input port
  -- C_HAS_MEM_OUTPUT_REGS   : Designates the use of a register at the output 
  --                           of the RAM primitive
  -- C_USE_SOFTECC           : Determines if the Soft ECC feature is used or
  --                           not. Only applicable Spartan-6
  -- C_USE_ECC               : Determines if the ECC feature is used or
  --                           not. Only applicable for V5 and V6
  -- NUM_STAGES              : Determines the number of output stages
  -- FLOP_DELAY              : Constant delay for register assignments
  ---------------------------------------------------------------------------
  -- Port Definitions
  ---------------------------------------------------------------------------
  -- CLK    : Clock to synchronize all read and write operations
  -- RST    : Reset input to reset memory outputs to a user-defined 
  --           reset state
  -- EN     : Enable all read and write operations
  -- REGCE  : Register Clock Enable to control each pipeline output
  --           register stages
  -- DIN    : Data input to the Output stage.
  -- DOUT   : Final Data output
  -- SBITERR_IN    : SBITERR input signal to the Output stage.
  -- SBITERR       : Final SBITERR Output signal.
  -- DBITERR_IN    : DBITERR input signal to the Output stage.
  -- DBITERR       : Final DBITERR Output signal.
  -- RDADDRECC_IN  : RDADDRECC input signal to the Output stage.
  -- RDADDRECC     : Final RDADDRECC Output signal.
  ---------------------------------------------------------------------------

ARCHITECTURE output_stage_behavioral OF BLK_MEM_GEN_V4_1_output_stage IS

  --*******************************************************
  -- Functions used in the output stage ARCHITECTURE
  --*******************************************************
  -- Calculate num_reg_stages 
  FUNCTION get_num_reg_stages(NUM_STAGES: INTEGER) RETURN INTEGER IS
    VARIABLE num_reg_stages : INTEGER := 0;
  BEGIN
    IF (NUM_STAGES = 0) THEN
      num_reg_stages := 0;
    ELSE
      num_reg_stages := NUM_STAGES - 1;
    END IF;
    RETURN num_reg_stages;
  END get_num_reg_stages;

  -- Check if the INTEGER is zero or non-zero
  FUNCTION int_to_bit(input: INTEGER) RETURN STD_LOGIC IS
    VARIABLE temp_return : STD_LOGIC;
  BEGIN
    IF (input = 0) THEN
      temp_return := '0';
    ELSE
      temp_return := '1';
    END IF;
    RETURN temp_return;
  END int_to_bit;

  -- Constants
  CONSTANT HAS_EN     : STD_LOGIC := int_to_bit(C_HAS_EN);
  CONSTANT HAS_REGCE  : STD_LOGIC := int_to_bit(C_HAS_REGCE);
  CONSTANT HAS_RST    : STD_LOGIC := int_to_bit(C_HAS_RST);

  CONSTANT REG_STAGES : INTEGER   := get_num_reg_stages(NUM_STAGES);

 -- Pipeline array
  TYPE reg_data_array IS ARRAY (REG_STAGES-1 DOWNTO 0) OF STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
  TYPE reg_ecc_array IS ARRAY (REG_STAGES-1 DOWNTO 0) OF  STD_LOGIC;
  TYPE reg_eccaddr_array IS ARRAY (REG_STAGES-1 DOWNTO 0) OF STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);

  CONSTANT REG_INIT      : reg_data_array := (OTHERS => init_val);
  SIGNAL   out_regs      : reg_data_array := REG_INIT;
  SIGNAL   sbiterr_regs  : reg_ecc_array  := (OTHERS => '0');
  SIGNAL   dbiterr_regs  : reg_ecc_array  := (OTHERS => '0');
  SIGNAL   rdaddrecc_regs: reg_eccaddr_array := (OTHERS => (OTHERS => '0'));

  -- Internal signals
  SIGNAL en_i     : STD_LOGIC;
  SIGNAL regce_i  : STD_LOGIC;
  SIGNAL rst_i    : STD_LOGIC;

  SIGNAL dout_i   : STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0) := init_val;
  SIGNAL sbiterr_i: STD_LOGIC := '0';
  SIGNAL dbiterr_i: STD_LOGIC := '0';
  SIGNAL rdaddrecc_i : STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0) := (OTHERS => '0');

BEGIN

  --***********************************************************************
  -- Assign internal signals. This effectively wires off optional inputs.
  --***********************************************************************

  -- Internal enable for output registers is tied to user EN or '1' depending
  -- on parameters
  en_i    <= EN OR (NOT HAS_EN);

  -- Internal register enable for output registers is tied to user REGCE, EN
  -- or '1' depending on parameters
  regce_i <= (HAS_REGCE AND REGCE)
             OR ((NOT HAS_REGCE) AND en_i);

  -- Internal SRR is tied to user RST or '0' depending on parameters
  rst_i   <= RST AND HAS_RST;

  --***************************************************************************
  -- NUM_STAGES = 0 (No output registers. RAM only)
  --***************************************************************************
  zero_stages: IF (NUM_STAGES = 0) GENERATE
    DOUT    <= DIN;
    SBITERR <= SBITERR_IN;
    DBITERR <= DBITERR_IN;
    RDADDRECC <= RDADDRECC_IN;
  END GENERATE zero_stages;

  --***************************************************************************
  -- NUM_STAGES = 1 
  -- (Mem Output Reg only or Mux Output Reg only)
  --***************************************************************************

  -- Possible valid combinations: 
  -- Note: C_HAS_MUX_OUTPUT_REGS_*=0 when (C_RSTRAM_*=1)
  --   +-----------------------------------------+
  --   |   C_RSTRAM_*   |  Reset Behavior        |
  --   +----------------+------------------------+
  --   |       0        |   Normal Behavior      |
  --   +----------------+------------------------+
  --   |       1        |  Special Behavior      |
  --   +----------------+------------------------+
  --
  -- Normal = REGCE gates reset, as in the case of all Virtex families and all
  -- spartan families with the exception of S3ADSP and S6.
  -- Special = EN gates reset, as in the case of S3ADSP and S6.

  one_stage_norm: IF (NUM_STAGES = 1 AND 
               (C_RSTRAM=0 OR (C_RSTRAM=1 AND (C_XDEVICEFAMILY/="spartan3adsp" AND C_XDEVICEFAMILY/="aspartan3adsp")) OR
                C_HAS_MEM_OUTPUT_REGS=0 OR C_HAS_RST=0)) GENERATE
    DOUT <= dout_i;
    SBITERR <= sbiterr_i WHEN (C_USE_ECC=1 OR C_USE_SOFTECC = 1) ELSE '0';
    DBITERR <= dbiterr_i WHEN (C_USE_ECC=1 OR C_USE_SOFTECC = 1) ELSE '0';
    RDADDRECC <= rdaddrecc_i WHEN ((C_USE_ECC=1 AND (C_FAMILY="virtex6")) OR C_USE_SOFTECC = 1) ELSE (OTHERS => '0');

    PROCESS (CLK,rst_i,regce_i)
    BEGIN
      IF ((C_FAMILY = "spartan6") AND C_RST_TYPE = "ASYNC") THEN --Asynchronous Reset
          IF(C_RST_PRIORITY = "CE") THEN  --REGCE has priority and controls reset
            IF (rst_i = '1' AND regce_i='1') THEN
              dout_i <= init_val;
            ELSIF (CLK'EVENT AND CLK = '1') THEN
              IF (regce_i='1') THEN
                dout_i <= DIN AFTER FLOP_DELAY;
              END IF;
            END IF;--CLK
          ELSE                    --RSTA has priority and is independent of REGCE
            IF (rst_i = '1') THEN         
              dout_i <= init_val;
            ELSIF (CLK'EVENT AND CLK = '1') THEN
              IF (regce_i='1') THEN
                dout_i <= DIN AFTER FLOP_DELAY;
              END IF;
            END IF;--CLK
          END IF;--Priority conditions
      ELSE --Synchronous Reset
        IF (CLK'EVENT AND CLK = '1') THEN
          IF(C_RST_PRIORITY = "CE") THEN  --REGCE has priority and controls reset
            IF (rst_i = '1' AND regce_i='1') THEN
              dout_i <= init_val AFTER FLOP_DELAY;
              sbiterr_i <= '0' AFTER FLOP_DELAY;
              dbiterr_i <= '0' AFTER FLOP_DELAY;
              rdaddrecc_i <= (OTHERS => '0') AFTER FLOP_DELAY;
            ELSIF (regce_i='1') THEN
              dout_i <= DIN AFTER FLOP_DELAY;
              sbiterr_i <= SBITERR_IN AFTER FLOP_DELAY;
              dbiterr_i <= DBITERR_IN AFTER FLOP_DELAY;
              rdaddrecc_i <= RDADDRECC_IN AFTER FLOP_DELAY;
            END IF;
          ELSE                    --RSTA has priority and is independent of REGCE
            IF (rst_i = '1') THEN         
              dout_i <= init_val AFTER FLOP_DELAY;
              sbiterr_i <= '0' AFTER FLOP_DELAY;
              dbiterr_i <= '0' AFTER FLOP_DELAY;
              rdaddrecc_i <= (OTHERS => '0') AFTER FLOP_DELAY;
            ELSIF (regce_i='1') THEN
              dout_i <= DIN AFTER FLOP_DELAY;
              sbiterr_i <= SBITERR_IN AFTER FLOP_DELAY;
              dbiterr_i <= DBITERR_IN AFTER FLOP_DELAY;
              rdaddrecc_i <= RDADDRECC_IN AFTER FLOP_DELAY;
            END IF;
          END IF;--Priority conditions
        END IF;--CLK
      END IF;--RST TYPE
    END PROCESS;
  END GENERATE one_stage_norm;

  -- Special Reset Behavior for S6 and S3ADSP
  one_stage_splbhv: IF (NUM_STAGES=1 AND C_RSTRAM=1 AND (C_XDEVICEFAMILY ="spartan3adsp" OR C_XDEVICEFAMILY ="aspartan3adsp")) 
  GENERATE
  
    DOUT <= dout_i;
    SBITERR <= '0';
    DBITERR <= '0';
    RDADDRECC <= (OTHERS => '0');

    PROCESS (CLK)
    BEGIN
      IF (CLK'EVENT AND CLK = '1') THEN
        IF (rst_i='1' AND en_i='1') THEN
          dout_i <= init_val AFTER FLOP_DELAY;
        ELSIF (regce_i='1' AND rst_i/='1') THEN
           dout_i <= DIN AFTER FLOP_DELAY;
        END IF;
      END IF;--CLK
    END PROCESS;
  END GENERATE one_stage_splbhv;

 --****************************************************************************
 -- NUM_STAGES > 1 
 -- Mem Output Reg + Mux Output Reg
 --              or 
 -- Mem Output Reg + Mux Pipeline Stages (>0) + Mux Output Reg
 --              or 
 -- Mux Pipeline Stages (>0) + Mux Output Reg
 --****************************************************************************
  multi_stage: IF (NUM_STAGES > 1) GENERATE
    DOUT <= dout_i;
    SBITERR <= sbiterr_i;
    DBITERR <= dbiterr_i;
    RDADDRECC <= rdaddrecc_i;

    PROCESS (CLK,rst_i,regce_i)
    BEGIN
      IF ((C_FAMILY = "spartan6") AND C_RST_TYPE = "ASYNC") THEN --Asynchronous Reset
          IF(C_RST_PRIORITY = "CE") THEN  --REGCE has priority and controls reset
            IF (rst_i = '1' AND regce_i='1') THEN
              dout_i <= init_val;
            ELSIF (CLK'EVENT AND CLK = '1') THEN
              IF (regce_i='1') THEN
                dout_i    <= out_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              END IF;
            END IF;--CLK
          ELSE                    --RSTA has priority and is independent of REGCE
            IF (rst_i = '1') THEN         
              dout_i <= init_val;
            ELSIF (CLK'EVENT AND CLK = '1') THEN
              IF (regce_i='1') THEN
                dout_i    <= out_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              END IF;
            END IF;--CLK
          END IF;--Priority conditions
          IF (CLK'EVENT AND CLK = '1') THEN
            IF (en_i='1') THEN
              -- Shift the data through the output stages
              FOR i IN 1 TO REG_STAGES-1 LOOP
                out_regs(i) <= out_regs(i-1);
              END LOOP;
              out_regs(0) <= DIN;
            END IF;
          END IF;
      ELSE --Synchronous Reset
        IF (CLK'EVENT AND CLK = '1') THEN
          IF(C_RST_PRIORITY = "CE") THEN  --REGCE has priority and controls reset
            IF (rst_i='1'AND regce_i='1') THEN
              dout_i    <= init_val AFTER FLOP_DELAY;
              sbiterr_i <= '0' AFTER FLOP_DELAY;
              dbiterr_i <= '0' AFTER FLOP_DELAY;
              rdaddrecc_i <= (OTHERS => '0') AFTER FLOP_DELAY;
            ELSIF (regce_i='1') THEN
              dout_i    <= out_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              sbiterr_i <= sbiterr_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              dbiterr_i <= dbiterr_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              rdaddrecc_i <= rdaddrecc_regs(REG_STAGES-1) AFTER FLOP_DELAY;
            END IF;
          ELSE                    --RSTA has priority and is independent of REGCE
            IF (rst_i = '1') THEN         
              dout_i    <= init_val AFTER FLOP_DELAY;
              sbiterr_i <= '0' AFTER FLOP_DELAY;
              dbiterr_i <= '0' AFTER FLOP_DELAY;
              rdaddrecc_i <= (OTHERS => '0') AFTER FLOP_DELAY;
            ELSIF (regce_i='1') THEN
              dout_i    <= out_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              sbiterr_i <= sbiterr_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              dbiterr_i <= dbiterr_regs(REG_STAGES-1) AFTER FLOP_DELAY;
              rdaddrecc_i <= rdaddrecc_regs(REG_STAGES-1) AFTER FLOP_DELAY;
            END IF;
          END IF;--Priority conditions
          
          IF (en_i='1') THEN
            -- Shift the data through the output stages
            FOR i IN 1 TO REG_STAGES-1 LOOP
              out_regs(i) <= out_regs(i-1) AFTER FLOP_DELAY;
              sbiterr_regs(i) <= sbiterr_regs(i-1) AFTER FLOP_DELAY;
              dbiterr_regs(i) <= dbiterr_regs(i-1) AFTER FLOP_DELAY;
              rdaddrecc_regs(i) <= rdaddrecc_regs(i-1) AFTER FLOP_DELAY;
            END LOOP;
            out_regs(0) <= DIN;
            sbiterr_regs(0) <= SBITERR_IN;
            dbiterr_regs(0) <= DBITERR_IN;
            rdaddrecc_regs(0) <= RDADDRECC_IN;
          END IF;
          
        END IF;--CLK
      END IF;--RST TYPE
    END PROCESS;
    
  END GENERATE multi_stage;

END output_stage_behavioral;

-------------------------------------------------------------------------------
-- SoftECC Output Register Stage Entity
-- This module builds the softecc output register stages. This module is 
-- instantiated in the memory module (BLK_MEM_GEN_V4_1_mem_module) which is
-- declared/implemented further down in this file.
-------------------------------------------------------------------------------

LIBRARY STD;
USE STD.TEXTIO.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BLK_MEM_GEN_V4_1_softecc_output_reg_stage IS
GENERIC (
  C_DATA_WIDTH                : INTEGER := 32;
  C_ADDRB_WIDTH               : INTEGER := 10;
  C_HAS_SOFTECC_OUTPUT_REGS_A : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_B : INTEGER := 0;
  C_USE_SOFTECC               : INTEGER := 0;
  FLOP_DELAY                  : TIME    := 100 ps
);
PORT (
  CLK          : IN  STD_LOGIC;
  DIN          : IN  STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0) ;
  DOUT         : OUT STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
  SBITERR_IN   : IN  STD_LOGIC;
  DBITERR_IN   : IN  STD_LOGIC;
  SBITERR      : OUT STD_LOGIC;
  DBITERR      : OUT STD_LOGIC;
  RDADDRECC_IN : IN STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0) ;
  RDADDRECC    : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
);
END BLK_MEM_GEN_V4_1_softecc_output_reg_stage;
--******************************
-- Port and Generic Definitions
--******************************
  ---------------------------------------------------------------------------
  -- Generic Definitions
  ---------------------------------------------------------------------------
  -- C_DATA_WIDTH            : Memory write/read width
  -- C_ADDRB_WIDTH           : Width of the ADDRB input port
  --                           of the RAM primitive
  -- FLOP_DELAY              : Constant delay for register assignments
  ---------------------------------------------------------------------------
  -- Port Definitions
  ---------------------------------------------------------------------------
  -- CLK    : Clock to synchronize all read and write operations
  -- RST    : Reset input to reset memory outputs to a user-defined 
  --           reset state
  -- EN     : Enable all read and write operations
  -- REGCE  : Register Clock Enable to control each pipeline output
  --           register stages
  -- DIN    : Data input to the Output stage.
  -- DOUT   : Final Data output
  -- SBITERR_IN    : SBITERR input signal to the Output stage.
  -- SBITERR       : Final SBITERR Output signal.
  -- DBITERR_IN    : DBITERR input signal to the Output stage.
  -- DBITERR       : Final DBITERR Output signal.
  -- RDADDRECC_IN  : RDADDRECC input signal to the Output stage.
  -- RDADDRECC     : Final RDADDRECC Output signal.
  ---------------------------------------------------------------------------

ARCHITECTURE softecc_output_reg_stage_behavioral OF BLK_MEM_GEN_V4_1_softecc_output_reg_stage IS

  -- Internal signals
  SIGNAL dout_i   : STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sbiterr_i: STD_LOGIC := '0';
  SIGNAL dbiterr_i: STD_LOGIC := '0';
  SIGNAL rdaddrecc_i : STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0) := (OTHERS => '0');

BEGIN

  --***************************************************************************
  -- NO OUTPUT STAGES
  --***************************************************************************
  no_output_stage: IF (C_HAS_SOFTECC_OUTPUT_REGS_B=0) GENERATE
    DOUT    <= DIN;
    SBITERR <= SBITERR_IN;
    DBITERR <= DBITERR_IN;
    RDADDRECC <= RDADDRECC_IN;
  END GENERATE no_output_stage;

 --****************************************************************************
 -- WITH OUTPUT STAGE
 --****************************************************************************
  has_output_stage: IF (C_HAS_SOFTECC_OUTPUT_REGS_B=1) GENERATE
    PROCESS (CLK)
    BEGIN
       IF (CLK'EVENT AND CLK = '1') THEN
           dout_i    <= DIN AFTER FLOP_DELAY;
           sbiterr_i <= SBITERR_IN AFTER FLOP_DELAY;
           dbiterr_i <= DBITERR_IN AFTER FLOP_DELAY;
           rdaddrecc_i <= RDADDRECC_IN AFTER FLOP_DELAY;

       END IF;
     
    END PROCESS;
    
           DOUT <= dout_i;
           SBITERR <= sbiterr_i;
           DBITERR <= dbiterr_i;
           RDADDRECC <= rdaddrecc_i;

  END GENERATE has_output_stage;

END softecc_output_reg_stage_behavioral;

--******************************************************************************
-- Main Memory module
--
-- This module is the behavioral model which implements the RAM 
--******************************************************************************
LIBRARY STD;
USE STD.TEXTIO.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BLK_MEM_GEN_V4_1_mem_module IS
GENERIC (
  C_CORENAME                : STRING  := "blk_mem_gen_v4_1";
  C_FAMILY                  : STRING  := "virtex6";
  C_XDEVICEFAMILY           : STRING  := "virtex6";
  C_MEM_TYPE                : INTEGER := 2;
  C_BYTE_SIZE               : INTEGER := 8;
  C_ALGORITHM               : INTEGER := 2;
  C_PRIM_TYPE               : INTEGER := 3;
  C_LOAD_INIT_FILE          : INTEGER := 0;
  C_INIT_FILE_NAME          : STRING  := "";
  C_USE_DEFAULT_DATA        : INTEGER := 0;
  C_DEFAULT_DATA            : STRING  := "";
  C_RST_TYPE                : STRING  := "SYNC";
  C_HAS_RSTA                : INTEGER := 0;
  C_RST_PRIORITY_A          : STRING  := "CE";
  C_RSTRAM_A                : INTEGER := 0;
  C_INITA_VAL               : STRING  := "";
  C_HAS_ENA                 : INTEGER := 1;
  C_HAS_REGCEA              : INTEGER := 0;
  C_USE_BYTE_WEA            : INTEGER := 0;
  C_WEA_WIDTH               : INTEGER := 1;
  C_WRITE_MODE_A            : STRING  := "WRITE_FIRST";
  C_WRITE_WIDTH_A           : INTEGER := 32;
  C_READ_WIDTH_A            : INTEGER := 32;
  C_WRITE_DEPTH_A           : INTEGER := 64;
  C_READ_DEPTH_A            : INTEGER := 64;
  C_ADDRA_WIDTH             : INTEGER := 6;
  C_HAS_RSTB                : INTEGER := 0;
  C_RST_PRIORITY_B          : STRING  := "CE";
  C_RSTRAM_B                : INTEGER := 0;
  C_INITB_VAL               : STRING  := "";
  C_HAS_ENB                 : INTEGER := 1;
  C_HAS_REGCEB              : INTEGER := 0;
  C_USE_BYTE_WEB            : INTEGER := 0;
  C_WEB_WIDTH               : INTEGER := 1;
  C_WRITE_MODE_B            : STRING  := "WRITE_FIRST";
  C_WRITE_WIDTH_B           : INTEGER := 32;
  C_READ_WIDTH_B            : INTEGER := 32;
  C_WRITE_DEPTH_B           : INTEGER := 64;
  C_READ_DEPTH_B            : INTEGER := 64;
  C_ADDRB_WIDTH             : INTEGER := 6;
  C_HAS_MEM_OUTPUT_REGS_A   : INTEGER := 0;
  C_HAS_MEM_OUTPUT_REGS_B   : INTEGER := 0;
  C_HAS_MUX_OUTPUT_REGS_A   : INTEGER := 0;
  C_HAS_MUX_OUTPUT_REGS_B   : INTEGER := 0;
  C_HAS_SOFTECC_INPUT_REGS_A  : INTEGER := 0;
  C_HAS_SOFTECC_INPUT_REGS_B  : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_A : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_B : INTEGER := 0;
  C_MUX_PIPELINE_STAGES     : INTEGER := 0;
  C_USE_SOFTECC             : INTEGER := 0;
  C_USE_ECC                 : INTEGER := 0;
  C_HAS_INJECTERR           : INTEGER := 0;
  C_SIM_COLLISION_CHECK     : STRING  := "NONE";
  C_COMMON_CLK              : INTEGER := 1;
  FLOP_DELAY                : TIME    := 100 ps;
  C_DISABLE_WARN_BHV_COLL   : INTEGER := 0;
  C_DISABLE_WARN_BHV_RANGE  : INTEGER := 0
);
PORT (
  CLKA          : IN  STD_LOGIC;
  RSTA          : IN  STD_LOGIC := '0';
  ENA           : IN  STD_LOGIC := '1';
  REGCEA        : IN  STD_LOGIC := '1';
  WEA           : IN  STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  ADDRA         : IN  STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
  DINA          : IN  STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0)
                      := (OTHERS => '0');
  DOUTA         : OUT STD_LOGIC_VECTOR(C_READ_WIDTH_A-1 DOWNTO 0);
  CLKB          : IN  STD_LOGIC := '0';
  RSTB          : IN  STD_LOGIC := '0';
  ENB           : IN  STD_LOGIC := '1';
  REGCEB        : IN  STD_LOGIC := '1';
  WEB           : IN  STD_LOGIC_VECTOR(C_WEB_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  ADDRB         : IN  STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  DINB          : IN  STD_LOGIC_VECTOR(C_WRITE_WIDTH_B-1 DOWNTO 0)
                      := (OTHERS => '0');
  DOUTB         : OUT STD_LOGIC_VECTOR(C_READ_WIDTH_B-1 DOWNTO 0);
  INJECTSBITERR : IN STD_LOGIC := '0';
  INJECTDBITERR : IN STD_LOGIC := '0';
  SBITERR       : OUT STD_LOGIC;
  DBITERR       : OUT STD_LOGIC;
  RDADDRECC     : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
);
END BLK_MEM_GEN_V4_1_mem_module;
--******************************
-- Port and Generic Definitions
--******************************
  ---------------------------------------------------------------------------
  -- Generic Definitions
  ---------------------------------------------------------------------------
  -- C_CORENAME              : Instance name of the Block Memory Generator core
  -- C_FAMILY,C_XDEVICEFAMILY: Designates architecture targeted. The following
  --                           options are available - "spartan3", "spartan6", 
  --                           "virtex4", "virtex5", "virtex6l" and "virtex6".
  -- C_MEM_TYPE              : Designates memory type.
  --                           It can be
  --                           0 - Single Port Memory
  --                           1 - Simple Dual Port Memory
  --                           2 - True Dual Port Memory
  --                           3 - Single Port Read Only Memory
  --                           4 - Dual Port Read Only Memory
  -- C_BYTE_SIZE             : Size of a byte (8 or 9 bits)
  -- C_ALGORITHM             : Designates the algorithm method used
  --                           for constructing the memory.
  --                           It can be Fixed_Primitives, Minimum_Area or 
  --                           Low_Power
  -- C_PRIM_TYPE             : Designates the user selected primitive used to 
  --                           construct the memory.
  --
  -- C_LOAD_INIT_FILE        : Designates the use of an initialization file to
  --                           initialize memory contents.
  -- C_INIT_FILE_NAME        : Memory initialization file name.
  -- C_USE_DEFAULT_DATA      : Designates whether to fill remaining
  --                           initialization space with default data
  -- C_DEFAULT_DATA          : Default value of all memory locations
  --                           not initialized by the memory
  --                           initialization file.
  -- C_RST_TYPE              : Type of reset - Synchronous or Asynchronous
  --
  -- C_HAS_RSTA              : Determines the presence of the RSTA port
  -- C_RST_PRIORITY_A        : Determines the priority between CE and SR for 
  --                           Port A.
  -- C_RSTRAM_A              : Determines if special reset behavior is used for
  --                           Port A
  -- C_INITA_VAL             : The initialization value for Port A
  -- C_HAS_ENA               : Determines the presence of the ENA port
  -- C_HAS_REGCEA            : Determines the presence of the REGCEA port
  -- C_USE_BYTE_WEA          : Determines if the Byte Write is used or not.
  -- C_WEA_WIDTH             : The width of the WEA port
  -- C_WRITE_MODE_A          : Configurable write mode for Port A. It can be
  --                           WRITE_FIRST, READ_FIRST or NO_CHANGE.
  -- C_WRITE_WIDTH_A         : Memory write width for Port A.
  -- C_READ_WIDTH_A          : Memory read width for Port A.
  -- C_WRITE_DEPTH_A         : Memory write depth for Port A.
  -- C_READ_DEPTH_A          : Memory read depth for Port A.
  -- C_ADDRA_WIDTH           : Width of the ADDRA input port
  -- C_HAS_RSTB              : Determines the presence of the RSTB port
  -- C_RST_PRIORITY_B        : Determines the priority between CE and SR for 
  --                           Port B.
  -- C_RSTRAM_B              : Determines if special reset behavior is used for
  --                           Port B
  -- C_INITB_VAL             : The initialization value for Port B
  -- C_HAS_ENB               : Determines the presence of the ENB port
  -- C_HAS_REGCEB            : Determines the presence of the REGCEB port
  -- C_USE_BYTE_WEB          : Determines if the Byte Write is used or not.
  -- C_WEB_WIDTH             : The width of the WEB port
  -- C_WRITE_MODE_B          : Configurable write mode for Port B. It can be
  --                           WRITE_FIRST, READ_FIRST or NO_CHANGE.
  -- C_WRITE_WIDTH_B         : Memory write width for Port B.
  -- C_READ_WIDTH_B          : Memory read width for Port B.
  -- C_WRITE_DEPTH_B         : Memory write depth for Port B.
  -- C_READ_DEPTH_B          : Memory read depth for Port B.
  -- C_ADDRB_WIDTH           : Width of the ADDRB input port
  -- C_HAS_MEM_OUTPUT_REGS_A : Designates the use of a register at the output 
  --                           of the RAM primitive for Port A.
  -- C_HAS_MEM_OUTPUT_REGS_B : Designates the use of a register at the output 
  --                           of the RAM primitive for Port B.
  -- C_HAS_MUX_OUTPUT_REGS_A : Designates the use of a register at the output
  --                           of the MUX for Port A.
  -- C_HAS_MUX_OUTPUT_REGS_B : Designates the use of a register at the output
  --                           of the MUX for Port B.
  -- C_MUX_PIPELINE_STAGES   : Designates the number of pipeline stages in 
  --                           between the muxes.
  -- C_USE_SOFTECC           : Determines if the Soft ECC feature is used or
  --                           not. Only applicable Spartan-6
  -- C_USE_ECC               : Determines if the ECC feature is used or
  --                           not. Only applicable for V5 and V6
  -- C_HAS_INJECTERR         : Determines if the error injection pins
  --                           are present or not. If the ECC feature
  --                           is not used, this value is defaulted to
  --                           0, else the following are the allowed 
  --                           values:
  --                         0 : No INJECTSBITERR or INJECTDBITERR pins
  --                         1 : Only INJECTSBITERR pin exists
  --                         2 : Only INJECTDBITERR pin exists
  --                         3 : Both INJECTSBITERR and INJECTDBITERR pins exist
  -- C_SIM_COLLISION_CHECK   : Controls the disabling of Unisim model collision
  --                           warnings. It can be "ALL", "NONE", 
  --                           "Warnings_Only" or "Generate_X_Only".
  -- C_COMMON_CLK            : Determins if the core has a single CLK input.
  -- C_DISABLE_WARN_BHV_COLL : Controls the Behavioral Model Collision warnings
  -- C_DISABLE_WARN_BHV_RANGE: Controls the Behavioral Model Out of Range 
  --                           warnings
  ---------------------------------------------------------------------------
  -- Port Definitions
  ---------------------------------------------------------------------------
  -- CLKA    : Clock to synchronize all read and write operations of Port A.
  -- RSTA    : Reset input to reset memory outputs to a user-defined 
  --           reset state for Port A.
  -- ENA     : Enable all read and write operations of Port A.
  -- REGCEA  : Register Clock Enable to control each pipeline output
  --           register stages for Port A.
  -- WEA     : Write Enable to enable all write operations of Port A.
  -- ADDRA   : Address of Port A.
  -- DINA    : Data input of Port A.
  -- DOUTA   : Data output of Port A.
  -- CLKB    : Clock to synchronize all read and write operations of Port B.
  -- RSTB    : Reset input to reset memory outputs to a user-defined 
  --           reset state for Port B.
  -- ENB     : Enable all read and write operations of Port B.
  -- REGCEB  : Register Clock Enable to control each pipeline output
  --           register stages for Port B.
  -- WEB     : Write Enable to enable all write operations of Port B.
  -- ADDRB   : Address of Port B.
  -- DINB    : Data input of Port B.
  -- DOUTB   : Data output of Port B.
  -- INJECTSBITERR : Single Bit ECC Error Injection Pin.
  -- INJECTDBITERR : Double Bit ECC Error Injection Pin.
  -- SBITERR       : Output signal indicating that a Single Bit ECC Error has been
  --                 detected and corrected.
  -- DBITERR       : Output signal indicating that a Double Bit ECC Error has been
  --                 detected.
  -- RDADDRECC     : Read Address Output signal indicating address at which an
  --                 ECC error has occurred.
  ---------------------------------------------------------------------------


ARCHITECTURE mem_module_behavioral OF BLK_MEM_GEN_V4_1_mem_module IS

  --****************************************
  -- min/max constant functions
  --****************************************
  -- get_max
  ----------
  FUNCTION get_max(a: INTEGER; b: INTEGER) RETURN INTEGER IS
  BEGIN
    IF (a > b) THEN
      RETURN a;
    ELSE
      RETURN b;
    END IF;
  END FUNCTION;

  -- get_min
  ----------
  FUNCTION get_min(a: INTEGER; b: INTEGER) RETURN INTEGER IS
  BEGIN
    IF (a < b) THEN
      RETURN a;
    ELSE
      RETURN b;
    END IF;
  END FUNCTION;

  --***************************************************************
  -- convert write_mode from STRING type for use in case statement
  --***************************************************************
  FUNCTION write_mode_to_vector(mode: STRING) RETURN STD_LOGIC_VECTOR IS
  BEGIN
    IF (mode = "NO_CHANGE") THEN
      RETURN "10";
    ELSIF (mode = "READ_FIRST") THEN
      RETURN "01";
    ELSE
      RETURN "00";  -- WRITE_FIRST
    END IF;
  END FUNCTION;

  --***************************************************************
  -- convert hex STRING to STD_LOGIC_VECTOR
  --***************************************************************
  FUNCTION hex_to_std_logic_vector(
    hex_str       : STRING;
    return_width  : INTEGER)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE tmp        : STD_LOGIC_VECTOR((hex_str'LENGTH*4)+return_width-1 
                                           DOWNTO 0);

  BEGIN
    tmp := (OTHERS => '0');
    FOR i IN 1 TO hex_str'LENGTH LOOP
      CASE hex_str((hex_str'LENGTH+1)-i) IS
        WHEN '0' => tmp(i*4-1 DOWNTO (i-1)*4) := "0000";
        WHEN '1' => tmp(i*4-1 DOWNTO (i-1)*4) := "0001";
        WHEN '2' => tmp(i*4-1 DOWNTO (i-1)*4) := "0010";
        WHEN '3' => tmp(i*4-1 DOWNTO (i-1)*4) := "0011";
        WHEN '4' => tmp(i*4-1 DOWNTO (i-1)*4) := "0100";
        WHEN '5' => tmp(i*4-1 DOWNTO (i-1)*4) := "0101";
        WHEN '6' => tmp(i*4-1 DOWNTO (i-1)*4) := "0110";
        WHEN '7' => tmp(i*4-1 DOWNTO (i-1)*4) := "0111";
        WHEN '8' => tmp(i*4-1 DOWNTO (i-1)*4) := "1000";
        WHEN '9' => tmp(i*4-1 DOWNTO (i-1)*4) := "1001";
        WHEN 'a' | 'A' => tmp(i*4-1 DOWNTO (i-1)*4) := "1010";
        WHEN 'b' | 'B' => tmp(i*4-1 DOWNTO (i-1)*4) := "1011";
        WHEN 'c' | 'C' => tmp(i*4-1 DOWNTO (i-1)*4) := "1100";
        WHEN 'd' | 'D' => tmp(i*4-1 DOWNTO (i-1)*4) := "1101";
        WHEN 'e' | 'E' => tmp(i*4-1 DOWNTO (i-1)*4) := "1110";
        WHEN 'f' | 'F' => tmp(i*4-1 DOWNTO (i-1)*4) := "1111";
        WHEN OTHERS  =>  tmp(i*4-1 DOWNTO (i-1)*4) := "1111";
      END CASE;
    END LOOP;
    RETURN tmp(return_width-1 DOWNTO 0);
  END hex_to_std_logic_vector;

  --***************************************************************
  -- convert bit to STD_LOGIC
  --***************************************************************
  FUNCTION bit_to_sl(input: BIT) RETURN STD_LOGIC IS
    VARIABLE temp_return : STD_LOGIC;
  BEGIN
    IF (input = '0') THEN
      temp_return := '0';
    ELSE
      temp_return := '1';
    END IF;
    RETURN temp_return;
  END bit_to_sl;

  --***************************************************************
  -- locally derived constants to determine memory shape
  --***************************************************************
  CONSTANT MIN_WIDTH_A : INTEGER := get_min(C_WRITE_WIDTH_A, C_READ_WIDTH_A);
  CONSTANT MIN_WIDTH_B : INTEGER := get_min(C_WRITE_WIDTH_B,C_READ_WIDTH_B);
  CONSTANT MIN_WIDTH   : INTEGER := get_min(MIN_WIDTH_A, MIN_WIDTH_B);

  CONSTANT MAX_DEPTH_A : INTEGER := get_max(C_WRITE_DEPTH_A, C_READ_DEPTH_A);
  CONSTANT MAX_DEPTH_B : INTEGER := get_max(C_WRITE_DEPTH_B, C_READ_DEPTH_B);
  CONSTANT MAX_DEPTH   : INTEGER := get_max(MAX_DEPTH_A, MAX_DEPTH_B);

  -- the memory type
  TYPE mem_array IS ARRAY (MAX_DEPTH-1 DOWNTO 0) OF STD_LOGIC_VECTOR(MIN_WIDTH-1 DOWNTO 0);

  TYPE ecc_err_array IS ARRAY (MAX_DEPTH-1 DOWNTO 0) OF STD_LOGIC;

  TYPE softecc_err_array IS ARRAY (MAX_DEPTH-1 DOWNTO 0) OF STD_LOGIC;
  --***************************************************************
  -- memory initialization function
  --***************************************************************
  FUNCTION init_memory(DEFAULT_DATA  :
                       STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0);
                       write_width_a : INTEGER;
                       depth         : INTEGER;
                       width         : INTEGER)
  RETURN mem_array IS
  VARIABLE init_return   : mem_array := (OTHERS => (OTHERS => '0'));
  FILE     init_file     : TEXT;
  VARIABLE mem_vector    : BIT_VECTOR(write_width_a-1 DOWNTO 0);
  VARIABLE file_buffer   : LINE;
  VARIABLE i             : INTEGER;
  VARIABLE j             : INTEGER;
  VARIABLE index         : INTEGER;
  BEGIN

    --Display output message indicating that the behavioral model is being 
    --initialized
    ASSERT (NOT (C_USE_DEFAULT_DATA=1 OR C_LOAD_INIT_FILE=1)) REPORT " Block Memory Generator CORE Generator module loading initial data..." SEVERITY NOTE;

    -- Setup the default data
    -- Default data is with respect to write_port_A and may be wider
    -- or narrower than init_return width.  The following loops map
    -- default data into the memory
    IF (C_USE_DEFAULT_DATA=1) THEN
      index := 0;
      FOR i IN 0 TO depth-1 LOOP
        FOR j IN 0 TO width-1 LOOP
          init_return(i)(j) := DEFAULT_DATA(index);
          index := (index + 1) MOD C_WRITE_WIDTH_A;
        END LOOP;
      END LOOP;
    END IF;

    -- Read in the .mif file
    -- The init data is formatted with respect to write port A dimensions.
    -- The init_return vector is formatted with respect to minimum width and
    -- maximum depth; the following loops map the .mif file into the memory
    IF (C_LOAD_INIT_FILE=1) THEN
      file_open(init_file, C_INIT_FILE_NAME, read_mode);
      i := 0;
      WHILE (i < depth AND NOT endfile(init_file)) LOOP
        mem_vector := (OTHERS => '0');
        readline(init_file, file_buffer);
        read(file_buffer, mem_vector(file_buffer'LENGTH-1 DOWNTO 0));
        FOR j IN 0 TO write_width_a-1 LOOP
          IF (j MOD width = 0 AND j /= 0) THEN
            i := i + 1;
          END IF;
          init_return(i)(j MOD width) := bit_to_sl(mem_vector(j));
        END LOOP;
        i := i + 1;
      END LOOP;
      file_close(init_file);
    END IF;
    RETURN init_return;

    --Display output message indicating that the behavioral model is done 
    --initializing
    ASSERT (NOT (C_USE_DEFAULT_DATA=1 OR C_LOAD_INIT_FILE=1)) REPORT " Block Memory Generator data initialization complete." SEVERITY NOTE;

  END FUNCTION;

  --***************************************************************
  -- memory type constants
  --***************************************************************
  CONSTANT MEM_TYPE_SP_RAM   : INTEGER := 0;
  CONSTANT MEM_TYPE_SDP_RAM  : INTEGER := 1;
  CONSTANT MEM_TYPE_TDP_RAM  : INTEGER := 2;
  CONSTANT MEM_TYPE_SP_ROM   : INTEGER := 3;
  CONSTANT MEM_TYPE_DP_ROM   : INTEGER := 4;

  --***************************************************************
  -- memory configuration constant functions
  --***************************************************************
  --get_single_port
  -----------------
  FUNCTION get_single_port(mem_type : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (mem_type=MEM_TYPE_SP_RAM OR mem_type=MEM_TYPE_SP_ROM) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END get_single_port;

  --get_is_rom
  --------------
  FUNCTION get_is_rom(mem_type : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (mem_type=MEM_TYPE_SP_ROM OR mem_type=MEM_TYPE_DP_ROM) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END get_is_rom;

  --get_has_a_write
  ------------------
  FUNCTION get_has_a_write(IS_ROM : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (IS_ROM=0) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END get_has_a_write;

  --get_has_b_write
  ------------------
  FUNCTION get_has_b_write(mem_type : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (mem_type=MEM_TYPE_TDP_RAM) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END get_has_b_write;

  --get_has_a_read
  ------------------
  FUNCTION get_has_a_read(mem_type : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (mem_type=MEM_TYPE_SDP_RAM) THEN
      RETURN 0;
    ELSE
      RETURN 1;
    END IF;
  END get_has_a_read;

  --get_has_b_read
  ------------------
  FUNCTION get_has_b_read(SINGLE_PORT : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (SINGLE_PORT=1) THEN
      RETURN 0;
    ELSE
      RETURN 1;
    END IF;
  END get_has_b_read;

  --get_has_b_port
  ------------------
  FUNCTION get_has_b_port(HAS_B_READ  : INTEGER;
                          HAS_B_WRITE : INTEGER)
  RETURN INTEGER IS
  BEGIN
    IF (HAS_B_READ=1 OR HAS_B_WRITE=1) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END get_has_b_port;

  --get_num_output_stages
  -----------------------
  FUNCTION get_num_output_stages(has_mem_output_regs : INTEGER;
                                 has_mux_output_regs : INTEGER;
                                 mux_pipeline_stages : INTEGER)
  RETURN INTEGER IS
  
    VARIABLE actual_mux_pipeline_stages   : INTEGER;
  BEGIN
    -- Mux pipeline stages can be non-zero only when there is a mux
    -- output register. 
    IF (has_mux_output_regs=1) THEN
      actual_mux_pipeline_stages := mux_pipeline_stages;
    ELSE
      actual_mux_pipeline_stages := 0;
    END IF;

    RETURN has_mem_output_regs+actual_mux_pipeline_stages+has_mux_output_regs;
   
  END get_num_output_stages;

  --***************************************************************************
  -- Component declaration of the VARIABLE depth output register stage
  --***************************************************************************
  COMPONENT BLK_MEM_GEN_V4_1_output_stage
  GENERIC (
    C_FAMILY                 : STRING  := "virtex5";
    C_XDEVICEFAMILY          : STRING  := "virtex5";
    C_RST_TYPE               : STRING  := "SYNC";
    C_HAS_RST                : INTEGER := 0;
    C_RSTRAM                 : INTEGER := 0;
    C_RST_PRIORITY           : STRING  := "CE";
    init_val                 : STD_LOGIC_VECTOR;
    C_HAS_EN                 : INTEGER := 0;
    C_HAS_REGCE              : INTEGER := 0;
    C_DATA_WIDTH             : INTEGER := 32;
    C_ADDRB_WIDTH            : INTEGER := 10;
    C_HAS_MEM_OUTPUT_REGS    : INTEGER := 0;
    C_USE_SOFTECC            : INTEGER := 0;
    C_USE_ECC                : INTEGER := 0;
    NUM_STAGES               : INTEGER := 1;
    FLOP_DELAY               : TIME    := 100 ps);
  PORT (
    CLK   : IN  STD_LOGIC;
    RST   : IN  STD_LOGIC;
    REGCE : IN  STD_LOGIC;
    EN    : IN  STD_LOGIC;
    DIN   : IN  STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
    DOUT  : OUT STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
    SBITERR_IN : IN  STD_LOGIC;
    DBITERR_IN : IN  STD_LOGIC;
    SBITERR    : OUT STD_LOGIC;
    DBITERR    : OUT STD_LOGIC;
    RDADDRECC_IN : IN STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);
    RDADDRECC  : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
  );
  END COMPONENT BLK_MEM_GEN_V4_1_output_stage;

COMPONENT BLK_MEM_GEN_V4_1_softecc_output_reg_stage
GENERIC (
  C_DATA_WIDTH             : INTEGER := 32;
  C_ADDRB_WIDTH            : INTEGER := 10;
  C_HAS_SOFTECC_OUTPUT_REGS_A  : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_B  : INTEGER := 0;
  C_USE_SOFTECC            : INTEGER := 0;
  FLOP_DELAY               : TIME    := 100 ps
);
PORT (
  CLK          : IN  STD_LOGIC;
  DIN          : IN  STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
  DOUT         : OUT STD_LOGIC_VECTOR(C_DATA_WIDTH-1 DOWNTO 0);
  SBITERR_IN   : IN  STD_LOGIC;
  DBITERR_IN   : IN  STD_LOGIC;
  SBITERR      : OUT STD_LOGIC;
  DBITERR      : OUT STD_LOGIC;
  RDADDRECC_IN : IN STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);
  RDADDRECC    : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
);
END COMPONENT BLK_MEM_GEN_V4_1_softecc_output_reg_stage;

  --******************************************************
  -- locally derived constants to assist memory access
  --******************************************************
  CONSTANT WRITE_WIDTH_RATIO_A : INTEGER := C_WRITE_WIDTH_A/MIN_WIDTH;
  CONSTANT READ_WIDTH_RATIO_A  : INTEGER := C_READ_WIDTH_A/MIN_WIDTH;
  CONSTANT WRITE_WIDTH_RATIO_B : INTEGER := C_WRITE_WIDTH_B/MIN_WIDTH;
  CONSTANT READ_WIDTH_RATIO_B  : INTEGER := C_READ_WIDTH_B/MIN_WIDTH;

  --******************************************************
  -- To modify the LSBs of the 'wider' data to the actual
  -- address value
  --******************************************************
  CONSTANT WRITE_ADDR_A_DIV  : INTEGER := C_WRITE_WIDTH_A/MIN_WIDTH_A;
  CONSTANT READ_ADDR_A_DIV   : INTEGER := C_READ_WIDTH_A/MIN_WIDTH_A;
  CONSTANT WRITE_ADDR_B_DIV  : INTEGER := C_WRITE_WIDTH_B/MIN_WIDTH_B;
  CONSTANT READ_ADDR_B_DIV   : INTEGER := C_READ_WIDTH_B/MIN_WIDTH_B;

  --******************************************************
  -- FUNCTION : log2roundup
  --******************************************************
  FUNCTION log2roundup (
    data_value : INTEGER)
  RETURN INTEGER IS

    VARIABLE width       : INTEGER := 0;
    VARIABLE cnt         : INTEGER := 1;

  BEGIN
    IF (data_value <= 1) THEN
      width   := 0;
    ELSE
      WHILE (cnt < data_value) LOOP
        width := width + 1;
        cnt   := cnt *2;
      END LOOP;
    END IF;

    RETURN width;
  END log2roundup;

 ------------------------------------------------------------------------------
  -- FUNCTION: if_then_else
  -- This function is used to implement an IF..THEN when such a statement is not
  --  allowed.
  ------------------------------------------------------------------------------
  FUNCTION if_then_else (
    condition : BOOLEAN;
    true_case : INTEGER;
    false_case : INTEGER)
  RETURN INTEGER IS
    VARIABLE retval : INTEGER := 0;
  BEGIN
    IF NOT condition THEN
      retval:=false_case;
    ELSE
      retval:=true_case;
    END IF;
    RETURN retval;
  END if_then_else;

  --******************************************************
  -- Other constants and signals
  --******************************************************
  CONSTANT COLL_DELAY : TIME := 2 ns;

  -- default data vector
  CONSTANT DEFAULT_DATA  : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0)
    := hex_to_std_logic_vector(C_DEFAULT_DATA,
                               C_WRITE_WIDTH_A);

  CONSTANT CHKBIT_WIDTH : INTEGER  := if_then_else(C_WRITE_WIDTH_A>57,8,if_then_else(C_WRITE_WIDTH_A>26,7,if_then_else(C_WRITE_WIDTH_A>11,6,if_then_else(C_WRITE_WIDTH_A>4,5,if_then_else(C_WRITE_WIDTH_A<5,4,0)))));

 -- the memory SIGNAL
  SIGNAL memory_i           : mem_array;
  SIGNAL doublebit_error_i  : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A+CHKBIT_WIDTH-1 DOWNTO 0);
  SIGNAL current_contents_i : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0);

  -- write mode constants
  CONSTANT WRITE_MODE_A : STD_LOGIC_VECTOR(1 DOWNTO 0) :=
    write_mode_to_vector(C_WRITE_MODE_A);
  CONSTANT WRITE_MODE_B : STD_LOGIC_VECTOR(1 DOWNTO 0) :=
    write_mode_to_vector(C_WRITE_MODE_B);
  CONSTANT WRITE_MODES  : STD_LOGIC_VECTOR(3 DOWNTO 0) :=
    WRITE_MODE_A & WRITE_MODE_B;

  -- reset values
  CONSTANT INITA_VAL  : STD_LOGIC_VECTOR(C_READ_WIDTH_A-1 DOWNTO 0)
    := hex_to_std_logic_vector(C_INITA_VAL,
                               C_READ_WIDTH_A);

  CONSTANT INITB_VAL  : STD_LOGIC_VECTOR(C_READ_WIDTH_B-1 DOWNTO 0)
    := hex_to_std_logic_vector(C_INITB_VAL,
                               C_READ_WIDTH_B);
  -- memory output 'latches'
  SIGNAL memory_out_a : STD_LOGIC_VECTOR(C_READ_WIDTH_A-1 DOWNTO 0) :=
    INITA_VAL;
  SIGNAL memory_out_b : STD_LOGIC_VECTOR(C_READ_WIDTH_B-1 DOWNTO 0) :=
    INITB_VAL;
    
  SIGNAL sbiterr_in  : STD_LOGIC := '0';
  SIGNAL sbiterr_sdp : STD_LOGIC := '0';

  SIGNAL dbiterr_in  : STD_LOGIC := '0';
  SIGNAL dbiterr_sdp : STD_LOGIC := '0';

  SIGNAL rdaddrecc_in  : STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL rdaddrecc_sdp : STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL doutb_i       : STD_LOGIC_VECTOR(C_READ_WIDTH_B-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL rdaddrecc_i   : STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sbiterr_i : STD_LOGIC := '0';
  SIGNAL dbiterr_i   : STD_LOGIC := '0';

  -- memory configuration constants
  -----------------------------------------------
  CONSTANT SINGLE_PORT : INTEGER := get_single_port(C_MEM_TYPE);
  CONSTANT IS_ROM      : INTEGER := get_is_rom(C_MEM_TYPE);
  CONSTANT HAS_A_WRITE : INTEGER := get_has_a_write(IS_ROM);
  CONSTANT HAS_B_WRITE : INTEGER := get_has_b_write(C_MEM_TYPE);
  CONSTANT HAS_A_READ  : INTEGER := get_has_a_read(C_MEM_TYPE);
  CONSTANT HAS_B_READ  : INTEGER := get_has_b_read(SINGLE_PORT);
  CONSTANT HAS_B_PORT  : INTEGER := get_has_b_port(HAS_B_READ, HAS_B_WRITE);
  
  CONSTANT NUM_OUTPUT_STAGES_A : INTEGER :=
    get_num_output_stages(C_HAS_MEM_OUTPUT_REGS_A, C_HAS_MUX_OUTPUT_REGS_A, 
                          C_MUX_PIPELINE_STAGES);
  CONSTANT NUM_OUTPUT_STAGES_B : INTEGER :=
    get_num_output_stages(C_HAS_MEM_OUTPUT_REGS_B, C_HAS_MUX_OUTPUT_REGS_B, 
                          C_MUX_PIPELINE_STAGES);

  CONSTANT WEA0  : STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  CONSTANT WEB0  : STD_LOGIC_VECTOR(C_WEB_WIDTH-1 DOWNTO 0) := (OTHERS => '0');


     -----------------------------------------------------------------------------
  -- DEBUG CONTROL
  -- DEBUG=0 : Debug output OFF
  -- DEBUG=1 : Some debug info printed
  -----------------------------------------------------------------------------
  CONSTANT DEBUG : INTEGER := 0;

-- internal signals
  -----------------------------------------------
  SIGNAL ena_i    : STD_LOGIC;
  SIGNAL enb_i    : STD_LOGIC;
  SIGNAL reseta_i : STD_LOGIC;
  SIGNAL resetb_i : STD_LOGIC;
  SIGNAL wea_i    : STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0);
  SIGNAL web_i    : STD_LOGIC_VECTOR(C_WEB_WIDTH-1 DOWNTO 0);
  SIGNAL rea_i    : STD_LOGIC;
  SIGNAL reb_i    : STD_LOGIC;

  SIGNAL message_complete : BOOLEAN := false;

  --*********************************************************
  --FUNCTION : Collision check
  --*********************************************************
  FUNCTION collision_check (addr_a    :
                            STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
                            iswrite_a : BOOLEAN;
                            addr_b    :
                            STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);
                            iswrite_b : BOOLEAN)
  RETURN BOOLEAN IS
    VARIABLE c_aw_bw        : INTEGER;
    VARIABLE c_aw_br        : INTEGER;
    VARIABLE c_ar_bw        : INTEGER;
    VARIABLE write_addr_a_width : INTEGER;
    VARIABLE read_addr_a_width  : INTEGER;
    VARIABLE write_addr_b_width : INTEGER;
    VARIABLE read_addr_b_width  : INTEGER;
  BEGIN
    c_aw_bw := 0;
    c_aw_br := 0;
    c_ar_bw := 0;

    -- Determine the effective address widths FOR each of the 4 ports
    write_addr_a_width := C_ADDRA_WIDTH-log2roundup(WRITE_ADDR_A_DIV);
    read_addr_a_width  := C_ADDRA_WIDTH-log2roundup(READ_ADDR_A_DIV);
    write_addr_b_width := C_ADDRB_WIDTH-log2roundup(WRITE_ADDR_B_DIV);
    read_addr_b_width  := C_ADDRB_WIDTH-log2roundup(READ_ADDR_B_DIV);


    --Look FOR a write-write collision. In order FOR a write-write
    --collision to exist, both ports must have a write transaction.
    IF (iswrite_a AND iswrite_b) THEN
      IF (write_addr_a_width > write_addr_b_width) THEN
        --write_addr_b_width is smaller, so scale both addresses to that
        -- width FOR comparing write_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        -- scale it down to write_addr_b_width
        --addr_b starts as C_ADDRB_WIDTH,
        -- scale it down to write_addr_b_width
        --Once both are scaled to write_addr_b_width, compare.
        IF ((conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_b_width)) = 
           (conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_b_width))) THEN
          c_aw_bw := 1;
        ELSE
          c_aw_bw := 0;
        END IF;
      ELSE
        --write_addr_a_width is smaller, so scale both addresses to that
        -- width FOR comparing write_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        -- scale it down to write_addr_a_width
        --addr_b starts as C_ADDRB_WIDTH,
        -- scale it down to write_addr_a_width
        --Once both are scaled to write_addr_a_width, compare.
        IF ((conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_a_width)) = 
           (conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_a_width))) THEN
          c_aw_bw := 1;
        ELSE
          c_aw_bw := 0;
        END IF;
      END IF; --width
    END IF; --iswrite_a and iswrite_b

    --If the B port is reading (which means it is enabled - so could be
    -- a TX_WRITE or TX_READ), then check FOR a write-read collision).
    --This could happen whether or not a write-write collision exists due
    --  to asymmetric write/read ports.
    IF (iswrite_a) THEN
      IF (write_addr_a_width > read_addr_b_width) THEN
        --read_addr_b_width is smaller, so scale both addresses to that
        --  width FOR comparing write_addr_a and read_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to read_addr_b_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to read_addr_b_width
        --Once both are scaled to read_addr_b_width, compare.
        IF ((conv_integer(addr_a)/2**(C_ADDRA_WIDTH-read_addr_b_width)) = 
           (conv_integer(addr_b)/2**(C_ADDRB_WIDTH-read_addr_b_width))) THEN
          c_aw_br := 1;
        ELSE
          c_aw_br := 0;
        END IF;
    ELSE
        --write_addr_a_width is smaller, so scale both addresses to that
        --  width FOR comparing write_addr_a and read_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to write_addr_a_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to write_addr_a_width
        --Once both are scaled to write_addr_a_width, compare.
        IF ((conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_a_width)) = 
           (conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_a_width))) THEN
          c_aw_br := 1;
        ELSE
          c_aw_br := 0;
        END IF;
      END IF; --width
    END IF; --iswrite_a

    --If the A port is reading (which means it is enabled - so could be
    --  a TX_WRITE or TX_READ), then check FOR a write-read collision).
    --This could happen whether or not a write-write collision exists due
    --  to asymmetric write/read ports.
    IF (iswrite_b) THEN
      IF (read_addr_a_width > write_addr_b_width) THEN
        --write_addr_b_width is smaller, so scale both addresses to that
        --  width FOR comparing read_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to write_addr_b_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to write_addr_b_width
        --Once both are scaled to write_addr_b_width, compare.
        IF ((conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_b_width)) = 
           (conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_b_width))) THEN
          c_ar_bw := 1;
        ELSE
          c_ar_bw := 0;
        END IF;
      ELSE
        --read_addr_a_width is smaller, so scale both addresses to that
        --  width FOR comparing read_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to read_addr_a_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to read_addr_a_width
        --Once both are scaled to read_addr_a_width, compare.
        IF ((conv_integer(addr_b)/2**(C_ADDRB_WIDTH-read_addr_a_width)) = 
           (conv_integer(addr_a)/2**(C_ADDRA_WIDTH-read_addr_a_width))) THEN
          c_ar_bw := 1;
        ELSE
          c_ar_bw := 0;
        END IF;
      END IF; --width
    END IF; --iswrite_b


    RETURN (c_aw_bw=1 OR c_aw_br=1 OR c_ar_bw=1);
  END FUNCTION collision_check;

BEGIN -- Architecture

  -----------------------------------------------------------------------------
  -- SOFTECC and ECC SBITERR/DBITERR Outputs
  --  The ECC Behavior is modeled by the behavioral models only for Virtex-6.
  --  The SOFTECC Behavior is modeled by the behavioral models for Spartan-6.
  --  For Virtex-5, these outputs will be tied to 0.
  -----------------------------------------------------------------------------
  SBITERR <= sbiterr_sdp WHEN ((C_MEM_TYPE = 1 AND C_USE_ECC = 1) OR C_USE_SOFTECC = 1) ELSE '0';
  DBITERR <= dbiterr_sdp WHEN ((C_MEM_TYPE = 1 AND C_USE_ECC = 1) OR C_USE_SOFTECC = 1)  ELSE '0';
  RDADDRECC <= rdaddrecc_sdp WHEN (((C_FAMILY="virtex6") AND C_MEM_TYPE = 1 AND C_USE_ECC = 1) OR C_USE_SOFTECC = 1) ELSE (OTHERS => '0');

  -----------------------------------------------
  -- This effectively wires off optional inputs
  -----------------------------------------------
  ena_i    <= ENA WHEN (C_HAS_ENA=1) ELSE '1';
  enb_i    <= ENB WHEN (C_HAS_ENB=1   AND HAS_B_PORT=1) ELSE '1';
  wea_i    <= WEA WHEN (HAS_A_WRITE=1 AND ena_i='1')    ELSE WEA0;
  web_i    <= WEB WHEN (HAS_B_WRITE=1 AND enb_i='1')    ELSE WEB0;
  rea_i    <= ena_i WHEN (HAS_A_READ=1) ELSE '0';
  reb_i    <= enb_i WHEN (HAS_B_READ=1) ELSE '0';

  -- these signals reset the memory latches
  -- For the special reset behaviors in some of the families, the C_RSTRAM
  -- attribute of the corresponding port is used to indicate if the latch is
  -- reset or not.

  reseta_i <= RSTA WHEN
              ((C_HAS_RSTA=1 AND NUM_OUTPUT_STAGES_A=0) OR 
               (C_HAS_RSTA=1 AND C_RSTRAM_A=1))
               ELSE '0';
  resetb_i <= RSTB WHEN
              ((C_HAS_RSTB=1 AND NUM_OUTPUT_STAGES_B=0) OR 
               (C_HAS_RSTB=1 AND C_RSTRAM_B=1) )
               ELSE '0';

  --***************************************************************************
  -- This is the main PROCESS which includes the memory VARIABLE and the read
  -- and write procedures.  It also schedules read and write operations
  --***************************************************************************
  PROCESS (CLKA, CLKB,rea_i,reb_i,reseta_i,resetb_i)

    -- Initialize the memory array
    ------------------------------------
    VARIABLE memory         : mem_array := init_memory(DEFAULT_DATA,
                                                       C_WRITE_WIDTH_A,
                                                       MAX_DEPTH,
                                                       MIN_WIDTH);
    VARIABLE softecc_sbiterr_arr         : softecc_err_array;
    VARIABLE softecc_dbiterr_arr         : softecc_err_array;
                                                       
    VARIABLE sbiterr_arr    : ecc_err_array;                                                   
    VARIABLE dbiterr_arr    : ecc_err_array;                                                   
----- COMMENTED FOR CR550771-------------------------------------------------
-----    VARIABLE doublebit_error  : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A+CHKBIT_WIDTH-1 DOWNTO 0) := (1 => '1', 0 => '1',OTHERS=>'0');
    CONSTANT doublebit_lsb  : STD_LOGIC_VECTOR (1 DOWNTO 0):="11";
    CONSTANT doublebit_msb  : STD_LOGIC_VECTOR (C_WRITE_WIDTH_A+CHKBIT_WIDTH-3 DOWNTO 0):= (OTHERS => '0');
    VARIABLE doublebit_error  : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A+CHKBIT_WIDTH-1 DOWNTO 0) := doublebit_msb & doublebit_lsb ;
----- COMMENTED FOR CR550771-------------------------------------------------

    VARIABLE current_contents_var  : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0);
  --***********************************
  -- procedures to access the memory
  --***********************************
  -- write_a
  ----------
  PROCEDURE write_a
  (addr        : IN STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
   byte_en     : IN STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0);
   data        : IN STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0);
   inj_sbiterr : IN STD_LOGIC;
   inj_dbiterr : IN STD_LOGIC) IS
    VARIABLE current_contents : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0);
    VARIABLE address_i        : INTEGER;
    VARIABLE i                : INTEGER;

    VARIABLE errbit_current_contents : STD_LOGIC_VECTOR(1 DOWNTO 0);
  BEGIN

    -- Block Memory Generator non-cycle-accurate message
    ASSERT (message_complete) REPORT "Block Memory Generator CORE Generator module is using a behavioral model FOR simulation which will not precisely model memory collision behavior." 
    SEVERITY NOTE;

    message_complete <= true;

    -- Shift the address by the ratio
    address_i := (conv_integer(addr)/WRITE_ADDR_A_DIV);

    IF (address_i >= C_WRITE_DEPTH_A) THEN
      IF (C_DISABLE_WARN_BHV_RANGE = 0) THEN
        ASSERT FALSE
          REPORT C_CORENAME & " WARNING: Address " &
          INTEGER'IMAGE(conv_integer(addr)) & " is outside range FOR A Write"
          SEVERITY WARNING;
      END IF;

      -- valid address
    ELSE

      -- Combine w/ byte writes
      IF (C_USE_BYTE_WEA = 1) THEN

        -- Get the current memory contents
        FOR i IN 0 TO WRITE_WIDTH_RATIO_A-1 LOOP
          current_contents(MIN_WIDTH*(i+1)-1 DOWNTO MIN_WIDTH*i)
            := memory(address_i*WRITE_WIDTH_RATIO_A + i);
        END LOOP;


        -- Apply incoming bytes
        FOR i IN 0 TO C_WEA_WIDTH-1 LOOP
          IF (byte_en(i) = '1') THEN
            current_contents(C_BYTE_SIZE*(i+1)-1 DOWNTO C_BYTE_SIZE*i)
              := data(C_BYTE_SIZE*(i+1)-1 DOWNTO C_BYTE_SIZE*i);
          END IF;
        END LOOP;

      -- No byte-writes, overwrite the whole word
      ELSE
        current_contents := data;
      END IF;

      -- Insert double bit errors:
      IF (C_USE_ECC = 1) THEN
        IF ((C_HAS_INJECTERR = 2 OR C_HAS_INJECTERR = 3) AND inj_dbiterr = '1') THEN
          current_contents(0) := NOT(current_contents(0));
          current_contents(1) := NOT(current_contents(1));
        END IF;
      END IF;
      
      -- Insert double bit errors:
      IF (C_USE_SOFTECC=1) THEN
        IF ((C_HAS_INJECTERR = 2 OR C_HAS_INJECTERR = 3) AND inj_dbiterr = '1') THEN
          doublebit_error(C_WRITE_WIDTH_A+CHKBIT_WIDTH-1 downto 2) := doublebit_error(C_WRITE_WIDTH_A+CHKBIT_WIDTH-3 downto 0);
          doublebit_error(0) := doublebit_error(C_WRITE_WIDTH_A+CHKBIT_WIDTH-1);
          doublebit_error(1) := doublebit_error(C_WRITE_WIDTH_A+CHKBIT_WIDTH-2);
	  current_contents := current_contents XOR doublebit_error(C_WRITE_WIDTH_A-1 DOWNTO 0);
        END IF;
      END IF;
      
    IF(DEBUG=1) THEN
	  current_contents_var := current_contents; --for debugging current
    END IF;

      -- Write data to memory
      FOR i IN 0 TO WRITE_WIDTH_RATIO_A-1 LOOP
        memory(address_i*WRITE_WIDTH_RATIO_A + i) :=
          current_contents(MIN_WIDTH*(i+1)-1 DOWNTO MIN_WIDTH*i);
      END LOOP;
      
      -- Store address at which error is injected:
      IF ((C_FAMILY = "virtex6") AND C_USE_ECC = 1) THEN
        IF ((C_HAS_INJECTERR = 1 AND inj_sbiterr = '1') OR (C_HAS_INJECTERR = 3 AND inj_sbiterr = '1' AND inj_dbiterr /= '1')) THEN
          sbiterr_arr(address_i) := '1';
        ELSE
          sbiterr_arr(address_i) := '0';
        END IF;
    
        IF ((C_HAS_INJECTERR = 2 OR C_HAS_INJECTERR = 3) AND inj_dbiterr = '1') THEN
          dbiterr_arr(address_i) := '1';
        ELSE
          dbiterr_arr(address_i) := '0';
        END IF;
      END IF;
        
      -- Store address at which softecc error is injected:
      IF (C_USE_SOFTECC = 1) THEN
        IF ((C_HAS_INJECTERR = 1 AND inj_sbiterr = '1') OR (C_HAS_INJECTERR = 3 AND inj_sbiterr = '1' AND inj_dbiterr /= '1')) THEN
          softecc_sbiterr_arr(address_i) := '1';
        ELSE
          softecc_sbiterr_arr(address_i) := '0';
        END IF;
    
        IF ((C_HAS_INJECTERR = 2 OR C_HAS_INJECTERR = 3) AND inj_dbiterr = '1') THEN
          softecc_dbiterr_arr(address_i) := '1';
        ELSE
          softecc_dbiterr_arr(address_i) := '0';
        END IF;
      END IF;
        
-----      -- Store address at which soft error is injected:
-----      IF (C_USE_SOFTECC=1) THEN
-----        IF ((C_HAS_INJECTERR = 1 AND inj_sbiterr = '1') OR (C_HAS_INJECTERR = 3 AND inj_sbiterr = '1' AND inj_dbiterr /= '1')) THEN
-----          errbit_memory(address_i) := "01";
-----        ELSIF ((C_HAS_INJECTERR = 2 OR C_HAS_INJECTERR = 3) AND inj_dbiterr = '1') THEN
-----          errbit_memory(address_i) := "10";
-----        ELSE
-----          errbit_memory(address_i) := "00";
-----        END IF;
-----      END IF;
        
    END IF;


  END PROCEDURE;

  -- write_b
  ----------
  PROCEDURE write_b
  (addr    : IN STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);
   byte_en : IN STD_LOGIC_VECTOR(C_WEB_WIDTH-1 DOWNTO 0);
   data    : IN STD_LOGIC_VECTOR(C_WRITE_WIDTH_B-1 DOWNTO 0)) IS
    VARIABLE current_contents : STD_LOGIC_VECTOR(C_WRITE_WIDTH_B-1 DOWNTO 0);
    VARIABLE address_i        : INTEGER;
    VARIABLE i                : INTEGER;
  BEGIN
    -- Shift the address by the ratio
    address_i := (conv_integer(addr)/WRITE_ADDR_B_DIV);
    IF (address_i >= C_WRITE_DEPTH_B) THEN
      IF (C_DISABLE_WARN_BHV_RANGE = 0) THEN
        ASSERT FALSE
          REPORT C_CORENAME & " WARNING: Address " &
          INTEGER'IMAGE(conv_integer(addr)) & " is outside range for B Write"
          SEVERITY WARNING;
      END IF;

    -- valid address
    ELSE

      -- Combine w/ byte writes
      IF (C_USE_BYTE_WEB = 1) THEN

        -- Get the current memory contents
        FOR i IN 0 TO WRITE_WIDTH_RATIO_B-1 LOOP
          current_contents(MIN_WIDTH*(i+1)-1 DOWNTO MIN_WIDTH*i)
            := memory(address_i*WRITE_WIDTH_RATIO_B + i);
        END LOOP;

        -- Apply incoming bytes
        FOR i IN 0 TO C_WEB_WIDTH-1 LOOP
          IF (byte_en(i) = '1') THEN
            current_contents(C_BYTE_SIZE*(i+1)-1 DOWNTO C_BYTE_SIZE*i)
              := data(C_BYTE_SIZE*(i+1)-1 DOWNTO C_BYTE_SIZE*i);
          END IF;
        END LOOP;

      -- No byte-writes, overwrite the whole word
      ELSE
        current_contents := data;
      END IF;

      -- Write data to memory
      FOR i IN 0 TO WRITE_WIDTH_RATIO_B-1 LOOP
        memory(address_i*WRITE_WIDTH_RATIO_B + i) :=
          current_contents(MIN_WIDTH*(i+1)-1 DOWNTO MIN_WIDTH*i);
      END LOOP;

    END IF;
  END PROCEDURE;

  -- read_a
  ----------
  PROCEDURE read_a
  (addr  : IN STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
   reset : IN STD_LOGIC) IS
    VARIABLE address_i : INTEGER;
    VARIABLE i         : INTEGER;
  BEGIN

    IF (reset = '1') THEN
      memory_out_a <= INITA_VAL AFTER FLOP_DELAY;
    ELSE
      -- Shift the address by the ratio
      address_i := (conv_integer(addr)/READ_ADDR_A_DIV);

      IF (address_i >= C_READ_DEPTH_A) THEN
        IF (C_DISABLE_WARN_BHV_RANGE=0) THEN
          ASSERT FALSE
            REPORT C_CORENAME & " WARNING: Address " &
            INTEGER'IMAGE(conv_integer(addr)) & " is outside range for A Read"
            SEVERITY WARNING;
        END IF;
        memory_out_a <= (OTHERS => 'X') AFTER FLOP_DELAY;
        -- valid address
      ELSE

        -- Increment through the 'partial' words in the memory
        FOR i IN 0 TO READ_WIDTH_RATIO_A-1 LOOP
          memory_out_a(MIN_WIDTH*(i+1)-1 DOWNTO MIN_WIDTH*i) <=
            memory(address_i*READ_WIDTH_RATIO_A + i) AFTER FLOP_DELAY;
        END LOOP;
        
      END IF;
    END IF;
  END PROCEDURE;

  -- read_b
  ----------
  PROCEDURE read_b
  (addr  : IN STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);
   reset : IN STD_LOGIC) IS
    VARIABLE address_i : INTEGER;
    VARIABLE i         : INTEGER;
  BEGIN

    IF (reset = '1') THEN
      memory_out_b <= INITB_VAL AFTER FLOP_DELAY;
      sbiterr_in   <= '0' AFTER FLOP_DELAY;
      dbiterr_in   <= '0' AFTER FLOP_DELAY;
      rdaddrecc_in <= (OTHERS => '0') AFTER FLOP_DELAY;
    ELSE
      -- Shift the address by the ratio
      address_i := (conv_integer(addr)/READ_ADDR_B_DIV);
      IF (address_i >= C_READ_DEPTH_B) THEN
        IF (C_DISABLE_WARN_BHV_RANGE=0) THEN
          ASSERT FALSE
            REPORT C_CORENAME & " WARNING: Address " &
            INTEGER'IMAGE(conv_integer(addr)) & " is outside range for B Read"
            SEVERITY WARNING;
        END IF;
        memory_out_b <= (OTHERS => 'X') AFTER FLOP_DELAY;
        sbiterr_in <= 'X' AFTER FLOP_DELAY;
        dbiterr_in <= 'X' AFTER FLOP_DELAY;
        rdaddrecc_in <= (OTHERS => 'X') AFTER FLOP_DELAY;

        -- valid address
      ELSE

        -- Increment through the 'partial' words in the memory
        FOR i IN 0 TO READ_WIDTH_RATIO_B-1 LOOP
          memory_out_b(MIN_WIDTH*(i+1)-1 DOWNTO MIN_WIDTH*i) <=
            memory(address_i*READ_WIDTH_RATIO_B + i) AFTER FLOP_DELAY;
        END LOOP;

        --assert sbiterr and dbiterr signals
        IF ((C_FAMILY="virtex6") AND C_USE_ECC = 1) THEN
          rdaddrecc_in <= addr AFTER FLOP_DELAY;
          IF (sbiterr_arr(address_i) = '1') THEN
            sbiterr_in <= '1' AFTER FLOP_DELAY;
          ELSE
            sbiterr_in <= '0' AFTER FLOP_DELAY;
          END IF;
          IF (dbiterr_arr(address_i) = '1') THEN
            dbiterr_in <= '1' AFTER FLOP_DELAY;
          ELSE
            dbiterr_in <= '0' AFTER FLOP_DELAY;
          END IF;
-----        ELSE
-----          sbiterr_in <= '0' AFTER FLOP_DELAY;
-----          dbiterr_in <= '0' AFTER FLOP_DELAY;
-----          rdaddrecc_in <= (OTHERS => '0') AFTER FLOP_DELAY;
-----        END IF;

        --assert softecc sbiterr and dbiterr signals
	  ELSIF (C_USE_SOFTECC = 1) THEN
          rdaddrecc_in <= addr AFTER FLOP_DELAY;
          IF (softecc_sbiterr_arr(address_i) = '1') THEN
            sbiterr_in <= '1' AFTER FLOP_DELAY;
          ELSE
            sbiterr_in <= '0' AFTER FLOP_DELAY;
          END IF;
          IF (softecc_dbiterr_arr(address_i) = '1') THEN
            dbiterr_in <= '1' AFTER FLOP_DELAY;
          ELSE
            dbiterr_in <= '0' AFTER FLOP_DELAY;
          END IF;
        ELSE
          sbiterr_in <= '0' AFTER FLOP_DELAY;
          dbiterr_in <= '0' AFTER FLOP_DELAY;
          rdaddrecc_in <= (OTHERS => '0') AFTER FLOP_DELAY;
        END IF;

-----   --assert softecc sbiterr and dbiterr signals
-----        IF (C_USE_SOFTECC = 1) THEN
-----          rdaddrecc_in <= addr AFTER FLOP_DELAY;
-----          IF (errbit_memory(address_i) = "01") THEN
-----            sbiterr_in <= '1' AFTER FLOP_DELAY;
-----          ELSE
-----            sbiterr_in <= '0' AFTER FLOP_DELAY;
-----          END IF;
-----          IF (errbit_memory(address_i) = "10") THEN
-----            dbiterr_in <= '1' AFTER FLOP_DELAY;
-----          ELSE
-----            dbiterr_in <= '0' AFTER FLOP_DELAY;
-----          END IF;
-----        ELSE
-----          sbiterr_in <= '0' AFTER FLOP_DELAY;
-----          dbiterr_in <= '0' AFTER FLOP_DELAY;
-----          rdaddrecc_in <= (OTHERS => '0') AFTER FLOP_DELAY;
-----        END IF;

      END IF;
    END IF;
  END PROCEDURE;

  -- reset_a
  ----------
  PROCEDURE reset_a
  (reset : IN STD_LOGIC) IS
  BEGIN
    IF (reset = '1') THEN
      memory_out_a <= INITA_VAL AFTER FLOP_DELAY;
    END IF;
  END PROCEDURE;

  -- reset_b
  ----------
  PROCEDURE reset_b
  (reset : IN STD_LOGIC) IS
  BEGIN
    IF (reset = '1') THEN
      memory_out_b <= INITB_VAL AFTER FLOP_DELAY;
    END IF;
  END PROCEDURE;

  BEGIN  -- begin the main PROCESS

  --*************************************************************************
  -- Asynchronous reset of Port A and Port B are performed here
  -- Note that the asynchronous reset feature is only supported in Spartan6
  -- devices
  --*************************************************************************
    IF((C_FAMILY = "spartan6") AND C_RST_TYPE="ASYNC") THEN
      IF (C_RST_PRIORITY_A="CE") THEN
        IF (rea_i='1') THEN
          reset_a(reseta_i);
        END IF;
      ELSE
        reset_a(reseta_i);
      END IF;
    
      IF (C_RST_PRIORITY_B="CE") THEN
        IF (reb_i='1') THEN
          reset_b(resetb_i);
        END IF;
      ELSE
        reset_b(resetb_i);
      END IF;
    END IF;
  
  --***************************************************************************
  -- These are the main blocks which schedule read and write operations
  -- Note that the reset priority feature at the latch stage is only supported
  -- for Spartan-6. For other families, the default priority at the latch stage
  -- is "CE"
  --***************************************************************************
    -- Synchronous clocks: schedule port operations with respect to both
    -- write operating modes
    IF (C_COMMON_CLK=1) THEN
      IF (CLKA='1' AND CLKA'EVENT) THEN
        CASE WRITE_MODES IS
          WHEN "0000" =>  -- write_first write_first
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;

          WHEN "0100" =>  -- read_first write_first
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;

          WHEN "0001" =>  -- write_first read_first
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;

          WHEN "0101" =>  --read_first read_first
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;

          WHEN "0010" =>  -- write_first no_change
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1' AND web_i=WEB0) THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1' AND (web_i=WEB0 OR resetb_i='1')) THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;

          WHEN "0110" =>  -- read_first no_change
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1' AND web_i=WEB0) THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1' AND (web_i=WEB0 OR resetb_i='1')) THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;

          WHEN "1000" =>  -- no_change write_first
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1' AND wea_i=WEA0) THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1' AND (wea_i=WEA0 OR reseta_i='1')) THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;

          WHEN "1001" =>  -- no_change read_first
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1' AND wea_i=WEA0) THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1' AND (wea_i=WEA0 OR reseta_i='1')) THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;

          WHEN "1010" =>  -- no_change no_change
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1' AND wea_i=WEA0) THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1' AND (wea_i=WEA0 OR reseta_i='1')) THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1' AND web_i=WEB0) THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1' AND (web_i=WEB0 OR resetb_i='1')) THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;

          WHEN OTHERS =>
            ASSERT FALSE REPORT "Invalid Operating Mode" SEVERITY ERROR;
        END CASE;
      END IF;
    END IF;  -- Synchronous clocks

    -- Asynchronous clocks: port operation is independent
    IF (C_COMMON_CLK=0) THEN
      IF (CLKA='1' AND CLKA'EVENT) THEN
        CASE WRITE_MODE_A IS
          WHEN "00" =>  -- write_first
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;

          WHEN "01" =>  -- read_first
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1') THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1') THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;

          WHEN "10" =>  -- no_change
            --Write A
            IF (wea_i/=WEA0) THEN
              write_a(ADDRA, wea_i, DINA,INJECTSBITERR,INJECTDBITERR);
            END IF;
            --Read A
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_A="SR") THEN
              IF (reseta_i='1') THEN
                reset_a(reseta_i);
              ELSE
                IF (rea_i='1' AND wea_i=WEA0) THEN
                  read_a(ADDRA, reseta_i);
                END IF;
              END IF;
            ELSE
              IF (rea_i='1' AND (wea_i=WEA0 OR reseta_i='1')) THEN
                read_a(ADDRA, reseta_i);
              END IF;
            END IF;

          WHEN OTHERS =>
            ASSERT FALSE REPORT "Invalid Operating Mode" SEVERITY ERROR;
        END CASE;
      END IF;
      IF (CLKB='1' AND CLKB'EVENT) THEN
        CASE WRITE_MODE_B IS
          WHEN "00" =>  -- write_first
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;

          WHEN "01" =>  -- read_first
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1') THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1') THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;

          WHEN "10" =>  -- no_change
            --Write B
            IF (web_i/=WEB0) THEN
              write_b(ADDRB, web_i, DINB);
            END IF;
            --Read B
            IF ((C_FAMILY = "spartan6") AND C_RST_PRIORITY_B="SR") THEN
              IF (resetb_i='1') THEN
                reset_b(resetb_i);
              ELSE
                IF (reb_i='1' AND web_i=WEB0) THEN
                  read_b(ADDRB, resetb_i);
                END IF;
              END IF;
            ELSE
              IF (reb_i='1' AND (web_i=WEB0 OR resetb_i='1')) THEN
                read_b(ADDRB, resetb_i);
              END IF;
            END IF;

          WHEN OTHERS =>
            ASSERT FALSE REPORT "Invalid Operating Mode" SEVERITY ERROR;
        END CASE;
      END IF;
    END IF;  -- Asynchronous clocks

    -- Assign the memory VARIABLE to the user_visible memory_i SIGNAL
    IF(DEBUG=1) THEN
      memory_i           <= memory;
      doublebit_error_i  <= doublebit_error;
      current_contents_i <= current_contents_var;
    END IF;

  END PROCESS;

  --********************************************************************
  -- Instantiate the VARIABLE depth output stage
  --********************************************************************
  -- Port A
  reg_a : BLK_MEM_GEN_V4_1_output_stage
    GENERIC MAP(
      C_FAMILY                 => C_FAMILY,
      C_XDEVICEFAMILY          => C_XDEVICEFAMILY,
      C_RST_TYPE               => C_RST_TYPE,
      C_HAS_RST                => C_HAS_RSTA,
      C_RSTRAM                 => C_RSTRAM_A,
      C_RST_PRIORITY           => C_RST_PRIORITY_A,
      init_val                 => INITA_VAL,
      C_HAS_EN                 => C_HAS_ENA,
      C_HAS_REGCE              => C_HAS_REGCEA,
      C_DATA_WIDTH             => C_READ_WIDTH_A,
      C_ADDRB_WIDTH            => C_ADDRB_WIDTH,
      C_HAS_MEM_OUTPUT_REGS    => C_HAS_MEM_OUTPUT_REGS_A,
      C_USE_SOFTECC            => C_USE_SOFTECC,
      C_USE_ECC                => C_USE_ECC,
      NUM_STAGES               => NUM_OUTPUT_STAGES_A,
      FLOP_DELAY               => FLOP_DELAY
    )
    PORT MAP (
      CLK          => CLKA,
      RST          => RSTA,
      EN           => ENA,
      REGCE        => REGCEA,
      DIN          => memory_out_a,
      DOUT         => DOUTA,
      SBITERR_IN   => '0',
      DBITERR_IN   => '0',
      SBITERR      => OPEN,
      DBITERR      => OPEN,
      RDADDRECC_IN => (OTHERS => '0'),
      RDADDRECC    => OPEN
    );

  -- Port B 
  reg_b : BLK_MEM_GEN_V4_1_output_stage
    GENERIC MAP(
      C_FAMILY                 => C_FAMILY,
      C_XDEVICEFAMILY          => C_XDEVICEFAMILY,
      C_RST_TYPE               => C_RST_TYPE,
      C_HAS_RST                => C_HAS_RSTB,
      C_RSTRAM                 => C_RSTRAM_B,
      C_RST_PRIORITY           => C_RST_PRIORITY_B,
      init_val                 => INITB_VAL,
      C_HAS_EN                 => C_HAS_ENB,
      C_HAS_REGCE              => C_HAS_REGCEB,
      C_DATA_WIDTH             => C_READ_WIDTH_B,
      C_ADDRB_WIDTH            => C_ADDRB_WIDTH,
      C_HAS_MEM_OUTPUT_REGS    => C_HAS_MEM_OUTPUT_REGS_B,
      C_USE_SOFTECC            => C_USE_SOFTECC,
      C_USE_ECC                => C_USE_ECC,
      NUM_STAGES               => NUM_OUTPUT_STAGES_B,
      FLOP_DELAY               => FLOP_DELAY
    )
    PORT MAP (
      CLK          => CLKB,
      RST          => RSTB,
      EN           => ENB,
      REGCE        => REGCEB,
      DIN          => memory_out_b,
      DOUT         => doutb_i,
      SBITERR_IN   => sbiterr_in,
      DBITERR_IN   => dbiterr_in,
      SBITERR      => sbiterr_i,
      DBITERR      => dbiterr_i,
      RDADDRECC_IN => rdaddrecc_in,
      RDADDRECC    => rdaddrecc_i
    );

  --********************************************************************
  -- Instantiate the input / Output Register stages
  --********************************************************************
output_reg_stage: BLK_MEM_GEN_V4_1_softecc_output_reg_stage
GENERIC MAP(
  C_DATA_WIDTH                => C_READ_WIDTH_B,
  C_ADDRB_WIDTH               => C_ADDRB_WIDTH,
  C_HAS_SOFTECC_OUTPUT_REGS_A => C_HAS_SOFTECC_OUTPUT_REGS_A,
  C_HAS_SOFTECC_OUTPUT_REGS_B => C_HAS_SOFTECC_OUTPUT_REGS_B,
  C_USE_SOFTECC               => C_USE_SOFTECC,
  FLOP_DELAY                  => FLOP_DELAY
)
PORT MAP(
  CLK          => CLKB,
  DIN          => doutb_i,
  DOUT         => DOUTB,
  SBITERR_IN   => sbiterr_i,
  DBITERR_IN   => dbiterr_i,
  SBITERR      => sbiterr_sdp,
  DBITERR      => dbiterr_sdp,
  RDADDRECC_IN => rdaddrecc_i,
  RDADDRECC    => rdaddrecc_sdp
);

  --*********************************
  -- Synchronous collision checks
  --*********************************
  sync_coll:  IF (C_DISABLE_WARN_BHV_COLL=0 AND C_COMMON_CLK=1) GENERATE
    PROCESS (CLKA)
      use IEEE.STD_LOGIC_TEXTIO.ALL;
      -- collision detect
      VARIABLE is_collision   : BOOLEAN;
      VARIABLE message        : LINE;
    BEGIN
      IF (CLKA='1' AND CLKA'EVENT) THEN
        -- Possible collision if both are enabled and the addresses match

        IF (ena_i='1' AND enb_i='1') THEN
          is_collision := collision_check(ADDRA,
                                          wea_i/=WEA0,
                                          ADDRB,
                                          web_i/=WEB0);
        ELSE
          is_collision := false;
        END IF;

        -- If the write port is in READ_FIRST mode, there is no collision
        IF (C_WRITE_MODE_A="READ_FIRST" AND wea_i/=WEA0 AND web_i=WEB0) THEN
          is_collision := false;
        END IF;
        IF (C_WRITE_MODE_B="READ_FIRST" AND web_i/=WEB0 AND wea_i=WEA0) THEN
          is_collision := false;
        END IF;

      -- Only flag if one of the accesses is a write
      IF (is_collision AND (wea_i/=WEA0 OR web_i/=WEB0)) THEN
        write(message, C_CORENAME);
        write(message, STRING'(" WARNING: collision detected: "));

        IF (wea_i/=WEA0) THEN
          write(message, STRING'("A write address: "));
        ELSE
          write(message, STRING'("A read address: "));
        END IF;
        write(message, ADDRA);
        IF (web_i/=WEB0) THEN
          write(message, STRING'(", B write address: "));
        ELSE
          write(message, STRING'(", B read address: "));
        END IF;
        write(message, ADDRB);
        write(message, LF);
        ASSERT false REPORT message.ALL SEVERITY WARNING;
        deallocate(message);
      END IF;

    END IF;
  END PROCESS;
END GENERATE;

  --*********************************
  -- Asynchronous collision checks
  --*********************************
  async_coll:  IF (C_DISABLE_WARN_BHV_COLL=0 AND C_COMMON_CLK=0) GENERATE

  SIGNAL addra_delay : STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
  SIGNAL wea_delay   : STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0);
  SIGNAL ena_delay   : STD_LOGIC;
  SIGNAL addrb_delay : STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0);
  SIGNAL web_delay   : STD_LOGIC_VECTOR(C_WEB_WIDTH-1 DOWNTO 0);
  SIGNAL enb_delay   : STD_LOGIC;

BEGIN

  -- Delay A and B addresses in order to mimic setup/hold times
  PROCESS (ADDRA, wea_i, ena_i, ADDRB, web_i, enb_i)
  BEGIN
    addra_delay <= ADDRA AFTER COLL_DELAY;
    wea_delay   <= wea_i AFTER COLL_DELAY;
    ena_delay   <= ena_i AFTER COLL_DELAY;
    addrb_delay <= ADDRB AFTER COLL_DELAY;
    web_delay   <= web_i AFTER COLL_DELAY;
    enb_delay   <= enb_i AFTER COLL_DELAY;
  END PROCESS;

  -- Do the checks w/rt A
  PROCESS (CLKA)
    use IEEE.STD_LOGIC_TEXTIO.ALL;
    VARIABLE is_collision_a       : BOOLEAN;
    VARIABLE is_collision_delay_a : BOOLEAN;
    VARIABLE message              : LINE;
  BEGIN

    -- Possible collision if both are enabled and the addresses match
    IF (ena_i='1' AND enb_i='1') THEN
      is_collision_a := collision_check(ADDRA,
                                        wea_i/=WEA0,
                                        ADDRB,
                                        web_i/=WEB0);
    ELSE
      is_collision_a := false;
    END IF;

    IF (ena_i='1' AND enb_delay='1') THEN
      is_collision_delay_a := collision_check(ADDRA,
                                              wea_i/=WEA0,
                                              addrb_delay,
                                              web_delay/=WEB0);
    ELSE
      is_collision_delay_a := false;
    END IF;


    -- Only flag if B access is a write
    IF (is_collision_a AND web_i/=WEB0) THEN
      write(message, C_CORENAME);
      write(message, STRING'(" WARNING: collision detected: "));
      IF (wea_i/=WEA0) THEN
        write(message, STRING'("A write address: "));
      ELSE
        write(message, STRING'("A read address: "));
      END IF;
      write(message, ADDRA);
      write(message, STRING'(", B write address: "));
      write(message, ADDRB);
      write(message, LF);
      ASSERT false REPORT message.ALL SEVERITY WARNING;
      deallocate(message);
    ELSIF (is_collision_delay_a AND web_delay/=WEB0) THEN
      write(message, C_CORENAME);
      write(message, STRING'(" WARNING: collision detected: "));
      IF (wea_i/=WEA0) THEN
        write(message, STRING'("A write address: "));
      ELSE
        write(message, STRING'("A read address: "));
      END IF;
      write(message, ADDRA);
      write(message, STRING'(", B write address: "));
      write(message, addrb_delay);
      write(message, LF);
      ASSERT false REPORT message.ALL SEVERITY WARNING;
      deallocate(message);
    END IF;

  END PROCESS;

  -- Do the checks w/rt B
  PROCESS (CLKB)
    use IEEE.STD_LOGIC_TEXTIO.ALL;
    VARIABLE is_collision_b       : BOOLEAN;
    VARIABLE is_collision_delay_b : BOOLEAN;
    VARIABLE message              : LINE;
  BEGIN

    -- Possible collision if both are enabled and the addresses match
    IF (ena_i='1' AND enb_i='1') THEN
      is_collision_b := collision_check(ADDRA,
                                        wea_i/=WEA0,
                                        ADDRB,
                                        web_i/=WEB0);
    ELSE
      is_collision_b := false;
    END IF;

    IF (ena_i='1' AND enb_delay='1') THEN
      is_collision_delay_b := collision_check(ADDRA,
                                              wea_i/=WEA0,
                                              addrb_delay,
                                              web_delay/=WEB0);
    ELSE
      is_collision_delay_b := false;
    END IF;

    -- Only flag if A access is a write
    -- Modified condition checking (is_collision_b AND WEA0_i=/WEA0) to fix CR526228
    IF (is_collision_b AND wea_i/=WEA0) THEN
      write(message, C_CORENAME);
      write(message, STRING'(" WARNING: collision detected: "));
      write(message, STRING'("A write address: "));
      write(message, ADDRA);
      IF (web_i/=WEB0) THEN
        write(message, STRING'(", B write address: "));
      ELSE
        write(message, STRING'(", B read address: "));
      END IF;
      write(message, ADDRB);
      write(message, LF);
      ASSERT false REPORT message.ALL SEVERITY WARNING;
      deallocate(message);
    ELSIF (is_collision_delay_b AND wea_delay/=WEA0) THEN
      write(message, C_CORENAME);
      write(message, STRING'(" WARNING: collision detected: "));
      write(message, STRING'("A write address: "));
      write(message, addra_delay);
      IF (web_i/=WEB0) THEN
        write(message, STRING'(", B write address: "));
      ELSE
        write(message, STRING'(", B read address: "));
      END IF;
      write(message, ADDRB);
      write(message, LF);
      ASSERT false REPORT message.ALL SEVERITY WARNING;
      deallocate(message);
    END IF;

  END PROCESS;
END GENERATE;

END mem_module_behavioral;

--******************************************************************************
-- Top module that wraps SoftECC Input register stage and the main memory module
--
-- This module is the top-level of behavioral model
--******************************************************************************
LIBRARY STD;
USE STD.TEXTIO.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BLK_MEM_GEN_V4_1 IS
GENERIC (
  C_CORENAME                : STRING  := "blk_mem_gen_v4_1";
  C_FAMILY                  : STRING  := "virtex6";
  C_XDEVICEFAMILY           : STRING  := "virtex6";
  C_MEM_TYPE                : INTEGER := 2;
  C_BYTE_SIZE               : INTEGER := 8;
  C_ALGORITHM               : INTEGER := 2;
  C_PRIM_TYPE               : INTEGER := 3;
  C_LOAD_INIT_FILE          : INTEGER := 0;
  C_INIT_FILE_NAME          : STRING  := "";
  C_USE_DEFAULT_DATA        : INTEGER := 0;
  C_DEFAULT_DATA            : STRING  := "";
  C_RST_TYPE                : STRING  := "SYNC";
  C_HAS_RSTA                : INTEGER := 0;
  C_RST_PRIORITY_A          : STRING  := "CE";
  C_RSTRAM_A                : INTEGER := 0;
  C_INITA_VAL               : STRING  := "";
  C_HAS_ENA                 : INTEGER := 1;
  C_HAS_REGCEA              : INTEGER := 0;
  C_USE_BYTE_WEA            : INTEGER := 0;
  C_WEA_WIDTH               : INTEGER := 1;
  C_WRITE_MODE_A            : STRING  := "WRITE_FIRST";
  C_WRITE_WIDTH_A           : INTEGER := 32;
  C_READ_WIDTH_A            : INTEGER := 32;
  C_WRITE_DEPTH_A           : INTEGER := 64;
  C_READ_DEPTH_A            : INTEGER := 64;
  C_ADDRA_WIDTH             : INTEGER := 6;
  C_HAS_RSTB                : INTEGER := 0;
  C_RST_PRIORITY_B          : STRING  := "CE";
  C_RSTRAM_B                : INTEGER := 0;
  C_INITB_VAL               : STRING  := "";
  C_HAS_ENB                 : INTEGER := 1;
  C_HAS_REGCEB              : INTEGER := 0;
  C_USE_BYTE_WEB            : INTEGER := 0;
  C_WEB_WIDTH               : INTEGER := 1;
  C_WRITE_MODE_B            : STRING  := "WRITE_FIRST";
  C_WRITE_WIDTH_B           : INTEGER := 32;
  C_READ_WIDTH_B            : INTEGER := 32;
  C_WRITE_DEPTH_B           : INTEGER := 64;
  C_READ_DEPTH_B            : INTEGER := 64;
  C_ADDRB_WIDTH             : INTEGER := 6;
  C_HAS_MEM_OUTPUT_REGS_A   : INTEGER := 0;
  C_HAS_MEM_OUTPUT_REGS_B   : INTEGER := 0;
  C_HAS_MUX_OUTPUT_REGS_A   : INTEGER := 0;
  C_HAS_MUX_OUTPUT_REGS_B   : INTEGER := 0;
  C_HAS_SOFTECC_INPUT_REGS_A  : INTEGER := 0;
  C_HAS_SOFTECC_INPUT_REGS_B  : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_A : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_B : INTEGER := 0;
  C_MUX_PIPELINE_STAGES     : INTEGER := 0;
  C_USE_SOFTECC             : INTEGER := 0;
  C_USE_ECC                 : INTEGER := 0;
  C_HAS_INJECTERR           : INTEGER := 0;
  C_SIM_COLLISION_CHECK     : STRING  := "NONE";
  C_COMMON_CLK              : INTEGER := 1;
  C_DISABLE_WARN_BHV_COLL   : INTEGER := 0;
  C_DISABLE_WARN_BHV_RANGE  : INTEGER := 0
);
PORT (
  CLKA          : IN  STD_LOGIC;
  RSTA          : IN  STD_LOGIC := '0';
  ENA           : IN  STD_LOGIC := '1';
  REGCEA        : IN  STD_LOGIC := '1';
  WEA           : IN  STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  ADDRA         : IN  STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
  DINA          : IN  STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0)
                      := (OTHERS => '0');
  DOUTA         : OUT STD_LOGIC_VECTOR(C_READ_WIDTH_A-1 DOWNTO 0);
  CLKB          : IN  STD_LOGIC := '0';
  RSTB          : IN  STD_LOGIC := '0';
  ENB           : IN  STD_LOGIC := '1';
  REGCEB        : IN  STD_LOGIC := '1';
  WEB           : IN  STD_LOGIC_VECTOR(C_WEB_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  ADDRB         : IN  STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  DINB          : IN  STD_LOGIC_VECTOR(C_WRITE_WIDTH_B-1 DOWNTO 0)
                      := (OTHERS => '0');
  DOUTB         : OUT STD_LOGIC_VECTOR(C_READ_WIDTH_B-1 DOWNTO 0);
  INJECTSBITERR : IN STD_LOGIC := '0';
  INJECTDBITERR : IN STD_LOGIC := '0';
  SBITERR       : OUT STD_LOGIC;
  DBITERR       : OUT STD_LOGIC;
  RDADDRECC     : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
);
END BLK_MEM_GEN_V4_1;
--******************************
-- Port and Generic Definitions
--******************************
  ---------------------------------------------------------------------------
  -- Generic Definitions
  ---------------------------------------------------------------------------
  -- C_CORENAME              : Instance name of the Block Memory Generator core
  -- C_FAMILY,C_XDEVICEFAMILY: Designates architecture targeted. The following
  --                           options are available - "spartan3", "spartan6", 
  --                           "virtex4", "virtex5", "virtex6l" and "virtex6".
  -- C_MEM_TYPE              : Designates memory type.
  --                           It can be
  --                           0 - Single Port Memory
  --                           1 - Simple Dual Port Memory
  --                           2 - True Dual Port Memory
  --                           3 - Single Port Read Only Memory
  --                           4 - Dual Port Read Only Memory
  -- C_BYTE_SIZE             : Size of a byte (8 or 9 bits)
  -- C_ALGORITHM             : Designates the algorithm method used
  --                           for constructing the memory.
  --                           It can be Fixed_Primitives, Minimum_Area or 
  --                           Low_Power
  -- C_PRIM_TYPE             : Designates the user selected primitive used to 
  --                           construct the memory.
  --
  -- C_LOAD_INIT_FILE        : Designates the use of an initialization file to
  --                           initialize memory contents.
  -- C_INIT_FILE_NAME        : Memory initialization file name.
  -- C_USE_DEFAULT_DATA      : Designates whether to fill remaining
  --                           initialization space with default data
  -- C_DEFAULT_DATA          : Default value of all memory locations
  --                           not initialized by the memory
  --                           initialization file.
  -- C_RST_TYPE              : Type of reset - Synchronous or Asynchronous
  --
  -- C_HAS_RSTA              : Determines the presence of the RSTA port
  -- C_RST_PRIORITY_A        : Determines the priority between CE and SR for 
  --                           Port A.
  -- C_RSTRAM_A              : Determines if special reset behavior is used for
  --                           Port A
  -- C_INITA_VAL             : The initialization value for Port A
  -- C_HAS_ENA               : Determines the presence of the ENA port
  -- C_HAS_REGCEA            : Determines the presence of the REGCEA port
  -- C_USE_BYTE_WEA          : Determines if the Byte Write is used or not.
  -- C_WEA_WIDTH             : The width of the WEA port
  -- C_WRITE_MODE_A          : Configurable write mode for Port A. It can be
  --                           WRITE_FIRST, READ_FIRST or NO_CHANGE.
  -- C_WRITE_WIDTH_A         : Memory write width for Port A.
  -- C_READ_WIDTH_A          : Memory read width for Port A.
  -- C_WRITE_DEPTH_A         : Memory write depth for Port A.
  -- C_READ_DEPTH_A          : Memory read depth for Port A.
  -- C_ADDRA_WIDTH           : Width of the ADDRA input port
  -- C_HAS_RSTB              : Determines the presence of the RSTB port
  -- C_RST_PRIORITY_B        : Determines the priority between CE and SR for 
  --                           Port B.
  -- C_RSTRAM_B              : Determines if special reset behavior is used for
  --                           Port B
  -- C_INITB_VAL             : The initialization value for Port B
  -- C_HAS_ENB               : Determines the presence of the ENB port
  -- C_HAS_REGCEB            : Determines the presence of the REGCEB port
  -- C_USE_BYTE_WEB          : Determines if the Byte Write is used or not.
  -- C_WEB_WIDTH             : The width of the WEB port
  -- C_WRITE_MODE_B          : Configurable write mode for Port B. It can be
  --                           WRITE_FIRST, READ_FIRST or NO_CHANGE.
  -- C_WRITE_WIDTH_B         : Memory write width for Port B.
  -- C_READ_WIDTH_B          : Memory read width for Port B.
  -- C_WRITE_DEPTH_B         : Memory write depth for Port B.
  -- C_READ_DEPTH_B          : Memory read depth for Port B.
  -- C_ADDRB_WIDTH           : Width of the ADDRB input port
  -- C_HAS_MEM_OUTPUT_REGS_A : Designates the use of a register at the output 
  --                           of the RAM primitive for Port A.
  -- C_HAS_MEM_OUTPUT_REGS_B : Designates the use of a register at the output 
  --                           of the RAM primitive for Port B.
  -- C_HAS_MUX_OUTPUT_REGS_A : Designates the use of a register at the output
  --                           of the MUX for Port A.
  -- C_HAS_MUX_OUTPUT_REGS_B : Designates the use of a register at the output
  --                           of the MUX for Port B.
  -- C_MUX_PIPELINE_STAGES   : Designates the number of pipeline stages in 
  --                           between the muxes.
  -- C_USE_SOFTECC           : Determines if the Soft ECC feature is used or
  --                           not. Only applicable Spartan-6
  -- C_USE_ECC               : Determines if the ECC feature is used or
  --                           not. Only applicable for V5 and V6
  -- C_HAS_INJECTERR         : Determines if the error injection pins
  --                           are present or not. If the ECC feature
  --                           is not used, this value is defaulted to
  --                           0, else the following are the allowed 
  --                           values:
  --                         0 : No INJECTSBITERR or INJECTDBITERR pins
  --                         1 : Only INJECTSBITERR pin exists
  --                         2 : Only INJECTDBITERR pin exists
  --                         3 : Both INJECTSBITERR and INJECTDBITERR pins exist
  -- C_SIM_COLLISION_CHECK   : Controls the disabling of Unisim model collision
  --                           warnings. It can be "ALL", "NONE", 
  --                           "Warnings_Only" or "Generate_X_Only".
  -- C_COMMON_CLK            : Determins if the core has a single CLK input.
  -- C_DISABLE_WARN_BHV_COLL : Controls the Behavioral Model Collision warnings
  -- C_DISABLE_WARN_BHV_RANGE: Controls the Behavioral Model Out of Range 
  --                           warnings
  ---------------------------------------------------------------------------
  -- Port Definitions
  ---------------------------------------------------------------------------
  -- CLKA    : Clock to synchronize all read and write operations of Port A.
  -- RSTA    : Reset input to reset memory outputs to a user-defined 
  --           reset state for Port A.
  -- ENA     : Enable all read and write operations of Port A.
  -- REGCEA  : Register Clock Enable to control each pipeline output
  --           register stages for Port A.
  -- WEA     : Write Enable to enable all write operations of Port A.
  -- ADDRA   : Address of Port A.
  -- DINA    : Data input of Port A.
  -- DOUTA   : Data output of Port A.
  -- CLKB    : Clock to synchronize all read and write operations of Port B.
  -- RSTB    : Reset input to reset memory outputs to a user-defined 
  --           reset state for Port B.
  -- ENB     : Enable all read and write operations of Port B.
  -- REGCEB  : Register Clock Enable to control each pipeline output
  --           register stages for Port B.
  -- WEB     : Write Enable to enable all write operations of Port B.
  -- ADDRB   : Address of Port B.
  -- DINB    : Data input of Port B.
  -- DOUTB   : Data output of Port B.
  -- INJECTSBITERR : Single Bit ECC Error Injection Pin.
  -- INJECTDBITERR : Double Bit ECC Error Injection Pin.
  -- SBITERR       : Output signal indicating that a Single Bit ECC Error has been
  --                 detected and corrected.
  -- DBITERR       : Output signal indicating that a Double Bit ECC Error has been
  --                 detected.
  -- RDADDRECC     : Read Address Output signal indicating address at which an
  --                 ECC error has occurred.
  ---------------------------------------------------------------------------

ARCHITECTURE behavioral OF BLK_MEM_GEN_V4_1 IS 

COMPONENT BLK_MEM_GEN_V4_1_mem_module 
GENERIC (
  C_CORENAME                : STRING  := "blk_mem_gen_v4_1";
  C_FAMILY                  : STRING  := "virtex6";
  C_XDEVICEFAMILY           : STRING  := "virtex6";
  C_MEM_TYPE                : INTEGER := 2;
  C_BYTE_SIZE               : INTEGER := 8;
  C_ALGORITHM               : INTEGER := 2;
  C_PRIM_TYPE               : INTEGER := 3;
  C_LOAD_INIT_FILE          : INTEGER := 0;
  C_INIT_FILE_NAME          : STRING  := "";
  C_USE_DEFAULT_DATA        : INTEGER := 0;
  C_DEFAULT_DATA            : STRING  := "";
  C_RST_TYPE                : STRING  := "SYNC";
  C_HAS_RSTA                : INTEGER := 0;
  C_RST_PRIORITY_A          : STRING  := "CE";
  C_RSTRAM_A                : INTEGER := 0;
  C_INITA_VAL               : STRING  := "";
  C_HAS_ENA                 : INTEGER := 1;
  C_HAS_REGCEA              : INTEGER := 0;
  C_USE_BYTE_WEA            : INTEGER := 0;
  C_WEA_WIDTH               : INTEGER := 1;
  C_WRITE_MODE_A            : STRING  := "WRITE_FIRST";
  C_WRITE_WIDTH_A           : INTEGER := 32;
  C_READ_WIDTH_A            : INTEGER := 32;
  C_WRITE_DEPTH_A           : INTEGER := 64;
  C_READ_DEPTH_A            : INTEGER := 64;
  C_ADDRA_WIDTH             : INTEGER := 6;
  C_HAS_RSTB                : INTEGER := 0;
  C_RST_PRIORITY_B          : STRING  := "CE";
  C_RSTRAM_B                : INTEGER := 0;
  C_INITB_VAL               : STRING  := "";
  C_HAS_ENB                 : INTEGER := 1;
  C_HAS_REGCEB              : INTEGER := 0;
  C_USE_BYTE_WEB            : INTEGER := 0;
  C_WEB_WIDTH               : INTEGER := 1;
  C_WRITE_MODE_B            : STRING  := "WRITE_FIRST";
  C_WRITE_WIDTH_B           : INTEGER := 32;
  C_READ_WIDTH_B            : INTEGER := 32;
  C_WRITE_DEPTH_B           : INTEGER := 64;
  C_READ_DEPTH_B            : INTEGER := 64;
  C_ADDRB_WIDTH             : INTEGER := 6;
  C_HAS_MEM_OUTPUT_REGS_A   : INTEGER := 0;
  C_HAS_MEM_OUTPUT_REGS_B   : INTEGER := 0;
  C_HAS_MUX_OUTPUT_REGS_A   : INTEGER := 0;
  C_HAS_MUX_OUTPUT_REGS_B   : INTEGER := 0;
  C_HAS_SOFTECC_INPUT_REGS_A  : INTEGER := 0;
  C_HAS_SOFTECC_INPUT_REGS_B  : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_A : INTEGER := 0;
  C_HAS_SOFTECC_OUTPUT_REGS_B : INTEGER := 0;
  C_MUX_PIPELINE_STAGES     : INTEGER := 0;
  C_USE_SOFTECC             : INTEGER := 0;
  C_USE_ECC                 : INTEGER := 0;
  C_HAS_INJECTERR           : INTEGER := 0;
  C_SIM_COLLISION_CHECK     : STRING  := "NONE";
  C_COMMON_CLK              : INTEGER := 1;
  FLOP_DELAY                : TIME    := 100 ps;
  C_DISABLE_WARN_BHV_COLL   : INTEGER := 0;
  C_DISABLE_WARN_BHV_RANGE  : INTEGER := 0
);
PORT (
  CLKA          : IN  STD_LOGIC;
  RSTA          : IN  STD_LOGIC := '0';
  ENA           : IN  STD_LOGIC := '1';
  REGCEA        : IN  STD_LOGIC := '1';
  WEA           : IN  STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  ADDRA         : IN  STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
  DINA          : IN  STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0)
                      := (OTHERS => '0');
  DOUTA         : OUT STD_LOGIC_VECTOR(C_READ_WIDTH_A-1 DOWNTO 0);
  CLKB          : IN  STD_LOGIC := '0';
  RSTB          : IN  STD_LOGIC := '0';
  ENB           : IN  STD_LOGIC := '1';
  REGCEB        : IN  STD_LOGIC := '1';
  WEB           : IN  STD_LOGIC_VECTOR(C_WEB_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  ADDRB         : IN  STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
                      := (OTHERS => '0');
  DINB          : IN  STD_LOGIC_VECTOR(C_WRITE_WIDTH_B-1 DOWNTO 0)
                      := (OTHERS => '0');
  DOUTB         : OUT STD_LOGIC_VECTOR(C_READ_WIDTH_B-1 DOWNTO 0);
  INJECTSBITERR : IN STD_LOGIC := '0';
  INJECTDBITERR : IN STD_LOGIC := '0';
  SBITERR       : OUT STD_LOGIC;
  DBITERR       : OUT STD_LOGIC;
  RDADDRECC     : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
);
END COMPONENT BLK_MEM_GEN_V4_1_mem_module;

  CONSTANT FLOP_DELAY  : TIME    := 100 ps;

  SIGNAL rsta_in          : STD_LOGIC := '1';
  SIGNAL ena_in           : STD_LOGIC := '1';
  SIGNAL regcea_in        : STD_LOGIC := '1';
  SIGNAL wea_in           : STD_LOGIC_VECTOR(C_WEA_WIDTH-1 DOWNTO 0):= (OTHERS => '0');
  SIGNAL addra_in         : STD_LOGIC_VECTOR(C_ADDRA_WIDTH-1 DOWNTO 0);
  SIGNAL dina_in          : STD_LOGIC_VECTOR(C_WRITE_WIDTH_A-1 DOWNTO 0):= (OTHERS => '0');

  SIGNAL injectsbiterr_in    : STD_LOGIC := '0';
  SIGNAL injectdbiterr_in    : STD_LOGIC := '0';
BEGIN -- Architecture
  --***************************************************************************
  -- NO INPUT STAGE
  --***************************************************************************
  no_input_stage: IF (C_HAS_SOFTECC_INPUT_REGS_A=0) GENERATE
      rsta_in    <= RSTA;
      ena_in     <= ENA;
      regcea_in  <= REGCEA;
      wea_in     <= WEA;
      addra_in   <= ADDRA;
      dina_in    <= DINA;
      injectsbiterr_in <= INJECTSBITERR;
      injectdbiterr_in <= INJECTDBITERR;
  END GENERATE no_input_stage;

 --****************************************************************************
 -- WITH INPUT STAGE
 --****************************************************************************
  has_input_stage: IF (C_HAS_SOFTECC_INPUT_REGS_A=1) GENERATE
    PROCESS (CLKA)
    BEGIN
       IF (CLKA'EVENT AND CLKA = '1') THEN
          rsta_in    <= RSTA AFTER FLOP_DELAY;
          ena_in     <= ENA AFTER FLOP_DELAY;
          regcea_in  <= REGCEA AFTER FLOP_DELAY;
          wea_in     <= WEA AFTER FLOP_DELAY;
          addra_in   <= ADDRA AFTER FLOP_DELAY;
          dina_in    <= DINA AFTER FLOP_DELAY;
          injectsbiterr_in <= INJECTSBITERR AFTER FLOP_DELAY;
          injectdbiterr_in <= INJECTDBITERR AFTER FLOP_DELAY;
       END IF;
     
    END PROCESS;
    
  END GENERATE has_input_stage;

mem_module: BLK_MEM_GEN_V4_1_mem_module 
GENERIC MAP(
  C_CORENAME                  => C_CORENAME,
  C_FAMILY                    => C_FAMILY, 
  C_XDEVICEFAMILY             => C_XDEVICEFAMILY,
  C_MEM_TYPE                  => C_MEM_TYPE,
  C_BYTE_SIZE                 => C_BYTE_SIZE,
  C_ALGORITHM                 => C_ALGORITHM,
  C_PRIM_TYPE                 => C_PRIM_TYPE,
  C_LOAD_INIT_FILE            => C_LOAD_INIT_FILE,
  C_INIT_FILE_NAME            => C_INIT_FILE_NAME,
  C_USE_DEFAULT_DATA          => C_USE_DEFAULT_DATA,
  C_DEFAULT_DATA              => C_DEFAULT_DATA,
  C_RST_TYPE                  => C_RST_TYPE,
  C_HAS_RSTA                  => C_HAS_RSTA,
  C_RST_PRIORITY_A            => C_RST_PRIORITY_A,
  C_RSTRAM_A                  => C_RSTRAM_A,
  C_INITA_VAL                 => C_INITA_VAL,
  C_HAS_ENA                   => C_HAS_ENA,
  C_HAS_REGCEA                => C_HAS_REGCEA,
  C_USE_BYTE_WEA              => C_USE_BYTE_WEA,
  C_WEA_WIDTH                 => C_WEA_WIDTH,
  C_WRITE_MODE_A              => C_WRITE_MODE_A,
  C_WRITE_WIDTH_A             => C_WRITE_WIDTH_A,
  C_READ_WIDTH_A              => C_READ_WIDTH_A,
  C_WRITE_DEPTH_A             => C_WRITE_DEPTH_A,
  C_READ_DEPTH_A              => C_READ_DEPTH_A,
  C_ADDRA_WIDTH               => C_ADDRA_WIDTH,
  C_HAS_RSTB                  => C_HAS_RSTB,
  C_RST_PRIORITY_B            => C_RST_PRIORITY_B,
  C_RSTRAM_B                  => C_RSTRAM_B,
  C_INITB_VAL                 => C_INITB_VAL,
  C_HAS_ENB                   => C_HAS_ENB,
  C_HAS_REGCEB                => C_HAS_REGCEB,
  C_USE_BYTE_WEB              => C_USE_BYTE_WEB,
  C_WEB_WIDTH                 => C_WEB_WIDTH,
  C_WRITE_MODE_B              => C_WRITE_MODE_B,
  C_WRITE_WIDTH_B             => C_WRITE_WIDTH_B,
  C_READ_WIDTH_B              => C_READ_WIDTH_B,
  C_WRITE_DEPTH_B             => C_WRITE_DEPTH_B,
  C_READ_DEPTH_B              => C_READ_DEPTH_B,
  C_ADDRB_WIDTH               => C_ADDRB_WIDTH,
  C_HAS_MEM_OUTPUT_REGS_A     => C_HAS_MEM_OUTPUT_REGS_A,
  C_HAS_MEM_OUTPUT_REGS_B     => C_HAS_MEM_OUTPUT_REGS_B,
  C_HAS_MUX_OUTPUT_REGS_A     => C_HAS_MUX_OUTPUT_REGS_A,
  C_HAS_MUX_OUTPUT_REGS_B     => C_HAS_MUX_OUTPUT_REGS_B,
  C_HAS_SOFTECC_INPUT_REGS_A  => C_HAS_SOFTECC_INPUT_REGS_A,
  C_HAS_SOFTECC_INPUT_REGS_B  => C_HAS_SOFTECC_INPUT_REGS_B,
  C_HAS_SOFTECC_OUTPUT_REGS_A => C_HAS_SOFTECC_OUTPUT_REGS_A,
  C_HAS_SOFTECC_OUTPUT_REGS_B => C_HAS_SOFTECC_OUTPUT_REGS_B,
  C_MUX_PIPELINE_STAGES       => C_MUX_PIPELINE_STAGES,
  C_USE_SOFTECC               => C_USE_SOFTECC,
  C_USE_ECC                   => C_USE_ECC,
  C_HAS_INJECTERR             => C_HAS_INJECTERR,
  C_SIM_COLLISION_CHECK       => C_SIM_COLLISION_CHECK,
  C_COMMON_CLK                => C_COMMON_CLK,
  FLOP_DELAY                  => FLOP_DELAY,
  C_DISABLE_WARN_BHV_COLL     => C_DISABLE_WARN_BHV_COLL,
  C_DISABLE_WARN_BHV_RANGE    => C_DISABLE_WARN_BHV_RANGE     
)
PORT MAP(
  CLKA          =>  CLKA, 
  RSTA          =>  rsta_in,         
  ENA           =>  ena_in,          
  REGCEA        =>  regcea_in,       
  WEA           =>  wea_in,          
  ADDRA         =>  addra_in,        
  DINA          =>  dina_in,       
  DOUTA         =>  DOUTA,        
  CLKB          =>  CLKB,       
  RSTB          =>  RSTB,        
  ENB           =>  ENB,        
  REGCEB        =>  REGCEB,
  WEB           =>  WEB,      
  ADDRB         =>  ADDRB,
  DINB          =>  DINB,       
  DOUTB         =>  DOUTB,        
  INJECTSBITERR =>  injectsbiterr_in,
  INJECTDBITERR =>  injectdbiterr_in,
  SBITERR       =>  SBITERR,   
  DBITERR       =>  DBITERR,     
  RDADDRECC     =>  RDADDRECC    
);
END behavioral;
