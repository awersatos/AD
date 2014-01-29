--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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


package tcc_intlv_3gpplte_v2_0_xst_comp is


  --core_if on component tcc_intlv_3gpplte_v2_0_xst
  component tcc_intlv_3gpplte_v2_0_xst
    GENERIC (
      c_elaboration_dir : string  := "./";
      c_family          : string  := "virtex5";
      c_component_name  : string  := "tcc_intlv_3gpplte";
      c_has_ce          : integer := 0
      );
    PORT (
      clk        : in  std_logic;
      ce         : in  std_logic;
      fd_in      : in  std_logic;
      block_size : in  std_logic_vector(12 downto 0);
      intlv_addr : out std_logic_vector(12 downto 0)
      );
  --core_if off
  END COMPONENT;


end tcc_intlv_3gpplte_v2_0_xst_comp;

