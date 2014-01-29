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

----------------------------------------------------------------------------
-- Filename:  mult_gen_v7_0.vhd
--                                   
-- Description:  
--      This is the VHDL behavioral description of a Multiply Compiler
--      Core.  It simulates the the behavior of the sequential core
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
use xilinxcorelib.mult_pkg_v7_0.all;
use xilinxcorelib.mult_gen_v7_0_non_seq_comp.all;
use xilinxcorelib.c_reg_fd_v7_0_comp.all;

use XilinxCoreLib.mult_gen_v7_0_services.all;

----------------------------------------------------------------------------
-- PORT DECLARATION
----------------------------------------------------------------------------

entity mult_gen_v7_0_seq is
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
end mult_gen_v7_0_seq;


architecture behavioral of mult_gen_v7_0_seq is

----------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------

   function calc_q_ce(C_HAS_CE, C_OUTPUT_HOLD : integer) return integer is
	begin
		if (C_HAS_CE = 1 or C_OUTPUT_HOLD = 1) then
			return 1;
		else
			return 0;
		end if;
	end calc_q_ce;

	function calc_mult_a_signed(C_A_TYPE, C_HAS_A_SIGNED : integer) return integer is
	begin
		if (C_A_TYPE = c_signed or C_HAS_A_SIGNED = 1) then
			return 1;
		else
		 	return 0;
		end if;
	end calc_mult_a_signed;

	function calc_mult_type(C_A_TYPE : integer) return integer is
	begin
		if (C_A_TYPE = c_signed or C_A_TYPE = c_pin) then
			return c_pin;
		else
			return c_unsigned;
		end if;
	end calc_mult_type;

	function calc_mult_width(C_B_TYPE, C_BAAT, C_B_WIDTH, mult_has_a_signed : integer) return integer is
	begin
		if (C_B_TYPE = c_signed) then
			return C_BAAT + C_B_WIDTH;
		elsif (C_B_WIDTH = 1) then
			return C_BAAT + mult_has_a_signed;
		else
			return C_BAAT + C_B_WIDTH + mult_has_a_signed;
		end if;
	end calc_mult_width;

	function calc_cycles(mod_cycle, div_cycle : integer) return integer is
	begin
		if (mod_cycle = 0) then
			return div_cycle;
		else
			return div_cycle+1;
		end if;
	end calc_cycles;

	function calc_serial(C_SQM_TYPE, C_MULT_TYPE : integer) return integer is
	begin
		if (C_SQM_TYPE = 1 and C_MULT_TYPE >= 2) then
			return 1;
		else
			return 0;
		end if;
	end calc_serial;

	function calc_accum_sign(C_B_TYPE, mult_has_a_signed : integer) return integer is
	begin
		if (C_B_TYPE = c_signed or mult_has_a_signed = 1) then
			return 1;
		else
			return 0;
		end if;
	end calc_accum_sign;

	function invert(inversion : integer) return integer is
	begin
		if (inversion = 0) then
			return 1;
		else
			return 0;
		end if;
	end invert;

	function calc_mult_rfd(C_HAS_SWAPB, C_HAS_LOADB : integer) return integer is
	begin
		if (C_HAS_SWAPB = 0 and C_HAS_LOADB = 1) then
			return 1;
		else
			return 0;
		end if;
	end calc_mult_rfd;

	function calc_predelay(C_MULT_TYPE, C_REG_A_B_INPUTS, C_SQM_TYPE : integer) return integer is
	begin
		if (C_MULT_TYPE > 2) then
			return 1 + C_REG_A_B_INPUTS - C_SQM_TYPE;
		else
			return 0;
		end if;
	end calc_predelay;

	function find_b_width(ccm_b_width, non_ccm_b_width, mult_type : integer)
      return integer is
   begin
      if (mult_type < 2) then
         return non_ccm_b_width;
      else
         return ccm_b_width;
      end if;
   end find_b_width;

   function has_a_sign (has_a_signed, a_type, baat, a_width : integer) return integer is
   begin
      if ((has_a_signed = 1 or a_type = c_signed) and (baat < a_width)) then
         return 1;
      else
         return has_a_signed;
      end if;
   end has_a_sign;

	function calc_latencytemp(C_LATENCY : integer) return integer is
	begin
		if (C_LATENCY > 0) then
			return 0;
		else
			return 1;
		end if;
	end calc_latencytemp;

	function calc_tempaccum(accum_store_width, C_BAAT : integer) return integer is
	begin
		if (accum_store_width > C_BAAT) then
			return 0;
		else
			return C_BAAT;
		end if;
	end calc_tempaccum;

	function calc_tempmult(accum_mult_width : integer) return integer is
	begin
		if (accum_mult_width > 1) then
			return 0;
		else
			return 1;
		end if;
	end calc_tempmult;

	function calc_op_width(mult_has_a_signed, C_HAS_LOADB, C_BAAT : integer) return integer is
	begin
		if (mult_has_a_signed = 0 or C_HAS_LOADB = 1) then
			return C_BAAT;
		else
			return C_BAAT + 1;
		end if;
	end calc_op_width;
	
	function calc_rom_width(C_MEM_TYPE, BRAM_ADDR_WIDTH : integer) return integer is
	begin
		if (C_MEM_TYPE = c_distributed) then
			return 4;
		else
			return BRAM_ADDR_WIDTH;
		end if;
	end calc_rom_width;
	
	function calc_in_width(effective_op_width, rom_addr_width : integer) return integer is
	begin
		if (effective_op_width mod rom_addr_width = 0) then
			return effective_op_width;
		else
			return effective_op_width + rom_addr_width - (effective_op_width mod rom_addr_width);
		end if;
	end calc_in_width;
	
	function calc_ccm_add(a_input_width, rom_addr_width, modu : integer) return integer is
	begin
		if (modu = 0) then
			return a_input_width/rom_addr_width;
		else
			return (a_input_width/rom_addr_width)+1;
		end if;
	end calc_ccm_add;

	function blk_mem_extra(C_MULT_TYPE, C_MEM_TYPE, C_PIPELINE, mult_has_a_signed, C_HAS_LOADB, C_BAAT, BRAM_ADDR_WIDTH : integer) return integer is
		constant effective_op_width : integer := calc_op_width(mult_has_a_signed, C_HAS_LOADB, C_BAAT);
		constant rom_addr_width : integer := calc_rom_width(C_MEM_TYPE, BRAM_ADDR_WIDTH);
		constant a_input_width : integer := calc_in_width(effective_op_width, rom_addr_width);
		constant modu : integer := a_input_width mod rom_addr_width;
		constant ccm_numAdders_1 : integer := calc_ccm_add(a_input_width, rom_addr_width, modu);
	begin
		if (C_MULT_TYPE > 1 and C_MEM_TYPE = c_dp_block and C_PIPELINE = 0 and ccm_numAdders_1 = 1) then
			return 1;
		else
			return 0;
		end if;
	end blk_mem_extra;
	


----------------------------------------------------------------------------
-- CONSTANT DECLARATION
----------------------------------------------------------------------------

	--has ce selection for final output register
	constant has_q_ce : integer := calc_q_ce(C_HAS_CE, C_OUTPUT_HOLD);
	--has_a_signed selectionf for internal multiplier
	constant mult_has_a_signed : integer := calc_mult_a_signed(C_A_TYPE, C_HAS_A_SIGNED);
	--a_type for internal multiplier
	constant mult_a_type : integer := calc_mult_type(C_A_TYPE);
	--output width for internal multiplier
	constant mult_width : integer := calc_mult_width(C_B_TYPE, C_BAAT, C_B_WIDTH, mult_has_a_signed);
	constant div_cycle : integer := (C_A_WIDTH/C_BAAT) ;
	constant mod_cycle : integer := (C_A_WIDTH - (C_BAAT*div_cycle)) ;
	constant no_of_cycles : integer := calc_cycles(mod_cycle, div_cycle);
	constant number_clocks : integer := no_of_cycles;
	constant shift_bits         : integer := select_val(calc_shift_bits(c_b_value, c_b_constant, c_b_type), 0, c_mult_type /= 2);
    constant ccm_b_width    : integer := select_val(bitstorep_string(c_b_value, c_b_type), c_b_width, c_has_loadb /= 0);
    constant actual_ccm_b_width : integer := select_val((ccm_b_width - shift_bits), c_b_width, c_has_loadb /= 0);
    constant actual_b_width     : integer := find_b_width(actual_ccm_b_width, c_b_width, c_mult_type);
	constant a_sig : integer := has_a_sign(mult_has_a_signed, mult_a_type, c_baat, c_baat);
    constant blk_mem_adjust : integer := blk_mem_extra(C_MULT_TYPE, C_MEM_TYPE, C_PIPELINE, mult_has_a_signed, C_HAS_LOADB, C_BAAT, BRAM_ADDR_WIDTH);
	constant c_latency : integer := calc_latency(c_baat, actual_b_width, c_b_type, a_sig, 0, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, mult_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_pipeline, bram_addr_width) + c_pipeline + blk_mem_adjust;
	--Determine if the slicer is going to be avoided
	constant ccm_serial : integer := calc_serial(C_SQM_TYPE, C_MULT_TYPE);
	--Calculate pipeline delay for the accum_sign
	constant accum_delay : integer := C_LATENCY-ccm_serial;
	--Calculate is accum_sign is actually needed
	constant accum_sign_needed : integer := calc_accum_sign(C_B_TYPE, mult_has_a_signed);
	--Calculate size of mult_width + sign extension if needed
	constant accum_mult_width : integer := mult_width + accum_sign_needed;
	--Calculate pipeline delay for ready
	constant rdy_delay : integer := C_HAS_Q+C_REG_A_B_INPUTS+C_LATENCY-ccm_serial+2-C_OUTPUT_HOLD;
	--Calculate size of accumulator output
	constant accum_width : integer := mult_width+1;
	--Calculate size of accumulator storage bits
	constant accum_store_width : integer := (C_BAAT*(number_clocks-1));
	--Determine if internal multiplier has an rfd
	constant mult_has_rfd : integer := calc_mult_rfd(C_HAS_SWAPB, C_HAS_LOADB);
	--Offsets to ensure that vhdl does not complain about reverse logic unnecessarily
	constant latency_temp : integer := calc_latencytemp(C_LATENCY);
	constant temp_accum : integer := calc_tempaccum(accum_store_width, C_BAAT);
	constant temp_mult : integer := calc_tempmult(accum_mult_width);
	--Calculate predelay value for internal multiplier
	constant predelay : integer := calc_predelay(C_MULT_TYPE, C_REG_A_B_INPUTS, C_SQM_TYPE);
	
	
	
----------------------------------------------------------------------------
-- SIGNAL DECLARATION
----------------------------------------------------------------------------

    --Clock enable signal for q registers
    signal int_q_ce : std_logic;
	--Held value of a_input
	signal a_load : std_logic_vector((C_BAAT*number_clocks)-1 downto 0);
	signal regB : std_logic_vector(C_B_WIDTH-1 downto 0);
	signal regA : std_logic_vector((C_A_WIDTH-1-((C_A_WIDTH-1)*C_SQM_TYPE)) downto 0) ;
	signal regBB : std_logic_vector(C_B_WIDTH-1 downto 0) ;
	signal regAA : std_logic_vector((C_A_WIDTH-1-((C_A_WIDTH-1)*C_SQM_TYPE)) downto 0) ;
	signal intCE : std_logic;
	signal intA_SIGNED : std_logic;
	signal regA_SIGNED : std_logic;
	signal intACLR : std_logic;
	signal intSCLR : std_logic;
	signal intLOADB : std_logic;
	signal intSWAPB : std_logic;
	signal regND : std_logic;
	signal intND : std_logic;
	signal intRFD : std_logic := '1';
	signal reg_rfd : std_logic := '0';
	signal intO : std_logic_vector(C_OUT_WIDTH-1 downto 0 ) ;
	signal intQ : std_logic_vector(C_OUT_WIDTH-1 downto 0) ;
	signal a_signed_held : std_logic;
	signal accum_load : std_logic;
	signal accum_pipe : std_logic_vector(C_LATENCY downto 0) ;
	signal rfd_pipe : std_logic_vector(number_clocks-C_REG_A_B_INPUTS-1 downto 0) := (others => '0');
	signal intSCLR_pure : std_logic;
	signal a_slice_load : std_logic;
	signal a_slice_load_sclr : std_logic;
	signal a_slice : std_logic_vector(C_BAAT-1 downto 0) ;
	signal b_held : std_logic_vector(C_B_WIDTH-1 downto 0) ;
	signal b_reg : std_logic_vector(C_B_WIDTH-1 downto 0) ;
	signal a_reg : std_logic_vector((C_A_WIDTH-1-((C_A_WIDTH-1)*C_SQM_TYPE)) downto 0) ;
	signal a_signed_reg : std_logic;
	signal slice_rfd : std_logic;
	signal int_nd : std_logic;
	signal accum_complete : std_logic_vector(accum_width+accum_store_width-1 downto 0) ;
	signal accum_out : std_logic_vector(accum_width-1 downto 0) := (others => '0');
	signal accum_store : std_logic_vector(accum_store_width-1 downto 0) := (others => '0');
	signal accum_feedback : std_logic_vector(accum_width-1 downto 0) := (others => '0');
	signal int_sclr_loadb_swapb : std_logic;
	signal int_a_signed : std_logic;
	signal pipe_rfd : std_logic;
	signal mult_signed : std_logic;
	signal int_mult_signed1 : std_logic;
	signal int_mult_signed2 : std_logic;
	signal int_mult_signed3 : std_logic;
	signal pipe_mult_signed : std_logic;
	signal mult_signed_pipe : std_logic_vector(C_REG_A_B_INPUTS+1-ccm_serial downto 0) ;
	signal accum_in : std_logic_vector(accum_mult_width-1 downto 0) ;
        signal accum_out_nem : std_logic_vector(accum_mult_width downto 0);
	signal mult_out : std_logic_vector(mult_width-1 downto 0) ;
	signal accum_sign : std_logic;
	signal accum_sign_pipe : std_logic_vector(C_LATENCY+(latency_temp*2)-1 downto 0) ;
	signal int_rdy : std_logic;
	signal int_rfd_reg : std_logic := '1';
	signal accum_mult_out_msb : std_logic;
	signal mult_o : std_logic_vector(mult_width-1 downto 0) ;
	signal mult_q : std_logic_vector(mult_width-1 downto 0) ;
	signal mult_rfd : std_logic;
	signal int_rdy_pipe : std_logic_vector(rdy_delay downto 0) := (others => '0');
	signal vcc : std_logic := '1';
	signal gnd : std_logic := '0';
	signal ND_vec : std_logic_vector(0 downto 0);
	signal regND_vec : std_logic_vector(0 downto 0);
	signal A_SIGNED_vec :std_logic_vector(0 downto 0);
	signal regA_signed_vec : std_logic_vector(0 downto 0);
	signal accum_mult_out_msb_delayed : std_logic;
	signal accum_mult_out_msb_vec : std_logic_vector(0 downto 0);
	signal accum_mult_out_msb_delayed_vec : std_logic_vector(0 downto 0);
	signal a_signed_reg_vec : std_logic_vector(0 downto 0);
	signal a_signed_held_vec : std_logic_vector(0 downto 0);
----------------------------------------------------------------------------
-- COMPONENT DECLARATION
---------------------------------------------------------------------------- 



begin

----------------------------------------------------------------------------
-- COMPONENT INSTANTIATIONS
---------------------------------------------------------------------------- 

	mult_gen_non_seq : MULT_GEN_V7_0_NON_SEQ 
				generic map (BRAM_ADDR_WIDTH => BRAM_ADDR_WIDTH,
							 C_A_TYPE        => mult_a_type,
							 C_A_WIDTH       => C_BAAT, 
							 C_BAAT          => C_BAAT, 
							 C_B_CONSTANT    => C_B_CONSTANT, 
							 C_B_TYPE        => C_B_TYPE,
							 C_B_VALUE       => C_B_VALUE, 
							 C_B_WIDTH       => C_B_WIDTH, 
							 C_ENABLE_RLOCS  => C_ENABLE_RLOCS, 
							 C_HAS_ACLR      => C_HAS_ACLR, 
							 C_HAS_A_SIGNED  => mult_has_a_signed,
							 C_HAS_B         => C_HAS_B, 
							 C_HAS_CE        => C_HAS_CE, 
							 C_HAS_LOADB     => C_HAS_LOADB, 
							 C_HAS_LOAD_DONE => C_HAS_LOAD_DONE, 
							 C_HAS_ND		 => 0, 
							 C_HAS_O         => 1,
							 C_HAS_Q         => 1, 
							 C_HAS_RDY       => 0, 
							 C_HAS_RFD       => mult_has_rfd, 
							 C_HAS_SCLR      => C_HAS_SCLR, 
							 C_HAS_SWAPB     => C_HAS_SWAPB, 
							 C_MEM_INIT_PREFIX => C_MEM_INIT_PREFIX,
							 C_MEM_TYPE      => C_MEM_TYPE, 
							 C_MULT_TYPE     => C_MULT_TYPE, 
							 C_OUTPUT_HOLD   => 0, 
							 C_OUT_WIDTH     => mult_width, 
							 C_PIPELINE      => C_PIPELINE, 
							 C_PREDELAY      => predelay, 
							 C_REG_A_B_INPUTS => 0,
							 C_SQM_TYPE      => 0, 
							 C_STACK_ADDERS  => 1,
							 C_STANDALONE    => 0, 
							 C_SYNC_ENABLE   => C_SYNC_ENABLE, 
							 C_USE_LUTS      => C_USE_LUTS)
				port map (A			=> a_slice, 
						  B			=> b_held, 
						  CLK		=> CLK, 
						  A_SIGNED	=> mult_signed, 
						  CE		=> intCE, 
						  ACLR		=> intACLR,
					  	  SCLR		=> intSCLR, 
					  	  LOADB		=> LOADB, 
					  	  LOAD_DONE	=> LOAD_DONE, 
					  	  SWAPB		=> intSWAPB, 
					  	  RFD		=> mult_rfd,
					  	  O			=> mult_o, 
					  	  Q			=> mult_q);
	
	rega_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => C_HAS_ACLR, 
							 C_HAS_CE       => C_HAS_CE, 
							 C_HAS_SCLR     => C_HAS_SCLR,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => (C_A_WIDTH-1-((C_A_WIDTH-1)*C_SQM_TYPE))+1)
				port map (D			=> A, 
						  CLK		=> CLK, 
						  CE		=> intCE, 
						  ACLR		=> intACLR, 
			  			  SCLR      => intSCLR_pure, 
			  			  Q			=> regA);
	
	regb_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => C_HAS_ACLR, 
							 C_HAS_CE       => C_HAS_CE, 
							 C_HAS_SCLR     => C_HAS_SCLR,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => C_B_WIDTH)
				port map (D			=> B, 
						  CLK		=> CLK, 
						  CE		=> intCE, 
						  ACLR		=> intACLR, 
			  			  SCLR      => intSCLR_pure, 
			  			  Q			=> regB);
	
	regbb_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => C_HAS_ACLR, 
							 C_HAS_CE       => 1, 
							 C_HAS_SCLR     => C_HAS_SCLR,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => C_B_WIDTH)
				port map (D			=> b_reg, 
						  CLK		=> CLK, 
						  CE		=> a_slice_load_sclr, 
						  ACLR		=> intACLR, 
			  			  SCLR      => intSCLR_pure, 
			  			  Q			=> regBB);
	
	regq_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => C_HAS_ACLR, 
							 C_HAS_CE       => has_q_ce, 
							 C_HAS_SCLR     => C_HAS_SCLR,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => C_OUT_WIDTH)
				port map (D			=> intO, 
						  CLK		=> CLK, 
						  CE		=> int_q_ce, 
						  ACLR		=> intACLR, 
			  			  SCLR      => intSCLR_pure, 
			  			  Q			=> intQ);
	
	regnd_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => C_HAS_ACLR, 
							 C_HAS_CE       => C_HAS_CE, 
							 C_HAS_SCLR     => C_HAS_SCLR,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => 1)
				port map (D			=> ND_vec, 
						  CLK		=> CLK, 
						  CE		=> intCE, 
						  ACLR		=> intACLR, 
			  			  SCLR      => intSCLR_pure, 
			  			  Q			=> regND_vec);
	
	regasig_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => C_HAS_ACLR, 
							 C_HAS_CE       => C_HAS_CE, 
							 C_HAS_SCLR     => C_HAS_SCLR,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => 1)
				port map (D			=> A_SIGNED_vec, 
						  CLK		=> CLK, 
						  CE		=> intCE, 
						  ACLR		=> intACLR, 
			  			  SCLR      => intSCLR_pure, 
			  			  Q			=> regA_signed_vec);
	
	regmultmsb_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => C_HAS_ACLR, 
							 C_HAS_CE       => C_HAS_CE, 
							 C_HAS_SCLR     => C_HAS_SCLR,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => 1)
				port map (D			=> accum_mult_out_msb_vec, 
						  CLK		=> CLK, 
						  CE		=> intCE, 
						  ACLR		=> intACLR, 
			  			  SCLR      => intSCLR_pure, 
			  			  Q			=> accum_mult_out_msb_delayed_vec);
	
	latchasig_gen : C_REG_FD_V7_0 
				generic map (C_ENABLE_RLOCS => C_ENABLE_RLOCS, 
							 C_HAS_ACLR     => 0, 
							 C_HAS_CE       => 1, 
							 C_HAS_SCLR     => 0,
			   				 C_SYNC_ENABLE  => C_SYNC_ENABLE, 
			   				 C_WIDTH        => 1)
				port map (D			=> a_signed_reg_vec, 
						  CLK		=> CLK, 
						  CE		=> a_slice_load_sclr, 
			  			  Q			=> a_signed_held_vec);

----------------------------------------------------------------------------
-- PROCESS DECLARATION
---------------------------------------------------------------------------- 

    a_slice_load <= intCE and int_nd and slice_rfd;
	a_slice <= a_load(C_BAAT-1 downto 0);
	int_rdy <= int_rdy_pipe(rdy_delay-1);
	accum_mult_out_msb <= accum_in(accum_mult_width-1);
	a_signed_held <= a_signed_held_vec(0);
	a_signed_reg_vec(0) <= a_signed_reg;
        accum_out_nem <= ('0' & accum_in);
	accum_mult_out_msb_delayed <= accum_mult_out_msb_delayed_vec(0);
	accum_mult_out_msb_vec(0) <= accum_mult_out_msb;
	regA_signed <= regA_signed_vec(0);
	A_SIGNED_vec(0) <= A_SIGNED;
	regND <= regND_vec(0);
	ND_vec(0) <= ND;
   
   	generate_inputs : process(ce, aclr, sclr, nd, a_slice_load, intSCLR, intCE, a_load, regBB,
   							 b_reg, regA, a, regB, b, regA_signed, a_signed, reg_rfd, intRFD, 
   							 intSWAPB, mult_rfd, a_signed_held, vcc, gnd, int_mult_signed1,
							 pipe_mult_signed, a_slice, mult_signed_pipe, pipe_rfd, accum_sign_pipe,
							 mult_signed, int_rdy_pipe, mult_q, mult_o, int_rdy, intO, intQ, regND,
							 accum_pipe, a_slice_load_sclr, SWAPB, rfd_pipe)
	begin
		if (C_HAS_SWAPB = 1) then
			intSWAPB <= SWAPB;
		else
			intSWAPB <= '0';
		end if;
		if (C_HAS_CE = 1) then
			intCE <= CE;
		else
			intCE <= vcc;
		end if;
		if (C_HAS_ACLR = 1) then
			intACLR <= ACLR;
		else
			intACLR <= gnd;
		end if;
		--Combine SCLR with CE where appropriate depending on C_SYNC_ENABLE
		if (C_HAS_SCLR = 1) then
			intSCLR_PURE <= SCLR;
			if (C_HAS_CE = 1 and C_SYNC_ENABLE = 1) then
				intSCLR <= SCLR and CE;
			else
				intSCLR <= SCLR;
			end if;
			if (C_SYNC_ENABLE = 1) then
				a_slice_load_sclr <= a_slice_load or (intSCLR and intCE);
			else
				a_slice_load_sclr <= a_slice_load;
			end if;
		else
			intSCLR_PURE <= gnd;
			intSCLR <= gnd;
			a_slice_load_sclr <= a_slice_load;
		end if;
		if (C_HAS_ND = 1) then
			if (C_REG_A_B_INPUTS = 1) then
				int_nd <= regND;
			else
				int_nd <= ND;
			end if;
		else
			int_nd <= vcc;
		end if;
		if (C_MULT_TYPE < 2) then
			b_held <= regBB;
		elsif (C_MULT_TYPE > 2) then
			b_held <= b;
		else
			b_held <= b_reg;
		end if;
		if (C_REG_A_B_INPUTS = 1) then
			a_reg <= regA;
			b_reg <= regB;
			a_signed_reg <= regA_SIGNED;
			slice_rfd <= reg_rfd;
		else
			a_reg <= a;
			b_reg <= b;
			a_signed_reg <= a_signed;
			slice_rfd <= intRFD;
		end if;
		--Combine int_sclr, loadb and swapb, CE and mult_rfd to reset rfd as appropriate depending on C_SYNC_ENABLE
		if (C_HAS_SWAPB = 1) then
			if (C_SYNC_ENABLE = 1 and C_HAS_CE = 1) then
				int_sclr_loadb_swapb <= intSCLR or (intSWAPB and intCE);
			else
				int_sclr_loadb_swapb <= intSCLR or intSWAPB;
			end if;
		elsif (C_HAS_LOADB = 1) then
			if (C_SYNC_ENABLE = 1 and C_HAS_CE = 1) then
				int_sclr_loadb_swapb <= intSCLR or ((not mult_rfd) and intCE);
			else
				int_sclr_loadb_swapb <= intSCLR or (not mult_rfd);
			end if;
		else
			int_sclr_loadb_swapb <= intSCLR;
		end if;
		if (C_HAS_A_SIGNED = 1) then
			int_a_signed <= a_signed_held;
		elsif (C_A_TYPE = c_signed and C_SQM_TYPE = 0) then
			int_a_signed <= vcc;
		else
			int_a_signed <= gnd;
		end if;
		if (accum_delay >= 0) then
			accum_load <= accum_pipe(accum_delay);
		else
			accum_load <= a_slice_load_sclr;
		end if;
		if (number_clocks - C_REG_A_B_INPUTS - 1 > 0) then
			pipe_rfd <= rfd_pipe(number_clocks-C_REG_A_B_INPUTS-2);
		else
			pipe_rfd <= a_slice_load_sclr;
		end if;
		if (C_HAS_A_SIGNED = 1) then
			if (C_REG_A_B_INPUTS+1-ccm_serial = 0) then
				mult_signed <= int_mult_signed1;
			else
				mult_signed <= pipe_mult_signed;
			end if;
		else
			mult_signed <= pipe_mult_signed and a_slice(C_BAAT-1);
		end if;
		if (C_REG_A_B_INPUTS+1-ccm_serial = 0) then
			pipe_mult_signed <= pipe_rfd;
		else
			pipe_mult_signed <= mult_signed_pipe(C_REG_A_B_INPUTS+1-ccm_serial-1);
		end if;
		if (C_LATENCY > 0) then
			accum_sign <= accum_sign_pipe(C_LATENCY-1);
		else
			accum_sign <= mult_signed;
		end if;
		if (C_PIPELINE = 1 or blk_mem_adjust = 1) then
			mult_out <= mult_q;
		else
			mult_out <= mult_o;
		end if;
		if (C_HAS_RDY = 1) then
			if (C_OUTPUT_HOLD = 1) then
				RDY <= int_rdy_pipe(rdy_delay);
			else
				RDY <= int_rdy;
			end if;
		else
			RDY <= 'X';
		end if;
		if (C_OUTPUT_HOLD = 1) then
			int_q_ce <= intCE and int_rdy;
		else
			int_q_ce <= intCE;
		end if;
		if (C_HAS_RFD = 1) then
			RFD <= intRFD;
		else
			RFD <= 'X';
		end if;
		if (C_HAS_O = 1) then
			O <= intO;
		else
			O <= (others => 'X');
		end if;
		if (C_HAS_Q = 1) then
			Q <= intQ;
		else
			Q <= (others => 'X');
		end if;
	end process generate_inputs;

	
	--Process to calculate output when the clears go high.
	--In addition action on the SWAPB and LOADB pins also cause the sequential multiplier to 
	--de-assert RFD.
	rfd_assign : process(intACLR, intSCLR, int_sclr_loadb_swapb, int_rfd_reg)
	begin
		if (intACLR = '1' or int_sclr_loadb_swapb = '1') then 
			intRFD <= '0';
		else
			intRFD <= int_rfd_reg;
		end if;
	end process rfd_assign;

	--Register rfd for serial parallel type
	register_rfd : process(CLK, intACLR)
	begin
		if (intACLR = '1') then
			reg_rfd <= '0';
		elsif (CLK'event and CLK = '1') then
			if (int_sclr_loadb_swapb = '1') then
				reg_rfd <= '0';
			elsif (intCE = '1') then
				reg_rfd <= intRFD;
			end if;
		end if;
	end process register_rfd;

	--int_rfd_reg
	rfd_reg_assign : process(CLK, intACLR)
	begin
		if (intACLR = '1') then
			int_rfd_reg <= '1';
		elsif (CLK'event and CLK = '1') then
			if (int_sclr_loadb_swapb = '1') then
				int_rfd_reg <= '1';
			elsif (intCE = '1') then
				if (C_HAS_ND = 1) then
					int_rfd_reg <= (pipe_rfd and (not intRFD)) or (intRFD and (not ND));
				else
					int_rfd_reg <= pipe_rfd and (not intRFD);
				end if;
			end if;
		end if;
	end process rfd_reg_assign;
	
	--mult_sign serial
	sign_multiplier1 : process(pipe_rfd, a_signed_reg, a_signed_held)
	begin
		if (C_HAS_A_SIGNED = 1 and C_REG_A_B_INPUTS+1-ccm_serial = 0) then
			if (number_clocks-C_REG_A_B_INPUTS = 1) then
				int_mult_signed1 <= pipe_rfd and a_signed_reg;
			else
				int_mult_signed1 <= pipe_rfd and a_signed_held;
			end if;
		end if;
	end process sign_multiplier1;
	
	--int_mult_signed
	sign_multiplier2 : process(pipe_rfd, a_signed_reg, a_signed_held, pipe_mult_signed, a_slice)
	begin
		if (C_HAS_A_SIGNED = 1) then
			if (number_clocks-C_REG_A_B_INPUTS = 1) then
				int_mult_signed2 <= pipe_rfd and a_signed_reg;
			else
				int_mult_signed2 <= pipe_rfd and a_signed_held;
			end if;
		else
			int_mult_signed2 <= pipe_rfd;
		end if;
	end process sign_multiplier2;

	--int_rdy
	ready : process(CLK, intACLR)
	begin
		if (intACLR = '1') then
			int_rdy_pipe <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			if (intSCLR = '1') then
				int_rdy_pipe <= (others => '0');
			elsif (intCE = '1') then
				if (rdy_delay > 0) then
					int_rdy_pipe(rdy_delay downto 1) <= int_rdy_pipe(rdy_delay-1 downto 0);
				end if;
			int_rdy_pipe(0) <= pipe_rfd;
			end if;
		end if;
	end process ready;

    -- Pipelines
	pipeline : process(CLK, intACLR)
	begin
		if (intACLR = '1') then
			if (C_LATENCY >= 0) then
				accum_pipe <= (others => '0');
			end if;
			if (C_REG_A_B_INPUTS+1-ccm_serial > 0) then
				mult_signed_pipe <= (others => '0');
			end if;
		elsif (CLK'event and CLK = '1') then
			if (intSCLR = '1') then
				if (C_LATENCY >= 0) then
					accum_pipe <= (others => '0');
				end if;
				if (C_REG_A_B_INPUTS+1-ccm_serial > 0) then
					mult_signed_pipe <= (others => '0');
				end if;
			elsif (intCE = '1') then
				if (C_LATENCY > 0) then
					accum_pipe(C_LATENCY downto 1) <= accum_pipe(C_LATENCY-1 downto 0);
				end if;
				if (C_LATENCY >= 0) then
					accum_pipe(0) <= a_slice_load_sclr;
				end if;
				if (C_REG_A_B_INPUTS+1-ccm_serial > 1) then
					mult_signed_pipe(C_REG_A_B_INPUTS+1-ccm_serial-1 downto  1) <= mult_signed_pipe(C_REG_A_B_INPUTS+1-ccm_serial-2 downto 0);
				end if;
				if (C_REG_A_B_INPUTS+1-ccm_serial > 0) then
					mult_signed_pipe(0) <= int_mult_signed2;
				end if;
			end if;
		end if;
	end process pipeline;

	--rfd pipeline
	rfd_pipeline : process(CLK, intACLR)
	begin
		if (intACLR = '1') then
			rfd_pipe <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			if (int_sclr_loadb_swapb = '1') then
				rfd_pipe <= (others => '0');
			elsif (intCE = '1') then
				if (number_clocks-C_REG_A_B_INPUTS > 1) then
					rfd_pipe(number_clocks-C_REG_A_B_INPUTS-1 downto 1) <= rfd_pipe(number_clocks-C_REG_A_B_INPUTS-2 downto 0);
				end if;
				rfd_pipe(0) <= a_slice_load_sclr;
			end if;
		end if;
	end process rfd_pipeline;

    tmp1 : process(accum_out, accum_store)
    begin
      accum_complete(accum_width+accum_store_width-1 downto accum_store_width) <= accum_out(accum_width-1 downto 0);
	  accum_complete(accum_store_width-1 downto 0) <= accum_store;
    end process tmp1;

	--Slice the A input
		slicer : process(CLK, intACLR, a_reg)
		begin
            if (C_SQM_TYPE = 1 and C_MULT_TYPE >= 2) then
               a_load(0 downto 0) <= a_reg;
            elsif (C_SQM_TYPE /= 1 or C_MULT_TYPE < 2) then
			if (intACLR = '1') then
				a_load <= (others => '0');
			elsif (CLK'event and CLK = '1') then
				if (intSCLR = '1') then
					a_load <= (others => '0');
				elsif (intCE = '1') then
					if (C_SQM_TYPE = 0) then	--need to slice
						if (a_slice_load = '1') then
							a_load(C_A_WIDTH-1 downto 0) <= a_reg;
							for i in 0 to (C_BAAT*number_clocks)-C_A_WIDTH-1 loop	--sign extend as required
								if (C_HAS_A_SIGNED = 1) then
									if (a_signed_reg = '1') then
										a_load((C_BAAT*number_clocks)-1-i) <= a_reg(C_A_WIDTH-1-((C_A_WIDTH-1)*C_SQM_TYPE));
									else
										a_load((C_BAAT*number_clocks)-1-i) <= '0';
									end if;
								elsif (C_A_TYPE = c_signed) then
									a_load((C_BAAT*number_clocks)-1-i) <= a_reg(C_A_WIDTH-1-((C_A_WIDTH-1)*C_SQM_TYPE));
								else
									a_load((C_BAAT*number_clocks)-1-i) <= '0';
								end if;
							end loop;
						else
							a_load((C_BAAT*(number_clocks-1))-1 downto 0) <= a_load((C_BAAT*number_clocks)-1 downto C_BAAT);
							for i in 0 to C_BAAT-1 loop
								if (int_a_signed = '1') then
									a_load((C_BAAT*number_clocks)-1-i) <= a_load((C_BAAT*number_clocks)-1);
								else
									a_load((C_BAAT*number_clocks)-1-i) <= '0';
								end if;
							end loop;
						end if;
					else	--need to pipeline balance if parm
						if (C_MULT_TYPE < 2) then
							if ((intCE = '1' and slice_rfd = '0') or a_slice_load = '1') then

                                if (c_sqm_type = 0) then
                                    a_load(C_A_WIDTH-1 downto 0) <= a_reg;
                                else
                                    a_load(0 downto 0) <= a_reg;
                                end if;
							end if;
						end if;
					end if;
				end if;
			end if;
        end if;
	end process slicer;

	--Accumulate result
	accumulate : process(CLK, intACLR)
	begin
		if (intACLR = '1') then
			accum_out <= (others => '0');
			accum_store <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			if (intSCLR = '1') then
				accum_out <= (others => '0');
				accum_store <= (others => '0');
			elsif (intCE = '1') then
				if (accum_store_width > C_BAAT) then
					accum_store(accum_store_width-1-C_BAAT+temp_accum downto 0) <= accum_store(accum_store_width-1+temp_accum downto C_BAAT);
				end if;
				accum_store(accum_store_width-1 downto accum_store_width-C_BAAT) <= accum_out(C_BAAT-1 downto 0);
				if (accum_load = '1') then
					accum_out(accum_mult_width-1 downto 0) <= accum_in;
					if (accum_mult_width-mult_width = 0) then
						accum_out(accum_width-1) <= '0';
					end if;
				else
					if (accum_mult_width-mult_width = 0) then
						--accum_out <= ('0' & accum_in) + accum_feedback;
                                                accum_out <= accum_out_nem + accum_feedback;
					else 
						accum_out <= accum_in + accum_feedback;
					end if;
				end if;
			end if;
		end if;
	end process accumulate;

	--Feedback accumulator output
	feedback : process(accum_out)
	begin
		accum_feedback(accum_width-C_BAAT-1 downto 0) <= accum_out(accum_width-1 downto C_BAAT);
		if (C_B_TYPE = c_signed) then
			for i in 0 to C_BAAT-1 loop
				accum_feedback(accum_width-1-i) <= accum_out(accum_width-1);
			end loop;
		else
			for i in 0 to C_BAAT-1 loop
				accum_feedback(accum_width-1-i) <= '0';
			end loop;
		end if;
	end process;

	--accum_in
	accum_input : process(mult_out, accum_sign)
	begin
		if (accum_sign_needed = 1) then
			if (C_B_TYPE = c_signed) then
				accum_in(accum_mult_width-1) <= mult_out(accum_mult_width-2+temp_mult);
			elsif (mult_has_a_signed = 1) then
				accum_in(accum_mult_width-1) <= accum_sign and mult_out(accum_mult_width-2+temp_mult);
			end if;
		else
			accum_in(accum_mult_width-1) <= mult_out(mult_width-1);
		end if;
        if (accum_mult_width > 1) then
		  accum_in(accum_mult_width-2+temp_mult downto 0) <= mult_out(accum_mult_width-2+temp_mult downto 0);
	    end if;
	end process accum_input;

	--accum_sign
	accumulator_sign : process(CLK, intACLR)
	begin
		if (intACLR = '1') then
			if (C_LATENCY > 0) then
				accum_sign_pipe <= (others => '0');
			end if;
		elsif (CLK'event and CLK = '1') then
			if (intSCLR = '1') then
				if (C_LATENCY > 0) then
					accum_sign_pipe <= (others => '0');
				end if;
			elsif (intCE = '1') then
	   			if (C_LATENCY > 1) then
					accum_sign_pipe((C_LATENCY+(latency_temp*2)-1) downto 1) <= accum_sign_pipe(C_LATENCY+(latency_temp*2)-2 downto 0);
				end if;
				if (C_LATENCY > 0) then
					accum_sign_pipe(0) <= mult_signed;
				end if;
			end if;
		end if;
	end process accumulator_sign;
   
    --O generation
	o_gen1 : if (C_OUT_WIDTH <= (C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED)) generate
		i1 : intO <= accum_complete(C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED-1 downto C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED-C_OUT_WIDTH);
	end generate;

	o_gen2 : if (C_OUT_WIDTH > C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED) generate
		i2 : intO(C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED-1 downto 0) <= accum_complete(C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED-1 downto 0);
		i3 : if (accum_sign_needed = 1) generate
			i4 : if (C_B_TYPE = c_signed) generate
				i5 : for i in 0 to (C_OUT_WIDTH-(C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED)-1) generate
					intO(C_OUT_WIDTH-1-i) <= accum_complete(accum_width+accum_store_width-1);
				end generate;
            end generate;
            i6 : if (C_B_TYPE /= c_signed) generate
				i7 : for i in 0 to (C_OUT_WIDTH-(C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED)-1) generate
					intO(C_OUT_WIDTH-1-i) <= accum_mult_out_msb_delayed;
				end generate;
			end generate;
        end generate;
        i8 : if (accum_sign_needed /= 1) generate
			i9 : for i in 0 to (C_OUT_WIDTH-(C_A_WIDTH+C_B_WIDTH+C_HAS_A_SIGNED)-1) generate
				intO(C_OUT_WIDTH-1-i) <= '0';
			end generate;
		end generate;
	end generate;

end behavioral;
