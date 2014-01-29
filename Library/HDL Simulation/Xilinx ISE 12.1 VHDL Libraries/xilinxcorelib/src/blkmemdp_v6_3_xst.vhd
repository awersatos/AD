-----------------------------------------------------------------------------
-- $RCSfile: blkmemdp_v6_3_xst.vhd,v $
-----------------------------------------------------------------------------
--
-- Dual Port Block Memory  - Behavioral Model wrapper
--
-----------------------------------------------------------------------------
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
--
-- Simple wrapper for the blkmemdp_v6_3 core.
-- XST cores that instantiate this core should use this wrapper.
-- This model is only for other cores that instantiate the blkmemdp. These
-- will instantiate the blkmemdp_v6_3_xst component.
-- This file itself is not analyzed by XST. it only requires the component
-- statement package.
-- This file is for behavioral simulation and also for use by Coregen.
--
--


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.blkmemdp_v6_3_comp.ALL;


ENTITY blkmemdp_v6_3_xst IS

  GENERIC (

    c_addra_width          : integer := 11;
    c_addrb_width          : integer := 9;
    c_default_data         : string  := "0";
    c_depth_a              : integer := 2048;
    c_depth_b              : integer := 512;
    c_enable_rlocs         : integer := 0;
      c_family               : STRING  := "virtex";     
    c_has_default_data     : integer := 1;
    c_has_dina             : integer := 1;
    c_has_dinb             : integer := 1;
    c_has_douta            : integer := 1;
    c_has_doutb            : integer := 1;
    c_has_ena              : integer := 1;
    c_has_enb              : integer := 1;
    c_has_limit_data_pitch : integer := 1;
    c_has_nda              : integer := 1;
    c_has_ndb              : integer := 1;
    c_has_rdya             : integer := 1;
    c_has_rdyb             : integer := 1;
    c_has_rfda             : integer := 1;
    c_has_rfdb             : integer := 1;
    c_has_sinita           : integer := 1;
    c_has_sinitb           : integer := 1;
    c_has_wea              : integer := 1;
    c_has_web              : integer := 1;
    c_limit_data_pitch     : integer := 16;
    c_mem_init_file        : string  := "null.mif";
    c_pipe_stages_a        : integer := 0;
    c_pipe_stages_b        : integer := 0;
    c_reg_inputsa          : integer := 1;
    c_reg_inputsb          : integer := 1;
    c_sinita_value         : string  := "0000";
    c_sinitb_value         : string  := "0000";
    c_width_a              : integer := 8;
    c_width_b              : integer := 32;
    c_write_modea          : integer := 2;
    c_write_modeb          : integer := 2;
    ------------------------------------------------------------------------
    -- new generic
    --c_xmem_init_array : MEM_ARRAY := DEFAULT_XMEM_INIT_ARRAY
    ------------------------------------------------------------------------

    ------------------------------------------------------------
    -- New Generics for Primitive Selection and Pin Polarity
    ------------------------------------------------------------
    c_ybottom_addr          : string  := "1024";
    c_yclka_is_rising       : integer := 1;
    c_yclkb_is_rising       : integer := 1;
    c_yena_is_high          : integer := 1;
    c_yenb_is_high          : integer := 1;
    c_yhierarchy            : string  := "hierarchy1";
    c_ymake_bmm             : integer := 0;
    c_yprimitive_type       : string  := "4kx4";
    c_ysinita_is_high       : integer := 1;
    c_ysinitb_is_high       : integer := 1;
    c_ytop_addr             : string  := "0";
    c_yuse_single_primitive : integer := 0;
    c_ywea_is_high          : integer := 1;
    c_yweb_is_high          : integer := 1;
    -- New generic to turn off(1) or on (0) warning messages
    c_yydisable_warnings    : integer := 1
    );

  PORT (DINA   : IN  std_logic_vector (c_width_a-1 DOWNTO 0) := (OTHERS => '0');
        DINB   : IN  std_logic_vector (c_width_b-1 DOWNTO 0) := (OTHERS => '0');
        ENA    : IN  std_logic                               := '1';
        ENB    : IN  std_logic                               := '1';
        WEA    : IN  std_logic                               := '0';
        WEB    : IN  std_logic                               := '0';
        SINITA : IN  std_logic                               := '0';
        SINITB : IN  std_logic                               := '0';
        NDA    : IN  std_logic                               := '0';
        NDB    : IN  std_logic                               := '0';
        CLKA   : IN  std_logic;
        CLKB   : IN  std_logic;
        ADDRA  : IN  std_logic_vector (c_addra_width-1 DOWNTO 0);
        ADDRB  : IN  std_logic_vector (c_addrb_width-1 DOWNTO 0);
        RDYA   : OUT std_logic;
        RDYB   : OUT std_logic;
        RFDA   : OUT std_logic;
        RFDB   : OUT std_logic;
        DOUTA  : OUT std_logic_vector (c_width_a-1 DOWNTO 0);
        DOUTB  : OUT std_logic_vector (c_width_b-1 DOWNTO 0)
        );

END blkmemdp_v6_3_xst;

-----------------------------------------------------------------------------

ARCHITECTURE xilinx OF blkmemdp_v6_3_xst IS
BEGIN

  bm : blkmemdp_v6_3
  GENERIC MAP(
    c_addra_width           => c_addra_width,
    c_addrb_width           => c_addrb_width,
    c_default_data          => c_default_data,
    c_depth_a               => c_depth_a,
    c_depth_b               => c_depth_b,
    c_enable_rlocs          => c_enable_rlocs,
    c_family                => c_family,
    c_has_default_data      => c_has_default_data,
    c_has_dina              => c_has_dina,
    c_has_dinb              => c_has_dinb,
    c_has_douta             => c_has_douta,
    c_has_doutb             => c_has_doutb,
    c_has_ena               => c_has_ena,
    c_has_enb               => c_has_enb,
    c_has_limit_data_pitch  => c_has_limit_data_pitch,
    c_has_nda               => c_has_nda,
    c_has_ndb               => c_has_ndb,
    c_has_rdya              => c_has_rdya,
    c_has_rdyb              => c_has_rdyb,
    c_has_rfda              => c_has_rfda,
    c_has_rfdb              => c_has_rfdb,
    c_has_sinita            => c_has_sinita,
    c_has_sinitb            => c_has_sinitb,
    c_has_wea               => c_has_wea,
    c_has_web               => c_has_web,
    c_limit_data_pitch      => c_limit_data_pitch,
    c_mem_init_file         => c_mem_init_file,
    c_pipe_stages_a         => c_pipe_stages_a,
    c_pipe_stages_b         => c_pipe_stages_b,
    c_reg_inputsa           => c_reg_inputsa,
    c_reg_inputsb           => c_reg_inputsb,
    c_sinita_value          => c_sinita_value,
    c_sinitb_value          => c_sinitb_value,
    c_width_a               => c_width_a,
    c_width_b               => c_width_b,
    c_write_modea           => c_write_modea,
    c_write_modeb           => c_write_modeb,
    c_ybottom_addr          => c_ybottom_addr,
    c_yclka_is_rising       => c_yclka_is_rising,
    c_yclkb_is_rising       => c_yclkb_is_rising,
    c_yena_is_high          => c_yena_is_high,
    c_yenb_is_high          => c_yenb_is_high,
    c_yhierarchy            => c_yhierarchy,
    c_ymake_bmm             => c_ymake_bmm,
    c_yprimitive_type       => c_yprimitive_type,
    c_ysinita_is_high       => c_ysinita_is_high,
    c_ysinitb_is_high       => c_ysinitb_is_high,
    c_ytop_addr             => c_ytop_addr,
    c_yuse_single_primitive => c_yuse_single_primitive,
    c_ywea_is_high          => c_ywea_is_high,
    c_yweb_is_high          => c_yweb_is_high,
    c_yydisable_warnings    => c_yydisable_warnings    
    )

  PORT MAP(
    DINA   => DINA,
    DINB   => DINB,
    ENA    => ENA,
    ENB    => ENB,
    WEA    => WEA,
    WEB    => WEB,
    SINITA => SINITA,
    SINITB => SINITB,
    NDA    => NDA,
    NDB    => NDB,
    CLKA   => CLKA,
    CLKB   => CLKB,
    ADDRA  => ADDRA,
    ADDRB  => ADDRB,
    RDYA   => RDYA,
    RDYB   => RDYB,
    RFDA   => RFDA,
    RFDB   => RFDB,
    DOUTA  => DOUTA,
    DOUTB  => DOUTB  
    );

END xilinx;

