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
--                     U.S.A.
--
--                     TEL: 1-800-Lattice  (USA and Canada)
--                          1-408-826-6000 (other locations)
--
--                     web: http://www.latticesemi.com/
--                     email: techsupport@latticesemi.com
--
-- --------------------------------------------------------------------
--
-- Simulation Library File for NEOPRIMS
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/neoprims/src/RCS/NEO_COMP.vhd,v 1.4 2005/05/19 20:03:16 pradeep Exp $ 
--

--- 
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
package NEOCOMP is 
-- 
component NEOAND2
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND3
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND4
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND5
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND6
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND7
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND8
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND16
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VIN8  : in STD_LOGIC := 'X';
	VIN9  : in STD_LOGIC := 'X';
	VIN10 : in STD_LOGIC := 'X';
	VIN11 : in STD_LOGIC := 'X';
	VIN12 : in STD_LOGIC := 'X';
	VIN13 : in STD_LOGIC := 'X';
	VIN14 : in STD_LOGIC := 'X';
	VIN15 : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOAND32
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VIN8  : in STD_LOGIC := 'X';
	VIN9  : in STD_LOGIC := 'X';
	VIN10 : in STD_LOGIC := 'X';
	VIN11 : in STD_LOGIC := 'X';
	VIN12 : in STD_LOGIC := 'X';
	VIN13 : in STD_LOGIC := 'X';
	VIN14 : in STD_LOGIC := 'X';
	VIN15 : in STD_LOGIC := 'X';
	VIN16 : in STD_LOGIC := 'X';
	VIN17 : in STD_LOGIC := 'X';
	VIN18 : in STD_LOGIC := 'X';
	VIN19 : in STD_LOGIC := 'X';
	VIN20 : in STD_LOGIC := 'X';
	VIN21 : in STD_LOGIC := 'X';
	VIN22 : in STD_LOGIC := 'X';
	VIN23 : in STD_LOGIC := 'X';
	VIN24 : in STD_LOGIC := 'X';
	VIN25 : in STD_LOGIC := 'X';
	VIN26 : in STD_LOGIC := 'X';
	VIN27 : in STD_LOGIC := 'X';
	VIN28 : in STD_LOGIC := 'X';
	VIN29 : in STD_LOGIC := 'X';
	VIN30 : in STD_LOGIC := 'X';
	VIN31 : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOBPAD
port( 
	PAD : inout STD_LOGIC := 'Z'
  );
end component;
-- 
component NEOBUF
port( 
	VIN   : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOCKBUF
port( 
	VIN  : in STD_LOGIC := 'X';
	VOUT : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOFF
port( 
	VIN  : in STD_LOGIC := 'X';
	CLK  : in STD_LOGIC := 'X';
	SET  : in STD_LOGIC := 'X';
	RST  : in STD_LOGIC := 'X';
	CE   : in STD_LOGIC := 'X';
	VOUT : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOINV
port( 
	VIN  : in STD_LOGIC := 'X';
	VOUT : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOIPAD
port( 
	PAD  : in STD_LOGIC := 'X'
  );
end component;
-- 
component NEOLATCH
port( 
	VIN  : in STD_LOGIC := 'X';
	CLK  : in STD_LOGIC := 'X';
	SET  : in STD_LOGIC := 'X';
	RST  : in STD_LOGIC := 'X';
	VOUT : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOONE
port( 
	VOUT  : out STD_LOGIC := '1'
  );
end component;
-- 
component NEOOPAD
port( 
	PAD  : out STD_LOGIC := 'Z'
  );
end component;
-- 
component NEOOR2
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR3
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR4
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR5
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR6
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR7
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR8
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR16
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VIN8  : in STD_LOGIC := 'X';
	VIN9  : in STD_LOGIC := 'X';
	VIN10 : in STD_LOGIC := 'X';
	VIN11 : in STD_LOGIC := 'X';
	VIN12 : in STD_LOGIC := 'X';
	VIN13 : in STD_LOGIC := 'X';
	VIN14 : in STD_LOGIC := 'X';
	VIN15 : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOOR32
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VIN8  : in STD_LOGIC := 'X';
	VIN9  : in STD_LOGIC := 'X';
	VIN10 : in STD_LOGIC := 'X';
	VIN11 : in STD_LOGIC := 'X';
	VIN12 : in STD_LOGIC := 'X';
	VIN13 : in STD_LOGIC := 'X';
	VIN14 : in STD_LOGIC := 'X';
	VIN15 : in STD_LOGIC := 'X';
	VIN16 : in STD_LOGIC := 'X';
	VIN17 : in STD_LOGIC := 'X';
	VIN18 : in STD_LOGIC := 'X';
	VIN19 : in STD_LOGIC := 'X';
	VIN20 : in STD_LOGIC := 'X';
	VIN21 : in STD_LOGIC := 'X';
	VIN22 : in STD_LOGIC := 'X';
	VIN23 : in STD_LOGIC := 'X';
	VIN24 : in STD_LOGIC := 'X';
	VIN25 : in STD_LOGIC := 'X';
	VIN26 : in STD_LOGIC := 'X';
	VIN27 : in STD_LOGIC := 'X';
	VIN28 : in STD_LOGIC := 'X';
	VIN29 : in STD_LOGIC := 'X';
	VIN30 : in STD_LOGIC := 'X';
	VIN31 : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOPU
port( 
	VOUT  : out STD_LOGIC := '1'
  );
end component;
-- 
component NEOPD
port( 
	VOUT  : out STD_LOGIC := '0'
  );
end component;
-- 
component NEORAM16 
generic(
        initval : in String := "0x0000"
  );
port(
	VIN  : in STD_LOGIC := 'X';
	WE   : in STD_LOGIC := 'X';
	ADR0 : in STD_LOGIC := 'X';
	ADR1 : in STD_LOGIC := 'X';
	ADR2 : in STD_LOGIC := 'X';
	ADR3 : in STD_LOGIC := 'X';
	VOUT : out STD_LOGIC := 'X'
  );
end component;
--
component NEORAM32 
generic(
        initval : in String := "0x00000"
  );
port(
	VIN  : in STD_LOGIC := 'X';
	WE   : in STD_LOGIC := 'X';
	ADR0 : in STD_LOGIC := 'X';
	ADR1 : in STD_LOGIC := 'X';
	ADR2 : in STD_LOGIC := 'X';
	ADR3 : in STD_LOGIC := 'X';
	ADR4 : in STD_LOGIC := 'X';
	VOUT : out STD_LOGIC := 'X'
  );
end component;
--
component NEOSR16
generic(
        initval : in String := "0x0000"
  );
port(
        DIN  : in STD_LOGIC := 'X';
        RAD0 : in STD_LOGIC := 'X';
        RAD1 : in STD_LOGIC := 'X';
        RAD2 : in STD_LOGIC := 'X';
        RAD3 : in STD_LOGIC := 'X';
        RCLK : in STD_LOGIC := 'X';
        WAD0 : in STD_LOGIC := 'X';
        WAD1 : in STD_LOGIC := 'X';
        WAD2 : in STD_LOGIC := 'X';
        WAD3 : in STD_LOGIC := 'X';
        WCLK : in STD_LOGIC := 'X';
        WREN : in STD_LOGIC := 'X';
        WPE  : in STD_LOGIC := 'X';
        SET  : in STD_LOGIC := 'X';
        RST  : in STD_LOGIC := 'X';
        DOUT : out STD_LOGIC := 'X'
  );
end component;
--
component NEOSRN32
generic(
        initval : in String := "0x00000000"
  );
port(
        DIN  : in STD_LOGIC := 'X';
        RAD0 : in STD_LOGIC := 'X';
        RAD1 : in STD_LOGIC := 'X';
        RAD2 : in STD_LOGIC := 'X';
        RAD3 : in STD_LOGIC := 'X';
        RAD4 : in STD_LOGIC := 'X';
        RCLK : in STD_LOGIC := 'X';
        WAD0 : in STD_LOGIC := 'X';
        WAD1 : in STD_LOGIC := 'X';
        WAD2 : in STD_LOGIC := 'X';
        WAD3 : in STD_LOGIC := 'X';
        WAD4 : in STD_LOGIC := 'X';
        WCLK : in STD_LOGIC := 'X';
        WREN : in STD_LOGIC := 'X';
        WPE  : in STD_LOGIC := 'X';
        SET  : in STD_LOGIC := 'X';
        RST  : in STD_LOGIC := 'X';
        DOUT : out STD_LOGIC := 'X'
  );
end component;
--
component NEOTRI
port(
	VIN  : in STD_LOGIC := 'X';
	CTL  : in STD_LOGIC := 'X';
	VOUT : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOUPAD
port( 
	PAD : inout STD_LOGIC := 'Z'
  );
end component;
-- 
component NEOXOR2
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR3
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR4
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR5
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR6
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR7
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR8
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR16
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VIN8  : in STD_LOGIC := 'X';
	VIN9  : in STD_LOGIC := 'X';
	VIN10 : in STD_LOGIC := 'X';
	VIN11 : in STD_LOGIC := 'X';
	VIN12 : in STD_LOGIC := 'X';
	VIN13 : in STD_LOGIC := 'X';
	VIN14 : in STD_LOGIC := 'X';
	VIN15 : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOXOR32
port( 
	VIN0  : in STD_LOGIC := 'X';
	VIN1  : in STD_LOGIC := 'X';
	VIN2  : in STD_LOGIC := 'X';
	VIN3  : in STD_LOGIC := 'X';
	VIN4  : in STD_LOGIC := 'X';
	VIN5  : in STD_LOGIC := 'X';
	VIN6  : in STD_LOGIC := 'X';
	VIN7  : in STD_LOGIC := 'X';
	VIN8  : in STD_LOGIC := 'X';
	VIN9  : in STD_LOGIC := 'X';
	VIN10 : in STD_LOGIC := 'X';
	VIN11 : in STD_LOGIC := 'X';
	VIN12 : in STD_LOGIC := 'X';
	VIN13 : in STD_LOGIC := 'X';
	VIN14 : in STD_LOGIC := 'X';
	VIN15 : in STD_LOGIC := 'X';
	VIN16 : in STD_LOGIC := 'X';
	VIN17 : in STD_LOGIC := 'X';
	VIN18 : in STD_LOGIC := 'X';
	VIN19 : in STD_LOGIC := 'X';
	VIN20 : in STD_LOGIC := 'X';
	VIN21 : in STD_LOGIC := 'X';
	VIN22 : in STD_LOGIC := 'X';
	VIN23 : in STD_LOGIC := 'X';
	VIN24 : in STD_LOGIC := 'X';
	VIN25 : in STD_LOGIC := 'X';
	VIN26 : in STD_LOGIC := 'X';
	VIN27 : in STD_LOGIC := 'X';
	VIN28 : in STD_LOGIC := 'X';
	VIN29 : in STD_LOGIC := 'X';
	VIN30 : in STD_LOGIC := 'X';
	VIN31 : in STD_LOGIC := 'X';
	VOUT  : out STD_LOGIC := 'X'
  );
end component;
-- 
component NEOZERO
port( 
	VOUT  : out STD_LOGIC := '0'
  );
end component;
-- 

end NEOCOMP;

