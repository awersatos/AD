-------------------------------------------------------------------------------
-- $RCSfile: dist_mem_gen_v3_2_xst.vhd,v $
-- $Revision: 1.8 $
-- $Date: 2008/09/08 19:37:02 $
-------------------------------------------------------------------------------
-- Copyright(C) 2005-2006 by Xilinx, Inc. All rights reserved.
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
-- of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.dist_mem_gen_v3_2_comp.all;

entity dist_mem_gen_v3_2_xst is
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
      a    : in  std_logic_vector(c_addr_width-1-(4*c_has_spra*boolean'pos(c_addr_width>4)) downto 0) := (others => '0');

      d    : in std_logic_vector(c_width-1 downto 0)      := (others => '0');
      dpra : in std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
      spra : in std_logic_vector(c_addr_width-1 downto 0) := (others => '0');

      clk       : in  std_logic := '0';
      we        : in  std_logic := '0';
      i_ce      : in  std_logic := '1';
      qspo_ce   : in  std_logic := '1';
      qdpo_ce   : in  std_logic := '1';
      qdpo_clk  : in  std_logic := '0';
      qspo_rst  : in  std_logic := '0';
      qdpo_rst  : in  std_logic := '0';
      qspo_srst : in  std_logic := '0';
      qdpo_srst : in  std_logic := '0';
      spo       : out std_logic_vector(c_width-1 downto 0);
      dpo       : out std_logic_vector(c_width-1 downto 0);
      qspo      : out std_logic_vector(c_width-1 downto 0);
      qdpo      : out std_logic_vector(c_width-1 downto 0)); 

end dist_mem_gen_v3_2_xst;

architecture behavioral of dist_mem_gen_v3_2_xst is

   constant path_and_file : string := c_elaboration_dir & c_mem_init_file;
   
begin    

   -- Instantiate the true behavioral model top level
   dist_mem_gen_inst: dist_mem_gen_v3_2
      generic map (
         c_addr_width     => c_addr_width,
         c_default_data   => c_default_data,
         c_depth          => c_depth,
         c_has_clk        => c_has_clk,
         c_has_d          => c_has_d,
         c_has_dpo        => c_has_dpo,
         c_has_dpra       => c_has_dpra,
         c_has_i_ce       => c_has_i_ce,
         c_has_qdpo       => c_has_qdpo,
         c_has_qdpo_ce    => c_has_qdpo_ce,
         c_has_qdpo_clk   => c_has_qdpo_clk,
         c_has_qdpo_rst   => c_has_qdpo_rst,
         c_has_qdpo_srst  => c_has_qdpo_srst,
         c_has_qspo       => c_has_qspo,
         c_has_qspo_ce    => c_has_qspo_ce,
         c_has_qspo_rst   => c_has_qspo_rst,
         c_has_qspo_srst  => c_has_qspo_srst,
         c_has_spo        => c_has_spo,
         c_has_spra       => c_has_spra,
         c_has_we         => c_has_we,
         c_mem_init_file  => path_and_file,
         c_mem_type       => c_mem_type,
         c_pipeline_stages => c_pipeline_stages,
         c_qce_joined     => c_qce_joined,
         c_qualify_we     => c_qualify_we,
         c_read_mif       => c_read_mif,
         c_reg_a_d_inputs => c_reg_a_d_inputs,
         c_reg_dpra_input => c_reg_dpra_input,
         c_sync_enable    => c_sync_enable,
         c_width          => c_width)
      port map (
         a         => a,
         d         => d,
         dpra      => dpra,
         spra      => spra,
         clk       => clk,
         we        => we,
         i_ce      => i_ce,
         qspo_ce   => qspo_ce,
         qdpo_ce   => qdpo_ce,
         qdpo_clk  => qdpo_clk,
         qspo_rst  => qspo_rst,
         qdpo_rst  => qdpo_rst,
         qspo_srst => qspo_rst,
         qdpo_srst => qdpo_srst,
         spo       => spo,
         dpo       => dpo,
         qspo      => qspo,
         qdpo      => qdpo);

end behavioral;
