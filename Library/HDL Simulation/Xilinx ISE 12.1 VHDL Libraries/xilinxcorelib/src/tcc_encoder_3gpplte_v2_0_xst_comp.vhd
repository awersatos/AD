-- $RCSfile: tcc_encoder_3gpplte_v2_0_xst_comp.vhd,v $
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

package tcc_encoder_3gpplte_v2_0_xst_comp is

  constant BLOCK_SIZE_PORT_WIDTH         : INTEGER := 13;
----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component xst
  component tcc_encoder_3gpplte_v2_0_xst
  generic(
    c_elaboration_dir :     string  := "./";
    c_component_name  :     string  := "tcc_encoder_3gpplte_v2_0_xst_comp";
    c_has_nd          :     integer := 0;
    c_has_rfd_in      :     integer := 0;
    c_max_blocks      :     integer := 0;
    c_has_ce          :     integer := 0;
    c_has_sclr        :     integer := 0;
    c_family          :     string
    );
  port(
    clk               : in  std_logic := '0';
    ce                : in  std_logic := '0';
    sclr              : in  std_logic := '0';
    fd_in             : in  std_logic := '0';
    block_size        : in  std_logic_vector(BLOCK_SIZE_PORT_WIDTH-1 downto 0) := (others=>'0');
    data_in           : in  std_logic := '0';
    nd                : in  std_logic := '0';
    rfd_in            : in  std_logic := '0';
    rfd               : out std_logic;
    rffd              : out std_logic;
    rsc1_systematic   : out std_logic;
    rsc1_parity0      : out std_logic;
    rsc2_parity0      : out std_logic;
    rdy               : out std_logic;
    block_start       : out std_logic;
    block_end         : out std_logic
  );
  --core_if off
  end component;


end tcc_encoder_3gpplte_v2_0_xst_comp;

