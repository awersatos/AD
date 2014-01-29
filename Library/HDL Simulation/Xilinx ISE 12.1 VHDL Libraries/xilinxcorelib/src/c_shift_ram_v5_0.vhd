-- $Id: c_shift_ram_v5_0.vhd,v 1.18 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - c_shift_ram_v5_0.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description
--  RAM based Shift Register Simulation Model
--   VHDL-87 compatable version
--   Also compatable with VHDL-93
--   User cannot generate a Memory Initialization file from the memory
--   contents, unless xilinxcorelib.mem_init_file pack is compiled from
--   either mem_init_file_pack_87.vhd or mem_init_file_pack_93.vhd.
--   Default compilation is mem_init_file_pack.vhd
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.ul_utils.all;
use xilinxcorelib.mem_init_file_pack_v5_0.all;
use xilinxcorelib.prims_constants_v5_0.all;
use xilinxcorelib.prims_utils_v5_0.all;
use xilinxcorelib.c_reg_fd_v5_0_comp.all;

entity C_SHIFT_RAM_V5_0 is
   generic (C_ADDR_WIDTH         : integer := 4;
            C_AINIT_VAL          : string  := "";
            C_DEFAULT_DATA       : string  := "0";
            C_DEFAULT_DATA_RADIX : integer := 1;
            C_DEPTH              : integer := 16;
            C_ENABLE_RLOCS       : integer := 1;
            C_GENERATE_MIF       : integer := 0;  -- Unused by the behavioural model
            C_HAS_ACLR           : integer := 0;
            C_HAS_A              : integer := 0;
            C_HAS_AINIT          : integer := 0;
            C_HAS_ASET           : integer := 0;
            C_HAS_CE             : integer := 0;
            C_HAS_SCLR           : integer := 0;
            C_HAS_SINIT          : integer := 0;
            C_HAS_SSET           : integer := 0;
            C_MEM_INIT_FILE      : string  := "null.mif";
            C_MEM_INIT_RADIX     : integer := 1;  -- for backwards compatibility
            C_READ_MIF           : integer := 0;
            C_REG_LAST_BIT       : integer := 0;
            C_SHIFT_TYPE         : integer := c_fixed;
            C_SINIT_VAL          : string  := "";
            C_SYNC_PRIORITY      : integer := c_clear;
            C_SYNC_ENABLE        : integer := c_override;
            C_WIDTH              : integer := 16
            ); 

   port (A     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0');
         D     : in  std_logic_vector(C_WIDTH-1 downto 0)      := (others => '0');
         CLK   : in  std_logic                                 := '0';
         CE    : in  std_logic                                 := '1';
         ACLR  : in  std_logic                                 := '0';
         ASET  : in  std_logic                                 := '0';
         AINIT : in  std_logic                                 := '0';
         SCLR  : in  std_logic                                 := '0';
         SSET  : in  std_logic                                 := '0';
         SINIT : in  std_logic                                 := '0';
         Q     : out std_logic_vector(C_WIDTH-1 downto 0)
         ); 
end C_SHIFT_RAM_V5_0;
--
-- behavior describing a parameterized ram based shift register
--
architecture behavioral of C_SHIFT_RAM_V5_0 is
--
   signal shift_out            : std_logic_vector(C_WIDTH-1 downto 0)      := (others => '0');
   type   T_PIPE_SIGNAL is array (0 to C_DEPTH) of std_logic_vector(C_WIDTH-1 downto 0);
   signal d_pipe               : T_PIPE_SIGNAL                             := (others => (others => '0'));
   signal intA                 : std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0');
   signal init                 : T_PIPE_SIGNAL                             := (others => (others => '0'));
   signal initclr              : T_PIPE_SIGNAL                             := (others => (others => '0'));
   signal int_ce               : std_logic                                 := '0';
--
   function getRealDepth(depth : integer) return integer is
   begin
      if((depth mod 16) > 0) then
         return(((depth/16)+1)*16);
      else
         return(depth);
      end if;
   end getRealDepth;

   function getRadix(C_DEFAULT_DATA_RADIX, C_MEM_INIT_RADIX : integer) return integer is
   begin
      if (C_DEFAULT_DATA_RADIX = 1) then
         return C_MEM_INIT_RADIX;
      else
         return C_DEFAULT_DATA_RADIX;
      end if;
   end getRadix;
--

   constant radix : integer := getRadix(C_DEFAULT_DATA_RADIX, C_MEM_INIT_RADIX);
--
begin
   
   cegen1 : if (c_has_ce = 1) generate
      cegen11 : int_ce <= ce;
   end generate;

   cegen0 : if (c_has_ce = 0) generate
      cegen01 : int_ce <= '1';
   end generate;

   -- The fixed length version can be modelled simply with a
   -- pipeline of FDs and a final output register if required
   fixed : if (C_SHIFT_TYPE = c_fixed) generate
      reged : if (C_REG_LAST_BIT = 1) generate
         qout1 : if (C_DEPTH > 1) generate
            qout11 : C_REG_FD_V5_0
               generic map (C_AINIT_VAL     => C_AINIT_VAL,
                            C_HAS_ACLR      => C_HAS_ACLR,
                            C_HAS_AINIT     => C_HAS_AINIT,
                            C_HAS_ASET      => C_HAS_ASET,
                            C_HAS_CE        => C_HAS_CE,
                            C_HAS_SCLR      => C_HAS_SCLR,
                            C_HAS_SINIT     => C_HAS_SINIT,
                            C_HAS_SSET      => C_HAS_SSET,
                            C_SINIT_VAL     => C_SINIT_VAL,
                            C_SYNC_ENABLE   => C_SYNC_ENABLE,
                            C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                            C_WIDTH         => C_WIDTH) 
               port map (D     => shift_out,
                         CLK   => CLK,
                         CE    => CE,
                         ACLR  => ACLR,
                         ASET  => ASET,
                         AINIT => AINIT,
                         SCLR  => SCLR,
                         SSET  => SSET,
                         SINIT => SINIT,
                         Q     => Q);     
         end generate;
         qout2 : if (C_DEPTH = 1) generate
            qout21 : C_REG_FD_V5_0
               generic map (C_AINIT_VAL     => C_AINIT_VAL,
                            C_HAS_ACLR      => C_HAS_ACLR,
                            C_HAS_AINIT     => C_HAS_AINIT,
                            C_HAS_ASET      => C_HAS_ASET,
                            C_HAS_CE        => C_HAS_CE,
                            C_HAS_SCLR      => C_HAS_SCLR,
                            C_HAS_SINIT     => C_HAS_SINIT,
                            C_HAS_SSET      => C_HAS_SSET,
                            C_SINIT_VAL     => C_SINIT_VAL,
                            C_SYNC_ENABLE   => C_SYNC_ENABLE,
                            C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                            C_WIDTH         => C_WIDTH) 
               port map (D     => D,
                         CLK   => CLK,
                         CE    => CE,
                         ACLR  => ACLR,
                         ASET  => ASET,
                         AINIT => AINIT,
                         SCLR  => SCLR,
                         SSET  => SSET,
                         SINIT => SINIT,
                         Q     => Q);     
         end generate;
      end generate;
      unreg : if not (C_REG_LAST_BIT = 1) generate
         Q <= shift_out;
      end generate;

-- Core Memory process
      process (CLK)
--   
         type     shifttype is array(0 to C_DEPTH-1-C_REG_LAST_BIT) of std_logic_vector(C_WIDTH-1 downto 0);
         variable shift : shifttype;

         constant mem_bits  : integer := C_DEPTH * C_WIDTH;
         variable memdvect  : std_logic_vector(mem_bits-1 downto 0);
         variable bits_good : boolean;
         variable lineno    : integer := 0;
         variable offset    : integer := 0;
         variable def_data  : std_logic_vector(C_WIDTH-1 downto 0);
         variable startup   : boolean := true;
         variable spo_tmp   : std_logic_vector(C_WIDTH-1 downto 0);
         variable dpo_tmp   : std_logic_vector(C_WIDTH-1 downto 0);
         variable srl_start : integer := 0;
         variable srl_end   : integer := 0;
--              

         function add_std_logic_vec( arg1, arg2 : std_logic_vector; size : integer ) return std_logic_vector is
            variable S : std_logic_vector(size-1 downto 0) := (others => '0');
            variable C : std_logic_vector(size-1 downto 0) := (others => '0');
            variable A : std_logic;
            variable B : std_logic;
         begin
            for i in 0 to size-2 loop
               if( i < arg1'length ) then
                  A := arg1(i);
               else
                  A := '0';
               end if;
               if( i < arg2'length ) then
                  B := arg2(i);
               else
                  B := '0';
               end if;
               S(i)   := A xor B;
               C(i+1) := (A and B) or (S(i) and C(i));
               S(i)   := S(i) xor C(i);
            end loop;
            return S;
         end add_std_logic_vec;
-- 
         function mul_std_logic_vec( arg1, arg2 : std_logic_vector; size : integer ) return std_logic_vector is
            variable M : std_logic_vector(size-1 downto 0) := (others => '0');
            variable A : std_logic_vector(size-1 downto 0);
         begin
            for i in 0 to arg2'length-1 loop
               if arg2(i) = '1' then
                  A := (others => '0');
                  for j in 0 to arg1'length-1 loop
                     if( i+j < size ) then
                        A(i+j) := arg1(j);
                     end if;
                  end loop;
                  M := add_std_logic_vec( M, A, size );
               end if;
            end loop;
            return M;
         end mul_std_logic_vec;
--
         function decstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable BIN    : std_logic_vector(3 downto 0);
            constant TEN    : std_logic_vector(3 downto 0)      := (3      => '1', 1 => '1', others => '0');
            variable MULT10 : std_logic_vector(size-1 downto 0) := std_logic_vector(to_unsigned(1, size));
            variable MULT   : std_logic_vector(size-1 downto 0);
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => BIN := (others => '0');
                  when '1'    => BIN := (0 => '1', others => '0');
                  when '2'    => BIN := (1 => '1', others => '0');
                  when '3'    => BIN := (0 => '1', 1 => '1', others => '0');
                  when '4'    => BIN := (2 => '1', others => '0');
                  when '5'    => BIN := (0 => '1', 2 => '1', others => '0');
                  when '6'    => BIN := (1 => '1', 2 => '1', others => '0');
                  when '7'    => BIN := (3 => '0', others => '1');
                  when '8'    => BIN := (3 => '1', others => '0');
                  when '9'    => BIN := (0 => '1', 3 => '1', others => '0');
                  when others =>
                     assert false
                        report "NOT A DECIMAL CHARACTER" severity error;
                     RESULT := (others => 'X');
                     return RESULT;
               end case;
               MULT   := mul_std_logic_vec( MULT10, BIN, size);
               RESULT := add_std_logic_vec( RESULT, MULT, size);
               MULT10 := mul_std_logic_vec( MULT10, TEN, size );
            end loop;
            return RESULT;
         end decstr_to_std_logic_vec;
--
         function binstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable INDEX  : integer                           := 0;
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => RESULT(INDEX) := '0';
                  when '1'    => RESULT(INDEX) := '1';
                  when others =>
                     assert false
                        report "NOT A BINARY CHARACTER" severity error;
                     RESULT(INDEX) := 'X';
               end case;
               INDEX := INDEX + 1;
            end loop;
            return RESULT;
         end binstr_to_std_logic_vec;
--
         function hexstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable BIN    : std_logic_vector(3 downto 0);
            variable INDEX  : integer                           := 0;
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => BIN := (others => '0');
                  when '1'    => BIN := (0 => '1', others => '0');
                  when '2'    => BIN := (1 => '1', others => '0');
                  when '3'    => BIN := (0 => '1', 1 => '1', others => '0');
                  when '4'    => BIN := (2 => '1', others => '0');
                  when '5'    => BIN := (0 => '1', 2 => '1', others => '0');
                  when '6'    => BIN := (1 => '1', 2 => '1', others => '0');
                  when '7'    => BIN := (3 => '0', others => '1');
                  when '8'    => BIN := (3 => '1', others => '0');
                  when '9'    => BIN := (0 => '1', 3 => '1', others => '0');
                  when 'A'    => BIN := (0 => '0', 2 => '0', others => '1');
                  when 'a'    => BIN := (0 => '0', 2 => '0', others => '1');
                  when 'B'    => BIN := (2 => '0', others => '1');
                  when 'b'    => BIN := (2 => '0', others => '1');
                  when 'C'    => BIN := (0 => '0', 1 => '0', others => '1');
                  when 'c'    => BIN := (0 => '0', 1 => '0', others => '1');
                  when 'D'    => BIN := (1 => '0', others => '1');
                  when 'd'    => BIN := (1 => '0', others => '1');
                  when 'E'    => BIN := (0 => '0', others => '1');
                  when 'e'    => BIN := (0 => '0', others => '1');
                  when 'F'    => BIN := (others => '1');
                  when 'f'    => BIN := (others => '1');
                  when others =>
                     assert false
                        report "NOT A HEX CHARACTER" severity error;
                     for j in 0 to 3 loop
                        BIN(j) := 'X';
                     end loop;
               end case;
               for j in 0 to 3 loop
                  if (INDEX*4)+j < size then
                     RESULT((INDEX*4)+j) := BIN(j);
                  end if;
               end loop;
               INDEX := INDEX + 1;
            end loop;
            return RESULT;
         end hexstr_to_std_logic_vec;
--
      begin

         -- Startup section reads and/or writes mif file if necessary.
         
         if (c_depth-c_reg_last_bit > 0) then
            if (startup) then
               def_data(C_WIDTH-1 downto 0) := (others => '0');
               case radix is
                  when 3 =>
                     def_data := decstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
                  when 2 =>
                     def_data := binstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
                  when 1 =>
                     def_data := hexstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
                  when others =>
                     assert false
                        report "BAD DATA RADIX" severity error;
               end case;

               if( C_READ_MIF = 1 ) then
                  read_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, lineno);
               end if;
               offset := lineno*C_WIDTH;
               while (lineno < C_DEPTH) loop
                  for i in 0 to C_WIDTH-1 loop
                     memdvect(offset+i) := def_data(i);
                  end loop;
                  lineno := lineno+1;
                  offset := offset+C_WIDTH;
               end loop;
               spo_tmp := (others => '0');
               dpo_tmp := (others => '0');

               if (C_GENERATE_MIF = 1) then
                  write_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, 0);
               end if;

               for i in 0 to C_DEPTH -1-C_REG_LAST_BIT loop
                  for j in 0 to C_WIDTH-1 loop
                     shift(i)(j) := memdvect(j + i*C_WIDTH);
                  end loop;
               end loop;

               startup := false;
            else                        -- Not FIRST
               if (CLK'event and int_CE = '1' and CLK'last_value = '0' and CLK = '1') then  -- rising edge!
                  for i in C_DEPTH-1-C_REG_LAST_BIT downto 1 loop
                     shift(i) := shift(i-1);
                  end loop;
                  shift(0) := D;
               elsif (CLK'event and (int_CE = 'X' or
                                     (CLK'last_value = '0' and CLK = 'X') or
                                     (CLK'last_value = 'X' and CLK = '1'))) then
                  for i in 0 to C_DEPTH-1-C_REG_LAST_BIT loop
                     shift(i) := (others => 'X');
                  end loop;
               end if;
               shift_out <= shift(C_DEPTH-1-C_REG_LAST_BIT);
            end if;
         end if;
      end process;
   end generate;

   a1 : if (C_HAS_A = 1) generate
      intA <= A;
   end generate;
   a0 : if (C_HAS_A = 0) generate
      intA <= std_logic_vector(to_unsigned(C_DEPTH-1, C_ADDR_WIDTH));
   end generate;

   -- The lossless version is also fairly straight forward
   lossless : if (C_SHIFT_TYPE = c_variable_lossless) generate
      reged : if (C_REG_LAST_BIT = 1) generate
         qout : C_REG_FD_V5_0
            generic map (C_AINIT_VAL     => C_AINIT_VAL,
                         C_HAS_ACLR      => C_HAS_ACLR,
                         C_HAS_AINIT     => C_HAS_AINIT,
                         C_HAS_ASET      => C_HAS_ASET,
                         C_HAS_CE        => C_HAS_CE,
                         C_HAS_SCLR      => C_HAS_SCLR,
                         C_HAS_SINIT     => C_HAS_SINIT,
                         C_HAS_SSET      => C_HAS_SSET,
                         C_SINIT_VAL     => C_SINIT_VAL,
                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                         C_WIDTH         => C_WIDTH) 
            port map (D     => shift_out,
                      CLK   => CLK,
                      CE    => int_CE,
                      ACLR  => ACLR,
                      ASET  => ASET,
                      AINIT => AINIT,
                      SCLR  => SCLR,
                      SSET  => SSET,
                      SINIT => SINIT,
                      Q     => Q);     
      end generate;
      unreg : if not (C_REG_LAST_BIT = 1) generate
         Q <= shift_out;
      end generate;

      process (CLK, intA)
         variable rdeep : integer := getRealDepth(C_DEPTH);
         type     shifttype is array(0 to rdeep-1) of std_logic_vector(C_WIDTH-1 downto 0);
         variable first : boolean := true;
         variable shift : shifttype;

         constant mem_bits  : integer := C_DEPTH * C_WIDTH;
         variable memdvect  : std_logic_vector(mem_bits-1 downto 0);
         variable bits_good : boolean;
         variable lineno    : integer := 0;
         variable offset    : integer := 0;
         variable def_data  : std_logic_vector(C_WIDTH-1 downto 0);
         variable spo_tmp   : std_logic_vector(C_WIDTH-1 downto 0);
         variable dpo_tmp   : std_logic_vector(C_WIDTH-1 downto 0);
         variable srl_start : integer := 0;
         variable srl_end   : integer := 0;
--              

         function add_std_logic_vec( arg1, arg2 : std_logic_vector; size : integer ) return std_logic_vector is
            variable S : std_logic_vector(size-1 downto 0) := (others => '0');
            variable C : std_logic_vector(size-1 downto 0) := (others => '0');
            variable A : std_logic;
            variable B : std_logic;
         begin
            for i in 0 to size-2 loop
               if( i < arg1'length ) then
                  A := arg1(i);
               else
                  A := '0';
               end if;
               if( i < arg2'length ) then
                  B := arg2(i);
               else
                  B := '0';
               end if;
               S(i)   := A xor B;
               C(i+1) := (A and B) or (S(i) and C(i));
               S(i)   := S(i) xor C(i);
            end loop;
            return S;
         end add_std_logic_vec;
-- 
         function mul_std_logic_vec( arg1, arg2 : std_logic_vector; size : integer ) return std_logic_vector is
            variable M : std_logic_vector(size-1 downto 0) := (others => '0');
            variable A : std_logic_vector(size-1 downto 0);
         begin
            for i in 0 to arg2'length-1 loop
               if arg2(i) = '1' then
                  A := (others => '0');
                  for j in 0 to arg1'length-1 loop
                     if( i+j < size ) then
                        A(i+j) := arg1(j);
                     end if;
                  end loop;
                  M := add_std_logic_vec( M, A, size );
               end if;
            end loop;
            return M;
         end mul_std_logic_vec;
--
         function decstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable BIN    : std_logic_vector(3 downto 0);
            constant TEN    : std_logic_vector(3 downto 0)      := (3      => '1', 1 => '1', others => '0');
            variable MULT10 : std_logic_vector(size-1 downto 0) := std_logic_vector(to_unsigned(1, size));
            variable MULT   : std_logic_vector(size-1 downto 0);
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => BIN := (others => '0');
                  when '1'    => BIN := (0 => '1', others => '0');
                  when '2'    => BIN := (1 => '1', others => '0');
                  when '3'    => BIN := (0 => '1', 1 => '1', others => '0');
                  when '4'    => BIN := (2 => '1', others => '0');
                  when '5'    => BIN := (0 => '1', 2 => '1', others => '0');
                  when '6'    => BIN := (1 => '1', 2 => '1', others => '0');
                  when '7'    => BIN := (3 => '0', others => '1');
                  when '8'    => BIN := (3 => '1', others => '0');
                  when '9'    => BIN := (0 => '1', 3 => '1', others => '0');
                  when others =>
                     assert false
                        report "NOT A DECIMAL CHARACTER" severity error;
                     RESULT := (others => 'X');
                     return RESULT;
               end case;
               MULT   := mul_std_logic_vec( MULT10, BIN, size);
               RESULT := add_std_logic_vec( RESULT, MULT, size);
               MULT10 := mul_std_logic_vec( MULT10, TEN, size );
            end loop;
            return RESULT;
         end decstr_to_std_logic_vec;
--
         function binstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable INDEX  : integer                           := 0;
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => RESULT(INDEX) := '0';
                  when '1'    => RESULT(INDEX) := '1';
                  when others =>
                     assert false
                        report "NOT A BINARY CHARACTER" severity error;
                     RESULT(INDEX) := 'X';
               end case;
               INDEX := INDEX + 1;
            end loop;
            return RESULT;
         end binstr_to_std_logic_vec;
--
         function hexstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable BIN    : std_logic_vector(3 downto 0);
            variable INDEX  : integer                           := 0;
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => BIN := (others => '0');
                  when '1'    => BIN := (0 => '1', others => '0');
                  when '2'    => BIN := (1 => '1', others => '0');
                  when '3'    => BIN := (0 => '1', 1 => '1', others => '0');
                  when '4'    => BIN := (2 => '1', others => '0');
                  when '5'    => BIN := (0 => '1', 2 => '1', others => '0');
                  when '6'    => BIN := (1 => '1', 2 => '1', others => '0');
                  when '7'    => BIN := (3 => '0', others => '1');
                  when '8'    => BIN := (3 => '1', others => '0');
                  when '9'    => BIN := (0 => '1', 3 => '1', others => '0');
                  when 'A'    => BIN := (0 => '0', 2 => '0', others => '1');
                  when 'a'    => BIN := (0 => '0', 2 => '0', others => '1');
                  when 'B'    => BIN := (2 => '0', others => '1');
                  when 'b'    => BIN := (2 => '0', others => '1');
                  when 'C'    => BIN := (0 => '0', 1 => '0', others => '1');
                  when 'c'    => BIN := (0 => '0', 1 => '0', others => '1');
                  when 'D'    => BIN := (1 => '0', others => '1');
                  when 'd'    => BIN := (1 => '0', others => '1');
                  when 'E'    => BIN := (0 => '0', others => '1');
                  when 'e'    => BIN := (0 => '0', others => '1');
                  when 'F'    => BIN := (others => '1');
                  when 'f'    => BIN := (others => '1');
                  when others =>
                     assert false
                        report "NOT A HEX CHARACTER" severity error;
                     for j in 0 to 3 loop
                        BIN(j) := 'X';
                     end loop;
               end case;
               for j in 0 to 3 loop
                  if (INDEX*4)+j < size then
                     RESULT((INDEX*4)+j) := BIN(j);
                  end if;
               end loop;
               INDEX := INDEX + 1;
            end loop;
            return RESULT;
         end hexstr_to_std_logic_vec;
--
      begin

         -- Startup section reads and/or writes mif file if necessary.
         
         if (first) then
            def_data(C_WIDTH-1 downto 0) := (others => '0');
            case radix is
               when 3 =>
                  def_data := decstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
               when 2 =>
                  def_data := binstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
               when 1 =>
                  def_data := hexstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
               when others =>
                  assert false
                     report "BAD DATA RADIX" severity error;
            end case;

            if( C_READ_MIF = 1 ) then
               read_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, lineno);
            end if;
            offset := lineno*C_WIDTH;
            while (lineno < C_DEPTH) loop
               for i in 0 to C_WIDTH-1 loop
                  memdvect(offset+i) := def_data(i);
               end loop;
               lineno := lineno+1;
               offset := offset+C_WIDTH;
            end loop;
            spo_tmp := (others => '0');
            dpo_tmp := (others => '0');

            if (C_GENERATE_MIF = 1) then
               write_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, 0);
            end if;

            for i in 0 to C_DEPTH -1 loop
               for j in 0 to C_WIDTH-1 loop
                  shift(i)(j) := memdvect(j + i*C_WIDTH);
               end loop;
            end loop;
            if (anyX(intA)) then
               shift_out <= (others => 'X');
            elsif (std_logic_vector_2_posint(intA) >= rdeep) then
               shift_out <= (others => 'X');  -- DLUNN MODIFIED FROM '0' FOR ILLEGAL ADDRESSING
            else
               shift_out <= shift(std_logic_vector_2_posint(intA));
            end if;

            first := false;
         else                           -- Not FIRST
            if (CLK'event and int_CE = '1' and CLK'last_value = '0' and CLK = '1') then  -- rising edge!
               for i in rdeep-1 downto 1 loop
                  shift(i) := shift(i-1);
               end loop;
               shift(0) := D;
            elsif (CLK'event and (int_CE = 'X' or
                                  (CLK'last_value = '0' and CLK = 'X') or
                                  (CLK'last_value = 'X' and CLK = '1'))) then
               for i in 0 to rdeep-1 loop
                  shift(i) := (others => 'X');
               end loop;
            end if;
            if (anyX(intA)) then
               shift_out <= (others => 'X');
            elsif (std_logic_vector_2_posint(intA) >= rdeep) then
               shift_out <= (others => 'X');  -- DLUNN MODIFIED FROM '0' FOR ILLEGAL ADDRESSING
            else
               shift_out <= shift(std_logic_vector_2_posint(intA));
            end if;
         end if;
      end process;
   end generate;

-- The lossy version requires some assesment of which value to
-- feed into the last sixteen locations.
   lossy : if (C_SHIFT_TYPE = c_variable_lossy) generate
      reged : if (C_REG_LAST_BIT = 1) generate
         qout : C_REG_FD_V5_0
            generic map (C_AINIT_VAL     => C_AINIT_VAL,
                         C_HAS_ACLR      => C_HAS_ACLR,
                         C_HAS_AINIT     => C_HAS_AINIT,
                         C_HAS_ASET      => C_HAS_ASET,
                         C_HAS_CE        => C_HAS_CE,
                         C_HAS_SCLR      => C_HAS_SCLR,
                         C_HAS_SINIT     => C_HAS_SINIT,
                         C_HAS_SSET      => C_HAS_SSET,
                         C_SINIT_VAL     => C_SINIT_VAL,
                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                         C_WIDTH         => C_WIDTH) 
            port map (D     => shift_out,
                      CLK   => CLK,
                      CE    => int_CE,
                      ACLR  => ACLR,
                      ASET  => ASET,
                      AINIT => AINIT,
                      SCLR  => SCLR,
                      SSET  => SSET,
                      SINIT => SINIT,
                      Q     => Q);     
      end generate;
      unreg : if not (C_REG_LAST_BIT = 1) generate
         Q <= shift_out;
      end generate;


      process (CLK, intA)
         variable rdeep     : integer                      := getRealDepth(C_DEPTH);
         type     shifttype is array(0 to rdeep-1) of std_logic_vector(C_WIDTH-1 downto 0);
         variable first     : boolean                      := true;
         variable shift     : shifttype;
         variable last16    : integer;
         variable addtop    : std_logic_vector(C_ADDR_WIDTH-1 downto 4*boolean'pos(C_ADDR_WIDTH > 4));
         variable addlow    : std_logic_vector(3 downto 0) := (others => '0');
         variable addti     : integer;
         constant mem_bits  : integer                      := C_DEPTH * C_WIDTH;
         variable memdvect  : std_logic_vector(mem_bits-1 downto 0);
         variable bits_good : boolean;
         variable lineno    : integer                      := 0;
         variable offset    : integer                      := 0;
         variable def_data  : std_logic_vector(C_WIDTH-1 downto 0);
         variable spo_tmp   : std_logic_vector(C_WIDTH-1 downto 0);
         variable dpo_tmp   : std_logic_vector(C_WIDTH-1 downto 0);
         variable srl_start : integer                      := 0;
         variable srl_end   : integer                      := 0;
--              

         function add_std_logic_vec( arg1, arg2 : std_logic_vector; size : integer ) return std_logic_vector is
            variable S : std_logic_vector(size-1 downto 0) := (others => '0');
            variable C : std_logic_vector(size-1 downto 0) := (others => '0');
            variable A : std_logic;
            variable B : std_logic;
         begin
            for i in 0 to size-2 loop
               if( i < arg1'length ) then
                  A := arg1(i);
               else
                  A := '0';
               end if;
               if( i < arg2'length ) then
                  B := arg2(i);
               else
                  B := '0';
               end if;
               S(i)   := A xor B;
               C(i+1) := (A and B) or (S(i) and C(i));
               S(i)   := S(i) xor C(i);
            end loop;
            return S;
         end add_std_logic_vec;
-- 
         function mul_std_logic_vec( arg1, arg2 : std_logic_vector; size : integer ) return std_logic_vector is
            variable M : std_logic_vector(size-1 downto 0) := (others => '0');
            variable A : std_logic_vector(size-1 downto 0);
         begin
            for i in 0 to arg2'length-1 loop
               if arg2(i) = '1' then
                  A := (others => '0');
                  for j in 0 to arg1'length-1 loop
                     if( i+j < size ) then
                        A(i+j) := arg1(j);
                     end if;
                  end loop;
                  M := add_std_logic_vec( M, A, size );
               end if;
            end loop;
            return M;
         end mul_std_logic_vec;
--
         function decstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable BIN    : std_logic_vector(3 downto 0);
            constant TEN    : std_logic_vector(3 downto 0)      := (3      => '1', 1 => '1', others => '0');
            variable MULT10 : std_logic_vector(size-1 downto 0) := std_logic_vector(to_unsigned(1, size));
            variable MULT   : std_logic_vector(size-1 downto 0);
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => BIN := (others => '0');
                  when '1'    => BIN := (0 => '1', others => '0');
                  when '2'    => BIN := (1 => '1', others => '0');
                  when '3'    => BIN := (0 => '1', 1 => '1', others => '0');
                  when '4'    => BIN := (2 => '1', others => '0');
                  when '5'    => BIN := (0 => '1', 2 => '1', others => '0');
                  when '6'    => BIN := (1 => '1', 2 => '1', others => '0');
                  when '7'    => BIN := (3 => '0', others => '1');
                  when '8'    => BIN := (3 => '1', others => '0');
                  when '9'    => BIN := (0 => '1', 3 => '1', others => '0');
                  when others =>
                     assert false
                        report "NOT A DECIMAL CHARACTER" severity error;
                     RESULT := (others => 'X');
                     return RESULT;
               end case;
               MULT   := mul_std_logic_vec( MULT10, BIN, size);
               RESULT := add_std_logic_vec( RESULT, MULT, size);
               MULT10 := mul_std_logic_vec( MULT10, TEN, size );
            end loop;
            return RESULT;
         end decstr_to_std_logic_vec;
--
         function binstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable INDEX  : integer                           := 0;
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => RESULT(INDEX) := '0';
                  when '1'    => RESULT(INDEX) := '1';
                  when others =>
                     assert false
                        report "NOT A BINARY CHARACTER" severity error;
                     RESULT(INDEX) := 'X';
               end case;
               INDEX := INDEX + 1;
            end loop;
            return RESULT;
         end binstr_to_std_logic_vec;
--
         function hexstr_to_std_logic_vec( arg1 : string; size : integer ) return std_logic_vector is
            variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
            variable BIN    : std_logic_vector(3 downto 0);
            variable INDEX  : integer                           := 0;
         begin
            for i in arg1'reverse_range loop
               case arg1(i) is
                  when '0'    => BIN := (others => '0');
                  when '1'    => BIN := (0 => '1', others => '0');
                  when '2'    => BIN := (1 => '1', others => '0');
                  when '3'    => BIN := (0 => '1', 1 => '1', others => '0');
                  when '4'    => BIN := (2 => '1', others => '0');
                  when '5'    => BIN := (0 => '1', 2 => '1', others => '0');
                  when '6'    => BIN := (1 => '1', 2 => '1', others => '0');
                  when '7'    => BIN := (3 => '0', others => '1');
                  when '8'    => BIN := (3 => '1', others => '0');
                  when '9'    => BIN := (0 => '1', 3 => '1', others => '0');
                  when 'A'    => BIN := (0 => '0', 2 => '0', others => '1');
                  when 'a'    => BIN := (0 => '0', 2 => '0', others => '1');
                  when 'B'    => BIN := (2 => '0', others => '1');
                  when 'b'    => BIN := (2 => '0', others => '1');
                  when 'C'    => BIN := (0 => '0', 1 => '0', others => '1');
                  when 'c'    => BIN := (0 => '0', 1 => '0', others => '1');
                  when 'D'    => BIN := (1 => '0', others => '1');
                  when 'd'    => BIN := (1 => '0', others => '1');
                  when 'E'    => BIN := (0 => '0', others => '1');
                  when 'e'    => BIN := (0 => '0', others => '1');
                  when 'F'    => BIN := (others => '1');
                  when 'f'    => BIN := (others => '1');
                  when others =>
                     assert false
                        report "NOT A HEX CHARACTER" severity error;
                     for j in 0 to 3 loop
                        BIN(j) := 'X';
                     end loop;
               end case;
               for j in 0 to 3 loop
                  if (INDEX*4)+j < size then
                     RESULT((INDEX*4)+j) := BIN(j);
                  end if;
               end loop;
               INDEX := INDEX + 1;
            end loop;
            return RESULT;
         end hexstr_to_std_logic_vec;
--
      begin

         -- Startup section reads and/or writes mif file if necessary.
         
         if (first) then
            def_data(C_WIDTH-1 downto 0) := (others => '0');
            case radix is
               when 3 =>
                  def_data := decstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
               when 2 =>
                  def_data := binstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
               when 1 =>
                  def_data := hexstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
               when others =>
                  assert false
                     report "BAD DATA RADIX" severity error;
            end case;

            if( C_READ_MIF = 1 ) then
               read_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, lineno);
            end if;
            offset := lineno*C_WIDTH;
            while (lineno < C_DEPTH) loop
               for i in 0 to C_WIDTH-1 loop
                  memdvect(offset+i) := def_data(i);
               end loop;
               lineno := lineno+1;
               offset := offset+C_WIDTH;
            end loop;
            spo_tmp := (others => '0');
            dpo_tmp := (others => '0');

            if (C_GENERATE_MIF = 1) then
               write_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, 0);
            end if;

            for i in 0 to C_DEPTH -1 loop
               for j in 0 to C_WIDTH-1 loop
                  shift(i)(j) := memdvect(j + i*C_WIDTH);
               end loop;
            end loop;
            last16 := rdeep - 16;
            if(C_ADDR_WIDTH > 4) then
               addlow := intA(3 downto 0);
            else
               addlow(C_ADDR_WIDTH-1 downto 0) := intA;
            end if;
            if (anyX(addlow)) then
               shift_out <= (others => 'X');
            else
               shift_out <= shift(last16+std_logic_vector_2_posint(addlow));
            end if;
            first := false;
         else                           -- Not FIRST
            if(C_ADDR_WIDTH > 4) then
               addtop := intA(C_ADDR_WIDTH-1 downto 4*boolean'pos(C_ADDR_WIDTH > 4));
               addlow := intA(3 downto 0);
            else
               addlow(C_ADDR_WIDTH-1 downto 0) := intA;
               addtop                          := (others => '0');
            end if;
            if (CLK'event and int_CE = '1' and CLK'last_value = '0' and CLK = '1') then  -- rising edge!
               for i in rdeep-1 downto last16+1 loop
                  shift(i) := shift(i-1);
               end loop;
               if (anyX(addtop)) then
                  shift(last16) := (others => 'X');
               else
                  addti := std_logic_vector_2_posint(addtop)*16;
                  if(addti >= rdeep) then
                     shift(last16) := (others => 'X');  -- DLUNN MODIFIED FROM '0' FOR ILLEGAL ADDRESSING
                  elsif(addti = 0) then
                     shift(last16) := D;
                  else
                     shift(last16) := shift(addti-1);
                  end if;
               end if;
               for i in last16-1 downto 1 loop
                  shift(i) := shift(i-1);
               end loop;
               shift(0) := D;
            elsif (CLK'event and (int_CE = 'X' or
                                  (CLK'last_value = '0' and CLK = 'X') or
                                  (CLK'last_value = 'X' and CLK = '1'))) then
               for i in 0 to rdeep-1 loop
                  shift(i) := (others => 'X');
               end loop;
            end if;
            if (anyX(addlow)) then
               shift_out <= (others => 'X');
            else
               shift_out <= shift(last16+std_logic_vector_2_posint(addlow));
            end if;
         end if;
      end process;
   end generate;


end behavioral;
