-- $Id: prims_utils_v4_0.vhd,v 1.10 2008/09/08 20:05:48 akennedy Exp $
--
-- Filename - prims_utils_v4_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains some helper functions for baseblocks components

library IEEE;
library std;
library XilinxCoreLib;

package prims_utils_v4_0 is

   use IEEE.std_logic_1164.all;
   use IEEE.numeric_std.all;

   use std.textio.all;

   function checkEQN(eqn       : string) return string;
   function postfixeqn(eqn     : string) return string;
   function evalpfeqn ( pfeqn  : string; addr : integer ) return std_logic;
   function pfeqn2init ( pfeqn : string ) return std_logic_vector;
   function init2mint ( init   : integer ) return string;

   function bv_to_slv(bitsin    : bit_vector) return std_logic_vector;
   function str_to_slv(bitsin   : string) return std_logic_vector;
   function str_to_slv_0(bitsin : string; nbits : integer) return std_logic_vector;
   function str_to_slv_1(bitsin : string; nbits : integer) return std_logic_vector;
   function str_to_bv(bitsin    : string) return bit_vector;
   function b_to_sl(bitin       : bit) return std_logic;
   function char_to_sl(bitin    : character) return std_logic;
   function slv_to_bv(bitsin    : std_logic_vector) return bit_vector;
   function slv_to_str(bitsin   : std_logic_vector) return string;
   function sl_to_b(bitin       : std_logic) return bit;
   function sl_to_char(bitin    : std_logic) return character;

   function all_ones (i : integer) return integer;
   function all_Xs (i   : integer) return std_logic_vector;

   type log2array is array (0 to 128) of integer;
   constant log2 : log2array := (0, 0,
                                 1,
                                 2, 2,
                                 3, 3, 3, 3,
                                 4, 4, 4, 4, 4, 4, 4, 4,
                                 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
                                 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
                                 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
                                 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7);  

   use XilinxCoreLib.prims_constants_v4_0.all;

   component PIPELINE_V4_0
      generic (C_AINIT_VAL     : string  := "";
               C_HAS_ACLR      : integer := 0;
               C_HAS_AINIT     : integer := 0;
               C_HAS_ASET      : integer := 0;
               C_HAS_CE        : integer := 0;
               C_HAS_SCLR      : integer := 0;
               C_HAS_SINIT     : integer := 0;
               C_HAS_SSET      : integer := 0;
               C_PIPE_STAGES   : integer := 1;
               C_SINIT_VAL     : string  := "";
               C_SYNC_ENABLE   : integer := c_override;
               C_SYNC_PRIORITY : integer := c_clear;
               C_WIDTH         : integer := 16); 
      port (D     : in  std_logic_vector(C_WIDTH-1 downto 0);  -- Input value
            CLK   : in  std_logic := '0';  -- Clock
            CE    : in  std_logic := '1';  -- Clock Enable
            ACLR  : in  std_logic := '0';  -- Asynch clear.
            ASET  : in  std_logic := '0';  -- Asynch set.
            AINIT : in  std_logic := '0';  -- Asynch init.
            SCLR  : in  std_logic := '0';  -- Synch clear.
            SSET  : in  std_logic := '0';  -- Synch set.
            SINIT : in  std_logic := '0';  -- Synch init.
            Q     : out std_logic_vector(C_WIDTH-1 downto 0)); -- Output value
   end component;

end prims_utils_v4_0;

library IEEE;

package body prims_utils_v4_0 is

   use IEEE.std_logic_1164.all;
   use IEEE.numeric_std.all;

   function checkEQN(eqn : string) return string is
      variable tmpchr : character;
   begin
      if ( eqn = "" ) then 
         return "Null Eqn";
      end if;
      cloop : for i in 1 to eqn'length loop
         tmpchr := eqn(i);
         if ( tmpchr /= 'i' and
              tmpchr /= 'I' and
              tmpchr /= '0' and
              tmpchr /= '1' and
              tmpchr /= '2' and
              tmpchr /= '3' and
              tmpchr /= '(' and
                          tmpchr /= ')' and
              tmpchr /= '~' and
              tmpchr /= '*' and
              tmpchr /= '@' and
              tmpchr /= '+' and
              tmpchr /= ' ' and
              tmpchr /= ht and
              tmpchr /= cr and
              tmpchr /= lf and
              tmpchr /= nul ) then
            return ("Illegal character in Eqn string : " & tmpchr);
         end if;
      end loop cloop;
      return "";
   end checkEQN;

   function postfixeqn(eqn : string) return string is
      variable tok     : character;
      variable peektok : character;
      variable prefix  : string( 1 to eqn'length+1 );
      variable temp    : string( 1 to eqn'length+1 );
      variable postfix : string( 1 to eqn'length+1 );
      variable i       : integer := 1;
      variable prefixi : integer := 0;
      variable tempi   : integer := 0;
   begin
      cloop : while ( i <= eqn'length ) loop
         tok := eqn(i);
         if ( tok = '(' or tok = '~' ) then
                 tempi              := tempi+1;
                 temp(tempi)        := tok;
              elsif ( tok = 'i' or tok = 'I' ) then
                 i                  := i + 1;
                 tok                := eqn(i);
                 if ( tok /= '0' and tok /= '1' and
                      tok /= '2' and tok /= '3' ) then
                    assert( false )
                       report("Missing port number in Eqn : " & eqn )
                       severity error;
                    return "";
                 end if;
                 prefixi            := prefixi + 1;
                 prefix(prefixi)    := tok;
              elsif ( tok = '+' or tok = '@' ) then
                 if tempi > 0 then
                    peektok         := temp(tempi);
                 else
                    peektok         := nul;
                 end if;
                 while ( peektok = '~' or
                         peektok = '*' or
                         peektok = '+' or
                         peektok = '@' ) loop
                    prefixi         := prefixi + 1;
                    prefix(prefixi) := peektok;
                    tempi           := tempi - 1;
                    if tempi > 0 then
                       peektok      := temp(tempi);
                    else
                       peektok      := nul;
                    end if;
                 end loop;
                 tempi              := tempi + 1;
                 temp(tempi)        := tok;
              elsif ( tok = '*' ) then
                 if tempi > 0 then
                    peektok         := temp(tempi);
                 else
                    peektok         := nul;
                 end if;
                 while ( peektok = '~' or
                         peektok = '*' ) loop
                    prefixi         := prefixi + 1;
                    prefix(prefixi) := peektok;
                    tempi           := tempi - 1;
                    if tempi > 0 then
                       peektok      := temp(tempi);
                    else
                       peektok      := nul;
                    end if;
                 end loop;
                 tempi              := tempi + 1;
                 temp(tempi)        := tok;
              elsif ( tok = ')' ) then
            if tempi > 0 then
               tok   := temp(tempi);
               tempi := tempi - 1;
            else
               assert( false )
                  report( "Missing opening parenthesis in Eqn : " & eqn )
                  severity error;
               return "";
            end if;
            while ( tok /= '(' ) loop
                       prefixi := prefixi + 1;
                       prefix(prefixi) := tok;
                       if tempi > 0 then
                          tok := temp(tempi);
                          tempi := tempi - 1;
                       else
                          assert( false )
                             report( "Missing opening parenthesis in Eqn : " & eqn )
                             severity error;
                          return "";
                       end if;
                       end loop;
                       elsif ( tok /= ' ' and tok /= ht and
                               tok /= cr  and tok /= lf and
                               tok /= nul ) then
                          assert ( false )
                             report("Illegal character in Eqn string : " & tok )
                             severity error;
                          return "";
                       end if;
                       i := i + 1;
                       end loop cloop;
                       while tempi > 0 loop
                          if temp(tempi) = '(' then 
                                                assert( false )
                                                   report("Missing closing parenthesis in Eqn : " & eqn )
                                                   severity error;
                                                return "";
                                             end if;
                                             prefixi := prefixi + 1;
                                             prefix(prefixi) := temp(tempi);
                                             tempi := tempi - 1;
                                             end loop;
                                             tempi := 1;
                                             while tempi <= prefixi loop
                                                postfix(tempi) := prefix(tempi);
                                                tempi := tempi + 1;
                                             end loop;
                                             return postfix;
                                             end postfixeqn;
                                             
                                             function evalpfeqn ( pfeqn : string; addr : integer ) return std_logic is
                                                variable addr_slv : std_logic_vector( 3 downto 0 );
                                                variable tempchr  : character;
                                                variable i        : integer := 1;
                                                variable stack    : std_logic_vector( 1 to pfeqn'length );
                                                variable stacki   : integer := 0;
                                             begin
                                                if pfeqn = "" then
                                                   return 'X';
                                                end if;
                                                addr_slv := std_logic_vector( to_unsigned( addr, 4 ));
                                                tempchr := pfeqn(i);
                                                while i <= pfeqn'length and tempchr /= nul loop
                                                   case tempchr is
                                                      when '0' =>
                                                         stacki := stacki + 1;
                                                         stack(stacki) := addr_slv(0);
                                                      when '1' =>
                                                         stacki := stacki + 1;
                                                         stack(stacki) := addr_slv(1);
                                                      when '2' =>
                                                         stacki := stacki + 1;
                                                         stack(stacki) := addr_slv(2);
                                                      when '3' =>
                                                         stacki := stacki + 1;
                                                         stack(stacki) := addr_slv(3);
                                                      when '~' =>
                                                         if stacki > 0 then
                                                            stack(stacki) := not stack(stacki);
                                                         else
                                                            assert( false )
                                                               report( "Malformed Postfix Eqn at ~ : " & pfeqn )
                                                               severity error;
                                                            return 'X';
                                                         end if;
                                                      when '*' =>
                                                         if stacki > 1 then
                                                            stack(stacki-1) := IEEE.std_logic_1164."and"(stack(stacki-1),stack(stacki));
                                                            stacki := stacki - 1;
                                                         else
                                                            assert( false )
                                                               report( "Malformed Postfix Eqn at * : " & pfeqn )
                                                               severity error;
                                                            return 'X';
                                                         end if;
                                                      when '+' =>
                                                         if stacki > 1 then
                                                            stack(stacki-1) := IEEE.std_logic_1164."or"(stack(stacki-1),stack(stacki));
                                                            stacki := stacki - 1;
                                                         else
                                                            assert( false )
                                                               report( "Malformed Postfix Eqn at + : " & pfeqn )
                                                               severity error;
                                                            return 'X';
                                                         end if;
                                                      when '@' =>
                                                         if stacki > 1 then
                                                            stack(stacki-1) := IEEE.std_logic_1164."xor"(stack(stacki-1),stack(stacki));
                                                            stacki := stacki - 1;
                                                         else
                                                            assert( false )
                                                               report( "Malformed Postfix Eqn at @ : " & pfeqn )
                                                               severity error;
                                                            return 'X';
                                                         end if;
                                                      when others =>
                                                         assert( false )
                                                            report( "Malformed Postfix Eqn at " & tempchr & " : " & pfeqn )
                                                            severity error;
                                                         return 'X';
                                                   end case;
                                                   i := i + 1;
                                                   tempchr := pfeqn(i);
                                                end loop;
                                                if stacki > 1 then
                                                   assert ( false )
                                                      report( "Incomplete Postfix Eqn : " & pfeqn )
                                                      severity error;
                                                   return 'X';
                                                elsif stack(1) = 'U' then
                                                   return 'X';
                                                else
                                                   return stack(1);
                                                end if;
                                             end evalpfeqn;
                                             
                                             function pfeqn2init ( pfeqn : string ) return std_logic_vector is
                                                variable initval : std_logic_vector( 15 downto 0 );
                                             begin
                                                for i in 0 to 15 loop
                                                   initval( i ) := evalpfeqn( pfeqn, i );
                                                end loop;
                                                return initval;
                                             end pfeqn2init;
                                             
                                             function init2mint ( init : integer ) return string is
                                                variable init_slv : std_logic_vector( 15 downto 0 );
                                                variable mint     : string( 1 to 560 );
                                                variable min1     : string( 1 to 16 );
                                                variable min1i    : integer := 1;
                                                variable minti    : integer := 1;
                                                variable i        : integer;
                                                variable i_slv    : std_logic_vector( 3 downto 0 );
                                             begin
                                                init_slv := std_logic_vector( to_unsigned( init, 16 ));
                                                for i in 0 to 15 loop
                                                   if init_slv(i) = '1' then
                                                      i_slv := std_logic_vector( to_unsigned( i, 4 ));
                                                      for j in 1 to 16 loop
                                                         min1(j) := nul;
                                                      end loop;
                                                      min1i := 1;
                                                      if i_slv(0) = '0' then
                                                         min1(min1i) := '~';
                                                         min1i := min1i + 1;
                                                      end if;
                                                      min1(min1i) := 'i';
                                                      min1(min1i+1) := '0';
                                                      min1(min1i+2) := '*';
                                                      min1i := min1i + 3;
                                                      if i_slv(1) = '0' then
                                                         min1(min1i) := '~';
                                                         min1i := min1i + 1;
                                                      end if;
                                                      min1(min1i) := 'i';
                                                      min1(min1i+1) := '1';
                                                      min1(min1i+2) := '*';
                                                      min1i := min1i + 3;
                                                      if i_slv(2) = '0' then
                                                         min1(min1i) := '~';
                                                         min1i := min1i + 1;
                                                      end if;
                                                      min1(min1i) := 'i';
                                                      min1(min1i+1) := '2';
                                                      min1(min1i+2) := '*';
                                                      min1i := min1i + 3;
                                                      if i_slv(3) = '0' then
                                                         min1(min1i) := '~';
                                                         min1i := min1i + 1;
                                                      end if;
                                                      min1(min1i) := 'i';
                                                      min1(min1i+1) := '3';
                                                      min1i := min1i + 2;
                                                      if( minti > 1 ) then
                                                         mint(minti) := ' ';
                                                         mint(minti+1) := '+';
                                                         mint(minti+2) := ' ';
                                                         minti := minti + 3;
                                                      end if;
                                                      for j in 1 to 16 loop
                                                         if min1(j) /= nul then
                                                            mint( minti ) := min1(j);
                                                            minti := minti + 1;
                                                         end if;
                                                      end loop;
                                                   end if;
                                                end loop;
                                                return mint;
                                             end init2mint;
                                             
                                             function bv_to_slv(bitsin : bit_vector) return std_logic_vector is
                                                variable ret : std_logic_vector(bitsin'range);
                                             begin
                                                for i in bitsin'range loop
                                                   if bitsin(i) = '1' then
                                                      ret(i) := '1';
                                                   else
                                                      ret(i) := '0';
                                                   end if;
                                                end loop;
                                                
                                                return ret;
                                             end bv_to_slv;
                                             
                                             function str_to_slv(bitsin : string) return std_logic_vector is
                                                variable ret : std_logic_vector(bitsin'range);
                                             begin
                                                for i in bitsin'range loop
                                                   if bitsin(i) = '1' then
                                                      ret(i) := '1';
                                                   elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
                                                      ret(i) := 'X';
                                                   elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
                                                      ret(i) := 'Z';			
                                                   elsif (bitsin(i) = '0') then
                                                      ret(i) := '0';
                                                   end if;
                                                end loop;
                                                
                                                return ret;
                                             end str_to_slv;
                                             
                                             function str_to_slv_0(bitsin : string; nbits : integer) return std_logic_vector is
                                                variable ret : std_logic_vector(bitsin'range);
                                                -- String types range from 1 to len!!!
                                                variable ret0s : std_logic_vector(1 to nbits) := (others => '0');
                                                variable retpadded : std_logic_vector(1 to nbits) := (others => '0');
                                                variable offset : integer := 0;
                                             begin
                                                if(bitsin = "") then -- Make all '0's
                                                   return ret0s;
                                                end if;
                                                if(bitsin'length < nbits) then -- pad MSBs with '0's
                                                   offset := nbits - bitsin'length;
                                                   for i in bitsin'range loop
                                                      if bitsin(i) = '1' then
                                                         retpadded(i+offset) := '1';
                                                      elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
                                                         retpadded(i+offset) := 'X';
                                                      elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
                                                         retpadded(i+offset) := 'Z';			
                                                      elsif (bitsin(i) = '0') then
                                                         retpadded(i+offset) := '0';
                                                      end if;
                                                   end loop;
                                                   retpadded(1 to offset) := (others => '0');
                                                   return retpadded;
                                                end if;
                                                for i in bitsin'range loop
                                                   if bitsin(i) = '1' then
                                                      ret(i) := '1';
                                                   elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
                                                      ret(i) := 'X';
                                                   elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
                                                      ret(i) := 'Z';			
                                                   elsif (bitsin(i) = '0') then
                                                      ret(i) := '0';
                                                   end if;
                                                end loop;
                                                
                                                return ret;
                                             end str_to_slv_0;
                                             
                                             function str_to_slv_1(bitsin : string; nbits : integer) return std_logic_vector is
                                                variable ret : std_logic_vector(bitsin'range);
                                                -- String types range from 1 to len!!!
                                                variable ret1s : std_logic_vector(1 to nbits) := (others => '1');
                                                variable retpadded : std_logic_vector(1 to nbits) := (others => '1');
                                                variable offset : integer := 0;
                                             begin
                                                if(bitsin = "") then -- make all '1's
                                                   return ret1s;
                                                end if;
                                                if(bitsin'length < nbits) then -- pad MSBs with '1's
                                                   offset := nbits - bitsin'length;
                                                   for i in bitsin'range loop
                                                      if bitsin(i) = '1' then
                                                         retpadded(i+offset) := '1';
                                                      elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
                                                         retpadded(i+offset) := 'X';
                                                      elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
                                                         retpadded(i+offset) := 'Z';			
                                                      elsif (bitsin(i) = '0') then
                                                         retpadded(i+offset) := '0';
                                                      end if;
                                                   end loop;
                                                   retpadded(1 to offset) := (others => '1');
                                                   return retpadded;
                                                end if;
                                                for i in bitsin'range loop
                                                   if bitsin(i) = '1' then
                                                      ret(i) := '1';
                                                   elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
                                                      ret(i) := 'X';
                                                   elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
                                                      ret(i) := 'Z';			
                                                   elsif (bitsin(i) = '0') then
                                                      ret(i) := '0';
                                                   end if;
                                                end loop;
                                                
                                                return ret;
                                             end str_to_slv_1;
                                             
                                             function str_to_bv(bitsin : string) return bit_vector is
                                                variable ret : bit_vector(bitsin'range);
                                             begin
                                                for i in bitsin'range loop
                                                   if bitsin(i) = '1' then
                                                      ret(i) := '1';
                                                   elsif (bitsin(i) = '0') then
                                                      ret(i) := '0';
                                                   else
                                                      assert false
                                                         report "Cannot translate STR_TO_BV with unknowns in STR"
                                                         severity error;
                                                   end if;
                                                end loop;
                                                
                                                return ret;
                                             end str_to_bv;
                                             
                                             
                                             function b_to_sl(bitin : bit) return std_logic is
                                                variable ret : std_logic;
                                             begin
                                                if bitin = '1' then
                                                   ret := '1';
                                                else
                                                   ret := '0';
                                                end if;
                                                return ret;
                                             end b_to_sl;
                                             
                                             function char_to_sl(bitin : character) return std_logic is
                                                variable ret : std_logic;
                                             begin
                                                if bitin = '1' then
                                                   ret := '1';
                                                elsif bitin = 'X' or bitin = 'x' then
                                                   ret := 'X';
                                                elsif bitin = 'Z' or bitin = 'z' then
                                                   ret := 'Z';
                                                else
                                                   ret := '0';
                                                end if;
                                                return ret;
                                             end char_to_sl;
                                             
                                             
                                             function slv_to_bv(bitsin : std_logic_vector) return bit_vector is
                                                variable ret : bit_vector(bitsin'range);
                                             begin
                                                for i in bitsin'range loop
                                                   if bitsin(i) = '1' then
                                                      ret(i) := '1';
                                                   elsif bitsin(i) = '0' then
                                                      ret(i) := '0';
                                                   else
                                                      assert false
                                                         report "Cannot translate SLV_TO_BV with unknowns in SLV"
                                                         severity error;
                                                   end if;
                                                end loop;
                                                
                                                return ret;
                                             end slv_to_bv;
                                             
                                             
                                             function slv_to_str(bitsin : std_logic_vector) return string is
                                                variable ret : string(bitsin'range);
                                             begin
                                                for i in bitsin'range loop
                                                   if bitsin(i) = '1' then
                                                      ret(i) := '1';
                                                   elsif (bitsin(i) = 'X') then
                                                      ret(i) := 'X';
                                                   elsif (bitsin(i) = 'Z') then
                                                      ret(i) := 'Z';			
                                                   elsif (bitsin(i) = 'U') then
                                                      ret(i) := 'U';			
                                                   elsif (bitsin(i) = '0') then
                                                      ret(i) := '0';
                                                   end if;
                                                end loop;
                                                
                                                return ret;
                                             end slv_to_str;
                                             
                                             function sl_to_b(bitin : std_logic) return bit is
                                                variable ret : bit;
                                             begin
                                                if bitin = '1' then
                                                   ret := '1';
                                                else
                                                   ret := '0';
                                                end if;
                                                return ret;
                                             end sl_to_b;
                                             
                                             function sl_to_char(bitin : std_logic) return character is
                                                variable ret : character;
                                             begin
                                                if bitin = '1' then
                                                   ret := '1';
                                                elsif bitin = 'X' then
                                                   ret := 'X';
                                                elsif bitin = 'Z' then
                                                   ret := 'Z';
                                                elsif bitin = 'U' then
                                                   ret := 'U';
                                                else
                                                   ret := '0';
                                                end if;
                                                return ret;
                                             end sl_to_char;
                                             
                                             function all_ones(i : integer) return integer is
                                                variable stmp : std_logic_vector(i-1 downto 0);
                                                variable ret : integer := 0;
                                             begin
                                                assert ( i < 32 ) 
                                                   report "Function all_ones(i) only works for i < 32"
                                                   severity error;
                                                
                                                for j in 0 to i-1 loop
                                                   stmp(j) := '1';
                                                end loop;
                                                
                                                ret := to_integer(unsigned(stmp));
                                                return ret;
                                                
                                             end all_ones;
                                             
                                             function all_Xs(i : integer) return std_logic_vector is
                                                variable stmp : std_logic_vector(i-1 downto 0);
                                             begin
                                                for j in 0 to i-1 loop
                                                   stmp(j) := 'X';
                                                end loop;
                                                
                                                return stmp;
                                             end all_Xs;
                                             
                                             end prims_utils_v4_0;

                                             Library IEEE;
                                             Use IEEE.std_logic_1164.all;
                                             use IEEE.numeric_std.all;

                                             Library XilinxCoreLib;
                                             Use XilinxCoreLib.prims_utils_v4_0.all;
                                             use XilinxCoreLib.prims_constants_v4_0.all;

                                             entity PIPELINE_V4_0 is
                                                generic (C_AINIT_VAL     : string  := "";
                                                         C_HAS_ACLR      : integer := 0;
                                                         C_HAS_AINIT     : integer := 0;
                                                         C_HAS_ASET      : integer := 0;
                                                         C_HAS_CE        : integer := 0;
                                                         C_HAS_SCLR      : integer := 0;
                                                         C_HAS_SINIT     : integer := 0;
                                                         C_HAS_SSET      : integer := 0;
                                                         C_PIPE_STAGES   : integer := 1; 
                                                         C_SINIT_VAL     : string  := "";
                                                         C_SYNC_ENABLE   : integer := c_override; 
                                                         C_SYNC_PRIORITY : integer := c_clear;
                                                         C_WIDTH         : integer := 16); 
                                                port (D     : in  std_logic_vector(C_WIDTH-1 downto 0); -- Input value
                                                      CLK   : in  std_logic := '0'; -- Clock
                                                      CE    : in  std_logic := '1'; -- Clock Enable
                                                      ACLR  : in  std_logic := '0'; -- Asynch clear.
                                                      ASET  : in  std_logic := '0'; -- Asynch set.
                                                      AINIT : in  std_logic := '0'; -- Asynch init.
                                                      SCLR  : in  std_logic := '0'; -- Synch clear.
                                                      SSET  : in  std_logic := '0'; -- Synch set.
                                                      SINIT : in  std_logic := '0'; -- Synch init.
                                                      Q     : out std_logic_vector(C_WIDTH-1 downto 0)); -- Output value
                                             end PIPELINE_V4_0;

                                             architecture behavioral of PIPELINE_V4_0 is

                                                constant timeunit : time := 1 ns;

                                                signal intQ : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
                                                -- signals for optional pins...
                                                signal intCE    : std_logic;
                                                signal intACLR  : std_logic;
                                                signal intASET  : std_logic;
                                                signal intAINIT : std_logic;
                                                signal intSCLR  : std_logic;
                                                signal intSSET  : std_logic;
                                                signal intSINIT : std_logic;
                                                signal AIV      : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
                                                signal SIV      : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
                                                type   pltype is array(0 to C_PIPE_STAGES-1) of std_logic_vector(C_WIDTH-1 downto 0);
                                                

                                             begin

                                                nopipe: if C_PIPE_STAGES = 0 generate
                                                   Q <= D;
                                                end generate;
                                                haspipe: if C_PIPE_STAGES > 0 generate
                                                   -- Deal with optional pins...
                                                   ce1: if C_HAS_CE = 1 generate
                                                      intCE <= CE;
                                                   end generate;
                                                   ce0: if not (C_HAS_CE = 1) generate
                                                      intCE <= '1';
                                                   end generate;

                                                   aclr1: if C_HAS_ACLR = 1 generate
                                                      intACLR <= ACLR;
                                                   end generate;
                                                   aclr0: if not (C_HAS_ACLR = 1) generate
                                                      intACLR <= '0';
                                                   end generate;

                                                   aset1: if C_HAS_ASET = 1 generate
                                                      intASET <= ASET;
                                                   end generate;
                                                   aset0: if not (C_HAS_ASET = 1) generate
                                                      intASET <= '0';
                                                   end generate;

                                                   ainit1: if C_HAS_AINIT = 1 generate
                                                      intAINIT <= AINIT;
                                                      AIV      <= str_to_slv_0(C_AINIT_VAL, C_WIDTH);
                                                   end generate;
                                                   ainit0: if not (C_HAS_AINIT = 1) generate
                                                      intAINIT <= '0';
                                                   end generate;

                                                   sclr1: if C_HAS_SCLR = 1 generate
                                                      intSCLR <= SCLR;
                                                   end generate;
                                                   sclr0: if not (C_HAS_SCLR = 1) generate
                                                      intSCLR <= '0';
                                                   end generate;

                                                   sset1: if C_HAS_SSET = 1 generate
                                                      intSSET <= SSET;
                                                   end generate;
                                                   sset0: if not (C_HAS_SSET = 1) generate
                                                      intSSET <= '0';
                                                   end generate;

                                                   sinit1: if C_HAS_SINIT = 1 generate
                                                      intSINIT <= SINIT;
                                                      SIV      <= str_to_slv_0(C_SINIT_VAL, C_WIDTH);
                                                   end generate;
                                                   sinit0: if not (C_HAS_SINIT = 1) generate
                                                      intSINIT <= '0';
                                                   end generate;

                                                   p1 : process(CLK, intCE, intACLR, intASET, intAINIT, intSCLR, intSSET, intSINIT)
                                                      variable FIRST      : boolean   := TRUE;
                                                      variable ACTIVE_CLK : std_logic;
                                                      variable SET_OR_CLR : std_logic := '0';
                                                      variable cetmp      : std_logic;
                                                      variable pipeliner  : pltype;
                                                   begin

                                                      if FIRST then
                                                         -- Define power-up value
                                                         if C_HAS_ACLR = 1 then
                                                            intQ <= (others => '0');
                                                         elsif C_HAS_ASET = 1 then
                                                            intQ <= (others => '1');
                                                         elsif C_HAS_AINIT = 1 then
                                                            intQ <= AIV;
                                                         elsif (C_HAS_SCLR = 1) or (C_HAS_SSET = 1)  or (C_HAS_SINIT = 1)then
                                                            intQ <= (others => '0');
                                                         else
                                                            intQ <= AIV;
                                                         end if;

                                                         if C_SYNC_PRIORITY = 0 then 
                                                            SET_OR_CLR := '0'; -- use SSET
                                                         else -- c_clear
                                                            SET_OR_CLR := '1'; -- use SCLR
                                                         end if;

                                                         for i in 0 to C_PIPE_STAGES-1 loop
                                                            pipeliner(i) := (others => '0');
                                                         end loop;

                                                         ACTIVE_CLK := '1';

                                                         FIRST := FALSE;

                                                      else -- Not FIRST
                                                         -- deal with synchronous events first
                                                         if (CLK'event and CLK'last_value = '0' and CLK = '1') then -- rising edge!
                                                            -- First the pipeline
                                                            if (intCE = 'X') then
                                                               for i in 0 to C_PIPE_STAGES-1 loop
                                                                  pipeliner(i) := (others => 'X');
                                                               end loop;
                                                            elsif (intCE = '1') then
                                                               for i in C_PIPE_STAGES-1 downto 1 loop
                                                                  pipeliner(i) := pipeliner(i-1);
                                                               end loop;
                                                            end if;
                                                            
                                                            -- Unqualified behaviour
                                                            if (intCE = '1') then -- Enabled
                                                               pipeliner(0) := D;
                                                            end if;
                                                            
                                                            -- Synchronous controls 
                                                            if (C_SYNC_ENABLE = 0) then
                                                               cetmp := '1';
                                                            else
                                                               cetmp := intCE;
                                                            end if;
                                                            if (cetmp = '1') then
                                                               if ((SET_OR_CLR = '0' and intSSET = 'X')  or 
                                                                   (SET_OR_CLR = '1' and intSCLR = 'X')  or
                                                                   intSINIT = 'X') then
                                                                  pipeliner(0) := (others => 'X');
                                                               elsif (intSINIT = '1') then                                        --Synchronous init
                                                                  pipeliner(0) := SIV;
                                                               elsif (intSCLR = '1' and (SET_OR_CLR = '1' or intSSET = '0')) then --Synchronous clear
                                                                  pipeliner(0) := (others => '0');
                                                               elsif (intSSET = '1' and (SET_OR_CLR = '0' or intSCLR = '0')) then --Synchronous set
                                                                  pipeliner(0) := (others => '1');
                                                               end if;
                                                            end if;
                                                            
                                                         elsif (CLK'event and ((CLK'last_value = '0' and CLK = 'X') or 
                                                                               (CLK'last_value = 'X' and CLK = '1'))) then
                                                            if (intCE /= '0') then
                                                               for i in 0 to C_PIPE_STAGES-1 loop
                                                                  pipeliner(i) := (others => 'X');
                                                               end loop;
                                                            elsif (C_SYNC_ENABLE = 0) then
                                                               pipeliner(0) := (others => 'X');
                                                            end if;
                                                         end if;

                                                         -- Asynchronous Controls
                                                         if intACLR = 'X' then
                                                            pipeliner(C_PIPE_STAGES-1) := (others => 'X');
                                                         elsif intACLR = '1' then -- asynch clear
                                                            pipeliner(C_PIPE_STAGES-1) := (others => '0');
                                                         elsif intACLR = '0' and intASET = 'X' then
                                                            pipeliner(C_PIPE_STAGES-1) := (others => 'X');
                                                         elsif intACLR = '0' and intASET = '1' then -- asynch set
                                                            pipeliner(C_PIPE_STAGES-1) := (others => '1');
                                                         elsif intAINIT = 'X' then
                                                            pipeliner(C_PIPE_STAGES-1) := (others => 'X');
                                                         elsif intAINIT = '1' then -- Asynch init
                                                            pipeliner(C_PIPE_STAGES-1) := AIV;
                                                         end if; 
                                                         
                                                         intQ <= pipeliner(C_PIPE_STAGES-1);
                                                      end if; -- FIRST
                                                   end process;
                                                   
                                                   Q <= intQ after timeunit;
                                                   
                                                end generate;

                                             end behavioral;
