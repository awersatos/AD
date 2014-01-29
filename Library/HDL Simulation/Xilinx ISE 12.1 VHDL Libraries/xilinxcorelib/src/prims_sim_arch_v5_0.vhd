-- $Id: prims_sim_arch_v5_0.vhd,v 1.18 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - prims_sim_arch_v5_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains the entity-architecture(behav) pairs for
--                               baseblocks primitives.


library XilinxCoreLib;
use XilinxCoreLib.prims_comps_v5_0.all;
use XilinxCoreLib.prims_utils_v5_0.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity C_LUT_V5_0 
-- Source for behavior = Hand crafted 

entity C_LUT_V5_0 is
   generic (
      init : in integer := 0;
      eqn  : in string  := "";
      c_enable_rlocs : in boolean := false
      );
   port( I0         : in  std_ulogic;
         I1, I2, I3 : in  std_ulogic := '0';
         O          : out std_ulogic
         );
end C_LUT_V5_0;

architecture behavioral of C_LUT_V5_0 is


   signal initsig : std_logic_vector(15 downto 0);
   signal once    : std_logic := '0';
begin

   one : process
      variable init4eqn : std_logic_vector( 15 downto 0);
   begin
      if( once = '0' ) then
         if ( eqn = "" ) then
            assert init /= 0
               report ("Constant 0 output. Use init or eqn generics to set xlut function.")
               severity warning;
            initsig <= std_logic_vector(to_unsigned(init, 16));
         else
            assert init = 0
               report ("Both eqn and init generics set. Using eqn.")
               severity warning;
            assert checkEQN(eqn) = "" 
               report checkEQN(eqn)
               severity failure;
            init4eqn := pfeqn2init( postfixeqn(eqn) );
            assert not Is_X( init4eqn )
               severity failure;
            initsig <= init4eqn;
         end if;
         once <= '1';
      end if;
      wait;
   end process one;

   p : process
      variable addr_slv            : std_logic_vector(3 downto 0);
      variable addr                : integer range 0 to 15;
      variable poss_addrs0         : std_logic_vector(0 to 15) := (others => '0');  -- '0' signals impossible address
      variable poss_addrs1         : std_logic_vector(0 to 15) := (others => '0');  -- '0' signals impossible address
      variable poss_addrs2         : std_logic_vector(0 to 15) := (others => '0');  -- '0' signals impossible address
      variable poss_addrs3         : std_logic_vector(0 to 15) := (others => '0');  -- '0' signals impossible address
      variable poss_addrs_combined : std_logic_vector(0 to 15) := (others => '0');  -- '0' signals impossible address
      variable tmpsig              : std_logic                 := '0';
      variable i, j                : integer;
   begin
      if( once = '0') then
         wait on initsig;
      end if;
      addr_slv := (I3, I2, I1, I0);
      if((I0 /= '1' and I0 /= '0') or
         (I1 /= '1' and I1 /= '0') or
         (I2 /= '1' and I2 /= '0') or
         (I3 /= '1' and I3 /= '0')) then
         -- pessimistically, the output should be 'X' but imagine an OR gate with any one input = 1 for example!
         -- O <= 'X' after 1 ns;

         -- Realistic solution: Build up an array of possible addr values for given inputs and check all possible outputs
         -- If all possible outputs are equal then that output should appear!

         case I0 is
            when '0'    => poss_addrs0 := (0|2|4|6|8|10|12|14 => '1', others => '0');
            when '1'    => poss_addrs0 := (1|3|5|7|9|11|13|15 => '1', others => '0');
            when others => poss_addrs0 := (others => '1');
         end case;
         case I1 is
            when '0'    => poss_addrs1 := (0|1|4|5|8|9|12|13 => '1', others => '0');
            when '1'    => poss_addrs1 := (2|3|6|7|10|11|14|15 => '1', others => '0');
            when others => poss_addrs1 := (others => '1');
         end case;
         case I2 is
            when '0'    => poss_addrs2 := (0|1|2|3|8|9|10|11 => '1', others => '0');
            when '1'    => poss_addrs2 := (4|5|6|7|12|13|14|15 => '1', others => '0');
            when others => poss_addrs2 := (others => '1');
         end case;
         case I3 is
            when '0'    => poss_addrs3 := (0|1|2|3|4|5|6|7 => '1', others => '0');
            when '1'    => poss_addrs3 := (8|9|10|11|12|13|14|15 => '1', others => '0');
            when others => poss_addrs3 := (others => '1');
         end case;
         -- Now gather all the addresses which are possible
         for i in 0 to 15 loop
            if(poss_addrs0(i) = '1' and poss_addrs1(i) = '1' and poss_addrs2(i) = '1' and poss_addrs3(i) = '1') then
               poss_addrs_combined(i) := '1';
            else
               poss_addrs_combined(i) := '0';
            end if;
         end loop;
         -- Now find the first possible address and the initsig at that address
         i := 0;
         while poss_addrs_combined(i) /= '1' loop
            i := i + 1;
         end loop;
         -- i is the lowest possible address
         tmpsig := initsig(i);
         j      := i;
         -- now check all the other possible addresses
         for i in j+1 to 15 loop
            if poss_addrs_combined(i) = '1' then
               if(tmpsig /= initsig(i)) then
                  tmpsig := 'X';
               end if;
            end if;
         end loop;
         O <= tmpsig;
         
      else
         addr := to_integer(unsigned('0' & addr_slv));
         O    <= initsig(addr) after 1 ns;
      end if;
      wait on I0, I1, I2, I3;
   end process;

end behavioral;

configuration cfg_lut of C_LUT_V5_0 is
   for behavioral
   end for;
end cfg_lut;


-------------------------------------------------------------

