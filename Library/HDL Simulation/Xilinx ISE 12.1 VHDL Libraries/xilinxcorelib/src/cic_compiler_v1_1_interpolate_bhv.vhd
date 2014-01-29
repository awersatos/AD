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
use xilinxcorelib.cic_compiler_v1_1_pkg.all;

library work;

entity cic_compiler_v1_1_interpolate_bhv is
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
end cic_compiler_v1_1_interpolate_bhv;

architecture behavioral of cic_compiler_v1_1_interpolate_bhv is
	constant pipe_subword_width : integer := C_PIPE_SUBWORD_WIDTH;
	--constant temp_W_c : stage_array := W_comb(C_NUM_STAGES, C_MAX_RATE, C_DIFF_DELAY, C_INPUT_WIDTH, 0);
	--constant max_WIDTH_c : integer := max(temp_W_c(0),temp_W_c(C_NUM_STAGES-1));
        constant max_WIDTH_c : integer := C_COMB_WIDTHS(C_NUM_STAGES-1);
	constant comb_processing_stage_latency : integer := COMB_STAGE_PROCESSING_LATENCY(max_WIDTH_c,pipe_subword_width,C_USE_DSP,C_FAMILY);

	-- define folding and latency
	constant INTEGRATOR_FOLDING : integer := INT_FOLDING_FACTOR(C_OVERCLOCK, C_MIN_RATE, C_NUM_STAGES, C_NUM_CHANNELS, 0);
	constant COMB_FOLDING : integer := COMB_FOLDING_FACTOR(C_OVERCLOCK, C_MIN_RATE, C_NUM_STAGES, C_NUM_CHANNELS, 0, C_USE_DSP,comb_processing_stage_latency);
	
	-- register sizes
	--constant W_c : stage_array := W_comb(C_NUM_STAGES, C_MAX_RATE, C_DIFF_DELAY, C_INPUT_WIDTH, COMB_FOLDING);
	--constant W_i : stage_array := W_integrator(C_NUM_STAGES, C_MAX_RATE, C_DIFF_DELAY, C_INPUT_WIDTH, INTEGRATOR_FOLDING);

	--constant LATENCY : integer := INT_LATENCY(C_LATENCY,C_MAX_RATE,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,W_c,W_i,C_FAMILY);
	constant LATENCY : integer := INT_LATENCY(C_LATENCY,C_MAX_RATE,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY);
	--signal latency_ptr : integer := LATENCY - INT_LATENCY(C_LATENCY,C_RATE,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,W_c,W_i,C_FAMILY);
	signal latency_ptr : integer := LATENCY - INT_LATENCY(C_LATENCY,C_RATE,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY);


	-- define register arrays for comb and integrator sections
	type CIC_INT_C_ARRAY is array (1 to 6) of integer;
	type CIC_INT_I_ARRAY is array (1 to 6) of integer;

	-- define constants for register sizing
	constant BMAX : integer := CICBMAX(C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY);

	constant C_REG_WIDTHS : CIC_INT_C_ARRAY := (INTERPSTAGEBITS(1,1,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(2,1,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(3,1,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(4,1,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(5,1,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(6,1,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY));

	constant I_REG_WIDTHS : CIC_INT_I_ARRAY := (INTERPSTAGEBITS(1,0,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(2,0,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(3,0,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(4,0,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(5,0,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY),INTERPSTAGEBITS(6,0,C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY));

	-- define registers with appropriate sizes - model with zero latency
	-- Comb sections differential delay registers - as many as number of stage times diff delay
	type C_1_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_INPUT_WIDTH-1 downto 0);
	type C_2_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(1)-1 downto 0);
	type C_3_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(2)-1 downto 0);
	type C_4_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(3)-1 downto 0);
	type C_5_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(4)-1 downto 0);
	type C_6_ARRAY is array (0 to C_NUM_CHANNELS-1) of signed(C_REG_WIDTHS(5)-1 downto 0);

	signal CM1_1 : C_1_ARRAY := (others => to_signed(0,C_INPUT_WIDTH));
	signal CM1_2 : C_2_ARRAY := (others => to_signed(0,C_REG_WIDTHS(1)));
	signal CM1_3 : C_3_ARRAY := (others => to_signed(0,C_REG_WIDTHS(2)));
	signal CM1_4 : C_4_ARRAY := (others => to_signed(0,C_REG_WIDTHS(3)));
	signal CM1_5 : C_5_ARRAY := (others => to_signed(0,C_REG_WIDTHS(4)));
	signal CM1_6 : C_6_ARRAY := (others => to_signed(0,C_REG_WIDTHS(5)));

	signal CM2_1 : C_1_ARRAY := (others => to_signed(0,C_INPUT_WIDTH));
	signal CM2_2 : C_2_ARRAY := (others => to_signed(0,C_REG_WIDTHS(1)));
	signal CM2_3 : C_3_ARRAY := (others => to_signed(0,C_REG_WIDTHS(2)));
	signal CM2_4 : C_4_ARRAY := (others => to_signed(0,C_REG_WIDTHS(3)));
	signal CM2_5 : C_5_ARRAY := (others => to_signed(0,C_REG_WIDTHS(4)));
	signal CM2_6 : C_6_ARRAY := (others => to_signed(0,C_REG_WIDTHS(5)));

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

	-- interpolation rate control
	type INT_CNT_ARRAY is array (0 to C_NUM_CHANNELS-1) of integer; 
	constant log2_rate : integer := number_of_digits(C_MAX_RATE,2);
	signal int_cnt : INT_CNT_ARRAY := (others => (C_RATE+1)); -- init to avoid initial processing 

	-- IF signals
	signal rfd_out : std_logic := '1';

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

	-- ready for data process
	rfd <= rfd_out;

	-- data output process
	dout <= dout_out(latency_ptr);
	dout_process : process(clk)
	begin
		if rising_edge(clk) then
			if LATENCY > 0 then
				if (SCLR = '1') or (RATE_WE = '1') then
					dout_out(LATENCY-1 downto 0) <= (others => int_to_slv(0,C_OUTPUT_WIDTH));
				else
					dout_out(LATENCY-1 downto 0) <= dout_out(LATENCY downto 1);
				end if;
			end if;
		end if;
	end process;

	-- ready data process
	rdy <= rdy_out(latency_ptr);
	rdy_processs : process(clk)
	begin
		if rising_edge(clk) then
			if LATENCY > 0 then
				if (SCLR = '1') or (RATE_WE = '1') then
					rdy_out(LATENCY-1 downto 0) <= (others => '0');
				else
					rdy_out(LATENCY-1 downto 0) <= rdy_out(LATENCY downto 1);
				end if;
			end if;
		end if;

	end process;

	-- channel sync process
	chan_sync <= chan_sync_out(latency_ptr);
	ch_sync_processs : process(clk)
	begin
		if rising_edge(clk) then
			if LATENCY > 0 then
				if (SCLR = '1') or (RATE_WE = '1') then
					chan_sync_out(LATENCY-1 downto 0) <= (others => '0');
				else
					chan_sync_out(LATENCY-1 downto 0) <= chan_sync_out(LATENCY downto 1);
				end if;
			end if;
		end if;
	end process;

	-- channel number out process
	chan_out <= chan_out_out(latency_ptr);
	ch_out_processs: process(clk)
	begin
		if rising_edge(clk) then
			if LATENCY > 0 then
				if (SCLR = '1') or (RATE_WE = '1') then
					chan_out_out(LATENCY-1 downto 0) <= (others => int_to_slv(0,log2_num_chan));
				else
					chan_out_out(LATENCY-1 downto 0) <= chan_out_out(LATENCY downto 1);
				end if;
			end if;
		end if;
	end process;


	-- zero-latency processing
	interpolator : process

		variable din_ext : signed(C_INPUT_WIDTH-1 downto 0) := (others => '0');
		variable Ct_1 : signed(C_REG_WIDTHS(1)-1 downto 0) := (others => '0');
		variable Ct_2 : signed(C_REG_WIDTHS(2)-1 downto 0) := (others => '0');
		variable Ct_3 : signed(C_REG_WIDTHS(3)-1 downto 0) := (others => '0');
		variable Ct_4 : signed(C_REG_WIDTHS(4)-1 downto 0) := (others => '0');
		variable Ct_5 : signed(C_REG_WIDTHS(5)-1 downto 0) := (others => '0');
		variable Ct_6 : signed(C_REG_WIDTHS(6)-1 downto 0) := (others => '0');
		variable C_result : signed(C_REG_WIDTHS(C_NUM_STAGES)-1 downto 0) := (others => '0');

		variable It_1 : signed(I_REG_WIDTHS(1)-1 downto 0) := (others => '0');
		variable It_2 : signed(I_REG_WIDTHS(2)-1 downto 0) := (others => '0');
		variable It_3 : signed(I_REG_WIDTHS(3)-1 downto 0) := (others => '0');
		variable It_4 : signed(I_REG_WIDTHS(4)-1 downto 0) := (others => '0');
		variable It_5 : signed(I_REG_WIDTHS(5)-1 downto 0) := (others => '0');
		variable It_6 : signed(I_REG_WIDTHS(6)-1 downto 0) := (others => '0');
		variable I_result : signed(I_REG_WIDTHS(C_NUM_STAGES)-1 downto 0) := (others => '0');

		variable rdy_var : std_logic := '0';
		variable chan_sync_var : std_logic := '0';
		variable int_cnt_var : integer := 0;
		variable rfd_var : std_logic := '1';
		variable chan_cnt_var : integer := 0;

		variable rate_val : integer := C_RATE; -- count value for rate control
		variable output_msb : integer := INTERPSTAGEBITS(C_NUM_STAGES,0,C_INPUT_WIDTH,C_RATE,C_NUM_STAGES,C_DIFF_DELAY);

	begin
		wait until rising_edge(clk);

		int_cnt_var := int_cnt(chan_cnt); -- current interpolation count
		chan_cnt_var := chan_cnt; -- current channel count
		C_result := to_signed(0,C_REG_WIDTHS(C_NUM_STAGES)); -- init to zero unless combs overwrite
		rdy_var := '0'; -- not ready unless set inside interpolation processing
		chan_sync_var := '0'; -- no channel sync unless deterined in interpolation processing


		if nd = '1' then
			-- process new input through comb sections
			-- sign extend input data
			din_ext := signed(din);

			Ct_1 := resize(din_ext,C_REG_WIDTHS(1)) - resize(CM1_1(chan_cnt),C_REG_WIDTHS(1));
			Ct_2 := resize(Ct_1,C_REG_WIDTHS(2)) - resize(CM1_2(chan_cnt),C_REG_WIDTHS(2));
			Ct_3 := resize(Ct_2,C_REG_WIDTHS(3)) - resize(CM1_3(chan_cnt),C_REG_WIDTHS(3));
			Ct_4 := resize(Ct_3,C_REG_WIDTHS(4)) - resize(CM1_4(chan_cnt),C_REG_WIDTHS(4));
			Ct_5 := resize(Ct_4,C_REG_WIDTHS(5)) - resize(CM1_5(chan_cnt),C_REG_WIDTHS(5));
			Ct_6 := resize(Ct_5,C_REG_WIDTHS(6)) - resize(CM1_6(chan_cnt),C_REG_WIDTHS(6));

			if C_DIFF_DELAY = 1 then
				CM1_1(chan_cnt) <= din_ext;
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

				CM2_1(chan_cnt) <= din_ext;
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

			int_cnt_var := 0; -- reset interpolation count

		end if;


		if int_cnt_var < rate_val then
			-- do integrator sections only if within interpolation rate count
			It_1 := I_1(chan_cnt) + C_result;
			I_1(chan_cnt) <= It_1;
			It_2 := I_2(chan_cnt) + It_1;
			I_2(chan_cnt) <= It_2;
			It_3 := I_3(chan_cnt) + It_2;
			I_3(chan_cnt) <= It_3;
			It_4 := I_4(chan_cnt) + It_3;
			I_4(chan_cnt) <= It_4;
			It_5 := I_5(chan_cnt) + It_4;
			I_5(chan_cnt) <= It_5;
			It_6 := I_6(chan_cnt) + It_5;
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

			-- output data for the interpolation phase just processed
			--dout_out(LATENCY) <= std_logic_vector(I_result(I_REG_WIDTHS(C_NUM_STAGES)-1 downto I_REG_WIDTHS(C_NUM_STAGES)-C_OUTPUT_WIDTH)); -- truncation of LSBs at the output; rounding will be used here
			if (C_OUTPUT_WIDTH < I_REG_WIDTHS(C_NUM_STAGES)) then
				-- limited precision; do scaling as required
				dout_out(LATENCY) <= std_logic_vector(I_result(output_msb-1 downto MAX(output_msb-C_OUTPUT_WIDTH,0)));
			else
				-- full precision, do not scale
				dout_out(LATENCY) <= std_logic_vector(I_result(I_REG_WIDTHS(C_NUM_STAGES)-1 downto 0));
			end if;


			rdy_var := '1';

			-- set channel synchronization
			if chan_cnt = (0) then
				if C_NUM_CHANNELS > 1 then
					chan_sync_var := '1'; -- tag channel 0 if multi-channel
				else
					chan_sync_var := '0';
				end if;
			end if;

			-- set ready for data
			if C_NUM_CHANNELS > 1 then
				-- multi-channel
				if int_cnt_var = 0 then
					-- just processed first phase of ...
					if chan_cnt < C_NUM_CHANNELS - 1 then
						-- not last channel
						rfd_var := '1'; 
					else
						-- last channel
						rfd_var := '0'; 
					end if;
				elsif int_cnt_var = rate_val - 1 then
					-- just processed last phase of ...
					if chan_cnt = C_NUM_CHANNELS - 1 then
						-- last channel
						rfd_var := '1';
					else
						rfd_var := '0';
					end if;
				else
					rfd_var := '0'; -- not ready otherwise
				end if;
			else
				-- single channel
				if int_cnt_var = rate_val - 1 then
					rfd_var := '1'; -- last interpolation phase processed - ready for data
				else
					rfd_var := '0'; -- not ready
				end if;
			end if;

			-- update interpolation rate count
			int_cnt_var := int_cnt_var + 1;

			-- update channel count
			if chan_cnt = (C_NUM_CHANNELS - 1) then
				chan_cnt_var := 0;
			else
				chan_cnt_var := chan_cnt + 1;
			end if;

		end if;


		-- synchronous clear and rate change
		if (SCLR = '1') or (RATE_WE = '1') then

			if RATE_WE = '1' then
				rate_val := conv_integer(RATE); -- capture new rate value if valid
				--latency_ptr <= LATENCY - INT_LATENCY(C_LATENCY,rate_val,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,W_c,W_i,C_FAMILY);
				latency_ptr <= LATENCY - INT_LATENCY(C_LATENCY,rate_val,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY);
				output_msb := INTERPSTAGEBITS(C_NUM_STAGES,0,C_INPUT_WIDTH,rate_val,C_NUM_STAGES,C_DIFF_DELAY);
			end if;

			-- clear filter state
			CM1_1 <= (others => to_signed(0,C_INPUT_WIDTH));
			CM1_2 <= (others => to_signed(0,C_REG_WIDTHS(1)));
			CM1_3 <= (others => to_signed(0,C_REG_WIDTHS(2)));
			CM1_4 <= (others => to_signed(0,C_REG_WIDTHS(3)));
			CM1_5 <= (others => to_signed(0,C_REG_WIDTHS(4)));
			CM1_6 <= (others => to_signed(0,C_REG_WIDTHS(5)));

			CM2_1 <= (others => to_signed(0,C_INPUT_WIDTH));
			CM2_2 <= (others => to_signed(0,C_REG_WIDTHS(1)));
			CM2_3 <= (others => to_signed(0,C_REG_WIDTHS(2)));
			CM2_4 <= (others => to_signed(0,C_REG_WIDTHS(3)));
			CM2_5 <= (others => to_signed(0,C_REG_WIDTHS(4)));
			CM2_6 <= (others => to_signed(0,C_REG_WIDTHS(5)));

			I_1 <= (others => to_signed(0,I_REG_WIDTHS(1)));
			I_2 <= (others => to_signed(0,I_REG_WIDTHS(2)));
			I_3 <= (others => to_signed(0,I_REG_WIDTHS(3)));
			I_4 <= (others => to_signed(0,I_REG_WIDTHS(4)));
			I_5 <= (others => to_signed(0,I_REG_WIDTHS(5)));
			I_6 <= (others => to_signed(0,I_REG_WIDTHS(6)));

			--int_cnt <= (others => (C_MAX_RATE+1));
			dout_out(LATENCY) <= int_to_slv(0,C_OUTPUT_WIDTH);
			int_cnt <= (others => (rate_val+1));
			chan_cnt <= 0;
			rdy_out(LATENCY) <= '0';
			rfd_out <= '1';
			chan_sync_out(LATENCY) <= '0';
			chan_out_out(LATENCY) <= int_to_slv(0,log2_num_chan);

		else
			int_cnt(chan_cnt) <= int_cnt_var;
			chan_cnt <= chan_cnt_var;
			rdy_out(LATENCY) <= rdy_var;
			rfd_out <= rfd_var;
			chan_sync_out(LATENCY) <= chan_sync_var;
			chan_out_out(LATENCY) <= int_to_slv(chan_cnt,log2_num_chan);

		end if;

	end process;
  
end behavioral;

