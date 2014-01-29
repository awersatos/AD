-- $Header: /devl/xcs/repo/env/Databases/ip/src2/K/hrdiv_v1_0/simulation/hrdiv_v1_0_xst_comp.vhd,v 1.3 2008/09/09 20:28:06 akennedy Exp $
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

package hrdiv_v1_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component hrdiv_v1_0_xst
  component hrdiv_v1_0_xst
    GENERIC (
      C_VERBOSITY         : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_LATENCY           : integer := 1;
      C_HAS_SCLR          : integer := 0;
      C_HAS_CE            : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_FORMAT            : integer := 0;
      C_NUMER_WIDTH       : integer := 16;
      C_DENOM_WIDTH       : integer := 16;
      C_FRACT_WIDTH       : integer := 0;
      C_HAS_DIV_BY_ZERO   : integer := 0
      );
    PORT (
      CLK            : in  std_logic                                  := '1';
      CE             : in  std_logic                                  := '1';
      SCLR           : in  std_logic                                  := '0';
      ND             : in  std_logic                                  := '0';
      RFD            : out std_logic                                  := '0';
      RDY            : out std_logic                                  := '0';
      NUMER          : in  std_logic_vector(C_NUMER_WIDTH-1 downto 0) := (others => '0');
      DENOM          : in  std_logic_vector(C_DENOM_WIDTH-1 downto 0) := (others => '0');
      QUOT           : out std_logic_vector(C_NUMER_WIDTH-1 downto 0) := (others => '0');
      FRACT          : out std_logic_vector(C_FRACT_WIDTH-1 downto 0) := (others => '0');
      DIVIDE_BY_ZERO : out std_logic                                  := '0'
      );
  --core_if off
  END COMPONENT;


end hrdiv_v1_0_xst_comp;

