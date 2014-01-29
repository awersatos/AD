library ieee;
use ieee.std_logic_1164.all;


package c_addsub_v10_0_comp is

-- core_if on component c_addsub_v10_0
  component c_addsub_v10_0
    GENERIC (
      C_VERBOSITY           : integer := 0;
      C_XDEVICEFAMILY       : string  := "no_family";
      C_IMPLEMENTATION      : integer := 0;
      C_A_WIDTH             : integer := 15;
      C_B_WIDTH             : integer := 15;
      C_OUT_WIDTH           : integer := 16;
      C_CE_OVERRIDES_SCLR   : integer := 0;            -- replaces c_sync_enable
      C_A_TYPE              : integer := 0;
      C_B_TYPE              : integer := 0;
      C_LATENCY             : integer := 1;
      C_ADD_MODE            : integer := 0;
      C_B_CONSTANT          : integer := 0;
      C_B_VALUE             : string  := "";
      C_AINIT_VAL           : string  := "";
      C_SINIT_VAL           : string  := "";
      C_CE_OVERRIDES_BYPASS : integer := 0;            -- replaces c_bypass_enable
      C_BYPASS_LOW          : integer := 0;
      C_SCLR_OVERRIDES_SSET : integer := 0;            -- replaces c_sync_priority
      C_HAS_C_IN            : integer := 0;
      C_HAS_C_OUT           : integer := 0;            -- may be registered in step with c_latency
      C_BORROW_LOW          : integer := 1;            -- only applies to implementation = 1
 --     C_HAS_OVFL            : integer := 0;            -- may be registered in step with c_latency
      C_HAS_CE              : integer := 0;
      C_HAS_BYPASS          : integer := 0;
      C_HAS_SCLR            : integer := 0;
      C_HAS_SSET            : integer := 0;
      C_HAS_SINIT           : integer := 0
      );
    PORT (
      A      : in  std_logic_vector(C_A_WIDTH-1 downto 0)     := (others => '0');
      B      : in  std_logic_vector(C_B_WIDTH-1 downto 0)     := (others => '0');
      CLK    : in  std_logic                                  := '0';
      ADD    : in  std_logic                                  := '0';
      C_IN   : in  std_logic                                  := '0';
      CE     : in  std_logic                                  := '1';
      BYPASS : in  std_logic                                  := '0';
      SCLR   : in  std_logic                                  := '0';
      SSET   : in  std_logic                                  := '0';
      SINIT  : in  std_logic                                  := '0';
--      OVFL   : out std_logic                                  := '0';
      C_OUT  : out std_logic                                  := '0';
      S      : out std_logic_vector(C_OUT_WIDTH - 1 downto 0) := (others => '0')
      );
    --core_if off
  end component;
  -- The following tells XST that c_addsub_v10_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  attribute box_type                           : string;
  attribute generator_default                  : string;
  attribute box_type of c_addsub_v10_0          : component is "black_box";
  attribute generator_default of c_addsub_v10_0 : component is "generatecore com.xilinx.ip.c_addsub_v10_0.c_addsub_v10_0";
  -- xcc include

end c_addsub_v10_0_comp;
