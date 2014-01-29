-- $Header: /devl/xcs/repo/env/Databases/ip/src2/K/xbip_multadd_v1_0/simulation/xbip_multadd_v1_0_comp.vhd,v 1.5 2008/09/10 09:50:48 akennedy Exp $
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
-- Component statement for behavioral model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- I would like to use the utils to define the width of PCIN and PCOUT, but when I leave the definitions in below I get failures
-- in xbld libs.   It says it can't find xilinxcorelib!
library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;

package xbip_multadd_v1_0_comp is

  --core_if on component xbip_multadd_v1_0
  component xbip_multadd_v1_0
  generic (
    C_VERBOSITY         : integer := 0;
    C_XDEVICEFAMILY     : string  := "NO_FAMILY";
    C_A_WIDTH           : integer := 16;
    C_B_WIDTH           : integer := 16;
    C_C_WIDTH           : integer := 32;
    C_DATA_TYPE         : integer := 0;
    C_CE_OVERRIDES_SCLR : integer := 0;
    C_AB_LATENCY        : integer := -1;
    C_C_LATENCY         : integer := -1;
    C_OUT_HIGH          : integer := 32;
    C_OUT_LOW           : integer := 0;
    C_USE_PCIN          : integer := 0
    );
  port (
    CLK      : in  std_logic                                     := '0';
    CE       : in  std_logic                                     := '0';
    SCLR     : in  std_logic                                     := '0';
    A        : in  std_logic_vector(C_A_WIDTH-1 downto 0)        := (others => '0');
    B        : in  std_logic_vector(C_B_WIDTH-1 downto 0)        := (others => '0');
    C        : in  std_logic_vector(C_C_WIDTH-1 downto 0)        := (others => '0');
   PCIN     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
 --   PCIN     : in  std_logic_vector(48-1 downto 0) := (others => '0');
    SUBTRACT : in  std_logic                                     := '0';
    P        : out std_logic_vector(C_OUT_HIGH downto C_OUT_LOW) := (others => '0');
   PCOUT    : out  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0')
--    PCOUT    : out  std_logic_vector(48-1 downto 0) := (others => '0')
    );
  --core_if off
  end component;
  -- The following tells XST that xbip_multadd_v1_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  attribute box_type                               : string;
  attribute generator_default                      : string;
  attribute box_type of xbip_multadd_v1_0          : component is "black_box";
  attribute generator_default of xbip_multadd_v1_0 : component is "generatecore com.xilinx.ip.xbip_multadd_v1_0.xbip_multadd_v1_0";
  -- xcc include

end xbip_multadd_v1_0_comp;
