--$RCSfile: lte_dl_channel_encoder_v2_0_xst_comp.vhd,v $
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 1.0
--  \   \        Filename: $RCSfile: lte_dl_channel_encoder_v2_0_xst_comp.vhd,v $           
--  /   /        Date Last Modified: $Date: 2009/09/08 15:40:34 $ 
-- /___/   /\    Date Created: April 2008 
-- \   \  /  \   
--  \___\/\___\
-- 
--Device  : All
--Library : lte_bb_ref
--Purpose : Top level main for for lte dl channel encoder
--Revision: $Revision: 1.3 $
--
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------------
-- ? Copyright 2008-2009 Xilinx, Inc. All rights reserved. 
-- 
-- This file contains confidential and proprietary information of Xilinx, Inc.
-- and is protected  under U.S. and international copyright and other
-- intellectual property laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any rights to the
-- materials distributed herewith. Except as otherwise provided in a valid
-- license issued to you by Xilinx, and to the maximum extent permitted by
-- applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
-- FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
-- IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
-- MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
-- and (2) Xilinx shall not be liable (whether in contract or tort, including
-- negligence, or under any other theory of liability) for any loss or damage
-- of any kind or nature related to, arising under or in connection with these
-- materials, including for any direct, or any indirect, special, incidental,
-- or consequential loss or damage (including loss of data, profits, goodwill,
-- or any type of loss or damage suffered as a result of any action brought by
-- a third party) even if such damage or loss was reasonably foreseeable or
-- Xilinx had been advised of the possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-safe, or for use in
-- any application requiring fail-safe performance, such as life-support or
-- safety devices or systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any other applications
-- that could lead to death, personal injury, or severe property or
-- environmental damage (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and liability of any use of
-- Xilinx products in Critical Applications, subject only to applicable laws
-- and regulations governing limitations on product liability. 
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.

-------------------------------------------------------------------------------------------
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

package lte_dl_channel_encoder_v2_0_xst_comp is

constant MEMADDR_W : natural := 6;
constant MEM_W : natural := 32;

component lte_dl_channel_encoder_v2_0_xst
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
    mschcb_wstart_tb: out std_logic;
    mschcb_wend     : out std_logic;
    mschcb_wend_tb  : out std_logic;
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


end lte_dl_channel_encoder_v2_0_xst_comp;
------------------- EOF $ID$ ----------------------
