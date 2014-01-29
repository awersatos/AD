-----------------------------------------------------------------------------
-- $RCSfile: blkmemdp_v6_3.vhd,v $
-----------------------------------------------------------------------------
--
-- Dual Port Block Memory  - Behavioral Model
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
-- Filename:    blkmemdp_v6_3.vhd
--
-- Description: The behavioral model for the Dual Port Block Memory
--
---------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Package containing functions used in the Dual Port Block Memory Behavior
-- Model
-----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;


LIBRARY XilinxCoreLib;
USE XilinxCoreLib.blkmemdp_mem_init_file_pack_v6_3.ALL;
USE XilinxCoreLib.ul_utils.ALL;
USE XilinxCoreLib.blkmemdp_pkg_v6_3.ALL;


ENTITY blkmemdp_v6_3 IS

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
    c_sim_collision_check  : string  := "NONE";
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

END blkmemdp_v6_3;

-----------------------------------------------------------------------------

ARCHITECTURE behavioral OF blkmemdp_v6_3 IS

  -- When constant warning_off is set to 0, all the warning of undefined
  -- input will be given.  To turn off the warning messages, set warning_off
  -- to 1.  Ex.  constant warning_off : boolean := 1;
  CONSTANT warning_off : integer := c_yydisable_warnings;

-----------------------------------------------------------------------------
-- Functions definitions
-----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Procedures that outputs warning messages
  -----------------------------------------------------------------------------

  PROCEDURE warn_out_undef ( outsig : IN string; warning_off : IN integer ) IS
  BEGIN
    IF (warning_off = 0) THEN
      ASSERT false REPORT
        "Setting output " & outsig & " to X"
        SEVERITY warning;
    END IF;
  END warn_out_undef;

  PROCEDURE warn_signout_undef( sig : IN string; outsig : IN string; warning_off : IN integer ) IS
  BEGIN
    IF (warning_off = 0) THEN
      ASSERT false REPORT
        "Undefined input "& sig &". Setting output " & outsig & " to X"
        SEVERITY warning;
    END IF;
  END warn_signout_undef;

  PROCEDURE warn_memcontent_undef ( whichport : IN string; addr : IN string; warning_off : IN integer ) IS
  BEGIN
    IF (warning_off = 0) THEN
      ASSERT false REPORT
        "Setting contents of memory at ADDR"& whichport &" = "& addr &
        " to X"
        SEVERITY warning;
    END IF;
  END warn_memcontent_undef;

  PROCEDURE warn_oddclk_trans ( sig : string; bef : string; aft : string; warning_off : IN integer) IS
  BEGIN
    IF (warning_off = 0) THEN
      ASSERT false REPORT
        "Clock signal " & sig & " transitioned from " & bef & " to " & aft &
        ". Memory operation will not be successful."
        SEVERITY warning;
    END IF;
  END warn_oddclk_trans;

  -----------------------------------------------------------------------------

  FUNCTION SLV_TO_STR (
    SLV : IN std_logic_vector
    ) RETURN string IS

    VARIABLE j   : integer := SLV'length;
    VARIABLE STR : string (SLV'length DOWNTO 1);


  BEGIN
    FOR I IN SLV'high DOWNTO SLV'low LOOP
      CASE SLV(I) IS
        WHEN '0'    => STR(J) := '0';
        WHEN '1'    => STR(J) := '1';
        WHEN 'X'    => STR(J) := 'X';
        WHEN 'U'    => STR(J) := 'U';
        WHEN OTHERS => STR(J) := 'X';
      END CASE;
      J                       := J - 1;
    END LOOP;
    RETURN STR;
  END SLV_TO_STR;

  PROCEDURE SET_MEM_TO_X ( sig : string; ADDRESS : IN std_logic_vector;
                           MEM : INOUT std_logic_vector; 
                           warning_off : IN integer
                           ) IS

  BEGIN
    IF (warning_off = 0) THEN
    ASSERT false REPORT
      "Invalid address "& sig &" : "& SLV_TO_STR(ADDRESS) & ". Entire memory contents will be set to 'X'."
      SEVERITY warning;
    END IF;
    FOR I IN MEM'high DOWNTO MEM'low LOOP
      MEM(I) := 'X';
    END LOOP;
  END SET_MEM_TO_X;

  FUNCTION SLV_TO_INT(SLV : IN std_logic_vector
                      ) RETURN integer IS

    VARIABLE int : integer;
  BEGIN
    int     := 0;
    FOR i IN SLV'high DOWNTO SLV'low LOOP
      int   := int * 2;
      IF SLV(i) = '1' THEN
        int := int + 1;
      END IF;
    END LOOP;
    RETURN int;
  END;

  FUNCTION ADDR_IS_VALID (
    SLV : IN std_logic_vector
    ) RETURN boolean IS

    VARIABLE IS_VALID : boolean := true;

  BEGIN
    FOR I IN SLV'high DOWNTO SLV'low LOOP
      IF (SLV(I) /= '0' AND SLV(I) /= '1') THEN
        IS_VALID := false;
      END IF;
    END LOOP;
    RETURN IS_VALID;
  END ADDR_IS_VALID;

  FUNCTION hexstr_to_std_logic_vec( arg1 : string; size : integer ) RETURN std_logic_vector IS
    VARIABLE RESULT                      : std_logic_vector(size-1 DOWNTO 0)                   := (OTHERS => '0');
    VARIABLE BIN                         : std_logic_vector(3 DOWNTO 0);
    VARIABLE INDEX                       : integer                                             := 0;
  BEGIN
    FOR i IN arg1'reverse_range LOOP
      CASE arg1(i) IS
        WHEN '0'                                                                        => BIN := (OTHERS => '0');
        WHEN '1'                                                                        => BIN := (0 => '1', OTHERS => '0');
        WHEN '2'                                                                        => BIN := (1 => '1', OTHERS => '0');
        WHEN '3'                                                                        => BIN := (0 => '1', 1 => '1', OTHERS => '0');
        WHEN '4'                                                                        => BIN := (2 => '1', OTHERS => '0');
        WHEN '5'                                                                        => BIN := (0 => '1', 2 => '1', OTHERS => '0');
        WHEN '6'                                                                        => BIN := (1 => '1', 2 => '1', OTHERS => '0');
        WHEN '7'                                                                        => BIN := (3 => '0', OTHERS => '1');
        WHEN '8'                                                                        => BIN := (3 => '1', OTHERS => '0');
        WHEN '9'                                                                        => BIN := (0 => '1', 3 => '1', OTHERS => '0');
        WHEN 'A'                                                                        => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'a'                                                                        => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'B'                                                                        => BIN := (2 => '0', OTHERS => '1');
        WHEN 'b'                                                                        => BIN := (2 => '0', OTHERS => '1');
        WHEN 'C'                                                                        => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'c'                                                                        => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'D'                                                                        => BIN := (1 => '0', OTHERS => '1');
        WHEN 'd'                                                                        => BIN := (1 => '0', OTHERS => '1');
        WHEN 'E'                                                                        => BIN := (0 => '0', OTHERS => '1');
        WHEN 'e'                                                                        => BIN := (0 => '0', OTHERS => '1');
        WHEN 'F'                                                                        => BIN := (OTHERS => '1');
        WHEN 'f'                                                                        => BIN := (OTHERS => '1');
        WHEN OTHERS                                                                     =>
          IF (warning_off = 0) THEN
          ASSERT false
            REPORT "NOT A HEX CHARACTER" SEVERITY warning;
          END IF;
          FOR j IN 0 TO 3 LOOP
            BIN(j)                                                                             := 'X';
          END LOOP;
      END CASE;
      FOR j IN 0 TO 3 LOOP
        IF (INDEX*4)+j < size THEN
          RESULT((INDEX*4)+j)                                                                  := BIN(j);
        END IF;
      END LOOP;
      INDEX                                                                                    := INDEX + 1;
    END LOOP;
    RETURN RESULT;
  END hexstr_to_std_logic_vec;


  PROCEDURE ADDR_OVERLAP (
    ADDRESS_A, ADDRESS_B, DAW, DBW     : IN  integer;
    OVERLAP                            : OUT boolean;
    OVRLAP_LSB, OVRLAP_MSB, DOA_OV_LSB,
    DOA_OV_MSB, DOB_OV_LSB, DOB_OV_MSB : OUT integer
    ) IS

    VARIABLE A_LSB, A_MSB, B_LSB, B_MSB : integer;

  BEGIN
    A_LSB := ADDRESS_A * DAW;
    A_MSB := A_LSB + DAW - 1;
    B_LSB := ADDRESS_B * DBW;
    B_MSB := B_LSB + DBW - 1;

    IF (A_MSB < B_LSB OR B_MSB < A_LSB) THEN
      OVERLAP      := false;
    ELSE
      OVERLAP      := true;
      IF (A_LSB >= B_LSB) THEN
        OVRLAP_LSB := A_LSB;
        DOA_OV_LSB := 0;
        DOB_OV_LSB := A_LSB - B_LSB;
      ELSE
        OVRLAP_LSB := B_LSB;
        DOA_OV_LSB := B_LSB - A_LSB;
        DOB_OV_LSB := 0;
      END IF;
      IF (A_MSB >= B_MSB) THEN
        OVRLAP_MSB := B_MSB;
        DOA_OV_MSB := DAW - (A_MSB - B_MSB) - 1;
        DOB_OV_MSB := DBW - 1;
      ELSE
        OVRLAP_MSB := A_MSB;
        DOA_OV_MSB := DAW - 1;
        DOB_OV_MSB := DBW - (B_MSB - A_MSB) - 1;
      END IF;
    END IF;
  END ADDR_OVERLAP;

  PROCEDURE COLLISION (
    ADDRESS                          : IN    std_logic_vector;
    LSB, MSB                         : IN    integer;
    MODE, PORT1, PORT2, InstancePath : IN    string;
    MEM                              : INOUT std_logic_vector
    ) IS

  BEGIN
    IF (MODE = "write") THEN
      IF (warning_off = 0) THEN
      ASSERT false REPORT
        "WRITE COLLISION detected at " & PORT1 & " in instance " & InstancePath &
        ". Contents of address "& SLV_TO_STR(ADDRESS) &
        " will be wholly or partially set to 'X'."
        SEVERITY warning;
      END IF;
      FOR I IN MSB DOWNTO LSB LOOP
        MEM(I) := 'X';
      END LOOP;
    ELSIF (MODE = "read") THEN
      IF (warning_off = 0) THEN
      ASSERT false REPORT
        "Attempting to read some or all of contents of address "& SLV_TO_STR(ADDRESS) &
        " from " & PORT2 & " while writing from " & PORT1 &
        " in instance " & InstancePath
        SEVERITY warning;
      END IF;
    END IF;
  END COLLISION;


  ---------------------------------------------------------------------------
  -- Internal signals and type declarations
  ---------------------------------------------------------------------------

  TYPE pipeline_stages_a IS ARRAY ( 0 TO c_pipe_stages_a) OF std_logic_vector(c_width_a-1 DOWNTO 0);
  TYPE pipeline_stages_b IS ARRAY ( 0 TO c_pipe_stages_b) OF std_logic_vector(c_width_b-1 DOWNTO 0);
  SIGNAL pipelinea : pipeline_stages_a;
  SIGNAL pipelineb : pipeline_stages_b;
  SIGNAL sub_rdy_a : std_logic_vector( 0 TO c_pipe_stages_a );
  SIGNAL sub_rdy_b : std_logic_vector( 0 TO c_pipe_stages_b );

  SIGNAL DOUTA_prim : std_logic_vector(c_width_a-1 DOWNTO 0) := (OTHERS => 'X');
  SIGNAL DOUTB_prim : std_logic_vector(c_width_b-1 DOWNTO 0) := (OTHERS => 'X');

  SIGNAL ADDRA_ipd : std_logic_vector(c_addra_width-1 DOWNTO 0) := (OTHERS => 'X');
  SIGNAL ADDRB_ipd : std_logic_vector(c_addrb_width-1 DOWNTO 0) := (OTHERS => 'X');
  SIGNAL DIA_ipd   : std_logic_vector(c_width_a-1 DOWNTO 0)     := (OTHERS => 'X');
  SIGNAL DIB_ipd   : std_logic_vector(c_width_b-1 DOWNTO 0)     := (OTHERS => 'X');

  SIGNAL ENA_ipd, ENB_ipd   : std_logic := 'X';
  SIGNAL WEA_ipd, WEB_ipd   : std_logic := 'X';
  SIGNAL SSRA_ipd, SSRB_ipd : std_logic := 'X';
  SIGNAL NDA_ipd, NDB_ipd   : std_logic := 'X';
  SIGNAL NDA_int, NDB_int   : std_logic := 'X';
  SIGNAL CLKA_ipd, CLKB_ipd : std_logic := 'X';

  SIGNAL nda_q, ndb_q               : std_logic                                  := '0';
  SIGNAL addra_int                  : std_logic_vector(c_addra_width-1 DOWNTO 0) := (OTHERS => 'X');
  SIGNAL addrb_int                  : std_logic_vector(c_addrb_width-1 DOWNTO 0) := (OTHERS => 'X');
  SIGNAL dia_int                    : std_logic_vector(c_width_a-1 DOWNTO 0)     := (OTHERS => 'X');
  SIGNAL dib_int                    : std_logic_vector(c_width_b-1 DOWNTO 0)     := (OTHERS => 'X');
  SIGNAL wea_int, web_int           : std_logic                                  := 'X';
  SIGNAL addra_q                    : std_logic_vector(c_addra_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL addrb_q                    : std_logic_vector(c_addrb_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL dia_q                      : std_logic_vector(c_width_a-1 DOWNTO 0)     := (OTHERS => '0');
  SIGNAL dib_q                      : std_logic_vector(c_width_b-1 DOWNTO 0)     := (OTHERS => '0');
  SIGNAL wea_q, web_q               : std_logic                                  := '0';
  SIGNAL new_data_a, new_data_b     : std_logic                                  := 'X';
  SIGNAL new_data_a_q, new_data_b_q : std_logic                                  := '0';
  SIGNAL rfda_int, rfdb_int         : std_logic                                  := 'X';
  SIGNAL rdya_int, rdyb_int         : std_logic                                  := 'X';

  SIGNAL complete_assignment        : std_logic_vector(13 DOWNTO 0) := (OTHERS => '0');
  SIGNAL and_assignment             : std_logic := '0';

-- Constants used in VITAL timing calculation  --------------------------------------

  CONSTANT InstancePath                     : string         := "*";
  CONSTANT Xon                              : boolean        := true;
  CONSTANT MsgOn                            : boolean        := false;
  CONSTANT tsetup_CLKA_CLKB_posedge_posedge : VitalDelayType := 1 ns;
  CONSTANT tsetup_CLKB_CLKA_posedge_posedge : VitalDelayType := 1 ns;


BEGIN  -- architecture

  ADDRA_ipd <= ADDRA;
  ADDRB_ipd <= ADDRB;

  -- CLKA
  ca_h : IF (c_yclka_is_rising = 1) GENERATE
    CLKA_ipd <= CLKA;
    complete_assignment(0) <= '1';
  END GENERATE;

  ca_l : IF (c_yclka_is_rising = 0) GENERATE
    CLKA_ipd <= NOT(CLKA);
    complete_assignment(0) <= '1';
  END GENERATE;

  -- CLKB
  cb_h : IF (c_yclkb_is_rising = 1) GENERATE
    CLKB_ipd <= CLKB;
    complete_assignment(1) <= '1';
  END GENERATE;

  cb_l : IF (c_yclkb_is_rising = 0) GENERATE
    CLKB_ipd <= NOT(CLKB);
    complete_assignment(1) <= '1';
  END GENERATE;

  -- NDA
  nda_1 : IF (c_has_nda = 1) GENERATE
    NDA_ipd <= NDA;
    complete_assignment(2) <= '1';
  END GENERATE;
  nda_0 : IF (c_has_nda = 0) GENERATE
    NDA_ipd <= '1';
    complete_assignment(2) <= '1';
  END GENERATE;

  -- NDB
  ndb_1 : IF (c_has_ndb = 1) GENERATE
    NDB_ipd <= NDB;
    complete_assignment(3) <= '1';
  END GENERATE;
  ndb_0 : IF (c_has_ndb = 0) GENERATE
    NDB_ipd <= '1';
    complete_assignment(3) <= '1';
  END GENERATE;

  -- DINA
  dina_1 : IF (c_has_dina = 1) GENERATE
    DIA_ipd <= DINA;
    complete_assignment(4) <= '1';
  END GENERATE;
  dina_0 : IF (c_has_dina = 0) GENERATE
    DIA_ipd <= (OTHERS => '0');
    complete_assignment(4) <= '1';
  END GENERATE;

  -- DINB
  dinb_1 : IF (c_has_dinb = 1) GENERATE
    DIB_ipd <= DINB;
    complete_assignment(5) <= '1';
  END GENERATE;
  dinb_0 : IF (c_has_dinb = 0) GENERATE
    DIB_ipd <= (OTHERS => '0');
    complete_assignment(5) <= '1';
  END GENERATE;

  -- ENA
  ena_1 : IF (c_has_ena = 1) GENERATE
    h   : IF (c_yena_is_high = 1) GENERATE
      ENA_ipd <= ENA;
    END GENERATE h;

    l : IF (c_yena_is_high = 0) GENERATE
      ENA_ipd <= NOT(ENA);
    END GENERATE l;
    complete_assignment(6) <= '1';
  END GENERATE;

  ena_0 : IF (c_has_ena = 0) GENERATE
    ENA_ipd <= '1';
    complete_assignment(6) <= '1';
  END GENERATE;

  -- ENB
  enb_1 : IF (c_has_enb = 1) GENERATE
    h   : IF (c_yenb_is_high = 1) GENERATE
      ENB_ipd <= ENB;
    END GENERATE h;

    l : IF (c_yenb_is_high = 0) GENERATE
      ENB_ipd <= NOT(ENB);
    END GENERATE l;
    complete_assignment(7) <= '1';
  END GENERATE;

  enb_0 : IF (c_has_enb = 0) GENERATE
    ENB_ipd <= '1';
    complete_assignment(7) <= '1';
  END GENERATE;

  -- WEA
  wea_1 : IF (c_has_wea = 1) GENERATE
    h   : IF (c_ywea_is_high = 1) GENERATE
      WEA_ipd <= WEA;
    END GENERATE h;

    l   : IF (c_ywea_is_high = 0) GENERATE
      WEA_ipd <= NOT(WEA);
    END GENERATE l;
    complete_assignment(8) <= '1';
  END GENERATE;
  wea_0 : IF (c_has_wea = 0) GENERATE
    WEA_ipd   <= '0';
    complete_assignment(8) <= '1';
  END GENERATE;

  -- WEB
  web_1 : IF (c_has_web = 1) GENERATE
    h   : IF (c_yweb_is_high = 1) GENERATE
      WEB_ipd <= WEB;
    END GENERATE h;

    l   : IF (c_yweb_is_high = 0) GENERATE
      WEB_ipd <= NOT(WEB);
    END GENERATE l;
    complete_assignment(9) <= '1';
  END GENERATE;
  web_0 : IF (c_has_web = 0) GENERATE
    WEB_ipd   <= '0';
    complete_assignment(9) <= '1';
  END GENERATE;

  -- SINITA
  sinita_1 : IF (c_has_sinita = 1) GENERATE
    h      : IF (c_ysinita_is_high = 1) GENERATE
      SSRA_ipd <= SINITA;
    END GENERATE h;

    l      : IF (c_ysinita_is_high = 0) GENERATE
      SSRA_ipd <= NOT(SINITA);
    END GENERATE l;
    complete_assignment(10) <= '1';
  END GENERATE;
  sinita_0 : IF (c_has_sinita = 0) GENERATE
    SSRA_ipd   <= '0';
    complete_assignment(10) <= '1';
  END GENERATE;

  -- SINITB
  sinitb_1 : IF (c_has_sinitb = 1) GENERATE
    h      : IF (c_ysinitb_is_high = 1) GENERATE
      SSRB_ipd <= SINITB;
    END GENERATE h;

    l      : IF (c_ysinitb_is_high = 0) GENERATE
      SSRB_ipd <= NOT(SINITB);
    END GENERATE l;
    complete_assignment(11) <= '1';
  END GENERATE;
  sinitb_0 : IF (c_has_sinitb = 0) GENERATE
    SSRB_ipd   <= '0';
    complete_assignment(11) <= '1';
  END GENERATE;

------- Generate ouput control signals RFDA, RFDB, RDYA, RDYB  ----------------------


  rfda_int <= ENA_ipd;

  rfda_1 : IF (c_has_rfda = 1) GENERATE
    RFDA <= rfda_int;
    complete_assignment(12) <= '1';
  END GENERATE;

  rfda_0 : IF (c_has_rfda = 0) GENERATE
    RFDA <= '0';
    complete_assignment(12) <= '1';
  END GENERATE;

  rfdb_int <= ENB_ipd;

  rfdb_1 : IF (c_has_rfdb = 1) GENERATE
    RFDB <= rfdb_int;
    complete_assignment(13) <= '1';
  END GENERATE;

  rfdb_0 : IF (c_has_rfdb = 0) GENERATE
    RFDB <= '0';
    complete_assignment(13) <= '1';
  END GENERATE;  

  and_assignment <= complete_assignment(0) AND complete_assignment(1) AND
                    complete_assignment(2) AND complete_assignment(3) AND
                    complete_assignment(4) AND complete_assignment(5) AND
                    complete_assignment(6) AND complete_assignment(7) AND
                    complete_assignment(8) AND complete_assignment(9) AND
                    complete_assignment(10) AND complete_assignment(11) AND
                    complete_assignment(12) AND complete_assignment(13);

  rdya_process : PROCESS ( rdya_int, and_assignment)
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( (c_has_rdya = 1) AND (c_has_nda = 1) AND (c_has_rfda = 1) ) THEN
        RDYA <= rdya_int;
      ELSE
        RDYA <= '0';
      END IF;
    END IF;

  END PROCESS rdya_process;

  rdyb_process : PROCESS ( rdyb_int, and_assignment)
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( (c_has_rdyb = 1) AND (c_has_ndb = 1) AND (c_has_rfdb = 1) ) THEN
        RDYB <= rdyb_int;
      ELSE
        RDYB <= '0';
      END IF;    
    END IF;

  END PROCESS rdyb_process;



-- Gate ND signals with EN

  NDA_int <= ENA_ipd AND NDA_ipd;
  NDB_int <= ENB_ipd AND NDB_ipd;

-- Register NDA handshaking input for port A

  register_NDA : PROCESS (CLKA_ipd,and_assignment )
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( CLKA_ipd'event AND CLKA_ipd = '1') THEN
        IF (ENA_ipd = '1') THEN
          IF (SSRA_ipd = '1') THEN
            nda_q <= '0';
          ELSE
            nda_q <= NDA_int;
          END IF;
        END IF;
      END IF;    
    END IF;
  END PROCESS register_NDA;

-- Register NDB handshaking input for port B

  register_NDB : PROCESS (CLKB_ipd,and_assignment )
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( CLKB_ipd'event AND CLKB_ipd = '1') THEN
        IF (ENB_ipd = '1') THEN
          IF (SSRB_ipd = '1') THEN
            ndb_q <= '0';
          ELSE
            ndb_q <= NDB_int;
          END IF;
        END IF;
      END IF;    
    END IF;
  END PROCESS register_NDB;

-- Register data/address/we inputs for port A

  register_inputsa : PROCESS (CLKA_ipd, and_assignment )
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( CLKA_ipd'event AND CLKA_ipd = '1') THEN
        IF (ENA_ipd = '1') THEN
          dia_q   <= DIA_ipd;
          addra_q <= ADDRA_ipd;
          wea_q   <= WEA_ipd;
        END IF;
      END IF;    
    END IF;
  END PROCESS register_inputsa;

-- Register data/address/we inputs for port B

  register_inputsb : PROCESS (CLKB_ipd, and_assignment )
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( CLKB_ipd'event AND CLKB_ipd = '1') THEN
        IF (ENB_ipd = '1') THEN
          dib_q   <= DIB_ipd;
          addrb_q <= ADDRB_ipd;
          web_q   <= WEB_ipd;
        END IF;
      END IF;    
    END IF;
  END PROCESS register_inputsb;

-- Select registered or non-registered inputs for port A


  select_inputsa : PROCESS (WEA_ipd, wea_q, DIA_ipd, dia_q, ADDRA_ipd, addra_q, NDA_int, nda_q, and_assignment )
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( c_reg_inputsa = 1) THEN
        wea_int    <= wea_q;
        dia_int    <= dia_q;
        addra_int  <= addra_q;
        IF ((wea_q = '1') AND (c_write_modea = c_no_change)) THEN
          new_data_a <= '0';
        ELSE
          new_data_a <= nda_q;        
        END IF;
      ELSE
        wea_int    <= WEA_ipd;
        dia_int    <= DIA_ipd;
        addra_int  <= ADDRA_ipd;
        IF ((wea_ipd = '1') AND (c_write_modea = c_no_change)) THEN
          new_data_a <= '0';
        ELSE
          new_data_a <= NDA_int;
        END IF;
      END IF;    
    END IF;
  END PROCESS select_inputsa;

-- Select registered or no-registered inputs for port B

  select_inputsb : PROCESS (WEB_ipd, web_q, DIB_ipd, dib_q, ADDRB_ipd, addrb_q, NDB_int, ndb_q, and_assignment )
  BEGIN
    IF (and_assignment = '1') THEN
      IF ( c_reg_inputsb = 1) THEN
        web_int    <= web_q;
        dib_int    <= dib_q;
        addrb_int  <= addrb_q;
        IF ((web_q = '1') AND (c_write_modeb = c_no_change)) THEN      
          new_data_b <= '0';
        ELSE
          new_data_b <= ndb_q;
        END IF;        
      ELSE
        web_int    <= WEB_ipd;
        dib_int    <= DIB_ipd;
        addrb_int  <= ADDRB_ipd;
        IF ((WEB_ipd = '1') AND (c_write_modeb = c_no_change)) THEN
          new_data_b <= '0';        
        ELSE
          new_data_b <= NDB_int;
        END IF;
      END IF;    
    END IF;
  END PROCESS select_inputsb;

-- Register new_data signals for Port A and B to track the synchronous RAM output

  register_newdataa         : PROCESS (CLKA_ipd, and_assignment )
    VARIABLE first_newdataa : boolean := true;
  BEGIN
    IF (and_assignment = '1') THEN
      IF (first_newdataa = true ) THEN
        new_data_a_q       <= '0';
        first_newdataa                  := false;
      ELSE
        IF ( CLKA_ipd'event AND CLKA_ipd = '1') THEN
          IF (ENA_ipd = '1') THEN
            IF (SSRA_ipd = '1') THEN
              new_data_a_q <= '0';
            ELSE
            -- Do not update RDYA if write mode is no_change and wea=1
            --IF NOT (c_write_modea = 2 AND wea_int = '1') THEN
            -- rii: 10/20 Make behavior the same as single port block memory
              new_data_a_q <= new_data_a;
            --END IF;
            END IF;
          END IF;
        END IF;
      END IF;    
    END IF;
  END PROCESS register_newdataa;

  register_newdatab         : PROCESS (CLKB_ipd, and_assignment )
    VARIABLE first_newdatab : boolean := true;
  BEGIN
    IF (and_assignment = '1') THEN
      IF (first_newdatab = true ) THEN
        new_data_b_q       <= '0';
        first_newdatab                  := false;
      ELSE
        IF ( CLKB_ipd'event AND CLKB_ipd = '1') THEN
          IF (ENB_ipd = '1') THEN
            IF (SSRB_ipd = '1') THEN
              new_data_b_q <= '0';
            ELSE
            -- Do not update RDYB if write mode is no_change and web=1
            --IF NOT (c_write_modeb = 2 AND web_int = '1') THEN
            -- rii: 10/20 Make behavior the same as single port block memory
              new_data_b_q <= new_data_b;
            --END IF;
            END IF;
          END IF;
        END IF;
      END IF;    
    END IF;
  END PROCESS register_newdatab;



  dp_primitive : PROCESS


    -- Local constant  and variables used for functionality
    VARIABLE Violation : std_ulogic := '0';

    VARIABLE Tviol_CLKA_CLKB_posedge : std_ulogic := '0';
    VARIABLE Tviol_CLKB_CLKA_posedge : std_ulogic := '0';

    VARIABLE Tmkr_CLKA_CLKB_posedge : VitalTimingDataType := VitalTimingDataInit;
    VARIABLE Tmkr_CLKB_CLKA_posedge : VitalTimingDataType := VitalTimingDataInit;

    CONSTANT mem_bits : integer := c_depth_a * c_width_a;

    VARIABLE MEM                                                        : std_logic_vector(mem_bits-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE MEM_tmpa : std_logic_vector(mem_bits-1 DOWNTO 0) :=(OTHERS => '0');
    VARIABLE MEM_tmpb : std_logic_vector(mem_bits-1 DOWNTO 0) :=(OTHERS => '0');

    VARIABLE ADDRESS_A, ADDRESS_B, OLP_LSB, OLP_MSB, OLPP_LSB, OLPP_MSB : integer;
    VARIABLE DOA_OV_LSB, DOA_OV_MSB, DOB_OV_LSB, DOB_OV_MSB             : integer;
    VARIABLE DOPA_OV_LSB, DOPA_OV_MSB, DOPB_OV_LSB, DOPB_OV_MSB         : integer;
    VARIABLE VALID_ADDRA, VALID_ADDRB, HAS_OVERLAP, HAS_OVERLAP_P       : boolean                               := false;
    VARIABLE WR_A_LATER, WR_B_LATER                                     : boolean                               := false;
    CONSTANT DIAW                                                       : integer                               := c_width_a;
    CONSTANT DIAW_1                                                     : integer                               := c_width_a - 1;
    CONSTANT DIBW                                                       : integer                               := c_width_b;
    CONSTANT DIBW_1                                                     : integer                               := c_width_b - 1;
    VARIABLE DOA_zd                                                     : std_logic_vector(c_width_a-1 DOWNTO 0);
    VARIABLE DOB_zd                                                     : std_logic_vector(c_width_b-1 DOWNTO 0);
    VARIABLE START_UP                                                   : boolean                               := true;
    VARIABLE offset                                                     : integer                               := 0;
    VARIABLE def_data                                                   : std_logic_vector(c_width_a-1 DOWNTO 0 );
    VARIABLE lineno                                                     : integer                               := 0;
    VARIABLE sinita_value                                               : std_logic_vector (c_width_a-1 DOWNTO 0);
    VARIABLE sinitb_value                                               : std_logic_vector (c_width_b-1 DOWNTO 0);

    VARIABLE ADDRESS_Astr : string(1 TO c_addra_width);
    VARIABLE ADDRESS_Bstr : string(1 TO c_addrb_width);

  BEGIN  -- process

    IF (and_assignment = '1') THEN
      IF (START_UP = true ) THEN

        sinita_value := (OTHERS => '0');
        sinitb_value := (OTHERS => '0');
        def_data     := hexstr_to_std_logic_vec(c_default_data, c_width_a);

        IF (c_has_sinita = 1) THEN
          sinita_value    := hexstr_to_std_logic_vec(c_sinita_value, c_width_a);
        END IF;
        IF (c_has_sinitb = 1) THEN
          sinitb_value    := hexstr_to_std_logic_vec(c_sinitb_value, c_width_b);
        END IF;
        IF( c_has_default_data = 0 ) THEN
          read_meminit_file(c_mem_init_file, c_depth_a, c_width_a, MEM, lineno);
        END IF;
        offset            := lineno*c_width_a;
        WHILE (lineno < c_depth_a) LOOP
          FOR i IN 0 TO c_width_a-1 LOOP
            MEM(offset+i) := def_data(i);
          END LOOP;
          lineno          := lineno+1;
          offset          := offset+c_width_a;
        END LOOP;
        DOA_zd            := sinita_value;
        DOB_zd            := sinitb_value;
        START_UP          := false;

      ELSE                                ---     behavior after start up 


        VALID_ADDRA := ADDR_IS_VALID(addra_int);
        VALID_ADDRB := ADDR_IS_VALID(addrb_int);

        IF (VALID_ADDRA) THEN
          ADDRESS_A    := SLV_TO_INT(addra_int);
          ADDRESS_Astr := SLV_TO_STR(addra_int);
        END IF;

        IF (VALID_ADDRB) THEN
          ADDRESS_B    := SLV_TO_INT(addrb_int);
          ADDRESS_Bstr := SLV_TO_STR(addrb_int);
        END IF;

        IF (VALID_ADDRA AND VALID_ADDRB) THEN
          ADDR_OVERLAP (ADDRESS_A, ADDRESS_B, DIAW, DIBW, HAS_OVERLAP,
                      OLP_LSB, OLP_MSB, DOA_OV_LSB, DOA_OV_MSB, DOB_OV_LSB, DOB_OV_MSB);
        END IF;

        IF (HAS_OVERLAP = true ) THEN
          VitalSetupHoldCheck (
            Violation      => Tviol_CLKB_CLKA_posedge,
            TimingData     => Tmkr_CLKB_CLKA_posedge,
            TestSignal     => CLKB_ipd,
            TestSignalName => "CLKB",
            TestDelay      => 0 ns,
            RefSignal      => CLKA_ipd,
            RefSignalName  => "CLKA",
            RefDelay       => 0 ns,
            SetupHigh      => tsetup_CLKB_CLKA_posedge_posedge,
            CheckEnabled   => ((TO_X01(ENA_ipd) = '1' AND TO_X01(ENB_ipd) = '1') AND
                                      (TO_X01(wea_int) = '1' OR TO_X01(web_int) = '1')),
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/blkmem_v6_3",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => warning);

          VitalSetupHoldCheck (
            Violation      => Tviol_CLKA_CLKB_posedge,
            TimingData     => Tmkr_CLKA_CLKB_posedge,
            TestSignal     => CLKA_ipd,
            TestSignalName => "CLKA",
            TestDelay      => 0 ns,
            RefSignal      => CLKB_ipd,
            RefSignalName  => "CLKB",
            RefDelay       => 0 ns,
            SetupHigh      => tsetup_CLKA_CLKB_posedge_posedge,
            CheckEnabled   => ((TO_X01(ENA_ipd) = '1' AND TO_X01(ENB_ipd) = '1') AND
                                      (TO_X01(wea_int) = '1' OR TO_X01(web_int) = '1')),
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/blkmem_v6_3",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => warning);
        END IF;

        --
        -- Port A
        --
        WR_A_LATER := false;
        WR_B_LATER := false;

        IF (ENA_ipd = '1') THEN
          IF (CLKA_ipd'event AND CLKA_ipd'last_value = '0') THEN
            IF (CLKA_ipd = '1') THEN
              IF (ADDRESS_A < c_depth_a ) THEN
                IF (wea_int = '1') THEN
                  IF (VALID_ADDRA) THEN
                    IF(c_write_modea = c_write_first) THEN
                      DOA_zd                                                 := dia_int;
                    ELSIF(c_write_modea = c_read_first) THEN
                      DOA_zd                                                 := MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW));
                    ELSIF(c_write_modea /= c_no_change) THEN
                      ASSERT false REPORT
                        " Wrong value for WRITE_MODE, assuming WRITE_FIRST "
                        SEVERITY warning;
                      DOA_zd                                                 := dia_int;
                    END IF; --END (c_write_modea = c_write_first)
                    IF (c_write_modea /= c_read_first) THEN
                      MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) := dia_int;
                    ELSE WR_A_LATER                                          := true;
                    END IF; --END (c_write_modea /= c_read_first)

                    IF (ENB_ipd = '1' AND VALID_ADDRB AND HAS_OVERLAP) THEN
                      IF (Tviol_CLKB_CLKA_posedge = 'X') THEN
                        IF (web_int /= '0') THEN
                          IF (c_write_modea /= c_read_first
                              AND c_write_modeb /= c_read_first) THEN
                            COLLISION (addra_int, OLP_LSB, OLP_MSB, "write", "port A", "port B", InstancePath, MEM);
                          END IF;
                          IF (c_write_modea /= c_no_change
                              AND c_write_modeb /= c_read_first ) THEN
                            DOA_zd (DOA_OV_MSB DOWNTO DOA_OV_LSB)          := (OTHERS => 'X');
                          END IF;
                          IF (c_write_modea /= c_read_first
                              AND c_write_modeb /= c_no_change ) THEN
                            DOB_zd (DOB_OV_MSB DOWNTO DOB_OV_LSB)          := (OTHERS => 'X');
                          END IF;
                        ELSE
                          IF (c_write_modea /= c_read_first) THEN
                            COLLISION (addra_int, OLP_LSB, OLP_MSB, "read", "port A", "port B", InstancePath, MEM);
                            DOB_zd (DOB_OV_MSB DOWNTO DOB_OV_LSB)          := (OTHERS => 'X');
                          END IF; --END (c_write_modea /= c_read_first ) 
                        END IF; --END (web_int /= '0')
                      END IF; --END (Tviol_CLKB_CLKA_posedge = 'X')
                    END IF; --END (ENB_ipd = '1' AND VALID_ADDRB AND HAS_OVERLAP)
                  ELSE
                    SET_MEM_TO_X("ADDRA", addra_int, MEM, warning_off);
                    IF (c_write_modea /= c_no_change) THEN 
                      warn_out_undef("DOUTA", warning_off);
                      DOA_zd := (OTHERS => 'X');
                    END IF;
                  END IF; --END(VALID_ADDRA)
                ELSIF (wea_int = 'X') THEN
                  warn_signout_undef("WEA", "DOUTA", warning_off);
                  IF (VALID_ADDRA) THEN
                    warn_memcontent_undef("A", ADDRESS_Astr, warning_off);
                    MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) := (OTHERS => 'X');
                  ELSE
                    SET_MEM_TO_X("ADDRA", addra_int, MEM, warning_off);
                  END IF;
                  DOA_zd                                                   := (OTHERS => 'X');
                ELSE
                  IF (VALID_ADDRA) THEN
                    DOA_zd                                                 := MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW));
                  ELSE
                    warn_signout_undef("ADDRA", "DOUTA", warning_off);
                    DOA_zd                                                 := (OTHERS => 'X');
                  END IF;
                END IF; --END (we_int = '1')
              
                IF (SSRA_ipd = '1') THEN
                  DOA_zd                                                   := sinita_value;
                ELSIF (SSRA_ipd = 'X') THEN
                  warn_signout_undef("SINITA", "DOUTA", warning_off);
                  DOA_zd                                                   := (OTHERS => 'X');
                END IF;
              ELSE
                ASSERT false
                  REPORT " Memory address of port A is out of range. "
                  SEVERITY warning;
                DOA_zd := (OTHERS => 'X');
              END IF;

            ELSIF (CLKA_ipd = 'X') THEN
              IF (c_yclka_is_rising = 1) THEN
                warn_oddclk_trans("CLKA", "0", "X", warning_off);
             ELSE
                warn_oddclk_trans("CLKA", "1", "X", warning_off);
              END IF;
              IF (c_write_modea /= c_no_change ) THEN
                DOA_zd                                                   := (OTHERS => 'X');
                warn_out_undef("DOUTA", warning_off);
              END IF;
              IF (wea_int /= '0') THEN
                IF (VALID_ADDRA) THEN
                  MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) := (OTHERS => 'X');
                  warn_memcontent_undef("A", ADDRESS_Astr, warning_off);
                ELSE
                  SET_MEM_TO_X("ADDRA", addra_int, MEM, warning_off);
                END IF;
              END IF;
            END IF;
          ELSIF (CLKA_ipd'event AND CLKA_ipd'last_value = 'X') THEN
            IF (CLKA_ipd = '1') THEN
              IF (c_yclka_is_rising = 1) THEN
                warn_oddclk_trans("CLKA", "X", "1", warning_off);
              ELSE
                warn_oddclk_trans("CLKA", "X", "0", warning_off);
              END IF;
              warn_out_undef("DOUTA", warning_off);
              IF (wea_int /= '0') THEN
                IF (VALID_ADDRA) THEN
                  warn_memcontent_undef("A", ADDRESS_Astr, warning_off);
                  MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) := (OTHERS => 'X');
                ELSE
                  SET_MEM_TO_X("ADDRA", addra_int, MEM, warning_off);
                END IF;
              END IF;
              DOA_zd                                                     := (OTHERS => 'X');
            END IF;
          END IF;
        ELSIF (ENA_ipd = 'X') THEN
          IF (CLKA_ipd'event AND CLKA_ipd'last_value /= '1') THEN
            IF (CLKA_ipd /= '0') THEN
              warn_signout_undef("ENA", "DOUTA", warning_off);
              IF (wea_int /= '0') THEN
                IF (VALID_ADDRA) THEN
                  warn_memcontent_undef("A", ADDRESS_Astr, warning_off);
                  MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) := (OTHERS => 'X');
                ELSE
                  SET_MEM_TO_X("ADDRA", addra_int, MEM, warning_off);
                  MEM                                                    := (OTHERS => 'X');
                END IF;
              END IF;
              DOA_zd                                                     := (OTHERS => 'X');
            END IF;
          END IF;
        END IF;

        --
        -- Port B
        --
        IF (ENB_ipd = '1') THEN
          IF (CLKB_ipd'event AND CLKB_ipd'last_value = '0') THEN
            IF (CLKB_ipd = '1') THEN
              IF (ADDRESS_B < c_depth_b) THEN
                IF (web_int = '1') THEN
                  IF (VALID_ADDRB) THEN
                    IF(c_write_modeb = c_write_first) THEN
                      DOB_zd                                                 := dib_int;
                    ELSIF(c_write_modeb = c_read_first) THEN
                      DOB_zd                                                 := MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW));
                    ELSIF(c_write_modeb /= c_no_change) THEN
                      ASSERT false REPORT
                      " Wrong value for WRITE_MODE, assuming WRITE_FIRST "
                      SEVERITY warning;
                      DOB_zd                                                 := dib_int;
                    END IF;
                    IF (c_write_modeb /= c_read_first) THEN
                      MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) := dib_int;
                    ELSE WR_B_LATER                                          := true;
                    END IF;
                    IF (ENA_ipd = '1' AND VALID_ADDRA AND HAS_OVERLAP) THEN
                      IF (Tviol_CLKA_CLKB_posedge = 'X') THEN
                        IF (wea_int /= '0') THEN
                          IF (c_write_modea /= c_read_first AND c_write_modeb /= c_read_first ) THEN
                            COLLISION (addrb_int, OLP_LSB, OLP_MSB, "write",
                                     "port B", "port A", InstancePath, MEM);
                          END IF;
                          IF ( SSRA_ipd = '0'
                               AND c_write_modea /= c_no_change
                             AND c_write_modeb /= c_read_first ) THEN
                            DOA_zd (DOA_OV_MSB DOWNTO DOA_OV_LSB)            := (OTHERS => 'X');
                          END IF;
                          IF (c_write_modea /= c_read_first
                              AND c_write_modeb /= c_no_change ) THEN
                            DOB_zd (DOB_OV_MSB DOWNTO DOB_OV_LSB)            := (OTHERS => 'X');
                          END IF;
                        ELSE
                          IF (c_write_modeb /= c_read_first ) THEN
                            COLLISION (addrb_int, OLP_LSB, OLP_MSB, "read",
                                     "port B", "port A", InstancePath, MEM);
                          END IF;
                          IF ( SSRA_ipd = '0'
                               AND c_write_modeb /= c_read_first ) THEN
                            DOA_zd (DOA_OV_MSB DOWNTO DOA_OV_LSB)            := (OTHERS => 'X');
                          END IF;

                        END IF;
                      END IF;
                    END IF;
                  ELSE
                    SET_MEM_TO_X("ADDRB", addrb_int, MEM, warning_off);
                    IF (c_write_modeb /= c_no_change ) THEN
                      warn_out_undef("DOUTB", warning_off);
                      DOB_zd                                               := (OTHERS => 'X');
                    END IF;
                  END IF;
                ELSIF (web_int = 'X') THEN
                  warn_signout_undef("WEB", "DOUTB", warning_off);
                  IF (VALID_ADDRB) THEN
                    warn_memcontent_undef("B", ADDRESS_Bstr, warning_off);
                    MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) := (OTHERS => 'X');
                  ELSE
                    SET_MEM_TO_X("ADDRB", addrb_int, MEM, warning_off);
                  END IF;
                  DOB_zd                                                   := (OTHERS => 'X');
                ELSE
                  IF (VALID_ADDRB ) THEN
                    DOB_zd                                                 := MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW));
                    IF (Tviol_CLKB_CLKA_posedge = 'X' AND HAS_OVERLAP = true AND c_write_modea /= c_read_first) THEN
                      DOB_zd (DOB_OV_MSB DOWNTO DOB_OV_LSB)                := (OTHERS => 'X');
                    END IF;
                  ELSE
                    warn_signout_undef("ADDRB", "DOUTB", warning_off);
                    DOB_zd                                                 := (OTHERS => 'X');
                  END IF;
                END IF;
                IF (SSRB_ipd = '1') THEN
                  DOB_zd                                                   := sinitb_value;
                ELSIF (SSRB_ipd = 'X') THEN
                  warn_signout_undef("SINITB", "DOUTB", warning_off);
                  DOB_zd                                                   := (OTHERS => 'X');
                END IF;
              ELSE
                ASSERT false
                  REPORT " Memory address of port B is out of range. "
                  SEVERITY warning;
                  DOB_zd := (OTHERS => 'X');
              END IF;

            ELSIF (CLKB_ipd = 'X') THEN
              IF (c_yclkb_is_rising = 1) THEN
                warn_oddclk_trans("CLKB", "0", "X", warning_off);
              ELSE
                warn_oddclk_trans("CLKB", "1", "X", warning_off);
              END IF;
              IF (c_write_modeb /= c_no_change ) THEN
                DOB_zd                                                   := (OTHERS => 'X');
                warn_out_undef("DOUTB", warning_off);
              END IF;
              IF (web_int /= '0') THEN
                IF (VALID_ADDRB) THEN
                  warn_memcontent_undef("B", ADDRESS_Bstr, warning_off);
                  MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) := (OTHERS => 'X');
                ELSE
                  SET_MEM_TO_X("ADDRB", addrb_int, MEM, warning_off);
                END IF;
              END IF;
            END IF;
          ELSIF (CLKB_ipd'event AND CLKB_ipd'last_value = 'X') THEN
            IF (CLKB_ipd = '1') THEN
              IF (c_yclkb_is_rising = 1) THEN
                warn_oddclk_trans("CLKB", "0", "X", warning_off);
              ELSE
                warn_oddclk_trans("CLKB", "1", "X", warning_off);
              END IF;
              warn_out_undef("DOUTB", warning_off);
              IF (web_int /= '0') THEN
                IF (VALID_ADDRB) THEN
                  warn_memcontent_undef("B", ADDRESS_Bstr, warning_off);
                  MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) := (OTHERS => 'X');
                ELSE
                  SET_MEM_TO_X("ADDRB", addrb_int, MEM, warning_off);
                END IF;
              END IF;
              DOB_zd                                                     := (OTHERS => 'X');
            END IF;
          END IF;
        ELSIF (ENB_ipd = 'X') THEN
          IF (CLKB_ipd'event AND CLKB_ipd'last_value /= '1') THEN
            IF (CLKB_ipd /= '0') THEN
              warn_signout_undef("ENB", "DOUTB", warning_off);
              IF (web_int /= '0') THEN
                IF (VALID_ADDRB) THEN
                  MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) := (OTHERS => 'X');
                  warn_memcontent_undef("B", ADDRESS_Bstr, warning_off);
                ELSE
                  SET_MEM_TO_X("ADDRB", addrb_int, MEM, warning_off);
                  MEM                                                    := (OTHERS => 'X');
                END IF;
              END IF;
              DOB_zd                                                     := (OTHERS => 'X');
            END IF;
          END IF;
        END IF;

        IF (WR_A_LATER = true ) THEN

          MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) := dia_int;
        END IF;

        IF (WR_B_LATER = true ) THEN

          MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) := dib_int;
        END IF;

        IF (WR_A_LATER AND WR_B_LATER AND HAS_OVERLAP
            AND Tviol_CLKB_CLKA_posedge = 'X') THEN
          -- If in this branch, then both ports a and b are in c_read_first mode
          -- Therefore, output ports A and B need to go unkown for a single
          -- cycle, and then go back to previous value
          MEM_tmpa((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) :=
            MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW));
          MEM_tmpb((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) :=
            MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW));
          COLLISION (addrb_int, OLP_LSB, OLP_MSB, "write", "port B", "port A", InstancePath, MEM);
          DOA_zd := MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW));
          DOB_zd := MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW));
          MEM((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW)) :=
            MEM_tmpa((ADDRESS_A*DIAW + DIAW_1) DOWNTO (ADDRESS_A*DIAW));
          MEM((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW)) :=
            MEM_tmpb((ADDRESS_B*DIBW + DIBW_1) DOWNTO (ADDRESS_B*DIBW));
        END IF;

        DOUTA_prim <= DOA_zd;
        DOUTB_prim <= DOB_zd;

      END IF;  --- start up    
    END IF;

    WAIT ON CLKA_ipd, CLKB_ipd, wea_int, web_int, ENA_ipd, ENB_ipd,
      SSRA_ipd, SSRB_ipd, dia_int, dib_int, addra_int, addrb_int;

  END PROCESS dp_primitive;

--------- Output pipeline for Port A    --------------------------------------------------------------------

  pipelinea_output            : PROCESS (CLKA_ipd, WEA_ipd, ENA_ipd, SSRA_ipd, DIA_ipd, ADDRA_ipd, and_assignment)
    VARIABLE sinita_value_int : std_logic_vector(c_width_a-1 DOWNTO 0);
    VARIABLE first_time_a     : boolean := TRUE;
  BEGIN

    IF (and_assignment = '1') THEN
      IF (first_time_a = TRUE ) THEN
        sinita_value_int   := (others => '0');
        IF (c_has_sinita = 1) THEN
          sinita_value_int := hexstr_to_std_logic_vec(c_sinita_value, c_width_a);
        END IF;
        FOR i IN 0 TO c_pipe_stages_a LOOP
          pipelinea(i) <= sinita_value_int;
        END LOOP;
        FOR i IN 0 TO c_pipe_stages_a LOOP
          sub_rdy_a(i) <= '0';
        END LOOP;
        first_time_a       := FALSE;

      ELSE

        IF ( CLKA_ipd'event AND CLKA_ipd = '1') THEN
          IF (ENA_ipd = '1') THEN
            IF (SSRA_ipd = '1') THEN
              -- for i in 0 to c_pipe_stages_a loop
              pipelinea(0) <= sinita_value_int;
              sub_rdy_a(0) <= '0';
              -- end loop;
            ELSE
              -- for i in 0 to c_pipe_stages_a loop
--            if not ((wea_int = '1') AND (c_write_modea = c_no_change)) then
                pipelinea(0) <= DOUTA_prim;
--            end if;
              sub_rdy_a(0) <= new_data_a_q;
              -- end loop;
            END IF;
          END IF;
        END IF;
      END IF;  
    END IF;

  END PROCESS pipelinea_output;

--------- Output pipeline for Port B    --------------------------------------------------------------------

  pipelineb_output            : PROCESS (CLKB_ipd, WEB_ipd, ENB_ipd, SSRB_ipd, DIB_ipd, ADDRB_ipd, and_assignment)
    VARIABLE sinitb_value_int : std_logic_vector(c_width_b-1 DOWNTO 0);
    VARIABLE first_time_b     : boolean := TRUE;
  BEGIN

    IF (and_assignment = '1') THEN
      IF (first_time_b = TRUE ) THEN
        sinitb_value_int   := (others => '0');
        IF (c_has_sinitb = 1) THEN
          sinitb_value_int := hexstr_to_std_logic_vec(c_sinitb_value, c_width_b);
        END IF;
        FOR i IN 0 TO c_pipe_stages_b LOOP
          pipelineb(i) <= sinitb_value_int;
        END LOOP;
        FOR i IN 0 TO c_pipe_stages_b LOOP
          sub_rdy_b(i) <= '0';
        END LOOP;
        first_time_b       := FALSE;

      ELSE

        IF ( CLKB_ipd'event AND CLKB_ipd = '1') THEN
          IF (ENB_ipd = '1') THEN
            IF (SSRB_ipd = '1') THEN
              pipelineb(0) <= sinitb_value_int;
              sub_rdy_b(0) <= '0';
            ELSE
            -- for i in 0 to c_pipe_stages_b loop
--            if not ((web_int = '1') AND (c_write_modeb = c_no_change)) then            
                pipelineb(0) <= DOUTB_prim;
--            end if;
              sub_rdy_b(0) <= new_data_b_q;
            END IF;
          END IF;
        END IF;
      END IF;    
    END IF;

  END PROCESS pipelineb_output;

-------- Select pipelined output or non-pipelined outputs for port A  -----------------------------------


  select_outputa : PROCESS (new_data_a_q, DOUTA_prim, pipelinea, sub_rdy_a, and_assignment)
  BEGIN
    IF (and_assignment = '1') THEN
      IF (c_pipe_stages_a = 0) THEN
        DOUTA    <= DOUTA_prim;
        rdya_int <= new_data_a_q;
      ELSE
        DOUTA    <= pipelinea(c_pipe_stages_a - 1);
        rdya_int <= sub_rdy_a(c_pipe_stages_a - 1);
      END IF;    
    END IF;
  END PROCESS select_outputa;

-------- Select pipelined output or non-pipelined outputs for port B  -----------------------------------


  select_outputb : PROCESS (new_data_b_q, DOUTB_prim, pipelineb, sub_rdy_b)
  BEGIN
    IF (and_assignment = '1') THEN
      IF (c_pipe_stages_b = 0) THEN
        DOUTB    <= DOUTB_prim;
        rdyb_int <= new_data_b_q;
      ELSE
        DOUTB    <= pipelineb(c_pipe_stages_b - 1);
        rdyb_int <= sub_rdy_b(c_pipe_stages_b - 1);
      END IF;    
    END IF;
  END PROCESS select_outputb;

END behavioral;

