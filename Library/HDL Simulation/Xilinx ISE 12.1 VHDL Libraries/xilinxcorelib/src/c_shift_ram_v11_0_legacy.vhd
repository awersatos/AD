
--------------------------------------------------------------------------------
--  (c) Copyright 1995-2006, 2009 Xilinx, Inc. All rights reserved.
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
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.c_reg_fd_v11_0_comp.all;
use xilinxcorelib.c_shift_ram_v11_0_pkg.all;

entity c_shift_ram_v11_0_legacy is
  generic (
    c_xdevicefamily      : string  := "virtex2";
    c_verbosity          : integer := 0;
    c_width              : integer := 16;  -- Default is 16
    c_depth              : integer := 16;  -- Delay line depth (default = 16 = 1x SRL16/SRL32) 
    c_addr_width         : integer := 4;  -- Dependent on c_width value specified
    c_shift_type         : integer := 0;  -- 0=fixed, 1=lossless
    c_opt_goal           : integer := 0;  -- 0=area, 1=speed
    c_ainit_val          : string  := "0000000000000000";  -- Applies only to registered output
    c_sinit_val          : string  := "0000000000000000";  -- Applies only to registered output    
    c_default_data       : string  := "0000000000000000";  -- If no (MIF) init details, use this val
    c_default_data_radix : integer := 1;  -- 0=no init values, 1=hex ,2=bin, 3=dec
    c_has_a              : integer := 0;  -- Address bus only exists for var length
    c_has_ce             : integer := 0;
    c_reg_last_bit       : integer := 1;  -- Register last output bit (with FF)
    c_sync_priority      : integer := 1;  -- Applies only to registered output
    c_sync_enable        : integer := 0;  -- Applies only to registered output
    c_has_aclr           : integer := 0;  -- Applies only to registered output    
    c_has_aset           : integer := 0;  -- Applies only to registered output
    c_has_ainit          : integer := 0;  -- Applies only to registered output    
    c_has_sclr           : integer := 0;  -- Applies only to registered output
    c_has_sset           : integer := 0;  -- Applies only to registered output
    c_has_sinit          : integer := 0;  -- Applies only to registered output
    c_mem_init_file      : string  := "init.mif";
    c_elaboration_dir    : string  := "./";
    c_mem_init_radix     : integer := 1;  -- for backwards compatibility
    c_generate_mif       : integer := 0;  -- Unused by the behavioural model    
    c_read_mif           : integer := 0;  -- Redundant in VHDL core
    c_enable_rlocs       : integer := 0  -- Not used with VHDL core
    );

  port (
    a     : in  std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
    d     : in  std_logic_vector(c_width-1 downto 0)      := (others => '0');
    clk   : in  std_logic                                 := '0';
    ce    : in  std_logic                                 := '1';
    aclr  : in  std_logic                                 := '0';
    aset  : in  std_logic                                 := '0';
    ainit : in  std_logic                                 := '0';
    sclr  : in  std_logic                                 := '0';
    sset  : in  std_logic                                 := '0';
    sinit : in  std_logic                                 := '0';
    q     : out std_logic_vector(c_width-1 downto 0)
    );
end c_shift_ram_v11_0_legacy;
--
-- behavior describing a parameterized ram based shift register
--
architecture behavioral of c_shift_ram_v11_0_legacy is

  constant timeunit : time := 100 ps;
  signal   Qint     : std_logic_vector(c_width-1 downto 0);


  -- purpose: converts an SLV to a string with range 1 to N
  function std_logic_vector_to_string (slv : std_logic_vector) return string is
    variable ret                           : string(1 to slv'high-slv'low+1);
    variable y                             : integer := 1;
  begin  -- FUNCTION std_logic_vector_to_string

    -- account for the fact that the input SLV may be in either range direction
    if slv'ascending then
      for i in slv'left to slv'right loop
        if slv(i) = '1' then
          ret(y) := '1';
        elsif (slv(i) = 'X') then
          ret(y) := 'X';
        elsif (slv(i) = 'Z') then
          ret(y) := 'Z';
        elsif (slv(i) = 'U') then
          ret(y) := 'U';
        elsif (slv(i) = '0') then
          ret(y) := '0';
        else
          report "Unknown CHARACTER - setting to '0'" severity warning;
          ret(y) := '0';
        end if;
        y        := y+1;
      end loop;
    else
      for i in slv'left downto slv'right loop
        if slv(i) = '1' then
          ret(y) := '1';
        elsif (slv(i) = 'X') then
          ret(y) := 'X';
        elsif (slv(i) = 'Z') then
          ret(y) := 'Z';
        elsif (slv(i) = 'U') then
          ret(y) := 'U';
        elsif (slv(i) = '0') then
          ret(y) := '0';
        else
          report "Unknown CHARACTER - setting to '0'" severity warning;
          ret(y) := '0';
        end if;
        y        := y+1;
      end loop;
    end if;

    return ret;
  end function std_logic_vector_to_string;

  constant ci_shift_type : integer := c_shift_type;

  constant srl_depth : integer := fn_get_srl_depth(c_xdevicefamily);


-- Verify that the generics are valid and will be supported by the
-- synthesizable model as well
  constant verify_generics : integer range 0 to 0 := fn_c_shift_ram_v11_0_check_generics(c_verbosity, c_width, c_depth, c_has_a, c_addr_width, c_opt_goal, ci_shift_type, c_reg_last_bit, c_generate_mif,
                                                                                         c_has_ainit, c_has_aclr, c_has_aset, c_has_sinit, c_has_sclr, c_has_sset, c_has_ce, c_sync_priority, c_sync_enable, c_read_mif,
                                                                                         srl_depth,
                                                                                         c_default_data, c_xdevicefamily);

  signal shift_out : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');

  type T_PIPE_SIGNAL is array (0 to C_DEPTH) of std_logic_vector(C_WIDTH-1 downto 0);

  signal intA    : std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0');
  signal init    : T_PIPE_SIGNAL                             := (others => (others => '0'));
  signal initclr : T_PIPE_SIGNAL                             := (others => (others => '0'));
  signal int_ce  : std_logic                                 := '0';
  signal pipe1   : std_logic_vector(c_width-1 downto 0);
  signal pipe2   : std_logic_vector(c_width-1 downto 0);

  -- Use utility function str_to_bound_slv_0 to convert the init values to std_logic_vectors
  constant ainit_val : std_logic_vector(c_width-1 downto 0) := str_to_bound_slv_0(c_ainit_val, c_width);
  constant sinit_val : std_logic_vector(c_width-1 downto 0) := str_to_bound_slv_0(c_sinit_val, c_width);

-- purpose: determines if any 'X's are present in the supplied vector
  function anyX(vect : std_logic_vector)
    return boolean is
  begin
    for i in vect'range loop
      if (rat(vect(i)) = 'X') then
        return true;
      end if;
    end loop;
    return false;
  end anyX;

-------------------------------------------------------------------------------
-- new functions as used in the synth model to read in a mif file
-------------------------------------------------------------------------------

  type T_MEM_INIT_ARRAY is array (0 to c_width-1, 0 to fn_get_real_depth(c_depth, c_reg_last_bit, ci_shift_type, srl_depth)-1) of std_logic;

  function get_default_data (def_data : string; width : integer) return std_logic_vector is
    variable dd                       : string(1 to width);
    variable ret_slv                  : std_logic_vector(width-1 downto 0) := (others => '0');
  begin  -- FUNCTION get_default_data
    if def_data'length > width then
      dd(1 to width)                                                       := def_data(1 to width);
    else
      dd(1 to def_data'length)                                             := def_data;
    end if;

    for i in 1 to width loop
      case dd(i) is
        when '0'    =>
          ret_slv(width-i) := '0';
        when '1'    =>
          ret_slv(width-i) := '1';
        when others =>
          assert false
            report "WARNING : c_shift_ram_v11_0_legacy : Filling unspecified c_default_data locations with zeros up to MSB"
            severity warning;
          ret_slv(width-i) := '0';
      end case;
    end loop;  -- i
    return ret_slv;
  end function get_default_data;

  function init_array(width, depth : integer; def_data : string) return T_MEM_INIT_ARRAY is
    variable filled_array          : T_MEM_INIT_ARRAY;
    constant default_data          : std_logic_vector(width-1 downto 0) := get_default_data(def_data, width);
  begin  -- FUNCTION init_array
    for i in 0 to width-1 loop
      for j in 0 to depth-1 loop
        filled_array(i, j)                                              := default_data(width-1-i);  -- coded this way to ensure left-most bit in default data string is the MSB (top bit) of the shift RAM
      end loop;  -- j
    end loop;  -- i
    return filled_array;
  end function init_array;

  impure function read_mif_data(read_mif, generate_mif, width, depth : integer; filename, elaboration_dir : string; default_data : string) return std_logic_vector is

    file initfile        : text;
    variable initline    : line;
    variable bits_good   : boolean          := true;
    variable ret_vec     : T_MEM_INIT_ARRAY := init_array(width, depth, default_data);
    variable bitchar     : character;
    variable bitline     : string (1 to width);
    variable mif_status  : file_open_status;
    constant pathandfile : string           := elaboration_dir & filename;
    constant offset      : integer          := width;
    variable ret_slv     : std_logic_vector((width*depth)-1 downto 0);
    variable output_vec  : T_MEM_INIT_ARRAY;

  begin  -- FUNCTION read_data

    if read_mif /= 0 then               -- if we don't want to use a mif file, don't try and read one      

      assert false report "NOTE : c_shift_ram_v11_0_legacy : Reading mif file..." severity note;

      FILE_OPEN(mif_status, initfile, pathandfile, read_mode);  -- access file only when c_read_mif = 1

      if mif_status /= open_ok then
        assert false
          report "ERROR : c_shift_ram_v11_0_legacy : Couldn't open memory initialization file"
          severity failure;
      end if;

      for lines in 0 to c_depth-1 loop
        if not(endfile(initfile)) then
          readline(initfile, initline);
	  -- This line is not needed; this was a fix for XST classic parse only
	  -- exit when endfile (initfile);  -- fix to avoid "Line <MY_LINE> has not enough elements for target- <MY_DATA>" error
          for i in 0 to width-1 loop
            read(initline, bitchar, bits_good);
            if ((bits_good = false) or ((bitchar /= ' ') and (bitchar /= CR) and (bitchar /= HT) and (bitchar /= LF) and (bitchar /= '0') and (bitchar /= '1') and (bitchar /= 'X') and (bitchar /= 'Z'))) then
              assert false
                report "WARNING   : c_shift_ram_v11_0_legacy : Unknown or illegal character encountered while reading MIF on line " & integer'image(lines+1) & " - finishing file read" & CR &
                "This could be due to an undersized MIF file"
                severity warning;
              exit;                     -- abort the file read
            end if;
            case bitchar is
              when '0'    => ret_vec(i, lines) := '0';
              when '1'    => ret_vec(i, lines) := '1';
              when others =>
                assert false
                  report "WARNING : c_shift_ram_v11_0_legacy : STD_LOGIC type other than '0' or '1' detected on LINE " & integer'image(lines+1) & " position " & integer'image(i) & " - writing '0' to this memory location"
                  severity warning;
                ret_vec(i, lines)              := '0';
            end case;
          end loop;  -- i

        end if;
      end loop;  -- lines          

      FILE_CLOSE(initfile);             -- explicitly close the file
      assert false report "NOTE : c_shift_ram_v11_0_legacy : File read complete" severity note;

    end if;  -- read_mif /= 0

    for deep in 0 to depth-1 loop
      for wide in 0 to width-1 loop
        ret_slv(wide+(deep*offset)) := ret_vec(((width-1)-wide), deep);
      end loop;  -- wide      
    end loop;  -- deep

    -- We return the array in all cases - if the mif file has been read, the
    -- array will have the data in it - if not, it will contain all zeros to
    -- initialise the SRL16s and the registers
    return ret_slv;

  end function read_mif_data;

  constant zeros : string(1 to c_width) := (others => '0');

begin

-------------------------------------------------------------------------------
-- internal ce generation
-------------------------------------------------------------------------------

  cegen1 : if (c_has_ce = 1) generate
    int_ce <= ce;
  end generate;

  cegen0 : if (c_has_ce = 0) generate
    int_ce <= '1';
  end generate;

-------------------------------------------------------------------------------
-- fixed-length behaviour
-------------------------------------------------------------------------------

  -- the fixed length version can be modelled simply with a
  -- pipeline of fds and a final output register if required
  fixed : if (ci_shift_type = c_fixed) generate

    reged                      : if c_reg_last_bit = 1 generate
      depth0                   : if c_depth = 0 generate
        qout21                 : c_reg_fd_v11_0
          generic map (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width)
          port map (d                  => d,
                    clk                => clk,
                    ce                 => ce,
                    aclr               => aclr,
                    aset               => aset,
                    ainit              => ainit,
                    sclr               => sclr,
                    sset               => sset,
                    sinit              => sinit,
                    q                  => qint);
      end generate depth0;
      depth1                   : if c_depth = 1 generate
        signal depth1_shiftout : std_logic_vector(c_width-1 downto 0);
      begin
        qout11                 : c_reg_fd_v11_0
          generic map (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width)
          port map (d                  => d,
                    clk                => clk,
                    ce                 => ce,
                    aclr               => aclr,
                    aset               => aset,
                    ainit              => ainit,
                    sclr               => sclr,
                    sset               => sset,
                    sinit              => sinit,
                    q                  => qint);
      end generate depth1;
      depth_gt_1               : if c_depth > 1 generate
        qout31                 : c_reg_fd_v11_0
          generic map (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width)
          port map (d                  => shift_out,
                    clk                => clk,
                    ce                 => ce,
                    aclr               => aclr,
                    aset               => aset,
                    ainit              => ainit,
                    sclr               => sclr,
                    sset               => sset,
                    sinit              => sinit,
                    q                  => qint);
      end generate depth_gt_1;
    end generate reged;

    unreg : if not(c_reg_last_bit = 1) and c_depth /= 0 generate
      qint <= shift_out;
    end generate;

    route_thru : if (c_depth = 0 and c_reg_last_bit = 0) generate
      qint <= d;
    end generate;

-- core memory process
    process (clk)
      type shifttype is array(0 to c_depth-1-c_reg_last_bit) of std_logic_vector(c_width-1 downto 0);
      variable shift     : shifttype;
      constant mem_bits  : integer := c_depth * c_width;
      variable memdvect  : std_logic_vector(mem_bits-1 downto 0);
      variable bits_good : boolean;
      variable lineno    : integer := 0;
      variable offset    : integer := 0;
      variable def_data  : std_logic_vector(c_width-1 downto 0);
      variable startup   : boolean := true;
    begin
      -- startup section reads mif file if necessary.          
      if (c_depth-c_reg_last_bit > 0) then
        if (startup) then

          -- call function in all cases - use to assign default data as well          
          memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, c_depth, c_mem_init_file, c_elaboration_dir, c_default_data);

          for i in 0 to c_depth -1-c_reg_last_bit loop
            for j in 0 to c_width-1 loop
              shift(i)(j) := memdvect(j + i*c_width);
            end loop;
          end loop;

          startup      := false;
        else                            -- not first
          if (clk'event and int_ce = '1' and clk'last_value = '0' and clk = '1') then  -- rising edge!
            for i in c_depth-1-c_reg_last_bit downto 1 loop
              shift(i) := shift(i-1);
            end loop;
            shift(0)   := d;
          elsif (clk'event and (int_ce = 'X' or (clk'last_value = '0' and clk = 'X') or (clk'last_value = 'X' and clk = '1'))) then
            for i in 0 to c_depth-1-c_reg_last_bit loop
              shift(i) := (others => 'X');
            end loop;
          end if;
          shift_out <= shift(c_depth-1-c_reg_last_bit);
        end if;
      end if;
    end process;
  end generate;

  a1 : if (c_has_a = 1) generate
    inta <= a;
  end generate;
  a0 : if (c_has_a = 0) generate
    inta <= std_logic_vector(to_unsigned(c_depth-1, c_addr_width));
  end generate;

-------------------------------------------------------------------------------
-- lossless behaviour
-------------------------------------------------------------------------------

  -- the lossless version is also fairly straight forward
  -- updated - 9th november 2004 - account for new pipelining option
  -- when c_opt_goal is set to 1 (speed optimisation)
  lossless    : if (ci_shift_type = c_variable_lossless) generate
    opt_area  : if (c_opt_goal = c_area) or (c_depth < srl_depth+1) generate  --OR (c_depth = srl_depth+1 AND c_reg_last_bit /= 0) GENERATE
      reged   : if (c_reg_last_bit /= 0) generate
        -- just an output register
        qout1 : c_reg_fd_v11_0
          generic map (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                       c_has_aclr      => c_has_aclr,
                       c_has_ainit     => c_has_ainit,
                       c_has_aset      => c_has_aset,
                       c_has_ce        => c_has_ce,
                       c_has_sclr      => c_has_sclr,
                       c_has_sinit     => c_has_sinit,
                       c_has_sset      => c_has_sset,
                       c_sinit_val     => std_logic_vector_to_string(sinit_val),
                       c_sync_enable   => c_sync_enable,
                       c_sync_priority => c_sync_priority,
                       c_width         => c_width)
          port map (d                  => shift_out,
                    clk                => clk,
                    ce                 => int_ce,
                    aclr               => aclr,
                    aset               => aset,
                    ainit              => ainit,
                    sclr               => sclr,
                    sset               => sset,
                    sinit              => sinit,
                    q                  => qint);
      end generate reged;
      unreg   : if c_reg_last_bit = 0 generate
        qint <= shift_out;
      end generate;
    end generate opt_area;

-- opt_speed : IF (c_opt_goal = c_speed) AND ((c_depth > srl_depth+1) OR (c_depth = srl_depth+1 AND c_reg_last_bit = 0)) GENERATE
    opt_speed   : if (c_opt_goal = c_speed) and (c_depth >= srl_depth+1) generate
      lat1      : if c_depth <= 8*srl_depth generate
        -- latency will be at least 1 cycle
        -- qout1 is a pipeline register, so gets limited controls
        qout1   : c_reg_fd_v11_0
          generic map (c_ainit_val       => std_logic_vector_to_string(fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit, ainit_val, sinit_val, c_width)),  --c_ainit_val,
                       c_has_aclr        => 0,
                       c_has_ainit       => 0,
                       c_has_aset        => 0,
                       c_has_ce          => c_has_ce,
                       c_has_sclr        => 0,
                       c_has_sinit       => 0,
                       c_has_sset        => 0,
                       c_sinit_val       => std_logic_vector_to_string(sinit_val),
                       c_sync_enable     => c_sync_enable,
                       c_sync_priority   => c_sync_priority,
                       c_width           => c_width)
          port map (d                    => shift_out,
                    clk                  => clk,
                    ce                   => int_ce,
                    aclr                 => '0',
                    aset                 => '0',
                    ainit                => '0',
                    sclr                 => '0',
                    sset                 => '0',
                    sinit                => '0',
                    q                    => pipe1);
        reged   : if (c_reg_last_bit /= 0) generate
          -- output register
          qout2 : c_reg_fd_v11_0
            generic map (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                         c_has_aclr      => c_has_aclr,
                         c_has_ainit     => c_has_ainit,
                         c_has_aset      => c_has_aset,
                         c_has_ce        => c_has_ce,
                         c_has_sclr      => c_has_sclr,
                         c_has_sinit     => c_has_sinit,
                         c_has_sset      => c_has_sset,
                         c_sinit_val     => std_logic_vector_to_string(sinit_val),
                         c_sync_enable   => c_sync_enable,
                         c_sync_priority => c_sync_priority,
                         c_width         => c_width)
            port map (d                  => pipe1,
                      clk                => clk,
                      ce                 => int_ce,
                      aclr               => aclr,
                      aset               => aset,
                      ainit              => ainit,
                      sclr               => sclr,
                      sset               => sset,
                      sinit              => sinit,
                      q                  => qint);
        end generate reged;
        unreg   : if c_reg_last_bit = 0 generate
          qint               <= pipe1;
        end generate;
      end generate lat1;
      lat2      : if c_depth > 8*srl_depth generate
        -- latency will be at least 2 cycles
        -- qout1 and qout2 are pipeline registers and get limited controls
        qout1   : c_reg_fd_v11_0
          generic map (c_ainit_val       => std_logic_vector_to_string(fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit, ainit_val, sinit_val, c_width)),  --c_ainit_val,
                       c_has_aclr        => 0,
                       c_has_ainit       => 0,
                       c_has_aset        => 0,
                       c_has_ce          => c_has_ce,
                       c_has_sclr        => 0,
                       c_has_sinit       => 0,
                       c_has_sset        => 0,
                       c_sinit_val       => std_logic_vector_to_string(sinit_val),
                       c_sync_enable     => c_sync_enable,
                       c_sync_priority   => c_sync_priority,
                       c_width           => c_width)
          port map (d                    => shift_out,
                    clk                  => clk,
                    ce                   => int_ce,
                    aclr                 => '0',
                    aset                 => '0',
                    ainit                => '0',
                    sclr                 => '0',
                    sset                 => '0',
                    sinit                => '0',
                    q                    => pipe1);
        qout2   : c_reg_fd_v11_0
          generic map (c_ainit_val       => std_logic_vector_to_string(fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit, ainit_val, sinit_val, c_width)),  --c_ainit_val,
                       c_has_aclr        => 0,
                       c_has_ainit       => 0,
                       c_has_aset        => 0,
                       c_has_ce          => c_has_ce,
                       c_has_sclr        => 0,
                       c_has_sinit       => 0,
                       c_has_sset        => 0,
                       c_sinit_val       => std_logic_vector_to_string(sinit_val),
                       c_sync_enable     => c_sync_enable,
                       c_sync_priority   => c_sync_priority,
                       c_width           => c_width)
          port map (d                    => pipe1,
                    clk                  => clk,
                    ce                   => int_ce,
                    aclr                 => '0',
                    aset                 => '0',
                    ainit                => '0',
                    sclr                 => '0',
                    sset                 => '0',
                    sinit                => '0',
                    q                    => pipe2);
        reged   : if (c_reg_last_bit = 1) generate
          qout3 : c_reg_fd_v11_0
            generic map (c_ainit_val     => std_logic_vector_to_string(ainit_val),
                         c_has_aclr      => c_has_aclr,
                         c_has_ainit     => c_has_ainit,
                         c_has_aset      => c_has_aset,
                         c_has_ce        => c_has_ce,
                         c_has_sclr      => c_has_sclr,
                         c_has_sinit     => c_has_sinit,
                         c_has_sset      => c_has_sset,
                         c_sinit_val     => std_logic_vector_to_string(sinit_val),
                         c_sync_enable   => c_sync_enable,
                         c_sync_priority => c_sync_priority,
                         c_width         => c_width)
            port map (d                  => pipe2,
                      clk                => clk,
                      ce                 => int_ce,
                      aclr               => aclr,
                      aset               => aset,
                      ainit              => ainit,
                      sclr               => sclr,
                      sset               => sset,
                      sinit              => sinit,
                      q                  => qint);
        end generate reged;
        unreg   : if not(c_reg_last_bit = 1) generate
          qint               <= pipe2;
        end generate;
      end generate lat2;
    end generate opt_speed;

    process (clk, inta)
      variable rdeep : integer := fn_get_real_depth(c_depth, c_reg_last_bit, ci_shift_type, srl_depth);
      type shifttype is array(0 to rdeep-1) of std_logic_vector(c_width-1 downto 0);
      variable first : boolean := true;
      variable shift : shifttype;

      constant mem_bits  : integer := rdeep * c_width;
      variable memdvect  : std_logic_vector(mem_bits-1 downto 0);
      variable bits_good : boolean;
      variable lineno    : integer := 0;
      variable offset    : integer := 0;
      variable def_data  : std_logic_vector(c_width-1 downto 0);

    begin

      -- startup section reads and/or writes mif file if necessary.

      if (first) then

        -- call function in all cases - use to assign default data as well        
        memdvect := read_mif_data(c_read_mif, c_generate_mif, c_width, rdeep, c_mem_init_file, c_elaboration_dir, c_default_data);

        for i in 0 to rdeep-1 loop
          for j in 0 to c_width-1 loop
            shift(i)(j) := memdvect(j + i*c_width);
          end loop;
        end loop;
        if (anyx(inta)) then
          shift_out <= (others => 'X');
        elsif (to_integer(unsigned(inta)) >= rdeep) then
          shift_out <= (others => '0');
        else
          shift_out <= shift(to_integer(unsigned(inta)));
        end if;

        first        := false;
      else                              -- not first
        if (clk'event and int_ce = '1' and clk'last_value = '0' and clk = '1') then  -- rising edge!
          for i in rdeep-1 downto 1 loop
            shift(i) := shift(i-1);
          end loop;
          shift(0)   := d;
        elsif (clk'event and (int_ce = 'X' or (clk'last_value = '0' and clk = 'X') or (clk'last_value = 'X' and clk = '1'))) then
          for i in 0 to rdeep-1 loop
            shift(i) := (others => 'X');
          end loop;
        end if;
        if (anyx(inta)) then
          shift_out <= (others  => 'X');
        elsif (to_integer(unsigned(inta)) >= rdeep) then
          shift_out <= (others  => 'X');  -- dlunn modified from '0' for illegal addressing
        else
          shift_out <= shift(to_integer(unsigned(inta)));
        end if;
      end if;
    end process;
  end GENERATE lossless;


  q <= qint AFTER timeunit;

END behavioral;
