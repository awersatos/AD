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
-- Simulation Library File for ORCA2
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca2/src/RCS/ORCACOMP.vhd,v 1.7 2005/05/19 20:04:09 pradeep Exp $ 
--
--- 
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
package ORCACOMP is 
-- 
component AGEB4
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	GE: out STD_LOGIC := 'X'
  );
end component;
-- 
component ANEB4
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	NE: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND2B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND2B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND3B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND3B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND3B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND4B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND4B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND4B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND4B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND5B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND5B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND5B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND5B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND5B5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AND6
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	F: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI21
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI211
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI2111
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI22
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI221
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI2211
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI222
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C1: in STD_LOGIC := 'X';
	C2: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI31
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI311
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI3111
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI32
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI321
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI33
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI41
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	A4: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI411
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	A4: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component AOI42
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	A4: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component BMS6
port(
	B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMS12
port(
	B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMS12F
port(
	B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--

component BMS12FPD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BMS12FPU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BMS6PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BMS6PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BMS12PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BMS12PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BTS6PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BTS6PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BTS12FPD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BTS12FPU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BTS12PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 
--
component BTS12PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
 


--
component BMZ6
port(
	B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ6PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ6PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ12
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ12F
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ12FPD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ12FPU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ12PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BMZ12PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BNDSCAN
port(
	PTDI:  in STD_LOGIC := 'X';
	PTMS: in STD_LOGIC := 'X';
	PTCK: in STD_LOGIC := 'X';
	BSO1: in STD_LOGIC := 'X';
	BSO2: in STD_LOGIC := 'X';
	TDI: out STD_LOGIC;
	TCK: out STD_LOGIC;
	BSEN1: out STD_LOGIC;
	BSEN2: out STD_LOGIC;
	TDO: out STD_LOGIC
  );
end component;
--
component BTS6
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTS12
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTS12F
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ6
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ6PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ6PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ12
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ12F
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ12FPD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ12FPU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ12PD
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component BTZ12PU
port(
        B:  inout STD_LOGIC := 'X';
        I:  in    STD_LOGIC := 'X';
        T:  in   STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component CB4
port( 
	CI : in STD_LOGIC := 'X';
	PC0: in STD_LOGIC := 'X';
	PC1: in STD_LOGIC := 'X';
	PC2: in STD_LOGIC := 'X';
	PC3: in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	NC0: out STD_LOGIC := 'X';
	NC1: out STD_LOGIC := 'X';
	NC2: out STD_LOGIC := 'X';
	NC3: out STD_LOGIC := 'X'
  );
end component;
-- 
component CB4P3BX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	PD : in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CB4P3DX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	CD : in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CB4P3IX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	CD : in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CB4P3JX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	PD : in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CD4
port( 
	CI : in STD_LOGIC := 'X';
	PC0: in STD_LOGIC := 'X';
	PC1: in STD_LOGIC := 'X';
	PC2: in STD_LOGIC := 'X';
	PC3: in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	NC0: out STD_LOGIC := 'X';
	NC1: out STD_LOGIC := 'X';
	NC2: out STD_LOGIC := 'X';
	NC3: out STD_LOGIC := 'X'
  );
end component;
-- 
component CD4P3BX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	PD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CD4P3DX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	CD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CD4P3IX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	CD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CD4P3JX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	PD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CU4
port( 
	CI : in STD_LOGIC := 'X';
	PC0: in STD_LOGIC := 'X';
	PC1: in STD_LOGIC := 'X';
	PC2: in STD_LOGIC := 'X';
	PC3: in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	NC0: out STD_LOGIC := 'X';
	NC1: out STD_LOGIC := 'X';
	NC2: out STD_LOGIC := 'X';
	NC3: out STD_LOGIC := 'X'
  );
end component;
-- 
component CU4P3BX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	PD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CU4P3DX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	CD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CU4P3IX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	CD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component CU4P3JX
port( 
	CI : in STD_LOGIC := 'X';
	SP : in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	PD : in STD_LOGIC := 'X';
	CO : out STD_LOGIC := 'X';
	Q0 : out STD_LOGIC := 'X';
	Q1 : out STD_LOGIC := 'X';
	Q2 : out STD_LOGIC := 'X';
	Q3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component COMP
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	EQ: out STD_LOGIC := 'X'
  );
end component;
-- 
component COMP4
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	EQ: out STD_LOGIC := 'X'
  );
end component;
-- 
component DCE16X2
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	RAD0: in STD_LOGIC := 'X';
	RAD1: in STD_LOGIC := 'X';
	RAD2: in STD_LOGIC := 'X';
	RAD3: in STD_LOGIC := 'X';
	RDO0: out STD_LOGIC := 'X';
	RDO1: out STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component DCE16X2Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	RAD0: in STD_LOGIC := 'X';
	RAD1: in STD_LOGIC := 'X';
	RAD2: in STD_LOGIC := 'X';
	RAD3: in STD_LOGIC := 'X';
	RDO0: out STD_LOGIC := 'X';
	RDO1: out STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component DCF16X2
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	RAD0: in STD_LOGIC := 'X';
	RAD1: in STD_LOGIC := 'X';
	RAD2: in STD_LOGIC := 'X';
	RAD3: in STD_LOGIC := 'X';
	RDO0: out STD_LOGIC := 'X';
	RDO1: out STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component DCF16X2Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	RAD0: in STD_LOGIC := 'X';
	RAD1: in STD_LOGIC := 'X';
	RAD2: in STD_LOGIC := 'X';
	RAD3: in STD_LOGIC := 'X';
	RDO0: out STD_LOGIC := 'X';
	RDO1: out STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component DMUX24
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	Z0: out STD_LOGIC := 'X';
	Z1: out STD_LOGIC := 'X';
	Z2: out STD_LOGIC := 'X';
	Z3: out STD_LOGIC := 'X'
  );
end component;
-- 
component DMUX24E
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	E : in STD_LOGIC := 'X';
	Z0: out STD_LOGIC := 'X';
	Z1: out STD_LOGIC := 'X';
	Z2: out STD_LOGIC := 'X';
	Z3: out STD_LOGIC := 'X'
  );
end component;
-- 
component DMUX38
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	Z0: out STD_LOGIC := 'X';
	Z1: out STD_LOGIC := 'X';
	Z2: out STD_LOGIC := 'X';
	Z3: out STD_LOGIC := 'X';
	Z4: out STD_LOGIC := 'X';
	Z5: out STD_LOGIC := 'X';
	Z6: out STD_LOGIC := 'X';
	Z7: out STD_LOGIC := 'X'
  );
end component;
-- 
component DMUX38E
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	E : in STD_LOGIC := 'X';
	Z0: out STD_LOGIC := 'X';
	Z1: out STD_LOGIC := 'X';
	Z2: out STD_LOGIC := 'X';
	Z3: out STD_LOGIC := 'X';
	Z4: out STD_LOGIC := 'X';
	Z5: out STD_LOGIC := 'X';
	Z6: out STD_LOGIC := 'X';
	Z7: out STD_LOGIC := 'X'
  );
end component;
-- 
component ADD
port( 
	A : in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	S : out STD_LOGIC := 'X'
  );
end component;
-- 
component FADD4
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	S0: out STD_LOGIC := 'X';
	S1: out STD_LOGIC := 'X';
	S2: out STD_LOGIC := 'X';
	S3: out STD_LOGIC := 'X'
  );
end component;
-- 
component FADD4O
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	OFL: out STD_LOGIC := 'X';
	S0 : out STD_LOGIC := 'X';
	S1 : out STD_LOGIC := 'X';
	S2 : out STD_LOGIC := 'X';
	S3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component SUB
port( 
	A : in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	BI: in STD_LOGIC := 'X';
	BO: out STD_LOGIC := 'X';
	S : out STD_LOGIC := 'X'
  );
end component;
-- 
component FSUB4
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	BI: in STD_LOGIC := 'X';
	BO: out STD_LOGIC := 'X';
	S0: out STD_LOGIC := 'X';
	S1: out STD_LOGIC := 'X';
	S2: out STD_LOGIC := 'X';
	S3: out STD_LOGIC := 'X'
  );
end component;
-- 
component FSUB4O
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	BI: in STD_LOGIC := 'X';
	OFL: out STD_LOGIC := 'X';
	S0 : out STD_LOGIC := 'X';
	S1 : out STD_LOGIC := 'X';
	S2 : out STD_LOGIC := 'X';
	S3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component ADSU
port( 
	A  : in STD_LOGIC := 'X';
	B  : in STD_LOGIC := 'X';
	BCI: in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	BCO: out STD_LOGIC := 'X';
	S  : out STD_LOGIC := 'X'
  );
end component;
-- 
component FADSU4
port( 
	A0 : in STD_LOGIC := 'X';
	A1 : in STD_LOGIC := 'X';
	A2 : in STD_LOGIC := 'X';
	A3 : in STD_LOGIC := 'X';
	B0 : in STD_LOGIC := 'X';
	B1 : in STD_LOGIC := 'X';
	B2 : in STD_LOGIC := 'X';
	B3 : in STD_LOGIC := 'X';
	BCI: in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	BCO: out STD_LOGIC := 'X';
	S0 : out STD_LOGIC := 'X';
	S1 : out STD_LOGIC := 'X';
	S2 : out STD_LOGIC := 'X';
	S3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component FADSU4O
port( 
	A0 : in STD_LOGIC := 'X';
	A1 : in STD_LOGIC := 'X';
	A2 : in STD_LOGIC := 'X';
	A3 : in STD_LOGIC := 'X';
	B0 : in STD_LOGIC := 'X';
	B1 : in STD_LOGIC := 'X';
	B2 : in STD_LOGIC := 'X';
	B3 : in STD_LOGIC := 'X';
	BCI: in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	OFL: out STD_LOGIC := 'X';
	S0 : out STD_LOGIC := 'X';
	S1 : out STD_LOGIC := 'X';
	S2 : out STD_LOGIC := 'X';
	S3 : out STD_LOGIC := 'X'
  );
end component;
-- 
component FAC4P3D
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component FMULT4
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	S0: out STD_LOGIC := 'X';
	S1: out STD_LOGIC := 'X';
	S2: out STD_LOGIC := 'X';
	S3: out STD_LOGIC := 'X';
	S4: out STD_LOGIC := 'X';
	S5: out STD_LOGIC := 'X';
	S6: out STD_LOGIC := 'X';
	S7: out STD_LOGIC := 'X'
  );
end component;
-- 
component FMULT41
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	MULT: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	P0: out STD_LOGIC := 'X';
	P1: out STD_LOGIC := 'X';
	P2: out STD_LOGIC := 'X';
	P3: out STD_LOGIC := 'X'
  );
end component;
component FD1S1A
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S1AY
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S1B
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S1D
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S1I
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S1J
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FL1S1A
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FL1S1AY
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FS1S1A
port( 
	S : in STD_LOGIC := 'X';
	R : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3AX
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3AY
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3BX
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3DX
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3IX
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3IZ
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3JX
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1P3JZ
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S3AX
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S3AY
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S3BX
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S3DX
port( 
	D: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S3IX
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FD1S3JX
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FJ1S3AX
port( 
	J : in STD_LOGIC := 'X';
	K : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FJ1S3BX
port( 
	J : in STD_LOGIC := 'X';
	K : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FJ1S3DX
port( 
	J : in STD_LOGIC := 'X';
	K : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FL1P3AZ
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FL1P3AY
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FL1S3AX
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FL1S3AY
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FT1S3AX
port( 
	T : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FT1S3BX
port( 
	T : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component FT1S3DX
port( 
	T : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q : out STD_LOGIC := 'X';
	QN: out STD_LOGIC := 'X'
  );
end component;
-- 
component GSR
port( 
      GSR: in STD_LOGIC := 'X'
  );
end component;
--
component INRB
port( 
	A: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component INV
port( 
	A: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component IBM
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBMPD
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBMPDS
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBMPU
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBMPUS
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBMS
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBT
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBTPD
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBTPDS
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBTPU
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBTPUS
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IBTS
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component IPAD
port(
        O:  out   STD_LOGIC);
end component;
--
component LTGT
port( 
	A0: in STD_LOGIC := 'X';
	A1: in STD_LOGIC := 'X';
	B0: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	GT: out STD_LOGIC := 'X';
	LT: out STD_LOGIC := 'X'
  );
end component;
-- 
component LU4P3AX
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
--
component LU4P3AY
port(
        D0: in STD_LOGIC := 'X';
        D1: in STD_LOGIC := 'X';
        D2: in STD_LOGIC := 'X';
        D3: in STD_LOGIC := 'X';
        CI: in STD_LOGIC := 'X';
        SP: in STD_LOGIC := 'X';
        CK: in STD_LOGIC := 'X';
        SD: in STD_LOGIC := 'X';
        CO: out STD_LOGIC := 'X';
        Q0: out STD_LOGIC := 'X';
        Q1: out STD_LOGIC := 'X';
        Q2: out STD_LOGIC := 'X';
        Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component LD4P3AX
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component LD4P3AY
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component LB4P3AX
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component LB4P3AY
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CI: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	CON: in STD_LOGIC := 'X';
	CO: out STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component MUX21
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component MUX21E
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	E : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component MUX41
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SD1: in STD_LOGIC := 'X';
	SD2: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component MUX41E
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SD1: in STD_LOGIC := 'X';
	SD2: in STD_LOGIC := 'X';
	E : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component MUX81
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	D4: in STD_LOGIC := 'X';
	D5: in STD_LOGIC := 'X';
	D6: in STD_LOGIC := 'X';
	D7: in STD_LOGIC := 'X';
	SD1: in STD_LOGIC := 'X';
	SD2: in STD_LOGIC := 'X';
	SD3: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component MUX81E
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	D4: in STD_LOGIC := 'X';
	D5: in STD_LOGIC := 'X';
	D6: in STD_LOGIC := 'X';
	D7: in STD_LOGIC := 'X';
	SD1: in STD_LOGIC := 'X';
	SD2: in STD_LOGIC := 'X';
	SD3: in STD_LOGIC := 'X';
	E : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component ND2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND2B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND2B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND3B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND3B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND3B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND4B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND4B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND4B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND4B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND5B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND5B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND5B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND5B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND5B5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component ND6
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	F: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR2B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR2B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR3B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR3B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR3B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR4B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR4B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR4B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR4B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR5B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR5B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR5B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR5B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR5B5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component NR6
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	F: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI21
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI211
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI2111
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	D : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI22
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI221
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI2211
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	D : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI222
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C1: in STD_LOGIC := 'X';
	C2: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI31
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI311
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI3111
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	D : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI32
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI321
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI33
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	B3: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI41
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	A4: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI411
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	A4: in STD_LOGIC := 'X';
	B : in STD_LOGIC := 'X';
	C : in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OAI42
port( 
	A1: in STD_LOGIC := 'X';
	A2: in STD_LOGIC := 'X';
	A3: in STD_LOGIC := 'X';
	A4: in STD_LOGIC := 'X';
	B1: in STD_LOGIC := 'X';
	B2: in STD_LOGIC := 'X';
	Z : out STD_LOGIC := 'X'
  );
end component;
-- 
component OB6
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OB12
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OB12F
port(
        I:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ6
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ6PD
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ6PU
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ12
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ12F
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ12FPD
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ12FPU
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ12PD
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OBZ12PU
port(
        I:  in    STD_LOGIC := 'X';
        T:  in    STD_LOGIC := 'X';
        O:  out   STD_LOGIC);
end component;
--
component OR2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR2B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR2B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR3B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR3B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR3B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR4B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR4B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR4B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR4B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR5B1
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR5B2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR5B3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR5B4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR5B5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OR6
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	F: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component OSCIL
port(
	TEST: in STD_LOGIC := 'X';
	OSC: out STD_LOGIC := 'X');
end component;
--
component PFUMX
port( 
	ALUT: in STD_LOGIC := 'X';
	BLUT: in STD_LOGIC := 'X';
	C0: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component PFUND
port( 
	ALUT: in STD_LOGIC := 'X';
	BLUT: in STD_LOGIC := 'X';
	C0: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component PFUND0
port( 
	ALUT: in STD_LOGIC := 'X';
	BLUT: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component PFUXR
port( 
	ALUT: in STD_LOGIC := 'X';
	BLUT: in STD_LOGIC := 'X';
	C0: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component PFUXR0
port( 
	ALUT: in STD_LOGIC := 'X';
	BLUT: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component READBK
porT(
      RDCFGN : in STD_LOGIC := 'X';
      CAPT : in STD_LOGIC := 'X';
      PRDDATA : out STD_LOGIC := 'X';
      RDBO : out STD_LOGIC := 'X'
  );
end component;
--
component RD4S3A
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4S3B
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4S3D
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4S3I
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4S3J
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4P3A
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4P3B
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4P3D
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4P3I
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RD4P3J
port( 
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4S3A
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4S3B
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4S3D
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4S3I
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4S3J
port( 
	D : in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4P3A
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4P3B
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4P3D
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4P3I
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	CD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RS4P3J
port( 
	D : in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	PD: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RLS4P3A
port( 
	D : in STD_LOGIC := 'X';
	D0: in STD_LOGIC := 'X';
	D1: in STD_LOGIC := 'X';
	D2: in STD_LOGIC := 'X';
	D3: in STD_LOGIC := 'X';
	SD: in STD_LOGIC := 'X';
	SP: in STD_LOGIC := 'X';
	CK: in STD_LOGIC := 'X';
	Q0: out STD_LOGIC := 'X';
	Q1: out STD_LOGIC := 'X';
	Q2: out STD_LOGIC := 'X';
	Q3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RCE16X4
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RCE16X4Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RCF16X4
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RCF16X4Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	CK : in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPE16X2
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPE16X2Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPE16X4
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPE16X4Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	WPE: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPP16X2
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPP16X2Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPP16X4
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
-- 
component RPP16X4Z
generic(
        initval : String := "0x0000000000000000"
  );
port( 
	AD0: in STD_LOGIC := 'X';
	AD1: in STD_LOGIC := 'X';
	AD2: in STD_LOGIC := 'X';
	AD3: in STD_LOGIC := 'X';
	DI0: in STD_LOGIC := 'X';
	DI1: in STD_LOGIC := 'X';
	DI2: in STD_LOGIC := 'X';
	DI3: in STD_LOGIC := 'X';
	WREN: in STD_LOGIC := 'X';
	TRI: in STD_LOGIC := 'X';
	DO0: out STD_LOGIC := 'X';
	DO1: out STD_LOGIC := 'X';
	DO2: out STD_LOGIC := 'X';
	DO3: out STD_LOGIC := 'X'
  );
end component;
--
component rom16x1
  GENERIC (
        initval : string := "0x0000"
  );
port( 
        ad0  : IN   std_logic := 'X';
        ad1  : IN   std_logic := 'X';
        ad2  : IN   std_logic := 'X';
        ad3  : IN   std_logic := 'X';
        do0  : OUT  std_logic := 'X'
  );
end component;
--
component rom32x1
  GENERIC (
        initval : string := "0x00000000"
  );
port( 
        ad0  : IN   std_logic := 'X';
        ad1  : IN   std_logic := 'X';
        ad2  : IN   std_logic := 'X';
        ad3  : IN   std_logic := 'X';
        ad4  : IN   std_logic := 'X';
        do0  : OUT  std_logic := 'X'
  );
end component;
-- 
component STRTUP
port(
        UCLK : in STD_LOGIC := 'X'
  );
end component;
--
component TBUF
port( 
	I: in STD_LOGIC := 'X';
	T: in STD_LOGIC := 'X';
	O: out STD_LOGIC := 'X'
  );
end component;
-- 
component TIBUF
port( 
	I: in STD_LOGIC := 'X';
	T: in STD_LOGIC := 'X';
	O: out STD_LOGIC := 'X'
  );
end component;
-- 
component TSALL
port( 
       TSALL: in STD_LOGIC := 'X'
  );
end component;
-- 
component VHI
port( 
	 Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component VLO
port( 
	 Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XOR2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XOR3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XOR4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XOR5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XOR6
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	F: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XNOR2
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XNOR3
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XNOR4
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 
component XNOR5
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
component XNOR6
port( 
	A: in STD_LOGIC := 'X';
	B: in STD_LOGIC := 'X';
	C: in STD_LOGIC := 'X';
	D: in STD_LOGIC := 'X';
	E: in STD_LOGIC := 'X';
	F: in STD_LOGIC := 'X';
	Z: out STD_LOGIC := 'X'
  );
end component;
-- 

end ORCACOMP;
