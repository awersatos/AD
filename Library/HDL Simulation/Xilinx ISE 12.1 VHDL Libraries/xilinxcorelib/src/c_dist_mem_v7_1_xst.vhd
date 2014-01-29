--------------------------------------------------------------------------------
-- $RCSfile: c_dist_mem_v7_1_xst.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 20:06:55 $
--------------------------------------------------------------------------------
--
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
--------------------------------------------------------------------------------
--
-- Simple wrapper for the c_dist_mem_v7_1 core.
-- XST cores that instantiate this core should use this wrapper.
-- This model is only for other cores that instantiate the c_dist_mem. These
-- will instantiate the c_dist_mem_v7_1_xst component.
-- This file itself is not analyzed by XST. it only requires the component
-- statement package.
-- This file is for behavioral simulation and also for use by Coregen.
--
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v7_0.ALL;
USE xilinxcorelib.c_dist_mem_v7_1_comp.ALL;


ENTITY c_dist_mem_v7_1_xst IS
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
            c_has_qdpo_rst   : INTEGER := 0;    -- RSTB
            c_has_qdpo_srst  : INTEGER := 0;
            c_has_qspo       : INTEGER := 0;
            c_has_qspo_ce    : INTEGER := 0;
            c_has_qspo_rst   : INTEGER := 0;    --RSTA
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
        qdpo      : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)); 
        
END c_dist_mem_v7_1_xst;

--
-- Instantiate the real c_dist_mem
--
ARCHITECTURE xilinx OF c_dist_mem_v7_1_xst IS
BEGIN

  dm : c_dist_mem_v7_1
  GENERIC MAP(
    c_addr_width         => c_addr_width,
    c_default_data       => c_default_data,
    c_default_data_radix => c_default_data_radix,
    c_depth              => c_depth,
    c_enable_rlocs       => c_enable_rlocs,
    c_generate_mif       => c_generate_mif,
    c_has_clk            => c_has_clk,
    c_has_d              => c_has_d,
    c_has_dpo            => c_has_dpo,
    c_has_dpra           => c_has_dpra,
    c_has_i_ce           => c_has_i_ce,
    c_has_qdpo           => c_has_qdpo,
    c_has_qdpo_ce        => c_has_qdpo_ce,
    c_has_qdpo_clk       => c_has_qdpo_clk,
    c_has_qdpo_rst       => c_has_qdpo_rst,
    c_has_qdpo_srst      => c_has_qdpo_srst,
    c_has_qspo           => c_has_qspo,
    c_has_qspo_ce        => c_has_qspo_ce,
    c_has_qspo_rst       => c_has_qspo_rst,
    c_has_qspo_srst      => c_has_qspo_srst,
    c_has_rd_en          => c_has_rd_en,
    c_has_spo            => c_has_spo,
    c_has_spra           => c_has_spra,
    c_has_we             => c_has_we,
    c_latency            => c_latency,
    c_mem_init_file      => c_mem_init_file,
    c_mem_type           => c_mem_type,
    c_mux_type           => c_mux_type,
    c_qualify_we         => c_qualify_we,
    c_qce_joined         => c_qce_joined,
    c_read_mif           => c_read_mif,
    c_reg_a_d_inputs     => c_reg_a_d_inputs,
    c_reg_dpra_input     => c_reg_dpra_input,
    c_sync_enable        => c_no_override,
    c_width              => c_width,
    c_ram32_fix          => c_ram32_fix)
  PORT MAP(
    a         => a,       
    d         => d,       
    dpra      => dpra,    
    spra      => spra,
    clk       => clk,
    we        => we,
    i_ce      => i_ce,
    rd_en     => rd_en,
    qspo_ce   => qspo_ce,
    qdpo_ce   => qdpo_ce,
    qdpo_clk  => qdpo_clk,
    qspo_rst  => qspo_rst,
    qdpo_rst  => qdpo_rst,
    qspo_srst => qspo_srst,
    qdpo_srst => qdpo_srst,
    spo       => spo,
    dpo       => dpo,
    qspo      => qspo,
    qdpo      => qdpo);
 
END xilinx;
