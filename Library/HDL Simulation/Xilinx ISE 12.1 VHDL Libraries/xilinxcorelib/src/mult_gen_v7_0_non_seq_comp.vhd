-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
Library ieee;
use ieee.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v7_0.all;
use XilinxCoreLib.mult_const_pkg_v7_0.all;

package mult_gen_v7_0_non_seq_comp is 

component mult_gen_v7_0_non_seq
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
      c_predelay        : integer := 0;
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
      c_use_luts        : integer := 1
      -- 1 if using LUT based parallel multiplier, 0 if 
      -- using the virtex2 multiplier blocks. (Ignored by behavioural model)
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
      o   : out std_logic_vector(c_out_width-1 downto 0) := (others => '0');
      -- non-registered output
      q   : out std_logic_vector(c_out_width-1 downto 0);
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
end component;

end mult_gen_v7_0_non_seq_comp;
