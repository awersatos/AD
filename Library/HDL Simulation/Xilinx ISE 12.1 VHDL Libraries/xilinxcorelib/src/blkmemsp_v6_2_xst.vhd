--------------------------------------------------------------------------------
-- $RCSfile: blkmemsp_v6_2_xst.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:48 $
--------------------------------------------------------------------------------
-- Block Memory Compiler : VHDL Behavioral Model wrapper
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
--
-- Simple wrapper for the blkmemsp_v6_2 core.
-- XST cores that instantiate this core should use this wrapper.
-- This model is only for other cores that instantiate the blkmemsp. These
-- will instantiate the blkmemsp_v6_2_xst component.
-- This file itself is not analyzed by XST. it only requires the component
-- statement package.
-- This file is for behavioral simulation and also for use by Coregen.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.blkmemsp_v6_2_comp.all ;


entity blkmemsp_v6_2_xst is

  generic (

       c_addr_width           : integer := 11 ;
       c_default_data         : string  := "eca97af001f81a864c057d76" ;
       c_depth                : integer := 1034 ;
       c_enable_rlocs         : integer := 0 ;
       c_has_default_data     : integer := 1 ;     
       c_has_din              : integer := 1 ;
       c_has_en               : integer := 1 ;
       c_family               : string  := "virtex2" ;
       c_has_limit_data_pitch : integer := 0 ;
       c_has_nd               : integer := 1 ;
       c_has_rdy              : integer := 1 ;
       c_has_rfd              : integer := 1 ;
       c_has_sinit            : integer := 1 ;
       c_has_we               : integer := 1 ;
       c_limit_data_pitch     : integer := 18 ;
       ------------------------------------------------------------------------
       -- new generics
       --c_xmem_init_array    : MEM_ARRAY := ("123456", "123456", "123456", "123456", "123456", "123456");
       c_mem_init_file        : string := "mif_file_16_1" ;
       ------------------------------------------------------------------------
       c_pipe_stages          : integer := 1 ;
       c_reg_inputs           : integer := 0 ;
       c_sinit_value          : string := "dcd461da8bac14a2d0902993" ;
       c_width                : integer  := 96 ;
       c_write_mode           : integer := 2;
       c_ybottom_addr         : STRING := "1024" ;
       c_yclk_is_rising       : INTEGER := 1;
       c_yhierarchy           : STRING  := "hierarchy" ;
       c_ymake_bmm            : INTEGER := 1;
       c_yen_is_high          : INTEGER := 1;
       c_yprimitive_type      : STRING  := "4kx4";
       c_ysinit_is_high       : INTEGER := 1;
       c_ytop_addr            : STRING := "0" ;
       c_yuse_single_primitive: INTEGER := 0;
       c_ywe_is_high          : INTEGER := 1;
       c_yydisable_warnings   : INTEGER := 0

  );

  port (DIN    : in STD_LOGIC_VECTOR (c_width-1 downto 0) := (OTHERS => '0');
        EN     : in STD_LOGIC := '1';
        WE     : in STD_LOGIC := '0';
        SINIT  : in STD_LOGIC := '0';
        ND     : in STD_LOGIC := '0';
        CLK    : in STD_LOGIC;
        RFD    : out STD_LOGIC ;
        RDY    : out STD_LOGIC ;
        ADDR   : in STD_LOGIC_VECTOR (c_addr_width-1 downto 0);
        DOUT   : out STD_LOGIC_VECTOR (c_width-1 downto 0)
       ); 

end blkmemsp_v6_2_xst;

-----------------------------------------------------------------------------

architecture xilinx of blkmemsp_v6_2_xst is
begin

  bm : blkmemsp_v6_2
  GENERIC MAP(
    c_addr_width           => c_addr_width,
    c_default_data         => c_default_data,
    c_depth                => c_depth,
    c_enable_rlocs         => c_enable_rlocs,
    c_has_default_data     => c_has_default_data,
    c_has_din              => c_has_din,
    c_has_en               => c_has_en,
    c_family               => c_family,
    c_has_limit_data_pitch => c_has_limit_data_pitch ,
    c_has_nd               => c_has_nd,
    c_has_rdy              => c_has_rdy,
    c_has_rfd              => c_has_rfd,
    c_has_sinit            => c_has_sinit,
    c_has_we               => c_has_we,
    c_limit_data_pitch     => c_limit_data_pitch,
    c_mem_init_file        => c_mem_init_file,
    c_pipe_stages          => c_pipe_stages,
    c_reg_inputs           => c_reg_inputs,
    c_sinit_value          => c_sinit_value,
    c_width                => c_width,
    c_write_mode           => c_write_mode,
    c_ybottom_addr         => c_ybottom_addr,
    c_yclk_is_rising       => c_yclk_is_rising,
    c_yhierarchy           => c_yhierarchy,
    c_ymake_bmm            => c_ymake_bmm,
    c_yen_is_high          => c_yen_is_high,
    c_yprimitive_type      => c_yprimitive_type,
    c_ysinit_is_high       => c_ysinit_is_high,
    c_ytop_addr            => c_ytop_addr,
    c_yuse_single_primitive=> c_yuse_single_primitive,
    c_ywe_is_high          => c_ywe_is_high,
    c_yydisable_warnings   => c_yydisable_warnings   
    )

  PORT MAP(
    DIN    => DIN,
    EN     => EN,
    WE     => WE,
    SINIT  => SINIT,
    ND     => ND,
    CLK    => CLK,
    RFD    => RFD,
    RDY    => RDY,
    ADDR   => ADDR,
    DOUT   => DOUT 
    ); 


end xilinx;
