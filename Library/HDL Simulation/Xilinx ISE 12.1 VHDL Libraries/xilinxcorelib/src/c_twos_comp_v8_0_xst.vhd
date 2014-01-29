-- $RCSfile: c_twos_comp_v8_0_xst.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:56 $
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
-- Filename - c_twos_comp_v8_0.vhd
-- Author - Xilinx
-- Creation - 2 Feb 1999
--
-- Description - This file contains the behavior for
--				 the C_TWOS_COMP_V8_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v8_0.all;
Use XilinxCoreLib.prims_utils_v8_0.all;
Use XilinxCoreLib.c_twos_comp_v8_0_comp.all;

-- (A)synchronous 2's complimenter
--

ENTITY c_twos_comp_v8_0_xst IS
  GENERIC(
    c_width         : INTEGER := 16;
    c_ainit_val     : STRING  := "0";                
    c_sinit_val     : STRING  := "0";                
    c_bypass_enable : INTEGER := c_override;
    c_bypass_low    : INTEGER := 0;
    c_sync_priority : INTEGER := c_clear;
    c_sync_enable   : INTEGER := c_override;
    c_pipe_stages   : INTEGER := 0;
    c_has_bypass    : INTEGER := 0;
    c_has_ce        : INTEGER := 0;
    c_has_aclr      : INTEGER := 0;
    c_has_aset      : INTEGER := 0;
    c_has_ainit     : INTEGER := 0;
    c_has_sclr      : INTEGER := 0;
    c_has_sset      : INTEGER := 0;
    c_has_sinit     : INTEGER := 0;
    c_has_s         : INTEGER := 0;
    c_has_q         : INTEGER := 1;
    c_enable_rlocs  : INTEGER := 0
    );

  PORT (
    a      : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- signed input value!
    bypass : IN  STD_LOGIC                            := '0';  -- control of negation : '0' = negate input
    clk    : IN  STD_LOGIC                            := '0';  -- clock
    ce     : IN  STD_LOGIC                            := '1';  -- clock enable
    aclr   : IN  STD_LOGIC                            := '0';  -- asynch init.
    aset   : IN  STD_LOGIC                            := '0';  -- asynch set.
    ainit  : IN  STD_LOGIC                            := '0';  -- asynch init.
    sclr   : IN  STD_LOGIC                            := '0';  -- synch init.
    sset   : IN  STD_LOGIC                            := '0';  -- synch set.             
    sinit  : IN  STD_LOGIC                            := '0';  -- synch init.
    s      : OUT STD_LOGIC_VECTOR(c_width DOWNTO 0);           -- asynch output
    q      : OUT STD_LOGIC_VECTOR(c_width DOWNTO 0)  -- registered output value
    );
END c_twos_comp_v8_0_xst;

architecture behavioral of c_twos_comp_v8_0_xst is

begin
  i_behv : c_twos_comp_v8_0
    GENERIC MAP(
      c_width         => c_width,
      c_ainit_val     => c_ainit_val,
      c_sinit_val     => c_sinit_val,
      c_bypass_enable => c_bypass_enable,
      c_bypass_low    => c_bypass_low,
      c_sync_priority => c_sync_priority,
      c_sync_enable   => c_sync_enable,
      c_pipe_stages   => c_pipe_stages,
      c_has_bypass    => c_has_bypass,
      c_has_ce        => c_has_ce,
      c_has_aclr      => c_has_aclr,
      c_has_aset      => c_has_aset,
      c_has_ainit     => c_has_ainit,
      c_has_sclr      => c_has_sclr,
      c_has_sset      => c_has_sset,
      c_has_sinit     => c_has_sinit,
      c_has_s         => c_has_s,
      c_has_q         => c_has_q,
      c_enable_rlocs  => c_enable_rlocs
      )
    PORT MAP(
      a      => a,
      bypass => bypass,
      clk    => clk,
      ce     => ce,
      aclr   => aclr,
      aset   => aset,
      ainit  => ainit,
      sclr   => sclr,
      sset   => sset,
      sinit  => sinit,
      s      => s,
      q      => q
      );
  
	
end behavioral;
