--$RCSfile: lte_dl_channel_encoder_v1_0_xst_comp.vhd,v $
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 1.0
--  \   \        Filename: $RCSfile: lte_dl_channel_encoder_v1_0_xst_comp.vhd,v $           
--  /   /        Date Last Modified: $Date: 2008/09/09 20:28:19 $ 
-- /___/   /\    Date Created: April 2008 
-- \   \  /  \   
--  \___\/\___\
-- 
--Device  : All
--Library : lte_bb_ref
--Purpose : Top level main for for lte dl channel encoder
--Revision: $Revision: 1.2 $
--
-------------------------------------------------------------------------------- 
-- DISCLAIMER OF LIABILITY
-- 
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
--
-- Copyright (c) 2008 Xilinx, Inc. All rights reserved.
--
-- This copyright and support notice must be retained as part 
-- of this text at all times. 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Standard: 3GPP TS 36.212.v1.2.3 version 8.2
--
-- Description:
-- 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package lte_dl_channel_encoder_v1_0_xst_comp is

constant MEMADDR_W : natural := 6;
constant MEM_W : natural := 32;

component lte_dl_channel_encoder_v1_0_xst
  generic
  (
    c_family                       : string  := "virtex5";
    c_xdevicefamily                : string  := "virtex5";
    c_elaboration_transient_dir    : string  := "test";
    c_mem_init_prefix              : string  := "dec";
    c_elaboration_dir              : string  := "./";
    c_component_name               : string  := "lte_dec";
    c_has_sch                      : integer := 1;
    c_has_cch                      : integer := 1;
    c_has_ich                      : integer := 1;
    c_has_rdif                     : integer := 0
  );
  port
  (
	  --inputs
    aclk            : in std_logic;
    areset          : in std_logic;
    -- ssch tb
    sschtb_wdata    : in std_logic := '0';
    sschtb_wstart   : in std_logic := '0';
    sschtb_wend     : in std_logic := '0';
    sschtb_wvalid   : in std_logic := '0';
    sschtb_wready   : out std_logic;
    -- msch cb                    
    mschcb_wdata    : out std_logic;
    mschcb_wstart   : out std_logic;
    mschcb_wend     : out std_logic;
    mschcb_wvalid   : out std_logic;
    mschcb_wready   : in std_logic;
    -- scch tb
    scchtb_wdata    : in std_logic := '0';
    scchtb_wstart   : in std_logic := '0';
    scchtb_wend     : in std_logic := '0';
    scchtb_wvalid   : in std_logic := '0';
    scchtb_wready   : out std_logic; 
    -- mcch cb                      
    mcchcb_wdata    : out std_logic;
    mcchcb_wstart   : out std_logic;
    mcchcb_wend     : out std_logic;
    mcchcb_wvalid   : out std_logic;
    mcchcb_wready   : in std_logic := '0';
    -- mcch cb                      
    michcb_wdata    : out std_logic;
    michcb_wstart   : out std_logic;
    michcb_wend     : out std_logic;
    michcb_wvalid   : out std_logic;
    michcb_wready   : in std_logic := '0';
    -- sreg
    -- address write
    sreg_awaddr     : in std_logic_vector(MEMADDR_W-1 downto 0);
    sreg_awvalid    : in std_logic := '0';
    sreg_awready    : out std_logic;
    -- data write
    sreg_wdata      : in std_logic_vector(MEM_W-1 downto 0);
    sreg_wvalid     : in std_logic := '0';
    sreg_wready     : out std_logic;
    -- address read
    sreg_araddr     : in std_logic_vector(MEMADDR_W-1 downto 0);
    sreg_arvalid    : in std_logic := '0';
    sreg_arready    : out std_logic;
    -- read data
    sreg_rdata      : out std_logic_vector(MEM_W-1 downto 0);
    sreg_rvalid     : out std_logic;
    sreg_rready     : in std_logic := '0';
    -- fifo status flags
    sch_fulln       : out std_logic;
    sch_fail        : out std_logic;
    cch_fulln       : out std_logic;
    cch_fail        : out std_logic;
    ich_fulln       : out std_logic

   );
end component;


end lte_dl_channel_encoder_v1_0_xst_comp;
------------------- EOF $ID:$ ----------------------
