-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 2.1
--  \   \        Filename: $RCSfile: bip_bram18k_v2_2_rtl.vhd,v $           
--  /   /        Date Last Modified: $Date: 2009/09/08 16:46:30 $ 
-- /___/   /\    Date Created: 2007
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : xbip_bram18k_v2_2
-- Purpose : RTL model of single 18K BRAM memory
--
--------------------------------------------------------------------------------
--  (c) Copyright 2007, 2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all; 

library xilinxcorelib;
use xilinxcorelib.xbip_pipe_v2_0_xst_comp.all;

library xilinxcorelib;
use xilinxcorelib.bip_bram18k_pkg_v2_2.all;
use xilinxcorelib.bip_bram18k_v2_2_sim_pkg.all;   

--core_if on entity bip_bram18k_v2_2_rtl
  entity bip_bram18k_v2_2_rtl is
    GENERIC (
      C_XDEVICEFAMILY : string := "virtex4";
      C_LATENCY        : integer := -1;
      C_VERBOSITY      : integer := 0;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
      C_OPTIMIZE_GOAL  : integer := 0;  --0 = area, 1 = speed.
      C_MODEL_TYPE     : integer := 1;  --0 = synth, 1 = RTL
      C_ADDR_WIDTH     : integer := 10;
      C_DATA_WIDTH     : integer := 18;
      C_INIT_VAL       : t_BRAM18k_init_val := (others => (others => '0'))
      );
    PORT (
      CLK       : in  std_logic                    := '1';
      CE        : in  std_logic                    := '1';
      SCLR      : in  std_logic                    := '0';
      WE1       : in  std_logic                    := '0';
      WE2       : in  std_logic                    := '0';
      ADDR1     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0'); 
      ADDR2     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0'); 
      DATAIN1   : in  std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
      DATAIN2   : in  std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
      DATAOUT1  : out std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
      DATAOUT2  : out std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0')
      );
--core_if off
end bip_bram18k_v2_2_rtl;



architecture rtl of bip_bram18k_v2_2_rtl is

  --The BRAM core takes the contents initialization as an array of 512 x 36
  --bits. The core package contains utility functions to allow a user core to
  --create the array in another form (eg. 1024 x 18, 2048 x 8, 4096 x 4, 8192 x
  --2, 16384 x 1) and convert to the standard form. This is preferable to
  --passing an array of 16384 x 36 because of speed. XST is not fast with such
  --large blocks of data.
  --The standard array element has the 4 parity bits first then the 32 data
  --bits, so that conversion from one aspect ratio of ram to another is possible. 
  type t_resolved_BRAM18k is array (0 to 2**C_ADDR_WIDTH-1) of std_logic_vector(C_DATA_WIDTH-1 downto 0);
  function fn_init_ram (
    p_addr_width : integer;
    p_data_width : integer;
    p_init_val   : t_BRAM18k_init_val
    )
    return t_resolved_BRAM18k is
    variable ret_val : t_resolved_BRAM18k;
    variable dummy : std_logic_vector(35 downto 0);
  begin
    case p_addr_width is
      when 9  =>                        --this matches the standard array, 1-1
        for addr in 0 to 511 loop
          ret_val(addr) := p_init_val(addr)(C_DATA_WIDTH-1 downto 0);
        end loop;  -- addr
      when 10 =>
        for addr in 0 to 511 loop
          dummy := p_init_val(addr)(35 downto 34)&p_init_val(addr)(31 downto 16)&
                   p_init_val(addr)(33 downto 32)&p_init_val(addr)(15 downto 0);
          ret_val(addr*2  ) := dummy(C_DATA_WIDTH-1 downto 0);
          ret_val(addr*2+1) := dummy(18+C_DATA_WIDTH-1 downto 18);
        end loop;  -- addr
        
      when 11 => 
        for addr in 0 to 511 loop
          dummy := p_init_val(addr)(35)&p_init_val(addr)(31 downto 24)&
                   p_init_val(addr)(34)&p_init_val(addr)(23 downto 16)&
                   p_init_val(addr)(33)&p_init_val(addr)(15 downto 8)&
                   p_init_val(addr)(32)&p_init_val(addr)( 7 downto 0);
          ret_val(addr*4  ) := dummy(   C_DATA_WIDTH-1 downto 0);
          ret_val(addr*4+1) := dummy( 9+C_DATA_WIDTH-1 downto 9);
          ret_val(addr*4+2) := dummy(18+C_DATA_WIDTH-1 downto 18);
          ret_val(addr*4+3) := dummy(27+C_DATA_WIDTH-1 downto 27);
        end loop;  -- addr
        
      when 12 => 
        for addr in 0 to 511 loop
          ret_val(addr*8  ) := p_init_val(addr)(   C_DATA_WIDTH-1 downto 0);
          ret_val(addr*8+1) := p_init_val(addr)( 4+C_DATA_WIDTH-1 downto 4);
          ret_val(addr*8+2) := p_init_val(addr)( 8+C_DATA_WIDTH-1 downto 8);
          ret_val(addr*8+3) := p_init_val(addr)(12+C_DATA_WIDTH-1 downto 12);
          ret_val(addr*8+4) := p_init_val(addr)(16+C_DATA_WIDTH-1 downto 16);
          ret_val(addr*8+5) := p_init_val(addr)(20+C_DATA_WIDTH-1 downto 20);
          ret_val(addr*8+6) := p_init_val(addr)(24+C_DATA_WIDTH-1 downto 24);
          ret_val(addr*8+7) := p_init_val(addr)(28+C_DATA_WIDTH-1 downto 28);
        end loop;  -- addr
        
      when 13 => 
        for addr in 0 to 511 loop
          ret_val(addr*16  )  := p_init_val(addr)(   C_DATA_WIDTH-1 downto 0);
          ret_val(addr*16+1)  := p_init_val(addr)( 2+C_DATA_WIDTH-1 downto 2);
          ret_val(addr*16+2)  := p_init_val(addr)( 4+C_DATA_WIDTH-1 downto 4);
          ret_val(addr*16+3)  := p_init_val(addr)( 6+C_DATA_WIDTH-1 downto 6);
          ret_val(addr*16+4)  := p_init_val(addr)( 8+C_DATA_WIDTH-1 downto 8);
          ret_val(addr*16+5)  := p_init_val(addr)(10+C_DATA_WIDTH-1 downto 10);
          ret_val(addr*16+6)  := p_init_val(addr)(12+C_DATA_WIDTH-1 downto 12);
          ret_val(addr*16+7)  := p_init_val(addr)(14+C_DATA_WIDTH-1 downto 14);
          ret_val(addr*16+8)  := p_init_val(addr)(16+C_DATA_WIDTH-1 downto 16);
          ret_val(addr*16+9)  := p_init_val(addr)(18+C_DATA_WIDTH-1 downto 18);
          ret_val(addr*16+10) := p_init_val(addr)(20+C_DATA_WIDTH-1 downto 20);
          ret_val(addr*16+11) := p_init_val(addr)(22+C_DATA_WIDTH-1 downto 22);
          ret_val(addr*16+12) := p_init_val(addr)(24+C_DATA_WIDTH-1 downto 24);
          ret_val(addr*16+13) := p_init_val(addr)(26+C_DATA_WIDTH-1 downto 26);
          ret_val(addr*16+14) := p_init_val(addr)(28+C_DATA_WIDTH-1 downto 28);
          ret_val(addr*16+15) := p_init_val(addr)(30+C_DATA_WIDTH-1 downto 30);
        end loop;  -- addr
        
      when 14 => 
        for addr in 0 to 511 loop
          ret_val(addr*32  )  := p_init_val(addr)(   C_DATA_WIDTH-1 downto 0);
          ret_val(addr*32+1)  := p_init_val(addr)( 1+C_DATA_WIDTH-1 downto 1);
          ret_val(addr*32+2)  := p_init_val(addr)( 2+C_DATA_WIDTH-1 downto 2);
          ret_val(addr*32+3)  := p_init_val(addr)( 3+C_DATA_WIDTH-1 downto 3);
          ret_val(addr*32+4)  := p_init_val(addr)( 4+C_DATA_WIDTH-1 downto 4);
          ret_val(addr*32+5)  := p_init_val(addr)( 5+C_DATA_WIDTH-1 downto 5);
          ret_val(addr*32+6)  := p_init_val(addr)( 6+C_DATA_WIDTH-1 downto 6);
          ret_val(addr*32+7)  := p_init_val(addr)( 7+C_DATA_WIDTH-1 downto 7);
          ret_val(addr*32+8)  := p_init_val(addr)( 8+C_DATA_WIDTH-1 downto 8);
          ret_val(addr*32+9)  := p_init_val(addr)( 9+C_DATA_WIDTH-1 downto 9);
          ret_val(addr*32+10) := p_init_val(addr)(10+C_DATA_WIDTH-1 downto 10);
          ret_val(addr*32+11) := p_init_val(addr)(11+C_DATA_WIDTH-1 downto 11);
          ret_val(addr*32+12) := p_init_val(addr)(12+C_DATA_WIDTH-1 downto 12);
          ret_val(addr*32+13) := p_init_val(addr)(13+C_DATA_WIDTH-1 downto 13);
          ret_val(addr*32+14) := p_init_val(addr)(14+C_DATA_WIDTH-1 downto 14);
          ret_val(addr*32+15) := p_init_val(addr)(15+C_DATA_WIDTH-1 downto 15);
          ret_val(addr*32+16) := p_init_val(addr)(16+C_DATA_WIDTH-1 downto 16);
          ret_val(addr*32+17) := p_init_val(addr)(17+C_DATA_WIDTH-1 downto 17);
          ret_val(addr*32+18) := p_init_val(addr)(18+C_DATA_WIDTH-1 downto 18);
          ret_val(addr*32+19) := p_init_val(addr)(19+C_DATA_WIDTH-1 downto 19);
          ret_val(addr*32+20) := p_init_val(addr)(20+C_DATA_WIDTH-1 downto 20);
          ret_val(addr*32+21) := p_init_val(addr)(21+C_DATA_WIDTH-1 downto 21);
          ret_val(addr*32+22) := p_init_val(addr)(22+C_DATA_WIDTH-1 downto 22);
          ret_val(addr*32+23) := p_init_val(addr)(23+C_DATA_WIDTH-1 downto 23);
          ret_val(addr*32+24) := p_init_val(addr)(24+C_DATA_WIDTH-1 downto 24);
          ret_val(addr*32+25) := p_init_val(addr)(25+C_DATA_WIDTH-1 downto 25);
          ret_val(addr*32+26) := p_init_val(addr)(26+C_DATA_WIDTH-1 downto 26);
          ret_val(addr*32+27) := p_init_val(addr)(27+C_DATA_WIDTH-1 downto 27);
          ret_val(addr*32+28) := p_init_val(addr)(28+C_DATA_WIDTH-1 downto 28);
          ret_val(addr*32+29) := p_init_val(addr)(29+C_DATA_WIDTH-1 downto 29);
          ret_val(addr*32+30) := p_init_val(addr)(30+C_DATA_WIDTH-1 downto 30);
          ret_val(addr*32+31) := p_init_val(addr)(31+C_DATA_WIDTH-1 downto 31);
        end loop;  -- addr
      when others =>
        assert false
          report "ERROR: BRAM18k: unsupported address width encountered in fn_init_ram"
          severity error;
    end case;
    return ret_val;
  end fn_init_ram;
  constant check_gens : integer := check_generics(
    P_XDEVICEFAMILY => C_XDEVICEFAMILY,
    P_LATENCY       => C_LATENCY       ,
    P_VERBOSITY     => C_VERBOSITY     ,
    P_OPTIMIZE_GOAL => C_OPTIMIZE_GOAL ,
    P_MODEL_TYPE    => C_MODEL_TYPE    ,
    P_ADDR_WIDTH    => C_ADDR_WIDTH    ,
    P_DATA_WIDTH    => C_DATA_WIDTH    ,
    P_INIT_VAL      => C_INIT_VAL      
    );

  constant ci_pipe_all : t_BRAM18k_latency := fn_BRAM18k_latency(C_LATENCY, C_OPTIMIZE_GOAL);
  constant ci_pipe : t_BRAM18k_pipe := ci_pipe_all.pipe;
  signal diag_pipe_all : t_BRAM18k_latency := ci_pipe_all;

  signal rom_en : std_logic := '0';
  signal pre_DATAOUT1  : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
  signal pre_DATAOUT2  : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
  signal prim_DATAOUT1 : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
  signal prim_DATAOUT2 : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
  
  shared variable contents : t_resolved_BRAM18k := fn_init_ram(C_ADDR_WIDTH,C_DATA_WIDTH,C_INIT_VAL);
  attribute RAM_STYLE : string;
  --  attribute RAM_STYLE of sin_cos_lut : variable is ci_mem_style;
  attribute RAM_STYLE of contents : variable is "block";  
begin
  i_pipe_1 : if ci_pipe(ci_rom_ip_stage) = 1 generate
    rom_en <= '1' when ce = '1' else '0';
    i_rom_reg : process(clk)
    begin
      if rising_edge(clk) then
        if rom_en = '1' then
          pre_DATAOUT1 <= contents(conv_integer(ADDR1));
          pre_DATAOUT2 <= contents(conv_integer(ADDR2));
          if WE1 = '1' then
            contents(conv_integer(ADDR1)) := DATAIN1;
          end if;
          if WE2 = '1' then
            contents(conv_integer(ADDR2)) := DATAIN2;
          end if;
        end if;
      end if;
    end process i_rom_reg;
  end generate i_pipe_1;

  ---------------------------------------------------------------------------
  --ROM op reg stage
  ---------------------------------------------------------------------------
  i_no_pipe_2 : if ci_pipe(ci_rom_op_stage) = 0 generate
    prim_DATAOUT1 <= pre_DATAOUT1;
    prim_DATAOUT2 <= pre_DATAOUT2;
  end generate i_no_pipe_2;
  i_pipe_2_a : if ci_pipe(ci_rom_op_stage) = 1 generate
    i_rom_reg : process(clk)
    begin
      if rising_edge(clk) then
        if ce = '1' then
          prim_DATAOUT1 <= pre_DATAOUT1;
          prim_DATAOUT2 <= pre_DATAOUT2;
        end if;
      end if;
    end process i_rom_reg;
  end generate i_pipe_2_a;
  -------------------------------------------------------------------------
  -- ROM speedup reg stage
  -------------------------------------------------------------------------
  i_rom_reg_a : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_rom_speedup_stage),
      C_HAS_CE   => 1,
      C_WIDTH    => C_DATA_WIDTH
      )
    port map(
      CLK  => CLK,
      CE   => ce,
      D    => prim_DATAOUT1,
      Q    => DATAOUT1
      );
  i_rom_reg_b : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_rom_speedup_stage),
      C_HAS_CE   => 1,
      C_WIDTH    => C_DATA_WIDTH
      )
    port map(
      CLK  => CLK,
      CE   => ce,
      D    => prim_DATAOUT2,
      Q    => DATAOUT2
      );
end rtl;
