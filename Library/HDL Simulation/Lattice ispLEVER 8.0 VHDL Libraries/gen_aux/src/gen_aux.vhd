-- -------------------------------------------------------------------- 
-- >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<< 
-- -------------------------------------------------------------------- 
-- Copyright (c) 2005 by Lattice Semiconductor Corporation 
-- -------------------------------------------------------------------- 
-- 
-- 
--                     Lattice Semiconductor Corporation 
--                     5555 NE Moore Court 
--                     Hillsboro, OR 97214 
--                     U.S.A 
-- 
--                     TEL: 1-800-Lattice (USA and Canada) 
--                          408-826-6000 (other locations) 
-- 
--                     web: http://www.latticesemi.com/ 
--                     email: techsupport@latticesemi.com 
-- 
-- -------------------------------------------------------------------- 
-- 
-- Component and definitions for primitives used by generic netlister
--  that are not in generics library
-- 
-- -------------------------------------------------------------------- 
-- 
-- Revision History : 


-- Component and definitions for primitives used by generic netlister
--  that are not in generics library

-- Component library 

library ieee;
use ieee.std_logic_1164.all;
package COMPONENTS is
   component G_VCC
      Port (  Y : Out   std_logic );
   end component;

   component G_GND
      Port (  Y : Out   std_logic );
   end component;

   component G_DPC
      Port (     CLK : In    std_logic;
                   D : In    std_logic;
                   P : In    std_logic;
                   C : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_DE
      Port (     CLK : In    std_logic;
                   D : In    std_logic;
                   E : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_DEPC
      Port (     CLK : In    std_logic;
                   D : In    std_logic;
                   E : In    std_logic;
                   P : In    std_logic;
                   C : In    std_logic;
                   Q : Out   std_logic );
   end component;


   component G_LATP
      Port (       D : In    std_logic;
                   P : In    std_logic;
                   E : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_LATC
      Port (       D : In    std_logic;
                   C : In    std_logic;
                   E : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_LATPC
      Port (       D : In    std_logic;
                   P : In    std_logic;
                   C : In    std_logic;
                   E : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_JKPC
      Port (     CLK : In    std_logic;
                   J : In    std_logic;
                   K : In    std_logic;
                   P : In    std_logic;
                   C : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_RSPC
      Port (     CLK : In    std_logic;
                   R : In    std_logic;
                   S : In    std_logic;
                   P : In    std_logic;
                   C : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_TPC
      Port (     CLK : In    std_logic;
                   T : In    std_logic;
                   P : In    std_logic;
                   C : In    std_logic;
                   Q : Out   std_logic );
   end component;

end COMPONENTS;


-- Entity/Architecture descriptions 

library ieee;
use ieee.std_logic_1164.all;
   entity G_VCC is
      port ( Y  : Out std_logic );
   end;

   architecture behavioral of G_VCC is
    begin
     Y <= '1';
   end behavioral;


library ieee;
use ieee.std_logic_1164.all;
   entity G_GND is
      port ( Y  : Out std_logic );
   end;

   architecture behavioral of G_GND is
    begin
     Y <= '0';
   end behavioral;


library ieee;
use ieee.std_logic_1164.all;
entity G_DPC is
      port (CLK,C,P,D : In  std_logic;
            Q       : Out std_logic );
end G_DPC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_DPC is
begin
  process(CLK,C,P)
    begin
      if C = '1' then
        Q <= '0';
      elsif P = '1' then
        Q <= '1';
      elsif rising_edge(CLK) then
        Q <= D AND D ;
      end if;
  end process;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
entity G_DE is
      port (CLK,E,D : In  std_logic;
            Q         : Out std_logic );
end G_DE;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_DE is
begin
  process(CLK,E)
    begin
      if rising_edge(CLK) then
        if E = '1' then
          Q <= D AND D ;
        end if;
      end if;
  end process;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
entity G_DEPC is
      port (CLK,P,E,C,D : In  std_logic;
            Q         : Out std_logic );
end G_DEPC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_DEPC is
begin
  process(CLK,C,P,E)
    begin
      if C = '1' then
        Q <= '0';
      elsif P = '1' then
        Q <= '1';
      elsif rising_edge(CLK) then
        if E = '1' then
          Q <= D AND D ;
        end if;
      end if;
  end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;
entity G_LATP is
      port (D, P, E : In  std_logic;
            Q   : Out std_logic );
end G_LATP;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_LATP is
begin
  process(P,E,D)
    begin
      if P = '1' then
	Q <= '1';
      elsif E = '1' then
	Q <= D;
      end if;
  end process;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
entity G_LATC is
      port (D, C, E : In  std_logic;
            Q   : Out std_logic );
end G_LATC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_LATC is
begin
  process(C,E,D)
    begin
      if C = '1' then
	Q <= '0';
      elsif E = '1' then
	Q <= D;
      end if;
  end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;
entity G_LATPC is
      port (D, P, C, E : In  std_logic;
            Q   : Out std_logic );
end G_LATPC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_LATPC is
begin
  process(C,P,E,D)
    begin
      if C = '1' then
	Q <= '0';
      elsif P = '1' then
	Q <= '1';
      elsif E = '1' then
	Q <= D;
      end if;
  end process;
end behavioral;



library ieee;
use ieee.std_logic_1164.all;
entity G_JKPC is
      port (CLK,J,K,C,P : In  std_logic;
            Q         : Out std_logic );
end G_JKPC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_JKPC is
begin
  process(CLK,C,P)
  variable Q_local:  std_logic;
    begin
      if C = '1' then
	Q_local := '0';
      elsif P = '1' then
	Q_local := '1';
      elsif rising_edge(CLK) then
	if J = '1' and K = '1' then
          Q_local := not Q_local ;
	elsif J = '1' and K = '0' then
          Q_local := '1';
	elsif J = '0' and K = '1' then
          Q_local := '0';
      	end if;
      end if;
      Q <= Q_local;
  end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;
entity G_RSPC is
      port (CLK,R,S,P,C : In  std_logic;
            Q       : Out std_logic );
end G_RSPC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_RSPC is
begin
  process(CLK,C,P)
    variable Q_local:  std_logic;
    begin
      if C = '1' then
	Q_local := '0';
      elsif P = '1' then
	Q_local := '1';
      elsif rising_edge(CLK) then
	if R = '1' and S = '1' then
          Q_local := 'X';
	elsif S = '1' and R = '0' then
          Q_local := '1';
	elsif S = '0' and R = '1' then
          Q_local := '0';
      	end if;
      end if;
      Q <= Q_local;
  end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;
entity G_TPC is
      port (CLK,C,P,T : In  std_logic;
            Q     :   Out std_logic );
end G_TPC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_TPC is
begin
  process(CLK,C,P)
    variable Q_local: std_logic;
    begin
      if C = '1' then
	Q_local := '0';
      elsif P = '1' then
	Q_local := '1';
      elsif rising_edge(CLK) then
	if T = '1' then
          Q_local := not Q_local ;
      	end if;
      end if;
      Q <= Q_local;
  end process;
end behavioral;

