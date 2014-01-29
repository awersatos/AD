-------------------------------------------------------------------------------
-- (c) Copyright 1995 - 2009 Xilinx, Inc. All rights reserved.
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
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

package dist_mem_gen_v4_3_comp is

   component dist_mem_gen_v4_3
      generic (
         c_family         : string  := "virtex5";
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
         c_mem_type       : integer := 1;
         c_pipeline_stages : integer := 0;
         c_qce_joined     : integer := 0;
         c_qualify_we     : integer := 0;
         c_read_mif       : integer := 0;
         c_reg_a_d_inputs : integer := 0;
         c_reg_dpra_input : integer := 0;
         c_sync_enable    : integer := 0;
         c_width              : integer := 16;
         c_parser_type        : integer := 1);
      port (
         a : in std_logic_vector(c_addr_width-1-(4*c_has_spra*boolean'pos(c_addr_width > 4)) downto 0) := (others => '0');

         d         : in  std_logic_vector(c_width-1 downto 0)      := (others => '0');
         dpra      : in  std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
         spra      : in  std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
         clk       : in  std_logic                                 := '0';
         we        : in  std_logic                                 := '0';
         i_ce      : in  std_logic                                 := '1';
         qspo_ce   : in  std_logic                                 := '1';
         qdpo_ce   : in  std_logic                                 := '1';
         qdpo_clk  : in  std_logic                                 := '0';
         qspo_rst  : in  std_logic                                 := '0';
         qdpo_rst  : in  std_logic                                 := '0';
         qspo_srst : in  std_logic                                 := '0';
         qdpo_srst : in  std_logic                                 := '0';
         spo       : out std_logic_vector(c_width-1 downto 0);
         dpo       : out std_logic_vector(c_width-1 downto 0);
         qspo      : out std_logic_vector(c_width-1 downto 0);
         qdpo      : out std_logic_vector(c_width-1 downto 0)
         ); 
   end component;

   -- The following tells XST that dist_mem_gen_v4_3 is a black box which  
   -- should be generated.  The command given by the value of this attribute 
   -- Note the fully qualified SIM (JAVA class) name that forms the 
   -- basis of the core 

   --xcc exclude
   attribute box_type          : string;
   attribute GENERATOR_DEFAULT : string;

   attribute box_type of dist_mem_gen_v4_3          : component is "black_box";
   attribute GENERATOR_DEFAULT of dist_mem_gen_v4_3 : component is
      "generatecore com.xilinx.ip.dist_mem_gen_v4_3.dist_mem_gen_v4_3";
   --xcc include

end dist_mem_gen_v4_3_comp;
