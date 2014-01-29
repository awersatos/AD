-- $Id: tcc_encoder_v1_0_comp.vhd,v 1.13 2008/09/08 20:10:10 akennedy Exp $
-------------------------------------------------------------------------------
-- Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2003 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------
-- AUTHOR      : David Lawrie
-- DATE        : 19th March 2003
--               Turbo Encoder.
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v6_0.ALL;

PACKAGE tcc_encoder_v1_0_comp IS

CONSTANT COMP_PKG_block_size_sel_width : INTEGER :=4;
-------------------------------------------------------------------------------
--define the tcc_encoder main component
-------------------------------------------------------------------------------
COMPONENT tcc_encoder_v1_0
  GENERIC(
    c_has_ce		         : INTEGER :=0;
    c_has_sclr		         : INTEGER :=0;
    c_has_aclr		         : INTEGER :=0;
    c_has_external_ram     : INTEGER := 0;
    c_has_block_size_valid : INTEGER := 0;
    c_family               : STRING  := "virtex2";
    c_enable_rlocs         : INTEGER :=0);
  PORT(
    clk             : IN STD_LOGIC;
    ce              : IN STD_LOGIC := '1';
    aclr            : IN STD_LOGIC := '0';
    sclr            : IN STD_LOGIC := '0';
    fd		        : IN STD_LOGIC := '0';    
    block_size_sel  : IN STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
    data_in         : IN STD_LOGIC := '0';
    rfd		        : OUT STD_LOGIC; 
    rffd		        : OUT STD_LOGIC; 
    rdy				  : OUT STD_LOGIC;
    block_size_valid: OUT STD_LOGIC;

    ram_we          : OUT STD_LOGIC;    
    ram_din         : OUT STD_LOGIC;    
    ram_intl_addr   : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);    
    ram_intl_data   : IN  STD_LOGIC := '0';    
    ram_fb_addr     : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);        
    ram_fb_data     : IN STD_LOGIC := '0';    

    rsc1_systematic : OUT STD_LOGIC; 
    rsc1_parity0    : OUT STD_LOGIC;
    rsc1_parity1    : OUT STD_LOGIC;
    rsc2_systematic : OUT STD_LOGIC; 
    rsc2_parity0    : OUT STD_LOGIC;
    rsc2_parity1    : OUT STD_LOGIC;
    block_end       : OUT STD_LOGIC;
    rsc1_tail       : OUT STD_LOGIC;
    rsc2_tail       : OUT STD_LOGIC);
END COMPONENT ;

-- The following tells XST that viterbi_v3_0 is a black box which  
-- should be generated command given by the value of this attribute 
-- Note the fully qualified SIM (JAVA class) name that forms the 
-- basis of the core 
attribute box_type : string; 
attribute box_type of tcc_encoder_V1_0 : component is "black_box"; 
attribute GENERATOR_DEFAULT : string; 
attribute GENERATOR_DEFAULT of tcc_encoder_V1_0 : component is 
          "generatecore com.xilinx.ip.tcc_encoder_V1_0.tcc_encoder_V1_0"; 

END tcc_encoder_v1_0_comp;


