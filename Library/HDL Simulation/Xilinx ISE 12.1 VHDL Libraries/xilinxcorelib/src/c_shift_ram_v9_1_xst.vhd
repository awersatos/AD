-- $RCSfile: c_shift_ram_v9_1_xst.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:53 $
--------------------------------------------------------------------------------
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v9_1.ALL;
USE xilinxcorelib.c_shift_ram_v9_1_comp.ALL;

ENTITY c_shift_ram_v9_1_xst IS
  GENERIC (
    c_family             : STRING  := "virtex2";  -- Lossless mode is architecture-specific
    c_width              : INTEGER := 16;  -- Default is 16
    c_depth              : INTEGER := 16;  -- SRL16 depth (default = 16 = 1x SRL16) 
    c_addr_width         : INTEGER := 4;  -- Dependent on c_width value specified
    c_shift_type         : INTEGER := 0;  --c_variable_lossy;  -- 0=fixed, 1=lossless, 2=lossy
    c_opt_goal           : INTEGER := 0;  -- 0=area, 1=speed
    c_ainit_val          : STRING  := "0000000000000000";  -- Applies only to registered output
    c_sinit_val          : STRING  := "0000000000000000";  -- Applies only to registered output    
    c_default_data       : STRING  := "0000000000000000";  -- No init details, use this val
    c_default_data_radix : INTEGER := 1;  -- 0=no init values, 1=hex ,2=bin, 3=dec
    c_has_a              : INTEGER := 0;  -- Address bus only exists for var length
    c_has_ce             : INTEGER := 0;
    c_reg_last_bit       : INTEGER := 1;  -- Register last output bit (with FF)
    c_sync_priority      : INTEGER := 1;  -- Applies only to registered output
    c_sync_enable        : INTEGER := 0;  -- Applies only to registered output
    c_has_aclr           : INTEGER := 0;  -- Applies only to registered output    
    c_has_aset           : INTEGER := 0;  -- Applies only to registered output
    c_has_ainit          : INTEGER := 0;  -- Applies only to registered output    
    c_has_sclr           : INTEGER := 0;  -- Applies only to registered output
    c_has_sset           : INTEGER := 0;  -- Applies only to registered output
    c_has_sinit          : INTEGER := 0;  -- Applies only to registered output
    c_mem_init_file      : STRING  := "init.mif";
    c_elaboration_dir    : STRING  := "./";
    c_mem_init_radix     : INTEGER := 1;  -- for backwards compatibility
    c_generate_mif       : INTEGER := 0;  -- Unused by the behavioural model    
    c_read_mif           : INTEGER := 0;  -- Redundant in VHDL core
    c_enable_rlocs       : INTEGER := 0   -- Not used with VHDL core
    ); 

  PORT (
    a     : IN  STD_LOGIC_VECTOR(c_addr_width-1 DOWNTO 0) := (OTHERS => '0');
    d     : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)      := (OTHERS => '0');
    clk   : IN  STD_LOGIC                                 := '0';
    ce    : IN  STD_LOGIC                                 := '1';
    aclr  : IN  STD_LOGIC                                 := '0';
    aset  : IN  STD_LOGIC                                 := '0';
    ainit : IN  STD_LOGIC                                 := '0';
    sclr  : IN  STD_LOGIC                                 := '0';
    sset  : IN  STD_LOGIC                                 := '0';
    sinit : IN  STD_LOGIC                                 := '0';
    q     : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)
    ); 
END c_shift_ram_v9_1_xst;
--
-- behavior describing a parameterized ram based shift register
--
ARCHITECTURE behavioral OF c_shift_ram_v9_1_xst IS
BEGIN

  i_behv : c_shift_ram_v9_1
    GENERIC MAP(
      c_family             => c_family,
      c_opt_goal           => c_opt_goal,
      c_addr_width         => c_addr_width,
      c_ainit_val          => c_ainit_val,
      c_default_data       => c_default_data,
      c_default_data_radix => c_default_data_radix,
      c_depth              => c_depth,
      c_enable_rlocs       => c_enable_rlocs,
      c_generate_mif       => c_generate_mif,
      c_has_aclr           => c_has_aclr,
      c_has_a              => c_has_a,
      c_has_ainit          => c_has_ainit,
      c_has_aset           => c_has_aset,
      c_has_ce             => c_has_ce,
      c_has_sclr           => c_has_sclr,
      c_has_sinit          => c_has_sinit,
      c_has_sset           => c_has_sset,
      c_mem_init_file      => c_mem_init_file,
      c_mem_init_radix     => c_mem_init_radix,
      c_read_mif           => c_read_mif,
      c_reg_last_bit       => c_reg_last_bit,
      c_shift_type         => c_shift_type,
      c_sinit_val          => c_sinit_val,
      c_sync_priority      => c_sync_priority,
      c_sync_enable        => c_sync_enable,
      c_width              => c_width
      )

    PORT MAP(
      a     => a,
      d     => d,
      clk   => clk,
      ce    => ce,
      aclr  => aclr,
      aset  => aset,
      ainit => ainit,
      sclr  => sclr,
      sset  => sset,
      sinit => sinit,
      q     => q
      ); 

END behavioral;
