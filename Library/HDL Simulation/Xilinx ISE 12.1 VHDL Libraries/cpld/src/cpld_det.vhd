-- DET simulation models
-- Xilinx CPLD Group
-- 24 Oct 2002

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package CPLD_DET_COMPONENTS is

attribute syn_black_box: boolean;
	attribute black_box_pad: boolean;
	attribute black_box_pad_pin: string;
	attribute black_box_tri_pins : string;
	attribute xc_props: string;
	attribute syn_noprune: boolean;
	attribute xc_padmacro : boolean;
	attribute BOX_TYPE : string;
	attribute syn_black_box of cpld_det_components : package  is true;

component CBD16CE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CBD16CE : component is TRUE;
attribute BOX_TYPE of CBD16CE : component is "BLACK_BOX";

component CBD16CLE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			CLR : in STD_LOGIC;
			CE : in STD_LOGIC;
			C : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (15 downto 0)
	);
end component;
attribute syn_black_box of CBD16CLE : component is TRUE;
attribute BOX_TYPE of CBD16CLE : component is "BLACK_BOX";

component CBD16CLED
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (15 downto 0)		);
end component;
attribute syn_black_box of CBD16CLED : component is TRUE;
attribute BOX_TYPE of CBD16CLED : component is "BLACK_BOX";

component CBD16RE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
	);
end component;
attribute syn_black_box of CBD16RE : component is TRUE;
attribute BOX_TYPE of CBD16RE : component is "BLACK_BOX";

component CBD16RLE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
attribute syn_black_box of CBD16RLE : component is TRUE;
attribute BOX_TYPE of CBD16RLE : component is "BLACK_BOX";

component CBD16X1
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (15 downto 0)
	);
end component;
attribute syn_black_box of CBD16X1 : component is TRUE;
attribute BOX_TYPE of CBD16X1 : component is "BLACK_BOX";

component CBD16X2
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (15 downto 0)
	);
end component;
attribute syn_black_box of CBD16X2 : component is TRUE;
attribute BOX_TYPE of CBD16X2 : component is "BLACK_BOX";

component CBD2CE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CBD2CE : component is TRUE;
attribute BOX_TYPE of CBD2CE : component is "BLACK_BOX";

component CBD2CLE
	port (
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (1 downto 0);
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(1 downto 0)
	);

end component;
attribute syn_black_box of CBD2CLE : component is TRUE;
attribute BOX_TYPE of CBD2CLE : component is "BLACK_BOX";

component CBD2CLED
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (1 downto 0)
	);

end component;
attribute syn_black_box of CBD2CLED : component is TRUE;
attribute BOX_TYPE of CBD2CLED : component is "BLACK_BOX";

component CBD2RE
	port (
			TC : out STD_LOGIC;
			CEO : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(1 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
	);
end component;
attribute syn_black_box of CBD2RE : component is TRUE;
attribute BOX_TYPE of CBD2RE : component is "BLACK_BOX";

component CBD2RLE
	port (
			C : in STD_LOGIC;
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(1 downto 0);
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(1 downto 0)		);
end component;
attribute syn_black_box of CBD2RLE : component is TRUE;
attribute BOX_TYPE of CBD2RLE : component is "BLACK_BOX";

component CBD2X1
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (1 downto 0)		);
end component;
attribute syn_black_box of CBD2X1 : component is TRUE;
attribute BOX_TYPE of CBD2X1 : component is "BLACK_BOX";

component CBD2X2
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(1 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (1 downto 0)	
	);

end component;
attribute syn_black_box of CBD2X2 : component is TRUE;
attribute BOX_TYPE of CBD2X2 : component is "BLACK_BOX";

component CBD4CE
	port (
			TC : out STD_LOGIC;
			CEO : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(3 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CBD4CE : component is TRUE;
attribute BOX_TYPE of CBD4CE : component is "BLACK_BOX";

component CBD4CLE
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
end component;
attribute syn_black_box of CBD4CLE : component is TRUE;
attribute BOX_TYPE of CBD4CLE : component is "BLACK_BOX";

component CBD4CLED
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(3 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (3 downto 0)
	);	

end component;
attribute syn_black_box of CBD4CLED : component is TRUE;
attribute BOX_TYPE of CBD4CLED : component is "BLACK_BOX";

component CBD4RE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(3 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
	);
end component;
attribute syn_black_box of CBD4RE : component is TRUE;
attribute BOX_TYPE of CBD4RE : component is "BLACK_BOX";

component CBD4RLE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(3 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end component;
attribute syn_black_box of CBD4RLE : component is TRUE;
attribute BOX_TYPE of CBD4RLE : component is "BLACK_BOX";

component CBD4X1
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(3 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (3 downto 0)
	);
end component;
attribute syn_black_box of CBD4X1 : component is TRUE;
attribute BOX_TYPE of CBD4X1 : component is "BLACK_BOX";

component CBD4X2
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(3 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (3 downto 0)	
	);
end component;
attribute syn_black_box of CBD4X2 : component is TRUE;
attribute BOX_TYPE of CBD4X2 : component is "BLACK_BOX";

component CBD8CE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(7 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CBD8CE : component is TRUE;
attribute BOX_TYPE of CBD8CE : component is "BLACK_BOX";

component CBD8CLE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(7 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (7 downto 0)	
	);

end component;
attribute syn_black_box of CBD8CLE : component is TRUE;
attribute BOX_TYPE of CBD8CLE : component is "BLACK_BOX";

component CBD8CLED
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(7 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			UP : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (7 downto 0)	
	);

end component;
attribute syn_black_box of CBD8CLED : component is TRUE;
attribute BOX_TYPE of CBD8CLED : component is "BLACK_BOX";

component CBD8RE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(7 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			R : in STD_LOGIC
		);
end component;
attribute syn_black_box of CBD8RE : component is TRUE;
attribute BOX_TYPE of CBD8RE : component is "BLACK_BOX";

component CBD8RLE
	port (
			CEO : out STD_LOGIC;
			TC : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(7 downto 0);
			C : in STD_LOGIC;
			CE : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of CBD8RLE : component is TRUE;
attribute BOX_TYPE of CBD8RLE : component is "BLACK_BOX";

component CBD8X1
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(7 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			CLR : in STD_LOGIC;
			L : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (7 downto 0)	
	);
end component;
attribute syn_black_box of CBD8X1 : component is TRUE;
attribute BOX_TYPE of CBD8X1 : component is "BLACK_BOX";

component CBD8X2
	port (
			CEOD : out STD_LOGIC;
			CEOU : out STD_LOGIC;
			TCD : out STD_LOGIC;
			TCU : out STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(7 downto 0);
			C : in STD_LOGIC;
			CED : in STD_LOGIC;
			CEU : in STD_LOGIC;
			L : in STD_LOGIC;
			R : in STD_LOGIC;
			D : in STD_LOGIC_VECTOR (7 downto 0)	
	);
end component;
attribute syn_black_box of CBD8X2 : component is TRUE;
attribute BOX_TYPE of CBD8X2 : component is "BLACK_BOX";

component CDD4CE
    port ( 
	   CEO : out STD_LOGIC;
           TC : out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(3 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CDD4CE : component is TRUE;
attribute BOX_TYPE of CDD4CE : component is "BLACK_BOX";

component CDD4CLE
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
end component;
attribute syn_black_box of CDD4CLE : component is TRUE;
attribute BOX_TYPE of CDD4CLE : component is "BLACK_BOX";

component CDD4RE
    port ( 
	   CEO : out STD_LOGIC;
           TC : out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(3 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC
	);
end component;
attribute syn_black_box of CDD4RE : component is TRUE;
attribute BOX_TYPE of CDD4RE : component is "BLACK_BOX";

component CDD4RLE
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
end component;
attribute syn_black_box of CDD4RLE : component is TRUE;
attribute BOX_TYPE of CDD4RLE : component is "BLACK_BOX";

component CJD4CE
	 port ( 
	   Q : out STD_LOGIC_VECTOR(3 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CJD4CE : component is TRUE;
attribute BOX_TYPE of CJD4CE : component is "BLACK_BOX";

component CJD4RE
         port ( 
	   Q : out STD_LOGIC_VECTOR(3 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC
	);
end component;
attribute syn_black_box of CJD4RE : component is TRUE;
attribute BOX_TYPE of CJD4RE : component is "BLACK_BOX";

component CJD5CE
         port ( 
	   Q : out STD_LOGIC_VECTOR(4 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CJD5CE : component is TRUE;
attribute BOX_TYPE of CJD5CE : component is "BLACK_BOX";

component CJD5RE
         port (
	   Q : out STD_LOGIC_VECTOR(4 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC
	);
end component;
attribute syn_black_box of CJD5RE : component is TRUE;
attribute BOX_TYPE of CJD5RE : component is "BLACK_BOX";

component CJD8CE
         port ( 
	   Q : out STD_LOGIC_VECTOR(7 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLR : in STD_LOGIC
	);
end component;
attribute syn_black_box of CJD8CE : component is TRUE;
attribute BOX_TYPE of CJD8CE : component is "BLACK_BOX";

component CJD8RE
    port ( Q : out STD_LOGIC_VECTOR(7 downto 0);
           C : in STD_LOGIC;
           CE : in STD_LOGIC;
           R : in STD_LOGIC
	);

end component;
attribute syn_black_box of CJD8RE : component is TRUE;
attribute BOX_TYPE of CJD8RE : component is "BLACK_BOX";

component FDD
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDD : component is TRUE;
attribute BOX_TYPE of FDD : component is "BLACK_BOX";

component FDD16
  port ( 
	Q : out STD_LOGIC_VECTOR(15 downto 0);
	C: in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
attribute syn_black_box of FDD16 : component is TRUE;
attribute BOX_TYPE of FDD16 : component is "BLACK_BOX";

component FDD16CE
  port ( 
	Q : out STD_LOGIC_VECTOR(15 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
attribute syn_black_box of FDD16CE : component is TRUE;
attribute BOX_TYPE of FDD16CE : component is "BLACK_BOX";

component FDD16RE
  port (
	Q : out STD_LOGIC_VECTOR(15 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(15 downto 0);
	R : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDD16RE : component is TRUE;
attribute BOX_TYPE of FDD16RE : component is "BLACK_BOX";

component FDD4
  port ( 
	Q : out STD_LOGIC_VECTOR(3 downto 0);
	C: in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end component;
attribute syn_black_box of FDD4 : component is TRUE;
attribute BOX_TYPE of FDD4 : component is "BLACK_BOX";

component FDD4CE
  port ( 
	Q : out STD_LOGIC_VECTOR(3 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end component;
attribute syn_black_box of FDD4CE : component is TRUE;
attribute BOX_TYPE of FDD4CE : component is "BLACK_BOX";

component FDD4RE
  port ( 
	Q : out STD_LOGIC_VECTOR(3 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(3 downto 0);
	R : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDD4RE : component is TRUE;
attribute BOX_TYPE of FDD4RE : component is "BLACK_BOX";

component FDD8
  port ( 
	Q : out STD_LOGIC_VECTOR(7 downto 0);
	C: in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of FDD8 : component is TRUE;
attribute BOX_TYPE of FDD8 : component is "BLACK_BOX";

component FDD8CE
  port ( 
	Q : out STD_LOGIC_VECTOR(7 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of FDD8CE : component is TRUE;
attribute BOX_TYPE of FDD8CE : component is "BLACK_BOX";

component FDD8RE
  port ( 
	Q : out STD_LOGIC_VECTOR(7 downto 0);
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	R : in STD_LOGIC;
	D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of FDD8RE : component is TRUE;
attribute BOX_TYPE of FDD8RE : component is "BLACK_BOX";

component FDDC
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDC : component is TRUE;
attribute BOX_TYPE of FDDC : component is "BLACK_BOX";

component FDDCE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDCE : component is TRUE;
attribute BOX_TYPE of FDDCE : component is "BLACK_BOX";

component FDDCP
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDCP : component is TRUE;
attribute BOX_TYPE of FDDCP : component is "BLACK_BOX";

component FDDCPE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDCPE : component is TRUE;
attribute BOX_TYPE of FDDCPE : component is "BLACK_BOX";

component FDDP
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDP : component is TRUE;
attribute BOX_TYPE of FDDP : component is "BLACK_BOX";

component FDDPE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	PRE : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDPE : component is TRUE;
attribute BOX_TYPE of FDDPE : component is "BLACK_BOX";

component FDDR
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDR : component is TRUE;
attribute BOX_TYPE of FDDR : component is "BLACK_BOX";

component FDDRE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDRE : component is TRUE;
attribute BOX_TYPE of FDDRE : component is "BLACK_BOX";

component FDDRS
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDRS : component is TRUE;
attribute BOX_TYPE of FDDRS : component is "BLACK_BOX";

component FDDRSE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDRSE : component is TRUE;
attribute BOX_TYPE of FDDRSE : component is "BLACK_BOX";

component FDDSE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	S : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDSE : component is TRUE;
attribute BOX_TYPE of FDDSE : component is "BLACK_BOX";

component FDDSR
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDSR : component is TRUE;
attribute BOX_TYPE of FDDSR : component is "BLACK_BOX";

component FDDSRE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	D : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC
	);
end component;
attribute syn_black_box of FDDSRE : component is TRUE;
attribute BOX_TYPE of FDDSRE : component is "BLACK_BOX";

component FTDCE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	T : in STD_LOGIC
	);
end component;
attribute syn_black_box of FTDCE : component is TRUE;
attribute BOX_TYPE of FTDCE : component is "BLACK_BOX";

component FTDCLE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	L : in STD_LOGIC;
	T : in STD_LOGIC
	);
end component;
attribute syn_black_box of FTDCLE : component is TRUE;
attribute BOX_TYPE of FTDCLE : component is "BLACK_BOX";

component FTDCLEX
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	D : in STD_LOGIC;
	L : in STD_LOGIC;
	T : in STD_LOGIC
	);
end component;
attribute syn_black_box of FTDCLEX : component is TRUE;
attribute BOX_TYPE of FTDCLEX : component is "BLACK_BOX";

component FTDCP
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CLR : in STD_LOGIC;
	PRE : in STD_LOGIC;
	T : in STD_LOGIC
	);
end component;
attribute syn_black_box of FTDCP : component is TRUE;
attribute BOX_TYPE of FTDCP : component is "BLACK_BOX";

component FTDCPE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	CLR : in STD_LOGIC;
	PRE : in STD_LOGIC;
	T : in STD_LOGIC
	);
end component;
attribute syn_black_box of FTDCPE : component is TRUE;
attribute BOX_TYPE of FTDCPE : component is "BLACK_BOX";

component FTDRSE
  port ( 
	Q : out STD_LOGIC;
	C: in STD_LOGIC;
	CE : in STD_LOGIC;
	R : in STD_LOGIC;
	S : in STD_LOGIC;
	T : in STD_LOGIC
	);
end component;
attribute syn_black_box of FTDRSE : component is TRUE;
attribute BOX_TYPE of FTDRSE : component is "BLACK_BOX";

component FTDRSLE
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
end component;
attribute syn_black_box of FTDRSLE : component is TRUE;
attribute BOX_TYPE of FTDRSLE : component is "BLACK_BOX";

component SRD16CE
	port (
		Q : out STD_LOGIC_VECTOR(15 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end component;
attribute syn_black_box of SRD16CE : component is TRUE;
attribute BOX_TYPE of SRD16CE : component is "BLACK_BOX";

component SRD16CLE
	port (
		Q : out STD_LOGIC_VECTOR(15 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
attribute syn_black_box of SRD16CLE : component is TRUE;
attribute BOX_TYPE of SRD16CLE : component is "BLACK_BOX";

component SRD16CLED
	port (
		Q : out STD_LOGIC_VECTOR(15 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
attribute syn_black_box of SRD16CLED : component is TRUE;
attribute BOX_TYPE of SRD16CLED : component is "BLACK_BOX";

component SRD16RE
	port (
		Q : out STD_LOGIC_VECTOR(15 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end component;
attribute syn_black_box of SRD16RE : component is TRUE;
attribute BOX_TYPE of SRD16RE : component is "BLACK_BOX";

component SRD16RLE
	port (
		Q : out STD_LOGIC_VECTOR(15 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
attribute syn_black_box of SRD16RLE : component is TRUE;
attribute BOX_TYPE of SRD16RLE : component is "BLACK_BOX";

component SRD16RLED
	port (
		Q : out STD_LOGIC_VECTOR(15 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
attribute syn_black_box of SRD16RLED : component is TRUE;
attribute BOX_TYPE of SRD16RLED : component is "BLACK_BOX";

component SRD4CE
	port (
		Q : out STD_LOGIC_VECTOR(3 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end component;
attribute syn_black_box of SRD4CE : component is TRUE;
attribute BOX_TYPE of SRD4CE : component is "BLACK_BOX";

component SRD4CLE
	port (
		Q : out STD_LOGIC_VECTOR(3 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end component;
attribute syn_black_box of SRD4CLE : component is TRUE;
attribute BOX_TYPE of SRD4CLE : component is "BLACK_BOX";

component SRD4CLED
	port (
		Q : out STD_LOGIC_VECTOR(3 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end component;
attribute syn_black_box of SRD4CLED : component is TRUE;
attribute BOX_TYPE of SRD4CLED : component is "BLACK_BOX";

component SRD4RE
	port (
		Q : out STD_LOGIC_VECTOR(3 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end component;
attribute syn_black_box of SRD4RE : component is TRUE;
attribute BOX_TYPE of SRD4RE : component is "BLACK_BOX";

component SRD4RLE
	port (
		Q : out STD_LOGIC_VECTOR(3 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end component;
attribute syn_black_box of SRD4RLE : component is TRUE;
attribute BOX_TYPE of SRD4RLE : component is "BLACK_BOX";

component SRD4RLED
	port (
		Q : out STD_LOGIC_VECTOR(3 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downto 0)
	);
end component;
attribute syn_black_box of SRD4RLED : component is TRUE;
attribute BOX_TYPE of SRD4RLED : component is "BLACK_BOX";

component SRD8CE
	port (
		Q : out STD_LOGIC_VECTOR(7 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end component;
attribute syn_black_box of SRD8CE : component is TRUE;
attribute BOX_TYPE of SRD8CE : component is "BLACK_BOX";

component SRD8CLE
	port (
		Q : out STD_LOGIC_VECTOR(7 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of SRD8CLE : component is TRUE;
attribute BOX_TYPE of SRD8CLE : component is "BLACK_BOX";

component SRD8CLED
	port (
		Q : out STD_LOGIC_VECTOR(7 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of SRD8CLED : component is TRUE;
attribute BOX_TYPE of SRD8CLED : component is "BLACK_BOX";

component SRD8RE
	port (
		Q : out STD_LOGIC_VECTOR(7 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC
	);
end component;
attribute syn_black_box of SRD8RE : component is TRUE;
attribute BOX_TYPE of SRD8RE : component is "BLACK_BOX";

component SRD8RLE
	port (
		Q : out STD_LOGIC_VECTOR(7 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of SRD8RLE : component is TRUE;
attribute BOX_TYPE of SRD8RLE : component is "BLACK_BOX";

component SRD8RLED
	port (
		Q : out STD_LOGIC_VECTOR(7 downto 0);
		C : in STD_LOGIC;
		CE : in STD_LOGIC;
		L : in STD_LOGIC;
		LEFT : in STD_LOGIC;
		R : in STD_LOGIC;
		SLI : in STD_LOGIC;
		SRI : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(7 downto 0)
	);
end component;
attribute syn_black_box of SRD8RLED : component is TRUE;
attribute BOX_TYPE of SRD8RLED : component is "BLACK_BOX";


end CPLD_DET_COMPONENTS;
