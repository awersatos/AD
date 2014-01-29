--------------------------------------------------------------------------------
--  Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------


-- $Id: tcc_encoder_3gpp_v4_0_comp.vhd,v 1.3 2009/09/08 16:21:51 akennedy Exp $
--
-- Description: Component statement for Turbo Convolutional Encoder 3GPP
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE tcc_encoder_3gpp_v4_0_comp IS

--------------------------------------------------------------------------------
-- Component declaration
--------------------------------------------------------------------------------
COMPONENT tcc_encoder_3gpp_v4_0
  GENERIC (
    c_external_ram            : INTEGER := 0;
    c_external_addr_gen       : INTEGER := 0;
    c_ext_iaddr_width         : INTEGER := 13;
    c_has_ce                  : INTEGER := 1;
    c_has_rfd_in              : INTEGER := 1;
    c_has_nd                  : INTEGER := 1;
    c_has_rfd                 : INTEGER := 1;
    c_has_sclr                : INTEGER := 1;
    c_has_block_size_valid    : INTEGER := 0;
    c_num_channels            : INTEGER := 1;
    c_rate_1_5                : INTEGER := 0;
    c_mux_tail_bits           : INTEGER := 1;
    c_family                  : STRING  := "virtex4";
    c_xdevicefamily           : STRING  := "virtex4"
  );
  PORT (
    clk              : IN  std_logic;
    sclr             : IN  std_logic;
    ce               : IN  std_logic;
    block_size       : IN STD_LOGIC_VECTOR(c_ext_iaddr_width+c_external_addr_gen-1 DOWNTO 0);
    fd_in            : IN  std_logic;
    rfd_in           : IN  std_logic;
    data_in          : IN  std_logic_vector(c_num_channels-1 downto 0);
    nd               : IN  std_logic;
    rffd             : OUT std_logic;
    rfd              : OUT std_logic;
    block_size_valid : OUT std_logic;
    rsc1_systematic  : OUT std_logic_vector(c_num_channels-1 downto 0);
    rsc1_parity0     : OUT std_logic_vector(c_num_channels-1 downto 0);
    rsc1_parity1     : OUT std_logic_vector(c_num_channels-1 downto 0);
    rsc1_tail        : OUT STD_LOGIC;
    rsc2_systematic  : OUT std_logic_vector(c_num_channels-1 downto 0);
    rsc2_parity0     : OUT std_logic_vector(c_num_channels-1 downto 0);
    rsc2_parity1     : OUT std_logic_vector(c_num_channels-1 downto 0);
    rsc2_tail        : OUT STD_LOGIC;
    rdy              : OUT std_logic;
    --External address generator ports: Only if c_external_addr_gen=1
    ext_iaddr        : IN STD_LOGIC_VECTOR(c_ext_iaddr_width-1 DOWNTO 0);
    ext_iaddr_ce     : OUT STD_LOGIC;
    ext_iaddr_rffd   : IN  STD_LOGIC; --Address gen ready for FD
    ext_iaddr_rdy    : IN  STD_LOGIC; --Address gen FIFO ready output
    --External memory ports: Only if c_external_ram=1
    mem_dina         : OUT STD_LOGIC_vector(c_num_channels-1 downto 0);
    mem_addrb        : OUT STD_LOGIC_VECTOR(c_ext_iaddr_width-1 DOWNTO 0);

    mem0_ena         : OUT STD_LOGIC;
    mem0_enb         : OUT STD_LOGIC;
    mem0_wea         : OUT STD_LOGIC;
    mem0_addra       : OUT STD_LOGIC_VECTOR(c_ext_iaddr_width-1 DOWNTO 0);
    mem0_douta       : IN STD_LOGIC_vector(c_num_channels-1 downto 0);
    mem0_doutb       : IN STD_LOGIC_vector(c_num_channels-1 downto 0);

    mem1_ena         : OUT STD_LOGIC;
    mem1_enb         : OUT STD_LOGIC;
    mem1_wea         : OUT STD_LOGIC;
    mem1_addra       : OUT STD_LOGIC_VECTOR(c_ext_iaddr_width-1 DOWNTO 0);
    mem1_douta       : IN STD_LOGIC_vector(c_num_channels-1 downto 0);
    mem1_doutb       : IN STD_LOGIC_vector(c_num_channels-1 downto 0)
    );
END COMPONENT;

-- The following tells XST that this core is a black box which
-- should be generated by the command given by the value of this attribute.
-- Note the fully qualified SIM (JAVA class) name that forms the basis of the
-- core.
-- xcc exclude
ATTRIBUTE box_type : STRING;
ATTRIBUTE box_type OF tcc_encoder_3gpp_v4_0 : COMPONENT IS "black_box";
ATTRIBUTE GENERATOR_DEFAULT : STRING;
ATTRIBUTE GENERATOR_DEFAULT OF tcc_encoder_3gpp_v4_0 : COMPONENT IS
                                 "generatecore com.xilinx.ip.tcc_encoder_3gpp_v4_0.tcc_encoder_3gpp_v4_0";
-- xcc include

END tcc_encoder_3gpp_v4_0_comp;
