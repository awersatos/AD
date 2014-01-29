---------------------------------------------------------------------------
-- $RCSfile: blkmemsp_v6_2_xst_comp.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:48 $
---------------------------------------------------------------------------
--                                                                       
-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
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
-- of this text at all times. (c) Copyright 1995-2004 Xilinx, Inc.
-- All rights reserved.
--
--------------------------------------------------------------------------------
-- Filename:    blkmemsp_v6_2_xst_comp.vhd
--
-- Description - This file contains the component declaration for
--               the blkmemsp_v6_2 core wrapper. This wrapper allows the core
--               to be instantiated by higher level XST cores.
--               This version of the file is for simulation only. It is
--               identical to the file of the same name in the top level
--               directory, except it uses LIBRARY xilinxcorelib.
--
--------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Note XST cannot use this file because it doesn't know what xilinxcorelib is.
LIBRARY xilinxcorelib;
USE xilinxcorelib.blkmemsp_pkg_v6_2.ALL;


PACKAGE blkmemsp_v6_2_xst_comp IS

----------------------------------------------------------------------------
-- COMPONENT DECLARATION
----------------------------------------------------------------------------
COMPONENT blkmemsp_v6_2_xst
 GENERIC(  c_addr_width       : INTEGER := DEFAULT_ADD_WIDTH;
           c_limit_data_pitch : INTEGER := DEFAULT_LIMIT_PITCH;
           c_default_data     : STRING  := DEFAULT_DEFAULT_DATA;
           c_depth            : INTEGER := DEFAULT_DEPTH;
           c_enable_rlocs     : INTEGER := DEFAULT_EN_RLOCS;
           c_family           : STRING  := DEFAULT_FAMILY;     
           c_has_limit_data_pitch: INTEGER := DEFAULT_HAS_LIMIT_PITCH;
           c_has_default_data : INTEGER := DEFAULT_HAS_DEFAULT;
           c_has_din          : INTEGER := DEFAULT_HAS_DIN;
           c_has_en           : INTEGER := DEFAULT_HAS_EN;
           c_has_nd           : INTEGER := DEFAULT_HAS_ND;
           c_has_rdy          : INTEGER := DEFAULT_HAS_RDY;
           c_has_rfd          : INTEGER := DEFAULT_HAS_RFD;
           c_has_sinit        : INTEGER := DEFAULT_HAS_SINIT;
           c_has_we           : INTEGER := DEFAULT_HAS_WE;
           --------------------------------------------------------------------
           -- new generics
           -- c_xmem_init_array   : MEM_ARRAY := ("123456", "123456", "123456", "123456", "123456", "123456");
           c_mem_init_file    : STRING  := DEFAULT_MEM_INIT;
           --------------------------------------------------------------------
           c_pipe_stages      : INTEGER := DEFAULT_PIPE_STAGES;
           c_reg_inputs       : INTEGER := DEFAULT_REG_INPUTS;
           c_sinit_value      : STRING  := DEFAULT_SINIT_VALUE;
           c_width            : INTEGER := DEFAULT_WIDTH;
           c_write_mode       : INTEGER := DEFAULT_WRITE_MODE;
           c_ybottom_addr     : STRING := DEFAULT_BOTTOM_ADDR ;
           c_yclk_is_rising   : INTEGER := DEFAULT_CLK_IS_RISING;
           c_yen_is_high      : INTEGER := DEFAULT_EN_IS_HIGH ;
           c_yhierarchy       : STRING  := DEFAULT_HIERARCHY ;
           c_ymake_bmm        : INTEGER := DEFAULT_MAKE_BMM ;
           c_yprimitive_type  : STRING  := DEFAULT_PRIMITIVE_TYPE;
           c_ysinit_is_high   : INTEGER := DEFAULT_SINIT_IS_HIGH;
           c_ytop_addr        : STRING := DEFAULT_TOP_ADDR ;
           c_yuse_single_primitive : INTEGER := DEFAULT_USE_SINGLE_PRIMITIVE;
           c_ywe_is_high      : INTEGER := DEFAULT_WE_IS_HIGH;
           c_yydisable_warnings: INTEGER := DEFAULT_DISABLE_WARNINGS
         );
  PORT   ( addr              : IN STD_LOGIC_VECTOR (c_addr_width-1 DOWNTO 0);
           clk               : IN STD_LOGIC;
           din               : IN STD_LOGIC_VECTOR (c_width-1 DOWNTO 0);
           dout              : OUT STD_LOGIC_VECTOR (c_width-1 DOWNTO 0);
           en                : IN STD_LOGIC;
           nd                : IN STD_LOGIC;
           rfd               : OUT STD_LOGIC;
           rdy               : OUT STD_LOGIC;
           sinit             : IN STD_LOGIC;
           we                : IN STD_LOGIC
         );
END COMPONENT;


-- The following tells XST that this core is a black box which  
-- should be generated with the command given by the value of this attribute.
-- Note the fully qualified SIM (JAVA class) name that forms the 
-- basis of the core.
ATTRIBUTE box_type : string; 
ATTRIBUTE box_type OF blkmemsp_v6_2_xst : COMPONENT IS "black_box"; 
ATTRIBUTE GENERATOR_DEFAULT : string; 
ATTRIBUTE GENERATOR_DEFAULT OF blkmemsp_v6_2_xst : COMPONENT IS 
          "generatecore com.xilinx.ip.blkmemsp_v6_2.blkmemsp_v6_2_xst";

        
END blkmemsp_v6_2_xst_comp;
