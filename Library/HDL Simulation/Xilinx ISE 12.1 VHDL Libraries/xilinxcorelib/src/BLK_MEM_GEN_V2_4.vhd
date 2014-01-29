-------------------------------------------------------------------------------
--
-- Block Memory Generator Core - Block Memory Behavioral Model
--
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under
-- license from Xilinx, Inc., and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid
-- license agreement with Xilinx, Inc. Xilinx hereby
-- grants you a license to use this text/file solely for
-- design, simulation, implementation and creation of
-- design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly
-- prohibited and immediately terminates your license unless
-- covered by a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as-is" solely for use in developing programs and
-- solutions for Xilinx devices, with no obligation on the
-- part of Xilinx to provide support. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for obtaining
-- any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
--
-- Any modifications that are made to the Source Code are
-- done at the user's sole risk and will be unsupported.
-- The Xilinx Support Hotline does not have access to source
-- code and therefore cannot answer specific questions related
-- to source HDL. The Xilinx Hotline support of original source
-- code IP shall only address issues and questions related
-- to the standard Netlist version of the core (and thus
-- indirectly, the original core source).
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
-- All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Filename: BLK_MEM_GEN_V2_4.vhd
--
-- Description:
--   This file is the VHDL behvarial model for the
--       Block Memory Generator Core.
--
-------------------------------------------------------------------------------
-- Author: Xilinx
--
-- History: January 11, 2006 Initial revision
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--  Output Stage Entity
-------------------------------------------------------------------------------

LIBRARY std;
USE std.textio.ALL;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BLK_MEM_GEN_V2_4_output_stage is
  generic (
    C_DATA_WIDTH  : integer := 32;
    C_HAS_SSR     : integer := 0;
    C_HAS_REGCE   : integer := 0;
    C_HAS_EN      : integer := 0;
    C_USE_ECC     : integer := 0;
    C_FAMILY      : string  := "virtex5";
    C_XDEVICEFAMILY : string  := "virtex5";
    C_USE_RAMB16BWER_RST_BHV : integer := 0;
    sinit_val     : std_logic_vector;
    num_stages    : integer := 1;
    flop_delay    : time    := 100 ps);
  port (
    CLK   : in  std_logic;
    SSR   : in  std_logic;
    REGCE : in  std_logic;
    EN    : in  std_logic;
    DIN   : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
    DOUT  : out std_logic_vector(C_DATA_WIDTH-1 downto 0));
end BLK_MEM_GEN_V2_4_output_stage;

architecture behavioral of BLK_MEM_GEN_V2_4_output_stage is

  function get_num_reg_stages(num_stages: integer) return integer is
    variable num_reg_stages : integer := 0;
  begin
    if (num_stages = 0) then
      num_reg_stages := 0;
    else
      num_reg_stages := num_stages - 1;
    end if;
    return num_reg_stages;
  end get_num_reg_stages;

  function int_to_bit(input: integer) return std_logic is
    variable temp_return : std_logic;
  begin
    if (input = 0) then
      temp_return := '0';
    else
      temp_return := '1';
    end if;
    return temp_return;
  end int_to_bit;

  function if_v4_bit(input: string) return std_logic is
    variable temp_return : std_logic;
  begin
    if (input = "virtex4") then
      temp_return := '1';
    else
      temp_return := '0';
    end if;
    return temp_return;
  end if_v4_bit;

  constant has_en     : std_logic := int_to_bit(C_HAS_EN);
  constant has_regce  : std_logic := int_to_bit(C_HAS_REGCE);
  constant has_ssr    : std_logic := int_to_bit(C_HAS_SSR);
  constant use_ecc    : std_logic := int_to_bit(C_USE_ECC);
  constant famv4      : std_logic := if_v4_bit(C_FAMILY);

  constant reg_stages : integer   := get_num_reg_stages(num_stages);

  type reg_array is array (reg_stages-1 downto 0) of
    std_logic_vector(C_DATA_WIDTH-1 downto 0);

  constant reg_init      : reg_array := (others => sinit_val);
  signal   out_regs      : reg_array := reg_init;

  -- internal signals
  signal en_i     : std_logic;
  signal regce_i  : std_logic;
  signal ssr_i    : std_logic;

  signal dout_i   : std_logic_vector(C_DATA_WIDTH-1 downto 0) := sinit_val;

begin

  -- assign the internal signals
  -----------------------------------------------
  -- This effectively wires off optional inputs
  -----------------------------------------------
  --Internal enable for output registers is tied to user EN or '1' depending
  -- on parameters
  -- For V4 ECC, EN is always 1
  -- Virtex4 ECC Not Yet Supported
  en_i    <= EN or (not has_en)
             or (famv4 and use_ecc);

  --Internal enable is tied to user REGCE, EN or '1' depending on parameters
  -- For V4 ECC, REGCE is always 1
  -- Virtex4 ECC Not Yet Supported
  regce_i <= (has_regce and REGCE)
             or ((not has_regce) and en_i)
             or (famv4 and use_ecc);

  --Internal SRR is tied to user SSR or '0' depending on parameters
  ssr_i   <= SSR and has_ssr;

  zero_stages: if (num_stages = 0) generate
    DOUT <= DIN;
  end generate zero_stages;


  one_stage_norm: if (num_stages = 1 and C_USE_RAMB16BWER_RST_BHV=0) generate
    DOUT <= dout_i;

    process (CLK)
    begin
      if (CLK='1' and CLK'event) then
           if (ssr_i='1' and regce_i='1') then
             dout_i <= sinit_val after flop_delay;
           elsif (regce_i='1') then
             dout_i <= DIN after flop_delay;
           end if;
      end if;
    end process;
  end generate one_stage_norm;

  one_stage_s3ax: if (num_stages = 1 and C_USE_RAMB16BWER_RST_BHV=1) generate
    DOUT <= dout_i;

    process (CLK)
    begin
      if (CLK='1' and CLK'event) then
           if (ssr_i='1' and en_i='1') then
             dout_i <= sinit_val after flop_delay;
           elsif (regce_i='1') then
             dout_i <= DIN after flop_delay;
           end if;
      end if;
    end process;
  end generate one_stage_s3ax;

  multi_stage: if (num_stages > 1) generate
    DOUT <= dout_i;

    process (CLK)
    begin
      if (CLK='1' and CLK'event) then
           if (ssr_i='1'and regce_i='1') then
              dout_i <= sinit_val after flop_delay;
           elsif (regce_i='1') then
              dout_i <= out_regs(reg_stages-1) after flop_delay;
           end if;

        if (en_i='1') then
          -- Shift the data through the output stages
          for i in 1 to reg_stages-1 loop
            out_regs(i) <= out_regs(i-1) after flop_delay;
          end loop;
          out_regs(0) <= DIN;
        end if;
      end if;
    end process;
  end generate multi_stage;

end behavioral;

-------------------------------------------------------------------------------
--  Top-level Entity
-------------------------------------------------------------------------------

LIBRARY std;
USE std.textio.ALL;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BLK_MEM_GEN_V2_4 is
  generic (
    C_ADDRA_WIDTH             : integer := 6;
    C_ADDRB_WIDTH             : integer := 6;
    C_ALGORITHM               : integer := 2;
    C_BYTE_SIZE               : integer := 8;
    C_COMMON_CLK              : integer := 1;
    C_DEFAULT_DATA            : string  := "";
    C_DISABLE_WARN_BHV_COLL   : integer := 0;
    C_DISABLE_WARN_BHV_RANGE  : integer := 0;
    C_FAMILY                  : string  := "virtex4";
    C_XDEVICEFAMILY           : string  := "virtex4";
    C_HAS_ENA                 : integer := 1;
    C_HAS_ENB                 : integer := 1;
    C_HAS_MEM_OUTPUT_REGS     : integer := 0;
    C_HAS_MUX_OUTPUT_REGS     : integer := 0;
    C_HAS_REGCEA              : integer := 0;
    C_HAS_REGCEB              : integer := 0;
    C_HAS_SSRA                : integer := 0;
    C_HAS_SSRB                : integer := 0;
    C_INIT_FILE_NAME          : string  := "";
    C_LOAD_INIT_FILE          : integer := 0;
    C_MEM_TYPE                : integer := 2;
    C_PRIM_TYPE               : integer := 3;
    C_READ_DEPTH_A            : integer := 64;
    C_READ_DEPTH_B            : integer := 64;
    C_READ_WIDTH_A            : integer := 32;
    C_READ_WIDTH_B            : integer := 32;
    C_SIM_COLLISION_CHECK     : string  := "NONE";
    C_SINITA_VAL              : string  := "";
    C_SINITB_VAL              : string  := "";
    C_USE_BYTE_WEA            : integer := 0;
    C_USE_BYTE_WEB            : integer := 0;
    C_USE_DEFAULT_DATA        : integer := 0;
    C_USE_ECC                 : integer := 0;
    C_WEA_WIDTH               : integer := 1;
    C_WEB_WIDTH               : integer := 1;
    C_WRITE_DEPTH_A           : integer := 64;
    C_WRITE_DEPTH_B           : integer := 64;
    C_WRITE_MODE_A            : string  := "WRITE_FIRST";
    C_WRITE_MODE_B            : string  := "WRITE_FIRST";
    C_WRITE_WIDTH_A           : integer := 32;
    C_WRITE_WIDTH_B           : integer := 32;
    C_CORENAME                : string  := "blk_mem_gen_v2_4";
    C_USE_RAMB16BWER_RST_BHV  : INTEGER := 0);
  port (
    CLKA   : in  std_logic;
    DINA   : in  std_logic_vector(C_WRITE_WIDTH_A-1 downto 0)
           := (OTHERS => '0');
    ADDRA  : in  std_logic_vector(C_ADDRA_WIDTH-1 downto 0);
    ENA    : in  std_logic := '1';
    REGCEA : in  std_logic := '1';
    WEA    : in  std_logic_vector(C_WEA_WIDTH-1 downto 0)
           := (OTHERS => '0');
    SSRA   : in  std_logic := '0';
    DOUTA  : out std_logic_vector(C_READ_WIDTH_A-1 downto 0);
    CLKB   : in  std_logic := '0';
    DINB   : in  std_logic_vector(C_WRITE_WIDTH_B-1 downto 0)
           := (OTHERS => '0');
    ADDRB  : in  std_logic_vector(C_ADDRB_WIDTH-1 downto 0)
           := (OTHERS => '0');
    ENB    : in  std_logic := '1';
    REGCEB : in  std_logic := '1';
    WEB    : in  std_logic_vector(C_WEB_WIDTH-1 downto 0)
           := (OTHERS => '0');
    SSRB   : in  std_logic := '0';
    DOUTB  : out std_logic_vector(C_READ_WIDTH_B-1 downto 0);
    DBITERR : out std_logic;
    SBITERR : out std_logic
    );
end BLK_MEM_GEN_V2_4;

architecture behavioral of BLK_MEM_GEN_V2_4 is

  -- min/max constant functions
  -------------------------------
  function get_max(a: integer; b: integer) return integer is
  begin
    if (a > b) then
      return a;
    else
      return b;
    end if;
  end function;

  function get_min(a: integer; b: integer) return integer is
  begin
    if (a < b) then
      return a;
    else
      return b;
    end if;
  end function;

  -- convert write_mode from string type for use in case statement
  ------------------------------------------------------------------
  function write_mode_to_vector(mode: string) return std_logic_vector is
  begin
    if (mode = "NO_CHANGE") then
      return "10";
    elsif (mode = "READ_FIRST") then
      return "01";
    else
      return "00";  -- WRITE_FIRST
    end if;
  end function;

  -- convert hex string to std_logic_vector
  -------------------------------------------
  function hex_to_std_logic_vector(
    hex_str       : string;
    return_width  : integer)
  return std_logic_vector is
    variable tmp        : std_logic_vector((hex_str'length*4)+return_width-1 downto 0);

   begin


    tmp := (others => '0');
    for i in 1 to hex_str'length loop
      case hex_str((hex_str'length+1)-i) is
        when '0' => tmp(i*4-1 downto (i-1)*4) := "0000";
        when '1' => tmp(i*4-1 downto (i-1)*4) := "0001";
        when '2' => tmp(i*4-1 downto (i-1)*4) := "0010";
        when '3' => tmp(i*4-1 downto (i-1)*4) := "0011";
        when '4' => tmp(i*4-1 downto (i-1)*4) := "0100";
        when '5' => tmp(i*4-1 downto (i-1)*4) := "0101";
        when '6' => tmp(i*4-1 downto (i-1)*4) := "0110";
        when '7' => tmp(i*4-1 downto (i-1)*4) := "0111";
        when '8' => tmp(i*4-1 downto (i-1)*4) := "1000";
        when '9' => tmp(i*4-1 downto (i-1)*4) := "1001";
        when 'a' | 'A' => tmp(i*4-1 downto (i-1)*4) := "1010";
        when 'b' | 'B' => tmp(i*4-1 downto (i-1)*4) := "1011";
        when 'c' | 'C' => tmp(i*4-1 downto (i-1)*4) := "1100";
        when 'd' | 'D' => tmp(i*4-1 downto (i-1)*4) := "1101";
        when 'e' | 'E' => tmp(i*4-1 downto (i-1)*4) := "1110";
        when 'f' | 'F' => tmp(i*4-1 downto (i-1)*4) := "1111";
        when others  =>  tmp(i*4-1 downto (i-1)*4) := "1111";
      end case;
    end loop;
    return tmp(return_width-1 downto 0);
  end hex_to_std_logic_vector;

  -- convert bit to std_logic
  -----------------------------
  function bit_to_sl(input: bit) return std_logic is
    variable temp_return : std_logic;
  begin
    if (input = '0') then
      temp_return := '0';
    else
      temp_return := '1';
    end if;
    return temp_return;
  end bit_to_sl;

  -- locally derived constants to determine memory shape
  -------------------------------------------------------
  constant min_width_a : integer := get_min(C_WRITE_WIDTH_A, C_READ_WIDTH_A);
  constant min_width_b : integer := get_min(C_WRITE_WIDTH_B,C_READ_WIDTH_B);
  constant min_width   : integer := get_min(min_width_a, min_width_b);

  constant max_width_a : integer := get_max(C_WRITE_WIDTH_A, C_READ_WIDTH_A);
  constant max_width_b : integer := get_max(C_WRITE_WIDTH_B, C_READ_WIDTH_B);
  constant max_width   : integer := get_max(max_width_a, max_width_b);

  constant max_depth_a : integer := get_max(C_WRITE_DEPTH_A, C_READ_DEPTH_A);
  constant max_depth_b : integer := get_max(C_WRITE_DEPTH_B, C_READ_DEPTH_B);
  constant max_depth   : integer := get_max(max_depth_a, max_depth_b);

  -- the memory type
  type mem_array is array (max_depth-1 downto 0) of
    std_logic_vector(min_width-1 downto 0);

  -- memory initialization function
  --------------------------------------------
  function init_memory(default_data  :
                       std_logic_vector(C_WRITE_WIDTH_A-1 downto 0);
                       write_width_a : integer;
                       depth         : integer;
                       width         : integer)
  return mem_array is
  variable init_return   : mem_array := (others => (others => '0'));
  file     init_file     : text;
  variable mem_vector    : bit_vector(write_width_a-1 downto 0);
  variable file_buffer   : line;
  variable i             : integer;
  variable j             : integer;
  variable index         : integer;
  begin

    --Display output message indicating that the behavioral model is being initialized
    assert (not (C_USE_DEFAULT_DATA=1 or C_LOAD_INIT_FILE=1)) report " Block Memory Generator CORE Generator module loading initial data..." severity NOTE;

    -- Setup the default data
    -- Default data is with respect to write_port_A and may be wider
    -- or narrower than init_return width.  The following loops map
    -- default data into the memory
    if (C_USE_DEFAULT_DATA=1) then
      index := 0;
      for i in 0 to depth-1 loop
        for j in 0 to width-1 loop
          init_return(i)(j) := default_data(index);
          index := (index + 1) mod C_WRITE_WIDTH_A;
        end loop;
      end loop;
    end if;

    -- Read in the .mif file
    -- The init data is formatted with respect to write port A dimensions.
    -- The init_return vector is formatted with respect to minimum width and
    -- maximum depth; the following loops map the .mif file into the memory
    if (C_LOAD_INIT_FILE=1) then
      file_open(init_file, C_INIT_FILE_NAME, read_mode);
      i := 0;
      while (i < depth and not endfile(init_file)) loop
        mem_vector := (others => '0');
        readline(init_file, file_buffer);
        read(file_buffer, mem_vector(file_buffer'length-1 downto 0));
        for j in 0 to write_width_a-1 loop
          if (j mod width = 0 and j /= 0) then
            i := i + 1;
          end if;
          init_return(i)(j mod width) := bit_to_sl(mem_vector(j));
        end loop;
        i := i + 1;
      end loop;
      file_close(init_file);
    end if;
    return init_return;

    --Display output message indicating that the behavioral model is done initializing
    assert (not (C_USE_DEFAULT_DATA=1 or C_LOAD_INIT_FILE=1)) report " Block Memory Generator data initialization complete." severity NOTE;

  end function;

  -- memory type constants
  -----------------------------------
  constant mem_type_sp_ram   : integer := 0;
  constant mem_type_sdp_ram  : integer := 1;
  constant mem_type_tdp_ram  : integer := 2;
  constant mem_type_sp_rom   : integer := 3;
  constant mem_type_dp_rom   : integer := 4;

  -- memory configuration constant functions
  --------------------------------------------
  function get_single_port(mem_type : integer) return integer is
  begin
    if (mem_type=mem_type_sp_ram or mem_type=mem_type_sp_rom) then
      return 1;
    else
      return 0;
    end if;
  end get_single_port;

  function get_is_rom(mem_type : integer) return integer is
  begin
    if (mem_type=mem_type_sp_rom or mem_type=mem_type_dp_rom) then
      return 1;
    else
      return 0;
    end if;
  end get_is_rom;

  function get_has_a_write(is_rom : integer) return integer is
  begin
    if (is_rom=0) then
      return 1;
    else
      return 0;
    end if;
  end get_has_a_write;

  function get_has_b_write(mem_type : integer) return integer is
  begin
    if (mem_type=mem_type_tdp_ram) then
      return 1;
    else
      return 0;
    end if;
  end get_has_b_write;

  function get_has_a_read(mem_type : integer) return integer is
  begin
    if (mem_type=mem_type_sdp_ram) then
      return 0;
    else
      return 1;
    end if;
  end get_has_a_read;

  function get_has_b_read(single_port : integer) return integer is
  begin
    if (single_port=1) then
      return 0;
    else
      return 1;
    end if;
  end get_has_b_read;

  function get_has_b_port(has_b_read  : integer;
                          has_b_write : integer)
  return integer is
  begin
    if (has_b_read=1 or has_b_write=1) then
      return 1;
    else
      return 0;
    end if;
  end get_has_b_port;

  function get_num_output_stages(has_mem_output_regs : integer;
                                 has_mux_output_regs : integer;
                                 c_family            : string;
                                 use_ecc             :integer)
  return integer is
  begin
    -- Virtex4 ECC Not Yet Supported
    if (c_family="virtex4" and use_ecc=1) then
      return has_mem_output_regs + has_mux_output_regs + 1;
    else
      return has_mem_output_regs + has_mux_output_regs;
    end if;
  end get_num_output_stages;

  component BLK_MEM_GEN_V2_4_output_stage
    generic (
      C_DATA_WIDTH  : integer := 32;
      C_HAS_SSR     : integer := 0;
      C_HAS_REGCE   : integer := 0;
      C_HAS_EN      : integer := 0;
      C_USE_ECC     : integer := 0;
      C_FAMILY      : string  := "virtex5";
      C_XDEVICEFAMILY : string  := "virtex5";
      C_USE_RAMB16BWER_RST_BHV : integer := 0;
      sinit_val     : std_logic_vector;
      num_stages    : integer := 1;
      flop_delay    : time    := 100 ps);
    port (
      CLK   : in  std_logic;
      SSR   : in  std_logic;
      REGCE : in  std_logic;
      EN    : in  std_logic;
      DIN   : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
      DOUT  : out std_logic_vector(C_DATA_WIDTH-1 downto 0));
  end component BLK_MEM_GEN_V2_4_output_stage;

  -- other constants
  --------------------------------------------------------
  constant coll_delay : time := 2 ns;

  -- locally derived constants to assist memory access
  ------------------------------------------------------
  constant write_width_ratio_a : integer := C_WRITE_WIDTH_A/min_width;
  constant read_width_ratio_a  : integer := C_READ_WIDTH_A/min_width;
  constant write_width_ratio_b : integer := C_WRITE_WIDTH_B/min_width;
  constant read_width_ratio_b  : integer := C_READ_WIDTH_B/min_width;

  -- To modify the LSBs of the 'wider' data to the actual
  --    address value
  -------------------------------------------------------
  constant write_addr_a_div  : integer := C_WRITE_WIDTH_A/min_width_a;
  constant read_addr_a_div   : integer := C_READ_WIDTH_A/min_width_a;
  constant write_addr_b_div  : integer := C_WRITE_WIDTH_B/min_width_b;
  constant read_addr_b_div   : integer := C_READ_WIDTH_B/min_width_b;

  -----------------------------------------------------------------------------
  -- FUNCTION : log2roundup
  -----------------------------------------------------------------------------
  FUNCTION log2roundup (
    data_value : integer)
  RETURN integer IS

    VARIABLE width       : integer := 0;
    VARIABLE cnt         : integer := 1;

  BEGIN
    IF (data_value <= 1) THEN
      width   := 0;
    ELSE
      WHILE (cnt < data_value) LOOP
        width := width + 1;
        cnt   := cnt *2;
      END LOOP;
    END IF;

    RETURN width;
  END log2roundup;


  -- default data vector
  constant default_data  : std_logic_vector(C_WRITE_WIDTH_A-1 downto 0)
    := hex_to_std_logic_vector(C_DEFAULT_DATA,
                               C_WRITE_WIDTH_A);

 -- the memory signal
  signal memory_i       : mem_array;

  -- write mode constants
  constant write_mode_a : std_logic_vector(1 downto 0) :=
    write_mode_to_vector(C_WRITE_MODE_A);
  constant write_mode_b : std_logic_vector(1 downto 0) :=
    write_mode_to_vector(C_WRITE_MODE_B);
  constant write_modes  : std_logic_vector(3 downto 0) :=
    write_mode_a & write_mode_b;

  -- reset values
  constant sinita_val  : std_logic_vector(C_READ_WIDTH_A-1 downto 0)
    := hex_to_std_logic_vector(C_SINITA_VAL,
                               C_READ_WIDTH_A);

  constant sinitb_val  : std_logic_vector(C_READ_WIDTH_B-1 downto 0)
    := hex_to_std_logic_vector(C_SINITB_VAL,
                               C_READ_WIDTH_B);
  -- memory output 'latches'
  signal memory_out_a : std_logic_vector(C_READ_WIDTH_A-1 downto 0) :=
    sinita_val;
  signal memory_out_b : std_logic_vector(C_READ_WIDTH_B-1 downto 0) :=
    sinitb_val;

  -- memory configuration constants
  -----------------------------------------------
  constant flop_delay  : time    := 100 ps;
  constant single_port : integer := get_single_port(C_MEM_TYPE);
  constant is_rom      : integer := get_is_rom(C_MEM_TYPE);
  constant has_a_write : integer := get_has_a_write(is_rom);
  constant has_b_write : integer := get_has_b_write(C_MEM_TYPE);
  constant has_a_read  : integer := get_has_a_read(C_MEM_TYPE);
  constant has_b_read  : integer := get_has_b_read(single_port);
  constant has_b_port  : integer := get_has_b_port(has_b_read, has_b_write);
  constant num_output_stages : integer :=
    get_num_output_stages(C_HAS_MEM_OUTPUT_REGS, C_HAS_MUX_OUTPUT_REGS, C_FAMILY, C_USE_ECC);

  constant wea0  : std_logic_vector(C_WEA_WIDTH-1 downto 0) := (others => '0');
  constant web0  : std_logic_vector(C_WEB_WIDTH-1 downto 0) := (others => '0');

  -- internal signals
  -----------------------------------------------
  signal ena_i    : std_logic;
  signal enb_i    : std_logic;
  signal reseta_i : std_logic;
  signal resetb_i : std_logic;
  signal wea_i    : std_logic_vector(C_WEA_WIDTH-1 downto 0);
  signal web_i    : std_logic_vector(C_WEB_WIDTH-1 downto 0);
  signal rea_i    : std_logic;
  signal reb_i    : std_logic;

  signal message_complete : boolean := false;

  -- detect overlapping addresses
  -------------------------------
  function collision_check (addr_a    :
                            std_logic_vector(C_ADDRA_WIDTH-1 downto 0);
                            iswrite_a : boolean;
                            addr_b    :
                            std_logic_vector(C_ADDRB_WIDTH-1 downto 0);
                            iswrite_b : boolean)
    return boolean is
    variable base_addr_a    : integer;
    variable base_addr_b    : integer;
    variable ratio_a        : integer;
    variable ratio_b        : integer;
    variable lo_addr_wider  : integer;
    variable hi_addr_wider  : integer;
    variable lo_addr_narrow : integer;
    variable hi_addr_narrow : integer;
    variable temp_return    : boolean;
    variable c_aw_bw        : integer;
    variable c_aw_br        : integer;
    variable c_ar_bw        : integer;
    variable write_addr_a_width : integer;
    variable read_addr_a_width  : integer;
    variable write_addr_b_width : integer;
    variable read_addr_b_width  : integer;
  begin
    c_aw_bw := 0;
    c_aw_br := 0;
    c_ar_bw := 0;

    -- Determine the effective address widths for each of the 4 ports
    write_addr_a_width := C_ADDRA_WIDTH-log2roundup(write_addr_a_div);
    read_addr_a_width  := C_ADDRA_WIDTH-log2roundup(read_addr_a_div);
    write_addr_b_width := C_ADDRB_WIDTH-log2roundup(write_addr_b_div);
    read_addr_b_width  := C_ADDRB_WIDTH-log2roundup(read_addr_b_div);


    --Look for a write-write collision. In order for a write-write
    --collision to exist, both ports must have a write transaction.
    if (iswrite_a and iswrite_b) then
      if (write_addr_a_width > write_addr_b_width) then
        --write_addr_b_width is smaller, so scale both addresses to that
        -- width for comparing write_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        -- scale it down to write_addr_b_width
        --addr_b starts as C_ADDRB_WIDTH,
        -- scale it down to write_addr_b_width
        --Once both are scaled to write_addr_b_width, compare.
        if ((conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_b_width)) = (conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_b_width))) then
          c_aw_bw := 1;
        else
          c_aw_bw := 0;
        end if;
      else
        --write_addr_a_width is smaller, so scale both addresses to that
        -- width for comparing write_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        -- scale it down to write_addr_a_width
        --addr_b starts as C_ADDRB_WIDTH,
        -- scale it down to write_addr_a_width
        --Once both are scaled to write_addr_a_width, compare.
        if ((conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_a_width)) = (conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_a_width))) then
          c_aw_bw := 1;
        else
          c_aw_bw := 0;
        end if;
      end if; --width
    end if; --iswrite_a and iswrite_b

    --If the B port is reading (which means it is enabled - so could be
    -- a TX_WRITE or TX_READ), then check for a write-read collision).
    --This could happen whether or not a write-write collision exists due
    --  to asymmetric write/read ports.
    if (iswrite_a) then
      if (write_addr_a_width > read_addr_b_width) then
        --read_addr_b_width is smaller, so scale both addresses to that
        --  width for comparing write_addr_a and read_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to read_addr_b_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to read_addr_b_width
        --Once both are scaled to read_addr_b_width, compare.
        if ((conv_integer(addr_a)/2**(C_ADDRA_WIDTH-read_addr_b_width)) = (conv_integer(addr_b)/2**(C_ADDRB_WIDTH-read_addr_b_width))) then
          c_aw_br := 1;
        else
          c_aw_br := 0;
        end if;
    else
        --write_addr_a_width is smaller, so scale both addresses to that
        --  width for comparing write_addr_a and read_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to write_addr_a_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to write_addr_a_width
        --Once both are scaled to write_addr_a_width, compare.
        if ((conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_a_width)) = (conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_a_width))) then
          c_aw_br := 1;
        else
          c_aw_br := 0;
        end if;
      end if; --width
    end if; --iswrite_a

    --If the A port is reading (which means it is enabled - so could be
    --  a TX_WRITE or TX_READ), then check for a write-read collision).
    --This could happen whether or not a write-write collision exists due
    --  to asymmetric write/read ports.
    if (iswrite_b) then
      if (read_addr_a_width > write_addr_b_width) then
        --write_addr_b_width is smaller, so scale both addresses to that
        --  width for comparing read_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to write_addr_b_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to write_addr_b_width
        --Once both are scaled to write_addr_b_width, compare.
        if ((conv_integer(addr_a)/2**(C_ADDRA_WIDTH-write_addr_b_width)) = (conv_integer(addr_b)/2**(C_ADDRB_WIDTH-write_addr_b_width))) then
          c_ar_bw := 1;
        else
          c_ar_bw := 0;
        end if;
      else
        --read_addr_a_width is smaller, so scale both addresses to that
        --  width for comparing read_addr_a and write_addr_b
        --addr_a starts as C_ADDRA_WIDTH,
        --  scale it down to read_addr_a_width
        --addr_b starts as C_ADDRB_WIDTH,
        --  scale it down to read_addr_a_width
        --Once both are scaled to read_addr_a_width, compare.
        if ((conv_integer(addr_b)/2**(C_ADDRB_WIDTH-read_addr_a_width)) = (conv_integer(addr_a)/2**(C_ADDRA_WIDTH-read_addr_a_width))) then
          c_ar_bw := 1;
        else
          c_ar_bw := 0;
        end if;
      end if; --width
    end if; --iswrite_b


    -- Convert the input addresses in base and offsets for our
    --   memory array. Ignore LSBs for asymmetric ports
    if (iswrite_a) then
      base_addr_a := (conv_integer(addr_a)/write_addr_a_div) * write_addr_a_div;
      ratio_a     := write_width_ratio_a;
    else
      base_addr_a := (conv_integer(addr_a)/read_addr_a_div) *  read_addr_a_div;
      ratio_a     := read_width_ratio_a;
    end if;

    if (iswrite_b) then
      base_addr_b := (conv_integer(addr_b)/write_addr_b_div) * write_addr_b_div;
      ratio_b     := write_width_ratio_b;
    else
      base_addr_b := (conv_integer(addr_b)/read_addr_b_div) *  read_addr_b_div;
      ratio_b     := read_width_ratio_b;
    end if;

    -- Determine the wider port, and normalized ranges
    if (ratio_a >= ratio_b) then
      lo_addr_wider  := base_addr_a * ratio_a;
      hi_addr_wider  := lo_addr_wider + ratio_a;
      lo_addr_narrow := base_addr_b * ratio_b;
      hi_addr_narrow := lo_addr_narrow + ratio_b;
    else
      lo_addr_wider  := base_addr_b * ratio_b;
      hi_addr_wider  := lo_addr_wider + ratio_b;
      lo_addr_narrow := base_addr_a * ratio_a;
      hi_addr_narrow := lo_addr_narrow + ratio_a;
    end if;

    -- compare the two ranges of address (narrow inside wider)
    if ((lo_addr_narrow >= lo_addr_wider) and
        (hi_addr_narrow <= hi_addr_wider)) then
      temp_return := true;
    else
      temp_return := false;
    end if;

    return (c_aw_bw=1 or c_aw_br=1 or c_ar_bw=1);
    --return temp_return;
  end function collision_check;

begin -- Architecture

  -----------------------------------------------------------------------------
  -- ECC SBITERR/DBITERR Outputs
  --  The ECC Behavior is not modeled by the behavioral models, therefore
  -- the SBITERR and DBITERR outputs are explicitly tied to 0.
  -----------------------------------------------------------------------------
  SBITERR <= '0';
  DBITERR <= '0';

  -----------------------------------------------
  -- This effectively wires off optional inputs
  -----------------------------------------------
  ena_i    <= ENA when (C_HAS_ENA=1) else '1';
  enb_i    <= ENB when (C_HAS_ENB=1   and has_b_port=1) else '1';
  wea_i    <= WEA when (has_a_write=1 and ena_i='1')    else wea0;
  web_i    <= WEB when (has_b_write=1 and enb_i='1')    else web0;
  rea_i    <= ena_i when (has_a_read=1) else '0';
  reb_i    <= enb_i when (has_b_read=1) else '0';

  -- these signals reset the memory latches
  reseta_i <= SSRA when
              ((C_HAS_SSRA=1 and ena_i='1' and num_output_stages=0) or                          (C_HAS_SSRA=1 and ena_i='1' and C_USE_RAMB16BWER_RST_BHV=1) )
               else '0';
  resetb_i <= SSRB when
              ((C_HAS_SSRB=1 and enb_i='1' and num_output_stages=0) or                          (C_HAS_SSRB=1 and enb_i='1' and C_USE_RAMB16BWER_RST_BHV=1) )
               else '0';

  ---------------------------------------------------------------------------
  -- This is the main process which includes the memory variable and the read
  -- and write procedures.  It also schedules read and write operations
  ---------------------------------------------------------------------------
  process (CLKA, CLKB)

  -- Initialize the memory array
  ------------------------------------
  variable memory         : mem_array := init_memory(default_data,
                                                     C_WRITE_WIDTH_A,
                                                     max_depth,
                                                     min_width);

  -- procedures to access the memory
  ------------------------------------
  procedure write_a
    (addr    : in std_logic_vector(C_ADDRA_WIDTH-1 downto 0);
     byte_en : in std_logic_vector(C_WEA_WIDTH-1 downto 0);
     data    : in std_logic_vector(C_WRITE_WIDTH_A-1 downto 0)) is
  variable current_contents : std_logic_vector(C_WRITE_WIDTH_A-1 downto 0);
  variable address_i        : integer;
  variable i                : integer;
  begin

    -- Block Memory Generator non-cycle-accurate message
    assert (message_complete) report "Block Memory Generator CORE Generator module is using a behavioral model for simulation which will not precisely model memory collision behavior." severity NOTE;
    message_complete <= true;


    -- Shift the address by the ratio
    address_i := (conv_integer(addr)/write_addr_a_div);

    if (address_i >= C_WRITE_DEPTH_A) then
      if (C_DISABLE_WARN_BHV_RANGE = 0) then
        assert FALSE
          report C_CORENAME & " WARNING: Address " &
          integer'image(conv_integer(addr)) & " is outside range for A Write"
          severity warning;
      end if;

      -- valid address
    else

      -- Combine w/ byte writes
      if (C_USE_BYTE_WEA = 1) then

        -- Get the current memory contents
        for i in 0 to write_width_ratio_a-1 loop
          current_contents(min_width*(i+1)-1 downto min_width*i)
            := memory(address_i*write_width_ratio_a + i);
        end loop;

        -- Apply incoming bytes
        for i in 0 to C_WEA_WIDTH-1 loop
          if (byte_en(i) = '1') then
            current_contents(C_BYTE_SIZE*(i+1)-1 downto C_BYTE_SIZE*i)
              := data(C_BYTE_SIZE*(i+1)-1 downto C_BYTE_SIZE*i);
          end if;
        end loop;

      -- No byte-writes, overwrite the whole word
      else
        current_contents := data;
      end if;

      -- Write data to memory
      for i in 0 to write_width_ratio_a-1 loop
        memory(address_i*write_width_ratio_a + i) :=
          current_contents(min_width*(i+1)-1 downto min_width*i);
      end loop;

    end if;
  end procedure;

  procedure write_b
    (addr    : in std_logic_vector(C_ADDRB_WIDTH-1 downto 0);
     byte_en : in std_logic_vector(C_WEB_WIDTH-1 downto 0);
     data    : in std_logic_vector(C_WRITE_WIDTH_B-1 downto 0)) is
  variable current_contents : std_logic_vector(C_WRITE_WIDTH_B-1 downto 0);
  variable address_i        : integer;
  variable i                : integer;
  begin
    -- Shift the address by the ratio
    address_i := (conv_integer(addr)/write_addr_b_div);
    if (address_i >= C_WRITE_DEPTH_B) then
      if (C_DISABLE_WARN_BHV_RANGE = 0) then
        assert FALSE
          report C_CORENAME & " WARNING: Address " &
          integer'image(conv_integer(addr)) & " is outside range for B Write"
          severity warning;
      end if;

    -- valid address
    else

      -- Combine w/ byte writes
      if (C_USE_BYTE_WEB = 1) then

        -- Get the current memory contents
        for i in 0 to write_width_ratio_b-1 loop
          current_contents(min_width*(i+1)-1 downto min_width*i)
            := memory(address_i*write_width_ratio_b + i);
        end loop;

        -- Apply incoming bytes
        for i in 0 to C_WEB_WIDTH-1 loop
          if (byte_en(i) = '1') then
            current_contents(C_BYTE_SIZE*(i+1)-1 downto C_BYTE_SIZE*i)
              := data(C_BYTE_SIZE*(i+1)-1 downto C_BYTE_SIZE*i);
          end if;
        end loop;

      -- No byte-writes, overwrite the whole word
      else
        current_contents := data;
      end if;

      -- Write data to memory
      for i in 0 to write_width_ratio_b-1 loop
        memory(address_i*write_width_ratio_b + i) :=
          current_contents(min_width*(i+1)-1 downto min_width*i);
      end loop;

    end if;
  end procedure;

  procedure read_a
    (addr  : in std_logic_vector(C_ADDRA_WIDTH-1 downto 0);
     reset : in std_logic) is
  variable address_i : integer;
  variable i         : integer;
  begin

    if (reset = '1') then
      memory_out_a <= sinita_val after flop_delay;
    else
      -- Shift the address by the ratio
      address_i := (conv_integer(addr)/read_addr_a_div);

      if (address_i >= C_READ_DEPTH_A) then
        if (C_DISABLE_WARN_BHV_RANGE=0) then
          assert FALSE
            report C_CORENAME & " WARNING: Address " &
            integer'image(conv_integer(addr)) & " is outside range for A Read"
            severity warning;
        end if;

        -- valid address
      else

        -- Increment through the 'partial' words in the memory
        for i in 0 to read_width_ratio_a-1 loop
          memory_out_a(min_width*(i+1)-1 downto min_width*i) <=
            memory(address_i*read_width_ratio_a + i) after flop_delay;
        end loop;

      end if;
    end if;
  end procedure;

  procedure read_b
    (addr  : in std_logic_vector(C_ADDRB_WIDTH-1 downto 0);
     reset : in std_logic) is
  variable address_i : integer;
  variable i         : integer;
  begin

    if (reset = '1') then
      memory_out_b <= sinitb_val after flop_delay;
    else
      -- Shift the address by the ratio
      address_i := (conv_integer(addr)/read_addr_b_div);
      if (address_i >= C_READ_DEPTH_B) then
        if (C_DISABLE_WARN_BHV_RANGE=0) then
          assert FALSE
            report C_CORENAME & " WARNING: Address " &
            integer'image(conv_integer(addr)) & " is outside range for B Read"
            severity warning;
        end if;

        -- valid address
      else

        -- Increment through the 'partial' words in the memory
        for i in 0 to read_width_ratio_b-1 loop
          memory_out_b(min_width*(i+1)-1 downto min_width*i) <=
            memory(address_i*read_width_ratio_b + i) after flop_delay;
        end loop;

      end if;
    end if;
  end procedure;

  begin  -- begin the main process

    -- Synchronous clocks: schedule port operations with respect to both
    -- write operating modes
    if (C_COMMON_CLK=1) then
      if (CLKA='1' and CLKA'event) then
        case write_modes is
          when "0000" =>  -- write_first write_first
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;

          when "0100" =>  -- read_first write_first
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;

          when "0001" =>  -- write_first read_first
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;

          when "0101" =>  --read_first read_first
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;

          when "0010" =>  -- write_first no_change
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if ((reb_i='1' and web_i=web0) or resetb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;

          when "0110" =>  -- read_first no_change
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if ((reb_i='1' and web_i=web0) or resetb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;

          when "1000" =>  -- no_change write_first
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if ((rea_i='1' and wea_i=wea0) or reseta_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;

          when "1001" =>  -- no_change read_first
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
            if ((rea_i='1' and wea_i=wea0) or reseta_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;

          when "1010" =>  -- no_change no_change
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if ((rea_i='1' and wea_i=wea0) or reseta_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if ((reb_i='1' and web_i=web0) or resetb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;

          when others =>
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
        end case;
      end if;
    end if;  -- Synchronous clocks

    -- Asynchronous clocks: port operation is independent
    if (C_COMMON_CLK=0) then
      if (CLKA='1' and CLKA'event) then
        case write_mode_a is
          when "00" =>  -- write_first
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;

          when "01" =>  -- read_first
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;

          when "10" =>  -- no_change
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if ((rea_i='1' and wea_i=wea0) or reseta_i='1') then
              read_a(ADDRA, reseta_i);
            end if;

          when others =>
            if (wea_i/=wea0) then
              write_a(ADDRA, wea_i, DINA);
            end if;
            if (rea_i='1') then
              read_a(ADDRA, reseta_i);
            end if;
        end case;
      end if;
      if (CLKB='1' and CLKB'event) then
        case write_mode_b is
          when "00" =>  -- write_first
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
          when "01" =>  -- read_first
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;

          when "10" =>  -- no_change
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if ((reb_i='1' and web_i=web0) or resetb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;

          when others =>
            if (web_i/=web0) then
              write_b(ADDRB, web_i, DINB);
            end if;
            if (reb_i='1') then
              read_b(ADDRB, resetb_i);
            end if;
        end case;
      end if;
    end if;  -- Asynchronous clocks

    -- Assign the memory variable to the user_visible memory_i signal
    memory_i <= memory;

  end process;

  -- Variable depth output stage per port
  -----------------------------------------
  reg_a : BLK_MEM_GEN_V2_4_output_stage
    generic map(
      C_DATA_WIDTH  => C_READ_WIDTH_A,
      C_HAS_SSR     => C_HAS_SSRA,
      C_HAS_REGCE   => C_HAS_REGCEA,
      C_HAS_EN      => C_HAS_ENA,
      C_USE_ECC     => C_USE_ECC,
      C_FAMILY      => C_FAMILY,
      C_XDEVICEFAMILY => C_XDEVICEFAMILY,
      C_USE_RAMB16BWER_RST_BHV => C_USE_RAMB16BWER_RST_BHV,
      sinit_val     => sinita_val,
      num_stages    => num_output_stages,
      flop_delay    => flop_delay)
    port map (
      CLK    => CLKA,
      SSR    => SSRA,
      REGCE  => REGCEA,
      EN     => ENA,
      DIN    => memory_out_a,
      DOUT   => DOUTA);

  reg_b : BLK_MEM_GEN_V2_4_output_stage
    generic map(
      C_DATA_WIDTH  => C_READ_WIDTH_B,
      C_HAS_SSR     => C_HAS_SSRB,
      C_HAS_REGCE   => C_HAS_REGCEB,
      C_HAS_EN      => C_HAS_ENB,
      C_USE_ECC     => C_USE_ECC,
      C_FAMILY      => C_FAMILY,
      C_XDEVICEFAMILY => C_XDEVICEFAMILY,
      C_USE_RAMB16BWER_RST_BHV => C_USE_RAMB16BWER_RST_BHV,
      sinit_val     => sinitb_val,
      num_stages    => num_output_stages,
      flop_delay    => flop_delay)
    port map (
      CLK    => CLKB,
      SSR    => SSRB,
      REGCE  => REGCEB,
      EN     => ENB,
      DIN    => memory_out_b,
      DOUT   => DOUTB);

  -- Synchronous collision checks
sync_coll:  if (C_DISABLE_WARN_BHV_COLL=0 and C_COMMON_CLK=1) generate
  process (CLKA)
    use IEEE.STD_LOGIC_TEXTIO.ALL;
    -- collision detect
    variable is_collision   : boolean;
    variable message        : line;
  begin
    if (CLKA='1' and CLKA'event) then
      -- Possible collision if both are enabled and the addresses match

      if (ena_i='1' and enb_i='1') then
        is_collision := collision_check(ADDRA,
                                        wea_i/=wea0,
                                        ADDRB,
                                        web_i/=web0);
      else
        is_collision := false;
      end if;

      -- If the write port is in READ_FIRST mode, there is no collision
      if (C_WRITE_MODE_A="READ_FIRST" and wea_i/=wea0 and web_i=web0) then
        is_collision := false;
      end if;
      if (C_WRITE_MODE_B="READ_FIRST" and web_i/=web0 and wea_i=wea0) then
        is_collision := false;
      end if;


      -- Only flag if one of the accesses is a write
      if (is_collision and (wea_i/=wea0 or web_i/=web0)) then
        write(message, C_CORENAME);
        write(message, string'(" WARNING: collision detected: "));

        if (wea_i/=wea0) then
          write(message, string'("A write address: "));
        else
          write(message, string'("A read address: "));
        end if;
        write(message, ADDRA);
        if (web_i/=web0) then
          write(message, string'(", B write address: "));
        else
          write(message, string'(", B read address: "));
        end if;
        write(message, ADDRB);
        write(message, LF);
        assert false report message.all severity warning;
        deallocate(message);
      end if;

    end if;
  end process;
end generate;

  -- Asynchronous collision checks
async_coll:  if (C_DISABLE_WARN_BHV_COLL=0 and C_COMMON_CLK=0) generate

  signal addra_delay : std_logic_vector(C_ADDRA_WIDTH-1 downto 0);
  signal wea_delay   : std_logic_vector(C_WEA_WIDTH-1 downto 0);
  signal ena_delay   : std_logic;
  signal addrb_delay : std_logic_vector(C_ADDRB_WIDTH-1 downto 0);
  signal web_delay   : std_logic_vector(C_WEB_WIDTH-1 downto 0);
  signal enb_delay   : std_logic;

begin

  -- Delay A and B addresses in order to mimic setup/hold times
  process (ADDRA, wea_i, ena_i, ADDRB, web_i, enb_i)
  begin
    addra_delay <= ADDRA after coll_delay;
    wea_delay   <= wea_i after coll_delay;
    ena_delay   <= ena_i after coll_delay;
    addrb_delay <= ADDRB after coll_delay;
    web_delay   <= web_i after coll_delay;
    enb_delay   <= enb_i after coll_delay;
  end process;

  -- Do the checks w/rt A
  process (CLKA)
    use IEEE.STD_LOGIC_TEXTIO.ALL;
    variable is_collision_a       : boolean;
    variable is_collision_delay_a : boolean;
    variable message              : line;
  begin

    -- Possible collision if both are enabled and the addresses match
    if (ena_i='1' and enb_i='1') then
      is_collision_a := collision_check(ADDRA,
                                        wea_i/=wea0,
                                        ADDRB,
                                        web_i/=web0);
    else
      is_collision_a := false;
    end if;

    if (ena_i='1' and enb_delay='1') then
      is_collision_delay_a := collision_check(ADDRA,
                                              wea_i/=wea0,
                                              addrb_delay,
                                              web_delay/=web0);
    else
      is_collision_delay_a := false;
    end if;


    -- Only flag if B access is a write
    if (is_collision_a and web_i/=web0) then
      write(message, C_CORENAME);
      write(message, string'(" WARNING: collision detected: "));
      if (wea_i/=wea0) then
        write(message, string'("A write address: "));
      else
        write(message, string'("A read address: "));
      end if;
      write(message, ADDRA);
      write(message, string'(", B write address: "));
      write(message, ADDRB);
      write(message, LF);
      assert false report message.all severity warning;
      deallocate(message);
    elsif (is_collision_delay_a and web_delay/=web0) then
      write(message, C_CORENAME);
      write(message, string'(" WARNING: collision detected: "));
      if (wea_i/=wea0) then
        write(message, string'("A write address: "));
      else
        write(message, string'("A read address: "));
      end if;
      write(message, ADDRA);
      write(message, string'(", B write address: "));
      write(message, addrb_delay);
      write(message, LF);
      assert false report message.all severity warning;
      deallocate(message);
    end if;

  end process;

  -- Do the checks w/rt B
  process (CLKA)
    use IEEE.STD_LOGIC_TEXTIO.ALL;
    variable is_collision_b       : boolean;
    variable is_collision_delay_b : boolean;
    variable message              : line;
  begin

    -- Possible collision if both are enabled and the addresses match
    if (ena_i='1' and enb_i='1') then
      is_collision_b := collision_check(ADDRA,
                                        wea_i/=wea0,
                                        ADDRB,
                                        web_i/=web0);
    else
      is_collision_b := false;
    end if;

    if (ena_i='1' and enb_delay='1') then
      is_collision_delay_b := collision_check(ADDRA,
                                              wea_i/=wea0,
                                              addrb_delay,
                                              web_delay/=web0);
    else
      is_collision_delay_b := false;
    end if;

    -- Only flag if A access is a write
    if (is_collision_b and wea_i/=wea0) then
      write(message, C_CORENAME);
      write(message, string'(" WARNING: collision detected: "));
      write(message, string'("A write address: "));
      write(message, ADDRA);
      if (wea_i/=wea0) then
        write(message, string'(", B write address: "));
      else
        write(message, string'(", B read address: "));
      end if;
      write(message, ADDRB);
      write(message, LF);
      assert false report message.all severity warning;
      deallocate(message);
    elsif (is_collision_delay_b and wea_delay/=wea0) then
      write(message, C_CORENAME);
      write(message, string'(" WARNING: collision detected: "));
      write(message, string'("A write address: "));
      write(message, addra_delay);
      if (wea_i/=wea0) then
        write(message, string'(", B write address: "));
      else
        write(message, string'(", B read address: "));
      end if;
      write(message, ADDRB);
      write(message, LF);
      assert false report message.all severity warning;
      deallocate(message);
    end if;

  end process;
end generate;

end behavioral;

