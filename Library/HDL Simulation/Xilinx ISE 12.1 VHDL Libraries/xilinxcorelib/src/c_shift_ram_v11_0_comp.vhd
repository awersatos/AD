-- $RCSfile: c_shift_ram_v11_0_comp.vhd,v $ $Revision: 1.4 $ $Date: 2009/12/04 11:46:42 $
--
--  (c) Copyright 1995-2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


package c_shift_ram_v11_0_comp is

  --core_if on component c_shift_ram_v11_0
  component c_shift_ram_v11_0
    generic (
      C_XDEVICEFAMILY      : string  := "no_family"; 
      C_VERBOSITY          : integer := 0;  --0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_WIDTH              : integer := 16;  -- default is 16
      C_DEPTH              : integer := 16;  -- srl16 depth (default = 16 = 1x srl16) 
      C_ADDR_WIDTH         : integer := 4;  -- dependent on c_width value specified
      C_SHIFT_TYPE         : integer := 0; --  -- 0=fixed, 1=lossless
      C_OPT_GOAL           : integer := 0;  -- 0=area, 1=speed
      C_AINIT_VAL          : string  := "0000000000000000";  -- applies only to registered output
      C_SINIT_VAL          : string  := "0000000000000000";  -- applies only to registered output    
      C_DEFAULT_DATA       : string  := "0000000000000000";  -- no init details, use this val
      C_HAS_A              : integer := 0;  -- address bus only exists for var length
      C_HAS_CE             : integer := 0;
      C_REG_LAST_BIT       : integer := 0;  -- register last output bit (with ff)
      C_SYNC_PRIORITY      : integer := 1;  -- applies only to registered output
      C_SYNC_ENABLE        : integer := 0;  -- applies only to registered output
      C_HAS_SCLR           : integer := 0;  -- applies only to registered output
      C_HAS_SSET           : integer := 0;  -- applies only to registered output
      C_HAS_SINIT          : integer := 0;  -- applies only to registered output
      C_MEM_INIT_FILE      : string  := "init.mif";
      C_ELABORATION_DIR    : string  := "./";
      C_READ_MIF           : integer := 0;
      C_PARSER_TYPE        : integer := 1   -- 0:Verific, 1:Classic Parser
      );
    port (
      A     : in  std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
      D     : in  std_logic_vector(c_width-1 downto 0) := (others => '0');
      CLK   : in  std_logic := '0';
      CE    : in  std_logic := '1';
      SCLR  : in  std_logic := '0';
      SSET  : in  std_logic := '0';
      SINIT : in  std_logic := '0';
      Q     : out std_logic_vector(c_width-1 downto 0) := (others => '0')
      );
    --core_if off
  END COMPONENT;
  -- The following tells XST that c_shift_ram_v11_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type                               : STRING;
  ATTRIBUTE generator_default                      : STRING;
  ATTRIBUTE box_type OF c_shift_ram_v11_0          : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF c_shift_ram_v11_0 : COMPONENT IS
    "generatecore com.xilinx.ip.c_shift_ram_v11_0.c_shift_ram_v11_0";
  -- xcc include

END c_shift_ram_v11_0_comp;
