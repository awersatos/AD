-------------------------------------------------------------------------------
-- $RCSfile: fir_compiler_v5_0_da_fir.vhd,v $ $Revision: 1.4 $ $Date: 2009/12/04 11:47:01 $
-------------------------------------------------------------------------------
-- Copyright (c) 2006 - 2008 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES
-------------------------------------------------------------------------------
-- Description:
--    DA FIR filter behavioral model, this has been moved from the Java DA FIR
--    design directory to be integrated into a single behavourial model for
--    the FIR Compiler.
--
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY std;
USE std.textio.all;

LIBRARY xilinxcorelib;
USE xilinxcorelib.fir_compiler_v5_0_sim_pkg.all;
USE xilinxcorelib.ul_utils.ALL;

ENTITY fir_compiler_v5_0_da_fir IS
  GENERIC( 
           component_name       : STRING := "dafir9";
           c_data_width         : INTEGER;
           c_result_width       : INTEGER;
           c_coeff_width        : INTEGER;
           c_taps               : INTEGER;
           c_response           : INTEGER;
           c_data_type          : INTEGER;
           c_coeff_type         : INTEGER;
           c_channels           : INTEGER;
           c_filter_type        : INTEGER;
           c_saturate           : INTEGER;
           c_has_sel_o          : INTEGER;
           c_has_sel_i          : INTEGER;
           c_has_reset          : INTEGER;
           c_mem_init_file      : STRING;
           c_zpf                : INTEGER;
           c_reg_output         : INTEGER;
           c_baat               : INTEGER;
           c_has_sin_f          : INTEGER;
           c_has_sin_r          : INTEGER;
           c_has_sout_r         : INTEGER;
           c_has_sout_f         : INTEGER;
           c_reload             : INTEGER;
           --c_reload_delay       : INTEGER;
           c_reload_mem_type    : INTEGER; -- ignored by model
           c_polyphase_factor   : INTEGER;
           c_optimize           : INTEGER; -- ignored by model
           c_enable_rlocs       : INTEGER; -- ignored by model
           c_use_model_func     : INTEGER; -- ignored by model
           --c_latency            : INTEGER;
           c_shape              : INTEGER); -- ignored by model
  PORT   ( din                  : IN  std_logic_vector( c_data_width-1 DOWNTO 0 ) := (OTHERS => '0');
           nd                   : IN  std_logic;
           clk                  : IN  std_logic;
           rst                  : IN  std_logic := '0';
           coef_ld              : IN  std_logic := '0';
           ld_din               : IN  std_logic_vector( c_coeff_width-1 DOWNTO 0) := (OTHERS => '0');
           ld_we                : IN  std_logic := '0';
           cas_f_in             : IN  std_logic_vector( c_baat-1 downto 0) := (OTHERS => '0');
           cas_r_in             : IN  std_logic_vector( c_baat-1 downto 0) := (OTHERS => '0');
           cas_f_out            : OUT std_logic_vector( c_baat-1 downto 0);
           cas_r_out            : OUT std_logic_vector( c_baat-1 downto 0);
           sel_i                : OUT std_logic_vector( bitsneededtorepresent(c_channels-1)-1 DOWNTO 0);
           sel_o                : OUT std_logic_vector( bitsneededtorepresent(c_channels-1)-1 DOWNTO 0);
           dout                 : OUT std_logic_vector( c_result_width-1 DOWNTO 0 );
           dout_q               : OUT std_logic_vector( c_result_width-1 DOWNTO 0 );
           dout_i               : OUT std_logic_vector( c_data_width-1 DOWNTO 0);
           rdy                  : OUT std_logic;
           rfd                  : OUT std_logic);
END fir_compiler_v5_0_da_fir;

ARCHITECTURE behavioral OF fir_compiler_v5_0_da_fir IS

  ------------------------------------------------------------------------
  --Replace input generic with function call to translated function
  constant c_latency : integer := get_da_fir_latency(
                                    c_filter_type,
                                    c_baat,
                                    c_data_width,
                                    c_data_type,
                                    c_taps,
                                    c_polyphase_factor,
                                    (c_response=c_da_symmetric or c_response=c_da_neg_symmetric),
                                    (c_reg_output=1));
  constant c_reload_delay: integer:=get_da_fir_reloadDelay(
                                      c_filter_type,
                                      c_data_width,
                                      c_baat,
                                      c_zpf,
                                      c_channels,
                                      c_taps,
                                      c_polyphase_factor,
                                      (c_response=c_da_symmetric or c_response=c_da_neg_symmetric),
                                      true);--GUI has this just set to true
-- ------------------------------------------------------------------------ --
-- GUI CONSTANT DECLARATIONS                                                --
-- ------------------------------------------------------------------------ --
  
  CONSTANT data_width               : INTEGER := c_data_width;
  CONSTANT result_width             : INTEGER := c_result_width;
  CONSTANT orig_number_of_taps      : INTEGER := c_taps;  -- number of taps specified by user
  CONSTANT number_of_taps           : INTEGER := c_taps + ((c_taps-1) * eval(c_filter_type=c_da_interpolated_fir) * (c_zpf-1));  -- total number of taps after adding zeros for interpolated filters
  CONSTANT coef_width               : INTEGER := c_coeff_width; 
  CONSTANT response                 : INTEGER := c_response;
  CONSTANT data_signed              : BOOLEAN := (c_data_type=c_da_signed);
  CONSTANT coef_signed              : BOOLEAN := (c_coeff_type=c_da_signed);
  CONSTANT data_nrz                 : BOOLEAN := (c_data_type=c_da_nrz);
  CONSTANT coef_nrz                 : BOOLEAN := (c_coeff_type=c_da_nrz);
  CONSTANT saturate                 : BOOLEAN := (c_saturate=1);
  CONSTANT has_out_chan_indicator   : BOOLEAN := (c_has_sel_o=1);
  CONSTANT has_in_chan_indicator    : BOOLEAN := (c_has_sel_i=1);
  CONSTANT chan_ind_width           : INTEGER := bitsneededtorepresent(c_channels-1);
  CONSTANT filter_type              : INTEGER := c_filter_type;
  CONSTANT number_of_channels       : INTEGER := c_channels;
  CONSTANT zero_packing_factor      : INTEGER := c_zpf;
  CONSTANT has_registered_output    : BOOLEAN := (c_reg_output=1);
  CONSTANT use_latency              : INTEGER := c_latency;
  CONSTANT baat                     : INTEGER := c_baat;
  CONSTANT coefficient_file         : STRING  := c_mem_init_file;
  CONSTANT pda                      : BOOLEAN := (c_baat = data_width);
  CONSTANT polyphase_factor         : INTEGER := c_polyphase_factor;
  CONSTANT interpolating_filter     : BOOLEAN := (c_filter_type = c_da_polyphase_interpolating);
  CONSTANT decimating_filter        : BOOLEAN := (c_filter_type = c_da_polyphase_decimating);
  CONSTANT interpolating_half_band  : BOOLEAN := (c_filter_type = c_da_interpolating_half_band);
  CONSTANT decimating_half_band     : BOOLEAN := (c_filter_type = c_da_decimating_half_band);
  CONSTANT hilbert_transform        : BOOLEAN := (c_filter_type=c_da_hilbert_transform);
  CONSTANT reloadable               : BOOLEAN := (c_reload = c_da_stop_during_reload);
  CONSTANT reload_delay             : INTEGER := c_reload_delay;
  CONSTANT local_coef_width	        : INTEGER := c_coeff_width + eval(c_coeff_type=c_da_nrz);
  CONSTANT local_data_width	        : INTEGER := c_data_width + eval(c_data_type=c_da_nrz);
  CONSTANT has_reset                : BOOLEAN := (c_has_reset = 1);
  
-- ------------------------------------------------------------------------ --
-- TYPE DECLARATIONS                                                        --
-- ------------------------------------------------------------------------ --
  
  TYPE  filter_coefficients_type IS ARRAY(1 TO number_of_taps) OF std_logic_vector(local_coef_width-1 downto 0);
  TYPE  tap_storage_type         IS ARRAY(1 TO number_of_taps) OF std_logic_vector(local_data_width-1 downto 0);
  TYPE  all_tap_storage_type     IS ARRAY(0 to number_of_channels-1) of tap_storage_type;
  
-- ------------------------------------------------------------------------ --
-- FUNCTIONS                                                                --
-- ------------------------------------------------------------------------ --
  
  FUNCTION hex_to_std_logic_vector(hexstring: STRING)
    RETURN std_logic_vector IS
    
    CONSTANT length       : integer := hexstring'LENGTH;
    VARIABLE bitval       : std_logic_vector((length*4)-1 downto 0);
    VARIABLE posn         : integer := bitval'LEFT;
    VARIABLE ch           : character;
  BEGIN
    FOR i in 1 to length LOOP
      ch := hexstring(i);
      CASE ch IS
        WHEN '0' => bitval(posn downto posn-3) := "0000";
        WHEN '1' => bitval(posn downto posn-3) := "0001";
        WHEN '2' => bitval(posn downto posn-3) := "0010";
        WHEN '3' => bitval(posn downto posn-3) := "0011";
        WHEN '4' => bitval(posn downto posn-3) := "0100";
        WHEN '5' => bitval(posn downto posn-3) := "0101";
        WHEN '6' => bitval(posn downto posn-3) := "0110";
        WHEN '7' => bitval(posn downto posn-3) := "0111";
        WHEN '8' => bitval(posn downto posn-3) := "1000";
        WHEN '9' => bitval(posn downto posn-3) := "1001";
        WHEN 'A' | 'a' => bitval(posn downto posn-3) := "1010";
        WHEN 'B' | 'b' => bitval(posn downto posn-3) := "1011";
        WHEN 'C' | 'c' => bitval(posn downto posn-3) := "1100";
        WHEN 'D' | 'd' => bitval(posn downto posn-3) := "1101";
        WHEN 'E' | 'e' => bitval(posn downto posn-3) := "1110";
        WHEN 'F' | 'f' => bitval(posn downto posn-3) := "1111";
        WHEN OTHERS => ASSERT false
                       REPORT "ERROR: FIR Compiler v4.0: Invalid hex value in MIF file" SEVERITY ERROR;
                       bitval(posn downto posn-3) := "XXXX";
     END CASE;
     posn := posn - 4;
   END LOOP;
   RETURN bitval;
 END hex_to_std_logic_vector;
 
--
-- Read coefficients from the mif file, and convert from NRZ to signed if necessary
--
  
  FUNCTION read_coefficients( filename: string;
                              number_of_values: integer;
                              nrz_coef: boolean )
    RETURN filter_coefficients_type IS

    VARIABLE coefficients : filter_coefficients_type;
    FILE     coeffile     : TEXT IS filename;
--     VARIABLE hexline      : LINE;
--     VARIABLE width        : INTEGER := (coef_width+3)/4;
--     VARIABLE hexstring    : STRING(1 TO width);
--     VARIABLE bitval       : std_logic_vector(width*4 -1 DOWNTO 0);
    VARIABLE binline      : LINE;
    VARIABLE binval       : bit_vector(coef_width-1 downto 0);
    VARIABLE bitval       : std_logic_vector(coef_width-1 downto 0);
    VARIABLE lines        : INTEGER := 1;
  BEGIN
    WHILE (NOT(endfile(coeffile)) AND (lines <= number_of_values)) LOOP
--       readline(coeffile, hexline);
--       read(hexline, hexstring);
--       bitval := hex_to_std_logic_vector(hexstring);
      readline(coeffile, binline);
      read(binline, binval);
      bitval := to_stdlogicvector(binval);
      if (nrz_coef) then
        if (bitval(0) = '0') then
          coefficients(lines) := "01";
        elsif (bitval(0) = '1') then
          coefficients(lines) := "11";
        else
          ASSERT false
          REPORT "ERROR: FIR Compiler v4.0: Invalid NRZ data in MIF file" SEVERITY ERROR;
          coefficients(lines) := "XX";
        end if;
      else
        coefficients(lines) := bitval(coef_width-1 downto 0);
      end if;
      lines := lines + 1;
    END LOOP;
    return coefficients;
  END read_coefficients;
  
--
-- Use function read_coefficients to read the mif file, and convert from NRZ to signed if necessary.
-- For interpolated filters, add zeros in the coefficient array.
--
 FUNCTION assign_filter_coefficients( filename              : STRING;
                                      filter_type           : INTEGER;
                                      orig_number_of_taps   : INTEGER;
                                      zero_packing_factor   : INTEGER;
                                      number_of_taps        : INTEGER;
                                      nrz_coef              : BOOLEAN )
    RETURN filter_coefficients_type IS
    
    VARIABLE filter_coefficients        : filter_coefficients_type;
    VARIABLE packed_filter_coefficients : filter_coefficients_type;
    VARIABLE posn                       : INTEGER;
  BEGIN
    filter_coefficients := read_coefficients(filename, orig_number_of_taps, nrz_coef );
    IF (filter_type = c_da_interpolated_fir) THEN
      posn := 1;
      FOR i IN 1 TO orig_number_of_taps-1 LOOP
        packed_filter_coefficients(posn) := filter_coefficients(i);
        posn := posn + 1;
        IF (zero_packing_factor > 1) THEN
          FOR j in 1 TO zero_packing_factor-1 LOOP
            packed_filter_coefficients(posn) := (OTHERS => '0');
            posn := posn + 1;
          END LOOP;
        END IF;
      END LOOP;
      packed_filter_coefficients(posn) := filter_coefficients(orig_number_of_taps);
      ASSERT posn = number_of_taps REPORT "ERROR: FIR Compiler v4.0: fundamental error in assigning coeffs" SEVERITY ERROR;
    ELSE
      packed_filter_coefficients := filter_coefficients;
    END IF;
    RETURN packed_filter_coefficients;
  END assign_filter_coefficients;
  
--
-- Compute the latency of the parallel to serial converter depending on the filter characteristics.
-- This is the number of cycles after ND that RFD will be asserted again.
--
  function compute_psc_latency( symmetric   : boolean;
                                baat        : integer;
                                data_width  : integer)
  return integer is
  
  variable psc_latency: integer := 0;
  begin
    if (baat = data_width) then
      psc_latency := 1;
    elsif (baat = 1) then
      psc_latency := data_width + (eval(NOT (interpolating_filter) AND symmetric)); 
    else
      psc_latency := (data_width + eval(NOT (interpolating_filter) AND symmetric) + (baat - 1))/baat;
    end if;
    if ((interpolating_filter OR interpolating_half_band) AND (psc_latency < polyphase_factor)) then
      psc_latency := polyphase_factor;
    end if;
    psc_latency := psc_latency-1; -- subtract one because the model doesn't count the first rising edge
    return psc_latency;
  end compute_psc_latency;
  
  
  -- ------------------------------------------------------------------------------
  -- Functions to clear and set the input std_logic_vector
  -- ------------------------------------------------------------------------------
  function all0(a: std_logic_vector)
    RETURN boolean IS
    
  variable z: std_logic_vector(a'LENGTH-1 downto 0) := (OTHERS => '0');
  BEGIN
    return (a = z);
  END all0;
  
  function all1(a: std_logic_vector)
    RETURN boolean IS
    
  variable o: std_logic_vector(a'LENGTH-1 downto 0) := (OTHERS => '1');
  BEGIN
    return (a = o);
  END all1;
  
  function any1(a: std_logic_vector)
    RETURN boolean IS
    
  variable z: std_logic_vector(a'LENGTH-1 downto 0) := (OTHERS => '0');
  BEGIN
    return (NOT (a = z));
  end any1;

-- ---------------------------------------------------------------------------
-- Zero the data memory.  Note that if the data is NRZ then the data memory is initialized with 1s (NRZ 0).
-- ---------------------------------------------------------------------------
  function zero_taps(number_of_taps: integer; 
                     data_nrz: boolean)
    RETURN tap_storage_type IS
    
  variable retval: tap_storage_type;
  BEGIN
    if (data_nrz) then
      for i in 1 to number_of_taps loop
        retval(i) := "01";
      end loop;
    else
      for i in 1 to number_of_taps loop
        retval(i) := (OTHERS => '0');
      end loop;
    end if;
    return retval;
  END zero_taps;
  
-- ------------------------------------------------------------------------ --
-- CONSTANT DECLARATIONS                                                    --
-- ------------------------------------------------------------------------ --

  CONSTANT symmetric            : BOOLEAN := (response = c_da_symmetric OR response = c_da_neg_symmetric);
  CONSTANT psc_latency          : INTEGER := compute_psc_latency(symmetric, baat, data_width);
  CONSTANT cascade_num_cycles   : INTEGER := (data_width + eval(data_width /= baat)*eval(symmetric) + baat - 1)/baat;
  CONSTANT extwidth             : INTEGER := cascade_num_cycles*baat;
  CONSTANT full_result_width    : INTEGER := local_coef_width + local_data_width + bitsneededtorepresent(number_of_taps);

-- ------------------------------------------------------------------------ --
-- SIGNAL DECLARATIONS                                                      --
-- ------------------------------------------------------------------------ --

  SIGNAL process_data           : std_logic                                 := '0';
  SIGNAL data_ready             : std_logic                                 := '0';
  SIGNAL result_ready           : std_logic                                 := '0';
  SIGNAL processed_result       : std_logic                                 := '0';
  SIGNAL data                   : all_tap_storage_type                      := (OTHERS => zero_taps(number_of_taps, data_nrz));
  SIGNAL filter_coefficients    : filter_coefficients_type                  := assign_filter_coefficients(coefficient_file, filter_type, orig_number_of_taps, zero_packing_factor, number_of_taps, coef_nrz);
  SIGNAL channel_number         : integer                                   := 0;
  SIGNAL new_data               : std_logic_vector(data_width-1 downto 0)   := (OTHERS => '0');
  SIGNAL delayed_new_data       : std_logic_vector(data_width-1 downto 0)   := (OTHERS => '0');
  SIGNAL result                 : std_logic_vector(result_width-1 downto 0) := (OTHERS => '0');
  SIGNAL mid_value              : std_logic_vector(data_width-1 downto 0)   := (OTHERS => '0');
  SIGNAL polyphase_internal_nd  : std_logic                                 := '0';
  SIGNAL ce                     : std_logic                                 := '1';
  SIGNAL lrfd                   : std_logic                                 := '1';
  SIGNAL reloading              : std_logic                                 := '0';

BEGIN

  -- use the internal lrfd signal to drive the output Port RFD
  rfd <= lrfd;
  
  --
-- Handle new data, and set up the output signals lrfd (the local version of RFD), and SEL_I
-- If reloading has started, then
--   set RFD to 0
--   Wait a cycle and set SEL_I to 0
--   Wait for reloading to be completed before waiting for new data again
-- If the ND signal is asserted, then
--   Update the input channel number and SEL_I
--   Assert data_ready so that tap_storage can store the new data.  Wait until process_data is
--     cleared to indicate that the data has been processed.
--   Clear RFD and wait psc_latency cycles before asserting RFD again
--   For decimating filters, polyphase_factor samples must be read in before they are processed.
--     These filters have an external memory that can store the new samples while the subfilters
--     are processing the old samples.  Signals polyphase_internal_nd indicate when a sample set
--     has been stored.
--
  data_input_handler : PROCESS
    variable local_data                 : std_logic_vector(data_width-1 downto 0) := (OTHERS => '0');
    variable local_channel_number       : integer := 0;
    variable decimating_channel_number  : integer := 0;
    variable sample_set_count           : integer := 0;
    variable setup                      : boolean := TRUE;
    variable processing_clock_count     : integer := 0; 
    variable fifo_full                  : boolean := false;
    variable reset_asserted             : integer := 0;
    variable dummy_var                  : integer := 0;

    -- set-up variable and types for decimating multi-channel filters DIN FIFOs
    type fifo_storage is array(1 to 16) of std_logic_vector(data_width-1 downto 0);
    type input_storage is array(0 to c_polyphase_factor-1) of fifo_storage;
    type read_pointer is array(0 to c_polyphase_factor-1) of integer;
    
    variable data_input_storage       : input_storage;
    variable data_input_pointer       : read_pointer;
    
  BEGIN
  
    -- --------------------------------------------------------------
    -- SET-UP: only used the first time through the filter to insure that everything is initialized
    -- --------------------------------------------------------------
    if (setup) then
        -- set local RFD to asserted, can accept input
        lrfd <= '1';
        
        -- clear the channel indicator to point at channel 0
        if (has_in_chan_indicator) then
            sel_i <= (OTHERS => '0');
        end if;
        
        -- decimating filters with multi-channel then have some extra variables
        if ( decimating_half_band OR decimating_filter ) then
            for i in 1 to 16 loop
                for j in 0 to (c_polyphase_factor - 1) loop
                    data_input_storage(j)(i) := (OTHERS => '0');
                end loop;
            end loop;
            
            for j in 0 to (c_polyphase_factor - 1) loop
                data_input_pointer(j) := 0;
            end loop;
        end if;
        
        -- done with set-up, set the boolean to false don't need to run this code again
        setup := false;
    end if;
    
    -- --------------------------------------------------------------
    -- Wait for either a  Reset assertion OR Reload operation OR a rising edge on the clock
    -- --------------------------------------------------------------
    WAIT until (   (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' )
                OR (reloading ='1')
                OR reset_asserted = 1 );
    
    -- check the signals and respond to the conditions
    -- FIRST check RESET -- highest priority
    if ( reset_asserted = 1 OR (rst='1' AND has_reset) ) then
        -- handle the reset operation
        lrfd <= '0';
        reset_asserted := 0;
        polyphase_internal_nd <= '0';
        processing_clock_count := 0;
        local_channel_number := 0;
        decimating_channel_number := 0;
        channel_number <= 0; 
        data_ready <= '0';
        
        -- reset the polyphase arm indicator back to the first arm
        sample_set_count := 0;
        
        -- clear all the local stored data versions
        local_data := (OTHERS => '0');
        new_data   <= (OTHERS => '0');
        
        -- clear the channel indicator
        if (has_in_chan_indicator) then
            sel_i <= (OTHERS => '0');
        end if;
        
        -- wait here until the RESET signal is turned off and a clock edge
        wait until (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='0');
        
        -- everything should be reset and Ready For Data again
        lrfd <= '1';
        
    elsif ( reloading = '1' ) then
        -- --------------------------------------------------------------
        -- Handle reload operation
        -- --------------------------------------------------------------
        -- turn the local version of the RFD signal off
        lrfd <= '0';
       
        -- clear the channel indicator on the next clock edge
        if (has_in_chan_indicator) then
            sel_i <= (OTHERS => '0');
        end if;
        
        -- WAIT for the reload operation to complete
        WAIT UNTIL reloading = '0' OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset);
        
        if ( rst='1' AND has_reset) then
            reset_asserted := 1;
        else
            -- reload operation complete, turn the local RFD back on
            lrfd <= '1';
            -- insure that the channel indicator is cleared
            processing_clock_count :=0;
            local_channel_number := 0;
            decimating_channel_number := 0;
            channel_number <= 0; 
            -- reset the polyphase arm indicator back to the first arm
            sample_set_count := 0;
            -- clear all the stored data versions and set the polyphase ND back to deasserted
            local_data := (OTHERS => '0');
            new_data   <= (OTHERS => '0');
            polyphase_internal_nd <= '0';
            data_ready <= '0';
            WAIT for 0 ns;
            -- everything should be as if the filter was reset
        end if;
    else --not reset or reload
        -- check for filter type
        if ( decimating_half_band OR decimating_filter ) then
            -- Decimating filter types have special requirements for input handling, the input must be held until
            -- all of the input samples have been received. In the case of a multi-channel filter the input data
            -- is channel interleaved. FIFOs are added to allow for the incoming sample sets to be formed.
            
            -- decrement the counter that tracks how many clocks have passed since last sample set started processing
            if ( processing_clock_count > 0 ) then
                processing_clock_count := processing_clock_count - 1;
            end if;
            
            -- check if a new DIN has arrived
            if ( (nd = '1') AND (lrfd = '1') ) then
                -- transfer the DIN Port data to the internal local_data signal
                local_data := din;
                new_data   <= local_data;
                wait for 0 ns;
                
                -- two cases: 1 channel and more then 1 channel
                -- for 1 channel then there are just a set of input registers that get filled, for more then 1 channel input FIFOs
                if ( number_of_channels = 1 ) then
                
                    if ( sample_set_count = (polyphase_factor - 1) ) then
                        -- need to process the data
                        -- check if the last set of data is finished being processed, IF NOT then wait that number clocks
                        -- ELSE proceed to storing the data and processing it.
                        while ( processing_clock_count > 0 ) loop
                            -- NOT finished processing the last sample set need to wait here for the remaining clock cycles
                            -- while waiting the input buffer is full so NOT Ready For Data; turn lrfd off
                            lrfd <= '0';
                            WAIT until (    (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' )
                                         OR reloading = '1'
                                         OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset) );
                                         
                            if (   reloading = '1'
                                OR( clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset) ) then
                                if ( rst = '1' AND has_reset) then
                                    reset_asserted := 1;
                                end if;
                                exit;
                            end if;
                           
                            -- another clock cycle occured, decrement the counter
                            processing_clock_count := processing_clock_count - 1;
                            
                        end loop; -- loop waiting for processing_clock_count to reach 0
                        
                        if ( (rst='0' OR NOT has_reset) AND reset_asserted= 0 AND reloading = '0' ) then
                            -- filter is ready to process data, assert the data_ready signal to start the processing
                            data_ready <= '1';
                            polyphase_internal_nd <= '1';
                            processing_clock_count := (psc_latency + 1);
                            -- signaled other process that data was available, it in turn will signal when it's done
                            WAIT until ( process_data'event AND process_data = '0');
                            data_ready <= '0'; 
                            polyphase_internal_nd <= '0';
                            sample_set_count := 0;
                            lrfd <= '1';
                        end if;
                    else
                        -- do NOT have a full set BUT still need to store the data in the tap storage
                        data_ready  <= '1';
                        polyphase_internal_nd <= '0';
                        -- wait causes the signals to be assigned
                        WAIT for 0 ns;
                        -- processing happens in 0ns (done)
                        data_ready  <= '0'; 
                        lrfd        <= '1';
                        sample_set_count := sample_set_count + 1;
                    end if; -- have a full set of data      
                else 
                    -- have a multi-channel decimating filter, handle the input FIFOs
                    
                    -- store the data in the input FIFO (which sub-filter)(which sample bin)
                    -- first move all the sample down to make room for this sample
                    for i in 15 downto 1 loop
                        data_input_storage(sample_set_count)(i + 1) := data_input_storage(sample_set_count)(i);
                    end loop;
                    -- made room in FIFO storage now store this sample
                    data_input_storage(sample_set_count)(1) := local_data;
                    -- increment this sub-filter FIFO read pointer to next location (every sample moved down by 1)
                    data_input_pointer(sample_set_count) := data_input_pointer(sample_set_count) + 1;
                    
                    -- if have received all of the samples for this sub-filter then move to the next sub-filter
                    if ( local_channel_number = (number_of_channels - 1) ) then
                        local_channel_number := 0;
                        sample_set_count := sample_set_count + 1;
                        if ( sample_set_count > (c_polyphase_factor - 1) ) then
                            sample_set_count := 0;
                        end if;
                    else
                        local_channel_number := local_channel_number + 1;
                    end if;
                    
                    -- update the Port SEL_I channel counter variable
                    if (has_in_chan_indicator) then
                        sel_i <= int_2_std_logic_vector(local_channel_number, chan_ind_width);
                    end if;
               end if;     -- check for number_of_channels > 1
            end if;      -- input sample available 
            
            -- for multi-channels operation the FIFO having a complete set of samples 
            -- OR the FIFO having samples and the filter becomes available will start a processing operation
            if ( number_of_channels > 1 ) then
                if ( (processing_clock_count = 0) AND (data_input_pointer(polyphase_factor - 1) > 0) ) then
                    -- have a complete set of samples and the filter is available
                    -- move the oldest set of samples out of the FIFOs into the filter and then process
                    channel_number <= decimating_channel_number;
                    for i in 0 to (polyphase_factor - 1) loop 
                        -- read the FIFO value out and set the new_data signal, the tap_store process will store/process
                        new_data  <= data_input_storage(i)(data_input_pointer(i));
                        
                        -- decrement the FIFOs READ location pointer
                        if ( data_input_pointer(i) > 0 ) then
                            data_input_pointer(i) := data_input_pointer(i) - 1;
                        else
                            data_input_pointer(i) := 0;
                        end if;
                        
                        -- set the flag that stores the data (tap sotre process)
                        data_ready <= '1';
                        -- if this is the last sample for the set then process then set the flag that processes the data
                        if ( i = (polyphase_factor - 1) ) then
                            polyphase_internal_nd <= '1';
                            WAIT until ( process_data'event AND process_data = '0');
                        else
                            polyphase_internal_nd <= '0';
                            WAIT for 0 ns;
                        end if;
                        -- clear the flag that stored the data
                        data_ready <= '0';
                        WAIT for 0 ns;
                    end loop;
                    
                    -- set the counter for the number clocks that the filter is busy processing the last set of data
                    processing_clock_count := (psc_latency + 1);
                    
                    -- adjust the counter that tell the tap store/processing which channel handling
                    if ( decimating_channel_number = (number_of_channels - 1) ) then
                        decimating_channel_number := 0;
                    else
                        decimating_channel_number := decimating_channel_number + 1;
                    end if;
                    
                end if; -- check for filter is ready and sample set available
                
                -- check if the filter is busy and any FIFO full
                if ( data_input_pointer(polyphase_factor - 1) >= 8 ) then
                    lrfd <= '0';
                else
                    lrfd <= '1';
                end if;
            end if;
        else
            -- all other types of filters 
            -- check if need to handle an input sample
            if (rat(nd)='1' and lrfd = '1') then
                -- ND was asserted and the local RFD is asserted, handle the input
                -- set the channel number on the output port and then update the internal channel counter
                channel_number <= local_channel_number;
                local_channel_number := (local_channel_number + 1) MOD number_of_channels;
                if (has_in_chan_indicator) then
                    sel_i <= int_2_std_logic_vector(local_channel_number, chan_ind_width);
                end if;
                -- transfer the DIN Port data to the internal local_data signal
                local_data := din;
                new_data <= local_data;
                
                -- assert the data_ready signal to start the processing
                data_ready <= '1'; 
                -- signaled other process that data was available, it in turn will signal when it's done, wait for it
                WAIT until (    (process_data'event AND process_data = '0')    );
                data_ready <= '0';
                
                -- need to wait for the number clock cyles required to process the data
                if (psc_latency > 0) then
                    lrfd <= '0';
                    for i in 1 to psc_latency loop
                        WAIT until (    clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' )
                                     OR reloading = '1'
                                     OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset);
                                     
                        if (   reloading = '1'
                            OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset)) then
                            if (rst ='1' AND has_reset) then
                                reset_asserted := 1;
                            end if;
                            exit;
                        end if;
                    end loop;
                end if;
                
                if  ( reloading = '0' AND reset_asserted = 0 ) then
                -- turn the Ready For Data signal back on
                    lrfd <= '1' ;
                else
                    dummy_var := 0; --this else statement is needed for the above if statement to work correctly...strange bug
                end if;
                
            end if; -- rat(nd) = '1'
        end if;     -- check for filter type
    end if;         -- check for signals/something to handle
    
end process data_input_handler;

-- ------------------------------------------------------------------------------------------
-- Update the data memory with the new DIN value. Becomes active when data_ready is asserted.
--    o Handle unknowns on the inputs.
--    o For interpolating filters, stuff 0s into the data memory.
--    o For NRZ data, translate from NRZ to signed before storing in data memory
--    o Assert process_data for a new result to be computed
--    o Clears the data memory when the filter is being reloaded
-- ------------------------------------------------------------------------------------------
  tap_storage : PROCESS
  variable setup        : boolean := TRUE;
  constant midpoint     : integer := (number_of_taps+1)/2;
  constant loop_count   : integer := eval(interpolating_half_band OR interpolating_filter) * (polyphase_factor-1) + 1;
  variable local_data   : std_logic_vector(local_data_width-1 downto 0);
  BEGIN
    if (setup = TRUE) then
        WAIT UNTIL clk'event AND rat(clk)='1' AND rat(clk'last_value)='0';
        setup := false;
        
    elsif ( rat(clk) = 'X' AND rat(ce) /= '0' AND rat(clk'LAST_VALUE)/='X' ) then
        -- undefined clk, make all internal data undefined
        for i in 0 to number_of_channels-1 loop
            for j in 1 to number_of_taps loop
              data(i)(j) <= setallX(data_width);
            end loop;
        end loop;
    elsif ( clk'event AND clk = '1' AND clk'LAST_VALUE = '0' AND rst = '1' AND has_reset) then
        -- have detected a reset signal asserted with rising edge of clock (sync) wait for reset to be turned of
        wait until ( clk'event AND clk = '1' AND clk'LAST_VALUE = '0' AND rst = '0' );
    elsif (data_ready'event and data_ready='1' ) then
        -- Store the incoming sample 
        if (anyX(new_data)) then
            -- incoming data has at least one undefined signal(s), set entire word to undefined
            local_data := (OTHERS => 'X');
        elsif (data_nrz) then
            -- NRX data -- convert to a 2 bit word equivelent value
            if (new_data(0) = '0') then
                local_data := "01";
            else
                local_data := "11";
            end if;
        else
            local_data := new_data;
        end if;
        
        for i in 1 to loop_count loop
            -- move all of the data down one location until get to the 1st location
            for j in number_of_taps downto 2 loop
                data(channel_number)(j) <= data(channel_number)(j-1);
            end loop;
            
            -- store the incoming data in the 1st location
            data(channel_number)(1) <= local_data;
            
            -- IF this is not a decimating filter (that requires multiple input samples) then set the flag
            -- that starts the data processing and then wait for it to complete
            if (NOT (decimating_half_band OR decimating_filter) OR polyphase_internal_nd = '1') then 
                -- set the flag, which starts the data processing procedure
                process_data <= '1';
                -- the data processing procedure will assert the result_ready signal when done
                -- break from the wait if reset is detected
                WAIT until (result_ready'event AND result_ready = '0') OR reloading = '1'
                            OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset);
                -- turn the process_data signal off
                process_data <= '0';
                -- by WAITing for 0ns the process is suspended and so the signal assignments are done
                WAIT for 0 ns;
            else 
                -- filter is a decimating type and have not reached the decimation rate yet
                process_data <= '0';
                WAIT for 0 ns;
            end if;
            
            -- clear the local data
            local_data := (OTHERS => '0');
        end loop;
    end if;
    
        -- ---------------------------------------------------------------------
        -- Handle Reload case, clear the memory and wait for reload to complete
        -- ---------------------------------------------------------------------
        if (reloading = '1' AND (rst = '0' OR NOT has_reset)) then
            -- loop for each channel clear the memory
            for i in 0 to number_of_channels-1 loop
                -- loop for each of the taps
                for j in 1 to number_of_taps loop
                    if (data_nrz) then
                        data(i)(j) <= "01";
                    else
                        data(i)(j) <= (OTHERS => '0');
                    end if;
                end loop;
            end loop;
            
            -- insure that the process_data signal is turned off and then wait for the reload to be done
            process_data <= '0';
            WAIT until reloading = '0';
        end if;
        
      -- WAIT for the next event to handle
      wait on clk, data_ready, reloading;
      
  end process tap_storage;
  
-- --------------------------------------------------------------------------
-- Handle reloading.
--   o assert reloading signal so other process go into reload mode
--   o read in and validate the new coefficients
--   o start the filter up once reloading is complete
-- --------------------------------------------------------------------------
  reload: PROCESS
  
    constant num_coefs: integer := (eval(symmetric) * (orig_number_of_taps + 1)/2) + (eval(NOT symmetric) * orig_number_of_taps);
    constant half_band: boolean := (filter_type = c_da_half_band OR filter_type = c_da_decimating_half_band OR filter_type = c_da_interpolating_half_band);
    variable local_coef         : std_logic_vector(local_coef_width-1 downto 0) := (OTHERS => '0');
    variable posn               : integer        := 1;
  BEGIN
    if (NOT reloadable) then
        WAIT;
    else
        -- in reload condition, WAIT for the load coefficient input signal then check and store new coefficient
        WAIT until (     (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rat(coef_ld)='1')
                     AND (rst ='0' OR NOT has_reset) );
        reloading <= '1';
        posn := 1;
        
        -- loop through for each of the new coefficients
        for i in 1 to num_coefs loop
            -- wait til the WE signal is asserted and a rising edge on the clock
            WAIT UNTIL (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rat(ld_we)='1')
                       OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset);
            
            if (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset) then
                assert(false) report"WARNING: FIR Compiler v4.0: Filter reset during reload operation.  DOUT will be invalid until filter is reloaded again." severity warning;
                exit;
            end if;
            
            -- check that the coefficient is valid for this filter type and tap
            if (((filter_type = c_da_half_band) OR (filter_type = c_da_decimating_half_band) OR (filter_type = c_da_interpolating_half_band) ) AND (i MOD 2 = 0) AND (i < num_coefs)) then
                ASSERT (all0(ld_din)) report "ERROR: FIR Compiler v4.0: Not a valid coefficient for a halfband filter : this coefficient must be zero." severity error;
            elsif ((filter_type = c_da_hilbert_transform) AND (i MOD 2 = 0)) then
                ASSERT (all0(ld_din)) report "ERROR: FIR Compiler v4.0: Not a valid coefficient for a hilbert transform : this coefficient must be zero." severity error;
            end if;
            
            -- for NRZ coefficients need to convert to equivelent 2's complement data types
            if (coef_nrz) then
                if (ld_din(0) = '0') then
                    local_coef := "01";
                elsif (ld_din(0) = '1') then
                    local_coef := "11";
                else
                    local_coef := "XX";
                end if;
            else
                local_coef := ld_din;
            end if;
            
            -- store the coefficient in the array
            filter_coefficients(posn) <= local_coef;
            
            -- user only needs to supply 1/2 the coefficients if symmetric, so copy this coefficient into the
            -- other side (symmetric partner) of the coefficient array
            if (response = c_da_symmetric) then
                filter_coefficients(number_of_taps-posn+1) <= local_coef;
            elsif (response = c_da_neg_symmetric AND (orig_number_of_taps MOD 2 = 0 OR posn < (number_of_taps+1)/2)) then
                filter_coefficients(number_of_taps-posn+1) <= two_comp(local_coef);
            end if;
            
            -- calculate what the next coefficient position in the array will be
            -- for INTERPOLATED coefficients the user does not specify the 0's between coefficients so we need to
            -- insert these into the models coefficient array. This is done by zeroing the array initially and then
            -- skipping these locations in the array as the new coefficients are written. 
            -- for all other types of filters the user provides the zeros in the coefficient stream
            if (filter_type = c_da_interpolated_fir) then
                posn := posn + zero_packing_factor;
            else
                posn := posn + 1;
            end if;
            
        end loop;
        
        if (rst = '0' OR NOT has_reset) then 
            -- after all of the coefficients are loaded there are a number of clock cycles that are required to load the 
            -- filters table -- wait that number clocks
            for i in 1 to reload_delay loop
                WAIT UNTIL (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0') 
                           OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset);
                if (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset) then
                    assert(false) report"WARNING: FIR Compiler v4.0: Filter reset during reload operation.  DOUT will be invalid until filter is reloaded again." severity warning;
                    exit;
                end if;
                ASSERT (rat(coef_ld)='0') report "ERROR: FIR Compiler v4.0: COEF_LD should not be asserted when the filter is being reloaded" severity error;
                ASSERT (rat(ld_we)='0') report "ERROR: FIR Compiler v4.0: LD_WE should not be asserted when the filter is being reloaded" severity error;
            end loop;
         end if;
        
        reloading <= '0';
    end if;
  end process reload;
        

-- ------------------------------------------------------------------------------
-- Multiply accumulate
--   When process_data is asserted, compute the new result.
--   Assert result_ready so the new result may be saved
-- ------------------------------------------------------------------------------
    mac: PROCESS
        variable local_result   : std_logic_vector(full_result_width-1 downto 0) := (OTHERS => '0');
        variable ldata          : std_logic_vector(data_width downto 0);
        variable coef           : std_logic_vector(coef_width downto 0);
        variable product        : std_logic_vector(data_width+1+coef_width+1-1 downto 0);
        
        -- ----------------------------------------------------------------------
        -- Multiply two std_logic_vectors - both must be the same width.  
        -- Use bit-arithmetic if the result bitwidth is greater than 32
        -- ----------------------------------------------------------------------
        FUNCTION "*"(a, b : std_logic_vector)
            RETURN std_logic_vector IS
            
            constant a_width    : integer := a'LENGTH;
            constant b_width    : integer := b'LENGTH;
            variable la         : std_logic_vector(a_width-1 downto 0) := a;
            variable lb         : std_logic_vector(b_width-1 downto 0) := b;
            variable product    : std_logic_vector(a_width+b_width-1 downto 0);
            variable negative   : boolean;
            variable a_value, b_value, prod_value: integer;
            variable index      : integer;
            variable cin, value : std_logic;
            
            BEGIN
                if (anyX(la) or anyX(lb)) then
                    product := setallX(a_width+b_width);
                elsif (all0(la) or all0(lb)) then
                    product := (OTHERS => '0');
                elsif ( a_width + b_width < 32 ) then
                    a_value := std_logic_vector_2_int(la);
                    b_value := std_logic_vector_2_int(lb);
                    prod_value := a_value * b_value;
                    product := int_2_std_logic_vector(prod_value,a_width+b_width);
                else
                    negative := FALSE;
                    if ( (la(a_width-1) xor lb(b_width-1)) = '1' ) then
                    negative := TRUE;
                end if ;
                
                if (la(a_width-1) = '1') then
                    la := two_comp(la);
                end if ;
                
                if (lb(b_width-1) = '1') then
                    lb := two_comp(lb);
                end if ;
                
                product := (OTHERS => '0');
                for i in 0 to b_width -1 loop -- b width
                    if (lb(i) = '1') then
                        index := i;
                        cin := '0';
                        
                        for j in 0 to a_width-1 loop  -- add a to prod
                            value := product(index) xor la(j) xor cin; -- sum
                            cin := (product(index) and la(j)) or (product(index) and cin) or
                            (la(j) and cin); -- carry
                            product(index) := value;
                            index := index + 1;
                        end loop;
                        
                        product(index) := product(index) xor cin; -- last carry
                    else
                        cin := '0';
                    end if;
                end loop; 
                
                if (negative) then
                    product := two_comp(product);
                end if;
                
            end if;
            return product;
        end "*";
        
-- ---------------------------------------------------------
-- Add two std_logic_vectors - both must be the same width
-- ---------------------------------------------------------
    function "+"(a,b : std_logic_vector)
        return std_logic_vector IS
        constant a_width: integer := a'LENGTH;
        constant b_width: integer := b'LENGTH;
        constant max_width: integer := eval(a_width >= b_width)*a_width + eval(b_width > a_width)*b_width;
        variable sa : std_logic_vector(max_width-1 downto 0) := extend(a, max_width);
        variable sb : std_logic_vector(max_width-1 downto 0) := extend(b, max_width);
        variable retval : std_logic_vector(max_width-1 downto 0);
        variable carry : std_logic := '0';
    BEGIN  -- plus
        IF (anyX(sa) OR anyX(sb)) THEN
            retval := (OTHERS => 'X');
        elsif (all0(sa)) THEN
            retval := sb;
        elsif (all0(sb)) THEN
            retval := sa;
        else
          FOR i IN 0 TO max_width-1 LOOP
            retval(i) := sa(i) XOR sb(i) XOR carry;
            carry := (sa(i) AND sb(i)) or
                     (sa(i) AND carry) or
                     (sb(i) AND carry);
          END LOOP;  -- i
        END IF;
        
        RETURN retval;
    END "+";
    
-- 
-- Convert a std_logic_vector to the required width.
-- If the output width is greater than the vector width, then sign or zero extend it
-- If the output width is less than the vector width, and we are not saturating, then use
--   the least significant bits.  If saturating, and the vector has overflowed (or underflowed)
--   the output bit width, then return the largest positive or smallest negative number.  
-- Saturating is not supported in this release.
    function saturated_value( data: std_logic_vector;
                              signed, saturate: boolean;
                              data_width, out_width: integer)
      RETURN std_logic_vector IS
      variable result: std_logic_vector(out_width-1 downto 0);
      variable temp_ones : std_logic_vector(out_width-1 downto 0);
    begin
      temp_ones := (others => '1');

      if (out_width > data_width) then
        result := extend(data, out_width, signed);
      elsif (out_width = data_width) then
        result := data;
      elsif (NOT saturate) then
        result := data(out_width-1 downto 0);
      else
        if (signed) then
          if ((data(out_width-1)='1' AND all1(data(data_width-1 downto out_width))) OR
              (data(out_width-1)='0' AND all0(data(data_width-1 downto out_width)))) then
             result := data(out_width-1 downto 0);
          elsif (data(data_width-1) = '1') then
            result := (OTHERS => '1');
          else
            result(out_width-1) := '0';
            result(out_width-2 downto 0) := temp_ones(out_width-2 downto 0);
          end if;
        else -- unsigned
          if (any1(data(data_width-1 downto out_width))) then
            result := (OTHERS => '1');
          else
            result := data(out_width-1 downto 0);
          end if;
        end if;
      end if;
      return result;
    end saturated_value;
    
    -- -----------------------------------------------------------------
    -- Actual MAC calculation
    -- -----------------------------------------------------------------
    BEGIN
        WAIT UNTIL (   process_data'event AND process_data = '1')
                    OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset);
        
        if (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset) then
            -- detected a RESET, wait till it's over
            WAIT UNTIL (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='0');
        else
            local_result := (OTHERS => '0');
            
            for j in 1 to number_of_taps loop
                ldata := extend(data(channel_number)(j), data_width+1, data_signed);
                coef :=  extend(filter_coefficients(j), coef_width+1, coef_signed);
                product := ldata * coef;
                local_result := local_result + product;
            end loop;
            
            result <= saturated_value(local_result, data_signed OR coef_signed OR data_nrz OR coef_nrz, saturate, full_result_width, result_width);
            mid_value <= data(channel_number)(number_of_taps/2 + number_of_taps MOD 2)(data_width-1 downto 0);
            result_ready <= '1';
            WAIT UNTIL  (   (processed_result'event AND processed_result='1')
                         OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset) 
                         OR (reloading = '1') );
            result_ready <= '0';
        end if;
    end process; --mac 
    
--
-- Store the computed results for latency cycles, and assign them to DOUT or DOUT_I and DOUT_Q at
-- this time.  The results are stored in a linked list, along with the number of cycles they
-- must be delayed.  This value is decremented every cycle.  When the value reaches zero, it
-- is placed on an output port, and RDY asserted.
-- For interpolating filters, multiple results are generated from a single input sample.  This
-- process ensures that these results are output in subsequent cycles by incrementing the latency
-- for each consecutive result.
-- This process also tracks the output channel for multichannel filters, and sets SEL_O
-- accordingly.
-- When the filter is reloading, the linked list is deleted
--
  delay_result: PROCESS
    function compute_latency(use_latency: integer ) return integer is
    
    variable latency: integer := 0;
    begin
      latency := use_latency;
      latency := latency - 1;  -- because the model doesn't count the first rising edge
      return latency;
    end compute_latency;
    
    constant latency: integer := compute_latency(use_latency);
    type output_record;
    type output_ptr is access output_record;
    type output_record is
      record
        result: std_logic_vector(result_width-1 downto 0);
        mid_result: std_logic_vector(data_width-1 downto 0);
        channel_number: integer;
        cycles_left: integer;
        nxt: output_ptr;
      end record;
    variable list_head: output_ptr := NULL;
    variable elem: output_ptr := NULL;
    variable setup: boolean := true;
    variable old_bin_chan_num: std_logic_vector(chan_ind_width-1 downto 0) := (OTHERS => '0');
    variable bin_chan_num: std_logic_vector(chan_ind_width-1 downto 0) := (OTHERS => '0');
    variable head_latency, local_latency: integer;
    
    procedure add_element_to_list(result: std_logic_vector(result_width-1 downto 0);
                                  mid_result: std_logic_vector(data_width-1 downto 0);
                                  channel_number, cycles_left: integer;
                                  variable list_head: inout output_ptr) IS
      variable elem: output_ptr;
    begin
      elem := NEW output_record;
      elem.result := result;
      elem.mid_result := mid_result;
      elem.channel_number := channel_number;
      elem.cycles_left := cycles_left;
      elem.nxt := list_head;
      list_head := elem;
    end add_element_to_list;
    
    procedure make_list_elements_unknown(variable list_head: output_ptr) IS
      variable elem: output_ptr := list_head;
    begin
     while (elem /= NULL) loop
        elem.result := (OTHERS => 'X');
        elem.mid_result := (OTHERS => 'X');
        elem := elem.nxt;
      end loop;
    end make_list_elements_unknown;
    
    procedure decrement_cycles_left(variable list_head: inout output_ptr;
                                    variable ret_elem: out output_ptr) IS
      variable prv_elem: output_ptr := NULL;
      variable elem: output_ptr := list_head;
    BEGIN
      ret_elem := NULL;
      while (elem /= NULL) loop
        elem.cycles_left := elem.cycles_left-1;
        if (elem.cycles_left = 0) then
          ret_elem := elem;
          elem := prv_elem;  -- the deallocated elem will always be the last element in the list
          if (elem = NULL) then
            list_head := NULL;
          else
            elem.nxt := NULL;
            elem := elem.nxt;
          end if;
        else
          prv_elem := elem;
          elem := elem.nxt;
        end if;
      end loop;
    end decrement_cycles_left;
    
    procedure remove_all_elements_from_list(variable list_head: inout output_ptr) IS
      variable next_elem: output_ptr := NULL;
    begin
      while (list_head /= NULL) loop
        next_elem := list_head;
        list_head := list_head.nxt;
        deallocate(next_elem);
      end loop;
    end remove_all_elements_from_list;
    
    procedure get_head_latency(variable list_head: in output_ptr;
                               variable head_latency: out integer) is
    begin
      if (list_head = NULL) then
        head_latency := 0;
      else
        head_latency := list_head.cycles_left;
      end if;
    end get_head_latency;
    
  BEGIN
    if (setup = TRUE) then
        -- initialize everything
        rdy <= '0';
        if (has_out_chan_indicator) then
                sel_o <= (OTHERS => '0');
        end if;
        if (has_registered_output) then
            if (hilbert_transform) then
                dout_q <= (OTHERS => '0');
                dout_i <= (OTHERS => '0');
            else
                dout <= (OTHERS => '0');
            end if;
        end if;
        setup := false;
    -- handle an unknown clock state
    elsif ( clk'event AND (rat(clk) = 'X') AND (rat(clk'LAST_VALUE)/='X') ) then
        make_list_elements_unknown(list_head);
    elsif (clk'event AND rat(clk) = '1' and rat(clk'last_value)='0') then
        decrement_cycles_left(list_head, elem);
        if (elem /= NULL) then
            if (has_out_chan_indicator) then
                bin_chan_num := int_2_std_logic_vector((elem.channel_number+1)MOD number_of_channels, chan_ind_width);
            end if;
            if (coef_ld = '0') then
                if (hilbert_transform) then
                    dout_i <= elem.mid_result AFTER 0 ns;
                    dout_q <= elem.result AFTER 0 ns;
                else
                    dout <= elem.result AFTER 0 ns;
                end if;
                rdy <= '1' AFTER 0 ns;
            end if;
            deallocate(elem);
        else
            rdy <= '0' AFTER 0 ns;
            if (NOT has_registered_output) then
                if (hilbert_transform) then
                    dout_q <= (OTHERS => 'X') AFTER 0 ns;
                    dout_i <= (OTHERS => 'X') AFTER 0 ns;
                else
                    dout <= (OTHERS => 'X') AFTER 0 ns;
                end if;
            end if;
        end if;
        if (has_out_chan_indicator) then
            sel_o <= old_bin_chan_num AFTER 0 ns;
            old_bin_chan_num := bin_chan_num;
        end if;
    elsif (result_ready'event AND result_ready = '1') then
        get_head_latency(list_head, head_latency);
        if (head_latency >= latency) then
            local_latency := head_latency+1;
        else
            local_latency := latency;
        end if;
        add_element_to_list(result, mid_value, channel_number, local_latency, list_head);
        processed_result <= '1';
        WAIT FOR 0 ns;
        processed_result <= '0';
    end if;
    
    if (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset) then
        -- Have reset
        remove_all_elements_from_list(list_head);
        if (NOT has_registered_output) then
            if (hilbert_transform) then
                dout_q <= (OTHERS => 'X');
                dout_i <= (OTHERS => 'X');
            else
                dout <= (OTHERS => 'X');
            end if;
        else
            if (hilbert_transform) then
                dout_q <= (OTHERS => '0');
                dout_i <= (OTHERS => '0');
            else
                dout <= (OTHERS => '0');
            end if;
        end if;
        
        rdy <= '0';
        if (has_out_chan_indicator) then
            sel_o <= (OTHERS => '0');
            bin_chan_num := (OTHERS => '0');
            old_bin_chan_num := (OTHERS => '0');
        end if;
        
    end if;
    
    if ( reloading'event AND reloading = '1' ) then
        -- Have a reload operation
        remove_all_elements_from_list(list_head);
        if (NOT has_registered_output) then
            if (hilbert_transform) then
                dout_q <= (OTHERS => 'X');
                dout_i <= (OTHERS => 'X');
            else
                dout <= (OTHERS => 'X');
            end if;
        else
            if (hilbert_transform) then
                dout_q <= (OTHERS => '0');
                dout_i <= (OTHERS => '0');
            else
                dout <= (OTHERS => '0');
            end if;
        end if;
        
        rdy <= '0';
        if (has_out_chan_indicator) then
            sel_o <= (OTHERS => '0');
            bin_chan_num := (OTHERS => '0');
            old_bin_chan_num := (OTHERS => '0');
        end if;
        
        if (reloading = '1') then
            WAIT UNTIL ((reloading = '0') OR (clk'event AND rat(clk)='1' AND rat(clk'last_value)='0' AND rst='1' AND has_reset));
        end if;
    end if;
    
    WAIT ON clk, result_ready, reloading;
  end process;
  
END behavioral;

