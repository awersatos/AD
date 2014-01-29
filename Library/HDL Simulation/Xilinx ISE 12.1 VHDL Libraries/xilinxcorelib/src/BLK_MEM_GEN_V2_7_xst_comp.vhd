-------------------------------------------------------------------------------
--
-- Block Memory Generator Core - Block Memory Behavioral Model
--
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
-- Xilinx is providing this design, code, or information
-- "as-is" solely for use in developing programs and
-- solutions for Xilinx devices, with no obligation on the
-- part of Xilinx to provide support. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
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
-- to the standard Netlist version of the core (and thus
-- indirectly, the original core source).
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
-- All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Filename: blk_mem_gen_v2_7_xst_comp.vhd
--
-- Description:
--   This file is the VHDL behavioral component for the
--       Block Memory Generator Core.
--
-------------------------------------------------------------------------------
-- Author: Xilinx
--
-- History: March 24, 2006 Initial revision
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--  Top-level Entity
-------------------------------------------------------------------------------

LIBRARY std;
USE std.textio.ALL;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

package blk_mem_gen_v2_7_xst_comp is

component blk_mem_gen_v2_7_xst is
  generic (
    C_ADDRA_WIDTH             : integer := 6;
    C_ADDRB_WIDTH             : integer := 6;
    C_ALGORITHM               : integer := 2;
    C_BYTE_SIZE               : integer := 8;
    C_COMMON_CLK              : integer := 1;
    C_DEFAULT_DATA            : string  := "";
    C_DISABLE_WARN_BHV_COLL   : integer := 0;
    C_DISABLE_WARN_BHV_RANGE  : integer := 0;
--    C_ELABORATION_DIR         : string  := "";
    C_ELABORATION_DIR         : string  ;
    C_FAMILY                  : string  := "virtex4";
    C_XDEVICEFAMILY           : string  := "virtex4";
    C_HAS_ENA                 : integer := 1;
    C_HAS_ENB                 : integer := 1;
    C_HAS_MEM_OUTPUT_REGS_A   : integer := 0;
    C_HAS_MEM_OUTPUT_REGS_B   : integer := 0;
    C_HAS_MUX_OUTPUT_REGS_A   : integer := 0;
    C_HAS_MUX_OUTPUT_REGS_B   : integer := 0;
    C_MUX_PIPELINE_STAGES     : integer := 0;
    C_HAS_REGCEA              : integer := 0;
    C_HAS_REGCEB              : integer := 0;
    C_HAS_SSRA                : integer := 0;
    C_HAS_SSRB                : integer := 0;
    C_INIT_FILE_NAME          : string  := "";
    C_LOAD_INIT_FILE          : integer := 0;
    C_MEM_TYPE                : integer := 2;
    C_PRIM_TYPE               : integer := 3;
    C_READ_DEPTH_A            : integer := 64;
    C_READ_DEPTH_B            : integer := 64;
    C_READ_WIDTH_A            : integer := 32;
    C_READ_WIDTH_B            : integer := 32;
    C_SIM_COLLISION_CHECK     : string  := "NONE";
    C_SINITA_VAL              : string  := "";
    C_SINITB_VAL              : string  := "";
    C_USE_BYTE_WEA            : integer := 0;
    C_USE_BYTE_WEB            : integer := 0;
    C_USE_DEFAULT_DATA        : integer := 0;
    C_USE_ECC                 : integer := 0;
    C_WEA_WIDTH               : integer := 1;
    C_WEB_WIDTH               : integer := 1;
    C_WRITE_DEPTH_A           : integer := 64;
    C_WRITE_DEPTH_B           : integer := 64;
    C_WRITE_MODE_A            : string  := "WRITE_FIRST";
    C_WRITE_MODE_B            : string  := "WRITE_FIRST";
    C_WRITE_WIDTH_A           : integer := 32;
    C_WRITE_WIDTH_B           : integer := 32;
    C_USE_RAMB16BWER_RST_BHV  : INTEGER := 0);
  port (
    CLKA   : in  std_logic;
    DINA   : in  std_logic_vector(C_WRITE_WIDTH_A-1 downto 0)
           := (OTHERS => '0');
    ADDRA  : in  std_logic_vector(C_ADDRA_WIDTH-1 downto 0);
    ENA    : in  std_logic := '1';
    REGCEA : in  std_logic := '1';
    WEA    : in  std_logic_vector(C_WEA_WIDTH-1 downto 0)
           := (OTHERS => '0');
    SSRA   : in  std_logic := '0';
    DOUTA  : out std_logic_vector(C_READ_WIDTH_A-1 downto 0);
    CLKB   : in  std_logic := '0';
    DINB   : in  std_logic_vector(C_WRITE_WIDTH_B-1 downto 0)
           := (OTHERS => '0');
    ADDRB  : in  std_logic_vector(C_ADDRB_WIDTH-1 downto 0)
           := (OTHERS => '0');
    ENB    : in  std_logic := '1';
    REGCEB : in  std_logic := '1';
    WEB    : in  std_logic_vector(C_WEB_WIDTH-1 downto 0)
           := (OTHERS => '0');
    SSRB   : in  std_logic := '0';
    DOUTB  : out std_logic_vector(C_READ_WIDTH_B-1 downto 0);
    DBITERR : out std_logic;
    SBITERR : out std_logic
    );
end component; --blk_mem_gen_v2_7


end blk_mem_gen_v2_7_xst_comp;

