-------------------------------------------------------------------------------
--  $RCSfile: cam_v5_1.vhd,v $ $Revision: 1.11 $ $Date: 2008/09/08 20:07:04 $
-------------------------------------------------------------------------------
--
-- Content Addressable Memory - VHDL Behavioral Model
--
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

-------------------------------------------------------------------------------
--
-- Filename: cam_v5_1.vhd
--
-- Description: 
--  The behavioral model for the Content Addressable Memory core.
--                      
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--
-- Content Addressable Memory - VHDL Behavioral Model Utilities Package
--
-------------------------------------------------------------------------------




-------------------------------------------------------------------------------
-- Library Declarations
-------------------------------------------------------------------------------
LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;

--Use int_2_std_logic_vector and std_logic_vector_2_posint from iputils_conv
USE XilinxCoreLib.iputils_conv.ALL;

--Use log2roundup, get_min, div4roundup from iputils_math
USE XilinxCoreLib.iputils_math.ALL;


PACKAGE cam_v5_1_pkg IS

  -------------------------------------------------------------------------------
  -- Contant Declarations
  -------------------------------------------------------------------------------

  CONSTANT const_srl_mem   : integer := 0;  --Constant for c_mem_type= SRL16
  CONSTANT const_block_mem : integer := 1;  --Constant for c_mem_type= Block Memory
  CONSTANT const_dist_mem  : integer := 2;  --Constant for c_mem_type= Distributed Memory

  CONSTANT const_bin_encoded  : integer := 0;  --Constant for c_addr_type= Binary Encoded
  CONSTANT const_sm_unencoded : integer := 1;  --Constant for c_addr_type= Single-Match Unencoded
  CONSTANT const_mm_unencoded : integer := 2;  --Constant for c_addr_type= Multiple-Match Unencoded

  CONSTANT const_lowest_match  : integer := 0;  --Constant for c_resolution_type= Lowest Match
  CONSTANT const_highest_match : integer := 1;  --Constant for c_resolution_type= Highest Match

  CONSTANT const_ternary_off : integer := 0;  -- Constant for c_ternary_mode = None
  CONSTANT const_ternary_std : integer := 1;  -- Constant for c_ternary_mode = Standard
  CONSTANT const_ternary_enh : integer := 2;  -- Constant for c_ternary_mode = Enhanced

   
  CONSTANT one  : std_logic := '1';
  CONSTANT zero : std_logic := '0';


  -------------------------------------------------------------------------------
  -- FUNCTION DECLARATION
  -------------------------------------------------------------------------------

  FUNCTION ternary_value (mask : std_logic_vector; data : std_logic_vector; ternary_mode : integer) RETURN std_logic_vector;

  FUNCTION ternary_compare (maska : std_logic_vector; dataa : std_logic_vector; maskb : std_logic_vector; datab : std_logic_vector) RETURN boolean;

  FUNCTION ternary_compare_xy (maska : std_logic_vector; dataa : std_logic_vector; maskb : std_logic_vector; datab : std_logic_vector) RETURN boolean;

  FUNCTION ternary_compareX (dataa : std_logic_vector; datab : std_logic_vector) RETURN boolean;


END cam_v5_1_pkg;


PACKAGE BODY cam_v5_1_pkg IS

  -------------------------------------------------------------------------------
  -- Function Declarations
  -------------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- FUNCTION:  ternary_value
  --
  -- DESCRIPTION: 
  --   This function converts a mask and data vector into a single
  --   std_logic_vector using 1's 0's and X's.
  --
  -- INPUTS:
  --    mask : mask for data, if bit is '1', bit is considered an 'X'
  --    data : data
  --
  -- OUTPUT:
  --    the data and mask combined into a single std_logic_vector, where
  --    any bit masked out is assigned the value 'X'.
  -----------------------------------------------------------------------------
  FUNCTION ternary_value (mask : std_logic_vector; data : std_logic_vector; ternary_mode : integer) RETURN std_logic_vector IS
    VARIABLE retval            : std_logic_vector(data'high DOWNTO data'low) := (OTHERS => '0');
  BEGIN
    IF ternary_mode = const_ternary_std THEN
      FOR i IN data'low TO data'high LOOP
        IF i <= mask'high AND i >= mask'low AND mask(i) = '1' THEN
          retval(i)                                                            := 'X';
        ELSE
          retval(i)                                                            := data(i);
        END IF;
      END LOOP;  -- i
    ELSE
      FOR i IN data'low TO data'high LOOP
        IF i <= mask'high AND i >= mask'low AND mask(i) = '1' AND data(i) = '1' THEN
          retval(i)                                                            := 'U';
        ELSIF i <= mask'high AND i >= mask'low AND mask(i) = '1' AND data(i) = '0' THEN
          retval(i) := '0';
        ELSIF i <= mask'high AND i >= mask'low AND mask(i) = '0' AND data(i) = '0' THEN
          retval(i) := 'X';
        ELSE
          retval(i)                                                            := data(i);
        END IF;
      END LOOP;  -- i    
      
    END IF;
    RETURN retval;
  END ternary_value;



  -----------------------------------------------------------------------------
  -- FUNCTION:  ternary_compare
  --
  -- DESCRIPTION: 
  -- This function compares two ternary values which are described using
  -- a combination of mask and data. When the mask bit = '1', the bit
  -- is considered an X, and will match either a 0 or a 1 bit.
  --
  -- INPUTS:
  --    maska = mask for dataa, a bit of '1' indicates an 'X' value
  --    dataa = first data input
  --    maskb = mask for datab, a bit of '1' indicates an 'X' value
  --    datab = second data input
  --
  -- OUTPUT:
  --    TRUE if A matches B. X's (mask 1's) are considered "don't cares".
  --    FALSE otherwise.
  -----------------------------------------------------------------------------
  FUNCTION ternary_compare (maska : std_logic_vector; dataa : std_logic_vector; maskb : std_logic_vector; datab : std_logic_vector) RETURN boolean IS
    VARIABLE equal                : boolean := true;
                                        -- vectors are considered equal until proven otherwise
  BEGIN
    FOR i IN dataa'low TO dataa'high LOOP
      IF (i >= datab'low AND i <= datab'high) THEN
        IF dataa(i) = 'U' OR datab(i) = 'U' THEN
          equal                             := false;
        END IF;
        IF maska(i) = '0' AND maskb(i) = '0' THEN
          IF dataa(i) = '1' AND datab(i) = '0' THEN
            equal                           := false;
          END IF;
          IF dataa(i) = '0' AND datab(i) = '1' THEN
            equal                           := false;
          END IF;
        END IF;


        --ternary_match_vector(i) := NOT (maska(i) OR maskb(i)) AND (dataa(i) XOR datab(i));
      END IF;
    END LOOP;  -- i

    RETURN equal;
  END ternary_compare;

  FUNCTION ternary_compare_xy (maska : std_logic_vector; dataa : std_logic_vector; maskb : std_logic_vector; datab : std_logic_vector) RETURN boolean IS
    VARIABLE equal                : boolean := true;
                                        -- vectors are considered equal until proven otherwise
  BEGIN
    FOR i IN dataa'low TO dataa'high LOOP
      IF (i >= datab'low AND i <= datab'high) THEN
        IF dataa(i) = 'U' OR datab(i) = 'U' THEN
          equal                             := false;
        END IF;
        IF maska(i) = '1' OR maskb(i) = '1' THEN
          IF dataa(i) = '1' OR datab(i) = '1' THEN
            equal := false;
          END IF;
        END IF;
      END IF;
    END LOOP;  -- i

    RETURN equal;
  END ternary_compare_xy;

  -----------------------------------------------------------------------------
  -- FUNCTION:  ternary_compareX
  --
  -- DESCRIPTION: 
  -- This function compares two std_logic_vectors which can include X's.
  -- Here, an X is considered to match both 1 and 0.
  -- A U matches nothing.
  --
  -- INPUTS:
  --    dataa = first data input (can include X's)
  --    datab = second data input (can include X's)
  --
  -- OUTPUT:
  --    TRUE if A matches B. X's are considered "don't cares".
  --    FALSE otherwise.
  -----------------------------------------------------------------------------
  FUNCTION ternary_compareX (dataa : std_logic_vector; datab : std_logic_vector)
    RETURN boolean IS
    VARIABLE equal                 : boolean := true;
  BEGIN
    FOR i IN dataa'low TO dataa'high LOOP
      IF (i >= datab'low AND i <= datab'high) THEN
        IF dataa(i) = 'U' OR datab(i) = 'U' THEN
          equal                              := false;
        END IF;
        IF dataa(i) = '1' AND datab(i) = '0' THEN
          equal                              := false;
        END IF;
        IF dataa(i) = '0' AND datab(i) = '1' THEN
          equal                              := false;
        END IF;
      END IF;
    END LOOP;  --i

    RETURN equal;
  END ternary_compareX;



END cam_v5_1_pkg;





-------------------------------------------------------------------------------
--
-- Content Addressable Memory - VHDL Behavioral Model
--
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Library Declarations
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.cam_v5_1_pkg.ALL;

--Use std_logic_vector_2_int, two_comp, int_2_std_logic_vector, rat, and
-- std_logic_vector_2_posint from iputils_conv
USE XilinxCoreLib.iputils_conv.ALL;

--Use log2roundup, get_min, and div4roundup from iputils_math
USE XilinxCoreLib.iputils_math.ALL;

--Use read_meminit_file from iputils_mem87
USE XilinxCoreLib.iputils_mem87.ALL;

--Use SLV_binary_encoder, one_hot, set_bit, SLV_binary_encoder_of_width,
-- and binary_compare from iputils_slv
USE XilinxCoreLib.iputils_slv.ALL;

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
ENTITY cam_v5_1 IS
  GENERIC (
    c_addr_type             :     integer   := 2;
    c_cmp_data_mask_width   :     integer   := 4;
    c_cmp_din_width         :     integer   := 4;
    c_data_mask_width       :     integer   := 4;
    c_depth                 :     integer   := 16;
    c_din_width             :     integer   := 4;
    c_enable_rlocs          :     integer   := 0;
    c_family                :     string    := "";
    c_has_cmp_data_mask     :     integer   := 0;
    c_has_cmp_din           :     integer   := 0;
    c_has_data_mask         :     integer   := 0;
    c_has_en                :     integer   := 0;
    c_has_multiple_match    :     integer   := 0;
    c_has_read_warning      :     integer   := 0;
    c_has_single_match      :     integer   := 0;
    c_has_we                :     integer   := 1;
    c_has_wr_addr           :     integer   := 1;
    c_match_addr_width      :     integer   := 16;
    c_match_resolution_type :     integer   := 0;
    c_mem_init              :     integer   := 0;
    c_mem_init_file         :     string    := "";
    c_mem_type              :     integer   := 0;
    c_read_cycles           :     integer   := 1;
    c_reg_outputs           :     integer   := 0;
    c_ternary_mode          :     integer   := 0;
    c_width                 :     integer   := 1;
    c_wr_addr_width         :     integer   := 4
    );
  PORT (
    CLK                     : IN  std_logic := '0';
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
END cam_v5_1;


-------------------------------------------------------------------------------
-- Architecture Heading
-------------------------------------------------------------------------------
ARCHITECTURE behavioral OF cam_v5_1 IS


  ------internal signals for each port  -------------------------------------------
  SIGNAL rd_din           : std_logic_vector(c_width-1 DOWNTO 0)            := (OTHERS => '0');
  SIGNAL rd_data_mask     : std_logic_vector(c_width-1 DOWNTO 0)            := (OTHERS => '0');
  SIGNAL data_mask_i      : std_logic_vector(c_width-1 DOWNTO 0)            := (OTHERS => '0');
  SIGNAL din_i            : std_logic_vector(c_width-1 DOWNTO 0)            := (OTHERS => '0');
  SIGNAL en_i             : std_logic                                       := '0';
  SIGNAL we_i             : std_logic                                       := '0';
  SIGNAL wr_addr_i        : std_logic_vector(c_wr_addr_width-1 DOWNTO 0)    := (OTHERS => '0');
  SIGNAL busy_i           : std_logic                                       := '0';
  SIGNAL match_i          : std_logic                                       := '0';
  SIGNAL match_addr_i     : std_logic_vector(c_match_addr_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL multiple_match_i : std_logic                                       := '0';
  SIGNAL read_warning_i   : std_logic                                       := '0';
  SIGNAL single_match_i   : std_logic                                       := '0';

  -------registered copies of inputs    ----------------------------------------
  SIGNAL data_mask_q    : std_logic_vector(c_width-1 DOWNTO 0)         := (OTHERS => '0');
  SIGNAL din_q          : std_logic_vector(c_width-1 DOWNTO 0)         := (OTHERS => '0');
  SIGNAL wr_addr_q      : std_logic_vector(c_wr_addr_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL wr_data_mask_q : std_logic_vector(c_width-1 DOWNTO 0)         := (OTHERS => '0');
  SIGNAL wr_din_q       : std_logic_vector(c_width-1 DOWNTO 0)         := (OTHERS => '0');

  -------registered versions of output ports for block memory  --------------------
  SIGNAL match_q          : std_logic                                       := '0';
  SIGNAL match_addr_q     : std_logic_vector(c_match_addr_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL multiple_match_q : std_logic                                       := '0';
  SIGNAL read_warning_q   : std_logic                                       := '0';
  SIGNAL single_match_q   : std_logic                                       := '0';


  -------internal signals, not connected to ports  --------------------------------
  SIGNAL wr_addr_int   : std_logic_vector(c_wr_addr_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL wr_din        : std_logic_vector(c_width-1 DOWNTO 0)         := (OTHERS => '0');
  SIGNAL wr_data_mask  : std_logic_vector(c_width-1 DOWNTO 0)         := (OTHERS => '0');
  SIGNAL write_counter : integer                                      := 0;
  SIGNAL wren          : std_logic                                    := '0';

  -------States for the CAM's internal state machine---------------------------
  CONSTANT READ_MODE            : integer := 1;
  CONSTANT START_WRITE_MODE     : integer := 2;
  CONSTANT END_BLK_WR_MODE      : integer := 3;
  CONSTANT BUSY_SRL_WR_MODE     : integer := 4;
  CONSTANT NEAR_SRL_END_WR_MODE : integer := 5;
  CONSTANT END_SRL_WR_MODE      : integer := 6;
  SIGNAL CAM_MODE : integer := READ_MODE;  --Current state


  -------Temporary signals used in the match process  -------------------------
  SIGNAL m_match_addr_i : std_logic_vector(c_depth-1 DOWNTO 0) := (OTHERS => '0');

  -------Data type for internal cam data storage  -----------------------------
  TYPE cam_data_type IS ARRAY (0 TO c_depth-1) OF std_logic_vector(c_width-1 DOWNTO 0);



-----------------------------------------------------------------------------
  -- FUNCTION:  init_cam_data
  --
  -- DESCRIPTION: 
  -- This function returns the cam_data, read-in from the .mif file,
  -- which is in the format required by the cam_data_type data type.
  --
  -- INPUTS:
  --    function implicity refers to c_mem_init_file, c_depth, and c_width
  --    
  -- OUTPUT:
  --    large array of std_logic_vectors which contains the entire contents
  --    read from the .mif file
  -----------------------------------------------------------------------------
  FUNCTION init_cam_data RETURN cam_data_type IS
    VARIABLE tmp_cam_data  : cam_data_type                                := (OTHERS => (OTHERS => 'U'));
    VARIABLE mem_init_data : std_logic_vector(c_depth*c_width-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE lines         : integer                                      := 0;
  BEGIN
    IF c_mem_init = 1 THEN
      read_meminit_file(c_mem_init_file, c_depth, c_width, mem_init_data, lines);

      FOR i IN 0 TO c_depth-1 LOOP
        tmp_cam_data(i) := mem_init_data((i+1)*c_width-1 DOWNTO i*c_width);
      END LOOP;  -- i
    END IF;


    RETURN tmp_cam_data;
  END init_cam_data;



  ------ Initialize the cam data       ----------------------------------------
  SIGNAL cam_data : cam_data_type := init_cam_data;




  
-------------------------------------------------------------------------------
-- Begin the architecture
-------------------------------------------------------------------------------
BEGIN


  -----------------------------------------------------------------------------
  -- Mandatory Pins
  -----------------------------------------------------------------------------

  --Data input bus
  din_i <= din;

  --Busy Flag
  busy <= busy_i;

  --Write Enable
  gen_we: IF c_has_we/=0 GENERATE
    we_i <= we;
  END GENERATE gen_we;
  nogen_we: IF c_has_we=0 GENERATE
    we_i <= '0';
  END GENERATE nogen_we;

  --Write Address
  gen_wr_addr: IF c_has_wr_addr/=0 GENERATE
    wr_addr_i <= wr_addr;
  END GENERATE gen_wr_addr;
  nogen_wr_addr: IF c_has_wr_addr=0 GENERATE
    wr_addr_i <= (OTHERS => '0');
  END GENERATE nogen_wr_addr;

  --Match flag
  reg_match    : IF c_reg_outputs = 1 GENERATE
    match <= match_q;
  END GENERATE reg_match;
  no_reg_match : IF c_reg_outputs = 0 GENERATE
    match <= match_i;
  END GENERATE no_reg_match;

  --Address of match
  reg_match_addr    : IF c_reg_outputs = 1 GENERATE
    match_addr <= match_addr_q;
  END GENERATE reg_match_addr;
  no_reg_match_addr : IF c_reg_outputs = 0 GENERATE
    match_addr <= match_addr_i;
  END GENERATE no_reg_match_addr;

  -------------------------------------------------------------------------------
  -- Optional Pins
  -------------------------------------------------------------------------------

  --Data Mask
  gen_data_mask   : IF c_has_data_mask = 1 GENERATE
    data_mask_i <= data_mask;
  END GENERATE gen_data_mask;
  nogen_data_mask : IF c_has_data_mask = 0 GENERATE
    data_mask_i <= (OTHERS => '0');
  END GENERATE nogen_data_mask;

  --Compare port
  gen_cmp_din   : IF c_has_cmp_din = 1 GENERATE
    rd_din <= cmp_din;
  END GENERATE gen_cmp_din;
  nogen_cmp_din : IF c_has_cmp_din = 0 GENERATE
    rd_din <= din;
  END GENERATE nogen_cmp_din;

  --Compare port Data Mask
  gen_cmp_data_mask : IF c_has_cmp_data_mask = 1 GENERATE
    rd_data_mask  <= cmp_data_mask; 
  END GENERATE gen_cmp_data_mask;
  gen_cmp_data_mask1 : IF c_has_cmp_data_mask = 0 GENERATE
    gen_cmp_data_mask2 : IF c_has_data_mask = 1 GENERATE
      rd_data_mask <= data_mask;
    END GENERATE gen_cmp_data_mask2;
    no_gen_cmp_data_mask : IF c_has_data_mask = 0 GENERATE
      rd_data_mask <= (OTHERS => '0');
    END GENERATE no_gen_cmp_data_mask;
  END GENERATE gen_cmp_data_mask1;
  

  --Core Enable
  gen_en   : IF c_has_en = 1 GENERATE
    en_i <= en;
  END GENERATE gen_en;
  nogen_en : IF c_has_en/=1 GENERATE
    en_i <= '1';
  END GENERATE nogen_en;

  --Multiple Match Flag
  gen_multiple_match      : IF c_has_multiple_match = 1 GENERATE
    reg_multiple_match    : IF c_reg_outputs = 1 GENERATE
      multiple_match <= multiple_match_q;
    END GENERATE reg_multiple_match;
    no_reg_multiple_match : IF c_reg_outputs = 0 GENERATE
      multiple_match <= multiple_match_i;
    END GENERATE no_reg_multiple_match;
  END GENERATE gen_multiple_match;

  --Read Error Flag
  gen_read_warning      : IF c_has_read_warning = 1 GENERATE
    reg_read_warning    : IF c_reg_outputs = 1 GENERATE
      read_warning <= read_warning_q;
    END GENERATE reg_read_warning;
    no_reg_read_warning : IF c_reg_outputs = 0 GENERATE
      read_warning <= read_warning_i;
    END GENERATE no_reg_read_warning;
  END GENERATE gen_read_warning;

  --Single Match Flag
  gen_single_match      : IF c_has_single_match = 1 GENERATE
    reg_single_match    : IF c_reg_outputs = 1 GENERATE
      single_match <= single_match_q;
    END GENERATE reg_single_match;
    no_reg_single_match : IF c_reg_outputs = 0 GENERATE
      single_match <= single_match_i;
    END GENERATE no_reg_single_match;
  END GENERATE gen_single_match;


  -------------------------------------------------------------------------------
  -- Registered Outputs (only for block memory)
  -------------------------------------------------------------------------------
  gen_reg_outputs    : IF c_reg_outputs = 1 GENERATE
    proc_reg_outputs : PROCESS (CLK)
    BEGIN  -- PROCESS proc_reg_outputs
      IF (CLK'event AND CLK'last_value = '0' AND CLK = '1' AND en_i = '1') THEN
        match_q          <= match_i;
        match_addr_q     <= match_addr_i;
        multiple_match_q <= multiple_match_i;
        read_warning_q   <= read_warning_i;
        single_match_q   <= single_match_i;
      END IF;
    END PROCESS proc_reg_outputs;

  END GENERATE gen_reg_outputs;




  -----------------------------------------------------------------------------
  -- PROCESS:   mode_proc
  --
  -- DESCRIPTION:
  --  This process determines the current state of the CAM.
  --  It implements a mealy state machine. On the rising edge of the clock, this
  --  process determines the next state based on the current state and any
  --  relevant inputs (we_i, write_counter, or c_mem_type).
  -- 
  -----------------------------------------------------------------------------
  mode_proc : PROCESS (CLK)
  BEGIN  -- PROCESS mode_proc
    IF (CLK'event AND CLK'last_value = '0' AND CLK = '1' AND en_i = '1') THEN
      CASE CAM_MODE IS
        WHEN READ_MODE =>
          IF we_i = '0' THEN
            CAM_MODE <= READ_MODE;
          ELSE  --we_i=1
            CAM_MODE <= START_WRITE_MODE;
          END IF;

        WHEN START_WRITE_MODE =>
          IF c_mem_type = const_block_mem THEN
            CAM_MODE <= END_BLK_WR_MODE;
          ELSE  --c_mem_type = srl16
            CAM_MODE <= BUSY_SRL_WR_MODE;
          END IF;

        WHEN END_BLK_WR_MODE =>
          IF we_i = '0' THEN
            CAM_MODE <= READ_MODE;
          ELSE  --we_i=1
            CAM_MODE <= START_WRITE_MODE;
          END IF;

        WHEN BUSY_SRL_WR_MODE =>
          IF write_counter < 14 THEN
            CAM_MODE <= BUSY_SRL_WR_MODE;
          ELSE  --write_counter >= 14
            CAM_MODE <= NEAR_SRL_END_WR_MODE;
          END IF;

        WHEN NEAR_SRL_END_WR_MODE =>
          CAM_MODE <= END_SRL_WR_MODE;

        WHEN END_SRL_WR_MODE =>
          IF we_i = '0' THEN
            CAM_MODE <= READ_MODE;
          ELSE  --we_i=1
            CAM_MODE <= START_WRITE_MODE;
          END IF;

        WHEN OTHERS => CAM_MODE <= READ_MODE;
      END CASE;
    END IF;
  END PROCESS mode_proc;



  -----------------------------------------------------------------------------
  -- PROCESS:   match_proc
  --
  -- DESCRIPTION:
  --  This process provides the logic used to determine if there is a match,
  --  how many matches are present, and the ideal state of the various output
  --  signals associated with the match logic.
  --  (Note: these outputs might be overridden under certain conditions)
  --
  -- NOTES:
  --  On the rising clock edge, the m_ (match_) internal signals are calculated.
  --  These m_ signals are later connected to the appropriate outputs.
  -----------------------------------------------------------------------------
  match_proc                    : PROCESS (CLK)
    VARIABLE m_matches          : integer                              := 0;
    VARIABLE i                  : integer                              := 0;
    VARIABLE tmp_m_match_addr_i : std_logic_vector(c_depth-1 DOWNTO 0) := (OTHERS => '0');


    VARIABLE j : integer := 0;

  BEGIN  -- PROCESS match_proc
    IF (CLK'event AND CLK'last_value = '0' AND CLK = '1' AND en_i = '1') THEN
      --set defaults
      tmp_m_match_addr_i := (OTHERS => '0');
      single_match_i   <= '0';
      multiple_match_i <= '0';
      match_i          <= '0';
      m_matches          := 0;

      FOR i IN 0 TO c_depth-1 LOOP

        IF c_match_resolution_type = const_highest_match THEN
          --loop the other way if resolution_type changes
          j := c_depth-1-i;
        ELSE
          j := i;
        END IF;

        --determine if a match for the data is found in location i (either
        --direct match, or a ternary match)
        IF
          (c_ternary_mode = const_ternary_off AND binary_compare(rd_din, cam_data(j))) OR
          (c_ternary_mode /= const_ternary_off AND 
           ternary_compareX(ternary_value(rd_data_mask, rd_din, c_ternary_mode), cam_data(j)))
        THEN

          --If during a write, we are reading and writing to the same address
          IF j = std_logic_vector_2_posint(wr_addr_int) AND wren = '1' THEN

            --Then do nothing (don't count this match)

          ELSE
            
            --Otherwise, count the match

            -----------------------------------------------------------------
            -- Calculate once for Read
            -----------------------------------------------------------------
            
            --if one or more matches have already been found,
            -- update signals to reflect multiple matches
            IF m_matches > 0 THEN
              single_match_i   <= '0';
              multiple_match_i <= '1';
              match_i          <= '1';
              IF c_addr_type = const_mm_unencoded THEN
                tmp_m_match_addr_i := set_bit(j, tmp_m_match_addr_i);
              END IF;
            END IF;

            --if no matches have been found yet, then update signals to
            -- reflect a single match
            IF m_matches = 0 THEN
              single_match_i   <= '1';
              multiple_match_i <= '0';
              match_i          <= '1';
              tmp_m_match_addr_i := one_hot(int_2_std_logic_vector(j, c_depth), c_depth);
              m_matches          := m_matches + 1;
            END IF;
          END IF;
        END IF;
      END LOOP;  -- i

      m_match_addr_i <= tmp_m_match_addr_i;


    END IF;
  END PROCESS match_proc;



  -------------------------------------------------------------------------------
  -- Match Output
  -------------------------------------------------------------------------------
  -- Set the match outputs appropriately.       
  -------------------------------------------------------------------------------
  match_addr_i <= SLV_binary_encoder_of_width(m_match_addr_i, c_match_addr_width) WHEN c_addr_type = const_bin_encoded ELSE m_match_addr_i;



  -------------------------------------------------------------------------------
  -- Input Storage
  -------------------------------------------------------------------------------
  --    The internal write values (wr_data_mask and wr_din) are set asynchronously
  --  when din_i and data_mask_i changes, but once a write operation starts, 
  --  they are connected to their registered values, to hold the data valid until
  --  the write operation is complete.
  -------------------------------------------------------------------------------
  wr_data_mask <= data_mask_i WHEN (we_i = '1' AND busy_i = '0') ELSE data_mask_q;
  wr_din       <= din_i       WHEN (we_i = '1' AND busy_i = '0') ELSE din_q;
  wr_addr_int  <= wr_addr_i   WHEN (we_i = '1' AND busy_i = '0') ELSE wr_addr_q;
  wren         <= we_i OR busy_i;

  -----------------------------------------------------------------------------
  -- PROCESS:   proc_inputs
  --
  -- DESCRIPTION:
  --    Register the input values to hold them during processing.
  -----------------------------------------------------------------------------
  proc_inputs : PROCESS (CLK)
  BEGIN  -- PROCESS proc_inputs
    IF CLK'event AND CLK = '1' AND en_i = '1' AND we_i = '1' AND busy_i = '0' THEN
      data_mask_q <= data_mask_i;
      din_q       <= din_i;
      wr_addr_q   <= wr_addr_i;
    END IF;
  END PROCESS proc_inputs;




  -----------------------------------------------------------------------------
  -- PROCESS:   main
  --
  -- DESCRIPTION:
  --  This process, on the rising edge of the clock, uses a case statement
  --  to identify the current state.
  --  In these blocks, the outputs for that CAM state are calculated.
  --  This implements a MEALY machine, where the outputs are set on each
  --  state transition according to the current state and the inputs.
  -----------------------------------------------------------------------------
  main               : PROCESS (CLK)
    VARIABLE matches : integer := 0;
    VARIABLE i       : integer := 0;

  BEGIN  -- PROCESS main
    IF (CLK'event AND CLK'last_value = '0' AND CLK = '1' AND en_i = '1') THEN

      CASE CAM_MODE IS

        ---------------------------------------------------------------------
        -- READ MODE - CAM's normal state, searching for matches
        ---------------------------------------------------------------------
        WHEN READ_MODE =>
          IF we_i = '0' THEN
            -- IF continuing to read
            busy_i           <= '0';
            read_warning_i   <= '0';
            write_counter    <= 0;
          ELSE
            -- ELSE starting a write
            IF
              (c_ternary_mode = const_ternary_off AND binary_compare(wr_din, rd_din)) OR
              (c_ternary_mode = const_ternary_std
               AND ternary_compare(wr_data_mask, wr_din, rd_data_mask, rd_din)) OR
              (c_ternary_mode = const_ternary_enh
               AND ternary_compare_xy(wr_data_mask, wr_din, rd_data_mask, rd_din))
            THEN
              --IF read and write data match, flag a read warning
              read_warning_i <= '1';
            ELSE
              read_warning_i <= '0';
            END IF;
            busy_i           <= '1';    --Set busy while writing
            write_counter    <= write_counter+1;  --Start counting the clock
                                                  --cycles for the write
          END IF;


        ---------------------------------------------------------------------
        -- START WRITE MODE - A write operation has been initiated
        ---------------------------------------------------------------------
        WHEN START_WRITE_MODE =>
          IF c_mem_type = const_block_mem THEN
            -- IF block memory implementation
            busy_i           <= '0';
            write_counter    <= write_counter+1;
            IF
              (
              (c_ternary_mode = const_ternary_off AND binary_compare(wr_din, rd_din)) OR
              (c_ternary_mode = const_ternary_std
               AND ternary_compare(wr_data_mask, wr_din, rd_data_mask, rd_din)) OR
              (c_ternary_mode = const_ternary_enh
               AND ternary_compare_xy(wr_data_mask, wr_din, rd_data_mask, rd_din))
              )
            THEN
              --IF read and write data match, flag a read warning
              read_warning_i <= '1';
            ELSE
              read_warning_i <= '0';
            END IF;

            -- Update the contents of the CAM with the value being written
            IF c_ternary_mode /= const_ternary_off THEN
              cam_data(std_logic_vector_2_posint(wr_addr_int)) <= ternary_value(wr_data_mask, wr_din, c_ternary_mode);
            ELSE
              cam_data(std_logic_vector_2_posint(wr_addr_int)) <= wr_din;
            END IF;

          ELSE
            -- ELSE srl16 implementation
            IF
              (c_ternary_mode = const_ternary_off AND binary_compare(wr_din, rd_din)) OR
              (c_ternary_mode = const_ternary_std
               AND ternary_compare(wr_data_mask, wr_din, rd_data_mask, rd_din)) OR
              (c_ternary_mode = const_ternary_enh
               AND ternary_compare_xy(wr_data_mask, wr_din, rd_data_mask, rd_din))
            THEN
              --IF read and write data match, flag a read warning
              read_warning_i <= '1';
            ELSE
              read_warning_i <= '0';
            END IF;
            busy_i           <= '1'; --Set busy while writing
            write_counter    <= write_counter+1;  -- Count clock cyles for the
                                                  -- write
          END IF;


        ---------------------------------------------------------------------
        -- END BLK WR MODE - Last cycle of a block-memory write operation
        ---------------------------------------------------------------------
        WHEN END_BLK_WR_MODE =>
          IF we_i = '0' THEN
            -- IF ending the write operation and going into read_mode
            busy_i           <= '0';
            read_warning_i   <= '0';
            write_counter    <= 0;
            
          ELSE
            -- ELSE starting another write operation immediately
            IF
              (c_ternary_mode = const_ternary_off AND binary_compare(wr_din, rd_din)) OR
              (c_ternary_mode = const_ternary_std
               AND ternary_compare(wr_data_mask, wr_din, rd_data_mask, rd_din)) OR
              (c_ternary_mode = const_ternary_enh
               AND ternary_compare_xy(wr_data_mask, wr_din, rd_data_mask, rd_din))
            THEN
              --IF read and write data match, flag a read warning
              read_warning_i <= '1';
            ELSE
              read_warning_i <= '0';
            END IF;
            busy_i           <= '1'; --Set busy while writing 
            write_counter    <= 1;
          END IF;


        ---------------------------------------------------------------------
        -- BUSY_SRL_WR_MODE - Middle of a SRL16 write operation
        ---------------------------------------------------------------------
        WHEN BUSY_SRL_WR_MODE =>
          IF
            (c_ternary_mode = const_ternary_off AND binary_compare(wr_din, rd_din)) OR
            (c_ternary_mode = const_ternary_std
             AND ternary_compare(wr_data_mask, wr_din, rd_data_mask, rd_din)) OR
            (c_ternary_mode = const_ternary_enh
             AND ternary_compare_xy(wr_data_mask, wr_din, rd_data_mask, rd_din) )
          THEN
             --IF read and write data match, flag a read warning
            read_warning_i <= '1';
          ELSE
            read_warning_i <= '0';
          END IF;
          busy_i           <= '1'; --Set busy while writing
          write_counter    <= write_counter+1;    -- Count clock cyles for the
                                                  -- write


        ---------------------------------------------------------------------
        -- NEAR_SRL_END_WR_MODE - Next-to-last clock cycle for an SRL16 write
        ---------------------------------------------------------------------
        WHEN NEAR_SRL_END_WR_MODE =>
          IF
            (c_ternary_mode = const_ternary_off AND binary_compare(wr_din, rd_din)) OR
            (c_ternary_mode = const_ternary_std
             AND ternary_compare(wr_data_mask, wr_din, rd_data_mask, rd_din)) OR
            (c_ternary_mode = const_ternary_enh
             AND ternary_compare_xy(wr_data_mask, wr_din, rd_data_mask, rd_din))
          THEN
            --IF read and write data match, flag a read warning
            read_warning_i                                   <= '1';
          ELSE
            read_warning_i                                   <= '0';
          END IF;
          busy_i                                             <= '0';
          write_counter                                      <= write_counter+1;
          -- Update the contents of the CAM with the value being written
          IF c_ternary_mode /= const_ternary_off THEN
            cam_data(std_logic_vector_2_posint(wr_addr_int)) <= ternary_value(wr_data_mask, wr_din, c_ternary_mode);
          ELSE
            cam_data(std_logic_vector_2_posint(wr_addr_int)) <= wr_din;
          END IF;



        ---------------------------------------------------------------------
        -- END_SRL_WR_MODE - Last cycle of a SRL16 write operation
        ---------------------------------------------------------------------
        WHEN END_SRL_WR_MODE =>
          IF we_i = '0' THEN
            -- IF ending the write operation and going into read_mode
            busy_i           <= '0';
            read_warning_i   <= '0';
            write_counter    <= 0;
            
          ELSE
            -- ELSE starting another write operation immediately
            IF
              (c_ternary_mode = const_ternary_off AND binary_compare(wr_din, rd_din)) OR
              (c_ternary_mode = const_ternary_std
               AND ternary_compare(wr_data_mask, wr_din, rd_data_mask, rd_din)) OR
              (c_ternary_mode = const_ternary_enh
               AND ternary_compare_xy(wr_data_mask, wr_din, rd_data_mask, rd_din))
            THEN
              --IF read and write data match, flag a read warning
              read_warning_i <= '1';
            ELSE
              read_warning_i <= '0';
            END IF;
            busy_i           <= '1'; --Set busy while writing
            write_counter    <= 1;
          END IF;

        ---------------------------------------------------------------------
        -- Undefined State
        ---------------------------------------------------------------------
        WHEN OTHERS => NULL;
      END CASE;



    END IF;
  END PROCESS main;




END behavioral;
