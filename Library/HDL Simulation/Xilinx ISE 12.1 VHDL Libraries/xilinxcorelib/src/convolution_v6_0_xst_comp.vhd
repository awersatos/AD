-- $Header: /devl/xcs/repo/env/Databases/ip/src2/I/convolution_v6_0/simulation/convolution_v6_0_xst_comp.vhd,v 1.8 2008/09/08 19:36:57 akennedy Exp $
--
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


PACKAGE convolution_v6_0_xst_comp IS

   COMPONENT convolution_v6_0_xst
      GENERIC ( 
         c_output_rate        : INTEGER:=3; 
         c_constraint_length  : INTEGER:=3; 
         c_punctured          : INTEGER:=0;
         c_dual_channel       : INTEGER:=0;
         c_punc_input_rate    : INTEGER:=3;
         c_punc_output_rate   : INTEGER:=4;

         c_convolution_code0  : INTEGER:=5;
         c_convolution_code1  : INTEGER:=7;
         c_convolution_code2  : INTEGER:=5;
         c_convolution_code3  : INTEGER:=7;
         c_convolution_code4  : INTEGER:=5;
         c_convolution_code5  : INTEGER:=7;
         c_convolution_code6  : INTEGER:=5;

         c_punc_code0         : INTEGER:=0;
         c_punc_code1         : INTEGER:=0;

         c_has_nd             : INTEGER:=0;
         c_has_rfd            : INTEGER:=0;
         c_has_rdy            : INTEGER:=0;
         c_has_fd             : INTEGER:=0;
         c_has_rffd           : INTEGER:=0;

         c_has_ce             : INTEGER:=1;  
         c_has_aclr           : INTEGER:=0;   
         c_has_sclr           : INTEGER:=0
      );
      PORT (
         data_in        : IN STD_LOGIC;
         data_out_v     : OUT STD_LOGIC_VECTOR(c_output_rate-1 DOWNTO 0);
         data_out_s     : OUT STD_LOGIC;
         fd_in          : IN STD_LOGIC;
         nd             : IN STD_LOGIC;
         rfd            : OUT STD_LOGIC;
         rffd           : OUT STD_LOGIC;
         rdy            : OUT STD_LOGIC;
         ce             : IN STD_LOGIC; 
         sclr           : IN STD_LOGIC;
         aclr           : IN STD_LOGIC;
         clk            : IN STD_LOGIC
      );
   END COMPONENT;
END convolution_v6_0_xst_comp;
