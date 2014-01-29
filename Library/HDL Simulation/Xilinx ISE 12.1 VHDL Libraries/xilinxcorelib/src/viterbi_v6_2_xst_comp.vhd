--------------------------------------------------------------------------------
-- $RCSfile: viterbi_v6_2_xst_comp.vhd,v $Revision: 1.4 $Date: 2008/09/09 15:27:24 $
--------------------------------------------------------------------------------
-- Copyright (c) 2006-2007 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you a 
-- license to use this text/file solely for design, simulation, 
-- implementation and creation of design files limited 
-- to Xilinx devices or technologies. Use with non-Xilinx 
-- devices or technologies is expressly prohibited and 
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information 
-- "as-is" solely for use in developing programs and 
-- solutions for Xilinx devices, with no obligation on the 
-- part of Xilinx to provide support. By providing this design, 
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
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
--
-- Any modifications that are made to the Source Code are 
-- done at the user?s sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part 
-- of this text at all times. (c) Copyright 2006-2007 Xilinx, Inc.
-- All rights reserved.
--------------------------------------------------------------------------------
--
-- Component statement for top level XST file for use in VHDL simulation only.
-- The component statement for use by XST is in bb_comps.vhd
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


package viterbi_v6_2_xst_comp is

--------------------------------------------------------------------------------
------------------------------------------------------------
component viterbi_v6_2_xst  
   generic (   
      c_convcode0_radix    : integer := 2;
      c_convcode1_radix    : integer := 2;
   
      c_has_erased         : integer := 0; 
      c_red_latency        : integer := 0;
--      c_radix4             : integer := 0;
      c_speed_v5           : integer := 0;
      c_component_name    : string  := "vitv6_2";
      c_elaboration_dir    : string  := ".";
      
      c_serial             : integer := 0;
      c_channel_count      : integer := 1;
      c_dual_decoder       : integer := 0;
      c_trellis_mode       : integer := 0;
      c_has_sync           : integer := 0;
      c_has_sync_thresh    : integer := 0;
      c_sync_norm_thresh   : integer := 20;
      c_sync_ber_thresh    : integer := 20;
      c_has_block_valid    : integer := 0;
      
      c_ps_state           : integer := 0;
      c_tb_state           : integer := 0;
      c_direct_tb_max      : integer := 42;
      
      c_constraint_length  : integer:= 7;
      c_traceback_length   : integer:= 42;
      
      c_has_best_state     : integer:= 0;
      c_best_state_width   : integer:= 3;

      c_max_rate           : integer:= 2;
      c_output_rate0       : integer:= 2;
      c_convolution0_code0 : integer:= 121;
      c_convolution0_code1 : integer:= 91;
      c_convolution0_code2 : integer:= 0;
      c_convolution0_code3 : integer:= 0;
      c_convolution0_code4 : integer:= 0;
      c_convolution0_code5 : integer:= 0;
      c_convolution0_code6 : integer:= 0;

      c_output_rate1       : integer:= 0;
      c_convolution1_code0 : integer:= 0;
      c_convolution1_code1 : integer:= 0;
      c_convolution1_code2 : integer:= 0;
      c_convolution1_code3 : integer:= 0;
      c_convolution1_code4 : integer:= 0;
      c_convolution1_code5 : integer:= 0;
      c_convolution1_code6 : integer:= 0;

      c_soft_coding       : integer:= 1;
      c_soft_code         : integer:= 0;
      c_soft_width        : integer:= 3;

      c_has_ber           : integer:= 0;
      c_ber_rate          : integer:= 0;
      c_has_norm          : integer:= 0; 
      
      c_has_rdy           : integer:= 1;
           
      c_has_ce            : integer:= 0;
      c_has_aclr          : integer:= 0;
      c_has_sclr          : integer:= 0;
      c_use_dsp48         : integer:= 0;
      c_family            : string  := "virtex2"
   );
   port (
      DATA_IN0       : in std_logic_vector(c_soft_width-1 downto 0):= (others => '0');
      DATA_IN1       : in std_logic_vector(c_soft_width-1 downto 0):= (others => '0');
      DATA_IN2       : in std_logic_vector(c_soft_width-1 downto 0):= (others => '0');
      DATA_IN3       : in std_logic_vector(c_soft_width-1 downto 0):= (others => '0');
      DATA_IN4       : in std_logic_vector(c_soft_width-1 downto 0):= (others => '0');
      DATA_IN5       : in std_logic_vector(c_soft_width-1 downto 0):= (others => '0');
      DATA_IN6       : in std_logic_vector(c_soft_width-1 downto 0):= (others => '0');

      TCM00          : in std_logic_vector(c_soft_width downto 0):= (others => '0');
      TCM01          : in std_logic_vector(c_soft_width downto 0):= (others => '0');
      TCM10          : in std_logic_vector(c_soft_width downto 0):= (others => '0');
      TCM11          : in std_logic_vector(c_soft_width downto 0):= (others => '0');

      SECTOR_IN      : in std_logic_vector(3 downto 0):= (others => '0');
      BLOCK_IN       : in std_logic;
      
      PACKET_START   : in std_logic;
      TB_BLOCK       : in std_logic;
      PS_STATE       : in std_logic_vector(c_constraint_length-2 downto 0);
      TB_STATE       : in std_logic_vector(c_constraint_length-2 downto 0);       

      ERASE          : in std_logic_vector(c_max_rate-1 downto 0);

      BER_THRESH     : in std_logic_vector(16-1 downto 0);
      NORM_THRESH    : in std_logic_vector(16-1 downto 0);
      
      DATA_OUT       : out std_logic;
      
      DATA_OUT_DIRECT : out std_logic;
      DATA_OUT_REVERSE: out std_logic;

      BER            : out std_logic_vector(16-1 downto 0);
      BER_DONE       : out std_logic;
      NORM           : out std_logic;
      
      OUT_OF_SYNC    : out std_logic;
      OOS_FLAG       : out std_logic_vector(2 downto 0);
      
      SECTOR_OUT     : out std_logic_vector(3 downto 0);
      BLOCK_OUT      : out std_logic;
      PACKET_START_O : out std_logic;
      TB_BLOCK_O     : out std_logic;
      DIRECT_RDY     : out std_logic;
      REVERSE_RDY    : out std_logic;
         
      SEL            : in std_logic := '0';
      SEL_O          : out std_logic;
            
      ND             : in std_logic := '0';
      RFD            : out std_logic;
      RDY            : out std_logic;
      CE             : in std_logic := '0';
      ACLR           : in std_logic := '0';
      SCLR           : in std_logic := '0';
      CLK            : in std_logic);
end component;

end viterbi_v6_2_xst_comp;
          
