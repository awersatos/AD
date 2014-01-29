-------------------------------------------------------------------------------
-- $Id: iputils_mem87.vhd,v 1.16 2008/09/08 20:08:59 akennedy Exp $
-------------------------------------------------------------------------------
--
-- IP Utilities Library
--
-------------------------------------------------------------------------------
--                                                                       
-- This file is owned and controlled by Xilinx and must be used solely   
-- for design, simulation, implementation and creation of design files   
-- limited to Xilinx devices or technologies. Use with non-Xilinx        
-- devices or technologies is expressly prohibited and immediately       
-- terminates your license.                                              
--                                                                       
-- Xilinx products are not intended for use in life support              
-- appliances, devices, or systems. Use in such applications is          
-- expressly prohibited.                                                 
--
--            **************************************
--            ** Copyright (C) 2000, Xilinx, Inc. **
--            ** All Rights Reserved.             **
--            **************************************
--
-----------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- iputils_mem87
---- memory features (like reading/writing to .mif files)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE iputils_mem87 IS

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
    filename : IN    STRING;
    depth    : IN    INTEGER;
    width    : IN    INTEGER;
    memvect  : OUT   STD_LOGIC_VECTOR;
    lines    : INOUT INTEGER
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
    filename : IN STRING;
    depth    : IN INTEGER;
    width    : IN INTEGER;
    memvect  : IN STD_LOGIC_VECTOR;
    lines    : IN INTEGER
    );




END iputils_mem87;




LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE BODY iputils_mem87 IS

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
    filename  : IN    STRING;
    depth     : IN    INTEGER;
    width     : IN    INTEGER;
    memvect   : OUT   STD_LOGIC_VECTOR;
    lines     : INOUT INTEGER
    ) IS
    FILE meminitfile                    :       TEXT IS filename;
    VARIABLE bit                        :       INTEGER;
    VARIABLE bitline                    :       LINE;
    VARIABLE bitchar                    :       CHARACTER;
    VARIABLE bits_good                  :       BOOLEAN;
    VARIABLE offset                     :       INTEGER;
    VARIABLE total_lines                :       INTEGER;
    VARIABLE mem_vector                 :       STRING(width DOWNTO 1);
    CONSTANT mem_bits                   :       INTEGER := depth * width;
    CONSTANT vec_bits                   :       INTEGER := memvect'LENGTH;
  BEGIN
    ASSERT mem_bits = vec_bits
      REPORT "BAD MEMORY VECTOR SIZE" SEVERITY FAILURE;
    IF(lines > 0 AND lines <= depth) THEN
      total_lines                                       := lines;
    ELSE
      total_lines                                       := depth;
    END IF;
    lines                                               := 0;
    offset                                              := 0;
    WHILE (NOT (endfile(meminitfile)) AND (lines < total_lines)) LOOP
      readline(meminitfile, bitline);
      read(bitline, mem_vector, bits_good);
      FOR bit IN 0 TO width-1 LOOP
        bitchar                                         := mem_vector(bit+1);
        IF (bitchar = '1') THEN
          memvect(offset+bit)                           := '1';
        ELSIF (bitchar = '0') THEN
          memvect(offset+bit)                           := '0';
        ELSIF (bitchar = 'X') THEN
          memvect(offset+bit)                           := 'X';
        ELSE
          memvect(offset + bit)                 := 'U';
        END IF;
      END LOOP;
      lines                                             := lines+1;
      offset                                            := offset + width;
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
    filename : IN    STRING;
    depth    : IN    INTEGER;
    width    : IN    INTEGER;
    memvect  : IN    STD_LOGIC_VECTOR;
    lines    : IN    INTEGER
    ) IS
  BEGIN
    ASSERT FALSE
      REPORT "Compiled version of MEM_INIT_FILE_PACK_V4_0 does not support MIF generation" SEVERITY NOTE;
    ASSERT FALSE
      REPORT "Try compiling the VHDL-87 only or VHDL-93 only compatable version" SEVERITY NOTE;
    ASSERT FALSE
      REPORT "See Data Sheet for details" SEVERITY NOTE;
  END write_meminit_file;




END iputils_mem87;

