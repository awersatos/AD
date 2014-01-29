-------------------------------------------------------------------------------
--
-- Fifo Generator - VHDL Behavioral Model Component Declaration
--
-------------------------------------------------------------------------------
--
-- Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under
-- license from Xilinx, Inc., and may be used, copied
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
-- Filename: fifo_generator_v4_4_xst.vhd
--
-- Description:
--  The behavioral model for the FIFO Generator core.
--
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.fifo_generator_v4_4_comp.all;

ENTITY fifo_generator_v4_4_xst IS
  GENERIC (
    ----------------------------------------------------------------------------
    -- Generic Declarations
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
    C_PRELOAD_LATENCY             : integer := 1;
    C_PRELOAD_REGS                : integer := 0;
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
    DIN                       : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0); --
    --Mandatory input
    PROG_EMPTY_THRESH         : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH          : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    RD_CLK                    : IN  std_logic := '0';
    RD_EN                     : IN  std_logic;  --Mandatory input
    RD_RST                    : IN  std_logic := '0';
    RST                       : IN  std_logic := '0';
    SRST                      : IN  std_logic := '0';
    WR_CLK                    : IN  std_logic := '0';
    WR_EN                     : IN  std_logic;  --Mandatory input
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

END fifo_generator_v4_4_xst;



ARCHITECTURE behavioral OF fifo_generator_v4_4_xst IS

BEGIN

  BEHV: fifo_generator_v4_4
    GENERIC map(
      C_COMMON_CLOCK                 => C_COMMON_CLOCK,
      C_COUNT_TYPE                   => C_COUNT_TYPE,
      C_DATA_COUNT_WIDTH             => C_DATA_COUNT_WIDTH,
      C_DEFAULT_VALUE                => C_DEFAULT_VALUE,
      C_DIN_WIDTH                    => C_DIN_WIDTH,
      C_DOUT_RST_VAL                 => C_DOUT_RST_VAL,
      C_DOUT_WIDTH                   => C_DOUT_WIDTH,
      C_ENABLE_RLOCS                 => C_ENABLE_RLOCS,
      C_FAMILY                       => C_FAMILY,
      C_HAS_ALMOST_EMPTY             => C_HAS_ALMOST_EMPTY,
      C_HAS_ALMOST_FULL              => C_HAS_ALMOST_FULL,
      C_HAS_BACKUP                   => C_HAS_BACKUP,
      C_HAS_DATA_COUNT               => C_HAS_DATA_COUNT,
      C_HAS_MEMINIT_FILE             => C_HAS_MEMINIT_FILE,
      C_HAS_OVERFLOW                 => C_HAS_OVERFLOW,
      C_HAS_RD_DATA_COUNT            => C_HAS_RD_DATA_COUNT,
      C_HAS_RD_RST                   => C_HAS_RD_RST,
      C_HAS_RST                      => C_HAS_RST,
      C_HAS_SRST                     => C_HAS_SRST,
      C_HAS_UNDERFLOW                => C_HAS_UNDERFLOW,
      C_HAS_VALID                    => C_HAS_VALID,
      C_HAS_WR_ACK                   => C_HAS_WR_ACK,
      C_HAS_WR_DATA_COUNT            => C_HAS_WR_DATA_COUNT,
      C_HAS_WR_RST                   => C_HAS_WR_RST,
      C_IMPLEMENTATION_TYPE          => C_IMPLEMENTATION_TYPE, --Fix CR:432807 in v3.2
      C_INIT_WR_PNTR_VAL             => C_INIT_WR_PNTR_VAL,
      C_MEMORY_TYPE                  => C_MEMORY_TYPE,
      C_MIF_FILE_NAME                => C_MIF_FILE_NAME,
      C_OPTIMIZATION_MODE            => C_OPTIMIZATION_MODE,
      C_OVERFLOW_LOW                 => C_OVERFLOW_LOW,
      C_PRELOAD_LATENCY              => C_PRELOAD_LATENCY,
      C_PRELOAD_REGS                 => C_PRELOAD_REGS,
      C_PRIM_FIFO_TYPE               => C_PRIM_FIFO_TYPE, --Fix CR:432807 in v3.2
      C_PROG_EMPTY_THRESH_ASSERT_VAL => C_PROG_EMPTY_THRESH_ASSERT_VAL,
      C_PROG_EMPTY_THRESH_NEGATE_VAL => C_PROG_EMPTY_THRESH_NEGATE_VAL,
      C_PROG_EMPTY_TYPE              => C_PROG_EMPTY_TYPE,
      C_PROG_FULL_THRESH_ASSERT_VAL  => C_PROG_FULL_THRESH_ASSERT_VAL,
      C_PROG_FULL_THRESH_NEGATE_VAL  => C_PROG_FULL_THRESH_NEGATE_VAL,
      C_PROG_FULL_TYPE               => C_PROG_FULL_TYPE,
      C_RD_DATA_COUNT_WIDTH          => C_RD_DATA_COUNT_WIDTH,
      C_RD_DEPTH                     => C_RD_DEPTH,
      C_RD_FREQ                      => C_RD_FREQ,
      C_RD_PNTR_WIDTH                => C_RD_PNTR_WIDTH,
      C_UNDERFLOW_LOW                => C_UNDERFLOW_LOW,
      C_USE_DOUT_RST                 => C_USE_DOUT_RST,
      C_USE_EMBEDDED_REG             => C_USE_EMBEDDED_REG,
      C_USE_FIFO16_FLAGS             => C_USE_FIFO16_FLAGS,
      C_USE_FWFT_DATA_COUNT          => C_USE_FWFT_DATA_COUNT,
      C_VALID_LOW                    => C_VALID_LOW,
      C_WR_ACK_LOW                   => C_WR_ACK_LOW,
      C_WR_DATA_COUNT_WIDTH          => C_WR_DATA_COUNT_WIDTH,
      C_WR_DEPTH                     => C_WR_DEPTH,
      C_WR_FREQ                      => C_WR_FREQ,
      C_WR_PNTR_WIDTH                => C_WR_PNTR_WIDTH,
      C_WR_RESPONSE_LATENCY          => C_WR_RESPONSE_LATENCY,
      C_USE_ECC                      => C_USE_ECC,
      C_FULL_FLAGS_RST_VAL           => C_FULL_FLAGS_RST_VAL,
      C_HAS_INT_CLK                  => C_HAS_INT_CLK,
      C_MSGON_VAL                    => C_MSGON_VAL
      )
    PORT MAP(
      --Inputs
      CLK                       => CLK,
      BACKUP                    => BACKUP,
      BACKUP_MARKER             => BACKUP_MARKER,
      DIN                       => DIN,
      PROG_EMPTY_THRESH         => PROG_EMPTY_THRESH,
      PROG_EMPTY_THRESH_ASSERT  => PROG_EMPTY_THRESH_ASSERT,
      PROG_EMPTY_THRESH_NEGATE  => PROG_EMPTY_THRESH_NEGATE,
      PROG_FULL_THRESH          => PROG_FULL_THRESH,
      PROG_FULL_THRESH_ASSERT   => PROG_FULL_THRESH_ASSERT,
      PROG_FULL_THRESH_NEGATE   => PROG_FULL_THRESH_NEGATE,
      RD_CLK                    => RD_CLK,
      RD_EN                     => RD_EN,
      RD_RST                    => RD_RST,
      RST                       => RST,
      SRST                      => SRST,
      WR_CLK                    => WR_CLK,
      WR_EN                     => WR_EN,
      WR_RST                    => WR_RST,
      INT_CLK                   => INT_CLK,

      --Outputs
      ALMOST_EMPTY          => ALMOST_EMPTY,
      ALMOST_FULL           => ALMOST_FULL,
      DATA_COUNT            => DATA_COUNT,
      DOUT                  => DOUT,
      EMPTY                 => EMPTY,
      FULL                  => FULL,
      OVERFLOW              => OVERFLOW,
      PROG_EMPTY            => PROG_EMPTY,
      PROG_FULL             => PROG_FULL,
      RD_DATA_COUNT         => RD_DATA_COUNT,
      UNDERFLOW             => UNDERFLOW,
      VALID                 => VALID,
      WR_ACK                => WR_ACK,
      WR_DATA_COUNT         => WR_DATA_COUNT,
      SBITERR               => SBITERR,
      DBITERR               => DBITERR
      );

END behavioral;
