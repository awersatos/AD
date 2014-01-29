--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.cic_compiler_v1_2_pkg.all;

library work;
    
entity cic_compiler_v1_2_decimate_bhv is
  generic (
    C_NUM_STAGES : integer := 4;
    C_DIFF_DELAY : integer := 1;
    C_RATE : integer := 4;
    C_INPUT_WIDTH : integer := 18;
    C_OUTPUT_WIDTH : integer := 26;
    C_USE_DSP : integer := 0;
    C_HAS_ROUNDING : integer := 0;
    C_NUM_CHANNELS  : integer := 1;
    C_PIPE_SUBWORD_WIDTH  : integer := 0;
    C_RATE_TYPE : integer := 0;
    C_MIN_RATE : integer := 4;
    C_MAX_RATE : integer := 4;
    C_SAMPLE_FREQ : integer := 100;
    C_CLK_FREQ : integer := 100;
    C_OVERCLOCK : integer := 1;
    C_HAS_CE : integer := 0;
    C_HAS_SCLR : integer := 0;
    C_FAMILY : string := "virtex4";
    C_COMB_WIDTHS : stage_array := (others => 0);
    C_INT_WIDTHS : stage_array := (others => 0);
    C_LATENCY : string := "zero_latency"
    );
  port ( 
    DIN : in  std_logic_vector (C_INPUT_WIDTH-1 downto 0);
    ND : in  std_logic;
    RATE : in std_logic_vector (number_of_digits(C_MAX_RATE,2)-1 downto 0);
    RATE_WE : in std_logic;
    CE : in  std_logic;
    SCLR : in  std_logic;
    CLK : in  std_logic;
    DOUT : out  std_logic_vector (C_OUTPUT_WIDTH-1 downto 0);
    RDY : out std_logic;
    RFD : out std_logic;
    CHAN_SYNC : out std_logic;
    CHAN_OUT : out std_logic_vector (get_max(1,number_of_digits(C_NUM_CHANNELS-1,2))-1 downto 0)
    );
end cic_compiler_v1_2_decimate_bhv;

architecture behavioral of cic_compiler_v1_2_decimate_bhv is
	constant pipe_subword_width : integer := C_PIPE_SUBWORD_WIDTH;
        constant max_WIDTH_c : integer := C_COMB_WIDTHS(0);
        constant comb_processing_stage_latency : integer := COMB_STAGE_PROCESSING_LATENCY(max_WIDTH_c,pipe_subword_width,C_USE_DSP,C_FAMILY);

	-- define latency
	constant INTEGRATOR_FOLDING : integer := INT_FOLDING_FACTOR(C_OVERCLOCK, C_MIN_RATE, C_NUM_STAGES, C_NUM_CHANNELS, 1);
	constant COMB_FOLDING : integer := COMB_FOLDING_FACTOR(C_OVERCLOCK, C_MIN_RATE, C_NUM_STAGES, C_NUM_CHANNELS, 1, C_USE_DSP,comb_processing_stage_latency);


	constant LATENCY : integer := DEC_LATENCY(C_LATENCY,C_MAX_RATE,C_MIN_RATE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_INPUT_WIDTH,C_DIFF_DELAY,C_RATE_TYPE,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY); -- use max rate to compute worst case latency
	signal latency_ptr : integer := LATENCY - DEC_LATENCY(C_LATENCY,C_RATE,C_MIN_RATE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_INPUT_WIDTH,C_DIFF_DELAY,C_RATE_TYPE,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY);
	-- define arrays for bit trimming
	type CIC_INT_I_ARRAY is array (1 to 6) of integer;
	type CIC_INT_C_ARRAY is array (1 to 7) of integer;

	-- define constants for register sizing
	constant BMAX : integer := CICBMAX(C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY);
	constant DYN_SCALE_BITS : integer := BMAX - CICBMAX(C_INPUT_WIDTH,C_MIN_RATE,C_NUM_STAGES,C_DIFF_DELAY);

	constant I_REG_WIDTHS : CIC_INT_I_ARRAY := (MAX(C_INT_WIDTHS(0),1), MAX(C_INT_WIDTHS(1),1), MAX(C_INT_WIDTHS(2),1), MAX(C_INT_WIDTHS(3),1), MAX(C_INT_WIDTHS(4),1), MAX(C_INT_WIDTHS(5),1));
	
	constant I_REG_SHIFT : CIC_INT_I_ARRAY := ((BMAX-I_REG_WIDTHS(1)), (I_REG_WIDTHS(1)-I_REG_WIDTHS(2)), (I_REG_WIDTHS(2)-I_REG_WIDTHS(3)), (I_REG_WIDTHS(3)-I_REG_WIDTHS(4)),(I_REG_WIDTHS(4)-I_REG_WIDTHS(5)), (I_REG_WIDTHS(5)-I_REG_WIDTHS(6)));

	constant C_REG_WIDTHS : CIC_INT_C_ARRAY := (MAX(C_COMB_WIDTHS(0),C_OUTPUT_WIDTH),MAX(C_COMB_WIDTHS(1),C_OUTPUT_WIDTH),MAX(C_COMB_WIDTHS(2),C_OUTPUT_WIDTH),MAX(C_COMB_WIDTHS(3),C_OUTPUT_WIDTH),MAX(C_COMB_WIDTHS(4),C_OUTPUT_WIDTH),MAX(C_COMB_WIDTHS(5),C_OUTPUT_WIDTH), C_OUTPUT_WIDTH);

	constant C_REG_SHIFT : CIC_INT_C_ARRAY := ((I_REG_WIDTHS(C_NUM_STAGES)-C_REG_WIDTHS(1)), (C_REG_WIDTHS(1)-C_REG_WIDTHS(2)), (C_REG_WIDTHS(2)-C_REG_WIDTHS(3)), (C_REG_WIDTHS(3)-C_REG_WIDTHS(4)), (C_REG_WIDTHS(4)-C_REG_WIDTHS(5)), (C_REG_WIDTHS(5)-C_REG_WIDTHS(6)), C_REG_WIDTHS(6)-C_REG_WIDTHS(7));


	-- define registers with appropriate sizes - model with zero latency
	-- Integrator sections
	type I_1_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(I_REG_WIDTHS(1)-1 downto 0);
	type I_2_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(I_REG_WIDTHS(2)-1 downto 0);
	type I_3_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(I_REG_WIDTHS(3)-1 downto 0);
	type I_4_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(I_REG_WIDTHS(4)-1 downto 0);
	type I_5_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(I_REG_WIDTHS(5)-1 downto 0);
	type I_6_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(I_REG_WIDTHS(6)-1 downto 0);
	signal I_1 : I_1_ARRAY := (others => to_signed(0,I_REG_WIDTHS(1)));
	signal I_2 : I_2_ARRAY := (others => to_signed(0,I_REG_WIDTHS(2)));
	signal I_3 : I_3_ARRAY := (others => to_signed(0,I_REG_WIDTHS(3)));
	signal I_4 : I_4_ARRAY := (others => to_signed(0,I_REG_WIDTHS(4)));
	signal I_5 : I_5_ARRAY := (others => to_signed(0,I_REG_WIDTHS(5)));
	signal I_6 : I_6_ARRAY := (others => to_signed(0,I_REG_WIDTHS(6)));


	-- Comb sections differential delay registers - as many as number of stage times diff delay
	type C_1_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(1)-1 downto 0);
	type C_2_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(2)-1 downto 0);
	type C_3_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(3)-1 downto 0);
	type C_4_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(4)-1 downto 0);
	type C_5_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(5)-1 downto 0);
	type C_6_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(6)-1 downto 0);

	signal CM1_1 : C_1_ARRAY := (others => to_signed(0,C_REG_WIDTHS(1)));
	signal CM1_2 : C_2_ARRAY := (others => to_signed(0,C_REG_WIDTHS(2)));
	signal CM1_3 : C_3_ARRAY := (others => to_signed(0,C_REG_WIDTHS(3)));
	signal CM1_4 : C_4_ARRAY := (others => to_signed(0,C_REG_WIDTHS(4)));
	signal CM1_5 : C_5_ARRAY := (others => to_signed(0,C_REG_WIDTHS(5)));
	signal CM1_6 : C_6_ARRAY := (others => to_signed(0,C_REG_WIDTHS(6)));

	signal CM2_1 : C_1_ARRAY := (others => to_signed(0,C_REG_WIDTHS(1)));
	signal CM2_2 : C_2_ARRAY := (others => to_signed(0,C_REG_WIDTHS(2)));
	signal CM2_3 : C_3_ARRAY := (others => to_signed(0,C_REG_WIDTHS(3)));
	signal CM2_4 : C_4_ARRAY := (others => to_signed(0,C_REG_WIDTHS(4)));
	signal CM2_5 : C_5_ARRAY := (others => to_signed(0,C_REG_WIDTHS(5)));
	signal CM2_6 : C_6_ARRAY := (others => to_signed(0,C_REG_WIDTHS(6)));

	type DEC_CNT_ARRAY is array (0 to C_NUM_CHANNELS-1) of integer; 
	constant log2_rate : integer := number_of_digits(C_MAX_RATE,2);
	signal dec_cnt : DEC_CNT_ARRAY := (others => 0);

	-- multi-channel related objects
	constant log2_num_chan : integer := get_max(1,number_of_digits(C_NUM_CHANNELS-1,2));
	signal chan_cnt : integer := 0;
	signal chan_sync_out : std_logic_vector  (LATENCY downto 0) := (others => '0');
	type CHAN_OUT_ARRAY is array (LATENCY downto 0) of std_logic_vector (log2_num_chan-1 downto 0);
	signal chan_out_out : CHAN_OUT_ARRAY := (others => int_to_slv(0,log2_num_chan));

	signal rdy_out : std_logic_vector  (LATENCY downto 0) := (others => '0');
	type DOUT_ARRAY is array (LATENCY downto 0) of std_logic_vector (C_OUTPUT_WIDTH-1 downto 0);
	signal dout_out : DOUT_ARRAY := (others => int_to_slv(0,C_OUTPUT_WIDTH));

begin


	-- decimator processing; handles ...
	-- single channel, multi-channel
	-- fixed rate, variable rate

	-- decimator is always ready to accept data
	rfd <= '1';

	dout <= dout_out(latency_ptr) when (rdy_out(latency_ptr) = '1') else (others=>'X');
	--dout <= dout_out(latency_ptr);
	dout_process : process(clk)
	begin
		if rising_edge(clk) then
			if (LATENCY > 0 and RATE_WE = '0') then
				dout_out(LATENCY-1 downto 0) <= dout_out(LATENCY downto 1);
			elsif (LATENCY > 0 and RATE_WE = '1') then
				dout_out(LATENCY-1 downto 0) <= (others => int_to_slv(0,C_OUTPUT_WIDTH));
			end if;	
		end if;
	end process;

	rdy <= rdy_out(latency_ptr);
	rdy_processs : process(clk)
	begin
		if rising_edge(clk) then
			if (LATENCY > 0 and RATE_WE = '0') then
				rdy_out(LATENCY-1 downto 0) <= rdy_out(LATENCY downto 1);
			elsif (LATENCY > 0 and RATE_WE = '1') then
				rdy_out(LATENCY-1 downto 0) <= (others => '0');
			end if;		
		end if;
	end process;

	chan_sync <= chan_sync_out(latency_ptr) when (rdy_out(latency_ptr) = '1') else 'X';
	--chan_sync <= chan_sync_out(latency_ptr);
	ch_sync_processs : process(clk)
	begin
		if rising_edge(clk) then
			if (LATENCY > 0 and RATE_WE = '0') then
				chan_sync_out(LATENCY-1 downto 0) <= chan_sync_out(LATENCY downto 1);
			elsif (LATENCY > 0 and RATE_WE = '1') then
				chan_sync_out(LATENCY-1 downto 0) <= (others => '0');
			end if;	
		end if;
	end process;

	chan_out <= chan_out_out(latency_ptr) when (rdy_out(latency_ptr) = '1') else (others=>'X');
	--chan_out <= chan_out_out(latency_ptr);
	ch_out_processs: process(clk)
	begin
		if rising_edge(clk) then
			if (LATENCY > 0 and RATE_WE = '0') then
				chan_out_out(LATENCY-1 downto 0) <= chan_out_out(LATENCY downto 1);
			elsif (LATENCY > 0 and RATE_WE = '1') then
				chan_out_out(LATENCY-1 downto 0) <= (others => int_to_slv(0,log2_num_chan));
			end if;	
		end if;
	end process;

	-- zero-latency processing qualified by the assertion of ND
	decimator : process

		variable din_ext : signed(I_REG_WIDTHS(1)-1 downto 0) := (others => '0');
		variable din_pad : signed(C_INPUT_WIDTH+DYN_SCALE_BITS-1 downto 0);
		variable dyn_scale_bits_var : integer := BMAX - CICBMAX(C_INPUT_WIDTH,C_RATE,C_NUM_STAGES,C_DIFF_DELAY);
		variable It_1 : signed(I_REG_WIDTHS(1)-1 downto 0) := (others => '0');
		variable It_2 : signed(I_REG_WIDTHS(2)-1 downto 0) := (others => '0');
		variable It_3 : signed(I_REG_WIDTHS(3)-1 downto 0) := (others => '0');
		variable It_4 : signed(I_REG_WIDTHS(4)-1 downto 0) := (others => '0');
		variable It_5 : signed(I_REG_WIDTHS(5)-1 downto 0) := (others => '0');
		variable It_6 : signed(I_REG_WIDTHS(6)-1 downto 0) := (others => '0');
		variable I_result : signed(I_REG_WIDTHS(C_NUM_STAGES)-1 downto 0) := (others => '0');

		variable Ct_1 : signed(C_REG_WIDTHS(2)-1 downto 0) := (others => '0');
		variable Ct_2 : signed(C_REG_WIDTHS(3)-1 downto 0) := (others => '0');
		variable Ct_3 : signed(C_REG_WIDTHS(4)-1 downto 0) := (others => '0');
		variable Ct_4 : signed(C_REG_WIDTHS(5)-1 downto 0) := (others => '0');
		variable Ct_5 : signed(C_REG_WIDTHS(6)-1 downto 0) := (others => '0');
		variable Ct_6 : signed(C_REG_WIDTHS(7)-1 downto 0) := (others => '0');
		variable C_result : signed(C_REG_WIDTHS(C_NUM_STAGES+1)-1 downto 0) := (others => '0');

		variable rdy_var : std_logic := '0';
		variable chan_sync_var : std_logic := '0';
		variable dec_cnt_var : DEC_CNT_ARRAY := (others => 0);
		variable chan_cnt_var : integer := 0;

		variable rate_val : integer := C_RATE; -- count value for rate control

	begin
		wait until rising_edge(clk);

		rdy_var := '0'; -- not ready unless set inside decimated processing
		chan_cnt_var := chan_cnt;
		dec_cnt_var := dec_cnt;

		if (SCLR = '0') and (RATE_WE = '0') then

		if nd = '1' then

			-- process new input
			-- sign extend input data
			--din_ext := resize(signed(din),I_REG_WIDTHS(1));
			if (C_RATE_TYPE = 1) and (DYN_SCALE_BITS > 0) and (C_OUTPUT_WIDTH < C_REG_WIDTHS(C_NUM_STAGES)) then
				-- dynamic scaling
				din_pad(C_INPUT_WIDTH+DYN_SCALE_BITS-1 downto DYN_SCALE_BITS) := signed(din);
				din_pad(DYN_SCALE_BITS-1 downto 0) := (others => '0');
				din_pad := SHIFT_RIGHT(din_pad,DYN_SCALE_BITS-dyn_scale_bits_var);
				din_ext := resize(signed(din_pad),I_REG_WIDTHS(1));
			else
				-- no scaling needed
				din_ext := resize(signed(din),I_REG_WIDTHS(1));
			end if;

			-- integrators
			It_1 := I_1(chan_cnt) + resize(shift_right(din_ext,I_REG_SHIFT(1)),I_REG_WIDTHS(1));
			I_1(chan_cnt) <= It_1;
			It_2 := I_2(chan_cnt) + resize(shift_right(It_1,I_REG_SHIFT(2)),I_REG_WIDTHS(2));
			I_2(chan_cnt) <= It_2;
			It_3 := I_3(chan_cnt) + resize(shift_right(It_2,I_REG_SHIFT(3)),I_REG_WIDTHS(3));
			I_3(chan_cnt) <= It_3;
			It_4 := I_4(chan_cnt) + resize(shift_right(It_3,I_REG_SHIFT(4)),I_REG_WIDTHS(4));
			I_4(chan_cnt) <= It_4;
			It_5 := I_5(chan_cnt) + resize(shift_right(It_4,I_REG_SHIFT(5)),I_REG_WIDTHS(5));
			I_5(chan_cnt) <= It_5;
			It_6 := I_6(chan_cnt) + resize(shift_right(It_5,I_REG_SHIFT(6)),I_REG_WIDTHS(6));
			I_6(chan_cnt) <= It_6;

			case C_NUM_STAGES is
				when 1 => I_result := It_1;
				when 2 => I_result := It_2; 
				when 3 => I_result := It_3; 
				when 4 => I_result := It_4; 
				when 5 => I_result := It_5; 
				when 6 => I_result := It_6;
				when others => I_result := It_1;
			end case;

			chan_sync_var := '0'; -- no channel sync unless deterined in decimated processing

			-- combs
  			-- compare value controls phase of decimation
			-- this in turn should be set to match input register delay in implementation model
			if dec_cnt(chan_cnt) = (0) then

				Ct_1 := resize(shift_right(resize(shift_right(I_result,C_REG_SHIFT(1)),C_REG_WIDTHS(1)) - CM1_1(chan_cnt),C_REG_SHIFT(2)),C_REG_WIDTHS(2));
				Ct_2 := resize(shift_right((Ct_1 - CM1_2(chan_cnt)),C_REG_SHIFT(3)),C_REG_WIDTHS(3));
				Ct_3 := resize(shift_right((Ct_2 - CM1_3(chan_cnt)),C_REG_SHIFT(4)),C_REG_WIDTHS(4));
				Ct_4 := resize(shift_right((Ct_3 - CM1_4(chan_cnt)),C_REG_SHIFT(5)),C_REG_WIDTHS(5));
				Ct_5 := resize(shift_right((Ct_4 - CM1_5(chan_cnt)),C_REG_SHIFT(6)),C_REG_WIDTHS(6));
				Ct_6 := resize(shift_right((Ct_5 - CM1_6(chan_cnt)),C_REG_SHIFT(7)),C_REG_WIDTHS(7));

				if C_DIFF_DELAY = 1 then
					CM1_1(chan_cnt) <= resize(shift_right(I_result,C_REG_SHIFT(1)),C_REG_WIDTHS(1));
					CM1_2(chan_cnt) <= Ct_1;
					CM1_3(chan_cnt) <= Ct_2;
					CM1_4(chan_cnt) <= Ct_3;
					CM1_5(chan_cnt) <= Ct_4;
					CM1_6(chan_cnt) <= Ct_5;
				else
					CM1_1(chan_cnt) <= CM2_1(chan_cnt);
					CM1_2(chan_cnt) <= CM2_2(chan_cnt);
					CM1_3(chan_cnt) <= CM2_3(chan_cnt);
					CM1_4(chan_cnt) <= CM2_4(chan_cnt);
					CM1_5(chan_cnt) <= CM2_5(chan_cnt);
					CM1_6(chan_cnt) <= CM2_6(chan_cnt);

					CM2_1(chan_cnt) <=  resize(shift_right(I_result,C_REG_SHIFT(1)),C_REG_WIDTHS(1));
					CM2_2(chan_cnt) <= Ct_1;
					CM2_3(chan_cnt) <= Ct_2;
					CM2_4(chan_cnt) <= Ct_3;
					CM2_5(chan_cnt) <= Ct_4;
					CM2_6(chan_cnt) <= Ct_5;
				end if;

				case C_NUM_STAGES is
					when 1 => C_result := Ct_1;
					when 2 => C_result := Ct_2; 
					when 3 => C_result := Ct_3; 
					when 4 => C_result := Ct_4; 
					when 5 => C_result := Ct_5; 
					when 6 => C_result := Ct_6;
					when others => C_result := Ct_1;
				end case;

				dout_out(LATENCY) <= std_logic_vector(C_result);

				chan_out_out(LATENCY) <= int_to_slv(chan_cnt,log2_num_chan);
				rdy_var := '1';

				if chan_cnt = (0) then
					if C_NUM_CHANNELS > 1 then
						chan_sync_var := '1'; -- tag channel 0 if multi-channel
					else
						chan_sync_var := '0';
					end if;
				end if;

			end if;

			-- drive IF signals
			-- update decimation counter
			if dec_cnt(chan_cnt) = (rate_val - 1) then
				dec_cnt_var(chan_cnt) := 0;
			else
				dec_cnt_var(chan_cnt) := dec_cnt(chan_cnt) + 1;
			end if;
			
			-- update multi-channel output signals
			if chan_cnt = (C_NUM_CHANNELS - 1) then
				chan_cnt_var := 0;
			else
				chan_cnt_var := chan_cnt + 1;
			end if;

			chan_sync_out(LATENCY) <= chan_sync_var;

		end if;

		else 
			if RATE_WE = '1' then
				rate_val := conv_integer(RATE); -- capture new rate value
				latency_ptr <= LATENCY - DEC_LATENCY(C_LATENCY,rate_val,C_MIN_RATE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_INPUT_WIDTH,C_DIFF_DELAY,C_RATE_TYPE,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY);
				dyn_scale_bits_var := BMAX - CICBMAX(C_INPUT_WIDTH,rate_val,C_NUM_STAGES,C_DIFF_DELAY);
			end if;

			dout_out(LATENCY) <= int_to_slv(0,C_OUTPUT_WIDTH);
			rdy_var := '0';
			chan_sync_out(LATENCY) <= '0';
			chan_out_out(LATENCY) <= int_to_slv(0,log2_num_chan);

			-- reset filter state
			I_1 <= (others => to_signed(0,I_REG_WIDTHS(1)));
			I_2 <= (others => to_signed(0,I_REG_WIDTHS(2)));
			I_3 <= (others => to_signed(0,I_REG_WIDTHS(3)));
			I_4 <= (others => to_signed(0,I_REG_WIDTHS(4)));
			I_5 <= (others => to_signed(0,I_REG_WIDTHS(5)));
			I_6 <= (others => to_signed(0,I_REG_WIDTHS(6)));

			CM1_1 <= (others => to_signed(0,C_REG_WIDTHS(1)));
			CM1_2 <= (others => to_signed(0,C_REG_WIDTHS(2)));
			CM1_3 <= (others => to_signed(0,C_REG_WIDTHS(3)));
			CM1_4 <= (others => to_signed(0,C_REG_WIDTHS(4)));
			CM1_5 <= (others => to_signed(0,C_REG_WIDTHS(5)));
			CM1_6 <= (others => to_signed(0,C_REG_WIDTHS(6)));

			CM2_1 <= (others => to_signed(0,C_REG_WIDTHS(1)));
			CM2_2 <= (others => to_signed(0,C_REG_WIDTHS(2)));
			CM2_3 <= (others => to_signed(0,C_REG_WIDTHS(3)));
			CM2_4 <= (others => to_signed(0,C_REG_WIDTHS(4)));
			CM2_5 <= (others => to_signed(0,C_REG_WIDTHS(5)));
			CM2_6 <= (others => to_signed(0,C_REG_WIDTHS(6)));

			-- reset counters
			dec_cnt_var := (others => 0);
			chan_cnt_var := 0;

		end if;

		-- drive IF signals
		rdy_out(LATENCY) <= rdy_var;

		-- update counter signals
		dec_cnt <= dec_cnt_var;
		chan_cnt <= chan_cnt_var;

	end process;

  
end behavioral;

