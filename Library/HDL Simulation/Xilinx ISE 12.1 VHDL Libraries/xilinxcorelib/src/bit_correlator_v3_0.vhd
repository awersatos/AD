--$ID:$
-- CORE NAME: C_BIT_CORRELATOR_V3_0
-- Copyright : Xilinx, Inc.
-- Filename : bit_correlator_v3_0.vhd
-- Core Description : correlates input with a binary pattern

LIBRARY ieee;  
USE ieee.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_unsigned.all;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.bit_correlator_pack_v3_0.all;

LIBRARY XilinxCoreLib;
use XilinxCoreLib.ul_utils.all;

LIBRARY std;
USE std.TEXTIO.all;

ENTITY C_BIT_CORRELATOR_V3_0 is

  GENERIC( 
       c_mem_init_file    : STRING;
       c_taps             : INTEGER; 
       c_input_type       : INTEGER;
       c_data_width       : INTEGER;
       c_channels         : INTEGER;
       c_latency          : INTEGER;
       c_shape            : INTEGER;  -- not needed for model
       c_has_mask         : INTEGER;
       c_has_sel_indicator: INTEGER;
       c_reload           : INTEGER; -- not supported in version 3.0
       c_reload_delay     : INTEGER; -- not supported in version 3.0
       c_reload_mem_type  : INTEGER; -- not supported in version 3.0
       c_enable_rlocs     : INTEGER  -- not needed for model
       );

  PORT(
      din     : IN    STD_LOGIC_VECTOR((c_data_width -1) DOWNTO 0);
      dout    : OUT   STD_LOGIC_VECTOR((bitsNeededToRepresent(c_taps) -1) DOWNTO 0) := (OTHERS => '0');
      nd      : IN    STD_LOGIC;
      rfd     : OUT   STD_LOGIC := '1';
      rdy     : OUT   STD_LOGIC := '0';
      sel_i   : OUT   STD_LOGIC_VECTOR((bitsNeededToRepresent(c_channels - 1) -1) DOWNTO 0) := (OTHERS => 'X');
      sel_o   : OUT   STD_LOGIC_VECTOR((bitsNeededToRepresent(c_channels - 1) -1) DOWNTO 0) := (OTHERS => 'X');
      ld_din  : IN    STD_LOGIC := '0'; -- not supported in version 3.0
      ld_we   : IN    STD_LOGIC := '0'; -- not supported in version 3.0
      coef_ld : IN    STD_LOGIC := '0'; -- not supported in version 3.0
      clk     : IN    STD_LOGIC
      );
END C_BIT_CORRELATOR_V3_0;

ARCHITECTURE behavioral OF C_BIT_CORRELATOR_V3_0 IS

  ---------------------------------------------------------------------------------------
  -- CONSTANTS
  ---------------------------------------------------------------------------------------
  
  CONSTANT  SERIAL_DIN             : INTEGER := 0;
  CONSTANT  PARALLEL_TO_SERIAL_DIN : INTEGER := 1;
  CONSTANT  PARALLEL_DIN           : INTEGER := 2; 
  
  ---------------------------------------------------------------------------------------
  -- SIGNALS
  ---------------------------------------------------------------------------------------
  SIGNAL lrfd : STD_LOGIC := '1';
  
  SIGNAL pattern_mask  : STD_LOGIC_VECTOR((size_of_patternmask_vector(c_taps, c_has_mask) - 1) DOWNTO 0) := read_pattern_mask( c_mem_init_file, c_taps,c_has_mask);
  SIGNAL intDout    : STD_LOGIC_VECTOR((bitsNeededToRepresent(c_taps) - 1) DOWNTO 0) := (OTHERS => '0');
  SIGNAL in_channel : STD_LOGIC_VECTOR((bitsNeededToRepresent(c_channels - 1) -1) DOWNTO 0) := (OTHERS => '0');
  
  -- signals for internal parallel to serial converter
  SIGNAL psc_data    : STD_LOGIC_VECTOR( (c_data_width - 1) DOWNTO 0) := (OTHERS => '0');
  SIGNAL load_counter: STD_LOGIC_VECTOR((bitsNeededToRepresent(c_data_width) - 1) DOWNTO 0) := (OTHERS => '0');

  SIGNAL started_correlator : STD_LOGIC := '0';
  
  -- create an array of std logic vectors that will be used to delay the result for number clocks that match the latency
  CONSTANT doutDelayLength: INTEGER := ((c_channels * c_latency) - 1);    
  TYPE delay is ARRAY(0 TO doutDelayLength) OF STD_LOGIC_VECTOR((bitsNeededToRepresent(c_taps) - 1) DOWNTO 0);
  SIGNAL doutDelay: delay := (OTHERS => (OTHERS => '0')); 
  
  -- create an array to delay the ND signal to create the RDY signal
  CONSTANT rdyDelayLength : INTEGER := ((c_channels * c_latency) - 1);
  TYPE delayRDY IS ARRAY(0 TO rdyDelayLength) OF STD_LOGIC;
  SIGNAL rdyDelay: delayRDY := (OTHERS => '0');
  
  -- create an array to store the input data, the array index represents the channel
  TYPE dinArray IS ARRAY( 0 TO (c_channels - 1)) OF STD_LOGIC_VECTOR( (c_taps - 1) DOWNTO 0 );
  
  -- create an array to delay the output of the channel output indicator
  TYPE channelDelay IS ARRAY( 0 TO (c_latency -1) ) OF STD_LOGIC_VECTOR((bitsNeededToRepresent(c_channels - 1) - 1) DOWNTO 0);
  SIGNAL selOutDelay: channelDelay;
  
	SIGNAL input_buffer_empty : integer := 0;
BEGIN  

  rfd <= lrfd;

  din_parallel_to_serial_converter: PROCESS (clk)

  BEGIN
    
    IF ((c_input_type = PARALLEL_TO_SERIAL_DIN) and (c_data_width > 1)) THEN
      IF (rising_edge(clk)) THEN
        IF(nd = '1' and lrfd = '1') THEN
          lrfd <= '0';      -- RFD is deasserted
        ELSIF (std_logic_vector_2_posint(load_counter) >= c_data_width -2) THEN
          lrfd <= '1';
        END IF;

        IF(nd = '1' and lrfd = '1') THEN
          psc_data <= din;  -- load the shift register
          load_counter <= (OTHERS => '0');
        ELSIF (std_logic_vector_2_posint(load_counter) < c_data_width -1) THEN
          psc_data <= '0' & psc_data((c_data_width - 1) DOWNTO 1);
          load_counter <= load_counter + '1';
        END IF;
      END IF;  
    ELSE
      lrfd <= '1';    
    END IF;
  end PROCESS;
  
  correlation: PROCESS (clk )

  variable count: STD_LOGIC_VECTOR((bitsNeededToRepresent(c_taps) - 1) DOWNTO 0) := (OTHERS => '0');
  variable data_reg: dinArray := (OTHERS => (OTHERS => '0'));
  variable in_channel_local : std_logic_vector((bitsneededtorepresent(c_channels - 1) - 1) downto 0):=(others => '0');
	variable start_correlator : std_logic:= '0';

  BEGIN   -- have a clock edge and the nd is asserted, then shift the data into the shift reg, ELSE wait

    IF((clk = '1' and clk'event) and( nd = '1')) THEN
      start_correlator := '1';
    END IF;

		started_correlator <= start_correlator;
 
     -- create the channel input indicator signal
    IF ((clk = '1' and clk'event) and --(start_correlator = '1') and
            (nd = '1') and (c_input_type = SERIAL_DIN)) THEN
      IF (in_channel_local >= (c_channels - 1 )) THEN 
        in_channel_local := (OTHERS => '0'); 
      ELSE
        in_channel_local := in_channel_local + '1';
      END IF;
    END IF;   
    
    -- output the channel input indicator
    IF(clk = '1' and clk'event) and
        (c_has_sel_indicator = 1) and 
        (c_input_type = SERIAL_DIN) THEN
      sel_i <= in_channel_local;
    END IF;

    in_channel <= in_channel_local;

    IF clk = '1' and clk'event THEN 
			IF(nd = '0' and lrfd = '1') THEN
				input_buffer_empty <= 1;
			ELSE
				input_buffer_empty <= 0;
			END IF;
		END IF;

    IF clk = '1' and clk'event THEN 
      IF (c_input_type = SERIAL_DIN) and nd = '1' and lrfd = '1' and (c_taps > 1) THEN -- SERIAL_DIN
        data_reg(std_logic_vector_2_posint(in_channel_local) ) := data_reg(std_logic_vector_2_posint(in_channel_local) )((c_taps - 2) DOWNTO 0) & din ;
      ELSIF ( (c_input_type = PARALLEL_TO_SERIAL_DIN) and (c_taps > 1)) THEN -- PARALLEL_TO_SERIAL_DIN
				IF(std_logic_vector_2_posint(load_counter) < c_data_width) and input_buffer_empty = 0 THEN
        	data_reg(0) := data_reg(0)((c_taps - 2) DOWNTO 0) & psc_data(0 DOWNTO 0);
				END IF;
      ELSIF (c_input_type = PARALLEL_DIN or (c_taps = 1)) and nd = '1' and lrfd = '1' THEN -- PARALLEL_DIN
        data_reg(0) := din;
      END IF;
    END IF;

    -- "count" how many bits of the input data match the pattern
    count := (OTHERS => '0');

    IF(start_correlator = '1') THEN
      for I in 0 to (c_taps -1) LOOP 
        IF ( c_has_mask = 0 ) THEN
          IF(c_input_type = SERIAL_DIN) THEN
            IF ( data_reg( std_logic_vector_2_posint(in_channel_local) )(I) = pattern_mask(I) ) THEN count := count + '1' ;
            END IF;
          ELSE
            IF ( data_reg(0)(I) = pattern_mask(I) ) THEN count := count + '1' ;
            END IF;
          END IF;
        ELSE     -- has a mask, check that the corresponding mask bit is set and then check the pattern versus data bit
          IF ( pattern_mask(I + c_taps) = '1' ) THEN -- check that the mask bit is set
            IF(c_input_type = SERIAL_DIN) THEN
              IF ( data_reg( std_logic_vector_2_posint(in_channel_local) )(I) = pattern_mask(I) ) THEN count := count + '1' ;
              END IF;
            ELSE
              IF ( data_reg(0)(I) = pattern_mask(I) ) THEN count := count + '1' ;
              END IF;
            END IF;
          END IF;
        END IF;
      END LOOP;
    END IF;
    intDout <= count;
      
  end PROCESS;

  -- delay the output of the number bits that match for the latency value
  delay_dout: PROCESS (clk, intDout)
  BEGIN 
    
    IF(c_input_type = PARALLEL_TO_SERIAL_DIN) THEN
      assert c_latency >= 3 
        REPORT "c_latency cannot be less than 3 for P2S case"
        SEVERITY FAILURE;
    ELSIF (c_input_type = PARALLEL_DIN) THEN
      assert c_latency >= 1
        REPORT "c_latency cannot be less than 1 for parallel cases"
        SEVERITY FAILURE;
    ELSIF (c_input_type = SERIAL_DIN) THEN
      assert c_latency >= 2
        REPORT "c_latency cannot be less than 2 for serial cases"
        SEVERITY FAILURE;
    END IF;

    if(c_input_type = PARALLEL_DIN) then
      if(c_latency = 1) then
        dout <= intDout;
      end if;
    end if;

    if clk = '1' and clk'event then
      IF(c_input_type /= PARALLEL_TO_SERIAL_DIN) THEN
        IF(c_latency = 2) THEN
          dout <= intDout;
        ELSIF(c_latency > 2) THEN
          doutDelay(0) <= intDout;
          dout <= doutDelay(c_latency - 3);
          FOR delayIndex IN 1 TO (c_latency - 3) LOOP
            doutDelay(delayIndex) <= doutDelay(delayIndex - 1) ;
          END LOOP;  
        END IF;
      ELSIF(c_input_type = PARALLEL_TO_SERIAL_DIN) THEN
        IF(c_latency = 3) THEN
          dout <= intDout;
        ELSIF(c_latency > 3) THEN
          doutDelay(0) <= intDout;
          dout <= doutDelay(c_latency - 4);
          FOR delayIndex IN 1 TO (c_latency - 4) LOOP
            doutDelay(delayIndex) <= doutDelay(delayIndex - 1) ;
          END LOOP;  
        END IF;
      END IF;
    END IF;
    
  end PROCESS;                         

    -- delay the output of the number bits that match for the latency value
  create_rdy_and_sel_o: PROCESS (clk)

  VARIABLE local_rdy : STD_LOGIC;
  VARIABLE count_rdy : INTEGER := 0; 
  variable in_channel_local : std_logic_vector((bitsneededtorepresent(c_channels - 1) - 1) downto 0):=(others => '0');
  BEGIN 
    
    IF clk = '1' and clk'event THEN
      
      IF(nd = '1') THEN
        local_rdy := '1';
        count_rdy := c_data_width - 1;
      ELSE
        IF(count_rdy = 0 ) THEN
          local_rdy := '0';
        ELSE
          local_rdy := '1';
          count_rdy := count_rdy - 1;
        END IF;
      END IF;

      -- store the New Data input signal in the delay element
      IF(c_input_type /= PARALLEL_TO_SERIAL_DIN) THEN
        IF(c_latency = 1) and (c_input_type = PARALLEL_DIN) THEN
          rdy <= nd;
        ELSIF(c_latency = 2) THEN
          rdy <= rdyDelay(0);
          rdyDelay(0) <= nd;
        ELSE
          rdy <= rdyDelay(c_latency - 2);
          for delayIndex IN 1 TO (c_latency - 2) LOOP
            rdyDelay(delayIndex) <= rdyDelay(delayIndex - 1) ;
          END LOOP;
          rdyDelay(0) <= nd;
        END IF;
      ELSIF (c_input_type = PARALLEL_TO_SERIAL_DIN) THEN
        rdy <= rdyDelay(c_latency - 2); 
        FOR delayIndex IN 1 TO (c_latency - 2) LOOP
          rdyDelay(delayIndex) <= rdyDelay(delayIndex - 1) ;
        END LOOP;  
        rdyDelay(0) <= local_rdy;
      END IF;
      
      IF ((clk = '1' and clk'event) and (started_correlator = '1') and
              (nd = '1') and (c_input_type = SERIAL_DIN)) THEN
        IF (in_channel_local >= (c_channels - 1 )) THEN 
          in_channel_local := (OTHERS => '0'); 
        ELSE
          in_channel_local := in_channel_local + '1';
        END IF;
      END IF;   

      IF(c_has_sel_indicator = 1) and (c_input_type = SERIAL_DIN) THEN
        -- store the internally generated output channel indicator signal
        selOutDelay(0) <= in_channel; 
        -- output the last value in the sel_o delay to the SEL_O output signal
        sel_o <= selOutDelay(c_latency - 2);

        for delayIndex IN 1 TO (c_latency - 2) LOOP
          selOutDelay(delayIndex) <= selOutDelay(delayIndex -1);
        END LOOP;  

      END IF;
      
    END IF;
    
  end PROCESS;                         

end behavioral;
