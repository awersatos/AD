--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 1.4
--  \   \        Filename: $RCSfile: dvb_s2_fec_encoder_v2_0.vhd,v $           
--  /   /        Date Last Modified: $Date: 2009/12/02 13:23:36 $ 
-- /___/   /\    Date Created: 2005 
-- \   \  /  \   
--  \___\/\___\
-- 
--Device  : All
--Library : dvb_s2_fec_encoder_v2_0
--Purpose : Top level dummy model for ROMS.
--Revision: $Revision: 1.2 $
--
-------------------------------------------------------------------------------- 
--  (c) Copyright 2005, 2008-2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;


ENTITY dvb_s2_fec_encoder_v2_0  IS
   GENERIC (   
      c_width              : INTEGER := 4; -- this can currently be 1 or 4
      c_ip_format          : INTEGER := 0; -- this can be 0=raw or 1=bytewise mpeg               
      c_op_format          : INTEGER := 0; -- this can be 0=raw or 1=symbol
      c_ip_buffer_mode     : INTEGER := 0; -- this can be 0=buffer full frame or 1=process asap
      c_op_buffer_size     : INTEGER := 0; -- this can be 0=2 normal packets or 1=3 normal packets
      c_has_ce             : INTEGER := 0;
      c_has_sclr           : INTEGER := 0;
      c_elaboration_dir    : STRING  := "./";
      c_elaboration_transient_dir    : STRING  := "./";
      c_mem_init_prefix    : STRING  := "intlv1";
      c_family             : STRING  := "virtex5";
      c_xdevicefamily      : STRING  := "virtex5"
   );
   PORT (
      din            : IN STD_LOGIC_VECTOR(c_width*(1-c_ip_format)+8*c_ip_format-1 DOWNTO 0):= (OTHERS => '0');
      rate           : IN STD_LOGIC_VECTOR(16-1 DOWNTO 0) := (OTHERS => '0'); 
      nd             : IN STD_LOGIC := '0';
      fd_in          : IN STD_LOGIC := '0';
      cts            : IN STD_LOGIC := '1';
      
      -- output
      dout           : OUT STD_LOGIC_VECTOR(c_width*(1-c_op_format)+5*c_op_format-1 DOWNTO 0);
      fd_out         : OUT STD_LOGIC;
      rate_out       : OUT STD_LOGIC_VECTOR(16-1 DOWNTO 0); 
      
      rffd           : OUT STD_LOGIC;
      rfd            : OUT STD_LOGIC;
      rdy            : OUT STD_LOGIC;

      -- optional pins
      ce             : IN STD_LOGIC := '0';
      sclr           : IN STD_LOGIC := '0';
      clk            : IN STD_LOGIC 
      );


END dvb_s2_fec_encoder_v2_0;

ARCHITECTURE behavioral OF dvb_s2_fec_encoder_v2_0 IS

BEGIN
   
---------------------------------------------------------------
END behavioral;
          
