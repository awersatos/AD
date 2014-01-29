-------------------------------------------------------------------------------
-- $Id: cic_compiler_v2_0_interpolate_bhv.vhd,v 1.2 2010/01/18 14:33:36 andrewd Exp $
-------------------------------------------------------------------------------
--  (c) Copyright 2006-2009 Xilinx, Inc. All rights reserved.
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
-------------------------------------------------------------------------------
-- Description:
--     
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.cic_compiler_v2_0_pkg.all;
use Xilinxcorelib.bip_utils_pkg_v2_0.get_max;
use Xilinxcorelib.bip_utils_pkg_v2_0.int_to_slv;

library work;

entity cic_compiler_v2_0_interpolate_bhv is
  generic (
    C_NUM_STAGES : integer := 4;
    C_DIFF_DELAY : integer := 1;
    C_RATE : integer := 4;
    C_INPUT_WIDTH : integer := 18;
    C_OUTPUT_WIDTH : integer := 26;
    C_USE_DSP : integer := 0;
    C_HAS_ROUNDING : integer := 0;
    C_NUM_CHANNELS  : integer := 1;
    -- C_PIPE_SUBWORD_WIDTH  : integer := 0;
    C_RATE_TYPE : integer := 0;
    C_MIN_RATE : integer := 4;
    C_MAX_RATE : integer := 4;
    C_SAMPLE_FREQ : integer := 100;
    C_CLK_FREQ : integer := 100;
    -- C_OVERCLOCK : integer := 1;
    C_HAS_CE : integer := 0;
    C_HAS_SCLR : integer := 0;
    C_HAS_ND          : integer := 1;
    C_USE_STREAMING_INTERFACE : integer:= 0;
    C_FAMILY : string := "virtex4";
    C_COMB_WIDTHS : stage_array := (others => 0);
    C_INT_WIDTHS : stage_array := (others => 0)--;
    -- C_LATENCY : string := "zero_latency"
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
end cic_compiler_v2_0_interpolate_bhv;

architecture behavioral of cic_compiler_v2_0_interpolate_bhv is
	-- constant pipe_subword_width : integer := C_PIPE_SUBWORD_WIDTH;
        -- constant max_WIDTH_c : integer := C_COMB_WIDTHS(C_NUM_STAGES-1);
	-- constant comb_processing_stage_latency : integer := COMB_STAGE_PROCESSING_LATENCY(max_WIDTH_c,pipe_subword_width,C_USE_DSP,C_FAMILY);
-- 
	-- -- define folding and latency
	-- constant INTEGRATOR_FOLDING : integer := INT_FOLDING_FACTOR(C_OVERCLOCK, C_MIN_RATE, C_NUM_STAGES, C_NUM_CHANNELS, 0);
	-- constant COMB_FOLDING : integer := COMB_FOLDING_FACTOR(C_OVERCLOCK, C_MIN_RATE, C_NUM_STAGES, C_NUM_CHANNELS, 0, C_USE_DSP,comb_processing_stage_latency);
	-- 
	-- -- register sizes
	-- constant LATENCY : integer := INT_LATENCY(C_LATENCY,C_MAX_RATE,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY);
	-- signal latency_ptr : integer := LATENCY - INT_LATENCY(C_LATENCY,C_RATE,C_MIN_RATE,C_RATE_TYPE,C_NUM_STAGES,C_NUM_CHANNELS,C_OVERCLOCK,pipe_subword_width,C_USE_DSP,C_OUTPUT_WIDTH,C_COMB_WIDTHS,C_INT_WIDTHS,C_FAMILY);
  
  --
  function select_integer (
           i0  : integer;
           i1  : integer;
           sel : boolean)
           return integer is
  begin
    if sel then
      return i1;
    else
      return i0;
    end if; -- sel
  end select_integer;
  --
  
  constant core_config: t_interpolate_config := get_interpolate_config(
                                                        C_NUM_STAGES,
                                                        C_DIFF_DELAY,
                                                        C_RATE,
                                                        C_INPUT_WIDTH,
                                                        C_OUTPUT_WIDTH,
                                                        C_USE_DSP,
                                                        C_HAS_ROUNDING,
                                                        C_NUM_CHANNELS,
                                                        C_RATE_TYPE,
                                                        C_MIN_RATE,
                                                        C_MAX_RATE,
                                                        C_SAMPLE_FREQ,
                                                        C_CLK_FREQ,
                                                        C_HAS_SCLR,
                                                        C_USE_STREAMING_INTERFACE,
                                                        C_FAMILY,
                                                        (0=>C_COMB_WIDTHS(0),1=>C_COMB_WIDTHS(1),2=>C_COMB_WIDTHS(2),3=>C_COMB_WIDTHS(3),4=>C_COMB_WIDTHS(4),5=>C_COMB_WIDTHS(5)),
                                                        (0=>C_INT_WIDTHS(0),1=>C_INT_WIDTHS(1),2=>C_INT_WIDTHS(2),3=>C_INT_WIDTHS(3),4=>C_INT_WIDTHS(4),5=>C_INT_WIDTHS(5)));
  
  constant LATENCY : integer := core_config.latency;
  signal   latency_ptr :  integer := LATENCY - LATENCY; -- ***************

	-- define register arrays for comb and integrator sections
	type CIC_INT_C_ARRAY is array (1 to 6) of integer;
	type CIC_INT_I_ARRAY is array (1 to 6) of integer;

	-- define constants for register sizing
	constant BMAX : integer := CICBMAX(C_INPUT_WIDTH,C_MAX_RATE,C_NUM_STAGES,C_DIFF_DELAY);
	-- Note: register widths in generics can be 0; the max function is used to prevent 0-valued widths which cause compilation failures
	-- constant C_REG_WIDTHS : CIC_INT_C_ARRAY := (max(C_COMB_WIDTHS(0),1),max(C_COMB_WIDTHS(1),1),max(C_COMB_WIDTHS(2),1),max(C_COMB_WIDTHS(3),1),max(C_COMB_WIDTHS(4),1),max(C_COMB_WIDTHS(5),1));
  constant C_REG_WIDTHS : CIC_INT_C_ARRAY := (max(core_config.comb.actual_widths(0),1),max(core_config.comb.actual_widths(1),1),max(core_config.comb.actual_widths(2),1),max(core_config.comb.actual_widths(3),1),max(core_config.comb.actual_widths(4),1),max(core_config.comb.actual_widths(5),1));
	-- constant I_REG_WIDTHS : CIC_INT_I_ARRAY := (max(C_INT_WIDTHS(0),1),max(C_INT_WIDTHS(1),1),max(C_INT_WIDTHS(2),1),max(C_INT_WIDTHS(3),1),max(C_INT_WIDTHS(4),1),max(C_INT_WIDTHS(5),1));
  constant I_REG_WIDTHS : CIC_INT_I_ARRAY := (max(core_config.integrator.actual_widths(0),1),max(core_config.integrator.actual_widths(1),1),max(core_config.integrator.actual_widths(2),1),max(core_config.integrator.actual_widths(3),1),max(core_config.integrator.actual_widths(4),1),max(core_config.integrator.actual_widths(5),1));



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
	-- signal int_cnt : INT_CNT_ARRAY := (others => (C_RATE+1)); -- init to avoid initial processing 
  signal int_cnt : integer:=0;
  signal int_cnt_max: std_logic:='0';
  
	-- IF signals
	signal rfd_out,rfd_int : std_logic := '1';

	-- multi-channel related objects
	constant log2_num_chan : integer := get_max(1,number_of_digits(C_NUM_CHANNELS-1,2));
	signal chan_cnt,
         chan_cnt_in: integer := 0;
	signal chan_sync_out : std_logic_vector  (LATENCY downto 0) := (others => '0');
	type CHAN_OUT_ARRAY is array (LATENCY downto 0) of std_logic_vector (log2_num_chan-1 downto 0);
	signal chan_out_out : CHAN_OUT_ARRAY := (others => int_to_slv(0,log2_num_chan));

	signal rdy_out : std_logic_vector  (LATENCY downto 0) := (others => '0');
	type DOUT_ARRAY is array (LATENCY downto 0) of std_logic_vector (C_OUTPUT_WIDTH-1 downto 0);
	signal dout_out : DOUT_ARRAY := (others => int_to_slv(0,C_OUTPUT_WIDTH));

  signal rate_we_int,
         nd_int
         : std_logic;
  
  signal rate_change,
         change_rate : std_logic:='0';
begin
  
  rate_we_int<=RATE_WE when C_RATE_TYPE=1 else '0';
  
  nd_int<=ND when C_HAS_ND=1 else rfd_out;
	
  -- ready for data process
	RFD <= rfd_out;

	-- data output process
	dout <= dout_out(latency_ptr);
  
	dout_process : process(clk)
	begin
		if rising_edge(clk) then
      if change_rate='1' then
        dout_out(LATENCY-1 downto 0) <= (others => (others=>'0'));
        dout_out(LATENCY-1) <= dout_out(LATENCY);
      elsif (SCLR = '1') then
        dout_out(LATENCY-1 downto 0) <= (others => (others=>'0'));
      elsif CE='1' then
        if LATENCY > 0 then			
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
      if change_rate='1' then
        rdy_out(LATENCY-1 downto 0) <= (others=>'0');
        rdy_out(LATENCY-1) <= rdy_out(LATENCY);
      elsif SCLR='1' then
        rdy_out(LATENCY-1 downto 0) <= (others=>'0');
      elsif CE='1' then
        if LATENCY > 0 then
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
      if change_rate='1' then
        chan_sync_out(LATENCY-1 downto 0) <= (others=>'0');
        chan_sync_out(LATENCY-1) <= chan_sync_out(LATENCY);
      elsif SCLR='1' then
        chan_sync_out(LATENCY-1 downto 0) <= (others=>'0');
      elsif CE='1' then
        if LATENCY > 0 then
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
      if SCLR='1' or change_rate='1' then
        chan_out_out(LATENCY-1 downto 0) <= (others => (others=>'0'));
      elsif CE='1' then
        if LATENCY > 0 then
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
    -- variable C_result : signed(C_REG_WIDTHS(C_NUM_STAGES)-1 downto 0) := (others => '0');
    type t_C_result is array (2*C_NUM_CHANNELS-1 downto 0) of signed(C_REG_WIDTHS(C_NUM_STAGES)-1 downto 0);
		variable C_result : t_C_result := (others=>(others => '0'));
    
		variable It_1 : signed(I_REG_WIDTHS(1)-1 downto 0) := (others => '0');
		variable It_2 : signed(I_REG_WIDTHS(2)-1 downto 0) := (others => '0');
		variable It_3 : signed(I_REG_WIDTHS(3)-1 downto 0) := (others => '0');
		variable It_4 : signed(I_REG_WIDTHS(4)-1 downto 0) := (others => '0');
		variable It_5 : signed(I_REG_WIDTHS(5)-1 downto 0) := (others => '0');
		variable It_6 : signed(I_REG_WIDTHS(6)-1 downto 0) := (others => '0');
		variable I_result : signed(I_REG_WIDTHS(C_NUM_STAGES)-1 downto 0) := (others => '0');

		variable rdy_var : std_logic := '0';
		variable chan_sync_var : std_logic := '0';
		-- variable int_cnt_var : integer := 0;
		-- variable chan_cnt_var : integer := 0;

		variable rate_val,
             rate_store,
             rate_sync: integer := C_RATE; -- count value for rate control
             
		variable output_msb : integer := INTERPSTAGEBITS(C_NUM_STAGES,0,C_INPUT_WIDTH,C_RATE,C_NUM_STAGES,C_DIFF_DELAY);
    
    --
    variable ip_rate_cnt : integer := 0;
    variable op_rate_cnt : integer := 0;
                                                   
    variable ip_rate : integer := ((C_CLK_FREQ/C_SAMPLE_FREQ)/C_NUM_CHANNELS)-2;
                                      
    variable rfd_int_gen : std_logic:='1';
    type t_block_ip_buff is array (C_NUM_CHANNELS-1 downto 0) of std_logic_vector(C_INPUT_WIDTH-1 downto 0);
    variable block_ip_buff: t_block_ip_buff:= (others=>(others=>'0'));
    variable din_sel: std_logic_vector(C_INPUT_WIDTH-1 downto 0);
    variable block_chan_px,
             block_ip_buff_diff: integer:=0;
    variable samples_to_process,
             ip_rate_cnt_max,
             op_enable: boolean:=false;
    constant op_rate: integer:= (((C_CLK_FREQ/C_SAMPLE_FREQ)/C_NUM_CHANNELS)/C_MIN_RATE);
    
    variable c_result_in_page,
             c_result_out_page
             : integer:=0;
    variable  int_cnt_var, 
              chan_cnt_var,
              chan_cnt_in_var: integer;
    variable  change_rate_var: std_logic:='0';
	begin
		wait until rising_edge(clk) and (CE='1' or SCLR='1');
    
    --Generate RFD
        
    --Generate internal rfd rate
    samples_to_process:=false;
    ip_rate_cnt_max:=false;
    if (nd_int = '1' or block_ip_buff_diff>0) and rfd_int='1' then
      rfd_int_gen:='0';
      samples_to_process:=true;
    end if;
    if rfd_int='0' then
      if ip_rate_cnt=ip_rate then
        ip_rate_cnt := 0;
        rfd_int_gen:='1';
        ip_rate_cnt_max:=true;
      else
        ip_rate_cnt := ip_rate_cnt + 1;
      end if;
    end if;
    rfd_int<=rfd_int_gen;
    
    --Generate block input or streaming, this duplicates core behavour so is maybe a little incestuous
    if C_NUM_CHANNELS=1 or C_USE_STREAMING_INTERFACE=1 then
      rfd_out<=rfd_int_gen;
      din_sel:=din;
    else
      if nd_int = '1' and rfd_out='1' and block_chan_px=C_NUM_CHANNELS-1 then
        rfd_out<='0';
      end if;
      
      if nd_int = '1' and rfd_out='1' then
        block_ip_buff(block_chan_px):=din;
        block_ip_buff_diff:=block_ip_buff_diff+1;
        if block_chan_px=C_NUM_CHANNELS-1 then 
          block_chan_px:=0;
        else
          block_chan_px:=block_chan_px+1;
        end if;
      end if;
      
      if ip_rate_cnt_max and chan_cnt_in=0 then --C_NUM_CHANNELS-1 then
        rfd_out<='1';
      end if;
      
      if (nd_int = '1' or block_ip_buff_diff>0) and rfd_int='1' then
        block_ip_buff_diff:=block_ip_buff_diff-1;
      end if;
      
      din_sel:=block_ip_buff(chan_cnt_in);
        
    end if;
    
    --Rate change
    change_rate<='0';
    change_rate_var:='0';
    int_cnt_var     := int_cnt;
    chan_cnt_var    := chan_cnt;
    chan_cnt_in_var := chan_cnt_in;
    if (nd_int = '1' or samples_to_process) and (rfd_int = '1') and rate_change='1' then
      if (C_NUM_CHANNELS=1 or C_USE_STREAMING_INTERFACE=1) or chan_cnt_in=0 then
        rate_change<='0';
        rate_val:=rate_store;
        rate_sync:=rate_store;
        change_rate<='1';
        change_rate_var:='1';
        output_msb := INTERPSTAGEBITS(C_NUM_STAGES,0,C_INPUT_WIDTH,rate_sync,C_NUM_STAGES,C_DIFF_DELAY);
        
        --clear like a reset but want to then continue processing, core add latency between clearing and new data
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
        
        It_1 := (others => '0');
        It_2 := (others => '0');
        It_3 := (others => '0');
        It_4 := (others => '0');
        It_5 := (others => '0');
        It_6 := (others => '0');
  
        C_result := (others=>(others => '0'));
        I_result := (others => '0');
        
        dout_out(LATENCY) <= int_to_slv(0,C_OUTPUT_WIDTH);
        -- ip_rate_cnt:=0;
        op_rate_cnt:=0;
        op_enable := false;
        -- block_chan_px:=0;
        -- block_ip_buff_diff:=0;
        -- samples_to_process:=false;
        -- ip_rate_cnt_max:=false;
        c_result_in_page :=0;
        c_result_out_page := 0;
        
        int_cnt_var := 0;
        chan_cnt_var := 0;
        chan_cnt_in_var := 0;
        
        int_cnt <= 0;
        chan_cnt <= 0;
        chan_cnt_in <= 0;
        
        rdy_out(LATENCY) <= '0';
        -- rfd_int_gen:='1';
        -- rfd_int <='1';
        -- rfd_out <= '1';
        chan_sync_var := '0';
        chan_sync_out(LATENCY) <= '0';
        chan_out_out(LATENCY) <= int_to_slv(0,log2_num_chan);
      end if;
    end if;
    
		--Calculate input rate when programmable
    if C_RATE_TYPE=1 then
      ip_rate:=((((C_CLK_FREQ/C_SAMPLE_FREQ)/C_NUM_CHANNELS)/C_MIN_RATE)*rate_val)-2;
    end if;
    
		if (nd_int = '1' or samples_to_process) and (rfd_int = '1') then
      
			-- process new input through comb sections
			-- sign extend input data
			din_ext := signed(din_sel);
      
      if change_rate_var='1' then
        Ct_1 := resize(din_ext,C_REG_WIDTHS(1)); 
        Ct_2 := resize(Ct_1,C_REG_WIDTHS(2));    
        Ct_3 := resize(Ct_2,C_REG_WIDTHS(3));    
        Ct_4 := resize(Ct_3,C_REG_WIDTHS(4));    
        Ct_5 := resize(Ct_4,C_REG_WIDTHS(5));    
        Ct_6 := resize(Ct_5,C_REG_WIDTHS(6));    
      else
        Ct_1 := resize(din_ext,C_REG_WIDTHS(1)) - resize(CM1_1(chan_cnt_in),C_REG_WIDTHS(1));
        Ct_2 := resize(Ct_1,C_REG_WIDTHS(2)) - resize(CM1_2(chan_cnt_in),C_REG_WIDTHS(2));
        Ct_3 := resize(Ct_2,C_REG_WIDTHS(3)) - resize(CM1_3(chan_cnt_in),C_REG_WIDTHS(3));
        Ct_4 := resize(Ct_3,C_REG_WIDTHS(4)) - resize(CM1_4(chan_cnt_in),C_REG_WIDTHS(4));
        Ct_5 := resize(Ct_4,C_REG_WIDTHS(5)) - resize(CM1_5(chan_cnt_in),C_REG_WIDTHS(5));
        Ct_6 := resize(Ct_5,C_REG_WIDTHS(6)) - resize(CM1_6(chan_cnt_in),C_REG_WIDTHS(6));
      end if;

			if C_DIFF_DELAY = 1 then
				CM1_1(chan_cnt_in_var) <= din_ext;
				CM1_2(chan_cnt_in_var) <= Ct_1;
				CM1_3(chan_cnt_in_var) <= Ct_2;
				CM1_4(chan_cnt_in_var) <= Ct_3;
				CM1_5(chan_cnt_in_var) <= Ct_4;
				CM1_6(chan_cnt_in_var) <= Ct_5;
			else
        if change_rate_var='1' then
          CM1_1(chan_cnt_in_var) <=(others=>'0');
          CM1_2(chan_cnt_in_var) <=(others=>'0');
          CM1_3(chan_cnt_in_var) <=(others=>'0');
          CM1_4(chan_cnt_in_var) <=(others=>'0');
          CM1_5(chan_cnt_in_var) <=(others=>'0');
          CM1_6(chan_cnt_in_var) <=(others=>'0');
        else
          CM1_1(chan_cnt_in_var) <= CM2_1(chan_cnt_in_var);
          CM1_2(chan_cnt_in_var) <= CM2_2(chan_cnt_in_var);
          CM1_3(chan_cnt_in_var) <= CM2_3(chan_cnt_in_var);
          CM1_4(chan_cnt_in_var) <= CM2_4(chan_cnt_in_var);
          CM1_5(chan_cnt_in_var) <= CM2_5(chan_cnt_in_var);
          CM1_6(chan_cnt_in_var) <= CM2_6(chan_cnt_in_var);
        end if;

				CM2_1(chan_cnt_in_var) <= din_ext;
				CM2_2(chan_cnt_in_var) <= Ct_1;
				CM2_3(chan_cnt_in_var) <= Ct_2;
				CM2_4(chan_cnt_in_var) <= Ct_3;
				CM2_5(chan_cnt_in_var) <= Ct_4;
				CM2_6(chan_cnt_in_var) <= Ct_5;
			end if;

			case C_NUM_STAGES is
				when 1 => C_result(chan_cnt_in_var+c_result_in_page) := Ct_1;
				when 2 => C_result(chan_cnt_in_var+c_result_in_page) := Ct_2;
				when 3 => C_result(chan_cnt_in_var+c_result_in_page) := Ct_3;
				when 4 => C_result(chan_cnt_in_var+c_result_in_page) := Ct_4;
				when 5 => C_result(chan_cnt_in_var+c_result_in_page) := Ct_5;
				when 6 => C_result(chan_cnt_in_var+c_result_in_page) := Ct_6;
				when others => C_result(chan_cnt_in_var+c_result_in_page) := Ct_1;
			end case;

      if chan_cnt_in_var = C_NUM_CHANNELS-1 then
        chan_cnt_in <= 0;
        
        --C_result made double paged to match core behavour for when changing rate to a lower rate and input data is missed
        if c_result_in_page/=0 or C_NUM_CHANNELS=1 then
          c_result_in_page:=0;
        else
          c_result_in_page:=C_NUM_CHANNELS;
        end if;
      else
        chan_cnt_in <= chan_cnt_in_var + 1;
      end if;
      
		end if;

    
    if (nd_int = '1' or samples_to_process) and (rfd_int = '1') and chan_cnt_in_var = C_NUM_CHANNELS-1 then --and int_cnt_var >= rate_sync then
      op_enable:=true;
    end if;
    
    rdy_var := '0'; -- not ready unless set inside interpolation processing
    chan_sync_var := '0'; -- no channel sync unless deterined in interpolation processing  
    int_cnt_max<='0';
      
    -- if int_cnt_max='1' then
      -- rate_sync:=rate_val;
      -- output_msb := INTERPSTAGEBITS(C_NUM_STAGES,0,C_INPUT_WIDTH,rate_sync,C_NUM_STAGES,C_DIFF_DELAY);
    -- end if;
      
    if op_enable then
    
      if op_rate_cnt = 0 then
        -- do integrator sections only if within interpolation rate count
        if int_cnt_var = 0 then
          if change_rate_var='1' then
            It_1 := resize(C_result(chan_cnt_var+c_result_out_page),I_REG_WIDTHS(1));
          else
            It_1 := resize(I_1(chan_cnt_var) + C_result(chan_cnt_var+c_result_out_page),I_REG_WIDTHS(1));
          end if;
        else
          It_1 := resize(I_1(chan_cnt_var) + to_signed(0,C_REG_WIDTHS(C_NUM_STAGES)),I_REG_WIDTHS(1));
        end if;
        
        if change_rate_var='1' and C_NUM_CHANNELS=1 then
          I_1(chan_cnt_var) <= It_1;
          It_2 := resize(It_1,I_REG_WIDTHS(2));
          I_2(chan_cnt_var) <= It_2;
          It_3 := resize(It_2,I_REG_WIDTHS(3));
          I_3(chan_cnt_var) <= It_3;
          It_4 := resize(It_3,I_REG_WIDTHS(4));
          I_4(chan_cnt_var) <= It_4;
          It_5 := resize(It_4,I_REG_WIDTHS(5));
          I_5(chan_cnt_var) <= It_5;
          It_6 := resize(It_5,I_REG_WIDTHS(6));
          I_6(chan_cnt_var) <= It_6;
        else
          I_1(chan_cnt_var) <= It_1;
          It_2 := resize(I_2(chan_cnt_var) + It_1,I_REG_WIDTHS(2));
          I_2(chan_cnt_var) <= It_2;
          It_3 := resize(I_3(chan_cnt_var) + It_2,I_REG_WIDTHS(3));
          I_3(chan_cnt_var) <= It_3;
          It_4 := resize(I_4(chan_cnt_var) + It_3,I_REG_WIDTHS(4));
          I_4(chan_cnt_var) <= It_4;
          It_5 := resize(I_5(chan_cnt_var) + It_4,I_REG_WIDTHS(5));
          I_5(chan_cnt_var) <= It_5;
          It_6 := resize(I_6(chan_cnt_var) + It_5,I_REG_WIDTHS(6));
          I_6(chan_cnt_var) <= It_6;
        end if;
  
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
        if (C_OUTPUT_WIDTH < I_REG_WIDTHS(C_NUM_STAGES)) then
          -- limited precision; do scaling as required
          if output_msb-C_OUTPUT_WIDTH < 0 then
            dout_out(LATENCY)(C_OUTPUT_WIDTH-1 downto C_OUTPUT_WIDTH-output_msb) <= std_logic_vector(I_result(output_msb-1 downto 0));
            dout_out(LATENCY)(C_OUTPUT_WIDTH-output_msb-1 downto 0)              <=(others=>'0');
          else
            dout_out(LATENCY) <= std_logic_vector(I_result(output_msb-1 downto MAX(output_msb-C_OUTPUT_WIDTH,0)));
          end if;
        else
          -- full precision, do not scale
          dout_out(LATENCY) <= std_logic_vector(I_result(I_REG_WIDTHS(C_NUM_STAGES)-1 downto 0));
        end if;
  
        rdy_var := '1';
  
        -- set channel synchronization
        if chan_cnt_var = (0) then
          if C_NUM_CHANNELS > 1 then
            chan_sync_var := '1'; -- tag channel 0 if multi-channel
          else
            chan_sync_var := '0';
          end if;
        end if;
        
      end if;
      
      if op_rate_cnt=op_rate-1 then
        op_rate_cnt:=0;
        if chan_cnt_var = (C_NUM_CHANNELS - 1) then
          chan_cnt <= 0;
          if int_cnt_var=rate_sync-1 then
            op_enable:=false;
            int_cnt<=0;
            int_cnt_max<='1';
            
            -- rate_sync:=rate_val;
            -- output_msb := INTERPSTAGEBITS(C_NUM_STAGES,0,C_INPUT_WIDTH,rate_sync,C_NUM_STAGES,C_DIFF_DELAY);
            
            if c_result_out_page/=0 or C_NUM_CHANNELS=1 then
              c_result_out_page:=0;
            else
              c_result_out_page:=C_NUM_CHANNELS;
            end if;
          else
            int_cnt<=int_cnt_var+1;
          end if;
          
        else
          chan_cnt <= chan_cnt_var + 1;
        end if;
      else
        op_rate_cnt:= op_rate_cnt+1;
      end if;
      
      chan_out_out(LATENCY) <= int_to_slv(chan_cnt_var,log2_num_chan);
    
    end if;
    
    rdy_out(LATENCY) <= rdy_var;
    chan_sync_out(LATENCY) <= chan_sync_var;
    
    --Hold input rate
    if rate_we_int = '1' then
      rate_store:=conv_integer(RATE);
      rate_change<= '1';
    end if;
    
    if SCLR='1' then
    
      rate_val:=C_RATE;
      rate_store:=C_RATE;
      rate_sync:=C_RATE;
      output_msb:= INTERPSTAGEBITS(C_NUM_STAGES,0,C_INPUT_WIDTH,C_RATE,C_NUM_STAGES,C_DIFF_DELAY);
      
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
      
      It_1 := (others => '0');
      It_2 := (others => '0');
      It_3 := (others => '0');
      It_4 := (others => '0');
      It_5 := (others => '0');
      It_6 := (others => '0');
      
      C_result := (others=>(others => '0'));
      I_result := (others => '0');
      
      dout_out(LATENCY) <= int_to_slv(0,C_OUTPUT_WIDTH);
      ip_rate_cnt:=0;
      op_rate_cnt:=0;
      op_enable := false;
      block_chan_px:=0;
      block_ip_buff_diff:=0;
      samples_to_process:=false;
      ip_rate_cnt_max:=false;
      c_result_in_page :=0;
      c_result_out_page := 0;
			int_cnt <= 0;
			chan_cnt <= 0;
      chan_cnt_in <= 0;
			rdy_out(LATENCY) <= '0';
      rfd_int_gen:='1';
      rfd_int <='1';
			rfd_out <= '1';
      chan_sync_var := '0';
			chan_sync_out(LATENCY) <= '0';
			chan_out_out(LATENCY) <= int_to_slv(0,log2_num_chan);

    end if;

	end process;
  
end behavioral;

