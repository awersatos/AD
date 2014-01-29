--
-- $RCSfile: dft_v3_1_xst_comp.vhd,v $
-- $Revision: 1.2 $
-- $Date: 2009/12/02 13:23:29 $
--
--  Copyright(C) 2007-2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package dft_v3_1_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component dft_v3_1_xst
  component dft_v3_1_xst
    generic (
      C_XDEVICEFAMILY  : string  := "virtex5";
      C_COMPONENT_NAME : string  := "dft_v3_1";
      C_DATA_WIDTH     : integer := 18;
      C_SIZE_1536      : integer := 0;
      C_HAS_CE         : integer := 0;
      C_HAS_SCLR       : integer := 1;
      C_FMAX           : integer := 307
      );
    port (
      CLK        : in  std_logic                                 := '0';              -- Clock
      CE         : in  std_logic                                 := '0';              -- Clock enable
      SCLR       : in  std_logic                                 := '0';              -- Synchronous clear
      XN_RE      : in  std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');  -- input data, real
      XN_IM      : in  std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');  -- input data, imaginary
      FD_IN      : in  std_logic                                 := '0';              -- Input data is first sample of frame
      FWD_INV    : in  std_logic                                 := '0';              -- Direction: 1=forward, 0=inverse
      SIZE       : in  std_logic_vector(5 downto 0)              := (others => '0');  -- Index into table of point sizes
      RFFD       : out std_logic;                                                     -- Core is ready to receive a new frame of data
      XK_RE      : out std_logic_vector(C_DATA_WIDTH-1 downto 0);                     -- Output data, real
      XK_IM      : out std_logic_vector(C_DATA_WIDTH-1 downto 0);                     -- Output data, imaginary
      BLK_EXP    : out std_logic_vector(3 downto 0) ;                                 -- Block exponent
      FD_OUT     : out std_logic;                                                     -- Output data is first sample of frame
      DATA_VALID : out std_logic                                                      -- Output data is valid
      );
  --core_if off
  end component;


end dft_v3_1_xst_comp;

