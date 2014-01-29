---------------------------------------------------------------------------
-- $RCSfile: blkmemdp_v6_3_xst_comp.vhd,v $
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
-- Filename:    blkmemdp_v6_3_xst_comp.vhd
--
-- Description - This file contains the component declaration for
--               the blkmemdp_v6_3 core wrapper. This wrapper allows the core
--               to be instantiated by higher level XST cores.
--               A duplicate of this file, with no reference to LIBRARY
--               xilinxcorelib is placed in the top level directory for
--               XST. These two files must be kept identical apart from
--               LIBRARY usage.
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Note XST cannot use this file because it doesn't know what xilinxcorelib is.
LIBRARY xilinxcorelib;
USE xilinxcorelib.blkmemdp_pkg_v6_3.ALL;


PACKAGE blkmemdp_v6_3_xst_comp IS

----------------------------------------------------------------------------
-- COMPONENT DECLARATION
----------------------------------------------------------------------------
COMPONENT blkmemdp_v6_3_xst
	GENERIC( 
                 c_addra_width	      : INTEGER := DEFAULT_ADDA_WIDTH;
                 c_addrb_width	      : INTEGER := DEFAULT_ADDB_WIDTH;
                 c_limit_data_pitch   : INTEGER := DEFAULT_LIMIT_PITCH;
                 c_default_data       : STRING  := DEFAULT_DEFAULT_DATA;
                 c_depth_a	      : INTEGER := DEFAULT_DEPTHA;
                 c_depth_b	      : INTEGER := DEFAULT_DEPTHB;
                 c_enable_rlocs	      : INTEGER := DEFAULT_EN_RLOCS;
                 c_family               : STRING  := DEFAULT_FAMILY;     
                 c_has_limit_data_pitch: INTEGER := DEFAULT_HAS_LIMIT_PITCH;
                 c_has_default_data   : INTEGER := DEFAULT_HAS_DEFAULT;
                 c_has_dina	      : INTEGER := DEFAULT_HAS_DINA;
                 c_has_dinb	      : INTEGER := DEFAULT_HAS_DINB;
                 c_has_douta          : INTEGER := DEFAULT_HAS_DOUTA;
                 c_has_doutb          : INTEGER := DEFAULT_HAS_DOUTB;
                 c_has_ena	      : INTEGER := DEFAULT_HAS_ENA;
                 c_has_enb	      : INTEGER := DEFAULT_HAS_ENB;
                 c_has_nda	      : INTEGER := DEFAULT_HAS_NDA;
                 c_has_ndb	      : INTEGER := DEFAULT_HAS_NDB;
                 c_has_rdya	      : INTEGER := DEFAULT_HAS_RDYA;
                 c_has_rdyb	      : INTEGER := DEFAULT_HAS_RDYB;
                 c_has_rfda	      : INTEGER := DEFAULT_HAS_RFDA;
                 c_has_rfdb	      : INTEGER := DEFAULT_HAS_RFDB;
                 c_has_sinita	      : INTEGER := DEFAULT_HAS_SINITA;
                 c_has_sinitb	      : INTEGER := DEFAULT_HAS_SINITB;
                 c_has_wea	      : INTEGER := DEFAULT_HAS_WEA;
                 c_has_web	      : INTEGER := DEFAULT_HAS_WEB;
                 c_mem_init_file      : STRING  := DEFAULT_MEM_INIT;
                 c_pipe_stages_a      : INTEGER := DEFAULT_PIPE_STAGESA;
                 c_pipe_stages_b      : INTEGER := DEFAULT_PIPE_STAGESB;
                 c_reg_inputsa        : INTEGER := DEFAULT_REG_INPUTSA;
                 c_reg_inputsb        : INTEGER := DEFAULT_REG_INPUTSB;
                 c_sinita_value	      : STRING  := DEFAULT_SINIT_VALUEA;
                 c_sinitb_value	      : STRING  := DEFAULT_SINIT_VALUEB;
                 c_width_a	      : INTEGER := DEFAULT_WIDTHA;
                 c_width_b	      : INTEGER := DEFAULT_WIDTHB;
                 c_write_modea	      : INTEGER := DEFAULT_WRITE_MODEA;
                 c_write_modeb	      : INTEGER := DEFAULT_WRITE_MODEB;
                 --c_xmem_init_array    : MEM_ARRAY := DEFAULT_XMEM_INIT_ARRAY                 
                 c_ybottom_addr     : STRING := DEFAULT_BOTTOM_ADDR ;
                 c_yclka_is_rising     : INTEGER := DEFAULT_CLKA_IS_RISING;
                 c_yclkb_is_rising     : INTEGER := DEFAULT_CLKB_IS_RISING;
                 c_yena_is_high        : INTEGER := DEFAULT_ENA_IS_HIGH ;
                 c_yenb_is_high        : INTEGER := DEFAULT_ENB_IS_HIGH ;
                 c_yhierarchy       : STRING  := DEFAULT_HIERARCHY ;
                 c_ymake_bmm        : INTEGER := DEFAULT_MAKE_BMM ;
                 c_yprimitive_type    : STRING := DEFAULT_PRIMITIVE_TYPE;
                 c_ysinita_is_high     : INTEGER := DEFAULT_SINITA_IS_HIGH;
                 c_ysinitb_is_high     : INTEGER := DEFAULT_SINITB_IS_HIGH;
                 c_ytop_addr        : STRING := DEFAULT_TOP_ADDR ;
                 c_yuse_single_primitive : INTEGER := DEFAULT_USE_SINGLE_PRIMITIVE;
                 c_ywea_is_high        : INTEGER := DEFAULT_WEA_IS_HIGH;
                 c_yweb_is_high        : INTEGER := DEFAULT_WEB_IS_HIGH;
                 -- New generic to turn off(1) or on (0) warning messages
                 c_yydisable_warnings    : integer := DEFAULT_DISABLE_WARNINGS
                 

               );

  PORT  (DINA  : in STD_LOGIC_VECTOR (c_width_a-1 downto 0):= (OTHERS => '0');
        DINB   : in STD_LOGIC_VECTOR (c_width_b-1 downto 0):= (OTHERS => '0');
        ENA    : in STD_LOGIC:= '1';
        ENB    : in STD_LOGIC:= '1';
        WEA    : in STD_LOGIC:= '0';
        WEB    : in STD_LOGIC:= '0';
        SINITA : in STD_LOGIC:= '0';
        SINITB : in STD_LOGIC:= '0';
        NDA    : in STD_LOGIC:= '0';
        NDB    : in STD_LOGIC:= '0';
        CLKA   : in STD_LOGIC;
        CLKB   : in STD_LOGIC;
        ADDRA  : in STD_LOGIC_VECTOR (c_addra_width-1 downto 0);
        ADDRB  : in STD_LOGIC_VECTOR (c_addrb_width-1 downto 0);
        RDYA   : out STD_LOGIC;
        RDYB   : out STD_LOGIC;
        RFDA   : out STD_LOGIC;
        RFDB   : out STD_LOGIC;
        DOUTA  : out STD_LOGIC_VECTOR (c_width_a-1 downto 0);
        DOUTB  : out STD_LOGIC_VECTOR (c_width_b-1 downto 0)
       ); 

END COMPONENT;

-- The following tells XST that this core is a black box which  
-- should be generated with the command given by the value of this attribute.
-- Note the fully qualified SIM (JAVA class) name that forms the 
-- basis of the core.
ATTRIBUTE box_type : STRING; 
ATTRIBUTE box_type OF blkmemdp_v6_3_xst : COMPONENT IS "black_box"; 
ATTRIBUTE GENERATOR_DEFAULT : STRING; 
ATTRIBUTE GENERATOR_DEFAULT OF blkmemdp_v6_3_xst : COMPONENT IS 
          "generatecore com.xilinx.ip.blkmemdp_v6_3.blkmemdp_v6_3_xst";

        
END blkmemdp_v6_3_xst_comp;
