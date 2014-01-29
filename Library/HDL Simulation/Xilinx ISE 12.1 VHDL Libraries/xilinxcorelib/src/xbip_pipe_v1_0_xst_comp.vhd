-- $Header: /devl/xcs/repo/env/Databases/ip/src2/K/xbip_pipe_v1_0/simulation/xbip_pipe_v1_0_xst_comp.vhd,v 1.3 2008/09/10 09:50:49 akennedy Exp $
-------------------------------------------------------------------------------
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package xbip_pipe_v1_0_xst_comp is

  component xbip_pipe_v1_0_xst is
    generic (
      C_LATENCY             : integer := 0;
      C_HAS_CE              : integer := 0;
      C_CE_OVERRIDES_SYNC   : integer := 0;
      C_SSET_OVERRIDES_SCLR : integer := 0;
      C_HAS_SCLR            : integer := 0;
      C_HAS_SSET            : integer := 0;
      C_HAS_SINIT           : integer := 0;
      C_SINIT_VAL           : string  := "0";
      C_AINIT_VAL           : string  := "0";
      C_WIDTH               : integer := 1;
      C_FAST_IP             : integer := 1
      );
    port (
      CLK   : in  std_logic                            := '0';
      CE    : in  std_logic                            := '0';
      SCLR  : in  std_logic                            := '0';
      SSET  : in  std_logic                            := '0';
      SINIT : in  std_logic                            := '0';
      D     : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
      Q     : out std_logic_vector(C_WIDTH-1 downto 0) := (others => '0')
      );
  end component xbip_pipe_v1_0_xst;

end package xbip_pipe_v1_0_xst_comp;
