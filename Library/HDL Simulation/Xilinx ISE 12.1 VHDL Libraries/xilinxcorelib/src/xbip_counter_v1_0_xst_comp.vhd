-- $Header: /devl/xcs/repo/env/Databases/ip/src2/K/xbip_counter_v1_0/simulation/xbip_counter_v1_0_xst_comp.vhd,v 1.2 2008/09/10 09:46:12 akennedy Exp $
--
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package xbip_counter_v1_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component xbip_counter_v1_0_xst
  component xbip_counter_v1_0_xst
    GENERIC (
      C_XDEVICEFAMILY     : string  := "virtex2";
      C_VERBOSITY         : integer := 0;
      C_USE_DSP48         : integer := 0;
      C_HAS_CE            : integer := 0;
      C_HAS_SCLR          : integer := 0;
      C_LATENCY           : integer := 1;
      C_FB_LATENCY        : integer := 1;
      C_WIDTH             : integer := 16;
      C_RESTRICT_COUNT    : integer := 0;
      C_COUNT_TO          : string  := "0";
      C_COUNT_BY          : string  := "0";
      C_COUNT_MODE        : integer := 0;          -- 0=up, 1=down, 2=updown
      C_THRESH0_VALUE     : string  := "0";
      C_CE_OVERRIDES_SCLR : integer := 0;          -- 0=override;
      C_HAS_THRESH0       : integer := 0;
      C_HAS_LOAD          : integer := 0;
      C_LOAD_LOW          : integer := 0
      );
    PORT (
      CLK     : in  std_logic                            := '0';              -- optional clock
      CE      : in  std_logic                            := '1';              -- optional clock enable
      SCLR    : in  std_logic                            := '0';              -- synch init.
      UP      : in  std_logic                            := '1';              -- controls direction of count - '1' = up.
      LOAD    : in  std_logic                            := '0';              -- optional synch load trigger
      L       : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- optional synch load value
      THRESH0 : out std_logic                            := '1';
      Q       : out std_logic_vector(C_WIDTH-1 downto 0)                      -- output value
      );
  --core_if off
  END COMPONENT;


end xbip_counter_v1_0_xst_comp;

