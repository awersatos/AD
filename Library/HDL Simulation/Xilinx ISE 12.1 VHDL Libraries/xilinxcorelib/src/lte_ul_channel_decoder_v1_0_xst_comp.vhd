-- $RCSfile $ $Date: 2008/09/09 20:29:19 $ $Revision: 1.2 $
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
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package lte_ul_channel_decoder_v1_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component lte_ul_channel_decoder_v1_0_xst
  component lte_ul_channel_decoder_v1_0_xst
    GENERIC (
   -- LTE_UL_Channel_Decoder General Generics
   c_family             : string := "virtex5";
   c_xdevicefamily      : string := "virtex5";
   c_elaboration_dir    : string  := "./";
   c_component_name     : string  := "LTE_UL_Channel_Decoder_v1_0";
   ----- Turbo Decoder core specific Generics ------
   c_num_pu             : integer := 4;   -- 2,4,8 processing units
   c_num_mem_chunks     : integer := 512; -- 256,512 processing units
   c_algorithm_type     : integer := 1;   -- 0=max, 1=maxscale, 2=max*
   c_num_dsp            : integer := 0;   -- number of dsp blocks available
   c_opt_goal           : integer := 0   -- 0=balanced, 1=speed
	   );
    PORT (
      ACLK          : in  std_logic;
      ARESET        : in  std_logic;
      SREG_WDATA    : in  std_logic_vector(31 downto 0);
      SREG_WVALID   : in  std_logic;
      SREG_WREADY   : out std_logic;
      SREG_AWADDR   : in  std_logic_vector(3 downto 0);
      SREG_AWVALID  : in  std_logic;
      SREG_AWREADY  : out std_logic;
      SSCHTB_WDATA  : in  std_logic_vector(47 downto 0);
      SSCHTB_WSTART : in  std_logic;
      SSCHTB_WEND   : in  std_logic;
      SSCHTB_WVALID : in  std_logic;
      SSCHTB_WREADY : out std_logic;
      SREG_RDATA    : out std_logic_vector(31 downto 0);
      SREG_RVALID   : out std_logic;
      SREG_RREADY   : in  std_logic;
      SREG_ARADDR   : in  std_logic_vector(3 downto 0);
      SREG_ARVALID  : in  std_logic;
      SREG_ARREADY  : out std_logic;
      MSCHTB_WDATA  : out std_logic;
      MSCHTB_WSTART : out std_logic;
      MSCHTB_WEND   : out std_logic;
      MSCHTB_WVALID : out std_logic;
      MSCHTB_WREADY : in  std_logic;
      SHARQ_WDATA   : in  std_logic_vector(31 downto 0);
      SHARQ_WSTART  : in  std_logic;
      SHARQ_WEND    : in  std_logic;
      SHARQ_WVALID  : in  std_logic;
      SHARQ_WREADY  : out std_logic;
      MHARQ_WDATA   : out std_logic_vector(31 downto 0);
      MHARQ_WSTART  : out std_logic;
      MHARQ_WEND    : out std_logic;
      MHARQ_WVALID  : out std_logic;
      MHARQ_WREADY  : in  std_logic
      );
  --core_if off
  END COMPONENT;


end lte_ul_channel_decoder_v1_0_xst_comp;

