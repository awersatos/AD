LIBRARY ieee;
use ieee.std_logic_1164.all;

LIBRARY XilinxCoreLib;
use XilinxCoreLib.ul_utils.all;

PACKAGE bit_correlator_comps is

COMPONENT C_BIT_CORRELATOR_V3_0

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
       c_reload           : INTEGER; -- not supported in version 3
       c_reload_delay     : INTEGER; -- not supported in version 3
       c_reload_mem_type  : INTEGER; -- not supported in version 3
       c_enable_rlocs     : INTEGER  -- not needed for model
       );

  PORT(
      din        : in    std_logic_vector((c_data_width -1) downto 0);
      dout       : out   std_logic_vector((bitsNeededToRepresent(c_taps) - 1) downto 0) := (others => '0');
      nd         : in     std_logic;
      rfd        : out   std_logic := '1';
      rdy        : out   std_logic := '0';
      sel_i      : out   std_logic_vector((bitsNeededToRepresent(c_channels - 1) -1) downto 0) := (others => 'X');
      sel_o      : out   std_logic_vector((bitsNeededToRepresent(c_channels - 1) -1) downto 0) := (others => 'X');
      ld_din     : in    std_logic := '0'; -- not supported in version 3
      ld_we      : in    std_logic := '0'; -- not supported in version 3
      coef_ld    : in    std_logic := '0'; -- not supported in version 3
      clk        : in    std_logic
      );
END COMPONENT;

END bit_correlator_comps;
