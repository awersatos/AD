-----------------------------------------------------------------------------
-- $RCSfile: blkmemdp_mem_init_file_pack_v6_3.vhd,v $
-----------------------------------------------------------------------------
--
-- Mem_init_file_pack for Block Memory - VHDL Behavioral Model
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
-----------------------------------------------------------------------------
--
-- Filename: blkmemdp_mem_init_file_pack_v6_3.vhd
--
--  Description:
--   Memory Initialization File reading and writing procedures
--   VHDL-87 and VHDL-93 compatable version
--     Does not allow Memory Initialization File to be generated
--
-----------------------------------------------------------------------------

LIBRARY std;
USE std.textio.ALL;
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--  
LIBRARY XilinxCoreLib;
USE XilinxCoreLib.ul_utils.ALL;
--

-- This package contains procedures to read and write Memory Initialization
-- Files into or from a memory stored as a single STD_LOGIC_VECTOR

PACKAGE BLKMEMDP_MEM_INIT_FILE_PACK_V6_3 IS

  -- Procedure to read a MIF file and place the data in a std_logic_vector
  -- Takes parameters
  --   filename : Name of the file from which to read data
  --   depth    : Depth of memory in words
  --   width    : Width of memory in bits
  --   memvect  : Memory vector ( must be depth*width in size )
  --   lines    : Number of lines to be read from file
  --              If lines <= 0 or lines > depth then lines = depth
  --              If the file has fewer lines then only the available
  --              data is read
  PROCEDURE read_meminit_file(
                              filename: IN    STRING;
                              depth   : IN    INTEGER;
                              width   : IN    INTEGER;
                              memvect : OUT   STD_LOGIC_VECTOR;
                              lines   : INOUT INTEGER
                             );
                             
  -- Dummy procedure acting as place holder for write_meminit_data
  -- File writing cannot be carried out in a VHDL-87/VHDL-93
  -- independent manner. In order to provide an VHDL spec independent
  -- package this dummy procedure is required. File writing support
  -- is provided in the VHDL-93 and VHDL-87 dependent packages.
  -- Takes parameters
  --   filename : Name of the file to which to write data
  --   depth    : Depth of memory in words
  --   width    : Width of memory in bits
  --   memvect  : Memory vector ( must be depth*width in size )
  --   lines    : Number of lines to be written to file
  --              If lines <= 0 or lines > depth then lines = depth
  -- But only reports back that this procedure is unsupported in this
  -- VHDL spec independent package.
  PROCEDURE write_meminit_file(
                               filename: IN STRING;
                               depth   : IN INTEGER;
                               width   : IN INTEGER;
                               memvect : IN STD_LOGIC_VECTOR;
                               lines   : IN INTEGER
                              );
END BLKMEMDP_MEM_INIT_FILE_PACK_V6_3;

PACKAGE BODY BLKMEMDP_MEM_INIT_FILE_PACK_V6_3 IS

  -- Procedure to read a MIF file and place the data in a std_logic_vector
  -- Takes parameters
  --   filename : Name of the file from which to read data
  --   depth    : Depth of memory in words
  --   width    : Width of memory in bits
  --   memvect  : Memory vector ( must be depth*width in size )
  --   lines    : Number of lines to be read from file
  --              If lines <= 0 or lines > depth then lines = depth
  --              If the file has fewer lines then only the available
  --              data is read
  PROCEDURE read_meminit_file(
                              filename: IN    STRING;
                              depth   : IN    INTEGER;
                              width   : IN    INTEGER;
                              memvect : OUT   STD_LOGIC_VECTOR;
                              lines   : INOUT INTEGER
                             ) IS
    FILE     meminitfile : TEXT IS filename;
    VARIABLE bit         : INTEGER;
    VARIABLE bitline     : LINE;
    VARIABLE bitchar     : CHARACTER;
    VARIABLE bits_good   : BOOLEAN;
    VARIABLE offset      : INTEGER;
    VARIABLE total_lines : INTEGER;
    VARIABLE mem_vector  : STRING(width DOWNTO 1);
    CONSTANT mem_bits    : INTEGER := depth * width;
    CONSTANT vec_bits    : INTEGER := memvect'LENGTH;
  BEGIN
    ASSERT mem_bits = vec_bits
      REPORT "BAD MEMORY VECTOR SIZE" SEVERITY FAILURE;
    IF(lines > 0 AND lines <= depth) THEN
      total_lines := lines;
    ELSE
      total_lines := depth;
    END IF;
    lines := 0;
    offset := 0;
    WHILE (NOT (endfile(meminitfile)) AND (lines < total_lines)) LOOP
      readline(meminitfile, bitline);
      read(bitline, mem_vector, bits_good);
      FOR bit IN 0 TO width-1 LOOP
        bitchar := mem_vector(bit+1);
        IF (bitchar = '1') THEN
          memvect(offset+bit) := '1';
        ELSIF (bitchar = '0') THEN
          memvect(offset+bit) := '0';
        ELSE 
          memvect(offset+bit) := 'X';
        END IF;
      END LOOP;
      lines := lines+1;
      offset := offset + width;
    END LOOP;
  END read_meminit_file;
--
  -- Dummy procedure acting as place holder for write_meminit_data
  -- File writing cannot be carried out in a VHDL-87/VHDL-93
  -- independent manner. In order to provide an VHDL spec independent
  -- package this dummy procedure is required. File writing support
  -- is provided in the VHDL-93 and VHDL-87 dependent packages.
  -- Takes parameters
  --   filename : Name of the file to which to write data
  --   depth    : Depth of memory in words
  --   width    : Width of memory in bits
  --   memvect  : Memory vector ( must be depth*width in size )
  --   lines    : Number of lines to be written to file
  --              If lines <= 0 or lines > depth then lines = depth
  -- But only reports back that this procedure is unsupported in this
  -- VHDL spec independent package.
  PROCEDURE write_meminit_file(
                               filename: IN STRING;
                               depth   : IN INTEGER;
                               width   : IN INTEGER;
                               memvect : IN STD_LOGIC_VECTOR;
                               lines   : IN INTEGER
                              ) IS
  BEGIN
    ASSERT FALSE
      REPORT "Compiled version of BLKMEMDP_MEM_INIT_FILE_PACK_V6_3 does not support MIF generation" SEVERITY NOTE;
    ASSERT FALSE
      REPORT "Try compiling the VHDL-87 only or VHDL-93 only compatable version" SEVERITY NOTE;
    ASSERT FALSE
      REPORT "See Data Sheet for details" SEVERITY NOTE;
  END write_meminit_file;

END BLKMEMDP_MEM_INIT_FILE_PACK_V6_3;
