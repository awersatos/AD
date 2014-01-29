-------------------------------------------------------------------------------
-- $RCSfile: dist_mem_gen_v3_1.vhd,v $
-- $Revision: 1.8 $
-- $Date: 2008/09/08 19:37:01 $
-------------------------------------------------------------------------------
-- Copyright(C) 2005-2006 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity dist_mem_gen_v3_1 is
   generic (
      c_addr_width     : integer := 6;
      c_default_data   : string  := "0";
      c_depth          : integer := 64;
      c_has_clk        : integer := 1;
      c_has_d          : integer := 1;
      c_has_dpo        : integer := 0;
      c_has_dpra       : integer := 0;
      c_has_i_ce       : integer := 0;
      c_has_qdpo       : integer := 0;
      c_has_qdpo_ce    : integer := 0;
      c_has_qdpo_clk   : integer := 0;
      c_has_qdpo_rst   : integer := 0;
      c_has_qdpo_srst  : integer := 0;
      c_has_qspo       : integer := 0;
      c_has_qspo_ce    : integer := 0;
      c_has_qspo_rst   : integer := 0;
      c_has_qspo_srst  : integer := 0;
      c_has_spo        : integer := 1;
      c_has_spra       : integer := 0;
      c_has_we         : integer := 1;
      c_mem_init_file  : string  := "null.mif";
      c_mem_type       : integer := 1;
      c_qce_joined     : integer := 0;
      c_qualify_we     : integer := 0;
      c_read_mif       : integer := 0;
      c_reg_a_d_inputs : integer := 0;
      c_reg_dpra_input : integer := 0;
      c_sync_enable    : integer := 0;
      c_width          : integer := 16);
   port (
      a    : in  std_logic_vector(c_addr_width-1-(4*c_has_spra*boolean'pos(c_addr_width>4)) downto 0) := (others => '0');

      d    : in std_logic_vector(c_width-1 downto 0)      := (others => '0');
      dpra : in std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
      spra : in std_logic_vector(c_addr_width-1 downto 0) := (others => '0');

      clk       : in  std_logic := '0';
      we        : in  std_logic := '0';
      i_ce      : in  std_logic := '1';
      qspo_ce   : in  std_logic := '1';
      qdpo_ce   : in  std_logic := '1';
      qdpo_clk  : in  std_logic := '0';
      qspo_rst  : in  std_logic := '0';
      qdpo_rst  : in  std_logic := '0';
      qspo_srst : in  std_logic := '0';
      qdpo_srst : in  std_logic := '0';
      spo       : out std_logic_vector(c_width-1 downto 0);
      dpo       : out std_logic_vector(c_width-1 downto 0);
      qspo      : out std_logic_vector(c_width-1 downto 0);
      qdpo      : out std_logic_vector(c_width-1 downto 0)); 

end dist_mem_gen_v3_1;

architecture behavioral of dist_mem_gen_v3_1 is

   constant max_address : std_logic_vector(c_addr_width-1 downto 0) :=
      std_logic_vector(to_unsigned(c_depth-1, c_addr_width));

   constant c_rom    : integer := 0;
   constant c_sp_ram : integer := 1;
   constant c_dp_ram : integer := 2;
   constant c_srl16  : integer := 3;

   type mem_type is array ((2**c_addr_width)-1 downto 0) of std_logic_vector(c_width-1 downto 0);

   ---------------------------------------------------------------------
   -- Convert character to type std_logic.
   ---------------------------------------------------------------------
   function char_to_std_logic (
      char : in character)
      return std_logic is

      variable data : std_logic;
      
   begin
      if char = '0' then
         data := '0';
         
      elsif char = '1' then
         data := '1';

      elsif char = 'X' then
         data := 'X';
         
      else
         assert false
            report "character which is not '0', '1' or 'X'."
            severity warning;
         
         data := 'U';
      end if;

      return data;
      
   end char_to_std_logic;
   ---------------------------------------------------------------------

   function read_mif (
      filename : in string;
      def_data : in std_logic_vector;
      depth    : in integer;
      width    : in integer)
      return mem_type is

      file meminitfile     : text;
      variable mif_status  : file_open_status;
      variable bitline     : line;
      variable bitsgood    : boolean := true;
      variable bitchar     : character;
      variable lines       : integer := 0;

      variable memory_content : mem_type;
      
   begin

      for i in 0 to depth-1 loop
         memory_content(i) := def_data;
      end loop;  -- i

      file_open(mif_status, meminitfile, filename, read_mode);

      if mif_status /= open_ok then
         assert false
            report "Error: read_mem_init_file: could not open MIF."
            severity failure;
      end if;

      lines := 0;

      for i in 0 to depth-1 loop
         
         if not(endfile(meminitfile)) and i < depth then
            
            memory_content(i) := (others => '0');
            readline(meminitfile, bitline);

            for j in 0 to width-1 loop
               read(bitline, bitchar, bitsgood);
               
               if ((bitsgood = false) or
                   ((bitchar /= ' ') and (bitchar /= cr) and
                    (bitchar /= ht) and (bitchar /= lf) and
                    (bitchar /= '0') and (bitchar /= '1') and
                    (bitchar /= 'x') and (bitchar /= 'z'))) then
                  assert false
                     report
                     "Warning: dist_mem_utils: unknown or illegal " &
                     "character encountered while reading mif - " &
                     "finishing file read." & cr &
                     "This could be due to an undersized mif file"
                     severity warning;
                  exit;                 -- abort the file read
               end if;

               memory_content(i)(width-1-j) := char_to_std_logic(bitchar);
            end loop;  -- j
            
         else
            exit;
         end if;

         lines := i;
         
      end loop;

      file_close(meminitfile);      

      assert not(lines > depth)
         report "MIF file contains more addresses than the memory."
         severity failure;

      assert lines = depth
         report
         "MIF file size does not match memory size." & cr &
         "Remaining addresses in memory are padded with default data."
         severity warning;
      
      return memory_content;
      
   end read_mif;

   ---------------------------------------------------------------------

   function string_to_std_logic_vector (
      the_string : string;
      size       : integer)
      return std_logic_vector is
      variable slv_tmp : std_logic_vector(1 to size) := (others => '0');
      variable slv : std_logic_vector(size-1 downto 0) := (others => '0');
      
      variable index : integer := 0;
   begin

      slv_tmp := (others => '0');
      index := size;      

      if the_string'length > size then
         for i in the_string'length downto the_string'length-size+1 loop            
            slv_tmp(index) := char_to_std_logic(the_string(i));
            index := index - 1;
         end loop;  -- i
      else
         for i in the_string'length downto 1 loop
            slv_tmp(index) := char_to_std_logic(the_string(i));
            index := index - 1;
         end loop;  -- i
      end if;

      for i in 1 to size loop
         slv(size-i) := slv_tmp(i);
      end loop;  -- i

      return slv;
      
   end string_to_std_logic_vector;

   ---------------------------------------------------------------------
   -- Convert the content of a file and return an array of
   -- std_logic_vectors.
   ---------------------------------------------------------------------
   
   ---------------------------------------------------------------------

   ---------------------------------------------------------------------
   -- Function which initialises the memory from the c_default_data
   -- string or the c_mem_init_file MIF file.
   ---------------------------------------------------------------------   
   function init_mem (
      memory_type   : in integer;
      read_mif_file : in integer;
      filename      : in string;
      default_data  : in string;
      depth         : in integer;
      width         : in integer)
      return mem_type is

      variable memory_content : mem_type := (others => (others => '0'));
      
      variable def_data  : std_logic_vector(width-1 downto 0) := (others => '0');
      constant all_zeros : std_logic_vector(width-1 downto 0) := (others => '0');
      
   begin

      def_data := string_to_std_logic_vector(default_data, width);

      if read_mif_file = 0 then
         -- If the memory is not initialised from a MIF file then fill the memory array with
         -- default data.
         for i in 0 to depth-1 loop
            memory_content(i) := def_data;
         end loop;  -- i                 
      else
         --Initialise the memory from the MIF file.
         memory_content := read_mif(filename, def_data, depth, width);
      end if;

      return memory_content;
      
   end init_mem;
   ------------------------------------------------------------------

   signal memory : mem_type :=
      init_mem(
         c_mem_type,
         c_read_mif,
         c_mem_init_file,
         c_default_data,
         c_depth,
         c_width);

   -- address signal connected to memory
   signal a_int     : std_logic_vector(c_addr_width-1-(4*c_has_spra*boolean'pos(c_addr_width>4)) downto 0) := (others => '0');
   -- address signal connected to memory, which has been registered.
   signal a_reg     : std_logic_vector(c_addr_width-1-(4*c_has_spra*boolean'pos(c_addr_width>4)) downto 0) := (others => '0');

   signal a_over    : std_logic_vector(c_addr_width-1-(4*c_has_spra*boolean'pos(c_addr_width>4)) downto 0) := (others => '0');

   signal spra_over : std_logic_vector(c_addr_width-1 downto 0) := (others => '0');

   -- read address signal connected to srl16-based memory
   signal spra_int  : std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
   -- read address signal connected to srl16-based memory, which has
   -- been registered.
   signal spra_reg  : std_logic_vector(c_addr_width-1 downto 0) := (others => '0');

   -- dual port read address signal connected to dual port memory
   signal dpra_int  : std_logic_vector(c_addr_width-1 downto 0) := (others => '0');
   -- dual port read address signal connected to dual port memory, which
   -- has been registered.
   signal dpra_reg  : std_logic_vector(c_addr_width-1 downto 0) := (others => '0');

   signal dpra_over : std_logic_vector(c_addr_width-1 downto 0) := (others => '0');

   -- input data signal connected to RAM
   signal d_int : std_logic_vector(c_width-1 downto 0) := (others => '0');
   -- input data signal connected to RAM, which has been registered.   
   signal d_reg : std_logic_vector(c_width-1 downto 0) := (others => '0');

   -- Write Enable signal connected to memory
   signal we_int : std_logic := '0';
   -- Write Enable signal connected to memory, which has been registered.   
   signal we_reg : std_logic := '0';

   -- Internal Clock Enable for optional qspo output
   signal qspo_ce_int : std_logic := '0';
   -- Internal Clock Enable for optional qspo output, which has been
   -- registered
   signal qspo_ce_reg : std_logic := '0';

   -- Internal Clock Enable for optional qdpo output
   signal qdpo_ce_int : std_logic := '0';
   -- Internal Clock Enable for optional qspo output, which has been
   -- registered
   signal qdpo_ce_reg : std_logic := '0';

   -- Internal version of the spo output
   signal spo_int : std_logic_vector(c_width-1 downto 0) := (others => '0');

   -- Internal version of the qspo output
   signal qspo_int : std_logic_vector(c_width-1 downto 0) :=
      string_to_std_logic_vector(c_default_data, c_width);

   -- Internal version of the dpo output
   signal dpo_int : std_logic_vector(c_width-1 downto 0) := (others => '0');

   -- Internal version of the qdpo output
   signal qdpo_int : std_logic_vector(c_width-1 downto 0) :=
      string_to_std_logic_vector(c_default_data, c_width);

   -- Content of spo_int from address a
   signal data_sp       : std_logic_vector(c_width-1 downto 0);

   -- Content of Dual Port Output at address dpra
   signal data_dp       : std_logic_vector(c_width-1 downto 0);

   -- Content of spo_int at address spra
   signal data_srl      : std_logic_vector(c_width-1 downto 0);

   -- Content of spo_int from address a
   signal data_sp_over  : std_logic_vector(c_width-1 downto 0);

   -- Content of Dual Port Output at address dpra
   signal data_dp_over  : std_logic_vector(c_width-1 downto 0);

   -- Content of spo_int at address spra
   signal data_srl_over : std_logic_vector(c_width-1 downto 0);

   signal a_is_over    : std_logic;
   signal dpra_is_over : std_logic;
   signal spra_is_over : std_logic;

   signal srl_start_int : integer;
   signal srl_end_int : integer;

begin
  p_warn_behavioural : process
  begin
    assert false report "This core is supplied with a behavioral model. To model cycle-accurate behavior you must run timing simulation." severity warning;
    wait;
  end process p_warn_behavioural;

   ---------------------------------------------------------------------
   -- Infer any optional input registers, in the clk clock domain.
   ---------------------------------------------------------------------
   p_optional_input_registers : process
   begin
      wait until c_reg_a_d_inputs = 1 and clk'event and clk = '1';

      if c_has_i_ce = 0 then
         we_reg   <= we after 100 ps;
         a_reg    <= a after 100 ps;
         spra_reg <= spra after 100 ps;
         d_reg    <= d after 100 ps;
      elsif c_qualify_we = 0 then
         we_reg <= we after 100 ps;
         if i_ce = '1' then
            a_reg    <= a after 100 ps;
            spra_reg <= spra after 100 ps;
            d_reg    <= d after 100 ps;
         end if;
      elsif c_qualify_we = 1 and i_ce = '1' then
         we_reg   <= we after 100 ps;
         a_reg    <= a after 100 ps;
         spra_reg <= spra after 100 ps;
         d_reg    <= d after 100 ps;
      end if;

      qspo_ce_reg <= qspo_ce after 100 ps;

   end process p_optional_input_registers;

   ---------------------------------------------------------------------
   -- If the inputs are registered, propogate those signals to the
   -- internal versions that will be used by the memory construct.
   ---------------------------------------------------------------------
   g_optional_input_regs : if c_reg_a_d_inputs = 1 generate
      we_int      <= we_reg;
      d_int       <= d_reg;
      a_int       <= a_reg;
      spra_int    <= spra_reg;
      qspo_ce_int <= qspo_ce_reg;
   end generate g_optional_input_regs;

   ---------------------------------------------------------------------
   -- Otherwise, just pass the ports directly to the internal signals
   -- used by the memory construct.
   ---------------------------------------------------------------------
   g_no_optional_input_regs : if c_reg_a_d_inputs = 0 generate
      we_int      <= we;
      d_int       <= d;
      a_int       <= a;
      spra_int    <= spra;
      qspo_ce_int <= qspo_ce;
   end generate g_no_optional_input_regs;
   ---------------------------------------------------------------------

   ---------------------------------------------------------------------
   -- In addition, there are inputs that can be registered, that can
   -- have their own clock domain.  This is best handled in a seperate
   -- process for readability.
   ---------------------------------------------------------------------
   p_optional_dual_port_regs : process
   begin

      if c_reg_dpra_input = 0 then
         wait;
      elsif c_has_qdpo_clk = 0 then
         wait until clk'event and clk = '1';
      else
         wait until qdpo_clk'event and qdpo_clk = '1';
      end if;

      if c_qce_joined = 1 then
         if c_has_qspo_ce = 0 or (c_has_qspo_ce = 1 and qspo_ce = '1') then
            dpra_reg <= dpra after 100 ps;
         end if;
      elsif c_has_qdpo_ce = 0 or (c_has_qdpo_ce = 1 and qdpo_ce = '1') then
         dpra_reg <= dpra after 100 ps;
      end if;

      qdpo_ce_reg <= qdpo_ce after 100 ps;
      
   end process p_optional_dual_port_regs;

   ---------------------------------------------------------------------
   -- If the inputs are registered, propogate those signals to the
   -- internal versions that will be used by the memory construct.
   ---------------------------------------------------------------------
   g_optional_dual_port_regs : if c_reg_dpra_input = 1 generate
      dpra_int    <= dpra_reg;
      qdpo_ce_int <= qdpo_ce_reg;
   end generate g_optional_dual_port_regs;

   ---------------------------------------------------------------------
   -- Otherwise, just pass the ports directly to the internal signals
   -- used by the memory construct.
   ---------------------------------------------------------------------
   g_no_optional_dual_port_regs : if c_reg_dpra_input = 0 generate
      dpra_int    <= dpra;
      qdpo_ce_int <= qdpo_ce;
   end generate g_no_optional_dual_port_regs;
   ---------------------------------------------------------------------

   ---------------------------------------------------------------------
   -- For the Single Port RAM and Dual Port RAM memory types, define how
   -- the RAM is written to.
   ---------------------------------------------------------------------
   p_write_to_spram_dpram : process
      variable srl_start : integer := 0;
      variable srl_end   : integer := 0;
      variable srl_start_vec : std_logic_vector(c_addr_width-1 downto 0);
      variable srl_end_vec : std_logic_vector(c_addr_width-1 downto 0);
   begin  -- process p_write_to_spram_dpram      

      wait until clk'event and clk = '1' and we_int = '1'
        and c_mem_type /= c_rom;

      if c_mem_type = c_srl16 then      
         if c_addr_width > 4 then
            srl_start_vec := a_int & "0000";
            srl_end_vec   := a_int & "1111";
         else            
            srl_start_vec := (others => '0');
            srl_end_vec   := (others => '1');
         end if;

         srl_start := to_integer(unsigned(srl_start_vec));
         srl_end   := to_integer(unsigned(srl_end_vec));

         srl_start_int <= srl_start after 100 ps;
         srl_end_int   <= srl_end after 100 ps;

         --Shift the memory content one location
         memory(srl_end downto srl_start) <= memory(srl_end-1 downto srl_start) & d_int after 100 ps;

      elsif a_is_over = '1' then
         assert false
            report "Writing to out of range address." & cr &
            "Max address is " & integer'image(c_depth-1) & "." &
            cr & "Write ignored."
            severity warning;         
      else
         memory(to_integer(unsigned(a_int))) <= d_int after 100 ps;
      end if;
      
   end process p_write_to_spram_dpram;
   
   ---------------------------------------------------------------------   
   -- Form the spo_int signal and the optional spo output. spo_int will
   -- be used in assigning the optional qspo output.
   ---------------------------------------------------------------------
   g_spo_from_srl: if c_mem_type = c_srl16 generate
      spo_int <= data_srl_over when spra_is_over = '1' else data_srl;
   end generate g_spo_from_srl;

   assert not(spra_is_over = '1' and c_mem_type = c_srl16)
      report "SPRA trying to read from out of range address." & cr &
      "Max address is " & integer'image(c_depth-1)
      severity warning;

   g_spo_not_from_srl: if c_mem_type /= c_srl16 generate
      spo_int <= data_sp_over when a_is_over = '1' else data_sp;
   end generate g_spo_not_from_srl;

   assert not(a_is_over = '1' and c_mem_type /= c_srl16)
      report "A trying to read from out of range address." & cr &
      "Max address is " & integer'image(c_depth-1)
      severity warning;

   a_is_over    <= '1' when a_int > max_address else '0';
   dpra_is_over <= '1' when dpra_int > max_address else '0';
   spra_is_over <= '1' when spra_int > max_address else '0';

   g_a_srlram_lt5: if c_mem_type = c_srl16 and c_addr_width < 5 generate
      --Due to the width of the address bus A in this instance, this
      --will not be used by the SRL16 based memory.
      a_over <= (others => '0');
   end generate g_a_srlram_lt5;

   g_a_srlram_bg4: if c_mem_type = c_srl16 and c_addr_width > 4 generate
      g_a_over_srlram_bg4: for i in 4 to c_addr_width-1 generate
         a_over(i-4) <= a_int(i-4) and max_address(i);
      end generate g_a_over_srlram_bg4;
   end generate g_a_srlram_bg4;

   g_a_over_not_srlram: if c_mem_type /= c_srl16 generate
      g_a_over: for i in 0 to c_addr_width-1 generate
         a_over(i) <= a_int(i) and max_address(i);
      end generate g_a_over;
   end generate g_a_over_not_srlram;

   g_dpra_over: for i in 0 to c_addr_width-1 generate
      dpra_over(i) <= dpra_int(i) and max_address(i);
   end generate g_dpra_over;

   g_spra_over: for i in 0 to c_addr_width-1 generate
      spra_over(i) <= spra_int(i) and max_address(i);
   end generate g_spra_over;   

   data_sp       <= memory(to_integer(unsigned(a_int)));
   data_sp_over  <= (others => 'X');
   data_dp       <= memory(to_integer(unsigned(dpra_int)));
   data_dp_over  <= (others => 'X');
   data_srl      <= memory(to_integer(unsigned(spra_int)));
   data_srl_over <= (others => 'X');
   
   g_has_spo : if c_has_spo = 1 generate
      spo <= spo_int;
   end generate g_has_spo;

   g_has_no_spo : if c_has_spo = 0 generate
      spo <= (others => 'X');
   end generate g_has_no_spo;
   ---------------------------------------------------------------------

   ---------------------------------------------------------------------
   -- Form the dpo_int signal and the optional dpo output. dpo_int will
   -- be used in assigning the optional qdpo output.
   ---------------------------------------------------------------------   
   g_dpram: if c_mem_type = c_dp_ram generate
      dpo_int <= data_dp_over when dpra_is_over = '1' else data_dp;
   end generate g_dpram;
   g_not_dpram: if c_mem_type /= c_dp_ram generate
      dpo_int <= (others => 'X');
   end generate g_not_dpram;

   assert not(c_mem_type = c_dp_ram and dpra_is_over = '1')
      report "DPRA trying to read from out of range address." & cr &
      "Max address is " & integer'image(c_depth-1)
       severity warning;

   g_has_dpo : if c_has_dpo = 1 generate
      dpo <= dpo_int;
   end generate g_has_dpo;

   g_has_no_dpo : if c_has_dpo = 0 generate
      dpo <= (others => 'X');
   end generate g_has_no_dpo;
   ---------------------------------------------------------------------

   ---------------------------------------------------------------------
   -- Form the QSPO output depending on the following:
   ---------------------------------------------------------------------
   -- Generics
   -- c_has_qspo
   -- c_has_qspo_rst
   -- c_sync_enable
   -- c_has_qspo_ce
   ---------------------------------------------------------------------
   -- Signals
   -- clk
   -- qspo_rst
   -- qspo_srst
   -- qspo_ce
   -- spo_int
   ---------------------------------------------------------------------
   p_has_qspo : process
   begin
      if c_has_qspo /= 1 then
         qspo_int <= (others => 'X');
         wait;
      end if;

      wait until (clk'event and clk = '1') or (qspo_rst = '1' and c_has_qspo_rst = 1);

      if c_has_qspo_rst = 1 and qspo_rst = '1' then
         qspo_int <= (others => '0');
         
      elsif c_has_qspo_srst = 1 and qspo_srst = '1' then
         
         if c_sync_enable = 0 then
            qspo_int <= (others => '0') after 100 ps;
            
         elsif c_has_qspo_ce = 0 or (c_has_qspo_ce = 1 and qspo_ce_int = '1') then
            qspo_int <= (others => '0') after 100 ps;
         end if;
         
      elsif c_has_qspo_ce = 0 or qspo_ce_int = '1' then
         qspo_int <= spo_int after 100 ps;
      end if;
   end process p_has_qspo;
   ---------------------------------------------------------------------
   qspo <= qspo_int;

   ---------------------------------------------------------------------
   -- Form the QDPO output depending on the following:
   ---------------------------------------------------------------------
   -- Generics
   -- c_has_qdpo
   -- c_qce_joined
   -- c_has_qdpo_clk
   -- c_has_qdpo_rst
   -- c_has_qdpo_srst
   -- c_has_qdpo_ce
   -- c_has_qspo_ce
   -- c_sync_enable
   ---------------------------------------------------------------------
   -- Signals
   -- clk
   -- qdpo_clk
   -- qdpo_rst
   -- qdpo_srst
   -- qdpo_ce
   -- qspo_ce
   -- dpo_int
   ---------------------------------------------------------------------
   p_has_qdpo : process
   begin
      if c_has_qdpo /= 1 then
         qdpo_int <= (others => 'X');
         wait;
      end if;

      if c_has_qdpo_clk = 0 then
         --Common clock enables used for qspo and qdpo outputs.
         --Therefore we have one clock domain to worry about.
         wait until (clk'event and clk = '1')
           or (c_has_qdpo_rst = 1 and qdpo_rst = '1');
      else
         --The qdpo output is in a seperate clock domain from the rest
         --of the dual port RAM.
         wait until
            (qdpo_clk'event and qdpo_clk = '1') or
            (c_has_qdpo_rst = 1 and qdpo_rst = '1');
      end if;

      if c_has_qdpo_rst = 1 and qdpo_rst = '1' then
         -- Async reset asserted.
         qdpo_int <= (others => '0');
         
      elsif c_has_qdpo_srst = 1 and qdpo_srst = '1' then
         
         if c_sync_enable = 0 then
            --Synchronous reset asserted.  Sync reset overrides the
            --clock enable
            qdpo_int <= (others => '0') after 100 ps;
            
         elsif c_qce_joined = 0 then
            -- Seperate qdpo_clk domain
            if c_has_qdpo_ce = 0 or (c_has_qdpo_ce = 1 and qdpo_ce_int = '1') then
               -- Either the qdpo does not have a clock enable, or it
               -- does, and it has been asserted permitting the sync
               -- reset to act.
               qdpo_int <= (others => '0') after 100 ps;
            end if;
            
         elsif c_has_qspo_ce = 0 or (c_has_qspo_ce = 1 and qspo_ce_int = '1') then
            -- Common clock domain so we monitor the common clock
            -- enable to see if the a sync reset is permitted, or there
            -- are no clock enables to block the sync reset.
            qdpo_int <= (others => '0') after 100 ps;
         end if;
         
      elsif c_qce_joined = 0 then
         -- qdpo is a seperate clock domain, so check to see if there
         -- is a qdpo_ce clock enable, if it is there, assign qdpo when
         -- qdpo_ce is active - if there is no clock enable just assign
         -- it.
         if c_has_qdpo_ce = 0 or (c_has_qdpo_ce = 1 and qdpo_ce_int = '1') then
            qdpo_int <= dpo_int after 100 ps;
         end if;
         
      elsif c_has_qspo_ce = 0 or (c_has_qspo_ce = 1 and qspo_ce_int = '1') then
         -- Common clock domain, check to see if there is a qspo_ce to
         -- concern us.
         qdpo_int <= dpo_int after 100 ps;
      end if;
   end process p_has_qdpo;
   ---------------------------------------------------------------------
   qdpo <= qdpo_int;

end behavioral;
