-- CoolRunner-II Simulation models for DET functions
-- Xilinx CPLD Group
-- 25 Oct 2002

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD16CE is
	generic (WIDTH: Integer := 16);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
		);
end CBD16CE;

architecture Behavioral of CBD16CE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;


TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q<=COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD16CLE is
	generic (WIDTH: Integer := 16);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			CLR : in STD_LOGIC;
			CE : in STD_LOGIC;
			C : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)
	);
end CBD16CLE;

architecture Behavioral of CBD16CLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q<=COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD16CLED is
	generic (WIDTH: Integer := 16);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)		);
end CBD16CLED;

architecture Behavioral of CBD16CLED is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal TC_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then
			if (UP='1') then
				COUNT <= COUNT+1;
			elsif (UP='0') then
				COUNT <= COUNT-1;
			end if;
		end if;
	end if;
end process;

TC <= '1' when	(((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or 
	((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0'))) else '0'; 

CEO <= '1' when (((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or 
	 ((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0')))  and CE='1' else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD16RE is
	generic (WIDTH: Integer := 16);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
	);
end CBD16RE;

architecture Behavioral of CBD16RE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0' ;
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD16RLE is
	generic (WIDTH: Integer := 16);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end CBD16RLE;

architecture Behavioral of CBD16RLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (L='1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q<=COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD16X1 is
	generic (WIDTH: Integer := 16);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD16X1;

architecture Behavioral of CBD16X1 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
		CEU_INT <= '0';
		CED_INT <= '1';
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

TCU <=  '1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0'; 
TCD <=	'1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0'; 
CEOU <= '1' when (((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) and CEU = '1') else '0'; 
CEOD <=	'1' when (((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) and CED='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD16X2 is
	generic (WIDTH: Integer := 16);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD16X2;

architecture Behavioral of CBD16X2 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
			CEU_INT <= '0';
			CED_INT <= '1';
		elsif (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

TCU <=	'1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0'; 
TCD <= '1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0'; 
CEOU <=	'1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1') and CEU='1') else '0'; 
CEOD <= '1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1') and CED='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD2CE is
	generic (WIDTH: Integer := 2);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
	);
end CBD2CE;

architecture Behavioral of CBD2CE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;


TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD2CLE is
	generic (WIDTH: Integer := 2);
	port (
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)	);
end CBD2CLE;

architecture Behavioral of CBD2CLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD2CLED is
	generic (WIDTH: Integer := 2);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD2CLED;

architecture Behavioral of CBD2CLED is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then
			if (UP='1') then
				COUNT <= COUNT+1;
			elsif (UP='0') then
				COUNT <= COUNT-1;
			end if;
		end if;
	end if;
end process;

TC <=  '1' when (((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or 
	((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0'))) else '0';
CEO <=  '1' when ((((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or ((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0'))) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD2RE is
	generic (WIDTH: Integer := 2);
	port (
			TC : out STD_LOGIC;
			CEO : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
	);
end CBD2RE;

architecture Behavioral of CBD2RE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <=  '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD2RLE is
	generic (WIDTH: Integer := 2);
	port (
			C : in STD_LOGIC;
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)		);
end CBD2RLE;

architecture Behavioral of CBD2RLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (L='1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD2X1 is
	generic (WIDTH: Integer := 2);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)		);
end CBD2X1;

architecture Behavioral of CBD2X1 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
		CEU_INT <= '0';
		CED_INT <= '1';
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

TCU <= '1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0';
TCD <=  '1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0';
CEOU <= '1' when (((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) and CEU='1') else '0';
CEOD <=  '1' when (((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) and CED='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD2X2 is
	generic (WIDTH: Integer := 2);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD2X2;

architecture Behavioral of CBD2X2 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal TCU_INT : STD_LOGIC;
	signal TCD_INT : STD_LOGIC;
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
			CEU_INT <= '0';
			CED_INT <= '1';
		elsif (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

process(COUNT, CEU_INT, CED_INT)
begin
	if ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) then
		TCU_INT <= '1';
		TCD_INT <= '0';
	elsif ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) then 
		TCU_INT <= '0';
		TCD_INT <= '1';
	else
		TCU_INT <= '0';
		TCD_INT <= '0';
	end if;
end process;

TCU <= '1' when  ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0';
TCD <= '1' when  ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0'; 
CEOU <= '1' when  ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1') and CEU='1') else '0';
CEOD <= '1' when  ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1') and CED='1') else '0'; 

Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD4CE is
	generic (WIDTH: Integer := 4);
	port (
			TC : out STD_LOGIC;
			CEO : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
	);
end CBD4CE;

architecture Behavioral of CBD4CE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0'; 
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD4CLE is
	generic (WIDTH: Integer := 4);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD4CLE;

architecture Behavioral of CBD4CLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0'; 
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD4CLED is
	generic (WIDTH: Integer := 4);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);	
end CBD4CLED;

architecture Behavioral of CBD4CLED is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then
			if (UP='1') then
				COUNT <= COUNT+1;
			elsif (UP='0') then
				COUNT <= COUNT-1;
			end if;
		end if;
	end if;
end process;

TC <= '1' when (((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or 
	((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0'))) else '0'; 
CEO <= '1' when ((((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or
  	((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0'))) and CE='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD4RE is
	generic (WIDTH: Integer := 4);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
	);
end CBD4RE;

architecture Behavioral of CBD4RE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD4RLE is
	generic (WIDTH: Integer := 4);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end CBD4RLE;

architecture Behavioral of CBD4RLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (L='1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0'; 
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD4X1 is
	generic (WIDTH: Integer := 4);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD4X1;

architecture Behavioral of CBD4X1 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal TCU_INT : STD_LOGIC;
	signal TCD_INT : STD_LOGIC;
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
		CEU_INT <= '0';
		CED_INT <= '1';
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

process(COUNT, CEU_INT, CED_INT)
begin
	if ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) then
		TCU_INT <= '1';
		TCD_INT <= '0';
	elsif ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) then 
		TCU_INT <= '0';
		TCD_INT <= '1';
	else
		TCU_INT <= '0';
		TCD_INT <= '0';
	end if;
end process;

TCU <= '1' when  ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0';
TCD <= '1' when  ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0'; 
CEOU <= '1' when (((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) and CEU='1') else '0';
TCD <= '1' when (((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) and CED='1') else '0'; 

Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD4X2 is
	generic (WIDTH: Integer := 4);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD4X2;

architecture Behavioral of CBD4X2 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal TCU_INT : STD_LOGIC;
	signal TCD_INT : STD_LOGIC;
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
			CEU_INT <= '0';
			CED_INT <= '1';
		elsif (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

process(COUNT, CEU_INT, CED_INT)
begin
	if ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) then
		TCU_INT <= '1';
		TCD_INT <= '0';
	elsif ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) then 
		TCU_INT <= '0';
		TCD_INT <= '1';
	else
		TCU_INT <= '0';
		TCD_INT <= '0';
	end if;
end process;

TCU <= '1' when  ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0';
TCD <= '1' when  ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0'; 
CEOU <= '1' when  (((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) and  CEU='1') else '0';
CEOD <= '1' when  (((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) and CED='1') else '0'; 

Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD8CE is
	generic (WIDTH: Integer := 8);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
	);
end CBD8CE;

architecture Behavioral of CBD8CE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;


TC <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD8CLE is
	generic (WIDTH: Integer := 8);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD8CLE;

architecture Behavioral of CBD8CLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0'; 
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD8CLED is
	generic (WIDTH: Integer := 8);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD8CLED;

architecture Behavioral of CBD8CLED is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
		elsif (CE='1') then
			if (UP='1') then
				COUNT <= COUNT+1;
			elsif (UP='0') then
				COUNT <= COUNT-1;
			end if;
		end if;
	end if;
end process;

TC <= '1' when  (((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or 
 ((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0'))) else '0'; 
CEO <= '1' when  ((((COUNT = TERMINAL_COUNT_UP) and (UP = '1')) or ((COUNT = TERMINAL_COUNT_DOWN) and (UP = '0'))) and CE='1') else '0'; 

Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD8RE is
	generic (WIDTH: Integer := 8);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
	);
end CBD8RE;

architecture Behavioral of CBD8RE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0'; 
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD8RLE is
	generic (WIDTH: Integer := 8);
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end CBD8RLE;

architecture Behavioral of CBD8RLE is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	constant TERMINAL_COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');

begin

process(C, R)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
		elsif (L='1') then
			COUNT <= D;
		elsif (CE='1') then 
			COUNT <= COUNT+1;
		end if;
	end if;
end process;

TC <= '1' when (COUNT = TERMINAL_COUNT) else '0'; 
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0'; 
Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD8X1 is
	generic (WIDTH: Integer := 8);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD8X1;

architecture Behavioral of CBD8X1 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C, CLR)
begin
	if (CLR='1') then
		COUNT <= (others => '0');
		CEU_INT <= '0';
		CED_INT <= '1';
	elsif C'event then
		if (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

TCU <= '1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0';
TCD <= '1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0'; 
CEOU <= '1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1') and CEU='1') else '0';
CEOD <= '1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1') and CED='1') else '0'; 

Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CBD8X2 is
	generic (WIDTH: Integer := 8);
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)	);
end CBD8X2;

architecture Behavioral of CBD8X2 is

	signal COUNT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal CEU_INT : STD_LOGIC;
	signal CED_INT : STD_LOGIC;

	constant TERMINAL_COUNT_UP : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '1');
	constant TERMINAL_COUNT_DOWN : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');

begin

process(C)
begin
	if C'event then
		if (R='1') then
			COUNT <= (others => '0');
			CEU_INT <= '0';
			CED_INT <= '1';
		elsif (L = '1') then
			COUNT <= D;
			CEU_INT <= CEU;
			CED_INT <= CED;
		elsif (CEU='1') then
			COUNT <= COUNT+1;
			CEU_INT <= '1';
			CED_INT <= '0';
		elsif (CED='1') then
			COUNT <= COUNT-1;
			CEU_INT <= '0';
			CED_INT <= '1';
		end if;
	end if;
end process;

TCU <= '1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1')) else '0';
TCD <= '1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1')) else '0'; 
CEOU <= '1' when ((COUNT = TERMINAL_COUNT_UP) and (CEU_INT = '1') and CEU='1') else '0';
CEOD <= '1' when ((COUNT = TERMINAL_COUNT_DOWN) and (CED_INT = '1') and CED='1') else '0'; 

Q <= COUNT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CDD4CE is
    port ( 
	   CEO : out STD_LOGIC;
           TC : out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(3 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end CDD4CE;

architecture Behavioral of CDD4CE is

	signal Q_INT : STD_LOGIC_VECTOR(3 downto 0);

begin

	process (C, CLR)
	begin
		if (CLR = '1') then
			Q_INT <= "0000";
		elsif (C'event) then
			if (CE = '1') then
				if (Q_INT = "1001") then
					Q_INT <= "0000";
				elsif (Q_INT = "1011") then
					Q_INT <= "0110";
				elsif (Q_INT = "1101") then
					Q_INT <= "0100";
				elsif (Q_INT = "1111") then
					Q_INT <= "0010";
				else
					Q_INT <= Q_INT + 1;
			  	end if;
		 	end if;
		end if;
	end process;

	Q <= Q_INT;
	TC <= '1' when (Q_INT = "1001") else '0';
	CEO <= '1' when ((Q_INT = "1001") and CE='1') else '0';

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CDD4CLE is
    port ( 
	CEO : out STD_LOGIC;
	TC : out STD_LOGIC;
	Q : out STD_LOGIC_VECTOR(3 downto 0);
	C : in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	L : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR (3 downto 0)
	);
end CDD4CLE;

architecture Behavioral of CDD4CLE is

	signal Q_INT : STD_LOGIC_VECTOR(3 downto 0);

begin

	process (C, CLR)
	begin
		if (CLR = '1') then
			Q_INT <= "0000";
		elsif (C'event) then
			if (L = '1') then
				Q_INT <= D;
			elsif (CE = '1') then
				if (Q_INT = "1001") then
					Q_INT <= "0000";
				elsif (Q_INT = "1011") then
					Q_INT <= "0110";
				elsif (Q_INT = "1101") then
					Q_INT <= "0100";
				elsif (Q_INT = "1111") then
					Q_INT <= "0010";
				else
					Q_INT <= Q_INT + 1;
			  	end if;
		 	end if;
		end if;
	end process;

	Q <= Q_INT;
	TC <= '1' when (Q_INT = "1001") else '0';
	CEO <= '1' when ((Q_INT = "1001") and CE='1') else '0';

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CDD4RE is
    port ( 
	   CEO : out STD_LOGIC;
           TC : out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(3 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC
	);
end CDD4RE;

architecture Behavioral of CDD4RE is

	signal Q_INT : STD_LOGIC_VECTOR(3 downto 0);

begin

	process (C)
	begin
		if (C'event) then
			if (R = '1') then
				Q_INT <= "0000";
			elsif (CE = '1') then
				if (Q_INT = "1001") then
					Q_INT <= "0000";
				elsif (Q_INT = "1011") then
					Q_INT <= "0110";
				elsif (Q_INT = "1101") then
					Q_INT <= "0100";
				elsif (Q_INT = "1111") then
					Q_INT <= "0010";
				else
					Q_INT <= Q_INT + 1;
			  	end if;
		 	end if;
		end if;
	end process;

	Q <= Q_INT;
	TC <= '1' when (Q_INT = "1001") else '0';
	CEO <= '1' when ((Q_INT = "1001") and CE='1') else '0';

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CDD4RLE is
    port ( 
	   CEO : out STD_LOGIC;
           TC : out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(3 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
	   L : in STD_LOGIC;
           R : in STD_LOGIC;
	   D : in STD_LOGIC_VECTOR (3 downto 0)
	);
end CDD4RLE;

architecture Behavioral of CDD4RLE is

	signal Q_INT : STD_LOGIC_VECTOR(3 downto 0);

begin

	process (C)
	begin
		if (C'event) then
			if (R = '1') then
				Q_INT <= "0000";
			elsif (L = '1') then
				Q_INT <= D;
			elsif (CE = '1') then
				if (Q_INT = "1001") then
					Q_INT <= "0000";
				elsif (Q_INT = "1011") then
					Q_INT <= "0110";
				elsif (Q_INT = "1101") then
					Q_INT <= "0100";
				elsif (Q_INT = "1111") then
					Q_INT <= "0010";
				else
					Q_INT <= Q_INT + 1;
			  	end if;
		 	end if;
		end if;
	end process;

	Q <= Q_INT;
	TC <= '1' when (Q_INT = "1001") else '0';
	CEO <= '1' when ((Q_INT = "1001") and CE='1') else '0';

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CJD4CE is
	 generic (WIDTH : integer := 4);
	 port ( 
	   Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end CJD4CE;

architecture Behavioral of CJD4CE is

signal Q_INT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

begin

process (C, CLR)
begin
	if (CLR = '1') then
		Q_INT <= (others => '0');
	elsif (C'event) then
		if (CE = '1') then
			Q_INT(0) <= not Q_INT(WIDTH-1);
			Q_INT(WIDTH-1 downto 1) <= Q_INT(WIDTH-2 downto 0);
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CJD4RE is
	 generic (WIDTH : integer := 4);
         port ( 
	   Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC
	);
end CJD4RE;

architecture Behavioral of CJD4RE is

signal Q_INT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

begin

process (C)
begin
	if (C'event) then
		if (R = '1') then
			Q_INT <= (others => '0');
		elsif (CE = '1') then
			Q_INT(0) <= not Q_INT(WIDTH-1);
			Q_INT(WIDTH-1 downto 1) <= Q_INT(WIDTH-2 downto 0);
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CJD5CE is
	 generic (WIDTH : integer := 5);
         port ( 
	   Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end CJD5CE;

architecture Behavioral of CJD5CE is

signal Q_INT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

begin

process (C, CLR)
begin
	if (CLR = '1') then
		Q_INT <= (others => '0');
	elsif (C'event) then
		if (CE = '1') then
			Q_INT(0) <= not Q_INT(WIDTH-1);
			Q_INT(WIDTH-1 downto 1) <= Q_INT(WIDTH-2 downto 0);
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CJD5RE is
	 generic (WIDTH : integer := 5);
         port (
	   Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC
	);
end CJD5RE;

architecture Behavioral of CJD5RE is

signal Q_INT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

begin

process (C)
begin
	if (C'event) then
		if (R = '1') then
			Q_INT <= (others => '0');
		elsif (CE = '1') then
			Q_INT(0) <= not Q_INT(WIDTH-1);
			Q_INT(WIDTH-1 downto 1) <= Q_INT(WIDTH-2 downto 0);
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CJD8CE is
	 generic (WIDTH : integer := 8);
         port ( 
	   Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end CJD8CE;

architecture Behavioral of CJD8CE is

signal Q_INT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

begin

process (C, CLR)
begin
	if (CLR = '1') then
		Q_INT <= (others => '0');
	elsif (C'event) then
		if (CE = '1') then
			Q_INT(0) <= not Q_INT(WIDTH-1);
			Q_INT(WIDTH-1 downto 1) <= Q_INT(WIDTH-2 downto 0);
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CJD8RE is
	 generic (WIDTH : integer := 8);
    port ( Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC);
end CJD8RE;

architecture Behavioral of CJD8RE is

signal Q_INT : STD_LOGIC_VECTOR(WIDTH-1 downto 0);

begin

process (C)
begin
	if (C'event) then
		if (R = '1') then
			Q_INT <= (others => '0');
		elsif (CE = '1') then
			Q_INT(0) <= not Q_INT(WIDTH-1);
			Q_INT(WIDTH-1 downto 1) <= Q_INT(WIDTH-2 downto 0);
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC
	);
end FDD;

architecture Behavioral of FDD is
begin
 process (C)
  begin
  if C'event then
	Q <= D;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD16 is
  port ( 
	Q : out STD_LOGIC_VECTOR(15 downto 0);
	C: in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end FDD16;

architecture Behavioral of FDD16 is
begin
 process (C)
  begin
  if C'event then
	Q <= D;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD16CE is
  port ( 
	Q : out STD_LOGIC_VECTOR(15 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end FDD16CE;

architecture Behavioral of FDD16CE is
begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q <= (OTHERS => '0');
 elsif C'event then
  if (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD16RE is
  port (
	Q : out STD_LOGIC_VECTOR(15 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(15 downto 0);
	R : in STD_LOGIC
	);
end FDD16RE;

architecture Behavioral of FDD16RE is
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q <= "0000000000000000";
  elsif (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD4 is
  port ( 
	Q : out STD_LOGIC_VECTOR(3 downto 0);
	C: in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end FDD4;

architecture Behavioral of FDD4 is
begin
 process (C)
  begin
  if C'event then
	Q <= D;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD4CE is
  port ( 
	Q : out STD_LOGIC_VECTOR(3 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end FDD4CE;

architecture Behavioral of FDD4CE is
begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q <= "0000";
 elsif C'event then
  if (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD4RE is
  port ( 
	Q : out STD_LOGIC_VECTOR(3 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(3 downto 0);
	R : in STD_LOGIC
	);
end FDD4RE;

architecture Behavioral of FDD4RE is
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q <= "0000";
  elsif (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD8 is
  port ( 
	Q : out STD_LOGIC_VECTOR(7 downto 0);
	C: in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end FDD8;

architecture Behavioral of FDD8 is
begin
 process (C)
  begin
  if C'event then
	Q <= D;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD8CE is
  port ( 
	Q : out STD_LOGIC_VECTOR(7 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end FDD8CE;

architecture Behavioral of FDD8CE is
begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q <= "00000000";
 elsif C'event then
  if (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDD8RE is
  port ( 
	Q : out STD_LOGIC_VECTOR(7 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	R : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end FDD8RE;

architecture Behavioral of FDD8RE is
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q <= "00000000";
  elsif (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDC is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC
	);
end FDDC;

architecture Behavioral of FDDC is
begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q <= '0';
 elsif C'event and C = '1' then
	Q <= D;
  end if;
   end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDCE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC
	);
end FDDCE;

architecture Behavioral of FDDCE is
begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q <= '0';
 elsif C'event then
  if (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDCP is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end FDDCP;

architecture Behavioral of FDDCP is
begin
 process (C,CLR,PRE)
  begin
  if (CLR = '1') then
  Q <= '0';
  elsif (PRE = '1') then
  Q <= '1';
  elsif C'event then
	Q <= D;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDCPE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end FDDCPE;

architecture Behavioral of FDDCPE is
begin
 process (C,CLR,PRE)
  begin
  if (CLR = '1') then
  Q <= '0';
  elsif (PRE = '1') then
  Q <= '1';
 elsif C'event then
  if (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDP is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end FDDP;

architecture Behavioral of FDDP is
begin
 process (C,PRE)
  begin
  if (PRE = '1') then
  Q <= '1';
 elsif C'event then
	Q <= D;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDPE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end FDDPE;

architecture Behavioral of FDDPE is
begin
 process (C,PRE)
  begin
  if (PRE = '1') then
  Q <= '1';
 elsif C'event then
  if (CE = '1') then
	Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDR is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC
	);
end FDDR;

architecture Behavioral of FDDR is
begin
 process (C,R)
  begin
 if C'event then
  if (R = '1') then
  Q <= '0';
  else Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDRE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC
	);
end FDDRE;

architecture Behavioral of FDDRE is
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q <= '0';
  elsif CE = '1' then
  Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDRS is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end FDDRS;

architecture Behavioral of FDDRS is
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q <= '0';
  elsif (S = '1') then
  Q <= '1';
  else 
  Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDRSE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end FDDRSE;

architecture Behavioral of FDDRSE is
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q <= '0';
  elsif (S = '1') then
  Q <= '1';
  elsif (CE = '1') then
	 Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDSE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	S : in STD_LOGIC
	);
end FDDSE;

architecture Behavioral of FDDSE is
begin
 process (C)
  begin
 if C'event then
  if (S = '1') then
  Q <= '1';
  elsif CE = '1' then
  Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDSR is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end FDDSR;

architecture Behavioral of FDDSR is
begin
 process (C)
  begin
 if C'event then
  if (S = '1') then
  Q <= '1';
  elsif (R = '1') then
  Q <= '0';
  else Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FDDSRE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end FDDSRE;

architecture Behavioral of FDDSRE is
begin
 process (C)
  begin
 if C'event then
  if (S = '1') then
  Q <= '1';
  elsif (R = '1') then
  Q <= '0';
  elsif (CE = '1') then
	 Q <= D;
  end if;
  end if;
  end process;
 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FTDCE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	T : in STD_LOGIC
	);
end FTDCE;

architecture Behavioral of FTDCE is
signal D : STD_LOGIC;
signal Q_I : STD_LOGIC;

begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q_I <= '0';
 elsif C'event then
  if (CE = '1') then
	Q_I <= D;
  end if;
  end if;
   end process;

D <= Q_I xor T;
Q <= Q_I;

 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FTDCLE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	L : in STD_LOGIC;
	T : in STD_LOGIC
	);
end FTDCLE;

architecture Behavioral of FTDCLE is
signal D_I : STD_LOGIC;
signal Q_I : STD_LOGIC;

begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q_I <= '0';
 elsif C'event then
  if (L = '1') then
  Q_I <= D;
  elsif (CE = '1') then
	Q_I <= D_I;
  end if;
  end if;
   end process;

D_I <= Q_I xor T;
Q <= Q_I;

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FTDCLEX is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	L : in STD_LOGIC;
	T : in STD_LOGIC
	);
end FTDCLEX;

architecture Behavioral of FTDCLEX is
signal D_I : STD_LOGIC;
signal Q_I : STD_LOGIC;

begin
 process (C,CLR)
  begin
  if (CLR = '1') then
  Q_I <= '0';
 elsif C'event then
  if (L = '1') then
  Q_I <= D;
  elsif (CE = '1') then
	Q_I <= D_I;
  end if;
  end if;
   end process;

D_I <= Q_I xor T;
Q <= Q_I;

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FTDCP is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CLR : in STD_LOGIC;
	PRE : in STD_LOGIC;
	T : in STD_LOGIC
	);
end FTDCP;

architecture Behavioral of FTDCP is
signal D : STD_LOGIC;
signal Q_I : STD_LOGIC;
begin
 process (C,CLR,PRE)
  begin
  if (CLR = '1') then
  Q_I <= '0';
  elsif (PRE = '1') then
  Q_I <= '1';
  elsif C'event then
	Q_I <= D;
  end if;
  end process;

D <= Q_I xor T;
Q <= Q_I;

 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FTDCPE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	PRE : in STD_LOGIC;
	T : in STD_LOGIC
	);
end FTDCPE;

architecture Behavioral of FTDCPE is
signal D : STD_LOGIC;
signal Q_I : STD_LOGIC;
begin
 process (C,CLR,PRE)
  begin
  if (CLR = '1') then
  Q_I <= '0';
  elsif (PRE = '1') then
  Q_I <= '1';
 elsif C'event then
  if (CE = '1') then
	Q_I <= D;
  end if;
  end if;
  end process;

	Q <= Q_I;
	D <= Q_I xor T;

 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FTDRSE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC;
	T : in STD_LOGIC
	);
end FTDRSE;

architecture Behavioral of FTDRSE is
signal D : STD_LOGIC;
signal Q_I : STD_LOGIC;
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q_I <= '0';
  elsif (S = '1') then
  Q_I <= '1';
  if (CE = '1') then
	Q_I <= D;
  end if;
  end if;
  end if;
  end process;

	Q <= Q_I;
	D <= Q_I xor T;

 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FTDRSLE is
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	L : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC;
	T : in STD_LOGIC
	);
end FTDRSLE;

architecture Behavioral of FTDRSLE is
signal D_I : STD_LOGIC;
signal Q_I : STD_LOGIC;
begin
 process (C)
  begin
 if C'event then
  if (R = '1') then
  Q_I <= '0';
  elsif (S = '1') then
  Q_I <= '1';
  if (L = '1') then
	Q_I <= D;
  if (CE = '1') then
	Q_I <= D_I;
  end if;
  end if;
  end if;
  end if;
  end process;

	Q <= Q_I;
	D_I <= Q_I xor T;

 end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD16CE is
	generic (WIDTH: Integer := 16);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end SRD16CE;

architecture Behavioral of SRD16CE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD16CLE is
	generic (WIDTH: Integer := 16);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD16CLE;

architecture Behavioral of SRD16CLE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD16CLED is
	generic (WIDTH: Integer := 16);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD16CLED;

architecture Behavioral of SRD16CLED is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
		if (LEFT='1') then
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		else
			Q_INT <= SRI & Q_INT(WIDTH-1 downto 1) ;
		end if;
		end if;
	end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD16RE is
	generic (WIDTH: Integer := 16);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end SRD16RE;

architecture Behavioral of SRD16RE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, R)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		elsif (CE='1') then 
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD16RLE is
	generic (WIDTH: Integer := 16);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD16RLE;

architecture Behavioral of SRD16RLE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C,R)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
		end if;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD16RLED is
	generic (WIDTH: Integer := 16);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD16RLED;

architecture Behavioral of SRD16RLED is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
		if (LEFT='1') then
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		else
			Q_INT <= SRI & Q_INT(WIDTH-1 downto 1) ;
		end if;
		end if;
	end if;
	end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD4CE is
	generic (WIDTH: Integer := 4);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end SRD4CE;

architecture Behavioral of SRD4CE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD4CLE is
	generic (WIDTH: Integer := 4);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD4CLE;

architecture Behavioral of SRD4CLE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD4CLED is
	generic (WIDTH: Integer := 4);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD4CLED;

architecture Behavioral of SRD4CLED is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
		if (LEFT='1') then
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		else
			Q_INT <= SRI & Q_INT(WIDTH-1 downto 1) ;
		end if;
		end if;
	end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD4RE is
	generic (WIDTH: Integer := 4);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end SRD4RE;

architecture Behavioral of SRD4RE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, R)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		elsif (CE='1') then 
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD4RLE is
	generic (WIDTH: Integer := 4);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD4RLE;

architecture Behavioral of SRD4RLE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C,R)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
		end if;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD4RLED is
	generic (WIDTH: Integer := 4);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD4RLED;

architecture Behavioral of SRD4RLED is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
		if (LEFT='1') then
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		else
			Q_INT <= SRI & Q_INT(WIDTH-1 downto 1) ;
		end if;
		end if;
	end if;
	end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD8CE is
	generic (WIDTH: Integer := 8);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end SRD8CE;

architecture Behavioral of SRD8CE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD8CLE is
	generic (WIDTH: Integer := 8);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD8CLE;

architecture Behavioral of SRD8CLE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD8CLED is
	generic (WIDTH: Integer := 8);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD8CLED;

architecture Behavioral of SRD8CLED is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, CLR)
begin
	if (CLR='1') then
		Q_INT <= (others => '0');
	elsif C'event then
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
		if (LEFT='1') then
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		else
			Q_INT <= SRI & Q_INT(WIDTH-1 downto 1) ;
		end if;
		end if;
	end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD8RE is
	generic (WIDTH: Integer := 8);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end SRD8RE;

architecture Behavioral of SRD8RE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C, R)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		elsif (CE='1') then 
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD8RLE is
	generic (WIDTH: Integer := 8);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD8RLE;

architecture Behavioral of SRD8RLE is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C,R)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		end if;
		end if;
		end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRD8RLED is
	generic (WIDTH: Integer := 8);
	port (
		Q : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end SRD8RLED;

architecture Behavioral of SRD8RLED is
signal Q_INT: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

process(C)
begin
	if C'event then
	if (R='1') then
		Q_INT <= (others => '0');
		if (CE='1') then 
		if (L='1') then
			Q_INT <= D;
		else
		if (LEFT='1') then
			Q_INT <= Q_INT(WIDTH-2 downto 0) & SLI;
		else
			Q_INT <= SRI & Q_INT(WIDTH-1 downto 1) ;
		end if;
		end if;
	end if;
	end if;
	end if;
end process;

Q <= Q_INT;

end Behavioral;
