-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2004 Xilinx, Inc.
-- All rights reserved.
--
-- $Id: c_dist_mem_v7_1_xst_comp.vhd,v 1.10 2008/09/08 20:06:55 akennedy Exp $
--
--------------------------------------------------------------------------------
-- Description - This file contains the component declaration for
--               the c_dist_mem_v7_1 core wrapper. This wrapper allows the core
--               to be instantiated by higher level XST cores.
--               This version of the file is for simulation only. It is
--               identical to the file of the same name in the top level
--               directory, except it uses LIBRARY xilinxcorelib.
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- Note XST cannot use this file because it doesn't know what xilinxcorelib is.
LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v8_0.ALL;


PACKAGE c_dist_mem_v7_1_xst_comp IS


COMPONENT c_dist_mem_v7_1_xst
  GENERIC (
            c_addr_width     : INTEGER := 6;
            c_default_data   : STRING  := "0";
        c_default_data_radix : INTEGER := 1;
            c_depth          : INTEGER := 64;
            c_enable_rlocs   : INTEGER := 1;   -- Unused by the behavioural model
            c_generate_mif   : INTEGER := 0;   -- Unused by the behavioural model
            c_has_clk        : INTEGER := 1;
            c_has_d          : INTEGER := 1;
            c_has_dpo        : INTEGER := 0;
            c_has_dpra       : INTEGER := 0;
            c_has_i_ce       : INTEGER := 0;
            c_has_qdpo       : INTEGER := 0;
            c_has_qdpo_ce    : INTEGER := 0;
            c_has_qdpo_clk   : INTEGER := 0;
            c_has_qdpo_rst   : INTEGER := 0;    -- RSTA
            c_has_qdpo_srst  : INTEGER := 0;
            c_has_qspo       : INTEGER := 0;
            c_has_qspo_ce    : INTEGER := 0;
            c_has_qspo_rst   : INTEGER := 0;    --RSTB
            c_has_qspo_srst  : INTEGER := 0;
            c_has_rd_en      : INTEGER := 0;
            c_has_spo        : INTEGER := 1;
            c_has_spra       : INTEGER := 0;
            c_has_we         : INTEGER := 1;
            c_latency        : INTEGER := 0;
            c_mem_init_file  : STRING  := "null.mif";
            c_mem_type       : INTEGER := c_sp_ram;
            c_mux_type       : INTEGER := c_lut_based;
            c_qualify_we     : INTEGER := 0;
            c_qce_joined     : INTEGER := 0;
            c_read_mif       : INTEGER := 0;
            c_reg_a_d_inputs : INTEGER := 0;
            c_reg_dpra_input : INTEGER := 0;
            c_sync_enable    : INTEGER := 0;
            c_width          : INTEGER := 16;
            c_ram32_fix      : INTEGER := 0  -- should not be passed in to simulation model
  );
  
  PORT (a         : IN  STD_LOGIC_VECTOR(c_addr_width-1-(4*c_has_spra*BOOLEAN'POS(c_addr_width>4)) DOWNTO 0) := (OTHERS => '0');
        d         : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');
        dpra      : IN  STD_LOGIC_VECTOR(c_addr_width-1 DOWNTO 0) := (OTHERS => '0');
        spra      : IN  STD_LOGIC_VECTOR(c_addr_width-1 DOWNTO 0) := (OTHERS => '0');
        clk       : IN  STD_LOGIC := '0';
        we        : IN  STD_LOGIC := '0';
        i_ce      : IN  STD_LOGIC := '1';
        rd_en     : IN  STD_LOGIC := '0';
        qspo_ce   : IN  STD_LOGIC := '1';
        qdpo_ce   : IN  STD_LOGIC := '1';
        qdpo_clk  : IN  STD_LOGIC := '0';
        qspo_rst  : IN  STD_LOGIC := '0';
        qdpo_rst  : IN  STD_LOGIC := '0';
        qspo_srst : IN  STD_LOGIC := '0';
        qdpo_srst : IN  STD_LOGIC := '0';
        spo       : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
        dpo       : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
        qspo      : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
        qdpo      : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)
  ); 
END COMPONENT;


-- The following tells XST that this core is a black box which  
-- should be generated with the command given by the value of this attribute.
-- Note the fully qualified SIM (JAVA class) name that forms the 
-- basis of the core.
ATTRIBUTE box_type : STRING; 
ATTRIBUTE box_type OF c_dist_mem_v7_1_xst : COMPONENT IS "black_box"; 
ATTRIBUTE GENERATOR_DEFAULT : STRING; 
ATTRIBUTE GENERATOR_DEFAULT OF c_dist_mem_v7_1_xst : COMPONENT IS 
          "generatecore com.xilinx.ip.c_dist_mem_v7_1.c_dist_mem_v7_1_xst";


END c_dist_mem_v7_1_xst_comp;
