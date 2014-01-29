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
-- Filename: blk_mem_gen_v3_1_comp.vhd
--
-- Description:
--   This file is the VHDL behavioral component for the
--       Block Memory Generator Core.
--
-------------------------------------------------------------------------------
-- Author: Xilinx
--
-- History: March 24, 2006: Initial revision
--          April 07, 2009: Added new ports and generics for Virtex-6 and 
--                          Spartan-6 support.
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--  Top-level Entity
-------------------------------------------------------------------------------

LIBRARY STD;
USE STD.TEXTIO.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

PACKAGE blk_mem_gen_v3_1_comp IS

COMPONENT blk_mem_gen_v3_1 IS
  GENERIC (
  C_CORENAME                : STRING  := "blk_mem_gen_v3_1";
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
  C_MUX_PIPELINE_STAGES     : INTEGER := 0;
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
  INJECTSBITERR : IN STD_LOGIC;
  INJECTDBITERR : IN STD_LOGIC;
  SBITERR       : OUT STD_LOGIC;
  DBITERR       : OUT STD_LOGIC;
  RDADDRECC     : OUT STD_LOGIC_VECTOR(C_ADDRB_WIDTH-1 DOWNTO 0)
);
END COMPONENT; --blk_mem_gen_v3_1

-- The following tells XST that c_addsub_v9_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF blk_mem_gen_v3_1 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF blk_mem_gen_v3_1 : COMPONENT IS
    "generatecore com.xilinx.ip.blk_mem_gen_v3_1.blk_mem_gen_v3_1";
  -- xcc include

END blk_mem_gen_v3_1_comp;

