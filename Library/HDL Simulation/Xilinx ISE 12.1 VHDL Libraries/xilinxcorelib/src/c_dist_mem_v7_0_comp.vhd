-- Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
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
-- of this text at all times. (c) Copyright 1995-2003 Xilinx, Inc.
-- All rights reserved.
--
-- $Id: c_dist_mem_v7_0_comp.vhd,v 1.13 2008/09/08 20:06:53 akennedy Exp $
--
-- Filename - c_dist_mem_v7_0_comp.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description - This file contains the component declaration for
--				 the C_DIST_MEM_V7_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v7_0.all;

package c_dist_mem_v7_0_comp is


----- Component C_DIST_MEM_V7_0 -----
-- Short Description
--
-- Distributed memory
--

component C_DIST_MEM_V7_0
	GENERIC (
            C_ADDR_WIDTH     : integer := 6;
            C_DEFAULT_DATA   : string  := "0";
	    C_DEFAULT_DATA_RADIX : integer := 1;
            C_DEPTH          : integer := 64;
            C_ENABLE_RLOCS   : integer := 1;   -- Unused by the behavioural model
            C_GENERATE_MIF   : integer := 0;   -- Unused by the behavioural model
            C_HAS_CLK        : integer := 1;
            C_HAS_D          : integer := 1;
            C_HAS_DPO        : integer := 0;
            C_HAS_DPRA       : integer := 0;
            C_HAS_I_CE       : integer := 0;
            C_HAS_QDPO       : integer := 0;
            C_HAS_QDPO_CE    : integer := 0;
            C_HAS_QDPO_CLK   : integer := 0;
            C_HAS_QDPO_RST   : integer := 0;    -- RSTA
	    C_HAS_QDPO_SRST	: integer := 0;
            C_HAS_QSPO       : integer := 0;
            C_HAS_QSPO_CE    : integer := 0;
            C_HAS_QSPO_RST   : integer := 0;    --RSTB
	    C_HAS_QSPO_SRST	: integer := 0;
            C_HAS_RD_EN      : integer := 0;
            C_HAS_SPO        : integer := 1;
            C_HAS_SPRA       : integer := 0;
            C_HAS_WE         : integer := 1;
            C_LATENCY    : integer := 0;
            C_MEM_INIT_FILE  : string  := "null.mif";
            C_MEM_TYPE       : integer := c_sp_ram;
            C_MUX_TYPE       : integer := c_lut_based;
            C_QUALIFY_WE     : integer := 0;
            C_QCE_JOINED     : integer := 0;
            C_READ_MIF       : integer := 0;
            C_REG_A_D_INPUTS : integer := 0;
            C_REG_DPRA_INPUT : integer := 0;
	    C_SYNC_ENABLE    : integer := 0;
            C_WIDTH          : integer := 16;
	    C_RAM32_FIX      : integer := 0	-- should not be passed in to simulation model
  );
  
  PORT (A        : in  std_logic_vector(C_ADDR_WIDTH-1-(4*C_HAS_SPRA*boolean'pos(C_ADDR_WIDTH>4)) downto 0) := (OTHERS => '0');
        D        : in  std_logic_vector(C_WIDTH-1 downto 0) := (OTHERS => '0');
        DPRA     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (OTHERS => '0');
        SPRA     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (OTHERS => '0');
        CLK      : in  std_logic := '0';
        WE       : in  std_logic := '0';
        I_CE     : in  std_logic := '1';
        RD_EN    : in  std_logic := '0';
        QSPO_CE  : in  std_logic := '1';
        QDPO_CE  : in  std_logic := '1';
        QDPO_CLK : in  std_logic := '0';
        QSPO_RST : in std_logic := '0';
        QDPO_RST : in std_logic := '0';
	QSPO_SRST : in std_logic := '0';
	QDPO_SRST : in std_logic := '0';
        SPO      : out std_logic_vector(C_WIDTH-1 downto 0);
        DPO      : out std_logic_vector(C_WIDTH-1 downto 0);
        QSPO     : out std_logic_vector(C_WIDTH-1 downto 0);
        QDPO     : out std_logic_vector(C_WIDTH-1 downto 0)
	); 
end component;

end c_dist_mem_v7_0_comp;
