-- $RCSfile: c_reg_fd_v9_1_xst.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:50 $
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
--
--
-- Filename - c_reg_fd_v9_1.vhd
-- Author - Xilinx
-- Creation - 21 Sept 1998
--
-- Description - This file contains the behavior for the baseblocks c_reg_fd_v9_1 module

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v9_1.all;
USE Xilinxcorelib.c_reg_fd_v9_1_comp.ALL;

-- bwid bit wide register with asynchronous clear

ENTITY c_reg_fd_v9_1_xst IS
  GENERIC (
    c_width         : INTEGER := 16;
    c_ainit_val     : STRING  := "0";
    c_sinit_val     : STRING  := "0";
    c_sync_priority : INTEGER := c_clear;
    c_sync_enable   : INTEGER := c_override;
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
    d     : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    clk   : IN  STD_LOGIC                            := '0';  -- clock
    ce    : IN  STD_LOGIC                            := '1';  -- clock enable
    aclr  : IN  STD_LOGIC                            := '0';  -- asynch clear.
    aset  : IN  STD_LOGIC                            := '0';  -- asynch set.
    ainit : IN  STD_LOGIC                            := '0';  -- asynch init.
    sclr  : IN  STD_LOGIC                            := '0';  -- synch clear.
    sset  : IN  STD_LOGIC                            := '0';  -- synch set.
    sinit : IN  STD_LOGIC                            := '0';  -- synch init.
    q     : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)          -- output value
    );
END c_reg_fd_v9_1_xst;

architecture behavioral of c_reg_fd_v9_1_xst is

begin
  i_behv : c_reg_fd_v9_1
    GENERIC MAP(
      c_width         => c_width,
      c_ainit_val     => c_ainit_val,
      c_sinit_val     => c_sinit_val,
      c_sync_priority => c_sync_priority,
      c_sync_enable   => c_sync_enable,
      c_has_ce        => c_has_ce,
      c_has_aclr      => c_has_aclr,
      c_has_aset      => c_has_aset,
      c_has_ainit     => c_has_ainit,
      c_has_sclr      => c_has_sclr,
      c_has_sset      => c_has_sset,
      c_has_sinit     => c_has_sinit
      )
    PORT MAP(
      clk   => clk,
      ce    => ce,
      ainit => ainit,
      aclr  => aclr,
      aset  => aset,
      sinit => sinit,
      sclr  => sclr,
      sset  => sset,
      d     => d,
      q     => q
      );
	
end behavioral;
