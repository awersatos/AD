-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Function Simulation Library Component
--  /   /                  Fast Carry Logic with Look Ahead
-- /___/   /\     Filename : CARRY4.vhd
-- \   \  /  \    Timestamp : Fri Mar 26 08:18:19 PST 2004
--  \___\/\___\
-- Revision:
--    04/11/05 - Initial version.
--    05/06/05 - Unused CYINT or CI pin need grounded instead of open (CR207752)
--    05/31/05 - Change pin order, remove connection check for CYINT and CI.
-- End Revision

----- CELL CARRY4 -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CARRY4 is

  port(
      CO          : out std_logic_vector(3 downto 0);
      O           : out std_logic_vector(3 downto 0);
    
      CI          : in  std_ulogic;
      CYINIT      : in  std_ulogic;
      DI          : in std_logic_vector(3 downto 0);
      S           : in std_logic_vector(3 downto 0)
      );

end CARRY4;

architecture CARRY4_V OF CARRY4 is

  signal ci_or_cyinit : std_ulogic;
  signal CO_out : std_logic_vector(3 downto 0);
begin

  O <= S xor ( CO_out(2 downto 0) & ci_or_cyinit );
  CO <= CO_out;

  CO_out(0) <= ci_or_cyinit when S(0) = '1' else DI(0); 
  CO_out(1) <= CO_out(0) when S(1) = '1' else DI(1); 
  CO_out(2) <= CO_out(1) when S(2) = '1' else DI(2); 
  CO_out(3) <= CO_out(2) when S(3) = '1' else DI(3); 
  ci_or_cyinit <= CI or CYINIT;

--  ci_sel : process (CYINIT , CI)
--  begin
--      if(CYINIT = 'U' or CYINIT = 'Z' or CYINIT = 'X') then
--         assert FALSE report
--            "Error : CARRY4 instance detects CYINIT unconnected. Only one of CI and CYINIT inputs can be used and other one need grounded."
--             severity failure;
--      elsif (CI = 'U' or CI = 'Z' or CI = 'X') then
--         assert FALSE report
--            "Error : CARRY4 instance detects CI unconnected. Only one of CI and CYINIT inputs can be used and other one need grounded."
--             severity failure;
--      else
--         ci_or_cyinit <= CI or CYINIT;
--      end if;
--
--   end process ci_sel;

end CARRY4_V;

