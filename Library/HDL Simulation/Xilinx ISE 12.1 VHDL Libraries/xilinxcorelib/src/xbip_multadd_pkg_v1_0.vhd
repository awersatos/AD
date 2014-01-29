library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;

library xilinxcorelib;
use xilinxcorelib.mult_gen_pkg_v10_1.all;

package xbip_multadd_pkg_v1_0 is

  -- Min. possible width for the multadd
  -- This will actually be 2 for signed data
  constant MULTADD_MIN_WIDTH : integer := 1;

  -- Max. possible width for the mult operands (A and B)
  -- This will actually be 54 for unsigned data
  constant MULTADD_MAX_MULT_IN_WIDTH : integer := 53;

  -- Max. possible width for the addition operand (C)
  constant MULTADD_MAX_ADD_IN_WIDTH : integer := 106;
  
  -- Max. supported latency for the multadd
  constant MULTADD_MAX_LATENCY : integer := 16;

  -- Min. supported output MSB for the multadd
  constant MULTADD_MIN_OUT_HIGH : integer := 0;

  -- Max. supported output MSB for the multadd
  constant MULTADD_MAX_OUT_HIGH : integer := 106;

  -- Record to store the latency of of the inputs to output port
  type LATENCY_REC is record
    ab_latency : integer;
    c_latency : integer;
  end record LATENCY_REC;
  
  type T_RESOLVABLE_GENERICS is record
    R_VERBOSITY         : integer;
  end record T_RESOLVABLE_GENERICS;

  function check_generics(C_VERBOSITY     : integer;
                          C_XDEVICEFAMILY : string;
                          C_A_WIDTH,
                          C_B_WIDTH,
                          C_C_WIDTH,
                          C_DATA_TYPE,
                          C_CE_OVERRIDES_SCLR,
                          C_AB_LATENCY,
                          C_C_LATENCY,
                          C_OUT_HIGH,
                          C_OUT_LOW,
                          C_USE_PCIN : integer) return T_RESOLVABLE_GENERICS;

  -- Returns a 0 if 1 DSP48 can be used: A port connects to A of DSP and B port connects to B of DSP
  -- Returns a 1 if 1 DSP48 can be used: A port connects to B of DSP and B port connects to A of DSP
  -- Returns a 2 if more than 1 DSP required.
  function resolve_dsp48_multadd_use (a_width, b_width, c_width, c_data_type : integer;
                                      c_xdevicefamily : string) return integer;

  -- If any latencies are specified as -1, return both as -1
  function resolve_latencies (ab_latency, c_latency : integer) return LATENCY_REC;

  function resolve_combined_multadd (c_width, c_data_type : integer) return boolean;

  function calc_multadd_latencies (a_width, b_width, c_width, c_data_type, ab_latency, c_latency, c_use_pcin: integer;
                                   xdevicefamily : string) return LATENCY_REC;

  function calc_dsps_required_for_add(xdevicefamily : string; a, b, data_type : integer) return integer;

  component addsub_dsp is
    generic (
      C_VERBOSITY      : integer := 0;
      C_XDEVICEFAMILY  : string  := "NO_FAMILY";
      C_MULT_OUT_WIDTH : integer := 16;
      C_C_WIDTH        : integer := 16;
      C_DATA_TYPE      : integer := 0;
      C_LATENCY        : integer := 1
      );
    port (
      CLK      : in  std_logic                                     := '0';
      CE       : in  std_logic                                     := '0';
      SCLR     : in  std_logic                                     := '0';
      MULT_OUT : in  std_logic_vector(C_MULT_OUT_WIDTH-1 downto 0) := (others => '0');
      C        : in  std_logic_vector(C_C_WIDTH-1 downto 0)        := (others => '0');
      SUBTRACT : in  std_logic                                     := '0';
      P        : out std_logic_vector(get_max(C_MULT_OUT_WIDTH,C_C_WIDTH) downto 0)  --one bit of growth
      );  
  end component;

component multadd_dsp is
  generic (
    C_VERBOSITY         : integer := 0;
    C_XDEVICEFAMILY     : string  := "NO_FAMILY";
    C_A_WIDTH           : integer := 16;
    C_B_WIDTH           : integer := 16;
    C_C_WIDTH           : integer := 32;
    C_DATA_TYPE         : integer := 0;
    C_CE_OVERRIDES_SCLR : integer := 0;
    C_AB_LATENCY        : integer := -1;
    C_C_LATENCY         : integer := -1;
    C_OUT_HIGH          : integer := 32;
    C_OUT_LOW           : integer := 0;
    C_USE_PCIN          : integer := 0
    );
  port (
    CLK      : in  std_logic                                     := '0';
    CE       : in  std_logic                                     := '0';
    SCLR     : in  std_logic                                     := '0';
    A        : in  std_logic_vector(C_A_WIDTH-1 downto 0)        := (others => '0');
    B        : in  std_logic_vector(C_B_WIDTH-1 downto 0)        := (others => '0');
    C        : in  std_logic_vector(C_C_WIDTH-1 downto 0)        := (others => '0');
    PCIN     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
    SUBTRACT : in  std_logic                                     := '0';
    P        : out std_logic_vector(C_OUT_HIGH downto C_OUT_LOW) := (others => '0');
    PCOUT    : out  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0')
    );  
end component;

end package xbip_multadd_pkg_v1_0;

package body xbip_multadd_pkg_v1_0 is

  function check_generics(C_VERBOSITY     : integer;
                          C_XDEVICEFAMILY : string;
                          C_A_WIDTH,
                          C_B_WIDTH,
                          C_C_WIDTH,
                          C_DATA_TYPE,
                          C_CE_OVERRIDES_SCLR,
                          C_AB_LATENCY,
                          C_C_LATENCY,
                          C_OUT_HIGH,
                          C_OUT_LOW,
                          C_USE_PCIN : integer) return T_RESOLVABLE_GENERICS is

    variable res : T_RESOLVABLE_GENERICS := (R_VERBOSITY         => C_VERBOSITY);
  begin

    if C_VERBOSITY /= 0 and C_VERBOSITY /= 1 and C_VERBOSITY /= 2 then
      report "WARNING: xbip_multadd: C_VERBOSITY valid range is 0 to 2.  Setting to 2.  Current value is " & integer'image(C_VERBOSITY) severity warning;
      res.R_VERBOSITY := 2;
    end if;

    assert C_XDEVICEFAMILY /= "NO_FAMILY" report "ERROR: xbip_multadd: C_XDEVICEFAMILY has not been correctly set (perhaps by CORE Generator)" severity error;

    -- Check datatype first as we'll use it elsewhere
    if C_DATA_TYPE /= 0 and C_DATA_TYPE /= 1 then
      report "ERROR: xbip_multadd: C_DATA_TYPE valid range is 0 to 1.  Current value is " & integer'image(C_DATA_TYPE) severity error;
    end if;

    if (C_A_WIDTH+C_DATA_TYPE-1) < MULTADD_MIN_WIDTH or (C_A_WIDTH) > MULTADD_MAX_MULT_IN_WIDTH then
      report "ERROR: xbip_multadd: C_A_WIDTH valid range is " & integer'image(MULTADD_MIN_WIDTH+boolean'pos(C_DATA_TYPE = 1)) & " to " & integer'image(MULTADD_MAX_MULT_IN_WIDTH) & " with C_DATA_TYPE set to " & integer'image(C_DATA_TYPE) & ". Current value is " & integer'image(C_A_WIDTH) severity error;
    end if;

    if (C_B_WIDTH+C_DATA_TYPE-1) < MULTADD_MIN_WIDTH or (C_B_WIDTH) > MULTADD_MAX_MULT_IN_WIDTH then
      report "ERROR: xbip_multadd: C_B_WIDTH valid range is " & integer'image(MULTADD_MIN_WIDTH+boolean'pos(C_DATA_TYPE = 1)) & " to " & integer'image(MULTADD_MAX_MULT_IN_WIDTH) & " with C_DATA_TYPE set to " & integer'image(C_DATA_TYPE) & ". Current value is " & integer'image(C_B_WIDTH) severity error;
    end if;

    if (C_C_WIDTH+C_DATA_TYPE-1) < MULTADD_MIN_WIDTH or (C_C_WIDTH) > MULTADD_MAX_ADD_IN_WIDTH then
      report "ERROR: xbip_multadd: C_C_WIDTH valid range is " & integer'image(MULTADD_MIN_WIDTH+boolean'pos(C_DATA_TYPE = 1)) & " to " & integer'image(MULTADD_MAX_ADD_IN_WIDTH) & " with C_DATA_TYPE set to " & integer'image(C_DATA_TYPE) & ". Current value is " & integer'image(C_C_WIDTH) severity error;
    end if;

    if C_CE_OVERRIDES_SCLR /= 0 and C_CE_OVERRIDES_SCLR /= 1 then
      report "ERROR: xbip_multadd C_CE_OVERRIDES_SCLR valid range is 0 to 1.  Current value is " & integer'image(C_CE_OVERRIDES_SCLR) severity error;
    end if;

    if C_AB_LATENCY < -1 or C_AB_LATENCY > MULTADD_MAX_LATENCY then
      report "ERROR: xbip_multadd: C_AB_LATENCY valid range is 0 to " & integer'image(MULTADD_MAX_LATENCY) & ".  Current value is " & integer'image(C_AB_LATENCY) severity error;
    end if;

    if C_C_LATENCY < -1 or C_C_LATENCY > MULTADD_MAX_LATENCY then
      report "ERROR: xbip_multadd: C_C_LATENCY valid range is 0 to " & integer'image(MULTADD_MAX_LATENCY) & ".  Current value is " & integer'image(C_C_LATENCY) severity error;
    end if;

    if C_AB_LATENCY > 0 and C_C_LATENCY <= C_AB_LATENCY then
      report "ERROR: xbip_multadd: C_C_LATENCY must be less than or equal to C_AB_LATENCY.  Current value of C_C_LATENCY is " & integer'image(C_C_LATENCY) & ".  Current value of C_AB_LATENCY is " & integer'image(C_AB_LATENCY) severity error;
    end if;

    if C_OUT_HIGH > MULTADD_MAX_OUT_HIGH then
      report "ERROR: xbip_multadd: C_OUT_HIGH valid range is " & integer'image(MULTADD_MIN_OUT_HIGH) & " to " & integer'image(MULTADD_MAX_OUT_HIGH) & ". Current value is " & integer'image(C_OUT_HIGH) severity error;
    end if;

    if C_OUT_LOW < 0 then
      report "ERROR: xbip_multadd: C_OUT_LOW valid range is 0 to " & integer'image(MULTADD_MAX_OUT_HIGH) & ". Current value is " & integer'image(C_OUT_LOW) severity error;
    end if;

    return res;
  end function check_generics;

  function resolve_dsp48_multadd_use (a_width, b_width, c_width, c_data_type : integer;
                                      C_XDEVICEFAMILY : string) return integer is
  begin
    if ((c_width+c_data_type <= ci_dsp48_c_width) AND (a_width+c_data_type <= fn_dsp48_amult_width(C_XDEVICEFAMILY)) and (b_width+c_data_type <= ci_dsp48_b_width)) then
      return 0;  -- use dsp48_multadd a->a, b->b
    elsif ((c_width+c_data_type <= ci_dsp48_c_width) AND (b_width+c_data_type <= fn_dsp48_amult_width(C_XDEVICEFAMILY)) and (a_width+c_data_type <= ci_dsp48_b_width)) then
      return 1;  -- use dsp48_multadd a->b, b->a
    else
      return 2;
    end if;
  end function resolve_dsp48_multadd_use;

  function resolve_latencies (ab_latency, c_latency : integer) return LATENCY_REC is
    variable latency_ret : LATENCY_REC := (ab_latency => -1, c_latency => -1);
  begin
    if (ab_latency = -1 or c_latency = -1) then
      return latency_ret;
    else
      latency_ret.ab_latency := ab_latency;
      latency_ret.c_latency := c_latency;
      return latency_ret;
    end if;
  end function resolve_latencies;

  -- purpose: Works out if we can implement a combined multadd structur
  function resolve_combined_multadd (c_width, c_data_type : integer) return boolean is
  begin  -- function resolve_combined_multadd
    -- we limit the combined mult_add to addwidths of 1 bit less than full width (signed limit is 47, unsigned limit is 46).
    -- This is done because in the combined multadd case, when the product width of A*B is greater than the width of C, the C width is not extended up to the A*B width.
    -- If the value of C is the max positive number the the product of A*B is 1, the addition of 1 +C causes us to roll-over to the max negative number.  (Wayne-See emails to
    -- Andrew dated 3/3/08).
    if c_width <= ci_dsp48_c_width-c_data_type-1 then
      return true;
    else
      return false;
    end if;
  end function resolve_combined_multadd;


  function calc_multadd_latencies (a_width, b_width, c_width, c_data_type, ab_latency, c_latency, c_use_pcin: integer;
                                   xdevicefamily : string) return LATENCY_REC is
    variable latency_ret : LATENCY_REC := (ab_latency => -1, c_latency => -1);
    variable usecase_used : integer := resolve_dsp48_multadd_use(a_width, b_width, c_width, c_data_type, xdevicefamily);
    variable combined_multadd : boolean := resolve_combined_multadd(c_width,c_data_type);
    variable mult_latency : integer := 0;
    variable addsub_dsp_latency : integer := 0;
    constant number_of_dsps_for_add : integer := calc_dsps_required_for_add(xdevicefamily,a_width+b_width,c_width,c_data_type); 
  begin
    if ab_latency=0 and c_latency=0 then
      latency_ret.ab_latency := 0;
      latency_ret.c_latency := 0;
    elsif ab_latency=-1 or c_latency=-1 then  -- calculate the optimum latency
      if (usecase_used < 2) then 
	if (c_use_pcin=1) then
          latency_ret.ab_latency := 3;
          latency_ret.c_latency := 1;
	else
          latency_ret.ab_latency := 3;
          latency_ret.c_latency := 2;
	end if;
      else -- more than 1 dsp required for implementation
        mult_latency := calc_fully_pipelined_latency(XDEVICEFAMILY,
                                                        A_WIDTH,
                                                        C_DATA_TYPE,
                                                        B_WIDTH,
                                                        C_DATA_TYPE,
                                                        1, --EMBEDDED_MULT,
                                                        1, --CORE_SPEED,
                                                        2, --C_CCM_IMP,
                                                        "1111111");
	if combined_multadd then
          latency_ret.ab_latency := mult_latency; 
          latency_ret.c_latency := mult_latency-1;
	else
          if number_of_dsps_for_add = 1 then
            addsub_dsp_latency := 2;
          elsif number_of_dsps_for_add = 2 then
	    --W if has_dsp48(xdevicefamily) then
	    if has_dsp48(xdevicefamily) or has_dsp48a(xdevicefamily) then
              addsub_dsp_latency := 4;
	    --W elsif has_dsp48a(xdevicefamily) or has_dsp48e(xdevicefamily) then
	    elsif has_dsp48e(xdevicefamily) then
              addsub_dsp_latency := 3;
	    else
              addsub_dsp_latency := 0;
	    end if;
          elsif number_of_dsps_for_add = 3 then
	    --W if has_dsp48(xdevicefamily) then
	    if has_dsp48(xdevicefamily) or has_dsp48a(xdevicefamily) then
              addsub_dsp_latency := 6;
	    --W elsif has_dsp48a(xdevicefamily) or has_dsp48e(xdevicefamily) then
	    elsif has_dsp48e(xdevicefamily) then
              addsub_dsp_latency := 4;
	    else
              addsub_dsp_latency := 0;
	    end if;
          else
            addsub_dsp_latency := 0;
          end if;
          latency_ret.ab_latency := mult_latency+addsub_dsp_latency; 
          latency_ret.c_latency := addsub_dsp_latency;
	end if;
      end if;
    else -- latency is explicitly specified
      latency_ret.ab_latency := ab_latency;
      latency_ret.c_latency := c_latency;
    end if;
    return latency_ret;
  end function calc_multadd_latencies;

  -- purpose: Works out the number of DSPs that are required to build the specified addsub
  function calc_dsps_required_for_add(xdevicefamily : string; a, b, data_type : integer) return integer is
    constant true_a_width : integer := a + data_type;
    constant true_b_width : integer := b + data_type;
    constant max_width    : integer := get_max(true_a_width, true_b_width)+1;
    variable dsps         : integer := 0;
  begin  -- function calc_dsps_required
    if has_dsp48e(xdevicefamily) then
      if max_width <= 48 then
        -- We can use the carry-out to fabric in the DSP48E
        -- to perform 48-bit 2-input adds
        dsps := 1;
      elsif max_width <= 96 then
        dsps := 2;
      else
        -- max. 142 bits
        dsps := 3;
      end if;
    elsif has_dsp48a(xdevicefamily) then
      if max_width <= 47 then
        -- There's no carry-out from the DSP48A to the fabric
        -- Limited to 47-bit 2-input adds (use the 48th bit for the bit growth)
      --W if max_width <= 48 then
	-- Use carry cascade
        dsps := 1;
      elsif max_width <= 95 then
      --W elsif max_width <= 95 then
        dsps := 2;
      else
        -- max. 141 bits
        --W -- max. 142 bits
        dsps := 3;
      end if;
    elsif has_dsp48(xdevicefamily) then
      -- This clause might be triggered if we are
      -- in Virtex-5, so we put it last
      -- There's no carry-out in the DSP48, but the A:B input is limited to 36
      -- bits, so we are limited to 36-bit 2-input adds (just use the MSB as
      -- for the bit growth)
      if max_width <= 36 then
        dsps := 1;
      elsif max_width <= 71 then
        dsps := 2;
      else
        -- max. 107 bits
        dsps := 3;
      end if;
    else
      assert false report "ERROR: xbip_multadd: Invalid family " & xdevicefamily & " caught in addsub_dsp" severity error;
    end if;
    return dsps;
  end function calc_dsps_required_for_add;


end package body xbip_multadd_pkg_v1_0;
