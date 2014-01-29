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
-- Copyright (c) 1994 by Data I/O Corporation.  All rights reserved.
-- 
-- VHDL Library for Synario Generic Symbols.

-- ----------------------------------------
-- Package for all library componenets
-- ----------------------------------------

library ieee;
use ieee.std_logic_1164.all;
package COMPONENTS is

   component G_XOR 		--55
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_XNOR		--54
      Port (       A : In    std_logic;
                   B : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_INV		--53
      Port (       A : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_BUFB		--52
      Port (      AN : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_BUF		--51
      Port (       A : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4OR4		--50
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                  DN : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4OR3		--49
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4OR2		--48
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4OR1		--47
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4OR		--46
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4NOR4	--45
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                  DN : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NOR3	--44
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NOR2	--43
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NOR1	--42
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NOR		--41
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NAND4	--40
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                  DN : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NAND3	--39
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NAND2	--38
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NAND1	--37
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4NAND	--36
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_4AND4	--35
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                  DN : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4AND3	--34
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4AND2	--33
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4AND1	--32
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_4AND		--31
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3OR3		--30
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3OR2		--29
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3OR1		--28
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3OR		--27
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3NOR3	--26
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3NOR2	--25
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3NOR1	--24
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3NOR		--23
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3NAND3	--22
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3NAND2	--21
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3NAND1	--20
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3NAND	--19
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_3AND3	--18
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  CN : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3AND2	--17
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3AND1	--16
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_3AND		--15
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_2OR2		--14
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_2OR1		--13
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_2OR		--12
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_2NOR2	--11
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_2NOR1	--10
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_2NOR		--9
      Port (       A : In    std_logic;
                   B : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_2NAND2	--8
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_2NAND1	--7
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_2NAND	--6
      Port (       A : In    std_logic;
                   B : In    std_logic;
                  YN : Out   std_logic );
   end component;

   component G_2AND2	--5
      Port (      AN : In    std_logic;
                  BN : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_2AND1	--4
      Port (      AN : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_2AND		--3
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_TP		--78
      Port (     CLK : In    std_logic;
                   P : In    std_logic;
                   T : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_TC		--77
      Port (     CLK : In    std_logic;
                   C : In    std_logic;
                   T : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_T		--76
      Port (     CLK : In    std_logic;
                   T : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_RSP		--75
      Port (     CLK : In    std_logic;
                   P : In    std_logic;
                   R : In    std_logic;
                   S : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_RSC		--74
      Port (       C : In    std_logic;
                 CLK : In    std_logic;
                   R : In    std_logic;
                   S : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_RS		--73
      Port (     CLK : In    std_logic;
                   R : In    std_logic;
                   S : In    std_logic;
                   Q : Out   std_logic );
   end component;


   component G_LATCH	--72
      Port (       D : In    std_logic;
                   E : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_JKP		--71
      Port (     CLK : In    std_logic;
                   J : In    std_logic;
                   K : In    std_logic;
                   P : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_JKC		--70
      Port (       C : In    std_logic;
                 CLK : In    std_logic;
                   J : In    std_logic;
                   K : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_JK		--69
      Port (     CLK : In    std_logic;
                   J : In    std_logic;
                   K : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_DP		--68
      Port (     CLK : In    std_logic;
                   D : In    std_logic;
                   P : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_DEP		--67
      Port (     CLK : In    std_logic;
                   D : In    std_logic;
                   E : In    std_logic;
                   P : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_DEC		--66
      Port (       C : In    std_logic;
                 CLK : In    std_logic;
                   D : In    std_logic;
                   E : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_DC		--65
      Port (       C : In    std_logic;
                 CLK : In    std_logic;
                   D : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_D		--64
      Port (     CLK : In    std_logic;
                   D : In    std_logic;
                   Q : Out   std_logic );
   end component;

   component G_MUX81	--63
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   E : In    std_logic;
                   F : In    std_logic;
                   G : In    std_logic;
                   H : In    std_logic;
                  S0 : In    std_logic;
                  S1 : In    std_logic;
                  S2 : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_MUX41	--62
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                  S0 : In    std_logic;
                  S1 : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_MUX21	--61
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   S : In    std_logic;
                   Y : Out   std_logic );
   end component;

   component G_TRI		--60
      Port (       I : In    std_logic;
                  OE : In    std_logic;
                   O : Out   std_logic );
   end component;

   component G_OUTPUT	--59
      Port (       I : In    std_logic;
                   O : Out   std_logic );
   end component;

   component G_INPUT	--58
      Port (       I : In    std_logic;
                   O : Out   std_logic );
   end component;

   component G_CLKBUF	--57
      Port (       I : In    std_logic;
                   O : Out   std_logic );
   end component;

   component G_BIDIR	--56
      Port (       I : In    std_logic;
                  OE : In    std_logic;
                   O : InOut std_logic;
                 FBK : Out   std_logic );
   end component;


   component G_HADD		--2
      Port (       A : In    std_logic;
                   B : In    std_logic;
                  CO : Out   std_logic;
                 SUM : Out   std_logic );
   end component;

   component G_FADD		--1
      Port (       A : In    std_logic;
                   B : In    std_logic;
                  CI : In    std_logic;
                  CO : Out   std_logic;
                 SUM : Out   std_logic );
   end component;


end COMPONENTS;
-- ----------------------------------------
-- End Package for all generic componenets
-- ----------------------------------------

-- ---------------------------------------------------
-- Entity/Architecture descriptions for all components
-- ---------------------------------------------------

-- -------------------------
-- G_MUX21 		--61
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_MUX21 is
      port (A,B,S : In  std_logic;
            Y  : Out std_logic );
   end G_MUX21;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_MUX21 is
    begin
     Y <= (A and (not S)) or (B and S) ; 
   end behavioral;


-- -------------------------
-- G_MUX41 		--62
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_MUX41 is
      port (A,B,C,D : In  std_logic;
		  S1, S0 : In  std_logic;
                  Y : Out std_logic );
   end G_MUX41;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_MUX41 is
    begin
     P1: process(A,B,C,D,S1, S0)
     begin
      	if S1 = '0' then   
       		if S0 = '0' then   
            	Y <= A;
        	elsif S0 = '1' then 
            	Y <= B;
        	end if;
       	elsif S1 = '1' then
       		if S0 = '0' then   
            	Y <= C;
        	elsif S0 = '1' then 
            	Y <= D;
        	end if;
       end if;
     end process P1;
   end behavioral;


-- -------------------------
-- G_MUX81		--63
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_MUX81 is
      port (A,B,C,D,E,F,G,H : In  std_logic;
		  	  S2, S1, S0 : In  std_logic;
                  	  Y : Out std_logic );
   end G_MUX81;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_MUX81 is
    begin
     P1: process (A,B,C,D,E,F,G,H,S2, S1, S0)
     begin
	 if S2 = '0' then
      	if S1 = '0' then   
       		if S0 = '0' then   
            	Y <= A;
        	elsif S0 = '1' then 
            	Y <= B;
        	end if;
       	elsif S1 = '1' then
       		if S0 = '0' then   
            	Y <= C;
        	elsif S0 = '1' then 
            	Y <= D;
        	end if;
       end if;
     elsif S2 = '1' then
      	if S1 = '0' then   
       		if S0 = '0' then   
            	Y <= E;
        	elsif S0 = '1' then 
            	Y <= F;
        	end if;
       	elsif S1 = '1' then
       		if S0 = '0' then   
            	Y <= G;
        	elsif S0 = '1' then 
            	Y <= H;
        	end if;
        end if;
     end if;
     end process P1;
   end behavioral;

-- -------------------------
-- G_XOR		--55
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_XOR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end G_XOR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_XOR is
    begin
     Y <= A xor B;
   end behavioral;

-- -------------------------
-- G_XNOR		--54
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_XNOR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                 YN : Out   std_logic );
   end G_XNOR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_XNOR is
    begin
     YN <= not (A xor B);
   end behavioral;

-- -------------------------
-- G_INV		--53
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_INV is
      Port (      A : In    std_logic;
               YN : Out   std_logic );
   end G_INV;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_INV is
    begin
     YN <= not (A);
   end behavioral;


-- -------------------------
-- G_TRI		--60
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
  entity G_TRI is
      Port (       I : In    std_logic;
                  OE : In    std_logic;
                   O : Out   std_logic );
  end G_TRI;

library ieee;
use ieee.std_logic_1164.all;
  architecture behavioral of G_TRI is
  begin
    O <= I when OE='1' else 'Z';
  end behavioral;

-- -------------------------
-- G_OUTPUT		--59
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_OUTPUT is
      Port (     I : In    std_logic;
                 O : Out   std_logic );
   end G_OUTPUT;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_OUTPUT is
    begin
     O <= (I);
   end behavioral;

-- -------------------------
-- G_INPUT		--58   
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_INPUT is
      Port (     I : In    std_logic;
                 O : Out   std_logic );
   end G_INPUT;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_INPUT is
    begin
     O <= (I);
   end behavioral;

-- -------------------------
--G_CLKBUF		--57
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_CLKBUF is
      Port (     I : In    std_logic;
                 O : Out   std_logic );
   end G_CLKBUF;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_CLKBUF is
    begin
     O <= (I);
   end behavioral;

-- -------------------------
-- G_BIDIR		--56
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
  entity G_BIDIR is
      Port (       I : In    std_logic;
                  OE : In    std_logic;
                   O : InOut std_logic;
                 FBK : Out   std_logic );
  end G_BIDIR;


library ieee;
use ieee.std_logic_1164.all;
  architecture behavioral of G_BIDIR is
  begin
    O <= I when OE='1' else 'Z';
    FBK <= O;
  end behavioral;


-- -------------------------
-- G_BUFB		--52
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_BUFB is
      Port (    AN : In    std_logic;
                 Y : Out   std_logic );
   end G_BUFB;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_BUFB is
    begin
     Y <= not (AN);
   end behavioral;

-- -------------------------
-- G_BUF		--51
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_BUF is
      Port (      A : In    std_logic;
                 Y : Out   std_logic );
   end G_BUF;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_BUF is
    begin
     Y <= A;
   end behavioral;

-- -------------------------
-- G_4OR4		--50
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4OR4 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 DN : In    std_logic;
                   Y : Out   std_logic );
   end G_4OR4;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4OR4 is
    begin
     Y <= not(AN) or not(BN) or not(CN) or not(DN);
   end behavioral;

-- -------------------------
--G_4OR3		--49
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4OR3 is
      Port (       D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                   Y : Out   std_logic );
   end G_4OR3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4OR3 is
    begin
     Y <= not(AN) or not(BN) or not(CN) or D;
   end behavioral;

-- -------------------------
-- G_4OR2		--48
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4OR2 is
      Port (       C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                   Y : Out   std_logic );
   end G_4OR2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4OR2 is
    begin
     Y <= not(AN) or not(BN) or C or D;
   end behavioral;

-- -------------------------
-- G_4OR1		--47
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4OR1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                   Y : Out   std_logic );
   end G_4OR1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4OR1 is
    begin
     Y <= not(AN) or B or C or D;
   end behavioral;

-- -------------------------
-- G_4OR		--46
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4OR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end G_4OR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4OR is
    begin
     Y <= A or B or C or D;
   end behavioral;

-- -------------------------
-- G_4NOR4		--45
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NOR4 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 DN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NOR4;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NOR4 is
    begin
     YN <= not (not(AN) or not(BN) or not(CN) or not(DN));
   end behavioral;


-- -------------------------
-- G_4NOR3		--44
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NOR3 is
      Port (       D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NOR3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NOR3 is
    begin
     YN <= not (not(AN) or not(BN) or not(CN) or D);
   end behavioral;

-- -------------------------
-- G_4NOR2		--43
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NOR2 is
      Port (       C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NOR2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NOR2 is
    begin
     YN <= not (not(AN) or not(BN) or C or D);
   end behavioral;

-- -------------------------
-- G_4NOR1		--42
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NOR1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NOR1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NOR1 is
    begin
     YN <= not (not(AN) or B or C or D);
   end behavioral;


-- -------------------------
-- G_4NOR		--41
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NOR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                 YN : Out   std_logic );
   end G_4NOR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NOR is
    begin
     YN <= not (A or B or C or D);
   end behavioral;

-- -------------------------
-- G_4NAND4		--40
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NAND4 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 DN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NAND4;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NAND4 is
    begin
     YN <= not (not(AN) and not(BN) and not(CN) and not(DN));
   end behavioral;

-- -------------------------
-- G_4NAND3		--39
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NAND3 is
      Port (       D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NAND3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NAND3 is
    begin
     YN <= not (not(AN) and not(BN) and not(CN) and D);
   end behavioral;

-- -------------------------
-- G_4NAND2		--38
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NAND2 is
      Port (       C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NAND2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NAND2 is
    begin
     YN <= not (not(AN) and not(BN) and C and D);
   end behavioral;

-- -------------------------
-- G_4NAND1		--37
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NAND1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                 YN : Out   std_logic );
   end G_4NAND1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NAND1 is
    begin
     YN <= not (not(AN) and B and C and D);
   end behavioral;

-- -------------------------
-- G_4NAND		--36
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4NAND is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                 YN : Out   std_logic );
   end G_4NAND;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4NAND is
    begin
     YN <= not (A and B and C and D);
   end behavioral;

-- -------------------------
-- G_4AND4		--35
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4AND4 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 DN : In    std_logic;
                   Y : Out   std_logic );
   end G_4AND4;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4AND4 is
    begin
     Y <= not(AN) and not(BN) and not(CN) and not(DN);
   end behavioral;

-- -------------------------
-- G_4AND3		--34
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4AND3 is
      Port (       D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                   Y : Out   std_logic );
   end G_4AND3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4AND3 is
    begin
     Y <= not(AN) and not(BN) and not(CN) and D;
   end behavioral;

-- -------------------------
-- G_4AND2		--33
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4AND2 is
      Port (       C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                   Y : Out   std_logic );
   end G_4AND2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4AND2 is
    begin
     Y <= not(AN) and not(BN) and C and D;
   end behavioral;

-- -------------------------
-- G_4AND1		--32
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4AND1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                 AN : In    std_logic;
                   Y : Out   std_logic );
   end G_4AND1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4AND1 is
    begin
     Y <= not(AN) and B and C and D;
   end behavioral;

-- -------------------------
-- G_4AND		--31
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_4AND is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   D : In    std_logic;
                   Y : Out   std_logic );
   end G_4AND;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_4AND is
    begin
     Y <= A and B and C and D;
   end behavioral;

-- -------------------------
-- G_3OR3		--30
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3OR3 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                   Y : Out   std_logic );
   end G_3OR3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3OR3 is
    begin
     Y <= not(AN) or not(BN) or not(CN);
   end behavioral;

-- -------------------------
-- G_3OR2		--29
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3OR2 is
      Port (       C : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                   Y : Out   std_logic );
   end G_3OR2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3OR2 is
    begin
     Y <= not(AN) or not(BN) or C;
   end behavioral;

-- -------------------------
-- G_3OR1		--28
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3OR1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                 AN : In    std_logic;
                   Y : Out   std_logic );
   end G_3OR1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3OR1 is
    begin
     Y <= not(AN) or B or C;
   end behavioral;

-- -------------------------
-- G_3OR		--27
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3OR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end G_3OR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3OR is
    begin
     Y <= A or B or C;
   end behavioral;

-- -------------------------
-- G_3NOR3		--26
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NOR3 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 YN : Out   std_logic );
   end G_3NOR3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NOR3 is
    begin
     YN <= not (not(AN) or not(BN) or not(CN));
   end behavioral;

-- -------------------------
-- G_3NOR2		--25
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NOR2 is
      Port (       C : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 YN : Out   std_logic );
   end G_3NOR2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NOR2 is
    begin
     YN <= not (not(AN) or not(BN) or C);
   end behavioral;

-- -------------------------
-- G_3NOR1		--24
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NOR1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                 AN : In    std_logic;
                 YN : Out   std_logic );
   end G_3NOR1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NOR1 is
    begin
     YN <= not (not(AN) or B or C);
   end behavioral;

-- -------------------------
-- G_3NOR		--23
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NOR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                 YN : Out   std_logic );
   end G_3NOR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NOR is
    begin
     YN <= not (A or B or C);
   end behavioral;

-- -------------------------
-- G_3NAND3 		--22
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NAND3 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                 YN : Out   std_logic );
   end G_3NAND3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NAND3 is
    begin
     YN <= not (not(AN) and not(BN) and not(CN));
   end behavioral;

-- -------------------------
-- G_3NAND2		--21
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NAND2 is
      Port (       C : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                 YN : Out   std_logic );
   end G_3NAND2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NAND2 is
    begin
     YN <= not (not(AN) and not(BN) and C);
   end behavioral;

-- -------------------------
-- G_3NAND1		--20
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NAND1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                 AN : In    std_logic;
                 YN : Out   std_logic );
   end G_3NAND1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NAND1 is
    begin
     YN <= not (not(AN) and B and C);
   end behavioral;

-- -------------------------
-- G_3NAND		--19
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3NAND is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                 YN : Out   std_logic );
   end G_3NAND;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3NAND is
    begin
     YN <= not (A and B and C);
   end behavioral;

-- -------------------------
-- G_3AND3		--18
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3AND3 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 CN : In    std_logic;
                   Y : Out   std_logic );
   end G_3AND3;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3AND3 is
    begin
     Y <= not(AN) and not(BN) and not(CN);
   end behavioral;

-- -------------------------
-- G_3AND2		--17
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3AND2 is
      Port (       C : In    std_logic;
                 AN : In    std_logic;
                 BN : In    std_logic;
                   Y : Out   std_logic );
   end G_3AND2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3AND2 is
    begin
     Y <= not(AN) and not(BN) and C;
   end behavioral;

-- -------------------------
-- G_3AND1		--16
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3AND1 is
      Port (       B : In    std_logic;
                   C : In    std_logic;
                 AN : In    std_logic;
                   Y : Out   std_logic );
   end G_3AND1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3AND1 is
    begin
     Y <= not(AN) and B and C;
   end behavioral;

-- -------------------------
-- G_3AND		--15
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_3AND is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   C : In    std_logic;
                   Y : Out   std_logic );
   end G_3AND;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_3AND is
    begin
     Y <= A and B and C;
   end behavioral;

-- -------------------------
-- G_2OR2		--14
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2OR2 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                   Y : Out   std_logic );
   end G_2OR2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2OR2 is
    begin
     Y <= not(AN) or not(BN);
   end behavioral;

-- -------------------------
-- G_2OR1		--13
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2OR1 is
      Port (       B : In    std_logic;
                 AN : In    std_logic;
                   Y : Out   std_logic );
   end G_2OR1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2OR1 is
    begin
     Y <= not(AN) or B;
   end behavioral;

-- -------------------------
-- G_2OR		--12
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2OR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end G_2OR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2OR is
    begin
     Y <= A or B;
   end behavioral;

-- -------------------------
-- G_2NOR2		--11
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2NOR2 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 YN : Out   std_logic );
   end G_2NOR2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2NOR2 is
    begin
     YN <= not (not(AN) or not(BN));
   end behavioral;

-- -------------------------
-- G_2NOR1		--10
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2NOR1 is
      Port (       B : In    std_logic;
                 AN : In    std_logic;
                 YN : Out   std_logic );
   end G_2NOR1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2NOR1 is
    begin
     YN <= not (not(AN) or B);
   end behavioral;

-- -------------------------
-- G_2NOR		--9
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2NOR is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                 YN : Out   std_logic );
   end G_2NOR;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2NOR is
    begin
     YN <= not (A or B);
   end behavioral;

-- -------------------------
-- G_2NAND2 		--8
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2NAND2 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                 YN : Out   std_logic );
   end G_2NAND2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2NAND2 is
    begin
     YN <= not (not(AN) and not(BN));
   end behavioral;

-- -------------------------
-- G_2NAND1		--7
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2NAND1 is
      Port (       B : In    std_logic;
                 AN : In    std_logic;
                 YN : Out   std_logic );
   end G_2NAND1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2NAND1 is
    begin
     YN <= not (not(AN) and B);
   end behavioral;

-- -------------------------
-- G_2NAND		--6
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2NAND is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                 YN : Out   std_logic );
   end G_2NAND;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2NAND is
    begin
     YN <= not (A and B);
   end behavioral;

-- -------------------------
-- G_2AND2		--5
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2AND2 is
      Port (     AN : In    std_logic;
                 BN : In    std_logic;
                   Y : Out   std_logic );
   end G_2AND2;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2AND2 is
    begin
     Y <= not(AN) and not(BN);
   end behavioral;

-- -------------------------
-- G_2AND1		--4
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2AND1 is
      Port (       B : In    std_logic;
                 AN : In    std_logic;
                   Y : Out   std_logic );
   end G_2AND1;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2AND1 is
    begin
     Y <= not(AN) and B;
   end behavioral;

-- -------------------------
-- G_2AND		--3
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
   entity G_2AND is
      Port (       A : In    std_logic;
                   B : In    std_logic;
                   Y : Out   std_logic );
   end G_2AND;

library ieee;
use ieee.std_logic_1164.all;
   architecture behavioral of G_2AND is
    begin
     Y <= A and B;
   end behavioral;

-- -------------------------
-- G_D			--64
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_D is
      port (CLK,D : In  std_logic;
            Q     : Out std_logic );
end G_D;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_D is
begin
  process(CLK)
    begin
      if rising_edge(CLK) then
        Q <= D AND D ;
      end if;
  end process;
end behavioral;

-- -------------------------
-- G_DC			--65
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_DC is
      port (CLK,C,D : In  std_logic;
            Q       : Out std_logic );
end G_DC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_DC is
begin
  process(CLK,C)
    begin
      if C = '1' then
        Q <= '0';
      elsif rising_edge(CLK) then
        Q <= D AND D ;
      end if;
  end process;
end behavioral;

-- -------------------------
-- G_DP			--68
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_DP is
      port (CLK,P,D : In  std_logic;
            Q       : Out std_logic );
end G_DP;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_DP is
begin
  process(CLK,P)
    begin
      if P = '1' then
        Q <= '1';
      elsif rising_edge(CLK) then
        Q <= D AND D ;
      end if;
  end process;
end behavioral;

-- -------------------------
-- G_DEC		--66
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_DEC is
      port (CLK,C,E,D : In  std_logic;
            Q         : Out std_logic );
end G_DEC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_DEC is
begin
  process(CLK,C,E)
    begin
      if C = '1' then
        Q <= '0';
      elsif rising_edge(CLK) then
        if E = '1' then
          Q <= D AND D ;
        end if;
      end if;
  end process;
end behavioral;


-- -------------------------
-- G_DEP		--67
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_DEP is
      port (CLK,P,E,D : In  std_logic;
            Q         : Out std_logic );
end G_DEP;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_DEP is
begin
  process(CLK,P,E)
    begin
      if P = '1' then
        Q <= '1';
      elsif rising_edge(CLK) then
        if E = '1' then
          Q <= D AND D ;
        end if;
      end if;
  end process;
end behavioral;


-- -------------------------
-- G_T			--76
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_T is
      port (CLK   : In  std_logic;
            T     : In  std_logic;
            Q     : Out std_logic );
end G_T;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_T is
begin

  process(CLK)
      variable Q_local: std_logic;
    begin
      if (not(now > 0 ns)) THEN
	Q_local := '0';
      end if;

      if rising_edge(CLK) then
	if T = '1' then
          Q_local := not Q_local ;
      	end if;
      end if;
      Q <= Q_local;
  end process;
end behavioral;

-- -------------------------
-- G_TC			--77
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_TC is
      port (CLK,C,T : In  std_logic;
            Q     :   Out std_logic );
end G_TC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_TC is
begin
  process(CLK,C)
    variable Q_local: std_logic;
    begin
      if C = '1' then
	Q_local := '0';
      elsif rising_edge(CLK) then
	if T = '1' then
          Q_local := not Q_local ;
      	end if;
      end if;
      Q <= Q_local;
  end process;
end behavioral;

-- -------------------------
-- G_TP			--78
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_TP is
      port (CLK,P,T : In  std_logic;
            Q     : Out std_logic );
end G_TP;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_TP is
begin
  process(CLK,P)
    variable Q_local: std_logic;

    begin
      if P = '1' then
	Q_local := '1';
      elsif rising_edge(CLK) then
	if T = '1' then
          Q_local := not Q_local ;
      	end if;
      end if;
      Q <= Q_local;
  end process;
end behavioral;

-- -------------------------
-- G_LATCH		--72
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_LATCH is
      port (D,E : In  std_logic;
            Q   : Out std_logic );
end G_LATCH;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_LATCH is
begin
  process(E, D)
    begin
      if E = '1' then
	Q <= D;
      end if;
  end process;
end behavioral;

-- -------------------------
-- G_JK			--69
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_JK is
      port (CLK,J,K : In  std_logic;
            Q       : Out std_logic );
end G_JK;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_JK is
begin
  process(CLK)
  variable Q_local:  std_logic;
    begin
      if rising_edge(CLK) then
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

-- -------------------------
-- G_JKC		--70
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_JKC is
      port (CLK,J,K,C : In  std_logic;
            Q         : Out std_logic );
end G_JKC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_JKC is
begin
  process(CLK,C)
  variable Q_local:  std_logic;
    begin
      if C = '1' then
	Q_local := '0';
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

-- -------------------------
-- G_JKP		--71
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_JKP is
      port (CLK,J,K,P : In  std_logic;
            Q         : Out std_logic );
end G_JKP;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_JKP is
begin
  process(CLK,P)
  variable Q_local:  std_logic;
    begin
      if P = '1' then
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


-- -------------------------
-- G_RS			--73
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_RS is
      port (CLK,R,S : In  std_logic;
            Q       : Out std_logic );
end G_RS;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_RS is
begin
  process(CLK)
    variable Q_local: std_logic;
    begin
      if rising_edge(CLK) then
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

-- -------------------------
-- G_RSC		--74
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_RSC is
      port (CLK,R,S,C : In  std_logic;
            Q       : Out std_logic );
end G_RSC;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_RSC is
begin
  process(CLK,C)
    variable Q_local:  std_logic;
    begin
      if C = '1' then
	Q_local := '0';
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

-- -------------------------
-- G_RSP		--75
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_RSP is
      port (CLK,R,S,P : In  std_logic;
            Q         : Out std_logic );
end G_RSP;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_RSP is
begin
  process(CLK,P)
    variable Q_local: std_logic;
    begin
      if P = '1' then
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

-- -------------------------
-- G_FADD		--1
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_FADD is 
   port (A, B, CI:  in std_logic ;
         SUM, CO:  out std_logic
        );
end G_FADD;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_FADD is
   signal s: std_logic;
begin 
   s <= a xor b;
   SUM <= s xor CI;
   CO <= (A and B) or (s and CI);
end behavioral;


-- -------------------------
-- G_HADD		--2
-- -------------------------
library ieee;
use ieee.std_logic_1164.all;
entity G_HADD is 
   port (A, B   :  in std_logic ;
         SUM, CO:  out std_logic
        );
end G_HADD;

library ieee;
use ieee.std_logic_1164.all;
architecture behavioral of G_HADD is
   signal s: std_logic;
begin 
   SUM <= a xor b;
   CO <= A and B;
end behavioral;

