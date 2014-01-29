-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
----------------------------------------------------------------------------
-- MULTIPLY COMPILER  :  VHDL Behavioral Model 
----------------------------------------------------------------------------
--
--    **************************
--    * Copyright Xilinx, Inc. *
--    * All rights reserved.   *
--    * March 3, 2000          *
--    **************************
--
----------------------------------------------------------------------------
-- Filename:  mult_gen_v7_0.vhd
--                                   
-- Description:  
--      This is the VHDL behavioral description of a Multiply Compiler
--      Core.  It simulates the the behavior of the entire core including each
--      of the following sub-cores:
--                                  0- lut based parallel
--                                  1- Virtex II parallel
--                                  2- parallel CCM
--                                  3- static RCCM
--                                  4- dynamic RCCM
--                                  5- XtremeDSP slice (Virtex 4)
----------------------------------------------------------------------------
-- Structure:
--    mult_gen_v7_0
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library std;
use std.textio.all;

library xilinxcorelib;
use xilinxcorelib.prims_constants_v7_0.all;
use XilinxCoreLib.mult_const_pkg_v7_0.all;
use xilinxcorelib.mult_gen_v7_0_non_seq_comp.all;
use xilinxcorelib.mult_gen_v7_0_seq_comp.all;

use XilinxCoreLib.mult_gen_v7_0_services.all;

----------------------------------------------------------------------------
-- PORT DECLARATION
----------------------------------------------------------------------------

entity mult_gen_v7_0 is
   generic (
      c_a_width         : integer := A_DEFAULT_WIDTH;
      -- vector width of operand A
      c_b_width         : integer := B_DEFAULT_WIDTH;
      -- vector width of operand B
      c_out_width       : integer := OUT_DEFAULT_WIDTH;
      -- vector width of the output
      c_has_q           : integer := DEFAULT_HAS_Q;
      -- generate a registered output- dout 
      c_has_o           : integer := DEFAULT_HAS_0;
      -- generate a non-registered output
      -- NOTE: core can produce both a
      -- registered and a non-registered
      -- output.
      c_reg_a_b_inputs  : integer := DEFAULT_REG_A_B_INPUTS;
      -- inputs A and B are registered
      c_a_type          : integer := DEFAULT_A_TYPE;
      -- determines whether the operand A
      -- is signed, unsigned
      c_b_type          : integer := DEFAULT_B_TYPE;
      -- determines whether the operand B
      -- is signed, unsigned
      c_b_constant      : integer := DEFAULT_CONSTANT_B;
      -- operand B is a constant
      c_b_value         : string  := DEFAULT_CONSTANT_B_VAL;
      -- value of operand B when constant
      c_has_aclr        : integer := DEFAULT_HAS_ACLR;
      -- generate an asynchronous clear
      c_has_sclr        : integer := DEFAULT_HAS_SCLR;
      -- generate a synchronous clear
      c_has_ce          : integer := DEFAULT_HAS_CE;
      -- generate a clock enable
      c_has_a_signed    : integer := DEFAULT_HAS_A_SIGNED;
      -- generate a signal to control the
      -- sign of operand A
      c_enable_rlocs    : integer := DEFAULT_ENABLE_RLOCS;
      -- enable relative placement
      c_has_loadb       : integer := DEFAULT_HAS_LOADB;
      -- generate a signal to control the
      -- loading of constant operand B
      c_mem_type        : integer := DEFAULT_MEM_TYPE;
      -- defines whether the multiplier
      -- implementation uses single port
      -- block mem, dual port block mem,
      -- distributed mem
      c_mult_type       : integer := DEFAULT_MULT_TYPE;
      -- determines which kind of multiplier
      -- to instantiate:
      -- 0- lut based parallel
      -- 1- Virtex II parallel
      -- 2- parallel CCM
      -- 3- static RCCM
      -- 4- dynamic RCCM
      -- 5- XtremeDSP slice (Virtex 4)
      c_baat            : integer := DEFAULT_BAAT;
      c_has_swapb       : integer := DEFAULT_HAS_SWAPB;
      -- generate a multiplier busy signal
      c_has_nd          : integer := DEFAULT_HAS_ND;
      -- generate a new data signal
      c_has_rdy         : integer := DEFAULT_HAS_RDY;
      -- generate a output ready signal
      c_has_rfd         : integer := DEFAULT_HAS_RFD;
      -- generate a ready for data signal
      c_pipeline        : integer := 0;  --DEFAULT_PIPELINED ;       
      c_sync_enable     : integer := DEFAULT_SYNC_ENABLE;
      c_has_load_done   : integer := DEFAULT_HAS_LOAD_DONE;
      -- signal is generated in GUI whenever
      c_output_hold     : integer := DEFAULT_OUTPUT_HOLD;
      c_sqm_type        : integer := 0;
      -- 0 = parallel input, 1 = serial input
      c_has_b           : integer := 1;
      -- generate a b input port (not used in behavioural model)
      c_stack_adders    : integer := 0;
      -- Placement (not used in behavioural model)
      bram_addr_width   : integer := 8;
      -- Block RAM address width. 8 in virtex, 9 in virtex2
      c_mem_init_prefix : string  := "mem";
      c_standalone      : integer := 0;
      -- Prefix for the memory initialisation file.
      c_use_luts        : integer := 1;
      -- 1 if using LUT based parallel multiplier, 0 if 
      -- using the virtex2 multiplier blocks. (Ignored by behavioural model)
      c_v2_speed        : integer := 1
      );
   port (
      clk : in  std_logic := '0';  -- clk must be present for all non-
                                   -- combinatorial implementation
                                   -- (i.e. if c_has_pipeline = 1)
      
      a   : in  std_logic_vector(((c_a_width-1)-((c_a_width-1)*c_sqm_type)) downto 0)
         := (others => '0');
      -- operand A
      b   : in  std_logic_vector(c_b_width-1 downto 0) := (others => '0');
      -- operand B
      o   : out std_logic_vector(c_out_width-1 downto 0) ;
      -- non-registered output
      q   : out std_logic_vector(c_out_width-1 downto 0) := (others => '0');
      -- registered output
      a_signed : in  std_logic := '0';
                                        -- determines the sign of operand A
                                        -- dynamically. (1 = signed) 
      loadb    : in  std_logic := '0';
                                        -- load operand B is used to reload
                                        -- the coefficient mem, active high-
                                        -- used when B is a constant that is
                                        -- reloadable.
      load_done : out std_logic;
                                        -- indicates that the mult. has
                                        -- finished reloading the new operand
                                        -- B into memory.
      swapb     : in  std_logic := '0';
                                        -- causes the multiplier to use the
                                        -- latest loaded B value.
      ce        : in  std_logic := '0';
      -- clock enable
      aclr      : in  std_logic := '0';
      -- asynchronous clear
      sclr      : in  std_logic := '0';  -- synchronous clear
      rfd       : out std_logic;        -- ready for data- signals that the
                                        -- multiplier can accept and process
                                        -- new operands
      nd        : in  std_logic                                                             := '1';  -- new data- signals that operands A
                                                                                                     -- or B have new data.
      rdy       : out std_logic         -- output ready- indicates that the
                                        -- output is valid.
      );
end mult_gen_v7_0;


architecture behavioral of mult_gen_v7_0 is

function check_loadb(mult_type, has_loadb : integer) return integer is
variable ret_val : integer;
begin
  if (has_loadb = 1 and mult_type > 2 and mult_type < 5) then
     ret_val := 1;
  else
     ret_val := 0;
  end if;
  return ret_val;
end check_loadb;

function check_swapb(mult_type, has_swapb : integer) return integer is
variable ret_val : integer;
begin
  if (has_swapb = 1 and mult_type = 4) then
     ret_val := 1;
  else
     ret_val := 0;
  end if;
  return ret_val;
end check_swapb;

function fix_mult_type(mult_type : integer) return integer is
variable ret_val : integer := 0;
begin
  --if mult_type /= 5 then
  --  ret_val := mult_type;
  --else
  --  ret_val := 1;
  --end if;
  ret_val := mult_type;
  return ret_val;
end fix_mult_type;

function set_sync_en (has_ce, sync_enable : integer) return integer is
  variable ret_val : integer := 0;
  begin
    if (has_ce = 1) then
      ret_val := sync_enable;
    else
      ret_val := 0;
    end if;
    return ret_val;
  end set_sync_en;

  signal int_o         : std_logic_vector(c_out_width-1 downto 0);
  signal int_q         : std_logic_vector(c_out_width-1 downto 0);
  signal int_load_done : std_logic;
  signal int_rdy       : std_logic;
  signal int_rfd       : std_logic;

  constant new_type    : integer := fix_mult_type(c_mult_type);

begin

  check_inputs : process
   begin
      if (c_has_loadb = 1 and c_mult_type < 3) then
        assert false
          report "Mult type must be set to 3 or 4 for a reloadable ccm" severity warning;
      end if;
      if (c_has_swapb = 1 and c_mult_type < 4) then
        assert false
          report "Mult type must be set to 4 for a reloadable ccm with a swapb pin" severity warning;
      end if;
      if ((c_has_a_signed = 1) or (c_a_type = c_signed)) and (c_a_width = 1) and ((c_mult_type < 2) or (c_mult_type = 5)) then
         assert false
            report "Cannot have a 1 bit signed value (A Port)" severity warning;
      end if;
      if (c_b_type = c_signed) and (c_b_width = 1) and ((c_mult_type < 2) or (c_mult_type = 5)) then
         assert false
            report "Cannot have a 1 bit signed value (B Port)" severity warning;
      end if;
      if (c_b_constant = 1) and ((c_mult_type < 2) or (c_mult_type = 5)) then
         assert false
            report "The multiplier type is not compatible with a constant B input" severity warning;
      end if;
      wait;
   end process check_inputs;

  i0 : if (c_baat = c_a_width and c_b_value = "0" and c_mult_type = 2) generate
    i00 : if (c_has_o = 1) generate
      int_o <= (others => '0');
    end generate i00;
    i01 : if (c_has_o = 0) generate
      int_o <= (others => 'X');
    end generate i01;
    i02 : if (c_has_q = 1) generate
      int_q <= (others => '0');
    end generate i02;
    i03 : if (c_has_q = 0) generate
      int_q <= (others => 'X');
    end generate i03;
    i04 : if (c_has_nd = 1 and c_has_rdy = 1) generate
      int_rdy <= nd;
    end generate i04;
    i05 : if (c_has_nd = 0 and c_has_rdy = 1) generate
      int_rdy <= '1';
    end generate i05;
    i06 : if (c_has_rdy = 0) generate
      int_rdy <= 'X';
    end generate i06;
    i07 : if (c_has_rfd = 1 and c_has_sclr = 1 and c_has_aclr = 1) generate
      int_rfd <= not(sclr or aclr);
    end generate i07;
    i08 : if (c_has_rfd = 1 and c_has_sclr = 1 and c_has_aclr = 0) generate
      int_rfd <= not(sclr);
    end generate i08;
    i09 : if (c_has_rfd = 1 and c_has_sclr = 0 and c_has_aclr = 1) generate
      int_rfd <= not(aclr);
    end generate i09;
    i010 : if (c_has_rfd = 1 and c_has_sclr = 0 and c_has_aclr = 0) generate
      int_rfd <= '1';
    end generate i010;
    i011 : if (c_has_rfd = 0) generate
      int_rfd <= 'X';
    end generate i011;
  end generate i0;
    

  i1 : if (c_a_width = c_baat) and not(c_baat = c_a_width and c_b_value = "0" and c_mult_type = 2) generate
    mult_non_seq : mult_gen_v7_0_non_seq 
                   generic map (c_a_width         => c_a_width,
                                c_b_width         => c_b_width,
                                c_out_width       => c_out_width,
                                c_has_q           => c_has_q,      
                                c_has_o           => c_has_o,
                                c_reg_a_b_inputs  => c_reg_a_b_inputs,
                                c_a_type          => c_a_type,
                                c_b_type          => c_b_type,
                                c_b_constant      => c_b_constant,
                                c_b_value         => c_b_value,
                                c_has_aclr        => c_has_aclr,
                                c_has_sclr        => c_has_sclr,
                                c_has_ce          => c_has_ce,
                                c_has_a_signed    => c_has_a_signed,
                                c_enable_rlocs    => c_enable_rlocs,
                                c_has_loadb       => check_loadb(c_mult_type,c_has_loadb),
                                c_mem_type        => c_mem_type,
                                c_mult_type       => new_type,
                                c_baat            => c_baat,
                                c_has_swapb       => check_swapb(c_mult_type,c_has_swapb),
                                c_has_nd          => c_has_nd,
                                c_has_rdy         => c_has_rdy,
                                c_has_rfd         => c_has_rfd,
                                c_pipeline        => c_pipeline,       
                                c_predelay        => 0,
                                c_sync_enable     => set_sync_en(c_has_ce, c_sync_enable),
                                c_has_load_done   => c_has_load_done,
                                c_output_hold     => c_output_hold,
                                c_sqm_type        => c_sqm_type,
                                c_has_b           => c_has_b,
                                c_stack_adders    => c_stack_adders,
                                bram_addr_width   => bram_addr_width,
                                c_mem_init_prefix => c_mem_init_prefix,
                                c_standalone      => c_standalone,
                                c_use_luts        => c_use_luts) --,
--                                c_v2_speed        => c_v2_speed)
                   port map    (clk               => clk,        
                                a                 => a,      
                                b                 => b,
                                o                 => int_o,
                                q                 => int_q, 
                                a_signed          => a_signed, 
                                loadb             => loadb,
                                load_done         => int_load_done,
                                swapb             => swapb,
                                ce                => ce,
                                aclr              => aclr,      
                                sclr              => sclr,
                                rfd               => int_rfd,
                                nd                => nd,
                                rdy               => int_rdy);
  end generate i1;
            
                 
  i2 : if (c_a_width > c_baat) generate
    mult_seq : mult_gen_v7_0_seq 
                   generic map (c_a_width         => c_a_width,
                                c_b_width         => c_b_width,
                                c_out_width       => c_out_width,
                                c_has_q           => c_has_q,      
                                c_has_o           => c_has_o,
                                c_reg_a_b_inputs  => c_reg_a_b_inputs,
                                c_a_type          => c_a_type,
                                c_b_type          => c_b_type,
                                c_b_constant      => c_b_constant,
                                c_b_value         => c_b_value,
                                c_has_aclr        => c_has_aclr,
                                c_has_sclr        => c_has_sclr,
                                c_has_ce          => c_has_ce,
                                c_has_a_signed    => c_has_a_signed,
                                c_enable_rlocs    => c_enable_rlocs,
                                c_has_loadb       => check_loadb(c_mult_type,c_has_loadb),
                                c_mem_type        => c_mem_type,
                                c_mult_type       => new_type,
                                c_baat            => c_baat,
                                c_has_swapb       => check_swapb(c_mult_type,c_has_swapb),
                                c_has_nd          => c_has_nd,
                                c_has_rdy         => c_has_rdy,
                                c_has_rfd         => c_has_rfd,
                                c_pipeline        => c_pipeline,       
                                c_sync_enable     => set_sync_en(c_has_ce, c_sync_enable),
                                c_has_load_done   => c_has_load_done,
                                c_output_hold     => c_output_hold,
                                c_sqm_type        => c_sqm_type,
                                c_has_b           => c_has_b,
                                c_stack_adders    => c_stack_adders,
                                bram_addr_width   => bram_addr_width,
                                c_mem_init_prefix => c_mem_init_prefix,
                                c_standalone      => c_standalone,
                                c_use_luts        => c_use_luts)
                   port map    (clk               => clk,        
                                a                 => a,      
                                b                 => b,
                                o                 => int_o,
                                q                 => int_q, 
                                a_signed          => a_signed, 
                                loadb             => loadb,
                                load_done         => int_load_done,
                                swapb             => swapb,
                                ce                => ce,
                                aclr              => aclr,      
                                sclr              => sclr,
                                rfd               => int_rfd,
                                nd                => nd,
                                rdy               => int_rdy);
  end generate i2; 

  o         <= int_o after 1 ns;
  q         <= int_q after 1 ns;
  load_done <= int_load_done after 1 ns;
  rfd       <= int_rfd after 1 ns;
  rdy       <= int_rdy after 1 ns;

end behavioral;            
