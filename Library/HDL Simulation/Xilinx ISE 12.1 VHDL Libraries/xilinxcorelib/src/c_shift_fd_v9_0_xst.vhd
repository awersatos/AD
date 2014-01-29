-- $RCSfile: c_shift_fd_v9_0_xst.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:51 $
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
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v9_0.all;
Use XilinxCoreLib.c_shift_fd_v9_0_comp.all;

ENTITY c_shift_fd_v9_0_xst IS
  GENERIC (
    c_width         : INTEGER := 16;
    c_shift_type    : INTEGER := 0;
    c_fill_data     : INTEGER := 5;
    c_ainit_val     : STRING  := "0000000000000000";
    c_sinit_val     : STRING  := "0000000000000000";
    c_sync_priority : INTEGER := 1;
    c_sync_enable   : INTEGER := 0;
    c_has_lsb_2_msb : INTEGER := 0;
    c_has_sdin      : INTEGER := 1;
    c_has_d         : INTEGER := 0;
    c_has_sdout     : INTEGER := 0;
    c_has_q         : INTEGER := 1;
    c_has_ce        : INTEGER := 0;
    c_has_aclr      : INTEGER := 0;
    c_has_aset      : INTEGER := 0;
    c_has_ainit     : INTEGER := 0;
    c_has_sclr      : INTEGER := 0;
    c_has_sset      : INTEGER := 0;
    c_has_sinit     : INTEGER := 0;
    c_enable_rlocs  : INTEGER := 0
    ); 

  PORT (
    lsb_2_msb : IN  STD_LOGIC                            := '0';
    sdin      : IN  STD_LOGIC                            := '0';
    d         : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');
    p_load    : IN  STD_LOGIC                            := '0';
    clk       : IN  STD_LOGIC                            := '0';
    ce        : IN  STD_LOGIC                            := '1';
    aclr      : IN  STD_LOGIC                            := '0';
    aset      : IN  STD_LOGIC                            := '0';
    ainit     : IN  STD_LOGIC                            := '0';
    sclr      : IN  STD_LOGIC                            := '0';
    sset      : IN  STD_LOGIC                            := '0';
    sinit     : IN  STD_LOGIC                            := '0';
    sdout     : OUT STD_LOGIC;
    q         : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)
    ); 
END c_shift_fd_v9_0_xst;

architecture behavioral of c_shift_fd_v9_0_xst is
begin
  i_behv : c_shift_fd_v9_0
    GENERIC MAP(
      c_width         => c_width,
      c_shift_type    => c_shift_type,
      c_fill_data     => c_fill_data,
      c_ainit_val     => c_ainit_val,
      c_sinit_val     => c_sinit_val,
      c_sync_priority => c_sync_priority,
      c_sync_enable   => c_sync_enable,
      c_has_lsb_2_msb => c_has_lsb_2_msb,
      c_has_sdin      => c_has_sdin,
      c_has_d         => c_has_d,
      c_has_sdout     => c_has_sdout,
      c_has_q         => c_has_q,
      c_has_ce        => c_has_ce,
      c_has_aclr      => c_has_aclr,
      c_has_aset      => c_has_aset,
      c_has_ainit     => c_has_ainit,
      c_has_sclr      => c_has_sclr,
      c_has_sset      => c_has_sset,
      c_has_sinit     => c_has_sinit,
      c_enable_rlocs  => c_enable_rlocs
      ) 

    PORT MAP(
      lsb_2_msb => lsb_2_msb,
      sdin      => sdin,
      d         => d,
      p_load    => p_load,
      clk       => clk,
      ce        => ce,
      aclr      => aclr,
      aset      => aset,
      ainit     => ainit,
      sclr      => sclr,
      sset      => sset,
      sinit     => sinit,
      sdout     => sdout,
      q         => q
      ); 
		
end behavioral;
	
	
	
	
	
	
	
	
	
	
	
	
