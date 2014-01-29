-------------------------------------------------------------------------------
-- $RCSfile: dist_mem_gen_v3_3_xst_comp.vhd,v $
-- $Revision: 1.7 $
-- $Date: 2008/09/09 19:56:22 $
-- Title      : Package containing component declaration for
--            : dist_mem_gen_v3_3_xst.vhd
-- Project    : Distributed Memory Generator
-------------------------------------------------------------------------------
-- File       : dist_mem_gen_v3_3_xst_comp.vhd
-- Author     : Xilinx, Inc.
-------------------------------------------------------------------------------
-- Description: This contains all the component declarations for the
-- distributed memory generator core source code.
-------------------------------------------------------------------------------
-- Copyright (c) 2005, 2006 Xilinx, Inc.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package dist_mem_gen_v3_3_xst_comp is

-------------------------------------------------------------------------------
-- The top level component of the RTL code for the Distributed Memory
-- Generator core.
-------------------------------------------------------------------------------   
   
   component dist_mem_gen_v3_3_xst
      generic (
         c_addr_width     : integer := 6;
         c_default_data   : string  := "0";
         c_depth          : integer := 64;
         c_has_clk        : integer := 1;
         c_has_d          : integer := 1;
         c_has_dpo        : integer := 0;
         c_has_dpra       : integer := 0;
         c_has_i_ce       : integer := 0;
         c_has_qdpo       : integer := 0;
         c_has_qdpo_ce    : integer := 0;
         c_has_qdpo_clk   : integer := 0;
         c_has_qdpo_rst   : integer := 0;
         c_has_qdpo_srst  : integer := 0;
         c_has_qspo       : integer := 0;
         c_has_qspo_ce    : integer := 0;
         c_has_qspo_rst   : integer := 0;
         c_has_qspo_srst  : integer := 0;
         c_has_spo        : integer := 1;
         c_has_spra       : integer := 0;
         c_has_we         : integer := 1;
         c_mem_init_file  : string  := "null.mif";
         c_elaboration_dir : string := "./";
         c_mem_type       : integer := 1;
         c_pipeline_stages : integer := 0;
         c_qce_joined     : integer := 0;
         c_qualify_we     : integer := 0;
         c_read_mif       : integer := 0;
         c_reg_a_d_inputs : integer := 0;
         c_reg_dpra_input : integer := 0;
         c_sync_enable    : integer := 0;
         c_width          : integer := 16);
      port (
         a         : in  std_logic_vector(c_addr_width-1-(4*c_has_spra*boolean'pos(c_addr_width > 4)) downto 0) := (others => '0');
         d         : in  std_logic_vector(c_width-1 downto 0);
         dpra      : in  std_logic_vector(c_addr_width-1 downto 0);
         spra      : in  std_logic_vector(c_addr_width-1 downto 0);
         clk       : in  std_logic;
         we        : in  std_logic;
         i_ce      : in  std_logic;
         qspo_ce   : in  std_logic;
         qdpo_ce   : in  std_logic;
         qdpo_clk  : in  std_logic;
         qspo_rst  : in  std_logic;
         qdpo_rst  : in  std_logic;
         qspo_srst : in  std_logic;
         qdpo_srst : in  std_logic;
         spo       : out std_logic_vector(c_width-1 downto 0);
         dpo       : out std_logic_vector(c_width-1 downto 0);
         qspo      : out std_logic_vector(c_width-1 downto 0);
         qdpo      : out std_logic_vector(c_width-1 downto 0)); 
   end component;

   
end dist_mem_gen_v3_3_xst_comp;
