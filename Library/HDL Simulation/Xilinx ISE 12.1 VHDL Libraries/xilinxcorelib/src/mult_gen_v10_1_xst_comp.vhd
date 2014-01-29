-- $RCSfile: mult_gen_v10_1_xst_comp.vhd,v $ $Revision: 1.4 $ $Date: 2008/09/09 21:30:37 $
--------------------------------------------------------------------------------
--  Copyright(C) 2006, 2007, 2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 2006, 2007, 2008 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- Note the presence of the PCASC port (for internal users only)
library xilinxcorelib;
use xilinxcorelib.mult_gen_pkg_v10_1.all;

package mult_gen_v10_1_xst_comp is

  component mult_gen_v10_1_xst is
    generic (
      C_VERBOSITY         : integer := 0;
      C_MODEL_TYPE        : integer := 0;
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_A_WIDTH           : integer := 18;
      C_A_TYPE            : integer := 0;
      C_B_WIDTH           : integer := 18;
      C_B_TYPE            : integer := 0;
      C_OUT_HIGH          : integer := 35;
      C_OUT_LOW           : integer := 0;
      C_MULT_TYPE         : integer := 1;
      C_OPTIMIZE_GOAL     : integer := 1;
      C_HAS_CE            : integer := 0;
      C_HAS_SCLR          : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 1;
      C_LATENCY           : integer := -1;
      C_CCM_IMP           : integer := 0;
      C_B_VALUE           : string  := "111111111111111111";
      C_HAS_ZERO_DETECT   : integer := 0;
      C_ROUND_OUTPUT      : integer := 0;
      C_ROUND_PT          : integer := 0);
    port (
      CLK         : in  std_logic                                       := '1';
      A           : in  std_logic_vector(C_A_WIDTH-1 downto 0)          := (others => '0');
      B           : in  std_logic_vector(C_B_WIDTH-1 downto 0)          := (others => '0');
      CE          : in  std_logic                                       := '1';
      SCLR        : in  std_logic                                       := '0';
      ZERO_DETECT : out std_logic_vector(1 downto 0)                    := (others => '0');
      P           : out std_logic_vector(C_OUT_HIGH-C_OUT_LOW downto 0) := (others => '0');
      PCASC       : out std_logic_vector(DSP_P_WIDTH-1 downto 0)        := (others => '0')); 
  end component;

end mult_gen_v10_1_xst_comp;
