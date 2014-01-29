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
--
------------------------------------------------------------------------------
-- $Id: blkmemsp_v6_0_comp.vhd,v 1.13 2008/09/08 20:06:40 akennedy Exp $
----------------------------------------------------------------------------
-- Block Memory Compiler VII :  VHDL Component package
----------------------------------------------------------------------------
--

----------------------------------------------------------------------------
-- Filename:  blkmemsp_v6_0_comp.vhd.vhd
--      
-- Description:  
--         Contains definitions of components used in blkmemv2_v2_0 core.
----------------------------------------------------------------------------
-- Structure: n/a
--          
----------------------------------------------------------------------------
-- Author:      Christopher Ebeling
-- History:
--              Ebeling    04/20/2000 - First Version
--              Ismail     05/18/2000 - Updated the generics to the latest
--              Ismail     06/01/2000 - Change c_has_limit_data_pitch and
--                                      c_limit_data_pitch to
--                                      c_has_limit_data_pitch and 
--                                      c_limit_data_pitch.
--              Ismail     08/02/2000 - Change c_has_default_data to c
--                                      c_mem_init_source.  Add new generic
--                                      c_xmem_init_array
--              Ismail     08/03/2000 - Substitute c_mem_init_source with
--                                      c_has_default_data and c_mem_init_array
--                                      with c_xmem_init_array
----------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.blkmemsp_pkg_v6_0.ALL;


PACKAGE blkmemsp_v6_0_comp IS

----------------------------------------------------------------------------
-- COMPONENT DECLARATION
----------------------------------------------------------------------------
COMPONENT blkmemsp_v6_0
 GENERIC( c_addr_width       : INTEGER := DEFAULT_ADD_WIDTH;
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

--------------------------------------------------------------------------------
--  Definition of Generics: 
--      c_addr_width          -- controls the width of the address pins
--      c_bit_pitch           -- indicates the max bit pitch for the core 
--      c_default_data        -- indicates string of hex characters
--                               used to initialize the memory
--      c_depth               -- controls the depth of the memory (I/O port)
--      c_enable_rlocs        -- core includes placement constraints
--      c_family              -- designates the target family device
--      c_has_bit_pitch       -- indicates if the core is built using a
--                               specified bit pitch
--      c_has_default_data    -- determines the source of memory initial
--                               -ization (0 (default_data),1(mif),
--                               2(mem_init_array))
--      c_has_din             -- the memory module has data input pins
--      c_has_en              -- memory has an EN(able) pin
--      c_has_nd              -- memory has a new data pin (ND)
--      c_has_rdy             -- memory has an output ready pin (RDY)
--      c_has_rfd             -- memory has a ready for data pin 
--      c_has_sinit           -- memory has a SINIT pin
--      c_has_we              -- memory has a WE pin
--      c_xmem_init_array     -- array for memory initialization 
--      c_mem_init_file       -- controls which .COE file used to
--                               initialize the memory
--      c_pipe_stages         -- indicates the number of pipe stages
--                               needed on the output.
--      c_reg_inputs          -- register all memory inputs (except en)
--      c_sinit_value         -- indicates string of hex characters
--                               used to initialize the output
--                               register (i.e. DOUT)
--      c_width               -- controls the width of I/O data port
--      c_write_mode          -- controls which write modes shall
--                               be implemented (c_write_first, 
--                               c_read_first, c_no_change)
--  Definition of Ports: 
--      addr                 -- port- address 
--      clk                  -- port- clock pin
--      din                  -- port- data input 
--      dout                 -- port- registered output
--      en                   -- port- enable pin
--      nd                   -- port- new data pin
--      rfd                  -- port- ready for data pin
--      rdy                  -- port- result ready pin
--      sinit                -- port- syncrhonous initialization pin
--      we                   -- port- write enable pin
------------------------------------------------------------------------------        
        
END blkmemsp_v6_0_comp;
