-------------------------------------------------------------------------------
-- $RCSfile: cam_v5_1_comp.vhd,v $ $Revision: 1.11 $ $Date: 2008/09/08 20:07:04 $
-------------------------------------------------------------------------------
-- Content Addressable Memory
--    Component Declaration File
-------------------------------------------------------------------------------

--  Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2004 Xilinx, Inc.
--  All rights reserved.

-- Filename: cam_v5_1_comp.vhd
--
-- Description:
--   This package file contains the top-level component declaration for the CAM
--   core
--
-----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


PACKAGE cam_v5_1_comp IS



-------------------------------------------------------------------------------
-- Definition of Generics:
-------------------------------------------------------------------------------
--  c_addr_type             : Determines format of MATCH_ADDR output
--                              0 = Binary Encoded
--                              1 = Single Match Unencoded (one-hot)
--                              2 = Multi-match unencoded (shows all matches)
--  c_cmp_data_mask_width   : Width of the cmp_data_mask port
--                              (should be the same as c_width)
--  c_cmp_din_width         : Width of the cmp_din port
--                              (should be the same as c_width)
--  c_data_mask_width       : Width of the data_mask port
--                              (should be the same as c_width)
--  c_depth                 : Depth of the CAM
--                              (Must be > 2)
--  c_din_width             : Width of the din port
--                              (should be the same as c_width)
--  c_enable_rlocs          : Enable placement directives?
--                              0 = Placement disabled
--                              1 = Placement enabled
--  c_family                : Architecture (not used in behavioral model)
--  c_has_cmp_data_mask     : 1 if cmp_data_mask input port present
--  c_has_cmp_din           : 1 if cmp_din input port present
--  c_has_data_mask         : 1 if data_mask input port present
--  c_has_en                : 1 if en input port present
--  c_has_multiple_match    : 1 if multiple_match output port present
--  c_has_read_warning      : 1 if read_warning output port present
--  c_has_single_match      : 1 if single_match output port present
--  c_has_we                : 1 if we input port present
--  c_has_wr_addr           : 1 if wr_addr input port present
--  c_match_addr_width      : Width of the match_addr port
--                              log2roundup(c_depth) if c_addr_type=0
--                              c_depth if c_addr_type = 1 or 2
--  c_match_resolution_type : When c_addr_type=0 or 1, only one match can
--                              be output.
--                              0 = Output lowest matching address
--                              1 = Output highest matching address
--  c_mem_init              :   0 = Do not initialize CAM
--                              1 = Initialize CAM
--  c_mem_init_file         : Filename of .mif file for initializing CAM
--  c_mem_type              :   0 = SRL16E implementation
--                              1 = Block Memory implementation
--  c_read_cycles           : Always fixed as 1 in CAM version 3.0
--  c_reg_outputs           : For use with Block Memory ONLY.
--                              0 = Do not add extra output registers.
--                              1 = Add output registers
--  c_ternary_mode          :   0 = Binary CAM
--                              1 = Ternary CAM (can store X's)
--  c_width                 : Data Width of the CAM
--  c_wr_addr_width         : Width of wr_addr port = log2roundup(c_depth)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Ports
-------------------------------------------------------------------------------
--  CLK            : IN  : Clock
--  CMP_DATA_MASK  : IN  : Data mask for CMP_DIN port
--  CMP_DIN        : IN  : Compare port - Data input (CAM read/search operation)
--  DATA_MASK      : IN  : Data mask for DIN port
--  DIN            : IN  : Data input (CAM Write operation, and CAM read/search)
--  EN             : IN  : CAM enable (active high)
--  WE             : IN  : CAM write enable (active high)
--  WR_ADDR        : IN  : CAM write address
--  BUSY           : OUT : High state indicates that user can not start a new
--                         write operation
--  MATCH          : OUT : High state indicates one or more matches found
--  MATCH_ADDR     : OUT : Address (or addresses) of matches found (if any)
--  MULTIPLE_MATCH : OUT : High state indicates MORE than one match found 
--  READ_WARNING   : OUT : High state indicates that the match operation may
--                         have returned misleading results because the data
--                         was being modified by a simultanous write operation
--  SINGLE_MATCH   : OUT : High state indicates ONLY one match found
-------------------------------------------------------------------------------
  COMPONENT cam_v5_1
    GENERIC (
      c_addr_type             : integer := 2;
      c_cmp_data_mask_width   : integer := 4;
      c_cmp_din_width         : integer := 4;
      c_data_mask_width       : integer := 4;
      c_depth                 : integer := 16;
      c_din_width             : integer := 4;
      c_enable_rlocs          : integer := 0;
      c_family                : string  := "";
      c_has_cmp_data_mask     : integer := 0;
      c_has_cmp_din           : integer := 0;
      c_has_data_mask         : integer := 0;
      c_has_en                : integer := 0;
      c_has_multiple_match    : integer := 0;
      c_has_read_warning      : integer := 0;
      c_has_single_match      : integer := 0;
      c_has_we                : integer := 1;
      c_has_wr_addr           : integer := 1;
      c_match_addr_width      : integer := 16;
      c_match_resolution_type : integer := 0;
      c_mem_init              : integer := 0;
      c_mem_init_file         : string  := "";
      c_mem_type              : integer := 0;
      c_read_cycles           : integer := 1;
      c_reg_outputs           : integer := 0;
      c_ternary_mode          : integer := 0;
      c_width                 : integer := 1;
      c_wr_addr_width         : integer := 4
      );
    PORT (
      CLK                     : IN  std_logic;
      CMP_DATA_MASK           : IN  std_logic_vector(c_cmp_data_mask_width-1 DOWNTO 0) := (OTHERS => '0');
      CMP_DIN                 : IN  std_logic_vector(c_cmp_din_width-1 DOWNTO 0) := (OTHERS => '0');
      DATA_MASK               : IN  std_logic_vector(c_data_mask_width-1 DOWNTO 0) := (OTHERS => '0');
      DIN                     : IN  std_logic_vector(c_din_width-1 DOWNTO 0) := (OTHERS => '0');
      EN                      : IN  std_logic := '0';
      WE                      : IN  std_logic := '0';
      WR_ADDR                 : IN  std_logic_vector(c_wr_addr_width-1 DOWNTO 0) := (OTHERS => '0');
      BUSY                    : OUT std_logic;
      MATCH                   : OUT std_logic;
      MATCH_ADDR              : OUT std_logic_vector(c_match_addr_width-1 DOWNTO 0);
      MULTIPLE_MATCH          : OUT std_logic;
      READ_WARNING            : OUT std_logic;
      SINGLE_MATCH            : OUT std_logic
      );
  END COMPONENT;

  


END cam_v5_1_comp;

