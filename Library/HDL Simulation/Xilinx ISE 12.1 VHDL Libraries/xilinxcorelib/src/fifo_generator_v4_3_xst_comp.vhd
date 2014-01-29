-------------------------------------------------------------------------------
-- $RCSfile: fifo_generator_v4_3_xst_comp.vhd,v $
-------------------------------------------------------------------------------
--
-- Fifo Generator - VHDL Behavioral Model Component Declaration
--
-------------------------------------------------------------------------------
--
-- Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under
-- license from Xilinx, Inc.,2 and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid
-- license agreement with Xilinx, Inc. Xilinx hereby
-- grants you a license to use this text/file solely for
-- design, simulation, implementation and creation of
-- design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly
-- prohibited and immediately terminates your license unless
-- covered by a separate agreement.
--
-- Xilinx is providing theis design, code, or information
-- "as-is" solely for use in developing programs and
-- solutions for Xilinx devices, with no obligation on the
-- part of Xilinx to provide support. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard. Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for obtaining
-- any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
--
-- Any modifications that are made to the Source Code are
-- done at the user's sole risk and will be unsupported.
-- The Xilinx Support Hotline does not have access to source
-- code and therefore cannot answer specific questions related
-- to source HDL. The Xilinx Hotline support of original source
-- code IP shall only address issues and questions related
-- to source HDL. The Xilinx Hotline support of original source
-- code IP shall only address issues and questions related
-- to standard Netlist version of the core (and thus
-- indirectly, the original core source).
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c)Copyright 1995-2006 Xilinx, Inc.
-- All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Filename: fifo_generator_v4_3_comp.vhd
--
-- Description:
--  The behavioral model for the FIFO Generator core.
--
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE fifo_generator_v4_3_xst_comp IS

 COMPONENT fifo_generator_v4_3_xst
  GENERIC (
    ----------------------------------------------------------------------------
    -- Generic Declarations (alphabetical)
    ----------------------------------------------------------------------------
    C_COMMON_CLOCK                : integer := 0;
    C_COUNT_TYPE                  : integer := 0;
    C_DATA_COUNT_WIDTH            : integer := 2;
    C_DEFAULT_VALUE               : string  := "";
    C_DIN_WIDTH                   : integer := 8;
    C_DOUT_RST_VAL                : string  := "";
    C_DOUT_WIDTH                  : integer := 8;
    C_ENABLE_RLOCS                : integer := 0;
    C_FAMILY                      : string  := "";
    C_HAS_ALMOST_EMPTY            : integer := 0;
    C_HAS_ALMOST_FULL             : integer := 0;
    C_HAS_BACKUP                  : integer := 0;
    C_HAS_DATA_COUNT              : integer := 0;
    C_HAS_MEMINIT_FILE            : integer := 0;
    C_HAS_INT_CLK                 : integer := 0;
    C_HAS_OVERFLOW                : integer := 0;
    C_HAS_RD_DATA_COUNT           : integer := 0;
    C_HAS_RD_RST                  : integer := 0;
    C_HAS_RST                     : integer := 1;
    C_HAS_SRST                    : integer := 0;
    C_HAS_UNDERFLOW               : integer := 0;
    C_HAS_VALID                   : integer := 0;
    C_HAS_WR_ACK                  : integer := 0;
    C_HAS_WR_DATA_COUNT           : integer := 0;
    C_HAS_WR_RST                  : integer := 0;
    C_IMPLEMENTATION_TYPE         : integer := 0;
    C_INIT_WR_PNTR_VAL            : integer := 0;
    C_MEMORY_TYPE                 : integer := 1;
    C_MIF_FILE_NAME               : string  := "";
    C_OPTIMIZATION_MODE           : integer := 0;
    C_OVERFLOW_LOW                : integer := 0;
    C_PRELOAD_REGS                : integer := 0;
    C_PRELOAD_LATENCY             : integer := 1;
    C_PRIM_FIFO_TYPE              : string  := "4kx4";
    C_PROG_EMPTY_THRESH_ASSERT_VAL: integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL: integer := 0;
    C_PROG_EMPTY_TYPE             : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_FULL_TYPE              : integer := 0;
    C_RD_DATA_COUNT_WIDTH         : integer := 2;
    C_RD_DEPTH                    : integer := 256;
    C_RD_FREQ                     : integer := 1;
    C_RD_PNTR_WIDTH               : integer := 8;
    C_UNDERFLOW_LOW               : integer := 0;
    C_USE_DOUT_RST                : integer := 0;
    C_USE_EMBEDDED_REG            : integer := 0;
    C_USE_FIFO16_FLAGS            : integer := 0;
    C_USE_FWFT_DATA_COUNT         : integer := 0;
    C_VALID_LOW                   : integer := 0;
    C_WR_ACK_LOW                  : integer := 0;
    C_WR_DATA_COUNT_WIDTH         : integer := 2;
    C_WR_DEPTH                    : integer := 256;
    C_WR_FREQ                     : integer := 1;
    C_WR_PNTR_WIDTH               : integer := 8;
    C_WR_RESPONSE_LATENCY         : integer := 1;
    C_USE_ECC                     : integer := 0;
    C_FULL_FLAGS_RST_VAL          : integer := 1;
    C_MSGON_VAL                   : integer := 1
);


  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    CLK                       : IN  std_logic := '0';
    BACKUP                    : IN  std_logic := '0';
    BACKUP_MARKER             : IN  std_logic := '0';
    DIN                       : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH         : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH          : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    RD_CLK                    : IN  std_logic := '0';
    RD_EN                     : IN  std_logic := '0';
    RD_RST                    : IN  std_logic := '0';
    RST                       : IN  std_logic := '0';
    SRST                      : IN  std_logic := '0';
    WR_CLK                    : IN  std_logic := '0';
    WR_EN                     : IN  std_logic := '0';
    WR_RST                    : IN  std_logic := '0';
    INT_CLK                   : IN  std_logic := '0';
    
    ALMOST_EMPTY              : OUT std_logic;
    ALMOST_FULL               : OUT std_logic;
    DATA_COUNT                : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
    DOUT                      : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY                     : OUT std_logic;
    FULL                      : OUT std_logic;
    OVERFLOW                  : OUT std_logic;
    PROG_EMPTY                : OUT std_logic;
    PROG_FULL                 : OUT std_logic;
    VALID                     : OUT std_logic;
    RD_DATA_COUNT             : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
    UNDERFLOW                 : OUT std_logic;
    WR_ACK                    : OUT std_logic;
    WR_DATA_COUNT             : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);
    SBITERR                   : OUT std_logic;
    DBITERR                   : OUT std_logic
    );
 END COMPONENT;

END fifo_generator_v4_3_xst_comp;
