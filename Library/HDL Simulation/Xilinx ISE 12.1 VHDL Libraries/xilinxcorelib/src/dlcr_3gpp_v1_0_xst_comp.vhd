--------------------------------------------------------------------------------
-- $RCSfile: dlcr_3gpp_v1_0_xst_comp.vhd,v $Revision: 1.6 $Date: 2008/09/09 19:56:23 $
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
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 3.0
--  \   \        Filename: 
--  /   /        Date Created: 01/July/2006
-- /___/   /\
-- \   \  /  \
--  \___\/\___\
--
--------------------------------------------------------------------------------
-- 
-- This text contains proprietary, confidential information of Xilinx, Inc.,
-- is distributed under license from Xilinx, Inc., and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid license agreement
-- with Xilinx, Inc.
-- This copyright notice must be retained as part of this text at all times.
--
-------------------------------------------------------------------------------
-- Author   : Xilinx
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package dlcr_3gpp_v1_0_xst_comp is

--------------------------------------------------------------------------------
------------------------------------------------------------
component dlcr_3gpp_v1_0_xst  
	generic (   
		c_multiple_antenna  : integer  := 2;                 -- this can either be multiple or single
    c_clock_power       : integer  := 3;                             -- no of clocks per chip, range 8 to 64 for clock rate
    c_buffer_width      : integer  := 12; --4096                     -- size of input memory buffer from 512 to 8192
    c_output_width      : integer  := 16;                            -- from 16 to 32

    c_mem_init_prefix   : string  := "dlcr";                         -- memory and build generics
    c_elaboration_dir   : string  := "./";
    c_family            : string  := "virtex4";
    c_xdevicefamily    : string  := ""
  );
  port (
    DSP_CLK           : in std_logic;                                -- ocp interface clock
    DSP_MDATA         : in std_logic_vector(31 downto 0);            -- write data from master to slave
    DSP_MADDR         : in std_logic_vector(21 downto 0);            -- master address 32 bit addressing bottom 2 bits ignored
    DSP_MCMD          : in std_logic_vector(2 downto 0);             -- transfer command 2-read,1-write,0- idle
    DSP_SCMDACCEPT    : out std_logic;                               -- slave accepts transfer 
    DSP_SRESP         : out std_logic_vector(1 downto 0);            -- response field 1 - valid response, 0 null response
    DSP_SDATA         : out std_logic_vector(31 downto 0);           -- requested read data from slave to master
    DSP_SINTERRUPT    : out std_logic;                               -- external interrput for system timing etc

    ANT_CLK           : in std_logic;                                -- chip rate clock
    ANT_MDATA         : out std_logic_vector(2*c_output_width-1 downto 0);  -- fixed pointer interleaved I&Q data
    ANT_MADDR         : out std_logic_vector(c_clock_power-2 downto 0);       -- Antenna ID of output data
    ANT_MCMD          : out std_logic_vector(2 downto 0);                               -- signifies output data is valid
    ANT_MDATAINFO     : out std_logic;                               --  primary frame sync based on TCELL=0
                      
    RESET             : in std_logic                                 -- RESET active high
  );  
end component;

end dlcr_3gpp_v1_0_xst_comp;
          
